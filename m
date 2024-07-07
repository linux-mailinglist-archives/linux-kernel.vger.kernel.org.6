Return-Path: <linux-kernel+bounces-243483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34DD69296C8
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 08:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26557B20E9B
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 06:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E087979E0;
	Sun,  7 Jul 2024 06:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j5sJ5Yk7"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E733B23B0
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jul 2024 06:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720332036; cv=none; b=BdErXsRoAjglUw5Pnzxk6yHWqCIDFf0sgRR6zOol0fa83P7HCQR00VWWOO3CzDAletl+Q8k5cBBe1ZvN/ExIEJF3QRllO5zXbjWG6VavAbtbnF1RndqAvkKeL0xSkT8oR1RSHAU3AoKHPSAzbuLg+kzO0E+UOsl3bpB+tq2v37I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720332036; c=relaxed/simple;
	bh=H6cPQ5ms3uaLdvwVxSxZ9+wUNHcNCDKI8rCw/mLmDMQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e/CthO3XmXzLT7kvlhEuJS4RmIhBxust/1F+d8vF9hfGiZ3eMvNt5aH7AUxJYFFlISwrhxt7Lx2CcsD28RkhQc43PC/FCyT0HcaZ9RFxzy0PP63sCBnoxcYCIaq7N3KrSN45IQpK7z/iPQPqgKogSQvxba1cI0nKwdsYofVrCJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j5sJ5Yk7; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fb4a807708so20421655ad.2
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jul 2024 23:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720332034; x=1720936834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0IGjS+Uaml8qMFqQu2OuijcDEH7XhYZvFeF/aJ7iOe8=;
        b=j5sJ5Yk7aIF8DOj1DfcgWuLd7kMH9WnuR1iZKD0/U0Xg7HHNZ/EghyJjmhABsynAf5
         WNeJSoAw8alTR9N/L8a3jSZmCe+bUOVTdkcdF+GpGNLX0aPVC8d40TiYMB2BIPzL6k/M
         Pm9iLjNhzKkSkAYg/ITgG5VhfoU2MewGcr2HBawIYIoiGWas6gYvuMMZHF+PyFo5Ni8S
         MvzeOoUwl/UicG+S1BFvXTW2tO48EdgjdtsMZHgFvZ2eKfUTw52yKsy6XD7KWOzjqZpn
         S3oQSaa297fLj2FvRPNTiywQoUhtbIPY6IW5EzFqIA75Ez3TJ6+rOsUR3eW8EvEEjinZ
         O72Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720332034; x=1720936834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0IGjS+Uaml8qMFqQu2OuijcDEH7XhYZvFeF/aJ7iOe8=;
        b=nvs+/N7KxmlZYeQ2SebG6tZwQ9qeg6QhXC4dJN4MZ34I7A2AyOpgs8A/1X53XqSUwv
         hXW+kgt/y8auzicRYH8Nyiz4tPQsihGHx+DVpFMA4K924KpaHUaFRF7c8Tv82+UrNZl2
         lU783prd6u89nn4byiu4L9PSoOFn8hLatiodu34pi9aLj+Ryxm6OijgqDys0qBNJCxpV
         bIzutgL59UYRL7ZTkVId3XCd6pAX1tzHGbNOGXDgknMfG6aBStylN6yM7m/vZ/dfdvlM
         O150F8KK5psw1kJqgS9ESme1GOVbZoUY+DUQpSDS1TWgsE+qTNACI6M+b/W7NZAeytlT
         KCYw==
X-Gm-Message-State: AOJu0YwWvoNVgCqR56lSbTXbo/mEt+s+gBh7rw8txYlPttp44ren0Qsl
	Uje7c6ehNHCZp2XK0sEtBHU+3iVeN5XYOBdteXf+JtEx7/I0tCLc
X-Google-Smtp-Source: AGHT+IHeN5TX25jlN/JgPbNytn8AEMlXBB5fUoGkFxzNSx2QJgHIEm0hyRfplXozBWuEX9ctL/Vxlw==
X-Received: by 2002:a17:902:ec83:b0:1fa:fbe1:284c with SMTP id d9443c01a7336-1fb33e188e9mr89926715ad.22.1720332034183;
        Sat, 06 Jul 2024 23:00:34 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fb6b03a0b7sm18942285ad.209.2024.07.06.23.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 23:00:33 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: syzbot+705c61d60b091ef42c04@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] change list_del to list_del_init in ieee80211_remove_interfaces
Date: Sun,  7 Jul 2024 15:00:28 +0900
Message-Id: <20240707060028.3261-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <000000000000ffc5d80616fea23d@google.com>
References: <000000000000ffc5d80616fea23d@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

---
 net/mac80211/iface.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index b935bb5d8ed1..7ac4a62ed536 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -2301,7 +2301,7 @@ void ieee80211_remove_interfaces(struct ieee80211_local *local)
 			ieee80211_vif_cfg_change_notify(sdata,
 							BSS_CHANGED_ARP_FILTER);
 
-		list_del(&sdata->list);
+		list_del_init(&sdata->list);
 		cfg80211_unregister_wdev(&sdata->wdev);
 
 		if (!netdev)
--

