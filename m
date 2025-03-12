Return-Path: <linux-kernel+bounces-558198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 222E7A5E2B9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 18:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6544217181B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 17:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD1625A346;
	Wed, 12 Mar 2025 17:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="CGCFdff7"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2BB25A2CF;
	Wed, 12 Mar 2025 17:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741800158; cv=none; b=EOpuoTGk3EwHEQ8h1O7WkHGWHeoSY0HxNr9Ts9ZtNgcoNtGrRX+EcmdIujEORwSH2zRg1oRAN79phn7wHvMxI7YLkC0qz0A88rreEzWIVGbjp6XyiCj3DycFE2UNUFAOAkWEl42o3z7v8FtDNSrQKSCP7Unk6oJ+dza5CMDODTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741800158; c=relaxed/simple;
	bh=jgPvmg+Q9Qzq37KOpqgcSMjVVBJ6hNYlQSn+eNyjBfU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AUx+AVXcR4SQQVZQVbZHEYm3bNrMUH1OCkeFXkSNeLUgY2oadDyFW9TY6VlILMZi8oWl+olfKKN4GxJ9eH3EljoVz4F9UNvn/z1RAbLRqnh/A4XoK5r05GO3Q4ltu3LJ51HJi1ngxyj3B7AjE4Tt3Y9j4Wb/hURLTUsNycJEhsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=CGCFdff7; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52C5qIHs028516;
	Wed, 12 Mar 2025 12:22:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=FyfKt0hheuVznvh1ftfE2AhNxXjgHWRaa7mfCVDeQwE=; b=
	CGCFdff7XFG0bGhGb62aWatjp48of1f8SRjom46aAxa4aJ6AVUa3SKeNrcxYVlue
	ZhNft6WBc9ioljhX0RchPTewHDZXhX8Pfn3cVaEN8Y3ILtwT0Ig+rPubfIiFcEVr
	AI6NNm/RcFUJkPU8msVpCYrGHPYBt5KlDPnnLFIdbJsAoWbH7jInV0MqokAlZVy4
	04u0pTMCc7ebtkoA6NKwthAVj6E7BM7xMmWgPLw4Etmlb63/XkHy70FQenow9vRt
	sz05VBezSsbgkv1IihR/xNdmFr5J76XaV0g6FZfPxVlvV4cVIJWuhCjUdJIstAfe
	x5UjOJrQ9a4AVNGM3wtIcQ==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 45au85tfdn-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Mar 2025 12:22:11 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 12 Mar
 2025 17:22:05 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.14 via Frontend Transport; Wed, 12 Mar 2025 17:22:05 +0000
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 33A4182255D;
	Wed, 12 Mar 2025 17:22:05 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <pierre-louis.bossart@linux.dev>,
        <yung-chuan.liao@linux.intel.com>, <peter.ujfalusi@linux.intel.com>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH 2/6] ASoC: SDCA: Use __free() to manage local buffers
Date: Wed, 12 Mar 2025 17:22:01 +0000
Message-ID: <20250312172205.4152686-3-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250312172205.4152686-1-ckeepax@opensource.cirrus.com>
References: <20250312172205.4152686-1-ckeepax@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: R8d8TsGdAGXtbsHScQHu8_g4j0uxJgLi
X-Proofpoint-GUID: R8d8TsGdAGXtbsHScQHu8_g4j0uxJgLi
X-Authority-Analysis: v=2.4 cv=fv/cZE4f c=1 sm=1 tr=0 ts=67d1c2c3 cx=c_pps a=uGhh+3tQvKmCLpEUO+DX4w==:117 a=uGhh+3tQvKmCLpEUO+DX4w==:17 a=Vs1iUdzkB0EA:10 a=w1d2syhTAAAA:8 a=L5TT23dkX6Ki6KiLlvEA:9
X-Proofpoint-Spam-Reason: safe

Use the cleanup.h helpers to manage some local buffers, this cleans up
the error paths a little.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/sdca/sdca_functions.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/sound/soc/sdca/sdca_functions.c b/sound/soc/sdca/sdca_functions.c
index 133cbde17ef48..4ee98d8fe89ed 100644
--- a/sound/soc/sdca/sdca_functions.c
+++ b/sound/soc/sdca/sdca_functions.c
@@ -913,9 +913,9 @@ static int find_sdca_entity_pde(struct device *dev,
 {
 	static const int mult_delay = 3;
 	struct sdca_entity_pde *power = &entity->pde;
+	u32 *delay_list __free(kfree) = NULL;
 	struct sdca_pde_delay *delays;
 	int num_delays;
-	u32 *delay_list;
 	int i, j;
 
 	num_delays = fwnode_property_count_u32(entity_node,
@@ -962,8 +962,6 @@ static int find_sdca_entity_pde(struct device *dev,
 	power->num_max_delay = num_delays;
 	power->max_delay = delays;
 
-	kfree(delay_list);
-
 	return 0;
 }
 
@@ -1022,8 +1020,8 @@ static int find_sdca_entities(struct device *dev,
 			      struct fwnode_handle *function_node,
 			      struct sdca_function_data *function)
 {
+	u32 *entity_list __free(kfree) = NULL;
 	struct sdca_entity *entities;
-	u32 *entity_list;
 	int num_entities;
 	int i, ret;
 
@@ -1054,8 +1052,6 @@ static int find_sdca_entities(struct device *dev,
 	for (i = 0; i < num_entities; i++)
 		entities[i].id = entity_list[i];
 
-	kfree(entity_list);
-
 	/* now read subproperties */
 	for (i = 0; i < num_entities; i++) {
 		char entity_property[SDCA_PROPERTY_LENGTH];
@@ -1170,8 +1166,8 @@ static int find_sdca_entity_connection_pde(struct device *dev,
 					   struct sdca_entity *entity)
 {
 	struct sdca_entity_pde *power = &entity->pde;
+	u32 *managed_list __free(kfree) = NULL;
 	struct sdca_entity **managed;
-	u32 *managed_list;
 	int num_managed;
 	int i;
 
@@ -1205,15 +1201,12 @@ static int find_sdca_entity_connection_pde(struct device *dev,
 		if (!managed[i]) {
 			dev_err(dev, "%s: failed to find entity with id %#x\n",
 				entity->label, managed_list[i]);
-			kfree(managed_list);
 			return -EINVAL;
 		}
 
 		dev_info(dev, "%s -> %s\n", managed[i]->label, entity->label);
 	}
 
-	kfree(managed_list);
-
 	power->num_managed = num_managed;
 	power->managed = managed;
 
@@ -1453,9 +1446,9 @@ static int find_sdca_clusters(struct device *dev,
 			      struct fwnode_handle *function_node,
 			      struct sdca_function_data *function)
 {
+	u32 *cluster_list __free(kfree) = NULL;
 	struct sdca_cluster *clusters;
 	int num_clusters;
-	u32 *cluster_list;
 	int i, ret;
 
 	num_clusters = fwnode_property_count_u32(function_node, "mipi-sdca-cluster-id-list");
@@ -1484,8 +1477,6 @@ static int find_sdca_clusters(struct device *dev,
 	for (i = 0; i < num_clusters; i++)
 		clusters[i].id = cluster_list[i];
 
-	kfree(cluster_list);
-
 	/* now read subproperties */
 	for (i = 0; i < num_clusters; i++) {
 		char cluster_property[SDCA_PROPERTY_LENGTH];
-- 
2.39.5


