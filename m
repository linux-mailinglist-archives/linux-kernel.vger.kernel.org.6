Return-Path: <linux-kernel+bounces-511572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A1DA32CDB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 18:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3888616A6AA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 17:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE83325D52D;
	Wed, 12 Feb 2025 17:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="3X12fzAR"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1630121B1BE
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 17:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739379858; cv=none; b=AJm8w0IehjguMqa4dAReSH1wQoLfL3euWj2AatYGdHCGgy0SqGyCZPUh8RZls6ASQajQDf0gmbICbyxgYIt/yjiU5o1K3kdFc/QDbz2gnmCpiaz8AhShLPUZM5qd/OAr8tccK7rYyyzPhCL2j5OK84l2YOz0t0I3330CeeomO6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739379858; c=relaxed/simple;
	bh=9oRpQ/HtPWXAz9dKVy1vzJm3BjcwllP00slMVxAEBCg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nb0remVbR8A/a6wVjsMlwnUa1qrNznlePbP0GB9iqoltkdqXmdOweQAHfsDHbNfngvHSGMZ5007dq2vkLilCChv3adz+NcrzSMgFTaB4u+zc5NnsRss7yf44I4r1Tfiumch850XWgEsjJWwJJoCyfkVkAj3LjZ1RpghXtRETewk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=3X12fzAR; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4395a06cf43so6922555e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 09:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739379852; x=1739984652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XbBh+XdWlm8snOXcjhqMlA+aMoxrnL+zgEJULN2LOx4=;
        b=3X12fzARLW2Y0uE9PqPPNoDGtv9dDxkvqv9PFVwWjqTAy+VwcsYLfdQTb2WOgupkWt
         LpvtTbR2JSZIoF0ZTF/WvG4LSSdVr86S6tA/VSsRgXuwyRilfBCWaQA1+t7xLhz+h3pj
         1IwZDBp3/y5TYXq+uhO5+rhxJxSGattlnWYWF4GIuR+N4qSpCPw9mwVhcGObxMApmDih
         iR5JQ86ru6T4bx26tTg67y9UeAr1hEeio34EjWUb9byeKzQBnNK0H8FJtDKhsJn7nofH
         1Oo00uAz1C8gymldxoiQUo+ZKs9ipa0n9JwtIgcMo5G8G1ZR+4AG06h3D+KQWiczyV8U
         OSMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739379852; x=1739984652;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XbBh+XdWlm8snOXcjhqMlA+aMoxrnL+zgEJULN2LOx4=;
        b=qpmwqBfdYo4RPY3Qd5FyduPRV32upZRiz9lVbdtzzoxnowfLbYZWsUw6z3H3KxwPLu
         BTtiRhDqF3ozzcRL9iAIzD7Mipgf4JALNGYLoT0xS4FZeZRasaFHQrnrLsLhJO9PTtRr
         nO/grYHbjPid54aMVVQUkxECBIv6c+g4diDYiteqfSlEB3FhljdaZwoWB0qPC02fLgEx
         FTMR/CMDYMyPZ8KJEfS0t9Caj6BmQ+iA/mELDMyqw7kKKvuvAP/XrzIiq4ldI3GLYyTv
         DOY4Wgw6dN8oMnM56iI8E1hZZm0Ayt6v+fsNB0W6mCUop1xS4JB/ZCFMqVKU8dcMrmso
         6a9g==
X-Gm-Message-State: AOJu0YyRhHjKqiMIajNIL50/61GeaaDt4GupaiHBd+5T80F+1V/qfBUR
	KT+QhLk5vnBw1wSLm1VKDEGqvUpDmzzL+F2jRqfpgDT2rmw8FmNIp/XFcbp4yjFRKCe1yoaBNOO
	KwIc=
X-Gm-Gg: ASbGnctXg6ytri5+zcWHHrYtvqLenmpN/8RsYhGjbrFtma9Adv/ReH/Ixio9158qaIj
	g7agM0cKnwAYtwYbUQFDoBuqguzs2n+GInp/jc6QQBUhoRKY+0kxt0B53DiYThtV3nu4QHCUO4e
	N/+Rn2ZgvOvXWryR+DKxH2XJuxR8todbv4M++OZ7LoEzzwhWiGrpHGX5FFhiqJ5MBNWmeSnjh4l
	g2buzBYFHeZ/UJNcuWuFb8ipaXHiwM+fey2BM1tvHGHiBTntZ2jwmx3l99Xy8v2NjDLkAQiZ/yL
	UC0MwNdx/3u5IpTe5ctcbjAtgpAkguyyn48JLc/qOKfq6s9ctDmfnK9t6Q==
X-Google-Smtp-Source: AGHT+IGqKiUfZhWfjXJuZTwjQwbeQCIqOI/Gan5Fraw/UuTiZ0Zem3jgLt8jnonugm+vbqnzPzdchg==
X-Received: by 2002:a05:600c:2309:b0:439:59cf:8e0a with SMTP id 5b1f17b1804b1-439601a11afmr2546355e9.24.1739379851961;
        Wed, 12 Feb 2025 09:04:11 -0800 (PST)
Received: from localhost (p200300f65f083b0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f08:3b04::1b9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a058930sm25402045e9.17.2025.02.12.09.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 09:04:11 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] mfd: lp3943: Drop #include <linux/pwm.h> from header
Date: Wed, 12 Feb 2025 18:04:03 +0100
Message-ID: <20250212170403.36619-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1006; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=9oRpQ/HtPWXAz9dKVy1vzJm3BjcwllP00slMVxAEBCg=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnrNSDROYQMGqEzchO5utQYDtZD4KeMzOThsJMA SSTLYhpzQSJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ6zUgwAKCRCPgPtYfRL+ TrMOB/9fvxniXnPdf+FNHY+qQlb4ctRszmkaTiZXhSp1nKkt1sYabrFxE5LHXBkfMvxUo/G5f86 Eqyh6AD2nu48xXxbUgLl5Izqnsvunsg9jQaTO/fwKu/ByCdj8q/3QsQYfAbjYoG1RNerLpb+JqJ sfe3UxJeh9wAe5TOblAvNgtqIhp1SwuHWRC3v//kmzzALU7QHterAf6qkxWXQgSbrjJdgt8GOab QmrvA6Ep17Pz9kGJ8rTKq994Ojf4/kKBVTa2kC2nFlh+K0RAr9I0mEpRh7V2Dil+bVy/co5klTG AcfaLJXXfTsVjRp120cVghgYSLh2FRNd/zzLtccTueAju8tJ
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The header doesn't make use of any symbols declared in <linux/pwm.h>.
There are tree files that #include <mfd/lp3943.h>. Two of them
(i.e. drivers/gpio/gpio-lp3943.c and drivers/mfd/lp3943.c) also don't
use any and the third (drivers/pwm/pwm-lp3943.c) has an explicit include
of <linux/pwm.h> itself.

So drop the unused include. The intended side effect is that
drivers/gpio/gpio-lp3943.c and drivers/mfd/lp3943.c stop importing the
"PWM" module namespace.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 include/linux/mfd/lp3943.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/mfd/lp3943.h b/include/linux/mfd/lp3943.h
index 020a339f96e8..402f01078fcc 100644
--- a/include/linux/mfd/lp3943.h
+++ b/include/linux/mfd/lp3943.h
@@ -11,7 +11,6 @@
 #define __MFD_LP3943_H__
 
 #include <linux/gpio.h>
-#include <linux/pwm.h>
 #include <linux/regmap.h>
 
 /* Registers */

base-commit: a64dcfb451e254085a7daee5fe51bf22959d52d3
-- 
2.47.1


