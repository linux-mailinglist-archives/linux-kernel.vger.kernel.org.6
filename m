Return-Path: <linux-kernel+bounces-540546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F10B2A4B208
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 15:12:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95D653B23BA
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 14:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244AC1E5B96;
	Sun,  2 Mar 2025 14:12:05 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509931E0B9C
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 14:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740924724; cv=none; b=lwPcPNUgLODnb7jTO5V3dkTtdEee7nyYHrZ1NKrTWG0G3uSD/Nb9aLhZFltLwDuvaq5vuJf2NI8t20TEEPnLCfA/8oXKp8r13bLm1M9fk6gkpiEfppk9YAIy79jTiaq1QN1S3xJ6hF5VSVFJ7lKwToVHQ+zuWPKs3ahCZrI01Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740924724; c=relaxed/simple;
	bh=LQGhS1IgVoLtLPDyLsR2GwAILnmH2G7ltniJ9g+FUQU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=s+WXRbsPphoiU8b/WQlnrOF7jVMOr/x5eK7lAGMxA9Qw1rPAX6g94LmwGOL9IrTO0lLO0cvPatA+ZdorchrytbfA7OaNJ4b4yRJLlrNokkfNs4G050vqDaV/yTTgBGzn8X0k6ajqiYWlzs8uLUSXshcYVoWRIqIucZ6qV2jajCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-855959aa39dso785628139f.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Mar 2025 06:12:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740924722; x=1741529522;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bf5gfceYpsp7FbCj88SSV7/XG491g4ThSK9w2xPLEZQ=;
        b=YlfhDhxgRNSeQPXMqRmoZFrQnJ/6Z2edJjJl+LYb5inixM9A41YavWYCCPjae09Xt5
         BzYTF1NlszVfGZRCkJISTiNWfywKhvlBOhCvn3tO2NZyYnEwF5SLC/bA4RNbv9OSRlye
         Qnl9xDnYje3aWzaoJ45SF1Eg1jjTxmyw/zAK1VKsNveo1iMmzsEFteXh/Rya/FeoCQ5t
         IfMfGW4SqPZHmKNhvmG5orSVvWD8NEwxE9Bj4CNgFGCxQ94rYfkO1RMmade7ZrH3ldFG
         XX35rddz32/jvRur3BJlRs0aFPrM6yx9qB9Q89c8Bi7GwObnLyFyUkNjLwTj9qE/sBIO
         1Tcg==
X-Gm-Message-State: AOJu0YwobTuFHx+SvEn4cBsfHy0TTYI4GRaN4IFb4W7JXzR5x92HLg4O
	T/W6vHX1sSb9yKdzWFfpRw1gU8c24EkjoO0ZjQs14x3kRg7gfkWGvM4DN3jBQYfLkMmBbHHfshP
	557i/BmT64vG1nf5yxFE3xkQxdtpP3l1x6+NmnixnRKpDsuY68eTSA8s=
X-Google-Smtp-Source: AGHT+IGv5D+pQx7DUBece7R3Rt8CDHb4Kr1ltoCRce4hKVYN49jk6JQJy6FWVVzuTpTJWvkPpqQsazX1fdOPghLXCKXEGdX8nHys
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:19ca:b0:3d3:e3fc:d5e1 with SMTP id
 e9e14a558f8ab-3d3e6e42248mr106175205ab.1.1740924722432; Sun, 02 Mar 2025
 06:12:02 -0800 (PST)
Date: Sun, 02 Mar 2025 06:12:02 -0800
In-Reply-To: <20250302134342.1598192-1-n.zhandarovich@fintech.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67c46732.050a0220.1dee4d.0038.GAE@google.com>
Subject: Re: [syzbot] [media?] WARNING in call_s_stream
From: syzbot <syzbot+5bcd7c809d365e14c4df@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, n.zhandarovich@fintech.ru, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+5bcd7c809d365e14c4df@syzkaller.appspotmail.com
Tested-by: syzbot+5bcd7c809d365e14c4df@syzkaller.appspotmail.com

Tested on:

commit:         1973160c Merge tag 'gpio-fixes-for-v6.14-rc5' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15cc68b7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=aad00f970c774056
dashboard link: https://syzkaller.appspot.com/bug?extid=5bcd7c809d365e14c4df
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16bfe864580000

Note: testing is done by a robot and is best-effort only.

