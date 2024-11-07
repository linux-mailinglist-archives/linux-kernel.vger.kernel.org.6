Return-Path: <linux-kernel+bounces-399385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A67999BFE48
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 07:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB65D1C21B80
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 06:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2CA9192D7E;
	Thu,  7 Nov 2024 06:16:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFC416419
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 06:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730960165; cv=none; b=LU/wYlcOCybP/wy2XbWGI7SxyazktkJSAga9d2OihK9/C6MHNyWQKmwMW+UJ0OTApjP5LZUG2Qz/pjIq8z0bKVnNYzyUcAvQCPeP8FfgnMZ3mKtBJdfE4N5T3FxYHh0x6kYeGF5niyOEja6emLtv0UkIxTwwRi3JjDaaBGZD7b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730960165; c=relaxed/simple;
	bh=Wcx8yYpMyMdpPp2cp0ddkd3ciM+xPc+JM1sDFbbFZbA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=j8x7I21ZVjVp86fgw8nnvbX3Hpuc7LloDrAL1I1MAbY0c8OsNGyUR37u8EBSOr89fq0l7ZOAR43w6XYQ8pV9xLeO3D6vYv4msxxqqtnMkbyGbNh0m79TiElPzk4wV6yn5tC2O97VoWDR0pX7d8KZYHMq2e3KX2hV2pMjNoClOoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a4f3d7d13fso7870575ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2024 22:16:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730960163; x=1731564963;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Eb0c7B1tXWPLmmqNGl8qQebLttW7rUORaipr8ITuR5E=;
        b=vS2w1Z6/Ra70nIhxk4Kla4exW8kZ2LyN4Lshdo3DMaQaZ/NkZv+UnSinbFZc/vA1bH
         Qrkuhvmh5+TCqFe2jZdb/FuNH30i7m3F6aXFAneccvmR7zMP4VkUG23TWHI6Xjik9cTk
         ExYfKJthtzM2TgxFK/dckMMV0d3YWeDpugDl7I5EnM/F3aL9+t+xeUH6+lf3etdleuve
         64u3Mq9aZERnzSJLBN3gScfkeV3E4bPEIZIUCQ+AmRXO8qN3bHGRJ5Ye0l6002v8Wnjo
         wRHCPTPX1/N23qLAKxpztNA2OGurpM0Bjtf8y6BTC0Edurmw9uOjB34INQIBduDAUm5t
         TNtQ==
X-Gm-Message-State: AOJu0YwJXXfu6bzhbN1/p9znT2AIsMFhtJe6SNhOlyjF9Yg8eEuKDRjJ
	jpkuG0wuXEuA7e/nhzonhZvIKzlNrzw1V7YNE/Gik49wHE7Q1CL/pZUu0F4YwnE1JFtvR8ZvWPs
	8ac0BSbhIbG8HOSnFHWvYL9RO5Z909v2E2FcMBOT4AnqBpnnIE/2f/Z8=
X-Google-Smtp-Source: AGHT+IFX3gSZB5r3c2bGUoYZc0O8scO0lUm/2+hRsaI3Zue2c6v7L0WKB/oozEBzJK4tihfiai55CxP0u2M7wuWX+kmiqWZw7Kd+
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aa8:b0:3a4:e9b3:22ad with SMTP id
 e9e14a558f8ab-3a6ecfc2123mr1542855ab.0.1730960162757; Wed, 06 Nov 2024
 22:16:02 -0800 (PST)
Date: Wed, 06 Nov 2024 22:16:02 -0800
In-Reply-To: <20241107055816.3307082-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672c5b22.050a0220.49393.0172.GAE@google.com>
Subject: Re: [syzbot] [mm?] BUG: stack guard page was hit in v9fs_file_read_iter
From: syzbot <syzbot+1fc6f64c40a9d143cfb6@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+1fc6f64c40a9d143cfb6@syzkaller.appspotmail.com
Tested-by: syzbot+1fc6f64c40a9d143cfb6@syzkaller.appspotmail.com

Tested on:

commit:         ff7afaec Merge tag 'nfs-for-6.12-3' of git://git.linux..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=105cbd5f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c0b2fb415081f288
dashboard link: https://syzkaller.appspot.com/bug?extid=1fc6f64c40a9d143cfb6
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1500cd87980000

Note: testing is done by a robot and is best-effort only.

