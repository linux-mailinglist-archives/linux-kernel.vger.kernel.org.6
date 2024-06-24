Return-Path: <linux-kernel+bounces-227274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F2B914E9E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 15:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C38CC1F2317D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 13:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF18C13E40E;
	Mon, 24 Jun 2024 13:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kyB4s7hC"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA8C13D617
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 13:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719235781; cv=none; b=TlvmkKvbG0HC6uTX6xcfIteF0JpoDQJLvpahaLBE2BU/LpJu4KYBQL+dPWIZXlNMfE8rD3KYj1Lb/JppGVEyabP9I1fcdkQyXaRu4cpVPeXAmS9/H/5FPWSBKwhPBM6T5KUR3jQm5UpxNM39o77eFFrtY33kLjQs8VIiBIeHjdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719235781; c=relaxed/simple;
	bh=mFagSOUWkccqruGGZADp7blfKJS5WoLbdcKgzewx5pI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TWW9bIhF+SwraNGpoouGJT9g/ItN5XRlNLUpHpwBgeMA+n3D3JOmAfnrKrLJSaTYZzNgdVAEXc1AhWiUQ2N2RXSBl8W72s1i6v/1JMDy/6HsVEqLGLqrqtXW0Z9FHW9LhKapAzFtbHM2At5acJxr5f0LDtFvfc/MEoBWFSZ1kAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kyB4s7hC; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719235779; x=1750771779;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mFagSOUWkccqruGGZADp7blfKJS5WoLbdcKgzewx5pI=;
  b=kyB4s7hCJ4s2CTkUwWYFVokUdHfmsHDhbMYa00lZzTbxnVF24YyH00N5
   8et7tj0FgvZykAFbvIRcqyCM+ZCUTcTub6HJsBielsGA3a3wFkcoWZFcE
   EplfxiYe5DECTafGzMUfeKZBskTHg1lyxLXvgKy//zramYFHk8h/qaLfa
   1YPAJWSNfU8RXYzidceVzew6pYUpkBzUL9P5FuWdhY9z4gIJ+qQh37VtL
   D4Tfhgw4zzShtrB0JiDbOWz9T1GKn/dnXk6t9aZtyJeLSQWWpzGx5A/Ya
   Pg1aMpOXmCUp5shWaxbS0D6C35mCcNN4DQvpA0a+mOcFixuF98ihWNslB
   g==;
X-CSE-ConnectionGUID: N0EmJa5PSCOj6fNNOsRtwA==
X-CSE-MsgGUID: vJRgetE+RMm43ekRgWs5sA==
X-IronPort-AV: E=McAfee;i="6700,10204,11112"; a="26830733"
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="26830733"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 06:29:38 -0700
X-CSE-ConnectionGUID: KPX8NfkeSkyqHvtqD+/Ogg==
X-CSE-MsgGUID: CwOdAXcjSaqK+EF5kvtRJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="47746659"
Received: from wentongw-optiplex-7000.sh.intel.com ([10.239.154.127])
  by fmviesa005.fm.intel.com with ESMTP; 24 Jun 2024 06:29:36 -0700
From: Wentong Wu <wentong.wu@intel.com>
To: sakari.ailus@linux.intel.com,
	tomas.winkler@intel.com,
	gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Wentong Wu <wentong.wu@intel.com>
Subject: [PATCH v3 0/5] Fix MEI command timeout issue following warm reboot
Date: Mon, 24 Jun 2024 21:28:44 +0800
Message-Id: <20240624132849.4174494-1-wentong.wu@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While enabling the IVSC on certain recent commercial products, the chipset
may occasionally enter an unknown state following a warm reboot. This issue
can cause the firmware to fail in responding to the MEI command from the
host, despite the firmware being re-downloaded. To resolve this, the current
patch set incorporates reset logic during system shutdown to ensure that the
IVSC chipset remains in a valid state after a warm reboot.

Furthermore, after the firmware download is complete, the firmware requires
some time to become operational. To enhance this, additional sleep time has
been introduced before the initial read operation to prevent a confusing
timeout error in vsc_tp_xfer().

Additionally, this patch set includes several enhancements as well:
1) utilizing the appropriate byte order swap function for data received
from the ROM;
2) correcting a spelling error in a comment;
3) constructing the SPI transfer command as per the specific request.

---
v2 -> v3:
 - switch code from `ibuf ? tp->rx_buf : ibuf` to `ibuf ? tp->rx_buf : NULL`

v1 -> v2:
 - remove cc spelling fix to stable
 - remove the reset toggling enhancement

Wentong Wu (5):
  mei: vsc: Enhance IVSC chipset stability during warm reboot
  mei: vsc: Enhance SPI transfer of IVSC rom
  mei: vsc: Utilize the appropriate byte order swap function
  mei: vsc: Prevent timeout error with added delay post-firmware
    download
  mei: vsc: Fix spelling error

 drivers/misc/mei/platform-vsc.c  |  4 ++--
 drivers/misc/mei/vsc-fw-loader.c |  2 +-
 drivers/misc/mei/vsc-tp.c        | 18 ++++++++++++++++--
 3 files changed, 19 insertions(+), 5 deletions(-)

-- 
2.34.1


