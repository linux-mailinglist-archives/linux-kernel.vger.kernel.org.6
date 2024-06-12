Return-Path: <linux-kernel+bounces-211902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5639A90588E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 18:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A7F02884C0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 16:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A664197A9D;
	Wed, 12 Jun 2024 16:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o+GrKvoB"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF58F195998
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 16:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718208982; cv=none; b=OCDv1svi61pUUojEM8ehBUdExxz8JC4+a5jIrNJvky+OJTJ0wB7a9HYaHCDFeaE21ZYwpqkVLcvIk0iBEKczh8uce4zeMH6UFXGNz9gL2NeixNa29IexMmOCPteTYwy8TYcZscsKyxDSXH5uldqiskLpt1l/5AqPHI3mIkUzRo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718208982; c=relaxed/simple;
	bh=6+UBEqHPuSCJQ5GPuzFYqeY5be1EJ+f74Fpf7byXhqo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O07nsKC7JjW6JbR6nQpvNGAYaoHZzs2lrjvrWbA/y/DzTFMV8Tl+oZ/lnyYTf39sWoA6Yho6QUMCkt/MylpwxKcr4lwEXx4IjyFkGMtXDsq/99RTGsbh/kV+/z8jzX24ecBO5Tfbl/pHvBK0PIYaisBrX7rpkD+9DdotXUfNdKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o+GrKvoB; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52bc29c79fdso76821e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 09:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718208978; x=1718813778; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KUSq90CkA/e5YtyJB3DxxxJXJzc5nG1xr3zOSJv9S5o=;
        b=o+GrKvoB8w8kPSQGXkjcoHycph1mJjuNRcq+KDohLwKCoCzAOrVLNSumeMG/rEZdqy
         opNNtWFfBzqlQgHDBlnMg98rnzi6s/WDFe5mURKXX2/9LWRo84ZtEwyHdNKyicHehqHy
         k0Hiv9psCCQaCsNuvi/RXDjI+9DQXEnY7fgnbtLzo+H9A4I1L7PDsHV27mbx2xmM+8Vw
         NsUbWLI+KNC25arx9/K7VC09gyeof9DANg5ha0sTfZMoc6b82zauDH9Mzy1Vk68dYZWU
         4lYgpRaBKNinTEu6hS0q0+I/NK91TH7Wj01w6y04hQFYCUOCNoNCzYTiFf8J0ijS+epM
         zUsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718208978; x=1718813778;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KUSq90CkA/e5YtyJB3DxxxJXJzc5nG1xr3zOSJv9S5o=;
        b=G6SMWnk7u3SrdP75ayUittlcExxVxN1iUlKTv/mcoJ8/GxwWqlQ1oNVwP4WcPmugOv
         XTz+xVVoJsw32c1PvG6QAH6sIFKSBPPbXSuC6oC1xZAwlSrZqpWJv3ro/C/3Ckb2w9Rf
         r6RfIDKulUpE9qJaX/GSTZjXMsXsdCD0xIBMs6/DD2mqbKhyLeW68mJEbB9DzAnk3WGV
         A162vftvpwuAvNz513/uATx46ORRigt9xBJnGblr9CslLunfYCbXyZ4baRgx6RnK7ZoE
         WxnzC0b8tmDfr5/rMpbmynTmiiUsRsA7QFwFqr0HRNTpPIWOEJw4IKS0wJGoPfSS1P4g
         yUEg==
X-Forwarded-Encrypted: i=1; AJvYcCWeyan1/RPjMiOrWLORAn78P2eyW5DOen7lKF19zkEhVG/p9p7ghevrlPPD0e4RCY1e2eoK+00PeUxB5Sx0iqhNU+kWwdXuOBRUgrQf
X-Gm-Message-State: AOJu0YzfbpVi0lI21aujmOBNn8wpojPXjmLuY0ACovN+eBgKL3Fb2LiK
	XxBEG/l8EKvnuHU3T8WjfkLhrAFP7vD3p7/MBraocsuhi5g9PyniDwsuYs5gisE=
X-Google-Smtp-Source: AGHT+IFwbnYghzXFTnC+RPeeiOFea6oxzdRq4GTl+xpaiMotJwnH3mE3DEOAsY+KEGhGtB0mf+6f5Q==
X-Received: by 2002:a19:e00a:0:b0:52c:8811:42f7 with SMTP id 2adb3069b0e04-52c9a3d2020mr1828169e87.19.1718208978302;
        Wed, 12 Jun 2024 09:16:18 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6efd6cfb74sm624815866b.20.2024.06.12.09.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 09:16:17 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 12 Jun 2024 18:15:36 +0200
Subject: [PATCH 23/23] ASoC: codecs: wcd939x: Drop unused num_ports field
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240612-asoc-wcd9xxx-wide-cleanups-v1-23-0d15885b2a06@linaro.org>
References: <20240612-asoc-wcd9xxx-wide-cleanups-v1-0-0d15885b2a06@linaro.org>
In-Reply-To: <20240612-asoc-wcd9xxx-wide-cleanups-v1-0-0d15885b2a06@linaro.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=668;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=6+UBEqHPuSCJQ5GPuzFYqeY5be1EJ+f74Fpf7byXhqo=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmacmr/WnHs89ZC/yEkUavUltM0vHYHU6KbqX4W
 wEotKpQ6ieJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZmnJqwAKCRDBN2bmhouD
 19KVEACbMMT3jPxwjV7Xo2ksLok+3WxWywwteg/LnIXFjkRxGoGONk15q24uYyDKKeTxUuPDpib
 XcwgtSHFW0e0q0mt2feP46Ce1INuVVah99aoK+HGWF79YJG/2UtzxzPCaTbewL7o4h+55j5TcuA
 vHM6nrwyyC+r7AJeOtKlOZy/tOy+YANRFZWu9UkXXRxx9pB2GtBYsTPaJ3HYwrGrjO+zJ9QITs4
 ccPF7qmrb5f7Gp2yZ8NU35FLjbaS0/UOSeyXCrXNF181JruQZ+wed0snTOALbZbdQ6IDQ9JD6GO
 rX0VMP0JW37eGVz/wcJRUYHOQ8zKCXQ9tgfANZn4JvwUhbFay/vJGEFhRhOC1tBt+k86B5Pbjzl
 SAB3Azk97OvL+I9xA/jLtun1WoHWXbFeSrhYFaUx1StgW0CATkzIdD6cL23hxrvZKhDTOADiDCo
 edn/0N6j5mAktUp3v2PV/lSD+qgj36GvPC6/P4Tj0TAVE+33cMLYxBD/ZNXcRnlyZK3eLztTnKS
 yHmDTb/is8fY8DEdcpmxpSEI0TqbM0masGNvaS26HcB91dO1ND8Ghs+gn81PjrTvvskQz5Gumld
 ALpx3MIKDaAHcU2lRawkwvJ9Y4AeWo8YnyzrkYIykhcicLO1BA+PR+XLarpL0oGplP0tQAVtWt1
 m/+jt/LnIuV+7Ig==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

The driver does not use few 'num_ports' in 'struct wcd939x_sdw_priv'.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/wcd939x.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/wcd939x.h b/sound/soc/codecs/wcd939x.h
index 0aa4d9d542c6..1571c2120cfc 100644
--- a/sound/soc/codecs/wcd939x.h
+++ b/sound/soc/codecs/wcd939x.h
@@ -912,7 +912,6 @@ struct wcd939x_sdw_priv {
 	const struct wcd939x_sdw_ch_info *ch_info;
 	bool port_enable[WCD939X_MAX_SWR_CH_IDS];
 	int active_ports;
-	int num_ports;
 	bool is_tx;
 	struct wcd939x_priv *wcd939x;
 	struct irq_domain *slave_irq;

-- 
2.43.0


