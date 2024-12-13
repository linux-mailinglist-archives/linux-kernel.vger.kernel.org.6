Return-Path: <linux-kernel+bounces-445375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BED639F153D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 19:51:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72D0C16139F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 18:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94CD71E47D7;
	Fri, 13 Dec 2024 18:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ytxrm1Ln"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7BF1547CA
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 18:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734115890; cv=none; b=CEQk3d9YJj5i3kkr4gBO8z2J4REtEpGcN8OmfImZ8p3wGEkWB5K1ZuU5YoGKhvD0gQDbpyQGXk97QWoo3LJdE372XaI4UVnvOzBaqwbhCWO3Q1f+7631fSskLh4ks0bNWCnjeW9c7udm78mGDWFCeCIINGRybYpcu+iojgQQjDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734115890; c=relaxed/simple;
	bh=76P2OgAQ7/wVhpGufHDbJfjG7u1gNs19Mcf9iBIQytU=;
	h=Subject:To:Cc:From:Date:Message-Id; b=FWOfM7acoVuwJhkjWAnaD5a/gMUBIAWke/hZ/fnjKHfMW0qW9bw1NxnkYI6PE3S2ZbONcYDQMSfnD5wCRw1/eSqVELe9cfTl2nog2P4NlbiOIo1K6LapzhsPlmyJ7lNBGgr4wkLKh+7bf/u2uTIBNGC6W1HrkHoNCixVbPi0Pfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ytxrm1Ln; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734115888; x=1765651888;
  h=subject:to:cc:from:date:message-id;
  bh=76P2OgAQ7/wVhpGufHDbJfjG7u1gNs19Mcf9iBIQytU=;
  b=Ytxrm1Lna0zBrFi8Dl8ybdsJ6Q65XN5MELoXKqXKf4Z1PhjgevR4UP3H
   6MhTsP4Y860bywjz9Q5w+8eZ8d42P5gEdkdSe7jpKnnnid6VqY+Lkkwg2
   Pto5LPpf5Axrgp5x4ly7YZxh0MdFmCI4axJ/j2aTn6ffMWt8loPfToIhS
   ArZtofNek9h+pFWPftJiofZGzcduxex5gpwnCzlncPEYc0WZtl9fl0XPT
   /ou6c34TuwPk/vhe7odxlutQPyTOcAWq8ETCJyeQ3hUjK4IGj+tSy/QdR
   5zJZPx1WcIgcf/Xml1N8C8BylsA7DUPvGizzkODwkdGwpuuwYTWBW5Gwl
   Q==;
X-CSE-ConnectionGUID: 0grE6n5iRS20F+eV18jJMA==
X-CSE-MsgGUID: zwH5mYSzQhiWtDeuJ50Fnw==
X-IronPort-AV: E=McAfee;i="6700,10204,11285"; a="34487416"
X-IronPort-AV: E=Sophos;i="6.12,232,1728975600"; 
   d="scan'208";a="34487416"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 10:51:28 -0800
X-CSE-ConnectionGUID: dQg6UfSsQoKtMX3BYvvh4g==
X-CSE-MsgGUID: CQIU76KwQJeY2MWRw5dYwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="96478746"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by orviesa010.jf.intel.com with ESMTP; 13 Dec 2024 10:51:28 -0800
Subject: [v2][PATCH 0/5] x86/cpu: Remove duplicate microcode version matching infrastructure
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,tglx@linutronix.de,bp@alien8.de,kan.liang@linux.intel.com,Dave Hansen <dave.hansen@linux.intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Fri, 13 Dec 2024 10:51:27 -0800
Message-Id: <20241213185127.F38B6EE9@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Changes from v1:
 * Fix missing conversion site in i10nm (Boris)
 * Shorten X86_STEPPING_MIN/MAX and helper names (Boris)
 * Fix up changelog typo/thinko reversing struct names (Tony)
 * Move skx_cpuids[] to a non-stepping helper
Changes from RFC:
 * Convert stepping match helpers to always take a range and never
   take a raw stepping bitmap. - Ingo

--

x86 has generic CPU matching infrastructure. This lets you build
tables of CPUs with some property.  It's mostly used for enumerating
model-specific features, but it is quite a bit more flexible than
that. In includes a facility to match steppings and microcode
versions. This generic infrastructure is built around 'struct
x86_cpu_id'.

There is a less generic, parallel CPU matching facility built around
'struct x86_cpu_desc'. It is used only for matching specific microcode
revisions.  All of the 'struct x86_cpu_desc' users can be converted to
'struct x86_cpu_id'.

Do that conversion then remove the 'struct x86_cpu_desc'
infrastructure.

Feedback is getting pretty cosmetic at this point so barring any big
comments on this, I'll probably apply it early next week.

--

 arch/x86/events/intel/core.c         |   62 ++++++++-----------
 arch/x86/include/asm/cpu_device_id.h |   51 ++--------------
 arch/x86/kernel/apic/apic.c          |   18 ++---
 arch/x86/kernel/cpu/amd.c            |    9 +-
 arch/x86/kernel/cpu/common.c         |   78 ++++++++++++-------------
 arch/x86/kernel/cpu/match.c          |   28 +-------
 drivers/edac/i10nm_base.c            |   21 +++---
 drivers/edac/skx_base.c              |    2 
 include/linux/mod_devicetable.h      |    2 
 9 files changed, 105 insertions(+), 166 deletions(-)

