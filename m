Return-Path: <linux-kernel+bounces-336022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2916697EE1D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 17:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99C1C1F21DDB
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 15:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19EF819CD12;
	Mon, 23 Sep 2024 15:28:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4A919E810
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 15:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727105284; cv=none; b=iK5t6niRBCotsweb/EjwJpDUSQwdPOp4/PzjPz5YMfOLfyMfEmySnVNbj232jXxXmqGJh/fItmI1ce2kElXV1WJAg2p9W7MmKhCbI5N5/efiN1KgNn2pDV4QQGf9MuR4CZWkWVkKFY5hTyXHENkCgS2YeuAR9hytZMxZJPOCESo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727105284; c=relaxed/simple;
	bh=BXuKDvmxn/uadsYCkrctcocwNsA/C0A+CEomiewh5lA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=gzCyhJPByxoWWGSjVIgSlfk+Bui5rfkwDnnYzi6sHs8HQc6V/UxDmV6xrI5LuQ4++LApgFU8FVD+ipgKtFk+GIzv9WKZwme3rOeFsQnDIHUZlw7jbjAVYaWK2wvsLnYqT0C2LljTkpfLcRn4DrYcbStXutw+FOphIr5kDuTb1qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39f4e119c57so43726505ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 08:28:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727105282; x=1727710082;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2ckOujVLYUX9L8YLfbATQHm9iM+ZOY20csnjvxP3xEk=;
        b=JS7mAwCLp4cI9OXj2dOBywSv6PT/l35DcO/qucabhqqccqT89OJuQ4F/g/crtNj4sc
         S+5L+wK5b/WoZ4aEEQaoytPzfTienbdTV3y8Z7SKkNytNB40oQ12TY9NbFT7Gu4h012B
         FTEIr6xN1yv7gxXis6xQ6gBZ8xI7mKHlEg7ddV//ncWmUa/vLwqSYt/hwSCAUwWakNR/
         3VAXI3iIZoajkUnPbebILC9X50NgQ8OB9t3LYSWqDpevZiQubghcaLfHtYZSOJMmMoAZ
         IQ4WIg80kNO6nuhrIGcm6lcwoUbANmjYU0bCX9Pd9E6Xbr4TfrP2LEtNIRLE1k5Gzzxi
         IMnA==
X-Forwarded-Encrypted: i=1; AJvYcCV7Cy5nt7IVT/5Xk3YCyp2s6Ir40bOWnuNlMs/h7VV25Ctgt/6j6Imh6AfEQyY+NsGwPyQPisyQF+cpp4M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjbcDEI0k31KQZ6pyorbiMIrWvv9vnK+1ypzxVe4EOKuxGpMQK
	NSg3FV/P48cq+UUnPKsvEsXW+hqNuYyLMoyGIGjSG9R6nJdiUBsDYdoIS8s336pUILVjUuPYM2+
	sKRv3Aype0xapPxkpLYWdNKQ1L0RORG86Fm09gMQvlPc8lMJIs0cB+3A=
X-Google-Smtp-Source: AGHT+IHrPeUe8EPwaXPn6y+dpbt+gLxKHTMO4wmuATQPHI6pQ8kHRTsga6xrvxBJEnOu/3k2uQ5rws73bXS2yRMIqnbmHvWnhXtu
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c49:b0:3a0:c88c:e668 with SMTP id
 e9e14a558f8ab-3a0c8cba344mr106518145ab.14.1727105282253; Mon, 23 Sep 2024
 08:28:02 -0700 (PDT)
Date: Mon, 23 Sep 2024 08:28:02 -0700
In-Reply-To: <CABBYNZLKMu296VLeEcyMZBw1HFivMA=L6xOZRHHcKwWZb7PQ4g@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f18902.050a0220.c23dd.0011.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in
 l2cap_connect (2)
From: syzbot <syzbot+c12e2f941af1feb5632c@syzkaller.appspotmail.com>
To: eadavis@qq.com, hdanton@sina.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, nogikh@google.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file net/bluetooth/hci_core.c
patch: **** malformed patch at line 6: diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c




Tested on:

commit:         de5cb0dc Merge branch 'address-masking'
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=57042fe37c7ee7c2
dashboard link: https://syzkaller.appspot.com/bug?extid=c12e2f941af1feb5632c
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=127c12a9980000


