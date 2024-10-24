Return-Path: <linux-kernel+bounces-380061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C899AE859
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 16:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E79EC28EB99
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 14:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2C41E8832;
	Thu, 24 Oct 2024 14:14:07 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B981F9EC7
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 14:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729779247; cv=none; b=P+YNniTbRDvF3y8Oj4Fw4Ui7uyUghmQLeR452JtYTH2/efrboXsHzzC2YjuyeHhT8G5DnOM0chjttf+bs2+6uStXvn23jZBeneUvhDG5p6JI6mFezIevQ0N0H/Tee4ZugbZ6oAvvLEWoiG+nn3sJZAJtwCXW3upXkjs5IzNjDWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729779247; c=relaxed/simple;
	bh=o9ztT9DIBFmCn1Tp8ub3wdlaElSkSRH6CB/CkqW8zIo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=hCYiGNm8WDk10LmBEZhpOm3VTBlhyKEZTxeanx2+lH4uHNA9GS8uHtFEvFc+GoE+P/tE1Ph5vVl67RRk3ftlczqgyKzu0mhJ3/nnpM/AXaHgG1ExcNChiFjXsU8cIHw53Ofa8rRFY98JKq2EehoyLCeqckafIgwhzGhx0bc/+n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3a6afd01eso9273265ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 07:14:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729779244; x=1730384044;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pc4+qw8W2B3ot05EKciEY+pCxEgfm6rLR/d6cuCVk7s=;
        b=f1awu491vYhoH9ORIBKIdFIUPQtF82lVm+cBzRy5gc72P+t29BwqSOXz7cZtW55PT+
         J38h/hsRIwto8gOEmCWvsYqZqik0mLfuBWLLjldLdKOm0jpCTVta6bLJC0CQodzKOSqU
         Qz8au4tIPaCwzlLpv0iQ+jdQ5nrSeZF/hd06TNWz4ZKcxlDu34Eb7pW+xQ1kB18VEkEY
         GanFGx0mQNo4Orn8EC2HjSv5UcYk+YQ87bRn1uDibN5ofDGAkAgbtOopt/FYkBfst1Hg
         maC9fv9b58thkgFQMgEqtUA7prIDeFPg5SHheZKm1Bf8rIBGhscLNcMcyipw5tSSbHdF
         URZg==
X-Gm-Message-State: AOJu0YzDSKmbwH0tWYvZqiSXfMC4+nySoWiP5JkzB8W0ZOQj47RIYpVu
	4XhFom+XS2BoPaRXXHJlvu/Xuv/Lg9/fsT6tOssuyovxomkIhPEWhWsiyQ9jz617aZhxbiXVdmg
	auKO8t8MEOFDnkfZntM5295qq4VH9HkbW/u0TPeU9xEGdCxW3aW/4sCY=
X-Google-Smtp-Source: AGHT+IFeCarR1ZhlYJFyJ7vM4U4iPu1F51NlKU+Int7s3S7tVfkfQ/GzrEsPLwDyL+OmXta2hhbXoHWir74f1uduRdQJ7ZJmbAQA
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20c9:b0:3a0:9aef:4d0 with SMTP id
 e9e14a558f8ab-3a4de7820eemr18503015ab.5.1729779244476; Thu, 24 Oct 2024
 07:14:04 -0700 (PDT)
Date: Thu, 24 Oct 2024 07:14:04 -0700
In-Reply-To: <000000000000afab690616b12f99@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <671a562c.050a0220.1e4b4d.00e0.GAE@google.com>
Subject: Re: [syzbot] Re: KASAN: use-after-free Read in netdev_unregister_kobject
From: syzbot <syzbot+6cf5652d3df49fae2e3f@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: KASAN: use-after-free Read in netdev_unregister_kobject
Author: dmantipov@yandex.ru

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git c2ee9f594da826bea183ed14f2cc029c719bf4da

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 629c302f7407..aaa7849c74f4 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2716,7 +2716,6 @@ void hci_unregister_dev(struct hci_dev *hdev)
  		rfkill_destroy(hdev->rfkill);
  	}

-	device_del(&hdev->dev);
  	/* Actual cleanup is deferred until hci_release_dev(). */
  	hci_dev_put(hdev);
  }
@@ -2756,6 +2755,8 @@ void hci_release_dev(struct hci_dev *hdev)
  	kfree_skb(hdev->sent_cmd);
  	kfree_skb(hdev->req_skb);
  	kfree_skb(hdev->recv_event);
+
+	device_del(&hdev->dev);
  	kfree(hdev);
  }
  EXPORT_SYMBOL(hci_release_dev);


