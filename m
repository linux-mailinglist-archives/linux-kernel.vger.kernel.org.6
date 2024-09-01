Return-Path: <linux-kernel+bounces-310134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B9C396755B
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 08:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B66F1B21BAE
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 06:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1156313A40C;
	Sun,  1 Sep 2024 06:50:05 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C1639879
	for <linux-kernel@vger.kernel.org>; Sun,  1 Sep 2024 06:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725173404; cv=none; b=C0qaoksv5P+WWU56sFgIKl83xaKEF0Cb18kAgHlvtddXiH+AqcFGmggESWopgQs58tljvL4muA6yAQ5ynMywUI51cqzaeY828kv8eYkPNcG0Cc029WZuwTqVO1m+y8sWVmuug6qQU1UfFOk8HCDioUU2FNcKXbtN8vPbXTJgboM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725173404; c=relaxed/simple;
	bh=yeYCy6QYZeR51Vw+ukJvQD6Cp38u+eTn914o1+UDaio=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=CZ48YsbuGtxNLK+qSczHnYR3QZMfNdlnvC5brLYR4F/VeeBQHA2T+EhPpV2WzShidFK2nguZdWN0wmZ2EVTj1HsSfec5QKuFGeqTIb3K41RcDfqchkWx/ekLmWYj0mW/9ldS1rGsVRmZ3TJhml78rU6W75Ggj7YGvEqiUfuBiYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-82a1a947606so260207739f.1
        for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 23:50:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725173402; x=1725778202;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=INSNF773u2LOTlqzVyB6spHH6Lfax9VosrU71l16kPw=;
        b=r0L0mfxweFNsfTVMJEH5dokXOKkEmWUcutZ5K3rnCrHrcdSlgIF5n191n3pKajHsx0
         ke8q7A6DhrohhBsepeeKkcktiq3rQ/ouBGt76QuUdbcDPbOq6F4I1rrx2UuDmYV9DrIE
         25JxRRwWRp+xN3mOj1I48+CUevs8h5I0rPC3RQ6eiysIwQe9erkz4id/hLMsZGV5ntib
         Sy7jz2nYbUGXT5w+2C4YZ1FqMGVjkooPmDl3Kim/jOYb7iVi6R+aPJQhrhuamzmG9H/T
         hPeshXeMr87Hoasn7nKZdxOGiXlqwObaj2fNjMgYNROUoEZRdDBYtZiyVEfqPmwXO2AV
         4Hqg==
X-Forwarded-Encrypted: i=1; AJvYcCW3pS/FdqEauFlBvPG/zTViiRIyZiA/z73atEaCIG4Rehg2O/zHxFkCyKqZibvgQ9p1cesOYr9Yhu9D/C0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtwH2Mr6f7rbqzSAoRAYo2S4OB6NTzOGH13051bs0fFtels+7P
	UZ68G78ootqbHgEYV486pF7kVCvMdcrFqCZUC7CYULonZ0AZdiECXOu3GaOrXE63vUCa5xapXaX
	Al+sKo2WKQ3Y6abimE7rm/HmB+JcXGhLwWWi42wLe2aEgP+x0tQyty1s=
X-Google-Smtp-Source: AGHT+IHE9Y0t0AmIR5HO8prvxG6BbuM2XE58wYwwQ7Vw6UjaNZqm8JfskPrUBQmPHgso4lzadtZ3xR9N+BMJBcGxVy8NWRNXgXxn
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3494:b0:4ce:928f:ad9a with SMTP id
 8926c6da1cb9f-4d017a1e518mr251161173.1.1725173402374; Sat, 31 Aug 2024
 23:50:02 -0700 (PDT)
Date: Sat, 31 Aug 2024 23:50:02 -0700
In-Reply-To: <tencent_E2678967C3A24456B776176C46C9D37BA305@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d31f2a0621093bea@google.com>
Subject: Re: [syzbot] [nfs?] INFO: task hung in nfsd_nl_listener_set_doit
From: syzbot <syzbot+d1e76d963f757db40f91@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+d1e76d963f757db40f91@syzkaller.appspotmail.com
Tested-by: syzbot+d1e76d963f757db40f91@syzkaller.appspotmail.com

Tested on:

commit:         fe1910f9 tcp_bpf: fix return value of tcp_bpf_sendmsg()
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=17d6a943980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=996585887acdadb3
dashboard link: https://syzkaller.appspot.com/bug?extid=d1e76d963f757db40f91
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16a8590b980000

Note: testing is done by a robot and is best-effort only.

