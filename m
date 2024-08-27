Return-Path: <linux-kernel+bounces-303813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4938596155A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 19:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 857981C22DF1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 17:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A891CEAC9;
	Tue, 27 Aug 2024 17:23:07 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC403C08A
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 17:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724779387; cv=none; b=ZfVr7mdVh/8yAQlZC01eGN9gbom8lTqVTVDFo8D7WRMf69+J46nrSOB/hICFMbUzB3hpM1aNYVwByrrkCZkenyZa4xtI9l1N+7oCexY2xVW/KGgZCpC2XLEMeafaUPb+l10NIQRpQJWYwuNMZL4Nmyh9/dlAAHI9DSyJj39pMq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724779387; c=relaxed/simple;
	bh=z5WtkOgyVbDxgEr6gDqjyRaSzFxi22zfoD7APj/SM0A=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=nOb6MK7z4QcZT4TnMltQbGMzh2L+T9oLkQGvETeqU11JPoQMkXG9z1PLmqWrXuJeji4D+dOOwtkuqirScaLtFRRi8e69SltxpoQJenM/J5tqw0ZU31D1QoCC7IVGt+wOSUEx9ahNTpCscwRynayx5Z9HKksptEzavSATTAYFIiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-39d17abca55so60381505ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 10:23:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724779385; x=1725384185;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L8M/9AdEZqsNgDPK5zvRnKUPHpB97ZEOQo4ACdtVWG0=;
        b=iXzxTY5AJQykIHPj+/pr0PeHoaP8a41dZ2fZTo7hI4pEUx7L9N1VIvHxiGYG4wFH11
         I1Hle6YfdPs9NAYtrRRi6JQbfxDXzSw6RosnWMtZwjgikgmnl6d96ALzron1sf3BN8qi
         0BPusGWJaXqPP0ORIyH7Py6UfjY/nOyallV6y7ozHjTD0A1K3/0yj2HBEf9lAu29R8qM
         geiUKRLPCUbHDEY3uhPLDDf5t0djYBGzEdcoBC4WuuNLrmCvoZ/Yb+MXejjpsuw34bgP
         W06FER/7DKeCQbXAqArqtW9fYkJdDyM2s0sTKCIqL1IFHp6qGIwCMIiXqGBOk2Dmm0ZT
         noJw==
X-Forwarded-Encrypted: i=1; AJvYcCUsEMWJdo7c0mGGpjrnk/U4Twtup9N9FjpegMQ0QevlhKQX0ZmP5is5Ld0LwpO+BUlmPTi7qsS+BoVawzE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCbRZKCglI0zQAh+3KGDHSTZ2WpXI16lm/k6+r6prksZ0G75xp
	0ZtS4Bd4QfpN3dRHWAESGiE2H6Ib3/d7Qh3JpLgkpV/4ibFv0l2+JrRTQkxAGqXVGRqH+bV3gq6
	Bj5KxUliVT8AGAllDOtMsmoC9/xyFKs9xt75CudvYN+SHOuHgISuBJEM=
X-Google-Smtp-Source: AGHT+IHWsK2QSotjdiGy+Q247AE29InoTPPm3+iWB//FzAyF0YbKZBGZc3O0OGAV8UFol5OQys6Zu3cpWYweJnc3DpAtKzCgISZ/
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2198:b0:39a:e91e:38e0 with SMTP id
 e9e14a558f8ab-39e63f100cemr2041545ab.6.1724779384908; Tue, 27 Aug 2024
 10:23:04 -0700 (PDT)
Date: Tue, 27 Aug 2024 10:23:04 -0700
In-Reply-To: <706373e55157441da446a4d634784706@paragon-software.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008dc0d40620ad7ec8@google.com>
Subject: Re: [syzbot] [ntfs3?] general protection fault in run_is_mapped_full
From: syzbot <syzbot+9af29acd8f27fbce94bc@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+9af29acd8f27fbce94bc@syzkaller.appspotmail.com
Tested-by: syzbot+9af29acd8f27fbce94bc@syzkaller.appspotmail.com

Tested on:

commit:         7529036a fs/ntfs3: Rename ntfs3_setattr into ntfs_seta..
git tree:       https://github.com/Paragon-Software-Group/linux-ntfs3.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=1598d17b980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c5ee621e7c3df264
dashboard link: https://syzkaller.appspot.com/bug?extid=9af29acd8f27fbce94bc
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

