Return-Path: <linux-kernel+bounces-335016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BDF897DFBD
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 03:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC46D1C2092B
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 01:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607D81925BD;
	Sun, 22 Sep 2024 01:19:05 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BC7188583
	for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 01:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726967945; cv=none; b=S0DJRQM3xaGwB+MRST6nU05eLCyZct5scrwCwFcUdu3OjrVgweMcom79P8jF0egNToKrOSJDoELf7L3RDKuDerD1ONc0QgXLpoi4gHDSkqpEefd1RyHBC0Eg/PXUbzJgo39Rmlp0sY0l17GrBr6W3bF5D1fhcIzXtguhj1apsJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726967945; c=relaxed/simple;
	bh=rNrRz3hgW5IQ+IZGme7PzvrNMyFphXtS+Y3BazJ0Kic=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Dy2Tf4ijq2enoq7rQ9kn2V/PgfmKkXqZKDLd/RNN8IrPncg47LK59d2mrv6F1aFdyP8yagTTJx0L91NjbLQzZaq4QMLR9xpIJlek1I9GAIOccJ5LlMg4aFkCYSmJe2NVppnKavGNtuXG2vXdMQcqIjtuaH2thpUKJvpYQnH5yYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-82aa499f938so335603339f.0
        for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 18:19:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726967942; x=1727572742;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uvM8Rz18gEAGpsbNvgCZqKsfFzOOvHnRVBzZCPxnKds=;
        b=sTqQbRZd7BvrCI5OSZUK3Fi7vzqDjYDgKLsd+Fue/8O/aLwqr+H7b4R8YvRht6RzBD
         qkts+K4W3Zm5rXPW0LiR9lHVwTQrci4xSLJOn4crJwzOv8s/8N4e8niwmW6h8rV3pBp6
         XkorVsZQRe+ImPpSKL5T8H2YJsGvrn7xZrVbqbLkX7jU1wkSn8M0MBwirKm1ApSoBp4q
         i94QF4b9wPjIO1tRm0Pqzl0xwBQg2zYgVWBhLFpCecqIfPEwATsvqxSt0uXB/cXqblIN
         obJjTVksF2fV0/oLxs6HQ+0ZChM5gkHY6kAkM/FJGgL0nuMk9LsEWRVwuPb3G1jF9p0B
         XtYQ==
X-Gm-Message-State: AOJu0YwmlZLQ87n76UVrm9DBHylHfmmpDBIoeIHDT/w8pMzWaxY50TJ+
	tCNmP7IoPn62EUjZE4qF221BGvEY0cr7z6C+MLVhLfW0mMKOov3Zp5QcWBs4hVQVJnZCwDfwJhv
	mKLcIiFLbIRWeBjpHfBugR/eHiwiHKuOC38Ii6YP3wWEL/xAlKaDg9Fs=
X-Google-Smtp-Source: AGHT+IEEXaNDaACPwIt1e1XWGIymd0zTBzrGORqrmuCxmuVcIIOZX2M4fKkRCVtipEJFR5k/kW5OkEDmyQRsni3DlJkxzCOJIaIE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1809:b0:3a0:9030:e70b with SMTP id
 e9e14a558f8ab-3a0bef528f7mr86683745ab.4.1726967942573; Sat, 21 Sep 2024
 18:19:02 -0700 (PDT)
Date: Sat, 21 Sep 2024 18:19:02 -0700
In-Reply-To: <CAABpPxThJayrg+ziEZH7DzDvTRVVBMtGA+urU18C=vStBON1WQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66ef7086.050a0220.3195df.0077.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] general protection fault in prt_str
From: syzbot <syzbot+37186860aa7812b331d5@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, pvmohammedanees2003@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+37186860aa7812b331d5@syzkaller.appspotmail.com
Tested-by: syzbot+37186860aa7812b331d5@syzkaller.appspotmail.com

Tested on:

commit:         88264981 Merge tag 'sched_ext-for-6.12' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12928e07980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8d53350f32cb0be2
dashboard link: https://syzkaller.appspot.com/bug?extid=37186860aa7812b331d5
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11f48e07980000

Note: testing is done by a robot and is best-effort only.

