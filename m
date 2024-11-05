Return-Path: <linux-kernel+bounces-397162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ADD59BD78E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 22:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EE1A1F221EC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 21:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C561E215C6A;
	Tue,  5 Nov 2024 21:23:04 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69761E764B
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 21:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730841784; cv=none; b=EhI5yVYW6g15LBADswNRkN+ri+QHlfWuJZCqv+I7TbCZlLPe+sMIZN/fou8yvKJlH1Wrmd2EFkAjTLXfZwQBzkJQAdvRrvXqfq95CC9Qm7Ut9w5F+JPnw/WSy+H/lj1fYT52K93kXMjOvAx5/mrHNix2+dauRdgIrO/sZqs0WGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730841784; c=relaxed/simple;
	bh=kQCEu7yxGcHmRi7XsXHy0L+cDjF3f4uqcBB2T1wVSZE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=lZSWEXNzY6dw5rMCptJpQHrT7hbevgXhsWm1leMB5boCYjbugo31skereFgw+M0rZodQdSU6lVNxTCIY07lX5QYNM6Yg44jExCZ5hSOGd88MB9B9pjENSKZ9YHnoP/eVqNEoiAVouFmwY8IE3BDyGuSlLDd7xmEcYpn0bkoFdso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-83abf68e7f0so581873139f.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 13:23:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730841782; x=1731446582;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vkGvgcQwShmuplOP247/InjuSz12bbsXpzFuh8KtVwI=;
        b=D3IdI1PjcyGYW3S/bOz2ip73r27FEDHZH3/H1bufqIhfe1E0jK4q7lHfyYxr0eBMEs
         5y+zB/Ld8DK/W4gIbRFtgw3/r98Jdg3pVaLFRpO/hHVQmNN7JrCot+FsHqR/V17pV/3b
         NWXdaTTSgfE1DoYDOV2QaSzc8e2avG07BOHMA48LpW5FN2PrMvCLeTIJ45J9fPR35PCO
         2Yfk23HjCRbuGdvapGrdSu3LdxcVzL6GIA+MLvFuM2GUD89I+SPRuFxk7WGRxoNsTdTQ
         S5vXD5vVqOskkom1OzDc67nDBBjnBq56i6oRHhe3a+S/YrV6FqK+VBgwpw6mmzrcsKbJ
         mhrg==
X-Forwarded-Encrypted: i=1; AJvYcCWY9jI60JUQlo7mh8y2DWY/YVF+IuFa2aeqZrUeXJYnHQuCsuEcV6nX/AYSolUEP/n9fFXipz/TdJqXg0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPGFYKthuyi+M9tSsLYcYC415MbT3ltQSzONCwd48fIUnAt0fc
	RXRNzRkdXKFKH3/uS5drHO4Q0ac0HaGN61Z4Hb1G9ACoscOK88Vndd/DaHkvLkc8LkAn9WBN8pU
	NXwhPEEcvJPKmbBEBD8pNBIPxPd1U4zgOcXbaCGHO/11FkMd6gaf07bE=
X-Google-Smtp-Source: AGHT+IFXd8O4TjXDV/qjaTMforSRuD97gd0qnHVddXivYYFsd1KkkUuKozA10cBVJtDHRuT/7dtDuMIeadnIascDGxZS6+4RfLyD
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:220a:b0:3a6:c89d:4eb5 with SMTP id
 e9e14a558f8ab-3a6c89d50e2mr104615525ab.15.1730841782125; Tue, 05 Nov 2024
 13:23:02 -0800 (PST)
Date: Tue, 05 Nov 2024 13:23:02 -0800
In-Reply-To: <20241105113529.3257-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672a8cb6.050a0220.2a847.1772.GAE@google.com>
Subject: Re: [syzbot] [block?] possible deadlock in __submit_bio
From: syzbot <syzbot+949ae54e95a2fab4cbb4@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+949ae54e95a2fab4cbb4@syzkaller.appspotmail.com
Tested-by: syzbot+949ae54e95a2fab4cbb4@syzkaller.appspotmail.com

Tested on:

commit:         f9f24ca3 Add linux-next specific files for 20241031
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=13d71d5f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bd0e833c188d474c
dashboard link: https://syzkaller.appspot.com/bug?extid=949ae54e95a2fab4cbb4
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10460f40580000

Note: testing is done by a robot and is best-effort only.

