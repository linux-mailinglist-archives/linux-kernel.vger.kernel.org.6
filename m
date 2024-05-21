Return-Path: <linux-kernel+bounces-184742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CCBF8CAB53
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 11:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DF551C21732
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 09:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E37E6BB45;
	Tue, 21 May 2024 09:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lTcmWNrF"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8FF6A8D2
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 09:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716285441; cv=none; b=phbBvm+4C7Gn6O0Ofo2+xWxlSMS7MuqNacKexzh1UsSvyFzct9i50qvT7QD4HnACPpD5M8eIyL4c1t4IwZ3R1dPYId0btLmVDhkcZU4DufruXTigOP+MMCwdNXCkAh4k38PYoYUjUtuBHXKwzhfVTyazeimbSBGEl65tmA8o1bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716285441; c=relaxed/simple;
	bh=0qPzwHfPxwiH9bEgiufqWDknYV680rVRxHR5kSQNXs8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hAMvtj5tv/k2vMmRyjL7aDjDPKc7jKrje4CPRR1GhT5UMpaXAAHB5aVXbiyScJWg/KpRnye+j9Cw5pCJrNLKrUauvddZdmkRQMX7MMbBpr2pEpH1WhuNFQjKsOrGfYo4lVwhR+M05hUkXmveK02mRmPtVHlZPuwJc5suXKWYVYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lTcmWNrF; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6f4472561f1so268872b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 02:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716285440; x=1716890240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T6v+LqDl7PgsDQchADwzDPsfHMrcim6MA4Pe4W269OQ=;
        b=lTcmWNrFstHozey05ze6KSn32IAfTvNTVk1s33UimNLvPkczuvjhKmn+21gJc8LCQx
         RZCIUrx/rB/AyYmIi4vdO7/hcli8AtG2JvNXYnfbLG9L/1x+fd6fcY82+DUyyNAGpazA
         JjXFtMJSHHgv+2tEzYNxns1+dhhDskQyu7OVF5zhahBa+9yWaQmHoTA+x9Xg9BFHjelI
         rY+948VaFyIPxvpfmYKPaTo588hF9xjUO3HG1x8DJMY6zTYIeU3V/sfSVr8tv0Hn1U2y
         D74OofDtJkIuCpmp/Lqv7n1qmKU+hMxZOlOiToWqtBIyBs0yqbIQpDYdSCgWRdCia1dm
         FA1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716285440; x=1716890240;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T6v+LqDl7PgsDQchADwzDPsfHMrcim6MA4Pe4W269OQ=;
        b=NAMCNY2entWCI/yPEVxcPY/zd3P3NRJuM+JMqAIDsaZMMpKC9nWSo16s4AkIaZyHc8
         kRH4gtquFRkWV3tJSzlUe4yLaAA3bfoantfbtbZ8sxTLXLYjAgu/TGdVZYRqkU2aINpY
         YGqoZGm7QbOQzOM9yY7J80oiOQRSYQGjldwwdE+/RAMrotgLilOpGNvbpc1U+o6V4OMY
         n8MNCXJKI26hXb2M2puBY2jHCt7ERtTYOAk5a836db+mlI+P5zcE6MRdddAEW1GBz9+U
         pL5cHmrV/RiX3S4uaSaZuJDbrmP+ve4bHbVjLTtqgNQNZIi2TXXu5Fu+rOC5a5mfgtOC
         O6LA==
X-Forwarded-Encrypted: i=1; AJvYcCWjQKi7Nh+3Vv9etd0QmrNPWN+QFNsGcETEunKf5ujWPaNiJmjR25ZjY6w3+DbBq51R+m7N3gHY7UXlPxbpmIGIabD1TGDLl68Xd2io
X-Gm-Message-State: AOJu0YxQ33cFdrasTJbHR1NDYyf0ydAyqVnXkAqDJD58cM9lIaNcdcDe
	Wgo5X0eZkShnz0VYBHDtU6En0ceyGZIip/DMzXa2/SeQiFuggA0mSUtfpyi/
X-Google-Smtp-Source: AGHT+IHwg/ycMSP4zLIilBIn2Qoz0J6SpMwS1AKx/OEKZQgsMDwvxYZJsM4P7HVHFwTkABW/MGFNEg==
X-Received: by 2002:a05:6a00:39a5:b0:6f0:c88e:a0dd with SMTP id d2e1a72fcca58-6f4e0384b45mr41097087b3a.28.1716285439636;
        Tue, 21 May 2024 02:57:19 -0700 (PDT)
Received: from ubuntukernelserver.. ([49.236.212.182])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2a817cbsm20332785b3a.58.2024.05.21.02.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 02:57:19 -0700 (PDT)
From: Roshan Khatri <topofeverest8848@gmail.com>
To: Larry.Finger@lwfinger.net,
	florian.c.schilhabel@googlemail.com,
	gregkh@linuxfoundation.org,
	ayushtiw0110@gmail.com,
	dan.carpenter@linaro.org,
	namcaov@gmail.com,
	linux-kernel@vger.kernel.org
Cc: Roshan Khatri <topofeverest8848@gmail.com>,
	linux-staging@lists.linux.dev
Subject: [PATCH v3] staging: rtl8712: Fix spelling mistake in rtl871x_event.h
Date: Tue, 21 May 2024 15:41:33 +0545
Message-Id: <20240521095633.50753-1-topofeverest8848@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

codespell reported misspelled joining in rtl871x_event.h. Correcting the
misspelled word improves readability and helps in searching.

Signed-off-by: Roshan Khatri <topofeverest8848@gmail.com>
---
v3:
 - Fixed misspelled word "readability" in patch description
v2:
 - Changed "mistakes" to "mistake" in the patch title as suggested by Philipp
 - Updated the patch description to reflect why this change is important
   as suggested by Philipp
 - https://lore.kernel.org/all/20240521082510.50422-1-topofeverest8848@gmail.com/
v1: https://lore.kernel.org/all/20240520064750.48912-1-topofeverest8848@gmail.com/

 drivers/staging/rtl8712/rtl871x_event.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8712/rtl871x_event.h b/drivers/staging/rtl8712/rtl871x_event.h
index 759a2d27d8f2..0cc780cf4341 100644
--- a/drivers/staging/rtl8712/rtl871x_event.h
+++ b/drivers/staging/rtl8712/rtl871x_event.h
@@ -37,7 +37,7 @@ struct surveydone_event {
 };
 
 /*
- * Used to report the link result of joinning the given bss
+ * Used to report the link result of joining the given bss
  * join_res:
  *  -1: authentication fail
  *  -2: association fail
-- 
2.34.1


