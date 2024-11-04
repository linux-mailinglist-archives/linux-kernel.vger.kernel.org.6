Return-Path: <linux-kernel+bounces-394257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC319BAC8D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 07:29:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A67B282101
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 06:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5030618C340;
	Mon,  4 Nov 2024 06:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="dYKJwKWI"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD9717583
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 06:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730701750; cv=none; b=KOJmisZb+cbOhME2nbXbkqgxwU9ccdZ/FwzMg8hweRujrQ23MsVvCaWv+lkHV+JLbfQ7YDjgCYGAw1BLFEZTeGYeTEidrhscGStVuW8kTp2mbfKrIyTHYx58mfNdCVNa4cBCOUIdbh+rrbb1/IT9edsJ9bvhhNChAGcmmf3YXrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730701750; c=relaxed/simple;
	bh=1lN8a0MLXly2H2wGORm6KH2j6tiD4qdhOI3LbpBLBo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m65pK90PTb5bJK2y1JeNUQiKpt0vpVrCyDjNzWv5XNODlM8XLI/TYTSrRm2P1czFjyOqv6fMMpXf+/a7u+ynWnqIvMavHBUvDf8DkRDwaWJjiallVAUPebUE1Lh2RYAz5x1HmZYIRJJW9GUuTpIqjeu/Do21+aYsVWFtuoeDnUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=dYKJwKWI; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 745CD40E0261;
	Mon,  4 Nov 2024 06:29:06 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 3hWP83OZ_FIR; Mon,  4 Nov 2024 06:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1730701742; bh=0Ni1yTACw2S3OD55JvQd9qo9TJOAqIOroW4339YwEd0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dYKJwKWIZauFo+Lu1vetOaS3Wmfzlifbepzss7Lzrw7rTIneHtRXyVDp5ev1UW2Hx
	 4x9CEYkgsN7pvnCpwC6LF+jRw8akjzflqZ4TVjo2f+YcPidzl7b4O6M8P/29oUdQRt
	 +ymYMtuATrPLQP/CWUvaP92kA+ms4/c4xiK7tq+xBfziRmDzRDksS5Xl29YwRUOohl
	 mxoOltffa1deBWRKzcU3xblV6KqFprry5W77yQhKvXS+mDMXvE27JSLddliruS1Ubl
	 Kw+jj8hI1aVWlCkoqFow/WUvUgVkyqzTIG7ke6Kp/A+IWr6gA0RYgfmQl7ONmDg8qG
	 GyGhvabbsFTf1H3x9Bq8RN/GDPvLJoZmAAHEeFQyR1kQQHaPKcoTrAXC4KpXnCSvGg
	 S3BHlF+VfWr2g6/oFy8LRrRBeMMP3r8yrshxNpNCjdkK+uHZmc2yAqonxH60cGibAH
	 HER0bV7x66LIB/fK2E1yR1X6RjYz3Qukk+vIspS+HRIuEeNfkHNOpTSMtyfyQZrJBR
	 I/9Sl7x5NMnPHumnRUcdwQeTx5cbI+KKC7xAawHTVdjqjcIFySD727kJUDYRuBvk6N
	 iRnStQ87R0SIi7d/ZjMt1ma8qKBb9+0ELVUiVNJ21gYikOuLUAPNOfsjPu2Jrzc0ev
	 zW1wDXaFKIgMJA5VWi21AMPk=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 524E640E0163;
	Mon,  4 Nov 2024 06:28:52 +0000 (UTC)
Date: Mon, 4 Nov 2024 07:28:45 +0100
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
Subject: Re: [PATCH v5 5/8] x86/sev: Map only the RMP table entries instead
 of the full RMP range
Message-ID: <20241104062845.GPZyhpnWueB-jCEl2H@fat_crate.local>
References: <cover.1730143962.git.thomas.lendacky@amd.com>
 <f48b9b551abb544fb7f997b9465680637f014dec.1730143962.git.thomas.lendacky@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f48b9b551abb544fb7f997b9465680637f014dec.1730143962.git.thomas.lendacky@amd.com>

On Mon, Oct 28, 2024 at 02:32:40PM -0500, Tom Lendacky wrote:
> @@ -224,7 +246,14 @@ static int __init snp_rmptable_init(void)
>  	if (val & MSR_AMD64_SYSCFG_SNP_EN)
>  		goto skip_enable;
>  
> -	memset(rmptable_start, 0, probed_rmp_size);
> +	/* Zero out the RMP bookkeeping area */
> +	if (!init_rmptable_bookkeeping()) {

So let's call it what it is then:

diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
index 5871c924c0b2..8145a7b14fa2 100644
--- a/arch/x86/virt/svm/sev.c
+++ b/arch/x86/virt/svm/sev.c
@@ -173,7 +173,7 @@ void __init snp_fixup_e820_tables(void)
 	__snp_fixup_e820_tables(probed_rmp_base + probed_rmp_size);
 }
 
-static bool __init init_rmptable_bookkeeping(void)
+static bool __init clear_rmptable_bookkeeping(void)
 {
 	void *bk;
 
@@ -246,8 +246,7 @@ static int __init snp_rmptable_init(void)
 	if (val & MSR_AMD64_SYSCFG_SNP_EN)
 		goto skip_enable;
 
-	/* Zero out the RMP bookkeeping area */
-	if (!init_rmptable_bookkeeping()) {
+	if (!clear_rmptable_bookkeeping()) {
 		memunmap(rmptable_start);
 		goto nosnp;
 	}


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

