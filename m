Return-Path: <linux-kernel+bounces-282264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40BFC94E16D
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 15:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C6321C20E3A
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 13:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C687314885B;
	Sun, 11 Aug 2024 13:29:04 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05738136345
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 13:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723382944; cv=none; b=k3ANoQlVDIxn5ugLmtv2iQO2Ct6mj2BMRQhsPSXSIi9tvlkoFnbu3VG8i9gkJlkGhn6DcraYqBpeKXRcadcWpWEUxfFf9dRDOk/dtOqUY0MmqAZXiPB0PGQvhnKGx+t+SWB6vSEzD2GV36OZXl5WVn288mH5L/R/suyPSJauaQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723382944; c=relaxed/simple;
	bh=4VIJuiITEW7ewzHq3AA+up117C46Xna41EtTB6jRDpg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=DEkIy9Z/VpRSnJOFCwhT6s2TowL467SuW5FNdnmq6M1QVJ3rfRA6Sk8daGJJz74he+tk8w2SFr62O5xxU/OmjzIIWrrGegteNW/knxvQaX5LXgkOPKG+89YrdfBzTJpiG9Rqimmb06ZryH7mZ1ww/CnbPytZQN+RaNh2CEeOGDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39b28ea6f37so48016395ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 06:29:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723382942; x=1723987742;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BnkKa50lZ8hs4Qk4BwOyGnKaIm3qqKKfma5Pq5XbRrs=;
        b=Uo72n7+VeUxeVbIj0ok1xrqVjB6P2AYhes/qJ4EmFWeGfLFHKDpV91LuM/Jw79Aotf
         pORW8b7ftjWzvlYj8Mgrh5+JrVusvV2s0U6+m5MkvLiLMJRR7LLU8fjiLissfbgPwDrx
         PPUC6DiICW3hbb0YUCFgMO44bv9cGeDApaQPGuLOr5vYN7zfVYKH86GK9df+7v/d3KkL
         /2H9M8UL0wl0dvxwE8FQdP0oto+VfoBHH1So5HK14nZlyuryONuF4+jbdWFeAgRb26Xw
         0R7f3inhdE0xYpwI+OoUHIRqR8oS9JCXNNC9KDTS5G4sBhHK29MN1j/KU9adpRLNlX3p
         U5Zg==
X-Forwarded-Encrypted: i=1; AJvYcCXSbjy3xCdVD+oInukXIcmwjNO6yNxslv3kuYsrGivXpPCTHAweE+Vi5EFlyq3rYb9L/V4oDNVjxbgQThE3AqqzDX2/vzE+ZP2dChsQ
X-Gm-Message-State: AOJu0Ywk0AYTyRV4S5EoLeco1HoyZnlOSsrrq0s6bnZKkB1dQdPK7qVV
	UUOkmaRKoQBHXKj+dcBC+Zh3q2QIZdeAH69Az+/CVEPuZGzcC1KZt22y1WMV4I1SdKEd4dvG3gQ
	vTkTTot4SwyNL+M6JI+uLUs+N9Hbdrdb/Yx7JjHlKGEB7tTLk323+y0k=
X-Google-Smtp-Source: AGHT+IF86Mz5uFG6noEffyBuynmhir8KuMZ4KINCzCYEAYQ+fD0uNmCOh4N+xL+7PJ1qedIPxl2odenKYUfLMEUCn/VWv3Q+BIPQ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20e8:b0:396:2d57:b1cb with SMTP id
 e9e14a558f8ab-39b748412dfmr4968815ab.0.1723382942031; Sun, 11 Aug 2024
 06:29:02 -0700 (PDT)
Date: Sun, 11 Aug 2024 06:29:02 -0700
In-Reply-To: <20240811125816.GC30068@redhat.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000127956061f685c79@google.com>
Subject: Re: [syzbot] [perf?] KASAN: slab-use-after-free Read in __uprobe_unregister
From: syzbot <syzbot+f7a1c2c2711e4a780f19@syzkaller.appspotmail.com>
To: acme@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, andrii@kernel.org, irogers@google.com, 
	jolsa@kernel.org, kan.liang@linux.intel.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	mark.rutland@arm.com, mhiramat@kernel.org, mingo@redhat.com, 
	namhyung@kernel.org, oleg@redhat.com, peterz@infradead.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+f7a1c2c2711e4a780f19@syzkaller.appspotmail.com
Tested-by: syzbot+f7a1c2c2711e4a780f19@syzkaller.appspotmail.com

Tested on:

commit:         6a0e3826 Merge tag 'for-6.11-rc2-tag' of git://git.ker..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1430267d980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=505ed4a1dd93463a
dashboard link: https://syzkaller.appspot.com/bug?extid=f7a1c2c2711e4a780f19
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1685014b980000

Note: testing is done by a robot and is best-effort only.

