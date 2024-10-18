Return-Path: <linux-kernel+bounces-370755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAED89A31AC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 02:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F6431F23310
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 00:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B2433993;
	Fri, 18 Oct 2024 00:33:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5297920E309
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 00:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729211584; cv=none; b=Cc8QJl6nwNHnrWGo64Kjywex0AcN2moFS0CikUxLzbquJkT6gvW8YPvnm/SdbxaCbXJCM6zzYj0JUM2fuYHxEbvc0M/tdccHvJTP2A7gHhs3Q4a/NGOSVRq7EkBXyORKYtQKtlko0t0dpTjSQYxJudjQyQf7Nf9DwcqGHvXJleg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729211584; c=relaxed/simple;
	bh=R9p7wHTzq+3x+zDSE/eQkeLeAYNzA0gWyXlblG0p8FU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=YfWkUyYDLPmfPKg6IJarUrIJHaBUVzcTDnsW0BQGjwhCr/i3tvghq2fIi7WLRmrzTpY5WjWveBiRZveYnPxN0owGiKZL7OODDUPtqG6QbhFdl9rYK2LhA2BPtrhpfNsRo4sT/LY1md6Nv0RnhQkDKATDKoDG6hWvT1xXgS+ZCkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a39631593aso19642895ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 17:33:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729211582; x=1729816382;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B+P9VPEgHEJhWOztHfYizBrLPckKwLhMVOjlybgApzg=;
        b=fq2qq+7J5+5sDAdzHp1kVz8+aPE08YBSLng12ok1nREPzwvTTZQjCNoZkC54hULaTx
         W0fI08QEtRxjVmEFF5jVP3P2JDX6lTVs+y4ardkbvXMHDnyCUI9RsamCFM8uYd29QLY+
         szsoHWINUBPzmgSZF1PKtQH38AqFHcx0hZK48uodJSWChMX4+051b1nCKlO4x0GvqXhg
         B+E17XfUSDq90o1Csi4juluKSnJwIsvm4SFbnoYRa2IiJqm7peWXMPdXWRYpJ6U0DEDG
         pXjF+ZV8I74eceJgwDi1+TnZiLTjTFD2QvjdhrktL9wC/kaPxkxcONUaIg5BiwhdBCkD
         R7pg==
X-Forwarded-Encrypted: i=1; AJvYcCXhPdA2GmEYxt2mRxSnNqqD/JSdXoFqHgBqNdZMCScjHsQneImGsD8ciD4aSnxq3YilOueJlypK/180UWY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2KabTC85shJjySMCGMeK4AKgDDm0VnlKEUI7pWnMpwvLY+PgZ
	HatbZ3dlp59hJE89hf5EdPIm6mNxkP8V1eSuEFvK5Q60x7JCabbEcWBxGzZLaWSylmcL0+sAh5Z
	JO8GMpeX1fMokuoR2X8IaNN3/Q8uUj9FwE7sPrt7Fe8n0xMiPvu/9ysU=
X-Google-Smtp-Source: AGHT+IHwxnecFgp8TgVEHdcUby8Z/HYmniWIaZebCAYZxhPezVjHW050jB76Pj4eM40ZeRFYEg+UXuCRD3/gSSLSY8VriGdVPD53
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:152a:b0:39f:507a:6170 with SMTP id
 e9e14a558f8ab-3a3f41b4a82mr4027845ab.8.1729211582396; Thu, 17 Oct 2024
 17:33:02 -0700 (PDT)
Date: Thu, 17 Oct 2024 17:33:02 -0700
In-Reply-To: <CAGiJo8SRrptdtiax6-NzTJyiPPy1OJOnkAB8yWLGNYasN=i25Q@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6711acbe.050a0220.1e4b4d.0009.GAE@google.com>
Subject: Re: [syzbot] [net?] KMSAN: kernel-infoleak in move_addr_to_user (7)
From: syzbot <syzbot+346474e3bf0b26bd3090@syzkaller.appspotmail.com>
To: danielyangkang@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+346474e3bf0b26bd3090@syzkaller.appspotmail.com
Tested-by: syzbot+346474e3bf0b26bd3090@syzkaller.appspotmail.com

Tested on:

commit:         6efbea77 Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13e6af27980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5242e0e980477c72
dashboard link: https://syzkaller.appspot.com/bug?extid=346474e3bf0b26bd3090
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1332af27980000

Note: testing is done by a robot and is best-effort only.

