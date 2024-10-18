Return-Path: <linux-kernel+bounces-371321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0DE09A399B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 11:13:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F0A7285504
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 09:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2111922E9;
	Fri, 18 Oct 2024 09:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="Wb9Ig4F+"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C338E19046E
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 09:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729242729; cv=none; b=WD0/tMap3bq57yDP2HIE2Qikfkf5aXsJUiiww0sbTzikfC8RQxkRabJnlK2xGgfga+UZa5arAHGiv8bdeQMWQHV/cOSHlGulmJXEyTrGhxqgxTEB3MAdhAHtKnPHo8aWfAO0PVA6xl3T8LophUuve7mvr8jpmvpcwKPAMTNOhaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729242729; c=relaxed/simple;
	bh=03Qb5hxKK7rAKMhBjn9jT6mqUqatJTsr8tb5L6OSVI8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=NSfUHwNkBpqlnYT2NkPCy3ddm4kfaqnINYLg5TFf0qgOwelB4Y864yb7RRoRzr0D8cHMEY5QtoqbNzFU6milS0pnrn+zLSFLxmKNFEtqBvuM0B9HT01LwIu4AdZLsKEUZsdRbgqGE+rpxdl+SFGLckv3PHJEEtGgj9KujxrihdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=Wb9Ig4F+; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20c53efc14fso817485ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 02:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1729242727; x=1729847527; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XkkT1YK08fvvBnsXdekTj1dlk1F6WdJ88gbC//Uv2Rg=;
        b=Wb9Ig4F+FkCJHzPERxhBJaw7t9DYxB11HMONuXk6TTXi4itNQQLAQ3bPw/lG/VkIQJ
         HZrtKM0HjNX8m5q+t4ZbyCkRr/5l7C5medRpFOjqFA+xMHPC09A9Uh1rwr/TfunwagEo
         TJ/fIHaWHcIFExg58XAX3OAhB5fETQJxzGUk8y9XoLc7o7uwFtBgz/f3Fp6YT7TG/3yo
         d7Pkv7HZwvZNTsGtjEL7nWMqcrmh737ZGQM1BAqxHpfvOFmvH0WbJN5xU/kG8JWF128t
         V8NgHUMTa+kz74cvyxgm7ekKvWeAd/ijzhKfZ4Yqt8TnG1CSZ7ubAvj6UKJrY0PUjF90
         6XRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729242727; x=1729847527;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XkkT1YK08fvvBnsXdekTj1dlk1F6WdJ88gbC//Uv2Rg=;
        b=ulWqKRL5th8oEDs6sMe1bTdk7I70FNOTD5StVSvh22IepSRrDGQaaj/I4UfnviLe9L
         y9y4DQkgy6bzVPT9r5Lc4M07/XEIgn3Vu9CuMEUXU3dpbi+R7elzpL0rglTF6tYQjbKX
         0XYOSHLg1JpZR6I6bnYrZ+NGEk9NX1oLz3rLKFF/HZIxwhWM7Lc7F9MX2jYOald7fawX
         Npwp7Wjvwp7hc0HJBeEL9WFJxRhwQKWtWWLUKxy7BslV0e2I3EMByJ3ZbN1oxmUecyNX
         B7wAdrB4JVIy7mt/tnkFQvA0cFyqOhB+MKxb/W1mAewBG++fdna6+XUpVlKL5yvNuCQr
         1obQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3fmCaLhoA93fQB+fb9+XSCcZaGLku881fTcLczCARx6nmpeI9zl43hoEXljFzdZcv+psiXQ09qoCKfZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLTktf0EAKRRIu1ooEuuDUxyiRXslOeWbn0+FxlDnn77ygMDXK
	RGu9zMK2qwQsAIhI3/GtNdnWlns00gkoihGdVf7/aB01Q9DT3iJi9pM8SnX614w=
X-Google-Smtp-Source: AGHT+IFU+OdYH5faJbm1npPyrHUQPkpVpJnW6eLNvXvJK6fIKzyxq5xuE0uIanU+RLnHqk+9JzTcBw==
X-Received: by 2002:a17:902:db0f:b0:20b:b93f:2fec with SMTP id d9443c01a7336-20e5a8aedd8mr10397965ad.8.1729242727131;
        Fri, 18 Oct 2024 02:12:07 -0700 (PDT)
Received: from ubuntu.huaqin.com ([116.66.212.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e5a747925sm8659115ad.71.2024.10.18.02.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 02:12:06 -0700 (PDT)
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
Subject: [PATCH v2 3/3] arm64: dts: mediatek: Add exton node for DP bridge
Date: Fri, 18 Oct 2024 17:11:35 +0800
Message-Id: <20241018091135.17075-4-xiazhengqiao@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241018091135.17075-1-xiazhengqiao@huaqin.corp-partner.google.com>
References: <20241018091135.17075-1-xiazhengqiao@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Add exton node for DP bridge to make the display work properly.

Signed-off-by: Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>
---
 arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi b/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi
index 682c6ad2574d..943837f20377 100644
--- a/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8186-corsola.dtsi
@@ -424,6 +424,7 @@
 		ovdd-supply = <&mt6366_vsim2_reg>;
 		pwr18-supply = <&pp1800_dpbrdg_dx>;
 		reset-gpios = <&pio 177 GPIO_ACTIVE_HIGH>;
+		extcon = <&usbc_extcon>;
 
 		ports {
 			#address-cells = <1>;
@@ -1656,6 +1657,11 @@
 				try-power-role = "source";
 			};
 		};
+
+		usbc_extcon: extcon0 {
+			compatible = "google,extcon-usbc-cros-ec";
+			google,usb-port-id = <0>;
+		};
 	};
 };
 
-- 
2.17.1


