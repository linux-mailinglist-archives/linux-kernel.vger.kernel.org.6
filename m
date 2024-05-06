Return-Path: <linux-kernel+bounces-170167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0469F8BD2C7
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 18:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE225281025
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 16:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA58815665E;
	Mon,  6 May 2024 16:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KHyeXEIo"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF6A156232;
	Mon,  6 May 2024 16:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715012923; cv=none; b=iCdAbel5nrFi2pEUv5G9XvkWGoUDUKN+l9pqYLwU6evqPdoX+fEmr4SbTHnA+98g4rDB23zrooS+3Q2f9ootY7DqNJfKbAT3BdDT+gYQLZkDJ0gmaH26OBC7Qo8DPypMRHVqWn5CfwEyKIFuaaLiAHl5fnK7WkOo362kPKHwJHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715012923; c=relaxed/simple;
	bh=TJCBlxaobgWm4Mks9yKhXKVxEnIJdD93CLSSW+aAmb0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UOwVPQUrIL8VImhN3H6a9oZWjYDMU27XjSdgT6IDQWmxd3mSbAs55pchWZG6yKjCzxSJghnQBhhAIOYytIETAqEjXBV7KaIwftjsMMuiPY+TgNfCqFBV51ss94kGuAQrM7mLqjCXisjyk02XDGP4Ah9h30RicUtMtwOU9PdyQT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KHyeXEIo; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-620e30d8f37so1865636a12.2;
        Mon, 06 May 2024 09:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715012920; x=1715617720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bUsiOFVNID+o8HqMi9Kuv7+m9t5vDqjyXqD9PUDfssk=;
        b=KHyeXEIoXxPPFuYMszFN6qajNbf0JIbpi1tUdzRJ6vTqaBYv1rwhGpD5eodpgSDfrg
         3zjhgAAOYsDpOBYxcHXnmR1mjtyce2P74rtL5lbGMxUgTW8zSf78xLYY2k0qFodaS0wO
         0iwVLXWinJvV/Oe9mOArZqjCfS6ZyyMSdX6Sp3QRoU8Xfy8IsFD0PXYdzvPpYWq7iJst
         qj3X6ocPhtVxcC/XZNpCjVaPyEfoPxkVArPgWDjBtgxmroCk2b6FRrECbP4gQJbk0P+w
         EX3j8YStpMaiVSxNVjl7fUm3Ufz8JdiKEWLNJ7qxXS8LP3f7B/8GmfEclzuHWdZmSHh8
         T8Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715012920; x=1715617720;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bUsiOFVNID+o8HqMi9Kuv7+m9t5vDqjyXqD9PUDfssk=;
        b=faingMi3vEk99hXIN3WrIr23rn0ZsdUt2TcSexrv/29/rpwRoUKYQbAqzWAy20KhEd
         mKKH7K6i/H1ufkvXr8o3PA3eW7/CGJiS/i0aN9/St/9apz73g4q1vBG2IIP6YHURp68e
         FWWsQnmMQb7680BmTViMyf24rvJhexvbBf25GJvYJ+OcYVHa98RJUWKyaq8mlEzV6ZKy
         GJFHP8E0H9cPNom3WAsCT7SgnY4JttI8n1kMPA0JACZkx7gZsdk93vb0JKmwJGX7cLdy
         0UquGI9LYpof2Gf1B9y6jz2fDgRFAo7vz/80JmM3hU7bkXwVjaU7rNbIn68RPrZ+uPWf
         +VKg==
X-Forwarded-Encrypted: i=1; AJvYcCV9f9Oz6GOYNeQ2i4NyfjTCoXXBNil6IveYcq57GLsY+pqnNNFW/8K+S77XgQGrmLmS9LUlByAFJBYA/CFjRuoIfBxcD/OVy86c95/z5BCcTjktKtPcEfO6QA/QY+ZeSUt8hcuf+cGN
X-Gm-Message-State: AOJu0YznqHCknJGBYiNP9tYrK/Uj0OOs7J/4rUJoiAkxoGo0nQ6Skk0x
	L3RPL5Fw1vU3zJfLZIv1orJDLKDZV178ZGZAMlZuwZIKSY8M5SSQD5zIdw==
X-Google-Smtp-Source: AGHT+IFWUdGJe6CVVMqYm5eoRSsyvmyjjlGFy0yhl9e0BJRH4jeeYgYbcLzwWMdrXIZwu8fG8qdpgA==
X-Received: by 2002:a17:90a:2f62:b0:2b1:4e21:2c5c with SMTP id s89-20020a17090a2f6200b002b14e212c5cmr9192052pjd.49.1715012919897;
        Mon, 06 May 2024 09:28:39 -0700 (PDT)
Received: from dev.. ([2402:e280:214c:86:88b5:d592:a102:f8f1])
        by smtp.gmail.com with ESMTPSA id w3-20020a17090a528300b002b4329ec537sm6721427pjh.53.2024.05.06.09.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 09:28:39 -0700 (PDT)
From: R Sundar <prosunofficial@gmail.com>
To: heikki.krogerus@linux.intel.com,
	gregkh@linuxfoundation.org,
	dmitry.baryshkov@linaro.org,
	neil.armstrong@linaro.org,
	christophe.jaillet@wanadoo.fr,
	u.kleine-koenig@pengutronix.de
Cc: skhan@linuxfoundation.org,
	javier.carrasco.cruz@gmail.com,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	R Sundar <prosunofficial@gmail.com>
Subject: [PATCH v6 linux-next] usb: typec: nb7vpq904m: Remove unneeded indentation
Date: Mon,  6 May 2024 21:58:29 +0530
Message-Id: <20240506162829.5223-1-prosunofficial@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In function nb7vpq904m_parse_data_lanes_mapping(), the "if (ep)"
condition is basically the entire function. Making the code a bit more
readable by inverting the condition so that the function returns
immediately if there is no "ep".

Signed-off-by: R Sundar <prosunofficial@gmail.com>
---

Fixed indentation in common path according to comments received on other patch
as below:

[ Nit, this function should be rewritten to not work like this, the
"common" path should not be indented, but only the exception (i.e. bail
if ep is not allocated properly.) ]
https://lore.kernel.org/all/2024041103-doornail-professor-7c1e@gregkh/

Goal is to get rid of of_node_put,but sending this patch first to do one
thing at a time.

Changes since v1 - fixed the typo error for spell from identation to
indentation

Changes since v2 - Shifted the indentation to one level left for the
switch cases as per coding style.

Changes since v3 - Added descriptive subject for the patch and checked
from and sign-off having same name.

Changes since v4 - Fixed name in signed-off-by as in documents.

Changes since v5 - Modified the subject and commit message as suggested.

Patches link:
------------
v1  - https://lore.kernel.org/all/20240420145522.15018-1-prosunofficial@gmail.com/
v2  - https://lore.kernel.org/linux-usb/20240420164927.15290-1-prosunofficial@gmail.com/
v3  - https://lore.kernel.org/all/20240421011647.3027-1-prosunofficial@gmail.com/
v4  - https://lore.kernel.org/all/20240424150718.5006-1-prosunofficial@gmail.com/
v5  - https://lore.kernel.org/all/20240426164705.2717-1-prosunofficial@gmail.com/

 drivers/usb/typec/mux/nb7vpq904m.c | 68 +++++++++++++++---------------
 1 file changed, 35 insertions(+), 33 deletions(-)

diff --git a/drivers/usb/typec/mux/nb7vpq904m.c b/drivers/usb/typec/mux/nb7vpq904m.c
index b17826713753..ed93194b16cf 100644
--- a/drivers/usb/typec/mux/nb7vpq904m.c
+++ b/drivers/usb/typec/mux/nb7vpq904m.c
@@ -321,46 +321,48 @@ static int nb7vpq904m_parse_data_lanes_mapping(struct nb7vpq904m *nb7)
 
 	ep = of_graph_get_endpoint_by_regs(nb7->client->dev.of_node, 1, 0);
 
-	if (ep) {
-		ret = of_property_count_u32_elems(ep, "data-lanes");
-		if (ret == -EINVAL)
-			/* Property isn't here, consider default mapping */
-			goto out_done;
-		if (ret < 0)
-			goto out_error;
-
-		if (ret != DATA_LANES_COUNT) {
-			dev_err(&nb7->client->dev, "expected 4 data lanes\n");
-			ret = -EINVAL;
-			goto out_error;
-		}
+	if (!ep)
+		return 0;
 
-		ret = of_property_read_u32_array(ep, "data-lanes", data_lanes, DATA_LANES_COUNT);
-		if (ret)
-			goto out_error;
 
-		for (i = 0; i < ARRAY_SIZE(supported_data_lane_mapping); i++) {
-			for (j = 0; j < DATA_LANES_COUNT; j++) {
-				if (data_lanes[j] != supported_data_lane_mapping[i][j])
-					break;
-			}
+	ret = of_property_count_u32_elems(ep, "data-lanes");
+	if (ret == -EINVAL)
+		/* Property isn't here, consider default mapping */
+		goto out_done;
+	if (ret < 0)
+		goto out_error;
+
+	if (ret != DATA_LANES_COUNT) {
+		dev_err(&nb7->client->dev, "expected 4 data lanes\n");
+		ret = -EINVAL;
+		goto out_error;
+	}
 
-			if (j == DATA_LANES_COUNT)
+	ret = of_property_read_u32_array(ep, "data-lanes", data_lanes, DATA_LANES_COUNT);
+	if (ret)
+		goto out_error;
+
+	for (i = 0; i < ARRAY_SIZE(supported_data_lane_mapping); i++) {
+		for (j = 0; j < DATA_LANES_COUNT; j++) {
+			if (data_lanes[j] != supported_data_lane_mapping[i][j])
 				break;
 		}
 
-		switch (i) {
-		case NORMAL_LANE_MAPPING:
-			break;
-		case INVERT_LANE_MAPPING:
-			nb7->swap_data_lanes = true;
-			dev_info(&nb7->client->dev, "using inverted data lanes mapping\n");
+		if (j == DATA_LANES_COUNT)
 			break;
-		default:
-			dev_err(&nb7->client->dev, "invalid data lanes mapping\n");
-			ret = -EINVAL;
-			goto out_error;
-		}
+	}
+
+	switch (i) {
+	case NORMAL_LANE_MAPPING:
+		break;
+	case INVERT_LANE_MAPPING:
+		nb7->swap_data_lanes = true;
+		dev_info(&nb7->client->dev, "using inverted data lanes mapping\n");
+		break;
+	default:
+		dev_err(&nb7->client->dev, "invalid data lanes mapping\n");
+		ret = -EINVAL;
+		goto out_error;
 	}
 
 out_done:
-- 
2.34.1


