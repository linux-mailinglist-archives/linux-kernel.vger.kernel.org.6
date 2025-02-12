Return-Path: <linux-kernel+bounces-511790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CBE6A32FB6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 20:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 110FD165445
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 19:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF581FF7C8;
	Wed, 12 Feb 2025 19:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IjGzuLHY"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50D1271813;
	Wed, 12 Feb 2025 19:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739388685; cv=none; b=X00wPuXJch/RElv9kGptGtnz7s0oc1BbV/wOczdZMfhNQHlNf7bFbjr0iUIRbcgwTmOeEysiv5v6ujMMRK+JNX35LX2+0htaIVDmIxFLVOWHGFuzXvwUTt3606DM7B+eTnGF+aipAFbF+pRHmke4VTSyoHLtZIT7+7iO5vFFhrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739388685; c=relaxed/simple;
	bh=ogjElKZkP71ejQJYT0hwP3uHhRqvyb4B8WNqvdEWaog=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PgL0HqDP1enqVJgNvsy0Cv6h3UWSfWlqz1NtzNsALN2iFps+yGTRFQvSxit4ru6ioOSIP71qvId6R2nyjwYOQDXceVJZzVceAMzZsK/KpmQhySvlGF/6B42cKG1I/Ni3WdlvRv00Ow1Ffd7j7ngui/uD1YfjUQgSZ2+rk9aWriU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IjGzuLHY; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739388684; x=1770924684;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ogjElKZkP71ejQJYT0hwP3uHhRqvyb4B8WNqvdEWaog=;
  b=IjGzuLHYasEgLq+YzohumRpuKshVWSErsJphSYvR7S2aFleeoTxJja3f
   N67iTveLVqdtHuyV+fgSFhh/WdX0R2rNSU6CkY3xJ/vE1RHMcXZ6VMNHJ
   wBkbtCpcNu1sbCoT7GHITSkkr7QdHJNeXd7Wd7nrpwvOP9MuNudydKi/x
   KLs5CPsyusE+YiXZK+sLrl3ptvGr0ghUSHWVVUimaG2tvNsJUAQXfpmnO
   esXOJiGWRrqo51ODfpv1SgcdIQslndcVm+PV8XMBmiWN18B9j3PXZ/0CJ
   gXN9CnP1+ovEDhNc05dC6DiQbzBkQqyAcrG5z2YjGarNp6kd8eE7fjGEB
   Q==;
X-CSE-ConnectionGUID: dbuSkH5STyCes+FDll1E0g==
X-CSE-MsgGUID: eWUY/nRAQH+Lk1TIymQfng==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="40183655"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="40183655"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 11:31:23 -0800
X-CSE-ConnectionGUID: tC83V0vbQ9mAzWQWQQ43FQ==
X-CSE-MsgGUID: c1U2mCFeTuuJzZZwviugoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117542533"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa005.fm.intel.com with ESMTP; 12 Feb 2025 11:31:20 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 4623011E; Wed, 12 Feb 2025 21:31:19 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Felipe Balbi <balbi@kernel.org>,
	linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 0/4] usb: dwc3: Avoid using reserved EPs
Date: Wed, 12 Feb 2025 21:28:00 +0200
Message-ID: <20250212193116.2487289-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.45.1.3035.g276e886db78b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On some platforms (Intel-based and AFAIK ARM-based) the EPs in the gadget
(USB Device Controller mode) may be reserved for some special means, such as
tracing. This series extends DT schema and driver to avoid using those.
Without this the USB gadget mode won't work properly (those devices that
"luckily" allocated the reserved EPs).

Changelog v3:
- split refactoring as preparatory change (Thinh)
- renamed variable and function (Thinh)
- added a warning in one place (Thinh)
- gathered tags (Ferry, Rob, Thinh)

Changelog v2:
- added minItems to the schema (Rob)
- revisited code and add NULL check to avoid crashes (Thinh)
- rewrote helper function to return error to the user if parsing fails
- elaborated in the commit message why we need this quirk (Thinh)
- addressed miscellaneous style issues (Thinh)

Andy Shevchenko (4):
  dt-bindings: usb: dwc3: Add a property to reserve endpoints
  usb: dwc3: gadget: Refactor loop to avoid NULL endpoints
  usb: dwc3: gadget: Add support for snps,reserved-endpoints property
  usb: dwc3: gadget: Avoid using reserved endpoints on Intel Merrifield

 .../bindings/usb/snps,dwc3-common.yaml        | 11 ++++
 drivers/usb/dwc3/dwc3-pci.c                   | 10 +++
 drivers/usb/dwc3/gadget.c                     | 63 +++++++++++++++++--
 3 files changed, 79 insertions(+), 5 deletions(-)

-- 
2.45.1.3035.g276e886db78b


