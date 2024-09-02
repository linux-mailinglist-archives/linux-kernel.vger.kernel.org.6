Return-Path: <linux-kernel+bounces-311029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2938968420
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 12:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8180B28105E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5A313C9DE;
	Mon,  2 Sep 2024 10:08:04 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C9013AD37
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 10:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725271684; cv=none; b=WPVliOyQSAZ2y7AJVoDyi20XzMBZAe6k/sXpIRRoJL1a5cMrXhU+Vf3ftQgcta71bzys+QDphITckaRISfol9uRQlAVgsEQUYlQqT301k7ELbcQNUGZ9x+Z8rlUnyOi2TsFst5PbyOhZDWBaG5uw8D6iGhmu01cCPh8Z6SvJ7JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725271684; c=relaxed/simple;
	bh=dz+y38FjFkmz7PztH6vb+3wA8b1++1ZfWQ9hV9dueT8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=T8zYiBaE8qkV9DwwL7cFacmJzkfQ07nftx8vj8hjZDaJuJB5DqIK2JzK+Xl4zVJ09O7/Yw6HGnVaI7g34w+NxmCuXDDvzaqVMqK1azhqooP8T4Ye3/objwpE/iUTY67ZwPDIzsj4q4SDsMVpvYKA0vrfcS6ltynhqrmu1Dvkwzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-39d505a087aso35291145ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 03:08:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725271682; x=1725876482;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S1ZI8Z1mNTH3uczMmGtu5HRADTUqD8qSIuklYf+UieE=;
        b=PgKYa0u3+GZ62fw6RCMfoP7zc/hNFEUtjt3ciLUNfeqAMqGNPO7Uohty71Jvtx/SP3
         NSslyGGHJAdUyw06SLDW5JwLcqNXM1C7UodO2/xXVSb8ZdfTfeF1dMZTeBtQaGrutLyx
         pTtcU3954Pyhx4Pv8pbuwy4xcEFEAKWonL3RB4j5eAdmaGZ4voe3n4zEPwtLF1nUJ0tV
         PfFYJtYgm+NGGRT7n5WXf/dSyBg9EroXYRtZ4IofCzV1XCGAxTlbr03isRfamZcphq0P
         9IIXGdS08y6Xn/3khuDpJvNNRR3nXAstWGlGxkpFOvScBSkeXka2lhlgm/dxU2DVBEr1
         Z5+g==
X-Forwarded-Encrypted: i=1; AJvYcCVTM/tdyIZJ+aMYWDs/BglDV8R5jpM5GZD7FikT5dPxcMRN3p+BxZrEEY0qgyl9+ylRZRQ2WhMBvqSjOJE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/wY8FU8LUOwEDEcyxJz9wyYXy4rUVRTrCKJdXPtiQfHJP/lQP
	pT+zYx1vNwNhxdOX6HPUnV06K7JPEWOIo0nQVMmW9t1Grs6y/A08qyBzIQIw1Uk55Q848lo48i5
	G0ZQIefVFzH02Rp9AgbH1wDcze3ukafOvdDmipzAZ7uNZnWi31MMNM9o=
X-Google-Smtp-Source: AGHT+IHEB10cbUaE1wUmk6yLQKuHBOE6EUNcUriJs2vNedp2BXIXZ5tEof05zrXQUZZhQ/xMGP9SpJRhKO+w73CHkYHi0zoJyeLp
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1ca4:b0:396:256a:2e01 with SMTP id
 e9e14a558f8ab-39f413707f2mr6320285ab.1.1725271682119; Mon, 02 Sep 2024
 03:08:02 -0700 (PDT)
Date: Mon, 02 Sep 2024 03:08:02 -0700
In-Reply-To: <20240902084101.138971-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c106810621201ddb@google.com>
Subject: Re: [syzbot] [nilfs?] general protection fault in nilfs_btree_insert (2)
From: syzbot <syzbot+9bff4c7b992038a7409f@syzkaller.appspotmail.com>
To: konishi.ryusuke@gmail.com, linux-kernel@vger.kernel.org, 
	linux-nilfs@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+9bff4c7b992038a7409f@syzkaller.appspotmail.com
Tested-by: syzbot+9bff4c7b992038a7409f@syzkaller.appspotmail.com

Tested on:

commit:         67784a74 Merge tag 'ata-6.11-rc7' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1752cf2b980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=94f4a91e4d2a2d49
dashboard link: https://syzkaller.appspot.com/bug?extid=9bff4c7b992038a7409f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1012cf2b980000

Note: testing is done by a robot and is best-effort only.

