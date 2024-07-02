Return-Path: <linux-kernel+bounces-238256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 376CC924786
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 20:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3EC9281BB0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 18:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E841C8FA9;
	Tue,  2 Jul 2024 18:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="Eg8QhUEe"
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137A77442F
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 18:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.147.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719946084; cv=none; b=isg30I01r+BNzcMHMkqGB+tEgHD/Ag5DwmFYaqXVq1ZMs24GUYnhwqpwCq+6VYYF7IVwFAEbM4ZJf/GyeBPCS1ypgaiDEdjGLNmS1rEe8k92mGcWoxSFCMX2ePI1kpm4E8ywfOzG56cbdrNw1rb0R8ud+KmoeV9QR1FRyABqfnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719946084; c=relaxed/simple;
	bh=6mPeGExdB8g59kIomkdxZxbeb+RUp33J6ZRmTyUtha0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V4BNmpozIQo/4S4TrjMKVZeXkMKETvnjXKLvh23KiDJNj/IGF9uUKssy5Q8ExM5eMdkDuHaOGtf4Tr6+WNuRUfzRAiNA99U/VqLiJ15plGUBu5IVywFt9dty/PMM+Uy4zsF/ymjh3gTtf/4yw74wDhdE90tObTTGI4cm70FtiW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=Eg8QhUEe; arc=none smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
	by mx0a-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 462Fi2fM031853;
	Tue, 2 Jul 2024 18:46:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pps0720; bh=cZHI3o5vijwEP2GKNej30tD
	g/paC0ciSdKQjouzo7JA=; b=Eg8QhUEe2hpdluShBQog/yynoCrYRtUqwn/vNrU
	EOIWqf7dJTIH7FEWDB6G//0Y7STrRN1te2zpzXax7xbkp37sLSHAMjjEVMPy8BPd
	y5NTZkcSj14J5yFjquZ/0TnMs5ITvg3Uy5exfVCWBClGSZVwrGkjHn7fnGEtvBAM
	R4FiCp0X43RiNqoPwjezbDQz51gVsjMUfpJoLRyLhZ+5skY9XQDfVts0D6HpRBPG
	d2VNwPtfGctYuagKEkMI+57mQOD7+BzgTy0ll9Gj5YUnOcLcb7nHuhPNbEEUbQbK
	wj28TcyZ0LxT0LtxFVDb1hdxAG9V7QkXUQnitYtfjXs/mjw==
Received: from p1lg14879.it.hpe.com ([16.230.97.200])
	by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 404mer1gft-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jul 2024 18:46:53 +0000 (GMT)
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14879.it.hpe.com (Postfix) with ESMTPS id C896A147A9;
	Tue,  2 Jul 2024 18:46:52 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [16.231.227.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTPS id 8B592800465;
	Tue,  2 Jul 2024 18:46:46 +0000 (UTC)
Date: Tue, 2 Jul 2024 13:46:44 -0500
From: Steve Wahl <steve.wahl@hpe.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>, Steve Wahl <steve.wahl@hpe.com>,
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
Message-ID: <ZoRLFI60Z0n8lwEf@swahl-home.5wahls.com>
References: <20240520183633.1457687-1-steve.wahl@hpe.com>
 <20240613152826.GKZmsQGnO3OthLH3Vu@fat_crate.local>
 <ZmsbZCF9rFzuB3rO@swahl-home.5wahls.com>
 <20240616202533.GDZm9KPZtpDKw5aXWX@fat_crate.local>
 <ZnBR6MgS-jzjgA8A@swahl-home.5wahls.com>
 <20240621131742.GEZnV9dn_0XVH0IZ58@fat_crate.local>
 <ZnmNKAE5qT48yhrI@swahl-home.5wahls.com>
 <20240701142704.GGZoK8uDt-2VVtclHl@fat_crate.local>
 <20240702174425.GHZoQ8edlTfB1falcO@fat_crate.local>
 <CAMj1kXGsjU5CpF655me1XNA8-5nbk3020vT2Bu5ZoFY25igovg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXGsjU5CpF655me1XNA8-5nbk3020vT2Bu5ZoFY25igovg@mail.gmail.com>
X-Proofpoint-ORIG-GUID: 22z0Bj_lK-Qn4x7J03Y2jLoLD860Nvhh
X-Proofpoint-GUID: 22z0Bj_lK-Qn4x7J03Y2jLoLD860Nvhh
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-02_14,2024-07-02_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 mlxlogscore=740 adultscore=0 impostorscore=0 mlxscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 phishscore=0 suspectscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407020136

On Tue, Jul 02, 2024 at 08:32:22PM +0200, Ard Biesheuvel wrote:
> On Tue, 2 Jul 2024 at 19:45, Borislav Petkov <bp@alien8.de> wrote:
> >
> > On Mon, Jul 01, 2024 at 04:27:04PM +0200, Borislav Petkov wrote:
> > > On Mon, Jun 24, 2024 at 10:13:44AM -0500, Steve Wahl wrote:
> > > > These accesses are a problem because they happen prior to establishing
> > > > the page fault interrupt handler that would mend the identity map.  I
> > > > know very little about the AMD SEV feature but reading the code I
> > > > think it may be required to do this before setting up that handler.
> > >
> > > Yeah, from looking at it, we should be able to establish a #PF handler that
> > > early too but the devil's in the detail, especially in that early boot code.
> > >
> > > Lemme poke some things and people...
> >
> > Ard, from EFI perspective and boot services exiting, do you see any potential
> > issues if we enable a pagefault handler in load_stage1_idt() in
> > arch/x86/boot/compressed/head_64.S already or is the EFI pagetable not really
> > "reliable" then?
> >
> 
> For the first boot, this shouldn't be needed - EFI maps all of RAM so
> I wouldn't expect the PF handler to fire, except when writing to code
> regions that were mapped ROX by the firmware. But even then, things
> should just keep working, although from a security pov, it would be
> better if the r/o regions remain r/o

We are looking at entering from kexec, and the identity map is not
completely filled in with all available RAM, especially if you use
smaller 2M pages to create the identity map.

Patches 1 and 2 are aiming to fill in the parts of the map we
potentially use before the page fault handler is established.

(And my overall problem is kexec creating the identity map with 1G
pages includes areas that are marked "reserved" by the BIOS, causing a
halt when speculatively accessed.  This is what patch 3 addresses.)

> > Would solve the issue in this thread where the EFI config table ends up not
> > mapped on some hw configurations, elegantly...
> >
> 
> The #PF handler makes sense when entering via the 32-bit entrypoint,
> where the asm can only map the lower 4G and is in no position to
> reason about where RAM lives.
> 
> For kexec on a 64-bit system, I would expect the high-level support
> code to be capable of simply mapping all of DRAM 1:1, rather than
> playing these games with #PF handlers and on-demand mapping.

Currently the identity map is selectively created, and at least
from my point of view, patches 1 and 2 add in some parts that are
missed and also not covered by #PF handlers.

--> Steve

-- 
Steve Wahl, Hewlett Packard Enterprise

