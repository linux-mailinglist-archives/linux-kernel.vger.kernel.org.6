Return-Path: <linux-kernel+bounces-303373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56878960B4D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 15:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1379C284334
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 13:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7321BD015;
	Tue, 27 Aug 2024 13:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ejjZNQoF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784BB19EED3;
	Tue, 27 Aug 2024 13:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724764077; cv=none; b=QqJUdxyU5gKnbD+tyN8nEyatFKAR6/shiDx4HskCH25aHQlmGvLJ/SO3Sy8xIb2vUdQ0mYHmLZKtE5qZ0jBQxPF6SXBhA15ZG3aNBMogMXKLwS1qrKvYDaFP3zfRB4CzjIUFbixCKN25LMcAuf8uGW3/OTe7comraVbDatKEqnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724764077; c=relaxed/simple;
	bh=g8EdWN1aG0i9+5j033Mo81mdDdaXXjAa6yW3FXpjIzE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sl5BEOcoEGvyCY9lJATEfxZkPQKj33Nq6GdE2YPZxRvmmHbMbWd/8oKSVbWZnIQZhR7xH2oPJMm2s755x2e8jRrFW77V2AbCZT+ZrL1qj5wh4B3kdemB7C1cLtkIMB2Kvxw7uYFKpFDdBSDiVOVfZudYDDhgFloIg51iW4gBr7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ejjZNQoF; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724764075; x=1756300075;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=g8EdWN1aG0i9+5j033Mo81mdDdaXXjAa6yW3FXpjIzE=;
  b=ejjZNQoFGtDoKhOhj6l4VW3L3qQ1eJ0zGRIO6ODg+fF/C/C3T9au4SEZ
   D8m+wxf+C+EwnT5+acMnehyiKKzkiMxzxDWcECYf5Om3EGcO4K35jF/5n
   3BL3+dKd7k51ZHUVKXDKw6dF039CcEKyNPVaqvvEjoIQBRD4A6rz8gdDX
   GtWabxZDn192xGaXTZavcs0nZ4tWTLfou7MckulTlY5COshaGOP/vs2cG
   oJ/z7qE0/OvqzwTF0yY4wSnrYrrzHgdxQL+N7Dry30440SeTIsDllu31K
   zxLIq5O4HUm2HBmsxROVkPMT5PSEoDmETWy7dQGqfs7vjfxbMAZsdMQi4
   A==;
X-CSE-ConnectionGUID: fab1+PgxS4ODmEGDXtSqYw==
X-CSE-MsgGUID: FLL672hNSomV8jVkXCDaRA==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="23400478"
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="23400478"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 06:07:54 -0700
X-CSE-ConnectionGUID: JyqMZngZS0G7ZaRqNJHWsw==
X-CSE-MsgGUID: U7fvSmVJSGOivVDOqiB8Nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="67551929"
Received: from anmitta2-mobl4.gar.corp.intel.com (HELO yungchua-desk.intel.com) ([10.247.118.39])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 06:07:53 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: linux-sound@vger.kernel.org,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	bard.liao@intel.com
Subject: [PATCH 00/14] soundwire: mipi-disco: add partial SoundWire Disco 2.1 support
Date: Tue, 27 Aug 2024 21:06:53 +0800
Message-ID: <20240827130707.298477-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds partial support for the SoundWire Disco 2.1.

Pierre-Louis Bossart (14):
  soundwire: mipi_disco: add MIPI-specific property_read_bool() helpers
  soundwire: optimize sdw_stream_runtime memory layout
  soundwire: optimize sdw_master_prop
  soundwire: optimize sdw_bus structure
  soundwire: optimize sdw_slave_prop
  soundwire: optimize sdw_dp0_prop
  soundwire: optimize sdw_dpn_prop
  soundwire: mipi-disco: remove DPn audio-modes
  soundwire: mipi-disco: add error handling for property array read
  soundwire: mipi_disco: add support for clock-scales property
  soundwire: mipi-disco: add support for peripheral channelprepare
    timeout
  soundwire: mipi-disco: add comment on DP0-supported property
  soundwire: mipi-disco: add new properties from 2.0 spec
  soundwire: mipi-disco: add support for DP0/DPn 'lane-list' property

 drivers/soundwire/mipi_disco.c | 151 ++++++++++++++++++++-----
 include/linux/soundwire/sdw.h  | 200 +++++++++++++++------------------
 2 files changed, 213 insertions(+), 138 deletions(-)

-- 
2.43.0


