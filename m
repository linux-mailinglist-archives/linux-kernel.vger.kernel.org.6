Return-Path: <linux-kernel+bounces-570024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCBCDA6AAF8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 17:22:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE5293BF35E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 16:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF081EB1A8;
	Thu, 20 Mar 2025 16:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="MMdhkUsv"
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F70019DF98
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 16:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742487737; cv=none; b=iJkwiHE5a6ymCrsHn99Ozx6JY6WGAMWJGFnFf2+EvOU9Nc1KcpMRMwT2elqh2mklt8Uw7XK+bOARod5dIgQdY1wmOKE+pdiMjkgxDGuHxhfUKkzNJppIZq0ehYOWf4wSReAphuHH9+8/d47D+yHmyAdP9/47RKT9OYN1H22sgRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742487737; c=relaxed/simple;
	bh=baXdZMpYZMQFEC98ABjVNqhaMT77K0PYCTO+rEXCflE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=GIQIf5770q69Kj+AsKlOv05dm1eVKTATX5FVVQPQ3ZRc9Nc+QbPu9AF1dTusFzMFyI8uhpq+CEmMJGYBdjTIrltdohhfXd3yU2/Vh7CAymeViKiMz4JqUl8qgpNKDZ3AaACz5Ejzx3xIK6MVvOmu+324xRoveCyRSXf3PbAwy1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=MMdhkUsv; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-72737740673so615766a34.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 09:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1742487733; x=1743092533; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K1q8PxXByFyxgJV41FsWeAnzj3IPlFF5hA9w9NPTGBY=;
        b=MMdhkUsv5ljJa8yaTxg4vgJ4rnffA2KiY/lAZ7C3SA9FpZsGfRP5th95F9hZm6iQ9s
         KccemdUOmeF6S/rutJLWNhTY9f8bodYNYkcFjYtivki6epxRhNy604/93Zb3zq3n9kLn
         yi7lo4a6D803rMOggL0UX+n5lKMFYLDsstsvAnhKH8ckZNFFG7LukUEsAK4nYX0Pj6PX
         vuPkatksaKuDx9pVr6/yPxe9zU/7RjD+iLUByATAszL/CSQRs8myFNBaoleMvbNsTHBI
         t0ph3N+x+OtjrfmBzmpAj6hkAKPjH6GB0Rhl+2jC0kCzDXFwDf8t5Kwj2P+LETm0aBLl
         pOUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742487733; x=1743092533;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K1q8PxXByFyxgJV41FsWeAnzj3IPlFF5hA9w9NPTGBY=;
        b=XyQHoniQ6xUrQ2N9iZ/NraqmY9GNXtv++nAtpqUAX3LMWByqGwOiu4W+Ns/PZvwegr
         fcwrHrbR5/mtR4Z/6VrvPMPX1ogZSEQ9IvvVwlikCf/woYkSH3KFG4JZUkSx8SL3FKy3
         sgCEWZl/6Mf2oqv6Thcwi0ZbM5qYcQraySR44nzit9IklgKM0Lc2MO7N/Dn9aphJ9hV0
         fjpS2q9dDf4jjcUfhMiY0wxg16x2wb71KW2Wpcfz+FQEUPK+rKkygj2XVIXzATpGVFC7
         Q23FtgJMSAsBIAhrvaAEEFBue2pipB9ahJRfFzT5SfW9aN7515J7NbSL4f1ngV43JPE4
         HUNw==
X-Forwarded-Encrypted: i=1; AJvYcCWAQAB31ususClHmrE8KGca5Qx7qxVuoImPXxzarkvzYDT1PPxuYcp0sEAmfOzZnfiJkPnIYW6ukZYaczw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIGNzsYodpkwEIyo5gtf6DW+KI0L9/f+D6zavYsiFgk+YZEfDk
	hpozlD1+2khkLa+V4DZKK+yOxFgjjpNHRnYKBGQtGH6OdS574B6jnHki2LX3emvDzv+iTSruf8G
	Pasg=
X-Gm-Gg: ASbGnctF1kbBU+q5ilt6ekNXi6MoA6vI9MizlrK1RUZ7cRW5zWpQG/T9wo5mh+S0VPF
	mvarJAfmRHsf8VweroBmpFPKh6lyQxXfU/0P6+M/bDaiYmr5z60AHefw6PT1hY8UxiM/RBpg/yV
	G9ujjFQDG0Ww75z0RdglHHstGu4i+RK8X5GE26tojt5KzU3GLbTR0QPVKsCUujNcs0PHUyFP/zr
	xABSCimlzcPdtU8qSzTrh22LecKWMlXE8CRze6FYXVDlQJ8hiLoGApcavNdeIJ7id3B4MbkYrn8
	G9Pla7BUcySVNeuE9K+KwWyTcaR1pJxnRCxPiHLaKlv71mQ/+Yyz0kuNqrXPqG2pQWtCdPfiPia
	n
X-Google-Smtp-Source: AGHT+IEAZT7cZkFi3N9O/7IkgUUC+ipDr7D1yuSmft24Q4Rr0rzYbqQCmkGBkC/KBVJ8ZoW7p0n/wQ==
X-Received: by 2002:a05:6830:718c:b0:72b:9cc7:25c4 with SMTP id 46e09a7af769-72c02e63703mr3004295a34.22.1742487733064;
        Thu, 20 Mar 2025 09:22:13 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72c0abcc1f2sm3616a34.37.2025.03.20.09.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 09:22:11 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 20 Mar 2025 11:21:52 -0500
Subject: [PATCH] iio: adc: ad7380: disable offload before using SPI bus
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250320-iio-adc-ad7380-fix-spi-offload-buffer-predisable-v1-1-6912ac8c0ae0@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAJ9A3GcC/x2NwQrCQAxEf6XkbCDdIlZ/RTxkN4kGSrfsogil/
 27wMIfH8GZ26NpcO9yGHZp+vHtdA8bTAOXF61PRJRgSpTNNidC9IkuJXKaZ0PyLfXOsZktlwfw
 204ZbU/HOeVHkmUYplq+FCGI2qpD+l/fHcfwAukE6LYIAAAA=
X-Change-ID: 20250320-iio-adc-ad7380-fix-spi-offload-buffer-predisable-a801dcfb9c00
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Angelo Dureghello <adureghello@baylibre.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1509; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=baXdZMpYZMQFEC98ABjVNqhaMT77K0PYCTO+rEXCflE=;
 b=owEBgwJ8/ZANAwAKAR+K+IyC93wDAcsmYgBn3EClI3Pa5Tr0wrsxXWIzbCMYcJ0fBD9bjJwjh
 DknTWpRQYWJAkkEAAEKADMWIQSKc9gqah9QmQfzc4gfiviMgvd8AwUCZ9xApRUcZGF2aWRAbGVj
 aG5vbG9neS5jb20ACgkQH4r4jIL3fAMg0BAAqBRIy1Z1KsEU9bRBzDpY9Lrsp9h+mOyeUxg2hoi
 a2T9iKDhOwr6dq4TksNbJdXBLmpqbc10orghnZbYdi2WFdL7laCq9fRZSJPZ19ma5oQQnh0mhLA
 TYtqR9XfPsM0QwvE2Jo/XYnc5TjDAoO0UTnxgtm2fGLcfT/3ZBBtO2kGAox/ji/nXOx/kwlajy5
 jaTFNIfooA+/B74EOBK0r7OtX+y4ZfeZDgPh6eg7IyXX8VMybrmJzc6olDSXePxaSwiyXf70W53
 s2xB0GX404PCE9927RkKOJEuFV1c6axPiENlEjbnL/EBSyMPuXYYF3fqO1BUPqM5RSnsWR6d6ry
 PmNaCAml7dEyib3P/MmQ8jvK7tjfEg4vj8L0cMdA5gK8u5ixNvBn2lO6drR03bx37s8edW9v56I
 lmZn3zBon4MJtD8NpUfpcZT5UV+VnROqlvs9xPg9CM5Ct4yw1DzZIlzOf4mqj+T8YEpjzIUn4/3
 VIE0pXeqL8yxdt9VUgQaw71rawiH7dCmzxoO2ZF1/rIpLPhtO1AJM1P2h/64HsBKwLQdJRGpbNL
 xBHx8YNKGtr4wMs9GLe7uOki/IyrD12cFl96AY+mPOhw9YJYKt1jSn0rfhrANnp04FWB0u6GplZ
 aAHkx5KHcrFaacV350HG29sG3KvH5+nCRQDU1HEndTh4=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Move disabling of the SPI offload before attempting to use the SPI bus
to write a register in ad7380_offload_buffer_predisable().

This caused a crash in the spi_engine_irq() interrupt handler due to
being in an invalid state.

Fixes: bbeaec81a03e ("iio: ad7380: add support for SPI offload")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad7380.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
index 4fcb49fdf56639784098f0147a9faef8dcb6b0f6..a2b41980c942e4cd1575bfe4f3846e297ad5d01d 100644
--- a/drivers/iio/adc/ad7380.c
+++ b/drivers/iio/adc/ad7380.c
@@ -1211,6 +1211,9 @@ static int ad7380_offload_buffer_predisable(struct iio_dev *indio_dev)
 	struct ad7380_state *st = iio_priv(indio_dev);
 	int ret;
 
+	spi_offload_trigger_disable(st->offload, st->offload_trigger);
+	spi_unoptimize_message(&st->offload_msg);
+
 	if (st->seq) {
 		ret = regmap_update_bits(st->regmap,
 					 AD7380_REG_ADDR_CONFIG1,
@@ -1222,10 +1225,6 @@ static int ad7380_offload_buffer_predisable(struct iio_dev *indio_dev)
 		st->seq = false;
 	}
 
-	spi_offload_trigger_disable(st->offload, st->offload_trigger);
-
-	spi_unoptimize_message(&st->offload_msg);
-
 	return 0;
 }
 

---
base-commit: 9f36acefb2621d980734a5bb7d74e0e24e0af166
change-id: 20250320-iio-adc-ad7380-fix-spi-offload-buffer-predisable-a801dcfb9c00

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


