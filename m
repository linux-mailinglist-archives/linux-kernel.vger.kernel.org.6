Return-Path: <linux-kernel+bounces-269349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03DD69431D6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 16:17:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34FFC1C24042
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 14:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7851AE875;
	Wed, 31 Jul 2024 14:17:01 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6CFDDAB
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 14:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722435421; cv=none; b=ULJg2OXegRUVncvp/77a3l7VvxjWtRGchwjZ4E9bcRVYeFd3iSEY1Du5231KaXlmQ/e8BpYyFeouvQIvSLdDxAB4bRiT9JfrZMWt4sJKyWBL5lW1RMVCCjDj+0KOxfJVGxB9EJ4g6UBv8FrZKd0xlGf57+1BpKN5XseLxgYSUL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722435421; c=relaxed/simple;
	bh=+xTrRYfQlCSnNEUwg9GKxV31hp7OwlLBV0+oKyHJcMA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=kIUk3V8rWLd1tVHzxMOB3SrmeV8kDfD5LtReBNoQhiulbAg6ggnBErRe5+s6glatwKsFnIQxg0OCzZKyW+GYvulVLs1Mo+gIzlPChRMBDq6Nxdwr5upr2edzEDX26Gz0unqm/kFrjU/Uyi5XA/kMHhZdVa30r27sQtaYcEWa4po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-81f87561de0so876184439f.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 07:16:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722435419; x=1723040219;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3e+/SqpCAfiNvWpP2QlCaGcZFqSEbO2bmkn8qZK2aTg=;
        b=dgIHLMo++dHkFf5bYtOzY5Re3FZnZ5tF6PgV6OocHN2IFflBDQWFW7hKejQCBIe7Ct
         Fvm0BqagnPrtXtRDnlu7w+vmFWpMp8RtbUCIkri6Kluc5C4C/bWLYBMk+MFw9lBCCaw6
         +CnvosTOjSkxqtdz5eRsPPXgeAEJ/ZoaQC/a6Rix1Y4a9GOYEW5O2Lpe9qEhvn1w9KPG
         FdTUXaj4YextUHsqw7XfpKSP9nowXnSB6xHrKvTsIbNtc6DSlGYz/wTARd0JlriQ2z5Y
         P5PMgphc7XNuGU/jHuKqFn1ybSZGXbE6LJ/IzukEzHj4j7e9s0ov3uKLNq92hNOG05a5
         BdUg==
X-Gm-Message-State: AOJu0YwMv7oEZmEmX4IE9nbfvmu39a6z5oAqENqZr11V2Ir+FBhe7Miq
	BNxVm+SgE3Cr/jguwVfAJbROO/Ktb/Plv/giisEm0FDnruCNPG4PkjkPJV0tr+aXrQeEYjzherc
	opZ3o737ov9EZpJa+whobKeauCcIABGh2rB3npDbibIilL0MxJrr/BLg=
X-Google-Smtp-Source: AGHT+IH9mfUT5Uq49YvHmg+nX7sKUyzwuy61Bfoh+qdRja6GUKa8/ijt9xAWpygqRim1O6QcfkImmuI3XmlqDQiCWAEQQd0pmH62
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1546:b0:398:3831:4337 with SMTP id
 e9e14a558f8ab-39aec427281mr9697155ab.5.1722435419228; Wed, 31 Jul 2024
 07:16:59 -0700 (PDT)
Date: Wed, 31 Jul 2024 07:16:59 -0700
In-Reply-To: <0000000000004da3b0061808451e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004fe2ca061e8bbfb1@google.com>
Subject: Re: [syzbot] Re: [syzbot] [net?] possible deadlock in
 team_device_event (3)
From: syzbot <syzbot+b668da2bc4cb9670bf58@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [net?] possible deadlock in team_device_event (3)
Author: aha310510@gmail.com

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master 

---
 drivers/net/team/team_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index ab1935a4aa2c..ee595c3c6624 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -1212,8 +1212,9 @@ static int team_port_add(struct team *team, struct net_device *port_dev,
 			   portname);
 		goto err_port_enter;
 	}
-
+	mutex_unlock(&team->lock);
 	err = dev_open(port_dev, extack);
+	mutex_lock(&team->lock);
 	if (err) {
 		netdev_dbg(dev, "Device %s opening failed\n",
 			   portname);
--

