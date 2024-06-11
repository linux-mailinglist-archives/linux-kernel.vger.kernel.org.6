Return-Path: <linux-kernel+bounces-208994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CAE2902B8D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 00:26:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 580791C22138
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 22:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC17152178;
	Mon, 10 Jun 2024 22:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Yl4MEXmL"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71361514DC
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 22:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718058341; cv=none; b=T2fZ9otyzwUaNkyFuGputZ7DN0kLqwRMjc4RVeehTStyYbveyhfqiPz0WLrl/8e84TdZkCKg6H9LJc6y/xyGkzH+WNeHg3tkZ8bJF7s9JDTx7998z7sudmMzmyqNpI/Xc8cSVI4uqXEJr562bBcnOdbnTvJgMTJux5x1fFqos1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718058341; c=relaxed/simple;
	bh=b/gmORW177pH358qwBll4nCzl18LhbdthrWxcEpd3WY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IXhksNHy9wOD27RdxsKSQv9B2lXNyPC0sxOQrj2MxvJ9DsMCt20Z4SFhtN43lTaKqcDtc9Vh817oP7YCrb9LJf59heVwkzv2KybioLA5IOoVSu57dt4+I5e9E8SfmNUuwEO1BFsiH/L08hZFH/nlldQKvjyLwxe6yevHoDY5WWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Yl4MEXmL; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1f6da06ba24so27533875ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 15:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718058339; x=1718663139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nKk/Fcf4krWK/CutdJaQNqib/rpK58721OaB/B0Az0c=;
        b=Yl4MEXmLY1Hlh4sAr3wjNFtQ3BaO0gFGzAI7U5DW1fjXy6EpvqNrx5c/Iy1oucxc5N
         j/DnNXxi8fGqv0KcWHqj5dByyQvsT7zXM+pynSCjm2tJmvxk8BKNBBZ+CsqYoQUyIGQ+
         p1aH18VNQfC21BJV3maG+uPpiegxBXG+o9zZI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718058339; x=1718663139;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nKk/Fcf4krWK/CutdJaQNqib/rpK58721OaB/B0Az0c=;
        b=nnR+tmVVRRwO7NTyR280kB9rcz2TsJuK2kyIt9C/wY+RwcS03rrKQfE2UcMzWWzz08
         0FilPH7/pJ2p+mQ/Ra4OZybrCLbvu3HHnwjDZDip1oukTqcisdfd719eGReJU1k8clts
         cCx+hgEw3nvTF42LeDRvBxyP6MT53OhtIIvmHegWCWBUfIvm2DB7M9QwZuKT1wY1mZRx
         ElOLiUXa18nBNXf0rqhQYghxp0sZZbTvr+9+YdKB+FP2QIrk/mMFBxJDpG4pZfb/Y1mI
         Mpcnq04VEVy17OyjWhwLzpwE1kUV/68Z64PqARN3yKxMdwSKO0cG1d7KSvUTgnS/ynUq
         lSgw==
X-Forwarded-Encrypted: i=1; AJvYcCValuK/Z6hPfUUByG38PV3PAPJVzxxRZk6lP30FOj7ztW/XDDDRygBWA4Fv1as2u1zM4nevexEfrZ4s5wz7GeQAJtmj/AvVm2ZzOx4u
X-Gm-Message-State: AOJu0YxtgZI0vQeDF3pyZs1RQOxbEMP95/qlFU42iKO60QdWBPQZUsuO
	a4E0padIu007ilmRnb++GUJZvh3Xyia+Yq4LOCOr1C1smPSmSOwEJ1ZGq30K4Q==
X-Google-Smtp-Source: AGHT+IEPvKsxtcTKyVFqYj3DMCQNNVcrn0tqX55aDDTvedwEK+TaMY96o+XSdyorpL5zdw3WSjvBxg==
X-Received: by 2002:a17:902:dace:b0:1f7:2dca:ea39 with SMTP id d9443c01a7336-1f72dcaf3a1mr3583725ad.68.1718058338829;
        Mon, 10 Jun 2024 15:25:38 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:bba2:69f4:1b51:d0f5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f71029e223sm29212325ad.170.2024.06.10.15.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 15:25:37 -0700 (PDT)
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
	Douglas Anderson <dianders@chromium.org>
Subject: [PATCH v4 2/8] tty: serial: Add uart_fifo_timeout_ms()
Date: Mon, 10 Jun 2024 15:24:20 -0700
Message-ID: <20240610152420.v4.2.I65a6430ab75f74d20c28b5c5f819dd5b8455933d@changeid>
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
In-Reply-To: <20240610222515.3023730-1-dianders@chromium.org>
References: <20240610222515.3023730-1-dianders@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The current uart_fifo_timeout() returns jiffies, which is not always
the most convenient for callers. Add a variant uart_fifo_timeout_ms()
that returns the timeout in milliseconds.

NOTES:
- msecs_to_jiffies() rounds up, unlike nsecs_to_jiffies(). This is
  because msecs_to_jiffies() is actually intended for device drivers
  to calculate timeout value. This means we don't need to take the max
  of the timeout and "1" since the timeout will always be > 0 ms (we
  add 20 ms of slop).
- uart_fifo_timeout_ms() returns "unsigned int" but we leave
  uart_fifo_timeout() returning "unsigned long". This matches the
  types of msecs_to_jiffies().

Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v4:
- New

 include/linux/serial_core.h | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 8cb65f50e830..97968acfd564 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -889,14 +889,21 @@ unsigned int uart_get_divisor(struct uart_port *port, unsigned int baud);
 /*
  * Calculates FIFO drain time.
  */
-static inline unsigned long uart_fifo_timeout(struct uart_port *port)
+static inline unsigned int uart_fifo_timeout_ms(struct uart_port *port)
 {
 	u64 fifo_timeout = (u64)READ_ONCE(port->frame_time) * port->fifosize;
+	unsigned int fifo_timeout_ms = div_u64(fifo_timeout, NSEC_PER_MSEC);
 
-	/* Add .02 seconds of slop */
-	fifo_timeout += 20 * NSEC_PER_MSEC;
+	/*
+	 * Add .02 seconds of slop. This also helps account for the fact that
+	 * when we converted from ns to ms that we didn't round up.
+	 */
+	return fifo_timeout_ms + 20;
+}
 
-	return max(nsecs_to_jiffies(fifo_timeout), 1UL);
+static inline unsigned long uart_fifo_timeout(struct uart_port *port)
+{
+	return msecs_to_jiffies(uart_fifo_timeout_ms(port));
 }
 
 /* Base timer interval for polling */
-- 
2.45.2.505.gda0bf45e8d-goog


