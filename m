Return-Path: <linux-kernel+bounces-196868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D18EF8D62C1
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 15:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F4CF1C225CB
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 13:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE6D158DA9;
	Fri, 31 May 2024 13:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="JEOF8PX7"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5059158A36
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 13:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717161409; cv=none; b=DNRdepiQmbelgNFKQNAgRh+T73RA3wnx+6ihUEBrZ0D5BbMqjtPNImSKfOkTKWX3Shk40o09ObtdlAHVXt+IPFtY3lWoz4sscnc/VYXV7zzrIdsV8QIQTL9i9MAkL1NB6MHnRd0XNemjM0n/cj+nKR9MTfNEB8A/Mljh7sYHIFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717161409; c=relaxed/simple;
	bh=BfavkLiaoMjhNDhQjKmCETR3/3J3EhyIkNJFU/CcVOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=isrOPjXMMFSwVjLARktMMRx2R4FWzn8oG3cHt4E2uYcDV+g8oo63AJNbiVuXPnIohKS2bT/d4HWJxVBJjfNpEkj97xPr4rtREf3eKTw6LBPDHbZrFVxRaKJFDUpuXkg4NdDHAwf/RljpsVP+4XnIRackqAMDpsO0S7BII3XF1H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=JEOF8PX7; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7280D40E0241;
	Fri, 31 May 2024 13:16:44 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id nAla2_wacaC6; Fri, 31 May 2024 13:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1717161401; bh=MBoInph48R5H6sVBCrU78RHdg8wzQUMpapSuKIbmamc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JEOF8PX7AHTrUx4BAHiguRqjAhC4NqdN9iwlxWvatGp6h4dKscp7mKEc5+MXAU02R
	 5MvxPaKapcNixUFCSCh4XwH3biA73mV4cc2t3qIqmHDXgqTErtQD0+V8t6ClltU78B
	 DG1CkNCRmJuC1sRYklIaH5F1+2B8phh4/OBGemtmlikpsHHKBk1ZmG1RzBGfZlozMX
	 cwRZLtSJzgKwcI0yS5dzCLXTZdkB81U9RNjbBIPz14lwZhtXkC2Gy6vdT+AG0HW9gg
	 KXW2S/ylYlxI5QSlT+ZeJI0SjVYE2Ekp/Fg9TjI4ia48JXVgfjvcYM2TvfWG215hV0
	 0yWkOConHYUnvuiTJmUA4LXFoFxavX25ed+J0ji76BProl+ofKUaylQezWoQ4/a9CN
	 vseaK1RufHcxBf2z7juKPPh4zhQLbncAFgrXwnHkvOkBm2PhAuPmpG2A4Tf5GCFoqm
	 hPaTAnOizkILBsK0aiEqCkmZjVHVG64NJ1TD5WTG47IlNpRs8d5SxG9QFNsKOID3uh
	 5mkSuDS9/HyTA+b9FZaMC/LMrqp6zG6po3OiVr2ksjzxpeyHL+/BXeKoMyO3q290IH
	 A05ji2/CKHKuFF9eYCAa++i5Lhb6zFUOjwqdkyIzxt4/iV0nBfeDtDMdnJAeyd3V6m
	 hXY/h+AecapPBFUEM5evp4tM=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 290A640E01A1;
	Fri, 31 May 2024 13:16:27 +0000 (UTC)
Date: Fri, 31 May 2024 15:16:19 +0200
From: Borislav Petkov <bp@alien8.de>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-coco@lists.linux.dev, svsm-devel@coconut-svsm.dev,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Michael Roth <michael.roth@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>
Subject: Re: [PATCH v4 14/15] x86/sev: Extend the config-fs attestation
 support for an SVSM
Message-ID: <20240531131619.GKZlnNo20bj98_ILiM@fat_crate.local>
References: <cover.1713974291.git.thomas.lendacky@amd.com>
 <9a4c4a16d00834c1b7ff458e25c185ac1c9bcf79.1713974291.git.thomas.lendacky@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9a4c4a16d00834c1b7ff458e25c185ac1c9bcf79.1713974291.git.thomas.lendacky@amd.com>

On Wed, Apr 24, 2024 at 10:58:10AM -0500, Tom Lendacky wrote:
> +/*
> + * The SVSM Attestation related structures
> + */
> +struct svsm_location_entry {

"svsm_loc" should be enough.

> +	u64 pa;
> +	u32 len;
> +	u8 rsvd[4];
> +};
> +
> +struct svsm_attestation_call {

Can we shorten all "attestion" to "atst" or "attest"?

> +	struct svsm_location_entry report_buffer;
> +	struct svsm_location_entry nonce;
> +	struct svsm_location_entry manifest_buffer;
> +	struct svsm_location_entry certificates_buffer;

report_buf;
nonce;
manifest_buf;
certs_buf;

Please shorten all those.

> +	/* For attesting a single service */
> +	u8 service_guid[16];
> +	u32 service_manifest_version;

manifest_ver;

> +	u8 rsvd[4];
> +};
> +
>  /*
>   * SVSM protocol structure

..

> +static void update_attestation_input(struct svsm_call *call, struct svsm_attestation_call *input)
> +{
> +	/* If (new) lengths have been returned, propograte them up */

"propagate"

> +	if (call->rcx_out != call->rcx)
> +		input->manifest_buffer.len = call->rcx_out;
> +
> +	if (call->rdx_out != call->rdx)
> +		input->certificates_buffer.len = call->rdx_out;
> +
> +	if (call->r8_out != call->r8)
> +		input->report_buffer.len = call->r8_out;
> +}
> +
> +int snp_issue_svsm_attestation_request(u64 call_id, struct svsm_attestation_call *input)

This looks like BIOS code. The only thing that's missing is the
CamelCase. :-)

int snp_issue_svsm_attest_req(u64 call_id, struct svsm_attest_call *input_call)

Now that's more like it!

> +{
> +	struct svsm_attestation_call *attest_call;

	struct svsm_attest_call *atst_call;

> +	struct svsm_call call = {};
> +	unsigned long flags;
> +	u64 attest_call_pa;
> +	int ret;
> +
> +	if (!vmpl)
> +		return -EINVAL;
> +

..

> +static int sev_svsm_report_new(struct tsm_report *report, void *data)
> +{
> +	unsigned int report_len, manifest_len, certificates_len;
> +	void *report_blob, *manifest_blob, *certificates_blob;

Prose. Shorter pls.

> +	struct svsm_attestation_call attest_call = {};
> +	struct tsm_desc *desc = &report->desc;
> +	unsigned int retry_count;
> +	unsigned int size;
> +	bool try_again;
> +	void *buffer;
> +	u64 call_id;
> +	int ret;

..

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

