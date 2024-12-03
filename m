Return-Path: <linux-kernel+bounces-429842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 496E79E2AF5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 19:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02D6CB26CD6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 16:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0181F1F8AD4;
	Tue,  3 Dec 2024 16:28:54 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D21C1F4283
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 16:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733243333; cv=none; b=OZzTlj45VB7TdLaBNusQe1nlZEfbLGYqHXRc6eVpx5erYE2GvwwzGgV/4SAskSJRmNS2YFTREMb39SD1VgjGwbFZoRVCMvpxstUf3WjAoXoOHHX8REnOfaWOzkM0JnJQR2U+Qs9infZuVXMc7O6s1LOIqWx5b1qooUhHocks33I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733243333; c=relaxed/simple;
	bh=9ruyO3AG5vzJV2tPGIagsYe01j0mujssPAIMbOy6MXc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=S/0c7AJbRERhS1fTreFQTcfYFYQpgcJB8vCVFhv/z/wWOhZ585CXQxAe4XALmiLnYCIVLlVUl+dQZ6eJjqAxKCIzLfW8tCo/448ELVczB4pfq84kFUfKXfAowKRBjtBrgSXMs9wtQIhGjlNJFTv4Mv6Z1voHGJkdMKeOPmuNkIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a79afe7a0bso74181605ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 08:28:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733243331; x=1733848131;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pTP+8DumYLBklR/cXAble2rRMSiUG3Z1thGEVX+PbX4=;
        b=CUKf4gAxiyPkfx3umF6zAi+pedKmCDVM9Fv7hRX42N6qSdZ3TJlgE1xZxNGd0Ozfn7
         gLpRmxLxzSAG+kjH4OuMFpQz78ZPuLg/CeL6Q3jTGmDWTFKoqVsUZgI+rIhn9QrVS8P8
         n/T90WdSu6roblz+vGRrzLvI9q3jjy1fm5d4Q4oSqMrgcNGdvQbPOxuEfJpcwjiv6M4N
         9OFe0yktOT7df8MJwwq3gn0Oi3QJ0oG4m6HOI6lRwEbytGQoPqQsm4YOpaD3Cl3B1UZY
         qgKIR8t55WPv0c8gH589KXSHtO2r3BahHlwR+RTRWhjyu+OWvSB+ZEGIGfa9cKAMB/Uu
         Fv0g==
X-Gm-Message-State: AOJu0YwJWrni0ZU6OQaSY6YywnpLNownYoJtLp4QFgbG29dkhJqLJjNo
	hZBc56lR9kuvGIfCpQJ2O3dQ4FkCeh3dsQ0cpS3ppmNshvq0F45T8j2hWva1gRHs1sU0TLnJEJ4
	8PkLZdQEfuIHMXnTrOz4MrK2iOJAdCHfb2xzBv5KFUs8WaCL6IddWT04=
X-Google-Smtp-Source: AGHT+IETZbb/NTJoGaF3pJErx44+39YQqD21/QUyOJ76hktCs90eUzx9LtBc40XtmLx2UuUTHAHSSorM+u66KKh+vS7jIPFpwWWx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20c1:b0:3a7:e86a:e803 with SMTP id
 e9e14a558f8ab-3a7f9a3b641mr43178415ab.8.1733243331219; Tue, 03 Dec 2024
 08:28:51 -0800 (PST)
Date: Tue, 03 Dec 2024 08:28:51 -0800
In-Reply-To: <674f1d49.050a0220.48a03.003b.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <674f31c3.050a0220.17bd51.0048.GAE@google.com>
Subject: Re: [syzbot] Re: KMSAN: uninit-value in f2fs_new_node_page()
From: syzbot <syzbot+5141f6db57a2f7614352@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: KMSAN: uninit-value in f2fs_new_node_page()
Author: dmantipov@yandex.ru

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git cdd30ebb1b9f36159d66f088b61aee264e649d7a

diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
index 6aea13024ac1..7371c09174cb 100644
--- a/fs/f2fs/node.h
+++ b/fs/f2fs/node.h
@@ -105,6 +105,7 @@ static inline bool get_nat_flag(struct nat_entry *ne, unsigned int type)
 
 static inline void nat_reset_flag(struct nat_entry *ne)
 {
+	ne->ni.flag = 0;
 	/* these states can be set only after checkpoint was done */
 	set_nat_flag(ne, IS_CHECKPOINTED, true);
 	set_nat_flag(ne, HAS_FSYNCED_INODE, false);
@@ -117,6 +118,7 @@ static inline void node_info_from_raw_nat(struct node_info *ni,
 	ni->ino = le32_to_cpu(raw_ne->ino);
 	ni->blk_addr = le32_to_cpu(raw_ne->block_addr);
 	ni->version = raw_ne->version;
+	ni->flag = 0;
 }
 
 static inline void raw_nat_from_node_info(struct f2fs_nat_entry *raw_ne,

