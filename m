Return-Path: <linux-kernel+bounces-305692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 245899632E7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 22:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24FDE1C227BB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 20:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE751B29AD;
	Wed, 28 Aug 2024 20:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e/DVfUhX"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE981B2539
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 20:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724877988; cv=none; b=hNIOeN51SBJmGkl6SW2s/EW7MSZw2Gc8GVGgU61MczecU7JMgQ7ZztNLxwi2XV+tOjvinoB26+LO3mDOMZZvmKVHUmZyqV6JX2pnL7PhwVDgOPoFLG/w0nS6IPyY3Scz537AGOH5GPJj+7SuPM269ZtXVJw6bcEGWHpzdV+uCwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724877988; c=relaxed/simple;
	bh=t7MF9q9qQ1/BFft9PGBV+aPNqpvkHl+vf3Eq8jnJlio=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Lq7SBVyZWR8SLW2e/xNl5aqDs4iYe9JOph/SEat1a+JyBjMJmWVspxnXmRkLZYZ9ZeG9mf6dZP5JaHZ0LPNGGOlyiOrkiGjietVxR92Q1WurUR6TrDf4xka244EcHxjQZMxE7/Ve5Sa5qZ4dN11L+jbrSi6SuJ02E0WnDFgYWuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e/DVfUhX; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2021537a8e6so65564185ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 13:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724877986; x=1725482786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j2NP7ED9yQeOL2K0nW20zcco+YfFdB0bQPpahpoJ62g=;
        b=e/DVfUhXbqbb+QQsrJl6QhNlXh/lnauek8w+cSwxYhi1Q9089cE+U+BA+zK4G6Oa3D
         bqPK2uo7TzVFGyIjz64L49AvtESg3kc4M+GJ/tUh5XQOo4ru/AjOKqFKHJ5nOtZH7jXb
         R4h3aEyWdAGgYutJHvX3AG7QxhXSJTKp25hKzvJn4SCVLF6bHt0Zm2kjQ5PTVk5DexdZ
         6LyzCcIRhWIISZQk1uRPdI8yKhn1NROeBHKFFFTsiuN3m3E1DvDVow4bn0YFltwpSLs8
         TxNB95HjLvTb6Viqfqf9IRqQpgX+CITiWqQJ+kMfHyhrT/LFiTCbv/q3pMGzgfQMHZEi
         UZPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724877986; x=1725482786;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j2NP7ED9yQeOL2K0nW20zcco+YfFdB0bQPpahpoJ62g=;
        b=xP61og0dgEmWK+cyNC57jsE9R9+mjOM1zw/3/diS57y9rw2hQS4zY5gILsXP4eowLs
         SUfIBJfA5TKYACH4GBFYuwxyhArIp5Yc/aaiTBHgUN6ba2VeR9QxsKN+FXgqP+qxqydW
         OCqtas71UL8WTVjHP0fIt6cpZyQno5QzZH/67ELnTRnuWalxXAtQ9MrMoziV76BRA1Up
         0fgoMPazSMrz0yLWxjG/6Jy5cKR5KbKsEbb64WwM5u59rgYnKI8rVFF8UxYR2pLZJcJe
         XBGw0Xr7te8O1gx+uml5TNfbsxctW8/U7B83vNnpMycps64otzjmbTgadItbwwGyyD4p
         I/Iw==
X-Forwarded-Encrypted: i=1; AJvYcCWcxIUhNHM2xjLBZ7fuXm3Pwcd2nZ3kZB/dsdX7bcQgJEhn0nJ+c1ZjLMN2TXCwK8117T/1t5skJfgWBio=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXMNfC2CdEHLCRzEXTjL7FJ4OShRPKPE+t6jNwa2ZUrp29LvAT
	HZvLQqycdGjmD2YN80+GkTKtYjO/5Fl4S5lbykd/yY0p68bysZtE
X-Google-Smtp-Source: AGHT+IF1PJ9A+TITiNmvfXWDWKmuCksVnECrUQ69s8nJM+FRJbDAx090f53Kxf0EIeY4e03kSaWIXQ==
X-Received: by 2002:a17:903:41cc:b0:202:1547:66b2 with SMTP id d9443c01a7336-2050c3ab754mr6212665ad.28.1724877986299;
        Wed, 28 Aug 2024 13:46:26 -0700 (PDT)
Received: from masingh-thinkpad.. ([49.207.54.176])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2038556667bsm103351525ad.7.2024.08.28.13.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 13:46:26 -0700 (PDT)
From: Manisha Singh <masingh.linux@gmail.com>
To: florian.c.schilhabel@googlemail.com,
	gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: philipp.g.hortmann@gmail.com,
	Manisha Singh <masingh.linux@gmail.com>
Subject: [PATCH v2 1/2] staging: rtl8712: Fix style issues in rtl871x_io.c
Date: Thu, 29 Aug 2024 02:15:52 +0530
Message-ID: <20240828204552.26790-2-masingh.linux@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove multiple assignments from a line

CHECK: multiple assignments should be avoided
+	pintf_priv = pintf_hdl->pintfpriv = kmalloc(sizeof(struct intf_priv),

Refactor the _init_intf_hdl() function to avoid multiple
assignments in a single statement. This change improves code readability
and adheres to kernel coding style guidelines.

Signed-off-by: Manisha Singh <masingh.linux@gmail.com>
---
Changes Since V1:
	Broke the patch into 2 different fixes

 drivers/staging/rtl8712/rtl871x_io.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl871x_io.c b/drivers/staging/rtl8712/rtl871x_io.c
index 6789a4c98564..6311ac15c581 100644
--- a/drivers/staging/rtl8712/rtl871x_io.c
+++ b/drivers/staging/rtl8712/rtl871x_io.c
@@ -48,10 +48,10 @@ static uint _init_intf_hdl(struct _adapter *padapter,
 	set_intf_funs = &(r8712_usb_set_intf_funs);
 	set_intf_ops = &r8712_usb_set_intf_ops;
 	init_intf_priv = &r8712_usb_init_intf_priv;
-	pintf_priv = pintf_hdl->pintfpriv = kmalloc(sizeof(struct intf_priv),
-						    GFP_ATOMIC);
+	pintf_priv = kmalloc(sizeof(struct intf_priv), GFP_ATOMIC);
 	if (!pintf_priv)
 		goto _init_intf_hdl_fail;
+	pintf_hdl->pintfpriv = pintf_priv;
 	pintf_hdl->adapter = (u8 *)padapter;
 	set_intf_option(&pintf_hdl->intf_option);
 	set_intf_funs(pintf_hdl);
-- 
2.43.0


