Return-Path: <linux-kernel+bounces-213483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 761219075E7
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 17:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F8F31F24996
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 15:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F6B14901B;
	Thu, 13 Jun 2024 15:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fxySFIUL"
Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DFE84A41;
	Thu, 13 Jun 2024 15:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718290930; cv=none; b=QtaCQUMuMsF6gb4gdKNg1Z4JYl3qTAiK+HSFV22SJjZ94XnIUf2oi4Cy/OeGY1oYq4rb0TOxdL0xVqhbLb7J6XEIGxFglxER4KCXewH57Toh9gUUcYbkAHHf/h4v8GOEMqlFZQ7KYkjX17x5sRsX34XZT6G4+YVZjm7iLR816X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718290930; c=relaxed/simple;
	bh=0vwy+oNU5J1EjAO5qZ9rH2UnBq8fpSIO7ukwd4fnDiY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ANnE6Eyfchk1v/RJNB+tVatFjtDZ7M5a0/u2fQrxOJ9mATIwtZAzzutnrODb2UW0nXVS3xQxh7B50TTxZkXk+9IuhZXo+iRVyDhybY4JVmBdsxlNf068GbQaF0X1qFbVx5pkHjoO2Zbkizu3kKZje1b81VmL/rFiOVcE3PoTxzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fxySFIUL; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-2c2c6b27428so883025a91.3;
        Thu, 13 Jun 2024 08:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718290928; x=1718895728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U8DQ5VScKhFQSJasWhNy88C3p44N18/s2PVWHrzDJ1M=;
        b=fxySFIULOcSiU0j8shdFXj0olcsY+r+SysYmEGW/WSrpyngMxwkClo2R3hDh/66jv7
         Vz6atNia+R0FBl1KpQdniQjZ0Q6T9kzY/W1nCpGJr3+hf75tKezHT0gOsw6a42SqRv17
         +IbTq0/56LEjj9oAsQVv9snCrcBiT6G2eXPy7uXts9ztF1XV6sKEEY9uJWtYaHsRyYdV
         ng7MYh0ZfsQ+nVnxtDrMLRYSMLpAVkR0K+cNlGdudrZQuP73jD53RhSlOLHh451RDj27
         RhdAdLi/FJW2MO1YraGJgfNqlrf/dOViVtxFXiJhcKmIEGzXHNTzGBJ0yEOWEjqqfXgQ
         Z98w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718290928; x=1718895728;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U8DQ5VScKhFQSJasWhNy88C3p44N18/s2PVWHrzDJ1M=;
        b=psUZgNkoirgXmEE+P5G+nRhWFBupfeAFNRYLgjURP3SCN2S3SKFyClMR/UOiXvlwRg
         CUrtASxMioLTleGNCc7vcawbQhOlK+fi7IOPvcN9V/v+u5KhGffJ+diDuhIVk3t3F8ts
         T1clQCwbBWZJDniHbXGQToNkV44jBf4xz2KN72F4fu00jS83ZiNYfONm4McXeBvdaRXy
         p7w2/PR2TdIOp400HlnbadFOnI8l+ATuuWV8KHSpj+jJeWDYxWjh31gU3mus3QlcSXLC
         sDwbc2AJ/tYrDglPrYUJPmOPfvDxEKQdB+B6NK8puI3DoLlBM72MmoBTEh6VuDPKqDr1
         RdQA==
X-Forwarded-Encrypted: i=1; AJvYcCWhwpK1889lJfTwBqv3a0NIEtX7b2NkiWzqGSUM3tBGjS8cTdCgnjZlSfS0AeEFfz/IDXBRk0Ot+9jrQ8lTrLY+/1BjCcON/tykqXX8
X-Gm-Message-State: AOJu0YzBcvsjGYY7tIj2zYlUZQ6mV4l2LLJZvBv4PNpb25L58zYQ5jxo
	tAbSKfdSM1SfQ1feFLuND/6I92seEk5PmN5bh2ALM2KAIHvYjoSC
X-Google-Smtp-Source: AGHT+IGUL6iL63738dYA+yvB1xagrNO9EYkLDn2Qr1lQX9lVpSnql/KaQWLtv98XU96vTEwwOs3YfQ==
X-Received: by 2002:a17:90b:3c1:b0:2c4:b2d3:6c8d with SMTP id 98e67ed59e1d1-2c4db129158mr13502a91.10.1718290927718;
        Thu, 13 Jun 2024 08:02:07 -0700 (PDT)
Received: from localhost.localdomain ([121.139.28.121])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c4c45ad12bsm1841234a91.7.2024.06.13.08.02.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 13 Jun 2024 08:02:07 -0700 (PDT)
From: Gyeonggeon Choi <gychoi.dev@gmail.com>
To: robh@kernel.org,
	saravanak@google.com
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Gyeonggeon Choi <gychoi.dev@gmail.com>
Subject: [PATCH] drivers:of: Add null check for bus in of_match_bus
Date: Fri, 14 Jun 2024 00:01:34 +0900
Message-Id: <20240613150134.66329-1-gychoi.dev@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Added a null check for the bus variable after calling of_match_bus.
This prevents potential null pointer dereference errors in subsequent
code, where bus->count_cells could cause a crash if bus is NULL.

Signed-off-by: Gyeonggeon Choi <gychoi.dev@gmail.com>
---
 drivers/of/address.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index d669ce25b5f9..85f986d25870 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -504,6 +504,8 @@ static u64 __of_translate_address(struct device_node *node,
 	if (parent == NULL)
 		return OF_BAD_ADDR;
 	bus = of_match_bus(parent);
+	if (bus == NULL)
+		return OF_BAD_ADDR;
 
 	/* Count address cells & copy address locally */
 	bus->count_cells(dev, &na, &ns);
-- 
2.39.3 (Apple Git-146)


