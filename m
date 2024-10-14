Return-Path: <linux-kernel+bounces-363067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE5299BD84
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 03:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D3811C220A8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 01:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1373C1BC58;
	Mon, 14 Oct 2024 01:58:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409943B796
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 01:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728871084; cv=none; b=ul5Dz2rGNApq+dUrOMGqYBOHkAk6prf54Sea2ZSPKFTHb3y76JOLFnN+d2BnRfAT2SgAJBzfofDmAtgsW0wjvx28K2FyrPlm4bCkdjiCtmCQ7JpI85naI9cF5iAVLJAug9o0rn1xF4niihiwTHnupOiXnZgmGAacOLGdjF+RrLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728871084; c=relaxed/simple;
	bh=KDjr7dTJFIx7LYdN+1OBTUPnhoqiejNCMfic9hd4ZPE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=KUFgD3HPLpr8yrem7jppX/RN/w+xDLukWN9KxXmIX08m8AG0yspidTeH4qprJBml/mS0Iw6dsG2n5lkT1+Z/yyRFwUGyGYfsjbcMZ1KJ+Q9lHZ0WouIJyZGi8yz2h+spYGQLwkREWlvHd1G3UqrKoU8UkAbpAjvcLFS4lDjOJaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a1a8b992d3so33191045ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2024 18:58:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728871082; x=1729475882;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A5JNbIkThihQjLFqgK47fCLV9Rv2LnDWk+FyzRw1Qm8=;
        b=Np0LPfnyvGjOFMzpqYinBOsHB4r8YRKKDojXra84Zy8t5Fd4bOE70rwY38fWi28my+
         tXo9pFW2IhWInd+qOi71YjrDrIEnZ32YDdbSyozi7xftDNmLGmjoHkVnRklqdzvQiKZ3
         MvGaiDWz9zfM6lnXFzzgGHW0vmsuNlFP5DcDpuZY23PmYBb1mpS50DNXh7hYhmnetQ0W
         nzPiytkLImlKIf80xQahWUalHa4/thbkiT2J7ReaFPIMr7CYHpyJRgVXqBbnN1jJk8dp
         Yyv432yPUgqjGUomN296hcP9FgdeJ/vxEqTTYDQLhhsfb4H928LHMGDJpuLzCDy5FPb1
         LjLA==
X-Gm-Message-State: AOJu0YwSufxBQG8FCcaY0Mo8EZO5ywc9naAcP0F40denFhXaIZiJMwc8
	wzRx0z48Jx9j4+/HzaBhoGvhcJwpbAHP5iXrpLNubLO+OL07UONcSYfQVC5pMpU/sGAANgrsn11
	1lgFk1YieT3pqTD3J3tL1COMqJBhDxyKYGI2j1hX4BrqElBYnymOkeiI=
X-Google-Smtp-Source: AGHT+IEB2xyqoYYS447F14Vojf4tippVunc7OeKJKRiBhcVGrbVHTC3e6kfxaiRceFFrhM294RfypB9gyEy3FAGTMowt3z7clEn1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c06:b0:3a2:762b:faf0 with SMTP id
 e9e14a558f8ab-3a3b58ca80fmr60155035ab.11.1728871082281; Sun, 13 Oct 2024
 18:58:02 -0700 (PDT)
Date: Sun, 13 Oct 2024 18:58:02 -0700
In-Reply-To: <b9bea8cd-effc-484f-ac46-1644093adffe@rowland.harvard.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670c7aaa.050a0220.3e960.004e.GAE@google.com>
Subject: Re: [syzbot] [usb?] INFO: task hung in usb_port_suspend
From: syzbot <syzbot+f342ea16c9d06d80b585@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, stern@rowland.harvard.edu, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+f342ea16c9d06d80b585@syzkaller.appspotmail.com
Tested-by: syzbot+f342ea16c9d06d80b585@syzkaller.appspotmail.com

Tested on:

commit:         d73dc7b1 USB: chaoskey: Fix possible deadlock chaoskey..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=15834727980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4510af5d637450fb
dashboard link: https://syzkaller.appspot.com/bug?extid=f342ea16c9d06d80b585
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13f54727980000

Note: testing is done by a robot and is best-effort only.

