Return-Path: <linux-kernel+bounces-201334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE3B8FBD21
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 22:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11E8928425D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 20:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6639714B949;
	Tue,  4 Jun 2024 20:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="t0dLhl+H"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC0114B071
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 20:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717532081; cv=none; b=SbOCa9S8qt7yU0yPhgubncDm/8sFaa2m6OAHLYA0mnQPXAm5JwcJ3KciTIv9VaLPIlWdsq1BSBg4NtZK9aIsp7oH0dIVzqrZy1rEHx7oHp+CpiGOlH68MpnjGLKabq56CbnKRpsHJzCEouVcoD479L1P+dQlGNc6NIh2wZSBa8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717532081; c=relaxed/simple;
	bh=U17ajrYHmKdbtsG3hqJxp6fpYyi+RunRtHPSfX9Ggrk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TWd3i4flsUZsx4qV2MjJWifRxAZHtpEIumuBKbZnlO8p/PHeBXZYMoCpytZItWYaygg82aOWfnnVXDlikxCpcaoqFYr5TPZuiHAA2M8zppioPQ4zNn4VR9RuBly5tSOMs4H5Jh1PC1sy53kzHATprYi57t7RoUHPwNx+0VFurOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=t0dLhl+H; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-578517c7ae9so1863057a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 13:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1717532078; x=1718136878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A7GVtUk4MKIiXkiZRNH9EfUE8gMvmK5/gt2D4FPc2AY=;
        b=t0dLhl+HxwJSe6+RoxjPG+FqzH9eCPa+NIXlj4TcpvlQ5B5yh32WEsgtYIxfU1/hjp
         pfS/g9xAdGDU8vm05HOmF9tz/Z3KKXpe8+46vwCmR7LiNH133P0ksIFp6pskLe/z+Nnr
         O/7+h3Y5bvZZNQ8UAvDyHjrw0G6g6rZPLI+Fo37y4fxS5pAWYb79fdHDvDkpvvQTLNZv
         2MY40O19rwojJ0JOipDvRg3z2cLVKsiCzY5El2GzxkHy7GGKWYDE0GKCxABghugZo3y6
         hToeI9nTnFgg1OFErvUYli4f1IKxjBzOAO9+LlhQ695arl5KUcNu1QaSV3TwOhuX1+gi
         /ZJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717532078; x=1718136878;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A7GVtUk4MKIiXkiZRNH9EfUE8gMvmK5/gt2D4FPc2AY=;
        b=XvIYPvcR9CvV9beGbOQ8hHn6FeCufs4SLZhnb2/hLJ3F9p0rw7HYniJjzCAM98O+DE
         63qcSZfTCBFDgGTvLxxuzO6KWV0reziMu9ikzVKMA2q/gnkOYcAA63mpTwRxG8GAvtIm
         Dbxkvwh52SkJx08uyGkrfhM4KKB4gBJjpqQhxbA/Wq+k0gC+3uJ2PwA8man1EvfTagqw
         OoYvZoCbrKb8SU6eoxWu5EVaIj1kXJxqGWrqx+5eN4fUCQL/MQ6QFbM/1ViO8O7fLs5Z
         HGSYMcOM0LufuGzc4sBIfYhlVnJoqiWGN03gEJqFPE6eYOGgPLAVrldlEM6QceQrW8z6
         SffA==
X-Forwarded-Encrypted: i=1; AJvYcCV3wiB+2lL+Xgt+A0hrjwbcWDByhe4VBGHtThk/6IcZEN48izWZ+WA9KBd2K3RklNAoZM85zhYTL6Keig04Kf47UxUgrnkGNeo/uH1P
X-Gm-Message-State: AOJu0YwI1SrfkhdDyevST+xcKSs98b4OIrjmeezbYn/un4NBpmwndjNM
	uVo9zC0skad9yoyNrwbp7MSY0WgC8wdgsoAeZBeRTppTneq7H+PmBoo5fqoktdl7C1k1b49QfvX
	bdDw=
X-Google-Smtp-Source: AGHT+IFHFfZ1S3gZMG+FikAyDnlbofzMieBA+8KbDVzQeJM7cL8PGdpd9PZxMIBJjxiYCQulgAvObw==
X-Received: by 2002:a50:d541:0:b0:57a:1c9:bf65 with SMTP id 4fb4d7f45d1cf-57a8bca02a3mr321001a12.31.1717532077500;
        Tue, 04 Jun 2024 13:14:37 -0700 (PDT)
Received: from debian.fritz.box. (aftr-82-135-80-160.dynamic.mnet-online.de. [82.135.80.160])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a5ef86458sm4703411a12.78.2024.06.04.13.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 13:14:37 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: dan.j.williams@intel.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net
Cc: linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [RESEND PATCH] raid6test: Use str_plural() to fix Coccinelle warning
Date: Tue,  4 Jun 2024 22:13:52 +0200
Message-Id: <20240604201351.257964-1-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes the following Coccinelle/coccicheck warning reported by
string_choices.cocci:

	opportunity for str_plural(err)

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 crypto/async_tx/raid6test.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/crypto/async_tx/raid6test.c b/crypto/async_tx/raid6test.c
index d3fbee1e03e5..3826ccf0b9cc 100644
--- a/crypto/async_tx/raid6test.c
+++ b/crypto/async_tx/raid6test.c
@@ -11,6 +11,7 @@
 #include <linux/mm.h>
 #include <linux/random.h>
 #include <linux/module.h>
+#include <linux/string_choices.h>
 
 #undef pr
 #define pr(fmt, args...) pr_info("raid6test: " fmt, ##args)
@@ -228,7 +229,7 @@ static int __init raid6_test(void)
 
 	pr("\n");
 	pr("complete (%d tests, %d failure%s)\n",
-	   tests, err, err == 1 ? "" : "s");
+	   tests, err, str_plural(err));
 
 	for (i = 0; i < NDISKS+3; i++)
 		put_page(data[i]);
-- 
2.39.2


