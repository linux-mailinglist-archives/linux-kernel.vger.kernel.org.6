Return-Path: <linux-kernel+bounces-227479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A749151CB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 17:16:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 388A928886D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 15:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FD019CD04;
	Mon, 24 Jun 2024 15:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="Lx0qfk5d"
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43001E868
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 15:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.143.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719242096; cv=none; b=ZVkkldiwOT0VlzFSigRj1R7nmdR5ItOj9kGr3px7Phrcw5zBk9Z6KulsRNvP8J360bN+TDL2TGzNm+4bmRw9BRztZOh6z78ZgvJjs2jVKHqgNfaNaU3YowArBCSkDCVX5SGzYwic6Md1wYJN3Q3Fj5goDzyn1/xZcTKPXGVLDQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719242096; c=relaxed/simple;
	bh=CuoOy1ii1cHDC1oCyNcHei++Uj4ZOjlT1SkHcX68MEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OoUTwxedi5PlfJxWvNszAbjynWdcxBxYRj4TMfB1M+E773EsKzFFdAL0BD5T1a8adRPgpQVqFcdPkHG0wKeWM8fcPIEAh8Uj8YDWOXwW2NibR2/1IkZX87Khoyxz4OowMBEfB/R06yV9Ei7G+fiAhUg82wpCpg6M+r9l8jNLzL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=Lx0qfk5d; arc=none smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45OC04tP006223;
	Mon, 24 Jun 2024 15:13:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pps0720; bh=UVoVfLIQz0S/jfoT/mip77x
	/qe57T1fnytTchil6afs=; b=Lx0qfk5dM/n83TkOEZldZxrYvHBcG/n00QTbI58
	ag2YqpALRB8pgbLwBbGkssS3vkI0AFmOOE7jiGrSl+1OFQc2ttgi8gjKv2xPkrKE
	CHREU4DvowP1iUZTROo7GktQR42Cuk6rvrXqhnQetv0XvY1vS2+q0COzQZnHierA
	2XX07mZGvvE2OLjP3NsOGzU9/BfQmb5hds/yypVbZS449oqv2RwlxRW6rp1n5tuG
	ByKoUYJgLVhV9WD7xCKLEfQIuwwZOfRPOOI4WcPS7S+qJ9BsNfG4EyfA51oxi9ss
	hqR4UoR4Q+whykF9PkPHLqNWtkzNHoS+cI/ovDrnY/0W0nA==
Received: from p1lg14880.it.hpe.com ([16.230.97.201])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3yy8dx1r0s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Jun 2024 15:13:53 +0000 (GMT)
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 09C1A8005F7;
	Mon, 24 Jun 2024 15:13:52 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [16.231.227.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTPS id E6CAD809741;
	Mon, 24 Jun 2024 15:13:46 +0000 (UTC)
Date: Mon, 24 Jun 2024 10:13:44 -0500
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
Message-ID: <ZnmNKAE5qT48yhrI@swahl-home.5wahls.com>
References: <20240520183633.1457687-1-steve.wahl@hpe.com>
 <20240613152826.GKZmsQGnO3OthLH3Vu@fat_crate.local>
 <ZmsbZCF9rFzuB3rO@swahl-home.5wahls.com>
 <20240616202533.GDZm9KPZtpDKw5aXWX@fat_crate.local>
 <ZnBR6MgS-jzjgA8A@swahl-home.5wahls.com>
 <20240621131742.GEZnV9dn_0XVH0IZ58@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621131742.GEZnV9dn_0XVH0IZ58@fat_crate.local>
X-Proofpoint-GUID: oZMXOPHJ_L6TAGeX3kEnaIwDz8inBnsP
X-Proofpoint-ORIG-GUID: oZMXOPHJ_L6TAGeX3kEnaIwDz8inBnsP
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-24_11,2024-06-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 mlxscore=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 adultscore=0 malwarescore=0 spamscore=0
 impostorscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2406140001 definitions=main-2406240122

On Fri, Jun 21, 2024 at 03:17:42PM +0200, Borislav Petkov wrote:
> On Mon, Jun 17, 2024 at 10:10:32AM -0500, Steve Wahl wrote:
> > The first, hardest step is locate a system that is AMD based, SEV
> > capable, with a BIOS that chooses to locate the CC_BLOB at addresses
> > that do not share a 2M page with other chunks of memory the kernel
> > currently adds to the kexec identity map. I.e. This is a stroke of
> > luck,
> 
> Ya think?
> 
> It is more likely that I win the lottery than finding such a beast. ;-\

Yes, that is the impression I was trying to impart!  :-)

> > and for all I know could depend on configuration such as memory
> > size in addition to motherboard and BIOS version.  However, it does
> > not seem to change from boot to boot; as system that has the problem
> > seems to be consistent about it.
> > 
> > Second, boot linux including the "nogbpages" command line option.
> > 
> > Third, kexec -l <kernel image> --append=<command line options>
> > --initrd=<initrd>.
> > 
> > Fourth, kexec -e.
> > 
> > Systems that have this problem successfully kexec without the
> > "nogbpages" parameter, but fail and do a full reboot with the
> > "nogbpages" parameter.  
> > 
> > I wish I could be more exact,
> 
> Yes, this doesn't really explain what the culprit is.
> 
> So, your 0th message says:
> 
> "But the community chose instead to avoid referencing this memory on
> non-AMD systems where the problem was reported.
> 
>     commit bee6cf1a80b5 ("x86/sev: Do not try to parse for the CC blob
>                           on non-AMD hardware")"
> 
> But that patch fixes !AMD systems.
> 
> Now you're basically saying that there are some AMD machines out there where
> the EFI config table doesn't get mapped because it is somewhere else, outside
> of the range of a 2M page or 1G page.

I haven't heard of one where using 1G pages doesn't include this EFI
table.  But if you switch to 2M pages using "nogbpages", that's when
you get into trouble.

(Also trouble if you switch to using some 2M pages using patch #3,
which is the point of the series.)

> Or even if it is, "nogbpages" supplied on the cmdline would cause the
> "overlapping 2M and 1G mapping to not happen, leaving the EFI config table
> unmapped.

I think so.  The EFI config table is being included by luck, not
explicitly; "nogbpages" switches to using 2M pages only, greatly
reducing the range of addresses unintentionally included in the map.
So the EFI config table doesn't end up mapped.

> Am I on the right track here?

I believe so.

Patch #3's intent is/was to reduce the amount of space unintentionally
included in the identity map, to avoid speculation into areas that
cause system halts on HPE's UV hardware.  It does so by using 1G pages
for large areas and 2M pages for smaller areas.  It should have worked
for systems in general, without being specific to UV, but when it got
into the mainline kernel, it was found to cause a regression on these
AMD systems, and was reverted.

The regression turned out to be the EFI config table not being mapped.

Patch #1 fixes this problem for the EFI config table, and patch #2
fixes it for the CC BLOB that is also likely accessed.

These accesses are a problem because they happen prior to establishing
the page fault interrupt handler that would mend the identity map.  I
know very little about the AMD SEV feature but reading the code I
think it may be required to do this before setting up that handler.

Thanks,

--> Steve

-- 
Steve Wahl, Hewlett Packard Enterprise


