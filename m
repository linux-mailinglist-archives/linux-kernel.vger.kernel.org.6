Return-Path: <linux-kernel+bounces-338160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C529985422
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 09:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42D19289B73
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 07:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE97F1684B0;
	Wed, 25 Sep 2024 07:24:04 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA08C15E5CC
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 07:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727249044; cv=none; b=gyWJGqiWEQdz9y07MWJSf4f49fzDjOC8egiLsIVkOqueJ5tnh4Joh3hQNy462wbIktXjuz+Wf+d1bh3BCADlYSp2997gp5zrFLt0GffcPy1xN0bTJ3ftp/MYvkE3zjDyTMPX32fqmOyyyWz4pL5GcBx1DEaBS+pYmavOR+C3UBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727249044; c=relaxed/simple;
	bh=cwBW1nZexvrkSpRRMNUvQRu4cEa3POxXfYqsqy+WG5U=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=F/WTj6CblaiM2kMvwu7QleL2Bl48frWkk87xuSuMy1nj/repcv3uoYwSqzaMQ8eZjuErtbYPo9d9sVo4nsX0MsW4CTl9yDdE/Qay/19hX/osITRZWgMe0Dw5jb+a7KaI0zAoMgFaO/3gjLJ9A1Itme81KLIxHq4faTMGKdfOwnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-82cd682f1d2so987796439f.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 00:24:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727249042; x=1727853842;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z/A3o4UVQs5NAn318rkcVw0SNvHvy2CSk8QVGSxPhsQ=;
        b=Qgo9UAKJTG2sVZhW3otkiPamvSZmfMSLcDxxuISuE4fwAd+cwhoQpbowZQVDcYmYY1
         GjIm0AuRwthtXH2aDemYGaXbUzgULH8eK4vMAWDTewg/oa74NQLsccPPmgLdYBpRN/Bl
         aHBuWYF/DZjL2rTAxRUWd4TwcRh7Kbz8cHmyilI+J3qwfPx7HrsqSKxaknfpLBiSOTwD
         a8qcbq5s2pKx5p+Ov+SXj9tw/8+fAelObsNOR0pmwcfTpRCUdvfQQVJk9AjAs9RjqQCo
         ss93geBNB4K6ttajGTK8hOWGr3pau1HW4Io+Fjiogr2MygxgGYuR+2sdFS4ajEVYdGNC
         +eaA==
X-Forwarded-Encrypted: i=1; AJvYcCU28G3YpwPc0FXonDd1H/HSbWggFxUwZNx60JRdvSmTqsbe0fxsv8F24rwcbyN2lHaslccZD0EIQPk4FqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmHcqhC693WOl+7kNz/ntndS9OG1UdaJdFNpNiQ4MHWQCwpJiM
	SBYKOxbZBHI4xUYi6oeCipd6HooGGXz6o5pnGJBAD+ejmcgmElyUfh9h8I3HzeOhwYK4NMWsXNl
	6mRUmHEnNIssUbxrXHX2l/OljGr9LM22BJuXXO+Y1sygUZZB10wtn1rI=
X-Google-Smtp-Source: AGHT+IEPpJLOMCaCb92K68J/cy1pD5OdA22rcpbcvYEB5cQSsPAy9r/VXZbw5kMVeJw+fKgDc5Tgm4uxiRh5RTa1mGOndjSeboQb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1566:b0:3a1:a179:bb54 with SMTP id
 e9e14a558f8ab-3a26d5e8bf2mr23514285ab.0.1727249041866; Wed, 25 Sep 2024
 00:24:01 -0700 (PDT)
Date: Wed, 25 Sep 2024 00:24:01 -0700
In-Reply-To: <000000000000dbda9806203851ba@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f3ba91.050a0220.30ac7d.0010.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] kernel BUG in vfs_get_tree
From: syzbot <syzbot+c0360e8367d6d8d04a66@syzkaller.appspotmail.com>
To: brauner@kernel.org, eadavis@qq.com, jack@suse.cz, 
	jfs-discussion@lists.sourceforge.net, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, shaggy@kernel.org, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit d97de0d017cde0d442c3d144b4f969f43064cc0f
Author: Kent Overstreet <kent.overstreet@linux.dev>
Date:   Tue Aug 13 01:31:25 2024 +0000

    bcachefs: Make bkey_fsck_err() a wrapper around fsck_err()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=147a0989980000
start commit:   2004cef11ea0 Merge tag 'sched-core-2024-09-19' of git://gi..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=167a0989980000
console output: https://syzkaller.appspot.com/x/log.txt?x=127a0989980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=38d475ce6711b8b4
dashboard link: https://syzkaller.appspot.com/bug?extid=c0360e8367d6d8d04a66
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=171f769f980000

Reported-by: syzbot+c0360e8367d6d8d04a66@syzkaller.appspotmail.com
Fixes: d97de0d017cd ("bcachefs: Make bkey_fsck_err() a wrapper around fsck_err()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

