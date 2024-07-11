Return-Path: <linux-kernel+bounces-248711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E91DB92E0FC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 09:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBFFCB20EE1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 07:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885B7148FE8;
	Thu, 11 Jul 2024 07:37:05 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA48329CEF
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 07:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720683425; cv=none; b=pouxVgFakgqXpzBUBQU+NaD9xE9f1jSYPpeCqCYFN5jPOitB3+m8+0HOBLGuOsJKjqsTdbgVAkKcfFuweuXS+EwEqHrcMFnpmWsN/Rtp4oQ1wcKhm4U88gC+mbtPXCt6mg+ULuoWI/nv7Mn/7+wTngq2L/awGyHnQ7RXnooZ7rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720683425; c=relaxed/simple;
	bh=A2ezpYR3ttrX/bq63eFO5j5ZnJ4PcR0U/4jpRULEayU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Fqjl06QkPqiCUznnLfTDtxjzMZTLWGZbCKUxW89VUEAAaa7/utAOv5hM7ro+va0wyyoVvaW0OGHehuO/FqSWEaFjAc7ztltLPqQUOyImH/nDgOAFxMmGPU9gKOqVhRxWZYQIqkDkrw+Y8L53Ud3JcCEi46o0m90HJOGHfzBBJnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7f6530b381bso70004639f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 00:37:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720683423; x=1721288223;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Pp0pNES1MFPjLxBywT/N8nY7ZTqE/24efjFS6N0IRo=;
        b=L1nt2r7DQ0EhcUU+HeXTaNtOdoteLAgCSVnC1jWGNeVm2Hm9dCbmHjyL9X1O9eTHTu
         BzNghffED6hQ9Y2136MZcgOo8qPRq4jP8cPVOSx9fA37TeoI1sZFhTRczdW8hOrDH48n
         QMiv85BwTuA775DllxXHqbH6i8ORUITYvurEyEAJLHvU6y+9mjikMizbTr7Nlsj2LfVI
         bj1MQeQV5gW9sAJ2zY14XQka3qKbEfNK1WpwdJp1tGMXQBILj1xYAaVmg4H7a/uws3az
         +NctfWNwCashXns5UxTRY0vLTLd5O8Hl3QGhMEjIAD/vcPhngTkrKSNWlFcH/yzxswYx
         CuRA==
X-Forwarded-Encrypted: i=1; AJvYcCUBA0nUDkFn7s47dey5/5sio6C7HehBlo5CmrIWzUXieoVVGDBtrpzc1IUi55YVpqjpadvmaIAWKW8c3uyQL+HKolXRlpN5mjOp4ueI
X-Gm-Message-State: AOJu0YwKDav+ZrA1pfIK8VjvpZt/syMHTRTcC9rYIcHm9UweJoMhBn5Y
	bON/S11Zg+8zeoy17xYwj/cXCQ5ek9DBbz0WZvgZ7mkDUgWJmbsh6Sn4H5cbeTXwK30BFfuVu/k
	0GPd6JP6CudJRacPiWXp4rrCjOLpMXWRMyftDqbsOZZq/qy3cgc/6RQQ=
X-Google-Smtp-Source: AGHT+IE+E1wvVpwW0IRISHm0yhA1mPaWzLXyOChuUjzyPUAInkL5ZPRD3nXQropSX/83UpIereEwhPnmTy8Fs5VLC0eOD5I4Wt6x
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2416:b0:4c0:8165:c395 with SMTP id
 8926c6da1cb9f-4c0b2a93c4dmr809715173.3.1720683423040; Thu, 11 Jul 2024
 00:37:03 -0700 (PDT)
Date: Thu, 11 Jul 2024 00:37:03 -0700
In-Reply-To: <086e91b5-4afa-40e3-b8a6-f2734761f801@paragon-software.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003398d5061cf3d49f@google.com>
Subject: Re: [syzbot] [ntfs3?] KASAN: slab-out-of-bounds Read in mi_enum_attr
From: syzbot <syzbot+a426cde6dee8c2884b0b@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+a426cde6dee8c2884b0b@syzkaller.appspotmail.com

Tested on:

commit:         9d9a2f29 Merge tag 'mm-hotfixes-stable-2024-07-10-13-1..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=106c2e9e980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bb254077242b0ab4
dashboard link: https://syzkaller.appspot.com/bug?extid=a426cde6dee8c2884b0b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

