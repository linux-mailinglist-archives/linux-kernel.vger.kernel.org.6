Return-Path: <linux-kernel+bounces-430626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8FB9E33B1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 07:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35CC5B251DC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 06:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E771618871E;
	Wed,  4 Dec 2024 06:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HVWEpzDD"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63CC16F851;
	Wed,  4 Dec 2024 06:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733294898; cv=none; b=r0n0qe4xovzppfFslUG5Vl4yM8bl1swkNePSTHnxcRBh/hHgd1cF4xFzQHQ8rQT+H5RCLiAJFk2YVp5g6pQU0UC1ZWCd05s74c/oUmeXTctaudVabn4LIibpFJSs/qqpHXP1Y2jeeOb4tPul5pQVTVo19sHPjznV3uXheD1rjYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733294898; c=relaxed/simple;
	bh=1JUZzPH1FFTZrW9waucyGpdYmJwLWnFLRiA9SPJla/I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=S0C23Hvxrjof3XIpyzRKX+/4m8fYc9raNdmQ+/gWrUKalVmR0DuP4f2aEupAFz8WQxgMRN51Lh70cHMwnbgek4oB9w6m7juJ3VqWizSHEr7s4Vs4gRXmfokomeGyQLNHytyB/nYXhwkE2laTZWDENtcwQhmKyl+vwylaT3QfjAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HVWEpzDD; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733294897; x=1764830897;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1JUZzPH1FFTZrW9waucyGpdYmJwLWnFLRiA9SPJla/I=;
  b=HVWEpzDDGgAIefdvvl26wD/xe2Uwilt7qk56bS8GwCTchGzPcjpo1UcV
   907MFVgI5Olsn3/8zOtvnFWEEkZ2ML9nCfuvrBCH3X5ZYTYK8SOWtigDV
   uVbCiPeOfqkqka3GS76t9oKC/ftVvmTudrZiU6PomsQLs4TPEPzqudCpu
   gF3jfkIB5Lasb1ICjuZBNV0k3sBq8PkScl8/Arqa1TcZaI4qgv0Py1keN
   Q3t/n3rjGO8YMIMx7uupIoHZxuHDU/A58tIRHbp67g6Quwm2T800aP8bj
   RA0mYWZ2YaFXSB27pI45iY91AHsomVC+ZPNPjfl6oNfiS6J8EWswmkS3R
   Q==;
X-CSE-ConnectionGUID: J0Zcg44+RQ+A4L1CeeVYCA==
X-CSE-MsgGUID: J2yQF7CLTWuoR4OygY95Vw==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="32904896"
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="32904896"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2024 22:48:16 -0800
X-CSE-ConnectionGUID: jINbh/T2RAGXAjyGXBomLQ==
X-CSE-MsgGUID: WWlaoC4SS8Op2RnHNc25PA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="94017359"
Received: from apgcp0h592126.png.altera.com ([10.244.75.134])
  by fmviesa010.fm.intel.com with ESMTP; 03 Dec 2024 22:48:13 -0800
From: Mun Yew Tham <mun.yew.tham@intel.com>
To: Dinh Nguyen <dinguyen@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Niravkumar L Rabara <niravkumar.l.rabara@intel.com>,
	Boon Khai Ng <boon.khai.ng@intel.com>,
	Rohan G Thomas <rohan.g.thomas@intel.com>,
	Karnan Shanmugam <karnan.shanmugam@intel.com>,
	Mun Yew Tham <mun.yew.tham@intel.com>
Subject: [PATCH net-next 0/1] Add ethernet mac support for Agilex5
Date: Wed,  4 Dec 2024 14:47:54 +0800
Message-Id: <20241204064755.10226-1-mun.yew.tham@intel.com>
X-Mailer: git-send-email 2.26.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Tham, Mun Yew" <mun.yew.tham@intel.com>

This patch set add three Ethernet MAC support for Agilex5 platform.

The OOBE daughter card with ethernet phy connects to the gmac2 via
rgmii interface.

Tham, Mun Yew (1):
  arm64: dts: intel: agilex5: add ethernet mac support

 .../arm64/boot/dts/intel/socfpga_agilex5.dtsi | 342 ++++++++++++++++++
 .../boot/dts/intel/socfpga_agilex5_socdk.dts  |  18 +
 2 files changed, 360 insertions(+)

-- 
2.26.2


