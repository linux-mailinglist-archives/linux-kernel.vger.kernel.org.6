Return-Path: <linux-kernel+bounces-318943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 816AB96F57D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 15:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0ED69B235A4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 13:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9378B1CF5ED;
	Fri,  6 Sep 2024 13:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="htokuvNO"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01DE12F5A5
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 13:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725629725; cv=none; b=swBL6uyFHUlU6KICZDZfvIn7SzZk2FA3GGEmIKmYTBV/ryAoUuozMf5xw7nyVZjzHmPWsGaEtAXUi6/i/Jrs1boRKo+4k6DYnEWvnfXVOxz07fiQkPr+P/ihkVu/y6mbAfyHqAzX17KyYJVDA6VBM20D4nbOB7Q/oAK2tPNIdTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725629725; c=relaxed/simple;
	bh=I6joFYKtEZpmpOu7whQFwYwYWPHiUyzVlrs8QkUbiqU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G1PLAgqTTW1/UzKElh26vL7QbJkP4LMlX3gdHHf9TuwYsl+Pj1VWTlh4/J/V9Nnl/8uu2M/IoebGHmbcp6H00qSkavazvy8/dGiZmFNf73zrgXjNg5ey22CeCUk8qEP8gWo/b1YNgcAVrJa4xhesWELy4hGQ9oQQ2/he12xlKHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=htokuvNO; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-371941bbfb0so1311949f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 06:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725629722; x=1726234522; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RdCiYPdjlPcL03UXJdJSn9R8TB2L5xNznH8+xFLLXME=;
        b=htokuvNODO9EuQjaKOKRYsYn5BVEdRa+C5AzbWjQb9OXzTPp+hjHFb/cphjz61tDd/
         C4ciCymgYko3Ymrv6dQ7sb0b4jgPRQVL4L2KycUfkjZKyq7d46f9ERH8FaNIpR9fNcuH
         OMKkmnPtbHxmHoVbTMQJronT4WAIQqMRfwTlhnmQcHBD3BftyZUv7YI9zHzNYtcpnnxs
         rxAxb3ChQkv+xSvrlJ3ICokM17CykhpsY5FshAQZqr+im0yBG6UnkwZ2/kgTeA3xUakx
         fxUSbMetDSUN3+z3YCvEoQTH02jYMqwSO1eO53uK8evXXasJzmjIgkUetpfj06jpOla3
         KrlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725629722; x=1726234522;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RdCiYPdjlPcL03UXJdJSn9R8TB2L5xNznH8+xFLLXME=;
        b=VP1MSlvbGPpI+Xweqpx74UFidgxF9RbWZFvQLdsZ27U84D7qkrGV+exBnE7YJYSY5C
         bHcUpZiP0r3nR7hXOLv61hMXW6NnS1cVP3t2fu3brMksnn0R6eFgjyU2jFkSujSPdGwy
         c9TtSV32kZ/++xjU/Ps8dv6El0R04H5isBioYoeFpRbAwn9tEC54GnRW7ZN7rRWbuHAM
         yJP5NR0A5HiR8rwm/BAVFphSIYsp9lpELKymiILy0p2e3638ktMUm3ihmWLj6GVmp3h0
         kQR3Dm6W8b71u1cY0R1Z6/O1/SdN8zX2DDh7wOm+bIE4FKKHxRpimYkoL7maUSGPX+Wz
         IKDA==
X-Forwarded-Encrypted: i=1; AJvYcCXZXt5p3SiIhODsOi7CwSJsEmQGY7Qy8IWY1I0z5ze6bDNH7TEwhvPdB5l0mMGYD5hJFfbdUeeWz/PnZHE=@vger.kernel.org
X-Gm-Message-State: AOJu0YySbu36/+MTUwlvo3dH0fjLSfzYhlUx5+B0DkDvI5pznxTu1UxB
	FA6Js6ORJ76zGvV9EW8pniEjPJYcZgE683MDJwmj3CBAh7e9QBC3D/vTfW0ckJ/qn06g07aTo11
	z
X-Google-Smtp-Source: AGHT+IEwO1wdUIgNHfUjloM9p7/zFIXeW9bGZBl/gFhtcN9dlE9gFZ3qMxWb8RFlBR6gNKwxbZsDRw==
X-Received: by 2002:a5d:6489:0:b0:378:8dea:4bee with SMTP id ffacd0b85a97d-3788dea4cbdmr1782508f8f.33.1725629721865;
        Fri, 06 Sep 2024 06:35:21 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:b0ad:b504:10d4:481d])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3749eea60e2sm21684597f8f.62.2024.09.06.06.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 06:35:21 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Fri, 06 Sep 2024 15:34:48 +0200
Subject: [PATCH v4 3/9] reset: amlogic: make parameters unsigned
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240906-meson-rst-aux-v4-3-08824c3d108b@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=737; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=I6joFYKtEZpmpOu7whQFwYwYWPHiUyzVlrs8QkUbiqU=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBm2wUQZPuqhHgOSA7hBjezMd0lE2tAgtqtIzJ/g
 bQLwVOijb+JAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCZtsFEAAKCRDm/A8cN/La
 ha10EACEv7fsnJOpH21ZFCiItZ/Yqvl+n8x74Q1Gz3GCAc/jBem4TBUzXI6KtVmikN4Hp1xbDLD
 emfslboEq3eLb+CV1Cd3+f1tVDWTrHPl9v5lzr52rrecxAc1byBWQnfX8GQIIG+G5BLVN0NT1B9
 ekvTWohL/zIEsekBTTjWQW1s+n0TSsXO2wBYWKK316irfGP1q91T60SmnxoPoHeeMh+JsNClAD5
 oATwmBoEfx0Im6PXo7Og2aZsdxYUTkHJYIYgEYzhG99Y7ly06aVRo65pDtIn7JSKX95B2t/PUz1
 Flo8XVHGvqdiXTRfdAi4GRXHZuYB7cFafY/P/e1M8jFEkhaSUWzPAMZi1qrWfxjYTW4IYTdS8ul
 Y+Idcl5yZfRSnlr+pbsXfM7FXmPJEYXna6QY7FCwXn6Elf+FLRRB7ghZCygO+fl+bzpxBmgJugC
 k3QttDeP9hdF8b00E4I9OlXhUgDrkzKM375fYNv2GtTGSZRu0YQODBASHGHKS8wuQGvlpND7IaH
 WBAG/6x33vTHlrCl54/7IF64OMCwBSlRfHnRwQuOp3DmSlFPJlRYdrzT/6sHQIq1KxB3heHGO6a
 xWEfwzA9MZUSmlv62mF2hhCIt2bt8gEQHy9/IvanxrnOJ7Bc9tURlajy/rPBw7wRuVAAwF1o1tm
 bSnaYfrHA1sD4pQ==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

register count and offset cannot be negative. Use unsigned integer
for this.

Suggested-by: Stephen Boyd <sboyd@kernel.org>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/reset/reset-meson.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/reset/reset-meson.c b/drivers/reset/reset-meson.c
index 848c2d88503e..50bd2241ef2f 100644
--- a/drivers/reset/reset-meson.c
+++ b/drivers/reset/reset-meson.c
@@ -17,8 +17,8 @@
 #include <linux/types.h>
 
 struct meson_reset_param {
-	int reg_count;
-	int level_offset;
+	unsigned int reg_count;
+	unsigned int level_offset;
 };
 
 struct meson_reset {

-- 
2.45.2


