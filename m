Return-Path: <linux-kernel+bounces-203151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD5E8FD72E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 22:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26C96B22F54
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 20:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70FDF158D78;
	Wed,  5 Jun 2024 20:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NmUY1Icr"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035E51586C7
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 20:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717618227; cv=none; b=aX0hMljB56YqzXX0q84X2SOOPkixvn1SvJNSiMDQvrl3a9TggxG3sU4s6qZlaFDDv6p6LkJvR9U7ChBQqUhpXpQ4UCg+KJMukzk2E82RNGTvD/3usf9yEzHIX3em7310GNk4F183oGQLL30RwZ6Rw8nkJc6I4u/4IhuXS0M5U/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717618227; c=relaxed/simple;
	bh=Oo6+gHUKlPRzoZULFedYFmiWhz4b3mZ9Jvr7zXkE4Lo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QGAsEgawBpedHjP9uZhO5rFjU678QaIy6lwLXS7gJzAAU4KjNIAJ/dcxPtI9LrUFsKNZMgEJnJBF7jsBQ69m/sI2Q54xawCoxFjqRCDyjA99fEfHIE26KFtWC7+2iiM+sTzyObPCYdK8X53Kr6WZd5gC1hIv9ZZ9mewWxfPXrRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NmUY1Icr; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-57a1fe63947so235184a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 13:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717618224; x=1718223024; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9Vw9DX3CSwtkdBUffdnArBNjtVj7mHBTphGyv2QQ9qI=;
        b=NmUY1IcrMtrLi3mz9dt83ZkcN27tvBoPshfWiiGjzwV4bPH3tcE/vCZJZ2aIg4sdpX
         +DpLPxCYc8Lm2wsWJ3T/+IRXwATO79KwY4756pr0pUa3HyK/ic0or6M2cfLLSY5RWv6E
         WLAC28nNrHR80p/mV7NMT5aKdKe/5gbn9boltuC6cEUlcky+mHSjtzGXz1rT7g6o8ItT
         NPmer9I9zJfVNub2hRKZJ9xR1xQUePy91sM7U/QVfvOo39vQePYAu2zlW5CilHYNlNrU
         gGRvBfdWM94IDpt93ad2hzkUfGPB9pgkoMKry50HSgwX9eSaO0EuQTNXFfrR+aNfDk1i
         phuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717618224; x=1718223024;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Vw9DX3CSwtkdBUffdnArBNjtVj7mHBTphGyv2QQ9qI=;
        b=EDrxt9XYK5e3LcH3EQtp13xtXB5t7I35pLd62ovpk3U1DtzxXNYXoUQMz9jjc7j/FA
         JNOr+rYiY7sLJrHBMq/48AZkYHTG+zhq/XcFzpih8uMZqX6ddbvWoih4wMOpzVNgLiUx
         /QHsg46R6cEeB/gFFH11segBHdxHE09BAyYscs6DzuYoMiWzFb9ksVQKW/0xSqL78IqO
         M7zCDqnhqCh2jfcbiKezq/1GIoriMLcSzLDQ7VTI8ksU4+rVsBNUaigEZJ1qqIqTUCs+
         4E+Fim2g0to20kCFUZzjMby3j47z5z3z2GB2Usop4jP+hkrTENLTC1SxMrsUJqcijnX0
         hKwA==
X-Forwarded-Encrypted: i=1; AJvYcCW/AYhDMZzcXBxInc4L3HH/6p83a6r3a5RQnslXh6BLVRSEKnaV+TsRt2aQA/K1XYWCgZ7+6qM2AxtCskEA2YvM5bGVsFQSOI6Cpj1V
X-Gm-Message-State: AOJu0YxofYrdrGr85aXExB6rr0bU0LCSHIhU5QNYjw5yOj9DJeWFAvZI
	QvOgK4KwxMPgGpO77iDSr4LOtwHwnkUJvfI8MsLtgIFET5qpcDZN3o7gN4I3aI4=
X-Google-Smtp-Source: AGHT+IEqlV2I5Db8a+ZFkhPsAYnoI1F1oliPNdAwUP8AaIYo4Qee83CiizfDot/q8uaYVI2GD+cyRg==
X-Received: by 2002:a50:d497:0:b0:578:6198:d6ff with SMTP id 4fb4d7f45d1cf-57a8bca263cmr2379893a12.33.1717618224135;
        Wed, 05 Jun 2024 13:10:24 -0700 (PDT)
Received: from [127.0.1.1] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a31be4e36sm9717473a12.53.2024.06.05.13.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 13:10:23 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Wed, 05 Jun 2024 22:10:14 +0200
Subject: [PATCH v2 1/7] soc: qcom: Move some socinfo defines to the header
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240605-topic-smem_speedbin-v2-1-8989d7e3d176@linaro.org>
References: <20240605-topic-smem_speedbin-v2-0-8989d7e3d176@linaro.org>
In-Reply-To: <20240605-topic-smem_speedbin-v2-0-8989d7e3d176@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 devicetree@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.14-dev

In preparation for parsing the chip "feature code" (FC) and "product
code" (PC) (essentially the parameters that let us conclusively
characterize the sillicon we're running on, including various speed
bins), move the socinfo version defines to the public header.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/soc/qcom/socinfo.c       | 8 --------
 include/linux/soc/qcom/socinfo.h | 8 ++++++++
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
index 8087941a7887..beb23e292323 100644
--- a/drivers/soc/qcom/socinfo.c
+++ b/drivers/soc/qcom/socinfo.c
@@ -21,14 +21,6 @@
 
 #include <dt-bindings/arm/qcom,ids.h>
 
-/*
- * SoC version type with major number in the upper 16 bits and minor
- * number in the lower 16 bits.
- */
-#define SOCINFO_MAJOR(ver) (((ver) >> 16) & 0xffff)
-#define SOCINFO_MINOR(ver) ((ver) & 0xffff)
-#define SOCINFO_VERSION(maj, min)  ((((maj) & 0xffff) << 16)|((min) & 0xffff))
-
 /* Helper macros to create soc_id table */
 #define qcom_board_id(id) QCOM_ID_ ## id, __stringify(id)
 #define qcom_board_id_named(id, name) QCOM_ID_ ## id, (name)
diff --git a/include/linux/soc/qcom/socinfo.h b/include/linux/soc/qcom/socinfo.h
index e78777bb0f4a..10e0a4c287f4 100644
--- a/include/linux/soc/qcom/socinfo.h
+++ b/include/linux/soc/qcom/socinfo.h
@@ -12,6 +12,14 @@
 #define SMEM_SOCINFO_BUILD_ID_LENGTH	32
 #define SMEM_SOCINFO_CHIP_ID_LENGTH	32
 
+/*
+ * SoC version type with major number in the upper 16 bits and minor
+ * number in the lower 16 bits.
+ */
+#define SOCINFO_MAJOR(ver) (((ver) >> 16) & 0xffff)
+#define SOCINFO_MINOR(ver) ((ver) & 0xffff)
+#define SOCINFO_VERSION(maj, min)  ((((maj) & 0xffff) << 16)|((min) & 0xffff))
+
 /* Socinfo SMEM item structure */
 struct socinfo {
 	__le32 fmt;

-- 
2.43.0


