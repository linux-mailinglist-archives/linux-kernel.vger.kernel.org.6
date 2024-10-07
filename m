Return-Path: <linux-kernel+bounces-353248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B004992B36
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 14:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0FB4284090
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 12:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C04041D26E8;
	Mon,  7 Oct 2024 12:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dZt5jtq1"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878401D222B;
	Mon,  7 Oct 2024 12:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728303175; cv=none; b=Ji5OemVXX5G/DChQjDU1lSw7KgP7feA+4ZzlEj2cw773Yw5+Ngaw+ANIVN31WSFqQlt9Cj1FEfJ7nscYkrRhgxGp+ayu2Sn56s/JIecedB34tYIBzKYnptyDI43ULwWh9Ai+1LKyE2TLyXpHiFukuEosxzUoITqOwYDVJnrqDxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728303175; c=relaxed/simple;
	bh=WSpJ6s/WmJbglCA4dpZ/faieIFmWF3blg5LWtf4LXKU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SmUi2OYNhXHYdJFfco6HRXqhhDk42AK2eJX9WgYeQmHIgvymph2BipmFUjgD19J9lHw9Lj5nTxDE8gm6RzOyhJycHYbeCoPqxnlfzFwaXtaV2FW1tv8iNO2dmnoW/7Wxmv4Mkn+j5cgBahvllI88lNfmXBlv0ZBq/jngRDsx9hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dZt5jtq1; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728303174; x=1759839174;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WSpJ6s/WmJbglCA4dpZ/faieIFmWF3blg5LWtf4LXKU=;
  b=dZt5jtq1QetYTDsrzjRNKR8BIEQIyluFXT2nk+Lsra8TCgFjwuNxqdqt
   ixhB4x5isHh5usbAjbFr+UrKNOWA2Y+emHktxgfu0IFO/U/qogA6fseTt
   5pebDu1M3dhzU0dKeB5i3pswHCoy4S07IRuQ9CUg2Eo8wU/yAdM1G1+Z+
   sV5yZSvHurMAIY80Ys+KrVM1jqZkCKp1399bc5IKVX8jyWn1Mi/AItfd7
   3J66DaO/h6QDtk4NQTnC5QhNOdzeffLhtXGixEXJ/dV5Yt050MaK4IiO9
   aKFhcJFDMG5Mvaakpr3sulBDjv3R+0OqOTeD1xtPrBONvUDhBQwrepM2I
   g==;
X-CSE-ConnectionGUID: nHTKgwZOTM+fgbX+gwNX+w==
X-CSE-MsgGUID: qXqXTlz2Tj67Aaadv4OY/g==
X-IronPort-AV: E=McAfee;i="6700,10204,11217"; a="15064789"
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="15064789"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 05:12:53 -0700
X-CSE-ConnectionGUID: EoN9DUosRTm6gydHaa27EQ==
X-CSE-MsgGUID: nhTmu6+ZSeu2g41fPAf7sA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="80246858"
Received: from anmitta2-mobl4.gar.corp.intel.com (HELO yungchua-desk.intel.com) ([10.247.118.70])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 05:12:50 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: broonie@kernel.org,
	tiwai@suse.de,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com,
	peter.ujfalusi@linux.intel.com
Subject: [PATCH 0/2] ASoC/SoundWire: Simply interrupt enabling for Intel
Date: Mon,  7 Oct 2024 20:12:39 +0800
Message-ID: <20241007121241.30914-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is more logical to couple interrupt enabling/disabling with
power-up/down sequences.

The change is mainly on ASoC tree. Can we go via ASoC tree with Vinod's
Acked-by tag?

Pierre-Louis Bossart (2):
  ASoC: SOF: Intel: hda-mlink: expose unlocked interrupt enable routine
  ASoC/SoundWire: Intel: lnl: enable interrupts after first
    power-up/before last power-down

 drivers/soundwire/intel_ace2x.c |  7 +++++++
 include/sound/hda-mlink.h       |  4 ++++
 sound/soc/sof/intel/hda-dsp.c   |  5 -----
 sound/soc/sof/intel/hda-mlink.c | 18 ++++++++++++++++++
 sound/soc/sof/intel/hda.c       |  2 --
 sound/soc/sof/intel/lnl.c       | 10 ----------
 6 files changed, 29 insertions(+), 17 deletions(-)

-- 
2.43.0


