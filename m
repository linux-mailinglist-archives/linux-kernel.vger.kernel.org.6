Return-Path: <linux-kernel+bounces-528942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E67A5A41E43
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 291B316E1E3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 11:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3BDF25C6ED;
	Mon, 24 Feb 2025 11:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="L8wADk9l"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1B925A2DA
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 11:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740397747; cv=none; b=KYhCNxpBXyPjdDTSYWoNW1C19DSNQxMwjswJgOZtmjhlND26Vsy7iAZuQKyOKI1wPlDpXPr2xm7N2L4GF2Q77+9BOkMIi11F2MQr6uHgYrLAk8mpQj1YC7dIrniIf3vFwumuoQF1A/MYXzNvWTR3N8SAnE9o8pVugzV+bNi0H7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740397747; c=relaxed/simple;
	bh=1Q202DvK61JKZzqWiEuqqM9Aj/wcpXNTi9KyK4b+sQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A5UqOIGj6VkQ4VhvNwtsyR+kt5THmTjGa7sSvAS0QQ+ZPNb05ppDJT4VVkV8AtTVHdEbvlhbe8IgvAbVYuEza/DESqpcmDuOHXNBmO94848Bx0sMhdy4KAxSymTrLdwQsG4/lEwyPsFz8ZYXCjPndmEvLs4Vj1bIpcVCePM61nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=L8wADk9l; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id BFE3840E01AD;
	Mon, 24 Feb 2025 11:49:00 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id qGMdkjvsM5ND; Mon, 24 Feb 2025 11:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1740397736; bh=Lw7qFiL9WCVd3Ob44UNeBij2JGHI/k8Oer5A13xUMeU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L8wADk9lz2UK58eAFQVDTnTpgJ3HqXzqTuCKnqSumH6ESAOmE9fLyexrBH/8KxuVZ
	 632RZl0Kfw3wK+DJK/jFqE2YxcnzYKjQE0k1vuV41QXYeidxfSSk1LaFLWtEJjeumn
	 Lk5O4xPw5S3FCV2ZFhyFZ+vs45kGbDI3EOXuoaeklxVcCar09IIt1ETyts8sSX2+Qs
	 BNXmv7Gdoon4FdlMg97RoWb9cgGzIRyds3DKp+UfIXHzXZsmw6+dfFS3rj8fp5N8po
	 NGcf2VGm3c9h0ya96SyvI/cZ5EqXoX3uhQnfKcqptF1EdPq0u+FCZ4G3UehIu5ng5Q
	 +F0zykUWtwz7oPTlm0MuXVz2rAtNEG9GphK+1/yx0r8LisPVxBgFaaMYMGsnwmUNpe
	 y7FyDiDeRU2UQ3/e6AG7QOksUefgR40BViQVO0pxeT8R/1w/GDqPCsaGT3lO9Y3DVe
	 hc0HlG4kxCw0MpwaD7+zMUmATPmg/Bo1tJ4R2g7195RCUZMyifyq8gi2fFSvf7bNyl
	 rLaBYtM+wxXknbJOXoJG4pG/nzCSzG4sH/rCQIj8NSIbGZA1krAIFNGTUFZ7xpHr8q
	 GqAR0KypHsgekufMu6h6q4/QqthJwGGBtGlAHq0mgA35+GcZBUn6ntqeDzDvaPmbwe
	 fRNTiRlbRKi+3QdkV15ZPneI=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B8C4B40E01AE;
	Mon, 24 Feb 2025 11:48:37 +0000 (UTC)
Date: Mon, 24 Feb 2025 12:48:31 +0100
From: Borislav Petkov <bp@alien8.de>
To: Rik van Riel <riel@surriel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, peterz@infradead.org,
	dave.hansen@linux.intel.com, zhengqi.arch@bytedance.com,
	nadav.amit@gmail.com, thomas.lendacky@amd.com, kernel-team@meta.com,
	linux-mm@kvack.org, akpm@linux-foundation.org, jackmanb@google.com,
	jannh@google.com, mhklinux@outlook.com, andrew.cooper3@citrix.com,
	Manali.Shukla@amd.com, mingo@kernel.org,
	Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v13 01/14] x86/mm: consolidate full flush threshold
 decision
Message-ID: <20250224114831.GBZ7xcj2IGlq_Kuo_a@fat_crate.local>
References: <20250223194943.3518952-1-riel@surriel.com>
 <20250223194943.3518952-2-riel@surriel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250223194943.3518952-2-riel@surriel.com>

On Sun, Feb 23, 2025 at 02:48:51PM -0500, Rik van Riel wrote:
> Reduce code duplication by consolidating the decision point
> for whether to do individual invalidations or a full flush
> inside get_flush_tlb_info.
> 
> Signed-off-by: Rik van Riel <riel@surriel.com>
> Suggested-by: Dave Hansen <dave.hansen@intel.com>
> Tested-by: Michael Kelley <mhklinux@outlook.com>
> Acked-by: Dave Hansen <dave.hansen@intel.com>
> ---
>  arch/x86/mm/tlb.c | 41 +++++++++++++++++++----------------------
>  1 file changed, 19 insertions(+), 22 deletions(-)

Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

