Return-Path: <linux-kernel+bounces-393938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 575E29BA7A6
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 20:25:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F0D61F21CA4
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 19:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A23B187877;
	Sun,  3 Nov 2024 19:25:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B8B33FE
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 19:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730661905; cv=none; b=M1B5tk20GopYsqel+a4+nL+d2YcqRm91Kbh5C7uEM202xGJRakm3uJUv/nTd/+/DfZ45keMwQFzjGJLYUnL6TxhvcEQomnWCsARWRKyvYwWDtLS465KIQ1GiVHkj6K4lpmwLTzcIeXrAAviJvfLlOPuPyXSXjxnbb8agacTcC+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730661905; c=relaxed/simple;
	bh=nvTsyDcgoEu/calHoRBoCTFXmfOrVAo0pwQ1p66yYlI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ssZadgQZNN5bTk4mkFeGh9g5P1NTU6LSWCxEABHeSMNXeXnpIFXiiZd8SyUqv/HKNUZM/aCefIVgd2KZcoy3pfiXYTMaK5Rz1rocrmt1kznepeFEmPqJynqCjAcLm+g3wlpxNXBiDoYZ+A9WTe3AhSC606cFRxMtSF/B7VpC7m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a4e41e2732so37480165ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2024 11:25:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730661902; x=1731266702;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KblZc6VcAIuMERdYLFiG7bVAPjvh6qjeAle0kPTQwNg=;
        b=e9hhSIgtE6Y6hT8LD3nhaCZD/aDpLdIHBL8g3Pwq6iYYPG4G4fd9NrFNUR5l4+nMiv
         k6GLl03fw52M/qpNHpd7Cb3su4dbFcPlZ8eDwQfr8fRaw6eA+fDjM3B7/3EKMn/JNHMq
         A/mzBUXZfJjgjjoerEjeltO//uDTXT2MHFr5ky6tc282miJnmPsDHfsMyNvFs5BBfMj8
         r8DIeLqn7P+lRcnphAB+Biwt2fTvEaXHrC8+qIZOLjh9Hk3cOzBTgdc7Rd3kzfgOj8zs
         342Nq9Vx9G0oly68x5KOk69qN/IrTJWjgh03FDBLVw/TydFeCFwX9h2G3aIcQhj7FSEa
         b3Yg==
X-Forwarded-Encrypted: i=1; AJvYcCX15sEOYCqEeT3Oq4n7JztvASgaHS2FiN+LwBzLfdkVnrpOCDh++wPxo8PTMpz9L+dlvCTcqa+GB166blI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyjsx2DwEjKBauodm3025jnonTz5OUPaXB8WnS7a+6hGQZ8kkRj
	p1LV8Urg1gGX6yiQedDwGhVls0wQq1tlx5LG3xZmWqtJNIBF6nL0yYB2ITinNYD+VMMnL0Lj3/M
	o2174jltCzoITN0EVNeSXBMsy91vbjmTlLaeMkIkDV4dvb8zEfkEI2DU=
X-Google-Smtp-Source: AGHT+IHutQpETAki9hW9AxzbVu609WpTKvTxFUSmrZ3nzVb49y/e/bVgZgJH4/oVCpplWce4p/IbL4bFaxPyOY5lHSPwSjedzmMp
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:52e:b0:3a5:e3bc:c1bf with SMTP id
 e9e14a558f8ab-3a5e3bcc3ddmr144999335ab.23.1730661902543; Sun, 03 Nov 2024
 11:25:02 -0800 (PST)
Date: Sun, 03 Nov 2024 11:25:02 -0800
In-Reply-To: <6727c3ac.170a0220.27f534.dc51@mx.google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6727ce0e.050a0220.3c8d68.0a8b.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] general protection fault in ocfs2_xa_block_wipe_namevalue
From: syzbot <syzbot+386ce9e60fa1b18aac5b@syzkaller.appspotmail.com>
To: andrew.kanner@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+386ce9e60fa1b18aac5b@syzkaller.appspotmail.com
Tested-by: syzbot+386ce9e60fa1b18aac5b@syzkaller.appspotmail.com

Tested on:

commit:         886b7e80 Merge tag 'driver-core-6.12-rc6' of git://git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=120b4587980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=35698c25466f388c
dashboard link: https://syzkaller.appspot.com/bug?extid=386ce9e60fa1b18aac5b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=133efaa7980000

Note: testing is done by a robot and is best-effort only.

