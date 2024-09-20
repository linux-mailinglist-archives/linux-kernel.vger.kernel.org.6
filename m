Return-Path: <linux-kernel+bounces-334697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F9197DAC5
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 01:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1E2D1C21218
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 23:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33E518A6B9;
	Fri, 20 Sep 2024 23:19:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B7F1531E1
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 23:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726874345; cv=none; b=CYI5ERB+ggUD+RZXPzAIPA19KAycfmNK6kwkLF3nBahg9md0hZHPTwP4ESE4iXoeFqZTMNm9Gzi4UynlkHGAySDXmrpK7F52CDvidD0vhbpMIMAxzswVQOqP5s0wvopCFFVX2mFMgm080Up37A7xzoTDZ1TOHjNK1YopF9rjeKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726874345; c=relaxed/simple;
	bh=aFyRAmhT9zUmgflTkx204tNVMvA3xkcW9nYv+0sy2+o=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=XPsDK07DidF+HZCZfnmzBMSeGd8lm65vzra6zpcHidoANM2t72VVkEYLkY5utkbUifFXXz5uunApM3DMczh3hY/QTYZOP3TALTJmr9R361kLMrwWLAnG6wW6p+pYxW0ZgGV6ok9DdLGZsKJtwxrUw7xhh1dEsvgkTYft0SXsptE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a0a2c95e81so32246085ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 16:19:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726874343; x=1727479143;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ns5zg23lQTVN+Sxwh8wVeSg8SPgTxehmvUwFAr5ff/4=;
        b=gxK4MvHwB06ISHVbnvGQfgY+z+NMPf1VedDEew1B4rQYe7jbMsSu5hOEujQfmL/Uaf
         eKrSi0bY5VepTZAO3GnSmbxl0mwNiIiQ32bkCFvWK8NK0tjBL7Pc5uJyG6t416Nvzx5+
         2jk5ePs25MpuE9cl8gl2M7WBlYkO8puBEMCYz924FgBLskmTnKNkvZkaC2ZYEt9Bn4sN
         lvFJ/+xXJqe30L7IHBMTv2n+d6tvyVOn5dbM1h2WEar6YmvzMapYvTavEDBm9z1Xzb7K
         Rt7NC1s/0+Kvc3ofyEawDpLzFtU8BLjGbuz0YgF7IuSvxV1D3f/Yq1wbrfZJGFSKNOTP
         GVxw==
X-Forwarded-Encrypted: i=1; AJvYcCUEy9n4nDw2tpURawhgAcyRytwgANrpwuQLajNlJZpy9iA9PG+Vf+izQbfhoNm/QP7O2GR/T8ANs4/ynH8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1QOpdxEbBFsfy2MZ+nooQJkB28lp2S048iYmXFkT2NpgKmqaQ
	anNeipDz5rx9SKJRIYsgiIi8y1xVUU3lPmx9yLLVB8ylrHY/djcWf0vCQ14w38OqL6PXQQrTo+T
	vFZ6s8uBJI5FTgrYc8Y6Tj6mX3oJMtFVgV+RnxhE8u3n8glC/sNcDDTg=
X-Google-Smtp-Source: AGHT+IHVVfIMSkfJRlIK2pISjvj1ucQmiMJqq1H+ghk2fcN139rC9/JIDBrBY3MOETXnxPV7JiAA/4jZ3pQMOaURQiGM3RmbwnMF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b0d:b0:3a0:9043:59ac with SMTP id
 e9e14a558f8ab-3a0c8d387bamr48859565ab.25.1726874343108; Fri, 20 Sep 2024
 16:19:03 -0700 (PDT)
Date: Fri, 20 Sep 2024 16:19:03 -0700
In-Reply-To: <20240920230001.685-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66ee02e7.050a0220.3195df.001c.GAE@google.com>
Subject: Re: [syzbot] [media?] KASAN: use-after-free Read in
 em28xx_close_extension (2)
From: syzbot <syzbot+a11c46f37ee083a73deb@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+a11c46f37ee083a73deb@syzkaller.appspotmail.com
Tested-by: syzbot+a11c46f37ee083a73deb@syzkaller.appspotmail.com

Tested on:

commit:         68d42091 sub: cdns3: Use predefined PCI vendor ID cons..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=13fdcca9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cb61872d4d8c5df9
dashboard link: https://syzkaller.appspot.com/bug?extid=a11c46f37ee083a73deb
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17219607980000

Note: testing is done by a robot and is best-effort only.

