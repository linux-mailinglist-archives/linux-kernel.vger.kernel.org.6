Return-Path: <linux-kernel+bounces-306976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99AF6964653
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 15:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 431401F268F1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 13:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1446E1A76A8;
	Thu, 29 Aug 2024 13:20:25 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4085D15E5C0
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 13:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724937624; cv=none; b=U6mIdMHNEU9xXZNRqO38TS6+Od7gRWjkKASc4z12AI14cA+Sh/Vqa6qh6SlQs+eqffmsX6td/j5mGC4OxKys1kuzkaxLoPrOXv+vtoSNjU3Yra3XOsLw6qeJ5AxpORSgiWzxsKv8XkLkUAFewxXeAl+eAzWO7DrtrBZ35WcMamg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724937624; c=relaxed/simple;
	bh=u4Jwcjg0J4HxizWCBJ/zviCp0rb0Bomjp1TKp/Pptyc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=iEUv2x08s6gC4JHRkuN3P3a2CV8N8zEZoFGc3/nqeRFnhE23EOOU5AASsiHrJse4K7zDvXsJtFFZ7m2DrHTUb7fih9lzfScAqCxJsPTrnLRk+tat8jwqkgbGl5w7G50ZtbXoKYZD0gMQURYgbe+OeEH999M5Isp7FwrIOIh5obA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-8223c3509a9so62921639f.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 06:20:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724937622; x=1725542422;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QeC0kzAHEyICaLkgHVFtFpFDH7/QjbTxOzJqwfIJku4=;
        b=s4UtoM+xRNIjC8oLHVjPSY9AEKgmBfnsuiuuAanDWOzFQ62gTny5K3YvqJOyrGl1UY
         f74xq5MBPrpMBY9YCZGUezLBNic+f9byo2ipzZdAMWlUV3XsNOtqWgqK7QKbWCZ8Jt3C
         Kng8kuWw1oNsA03iVC0tAjYqi6SimuyJRs0lBKuwRSEIbrtHMa3r/UmSN0av3FVSJmhB
         YO/s0qktq+KaethBkDqbLPA5hn8Kca++58VxACXlpr7hLy8SYOi4PT66yIf6Kh4Tp9fn
         EPI+kz5W+7AwlS7o5fXu2AXURcMkauqS+tRToBESo6ISFc3CHdmE/btsoLdp9kVpV1/v
         Amdg==
X-Forwarded-Encrypted: i=1; AJvYcCU5gcWMrq2jzJK1TLoabwAN/lAMCvISo4BZQKHdY188R7D1E0DZ3IWUmFiI43ByLz6nEYNSKX0oDZexugk=@vger.kernel.org
X-Gm-Message-State: AOJu0YycFSqXa3SFnXntjIS5wF5W7hro4q6f4OoVPxvf3498Tv4ZlEw4
	PSr2ZJQIUAJ/Nr9GlkzBcWxteUPJ7A8CI4gupDl7HyG7y+ghvgE7CHiX2KupVt6eI1Ll8WreVLC
	NiJruDeROCNqYdjyH9pbYFRX5PpbX45E2/MIaBDqL2v+ay1QnOKwOtj8=
X-Google-Smtp-Source: AGHT+IHawIXQAkKBbELYy+9M47m1A7QIHjdfsr04WmeswNZ+EYgpg1TqyJH4So61MDZLu15Oxhegv485ZfG9Hn2RM0biX4oMLJnF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1543:b0:397:5d37:61fa with SMTP id
 e9e14a558f8ab-39f377df2cdmr2071625ab.2.1724937622365; Thu, 29 Aug 2024
 06:20:22 -0700 (PDT)
Date: Thu, 29 Aug 2024 06:20:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003db80e0620d256fb@google.com>
Subject: [syzbot] Monthly v9fs report (Aug 2024)
From: syzbot <syzbot+listba218e48000a259e73d2@syzkaller.appspotmail.com>
To: asmadeus@codewreck.org, ericvh@kernel.org, linux-kernel@vger.kernel.org, 
	lucho@ionkov.net, syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello v9fs maintainers/developers,

This is a 31-day syzbot report for the v9fs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/v9fs

During the period, 1 new issues were detected and 0 were fixed.
In total, 3 issues are still open and 32 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 3115    Yes   WARNING in v9fs_fid_get_acl
                  https://syzkaller.appspot.com/bug?extid=a83dc51a78f0f4cf20da
<2> 17      Yes   WARNING: refcount bug in p9_req_put (3)
                  https://syzkaller.appspot.com/bug?extid=d99d2414db66171fccbb
<3> 2       Yes   WARNING in v9fs_begin_writeback
                  https://syzkaller.appspot.com/bug?extid=0b74d367d6e80661d6df

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

