Return-Path: <linux-kernel+bounces-373584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 506639A5913
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 05:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E78DB1F21E20
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 03:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658571CF7D8;
	Mon, 21 Oct 2024 03:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="fLO/jgjl"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4030F1CEE9A
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 03:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729479724; cv=none; b=UcvQgEikZKeNWwxT2OH290Ex2wP8p/07POJnidVpcOFoCnxYAS+ybfiWD0m+nVgs13FD6yI82JSMt+DFmTFes/kIalKO3JNE+L/xMRADWm5qFeUKXqVK0jOUDhDQIedJwmFNcs9QoL++B6kIdDQ81amVLN3akkb4PKLZZwPNCLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729479724; c=relaxed/simple;
	bh=+1oPmQQZYYyTlzfu+WalO7jQocFIehp8SUptW/y7x18=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=SDzRKqhiEd3GFKigRXeaQLlfCf7uQI/6mJHXdWehfaFhHYPFYheR9RqBTnk9h4wTZzuCQJ4sJHoHWVa6Bpt6lRUZ5yxEYJpE9M+4+nu1GJkHFh6mXPJeyaUr+4BsmS78J87Ccm7bw6M+R+bvxVghhCRjn/EM+6wPdWzixlfvMTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=fLO/jgjl; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-717839f9eb6so108291b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 20:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1729479721; x=1730084521; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RwvmpL8qKj3SLwmzOmr8dF0fJatg9G7HpxkdxZupeyM=;
        b=fLO/jgjlyBpP3gZ3zHw6uL74qNwZhJgu4vF+fc8xhGaIVmSVFawUe/+YZOHer7WKU3
         n4znyMptFymdwUiIkQI/9jxlJfRZISDwbl93qJ147yVJmqomdutWdPzha3fpOBe6BNN9
         /mOngtKBU2OfYcAST+ShGOIoY6V07o5v/bBf/XBQutV3gUOGhiXenJoJ5WEA91MFtACd
         yQqpr54RQYRs5OgMt9fvtd6aFFSKznUIjulMYIkq3avdk7/zWg0u+/4NII0va4wgmL00
         1qMOTIfGKayGEMds9Co62SuFniWfYV4/iH7PGXc1ND3oobn3ajh/aC69NRJIccuMCMZQ
         L59A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729479721; x=1730084521;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RwvmpL8qKj3SLwmzOmr8dF0fJatg9G7HpxkdxZupeyM=;
        b=vDAhSu4UvMQE1XjfrrzHYhzuIH71kYrQbrOH+lNZvoy9C9bmKK7ezWLay9+jeNQ8A4
         Urs7dkLTxB0c4pTWOxg1ZGFoFyZaWVE5tvcfMnll6roJ4U8TEOr2I8DVR51s1w54225A
         Lk8ff97MTFrtBMc0p4tePUL9u8+rFGXAwank6QW2BS8yDv6wRyffPOle/2w+U1b37HOR
         keQ36Kc8ii1UlyCAhTZd2J68aj23IOwCdqURfnlwVQRbIUrK4+9fD/eaywkHyBLmPjei
         QHu0qRhn0Mv1fNJjQNZ6Ja3OGq8VAYS4Ys2JDHhw2GXfcAkAMDV9ZVPOE1jNMCVUKVit
         KQ9g==
X-Forwarded-Encrypted: i=1; AJvYcCUa5RBahD4h3JBe7SoXICI1w1FzByRArR4W9Ns1Pv4I6jfZNdbTgMg9W4uCe7w0rXe8VoODSjsXf7Pm6NQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfLDkY7G8M2kenFapVf0qxdUSGy1JMJaYgYvhO4Fli8bCyolnr
	WdRKnXm0lQwYHygVPwgIMOjgNJ2rE7IwQgcnTIg/v3L1vWePmv81admo7lm1/lg=
X-Google-Smtp-Source: AGHT+IHbWlSXkhTf+Zn+HTAPr4tp/WE5z2N/4rjBqzeFRCPxylG6iEA0iZI+/xW79NLFCM34qxB4fw==
X-Received: by 2002:a05:6a20:3941:b0:1d4:f5e4:6a9a with SMTP id adf61e73a8af0-1d92c592a15mr5971583637.12.1729479721426;
        Sun, 20 Oct 2024 20:02:01 -0700 (PDT)
Received: from ubuntu.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec1313fb5sm1815601b3a.7.2024.10.20.20.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 20:02:01 -0700 (PDT)
From: Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>
To: devicetree@vger.kernel.or,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	wenst@chromium.org,
	hsinyi@chromium.org,
	sean.wang@mediatek.com,
	Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>
Subject: [PATCH v3 4/4] arm64: dts: mediatek: Modify audio codec name for pmic
Date: Mon, 21 Oct 2024 10:59:38 +0800
Message-Id: <20241021025938.676-5-xiazhengqiao@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241021025938.676-1-xiazhengqiao@huaqin.corp-partner.google.com>
References: <20241021025938.676-1-xiazhengqiao@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

change `codec` in pmic (in mt8186-corsola.dtsi) to `audio-codec`

Signed-off-by: Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>
---
 arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi b/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi
index 943837f20377..13e464dac1be 100644
--- a/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi
@@ -1276,7 +1276,7 @@
 		interrupts-extended = <&pio 201 IRQ_TYPE_LEVEL_HIGH>;
 		#interrupt-cells = <2>;
 
-		mt6366codec: codec {
+		mt6366codec: audio-codec {
 			compatible = "mediatek,mt6366-sound", "mediatek,mt6358-sound";
 			Avdd-supply = <&mt6366_vaud28_reg>;
 			mediatek,dmic-mode = <1>; /* one-wire */
-- 
2.17.1


