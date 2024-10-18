Return-Path: <linux-kernel+bounces-371585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66ABA9A3CE8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 13:12:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12C8A1F210D4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 11:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E576120262E;
	Fri, 18 Oct 2024 11:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="GiNAT9N1"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E9920102B
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 11:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729249871; cv=none; b=EYt0bA92KTDXrAkXjsLNK0Hy0QLBCqySG/2CKwkje2QlQUlxb72XEqKij6mMQnG6rUuYmDG2IZ3aytp7Ess5+9le/kiCKlK44FSenXX6ZHDbNVUFBukoQ/pVPz03HF5nk7CjZSMPe5tQ6Y6/Jg/baRdYj5mWTE+isP4gSHu6038=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729249871; c=relaxed/simple;
	bh=THg/k14NwK2lCAj7y4e3OCdL5psv8E0RFI4h2miuVdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ijnhPRHsXQxknZyVJ3HajOeqZKhd1u8wocb+9s3sBfxz+58o5OsSxKOTl4scwHo9nkbklG4Y2yskFEzC1yOcodhTmWLBsCHga4Lk2C9fPxNqxZbNbc5UzZ8a1RS6h0ebgyy7oP134mXGYfsFTDk/KRLKWmfq4JnUcV+agVkOYCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=GiNAT9N1; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id CB67840E0163;
	Fri, 18 Oct 2024 11:11:00 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 8TE2FpSz-TMC; Fri, 18 Oct 2024 11:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1729249856; bh=oxj2AqK1sJ4jXql8ghrCEy85xjUTCWV77S9tiO7DVrE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GiNAT9N1kB/abeYScXan6VA8FtXrrv4R9ISjEg083XJB7vC76knYE6xm1EQr+c86k
	 wZi/bnJ6N9gWDcb91hUqDU7aPmQukKjWJRvPoHox4tvzV2m48Gq9dqCWQp+JzMx+Ha
	 u9iB1luJv6RvhCDzPxCEa+/kzAhUsCNcuH4o2OHKHQ2Kz5q+cqllj+jMA1vCirflK8
	 9Vhk77+9S7yNQcZdqke9J93tIwTOwLUxIdMzrlpQkIzzS7pl3kW2wKvx1GkPxkZ0RS
	 zdFKOlnOPjww61igdZdjEkjnxBa+FAvzpOqqzHuvceLk41ghSOnWKufwNBaWyZcMGJ
	 U5C237dLC1FaxI6CXu7Dg+P41solxXDjYl4jNnRBW3XqikM3YgE/woF90vQ0BOvjgx
	 9fPNp3s+63RCw0dI94i8ydNqRRzVbgOA/3W8kvS/bb+EY4RIrzS3HkjM6TBqBTdBY1
	 UsBoy6N9Sy2M6l6rvcTzJQa2V4sjvIKx48xMQDJ4UvzoBa/EZXiUwFJdd+bDOiQk5O
	 1B8ZiQqDQusL/XI3vTd/Don6OzIz/F9R7Ycc7Mt2cfb8wCBT7uriz8oyqzq3SSgMJH
	 vakZiTG3+ce7T7SdEmxKL5LFozLrdGsSfkvYLqY5TfL/6tT2isMS5zk+iOevIKfkQQ
	 wSfuXhznKsGAIuDD8jW6PVto=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9208240E0263;
	Fri, 18 Oct 2024 11:10:48 +0000 (UTC)
Date: Fri, 18 Oct 2024 13:10:43 +0200
From: Borislav Petkov <bp@alien8.de>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Michael Roth <michael.roth@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>
Subject: Re: [PATCH v2 1/7] x86/sev: Prepare for using the RMPREAD
 instruction to access the RMP
Message-ID: <20241018111043.GAZxJCM8DK-wEjDJZR@fat_crate.local>
References: <20240904104728.GBZtg6wIgihDlsIgIS@fat_crate.local>
 <20241017181636.2878844-1-thomas.lendacky@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241017181636.2878844-1-thomas.lendacky@amd.com>

On Thu, Oct 17, 2024 at 01:16:36PM -0500, Tom Lendacky wrote:
> I can look at naming the new struct "rmpread" and see how that looks if you
> prefer.

I think I understand what you mean now and I guess something like the below
would make it more clear. Diff ontop:

diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
index 73d4f422829a..73d9295dd013 100644
--- a/arch/x86/virt/svm/sev.c
+++ b/arch/x86/virt/svm/sev.c
@@ -48,7 +48,8 @@ struct rmpentry {
 
 /*
  * The RMP entry format is not architectural. The format is defined in PPR
- * Family 19h Model 01h, Rev B1 processor.
+ * Family 19h Model 01h, Rev B1 processor. This is the raw, verbatim
+ * representation as it is found in the RMP table.
  */
 struct rmpentry_raw {
 	union {
@@ -286,7 +287,7 @@ static int __init snp_rmptable_init(void)
  */
 device_initcall(snp_rmptable_init);
 
-static struct rmpentry_raw *__get_rmpentry(unsigned long pfn)
+static struct rmpentry_raw *get_raw_rmpentry(unsigned long pfn)
 {
 	if (!rmptable)
 		return ERR_PTR(-ENODEV);
@@ -312,7 +313,7 @@ static int get_rmpentry(u64 pfn, struct rmpentry *entry)
 		return ret;
 	}
 
-	e = __get_rmpentry(pfn);
+	e = get_raw_rmpentry(pfn);
 	if (IS_ERR(e))
 		return PTR_ERR(e);
 
@@ -393,7 +394,7 @@ static void dump_rmpentry(u64 pfn)
 	}
 
 	if (e.assigned) {
-		e_raw = __get_rmpentry(pfn);
+		e_raw = get_raw_rmpentry(pfn);
 		if (IS_ERR(e_raw)) {
 			pr_err("Failed to read RMP contents for PFN 0x%llx, error %ld\n",
 			       pfn, PTR_ERR(e_raw));
@@ -420,7 +421,7 @@ static void dump_rmpentry(u64 pfn)
 		pfn, pfn_i, pfn_end);
 
 	while (pfn_i < pfn_end) {
-		e_raw = __get_rmpentry(pfn_i);
+		e_raw = get_raw_rmpentry(pfn_i);
 		if (IS_ERR(e_raw)) {
 			pr_err("Error %ld reading RMP contents for PFN 0x%llx\n",
 			       PTR_ERR(e_raw), pfn_i);


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

