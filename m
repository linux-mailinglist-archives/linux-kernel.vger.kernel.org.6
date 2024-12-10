Return-Path: <linux-kernel+bounces-440138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A3B9EB964
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 19:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46E75188544F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 18:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4165D1A00F8;
	Tue, 10 Dec 2024 18:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R2igFiKo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC0D8634A
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 18:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733855694; cv=none; b=Z8aQLjx4dRunzslIsuTy+eI4KqYj2thC1TP4iPXaI/kbuHic2nwLm7yV8dNYAWAYsznHlI+f4X5nEtqWeiRovdUTs13BVMb2UqRrz14icnc2AwIHp17rAUkFdRHCDBedgNq/vvtQo6p4daiuHclx4y+Jl0njLzoKbr9d2Hvry6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733855694; c=relaxed/simple;
	bh=W2EytOZUNFBcFr6wPRLGScngdEtL5uKBSlZGtpDx5MA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kN5HQrCU60D1gRW8zbtVIDb9mbrI2UXf2Vu2AyComNSNWfk/fcROjatKk7u7lTqgYlrvzPsHhYe/PwkH1TOZerUMlVZiyfgMroaqoa/8A/LZ7WYoxgqs/KDMiX1sM2W1KAFWEAtB//Nqpe6J0R+Feqq3znBS48B+Ch2UqreodQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R2igFiKo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 686A5C4CED6;
	Tue, 10 Dec 2024 18:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733855694;
	bh=W2EytOZUNFBcFr6wPRLGScngdEtL5uKBSlZGtpDx5MA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R2igFiKoEFGJjO2IU6T9ZuXETz0TThtI7QA/V2lIGqO9KhIbxxOGSqDI4Y/TwzVHA
	 jlLxjG6XvVvIGKZD11slF3jBW+DflsOTWB3muaZ6eibJq5vNoWIVR+BQ4fgJV3JZCu
	 mc5N9synyh23XVcwFjsuftLiYLbtm9E8MgYn8Sh1mCTb3JJv229Por5vPi4d9mxpdG
	 0d+BbBXSo6XneeS7379XVhNmNRPl3Jte25FnRKFNxqzUPsROE7NbjvFIZBVDgfCtrt
	 kN0ZWhbGhZpnq0GS2+Lxt/cPLe1yPAKoL3x/NVvfHkwFflHpgmSKp19ZRgt0p8/buG
	 O/7Rmj18w3iDg==
From: Will Deacon <will@kernel.org>
To: linux-arm-kernel@lists.infradead.org,
	Anshuman Khandual <anshuman.khandual@arm.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/mm: Drop INIT_MM_CONTEXT()
Date: Tue, 10 Dec 2024 18:34:42 +0000
Message-Id: <173383034723.3807515.1598046188677105190.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241202043553.29592-1-anshuman.khandual@arm.com>
References: <20241202043553.29592-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 02 Dec 2024 10:05:53 +0530, Anshuman Khandual wrote:
> Platform override for INIT_MM_CONTEXT() is redundant because swapper_pg_dir
> always gets assigned as the pgd during init_mm initialization. So just drop
> this override on arm64.
> 
> Originally this override was added via the 'commit 2b5548b68199 ("arm64/mm:
> Separate boot-time page tables from swapper_pg_dir")' because non standard
> init_pg_dir was assigned as the pgd. Subsequently it was changed as default
> swapper_pg_dir by the 'commit ba5b0333a847 ("arm64: mm: omit redundant
> remap of kernel image")', which might have also just dropped this override.
> 
> [...]

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64/mm: Drop INIT_MM_CONTEXT()
      https://git.kernel.org/arm64/c/5f882f4aa8aa

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

