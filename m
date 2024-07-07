Return-Path: <linux-kernel+bounces-243484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE99D9296C9
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 08:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 793AB1F21E9D
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 06:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B3D79E0;
	Sun,  7 Jul 2024 06:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vbt3dYEg"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533FC23B0
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jul 2024 06:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720332138; cv=none; b=MTdossOQ9lBc6mt1spiQ2H83PKYQNro6cwmgsEISW9U1By0Q832YHYlVA8KFh1LAZfXh9brOepiZScXS/YCa5aZYeZHYknykw6XB5KVrlGv0jdVsoHzIrpp9FIjutPVMzuScaTeM+RYOyFE3yMeJZ454yrj/MUA07nB3rrmMCAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720332138; c=relaxed/simple;
	bh=H6cPQ5ms3uaLdvwVxSxZ9+wUNHcNCDKI8rCw/mLmDMQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XISvWIZxe5FmV3dcCXdAwvAbVHUfxsV2EQIpUenNPzp41ckxZB/Ghsv4HxOeC37YS4gV2Ya8NMT7I0ESo8klbSQ9luv7j5JPQ1NiAGoLFZEeZvcu/pop3WK9GMwPjkjFdT6imecnc8Z7AU2SsbeimJwW2zzIpGXyXw/4j3E+l6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vbt3dYEg; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1f65a3abd01so20133665ad.3
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jul 2024 23:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720332136; x=1720936936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0IGjS+Uaml8qMFqQu2OuijcDEH7XhYZvFeF/aJ7iOe8=;
        b=Vbt3dYEghfVQcN7jLzLwiwlBrEVqVpmWxlZ6dmMqvIA4LUiKlJsPLNxa1KMgFrhZX/
         TGVf+1ZbMIZcW3+V0/6a0Wh+YqlOlR/FT1/hLvQPjXa3QUP8Ogxn3H2xvkWCImYdEGQS
         ieklUc+e7wuZR83DJHMsiA8a9zB1Vta50NowN4pul9keduevgtiJE49kJhow8AOOvG9w
         kF29j5LqRk13f5MHWBo/fG5tlmp7LOiBofSF1QtwnoO0l0ibjDV8CvX0+Otpi17StTcC
         vQaMHWJSCK00HNFR1/RXt7azidYaOxIafm5Rz9+vBWjSQtejuT3oZYeWiVu7Az+NLdd1
         iVWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720332136; x=1720936936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0IGjS+Uaml8qMFqQu2OuijcDEH7XhYZvFeF/aJ7iOe8=;
        b=nV0TyJjZClGv7C/ehGOhq69Y4CQtkj/0lHdhy4eZ0t3HP+athYydgFpgqNxOr3uppj
         KrFAYqw1WeIAsER34wij9w5Q4yEXygROyiNvV7hZgjeMFHYE2vX4BgzbxdpXWjgoatNW
         ta7aGEXq19Osu2KPyg7LmUMVLhAxIYuulUWa5zAGTCc8+o8pViC/r5YbCYW/bj/AoU0a
         hrANPbLbqFluK6SOvUqz0HnhqIvqnvXqAnk3lDIvXJVctawujVm8TTCNZujCX4g+ABIh
         b5vrtgHoxQyamFEJp+0zsik7JWzRHlW/Nt5MXoLPRuATudap3BsRtxNBoS5SXyxLOFnI
         X4zQ==
X-Gm-Message-State: AOJu0YyH1/Okaj60LzhkS+osdoBLDcGOTYDtVvp3CsKZEn8jpByorv18
	hIFMCnui4/Z4G+6bixx5cldCXunPg6gGFEVQGwkSi0NRc8M4Dw7z
X-Google-Smtp-Source: AGHT+IG99n+YAiWmWhfYQ350jt140MuiEkIHQkXBRUVw9K2XCzed5xDVn6gLxRMimwlPlAGvL019Sg==
X-Received: by 2002:a17:90a:bb0d:b0:2c9:69ce:cd5a with SMTP id 98e67ed59e1d1-2c99c53bcf2mr6379383a91.17.1720332136439;
        Sat, 06 Jul 2024 23:02:16 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c99a950c37sm5897085a91.13.2024.07.06.23.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 23:02:16 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: syzbot+705c61d60b091ef42c04@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] possible deadlock in team_del_slave (3)
Date: Sun,  7 Jul 2024 15:02:12 +0900
Message-Id: <20240707060213.3367-1-aha310510@gmail.com>
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

