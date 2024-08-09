Return-Path: <linux-kernel+bounces-280565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E4394CC2F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 10:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43B122813DE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 08:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5602618E741;
	Fri,  9 Aug 2024 08:29:06 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A388218E053
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 08:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723192145; cv=none; b=ObPXPAkKaSa4u5264pEXrxMkJb1o5ph72acTtvEGuMkIsEixrMhQ6fOQtrPfCitEH8tub1atBWpfKBkE4TnOln1V3eCy3W5v4y2FQn32uZ1e+S4RozL0bfw/fuXOidk90Ef1sxZ4sE3y2yDwfDPy7mDnfyLFp6KlhJpZmPsSnPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723192145; c=relaxed/simple;
	bh=cU9RcXb4S5gQpOyUv/FA7jli1JE8vbCBxShMU7mfGws=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=VM599GAJcgJdwyrqrji7pXcOO655FQgdKRjObRLj/0km+RKur6T6lbKfqX3aD8Idf9I4VUd+O+37/7DODOGpwMZzOVRUw2wLWpsVpN5dy0gCx1nhUzVjfdtd2hTSZRrTXYMM/rj454eUNoJjNzinbh9s+GzdV/8i+3OPj+HjjVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-81fc0896188so206430839f.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 01:29:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723192142; x=1723796942;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IjDidAQL48GQw9meQC+l38N/hrXlDPXoqULwhYHkPS0=;
        b=WL985FlITh+CZoFGIRNQgrJnO64aEiV8WppKp25ni+MjDyelnLjiP7N7PuY0P6AecE
         d97JYVTWFAYD1meLJYxdJ0SkkyFqcbIOmD59bL3/Rg4AtxxwKQCUAzxzSPSkNRbUYo6B
         wXmKCElnIIr/Y4ATWyMaNZM/kpGl6VTgSTvlzgJ06KMIkQYI/BztA1sIf6mR7YiKEph6
         qPlmbAUJn5Afojw2wb2XG1VwRmqgp5dTwQOqSayLZPrwCkhbKfAw3EXrHPrX4gtQdIHp
         F2IMErkRyn8ICs2tqADUgRgyIxColWrV1cbFJSm67EbsldZxpYLiD7q4fg4H+RYtKRli
         7Phw==
X-Gm-Message-State: AOJu0Yz4FaiGKJTO5/00ckw83v0zQrLjnLmC0MeoVBcfQpN6Lks8X242
	R01Jqog+ywF3zzOrwQDPU0QVDwytiqDiMMAl1A05Uo7c2ekElh//aJGwhikOmoHxwfthRkfK2FR
	yAB9FU1eWCKENOPzgCYg8zxOdAvq+e6L02HeNWfXJm436zjxB906RoRQ=
X-Google-Smtp-Source: AGHT+IHK2vanXUSbRzlZmZ9m29CKvfo+J0dY4OeaazqkQ3RCcZNgX65L2FA2Q2Bv00pbyKudnf8St+FAeFMdyBcRYmTJR+G9dxfP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8401:b0:4c0:896c:515d with SMTP id
 8926c6da1cb9f-4ca6edc9cd5mr44150173.5.1723192142561; Fri, 09 Aug 2024
 01:29:02 -0700 (PDT)
Date: Fri, 09 Aug 2024 01:29:02 -0700
In-Reply-To: <20240809081544.2529127-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008994cd061f3befad@google.com>
Subject: Re: [syzbot] [v9fs?] WARNING in v9fs_begin_writeback
From: syzbot <syzbot+0b74d367d6e80661d6df@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

fs/9p/fid.c:98:9: error: implicit declaration of function 'fget'; did you mean 'sget'? [-Werror=implicit-function-declaration]


Tested on:

commit:         c0ecd638 Merge tag 'pci-v6.11-fixes-1' of git://git.ke..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=8da8b059e43c5370
dashboard link: https://syzkaller.appspot.com/bug?extid=0b74d367d6e80661d6df
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14722213980000


