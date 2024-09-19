Return-Path: <linux-kernel+bounces-333433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C78797C88F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 13:22:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23CB11F25A72
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 11:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08FA519D8BD;
	Thu, 19 Sep 2024 11:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eixflorJ"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A1919D8B5
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 11:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726744931; cv=none; b=FXFgcxSuW5FFplenrsgnC3bh7KWF9ZluCjWGmu0x8+dkJRYxpJnUXon1xs8GBotMqM+87JzjBRwF+muTh65248yyK3h/q4F0eS5p5QdY+GfyzsQbnXdiwIRiPHwt4u0tvqNFXhjaaSi4ahIzbSU6DiF2iYNk1sFFAqYXcZ36Ks4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726744931; c=relaxed/simple;
	bh=sKoAjOs8rD8K8GFRKDaelO9zPYv1akfq34sYpYLjJf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iqu4HgNkKFOnJGteTgXl8RBcZmDYy6hgY+pJwuXTZtixf71djxoyC3rPb5dfXir1agCN3hQmqjhjBvviL6m+iXfTTos0aRsnkl93ro6pvyqNjQoudFVej1Thd3E+0MT1mtDjDlpEamZ2fe1+VOfWlSscbWnmPR2PQKQtLl0ikuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=eixflorJ; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2053616fa36so10118705ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 04:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1726744929; x=1727349729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dMIeIkBw/sEwhttTsHHImWJDak9J5XbBMV3Q0L0EynM=;
        b=eixflorJzdiHWNAwYWP8VMHwclhVhoTUpfV8sZg1x0f8SxTSYxQtaLcF9OJgq4/tH1
         tqxGk+GQ76BBnXAW+Eox2hQUVb2s5hLjsAY4lmeSqwq4Qux6SLIjqP64i0UoXEoNUyAQ
         GJb/jS8ED8dwxNKGAPmgz5T078brg0HeOjZuQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726744929; x=1727349729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dMIeIkBw/sEwhttTsHHImWJDak9J5XbBMV3Q0L0EynM=;
        b=NpXbzmCf55Sj9BraldWovI+hkHxZ2/3mJyY7jT5YaAuj5FdDbCVrUv4WFysI3TTdOO
         qvmRKfYBmFSypq2sjX0wqfLnQQfrPrbV1l3fqWvZtP/xy+AjMUJSOJAyXP10o4s1a0ni
         pLEJDygnEYMEr2bxrEKWY7BCntpfqDHiRIG+tipsD/zBgff/Konak1qsBSZHAkUIwsAv
         ETH27HKOwCEUuyCrcvvN1hdh1c8vjQgGxSEX6/OBPrk+em1Rew9pUFqrQjm/q3tA+b11
         A49yiM3V+PmuwGB1UCc5Wbhzt2wz8AcOwGkgWFTFI1n6ULlQA6yHS2uK71EqtZt9Rfyf
         Nzvg==
X-Forwarded-Encrypted: i=1; AJvYcCWS2wtlXhqLY9nZRMvck8P919gmujFjaMSyZojSZKZWcSzeIb17775i/CMs+/SlFChBDxzCtvq5dD2luvE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO6PXI/0guj7guErAQ3fftdnU8NYB8tuKJnj/blhZRmK3UzFMD
	Pj8oGAGoeu2FmxD8+V2FZx8CqjGuEPB2Xriytiu+2aJXlDRJ1ImtsLbT9hBlZA==
X-Google-Smtp-Source: AGHT+IFk5QDD/1gNzdKSfHXjASXaeXEteAWqOOFjRzNyDZr+9gLzrRtZ1AYty5vAcEPcBwRhs9emFQ==
X-Received: by 2002:a17:902:ced0:b0:205:937f:3ae3 with SMTP id d9443c01a7336-2076e3ea569mr391568935ad.44.1726744929503;
        Thu, 19 Sep 2024 04:22:09 -0700 (PDT)
Received: from localhost (117.196.142.34.bc.googleusercontent.com. [34.142.196.117])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-207946fb724sm78146305ad.200.2024.09.19.04.22.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2024 04:22:09 -0700 (PDT)
From: Rohit Agarwal <rohiagar@chromium.org>
To: chunkuang.hu@kernel.org,
	krzk+dt@kernel.org,
	ck.hu@mediatek.com,
	robh@kernel.org
Cc: linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Rohit Agarwal <rohiagar@chromium.org>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v2 2/2] dt-bindings: display: mediatek: dpi: Add power domain for MT8195 DP_INTF
Date: Thu, 19 Sep 2024 11:21:52 +0000
Message-ID: <20240919112152.2829765-3-rohiagar@chromium.org>
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
In-Reply-To: <20240919112152.2829765-1-rohiagar@chromium.org>
References: <20240919112152.2829765-1-rohiagar@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add power domain binding for MT8195 DP_INTF that resolves the following
error and many more similar ones:

arch/arm64/boot/dts/mediatek/mt8195-cherry-dojo-r1.dtb: dp-intf@1c113000:
power-domains: False schema does not allow [[55, 18]]

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202409102119.AYvaTjUi-lkp@intel.com/
Fixes: 5474d49b2f79 ("dt-bindings: display: mediatek: dpi: Add power domains")
Signed-off-by: Rohit Agarwal <rohiagar@chromium.org>
---
 .../devicetree/bindings/display/mediatek/mediatek,dpi.yaml       | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
index 1e748ee23fc7..201f1696854f 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
@@ -90,6 +90,7 @@ allOf:
                 - mediatek,mt8173-dpi
                 - mediatek,mt8183-dpi
                 - mediatek,mt8186-dpi
+                - mediatek,mt8195-dp-intf
     then:
       properties:
         power-domains: false
-- 


