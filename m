Return-Path: <linux-kernel+bounces-422074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF2E9D942E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 10:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE230B29239
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 09:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD961D2F54;
	Tue, 26 Nov 2024 09:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="k2w87Jjk"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236C51CDFBE
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 09:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732612880; cv=none; b=cUnEmVs7mRmzdtKZ2UxdU9Hk78rCCsV1tPdAHoWZaHVl5UBx2+Ux4q54FvGuz4dShu/sW5Cw4mA8b7ScpgZz9XTQtevL6wSNxzfqozQtGa+2jVyJaoxMAKC91RgLxx7g1W6Qun1WqEdekh602fYbshh0HBq1Ryc2K+KstQlmZZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732612880; c=relaxed/simple;
	bh=peR4Vif7woHWK7GGXYa577M+2RIwJeK0uX7OsLiQUiU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hX7hNrrr/b4UaZEy8hGdffTwdPh7F/TC20QQ53D8SOUQYBdbYyFjov4zw2xT6dsgipH4eD0sj5hsPR2ZiJyev0epWwDd3Wbv2nWWID8zaFvvlkFDrTSHcCD+ICpaQeeV0NAQMfBrOXVgclF7gEeickHcLRj+u1J/1Tlgk5mNd6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=k2w87Jjk; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4349e4e252dso18860435e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 01:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1732612876; x=1733217676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sn4qpT/iGLCOuVRl/HhbV74eVKZi/FzZDWa4nL4zSFw=;
        b=k2w87JjkHiabvDLC4jaRhmjbfFPncA2OiY4Gaxwqmhc5ne188YaKHCRXNjLeianRqW
         1493NnWQGtdSNN7Axs8Q3bg5IWUWBQcQm4koKNyZAfBQK5lP9tnG2IWpSf8ULwHhQK2p
         x+3wNDSM2BDkbdFDIqnl1mGB2g7zjbqy6FGGotYxIAHz90d/iw9dWV1N4U8w0wm+hvbt
         PrhPOrvOevVl+8ZO9I6tY6+yZDQ7vippzhKOM1YmjuuqY4X2HfkZ+rGlW2KcMSPbtR0Z
         q/iPzepPY3vNz1N5Ec4far7nRrhIgx3o5mpIdhRuY2o0EFGRlTT1+oGZwsyN6rN+GIlL
         aBhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732612876; x=1733217676;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sn4qpT/iGLCOuVRl/HhbV74eVKZi/FzZDWa4nL4zSFw=;
        b=o2q7JmlBkT1WrQ3X+cYDpkUCDQwS19hnC0ni7EgwgkLMYWPDin73GTzjKdSWA4qrMx
         hhaTnWDzwSF/g9i+tj6cw0rezleZTXMKKRRJ45l0ppW8cGsAbAeJoRNhxI9AX4rfGJ1C
         Xgh3jrEukn4LO0Ov0KnWQUr8HTc3Zd+SXN/Y1D/4jKI1kAEB21XubTvQFsdpkkXEs7N7
         sp7nHvsAo8tzzv50RghW4aHM5d/wrHZfzir7Iox/zsXaxsvihKY1z8KEGfPFDahTPdkN
         YPwOePXZIE0aW/KtOkCEyOcTwLlpKAByPuIamHmscpuv9ixf+KMTliEPqaNW+QyGLTpQ
         wp1w==
X-Forwarded-Encrypted: i=1; AJvYcCUk14dZmQ/2tH1LkdAXxUwZf4BZWY8TA8CuDifLnm6glW3XfVVsm2WEEcWitXXbzhoKWo7Mckqq6YWAKqY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoJ6kVFdVhWvaudQygRIuugm9DRk5lf32myUzr+8Acgpx5bOz3
	XrHwLDidFVpUojLc/E/wAEevSzkxQ1DOX7ivDQf62MAjy8FcX2HH9YPB0GLj8mE=
X-Gm-Gg: ASbGncsfi0vCa1t6+NPE0l+9u3dgimJRyacL3l2eglKL7QO/CbQLhB6RgTBj6Mx4bgX
	47dn9MyvLHaD8XzwA2RABzSERfcb/gi6liDYCCZkv8se6PvbpjV8I32gOrGk2vHEHZ/bufGB4Vd
	jgu3I7FXUc3u/jyfuRIzaxzetDcQHUEIETSpZZTdLeX6yn5lt7IP/53q6VtCgepY+TVVy1TSit4
	h/MO5au9EbVQTeYRXh2H1gDTKHay5lI7dOwNuYMFmNg5JRtjV/K7arK81fs+S5HNJmxjvEF0KOf
	NI8=
X-Google-Smtp-Source: AGHT+IEownUh3zO6s9pCDV0Clvw+JlHntDQwx/j8qHfP92J8/y9dWvLESVOAtn+7QOc0lvgJXmcboQ==
X-Received: by 2002:a5d:5f4b:0:b0:382:1831:f7db with SMTP id ffacd0b85a97d-38260b59bc9mr13021685f8f.19.1732612875617;
        Tue, 26 Nov 2024 01:21:15 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fbc3a47sm13027694f8f.73.2024.11.26.01.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 01:21:15 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: vkoul@kernel.org,
	kishon@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	p.zabel@pengutronix.de,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	gregkh@linuxfoundation.org,
	yoshihiro.shimoda.uh@renesas.com,
	christophe.jaillet@wanadoo.fr
Cc: linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-usb@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2 06/15] dt-bindings: usb: renesas,usbhs: Document RZ/G3S SoC
Date: Tue, 26 Nov 2024 11:20:41 +0200
Message-Id: <20241126092050.1825607-7-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241126092050.1825607-1-claudiu.beznea.uj@bp.renesas.com>
References: <20241126092050.1825607-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

The USBHS IP block on RZ/G3S SoC is identitcal to the one found on the
RZ/G2L device. Document the RZ/G3S USBHS IP block.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- this was patch 09/16 in v1
- collected tags

 Documentation/devicetree/bindings/usb/renesas,usbhs.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/renesas,usbhs.yaml b/Documentation/devicetree/bindings/usb/renesas,usbhs.yaml
index b23ef29bf794..980f325341d4 100644
--- a/Documentation/devicetree/bindings/usb/renesas,usbhs.yaml
+++ b/Documentation/devicetree/bindings/usb/renesas,usbhs.yaml
@@ -26,6 +26,7 @@ properties:
               - renesas,usbhs-r9a07g043 # RZ/G2UL and RZ/Five
               - renesas,usbhs-r9a07g044 # RZ/G2{L,LC}
               - renesas,usbhs-r9a07g054 # RZ/V2L
+              - renesas,usbhs-r9a08g045 # RZ/G3S
           - const: renesas,rzg2l-usbhs
 
       - items:
@@ -130,6 +131,7 @@ allOf:
               - renesas,usbhs-r9a07g043
               - renesas,usbhs-r9a07g044
               - renesas,usbhs-r9a07g054
+              - renesas,usbhs-r9a08g045
     then:
       properties:
         interrupts:
-- 
2.39.2


