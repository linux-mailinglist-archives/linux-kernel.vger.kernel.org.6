Return-Path: <linux-kernel+bounces-415735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 721549D3A94
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 13:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 323FA1F2231E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 12:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA321A071C;
	Wed, 20 Nov 2024 12:22:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D1F16A92D
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 12:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732105326; cv=none; b=Izv4Atk6F3B2NQ4guZM0vON2hORNiPzVUvi1t+nZHWyR49t3yjxt2q++MNn8Uh2Syjubm9Vii7SBK/9MBJr0hJHmp8i89j0+Ye4O7I6Tzhp0ppv2ySWb0aEFqoxPKffCZitEYPAokKnH+ia5oLmQhtBDMq0Mc2/XXs9p3rfNQp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732105326; c=relaxed/simple;
	bh=Ez4iS5JA4fxXt1NTn9gJdLwRmjT54vp49B5EYO2om4I=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=NaGCRe99W/vtfNGa6v/jvxSNwCOa7xiEZ9bZ2W+4mjk3W7uTKSBM69/h3dJCyrLs/ahucR4v23ODaQfzKC0leO9oA2elIru0pX0cjrpwQFPVwLmMFN1MX5lUC3JCak0BM8cgRRlg5A26Bx8p1bfN0Si6GzKpmwp4TupNm2VZj5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a78421a2e1so11365435ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 04:22:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732105324; x=1732710124;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mhIFq8DUWElSlJ/MYbqNa952ij3yfVBIg3yjTnxQ1OU=;
        b=Gfnk5C9QmRGTm0EC+S0sJ4bKzu0UmqGw5Fpz/lD/NRvxvhmYakQAYW2t/4v6ZXSawH
         E+bzbSQ3YjiUTaASgCf4o8vPT3kzzFqgbAmwtzglJMUA0cutQSRRodOTnFr6l9uVXEVd
         xQ51PGaGrfLOM2S6Dh1QLHtohTDq+kpwZzeMwU78w3dGQvFQLr6IVPVJsjmrnBBo+ZLJ
         keXGR1FPPSktiurfzedp+VGyDHoLQGMA5kyv0rzpbaDFCe41djFv3/e+XCOLwZq3kTPR
         HOBQy2qGDw/FqMaGCBQKbzCXTFzEIHXrYgL2+UmHw9jHrJuTgwAkk73aHXmBzd8UPF5R
         TZZg==
X-Forwarded-Encrypted: i=1; AJvYcCXll+IQM5Y+KRw0lZ8/xONG+7KPT2btvdvydq+vr7Jh9FparnyY5rkdjxuBe7iB062nc0zOQhmKZBniChk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb3XIouRKVSsIdM6h/7ErjfIy7qgZ1j3EceNxuPeMkWOLJnLmQ
	+cuaDXqh59cWmnZlHGQBinlSLnhSI1idcX8oHXjKsf0smpFy+ezV3NGvD3yTNuw7HQ9mPubnWd2
	kmn+PblUJALMuixJCHXsyoV7Jn71KDdcpZJLCQ5odyqILjaCyuOoHa9E=
X-Google-Smtp-Source: AGHT+IEk9DFW9OVKKXa/ouK7V7vHh4T9eVZQ3KlQ7qGGTfMS80hX+oaljE3qteePPstRQEp6D2WetMF4BbCkpd0Fwuql9OhhPqdh
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d0b:b0:3a7:3760:7314 with SMTP id
 e9e14a558f8ab-3a786584e2fmr27626055ab.20.1732105324033; Wed, 20 Nov 2024
 04:22:04 -0800 (PST)
Date: Wed, 20 Nov 2024 04:22:04 -0800
In-Reply-To: <20241120114703.1293-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <673dd46c.050a0220.3c9d61.0160.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] WARNING in hci_recv_frame
From: syzbot <syzbot+3e07a461b836821ff70e@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+3e07a461b836821ff70e@syzkaller.appspotmail.com
Tested-by: syzbot+3e07a461b836821ff70e@syzkaller.appspotmail.com

Tested on:

commit:         bf9aa14f Merge tag 'timers-core-2024-11-18' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=171b4ae8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8b2ddebc25a60ddb
dashboard link: https://syzkaller.appspot.com/bug?extid=3e07a461b836821ff70e
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=125cbbf7980000

Note: testing is done by a robot and is best-effort only.

