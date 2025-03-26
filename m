Return-Path: <linux-kernel+bounces-576752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE57A713FF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 10:44:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12C1F3BA7FA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 09:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C1B91AF0B6;
	Wed, 26 Mar 2025 09:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TBSijx9f"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B8F1A9B49;
	Wed, 26 Mar 2025 09:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742982279; cv=none; b=I0STNsA1SgaimCP5xiVZdsFB2RV4q+HEoAVHmaAp8ofFlqMVBTbBES3tkrMrm9WGlZj3p/Fvz0qUA41UrR9OCKEM+GmYJYKdfZk9PSnJC1yPvhj7Uk6CLjyNdkc4fprIoGGqGtvDfHjFQSMTzmxYQGQUYPmUypsMNssFzP4uepA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742982279; c=relaxed/simple;
	bh=fdePpYKXw9iPYxZ5nJEMIVpnc6IYu5T/HOyMR7iT3mI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p7XTkpEhELSXMGy6odijLe6c8Ot+m2Trp4nPlU8ZYX82tUrgd41cpEcwrnBRbjcIYWS01Hw+frWjcWSqxE/4bc4DTb0PvBLvGXEce/1EIhlUMEQTCFua86GSJkWxIJ6EX4/FJ1Fc8kyAE4ADnGlv02Ylrxd1UjJHMJmtAGCgW44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TBSijx9f; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5e5e22e6ed2so10267083a12.3;
        Wed, 26 Mar 2025 02:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742982276; x=1743587076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LhF6R6vwCAIFOORSKjXUEJg8tNapknbDuMgOuxMh77A=;
        b=TBSijx9fDHw+qe36f2o73BSqetR5mFQBW45Z3bexqXiO0is9GR9Ky7IFJF0WyZ+QHF
         wPBVVHKLwv27tSKkdUPhsfvSCYfRk5b/nY+5aULFJTuQhptRLoWjlVIi8RgA8l/j7uAc
         mD66rNxbudkxJWtjCe/rFqeisARY0Fma5FogIUnifE7IAXDhwlZsSJZIIfyTxp+qTqud
         jc/5NZWLhT9H28ZrsLkAxbHyKbkrJgylIS7mAUv+YGL9KQnCecmwCPRPY8+jmExIsrmG
         hM9PL/1gb1vPLfXWdhJbD50N3PQAOOok48yeK5dDBsdy7Wzx5tcpzY8kJ/COdl5nfCrB
         kdDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742982276; x=1743587076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LhF6R6vwCAIFOORSKjXUEJg8tNapknbDuMgOuxMh77A=;
        b=ENAOaCZKkOrv/HKq2WRjKEZYfXWtnzHY8Gv/LiajM7cfD3PXF2yCAXx2WXgkWzFrso
         O1Es7minKZRIIZNVxbLjUmVg8Dc1rQrXUPBM8R+Q/VUiUzF3SFx4s3MAhaifAfyMUjxw
         kFvZH4MBEY9Ng6P93bGYAgfH4nUghN2nox2W/fKIFevT7y6w09tDpW+wXdEB7RAF/WqR
         02q5i3ZaF8Qv4lsO0GqcWjnnXjkPrN2YgpXIjp5tn/t3df6iTxfMblnO9oTkOnizR5Oh
         fUKaKMUClqAD6kzwpEvUCmDMjq4eMStwuvUEsiAj+62IHjR1RqQDLeiNrdNBLmTxM6y4
         p58A==
X-Forwarded-Encrypted: i=1; AJvYcCUJ9NMymUHp/xeFwddahxTEaN4k0UkM9CXmkpRIx+1S03+KGRDYENV9fHiAqvFvaltuXXUUiFvn7vR2@vger.kernel.org, AJvYcCXA4XhhWdI3NM1b/cAS737iCR5plYTD2u7QTFFlTBySkbQYDNz97CzFxzMhKoxt4mePh3yH9Xvt+oU/Ymqa@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy3V0sky/W46WSDnTR8a5fBWXnic0FUwOkRuGct+otnoE/CUAd
	n5fhENamQmBW09kadxeCorz3wMqLxZ3OGeLXA2c1UbPOOyyBwQjO
X-Gm-Gg: ASbGncsR0oIYUNnXfEc7lF+BeCDNAdtm/Uo7Iv3mJUIeWvyUBYMeSJ3ji9rHD+8W1dr
	2lVT2gZRJ2PY+UBKXsVPOfSx366zj5kMb2F+8fwyn71ajuGUPeOhym3hpMn++1sD2vJxrrDuNCh
	RURc7vvqc2XYifNnnVCyi1C4AATITnRU67dh+LC8ZHb6RfsbKkWIHUY5Nt/bpSGWgq3AcLiyPLa
	sml4bZXHaasFkqm3b6oVyA6mUs822g0tVDhzoJsVEHuMhEEDOeQH4VyinEsX8jjeaO386wAWiSJ
	bmlrU8J4epn0HSrO/7mc4KYoH1n8nu3Qe6CYbBeaEeqyH6bp
X-Google-Smtp-Source: AGHT+IFYQXx/dczxe9yMk/xq+gCXEaSFfjBpLvbptmHL8QgCOEYYRcX3+bVaYHpFvj4ivFc8M3ACMg==
X-Received: by 2002:a05:6402:50d2:b0:5e4:99af:b7c with SMTP id 4fb4d7f45d1cf-5ebcd426f95mr15941899a12.9.1742982275987;
        Wed, 26 Mar 2025 02:44:35 -0700 (PDT)
Received: from wslxew242.. ([188.193.103.108])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ebccf84600sm9120488a12.19.2025.03.26.02.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 02:44:35 -0700 (PDT)
From: =?UTF-8?q?Goran=20Ra=C4=91enovi=C4=87?= <goran.radni@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: =?UTF-8?q?Goran=20Ra=C4=91enovi=C4=87?= <goran.radni@gmail.com>,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/3] dt-bindings: arm: stm32: Document Ultratronik's Fly board DT binding
Date: Wed, 26 Mar 2025 10:44:26 +0100
Message-ID: <20250326094429.2397365-3-goran.radni@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250326094429.2397365-1-goran.radni@gmail.com>
References: <20250326094429.2397365-1-goran.radni@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This commit documents ultra-fly-sbc devicetree binding based on
STM32MP157 SoC.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Goran Rađenović <goran.radni@gmail.com>
---
 Documentation/devicetree/bindings/arm/stm32/stm32.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
index b6c56d4ce6b9..c1cb54ffb210 100644
--- a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
+++ b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
@@ -175,6 +175,11 @@ properties:
           - const: phytec,phycore-stm32mp157c-som
           - const: st,stm32mp157
 
+      - description: Ultratronik STM32MP1 SBC based Boards
+        items:
+          - const: ultratronik,stm32mp157c-ultra-fly-sbc
+          - const: st,stm32mp157
+
       - description: ST STM32MP257 based Boards
         items:
           - enum:
-- 
2.43.0


