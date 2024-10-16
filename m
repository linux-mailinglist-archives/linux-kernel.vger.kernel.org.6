Return-Path: <linux-kernel+bounces-367172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD9099FF7B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 05:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 745AB1C24446
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 03:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408FA176251;
	Wed, 16 Oct 2024 03:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Loi+OPDc"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1113916088F;
	Wed, 16 Oct 2024 03:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729049364; cv=none; b=gyvmcoPDHUkXQjZMQpoINe5Xvhs1WfteQVG557tnuF5Hp1lvBKC7Y79HgUQO6oOi62UBQCjFgOxreLr8iTPvMBR6T8XAe2LiJXDu+PuRrC+Y/uH16K/NwsAjU9DEs+uh3Ynx2tUPmBNnogl8l0LQzkkiSZBs7oF3xE59g+9X7Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729049364; c=relaxed/simple;
	bh=iEdW0H6pSNWymAAe4o8Tlp8oetUQehJCG71swjVIz9s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=V6QBHIbAomVUCNPqu6NOXykpsYqmBaJItwcTCG/+LEu3x6cidLgoABniZc2D/UUgoCqD4SdaYJzBWu743bjFyHkaI94i2T0BnescndfBU7VPdSVO2EaOQitTbUetps0B2UirKNnSy4GYlyOUbZyFEmlKeiXb/sxpdx27AV7jbMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Loi+OPDc; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729049363; x=1760585363;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iEdW0H6pSNWymAAe4o8Tlp8oetUQehJCG71swjVIz9s=;
  b=Loi+OPDchjHEMhBHL9CGGxTxylxGXVyumPs9MtcxjxSKyBCK8VvGhI3L
   P+aqrD2YpruO303yO34eFSoM7jmZ2Sm1b754RNPTxFP0NRNUdVPSCXskO
   Vd676l8I6ClxS33yqec/eCYPBQYn5nQzBNL+Y0mh1u1T5h0Z6cdSr0O+d
   7aayJ9T+5n6Zyu73FY8WZZcSRRW01OH3RnRsQo0ID4QMg2ebBCaIDd/dX
   49W2mPIVPGBfogJ5MRGNJaea94/x4ZH4wHtxuLPGjMTMWdyRYamYCkNnZ
   AogjeZgqPAKpE8ZYDDydEuTrilr2EuPE2gf4RtpzGf4G1Qirzpbs02myj
   g==;
X-CSE-ConnectionGUID: /fMlyfmOSlGa2EevpEpkbQ==
X-CSE-MsgGUID: Ih5AO1fZQEy+sKN82HIe2A==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="28676500"
X-IronPort-AV: E=Sophos;i="6.11,206,1725346800"; 
   d="scan'208";a="28676500"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 20:29:22 -0700
X-CSE-ConnectionGUID: 1p0dKOPBQ/+rqTgL4b4tNw==
X-CSE-MsgGUID: jCWvcyp+TGmv1neMHNiMVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,206,1725346800"; 
   d="scan'208";a="78047632"
Received: from cvapit-mobl1.ger.corp.intel.com (HELO yungchua-desk.intel.com) ([10.247.118.236])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 20:29:19 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: broonie@kernel.org,
	tiwai@suse.de,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com,
	ranjani.sridharan@linux.intel.com
Subject: [PATCH 0/4] ASoC/SoundWire: clean up link DMA during stop for IPC4
Date: Wed, 16 Oct 2024 11:29:06 +0800
Message-ID: <20241016032910.14601-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Clean up the link DMA for playback during stop for IPC4 is required to
reset the DMA read/write pointers when the stream is prepared and
restarted after a call to snd_pcm_drain()/snd_pcm_drop(). 

The change is mainly on ASoC. We may go via ASoC tree with Vinod's
Acked-by tag

Ranjani Sridharan (4):
  ASoC: SOF: ipc4-topology: Do not set ALH node_id for aggregated DAIs
  ASoC: SOF: Intel: hda: Handle prepare without close for non-HDA DAI's
  soundwire: intel_ace2x: Send PDI stream number during prepare
  ASoC: SOF: Intel: hda: Always clean up link DMA during stop

 drivers/soundwire/intel_ace2x.c   | 19 +++++-----------
 sound/soc/sof/intel/hda-dai-ops.c | 23 +++++++++----------
 sound/soc/sof/intel/hda-dai.c     | 37 +++++++++++++++++++++++++++----
 sound/soc/sof/ipc4-topology.c     | 15 +++++++++++--
 4 files changed, 62 insertions(+), 32 deletions(-)

-- 
2.43.0


