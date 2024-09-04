Return-Path: <linux-kernel+bounces-314040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF22D96AE06
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 03:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CD392869E2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 01:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D379BD2E5;
	Wed,  4 Sep 2024 01:43:57 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3140110F9
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 01:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725414237; cv=none; b=E4MS8x3eNxfAqj5e41UIUQJV5Yie2FdsAz0Pqc5lv/5WvvGWRDR94BWoNuQWyta4zJXSLWHflU72TF4ywTEN6R+zA1cvULoeX13fcHr8mmdv0TdM3dD7nHL0czRcztPvZyneVp8xUZJcw4oVpJI1TwXWWFOqfAOflTHQ3+C5ZP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725414237; c=relaxed/simple;
	bh=kKj1xbM/gx74OgHETtI/2oi46qk0wlJm779K/blRS9A=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=StT1jySfn1Ls1q3THNepjHWHEezHH6LLZNCztHhYrtvYkGP+i2q70f60Y9VmUWeg0it8VbjYKCNjSSxx0j1ikfAWQ/g4b9eGctiXni9YdgHOGUwmVmHuPtULU3reTmJhVPm5E0zFwyVZMeyuOq2yZWj6VTA3t1xPJ3T4eh5FnKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39d4c745e31so80394135ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 18:43:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725414235; x=1726019035;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I9rKTtrUeWecm2CKSDUu6+ti5BxjhW6VWxA5y/EBjRw=;
        b=XaOLec22RQ8Qmi8mjQytK2cZtrVqEeJMt8/LHKfboR/8RGy0alWRw9si8Yk+JbWqSj
         hN5+pUJO3n2B2HWMj5/PSb0aiKnM76Ns0a5FQZhqgFRKUnCU1XaKWr0IB3lxXKGWyd7v
         In2p81l9FVTA6Zb4rb7RTfBT6giRIxTc7UFVDoIH2Q6coTAv3GuTVrAjgBnEgCmkGF4d
         UCxtKy2FMNl0A2+Ye/I0OuEqEhydRRCb0lYDdYMpmaqOUDtsVPnVySTulSzj2FfNRnlj
         PQSY1Ym4WT9ecBEA5IqCWY+oQTRw3W9Vsdi2799DkyEwynmYhK90CYk7fzradjCNWU7I
         L35w==
X-Gm-Message-State: AOJu0YyAIQdRuHMbRPZpjoqpXKDUxRqMTn72AW8vbUZIvRk6ml7FnXkW
	CQnlduX3dRbeLHkkf4B8LFP/8fHfxslW6f/n7Y+1oBBuOBA8uCRoHpqpoYE5THEyoIsYUSfzdlK
	THudgriTuRBcfvNzvqNDzLCgqy8fF45Qf9iA6aNLOa4+xIlOsr14fPzY=
X-Google-Smtp-Source: AGHT+IETAmNm7RoHyD28Ls94NgbU8mF6mRRLjvpzh4Bvf7d4CCShnFDDTSBTViVeQvFBeBOWQlRjirjBa5XaoEZzsdfuoS4QwEFr
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:198f:b0:396:dc3a:72f2 with SMTP id
 e9e14a558f8ab-39f410602bamr12005385ab.3.1725414235267; Tue, 03 Sep 2024
 18:43:55 -0700 (PDT)
Date: Tue, 03 Sep 2024 18:43:55 -0700
In-Reply-To: <0000000000001b6052062139be1c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009572060621414e96@google.com>
Subject: Re: [syzbot] [syzbot] [btrfs?] general protection fault in btrfs_root_node
From: syzbot <syzbot+9c3e0cdfbfe351b0bc0e@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [syzbot] [btrfs?] general protection fault in btrfs_root_node
Author: ghanshyam1898@gmail.com

Added a check for the nullability of the extent_root variable.

I am not sure what error code I should return when the variable is
null. Can someone help me with this? Thank you very much.

#syz test

diff --git a/fs/btrfs/ref-verify.c b/fs/btrfs/ref-verify.c
index 9522a8b79d22..e613420cb079 100644
--- a/fs/btrfs/ref-verify.c
+++ b/fs/btrfs/ref-verify.c
@@ -1002,6 +1002,9 @@ int btrfs_build_ref_tree(struct btrfs_fs_info *fs_info)
  return -ENOMEM;
  extent_root = btrfs_extent_root(fs_info, 0);
+ if (!extent_root)
+ return -EBADF;
+
  eb = btrfs_read_lock_root_node(extent_root);
  level = btrfs_header_level(eb);
  path->nodes[level] = eb;

