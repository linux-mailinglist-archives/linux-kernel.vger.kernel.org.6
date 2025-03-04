Return-Path: <linux-kernel+bounces-544030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F42A4DC9B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 12:31:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C2657AA93C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 11:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651771FF61E;
	Tue,  4 Mar 2025 11:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ivk18A8E"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798BF1372;
	Tue,  4 Mar 2025 11:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741087857; cv=none; b=TQrTb0mdSPSXTWYyG/RwLzs8QJtp3JZU2rcTRUJt9X+ZjDGOJkj60vHb3pS7T6q8PS41TmbNQxs2d5GbFOgb3LcQbTnTf1g2Uoha0pKGsDahKpj5587rMBysXnUuloXyNEm/z9sBFNC+68DB9NcnPZxNWbtrt2E/pCrZomNWINc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741087857; c=relaxed/simple;
	bh=m1QXoo0Ah2TX6eBak8hPjqLowqg2oHXteU+TOB7lBMM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sJombaSgvN2QkVukxGmQCJe2jT9gPX8hXJSgt7QjteT21s4wOYxAHDeUYXeStOsExM1rxCqPtyp4vpBqzQe6chgZsKeBrujpXLnZjLnPIFfkDeKV41DVTSV+joV5yyyzlKHXM0p8NxMBQicIcfwb0dWvArS5cqstgP9G1UfLcFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ivk18A8E; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741087856; x=1772623856;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=m1QXoo0Ah2TX6eBak8hPjqLowqg2oHXteU+TOB7lBMM=;
  b=Ivk18A8EGXZ9NroUqIHCByKlU4AY6aacmQAuj+wNa9ApG5JWhMCIHhBZ
   PJimGApdzsft5VCXULoermT5EdBdfQx8nlINwc1axVdimxeKF7QLCDYp0
   TW3Y2TrOHv7SWwmT3KWdWGunH/bberhP2U4jc62BiOKuWtKEiM8z678Wo
   WSwGBYf9ptVeG6VgHrjlFFxfyCEvKkFkmFbeMdJJQsiJNZy+uWK0/XPbR
   zCkTIc/V2LMdo6OVNzeQ7RqVnb3PnYRwdDfuaLktRWGJDy98T6OB5EhId
   S39P6uVGyuifYTFg/++OtdwIxv8/kFqRmKOsEhcLBCA1JyDiE2bWUwPNZ
   g==;
X-CSE-ConnectionGUID: TTOE4+UwTdqxtfttzquGHw==
X-CSE-MsgGUID: YnynlnYLTpGldVDKeW1sQQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="41898322"
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="41898322"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 03:30:56 -0800
X-CSE-ConnectionGUID: kxMrQzIDQT2c9oO6uQC5uQ==
X-CSE-MsgGUID: pfz0CUhLQiGeV2K7ZrH0bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="141579989"
Received: from unknown (HELO mattu-haswell.fi.intel.com) ([10.237.72.199])
  by fmviesa002.fm.intel.com with ESMTP; 04 Mar 2025 03:30:54 -0800
From: Mathias Nyman <mathias.nyman@linux.intel.com>
To: <gregkh@linuxfoundation.org>
Cc: <linux-usb@vger.kernel.org>,
	linux-kernel@vger.kernel.org,
	Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 0/1] xhci fix for usb-linus
Date: Tue,  4 Mar 2025 13:31:46 +0200
Message-ID: <20250304113147.3322584-1-mathias.nyman@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Greg

Michal found and fixed a regression introduced in 6.13
If possible it would be nice to get this into 6.14 still

Thanks
Mathias

Michal Pecio (1):
  usb: xhci: Fix host controllers "dying" after suspend and resume

 drivers/usb/host/xhci.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

-- 
2.43.0


