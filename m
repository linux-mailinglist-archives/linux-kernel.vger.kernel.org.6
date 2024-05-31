Return-Path: <linux-kernel+bounces-196174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE368D5873
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 03:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17FF11C22711
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 01:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0A8558A5;
	Fri, 31 May 2024 01:58:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6D652F71
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 01:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717120685; cv=none; b=PiPmYbBY4/Kfxc/BosypQWmRiAnCg2z6hyaW/hU3Z0AjPWsyGwiroddl7RPvp7ilyCD3dsWTGHX99sNluM9DshrbO3zyw8GvAYaiDnP23C8Ssgu1yd7qNSWmOqvfmYnltsQkECuB2DmhgsyodER5oibKYGkujmGB0ABUCGq0oAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717120685; c=relaxed/simple;
	bh=oKdqIgYYeqTIjJ/EBn/tOFlsj3rG4uVjeVE3gLanJIM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=QjEM0siACxBRbz3Tt5jRsVqNGrxZZeGc2LvVFpQc8gR9NoXLhW754vW94vDHpfVv2C3irCtwklz0mdmdnCA52iMkyp+ZXjzTwidpx4PRxOOMwDVrkGOlmf0WB7n+ObqmlyXnrPGi3D33UCLsVWm6lj14mUTLSV/kCZcL4VLw0Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3747f77bafcso11182875ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 18:58:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717120681; x=1717725481;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lVF5fLhrIMnfDIaeb9o1U/wk5sbSqoaeBs5jwtIDr+g=;
        b=fwR1FrHXZXwALmxOmK5AIXd3lXDlL9jlIyFYSITXx37BhLa+h3hopMKUuG7N46iqbm
         sDjN5FwSWHvv93Dh5SnH7UCjt2kSpuhJ3dIisJX1cZnGHHNy3In7+r50CVC/SdZf0Z3T
         vbn/i/DkB2GQa3MuipxThwZ5RGxBWzR+YmX0F+fQ2byjbu8ukHwcLjQlXRwZ4bv8Xvwv
         MAyl9qfvTMXfLGNQOHDu0zEtNrkgLpo0PtAl0QaPuULbEOuweWCyy1yOd/x88hRXyxP3
         n/eu63Sh+d3NWlfVvz6D7bGY8se3DkaQ+SohERz6Ve/DPv5yzNN5V2oGgjt19TKQYBwi
         d5ug==
X-Forwarded-Encrypted: i=1; AJvYcCVpDuf/Jrs1c7lQVJbi0CeC0+Xrw4L+sihIcktYFPTGeeCmITJ9TRwV7hitY9VpkN4UJUKu86G9oBwm8RZCakTLDB1ekPvYX604Ql03
X-Gm-Message-State: AOJu0YwO8IdQ0P2fqPevxM2iBF9qKKRpnJvoPKmnBxzgtUEF+jh5/sqG
	6jLpj778PfCDW9Xo6nPTxVERaIeC1WiGY8lL6A5e8Y+IaA0eLKfMj18bbZubZkzeBNBm03GNZVz
	T3Aystu5OtYYnilOP7M5c3RTTFGBpkDkhfNFfprxkWMCko4usrI9oqGc=
X-Google-Smtp-Source: AGHT+IGrEt4nUHDcF3e9MOXXksrBLXmItYeZQKlTA/4sBECgJXxoMv/I84e0RWwwD6fDhWGo1aIlMPvg8kADYAiMA0xzhn5JIBFm
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1e08:b0:374:5eee:dc2f with SMTP id
 e9e14a558f8ab-3748b8f23b6mr480465ab.0.1717120681793; Thu, 30 May 2024
 18:58:01 -0700 (PDT)
Date: Thu, 30 May 2024 18:58:01 -0700
In-Reply-To: <cdac627f-7d25-49d6-abf5-c9f9723f0dcc@kernel.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000466c600619b650a2@google.com>
Subject: Re: [syzbot] [f2fs?] KASAN: slab-use-after-free Read in sanity_check_extent_cache
From: syzbot <syzbot+74ebe2104433e9dc610d@syzkaller.appspotmail.com>
To: chao@kernel.org, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+74ebe2104433e9dc610d@syzkaller.appspotmail.com

Tested on:

commit:         b022159f f2fs: fix to truncate preallocated blocks in ..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git wip
console output: https://syzkaller.appspot.com/x/log.txt?x=10811664980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6be91306a8917025
dashboard link: https://syzkaller.appspot.com/bug?extid=74ebe2104433e9dc610d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

