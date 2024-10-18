Return-Path: <linux-kernel+bounces-371771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B613E9A4020
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 15:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 701872810B2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 13:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB6B1FCF48;
	Fri, 18 Oct 2024 13:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UN3eI2Sy"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A075E1F4FA8
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 13:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729258668; cv=none; b=sTXKERdLS2UC1pox1dDtOqnRy/kiwk7wUhUW5be05YqQTcYxMy3yzoh8FadLoNOv2lli4lanu4TUvS+Y73pFc1oVrlsBhsqF7WFPfDM2qVIx8lu1dmfTDvu9oRu4nmA2bNLNSvGBhyPwsBswo/hY+1pkPo6A/F/L16BpVoVvNgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729258668; c=relaxed/simple;
	bh=NrBqsWCuaAQ/Cuj024knkF2DII41vrMEDac5L3LP/gg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=qsSEnxYuFArwjCh8Vnlq5oz2S5Lvu45ECENllSgPClxFGUoGHDEOoR+EE4hWrFnrM9qwhzRQCf+9sW+sVZFPNd/z14DcVJmPP5OR6VXN9vUzsoI3e3omSsDuMz0gBP6G9M29t5KvbPk02NZPDVdcxZH6eih8j24hlYGQNC0y0p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UN3eI2Sy; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4315c1c7392so16203855e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 06:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729258664; x=1729863464; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9g6X28B6QyIz5mltae5jx7UaHpkhC0PDITotQrVOf14=;
        b=UN3eI2SyQNhly/zf/tYA9OKDmOzCJ8cqB8fnViL7JYyCsWzz/6VQtDW/aQ6UVhR5k1
         vCNORJeCsK7lF/k7qlm6sl2AK22oPXOAfy9u+9QGpqf8htZ8s/oytTOGXOyPki08yGB4
         geCbPzBYesbtezyTvvum7lbPpSQ9P4tWHutbpHuKSs7nCwxJubRYQPiW2k1QWtzGEqgy
         A1JlW+NMS+i0SApTeHlM1ZU9aW7V1Z8mEJZjVaTOr5vo75SxCSZ7wg/83xuE5wdJwSCX
         G3fffk7AXS+9FpzvSq4ezddvXjezur026AFBzM9yYPInHISBDUWRL0pK3VVUJErdjOJI
         LBqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729258664; x=1729863464;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9g6X28B6QyIz5mltae5jx7UaHpkhC0PDITotQrVOf14=;
        b=WBvF1+1byO997OdiKOvBnX6XyK0aFft1ZxODafr9CEhu0ZimAaaMg88iSlTjX0smI/
         4ZihLRs1S3NOr1Q6DRVpb0pX4/YR+lF8u0TVtJO0q+/rVr2bcbmdBmBx75VFat1XVcEU
         cmEjN1PD3oF/1CN0ruXhQ0NdN/u6HT6B0cS3SD54L6jXQ2n+ACEt9ZzM8MMnCqmySytR
         zxMWz4ZYuBpA18BKSe1cfHHyaliutVt8nq4fWAZLcq+I1G7aigBk8GV3pNrkrUtEJzb5
         0W8zxloOQt/blWlqtWiKB0GLKdLR/4lHpI3pUa/OhP2W5C7aabcuFC6iejzR/qFlJzEm
         FZsA==
X-Forwarded-Encrypted: i=1; AJvYcCWX6S5YL+BnscBzE9WRVK7FQwe2gzlw4Tp+zrJp8xWebHmAoGl+5i/pzAR/HK4+qvIp9tIGgVazuQGwkAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEiHleBin0EmgqL8aQ0YBPZ6g8l4k1j2Huk6LKNYf4XMwKZQY+
	0GMQay8N4G4WYF3B1BZ/SlyBXKzT22SSD5mZ72mDhMNJ3qkrK4mI662iCvE7fSvctbjYatXgKgS
	3
X-Google-Smtp-Source: AGHT+IFCUgN7OzzYT+R+UjYNcvyXfv69g2h0+VHrvjEge4+4nbLU62Z2mcykFjWYCuiCipDnNr9mRg==
X-Received: by 2002:a05:600c:4f09:b0:431:542d:2592 with SMTP id 5b1f17b1804b1-431616a3aaemr15875525e9.27.1729258664468;
        Fri, 18 Oct 2024 06:37:44 -0700 (PDT)
Received: from [127.0.1.1] ([82.76.168.176])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43160e4437dsm24305925e9.30.2024.10.18.06.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 06:37:44 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Fri, 18 Oct 2024 16:37:36 +0300
Subject: [PATCH] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Fix X1E80100
 resets entries
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241018-phy-qcom-qmp-pcie-fix-x1e80100-gen4x4-resets-v1-1-f543267a2dd8@linaro.org>
X-B4-Tracking: v=1; b=H4sIAJ9kEmcC/x2NwQ6CMBAFf4Xs2ZfsYonorxgPUhfYA6W0xtQQ/
 t3G4ySTmZ2yJtNMt2anpB/LtoYKcmrIz88wKexVmVpunbD0iPMXm18XbEtE9KYYraCI9izMmDS
 44pA06ztjlMHJcD13l46pJmPSav9398dx/ABPU/mXfgAAAA==
X-Change-ID: 20241018-phy-qcom-qmp-pcie-fix-x1e80100-gen4x4-resets-f1b41b935750
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Johan Hovold <johan+linaro@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-arm-msm@vger.kernel.org, 
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>, 
 Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1472; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=NrBqsWCuaAQ/Cuj024knkF2DII41vrMEDac5L3LP/gg=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBnEmSiuAUWzOzRknYiBKK4XsGyfZq0uJbv4jtkv
 /gpfSjkVb2JAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZxJkogAKCRAbX0TJAJUV
 VpEyEADNVS0D7L+QFC6C01wOBEDU/N/MpIsJDVUJsA2T0SZFxAX0vfVa43uZaHeuq5QKFeLgdD1
 PWAnNBY+2PINh18jAUjHB58us46ZFK7BscC563BCTxioIDySUOGG6aWcBMLtzslRk6u30A1J4tz
 hlCZQOFlQp4NoKR5JHquZXErtF01oCycx4d/qxNwVEIcI9ozWeDRC0W1cN8L6/YU/0alhQIUKdk
 TXoQesmcFrs6roJBsq51OH4fhwYOUPa9A8qxcdrfYaOaqOEpowu8QbsPt8zB07vZbLVPrmbOPqT
 KoLO4cZw52O8ejRcqMF6g/NUdMqNGPaAjL7mbJpCmjlm+ZiNwGR/IQOK2sR7mOc3sDV98N9Clca
 ErFVzBXM977a2hRl91IqCMmMtBYZ1GPcw2oa+w2rq1JlXUvGPkmB7rWVOi3fw3bi8ssbHlbDSH2
 9p3Pa7Bky7la9Ye/l0z3zAskfHdiJw9a5vYX/9cqc+s2QUZO+/MNL1/miONnweHMfmASwE+mpIU
 hhGJe91Leb+I7HMgzx7uexHRk2y+JlgZ5hnuUKuhhVPX5VZtd5JEJu5f9SJbhLrDrB2Av8OFL2v
 R1SZFzXPY0r0bBvaOLdjQ7wtvBDDtll7mX9ttNUvUMMbQpKshiPwJpM/EIvbP17MJOzNiddQiTQ
 08kpXaTs4loiHAQ==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

The PCIe 6a PHY on X1E80100 uses both resets in 4-lanes mode as well.
So fix the resets entries for it by adding the Gen4 4-lanes compatible
alongside the 2-lanes one.

Fixes: 0c5f4d23f776 ("dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Document the X1E80100 QMP PCIe PHY Gen4 x4")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202410182029.n2zPkuGx-lkp@intel.com/
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
index dcf4fa55fbba58e162e5c7bebd40170342039172..b5bb665503c86c79940031bcb58a36a833918a4e 100644
--- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
@@ -201,6 +201,7 @@ allOf:
               - qcom,sm8550-qmp-gen4x2-pcie-phy
               - qcom,sm8650-qmp-gen4x2-pcie-phy
               - qcom,x1e80100-qmp-gen4x2-pcie-phy
+              - qcom,x1e80100-qmp-gen4x4-pcie-phy
     then:
       properties:
         resets:

---
base-commit: d61a00525464bfc5fe92c6ad713350988e492b88
change-id: 20241018-phy-qcom-qmp-pcie-fix-x1e80100-gen4x4-resets-f1b41b935750

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>


