Return-Path: <linux-kernel+bounces-246126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF9C092BDD8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 17:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D21631C2205C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 15:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD0919CCFE;
	Tue,  9 Jul 2024 15:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="hwcbQVhL"
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC24364AB
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 15:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.143.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720537743; cv=none; b=HqjWDtytUvq0A+J7JqYZi393VZ/+vPeY/zhL1Dz48+/te7E/l7wRWmR4tlk5DCPmD0kCxOiJPopEUkM5FUd7uWI7EoIyyM5MDTjDV9Mkfrs4UBI8ZHMXEWQEOPQ9Y0VWFE/QzxJ54SXniMhvubjAeWSFQQJrbE70FM0mgwj8h6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720537743; c=relaxed/simple;
	bh=ARWgJgSVMvfRKaq7gILKEe9d/d+dOgJf2X3do9RlQ7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ne4BfblrBrbE0vHVMig3Fj2eV9cO4NQjlxuti0AqnpA5sgs5m4z6z9STUdtnBYQzbFDaOMYxJ0aNvM/2zpKaVAtw2/d0vdhlNkXLx3GrajVs3OOhGWLccx0fXRh+64xzixp2e0vuc9S8APSXZ1V9KM8nyhb2ce5oWP/4tltQeds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=hwcbQVhL; arc=none smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134423.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 469D38V0014424;
	Tue, 9 Jul 2024 15:07:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pps0720; bh=XBbugEwSm7aqeaT41Tr29EK
	RuB+6EebZt+Dw6pA9kzo=; b=hwcbQVhLtEg6gTEpmCYI/JBfjJQbFsxw19fOi5Y
	yOTYdDh0kh72rFUCOeg3xqh9DOgoRL59EcUOfecVeH7c/xs+DfbGhqldREbwJ16j
	P3cB3dMDRgePy9K38J6JmM3EcgKb1OMS7T0DavtRqOt17o9MHOLrhDS8tnN0Dzbf
	r+9ARukdXs/U24LIYHWK02Wgxj0pi3Ac+H4ibCYeVa+bddeMXOkoYTMEamEtgtI1
	WV/MKn2gDI+HdZNvWwE+QCmivewp/d0Kg4wjkkWNWRY7uM2d04mMLseaZESkF2NG
	BVBdQB/cwj1m1dpWU26u/iJBcsNGtQ4CYdagThN9P7UsqDQ==
Received: from p1lg14881.it.hpe.com ([16.230.97.202])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 4095n296wf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 15:07:57 +0000 (GMT)
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 3F1F38059F2;
	Tue,  9 Jul 2024 15:07:56 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [16.231.227.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTPS id E352D80161F;
	Tue,  9 Jul 2024 15:07:50 +0000 (UTC)
Date: Tue, 9 Jul 2024 10:07:48 -0500
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
Message-ID: <Zo1SRIZEhveMwSPX@swahl-home.5wahls.com>
References: <20240708181133.GHZowr1eznPqgvdtRw@fat_crate.local>
 <CAMj1kXG8hZ86BFbar9S5mmvKMH4a0XF0oCm36WwZxYNqc0+pjQ@mail.gmail.com>
 <20240708190724.GIZow47G0J8vO6J3ee@fat_crate.local>
 <Zow-AXsLHjU6gfET@swahl-home.5wahls.com>
 <20240708195810.GKZoxE0pRWHEUljjnQ@fat_crate.local>
 <ZoxOt1_w7nblRQCv@swahl-home.5wahls.com>
 <CAMj1kXGA8zG95WutMgVgeb-M7oQKJrVO6QWNzLi1GMuj1wq=bg@mail.gmail.com>
 <ZoxX9mckeu046zed@swahl-home.5wahls.com>
 <CAMj1kXE5OYTxxBEO38dRyYt_J1FNpU-tdkaU8rxvrMLd_k_beg@mail.gmail.com>
 <20240709103742.GCZo0S9md7YyeevRN-@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709103742.GCZo0S9md7YyeevRN-@fat_crate.local>
X-Proofpoint-GUID: kPxHdGZfeB7wTZBBMbdGcPnlsYTYKy4r
X-Proofpoint-ORIG-GUID: kPxHdGZfeB7wTZBBMbdGcPnlsYTYKy4r
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_04,2024-07-09_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 suspectscore=0 spamscore=0 priorityscore=1501 mlxlogscore=903 phishscore=0
 bulkscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2407090099

On Tue, Jul 09, 2024 at 12:37:42PM +0200, Borislav Petkov wrote:
> On Tue, Jul 09, 2024 at 08:49:43AM +0200, Ard Biesheuvel wrote:
> > > Patch #2 adds the CC blob to the identity map as well, if present,
> > > since if present it is also dereferenced before the page fault handler
> > > can be put into place.  Given what's been discussed, this patch might
> > > not be necessary; I don't know enough to say whether kexec-ing a new
> > > kernel within a SEV guest makes sense.  I'm pretty certain it can
> > > cause no harm, though.
> 
> No, keep it in the bag until it is really needed. No proactive "fixing".
> 
> > I'd prefer it if that is addressed within the context of the SEV guest
> > work. The memory setup is quite intricate, and dealing with individual
> > types of EFI config tables is something we should avoid in general. I
> > still maintain that the best approach would be to map all of DRAM 1:1
> > instead of mapping patches left and right (as this is what EFI does),
> > but if we need to do so, let's keep it as generic as we possibly can.
> 
> Sure. There's the kink that coco guests need to accept memory first and
> mapping it all is the least performant one. But we can deal with that later.
> 
> > I wasn't cc'ed on any of the patches so I don't know exactly what was
> > discussed.
> > 
> > Please cc me and linux-efi@ on your next revision.
> 
> And please update your commit messages with what was discussed on this thread.
> 
> Thx.

Thanks, Boris.  I'll give it my best shot.

Next version will leave out the current patch #2, and update the
comments to include this conversation somehow summarized.

I think perhaps the cover letter was also too verbose on the history
and unintentionally hid the information necesary to understand the
situation.  I will try to make it more concise.

--> Steve


-- 
Steve Wahl, Hewlett Packard Enterprise

