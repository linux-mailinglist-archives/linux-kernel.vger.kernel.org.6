Return-Path: <linux-kernel+bounces-279355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D0E94BC32
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 13:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52BCC1C21CD3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 11:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34EBB18B474;
	Thu,  8 Aug 2024 11:24:06 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF7612C7FD
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 11:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723116245; cv=none; b=FNGA3bGBzA4Do7T6YCFIrL+nZb9Bruys0QgBL3IBRYJhe42xtfrY+pBI35jdPjehVYJIUtcx6QIX0wypMMuLHcCbuiztzZp2sZuqjkLw+WZn6IomhV21VwsEFUUjFBBNbR8pVzYBW147GP5MRpyDKIIO2U8WPTIPNEj9J6gh6pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723116245; c=relaxed/simple;
	bh=+xDchZJbJ3PO+TDI075y2hz4G/L2JOpKpUfZS9DY3Q8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=OTTn1UK7vP2KXXj/sJIfKruopEr3AAg8eFeswjLE+7raq96tG30zvjliBXpZqoKweiPnauUVkc49AkoXhrC4ZRqPeSucnsXAej6hXKxiUhO20RmRPvwwdCnnDd+cm4G5uqOB7m+Ie72rt6uvGnu1JsTq1JdM7xi+bzT30HTUu1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-81f87635cc1so109365439f.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 04:24:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723116243; x=1723721043;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fyc7NzHKl6161WpX1EslzQw1uJikQ1PUunkU3f00TUw=;
        b=Q2tRC6XEYN2aBki+BlJHmkUnq0B7ZDMV9DG6wJ92st03xibiBNZHHU20irI/JviTCg
         4yEfecaU94+mHzTEOcWuZ8zKC8e+IX6YJDyiu9O5008e+f0P2ObJNTmWAE7rWhZ5Df/r
         mfsmT0QVSMHv+tD+ToYI8tUq4evy27XIWq+9TLfVFLmbXFao4p4EBTkrdAkRRLIH1mRG
         X+begYO9z09K1KeGK2Yz+zWGQlb9PF6CkLGG8KgzGswyFkcJka5dQcK/1Mv5i57Xk9JN
         BgKQcyk+dHwqO8oemei/bdiGnjiCrVO0TMRUJBzzuaJUzcLBAUsdWDT//2KZ/nuPVIco
         GYYA==
X-Forwarded-Encrypted: i=1; AJvYcCXLZ2pivs8A5j5M7PYCk4X6p3424ahtHQdkz3F12x8+NIWUEALXl3iM6FqyMAvFqSbnJMbe2YMgCei350T7CNSFLXmggrJ4ntgTNsg1
X-Gm-Message-State: AOJu0YwEENCpp9nq0OGm230agoaQB/uvFJDTfjbBkY80gOccVAVkA3Ef
	qflU/FTuCExINGolIAEdQK1zl9BALyNSVrA2V/nYTwST38TGRxtruFFo3HG3zaotonbBIC4rewV
	hUzipTFwLJd25/feZyRRrCw8UsxNk3dAdRRoBq7YPwA64Nso0vDGF3u4=
X-Google-Smtp-Source: AGHT+IEX/F7ZtpCFLO4ThYuQZS+BOEHi2U5k2Md1A9RghmTmV6aM34FgEFGuNcusrs6c/JtjclAJUB/rcyhvscmnxhPXHbX+0fZI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8606:b0:4b7:ca39:5869 with SMTP id
 8926c6da1cb9f-4ca5e186a43mr76912173.6.1723116243442; Thu, 08 Aug 2024
 04:24:03 -0700 (PDT)
Date: Thu, 08 Aug 2024 04:24:03 -0700
In-Reply-To: <tencent_1E27F746D652D8C64C49BE6EDBAEEF4CA506@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000098ee15061f2a43aa@google.com>
Subject: Re: [syzbot] [v9fs?] WARNING in v9fs_begin_writeback
From: syzbot <syzbot+0b74d367d6e80661d6df@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

fs/9p/vfs_file.c:99:1: error: control reaches end of non-void function [-Werror=return-type]


Tested on:

commit:         c0ecd638 Merge tag 'pci-v6.11-fixes-1' of git://git.ke..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=8da8b059e43c5370
dashboard link: https://syzkaller.appspot.com/bug?extid=0b74d367d6e80661d6df
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12be496d980000


