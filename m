Return-Path: <linux-kernel+bounces-532709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57354A45140
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 01:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74CF33AF7A8
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 00:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C2D4A1C;
	Wed, 26 Feb 2025 00:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G9Nd/W3c"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA45828EB
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 00:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740528655; cv=none; b=mTB34UxN1Om8p/kjezPPSegZouq/mJTFA0aArm0HDIwDJcmL5J6Z1coNFBIrB8bYZWHNsC7HxG4cuAm7RKzM19mXvWMiJQeakGgZye8FdBfHbo//vIAriA+iSuB4LWRljJbKFVjTrfCSs2Ctb2TA05sA4qnVLxLOfD4gPXqY9CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740528655; c=relaxed/simple;
	bh=49SUBzThyd9e7y0nhqcoDUOOKWxbYBsP2XBvQGwPRys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hA8Ia+zkdRO5wmz3Rh3BMFGHqfttV6JelfSlUqa6zyehFl44uHMDTbcygjjFEZ6KXYVADFdSzE1XGlSWVucNkkvB5P2yO5Maxzss2Mvy9Zvo+9cCgkmWrUKnWBunHr47CmYKtykZmd5KwLKMG2jW6NycXhdcccPC45GuRuxfETM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G9Nd/W3c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A1FEC4CEDD;
	Wed, 26 Feb 2025 00:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740528655;
	bh=49SUBzThyd9e7y0nhqcoDUOOKWxbYBsP2XBvQGwPRys=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G9Nd/W3cOBogxdlzH5W7R2i885MstlkyBA6wyh8ewYrp7QZVdEnI3tmffn9vUY59q
	 NR1ul224yG9Qa2M25MgW46NuxFaLMU+LjAZH8LSzPRxfv+8ojJpHFJJqREpp2sKSbk
	 IkpDI/KU+mtJ5EIH20eJC26M/fvom4a4vI5d4HFjvj2w4l2M2CjAHXqSEO4GuVm47T
	 7JNtkY7CAlJkcGlcAqtr3Zu1J6Wdh4IsJUz/qak5ZagZ0UswA/G+oxihiYI7lp4wnn
	 e8GK6DWfNj3Ohf13DMLC8Dq1+YsjHim8p+Q614mfk8nuC6ynY7Jl3af9pBhtSRcUxK
	 0RRVej2Cefs3g==
Date: Wed, 26 Feb 2025 00:10:50 +0000
From: Will Deacon <will@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Luiz Capitulino <luizcap@redhat.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] arm64/mm: Fix Boot panic on Ampere Altra
Message-ID: <20250226001047.GA24197@willie-the-truck>
References: <20250225114638.2038006-1-ryan.roberts@arm.com>
 <CAMj1kXHNO+iB4vNFz-4tR_9CPzv96hn+RW=eqyZXMGy_AySDpw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHNO+iB4vNFz-4tR_9CPzv96hn+RW=eqyZXMGy_AySDpw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Feb 25, 2025 at 07:05:35PM +0100, Ard Biesheuvel wrote:
> Apologies for the breakage, and thanks for the fix.
> 
> I have to admit that I was a bit overzealous here: there is no point
> yet in using the sanitised value, given that we don't actually
> override the PA range in the first place. This is something I've
> prototyped for Android use, so that linear map randomization can be
> force enabled on CPUs with a wide PArange, but right now, mainline
> does not have that capability, and so I'd be inclined to just revert
> the hunk that introduces the call to read_sanitised_ftr_reg() into
> arm64_memblock_init(), especially given the fact that commit
> 62cffa496aac was tagged for stable, and was already pulled into 6.13
> and 6.12
> 
> In any case, it would be good if we could get a fix into Linus's tree asap

Makes sense. So the patch below?

Will

--->8

From b76ddd40dd6fe350727a4b2ec50709fd919d8408 Mon Sep 17 00:00:00 2001
From: Ryan Roberts <ryan.roberts@arm.com>
Date: Tue, 25 Feb 2025 11:46:36 +0000
Subject: [PATCH] arm64/mm: Fix Boot panic on Ampere Altra

When the range of present physical memory is sufficiently small enough
and the reserved address space for the linear map is sufficiently large
enough, The linear map base address is randomized in
arm64_memblock_init().

Prior to commit 62cffa496aac ("arm64/mm: Override PARange for !LPA2 and
use it consistently"), we decided if the sizes were suitable with the
help of the raw mmfr0.parange. But the commit changed this to use the
sanitized version instead. But the function runs before the register has
been sanitized so this returns 0, interpreted as a parange of 32 bits.
Some fun wrapping occurs and the logic concludes that there is enough
room to randomize the linear map base address, when really there isn't.
So the top of the linear map ends up outside the reserved address space.

Since the PA range cannot be overridden in the first place, restore the
mmfr0 reading logic to its state prior to 62cffa496aac, where the raw
register value is used.

Reported-by: Luiz Capitulino <luizcap@redhat.com>
Suggested-by: Ard Biesheuvel <ardb@kernel.org>
Closes: https://lore.kernel.org/all/a3d9acbe-07c2-43b6-9ba9-a7585f770e83@redhat.com/
Fixes: 62cffa496aac ("arm64/mm: Override PARange for !LPA2 and use it consistently")
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
Link: https://lore.kernel.org/r/20250225114638.2038006-1-ryan.roberts@arm.com
Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/mm/init.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 9c0b8d9558fc..ccdef53872a0 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -279,12 +279,7 @@ void __init arm64_memblock_init(void)
 
 	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE)) {
 		extern u16 memstart_offset_seed;
-
-		/*
-		 * Use the sanitised version of id_aa64mmfr0_el1 so that linear
-		 * map randomization can be enabled by shrinking the IPA space.
-		 */
-		u64 mmfr0 = read_sanitised_ftr_reg(SYS_ID_AA64MMFR0_EL1);
+		u64 mmfr0 = read_cpuid(ID_AA64MMFR0_EL1);
 		int parange = cpuid_feature_extract_unsigned_field(
 					mmfr0, ID_AA64MMFR0_EL1_PARANGE_SHIFT);
 		s64 range = linear_region_size -
-- 
2.48.1.658.g4767266eb4-goog


