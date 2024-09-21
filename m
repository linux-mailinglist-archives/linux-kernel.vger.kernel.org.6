Return-Path: <linux-kernel+bounces-334998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB8B097DF85
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 01:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58298281E77
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 23:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32788171066;
	Sat, 21 Sep 2024 23:15:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7652B170A3D
	for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 23:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726960504; cv=none; b=nLpOyVXCQ1+4+tBf7oyaLhbvfkYewgDKoX15HVQ7QnxJkwSQKx1qr2UgPATYb1kbmHOdfIzA3UUQeXi+D6yF7kEHCzHrrTBtk/O/fb6uakn37iD+unJMcaCgulrXy4qba0Ece5+W56EHU1LHNnZj/nL9J9NMYJTNP9cyCveu6Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726960504; c=relaxed/simple;
	bh=mItxw1fkw3i4TCyf9ebcM+X15V1kKeMltS4+tw9Rx8g=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=QyV+Q9VxU1oPfIoVAh+wzq94cP/mSOavaK/4IKXok2THpzosjPLxGxqCYGNdd3Oh74uMLC5mKdnS0Go9MGjipvsho4RTegTdnKFE+y+4D5cTk0khVreEYtttH2PeglR3hvRAJc49I1ggb+m5Q8bvXqdNaU+qc8swM8yYNWnC+HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a1957c7cf3so4112865ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 16:15:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726960502; x=1727565302;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=62wSWw2loLJjz1X/sJsuWKexTVDeA4/FS0eDPKVrNpw=;
        b=r3fT7duRX6w6lqx6OHHdonCi5pi3YTk84o2VkLenGQ8XHijnp3s/hpzGoE8J6Beidn
         xnPmuMHdgKcGhyiYSyIM5LFxV7WdxXFTsG4Al8X/VRklFwF1jqHTEbt4ge68fQe0tDYd
         VFDSLIr9tEIfYRhlBf40k+Z3eRl7QVOF+TvrjpPKmLAtsJSJ9Msz3+Mm/sB8QbmQWl9k
         7jtF6GuQ1sHB8rvMkAzC6MNAZ1GNgWOBXry6ofslasHLJuT5iKVubzQsgnROKhEv6/AD
         m9iIdcOGgrSb/36vx6/boVFhaOQTvxHleh7ljElhxCdVGv+yc6skMhNHfZLIGmdp8lPC
         J/xw==
X-Gm-Message-State: AOJu0YxxC4uMRnyKZ1k0OxZNWxNeHhOAV8s+fSysOle0aLtL6sB1aC2Q
	LbsRHRj6zhfidCs6LAT/Vb0A4TnjbxEK8zcXLt+xmSo48e8PpnDFbTyZmJBjSEDRm+A+GY8XWjq
	HeOSxsAqzIlSHmcn8Vl8FKDBanuCE/H9dPZxROjTVYJohnkN3KcIgsa0=
X-Google-Smtp-Source: AGHT+IEAj7QY8FVAPzxWwLqFG0N2BA6eOcefaZyUK88MqoQ3ayKEHaLjXuJ70QI/bAzWVC6y3yDuE+RdPyyQPXzikUR7zcxign6V
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:156d:b0:3a0:4a91:224f with SMTP id
 e9e14a558f8ab-3a0c8c61ae4mr59887675ab.1.1726960502615; Sat, 21 Sep 2024
 16:15:02 -0700 (PDT)
Date: Sat, 21 Sep 2024 16:15:02 -0700
In-Reply-To: <CAABpPxT0rTdOOWFrLLLtQg7UQTDgACdg-hojvtB6S22Fp77ycw@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66ef5376.050a0220.3195df.0070.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] general protection fault in prt_str
From: syzbot <syzbot+37186860aa7812b331d5@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, pvmohammedanees2003@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+37186860aa7812b331d5@syzkaller.appspotmail.com
Tested-by: syzbot+37186860aa7812b331d5@syzkaller.appspotmail.com

Tested on:

commit:         88264981 Merge tag 'sched_ext-for-6.12' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12df9e9f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8d53350f32cb0be2
dashboard link: https://syzkaller.appspot.com/bug?extid=37186860aa7812b331d5
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13426c27980000

Note: testing is done by a robot and is best-effort only.

