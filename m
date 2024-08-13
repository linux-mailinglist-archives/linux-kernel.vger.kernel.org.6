Return-Path: <linux-kernel+bounces-284033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1EC794FC36
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 05:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 001AC1C223C8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 03:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21451BC40;
	Tue, 13 Aug 2024 03:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AtkpY2tS"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0931B7FD
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 03:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723519692; cv=none; b=QYNpxOZPPI2aX8ZfHSn0xqkweoeL6P52NSltqAHc5Z9657ShYPkl2eldw0D5SpMsvQmgYD6/iTNP1Rw2MaSAz7r8oHc93//c0yMIEpdI6w54iXPCZ8IfPEXJWDDHXHB39kcpZktJ03U+UJLLYapMpUevf1NwUaontI+4+IlCwj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723519692; c=relaxed/simple;
	bh=Xmthjr7+UIxSbkXpf/W2dHKQClQmNPuDviqazeMJnCM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=JlUSTYTYIoYXKOpv77yla7RNV4tX7AmDJYyjxZgI52H9cCDIQg0OkwOSw42mHwbpSRL82lieDRf2uQcJZwSfqixA7DAJdCW+5CUlfjHSlxcNeAhzG3m6MInQ8L/N7rh7BiJQGj4eCciI6oXIZaxURwxw7ykbmNgspHOnBU1zhPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AtkpY2tS; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723519691; x=1755055691;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=Xmthjr7+UIxSbkXpf/W2dHKQClQmNPuDviqazeMJnCM=;
  b=AtkpY2tSqh/0tNaOwTwLHwyBHVgCMdleX8lk9E0eft3SZGhjVzc/ZtC5
   1+eSsDUCsJFOl6ZL6JM11DgPAoS4R/SsXcuS5QECBOSr+7kOcczedRvUK
   zk271tLuOou5piRgBHoTRon9QcxVfIAIpUouLBnqrsHq/9wo7l3Gskw5G
   wMEMZWmwgRjdwl1/bj1hj7usCddviK/RfHk7WXncV6r6XQwLQara2q9fs
   js8NPHOpsIKfzVG1p19WSgDb/4aj50sD7YDTPhfrwSQpSQnS+SMzPmD85
   5QqAzzyII7LOGH3daThF1RiK8a4VhjqECH5cS7l4E6P5df/YPZbIC4RYD
   w==;
X-CSE-ConnectionGUID: 6JD/KofwQ4CdDUJ+60L2/g==
X-CSE-MsgGUID: B34W47sRQ6SiQuTq2HrUAQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="32232741"
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="32232741"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 20:28:10 -0700
X-CSE-ConnectionGUID: kT8SroZMRg2ReiKaw0Qxxg==
X-CSE-MsgGUID: iBdau3xZRwGJ15zTih5AYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="58393975"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 20:28:08 -0700
From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To: tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org,
	x86@kernel.org,
	qiuxu.zhuo@intel.com
Subject: Re: [GIT pull] x86/urgent for v6.11-rc3
Date: Tue, 13 Aug 2024 11:15:22 +0800
Message-Id: <20240813031522.4544-1-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <87le12rw26.ffs@tglx>
References: <87le12rw26.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

> From: Thomas Gleixner <tglx@linutronix.de>
> To: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: linux-kernel@vger.kernel.org, x86@kernel.org
> Subject: Re: [GIT pull] x86/urgent for v6.11-rc3
> 
> On Sun, Aug 11 2024 at 11:07, Linus Torvalds wrote:
> [...]
> > So i think that static_branch_likely() should have been changed to a
> > static_branch_unlikely() too, but it's possible that I've just
> > confused myself.
> 
> You are right. It creates a branch for the !virt_lock case.
> 
> > Anyway, somebody should double-check me.
> >
> > I doubt it actually matters, since I think this all is fundamentally
> > just in the slow-path, so the "do a branch or a no-op" is likely
> > entirely in the noise even if I followed the code right. But it looked
> > off to me.
> 
> It is off and yes it won't matter much in the slowpath maze.

static_branch_unlikely() matches that 'virt_spin_lock_key' is set to false 
in default after the commit,

  e639222a5119 ("x86/paravirt: Fix incorrect virt spinlock setting on bare metal")
  
although it offers little performance benefit since it is in the slow path.

Thomas, do you think it's worth making a patch to convert static_branch_likely()
to static_branch_unlikely() for this check, as suggested by Linus?
If so, I can assist with this.

Thanks!
-Qiuxu

