Return-Path: <linux-kernel+bounces-319509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CAC196FD87
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 23:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00C001F244A4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 21:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92C215990C;
	Fri,  6 Sep 2024 21:45:04 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E400E1598EE
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 21:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725659104; cv=none; b=RQd+iwqE+wfLKQZuGgP835llG2Dh7yMeEjAfpQiVCzjQfEMKykN42alXrj/4Xql3LHxIeN10RwYexOq41KHOQ83zPOmxW3n/vthfPhiBMl6/3xC8cwvgpcWN8sM1Xmnt7ojvDPTtrYQLaIQvoCx8Nro893oZdJx87oMQKlON5oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725659104; c=relaxed/simple;
	bh=vQJAzXg0Ve7cd7eLQUhLmYpFhx5pRLuWuyrN6fB/92U=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=kauSoRAqSk6oDNU5o5lgsawLUVRZjEXjNnshfpmGEztW8WvD+vzEKMoeBapddRzcnTGKCJOis2DUnqGo3SVg1q+d7Zwd9rW8Jj3xDC5xbBGi6a9J5Ruie5TpndzdPzKoRqbPopMLPPvHL1AE6Mpci3hKgCZidydMNg1Vl9sS25E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-82a231e35ddso487523239f.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 14:45:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725659102; x=1726263902;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jKRnfaZVz+TriRYszdIiGoeKN1ji67pKmKHylWhjTPg=;
        b=Xg19dSpSGMWvFbDjzhMEtJ7q3B3VzkUn2Vmup6loLeNfjWUtEHnyiVK4ba/LQIAdUs
         9xn8Bj/hU7gXfnKx8Qn3ou23ofRJGXc5QnLKA3K19DoQEKgiKQQ/Bfl8Fct6h7Qm+v0K
         +a/mr//T+m+LxHNnrRXWSGko884zRlJ1peHNGY34ZybTVPg5iGQfvyJEvdoxDeC5VR6+
         Q/kyBVVrkKwrcIk/iFgpMaC/jShjjOO0UVwX/570ja3THCCYTasefUsiTquiWaSUwpgW
         ovR9IYZvjxhyVikvGZk3rWozk1Hn1E264N9erBCqGPqOze4bDCDLNIu9LuEhhXBGIAk2
         X9nA==
X-Forwarded-Encrypted: i=1; AJvYcCWYRcKbONOC4qs6M3Xob3TrFFgbTc0ntgf1xvFVnnjK/tHlNZgGch1Gv01jvks1Bsyh2yaC5DA6FyOqVto=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFg7WJUAimE5yKkmlbfPbJXlWPy//LP82E9q9XCrJJbwQaO4tK
	GaN3a24UNW5fD0MdHpHxpv7WpFG+4Dl9ZJ0gqipiFLPD4PiyEe8zOAKWfDQX6aBbfXGkYufxWQU
	bvLnnfPaKqlQw2DIwsiZ6pIiZ4Z8BFRIrHOaamTMso2JL0aUjH9SDPO4=
X-Google-Smtp-Source: AGHT+IEkCvQJA8x0CFn62kiMPQ9qduBCbVZQvrQTL3WC/wnLdYlGWrviPYYLYBiyRuJXvCPfd8tgnIdD11W5kiUP4UgiwrQ+gm7i
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4122:b0:4c8:d4a7:898d with SMTP id
 8926c6da1cb9f-4d084cc4d22mr179524173.0.1725659102069; Fri, 06 Sep 2024
 14:45:02 -0700 (PDT)
Date: Fri, 06 Sep 2024 14:45:02 -0700
In-Reply-To: <CAG-BmocAqtJ94=C4O8O56SpQ7x62i7JMRfXQZMTqeco4GW0hzg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c8529c06217a5106@google.com>
Subject: Re: [syzbot] [ocfs2?] general protection fault in ocfs2_buffer_cached
From: syzbot <syzbot+adfd64e93c46b99c957e@syzkaller.appspotmail.com>
To: ghanshyam1898@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+adfd64e93c46b99c957e@syzkaller.appspotmail.com
Tested-by: syzbot+adfd64e93c46b99c957e@syzkaller.appspotmail.com

Tested on:

commit:         6b8ff511 Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=139e03c7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=14f90d959c4a3f08
dashboard link: https://syzkaller.appspot.com/bug?extid=adfd64e93c46b99c957e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15eb2ffb980000

Note: testing is done by a robot and is best-effort only.

