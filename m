Return-Path: <linux-kernel+bounces-299396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD1D95D3F8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 19:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE4BC1C20DBD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 17:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055E318C337;
	Fri, 23 Aug 2024 17:04:06 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F883189B93
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 17:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724432645; cv=none; b=uQpfzQXmopiGHVw33bZAXEUk1T+UkwEckWh0sV3gv6+xJZfe+3x2EQ8MQ3d5pzDThIBODckWEOQiDORAQ0mgS7NvbNAs+INUiZ6Mtrz6EdSz6TapyyMUpgOXFsNNZH86p9IMuVYb17nCXPuERQs0zvV3sr5AP21OlbICZ77w8P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724432645; c=relaxed/simple;
	bh=d52yvE/GYjtRqH/BG615idReOKNPIC0NfKnLvSUl/fE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=CT74gkvd5E8M74YJxHgGlubEoSOoJ8g9ZHlw+EmYe6X4+5HzkLcIQmyh6krgdsajssw0UfuTLUI24+fK8r5Ih1ezv6DI5Pe9UNCuiUy619P3ugbOvIBr/MvYHnDU5C45C+OE1y/ZpBg4cT/zrolbCq0/8b5ex+0oPNqBAzg4qFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-827878b991aso84874139f.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 10:04:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724432643; x=1725037443;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C90LATNSBhaqimddlz2BNPSUAb4V88NW5KBiyu/pYlU=;
        b=TCjvGYzlJakMCXGyL8M0igUun8v2l0x7dPu7LlRyNQMi41jb4vYB8HokZDryjSZJ2Y
         3Tsl5eueeDUUPgyVkNR3m9nj9hbdgkWqqsON8Qd21pjdDTqQ5YT+flxlUlZJxs7ZhTl8
         TqfLqv4Ux7PnVLteEAIpvepGKYrrwkYrVFh6qtJlUW5QzpSdJ9+bjjEGxTKKAJvJ1MBB
         JoxkWh472nC8Pi1Ew9E2pfGJ/qMv1VGtAm66xSJumG5+q2UJOthvyhX0UNNu5Yvh5r4c
         bA5RnhENZYvrVmrz5lkm/3rcFWu5N1w6qzNS2fNdrkE9DKZhWW6FgjcuCxEb/+2MpHvE
         6V/g==
X-Forwarded-Encrypted: i=1; AJvYcCUFKQgVxIlYgWhluUyT6wEOhqL/vIwj2PIr9wstI49DCWEoqPp25Gah8TM/4ozX1JVSPgluHRGjwswjR9E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6WylVlPJFkO4SrBQ3uhnquNpZ04VW2z5alhePgTHGQgSon2Z1
	KnAGOb5mVyLerTwpUmj6GzGqX01jKbdfUocEzcPIkEE5tI2RxOEs6T83ozY0wUj3VaIfrrukcGp
	mSf/QSugGJm9w4P/2KvOAymE+eibnSzZpwkKOWasrhWty3b3YW0Drxvw=
X-Google-Smtp-Source: AGHT+IFBmAADJdsN/l27OcD/H0mOuFBLnQi6NU+2NsX5l5JnMIqU8dE4kd+bP1rm4UI0idvL8U9MYnxvlEdHE4Mrr7LAnFzOJE4j
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6185:b0:824:d7b5:451 with SMTP id
 ca18e2360f4ac-8278711c99fmr8095039f.0.1724432643468; Fri, 23 Aug 2024
 10:04:03 -0700 (PDT)
Date: Fri, 23 Aug 2024 10:04:03 -0700
In-Reply-To: <199d972e9c5748a3b18a88feff01aa0b@paragon-software.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000273ff006205cc30b@google.com>
Subject: Re: [syzbot] [ntfs3?] UBSAN: array-index-out-of-bounds in decompress_lznt
From: syzbot <syzbot+39b2fb0f2638669008ec@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
SYZFAIL: NL802154_CMD_SET_SHORT_ADDR failed

2024/08/23 17:03:34 ignoring optional flag "sandboxArg"="0"
2024/08/23 17:03:35 parsed 1 programs
2024/08/23 17:03:35 [FATAL] failed to run ["./syz-executor" "setup" "fault" "binfmt_misc" "usb" "802154" "swap"]: exit status 67
mkdir(/syzcgroup) failed: 17
mount(binfmt_misc) failed: 16
SYZFAIL: NL802154_CMD_SET_SHORT_ADDR failed
 (errno 16: Device or resource busy)


Tested on:

commit:         7529036a fs/ntfs3: Rename ntfs3_setattr into ntfs_seta..
git tree:       https://github.com/Paragon-Software-Group/linux-ntfs3.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=10e2bc7b980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=500271480f7d801c
dashboard link: https://syzkaller.appspot.com/bug?extid=39b2fb0f2638669008ec
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.

