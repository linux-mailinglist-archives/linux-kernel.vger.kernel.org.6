Return-Path: <linux-kernel+bounces-363318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9230299C08B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 09:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3ED4B1C2262F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 07:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D04148FF5;
	Mon, 14 Oct 2024 07:00:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCFC148833
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 07:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728889205; cv=none; b=W0emN7+0KY8tjhMbbQO5CSuwfLoVLwkLjrEekYzklWTVe9tGF36R3aw2y5fNV8Zg0Ps49g5dLIF99wnXu06Bipw7WZ0kp8vY85N1pOIBRqzCujUmuq4wnE0F2pgzx2ejbvgloHUdpKH6tpwDqmFAOwL49pBJ3HqHhCY3UdoE3wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728889205; c=relaxed/simple;
	bh=UVeWoj5Og+wsSq9WC972/2Jqtj7IYT6e/JNvd8LqKOA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=iRDsCzqtX/969jwrnM60VWTaHE0FQNNFxqeComDzfLXjqZ7y3tqTCd726xGYv9EBCEol74LSHWWLT1+q35M4ZwNHitwr1xeDotJBUMzKeK3imDSEu6b3avtKb8M1Zjo1PZ6VyasljYibBVLi7P8etmr/wY+7nPrflylYdN0XujI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a3b7ecad71so11731045ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 00:00:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728889203; x=1729494003;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5tQ9QvYQlzu+5EQLgcSwBsHR+7o1ULHR0qfz4ooAiis=;
        b=AnJJ+qh7yrH+LJc92fi5CcXf/W0bHEJG152WTwbmQhHSDE+OD8fTRQZHDjI9ypQ3rt
         wuSKXVXrn/kVVrxnb7x9i9WrgpplsdnxyG2isoq4tD7SIu3eXXHrqkZ4+2YiYFkdSgB/
         wru8dSxAXCmIW7NXl/hK0KzThjJc+rLwJpk27EIeyOo35WFpwAtmpvj3djzoL/SuY4da
         gQ4LzVxecE+NNT5QcSslTSYeslav8UoBa1HVnaODs6vTUfY1RzN+XBDMFizOofSRA6Rk
         ZZzMD8ZHtgkCnO0SU+ScfQRs9h2JJeXYb2xaAmA93ZRpwpUnZexkoHFMeDN7+9/esPyt
         tRGA==
X-Forwarded-Encrypted: i=1; AJvYcCVGmq66jVcLgdkZi9Qga/a6wDCzwqswD5eozlEmdWRUI0iQ89TbHmneRFXCtDRQHZ6N2rAmllkgBQcVJLk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0PlgtofKAcKK+xnwuA5wPbIUeTTUor65MAejurz2mUOZXEsWB
	r9WCHF2ZM0eZQQndA9+NuKgsMvdQAauLNtHfQqbU5qQRoZy1C4Pq8ssiGWeioWmhcHtOhwkbHzB
	UCYeAfHc5g8XlTx0xX0YI/oSTzIfxRtpmI9HlBbMraCqa+sR+TMPOKK0=
X-Google-Smtp-Source: AGHT+IFPLvjoT1nCozSMVZ+82FBS4ca4DzmtsttPjqOJfzG/6nwVAEmMWDEs1IpVyod9cH6mpqA6VJA3nNIidyPjIoR/8n2wPf0e
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca4a:0:b0:3a0:4250:165f with SMTP id
 e9e14a558f8ab-3a3b5c7389dmr79375795ab.0.1728889202945; Mon, 14 Oct 2024
 00:00:02 -0700 (PDT)
Date: Mon, 14 Oct 2024 00:00:02 -0700
In-Reply-To: <658bf0ce-9565-4b47-9043-a853374a74fa@suse.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670cc172.050a0220.3e960.0058.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] kernel BUG in ocfs2_read_virt_blocks
From: syzbot <syzbot+797d4829dafe3f11dce7@syzkaller.appspotmail.com>
To: eadavis@qq.com, heming.zhao@suse.com, jlbec@evilplan.org, 
	joseph.qi@linux.alibaba.com, linux-kernel@vger.kernel.org, mark@fasheh.com, 
	ocfs2-devel@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+797d4829dafe3f11dce7@syzkaller.appspotmail.com
Tested-by: syzbot+797d4829dafe3f11dce7@syzkaller.appspotmail.com

Tested on:

commit:         6485cf5e Merge tag 'hid-for-linus-2024101301' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17169440580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=164d2822debd8b0d
dashboard link: https://syzkaller.appspot.com/bug?extid=797d4829dafe3f11dce7
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12e20030580000

Note: testing is done by a robot and is best-effort only.

