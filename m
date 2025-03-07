Return-Path: <linux-kernel+bounces-551719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5A9A56FD3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 18:59:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17E8D3B881C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 17:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3663B24500F;
	Fri,  7 Mar 2025 17:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WzIsNPtE"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C1523ED6F
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 17:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741370279; cv=none; b=SBDw0nwpavx3ap76XjjyXLQTpI2InwCSXV/+jv163JKlLbNtnUB11yXhdXbVrqviJp+BGVa0bI3UFQJWzegLrYCHmCN1JDSHChSs8WKnRvyhWaUyylQQTwL5YTwIuHxVq6UoD/RjPgL8BrRvsdHApPHies8yHLWPmAJedGBzp4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741370279; c=relaxed/simple;
	bh=EY2S50CyISdq3nPrExweydCBhMumYyhAyAOp25X2rvE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TmcT189R1GMC1ftsaRzWoZEmtYkKKGLK6A3aqpcy1nseDN5b6jNb6rHMqwDd2bara52rcoYL7v5e98PFwnUOgwYMRVqcZxqxyKgSXxUaLDbQwiP30MdJ9DpM4C+32J2o1Ei+hEl5Cfp6S9VY96RcxekdYjO9qSvD1EHrslTMnaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WzIsNPtE; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-abec8b750ebso364256566b.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 09:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741370276; x=1741975076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yEnUjNuUqm5QapxreDthsg15VWD/vl1byEP9/xBmO2o=;
        b=WzIsNPtE+GPLo+dxM5uxdkBJLJaH1TKv4z75TTq8PlpVL7hTZnn3I/zM8AxTREzFvs
         OudeMdi+gtlG5Rr9p9ZOE3L1R7HYUJUZCD7Yo+iT4URFyrW8oj4qAMpYmhW32c47yQq3
         wMyGSVc6BAKTNjQfb9UVR/v/VtIUMFFwz4XEMpc/nCiSr5CNoBlmGHIk/ovAweiGAR4q
         3TuSbqUXdllp+oHiDDSu9FBK+7Is8Vi9Bpoio46os0IJ8Pgrczhk5+whSFqD3HrGNwxZ
         JP05PlugjvjubtlUZNmdWUGasnmCtVd4rusSkeXYRRWsc3O2DFld9Uxx9SBQzhMrhnIZ
         vJdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741370276; x=1741975076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yEnUjNuUqm5QapxreDthsg15VWD/vl1byEP9/xBmO2o=;
        b=AGRxlVzPoVflouX8cFSbSpoO0aazsNeLVe21EaxMlw4IRL7V7bevxHRu6GIJ1ohJR3
         zSXZt4lFQiRwbFL5pQDPXVGb0/oi+yEREbNrpYKrS580czddDbarhFHC5s83trK5X+XW
         gaokassLOe0l5BDxtEK+8jGtcrM0dxPt8HqhcOETmOQRoHV/DE7zI3B5cGhScrzubAGv
         7/iUYecQg//+x6s6GVp45e8kkWMgD4vRQLv3N0uhouKlqCOsEoB9OsDoAMiKB9db1+hx
         AwsLuxpuHxg1gT+yeFMa5k+/9h0LAmApTooQoReK+/Flw06ot4Y3be+52vXhQcT7SLKQ
         Hthw==
X-Gm-Message-State: AOJu0YwmGq7zCDRCGdtZZSVRsqhbXuWFq352ahwTh2UDxNlzPqV35CEv
	g6Gc0h8GaeWCb/Cmtc54Rcnu3nPfwfI27Y4/j8Diu20UsRyhAzZYu7PTgN8Q0bY=
X-Gm-Gg: ASbGncvo0C5bxU/rYqRyQg03wqGLbwcH6ZY6U6x0FYFpHuWxkBCYystIgNeICjd045X
	zztZP8qzSqLitrjqZ8eeagzbCdjZJoLQmrNKnX6ApZ99wR83GkX7EBRXn+26jv3LSgq6Bio62Op
	gCKx44cnfQQl+y7F/MDECspDqC2i9FIBmDFQuUvq8upihxTcdQHueaQ8Sn17xQ7Sk9tZgaZmLPw
	Z/hNCexoJ/PlnGEms1JnTqEvbyFH15GtgyDgMeBXpPxeDOB2tX9u2Z77A3HuRaQsJ/fZWRVi3f2
	4gNRlarRD1F1oldqiKM6v+M4i4e6zlb6SWkrgbOWhOOrvcyz/Vjkyledd28/3deqCpdg1Q==
X-Google-Smtp-Source: AGHT+IGYCJyBSl7Qxssu6C6DdQfbtYVHWO2yFLFhonTvDmBzTv5fH5elyGa5bKLiTtbsZxoN0jQfEQ==
X-Received: by 2002:a17:907:97c6:b0:abf:750b:93b8 with SMTP id a640c23a62f3a-ac252a9d093mr429146266b.22.1741370276103;
        Fri, 07 Mar 2025 09:57:56 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c745c5afsm2803622a12.18.2025.03.07.09.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 09:57:55 -0800 (PST)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Barnab=C3=A1s=20Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 06/14] dt-bindings: nvmem: Add compatible for MS8937
Date: Fri,  7 Mar 2025 17:57:16 +0000
Message-Id: <20250307175724.15068-7-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250307175724.15068-1-srinivas.kandagatla@linaro.org>
References: <20250307175724.15068-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=937; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=6W6zcrnhaw2WbDgBvmsytJG9L01rOF4mMuUIqSbG5OA=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBnyzN9t9Or2Ry5G+ZoMbzoQF1DbMBw3+O647n5X asfTxAD27yJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZ8szfQAKCRB6of1ZxzRV N/kOB/4yh39J/XqogX1iCMlhQRu042NzMAcC3Kud0u+zvbghjFrRGrfqYgu0fdkM+88ha7blJ36 9oYlI2RuXscdLhY+GX4MZx8KZtvaF3U6beYbFPk1Fz6C7RMpj+MwqiGsgL25NayLmSHBJoT5fXl 7YgAsYNYSZ7QrwzjXhP/WTWf8BLYW4qJtGOx9063OZvxUvbrH23dCX4mWSGos7hLZvOdTW/LCWy 5FGMHE6UpHXNHJOD6KqGsSW+Y8FYOHiRzRZ2GdKeY4WkoriMiEtnCgJ+/j2bHxVOUEccVVc64kj oXPwyKnXszFENOPEnjY3VEkbmvpBFd2hCtyeK3/XbPR/+U2e
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit

From: Barnabás Czémán <barnabas.czeman@mainlining.org>

Document the QFPROM block found on MSM8937.

Signed-off-by: Barnabás Czémán <barnabas.czeman@mainlining.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
index a85f817b015d..a9de635bf31e 100644
--- a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
+++ b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
@@ -28,6 +28,7 @@ properties:
           - qcom,msm8226-qfprom
           - qcom,msm8916-qfprom
           - qcom,msm8917-qfprom
+          - qcom,msm8937-qfprom
           - qcom,msm8974-qfprom
           - qcom,msm8976-qfprom
           - qcom,msm8996-qfprom
-- 
2.25.1


