Return-Path: <linux-kernel+bounces-558668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E139A5E93D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 02:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B10401899C97
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 01:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5163428399;
	Thu, 13 Mar 2025 01:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="rPLX3SjK"
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB6D4A2D
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 01:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741828576; cv=none; b=j2oRr0/xDWPwIhti6pL0jlRs5O3YPZ3OCfDshngNJWaodnmMlD2tBiAztwq2BiOhvowQXlvix/zEU8UO++7Jb/iPtPElswjw5YNsrXHzPcp/Qz+u1fUH3qDXSxvXHl5B5z6vX/5DYP6n+++BqTTjPmo8zUWKoVyzFNVJ7SJdadY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741828576; c=relaxed/simple;
	bh=Nsm1P9IXqK79RS5iTQ15GAMUIKO5XFHcSqUCqmzn8qc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eIuoXESKsyCMMOHNxPssmT6dk2cygOSZV1Bix2HeJXSJUZx9hvRtUB+gONyTyQMEXXOXQks7NWs69gevzxpkZi7UfR01wM6jze3FqNVSuMwj8Wf+KQUtsKoEJtrDTvekhy07XsSnTrp6d0QFCzBpKiLgQdZUdbUNsc078STINPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=rPLX3SjK; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-60029342c98so238664eaf.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 18:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741828574; x=1742433374; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mrZTqZUxbK1LjORtr8ZS2MLu+W9jtz5kAVFYAftauks=;
        b=rPLX3SjKAEDFPf5Uiyyr5MJr0mlerAxD2u0vscXa+xBZmiOdrRmEA0c7wZUL8F5mDz
         H4xuTJkxS0M/8EAMwZfDuquclHOM5KyrK51ughKMsKNFlIyA/v4P3MH2qTpvBLwrvO9L
         bmhUt6bvC0l5VhjIUuiXb67xGbfWINh5R5g7uMsvVSKi6xoIDdbUS6um7og/kcSdLA8n
         Ncw9HVRupI8cCLycUaJsb2smkb9isY80x6NCBL+0n2UuYSeZAY3+eq3+c77hDQ6pWJ8X
         C2c7J4NRcBnwQaEarJZvJWROekAEIhTzQnlMjaWyMi8AZdrw2VQaippWLu/FdS2mcwx+
         NvVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741828574; x=1742433374;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mrZTqZUxbK1LjORtr8ZS2MLu+W9jtz5kAVFYAftauks=;
        b=FZOFujMkKuwMB7WMhigxplRehHMylShb0ssqnPpVokSNbIrtWUc4/fQPdtqN+eGOcT
         YmFnl238AVzJYiVSJ83fDWPR8pap/wG2MF0q41CdcTG5rMMVV689NU+Cp6taLw2G6jOD
         mqMEuvEEjZmASpZloxDGp2Xic2CJ8SLv6C5xOwDSMKwnXYDxse8SY57G8QSzPsuVRUwz
         vAUK6VdUyYcE/iNS6dGeoNiYIIwzgJpVtoRhupTE/KoFfoCb1G6ePY7zbZi6zlBbVkCT
         kfL0b0UjcK2/+Tfx71N5nt5P1WlVhU5N9mYiLewNpxxDQVsEaCYy+VmPvdEnu0wpXIuG
         ug4A==
X-Forwarded-Encrypted: i=1; AJvYcCXjmUXBFD5Vn35+P/QoJCo2cYIUyzN+Y2LNa0XxSoWhNSvpHSEJl/5RlopqW9kC3qihUwxBqC906XRe/nQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YynEIcZ32iFHJzEopbX3EU5V1YI1UUnG5R7I/zJsNAOMDN2FXSO
	OT3eihMF/agpdWmKxb1KauS3RNK64D1e2zBiEKjgJEtEkP4aUVl0CL81kTkkCnE=
X-Gm-Gg: ASbGncuAOujcbanXC+Cm+uIRuyixCsQGjF07M61u4IPqmVGCzOjiL66umJYGeJ91sXf
	eSlCyAarRIt2niZ/Pw2+zEuTr7Cfgx2XF94dlh5ufN7Bwxi2Zbr2M/ioha8RnAx6o500TzAHfqx
	pqWo1VdL+ZMQoJJDjXKYo9r9sU7xP7cLhzcV/EeBKX1zOyCFdvR74bqPDf7nSTJDnKKRuMz/p6u
	fLYvC3Tmj0KkhWbrMiPUcUbOFxOThwiTwHhOK9PN54x7iAmpZZEALnoaILuMp+pdCu+kXAw+qxg
	fcAi9PaNcp8Yh3SmhtZS9zCGjy9ErEe42jCcIpzFPRDY2iPzlAkIHL3hHtEQdHpB0ajR1jB79HA
	d
X-Google-Smtp-Source: AGHT+IHAfNO0rPuYnHkGm0gbnqyBvXFhbZTEPez6E/tb7cDSLbvx7f4sbMN/yzXFdcc0JNs+adii7g==
X-Received: by 2002:a05:6820:3090:b0:5fc:fb1a:2b92 with SMTP id 006d021491bc7-6004ab2f30emr12512731eaf.6.1741828573934;
        Wed, 12 Mar 2025 18:16:13 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-601db659ad8sm39865eaf.8.2025.03.12.18.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 18:16:13 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 12 Mar 2025 20:15:39 -0500
Subject: [PATCH 01/11] iio: adc: ad7606_spi: check error in
 ad7606B_sw_mode_config()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250312-iio-adc-ad7606-improvements-v1-1-d1ec04847aea@baylibre.com>
References: <20250312-iio-adc-ad7606-improvements-v1-0-d1ec04847aea@baylibre.com>
In-Reply-To: <20250312-iio-adc-ad7606-improvements-v1-0-d1ec04847aea@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Angelo Dureghello <adureghello@baylibre.com>, 
 Alexandru Ardelean <aardelean@baylibre.com>, 
 Beniamin Bia <beniamin.bia@analog.com>, 
 Stefan Popa <stefan.popa@analog.com>, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1102; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=Nsm1P9IXqK79RS5iTQ15GAMUIKO5XFHcSqUCqmzn8qc=;
 b=owEBgwJ8/ZANAwAKAR+K+IyC93wDAcsmYgBn0jHa/kXO9pooqHCPQs1sIidUhMs3fZytFn7t9
 gsVcWOBrC2JAkkEAAEKADMWIQSKc9gqah9QmQfzc4gfiviMgvd8AwUCZ9Ix2hUcZGF2aWRAbGVj
 aG5vbG9neS5jb20ACgkQH4r4jIL3fAMc7Q//VBTc8uLhwPNd8mhtlYZcmXiY1rBXmfgk1ZSPvX7
 rNQBIGJNniHB54qa4WZSMgICcpZQ4u2kodME6zw8CaB/qz2QVai4pTerzUO8B35cu2eCC1lbv7b
 rr/hupj6y2ocg8yiz+o0f98Or2P5XGpCG8rEJbKTOSyXEvQOip8emP5sx4OcRUT/UPh+ZmXkrrQ
 +HeDF1PwSfBfriOugQgPUWhQEwX/qHMgBQgEFto+mNG1TrRQqOouxkor5sbdwr5C9GLqZyGEjru
 OoBYxt81rHNRrDL2KYgu4wdSaD67wEsWBeoAUlMAgiUFVa7t+1PB3COSaHC+Sxx/EmGGHKxZGuu
 3v6ZoxbzgoR88Gp0lTWa3o860Nwkd7tCxYrWCWhXXSlETW/m4dT5kCqY096W3clsMdtoh7yEByw
 4HAAt3OomdgwW4h4OBqpZ48QT6T4oK0kABAVSNWwebG1jwuzriqdCU2bCCSFSlZUgh2s3Wn+Mpd
 Sc+5lItWP5Tdx9wINeOy6G6vnAr4zXUAZDlNODvCUG6szR7D37jjK8rsHuyCsWXV5saJ3xDbp3j
 3WlpNCFoD5zTPl9iXjqVMgyYTCuXW9vbA6HXexeIbu+LngyvJ7/J8VKq7I8XgLYFj6OEGMl+qfm
 jVuGcp0wxRm+ROa9K+MucJtYU/AI4RDpgVFCOqw5YtZk=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add missing error check in ad7606B_sw_mode_config().

Fixes: d2a415c86c6b ("iio: adc: ad7606: Add support for AD7606B ADC")
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


