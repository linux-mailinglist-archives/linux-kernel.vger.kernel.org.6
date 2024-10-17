Return-Path: <linux-kernel+bounces-369977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD1C9A2523
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 16:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69EF9282044
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 14:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98FE1DE2DA;
	Thu, 17 Oct 2024 14:34:14 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3391DE4D7
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 14:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729175654; cv=none; b=uUiqNrPUoUYw1H+u3XgWzC+VKkBJzjmcZs9KXc/BcBwWiGnPZpwWJj+Hrgc/qPbciqLi3UY7kf+oFYnxAHdSGKMvyHXMYgiskEPqJ3k37GY7esy8i4O9iEvHpuz0B1H9wOdQhFsC/sgsR81kOEevJ9PsdcFhIwjUBCeLZNbbAL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729175654; c=relaxed/simple;
	bh=T0Ip+FOzeYhqCkmNDbKXV/OHsiIbIdeg6WqtREuf/p8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=QKkM7dkJVG2JkIPrVBLXsntEB9ChAnG+7NmENZEpCEaOBLRg2MDs4Hiqt3vPGC1FrC9w13RcTrE0aRBxtM+qmlOtzHhTxudnW6bzionqwJ2queV9/DapyFHGwuPjnvms8mKXP0ZrwH0oW+m2wAwonPBSp1OfYVJ0rzv8QQDiRmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-83aaea19f54so65737539f.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 07:34:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729175646; x=1729780446;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/N70uIQTRyv33t9hYOd1BlGE2STvs58guCHZZAOi0Qg=;
        b=Jga3nGRVZb5jOtnrYyVY0Yov8f8gC6lFbD335eqvHI4MAmi4ksa+mkzqHdr5FQYOYb
         oYAuDbwdkHpMfaVI1R37lIs9i3ZUp3cwHU0MzOAx4whh/2QeTiNZ9h6kK9cCld1m9irz
         /iIHEI1VN342eRWG4Bp6FDUPvgcQixzXZJ10Lc78+NErk4hkQ5s6dKbkQ41CzMQABKQU
         xlC/xhW0RD6J0TbcIWEg2G8gQ3s9cQK6Jqm80Ascf0KNEbmL1MNthsGZm1hDWjvNDDOI
         4TYK1QokO9OiLvGiI0JvRitZadbMVDswZ8rgx7Rj+PikXuN8Cg/sptcIc7cLY1gtGJ5X
         MxCQ==
X-Gm-Message-State: AOJu0Yxrvdqaga4yQ9N16v/Q0+Im6EVs5XVfSlMau9WVCgdNbsR8dbS4
	QV+SZv8uAPIOrQ40ZlNx0zn5BRKR+Gd4HHlAjbHBim1tqcGfma9iFqYVkd6xg1Z/+rX81uy6f97
	jrHRH95/wInERaE30DAdTCzt17vrTq5IJpoMONSvsmeBEUwQzekvMAIk=
X-Google-Smtp-Source: AGHT+IEP4piMjHjVsUVnl5l+s6rt9VsXH8CnY774Kov43xER7VmCOJn4Qk7dTnQQQpCAeIxcnNo9OBOksEyW/LnNG1X2KJpVCFo8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:17cc:b0:3a3:a5c5:38d8 with SMTP id
 e9e14a558f8ab-3a3e529d7e7mr25092225ab.3.1729175646487; Thu, 17 Oct 2024
 07:34:06 -0700 (PDT)
Date: Thu, 17 Oct 2024 07:34:06 -0700
In-Reply-To: <CAN=OONxnT_AnjoQQYFud9V-eH=2mLdx9P9p34jF5eVktEbcAaw@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6711205e.050a0220.d5849.002c.GAE@google.com>
Subject: Re: [syzbot] [jfs?] KASAN: null-ptr-deref Read in drop_buffers (3)
From: syzbot <syzbot+de1498ff3a934ac5e8b4@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, sarvesh20123@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+de1498ff3a934ac5e8b4@syzkaller.appspotmail.com
Tested-by: syzbot+de1498ff3a934ac5e8b4@syzkaller.appspotmail.com

Tested on:

commit:         c964ced7 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12441830580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cfbd94c114a3d407
dashboard link: https://syzkaller.appspot.com/bug?extid=de1498ff3a934ac5e8b4
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17e81830580000

Note: testing is done by a robot and is best-effort only.

