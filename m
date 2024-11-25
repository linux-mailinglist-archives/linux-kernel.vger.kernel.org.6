Return-Path: <linux-kernel+bounces-420930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 009049D847A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 12:30:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA48428786F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 11:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96740199947;
	Mon, 25 Nov 2024 11:30:05 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B8B186294
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 11:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732534205; cv=none; b=AlYg/X32ldbW1yiEe/m4vk9MsrKxOJOA98Zp5QM7yH1gc3GMxC6JjC2hEALwJ0Mwy9grUXjXikHqmSO5jUPNO7BcFb7s+kn2gF/QKnjenkaTDCD6ARNdL7Xhsbnpd/aWOtTitj2IBdcUSRPOJQZsMQtvP5rI8rWqplPahZw7TJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732534205; c=relaxed/simple;
	bh=ICHCbrzwtzX5WoXiFrU5K0CKA/+UcGu1uL8e4qhnC/4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=mTKOJGRlZohCnpm3pwVIANGuR+J2afVwTej+MPDTC+iY3cb/C6tD2lQEyMmV9sPhGh3DtCcLQ0qEfNrn7S8YBiN+hB9ge3802esya9PnLcMBvLXAtUm6sAmwR/1HZ+w+QU7V8ExCinQQqRhK0ws/x3jm/1kAJQ/mEr0zSBYn0yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-841843a9970so113674139f.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 03:30:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732534203; x=1733139003;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hy9JYi0xiCmZo9Y6IW6hmnOwU7Z6Pz/+nyr8wGUguNo=;
        b=nVTw9Zoh8FLZpT602+erKNrnUYyDnIc54iYiM6oC02i8r9mX98WRFxPxxOPdrgG6ls
         kobrfFuitnLZSxIk/rZkGDwUuF01D1VJfQpUw4P7nc/yuURc3At4hVzK+7Qxv4eYo3y/
         N9LlEFyp6565PTV5xP3B7iStb2SNgdpY3Tb09oO2dvWhcktSluMQgF8sXEy+A4vn0jco
         NNMXPpuiK33Cgh9ot14eKdj2V9rv6hvIYqcLOzO9STX+ScRyNpVYwzi8rEBvsgaXMYWP
         RytGqw3WVquwRtOmrSSFGkyOp9/qoqrOTLiHSZPCjVHvtnyhXSAH60rx0xRKWrSAz2Sd
         Us5g==
X-Forwarded-Encrypted: i=1; AJvYcCXPEZBX/roHuOo1gOJKsV2/gZACh15VoHpsbjG+2baEKynOY5c8YZGkJk3W1KJY1AO/MOGQZV94rGtIgj4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSYU+FefEOzD4NBwzMjrYVtDb364dKtZiRhyW50sT0tJ7AnkOl
	Jz4msQdY1bLw6yvEB9zYW/W0glcWzVno7IJgEERpIxOQb2QREBKUtNovbCqrxenyc8L/LKpyJPY
	S+bcNmr/M967a7KO9L7xQZhijIPw7QXTV2hBvl8nSfF74kYTGCjw2tGE=
X-Google-Smtp-Source: AGHT+IHgbIdGmzlwzkUbredCvt6hMXFV9IvreNknHrTgMRRtYGk0sW67a4h1dLCTt1oqS3vbSiPjC8ZmM/IKXJbqW/UXMNsxOIM8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:184a:b0:3a0:915d:a4a7 with SMTP id
 e9e14a558f8ab-3a79ad10db6mr129531615ab.2.1732534202990; Mon, 25 Nov 2024
 03:30:02 -0800 (PST)
Date: Mon, 25 Nov 2024 03:30:02 -0800
In-Reply-To: <00000000000009ff2e061ce633d7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67445fba.050a0220.1cc393.0078.GAE@google.com>
Subject: Re: [syzbot] [net?] possible deadlock in ip_mroute_setsockopt
From: syzbot <syzbot+e227429f6fa77945d7e4@syzkaller.appspotmail.com>
To: alibuda@linux.alibaba.com, davem@davemloft.net, dsahern@kernel.org, 
	dust.li@linux.alibaba.com, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, schnelle@linux.ibm.com, syzkaller-bugs@googlegroups.com, 
	wenjia@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit d25a92ccae6bed02327b63d138e12e7806830f78
Author: D. Wythe <alibuda@linux.alibaba.com>
Date:   Thu Jun 13 18:00:30 2024 +0000

    net/smc: Introduce IPPROTO_SMC

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15fc6530580000
start commit:   fcc79e1714e8 Merge tag 'net-next-6.13' of git://git.kernel..
git tree:       net-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17fc6530580000
console output: https://syzkaller.appspot.com/x/log.txt?x=13fc6530580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=275de99a754927af
dashboard link: https://syzkaller.appspot.com/bug?extid=e227429f6fa77945d7e4
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=175459c0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10dc0ee8580000

Reported-by: syzbot+e227429f6fa77945d7e4@syzkaller.appspotmail.com
Fixes: d25a92ccae6b ("net/smc: Introduce IPPROTO_SMC")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

