Return-Path: <linux-kernel+bounces-225525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2817B9131C5
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 05:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6CDE1F22A88
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 03:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF568F5B;
	Sat, 22 Jun 2024 03:27:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDA0522F
	for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 03:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719026824; cv=none; b=Z96Js4K42WjFdIYwt/vQHwHnI5/r+Uaia1EilDFUMLaygbXzR6hFZt5N5su74I3tZWn4foWaVe0eqDykFrb0/gEzCC9Hl9wIRQrgMRnwdsbzwILajM8BthZfMfH4Ap1KIWVMcgWXpjpqDfskd01DxQHYdSjqbef2fJKhCUFUhyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719026824; c=relaxed/simple;
	bh=BhsGrKkclcn3iy9o1g69yuBT9W7BTJDm56uR43fcJOo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=e8s9CvE2BS2abMc1pR6vHa9ps3kiCpZ0zzBz200MnWz1E0HuunotF4euDsSBgouWdZtb8JYxWSnEuMASQmCZnAZGL8duq01OtrxxPQfiV7xFFIIKVEcDCOeVOJStdLvf79y4gnnQyzccGM7cNWVPorilCXvRZ0OVhO83rJiBxzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7e92491e750so186016339f.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 20:27:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719026822; x=1719631622;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vb4EvQghIsAwCTyCVP7qbZx2tN04zQotCHqOVqfEFxs=;
        b=dVyujteRtTPC5+/plcWoKjdZ/ucF32D4Od5j71NDTd8sJHZYERhd3WPn7BO629++z9
         lbRBbv1V8dGLfaRauipHButeBNqdR5ZG9HHsRZP3iOtr3y0DvJUDdtxxxext0IeJP8Co
         nE8o1sJ2ku8KAjnwtRypsS8XBfjkgfGXTyFCeMmEGk62d3QvVijTtcNltFXyWWpr3kmj
         +DEEcB9zmTSI156RQuyJPQvs9rbM0ke+agHHd40QSur9F1rw+E7J8FPPgyMzlcpJiMAe
         npnPF/Juf2R+nLkDmwG8O71wPjk9urcEAx1MT3Rcos+N7IEKkaNPj3Tvxcl23dPaYHk9
         IevQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9FwlGdIsI/J/ku0KrhkR/xjy1ozi41tx6aVQKYIMJYt47jt7DkikdpuX6hfLZ7r/V7qBaPyNFmbDbQi32P/ywPtG7Zqbnx4YOWKZP
X-Gm-Message-State: AOJu0YyueDM+aNAsv9BqsOb9ofxIm93dV658IgNKJsgQV2xwKo88heAJ
	ZzNOGUycniDDhaHhJTo0QiqDg7tNUX7WHQqWXSEDroaH5Cj82jq2tP1W/LoONM89EOytJ9uqgoR
	4ImXdVO6Kp1BwHkE+hUmAyr5mWkeZf4hwzKn+S4DR4tTiBounXkdd9qQ=
X-Google-Smtp-Source: AGHT+IF6JFfIhW/WhkuydtsrIQGJLZyOill0gWaDfNMa9I6oZY5LQVOP4Uqjsst8qeetlLBTqGDQBdycAKwlt+SalkKGZayBpaSx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a5d:9853:0:b0:7eb:761a:d0f0 with SMTP id
 ca18e2360f4ac-7f3a0241b30mr928239f.1.1719026822724; Fri, 21 Jun 2024 20:27:02
 -0700 (PDT)
Date: Fri, 21 Jun 2024 20:27:02 -0700
In-Reply-To: <tencent_EF3CBD367097AC370E4A5E7525769D668209@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000020cd74061b721f4d@google.com>
Subject: Re: [syzbot] [bluetooth?] general protection fault in l2cap_sock_recv_cb
From: syzbot <syzbot+b7f6f8c9303466e16c8a@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+b7f6f8c9303466e16c8a@syzkaller.appspotmail.com

Tested on:

commit:         cc8ed4d0 Merge tag 'drm-fixes-2024-06-01' of https://g..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=10981b9c980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=47d282ddffae809f
dashboard link: https://syzkaller.appspot.com/bug?extid=b7f6f8c9303466e16c8a
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15d2c48e980000

Note: testing is done by a robot and is best-effort only.

