Return-Path: <linux-kernel+bounces-555070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8951CA5A52D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 21:43:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3840B1892B95
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 20:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2B01DF72C;
	Mon, 10 Mar 2025 20:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="n6hqXagm"
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC96C1DED4C
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 20:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741639393; cv=none; b=nyFV5bnrXXeSEU6lyKQWylcSQyWfE5s8Z7S6qSh8xtz0VjcspBsNubsU/yCvSXOnqSboZbYjhIMwXNcUkgmBx1LJjMxzAYROA9bf6SSVrhNl7klwG2yolS8D3qevK/XROmyBNdKEvzza0PfdsXUqfyq12BBeND4B3hOn6yeK15E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741639393; c=relaxed/simple;
	bh=0xf2lfBMlkwq8GDrukDrWvlzGt+OAqJxAVu2qGUaX1U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ken5yFuWCkKBdUvGK/P1IBC25p4gauTDLBXmB8HIXe4iXLecUEf52M77vSzJ8iyjJ+BmRC2vdQWHXFBj8OTebTn6iDRs6r8gmph7zp1oLJo6I2s/XZdApwatMbOnAU8Ap8MxJIeeAGxsVY6XOfjwbtneJ2GSy204pInILW/cQDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=n6hqXagm; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5fe944b3fa0so2154542eaf.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 13:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741639391; x=1742244191; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=epdj0pGglcLo1fb3QxJPZQv/lE+WglsZbV58ruZDnRA=;
        b=n6hqXagmka+4Nw0mNflqhQASedNuAW2+qwbRmRCHJlBVF+i5nNZW+qpNmakA64UrhS
         Ar/SlCFYpaKCmaTUaX6SBuvUi8EAsSip1URPpIQgOIePIuo1CQ5UjiAKz1X6Ae2pJefd
         jelbsfld/VB82/6WFOcPJIErttJEzUOprv9OskVwyKm02S/Mxh9CgLaGLdRanmoTz/0x
         eB1x66dzpBWwDAe7HbLSAJpqVMpHWpQ5ya/KWJHJiuAIjA/VlK1EFIyrQyiS4VH5hN2z
         uVr1Wk9LhuzzsuaypYD6a9d6PfobF0zUa2UEtPifSK7NIMMtaUTJVRwhltRHjwnlEIFs
         UAHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741639391; x=1742244191;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=epdj0pGglcLo1fb3QxJPZQv/lE+WglsZbV58ruZDnRA=;
        b=Xbb5F+4XV3VPeyEhl+3Jxd0kkwmmQP/1eQbjXjwgTe/X2zwnAnOiDsK/j3hXFoxJHL
         oSl3FrWMnXRS2SPHqTKOL3JoYHc55/X0TiV3Kqh9iMbq32bxxAEYTH9Y5DdxuVipKys7
         /z3GIj7kj/hkESojFl5Am/MDj9IhhRFldPj8nHLQiZVanLEZKqJCPHTvB9B01x9nWEUl
         Gyu8BPYBy1ZkROdQsXiSWXSDoMVWpocRUNj4I9ueYQoy6Od1BtqsnZjlwh4+8IETnQzp
         EHmPUa2bvdwPpAiaAz3gkv+BOuN6lFXYvBLlC0pj3L22wTfLPP9a6qpi3+wcXLh7spBy
         XGkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmwJHnnySr8DwRyeQWOX2rT/c7S1iDTyX6XjRPgOk43TxzNMyfy/7DkDr+lWc73HPbOhPJxCLsqWHEGzk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4kKvpNnz79fOBODLjspNIl7V2t+swqTpfIyYSJIisfumABotG
	y50lvhmy7ewvidQo5utxF6KLDX+FRa4zUqcaRbBH3APTXml/nuTbHMTBxH2xISE=
X-Gm-Gg: ASbGncsf2C1vXTdniREiEzau9reWXpfMAu0AfNApFcrfqEXU6nGFhIwFVe+gQo4ws4j
	LrP1PKps1Sj3QdJc1I/+Yk4slR7W0aITN/8H6kPKuFaKPIH+Y3n4uonWhot1ApPdIotfvwEm/SH
	d10L20g2g+ky2cIBR3Xgej2Af3jQBxgLDdzQLkQ89u5BT0YBJ4jNj1qtdwqhNthmf0JcT45Xez2
	ZFHWYoYhCr32jke3VRqOIBHvuo73FXR2bhMTiJAQyZAkbTutq/UlZo+5F5xjqD+rE4HBjU4yUee
	lqz6B55yASYLhlzwHk/n0O/P5CdtNoxMutSKkdWUL5TzlqazEU96qeJifVwpe2QGyMB/knAGdQ5
	CCcelSe+f2rM=
X-Google-Smtp-Source: AGHT+IF3tmx1kGHFtcRxx4TOJ+aZvJTTIq2iqIl6c/KAO5ngljUPVei58WxV+MNvlmlbqMMyOLaJYQ==
X-Received: by 2002:a05:6808:1b26:b0:3f7:ff67:1d9a with SMTP id 5614622812f47-3fa2c78e8e6mr559991b6e.36.1741639390752;
        Mon, 10 Mar 2025 13:43:10 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f855f69b1asm764315b6e.30.2025.03.10.13.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 13:43:09 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 10 Mar 2025 15:43:04 -0500
Subject: [PATCH 1/5] iio: adc: ad4030: check scan_type for error
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250310-iio-adc-ad4030-check-scan-type-err-v1-1-589e4ebd9711@baylibre.com>
References: <20250310-iio-adc-ad4030-check-scan-type-err-v1-0-589e4ebd9711@baylibre.com>
In-Reply-To: <20250310-iio-adc-ad4030-check-scan-type-err-v1-0-589e4ebd9711@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Esteban Blanc <eblanc@baylibre.com>, Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>, kernel test robot <lkp@intel.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>
X-Mailer: b4 0.14.2

Check scan_type for error ad4030_get_chan_scale(). Currently, this
should never fail, but it is good practice to always check for errors
in case of future changes.

Calling iio_get_current_scan_type() is moved out of the if statement
also to avoid potential issues with future changes instead of assuming
that the non-differential case does not use extended scan_type.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202503040954.n6MhjSsV-lkp@intel.com/
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad4030.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ad4030.c b/drivers/iio/adc/ad4030.c
index 9a020680885d93f4da8922e5cfeecc0c7ce23f4d..af7a817e8273496e8856a5ba1a9c2e66a11f0a84 100644
--- a/drivers/iio/adc/ad4030.c
+++ b/drivers/iio/adc/ad4030.c
@@ -390,16 +390,18 @@ static int ad4030_get_chan_scale(struct iio_dev *indio_dev,
 	struct ad4030_state *st = iio_priv(indio_dev);
 	const struct iio_scan_type *scan_type;
 
+	scan_type = iio_get_current_scan_type(indio_dev, st->chip->channels);
+	if (IS_ERR(scan_type))
+		return PTR_ERR(scan_type);
+
 	if (chan->differential) {
-		scan_type = iio_get_current_scan_type(indio_dev,
-						      st->chip->channels);
 		*val = (st->vref_uv * 2) / MILLI;
 		*val2 = scan_type->realbits;
 		return IIO_VAL_FRACTIONAL_LOG2;
 	}
 
 	*val = st->vref_uv / MILLI;
-	*val2 = chan->scan_type.realbits;
+	*val2 = scan_type->realbits;
 	return IIO_VAL_FRACTIONAL_LOG2;
 }
 

-- 
2.43.0


