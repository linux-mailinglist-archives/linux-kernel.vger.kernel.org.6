Return-Path: <linux-kernel+bounces-518227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F7BA38BBD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 19:58:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6552F189416F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 18:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2838B236457;
	Mon, 17 Feb 2025 18:58:08 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE3D137C35
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 18:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739818687; cv=none; b=tj4ogcStxwhEELP+zhv1gkzyIpYO1e3C1gv26K2if0nSoTECSM6Gkwpgx9D8DlUDgPryT+kyf7cTdUKkwPbR8ya7j3N+TiVcuASXPcg9nnMS/p3yi910hgUomx74LJ6DcEMNRUTu753TN0pHRo8c6PxjI3ZNR077Zr6Kz0qxEmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739818687; c=relaxed/simple;
	bh=YDqps0J4C1dQJWutldi+uXtzFj/5V5pzZ9Ss6hAUGkY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=PsK8vOrUqt5WoVIA6QlGNpCGByan0B1ZZwuDAoKpnHTyiFQjvyW/+elJnPDdnGLhq+mJiqRcvQXL2gpUs6bVAnF3WwA7/BuCiIxfck5reobUGgpQbhu/0bCIkO3uxjWyzXHmOoYiAOW4MsAbJ3KhG8qFYjUNAynqZKsIWsQIygU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3d2a1d674a2so9127825ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 10:58:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739818685; x=1740423485;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v4TvGlUsNtGo4unWeNBOP3y9zaLBmcNgQQFAijZv/sA=;
        b=mmNDdqK7yljYjI9GDpsOcKRVHn4lDo4dSDRJgYINhOm0nobkPFtSS8KyKy4y4o/s5c
         hQUP0o216gRwvAyh6932C2jX/2LtRjhxRdWJ1B3uFfIMDF/ZlV2n0HZTcw2RGamilceB
         NucedbHcydUT0j/xA38H9r8dDsRha5/yoGlr3mWAiz5uyPLXDUtl+AguWfDfF4Bq1BPv
         HlTf/ZpgPU+/uivYHIcZjeo2bYL7w8r/gbfmB/v7w0LW8odM1MQrwUGgyfFQZSoIiLgn
         gkXKmNhCQ9y/1ak0I2NigbjdPpd9GHpAu1JolZu6xFOUsP+zXV0RoAhU+J9fPzxTMLmX
         AOVw==
X-Gm-Message-State: AOJu0YzWDMhMxX83wsaOZ/jzE5DKR2S3DZ5j0x0Eu4CRL2LKVRem/am4
	s5Dj+d0+uY+UpO/nnglp/+a7KRDiiC3kmGLomDeJL+0/Q2fsI2slHhUfB18KaZrdnVJDhzoVmOa
	SibmPAOJE2SYT1xwr641ac1CjTibSeZCv8vpAfD62kxvOF0uBiFI5Fzs=
X-Google-Smtp-Source: AGHT+IHRQyPrWfvZLwv7BHw6Q+oJxKURK+13fKCpMGyU+C/5mUWpmp9BlMV2oK13cYC9UdGFJ2ZqfWzOI1NaxGWdEzy0JYaW9DGo
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a4d:b0:3d0:4a82:3f43 with SMTP id
 e9e14a558f8ab-3d28078e655mr91748005ab.5.1739818685539; Mon, 17 Feb 2025
 10:58:05 -0800 (PST)
Date: Mon, 17 Feb 2025 10:58:05 -0800
In-Reply-To: <20250217181634.343035-1-zoo868e@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67b386bd.050a0220.173698.003c.GAE@google.com>
Subject: Re: [syzbot] [can?] WARNING in ucan_probe
From: syzbot <syzbot+d7d8c418e8317899e88c@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	zoo868e@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+d7d8c418e8317899e88c@syzkaller.appspotmail.com
Tested-by: syzbot+d7d8c418e8317899e88c@syzkaller.appspotmail.com

Tested on:

commit:         0ad2507d Linux 6.14-rc3
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11723bf8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b7bde34acd8f53b1
dashboard link: https://syzkaller.appspot.com/bug?extid=d7d8c418e8317899e88c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=160f75a4580000

Note: testing is done by a robot and is best-effort only.

