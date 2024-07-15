Return-Path: <linux-kernel+bounces-252401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D5D93129E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 12:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A0C71C22159
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 10:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0AC188CCF;
	Mon, 15 Jul 2024 10:52:08 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EEF18411C
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 10:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721040727; cv=none; b=ib1aul1ocEQwawrTt4zAVGs04kXQvqNxuK4jzFqecLR6s4B931xnpvHTkVTnIqTWlCBf9SIOZ0JQzhCVW4rCC264k506rJ9J+e1/3jFF/Ktbvk5gr73INeF1xZOVsD5JBB10QoeZxKeMMSqt3Aerxv9VxMJu2AMTASySqdjCMMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721040727; c=relaxed/simple;
	bh=lcN4KavA0Hc0z5/aOXmhlMyjr32GnGv9eOQqvSV0dNM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=mGdxHy6M++0uay7uidTpu3AXh34ThUzoIAVS/hB2e1N21sJ6vXnqkR6dy5uqyV2xesUpmQ+to/mkZV8DutF0UqCgk2xFzEidna1u6A8XvKcbOdgpH0fw0UZxa/eXZro+Gg8OKaV+gitXKt6FjaIvKY6Dteyh4iEn9wL0G2NHbts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-80ae24094f8so284411639f.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 03:52:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721040725; x=1721645525;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ji5sXQmQy+aXhbnSrquhD0auInD0NO3x3czhoMrHKA8=;
        b=C15l+XU2Z8vMcdmea2IpUh2A8qB21TmsP/Us8/9j3cKvRG5eKhh6BqojOGTJ+yhdpX
         +rDVVOgOvqKBPEyE2tn6ttsuqZcB/EKI8kt/US3qK/DALJidDQejmRREhNFzPF8/dbzu
         xvssThzr4AkTtO4GH0f4cFu/vjtZ5gGr17pPhCpv4gbqtgEMIzdPfx9v0Hrn/J8A0OEn
         3IHEjHWiTHOqozw/rZa/CY1VOOcWSEAknL57J4COLJnVTJEkdSIoLYPrPunytJSOg0fP
         kigpB+9rAafL/2ZbxLG9kw6IC24XZMyHGdfv36hmTGSoemkglW8SlGcHQkkQrg64Bouk
         O2jQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXbXcl6PxTaaAcsYUFW6Ga6d4JwTcUWC85LXiuOkEmyyxa56SczfDED6ijbRbPW1VzJRZYgCMTSNkUTnzfNM1sehN53sTb/pm9kFe+
X-Gm-Message-State: AOJu0YzQrHEH3iS+57D04OJi/r1O51bwQjAIpNm/KJ6yGAf7haRxfU6i
	v9vEMpRcXjU1EdicfevHPckzGiogCrp64iAEL0xVMcl/qSvDUXN24ijS2cyi0iCRakVmxryMFYI
	ga9CLltTF6bb465FjOTHa8qpxQUNSkyQXzeqUjDENLjM3eJeA+5MNC2k=
X-Google-Smtp-Source: AGHT+IFbm5zSAyKSnXFUdtmipGWg/B6EOdbjzPwt1yyDUixPWGWp3dFQUFffZUkJIoxw/FZdAkE0JJJHjzBwL5TstHHOocFdsqKq
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:12cc:b0:4c0:a8a5:81dd with SMTP id
 8926c6da1cb9f-4c0b2b0f8dbmr1251421173.3.1721040725375; Mon, 15 Jul 2024
 03:52:05 -0700 (PDT)
Date: Mon, 15 Jul 2024 03:52:05 -0700
In-Reply-To: <eb49b42d-61eb-4654-81e6-577a6199e0ee@paragon-software.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000148de1061d4705bb@google.com>
Subject: Re: [syzbot] [ntfs3?] BUG: unable to handle kernel NULL pointer
 dereference in attr_make_nonresident
From: syzbot <syzbot+5b6ed16da1077f45bc8e@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+5b6ed16da1077f45bc8e@syzkaller.appspotmail.com

Tested on:

commit:         911daf69 fs/ntfs3: Fix formatting, change comments, re..
git tree:       https://github.com/Paragon-Software-Group/linux-ntfs3.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=12cb942d980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bc26ad11927ab7fa
dashboard link: https://syzkaller.appspot.com/bug?extid=5b6ed16da1077f45bc8e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

