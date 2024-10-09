Return-Path: <linux-kernel+bounces-356235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11135995E54
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 05:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A40BD283BA4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 03:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F201428E0;
	Wed,  9 Oct 2024 03:50:07 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5F110FF
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 03:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728445806; cv=none; b=OV5GXSpMJpMT6x7EKl/pnMjXB6fNBiuJxdSUjwI4ojhtp0/rZzB8Gt6Tl55+iJoJZ9pdNrVwoo41LhdPdCHjJBZfMVObfJGc0Wazn36vqYyuO8VnTw0t3Or4ajMHFnZg+fVL5USxp9eW42qKMfcCTW0jjytLi/bM0ICD+ZLs+yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728445806; c=relaxed/simple;
	bh=2pzntAbDepUFPLzEgBid8WcHpvGzHwCjJYl+mmrHnDo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=mtVxj2pLedHNKQ1e5uNhl8TRfgUpJPQdUsdxq9tzTkpU7Cae4eM9ot/4b+JwxJstblira/KEGRiy9VCiysb98LxqKziUmwMXgXs7c8dYol5Ce7n+uujJ42irjBwW97TmdTMF0xzt+gvd4v6xT1GOxW8Tf/Zrac/msalTO54MIew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a348ebb940so66709895ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 20:50:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728445803; x=1729050603;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rw7rJSCiCXfgr4IOyT+sg+vA80oPk9jU0sR6X02fBho=;
        b=eF9cRmyQ+C6PwGTJdlMou2eqduzjnyypMGdkE3sRk/lLmz6+a23sODa7H2iwtx/f6M
         +SB1ytiDtVb5CyD/kz4vuUwzhwTpsbadvRDxESZG6SlA34suh9u0C+DGp9JaCM6O/dO/
         pOjLFbWFXntXzrUzmHVmVeq5cH0n+MA6iAiSdJrBbaEYL4DIw6tCTi8jX6v+oszLgkw1
         XxutnK8U9x1p4df/wMcb4todQ6QPSosDGgmHGqMXtB4jV+wgEiQHZVbl2o1fr2qDoHcF
         B7j1BHjojKhkYXEiwdk2cbOUEs4cCtuQBbOx9bscZvlHBF80KRol8tihJTZnD1TpZQrd
         WyTg==
X-Forwarded-Encrypted: i=1; AJvYcCVJpAY4fdUeMIkQhSq9L0tf5RHz4wbxyk9FkHgS2k1svHf7Jqew5AUQvfSQakYuNqyOm4rfW66k5Oy8nV4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2ApNLZ/AxKNTjWbwaIbjSDTQShWW47x0rAryApyTY4VnwoPW3
	A/82F/KRPoOdFH4RoAMwItIXh9NZe9NmBrnzjPqc3tL7xBdtYW1D5sR2GNj1aVUE/qUEHNqdoPO
	bG+N/KXPmFlQIZmfXs1r9DrFwuBP06SID4FegONLRRHNiBIa9G5De8sY=
X-Google-Smtp-Source: AGHT+IFsZsK2mw6jBIY0lJMvI3/T+aTtTJV7pSr8Hw2SWDC9T3wqDKnfiMRj4ewbUZ31aLtZYi2xzaYbm/17MuYJvMuG8Q9+2rRo
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1561:b0:3a3:4175:79d2 with SMTP id
 e9e14a558f8ab-3a397cf240bmr12259775ab.14.1728445803106; Tue, 08 Oct 2024
 20:50:03 -0700 (PDT)
Date: Tue, 08 Oct 2024 20:50:03 -0700
In-Reply-To: <4cd7f0c2-a6e8-4bc6-b9fc-4b0edc99f63f@126.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6705fd6b.050a0220.3f80e.0023.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] UBSAN: shift-out-of-bounds in bch2_stripe_to_text
From: syzbot <syzbot+f8c98a50c323635be65d@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	zhaomzhao@126.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+f8c98a50c323635be65d@syzkaller.appspotmail.com
Tested-by: syzbot+f8c98a50c323635be65d@syzkaller.appspotmail.com

Tested on:

commit:         1ec6d097 Merge tag 's390-6.12-1' of git://git.kernel.o..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1144f707980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6265dd30e362bb47
dashboard link: https://syzkaller.appspot.com/bug?extid=f8c98a50c323635be65d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1087e327980000

Note: testing is done by a robot and is best-effort only.

