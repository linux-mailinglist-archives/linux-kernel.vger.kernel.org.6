Return-Path: <linux-kernel+bounces-306576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD0979640B8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 11:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6764DB21CC1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 09:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E28318CC18;
	Thu, 29 Aug 2024 09:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WpwyEXT6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A31156875
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 09:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724925451; cv=none; b=l8NnY6jG2PUgVGcWOC1QMdts/RByg6EWUbL8WISanYf5I7tsLLV5e2cB+pCIbGw088DVsJQ9PCClfAMIuoXZPWHkBlJ+C9Y88PgMBk2wsUEquNOUnbuZlMviq6rEWal+h971qGBXpJW9HerIQjvtwUEQKRLTB2J027PaRBSp1uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724925451; c=relaxed/simple;
	bh=b1ywdumCTTgxBm50tmNifq21TKUasPcz6GV1DeDwK+E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Gco2AfX/t62iuj/DvE2X8dj7eraEFVQ5T4zNIV3URANyoVbUUx2d2KbXYiUIYX3IpLeuwOmgouayuBPGG7QQ8Yl/I3R7EQp5EkyqloJA+NOCFkJ/A8TOT/wAUy+i92u+84CiMMlpq1HtDY6zJLVhBJvahIt0CKxQKCal7D8wgbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WpwyEXT6; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724925450; x=1756461450;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=b1ywdumCTTgxBm50tmNifq21TKUasPcz6GV1DeDwK+E=;
  b=WpwyEXT6G2vnowgrSwWUD0Jaq5xLld/EP8jsrT6ynaKzPukiyYXdZeTI
   w7QVoU9aK/PH6DUkVU+/ZX4A9TWu4fKAPaUYuX7YDA4ame2PG0ZEWX0uI
   2Frwwwg28J9/Crt5ZWxseM2a2f0tGWpBaCOrj/+ZzmZ3WviJU4HOtWQSg
   3eis6EBL/HZ+DJBYTOxrbkrASUJmRTCLqsqW60wh+LFfl1PJT7WIKV90S
   zLKFSVDWUYpsWpNg+VWQ09iwL5k3l5vnZ1EIYMRifmBIR9oYZzsxK7GJB
   wplihIkG58EzsGN0pFcu3KoZl+blakn+oQlmmDeMnelGuiyN+OJCUJdTW
   w==;
X-CSE-ConnectionGUID: D4ByTQo1RFisRd3+RGgWRw==
X-CSE-MsgGUID: 1cD4IKMiSPCfPpa+3oFhMQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="23391530"
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="23391530"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 02:57:29 -0700
X-CSE-ConnectionGUID: W+5vM121SzqsvTf5kIeBoQ==
X-CSE-MsgGUID: 9qKF2jQ1SESpWZHZe4BE/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,185,1719903600"; 
   d="scan'208";a="63155058"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.59])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 02:57:27 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Lee Jones <lee@kernel.org>,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 0/2] mfd: intel-lpss: New LPSS PCI IDs
Date: Thu, 29 Aug 2024 12:57:17 +0300
Message-Id: <20240829095719.1557-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

Here are a few LPSS PCI IDs for new platforms. The Arrow Lake-H one was
sent already in the previous cycle but it might have fallen through the
crack so resending it here.

Ilpo Järvinen (2):
  mfd: intel-lpss: Add Intel Arrow Lake-H LPSS PCI IDs
  mfd: intel-lpss: Add Intel Panther Lake LPSS PCI IDs

 drivers/mfd/intel-lpss-pci.c | 39 ++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

-- 
2.39.2


