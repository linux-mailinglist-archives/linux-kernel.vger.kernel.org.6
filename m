Return-Path: <linux-kernel+bounces-188805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BCEA8CE730
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 16:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA2032815CB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 14:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41F112BF3D;
	Fri, 24 May 2024 14:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qInGtlCn"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC3586AE2
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 14:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716561409; cv=none; b=A2YdiygNJdJhblJeZQi36/qqMm3TKYMhL1KWlUQ4gZqxthrs7ayHRln2rmUHmh5DWivPSSlD5EhHvZfvsefF7h5vfVnF3lySuPEATKn/jKtWv2dYnhFOLHZc4z/Xrxy8BYHNRTc6Sbx3sc1ONj0uS6aSxfAqzbi5TTRCLCBpzwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716561409; c=relaxed/simple;
	bh=ZooK+41W0K/jFlibqaPJFgKsS9QnWZNfVY5jj0tbSZ8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=mWpN6v7SHce8GOT970u57gUTNwOtX0m5ugEVQRSgjuOkWy5kBm6HILN4RDB6gu/BdT4tFax8Dthh5C6P3NoJ5yKhrLVLByPC3JBEORvaiAPbY/ZVYoFrPFuxMhYbxRinrPZpZugwpFpFqA3aW4X8Hel3KsfetFGFmT2AJAKhRh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jwylder.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qInGtlCn; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jwylder.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-df771b5e942so544918276.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 07:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716561407; x=1717166207; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vTUqpwB46+S1HwE5N5i7HBLwsrVchHYHKhwYvBsIB4E=;
        b=qInGtlCnPNnUJWOgBjvOYbWvWKwtN6JU4UDDlZiFnRx+MuVZ1LNnXJNseOempyOGbk
         3syynN0sYgYsdu20Q6jmoU9IP+I6uIsFsxgWSo3H5481jXkZIrTOuEsODw34zxpFuRPB
         wG6jWzfTS0U87A3Ei4vL5KBXDH89XHP/IxjtGMZJOBKw6MCIgFZCab2kaNm4hU37Uxab
         Id1ZRwv0HeMbyg8o7OLqyKfUKGtEjCuJVWcs3I7QTS1Cq81Q3Nn5RksX0JM8oqBR/4oO
         H6I+O02G8qOvmd5ejKn1ejVtYrSa25qwv8TjkSYVWlQAr9WelBTHBfzgMvY7Mg55iF/+
         Y+SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716561407; x=1717166207;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vTUqpwB46+S1HwE5N5i7HBLwsrVchHYHKhwYvBsIB4E=;
        b=shVuSwasxv9U36s1FqUuE1pfDcjdPNyP0I45Z5d65dcfw86Z5GixBDmCoHyHWeu6+j
         HP47CEI+pMtpTCZDkYz47GhHNEzQg3F0KLueK5YypdSpWAfV51rFFIzwIH6jozV9Ogzd
         XHygrDmgmqg8u7zNBNA/JyI/yIR08wf1Dq5ROKp4i8xETyv46sC8kMbxad0eUyJtGWxg
         O4broo/4ukEZIWk7X6fiKDUmIcWTLgRWblvI9O8/s3I1u/i5mbSy+PvE+lqmsKcYk8CA
         zXvFkdhMJ94iE4e8sh29o/RPmCYNXwUG/2P8xzZwm6Tex4o9OJXqai/bU/+y5O3nHIU+
         pzDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxqpIzTRPwD/HtCorOvW1ub7da0YMnxBVylfqMEfT2dkPGLdiIi7Xo3trKtMw/0fhYc9sy4SCeqlp5VaTL6GENzMA9vyt29FFhyFq1
X-Gm-Message-State: AOJu0YxQ2xNm7p/+iM0LKv3tNVuLuiSos7hD1Is7cjEANg573vAikw0g
	i/TeYiueoiN8MoGyMKpbyN6/2Cckk/mpjaN9BLCYzNItC48zdAVHQeW6l08MLYbLoUqyZmOoD5l
	U58gBlA==
X-Google-Smtp-Source: AGHT+IFjGNWYoNC1kzH8fASakEvejNew5BRAJf3D17B9rWIT+a0/4BGcz+BWw61esh3JBn4vDo5lTiMnRqNt
X-Received: from tetrad.chi.corp.google.com ([2620:15c:2:a:76b0:ffd9:14f8:518c])
 (user=jwylder job=sendgmr) by 2002:a05:6902:10c1:b0:df7:6f84:f377 with SMTP
 id 3f1490d57ef6-df77204ce31mr164400276.0.1716561406892; Fri, 24 May 2024
 07:36:46 -0700 (PDT)
Date: Fri, 24 May 2024 09:36:36 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240524143638.3057944-1-jwylder@google.com>
Subject: [PATCH v3] regmap-i2c: Subtract reg size from max_write
From: Jim Wylder <jwylder@google.com>
To: Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>
Cc: Jim Wylder <jwylder@google.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Currently, when an adapter defines a max_write_len quirk,
the data will be chunked into data sizes equal to the
max_write_len quirk value.  But the payload will be increased by
the size of the register address before transmission.  The
resulting value always ends up larger than the limit set
by the quirk.

Avoid this error by setting regmap's max_write to the quirk's
max_write_len minus the number of bytes for the register and
padding.  This allows the chunking to work correctly for this
limited case without impacting other use-cases.

Signed-off-by: Jim Wylder <jwylder@google.com>
---
V1 -> V2: Also subtract padding in addition to register bytes
V2 -> V3: Added version change descriptions

 drivers/base/regmap/regmap-i2c.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regmap-i2c.c b/drivers/base/regmap/regmap-i2c.c
index 3ec611dc0c09..a905e955bbfc 100644
--- a/drivers/base/regmap/regmap-i2c.c
+++ b/drivers/base/regmap/regmap-i2c.c
@@ -350,7 +350,8 @@ static const struct regmap_bus *regmap_get_i2c_bus(struct i2c_client *i2c,
 
 		if (quirks->max_write_len &&
 		    (bus->max_raw_write == 0 || bus->max_raw_write > quirks->max_write_len))
-			max_write = quirks->max_write_len;
+			max_write = quirks->max_write_len -
+				(config->reg_bits + config->pad_bits) / BITS_PER_BYTE;
 
 		if (max_read || max_write) {
 			ret_bus = kmemdup(bus, sizeof(*bus), GFP_KERNEL);
-- 
2.45.1.288.g0e0cd299f1-goog


