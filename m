Return-Path: <linux-kernel+bounces-350155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2BEB990092
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 12:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 698741F21EE5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 10:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DED114A609;
	Fri,  4 Oct 2024 10:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S13O7o2n"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA3114A095
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 10:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728036630; cv=none; b=UUvqbJNWBXR6/AK/pyHtOVzMYaocAZAZRbDI1Pqmkq2jRuGqvEM+lT0EKbAsPFPr4RMkSBk41K1H7xjvEoHmfNVM+Z6jnMYGSduBCeQg4OOjyvY56tLb5ENdBguoDXvHfjdeeWTxc0XkEbiqTZ8MXNVep/9ZOBeDNlXWpK8P7WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728036630; c=relaxed/simple;
	bh=h2bSgynWcUsopXYpmzcf49SKdBw2+LEG49P5EMZD3Ms=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hBzMzL3qemj19kavzq6JBzIEawr/crmLGG2C4Pp18heePvhjmbXaRwQKiru4uovhkgucHIIDQcVGf4km4cLPnvXHZ/L7M+vQe+0IzjkVOTJBm2QfY2/QQhZTwc/NPcfp9fTZS4S0mxJ5MhKA+wiIu+xn3yv4Yn7Ab1eWo6ZYNBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S13O7o2n; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728036629; x=1759572629;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=h2bSgynWcUsopXYpmzcf49SKdBw2+LEG49P5EMZD3Ms=;
  b=S13O7o2nMurBzvxv/XtTw26BAUVFVmjjQrb/Xj+H8Z3uu+lxf+dvv0cj
   OJzrs3aYsdt7Kc91lbSaT6klCpCoodMEiodeCxjFy9I75hRXBNtn6nZhz
   TA/CKT8Q06ukcn7vlhF455PlagF2ZYsS+fnTaRZKchXA2QseHixgjOsDB
   l/kaBh6Cw06HqrVMu18pDi/hWP9mAcSRxyUXqwS/CTLGv+sxZQAfU+uCv
   GkCniFSjXhxQbmqjHaTBAewU6ksLy9HhL5OwOjyFsuFeRn47BPZzU2oR9
   Ag2yufa7xr76SPaXxcgyspIxtjF/wGP0G7DOvW3dRtemTOY5GhRZwJ0Qs
   w==;
X-CSE-ConnectionGUID: vrnB/ZNXRCKZmDAdGQcdJw==
X-CSE-MsgGUID: nJ5ln2wgRDmaoT0mMz3ilg==
X-IronPort-AV: E=McAfee;i="6700,10204,11214"; a="44784884"
X-IronPort-AV: E=Sophos;i="6.11,177,1725346800"; 
   d="scan'208";a="44784884"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 03:10:28 -0700
X-CSE-ConnectionGUID: ZTq54FNWQyC0edJNNdCoZw==
X-CSE-MsgGUID: EtJaNfB0S9GfF+c2GSwsTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,177,1725346800"; 
   d="scan'208";a="74658805"
Received: from olympicsflex1.amr.corp.intel.com (HELO tkristo-desk.intel.com) ([10.245.245.54])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 03:10:26 -0700
From: Tero Kristo <tero.kristo@linux.intel.com>
To: 
Cc: linux-kernel@vger.kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	linux-nvme@lists.infradead.org,
	sagi@grimberg.me,
	kbusch@kernel.org
Subject: [PATCH 0/1] nvme-pci: Add CPU latency pm-qos handling
Date: Fri,  4 Oct 2024 13:09:27 +0300
Message-ID: <20241004101014.3716006-1-tero.kristo@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

Re-posting this as the 6.12-rc1 is out, and the previous RFC didn't
receive any feedback. The patch hasn't seen any changes, but I included
the cover letter for details.

The patch adds mechanism for tacking NVME latency with random workloads.
A new sysfs knob (cpu_latency_us) is added under NVME devices, which can
be used to fine tune PM QoS CPU latency limit while NVME is operational.

Below is a postprocessed measurement run on an Icelake Xeon platform,
measuring latencies with 'fio' tool, running random-read and read
profiles. 5 random-read and 5 bulk read operations are done with the
latency limit enabled / disabled, and the maximum 'slat' (start latency),
'clat' (completion latency) and 'lat' (total latency) values shown for each
setup; values are in microseconds. The bandwidth is measured with the
'read' payload of fio, and min-avg-max values are shown in MiB/s. c6%
indicates the time spent in c6 state as percentage during the test for
the CPU running 'fio'.

==
Setting cpu_latency_us limit to 10 (enabled)
  slat: 31, clat: 99, lat: 113, bw: 1156-1332-1359, c6%: 2.8
  slat: 49, clat: 135, lat: 143, bw: 1156-1332-1361, c6%: 1.0
  slat: 67, clat: 148, lat: 156, bw: 1159-1331-1361, c6%: 0.9
  slat: 51, clat: 99, lat: 107, bw: 1160-1330-1356, c6%: 1.0
  slat: 82, clat: 114, lat: 122, bw: 1156-1333-1359, c6%: 1.0
Setting cpu_latency_us limit to -1 (disabled)
  slat: 112, clat: 275, lat: 364, bw: 1153-1334-1364, c6%: 80.0
  slat: 110, clat: 270, lat: 324, bw: 1164-1338-1369, c6%: 80.1
  slat: 106, clat: 260, lat: 320, bw: 1159-1330-1362, c6%: 79.7
  slat: 110, clat: 255, lat: 300, bw: 1156-1332-1363, c6%: 80.2
  slat: 107, clat: 248, lat: 322, bw: 1152-1331-1362, c6%: 79.9
==

As a summary, the c6 induced latencies are eliminated from the
random-read tests ('clat' drops from 250+us to 100-150us), and in the
maximum throughput testing the bandwidth is not impacted negatively
(bandwidth values are pretty much identical) so the overhead introduced
is minimal.

-Tero


