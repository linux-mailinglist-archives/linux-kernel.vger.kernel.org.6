Return-Path: <linux-kernel+bounces-239786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC1792654C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 17:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 361831F2229D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 15:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64FD6180A94;
	Wed,  3 Jul 2024 15:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NXdf2SOs"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2CE17B41D
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 15:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720021921; cv=none; b=Lg9dLO0QNESIrOXXS3D4N5U/X3/8ggefq9eJIAT/h3kN5fnQQYI0lOed9iIhlZ09FK1UPm/NEFoyDOFzxqnwSI3ewI3tsdVorVXVUrVXJwx25WrFMKXO763u+K8WloZIWyuNPkZ2fD/wZqA2JwZI7LLFWOZJPgM534oZoNyoXfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720021921; c=relaxed/simple;
	bh=GkpTPi8P4ApDe8CYSRCs3rhE959LVlEQN1gG5pyKAWs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VlUlPTHmNBAld9qiFmZ3eQWHxqSSEZUmm23Sxw81YfZDjZ+ga4cY8WPlgG3W1BqT5BuxDeQF2esYWZPse7IJTZYOKZkWP/L2GkJP4MBd7E091FRUP62Q0lU8uOacvg9UewBmU/il/z7f9QmoIvYcmxUfUInYJuQlKNbcCNphneA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NXdf2SOs; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-70699b6afddso3835953b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 08:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720021920; x=1720626720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iBRIJk4OmtaI83yEcD87GVjj5GV1KWBbEvNwrvJbLqk=;
        b=NXdf2SOstymc8FSUlkeSeEmziAYGNDuO0SZwHNY296u6O020p3gSM0oEeOlJft7yoM
         Ut6E0RdoZ+MdYI3rHT/koG9QxLsPnVwMfuoa2+7wNJQmWtw8U3iRxoq7HNpEEcp/BOhI
         ykKjyAqoFpWztu7f8UPb8VqOnK6P+sEuDw13shsVinhDOyrBJiTlbqSmpzBPg11phg0y
         r7ojogmBpnHR7lowbT4l/apEDnoc+pBhNyOvTtnBdm0wyR6I93g1vcsEHV2q/PibX8re
         YN0gI4q1v5jgRX1vRquFJcL7VFxDr6U+sug6dJpa8XRrQXOiB3hwaefEdUHqI9bXEppH
         YTRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720021920; x=1720626720;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iBRIJk4OmtaI83yEcD87GVjj5GV1KWBbEvNwrvJbLqk=;
        b=b5FRs9p0pQJb/efZd8yqf0xmvEYmxXQX10O5+03JoqsupqgVu7FCc4JjSgaGe1S25q
         xV3I8OgIGM8smPB6rXeOs0U1xUCrb35+gUWLAqUil+0SEwuFvIfdmyJ3LzCjZh5SO0yx
         t5tlgRak2Y+ZAQY28vO2XSeyXtzxYWvoUIvZ7bKdclW6PCYoHAuQ5bH2Hq38sauJek+E
         6o6CXk+iDINs1lAsGzxSEszKkIUSCUzBzViPM5cFzS0MD+JwIyrOe4tQrqAjPSStJLnh
         Zj3BVJED27Ek2YZsVh3btWA409cwKHXaebVrEB/++hkI/NTtFTwjmsKsSWiRKa/ed0uB
         KxcQ==
X-Gm-Message-State: AOJu0YxcSl399LY7sXwUgggip9iSJOn+ioeIZs+0S+ZdwPZNiVf/QBHk
	sz9HnelVxQcVnBhGXrthJMx2uhuUzRqOKMTpZBxwFQija9O4GkA7
X-Google-Smtp-Source: AGHT+IHj53HUu651XbX1c2Fd9aJnqEzdemIIjKwA/NOmxVg/8J8QuIP17oWhxG1vyz24KCldcVe+nA==
X-Received: by 2002:a05:6a00:80f:b0:706:58a8:f686 with SMTP id d2e1a72fcca58-70aaaf520bemr12421436b3a.32.1720021917639;
        Wed, 03 Jul 2024 08:51:57 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-708029582fasm10576997b3a.88.2024.07.03.08.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 08:51:56 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: syzbot+705c61d60b091ef42c04@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] possible deadlock in team_del_slave (3)
Date: Thu,  4 Jul 2024 00:51:53 +0900
Message-Id: <20240703155153.83500-1-aha310510@gmail.com>
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
 drivers/net/team/team_core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index ab1935a4aa2c..43d7c73b25aa 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -1972,7 +1972,8 @@ static int team_add_slave(struct net_device *dev, struct net_device *port_dev,
        struct team *team = netdev_priv(dev);
        int err;
 
-       mutex_lock(&team->lock);
+       if (!mutex_trylock(&team->lock))
+               return -EBUSY;
        err = team_port_add(team, port_dev, extack);
        mutex_unlock(&team->lock);
 
@@ -1987,7 +1988,8 @@ static int team_del_slave(struct net_device *dev, struct net_device *port_dev)
        struct team *team = netdev_priv(dev);
        int err;
 
-       mutex_lock(&team->lock);
+       if (!mutex_trylock(&team->lock))
+               return -EBUSY;
        err = team_port_del(team, port_dev);
        mutex_unlock(&team->lock);
 
--

