Return-Path: <linux-kernel+bounces-384620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3299B2C78
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 11:13:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BB2F1C21D85
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 10:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCDEE1D63DF;
	Mon, 28 Oct 2024 10:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jJtFebvL"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0961D5ABD
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 10:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730110354; cv=none; b=JTnvbI6d9zfQIk2v90hYaM0E2LEyFfdtyTfZXxlwivH0E6aMoU9vmQrdTs8Fc0nNmr7iWfTG9k9XgVk265wz+NXow9UiPYEKTJRINjKDHnwaIQnIspHiR3cVrb2mJ4jQ+wOz3bF2w5Ht3jL4DthIGzCFjQiP/cSkdJ9aDRritz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730110354; c=relaxed/simple;
	bh=CUtvkf+t59QX4prslptAVYmO9B9yIfrnRI6r3hKSoAg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=COXh+OY0LYbZV94aK4FTlI0TvWI82pwFqZ7YNz2ZobzH37GrukRW00KUXE5zRPGS8Hs6qieblgxQUJ0ySIaKiFCQVA2SEBgDxzyTUiBTgUNlj1w7N3JPJdPXPFrP8SGoRpRtcJMVy7X/0xqc5JhfnYqyBzCTK82U050SNLgzFJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jJtFebvL; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7b1488fde46so327173985a.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 03:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730110351; x=1730715151; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=adgmJOhHcaFkex36EFAe1BXPWl8Ng3rQHGIFjAA8UGA=;
        b=jJtFebvLLF0asJft9hXpQ6nSjl4dbDOVD1SFuDbo4Vk7qc2g4nwkH28z2JhA6sC/pQ
         t9hKRWlYJaAg08UYdWNkMmRSJT2GeeqWj52GIowJN86J79jdYHohkERrAYAJG9nBwIC8
         nJ8E9fipb28kE8RilyhQRekd7L4aooWnhR42Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730110351; x=1730715151;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=adgmJOhHcaFkex36EFAe1BXPWl8Ng3rQHGIFjAA8UGA=;
        b=BDRFbygukn9rmDTkZR7XnAObq1Cn7Uecqs+z4hLCKPbVABpzriXeYiprLaMoxrPwqd
         NnC7o69Tq2wBzsDD9F5FOcwhWFvsMM/cjSQrY1ohYIaxrR3qg8900RWYJELMHT6ekshy
         /K0HdbW2TaxK2LHK74yXqep96dc1nLEiXyb/5zHuOHX3uXyDH8b2fpSgiFLu4oHJzk+g
         JdlFgPZQIDAadx7c01hBHdQkkcts1tu6EZTdSkYcH0soQ6ztV9KqS92A+DLrxgVfNAP0
         5Wbm2uRXnANyK/NLk1Y6CykVNOPnXFnkr4iEQQrTkeR2DzhdFc/Ifq3aTD2tusdA6suY
         vyJA==
X-Forwarded-Encrypted: i=1; AJvYcCXUL1KvrEbI6/IdWYrlS/W68UJBK/o4aCamKp45Zx0PGcIS4fcXnFPMCJbzBSRwV7/2PlBemHOhKsmCnZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTIil26nVo6FCSI3m5TnTQcaR6ZtXpGKZkplYumgElPNvF1xW1
	lhh1OznSdhBAn5hTLJvFqot54xBRP+ASlEv+wNohgLfpQXTiqQpS0ghgvg32y0+AMq61l35Ivuw
	=
X-Google-Smtp-Source: AGHT+IEvNa1/u021S1k1XErRR5bkD/RvaCZqUFQg81oUJKijF5rpiMRdpeKxB40Z9diyYoooWSmBCw==
X-Received: by 2002:a05:620a:2801:b0:7af:cf73:d70 with SMTP id af79cd13be357-7b193f0b137mr1497661185a.39.1730110350726;
        Mon, 28 Oct 2024 03:12:30 -0700 (PDT)
Received: from denia.c.googlers.com (189.216.85.34.bc.googleusercontent.com. [34.85.216.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b18d279126sm305483385a.9.2024.10.28.03.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 03:12:30 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 28 Oct 2024 10:12:24 +0000
Subject: [PATCH v2 4/5] iio: hid-sensors-prox: Make proximity channel
 indexed
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241028-hpd-v2-4-18f6e79154d7@chromium.org>
References: <20241028-hpd-v2-0-18f6e79154d7@chromium.org>
In-Reply-To: <20241028-hpd-v2-0-18f6e79154d7@chromium.org>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 Lars-Peter Clausen <lars@metafoo.de>
Cc: Harvey Yang <chenghaoyang@google.com>, linux-input@vger.kernel.org, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0

We are going to introduce more proximity channels. Make proximity a
indexed channel now, in a simple patch, so the change can be easily
bisected if there are any issues.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/iio/light/hid-sensor-prox.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-sensor-prox.c
index d38564fe22df..0f12a8a83790 100644
--- a/drivers/iio/light/hid-sensor-prox.c
+++ b/drivers/iio/light/hid-sensor-prox.c
@@ -40,6 +40,7 @@ static const struct iio_chan_spec prox_channels[] = {
 		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
 		BIT(IIO_CHAN_INFO_HYSTERESIS),
 		.scan_index = CHANNEL_SCAN_INDEX_PRESENCE,
+		.indexed = true,
 	}
 };
 

-- 
2.47.0.163.g1226f6d8fa-goog


