Return-Path: <linux-kernel+bounces-448089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 925929F3AF4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 21:38:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E05716BCB6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 20:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4870A1D5AB6;
	Mon, 16 Dec 2024 20:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="UnMC+KMd"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A8C1D4342
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 20:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734381474; cv=none; b=ZyaLdsd2To8h7oIZMgIqFLOqVXsv2zboSb36QNXoXeEYZLtRUcxZbsSNIEcmYoLqSt2l46bWAx1SnKk464DXVsrnkEGREnqc+PeLyQN+IQyy3d+cQ/b/rvUQg/PlBMd+DWklwhPPzEnaflvhTj+o0/MGot5ADLk+vTXxPlO1X1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734381474; c=relaxed/simple;
	bh=EHy5byuG6WbwH/WIoV7ON1vbDnc/Cuw0X71BpLN71pk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZcdNsn0uIAAtXsBRgRQCGwO/7zG9PBNSdkf/JmspVYkecoQEJzM83pt1Nl1WVHxWGHp2vwT1peQJ1qplu8n359cpSEpS9NfVEOtxhOBg5KONm8ipKNrVq9Y+Tf+MliURUHq3huuaafhwtKOrcfWmT+/SX+sYfMdl1h1B/zK0aYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=UnMC+KMd; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43625c4a50dso31421845e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 12:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1734381470; x=1734986270; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/uTGbHwpheP7ZTAGPT3M61/wOimoSAI/DIQJehz+WSk=;
        b=UnMC+KMdsaOANflEqx+9YBwxWI6Q6M4V6CwRaPkbZZrJIDjEYuUVl8YZcgSSByG41p
         hNNkDFdWoyedjiLVtJk+4bQw53xLm8zH8OiezEqxdpogKw9X5PURHkRz2kkhVCn1PKjK
         NJ21VDjP4p7ECTjto3PWRLe0zY4Hdpv3W+Eo3If12+3ARArQ8N6MVrrnvPxn6o7daRQb
         A4xStepoMfteVSokDz7V+j2I/tDzRgUHE4jhbd80+Hx86ADagfO/kLXSNILW3l5Al7UD
         vLPrI9vMMhb1IHBP/J1IzFBx1nVVt/pnjGsgmPEtp3HMC/VWz7Kg9W9Yxz7dgx8crLjo
         yU/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734381470; x=1734986270;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/uTGbHwpheP7ZTAGPT3M61/wOimoSAI/DIQJehz+WSk=;
        b=xC3NYWNgJgDmEqaT5Q8BagJzXAxLA2JZ0WJmrz297x9Rnu1qE5TMKAESjlUVd3X1LY
         SjURFuqcq6PAEIMuD7xss+HpoefVB4En1el9EuJFAqjFeYSPiayg8GyRCkeujbhT4R5h
         g1pTNN1LnRNkoEZy3KaGdnIfEbZ9pT3JP6HeDF1jtlDZ6VvZ6L+4we1QITDK6Fip7swp
         9IAqleGA4qjKSQsOQR6xgNKdkMVj1uhv/OCgmDIa5N5Lckp6CCRfEDN7jvwLtl1Dccyw
         kNJ3ERtYzB3rPydt6xc/hdiVJSEBBXLJY/CugTPFHtIsW7RMQGIauK+Yp4YdWiOz+Gn7
         2p0g==
X-Forwarded-Encrypted: i=1; AJvYcCW0MYcwSO9ZffPrnUvZpdpToBPDiNdzy3pyQW/L3aJ4IYVHaJO7dabJeCUNVg9EY/Hfhyc5K0SQiUmDOTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbU8iiZjpQIE14U8qRT9E9GuFfoCf6lEckhKfm/WcZNmKX2wjP
	csp/Ws0uI4tDl4SsB70zXOkIsbbckbGsDtMAJxyiTw646MgrVyJUlnEJjf1DjlA=
X-Gm-Gg: ASbGncv7DmCAQAU19bXiX5hYmECqmp8vCMMtBa6Lspngn+CB/tUbeQYEGWZeaQyGYHC
	UfI2PPHpgROU1CrfQTl9EHAJ1LzpuvAbEeF5BSjpqGUyXBX5N1c4Q96FaZW2y+tAxK6nU/+HtLr
	cLb1tBBXI4/HodxLr53oKR3uNV2v1OIbnG66AfIFperojjF+8oHtkARJNVLrbem0h0AREj2nmhm
	4Q0xZbSeVHbJjplPiSiQxMkLxntzEdrOeBIPPC4jRKquP1e+XQvHAHgFb7vJfn0AIZj2p3jCNof
	6su/xwJDaAZvucsVxd//KNNhv2QyWCNbcg==
X-Google-Smtp-Source: AGHT+IFNCWVvRQ7+f8hFiG7JbS7X72/g8umDwwWJ5AyRvkEjalQbahlAC2N4g/Q6vqIgCI1W5i1cmw==
X-Received: by 2002:a05:600c:214a:b0:434:f7e3:bfbd with SMTP id 5b1f17b1804b1-4362aa947admr126088855e9.23.1734381469651;
        Mon, 16 Dec 2024 12:37:49 -0800 (PST)
Received: from [127.0.1.1] (host-79-17-239-245.retail.telecomitalia.it. [79.17.239.245])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4363602b468sm95514245e9.11.2024.12.16.12.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 12:37:49 -0800 (PST)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Mon, 16 Dec 2024 21:36:22 +0100
Subject: [PATCH 2/8] iio: dac: ad3552r-hs: clear reset status flag
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241216-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v1-2-856ff71fc930@baylibre.com>
References: <20241216-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v1-0-856ff71fc930@baylibre.com>
In-Reply-To: <20241216-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v1-0-856ff71fc930@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Mihail Chindris <mihail.chindris@analog.com>, Nuno Sa <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>, 
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.1

From: Angelo Dureghello <adureghello@baylibre.com>

Clear reset status flag, to keep error status register
clean after reset (ad3552r manual, rev B table 38).

Fixes: 0b4d9fe58be8 ("iio: dac: ad3552r: add high-speed platform driver")
Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 drivers/iio/dac/ad3552r-hs.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iio/dac/ad3552r-hs.c b/drivers/iio/dac/ad3552r-hs.c
index 216c634f3eaf..8974df625670 100644
--- a/drivers/iio/dac/ad3552r-hs.c
+++ b/drivers/iio/dac/ad3552r-hs.c
@@ -329,6 +329,12 @@ static int ad3552r_hs_setup(struct ad3552r_hs_state *st)
 		dev_info(st->dev, "Chip ID error. Expected 0x%x, Read 0x%x\n",
 			 AD3552R_ID, id);
 
+	/* Clear reset error flag, see ad3552r manual, rev B table 38. */
+	ret = st->data->bus_reg_write(st->back, AD3552R_REG_ADDR_ERR_STATUS,
+				      AD3552R_MASK_RESET_STATUS, 1);
+	if (ret)
+		return ret;
+
 	ret = st->data->bus_reg_write(st->back,
 				      AD3552R_REG_ADDR_SH_REFERENCE_CONFIG,
 				      0, 1);

-- 
2.47.0


