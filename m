Return-Path: <linux-kernel+bounces-565348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04151A6665A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 03:36:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C467189CECA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 02:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D05C1537C6;
	Tue, 18 Mar 2025 02:36:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CAA4A1C
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 02:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742265364; cv=none; b=qryqjpMUiaRJH0CEP1a3GijXO8Q2S33jBJl58CDcr0LYK0Tk7bZuhleUQeLXVyOx/0UZCYe8HLVemXH3xHiR2IB+g9ocu0xBnVoqkDKArkhfKqvJ1CrNke3iEZQLAO50kEmq71qUwDQV7B5aJAN7BS8xYjl11bmNnVstwEVsTSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742265364; c=relaxed/simple;
	bh=yLbPsJpX5l9l1vukAvQwRO1EBI4s6UqXU2+Dt6fB/Jw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=JPWf4i2QEk7lHd7VFjjlrzI4ewlF8tTGzYEtPq+ShhQMZkBrN7Vis0qrjPO4jvDMN3krOgjEJo+fz0a//ckze0VzIJpp5yXIf7Bvq+Vw+mxj3l6wKXoVKOyU4OI7yDvMza92bqkrbwx8UiQm5QNGAsOLgTb+tFTwQOb7+FqJMYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3d44ba1c2b5so50475705ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 19:36:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742265362; x=1742870162;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4nJdCh6Gf11OxlXB1CSQBT59U7RCoF8rS55tQXuNdHc=;
        b=thlSvPL7gxQoR5T6EQ4HXa2njXTODVIYKUDu4QLDtOPa4NrI0b5gAvKlpEeX5TkgZ8
         C/eFZDMqhVJXtn7WXrl9X2yza6pBKxh9IA+PX9+8p12OsA/TAXniGXs+HeCcRW3DRl+t
         LLIUUwZnHXF+mx/7NV6MqplPFfwSLy07jnUXe/VLe18YNXKg30HwarxfJ9BZPl1QoCRe
         ycq6UXgIN1LWcj3heXupW9bfaS5hbfKAx4rRf8uN+ThV/HrsA5KbMmUyIRcySGj5IGP6
         juElxuQbdegS3Q6v5uG/IFgAuVh5YPI+y1OsY53ybrYlp903hmRnRuTlDqJlnIfaZ0UB
         5Etw==
X-Forwarded-Encrypted: i=1; AJvYcCVhOG/1sIdxM61XzmPbMqhIetQR0cY0hidXvlEEgbEOPNoEF7KDNxS3afUXCxLaQCCo7Bg31E3aL2GySS0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywdu4rsWpkPVC/sHFO8IaW2sw93iUtheIwjvy4/F7pNxKfFy/3t
	cqmYSbiHb9XQ3I0WJmWsl5K2cp/rB+YF5DcBGWG5XVFVhKjrG2Z3u1sOEkVdDh3iQS5Y8ajmQ8C
	kJAgTtS4G41vzvSboMQF7b1Uih92GUZltT0l4wXgKeYzkCA72Sw6ogBc=
X-Google-Smtp-Source: AGHT+IGF6ZsC0jKqmx4rTUr4PpbPlwXT39yKkqaQlKGsWDDoPfiRExlruciy2COoRaiVkNksork3Ii6G2TGn1X7epUD+PuOBWm4q
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:4615:b0:3d4:2306:6d0 with SMTP id
 e9e14a558f8ab-3d483a7a825mr104836385ab.14.1742265362655; Mon, 17 Mar 2025
 19:36:02 -0700 (PDT)
Date: Mon, 17 Mar 2025 19:36:02 -0700
In-Reply-To: <tencent_DEB361637AE96D43A8C447D77D577626C705@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67d8dc12.050a0220.3657bb.0009.GAE@google.com>
Subject: Re: [syzbot] [wireless?] INFO: trying to register non-static key in cfg80211_dev_free
From: syzbot <syzbot+aaf0488c83d1d5f4f029@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+aaf0488c83d1d5f4f029@syzkaller.appspotmail.com
Tested-by: syzbot+aaf0488c83d1d5f4f029@syzkaller.appspotmail.com

Tested on:

commit:         4701f33a Linux 6.14-rc7
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16a3d278580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2e330e9768b5b8ff
dashboard link: https://syzkaller.appspot.com/bug?extid=aaf0488c83d1d5f4f029
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10c4c44c580000

Note: testing is done by a robot and is best-effort only.

