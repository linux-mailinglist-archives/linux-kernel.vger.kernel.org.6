Return-Path: <linux-kernel+bounces-402058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFBF99C22DD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 18:24:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC29D283772
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 17:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1251EBA1A;
	Fri,  8 Nov 2024 17:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="gGt0/ET1"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C09E199FBF
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 17:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731086664; cv=none; b=Xzj0oPDC3IULaGYwNgIQu7rUrkfVWioN/b9ZyeGADjq7MDzSje1tJAMgrd+i9SYNsKWRxL7SG6+ftWmscB0fZDFxljhPXX0Q9jgfcz21fXT8QQZzMkkW0gp5x+GFXUlw7bS4iwu90wllaCsW3Zyv2d99pIwGnCbRguDJWTtU4K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731086664; c=relaxed/simple;
	bh=sl2TcjsQxs8m+9wj8kQh0RUR2PlBSPCbsuS6yKcA10w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N/g3286m5gZBod8Ok9m/IX8wIbdreXYqO2x/NC7brfFnS6redwzUPGpKm2j/8H7koVvVd3qPzv3RoouWZqRmBOkGQS5ad4aGjXcdd9MBgSCXHM8ISycaAbxq399My+WtW7u2uG69mXhYeCDD1dNRS0TOOpjAgRbpEdbmPrcaG8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=gGt0/ET1; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 522AF40E0263;
	Fri,  8 Nov 2024 17:24:13 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 7WApZexhZmiY; Fri,  8 Nov 2024 17:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1731086648; bh=soe5Qt4taCYOywrlKGxsxcXWTZ/PIHalSvwsSCb+vHU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gGt0/ET10y3epu/BkO7vkOc14upe6zPBVkPeFdCD1OhVabVTGMnWzOvZcrs/cr9nW
	 xYRJU0xih/5hyHNF4NXgIjobQF6AbHvCYAV+XH8DPIkBEBm6RSixXMrZ1+FUkuXoiP
	 eXMsj5y66MbwHzwuiG/3cQfr6GYuDE9ht4zaSElm2o1Pwk3V6Qhr6LCSrqzuuwTNjg
	 PT4ktZQjfGzGVKzq4q7+aKV+uXpXop6AosBTINEYT4YdhP7I2Ksie65qATUFkeCSmb
	 Dhr1tCiFjl0QxoQJsfwYeaeWIbw4FNIESPkn5whaSPYg/BHL/B2JpT0Prw/GgpFmNW
	 Hd3jIVSaqoUhmpmsO5LeieEGh+zUexvr3QcPGQoXfsQyNhJ9xCO+hZTtMH2ufTJMib
	 GkwUUQ8fFvoXOx3RHy9mTTcecHv9sTCq1wRMbn472JDbdLhmla61CUzxzEStbW7Ghn
	 rbIk4l3qgV+mGWFTQ0neaPOj1y6nVxFqRLTwRM/CDmTdVtygoxJCw+5C0pIduyOTU6
	 duFc/BQNOjNjkKfZKHBNeYRatSEwXYj/SbZbrFVjIeqJ9uvwVDHrVBSF3LXfsHR3S0
	 pJ5+Yt7yHtfIgd2mo2fKUzAxbqw0/j9Xto3ZreSsudB8Stv/YYrlWMpt6DXvezPeDh
	 OVtS/A+gXnj8UCJB4V4JzHfs=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F319940E0219;
	Fri,  8 Nov 2024 17:23:57 +0000 (UTC)
Date: Fri, 8 Nov 2024 18:23:46 +0100
From: Borislav Petkov <bp@alien8.de>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Michael Roth <michael.roth@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Subject: Re: [PATCH v5 6/8] x86/sev: Treat the contiguous RMP table as a
 single RMP segment
Message-ID: <20241108172346.GBZy5JIv9qbbOZbo2k@fat_crate.local>
References: <cover.1730143962.git.thomas.lendacky@amd.com>
 <6118c46de2b2260b72dd3ed4421e5e08713fd47a.1730143962.git.thomas.lendacky@amd.com>
 <20241104103353.GQZyijEalUocS_yG5r@fat_crate.local>
 <79be2e29-6487-dd60-9b6f-3daa48a2e93f@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <79be2e29-6487-dd60-9b6f-3daa48a2e93f@amd.com>

On Mon, Nov 04, 2024 at 10:03:22AM -0600, Tom Lendacky wrote:
> >> +	desc = kzalloc(sizeof(*desc), GFP_KERNEL);
> > 
> > 			sizeof(struct rmp_segment_desc)
> 
> Hmmm... I prefer to keep this as sizeof(*desc). If any changes are made
> to the structure name, then this line doesn't need to be changed.

Oh boy, we really do that:

from Documentation/process/coding-style.rst

"The preferred form for passing a size of a struct is the following:

	p = kmalloc(sizeof(*p), ...);

The alternative form where struct name is spelled out hurts readability and
introduces an opportunity for a bug when the pointer variable type is changed
but the corresponding sizeof that is passed to a memory allocator is not."

Well, my problem with using the variable name as sizeof() argument is that you
need to go and look at what type it is to know what you're sizing. And it
doesn't really hurt readability - on the contrary - it makes it more readable.

/facepalm.

> > Why isn't this zeroing out part of alloc_rmp_segment_table()?

First of all:

diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
index 37ff4f98e8d1..1ae782194626 100644
--- a/arch/x86/virt/svm/sev.c
+++ b/arch/x86/virt/svm/sev.c
@@ -293,18 +293,16 @@ static void __init free_rmp_segment_table(void)
 	rmp_segment_table = NULL;
 }
 
-static bool __init alloc_rmp_segment_table(void)
+static struct __init rmp_segment_desc **alloc_rmp_segment_table(void)
 {
 	struct page *page;
 
 	/* Allocate the table used to index into the RMP segments */
 	page = alloc_page(__GFP_ZERO);
 	if (!page)
-		return false;
-
-	rmp_segment_table = page_address(page);
+		return NULL;
 
-	return true;
+	return page_address(page);
 }
 
 /*
@@ -344,7 +342,8 @@ static int __init snp_rmptable_init(void)
 		goto nosnp;
 	}
 
-	if (!alloc_rmp_segment_table())
+	rmp_segment_table = alloc_rmp_segment_table();
+	if (!rmp_segment_table)
 		goto nosnp;
 
 	/* Map only the RMP entries */
---

which makes the code a lot more readable and natural.

> If the SNP_EN bit is set in the SYSCFG MSR, the code needs to skip the
> zeroing of the RMP table since it no longer has write access to the
> table (this happens with kexec).

So we allocate a rmp_segment_table page when we kexec but we can't write the
entries? Why?

This sounds like some weird limitation. Or maybe I'm missing something.

> This keeps the code consistent with the prior code as to where the
> zeroing occurs. I can add another argument to alloc_rmp_segment_desc()
> that tells it whether to clear it or not, if you prefer.

You can also merge that init_rmptable_bookkeeping() and the zeroing of the RMP
entries into one function because they happen back-to-back.

In any case the placement of this whole dance still doesn't look completely
optimal to me.

> This is where I was worried about the VMM/guest being able to get into
> this routine with a bad PFN value.
> 
> This function is invoked from dump_rmpentry(), which can be invoked from:
> 
> rmpupdate() - I think this is safe because the adjust_direct_map() will
> fail if the PFN isn't valid, before the RMP is accessed.
> 
> snp_leak_pages() - I think this is safe because the PFN is based on an
> actual allocation.
> 
> snp_dump_hva_rmpentry() - This is called from the page fault handler. I
> think this invocation is safe for now because because it is only called
> if the fault type is an RMP fault type, which implies that the RMP is
> involved. But as an external function, there's no guarantee as to the
> situation it can be called from in the future.
> 
> I can remove it for now if you think it will be safe going forward.

I like being cautious and you probably should put this deliberation above the
array_index_nospec() so that it is clear to future generations reading this
code.

And yeah, it might be safe but it is not like it costs compared to the
remaining operations happening here so maybe, out of abundance of caution, we
should keep it there and explain why we do so.

Hmmm?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

