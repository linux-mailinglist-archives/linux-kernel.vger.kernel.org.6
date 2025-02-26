Return-Path: <linux-kernel+bounces-534168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FAAAA463BE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:52:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 631623B5940
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 14:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE9422539D;
	Wed, 26 Feb 2025 14:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="mMKkrk1U"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A0B2222D3
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 14:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740581429; cv=none; b=JD21lIk5mL0GnbmIoJsti+A1BEaxyRVNnjynzJfH18DIX395ugzT8tq0V8fjFYJ7GDihvIKnU25U4u4kZMxfWNtn7A2Q3QevRFKlL2WQ8e16aRDU6vVh3wGZtLb3rvjkuFe2SXVNCgnpgng6lIaOaNUiEKV/WH3LBcDVHeKLAvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740581429; c=relaxed/simple;
	bh=AiBtlkpcTdJmU62MyZVlruSSe6cY2MOj4UoJW00/I1A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OBpHFROp1Bv4AAiZ6WConlsx1C41yvza3E2ioDB+34Jert8vexaZiZqCV80vRmNr9v3OWmMCfIZq6I+gtjsisEtPAmPRsAALe0jX9Jajj3VDVnQury072CN721cwRLYeKApk9N/ObEHM8ZTXxIercjh+b2KAmf6YAEBL9pIUIoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=mMKkrk1U; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43994ef3872so43213075e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 06:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1740581425; x=1741186225; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K0B5DTNgvnwka6JhdG1RxKRZQdylIuRKT1s0mr36XMI=;
        b=mMKkrk1U4oAhvNgDUXYB7mPOhiLokBNta9dqDUjYUUB7apPrvr5pJLEGFpXHP+eRYx
         qQrXSYLKGoz1HEHE82a/WLNRAefDTAp2VJHeagpuswD/LRMdHq+zvX1RPJMmSL6WHePO
         ptYLh6xM9IBB1Y2ADb5wASqH/mnJnd1DjwoHkRBZdHXZjDc85Uxskgws9vjLnCUj9RsK
         D1rNDJHtaiLgdCGeCQV/LdmkWWRR3dQ1FwMIiHMJ85H4PuioXu27clsdu5ZWAl+/UGQ4
         9p8pNMUmZlnQJLGhMDOHRVdaYHbztPMwRPMjZW3jGMad2Q40Pq9zP8+5xFu5jlPzU7ZK
         5Yrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740581425; x=1741186225;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K0B5DTNgvnwka6JhdG1RxKRZQdylIuRKT1s0mr36XMI=;
        b=VWhckbQHU3YTgE2be/ynUbc4bPvmpAqeVYmrfSBlbJxlxAhNANRs8F8CbaJEHjP+jn
         5eaUGI+/BrmXv8ByFVWutRRqnzl3NT0ASycf1byac41zHOmttKFnkdCPyn9o0u5b9Ndf
         rtGEEkM8zFbrrgGTVTVC2XflXZcIldSfcuCWsutM/YGY62wL6PmhWDbD73u3+JF59NDb
         YbM3bRwDW6pVGy+OV7t/zlAB2SkPspyeKLozcHsyaf5o2zdFmPnquVheK7ABqU1jc4R0
         fILGAmkeIbjZJBIrcegkdGMm7xcVhiDD8zHvYBUlZephb+qmCFE30wEd/W2Ckf7racAb
         F4ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbvH3n4T8uMkbFaGkV1ATJBi8VGxDMSZ0O3RtpYgiXVz+UGY+WUAI9W5omBFinTKwgBXgLNhxmPYAXKh0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywtg14ur9eADeJILgfGpcUVVU78Nud7EWD1B/ehaa68xgqQXJzZ
	EG2MNUirRm4nBhYjiZOkNXxdKimaAa0RV6QSzROQNoGesIRiFlkbN64DoJHXeGA=
X-Gm-Gg: ASbGncv4gmpZDeQzLAD65mPGMClPC3tVg4c7oz8m9myXd1c9iwf2KfRj2nekF9HDN4o
	4CJAPWZeKNGYb7xHZhKYzYn7b3l8CM+jnq1L9ilogtbrVstsGz9G9D73v7QU9HKQNgeuJ9JaMb2
	qVaK/pLHXRXLu4wM7oTV+U7stkHT73Z18+EeXwf8FQbZ9V15uuMGmT8jaX8tX/cxU/6e6GfJQrk
	165kaNSE550/SKqpBjaxyCWmw8Pa+fHplkMcXpAYeJxd2upqxlYwHG6aG7Ek7Ojjsnlczht9PDe
	1RBZ3mhVI+nYuWkNa3aEooQfyo6dXMZ2EcE7YgPx6PqFtUoFjT5lPCMRvNF0955GMcO8etpyCyr
	PAazzT7nn+W1RO9WUtgvBmYM=
X-Google-Smtp-Source: AGHT+IF606LkuiMsDjoxoFUsY5Gw5UF42U3bEMG+pWqETROOOXt9np0boII9VXCYLUynJeWaadJIDg==
X-Received: by 2002:a05:600c:5123:b0:439:88bb:d035 with SMTP id 5b1f17b1804b1-43ab0f2887dmr73970795e9.5.1740581425531;
        Wed, 26 Feb 2025 06:50:25 -0800 (PST)
Received: from jstephan-bl.local (2a02-842a-d52e-6101-6fd0-06c4-5d68-f0a5.rev.sfr.net. [2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba549d6asm23747965e9.36.2025.02.26.06.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 06:50:24 -0800 (PST)
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 26 Feb 2025 15:50:05 +0100
Subject: [PATCH 3/3] docs: iio: ad7380: add adaq4381-4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250226-ad7380-add-adaq4381-4-support-v1-3-f350ab872d37@baylibre.com>
References: <20250226-ad7380-add-adaq4381-4-support-v1-0-f350ab872d37@baylibre.com>
In-Reply-To: <20250226-ad7380-add-adaq4381-4-support-v1-0-f350ab872d37@baylibre.com>
To: Michael Hennerich <michael.hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>, Lars-Peter Clausen <lars@metafoo.de>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.2

adaq4381-4 is the 14 bits version of adaq4380-1 chip. Add it to the
documentation.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 Documentation/iio/ad7380.rst | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/iio/ad7380.rst b/Documentation/iio/ad7380.rst
index cff688bcc2d9601a9faf42d5e9c217486639ca66..35232a0e3ad730c19b5201b74280bdb6deaa9667 100644
--- a/Documentation/iio/ad7380.rst
+++ b/Documentation/iio/ad7380.rst
@@ -29,6 +29,7 @@ The following chips are supported by this driver:
 * `AD7388-4 <https://www.analog.com/en/products/ad7388-4.html>`_
 * `ADAQ4370-4 <https://www.analog.com/en/products/adaq4370-4.html>`_
 * `ADAQ4380-4 <https://www.analog.com/en/products/adaq4380-4.html>`_
+* `ADAQ4381-4 <https://www.analog.com/en/products/adaq4381-4.html>`_
 
 
 Supported features
@@ -52,8 +53,8 @@ declared in the device tree as ``refin-supply``.
 ADAQ devices
 ~~~~~~~~~~~~
 
-adaq4370-4 and adaq4380-4 don't have an external reference, but use a 3.3V
-internal reference derived from one of its supplies (``refin-supply``)
+ADAQ devices don't have an external reference, but use a 3.3V internal reference
+derived from one of its supplies (``refin-supply``)
 
 All other devices from ad738x family
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-- 
2.47.1


