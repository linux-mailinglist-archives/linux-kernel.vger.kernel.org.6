Return-Path: <linux-kernel+bounces-422778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2A09D9E0D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 20:31:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B966286E4A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 19:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB941DED79;
	Tue, 26 Nov 2024 19:31:09 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2881AAD7
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 19:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732649469; cv=none; b=lVIF0g0itNCed0mG/cHYPlwV7zusPkBecI0aQn0QETj2zE5a/JRER2NM/Rskt3hzciJsx0SJXS/4DjQQ8jOmjT6Xn4nHhRFgZPM4HoHnSyWNgGbOQaRDlEOiHNtbaJ+FCBaMuw5g67d77V8zd9tBDoxad117dX0Gths+fcTVW3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732649469; c=relaxed/simple;
	bh=Z3Yh2qOY8Xtf+fmgZGJLC+IYmCMIWKkdvMJGsLFHuZw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ERpVOs/3fpqN4mj+C7AEEHYalLtu0xnLfuglHl9qzbJWAEwVBRevjnSn9SDFi7h0xKmjsZAZVS+B3bMlWOt4tkr/ET5TvtPML5jbvtLrhxY0NQgsQqnomd8snLbsoAAuIZJpcqMgDb0GpfSY7A2cp6WZDzl+ZlQeLf1zttZHCcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-83e5dd390bfso8280339f.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 11:31:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732649467; x=1733254267;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h3CcMyqh6Vw2D6UimFBh1G8vqaTzPY//H9G8tue85iE=;
        b=btyJZVg35hMxXdYPnlOIOSfGoBUkIFfOjuJZh7cDHUsmrdXFPQ4r2+2r2nvnLrp15X
         YS7VUCWtjnTLKf9h0EWnt4DkA1z9BSw1xx0l0EXQM6L2YU+GAAmPVJ3J9Zz6jdws8htE
         TSefhcI+Dy8AgI+3odmbbvBuRY6+p3RswJVufSs6qcqgubzFpReWlVtQyqShmAxyOsWA
         JayC6gX9oYSGaIB2s8WfNxCKbR7ON072C9t5TQqQGVStGoBMl5RGUZm+Eax5bSVEdtlY
         S9rCBdCICcRbxariUzXA9rSNTU2VcDRzezObb10spW37p7IkY7zHal5Y0QMf1JDsGUhf
         JteA==
X-Forwarded-Encrypted: i=1; AJvYcCV4TgXexs7MVWJfv6t11/91+zI/Hrui5WjmkKan/Gx4Uml736kTs98D/CjB5WVeVfJjQy5JlOiOaw8UvTI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvFYmLH1mO7EaXZgGAzj6lvouGnR/xGyQTrcPzhlGdFe/horSY
	G0UaZG5gGnsvrpOE+l3/IiVdYyCFz9yXCQotPWh4wgT1J0EhD/Y941F77k6oz6phLFIu/KrHv3D
	59g2lazQjycldWocqmpnzqhlwhk0hrff06XyDapaLQuutYka/52Q8ZXg=
X-Google-Smtp-Source: AGHT+IHhUJgZRn8cEIpq2ohKQAHuqvVvyaYASR0ayovJ4dSWmFjQUCv+4k3ANt4iU+F9hFQMh2aJBjwzb0csbO/dDix8+GQ6iwJg
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1745:b0:3a7:bcc5:9de3 with SMTP id
 e9e14a558f8ab-3a7c51ea413mr5332075ab.2.1732649467304; Tue, 26 Nov 2024
 11:31:07 -0800 (PST)
Date: Tue, 26 Nov 2024 11:31:07 -0800
In-Reply-To: <67461f7f.050a0220.1286eb.0021.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <674621fb.050a0220.21d33d.001e.GAE@google.com>
Subject: Re: [syzbot] [net?] general protection fault in modify_prefix_route
From: syzbot <syzbot+1de74b0794c40c8eb300@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	eric.dumazet@gmail.com, horms@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, thinker.li@gmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 5eb902b8e7193cdcb33242af0a56502e6b5206e9
Author: Kui-Feng Lee <thinker.li@gmail.com>
Date:   Thu Feb 8 22:06:51 2024 +0000

    net/ipv6: Remove expired routes with a separated list of routes.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17a90dc0580000
start commit:   7eef7e306d3c Merge tag 'for-6.13/dm-changes' of git://git...
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=14690dc0580000
console output: https://syzkaller.appspot.com/x/log.txt?x=10690dc0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3c44a32edb32752c
dashboard link: https://syzkaller.appspot.com/bug?extid=1de74b0794c40c8eb300
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=142375c0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=146f1530580000

Reported-by: syzbot+1de74b0794c40c8eb300@syzkaller.appspotmail.com
Fixes: 5eb902b8e719 ("net/ipv6: Remove expired routes with a separated list of routes.")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

