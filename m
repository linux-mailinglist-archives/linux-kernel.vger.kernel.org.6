Return-Path: <linux-kernel+bounces-354447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18DB4993D90
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 05:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2C491F2494E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 03:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEAF240849;
	Tue,  8 Oct 2024 03:37:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2563BBCB
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 03:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728358625; cv=none; b=sXaofI0TD7ScMfsMCrDKxWaa0IT3Epvp3h40sPjQpNfWp1j3K04Mw0JTdBbnTpdBKBcM/gte98jTp3qqtgsGjK5xxYqPzYLMo9xgIu8nxXuBTiXiaJI34tMz3vDzn86zqkeqyYxzHdvgCWW26djlYdXocAErAXia7HgWtZbuN4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728358625; c=relaxed/simple;
	bh=9lCC6/cPpt6A3D9ApigehizFGweWB9PeX4KwX3Vh3HA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Pldi0u5aIZTdBdZNZF1N16V4WVLoomfqFlmTwenqx0figycm0AE3RnlYKhju7Org5xEbLqhmE9cWuZZVJpjKUjMlL2ELusC04LFDMKjdAlYMshz9KXsvfWP+bVx9cQYmrpeb5kgV6+h897p/qOIssGM0u4PU8hfyEeI4DVlVRsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a343c444afso58302485ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 20:37:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728358623; x=1728963423;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KSzLNKT6ggLBRa7OjU1CCapcNmts6fijQLpZW/Tgbkk=;
        b=pTYlIWoC5mVkQTTsMswhdCAWjuMZIO99xmb06MXYb8IN/w3N6H45iAAN59/guEwgC0
         EuUQaBF+OHogzlvdw2t1OIEMfbIk+amd022511CjZWi54+spCdaSPfmAl85VwpkUy5y2
         SiB3Eii4rYfUWPaeYLK+OrJ4MntIyJspQN4ulsMOLPzywmOCqEcVCjtGXD04jNvZhUgD
         JJwgF+4lfpHsEDnBJx0b3CzRdkXmHsEbUO1AgogrtRZjXgv/yFfyicbmukh+0k2bO/ng
         i5kxsTVHA5NM2pTi7mfHgMYnjSLn5TKIKT2uxZcD8q94Zoa949lDFM0S55pDgmDIcRqQ
         wS5w==
X-Forwarded-Encrypted: i=1; AJvYcCXmWPD5fphVPlAvWDUd0OtrOrDH/Lx4BHqq8tJhtbXBvWeC+KiLrl93XQ87RukHZc61QAwsRf83w45O5KE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJZiBSn9Y6Spa5HnF0cuGGKCZgjJEZ4tDq9cfSmvjfsgmHCh6D
	wlvursMERB5xFAatAizF01dyffYwhN89OJDX8T/oSOKksjzfi9bdeVownX6wtTmCa660bnU4ms8
	IOKRjki7OJDhbt0cVU0Z9t8x9T1z0tv9T4UtEplyFDQgwivaT5RRYFd8=
X-Google-Smtp-Source: AGHT+IF0hAiBE0Fb+aPb21J0S7uMLzyS9Sc9RrEn7srF0SIcpCnZCDnEqOSeWf85zCgZaSnrqbrbOA9grvuCBSNyji9u+HpMxZSt
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:184d:b0:3a0:451b:ade3 with SMTP id
 e9e14a558f8ab-3a375a978dbmr140169875ab.10.1728358623187; Mon, 07 Oct 2024
 20:37:03 -0700 (PDT)
Date: Mon, 07 Oct 2024 20:37:03 -0700
In-Reply-To: <66f70232.050a0220.38ace9.002f.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6704a8df.050a0220.49194.0521.GAE@google.com>
Subject: Re: [syzbot] [ntfs3?] WARNING in wnd_init (2)
From: syzbot <syzbot+47de774a425e2380f16f@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit fc471e39e38fea6677017cbdd6d928088a59fc67
Author: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Date:   Fri Jun 30 12:12:58 2023 +0000

    fs/ntfs3: Use kvmalloc instead of kmalloc(... __GFP_NOWARN)

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10a4bb80580000
start commit:   8cf0b93919e1 Linux 6.12-rc2
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=12a4bb80580000
console output: https://syzkaller.appspot.com/x/log.txt?x=14a4bb80580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7a3fccdd0bb995
dashboard link: https://syzkaller.appspot.com/bug?extid=47de774a425e2380f16f
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17ab2707980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10dbc327980000

Reported-by: syzbot+47de774a425e2380f16f@syzkaller.appspotmail.com
Fixes: fc471e39e38f ("fs/ntfs3: Use kvmalloc instead of kmalloc(... __GFP_NOWARN)")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

