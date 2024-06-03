Return-Path: <linux-kernel+bounces-199315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F48F8D856B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 16:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF1A6285086
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 14:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B14812D1F1;
	Mon,  3 Jun 2024 14:48:09 +0000 (UTC)
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5190583CCF
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 14:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.147.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717426089; cv=none; b=PiTwN/hszMyNQeAaM4B459zb2M5WZ5YWaf3ihxDNi3sbx8sBhAy+X4cfJ+Yxtyqf+KKEA4kHTdcMZ45nYqrrnvR2ihxV/y+BwHgpqM5xDCt858mi0/69S3PGAStGX23ZobXawPXGbW5J5m7GgegRCHNkAAKjNIiKNIi/jtMciig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717426089; c=relaxed/simple;
	bh=BZsuFofp5n7RypcXAhf8epD5GJ0xMO/QGZyEdcc9kyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=M4dmA7rRik0s3AIRCJNglVG4NoXBIZjmzocqq5MHeJLv+azysfqQbTmeHqZ92vH18tRKqsx6URdMa037vBJVQlef7p09EvKBDnhzzB4ySvL37kj25o0HsXVDUt5wMY3jdw/YwY7P4k9xaEkUMyT8y9vFT7yAQaMnWIpJu6LuMSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; arc=none smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
	by mx0a-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 45392knG015151;
	Mon, 3 Jun 2024 14:46:37 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Dhpe.com;_h=3Dcc?=
 =?UTF-8?Q?:content-type:date:from:in-reply-to:message-id:mime-version:ref?=
 =?UTF-8?Q?erences:subject:to;_s=3Dpps0720;_bh=3DNmDlpuCKXf+fQPySad2+w7jdj?=
 =?UTF-8?Q?lccBZGAG9LaOBq8sig=3D;_b=3DosvRC+romGvPNw2d8ZPGJm0bk9cW8W6eJTpv?=
 =?UTF-8?Q?FkQUZhNHBul2BiCoHIi2BVsgGG6FSv9B_jug224d1D5H7KkOkUYcvKUp2hfRS5p?=
 =?UTF-8?Q?24PZDF/oPvx6F2M3JtqBkJWcFx3GSlOTrr137r_znk8H9ZP1nV9ptXRfLw9J8r2?=
 =?UTF-8?Q?vWgeqXp5mcmjh9ylw2X3LV9KZlzxNWZwcavnYEQs+tMY_mKbHthov+ZecfWAO5J?=
 =?UTF-8?Q?4k++pQR6c0GMQGhsqL9FkesDxSH1go8iQWF2SDth5huSq5GY4k_uHLMwqMKs49C?=
 =?UTF-8?Q?myWoyvPKXs640gF+sxgHyYA3+u2uaTOcXBH6cnCkgqJ4psvZwXHxyO21_ng=3D?=
 =?UTF-8?Q?=3D_?=
Received: from p1lg14879.it.hpe.com ([16.230.97.200])
	by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3ygd93aby9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Jun 2024 14:46:37 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14879.it.hpe.com (Postfix) with ESMTPS id F40AA14786;
	Mon,  3 Jun 2024 14:46:35 +0000 (UTC)
Received: from dog.eag.rdlabs.hpecorp.net (unknown [16.231.227.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTPS id 01F6780170C;
	Mon,  3 Jun 2024 14:46:31 +0000 (UTC)
Date: Mon, 3 Jun 2024 09:46:07 -0500
From: Steve Wahl <steve.wahl@hpe.com>
To: Dave Young <dyoung@redhat.com>
Cc: Steve Wahl <steve.wahl@hpe.com>, Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Pavin Joseph <me@pavinjoseph.com>, Eric Hagberg <ehagberg@gmail.com>,
        Simon Horman <horms@verge.net.au>,
        Eric Biederman <ebiederm@xmission.com>, Sarah Brofeldt <srhb@dbc.dk>,
        Russ Anderson <rja@hpe.com>, Dimitri Sivanich <sivanich@hpe.com>,
        Hou Wenlong <houwenlong.hwl@antgroup.com>,
        Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>,
        Yuntao Wang <ytcoode@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
        Joerg Roedel <jroedel@suse.de>, Michael Roth <michael.roth@amd.com>,
        Tao Liu <ltao@redhat.com>, kexec@lists.infradead.org
Subject: Re: [PATCH 0/3] Resolve problems with kexec identity mapping
Message-ID: <20240603144607.GA919612@dog.eag.rdlabs.hpecorp.net>
References: <20240520183633.1457687-1-steve.wahl@hpe.com>
 <CALu+AoQGvHzkoRPvAwqaCCokOBsjQ7tDwMVwgyOMUqKm=tEkuQ@mail.gmail.com>
 <CALu+AoR_OZbrrVWL_2EbDB-ctSR28+006q+nHhwgZ55QhK0qSw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALu+AoR_OZbrrVWL_2EbDB-ctSR28+006q+nHhwgZ55QhK0qSw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-GUID: X-I2ZXp4pRs7QeN3vWlXArNg9xrmUX1T
X-Proofpoint-ORIG-GUID: X-I2ZXp4pRs7QeN3vWlXArNg9xrmUX1T
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-03_11,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 clxscore=1011 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406030122

Gentle ping.  Can someone give me some feedback, please?  

Thanks,

Steve Wahl, HPE.

On Thu, May 23, 2024 at 10:54:33AM +0800, Dave Young wrote:
> Cc kexec list as well.
> 
> On Thu, 23 May 2024 at 10:52, Dave Young <dyoung@redhat.com> wrote:
> >
> > Add Tao in the cc list.
> >
> > On Tue, 21 May 2024 at 02:37, Steve Wahl <steve.wahl@hpe.com> wrote:
> > >
> > > Although there was a previous fix to avoid early kernel access to the
> > > EFI config table on Intel systems, the problem can still exist on AMD
> > > systems that support SEV (Secure Encrypted Virtualization).  The
> > > command line option "nogbpages" brings this bug to the surface.  And
> > > this is what caused the regression with my earlier patch that
> > > attempted to reduce the use of gbpages.  This patch series fixes that
> > > problem and restores my earlier patch.
> > >
> > > The following 2 commits caused the EFI config table, and the CC_BLOB
> > > entry in that table, to be accessed when enabling SEV at kernel
> > > startup.
> > >
> > >     commit ec1c66af3a30 ("x86/compressed/64: Detect/setup SEV/SME features
> > >                           earlier during boot")
> > >     commit c01fce9cef84 ("x86/compressed: Add SEV-SNP feature
> > >                           detection/setup")
> > >
> > > These accesses happen before the new kernel establishes its own
> > > identity map, and before establishing a routine to handle page faults.
> > > But the areas referenced are not explicitly added to the kexec
> > > identity map.
> > >
> > > This goes unnoticed when these areas happen to be placed close enough
> > > to others areas that are explicitly added to the identity map, but
> > > that is not always the case.
> > >
> > > Under certain conditions, for example Intel Atom processors that don't
> > > support 1GB pages, it was found that these areas don't end up mapped,
> > > and the SEV initialization code causes an unrecoverable page fault,
> > > and the kexec fails.
> > >
> > > Tau Liu had offered a patch to put the config table into the kexec
> > > identity map to avoid this problem:
> > >
> > > https://lore.kernel.org/all/20230601072043.24439-1-ltao@redhat.com/
> > >
> > > But the community chose instead to avoid referencing this memory on
> > > non-AMD systems where the problem was reported.
> > >
> > >     commit bee6cf1a80b5 ("x86/sev: Do not try to parse for the CC blob
> > >                           on non-AMD hardware")
> > >
> > > I later wanted to make a different change to kexec identity map
> > > creation, and had this patch accepted:
> > >
> > >     commit d794734c9bbf ("x86/mm/ident_map: Use gbpages only where full GB page should be mapped.")
> > >
> > > but it quickly needed to be reverted because of problems on AMD systems.
> > >
> > > The reported regression problems on AMD systems were due to the above
> > > mentioned references to the EFI config table.  In fact, on the same
> > > systems, the "nogbpages" command line option breaks kexec as well.
> > >
> > > So I resubmit Tau Liu's original patch that maps the EFI config
> > > table, add an additional patch by me that ensures that the CC blob is
> > > also mapped (if present), and also resubmit my earlier patch to use
> > > gpbages only when a full GB of space is requested to be mapped.
> > >
> > > I do not advocate for removing the earlier, non-AMD fix.  With kexec,
> > > two different kernel versions can be in play, and the earlier fix
> > > still covers non-AMD systems when the kexec'd-from kernel doesn't have
> > > these patches applied.
> > >
> > > All three of the people who reported regression with my earlier patch
> > > have retested with this patch series and found it to work where my
> > > single patch previously did not.  With current kernels, all fail to
> > > kexec when "nogbpages" is on the command line, but all succeed with
> > > "nogbpages" after the series is applied.
> > >
> > > Tao Liu (1):
> > >   x86/kexec: Add EFI config table identity mapping for kexec kernel
> > >
> > > Steve Wahl (2):
> > >   x86/kexec: Add EFI Confidential Computing blob to kexec identity
> > >     mapping.
> > >   x86/mm/ident_map: Use gbpages only where full GB page should be
> > >     mapped.
> > >
> > >  arch/x86/kernel/machine_kexec_64.c | 82 ++++++++++++++++++++++++++++--
> > >  arch/x86/mm/ident_map.c            | 23 +++++++--
> > >  2 files changed, 95 insertions(+), 10 deletions(-)
> > >
> > > --
> > > 2.26.2
> > >
> 

