Return-Path: <linux-kernel+bounces-529465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7927A426A8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 16:43:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42FC41888BDE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 15:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8C824BBFC;
	Mon, 24 Feb 2025 15:38:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1E71A0BD6
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 15:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740411485; cv=none; b=nQEoFK1JGI49IwKQ5Qex09i8s/ZwpKjReETwAv8KDSXBx+l9oFEj6gxUpwnom6pRU0ip3LaljYTbTXGUO3HGHMvP2oy7bRbQWDnrzda/+Eoxra+CuIGv2w82T4ujwb7wM7wHiu+E0pVinMPjAOjHWu/WV7BCB1Q2SQGkr/zA45o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740411485; c=relaxed/simple;
	bh=1bcNFcwwpLPReHcTdpi29Uz7kpzCOIwcFak8N8SnTjs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ZN3TSQ39rT68BzT/InATs9nEU9Qe+ItssfHvFlG9QlibUM6roH1eTLIZ74anxv3HeapHqIlmQoO75KQo0DbyzQUx8FtRS4VFjAggemJ93O7vrmrR5IGHTu6PmK7pg6fAgFFJ5ux3RBpFmHmd0pXhjSCVZK0xhRDlVQAOlvaDX9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3d2b1e1e89fso34931375ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 07:38:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740411483; x=1741016283;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PkHle2mOiR9F57iCJhSZBBB2v8umfPpMYllh5B1OrSE=;
        b=WJ40+SFp2bK8WJSUL/69R88qwn3OBOH43ZssOEJ7Hx5cqrmLn7NNmr6GGyb638Azzs
         glhp0m/K5fcI+/35sJSdajyY5dMKLdDcFk0l+YbCZuAGArOXsqQIX5ohv8YPgGxyUXXt
         jwiPx0cG1D2m8/4DvIKavgiqiV+iD0iYQ0frRNGrRVLKkDJcz9BPEZDZHJDlBNk5/6Tf
         vcb8oKIC5ChFAHH0sOn/JRNqxRyTZShrfVAjMTggLJsYF4mD+i5gtcAybNfLVXDLvv6G
         cLDfVz88DohDlQMoaQsc/cHWwXbM3gu4QQU9+gFLq2qDWKDeLAWdLR2slDYmb1oNKI7J
         tXrw==
X-Gm-Message-State: AOJu0YxbJiATX9K3D8O5grVPjjSejXitERau4GkVz2vyImHJjAhX602K
	P1JcPQngCocPF67JkqgNw7GJugXeN+s40t8VECsF2kSZl4YUXJZ4dQYzrPuHH3TuZi0j3fqKD5J
	tIyZDKFh6dXutHOjUlOzobYr4mIJiNXt4gMYg0PZzgU2XXKKG7tQeB0I=
X-Google-Smtp-Source: AGHT+IFnDnwV5Zg7VLSu1I5l0SOa8o2OFnqhGqLjP5npt6ja4t2CRIrriVB0fnZ7yIECq5YtTJiDTFAoLdvIt9m8ma4gkOVdHV+5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d0f:b0:3d0:235b:4810 with SMTP id
 e9e14a558f8ab-3d2cb429ef3mr137694285ab.2.1740411483240; Mon, 24 Feb 2025
 07:38:03 -0800 (PST)
Date: Mon, 24 Feb 2025 07:38:03 -0800
In-Reply-To: <20250224150121.1219049-1-n.zhandarovich@fintech.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67bc925b.050a0220.bbfd1.008b.GAE@google.com>
Subject: Re: [syzbot] [media?] WARNING in call_s_stream
From: syzbot <syzbot+5bcd7c809d365e14c4df@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, n.zhandarovich@fintech.ru, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+5bcd7c809d365e14c4df@syzkaller.appspotmail.com
Tested-by: syzbot+5bcd7c809d365e14c4df@syzkaller.appspotmail.com

Tested on:

commit:         d082ecbc Linux 6.14-rc4
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=144cadb0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=aad00f970c774056
dashboard link: https://syzkaller.appspot.com/bug?extid=5bcd7c809d365e14c4df
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=118b3fdf980000

Note: testing is done by a robot and is best-effort only.

