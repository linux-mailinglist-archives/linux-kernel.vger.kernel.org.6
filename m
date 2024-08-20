Return-Path: <linux-kernel+bounces-293102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B5EA957AD0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 03:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAAF228351E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 01:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7472A17BB4;
	Tue, 20 Aug 2024 01:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gsKO77Eu"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C10412E71;
	Tue, 20 Aug 2024 01:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724116432; cv=none; b=jaLqrQusK/8NQdpiIHw2yQvnxtVOBRnE0EoXeIh6EC2eccPsp9POA04SI1+f+l7+cvYrqkTa9k3g3bG8dG8xiO9zE1VswMrmCvrpsYwVn1raXQ364VYXgIe8zXBvVHtbZSmRDL06SVT2k73a86ENWiWMf9+uTAkqufeu1RhRXwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724116432; c=relaxed/simple;
	bh=kaBfKsK8W3enPAV3chXtxSm4VlD6KstYlp0RGouhFCY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dRYzyaU15/LakaqjSf1fDLvAxDwZsP3EG3yBxLn16UmvtNXh1zEcZRkEl2tI5qHtIsPpOctpiroMGo7Y9EuKccSqU//t4aNOGmtAHWAJXkTvquyU2rWv1DYB3bP2IJ7PzDqiVNO8bqJgglFLi5R5K8z5LZkfTzy5oHy7oGaSeBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gsKO77Eu; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-6bce380eb96so2862032a12.0;
        Mon, 19 Aug 2024 18:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724116431; x=1724721231; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uXmktjdxKs0kqyNvIyHj9YIXp7GC7yWeIp3c/2fZgjE=;
        b=gsKO77EuxQNH89aw384KgWiZEoh6J7G241TbjNfnldBYbzQK5t2SO6hvO/UL75IyhW
         DE8w3oY1vVcSdjBRp9p4VjI8zXaVBRDutcvySTCtyu6D10DyZEg1OKoQH3/7OSjcgHuQ
         LYsmI1fK7QIJGJFqYgfwSxt5+eWBe+hXWQIOTJdB0PtBmLbFwes8wF7YeqB8WQO2Tuql
         4h60f3RVFfWGcvUERyjetj8nyXdH1lUMFOqiexX5GLBHsxbP1TlUlKCyPboYJ+nYEp+7
         n88BpkS/+P9yA+BQDQ3Z2a9v7BxfZid57ys0Ux2Jc6oR8na2EKSx+JhILaB60StmPyu0
         RSdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724116431; x=1724721231;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uXmktjdxKs0kqyNvIyHj9YIXp7GC7yWeIp3c/2fZgjE=;
        b=ln5o3yW1nlIAmmRnMvs63hDJewT3yG8C0M/Ox3aPcaetnLaOjwDXSv1BIu2OnNL6L+
         MB0Vv6rYoJE1rMSqit+EVYY09R78Fu0wnLa7I6Z2ghr7w6Oq2O/AnEujAwnFQTnG7YZe
         usOqfFSd+d6aLN2nNEJR/7oEFu5Dx+UChd1sna3GCq8l8xXIkDZMQ+C9lKRqVPjwxolS
         eBIsINSwbQZzL5dhwnaZcQj8xrw6G4Zwt0a8uNY4G9SVDSfBlgcb8ECNJNtHgSr+q0lS
         R4ubir2/EWsxAl2VIc/omever5t/XBaQ9CHBboXFEQ2KmMkX6ZuxeiXmIyauFPX7rqlW
         K99w==
X-Forwarded-Encrypted: i=1; AJvYcCX6TSGkMq4Y8HAILg34/IrTj114ktRLKqBUP7Jn2BJK+3tfRslDIAfZBUHjJfCXAXJgw1IOlL1n7ZTSRPc=@vger.kernel.org, AJvYcCXl6pziP2FMoG+TXYHoJdLz0iAqdKBde8DeoQLwuFVtjGD2mucvR7sq8UWCOkVbMOKY+JZZBeheYxaDIII=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwyC9k0PsUjuqqm6QvVqUaQWrIqi2PjsfNuqX3hrYF5Ovv6cav
	gtgSwNgQJKpgpo38coxgCWUUGYBYfeR5sErjYbKS5SH44JoqeM04
X-Google-Smtp-Source: AGHT+IH/rkSGDdxNRnPP4+AkDxOpDtHgn8E4EywUFQaKUcQB1hoKA0tTt8KdYKzZo4MdYKkRvGMwtg==
X-Received: by 2002:a05:6a20:4920:b0:1c8:ebd2:85a9 with SMTP id adf61e73a8af0-1c905052b10mr8849647637.50.1724116430273;
        Mon, 19 Aug 2024 18:13:50 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:f80c:1483:bced:7f88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127add7df5sm7162170b3a.43.2024.08.19.18.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 18:13:49 -0700 (PDT)
Date: Mon, 19 Aug 2024 18:13:47 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: tas5086: use sleeping variants of gpiod API
Message-ID: <ZsPty8oNMQk4YTl1@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The driver does not access reset GPIO in atomic contexts so it is usable
with GPIOs that may sleep during access. Switch to using
gpiod_set_value_cansleep().

Also the reset GPIO is configured as output at the time it is acquired,
there is no need to use gpiod_direction_output() when executing reset
sequence.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 sound/soc/codecs/tas5086.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/tas5086.c b/sound/soc/codecs/tas5086.c
index 4bc1fdd232bb..b97c0e885713 100644
--- a/sound/soc/codecs/tas5086.c
+++ b/sound/soc/codecs/tas5086.c
@@ -463,9 +463,9 @@ static void tas5086_reset(struct tas5086_private *priv)
 {
 	if (priv->reset) {
 		/* Reset codec - minimum assertion time is 400ns */
-		gpiod_direction_output(priv->reset, 1);
+		gpiod_set_value_cansleep(priv->reset, 1);
 		udelay(1);
-		gpiod_set_value(priv->reset, 0);
+		gpiod_set_value_cansleep(priv->reset, 0);
 
 		/* Codec needs ~15ms to wake up */
 		msleep(15);
@@ -866,9 +866,10 @@ static void tas5086_remove(struct snd_soc_component *component)
 {
 	struct tas5086_private *priv = snd_soc_component_get_drvdata(component);
 
-	if (priv->reset)
+	if (priv->reset) {
 		/* Set codec to the reset state */
-		gpiod_set_value(priv->reset, 1);
+		gpiod_set_value_cansleep(priv->reset, 1);
+	}
 
 	regulator_bulk_disable(ARRAY_SIZE(priv->supplies), priv->supplies);
 };
-- 
2.46.0.184.g6999bdac58-goog


-- 
Dmitry

