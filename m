Return-Path: <linux-kernel+bounces-369153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 006929A197F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 05:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27B291C21809
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 03:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C74A13B29B;
	Thu, 17 Oct 2024 03:51:10 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3862E61FD8
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 03:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729137070; cv=none; b=G34SU4dBPCTWLkdYDRpSG0KLNt7l/uZaGxA+1Hxe+vwHHAPNsDGJFZYaYQvnDzuw74/IEtE1RbCfLoIVwcEvXz8OeCR4lZTdHryaWY9tEhTeaHASW8eafBi83YdegvEvLf4nnj77jo8AEPPCaxtJNCNLMKGjPAxM1Q+HzjgWhMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729137070; c=relaxed/simple;
	bh=5sgLZJpPyyKTWiSQH/3D7hHhK7wGKyyZVpJjar0izCI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=BCGvR6gUruW1ojDvQ29DD5zG/Tdpuzm3PNbvtvQ+bnZqLEHL2cOs6QjXfutQ7R7g6OQonbt1MNgP2c7STflfUo4vmT73452plFelrjKXoW6wSzSo3aVznH9Af1OqgjfBVrCWuA6qYv0RjW8EMWtlcUAEZqUnaFWVDGxZ9dFOeUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a3b2aee1a3so5416965ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 20:51:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729137066; x=1729741866;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z2o1r8g3kxMJj+oyImbuuMcrd3JNRmjseZBIKax5nbE=;
        b=RMECZbIZkT6kQpTG/bv5/x0+s07sbN92f2LSdxqrwUJblExXAY28IPfoaiPi7wFNHf
         BcqxfdVCYKlVq4GKcHI4mhJt8k9ziHD0Av5IZbxgab6cUyWUysonUXjsVUdlu2T8xhv1
         3xTctRfaRJrbzUwNAI0NlEPdisQPNammdemnTC0qK9XqeG9CTV/aeN2s8JjZupPnvZl/
         n+ZRs94G0/t2QwuhlJkg5cqVhXLGveJVtY2GLJCdtbuEWcf6QZxMJukoRXl5o4a35vW0
         KAi/2dB2qy5gdA9ueBi58B3qbfZKbr/cng4LsTG9ldE4KAaaszLXuWO/lYkrU/AbyYc8
         /cPg==
X-Gm-Message-State: AOJu0YxtIi4Z6TMgjKLCRA1QrYqXtB47doP6RuXMbX/Py70vXFk6ALIq
	JUEL/z3ZZl9VU6AU+rBVp79cA9IpjWYRn62J4XlKkQef5pTEi/NvAMkGEGNuG5NbEaSxcaGaTiY
	u0WXNFZAJOjP0Mn+sj29idHAQtmOLOoVBl29+iFpIPEli1CJqzmxNlwQ=
X-Google-Smtp-Source: AGHT+IFrsWEpbAWxrJDcxJBhQCGCH2IlUMnQdpZahH205SVL4D8DubWZPexWpdBsl+xnawmS+PTUtaEn9QODKkLnSQYf21uE0roi
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:160a:b0:82a:a4e7:5544 with SMTP id
 ca18e2360f4ac-83792ef2fa9mr2076269539f.9.1729137065792; Wed, 16 Oct 2024
 20:51:05 -0700 (PDT)
Date: Wed, 16 Oct 2024 20:51:05 -0700
In-Reply-To: <20241017031934.156050-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <671089a9.050a0220.d9b66.017a.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] possible deadlock in ocfs2_fiemap
From: syzbot <syzbot+ca440b457d21568f8021@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+ca440b457d21568f8021@syzkaller.appspotmail.com
Tested-by: syzbot+ca440b457d21568f8021@syzkaller.appspotmail.com

Tested on:

commit:         c964ced7 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=135ab887980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=164d2822debd8b0d
dashboard link: https://syzkaller.appspot.com/bug?extid=ca440b457d21568f8021
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1383dc40580000

Note: testing is done by a robot and is best-effort only.

