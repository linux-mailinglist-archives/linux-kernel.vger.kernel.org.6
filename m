Return-Path: <linux-kernel+bounces-263447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7978D93D5FE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 17:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34393286401
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 15:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A460917BB1F;
	Fri, 26 Jul 2024 15:23:04 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9847157A5B
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 15:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722007384; cv=none; b=BXS0iYfPYk01+zuaDJQvhfnm5AE7LqwXdPEnDid+pkpuPRRhAP5VD+NJ+KlDk4sxGEbIzaoWOw5ux1htFYePq06gvPWbAdOYPCN45mnBcrp4lXnnh+ZUuq80+y7mZw7xMPJ563VVheOJ3Yw2iV9gla8hEV3HQnKP7y87kQj74nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722007384; c=relaxed/simple;
	bh=qlp7+7AcQXwJaqTb943IHxf/RFYYalN4M2URRp77+tE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=exqRZDSCPhJtoK60qCWItglmhZH7/ttLydyqOk5IIYlDo6Oy8IMvv7AXiCVmzjqKpqxwrRUzyXjHF2qp/AJsG7S780TAt58IgfGPU14hNiivQpK5Z6JBf7Ws9K259dnHVY6kX/oH8PGLBJf7EuvpjG1sdnqQOA11VB3mulOX6kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7f66b3d69a8so182549339f.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 08:23:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722007382; x=1722612182;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wrSzqyiMZx4ozjypR+uiSnGPSDS1DfBLU8iYnkXnm8o=;
        b=C/iKT/JGoye11pXUIgXKgcHFDerBZEytZNUJ5gvaI94dOzsPK7AuZ6iJItqxkMEaKd
         oSJr5ExN700oEM8n8Lw+fvXdrnR/+Qwez1XG+vtK32hY61aj03Tp/ifKz7zs3mVtQCo1
         +i8+r1Mfjs5zK3Uw6BfoxqP4d0an+mHJe/+xhlX1VRuXxbz44nlYXyQ0xL9c38uRH1ax
         Rz1w6qLqmN+gRbEhd2QboVgOUI4oOq8z0dL17RlWHpWKTh/MB42QGxdJFQIyTmMcilxs
         4Z8IP5LaBTsiiJztPUYRTJJDxXF13RMwGOi5a9bJae+Ry05P3+gWBOsbt324+H2XPR8L
         e1eg==
X-Forwarded-Encrypted: i=1; AJvYcCXALISGBzi+woiiwP7eZqmEo5/E1g37H708+y9283ZxLyhk+xqKrgseak6lkuM/jFy5SmmjCN//7CEh0lS8Sn/fuNKHLb016lOzTABt
X-Gm-Message-State: AOJu0YwT37PaSYxihuF8fSBLoDg3PfSuUrxJZnB2oIRUoztQW+MoUu6z
	b1uwayvBbA4AgbpNSPlG2e4MYvIZuWueiBlFfwzZ9E87Af8s+Ql+tOIqNUsb8lU7GDiVpiFE/Oo
	E495rjCkyu9ylYfRy2i2V+fPGQyEpHydYXI3Vb2M2Z0Jk24Js7Rn5lVM=
X-Google-Smtp-Source: AGHT+IEitdjrvQfgUSlHI9A5b/o7wbVGbHXJfvr5OeY9BfiBEWaDu7+L2Zu4oFY+y+iyX8y9suRRcOHcvVDTWq93/LtY+DN37WYn
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4120:b0:4c0:9a3e:c24d with SMTP id
 8926c6da1cb9f-4c29b6da7acmr341864173.0.1722007382122; Fri, 26 Jul 2024
 08:23:02 -0700 (PDT)
Date: Fri, 26 Jul 2024 08:23:02 -0700
In-Reply-To: <000000000000b90a8e061e21d12f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004ff2dc061e281637@google.com>
Subject: Re: [syzbot] [f2fs?] WARNING in rcu_sync_dtor
From: syzbot <syzbot+20d7e439f76bbbd863a7@syzkaller.appspotmail.com>
To: brauner@kernel.org, chao@kernel.org, frank.li@vivo.com, jack@suse.cz, 
	jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit b62e71be2110d8b52bf5faf3c3ed7ca1a0c113a5
Author: Chao Yu <chao@kernel.org>
Date:   Sun Apr 23 15:49:15 2023 +0000

    f2fs: support errors=remount-ro|continue|panic mountoption

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=119745f1980000
start commit:   1722389b0d86 Merge tag 'net-6.11-rc1' of git://git.kernel...
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=139745f1980000
console output: https://syzkaller.appspot.com/x/log.txt?x=159745f1980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b698a1b2fcd7ef5f
dashboard link: https://syzkaller.appspot.com/bug?extid=20d7e439f76bbbd863a7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1237a1f1980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=115edac9980000

Reported-by: syzbot+20d7e439f76bbbd863a7@syzkaller.appspotmail.com
Fixes: b62e71be2110 ("f2fs: support errors=remount-ro|continue|panic mountoption")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

