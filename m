Return-Path: <linux-kernel+bounces-439347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4301C9EADF7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 11:29:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 963E628185C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A481DC982;
	Tue, 10 Dec 2024 10:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="IBalEQ6x"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9C623DE9F
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 10:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733826539; cv=none; b=RUgLPYwgmpFssEa8KnhH2X0h0LhuObnmQSvjm+W0Bht7cYbU5zxdgZPi5mVRM2BmwshsT9C2e7mgSKMTgMj//jKbRE/wUj2iFwyh9442eRX7SnGgXO0JgDv+YdceOy6y2/T8gHdl2k9uIrrCvYWxR6unktNypVxD0kaiAUmiViU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733826539; c=relaxed/simple;
	bh=AXICE45n8VGEWntYeT3CM4FjrEti+tM9ptF3DZdi79U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d4raIDyDoHithKeFR++5sYxUBFsF6NpGFKx/P6yu1krfnOboImIJ9jhG/2Kexz75c+BHuEpZh7mctCMqtiOx2aqASeoxWv8IlETY2psFuXvAufrBvI/Jt/sL9xDPHN30AQajr4ASXxbaIXLRNDgfX6pk/XONKmo/zp+StfS9Vus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=IBalEQ6x; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A56D240E028B;
	Tue, 10 Dec 2024 10:28:54 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id DOxvEddhPsYD; Tue, 10 Dec 2024 10:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1733826530; bh=4Ib7E36r4o7wZ6csrTRSfZT/WxIPoKg/kjFQFON/JFA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IBalEQ6xbChoSfuN2KL976HgswEqgNvqOF6H/I/OfobbMps+pWMddoEwO9aLYroju
	 Bv1c9QCIuz3Vm4rTKfCMg7jeyHpt+t2cW9x+/vTGI2D034znsrDTzzs25UTDX59zlu
	 YCspiSKSuW/T0MOC+aFOg7r5AiWqQFR4nbVeThFxbUma+OQj8hUtSg38+RU7gs78C3
	 k9md0M2SRwN+/1HNqOVyp+1uQT4JD9+c0aNaTrAO9hFV41PCc9edSZlkFIOxN9jBus
	 eLEF+G0qA8K1iLXaX4bO70ZFF7isbZ+1cND+eHCBNqC2+lpv9wwsvR/zW8Ar8zkg2w
	 T+cWQMdypNOlaFHUaw0Au+rt/wxwye4t+0xJ3ssr0YIHASF+GpO9jzVknzUWXlRGEC
	 pE9s1a9AyMf23IhON14V0o/rHXXd7hIpLaYDnD5HEkjrgfaYDe/us/7pWc8sBog6l1
	 s8R74rK4UI2Sq/jqTtJc9r4EKuvSWNNIW/JbB3+DFk/pVGKmmWlsfAuVx3aP9ETNe3
	 mbrPZCYuw2yPYNNvdsDj0ENjKQLYcSm9LaOtlz+gb2gszgSczOQUy3/jTvWgm/VeKV
	 zsYHSox3i6SEhwN1LvHJMWEkDDsqwikIrYfbyc2FHdF8KfowYedboyDDNl4KYXx4zR
	 azOHoT/F9IekSbLCrheD89n0=
Received: from zn.tnic (p200300ea971f9307329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971f:9307:329c:23ff:fea6:a903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BF5E640E0288;
	Tue, 10 Dec 2024 10:28:40 +0000 (UTC)
Date: Tue, 10 Dec 2024 11:28:35 +0100
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
Subject: Re: [PATCH v6 6/8] x86/sev: Treat the contiguous RMP table as a
 single RMP segment
Message-ID: <20241210102835.GCZ1gX04evsuTcS01d@fat_crate.local>
References: <cover.1733172653.git.thomas.lendacky@amd.com>
 <8c40fbc9c5217f0d79b37cf861eff03ab0330bef.1733172653.git.thomas.lendacky@amd.com>
 <20241209194320.GCZ1dIWDMPppdXgzxJ@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241209194320.GCZ1dIWDMPppdXgzxJ@fat_crate.local>

On Mon, Dec 09, 2024 at 08:43:20PM +0100, Borislav Petkov wrote:
> I think we should collect the deliberation why we're doing this nospec stuff
> from here:
> 
> https://lore.kernel.org/r/79be2e29-6487-dd60-9b6f-3daa48a2e93f@amd.com
> 
> into a comment around here for future reference.
> 
> This is the best example for those: "uff, why did we do it back then"?
> questions when we stare at this months, years from now.

IOW, something short like this which should catch the gist of the idea:

diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
index 3272a73d3594..46abc73cbb87 100644
--- a/arch/x86/virt/svm/sev.c
+++ b/arch/x86/virt/svm/sev.c
@@ -453,6 +453,14 @@ bool snp_probe_rmptable_info(void)
        return true;
 }
 
+/*
+ * About the array_index_nospec() usage below:
+ *
+ * This function can get called by exported functions like
+ * snp_lookup_rmpentry(), which is used by the KVM #PF handler, among
+ * others, and since the @pfn passed in cannot always be trusted,
+ * speculation should be stopped as a protective measure.
+ */
 static struct rmpentry_raw *get_raw_rmpentry(u64 pfn)
 {
        u64 paddr, rst_index, segment_index;

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

