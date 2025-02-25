Return-Path: <linux-kernel+bounces-530770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C99A4381A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 09:52:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EBCF189C17D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 08:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4879325EFAB;
	Tue, 25 Feb 2025 08:52:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F6F25D537
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 08:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740473525; cv=none; b=ARlxR1h3KFLiefr4ZfTwuT/YqLTSiz8baUBLO49keENpLoLG1ggbSsb+U0FfAH2GbhHIIf5BuEdv7vOiftcLxsa5KcYwWYHyKKE6WDwSg24qgQ5/+7VYdRkLjpT0wRkuKdqUUJMjLYyHgElLQXAHurcGF6QXqwbqXynuGI0F+zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740473525; c=relaxed/simple;
	bh=OHEnNbaP9MRGpwpX/IDYHnSTGrNwvreynXWVTjI4UaU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=dO+Rl80Rk9gTmjZIQftDozZGO4HjmxRDn4alqFn7dILMt8hWEFXuS104/QHT5eY6zs2U86UpyxTnxtSuAtDTOKzS3xgKtp6XWz+WN8cgaIVaGhRrVD96PNurqy+jNcSBXe6Y53LP8RUHlokWgtT8tpyblS7Bz+ex4FhqwRIHh7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3d2ef1a37beso11789205ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 00:52:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740473523; x=1741078323;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zAts+vuoliq11ehW1oIKE6z/QxhZihrLulmQxsKym6M=;
        b=LZJ5BpfxtUvQaq3Jgo9KaQWeNxAEavS7LO5Md3DIZHleaGaDZPo02I1PNvp551C6Xf
         5pNayhJnDf8oZ9LetNz9mSBCeXPu50Ol4eju6MKJDukHT/c+9JkZxGga6IhEdNsu0wgW
         5DcI/XByqHZ/IQHfrDED3Yrrg+gqgj4+X1qzjWvIu7BNnJyzMJgHMiXth3TLn9jDpo9c
         5234qBz9RRVjM1LaU48DjocFYWUXMs8jXfDLIUBZHeT8nqbgALP020teOqstz1gdKV1q
         Esy0XTAITJVF4dBjLmOmmNmPCmwWzW9F7v6cdxJbjC7x313G5MS8x31Y/PvmcRchdLW2
         CwMA==
X-Gm-Message-State: AOJu0YwsALBgW1bPWBptfNU41+esHYgmoL61aXmqftNTvM++WU7WTZWL
	uC8hZme7Eoq6SYWMHILqqozQOeAvdaB0lPflpzARVgUKDtTFHo385buRllfqkoTFSpgUKqr6aI/
	dcjZ7+PvBT+sEbfA0vpm9D4BDDgv5a4cAm6lMHZdvX4GC/p0IFqoUwHc=
X-Google-Smtp-Source: AGHT+IGCkIS+9TfWKvxEl6VJxh8vZ1UQ6oIhRdFMjEBtdbxYno+JQEtfR78eBG0iP4cTAEJX/Jn7+tFy3SgTeMSkKTUzmUen66Zx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:16cf:b0:3d2:bac3:b45f with SMTP id
 e9e14a558f8ab-3d2fc0d9638mr25898735ab.4.1740473523765; Tue, 25 Feb 2025
 00:52:03 -0800 (PST)
Date: Tue, 25 Feb 2025 00:52:03 -0800
In-Reply-To: <13EF942E-1B2F-4B04-AB8F-5D93DCA7E4AE@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67bd84b3.050a0220.bbfd1.00a1.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] possible deadlock in pcpu_alloc_noprof
From: syzbot <syzbot+fe63f377148a6371a9db@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, mmpgouride@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+fe63f377148a6371a9db@syzkaller.appspotmail.com
Tested-by: syzbot+fe63f377148a6371a9db@syzkaller.appspotmail.com

Tested on:

commit:         5404ebaa bcachefs: Fix deadlock
git tree:       https://github.com/alanskind/bcachefs
console output: https://syzkaller.appspot.com/x/log.txt?x=1273c6e4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=19886416c83671c4
dashboard link: https://syzkaller.appspot.com/bug?extid=fe63f377148a6371a9db
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

