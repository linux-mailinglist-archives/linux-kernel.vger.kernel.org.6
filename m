Return-Path: <linux-kernel+bounces-245663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47EE892B5B4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 12:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED0081F23E05
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 10:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A4A15623B;
	Tue,  9 Jul 2024 10:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZgwN+YdB"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB4115746F
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 10:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720521939; cv=none; b=C6DXu2smUwcsYMs19VtbigXk9B2P7NvueT5xL2ojiRtUnicy5OPLhsB1OEAQ4biRJpnyQh7JAQeH5+FKfbsBJi3u7nCcT0gEYOSDm3joT5qZ3hrQ+cbwh4Djl4pf4mc0xucGeaNMdVee/CmdSWNhfqNtn1G5H2ff20VXSvBryuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720521939; c=relaxed/simple;
	bh=qLAOTrSFtuBecm3+EwggXg43xqGrGY4RLrmT8vpNaLU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L/fOkTX9jrs95FsrpMmck+Tgb0VTTV2PDFTXmGTpNPU8uI4I7tp5+wBtouu25Y+PhjTXgtQ8lYlsVVoePwgitNuOPntu4zGxXSsbjgiIsODdGYVbZ2rT6TtIaBPD5Pc6wYUs0MvC3pFOEf61LsOpJrEGdULrc2Z92oKFQyqLLJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZgwN+YdB; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a77c9c5d68bso468872166b.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 03:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720521936; x=1721126736; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gToTLptM86w4DbSg4pVJQrRVwG35LsSkyYQCCt7KVjw=;
        b=ZgwN+YdBgQhN2MBnsLSfOTUs5jUXRluiwgVocgzZ4IXvyRcqwS399wdLz4MeE+hfog
         L03SL55zD7D09DZbX328SIZPZOiV+BSgW1kVG4ddH2pQ2UGacvLvdfBWY43NoX0MieBN
         CKTxJY20tmsM2ju/qo4zoxsqYO9Q4/rYUKp7gEYWYTfpZMOyVmWjOWI/i988vdjo1NpU
         PhrKGO+vt9rKoYiXzntjrm3jBpGfbauJg+kMKj3wq/uyyvepPBjCAjPZxzknI/bEX7ic
         d83SK4S2YvDwrLCVpzLdOkOPFcHugWLCS7I4QFD2T786Tk5SnocH0lHcRf/ilZIrdlGi
         JhTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720521936; x=1721126736;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gToTLptM86w4DbSg4pVJQrRVwG35LsSkyYQCCt7KVjw=;
        b=EoxIuihEj6rzYLSRML3tHll2spnJvU9ApH57YOpfkUV91E+c5v/ldc7Lj/KAAPphga
         TSzeQ3XGwoUSVoscpjlyDtGjRRjyzjNlJNEX2Z1aM28aFcyOSLWfgGQlLgMRk6POSUep
         jtUb28XSRcFJ8ss4MqJMqhz9aMxNSdmzgmnFUR+QlyVOs3HJ1AhkKV2DI4T7AxCS3ocD
         FZcN3qJfSX3QxSRvqGI2zzOGGGoTivJY4mH/Sy6h8Bzg5PYfDWNg1KuaIE5KTwL8qhxQ
         qjPvNjy76hVZmfiVmmS0oc0Fj6tfPJiPoov3igRnObTaaBqKw1pHNUc6bzjhs1Y0L5Pf
         povQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0cCtRtt7unbpXNg9QQ92hV+lQzyB2PigIaDioI1mfyJL0r3gz335iiRXsWdDbIMIGqP7U1ecM02ycdpkXuWEXSDrNfp8Rncw0yuvo
X-Gm-Message-State: AOJu0YwmaLF/Nl1+Mdsb4gJyPj5IhJJxtQgMgih9RXVqFD3Gg3vLs5Xt
	YVUscfiAAvhge4909bqv64cP5aIcxGoECgaGjvu6xf3RfY/o8ZqQhP3zuG3NDwI=
X-Google-Smtp-Source: AGHT+IFW3cXCBLhl8y6tH7WGUVEU2s6NXfrAid4cgw+rlJCWH5RBeVmuYYGgJqUJYlZ0TQecK8lYqw==
X-Received: by 2002:a17:906:81d2:b0:a77:b052:877e with SMTP id a640c23a62f3a-a780b6b3605mr146799266b.19.1720521935892;
        Tue, 09 Jul 2024 03:45:35 -0700 (PDT)
Received: from [192.168.105.194] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a7ff038sm66295466b.115.2024.07.09.03.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 03:45:35 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Tue, 09 Jul 2024 12:45:30 +0200
Subject: [PATCH v5 2/5] drm/msm/adreno: Add speedbin data for SM8550 / A740
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240709-topic-smem_speedbin-v5-2-e2146be0c96f@linaro.org>
References: <20240709-topic-smem_speedbin-v5-0-e2146be0c96f@linaro.org>
In-Reply-To: <20240709-topic-smem_speedbin-v5-0-e2146be0c96f@linaro.org>
To: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720521930; l=1480;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=qLAOTrSFtuBecm3+EwggXg43xqGrGY4RLrmT8vpNaLU=;
 b=felzT5CFkBH3CSD4+amuMEw8IiUfz80JoigCu+pRFOy5BlFTjJygWaDDjwtuKGHNKBhm30wZg
 NBUe1/jVPMZBLTAjuLJBMe6dl3+f4IGUf2f654Aut78+wx/zTfxZ3ug
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Add speebin data for A740, as found on SM8550 and derivative SoCs.

For non-development SoCs it seems that "everything except FC_AC, FC_AF
should be speedbin 1", but what the values are for said "everything" are
not known, so that's an exercise left to the user..

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
index 68ba9aed5506..e3322f6aec13 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
@@ -11,6 +11,9 @@
 #include "a6xx.xml.h"
 #include "a6xx_gmu.xml.h"
 
+#include <linux/soc/qcom/smem.h>
+#include <linux/soc/qcom/socinfo.h>
+
 static const struct adreno_reglist a612_hwcg[] = {
 	{REG_A6XX_RBBM_CLOCK_CNTL_SP0, 0x22222222},
 	{REG_A6XX_RBBM_CLOCK_CNTL2_SP0, 0x02222220},
@@ -1209,6 +1212,11 @@ static const struct adreno_info a7xx_gpus[] = {
 			.gmu_chipid = 0x7020100,
 		},
 		.address_space_size = SZ_16G,
+		.speedbins = ADRENO_SPEEDBINS(
+			{ ADRENO_SKU_ID(SOCINFO_FC_AC), 0 },
+			{ ADRENO_SKU_ID(SOCINFO_FC_AF), 0 },
+			/* Other feature codes (on prod SoCs) should match to speedbin 1 */
+		),
 	}, {
 		.chip_ids = ADRENO_CHIP_IDS(0x43050c01), /* "C512v2" */
 		.family = ADRENO_7XX_GEN2,

-- 
2.45.2


