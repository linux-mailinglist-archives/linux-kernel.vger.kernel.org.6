Return-Path: <linux-kernel+bounces-187126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1593B8CCD89
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 09:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE8771F22109
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 07:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D27A13D29A;
	Thu, 23 May 2024 07:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Ih7cW4tj"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FE313D260
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 07:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716451114; cv=none; b=j2g+9C4SflvGDGYEvVPz1QnrEFqAdyQWqw3P2FJrZMCXYVdL+qJM3cJskGphCKmDrVd0wo0jHDZbREAD1lX2HsRCM3n6XYDIS3Ng18UJezhDrqu5WZXUgiS2go8KqV2cwKd29sSYPyc/5+iwflGrYlOkcE8lMpd100qyXQ3S7uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716451114; c=relaxed/simple;
	bh=JXfSwwnz3aoD1YttqGWpLZwDZffWB1gKvJPkA/WlJVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q6WCSJqa+oj1k9IFDXG1rlK6+4UP7rjq7Fz/F6pJ2UFyvLZLuP2Bc6NiCWtXQWEMmySwnnNObyL6VVn6LMWxHVPWcQPDjh3XDvpRr5FZEsH5xW/++EUtTFfjfvQ0jV+ldFRRlw+wkM5Lq60IRvTCucstp7hjcbcUitohEzhtiNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Ih7cW4tj; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-420298ff5b1so68326355e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 00:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716451111; x=1717055911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qI60UQPxpWufyIYTmlWT9jYm0QX18O1OLfjH3sNxehE=;
        b=Ih7cW4tjbhpzpJjTY6jbi2qqMrrmkRC97Pso2mnpsH8zpgZqxOaeSNAXZW2OjhCYpp
         HKZKmCsQPXx98VrUTIpA71F0L12zZ36AsSCVVBQFllLEydbJDrwLHWArxSORMeuQSF2Q
         WIOSvE1mn0zwEb8OyEaxEnhpaKdNZgcrGPoYaDuomy8ceL4h0XvxkpyrxOhexYcij8zw
         C403lNhkuCiBiDjcy7UuhXniYLCsDCl9JV1Z0DH8s+Q5OSmZJlwEq9bgROjFNOrIzMw6
         tf8rh54VFmKypHyXkPun+NQmeqfkFMtTMkGO5COcJGxjL8PG7Puq2RVykwkaV7tOopnn
         tQXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716451111; x=1717055911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qI60UQPxpWufyIYTmlWT9jYm0QX18O1OLfjH3sNxehE=;
        b=meBLX5pYHYnbz+JTqyE68PsjiXQXhM6pRLk3jniTSkkDsz6XXIUe/Wzi45QBMosEqb
         vYeK1HT8ktiXKqXBGfS6Ps0v02CN/JOA2xMDiIiRT0a4fmfnPu/kzOtqaYrx1jKXeqBN
         PvcbNLqAM1D6QEnpKDBVUAiqVblQ4IIpDbD9D1l0ohbcSybO+B4x5TqxhNBQMcydxXAa
         2cAcoB530ow1FH9zXNSfIXMyqfsS66pkx/xCJsfgT/IiIPF9WgpaROCMrj5NEd0ClzAn
         LMJQaakr4WseT5nRsWF+lD79Gj3yODLexPdbHJRGU3ldNRQrdofHlNNSlU8IhkPcJDJd
         ucMw==
X-Forwarded-Encrypted: i=1; AJvYcCWgLtalhWNx7kOHibF0DZhpHqL8hf8F+CvPe3opw0OEG6aBvYNMqZBv+AgHQOhvIq3Lv9kGn1bNZN1rREHafoerhVoatVOUtutpFkjS
X-Gm-Message-State: AOJu0YyrKw76ZqecrciEZ8BAckl81h+KpA8hc1wy/rkcc0zt61sCUCdx
	+SHXa6iWN2yvCycDOQyaFMxJ0IdQGjgBKqe93uvVZL40EwewgDcQdulHFg41ZwA=
X-Google-Smtp-Source: AGHT+IEmmwzL+k40uTlhKRwS2l9e+3ryu1+UT4VHTi5jnr4CZXZGZT2LSEj1dDGLqO0KbZJstq52qw==
X-Received: by 2002:a05:600c:314d:b0:41b:e244:164a with SMTP id 5b1f17b1804b1-420fd2f1533mr40593155e9.6.1716451110834;
        Thu, 23 May 2024 00:58:30 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a246:821e:6f3b:6b50:4762:8343])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100f01d7fsm17359125e9.1.2024.05.23.00.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 00:58:30 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	John Ogness <john.ogness@linutronix.de>,
	Markus Schneider-Pargmann <msp@baylibre.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Ronald Wahl <ronald.wahl@raritan.com>,
	Thomas Richard <thomas.richard@bootlin.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: Vibhore Vardhan <vibhore@ti.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Dhruva Gole <d-gole@ti.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 3/5] serial: 8250: omap: Set wakeup capable, do not enable
Date: Thu, 23 May 2024 09:58:17 +0200
Message-ID: <20240523075819.1285554-4-msp@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240523075819.1285554-1-msp@baylibre.com>
References: <20240523075819.1285554-1-msp@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver sets wakeup enable by default. But not all uarts are meant to
be wakeup enabled. Change the default to be wakeup capable but not
enabled. The user can enable wakeup when needed.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/tty/serial/8250/8250_omap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index ca456ea23317..5b7508dfb5d8 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -1496,7 +1496,7 @@ static int omap8250_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, priv);
 
-	device_init_wakeup(&pdev->dev, true);
+	device_set_wakeup_capable(&pdev->dev, true);
 	pm_runtime_enable(&pdev->dev);
 	pm_runtime_use_autosuspend(&pdev->dev);
 
-- 
2.43.0


