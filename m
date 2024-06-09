Return-Path: <linux-kernel+bounces-207380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC44901652
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 16:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C59DF1C20A0E
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 14:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1A143AC4;
	Sun,  9 Jun 2024 14:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U8h/UQNi"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793911CD3C
	for <linux-kernel@vger.kernel.org>; Sun,  9 Jun 2024 14:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717942651; cv=none; b=T1hp0k5zOwGYcKTUOr16/B1hyIYuDvPsyhd/yeBIBjA6fLyOXQsLP5wExzZsxWcmmiW1Yy5Tur2MEFhgkKcWsF7EKYzCdHnJaO+GaosUqP+MKyUCcJSFyu2TttRjqqOv3wS9+su18MH/6FPijOprp5gIo4kikfkzqYIM/1zFBUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717942651; c=relaxed/simple;
	bh=NJDToOELLavN79YkpNHBhxfCYr8Bzt9pRlexqHPJ7XY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=miSyvtft1KBK2xEmpVLaLYFVWGMPsbpgka7ZjAp9Cl+EP2e6lIXr84XH3GP4IfeGuGwkUNVfPzKSQGdKBgyOFBxbTFOCcBBP4M2JgedsumYdCMLC+T4Q6/nq9o6/l34cNN6anj2ev+T1BpzOvcRDbk1tymDgIctypmHHcchO5Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U8h/UQNi; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7041f4553ccso1443953b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2024 07:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717942650; x=1718547450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TutpqlrSfL/EF9pT63bvOTQrpOoXNL5CWPlMZU8S7qU=;
        b=U8h/UQNiwli2/fRnA5A3ZYhGwmJVO9zJuvs6ki5Zg5nsai4GuLsaIXjapUFaJi/g90
         9t0s245GqtUaR2+U+P8Tt9WgH2TKZPtEJd/1FbnWjCey7C69f+mRDtVUn5qNIX7u8eHF
         8oWswBY+ue7q0Q3yPWHo5e72zlKQI3fG1P8rgTPXFjnHCnfaguXuJag+RYec+FAzPO6B
         dW8S3RS6eoKoIGBPP+UmNwvIBLOEHDsac1+G33IcJLLlY6LYibypWdR7HgORoIlQPV5u
         tEXN431I7J1ld3Ip7ibN5mv7/wsLp2tYM2mjVoTtXyc4FvNUAb38Y5hvQfTD3tBG+3Od
         2/IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717942650; x=1718547450;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TutpqlrSfL/EF9pT63bvOTQrpOoXNL5CWPlMZU8S7qU=;
        b=JGuE8/bTnVJ/Y1eSnsHSRKufCToqX3aH6+1l8TRiYC7YRYdhoT3npOXdtX0RdOdUb3
         /9v6ZQQlhREcCnntzkI5qnK/Vm2PIxuY1WWFtEwdYpEV1IZLfWGdkI9M82Rz5LrObxWN
         FYjIgi2XWuuZbUV1Ig9cECn92uH7jmE6uNhUcFqXT7iIFWJehugmQZqYti3ntlD7yMrt
         4V74PJx8XR6Fu0kOZbBTQIC0pw+i7gYSW98ijsqwEqo1L8SPIAAcD9evLUqUs0N/y3ZX
         i8Sivj9dlEUpQ6sG1dUwPsdUzIvKZaI5ZRXX5sTyHcSpYBxXNn6vnKLiEbQc9YZQI9A3
         VNPw==
X-Forwarded-Encrypted: i=1; AJvYcCVsYNKp+h2kfHRR+hZTJf90WprVZCR84AvgQ8NTh1Xls3d9wnGeAQgyYKdbfZeiTSb1YCjdUHiYVBwLM6GV1ypXIrGkL/ZLMIdBs2vE
X-Gm-Message-State: AOJu0YzBGua9N7FnYj1uLQ43rleVZy1YeqBVVgybBPZ4ZX5/oHNB7dcj
	mfiQR2loJ25DTaafpZ354lbCRYhTdii/zQwgsL82JpfmnlUozeqd
X-Google-Smtp-Source: AGHT+IFTYQkeJxZrMdLUEDOMYJfJADY46i3otPb5Xg6VepNEXgcNkbZzzwYqyTOBwy5rjnS0JFuV0Q==
X-Received: by 2002:a05:6a20:7490:b0:1b5:97da:dfde with SMTP id adf61e73a8af0-1b597dae2ccmr3868311637.43.1717942649827;
        Sun, 09 Jun 2024 07:17:29 -0700 (PDT)
Received: from dev0.. ([49.43.162.161])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7041ffa7cfasm2767555b3a.112.2024.06.09.07.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 07:17:29 -0700 (PDT)
From: Abhinav Jain <jain.abhinav177@gmail.com>
To: agk@redhat.com,
	snitzer@kernel.org,
	mpatocka@redhat.com,
	dm-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: skhan@linuxfoundation.org,
	javier.carrasco.cruz@gmail.com,
	jain.abhinav177@gmail.com
Subject: [PATCH] dm: Add support for escaped characters in str_field_delimit()
Date: Sun,  9 Jun 2024 14:17:21 +0000
Message-Id: <20240609141721.52344-1-jain.abhinav177@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new variable for escaped characters.

If an escaped character (\) is found before the separator, and if the 
separator is not found or if the escaped character is located before the
separator, then move the separator ahead and continue searching for the
next separator.

Return the pointer to remainder string after the delimiter. If the
separator was found, return a pointer to the character immediately after
the delimiter (s + 1). If the separator was not found, return NULL.

Signed-off-by: Abhinav Jain <jain.abhinav177@gmail.com>
---
 drivers/md/dm-init.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/md/dm-init.c b/drivers/md/dm-init.c
index 2a71bcdba92d..bef6a582a4ae 100644
--- a/drivers/md/dm-init.c
+++ b/drivers/md/dm-init.c
@@ -87,11 +87,21 @@ static void __init dm_setup_cleanup(struct list_head *devices)
  */
 static char __init *str_field_delimit(char **str, char separator)
 {
-	char *s;
+	char *s, *escaped;
 
-	/* TODO: add support for escaped characters */
 	*str = skip_spaces(*str);
 	s = strchr(*str, separator);
+
+	/* Check for escaped character */
+	escaped = strchr(*str, '\\');
+	if (escaped && (s == NULL || escaped < s)) {
+		/*
+		 * If escaped character comes before the separator, move
+		 * the separator ahead & continue searching for next one.
+		 */
+		s = strchr(escaped + 1, separator);
+	}
+
 	/* Delimit the field and remove trailing spaces */
 	if (s)
 		*s = '\0';
-- 
2.34.1


