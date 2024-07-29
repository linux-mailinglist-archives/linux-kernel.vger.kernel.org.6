Return-Path: <linux-kernel+bounces-266418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E606693FFA6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 22:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A74202838B1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 20:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D516E18C325;
	Mon, 29 Jul 2024 20:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aveEfELR"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BB215B98D
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 20:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722285660; cv=none; b=RS5N7BNmsu+Qn0fRFTGUl/aF9vsmCOKv82Jn7LBjvJhirz2m38PNkci7KEy6lFUmuDTxF9wLlL96h0Lq3BrGgLdf39UZBTumw8BN+7DIpIK6U3R7jAgGSqevxF3EmIrDLhnlpiP52JVcT0hh1t521RWIxZ/B8ma/Mzea4RF5lXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722285660; c=relaxed/simple;
	bh=JDPEiWSJjysWusTQvGLI5kdhss1TZceatUOZLyfukGw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=sQxGVmPiYnRQj2P/m+iLKS3SFEo/bFaYlCu9YgZOWeQ88oPNv9X9Mpk205DnzzAyG51yVMPNqIAzahY6+S1Uwp5SNactl+ohVFNPbNBLgeo2Gn8YQzE9uZ2pRS08Es3xKG/LwsL3W/MSS1HnRulQo/6H9akVmb/aZL0IG+DM1rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--zenghuchen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aveEfELR; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--zenghuchen.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e0b329ba782so5098118276.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 13:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722285658; x=1722890458; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=n7ZbQjS7fYcpPV8CeoeZ/SVTCnctOwY25lHwhKuyOmE=;
        b=aveEfELRynQDeu6m8lfJxC6PffSi4c+Vhkq+X7jVBgjQE0aDy1c7VcyQpsUNY/EyxF
         BaBkhKp2aKsDAleAZ46Byo9Ndf93Ibvxj+UNXoPe0ylGelBb3vjLuzE2QJwuUDeN3SXm
         wYAHlA841E8nuGqxJDfWQM42fhec94XxdWkKc2Zlod1BBH8Eg9rlqQC8uPKdZg6w6bpf
         FjJUqxWhpSUjmE/Q20Sllq/+hIzYH+XHAKDD045ryFkrANFkSBB6MoxABldNFUeZTHXi
         ov0kTWTJLkVx2nyx/Svfa5SOC9zickePGuoMNY7G/xJLRf3TUMpepZ15l+w+QQ3SsXCM
         IOFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722285658; x=1722890458;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n7ZbQjS7fYcpPV8CeoeZ/SVTCnctOwY25lHwhKuyOmE=;
        b=bxJysgrLEIoaiob6pfHPb0drMR9V2O9g6tI2jmP2xDfRarVeywKGUYf3ksUNLqx6PK
         Ivf89BuA8P2IoEcKjqyOFkv1BU0c6V4r5OySyKxvpbKh0LnujU63XFQ9+U2p/ywIjLUO
         US7Tne5NXTHGzNj2So8uHS9b/39WMcTSTmUYzA5k1a2WmDuvOAgE41vJk0q4/3WpQ4N1
         7sXi1h4+xsfVbQMkoxQt00g91ZQUHyAenadHe2kjqRRGLwkMVknyU8ptTcLPaFqVWCW7
         M3cnOX1kHYae9nBwpL0xmDud4OXyXxU3Wj9XzpSxGTZeXA88T1MJW6ywAm/Tr85N23mB
         KnQQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8mENZxMvJ/hy14VukVV1VEOXovyqayV7U4KepF8h832s9S8uBpjAa6UONJhZm1SBZxyJDkyihD821JSnZEgvmSvt/bBwhDeMAF0kp
X-Gm-Message-State: AOJu0Yx6od4TRlRXQe/Zax9lEzQLrW7SgDokx4XQ/xSGSwgY32k26wQa
	SgimXWm0TwTmTQBtL2P51oe9cVz1ot0JLxyI0KEau5Vr2tmXT7l7KcmTIaS/BdgTiV8zWPTkkxQ
	BVA16hxegYkA7Pou5kg==
X-Google-Smtp-Source: AGHT+IF42e6dPo93pFDAH6b7KWc5DCBD36rR4/DxpqnZk4t1+1z42eObI3nYz2JdBz4NjrRNYjjHK3hIHceT3N/F
X-Received: from zenghuchen.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:2448])
 (user=zenghuchen job=sendgmr) by 2002:a05:6902:2b0d:b0:e05:fb86:1909 with
 SMTP id 3f1490d57ef6-e0b5445e804mr861185276.6.1722285657746; Mon, 29 Jul 2024
 13:40:57 -0700 (PDT)
Date: Mon, 29 Jul 2024 16:40:54 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
Message-ID: <20240729204054.2269031-1-zenghuchen@google.com>
Subject: [PATCH] leds: lm3601x: reset led controller during init
From: Jack Chen <zenghuchen@google.com>
To: Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Vadim Pasternak <vadimp@nvidia.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Jack Chen <zenghuchen@google.com>, 
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

LED controller should be reset during initialization to avoid abnormal
behaviors. For example, when power to SoC is recycled but power to LED
controller is not, LED controller should not presume to be in original
state.

Signed-off-by: Jack Chen <zenghuchen@google.com>
---
 drivers/leds/flash/leds-lm3601x.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/leds/flash/leds-lm3601x.c b/drivers/leds/flash/leds-lm3601x.c
index 7e93c447fec5..978256310540 100644
--- a/drivers/leds/flash/leds-lm3601x.c
+++ b/drivers/leds/flash/leds-lm3601x.c
@@ -434,6 +434,10 @@ static int lm3601x_probe(struct i2c_client *client)
 		return ret;
 	}
 
+	ret = regmap_write(led->regmap, LM3601X_DEV_ID_REG, LM3601X_SW_RESET);
+	if (ret)
+		dev_warn(&client->dev, "led controller is failed to reset\n");
+
 	mutex_init(&led->lock);
 
 	return lm3601x_register_leds(led, fwnode);
-- 
2.46.0.rc1.232.g9752f9e123-goog


