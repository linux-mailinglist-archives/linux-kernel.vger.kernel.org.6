Return-Path: <linux-kernel+bounces-327804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B125977B6A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 10:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4B531F26E98
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 08:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E3E1D6DA3;
	Fri, 13 Sep 2024 08:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CqRBYqiX"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACD41BC075;
	Fri, 13 Sep 2024 08:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726217057; cv=none; b=MX+ala42fh7kmwgw3AgzuvH7aHSeJ3C/GsLbZSUZUsWuRJBO61GO1K8dF9TIcY5u+hVSjQM9JnWfdcO4eM7Lv+jncp9dsVDHcYla2LLBCMNc1bwEjuwUGPMiyf4EQ3+m8BlDON6FxJ8bF6+Tpm3yzjIWI1WTHKmLSlgVBhHKKlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726217057; c=relaxed/simple;
	bh=SlHr7gBadzFaExcdwqHHjO9/LRdWJ/0pSFefJXmWUlQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=I1wFfuk3es/ypABQ3ntD+V/5plfOmfW4iwC9nnsHd9mkWCr0p0QECQf1Su7NYgvXEs0jS/XTYXqKfqDw5MiQDR01SECHT1sjQOV7U/dI3sBcaa3YRf6M0GDxlHPW1bwl14+u2AvDZcLqYrALQjmz3+JifBd5znrNERaGHcEy1g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CqRBYqiX; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726217056; x=1757753056;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SlHr7gBadzFaExcdwqHHjO9/LRdWJ/0pSFefJXmWUlQ=;
  b=CqRBYqiXAbZ/y7ccllB0RCvB1LpCpORFkStSeikAop0xOcp/7V7KA8aP
   4KcvBHth1zsPt4wtRJABtY92mZnM5Vyk2a3QgGfRWf/AAaiWJOkmFxH/o
   kML9YVYymj9JwqgwTP4txYK7s88nmnd6q7FayHKYARFMw/qmQa6Mcqgru
   n9US7hxLXiA79XrAFvVpZu4bDUEjKw2we7FBXuKSKvdGE7weFsnlkav91
   yXfNrSmwui7ReOoBjoUinxrI/UZmjwcdp13mSddkKW1RdPdyGmZL74/64
   p+UgAAydceW7CuXGDrcGTfBNL4Ag5SEU9mzaFB4srdHERfUZJqLClecuh
   A==;
X-CSE-ConnectionGUID: noq7EyIMQ2eJEY+EBQgjHw==
X-CSE-MsgGUID: tCVaTeTTS2iYY1lL4i4vcA==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="50523445"
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="50523445"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 01:44:15 -0700
X-CSE-ConnectionGUID: XPIf3vyGQoqG+0eyBVTYFg==
X-CSE-MsgGUID: f9njAnDXStmIhcNgdMtB3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,225,1719903600"; 
   d="scan'208";a="72979093"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa004.jf.intel.com with ESMTP; 13 Sep 2024 01:44:12 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 73CD0334; Fri, 13 Sep 2024 11:44:11 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mathias Nyman <mathias.nyman@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 0/2] xhci: pci: Amend definitions of PCI device IDs
Date: Fri, 13 Sep 2024 11:43:36 +0300
Message-ID: <20240913084411.3309911-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1336.g36b5255a03ac
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Amend the definitions of PCI device IDs.

Andy Shevchenko (2):
  xhci: pci: Use standard pattern for device IDs
  xhci: pci: Fix indentation in the PCI device ID definitions

 drivers/usb/host/xhci-pci.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

-- 
2.43.0.rc1.1336.g36b5255a03ac


