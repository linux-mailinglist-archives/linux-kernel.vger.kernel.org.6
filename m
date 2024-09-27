Return-Path: <linux-kernel+bounces-341221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F26987CD5
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 04:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B9AB1F2261C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 02:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E987E290F;
	Fri, 27 Sep 2024 02:05:04 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F2414D282
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 02:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727402704; cv=none; b=X5cnDtql06RpMX211XR8TG114+CBFMbqvUQgZtYFJZzVVv46vmPcXVvm202JtQmgch7jVnwVa/yyPp9e9mVfqC3hjgIetim1qhVnvA6piwlcxqqCvXCWrvNYGo31RNQDu8gdlbQvec6tFGtnCMD0vwhty5Pbn5Z2OyL1cytfrBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727402704; c=relaxed/simple;
	bh=OHyvCo9NiAIpi8C7XwA/tpWUbjNyO1z7zEGBzofv0UI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=BJj/cjGTko+kLTFlt/lqSLZE0ofqUkCTbtlQiu8Md4sDQz7D5yMKKa7M/WGdSbJ8RLGgp+h+8V0HHvMThBl4ycoyzifgw1OODnPCTTBYEIHHIqJw13PCgtKcbciSSNzjQkR5qAifO2ocFCOQKV5KhWCY32DOy4CKRnuOeZIVFLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-82ced069d94so176062539f.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 19:05:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727402702; x=1728007502;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=URDsUQT57ZVIt02dfN1M1XAVNfSaTLuQwRlPHDLTxnw=;
        b=PqHP0UCawK/SEs17oU+t+ulJelueeGpoIr6Olbf/wGvchB+VsDsIW+vrXCpEONQpwR
         IqfTKrPIXxeN6tKFAyejm0nMsktM6IMGfMNYITVu2tWutfUMXEl73/NckjIyGLBbv6YT
         DWMAFm7sls4EJDhbIEHiDxH/rLiUVLF/8uDxBlOkXvWn9Wz0HLJkT4mBFhCzduy2IrXA
         10utfMQaubU21LEH7hQpHwV7+aCFApWnGD3Ue7dNiSqfZP0bQQuR1u69+zh6rs87yUDt
         3o4Qq9qLtYFlJG5G+WwhWh/oZ8JbqclsLlW5JJxuJeKG+6/DTri5/6bQxhvgAEBd4Y2Z
         PF/A==
X-Forwarded-Encrypted: i=1; AJvYcCWupEH4WXluP/V1hoKjQRMGpsQj5JtHHABqUax9R8XV8K3uUaQIShOZpsIhVv+emYcFOlwoXKveIzb5FEA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzrp7bD+suGyxbug/P6MzsW3IHulhc1+Ei1eRWFYX55zOfrxtIw
	FbrUc14JH9CI6d5d/t9CCXBOvwSDlC3j5Y4hbNXSVTtD5b6lfiR14x3MPEi7LMfWa6gx+HdvW7M
	TO3T7pzYK5IULYTUaiw8MWCuOBLDms+6dfMdpGmrmkV4QZwgYkDp5cxQ=
X-Google-Smtp-Source: AGHT+IHHvvKoVaJa3WZYWHvQJAtTmIYpqzTDBC/A3KV+fSDHUB42moVaaXXLcAcjwlIQCYmUHWIBplbmefoc68WBJ2pDs7ywEG+b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:216e:b0:3a3:4477:e2f0 with SMTP id
 e9e14a558f8ab-3a3451652f5mr16621045ab.10.1727402702428; Thu, 26 Sep 2024
 19:05:02 -0700 (PDT)
Date: Thu, 26 Sep 2024 19:05:02 -0700
In-Reply-To: <20240927013806.3577931-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f612ce.050a0220.38ace9.0006.GAE@google.com>
Subject: Re: [syzbot] [serial?] INFO: task hung in vcs_open (8)
From: syzbot <syzbot+8a192e8d090fa9a31135@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	lizhi.xu@windriver.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
no output from test machine



Tested on:

commit:         075dbe9f Merge tag 'soc-ep93xx-dt-6.12' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1305aaa9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f7f1af2ec501f918
dashboard link: https://syzkaller.appspot.com/bug?extid=8a192e8d090fa9a31135
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=158be59f980000


