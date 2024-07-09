Return-Path: <linux-kernel+bounces-245660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E259992B59F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 12:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 112C61C21859
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 10:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21961157466;
	Tue,  9 Jul 2024 10:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ljsjyIM1"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE74B66F
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 10:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720521936; cv=none; b=K0iBl4CHcL3P9RRTM3JMjBl6xLMPtPZlBSRAypkAgxXIpWtviL9t9PPcFD2Phl8DrMFxQf3Luhwv+OEnWAkOz4Ru8bd7j9qLKTPHOqzCI9kUmz5tavazNNuDcBrI81eT/ioFuBs3/l7xLjANLjSbokza+iugMTdDIAJzApiPpeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720521936; c=relaxed/simple;
	bh=DiKuajQjDvsPgnq/MT8rUGokqmDQszLk8ppgz/Da+oQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SbbSBNh71JldZjKWe6nJg/PAwKiSy1IqewBDX1UXLfXX2wojBGKyfKQ5QdL2zexXZsBmdkFeMOYcQE+erXCQ+mbKrzMVnKJ0XfDiv9CLFCHi0nOoCfJeIkzZo+AOGsdYHIGm80EZ1AyDrawb41WY4QXmEqmloMXUBtVSfOa1Bg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ljsjyIM1; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a77e2f51496so363619666b.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 03:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720521933; x=1721126733; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N1Uy4SNyn83EE+iKJmeAoId3aAi1waClmvNIPZ5Lgz0=;
        b=ljsjyIM1nab0NbXQ9rKkMlZLFsjLa9OH+RLzGeOm5B4I53L2uL7SrfHGfw3yJE4ZLz
         zOM8ECOc7QzajUt0lzWV66tVpYuhX1ovPy+n9RHHrMnOy1kyj4tIuOQiwcr+A5j9UmXX
         g9E/QFTHAnGejrwlelUU+6eicPy20UGhxIjdK7S20XskPmGxBIVa6yP6ulTL1Wlv6qqJ
         6NgNOakpZ87TaBOvnNiy9feXHaRjZ9hUU+7NR5Qzzw9RmuSMFMiu46t/K2ZLGeOOx5Nc
         cd/9ZP09HmhmCUgbj4Q0N+s9DBCbISj1TVR73FpOgACQKzl5VFPYvjPrTEnJem9kq0lK
         4o/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720521933; x=1721126733;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N1Uy4SNyn83EE+iKJmeAoId3aAi1waClmvNIPZ5Lgz0=;
        b=cNSzBq/hN3tbWgt5b8YAS4jYKREGdqqfrqTyq2SD+4wnmb/SAWBi9mcbJOKgiNBzAd
         +blGmkfzA+FOlEZXOr9RmUB4C277RCvexL5h5awG80RHmJxUreWNudFmdnnZLn0Keyxv
         /6duEjwoGAu8biHiYSCUN7cE5miq4pYPZ2BFjLG91Gkpo6PaOzh7YeDhkhepBs+wEpRQ
         SM9eEN6MTKVWE5EsjGs4p1E/MmSaxJ0WRLAid3THZ8+Pc7BDuF0qRa07OzuLyPUCuD37
         tn5PODKdoK+ug2+s6HVsR9WZ72sOGXnprwhBzjMCbjlcf1njQRER93Qo0nXfljMwuANG
         g2Gw==
X-Forwarded-Encrypted: i=1; AJvYcCWhbx2nIfDPJCnoBsQftR2BcSUE5Sy8ZNlUullwhnqtT81CJ+Tmx945Ez81AmvNxrZ3bA+dEdDmeOyXBefz+qDKB9fLQDiMiaYAlfjS
X-Gm-Message-State: AOJu0YySPw8mkkmooDcHGHCtlP5Mt5ZoDfN8Ywdc16aYEFCzzviLOcvc
	IXeHIDJRHdAiyCD9q2x+p2we63I6gH0FnjlLET/gFntnevjnbjXEgIKRBc9DCvI=
X-Google-Smtp-Source: AGHT+IGkgRr67p/sC6tOf9bUtQJmcMceFqxyhsNdiCWp9IQntUPgK1fP32IeIXByAubS8QjEGDqQJA==
X-Received: by 2002:a17:907:724a:b0:a72:5a8c:87c6 with SMTP id a640c23a62f3a-a780b68a9d5mr160855866b.10.1720521932661;
        Tue, 09 Jul 2024 03:45:32 -0700 (PDT)
Received: from [192.168.105.194] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a7ff038sm66295466b.115.2024.07.09.03.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 03:45:32 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v5 0/5] Add SMEM-based speedbin matching
Date: Tue, 09 Jul 2024 12:45:28 +0200
Message-Id: <20240709-topic-smem_speedbin-v5-0-e2146be0c96f@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMgUjWYC/3XNUQvCIBDA8a8yfM5Qc8N66ntExNRzO2g6dEgx9
 t1zg4iguKf/wf1uJgkiQiKnaiYRMiYMvkS9q4jpW98BRVuaCCYkK0OnMKKhaYDhlkYAq9FTZQG
 MZRocA1IuxwgOH5t6uZbuMU0hPrcnma/bt1f/9DKnjBoQWjVS1Fzz8x19G8M+xI6sYJYfpBF/E
 FkQ1zglj4dWKy6/kGVZXgpKkof8AAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720521930; l=2800;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=DiKuajQjDvsPgnq/MT8rUGokqmDQszLk8ppgz/Da+oQ=;
 b=wJla8q9532uYuw6CKE5sv/3w36y0aZyhqGMRjEXDqC+Xaq4K9H5C/Bf7W6J/ovUdlL2BCJ0ms
 9XuL6HSJbyRCqB4H2hqDP/MhKQ1QDdeJfG56LRz2y6MmHwCeXk93YnQ
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Newer (SM8550+) SoCs don't seem to have a nice speedbin fuse anymore,
but instead rely on a set of combinations of "feature code" (FC) and
"product code" (PC) identifiers to match the bins. This series adds
support for that.

I suppose a qcom/for-soc immutable branch would be in order if we want
to land this in the upcoming cycle.

FWIW I preferred the fuses myself..

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Changes in v5:
- Rebase
- Fix some unhandled cases (Elliot)
- Fix unused variable warning
- Touch up some comments
- Link to v4: https://lore.kernel.org/r/20240625-topic-smem_speedbin-v4-0-f6f8493ab814@linaro.org

Changes in v4:
- Drop applied qcom patches
- Make the fuse/speedbin fields u16 again (as Pcode is unused)
- Add comments explaining why there's only speedbin0 for 8550
- Fix some checkpatch fluff (code style)
- Rebase on next-20240625

Changes in v3:
- Wrap the argument usage in new preprocessor macros in braces (Bjorn)
- Make the SOCINFO_FC_INT_MAX define inclusive, adjust .h and .c (Bjorn)
- Pick up rbs
- Rebase on next-20240605
- Drop the already-applied ("Avoid a nullptr dereference when speedbin
  setting fails")

Changes in v2:
- Separate moving existing and adding new defines
- Fix kerneldoc copypasta
- Remove some wrong comments and defines
- Remove assumed "max" values for PCs and external FCs
- Improve some commit messages
- Return -EOPNOTSUPP instead of -EINVAL when calling p/fcode getters
  on socinfo older than v16
- Drop pcode getters and evaluation (doesn't matter for Adreno on
  non-proto SoCs)
- Rework the speedbin logic to be hopefully saner
- Link to v1: https://lore.kernel.org/r/20240405-topic-smem_speedbin-v1-0-ce2b864251b1@linaro.org

---
Konrad Dybcio (5):
      drm/msm/adreno: Implement SMEM-based speed bin
      drm/msm/adreno: Add speedbin data for SM8550 / A740
      drm/msm/adreno: Define A530 speed bins explicitly
      drm/msm/adreno: Redo the speedbin assignment
      arm64: dts: qcom: sm8550: Wire up GPU speed bin & more OPPs

 arch/arm64/boot/dts/qcom/sm8550.dtsi       | 21 +++++++-
 drivers/gpu/drm/msm/adreno/a5xx_catalog.c  |  6 +++
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c      | 34 ------------
 drivers/gpu/drm/msm/adreno/a6xx_catalog.c  |  8 +++
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c      | 54 -------------------
 drivers/gpu/drm/msm/adreno/adreno_device.c |  2 +
 drivers/gpu/drm/msm/adreno/adreno_gpu.c    | 85 +++++++++++++++++++++++++++---
 drivers/gpu/drm/msm/adreno/adreno_gpu.h    |  6 ++-
 8 files changed, 119 insertions(+), 97 deletions(-)
---
base-commit: 0b58e108042b0ed28a71cd7edf5175999955b233
change-id: 20240404-topic-smem_speedbin-8deecd0bef0e

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>


