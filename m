Return-Path: <linux-kernel+bounces-327512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C8E977703
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 04:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21ADA1C24151
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 02:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8F81C2DBD;
	Fri, 13 Sep 2024 02:47:08 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E512A1D2
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 02:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726195627; cv=none; b=T1X7UcDH7JaH8ctTxzEuZY6c/99JCvZ1M/EyO6vNMcvfbsRB9CIAdRk4Vn3bUyg+8S9S/e8u3jdSiNoYQ+pNNMtAomOX4bcK1yUsqHS6oJsy1fbRy/WqF+Dx4C2kyOD+6+JQHZjhXQMBn8FphcTLI9q9KWgrE4Cqv45IgrdZpbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726195627; c=relaxed/simple;
	bh=Z+AyqT0z5slYEKR/EZ2b5K3PKfMdlKBQ0731BYcQt3A=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=fcIUiZNQO0UOLqlMeZZNxHBf3k18HkvVL7WamWNsOSYbs8kRBPTUK1lYDQXAyPFZOom+q+g0gnHLikfehJeRoEoQe5qDjM2a2/UVj0DUX1rU8gpFa287wVb0J8GYQYCxYcBCDTAhaefi8yewfbPJUIlekMTCWXDOuML2TNfRNoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a0862f232fso16394055ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 19:47:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726195625; x=1726800425;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j5Qalv+ZWwp2Crs5JzwNX67tlmsezDCid6fcSjz0QvE=;
        b=ruHzKDXZK1xer0YwdWktcM6AMc8kXAakUtgOZxEyZRoWtQKbbMrZz40knMXGbtWdt7
         wWXfHVHQyUnstZRbz4+xjO88YNKaWO8+5t3RrkAKWWLHRYaLOJKO2C54M6CsIJ0Jt8eH
         S09n+l1ht7L/OCFwPQh83dMFyrNJHqyi3BBbouQjOk8XwFMMGy97hCV/4L3AhA3PmiaZ
         PCueexi84OYwJXqh7ATd+SltLPBoUPULsVsEtEV/5PAq3cMHR/5vcJfbxQYlS9J5gQ5Z
         2WSfrzDJKExR+vR/vRUuDHEmCwFIVp+Iu3KMxpl5xLU4dyqk5FhLoYb5aVBSh+z6Xi/L
         l1VQ==
X-Forwarded-Encrypted: i=1; AJvYcCVj6U0yx/1Uj77fXeN2c3o0ACojVGuwTXomPmp6mhpwIAMqN6Mj+zhdPZEhEI8UsakuBH8/KBb9jJl4cV0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6RUSW7hvJp3+8hg56/GkGwCTU4FGL6aGamBQzDX2M7KHAAgGC
	SMRPQRtXXc5iLYWSALzVadzEAxiSvd/eq+G5DAITcHlvrfkv2apoqwUrxLqhGwc0hvOxZN+c/OC
	9kkn+/8llDWj08+Yh8IHO8a4VWepEhiH4MTNS82tNQ1f7s8XTGxv5/ic=
X-Google-Smtp-Source: AGHT+IEkrG2Iu5XrA50NNTPXn13N2q68OiqR/NLLBlttD34N2lXi2VTF7UO4K8Xa4NJ2uTiBsbsgwH6clMCr2/APZL4dOdtDl4v2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:190a:b0:39f:500e:2ffd with SMTP id
 e9e14a558f8ab-3a0849551bfmr54323305ab.19.1726195625465; Thu, 12 Sep 2024
 19:47:05 -0700 (PDT)
Date: Thu, 12 Sep 2024 19:47:05 -0700
In-Reply-To: <0000000000005348f9061ab8df82@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000011b0080621f73dd2@google.com>
Subject: Re: [syzbot] [net?] INFO: rcu detected stall in neigh_timer_handler (8)
From: syzbot <syzbot+5127feb52165f8ab165b@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, gregkh@linuxfoundation.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, marcello.bauer@9elements.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, stern@rowland.harvard.edu, 
	sylv@sylv.io, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 22f00812862564b314784167a89f27b444f82a46
Author: Alan Stern <stern@rowland.harvard.edu>
Date:   Fri Jun 14 01:30:43 2024 +0000

    USB: class: cdc-wdm: Fix CPU lockup caused by excessive log messages

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17eae0a9980000
start commit:   dc772f8237f9 Merge tag 'mm-hotfixes-stable-2024-06-07-15-2..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=333ebe38d43c42e2
dashboard link: https://syzkaller.appspot.com/bug?extid=5127feb52165f8ab165b
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17398dce980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=112fa5ac980000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: USB: class: cdc-wdm: Fix CPU lockup caused by excessive log messages

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

