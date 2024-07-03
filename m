Return-Path: <linux-kernel+bounces-239550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E68926204
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 15:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18D511F23BC0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 13:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C0017A59B;
	Wed,  3 Jul 2024 13:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FzxXWZtE"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E306B1E891
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 13:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720014285; cv=none; b=XM8G7CjDq6wLby90U6wkYZftHIkiMPObElueVcYEEg4SU0sat0TN/rxcsT365iCfisn+frRs5FKD4W0vH5GxWJwXVSrU2GjoZm0ePr9k0nUOHy8HCS7GeRLNPbDp1VHx8IKZIM7PFqwEnYYFHszOHsN5vMX6vLNkc614Ccyd/Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720014285; c=relaxed/simple;
	bh=ScdAqoAeBuQD3KpHmD6W7NyYl4A1XiSIi4GlwH1InU0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gIQWoPysFpCBtPMHWh6cAChDCNo7u6utOeylZF4djX6mGRpuLOpOqcF5W0nHm3EhIyS9yp1lKFf5SjeKc1THjl8K/jPnI0f62Auh2XZh51NU/Ahd3Ymhy/bLdq7mPs73XrIapQSqzxh62Fyw3lfzrsYOgJrggMjPMKHV4fSnfjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FzxXWZtE; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-382458be75bso2851555ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 06:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720014283; x=1720619083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LyvT7a3XWBg4WM1pfJF6b3xvjEPXEA/26ZU9sblubv8=;
        b=FzxXWZtE4N4MFY7IvOhR3jniL9RoK5K1YjvFeLnGUnjn9Q9GXbol/cBHLPnXz6pR4W
         7KOq3lHmoJylXBKsyJb+4MkYG5RGqlRvtgHaqXBgWf/Qz7fcyHsUagxpeEKEhNuXPheT
         C/X+aGXsBbHiUafT/IglO5RXUqhmJoInchc95OI6vZzbr/QkESoV19GWfpn3P8xy7Ynk
         Q9CF9qyAFtRJF2WyLNMoFwlHgDutlt+NRldKXUA5PJQwEnQkJLlgbsJx6gvvoMzjvntI
         2IKlL3D+fFhc3zv4gnIXtZrlAzZP7PFFtjEgVBwWzNNQDoaOlyioQUupDAg7XKabFaza
         z4Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720014283; x=1720619083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LyvT7a3XWBg4WM1pfJF6b3xvjEPXEA/26ZU9sblubv8=;
        b=ZYWpmvdOFzgct6b00z/PU6zFVChxvm7FBVh57nlttZJnAFyYefX7gqXeNqksvPChsJ
         niSH/E1S5tQdNl9lRvmQDwE83p/CH1YZJP0CO0vugUE2pE5tCrLsDITyb6KtUT8pXCvH
         6+hgm+8FddvoXMNaW6/Xn40ILw57LgLHPOVpCOfb8QKZcXFOLAq9rXyvnLb2bATzf+6F
         U2NQcIjI2Ksk5kv3DCrp9+R3nPtgZ/gClwLie/ac6Vf+Bw4Y97lmSJN5Jc+H2sY6ll62
         NSsQxeS9yS3u5FWSBuRV67Jm72qPuWVtD6UFvNKoaInoV26SLCTDLs+fugyuCimb+P4b
         Jxvw==
X-Gm-Message-State: AOJu0Yw57CeiQ48QNWKfC04/v8yOpm2j/nX4baDYs4sXlVx2gqYixXid
	SzIyOqAzd43qV1/R+uFvGxkJ1fMw5bzzHcZ3SAy2EPMPczXA/1Okalnl+nD05BA=
X-Google-Smtp-Source: AGHT+IF99FX2Y9TiFXZLf+MxEHYr5IDR9qE5B5BxjDF3BIN2ryHqTGeeoCGGWOPVDIDiTrklk5AY/w==
X-Received: by 2002:a05:6e02:1a82:b0:382:586d:c113 with SMTP id e9e14a558f8ab-382586dc332mr14268145ab.2.1720014283027;
        Wed, 03 Jul 2024 06:44:43 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72c6a8deff2sm6873399a12.37.2024.07.03.06.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 06:44:42 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: syzbot+705c61d60b091ef42c04@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] possible deadlock in team_del_slave (3)
Date: Wed,  3 Jul 2024 22:44:39 +0900
Message-Id: <20240703134439.79904-1-aha310510@gmail.com>
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
 drivers/net/team/team_core.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index ab1935a4aa2c..3ac82df876b0 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -1970,11 +1970,12 @@ static int team_add_slave(struct net_device *dev, struct net_device *port_dev,
                          struct netlink_ext_ack *extack)
 {
        struct team *team = netdev_priv(dev);
-       int err;
+       int err, locked;
 
-       mutex_lock(&team->lock);
+       locked = mutex_trylock(&team->lock);
        err = team_port_add(team, port_dev, extack);
-       mutex_unlock(&team->lock);
+       if (locked)
+               mutex_unlock(&team->lock);
 
        if (!err)
                netdev_change_features(dev);
@@ -1985,11 +1986,12 @@ static int team_add_slave(struct net_device *dev, struct net_device *port_dev,
 static int team_del_slave(struct net_device *dev, struct net_device *port_dev)
 {
        struct team *team = netdev_priv(dev);
-       int err;
+       int err, locked;
 
-       mutex_lock(&team->lock);
+       locked = mutex_trylock(&team->lock);
        err = team_port_del(team, port_dev);
-       mutex_unlock(&team->lock);
+       if (locked)
+               mutex_unlock(&team->lock);
 
        if (err)
                return err;
--

