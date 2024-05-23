Return-Path: <linux-kernel+bounces-187689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F098CD69A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 17:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 344431C21E4F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 15:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC85B653;
	Thu, 23 May 2024 15:04:09 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCC66FB6
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 15:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716476649; cv=none; b=pEF00q/AV3Tlz6QIZy7Lob8Ep6kWen7vmKSA5WfZ1GE2PK+wHJtuZbl7JZ87d7F63C6t2km9115j1B5xuRQFD+1w74purW+6D+x8gY52FuEqSVCYTpghWFxAbUUWIfMNXZwSTED1EN47Cb5nMal3T5C98MwGNyQ2x+n12mZxUcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716476649; c=relaxed/simple;
	bh=BB8eqmpXw02S1/kBTJGcfE87OLw8jWCBPfvdVutU6aM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=XJ/0CPsTiNtTtr9+6isXPCujWAl33uf0boVtTKYRbWRQw2+mcDoq+GBewCm0WzTaZqdh1nBjONprAtV5Du0JikFJRxZWMId2HYjGIVuCB6q55RlzFC0Z+0/fyrUrlKsBJMbPoOY37f+BBxWpvgMPZBBAc9frMrJTieVtMCoCk4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-36c89052654so21914395ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 08:04:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716476647; x=1717081447;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zlhtVE6QhrPTnfiT9bzIHgzjMwE8jicE8ReLvV48Ah0=;
        b=Cgek1WJxMccH+AKnn1RnZTB3Abia4ogQ/q0cYP+85CmazMZNOC3RGFtQl3fGzo+JFq
         9Nmx5aejIAvkpNbPjF8Bz8X7Cjv2yfUbDApyD8NrLSp2rsHpU1y4K+1SKYHv50Km2WBS
         1X2pEN0ouC3JuvmLm4Ms6iXbNVX3JUbJw4K0bz7mN8AO9FbtMyihnD7HTeLvjVjDfqTK
         WG8oDRGW9kJ4bIMzCX5Eym4VR4yD/9MVXd1Rxp9suG+TZlIcgtsHvq3TJvEDb/MUNd42
         B7AaM7o8S88gOFE408NQPp9Kka84ASn9jfTmrkmwN9ASMiA9mi1l8R8+juMoigkXmmI7
         o16w==
X-Forwarded-Encrypted: i=1; AJvYcCURhXKxsi08JuG0HWbA3pHM83IExjuX/ppjblpHrC0HH9wSWuFIrhJGiprxb7aYAYpIjVXq4nbKO+/40MndflRObOrKH8+Y4wF8TzgC
X-Gm-Message-State: AOJu0YyhDoh2l/abEv2yBQF+ezNdXP1gH1VZ5irLtMYc6zqC1YpDYOHl
	QVEYjhYvryMEVYIRyN5PTZd/Ov3bl18UE/dsvgSg3H6VTW8b8WZQAVnM4PsTgLMNu+UZJY5k11w
	cjxU8NTnRCQ5UR8Z+/eabflKqLPKlwtOwW0064+H9MKAoWgj+7MN6Png=
X-Google-Smtp-Source: AGHT+IGbAfeK62wofPTkhHwGC8NPnacLdTEUS1iKQlAzqyVn18HhxuLcFJ5tATPY10drYoro52NpqWnCc89kV/qPb5xtdhMUr40r
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:148d:b0:36d:92b9:8f30 with SMTP id
 e9e14a558f8ab-371f6b2a832mr4585555ab.1.1716476642845; Thu, 23 May 2024
 08:04:02 -0700 (PDT)
Date: Thu, 23 May 2024 08:04:02 -0700
In-Reply-To: <580959.1716475058@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008ffbc60619205c17@google.com>
Subject: Re: [syzbot] [v9fs?] KASAN: slab-use-after-free Read in p9_fid_destroy
From: syzbot <syzbot+d7c7a495a5e466c031b6@syzkaller.appspotmail.com>
To: asmadeus@codewreck.org, brauner@kernel.org, dhowells@redhat.com, 
	hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+d7c7a495a5e466c031b6@syzkaller.appspotmail.com

Tested on:

commit:         c760b372 Merge tag 'mm-nonmm-stable-2024-05-22-17-30' ..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1456cc14980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=966dbeb548ca6926
dashboard link: https://syzkaller.appspot.com/bug?extid=d7c7a495a5e466c031b6
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1632668a980000

Note: testing is done by a robot and is best-effort only.

