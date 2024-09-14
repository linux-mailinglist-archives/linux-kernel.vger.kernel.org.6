Return-Path: <linux-kernel+bounces-329340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E4797902D
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 12:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21F131C23009
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 10:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70A31CF7B0;
	Sat, 14 Sep 2024 10:58:28 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA71A1CF294
	for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 10:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726311508; cv=none; b=pEanyEtYsclmc+nH9/zRqLS3vCCHJVD3OMpUyfnS718tYgm3rhVmE9fQDExpMY9zpOQhEua9ehsXKICZVNFzoKaTPjfE+B4g+wx7Akz9rqQvQAvleAikTbxMBg3L2PiqapKX/lN1QrOXRNR2Jwgxf5qKbOe2IkWlILlVGCbnOAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726311508; c=relaxed/simple;
	bh=6FU7I+36Vs4Ty1Rx4f/ad8Ea+XxLUpDl/B1613vDDkw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=eIp7ywo8vZAdSOdb00xR6PU7Yr6X7DmUF4IS2DI2wFBCkidegvQYPZQtYMoUusRYS83H+w6siVgCRJxJrDeerFN6cJ4yWb5RXQdd075gVCose7gPCpcGeDbnhzkUMJxZzkNp/BHd+arMl7NFqYYiPhL9gC20uTvquenFAxGxCu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-39d49576404so49879825ab.3
        for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 03:58:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726311506; x=1726916306;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lVuoLqGne9P1lyA2uxe9sfoWtm1gKn1KP1rP9poDOqc=;
        b=fYDtHJnnKfasPNYgEmBCj88ojSTn5uO6kcmxNMKY40nWPgKa8alo9HIoY6YaVZT2J9
         vIGMFY9w+ADX1ri6q4AK5c148HSz6yjPge839oUM/WsZo+Is+QxH5WxumWFHd4Q3B+UZ
         XfGL+NVRq81RoAh78+dWKBgCCuJGVVmw/xateM3RsqhZfsso/CgfJI+JO5+VWLs8atih
         txns7S0YkjWXUyQ1OoqV7XhoQnIAFg01N+1KYP+XahLYkhDRRCsGERIaX5ZUSjbpxEEo
         SVUz5zTllC9jhQ3aNYTXtI6Jsv0Mwv/I0+rAsqvUiE3mOuAiYFOigr8OJe7dHH6X0g3h
         TeYQ==
X-Gm-Message-State: AOJu0Yye9M7eoTDiDWKjDKv+Zli80RkSg9ZzJgfrcVBKt0f+TaaFEGH8
	Og8kBBSWfyq0az6trJSDF9VFwys7W1xDRuArfhdbYHpNFZ40GbglSRjMMqHWGy5Rc6erL7+nen/
	iOciNhQ0fV1ptB2OlaMH3WkwhEixSeMATLYjx9E0GgV6oFEONcu2q3H0=
X-Google-Smtp-Source: AGHT+IHzBsQojbp13wK6XmU9C7AZ9k813RygyDRi5OKXtOOvw2u+OuBRBiJUcfIBiNabCak5lb/wRNbX28H8fM2Z8ubJ6ni4kb9b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aa2:b0:3a0:9238:d43 with SMTP id
 e9e14a558f8ab-3a092380dd4mr22628925ab.12.1726311506208; Sat, 14 Sep 2024
 03:58:26 -0700 (PDT)
Date: Sat, 14 Sep 2024 03:58:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66e56c52.050a0220.3a9b1.0031.GAE@google.com>
Subject: [syzbot] Monthly usb report (Sep 2024)
From: syzbot <syzbot+listc92cdb9da74ba407482a@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello usb maintainers/developers,

This is a 31-day syzbot report for the usb subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/usb

During the period, 6 new issues were detected and 0 were fixed.
In total, 80 issues are still open and 351 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  3780    Yes   KMSAN: uninit-value in dib3000mb_attach (2)
                   https://syzkaller.appspot.com/bug?extid=c88fc0ebe0d5935c70da
<2>  3144    Yes   KASAN: slab-use-after-free Read in hdm_disconnect
                   https://syzkaller.appspot.com/bug?extid=916742d5d24f6c254761
<3>  2019    Yes   INFO: rcu detected stall in worker_thread (9)
                   https://syzkaller.appspot.com/bug?extid=225bfad78b079744fd5e
<4>  999     Yes   INFO: rcu detected stall in hub_event
                   https://syzkaller.appspot.com/bug?extid=ec5f884c4a135aa0dbb9
<5>  874     Yes   general protection fault in ir_raw_event_store_with_filter
                   https://syzkaller.appspot.com/bug?extid=34008406ee9a31b13c73
<6>  862     Yes   INFO: task hung in usb_get_descriptor (2)
                   https://syzkaller.appspot.com/bug?extid=e8db9d9e65feff8fa471
<7>  836     Yes   INFO: task hung in usbdev_open (2)
                   https://syzkaller.appspot.com/bug?extid=b73659f5bb96fac34820
<8>  652     Yes   INFO: task hung in hub_port_init (3)
                   https://syzkaller.appspot.com/bug?extid=b6f11035e572f08bc20f
<9>  515     Yes   INFO: rcu detected stall in corrupted (4)
                   https://syzkaller.appspot.com/bug?extid=aa7d098bd6fa788fae8e
<10> 478     Yes   INFO: rcu detected stall in syscall_exit_to_user_mode (2)
                   https://syzkaller.appspot.com/bug?extid=a68ef3b1f46bc3aced5c

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

