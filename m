Return-Path: <linux-kernel+bounces-416341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C802D9D4380
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 22:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68044B24100
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 21:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4D31C7B63;
	Wed, 20 Nov 2024 21:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="PpZ1AOlr"
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D471C4622
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 21:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732138446; cv=none; b=FlDEkKfJLF10F/idQ6cttMRDKXeUTy9bGUCxY1z0e4RbHviYfqYMMfYUOApn4jASX9MTG+myKZ7xPz5/uDwM8XWlRl7VBf29MRFGP+0sbKoOnla/MS/RFgZNm7ZRA7zknaeMitkqe5nkwktNGFrbHNCFKJCgzyjC5Zb+PWIHaWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732138446; c=relaxed/simple;
	bh=CDa4K/qMrZy2Vk2sOAtkcJn6wgLoYlOypmZEq0L+kMw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P/TOBHRr46l3UQNIQQrcleKiyCUT1UjTsoBx1s1ar17CpYS0NQkUFOL4QdRVhi9udAJhFulMyX2YAsbyhfgATQhC7HhWCiPn2JYG7ZGHlfiB0dTUTojaX/NNiRaxZxj3xb9o8cHZ65c5awbgGUiVrrmZtzcFT3vfNd8MCrTSB4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=PpZ1AOlr; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2964645d2b7so219921fac.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 13:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732138444; x=1732743244; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yw+ajRa8KccOrwd0yiTrzG6Wjr5FRjEkQmVdFiXTvr8=;
        b=PpZ1AOlrfZcpa39ELZXWUwBllV9lPpzBuI4mRuUclngjPu3Ows2SBDzpcRj5XARE5o
         728I0JhdLyUj9CupRkWG+ec36eKSIsVGo5nEfm+0Z/AVdZgkE0rgtNv2Zslr8yZLA/vQ
         gCepM6Hg8so+gEgRyDsWDqmO2K8y4womYlqhMU5NV1KSDJueTxGMV0W1q1qatWrG5W4i
         QJgMyiF9PZ6BBz++Znm9+FgH1+uspHA3cjCupVj0N7KkIwKABFB9fyNWXoW+Crprpxsq
         Hn1xNcyXNQ0DLB2IAd329yFbmb9+xFQchJeIrobpFFpCWUxod60ncNgjxoNbzRRaPPd2
         PAvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732138444; x=1732743244;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yw+ajRa8KccOrwd0yiTrzG6Wjr5FRjEkQmVdFiXTvr8=;
        b=WooNrvpNFIhmPjMDcanVDHbQ6eCr0c8G6JAuwDvGsPiyURkr4sO+w+xRYRnxMUwMOY
         yBRWyjw4eRhy097kBaf5oefBiewUufvSQmOzxAA67+H1WJujxCXY7BPSO8CRBDnrzWHW
         YPdB8gEhRh3DzHTgLlt1vFSHJ7cUDyuB0g7LOKFwgnJ/nthMdQVub1MZGpOgDRvp27F1
         TD8HAoI9nlZA3bAPrg0v6e43Sd9rNZZO4zm8cJCiIrdK/NxrtWZavCNGwkT7TqdOLx5A
         cv92M/vFNTureqcGrautk34V1vmNe0+QWgBDScRwqZty4kuQ7AaRC+dN1tUHpgwJKfu2
         fuCw==
X-Forwarded-Encrypted: i=1; AJvYcCW5YyDk/aiGAE2x4OhiqWvQqO+lyAMvB0RceF4K1UTCPiI+7JNGh0HSGMvzpEEwNjp8x1J6cBiR4wQeD4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEVGeuRJzvs8k/Df9rrQZ/7FRkPbWd99h+p28Kc3Oshq6EU7Mr
	j7qNx0ENWAf4CME7zZ7ufPzVJe4RnDrFsjNRoOh2WzDyG88rEkHzY+PNQomiw3E=
X-Gm-Gg: ASbGncv6vIXidyBiRXELmviBu0HtDr8EPfYCn/5Zu0jqxZSSV5yQz13fioBoOk0T7EE
	cjVh77JO+J1NfRIhih53hZVSm81+voL/IQ2ejT5GB5tV5cCVRaHb5J32B6DNLBmX5R/XajTAnwz
	V665QPRcJW6agmuJU3khqOtyKtta+JUJanvnQ2FT1f7/Et127yXo+l/tA1PU+PLDi7R6pMqr33g
	38ZYxOUVvkdBLgM6NMU9+mw4Ro6BdlrzhOZsXO3dciOcKYH557xANW1shT1q1A5pqENiU/fdP7N
	5Hkbqw==
X-Google-Smtp-Source: AGHT+IFt3OYUTddzXeyXQxe7QYviNNpiS7sqQ7XHszAFayFyZfwLOK9wvkkKMZ1SNhQi+bvcF8zekA==
X-Received: by 2002:a05:6871:d084:b0:27b:55af:ca2b with SMTP id 586e51a60fabf-296d9b5cd91mr4192758fac.11.1732138444351;
        Wed, 20 Nov 2024 13:34:04 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29651852c27sm4487365fac.2.2024.11.20.13.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 13:34:03 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 20 Nov 2024 15:33:25 -0600
Subject: [PATCH 02/11] iio: dac: ad5686: fix struct name in doc comment
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241120-iio-regulator-cleanup-round-6-v1-2-d5a5360f7ec3@baylibre.com>
References: <20241120-iio-regulator-cleanup-round-6-v1-0-d5a5360f7ec3@baylibre.com>
In-Reply-To: <20241120-iio-regulator-cleanup-round-6-v1-0-d5a5360f7ec3@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Antoniu Miclaus <antoniu.miclaus@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.1

Fix a copy/paste mistake in the struct ad5686_state doc comment.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/dac/ad5686.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad5686.h b/drivers/iio/dac/ad5686.h
index 760f852911df..5b150f344fda 100644
--- a/drivers/iio/dac/ad5686.h
+++ b/drivers/iio/dac/ad5686.h
@@ -115,7 +115,7 @@ struct ad5686_chip_info {
 };
 
 /**
- * struct ad5446_state - driver instance specific data
+ * struct ad5686_state - driver instance specific data
  * @spi:		spi_device
  * @chip_info:		chip model specific constants, available modes etc
  * @reg:		supply regulator

-- 
2.43.0


