Return-Path: <linux-kernel+bounces-318864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D70E296F451
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 14:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 815891F231D1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 12:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAAD41CCB45;
	Fri,  6 Sep 2024 12:29:04 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B61613AA38
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 12:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725625744; cv=none; b=jioWdauQuMblvJV0L3/ziow0DVj8MhieLl2mOzSTbVV6n2WZFXvguGfv8lelag89tZx9GXG2huCiYm5BPuiaknc9g5Nf+0GjyW2ssE6XN2hHHZsOWgIbTgYwl/ncXxvESSIPiuQXTaMU/hK3zxe+CQFLCmyC5rY4D2z4EhnIDBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725625744; c=relaxed/simple;
	bh=dXbwhnCtaT/dxZdQu2nYSXGXGww/S6PaLklhSMoKxOY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=OLegCY/RgWaXyvdr+VTuFcuu79FM+mWCvwfXkLeiLEfuovn4QEZLHInCgo7PwsKP04+M+Ykvy5OcSFnkRK6Oq3hlfovJRsfy3oiktlwk6xEw4k8ZTpH5+2wo5hUYMkktQ/Cl247Vbs2gIMVw5gPU5aVcnSh1t+2jYBBrgW7T6gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-82a492c9d88so448180639f.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 05:29:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725625742; x=1726230542;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UEYD1oY504UfhqJVccdAWuegLMKhW4z0eJVt6vT9eLc=;
        b=DOnCuX3yPTgaAC6GBzBVA7qg33lCMLQ2ePGl+prHVT3547fsguF3Yxq/foQFvyMhO+
         9NLyzPagbOwU8CXvCKf7KppHrid9lGWSRJlZmBIJvpDg9R/cFojC7thh10v7r0OlLNaa
         WarXKOv5QVB37TNqqAYj5mQ7IjHBL8/GOT68lZKbmFsiBF/82N/eb4RH2hIT1VH4G/F2
         hLbtuPwPdDVJMfcvpdNJhDNCWupH3RCEoIYOE2z7iM/B80QdZg7jScAFyaC7IHCeZY8B
         16mTmQWKZ3hiFOoEmqGrbCZ3k+P6kH+vpNTHne+/M/U00BUsdzFG/xIoXJZnsfHP2zro
         qVgA==
X-Forwarded-Encrypted: i=1; AJvYcCWUcPIWRdMaysXPhSzAm79Vh8IPYADtuVnyRMntZZwrXZiQ7sW8qa2wnuUrlCuKNHR3QRU2B6ISis4CIF4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4xGZGzbnO2jfFDyoxrhCOgCDflRFGlLbq9P3LV92gi8yxy2+E
	3O16vXrO7jKES+dv95/cWSOqBDc7oqAfzf4DDhy67dinohmXilzlbptk3u6bJaJTKWCTW8gMmrR
	POomPxKdXWjHJNaOfHq/OI9Qd7Fvmqbth3kS+uMaMZ0HXSTG8lmkpkfk=
X-Google-Smtp-Source: AGHT+IH20JnU58cTljlAu1jyi5aQwM/UXcy+QjNuIp+UfScqLEnwgnJASlN6gGlatX9GkcmjrMX5b+YKPhSEcXQqzfRCxg5KWnQi
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2181:b0:4c2:7179:ce03 with SMTP id
 8926c6da1cb9f-4d084e95153mr78203173.2.1725625742240; Fri, 06 Sep 2024
 05:29:02 -0700 (PDT)
Date: Fri, 06 Sep 2024 05:29:02 -0700
In-Reply-To: <tencent_9A6ED2CC9A27D2C6CB92DA0671C98BEED806@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000061cd6c0621728d37@google.com>
Subject: Re: [syzbot] [usb?] KMSAN: kernel-usb-infoleak in usbtmc_write
From: syzbot <syzbot+9d34f80f841e948c3fdb@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+9d34f80f841e948c3fdb@syzkaller.appspotmail.com
Tested-by: syzbot+9d34f80f841e948c3fdb@syzkaller.appspotmail.com

Tested on:

commit:         b831f83e Merge tag 'bpf-6.11-rc7' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10f429ab980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=35c699864e165c51
dashboard link: https://syzkaller.appspot.com/bug?extid=9d34f80f841e948c3fdb
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1404b6ab980000

Note: testing is done by a robot and is best-effort only.

