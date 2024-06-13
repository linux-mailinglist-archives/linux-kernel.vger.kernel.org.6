Return-Path: <linux-kernel+bounces-213630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA341907817
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 18:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 949BEB2465A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 16:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3514145B03;
	Thu, 13 Jun 2024 16:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="Wl2lmBsW"
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3205912F386
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 16:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.147.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718295492; cv=none; b=dcTtuHXFxz6JfJ6WQU7/Pu569pVjWEoVthFcWP/V6dQe+Q3e59d4gI/RrFBEbfD79BcS3G2Q8TsF/ASu8+SdNXA/4RXBBc6EHDITcdG+GQ5mdsOGJo6ZXEzLBNXciIc3/9o5FDNSWRNhk6I84mzpcsR27VOSOY+mgwio/Ld9+Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718295492; c=relaxed/simple;
	bh=iBM4pmUdvLp0wJE+5dcbsfYPkB5DnRjbzC1GW3wslw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CHc+tMTQJu2RlgFq0ufobpZYyxapp1bR9p95QBgObjT/zCCXWL+H4vn0T5CKPPnWHleNU8PB36N5IsV2e0U3BMNnPuyMWq7Ys0T63GG0JggIINWaIYhCg2VqE1ePGQlsr6ajOvCw5Qh169vLeLjoKRHdAFhVkfRXQdPWLhMgPUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=Wl2lmBsW; arc=none smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
	by mx0a-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 45DFWE6Y015627;
	Thu, 13 Jun 2024 16:16:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc : content-type : date
 : from : in-reply-to : message-id : mime-version : references : subject :
 to; s=pps0720; bh=Y3rT6DLE+dHOJaRI2CdWBzq1y0u3tAjCK1Syhh5F3Ng=;
 b=Wl2lmBsWmxvHwWIsAIoowr2ZAJCWzDS1SnpWYBC1OLSCD1QklXjJx1XCWlHv46NJXtTL
 Jv1Le2U+sM3MnlhnzX8cfSCiwrIMcX/g2fDZnINYwzM5KEQWXVmmkTsUblttQuXikOKs
 egpD2kZf/4pDrdGEGztu3wmQNWFeAEzNJYhpjTUkkQw3kWBZRTOLXvOhAhhr5q603UjA
 n5SsgL7wy6TR+z4ehrsDJ6YKBsYUbmjtDfLaQ4reUQF6ElNbsWWuGqrs05Mjus5U3UaH
 6CY4u5jNmxDNWp8p7pka0ilYRqCh9AaQ31i/9A/CjKpcJryf22b3EErj9PfIcu4pAoW3 QQ== 
Received: from p1lg14879.it.hpe.com ([16.230.97.200])
	by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3yr1yxha3y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 16:16:48 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14879.it.hpe.com (Postfix) with ESMTPS id C80C2147AA;
	Thu, 13 Jun 2024 16:16:44 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [16.231.227.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTPS id C7DC6809D02;
	Thu, 13 Jun 2024 16:16:38 +0000 (UTC)
Date: Thu, 13 Jun 2024 11:16:36 -0500
From: Steve Wahl <steve.wahl@hpe.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Steve Wahl <steve.wahl@hpe.com>, Ashish Kalra <ashish.kalra@amd.com>,
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
Message-ID: <ZmsbZCF9rFzuB3rO@swahl-home.5wahls.com>
References: <20240520183633.1457687-1-steve.wahl@hpe.com>
 <20240613152826.GKZmsQGnO3OthLH3Vu@fat_crate.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613152826.GKZmsQGnO3OthLH3Vu@fat_crate.local>
X-Proofpoint-GUID: iau639vRooRc3lIOREaNeZ5DNksGBcka
X-Proofpoint-ORIG-GUID: iau639vRooRc3lIOREaNeZ5DNksGBcka
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-13_09,2024-06-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0 adultscore=0
 malwarescore=0 impostorscore=0 phishscore=0 clxscore=1011 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406130115

On Thu, Jun 13, 2024 at 05:28:56PM +0200, Borislav Petkov wrote:

Thank you for at least saying something on this!

> On Mon, May 20, 2024 at 01:36:30PM -0500, Steve Wahl wrote:
> > Although there was a previous fix to avoid early kernel access to the
> > EFI config table on Intel systems, the problem can still exist on AMD
> > systems that support SEV (Secure Encrypted Virtualization).  The
> > command line option "nogbpages" brings this bug to the surface.  And
> > this is what caused the regression with my earlier patch that
> > attempted to reduce the use of gbpages.  This patch series fixes that
> > problem and restores my earlier patch.
> > 
> > The following 2 commits caused the EFI config table, and the CC_BLOB
> > entry in that table, to be accessed when enabling SEV at kernel
> > startup.
> > 
> >     commit ec1c66af3a30 ("x86/compressed/64: Detect/setup SEV/SME features
> >                           earlier during boot")
> >     commit c01fce9cef84 ("x86/compressed: Add SEV-SNP feature
> >                           detection/setup")
> > 
> > These accesses happen before the new kernel establishes its own
> > identity map, and before establishing a routine to handle page faults.
> > But the areas referenced are not explicitly added to the kexec
> > identity map.
> > 
> > This goes unnoticed when these areas happen to be placed close enough
> > to others areas that are explicitly added to the identity map, but
> > that is not always the case.
> > 
> > Under certain conditions, for example Intel Atom processors that don't
> > support 1GB pages, it was found that these areas don't end up mapped,
> > and the SEV initialization code causes an unrecoverable page fault,
> > and the kexec fails.
> 
> What does Intel Atom have to do with SEV?!

The Atom was the prominent example of a platform that the code
introduced for SEV broke.  Unfortunately, the fix currently
implemented leaves things still broken for actual AMD SEV capable
processors when nogbpages is used, and this problem is the reason for
the apparent regression when my reduce-use-of-gbpages patch was
accepted (later removed).

Tau Liu's original patch fixed this problem, but was not accepted.
The patch that was accepted does not fix this.

> > Tau Liu had offered a patch to put the config table into the kexec
> > identity map to avoid this problem:
> > 
> > https://lore.kernel.org/all/20230601072043.24439-1-ltao@redhat.com/
> > 
> > But the community chose instead to avoid referencing this memory on
> > non-AMD systems where the problem was reported.
> > 
> >     commit bee6cf1a80b5 ("x86/sev: Do not try to parse for the CC blob
> >                           on non-AMD hardware")
> > 
> > I later wanted to make a different change to kexec identity map
> > creation, and had this patch accepted:
> > 
> >     commit d794734c9bbf ("x86/mm/ident_map: Use gbpages only where full GB page should be mapped.")
> > 
> > but it quickly needed to be reverted because of problems on AMD systems.
> > 
> > The reported regression problems on AMD systems were due to the above
> > mentioned references to the EFI config table.  In fact, on the same
> > systems, the "nogbpages" command line option breaks kexec as well.
> > 
> > So I resubmit Tau Liu's original patch that maps the EFI config
> > table, add an additional patch by me that ensures that the CC blob is
> > also mapped (if present), and also resubmit my earlier patch to use
> > gpbages only when a full GB of space is requested to be mapped.
> > 
> > I do not advocate for removing the earlier, non-AMD fix.  With kexec,
> > two different kernel versions can be in play, and the earlier fix
> > still covers non-AMD systems when the kexec'd-from kernel doesn't have
> > these patches applied.
> > 
> > All three of the people who reported regression with my earlier patch
> > have retested with this patch series and found it to work where my
> > single patch previously did not.  With current kernels, all fail to
> > kexec when "nogbpages" is on the command line, but all succeed with
> > "nogbpages" after the series is applied.
> > 
> > Tao Liu (1):
> >   x86/kexec: Add EFI config table identity mapping for kexec kernel
> > 
> > Steve Wahl (2):
> >   x86/kexec: Add EFI Confidential Computing blob to kexec identity
> >     mapping.
> >   x86/mm/ident_map: Use gbpages only where full GB page should be
> >     mapped.
> > 
> >  arch/x86/kernel/machine_kexec_64.c | 82 ++++++++++++++++++++++++++++--
> >  arch/x86/mm/ident_map.c            | 23 +++++++--
> >  2 files changed, 95 insertions(+), 10 deletions(-)
> 
> Anyway, + Ashish who's been dealing with SNP kexec. We have identified one EFI
> issue so far:
> 
> https://lore.kernel.org/r/20240612135638.298882-2-ardb%2Bgit@google.com
> 
> You could give it a try and report back.

I will look at it, but a cursory inspection doesn't show anything
that affects what I'm talking about here.

Thanks!

--> Steve

-- 
Steve Wahl, Hewlett Packard Enterprise

