Return-Path: <linux-kernel+bounces-567030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18EE1A6801B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 23:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C91243BFD75
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 22:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C993213E71;
	Tue, 18 Mar 2025 22:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="NokKE2LK"
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D134320765F
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 22:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742338341; cv=none; b=hCtPq0dw1fbhvXWHXBZBdvVv/1XIET8ZlKmlcZQga+8NmWnzml5s6WEWx/9L0MRwYexBbzrXUgFo/fTRwdLIm5/vwRwY6EMq2yebtRbmeHIS6d66qYa0EL6fDWD+pNCtHIpA3nVvkivzU44MjxSeBrfiNG3Ay5N6uAZLSbK3m94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742338341; c=relaxed/simple;
	bh=MymKfg9hNdh7VEIVG5aw3IyW7Bibo8midSILlV4WG+E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SJoIJ0H5k1ASZ4225Dr/iXjquzg+mLc+bamjmtPYBJa1LKavVjW3C8KpcUG7u5sBuQt/dUT2lxRUbOVXOEuKFNjr0wE+ZwghTotyjdwBuVucxlZ9O31kpxRajNo1dDMD1B9Vb1AmxHnaNDzaUkK6wcKMEMaYpFF+ymhV+dNDczU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=NokKE2LK; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-72a145521d6so4148889a34.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 15:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1742338338; x=1742943138; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kkbLNtVpwpFZWMs4rz6SYORu0wPhARh2K7016vD7POc=;
        b=NokKE2LKV3UlN2uBnUuj+cyanRGo3rAh8iQmVJZn094WzKOHqfGJSgFaYs7wCJULHR
         Z6afHHTEi/gMoCUwUgNrO6K3WcgP1p7qwmB3xSn9Tq6zS3Lz/aB4dFcVE4JTq629kood
         8hHHa6YIKRLpVV8E9VOECwoJ9s8v+6bmZF+zEuBzvLuPftr2I7XDOTc0ZIyT/81nfks1
         u7fNziuDmgzXNCTKkQ/bp0433SHEwH+fMpX2KBl6X1K3uGjv5vnuo7Hl9u3Pk2Wf7dK7
         Qgx0LIG1TPK+n29DjX0C3scKDGEC77+raEaXO/vngwiRqc6S22Uq6ySMtxATJ8QcXgY6
         bS4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742338338; x=1742943138;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kkbLNtVpwpFZWMs4rz6SYORu0wPhARh2K7016vD7POc=;
        b=VaFNeCgx1hrESZlUceFoOMYZSX/V6iOfJMYaEhoZRHi0q6kLuBPmFS34OhhPUErHMO
         vvVBtTqUvJW1cO4dH1RSjwqPld7PP0iORuRoO+HYHxJafgijN65GKpElBIz8INn9BIz9
         bbNJ0garVwPkHaDU5d9/I/lJZ2r7wTTCHsk9e+Ei/9cWYinPLcQ6NyZj1FTQ2Zaubaf8
         qUU6iPEXtadk2c0HMvyf6yef8KF98J0C89H9lLMcEmoG5rCCPARd7ijSwpjZW8cDGTfJ
         DYFiSdcLTiOzjINHwzDSbrMrhG7WJ5OR9GuKJMqWok59QyNpifeqXqFSIABVeaED+WSJ
         YUjw==
X-Forwarded-Encrypted: i=1; AJvYcCVTSQDCN3z/6F77jTGngCMgxocVU3s9ZYxUqf3dAu19yq3JB5K/ozw29kRlocQFIZ1ylglVhLB2SXSKO88=@vger.kernel.org
X-Gm-Message-State: AOJu0YxskVXD6t2ltjNACngVAENvozmo3UbNZkWlso8jWCd8BaEefNfN
	rWgQKjMPVBpIi9hVQbQObzchHhoDy1+QT74kMsXA9+ASJjx+zTU+UDfFmGXMR+A=
X-Gm-Gg: ASbGnctoUHjplBHAOznUbgI4hbqcAKmCco5YzRMrNOg6HnN09T20sNx5NxklMOACcDv
	lC8QvBDOR9S1THifG/FZhWyWL31gVG/5a37vGVisBDNmXsRQL0FePvh+EQcZrV8uTgJoZ0dEc8h
	1gLOt74OxfpXn0YbTY1v/WHDZ8+ZotxHZaPLhdy8m4wMMdKgIESZc2SmZ4ZliRH0773pYt2MdQh
	5HsQLcfvazZZz/25glGv0VaUVW9Z1vf54SrM4ih6iPkxyYA6qPFqYQdL0Ya/Rkayqw4MTn+DyrK
	DBLv6qAFqmpdtcSw/UxYIZWZ8mE6zXlLNC8sl6YJhlDWsiI07tT/SRxJhE5Rjxj75Yv7lno/shO
	c
X-Google-Smtp-Source: AGHT+IHZuyggkmPqrQGrGAUy7Y06HBEeAVytcb7xb+U7eWde81LwLef59gm2Mn288clBZJ6aSWdajg==
X-Received: by 2002:a05:6830:914:b0:72b:a465:d955 with SMTP id 46e09a7af769-72bfbdc7d99mr447313a34.12.1742338337879;
        Tue, 18 Mar 2025 15:52:17 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72bb274e95dsm2191690a34.52.2025.03.18.15.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 15:52:17 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 18 Mar 2025 17:52:10 -0500
Subject: [PATCH v2 02/10] iio: adc: ad7606_spi: check error in
 ad7606B_sw_mode_config()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250318-iio-adc-ad7606-improvements-v2-2-4b605427774c@baylibre.com>
References: <20250318-iio-adc-ad7606-improvements-v2-0-4b605427774c@baylibre.com>
In-Reply-To: <20250318-iio-adc-ad7606-improvements-v2-0-4b605427774c@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Angelo Dureghello <adureghello@baylibre.com>, 
 Alexandru Ardelean <aardelean@baylibre.com>, 
 Beniamin Bia <beniamin.bia@analog.com>, 
 Stefan Popa <stefan.popa@analog.com>, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1075; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=MymKfg9hNdh7VEIVG5aw3IyW7Bibo8midSILlV4WG+E=;
 b=owEBgwJ8/ZANAwAKAR+K+IyC93wDAcsmYgBn2fkcpJMq2rXU95PQB6TEGoJ22ZJZHkAdMUEdB
 d+M7ZlvgiWJAkkEAAEKADMWIQSKc9gqah9QmQfzc4gfiviMgvd8AwUCZ9n5HBUcZGF2aWRAbGVj
 aG5vbG9neS5jb20ACgkQH4r4jIL3fAO+9A/+ItmzaIp+mvBlYOaQ0EVK1pPYXT9Ef/+hE05DhnQ
 /X1qg7hTt9WlpdYgq56g6OVsvu58Ya+R9Ha6OG/7/7X1Q/Bkx5VflVXQInblBfYqXOyFHjG4CKv
 EJ10ellc80Ja5FDifbJjam5YXMJbUzOj+aU5+2oxnO/l0ouPj7F7CH6ktuNA4zqg2OS8zR7L71/
 D8qo6wTGBxCdj07xLCNup90hz+CSFoT9yP9oMNOCi7btpRYASauKOyWOrCTOVK2reIAGe3LUFXy
 vpvf7Y1zWoGS5eM2kNf8FqhfZXw6zS7+K0zEZ6V28fZbsNlEMdZCkxOHIb7l7VyFaGodREU0VLD
 UvMu6STQB1g0Lx/6TxaI9jT5d70vmTbxUraLkUrfzokC3IxeXkBADFu/CDeM6p39uz1nmp/fksP
 iu1IJMCvOHAvMAV10YVRQgY/u3d86kndlceWf7xrj3OpwPN07AgAF9+7CsTBLvc1I0FscVaNCgD
 eXnxDtqyMY12MOiDhASlwxZXcw+aXDXZWM6ONtR3fVlufQEJGL3zRwTpefw0wNxhIQn6LtCQ2Fa
 8cc7kJ00DMTkiwuW0QiIAhpNTYzhA2lDo9bWw+umVCq3jkgBDcXQ/XyOslGir8FxWtEKvlLhRY6
 yDvV1G1juaePJO8eo4A2jpjEGs0Kx/0FQj7/s5qLAohA=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add missing error check in ad7606B_sw_mode_config().

Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad7606_spi.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ad7606_spi.c b/drivers/iio/adc/ad7606_spi.c
index 885bf0b68e7775c5f4a12dfb827f502d5f782e8c..c028e08efe2c82cd97249f98eec50a9a9c06471f 100644
--- a/drivers/iio/adc/ad7606_spi.c
+++ b/drivers/iio/adc/ad7606_spi.c
@@ -174,11 +174,13 @@ static int ad7616_sw_mode_config(struct iio_dev *indio_dev)
 static int ad7606B_sw_mode_config(struct iio_dev *indio_dev)
 {
 	struct ad7606_state *st = iio_priv(indio_dev);
+	int ret;
 
 	/* Configure device spi to output on a single channel */
-	st->bops->reg_write(st,
-			    AD7606_CONFIGURATION_REGISTER,
-			    AD7606_SINGLE_DOUT);
+	ret = st->bops->reg_write(st, AD7606_CONFIGURATION_REGISTER,
+				  AD7606_SINGLE_DOUT);
+	if (ret)
+		return ret;
 
 	/*
 	 * Scale can be configured individually for each channel

-- 
2.43.0


