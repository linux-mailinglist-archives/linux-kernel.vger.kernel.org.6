Return-Path: <linux-kernel+bounces-395268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 768D89BBB1C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 18:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02460B216D6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 17:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416361C75EB;
	Mon,  4 Nov 2024 17:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="BwmS2Vsn"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DACA1CACFA
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 17:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730739939; cv=none; b=IJI/T+4TfEc1iNRnFnGoMR3aFksSd+D8N2pK2a7sVREqGXUa6ELLeDcQSuFPy7IyH1sp0cKZb47HksYQAep0MfCUh53u2hhGxlNk8BIs355SYUR1MzZrtAfRqvidqvDeIDth861Z2WPBr/mnjXR6fzOHGDDHI00LVzBYaiusUIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730739939; c=relaxed/simple;
	bh=rr0gjl/zeI9759khqd9Lt6RZPFSFYdYcYkjuXIAlCew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zz97C1CIidMoEWpKdmt98jk8UivwkclE30oPUA2jw7xYqvk9O8FJMzKPMAgUm0sfoyZzxpN8bJSOJ0YqkbqZBF6vcZlMhIN0O+RdjuTGpKlfDpZxvfPTXhi7cSX9caSztZ18RGX/8J/GrOPbaOFxsTV4sCQU+Msxutx3xV11hL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=BwmS2Vsn; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E042340E0263;
	Mon,  4 Nov 2024 17:05:34 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 1XKyvydwzMCk; Mon,  4 Nov 2024 17:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1730739931; bh=qqNHkIL2k+cgA6wP4Uz3BLFmBZ8wL8ZGhObDzsbBBys=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BwmS2VsnVcQ5X8EYroc3fA++8+E9Gv2im6dnUtttJvhmujMutB5sBQ+ARdxE+UiNF
	 Zb2fS8Eg/SA1oYfdCUmAit0IpH1qTaznhWJzHYECMk6jjiddusBn7ucemznyjoN4/t
	 C24S/CQ/d6btoAVeFYaE6hXievojNG8TqBRCYDIF2/uoKZ3EzbNDrglpslQlMPFvz9
	 1h6WsOqrQzD3kEHW6u+JFLxtUuoSgpUZf6IDm8ykVo2aUruc79FmazhI26fOD/utJZ
	 z2GiLu8QwlTLzROSjCe5VFjsOr7N8tA5YeE0mIGSXg3P38APEb1WWIyBGqVRKHbIpv
	 rPdKufxXxt0dPO/wshBMBNDurT8pRYdXzzNo5SxzdoqNgwdtuW5uO8weFCM9jaV58y
	 Pj8bc7ScWyWYx7gWi1rO6GpHlpYHzb/oZ4/w7qiSYSq5OWnNXicwe4OY+qK7Q1/v85
	 mDh36Bu4t4IA09W2+8ZtKbSKH6+CaPymkMxlzt0M6A4z9lzDmRfJmumHYRxOWALiR0
	 zwXBI2/XzCTIpLzWsLwpS3VtX/xZ+bTrp7UmC7m5VS1+QUX7CzoQBauvlKrluyMI4e
	 pQos21UHn5+9ydb/KHILqyeJaT+5C2QD+24Q2pOJrtNDghJIuKOTnl1Hgumn/l3KnL
	 catWM+44s4ElLTRhMwsKhp6Q=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C9C9840E0163;
	Mon,  4 Nov 2024 17:05:20 +0000 (UTC)
Date: Mon, 4 Nov 2024 18:05:14 +0100
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
Message-ID: <20241104170514.GGZyj-yvIHo8Y-eKpj@fat_crate.local>
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
> >> +static u64 rmp_segment_size_max;
> > 
> > This one is used in a single function. Generate it there pls.
> 
> It's used in two functions, alloc_rmp_segment_desc() and
> set_rmp_segment_info().

You can always lift it up later if it is needed more than now:

diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
index 37ff4f98e8d1..77bdf4d6a8f4 100644
--- a/arch/x86/virt/svm/sev.c
+++ b/arch/x86/virt/svm/sev.c
@@ -103,7 +103,6 @@ struct rmp_segment_desc {
 static struct rmp_segment_desc **rmp_segment_table __ro_after_init;
 static unsigned int rst_max_index __ro_after_init = 512;
 
-static u64 rmp_segment_size_max;
 static unsigned int rmp_segment_coverage_shift;
 static u64 rmp_segment_coverage_size;
 static u64 rmp_segment_coverage_mask;
@@ -223,9 +222,13 @@ static bool __init init_rmptable_bookkeeping(void)
 
 static bool __init alloc_rmp_segment_desc(u64 segment_pa, u64 segment_size, u64 pa)
 {
+	u64 rst_index, rmp_segment_size_max;
 	struct rmp_segment_desc *desc;
 	void *rmp_segment;
-	u64 rst_index;
+
+	/* Calculate the maximum size an RMP can be (16 bytes/page mapped) */
+	rmp_segment_size_max = PHYS_PFN(rmp_segment_coverage_size);
+	rmp_segment_size_max <<= 4;
 
 	/* Validate the RMP segment size */
 	if (segment_size > rmp_segment_size_max) {
@@ -415,10 +418,6 @@ static void set_rmp_segment_info(unsigned int segment_shift)
 	rmp_segment_coverage_shift = segment_shift;
 	rmp_segment_coverage_size  = 1ULL << rmp_segment_coverage_shift;
 	rmp_segment_coverage_mask  = rmp_segment_coverage_size - 1;
-
-	/* Calculate the maximum size an RMP can be (16 bytes/page mapped) */
-	rmp_segment_size_max = PHYS_PFN(rmp_segment_coverage_size);
-	rmp_segment_size_max <<= 4;
 }
 
 #define RMP_ADDR_MASK GENMASK_ULL(51, 13)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

