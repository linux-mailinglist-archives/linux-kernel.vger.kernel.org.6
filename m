Return-Path: <linux-kernel+bounces-244811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7533292A9D1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 21:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12FE0B21034
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 19:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9119979FD;
	Mon,  8 Jul 2024 19:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="QUQbLp4h"
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F4118E1E
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 19:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.147.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720467014; cv=none; b=lre0pwnCsPXgMMbqcQ1+VFg7ZE8OsejfBOkRVcci4VVIJtC0Lr1q/FDUEM8KJFWhicYd2sJTph/sh01NjBKbLROawL/v5LKgV4ROBq9zwqsMfBRmyradubpMirjehIExOXJvSdrmUnNxgw/qAq7k6GzMR+gxnr0WvkL64xqaLPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720467014; c=relaxed/simple;
	bh=NpgwHPX/d3tp/EyiDsUQn8KVXyW32rJMURGHE0iQyAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gyHypsyR/Vt0Dy1B+eavf2mP5BHBC9X+FKxS2nPMt7XzKlNRQO86A7/BExiDzXAHVGVrWX+IzVF0tpQg9UKGrBTgTJezMfcRWmrtto7RY04peyThePik7ZJriGULr855vdrnQLM5YPMuR/NBLH+LrXTuD2Xh34Qt2LBHcBd5+nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=QUQbLp4h; arc=none smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
	by mx0a-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 468IQVFh002080;
	Mon, 8 Jul 2024 19:29:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pps0720; bh=H4RsE4EKfRow56WbdKNcMSY
	bYBDOUL/8VYeHWiX8J0U=; b=QUQbLp4hc5zBnowbt4miBJIo/pPjTvOXYq7dWPN
	FID6/tagd9nUfPWpqHqmse17Ih0bFjm86ai+AkmBMB2PrzHZWgcRDeB9v4B5fQiG
	o3trblrMIFPBrhgQks+GRYlQVzae1M7s0EtfxBGAKZImcnQy7yloltup2Jg/fDdX
	9JVmwimV8PctEEs/yvtgLgcwRbxapKYEZjd91VlN+w9Ma1QGbixCNQZER7TtjGN6
	UFbFpa1ZjUKcOYGtqUvfMcA0OVB60H5MH4erph72DGoQBB3r9BlVwy5wz/VgyBNb
	rl8IGNwTdqEfgI0Qvz95niMAyj6bvYklRx/+07nwzhdczug==
Received: from p1lg14878.it.hpe.com ([16.230.97.204])
	by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 408dr8vfm0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jul 2024 19:29:16 +0000 (GMT)
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 7A64912E9A;
	Mon,  8 Jul 2024 19:29:13 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [16.231.227.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTPS id 855628014F7;
	Mon,  8 Jul 2024 19:29:07 +0000 (UTC)
Date: Mon, 8 Jul 2024 14:29:05 -0500
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
Message-ID: <Zow-AXsLHjU6gfET@swahl-home.5wahls.com>
References: <20240621131742.GEZnV9dn_0XVH0IZ58@fat_crate.local>
 <ZnmNKAE5qT48yhrI@swahl-home.5wahls.com>
 <20240701142704.GGZoK8uDt-2VVtclHl@fat_crate.local>
 <20240702174425.GHZoQ8edlTfB1falcO@fat_crate.local>
 <CAMj1kXGsjU5CpF655me1XNA8-5nbk3020vT2Bu5ZoFY25igovg@mail.gmail.com>
 <20240703154301.GEZoVxhREtHjk0vtaL@fat_crate.local>
 <ZowI9w7huVfcKJ7I@swahl-home.5wahls.com>
 <20240708181133.GHZowr1eznPqgvdtRw@fat_crate.local>
 <CAMj1kXG8hZ86BFbar9S5mmvKMH4a0XF0oCm36WwZxYNqc0+pjQ@mail.gmail.com>
 <20240708190724.GIZow47G0J8vO6J3ee@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240708190724.GIZow47G0J8vO6J3ee@fat_crate.local>
X-Proofpoint-ORIG-GUID: oWEE9cDr5kzfnxuLmOl787osxcn3GcUb
X-Proofpoint-GUID: oWEE9cDr5kzfnxuLmOl787osxcn3GcUb
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-08_10,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 mlxscore=0
 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0 mlxlogscore=996
 spamscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2406140001 definitions=main-2407080146

On Mon, Jul 08, 2024 at 09:07:24PM +0200, Borislav Petkov wrote:
> On Mon, Jul 08, 2024 at 08:17:43PM +0200, Ard Biesheuvel wrote:
> > Happy to assist, but I'm not sure I follow the approach here.
> > 
> > In the context of a confidential VM, I don't think the page fault
> > handler is ever an acceptable approach. kexec should filter out config
> > tables that it doesn't recognize, and map the ones that it does (note
> > that EFI config tables have no standardized header with a length, so
> > mapping tables it does *not* recognize is not feasible to begin with).
> > 
> > All these games with on-demand paging may have made sense for 64-bit
> > kernels booting in 32-bit mode (which can only map the first 4G of
> > RAM), but in a confiidential VM context with measurement/attestation
> > etc I think the cure is worse than the disease.
> 
> See upthread. I think this is about AMD server machines which support SEV
> baremetal and not about SEV-ES/SNP guests which must do attestation.
> 
> Steve?

Yes, this is about AMD machines which support SEV, running bare metal.
("Server" is in question, one of my testers is known to be using a
laptop, so the facilities must be present in non-servers as well.)

> AFAIR, there was some kink that we have to parse the blob regardless which
> I didn't like either but I'd need to refresh with Tom and see whether we can
> solve it differently after all. Perhaps check X86_FEATURE_HYPERVISOR or so...
> 
> Thx for offering to help still - appreciated! :-)

You asked me to imagine if the one-liner had worked.  Yes, it would
have been a magical, easy fix!  But things should be as simple as
possible, but no simpler, and that solution is "simpler than
possible".

As far as I can see it, the effort you're putting into finding a
different solution must mean you find something less than desirable
about the solution I have offered.  But at this point, I don't
understand why; and lacking that understanding, I'm powerless to help
find alternatives that would be more acceptable.

Having kexec place these portions in the identity map before jumping
to the new kernel more closely mimics the conditions we are under when
entered from the BIOS and bootloader.  So it seems to me to be the
logical way to go.

Thanks,

--> Steve

-- 
Steve Wahl, Hewlett Packard Enterprise

