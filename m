Return-Path: <linux-kernel+bounces-548829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21580A549C0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 12:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 969A51751E0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 11:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F73212D7A;
	Thu,  6 Mar 2025 11:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="luYK1E9E"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76987211A19
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 11:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741260964; cv=none; b=ujz2t6LoowVr5R00Hy90ieIhWVFpDqejj2d1+KMgQBloCXb3cwExeXMRSFi2WuxcLNY1q6OvIrFwRbeSUXNT3PgyJpb3XM7zbn3y+5JTQmuxpsf1ENRpQMZJYVXs/J8cIlkTCtkKNq+LH3xaXrU+9KHrmTxeAUU/N/e0xh5sKK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741260964; c=relaxed/simple;
	bh=3nZQ7e6h+YacqRMgx/Xd4BzDtN/zr2bOXSyLefmucUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M5CM+TQDqTOXTgAqcE99RcQD3jnBZcKgnsZNHGD6F2KCuYb+DF1bWIwlWJsf6ynBRJpoUCz2p5p2d/Wam1O3dkuVf7+WSxBrZO2XIal2dPHUuRaZ/lsnzaOQWzQ9snRsU8sk0wEwxFJOsY+n/ydIBdgE8eYokI3ZbGQtk25An4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=luYK1E9E; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5493b5bc6e8so614952e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 03:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741260960; x=1741865760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s+AyyFlWHkvIaDbzkVyONzVVHpZRnmhFgeQIexgdJRs=;
        b=luYK1E9EukrklF3Da1KFaE0zJUWoZdADjqhPeXYS+0O9GuXlY5uTN7f1xhHA657OYe
         SG45t1qH0WR057Kr9mpStJ6YCQSKsL74uLHBwggf9x2jns3PuFKk8tU9YKeLF1M+70o9
         r0R09n9+avzwVtdzoHFPpyPRx3EOlyM+kc/syvduKQrrT99kq2705JtGPG9PPgKITT5o
         qo3dy1E2/d5tiQJZgJPkV3w8sZvSpHjbkDNBHNzck40P76XdzN6gkGwVWXUURte+6Iwp
         rjRC1cAsz/WC/t0VNO3gEeLQxLcBrEmYemsanmVyyLn9fNXPJRLHutS63xrqnIi+Q1V5
         Xnhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741260960; x=1741865760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s+AyyFlWHkvIaDbzkVyONzVVHpZRnmhFgeQIexgdJRs=;
        b=DxSERRWda5JkRoNWHFKbFQpIk5TSBNaR2Yf0O1+j8+QSFkyg2zUVp1O+SSHkE5o8Ea
         QMl/9fnn+QQWKbhp/hP6JY6U/UeewJguCjCAq8R6+kNKD3I2T35m2cBpCyFIC6qHY6NB
         MQ0H8A8oogy5KWEEOA+50ApPsQsNc6OUMnIwnz7jfE7z9oise6eMk45/Ne2OWWw3a14n
         o10oL3NPO5vvKKAJbH2z5cInUYzm9VcwD3pYsudpbGChD9cWBL4KZD1h93NgAmD56ZPj
         7sePS9NPWqhuLQjZg5ype8dTx9vwZ+d8DpyUbWpq//fDxAYR+pN1sz/PC9vCHSBfOQ/3
         tZSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNI5hWVUjumABBzdJdeGlNXAYFuhfHsK504ygJ1edP4KfNdXNCaRbhp+z7w80yRWaCO948utugqmos1IM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUx9TgBtD/HEbs8+/fB59MMia0WSASWUhTnjNwJjeMHcqdT+YW
	BiEirWHv4bRdpqsj0qslTFiq0sjVU7trSWcU0260efjrC1AFt/ABv/iivFFJdC8=
X-Gm-Gg: ASbGncuXVav8m52pwSHHtD5542bL71WUqTlAlOAbMNxQvXuO6Eli2g6N0pMe5ubXJXK
	0GOac0FjuEJPwxAly+W1ZzV95lXGot5QTD3l2nNGdIILJyxGAxx6E7iZhRXdhYM2VMq4M7CFow3
	o9BCimDhFCefDFCmZfk/xCBsg32LbXEuhZp/+B9G2pqOg8aPrzPS8PO8Fnp5qRTQ0qOX1ldLW9D
	zkNhPyktyR4bJ5DB2ZmuPYhJKJxiMA4Kap0sSUKIUEhGSaHMh5pDB1apZkeN8H4FfPuEmsE+in0
	kIF+juMA1DCruePWs5V4xoxH9lKom37IYXZE9K1tADvZOPPdLvJMzApjaoRUKB5bgqxT3yK05U7
	wUqt7QnnL+OvKwRkMF6I=
X-Google-Smtp-Source: AGHT+IGdluhAdfmeE1f9+qi3DVUdsCzNksoJolzcqmbX6FS/jk4/mksaZKHzfgsja4/EHr4gkuoFrg==
X-Received: by 2002:a05:6512:b1f:b0:549:4ac4:a464 with SMTP id 2adb3069b0e04-5497d33215dmr2277928e87.2.1741260960489;
        Thu, 06 Mar 2025 03:36:00 -0800 (PST)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30be9918086sm1809511fa.54.2025.03.06.03.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 03:36:00 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	linux-pm@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>,
	Pavel Machek <pavel@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] PM: s2idle: Avoid holding the s2idle_lock when calling pm_wakeup_pending()
Date: Thu,  6 Mar 2025 12:35:41 +0100
Message-ID: <20250306113549.796524-3-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250306113549.796524-1-ulf.hansson@linaro.org>
References: <20250306113549.796524-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There's no reason to hold the s2idle_lock longer than necessary. Let's
instead acquire it when really needed in s2idle_enter().

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 kernel/power/suspend.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index e7aca4e40561..ca09f26cbf4e 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -91,10 +91,10 @@ static void s2idle_enter(void)
 {
 	trace_suspend_resume(TPS("machine_suspend"), PM_SUSPEND_TO_IDLE, true);
 
-	raw_spin_lock_irq(&s2idle_lock);
 	if (pm_wakeup_pending())
 		goto out;
 
+	raw_spin_lock_irq(&s2idle_lock);
 	s2idle_state = S2IDLE_STATE_ENTER;
 	raw_spin_unlock_irq(&s2idle_lock);
 
@@ -111,11 +111,10 @@ static void s2idle_enter(void)
 	wake_up_all_idle_cpus();
 
 	raw_spin_lock_irq(&s2idle_lock);
-
- out:
 	s2idle_state = S2IDLE_STATE_NONE;
 	raw_spin_unlock_irq(&s2idle_lock);
 
+ out:
 	trace_suspend_resume(TPS("machine_suspend"), PM_SUSPEND_TO_IDLE, false);
 }
 
-- 
2.43.0


