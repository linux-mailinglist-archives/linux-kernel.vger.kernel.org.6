Return-Path: <linux-kernel+bounces-207498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B4F901814
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 22:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A34FF280C33
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 20:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 047494D8D0;
	Sun,  9 Jun 2024 20:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="HqZsCIor"
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0BE43AC4
	for <linux-kernel@vger.kernel.org>; Sun,  9 Jun 2024 20:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717963587; cv=none; b=o0a5EStuHAZfW2MvgbaTWPwJ3rN+kseFee1Fc+32QChx2sYYGFmidhN8uO27fNVo7/Q3DVjvfUZghydlxQuBdh8rNMCz/aKIGzbUthwt/U0QR5fhOF6emtkYOuixBBIBPdWJfvvqJ3QtfZJv84rxvHJqtnBnmFfQt6fKn33ibmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717963587; c=relaxed/simple;
	bh=OQ8LIfPXu3hLpWk0qkAUgzkjoCV+/oOpWmGnaf7E7Qg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IIFixqTocXGUl/aFyGE8t+YvP30BpelFlfZIjvM1XgTPBVd3InF0TIjmzQe6Rg4crTfj4CoZgnAf8ZEBS6Ov5WwiWTFXRueHgALc6SqtlkIo3w2ELZoHereqVvhJyEASAxWWsNO5kGqlgwdmnEewQp3nD3frZ4EEF4g80o7mNsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=HqZsCIor; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5b2e93fddafso1727748eaf.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2024 13:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1717963585; x=1718568385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oYKfigbf7VqwLqv7HhequLfARQ4HkFaCIDWgcDYu/E0=;
        b=HqZsCIorJSHZPBcperrXtXGBWuE5zcItFcIVv75hX2mX7RI7J6CBmzbBT3LxDTaIws
         9cCLU9M9TOuwS+BV3ClUJ+uYytaBn9lmddcuH6PabcyKAL54c5E19BVgzxGRDscDKdEd
         XTHWW1EjSSfwOfiHU1Y2iQGFLANNtklEUgHR3jAN+dWZFwzbnp0/olL8EZSluEf2YjnC
         F0Fd4BQPAqnpofSVorYa+5b5NVDbCLbmJGknjC4HLOhB/2jrE2cE9kj6Dq3qhnKGQrb4
         Q7P8eppPIkV/e/3d0ernZ7CW+QU88pm+WmJWARXcQHIs7RxhPv68q+4V7glPsthHshGF
         6Vvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717963585; x=1718568385;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oYKfigbf7VqwLqv7HhequLfARQ4HkFaCIDWgcDYu/E0=;
        b=TtV8Bag8DpoqcgKx81krxRSSyzszjp8YuhPVQDrxrya8gg0U4PUC+dMsy5fpnuoYrI
         ozEqc1faUe9VE8nLLLusQkNj9IIPmUyHr60TtOQ7zLciUpqKs4wzxWWFNlnWE/Xwvp8r
         TCypvmlHE5vwDK+0JS3/Z3Luxg8lTFDBKeWGhiqZy5RW9t7lb1jvBciukWfONeKwrOvT
         ZXhj7Omkf7QNir6lHE9dgFWft7sKRsy04XblM9iZmzvj7xNIP3/OTrpxflugRgVFq1pN
         z768rIHcLvMbuS9QXIJRB/skMQ1Q4T8/6hPsBVOHUSW3kC/4xayrpbq+9amtKFGI25s7
         1cWA==
X-Forwarded-Encrypted: i=1; AJvYcCWWu/LDKEe0DKV7Qtxamkb+2lFf5cNs4hdOUnDPaEKSiBlO2i0q8dZMQ5b/hLV6QmK8CoWn4FfEM+j7fSErXz7NS031bEO0ip6y9twu
X-Gm-Message-State: AOJu0Yw4zEKH91eJdlgYKjNiNqKgQySTpYSAzJMVUUCkMBicH+KutNr9
	rqi213saJ/5IpjYpzVb7a35vLXWsdw2Gr7R0x3uAXNY0gIUKEOiuXnsUP6jqBNM=
X-Google-Smtp-Source: AGHT+IE+Q6PIYzDdNSoHQfMEgTJPKdEnjFwglsLO0gEt7q/0j56YXA/CnyEa9tPCeZtPIufEStcA2A==
X-Received: by 2002:a4a:bc01:0:b0:5ba:8ac1:3a29 with SMTP id 006d021491bc7-5ba9151ae64mr4996042eaf.1.1717963584573;
        Sun, 09 Jun 2024 13:06:24 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ba977e121bsm1413278eaf.28.2024.06.09.13.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 13:06:24 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: William Breathitt Gray <wbg@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Judith Mendez <jm@ti.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] counter: ti-eqep: remove counter_priv() wrapper
Date: Sun,  9 Jun 2024 15:06:16 -0500
Message-ID: <20240609-ti-eqep-cleanup-v1-2-9d67939c763a@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240609-ti-eqep-cleanup-v1-0-9d67939c763a@baylibre.com>
References: <20240609-ti-eqep-cleanup-v1-0-9d67939c763a@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

The ti_eqep_count_from_counter() function is just a wrapper around
counter_priv(). counter_priv() can be used directly, so we don't need
the wrapper function. Remove it.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/counter/ti-eqep.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/counter/ti-eqep.c b/drivers/counter/ti-eqep.c
index 30c35b6c6050..924e379303dd 100644
--- a/drivers/counter/ti-eqep.c
+++ b/drivers/counter/ti-eqep.c
@@ -86,15 +86,10 @@ struct ti_eqep_cnt {
 	struct regmap *regmap16;
 };
 
-static struct ti_eqep_cnt *ti_eqep_count_from_counter(struct counter_device *counter)
-{
-	return counter_priv(counter);
-}
-
 static int ti_eqep_count_read(struct counter_device *counter,
 			      struct counter_count *count, u64 *val)
 {
-	struct ti_eqep_cnt *priv = ti_eqep_count_from_counter(counter);
+	struct ti_eqep_cnt *priv = counter_priv(counter);
 	u32 cnt;
 
 	regmap_read(priv->regmap32, QPOSCNT, &cnt);
@@ -106,7 +101,7 @@ static int ti_eqep_count_read(struct counter_device *counter,
 static int ti_eqep_count_write(struct counter_device *counter,
 			       struct counter_count *count, u64 val)
 {
-	struct ti_eqep_cnt *priv = ti_eqep_count_from_counter(counter);
+	struct ti_eqep_cnt *priv = counter_priv(counter);
 	u32 max;
 
 	regmap_read(priv->regmap32, QPOSMAX, &max);
@@ -120,7 +115,7 @@ static int ti_eqep_function_read(struct counter_device *counter,
 				 struct counter_count *count,
 				 enum counter_function *function)
 {
-	struct ti_eqep_cnt *priv = ti_eqep_count_from_counter(counter);
+	struct ti_eqep_cnt *priv = counter_priv(counter);
 	u32 qdecctl;
 
 	regmap_read(priv->regmap16, QDECCTL, &qdecctl);
@@ -147,7 +142,7 @@ static int ti_eqep_function_write(struct counter_device *counter,
 				  struct counter_count *count,
 				  enum counter_function function)
 {
-	struct ti_eqep_cnt *priv = ti_eqep_count_from_counter(counter);
+	struct ti_eqep_cnt *priv = counter_priv(counter);
 	enum ti_eqep_count_func qsrc;
 
 	switch (function) {
@@ -177,7 +172,7 @@ static int ti_eqep_action_read(struct counter_device *counter,
 			       struct counter_synapse *synapse,
 			       enum counter_synapse_action *action)
 {
-	struct ti_eqep_cnt *priv = ti_eqep_count_from_counter(counter);
+	struct ti_eqep_cnt *priv = counter_priv(counter);
 	enum counter_function function;
 	u32 qdecctl;
 	int err;
@@ -249,7 +244,7 @@ static int ti_eqep_position_ceiling_read(struct counter_device *counter,
 					 struct counter_count *count,
 					 u64 *ceiling)
 {
-	struct ti_eqep_cnt *priv = ti_eqep_count_from_counter(counter);
+	struct ti_eqep_cnt *priv = counter_priv(counter);
 	u32 qposmax;
 
 	regmap_read(priv->regmap32, QPOSMAX, &qposmax);
@@ -263,7 +258,7 @@ static int ti_eqep_position_ceiling_write(struct counter_device *counter,
 					  struct counter_count *count,
 					  u64 ceiling)
 {
-	struct ti_eqep_cnt *priv = ti_eqep_count_from_counter(counter);
+	struct ti_eqep_cnt *priv = counter_priv(counter);
 
 	if (ceiling != (u32)ceiling)
 		return -ERANGE;
@@ -276,7 +271,7 @@ static int ti_eqep_position_ceiling_write(struct counter_device *counter,
 static int ti_eqep_position_enable_read(struct counter_device *counter,
 					struct counter_count *count, u8 *enable)
 {
-	struct ti_eqep_cnt *priv = ti_eqep_count_from_counter(counter);
+	struct ti_eqep_cnt *priv = counter_priv(counter);
 	u32 qepctl;
 
 	regmap_read(priv->regmap16, QEPCTL, &qepctl);
@@ -289,7 +284,7 @@ static int ti_eqep_position_enable_read(struct counter_device *counter,
 static int ti_eqep_position_enable_write(struct counter_device *counter,
 					 struct counter_count *count, u8 enable)
 {
-	struct ti_eqep_cnt *priv = ti_eqep_count_from_counter(counter);
+	struct ti_eqep_cnt *priv = counter_priv(counter);
 
 	regmap_write_bits(priv->regmap16, QEPCTL, QEPCTL_PHEN, enable ? -1 : 0);
 

-- 
2.45.2


