Return-Path: <linux-kernel+bounces-404679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 270AD9C4720
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 21:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6C92B26AEA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 20:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B336B1BCA05;
	Mon, 11 Nov 2024 20:21:08 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63161AB6CD
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 20:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731356468; cv=none; b=FBB+F0CiPNc+yGsuZh4Ul7I5kj5Qe6fOru8P2ExungQ+12ysCupWHtUk6WJfmemtFspPgVh2kF2PnCL0CHyyHzwwYEetsM47JBWVkeU7HZW0sx3EbzbZsaFAz4Sx6FJILqilKM0JieCWv6XgQcienjmjFUDLacQZ9rOUD2HaTH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731356468; c=relaxed/simple;
	bh=d8A2c1DjZvM2zYOqQ/xG+gf2/qCL7nEQFYWu9RK/Dv8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=nIlImFvuEU+OGPNfaAKAOyffMI/8NsCDDaGGVq23lS96zKlFfSn3KdvRu3V5c7VayCMS5qATXj6avXcXEDgJIGcNLMSIM3DpbIkc9huVILUtN1ls6IjPCT3mAJfJKmFBASEf18gSySydfzDOJoceXeTZc60/u5VD3zPrv1YVMrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a3b506c87cso60722175ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 12:21:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731356466; x=1731961266;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vdDKwOQ93P2ZZ2YC0YYBYLVt9HNXo8frAID6MN0wAdM=;
        b=m/LtBGZIHiS+bOyoBRMicqdodpi0uInmRCbEQoz0J9KNGIbnvqNOynsaWcKBVb/Uof
         cPMOSbHg58PZB9JzAnAqu3emFcuQSvVXH9vbX0qFbz/2ovB/MFGblA3wPFpX3D5ifyxY
         dFkKmEDQSSsXUyGLT2wUol9b/oSNGaWRHwO5fl67rUz7pDR/VrRUUZHhQsXEgWFO/L86
         GosHoiHAA/UMqTWCW0BVjoIOslC4tTrpYaN3u24CC8Y8iqYdRqXR6rkVq7vJgOE/AF0S
         9unJUvYoVnZLIMaDLatUQA+KdRzxj0nw55bS6QEHMjeyjeDDDuZnFtiSqNBqDXsuF6ZZ
         79zQ==
X-Forwarded-Encrypted: i=1; AJvYcCUd0tRqqY2Z+s7IFiYT+A5mBqSOnf8h9SHX1kk9BGomY2D+X9STWArs4sxl6nR4nWt5VV2kDDXCokgTzg4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBeQBGhTVywxw0FB7h60HH02iyQ6jPuItm3EcdrJaHutCvsrr9
	6310ObbKxG3MufYfjai6Wy3sux48mu8rpSpwriWRWv27tXEzOSOParzJC3eBUu0xYr+mRsR5byM
	1bIsbjXbX1cvfjZ6r4f7YZd7Iea4w87EzYf5dYN1xB5okBDV3nhErDs8=
X-Google-Smtp-Source: AGHT+IHLDZ18nOfpP6pz8FPw4mbzvT45eAjmWogaOAXRKjrZrye5SZtXZb72GQHvz2tfvbEReZs17Zb9qjsx+zoQ0EyhxuIlEon7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1:b0:3a2:6cd7:3250 with SMTP id
 e9e14a558f8ab-3a6f19c1b01mr154430485ab.10.1731356465942; Mon, 11 Nov 2024
 12:21:05 -0800 (PST)
Date: Mon, 11 Nov 2024 12:21:05 -0800
In-Reply-To: <18374947-f71e-4f71-b097-f06eb0699bfa@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67326731.050a0220.1fb99c.0156.GAE@google.com>
Subject: Re: [syzbot] [hfs?] KMSAN: uninit-value in hfs_free_fork
From: syzbot <syzbot+2e6fb1f89ce5e13cd02d@syzkaller.appspotmail.com>
To: gianf.trad@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file fs/hfs/bfind.c
patch: **** unexpected end of file in patch



Tested on:

commit:         2d5404ca Linux 6.12-rc7
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=522060455c43d52e
dashboard link: https://syzkaller.appspot.com/bug?extid=2e6fb1f89ce5e13cd02d
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14cfb4e8580000


