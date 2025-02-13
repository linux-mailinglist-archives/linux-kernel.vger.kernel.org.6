Return-Path: <linux-kernel+bounces-513059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 506CCA34133
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 15:03:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2FC31890A5B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 14:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6EF12222D2;
	Thu, 13 Feb 2025 13:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TKDpKnpQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3862222CA
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 13:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739455150; cv=none; b=T/QfB+rGKu+Chib1siEcwRyCjOtFI6oIR02W6CyAxCI2h9TY5KE3C5saMRGw3pLDKH4BoL5ONHrdxtwCQsEkNx7n14O9o1eBgp3qIVVQucdVl+uCmPbt9HRwKQZAuQKsDf3LeqaYm6QfDDLba8Ipz+cAQdf09eL90k9iGOG9w5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739455150; c=relaxed/simple;
	bh=86lSLlfSnH3gLlHMarEFFkwpZl7BtgL5BOo2fiEcAXg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BdhJnX9NeNWyG7WNmj67R29i9NdKo2A+PkFB8mTSzq1wYsu2Jmr9eovSXEUcfOooq6uPfpiJoQ6HZXelndXa3sE63mRf6kqsRe7NLkWAg/TCuGPTA2BictMqoFfpiwZz45SwuYS0oBGUNtExoNPnLdqQwoyMPilil2oWW1k5RNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TKDpKnpQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3DDBC4CED1;
	Thu, 13 Feb 2025 13:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739455149;
	bh=86lSLlfSnH3gLlHMarEFFkwpZl7BtgL5BOo2fiEcAXg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TKDpKnpQZZLPLJkxSAp4NQrHabwTbI+1k6690/Wd6bz1VqhXT3WrSaJBXDJXe7n3V
	 FAUMe0lEskBGSiui5Jd3oo3DNpCoZ3SzpqtjT8sNEYeLFc/XoMGz9vcOWDatH00MUF
	 HQBIdOl2MyiU1/KXWpnCRdKFYXI0nqUfDnC9o9FR0mgOXL5loe+bISDAPfYsm2aeu0
	 bdITb5rssub6wlOgZEM1Gcw6dhOb8KGXmUh8i9dEXTkpamTvbwbH7qky0fGGzRg/vj
	 Gw9P/KhohA6y5uvdJUXmmdzWSbCmgzvTNVPOm3TZNCHsaOg+5vvBaeVajR3YPePneS
	 r6IHchmUPbuZw==
From: Will Deacon <will@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	ionela.voinescu@arm.com,
	sudeep.holla@arm.com,
	catalin.marinas@arm.com,
	Beata Michalska <beata.michalska@arm.com>
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	sumitg@nvidia.com,
	ptsm@linux.microsoft.com
Subject: Re: [PATCH] arm64: amu: Delay allocating cpumask for AMU FIE support
Date: Thu, 13 Feb 2025 13:59:01 +0000
Message-Id: <173944478263.2605897.5555784632946781698.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250131155842.3839098-1-beata.michalska@arm.com>
References: <20250131155842.3839098-1-beata.michalska@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 31 Jan 2025 15:58:42 +0000, Beata Michalska wrote:
> For the time being, the amu_fie_cpus cpumask is being exclusively used
> by the AMU-related internals of FIE support and is guaranteed to be
> valid on every access currently made. Still the mask is not being
> invalidated on one of the error handling code paths, which leaves
> a soft spot with theoretical risk of UAF for CPUMASK_OFFSTACK cases.
> To make things sound, delay allocating said cpumask
> (for CPUMASK_OFFSTACK) avoiding otherwise nasty sanitising case failing
> to register the cpufreq policy notifications.
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64: amu: Delay allocating cpumask for AMU FIE support
      https://git.kernel.org/arm64/c/d923782b0412

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

