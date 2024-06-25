Return-Path: <linux-kernel+bounces-229553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 348969170BA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 20:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E30E028C319
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 18:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A53017E46B;
	Tue, 25 Jun 2024 18:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Liz99xOH"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3796617D356
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 18:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719341691; cv=none; b=Q8zMEmpAPwZ3rfi+JSSqt3Y+Wpm/EeXgp9nQhuQfFjYgfz1cHrAkPAEZDUBirNsuNQT2sNtTkAqfO548s0dedfmQMb59w5d+/ysB5TVp2J0OV+6h/bJFfdExbv1zeRmPWg1LEWEB4YULEVq7i6x1F9B6RnoVJhiUHIb0UB2IoAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719341691; c=relaxed/simple;
	bh=IqxT/XaY/qre3pbFCzxDe2dM3jXz5RZUhwZonz27NSw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MmLmCIYvGdML3HsTr5/hkZ5afNgIvWL8Klrc/fCWJiy4tmBbynr7O/yDlQsmk6s7ydjjaBpBimI6spTh3n1aEMFDQgBO5xsI0RJgsK4yrB/tEh8BnyE99Cf0GURhnNuMM5D3e0Rp4qlD5rrBxCHeuA4MIjxqMlv1/dg88x6+xFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Liz99xOH; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-57cc1c00b97so5877180a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 11:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719341688; x=1719946488; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RslMOok7+SRb0tZIuuUneQKJy4llxQByohMGQm6a7lg=;
        b=Liz99xOHAAMrYLHy1Hkenqd3auK7yMLH21+J8Clks0u/RxHlVQAkSjaiYW/x910g/j
         QyG5NidzufPcsANnVu78wIG67T+Aq8CJUHPM3Pjck11AjsBZCvvLKtGi3LDgNpp0MkLu
         z9ONgtmkxXGC9OEKs7HY/yjDUCmDScH06vNREym/fwqPvQhZRiw/OYZ/i2ij9U/2gF99
         8rNpB4luyxQCSjH+PgOE63UcuXNR/jVzP77wf9hFJvP7Vvv98Yz25LJ0BJcvabdhyktY
         83cMEfJHBdL+rqRo9sUNkQMzKk7Atb1lAOHybrWpxzZad+HnOzcLqod7KIOJ60rZBK6Q
         KoFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719341688; x=1719946488;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RslMOok7+SRb0tZIuuUneQKJy4llxQByohMGQm6a7lg=;
        b=hPwePwSgyLtoAowTEBboBpJZfmxnV9gN+3mNnQimmNgXHhw5KFYDO2phyqSpfCryiB
         hWRf/pIAQNgUykRf/xefhOIZG9foLQuFi3XgU1TKgmUh+LjlpBjrjLpzUFuV7ynYP1tR
         EYvJmymTvzW+q0Qshi8wL9tSU2aczvcPkgaVUH4tVtCl92/+I1boWZnevXIsMjghOxG3
         V6Y+hPXfmyM2ex5+4V4eV/d9oP5KACLiJmrEooV7uAcEa8C9+7cHiev6/jSo7ZCbMuHN
         vxY2T+G9evpGqLc0IfLbF+2UCp//62p6sfWoKrfnHKgzncmBe/nj2z0ft8aIWBagprzo
         P4dg==
X-Forwarded-Encrypted: i=1; AJvYcCVX8dN1wiXF8HP7ae4pBzBM5OwX/0goZrG6uaHJ5wqjHWdxaYjMqu0Cj25DCIwu4UyU3AF6zGPJ5MsWRMbCgPC6KIZrlmmD+D5hpwqZ
X-Gm-Message-State: AOJu0YxSbUfAhjkhjTexo6Fd0WaqG+r1Y3ulskBR6L59bQCurgPNcq2/
	5da6voY35Zn6q1bqTWpkDeIUxOIbmAxq49YIyH//VBrbtqyUAiWnhKl0hZMqlqY=
X-Google-Smtp-Source: AGHT+IGgV5XNEHZlscPIUwGZlGHAvsdbFXvfBd3MkXeqG+BdMPDfhtOjj2M3SWB0pI6uYjgg1nm5bQ==
X-Received: by 2002:a50:c343:0:b0:57c:7ce3:6cd9 with SMTP id 4fb4d7f45d1cf-57d4bd8173amr6264270a12.23.1719341688229;
        Tue, 25 Jun 2024 11:54:48 -0700 (PDT)
Received: from [192.168.215.29] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d30583e93sm6206332a12.96.2024.06.25.11.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 11:54:47 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Tue, 25 Jun 2024 20:54:42 +0200
Subject: [PATCH v2 2/2] Revert "drm/msm/a6xx: Poll for GBIF unhalt status
 in hw_init"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240625-adreno_barriers-v2-2-c01f2ef4b62a@linaro.org>
References: <20240625-adreno_barriers-v2-0-c01f2ef4b62a@linaro.org>
In-Reply-To: <20240625-adreno_barriers-v2-0-c01f2ef4b62a@linaro.org>
To: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Akhil P Oommen <quic_akhilpo@quicinc.com>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719341683; l=1182;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=IqxT/XaY/qre3pbFCzxDe2dM3jXz5RZUhwZonz27NSw=;
 b=bf4fOmgiiY9wBmlPLmScoY7M3PVhXAq9z2YI3hCMleizQn83eYlbtCBhdiLjMkanneiBIOPKC
 IrQh0EQxtzKBYdtR/m9m5FMJSE+oheGuEHORh4MyKpSMMYSeCtNfD4f
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Commit c9707bcbd0f3 ("drm/msm/adreno: De-spaghettify the use of memory
barriers") made some fixups relating to write arrival, ensuring that
the GPU's memory interface has *really really really* been told to come
out of reset. That in turn rendered the hacky commit being reverted no
longer necessary.

Get rid of it.

This reverts commit b77532803d11f2b03efab2ebfd8c0061cd7f8b30.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 4083d0cad782..03e23eef5126 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -867,10 +867,6 @@ static int hw_init(struct msm_gpu *gpu)
 		gpu_read(gpu, REG_A6XX_RBBM_GBIF_HALT);
 	}
 
-	/* Some GPUs are stubborn and take their sweet time to unhalt GBIF! */
-	if (adreno_is_a7xx(adreno_gpu) && a6xx_has_gbif(adreno_gpu))
-		spin_until(!gpu_read(gpu, REG_A6XX_GBIF_HALT_ACK));
-
 	gpu_write(gpu, REG_A6XX_RBBM_SECVID_TSB_CNTL, 0);
 
 	if (adreno_is_a619_holi(adreno_gpu))

-- 
2.45.2


