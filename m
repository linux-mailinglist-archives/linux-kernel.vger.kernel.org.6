Return-Path: <linux-kernel+bounces-397740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 268299BDFBB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 08:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 259741C20F2B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 07:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848961D1302;
	Wed,  6 Nov 2024 07:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iyCq0UKC"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7169B3C39;
	Wed,  6 Nov 2024 07:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730879626; cv=none; b=mjwV9NBDyCh1xf2JiIhlXPXzaQDxqa/eoLNfrmasuc9omtMNwbqa5x6YgUhQ1yLq9H9H4snPN/8P8o771O7SdfDHcJO6mha9tfAQAa9Vd93+KLTj0CYvdQmgcH6RhmKWu1NzUSXBI83iXHXP6SscQm6F0PI09jASWX+A8pge9I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730879626; c=relaxed/simple;
	bh=9/OY2lc1XpuzQpKeUZPizSiod5Pyfy2mAMCYeJO3DBY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lypOE2926dD0wKE1mJ+5BlyiTu8oDplvtU0NDZAVfUySzK1SuTjWa4EsI3f7lDa2W4Vuj+kFrHHPGc5KcYCrAEr6whNXuAjS1kpGqvlR0oYKGz9sztX2Dx62vvTR0J5L4jacXsuQTd0DN82KYRME7m7MKvwoRoAVvkh492pvB48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iyCq0UKC; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730879624; x=1762415624;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9/OY2lc1XpuzQpKeUZPizSiod5Pyfy2mAMCYeJO3DBY=;
  b=iyCq0UKCTn90JQve3ug2afprj41hCgWkiTAoxNvxWymlHFHG7ZbT7nNy
   4SocdpiVki13O7KSuhbiYXXQ1rA/sFgv1+u9BT831PUShT0g7P83kqLx6
   eFfLsKoLbRdQfbSQnam014j5FstNEg08Ntp6REoNmHz9OeYc9a6/FrLkF
   dx6cpJ42OdWsadoMhujd8vONdoO+nnwMsHdtpSiCHzTI/qWxr0GbosF5S
   1Bf9oCW6KCrmZX6cGkOzNlcOEfEblNnfbZXZzQ98b84ZbUuts1b2309z2
   B2+PnGPBz6zGL0Ldiy2OVtZ177ykeQHfNLN0zUjMJoDRM+8ozPqTsbcv+
   w==;
X-CSE-ConnectionGUID: iGNOM7p1SzqVcX+IHRaxUg==
X-CSE-MsgGUID: Q4b6e+GDTXG9H8JJnn00VA==
X-IronPort-AV: E=McAfee;i="6700,10204,11247"; a="30092947"
X-IronPort-AV: E=Sophos;i="6.11,262,1725346800"; 
   d="scan'208";a="30092947"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 23:53:44 -0800
X-CSE-ConnectionGUID: C3SAXe41T+id0CSCRajKyQ==
X-CSE-MsgGUID: bDMxz+2WRTe2XDuCemWDaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,262,1725346800"; 
   d="scan'208";a="121901847"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.244.56])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 23:53:16 -0800
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: vkoul@kernel.org,
	perex@perex.cz,
	tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	broonie@kernel.org,
	amadeuszx.slawinski@linux.intel.com
Subject: [PATCH] ALSA: compress_offload: Use runtime pointer in snd_compr_poll()
Date: Wed,  6 Nov 2024 09:53:12 +0200
Message-ID: <20241106075312.15601-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

runtime is not used as seen with W=1 :
sound/core/compress_offload.c: In function ‘snd_compr_poll’:
sound/core/compress_offload.c:409:35: error: variable ‘runtime’ set but not used [-Werror=unused-but-set-variable]
  409 |         struct snd_compr_runtime *runtime;
      |                                   ^~~~~~~

Instead of dropping the runtime, use it in the function in place of
stream->runtime

Fixes: 04177158cf98 ("ALSA: compress_offload: introduce accel operation mode")
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/core/compress_offload.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index 5ecdad80a0d8..86ed2fbee0c8 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -418,7 +418,7 @@ static __poll_t snd_compr_poll(struct file *f, poll_table *wait)
 
 	guard(mutex)(&stream->device->lock);
 
-	switch (stream->runtime->state) {
+	switch (runtime->state) {
 	case SNDRV_PCM_STATE_OPEN:
 	case SNDRV_PCM_STATE_XRUN:
 		return snd_compr_get_poll(stream) | EPOLLERR;
@@ -426,7 +426,7 @@ static __poll_t snd_compr_poll(struct file *f, poll_table *wait)
 		break;
 	}
 
-	poll_wait(f, &stream->runtime->sleep, wait);
+	poll_wait(f, &runtime->sleep, wait);
 
 #if IS_ENABLED(CONFIG_SND_COMPRESS_ACCEL)
 	if (stream->direction == SND_COMPRESS_ACCEL) {
@@ -445,18 +445,18 @@ static __poll_t snd_compr_poll(struct file *f, poll_table *wait)
 	avail = snd_compr_get_avail(stream);
 	pr_debug("avail is %ld\n", (unsigned long)avail);
 	/* check if we have at least one fragment to fill */
-	switch (stream->runtime->state) {
+	switch (runtime->state) {
 	case SNDRV_PCM_STATE_DRAINING:
 		/* stream has been woken up after drain is complete
 		 * draining done so set stream state to stopped
 		 */
 		retval = snd_compr_get_poll(stream);
-		stream->runtime->state = SNDRV_PCM_STATE_SETUP;
+		runtime->state = SNDRV_PCM_STATE_SETUP;
 		break;
 	case SNDRV_PCM_STATE_RUNNING:
 	case SNDRV_PCM_STATE_PREPARED:
 	case SNDRV_PCM_STATE_PAUSED:
-		if (avail >= stream->runtime->fragment_size)
+		if (avail >= runtime->fragment_size)
 			retval = snd_compr_get_poll(stream);
 		break;
 	default:
-- 
2.47.0


