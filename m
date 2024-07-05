Return-Path: <linux-kernel+bounces-242410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AFF99287AB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 13:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C2C11C221CE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 11:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A15B149DE3;
	Fri,  5 Jul 2024 11:18:06 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8544147C82
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 11:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720178286; cv=none; b=HX7syx9eCIDORsQfpsAcezbLQ7EvFhVtOgfvFjeaAMzSj3JJk//GVqXRsujmE1VFOhX/8Eb9JdLV+kt8luOxInSKzf/gE1WTEPt5sZ7lC30Rp9lGBHlY9LRNxvqlPkqHvruKXeGwu9ZreJWRolKBSUBtZ6sMPRi2MKdk9KjNHms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720178286; c=relaxed/simple;
	bh=DcEvBQzYn4eHzbpGBy15PzrDsQIOG4YC35uyd6YyNUg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Y0wn03ZC31OMN5t0SLyhNtnccUzKzYRLwbnIwP2xIMyjH9vTHzIhrodkgTuSjhyLe+9CEMfU5WlEtuL8q0gOAdbYhhHlcdD7TmQLrNyMUPI2bLtkN2OkgQst/TJMYX6Wbu80mUq6HsIcIi6ONDrWnKk197xZSAbaPKE/orNPfQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7f66b2c7e9aso194334239f.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 04:18:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720178283; x=1720783083;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FcXD0BG3kuwJsqIbgzDKmojoQKPo+GlBR5V8khmyXns=;
        b=BeQ97FL333iSlKC0UfspjtzdzkQDi7yKAgH0mlUTpI+krHPTcRbnp2/ACVTwkfOrz/
         vlL4VUTyevb29mj500kZVIcL38/aQiASOO5rBRDUxDn/rftxPKRTuJITd3qfvj1v9D40
         OfWgaumt+zPUGrvmtfI8C2CZAk2knERnrd5Ulgi5QGIoRhgR+r2Bq1ocYZQTcAsL59vH
         Ra/jcSzkgYlCihzhnwr41fjsy0FbNglvgjobe1SVCTN7bqjwbsfSmDmN+LyliReiv58E
         VF2cqFFRXv9TahjNpSddtjxtiV++NJv4CEVEOBQwBmawrE3gQRSJkMrrdOfQUry8GOmV
         CnUA==
X-Forwarded-Encrypted: i=1; AJvYcCVEnTfwbGEgQASd8WQRY3SYJEmRme8xc1FNr7Sy30adWuxA4oq27vxPOvnvtc+nRxeXjaZfb7c5+Xb/RLsVW0fZXrznSBFUc/JIAiJM
X-Gm-Message-State: AOJu0Ywpxgj5fjJaar/R3sE6WWhcARyCnpdIq3vMs3WOLgpKOdN8gcjW
	3YrLm+KcZ/PkNX/jkWZqNlSXC7DggLPHfj92yXbjF8WYn1Bssr96vMpddvngdJg/gjsI77JjeS2
	qrtSicQKvgrnkWF5TPwlalz3zS36oXvSV+h4cR89PecGqQ016xgak130=
X-Google-Smtp-Source: AGHT+IFMVpbI/oyUD/Nzf6SMZz+ORuXDMuVeo/VwepvtWQMChUOmoisakOynndWpToGIlO7sv74oPSteHwMvhUCQGIieG7LgFupM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:35ac:b0:4c0:7f51:c3c5 with SMTP id
 8926c6da1cb9f-4c07f51da77mr85862173.1.1720178283056; Fri, 05 Jul 2024
 04:18:03 -0700 (PDT)
Date: Fri, 05 Jul 2024 04:18:03 -0700
In-Reply-To: <20240705104821.3202-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000832194061c7e37c3@google.com>
Subject: Re: [syzbot] [netfilter?] KASAN: slab-use-after-free Read in nf_tables_trans_destroy_work
From: syzbot <syzbot+4fd66a69358fc15ae2ad@syzkaller.appspotmail.com>
To: fw@strlen.de, hdanton@sina.com, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+4fd66a69358fc15ae2ad@syzkaller.appspotmail.com

Tested on:

commit:         1c5fc27b Merge tag 'nf-next-24-06-28' of git://git.ker..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=152db3d1980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5264b58fdff6e881
dashboard link: https://syzkaller.appspot.com/bug?extid=4fd66a69358fc15ae2ad
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1395cd71980000

Note: testing is done by a robot and is best-effort only.

