Return-Path: <linux-kernel+bounces-246781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB59692C698
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 01:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EEC7B21EB4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 23:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0F918785F;
	Tue,  9 Jul 2024 23:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LySywCaJ"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EC0187846
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 23:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720567775; cv=none; b=GrJykk2V/KXGm91lXK1PYMmI4o/S0miWCufq/q1LlDAbnwN5f4FJ33s8eh3gfzoiKtMfTXusOfW+0yiun412ty4O0pFWcOdnB3ex2rjI9iFJXse7xU+OkfQZyIh01q5cgEAlhN9DTFYBe8ztC3NsLGXp5VwU/0Pp+7i/26WOmw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720567775; c=relaxed/simple;
	bh=/C+m9G5C1oyrifrND44Mt+NNq1kq4xLtpNHvtlTs6Jc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sU3TMYjoGWyMYheeX6IyFTUFR9+l0E3OAi1pkJwm7GeegL2t/upaj4J+TtdAZqNTdGRisiU112Lw9LlbZeCxEhtw1cwuINBCSbBRP7+9xbxSv2WkZq6Fh348izt4k27/oyqd5olnPk8ZPPlNuNqjw4To8aHQEB+DSpHTAiVSDv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LySywCaJ; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1fb3cf78fa6so32291525ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 16:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1720567773; x=1721172573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kRK2aH8EGZeW0Byt2MUaFYsISDnZuj8/DLaqPgMip44=;
        b=LySywCaJjNi+CAZrbHs4Z2z0C3gpnLSHfmsw2oNlw4muNgtV5DmXwnFeXHAOiM99n1
         6WBeLlfhhrvTlz3AmDTt8L4+GU2qJX9iXlG6YKaBWQDd8oo3D40fKT3iaiSidOZdiXey
         su2aC6D7NhvrMQ7xlx/hgnPKXafYL4YM/bw9I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720567773; x=1721172573;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kRK2aH8EGZeW0Byt2MUaFYsISDnZuj8/DLaqPgMip44=;
        b=II0ENabL96b/XvECDoD54tDfNUbLMVRu3EbLs+uTlAugFuwuicZGd9i40gDRnqBT3S
         tl5KeGaiEqpHYMr+h1vZ31NNFR3aFsFMvmrMC1zV+hUq/GODnbIzLOAGEi+AiYovFuyK
         4LSv8iyU29WPBEzr5Y+CPcDGH2sOX6PVlWILhEZOOv3M/kPXA9qmnt8n+ugWN1chmymZ
         f+T7T4wg34o/6pXy61uEEqBJ9O/upk5Zm1S3lA9aFKl1vaaFQdyVaTW7ypub8jTWt/Wb
         0q99nUUOhmjhVD8hnfCnxggeqAlUV3Va9hgYkO1htdS5JQHFYjdgvdYsfYGaDFTmGRrW
         qPgA==
X-Forwarded-Encrypted: i=1; AJvYcCXhVF24t/HuRyMi+dkSphTqnBLHmt2yFR0CtE6ckjVsmcrIegeIUa5jX0I2m8hBHRlzfSBunz5X77p7ucP+KMyKSvQs/MlT/TbI0vlI
X-Gm-Message-State: AOJu0YxQNwuSSd1rQpcz6A6Ca+fQpFvMoWDwSu162/oTUj+m3XHEpGeY
	ffQKfGzE9pTq1pFLq0woft6tMRoG5jfUCgSXl7chEG2NYE+xdgN7xdcahMYM8qWPXtk+DESFDcE
	=
X-Google-Smtp-Source: AGHT+IG68wqqdkjCg2HTkpkJ73U3cwNCZ1/dIfTvUZgwAXz7p8+hO34uDRg42cFEf3wMNazOD5hbtQ==
X-Received: by 2002:a17:902:d4c7:b0:1f9:a386:2bbd with SMTP id d9443c01a7336-1fbb6d4408fmr31698325ad.22.1720567773289;
        Tue, 09 Jul 2024 16:29:33 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:1c76:f248:3538:85f7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6ac80a2sm21319745ad.236.2024.07.09.16.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 16:29:32 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Douglas Anderson <dianders@chromium.org>,
	Johan Hovold <johan@kernel.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH] serial: qcom-geni: Show '@' characters if we have a FIFO underrun
Date: Tue,  9 Jul 2024 16:28:45 -0700
Message-ID: <20240709162841.1.I93bf39f29d1887c46c74fbf8d4b937f6497cdfaa@changeid>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As of commit 2ac33975abda ("serial: qcom-geni: do not kill the machine
on fifo underrun") a FIFO underrun will no longer hard lockup the
machine. Instead, a FIFO underrun will cause the UART to output a
bunch of '\0' characters. The '\0' characters don't seem to show up on
most terminal programs and this hides the fact that we had an
underrun. An underrun is aq sign of problems in the driver and
should be obvious / debugged.

Change the driver to put '@' characters in the case of an underrun
which should make it much more obvious.

Adding this extra initialization doesn't add any real overhead. In
fact, this patch reduces code size because the code was calling
memset() to init 4 bytes of data. Disassembling the new code shows
that early in the function w22 is setup to hold the '@@@@' constant:
  mov     w22, #0x40404040

Each time through the loop w22 is simply stored:
  str     w22, [sp, #4]

Cc: Johan Hovold <johan@kernel.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/tty/serial/qcom_geni_serial.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 69a632fefc41..332eaa2faa2b 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -872,10 +872,10 @@ static void qcom_geni_serial_send_chunk_fifo(struct uart_port *uport,
 {
 	struct qcom_geni_serial_port *port = to_dev_port(uport);
 	unsigned int tx_bytes, remaining = chunk;
-	u8 buf[BYTES_PER_FIFO_WORD];
 
 	while (remaining) {
-		memset(buf, 0, sizeof(buf));
+		u8 buf[BYTES_PER_FIFO_WORD] = { '@', '@', '@', '@' };
+
 		tx_bytes = min(remaining, BYTES_PER_FIFO_WORD);
 
 		uart_fifo_out(uport, buf, tx_bytes);
-- 
2.45.2.803.g4e1b14247a-goog


