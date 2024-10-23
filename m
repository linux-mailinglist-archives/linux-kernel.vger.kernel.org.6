Return-Path: <linux-kernel+bounces-378719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98BF59AD458
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 20:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C73AB1C21DE7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 18:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F36C1D1F50;
	Wed, 23 Oct 2024 18:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FdKBkgrP"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E1A1D14E4;
	Wed, 23 Oct 2024 18:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729709933; cv=none; b=dByvHI3BDf9CnIqEGFfON9aKQdSCPfsssBTERP2hVPh3N1hjx2JgiTW7eKkOxW6IyJQxg2BtGtdZkkWTma4o0jCezdTZ8AFA+5mLBjWkKZkRUYeoMWY9YWQIglZAzhf2S2wFJe8ndv24hKl9CAw3G9sABIs9WJQXPNCtZIIm9xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729709933; c=relaxed/simple;
	bh=63W5Ky+pMOBBnhK2c1KQgIZjKxCECrOTMw1zvS/YZEE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A7AvZamN3K1vN2wihvWWVw+hWEIGrCXS97BPpNQuT7DT8lvsduyhrde6tnRb8lq+rU9szEop/IPFZI7VVAVjZ5y697xj+zR1REK3/0gX9zVXirbIdH/YijM1GB28oDVN/LpGRYs+mE9gc6/Mc8atD2r99BbSJjtMERfCeQgSubo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FdKBkgrP; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20c805a0753so747305ad.0;
        Wed, 23 Oct 2024 11:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729709931; x=1730314731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bETUmi3XIXD8kJXknLOuOgQdcHp3kntpbqzcQWybJyo=;
        b=FdKBkgrP46uniLiPbhDVS4k95RK/wyp7VNJ5FygKDvYTm1NpaSWy69HBxIrv2K8Ias
         tXhkIM0r4/zT2jJEtDabiMfqQvxTvTBMcMQFWsbrpXEI4VPlW3klzcslPUreEp1co/mv
         9HDzTTWFnL2snom825thNvNzXcsL0ifBg6w7LifnW+L/9cvSfrrkOdOfnxe3dHKL/DWH
         eIlxx0zwsmwJEJ518KhTVo6ninaAB/RGLPqJ5cdRq244RlWyfn1a+wviWpEtIgsLllld
         nUMLsH+znh4eDOzhpTHKDKX4purq/0ZkR18z+Fvg042tmiu2WO8bJdIKxI2UZuGglojh
         aipQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729709931; x=1730314731;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bETUmi3XIXD8kJXknLOuOgQdcHp3kntpbqzcQWybJyo=;
        b=GRF8ZgbmChW0UFJPF5eKgZ0OL5sc/z+8Rs2yINHuYXroClRnoidVwBXxUaWZfphnsa
         kzjJdMkNfqGBP1+N9haHp61FJA60jazdsjNWmhTxfI0+kLPG21CxDF5qivV5Z87TZSuW
         C4+/ZDv3TiHjvED+EtUKRurDDsiKCSaOkP/+ga4UJy/xNDUsvPG3o6LvlQvF8oJ/sSCw
         MA4cANHPDNQmPMr/Sxez7/bmGbMRyHSMuvWhEYk7gHnZ2SO+t2GQZqbCNXwop62Ty6y0
         C/4Bzn3QbEJiAoPMCtG1Orqw/aMqvYYhXNBFYfSzSKomv0maurOmEo8GCP77NpJ5g0QI
         Gbpg==
X-Forwarded-Encrypted: i=1; AJvYcCUsphNlnlWmrYuWfb9Kqv5urOfEn2zu9E2ETwsAG2PdVQw4hXR1LONhQOlYpJ06uuPLPmthiqOhiFhF@vger.kernel.org, AJvYcCV98nxs8ckwbf/sEgMuyXdj2RGcYjBJAH+S7XH5YYEEkQOYjuUKT44z6BFgLnfiDWhXYOASzexTxQ7JHdko@vger.kernel.org
X-Gm-Message-State: AOJu0YwDM9bC/Mxy3bFjIQHBi83bGWkRg7s1faBaRlVX4kgDtjG/BCsW
	blT51uoHCC+8LTLzGGZNZ/i5MIdtt3IapoARrBMbPiyU/ap7lggl
X-Google-Smtp-Source: AGHT+IEiMM+L5uFTC2VVfCZ7I44sSELbZMIx+Zoda6jHBhFMKFwgs8wwCZULrOSJN8mgnxIegVhiIQ==
X-Received: by 2002:a17:902:d482:b0:20c:8df8:5066 with SMTP id d9443c01a7336-20fa9ea096cmr44157185ad.45.1729709931402;
        Wed, 23 Oct 2024 11:58:51 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:248:317f:2ba9:e66c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0f6ee4sm60619955ad.295.2024.10.23.11.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 11:58:50 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: tglx@linutronix.de
Cc: daniel.lezcano@linaro.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Fabio Estevam <festevam@denx.de>
Subject: [PATCH 1/2] dt-bindings: timer: fsl,imxgpt: Fix the fsl,imx7d-gpt fallback
Date: Wed, 23 Oct 2024 15:58:40 -0300
Message-Id: <20241023185841.1183706-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fabio Estevam <festevam@denx.de>

imx7s.dtsi correctly describes the GPT node as:

compatible = "fsl,imx7d-gpt", "fsl,imx6dl-gpt";

Document the fallback compatible to be "fsl,imx6dl-gpt" in the bindings.

This fixes the following dt-schema warnings:

timer@302f0000: compatible: 'oneOf' conditional failed, one must be fixed:
	['fsl,imx7d-gpt', 'fsl,imx6dl-gpt'] is too long
	'fsl,imx1-gpt' was expected
	'fsl,imx21-gpt' was expected
	'fsl,imx27-gpt' was expected
	'fsl,imx31-gpt' was expected
	'fsl,imx7d-gpt' is not one of ['fsl,imx25-gpt', 'fsl,imx50-gpt', 'fsl,imx51-gpt', 'fsl,imx53-gpt', 'fsl,imx6q-gpt']
	'fsl,imx6dl-gpt' was expected
	'fsl,imx7d-gpt' is not one of ['fsl,imx6sl-gpt', 'fsl,imx6sx-gpt', 'fsl,imx8mp-gpt', 'fsl,imxrt1050-gpt', 'fsl,imxrt1170-gpt']
	'fsl,imx6sx-gpt' was expected

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml b/Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml
index e2607377cbae..a2fcb1e8e74e 100644
--- a/Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml
+++ b/Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml
@@ -31,6 +31,7 @@ properties:
           - enum:
               - fsl,imx6sl-gpt
               - fsl,imx6sx-gpt
+              - fsl,imx7d-gpt
               - fsl,imx8mp-gpt
               - fsl,imxrt1050-gpt
               - fsl,imxrt1170-gpt
@@ -38,7 +39,6 @@ properties:
       - items:
           - enum:
               - fsl,imx6ul-gpt
-              - fsl,imx7d-gpt
           - const: fsl,imx6sx-gpt
 
   reg:
-- 
2.34.1


