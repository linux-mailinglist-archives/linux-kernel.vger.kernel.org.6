Return-Path: <linux-kernel+bounces-535095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F9FA46EC3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 23:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EDD616DD34
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 22:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D574625E831;
	Wed, 26 Feb 2025 22:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F2m998LV"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B227D25E81A;
	Wed, 26 Feb 2025 22:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740610212; cv=none; b=A03o8hznUTtn7+bDoAf5WS1HT5c6LU9sPUf/rPHmJSGjRBX6WIwDnsjpQVeePEOK35BYyVEAB+BVJsEFBglbH1Gh/LgkHBf/u6jcp30wd7yO6Kf9pM959mDjusuRihRZ72Gp5yqpmEAPTBOwxa1opQIu2FYMuEgE6bFsOlKrVcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740610212; c=relaxed/simple;
	bh=5mApkXKPUUu8fT/pMotJnNKInAuHFBHG31AVjsDfbhI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=e5p+MPSQSsUtqljdYZ7qxpuYJOi7CO5FMB1Q3j8ZLcdFpVcdQjf4vbupXNrd+uFnQmGiy9YfGhJLrSY1rNKcvCNGGKGfW9zesgbIttTUTeaGZAd3jpBM6fSIECIjIiGwn+zBL+6mWB3v8K2ZnoTPaTbpeaHdZIvjV5Q9eq8zH1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F2m998LV; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-38f1e8efe82so372558f8f.0;
        Wed, 26 Feb 2025 14:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740610209; x=1741215009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z9Z5E8n6kLDfAj5O59rt6w34+w06lR7Z40O7p+qUX1k=;
        b=F2m998LVGqechT8mmrTqBq2gI1DoLKqY5fyzeoPHXiyk6aTQLc832MUvEn0ebJp4hC
         XC3j44IFIDVeKoX2XYy7ActQ1JK8nEbPDZcbMDGH3On52MW2pqs5BG42s3Qq5eA03rn7
         jQKcQst+eL3LY4Yk72tQwGqgWBquhN6FaUx/H7CKrI0ASCZrsD0bOkQP/dXpReFFENMm
         lI89jUclbL0qhxTdiXgATsY3rEM+9yC74w3VkKyJdKLuyz7EyJjxmIJbZoDl3sGr1ARI
         7JIeOL3kbhTyuFmBFevBtm0MU1ExPmMJ4MOJehE3k9wItV3a2ZHJW+J02OO41rVRYRrr
         OB+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740610209; x=1741215009;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z9Z5E8n6kLDfAj5O59rt6w34+w06lR7Z40O7p+qUX1k=;
        b=TE3TDcS7AcGeF1OZ5ddaIDhiffuDGwtDguRefojjlqR4Zf5TaioFy3utgAwHD5jenh
         GhhesSx1J+YRC393/xYJjfK0nBOwgifB1XWKUJJ+/PV2n7FV4q3fmTPYGz0+UAH10Fss
         rRop7K1+60U22P+kdyo5OW7Ds7yGAHXzD03pxwngd4ij/ZdI5baAFt6NBbH/c0udzsgU
         ns1y0pUFXTDe/OkuGMRHSsVpuj26/x6t4gMnXxWd2/Lwomx/HFmVy7zxD1LZagJtqKzq
         nhU+AcZUaAB276Y5BOZp5xAp5tbFvKHXXV2BNFBqc6vh3KOu+3g0bqXw3RdnmHJvNVAV
         8voQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4BylAY0fcmhPEiSCKQtams+/nO2M9quQZUWFUyZI5FMn7IxqkG0nbDeHcJ1vnxJmYvBO38NKjweCCAHI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLOfa5yT3WQdracViGaJQ0r/GJRYQdGohfTDsRMk+hx4Cmt39c
	9RPtiklMFJIG/6EW5K1xBj4kp8z7kgFlbxndS3ZbMAssu+qXRuGV
X-Gm-Gg: ASbGncu3s7cyDdz0ayo/9W3V2oSahM5tJWrxMXnN1CVlLVUO6oSUm0iXlyJHJgjwJ0H
	ht3/enDGqlkWR+4x3Qc6vbvefskTXrHs1f12pVsQQLgsmDvC3FYQbETyXqWsm20LbfOLlks0Aff
	zzwQsOdCMVOq7ZFM7rEPmZUBnAJjr6t4IHb+8d7CAFrheyZxsho12MIcRy+HwV5epGfGUljCfSQ
	ED5ly8NwrWdSk9HmxPqImB7g8A6/M05b47s6O4vi7HZ1cRBSvTCjrCQwHLGxwDygR1CrRK7m57W
	UTJTXyvGKLpwtlv2GeyPNB7yu88=
X-Google-Smtp-Source: AGHT+IHUlRphW0Ca1hhAt05nEWcSc8d+QNTGkOv7KeyGs/4Z3TKCVfkbqoJTXatO3WkXA5tUI1slzA==
X-Received: by 2002:a05:6000:154b:b0:38d:d666:5457 with SMTP id ffacd0b85a97d-390cc631b04mr9011648f8f.42.1740610208846;
        Wed, 26 Feb 2025 14:50:08 -0800 (PST)
Received: from localhost ([194.120.133.72])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43aba52b7ecsm35242335e9.3.2025.02.26.14.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 14:50:08 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Catalin Marinas <catalin.marinas@arm.com>
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] scripts/sorttable: Fix resource leak on file pointer fp
Date: Wed, 26 Feb 2025 22:49:34 +0000
Message-ID: <20250226224934.594983-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a resource leak on fp on an error return path in function
parse_symbols that causes a resource leak. Fix this by adding in
the missing fclose.

Fixes: ef378c3b8233 ("scripts/sorttable: Zero out weak functions in mcount_loc table")
Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 scripts/sorttable.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/scripts/sorttable.c b/scripts/sorttable.c
index 7b4b3714b1af..e35abf28d037 100644
--- a/scripts/sorttable.c
+++ b/scripts/sorttable.c
@@ -665,8 +665,10 @@ static int parse_symbols(const char *fname)
 
 		addr = strtoull(addr_str, NULL, 16);
 		size = strtoull(size_str, NULL, 16);
-		if (add_field(addr, size) < 0)
+		if (add_field(addr, size) < 0) {
+			fclose(fp);
 			return -1;
+		}
 	}
 	fclose(fp);
 
-- 
2.47.2


