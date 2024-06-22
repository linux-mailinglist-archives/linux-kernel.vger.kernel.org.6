Return-Path: <linux-kernel+bounces-225707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9436F913423
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 15:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2083B22CB2
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 13:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C42E1527A1;
	Sat, 22 Jun 2024 13:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fL5CEhVL"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F98616F0F2;
	Sat, 22 Jun 2024 13:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719061976; cv=none; b=IUuUEQINA760GoqE47KJsviRDemK9GkYTBJJtzBoDaTM0ovFSq86LCcoURHFBWz7jvQshc7MnSk88KRy3RHbXA5/OLy5GBTfvqaANvYfNMN7fhkxQdSt64sbUKewbEPGx7UjYHwv3Ythu4V+wBz8bnS6T2v80IXDv9bPwWHEDDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719061976; c=relaxed/simple;
	bh=gBxXwvVagI4ftepWbB3zihlaWc8oZrTP1cEGekvDHwE=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dl18NxaOo1m1FIiMRXXkwf2WS3h4o11cId1+BaN6zwBqZK1wzqQ883L+/u4/mte8SitRtG6GaZGC0MpQlvQ1Zs+jvQ+7TrBde/Oe25a2Zuw6XPKcwwaNK3eYyotEm9ruYoqBhRFeaGJv4QnrkCtoLQQ7qjFo1wrZji0WbnlVg5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fL5CEhVL; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a6f177b78dcso316075766b.1;
        Sat, 22 Jun 2024 06:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719061973; x=1719666773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OS2tNNDMF7Cd9yV7FuF7w+ag2Zr2Tkm/X81pLFNB/r0=;
        b=fL5CEhVLmOyCCJ5tMK2c4/bY2A29vDTfXVFfJsD61tN+Y4bNt0ZTM4XcbSbpHf2VCR
         8qEr1axdvhA20paa6B2WZQe7gMso+Lqhjz1T6dXNQXxGI88ICo4ewJmRxFzCvlKjj7PA
         LnjlTIXZt9h4CuYFzOKUwgyQXs/jMaGpwqydZQEGeUuZ5zbFtFF6lMmARKt2sJeoaZj3
         oriiVWVSqrzFZkB9upsGAb4j69SeIX+rlXybLytb3alwtK9Ze+03Df9W2D69f62r/L88
         IHXdOJSMia9ujA2mkC+7HvBMW5dKLuaFULxI5UMBjjg5F4cXHMAuJY2+kDxHWIgUXAxc
         /dyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719061973; x=1719666773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OS2tNNDMF7Cd9yV7FuF7w+ag2Zr2Tkm/X81pLFNB/r0=;
        b=QmHR4qDShTFQO+3iI9C3YhoSDHTNY9+Uf4JBkYhOky5CmMKZ3Q7RHBpFPPR9dV2n7N
         Jgyd+MLULBCS0L/PMJF8QfcTPBDsUufKtQK6HEXjGSHEQ8kUFI16iN/TDI4nA6m0xhSk
         SYRegrGJ2j+VH8l9Qc0nG1wpmbcpTAZKhNfz5K0N10ndjWdlIssrZ1qpI5ElCmyBS2+v
         oRCYHjG4HqwjKXNmWvAdmbeK8yA51WsbtyPSAGxI/Csy5BYRVQ6+/fIGkV9oJSl/QULf
         /uoGo7R7nFiRqF1eN6bIlyAnUxWal3ZQeFW/XrIsfZttb/lZzqnKqU2sIFRlEhyQEz3A
         awhA==
X-Forwarded-Encrypted: i=1; AJvYcCWjjAWwSzzVp5DXiM4QEWOeNYoG8LJI2IaaYm4ppB+I5HjUX8ZtE5hKeIGKi5GQXhRAdvbKpOgLQ7MKaTKmdYQ65EtBqHrFkKJTYBI7qm9mM4h9qDSfeXGRsXtu91BDE6mbIk40K2y87RCyESMX/Px00XtDurh9Cq7DsCMzp2Bv9g9rViij
X-Gm-Message-State: AOJu0Ywzu1KfpT521jctP60yTvYOAAWervrj3XYRN0EF4NkSaqBicEIa
	dNE9JiUYb7VR7jdCN61hI/4v2+XbxkKDtp7D8Vtev09mnW65eHiXzX+vZsSBgdQ=
X-Google-Smtp-Source: AGHT+IFyJGKQbxJh6fK4UgCksg7qrcHYvLLempm3p7GWi7cFtmy4WwyuDhhOjkLx49PwlRpT/DlTYQ==
X-Received: by 2002:a17:907:a4c5:b0:a6f:b5ff:a6fd with SMTP id a640c23a62f3a-a6fb5ffab3cmr720166366b.12.1719061973272;
        Sat, 22 Jun 2024 06:12:53 -0700 (PDT)
Received: from toolbox.. ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6fcf42a724sm197708166b.16.2024.06.22.06.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jun 2024 06:12:53 -0700 (PDT)
From: Christian Hewitt <christianshewitt@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shenghao Ding <shenghao-ding@ti.com>,
	Kevin Lu <kevin-lu@ti.com>,
	Baojun Xu <baojun.xu@ti.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: [PATCH v2 1/2] dt-bindings: sound: add ti,pcm5242 to pcm512x
Date: Sat, 22 Jun 2024 13:12:44 +0000
Message-Id: <20240622131245.2607533-2-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240622131245.2607533-1-christianshewitt@gmail.com>
References: <20240622131245.2607533-1-christianshewitt@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add ti,pcm5242 to the pcm512x driver file

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
Changes since v1:
- s/pcm5424/pcm5242 in patch title and description

 Documentation/devicetree/bindings/sound/pcm512x.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/pcm512x.txt b/Documentation/devicetree/bindings/sound/pcm512x.txt
index 77006a4aec4a..47878a6df608 100644
--- a/Documentation/devicetree/bindings/sound/pcm512x.txt
+++ b/Documentation/devicetree/bindings/sound/pcm512x.txt
@@ -6,7 +6,7 @@ on the board). The TAS575x devices only support I2C.
 Required properties:
 
   - compatible : One of "ti,pcm5121", "ti,pcm5122", "ti,pcm5141",
-                 "ti,pcm5142", "ti,tas5754" or "ti,tas5756"
+                 "ti,pcm5142", "ti,pcm5242", "ti,tas5754" or "ti,tas5756"
 
   - reg : the I2C address of the device for I2C, the chip select
           number for SPI.
-- 
2.34.1


