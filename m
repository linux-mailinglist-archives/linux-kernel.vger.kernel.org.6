Return-Path: <linux-kernel+bounces-367173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE2D99FF7C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 05:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EA681F251B8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 03:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C79918595E;
	Wed, 16 Oct 2024 03:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D+bqdsWq"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C07817C210;
	Wed, 16 Oct 2024 03:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729049367; cv=none; b=i4d0QY/Rz0MQ+bf/eLGPfUPdbbWCyTmvuPOL8hjBsPrWF8pRHtuQQHpbX5MueOzYkWLgJtELeFcqSaklfpoqrJjEjUUtSHi2x6tBkpGNUtEYt9jICly8XrH8+Bwe/2iFQGaYuuHUGS6W+dfenBFeKFl3Q71Y1Hatl4/ZM4LpWyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729049367; c=relaxed/simple;
	bh=oB2x5QGc7JYRpJb1UNT9KfqbRv/o3tDmrF/5qx1mMDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ebiny5rLUGvi0r4Q7LdgJR2n7untSADUC8XbsHeMO9yY7yftDBnxC5MT+SwFbAhJrUzWcx8UcZQv+7Bshk9BMuh8Psk5nbhqUwnL/OkXlzhzVTqR7DpJbe9eBam+NwL0d0Dza1Or5b4mtuVsuJC0QiowLFnWHyu/BDOOF+1bZns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D+bqdsWq; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729049366; x=1760585366;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oB2x5QGc7JYRpJb1UNT9KfqbRv/o3tDmrF/5qx1mMDQ=;
  b=D+bqdsWqknFJh0j4vlPLHJYhQqG9knn+l4Y9tXaYUfeGOUU2MaWKA7iR
   tA7RqQy+mXt3b39i2GQAjY0cVCOC9xCKVtCy+X1e2LLD8QI9eCHdtQvPu
   WmD+pMxAzPQXNJNC6je1cRphLvD+tSDtR2krh18yrjWNmPkdQBqxlhVi0
   LsNcfoEJCRr7eT+shLzLAIBlfSCUzpDCsNHIgLIaKRUqjlVK8dJcUTfp7
   EMsW+dtdqB0IyVtX0fk/Efj0e9Y9jWndePAqb4qn4inbXhOevLtk25qYy
   SKY3Oo/7u1T3bFf3i2ry5CwiBMF2Cb2gNMjDkPeto83iByZFk9Yp2fUl0
   w==;
X-CSE-ConnectionGUID: WwvGFaNETyqMu4BATs5FLQ==
X-CSE-MsgGUID: i01FvqH+SCiAI+6JClqYjA==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="28676505"
X-IronPort-AV: E=Sophos;i="6.11,206,1725346800"; 
   d="scan'208";a="28676505"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 20:29:26 -0700
X-CSE-ConnectionGUID: aYxstxQCQUqiARgbKbOLYQ==
X-CSE-MsgGUID: xkI9kYn5TiCOYcPMMxcAxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,206,1725346800"; 
   d="scan'208";a="78047642"
Received: from cvapit-mobl1.ger.corp.intel.com (HELO yungchua-desk.intel.com) ([10.247.118.236])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 20:29:23 -0700
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
Subject: [PATCH 1/4] ASoC: SOF: ipc4-topology: Do not set ALH node_id for aggregated DAIs
Date: Wed, 16 Oct 2024 11:29:07 +0800
Message-ID: <20241016032910.14601-2-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241016032910.14601-1-yung-chuan.liao@linux.intel.com>
References: <20241016032910.14601-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>

For aggregated DAIs, the node ID is set to the group_id during the DAI
widget's ipc_prepare op. With the current logic, setting the dai_index
for node_id in the dai_config is redundant as it will be overwritten
with the group_id anyway. Removing it will also prevent any accidental
clearing/resetting of the group_id for aggregated DAIs due to the
dai_config calls could that happen before the allocated group_id is
freed.

Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 sound/soc/sof/ipc4-topology.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/ipc4-topology.c b/sound/soc/sof/ipc4-topology.c
index 56427d6e3679..1fcf4692a21f 100644
--- a/sound/soc/sof/ipc4-topology.c
+++ b/sound/soc/sof/ipc4-topology.c
@@ -3250,9 +3250,20 @@ static int sof_ipc4_dai_config(struct snd_sof_dev *sdev, struct snd_sof_widget *
 		 * group_id during copier's ipc_prepare op.
 		 */
 		if (flags & SOF_DAI_CONFIG_FLAGS_HW_PARAMS) {
+			struct sof_ipc4_alh_configuration_blob *blob;
+
+			blob = (struct sof_ipc4_alh_configuration_blob *)ipc4_copier->copier_config;
 			ipc4_copier->dai_index = data->dai_node_id;
-			copier_data->gtw_cfg.node_id &= ~SOF_IPC4_NODE_INDEX_MASK;
-			copier_data->gtw_cfg.node_id |= SOF_IPC4_NODE_INDEX(data->dai_node_id);
+
+			/*
+			 * no need to set the node_id for aggregated DAI's. These will be assigned
+			 * a group_id during widget ipc_prepare
+			 */
+			if (blob->alh_cfg.device_count == 1) {
+				copier_data->gtw_cfg.node_id &= ~SOF_IPC4_NODE_INDEX_MASK;
+				copier_data->gtw_cfg.node_id |=
+					SOF_IPC4_NODE_INDEX(data->dai_node_id);
+			}
 		}
 
 		break;
-- 
2.43.0


