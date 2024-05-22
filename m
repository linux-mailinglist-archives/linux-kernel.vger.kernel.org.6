Return-Path: <linux-kernel+bounces-186511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 345918CC518
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 18:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E26A02821DC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 16:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583681420D1;
	Wed, 22 May 2024 16:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="djW9DNbr"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D86B1F614;
	Wed, 22 May 2024 16:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716396521; cv=none; b=qK3L4e+s9oDimiiZZL1m8HW6XlZ0IdEgdzqtKK3e1k0gs2FCIG9kJ6RbC3BpIjThPktAV/zBvlDqEmE5fFgWjpySUqhNXBwvTTPB4bA3NYxTydC7/bdx8A03Iy9xnSLa3OpFKz9+AF5rKYUPQigxbLIe7Lhmm/6/hvKqD5xx5vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716396521; c=relaxed/simple;
	bh=Zs9uy9fuyBX3pDUtkcwuVdOvf2tBQXh3mak3VwTK2LE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BC97nemXp/i6ILnMln5EdyYqlXA3yzl7Bmd/ThYiiXCP6IqmvAIgypO+CfQ9Sex2hQeoQyGcZBOINANWW3DbUnp2HkE/s4qYUQpF2J9PLWveTtJmNLO1ML2oo1ZzClGakDSEFiwG2yYnlZcasE1wxjxDayiFxL2wqh9kJpepQEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=djW9DNbr; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a59b178b75bso750469066b.0;
        Wed, 22 May 2024 09:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716396518; x=1717001318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d/ujNHZnkzFsd6E210+MMTUGoW5Jl82peR2NMFbTbjo=;
        b=djW9DNbroXi7tZWgFmg/OC3fDFupkfYTovEzhTDpTRFFvmfAtb9jg8v/hcaU2LBM9a
         TFIz4oiTjhE/ktEaS8l0FBgbV9bdZa77+F6zc3Sv7VTmK5EFvuwgYfl0x2Ps0ncCwAws
         flruf1ZKaEQxG7rhDgNFKGFp8J+pUNvnWHwH3J8BcVs1ll30QPJNy/6eenSCGhbQZHlD
         0th51upptYsekE1yVds3EDvdawgJ2/zTFhDTvSIvYYY0mjskpzOGd8CdOO8mO9/jRzNs
         2FKkYOMBthUE7HJytjfRiI/XGD1X3lLIp/EvvqboD+dkwRzNbJ/0J0lGjOZKWtPPC2Eo
         6HLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716396518; x=1717001318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d/ujNHZnkzFsd6E210+MMTUGoW5Jl82peR2NMFbTbjo=;
        b=knZDP7J5KuhdROIkdOiUBpX4RDlnpvwsLLZfkiEr+OYsuzUKGvT0GJLLZDRC5icHpm
         Qu79zadYjFZswzh6GeY9HzGwT/mnDnb3isDALTwTwK4G0N/+tSvQ8NMDePvMHpIA/1nD
         QEHfDDTRoRGcgRZbwbOz7+JCVXOFvNqWe69PRViUpm5mSgiGxhMVV3WhCZ9d95JFY5Sh
         WNNL7REfVVrUH6ZPs5gGwfvJifed62EHCUNyd/fGCtFYxT6eqcIRseLM3bzr5PyCNiYd
         Kt6QG1EELBlKRmXzL2kCUpsTXP+lzIO9RSu9ma8wl4ikSjAbUwpPIAn44C1YAcPhohth
         5vWA==
X-Forwarded-Encrypted: i=1; AJvYcCX/+o9W/f7nbkALrJHUZBR/5CnXCLdRSoVkXmNHGlViYF3DqS4BcWoMuXFiC2FE+1RKH7m7notr4mns4KbsWqIPlU2eqZGX9lTzg4rnEsj+H4OdsEIKRMxWTEWDaBwCgwUPI+rEz0IYmPzeTJNAFXldhBgI3DbVKY7dd2+wlEHVcy3cbHKw
X-Gm-Message-State: AOJu0Yxz4FrNi27xpJDXZawL3Aob51rYL3cH5JAkiSxa/JsHmc6TBTl9
	tZx82vJC3p1fdocp3Wg4/2hfSill3ps1gi/evV8kcw84iBSNV8/TlqEXYVRB
X-Google-Smtp-Source: AGHT+IEAEupHubY8Y98cOTotug1q6ywUppaPM+LnKH2/VioZp2/kE/NPnxHDsawu2kYv3gqoUC75Bw==
X-Received: by 2002:a17:906:3a91:b0:a5a:7a4e:7e80 with SMTP id a640c23a62f3a-a622814ea8amr186634766b.72.1716396517276;
        Wed, 22 May 2024 09:48:37 -0700 (PDT)
Received: from localhost (host-95-246-50-43.retail.telecomitalia.it. [95.246.50.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5cdeacb2casm951212066b.67.2024.05.22.09.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 09:48:37 -0700 (PDT)
From: Matteo Martelli <matteomartelli3@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Daniel Drake <drake@endlessm.com>,
	Katsuhiro Suzuki <katsuhiro@katsuster.net>,
	Matteo Martelli <matteomartelli3@gmail.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] ASoC: es8311: dt-bindings: add everest es8311 codec
Date: Wed, 22 May 2024 18:46:55 +0200
Message-ID: <20240522164722.954656-2-matteomartelli3@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240522164722.954656-1-matteomartelli3@gmail.com>
References: <20240522164722.954656-1-matteomartelli3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add DT bindings documentation for the Everest-semi ES8311 codec.

Everest-semi ES8311 codec is a low-power mono audio codec with I2S audio
interface and I2C control.

Signed-off-by: Matteo Martelli <matteomartelli3@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/sound/everest,es8316.yaml          | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/everest,es8316.yaml b/Documentation/devicetree/bindings/sound/everest,es8316.yaml
index b6079b3c440d..214f135b7777 100644
--- a/Documentation/devicetree/bindings/sound/everest,es8316.yaml
+++ b/Documentation/devicetree/bindings/sound/everest,es8316.yaml
@@ -4,18 +4,21 @@
 $id: http://devicetree.org/schemas/sound/everest,es8316.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Everest ES8316 audio CODEC
+title: Everest ES8311 and ES8316 audio CODECs
 
 maintainers:
   - Daniel Drake <drake@endlessm.com>
   - Katsuhiro Suzuki <katsuhiro@katsuster.net>
+  - Matteo Martelli <matteomartelli3@gmail.com>
 
 allOf:
   - $ref: dai-common.yaml#
 
 properties:
   compatible:
-    const: everest,es8316
+    enum:
+      - everest,es8311
+      - everest,es8316
 
   reg:
     maxItems: 1
-- 
2.45.0


