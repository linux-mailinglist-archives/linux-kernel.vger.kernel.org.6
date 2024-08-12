Return-Path: <linux-kernel+bounces-283091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7BF94ED0D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 14:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C76628315B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 12:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1795317A939;
	Mon, 12 Aug 2024 12:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="de9bqy/G"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA78917A902
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 12:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723465863; cv=none; b=hR1j4NUnVOvIwKo6ILmHMzppyTBJtuXoKBliRyVueT5HSZL+giUZKNjzj2Rhxj0L8JGg5tNYSxbRqQOXdDati5LC5+FDJmlzUxo6nSbbnJ/b5FeD+oS8iEbuDmLRikQQ1WrJt48hYzk4Yta/HR/g80zVUaMDYYEgyeZQn8tjRvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723465863; c=relaxed/simple;
	bh=4s62qVRHCnsvaoNH4q2XMZiaS9GZto2/rKo40yJ5wGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=beYxCK7Fa53E/kaaH0Arnw86M6D4xOEULfzZAhomBFo3m9XMRNMBzDcjCtAN52KAd8b96197c5lgojwFS3oH2Si6zuoveuj+Pijj8tNk3MY9Ew1WjXdDp9RNu+fe+kds15uhIHCliZLLlg/ZFM63+ORnE7xKS0Bq2bcuB1mm/ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=de9bqy/G; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-428243f928fso42406785e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 05:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723465859; x=1724070659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CrjMzxFTOymK1yhiDsFxq0lcAyXP/N53dsHhhTtc+pE=;
        b=de9bqy/GLISDqJXhRY/AzKzFfYNx/NlU4BsWVM/a799aNPDuzsnyW3I9Utwsv1aVOT
         S3pZ2etyjLOt7Ay6g/b0hPnDqn7+FOTpwAiNfW0R56VWkROya8c4kTR96P+Hg3MjTuNm
         F5O8YsOYvOWPfIWLHKbd06Xh2Pw/1LAa756GUwnqo9gJhE3r9Qy102mh1yzc1Bf4RweG
         SqhzlOzwXOOyJpMvj4SQ/BBCCQqp8ATfETZ6Lz3Qux63EPv5xtGqkJHKk/1ZAu1H/h5Z
         1KNmV9gh3GkReiMp68TPUzAOCzYP2uEf0BphBTr+LdI0fUOuk5vNUjFP5AKMemawaarT
         u/Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723465859; x=1724070659;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CrjMzxFTOymK1yhiDsFxq0lcAyXP/N53dsHhhTtc+pE=;
        b=NlLYSoGDc9SOZSSYNDtychZsckTh5ZNfxrPHhkOop6THe9AIErBhwL4XqtDG1CtI0O
         XzZMStherzKJRwgXzlCQ9naX1exlwq3TXcVrIKHlhEpl2UzCdbi+aqWeqEAtqsu0plOe
         1GIQ9FSmciTveuMbGSdkW3yNnQk9QVoDQKc/5PPP+yGJPt/vH3wee1weV+uyKWX+2tbR
         KXo69u8B2vmbr8nH1l9yVgbrnkHBNYG6jZeEAF4HSErI13vL44S9NGlZeNUTeOn8NNv9
         +blUJ+gMDAQlflT4KkdM72Bvw9VZS11JW8sGpG3CnNxctnz8QVXHLugxXykOUjVbbViz
         v2EQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbnT2/HVQN8noUs763z5EUw6Td9Aad5q2IIu6UuPBKQHdgwLNl3AWTzeXme4scyaVQ0dAh6AvJHUZjJcjLtu+BxvK7aLdLm07vlHQH
X-Gm-Message-State: AOJu0YyFnMAhufseg1UtOvJiLBZlCsXMVx3QLJ98dRm0w+hMQlxPm9Pb
	MAgIKVRMEz1bUHuLv+hNcL7x+wGdZbqd3f1QAPtdJMcHO/iTIloY0j/oDPtXlXM=
X-Google-Smtp-Source: AGHT+IHqBpkoDp5Wal5s8Y3KdZUq9WqkY3HpRBrs+w1cLO3eMxLwKdriiu6K0wUn5dFjISVeNq3Axg==
X-Received: by 2002:a05:6000:1b02:b0:368:7282:51d6 with SMTP id ffacd0b85a97d-3716ccef03cmr182934f8f.21.1723465858925;
        Mon, 12 Aug 2024 05:30:58 -0700 (PDT)
Received: from krzk-bin.. ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4e51eb10sm7349493f8f.84.2024.08.12.05.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 05:30:58 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Sumit Gupta <sumitg@nvidia.com>,
	linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	stable@vger.kernel.org
Subject: [PATCH] memory: tegra186-emc: drop unused to_tegra186_emc()
Date: Mon, 12 Aug 2024 14:30:55 +0200
Message-ID: <20240812123055.124123-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

to_tegra186_emc() is not used, W=1 builds:

  tegra186-emc.c:38:36: error: unused function 'to_tegra186_emc' [-Werror,-Wunused-function]

Fixes: 9a38cb27668e ("memory: tegra: Add interconnect support for DRAM scaling in Tegra234")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/memory/tegra/tegra186-emc.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/memory/tegra/tegra186-emc.c b/drivers/memory/tegra/tegra186-emc.c
index 57d9ae12fcfe..33d67d251719 100644
--- a/drivers/memory/tegra/tegra186-emc.c
+++ b/drivers/memory/tegra/tegra186-emc.c
@@ -35,11 +35,6 @@ struct tegra186_emc {
 	struct icc_provider provider;
 };
 
-static inline struct tegra186_emc *to_tegra186_emc(struct icc_provider *provider)
-{
-	return container_of(provider, struct tegra186_emc, provider);
-}
-
 /*
  * debugfs interface
  *
-- 
2.43.0


