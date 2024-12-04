Return-Path: <linux-kernel+bounces-431446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C4C9E3D72
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 15:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18C7D2810FD
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 14:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2915E20B1F4;
	Wed,  4 Dec 2024 14:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F2kAWs3u"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173A720B803
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 14:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733324256; cv=none; b=tAOf68ZOJvdwpeAepcAaHoIJQHl4Sb9LT1SHd4HnwVATpYFdah85xQ28OlZIqHZA/qIxkvIW1vxRi2OJp/O6IXa0EUre3Sn0LtIBOMzYiMC+wa/x8q0IyLDJV9v6B85W+qeGOodzbr/yBUketEEyzFrFNs/gXsr7nhb7PDROY6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733324256; c=relaxed/simple;
	bh=yEZqPYC+h9ATloVU0XmNyzZGllbuEk61RrZf7nWTCPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZJ2kK0daLj8HeLV8aEZaLZSTW46RW03prkeYfQfrDmUbfvfTbjFR0jzujsXpit52eWAt9tHk4dEtovqLqxE0SBbN2BcrZE0RSK8a2wFbwJlpnl4W1CSQ39X9TNuCjeCMGVUcs0BMmQKKN32XLdin0nDMRJistUst4aeq9lDQ0+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F2kAWs3u; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-434a766b475so63561155e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 06:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733324253; x=1733929053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nHRk7vTqEYKo1g5eurOtqzkc5wPjmAmCwHqc6uMEKP4=;
        b=F2kAWs3ub1oRiF4pqNIUpV2HOdvVary+yRD63SuXIpDU08R1/WLCei1tSL4aX3BTwR
         9IVT301OIWzgwt+I1x4+qf+KTaGR98kkWu1bNI69ve+qZAsFtspPJmA/ro1zA1QAnBuy
         63CbS+Vw65VeUVBVdkK4VbtjXwXTdM6h4+UI2YpIWsKs96m5yiXWaEPzwYxd1RhRWKPN
         ecpsTWrR2KhfoYm2ygaASuHXdvkAqId1EvFECqr2d1Xvb2D9Se4sgMeFfRJsp8SLMJtv
         CzgUoabcNmBe9WbfPvcoIwRt+8sPY/gcBDT+ClKFGKQSwFODO7NOUkut7G8zj/oGU7xn
         K1DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733324253; x=1733929053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nHRk7vTqEYKo1g5eurOtqzkc5wPjmAmCwHqc6uMEKP4=;
        b=CZk5rabnZtkUzRtCvyro0lGuSXABA3jxXjROF3fbWp+9aOlt1qL8yJe5TA9NSeQlR2
         WWErFOg7lhWiokrBBfQjLr3yzsvaBPVPQ1ZInJczusv0SWCCHFd1dc25HfEM++Mchi+9
         Tv4nAqm6V6UztMUH5k95W5+tgdQR6f+z3D8aeyC7Rj2b5xCeA0op4dG6PmaR5kg5l4hH
         5lF4yhPqHGSr/9nrzIWxLyx2z35C1AWY4TqMVNVDLdmd1Wah4qA4WzA7mOCuad6ri5/b
         K9ti1HowBvzMHaf9OspqkrQ96MSEzG3wcRRfL2d6NSCypQlzAU0wQFpUyQAreRPiKYbA
         q5tw==
X-Forwarded-Encrypted: i=1; AJvYcCUlrjG7quyH32wh4iwKIXNfv00kdEUhXmYkiOjMLJRO78eKuCEMgS6d9eFFwIQHm2PaZeTOhwNpbL5vJig=@vger.kernel.org
X-Gm-Message-State: AOJu0YyC6TlcEFRtdSEgX4yIyf4j+ttwUSkOvNahCk4x6Kl3B9orkRB6
	hLizfyec69bf+W5wEyHMEXoEpQzm9gnuUMk/JJJV664S4VW92pGDXe99+ZPE
X-Gm-Gg: ASbGnctSHBCbOWSyT5LWGwCbWerfnkBNP/nlpn6FL5mBTI5y5m8AzDGA+P+l50nuk3n
	SOWkX1JpVuXd56OTv7Vg2L3RIuqE5Czxk+NoKecD7Po3YJ67oNn1T4/30sJ7DmtAKtp3no+5RSQ
	TWyenuGTrWyahnc4S8FcZxowR1pyYMfLbuBuQiN5aGhVGdy5Kzz7QHZ/UFd4TPp+XycQ1oX3Nuo
	aa6vwh5M+cpJdzQE7B9sS9H98cCIxhDnR8ifTRmP8hYSDqK6tM0lrFx/YDbGid6NllGnU6havR8
	Gz2kGX93Xw==
X-Google-Smtp-Source: AGHT+IEeOsXx/TryOQSdqrLK7Z3OQsWP9ayyBqEQj/Idaz4p5iJo5wT4VODFNQGlsjX7UAbq8UCDSA==
X-Received: by 2002:a05:600c:3546:b0:432:7c08:d0ff with SMTP id 5b1f17b1804b1-434d0a07f0emr51584025e9.23.1733324253374;
        Wed, 04 Dec 2024 06:57:33 -0800 (PST)
Received: from localhost.localdomain (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d527e8besm26678955e9.13.2024.12.04.06.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 06:57:32 -0800 (PST)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Dave Penkler <dpenkler@gmail.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH 1/4] staging: gpib: Remove useless include
Date: Wed,  4 Dec 2024 15:57:10 +0100
Message-ID: <20241204145713.11889-2-dpenkler@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241204145713.11889-1-dpenkler@gmail.com>
References: <20241204145713.11889-1-dpenkler@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

linux/version.h not needed.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202410102259.zcoS9Eiu-lkp@intel.com/
Signed-off-by: Dave Penkler <dpenkler@gmail.com>
---
 drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c b/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c
index 796c3a5be545..9a3271e885d2 100644
--- a/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c
+++ b/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c
@@ -10,7 +10,6 @@
 
 /* base module includes */
 
-#include <linux/version.h>
 #include <linux/module.h>
 #include <linux/sched.h>
 #include <linux/init.h>
-- 
2.47.1


