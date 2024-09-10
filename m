Return-Path: <linux-kernel+bounces-323458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA5E973D6E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 18:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3D941F26E16
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 16:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082101A0B10;
	Tue, 10 Sep 2024 16:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ozSDcyhs"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484D01AB503
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 16:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725985991; cv=none; b=PsKup6uE4qrvLbjovn+e0oR09SDQAeobBU6Os6lEX+ABmUWZM33DDuEkilC7b3J7Ya3kZ/jnvon9lZmqneQeqqAzsz2+BeOTBryAbbf+WW3avxO254fIovUiDLLc8oPpmQnORuj4IuBLmlkUh4GzCXW+1ZnlB7zjozosHeRferU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725985991; c=relaxed/simple;
	bh=uFpLNDx7axOqsTgkkJPsc6yBsPXI/ygS3MYpVh8ixvI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iZK6llJlwzjNbAH0qIy7oTC5x5aoiSHHksBdxsEdXY2rGX72a8zZrN36rc+2BwJXQvVpGQLnIPxVl+P/TsikgCurIY9hF04HQHJ0zqT3Ez9i7DVbOxXsFbzrArnpWyK0aBrWLd7a/UUFgKj5XTnAEiyMHyPFWt8sjyYXLemICo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ozSDcyhs; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-374bd059b12so3547509f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 09:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725985988; x=1726590788; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0tSPL9hjXApUYKXuHpC3lX5106d4gltSKmV8tShxn0Y=;
        b=ozSDcyhsfIyz4pwJ02MkfIKv+Nn7vmyZJheB/PPYyV/Ew/sSuCTiAT0lGdu3lEpZPZ
         dxWXRVwY5cR7549Zaex3q1xZMSVKn84wwp8UiWEIyKDlFGJlate0cQf9ojMHHeqpwev2
         P+lYdd9Y8MGN7ZpQ+Mf7l2cErnMvZhHm2B8nTVdklhZf/E41M+ybU+9dTtfALpY4R6ye
         Bw+2GBmKffJwmGDwxZ3EaBbAkwnUxjYZWLS7kNk1WQomEyFbTkHSy584+Su9WjPxDUT7
         jVcydCkPeUmsELZWl2u0tVe9nJrM+X9mOimz3YJ34Zk8qmttq6F/janKEUF01cZErbBX
         zRXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725985988; x=1726590788;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0tSPL9hjXApUYKXuHpC3lX5106d4gltSKmV8tShxn0Y=;
        b=JwGvg17IFjsjdILP56wfyi2JM/pqkwYDeNk2xlPKGLi1lW9ysDaF1KBau6lUJIq+SN
         hEVrRI9VSCRiYGGtfb7C1jTfEq0Nt9UmnxRoxWyvkJBclWhh+/QZ57X28/CEveHPT4pc
         fLxfKOgqz5KX2pfRfSJYKUzY7CwdiA25FuOjHKrkXLWIbL78XXOEydGpCtxDO3hIhUBx
         m8tWCo9L8u3X4p8UKRixbsJlI9YRO08qf9pbk8gDMFpjVe8mYz8XkgyqI09kwWeh/K3n
         EORXjZPaO4hKFun1zN/prGL8i65ShR4ulWeGJ41QE/pK0cZ/q9Ije5alfhImisgkxA23
         gbdw==
X-Forwarded-Encrypted: i=1; AJvYcCUriNDE5qOewtPav67QToLNQhm+zqUrwgGuTONhpF+YQvN3gimc0Sx1WTvZhhyhLplZuSdCJmzSKw1rw0g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiJ5kDWRcJ8l5CMZ4IGHr7+Bs5BqRVcENFcv8bgPypkZTnoUNl
	qLjU6zUE128o1tydr9lB5mWrejckVMfus56KYOy48lA8CwGyKq4mB3QG7KjrJ9s=
X-Google-Smtp-Source: AGHT+IEAQR9BO+yAiqhladmdOuF5JjCwDfl9NeIYLrsC3j51II+i92+uH3mBlNCFN/eHNfMzuinSIQ==
X-Received: by 2002:adf:efc7:0:b0:374:c9cd:9bf4 with SMTP id ffacd0b85a97d-37894a6ac0bmr6234424f8f.52.1725985987538;
        Tue, 10 Sep 2024 09:33:07 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:8ba7:bfe4:fea9:65b])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42cc1375189sm25076025e9.1.2024.09.10.09.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 09:33:07 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Tue, 10 Sep 2024 18:32:48 +0200
Subject: [PATCH v5 6/9] reset: amlogic: add reset status support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240910-meson-rst-aux-v5-6-60be62635d3e@baylibre.com>
References: <20240910-meson-rst-aux-v5-0-60be62635d3e@baylibre.com>
In-Reply-To: <20240910-meson-rst-aux-v5-0-60be62635d3e@baylibre.com>
To: Philipp Zabel <p.zabel@pengutronix.de>, Stephen Boyd <sboyd@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Jiucheng Xu <jiucheng.xu@amlogic.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1583; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=uFpLNDx7axOqsTgkkJPsc6yBsPXI/ygS3MYpVh8ixvI=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBm4HS5Os8nvAWVam3MD2aXk6qjTKElTgYwG+Kmm
 81fEj+NPRWJAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCZuB0uQAKCRDm/A8cN/La
 hcGoD/oDe94aoo17S/5UrJ6BEEh90EQJYvYYF5PUECrF/0sE2pzULDxN6SQSJCoos6SZRTpKJDn
 KfICwBxmuB0xw8V4/nmyQedtEXVXk1Kf70mAAJv8V4NL2iSgN1sE2sIjopMdiFIGiFMLwpMbyVW
 sfadAYSoKlovdC61RAI/KhGdJC5E5Am4Z8yfbyte3uQRta5Exc1qZW/KIQURO+SOLECgobPOWn7
 VD/YoCt4b58k+36xBVn220LxPQ2p7824F159MBmZ+jlGLyI8iZGqmfpuSH05Uw1WAy1uRBIUEw5
 TffX4O09FNQK/YCrEPOoaoW7rMgmt/i2D1X18yNSShFBaBv1wWy/cVUZoRBIUzj+WItN2gu2hxE
 OUPLhhrdIy8HHDwZ8rmy/kYc5X41OUYb4SJyVIqdZzTTuFKByz4iiAaB2o2ueh/L3/Vwk1J+TNh
 CLiKbvfCwo6fYos2qhZKgxESTmGjT+h4jPrgke7pQL4MGr/oIJa8L+EZ2zbYhOqWhY3ggWTzqYR
 VAW1PHcDfflSvfLSj/kIw4TRupXEGn1E41vRThuQOfKjnk8Bq6p5tE7f+1hMERLbHgArN/8qRyF
 ujXJXCUB+iLoIivAAWgseixWB5eGPrQ+aNaTm9Jn/lcnjHjLzlPKJpLFH+LpMdtRlmHP6fX6jTA
 RfjUTfIn8IhRhXQ==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

Add a callback to check the status of the level reset, as done in
the reset driver of the audio clock controller.

This is done keep the functionality when the audio reset controller
get migrated to meson-reset.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/reset/reset-meson.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/reset/reset-meson.c b/drivers/reset/reset-meson.c
index e31c1b7c9e4d..af690d3012ec 100644
--- a/drivers/reset/reset-meson.c
+++ b/drivers/reset/reset-meson.c
@@ -68,6 +68,22 @@ static int meson_reset_level(struct reset_controller_dev *rcdev,
 				  BIT(bit), assert ? BIT(bit) : 0);
 }
 
+static int meson_reset_status(struct reset_controller_dev *rcdev,
+			      unsigned long id)
+{
+	struct meson_reset *data =
+		container_of(rcdev, struct meson_reset, rcdev);
+	unsigned int val, offset, bit;
+
+	meson_reset_offset_and_bit(data, id, &offset, &bit);
+	offset += data->param->level_offset;
+
+	regmap_read(data->map, offset, &val);
+	val = !!(BIT(bit) & val);
+
+	return val ^ data->param->level_low_reset;
+}
+
 static int meson_reset_assert(struct reset_controller_dev *rcdev,
 			      unsigned long id)
 {
@@ -84,6 +100,7 @@ static const struct reset_control_ops meson_reset_ops = {
 	.reset		= meson_reset_reset,
 	.assert		= meson_reset_assert,
 	.deassert	= meson_reset_deassert,
+	.status		= meson_reset_status,
 };
 
 static const struct meson_reset_param meson8b_param = {

-- 
2.45.2


