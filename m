Return-Path: <linux-kernel+bounces-555074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86521A5A537
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 21:44:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 782B11886119
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 20:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36E61DF72D;
	Mon, 10 Mar 2025 20:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="gN4ONqFq"
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB941E104E
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 20:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741639402; cv=none; b=HgW6GBsujw1nm8OEfyFsPaCWnPWXF7u/y/9PgXv/MN47rPKQy2bCmzrgL1V1Lu7aS7TcjS9ocOI2uP4kOGN8qteKiK/BFqh4K348xBGN+4JR9Ym5A5x+d+lSosVkd0waX2sKPNHhHAIilcwqFlsSEnCJRMNYs3o+YiPT2Kqmlg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741639402; c=relaxed/simple;
	bh=fy3YCEIhYXyfAtQCLfJyFl5dLmJOK0fZMwPIbAJdXh4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZdqbcVfn5xVwEniQDNkL3m7J51Vi5ODYGiDhS8nOKagtM44Z9o36GbjdwccR1gMSKvRn/L7/+GN7ISqthkCRliRw5bFlMb3pTkscUu/kQ5sgMoFZp3ByELYg80jLouDglHQQcVPU4e79BogudfuD1Tt1gOjostcTuiA5x3370do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=gN4ONqFq; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-601ad30bc0cso831812eaf.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 13:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741639400; x=1742244200; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J1AkfraDMLpclf5PdJvYaweOQN0fYlysTRqs642bX38=;
        b=gN4ONqFqXpCZXYZa1f04VYSTCT1ByZqOjVf0zFSLbuSlq8bhjV2K2w2u69iYnsuEpC
         E40T7+kIbg1abNLY6P5PL8KcjfNBbY149mT/3EY4ZyBrIaJgCsP8uzI1YS7I0mB84rey
         1RvzP3jWSmh+alAbtP9WEYy+hnKSbmpQDvP3WQ0Rcx/2t/hxLMdMhsnZZcDfIpxbP/vl
         iUe7XZVrGv5WKHmgm4HBh9TRO2hr/xlnsv81eEAPzkyN5uODCTLxmxpiw3z95qR/v/Ld
         zZRYS7YB6pa7dEum1UEAhxdiH/WWVnOGnmKDiNf1hMHy2Q9uAfGraGynpGDYSPRcHXbc
         XRgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741639400; x=1742244200;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J1AkfraDMLpclf5PdJvYaweOQN0fYlysTRqs642bX38=;
        b=DcSCbbgZjqN/cNs1On4wQmRGc73u2J/Nb0EpHXXH9Dxw9V888rHw5nyY7XmlzVqRol
         FqEUOYAcKSu085H1T3aOtIMUcNt75fKxWd2eTaTQUAEEnjdwSWnDGXYIU4LLaoAX7Rpb
         UPHGDD9/P/LmmewnNU3CsxmMKMzLtT3yzgxllKo0Ncz6GCA6op4bwyaBFAP0EEMLPoxG
         M79d2Um5hjsyznrBvaYuirtz1YlhINKAaLk5akI0aHJ+RrNv+2S+U6v8yLpeSzFysF14
         cXvjGV4hekiwhN8QYAV5drVss56x8uWOVz6z4JeHv8xLagshcj5n6/nreumD+DtY9RF7
         EtmA==
X-Forwarded-Encrypted: i=1; AJvYcCV2C4w4NJoNM7kw7/ZEHX647fmyUIQnLhM5O5UtVk/+b2v/b/GPgQA/LJS4OuYrdwq/95L/U8nN1Qt9ioQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpixiV+zT2dyDtEOBiqsnvGSNmc0zaudHAc+WfWEng0Hg2nuR4
	S5d+dN22LVrDvACfuAKEvLf513dwR481MbWRbOSCimCYTRP4JDqfcJTAP/Mi6pc=
X-Gm-Gg: ASbGnctIIj6WC41Y3+gkeg/tqXsLgDvWRP/Kcegm0aoUwmu88ac+Hfto45bzOQx3x0L
	EL+qAor+v0MgVxzgndSugP5iIyEhEY9INmvqEF/U2mE6tlJnoBfgSRKA3105Ad0E52w8dWwHV9b
	cyu0R01ZS/mKJ8ifMTgVXN4ZBGFvqSZUoMxJURS0f34EBJb8UjlhmH/6MD7WJ3Xt6/WpFC1hfOY
	HB+jIqn/tTywNJ2Ml0wq7HS+tV62icdSQkRDbhNDs0ILz99Y1GuX8PNiqJVf+XR8juYCCGjZkye
	0hPx0VilVA+OnsIdr7vQGrCO99fNmcfV0kKim/+DucR6HjpPcyH/gVU3X/K25J9WxLIqtTUMWhz
	v
X-Google-Smtp-Source: AGHT+IFjnN7xgqA5S6WxW9zh3aoenUjvYW1xuLxTRrObH49wacCSqx5z5F6Kj5S5n7YLILh9oajgoA==
X-Received: by 2002:a05:6808:4448:b0:3eb:5a58:9b6b with SMTP id 5614622812f47-3fa2bdc5125mr556668b6e.11.1741639399765;
        Mon, 10 Mar 2025 13:43:19 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f855f69b1asm764315b6e.30.2025.03.10.13.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 13:43:18 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 10 Mar 2025 15:43:08 -0500
Subject: [PATCH 5/5] iio: adc: ad4030: explain rearranging raw sample data
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250310-iio-adc-ad4030-check-scan-type-err-v1-5-589e4ebd9711@baylibre.com>
References: <20250310-iio-adc-ad4030-check-scan-type-err-v1-0-589e4ebd9711@baylibre.com>
In-Reply-To: <20250310-iio-adc-ad4030-check-scan-type-err-v1-0-589e4ebd9711@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Esteban Blanc <eblanc@baylibre.com>, Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2

Add a comment explaining why the raw sample data is rearranged in the
in the ad4030_conversion() function. It is not so obvious from the code
why this is done.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad4030.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iio/adc/ad4030.c b/drivers/iio/adc/ad4030.c
index 54ad74b96c9f256a67848330f875379edc828b0b..636f9f33e66af73d102722b984dc1230e1417d1e 100644
--- a/drivers/iio/adc/ad4030.c
+++ b/drivers/iio/adc/ad4030.c
@@ -646,6 +646,12 @@ static int ad4030_conversion(struct iio_dev *indio_dev)
 					   &st->rx_data.dual.diff[0],
 					   &st->rx_data.dual.diff[1]);
 
+	/*
+	 * If no common mode voltage channel is enabled, we can use the raw
+	 * data as is. Otherwise, we need to rearrange the data a bit to match
+	 * the natural alignment of the IIO buffer.
+	 */
+
 	if (st->mode != AD4030_OUT_DATA_MD_16_DIFF_8_COM &&
 	    st->mode != AD4030_OUT_DATA_MD_24_DIFF_8_COM)
 		return 0;

-- 
2.43.0


