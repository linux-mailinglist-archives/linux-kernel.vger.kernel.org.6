Return-Path: <linux-kernel+bounces-175282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6345D8C1D8E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 07:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E73F8283710
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 05:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66C914D716;
	Fri, 10 May 2024 05:08:06 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE5020309
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 05:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715317686; cv=none; b=VBILn3WDVD0WPHlc0TIpBsetgwWPf0AVw9/MvCJTNSpd0nHZ6MI5/RtQyo5JBCMtzQKm3mJO67zSNesBrMNKSuXlZLnVKpZfc5xJYYh3DeNENO1kUlk3OaYnd4MEVHMp+Ge8XICLgtVSbKXvYtr9bS6WFPsAWDEu5bNlwWn3In4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715317686; c=relaxed/simple;
	bh=Pqy5lmmcw0oAX8mFgZ9RrdJ5pDBFdd8DQ9gUz5hvWO0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=D1mmP1zjFrRW5RlU/0Ix2U3j663sswJMFsPxGK8z9ABlwzzBSMwIvhWmZY7JripkgZOFKRQuLLRb/KHleYxYBB/o5gv4xSPTyRVywAJ6B45G+owo5f3XRwS8hgCLiQL3rVd1+0F2FVilHbB4IVj79tD6P1Fi6iKxKZLRSqicgsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7da52a99cbdso158989339f.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 22:08:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715317684; x=1715922484;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AEYzaVFxClHnzclCpBQe8wBmRudx65WCcAHd23Nvkgw=;
        b=uWRlu21D9lIOZYCQbeQELreFdoBPUNlVAsvv1T2WlZ71gsQpdjBE4xg513kigVcC4G
         JNGZliJjUsnMVnR4GvySwMxn6mc4R8Gx+FkGhtffDKHfgndce3XCXPAjYGU9gHHLm0Dt
         QvkaS9mLr9nSYAi3e+5qWk8VXLHB4bXNjbrJMVDRKx5H6i3sOezX7D8Pqqv7bR1pMx24
         j9lvE0u11NctZpDPD+VU9LuNUyiIgovKCZ3qorRiSsSAphOZPAFXfxW+q7TE+KLjyE/b
         OTUE7tXdIR5FOkUDjJEysYmqt3j0TIjOPULzjtzj7qQjY91dIXK15X0fo0jsxwBCYA2i
         SadA==
X-Forwarded-Encrypted: i=1; AJvYcCUSJiNBMWBGcSnbR9+AdtOMU59fnqCk9lSD0zUQtlmMERtT3etgnhD8jmigDCo7ohxsAEqq2/7m3Mkf1TjSojuAr6SXu0L6qud6HBbd
X-Gm-Message-State: AOJu0Yy/z1Iahc/lNtYjfkmfyMqd301kynm28nDI5E5xeeZWT5Ds7yoU
	SrsAmHbwQcK7Dlh1Uz7Vi0UJyAov+Y9jzjyY5GR4dQ9zzyRGhnWxLV9TvndMiUWoEtc7v1Y7O54
	w7McubHK6YobKYChGqXltAv2X0cAojNWhsFiuXQtk9ZqpSxbnD/zIljE=
X-Google-Smtp-Source: AGHT+IFy+SsvaSHRdbnflxzcQlgQCYz3IBbSgJxxHgkxgGzAV6KjiLv7yNcYRq+cK8DyyZtxlQZrgTbjP3aFM1U+sIF0b5l10DXH
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:608c:b0:7de:3f44:a6fe with SMTP id
 ca18e2360f4ac-7e1b519cfb4mr4772039f.1.1715317684278; Thu, 09 May 2024
 22:08:04 -0700 (PDT)
Date: Thu, 09 May 2024 22:08:04 -0700
In-Reply-To: <000000000000611ffc061800de0d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003fa9d106181285ed@google.com>
Subject: Re: [syzbot] [bcachefs?] kernel BUG in __journal_res_get
From: syzbot <syzbot+c60cd352aedb109528bf@syzkaller.appspotmail.com>
To: bfoster@redhat.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 2d02bfb01b2743da06748ba396ff7da4425488ef
Author: Kent Overstreet <kent.overstreet@linux.dev>
Date:   Fri Jan 5 19:17:57 2024 +0000

    bcachefs: improve validate_bset_keys()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1232e998980000
start commit:   45db3ab70092 Merge tag '6.9-rc7-ksmbd-fixes' of git://git...
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1132e998980000
console output: https://syzkaller.appspot.com/x/log.txt?x=1632e998980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9d7ea7de0cb32587
dashboard link: https://syzkaller.appspot.com/bug?extid=c60cd352aedb109528bf
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15b795a8980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17592c00980000

Reported-by: syzbot+c60cd352aedb109528bf@syzkaller.appspotmail.com
Fixes: 2d02bfb01b27 ("bcachefs: improve validate_bset_keys()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

