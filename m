Return-Path: <linux-kernel+bounces-246464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5629E92C205
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 19:14:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12018294065
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 17:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31EE2189F58;
	Tue,  9 Jul 2024 16:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="VEYdgSfR"
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782F0189F4C
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 16:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.147.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720544284; cv=none; b=akwb0CnjGQ9EiJlwEZkLM17EXtG44HYjjOxuZEJvyVHa3S7jArKDSW7Wsi8dYn1qRb76AZL9b8fkic7T0NHyy2pp/HpWTQ6UkNCEld6AWlih8cZcNwYPKVe2YN3CTUCUcCF/JLynlluud5NeqFAj7ZLpoUqJe7GiqBflapLbe0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720544284; c=relaxed/simple;
	bh=nkTWMGfjEyh1vvy7M5TLEzkpGoCAbgKFsJFG64WstwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eVHcygSYN4tpf0LkB2PjqTFfgupRsSDaMu7G6F7G5R+cXt42qq6fV411eCc6EtivfHv7T1G1VMRqeKUf96kFHWx4Jl8P1tOX9dg51HbJ5MIFWgJI9aGP0z+WtNYncPaNgDsU6jflfSYftiax8B2M8xlurEPn5M93D+GJIUQNf7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=VEYdgSfR; arc=none smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 469G2xj0025294;
	Tue, 9 Jul 2024 16:56:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pps0720; bh=xFASJwdgR+cb5+o7gVSxSuY
	ML2SzklMlZnUynN7IJA0=; b=VEYdgSfROL6G5DJhp+vkx/g3ybkpPAEKlVCBuMJ
	8neEVSdGBA1kL/h0fYGo9+bdNhL2u6394RHRgSQtIq6f67MF4vVHcXHdEmR1z4SF
	PS0HEvUBmCf9VWW7qm3AjabEtNXLdI1vztE7BANHR8Nj1Dls/sALG+DR+Tf6Xoof
	leOq2kWZ449pPZZIaAylae0s2CvLhNox948u6zf3VsP9et8KDmAIITP/dWa6wp5y
	Q3EivPIRbzqjkvnCI3mZ1kelbGV8wh+UKmaUSPJBl5N6XHeNXXxK3lvrXNy/Cp59
	oaVabVKy2LdNk2H0gY+J9DySXPhSKUm9lplq2aEbixUvSoA==
Received: from p1lg14881.it.hpe.com ([16.230.97.202])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 408x1xnppp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 16:56:33 +0000 (GMT)
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14881.it.hpe.com (Postfix) with ESMTPS id D12C88059E9;
	Tue,  9 Jul 2024 16:56:32 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [16.231.227.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTPS id 5BFD2801D88;
	Tue,  9 Jul 2024 16:56:28 +0000 (UTC)
Date: Tue, 9 Jul 2024 11:56:26 -0500
From: Steve Wahl <steve.wahl@hpe.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Steve Wahl <steve.wahl@hpe.com>, Ard Biesheuvel <ardb@kernel.org>,
        Ashish Kalra <ashish.kalra@amd.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org, Pavin Joseph <me@pavinjoseph.com>,
        Eric Hagberg <ehagberg@gmail.com>, Simon Horman <horms@verge.net.au>,
        Eric Biederman <ebiederm@xmission.com>, Dave Young <dyoung@redhat.com>,
        Sarah Brofeldt <srhb@dbc.dk>, Russ Anderson <rja@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>,
        Hou Wenlong <houwenlong.hwl@antgroup.com>,
        Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>,
        Yuntao Wang <ytcoode@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
        Joerg Roedel <jroedel@suse.de>, Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH 0/3] Resolve problems with kexec identity mapping
Message-ID: <Zo1rugBl5WWy-1LJ@swahl-home.5wahls.com>
References: <20240708190724.GIZow47G0J8vO6J3ee@fat_crate.local>
 <Zow-AXsLHjU6gfET@swahl-home.5wahls.com>
 <20240708195810.GKZoxE0pRWHEUljjnQ@fat_crate.local>
 <ZoxOt1_w7nblRQCv@swahl-home.5wahls.com>
 <CAMj1kXGA8zG95WutMgVgeb-M7oQKJrVO6QWNzLi1GMuj1wq=bg@mail.gmail.com>
 <ZoxX9mckeu046zed@swahl-home.5wahls.com>
 <CAMj1kXE5OYTxxBEO38dRyYt_J1FNpU-tdkaU8rxvrMLd_k_beg@mail.gmail.com>
 <20240709103742.GCZo0S9md7YyeevRN-@fat_crate.local>
 <Zo1SRIZEhveMwSPX@swahl-home.5wahls.com>
 <20240709164620.GLZo1pXPiG42JH4ylN@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709164620.GLZo1pXPiG42JH4ylN@fat_crate.local>
X-Proofpoint-ORIG-GUID: HoTSir1je7_bwYRIiP2vGIAvwwc_E7AM
X-Proofpoint-GUID: HoTSir1je7_bwYRIiP2vGIAvwwc_E7AM
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_06,2024-07-09_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 malwarescore=0 mlxscore=0 phishscore=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407090112

On Tue, Jul 09, 2024 at 06:46:20PM +0200, Borislav Petkov wrote:
> On Tue, Jul 09, 2024 at 10:07:48AM -0500, Steve Wahl wrote:
> > I think perhaps the cover letter was also too verbose on the history
> > and unintentionally hid the information necesary to understand the
> > situation.  I will try to make it more concise.
> 
> Thanks.
> 
> And while we're at it, I think we should do this too.
> 
> Which should actually fix your issue too.

Ok, that one is interesting.  I think you are right, it will fix the
problem as we would bail before calling find_cc_blob(), which is where
we get into trouble.  (That call happens just outside the context
displayed by the diff below).

I will add it.

--> Steve

> ---
> diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
> index cd44e120fe53..a838cad72532 100644
> --- a/arch/x86/boot/compressed/sev.c
> +++ b/arch/x86/boot/compressed/sev.c
> @@ -484,6 +484,15 @@ static bool early_snp_init(struct boot_params *bp)
>  {
>  	struct cc_blob_sev_info *cc_info;
>  
> +	/*
> +	 * Bail out if not running on a hypervisor (HV). If the HV
> +	 * doesn't set the bit, that's an easy SEV-* guest DOS but that
> +	 * HV has then bigger problems: the SEV-* guest simply won't
> +	 * start.
> +	 */
> +	if (!(native_cpuid_ecx(1) & BIT(31)))
> +		return false;
> +
>  	if (!bp)
>  		return false;
>  
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette

-- 
Steve Wahl, Hewlett Packard Enterprise

