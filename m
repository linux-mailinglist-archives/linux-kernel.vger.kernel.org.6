Return-Path: <linux-kernel+bounces-434347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F7D9E6551
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 05:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A6DE2852C2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 04:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66253194082;
	Fri,  6 Dec 2024 04:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a80QeMwL"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6323F28FD
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 04:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733458432; cv=none; b=OIrgGk0GE3p/u8BWATOiCDDqV5oDC2LUcN+YJfLvL3j/i2SjHd1lKql02XiqIPhH5RqdRfZitUYAjc4UudS6d6TwV+/tOUNqA4sSRHUpfJ/ZmeP31XDjL650ZEbmL6R7QURWzutDccKBHVEXV3XyESxzMyR3kD+e/orkUIR1uoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733458432; c=relaxed/simple;
	bh=9HvO6MAsaIXImHWsj9SUkjkf6vOQBCv+prcETtLm2y0=;
	h=From:To:Cc:Subject:Date:Message-Id; b=hIPp1iIEHQNXBjLHpI3NI5zXX84AvE2Ba1ZuphJDlp4sfhjSlA8o2B7UXow0mNphKqp8y4IyAIUkCnz3xFhvHAMKzse0FZk1Ymtq2KYKJWM0iuj6bo41CdABShBVMQDpvTKbd9oL+McHmH16J3LYxdHvThKXmafmcHaockiKFLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a80QeMwL; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7250c199602so1755945b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 20:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733458431; x=1734063231; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UuXPmsAiOF3KO5nczLS1cdNL/HEbPrxijgBKivhC7TQ=;
        b=a80QeMwLYKQr+fJGLaB4x7HPmwZdNWDujqJpqkibVYqqZyVS0QR4+3lAmYJ/5d7PiJ
         qDZi3qSIbjVkSZ6Tz6OXrF2zBv8Q1HWLMttQfrthpO7eqfrdjpgZYIKRALcFqXkLl/zO
         r2F9RFt4ypaC6QCFS2ogNSUktru8GGUwfFQy5dbC10O2S8PmxBylZf/GoOYx6lqXK6YF
         5Cc3fUJrti9RuhDrhSdgJLea3f9pQW0rBtSfvU7seVFUuo+3vaT77Z4R2Qffvv9c3MQ6
         GUz4p5jMpU8Lg0hiZmJbbT9mL8wCCCU+j0ofr3Ixlg+cq7pSadersvAQ+74NOrq8rSJ7
         gsZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733458431; x=1734063231;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UuXPmsAiOF3KO5nczLS1cdNL/HEbPrxijgBKivhC7TQ=;
        b=X1OuHhTuCMZuRb6YgDqmWeyg446bz8XsFlJexxuru2W6zytiIbGA7qg5mqABp55RXr
         v5gvoEbMOl9hBNWj5m16epTZES4DcdVZvaxyns3WGBXgL5+w4HdAjAiuBrPRYmzxVOMp
         OHdkZeVsg32GadsyGVJFk5FkkmLgJ+bvL0qkZdNm1sVhYkAtfdbYWMyAShqUtWjc5d3O
         mXnxR282kC6tqdREOEJ2mEMclZByFT4/CSsvZWLt2PfaGk5ABScsYuasqp5q0vi8Jc0c
         5XvdLDbddus20pbD1pGcWoacC2bO6w5K/scvwal08yuOV/bL3haUBN8fmXyyFlJ378t/
         9A6Q==
X-Forwarded-Encrypted: i=1; AJvYcCV7GGAf8EDmL9ikI0yOKmUcCqmchDO3TlA+KJDk+lRmEdwU0g270EmkYjWywDt220XuAoykhzQR8cZ/g60=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTakOzJ3e4ln/NHr+RFytY65FLY2UmhZrm+6axtESvL1S7Ll0U
	/GvMQ+5wd9/RCkblT+yAP5Ajyf/XvYLkdWzAZe11AGw86EZ5zIJb
X-Gm-Gg: ASbGncurOpZL/g8sTvHuKQmKwCzZGMccQFO5qPlzCkI2xbPppFYGNefyzh45jQLsTCl
	LiQ1tB7OHp5NXDxjvMyBXTeCTD99q38hN9j17rymDeRpv6PlpA4RoFb8enRaVy7Y3JWtsfa9gaz
	Q7tk68hJJCvsqzM6lNaJo4kBMnY1L+Skh0wus/JDAaxL2Q/FASpcaWyy3gJfSbfuHP9nYcGf+dW
	X32y+zfDxkcO46T62kt7mB+2QLb/1yQ7LEqEsmuFYFMwxMkqOj0EobfRYI=
X-Google-Smtp-Source: AGHT+IGZZUwFyYYKNSZJGEwBzFB9vB1IksjaTseSLyd5Hv0Gt7enq5dkTyGH4fVP1YU6F7XCItfZDA==
X-Received: by 2002:a05:6a00:189b:b0:71d:f4ef:6b3a with SMTP id d2e1a72fcca58-725b81bdaebmr3143136b3a.21.1733458430544;
        Thu, 05 Dec 2024 20:13:50 -0800 (PST)
Received: from localhost.localdomain ([43.153.70.29])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd157d421fsm1836330a12.72.2024.12.05.20.13.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Dec 2024 20:13:50 -0800 (PST)
From: mengensun88@gmail.com
X-Google-Original-From: mengensun@tencent.com
To: akpm@linux-foundation.org
Cc: linux@weissschuh.net,
	joel.granados@kernel.org,
	avagin@google.com,
	linux-kernel@vger.kernel.org,
	MengEn Sun <mengensun@tencent.com>
Subject: ucounts: Move kfree() out of critical zone protected by ucounts_lock
Date: Fri,  6 Dec 2024 12:13:47 +0800
Message-Id: <1733458427-11794-1-git-send-email-mengensun@tencent.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: MengEn Sun <mengensun@tencent.com>

Although kfree is a non-sleep function, it is possible to enter a
long chain of calls probabilistically, so it looks better to move
kfree from alloc_ucounts() out of the critical zone of ucounts_lock.

Reviewed-by: YueHong Wu <yuehongwu@tencent.com>
Signed-off-by: MengEn Sun <mengensun@tencent.com>
---
 kernel/ucount.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/ucount.c b/kernel/ucount.c
index f950b5e5..86c5f1c 100644
--- a/kernel/ucount.c
+++ b/kernel/ucount.c
@@ -164,8 +164,8 @@ struct ucounts *get_ucounts(struct ucounts *ucounts)
 struct ucounts *alloc_ucounts(struct user_namespace *ns, kuid_t uid)
 {
 	struct hlist_head *hashent = ucounts_hashentry(ns, uid);
-	struct ucounts *ucounts, *new;
 	bool wrapped;
+	struct ucounts *ucounts, *new = NULL;
 
 	spin_lock_irq(&ucounts_lock);
 	ucounts = find_ucounts(ns, uid, hashent);
@@ -182,17 +182,17 @@ struct ucounts *alloc_ucounts(struct user_namespace *ns, kuid_t uid)
 
 		spin_lock_irq(&ucounts_lock);
 		ucounts = find_ucounts(ns, uid, hashent);
-		if (ucounts) {
-			kfree(new);
-		} else {
+		if (!ucounts) {
 			hlist_add_head(&new->node, hashent);
 			get_user_ns(new->ns);
 			spin_unlock_irq(&ucounts_lock);
 			return new;
 		}
 	}
+
 	wrapped = !get_ucounts_or_wrap(ucounts);
 	spin_unlock_irq(&ucounts_lock);
+	kfree(new);
 	if (wrapped) {
 		put_ucounts(ucounts);
 		return NULL;
-- 
1.8.3.1


