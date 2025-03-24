Return-Path: <linux-kernel+bounces-574025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E6BA6DFB3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 17:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0E1E7A52D6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 16:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81E22641EF;
	Mon, 24 Mar 2025 16:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SuUnffST"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B10263F52;
	Mon, 24 Mar 2025 16:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742833816; cv=none; b=CPbawiXMIIrdA0foim6dZNL7Opa3qLZQr+u7lk2c2m2VEFTUvz24wA6GRZWwexO83qtteQlNSn8pahbZV1hO/FziWSo+jGIsKEyjYs9/YSaWMakQm9rMSsbmH7DS1WfXosMdKr+KWLbxMUBLhQjYkZWAq71/Iw0V9pZRqdRaEAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742833816; c=relaxed/simple;
	bh=jtozxlDlFArb33Vwn4r3NVMWeWlV1gMBeUBT/QzmsQA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GVzdfN5MKnr4s6CboK7sUrd5OoYD/jVc7cQX9P8vAptUmFyR4TmMMwrcRkFYFik8O9YqtVGA05QOtNDjvoSgrNg10BxhkOCHSwtvoEbofm6DFfckB3hK5xSKfilMn54aUilJjlyeN5XAO/ROZ7Trng4625jrY4sLc314/IbTkUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SuUnffST; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43cf05f0c3eso29977185e9.0;
        Mon, 24 Mar 2025 09:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742833813; x=1743438613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gu5G8CnhO94dSAWaShWe9FJyZsw97QYskm73IppyfbE=;
        b=SuUnffSTFWZrAckz/+zJYzCQyRpO5LILoXCvUkrKVAcMLwIOJ6/FoyHwz7fT/XTEMW
         GCWIyEBHFLqaCxFPJ8Oa5q2usXVTnq5H0DPHqD462ieLH4H3EzIuFAGFWL9k9edkKaCf
         wRsIBRWM67DJXYYT4QnAWuSkpJifCmKAEMbmh9vjxZ5NGzxWr6O1seQzs+uGX+vUMy+v
         oZdo8DWKuTe77TxCwap85/RpLQjf8e8s4wfbyJ2keX5xrKguBSGtb1+YQfxYnXeMS7P0
         cRgNfEJb1K3Yl5e29aVZQOem/xtTdHMKg52RUeFe2NwHymWnAJpI990MRtrgZWfz7VSs
         yTkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742833813; x=1743438613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gu5G8CnhO94dSAWaShWe9FJyZsw97QYskm73IppyfbE=;
        b=tdTY+t7+vSo6SA28+wVZGyr8WYaCt4GeiECkdFWmXORnGkgoOD4CKOa3+k68E4liPS
         XRmtJOBWrUP1XeHekq6CJl6r1DVTu7qPwj4RoVjPhMWZLCWhvqLJjGdYUzGbuZKPOvZW
         gxFUsG7IDGgb6qwVh75NoJgCdbVj6Y+cd46HBm8yNxqoHUojgFC+DgfCc9GU6btJ8eRE
         OTT0GL1+9116rbSSdn8CpnevSX8d8PnllEXiJyOc89odetA/EhRAR11eTeTs9i1unlgr
         O7Qj8WsG2wkPCEnfHO+EVnGteJ4obETjVPq4VgUMphwAqDh7hTY+Nlk44UFP5def4ue5
         ZTlA==
X-Forwarded-Encrypted: i=1; AJvYcCVsZIQuanXiTg1MCjWD7cI/RVhkE7Z7tuUEqHBtjzwIE4kmikZHnuhgMh+YHlbidcFJlckTUc4KqvEC@vger.kernel.org, AJvYcCXXgSklRCvULqZAA++41nTRjLnUibgzcgVkR2f3NwzAd6SEBFFdcy3Y5wYQuB/6ylEAVbdW5CENuxnpJ3Bd@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo54G/oqQPmijNcnETbIAUwoIvp+mp/63hVe6IFS/OrNS2mwLm
	vZzVkMUfgeXOyyrhREwLQXOKja1eggBkkotu3jiu2k8cUTPX0bPwd7zWDVlG
X-Gm-Gg: ASbGncs0vhRnGaJldWHYXRG4LfcfxAX4CIn+mn6YsIiy9034DGx88DbR3mL63uESKHc
	NF33chv3as6+Id5t+Rc8qlLepueyo/SH5+SxAnODTve6YUS7qCa/P+Ju+Y5sIZC2qoGJpJWcqSP
	nKuSr+qVelx9lUmJVpefFoEYL6lM8J73Ws2sgz3FuxbSQoj7cDe2BwioCq4vOsLvJjko/9Fslyk
	7rMempwHzhLa5XSNvjVpyktKl4S9mq4+rRNS2e4V3wOZZXDHzXHBsUl1OtEYNNfLeYeDqb3QRIK
	r44YWt59K4wDqTCEYVL+p+7FqeUFZhUJqJdSCaaxGcDoSXaGnfPI/KYdcxtuvpq0rmYHqNA8I6t
	UZ+vvpSA=
X-Google-Smtp-Source: AGHT+IGu6fTgDwofVoKRjp4DA1DLbpppRHEZaZIgwdT9HARin3pVTWNzJxo96bidLrG+Ulb5IFSLDw==
X-Received: by 2002:a05:600c:3b9c:b0:439:86fb:7340 with SMTP id 5b1f17b1804b1-43d50a4ca6bmr119432205e9.30.1742833812679;
        Mon, 24 Mar 2025 09:30:12 -0700 (PDT)
Received: from playground.localdomain ([82.79.237.110])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4fdb0669sm124106765e9.34.2025.03.24.09.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 09:30:12 -0700 (PDT)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Frank Li <Frank.li@nxp.com>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/5] dt-bindings: dsp: fsl,dsp: document 'access-controllers' property
Date: Mon, 24 Mar 2025 12:25:53 -0400
Message-Id: <20250324162556.30972-3-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250324162556.30972-1-laurentiumihalcea111@gmail.com>
References: <20250324162556.30972-1-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

Some DSP instances may have their access to certain peripherals
conditioned by a bus access controller such as the one from the
AIPSTZ bridge.

Add the optional 'access-controllers' property, which may be used
in such cases.

Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/dsp/fsl,dsp.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml b/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
index b8693e4b4b0d..e610b7636a08 100644
--- a/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
+++ b/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
@@ -91,6 +91,9 @@ properties:
       - const: runstall
       - const: softreset
 
+  access-controllers:
+    maxItems: 1
+
 required:
   - compatible
   - reg
-- 
2.34.1


