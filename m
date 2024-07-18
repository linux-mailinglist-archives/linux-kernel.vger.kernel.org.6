Return-Path: <linux-kernel+bounces-256353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0303C934CDD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 14:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65DB1B22CD6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 12:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F62513B7BE;
	Thu, 18 Jul 2024 12:00:06 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFC012FB34
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 12:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721304005; cv=none; b=oTHY9GmtUkdg4yiv/7xFT/qMwHTkH0fOgjNJeWT9l4ry0FlAUQ/kfxUTI1wCPLz+XfEzUX3AXdXrGHxqtHf5xCcC94YAhe78nT/63f5atRzFEuErQ/fnBqQRt2i4bSHst6t6e1t1ooHg4b7LhMVWP4s6HDj/YrHd8kltVp0gSuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721304005; c=relaxed/simple;
	bh=3gLBsscoSBFCxLmDvvnBKSsjHCec6Gpm0ks/pSurpTc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=dYNW6gEKoe1MQ7okzDICeQDxTKA9Aq+PowapsLw3Gn8U27uiffX8/WsGJ7Cy58wDeA0o8lqLnNvKFhipMiomQ/j0S+g+1THQLqZl12yhP6+Bk6NQU2pIbKs5CjvAkiybrOnub41LBWBuhlpdK3EihRbPcFgnj74ho9G5nUWvn3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-8152f0c63c4so228519139f.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 05:00:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721304003; x=1721908803;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0xRxDJxtAdMMpSSvxFYj6JkhxMKleL/Og5yP/fDMtos=;
        b=uYFyUpSh9vMAwzINUBQhnarIv+H3EmzRSUAYBDjRJiyrVmz51FqwV2GG/30caF4lN3
         MRRFv0NhuZl/k4OjNC1oYyBY/DbL+bo57RVWBM8mxrzxvx6pEm53H8eY1sFEXik4mQGP
         ZEQAVlvgFWPvANiPNNhmavlKd19xW1Zj12Q73OdK5oeeA3vW36Xt+9DQfxQoPOaoCLoj
         amHCYTTxEL9VPRnYpH7lrmFbAXWYHWJ15kcBVvTadgtEBVeHKppSmKFYJGLcR/Vlwqqo
         ePMdIKlN+aW0sK4cmeYPsWK3Ww5QQj+zvyBnxsS8jGe2LGi9xnikEArqKqz5nyzdPeSd
         n99A==
X-Forwarded-Encrypted: i=1; AJvYcCW+tGtNOMeDPBTcp5XuVVZayT0QPXF7XzpeR/aprJjb4jn8xgVBZm1jadI01Wd28IdT3CwswbWjowrJglGIsTST9UWqgx8SMZqNK7Rs
X-Gm-Message-State: AOJu0Yw0ylRbJaQGJ66YYkAFzCUZjtxBH8DTf5LUrouKCUUBIjrlIe7l
	c3hfsTEJAKQ728wi8e1jtl8hqvQwKMhkGyzM6Re73N8tgHXiqSkjzCBfCNrnlaRsy6OwOIlH5pc
	icd0G8OpahqlcqhxNTkQmQYJUu4hJoqAG0fHnUdzU2a/6AidFei2to6w=
X-Google-Smtp-Source: AGHT+IFvi6Rj51UYqaujK4CcrHiK0jD+18oJowhra8vBynVABXLRhCQ+81bwUGz7WfaOl5fVNVVsi9mjGFDKF1yw6bSQauh5O7B7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:204d:b0:4c0:971d:36b1 with SMTP id
 8926c6da1cb9f-4c21fc95f5amr105399173.3.1721304003359; Thu, 18 Jul 2024
 05:00:03 -0700 (PDT)
Date: Thu, 18 Jul 2024 05:00:03 -0700
In-Reply-To: <20240718110318.1438-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000abc9fc061d8451a5@google.com>
Subject: Re: [syzbot] [fs?] WARNING: lock held when returning to user space in ns_ioctl
From: syzbot <syzbot+dd73570cf9918519e789@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+dd73570cf9918519e789@syzkaller.appspotmail.com
Tested-by: syzbot+dd73570cf9918519e789@syzkaller.appspotmail.com

Tested on:

commit:         51835949 Merge tag 'net-next-6.11' of git://git.kernel..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=102d825e980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d3bdd09ea2371c89
dashboard link: https://syzkaller.appspot.com/bug?extid=dd73570cf9918519e789
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1575825e980000

Note: testing is done by a robot and is best-effort only.

