Return-Path: <linux-kernel+bounces-251436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB7549304E0
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 12:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F49D1F21746
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 10:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 958B84965B;
	Sat, 13 Jul 2024 10:03:07 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0EF83BBF6
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 10:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720864987; cv=none; b=SJ4h7moHLeqXtiqc6M49i9/ilrqmD1bv0TowOTH8HSPzCogZIlFSNHPjMJc5lo3OJzNwOb0avi7bKRDswwufGqknrXsxXz2F/RRCyH6euRmZDnDjtp3GdU1C/S8rOEj1192tF3GZSaMvzWXKA+R1Gu8pItxPQOPGD2eeKDXLuCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720864987; c=relaxed/simple;
	bh=LSAmyxGPxbogN4d0LlvIlwcII5kiag9IcPUp0X+hmfE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=nB8HYzZ0WV6YJZdJRQvFaFaYLRFMzKs0pF8V/15BM/UNntAPb/VnSorKC1YxiC55d+LNOJPiAHaipGnEfin3D2a2tvAs5CZWDkTLJUavqxKAnvOVG1BE61JxDXYkx81BOQNIGZBDh5YURZtbZgd+9AUjCi7/cwc18eVX2pCcWpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-80ae24094f8so126040239f.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 03:03:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720864985; x=1721469785;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HyvjDO0p5/NKn0gmyYqUlbQqZ7pAdjlwQcbwFfCEJ+A=;
        b=VsG0MEaxmInsjzwENsRuD3HnUkUvWthouyKEOt09vW5UdBcJ5ccw5HtV3pUvrWXOvo
         gRSWddGXLc/4E0b2gNYOB5gYxCf7FL6PBijMu3VKcauJcXfzc45Zdsk1l56aFh7XK6ov
         HawMvDpkZ1ILsYBoma76vLVCfZVKv+pyFmycJy3CqLUBhg4MWDKPMp007vw1qRfB8MOH
         HdSXzf8i5WKjRgRXQselKV9+vG01d8kGYuZArtN8w5j207hVL/HhduV7sVNweNrwZfeZ
         ceVSlsVVDunkUI/SpMZv1mgxrBvznp6NU01gpU0ynwe55lrvJhQJjFs2EuafEt+DLhEK
         wIaw==
X-Forwarded-Encrypted: i=1; AJvYcCUlwotVoBsoNI9mTcGShhUwKM33ISQ0YEpbM/cmkHGRgoZLLABNonFTZT9FhlgGbkvqe4+qo+IqpJKgdkreMCz4CExwWAEbna89k3Dt
X-Gm-Message-State: AOJu0YzpKnBZe8AjgatZA/HklR/xy3q5CUS2PLOur21rrnFgG0DdhDsP
	TCD4iQO1eLBvOKQRIRL9gRPY5fB/Q2LeKXMX4Hk1c/AKgZwn6vY9jpZdguHrzqPUHo+iOmFEBdX
	TBNeA2Z9Wbq5urh1uVzZCRUgbXt2yGew14b/hM2LTtT/Shzv/hkRsisQ=
X-Google-Smtp-Source: AGHT+IG/d8gWvYGsmgpjfE3NmA4GY30saKFZrFiDkQsLjbCXWw8jV33wv6G82tbK5dewlWjo1yIYDtJ1UW8jeMz4ntDQ925DPPAP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1509:b0:4b9:eee6:40d with SMTP id
 8926c6da1cb9f-4c0b2b91a68mr799540173.4.1720864984957; Sat, 13 Jul 2024
 03:03:04 -0700 (PDT)
Date: Sat, 13 Jul 2024 03:03:04 -0700
In-Reply-To: <20240713092925.927-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000229f19061d1e1afb@google.com>
Subject: Re: [syzbot] [io-uring] general protection fault in tomoyo_socket_bind_permission
From: syzbot <syzbot+1e811482aa2c70afa9a0@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+1e811482aa2c70afa9a0@syzkaller.appspotmail.com

Tested on:

commit:         3fe121b6 Add linux-next specific files for 20240712
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=113795e1980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=98dd8c4bab5cdce
dashboard link: https://syzkaller.appspot.com/bug?extid=1e811482aa2c70afa9a0
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16d43b6e980000

Note: testing is done by a robot and is best-effort only.

