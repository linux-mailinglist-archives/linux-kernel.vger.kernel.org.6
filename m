Return-Path: <linux-kernel+bounces-422190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5AD99D95B0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 11:38:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD94DB23125
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 10:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493C718FDBA;
	Tue, 26 Nov 2024 10:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UAOJt8hK"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09A51AC44C
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 10:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732617401; cv=none; b=YfITGW1A15H2EzLsUFfY7GunRZsD7FTLxlA8mE+dArRam2vUsCWs4QgXXEI6Sy1ff8yKBzJy7j6BpLcsTgtRrnCAuqdJXvxD3J89oSdU7E60KVbLMljWY8HChHthxLu8ghiAfQQY0S8A5/kwVv5D1OIrMs/caqXeB3vDbgPI548=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732617401; c=relaxed/simple;
	bh=BsqWy7SH6fBo4JUWOSufZPC3a0rKIB/JoNnTL7sZ67Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WAKEYcGuSzTxVfg5hfRn7Mi5T7lHQumKORA3wyVd75WniSUyIWlanJ/n7tiF3njpP6gxUPzCxdWAUVmubtWIfvG6tFZCS/LaTxsevWHglI5Bx7rWdFkFD2DubDCGSYfjLZycgFtN4aGrDNw/aLxvdPc5MSBYRWbOgYb0+aDeeVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UAOJt8hK; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aa530a94c0eso475223766b.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 02:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732617397; x=1733222197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iX8xzwbYhyoqhIB2hSc4QZ8h9QtVSz/pkj+4ftY5rkE=;
        b=UAOJt8hKUakmDywUi+o49mNA3FLX7zbDboj517kqHIGoQr2JSiglEYj9dvJe1cjN0b
         /fSo4uBF3zPKPhtsX0y1uF/c+JN/zoMAeo0yphoI9/s3YBeL/wl9PK7XYVPqUdErwZ+r
         +ebCiOFqD67VLbTkZoDhD4Q2uIk/e0P18cqWo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732617397; x=1733222197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iX8xzwbYhyoqhIB2hSc4QZ8h9QtVSz/pkj+4ftY5rkE=;
        b=RShBPCh1cfudt+56CDJjgIqED0Dc5nbQ+/u13OX4c/2ahCHUd9aEuflDHL6lOjzthA
         mk9Z3IkAdQusqFEUik7o0Dk8QopOnmATHIYM5+vQ2Jh6ELkNSofL8EV9bQljS1VEmNcG
         KDw1gv1oGVskKWFr8upMU7tD+iCJKIG+hKaAYMIMwUa9awMjNyKdRZpBCacyDU6c8ACH
         UfRnqVUSy+W45IPUcgLi1VL+UZZ6fxrmPZ7pTL54IqMVQe24ipEp0MY7TUmq3afbEWmv
         zgBJZ6AfGwcuSve7erXSAxXVsAqDtMnmsnj6gljF5BJ1gfA5M1HFgPueMJsI/+9DKrZy
         /29Q==
X-Forwarded-Encrypted: i=1; AJvYcCWC63eD8po6jJRgXEmKUHjQchXO2TzkjRip1n2DK5aWNvCDgqMMef18ApXtZH9efy4MVtIrPmB5PJHzRyk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg1SkPHP5S/uNf5GiWCWsGtc3WAfYOILqkBGwDtfJ29P2A9vSE
	43o5obExZDQPAp/043iLpdz40r1wmMm1zBnVuiS5xquVp8CmIRtx1op81/SJQQ==
X-Gm-Gg: ASbGnct/5s2xjE6pAPiES0x/3+sslEs0OKPpcIIN6yJsDY2jntNyu4/nD5dgVATD+9L
	MasJ5Z5c+M1Lf9eirOa50QnpseYFivoJwKCTvc3S7QRydJfsMTA5VJqV5hitdTtGr51zk9OG2Cp
	g7/ns9yLkL+4XDj89d71BECn/lK0jQ52TFeXeSRQ4topkoSJ0UhZyl8SOBgm2QKkkBtfBKiWU5Y
	t1cLodiO7LfxtQV6llYaiW2w0rOdKSBHNYzDKV97cuSc6wzrpVFpXBtwoGGSeltgOmW47N5Me6H
	Uhz1neZq
X-Google-Smtp-Source: AGHT+IH7pzt4uagb2/yHSWvl5yYjrOK0GvCI0T39Co0MwSq5iX+PgtgIfkrdFxk3mxGtBSslu+TfUg==
X-Received: by 2002:a17:906:308d:b0:aa5:4b7f:e705 with SMTP id a640c23a62f3a-aa54b7fe8bfmr702146366b.1.1732617396904;
        Tue, 26 Nov 2024 02:36:36 -0800 (PST)
Received: from localhost (30.171.91.34.bc.googleusercontent.com. [34.91.171.30])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-aa54afde284sm292271266b.17.2024.11.26.02.36.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2024 02:36:36 -0800 (PST)
From: Wojciech Macek <wmacek@chromium.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Chen-Yu Tsai <wenst@chromium.org>,
	Rafal Milecki <rafal@milecki.pl>,
	Hsin-Yi Wang <hsinyi@chromium.org>,
	Sean Wang <sean.wang@mediatek.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Wojciech Macek <wmacek@chromium.org>
Subject: [PATCH v3 1/2] dt-bindings: arm: mediatek: Add MT8186 Starmie Chromebooks
Date: Tue, 26 Nov 2024 10:36:31 +0000
Message-ID: <20241126103632.419469-2-wmacek@chromium.org>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
In-Reply-To: <20241126103632.419469-1-wmacek@chromium.org>
References: <20241126103632.419469-1-wmacek@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an entry for the MT8186 based Starmie Chromebooks, also known as the
ASUS Chromebook Enterprise CM30 Detachable (CM3001). The device is
a tablet style chromebook.

Signed-off-by: Wojciech Macek <wmacek@chromium.org>
---
Changelog v3-v2:
 - No changes
Changelog v2-v1:
 - Fixed items/const bidings description in mediatek.yaml

 Documentation/devicetree/bindings/arm/mediatek.yaml | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index 1d4bb50fcd8d..6191a5320c14 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -263,6 +263,19 @@ properties:
           - const: google,steelix-sku196608
           - const: google,steelix
           - const: mediatek,mt8186
+      - description: Google Starmie (ASUS Chromebook Enterprise CM30 (CM3001))
+        items:
+          - const: google,starmie-sku0
+          - const: google,starmie-sku2
+          - const: google,starmie-sku3
+          - const: google,starmie
+          - const: mediatek,mt8186
+      - description: Google Starmie (ASUS Chromebook Enterprise CM30 (CM3001))
+        items:
+          - const: google,starmie-sku1
+          - const: google,starmie-sku4
+          - const: google,starmie
+          - const: mediatek,mt8186
       - description: Google Steelix (Lenovo 300e Yoga Chromebook Gen 4)
         items:
           - enum:
-- 
2.47.0.338.g60cca15819-goog


