Return-Path: <linux-kernel+bounces-267489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2CE94120E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 14:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96354B25757
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 12:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F02419EEC8;
	Tue, 30 Jul 2024 12:41:38 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58386757FC
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 12:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722343297; cv=none; b=Za7kBgQ9GMo3SOfTCAb9q3kJWcHKNy0942s0oYnKBO+/k7OFk9gYr10pdo05/txAHpzWTOJPrgg9fwD7wO3uiFK240Yn7R7ugWKKCXh7e6o2Px8I3A0Xne8hrZFWWO/wORqy0g2XYRQ7ZkIDDt8bfhR/uGdUr3TDVkbis675ing=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722343297; c=relaxed/simple;
	bh=Sa4pUeLQ+vlZbd2pzjfIpSqx5Zwhcsm4o129UDbEoLI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=rluhcZg3Ti0nitJS5D6XFx3VJfuIXAMzAUWobamOJUPXeBhBCrb2E6NVY5d16dkDRXDXfA0VIO/bPnUCpMyE+SjFnnZvX8CBi9nb9VD4j5IUk/5YH1x8Kfutaw8HX3oxpeVfwbRJCCglEmNhjk1/YeiyhIVsaEMWWrhzHr8ZPpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-37642e69d7eso63382795ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 05:41:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722343295; x=1722948095;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DsuWEAwFesBmVmB4583XOMo/wby9g3RmZDSGzW/7gaU=;
        b=t8IzLK3xUYht1vDoNK5kodAiXdttLCVXLftYRWFnT/fr2LxCXnwJFkg22YxZjp/oCW
         0mQDXZtDXwZI0PlW84XUrKAA2x4bE57Euo9fLaZaYqouCWQ95cHj9XIn1c5WTTXB3ltL
         O1BPBKzALQbMtqD1DMxG71HMs0Ko8inu3uA/MXFtk9huyQmG0m61/itAhd5Z9cenqpfk
         nUmQw+dR8x6IE3qtftJwuuMaSuyKtI8iusEt6fNKJssH90UDKOrVdi1q8+b/ltj5lrxB
         isB7bCiXH3xt6khvsri97w09iNFVBn37VBW07PaVxMfb6NxXFSAWY72iw1RY8h1nchgy
         Z4nQ==
X-Gm-Message-State: AOJu0YzouNty/ZUv8B5LopeLW6ILBVGJ8juIPjedsZ2wdVv6iNu9R6Ga
	Vg3jigAVU0rmZjBLcIs6XaT1x1KHTUxMALulJEEKac4/kLxTVhNam99vhrijMrzMwpN0hezt6t2
	+9SaWaJu9xwoc+wuiQGyaiy+P+bYkYxlgN8KVajyqXxEUzEbwPS9U7Gc=
X-Google-Smtp-Source: AGHT+IFBzWxqeUmj57QaeX34OfdH2pTxYjwbnBxvjvZYzQvFDKa4hz+JwKxknwE9hwD8TyiJLP/wMUpLMOm/Bq8xq8gCgouD0n8f
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b2e:b0:39a:ea7d:2a9a with SMTP id
 e9e14a558f8ab-39aec438d4cmr7824925ab.6.1722343295473; Tue, 30 Jul 2024
 05:41:35 -0700 (PDT)
Date: Tue, 30 Jul 2024 05:41:35 -0700
In-Reply-To: <0000000000004da3b0061808451e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004eea70061e764caf@google.com>
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
 net/core/rtnetlink.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 87e67194f240..178f5b85fd87 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -2896,13 +2896,6 @@ static int do_setlink(const struct sk_buff *skb,
 		call_netdevice_notifiers(NETDEV_CHANGEADDR, dev);
 	}
 
-	if (ifm->ifi_flags || ifm->ifi_change) {
-		err = dev_change_flags(dev, rtnl_dev_combine_flags(dev, ifm),
-				       extack);
-		if (err < 0)
-			goto errout;
-	}
-
 	if (tb[IFLA_MASTER]) {
 		err = do_set_master(dev, nla_get_u32(tb[IFLA_MASTER]), extack);
 		if (err)
@@ -2910,6 +2903,13 @@ static int do_setlink(const struct sk_buff *skb,
 		status |= DO_SETLINK_MODIFIED;
 	}
 
+	if (ifm->ifi_flags || ifm->ifi_change) {
+		err = dev_change_flags(dev, rtnl_dev_combine_flags(dev, ifm),
+				       extack);
+		if (err < 0)
+			goto errout;
+	}
+
 	if (tb[IFLA_CARRIER]) {
 		err = dev_change_carrier(dev, nla_get_u8(tb[IFLA_CARRIER]));
 		if (err)
--

