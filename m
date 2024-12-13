Return-Path: <linux-kernel+bounces-444337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B61B9F04FB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 07:43:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BEB32827C2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 06:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9786218D64B;
	Fri, 13 Dec 2024 06:43:04 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C204918CC1C
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 06:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734072184; cv=none; b=ovbRDNUQrf7z/u0HxUT8SbtRkLBi8Sj4ksqwmHDAD+K9vOCSoiCYNp6U8cWgnD5GVOFc4AoNGQrIg2tMTQaEZ4aKzpMZWkwHmxAOu3eaT2UEUZ9UGH9MeB1aQkGmiT/11NnLcxxMNkqlmNAwdd6OC9TG1QbChMypDO+JpsL4Ork=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734072184; c=relaxed/simple;
	bh=VLePF9S7rVDUSwVk6uQ5L7i1mGXupDwz6glD2zHvwtM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=dx+DgcTjZzRCAPlDIPle1oNQgDELPqLmnPoPgviKyGXPp0z53yfMc2F6eFoF2Jtxnz5c0hv371PtwCjBwI9Qmp8Z8D4EGlYO1CX/ob7D7kXw203oWzg+trb/hvn3MRzDrjPtoQwJUHCs2aW7919vVchl4ps5WuiChBpTW83CUI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a9cc5c246bso14851265ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 22:43:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734072182; x=1734676982;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LZNloNTBBzvVn9dHzNDhBIezpwKVH3QvQganD60bjAU=;
        b=PCmFOqIUFq2rVaaevzw/NAyFVhnvAMlbDAzNJpg4l5smqRI6c3kE6ZlWIrjTVlXCFw
         qmIN+GRhwndGYNGp3eHd2uaBomnZrgZ9QaCzBrBhWJChOaVimxi0JYAGkpyn10Eb8Rjq
         PslbT4ANsHy2sbYlQ5g/5NVqJIPSIWv4KfCh7KOywmRJjBf7G1YTjCUSV/I9LZcv463I
         gMIUGP9upNr8kRiQjBoClMQnQdzt571ROhYvCuZnv+xhLOPSnt98noynO3WKwDSoDHH2
         vKWpnfQt3TRKBHpDzEb16SwYGgM6rupIJDCucqnOUx9HhXu5O9CajHQCzpF5wn257X4h
         7XKA==
X-Forwarded-Encrypted: i=1; AJvYcCVBv/W8f+v9N4N+0tO3pmtjmMX7ixYFpUS7BfF/AT+z3LzTwud7ff7QZ8l0kX1MA105h6NKYrzigmIuNV4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaZB1NYig+ZVQVmYR2t5Fejyjfga9REfuJrOPNT0vdqGOxR3Mm
	YYQj0/OYQyi2cdI9EL00ntIRQgpjSpc3WXJTJgbncnA1nPQSrIxLhf2k16eeprIlDLgvFWL0mbY
	ssK7DN4VbwrJwvs/GftoWf+Cz0XHp/XtU75+1GsQ7ateLv8CjPr7X0Fw=
X-Google-Smtp-Source: AGHT+IHX5wFpMY5vudI70KCTEuKr3oeK/7NogyKnkKlPpALk3VxdD3z62XiapBuseesr7rGWFEV7c0v3k2sJlcfddn2rm8BlPe7T
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c54a:0:b0:3a7:c5b1:a55f with SMTP id
 e9e14a558f8ab-3afef34cf79mr15203195ab.0.1734072182055; Thu, 12 Dec 2024
 22:43:02 -0800 (PST)
Date: Thu, 12 Dec 2024 22:43:02 -0800
In-Reply-To: <672dbff0.050a0220.69327.0002.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675bd776.050a0220.1a2d0d.0002.GAE@google.com>
Subject: Re: [syzbot] [ntfs3?] possible deadlock in mark_as_free_ex (2)
From: syzbot <syzbot+8df514c431bd240c5644@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 5fc982fe7eca9d0cf7b25832450ebd4f7c8e1c36
Author: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Date:   Thu Oct 10 17:09:24 2024 +0000

    fs/ntfs3: Fix case when unmarked clusters intersect with zone

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15a78730580000
start commit:   231825b2e1ff Revert "unicode: Don't special case ignorable..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17a78730580000
console output: https://syzkaller.appspot.com/x/log.txt?x=13a78730580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c7c9f223bfe8924e
dashboard link: https://syzkaller.appspot.com/bug?extid=8df514c431bd240c5644
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=128e6cdf980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1784b20f980000

Reported-by: syzbot+8df514c431bd240c5644@syzkaller.appspotmail.com
Fixes: 5fc982fe7eca ("fs/ntfs3: Fix case when unmarked clusters intersect with zone")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

