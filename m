Return-Path: <linux-kernel+bounces-447524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A8E9F33BF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 15:55:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0811C188956F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 14:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B364220765E;
	Mon, 16 Dec 2024 14:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FwjHKa4z"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5468C206F13;
	Mon, 16 Dec 2024 14:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734360683; cv=none; b=MBfTmH96inodUbk1DpTS4fFKU2UcokCrUd61QP51lKQpctElQUmGO1xx3lUJD2U2r64dnXoElbRZn+0kXg0vmAjnAmrBOIRGK1AWpTBRb8SjOLkc7VnYIM1BitesHHfnCdS329vjikQU+mqN+1cJ5UtikGY2aP3BGqknNrG4GOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734360683; c=relaxed/simple;
	bh=cWi8DmSi7C7RoYGebBs9V11KbEf0JwdrdWWSFkvT2/A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WVMwBkIraI+/55B2SGFHam3XTzFp2G7nlLiYpLDbgA27QCL29Hl6heoSTJIGWUtUbN4Oq/rhlZ70lcQOoHNxe8LGtPa7ApoNEDXMH4+K8A6q2XDOUrc9h8mLrgYIhQT0AnRuK61IIhqt7IUwAQWdgaNafMlxiATqdXBfzV7CpjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FwjHKa4z; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4361b6f9faeso25871995e9.1;
        Mon, 16 Dec 2024 06:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734360679; x=1734965479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3O9xjwYbMuKJBMh8JPk0dRAP4OjyngOz+BP2VQZxpdg=;
        b=FwjHKa4z9bVQ00W0B9aJz17tVCt3Gyp2YMWylEm6vpuwUPQcFNYjinZlimamqvHfGy
         sFR/ywTmtjwfh7t8O9bnLclPPhoUEulw4XaeyO5npijcOpA18H+cPI4Bdl1BDWabiOVZ
         QFj1dhz4GZ6tXhI9e76BQZYgzM764OU/4Y0QsJ3gYE8d3gbVtt7NeGaMoH1l0bh4r/xg
         vL8lIWuHUp/FAVzBV0/Bf1oniuy58grKH5X4nGInaUpL67+ClRFweFAh1F2mjs9NL7Rz
         rx43sVk7KNxwtJIBULhEB8fZaOZhSGlZv765hXO+MP6vBBdgfZ64uGJ8/q9caE/FUUkV
         6m6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734360679; x=1734965479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3O9xjwYbMuKJBMh8JPk0dRAP4OjyngOz+BP2VQZxpdg=;
        b=h0VQAQAMAXxLA8zCHIooNTASzNoqU2FVNoJyjC4Pa9VbL/72I2LQ4cZXg9z6mVMSRI
         /vU1uW6fRMDq0DjncYU1o1V/zGoS0Cjpo4BRmf9MzESIZcv1xfQrkEeZN+Hyxbb1DDc+
         1a4TvNqVOcm+PXsP2oNjvPLiYYIs91utCap9JXuQuWq9p7/sNQv+FZGJswFkbx3RYlQB
         y/0/kvvOmnvKLBvMDmo6sy8cIszTpDfmjsG8NtSiCz0SzcrdBalndMkNp48CIJIGRH+Z
         32SEIZRBENE7l1+HChSn8rTjHkGXgI42lhnC/BGT9dklg4tZZb1SqQXDKvpDdRlRquK0
         Bstw==
X-Forwarded-Encrypted: i=1; AJvYcCUXnLpkzBR2q5qlGAiEt4pFKTk2sfjEKYY8BgRowQrnYaNq8xbgDOAliSVOIHuQ6BvKL9ThDaPKXY2xcfLv@vger.kernel.org, AJvYcCVL6zR89n1oS5o50SVU99QTYrR4Lofzcm+sRe7EzwfwTtodxo3AtKvRfDnSgzQuQ56WrmwPoYATrMarUjc=@vger.kernel.org, AJvYcCVUVb/872CTRpDnzc9b6ATLVnOYaDIN+1hR1GXlPPj88RFNWjFfBzGojLLYPHw3ovOfNgTV4NI2h/tx@vger.kernel.org
X-Gm-Message-State: AOJu0Yzkmf39G3n+JBKposxpv47Vz9J9Z30yE+/63JtGzGK6W709/g8H
	oZZYqRuqaSYF3ku0rllLjX98i+IMyUrzaiIqV3dFNz9zkBmrlG7b
X-Gm-Gg: ASbGncvfupZV2aCeOGljn6KLwdopCQ9mRrDmPsVWkBrCzj4Cvjmo08TBNXwGqoEZaF3
	pAKAblWvb7bK7oO8IOSU5/JC2q+1HzTGBZ45lyJ39nGZtpZmSIDxIuomgWW4PR0k2jxTwmLxJ8J
	2SKghs72DC+JlPUFK+plJHgl2xE9yY5P/n4UUTvOVA+Ua/e/QtN+8PBjP1YZODBD9izbkgNmBN7
	8pUwoIZyQPGxrg2VLcKW231B8RCJhlbX6QpNSZyws/CgURVj2FDEbljK3ZaIVgSnoujkpyxyYAL
	7qMls7rtBPLLBDMH
X-Google-Smtp-Source: AGHT+IFA3RNClGg885yiYlISYsYOJeTw1Fd1eRv96uL8DaVCl3QiM+cW2wRgxshrWVj5DiQhXeuZ5w==
X-Received: by 2002:a05:600c:1c09:b0:435:edb0:5d27 with SMTP id 5b1f17b1804b1-436230bfd93mr136287915e9.9.1734360679587;
        Mon, 16 Dec 2024 06:51:19 -0800 (PST)
Received: from playground.localdomain ([92.120.5.10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4362559ed6csm141616455e9.24.2024.12.16.06.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 06:51:19 -0800 (PST)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Mark Brown <broonie@kernel.org>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Takashi Iwai <tiwai@suse.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Frank Li <Frank.li@nxp.com>
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-sound@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/5] ASoC: dt-bindings: audio-graph-card2: add widgets and hp-det-gpios support
Date: Mon, 16 Dec 2024 09:50:37 -0500
Message-Id: <20241216145039.3074-4-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241216145039.3074-1-laurentiumihalcea111@gmail.com>
References: <20241216145039.3074-1-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

Introduce the 'widgets' property, allowing the creation of widgets from
4 template widgets: Microphone, Line, Headphone, and Speaker. Also
introduce the 'hp-det-gpios' property, which allows using headphone
detection using the specified GPIO.

Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
---
 .../devicetree/bindings/sound/audio-graph-card2.yaml          | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/audio-graph-card2.yaml b/Documentation/devicetree/bindings/sound/audio-graph-card2.yaml
index f943f90d8b15..94588353f852 100644
--- a/Documentation/devicetree/bindings/sound/audio-graph-card2.yaml
+++ b/Documentation/devicetree/bindings/sound/audio-graph-card2.yaml
@@ -37,6 +37,10 @@ properties:
   codec2codec:
     type: object
     description: Codec to Codec node
+  hp-det-gpios:
+    $ref: audio-graph.yaml#/properties/hp-det-gpios
+  widgets:
+    $ref: audio-graph.yaml#/properties/widgets
 
 required:
   - compatible
-- 
2.34.1


