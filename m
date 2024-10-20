Return-Path: <linux-kernel+bounces-373126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC669A528C
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 07:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E38351C21132
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 05:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26CCEAFA;
	Sun, 20 Oct 2024 05:27:07 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB05EBE5E
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 05:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729402027; cv=none; b=Sesu5AOYi7HYd/gagH12cz8p9Ewwb+1l8wym/kkiOWyIxvvmHi4l5zRA/pdSrLCRltmFjU6Zly/2MtEwbZ4QtzjEqtdg7r1lD+lC2QHPk6jg1GU/a0gERHL55q3xCAu3jYLhfn7Bgdy0sEgs5orniRUlzEtuj8hw3omLONuI9dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729402027; c=relaxed/simple;
	bh=a5Rcf6a6v5JDZThblChhGloRU+jtbi7xTzEPZ1eKLa4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=pIsUqYhGUQy2ZpI3mOjp2grMXgXd9X8AT7lx2pbMhOElQcZxfNW69wu3opvTPNTzXTXv9RlpEwvHxebocFEWa+YmzlRA5XKj6bnlfbdZz/NdXD46rP2qvmWDkDQVgoBOOT+HSo0FB1Y000fjAN/4M9vNsmNk2trn7Jzl+bqkKi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3c72d4ac4so33463185ab.3
        for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 22:27:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729402025; x=1730006825;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3lpPtvmifi5Sca04uwV/sjmM6lHv0HJRcL4LGQWXbZI=;
        b=uFGxKLPU/n3gEy35ip6qT+hpy7B6++qx1afUozm16EVFVcIZAtCr2bE9AvMbWoVmbU
         aR8yh7KUYHp0eUFH3RebzYsJUBZMhrp7Ary7DEYMaCjoafKTz5tl1FQ5RWGwABBRRrhu
         Xz8rTQglb4xOpAamXs0DC1ggpaxcVmeplKo3cd/rDEi3N0l6trkR+Jdkcrw+AwYUhk9m
         rtvgykaC6+nMzsKjx5JxPQSXVWu3IpDCzK2eOXpJvUqNMWkH9QfPsbpFZ3r948qo7y76
         Uj3nDqtn45GTNQkt7WqubrPG3eh5KrxosttfzFQtxVSxDoFv4jS4w1yfwcVM4101zekv
         6Vyg==
X-Forwarded-Encrypted: i=1; AJvYcCXr1gUIvmu+pDbzXl/MJjhcQbHw9ERrPihrOum3bt97vRgrr20KPzVYSdi6oy01GAyOnbDKhrIYaQ8S0cI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ/AL8a5pXrCgtbL59AYVSjt4Jsri5Z14LlvqvPSrWphg2Zvgy
	5wSRNN7QIThurkrvR2rZLe6mrkD5a4CJUDU49kUogq1IEMkLMNE2uLVNhhNplyVe6O9+rshc2qM
	WZdikiL8rIpqCMRX1OHgyQSnFWOkQeI0FQcP0zI7YTAszxF/dYBBuDGQ=
X-Google-Smtp-Source: AGHT+IEYce9sUyNDdTk+wgGzFw2BwQz03vWyRMhmI14+zjrbpa+FnVBxVGn7dNxGyzCKuqAaIyh1OXcVhnLc8MTf6tvTILICZaan
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1385:b0:3a0:8d8a:47c with SMTP id
 e9e14a558f8ab-3a3f4073df5mr70096325ab.14.1729402024790; Sat, 19 Oct 2024
 22:27:04 -0700 (PDT)
Date: Sat, 19 Oct 2024 22:27:04 -0700
In-Reply-To: <tencent_3D5A3D31368C961236E64AB074D777FD6609@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <671494a8.050a0220.10f4f4.002a.GAE@google.com>
Subject: Re: [syzbot] [xfs?] KASAN: null-ptr-deref Write in
 xfs_filestream_select_ag (2)
From: syzbot <syzbot+4125a3c514e3436a02e6@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+4125a3c514e3436a02e6@syzkaller.appspotmail.com
Tested-by: syzbot+4125a3c514e3436a02e6@syzkaller.appspotmail.com

Tested on:

commit:         715ca9dd Merge tag 'io_uring-6.12-20241019' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13a120a7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=78db40d8379956d9
dashboard link: https://syzkaller.appspot.com/bug?extid=4125a3c514e3436a02e6
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12480d1b980000

Note: testing is done by a robot and is best-effort only.

