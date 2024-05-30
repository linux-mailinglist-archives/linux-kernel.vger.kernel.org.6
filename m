Return-Path: <linux-kernel+bounces-195348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 065328D4B5B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 14:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEE5028234B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 12:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A68718509F;
	Thu, 30 May 2024 12:15:20 +0000 (UTC)
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCF9183A7C
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 12:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.147.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717071319; cv=none; b=jVE08Upz78+3IL9rMZWrEc7Cm9SMXf99qFjNRDG3YveaLRW8myvCbnPVWjzio9pOIVdLmBPZiK/XROYYRx6bds2xQp/o7M+WpqU65bfquLBXXk4McXzfoSo8l89EzJRnaIJQtNCgxFnAjetTsA95H1iRhZwvGdoioGLOLjyUlTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717071319; c=relaxed/simple;
	bh=xNsD321Wv+tqfgPAeBKoPDeYdpw+XN0+YsgsdRIznLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CgB8zImUtrlFCDZfLYVhfAgZaHvRlWscRoHRbHLnfapXU1Juh1aMl5O4tPCiip+2Mt9hWbtI6/8uI2VRVBW/kSXV170Du2WPFILW60IijQNvRxZOgc3U/3ZMlkzbk9bKRegiZkxByrvyKzPpHyzJGR7YGKmAyv4xioGb9salIlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; arc=none smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44U92r7b025608;
	Thu, 30 May 2024 12:15:01 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Dhpe.com;_h=3Dcc?=
 =?UTF-8?Q?:content-type:date:from:in-reply-to:message-id:mime-version:ref?=
 =?UTF-8?Q?erences:subject:to;_s=3Dpps0720;_bh=3D6vgpXrjrkaMkIXNavufqf89Fa?=
 =?UTF-8?Q?7ZcgIjU17RW1xCW0+c=3D;_b=3DWXzQF0/r686TPV3oyTkUvNAeEeLYmLFOdEx4?=
 =?UTF-8?Q?9hJHzM/ZxfQtRVUNa1cP7h0TUyYlHF2J_uiZ0KzcirW6OOYi+ZJgL7WP7FmJ/cC?=
 =?UTF-8?Q?kOnpwBw1zQZxevyJKAGpenJEkDoMS/y2PrCWXq_wsK59iVHHA38gUy7UsAGmiHo?=
 =?UTF-8?Q?eyWyeOzPtu0VPO2DXi4t9H6isLznUgvudt682b9kHCXp_eS1KvGO2cOC/9EMknv?=
 =?UTF-8?Q?0BaeI6pybDz3bB04uuAU1FC6OOR5y2g4ktn0VkFgX6qv8x3tro_CfWK/BmeS5Y0?=
 =?UTF-8?Q?gCq3iJzlyv8pkMPwRR4WhqFn8LsN6iAzy7UQoJ54EwGOIPPt15W2i6zX_jA=3D?=
 =?UTF-8?Q?=3D_?=
Received: from p1lg14880.it.hpe.com ([16.230.97.201])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3ye1r5jhf4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 May 2024 12:15:00 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 8FAEE8005FD;
	Thu, 30 May 2024 12:14:59 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTPS id 7A30180107B;
	Thu, 30 May 2024 12:14:58 +0000 (UTC)
Date: Thu, 30 May 2024 07:14:56 -0500
From: Dimitri Sivanich <sivanich@hpe.com>
To: David Wang <00107082@163.com>
Cc: Dimitri Sivanich <sivanich@hpe.com>, kevin.tian@intel.com,
        baolu.lu@linux.intel.com, jroedel@suse.de,
        linux-kernel@vger.kernel.org
Subject: Re: [Regression] 6.10-rc1: Fail to resurrect from suspend.
Message-ID: <ZlhtwDqFek7lP+9X@hpe.com>
References: <20240530120110.22141-1-00107082@163.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530120110.22141-1-00107082@163.com>
X-Proofpoint-ORIG-GUID: LHWj9c2Ds8eCUY5UReE-r7bxr49ljOVG
X-Proofpoint-GUID: LHWj9c2Ds8eCUY5UReE-r7bxr49ljOVG
X-Proofpoint-UnRewURL: 2 URL's were un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-30_09,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0 impostorscore=0
 mlxscore=0 clxscore=1011 priorityscore=1501 phishscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405300093

Hi David,

There is a fix to commit d74169ceb0, which I'll be posting shortly.  Hopefully
that will resolve your issue.

On Thu, May 30, 2024 at 08:01:10PM +0800, David Wang wrote:
> Hi,
> 
> My system fails to resurrect after `systemctl suspend` with 6.10-rc1,
> when pressing power button, the machine "sounds" starting(fans roaring),
> but my keyboard/mouse/monitor is not powered, and I have nothing to
> do but powering cycle the system.
> 
> I run a bisect session, and narrows it down to following commit:
> 
> 	commit d74169ceb0d2e32438946a2f1f9fc8c803304bd6
> 	Author: Dimitri Sivanich <sivanich@hpe.com>
> 	Date:   Wed Apr 24 15:16:29 2024 +0800
> 
> 	    iommu/vt-d: Allocate DMAR fault interrupts locally
> 	    
> 	    The Intel IOMMU code currently tries to allocate all DMAR fault interrupt
> 	    vectors on the boot cpu.  On large systems with high DMAR counts this
> 	    results in vector exhaustion, and most of the vectors are not initially
> 	    allocated socket local.
> 	    
> 	    Instead, have a cpu on each node do the vector allocation for the DMARs on
> 	    that node.  The boot cpu still does the allocation for its node during its
> 	    boot sequence.
> 	    
> 	    Signed-off-by: Dimitri Sivanich <sivanich@hpe.com>
> 	    Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> 	    Link: https://lore.kernel.org/r/Zfydpp2Hm+as16TY@hpe.com
> 	    Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> 	    Signed-off-by: Joerg Roedel <jroedel@suse.de>
>  
> And I have confirmed that reverting this commit can fix my problem.
> 
> Following is my bisect logs:
> 	$ git bisect log
> 	git bisect start
> 	# status: waiting for both good and bad commits
> 	# good: [a38297e3fb012ddfa7ce0321a7e5a8daeb1872b6] Linux 6.9
> 	git bisect good a38297e3fb012ddfa7ce0321a7e5a8daeb1872b6
> 	# status: waiting for bad commit, 1 good commit known
> 	# bad: [1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0] Linux 6.10-rc1
> 	git bisect bad 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
> 	# good: [db5d28c0bfe566908719bec8e25443aabecbb802] Merge tag 'drm-next-2024-05-15' of https://gitlab.freedesktop.org/drm/kernel 
> 	git bisect good db5d28c0bfe566908719bec8e25443aabecbb802
> 	# good: [db5d28c0bfe566908719bec8e25443aabecbb802] Merge tag 'drm-next-2024-05-15' of https://gitlab.freedesktop.org/drm/kernel 
> 	git bisect good db5d28c0bfe566908719bec8e25443aabecbb802
> 	# bad: [a90f1cd105c6c5c246f07ca371d873d35b78c7d9] Merge tag 'turbostat-for-Linux-6.10-merge-window' of git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux
> 	git bisect bad a90f1cd105c6c5c246f07ca371d873d35b78c7d9
> 	# good: [8b35a3bb33b57bc2cb2694a50e49e0ea01b9ff6f] Merge tag 'pmdomain-v6.10' of git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm
> 	git bisect good 8b35a3bb33b57bc2cb2694a50e49e0ea01b9ff6f
> 	# bad: [619b92b9c8fe5369503ae948ad4e0a9c195c2c4a] Merge tag 'clk-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux
> 	git bisect bad 619b92b9c8fe5369503ae948ad4e0a9c195c2c4a
> 	# good: [91b6163be404e36baea39fc978e4739fd0448ebd] Merge tag 'sysctl-6.10-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/sysctl/sysctl
> 	git bisect good 91b6163be404e36baea39fc978e4739fd0448ebd
> 	# bad: [0cc6f45cecb46cefe89c17ec816dc8cd58a2229a] Merge tag 'iommu-updates-v6.10' of git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu
> 	git bisect bad 0cc6f45cecb46cefe89c17ec816dc8cd58a2229a
> 	# good: [89721e3038d181bacbd6be54354b513fdf1b4f10] Merge tag 'net-accept-more-20240515' of git://git.kernel.dk/linux
> 	git bisect good 89721e3038d181bacbd6be54354b513fdf1b4f10
> 	# good: [89721e3038d181bacbd6be54354b513fdf1b4f10] Merge tag 'net-accept-more-20240515' of git://git.kernel.dk/linux
> 	git bisect good 89721e3038d181bacbd6be54354b513fdf1b4f10
> 	# good: [de111f6b4f6a3010020825d22a068f416bc29c95] iommu/amd: Enable Guest Translation after reading IOMMU feature register
> 	git bisect good de111f6b4f6a3010020825d22a068f416bc29c95
> 	# good: [da55da5a42d4247d7a48b843fa5fcd9a4a10f4fe] iommu/arm-smmu-v3: Make the kunit into a module
> 	git bisect good da55da5a42d4247d7a48b843fa5fcd9a4a10f4fe
> 	# bad: [ba00196ca41c4f6d0b0d3c4a6748a133577abe05] iommu/vt-d: Decouple igfx_off from graphic identity mapping
> 	git bisect bad ba00196ca41c4f6d0b0d3c4a6748a133577abe05
> 	# bad: [446a68c58d2e5b8140d474f1a74082aebeee9bb0] iommu/vt-d: Add trace events for cache tag interface
> 	git bisect bad 446a68c58d2e5b8140d474f1a74082aebeee9bb0
> 	# bad: [cc9e49d35b4de47d6b656ac144cb22b11dc65c2e] iommu/vt-d: Remove debugfs use of private data field
> 	git bisect bad cc9e49d35b4de47d6b656ac144cb22b11dc65c2e
> 	# good: [9e7ee0f045395dc8aa55fbdc164c062484f4c88d] iommu/vt-d: Use try_cmpxchg64{,_local}() in iommu.c
> 	git bisect good 9e7ee0f045395dc8aa55fbdc164c062484f4c88d
> 	# bad: [d74169ceb0d2e32438946a2f1f9fc8c803304bd6] iommu/vt-d: Allocate DMAR fault interrupts locally
> 	git bisect bad d74169ceb0d2e32438946a2f1f9fc8c803304bd6
> 	# first bad commit: [d74169ceb0d2e32438946a2f1f9fc8c803304bd6] iommu/vt-d: Allocate DMAR fault interrupts locally
> 
> 
> FYI
> David

