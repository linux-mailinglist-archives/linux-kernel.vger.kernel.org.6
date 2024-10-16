Return-Path: <linux-kernel+bounces-367832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D751E9A074D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 12:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14FE31C26993
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 10:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C92E212EEE;
	Wed, 16 Oct 2024 10:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eeESmpRm"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C20E212EE5;
	Wed, 16 Oct 2024 10:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729074265; cv=none; b=aUhWgOYDza4KtE5YzwQmmjuUlGWMenWt8ph+hwZEc+qd7Fce9EOkkBr3c6B3ka8Ndhf4lwXjzdQZKPA3TFtkYzYljn0aCma+pu27plp5PM3EORDwDanY2q99Rjo3fYNDiiO97pHZ6lkMe8GsiMchaL6TSqsZfAMMr4tgif2geyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729074265; c=relaxed/simple;
	bh=JyhxhUVd8DyT3ftBCZnDzf7V31bEENXyt/3/kHeBsEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VgJY7t5tuMxAZEYa/+/vlXtgkduFdqGTeSgyFngE2W/1VXora7mshE+wKj9boI/kaQ861KVPFKXv+FiFi9R3HGyObPHVhNAyt4y9zrMjL9czlnfwwBAJjjBN9xfeAGYt8HUgdp4GRZH64MSg4zzcgJEjd8eLDEx19DgeZWfv5ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eeESmpRm; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729074265; x=1760610265;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JyhxhUVd8DyT3ftBCZnDzf7V31bEENXyt/3/kHeBsEY=;
  b=eeESmpRmj/DKZkI2qFP/yRFi23dFsbAyLinEfTNskQ2Sw5gl9Ee2VB6H
   A3l2Ry1LMzbDWEaAjRBUHZpAoPkvXekZZBPY2X0/Qbv2tf0yw2Joqk1Zp
   V/9XSDPlRJAAWtgCWGrCg9CyRnEgG0JhwXJFwo0l3s2n+ATJBVV5tKRce
   Z+BSei9BpSWHMolprOCeOkOo12lag2AwkHZqz1MNMxQ4KqkxK0DzyqHQj
   NKSmMQM+2pb88y5OHVVOTtVABFKeCGGoYZ/i1urFOxKtjoBxpJXk08HcE
   XLvkVCXf2GX5is59pX9Iuv+W8v1Z/aaqIEZ6NScjDDw2OG5k6SaVAx7Vs
   Q==;
X-CSE-ConnectionGUID: Z8PgeoHgQgiGQMxWdkHEyA==
X-CSE-MsgGUID: TfnFR4y+R1yRwtGEKGkPlg==
X-IronPort-AV: E=McAfee;i="6700,10204,11226"; a="27985947"
X-IronPort-AV: E=Sophos;i="6.11,207,1725346800"; 
   d="scan'208";a="27985947"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 03:24:24 -0700
X-CSE-ConnectionGUID: 85SBHPE5QYebM675VApPew==
X-CSE-MsgGUID: NY1lfgY5Q4KhZlACQCWSwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,207,1725346800"; 
   d="scan'208";a="82961045"
Received: from cvapit-mobl1.ger.corp.intel.com (HELO yungchua-desk.intel.com) ([10.247.118.236])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 03:24:22 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: broonie@kernel.org,
	tiwai@suse.de,
	vkoul@kernel.org
Cc: vinod.koul@linaro.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	pierre-louis.bossart@linux.dev,
	bard.liao@intel.com
Subject: [PATCH 11/11] ASoC: SOF: Intel: hda: use machine_check() for SoundWire
Date: Wed, 16 Oct 2024 18:23:33 +0800
Message-ID: <20241016102333.294448-12-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241016102333.294448-1-yung-chuan.liao@linux.intel.com>
References: <20241016102333.294448-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Use the new machine_check() callback to select an alternate topology
for RT712-VB devices.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 sound/soc/sof/intel/hda.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
index 9abc4c071ae5..38921c0db84e 100644
--- a/sound/soc/sof/intel/hda.c
+++ b/sound/soc/sof/intel/hda.c
@@ -1124,7 +1124,8 @@ static struct snd_soc_acpi_mach *hda_sdw_machine_select(struct snd_sof_dev *sdev
 		}
 		/* Found if all Slaves are checked */
 		if (i == hdev->info.count || !link->num_adr)
-			break;
+			if (!mach->machine_check || mach->machine_check(hdev->sdw))
+				break;
 	}
 	if (mach && mach->link_mask) {
 		mach->mach_params.links = mach->links;
-- 
2.43.0


