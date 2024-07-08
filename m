Return-Path: <linux-kernel+bounces-244897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D7692AB1A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 23:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66594282B03
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 21:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDBA114EC51;
	Mon,  8 Jul 2024 21:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="c+dX4Ww5"
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6D71CD3D
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 21:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.147.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720473652; cv=none; b=JEMSE8P5ZEdRCMilafQjTVQjs6sEZ1Y4l3rrnZwygr75MI1+uJa5YO7Dq+x+6GGVkRTPze6AUu39vRVFnqo017kOe24dTwD7WseA020EjCpfs/0SLa+Nrlscdh2enYk9Uy5VWgFwdZ45aE/f95ZZS6pKKTdRzM3idnDENg71mwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720473652; c=relaxed/simple;
	bh=dJnYTz1ag8EQmfFSoSRPHa2Nk0g/OZkdcnp4VY+/vFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E1SyLRAysTjaVWXctMO0GSTOtAOfTsuwV7AyvfoctWEjKzIvwY31Oht85CUGQ3hzEHqZdq+1WFNDSf041ATROi3hqpaLquJwPKQ6D0GOSEKfOB7LEcqp8tcKFBU4RiX8Z8IzQKu9g3tNW01+cOew98xqDMNeBDAIVwS71VudUYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=c+dX4Ww5; arc=none smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
	by mx0a-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 468EkjZa005646;
	Mon, 8 Jul 2024 21:20:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pps0720; bh=d0OI0mJZSSL4IwjltDfuVUY
	eJXJFIC5RyBFtpQK7OmQ=; b=c+dX4Ww5/sBjd9rs485vVMe5PfaKBfM60LRgXy4
	MSSIg/77ryzfCec7eRHpp0mzzyTSZlS4etc+NECXFVRKDcpIhWqxXAM5UZPaM0Xi
	GimnVSKu6htAresLQ13ozbl29NfAMO0Gxn1uVake/SJ/2Fb3vy9niFFvGz7TnnTM
	JeyUzqJHoRHzCNEJ23ijmXyS+xwzIPhe7OXM2J9JrclCmsDF2Dg3kXAKq3kIplZ7
	FE4501q9GDD7Hgk4iI8y5WaGpoz3h0ResSEVnz/3MYLQj/37eL6zgIjajvu+k24f
	R5sZ6NCq/2pKHHpBgAbehmltwW2Dryojayu4uq/qfExVyiQ==
Received: from p1lg14879.it.hpe.com ([16.230.97.200])
	by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 408j5tamdn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jul 2024 21:20:00 +0000 (GMT)
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 9FB48147A1;
	Mon,  8 Jul 2024 21:19:56 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [16.231.227.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTPS id D8DA480283E;
	Mon,  8 Jul 2024 21:19:52 +0000 (UTC)
Date: Mon, 8 Jul 2024 16:19:50 -0500
From: Steve Wahl <steve.wahl@hpe.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Steve Wahl <steve.wahl@hpe.com>, Borislav Petkov <bp@alien8.de>,
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
Message-ID: <ZoxX9mckeu046zed@swahl-home.5wahls.com>
References: <CAMj1kXGsjU5CpF655me1XNA8-5nbk3020vT2Bu5ZoFY25igovg@mail.gmail.com>
 <20240703154301.GEZoVxhREtHjk0vtaL@fat_crate.local>
 <ZowI9w7huVfcKJ7I@swahl-home.5wahls.com>
 <20240708181133.GHZowr1eznPqgvdtRw@fat_crate.local>
 <CAMj1kXG8hZ86BFbar9S5mmvKMH4a0XF0oCm36WwZxYNqc0+pjQ@mail.gmail.com>
 <20240708190724.GIZow47G0J8vO6J3ee@fat_crate.local>
 <Zow-AXsLHjU6gfET@swahl-home.5wahls.com>
 <20240708195810.GKZoxE0pRWHEUljjnQ@fat_crate.local>
 <ZoxOt1_w7nblRQCv@swahl-home.5wahls.com>
 <CAMj1kXGA8zG95WutMgVgeb-M7oQKJrVO6QWNzLi1GMuj1wq=bg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXGA8zG95WutMgVgeb-M7oQKJrVO6QWNzLi1GMuj1wq=bg@mail.gmail.com>
X-Proofpoint-GUID: qrTtK2tngBdJtj67WDJ4y-f71hKunap-
X-Proofpoint-ORIG-GUID: qrTtK2tngBdJtj67WDJ4y-f71hKunap-
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-08_11,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 impostorscore=0 mlxscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015
 phishscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407080158

On Mon, Jul 08, 2024 at 11:05:29PM +0200, Ard Biesheuvel wrote:
> On Mon, 8 Jul 2024 at 22:41, Steve Wahl <steve.wahl@hpe.com> wrote:
> >
> > On Mon, Jul 08, 2024 at 09:58:10PM +0200, Borislav Petkov wrote:
> > > On Mon, Jul 08, 2024 at 02:29:05PM -0500, Steve Wahl wrote:
> > > > Yes, this is about AMD machines which support SEV, running bare metal.
> > > > ("Server" is in question, one of my testers is known to be using a
> > > > laptop, so the facilities must be present in non-servers as well.)
> > >
> > > No, they can't be. SEV is supported only on server, not on client. This laptop
> > > has a different problem it seems.
> >
> > Ahhh.  On the laptop, it's not looking *at* the CC blob that's the
> > problem.
> >
> > Its looking *for* the CC blob in the EFI config table; the CC blob
> > probably does not exist in that table on the laptop.  But the EFI
> > config table needs to be identity mapped, to look through it and see
> > that the CC blob is not there, and the EFI config table is not mapped.
> >
> > I think the existence of the CC blob in the EFI config table is being
> > used, more or less, as a flag as to whether we need to do SEV related
> > code.  Without mapping the EFI config table, we can't look for that
> > blob.
> >
> 
> We have run into this exact problem before - I don't have time to
> check lore right now (it's 11pm here) but 'CC blob' and 'EFI config
> table' are the keywords that may help you track down the thread.
> 
> So first of all, let's define some terminology:
> - the EFI system table is the EFI root table that contains some magic
> numbers and pointers to various other assets in memory, one of which
> is:
> - the EFI config table array, which is just a list of (GUID, pointer)
> tuples, the length of which is recorded in the EFI system table
> - an EFI config table is some asset elsewhere in memory that is
> identified by its GUID.
> 
> The EFI config table array can grow and shrink at boot time, which is
> why it is a separate allocation, as this allows it to be realloc()'ed.
> This means any bootloader that intends to map the primary EFI table
> should also map the EFI config table array, which may be elsewhere
> entirely.
> 
> > > > As far as I can see it, the effort you're putting into finding a
> > > > different solution must mean you find something less than desirable
> > > > about the solution I have offered.  But at this point, I don't
> > > > understand why;
> > >
> > > Why would we parse the CC blob which is destined *solely* for a SEV- *guest*,
> > > when booting the baremetal kernel which is *not* a guest?
> > >
> > > This is the solution I'm chasing - don't do something you're not supposed to
> > > or needed to do.
> >
> > What you're saying suggests that, maybe, my patch #2 will not be
> > necessary.  The CC blob will never be present except for in a guest.
> > But can you do a kexec to a new kernel within that guest?  If so,
> > patch #2 might still be necessary.
> >
> > Anyway, I think the references you're trying to eliminate when they're
> > not needed are the references used to determine if the SEV feature is
> > to be used in this specific boot iteration or not.
> >
> 
> It would be better if we did not have to rely on page fault handling
> to map the EFI config table array this early. This is not strictly
> related to SEV, but the CC blob happens to be the EFI config table
> that is accessed before the page fault handler is installed.
> 
> So regardless of how we fix any SEV-guest specific issues, we should
> ensure that kexec infrastructure creates the mappings of the EFI
> system table and the EFI config table array upfront.

I think that's exactly what this patch series does.

The mapping of the EFI system table is/was already present in
map_efi_systab.  Patch #1 in this series adds the efi_config_table to
what gets mapped.

Patch #2 adds the CC blob to the identity map as well, if present,
since if present it is also dereferenced before the page fault handler
can be put into place.  Given what's been discussed, this patch might
not be necessary; I don't know enough to say whether kexec-ing a new
kernel within a SEV guest makes sense.  I'm pretty certain it can
cause no harm, though.

And patch #3 fixes the UV platform problem as discussed, which will
not cause the previous reported regression if patches #1 and #2 are
already in place.

--> Steve

-- 
Steve Wahl, Hewlett Packard Enterprise

