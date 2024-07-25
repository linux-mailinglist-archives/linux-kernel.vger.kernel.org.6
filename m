Return-Path: <linux-kernel+bounces-262094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11CC893C0B0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 13:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD462282422
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 11:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36521199251;
	Thu, 25 Jul 2024 11:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sF6vM8BS"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B1B1990D6
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 11:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721906639; cv=none; b=pUX4KvSvlGKo+MuoGo4Gv1z7Tqs6CZ/9QGibrvaBgbJrvB//4zYfQzW3+pAJr1URJJzrFfGqkm27GypBhu6jun58xqyu8z2yuspVu6pw+eXSKWrrIIwaRYqBoYhaHbxv/+r3xBfixturr/ONtu+uDLOdarOtEmuy62lkMGZYUis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721906639; c=relaxed/simple;
	bh=H3zPQHTWirqb+YKkh6z42j305IWpTK+pFRf3UJIfZsM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LD/2s4+76bpVoVAh2kp0T/AXo4UrXQR+luaGyZZoFg0oYLTDad2oEs2nN8cSIspuosIuAeBqTIIo60TSfsUw0A5JvaiEzgcbel8gCOmwEgoVwWuPwnfXmcumrblTBPVPbhOils6T006x39mQSuuVfxFu+X4Zs7jx67GHw/zB/HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sF6vM8BS; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-367ab76d5e1so329667f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 04:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721906636; x=1722511436; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gTBSTTOkb+WSl1iUVchSrVeyD6kc7gtLT8y+Hn/zjv8=;
        b=sF6vM8BSZsZ7bHiI7FGF/WZDpwJQIc7k2JVUfZV9QcRbSWcDOo1iJOs4HgqswoYZul
         uGoqwU5G1/umg3edUr40YFjXqH8m9XNyVwflPOofrUttp7t+rG6GJ+y289R+Isg5oDsS
         nc21Mq3QbcDmBAyS+hfMgmXEaapW+iVr7n4FQkcpFB49+mCu9f0dbVf4h6EavRUTaV9r
         pNiTmsMTcayz5p61Mk3Mk/Xt5q3iJ7YnCNylICKnGpxL5QIg96vlASMDizZRv6K551WX
         /B+s9gzz7OfNLZWX6pxZdE+yziZjECmDa6TX4F+QQUWItMU/MPLwabNu41KUrqGzNfD4
         IRNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721906636; x=1722511436;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gTBSTTOkb+WSl1iUVchSrVeyD6kc7gtLT8y+Hn/zjv8=;
        b=PysZvM/L5Aq4qDe26NSXHffQbxH58V2Lg5Y8/MJLULGJMHWrPZirYlMzJRI6VLHPFt
         t/J0GyNL9dkL9U8pETQQON1tt9hlwQI0XjR57qzPAVsmp8NbDiwOF1q2js0wlJ9wKQ3W
         o6cqrXqJ6oIyZ2QiXSx0lWOfCSEcJqiWXO2pu3hCoVNpFNHGbX8/zXMyqr2P5bo2nZxh
         vlDPl0Cm3J8j7vd3emG7vGnkzSZw6IaiRzJ1Yh/Vy7locC4/5ef73GoKAtoK67Ec8/XA
         dAuD/XkhOHQZzuHDbsuooX/5MMJtf5LyMreOo+KbFl0bLN58wRr+p1nN9GIIR/Ypj7Ip
         AYqg==
X-Forwarded-Encrypted: i=1; AJvYcCWwmvRNQXjB7ZBgyCIdgMKmJ7qxSNfE+rxwy6megkd1QnXkMWRrvldCGj8bzE9J48iKd8/vueHpT+kskqiS1MkCAI/4nAMosL6DJYUB
X-Gm-Message-State: AOJu0Yx8yNfKRlYWDE+JBhFv/uars/mUgWux+AKipmjpckE05exUp6W+
	RWIKokUKf0pd90pyCvAWvV4h/5+NKu+q2Jtg6nnQ7Do1NmduptNtdmABaLx7H3WZVZIZpQmIx4I
	Q
X-Google-Smtp-Source: AGHT+IHAfTlo9M6e5r9HgMHgdhErs0TlhZtiXo/7lrlvfs1/razJ48JKVhDyFjVXqWYom0Upw/26mQ==
X-Received: by 2002:a05:6000:e02:b0:368:3b1f:fe40 with SMTP id ffacd0b85a97d-36b319df228mr1806585f8f.20.1721906636120;
        Thu, 25 Jul 2024 04:23:56 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b367e072asm1823607f8f.42.2024.07.25.04.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 04:23:55 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 25 Jul 2024 13:23:43 +0200
Subject: [PATCH 1/7] ASoC: codecs: wsa881x: Use designator array
 initializers for Soundwire ports
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240725-asoc-wsa88xx-port-arrays-v1-1-80a03f440c72@linaro.org>
References: <20240725-asoc-wsa88xx-port-arrays-v1-0-80a03f440c72@linaro.org>
In-Reply-To: <20240725-asoc-wsa88xx-port-arrays-v1-0-80a03f440c72@linaro.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2540;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=H3zPQHTWirqb+YKkh6z42j305IWpTK+pFRf3UJIfZsM=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmojXD18kJb1J8ilpNX0TqXikxBBqVB+AYDoX3s
 ofz9k9fE5eJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZqI1wwAKCRDBN2bmhouD
 10rxD/oDw2zy6A5vr/mf1lFcmwK5FKJCWh5Fk9QW6Xgt5ZPo0Z9CEooxuhCynFyOQ2ZpFiWVVCA
 zQjbNrj4nOoHuwcmmFAXkBLRbybce9FHqoLQ9U2rxOyrTOqjh15OV7G9cpbncYtWGWEfNBm0NTI
 GE4W4e+9s3ERSChCy6Mc5rTP5bhB/c3JYg3mpI7Olx3C+ZcYqwjmf33TxmQW2wL/+zkHO7qf9Nc
 G2WpUQpxY+HpAslqcFienRtcGthZSTBVNSX3OvSV4Tdyug9owWh3rt5bHIwwUf2tzkIwnVJMrnI
 xgPHcGu8oYNk6bSGWpUkLQy4xQ5/svZuhHZ8cbEUt7wkiWpE3cjb945wXYwAOP1+bKYGHk7Y/2Z
 vqSk0qY6tyVwAtHYIBfFtFR/4+iEptZ6yqe4NTEGjWOfnLc5g7IBRgb5RurvqssAwY3jIl5bO4M
 OM6Qqtu4HulnwD2aX2otXE7WgAxyV29k+4Rv1WdUV0jRklzDmcYFWiapRofQrGQBS5L0PkyzjQ9
 wFpYqJmouMApelh/fUq2V+ypxUrXfUkas6hZm/KEdAhMjTLSZVS+UkKCbioo4sYd0UpJoCXRIOs
 H3QccdYt6Dz991XlRfQTZ23lIGq6EqyEOJfT2o2akCNp9R3QsJf/5gCgCQVvPUcpuvGjRJwDE/T
 3/cJvitndAM0LqQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Two arrays (with 'struct sdw_dpn_prop' and 'struct sdw_port_config')
store configuration of Soundwire ports, thus each of their element is
indexed according to the port number (enum wsa_port_ids, e.g.
WSA881X_PORT_DAC).  Except the indexing, they also store port number
offset by one in member 'num'.

Entire code depends on that correlation between array index and port
number, thus make it explicit by using designators.  The code is
functionally the same, but more obvious for reading.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/wsa881x.c | 42 ++++++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 20 deletions(-)

diff --git a/sound/soc/codecs/wsa881x.c b/sound/soc/codecs/wsa881x.c
index 0478599d0f35..a5e05c05fd3d 100644
--- a/sound/soc/codecs/wsa881x.c
+++ b/sound/soc/codecs/wsa881x.c
@@ -386,33 +386,32 @@ enum wsa_port_ids {
 
 /* 4 ports */
 static struct sdw_dpn_prop wsa_sink_dpn_prop[WSA881X_MAX_SWR_PORTS] = {
-	{
-		/* DAC */
-		.num = 1,
+	[WSA881X_PORT_DAC] = {
+		.num = WSA881X_PORT_DAC + 1,
 		.type = SDW_DPN_SIMPLE,
 		.min_ch = 1,
 		.max_ch = 1,
 		.simple_ch_prep_sm = true,
 		.read_only_wordlength = true,
-	}, {
-		/* COMP */
-		.num = 2,
+	},
+	[WSA881X_PORT_COMP] = {
+		.num = WSA881X_PORT_COMP + 1,
 		.type = SDW_DPN_SIMPLE,
 		.min_ch = 1,
 		.max_ch = 1,
 		.simple_ch_prep_sm = true,
 		.read_only_wordlength = true,
-	}, {
-		/* BOOST */
-		.num = 3,
+	},
+	[WSA881X_PORT_BOOST] = {
+		.num = WSA881X_PORT_BOOST + 1,
 		.type = SDW_DPN_SIMPLE,
 		.min_ch = 1,
 		.max_ch = 1,
 		.simple_ch_prep_sm = true,
 		.read_only_wordlength = true,
-	}, {
-		/* VISENSE */
-		.num = 4,
+	},
+	[WSA881X_PORT_VISENSE] = {
+		.num = WSA881X_PORT_VISENSE + 1,
 		.type = SDW_DPN_SIMPLE,
 		.min_ch = 1,
 		.max_ch = 1,
@@ -422,17 +421,20 @@ static struct sdw_dpn_prop wsa_sink_dpn_prop[WSA881X_MAX_SWR_PORTS] = {
 };
 
 static const struct sdw_port_config wsa881x_pconfig[WSA881X_MAX_SWR_PORTS] = {
-	{
-		.num = 1,
+	[WSA881X_PORT_DAC] = {
+		.num = WSA881X_PORT_DAC + 1,
 		.ch_mask = 0x1,
-	}, {
-		.num = 2,
+	},
+	[WSA881X_PORT_COMP] = {
+		.num = WSA881X_PORT_COMP + 1,
 		.ch_mask = 0xf,
-	}, {
-		.num = 3,
+	},
+	[WSA881X_PORT_BOOST] = {
+		.num = WSA881X_PORT_BOOST + 1,
 		.ch_mask = 0x3,
-	}, {	/* IV feedback */
-		.num = 4,
+	},
+	[WSA881X_PORT_VISENSE] = {
+		.num = WSA881X_PORT_VISENSE + 1,
 		.ch_mask = 0x3,
 	},
 };

-- 
2.43.0


