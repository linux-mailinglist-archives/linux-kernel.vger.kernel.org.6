Return-Path: <linux-kernel+bounces-395328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2829BBC63
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 18:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21B27282A4B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 17:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2871D0490;
	Mon,  4 Nov 2024 17:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BzQ9ndBM"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BB51CACD9
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 17:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730742640; cv=none; b=n8omSZ7FyHcLgNmz4Dtt6XtLDSdubqBZPrGhpB2y4+uhefKWjzj+xEkJLjZf2Wqz95PbaCT9dl6NBlrQQxDd68gWMb7rQx84Ak+1y8s6Oa12q3hJ54TmPIgPOIwSHpC5EHL81BhAqliQKnd0exNw6rZo4wgl3tu95QwpjasO+f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730742640; c=relaxed/simple;
	bh=23ngUTksLpTkGw0aoSlNw3ryYZyvaCsuu0KwcDUyKbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f5d7wgcdrJkkvQtwAfLVYZ9NI7j4JgnPOGeXG/ar1DNIIDXr1YOKHZRO2xndRvXwditjP9MZuA024orYmi7PmVB6SlVQhy5oD/WiIEnVx5IpSSDK9nqAXipyj0ovo8SJjML68ahzKVJhrMq8YbMwtY/nwF822IWFmoANxV+e36k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BzQ9ndBM; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43155afca99so33657585e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 09:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730742637; x=1731347437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3bZW2vMqumbONmM6bkNUy1UefcqeQAO43C3ir03Pf+8=;
        b=BzQ9ndBMA91Ax5xAMyKb9ex8DGTuepbE4rqvN48vdikzEyPQZ1Ky1/Zr9zCPMQ0aPJ
         Q0CsB4EJgtn2hhyBoPPGGHpEXi9F2WOzFIdYW5RmZ5FA5c7+jsbll2gCCpqq0giax0M9
         ZNH1Z98MHFeZ8Cj15VigahzEYb5yJ9s0DnOZ2WtXffHdqaeUWx1uNj2YwehrOgxXWT8c
         B/Ua3wuBf4JuzLaWo0h6RT9FPy33JNixGVUAmvPwaNVlxV5xtMwCsoG8HyQxMrWRUiAp
         DTQnaFL2U3nm+uyTdMhF652E6b9jKK6w9XrshYxbhIe5+71pAYZsgfo81E9cI4SGs3B4
         E1Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730742637; x=1731347437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3bZW2vMqumbONmM6bkNUy1UefcqeQAO43C3ir03Pf+8=;
        b=Jtn9bT/7+6tmvntron4msmGn3KdLHAW62+Jnj6++odDHVhTlL3gG4WofgOk1+blyy7
         0S7VFx9jsb0dNs8qtIeLUaoklU76D1LrcxmdnPlrJCVpQRbQl6Hp4qOydxTb3bhfbedm
         5oX5nm/rq7Ihm2k/LrIyYFBo3W7FHLd4zCNh3ElPn2mrEh25q+ncmTC7z4XeLhv85AQV
         pLFDdJsLdRWfSR0xWJKWScopcoiD6aO9Yv9AcCXGdcLsTeVN7zOnAtiXg4d1b8duHqpm
         bn6Fk7M2Sv/jSZEMKDHgj3fQdWzK5I2cRHikfPLRnZC9wc1ex+ngNnyUtqPmL974j2/a
         cvSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHjmthoaX6PE0Ro88u7hc+xLtQo4fPZnGx8eqJ02+DICu7xWdMK1di8d+cnW9PTeZYbrDBttlNr2V7JTk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG3I9DgqOBnMKYlTT5Gz/FPP+RTnkjbLZzhsL0wsfEVpKok4un
	cZYqYyfGWweDQX6yVTgiDFx8xUUXc6OWB7CGlwrJOxBdxe6qJvUO
X-Google-Smtp-Source: AGHT+IED9koMHdtoigV1IUNLC0Lf8hQjcXzlL4YR2SQSl38kHBY6wovIRGamZetZgT8dKXARQicxow==
X-Received: by 2002:a05:6000:178b:b0:37c:c9bc:1be6 with SMTP id ffacd0b85a97d-381c79bb817mr9913699f8f.16.1730742637254;
        Mon, 04 Nov 2024 09:50:37 -0800 (PST)
Received: from localhost.localdomain (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10b7f80sm13839821f8f.20.2024.11.04.09.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 09:50:36 -0800 (PST)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: skhan@linuxfoundation.org,
	arnd@arndb.de,
	dan.carpenter@linaro.org,
	Dave Penkler <dpenkler@gmail.com>
Subject: [PATCH v3 11/12] staging: gpib: Re-order the lookup tables
Date: Mon,  4 Nov 2024 18:50:12 +0100
Message-ID: <20241104175014.12317-12-dpenkler@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241104175014.12317-1-dpenkler@gmail.com>
References: <20241104175014.12317-1-dpenkler@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Re-order the tables so that the bcm27xx table is used first
as these devices are more popular and numerous than the older ones.
This is slightly more efficient for the later pi3 and subsequent models
but should not be noticable in practice for all users.

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


