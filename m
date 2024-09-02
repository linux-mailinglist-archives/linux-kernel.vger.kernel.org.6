Return-Path: <linux-kernel+bounces-311324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B85E968788
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 14:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1C83B23E8A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 12:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49ECD18595A;
	Mon,  2 Sep 2024 12:29:04 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801BA19E96F
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 12:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725280143; cv=none; b=bzboSrpB/83uTQhNKD9TAVT65B1f4zXB+uPj6zc/vU059qu0UPRVVYvgdqEOxT9S+d5yFti/fNHEk9drIjHG8sCw6POvV9UwyfOfw0kvE0IkU/fHWDSVw/k4X89VMQ4Y98i3g05C4ZQWqywMhahLbZWDsKeOqH8t22t846fhhQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725280143; c=relaxed/simple;
	bh=Y22xo1KeI/H70tsZp9XDDN+XQNLU1iLBiTuyqWVuM+w=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=hOqBA/uGX2hNunE2saiw91NZMeDBUkAuHgxYr6uzYLiK1W+vBvzDSSHN9mEBnieBeyjL8d/4Ay2WWHXMLRHHcOH2ID/x6zPUy417ZyIWjpgwz2WS8jgFl5cWwkGa99Q4tsZ8FuDI8uyqouxzw9+kJ/7eru8WNYQHgtsdN4JxlBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-39f53125f4eso16446985ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 05:29:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725280141; x=1725884941;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dov6y4mS5VP69C2MZ48a5b3rf7Q5lLo5GyKHuKQiybw=;
        b=X0mhaoqK1e11+8vYDL4Il9hvk07tVWuLrtsrKLGREUqn3Mq74Fmy1kySXoD1KJvKO5
         2SchgngjU0Aki1ntDe/usb+ofSoywlX95SxDG8ukvBUo1sAim1kcKzJ0ofSBS+7P0arE
         sZa1qIZpM0vf1BEhlFNxZBUJAbkd9Wb8XFk0IMEKg4EzZ8uqYsbbSg50fFmbBXZ1+VWT
         Wk+Yu5d8DmhB5ZvShDp7m94UbUuykS2pnycCC4U1jS0dWA01gzbTGfMpGQPI3Yx8RL1m
         cvK1xteW0au0tkJXwW1KF8+TAwoDXeu9IHzbIhCpZojdtxeY/3DgdM0NWmZqPsHDCO0d
         rpYA==
X-Forwarded-Encrypted: i=1; AJvYcCVCEgN1ePregOZ1c6yWayjxdTleuHRJ43XeKELXdQmL1xzM61Vj2EwCWKCQwMc/QQbOMGK93ZA2n4H9cRU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeRCEV1TUjx8jh00WPmxiQ6mmfE8fzzDOtLmVhFbPvU7avkBQE
	z4XaeTtEscwTxnSf1/X6z/7KpJH4UruT7KXN2aCnlfHOlOIxmhlsi/I1BOJz1TKXfgirOcAAirl
	sG2wQEiAYdZVF91HxYYMQ+ZPM6bxr+60s/KG29vPKI6ZP5bLRb1gpI2U=
X-Google-Smtp-Source: AGHT+IEGtLImGZmmKMXSL/xm4A1Gg1PCz9qOJqMGZHlVxuVgAXW95+jEhBiC1rQSfoUvzKvyx90FNx3QRullBv/ZBh6RUMogVI4V
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:194a:b0:397:3a28:94f1 with SMTP id
 e9e14a558f8ab-39f41061d7cmr6403325ab.3.1725280141755; Mon, 02 Sep 2024
 05:29:01 -0700 (PDT)
Date: Mon, 02 Sep 2024 05:29:01 -0700
In-Reply-To: <41ccdc3a-7259-4fcd-88bb-07590d278d19@paragon-software.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fcd95906212215df@google.com>
Subject: Re: [syzbot] [ntfs3?] kernel panic: stack is corrupted in vprintk_emit
From: syzbot <syzbot+4d2aaeff9eb5a2cfec70@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file fs/ntfs3/super.c
patch: **** unexpected end of file in patch



Tested on:

commit:         7529036a fs/ntfs3: Rename ntfs3_setattr into ntfs_seta..
git tree:       https://github.com/Paragon-Software-Group/linux-ntfs3.git master
kernel config:  https://syzkaller.appspot.com/x/.config?x=7229118d88b4a71b
dashboard link: https://syzkaller.appspot.com/bug?extid=4d2aaeff9eb5a2cfec70
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15523cc7980000


