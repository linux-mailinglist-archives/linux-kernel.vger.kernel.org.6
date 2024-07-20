Return-Path: <linux-kernel+bounces-257881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3775E93800B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 10:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2729B21906
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 08:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6FE328DB;
	Sat, 20 Jul 2024 08:45:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0608A2AE66
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 08:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721465105; cv=none; b=AOlujoXD66tE4DahMPeH6XNkhPbSwCwbjQBE8onCFxGipThjec0rokEKDkVwB1H51y0ck0JndM5qtN+DU3SZS1Jqo56BQ1ClhgyecD0vMbCSmVe30Te3XvT9uJdIX5CDZWjnNyP2dOP6VhITmQS+SKtEUjFm9xMpmoGCWmPjpsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721465105; c=relaxed/simple;
	bh=PIVNr4G1SYzKbY3w/sHzIgWaxXHUnr/dyRT/lljYiw8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Vx4RzfehMnPaJgrImOxLgd4ScsuV7TrXsukvzvXKTVBAse7F22zawa3lbPxqw1fkGH2HSA3iKGm0VudsmZyD/4Z0Or4K9i4yhb78Svmwr8mV1HyyC6maEhtiDneo/04mzCquUpTcyuBOL0VHSyZh9OYC9TSRgX88XzcVKFN5qww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3983ed13f0bso18950805ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 01:45:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721465103; x=1722069903;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7veHkM3Fd++Htd4NptFpfnvDW2N5u5LbiKZxRt3L8MM=;
        b=QL0iumJ+qaIIdYAqm5Iqxm4Ki0lyi6yIK3PJfXIehQV+QEjl4pLTJNtj+MNhnDNAQc
         uUQG9KQfKIKWt79ZKKY0QW7kaVaNAwV/JviVJrCU2r+c2iZXcsKGFmPUkLts+rQf2ZLV
         69Ksq5slA0FEiUySQfPioRJ/69o5FMyWCXIrIY5G00siHwqHHJANr1gkU2Kez2VZdDZm
         W4oKS8tUs2cozEl9/O3IX1Gq0k8bCwPLEld9LUeVGhp7G0e0PtM1mTpybWzAE6YDYk/I
         ZbcZqo6d6U4xQx4eZpU2HJgRKH9yYKeYtXIgKLB+ILZOGe0exF5g2LhDKN/YF73WHzM/
         vICA==
X-Forwarded-Encrypted: i=1; AJvYcCWRk4pqbXDYuC7Y/iNZE8VZj4CAM9aMNAF4AOhnl/eaZVR391PLo0YsN/9db1hhHzP6RgrjK/Ul2+nUdrxPQxQ1UIDPXod5Z20TsTMu
X-Gm-Message-State: AOJu0Ywm5qVXFVLUJcFJP793TlGphQHmLrNqvaRBQrwyLAX2xgu3rKTv
	CkIHV061XDHjJQaWTX1QQnTDScB/P1lY1tfaWk2vM2ttHDkk/Qt423bPlJIuLpwP697NjE+/FOE
	yXcP2eZ+A2UpfXL+NcjHt61Ef96zLZpu2I6DaxG2ucTVpQThYbitH0cA=
X-Google-Smtp-Source: AGHT+IGQuJfKgcnDiTQ0aXgylrxj6w+U8+/YlB6ge5XNOLfsyCn8aadwbv70T6yDzZYHzni9aGgrUYD7DgaMriMjnYe9zstVeGyz
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c1:b0:385:ffe:4516 with SMTP id
 e9e14a558f8ab-398e4db86a7mr1377915ab.2.1721465103207; Sat, 20 Jul 2024
 01:45:03 -0700 (PDT)
Date: Sat, 20 Jul 2024 01:45:03 -0700
In-Reply-To: <20240720081802.79749-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f860ea061da9d312@google.com>
Subject: Re: [syzbot] [net?] KMSAN: uninit-value in hsr_get_node (3)
From: syzbot <syzbot+a81f2759d022496b40ab@syzkaller.appspotmail.com>
To: aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

net/hsr/hsr_framereg.c:227:11: error: no member named 'max_len' in 'struct sk_buff'; did you mean 'mac_len'?


Tested on:

commit:         3c3ff7be Merge tag 'powerpc-6.11-1' of git://git.kerne..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=87a805e655619c64
dashboard link: https://syzkaller.appspot.com/bug?extid=a81f2759d022496b40ab
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12ff6521980000


