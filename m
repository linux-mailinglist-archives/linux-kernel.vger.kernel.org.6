Return-Path: <linux-kernel+bounces-187139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 951368CCDAC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 10:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FB962818A8
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 08:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D158213CF93;
	Thu, 23 May 2024 08:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="wkNDQulX"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD8E2EAF9
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 08:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716451355; cv=none; b=Y4G+NWxg5MlF/3ufrlbHsXDo1P8GWxOpqpAf/a9gG61AIqwZmCVc2U8j2YvCoJy6POAQpSZN9tauQm3ygdwhPDNFKyru8TzpKosuPNHy4GWteAOpm7X5fKDUOx0qb3WaDiZSPYR78A46uScoLdjCe/pLuYbjR2ucRrmgLyFkwg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716451355; c=relaxed/simple;
	bh=93BkviNCvSQMI5hCOWWFbJYlHSfKWs+OCnF5mCnvmxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TXwSMxWFzD9GZfy0Gr0pLm9jp1MajM3XwkP0PMnqCZwpI2Fbo3U/bpFT2+B2/uaU9d36ybX+S92+AtS1/RJblZZQ217Vm/UfdDZW8CM18GAyx0SmjMtnpGsAfv4xPgRcq5mxcQVgckpgWO7h5oiQEd8PEniuL44CRN0dIxG07OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=wkNDQulX; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-354f6ab168aso302046f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 01:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716451351; x=1717056151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hvk4HIZY8LHEcAUwcSCVMUiBIBW/hN1J4i9rPXs1rgU=;
        b=wkNDQulXNVjFwQp+Jmnx4X0GJKh94nyCsuDjeb4tYWZY217Dvb2k1LmsV1djAMlv05
         n08m1EG2pOuzd366FlsuoB00eObM7Ll9VNxGX8DBdMA9+ioQsmgoS3WZSs7wU6sImhLI
         g1WeSEizbh+Edm5/qe4Ja7yJoCoAbK7JjwezObweO6dBOyAAvmtJ3a4DpkLclBiCCLcQ
         KZXA+vXELbkQoPU5Zb8imFcEiCIHLlX93ZJlY4eK9yoMH/+BZdbuPUbK7qNKQ9Cq6f8c
         DYG1otQyxeD02VKSx1aTKZc3cdd+W/Ja54R5S15Xu0HD5UTSzlEWL2FuSDdI8dxWDWhl
         fAXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716451351; x=1717056151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hvk4HIZY8LHEcAUwcSCVMUiBIBW/hN1J4i9rPXs1rgU=;
        b=kdfrEpMzTRRQIG8NqR6dU2otdDmH38F2SLpCRdb8xKRAAEciOf1VUIUda/qTTer9XP
         MjiElh5f5t9+IW3r4NKqRLvWkWTrl4RdTqxx+LDslXTMSzPRaL+Y/82jPv9V47BpFerY
         m+VXa0KEra66f/j6LJypm4M563jqflhfh7vcLE3fM3LzccXWE9dMwizeLzEzOb4ZKcTx
         mMtuozm9YbPbblVB/qbWjAuysn2e9F6TeQ0/hui3gN1d+z8ZQ4tF/bq4kzywvOkjqSTg
         yeS05LCX6dLl6H9VI/vgwUyC8cseIQ4hsoEpaOieYDg1OjWbfcE3XZ8JgZVWY6aZgP7V
         HdYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIEmHK/+f/NddPdznxSTS3mFKGZfvyMZMXxUhL3xi8v/z2nNX3RqqMo+ICay3wfVhz4Z/aJNk5ZItvzNwhANEnKNR4AgD8KqNNZ9Mf
X-Gm-Message-State: AOJu0Yx7O9AoMD77SdCjsyOCV5fh7ImbVNjAvLn8Luq+RM0lgd7RuHqk
	xCmTHwtf2KhBuVnz6Dxi7Ym121ghRF+USYJ8Ctf+8scZUvmQCiHiF6PocLjQiPs=
X-Google-Smtp-Source: AGHT+IHIDpueviEXVOQCfyMIdb4MDOW3f6eAQ8UhH17w3HoGPfjSwbQa24Vo8LaaSg9UtVgFg6tSMQ==
X-Received: by 2002:a5d:456f:0:b0:354:f46c:856b with SMTP id ffacd0b85a97d-354f757c1c3mr1444427f8f.28.1716451350801;
        Thu, 23 May 2024 01:02:30 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a246:821e:6f3b:6b50:4762:8343])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35501abfdddsm93637f8f.110.2024.05.23.01.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 01:02:30 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Nishanth Menon <nm@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: Vibhore Vardhan <vibhore@ti.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Dhruva Gole <d-gole@ti.com>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH 1/6] dt-bindings: ti, sci: Add property for partial-io-wakeup-sources
Date: Thu, 23 May 2024 10:02:20 +0200
Message-ID: <20240523080225.1288617-2-msp@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240523080225.1288617-1-msp@baylibre.com>
References: <20240523080225.1288617-1-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a property with an array of phandles to devices that have pins that
are capable to wakeup the SoC from Partial-IO. In Partial-IO everything
is powered off including the DDR. Only pins belonging to a couple of
devices are active and wakeup the system on activity.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml b/Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml
index 7f06b1080244..c8ed0dd4fee4 100644
--- a/Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml
+++ b/Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml
@@ -61,6 +61,12 @@ properties:
   mboxes:
     minItems: 2
 
+  ti,partial-io-wakeup-sources:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description: |
+      List of phandles to devicetree nodes that can wakeup the SoC from the
+      Partial IO poweroff mode.
+
   ti,host-id:
     $ref: /schemas/types.yaml#/definitions/uint32
     description: |
-- 
2.43.0


