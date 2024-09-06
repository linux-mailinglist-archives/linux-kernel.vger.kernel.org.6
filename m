Return-Path: <linux-kernel+bounces-318941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9678F96F57B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 15:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 564C4282FEC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 13:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB941CEE96;
	Fri,  6 Sep 2024 13:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="V0agq/bh"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E1D1CCB42
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 13:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725629724; cv=none; b=QBpHleN3iqyttDK7qwCOzcaMqJa3kYNN6VhIwFiq7RBY3oYjoWk4WVgUdk0OOWElzSfkBYT8BBorsp0RPVvxLXyNW5ujLUZre3hFRApksxsJhZY6OFdjsWrqf/zrKYAxblE1ey7mxoa23wALN7wbsXN6CT3fAGgi0H9tx0PUdVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725629724; c=relaxed/simple;
	bh=TBFxeGrFtyl6fNkBC1RzGGAepksDKxjvf8LT6xC71TA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aQRS5K1oW8BeSThVjkgsn07iXdqDWDT1Yr1rTof3VpgDfh0tY4RYnjxplNT+gxbbcNZ1YqDMNu1eOIsO4Q7qUwXP5LR5BKEHg2a9xEo3NxM0VgdCkphR4DGJ4DFkbg/tgrNH5ohw2XmbzeoKoubxGMSSP3O1gIggcZDnzt57LDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=V0agq/bh; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-374c6187b6eso1225299f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 06:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725629721; x=1726234521; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n0U3ETN12gpBLws4jxOpUFqH+6wugx8Wdm0xkOdNhP8=;
        b=V0agq/bh2yGRkfIHoalrsjTEWk+8FaldB4IFvN3GNql+xHJSfFOr7EWOpaigIJZ7yA
         7eaM1Aalfqxy/jCqnb4Opyu79x2DGIggsoHuyeANtTl74k3nxxxqxSayfgCVvKP9QYHe
         R8RCHaVHXHwbs1bPz0dGx0fzlEmImTOB19qsdXbwiHUzVL7vLno3fFx/Fp9fEKM/O3XE
         cE/lxrOrp/oqGgCFvFGCtUDtmbAtXjPYXYRD82ZJBz4k8UgUIhLqAorFSjTrMFd2jgu7
         SVbtLJpEzslc5/dWsOTZWIEkT6VrJRLf9rbCMWnHQfvj0Zp/dhbhLSehcImMNQIDrU8y
         lXMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725629721; x=1726234521;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n0U3ETN12gpBLws4jxOpUFqH+6wugx8Wdm0xkOdNhP8=;
        b=snJZb2KgC/GYfsMAZTmGdPCObje1xysn82uw1gl1ULR9x6MYbADly3NE7crz4opSuf
         ueCyuMRtjGGR7Gf7Er6cwi8aIbJU/3yrELywqVoIwZ/vhmmmCEtRKxuTIH7L84VTS8kj
         l2fSHhkLPwuH1S0N1ROrvjMBjSMSmuDu5blUYJvlGop64ezlslgd314rQa7tzWj/7SQo
         QBf16u1wjS7A8s1EzXgIdIwdZL3OJ615+yKge4LC3lAJtpMUQSHhGjjkydNj03ulg6zh
         ZJ9v1G+UC5JYOYeBjTKX50G5mT+fG09Jf6ohddFFX4R6ePbU0A8FD7IHDflY4s8WUf9F
         Kltg==
X-Forwarded-Encrypted: i=1; AJvYcCWURYjgix+sWuA6buki/h+8fCb2ixeCypoPpjTnwdX2DEmrXUEEaSFDSTNCzJbtJTr8uI2alse+Mcxp/BY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGwPcknLmG0zhfYFu8jBO8RttkM0+rn3RKTai9l/+i00HKa3WT
	GfV5YZJA0ZDAGqvYcMfKykFqJD8pR4Nvomoi+lSKYDsDCJhcBw3SWonhFSs1Z4fuvy2ThYzZxA+
	a
X-Google-Smtp-Source: AGHT+IEck+AkM1e/F0oOBSh0/l7dodO/LMFTYdYmPo9Gy7QWWQWyEDnvdz0QhdH2CJo/6tO+xwN3iQ==
X-Received: by 2002:adf:f582:0:b0:374:bb1b:d8a1 with SMTP id ffacd0b85a97d-378895c8952mr1681058f8f.13.1725629721019;
        Fri, 06 Sep 2024 06:35:21 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:b0ad:b504:10d4:481d])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3749eea60e2sm21684597f8f.62.2024.09.06.06.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 06:35:20 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Fri, 06 Sep 2024 15:34:47 +0200
Subject: [PATCH v4 2/9] reset: amlogic: use generic data matching function
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240906-meson-rst-aux-v4-2-08824c3d108b@baylibre.com>
References: <20240906-meson-rst-aux-v4-0-08824c3d108b@baylibre.com>
In-Reply-To: <20240906-meson-rst-aux-v4-0-08824c3d108b@baylibre.com>
To: Philipp Zabel <p.zabel@pengutronix.de>, Stephen Boyd <sboyd@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Jiucheng Xu <jiucheng.xu@amlogic.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=817; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=TBFxeGrFtyl6fNkBC1RzGGAepksDKxjvf8LT6xC71TA=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBm2wUPlC/gkEKuYmmJSQFov72bIlxBAfcOhgW4+
 tmdinirt7SJAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCZtsFDwAKCRDm/A8cN/La
 hQTKD/4pjOSZAMxRwxoSirqwtsKwMZIFFQfvnMpj+2MVvE21rHthawohviXi+usbOJmPUVQRXAJ
 HHFX1T+o1qac3mBV7OJnyYJUAa9oyOuAEtLVCacbf/7TWUqZMXkE94/X4wCXh4Yt1BXpb8Q6oSU
 fIO6fPEWnp9RMgV8/nxVDYsV90TieDzn4NSn83gi/HVVTNJ2yXNMy2DjFxnuX4z4SfDIx3z8vlq
 DItjRZA468lzaiwM296nMgxYQsaBbaZIYHJbNT9GR8RJZB5GHo/3mQc/+TJavvQ3SD5sfbtQ9PE
 HTz4fwQfparPEt/35j1yhRdt03MA3szrle8mRZOTGA65+ZqlnHRrS6wdMl9DYApZbWbZ7lllcKC
 df42W1hHxnAPHGO+gpFakwaSQ9eNrUgS3p5Z3fQ6pZ6FHhltqf6pSbKDUh7YwTMctpA0eFgoaBI
 pDTfOkbf+ssxJLITWhuK0vCpTSuxUP7HjaKS9ImfIN6RNskQnkW6uGtuk5/fcWR2bEgy9MTorKU
 piCPrf11mlVRG3eqdlUyn73x36SIg9qHAfpSe8mprHa/ns8KjOlQpdbeaPS1jlvr0OVz4ky8Xsw
 3xH6ZVD2EvQvgiXrz/y1T7v1MNRxSV187cbhXr6cfzb79j5HqCXVQZ83oi/hgop+0Z6dVJmkJ0l
 O8Q4U8PHuYbHXdA==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

There is no need to use the DT specific function to get
matching data, use the generic one instead

Suggested-by: Stephen Boyd <sboyd@kernel.org>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/reset/reset-meson.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/reset/reset-meson.c b/drivers/reset/reset-meson.c
index 9dd38cc209e2..848c2d88503e 100644
--- a/drivers/reset/reset-meson.c
+++ b/drivers/reset/reset-meson.c
@@ -134,7 +134,7 @@ static int meson_reset_probe(struct platform_device *pdev)
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-	data->param = of_device_get_match_data(dev);
+	data->param = device_get_match_data(dev);
 	if (!data->param)
 		return -ENODEV;
 

-- 
2.45.2


