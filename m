Return-Path: <linux-kernel+bounces-311514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1209689FB
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 16:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2FDB1F24CAE
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 14:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A301A2633;
	Mon,  2 Sep 2024 14:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yWBPzsZQ"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4613DABF3
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 14:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725287415; cv=none; b=pmNFE+Ej2LZYPqew3sfN2em3a4uH5WC78v9bqF4Bigyzb2aGlXK8iznySdiIp55UFVhrURfQ1cc58ocMXCNnL8XgjjE5C6KWf+2f+belggUgFyZt0q2+slicBl5qF7MyFC8YHh6qcSFMdwtBXY0tNi8Gc8Y4MGHkdC0qsSg0JGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725287415; c=relaxed/simple;
	bh=emb8q+6gXOjS5iw1fauZynFmoiaNEeiD27qwYCDSSw0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=guwVA5YqpucvGYJ1QkgjA7XvYzxZ0gF5rJBt6WjOZ0aC3Y1N/FnLpixDT7ywguJZYUXA5VTFoJeJB+gtKsVxMxSpaMLJIN5QHN/MW0J/AjlNLEyjdCbi4a290PzgK4NQmkZxFsl8wPYbDis66hmm+WEuv3rMfaDMemR6wmWP5yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yWBPzsZQ; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5a10835487fso5701612a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 07:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725287412; x=1725892212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HyyqGwMkWW7u8Lss1KA1H5146wVoNDESuuT5hwniUaA=;
        b=yWBPzsZQfVlxM3SJJe4lle5xYPo960zezBBv/TaIGbCwY9ahNbFvhsdHYCJXBqt9gW
         +mGVC8pXoMDMtlNUrJ6Py7QfbOwT6se/8EdJyRIc1Uj/HwxWrIp7ZdtLCMdRWmzN2wyU
         bCNnJVhEs0LMaKjN+YADkz4hBs1ABYb3sKrptSuHVT5CfkAbvjrfAt91E3qj3og7rFln
         L8PDAIbiuCLDnVvN4jFXPOh9OjPCtvftc0AUEAmjwmVrYB35HWsH1eeaLGZGn0o4zAz2
         XxG37rmC0+dYnFWjygEjrwX8ofZ6gb4M69EUXKjNV1019flVHg/nxE2YJu+ga+KPsaG2
         H+rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725287412; x=1725892212;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HyyqGwMkWW7u8Lss1KA1H5146wVoNDESuuT5hwniUaA=;
        b=ND4ndnEDoUqeHwY6iL+VqmuWop4J6KL0QoGqghwjs7mB8cGM4q0AsJzGaOw0KUno+J
         4W31wyU5nT5SD78OHYKo7u4mbAf/kSRTkn2xhchn3Cez4iDHi60bW0GvsPI1qaX0ZDCM
         NzIbC/VCK27FP0yxdHaRn0mI+3TsBIfDA37C2hDlsf0hOi1GATYxWDNrjsYHyDKyrZsn
         GPMsADWtwGtE9FJpWd4r0oY55semIT9bokAAaKLc+cjz7OOC6ThS8PdF1sewIYYikF9Y
         CPk03owJCv1k/PP1ktcTW/g0LgvqHQYoqILoBOHMcJduZLUYwGIQUDEQu+Ktfv4tWwYh
         49qg==
X-Gm-Message-State: AOJu0YzDOcNI07JoTca0qLZS6pdugDhigH6OqhboJ+Ux77IyqUasRSy3
	JEwhKfhHT3OoSlGtlNUQxxyxFgYTyQUQiJ1w6x5dazAsfGs3zWo2H7QHyDgOZ38l7K0hwIlG4Su
	g
X-Google-Smtp-Source: AGHT+IEkO45kYfW9M3CJguwqWlICZW/1nRjI2MvjpTaeKTuEJqU9eEWgG7DgCb41YlRBWOV1s6oAEw==
X-Received: by 2002:a17:907:9490:b0:a72:40b4:c845 with SMTP id a640c23a62f3a-a8a1d4c36b9mr25861866b.51.1725287412389;
        Mon, 02 Sep 2024 07:30:12 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891d80fcsm566011666b.181.2024.09.02.07.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 07:30:11 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Frank Li <Frank.Li@nxp.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 9/9] dt-bindings: nvmem: sfp: add ref to nvmem-deprecated-cells.yaml
Date: Mon,  2 Sep 2024 15:29:52 +0100
Message-Id: <20240902142952.71639-10-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240902142952.71639-1-srinivas.kandagatla@linaro.org>
References: <20240902142952.71639-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frank Li <Frank.Li@nxp.com>

Add ref nvmem-deprecated-cells.yaml to support old style binding.

Fix below CHECK_DTBS warning.
efuse@1e80000: Unevaluated properties are not allowed ('unique-id@1c' was unexpected)

Signed-off-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml b/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml
index 70fb2ad25103..1b20b49eee79 100644
--- a/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml
+++ b/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml
@@ -15,6 +15,7 @@ description: |
 
 allOf:
   - $ref: nvmem.yaml#
+  - $ref: nvmem-deprecated-cells.yaml
 
 properties:
   compatible:
-- 
2.25.1


