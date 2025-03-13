Return-Path: <linux-kernel+bounces-558669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F642A5E93F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 02:16:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E09EC3B8780
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 01:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C1C4D8C8;
	Thu, 13 Mar 2025 01:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="p5miBOzg"
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2110B2E3391
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 01:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741828577; cv=none; b=lTaO4OcYr6W3tHV4RD0NeSsaOKLueYaCTYbLQta1TYr8kqAhdmzL8WpWzHrOGwz3is35fWXbQCc/8O6n1EMS8mhvNPyH1Ip6Z4wan1LGGkKKQbsxXQoyWbnUgvc3T2k8VrO8HPmVmrcOjoPu3sHXoSHTRAZGmOE/3JpxEq6rLaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741828577; c=relaxed/simple;
	bh=eSDJa0J3f/28ZDWAk7VEZPtKxr9YtAv6+UKKVOJdVaA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=tfJ2+R37EwdCOc+pyObRcJhE9l/um7tRPLVh8UupH+EDK2h64UXqZ+SJbR37EK21iT5N1XMSb7Z9XN7mED34Wmj6OCMIIwtAjv8M43hF6vXW2hwQ+UMH9oLQ8f54UyhXRQo96kn5MrmRVOkbDKxuz1ZO0TvsE1T9TxgYHbrBckE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=p5miBOzg; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7273b0d4409so130776a34.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 18:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741828573; x=1742433373; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rJ934ZvEElWehjNAUMIc/nP+ftV711ek8hldYYhR81o=;
        b=p5miBOzgK2gvVRvOqwUpraIwF0Q8G2rWtTwBT5I5gyTX/xtVgqmHc7JNdGhiH5j98n
         ZVAums+ljUDX58zndqJNnyEQhQUPUta86gMv+EnlJfzTFsTxToEt4UABA1ncBPvf0By+
         f+nk9RF7rx3VzpFzfFppJ6GVc5SWsxyQYNy/Lat03dKI1GfoILbOqveIN04x2TKafGc7
         8yKYWDZwYQS0LxCwQ93FyQfDjJYGIjApz+wE+IgK9M+sNVhyrVVYnfgVn+LNTd5H4iJs
         rNkvOm1tsnStFIr/V5qTodwuvDoxDsOq0DkA/KZ46pBtRsF6voRP2b6sj9EhGWy9IJ82
         dPlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741828573; x=1742433373;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rJ934ZvEElWehjNAUMIc/nP+ftV711ek8hldYYhR81o=;
        b=FKTeBDEmuRQYjV6bTvYP+A/rL8YjIb9JOkXQ67V+AXFwQMrFaBBOmYL1i/DSEBVDxn
         lIlNAqosbJ9073N4/XQimf/acuc65yiYASF1W56C1wJZm454I5cr6QZ/LcZvbul7mqKi
         /dqHnQnC9WBTd2xIyRJsZvdZSARlBdgGkoDDwcyVloNb6k9CQEz9XV8FArbKzaWuCdLt
         WT6VH4KsD9v+IJrkzrBIyMg9zWptkupf63Tyafjgzd0GvWTbr44WYYkhGcnHWqL+LMvr
         eZwWQugYxTfec2EG4YbuccuWK20n41VcluPU/o8b+vOniLrPTu1XeUuunoOsKP6OvKaW
         pIbw==
X-Forwarded-Encrypted: i=1; AJvYcCW9aQhVzuSstVGVb1G7eUAeWRjSZAAFUuvvEo+/G22lGb5dClV65brT9wpzl9i2A6hVt2XT+dBwPZnj5bE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiI9SniMAF7oQl5PBAk5/FE2zEgeEMkN/Zcw8bsLDXxZkYtcFi
	TKpjTmIcwCzzYIA+uvQ5InPFANXMcjY1lsFXdkuMI7DyiJKFLJPCdbWQdBPVTrU=
X-Gm-Gg: ASbGnctR2Jb9CTAiHZ5OpvnNbcBMPAfj8DdIwRu9ID0ZSjhCVqrkN4SD8PjhesPnEg/
	sz0ANs5xUnv9RymWghd6vn9yUxFn4840RA8n6rGO9u+6g8qspFeVE7DDvTfQizapVm+t5fgQsvc
	ZWeUnXlpOdntS9/LM7nu2MBAcaeYdaSndiJRM4zPLmGrdJT34bDrUk3hRGp9ElMqM1q4QXwpqQP
	zaiBJdh+fT7ZX33nfK1KAHLtzl71UtgLaS9wDbWpXxgfLR0O5Mar929l5RA6RYg6lHYNGFJJN5Q
	2XiMTgYbm9pWt/ctki3GYi3JItCTDd+vumSZQ2P3CN3aQnZBHQWFQKTSnH12KpTN2P2yKrHMatH
	o
X-Google-Smtp-Source: AGHT+IGyd3POHMXsoid9kuJ3cLMAmofPcBo1X3qB8GLAB/6v3cfNghSUhP+eQGeHnWo0kF9Z3uykQQ==
X-Received: by 2002:a05:6830:3690:b0:72b:9e3b:82bc with SMTP id 46e09a7af769-72b9e3b83e5mr4912042a34.11.1741828573169;
        Wed, 12 Mar 2025 18:16:13 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-601db659ad8sm39865eaf.8.2025.03.12.18.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 18:16:12 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH 00/11] iio: adc: ad7606: improvements and ad7606c parallel
 interface support
Date: Wed, 12 Mar 2025 20:15:38 -0500
Message-Id: <20250312-iio-adc-ad7606-improvements-v1-0-d1ec04847aea@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALox0mcC/x3MTQqAIBBA4avErBvwh7S6SrSQHGsWaWhEEN09a
 fEW3+Y9UCgzFRibBzJdXDjFCtk2sGwuroTsq0EJ1QktJTIndH6pWSMM8n7kdNFO8Sw4DNZbF5T
 sSUM9HJkC3/99mt/3Aw5IFyNtAAAA
X-Change-ID: 20250311-iio-adc-ad7606-improvements-997d7af218e3
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Angelo Dureghello <adureghello@baylibre.com>, 
 Alexandru Ardelean <aardelean@baylibre.com>, 
 Beniamin Bia <beniamin.bia@analog.com>, 
 Stefan Popa <stefan.popa@analog.com>, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1919; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=eSDJa0J3f/28ZDWAk7VEZPtKxr9YtAv6+UKKVOJdVaA=;
 b=owEBgwJ8/ZANAwAKAR+K+IyC93wDAcsmYgBn0jHaQEdQwjhfPwRhzeaRMjjGEDzPEi1Wb1dRY
 5qiHP84Jv2JAkkEAAEKADMWIQSKc9gqah9QmQfzc4gfiviMgvd8AwUCZ9Ix2hUcZGF2aWRAbGVj
 aG5vbG9neS5jb20ACgkQH4r4jIL3fANXJRAAuvB8qcfKXcRTeXa0BVkZcPO61TYbUaSH2z6Pj7f
 Z9sh9uDYy1eqpqQhHw9XOQ6xc7qZbNPdfpuA3NSopArynbJ+02Eu6i/q5Y79Cfy++mPZyS4XXRI
 O10MAKM20YkyzM43jZkPyMSoMQU/UKcAdG340PIY/QP+a/Z03cxap3RPCXGjhnNBUWtcu6f3NmM
 GBIdURQFdq9xkMxByXHvX7MQ4DE1N6HPgGAxAO0lO5p/kYLZ3MrOygPk52dIks5YoEKIziIq94k
 tHL1u00QgsMLc9lIYOXdTtgSgfe4O4y7VUbGm5Ur4qQ8oCNYOKqTE7G7qw1kzjDSQkIgAjANyiG
 fwIPdZd6ipQHW94LqV8QjZPDflTzbPV2GuEXZ0YUeMfCgvgMTc7L9mgsPzxhwLHPnEckc40hpf5
 K7OQkeKKlfUpC7cs+yOb/dwToUDpHS0mcM5vxZVgwcmovj6FYIIiabubBxnU/54lPOJiSdJ1ubU
 RbdJBgtEZAJV449H9mVvdJ0nGfXcLEV+EE5KQG/B+VXXIMWTLuQRFRAHUGMChg9jliyG1P0SJgx
 UZ7zFtn7pVqJC+17HSVuextQ0TPapwg7Yb/zyx4sVdWhGjQhXzIV5kN6DoRQ1KHcf2juAGFRk2y
 LLZriUIhNIT/r/xayv1aNMg4pTOiqCtxU6gN3Du1ZljE=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

The main purpose of this series is to add support for the AD7606C chips
using a parallel interface. Along the way quite a few improvements were
made to the driver which in the end made adding the additional chips
trivial.

The first 3 patches are fixes. The next 6 are some minor cleanups. The
2nd to last patch is the big one. As explained in the respective commit
message, the channel data structures were getting out of hand and only
going to get worse with the addition of SPI offload support. Instead, we
are opting to dynamically allocate the channel data structures to avoid
a bunch of the existing complexity in the driver.

I have limited access to hardware, so I was only able to test this with
ad7606c-18.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
David Lechner (11):
      iio: adc: ad7606_spi: check error in ad7606B_sw_mode_config()
      iio: adc: ad7606: check for NULL before calling sw_mode_config()
      iio: adc: ad7606: fix scales_available attributes
      iio: adc: ad7606: add missing max sample rates
      iio: adc: ad7606: use devm_mutex_init()
      iio: adc: ad7606: fix kernel-doc comments
      iio: adc: ad7606: use kernel identifier name style
      iio: adc: ad7606: don't use address field
      iio: adc: ad7606: drop ch param from ad7606_scale_setup_cb_t
      iio: adc: ad7606: dynamically allocate channel info
      iio: adc: ad7606_par: add ad7606c chips

 drivers/iio/adc/ad7606.c     | 313 ++++++++++++++++++++-----------------------
 drivers/iio/adc/ad7606.h     | 171 +++++++----------------
 drivers/iio/adc/ad7606_par.c |  37 +----
 drivers/iio/adc/ad7606_spi.c |  98 ++------------
 4 files changed, 211 insertions(+), 408 deletions(-)
---
base-commit: 97fe5f8a4299e4b8601ecb62c9672c27f2d2ccce
change-id: 20250311-iio-adc-ad7606-improvements-997d7af218e3

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


