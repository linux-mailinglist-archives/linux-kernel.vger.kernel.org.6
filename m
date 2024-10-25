Return-Path: <linux-kernel+bounces-382256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1E69B0B90
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 19:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30A431C20C0B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 17:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834BF1FB8B9;
	Fri, 25 Oct 2024 17:20:07 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F43F20C33B
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 17:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729876807; cv=none; b=mnxhD/9UiA0POUe6M4htPVWAbz6LgYgwklictwCt98umlxAxiesZn+NbO6ZF6pc/bH5ks1RE45gqIBscquLWoNeJ+d+G5KFOwMXwDJIh2tpDIE0oNhS4tOdHy3V3MHZ7LgmnHbG5234AOCR2tivGzkvnd3CLTUuwFKeTeLZ5aP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729876807; c=relaxed/simple;
	bh=62EMHFhjcX3rGBMzuLvMzPRVswFxaPvXGB3xwXBfo1s=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ghqLhO8il/Tny8ma+CpOfMBYUuOgWJdfB0KPL+5x969P5nKeAY6R6twn8/Fz6IU95T7Sr2Y/Q+reypmRN+BtBinVsmUfCLMYA2LQot58IC9rtI74X7w8ci9f5aYaucqxEz+XYJ3SSODtiiolrI6ZbulDuB9cStVRr/Vmlexk5Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a3bb31e3cfso21933575ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 10:20:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729876804; x=1730481604;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/mtRFivprD+q70qS1YpzZnnWyJYglXFyE4OXmmBy+Cs=;
        b=ua0kqOPL5eG/atxokwNyoYhtu0sf+o4G1rwdyG1mm4qwKNd+KRHzIZpRN9HMvnwRFY
         8cics/fHvWQJY9aBET7CECbvuxVCUfgPvAQvIulgn/dD8nZSUdiqyl7ASdCyX3k3bDyH
         o/T5d88e97RJsaVuAXBbtQ76hrzLmXsd72OYqQYqQjkR+jIH6mnbbmQPbP8t8LS8XQQV
         /d+XORSxVpkkjjXnn5tXLEbTBTtONWgHenEhFxT2LTQIqeei3FKXEkBzn1m7IUmgZYQL
         vdAC1hVII/TTgsglzcsTuegqqat45fmcBAgocmMvTHZLEFV5jteZUMSKLgk4FbtRSzjG
         b6BA==
X-Forwarded-Encrypted: i=1; AJvYcCUXOMU3loEhdZ83nDEN0Bxtt7dBmhzvrjqX7fjiaYzdMa79U+1uqfaCJVrBrpp09R1tJS124rsd5OOngsE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMuYI4a/P5OPRS0N6s+T/tEXQL5YJQVY0IF7VL1UtA53+tsBZJ
	PgV4k2ccR++7ioL89ATzcJynSJwK7ue9FPgxxyEKHAJsWYQbDth5RyR/rxs76MiWbxu4lIssLZb
	OSYid/WX8tb/hUiY/gaqJujB5re7NJvSwKBZVZlQqJIqGdtnBc4PZFqU=
X-Google-Smtp-Source: AGHT+IEnSA4DYG2UnQrJ775IZWFe0RTwXMN6mO+pGvTsTto5I/BPaUB8KP31Z3RuOf2ZYjFLgRGHN9mULujlGzuvlUEm22+5ZsgB
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fc3:b0:3a3:b1c4:8176 with SMTP id
 e9e14a558f8ab-3a4de820c0dmr69655325ab.24.1729876804553; Fri, 25 Oct 2024
 10:20:04 -0700 (PDT)
Date: Fri, 25 Oct 2024 10:20:04 -0700
In-Reply-To: <20241025170010.19654-1-zoo868e@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <671bd344.050a0220.455e8.022e.GAE@google.com>
Subject: Re: [syzbot] [jfs?] UBSAN: shift-out-of-bounds in dbFindBits (2)
From: syzbot <syzbot+9e90a1c5eedb9dc4c6cc@syzkaller.appspotmail.com>
To: jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	shaggy@kernel.org, skhan@linuxfoundation.org, syzkaller-bugs@googlegroups.com, 
	zoo868e@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+9e90a1c5eedb9dc4c6cc@syzkaller.appspotmail.com
Tested-by: syzbot+9e90a1c5eedb9dc4c6cc@syzkaller.appspotmail.com

Tested on:

commit:         ae90f6a6 Merge tag 'bpf-fixes' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1274aebb980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fc6f8ce8c5369043
dashboard link: https://syzkaller.appspot.com/bug?extid=9e90a1c5eedb9dc4c6cc
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1254aebb980000

Note: testing is done by a robot and is best-effort only.

