Return-Path: <linux-kernel+bounces-354825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A06B399430D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 10:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4979F1F29682
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 08:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE7E1D07BA;
	Tue,  8 Oct 2024 08:50:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118F177102
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 08:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728377405; cv=none; b=J2X2iB9qQJJfrY+a3tnVpVZWq21BE/3D6okQfzQRanwV8dNzfv18yAOk1s1B64LQFylaicjtd6ECEgt0vofLJf9lYFqpXW9I1hMwVp4IikOBroOAabyLK0fYMHgXSBXQYXpjuYH8CG0H4LgQt6mClZ6DywdmK4ZUXTI1ozZfS+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728377405; c=relaxed/simple;
	bh=U1ovfypYMIhQmtiZi2K/KRO7l4WfNQM2nK8I2rd0ucQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ZeJ2YKoOJd29oI8uwwantPtvSzum+gEsse7fu9Aa5+PlpwyEnvzgyVAsIwsAKGW1OwdFEs/aVf0crZRxhgFI0YJ/dLc8Og9j99hVFhvG6o+qFQ84BgZaIFsIwaqPMC2AyS+PsVkmHQplRCf2E6b2JyAVrGmFIe8zWDQ2wIW8kkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-82aad3fa5edso448579339f.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 01:50:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728377403; x=1728982203;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CBvKpDn9GrRhj3YxBgIM7qO8I2+gyEgbuwpf8yiHtBI=;
        b=D1C+Jez7nXIn2EI1U1voWRD3NxBdxzxeESy4bzsp6abAqQjrAoOYYFI4L8wwg7Azrp
         Ed5X02HmZHi+rdN0bq6YJ80iTcIyt6IuTm9n41h7Us5+kAqDlGCht7tfb6jSNYc4xI+W
         hwRX5+d+9V/f2NjhmyAPfG8267SuzIX9ZApGR4dRzn0kYQzvs0SH0mos0ymCvwsB8qb9
         /z2imtKlNe6HnsFH2sClkOS5vXGXbuM0XXOKsbSJQJEz+iSRfvudhG2+itO+ZdbSfCWq
         BiIEhSvL06tp4Hc4nuvHdUx+WU0LyB1sN7s9Spq4Ay5B1HRu1CsksFe8ajSmCUVEXExg
         pxVw==
X-Forwarded-Encrypted: i=1; AJvYcCV9FX7mBKad1591Tay+EYAJ91iZen+BaUFcjm4k2JTxOpiIDf36Ggos03zocdlQRmVDG4jh8lD3Abehidc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf/gfAjYKfOx0Kx+9Ykp4/QuW6wxKn5n8j8ZaUktinaY4p3Lda
	pNZ0CAc2gWp71MyefB0FlQq2I3K75k3TJkCS1dH6qXpFGl7f5u1BZKBFE5OVBjIYUDsNXAshjBq
	x3sXleCApd0UNf1Vnr91fdIhFAhATT6IhZf9yQXzivHmyapJwPWcrqB8=
X-Google-Smtp-Source: AGHT+IFA6pdilpZEWRCu6RFnLR3T1nvedPKJLWW8oYyLLPhmY98zuXMLzPfqjW9gE8T0n/whKpmWeJNjitTfQE05EeLoE0Z6Wp7c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20c5:b0:3a0:9244:1916 with SMTP id
 e9e14a558f8ab-3a375a9e8famr137522615ab.11.1728377403354; Tue, 08 Oct 2024
 01:50:03 -0700 (PDT)
Date: Tue, 08 Oct 2024 01:50:03 -0700
In-Reply-To: <feacd590-f315-4cfc-a8c6-eb664cc6350b@126.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6704f23b.050a0220.1e4d62.0088.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] UBSAN: shift-out-of-bounds in bch2_stripe_to_text
From: syzbot <syzbot+f8c98a50c323635be65d@syzkaller.appspotmail.com>
To: kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	zhaomzhao@126.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+f8c98a50c323635be65d@syzkaller.appspotmail.com
Tested-by: syzbot+f8c98a50c323635be65d@syzkaller.appspotmail.com

Tested on:

commit:         1ec6d097 Merge tag 's390-6.12-1' of git://git.kernel.o..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=140617d0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6265dd30e362bb47
dashboard link: https://syzkaller.appspot.com/bug?extid=f8c98a50c323635be65d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1105a327980000

Note: testing is done by a robot and is best-effort only.

