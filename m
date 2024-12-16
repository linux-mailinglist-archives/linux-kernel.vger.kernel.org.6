Return-Path: <linux-kernel+bounces-447521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 399C59F33B9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 15:54:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 780CD164325
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 14:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072922063F7;
	Mon, 16 Dec 2024 14:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g65hfis3"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCEE2063EC;
	Mon, 16 Dec 2024 14:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734360678; cv=none; b=bnEp9Z8Oi6wCHZQO9FqNE3OIst+Qx9zZy9UXLuNrj/8MS98NJ60ed0UqR8GqDWj9BE8Tm8bdQ/37gCNQvkk/5omMf5WmIZScVH7sycbVAj+jm3xmlaSxXgrQP8G0VwA6sPtjQDbU9YHZCFHMpikeI3q4QxJPfWaSRmbXA5zgqE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734360678; c=relaxed/simple;
	bh=kAz5cBPcgesyVW4NY2ucqWfgWBRYVqzqd6e6WZNwbSE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F/xd+vCyLOP0HXAnMqhytAkNpsYtfjfRvYHocms5xYq/6SZm6HMgQ2RJll4n+DRSfiZ9xeUhsyNM3igVO/DCdfZzYWrj5Tkd+9PTy2YbVW+VySri0IunjtDNjbir/0VDILIYmnpIHDcEKMdLffT8V6Pcy4zGI09wdWmp4hWzJEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g65hfis3; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3863c36a731so3020635f8f.1;
        Mon, 16 Dec 2024 06:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734360675; x=1734965475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FZR22IhRUpX/Fq7KGPdPODk7QFLwb+WURrRAPPoxEH0=;
        b=g65hfis3bDjnJT8+9bR1NZpWIhYDm4epXF4ONEQIPZ6vOup8B0vVP2LGKsLBmtLTYo
         wP5H1Gi0Onkay8jbnQaUvGMe8+F7L4Fy0un+WIAeuM9TSO7wnwwC+O7QEXEclBbkqAjU
         TVVGif9089mec6/95xsahHjGDxXsYaOC66BN30bWYTxyQAX2yy6tsCKLftZLbXLS3zuh
         EddS6iXPWV1JXsgwI4ij4mPP7Ol76Ykd5naCAtRC8MESs/c98jAMoM7Ff5mj5HtYM2BK
         +iw1SDENXV6bZz3jyU6WeAqj+vJnxybIc77xjlJ+8vYFLDjaI8ab2/VRLioPFEi3wIYS
         yL3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734360675; x=1734965475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FZR22IhRUpX/Fq7KGPdPODk7QFLwb+WURrRAPPoxEH0=;
        b=KAea2aBKndzOlIDHUGQz8+esjp6yW9ucDUeL0LqWAt0gNNjvibyUIwV32NrlFaAOOn
         hr3xoNXC93O1vVisziIGuIjqlxAxYu/LIPCq2BhD74Vi/5RdDiy4DbapsbkRa1HbA4pt
         hWK6NkMPp4VA2e4cj0o5kJSRqNlpZ+JO+Kamr+IIrOSr3ac/cg3xVHtOkl40U7wpXdue
         LboGZJuhO8fJx4qA4KacoBBkuj0PB8aphZXMgXbkzbNQ/NeF+CJxScX2v6TMtbwdHsDQ
         JV7rsN72urLrwUwWmod9FURFqrJkFt01YHuFSDULYOxILeS4Jcjy1w2khdQ6D/673Va0
         xkfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjhtIeCwQN7fu2SSM4hpEYWf1NY3CWXhgtceOxq4EN/kCepEjRZjfIKG4acfMldJlmFoIlrqrJTsLiCh3f@vger.kernel.org, AJvYcCVLWCh5E2yGbCNK6sGH3bLzbfqqUaZMBtKnyAtV3/NaGSXAffkz8SEr6+12Tq4l93irlFebxzAJGJe/M2g=@vger.kernel.org, AJvYcCWaQDGcjFCuMUCDduQtmKVj/PEfk7iNCKakIQL7KsV4/4dEZd/4+8Er1V2MfW7CcWiU8aHaXWyOSD9R@vger.kernel.org
X-Gm-Message-State: AOJu0YwmyBxTrxhelsCGM4VJkQGU5uHY2FfHg3RlCktTNubm27PhVCYv
	EzDQgbRnnEZUqM1kE36yYip71hik/bi+MvGt+nluXfwVXBJNR9kK
X-Gm-Gg: ASbGncsmn5PorhuGjuRckayrsQsvRzOBaxSyzTfDCslXodME/PrZs/TrtugRVANui2a
	3+EguOu/5Z4E5rRMu4TmkObCYqA3ucxGRKy6zZZ3N1Dd7sD32yR5NfRoBjCiREwpT498vvX7u1j
	9EC0Krz1H89GejNlAcKov51BRiL8E2VIVPxpJKYIlwc31cEMIGp9eE1q34fuDeaInokswU1ssMp
	f7WGcXzgDPHyrT3TYH/bFazXZgjRLWM1BlR0RXLU58IlkTC4mjbR8jUSBoHa4jjqFuL7TxOJc4N
	qfLsIm/os0vIDPUn
X-Google-Smtp-Source: AGHT+IHzN/5NhLTul0WIKF2FfViCsMY2uCJdEVicfsfHV8smpoFeZ1z55RS+AV0S1OCL0ZcqZxbh/A==
X-Received: by 2002:a5d:6c6c:0:b0:385:e1f5:476f with SMTP id ffacd0b85a97d-3888e0b9bcbmr8246013f8f.39.1734360674752;
        Mon, 16 Dec 2024 06:51:14 -0800 (PST)
Received: from playground.localdomain ([92.120.5.10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4362559ed6csm141616455e9.24.2024.12.16.06.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 06:51:14 -0800 (PST)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Mark Brown <broonie@kernel.org>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Takashi Iwai <tiwai@suse.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Frank Li <Frank.li@nxp.com>
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-sound@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/5] ASoC: dt-bindings: add common binding for NXP audio processors
Date: Mon, 16 Dec 2024 09:50:35 -0500
Message-Id: <20241216145039.3074-2-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241216145039.3074-1-laurentiumihalcea111@gmail.com>
References: <20241216145039.3074-1-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

Add common binding for NXP audio processors with Sound Open Firmware
(SOF) support.

Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
---
 .../bindings/sound/fsl,sof-cpu.yaml           | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/fsl,sof-cpu.yaml

diff --git a/Documentation/devicetree/bindings/sound/fsl,sof-cpu.yaml b/Documentation/devicetree/bindings/sound/fsl,sof-cpu.yaml
new file mode 100644
index 000000000000..1958afceba75
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/fsl,sof-cpu.yaml
@@ -0,0 +1,35 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/fsl,sof-cpu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP audio processor common properties
+
+maintainers:
+  - Daniel Baluta <daniel.baluta@nxp.com>
+
+properties:
+  reg:
+    maxItems: 1
+
+  mboxes:
+    maxItems: 4
+
+  mbox-names:
+    items:
+      - const: txdb0
+      - const: txdb1
+      - const: rxdb0
+      - const: rxdb1
+
+  memory-region:
+    maxItems: 1
+
+required:
+  - reg
+  - mboxes
+  - mbox-names
+  - memory-region
+
+additionalProperties: true
-- 
2.34.1


