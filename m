Return-Path: <linux-kernel+bounces-226395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA337913DB9
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 21:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B4881F21DD5
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 19:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BBA9183091;
	Sun, 23 Jun 2024 19:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="quI0jAie"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10AE44C86
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 19:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719171268; cv=none; b=sFW8URoust4pZdOFVVGzB7RCNRh/y+2yTNNTv2MOp6SKUhJfVl+sKyAUOph4ba3NecCGxQlX3pj6rs+2cDZlBR/demUDtGQ+uk3PoVXFN8ycMNxOC49f9v856EqVf7zrSKcMSngNFcMREOHUk779mC98amWeidXHV4R5s3CdrjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719171268; c=relaxed/simple;
	bh=ct1ik3BGCjjOeqErtdK1uMsUpovr6hfYlxq2FElf6b4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UMyzAuRElQOYWSfTADYMpm67Q7UTl6rIc+XFTy65Z7ezUzH81wU78wgX+MTRZRA9zqSMQpe9msXiRcja7bUw38HEBoerjA0b5Ii4L4/yXaO10XCZO6AnucDeDy2Cr6Udb7TSIBkARVmFCRQdKPqcCF6aaFbwxG0xY8fpJPjPyAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=quI0jAie; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-364b2f92388so2472247f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 12:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719171265; x=1719776065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jlJ9HKaPN5zKWsVg50zksinAvfEscvtSvPK9OhtidXw=;
        b=quI0jAieMNhmLJFKKDO5lthe0vRf+Zjysi/Arzf/GTEvEDOa1as/Jy+6dg2g2GqC8A
         1/zzOc96S4H3BJUpDZJeLo72LcbIVsyzcCgLjvNZqtFLOiEUfC4l+lUEex+MtjMOxWOH
         TXH3XVBfxi32Owj3SJXpOJPyyymCZcUIU9Qbl2kSL2GYL5PNSbVDcIvtHw0bBdLDSV+7
         ijFDPY3hEu1jqo0gNCS0Q8DkiCxvoYJeEINQCxoFK8N0hy6TjGVtl6+vR+1MHc59C6//
         dkq7BQpXIVG4X+AZ6Eo2J00YCNMLmOHBJHYF9XzVAZe6zUxggM+A+JbDUta+5+Im8G8q
         HHBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719171265; x=1719776065;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jlJ9HKaPN5zKWsVg50zksinAvfEscvtSvPK9OhtidXw=;
        b=PYfv3gdel9myeuR7wZXNG8LfXZoy7TWGpTCYR8Chh+UEQHcWrLdz/brosiPZCmFNF5
         F/9x8OyrXKVo9RSxtsT/x24lZM960AO3YZ6DKGqSRM4EdEJTUTl0VnIgTlXlnKZBhSjt
         gn813ywx8DbZjMxafUjxAx7gCF5vU1M0rmq1kBBiaGf5d84i85/6KXtoZ2MDYPyeI7um
         DeEl1V71FxQwz0sVnNz10+lEYE948lblkzlv/UtuNKF8NwXqbDUuhsA823Sn4a0zHzG2
         X1i10TTmZNlyHMLCclDQhB2oM8EOf7ozIX372hP9HEfB8EzFbAHbQ62UiGxvbTOS7Wv4
         TYsw==
X-Forwarded-Encrypted: i=1; AJvYcCUqBAP+QIHDtW9zqj6/p/g7Zkt6pMhue3H7PPMM3pxgGycvIw6/ElXlBAaP3T0rUAvQYrWnYSIpAeuuLCWjAP8HZO/CqwUpGJ2e7yjs
X-Gm-Message-State: AOJu0YypA0kv2Ut0uYPFT/0UPr9kYP7294yx2FirIvcWI+rToonAd/7p
	7Qtb3bAnWR5B7jM8+50X7CpedpOKDmi5md3iUQKk/I+19aIQk9h3GyBLRr5urqI=
X-Google-Smtp-Source: AGHT+IHxnvgnCBnVOx5YrWZI7IIYL0JKxRUHUwFMlSq0RLjcqe7o5RxhbPGXRRATXFAddTNZRIxxnA==
X-Received: by 2002:adf:f003:0:b0:365:b695:ef76 with SMTP id ffacd0b85a97d-366e94d148amr1518807f8f.36.1719171265098;
        Sun, 23 Jun 2024 12:34:25 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4248179d1fdsm114756015e9.7.2024.06.23.12.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 12:34:24 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rob Clark <robdclark@gmail.com>,
	Sean Paul <sean@poorly.run>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] drm/msm/adreno: allow headless setup on SM8150 MTP
Date: Sun, 23 Jun 2024 21:34:19 +0200
Message-ID: <20240623193420.333735-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit f30ac26def18 ("arm64: dts: qcom: add sm8150 GPU nodes") re-used
amd,imageon compatible for the SM8150 just to enable headless mode due
to missing display controller nodes.  This work-around was later
narrowed to the SM8150 MTP board in commit 1642ab96efa4 ("arm64: dts:
qcom: sm8150: Don't start Adreno in headless mode").

This was not a correct solution, because the Qualcomm SM8150 SoC does
not have an AMD GPU and the SM8150 MTP board does not have magically
different GPU than SM8150 SoC.

Rely on board compatible to achieve the same in a Devicetree-correct
way.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/gpu/drm/msm/adreno/adreno_device.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
index c3703a51287b..a8afe0b6429b 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -838,7 +838,8 @@ static int adreno_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	if (of_device_is_compatible(pdev->dev.of_node, "amd,imageon"))
+	if (of_device_is_compatible(pdev->dev.of_node, "amd,imageon") ||
+	    of_machine_is_compatible("qcom,sm8150-mtp"))
 		adreno_device_register_headless();
 
 	return 0;
-- 
2.43.0


