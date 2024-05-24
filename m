Return-Path: <linux-kernel+bounces-188232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6708CDF82
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 04:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9658282573
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 02:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7822206B;
	Fri, 24 May 2024 02:31:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFCE33D8
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 02:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716517864; cv=none; b=mZQpB891kfq42xt2yziy7IhcBAkhvFtZmhSHX/A1MdWGbUXNnk2AUwROilIhlot9pIdig1smlkRTWEZ7UpRI7Bim3htEfFP20M0jlmxiBujSKKXUWPtCc0pJLUOdKnni/lrC/9K+GezR1hTQ3CJkuprx/v9XU+0l4qt61w+pJRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716517864; c=relaxed/simple;
	bh=TznDKzMJuKiUJ585rhM35ZjLhiINq0RwukspR7SwnVw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Io9ygb7l4qZuVz57yL14F5rlTD1YI/QpdvnN6LghWijy295L6D760vwwRgMiYX6jv83Vcw7U2SJILE/IE9SL9p0uWAq+dWp0+vIY22EmgW/BKe4WJcTcjnOanYMM5nVDA7maK+xmUkmqKhwdWcfs3n31PbtZnyDCWZJF3ANt2Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-371280b8ddfso25321465ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 19:31:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716517862; x=1717122662;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vaf6ixgd8Png0hsiVPaDl/h/gA5K/3vqhx/2V7KxUCU=;
        b=jAlCIWsgPU2yc6gZF57mIvvfgGERXCiQHQQhoripVIKCJhag3+uNAavYk5NKzJ+3+a
         VAANwG/MUPYpc5iyG8sVDlgw8REfReDcJFhg2pYZ5RxmzElr6PrHmDVG1bYTraG9H/d5
         yL/hVf5H25qH8tJHCNPtKQwH+kbMHK6qhcGO/eNl9KoZyksP7cYMSDeGpRBx3jHqKD56
         8RsitKyuAbL0rGvSLQ0I35/SCI+TrZq1n/JJh5OaoOHGitGCG6oB/5tgM4NPKyekGyOo
         KzuCImkeO2+57PgNS3BBuc3V2YNnnuXoD1o7UQlovgWBuhZwYcPf1kGpv06I+T2bw0bs
         WDKg==
X-Gm-Message-State: AOJu0YyQCVtNLetLuyPCXY4s6V8ppEqWCwByekaNfSv/80E8Cogx3ls0
	Bu6jnMR7oRnx26lT19fuZPAruwAikprY4InH0/r6Hc4CBkdB8l3aS9+2XQ3usSZw4yYZvbmIM+I
	2UntK0/jXYnB8ShAWzJnAg1QkJ4OR4uHUMtuPHi+Du8Ns21F6OuVDfiU=
X-Google-Smtp-Source: AGHT+IFWClzCgcboJPZ9l/HQN34nZajiVJZiMpSYVfzQBO8FBsGsRXMY5Ymv57/M5GAtlrdqXEsr4kbm9UTem1snyI6oEwOrlxMq
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2182:b0:36d:bb86:f6a7 with SMTP id
 e9e14a558f8ab-3737b2ca590mr451965ab.2.1716517862623; Thu, 23 May 2024
 19:31:02 -0700 (PDT)
Date: Thu, 23 May 2024 19:31:02 -0700
In-Reply-To: <20240524020717.1126466-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000073dcb2061929f569@google.com>
Subject: Re: [syzbot] [fs?] general protection fault in iter_file_splice_write
From: syzbot <syzbot+d2125fcb6aa8c4276fd2@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+d2125fcb6aa8c4276fd2@syzkaller.appspotmail.com

Tested on:

commit:         33e02dc6 Merge tag 'sound-6.10-rc1' of git://git.kerne..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=110c280c980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=25544a2faf4bae65
dashboard link: https://syzkaller.appspot.com/bug?extid=d2125fcb6aa8c4276fd2
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14f2c0fc980000

Note: testing is done by a robot and is best-effort only.

