Return-Path: <linux-kernel+bounces-523338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D1ECA3D554
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 10:50:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 979FA3AF46A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 09:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849901F1934;
	Thu, 20 Feb 2025 09:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lax5Rt0T"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCCB1F1517;
	Thu, 20 Feb 2025 09:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740044725; cv=none; b=dOmaofu89pNKy5cjZNqHlI/aV7PUxsjkiSLoRGiQNIAzN/FtlpzNBIpZaSuY6m9Zpvl4fzsyiuD0jWoXBxGlel0XhQiLz5V9MW4lRK93qVPKDW0Sax1izDy67Zl4ZoNYeqjAlN7JNiR/aSwx994s+SUdOjddOcGIBkXiqNiq+PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740044725; c=relaxed/simple;
	bh=1RYxrboSGf1EhWpjGi5l6akaPn/GrsR37xr33T6lKEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MXPEgPyt+bX4CufbJQZSuYzrmXwWF2PkQnoE3lsFEmoc6ajo4dttleswQywo1UFl6OJj34dC4UOlnUmpFL6HNSTKnz6iAZ0odfDvOFrGj3dhpQrSGo7EtpCQxS6u8VJMKWqbk8HIQng+PpGU12re+lJ0Hi+v/ZA7q631FhSc1u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lax5Rt0T; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-30738a717ffso5614831fa.0;
        Thu, 20 Feb 2025 01:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740044722; x=1740649522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uP54MxAad7BaXbPMxMjCizUh7J0Y3WSL+99INsIzw/Y=;
        b=Lax5Rt0T8OiTUURwxnWb7fYXHS52QdDvdf3PwmxEDvjwO27X1tuBMPi3SeZgobKuxm
         nZdEHENtQpykEclvpNXP7klotv0fMMpD5bPv6UjwaQF84ZN5bOHa8Guzcrk1ZV7L5FYV
         H0GBu+swTGhBP+Soec6s1SmvtTlWMDtVGgAyp+ri3wH8Ii6Hvbvl6vd4hjC5DEHj0vRj
         l3lNNEPP94nK1CpDfDhRkgEKzwMZrjQEyVxRyhlxn5Kh6N7T60OLUFqXVEz5zF88Ee4v
         n3u9KqxexK/OnnQpQHdyXj7DXgLHNOSUhAEUceiBs8tqCZxhPJGOUOEumbfxkuF16Aww
         71lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740044722; x=1740649522;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uP54MxAad7BaXbPMxMjCizUh7J0Y3WSL+99INsIzw/Y=;
        b=j1QuTP7XtzEC+wN9Df70wZ1eKUD3TC5/k0I7gqPc+EQBsGOA/XKhFg0IRbbjVec5QV
         eQJU+I2N3sGMLSeS08gGZtIylD45gA8MPzs+dgG7pbFMZz9VjdJMezMUMrmOtJzkI8wx
         vp0dGVWJqDnOQEaVpFEcmHFOOMawTxuZoV8ZdXN+Bc+NIMc+uh/tp+KSM5zsKLviK/h2
         wwFiFRvT+t7nwJF5XkbJUym7owqw6kX3DsmhRqbvEPofAhuEj+jm8WAfDzy6rOSlMyc2
         a5y7HGKAdVGeezsiMG92tFQ1jbwiooWhkkD4B33ZojhdMTe0jOyXShhb52p/lFqS4LmC
         rIxw==
X-Forwarded-Encrypted: i=1; AJvYcCVqP34NPPG010UqC67cs8jAneNrFa1PLiKBMG2bW8LcqVwPtTyRWtzhoZw0Spv+sf9WAuyd4p6gKwrCPv8L@vger.kernel.org, AJvYcCXTk/HwF9NtBn5NK2D1IEp7a68S7WODyCSJTS+LMD1AJVZMh4z3oWmH9wuHqh9Iacx5mzPTRuDvD3op@vger.kernel.org
X-Gm-Message-State: AOJu0YyHMCcWrBrvvLp+nSeplw2jGeL8Z+mkvU2S+Kf0qjChCsFA7dBb
	l21Edh3MwJ+OOXuBcEJDGMZ9f64kOm7iDRQsQh+DBIT9bXS3djcS
X-Gm-Gg: ASbGncsPvej0zNYO+NCexARyHIVYiU514ocBx1Eucnote1MqKx8dQOVVRUau69+ZG7r
	sIHDiAGr71RJcKNA9SgIs30ODyZB9UA7N7qsJPZQAYuv49KQkv26vKCfMWlDIWFGxoLIXg1LVMe
	BB/J7FYk05UyyI0rQJE8zLp3lY0wJDqYifrN5t+4JBjVYT2mFwtdU4zdOXC1CaIUTdX2wKpsPKW
	+3l9Ghn+9Y3u8n7LCRkLTCce/vFg7Sel/laOkemBTFXkwCVpF+T8VcqdID+Ekwr6OFYji2PKUHh
	YYJREeo=
X-Google-Smtp-Source: AGHT+IGynhUbFTfyxxBWfbXmMmCDaqF1917tHAA6gMYameAn0opOanGEOqnUwdwMb4P3bXUnPGGPqg==
X-Received: by 2002:a2e:90ca:0:b0:309:2627:8adc with SMTP id 38308e7fff4ca-30a51fee6fbmr4684441fa.8.1740044721730;
        Thu, 20 Feb 2025 01:45:21 -0800 (PST)
Received: from xeon.. ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30a3a0d1c2bsm9574311fa.11.2025.02.20.01.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 01:45:21 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Maxim Schwalm <maxim.schwalm@gmail.com>
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/3] dt-bindigs: display: extend the simple bridge with MStar TSUMU88ADT3-LF-1
Date: Thu, 20 Feb 2025 11:44:55 +0200
Message-ID: <20250220094456.32818-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250220094456.32818-1-clamor95@gmail.com>
References: <20250220094456.32818-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A simple bridge used in ASUS Transformer AiO P1801-T.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 .../devicetree/bindings/display/bridge/simple-bridge.yaml        | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/bridge/simple-bridge.yaml b/Documentation/devicetree/bindings/display/bridge/simple-bridge.yaml
index 43cf4df9811a..8308e833938d 100644
--- a/Documentation/devicetree/bindings/display/bridge/simple-bridge.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/simple-bridge.yaml
@@ -31,6 +31,7 @@ properties:
           - ti,opa362
           - ti,ths8134
           - ti,ths8135
+          - mstar,tsumu88adt3-lf-1
 
   ports:
     $ref: /schemas/graph.yaml#/properties/ports
-- 
2.43.0


