Return-Path: <linux-kernel+bounces-399782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D57F89C0424
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 12:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1284D1C220F2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 11:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73CE020ADF6;
	Thu,  7 Nov 2024 11:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S8aAASFQ"
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C81520ADC7
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 11:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730979229; cv=none; b=R8E5f4RMGJZ9JWGY7l1Kh2/A4Hl+4VpJvA/QAfInomYs5Q00yoKT58hz756bgSIcqc9aKDTAegAVThPKF70pLQgfIFxgkV4780se4pi7xPE+S3l1+Dn9MxW3lhyfuM7jx3zIFuDwHVToST4ni85I+PSsRFB7mea+yQh/9xSs5tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730979229; c=relaxed/simple;
	bh=v0nV0ozMqLgGQIsypK5wMYr1nqnINLpUTLBgBBfijKc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Smb8TgvSi8p9dXnbnTnuoqryDQgu//yAWASvKlKP7Dq3ZcTvoQPH/n/btY1qH8aeUBa5Mv9uSinp/46nAd7EQF3VIcZSRlsP0Qw2fcwfHy8AHwYBR0SrRIjslNPKMydvhO+O0GtWqd4SRFuvkfZGnq1Slr5074d7zKTcvv9d8yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S8aAASFQ; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-20c767a9c50so8761895ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 03:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730979227; x=1731584027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BzEmUMxVFejxdU/rfXTVlEUY+fR/wUBvx47lSE477/Y=;
        b=S8aAASFQ2Tp2E0b8+ZkRCUakf+Ccy1oIe192Dim4ykskDoBZ1QnYdTgt63L5pld9JH
         g/OOgNqDyILt4qCOJBpLcaTWOArzjXDLEBQPPVfOtE6nMJo4YYJKsjl7mt6ZflL0+ax/
         hNwpM3LbNkf6SDY3a1+1r71xUax3amjKHq4/YzffPfblY3BzaPXOigKv324S1ArmSHve
         TPNUx4xxFphIYZPJGFpp426LFz82SUc0RRlMuiDAEDjHGud3V6iI9juPCyouiauBhZyw
         woL1wRVEC0Awvnj593y7ZuY3vww6cPEDjC0klqWHDb48AQp+JkmqZQVYdwz9IB5Tv3O/
         LIPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730979227; x=1731584027;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BzEmUMxVFejxdU/rfXTVlEUY+fR/wUBvx47lSE477/Y=;
        b=sgm2eUxno9BRdcBBHKjTfqpbIS05KYfdFh1pRpT9O9gbSzGeT2I8GLo37E50EiaV3W
         NQRrNwYPwUBHc6fhK3K5U9kMa5sU2ov3kCsiiFipQQjH+sEFuuU07LWz9vKEXu9P0wwh
         +hvdAT8e1YhrsGfRRrckaf7m8aGwDjmP+S1UEs/Hy8EFxEwPCdYl95R0x1upqKABoB5Z
         R5W7jBO0SnVuS5voBo2dvVe1Jt46fz72OcVXiK6p013+P6mZz6FBrB+T1fyZGvzEYJRH
         cXpfL1sSq+ZGZyVqeVGH+yLhniIgskuAqwm3Ou4aDFKz4iZkZVAugYaK5+64I3YJVvli
         mOdA==
X-Forwarded-Encrypted: i=1; AJvYcCWh3T+N5eScYt285secgPIDxQsnrhaSdEN9c3EuYQRj7axhXluT61jey7gaBj+d65X1EmW2KNCbfb8OfaY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLCAV0bXq/qAh2kur1fp8kFCEddYD9pDkY5fvEvF3phYtJXRmf
	t2pk+MWDq7HGCqPoT9Ik+l6vkd+slLLy70AbeqBbxZJVA1oirXwQ
X-Google-Smtp-Source: AGHT+IHq+EF/3DgL31wNjq6ih0Ox4gUqipEMw2wqsuNioKyqFspXsDPknMqVgMaPN9uM1QnRfvNWWQ==
X-Received: by 2002:a17:902:e5c9:b0:20c:79f1:fee9 with SMTP id d9443c01a7336-2111af17177mr309869405ad.11.1730979227482;
        Thu, 07 Nov 2024 03:33:47 -0800 (PST)
Received: from tom-QiTianM540-A739.. ([106.39.42.118])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e77ad1sm9983565ad.261.2024.11.07.03.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 03:33:47 -0800 (PST)
From: Qiu-ji Chen <chenqiuji666@gmail.com>
To: dtwlin@gmail.com,
	johan@kernel.org,
	elder@kernel.org,
	gregkh@linuxfoundation.org
Cc: greybus-dev@lists.linaro.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	Qiu-ji Chen <chenqiuji666@gmail.com>
Subject: [PATCH v3] staging: greybus: uart: Fix atomicity violation in get_serial_info()
Date: Thu,  7 Nov 2024 19:33:37 +0800
Message-Id: <20241107113337.402042-1-chenqiuji666@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Our static checker found a bug where set_serial_info() uses a mutex, but 
get_serial_info() does not. Fortunately, the impact of this is relatively 
minor. It doesn't cause a crash or any other serious issues. However, if a 
race condition occurs between set_serial_info() and get_serial_info(), 
there is a chance that the data returned by get_serial_info() will be 
meaningless.

Signed-off-by: Qiu-ji Chen <chenqiuji666@gmail.com>
Fixes: 0aad5ad563c8 ("greybus/uart: switch to ->[sg]et_serial()")
---
V2:
Modified the patch description to make it more concise and easier to understand.
Changed the fix code to ensure the logic is correct.
Thanks to Johan Hovold and Dan Carpenter for helpful suggestion.
V3:
Used the correct patch prefix.
Thanks Johan Hovold, Dan Carpenter, Alex Elder and Greg KH for helpful suggestion.
---
 drivers/staging/greybus/uart.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/greybus/uart.c b/drivers/staging/greybus/uart.c
index cdf4ebb93b10..8eab94cb06fa 100644
--- a/drivers/staging/greybus/uart.c
+++ b/drivers/staging/greybus/uart.c
@@ -596,11 +596,13 @@ static int get_serial_info(struct tty_struct *tty,
 	struct gb_tty *gb_tty = tty->driver_data;
 
 	ss->line = gb_tty->minor;
+	mutex_lock(&gb_tty->port.mutex);
 	ss->close_delay = jiffies_to_msecs(gb_tty->port.close_delay) / 10;
 	ss->closing_wait =
 		gb_tty->port.closing_wait == ASYNC_CLOSING_WAIT_NONE ?
 		ASYNC_CLOSING_WAIT_NONE :
 		jiffies_to_msecs(gb_tty->port.closing_wait) / 10;
+	mutex_unlock(&gb_tty->port.mutex);
 
 	return 0;
 }
-- 
2.34.1


