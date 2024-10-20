Return-Path: <linux-kernel+bounces-373113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 088769A525E
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 06:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5A121F212D2
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 04:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8721A8BEA;
	Sun, 20 Oct 2024 04:12:06 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6630E523A
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 04:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729397526; cv=none; b=BEHXmYtsi/vVmY9N31cWPRU5OhvWEtiwnIgftw9OnQHSoMDHpslMneqpVlR7Uu/sVwp5MMLW9t1ymq8OjNE2MkJIkL71jkFYQK0ocKR+neNbESPgs1HuzoaSalVnYSpQ/FCtfUJlkcRfJ4hX4ehkYBuzYWRZ/fUwvVIOwr+YMyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729397526; c=relaxed/simple;
	bh=XiREbONcjwTPHWrF77e6lQ4Q29UJhecXbakHOmUUbdI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=i+X6v+wrk5ylwr9LenGeCMJlQpvuY0pLWThzILDYm14z/WP0/Rp3EVfa+wG0TkLKQFeW+mk8E/lgEvHWH2Z41Ak0V0vqsh0GYQx5SjUoHe5Zh4482FmcOX68vB0B3xN3qOyYDUkOlYaBHbA2S71mjq7F2S5G4ZhCUZNtX1t931g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a3c27c72d5so28980625ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2024 21:12:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729397523; x=1730002323;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LN66OFXS8pL02CHqPeZmiIHb45Jy63lerWr12e1DZWA=;
        b=Yc91qwG97QflkXMM+2hcw9khtg09SB13l76Wzybk67NAh2JWnB/SCHj9C1os8NSwKZ
         /s36ZsNMfeiKMlbkinTsoHkMKYakJ8BlMz4Bf5wfD+powkt4C+SLMJzi6Vc0WgfjeNI+
         sMa7n2dWFwprpMdbobsd9v3S0RUfvZKq8nPK72m8huURWgzXnZBVOAZQOx8X9dYx9nd2
         LCFMwy7pg8UiNn0jwhxZKBkSPO+X6K0aEOjxWZRvX6xHnnKGWLgfITrArM5SdTNrEoKM
         gNvvJTjelaNYpvaXqadYWVY71k3C+bO8vDIJjMqTZAHCt7uHA/EPdQLrpCuoa7xaHRxF
         jdSg==
X-Forwarded-Encrypted: i=1; AJvYcCVUJ5wLn7j+SJRkr/+I3ykePgmgfPGcSyK+fbBTAufYsVDbsApjeaJA/uDdXzn5a/IMlG22ofaazPCttL4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgilvZiw8bKjf9evTsc29D2TRRDGhlOXeLUMa7doIUTvquMybL
	Q0zD/Ekud6kW96eu5TESvhTxGlnmDRmTYDr6zd0tbuf3AuEuc1okTVp53M+MEn0zSTm12COLsql
	xvf6A+FbYzHUGN7m9cX84YWwuAxjBFwFWWoQxmwzyisz++tc3JUos8So=
X-Google-Smtp-Source: AGHT+IGIJpjHQdGbatsT8Lj2R18RX0GCiUV53XFJVOeyzmH/hmqYRBVtu2xYiEe8x8I1O0jaenyTFYtQBHmDxXrlw12oyzoT36/l
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c85:b0:39d:637f:97bc with SMTP id
 e9e14a558f8ab-3a3f3fcb59dmr65985215ab.0.1729397523441; Sat, 19 Oct 2024
 21:12:03 -0700 (PDT)
Date: Sat, 19 Oct 2024 21:12:03 -0700
In-Reply-To: <tencent_87498E2ECA6EE38C96E7C6C6F952D3C65206@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67148313.050a0220.10f4f4.0027.GAE@google.com>
Subject: Re: [syzbot] [xfs?] KASAN: null-ptr-deref Write in
 xfs_filestream_select_ag (2)
From: syzbot <syzbot+4125a3c514e3436a02e6@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+4125a3c514e3436a02e6@syzkaller.appspotmail.com
Tested-by: syzbot+4125a3c514e3436a02e6@syzkaller.appspotmail.com

Tested on:

commit:         715ca9dd Merge tag 'io_uring-6.12-20241019' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12d9b240580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=78db40d8379956d9
dashboard link: https://syzkaller.appspot.com/bug?extid=4125a3c514e3436a02e6
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=134a20a7980000

Note: testing is done by a robot and is best-effort only.

