Return-Path: <linux-kernel+bounces-211537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F1B905357
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 15:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D04681F2316D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 13:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E47E179663;
	Wed, 12 Jun 2024 13:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QkIJtFH1"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C240170853
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 13:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718197877; cv=none; b=tCR6M7rZCN6hD/Vo8jr+EG5zshAhdevIqkO5xMlOuTLRYz40WE7bG/abYFNinnd7E/jLjyadcON0eE+MqdQ8ncj7JSxmXon42qwbudnpPBHxRAn7TF6Y7mesTdDh8cQXx/wSmAkk3rmOmBeGi3tSVTGAzy2xhxwQczMtlbo8kKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718197877; c=relaxed/simple;
	bh=e9aTL45b/5VauqiLnFJX3VwIBSY8e722VlmpSLAk3tg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=iHFONYOtl4T3e6iwzoLX21s8oNjMPKqeZepRNXQLXUY4eVrVbY31uIzqVy5CUX2WEusz6LZS3q/f3EDrm84hWQ/IApWBAYBdjxNh91RcIsJ5Cv7duHqCMWkitjHdNjaCA0/PpZHt2fhbocsno+Nsu0QK2iqsPWiZ9Gw42ZrR61Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QkIJtFH1; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a6e349c0f2bso679907466b.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 06:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718197874; x=1718802674; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wNDZP3olXhf0m0jznv4sHsrpG3mrdyMI3Wu77Y+9NAw=;
        b=QkIJtFH1O3N/U0VEGrBddzmM6ZQhnlyN7cmKtQDGqRpxHQ815gY3UFX6te+HeQ2UTD
         eQZglDnK6h2m0D1nT08JWgm1PIJu0u8wj/O8ZqVRT20PFSu+zaL9d0fMOuWC/4f12zty
         0/CcFk5A79HYAqDBi3RPBIAET68IMd5BAaXJ/SNDdPFoma/XEg181nf1i7ptpEOdbz99
         ZCuLr1mlzpZpomrCME5BYyOxDTiSFiNVWZAbrzi7vyJDew+2Myrly64ABoQG2B1WDNYY
         JtXGs9XKw5C1qYO3xbJaUoWgrYx1BUh+ev6o3ZZzkQnshBHSltwvXIUIeTUUctd1cIgX
         kHHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718197874; x=1718802674;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wNDZP3olXhf0m0jznv4sHsrpG3mrdyMI3Wu77Y+9NAw=;
        b=F32u14BwEXRX4c95aZmBZYr6anHTVjHMsbIG72NNJCmhxS3VcOnm1UG4vhi2SHwfnO
         63SuD2qPBpZf7HF38GYF4oUuAKiXi0ghSDmy9s3KrYNf5rKaUd0GZYUw3qoZATJ5r7hf
         zax+LYOK+Qdtt5gKStIVFiHkltGCSYbW7c9R8PDQ8M+TiQnBRpXmKowjFpdtuiQwYBWM
         VnlNOH5+VsTRk9xZyJP2BpVaqV0qoxXflFr7oY//G4Fpa1Xuo0lRfKcU9HWWAvu1BzBw
         MA7u+qZHyhAid9H7gXJA/FtusJwnZfPDjBhJugAlseSp4oPzxJ3S6Nl+rIaqpf57AJMe
         DfOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkZtcNvLMzyqBqlAe1Ptzdm058NYFO4pgDGs/BHOssD4RahwrkC49mPNvFj4GgVkeg20mRPHe8nfPQayVxHOE6GTJueqg4iL3d/yZJ
X-Gm-Message-State: AOJu0YwnFScUB8AmkV3nVffwq7iei5oztgCCn9zEdkNvTs3WulaDMvT0
	vRfTyZmh+Ogi/XMTkAe1bLFkO3lgfmXkHPMQHHt9RNRcjtdtq9+Z
X-Google-Smtp-Source: AGHT+IGp/qoxB+zL6ngPmsZ4PnHWEDtB+UvZ6sOM9/TIP4yOSEHF/GZYEmSsDYcsZ0tU6XTE6HW/0g==
X-Received: by 2002:a17:906:2da2:b0:a6f:309d:f889 with SMTP id a640c23a62f3a-a6f48013fe8mr107003566b.54.1718197874324;
        Wed, 12 Jun 2024 06:11:14 -0700 (PDT)
Received: from [127.0.1.1] (84-115-213-103.cable.dynamic.surfer.at. [84.115.213.103])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f00108531sm591165666b.211.2024.06.12.06.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 06:11:13 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Wed, 12 Jun 2024 15:11:01 +0200
Subject: [PATCH] coresight: cti: move fwnode_handle_put to the early break
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240612-coresight-cti-platform-handle-put-v1-1-6817c5854e2b@gmail.com>
X-B4-Tracking: v=1; b=H4sIAGSeaWYC/x2NQQqDMBAAvyJ77oKuIbX9SvEgyUYX1IRNlIL49
 4YeB4aZCzKrcIZ3c4HyKVniXqF7NOCWaZ8ZxVcGasm0tiN0UTnLvBR0RTCtUwlRN6yuXxnTUdA
 b/7L0tNQPPdROUg7y/T8+433/AFYyVLRzAAAA
To: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718197872; l=2158;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=e9aTL45b/5VauqiLnFJX3VwIBSY8e722VlmpSLAk3tg=;
 b=3Wt9ngjsY/3xxjem8OHTiHgddO/flhIkmQ7tilcfn9FzzYWRyMMO2Y5YNHOeLhys1fzAX3sYo
 /i34OUYRjrHDOgvSRp/eVgl9F/jyMCXv0BOlQ3DJQwCt4t8pY6W9bfe
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The explicit call to fwnode_handle_put() is only required if the
fwnode_for_each_child_node() loop contains early exits. On the other
hand, it is not required otherwise, and its usage is then unnecessary.
The current approach is not buggy (NULL pointer is ignored), but can be
optimized by limiting the calls to fwnode_handle_put() to the case where
it is really necessary.

Move fwnode_handle_put() to the early break within the loop to avoid
calling the function when it is not required.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Note that this issue was already mentioned during the patch review [1],
but the outcome was that fwnode_handle_put() is required for early
exits. Apparently, that was the end of the discussion, but the call to
the function that decrements the refcount is unnecessary if the end of
the loop is reached without any break/goto/return.

This issue was found while analyzing the code, and I don't have the
hardware to validate it beyond compilation and static analysis. Any
tests to catch regressions with real hardware are always welcome.

Link: https://lore.kernel.org/all/20191119231912.12768-8-mike.leach@linaro.org/ [1]
---
 drivers/hwtracing/coresight/coresight-cti-platform.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-cti-platform.c b/drivers/hwtracing/coresight/coresight-cti-platform.c
index ccef04f27f12..5aec37be1177 100644
--- a/drivers/hwtracing/coresight/coresight-cti-platform.c
+++ b/drivers/hwtracing/coresight/coresight-cti-platform.c
@@ -426,10 +426,11 @@ static int cti_plat_create_impdef_connections(struct device *dev,
 		if (cti_plat_node_name_eq(child, CTI_DT_CONNS))
 			rc = cti_plat_create_connection(dev, drvdata,
 							child);
-		if (rc != 0)
+		if (rc != 0) {
+			fwnode_handle_put(child);
 			break;
+		}
 	}
-	fwnode_handle_put(child);
 
 	return rc;
 }

---
base-commit: 83a7eefedc9b56fe7bfeff13b6c7356688ffa670
change-id: 20240612-coresight-cti-platform-handle-put-d4d962762383

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


