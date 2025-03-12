Return-Path: <linux-kernel+bounces-558200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D66A5E2BF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 18:29:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BA653BC634
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 17:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F191E9B30;
	Wed, 12 Mar 2025 17:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="cCu45HK3"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1E725A2B3;
	Wed, 12 Mar 2025 17:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741800158; cv=none; b=Ze8SwHhz5dNqSHz8ARBZ4zI9mpTdaekLLfzHSeM5+A9dKgXUwRXI2tYJVjB2YGC9orUP4C9mEGuAPlvb8CpErftMIYPkwq2QmCKukFGGb6ylrdgx62t+P+YNz6ofYh+Bop62p/BWseXOWYx3tmwkb3od8LIRAoS+Mev6VwLR/wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741800158; c=relaxed/simple;
	bh=1jv5CvsISS6VubHiNYfPXEiQCOjE2PTh28+yZ7KKLUg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uZC5Csu4iSSEvMSaB0RQy7t4dY4eC+N1kWO0FQminFz1487g9nZAYmL1B1b/FEu56iYiNrNOnJ4mr0fOTFMWXLZaHtxh2FJExgaiVRDtSW0pEcdNHhMsN3WprgpVjNvmrHdDkn0NJ0C762UHH9uLlp6C0QPlIjY+NmefOCUGGuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=cCu45HK3; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52C6FZHP029588;
	Wed, 12 Mar 2025 12:22:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=k9x6Xsf+Pxlzu/Z2hlNLxQlPcOLync0Kzy/PrS741+M=; b=
	cCu45HK398eJjeAReqqjS5sAjydcphqUle7KfcrEVIx97wuz2mBLs04DmPGjrAcs
	wciW9JG833hsSnMMYSE8BY1abGnUz3ZdLnYca66d5guOpLznMHzhcYLMHKAvVyXP
	u8XzqSeM+2eEfi7s/5id2jGWxbopi+m2wrzOHKLsTXU6EXNvkrn4bM46+3RLU+3D
	K0VTNrMCfqTQGOqjzvgxsYF9CibZ0pkXVlvCWz3BEVHgG4WA+JCG7ei4zD61C8rG
	mazrpfQ+nF5LqgcbGIsKfliumnsfWZ1If+9OVeG59R0KGi+bvAt0Vsby5LRln14e
	KQ6/DLLsXr2C0j6Ny2zssQ==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 45au85tfdp-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Mar 2025 12:22:08 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 12 Mar
 2025 17:22:05 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.14 via Frontend Transport; Wed, 12 Mar 2025 17:22:05 +0000
Received: from ediswws07.ad.cirrus.com (ediswws07.ad.cirrus.com [198.90.208.14])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 58FFB822561;
	Wed, 12 Mar 2025 17:22:05 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <pierre-louis.bossart@linux.dev>,
        <yung-chuan.liao@linux.intel.com>, <peter.ujfalusi@linux.intel.com>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: [PATCH 6/6] ASoC: SDCA: Add support for GE Entity properties
Date: Wed, 12 Mar 2025 17:22:05 +0000
Message-ID: <20250312172205.4152686-7-ckeepax@opensource.cirrus.com>
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
X-Proofpoint-ORIG-GUID: tvaR9cD-wxFiSL18ngUDqnET8YLwUkrh
X-Proofpoint-GUID: tvaR9cD-wxFiSL18ngUDqnET8YLwUkrh
X-Authority-Analysis: v=2.4 cv=fv/cZE4f c=1 sm=1 tr=0 ts=67d1c2c0 cx=c_pps a=uGhh+3tQvKmCLpEUO+DX4w==:117 a=uGhh+3tQvKmCLpEUO+DX4w==:17 a=Vs1iUdzkB0EA:10 a=w1d2syhTAAAA:8 a=MldGFf8XINzs0YfW2RIA:9
X-Proofpoint-Spam-Reason: safe

Add support for parsing the Group Entity properties from DisCo/ACPI.
Group Entities allow control of several other Entities, typically
Selector Units, from a single control.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 include/sound/sdca_function.h   |  48 ++++++++++++
 sound/soc/sdca/sdca_functions.c | 129 ++++++++++++++++++++++++++++++++
 2 files changed, 177 insertions(+)

diff --git a/include/sound/sdca_function.h b/include/sound/sdca_function.h
index d7489e3c7e471..253654568a41e 100644
--- a/include/sound/sdca_function.h
+++ b/include/sound/sdca_function.h
@@ -44,6 +44,11 @@ struct sdca_function_desc;
  */
 #define SDCA_MAX_DELAY_COUNT 256
 
+/*
+ * Sanity check on size of affected controls data, can be expanded if needed.
+ */
+#define SDCA_MAX_AFFECTED_COUNT 2048
+
 /**
  * enum sdca_function_type - SDCA Function Type codes
  * @SDCA_FUNCTION_TYPE_SMART_AMP: Amplifier with protection features.
@@ -927,11 +932,51 @@ enum sdca_entity_type {
 	SDCA_ENTITY_TYPE_HIDE				= 0x31,
 };
 
+/**
+ * struct sdca_ge_control - control entry in the affected controls list
+ * @id: Entity ID of the Control affected.
+ * @sel: Control Selector of the Control affected.
+ * @cn: Control Number of the Control affected.
+ * @val: Value written to Control for this Mode.
+ */
+struct sdca_ge_control {
+	int id;
+	int sel;
+	int cn;
+	int val;
+};
+
+/**
+ * struct sdca_ge_mode - mode entry in the affected controls list
+ * @controls: Dynamically allocated array of controls written for this Mode.
+ * @num_controls: Number of controls written in this Mode.
+ * @val: GE Selector Mode value.
+ */
+struct sdca_ge_mode {
+	struct sdca_ge_control *controls;
+	int num_controls;
+	int val;
+};
+
+/**
+ * struct sdca_entity_ge - information specific to Group Entities
+ * @kctl: ALSA control pointer that can be used by linked Entities.
+ * @modes: Dynamically allocated array of Modes and the Controls written
+ * in each mode.
+ * @num_modes: Number of Modes.
+ */
+struct sdca_entity_ge {
+	struct snd_kcontrol_new *kctl;
+	struct sdca_ge_mode *modes;
+	int num_modes;
+};
+
 /**
  * struct sdca_entity - information for one SDCA Entity
  * @label: String such as "OT 12".
  * @id: Identifier used for addressing.
  * @type: Type code for the Entity.
+ * @group: Pointer to Group Entity controlling this one, NULL if N/A.
  * @sources: Dynamically allocated array pointing to each input Entity
  * connected to this Entity.
  * @controls: Dynamically allocated array of Controls.
@@ -940,12 +985,14 @@ enum sdca_entity_type {
  * @iot: Input/Output Terminal specific Entity properties.
  * @cs: Clock Source specific Entity properties.
  * @pde: Power Domain Entity specific Entity properties.
+ * @ge: Group Entity specific Entity properties.
  */
 struct sdca_entity {
 	const char *label;
 	int id;
 	enum sdca_entity_type type;
 
+	struct sdca_entity *group;
 	struct sdca_entity **sources;
 	struct sdca_control *controls;
 	int num_sources;
@@ -954,6 +1001,7 @@ struct sdca_entity {
 		struct sdca_entity_iot iot;
 		struct sdca_entity_cs cs;
 		struct sdca_entity_pde pde;
+		struct sdca_entity_ge ge;
 	};
 };
 
diff --git a/sound/soc/sdca/sdca_functions.c b/sound/soc/sdca/sdca_functions.c
index 0cc25fb9679b4..c8efdc5301b53 100644
--- a/sound/soc/sdca/sdca_functions.c
+++ b/sound/soc/sdca/sdca_functions.c
@@ -1136,6 +1136,92 @@ static int find_sdca_entity_pde(struct device *dev,
 	return 0;
 }
 
+struct raw_ge_mode {
+	u8 val;
+	u8 num_controls;
+	struct {
+		u8 id;
+		u8 sel;
+		u8 cn;
+		__le32 val;
+	} __packed controls[] __counted_by(num_controls);
+} __packed;
+
+static int find_sdca_entity_ge(struct device *dev,
+			       struct fwnode_handle *entity_node,
+			       struct sdca_entity *entity)
+{
+	struct sdca_entity_ge *group = &entity->ge;
+	u8 *affected_list __free(kfree) = NULL;
+	u8 *affected_iter;
+	int num_affected;
+	int i, j;
+
+	num_affected = fwnode_property_count_u8(entity_node,
+						"mipi-sdca-ge-selectedmode-controls-affected");
+	if (!num_affected || num_affected == -EINVAL) {
+		return 0;
+	} else if (num_affected < 0) {
+		dev_err(dev, "%s: failed to read affected controls: %d\n",
+			entity->label, num_affected);
+		return num_affected;
+	} else if (num_affected > SDCA_MAX_AFFECTED_COUNT) {
+		dev_err(dev, "%s: maximum affected controls size exceeded\n",
+			entity->label);
+		return -EINVAL;
+	}
+
+	affected_list = kcalloc(num_affected, sizeof(*affected_list), GFP_KERNEL);
+	if (!affected_list)
+		return -ENOMEM;
+
+	fwnode_property_read_u8_array(entity_node,
+				      "mipi-sdca-ge-selectedmode-controls-affected",
+				      affected_list, num_affected);
+
+	group->num_modes = *affected_list;
+	affected_iter = affected_list + 1;
+
+	group->modes = devm_kcalloc(dev, group->num_modes, sizeof(*group->modes),
+				    GFP_KERNEL);
+	if (!group->modes)
+		return -ENOMEM;
+
+	for (i = 0; i < group->num_modes; i++) {
+		struct raw_ge_mode *raw = (struct raw_ge_mode *)affected_iter;
+		struct sdca_ge_mode *mode = &group->modes[i];
+
+		affected_iter += sizeof(*raw);
+		if (affected_iter > affected_list + num_affected)
+			goto bad_list;
+
+		mode->val = raw->val;
+		mode->num_controls = raw->num_controls;
+
+		affected_iter += mode->num_controls * sizeof(raw->controls[0]);
+		if (affected_iter > affected_list + num_affected)
+			goto bad_list;
+
+		mode->controls = devm_kcalloc(dev, mode->num_controls,
+					      sizeof(*mode->controls), GFP_KERNEL);
+		if (!mode->controls)
+			return -ENOMEM;
+
+		for (j = 0; j < mode->num_controls; j++) {
+			mode->controls[j].id = raw->controls[j].id;
+			mode->controls[j].sel = raw->controls[j].sel;
+			mode->controls[j].cn = raw->controls[j].cn;
+			mode->controls[j].val = le32_to_cpu(raw->controls[j].val);
+		}
+	}
+
+	return 0;
+
+bad_list:
+	dev_err(dev, "%s: malformed affected controls list\n", entity->label);
+	return -EINVAL;
+}
+
 static int find_sdca_entity(struct device *dev,
 			    struct fwnode_handle *function_node,
 			    struct fwnode_handle *entity_node,
@@ -1174,6 +1260,9 @@ static int find_sdca_entity(struct device *dev,
 	case SDCA_ENTITY_TYPE_PDE:
 		ret = find_sdca_entity_pde(dev, entity_node, entity);
 		break;
+	case SDCA_ENTITY_TYPE_GE:
+		ret = find_sdca_entity_ge(dev, entity_node, entity);
+		break;
 	default:
 		break;
 	}
@@ -1384,6 +1473,42 @@ static int find_sdca_entity_connection_pde(struct device *dev,
 	return 0;
 }
 
+static int find_sdca_entity_connection_ge(struct device *dev,
+					  struct sdca_function_data *function,
+					  struct fwnode_handle *entity_node,
+					  struct sdca_entity *entity)
+{
+	int i, j;
+
+	for (i = 0; i < entity->ge.num_modes; i++) {
+		struct sdca_ge_mode *mode = &entity->ge.modes[i];
+
+		for (j = 0; j < mode->num_controls; j++) {
+			struct sdca_ge_control *affected = &mode->controls[j];
+			struct sdca_entity *managed;
+
+			managed = find_sdca_entity_by_id(function, affected->id);
+			if (!managed) {
+				dev_err(dev, "%s: failed to find entity with id %#x\n",
+					entity->label, affected->id);
+				return -EINVAL;
+			}
+
+			if (managed->group && managed->group != entity) {
+				dev_err(dev,
+					"%s: entity controlled by two groups %s, %s\n",
+					managed->label, managed->group->label,
+					entity->label);
+				return -EINVAL;
+			}
+
+			managed->group = entity;
+		}
+	}
+
+	return 0;
+}
+
 static int find_sdca_entity_connection(struct device *dev,
 				       struct sdca_function_data *function,
 				       struct fwnode_handle *entity_node,
@@ -1404,6 +1529,10 @@ static int find_sdca_entity_connection(struct device *dev,
 		ret = find_sdca_entity_connection_pde(dev, function,
 						      entity_node, entity);
 		break;
+	case SDCA_ENTITY_TYPE_GE:
+		ret = find_sdca_entity_connection_ge(dev, function,
+						     entity_node, entity);
+		break;
 	default:
 		ret = 0;
 		break;
-- 
2.39.5


