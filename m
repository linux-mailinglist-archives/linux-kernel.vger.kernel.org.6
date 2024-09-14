Return-Path: <linux-kernel+bounces-329233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C610978EFA
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 09:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4707A1F242F0
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 07:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB29513BC3F;
	Sat, 14 Sep 2024 07:53:04 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34ABC13A257
	for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 07:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726300384; cv=none; b=aLqCHabwRqkH8JjOkezMW1geCFJudFCgNWrhJzmiLTPPcuEYwz6Y+/hos8QL76k5xpc7JgLp0LdJeAZGOGh6szak5DpaRxE4jeTeA3ctd9bxWQAV55BEFFjkroaZKVMhtwu3d8DrIAHMjTtSYJcfLHqL3hyokppBtFlLDTSaDw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726300384; c=relaxed/simple;
	bh=kYrcfGqyI9UWqVgfDl8JjHC+PQmcip52vOqz4ExrGq8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=nbjXnuE1k8gi21WEl/N89VutkI96Y6iItkvHzVFxNydYrc0SdvkJnaDRbQx+bbOF2dEMRfBRNyachwKKAHbXVvXEHDwd3SOCJWZkgGwYCjfKNJEa1zjb4Gv+Mjf31F3xR3pYTSaXEHxaAzgs6yszIs13h7aWUVgc0uqFpG2dDCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-39f5605c674so41195695ab.3
        for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 00:53:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726300382; x=1726905182;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TBh4u3skwGtSv3GL/wDNzy7yp1jEN3S+V/wuQDqlikA=;
        b=JmOdPep0Y+fsJ9dlkh9lJz9BZfjMo/E/LASnGlZ1CzPS7KL9i4wR18u6OesELDXvnm
         BX9zEcy+gP50GrVcN2TwG3/yH4qdjKm9o0Us4wneXrVxFFf71i40IMM+vowx0H4vSC4+
         XF3+lhEwG0IShyOz4l+oHjlPXxYzHPQRO9b94BdkqLG6f0PdTdkmzQdpGKEispl4bg+i
         JlXg8SfhzgjiAGbn9SEE9Sp7H+pkZhExnf47qR/alCXv3/q7lSLPMxCyIDio9iZyCzVj
         vIfFccFwfFqZSc0eqaYTjD2p/lYeQABFibpNWr6MNbt7GT6hjL2o41tb7m/vDoKRY4Be
         H/gw==
X-Forwarded-Encrypted: i=1; AJvYcCWJqp1spjbRorV1PztnKfarD1pr4/OHLp3wqx0EyOK96bIjslEZ/yk7xRnLR+aAwUHvWUHrD5bxDdoumnA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw4djuYdW5dizhfX+8iP9ZKTgY1NaskT+kFRmuKx0sG1JwH2mN
	5hC+8m9x/HvBYJm4kvg2wyroAMEA0yvigM6oHHw3h1q4i8g35I87AKb+CiGxFIHfGqMrjpxcKXG
	LO5T5eNcNudEeYyvOzXpJMzAJD96zRvf7YCIgEUJBAjg8uQKmiiK99FM=
X-Google-Smtp-Source: AGHT+IEilAHp69i8GKZ0aEbebAOEzDE2jEWi+Isl/7f3TMAf601houOnWWM7jwutZZkAMOjwOs1+fGn2OYwSntljErZp6dAsZHow
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1e0a:b0:3a0:4d6b:42f7 with SMTP id
 e9e14a558f8ab-3a08b79a1a2mr58094615ab.22.1726300382397; Sat, 14 Sep 2024
 00:53:02 -0700 (PDT)
Date: Sat, 14 Sep 2024 00:53:02 -0700
In-Reply-To: <000000000000e28810061fb68dd0@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66e540de.050a0220.175489.0002.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] possible deadlock in ocfs2_get_system_file_inode
From: syzbot <syzbot+e0055ea09f1f5e6fabdd@syzkaller.appspotmail.com>
To: elic@nvidia.com, jasowang@redhat.com, jlbec@evilplan.org, 
	joseph.qi@linux.alibaba.com, linux-kernel@vger.kernel.org, mark@fasheh.com, 
	mst@redhat.com, ocfs2-devel@lists.linux.dev, ocfs2-devel@oss.oracle.com, 
	parav@nvidia.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit a3c06ae158dd6fa8336157c31d9234689d068d02
Author: Parav Pandit <parav@nvidia.com>
Date:   Tue Jan 5 10:32:03 2021 +0000

    vdpa_sim_net: Add support for user supported devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17ea8407980000
start commit:   196145c606d0 Merge tag 'clk-fixes-for-linus' of git://git...
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=141a8407980000
console output: https://syzkaller.appspot.com/x/log.txt?x=101a8407980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1c9e296880039df9
dashboard link: https://syzkaller.appspot.com/bug?extid=e0055ea09f1f5e6fabdd
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16fdd49f980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13f5a7c7980000

Reported-by: syzbot+e0055ea09f1f5e6fabdd@syzkaller.appspotmail.com
Fixes: a3c06ae158dd ("vdpa_sim_net: Add support for user supported devices")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

