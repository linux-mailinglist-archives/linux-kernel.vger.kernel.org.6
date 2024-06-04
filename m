Return-Path: <linux-kernel+bounces-201023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A428FB84D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 18:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F12302854BD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 16:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A911474BE;
	Tue,  4 Jun 2024 16:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cvHM+O4z"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225911A269
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 16:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717516905; cv=none; b=guwHOjAxdzwyHo+4MNvXnwJqID9W/8UrGsjaOzOFfyUm6OijlGCtG0cvMCgSJ3HqjAb9GygQolMlcUd5osAvZGnXLdZU3I+Nep+P54praDyzZOU50bCNpQtn/RnG4wb8mCW7khKGD/7bMo4amOZC+X99h0oVI2NloqEYD6clK44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717516905; c=relaxed/simple;
	bh=UHzZ5C64QokgB0Nf9YRDLoY3TcwruMFoCd+RWF3Ex3w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Of/o9fLwKVdzmX4RHJzzIHRjks0VVps170Dr4XV3sXeDmpZ2mlcAw5mBMW3QlkrPGjGsOeefwDybgPbIMhfVf+GQ18ahxZpR0rBbfCa2PAataZ0e1hDC312k+4vWjJzgVJse7POFi//eeoPfa+7JLavOe39mPC4AILVdtMZ4KQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cvHM+O4z; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1f63642ab8aso34406845ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 09:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1717516902; x=1718121702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VrvFgnb5K8RErqVb3j7BOiSXQIj7zAENvVNIAFSR1AI=;
        b=cvHM+O4zfQRQ4C4xy1woVvgozOLvjfdO4PEMPL2Q8wdbxUaPyA8qWVFB43hW5UJM07
         5Bv2nxZZDmQpy42sWSbH4oRthcljo8AJuTcr4ZLNQPCqeQ29estF3PzS3tgvWY5KVP1Y
         L28QX4VlEXpcfhSub22lqAmGHTlmK3Gg8Xnfs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717516902; x=1718121702;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VrvFgnb5K8RErqVb3j7BOiSXQIj7zAENvVNIAFSR1AI=;
        b=Y9eMUxBRpoWw+kEF280yshGXN/PMSbh5qUp47iMVr0kEfvV/uNh3WNZCnWPqQJBE73
         1jR0HdSM6fBlDNJx4EyZ0Jghiryo5nHCvfDyCj72+qHPPWpk/35wC6Kg3L4oXxcBREbH
         TNmNi5UTeF1vSYESc11xqEDcV9d94IUwGGvXYNCJHCUnRuN9jEaueZ1KeYOX7+3DQZeq
         JcE9b4UgDx8Kr3c2T0euAz2k+rlYb5G0tOUXsNH5BIu31R/Mjcy/rFBMcSfQuPlY4ZOn
         7l+dlRhqwEgfO/7o+IktglAdRhcJ2zO7MnsRZncEo0w4jEbfYI+S+cDFJ/bFPapgCihj
         ZfbA==
X-Forwarded-Encrypted: i=1; AJvYcCWcugW5RT8NWEl1ptdvmm/alq2k3TdEhMIZZSTbbUN50X4lGuPgQWzfy4LOlqH0K5RTHdlLJQ/bRRZP5e4KpVH5/E/bZ9FAI5Kqu7nS
X-Gm-Message-State: AOJu0YwxoRq3HhL9/pEp7fMvY1oIzZz+JkFmdpZn28frlntuqjIA2hDE
	gLxHxYaoGXe/cRNcu0+zQ0M6sN0r6FbD2DeMXB4x2s4/M4kClBQQC3tKPq0diA==
X-Google-Smtp-Source: AGHT+IFFgX0sKYkAtcpvw1itN+1f9pVmaj2lYmIXlASKInlnOGaz93g0ZHqpT9u6xEaXRgFFJjMsCg==
X-Received: by 2002:a17:902:e805:b0:1f6:6f45:81f0 with SMTP id d9443c01a7336-1f66f4583e9mr86089725ad.57.1717516901863;
        Tue, 04 Jun 2024 09:01:41 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:3609:ff79:4625:8a71])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f632358519sm86118385ad.82.2024.06.04.09.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 09:01:41 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-arm-msm@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	John Ogness <john.ogness@linutronix.de>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Tony Lindgren <tony@atomide.com>,
	Stephen Boyd <swboyd@chromium.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Rob Herring <robh@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Subject: [PATCH v3 0/7] serial: qcom-geni: Overhaul TX handling to fix crashes/hangs
Date: Tue,  4 Jun 2024 09:00:26 -0700
Message-ID: <20240604160123.2029413-1-dianders@chromium.org>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
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

Douglas Anderson (7):
  soc: qcom: geni-se: Add GP_LENGTH/IRQ_EN_SET/IRQ_EN_CLEAR registers
  serial: qcom-geni: Fix the timeout in qcom_geni_serial_poll_bit()
  serial: qcom-geni: Fix arg types for qcom_geni_serial_poll_bit()
  serial: qcom-geni: Introduce qcom_geni_serial_poll_bitfield()
  serial: qcom-geni: Just set the watermark level once
  serial: qcom-geni: Fix suspend while active UART xfer
  serial: qcom-geni: Rework TX in FIFO mode to fix hangs/lockups

 drivers/tty/serial/qcom_geni_serial.c | 321 +++++++++++++++-----------
 include/linux/soc/qcom/geni-se.h      |   6 +
 2 files changed, 192 insertions(+), 135 deletions(-)

-- 
2.45.1.288.g0e0cd299f1-goog


