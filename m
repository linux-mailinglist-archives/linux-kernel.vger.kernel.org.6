Return-Path: <linux-kernel+bounces-350432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA396990509
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 15:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E60E9B22AA7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 13:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D509C212F1D;
	Fri,  4 Oct 2024 13:56:52 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCB0212F1C
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 13:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728050212; cv=none; b=M8MQwpvygnXkI0dB+14lUakrg1VB5yUZjYy5p6DiASHJLx6M/ocLDMvkKNWkkPgHE5Pwy+/tbYdQxf9oM3SJscyuqjvDP1nqNvZduk1i5dcb9m0MXOVOj7nydvJOgLKqlGQ06ibvXZxeij5fz0/JkuwW3/30VJmomHnkw19PTNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728050212; c=relaxed/simple;
	bh=CzR4Eb4/dDwTsmdyJTm8D0cje2IzafzkjG1aBbd2qBU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=h2bcvsh35JPuos8QkWmIlCBJNZfUKOAwBR5lTYkikTYanwJhfwG129OC+b9fbKLQmZqeyhl6HajV9FXDItzu3t+oSyvxdVIQ+5p8WakaMFvOQ+r6d8lJxd6v7FuzkOd0N33anXrmnjF9UO7YamWdvwANQD+/EyetmIgANhMRaWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a34988d6b4so33555675ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 06:56:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728050210; x=1728655010;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cBnxlWIdj3TpJzvieBbIOYmpLQb69r0U9EKYM5qsgUY=;
        b=kIzTHhPtDaOZqLhn9Kn8u9PAaxyEuYpEgkX0STqMx1ypdqzneXMKkGWy3Ma2Ccv4Dy
         AaT+DHsm6VxsSk5BKrwtd+qpe6+BPj3Z77PzNNtTG7JIn1moE0ZkKYPOv58bvoT15E74
         lVKTUhk8GkrTtzEJr3BOgYqkjbB2wL8PSpilEkmHa+B8InJjb70+Y4PkI4Q0Qu/FIIC5
         TcFGyoomLAFvjBio3wq1eeICD2Qkheb1mV04jNsxlxr2hF0f5jNsl/+tswDvjITR9OvP
         1By1ndyyQr9K6zbbhorIejOZQlL4ohvfqG387KWgHMjYIyENnNVnvrgRv2B3zThe7Y5Z
         F36g==
X-Gm-Message-State: AOJu0YyWz/wHTw7hp4lLCldymyOKZFqCAuWWILPqs5zD8yNq5kfBzaqv
	H543Hwnsmd8KmqJAL2O3OYIuOZ2Wf4rLJQ4oiOIwhrJe4c8xctymJDDKboib8FwZT0Oj7wlSGiW
	cd6602WHRjowFNk2bzLKKnECmA2hNC/2+iB9yb+2H7q2nicbmqTbZd0M=
X-Google-Smtp-Source: AGHT+IGMLRzh6dyTSDuVDCekIrPVau34uaA5eLHv6dAagoe50toZB9r2DEBh/n/0WzDxSRUPGXmQOFQjkqmn+s655PTr9m1aoloL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1685:b0:3a0:98b2:8f3b with SMTP id
 e9e14a558f8ab-3a3759925d4mr26726875ab.7.1728050210188; Fri, 04 Oct 2024
 06:56:50 -0700 (PDT)
Date: Fri, 04 Oct 2024 06:56:50 -0700
In-Reply-To: <000000000000932e45061d45f6e8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66fff422.050a0220.49194.048b.GAE@google.com>
Subject: Re: [syzbot] Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free
 Read in set_powered_sync
From: syzbot <syzbot+03d6270b6425df1605bf@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in set_powered_sync
Author: dmantipov@yandex.ru

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git b63c755cb65d43c8aba987c4f6b57c77c6f123f2

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index bab1e3d7452a..492723a22e68 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -345,6 +345,7 @@ enum {
 	HCI_UP,
 	HCI_INIT,
 	HCI_RUNNING,
+	HCI_CLOSING,
 
 	HCI_PSCAN,
 	HCI_ISCAN,
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 629c302f7407..95f55cfb6da6 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -501,12 +501,16 @@ int hci_dev_close(__u16 dev)
 		goto done;
 	}
 
+	set_bit(HCI_CLOSING, &hdev->flags);
+
 	cancel_work_sync(&hdev->power_on);
 	if (hci_dev_test_and_clear_flag(hdev, HCI_AUTO_OFF))
 		cancel_delayed_work(&hdev->power_off);
 
 	err = hci_dev_do_close(hdev);
 
+	if (unlikely(err))
+		clear_bit(HCI_CLOSING, &hdev->flags);
 done:
 	hci_dev_put(hdev);
 	return err;
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 2272e1849ebd..ff43718822d4 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -1671,6 +1671,11 @@ static int hci_mgmt_cmd(struct hci_mgmt_chan *chan, struct sock *sk,
 			goto done;
 		}
 
+		if (unlikely(test_bit(HCI_CLOSING, &hdev->flags))) {
+			err = -ENODEV;
+			goto done;
+		}
+
 		if (hci_dev_test_flag(hdev, HCI_SETUP) ||
 		    hci_dev_test_flag(hdev, HCI_CONFIG) ||
 		    hci_dev_test_flag(hdev, HCI_USER_CHANNEL)) {

