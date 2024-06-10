Return-Path: <linux-kernel+bounces-208992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D5A902B88
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 00:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9F52281809
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 22:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CEBA18E2A;
	Mon, 10 Jun 2024 22:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AxH9c3Yj"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05109745F4
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 22:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718058336; cv=none; b=qh3tYpVk+sjZ/zUdOhFvszfLdlkmRs4gvlDA57UXPusfgGUmDjcMrQkc9n1jP0OkkgUS9K2stNaL5aNZaA+e7+sHphshHbSmIoUTaj7VGjmTR1N386kQRWEKNQgSxEiT0eoy0Un+0fJXktI8m6nU4+VDDVPGjs68iL6rJ2vNvZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718058336; c=relaxed/simple;
	bh=MqviCqfqIHX7u8G/Z6LL7r1CVMo4OBErpJn1/ngl/vE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sm8uT+6nVKctfPC+SMK/wncEGLmYLi5q6ikkR9SUYMP6IoX7SZq1L6NUT+UFkXMpdqHbDoIb0qR+fLVnfMefORJ+lmxwWfwPv7SDK4CCjrEDrnuRIegBxoke4Wpa+4dkc5mAfnsxVEUDSWWbZSl4I0pmfao80GovRViE69Ztkf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AxH9c3Yj; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1f6fd08e0f2so15197245ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 15:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718058334; x=1718663134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9f82RCupm/BfuZamDEll+7kz7R1SJFCpY/OHFhONWlY=;
        b=AxH9c3YjBgE/N5qrHRryxAaRU/bmmqI10Zf/btyrsIOMNUlUZa/5WvVyZ6xM7V66jW
         lDeFADB1kScSVeyYs5Xap/Q4ChPEdtKmCT6ZzqDNGlfOLgxO9VYkOg3frnnR6w4qQenQ
         YI/TyJfjPh5wAWCCM8/x/lP67vTJXy/zublf8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718058334; x=1718663134;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9f82RCupm/BfuZamDEll+7kz7R1SJFCpY/OHFhONWlY=;
        b=PF6dl8ulI3RTOSeGvlXw8uSFykdEVwZbLYbBBvyX5oeBSo8pd1j+gKymb5wdLiKVTP
         X8dbVt9JA7P1zI9O/NNxDbMRxzhI8xD/v95isDxvzxnj8HpGuOJTc/psuSYcoJOd1B/x
         ToHSrqO+NlPLqsG+fxjg7NBRe64IU6kQqvo6W5ynITLnQOoBXdkRm4THXIK4tHKz5gYb
         3JShfRaBpUXAo6rQC0h/1nuGil//QUMTGy8oizAOuYqXHg0inAxR2ldbt3WjnPm2ofAk
         uOUlk232XdH9xQ+pTlx4vS53xDkEYoLHyZeKgYMb6NhAC2wgC4CnpWt/OW5sBs6lcpCQ
         NZHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVN9RdnZ2T5q3V634xgrVkD+F9Sh0dlGIL4C+BHsMF4Vw9epq3mLSb1NT1pVh8MyXSLLT7Kmf9tCfOpFu2Ulw32it1A5ZF99DvCquZK
X-Gm-Message-State: AOJu0Yxu1KzrY3eaY0G/1vnwJ7aXFrUMSWQ4e9ltTVH3Ieqy42lQEWQ5
	Y8k7Xm2Q5PmBndvMqPc1PWPrK2EBcoWAXPa4rootIvKnZU/NILIOB4b7Z67lbg==
X-Google-Smtp-Source: AGHT+IE2nKLq+Ptop68Z34+mriVxV3i7t1j3Qzwns8l2vbwaKmyQaRrPowITUmKiCuwMqUaMG2Hlqw==
X-Received: by 2002:a17:902:e808:b0:1f7:1931:7a9c with SMTP id d9443c01a7336-1f719317ef2mr35773995ad.15.1718058334285;
        Mon, 10 Jun 2024 15:25:34 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:bba2:69f4:1b51:d0f5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f71029e223sm29212325ad.170.2024.06.10.15.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 15:25:33 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Yicong Yang <yangyicong@hisilicon.com>,
	Tony Lindgren <tony@atomide.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	linux-arm-msm@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Stephen Boyd <swboyd@chromium.org>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Douglas Anderson <dianders@chromium.org>,
	Rob Herring <robh@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Subject: [PATCH v4 0/8] serial: qcom-geni: Overhaul TX handling to fix crashes/hangs
Date: Mon, 10 Jun 2024 15:24:18 -0700
Message-ID: <20240610222515.3023730-1-dianders@chromium.org>
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


While trying to reproduce -EBUSY errors that our lab was getting in
suspend/resume testing, I ended up finding a whole pile of problems
with the Qualcomm GENI serial driver. I've posted a fix for the -EBUSY
issue separately [1]. This series is fixing all of the Qualcomm GENI
problems that I found.

As far as I can tell most of the problems have been in the Qualcomm
GENI serial driver since inception, but it can be noted that the
behavior got worse with the new kfifo changes. Previously when the OS
took data out of the circular queue we'd just spit stale data onto the
serial port. Now we'll hard lockup. :-P

I've tried to break this series up as much as possible to make it
easier to understand but the final patch is still a lot of change at
once. Hopefully it's OK.

[1] https://lore.kernel.org/r/20240530084841.v2.1.I2395e66cf70c6e67d774c56943825c289b9c13e4@changeid

Changes in v4:
- Add GP_LENGTH field definition.
- Fix indentation.
- GENMASK(31, 0) -> GP_LENGTH.
- Use uart_fifo_timeout_ms() for timeout.
- tty: serial: Add uart_fifo_timeout_ms()

Changes in v3:
- 0xffffffff => GENMASK(31, 0)
- Reword commit message.
- Use uart_fifo_timeout() for timeout.

Changes in v2:
- Totally rework / rename patch to handle suspend while active xfer
- serial: qcom-geni: Fix arg types for qcom_geni_serial_poll_bit()
- serial: qcom-geni: Fix the timeout in qcom_geni_serial_poll_bit()
- serial: qcom-geni: Introduce qcom_geni_serial_poll_bitfield()
- serial: qcom-geni: Just set the watermark level once
- serial: qcom-geni: Rework TX in FIFO mode to fix hangs/lockups
- soc: qcom: geni-se: Add GP_LENGTH/IRQ_EN_SET/IRQ_EN_CLEAR registers

Douglas Anderson (8):
  soc: qcom: geni-se: Add GP_LENGTH/IRQ_EN_SET/IRQ_EN_CLEAR registers
  tty: serial: Add uart_fifo_timeout_ms()
  serial: qcom-geni: Fix the timeout in qcom_geni_serial_poll_bit()
  serial: qcom-geni: Fix arg types for qcom_geni_serial_poll_bit()
  serial: qcom-geni: Introduce qcom_geni_serial_poll_bitfield()
  serial: qcom-geni: Just set the watermark level once
  serial: qcom-geni: Fix suspend while active UART xfer
  serial: qcom-geni: Rework TX in FIFO mode to fix hangs/lockups

 drivers/tty/serial/qcom_geni_serial.c | 322 +++++++++++++++-----------
 include/linux/serial_core.h           |  15 +-
 include/linux/soc/qcom/geni-se.h      |   9 +
 3 files changed, 206 insertions(+), 140 deletions(-)

-- 
2.45.2.505.gda0bf45e8d-goog


