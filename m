Return-Path: <linux-kernel+bounces-289927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5C1954D67
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 17:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7F1B1F22EC4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 15:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E121BD4E4;
	Fri, 16 Aug 2024 15:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oV+JTADd"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F741BD02A
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 15:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723821253; cv=none; b=Wymw2pAs1gjNfFxqVzbpXLieJQqX2DZquik9vL+IS0BykMXcJ7kzhaC27nTEh9042z2eZa4qxCPiVeRYznfibkWvWxDeXN1eIGG67vHQ4QGXlrwV/8L/9unLZ1VIy5gFsNyZidFRpdr6wFEQh10XgeW87J4fOVmKy64aIJ96WkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723821253; c=relaxed/simple;
	bh=MKKPiciZc0EYGi4JZ+9QBcLZh5/E8ocqiK1GNgucmQE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gR3h9cKdaR+kXU7ozsMkpMSx0MMj8F9/TUJ0uqiVXbmH/jadq5epXkIjW+BVJT+65O5qdWPYCu8Fyhz/BbpXmdlN/mgrdABsT/QHuUXxESoaLB1xRsSikEnhk7e0HMmqWIzRfBEKxplazx0onOcduRuJfUOMbZfsgfCQI0/hJOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oV+JTADd; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-371893dd249so999055f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 08:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723821250; x=1724426050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fKhgYZGd6MhEpwJKETkIMp2KfUsUFptLQmP8VXkZ9Mw=;
        b=oV+JTADdJfZ8JgeJQsYrYUavhXiMJaq5mPSnz4nLHC8JYEJiiApKgPSg1fRWCnhZAv
         Hfoh9szASXHsGwVwX/clam270fbLbUma4QYC1Rfg1mgbeGDgVYfUhtBYxSlCbwY81BVV
         mc+6w/oD8NTdO8bcW1To/qYCG3Cbfzk//Cc5zfBm1/a0Imz7Fdj6CMmMtYn/IVwQpviY
         QcKTZ96x1oll2ONG65HBkbC9NTmK5ZF9YAVesVfQB+s2fBmH46moqrLhnC7/KRx5SxRX
         4F60zjijWnurO55mA3i8q6DbKDYj7Jk/nZPuHvnLDXR1xsV0jzQffCir/4jCY0xRRgoE
         3SKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723821250; x=1724426050;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fKhgYZGd6MhEpwJKETkIMp2KfUsUFptLQmP8VXkZ9Mw=;
        b=cXXYO2qVh0e9+YANcx0MxoVppNQWYd/2yvv7O5DfXv/C8/PXUpMpf/bCAeqGfRQdjV
         ghzMh3bRT6Pg21nVioU84T4dg0hP5MTv2Lf8ORzoRKgNmfLCE8ZfEVHMABS/i9tjjDAb
         SauasIQOqX/XaHgN+QDHjoddMbGgETvwR6DUiFbOFsPrOjrRlZCutADbH//Wu8yjNtha
         bY9/aQtEDLBhhANINAqVL31MwQVnbKB8jkrmoS2zoREZC5yVr4pFMNvDjy9TrdRnMU71
         uQeIlRv2gR1rNC46FWNCzf6fAWavh4Vud0SaVjOaNSHfNaUTmd++rAS5fTDfzg2zR8mc
         MXSA==
X-Forwarded-Encrypted: i=1; AJvYcCUL3XL5WkM17+gql0+HfNOaqRFSgyjSgBNukgDKe/ecdUQYl2LSu9oBgA52QWz5iT+X2hQUGTBqqYzUa+5puirWu5sOmuAkKgueeacM
X-Gm-Message-State: AOJu0YzoingzXAq6GWUPm3+zf+CMfwaA/GYRPy4sCg9wA420AsJpuPAr
	YSdxQslmOlwA5Q/SgTqZewaik9R7rnhdJmJ+OxB0HNMrvjFDNzsfedwwxKrn8qw=
X-Google-Smtp-Source: AGHT+IHtuQXvmrhkkFiEnHekC/5NQfc0+553ULsBowWpY0clJhHJiTSDhMUI0CtNFYI+isWQOpUYYQ==
X-Received: by 2002:adf:f7c5:0:b0:367:8876:68e6 with SMTP id ffacd0b85a97d-371946a5175mr2178345f8f.48.1723821250458;
        Fri, 16 Aug 2024 08:14:10 -0700 (PDT)
Received: from krzk-bin.. ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-371898ac2d1sm3854184f8f.109.2024.08.16.08.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 08:14:09 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] firmware: arm_scmi: Simplify with scoped for each OF child loop
Date: Fri, 16 Aug 2024 17:14:07 +0200
Message-ID: <20240816151407.155034-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use scoped for_each_child_of_node_scoped() when iterating over device
nodes to make code a bit simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/firmware/arm_scmi/driver.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 33676b6ece95..2b9c38f55989 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -2726,14 +2726,14 @@ scmi_txrx_setup(struct scmi_info *info, struct device_node *of_node,
 static int scmi_channels_setup(struct scmi_info *info)
 {
 	int ret;
-	struct device_node *child, *top_np = info->dev->of_node;
+	struct device_node *top_np = info->dev->of_node;
 
 	/* Initialize a common generic channel at first */
 	ret = scmi_txrx_setup(info, top_np, SCMI_PROTOCOL_BASE);
 	if (ret)
 		return ret;
 
-	for_each_available_child_of_node(top_np, child) {
+	for_each_available_child_of_node_scoped(top_np, child) {
 		u32 prot_id;
 
 		if (of_property_read_u32(child, "reg", &prot_id))
@@ -2744,10 +2744,8 @@ static int scmi_channels_setup(struct scmi_info *info)
 				"Out of range protocol %d\n", prot_id);
 
 		ret = scmi_txrx_setup(info, child, prot_id);
-		if (ret) {
-			of_node_put(child);
+		if (ret)
 			return ret;
-		}
 	}
 
 	return 0;
-- 
2.43.0


