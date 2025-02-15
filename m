Return-Path: <linux-kernel+bounces-516065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3FA2A36C92
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 09:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76967171235
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 08:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC2E194A65;
	Sat, 15 Feb 2025 08:10:04 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4D84C8E
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 08:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739607004; cv=none; b=MQ9sG21wG6NsOeQd+0UQUHRV1BNs+KAqDAPWzyg19a9fFd8S23yDjfl7ryreiVDpSSl4a0W7DGo/Ndb/AAKB4nxMcffs8FFYtiMb8aNcKauBlDwbi5TofF3droPyYbwXiulGZ6f5gGi1bioF/SWCYYppyGWaO3NZxrTJvz2ejoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739607004; c=relaxed/simple;
	bh=ptffSltijLdqLGv4yVGcIGTi4OhChHx1WWaF16FIWX4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=E9MNRmpsMmcHsr5cjt1kKvYRnSz08A4CgApZj0z7phHi1jBvitopa50sdI+4EVEn/1lspd7TW4HLb+ghoAqWtKUb9ZVeyDSVfLBhJUCS7p34HFVl+ODJofJxtZotog+xyY8v5e976oJWCq6wYlUym4bvJHpeLGSUJj56CjQ+SMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-8556814d1c4so196485539f.0
        for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 00:10:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739607001; x=1740211801;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ej0Im0Laq/eK+S5zWbgP7a1P90BLa1XrcYl0gGqjzmA=;
        b=f31yFRP88Bq99rNI5gFEeXGcR80yRn4KpdU5hHCxY47BwkKVbeikPYA9dOTCbTfRKX
         M2x4GuiFZFcb9JUelroOFj1VPLODFyRJzHig5Repp+vCNJKJ2q2gV0LUmRmo+9O9wu5B
         wvNOjQuVHCGo40cI2B48ji0A5E9vUjbabjYiGVR1xOXmN/a7Z13JtX1JtDhO0emDvLtR
         oalrtKSq4mCjw/6+QfKSSd6trHgReWCGio2dmLI5AM0k0t8lFxZLt5ycU8qwVgSuRhhq
         BGyXcfGvrLfMwHsmaeWc8d+UMib5tZfYRZQwA6D7OyzPEuEsvW/zLsxStXXo3f4YBfAH
         ixVA==
X-Forwarded-Encrypted: i=1; AJvYcCX/9NwqmoM34aGEdGysefvQRtkZ7VIznK6fn2tAoDWlhov2n0LWIUs6pBPnNCK1j9eGjfDa38mpPlobZLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2GHXBuzlm0mBYhGhT36kiab1ET5VA1SrWUQKUjf/eanIgIg9A
	hrCbnwc52xZNcAH4jsiZYkQCpFNlsmqo5q9SB8YKUVys4RIbGcMjlinDBJc3hY+uYr8rz0ecNyv
	rwbxHMZedB33m5QkfGK0WjzSsm6b7FkIl4vYVXL/EN/x2174XNaZ7muI=
X-Google-Smtp-Source: AGHT+IEOt8TkgfWLf53+s6ln/e0Gyw52Fwq2odymM1+yPKWOzLPAuZMVhvFBBX6g8qRsmHKyzK7iXvP1AoKrV5Xb5SH0kMWP0Df+
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c0a:b0:3cf:bc71:94ef with SMTP id
 e9e14a558f8ab-3d28092c1a7mr17454315ab.17.1739607001715; Sat, 15 Feb 2025
 00:10:01 -0800 (PST)
Date: Sat, 15 Feb 2025 00:10:01 -0800
In-Reply-To: <20250215074343.2302-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67b04bd9.050a0220.47157.0001.GAE@google.com>
Subject: Re: [syzbot] [netfs?] KASAN: slab-use-after-free Write in io_submit_one
From: syzbot <syzbot+e1dc29a4daf3f8051130@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+e1dc29a4daf3f8051130@syzkaller.appspotmail.com
Tested-by: syzbot+e1dc29a4daf3f8051130@syzkaller.appspotmail.com

Tested on:

commit:         7ff71e6d Merge tag 'alpha-fixes-v6.14-rc2' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=107d6098580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c09dc55ba7f798e3
dashboard link: https://syzkaller.appspot.com/bug?extid=e1dc29a4daf3f8051130
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=126e99a4580000

Note: testing is done by a robot and is best-effort only.

