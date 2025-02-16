Return-Path: <linux-kernel+bounces-516592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C42A37469
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 14:03:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 205D81894A37
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 13:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2D319E82A;
	Sun, 16 Feb 2025 12:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Zee3AAfF"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145B419D89B
	for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 12:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739710739; cv=none; b=rQ6VD7ypwl2vemipkj8/wqnyd4wyCg1PM5Of+FZVUs4O56ylEOPJRNRmB1pWL3Vn5f+2MoIyRb96zW2eEPEMnRcz5l0awJXtPyUQAgotQGQ8FkzAuHO7aDdhaUUDhy75TRFi3Vx+v3hZl1eONcf7pLHmukoyxweaXiZn6D9KxTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739710739; c=relaxed/simple;
	bh=M027Wka85YHpOsFpEaAyOcm3fQNZIgSRcuqEQ7ncvt8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AYVPMAC6lIeINSsVCXSraHAnUo7A6Ne23qqBqtQZ6xB+BPzdCnFrefdtxT5b5AETossKo1dV/fqqtraUkGv8JXFBp9RfoytlVlfzTAmyp80MsuY+lq4/t9grMhLw6EMoxZXneh8X+p+gossJxNnRdY04zM1AYCgvDs4EhLIXA2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=Zee3AAfF; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id CBE8E3F175
	for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 12:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1739710736;
	bh=zhY6qp/Hv2zLsONt663fjITCkgKIh4r/C82D6wubct4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=Zee3AAfFtX2bUD4y8q0RnGqvVeKcsn/2Jyckah1iZ7BHbFVuRRAJNJpn642JS3vjp
	 rYTSHqmtB8mXj6lD+8jTAENMk2ysM4fjXEToFpmxmoDSccMFMBwrytxqNTD2for5HX
	 sf7qW4+6LqapyysqjLeWVwdNkyPMAZaQdBGXrPY722grhQx0K/7kfa0zy9AkjrF2tu
	 Z1xlMdJWUExehQ70yt8SIYFGp570PNkLNLmFOljrcl4Ej+1+jW5QIGhDS8MbXJrxz1
	 oA0RsKp/7/qDiv0HUq6jSCIVuOzLXcj7DlMq52dHHljoa7SNNlDIru+CUIQhUNIM+a
	 +V9eouTau6BFg==
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-220f0382404so44830915ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 04:58:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739710735; x=1740315535;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zhY6qp/Hv2zLsONt663fjITCkgKIh4r/C82D6wubct4=;
        b=sN/lZaPmPUVr6hbIOWn+C9mOaiN6yMmc82eieGAFJPjBM6aFmAblgRLaHzER3olyFQ
         jf2itGCV9JxMd52Jmc8KPc2sJEMG6tOPYRKqRXAHtuNsjydLo+nSXq5kgUhj6MME9ppB
         YM8JA4aiFUrt2bdKS867mnel0NSyRY0KUTr43eWCUGVt8nfiEpFHbkq4XyXMCHcJD4MY
         r5XGWOeQl48RG3TlqW29ryB6Cht3yhu8QNCQPN0FAhS/7gLo6s6VUMs8ETTHq9cVAHJv
         JX3yInCzJvG69ww2mdb7NM/pNCGl0WyGPppS5PPPzUy+Syzv9IhI20KdMduNGy8t5AK7
         m1tQ==
X-Forwarded-Encrypted: i=1; AJvYcCWph70u8z6j6tCx/PRqLCVO9jPfECFlEFtMsmaGFTQQtG0WmpMMkZ2geVbs6ZwXOyicuobgXfNhzt5T9EY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVUCgGSyLA/P1i79OGtu0PZyLiGrNwJ8iKYD3CzrfSCkG29Cbl
	TxTfuOwHc0xP3icu0HIwKsKFV1eFuV+KK1fIAHkWiBdHcZlMTmLldCEAbR1oC+SZfy/L4VKtGnt
	Qvf895vCJ9Tf7X29I/hkzz2DzcxeNM4xVu2QMxFCLVVSO8IhX1uQr4mXeiZRtl6jZOdWumu8JOE
	Tytg==
X-Gm-Gg: ASbGncuLP2rMpEij+zN6VMbRtLJkSBuCMOharX1Q5kYT4H92l/vBVepXN5hNHbWiebz
	QD6F9yUm3dyOl4n081WjHX/KIJeOEeJlOC8dKc+56RhVHx1XnTQE7z1Zr8kfiN2jnVEgXI8EK9t
	WtYsrIendDnc+ieq3vo1ad4YDe6DfPNN8+8Rx4jJDfpy+PiG7pCu8wPzbzvEy2f/zTOGaCBRoI+
	QasHTq+9lm0Lpp96U7OVqnA3HpuYHKnU/X/NfEpFtW3ZH/MoVATm3sTATNxnV32lcu6i+WR2r4b
	vOqweA==
X-Received: by 2002:a05:6a21:e8d:b0:1e1:aef4:9ce8 with SMTP id adf61e73a8af0-1ee8cba0fc4mr11535562637.28.1739710735444;
        Sun, 16 Feb 2025 04:58:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHuPqNVXjgq1Wr/qoPHQT9LJIyj39hUcdGoEPe0WRrviyP2A3rvxb9A/MoT8qL0lIxtuEIFPA==
X-Received: by 2002:a05:6a21:e8d:b0:1e1:aef4:9ce8 with SMTP id adf61e73a8af0-1ee8cba0fc4mr11535543637.28.1739710735131;
        Sun, 16 Feb 2025 04:58:55 -0800 (PST)
Received: from z790sl.. ([240f:74:7be:1:eaa9:d394:f21d:ee9f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73256fb09e1sm4316545b3a.65.2025.02.16.04.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 04:58:54 -0800 (PST)
From: Koichiro Den <koichiro.den@canonical.com>
To: linux-gpio@vger.kernel.org
Cc: brgl@bgdev.pl,
	geert+renesas@glider.be,
	linus.walleij@linaro.org,
	maciej.borzecki@canonical.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 10/13] gpio: aggregator: rename 'name' to 'key' in aggr_parse()
Date: Sun, 16 Feb 2025 21:58:13 +0900
Message-ID: <20250216125816.14430-11-koichiro.den@canonical.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250216125816.14430-1-koichiro.den@canonical.com>
References: <20250216125816.14430-1-koichiro.den@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename the local variable 'name' in aggr_parse() to 'key' because struct
gpio_aggregator_line now uses the 'name' field for the custom line name
and the local variable actually represents a 'key'. This change prepares
for the next but one commit.

No functional change.

Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
---
 drivers/gpio/gpio-aggregator.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/gpio-aggregator.c b/drivers/gpio/gpio-aggregator.c
index 692d90246674..2e993c9a7ce5 100644
--- a/drivers/gpio/gpio-aggregator.c
+++ b/drivers/gpio/gpio-aggregator.c
@@ -988,7 +988,7 @@ static struct configfs_subsystem gpio_aggr_subsys = {
 static int aggr_parse(struct gpio_aggregator *aggr)
 {
 	char *args = skip_spaces(aggr->args);
-	char *name, *offsets, *p;
+	char *key, *offsets, *p;
 	unsigned int i, n = 0;
 	int error = 0;
 
@@ -997,18 +997,18 @@ static int aggr_parse(struct gpio_aggregator *aggr)
 	if (!bitmap)
 		return -ENOMEM;
 
-	args = next_arg(args, &name, &p);
+	args = next_arg(args, &key, &p);
 	while (*args) {
 		args = next_arg(args, &offsets, &p);
 
 		p = get_options(offsets, 0, &error);
 		if (error == 0 || *p) {
 			/* Named GPIO line */
-			error = aggr_add_gpio(aggr, name, U16_MAX, &n);
+			error = aggr_add_gpio(aggr, key, U16_MAX, &n);
 			if (error)
 				return error;
 
-			name = offsets;
+			key = offsets;
 			continue;
 		}
 
@@ -1020,12 +1020,12 @@ static int aggr_parse(struct gpio_aggregator *aggr)
 		}
 
 		for_each_set_bit(i, bitmap, AGGREGATOR_MAX_GPIOS) {
-			error = aggr_add_gpio(aggr, name, i, &n);
+			error = aggr_add_gpio(aggr, key, i, &n);
 			if (error)
 				return error;
 		}
 
-		args = next_arg(args, &name, &p);
+		args = next_arg(args, &key, &p);
 	}
 
 	if (!n) {
-- 
2.45.2


