Return-Path: <linux-kernel+bounces-186397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 356A48CC3B0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 17:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66D4A1C22526
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 15:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0441224CC;
	Wed, 22 May 2024 15:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="LIP/93DP"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F70217556
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 15:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716390172; cv=none; b=KGpUi2OZefwPQZIhs+O3bxVNBMERAqjZsmhJgi3Ii+MEFiXThvxK3dztaJlv/I8v4+Pm7bjTV7bx7mKJOmEXQpVGu+KGBIo6xZAz3HUcw3gTEsbFqSqDHk2omz/CASbhYnmH5d1DAE6FrUgOspyv0UK/qk1Sm90L5k6glYth+bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716390172; c=relaxed/simple;
	bh=O0L72EV3SoSMUxeiDpo2pMhpYJ4G4dITD0c7JPwzQdk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uUrV/FoRR1JHYk/2kimuBYsJLWMPoOuHzGgh+qxefzD5rLAi5KjclNrkdMsgnXnVOVW9bu+SW/nxsAsGWzNXsrBLAO5AS98yUcq0rQAQ2EPO/h+gfgJGhr81wJ6Oq86tshG86AB++PpcEzxjXc5unlGPh28qawXqBpHm7kck0hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=LIP/93DP; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-420180b5897so8658555e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 08:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716390168; x=1716994968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qRSTScqeQkeHPB+eXO+qUigZFJj2TICxMJQ8vQ0E+fE=;
        b=LIP/93DPQ9tPfaFoYSxi3ccLE5rtg4olQ3OwsG/PGIT42WogMQE8sKNslZYA83FGJA
         4HxZFpAoci/wRngdUcV/hfBgyh0exE9KW3TVmCcbZ92IlVOD/IzmljJltYqU2Fi5uvMa
         ORXPpOcOGKHECGNHOTZ44QeBxF1lkdV9fqdJi5WacZ9axkXwdTIvoSP24QZnqgqiC+8v
         DLhfjxHSTID7AanvZMhZFexDu9PgVDFqOr8FfxCTrbMk2838HrFVox8Ju9nli9WE7qwQ
         n+uhJqU/umSXhucoMYysi01XOzFr5KCQmNl4WHn2TtL03zvXgQCGiSjiU8484oC2G/H7
         yAUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716390168; x=1716994968;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qRSTScqeQkeHPB+eXO+qUigZFJj2TICxMJQ8vQ0E+fE=;
        b=IUsHoqDAv0dCT8cEPp3mvPrZISNz7nbCu+yssLDrSiXVLtESyOEBvVCSjjPmhcirP8
         E5ZuexujlCyOfILePVK/7uux11KN3Cy4eK592p1Ugu+ZhHHfLE81mG3b/eOUhM+1HLqh
         hPZurkCT/NxtatzsrjuqDHBu16doSjxiokzI9ZhLcCluSw3ZhbeIqq4U8VB4ESDS/eW1
         sIEOFJyfdm60BiBYXbxZubF7Y20OLDMzsDwhTHpHZMu/YmVA1MI/3xTw/k9VCxPuwYD5
         25KxMp4/i1PznCV73SJsGDpGmaFF9V3ZFd5y6Q6KARIBJq8v5P26FoBqojXhXto3gKIA
         uqbQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2oph2ZUIBYLnWDPQeLz2M5ufyblpiFqe9o5Y7lHUtUtJz2LdcCBmlPQsQAtTHrYryZX6vQBekwvmilUqA2VBbK8FPg1GrNUs9cJQu
X-Gm-Message-State: AOJu0YzOZl/eUGaMvqNjEQwDI5k/i2MKqconyVQmDBGu88q1H+eLRztJ
	+Pq3HD0hfoWZd+9ds2ghSqGAU77va2lf6Bi+F0PfYkuRdwj6xSctspcHHrPAdXc=
X-Google-Smtp-Source: AGHT+IG4GcEYn1PZI2Gtu5J0UVA+SzKFrymrH4lYB8MtjfRDD7wK1hG8lEjenPs+3o8noaNhbG6Exg==
X-Received: by 2002:a7b:ce14:0:b0:420:1551:96ab with SMTP id 5b1f17b1804b1-420fd2fdcc5mr19499465e9.10.1716390167789;
        Wed, 22 May 2024 08:02:47 -0700 (PDT)
Received: from localhost.localdomain (host-79-16-6-145.retail.telecomitalia.it. [79.16.6.145])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fa90e93absm531370515e9.9.2024.05.22.08.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 08:02:47 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
To: jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: nuno.sa@analog.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Angelo Dureghello <adureghello@baylibre.com>
Subject: [PATCH v2 0/6] minor fixes and improvements
Date: Wed, 22 May 2024 17:01:35 +0200
Message-ID: <20240522150141.1776196-1-adureghello@baylibre.org>
X-Mailer: git-send-email 2.45.0.rc1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Angelo Dureghello <adureghello@baylibre.com>

After testing this driver, add some minor fixes and improvements,
as adding single channel variants support (ad3541r, ad3551r), also as a
preparatory step to bigger future improvements related to fast-rate mode
for this DAC family.

Previous patches (v1, 3/3)
https://lore.kernel.org/linux-iio/20240510141836.1624009-1-adureghello@baylibre.org
https://lore.kernel.org/linux-iio/20240510141836.1624009-2-adureghello@baylibre.org/
https://lore.kernel.org/linux-iio/20240510141836.1624009-3-adureghello@baylibre.org/

Angelo Dureghello (6):
  dt-bindings: iio: dac: fix ad3552r gain parameter names
  dt-bindings: iio: dac: add ad35xxr single output variants
  iio: dac: ad3552r: add model data structure
  iio: dac: ad3552r: add support for ad3541r and ad3551r
  iio: dac: ad3552r: change AD3552R_NUM_CH define name
  iio: dac: ad3552r: uniform structure names

 .../bindings/iio/dac/adi,ad3552r.yaml         |  43 ++++--
 drivers/iio/dac/ad3552r.c                     | 140 ++++++++++++------
 2 files changed, 128 insertions(+), 55 deletions(-)

-- 
2.45.0.rc1


