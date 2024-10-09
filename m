Return-Path: <linux-kernel+bounces-356451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC4C99614C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 09:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E25C12855A0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 07:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61189187861;
	Wed,  9 Oct 2024 07:44:06 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E20C186E27
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 07:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728459846; cv=none; b=ET7HEcIl862FBnlFlAbHGw/pp85MRQM+1IBs43ORoqqsPPQXadFHBug2Ey6cYOUYmSAtUvHc4t59mJBYeLUsVNYFF6QTkOrqJrDAZCSVstA74zqOdK9TdZhbZHOB9SYL/KkAfhNu2yrr9Aof5nBex8iGBrzR6qkOQzZxOwPXcpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728459846; c=relaxed/simple;
	bh=vro3Bbe+8hKP1n1pXWEdxEnFJNKRiv0zk1QHqAcZZkw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=e/rx2rEl+x8OR/w+79HBL655IATDXg6rox0GqihKZ7a3blxsvtOYG8/hNXF0GiTix0s/aYVeXXhDsGvSNdQ3ZvEtlcdxRvdWB60yMe0QGjjn+zRXM+rjzvqpP4CiSmujBExtFC0jZZnniLeuwLYlnJ5UCUnQCrY+z1LyEOAj2zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a342e872a7so68304475ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 00:44:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728459843; x=1729064643;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/cIM4FzGaC91vtdSI5kp+oxCUFiOwgoAfMBzSugYPic=;
        b=OYIVZPst9/XnAqcPc2pzr0+PvB4dsfwOlX3Df6JZCaDM4wexlLcsQtCjU3UgGJW2o9
         jyHflxneN8GcrZTo9t3iZVVEv4NBl953M9sSGG2G3VDWZprQO+XS87EKAJVbrGO8o36l
         bKcgu6dcHOhUjPDg9siOCgj4YG/xzEpmrVxIxYNZun9U2AGf+RdY3hX8NvAECHcLagkp
         HsTWtHn3FOO0HLPgGWAWPu2UpWrw5eTZUpPi5ZIHEDM0618wHuvsgkkiswJe6PjPMi0W
         epyEzWxqMITZ2AXCYVDJ9mgMtzIQqsxfveBS1dkhB04MQJaToHqrw4oyQ4pxgv0JSN29
         12rA==
X-Forwarded-Encrypted: i=1; AJvYcCXyqwYVXqXRfpsh9lkgpSxW/S2rtw2ev7K4Y37edYhK+jRP7dt9fffzuMwIWCUrpC9YtUcz/k0CksOQE0E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxfw9VhwSQGLAg56nEnbLUpek+agAqBxp61xW+L2l0UPvgCZsiP
	Y/1oP9gOsaWjsfB0Gz203dD7373FYe7qYIHiOGOiySwXpxJA5xbXDjO0XeoW+rGo3B2fZX1uKon
	PLZ9SxY6PF7eb3EU7ihKSMDc+ZRbhkjjIjvWEKW4VsixMswNmPK+5ZhU=
X-Google-Smtp-Source: AGHT+IGQUQlE1emHK5BMoVHftqjMHMKZ9WzpGESuX/WJupIlx748u5PWWxzaIpPs7tVEVvN3RxleI5Ir+epplxZsh4OdZn5wVcaV
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:152b:b0:3a2:463f:fd9e with SMTP id
 e9e14a558f8ab-3a397ce4910mr11518575ab.6.1728459843585; Wed, 09 Oct 2024
 00:44:03 -0700 (PDT)
Date: Wed, 09 Oct 2024 00:44:03 -0700
In-Reply-To: <66fa2708.050a0220.aab67.0025.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67063443.050a0220.22840d.000f.GAE@google.com>
Subject: Re: [syzbot] [wireguard?] INFO: task hung in wg_destruct (2)
From: syzbot <syzbot+7da6c19dc528c2ebc612@syzkaller.appspotmail.com>
To: Jason@zx2c4.com, bsegall@google.com, davem@davemloft.net, 
	dietmar.eggemann@arm.com, dsahern@kernel.org, edumazet@google.com, 
	jason@zx2c4.com, juri.lelli@redhat.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, mgorman@suse.de, mingo@redhat.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, peterz@infradead.org, 
	rostedt@goodmis.org, syzkaller-bugs@googlegroups.com, 
	vincent.guittot@linaro.org, vschneid@redhat.com, wireguard@lists.zx2c4.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit dfa0a574cbc47bfd5f8985f74c8ea003a37fa078
Author: Peter Zijlstra <peterz@infradead.org>
Date:   Wed Jun 5 10:09:11 2024 +0000

    sched/uclamg: Handle delayed dequeue

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13c2d7d0580000
start commit:   e32cde8d2bd7 Merge tag 'sched_ext-for-6.12-rc1-fixes-1' of..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1022d7d0580000
console output: https://syzkaller.appspot.com/x/log.txt?x=17c2d7d0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=286b31f2cf1c36b5
dashboard link: https://syzkaller.appspot.com/bug?extid=7da6c19dc528c2ebc612
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=146ae580580000

Reported-by: syzbot+7da6c19dc528c2ebc612@syzkaller.appspotmail.com
Fixes: dfa0a574cbc4 ("sched/uclamg: Handle delayed dequeue")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

