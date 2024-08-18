Return-Path: <linux-kernel+bounces-291150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3905B955DF6
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 19:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BF7F1C20AFC
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 17:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B4A14A4DB;
	Sun, 18 Aug 2024 17:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vtlpoyuj"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0544614EC5B
	for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 17:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724002134; cv=none; b=nrSSLhNEmpvUg4KbFYAfsXCc1zubeqZvm9j/NEO4MX090YdZusgpDvfKfXFtvzm+Na8oaIBLwavsuNL9Ok5JGLG/ffNonPpMW4Q2Udm38vqzqSBegJCQCyxJ4hgGoaiI9bgxB40wFzH0AWgi9IOqR3kJAKVCrpQDaXcblZs7lCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724002134; c=relaxed/simple;
	bh=ND2Ns7m2h9MafHRCr6JabpIRpQLxTmeDBLHdaLMYhgA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fJZSR61Nu1Zdxa0nABbpKAlKvFENJnyrfrZDjIv1Kxyfol0IbBJg9bOcWJxpqAnKhsToSgfI4A8IWNbFemUzjyYTN73gwYUFQXP+MPXq/+Wk4HlsrEzPglgvh5QDcqY1y3U4vJy8HeQk+WfsrhCiO6TdQw6EylGbuqgOmvJy6Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Vtlpoyuj; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3719398eafcso1627789f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 10:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724002130; x=1724606930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zSmdK3PMjq/K9tgLuhcYRFCmQqxZohO2iMaFOSnuyz4=;
        b=VtlpoyujK6WC6yJCwfI7q1WkyDdqO21JB7wrDdTGIq2mowG9D84gVLAf1WXj4t7wEQ
         gjHGrb9E4RmZsMxgFfWsq1GS8BvXtyEBpr374Id0OOxyF/1m/tKY+mMDAiuvuqwOMVS3
         M++onSVmxLxGbo87FO1IJLpQt4eMSZvJzj7YzyEGraHKlz4V1QsTkri8+7ltcrK/r+hA
         h+bqAZcKf4DkjXMkzmu7gff/vCVIuBjFvzdXS54/MpOpGSmjiPP52600rQx2c8EuGWY7
         xfuHi0INppIzApT1iDcQ4Psibm2D02q+nYiIiX+Ezv8ESBoxgiY5S/j/BBvsNbv2JgnY
         bA/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724002130; x=1724606930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zSmdK3PMjq/K9tgLuhcYRFCmQqxZohO2iMaFOSnuyz4=;
        b=Xxs+JvpcBairVFpQbf8mfiiEL4chR+9yg/43inJ9zbJqb35lqKRS8pZRVhO8rl3qsG
         AO5AX4En9wp/CJUmaCEIXli0K7/l8COvc6/0VMA5UmxwiTXTsHWCjuQcBlLZTB5TJk5C
         eayAXRmHsdxomRQDgl2Dw6c6ehHx4ka1wZU1pXNFpCT+z9XoJHMLkrZN4bf6uSJdGCF2
         SoeeZLTz1414C2O6xvixeLVMnJ88TPJwal7g3/qzxVi3xB1XaVQCvqO0FfNYgSZJR1uF
         dLypi0457ozhQc0WX/5K5IPG+Qk45CuBX5ITeAVSkCy0FcOOaU1QMg9od6AH7cE2STFQ
         vV9w==
X-Forwarded-Encrypted: i=1; AJvYcCWYBnO0DI/vau8k3TXlghg+vkPPrsI0eEpBfQkGXMb4N/5LSwtz9bM4BihzIYzYlsFjQnXmeX90w6/jIKqdZ9MNFkfPU8a0ZM5ye5iE
X-Gm-Message-State: AOJu0YyEQdQuiv6RkGG9c7MLiCfFV9UrajZCItL+NhRHPh0nky826GZW
	lqpPtEo6guOFmVGo7eMPwl2BLzxTf8OWxLxVx6QJi3UAYusyNqvGdmmgK7PqaWI=
X-Google-Smtp-Source: AGHT+IFFcTzuaWi1C9l4fEAiu30Dke3dJ7DShYztrgu7+LZAs4fHVNOv+80w4I6uDPfpNgAVFTqNtg==
X-Received: by 2002:a5d:53c5:0:b0:367:8a00:fac3 with SMTP id ffacd0b85a97d-371946514e9mr5769488f8f.30.1724002130248;
        Sun, 18 Aug 2024 10:28:50 -0700 (PDT)
Received: from krzk-bin.. ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3718983a31csm8518541f8f.17.2024.08.18.10.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2024 10:28:49 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Xiaowei Song <songxiaowei@hisilicon.com>,
	Binghui Wang <wangbinghui@hisilicon.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/3] dt-bindings: PCI: renesas,pci-rcar-gen2: add top-level constraints
Date: Sun, 18 Aug 2024 19:28:42 +0200
Message-ID: <20240818172843.121787-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240818172843.121787-1-krzysztof.kozlowski@linaro.org>
References: <20240818172843.121787-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Properties with variable number of items per each device are expected to
have widest constraints in top-level "properties:" block and further
customized (narrowed) in "if:then:".  Add missing top-level constraints
for clocks and clock-names.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/pci/renesas,pci-rcar-gen2.yaml    | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/renesas,pci-rcar-gen2.yaml b/Documentation/devicetree/bindings/pci/renesas,pci-rcar-gen2.yaml
index b288cdb1ec70..065b7508d288 100644
--- a/Documentation/devicetree/bindings/pci/renesas,pci-rcar-gen2.yaml
+++ b/Documentation/devicetree/bindings/pci/renesas,pci-rcar-gen2.yaml
@@ -42,9 +42,13 @@ properties:
   interrupts:
     maxItems: 1
 
-  clocks: true
+  clocks:
+    minItems: 1
+    maxItems: 3
 
-  clock-names: true
+  clock-names:
+    minItems: 1
+    maxItems: 3
 
   resets:
     maxItems: 1
-- 
2.43.0


