Return-Path: <linux-kernel+bounces-198195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 394498D74BF
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 12:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C888E1F21C83
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 10:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67961374C3;
	Sun,  2 Jun 2024 10:23:07 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17ADA21
	for <linux-kernel@vger.kernel.org>; Sun,  2 Jun 2024 10:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717323787; cv=none; b=YedyBMc3ece3P4UXf0lF18vQqwgb/nLmCGWyq1qKzmpC0Rv0H3JG+7EHTvDN2ihNE+WnzprAsNvDPc3lcsUxA2AU2Ev6KJhEaFFL+zOX53YcCfxHzOmWzeIJviBSdV8hfD4f1XKAoQbTpKlZ38Usqg0XkfRkWNw390bkrmWKr4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717323787; c=relaxed/simple;
	bh=w+AcFgvjJYewmnJnFSwz2pD6jSMQzh1iULV1s2D3dLw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=p62t+yV0mLGmbdNzjIGsoE9riJhQG4ARo0A3+PqPGpfi0hlF66wP6b4KGKRI4Es5airOmwGGyalSk6SyYSbowXpEti90tRVkUFPjzIHcm4yGTlhay0iTwXTVP2EGbodJzu4MNqFD/YY7UR4/boW1gO+sewNwUdnpw34s19ZaNnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3747f77bafcso29393325ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2024 03:23:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717323785; x=1717928585;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vAOfm6ZPAOyr5Njyk7uzc0pdLITL0XP374IWO7Y1mvA=;
        b=fuckhQ8gueNWF9Yhx4EHDHl2+2t/CCehTdL2Xg8lWLh7mjniowOWKwAN+66jOm382y
         CmTcDewaz3GCc6ycxNK16rSzSG5FrmzXmHr1kEkW2Ux9/T+S3jzCUJnA1duN0udkQ5Pu
         MluIHCgm18nJIC9ton4wmW2GoLyz/pv81vZ+OnNaysk8y2jK1h2NhquNdQCMKXFxoWYB
         gAEq/VikQj7KVyQEHpI50GTKvqx03H9hgOlktca382fT6LVzRE0wM9YtWHK68H7yXHqX
         FC0YxPxLAw7u7vtuIA9dXyu/STPkfiXJDyi0x7M/sUvPDteRhrPBg+Yl5y9ADFuqPsMZ
         acFw==
X-Forwarded-Encrypted: i=1; AJvYcCXLQ7yxvjbNHI1Krh2PEYZpyRSpjbFC1W1o5pHInx8jYIss/BdbwT69P/y80Q21nuiaPcf2f22tERM9Efc5E2U8d1U7zo4FbIvJAJt4
X-Gm-Message-State: AOJu0YyiskX67K1HBh7gCgu/IzXTkxsK4C6izCtknTXH4cVVmc+ggVCL
	zmvhGTAyaBarV849t+Udq0Xf26SA8OaevWLaJLcxKnOxM3FfVVBXNdhZr39YTdzrlS5l/OXAb/n
	BdGBLeDtOlP/d+9D1+72cFfd0fnavVyBOLU+QCofaq5GVJxvZlXF3ae4=
X-Google-Smtp-Source: AGHT+IEbk/6UBvu0tBRCiUnwoucHpHUsiwEYC13SSjLsUa/5y5dNusqUKIwNsdEIkWkoYa1NpRvusKwabF1nhwzyJ/YPl42WG2vV
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20ee:b0:36d:b5df:f478 with SMTP id
 e9e14a558f8ab-3748b9d5c4dmr6702335ab.4.1717323784821; Sun, 02 Jun 2024
 03:23:04 -0700 (PDT)
Date: Sun, 02 Jun 2024 03:23:04 -0700
In-Reply-To: <20240602095024.3791-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000028b0c00619e59afc@google.com>
Subject: Re: [syzbot] [gfs2?] BUG: corrupted list in gfs2_fill_super
From: syzbot <syzbot+d34c2a269ed512c531b0@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+d34c2a269ed512c531b0@syzkaller.appspotmail.com

Tested on:

commit:         0e1980c4 Add linux-next specific files for 20240531
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=120cbdfc980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d9c3ca4e54577b88
dashboard link: https://syzkaller.appspot.com/bug?extid=d34c2a269ed512c531b0
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=120731f2980000

Note: testing is done by a robot and is best-effort only.

