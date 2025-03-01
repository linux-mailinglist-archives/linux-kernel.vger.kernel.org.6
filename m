Return-Path: <linux-kernel+bounces-539985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F8BA4ABA2
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 15:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9F233B154E
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 14:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C033597B;
	Sat,  1 Mar 2025 14:15:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA261DF960
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 14:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740838505; cv=none; b=EiynE0p7ro8JKIm3rvluRlF6K5Ks8LrhvfRUq/IHxTvLAXhgkwNs3jw3wB0zom+YjTNb2drCHUoJ7s3Iz9Ch9u48OQNLQCq894bq9mqDn6AFPZ8QqrTkZagtC/yPaysZZyWS0TP4iEni1BL40NTC3Swr+5p5Tj58kPBRnmrPaYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740838505; c=relaxed/simple;
	bh=+gAnRp6+gqSDe/mp/8I6ZE7FW94OMZODy9DStIgMzYw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qFwb9r7bRFGNO/lxDlee65QLK4kmVHTOt0OwPTBF1yNchn22nCIgrxk1capVI4zg16vNDmS6BLRINgGyMM3lh3/ERj/HHqvMOUGaUmFIOmdl3IGQ+diKtIjRt+72Hld784KXDeAFwujXu2s+sb/nZ/wH/Bwr+Nf5maqHec8sO5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3d3e09da2c0so22848125ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 01 Mar 2025 06:15:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740838503; x=1741443303;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q81GX3Wy7FjhzyorMyBxVtq7lpK8aGZ9/duNi3N20xQ=;
        b=DXG5XiVHlb1rtvUNXiTrrey4C9A8+KX0VovpZutt7QJE70nW9tdmEC4yLZGlAn/8N5
         liP4QbJJwh3ESVV1G+Kp+7M8VV2LOqlsgL4gXF1+Pk7a0HN4HIbKtzVtwl0hO2vSr6Y4
         MvL2FLlDP0jFWu3a8M8BbJU8F3bbsoYQuMkzKhSqimgOj25WTe3BRSH/0GLPKJreXdmo
         D5vfr38w55ixT42UZoChq/YToDsuLOo6ZlYHkUmQuvuuxEtu8BlBL2AH2BJATvVGVFxU
         BZy9/MTyn8PV7flbemVWzE6qBUmGBM7cBQnm96PkAVdWv5e3r7VENCKVfZrTX+HlSiyy
         aB0A==
X-Forwarded-Encrypted: i=1; AJvYcCWWPyqH+IqvMxsJ5DgzaBpAawzJ4cM3frAOyMtjHE4qwG8EODyDvg1wewDeQZX8GNDfScgSaJFKgPD5VBs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8G7SySaD9TSH/XAQ9JWyP1w2K/vJCaqdNs3rfHwSTeqesbwc4
	VDDv45j+5/qvquodIrzulrowKr3EI/34WFbmTZ1w/njtDPEgMQISnnsE2tN5vJ8tdplCpotD1tS
	G+11NFHQ7KqGVV45mgEQWdMA+ue33XppWSsvUQpCqmG+k5mfelq9w6LE=
X-Google-Smtp-Source: AGHT+IE2dPPX9uaRspCi4Bznx/Q0+cOgsTvzw1nn5pecUshShtlXelRj4Z7F4IGu2IqYziYl7mGp/ZXQ8Jr8vgPN2ryurW8+OJtW
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d02:b0:3d0:f2ca:65aa with SMTP id
 e9e14a558f8ab-3d3e6aff564mr73592425ab.4.1740838502926; Sat, 01 Mar 2025
 06:15:02 -0800 (PST)
Date: Sat, 01 Mar 2025 06:15:02 -0800
In-Reply-To: <20250301134743.2874-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67c31666.050a0220.dc10f.0168.GAE@google.com>
Subject: Re: [syzbot] [block?] possible deadlock in loop_set_status
From: syzbot <syzbot+9b145229d11aa73e4571@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+9b145229d11aa73e4571@syzkaller.appspotmail.com
Tested-by: syzbot+9b145229d11aa73e4571@syzkaller.appspotmail.com

Tested on:

commit:         03d38806 Merge tag 'thermal-6.14-rc5' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=165dc8b7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5b4c41bdaeea1964
dashboard link: https://syzkaller.appspot.com/bug?extid=9b145229d11aa73e4571
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1727c5a8580000

Note: testing is done by a robot and is best-effort only.

