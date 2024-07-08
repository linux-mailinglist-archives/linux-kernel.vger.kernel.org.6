Return-Path: <linux-kernel+bounces-244557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 307E792A5F5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 17:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE470284C05
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 15:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE1801411E7;
	Mon,  8 Jul 2024 15:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="K4ypnVUp"
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7589914388F
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 15:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.147.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720453459; cv=none; b=uo4HIe7nmQkbdk6IoqDFNJvqBDN18XrhEdDqtka75Z+VVXGp/ZUJpSI4a71BKW2kRnse/tu8M/OYgHGqBn4A08V3bd+4B/IgOZnINBwGJNFCUvMsXXy0007G+ZXJwLZUatm1FzMN6VHibrzddXpWZoLp/TSRE+PPD2FrGYcFcOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720453459; c=relaxed/simple;
	bh=GMSb6T8O6OYkZ/FNnE1PL3FavlZARXIzGMH704UX7Bg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dsnSyDLTstK+saXEIqcCGIDxeLkRL0vNqxhoDmnoalhlCQFzKU1lEq6nKT5qYplAp6G+YKo8Yz/svxVQMVsM9MUY4PjmV1rOYr7Xc0e0PwMCYObW9GGH/NJ7CULLo56MlYYtWiTqGrGxDZYkBrnjz+2e/nEsAu2Jz3jflHEHwDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=K4ypnVUp; arc=none smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
	by mx0a-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 468E8Vg7008475;
	Mon, 8 Jul 2024 15:42:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pps0720; bh=8kJQOPWbJ+aKHyQ9fZc+lY+
	bRONOJ/gC1llyMQ4rbOQ=; b=K4ypnVUpA0BIaZkuNT0V4a7jasZK4HmRuMsD/aH
	MvA4h0WMAOGyL+QnRCduCxqiEH/oCRAg9+lh455ZA5HtIdYF08+MbRzWLEuq9oAx
	9qZUk9Wk5s+B0dsU1OBsE3fa7z8Xzc8gbRW+KY/71i3uaLOGnmuB5Cmi9HyZ4Stc
	6FtY6k4tzqe04MwG5gR1oxP/0clg/265Iwj+8qIb8Snsp7SsQEKOBOPktzIz1g8w
	HhdGEgeYKoe1eRn2Dha3JoMky+ez+G9E3G+MKMtHRw9A+ZWFAjwHQrOjntxoKi8d
	VvslW02i7CaRnz09+qeDfYNP4sdRDLsoROr8K4m833ejNOA==
Received: from p1lg14880.it.hpe.com ([16.230.97.201])
	by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 408hm6rrsm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jul 2024 15:42:57 +0000 (GMT)
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14880.it.hpe.com (Postfix) with ESMTPS id D676A80025D;
	Mon,  8 Jul 2024 15:42:56 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [16.231.227.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTPS id 7F38080A3F8;
	Mon,  8 Jul 2024 15:42:50 +0000 (UTC)
Date: Mon, 8 Jul 2024 10:42:47 -0500
From: Steve Wahl <steve.wahl@hpe.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Ard Biesheuvel <ardb@kernel.org>, Steve Wahl <steve.wahl@hpe.com>,
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
Message-ID: <ZowI9w7huVfcKJ7I@swahl-home.5wahls.com>
References: <20240613152826.GKZmsQGnO3OthLH3Vu@fat_crate.local>
 <ZmsbZCF9rFzuB3rO@swahl-home.5wahls.com>
 <20240616202533.GDZm9KPZtpDKw5aXWX@fat_crate.local>
 <ZnBR6MgS-jzjgA8A@swahl-home.5wahls.com>
 <20240621131742.GEZnV9dn_0XVH0IZ58@fat_crate.local>
 <ZnmNKAE5qT48yhrI@swahl-home.5wahls.com>
 <20240701142704.GGZoK8uDt-2VVtclHl@fat_crate.local>
 <20240702174425.GHZoQ8edlTfB1falcO@fat_crate.local>
 <CAMj1kXGsjU5CpF655me1XNA8-5nbk3020vT2Bu5ZoFY25igovg@mail.gmail.com>
 <20240703154301.GEZoVxhREtHjk0vtaL@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703154301.GEZoVxhREtHjk0vtaL@fat_crate.local>
X-Proofpoint-ORIG-GUID: xmqM3nHnZ6R7M3-ZRhe8OJfi4hXHzMFb
X-Proofpoint-GUID: xmqM3nHnZ6R7M3-ZRhe8OJfi4hXHzMFb
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-08_09,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=983
 malwarescore=0 phishscore=0 mlxscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407080117

On Wed, Jul 03, 2024 at 06:14:41PM +0200, Borislav Petkov wrote:
> On Tue, Jul 02, 2024 at 08:32:22PM +0200, Ard Biesheuvel wrote:
> > For kexec on a 64-bit system, I would expect the high-level support
> > code to be capable of simply mapping all of DRAM 1:1, rather than
> > playing these games with #PF handlers and on-demand mapping.
> 
> Yeah, apparently we can't do that on SGI, as Steve said.
> 
> I like the aspect that the #PF handler won't fire in the first kernel because
> of EFI mapping all RAM. That's good.
> 
> So we could try to wire in a #PF handler in stage1, see below.
> 
> Steve, I don't have a good idea how to test that. Maybe some of those
> reporters you were talking about, would be willing to...
> 
> ---
> diff --git a/arch/x86/boot/compressed/idt_64.c b/arch/x86/boot/compressed/idt_64.c
> index d100284bbef4..a258587c8949 100644
> --- a/arch/x86/boot/compressed/idt_64.c
> +++ b/arch/x86/boot/compressed/idt_64.c
> @@ -32,6 +32,7 @@ void load_stage1_idt(void)
>  {
>  	boot_idt_desc.address = (unsigned long)boot_idt;
>  
> +	set_idt_entry(X86_TRAP_PF, boot_page_fault);
>  
>  	if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT))
>  		set_idt_entry(X86_TRAP_VC, boot_stage1_vc);
> 
> -- 
> Regards/Gruss,
>     Boris.

Boris,

Eric Hagberg tested this patch for me and it didn't work.  (Thanks,
Eric.)

So I looked at the code more closely, and I don't think
boot_page_fault is going to work prior to the call to
initialize_identity_maps.  In the current flow in head_64.S, that
comes after load_stage2_idt, where here we were trying to use it
just after load_stage1_idt, quite a bit earlier.

Is there a reason you want to avoid having these areas already entered
in the identity map setup by kexec?

I can see this could have the appearance of getting out of hand if we
had to continually add things to it. But only those pieces that need
to be referenced before the page fault handler is established actually
require this treatment.

--> Steve

-- 
Steve Wahl, Hewlett Packard Enterprise

