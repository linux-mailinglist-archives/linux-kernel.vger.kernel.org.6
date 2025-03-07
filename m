Return-Path: <linux-kernel+bounces-550642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE195A5625B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 09:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32D73188B556
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 08:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48CB11DE2C8;
	Fri,  7 Mar 2025 08:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yH7S8w4l"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7351B4224
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 08:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741335216; cv=none; b=AV89oRSLh5q7xl0c9dJsC+a0I0Y9VlfXC+JMiJK1tVd+IzWcSlrunVBUgwekf/uZmPyg2puRG9MdfkSkLDzgG8QCpvJ1kcl5KDbCs9wmnk5GroHQVCBAJt5qITU/XD+1OZc1k5HfhAyItYFLx6ougR3+fnpdRsSyPV1737X1lls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741335216; c=relaxed/simple;
	bh=mNNtsgjvr/yg2dDU2qGg1ag4pOBiq+f/ajn9YgzG3AQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M8NSKeyum0Y/K6Kk6wxldFmc6+JQ0AILBTI7+CqYUkIQ3OmHO8qoKhyLDbtRQQZOwLlOKj5CYp+GxvApMlgu6z2z0f/ap+TP9ZG9N8Jkf0MqXsrVGJoatjo4n9V1g/SmXY2dd7FR5q/9qIZX1yrVcsLDByqeA5Uz4k7FQpupkfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yH7S8w4l; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43bd750d27dso2042385e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 00:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741335213; x=1741940013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=12a3NnEfGMI2vuVvciD88yslLap86n9MfZE9qRsezz4=;
        b=yH7S8w4lVDYb0b579FuP93g8k8kinxWIbiqkN1cGT5OKt3+UA6VIJ7uj5Epbch/ygr
         wZhMUWu/PUAU4Rv3xaODXKze1uDqkZ6fpaL/+GtF6xljTw1kgoTiUua4CApSA76qtJC+
         y8UgX6xlFtKdttpjysXvpakyhheOD0r9lwkFz4dWthvXlt4+l8vkmH58sUtWwGOGjLNm
         MoH2xjC3GSKtfYmF8QYeALPE4KCy3WdGtvQhQOBdNEJ+jw6uJjhjtfd2EaUQoPO95Xrf
         NQBDTW6ONl/bPUEsaIxyAKj65Gila15quMGmmCmqZeRcBCbcuiHP4rtW1MunUjv4Pl2/
         sWgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741335213; x=1741940013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=12a3NnEfGMI2vuVvciD88yslLap86n9MfZE9qRsezz4=;
        b=esy9niBdcp8q7K7tQ+O+q0FMJinC1QBylJLDNBGmsczFl8uVPbX7KHbRVQhcgTpNW1
         JRKG4Vjsz8+FV31w280M9lxAOVf7pthq9F7Niy27q5nj+IDLgyLQuWqZRH9qMtHRcr6Z
         kmSoJttb3UkmQVaTvLEewoJHlZUZiigaoj8MSrsL8YBDrlFOffH1N79F9jwsMDvKP01V
         TlfU+akx8Ws4a/tZDmqQTzeHGRyK8VhR2/OK+9S2ClGZ8ydD3gqkZt1piXLSUXXWJ4dd
         O9V7qneQLO49hmI3lqzy/5E7h/bP/3wdGAyqLSIuSyDR7dVHfRhMQIWIxsTtLiYxqBra
         3hng==
X-Forwarded-Encrypted: i=1; AJvYcCUM93AfO+qER1lMI4Ecnr0tfVPPtcbiyvVvCBGxB2jfo561NuWgTP+pOTXmGoBMnTsF60Xf9R4pUjjIGKo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/zhmZx6vXVa59nIZZUjBfW97zFz+G1w2hOFn74hexx97OxHhz
	hMuon8ogo12SAMhEKYI1GttO4xZU3CRHvBQw+/5X271OochZw1rFmtPps7lnv40=
X-Gm-Gg: ASbGncsYHW2me6F5MkmOMzkxg1x4PRcE+yMNegy9atAe8WD3kw1Nwlohb4xKDidWiqk
	jPVf7vAxH3pkPP7sIu1Nf0pliSgFNylBmRyEAjBklA175QDCvv4BwR0oLXLnCp+ky5olgij/yAO
	9ry4cR8w1pd2Zx4xMnKrjQbRxxv2djHov5Sf4hsJdC7+nyMV3r7/aZZ2hOnJqpnVP/sqYBQm+d3
	mBbL0Jcr1pqB9LsA+/TSEvZThngqHsNSy1zoCWUFT7DXLAlxLt2QJx7Nw9MTgaCsqkhdOBd5Weh
	TV11dSVpAHRHltZb/LI+mYJROARYE+RdTpxShirYXLAw81vEYR0ku4Nn4K8=
X-Google-Smtp-Source: AGHT+IFQ+WMMvLL1/aaHUI7n7dcR9ePxgtPjRJRbPaHSVEqjJg//u898K3D1y4ZCAvDVaQslPXHcGA==
X-Received: by 2002:a05:600c:35c9:b0:43b:c844:a4ba with SMTP id 5b1f17b1804b1-43cccdd9b0dmr2917685e9.3.1741335213314;
        Fri, 07 Mar 2025 00:13:33 -0800 (PST)
Received: from krzk-bin.. ([178.197.206.225])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c0e222dsm4575458f8f.72.2025.03.07.00.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 00:13:32 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] dt-bindings: PCI: fsl,layerscape-pcie-ep: Drop unnecessary status from example
Date: Fri,  7 Mar 2025 09:13:27 +0100
Message-ID: <20250307081327.35153-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250307081327.35153-1-krzysztof.kozlowski@linaro.org>
References: <20250307081327.35153-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Device nodes in the examples are supposed to be enabled, so the schema
will be validated against them.  Keeping them disabled hides potential
errors.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml          | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml
index 1fdc899e7292..d78a6d1f7198 100644
--- a/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml
@@ -94,7 +94,6 @@ examples:
         reg-names = "regs", "addr_space";
         interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>; /* PME interrupt */
         interrupt-names = "pme";
-        status = "disabled";
       };
     };
 ...
-- 
2.43.0


