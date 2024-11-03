Return-Path: <linux-kernel+bounces-393994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19DC59BA853
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 22:28:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FA89B217C0
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 21:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856EC1AA785;
	Sun,  3 Nov 2024 21:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m/R3ZgZ4"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A913199948
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 21:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730669206; cv=none; b=AkChAlN2FTyzuurWN6xwd/iWgPQxK52lpp5ZB/hfkCeOhaPRRWym7p75HSG6wI6O6TpmviX8xKLYUjZa3qtnhvq3cF/M3nUAIGw37HOLYbZMfvd3DI38lsH681bLnry5s+L0ldI4wQO7wYveqjFlsbBvNZja/UHR9qgi/iXbYS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730669206; c=relaxed/simple;
	bh=V4P0B2EgUQLw86NKiUCzY+oZ2ZLOhwnaId7lph2qPcM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PlWwkXWgQBc7c2ZrIkfYnurzFwLXwIzOOmnC+jkTC3OQO0HsIOkeDWkVzu2UCm4loQVeoginFlayS1jOunpqIokfDJhTOVmQPMU3b/Jzg98AU+P1/9NPNrNkWg9e/26QtD4dqcs2vURhyemBV1QzHnhvWCybNHJ987Jlnsw6iAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m/R3ZgZ4; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4316e9f4a40so29228585e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2024 13:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730669203; x=1731274003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jHXAdcTsvT4B5g/S/kETasZjOIWl5qfipOtLsGqLhtk=;
        b=m/R3ZgZ453mkVctGoqHHS4UE7o6LQDbBzqSq7Cr+m4QcAg3SzI53t9WAsk45Ptk1hW
         YP4rJtwEu5lT00JXxfD2yqwMwxQ8Q4zALiTBnv3ku6qfk2SutTlQZd1ptKhrwe1XDI88
         0HmdPecQiieDHn1pseC9lYkLsE/+MIUMq7laCwlmQaXdLyJoj2zz+Bw28kyvLXtMDyHH
         +ZVZSeXQG4CLwarqACcLP4CNy0MUi1nmRKG/2lXbiGbCW0WDlHpLn8Gmf+ez1CCJrwGq
         Ba3eoMcziYzXlu7X9TNE1mDpncJC0+3ws6trnFgTNtovrOTR9n0yZhqNsmZV5j7/9aRJ
         9ZHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730669203; x=1731274003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jHXAdcTsvT4B5g/S/kETasZjOIWl5qfipOtLsGqLhtk=;
        b=lWQww+2jQI2N0KhjeKkrdohk4tzrKPfnxAbzneAvXSR7NV+9v0kw0ELDoNaeMQ7RfZ
         PHQRB6AxwhI6lpv+tTbvkXzalnQWgZgIEl30ZPnivNnlHX30ivxeJNZvKGHw4sPdvj++
         UnCA82xBdQ5PU9Ieo2n17LUbrvnWDPp8lA060Hzd9abfz9Nsyzk6E/d7E4CV2NA0+jdo
         B3UF8ZN4xTt4QrA4f0SNDAzftfOdqSnBYV1PDRKSUiwByH7ZPoI4XaSixj/zI/qRUHxa
         3GEA3PgfGlggTLD8QgxbwWuOt2GrpXC15fusDfgAZoRVB1T5E8ghBisXcxz1+FRY7+8S
         9lag==
X-Forwarded-Encrypted: i=1; AJvYcCW74HMmaUSYa+4j26YmAM2oF15jw41kOiKSkc60sJFerVX5by1h9lLpqu1I24T/Hv/EFaqWgp+lzcyLRjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKe1pLdTC3VezJ8NwNk70Y3CjPsJrWkkB/6dEsaOGtbW2skUP5
	8VJ9rTxw58Fl6KqOnTcd5rW4zercR4QglWchGLD8byYp8Ha/oUJ0ho+FiQaV
X-Google-Smtp-Source: AGHT+IFMGDx9DOAYBdrUFd8VOS4PJJ1EbDKfLHz3JNBUH9jucFE0Ec58+yoNuW2fUZV+sMk/RYEniA==
X-Received: by 2002:a05:600c:3c8c:b0:431:4fa0:2e0b with SMTP id 5b1f17b1804b1-4319ad146b1mr241501305e9.28.1730669203384;
        Sun, 03 Nov 2024 13:26:43 -0800 (PST)
Received: from localhost.localdomain (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd910718sm166150385e9.12.2024.11.03.13.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 13:26:42 -0800 (PST)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: skhan@linuxfoundation.org,
	arnd@arndb.de,
	dan.carpenter@linaro.org,
	Dave Penkler <dpenkler@gmail.com>
Subject: [PATCH 10/11] staging: gpib: Re-order the lookup tables
Date: Sun,  3 Nov 2024 22:26:16 +0100
Message-ID: <20241103212617.13076-11-dpenkler@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241103212617.13076-1-dpenkler@gmail.com>
References: <20241103212617.13076-1-dpenkler@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Re-order the tables so that the bcm27xx table is used first
as these devices are more popular and numerous than the older ones.

Signed-off-by: Dave Penkler <dpenkler@gmail.com>
---
 drivers/staging/gpib/gpio/gpib_bitbang.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/gpib/gpio/gpib_bitbang.c b/drivers/staging/gpib/gpio/gpib_bitbang.c
index 78032af5061c..a2d562cbd65b 100644
--- a/drivers/staging/gpib/gpio/gpib_bitbang.c
+++ b/drivers/staging/gpib/gpio/gpib_bitbang.c
@@ -202,7 +202,7 @@ int gpios_vector[] = {
 
 /* Lookup table for general GPIOs */
 
-static struct gpiod_lookup_table gpib_gpio_table_0 = {
+static struct gpiod_lookup_table gpib_gpio_table_1 = {
 	// for bcm2835/6
 	.dev_id = "",	 // device id of board device
 	.table = {
@@ -232,7 +232,7 @@ static struct gpiod_lookup_table gpib_gpio_table_0 = {
 	},
 };
 
-static struct gpiod_lookup_table gpib_gpio_table_2 = {
+static struct gpiod_lookup_table gpib_gpio_table_0 = {
 	.dev_id = "",	 // device id of board device
 	.table = {
 		// for bcm27xx based pis (b b+ 2b 3b 3b+ 4 5)
@@ -264,7 +264,7 @@ static struct gpiod_lookup_table gpib_gpio_table_2 = {
 
 static struct gpiod_lookup_table *lookup_tables[] = {
 	&gpib_gpio_table_0,
-	&gpib_gpio_table_2,
+	&gpib_gpio_table_1,
 	0
 };
 
-- 
2.46.2


