Return-Path: <linux-kernel+bounces-418837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBBB19D65FB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 23:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D43128763C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 22:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C7A19E970;
	Fri, 22 Nov 2024 22:52:06 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7171D17BEC8
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 22:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732315925; cv=none; b=l2rQk1tPNJjrQXX9CMj4b1M/Tl6RsrhZ0xnh+HoyJ+a1CCvyZ+enWDWXoI4hEZf8xJqR5QhsIYv5TF1iSuQhGtN9OyqqlBHOxoSl1iWUYddsY+g+pZkY8YRIUkKJVW2Twt4YutJ2btqHoxcVMkCwWymqvFbPgnHahps1zihz3OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732315925; c=relaxed/simple;
	bh=kmGSa91tyJttda6ANfUnL9QepGPBAngsBpeN4UX81Aw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=b//+AhhLs3oCe1VNmtwLsm3OmeST6rUPGQL1Or+vbw+AZmO32KTXwpPXYFOaisI9e7xx6fDpVwDbIBwmVxOQU1POMg7o+K8QTkGnAFIW0xVYmigJIzLlsfA5r9d1auGt4G4MjWxnuGAcqM3DZM+KqFdnYuI5Knz+YQiNW4xzGlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a76690f813so29710215ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 14:52:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732315923; x=1732920723;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PMeFAF7MPup7U5jhW/EyDakHB6OAdFr7nCoVLH8NZvo=;
        b=b497TFG8qZAvYggXOTGQZ4d5cKiXn/+snKAq6JpwYEcmy4yxWk1bN1ffIiAJOSRZV8
         EO+iwB83g0Vx2RYdadWfPLt5KJ+4EouRMY9ln3HQ8eG7DHxATNKPZohVZOTNd8ZIAX7p
         A+5tUz2BTVizxJWxDg4VQiYkPTWvw1w8eiHQ/ZQZFAWCG+0mqJJaieezCBbZSjvJCE1n
         x2ukDPB1tnvl8y7DAsYg4xbsjWP8KIWUNwY/t8wNf3oVd3Vz6QllyfTzVkgh+4on5tS6
         iNROsJDTEU1CI99+y6CNmxzsUJ9ulL18NGAxxaeItN7gsT56G+HCyhRyuxSe9luIFydI
         aSMg==
X-Forwarded-Encrypted: i=1; AJvYcCVKWk8Z4+JCsR5slpEAZ5f3O5tbwlfEjziCzZWfOtXu0zweXdkkO222Yg5Q/kpnaSo2x1HeJ73ll83Vrlk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJchgLeMZcfEAUxTGGqtuYPF7BJfckiHUXSkfAAF2E86d+xl1i
	+td4nS7EoR536h1H8kJ/3KR2/ED6dhXPvrALugHlG3JOXC4RD14DwN+ZGQxgEUBNeXeCTijaRov
	9AtkopVzI+tUvevRXmHYGnfgAXnsXbUdGsTf/gEms1yy4QK4uN4p7jKU=
X-Google-Smtp-Source: AGHT+IGCh5h19AzJE7guuc8s0oUg6t8D2QPhJtVxJba13C3Vn07uHrVqQZJq8iGI3p86UK7SU6TFhHCxzmC3dkU231BDCY8QjGC/
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fed:b0:3a7:99a1:f44e with SMTP id
 e9e14a558f8ab-3a79acfcf85mr63872825ab.1.1732315923785; Fri, 22 Nov 2024
 14:52:03 -0800 (PST)
Date: Fri, 22 Nov 2024 14:52:03 -0800
In-Reply-To: <20241122221953.18329-1-leocstone@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67410b13.050a0220.3c9d61.019c.GAE@google.com>
Subject: Re: [syzbot] [hfs?] KMSAN: uninit-value in hfs_read_inode
From: syzbot <syzbot+2db3c7526ba68f4ea776@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, leocstone@gmail.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	quic_jjohnson@quicinc.com, sandeen@redhat.com, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+2db3c7526ba68f4ea776@syzkaller.appspotmail.com
Tested-by: syzbot+2db3c7526ba68f4ea776@syzkaller.appspotmail.com

Tested on:

commit:         28eb75e1 Merge tag 'drm-next-2024-11-21' of https://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1382175f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ef9abe59471e0aee
dashboard link: https://syzkaller.appspot.com/bug?extid=2db3c7526ba68f4ea776
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16088c90580000

Note: testing is done by a robot and is best-effort only.

