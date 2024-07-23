Return-Path: <linux-kernel+bounces-260159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF8DC93A3F6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 17:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C9E61C21E65
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 15:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD45157A47;
	Tue, 23 Jul 2024 15:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QvvySTao"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEAB15748C
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 15:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721749625; cv=none; b=h45hQUnpqW+PQtuX+q1YoTT/TeT93q1y68D44HFj9aeZzYS2UEgZI/U/QWErra2tcJ46ZhGGzy6a3YzBVbpMvKufFsS1WPmefCiF5OV0Vr1KdpIaG05m5ZrINaLry7dX0KV7QBk13RlmQnYGfOkwtWNfQ7ueFR8smfr1QCdhF+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721749625; c=relaxed/simple;
	bh=87y0ZcSvXb9SA3kA4iK2xLw1zsrpzH8vfx3v3HTdx4o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sDDq14lfTAVnMtUH6CyIafDU90e/wxzbNvFxLKDMdbHDa75JdGwUTl8OZZD7RAOiHlm+t5Qj/M8NUe5yYw7/1EQUZzM4aQh4zontILZObkkZMv9q5AC1W/aZDOPGeDWOYpQ4pp+FhO6xhGha2r9ncG3dGExVjrM+RcrrrS6Lbvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QvvySTao; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ADC4C4AF0E;
	Tue, 23 Jul 2024 15:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721749625;
	bh=87y0ZcSvXb9SA3kA4iK2xLw1zsrpzH8vfx3v3HTdx4o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QvvySTaoEJOqI+DH30uX9v1KrOglpb4jsxgTSnD5Xg6Twd8hl0uiSZdGsIAXBJT8U
	 RIiQ+9HsAe6E8/FqcIv6Loyt9tR4NYLCvoCprJcal159dgCEYThUntPLSQNfd8ep1E
	 LR5PA3t5vziax0vc1hraWoXuRF3PBOasxMjt+GwDeEMHND4XpY+4oXiZVaX6X9k68q
	 ++KvLRmkZu0VCWldxicHz+a/DuTLFPXR3OdqAmF+5vAy7nYiiPFy0L4Z3+MjPWCDhy
	 mEvt4O8dMYtSZblKTIj7X5lkLH913BGtM/vjqec8RhWw6E2PZeQjNfTu8Ap05r6Ydm
	 3tVBt4aqCSNhg==
From: Will Deacon <will@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	Masahiro Yamada <masahiroy@kernel.org>
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2] arm64: remove redundant 'if HAVE_ARCH_KASAN' in Kconfig
Date: Tue, 23 Jul 2024 16:46:53 +0100
Message-Id: <172174460679.278807.14772169296423125721.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240715192843.2201439-1-masahiroy@kernel.org>
References: <20240715192843.2201439-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 16 Jul 2024 04:28:17 +0900, Masahiro Yamada wrote:
> Since commit 0383808e4d99 ("arm64: kasan: Reduce minimum shadow
> alignment and enable 5 level paging"), HAVE_ARCH_KASAN is always 'y'.
> 
> The condition 'if HAVE_ARCH_KASAN' is always met.
> 
> 

Applied to arm64 (for-next/core), thanks!

[1/1] arm64: remove redundant 'if HAVE_ARCH_KASAN' in Kconfig
      https://git.kernel.org/arm64/c/62e2397c2203

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

