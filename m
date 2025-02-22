Return-Path: <linux-kernel+bounces-527164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D24A40801
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 12:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43B92700DF1
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 11:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F52220ADCA;
	Sat, 22 Feb 2025 11:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nTg1x/SB"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40848209669
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 11:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740224513; cv=none; b=oqaw1duAm9rsqHcJs8g8IBwNEj1uXn2cpqFKWuIdViCj8A5T8RwxyCD8LptOvr1Rl7fz61y9UzQrtIeP9BxQl7NPp0wjKKFw0RFagAFopUZrwltDA35XnRltTcWnamLezg09Kqfs8REkIm8BwuxqYHnB884PE7O89vlYLDCheG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740224513; c=relaxed/simple;
	bh=vu/VIs7YG3zkVFX2YaEP85DPSJetV9jQwZiEvU6CoKU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JpVQehZWwbHYLAD29MZMuDQj6fyd/3X5jQakRAhR70UzpzuLd3MzncJfSX7otgdLfb70+CZamoJDFx8eP3lFyZUdpTUuXt++nB7cUkwpS6P5d1IBK0exSRNxqhmGBdKLUyKe0niUD1E6IYWLMk2EUqIQ2/ZTcGbpaKq5UK/DPaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nTg1x/SB; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5dbf65c0c4fso589315a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 03:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740224510; x=1740829310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Pg9OSIRa3mJDiRSNRlfM9UaUu3vkBxr1oQN9bQqTEQM=;
        b=nTg1x/SBlPQiOwv6liDXWGl0U6b+AOWu1rJzpCCxGDN6slWlw6ySmc7T1j0W3psluG
         QGeljcZ4melubbz3fN0N46bnCWCnvquwPp0ELzgGrHR8NS5B6M7c49hgM6ywukEBd6LM
         Bp4dQiyoCgEbKtSC5b9X61AOp21XwIzXd9thk6cv6f9lZbWBDYm0qH2xGUnNOHFPp+gE
         RHkYOrghNDNrNneONlFmFYvTaylEIkP+mOeQgfgnGPLYeBMvvFCxsNX3pdFHXspHCZrP
         pxoB3BJ5a+nV9ibGr3YOBaxXpEDfxgvO6ih3ou6hBbetMdlgmhOA7zTIHHjLgTvk6bdw
         zvGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740224510; x=1740829310;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pg9OSIRa3mJDiRSNRlfM9UaUu3vkBxr1oQN9bQqTEQM=;
        b=KzMY34+Kr9YLTFYrAZCYrI8yheL+rLYigytXmbbBdNrgXZAl2LycXDiGXnI2W0jr4u
         YeoQJd/eJJE1RhrEqDh6B2Z6YVuaKwUwyCHxp3L4DQ7rThEvlnBVGl6WEsIHWLIYS/al
         k3r1+Od8+ki+1ILfMN5gbfZULYAVgZp18xWBms9KEtq42wMrk//kNOrVZPuj0Gsufy/J
         FkI1OcbWeVW3h7KhXjArM6YnYBhlyrkNRvxgKUjgWaxAVlgaz6VDh5c9TNFNUT11AyvV
         5cWvGHgOel6o6EIQDp47Cv86+BwUpK1JpwQjWsTBFUbwb2M/6nxuHDaalzhfi/rQMAlM
         aROQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoUEy+y9qKf2dxW5eafplwYqBls8nBJrB3TqR1PjZvL1g5I+p2DQ/sIS2atn6L/AhMeX06O/mjLmF17qA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+1bStJywfii/W4wgLhOQA5O53D7UkTmvb6wt8Axm1wFlrlzRZ
	CvOCyGkfoXBn/naxtmUrz4QzCZQ0nrjTf2akdwTS+QpN4dotIU2d6x/n+Nz23Gs=
X-Gm-Gg: ASbGncvzNeva67AB8oT5t+TIe3SdqggefW2CB6y7kifWSlu/RSOm/EmNLGl+hJClolS
	6OuccApQINPdKiVLklUDw+SEfQExUFqg93UtYgEfr/LJ8v0q1rL26Cme4bqY//mGlkTSg9ro5Aj
	rEjx3MpiN9IIvugQV/2XDecuN4JtYcaKIXTivbf6pgxWWm7NBUWQz6JIYC0EpF5mWPfMwjFRz/J
	hRgwDG4CkDiA3ABqUvV0re8IZ2eUiWWNwBDmOkNXQQt6v2/TRVb1of3D4AMZ6iWfe6r64MnrLr3
	w4Xq86U3Gm6ELCup3i7CRXXzMmQkJfzQi8y9Cuh/GZXqcqEcTbkNmi1t83J3HMAU9cvhDZbg05g
	=
X-Google-Smtp-Source: AGHT+IExcHQtiDKMj+mN+X979lYdCH5vPGkYda6XClGheig67KnUK/FsbB2QwJpX8ZpAkABrcL+YIw==
X-Received: by 2002:a17:907:7f9e:b0:abb:e7b0:5437 with SMTP id a640c23a62f3a-abc096c807fmr265884266b.0.1740224510499;
        Sat, 22 Feb 2025 03:41:50 -0800 (PST)
Received: from krzk-bin.. (78-11-220-99.static.ip.netia.com.pl. [78.11.220.99])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba5337634bsm1852663066b.91.2025.02.22.03.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2025 03:41:50 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] rtc: fsl-ftm-alarm: Mark acpi_id table as maybe unused
Date: Sat, 22 Feb 2025 12:41:45 +0100
Message-ID: <20250222114146.162835-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For !ACPI builds, the acpi_device_id table will not be referenced
because of ACPI_PTR:

  rtc-fsl-ftm-alarm.c:312:36: error: unused variable 'ftm_imx_acpi_ids' [-Werror,-Wunused-const-variable]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/rtc/rtc-fsl-ftm-alarm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-fsl-ftm-alarm.c b/drivers/rtc/rtc-fsl-ftm-alarm.c
index a72c4ad0cec6..c8015f04c71f 100644
--- a/drivers/rtc/rtc-fsl-ftm-alarm.c
+++ b/drivers/rtc/rtc-fsl-ftm-alarm.c
@@ -309,7 +309,7 @@ static const struct of_device_id ftm_rtc_match[] = {
 };
 MODULE_DEVICE_TABLE(of, ftm_rtc_match);
 
-static const struct acpi_device_id ftm_imx_acpi_ids[] = {
+static const struct acpi_device_id ftm_imx_acpi_ids[] __maybe_unused = {
 	{"NXP0014",},
 	{ }
 };
-- 
2.43.0


