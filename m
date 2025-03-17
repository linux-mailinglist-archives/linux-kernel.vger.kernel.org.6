Return-Path: <linux-kernel+bounces-563211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0154CA63913
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 01:41:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA8643AE172
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 00:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9B917A2FF;
	Mon, 17 Mar 2025 00:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oX3pM9Ip"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7527B171092
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 00:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742171996; cv=none; b=otaH+l6E29Jns+TvfVY+gU9E8vwinfC0fK7Xuqv5bnaVtB0+2kZa6nnaCpNcIbG5fyrTptEui3JdYr76w4uzrvTvgRMdbFAIHycP/SqmAcz4dtYvRxO0uWF4HbIfFk8jwSOkYOeQQF6giMR/e4xpNIMj2dMwB4tR7ujUL7bWULE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742171996; c=relaxed/simple;
	bh=EC9j2bIq4ciGt5bTfsPpCKAcRq1j/C87MvJJDh4ON1A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h89+8iJRG4hDmWYELrWp7qbG23wG9EDyduT2bsueYaQA2ATHUmoJTNGr04bzNdO/udHxKwz/sp6SaqxD/JmQZaVEDwUqZ+iR7dtVkvuOSQ74SRrN9/pI6KiJwm0K3TJj47jRS4RRTUJ9T5Ffzrmz7XFLXY7srV7urb3ITFN1NdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oX3pM9Ip; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ac345bd8e13so235422166b.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 17:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742171992; x=1742776792; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3oIaC4JSPq4Hxx0BCotHyy3fEpNhxbu3GVa44qnjARE=;
        b=oX3pM9IpCKJ5eXZxBEMA5VP2Zh4cZLsOAJFCJdsAaZooEFe1ZRqeduJAZlQnU8GCTI
         Eq/+HRAQ7zxmOT1EIFenukb960BHGeO4GzEdCwGKNWE0mpUgeVDk1BWbE6GQ+Icpf3zK
         2fD8hj38v/8gR8TAGZG6Y/nYZti26HjX3c5WXoypF30mJRNFg11fs1xEalA1bBCHNv8D
         /KyLZ7N1+Muz8YeYGyY2sjKeI/DYgr5FVYT12B5SOqG9BNNloRzP5s0vQaVKlzo9AJqG
         FhzzMMzNC5faCCBMhJifEvggxqBkINSjCt7GDZcig/yWqgnRDiyCdErOHlGGA6NcNg0A
         Gl3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742171992; x=1742776792;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3oIaC4JSPq4Hxx0BCotHyy3fEpNhxbu3GVa44qnjARE=;
        b=hlRty2Dql+//CYyGP89cdwEvy/peM5fe0cYB5uIETH5+AUqTeiVegGa7N4Ro4QkV8m
         xUsKVOLhxDnE7a00ak48SYjQtkNQ46+QBbxfd4xtpddElDXHfM/5xi2RWYiWaXztXgaq
         YaD+hZLSvhNaKgajhpQrSrIG4VHMGbuTCvRLbDqVtG8Y0ch8b4wZfSz/w7Si2q9CS7IB
         pgyHvMH7cBx7wNmFbO3GYu2L6QrytXyJFhvIFWx+xmI0Rj9qIM/fOV+9wY+ueLN9ICAn
         oyGRd1+UZVDuyTrePJwYw6DSeTXcXFUl43WO+shBLRwT+zc/F+x/zdB2Ru5r3RvRr/KX
         TB2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUEzikEuhLfdBfc0+1vJtQCFc4ligConjveqAOgheKSSRiVvMZShqGfvJEYvf8yzHEqgJ4LBgyZy2koT90=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/ZLxkJ1bKs2ujlpL6Dtf09MQaNHMeOyXOFA9Hn9VxTxaCuAF6
	vNsa8Txlj9jiKirj3dYwMZXRY91Lq2btuHjM2DZYzEFnMegg6yYaqvXbc3FvPHA=
X-Gm-Gg: ASbGncvOA8p3dfREhz8PTMweqROjzRxxMxlFcCR13T/+QHteIfi82JX/Miue0Knk/5F
	+K0X6HySaw96aGaRp0H788LLKzfIfidRE7vL6uBBQ47d8+qKtxdAqiLJIiUmuRT7GEcT4ESej7K
	wIBxc7gZIQCfX3mDpZVQMS2zDxjIV7LtXrcZ9AbyPT43xMv2u6WZvgxTrewueXopGX74r7TpX14
	1jEvwRWC5BMOso0IKIVjB369oeeFn0FwU28Gag0du+5xY/Ara+33/xrJsJcH/74IjzoEnIzsnaD
	HLyFoSy206nWvv22pkfzpHCXF0qmUOnuJUv6LwPaVBZeTRbQeWufCCIIg5FXKE82hec3rED2sqw
	PonA2917TiO0m0aG+S4TbDNufNBUFAdzWFAEngmuot8xilhhJhYikRAMpjowYgOlTJ6TB
X-Google-Smtp-Source: AGHT+IGw5bWEY5CU0ToSapKWjZkga24fSjvSj722h9dS/H4k7EkMFeAOLRKF/irP9dBdAZwFIVLVfQ==
X-Received: by 2002:a17:907:7e8d:b0:ac2:29cf:643d with SMTP id a640c23a62f3a-ac3301e4c55mr1021762166b.25.1742171991816;
        Sun, 16 Mar 2025 17:39:51 -0700 (PDT)
Received: from [192.168.178.107] (2001-1c06-2302-5600-7555-cca3-bbc4-648b.cable.dynamic.v6.ziggo.nl. [2001:1c06:2302:5600:7555:cca3:bbc4:648b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3146aefadsm562407166b.8.2025.03.16.17.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Mar 2025 17:39:51 -0700 (PDT)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date: Mon, 17 Mar 2025 00:39:40 +0000
Subject: [PATCH 8/8] media: i2c: ov02e10: Add OF probe support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250317-b4-media-comitters-next-25-03-13-ov02e10-v1-8-bd924634b889@linaro.org>
References: <20250317-b4-media-comitters-next-25-03-13-ov02e10-v1-0-bd924634b889@linaro.org>
In-Reply-To: <20250317-b4-media-comitters-next-25-03-13-ov02e10-v1-0-bd924634b889@linaro.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Jingjing Xiong <jingjing.xiong@intel.com>, Hao Yao <hao.yao@intel.com>, 
 Jim Lai <jim.lai@intel.com>, You-Sheng Yang <vicamo.yang@canonical.com>, 
 Alan Stern <stern@rowland.harvard.edu>, Hans de Goede <hdegoede@redhat.com>, 
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
X-Mailer: b4 0.14.2

Supply OF probe matching table and enumeration structure hook.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/media/i2c/ov02e10.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/media/i2c/ov02e10.c b/drivers/media/i2c/ov02e10.c
index 2c15df8ca733aa4f37e125ac3bfb51a319e34c6e..10cac199b23f14ed79f4fb7e84d2c685c6d70399 100644
--- a/drivers/media/i2c/ov02e10.c
+++ b/drivers/media/i2c/ov02e10.c
@@ -954,11 +954,18 @@ static const struct acpi_device_id ov02e10_acpi_ids[] = {
 
 MODULE_DEVICE_TABLE(acpi, ov02e10_acpi_ids);
 
+static const struct of_device_id ov02e10_of_match[] = {
+	{ .compatible = "ovti,ov02e10" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, ov02e10_of_match);
+
 static struct i2c_driver ov02e10_i2c_driver = {
 	.driver = {
 		.name = "ov02e10",
 		.pm = &ov02e10_pm_ops,
 		.acpi_match_table = ov02e10_acpi_ids,
+		.of_match_table = ov02e10_of_match,
 	},
 	.probe = ov02e10_probe,
 	.remove = ov02e10_remove,

-- 
2.48.1


