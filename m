Return-Path: <linux-kernel+bounces-227492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5061915229
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 17:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5191B1F233EE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 15:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8BB519B58E;
	Mon, 24 Jun 2024 15:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="OhsgcwMa"
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD45D1DFEA
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 15:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.143.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719242702; cv=none; b=WauW0Cm/ifuUzNrX7659FcKrGpzfdPRcK950qEL4wTusPGaFwDmwIsbP34mR3njda6Fm5WraFZWxP2txBMwTxtTITLLpMk/cOS4avl8kXOMDJPKdRcCj9yEObVGpeCqxkkN+z4JQ6jJQ1kpvpr0mrBo6dZScv6CfT/rFy4Mcswk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719242702; c=relaxed/simple;
	bh=QCgAlC1aaGN2oVYXqdYGcjyUVE3lYRWM6mEXqoXJrxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eiOTxLlyYKlRYmN8ryaM3cKCNMq4qqr8TUmWtN2XrlySCDX2nPmpMhI26vJGS36OwyuCadMK5hO2kZU3N7YPD2GD4BrXNAuAR8NjVV8IH5sQm7xwjLQqMnMug78frIV7RZkeij9wsTV0+VoaWVZjuLqxbrVSNc0ds+u9qIohhU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=OhsgcwMa; arc=none smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134423.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45OEYcen010772;
	Mon, 24 Jun 2024 15:10:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pps0720; bh=uopFDU2iJ62YUUUJx/OTpJh
	QWPfqzYlpZdZMUxXMgJM=; b=OhsgcwMaKMG+Ln8vjhmSYCQqixNYtBTvBTStHqi
	me1K/uow8/otOS466WxaMV0QDCCMHL/SkqWzuXQaiL+A2QcJflEeb9E/aF6Gx6hA
	2NqefaIzPw1emN+5uygPUaXzYHB0gg+jyu1pmATYVjxCu8Z3Ku/jZZwVuB6dCBHe
	qjzxuLwiulg2jZ14oSYujZZaHpByO0o+C8PaV2BtBBip22nQoSwi0vfTBBdms8ID
	zemH9D+mheNB7lTf1cdw874+Um/63nZ4eJh6nJz8DUcv+iuTRuGRgiuxXhwbMcn4
	AoJfaJ51yDav5w9GkAE3t2necJNs23Mw4+Viu9P8rS+tU+A==
Received: from p1lg14878.it.hpe.com ([16.230.97.204])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3yyape8aam-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 15:10:53 +0000 (GMT)
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 111DD12E93;
	Mon, 24 Jun 2024 15:10:52 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [16.231.227.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTPS id 53A77801FDF;
	Mon, 24 Jun 2024 15:10:46 +0000 (UTC)
Date: Mon, 24 Jun 2024 10:10:44 -0500
From: Steve Wahl <steve.wahl@hpe.com>
To: "Kalra, Ashish" <ashish.kalra@amd.com>
Cc: Borislav Petkov <bp@alien8.de>, Steve Wahl <steve.wahl@hpe.com>,
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
Message-ID: <ZnmMdEWDtRIqpZ5T@swahl-home.5wahls.com>
References: <20240520183633.1457687-1-steve.wahl@hpe.com>
 <20240613152826.GKZmsQGnO3OthLH3Vu@fat_crate.local>
 <ZmsbZCF9rFzuB3rO@swahl-home.5wahls.com>
 <20240616202533.GDZm9KPZtpDKw5aXWX@fat_crate.local>
 <ZnBR6MgS-jzjgA8A@swahl-home.5wahls.com>
 <20240621131742.GEZnV9dn_0XVH0IZ58@fat_crate.local>
 <40ed4296-e9ef-423d-a40b-889334eebcd4@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40ed4296-e9ef-423d-a40b-889334eebcd4@amd.com>
X-Proofpoint-ORIG-GUID: 5Nf7cJPjgEdKu_1LXKWnUv5kJN65AvMF
X-Proofpoint-GUID: 5Nf7cJPjgEdKu_1LXKWnUv5kJN65AvMF
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-24_11,2024-06-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 phishscore=0 clxscore=1015 mlxlogscore=999 impostorscore=0
 adultscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406240121

On Fri, Jun 21, 2024 at 02:41:35PM -0500, Kalra, Ashish wrote:
> On 6/21/2024 8:17 AM, Borislav Petkov wrote:
> 
> > On Mon, Jun 17, 2024 at 10:10:32AM -0500, Steve Wahl wrote:
> >> The first, hardest step is locate a system that is AMD based, SEV
> >> capable, with a BIOS that chooses to locate the CC_BLOB at addresses
> >> that do not share a 2M page with other chunks of memory the kernel
> >> currently adds to the kexec identity map. I.e. This is a stroke of
> >> luck,
> > Ya think?
> >
> > It is more likely that I win the lottery than finding such a beast. ;-\
> >
> >> and for all I know could depend on configuration such as memory
> >> size in addition to motherboard and BIOS version.  However, it does
> >> not seem to change from boot to boot; as system that has the problem
> >> seems to be consistent about it.
> >>
> >> Second, boot linux including the "nogbpages" command line option.
> >>
> >> Third, kexec -l <kernel image> --append=<command line options>
> >> --initrd=<initrd>.
> >>
> >> Fourth, kexec -e.
> >>
> >> Systems that have this problem successfully kexec without the
> >> "nogbpages" parameter, but fail and do a full reboot with the
> >> "nogbpages" parameter.  
> >>
> >> I wish I could be more exact,
> > Yes, this doesn't really explain what the culprit is.
> >
> > So, your 0th message says:
> >
> > "But the community chose instead to avoid referencing this memory on
> > non-AMD systems where the problem was reported.
> >
> >     commit bee6cf1a80b5 ("x86/sev: Do not try to parse for the CC blob
> >                           on non-AMD hardware")"
> >
> > But that patch fixes !AMD systems.
> >
> > Now you're basically saying that there are some AMD machines out there where
> > the EFI config table doesn't get mapped because it is somewhere else, outside
> > of the range of a 2M page or 1G page.
> >
> > Or even if it is, "nogbpages" supplied on the cmdline would cause the
> > "overlapping 2M and 1G mapping to not happen, leaving the EFI config table
> > unmapped.
> 
> From the instructions to reproduce this issue, it looks it is only reproducible on some AMD systems with the "nogbpages" parameter supplied on the kexec-ed kernel's command line, so supplying "nogbpages" is essential to reproduce this, but then "nogbpages" as mentioned makes sense on Atom processors mainly and those are already safe due to the following commit/patch:
> 
> commit bee6cf1a80b5 ("x86/sev: Do not try to parse for the CC blob
>                           on non-AMD hardware")
> 
> The question is why would you want to use "nogbpages" on AMD systems and then find one of this system which does not have EFI config table mapped as it is outside the range of a 2M or 1G page.

"nogbpages" uses 2M pages exclusively and illustrates the same problem
that would/did surface with patch #3 that uses a combination of 2M and
1G pages.  This is the source of the regression that caused patch #3
to be reverted after it previously got into the mainline.

I'm not sure there is currently a reason to use it other than this
illustration.  If a reason to use it did arise, though, you would hit
this problem.

Thanks,

--> Steve Wahl

-- 
Steve Wahl, Hewlett Packard Enterprise

