Return-Path: <linux-kernel+bounces-408954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B916A9C858E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 10:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8520EB2856E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 09:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4139F1DE885;
	Thu, 14 Nov 2024 09:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lbvk/xIz"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF68E29CFB
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 09:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731575039; cv=none; b=cOL0qsVvVvgWN4GQzJNo9hqCRPw5KJMhSd32HtSRENYM8coECygUj031tUJqMxOHvDgiMPCaMvt4M2tzASi3bqC/GyebmDAwqS4UbCW+bTAq9W0/sjxE06KjvoH51hFL45vLkrwA+d/AyaW7V2be6AAou3UUx9D32c8fWBNLSNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731575039; c=relaxed/simple;
	bh=zWuRiFchZrNBLXRq0j24MhQKqSTdtNiY9xXXezztt0E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=f+d9uwXK6oFWN0xVSYQ0v6d7hF50u2Bl3NX3xJnZzXu1+6nl1M7t2E+M9JQMbZz9SC2AbCCGhN1UDOnysilC3JRpSItPir0x1s+gTn2e1CKvjXJCffZntshIkYsWTZVQPc92CSSEGax/XTNLwGtuI+GhXkwMglo/Xg34HA9vKQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lbvk/xIz; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-37d4c482844so252249f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 01:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731575036; x=1732179836; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8yR9tbhF0q7yv18wxqWfZSuY7tMkF/Aly2je5xrlXRw=;
        b=lbvk/xIzFDHpYcENEsDUfX4v6vkLmdEQktMwFkPfPCkStNa5r8g9MwNcT6RmMg27k/
         7H+L3rUf8b9Krh/OIeYSvQREm6Pkgaq4aezNsqGVTPqFRro8GI4u12gg+HvknsIUbBJk
         lm02PXX8kZxd6cXzLMnmUBm7vV3edn90njBiiZ3o8TIShL33W3pFZOUi4kD9BI/z2KpH
         uKPS8S4IKQ20LIS0Sr94GFIsutVA9EsAtwNaC9pA8kyp/F0IJrzJ0mgq/BAOTIpLNnjp
         hHWwirY0Ozbp1IQBpdRqUSQhzwE8YVRkPEQD3GggCFIg+aFFJNvcaylN9xLg4AAUt4Dg
         HRpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731575036; x=1732179836;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8yR9tbhF0q7yv18wxqWfZSuY7tMkF/Aly2je5xrlXRw=;
        b=GEGl0VbP3lQxT76iKNdvpX6YJLA0yf8UQH84u6U6CCiWSPCsKzIeUg1M8zcrsgM31m
         xR16FRJWIk07F+wqvEeL/RbhY+zlJd68IPKk+N9SYfrzEDmkK8xYBTS9VZDaCGrSStfE
         TuYfY0CKbAdVhsGvp47Bj6GRfCqqHZyAYXJUAutO5QH/OBTQaOX/AgCQ9U+bujU8RkEm
         FUfxZQg14iJsYpNmMx+N9pJc9DMcNnruPf3FAHqFlZqrbt6uNTiJPrm4gJHOe7dxGD5A
         pmu0D6jXpv/lbxMBIyaa7GVM9VIXOWFrQzt+Fwx4iZEyGTlsIESKIElj5T5C6M6j2eb4
         opGQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/9HQ09hWSvB/zYJz47LMz5FJEzi2u2A9lwoKXDZbtIBpGQ1cQ+6wJhlYM8iPaVW9x57gldgp7EYgQ470=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPmluaynt2ohFT8Ajvm+aH0leK93StH7NwENsusC/maNpCYqBn
	v1fD/QQL2cRpukpTUJN85bO11jET3p0vZvxsvvqzC6rJbS6AKUIoC5ZJBE0Vcjg=
X-Google-Smtp-Source: AGHT+IF7LePleA2RVAB0zLKwWrjCZlENR6/gtLxK87oI7QxvhdPKjaNrSnuc/bm9zTG3lEGgwAT6DQ==
X-Received: by 2002:a5d:6487:0:b0:37e:f4ae:987d with SMTP id ffacd0b85a97d-381f1872f43mr18512390f8f.29.1731575036374;
        Thu, 14 Nov 2024 01:03:56 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-382207fd632sm82453f8f.44.2024.11.14.01.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 01:03:55 -0800 (PST)
Date: Thu, 14 Nov 2024 12:03:52 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Max Staudt <max@enpas.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-can@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH net] can: can327: fix snprintf() limit in
 can327_handle_prompt()
Message-ID: <c896ba5d-7147-4978-9e25-86cfd88ff9dc@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

This code is printing hex values to the &local_txbuf buffer and it's
using the snprintf() function to try prevent buffer overflows.  The
problem is that it's not passing the correct limit to the snprintf()
function so the limit doesn't do anything.  On each iteration we print
two digits so the remaining size should also decrease by two, but
instead it passes the sizeof() the entire buffer each time.

If the frame->len were too long it would result in a buffer overflow.

I've also changed the function from snprintf() to scnprintf().  The
difference between the two functions is that snprintf() returns the number
of bytes which would have been printed if there were space while the
scnprintf() function returns the number of bytes which are actually
printed.

Fixes: 43da2f07622f ("can: can327: CAN/ldisc driver for ELM327 based OBD-II adapters")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
---
 drivers/net/can/can327.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/can327.c b/drivers/net/can/can327.c
index 24af63961030..5c05ebc72318 100644
--- a/drivers/net/can/can327.c
+++ b/drivers/net/can/can327.c
@@ -623,16 +623,16 @@ static void can327_handle_prompt(struct can327 *elm)
 			snprintf(local_txbuf, sizeof(local_txbuf), "ATRTR\r");
 		} else {
 			/* Send a regular CAN data frame */
+			int off = 0;
 			int i;
 
 			for (i = 0; i < frame->len; i++) {
-				snprintf(&local_txbuf[2 * i],
-					 sizeof(local_txbuf), "%02X",
-					 frame->data[i]);
+				off += scnprintf(&local_txbuf[off],
+						 sizeof(local_txbuf) - off,
+						 "%02X", frame->data[i]);
 			}
 
-			snprintf(&local_txbuf[2 * i], sizeof(local_txbuf),
-				 "\r");
+			scnprintf(&local_txbuf[off], sizeof(local_txbuf) - off, "\r");
 		}
 
 		elm->drop_next_line = 1;
-- 
2.45.2


