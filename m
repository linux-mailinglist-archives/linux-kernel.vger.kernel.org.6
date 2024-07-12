Return-Path: <linux-kernel+bounces-250458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3928F92F812
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 11:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48A8F1C21B8D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 09:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA5214B978;
	Fri, 12 Jul 2024 09:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Y/eOyjZT"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F5A13D51E
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 09:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720776938; cv=none; b=faBDqp6QxzDDeBlKgFhV9S1CLbAMaJO7qb39d28akJINTQH2SgfCQYgXrNyrX8hN4QVSNv1GwaWnqMZhcMkAkv2ToniTwZY8HmzeZ/oXfNC1ROY8QfkkTZ25/7yTuArO3fEUjxw1HXQ3+EOcjByfVl+ABvRCAQSQ0cnFy7JG3fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720776938; c=relaxed/simple;
	bh=kXV0109FCOzso+L559vqF0BSPt0UUb6aogVBVgHjZvk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=u2Tgi+vTONcHULeVVjQoRYIydQiHQBzntaMnJJO7w+WSe9mbQbkaOljcNN0uEWA87egPGBsuLIYvS6D7zG/SnKBGhBy73BQygsZK5QT2rJ2NFRoV3O8pJRhdgkOoF1fmbSWgXor+zhSTGJ601Reketad6d3JPynOeGPPJwLEwLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Y/eOyjZT; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a77abe5c709so230291866b.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 02:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720776933; x=1721381733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wn8z9cRdOEh+xpEHyWfRewfBG/LWm9irdSwzJQPt4vg=;
        b=Y/eOyjZThmcsdw6Hs5Fxg2/ty7n1UbXh1E9545jEWIOAYdXgug5ZpTkA8Lvg2e2h+R
         Y5HR4L8gwKUlpMapiyRxRLiGoWgDzgMN28UTRm+rxVl/KE+sxsin3Ug4WrHgxoYVliWc
         KH2TXcFTLb2bObM8sSVTcVRlR3+9w8Kml0E8XpBMmuBSYXqhFtGhpvIbNKw8wAZPjlvc
         qKqh/8UCN9nEDhs0xUj7F5LUk7J8VEpDsNtWF5tzcp8N7awPa0uNyQv5wVy/vWiXm3Fy
         8LrryUtoN94wC8G0vVT53eMB+2Sgsmj7feJn2+1zS1+7Yfi6GMGLv032xVQ4tJxOaazL
         9LaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720776933; x=1721381733;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wn8z9cRdOEh+xpEHyWfRewfBG/LWm9irdSwzJQPt4vg=;
        b=aP+DN15qIBc2FBaTJ04XHRA946UNOBYKYFlhyifIghNJVwgV7FZUxP8L53zX2RH3zm
         x68sD6lWS+ex0bMCXxYJELS5919hCq5m0GeyTh/YWDfcCspVs5AfAlNevTKw0Ls5boGu
         BAOFinBaZNU+bS+wW864ajIKCwPF8ZFSVhM/oAESE+7PgVdNbLl0nG2BLXcnnFPslZzu
         QcPvHLPIm0OiwkQytZm03T8gmAREcFXXG5GvmRSMPMBzTpL5ZkJa3KDu21k4z22x9yvx
         CGwMefHk4WzFVF3T0P106vXAAqKW0b71B2oRIDVP7Ns72yLAttoso3y9uyZxivB/gyGo
         Em0Q==
X-Forwarded-Encrypted: i=1; AJvYcCX/sE1rY1dvTRSjBVAMDGqIhTKIGFbtyiGwSL6YBWYnXEZv/nIFhgVJQ3kuc+IwmLOvpdUWFymOj/wTpPXbsiZK40jdKotUl5hj20UP
X-Gm-Message-State: AOJu0YyFQcjOUUPsuQq5Uwn5oOAOw2mYeXW1G2YFWlfGC0YD7ZLMYEMA
	xPG+xRN+19ilOmIXlvOzCDx3HOo8U7Tf4IA7ug30PFkD3LqagRw3AHLkzbyVpT0=
X-Google-Smtp-Source: AGHT+IHSQezVZTQQW1YWOTobbr+S5uTMZDEaxVRC5FiDnpQtUZO1W5xkFdreFDBnucdlNuc1el1aSg==
X-Received: by 2002:a17:906:128d:b0:a77:e2e3:354f with SMTP id a640c23a62f3a-a780b6b180dmr793845966b.23.1720776932757;
        Fri, 12 Jul 2024 02:35:32 -0700 (PDT)
Received: from localhost (p50915eb1.dip0.t-ipconnect.de. [80.145.94.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a7300a5sm330569366b.94.2024.07.12.02.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 02:35:32 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] UAPI/ioctl: Improve parameter name of ioctl request definition helpers
Date: Fri, 12 Jul 2024 11:35:23 +0200
Message-ID: <20240712093524.905556-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2732; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=kXV0109FCOzso+L559vqF0BSPt0UUb6aogVBVgHjZvk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmkPjdS6x38g4I61Cvhedr2EMZsoXcs7g4Pv0tO SONUGjNnLSJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZpD43QAKCRCPgPtYfRL+ Tvk/CAChvDEQCj5h5oxdkskTo+bNDeXrjti5iVsuEITNMn2N53JRn/kfWCAavFKe+AJPEKhy9rX brrBDiHCQ9nnDaRmA8f9p0iX0mnaDTlMs1PczrrS8YfZRMAP0QyMHXgiV/YlK/kUiSZTn/5z9v4 PFrD9Q4ogmKYm/n5aO7YwwBewnJThBjfTxs8uOijks8qLdrRQn79kqNiKnPe1IwQLnbhiLx6waY v8gW6Ep0LCrU1pyDSTIpiGaJcL5mv4wwBto8Lw8FzdA6lhGeqFsH3+FAEg9idYCME8SD6ZuIJzG QNsTpTqGcr2qXR8tGfbZaszEE2869L+MtVpCRrEbyxssqFxC
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The third parameter to _IOR et al is a type name, not a size. So the
parameter being named "size" is irritating. Rename it to "argtype"
instead to reduce confusion.

There is a very minor chance that this breaks stuff. It only hurts
however if there is a variable (or macro) in userspace that is called
"argtype" *and* it's used in the parameters of _IOR and friends. IMHO
this is negligible because usually definitions making use of these
macros are provided by kernel headers (i.e. us) or if they are
replicated in userspace code, they are replicated and so supposed to
match the kernel definitions (e.g. to make them usable by programs
without the need to update the kernel headers used to compile the
program).

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
Hello,

if there are doubts about using "argtype": Would "_argtype" be better?

Best regards
Uwe

 include/uapi/asm-generic/ioctl.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/uapi/asm-generic/ioctl.h b/include/uapi/asm-generic/ioctl.h
index a84f4db8a250..e3290a5824c9 100644
--- a/include/uapi/asm-generic/ioctl.h
+++ b/include/uapi/asm-generic/ioctl.h
@@ -82,13 +82,13 @@
  * NOTE: _IOW means userland is writing and kernel is reading. _IOR
  * means userland is reading and kernel is writing.
  */
-#define _IO(type,nr)		_IOC(_IOC_NONE,(type),(nr),0)
-#define _IOR(type,nr,size)	_IOC(_IOC_READ,(type),(nr),(_IOC_TYPECHECK(size)))
-#define _IOW(type,nr,size)	_IOC(_IOC_WRITE,(type),(nr),(_IOC_TYPECHECK(size)))
-#define _IOWR(type,nr,size)	_IOC(_IOC_READ|_IOC_WRITE,(type),(nr),(_IOC_TYPECHECK(size)))
-#define _IOR_BAD(type,nr,size)	_IOC(_IOC_READ,(type),(nr),sizeof(size))
-#define _IOW_BAD(type,nr,size)	_IOC(_IOC_WRITE,(type),(nr),sizeof(size))
-#define _IOWR_BAD(type,nr,size)	_IOC(_IOC_READ|_IOC_WRITE,(type),(nr),sizeof(size))
+#define _IO(type,nr)			_IOC(_IOC_NONE,(type),(nr),0)
+#define _IOR(type,nr,argtype)		_IOC(_IOC_READ,(type),(nr),(_IOC_TYPECHECK(argtype)))
+#define _IOW(type,nr,argtype)		_IOC(_IOC_WRITE,(type),(nr),(_IOC_TYPECHECK(argtype)))
+#define _IOWR(type,nr,argtype)		_IOC(_IOC_READ|_IOC_WRITE,(type),(nr),(_IOC_TYPECHECK(argtype)))
+#define _IOR_BAD(type,nr,argtype)	_IOC(_IOC_READ,(type),(nr),sizeof(argtype))
+#define _IOW_BAD(type,nr,argtype)	_IOC(_IOC_WRITE,(type),(nr),sizeof(argtype))
+#define _IOWR_BAD(type,nr,argtype)	_IOC(_IOC_READ|_IOC_WRITE,(type),(nr),sizeof(argtype))
 
 /* used to decode ioctl numbers.. */
 #define _IOC_DIR(nr)		(((nr) >> _IOC_DIRSHIFT) & _IOC_DIRMASK)

base-commit: 3fe121b622825ff8cc995a1e6b026181c48188db
prerequisite-patch-id: 816efa50518af0814a168f7f0ac5904b7128e5b1
-- 
2.43.0


