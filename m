Return-Path: <linux-kernel+bounces-362571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C62A99B686
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 20:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BF471C2112A
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 18:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399D115252D;
	Sat, 12 Oct 2024 18:00:07 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A5312EBE1
	for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 18:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728756006; cv=none; b=HmqPq6Jo5O1OFghEgOYFVG0J0o6e+kvNFs36jpQ97RIFSIzOBoxfxaju5vhwKGWUj9ZcIqX3F63xCCtsffeXImR8zcSz16/N7N1ZmGGspNtmsBFkmlgLPkjyVkPtHiW5e51nlfru7FLWk69EgTDfANa+Gxajc8ANZi1h8fpDZ4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728756006; c=relaxed/simple;
	bh=8hHt5+iGh39sjPHzAaTebYzs9NAavjCpggn19QT5Ygg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=cRBmt+sfAvbE5peELkxyvZevzRI/vYX08tGOKpNEUbWwdCq09VjTFUVDK2029yidZ9H6L83hP93rhWnwEow6xW2tsZMaLzsHa5Ca3LyrvtEyA2PuFPpy9Jvia0sDpIz4Ivp9ZnCGxFD/MP9tYu9e7yq6yoypDQCokQ7ZcaQ+eng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a34988d6b4so48077905ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 12 Oct 2024 11:00:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728756003; x=1729360803;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L47wACq13635XdZjofeiVNe4JkOgqBJXEN4PIFmbHa4=;
        b=guomL11/v8V+QYiP5bkj2nhKuPq7LcEXAou2cuVzlUhspgQBFqlM8sRYAI5n1evsCl
         /FpUFltFKJAhSKktcPoF1gPrKaVI/HdTHxqBvdqg0rDUN5EAGaOOaUkZNYZpHTu5GlmJ
         ZwUCGAQprLfjO5o0xiBVBAHg0Tau+mBlbL/q6RvQUG3lQm2l1nFlsjUfzOpn6SGgE5LB
         dIx05Tv9P7iFVIaJWtHYe7fkFqGJkt6fp/jM3AMiAR4SFXbW6Q1IDz+/ntDBYqr+su22
         e2YAzGtzRMWtpg85slrMu89LEts3IPLfRWJJDnUEfLUmi3ufAn7UQ4S0IWf45QMKpOi4
         YeQw==
X-Forwarded-Encrypted: i=1; AJvYcCUb+WvA6b/gdLddoVLu8duU16bOSKvakQCn/D+4hKXmLbVJn3GZZKxgdboZfrMgW/u0pudVyNAsjMwR1Y0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb6gzNFkUr8QG5G1rIVkiq8sIk7ae5ueK/p78Rg1AK4RYj3bLF
	nEbeI2KnaWb9lZgSAYk0yhgRX0NguR+RYVRrN0AzxDm97yzmMyqNWC4p/JEBgLYwV/S09SiWuqb
	4p0Airw7/Ujex/9eqOpaOQGx0pfPUQzhFFQWzcfa85R7lVIirIECys3I=
X-Google-Smtp-Source: AGHT+IG6LjZwaZf0PkapF36b7e6PJiIgY1UV/fM3a8Ux0q94gT0tk4EZeblrJM6H9JkIA5LDTwp2w+HCtPmT7M+vjB39+784nixA
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cdad:0:b0:3a1:a20f:c09c with SMTP id
 e9e14a558f8ab-3a3bce0b1e1mr28399625ab.22.1728756003623; Sat, 12 Oct 2024
 11:00:03 -0700 (PDT)
Date: Sat, 12 Oct 2024 11:00:03 -0700
In-Reply-To: <ZwqEijEvP7tGGZtW@fedora>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670ab923.050a0220.3e960.0029.GAE@google.com>
Subject: Re: [syzbot] [net?] [nfc?] KMSAN: uninit-value in nci_ntf_packet (3)
From: syzbot <syzbot+3f8fa0edaa75710cd66e@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, krzk@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	qianqiang.liu@163.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+3f8fa0edaa75710cd66e@syzkaller.appspotmail.com
Tested-by: syzbot+3f8fa0edaa75710cd66e@syzkaller.appspotmail.com

Tested on:

commit:         7234e2ea Merge tag 'scsi-fixes' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11b63fd0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=981fe2ff8a1e457a
dashboard link: https://syzkaller.appspot.com/bug?extid=3f8fa0edaa75710cd66e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14f87b27980000

Note: testing is done by a robot and is best-effort only.

