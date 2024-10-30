Return-Path: <linux-kernel+bounces-388510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A531D9B6087
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 11:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF4ACB22A65
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 10:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414B01E3793;
	Wed, 30 Oct 2024 10:52:12 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2051E2848
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 10:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730285531; cv=none; b=K2A6uZQM8pwUXArJfmEPM4n0HfCzprkTpmpPcGgwvzaoTWfbuOhmvfraWdhmgVk9Xcdzna4GlLn0nxrPTP3ulV5kiwEz4vSwcle0SrvvYvICLxku3e/2Q+cxwl1+6ft9hoaj9XNWD1kAc0Vqc6xQx30U4MqlOuJjXC85rbxm9js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730285531; c=relaxed/simple;
	bh=kOe7NaPPMJKT/QbP2BkpWIMAHxP/mCEb+4qfjk7czwg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=nEQwjuy6xKRvU9CieTJroVAw0NnnAMOfZZqCDgW+0mKwvNqvdjxIxF6iK41AK8JozzmVuxdyplp7Vxn1AdeSMkxXF09uwz0PbEMlzmSFNUnptKaS7Uw8jTFL23MPeivuOeIruBQBNrq2uQRi0EyGpikQr0ux5ZGCMho6eSbmvzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a4f3d7d13fso33859925ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 03:52:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730285529; x=1730890329;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LeALd6KDuOuKi9qXNLq10f5153cW8xXpkk8Olr/BMoE=;
        b=LLi2mP42x8SfIb7rUC+EU8k2zUCs13lATZLoPuiucyHFBpmsaugVVZ2POhQ/v2RBPC
         mCJlyHNOxg42Tk65icZGBpI+nI+Ll/MMStglezJxBy3AKufaFnx8vbVAUrS6IYniRSi5
         h6YuXfCzU81A+PfYUAHGKD2BbqndMEZz+6vH2LZLRu9SDiN5KIr5Eq9dBMNhIqbMxhdH
         JSRRqsvTtOZUa+F4mu/uzz5o33Coztm9VyQV6cMz3X+kdf94PaX/hWJPZyjqQP2179Ov
         kVvnnEpxWy78iSMcGr3kioizorePgc+Qbjuyf0+qn2a/LHm9N5xnKURVpDXxtD5qHhhj
         b75w==
X-Forwarded-Encrypted: i=1; AJvYcCUyIw0fh/jHk5D/69PCEup/MNd+bg6Mbn0CvfEBYQs9sFHVvJhgsvNJrq/F1+Mk4uGqDsJWso3dIxxmxsM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8BBv+ahVxiJxhpWFewcgiO6ezhHpJDIpw6cyNY6nL0YxWqrbl
	MwlhyfyL+sgtYZrMk9n4Ni4DgJHc4nMJi/5yzsuuVd9s2OS7vKnZw/gpHTBvbxnjnTul4otsfch
	lQ6Oei3Kba8Pj7hRF8ex4OUxbse2+eOos05ejfNyN35Hg+Iet3HttXkE=
X-Google-Smtp-Source: AGHT+IELt0N6Rfd0bwOsR+AY3ppoTBV7RKwQ3Uic1kzPlRch2AJQGJsyjrM2XzMl745KfBe/1rsXYFGnRoHTVp1+131sJzwZGRHM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c26d:0:b0:3a3:b256:f31f with SMTP id
 e9e14a558f8ab-3a4ed2fc0a7mr139108765ab.19.1730285529327; Wed, 30 Oct 2024
 03:52:09 -0700 (PDT)
Date: Wed, 30 Oct 2024 03:52:09 -0700
In-Reply-To: <tencent_93E0C66D49BEAEDE6ECA0C9FA7C786D2D206@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67220fd9.050a0220.35b515.0012.GAE@google.com>
Subject: Re: [syzbot] [overlayfs?] WARNING in ovl_encode_real_fh
From: syzbot <syzbot+ec07f6f5ce62b858579f@syzkaller.appspotmail.com>
To: amir73il@gmail.com, eadavis@qq.com, linux-kernel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, miklos@szeredi.hu, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+ec07f6f5ce62b858579f@syzkaller.appspotmail.com
Tested-by: syzbot+ec07f6f5ce62b858579f@syzkaller.appspotmail.com

Tested on:

commit:         c1e939a2 Merge tag 'cgroup-for-6.12-rc5-fixes' of git:..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=123ee2a7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=35698c25466f388c
dashboard link: https://syzkaller.appspot.com/bug?extid=ec07f6f5ce62b858579f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=123c8630580000

Note: testing is done by a robot and is best-effort only.

