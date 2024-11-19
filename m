Return-Path: <linux-kernel+bounces-414757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F36E19D2CE3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 18:46:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC7121F2214F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 17:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337201D221C;
	Tue, 19 Nov 2024 17:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZK9P8tzE"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035821D1F71
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 17:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732038355; cv=none; b=DHA9fDcTX/GVheSjpRkNmJzgiF9gP4g0vg1g2nILbxnDAxSyBTBVv1/IuyT1/Re9qgfUmD1QNXfiqmt6XXSiTT+AnvOlrT3riAp2l2maNyt71ZDcOqxU39P9nH3oeffQMh5JkH0fK0IyCekKDZr90cvIstCQy+7Doj9464Ai3gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732038355; c=relaxed/simple;
	bh=mTdAVuUriIMRS+V3xoSSx/BGafZH3FWGBC1BWGHuswc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hDrS4n/YCztPnieaSxnKrciSJ45V5cyA0I+9sF+qvq4fwg3HuaW8X0RmHdbQhp6aYBRwsCzA/EQWndp5zCulfa7TE3Chz0ksmAauOJF03yMHePyzKQALnnCSk7jukMIqK5M3pxNe9HFrKcMzTB8MNClb0iMueXcQMKnHekF28ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZK9P8tzE; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732038354; x=1763574354;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mTdAVuUriIMRS+V3xoSSx/BGafZH3FWGBC1BWGHuswc=;
  b=ZK9P8tzEELIbrtq81Rq9BaY7KJuM18NalkkqYQddvREOwZZfvHGCwvKd
   ZlBC8Qlr/gBqTw8MxkclyOpYSNQD4xo1tuvXymnKcp69p0iClgUrPMC2c
   Kc86InnaQHFzS3bQY642tg/NWkVfA7fn09ULAsJP3gnVDk3+ulTHugatN
   Xil5im47XHNP0s/6Ye9+BUGvrqjRLCRIdtQbbyNuTHs8wQSJnp4qvSb/3
   S+BqNz/0LFtPilx/BPZbVJB82I2cEvlWRLyxeuDOH/HZVlywPig4XL8Vd
   oWmf1naAyBpH4rUWsJ7oC6gpqRk5w/LZplzhOOgzSYSbhGK5/yaOXYQeq
   g==;
X-CSE-ConnectionGUID: 4DiQb3I6RjiX6bf7bvD+DQ==
X-CSE-MsgGUID: M63S6bYZSG+61iFTM9oDZw==
X-IronPort-AV: E=McAfee;i="6700,10204,11261"; a="32165650"
X-IronPort-AV: E=Sophos;i="6.12,166,1728975600"; 
   d="scan'208";a="32165650"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 09:45:53 -0800
X-CSE-ConnectionGUID: hmhvNWEPSwqGVOu411YWJg==
X-CSE-MsgGUID: sbqgqTgWRoeNl6WqcqEBhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,166,1728975600"; 
   d="scan'208";a="89757911"
Received: from myoakum-mobl.amr.corp.intel.com (HELO desk) ([10.125.150.235])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 09:45:53 -0800
Date: Tue, 19 Nov 2024 09:45:46 -0800
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
	bp@alien8.de
Subject: Re: [RFC][PATCH] x86/cpu/bugs: Consider having old Intel microcode
 to be a vulnerability
Message-ID: <20241119174546.5ehj6yjiqk3baxhh@desk>
References: <20241107170630.2A92B8D3@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107170630.2A92B8D3@davehans-spike.ostc.intel.com>

On Thu, Nov 07, 2024 at 09:06:30AM -0800, Dave Hansen wrote:
> 
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> You can't practically run old microcode and consider a system secure
> these days.  So, let's call old microcode what it is: a vulnerability.

> Expose that vulnerability in a place that folks can find it:
> 
> 	/sys/devices/system/cpu/vulnerabilities/old_microcode

Sorry for playing the devil's advocate. I am wondering who is the prime
beneficiary of this change?

Roughly dividing the user base into:

1. People who get their updates from distro. As distros also provide the
   microcode, most likely, their kernel will be patched to agree that the
   microcode that they provide has latest security fixes. Effectively
   distros have the control over what the kernel reports.

2. People who get their updates from distro, but build their own kernel
   could benefit from this change. Broadly these would be CSPs/embedded
   vendors/developers etc.

   - I am assuming CSPs are well versed with the microcode updates and
     hand-pick the microcode that they want to apply. So, they may not be
     care too much about microcode being old. And majority of their users
     that run workload in a guest VM won't see the microcode version.

   - In my experience, embedded vendors generally take a very long time to
     provide updates. They could benefit from this change when they
     eventually update their kernel.

   - Expert users/developers who submit bug reports to mailing lists can
     now know that they are running old microcode, and should update their
     microcode before submitting a bug report. To me they would benefit
     the most from this change.

For this to be help category 1. users, we need blessing from distro
providers. It would be great if more and more distros provide their
agreement/feedback on this change, as they are the ones who would enforce
this change.

