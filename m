Return-Path: <linux-kernel+bounces-392189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCAA9B90D0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 12:57:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 337E2281CCE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 11:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9FCD19F11F;
	Fri,  1 Nov 2024 11:57:20 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5556119CC27
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 11:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730462240; cv=none; b=AXlVoTzyDfnKlQSpnuMojT9wGmFpbgfoXZmwnYfO9XFtyM9JZIz3Y8EMQc2WaezzEf/6hp7O47ybVSyhFTheGxSgDfAnKWu+EbM810vUPAYrbXtCvseBBBA7xpfkalPf9pS3ydDgxCCtHiZUs9blS3Vfen6cq3GW0XWb+gs3Yj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730462240; c=relaxed/simple;
	bh=D5bQuqum8NEbKzevTKnqMHI44XR8ptln0KriVHztNwU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=oAFP0PEy6GsohW/Nh/23wixDLmmhPf6g9To18hIXEZr9t1zWazMSMMzCvzmYyvnH5vGiYR03j9adwG78IxTc6TkH1xbl6+1Rdmw+yRlxqVJRO/9jZaF/I3jHPCRe7/hcXzssitpll7OEcINU0HbArEDvqwIiZYln+34II+cdoOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3ba4fcf24so20135735ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 04:57:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730462237; x=1731067037;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q8OziaPjrMWzUcJM4X9tQOjE6A6ng6V/s7j+Smoe4w4=;
        b=pl2n4Q2WKv//WlJ0lgcw7WpNtmEyuu6FnRkKQq1PnlNJdyCFA5OEd3AARZSoctxsMu
         Ypf2vyyE629vNfYkZP19q4/VKBJRwofO0jJOYRIZdXH7aJGDIn6lyYo6PTcWX4YtFSXG
         GwVokRk/bEhBotbE+I3IWJETHwpPHMH4vSEwRLfcwZrSv47Bhr4Iyhqc/pHgu1rTsPE3
         werxwRuKheHQVoW9qRL4Z8T/0Orw4Pac+1/xhl0rVj3w3f0ICm3CAm6fXFrAQOT/Z4lP
         SsuwxIJvBG4KzoTg890KOvT8CAEN+qA1xYvN6bTVGbLcUqWi7FYhTndEBVKsdY1Wodzz
         K4pA==
X-Gm-Message-State: AOJu0Yy/KKUmT6khyBZHk3toDXAeJIsJcMFff9kEBNdn6fn2Mxdkn6cT
	soEnmy9h6vlGyfCiXnIdHav5dcuxDtf3iHD7ELayd66Yag0SIAQWO9T05ZgNFNCO2N0FFzcsjw8
	JIRbhXNdSBMj0oQHQfXGC749YmSTrBWFEyF+l3gkkg0Nd9jF5hPRnfXA=
X-Google-Smtp-Source: AGHT+IEkg77Gq93Dh42XbQh0LuLRrnNzlZ70NJxgUNJ3OPJQWflMx5BVa/tm5qII/Vtpa6t4QfF2S1Boi5IU9D6LG8oJ4eec5hlO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1feb:b0:3a0:92b1:ec3c with SMTP id
 e9e14a558f8ab-3a609a2b2e5mr72541845ab.4.1730462237468; Fri, 01 Nov 2024
 04:57:17 -0700 (PDT)
Date: Fri, 01 Nov 2024 04:57:17 -0700
In-Reply-To: <000000000000afab690616b12f99@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6724c21d.050a0220.35b515.016e.GAE@google.com>
Subject: Re: [syzbot] Re: KASAN: use-after-free Read in netdev_unregister_kobject
From: syzbot <syzbot+6cf5652d3df49fae2e3f@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: KASAN: use-after-free Read in netdev_unregister_kobject
Author: dmantipov@yandex.ru

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 6c52d4da1c742cd01a797a4d0a2d3c5a60dc9bfe

diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
index 367e32fe30eb..80ac537fa500 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -73,6 +73,8 @@ void hci_conn_del_sysfs(struct hci_conn *conn)
 		return;
 	}
 
+	device_move(&conn->dev, NULL, DPM_ORDER_DEV_LAST);
+
 	while (1) {
 		struct device *dev;
 
-- 
2.47.0


