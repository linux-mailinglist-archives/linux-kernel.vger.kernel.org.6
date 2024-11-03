Return-Path: <linux-kernel+bounces-393807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8118B9BA575
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 13:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DA941C20D79
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 12:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B2316E86F;
	Sun,  3 Nov 2024 12:51:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54B7158DC0
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 12:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730638265; cv=none; b=X6KANHXaRy+5gyHoBaLAN54fhKConXrJHE1+aGVKtazWbtnKo88w0VDgG4pm9d2HDjvi7zXr8Jx8J/lqQ/IEiG4xyTGAxuZMaCylH1nIGq1rEXe85aaYFZpJqel1y0RDm2xAcbbBRuIL2omO/nGgK5xK1kv0k+6+iwADwAvUjKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730638265; c=relaxed/simple;
	bh=piSZz+R1LDNqFSNj+rGYl92ubdi+Zin3YdppkW59UaE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=nW4nCc+0kIak4qlqMeA4bN0jcuDS6ftC4LALRjOaTOCz5twodXVomgfuXZnFjwJh8IJuyB2Q+XGpNOgh/008LH2NJMTRL4w5I/LWwESrOhU+OFYzxR2e9kEiArtPRNGIcqUIGOhbW666iYhYHfL2iQaN4B5bpdUG+Q59eYwNxns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a6bd5be0faso16627585ab.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2024 04:51:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730638263; x=1731243063;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8sXV6nkrq6f/dVfYK9hV+cScjwRuISgxlc87bQs+qBg=;
        b=kqQCCuoKnO6aWAYmOoebDYBtU8PR/oROPYw5TBFaY12bXaOjBlwDabkP8luNo5wnAJ
         TPYdxwdskw0EN0H6ISq17qWyp6ZwFKk2NyenfhaRBYLUkxJ8V86fBxDTejkvqtV8SLa0
         8KNj/RGLn2Vw8M61kXPDykn/qof0DkRC2OzUiniFDFnsl+dcgEeYRq7edEtVtHdNx8D5
         7brs+FAosUsFe7wRgUdiuGgxRZZvaeOJrK4TjEA+LCPzHG1QSoTeig5fh3CHHs+Wk3/3
         BSKl+MIHFvxb9vl+WKjlqOloqI3pXnXXsEPQPOCGwMQj59JWm5HgzWKkW3/5OlQraMJH
         +MeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVDsFjm+Cf+OXlzi87MV+kXguFQMpG5aRl1a8VJNd4nY0OETmgxsD6XbDdlnqWlY8+btSudz1oN0D2KP4=@vger.kernel.org
X-Gm-Message-State: AOJu0YytM/TjMmo3w5zfECfLV5tjB3iV9/h667ZxKI+ySWHTMLMEJrKm
	DqUHXJPXkpMaeFbxNlaRhyRgqtS8RkdADgtMo0P7IgvSVHjoEzT41qc2L8ydTcuI/fOStGb05br
	i8m21adekt1dNi7MedEevOwMDeFWj0XQvv2RyZGHsKbqkux1S8zvpbw4=
X-Google-Smtp-Source: AGHT+IGkx2KgTzybM+bFBWKiD5r1fwAdvmhysNfVCoSTb8wnFdVW8TYs63cylzjJ62wGzV5+o+fKXu1/RMQlNA3GUbARMg3gtKAe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1528:b0:3a3:b593:83a4 with SMTP id
 e9e14a558f8ab-3a4ed295bb6mr270904355ab.14.1730638262900; Sun, 03 Nov 2024
 04:51:02 -0800 (PST)
Date: Sun, 03 Nov 2024 04:51:02 -0800
In-Reply-To: <6718dc39.050a0220.1e4b4d.0088.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672771b6.050a0220.3c8d68.0a4f.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] kernel BUG in bch2_btree_path_level_init (2)
From: syzbot <syzbot+eff0acb9087ee995577a@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit bf4baaa087e2be0279991f1dbf9acaa7a4c9148c
Author: Kent Overstreet <kent.overstreet@linux.dev>
Date:   Sat Oct 5 21:37:02 2024 +0000

    bcachefs: Fix lockdep splat in bch2_accounting_read

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16cd6b40580000
start commit:   3e5e6c9900c3 Merge tag 'nfsd-6.12-3' of git://git.kernel.o..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=15cd6b40580000
console output: https://syzkaller.appspot.com/x/log.txt?x=11cd6b40580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f527353e21e067e8
dashboard link: https://syzkaller.appspot.com/bug?extid=eff0acb9087ee995577a
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16e5ab40580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1760e987980000

Reported-by: syzbot+eff0acb9087ee995577a@syzkaller.appspotmail.com
Fixes: bf4baaa087e2 ("bcachefs: Fix lockdep splat in bch2_accounting_read")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

