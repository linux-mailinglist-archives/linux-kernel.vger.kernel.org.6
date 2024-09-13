Return-Path: <linux-kernel+bounces-328185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 563C2978033
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 14:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90A231C212A7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 12:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A3661DA0EE;
	Fri, 13 Sep 2024 12:38:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA56187849
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 12:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726231084; cv=none; b=DvK5anJQQOh3/mk5QAiAqboULIwaJpqYFfmEBSKQn2QsfBb9GRsy3EH/MROrxjo0OKN1V9gXVdwVfm12Dpt8S7X3ozaL3MN1z83AZsHsLrfXFC5WGTx71GQmEIkSuZKmajdZuXObf0Ac7MMcIIDPlHl1Tk2O1YPyCRH5SOKN0Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726231084; c=relaxed/simple;
	bh=tDdQOXXTIYsdRS8oWp9XIlIKUUvMOZrroZP1zmOLyWw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=jx2Jw2fSwaoFY5XIEqOttNjf/KiKXCaJw+xQs5e76JE+QComlOSzRKUFVu7zZ4ejTmXvz+mBksX2gaihuCOjlfJ4fwlCSkQdmPxoqBBGHNqWYaxqkKbje0C/usodLpPYPTRKblz72vP2LIA8/PfqeipJtcKv9W2KjphfVuK11F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39f6f16ed00so10762505ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 05:38:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726231082; x=1726835882;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bzJrkn4E5674WzmubT500OgDUeZgNQiWj0sFXmEpZ8o=;
        b=mHTD1aAxBSIQKD3di+tUk9IUKkTimE4LZ+9bQtwQXrSmeOLhzHTDhJ/YdkXOpr6D61
         DgkZSUrJLWjr5XzgboH5soro8VcQYqVoC79trQXdOgNn94p1Pf+2xTnnTkuPy6FyV4MS
         gxogWbI3eWo6OGcWTsnCKY0itAr5Urs2uAVRksBlJc+u80/IGwurj+qsTUQdnvaqKThM
         S/UGB3T83NEqjjO7gfsI1IYKCBW24EMchRbrD1LTLbukD/cNc+SIfeeB/jPVf5X8VSJZ
         aIBLYk9P+RvcDaiGiVLdPwSY8i2iA3HywSCl3grgnFr75ncTqk10H0q+8R/jVPcjtCpy
         BTog==
X-Forwarded-Encrypted: i=1; AJvYcCVA09i1SXrB/arS1uQ92ooJ4NjICZ5zM55vCo0Wdm8PHDPSz2xTwNJ6XnQkr6MwjUiPaTH6+aXzwphB91g=@vger.kernel.org
X-Gm-Message-State: AOJu0YziZvMk1nVxoCi/9L2FkITkAN6FEcLqAgh6v5TfTF6T0eaBVauq
	2rSCBUmiV+4j710RyBBzsA/PKSqu1I8qms6WKnVGjZ3W097ymelsvy4oMxd4vo6vsY/8BEZxnfB
	P1ZGeZrzGciHFgrYyeVl34rHIyK08eU+eYejK6H33ylCvSESzW7Rob3k=
X-Google-Smtp-Source: AGHT+IGnWFLAKoLqrNx9MzGgJYCSfB6+5jz12fG1fp7koR/LR6jauqhy0bYHYArUNVuGqNQNcVQeuyiPxnSgsuVXutvGzKI+6uqc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1645:b0:3a0:4de2:3257 with SMTP id
 e9e14a558f8ab-3a08b789712mr27008835ab.18.1726231082533; Fri, 13 Sep 2024
 05:38:02 -0700 (PDT)
Date: Fri, 13 Sep 2024 05:38:02 -0700
In-Reply-To: <20240913121109.289-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007999780621ff7e3b@google.com>
Subject: Re: [syzbot] [wireguard?] WARNING in kthread_unpark (2)
From: syzbot <syzbot+943d34fa3cf2191e3068@syzkaller.appspotmail.com>
To: frederic@kernel.org, hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+943d34fa3cf2191e3068@syzkaller.appspotmail.com
Tested-by: syzbot+943d34fa3cf2191e3068@syzkaller.appspotmail.com

Tested on:

commit:         196145c6 Merge tag 'clk-fixes-for-linus' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11ce10a9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9e236c2f9e028b26
dashboard link: https://syzkaller.appspot.com/bug?extid=943d34fa3cf2191e3068
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=126610a9980000

Note: testing is done by a robot and is best-effort only.

