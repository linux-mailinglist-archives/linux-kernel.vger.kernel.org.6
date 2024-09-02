Return-Path: <linux-kernel+bounces-311498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D050A9689DD
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 16:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F16D282C98
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 14:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD8B2139C6;
	Mon,  2 Sep 2024 14:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FwIwJKhB"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5707521018F
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 14:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725287121; cv=none; b=ZopLxbFOzd2uLZpchFeW+Y0/NfhMtJRof0Su9gU2KjIvtuWTWnJRkOr6+tROmxTR5ps7Fxl6l6VP3GEYcPom6hWZimipHkih0DDEMIl2iO8uvNzhZgMIOYTAblPXVpE8erVuy/CJitOhTpmQMD/ckBbrB1qvlqudF1pDHdGwBaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725287121; c=relaxed/simple;
	bh=AzaAfthTj3oPuZJHTCZMkNORw1JDAjyfcLr2xsQ3dfo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KRtC34EvSgiiwNNhGUw+keutPzlNeoNVSi8wX0fa+cbGGuq0jzPiRBYnlELAGRCzSlARvOtWuGTEwvQcxKEZzjhv4qbix2YQ51++xVWSbUJTevbvY1WSFZeSmrVlP4vuSXPP6TkVN7IKtklI2dBWFOtkC6Ivakc1XokXUZ+zg0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FwIwJKhB; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2f50966c478so44447011fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 07:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725287117; x=1725891917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xEqPUZhtdX5/8LGHAXcAYGkDFqga90sc5TMoJh0yC4g=;
        b=FwIwJKhBwOBMBPaV9UReb4nAlOsbka8k1QhClqHC2P/+QgJjNjP5w+4GvTCUemJEJs
         Gy9WCuOxxuP/44ilKlj2Wg4qLJPcT+SM3xjno9XBAPDw+AFjIX5nFdLXc2diSbiHDUgd
         NzLfdqJUGm+d1ZoO82v8YiTrtNYzTsZd5vSJYLlcexZF5e4cdOjYIVSXiQJrQFB2FvNF
         QCudYsSaBSELw1zXmuU1J4IK23UvJNQpedUMet+itPhm9JVDB7BM39MxCfcNOP+V9q5t
         At6KVG7wF4R0NwM28NtHGUlUjXFU/0fz0/emKcepU7OHjQFcFd5WGlK74YEmTWV2gR3Y
         gEIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725287117; x=1725891917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xEqPUZhtdX5/8LGHAXcAYGkDFqga90sc5TMoJh0yC4g=;
        b=iJtjFgMuyW+V2HqzG0WMbKoZDPX8Se2BHi/Qmj1kYcdzpvhAOO16SjqbncxeYJl5ie
         WpB+SByCkrYLJRrkyPuWrtxhVWjTvFmisJiem41FUeTqv9TyuJxGPZEJTGctYGKJkozE
         xiA6IB4K42dGXCcqv+9BvjYDfkNQE/ykqZEG+36lmAvRfy3NFZ9j0m3dIMg5Ly+5xe3i
         cRaBpvUtQiyzJEzheVlg0atHRiuHOFPO3SnD+RROv5sZClZYhRqp4xypwU0JE9FfLJly
         +H6X1bGmv6XCi+Jc8phxuRBcAMfL0K/tHkUAZKtDmiuqtTCNj85trjOwK3mZjiC5z+lI
         zuBg==
X-Gm-Message-State: AOJu0YyR72rGWLxyZO9Qtr2gegPiR9QZgI1Wgv2ocxbBnDGClkLlX8TT
	j+njhUBnaBB9/qU82toPxq+vZcMjKbLmcxdJcUXdE6tmT9/Ms9gYWNkVIw/JFV0=
X-Google-Smtp-Source: AGHT+IFBGhEqhORTU317F+vkMZ0dALKzW3x2CANLv5SAF2qvMyeWJDu5gm48GADl4hd+GdGPAVTvIA==
X-Received: by 2002:a05:651c:550:b0:2f5:11f6:1b24 with SMTP id 38308e7fff4ca-2f61e0562admr77454241fa.18.1725287117300;
        Mon, 02 Sep 2024 07:25:17 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c226c6a3f5sm5308881a12.2.2024.09.02.07.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 07:25:16 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Michal Simek <michal.simek@amd.com>,
	Rob Herring <robh@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 3/3] dt-bindings: nvmem: Use soc-nvmem node name instead of nvmem
Date: Mon,  2 Sep 2024 15:25:10 +0100
Message-Id: <20240902142510.71096-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240902142510.71096-1-srinivas.kandagatla@linaro.org>
References: <20240902142510.71096-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michal Simek <michal.simek@amd.com>

Based on commit d8764d347bd7 ("dt-bindings: firmware: xilinx: Describe
soc-nvmem subnode") soc-nvmem should be used instead of simple nvmem that's
why also update example to have it described correctly everywhere.

Fixes: c7f99cd8fb6b ("dt-bindings: nvmem: Convert xlnx,zynqmp-nvmem.txt to yaml")
Signed-off-by: Michal Simek <michal.simek@amd.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.yaml b/Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.yaml
index 917c40d5c382..1cbe44ab23b1 100644
--- a/Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.yaml
+++ b/Documentation/devicetree/bindings/nvmem/xlnx,zynqmp-nvmem.yaml
@@ -28,7 +28,7 @@ unevaluatedProperties: false
 
 examples:
   - |
-    nvmem {
+    soc-nvmem {
         compatible = "xlnx,zynqmp-nvmem-fw";
         nvmem-layout {
             compatible = "fixed-layout";
-- 
2.25.1


