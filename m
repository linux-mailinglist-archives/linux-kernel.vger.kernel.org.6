Return-Path: <linux-kernel+bounces-555072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D58A5A533
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 21:43:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52CBC188F594
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 20:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460F91DF24A;
	Mon, 10 Mar 2025 20:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2QBWZ2je"
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0091E0E00
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 20:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741639400; cv=none; b=cjL8K1DD89zqv/VHB+EzMWMl/0+/t7Ilh8I3UFqkfqYNR8F3pcPSWWJypgEwJhTX9ExhRoShdX19usbWf1ZBY0kJ5fk5ZgycS4rML8OMkNXtoYoRJNb5kNLkr+TdsUt5Y+doeq9WhTQxMGXIEm9YvMpMyKcTwC6iw+GkcjT2z6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741639400; c=relaxed/simple;
	bh=u5ePsmfcDhDkeOwFNFmtVTRv9Rit4LfnW4jtEHfO+UI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bIAhozCsLN72lRYvTtA3QnEWyYCMteFwO2LUxP5TMvW885IiIFLlfsThh85C6qssgfX09cs7hKEFSo+cGp3oVaRvGUWU3Q9VtooOWIj13/ggOSJte2DqXDsNIQzehjj93JgYn6OydOKW97eMWzw3m9LnrnyS+rhu5dTm3hfagrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=2QBWZ2je; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3f8ae3ed8f4so756817b6e.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 13:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741639396; x=1742244196; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OCuzGiRhkz0CBFkmeuLAdFa7ZCDNUYxNv2hZAmPEZO0=;
        b=2QBWZ2jeRvH+x2Yd4Cnq3fBFXtxl+lCa8ugpxYp0AlArhQ+9lNadxKS/s5m84keVe1
         EqlzsNQknkQTsyq6OVq31gzv0HXvb1z7p4n+r4p33Yr8ZLS6bWDtPEEGlC4eIE2hgk+3
         /XK1POM2Kt9QhYhHIfJ8Qy0/ZU/rWoPbrXcZvHFVKm23qOyXG26pGotVOqyZCXNVei2X
         rskPGKUR3K8uzwYNQpx30afgYf08dabGcvb5WNDqMYuDEpWjwBZ6ST+V0hzwlfSWgLLM
         DCwSNn1sU3PnKxOoA/8sF+CQJr/KuI8q6Wcx6a3egejludKKaWLsvzLTN2bRUhDaiqgF
         7hEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741639396; x=1742244196;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OCuzGiRhkz0CBFkmeuLAdFa7ZCDNUYxNv2hZAmPEZO0=;
        b=TiKymeWFPmQUdhibhVhBjkMzlJe9BNClmrHUmVlyM7KgSjGXYvVnc7wHIHikBuk7ab
         iUFZfEAmPDEJziaS07BRcdYRebqRfOaT8sXLP3DGqFhnewp1fClBgwSX5C569g08HcOm
         +woiMWoIXGwwRi4h1Ki3kKaOQIKxQhEUBd8eREtm2zjF0haq/lnH41XOBRBorVx6FPbd
         gI/7Cc/9M5qsCGbEIkIFO5lJTKoWQ9fNb8BnyPz5GtjAWO1hriCJcRiqBBPRnJu9FZfq
         8IHwxusyweFEmd5tSss7Qk1BsYwvzllVNlhTTRxdIzkE/qVR/0YTUHaKxQs+s/qH0ikL
         LgZA==
X-Forwarded-Encrypted: i=1; AJvYcCU+Fo7tWvN829xjiY5dcxOMvnj8aaVyLFfkB5LSg5SOCSZHMO0h5dNyKFadi+AJjQNEiLwsQW+uPglbCko=@vger.kernel.org
X-Gm-Message-State: AOJu0YxokrDNwDMtS7Gnd1zyw13g5TGtUacpqm31cKJiPTbtcYBAvEl5
	Vy7zmmfVqz0TAPDSrs+H+IWlbCfNzmI51VcnT6bmqJSIGusmjWzVA1Ro7k0Io38=
X-Gm-Gg: ASbGncui026/4k1wcAkUpp9uJ1vnHK1EL3YTKw6xBURuHEf9Pyz9UwGxrb9yNrwin6f
	V3IwuYCbb/1gL272RO931TE8P6mDZPN9vs/pVKxTwsI85HYzlycVKBbWRU+t0K4Oh3YTGN4XlZe
	p1cHw/Di6NSkaS4MUwT6Ob8zP/ZZ0mUo9GdkKrk+3p82tFem9LgvDzn7UNV3FWiC5lkW4ZeCMXT
	kAkaMVsND7y++YtZ3L7UBeM1wA4Bf77RAvJq/HB8W9xbm1hb2ZysLQMhnA2peLLqdUPTLyOLO96
	8CxeIW1CjA1w8kGulGXOFe8HIhW6pibhxxhjds6+mlYJyUf87Zj5F8JWOqu/ECYaJFnZSb4iVBI
	j
X-Google-Smtp-Source: AGHT+IFyOgnLNUP09CaNVpg3/60xdXC/GRP1hdw7pw4FVDHJLFomixKx8H+hEkS0rIe2cI6usE+vUg==
X-Received: by 2002:a05:6808:384a:b0:3f4:1738:f804 with SMTP id 5614622812f47-3f697afe34amr8586223b6e.4.1741639396306;
        Mon, 10 Mar 2025 13:43:16 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f855f69b1asm764315b6e.30.2025.03.10.13.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 13:43:14 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 10 Mar 2025 15:43:06 -0500
Subject: [PATCH 3/5] iio: adc: ad4030: move setting mode to
 update_scan_mode
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250310-iio-adc-ad4030-check-scan-type-err-v1-3-589e4ebd9711@baylibre.com>
References: <20250310-iio-adc-ad4030-check-scan-type-err-v1-0-589e4ebd9711@baylibre.com>
In-Reply-To: <20250310-iio-adc-ad4030-check-scan-type-err-v1-0-589e4ebd9711@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Esteban Blanc <eblanc@baylibre.com>, Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2

Move calling ad4030_set_mode() from the buffer preenable callback to
the update_scan_mode callback. This doesn't change any functionality
but is more logical since setting the mode is a function of the scan
mask and doesn't require an "undo" operation when the buffer is
disabled.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad4030.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/ad4030.c b/drivers/iio/adc/ad4030.c
index f24b46164a477f9b6b5c93ffeba0a335f7b3de5a..c2117c7a296f22aeeec6911c8a8c74ed576296a0 100644
--- a/drivers/iio/adc/ad4030.c
+++ b/drivers/iio/adc/ad4030.c
@@ -868,6 +868,12 @@ static int ad4030_get_current_scan_type(const struct iio_dev *indio_dev,
 	return st->avg_log2 ? AD4030_SCAN_TYPE_AVG : AD4030_SCAN_TYPE_NORMAL;
 }
 
+static int ad4030_update_scan_mode(struct iio_dev *indio_dev,
+				   const unsigned long *scan_mask)
+{
+	return ad4030_set_mode(indio_dev, *scan_mask);
+}
+
 static const struct iio_info ad4030_iio_info = {
 	.read_avail = ad4030_read_avail,
 	.read_raw = ad4030_read_raw,
@@ -875,13 +881,9 @@ static const struct iio_info ad4030_iio_info = {
 	.debugfs_reg_access = ad4030_reg_access,
 	.read_label = ad4030_read_label,
 	.get_current_scan_type = ad4030_get_current_scan_type,
+	.update_scan_mode  = ad4030_update_scan_mode,
 };
 
-static int ad4030_buffer_preenable(struct iio_dev *indio_dev)
-{
-	return ad4030_set_mode(indio_dev, *indio_dev->active_scan_mask);
-}
-
 static bool ad4030_validate_scan_mask(struct iio_dev *indio_dev,
 				      const unsigned long *scan_mask)
 {
@@ -895,7 +897,6 @@ static bool ad4030_validate_scan_mask(struct iio_dev *indio_dev,
 }
 
 static const struct iio_buffer_setup_ops ad4030_buffer_setup_ops = {
-	.preenable = ad4030_buffer_preenable,
 	.validate_scan_mask = ad4030_validate_scan_mask,
 };
 

-- 
2.43.0


