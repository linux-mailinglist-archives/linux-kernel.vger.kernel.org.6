Return-Path: <linux-kernel+bounces-246115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EEA792BDB5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 17:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41A061C2293D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 15:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035A019DF46;
	Tue,  9 Jul 2024 15:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="DUMRjSom"
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A661115B999
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 15:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.147.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720537348; cv=none; b=cfDSubgpY6PiTz+05eZaFToSzuJPkGHMo+4Z0VSTRzoCNPPUyZF3w4U2P/Ccdj9fdnkedR2yGHxUQRrR4Kk41TLL/WB3DVNSWEsNeh4Tbzin6LiGyDqTun0VmLArjei4xKXr+FWuIJG1Vx9TR6yUNE0dZ/KOiWZ2nuZiKsW6F4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720537348; c=relaxed/simple;
	bh=OJG480lZbvTpw5zgJ4zuR+Ne47iJxqJ8SgW/TQh7mqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WO08rVctzVPTSxhwy9zvFQ17WOFBiLOtnBFW7mzseLbtKmWO8Ld0crAwUZZeH406cu9qw1qmFHJOKothw11+SHb8bhlg5xIPa41YPd2cb/SPg+j0gE/9fiufk2+DwmcXc6h/iV4uXVfAIq0ma7HlRdjyeEnLplkGezJEpyd4y+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=DUMRjSom; arc=none smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4697Hq8q004306;
	Tue, 9 Jul 2024 15:00:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pps0720; bh=uHELD7mdwUM8XDFKnw5XFYz
	KcmpcgxZkIp1b4Fwg7Es=; b=DUMRjSomMmFrOuy6O/SDN5b7bczuELOY4gza/vf
	0wNjtk9gqG+HmNqPCgImeIqjfGwpWLxArJ+qtnKbf/z6441vv91qEj0IdOuI/Ma/
	Aov+FO8s6ICUTUVbJCOfvrcMIE3R7p6SbC6MpDlw9VIhY2OxPdhj11NHkRW2CwIL
	a/yigzhb8dqYWjx84slbBy9vOZGqCJ6aElwNf9thsYZKJJwfP6b5ANXIDWCbzswz
	sWXkDcuakzyscb+7OU86BKf2cWwhdc5MgaCO4E93JYtTwbCrpBFoeZ1c7Au1n/HC
	zAQ9y3FWnYVWsbPlLX/qgs2WX5Rygua1QAdH3il15CR4jdA==
Received: from p1lg14878.it.hpe.com ([16.230.97.204])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 408t2dp0ey-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 15:00:42 +0000 (GMT)
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14878.it.hpe.com (Postfix) with ESMTPS id E001C12E9B;
	Tue,  9 Jul 2024 15:00:39 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [16.231.227.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTPS id 8104C802818;
	Tue,  9 Jul 2024 15:00:34 +0000 (UTC)
Date: Tue, 9 Jul 2024 10:00:32 -0500
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
Message-ID: <Zo1QkP0GQOkyrvTx@swahl-home.5wahls.com>
References: <ZowI9w7huVfcKJ7I@swahl-home.5wahls.com>
 <20240708181133.GHZowr1eznPqgvdtRw@fat_crate.local>
 <CAMj1kXG8hZ86BFbar9S5mmvKMH4a0XF0oCm36WwZxYNqc0+pjQ@mail.gmail.com>
 <20240708190724.GIZow47G0J8vO6J3ee@fat_crate.local>
 <Zow-AXsLHjU6gfET@swahl-home.5wahls.com>
 <20240708195810.GKZoxE0pRWHEUljjnQ@fat_crate.local>
 <ZoxOt1_w7nblRQCv@swahl-home.5wahls.com>
 <CAMj1kXGA8zG95WutMgVgeb-M7oQKJrVO6QWNzLi1GMuj1wq=bg@mail.gmail.com>
 <ZoxX9mckeu046zed@swahl-home.5wahls.com>
 <CAMj1kXE5OYTxxBEO38dRyYt_J1FNpU-tdkaU8rxvrMLd_k_beg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXE5OYTxxBEO38dRyYt_J1FNpU-tdkaU8rxvrMLd_k_beg@mail.gmail.com>
X-Proofpoint-ORIG-GUID: XvuyizmuUVPl8bFKtJu8WDnjyYZmHpbn
X-Proofpoint-GUID: XvuyizmuUVPl8bFKtJu8WDnjyYZmHpbn
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_04,2024-07-09_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 malwarescore=0 spamscore=0 mlxlogscore=660 phishscore=0 adultscore=0
 bulkscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407090098

On Tue, Jul 09, 2024 at 08:49:43AM +0200, Ard Biesheuvel wrote:
> On Mon, 8 Jul 2024 at 23:20, Steve Wahl <steve.wahl@hpe.com> wrote:
> >
> > On Mon, Jul 08, 2024 at 11:05:29PM +0200, Ard Biesheuvel wrote:
> > > It would be better if we did not have to rely on page fault handling
> > > to map the EFI config table array this early. This is not strictly
> > > related to SEV, but the CC blob happens to be the EFI config table
> > > that is accessed before the page fault handler is installed.
> > >
> > > So regardless of how we fix any SEV-guest specific issues, we should
> > > ensure that kexec infrastructure creates the mappings of the EFI
> > > system table and the EFI config table array upfront.
> >
> > I think that's exactly what this patch series does.
> >
> > The mapping of the EFI system table is/was already present in
> > map_efi_systab.  Patch #1 in this series adds the efi_config_table to
> > what gets mapped.
> >
> 
> Excellent. Please update the commit log to make it very clear that it
> is the EFI config table *array* (the GUID/pointer tuple list) that is
> being mapped, without any regard for the meaning of the individual
> entries.
> 
> Also, the patch seems to be lacking your signed-off-by.

I wrote in the non-permanent-comment section of that patch:

------------------------------
> I (Steve Wahl) modified the above commit message, but did not modify
> the code.  I am not clear if that requires additional Co-developed-by:
> and Signed-off-by: lines.  If so, copy them from here:
> 
> Co-developed-by: Steve Wahl <steve.wahl@hpe.com>
> Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
------------------------------

I take it you believe I should add them to the for-posterity portion
of the patch.  I will do so.

> > Patch #2 adds the CC blob to the identity map as well, if present,
> > since if present it is also dereferenced before the page fault handler
> > can be put into place.  Given what's been discussed, this patch might
> > not be necessary; I don't know enough to say whether kexec-ing a new
> > kernel within a SEV guest makes sense.  I'm pretty certain it can
> > cause no harm, though.
> >
> 
> I'd prefer it if that is addressed within the context of the SEV guest
> work. The memory setup is quite intricate, and dealing with individual
> types of EFI config tables is something we should avoid in general. I
> still maintain that the best approach would be to map all of DRAM 1:1
> instead of mapping patches left and right (as this is what EFI does),
> but if we need to do so, let's keep it as generic as we possibly can.

I understand.  It's hard to kick yourself out of proactive mode when
you're battling a problem that you can't reproduce in your own
hands. :-)

This is one reason why I kept it as a separate patch in the first
place, though.

If you will, keep in mind for the future that mapping all of DRAM 1:1,
without regards to what areas the BIOS has marked "reserved" in the
E820 tables and such, allows processor speculation into said reserved
areas, which causes system halts on our (SGI UV) platform.  Patch #3
is all about this.

Mapping all of DRAM *except* areas marked reserved would work on our
platform.

> > And patch #3 fixes the UV platform problem as discussed, which will
> > not cause the previous reported regression if patches #1 and #2 are
> > already in place.
> >
> 
> I wasn't cc'ed on any of the patches so I don't know exactly what was
> discussed.
> 
> Please cc me and linux-efi@ on your next revision.

Will do.

--> Steve
-- 
Steve Wahl, Hewlett Packard Enterprise

