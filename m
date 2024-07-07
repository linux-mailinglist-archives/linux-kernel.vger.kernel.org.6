Return-Path: <linux-kernel+bounces-243485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D5EA99296CC
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 08:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23F82B211B3
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 06:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B6FBAD27;
	Sun,  7 Jul 2024 06:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VfTuygGg"
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8134428
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jul 2024 06:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720332420; cv=none; b=lvxMBLLDDSewppz2vTrhInuUBLMYQ6Y+4JlsGbnreScubDpIFESrJz4JRl6uXekdawPA1QS4tavJDi+KYlREkz0xj4N4QLIE4Q1wlK6mt4t28Qahlf7VA3s5L76nuiuC6PjawQ/AXt2WZMjgDP/mKlAv2xg94TDyS7V4EYHGkWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720332420; c=relaxed/simple;
	bh=ryB6ZdkmhUStxWUU6h99VO4HJ0DsTJB726AxFZvC79U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SeeXNJU1viN26YUHq1j73aw5EACVQtQErAWPXrSbA2O4/Uv2k9xBoKh50XJqIPNShIHDQHvBo/WqdY/OiUs3PjHkIGOMB64IC6IOdR3m/Kg3NsaJxvOPTLp8ZfMIKxQNFkhBN5Vz14wGjSvZQ3n8D0GO8vCE3QGHi9K3Pgxg1vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VfTuygGg; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3d9229486efso962676b6e.3
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jul 2024 23:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720332418; x=1720937218; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L5HC0xqXo3XDLmEjG9smXJrrLr8bFvzWxtYvM5QY9u0=;
        b=VfTuygGgrE2yuRGAgHyFuKTtOr0piGhQHoW/01uVL5oNrIZbts7ZT+TDJrsAYkYICm
         Zz+x++T+y1fe81rL+tFMCehWTSzT1j9DiR/sjZuhlmTs0wbOSkFf+s2RLU3JuTVO6QQ/
         bPtE4g6IRxDM6CPoe1N4wnRY2sfU/0ZnbYf7hTn7cdfBQ9g2LTF2Zqpc6LrdmI/PdI0X
         gpCodAXJvl/VRqO/9zP/ptBspMeLidgWd8ti28XGpnACQ7gSjyIKp9vaHai7gHMrvXIb
         UDnDIyjvTv1Ov9SzYwWOefc4QY0xM9mW0TV1z9rj82EfevtuyThyxW6g/NfF65fDQX2I
         Q3qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720332418; x=1720937218;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L5HC0xqXo3XDLmEjG9smXJrrLr8bFvzWxtYvM5QY9u0=;
        b=wK3wutLUIAZhtfFMrUMjBqns94VlSvWu2cmShkn+Zznvt0typlNp0+1Dyia+CKXeXQ
         OVqyvqjhhkYo5c4Wshra94fab1lVcW6tKCLFUQbloBDNscMBLzF3F2WwMhlRLqxJU/Bl
         8A6WQHgl1kzydp+R3+d6NgErfx4QxBJyG36OkHMYxHsxUm13oNQ+CvfCAqK5WFkzOE+u
         tu6nJZQlKPcO48Zdtf+JsYyxS1mYk57P+ioWuXU6krCclYgyY5viHR0Oda5DGzRchKc5
         MEF0PeSfCYqTeHybiFVsgtW4ib97m+7dhdYhBjgpPpf6q+p4V650ZXWevYS9aR7KU1H8
         rSRA==
X-Gm-Message-State: AOJu0Yw4sVdBQtW/BggdwRA7egrDH0HlCV+ven8phrI2wYFInaVoJ0Sh
	c+wc+F9qXXxrBJG/wOhcjaladtFPhdIbRuoTxxHEznVWj78TjOrO
X-Google-Smtp-Source: AGHT+IGqrk6nyx30ziH4RghodODiu1m9ZWk7YRXXaJJyqG1WkE2sGJlZfHz19C6V8CW4e+Dg92f1fw==
X-Received: by 2002:a05:6808:13ce:b0:3d6:2b42:82e3 with SMTP id 5614622812f47-3d914c51bc2mr10738715b6e.4.1720332418337;
        Sat, 06 Jul 2024 23:06:58 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b15e0cefcsm2859369b3a.166.2024.07.06.23.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 23:06:57 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: syzbot+705c61d60b091ef42c04@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] possible deadlock in team_del_slave (3)
Date: Sun,  7 Jul 2024 15:06:54 +0900
Message-Id: <20240707060654.3822-1-aha310510@gmail.com>
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
 net/mac80211/iface.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 7ac4a62ed536..e55b1c2654ab 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -2286,6 +2286,8 @@ void ieee80211_remove_interfaces(struct ieee80211_local *local)
 	list_splice_init(&local->interfaces, &unreg_list);
 	mutex_unlock(&local->iflist_mtx);
 
+	wiphy_unlock(local->hw.wiphy);
+
 	list_for_each_entry_safe(sdata, tmp, &unreg_list, list) {
 		bool netdev = sdata->dev;
 
@@ -2307,7 +2309,6 @@ void ieee80211_remove_interfaces(struct ieee80211_local *local)
 		if (!netdev)
 			kfree(sdata);
 	}
-	wiphy_unlock(local->hw.wiphy);
 }
 
 static int netdev_notify(struct notifier_block *nb,
-- 
2.34.1


