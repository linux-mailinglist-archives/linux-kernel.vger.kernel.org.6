Return-Path: <linux-kernel+bounces-423365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F719DA659
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 12:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DCD12830EF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 11:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905731E0E02;
	Wed, 27 Nov 2024 10:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Afk2R8G2"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3DE1E0DCC
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 10:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732705126; cv=none; b=rpo+8u0swyqa6hRN29i+r80ptflAKTn84lyclAO0i0NUqmlXDMDWAsfidqQR2FgEUZR2j+XH4D8YAyp7EFRIhcHXZukY3z3OIAvMzT4XgWu+GZJAwaoFjAzLWCZ2PJo1sS7tkLqTyEXhn18yZ4Ej9TMQXCzGoK/mqL3XqE4ZCyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732705126; c=relaxed/simple;
	bh=S7LPZ+3y6FWIMJsp5Ouu+DK3lPX6vaJw3it09f2Ne+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Guwx5+NftI7VMvwFAYvV33X7r0BpPgXct/mvysFaTbx6x7TPidzk3LohLFCls6YVet4ebhsnF3XftyUGfZJUfDCivOtBPUkp6xJYGOyVq74qo1uGci+E7xZm00rO/4s9lgoZRHdhTaucK9u819XWY1k1eINsOiKS0Xf0d0Ud42E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Afk2R8G2; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7f71f2b136eso5335895a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 02:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732705125; x=1733309925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cJl3kb5XMLhtXCrbkEMR/4kHcfh7IzK3UV5gKDYZwhw=;
        b=Afk2R8G21GIWVC+W0lbOF6px0gMudIA9JtbHDynGABu0sO36zPptK7mNOzCUYIWG2z
         nG9zMiB7KReDqofLojXkBtDtIBdB0FLKdIULbeS/CTmOXCfdRFsmX7KJAbnxFrR0d5MQ
         e+9zzm234kaQwOFrABpid10g5CTaJOdfKqDYY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732705125; x=1733309925;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cJl3kb5XMLhtXCrbkEMR/4kHcfh7IzK3UV5gKDYZwhw=;
        b=josGelbX/W0WOzCP1tD0YhrV6uQ/S0TyRAT2yuAsinnZIOmBCnMRBm0Hn7AjHpDUdP
         1JX5a3/gJXLrnusAQU/reeA7TAjg3DHv9Ffkyz/ZEU03KJEjt1soWEfpfHP42PXIK4J9
         bX6F01Rm239pzGjc6/y1ncXV4ZsjiKjFX4usowA0SYh43QBNHheWsXSR88hBAhm4DBJG
         W0rQZczup6GrZ0qH0Ecy1Iz38KMTJk/Z0SxOCD6YL38GcfY4bOmWSrAJ3zzitiHB7qRw
         ObQLsM5X9v1uYIKBHk/yOg7JkY3mcwRxVQZhUDoFvkaiiECzKMJ9s9Av/HybKLdlbETb
         qvUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXw7JgSP5YoTIm/aUncmY02pDa77E5QVNXXJl+sIbtBiv177hQxtJ/2KLdRcFomljfWQBwQ9WqoUSAf658=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaC4ypjcUGrhbvlndayytZ5MvK/DN+bHKqvZYcOoHtAPfy5Yio
	XAFkVJqmEHBe2FWTf85Wi0uIAdn/IcL4gWrmMloblpcmv94BvBTmTjyzLQibag==
X-Gm-Gg: ASbGncvuNCljtVg05xgPwBtfJBm4NxkFuCm0ikTLzJqOeP4TVzxFdtUB0QVzr37Pwu3
	adrz36QppIZVHkuZ77N2CfsQ4iX8ZC6zcl9xPQeNWRrFd7N30eaOMP+cyB6b3e/8w+cRZA3Msrm
	3fyP/liwAhNIDPbH8TM7qqplgEG/Y2f11lcpMlVXW8PtYFsobZ2ZSPQsJOuYS9Mc9Yq4quKlVey
	bBIlr9vh0DKQap7UFh12EAEsxit3j8C5Xvs27oaTDO0MiylK2IsV1IscuAZtGkmvZbdwxfHaQ==
X-Google-Smtp-Source: AGHT+IGL+fUYN25nrPPTc6QN4yfjwK4zt5HoSmXI1qXJXe97hGTkF/f4uxfX713K4ZM4XUZIFaEH6Q==
X-Received: by 2002:a05:6a20:3945:b0:1e0:d1db:4d8a with SMTP id adf61e73a8af0-1e0e0b207demr3923440637.10.1732705124764;
        Wed, 27 Nov 2024 02:58:44 -0800 (PST)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:a2e8:8551:482f:404b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ee0fa860a9sm1196835a91.33.2024.11.27.02.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 02:58:44 -0800 (PST)
From: Pin-yen Lin <treapking@chromium.org>
To: Francesco Dolcini <francesco@dolcini.it>,
	Kalle Valo <kvalo@kernel.org>
Cc: David Lin <yu-hao.lin@nxp.com>,
	Pin-yen Lin <treapking@chromium.org>,
	Doug Anderson <dianders@chromium.org>,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org
Subject: [PATCH] wifi: mwifiex: decrease timeout waiting for host sleep from 10s to 5s
Date: Wed, 27 Nov 2024 18:55:43 +0800
Message-ID: <20241127105709.4014302-1-treapking@chromium.org>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In commit 52250cbee7f6 ("mwifiex: use timeout variant for
wait_event_interruptible") it was noted that sometimes we seemed
to miss the signal that our host sleep settings took effect. A
10 second timeout was added to the code to make sure we didn't
hang forever waiting. It appears that this problem still exists
and we hit the timeout sometimes for Chromebooks in the field.

Recently on ChromeOS we've started setting the DPM watchdog
to trip if full system suspend takes over 10 seconds. Given
the timeout in the original patch, obviously we're hitting
the DPM watchdog before mwifiex gets a chance to timeout.

While we could increase the DPM watchdog in ChromeOS to avoid
this problem, it's probably better to simply decrease the
timeout. Any time we're waiting several seconds for the
firmware to respond it's likely that the firmware won't ever
respond. With that in mind, decrease the timeout in mwifiex
from 10 seconds to 5 seconds.

Suggested-by: Doug Anderson <dianders@chromium.org>
Signed-off-by: Pin-yen Lin <treapking@chromium.org>
---

 drivers/net/wireless/marvell/mwifiex/sta_ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c b/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c
index e06a0622973e..f79589cafe57 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c
@@ -545,7 +545,7 @@ int mwifiex_enable_hs(struct mwifiex_adapter *adapter)
 
 	if (wait_event_interruptible_timeout(adapter->hs_activate_wait_q,
 					     adapter->hs_activate_wait_q_woken,
-					     (10 * HZ)) <= 0) {
+					     (5 * HZ)) <= 0) {
 		mwifiex_dbg(adapter, ERROR,
 			    "hs_activate_wait_q terminated\n");
 		return false;
-- 
2.47.0.338.g60cca15819-goog


