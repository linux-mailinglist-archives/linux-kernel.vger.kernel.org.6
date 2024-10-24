Return-Path: <linux-kernel+bounces-380059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A379AE84D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 16:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78A051C222B7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 14:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23B6B1E7661;
	Thu, 24 Oct 2024 14:13:24 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38F51DF980
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 14:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729779203; cv=none; b=NhY66MDDCEjYqkvkRWEzUhznrZr5YYcXOPke4ev0+cN+phC3qovLMB3TruVLD5ZbavMidx9evSdfurukrRmq5q6mbdvNI0c19tsxIdwk9f17J29DLq9ASnsZRp7l9l0jFu42WKJsIcBGbW8SDlA6b6IdJKrRSzKCU6xVyp3oMds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729779203; c=relaxed/simple;
	bh=aUgWZjGHXmeitxu4SEI2Dj8o5VfZT+zNCEHa8maN72I=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=nMGsKV76P/Jv+mrD6IbhNIbwulBEbtKY5K0hkZ1/x9FC3LTYnATiETQvMD0dk0H55g//uiFRDTKjRes8RlL5fzCDtxAKkcmNTCoJfrBhP/QDkgdCgbN9EKZ5xDvGB79cmal4VgzFKRkyDRU+A2SDdYY4cTsGBfYwXXVeYbux/8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a3b4395dedso9597495ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 07:13:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729779201; x=1730384001;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LyRlmN5TojHmd2W2LVkpL5X+8/L48FS5Ught27NjYG0=;
        b=kxBwJIIOeVIPq4edk5l4Bh/sBYAiRUD1tIvcSx2Paw9O5siX44Opmz932M+YJsFjN6
         WXiXj2i9iqvlLp0f/g4brDNRSyLT6fSievHtd4e0b8m4rVufuhcyyfgR3e372tjkoB66
         SRVJRWaflgykygu7+cr/LqPcDC+hkbFuvHUVzlKEaanUJEYx6712yz2o3emBeL2vOdgf
         R7TcUDxu1ChjyRxqEQMLaXJm1ppl1YiqPG17euMG1GJQxUgZdMJmB0uWo8gImEycTwzo
         JxqGVC8pwMRjVxXFUbKMH6gxGPDyPVHciqdDrL5E8mt9r2BIOeZR+Ubxr/rq065Qxtyo
         RlPg==
X-Gm-Message-State: AOJu0Yxv7rGawck80xnVFjepCN9bodge4EIZWniuSM2HAZu4Er6r3Tzy
	F3sAHSwHRBWrX0XY2iq+iB1/iVCZLMVPFWm6hNhfK8Pfh2OW3wlD+Zr+SQmmA4Kk7Ggklxm2OS5
	14nO7t8pAs7+ufeMtEfM4VTlQdQqzKbogO3/CVmZvCSfs9jVFBuBvrrc=
X-Google-Smtp-Source: AGHT+IEW8bFiaud8yez5QudRn0i2UQNHtfAqZoPbg/0jq2EeD+zGYmk3IUQprkmrLr1tHvNJEu4EoJ+y9fs/WY4kkmFWh8G6bBRu
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a67:b0:3a0:b384:219b with SMTP id
 e9e14a558f8ab-3a4d59ff663mr63073545ab.26.1729779200602; Thu, 24 Oct 2024
 07:13:20 -0700 (PDT)
Date: Thu, 24 Oct 2024 07:13:20 -0700
In-Reply-To: <000000000000afab690616b12f99@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <671a5600.050a0220.10f4f4.01f0.GAE@google.com>
Subject: Re: [syzbot] Re: KASAN: use-after-free Read in netdev_unregister_kobject
From: syzbot <syzbot+6cf5652d3df49fae2e3f@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: KASAN: use-after-free Read in netdev_unregister_kobject
Author: dmantipov@yandex.ru

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next fb4560832d4c91d73680538d6659ac2c024ec9d5

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


