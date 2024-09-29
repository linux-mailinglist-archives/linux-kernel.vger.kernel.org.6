Return-Path: <linux-kernel+bounces-343007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0AF19895CE
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 16:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A666B22F12
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 14:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8281F17BB25;
	Sun, 29 Sep 2024 14:00:08 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C503A17BB07
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 14:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727618408; cv=none; b=kG50tUlA9lMz1xm60suyQBoMtHgW26BwuACpf4WJEmb/8j8zdqfVcqaOB2a06pV05j/WBuN6/jPA747dzZn7owoblJ9URtpBSO0PRRhkryUm7eiUbIxbb8W+Kvbx/2uBNNd/el+n4vDwBXScY4rkqHEmzbbPSvoCHyint3GjAcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727618408; c=relaxed/simple;
	bh=v7G37nVCbj33ZPCz1gL+Bg1IqUXCxPYalJwdlPEeWwM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=WodVLAxCDc2nbvUK5F/dUF5TfGOHn7hMuBUEzKOgufHa7uaylrfyulBMTQacYqOyID6ECGeLuzCdDCHZYL48O8msu49549awr+DnUOnkgoDMw8LkN7THw9SBr4rWWw3Y+ANHXatZKW8a1ldu68VlfN7aYPXfVouzDXrc7Kweqd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a1e69f6f51so33986235ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 07:00:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727618406; x=1728223206;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rSs0pOvSrSfzq5iItQMe8kd6oB3Qd98bINCZfasYKWI=;
        b=UV7tPzqwXrmLadIKr4aoyzkej6+Vi/zk1Bm9vUH0rEZEaaUSzlRg2Y4hPmlYI7tAaD
         E0xGOuPmDURIJKVrzXZslDivcARhOl93vElzcstXatwaQrAnHnURecJkhHjgh2FIdyK5
         KKbYVHntEwn9hsy7W+YH/kYz6zDTX312683Ao74CwItxSQLpz+b00f1PgcyX4NBDel5C
         wxIj+W6FZbTNkck2BHN4RXeikaQxJacdRMi/jHTey5i+WbS+c+fAc+V/nA2oyZ5yRkpo
         +mDiDlwrxXdBVnSQ1jWNrHpuygkg/2YDebJ1sD6Mrjld5xkDfGTrQTswUlacoUAOHhBo
         O+GQ==
X-Gm-Message-State: AOJu0YylUzorNIMSlJcW7OHfGBA9IDN3OR699MmEUwqA06nJhK2WPQ3v
	02edHSUk0WkYnZA6vvCNwt1UzWmuXYvYZ7/O+IoAMHDk/tFKRSFB/jVQuLAcxIzlpWhK/fDb5gb
	cz94FnfGr5p1vzbTiYF11yp07wesJ3Vj+eBFtAwX0x1WcBTWRsgAVV/I=
X-Google-Smtp-Source: AGHT+IHz2fdpnEwChCZNTfgZu6LNEIUi0qbAoVdLJ13AXNhvor7mvQjDLjDzQYdxgMACP4q9VXHNVoSj+w+DUtplCG+UebG7Gt8/
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aaa:b0:3a0:8f99:5e00 with SMTP id
 e9e14a558f8ab-3a345145870mr71997675ab.4.1727618404574; Sun, 29 Sep 2024
 07:00:04 -0700 (PDT)
Date: Sun, 29 Sep 2024 07:00:04 -0700
In-Reply-To: <delA5FekzdAhhRtj07A23KOexGB1wt-QIIo3VwX-wUqS1_Hbhbg-TnqJ3ZXbi9DCGKL69lVLWKC3JoKYDYSWi6l63Irphq8zQqdBFcaOsv4=@proton.me>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f95d64.050a0220.6bad9.0014.GAE@google.com>
Subject: Re: [syzbot] [bcachefs?] kernel BUG in bch2_btree_pos_to_text
From: syzbot <syzbot+cf7b2215b5d70600ec00@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, pz010001011111@proton.me, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+cf7b2215b5d70600ec00@syzkaller.appspotmail.com
Tested-by: syzbot+cf7b2215b5d70600ec00@syzkaller.appspotmail.com

Tested on:

commit:         3efc5736 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10fd7507980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a4fcb065287cdb84
dashboard link: https://syzkaller.appspot.com/bug?extid=cf7b2215b5d70600ec00
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=118d7507980000

Note: testing is done by a robot and is best-effort only.

