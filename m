Return-Path: <linux-kernel+bounces-442110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D75F99ED80C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 22:04:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04EF3280FB7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 21:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4405259480;
	Wed, 11 Dec 2024 21:04:23 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256D7ECC
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 21:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733951063; cv=none; b=e5Krc7atR+FdrN9nU9TihR+CU0tVP+HT7zrs/ceeMoTDMpSmFFbI+Qgw4BKg7nW1PVSmMJ7XVaV6gvl0a/RJG4b1eRIqJbMQa//hwiSXEXrHHukTC5Jp+XkYFuv75mL4u6HNppSnD0hnhWZXpiiURDhswt007ZpMuVNM3un9Pac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733951063; c=relaxed/simple;
	bh=r5RWI4DUvKeF2ncYKqSt6dWYggoSmrQO6kupdmBnqdY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Af4QY9Ky5nxAjktzJHC/70JCOxklAaLLBa/GRTja4shXld1M25b8MDyUSxq2xXR9Sl7VvkybzDS6+Cz86sfclnjzdy08wvMXMb6zrvYy/nXpRoi3ySpT+ZE0CfaFc8czpi5tjPTLhuLV8A5fo5cQfXRYige9pafcVhQj9IyAoWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a81777ab57so48856895ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 13:04:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733951061; x=1734555861;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2pUPUKzdBCP70aP2KdcRfmndxHeUQS87JsUphvI0xsk=;
        b=Xrjt6h0kpJF4tW4cgv8QBcMMlndV8OA8Pedz92bHmh64LdczREeOBC5s5MbXTreGbv
         yrl8DGWh0Wl+0Y6xNUYL4K2Bg9B0Ua3fx9iHEO0T6pgyC+f5Jl+kP8m4mZAgHeeAM5cA
         n7jAQsV6hCwA0hLtLuTWcOElg1sJMTLOHr/Eyl4Uidy/a/Wubjj6QS0M1j3FAOOBUwOQ
         1JdGn4+o+eU8rYz01G/8Jpp7Pu70rHKGLcy+oVuIn2Y8RNcC12WF9zm9Y6bkDjBDAC/a
         b5ntIEGkf1vXlALJMo7K0U7+I/NwUEdD2C1O2UMG5mN3S+qFHiSpGe+J5I2xA6Tq49KQ
         GpuA==
X-Gm-Message-State: AOJu0YzIuMDExBMmMvw5rjEreK2eqZtuyNU4QFTRq15jGLlcCAYUEDrq
	M87hqZ7hcRBtY4GYhi0rcDJhb2zFLH/1Qz2ezsWPcW+hcKFbW053+70jf52F9CvkuxQPw4Yvuz+
	uw1QuepRN1S74POr1CWcxwIx5XUZsqk93EDycFciSe134oA0aMsuI+gg=
X-Google-Smtp-Source: AGHT+IGHCWSTEwIuKYrWGUbiRGy4BuuiYSgyClOR1Azlzg+DML5ukCAg4Wc65CbUPulYcsXkXUhCZpZ5barmMqrIb80Jm1RbHUpO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1707:b0:3a7:e528:6edd with SMTP id
 e9e14a558f8ab-3ac48f8cecamr10118065ab.12.1733951061384; Wed, 11 Dec 2024
 13:04:21 -0800 (PST)
Date: Wed, 11 Dec 2024 13:04:21 -0800
In-Reply-To: <675963eb.050a0220.17f54a.0038.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6759fe55.050a0220.1ac542.0011.GAE@google.com>
Subject: Re: [syzbot] Re: [syzbot] [v9fs?] WARNING in __alloc_frozen_pages_noprof
From: syzbot <syzbot+03fb58296859d8dbab4d@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [v9fs?] WARNING in __alloc_frozen_pages_noprof
Author: leocstone@gmail.com

#syz test

diff --git a/fs/9p/acl.c b/fs/9p/acl.c
index eed551d8555f..1b9681d58f8d 100644
--- a/fs/9p/acl.c
+++ b/fs/9p/acl.c
@@ -28,6 +28,8 @@ static struct posix_acl *v9fs_fid_get_acl(struct p9_fid *fid, const char *name)
 		return ERR_PTR(size);
 	if (size == 0)
 		return ERR_PTR(-ENODATA);
+	if (size > KMALLOC_MAX_SIZE)
+		return ERR_PTR(-ERANGE);
 
 	value = kzalloc(size, GFP_NOFS);
 	if (!value)

