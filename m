Return-Path: <linux-kernel+bounces-337189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 201199846A6
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 15:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D69A7284B01
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 13:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4ED01A7261;
	Tue, 24 Sep 2024 13:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cNQclWBy"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4681A706F
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 13:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727184068; cv=none; b=Vt/33Huk5rbXZlCUZW4iWlTj/srapgQKB8Rjac9Z76AanuWwtbtvhFdFoBAjh3SeoXK93b0NLUSvPTu/m2ewqeGEcziEb/L460s3Zm0akKqPW9vA4kOIo5NLplmZsj1ydPmTEJK8fXAMQ+9uY5U+HrARd50gtsGtLtuiQnTLBgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727184068; c=relaxed/simple;
	bh=fpzyu68RGtD1Helde8RRnH9eX5OdhQx0n7YcUkSo4dI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d2y2toe9GzVoEjQs5MDcyIUdwQjHo0LHgz79FLgFcraZiIL82CSDrsqfxh631Y+L/5RvJMDJM2z73mbYbNlVjcsSo700083+h1/K51d81Fvwt9zR4GDHdp3cKT2LOMbecLsJOMqypNBXrYdkQcIGhmEpT8VENJ92iqDZmoRdS0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cNQclWBy; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-53659867cbdso7940221e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 06:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727184064; x=1727788864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HGiHdBTqLysw0OjzmqeOkmIi8HPVvmwCEfeNLRDsfSY=;
        b=cNQclWByUVuqjr4nMuWmbYvYlfkISl7kF9HxJ+4uz1Y5gg84si3yLObpseOd7tWM5h
         G2+2PwMPfHKLOcJI5QVA5HiZp7w0e3sBqhY/UvDmwttJ7PTaD818MPQ+2CBmIRgZZFMR
         DVssh64nMbdN8mizc8ZhJ3twWbyaxKlJy7Z3hxQmPstWN9Hlw21iOnp4A9OiVOrXwEjP
         bCj89PpG4NK3atufSJ9XQBBvQhVKtIfTz0HSI7znFFJHnvoVPZPPcTIj7Kb3QK9HX0B7
         IetFDaeTL4wAQ26//t5IodD9o88plJ9D0rgy9WFYS/wD9xEiyczOMyAg4FzOCGtMyomF
         xprg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727184064; x=1727788864;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HGiHdBTqLysw0OjzmqeOkmIi8HPVvmwCEfeNLRDsfSY=;
        b=Xn6kZ902+2ZnmeywmTrOSQeT7n9rvqs5PvkK8W14xfOQYOCSWfjm9It4AsU5QWGn4E
         64M5ro/f/QO5OonEI7hr/WlvJ3cnAIDeRLDLKoopgnHtPYXd3jk4njPD1DZ9rPQLC4wC
         Bom4BTHN5WYLyFs0DkAkQVw99AURsVTMO3Un+71FndYybY6uJshzM71jJ22Xg9Vyg2d0
         H7kaulReHt9m8UVAcHtWsaQVuH7TT2xuTPUgcj+91wFk2RzT/WNuiuoGC0mznD98hE2Y
         dWMPt8nPSiXmlgTXwNKzl8xLfBcNeAAhPw4zv0j9lehL4O8ZQIjwMyFUWIXHruw5Rro0
         faow==
X-Forwarded-Encrypted: i=1; AJvYcCUugml1mMLOPsbr2hAgaBeWwhl1MjGpSO/FFJbv7m8QGrGISlsYfARMnc784hE5LHKW8u9AZ4XG2DGIlqk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeDQDQ5V9B9iXa9Lm3woA/fu/cSBVANv8PSsXNLwedVR3UPoXe
	imiKRmM5jUFAaYdyAr06rEet8A3CDOaxjNM0sAkRSgjFv+ZRZcmStWA0EnDY
X-Google-Smtp-Source: AGHT+IES6841pfRu7wJ1fE8tkWFVUP5yKx2Qsc59u66WH3eAZk+D5jBuwd6qXnDnBFP0nUtZ0Rx0xw==
X-Received: by 2002:a05:6512:1196:b0:52e:933f:f1fa with SMTP id 2adb3069b0e04-536ac3464a8mr9490004e87.61.1727184064078;
        Tue, 24 Sep 2024 06:21:04 -0700 (PDT)
Received: from alessandro-pc.station (net-37-119-39-155.cust.vodafonedsl.it. [37.119.39.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93930f7b90sm83978866b.175.2024.09.24.06.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 06:21:03 -0700 (PDT)
From: Alessandro Zanni <alessandro.zanni87@gmail.com>
To: nm@ti.com,
	ssantosh@kernel.org
Cc: Alessandro Zanni <alessandro.zanni87@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	skhan@linuxfoundation.org,
	anupnewsmail@gmail.com
Subject: [PATCH] soc: ti: knav_qmss_queue: remove useless statement
Date: Tue, 24 Sep 2024 15:20:23 +0200
Message-ID: <20240924132025.22046-1-alessandro.zanni87@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the statement "continue" at the end of the loop where it
becomes useless.

Signed-off-by: Alessandro Zanni <alessandro.zanni87@gmail.com>
---
 drivers/soc/ti/knav_qmss_queue.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/soc/ti/knav_qmss_queue.c b/drivers/soc/ti/knav_qmss_queue.c
index 6c98738e548a..1cc54905b398 100644
--- a/drivers/soc/ti/knav_qmss_queue.c
+++ b/drivers/soc/ti/knav_qmss_queue.c
@@ -723,7 +723,6 @@ static void kdesc_empty_pool(struct knav_pool *pool)
 		if (!desc) {
 			dev_dbg(pool->kdev->dev,
 				"couldn't unmap desc, continuing\n");
-			continue;
 		}
 	}
 	WARN_ON(i != pool->num_desc);
-- 
2.43.0


