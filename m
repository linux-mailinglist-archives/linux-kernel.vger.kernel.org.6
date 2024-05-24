Return-Path: <linux-kernel+bounces-188958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F588CE8FB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 19:01:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD6E71F2208A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 17:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4C112E1F9;
	Fri, 24 May 2024 17:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WEp/ceBb"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CB26FC3
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 17:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716570112; cv=none; b=kiB7HnpDfr+/7nMAyNipoSjkC9rp7uMHdSo+aQstabHX+2q9fC1B7nP4fNLD0Qg0QigDtWMiSZnXx2H1zyZxpSRQyqHRMdc0k02JiBAYTWq4w3I6mSbQTY2k4FlzWF9kftIke/Hd8QI75a2VgeocbeCB1Pe9cCFjdKTgB54KjAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716570112; c=relaxed/simple;
	bh=Cf+G7MUSUrZ7+MSy0trSFBbvCcixdcWFggMfx4iRHeM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=S6iq8WWcl8YCiwOqyUiDzqlkyGjaAQdNNhOAYMAiDtzH7PylV80Jnm7jisBdmVsXmHpWe+bdmGml+PT9hdgPI+4QplhviCt25xh0Jza6HhDv5bEX/JfAbfXnQaK6hxfUCjQWDK2Vekhj3LKxaEGfBx75irthlbqNqX1m2POST/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WEp/ceBb; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1f333c7e702so23808895ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 10:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716570111; x=1717174911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b3A5Y3TABUrw3JWh7w8rkmw88AtD1mrVDTKhYMfh+dc=;
        b=WEp/ceBbi4eHjTb/hebSLoa3BsAOPhFUEp2r8/HN6VYYgEpDUazV9rr82jrTghvqaP
         6ovBUGPy1Q2kNDWrH57mSbxqdUi2PL3DDZFRSqrRSaEvJQKbsKGzL1gKQpPK3G7VA0oi
         mpzZ+jeVEwFEP4XMLKMMco8f24Fj67OkfeZ00lle97LueQTMsPxwRzPgdw70PL1PEtyX
         l/T+ZH8lo5cTT0FhMoi5VxAfGBNrkrFuhGSrFfgh0lhjlkjVvJYLgO+P/B1E91xt6Ww0
         ag2P5Kk51WI+OXfpBzJg60niu/jn61Jq4a1HTsM3bONq9FxPaBR6AtXI4JQQSssXUuSG
         QFow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716570111; x=1717174911;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b3A5Y3TABUrw3JWh7w8rkmw88AtD1mrVDTKhYMfh+dc=;
        b=myt+R94g2ih2ThMMY1i16/XJWQz8yc7tAPht0KhyAEbcD+YVn1CpwSHCWzrC6WqPgF
         JZ0VxOu4WOZKBVBoFlfEBrs37yG+7E4cfLgTYv1JxKaamNw6X7YJtQ0o8zCEaPeP51or
         WYoy+cvj+s8JZfRzZxngbk1oDHIJ4gH721QRmzRXDjGwMt8UtUklAQOJazO1D+rF9/c3
         a9rB9sXvxgwG2jJsDxdOHHjTB0JeBcd5YMWSODFiq5oTYQgwMyN0iqewiRPs7sSNDRPZ
         malJhUet6Q0mMd2uF8qBtfvXmAD0uRa1qNBJjDwFBl8i1M9L+NgA9ko/DiuMIZazq+Bd
         Y+Xg==
X-Forwarded-Encrypted: i=1; AJvYcCX2g4sHGUUc0HeYebeWFuK+GfYPFnPYbwaTkExmCVX157mhhVnuaBN7zGkrNHsJpQXWq7mhkQqSxlZEPW9Qzv+3Q9FEE01WMibczh8Y
X-Gm-Message-State: AOJu0Yyk2z37CLXcK0wdIrI3+C3I0VXNxxlQOPSjAg0hsOl9LJuEPssK
	OHGdaVWXaCXIxcVvzOdAJZqHZ1ISLopB9R/pZgJgvsnbGUNOSnUC
X-Google-Smtp-Source: AGHT+IHEHsT1zzNtRQiEvxL9vQVA1+GMmM1tGgu0886rvjafxm8Xlqj1jhjE4F2JrqMmJP4hZy0nbQ==
X-Received: by 2002:a17:902:e745:b0:1eb:54b7:2724 with SMTP id d9443c01a7336-1f44990030emr30810925ad.64.1716570110284;
        Fri, 24 May 2024 10:01:50 -0700 (PDT)
Received: from localhost.localdomain ([171.61.204.81])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c9d97ccsm15992875ad.295.2024.05.24.10.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 10:01:49 -0700 (PDT)
From: Abhishek Tamboli <abhishektamboli9@gmail.com>
To: srinivas.kandagatla@linaro.org
Cc: alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] Correct documentation for struct segdist_code
Date: Fri, 24 May 2024 22:31:42 +0530
Message-Id: <20240524170142.9633-1-abhishektamboli9@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct the documentation for struct segdist_code by
removing the incorrect reference to segdist_codes and
add a note to describe the array.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202405190241.jIzZxFB5-lkp@intel.com/

Signed-off-by: Abhishek Tamboli <abhishektamboli9@gmail.com>
---
The documentation for struct segdist_code contained an incorrect reference
to segdist_codes as a member. This patch removes that incorrect reference
and adds a note to describe the array segdist_codes[] containing all possible
Segment Distribution codes.

 drivers/slimbus/stream.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/slimbus/stream.c b/drivers/slimbus/stream.c
index 1d6b38657917..d9eaa8989d2e 100644
--- a/drivers/slimbus/stream.c
+++ b/drivers/slimbus/stream.c
@@ -18,7 +18,8 @@
  *		and the first slot of the next  consecutive Segment.
  * @segdist_code: Segment Distribution Code SD[11:0]
  * @seg_offset_mask: Segment offset mask in SD[11:0]
- * @segdist_codes: List of all possible Segmet Distribution codes.
+ *
+ * Note: segdist_codes: List of all possible Segmet Distribution codes.
  */
 static const struct segdist_code {
 	int ratem;

base-commit: f3d61438b613b87afb63118bea6fb18c50ba7a6b
prerequisite-patch-id: f30868a7fdcfaceb6bab2b6f41402a9aeae858cb
-- 
2.25.1


