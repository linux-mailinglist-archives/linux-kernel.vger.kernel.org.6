Return-Path: <linux-kernel+bounces-297646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9429195BBF3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 18:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 262402845AA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 16:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C231CDA10;
	Thu, 22 Aug 2024 16:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="noGm8HO8"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD2B1CCEEE;
	Thu, 22 Aug 2024 16:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724344257; cv=none; b=qXxjtXWJeOsoS2gCaWzprkwgH6UIuDEmUjyT8xwQVs9TJsF35Zc4TfCKUowFq72p53QFUoiqntybf32O7K7PRquUSUW46W+bXD4dvfc7np7A+CzA5dN5LS/uuD8xaZINcexMM+1bdFi09EE+rvdUOPhV+5Xttt6m8oAuviJbHKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724344257; c=relaxed/simple;
	bh=QEJC1cALUBumf2HHqM+GA6290lil4w8v+hebHvuw2Gk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ouD13fUwaE1OfXprWI5v5fqG+d+97jq55c7Y4hdkcZWMmGw0nB7y6hu6YQIGbSxHdEkQKywfjjutjDxYpBX1hRUGw1Z8EEKxg/53e+JfEa91GvCbJwIdLcIwmOehWg6HbyA/Y47JrKnAq/TGb/tI4Y/0SaK1javpJ+39buCgnhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=noGm8HO8; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a7abe5aa9d5so137350466b.1;
        Thu, 22 Aug 2024 09:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724344254; x=1724949054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TsKvdf4ZDhQDrXDhRuDXeaPOzfYKZbxyCrGrQmwONKg=;
        b=noGm8HO8WyVTB9o7naSh4qvnAWvnK4sySzzin295bkVbkuC+d1P2BYMjiazYFmsq7i
         ue32OiW+D2d+HLRAf6sQivbI4QaSLM+6vpWRxQCIVYlR+0gOOJy0Wi4jev2RsD3Hz8xe
         aAlP/0V9Ca+wxd8MixC3ZtBPWpLY73izUqvgE7RUmWSyRAUnet9dCzG/7ZcEhq/2827o
         PhPiS/sj/IYRqNKNRW3fkAJCKaeFCkSGX7mQDwuLD9vVrehrhpqV2xwEbszpVmlL6tGJ
         7VCtF05RXLedazbftTiv4n+0KizQe3gLYBBseCuAqR9gqGj8Fnn6/2nNpTI3G5wR+3ow
         GAzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724344254; x=1724949054;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TsKvdf4ZDhQDrXDhRuDXeaPOzfYKZbxyCrGrQmwONKg=;
        b=Gxhg21frdWaAEEw5L2U/kLgnIdSd0+Mw7IIx/yijta7J8Z9i4bRLPSCGDbDuBoUwWd
         5c7XrUKnYFcjn5faY1LbHlSAe/2Cc4MSXxtqtoszB9EXYZE0XnTiRy87Mi6Kok85UFPp
         0PrCkX35HbzxqLv0ZHUnpgViIAAtQzDdHxACds9bXjSFniAFgSjQeeBFclAyj8FQVgw9
         s8ME3ksujAIZHg5NOjf2hdoOZYOL8RpV0//2+who12VskdC4O1r9Z7ykN74mJUO+RXCN
         lvOJgMeD+SV/+PgC6KMPFixf3cvrXy7dEAnv8/5cpmpw8UqB4ihaN4uiJLngMMMWBMZd
         TQlg==
X-Forwarded-Encrypted: i=1; AJvYcCWXyLlYK1GzkLFJDb4/bpyG2h0OmNRa6Gw0XI+cVkJw26nBdC+ujcEfQ3fPBXitgO1mKYbNLziPZyQRmh0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjGZ75cmPyeBKNj/YAA5oJZPKAXMxdPZHcBEQ4b+vPhtsVmY0v
	TTnWaa2QCP5eZu+Lq0Er+GVkvf2pz7i+nBxwWMdwg3YhiraHGr8G9rUvNg==
X-Google-Smtp-Source: AGHT+IFMyjGwQ0XSfu2JIunz6P7wZCodLI1co4GLN1jnPM7W+XkkMMw1Tg2ij2Gp7LBe+6eTUZwuUg==
X-Received: by 2002:a17:907:1b1d:b0:a7d:a00a:a9fe with SMTP id a640c23a62f3a-a8691aec2e5mr239885566b.17.1724344253517;
        Thu, 22 Aug 2024 09:30:53 -0700 (PDT)
Received: from localhost (craw-09-b2-v4wan-169726-cust2117.vm24.cable.virginm.net. [92.238.24.70])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f436bb8sm140073966b.131.2024.08.22.09.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 09:30:53 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Meir Elisha <meir6264@gmail.com>,
	linux-staging@lists.linux.dev
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: make read-only array dot11_rate_table static const
Date: Thu, 22 Aug 2024 17:30:52 +0100
Message-Id: <20240822163052.636570-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Don't populate the read-only array dot11_rate_table on the stack at
run time, instead make it static const.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ieee80211.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
index b89e88d6a82d..0cc5142a90e0 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ieee80211.c
@@ -55,7 +55,9 @@ static u8 WIFI_OFDMRATES[] = {
 
 int rtw_get_bit_value_from_ieee_value(u8 val)
 {
-	unsigned char dot11_rate_table[] = {2, 4, 11, 22, 12, 18, 24, 36, 48, 72, 96, 108, 0}; /*  last element must be zero!! */
+	static const unsigned char dot11_rate_table[] = {
+		2, 4, 11, 22, 12, 18, 24, 36, 48, 72, 96, 108, 0
+	}; /*  last element must be zero!! */
 	int i = 0;
 
 	while (dot11_rate_table[i] != 0) {
-- 
2.39.2


