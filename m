Return-Path: <linux-kernel+bounces-411742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F139CFF11
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 14:13:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A98C9B28847
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 13:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D59F1C07D4;
	Sat, 16 Nov 2024 13:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TAG7/nQr"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC2B1BD4E1;
	Sat, 16 Nov 2024 13:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731762644; cv=none; b=cZPIhfL+33p8+fYJQrc5Y9Eq3WaHzU9YTnFs+2CpqYMc4uSZiUctqWPhGh1/bKdL/FmSEhSmma/OBnqRROVdceRLAXNxooTwd6NwrUKHwHmeQRPS+Jqdizw3RwhctRdOjhumDvQD1pIJ0u6zFf0yiply+dn5g5fnnLX57z+9CaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731762644; c=relaxed/simple;
	bh=MsyYsIsG1dthibRPjDDuu6F6WG0T74JA0NUdhhPUFfs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lKmBx5kxapZxq3MzaEVg/1GB5AwTXEhghnwj6WkCTZupmE6Iv+x2VQc64b5MDX7q+KKAjohl7jDT0d13Eo79ab8PtR1pESA5U6/MSROjNj3tMi7bfxk0S4HFSYn1QEcAM1k/0sYTQDIfKGVJtAeOx+xZkLwYlU6NbNq2eyUymSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TAG7/nQr; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4314c006fa4so2755415e9.0;
        Sat, 16 Nov 2024 05:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731762641; x=1732367441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OaWVlv0xuu0KWoOzHnE18Qt9ZYrFlDq7yJPtkCywBZs=;
        b=TAG7/nQrSb45E571qZyK8lm9UXFSSuiJPBWqagcOR+2sLarZDKU25F4F+PxZZeImWd
         Ffrr+i8gQPxODJnHUjj7gBezM4Zn7d05mJt9p7SCbQZZbAO0Zo4R7w05sjYuvWsfSgcN
         kg/XePsxf2fFpZ7ylv7awFFVlbUpxwzv8/bNQ66Ca+yQ4lndkftJIDC+7z90n0QW1lmD
         gfc5Dq8VgMBhChmjMqvgaL/mEuNmlMIf+3Di1LxG8S2pOzt/2GWNjxSD8Qm2Ja8jW+52
         gZVWKXRewJFQNGWExEOkmUhcM/J770DFCVgRGQK4bh5tD3CoBwmHz85/l+DPp0cGIf1b
         DEvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731762641; x=1732367441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OaWVlv0xuu0KWoOzHnE18Qt9ZYrFlDq7yJPtkCywBZs=;
        b=IsgLQC++EvD4rpl+BRug8yvH/mRKizOEfEcNLXaGXeIGoiHn7GaDtobRijY3HMwkKF
         P5W28u56mpz78yE/kJEnhNMOUKOKQpFaF+znneeCW/s+RIgBHnlpkCFKNpZQfHbloVZu
         YEN2xDb1iTeu0YAnIFScwePDz1vdJaApOJhIpFnnhRwG6wVH1KC9v3y8VVisWO+knTsA
         zRccvhYErwO5FJU3AM2xsehsMdlVhFlZRmNPmuZG3dTdO9VjWd7zOSOybaD3Lq9mcovp
         Gx7Qc3BdBAWIqYClk6KZM0+zZ9LDFBrxBAhQNvZXNSMuIOFT5Bnevv1FNkbgQqvMYWMP
         Rdng==
X-Forwarded-Encrypted: i=1; AJvYcCV2U/YoEZLFWTfOpPock6pUUE0FvI4x7svyM7v0ZDRsgYErrEeIvWq614ZFWTB8t3H8dgD29fUc19N/XlWq@vger.kernel.org, AJvYcCWoxAOGLTE5nNek+vTnhGk/VkfxDd4PsVCexPtjpUZnVNfanxKpIf4aG+owWK4yFyZcTALMHrZUCrul@vger.kernel.org
X-Gm-Message-State: AOJu0YzWeU4lHqRtXWlGX/bpcdDlAHJZ0k3gs6a+wh8HR6tpHAfXMzpf
	IHP5wWUt+O2ClkAvW9Rg2hrzL4Sy0jyl+yyGumvn54iJb75i7XKx
X-Gm-Gg: ASbGnctvdq6rQ0/riZtaRuGjUMmekHJktWs6YKVjJVm2TSj5sKWXgJCnq2qiuCich81
	YOxwWmL08QYE0JmlUVPO5kGDl470cCfCgaDOMP152wi8/fPr9ypEWKrG8VL4GzK5unIJeEiXDEE
	l872eGPWs9cwHLum8k9T4BZ2iN8940pYIO18nnsS48AHbRYZ/srX074XK4zySWUiUX4imUYvTpS
	GqKgi/ACb9J51VoE1tpjYrQ/uQCPZnHKYmZvhWzSDIedYj/sNnHsvv1JJnFH/KX4jIzhkp6fa5U
	LAD+qK+60aKrPm/5fUbw4buRotFD
X-Google-Smtp-Source: AGHT+IF7AopHnHI7knCA4h91IPjH/YuJVDrHDNIg2ZWL7CmT6W+xuwrmCVK0nScRMb3uGgLwEJcQhw==
X-Received: by 2002:a05:600c:3588:b0:42c:ba61:d20b with SMTP id 5b1f17b1804b1-432df728caamr22537685e9.3.1731762640625;
        Sat, 16 Nov 2024 05:10:40 -0800 (PST)
Received: from 5dfbf0f66296.v.cablecom.net (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da28ba80sm92424375e9.29.2024.11.16.05.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2024 05:10:39 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dinguyen@kernel.org
Cc: marex@denx.de,
	s.trumtrar@pengutronix.de,
	l.rubusch@gmail.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 10/11] dt-bindings: altera: removal of generic PE1 dts
Date: Sat, 16 Nov 2024 13:10:24 +0000
Message-Id: <20241116131025.114542-11-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241116131025.114542-1-l.rubusch@gmail.com>
References: <20241116131025.114542-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the binding for the generic Mercury+ AA1 on PE1 carrier board.

The removed Mercury+ AA1 on PE1 carrier board is just a particular
setup case, which is actually replaced by the set of generic Mercury+
AA1 combinations patch.

In other words a combination of a Mercury+ AA1 on a PE1 base board,
with boot mode SD card is already covered by the generic AA1
combinations. There is no further reason to keep this particular case
now in a redundantly. Thus the redundant DT setup is removed.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/altera.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/altera.yaml b/Documentation/devicetree/bindings/arm/altera.yaml
index 51f10ff8e..1561f0164 100644
--- a/Documentation/devicetree/bindings/arm/altera.yaml
+++ b/Documentation/devicetree/bindings/arm/altera.yaml
@@ -31,7 +31,6 @@ properties:
       - description: Mercury+ AA1 boards
         items:
           - enum:
-              - enclustra,mercury-pe1
               - enclustra,mercury-aa1-pe1
               - enclustra,mercury-aa1-pe3
               - enclustra,mercury-aa1-st1
-- 
2.39.2


