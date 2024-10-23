Return-Path: <linux-kernel+bounces-378859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70AD09AD666
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 23:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 286CB1F220E7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 21:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B3E1E7C2C;
	Wed, 23 Oct 2024 21:13:07 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F911494B3
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 21:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729717987; cv=none; b=uKPfk1tXkZHLGkrHGzWEnOhp/ImajIIqNzj/vNFm2ExV1r0J4k0OpzZNEduGBT+7jsVJE6FcyYyDg/AAI6T2Ln1zeZ7M0YLh2cEFUI4g2S4XgfPrmNGr9nCNnh/zAcR5gtv1r5s3s+8OqibYkAll14Bf88a74JzVpphjlEOZZkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729717987; c=relaxed/simple;
	bh=cFRPMUWoBRUUg5n/0eqhBH5pFm7+qAhyQs9ifFH1l0s=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=LXZt33hG46TDSaqkhOdAf0xtS0/B5nq9Wwe+mnHlw9zoVob87qBEJbhcynRNNCFwXvekWOcHsY3JGmx2BVVgKwU/ZQ/3KXRFrCElGhG/QBgQC5ZznUVkvNGlXwQk6XkJgrIrI17eOAu4SOytv7dPe7ibYltBEvsTiT7k7cOkdn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3b7b13910so2371485ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 14:13:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729717985; x=1730322785;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NtdQ6AatqqunbWDIMg/bWDUZALh8TkENlxiTiD9vfYA=;
        b=xHt3hxKIyfFMyULiC6QZJ5hBp3OQaMpRFe9YTB10yQDoTRAuQHThHRF0Clv06KhS3w
         6UiMDXqC355BMehOWyxIlmDcVnC2Ie6QcaI+5McoSNT3I6CBwTLmj70N8gtQbn0mbGQ4
         71p523F1M2yqpDtmiTqUiYX5mLVgMz3ykdmcXHjt7gEHZo0R0FlnBbqoVUMnhu5XDWp9
         hCwSJT7onEnfOGD5t2IHVLnx8GtMnf5HkX2tzj3TTaMHleVcOrGyAyymrH73Q8TiPY4l
         ajbg0JagIArIM3kxvarxJZrK72UViJpWYuBPMp+f6rCpdOaDzSN7aI/In3mC5QYrjIAC
         wXZA==
X-Forwarded-Encrypted: i=1; AJvYcCVCZI3E83HzYuCryxYvXaWX0LgMG8ss2BW0VNoi5T13Xx0iInSU5GtFD4l+Ogb3c7vbkxa6XXLdGHx2XKo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw1aiam6+3Ci6OBwpSLRuZhBuP58FK3LYAcni/v1cjpZ0NbJ2x
	6RPRD3rlt4V7ZlxSqdOZh+ibwA2qAv5jmA+J+mb1NfYDkrGOQN2yuiTVZGD01P1zhCecy3wFPo9
	oprfnR9y/Zb//JRvSYE1xoh2FYSzevenKPVl6ko7F1u+jLXgLOObeBgg=
X-Google-Smtp-Source: AGHT+IEYj0JeSMvIeosASfoo3MtqVoSiaYNI6mX/2iXFOysBtzO4mKlKK9FGU9lN032ZJI6twP4BCUQeI7wBzwIQNvUjz9TdXewJ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b2b:b0:39b:3894:9298 with SMTP id
 e9e14a558f8ab-3a4d58262acmr45538495ab.0.1729717984895; Wed, 23 Oct 2024
 14:13:04 -0700 (PDT)
Date: Wed, 23 Oct 2024 14:13:04 -0700
In-Reply-To: <05c21638-620e-44e6-a08a-c4166304b660@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <671966e0.050a0220.10f4f4.01c9.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] UBSAN: shift-out-of-bounds in validate_sb_layout
From: syzbot <syzbot+089fad5a3a5e77825426@syzkaller.appspotmail.com>
To: gianf.trad@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+089fad5a3a5e77825426@syzkaller.appspotmail.com
Tested-by: syzbot+089fad5a3a5e77825426@syzkaller.appspotmail.com

Tested on:

commit:         c2ee9f59 KVM: selftests: Fix build on on non-x86 archi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1640b640580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=41330fd2db03893d
dashboard link: https://syzkaller.appspot.com/bug?extid=089fad5a3a5e77825426
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=165c2287980000

Note: testing is done by a robot and is best-effort only.

