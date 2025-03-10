Return-Path: <linux-kernel+bounces-553747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB2BA58E68
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 09:41:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A3BD188C218
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 08:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D630A22371B;
	Mon, 10 Mar 2025 08:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CjbincBd"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8980822258E;
	Mon, 10 Mar 2025 08:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741596096; cv=none; b=sTqBvhFJT1R46JgiKwCTriB1vBv/hX3Zmm0It4Xgv+mUa2WevfMcBTc6EpgKgh17o1rRM8/br3Nf/AXadKrtq386nKtYVOK4pYaDfDM4mC+M8JtAXbTWJP4qLENDuWJCtT/jOnCkGRjRo2zQS7xFbtL2+u6XwbpyLd9P6dYWm9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741596096; c=relaxed/simple;
	bh=sZJpqurhRMS2QPh3cwePIaisIvFQbiS5sBipqSnor+o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G2LZoqZwDLeaC7FgrJG3BC2Ca4BGypSnmjCnJU5oZLuZ9bkSntjPHG0kSJwPMD95hDPlHQgEANew0irUEodVQx6XX9To7J4Fnhae00pkeyLb3RpYigjq++56I0JF1+ZWwcRgIgNZ2ytl/eYhkNj13YOeOpHis8Di+hv+sjz6KIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CjbincBd; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5e5bc066283so5994640a12.0;
        Mon, 10 Mar 2025 01:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741596093; x=1742200893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QZUNeINjdqSJ79E/oEIhLa9NAr++krOxCOFKaWQ3/OY=;
        b=CjbincBdIrgVzTdHzhRN5Z4BsDMszNfTeBkRXoNVWDvO38Yk853cDBfROLnZqJFQ/5
         2DH9kYA/Chx3vN6BHmsgAX681HS92dhskIjpndhiCZcXSs2Y3R3eGCUgsc8ZcclYRIal
         COtoFAUhMA4FQDPD4U0jDU7eCo5L971Kf2thfNQl/lM8JW9R69x685qTwJDHlFUmr9ba
         /yDpo3bbaXXmxRrJpCBNq1HvwxtadvEnnglQZfonTXWhm/sNz3LEaDftdIisDphJVgWI
         Ad1e+qTlaF/aw+Db6Mh6ajNONdEtoj4nHmHO7g+B3T5Ej05nkSlQGNRCxgZwO0s8WALJ
         FyqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741596093; x=1742200893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QZUNeINjdqSJ79E/oEIhLa9NAr++krOxCOFKaWQ3/OY=;
        b=jutWKIlKK5OM8xqCbPsV2yOCVJM18YCHU2GdPDdIhorSPtGenczskABKOZ4ShZKXPM
         cPbrkRvqPMI5xza2imLorM1yHix0TM5qgs87wLVrG8/BuTnq2HERH3wGceo2p1p0MwX2
         BZPkecgeH4g4O1xnj6JYOhxAzPpFcAbBOH9RwohMZphLvH4lmhlBDwOXska5mHQTE8Ds
         PgF1cqQinRjyOTBNkS9X5d6AQD4b8t5ZZVb7YRZ35scuoycGwUbYocNgJkoUJfHnOp42
         zRfCf3SD+xPp69xyZRfACuIPqUkvayE0T/Sw235IQcnJOq4T6kuu6e4Oc/boSuGH0SOx
         NPiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHGBXaJgKRFWYK3l8ycycEQQg+SOOd73Os1qKdD4F2D/9NZw6aJRiCG1sIQrux54ywqE62S8rpKueN/Ho=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJkQkZS284mmN/qZBQPJr68l2TS30GjolKbCpnxcEkShcnp/As
	muywpmhwbOts/9x150nDFGQTFp3PmTo1BUs6/IGAJShirlYQ7+q9
X-Gm-Gg: ASbGncuAorjcOFLd2dDA5rO+1hscoK3n64yuJBFsuRId1qi06g7VUim8PLcXWGTJiDu
	uMO18k1ehZXn0LvYA/QQ96BGr+6RMXsMekZfDSPcBXmLyGw+PRPfJOHDtQL7pjOGBMM6UqkKaKf
	q6bumc9NhT377udbXY3YYHlowa5ZesQd29PYGBLx7NfIBapLsb5vKTJgU6wJr6hvsGE61VfhBf1
	0syInTlCi6+jZ4xu1WHOkgc18l/jd6lCqRN1fXYx1teJvZ4N76j4D1B8LVjmyTEgBDzOkyND7Z9
	UUZf7b7apVhnIMKNB/rO4fh9PTkqXCA54a2DBood3nlRocCiZmGNSGbP6B5k8g==
X-Google-Smtp-Source: AGHT+IELDJI+VIDcVn7Yq5RFxY6w/z428UF4fp4K88TLicDPu3CdberaWXBF66KZJcQjbTu2huEF6w==
X-Received: by 2002:a05:6402:234c:b0:5e4:ce6e:3885 with SMTP id 4fb4d7f45d1cf-5e5e22b22aamr13600345a12.2.1741596092564;
        Mon, 10 Mar 2025 01:41:32 -0700 (PDT)
Received: from foxbook (adts246.neoplus.adsl.tpnet.pl. [79.185.230.246])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c7473ea1sm6619073a12.29.2025.03.10.01.41.31
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 10 Mar 2025 01:41:32 -0700 (PDT)
Date: Mon, 10 Mar 2025 09:41:29 +0100
From: Michal Pecio <michal.pecio@gmail.com>
To: Mathias Nyman <mathias.nyman@intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] usb: xhci: Avoid Stop Endpoint retry loop if the
 endpoint seems Running
Message-ID: <20250310094129.20273c14@foxbook>
In-Reply-To: <20250310093605.2b3d0425@foxbook>
References: <20250310093605.2b3d0425@foxbook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Nothing prevents a broken HC from claiming that an endpoint is Running
and repeatedly rejecting Stop Endpoint with Context State Error.

Avoid infinite retries and give back cancelled TDs.

No such cases known so far, but HCs have bugs.

Signed-off-by: Michal Pecio <michal.pecio@gmail.com>
---
 drivers/usb/host/xhci-ring.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 28ebc0fc5bc2..241cd82672a6 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -1259,16 +1259,19 @@ static void xhci_handle_cmd_stop_ep(struct xhci_hcd *xhci, int slot_id,
 			 * Stopped state, but it will soon change to Running.
 			 *
 			 * Assume this bug on unexpected Stop Endpoint failures.
-			 * Keep retrying until the EP starts and stops again, on
-			 * chips where this is known to help. Wait for 100ms.
+			 * Keep retrying until the EP starts and stops again.
 			 */
-			if (time_is_before_jiffies(ep->stop_time + msecs_to_jiffies(100)))
-				break;
 			fallthrough;
 		case EP_STATE_RUNNING:
 			/* Race, HW handled stop ep cmd before ep was running */
 			xhci_dbg(xhci, "Stop ep completion ctx error, ctx_state %d\n",
 					GET_EP_CTX_STATE(ep_ctx));
+			/*
+			 * Don't retry forever if we guessed wrong or a defective HC never starts
+			 * the EP or says 'Running' but fails the command. We must give back TDs.
+			 */
+			if (time_is_before_jiffies(ep->stop_time + msecs_to_jiffies(100)))
+				break;
 
 			command = xhci_alloc_command(xhci, false, GFP_ATOMIC);
 			if (!command) {
-- 
2.48.1

