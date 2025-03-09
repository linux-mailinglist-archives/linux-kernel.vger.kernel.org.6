Return-Path: <linux-kernel+bounces-553174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC1BDA58526
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 15:58:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F7C016B90F
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 14:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB9B1EF36D;
	Sun,  9 Mar 2025 14:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t1vgn5ye"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90251E8359
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 14:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741532262; cv=none; b=CLlfmgk1k0kCScAUav4et57JFM7JwcNZd5DAy/Q6/GjzIQ5iyOhR+Y/hu4YspMx780A/NN7ns0DZOkRhrL+3V6uqY1vQtPT/ppYGR19yU+Gxyx7SSwhUHTNCk4HDy36V56/lWZs/Z44iH2w1gZS/iqgexL/ykpKKn+DGiHBIHGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741532262; c=relaxed/simple;
	bh=R0iwPCFv2TxOgUfGPaJWLwsVCF8ZMsJL2tVBboocnFw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s+3z2j5YNMhBGn8Z66M40kyk8RRgO2JP5vLNVMTc4QPOkpitPnbbQQXJMp/zjZQGgGE8tTIliHaTMJQvP0TYPE4fzlcGZgWTiyfpzcLLhTSLjBQ2VJonEjLTuhDw62UUZkN62xk2+k8OiVYwup7EYGaVIs4cT8iC10OzRwB4WIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=t1vgn5ye; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43bdf0cbb6bso18812195e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Mar 2025 07:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741532259; x=1742137059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kRtX0Tco56vW4mGmeM52+vQurVKi/ujaJalKa4Y92rc=;
        b=t1vgn5yelFzp+yL1pkLUfMOn2ReYSKPLM+cOlm9aAQ07g0oUloWsNsQmfkk86Qhq6R
         qVdK2OLseHBch+u5NLIdJX2F/8TLKPtMd5oSE0qRtH1DufmRLUqGjTkddud4qinI65ct
         c7F0m3WtJk8lkEzfdo6Qi5Gat5KHrPdRKzjTvIpVugggtK6LC/WvHjuNHLf8OPIzqYxh
         oi47mjBiy7AKf/VKPhwmhLhmsWDMK5are6uUB8v4Ra2CbiVe6thAqAkGa35n1OgNySba
         54GrAPLRfpVDTsxgK0luYPbZ9vSa2CqyAq5wo1RAa/4PuOixQMArulxcGvwWRUcHiUos
         fMKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741532259; x=1742137059;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kRtX0Tco56vW4mGmeM52+vQurVKi/ujaJalKa4Y92rc=;
        b=I/VbMv2QdHDXxJpfbCxSpTOEF1INSMIeuuu5NP4MPcD6Ra3pU6TfXQwg4hQMM/qxkX
         XWhJDOvIWZ7cbs3a6uBgu4EI/LJ3e68dA1WMvS28rLr72f3iq738O2OMJl3DUAHgv7Vi
         Gt8ZIiBZ14gRehXlLaR4sQ/ATs7fVGP+xjhJLo66P7pCEzESUYJxI4Hx1jx6WoPMmkXA
         VBB61UYGnpaUR75Jv78XxKdxtcuz2eAnEYlBQ8OBchfs8Sh4n4h38RlJmCPFukmhOxHM
         1Kgu8RZSQ3xC1fD9netuBxbjme+0qcqTe1YZHjrM7KHw50J7nabTFyR22MDzLAYyCKdj
         zR8A==
X-Gm-Message-State: AOJu0Yx67X4UoaTGar2Bv6O8QqSjlHubliW+YOk7XH7EyozBPeC0QmMl
	cl6sdOTqkg2svsBcIRv/iHBPc3SzOZC/OanaXGnc8hIQ0E6wmsb/XNE4PhhpQVg=
X-Gm-Gg: ASbGncvhEdQMjAut66otuZ8WLZH4DL/FDsioYSL3RLwo94IrYYkqAq2ORit9htK5Q+2
	LugKtCYhYX+PwtalheQoCpKrC4tWbiHhrFoWPYBl4fErz0OLOXcWJPEC3l94fwu/B1xrrKbI4T9
	O7dUv4WXadpxVkJb3j4laYS4LPrrSdLOCP8PY33Lts83ZdLHELvOtCSg3B6khXgZlnZYD/2ILwl
	HyDRYsn0lh/BZbJI0Sp+tIuKAjo6aMr456OpOhztFG/Gcq6pOSQddPoz1dZSRp0SOInlMPrPGWX
	z2wfk1D2nJU/VJea0bZiL9dB/kz99hLyTR88VKbletOYA0aTbUzsTbCjQH3LxxDJ66ST+g==
X-Google-Smtp-Source: AGHT+IFmmE0V5dvhq/0layd7G6bOGHRQ+xNXjgkLEWFBV+SUvDgwI/182TCyh+F3PK0c9omjbUnbYQ==
X-Received: by 2002:a05:6000:1789:b0:391:1f9:c59a with SMTP id ffacd0b85a97d-39132dd94dcmr6827317f8f.46.1741532259126;
        Sun, 09 Mar 2025 07:57:39 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c1031fdsm11744899f8f.89.2025.03.09.07.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 07:57:37 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 07/13] dt-bindings: nvmem: fixed-cell: increase bits start value to 31
Date: Sun,  9 Mar 2025 14:56:57 +0000
Message-Id: <20250309145703.12974-8-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250309145703.12974-1-srinivas.kandagatla@linaro.org>
References: <20250309145703.12974-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1121; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=vvMLJHbQfUn7pa1OVJZqJEDv122+kRbgZS1YYVxpPyU=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBnzaw5sbTHVoHKZK3CWDl2/UfwjN0TVxhNXstCm pNyqWWbYtaJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZ82sOQAKCRB6of1ZxzRV N+qsB/0YeLY/fO8iKie+oWktyZbFQHeET4oXtdgLa50z39CvKjdGsBsq75wSwAu/PHJ2fkm85fl l2SlufOOCZc7E1CoA3F/a7QJp+bp709xw4ZgptsAYREfLkDYQkaxfbWL65sVcM0FxIiLAMA4sLp 7AWuSuAOZFsrSpQsjqWkiaUtSBH4GbxH75tSXZ7x8hITygY/2O1+Pi8agqaQZiRINZLP1uZZU3R pO1KHAuBYYBKaU2y7sfnKSRisGVRzZUo+mbN6D1wJbtFgSExQuI8IHMe7EPf2h1Kw+u0l3GYraf 77zDG668KpyQPljS3d4M94de+OaTrwWs7KomZRFRa0hG2v5z
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

If NVMEM uses a data stride bigger than a byte, the starting bit of the
cell might be bigger than a byte (e.g. if the data comes in the second
byte of the 4-byte word). Allow the staring bit to be 8 or greater to
reflect such usecases.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 Documentation/devicetree/bindings/nvmem/layouts/fixed-cell.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/nvmem/layouts/fixed-cell.yaml b/Documentation/devicetree/bindings/nvmem/layouts/fixed-cell.yaml
index 8b3826243ddd..38e3ad50ff4f 100644
--- a/Documentation/devicetree/bindings/nvmem/layouts/fixed-cell.yaml
+++ b/Documentation/devicetree/bindings/nvmem/layouts/fixed-cell.yaml
@@ -27,7 +27,7 @@ properties:
     $ref: /schemas/types.yaml#/definitions/uint32-array
     items:
       - minimum: 0
-        maximum: 7
+        maximum: 31
         description:
           Offset in bit within the address range specified by reg.
       - minimum: 1
-- 
2.25.1


