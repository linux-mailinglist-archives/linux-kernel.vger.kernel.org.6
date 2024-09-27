Return-Path: <linux-kernel+bounces-341891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A51F9887D8
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 17:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 440E2281F55
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 15:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4B61C0DF9;
	Fri, 27 Sep 2024 15:02:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300AB8F5A
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 15:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727449325; cv=none; b=bPjB3yPRujbM5s5gp4vSYTE9OT2HSOvtsRbIsflWARFNG5RYBBq3g4C1SbG9PD1XfAcNmwD6mPMFBFj9AuO5wzP4fn+JGpKjzg+OvBcojCB+bNXIzmlhdTj2VL0ha8TWGdTMhsSrazXp53MVD3dYvkZhYTMyDfn5KLDqaPqC4V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727449325; c=relaxed/simple;
	bh=0AT9m0oItan6aRxTlZoqIat+Fh3lDlrpmv5EEtGHuRU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=GDHbo1wBt81Y5ZnWvdtxRU4u9/xRdiwLY128oKjMD7aQEXVPF1mCEvlRhAkvrH/S+1iA9dm1hjKfiAs7OFqW8xDWQUYXVl/qO+eG10u6vU+4nwgexZNToJleFkBKYOZTsGCvYX4SlgeiHNhihRn+eP+08snxSW9TktQw+JRBOic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-82cda2c8997so283516939f.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 08:02:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727449323; x=1728054123;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gH414nO6zVibL0PTmWE3cI6els9/sncR6gGH6gSpCCE=;
        b=UyCVAETqeY9NP0yoYPEd77yBX8gcRwAhRWEUMG2//jgE5nOjQqvoYZtA/6sYWrTAr9
         696AduRS/QLYnpO0gsGUL2DseDH4poQqf8kQI/f934yJszLV964yQ+ZcLcHHgtB3D2en
         khsjhodmOgdoVeBEg3L9zcl578MSN75d/hYwxRQL6TMQnmatA2TxkyJZrkA36FwmcvGZ
         0H0JwBnrZg6cEn6+uUhBCvIsWKYFHIcmpxSJSjN1lG4HHgIPw0mkgm6MgkvlDlplVdNd
         K+Cp0rJ24uxjaqUi2F6lPYLRetP6BJeYJU2hg1mhVxNrEZvUMUaV//SE5jR7B1kp6nHr
         3+GA==
X-Gm-Message-State: AOJu0YxU+UD+mtArv3fzrs4wtHizxXFZEMXr2KgV12W17iPTxf9LHxPc
	PabdOGbtzmUdfmjA+GJxRWRUX6+yG0QScYTpek9vwLw7kP37OVPJX5yMpbdM37hpgBF3KyKCNBS
	0n96661MbLFtQ5LcJ8iAz70Y0JP2pW4At0G6G1/K8B9DI6JDPFu52eik=
X-Google-Smtp-Source: AGHT+IFNlYVQDYl/M9jcfN/xTEj2JhuQFuh93zbWux+H06W+JPh9BOgkRfYy2rXJy6ff0FhI7zJgOQBXhitrEpxjV8cooh0bkYH9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1562:b0:3a0:a224:eb3a with SMTP id
 e9e14a558f8ab-3a3451650famr33480775ab.6.1727449323217; Fri, 27 Sep 2024
 08:02:03 -0700 (PDT)
Date: Fri, 27 Sep 2024 08:02:03 -0700
In-Reply-To: <20240927144200.2402128-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f6c8eb.050a0220.38ace9.0028.GAE@google.com>
Subject: Re: [syzbot] [squashfs?] possible deadlock in fsnotify_destroy_mark
From: syzbot <syzbot+c679f13773f295d2da53@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+c679f13773f295d2da53@syzkaller.appspotmail.com
Tested-by: syzbot+c679f13773f295d2da53@syzkaller.appspotmail.com

Tested on:

commit:         075dbe9f Merge tag 'soc-ep93xx-dt-6.12' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=116d5e27980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5f49dd07427b3bf8
dashboard link: https://syzkaller.appspot.com/bug?extid=c679f13773f295d2da53
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=125c959f980000

Note: testing is done by a robot and is best-effort only.

