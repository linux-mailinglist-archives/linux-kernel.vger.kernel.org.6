Return-Path: <linux-kernel+bounces-439501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 022BE9EB021
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 12:47:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E981282546
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 11:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01FEB78F39;
	Tue, 10 Dec 2024 11:47:08 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FA43C30
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 11:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733831227; cv=none; b=KGbgsH87CsROkFWyFA3FzIJDvTrthZQ9/JbG5XpIMEXFM3vhTgrSlZA/YmgO0xwzm7idAZNNQbLYfidrqcd97Zs6cu4gmCzNnty2xbbkvrOyPQrMKtH3BMTnEqmv0hlRE82NK2/LykTq8GDNXy60DcwO1/W0QhzCamX7ZQCT/L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733831227; c=relaxed/simple;
	bh=S+1mWHR4pCHTgvD28d7yG1W8tBQWQlxedbN3pTWnZAM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=mDcxmEtcA1dDf8wM7lYhNFlA2ad35yGzJIiznh1ILjdJajWlrQ+LWb6IrlIEolfeETP1LXbraZb1dJXNOxuCRQz21fn5RxZBAcAhfQO1lrQIqLkSBznwdn3T7sj7iYzHx22g7ArOoTu5dFY0Cf7Jakfn5h4lXG2YWEU1TRuoMoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a7cf41b54eso105300865ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 03:47:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733831225; x=1734436025;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=97+9s3dhngU3xzp8BQV2/r6pIIBerftQCixS27XkXtU=;
        b=wvIhen37uc174TuwSVOqGPyN3tixENqA8uuLBy7s7DAq08Lhk5mz854Knnz4S5nEXP
         vxsNxbbYIER7OJrX1FNtDfhi3FvXH2yKn2BgWT3pHlzBr9R71ALh1TtztQlJYxUA/Eti
         594WUFyI1FsrHlZu0Rn5BYkAEw5DFwlKFLqeZNI1DPXgMp6xCqY9xosCcDcfKSmwkhMw
         Qe/FwtN1qH0TAAKlK/NcR9AzsGmWGA6sVvhkM9n1OpEowOyIe8xOdmyYfTSazdvj8ld+
         /WyJn3Zyw2gMN+m3PScbdvX5gymJrqCvQ/dkRhqc+PkoMyHE6o/YTS+yT/D0hdJMCYWu
         2zqw==
X-Forwarded-Encrypted: i=1; AJvYcCX3WaftKovlbkWG/vVsZMi8SYFsgV7YQo8+/tTdH8P8u+onbcEN+eS+fT8ManQPMahfUC0w1v0svTuPsU8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd8F1zOaQT/JxEkT9GPxBvYDNav1VlF7FBvV0MHKxRMn1q8QVt
	gRCoPhPWLN83eFklt/M6D0oBTBv20fwaIvbok+MF92+KSv4rfGoS8+hwmoQRCpKCTJcfNn6V6v4
	VHkvp/tAoZjaUQbDYBtIfXuo0BkW26vmmoZuJcYV/iZVDp9RYb1t61BM=
X-Google-Smtp-Source: AGHT+IGZ2yzTbkD5GOwx0wnDW5tMQ6zpvXOegf5S/zDXBVd1y55E1FHLLQ9R9C2Byuk35bm2PZeyqXdJTaT5HPFz3OWbiUUW1isB
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b4a:b0:3a7:e01b:6410 with SMTP id
 e9e14a558f8ab-3a811e0815dmr172123085ab.18.1733831225469; Tue, 10 Dec 2024
 03:47:05 -0800 (PST)
Date: Tue, 10 Dec 2024 03:47:05 -0800
In-Reply-To: <a1ef0b7bd9d2491ad346fb2a55b4279c4bd2f1fe.camel@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67582a39.050a0220.2477f.0063.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] KASAN: use-after-free Read in ocfs2_search_extent_list
From: syzbot <syzbot+2313dda4dc4885c93578@syzkaller.appspotmail.com>
To: jlbec@evilplan.org, joseph.qi@linux.alibaba.com, 
	linux-kernel@vger.kernel.org, mark@fasheh.com, ocfs2-devel@lists.linux.dev, 
	sunjunchao2870@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+2313dda4dc4885c93578@syzkaller.appspotmail.com
Tested-by: syzbot+2313dda4dc4885c93578@syzkaller.appspotmail.com

Tested on:

commit:         50760016 Merge tag 'loongarch-fixes-6.13-1' of git://g..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=17037c0f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=50c7a61469ce77e7
dashboard link: https://syzkaller.appspot.com/bug?extid=2313dda4dc4885c93578
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=106c68f8580000

Note: testing is done by a robot and is best-effort only.

