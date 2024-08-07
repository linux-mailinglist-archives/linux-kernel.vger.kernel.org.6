Return-Path: <linux-kernel+bounces-278024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6CCA94A990
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 16:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7F721C21220
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 14:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E6F7441F;
	Wed,  7 Aug 2024 14:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="PKt0TU2o"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49B94AED1
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 14:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723039974; cv=none; b=Sj7zUxFw6+oyE/c9FDB1YD/aNKz3S9jD525Vx5iwfNwAFL9+1NWGASrom4Sb9t1SdPYVRL2jbzZ1m/DqIGBwYLKhezUEo3FBUg8bevf3rUnSV+V5mCLQF2tQaVhnGre+rGgpInYWqy9W8tfIutm4lEHVcWRynRFbUgoTgfNd10c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723039974; c=relaxed/simple;
	bh=G53h7iK7equCI+YAgbuXL22KeDRVYHM1PGJrRCk2n3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sv1+18mnBTbWMAREFeubc7s3VusLApTUuIuMkCJrpqNq1jc4RKN5+YQfHaEy4fL8pN1h5rC8v5x3qevB6ER9ycPqix3A1c6CsLTEFz3LKNwWiwfBJKjxVoiNTiCnATCCLIpIBSIOUQkX5usGNSV+css+pjl/hixzjflL7sGISlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=PKt0TU2o; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52efd08e6d9so2835095e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 07:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1723039971; x=1723644771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a5C8r3Duyh4k8zPXTMuRthG6AYE+Xab3qX66upD04/4=;
        b=PKt0TU2oq+4p6tLspbrj9btjzCWn8Wcyz+t8d8wx8JrpLnwcCT/IVQ3ANXxxBaxoG7
         ImOOqBIx3CAZotrA0xPrPXiiHsVX0ngdsNGj6TRyFhp/KZjkDuFQ+sFu3bl9UiQIUoF6
         oMDmFd9mo7EswuD5aeaDeDjhbw7TS2VZZoruofRWIntOhuMmt7bP/tr2h/8yvL7MN49y
         D0pehhghzftlXhP3zsBK3u7e3khtFg4RVVBxueUMQfE6iDPelLbHDVDA7u5lmdn9md7O
         4qCNkQ3T9kPOdmE3i7JFSlVgmDiW8RiDnC33M6kzRs0T17eQXSYUXxlhPs7/U/ro+WLz
         rrWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723039971; x=1723644771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a5C8r3Duyh4k8zPXTMuRthG6AYE+Xab3qX66upD04/4=;
        b=QmTwVdWGVy9LvFBRG2Of3oVmkvV3G3XbB39s5R0Cx9InudyLIz7usXlv86zYECpgZe
         ORfUNrkhwrI1oTgb9gIkCz1wyG+YDbhJRVDJc9L+EaL3vE9xq2+fALfrz8AilMsb8Gs0
         xcUETaaD3OH3kjz57JGy/1XX9bi+o3XOOjAXyGLLzMHcGW6WBEUvlJia4VmyaHIrjtda
         1JdZQKjDINPEjJll9xMlu6HGsMP5HL4hQ/d/oaPjs8w1tTJ6fX/umTyttJYdT4lWMXgK
         LNjHb6I9XmFBiIEvJ4+thB0AmySf5f5DnrHGb4vnORiJZeIIXZvgR2hXGZRb1QQV+HpR
         y/1g==
X-Forwarded-Encrypted: i=1; AJvYcCVDWRO/lnzCAY2xv9HSHFPVvkEu3Ku9YkR2gIDvGDsOcvMgosRbqKhJVKe/iX9tjyXTqkc3wlr/I+F2SB6bBIeqNgijXndDvTUafE5n
X-Gm-Message-State: AOJu0Yzv6s9IDD1HaZhMLOw/YLJShF/4yba09+6rjdkG4tJI1jl1dLLw
	r0I/ynlMUKkIxI/D1iAxQMVnBlCFonKwAR1RS2pI4wYF4S/M1XTj49aJi4+Rgvw=
X-Google-Smtp-Source: AGHT+IFosTI6Kk9S7vVp+2KFUmR/5pvfyiB5Vr1uhy5ZefdQG7LKhdWRJvxVgUXiBD9CZ+Mjmb+Ybw==
X-Received: by 2002:a05:6512:3c98:b0:530:b760:92b3 with SMTP id 2adb3069b0e04-530bb3a2247mr9912329e87.31.1723039970563;
        Wed, 07 Aug 2024 07:12:50 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a245:8609:c1c4:a4f8:94c8:31f2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5b83b92cbccsm7057525a12.68.2024.08.07.07.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 07:12:50 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Markus Schneider-Pargmann <msp@baylibre.com>,
	Tony Lindgren <tony@atomide.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Ronald Wahl <ronald.wahl@raritan.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Thomas Richard <thomas.richard@bootlin.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Udit Kumar <u-kumar1@ti.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Vibhore Vardhan <vibhore@ti.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Dhruva Gole <d-gole@ti.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v2 2/5] serial: 8250: omap: Remove unused wakeups_enabled
Date: Wed,  7 Aug 2024 16:12:24 +0200
Message-ID: <20240807141227.1093006-3-msp@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240807141227.1093006-1-msp@baylibre.com>
References: <20240807141227.1093006-1-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This field seems to be unused for quite some time already. Remove it.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/tty/serial/8250/8250_omap.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 1af9aed99c65..02d4f3073696 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -144,7 +144,6 @@ struct omap8250_priv {
 	atomic_t active;
 	bool is_suspending;
 	int wakeirq;
-	int wakeups_enabled;
 	u32 latency;
 	u32 calc_latency;
 	struct pm_qos_request pm_qos_request;
-- 
2.45.2


