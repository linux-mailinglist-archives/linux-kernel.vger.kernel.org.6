Return-Path: <linux-kernel+bounces-559572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B344A5F5BB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 14:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E377F7AA349
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 13:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40949267B79;
	Thu, 13 Mar 2025 13:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mkx8atet"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4676D267737;
	Thu, 13 Mar 2025 13:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741871526; cv=none; b=GIOx1nSfdXTKjWidxFqK3EMk+J5cliBjt+V1cGBwjCsV7lBS0Wco8TkdcZzG+2gtvfk3YEg77wfHTSEJf0XvOnTeuaOZ+9gn2fy1/CjXcnM8vUhX+y3ecJi50GCELaBpxgMwLWAisYRz4higtN0e08CnI6sA/AZNbNFq8SU+dOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741871526; c=relaxed/simple;
	bh=losN7+Xc5utDKmJ4z+1lgugBumic+UE1GU4OYTnTOco=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V4tALBiLDVjY4nFI0COYP0RPY9XWYGJGTQpbl0FRQUFc7om1MuOm1/MtMjtfQCxA5O8+bKvoHDB8rBO1A+ZrF1PNsH5/trijxdyA4kGpvy7vutA39KpG5GoipUlSdPiUh1SIk4ylB3Uzz3DvsLahCer/hV5qm9Fa9y8G7P0l6Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mkx8atet; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2239aa5da08so16723545ad.3;
        Thu, 13 Mar 2025 06:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741871524; x=1742476324; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ioHnF4CSbRYwCOFInozClNxdEAsDMbHLiEMPDV5mWJ8=;
        b=mkx8atetkIvaVqgSwz03jor0bOiqxwqlbt9zPRLoKguXtEx8XYawQSUXSgrdU/U+gM
         YyQ03/W/gnU1asMsQMc5ZAPuSuTbl06RWQtTAVU/9WQQTolGyHfCc2iujdGdLjwX0zZ9
         IF6mp06O3ZVwar5cZMUd7n9TkovVhb30piLJeQeVoaMZZfciCMOvbIg50DNNgeoC0nqX
         QiGheP1EMwSmx/WMlMV0RDW8qE8CKk18lXzRmlxF4cGwyqgDS/E88ZapZDJUvpn15kyH
         MVfL2vZYtbQ2kbBU2WRXlXx3EayQWOtBff0/+fIk+mnE/ULVhJNf1m+fd2qusrcwksBs
         mlyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741871524; x=1742476324;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ioHnF4CSbRYwCOFInozClNxdEAsDMbHLiEMPDV5mWJ8=;
        b=OzgwIub+t/32HAKoarDakrG+5Xi5AxtztueHkmZSF1XvIaXw2Q+RudFsmsYTBlm4Qh
         jcGZogNswA/e99VFNhhibSW3gBPorSA60I9wnKkVxH9MdbpdoE4evgM4A6HOITblnBbV
         VenHl6CwfybT9jTKSLR0BSbprw5EUJtMxqYek6tGuJgzN7NDXF6f0wdwXO9xxnnNtP2S
         3cipxvSA+joirfVhBRd7XvTjeMf0KIlbewgC2oNO/+mMbWKT8kkV/HyUH8/5h+4fQA+e
         Cy2honLQY/dxWF7ip7e/wXU27LdQL0BI0NHVBjnQlDNKW0rTU3lf+Yjp8lGSCvE8ok2X
         7gMw==
X-Forwarded-Encrypted: i=1; AJvYcCXgYqZSbfj/YQIMHUj+mJq4HUYBIOnk87xZdJ+KpQDHhilkw75ej1leALYWEWl7tX+alwaFxNSmRXssSOU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtcobSOCOrRn1vMp8Agx0K8KE55PmqCEmlxiV3DZB5hWMNh3JR
	Xx46bS8njwgQyrh430DSXiFeeLFBeXMGB2FzG7qXqZncTIX414tvt+3sgNCamp2UZEpo
X-Gm-Gg: ASbGncvyVUzL9dg8ev0G95cSTpXm0zVT2iKg8cK4PkrYoC0uo98EmAISx1ft9TWXtau
	UTrKpksxyDEh4EMNh4OQkxFm8pWavPeuNf8pDcJp+XPxAi9Hq5DqBNvaSmvTC4NDGAf+1nMfzc0
	jOD7uP2zz2ORbuf0w0ffYBu6s6dzvs7qBzM1XOQlrxq1Njv4JvDheTFdDM0CN7Fb+ho2/DqvkKp
	sjxMK+SbktiPxEqv3fEFHMf0MxL20G2/vltqaOLwvLHVHsL2TQoIgVe/2VEls3fzWP7ebNCaNKj
	Fl7MCersfvO983OuOiQdAiJ5/kZB9T2beyM=
X-Google-Smtp-Source: AGHT+IH2Tw+QYfXY3WazHSYYhYEHi4iFK5Rz3wHX0nrqtQpHEZJOcKdnWkhmCHmNlfUvzg4HFsOddg==
X-Received: by 2002:a17:902:e80a:b0:224:6ee:ad with SMTP id d9443c01a7336-22428c01371mr410617775ad.44.1741871524191;
        Thu, 13 Mar 2025 06:12:04 -0700 (PDT)
Received: from [198.18.0.9] ([2a0f:7803:fac5:a7b6::1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6ba6d52sm12539615ad.116.2025.03.13.06.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 06:12:03 -0700 (PDT)
From: Zixian Zeng <sycamoremoon376@gmail.com>
Date: Thu, 13 Mar 2025 21:11:49 +0800
Subject: [PATCH v3 1/2] spi: dt-bindings: snps,dw-apb-ssi: Add compatible
 for SOPHGO SG2042 SoC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-sfg-spi-v3-1-e686427314b2@gmail.com>
References: <20250313-sfg-spi-v3-0-e686427314b2@gmail.com>
In-Reply-To: <20250313-sfg-spi-v3-0-e686427314b2@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@outlook.com>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, sophgo@lists.linux.dev, chao.wei@sophgo.com, 
 xiaoguang.xing@sophgo.com, dlan@gentoo.org, 
 Zixian Zeng <sycamoremoon376@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741871512; l=949;
 i=sycamoremoon376@gmail.com; s=20250113; h=from:subject:message-id;
 bh=losN7+Xc5utDKmJ4z+1lgugBumic+UE1GU4OYTnTOco=;
 b=ndAuJNM+9Z0GCvopXpM8mOuezwgblTRngkyxWcXuEIrGOBWqA386LTSVTso8ktm5ASWERKBR2
 QOnejMyOqQdCTA3gURZiiSj9KkfobekfTyP2sNO3oT/NcCArQUd2yVc
X-Developer-Key: i=sycamoremoon376@gmail.com; a=ed25519;
 pk=OYfH6Z2Nx3aU1r0UZdvhskmddV6KC6V1nyFjsQQt4J8=

add compatible property to include "sophgo,sg2042-spi" for
the SOPHGO SG2042 SoC SPI Controller.

Signed-off-by: Zixian Zeng <sycamoremoon376@gmail.com>
---
 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
index bccd00a1ddd0ad92b437eed5b525a6ea1963db57..33fb21267df2594e68419cfb980a40909868e337 100644
--- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
+++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
@@ -92,6 +92,10 @@ properties:
         items:
           - const: thead,th1520-spi
           - const: snps,dw-apb-ssi
+      - description: SOPHGO SG2042 SoC SPI Controller
+        items:
+          - const: sophgo,sg2042-spi
+          - const: snps,dw-apb-ssi
 
   reg:
     minItems: 1

-- 
2.48.1


