Return-Path: <linux-kernel+bounces-227908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F4739157FF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 22:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6AA81F219C0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 20:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E68A1A070D;
	Mon, 24 Jun 2024 20:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G9KcJQ4M"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A922233B;
	Mon, 24 Jun 2024 20:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719261144; cv=none; b=ZTO+lkvYZqVYOUk8qkobV3Y5O0Y2YD5KzN7ybFSljwuC9aUi7I/Q9xpXoXEfYj8ZOImxHhwexcQX1pauGxjUuij/hODXejMMAvk56ZcbELifv+nNNawPCTkEshWtpnjy5f4+2OsXKLr6AjwvO5ryghaGQPNMSpAYH1i/qmVhokw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719261144; c=relaxed/simple;
	bh=fuO4OwbXABi3s5sBggMwImCzAJF7yoChOhtO/9EqYF8=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=t7ldOKbAQ3ohACExpHT/c+dKvMu+GUqcarEenW+FCSk/FVtu7XagCEzcqABHcT7RKX3ZlQFOx/+OExPADkZSHDxottkbPItrwYxOD5qR4oFo04BPyMU9P8rLXa4d9F8yY40xQGF4QzZJHfnT1dfKJGQtXf7hh7N0InN4H7TGjj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G9KcJQ4M; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719261143; x=1750797143;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fuO4OwbXABi3s5sBggMwImCzAJF7yoChOhtO/9EqYF8=;
  b=G9KcJQ4MG8tWw3+vLENS2eRlQw2fgn2rRp4tPMomhS4NI7kzMWGQ34tC
   TTsR/VXdWWWfKuEaPORLJG/W7jzeiH8ur7i2gbf8HQGRaUNxfzXv6Xdl7
   4OX93TP2J4rMAAGQJg3EciLD5L17/QTmG1+PfVbg0gGXY416Eqy50odUa
   XVmUHdBDvx6pzMtTUMCkbnRRQddwbpcUBli5+37uHrOdWqIxD3jG+q3TS
   yj1mqTwhXhbuDYviLXvL/lEwWHhufABoujfXw0HqTB8D/2CByrkx4nBTt
   ZGQ9PrqOVLCcZMSt8MlMX52sNmeURrbj0OqV6TyQzzOCJGkknB2O/UWOq
   Q==;
X-CSE-ConnectionGUID: rlluUfKDTU2OTtyPOGDTNg==
X-CSE-MsgGUID: o9U8AcVxTGScWmt1h0Soig==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="33792322"
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="33792322"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 13:32:22 -0700
X-CSE-ConnectionGUID: t/FZ04zATRGk0IVW6md0bQ==
X-CSE-MsgGUID: OWb9ziIuR1qIAmg9o4Xahw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="47949129"
Received: from ticela-or-265.amr.corp.intel.com (HELO xpardee-test1.amr.corp.intel.com) ([10.209.54.237])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 13:32:22 -0700
From: Xi Pardee <xi.pardee@linux.intel.com>
To: xi.pardee@linux.intel.com,
	irenic.rajneesh@gmail.com,
	david.e.box@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/9] LTR ignore feature improvement
Date: Mon, 24 Jun 2024 13:32:09 -0700
Message-Id: <20240624203218.2428475-1-xi.pardee@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series contains six patches to improve LTR ignore
feature, one patch to modify the usage of pmc_core_send_msg and
two patches to improve PMC Core driver in general.

Improve LTR ignore feature:
platform/x86:intel/pmc: Add support to undo ltr_ignore
platform/x86:intel/pmc: Use the Elvis operator
platform/x86:intel/pmc: Use DEFINE_SHOW_STORE_ATTRIBUTE macro
platform/x86:intel/pmc: Remove unneeded min_t check
platform/x86:intel/pmc: Add support to show ltr_ignore value
platform/x86:intel/pmc: Move pmc assignment closer to first usage

Modify the usage of pmc_core_send_msg:
platform/x86:intel/pmc: Use the return value of pmc_core_send_msg

Improve PMC Core driver:
platform/x86:intel/pmc: Convert index variables to be unsigned
platform/x86:intel/pmc: Simplify mutex usage with cleanup helpers

Xi Pardee (9):
  platform/x86:intel/pmc: Use the return value of pmc_core_send_msg
  platform/x86:intel/pmc: Simplify mutex usage with cleanup helpers
  platform/x86:intel/pmc: Convert index variables to be unsigned
  platform/x86:intel/pmc: Move pmc assignment closer to first usage
  platform/x86:intel/pmc: Add support to show ltr_ignore value
  platform/x86:intel/pmc: Remove unneeded min_t check
  platform/x86:intel/pmc: Use DEFINE_SHOW_STORE_ATTRIBUTE macro
  platform/x86:intel/pmc: Use the Elvis operator
  platform/x86:intel/pmc: Add support to undo ltr_ignore

 drivers/platform/x86/intel/pmc/core.c | 214 +++++++++++++-------------
 1 file changed, 109 insertions(+), 105 deletions(-)

-- 
2.34.1


