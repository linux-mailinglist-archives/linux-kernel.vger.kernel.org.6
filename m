Return-Path: <linux-kernel+bounces-195336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F12E68D4B3D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 14:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E7F81C23391
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 12:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88396183A72;
	Thu, 30 May 2024 12:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ilQJi9Xn"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9FF8183A66
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 12:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717070503; cv=none; b=lo/2kD/PcIXXpa6nHjhQ75LVujzbXRBY/qELOR1z6v4JPBzx/E71TvgWPujxnuX7DdhapFpI15N8jvNqREkIClwN4uWzcRBmp+9e1LeAXPnewc7qGk2M7C3s7W+kHBUj8TBLX9cuqM0r39bqYVV4cdWWuyDDKwdy4PP0ctq4CpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717070503; c=relaxed/simple;
	bh=cTzUY6jSVP0z3DdLxZ3a8PW6ByaAklUFEgH+9kaYB0A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QguN8edULdN/OqF+xrDryPbh8HXd3qCzYbdU6y9Kqtinhn6HuFE6RxHW5OCTNglx6tk8pVmCNlvOGtqFfFxweC2Q+PJXNe6IfT/WUC5dew8JbWdGKgjmSot39XHrnY4kf5m2k3yaDQVODQ74T3A+sS3tG0UPwM2t3fMB7CEZzLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ilQJi9Xn; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=jzdIn
	PFoiQE79oz0FAxRgBjy+bhSglkdU1VhG3eJOdY=; b=ilQJi9XnuoCEnlo9ZrzET
	J2KRKmN1w7/JQMQAsG+opNLqL7/o1hIeQckARBUCFb5r9epSZ+JIHmeoWPB0llOD
	I0vUvv9/7AyOitSsuEtxYX0B6jRayjKdNJM8E11ADIuE254333T5o6JlAX82Vr91
	ZBkdWWdTQM3w12Z38ocg1c=
Received: from localhost.localdomain (unknown [111.35.185.173])
	by gzga-smtp-mta-g3-0 (Coremail) with SMTP id _____wDnD7SGalhmU1M7Fg--.17729S4;
	Thu, 30 May 2024 20:01:13 +0800 (CST)
From: David Wang <00107082@163.com>
To: sivanich@hpe.com,
	kevin.tian@intel.com,
	baolu.lu@linux.intel.com,
	jroedel@suse.de
Cc: linux-kernel@vger.kernel.org,
	00107082@163.com
Subject: [Regression] 6.10-rc1: Fail to resurrect from suspend.
Date: Thu, 30 May 2024 20:01:10 +0800
Message-Id: <20240530120110.22141-1-00107082@163.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnD7SGalhmU1M7Fg--.17729S4
X-Coremail-Antispam: 1Uf129KBjvJXoW3Wr1UCryxJFy5tr4kCw18AFb_yoW7GFyxpr
	yxWFnI9r43Xry8X3Wjgw47u3ZxG3s8Ar43u3y5Kw45AF98Gr9YqFsIqrW3Wry8ZF4UGay7
	Xa4DZrn0934DZaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0p_KZXUUUUUU=
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/xtbBEAfuqmVOER6+FwABsf

Hi,

My system fails to resurrect after `systemctl suspend` with 6.10-rc1,
when pressing power button, the machine "sounds" starting(fans roaring),
but my keyboard/mouse/monitor is not powered, and I have nothing to
do but powering cycle the system.

I run a bisect session, and narrows it down to following commit:

	commit d74169ceb0d2e32438946a2f1f9fc8c803304bd6
	Author: Dimitri Sivanich <sivanich@hpe.com>
	Date:   Wed Apr 24 15:16:29 2024 +0800

	    iommu/vt-d: Allocate DMAR fault interrupts locally
	    
	    The Intel IOMMU code currently tries to allocate all DMAR fault interrupt
	    vectors on the boot cpu.  On large systems with high DMAR counts this
	    results in vector exhaustion, and most of the vectors are not initially
	    allocated socket local.
	    
	    Instead, have a cpu on each node do the vector allocation for the DMARs on
	    that node.  The boot cpu still does the allocation for its node during its
	    boot sequence.
	    
	    Signed-off-by: Dimitri Sivanich <sivanich@hpe.com>
	    Reviewed-by: Kevin Tian <kevin.tian@intel.com>
	    Link: https://lore.kernel.org/r/Zfydpp2Hm+as16TY@hpe.com
	    Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
	    Signed-off-by: Joerg Roedel <jroedel@suse.de>
 
And I have confirmed that reverting this commit can fix my problem.

Following is my bisect logs:
	$ git bisect log
	git bisect start
	# status: waiting for both good and bad commits
	# good: [a38297e3fb012ddfa7ce0321a7e5a8daeb1872b6] Linux 6.9
	git bisect good a38297e3fb012ddfa7ce0321a7e5a8daeb1872b6
	# status: waiting for bad commit, 1 good commit known
	# bad: [1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0] Linux 6.10-rc1
	git bisect bad 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
	# good: [db5d28c0bfe566908719bec8e25443aabecbb802] Merge tag 'drm-next-2024-05-15' of https://gitlab.freedesktop.org/drm/kernel
	git bisect good db5d28c0bfe566908719bec8e25443aabecbb802
	# good: [db5d28c0bfe566908719bec8e25443aabecbb802] Merge tag 'drm-next-2024-05-15' of https://gitlab.freedesktop.org/drm/kernel
	git bisect good db5d28c0bfe566908719bec8e25443aabecbb802
	# bad: [a90f1cd105c6c5c246f07ca371d873d35b78c7d9] Merge tag 'turbostat-for-Linux-6.10-merge-window' of git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux
	git bisect bad a90f1cd105c6c5c246f07ca371d873d35b78c7d9
	# good: [8b35a3bb33b57bc2cb2694a50e49e0ea01b9ff6f] Merge tag 'pmdomain-v6.10' of git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm
	git bisect good 8b35a3bb33b57bc2cb2694a50e49e0ea01b9ff6f
	# bad: [619b92b9c8fe5369503ae948ad4e0a9c195c2c4a] Merge tag 'clk-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux
	git bisect bad 619b92b9c8fe5369503ae948ad4e0a9c195c2c4a
	# good: [91b6163be404e36baea39fc978e4739fd0448ebd] Merge tag 'sysctl-6.10-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/sysctl/sysctl
	git bisect good 91b6163be404e36baea39fc978e4739fd0448ebd
	# bad: [0cc6f45cecb46cefe89c17ec816dc8cd58a2229a] Merge tag 'iommu-updates-v6.10' of git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu
	git bisect bad 0cc6f45cecb46cefe89c17ec816dc8cd58a2229a
	# good: [89721e3038d181bacbd6be54354b513fdf1b4f10] Merge tag 'net-accept-more-20240515' of git://git.kernel.dk/linux
	git bisect good 89721e3038d181bacbd6be54354b513fdf1b4f10
	# good: [89721e3038d181bacbd6be54354b513fdf1b4f10] Merge tag 'net-accept-more-20240515' of git://git.kernel.dk/linux
	git bisect good 89721e3038d181bacbd6be54354b513fdf1b4f10
	# good: [de111f6b4f6a3010020825d22a068f416bc29c95] iommu/amd: Enable Guest Translation after reading IOMMU feature register
	git bisect good de111f6b4f6a3010020825d22a068f416bc29c95
	# good: [da55da5a42d4247d7a48b843fa5fcd9a4a10f4fe] iommu/arm-smmu-v3: Make the kunit into a module
	git bisect good da55da5a42d4247d7a48b843fa5fcd9a4a10f4fe
	# bad: [ba00196ca41c4f6d0b0d3c4a6748a133577abe05] iommu/vt-d: Decouple igfx_off from graphic identity mapping
	git bisect bad ba00196ca41c4f6d0b0d3c4a6748a133577abe05
	# bad: [446a68c58d2e5b8140d474f1a74082aebeee9bb0] iommu/vt-d: Add trace events for cache tag interface
	git bisect bad 446a68c58d2e5b8140d474f1a74082aebeee9bb0
	# bad: [cc9e49d35b4de47d6b656ac144cb22b11dc65c2e] iommu/vt-d: Remove debugfs use of private data field
	git bisect bad cc9e49d35b4de47d6b656ac144cb22b11dc65c2e
	# good: [9e7ee0f045395dc8aa55fbdc164c062484f4c88d] iommu/vt-d: Use try_cmpxchg64{,_local}() in iommu.c
	git bisect good 9e7ee0f045395dc8aa55fbdc164c062484f4c88d
	# bad: [d74169ceb0d2e32438946a2f1f9fc8c803304bd6] iommu/vt-d: Allocate DMAR fault interrupts locally
	git bisect bad d74169ceb0d2e32438946a2f1f9fc8c803304bd6
	# first bad commit: [d74169ceb0d2e32438946a2f1f9fc8c803304bd6] iommu/vt-d: Allocate DMAR fault interrupts locally


FYI
David


