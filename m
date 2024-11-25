Return-Path: <linux-kernel+bounces-420577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7419D7CD3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 09:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A9B11630EC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 08:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FBC318A92C;
	Mon, 25 Nov 2024 08:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VcvCHM+5"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0135516FF37
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 08:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732522905; cv=none; b=L7U5axl5o9KJF5jcfbvUw6Vjp6Y5OjItmQlUegp22NPs3g8wib1qq1BWoNm1EGhZe+RlqgJ+ZrBO7wjjXOoMzoIgQ8eMUWeiWvJlKQgHimpA0myNE9VgKWpaS8HJHIeYacLbWP0cDJGjitUjoOBTMbKhghwl94eR3lwokMMWKCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732522905; c=relaxed/simple;
	bh=+k4W5kdm2/R91a0sqKatP50hzxJmlQq0DzlqB+BMlgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gXjOnx2KzHWuXhZFZi6QFVmoy5epoKY3UptRTMslbTqFJlJnVQdGcI2M4kfIFCyf+Sqg9umovd/HqY/5gMGR72Yz2RtON2TDvrWeD6XdefaCrqm896sW8NtTJrUYEcp1SRAxhVfsJI6M/A5Ws1Mx6H4fu0dDkfeJ5SSRPWNA2fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VcvCHM+5; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a9a0ec0a94fso596451666b.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 00:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732522902; x=1733127702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HPnYr8aIDFby+4dgQKR60j9AMYM1qDxkn1rBoSKaia4=;
        b=VcvCHM+58eyptvLKPGBpDtWxRc2AqU+RnJsB18a45GS4dNKfwmb7CqIr6Ez7dXZoim
         iqzIcoZUfDx3yhnGRjMa5j+wZ2J1LaIV27iqVzqgiRF1KRD06LyqQfPwehj4gMVrOVz3
         tnYncc5Pu6DCNA06BP9smZYw8wb/jAVlooNOI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732522902; x=1733127702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HPnYr8aIDFby+4dgQKR60j9AMYM1qDxkn1rBoSKaia4=;
        b=CLlIRtKSR0oH6kfS02TjLfc13/6uF9hMERenOXY49DHwUa/SJlKuN+VxBq9eHZilmA
         pOcB8Retd6DHh6fIKa+1v1ijgbJRI2kQL56qV8FM1qgygLiu/CsRlr1S/6YvY8ttjso1
         3NSB3MzXorw8odBLKQJEHmgQ5/r+4YYTdCADdgv0cjMobvuOfTwgwCmGQn74L9T0sD0/
         zdXIB09JhZmLM97u+EX9Rqp6Wi/bhdhIrqDry9CaRQT760BEpiWBj9M7He6AczGc+xCl
         XGGNLMK87nQ3TpNUoyLiBC8Y5exvp4A+BZjrm1S6Upn/eaCn8vDhokt91HzLfUub/vg7
         t/tA==
X-Forwarded-Encrypted: i=1; AJvYcCX44Z/tGXfcyrvwTenhcI1ZOUCG2w91j76AYONDyC7tA7PPE4TlIrFXPAnRwUYvb5pqb+mL+aFwemHjN6w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqbEapL0XAj+sPItf5ufCbq96JElxC/KJ7cT/6XcGlJhLecll3
	6ZarazeDvABFHEY383/8wI98s7mQeRsXryGlSJEKZp+Sx2BB1tvOLozpELAdTQ==
X-Gm-Gg: ASbGncsbu7Iu97aHgfBXzBQnOv3hwdH8pRIfwHxMhrv/vPo2fRXoUaZhSQe5TLsscqu
	jonEBH/+3RwUb/oH+ZW283EvPUwnONBloEeysVNL4HelBL8IytreLFdKHQhko6ey5aTo7ymgvJ8
	PQJnHIRV/UaPoWtrrJ+rQ+5LABB24poaX768A29LiWVLJNJXUlIWmDR6GQIL0UZ2C7NFkqxa1kC
	AoPcr+6fUrvg+ZMQsJH1TAt8ICEXGI13SxnqQwBVaVWw69xk5A0TJIysrUDeaIC+T4WvAj7UDcd
	tMSDwFZJ
X-Google-Smtp-Source: AGHT+IFnAzkhOOadrvOXWSDGzf+kPfjLpDwohhUu4l6LeAbOtGTBnyhEYnIeoSDJDix3CiMDzFUNxA==
X-Received: by 2002:a17:907:7712:b0:aa5:1699:e25a with SMTP id a640c23a62f3a-aa51699e2e7mr827925366b.10.1732522902261;
        Mon, 25 Nov 2024 00:21:42 -0800 (PST)
Received: from localhost (30.171.91.34.bc.googleusercontent.com. [34.91.171.30])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-aa52e45391dsm318503166b.60.2024.11.25.00.21.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 00:21:41 -0800 (PST)
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
Subject: [PATCH v2 1/2] dt-bindings: arm: mediatek: Add MT8186 Starmie Chromebooks
Date: Mon, 25 Nov 2024 08:21:28 +0000
Message-ID: <20241125082130.2390310-2-wmacek@chromium.org>
X-Mailer: git-send-email 2.47.0.371.ga323438b13-goog
In-Reply-To: <20241125082130.2390310-1-wmacek@chromium.org>
References: <20241125082130.2390310-1-wmacek@chromium.org>
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

Changelog v2-v1:
 - Fixed items/const bidings description in mediatek.yaml

 Documentation/devicetree/bindings/arm/mediatek.yaml | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index 1d4bb50fcd8d9..6191a5320c148 100644
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
2.47.0.371.ga323438b13-goog


