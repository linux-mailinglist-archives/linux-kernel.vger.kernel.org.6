Return-Path: <linux-kernel+bounces-348986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A49E098EEF4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 14:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65DC328433A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 12:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8E21741D2;
	Thu,  3 Oct 2024 12:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D9KofIOU"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D99155A21;
	Thu,  3 Oct 2024 12:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727957859; cv=none; b=onFs7qf9G/izfpYtiHhQLpFmlt99z5/VQHJ8CVZu+i3kHODcADg8d4Fs8KSvNx0JIoiGsKY+gT1idksTX+vxJBzhumCTo0KGNn0xAUvSuMEM+tC9FARxLPfNIPngXcAZEP3TH4qrQzGZhdVtCt2j4JA32ODhyD4JtX9sSVQIaFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727957859; c=relaxed/simple;
	bh=UyG36ACBL7N9SkcQtESHMB/jo6qFs9GqKpv2XYuI5dg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PON/l5DdvfJkDPjWIB3cbLwT4DCG4XqPSg1PRU1uRpXQrMB5Mv9EHt0OaBmgEWbi9rAfd4jJidSdVDk9oVTD2pS5vdxOntE0S1FHJTA8RXwdbP7w2pnC7a3XVKbIyfiMESsL+jk7nfT9kLw2xp6dpCDkLXTnT2BklTrf1pnsuMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D9KofIOU; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727957858; x=1759493858;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UyG36ACBL7N9SkcQtESHMB/jo6qFs9GqKpv2XYuI5dg=;
  b=D9KofIOU8obA03Yi/70RcIBC7n7GF5fSDAX4qgjEy5xCxKmAgUHLtlUk
   JfGTDDGmF6+vs9zay46bu+uhzCm3Uo4MK9s3UCQj6DH7nPVi/8/EhfOeK
   5BuZzbzvSj5v3JRJ40VjJ18jWs4TLV9sSAqLBeYh9SBn13PH2YtZA220W
   GvKMP6uK8+ufS+GqG7fco+/vdbfTdy94UDunj7DsvkZ038DBe+KW7VxJ4
   hpBHJhwkwxUvhetqjNEGURAl+TI2YCHqZDxv4jLbd3Yh56wdQvQZ2hG1N
   o1dXX2FsgkwNqYmAdfLeT3w/CAflW4gtelbiKnvorx9HGYOTH3h8VkURi
   Q==;
X-CSE-ConnectionGUID: bB3batXdQwOcF8nxtc5LZw==
X-CSE-MsgGUID: bHoEACsEQjasuEe7WkIP+w==
X-IronPort-AV: E=McAfee;i="6700,10204,11214"; a="31029797"
X-IronPort-AV: E=Sophos;i="6.11,174,1725346800"; 
   d="scan'208";a="31029797"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 05:17:37 -0700
X-CSE-ConnectionGUID: fbxryxUaRBqPgwVxzEU9KA==
X-CSE-MsgGUID: 8cN5sDiqQnq6LqMcDljO1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,174,1725346800"; 
   d="scan'208";a="111786200"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa001.jf.intel.com with ESMTP; 03 Oct 2024 05:17:35 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 81B3E1E5; Thu, 03 Oct 2024 15:17:34 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mathias Nyman <mathias.nyman@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 0/3] xhci: pci: Amend definitions of PCI device IDs
Date: Thu,  3 Oct 2024 15:14:43 +0300
Message-ID: <20241003121729.3867216-1-andriy.shevchenko@linux.intel.com>
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

There is a new patch 1 that may be folded in the original commit by
Mathias. After this series the whole Cadence case can be amended at
once as Roger suggested.

In v2:
- dropped 'are' in the commit message (Sergei)
- added a new patch to align Cadence ID name

Andy Shevchenko (3):
  xhci: pci: Aling the naming for Cadence PCI ID 0x0200
  xhci: pci: Use standard pattern for device IDs
  xhci: pci: Fix indentation in the PCI device ID definitions

 drivers/usb/host/xhci-pci.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

-- 
2.43.0.rc1.1336.g36b5255a03ac


