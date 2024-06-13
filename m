Return-Path: <linux-kernel+bounces-212648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F3B4906451
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 08:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A4C4B23A36
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 06:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E95137C22;
	Thu, 13 Jun 2024 06:46:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989DE2F30
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 06:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718261165; cv=none; b=cXJNWW3nL8Kk8o8wPt+4Q85pWoCMdssUsJLF0E1hMFFOw6ol7cx56+KDZEq0GnmrUVJS2Y6TQgOsPSYm475T/y0ODnB4eGarSUXep31Oc91Pyp+alQvnyq9et6S+EQbnI9fJvwSE5JrPkP/eGxPrE9uhsbnHSsTb9E3rG7dwkFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718261165; c=relaxed/simple;
	bh=32IH8KSlXm2ko3meyXugpk3LSb+VUtidUqO+72/WiBo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=l7vLCU2R4UmlP5lfb/T+eCyAn72Bk25xfjZ0rviULgcMqGgn924J57dDAr8u/jJ8/BSYhLpOfxZE4MoW6R7OyNe9iciN5Afs5qJiR7AT3o7iihSKjGxfRWvZBc3tb1D5JLZT5ftcJ4jTGmnQpODQJVVZJSwZknbS04rU92pRDhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7e8e2ea7b4bso64047839f.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 23:46:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718261163; x=1718865963;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2xgF8ibcEaldCk43yXegeJSCV4DTuCuF5ATotbVCUuQ=;
        b=scoYrK8eyMZwCc3v1CZXklEpLBEWGo7q5caElPgnOlVlKQQUzJTRwoHxzTAdnY//8B
         5Lenq8OPYx2VYJvbOoobGBjLimd0sWmlPWYwvDjT/NN/qdDSZu2XNmSY1Jxw2rO1A1uR
         LCBXT9qyz0UUl6ZsSJQHyL23erBpErSERNkPtOFcAvJRH4I/favomWGJz00KIZlWuJby
         TaeM9JwNICz7nuPh1WnW+HAuvAiWRVZ3mo/A/QU2IqW+5gT2Wa8LB90tw153LNm2aDEv
         KS/miFRFdChTGnyZ97UR191TxOzIVuGE1Z0gAOa+mxU9Tegp1w4tjgr2Yjn9BqSObh/9
         zjIw==
X-Forwarded-Encrypted: i=1; AJvYcCXZhjDJI9awZSaYc8mL735e/0sawpQhsTZi/kxhr4h5aUpaqqZ3TlxJFrE2vQ82/GxuSOStroQn3KR8rJJ/kRQPXALx7xQ/jTs/Udsm
X-Gm-Message-State: AOJu0Yz40U0n2MKbisqFRcFoud6lTaOYJYUPoQMerpuOM9LByzozhqdS
	Z04kCAtMuV3/Ap8C3vEnccG8rjX1JJMR5BJPslIsXTK8+z977pX6D8gjb9uMetwq5f6tJfCAzZV
	zOdh1eo4l4My6WG8omqCUaiU4PMrbwzn/6g+h8V+inEpG3451MIjDaAM=
X-Google-Smtp-Source: AGHT+IHVV4ammGC2f4+AGyBTE1+VDmo87HUmoApb8C4WDpycZnv406L1ZJ6bIafm6AgJf15GrH+StIi7CY1fsJAsDhp7cO8L/eZo
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:641f:b0:7eb:9f62:3370 with SMTP id
 ca18e2360f4ac-7ebcd19eff6mr21065439f.4.1718261162696; Wed, 12 Jun 2024
 23:46:02 -0700 (PDT)
Date: Wed, 12 Jun 2024 23:46:02 -0700
In-Reply-To: <IA0PR11MB718550C7137E8341C7D54A71F8C12@IA0PR11MB7185.namprd11.prod.outlook.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003bfa48061abfda41@google.com>
Subject: Re: [syzbot] [dri?] [media?] general protection fault in
 udmabuf_create (2)
From: syzbot <syzbot+40c7dad27267f61839d4@syzkaller.appspotmail.com>
To: christian.koenig@amd.com, dri-devel@lists.freedesktop.org, 
	kraxel@redhat.com, linaro-mm-sig-bounces@lists.linaro.org, 
	linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, sumit.semwal@linaro.org, 
	syzkaller-bugs@googlegroups.com, vivek.kasireddy@intel.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+40c7dad27267f61839d4@syzkaller.appspotmail.com

Tested on:

commit:         c7db1220 fixup! udmabuf: pin the pages using memfd_pin..
git tree:       https://gitlab.freedesktop.org/Vivek/drm-tip.git syzbot_fixes
console output: https://syzkaller.appspot.com/x/log.txt?x=133a93e2980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=58a2adb83f90b327
dashboard link: https://syzkaller.appspot.com/bug?extid=40c7dad27267f61839d4
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

