Return-Path: <linux-kernel+bounces-529353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97760A42372
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 15:43:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EA60172C0B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 14:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632322561B1;
	Mon, 24 Feb 2025 14:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Hq76Hsb4"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0154F254867
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 14:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740407525; cv=none; b=Bu0IOEQ1QKProRGUNPGoPt7BtFjs1eFuia8/jlHiclrHkyqn8J/9t6GAqmaocKfPW6ik3Pf3VjZHCd+8MsAKERPsCT3ubat0N+yDlIAppmWbAuwY9LZzcJQ1+i4lCsK8t5mOedPFFNHOMWi9EDEmt+9R9oo0ggJXg2HB0V9Nxs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740407525; c=relaxed/simple;
	bh=mIMrKN5xcM7tpm8rlo5k3zlkRBdN923WRx56grA2Qdw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LmAOv5xoEeIp3KGeYfy4gLDqyolkA8vx2qHxCQV3nNoQ+dk5Taovx/0cau1Ss52yy9UgeOz0F0fPu8tLMT/Cdy6iDBR+EkX1hPNUtcE2IV0ce+fOFYAqeZh8h3w8yuY4gHofs0d2v1Ma+VKzRpu2nz4SXbc99v23+b8Z7AP4Zgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=Hq76Hsb4; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 9417041231
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 14:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1740407521;
	bh=DjlFi9V4c7FKst+EVjkMgygpaoK69o8x/prjnL49xtM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=Hq76Hsb4XzHKxsg5CFq7XxqWf2fz9LeR35/YER6bBqG/+OeGEeqrscODnz7HaJi4n
	 yYGx/6DCKDCdLCVHrwYSU4fds3UfH8jtoGAqKZccJmImfPNelib9KsjNFQ3R6wvcE2
	 NhEFDHd4i3DwBAfhUGlJ/VtSJ90ygk/+R09PCBMCoGHi9ER7Qrfj8Z3WrNnVt0J5JL
	 5Ij5V/YlfMffKagmzs+hMDNHOscW3shNWWBOHmF2uYlo9kvPi+1ChQYoWtO9mZuX/m
	 IiufKhclew+6s8J3FcDm9e8t0AFhdrTM5pGRPHS8MlU7xqtOmWqEdrVeA6fiZL3EFa
	 ivt1iU7LXkoOw==
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-21f6cb3097bso118068995ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 06:32:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740407518; x=1741012318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DjlFi9V4c7FKst+EVjkMgygpaoK69o8x/prjnL49xtM=;
        b=l/k/Hv6sKddYlMUallpKaGrC6ZBJJ8l3SnOtaw3GCuNUVac+77Vz2CBwAXekI2WS5f
         Z+MaO+f1GxQ94MOswb6V8DubbB7ozuOnKvlTsDCNsK5tV/G3WK2grWrIGoQBPXisfx2j
         eCeb1Qg+iWQJ5cOayAgGAMfVkbpT8riwqhhuL8Jqt8XX1bQyyMBw4BmetoY1/3nEHNQV
         7wgWleKhDl+pDCjwxXCS698joDitzs7o2Tp+hQYEvWcN5WtIhAxlitUcLp9iWygokvpj
         VSRXO+Et5V1swfZ6D9towR8/X+BVbR0pCtLNfvJQmfbcq5dY9hYGVzqS4Pp6ruifuKKx
         tSTw==
X-Forwarded-Encrypted: i=1; AJvYcCW46975cLeTBwL0MW+na4LUDw0YS0xoPiJTkSUleCDZ5/GgTpKQqA+IUrYwFAKmD12xhN28jJ96xB0azGc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu6jQGPhIT0067SyZAICkG1OH8/VN8Fb5oga7RxtajCMNqX3u8
	PaIgS4coXu1b3/3saND9ASzRE6NjjMU78roGg7JjPSpq0Uuy5VlyA6lwiZGYbDe9TRK57OZ0buH
	uOKXqXoyROKHOHhgePcArvx8UKaLyO8jP+0Tz7NBOckA5Mo9BJY3iGNzCRuQD8QaLTXL+1w61ES
	I4WA==
X-Gm-Gg: ASbGncufTdMICRvFBxNoBzOcgrqj4u+w66vPPr2NxEaOZmcdTu3m54kfl1l+AT3UPPI
	UJ/Sq4QKm0EgaMkZIUgWCuKRgbPPygjFosOCqSbdKfmiXr+uolXCqCvi9iETmr0q6bpTzMBz0mp
	MLHUastn+++2Il/U40jscllUJzNZokPyo5ZsP7Shulty1/OYEXIFMa4RdfrTMPUCAU5hWhXEa7i
	Vn+/2ktsKZE784tBPBB/25+fTCrjwe+C5W0TLEO/h8zJkhvDC4wVxcWDsnPAtVtxXKNP5dn6bx1
	QSqryHCdU5y1kwRe
X-Received: by 2002:a17:902:b205:b0:220:ff3f:6cbc with SMTP id d9443c01a7336-221a1148e8emr166230325ad.34.1740407518593;
        Mon, 24 Feb 2025 06:31:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEz9BZWNkOBscqruU/pzCAxXMyOaiitRO4f6iCRddeVjQzMWCXFfzbSgjTM0tjnPfmZXCi17A==
X-Received: by 2002:a17:902:b205:b0:220:ff3f:6cbc with SMTP id d9443c01a7336-221a1148e8emr166230025ad.34.1740407518240;
        Mon, 24 Feb 2025 06:31:58 -0800 (PST)
Received: from z790sl.. ([240f:74:7be:1:de7b:58db:ab85:24ee])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d545d067sm177613895ad.109.2025.02.24.06.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 06:31:58 -0800 (PST)
From: Koichiro Den <koichiro.den@canonical.com>
To: linux-gpio@vger.kernel.org
Cc: brgl@bgdev.pl,
	geert+renesas@glider.be,
	linus.walleij@linaro.org,
	maciej.borzecki@canonical.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 6/9] gpio: aggregator: rename 'name' to 'key' in aggr_parse()
Date: Mon, 24 Feb 2025 23:31:31 +0900
Message-ID: <20250224143134.3024598-7-koichiro.den@canonical.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250224143134.3024598-1-koichiro.den@canonical.com>
References: <20250224143134.3024598-1-koichiro.den@canonical.com>
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

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
---
 drivers/gpio/gpio-aggregator.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/gpio-aggregator.c b/drivers/gpio/gpio-aggregator.c
index e6d455089a27..0c30153ce9ab 100644
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


