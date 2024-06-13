Return-Path: <linux-kernel+bounces-213173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98BE2906E97
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 14:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CEB3B25BE4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 12:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6527A13D635;
	Thu, 13 Jun 2024 12:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y5KZGu0e"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A888145A1B
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 12:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718280479; cv=none; b=fpffJ4eGmhq1Zo+srVpnOn3c9HjNoQ4T9xQb4Y9anr1ACq65ZUM5RCiU4fSwBov4IiPUkKy5+xmFPZLtx3ZoQJWLKYg18gRV14GqX/k8n2WFytulCb1266Xo3bk0bwoz6taXemh3Xi48aSdMN15lFHMoevLf9+r6pCC4wiHMS1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718280479; c=relaxed/simple;
	bh=ApfIUmMvEtf39ojiOQllZCMOwnzalBblmip9w0Xdo7w=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=VvBKw9kAKD9dO6klCsnkIRUu1ciQgZxyv0ol4pNufEdlUDEOXSwBWICzMsBiPyZZsCL7zL/+eIAQ4vEL+GvULNu5yAym/aD9ol+MmKAuBdjc4CIANJn6oCOyLl2P06FE4FywAmxJQEESDImOvsbG/dY0D8uu8PphWS9JVbCupAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joychakr.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y5KZGu0e; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joychakr.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dfe9ef3a637so1506179276.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 05:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718280476; x=1718885276; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oGodyiYjLAsD0yJbNMBI7MVLGuadjuXw3TChSJWxUzw=;
        b=Y5KZGu0eWU7udil0ghLJo1dz+yZJZd3vOg/d4XuoALJpL8oih1QPKMH2E0hqh34cPl
         zX2kggXpIOTjfibED34a7YAe5DETTBoU7YWyaVKXmUdloQc8t8EJ7sAs/A+FMey1a0eK
         O/50qErDCVAcUjAeOYUcyMmxlewXrHhJ/Tr8Zw6NRlXCrV+cXA5Yu5L1J2xf23e5D2V6
         AfdAAWnccsCjGD+jslmcgvHw0dVvJ5TawZoIPA2dskdB44ljcDb2TgytmRLAGoywhQ78
         9c0gnNgUYuUICaJkLRIbebXBd9vbu9AWAEUyCpTrgzzEWMbcU6oFWqDCd4lK88A7dbEG
         TD3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718280476; x=1718885276;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oGodyiYjLAsD0yJbNMBI7MVLGuadjuXw3TChSJWxUzw=;
        b=m/quFnDRLx8gaFRWw+frNQorKqz8zcK+mgrLdENczln5UFDjNGK8LCMdggrLAMJHS5
         m4zl18HjUA+EV02kieLDQhL9STWZ+ssP4l3NG2ondGBxL4EBOE4FSn2HrUcnJlE1e9/m
         taA9jivG0Tnlg5AM58jNGhz5EbUSnsOWYLPlFNNyxhpMtNxvpnGu5qw1kB2w5+v6Q25k
         0ShkA/olr5cllQT4tbfocnIeVUSqx5j300Lc8W5E5sUnyNJ/1oniJv3+xXEiKrR4RGnj
         s6jbAztDZyQt7jYGf0TUJpji+9f3WPPdEmhwgw6mSFJ8Rhnk7cy3H3l4BxM+7N3Yc9bk
         G5EA==
X-Forwarded-Encrypted: i=1; AJvYcCUwIhOXUPK8r1aNUW2EiyKZwc7ATCpaiEWdWfO4Z/K/GAk2CAswAj/keFOmI+t1ZPvN/RJ9r7gmCQxkIU0DwQTjDoNDEDJhe5FWRlc+
X-Gm-Message-State: AOJu0YxdUN9IwL3cceSNu/ilhMRS29XCl2Hr28xx2BbSpsBMy4rVUBs1
	2zcOCd9kcJ8CVQkZ6Y9OQNR37q7otPgjhN3YoflkK/h+lITAxpkBu/Y1V20URgSc4hZJeymCwgL
	QNNoY8IIUJA==
X-Google-Smtp-Source: AGHT+IHXow2FDhm75pimKLZX48hWrRy1U08wctHSj/K1NF6TSMVXN+j/Fjh1IvFkAupdAwJLYkrs5thABS5WRA==
X-Received: from joychakr.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:6ea])
 (user=joychakr job=sendgmr) by 2002:a05:6902:1001:b0:dfa:dec3:7480 with SMTP
 id 3f1490d57ef6-dfe69005926mr357042276.12.1718280476322; Thu, 13 Jun 2024
 05:07:56 -0700 (PDT)
Date: Thu, 13 Jun 2024 12:07:50 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Message-ID: <20240613120750.1455209-1-joychakr@google.com>
Subject: [PATCH v2] rtc: abx80x: Fix return value of nvmem callback on read
From: Joy Chakraborty <joychakr@google.com>
To: Sean Anderson <sean.anderson@seco.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Joy Chakraborty <joychakr@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Read callbacks registered with nvmem core expect 0 to be returned on
success and a negative value to be returned on failure.

abx80x_nvmem_xfer() on read calls i2c_smbus_read_i2c_block_data() which
returns the number of bytes read on success as per its api description,
this return value is handled as an error and returned to nvmem even on
success.

Fix to handle all possible values that would be returned by
i2c_smbus_read_i2c_block_data().

Fixes: e90ff8ede777 ("rtc: abx80x: Add nvmem support")
Cc: stable@vger.kernel.org
Signed-off-by: Joy Chakraborty <joychakr@google.com>
---
 drivers/rtc/rtc-abx80x.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
index fde2b8054c2e..1298962402ff 100644
--- a/drivers/rtc/rtc-abx80x.c
+++ b/drivers/rtc/rtc-abx80x.c
@@ -705,14 +705,18 @@ static int abx80x_nvmem_xfer(struct abx80x_priv *priv, unsigned int offset,
 		if (ret)
 			return ret;
 
-		if (write)
+		if (write) {
 			ret = i2c_smbus_write_i2c_block_data(priv->client, reg,
 							     len, val);
-		else
+			if (ret)
+				return ret;
+		} else {
 			ret = i2c_smbus_read_i2c_block_data(priv->client, reg,
 							    len, val);
-		if (ret)
-			return ret;
+			if (ret <= 0)
+				return ret ? ret : -EIO;
+			len = ret;
+		}
 
 		offset += len;
 		val += len;
-- 
2.45.2.505.gda0bf45e8d-goog


