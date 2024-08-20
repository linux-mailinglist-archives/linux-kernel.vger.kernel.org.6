Return-Path: <linux-kernel+bounces-293497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 565CD958088
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 10:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8861E1C20616
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 08:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A225C189F47;
	Tue, 20 Aug 2024 08:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UQpb6kz1"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33AC189BBD
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 08:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724141237; cv=none; b=gzyV/UoMk4p6BIgipR+4elurMrpr2bZwNNAY9FKiVa0yizDvi+d5R2YGEeqwQhKLvqaKT5yixoQgBnz2/ods47KKBnmyvrsngZ6K6SwI7oWpjhGM8HF4sip+Qwvu0o7vQrNRiTJPrG0W7IYyzgQuQ4spcCnF13YYr3BTEL8IijI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724141237; c=relaxed/simple;
	bh=HU2Z0RdQeN0837JM1G3eVaCWsVPXe1UtVEJhTaUaX58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R20XtN7ZJ5EseNaFaTraj+HIw02zvx82VacOGpIczHufK78MNaizEy3LaMwM8hADgbWK77gRcNINz0tgvTDwAkV78prfU10S19MkbwqMItsdNClfOb9+DLsqlHZVJjGtv4JMIPSZVlHZMq4zjpbiXhDiQ3FTaxV2RDiMgKnoWUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UQpb6kz1; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-710cad5778fso4293715b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 01:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724141235; x=1724746035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KkKGSAKuHmkOcXhq4rTBRZZbsedAQGMKKV0Dw3RFXH8=;
        b=UQpb6kz1xjkM3R8ypK2gRd2plOAAr0NOZUP0gd6yb8NiMK3h5l+1aRuf3vw0eyDSYA
         eX5Wzfn8wpfYwJfc81MyNIWq33wEyD3/DlwnAZxFOJ8G++yQgES/w//ibkgYheiF0610
         sfZpGdXgRSbnHn8qW4WUnEEkAuhTHTxBOIgCo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724141235; x=1724746035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KkKGSAKuHmkOcXhq4rTBRZZbsedAQGMKKV0Dw3RFXH8=;
        b=K7KLg5vhMNll23pnsWMixO48DcYq29kOMgvUukfKea3S9YaVNiei9uTR/i3wdN5T+l
         Z2jnZdvQV863xzkrZBajRU0PMA/8AEil2yLUB1gu4H6m9IqXeSVHX6Kb20aOJ+r2bJcJ
         4JG6udSZZTJ4gAku9Y9rJWuM4DuPn8GCplntnuh8StME2fc/EIeDhueP3ZCuncJaWI2n
         499LUwlnZPAd8BapFgASi24KDQbrsnJVCbEjwOnuidCB8VD0rzm/RNFp2GSzpp0I7yAf
         gLk2H1OiHdXmxMCQf/HcdCEoxJgj2JaKQAE6zL9pE1drKC5UurDQB95srPo3HIQQhU0L
         LlAA==
X-Forwarded-Encrypted: i=1; AJvYcCXhhjAAfHytrsujMBbDUXPmWH4TNHbp15cY41Fv1UngolNsPscNrvc3w0aYGtYLwVJoCoE419unDkjEEXs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjjNNWoxytaWYrcyLHwaV9aRmwDwmd/Nwt8WMH0GH/VGCkuaRU
	CuWBvyW+rfOnufBR/YcwZuhXRSZZLcjMkwwkumBzXSXwXpZOGMxHm3+gib+sDA==
X-Google-Smtp-Source: AGHT+IHwKaoQ6zqgeUDaUr0M0mia8HrEnOi0MHVVZtaxLErdruMh0fQ5zoE5wSNwv2WofQFKlv2X/w==
X-Received: by 2002:a05:6a00:2e1c:b0:710:5a64:30d5 with SMTP id d2e1a72fcca58-713c4da0349mr17959374b3a.6.1724141234688;
        Tue, 20 Aug 2024 01:07:14 -0700 (PDT)
Received: from localhost (185.174.143.34.bc.googleusercontent.com. [34.143.174.185])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-7c6b61c7202sm8829978a12.31.2024.08.20.01.07.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2024 01:07:14 -0700 (PDT)
From: Rohit Agarwal <rohiagar@chromium.org>
To: chunkuang.hu@kernel.org,
	p.zabel@pengutronix.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	ck.hu@mediatek.com,
	jitao.shi@mediatek.com
Cc: dri-devel@lists.freedesktop.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Rohit Agarwal <rohiagar@chromium.org>
Subject: [PATCH 1/3] dt-bindings: display: mediatek: dpi: Add power domains
Date: Tue, 20 Aug 2024 08:06:57 +0000
Message-ID: <20240820080659.2136906-2-rohiagar@chromium.org>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
In-Reply-To: <20240820080659.2136906-1-rohiagar@chromium.org>
References: <20240820080659.2136906-1-rohiagar@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add power domain binding to the mediatek DPI controller.

Signed-off-by: Rohit Agarwal <rohiagar@chromium.org>
---
 .../devicetree/bindings/display/mediatek/mediatek,dpi.yaml     | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
index 5ca7679d5427..10b8572dd922 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yaml
@@ -62,6 +62,9 @@ properties:
       - const: default
       - const: sleep
 
+  power-domains:
+    maxItems: 1
+
   port:
     $ref: /schemas/graph.yaml#/properties/port
     description:
-- 
2.46.0.295.g3b9ea8a38a-goog


