Return-Path: <linux-kernel+bounces-244872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A1992AAB1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 22:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 526AFB21896
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 20:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563B23BBFB;
	Mon,  8 Jul 2024 20:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="O5FOt4Yr"
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0CDA29
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 20:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.143.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720471307; cv=none; b=DrsMWrISefUQTVX41Dag8ubVEDUtlV8sJC6t9I+F6bkPcv3xknsZAlJKiUQzdMFuFH2U4qwFzlzLzQOVM4o9QblGXylTHnr6UNdH5TEsdaNNzU21CGubho0bYKbEE0kB5wmCrEU1/UzeRVe138Wd8Bnki3RuzvhIKjkTHqAQaF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720471307; c=relaxed/simple;
	bh=DdrLdtglAkeD6cIc/nDxIUEOxeRx0RiArlCjpgWkJJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CNx6J47UmQmErpkMBXQqfaCXyeJxXCw7ze4G8CiG0YMDpfco8eFSqabfan/89Kvsw/Lji7eunbl3UJbwDjO/yGzRzrdpboy+QI3coYiAJueEsVcDzqinyne7l8tVhMg67NLTkxx92wHyn/yK8VNzFvfsHow+NhjwqXGqXKJBfv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=O5FOt4Yr; arc=none smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 468DTfaJ002800;
	Mon, 8 Jul 2024 20:40:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pps0720; bh=Wryz8cVauU8kpZrTA6THDJw
	gY9TKlykCHdTX+MDLbYk=; b=O5FOt4Yr5TuuztZm3xksJP6U6DcFc+OXhiXIrbO
	F4woUWPwKxfBXlISvDnQqxuuG/1kmqOIjqVxsVfwHH0yiXxgx8qKu9c899kLqvgQ
	87pt+wOsR9xZjfi1qS0qjX0dmOoQqHAlUi264qVnSs0fM3kuGBGl4jxgDPD3Wg/z
	Iv/Tv2TNuMe1XfCzoGXGwtN+OAE39AV5DP3XRLd2K9RjISDBA+U91215Thx9p+jl
	6DIO5P/pyELh6zRvip1nWK8wfhQSphyVXidV9fO1KMrbpSzHHiqDm4l0xaZ/fFjE
	XEyBGanzezHPXdoO8I1QOzmaJ/8LHEYll5IA+50rPNdnDOw==
Received: from p1lg14879.it.hpe.com ([16.230.97.200])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 408h1s332w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jul 2024 20:40:31 +0000 (GMT)
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 08BB9147A9;
	Mon,  8 Jul 2024 20:40:30 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [16.231.227.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTPS id 0C18B801632;
	Mon,  8 Jul 2024 20:40:25 +0000 (UTC)
Date: Mon, 8 Jul 2024 15:40:23 -0500
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
Message-ID: <ZoxOt1_w7nblRQCv@swahl-home.5wahls.com>
References: <20240701142704.GGZoK8uDt-2VVtclHl@fat_crate.local>
 <20240702174425.GHZoQ8edlTfB1falcO@fat_crate.local>
 <CAMj1kXGsjU5CpF655me1XNA8-5nbk3020vT2Bu5ZoFY25igovg@mail.gmail.com>
 <20240703154301.GEZoVxhREtHjk0vtaL@fat_crate.local>
 <ZowI9w7huVfcKJ7I@swahl-home.5wahls.com>
 <20240708181133.GHZowr1eznPqgvdtRw@fat_crate.local>
 <CAMj1kXG8hZ86BFbar9S5mmvKMH4a0XF0oCm36WwZxYNqc0+pjQ@mail.gmail.com>
 <20240708190724.GIZow47G0J8vO6J3ee@fat_crate.local>
 <Zow-AXsLHjU6gfET@swahl-home.5wahls.com>
 <20240708195810.GKZoxE0pRWHEUljjnQ@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240708195810.GKZoxE0pRWHEUljjnQ@fat_crate.local>
X-Proofpoint-ORIG-GUID: 3UtVdO8RmUKE6dHzegv-r9CA0ngS2dJB
X-Proofpoint-GUID: 3UtVdO8RmUKE6dHzegv-r9CA0ngS2dJB
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-08_11,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=877 impostorscore=0 mlxscore=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2407080153

On Mon, Jul 08, 2024 at 09:58:10PM +0200, Borislav Petkov wrote:
> On Mon, Jul 08, 2024 at 02:29:05PM -0500, Steve Wahl wrote:
> > Yes, this is about AMD machines which support SEV, running bare metal.
> > ("Server" is in question, one of my testers is known to be using a
> > laptop, so the facilities must be present in non-servers as well.)
> 
> No, they can't be. SEV is supported only on server, not on client. This laptop
> has a different problem it seems.

Ahhh.  On the laptop, it's not looking *at* the CC blob that's the
problem.

Its looking *for* the CC blob in the EFI config table; the CC blob
probably does not exist in that table on the laptop.  But the EFI
config table needs to be identity mapped, to look through it and see
that the CC blob is not there, and the EFI config table is not mapped.

I think the existence of the CC blob in the EFI config table is being
used, more or less, as a flag as to whether we need to do SEV related
code.  Without mapping the EFI config table, we can't look for that
blob.

> > As far as I can see it, the effort you're putting into finding a
> > different solution must mean you find something less than desirable
> > about the solution I have offered.  But at this point, I don't
> > understand why;
> 
> Why would we parse the CC blob which is destined *solely* for a SEV- *guest*,
> when booting the baremetal kernel which is *not* a guest?
> 
> This is the solution I'm chasing - don't do something you're not supposed to
> or needed to do.

What you're saying suggests that, maybe, my patch #2 will not be
necessary.  The CC blob will never be present except for in a guest.
But can you do a kexec to a new kernel within that guest?  If so,
patch #2 might still be necessary.

Anyway, I think the references you're trying to eliminate when they're
not needed are the references used to determine if the SEV feature is
to be used in this specific boot iteration or not.

--> Steve
-- 
Steve Wahl, Hewlett Packard Enterprise

