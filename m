Return-Path: <linux-kernel+bounces-264571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CEF693E547
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 15:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEFC51C20C95
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 13:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08764482E4;
	Sun, 28 Jul 2024 13:06:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F96A39FCE
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 13:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722171965; cv=none; b=TNDK74uQEBPatjk487fhzUW2KLbCtx6MiMdtRrVOeaBskT0pPQ6ajKAiKAoN8f3BxfUASSx6zu9AHFiGvF0JembwERJwyo5Q4GT6DuDkjvSYvDXwfP9CvmkyhrIDDD+xhFprT2hl6IeDKwjl8tG5xRLNwmggtVozWqD0o5TSJGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722171965; c=relaxed/simple;
	bh=6GohRNnVkdyMyhY57MVAqGzgqiPtB9QMvzqAcCiaW9Q=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qJZbjPM2FHZBHIejz7o4Li1AWMZaHUpebjP83T4lOTzy/CDYHfy375GXdTURY3rJuGyZb9Pp25OK1sfy14epUE4DPMS/pe4UP8Mc7/KVowg4qmYUmBYMRww2/B0KmiXGMGCTgf5wtJF/CwVg4aULKmHo47QxJCDXfoT8Zg0oOJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-39ad7e6b4deso36694505ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 06:06:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722171963; x=1722776763;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f2Hh/tYqJJ9WIGR+/RAvK6iu0tFipC4/a5RgExdtwqI=;
        b=RDSPC/4vvX5/aQMy+6oFZDxCaFphx9qvXWcgo9kMptGdALskTaxCB1Q5xm/FnfzKfH
         XkonZODPPxhuCXDdcKSV3XyIqzbDV/aZ7TPRRu1URlWwR3mjP8+Eico8QKagpZDi8vZ+
         C/J/UznpS/NY5II3SXHyD+lkVVOt33pIDdLWUfDvd67qEqM5BojwfsLCSOskZ77YXa68
         gZNH5yZ53BG6ZlAL+jbmUgOLKuXjJovY1+CZZz/DspiglcP9ewnXyWi7XBI3S/50wsno
         1c2oUJeLGTFB1dh2K3Ms9dVEoHNh2oor/wgv5RbSWIxZGPYPuDqYWl7BvoIaNteyWaCz
         zXYg==
X-Gm-Message-State: AOJu0Yz/YFAY4HB9BH9jQUt4dA0pVS6huQ++RYTWnnRn/NMnrnj4PlX0
	Yk8W9Ub7z3lg7OaOYQeYtGkXXMND2KQ+QrdIH+1gVH9zwotZRn0VNNS3r0Ruc9Wo+s8mmZ/abzV
	m/7/LSprpsE/eCYKvB/M1kNg5OU0J74k9nq/EEBaQahPmfqNdTsTou/c=
X-Google-Smtp-Source: AGHT+IGnYHzm6JGbv3X2pM1QmyFpWz22JCEG++Vq92dRl2xksE+9+LZrd3IdREGnqxSUI/ALp5rGZOJiftvEWW3O/zHkTxz3nmhR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1caa:b0:39a:eb4d:23c5 with SMTP id
 e9e14a558f8ab-39aec25666dmr3316865ab.0.1722171963458; Sun, 28 Jul 2024
 06:06:03 -0700 (PDT)
Date: Sun, 28 Jul 2024 06:06:03 -0700
In-Reply-To: <08149055eb7289e1948d2a9fcee0229581e8c6b9.camel@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001fd53d061e4e6844@google.com>
Subject: Re: [syzbot] [hfs?] KMSAN: uninit-value in hfsplus_delete_cat
From: syzbot <syzbot+fdedff847a0e5e84c39f@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, simeddon@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+fdedff847a0e5e84c39f@syzkaller.appspotmail.com
Tested-by: syzbot+fdedff847a0e5e84c39f@syzkaller.appspotmail.com

Tested on:

commit:         5437f30d Merge tag '6.11-rc-smb-client-fixes-part2' of..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10701da1980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ea3a063e5f96c3d6
dashboard link: https://syzkaller.appspot.com/bug?extid=fdedff847a0e5e84c39f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=141241c9980000

Note: testing is done by a robot and is best-effort only.

