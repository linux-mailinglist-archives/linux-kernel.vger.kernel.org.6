Return-Path: <linux-kernel+bounces-310218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D38D967671
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 14:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 348191C21559
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 12:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56CB17A583;
	Sun,  1 Sep 2024 12:34:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CBE14C584
	for <linux-kernel@vger.kernel.org>; Sun,  1 Sep 2024 12:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725194045; cv=none; b=TU1Sih8ZiqZdBEoNEZHusyqPwiqanbclv5NbdQzxj4oOCONBhASWDj2jze7/Ie+KDazHIsUOb6eOyN0+PasDocM2sMA1Et7doq2XrK/50V0e/fDXcJ1QNxwFjR980F/snOuJ343cxc0KWiVE402umvSnZUIOmg0Z125XU1vh2Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725194045; c=relaxed/simple;
	bh=CUJxDY4vmJAEJqKS6S5TN8fIMXnins6MR89/cBuKf5A=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=QSB9aih0zuZuOOuzoSwanPGyXe5l7jjTuzTJOAoAUR5u1gpcffcnlW7hCoBA/b34W9QU9sfO83sw9qF2Gmyo+zVBDEyqGWpShUwkN0I5JieOmLAJSwEnwXzc/ZXiKC3Yz+1PEWBlNmaXDtfaQ+45Famzkwwb1ZDC17DKJzwR99A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-82a1c81b736so371233239f.1
        for <linux-kernel@vger.kernel.org>; Sun, 01 Sep 2024 05:34:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725194043; x=1725798843;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VW7ap+EQYIq3PDTTReUgdcQQbZo1rtiFoKurLifu6B4=;
        b=YNoDqcHp627ySJVMNlJ5ukZedYmhL+VxNr/TJfpxtTwXAKn5m5HCyEuw/fZnzdzKW8
         nUn1baoAjazcznqptoUTk6Hcll6fwENl8PFAmZZseLrwv4J+o9lqEDr8X34KeviMKjWk
         kKISowdKzjF4vvSCqr5w+wGlJVZ1ikAKis6HreYeKt2U2RhyBQsgiML6V57CdR9kzzqc
         MdwifaLh5SQbon06UnQFW92sqSK7BJrIbaXDnZv8uXCNM8CTc/nKZc1NxJp7IztzVMHe
         fX2jAd6fu9SVDLJFJcuJ5cU4yMKo/rAW+ad0yvLec28Y5atvxZWnApkG/qm6l5a9RUjR
         hPFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXU373do6RwfwqPU2uYvOee3cLctu2yDKOjnLYUnTM+2VLwLZ0omHaCgwJ5NfQ/pNvZj6q0dv5PZB2ygHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkNSGET/KuRg/wcZBMq7tqMIvJ6rEM0oni5YMGwJE2d+n9rPAp
	hnzDrFsSU7n10dT9cNK6Lt2+RpNUOJvyEkLs1mq+Bmif2I87pq/g7P4+DwozlNqTmUZstmLBTBK
	amZlp9Em+f3ykymDDRW//OEOgYojtP+nRBBU0AH3wsmgh7mDalJ6jy+g=
X-Google-Smtp-Source: AGHT+IGhn0gJE/LtqBPSue2jbVawIErocTYS+T6i9Td6ddXhgfdqdIGSiKhau5wwKSr99H0biFbMarPHK3i6WljiNPEXWxneMD2a
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:14c2:b0:807:c095:9d39 with SMTP id
 ca18e2360f4ac-82a2611ad50mr67640739f.0.1725194042871; Sun, 01 Sep 2024
 05:34:02 -0700 (PDT)
Date: Sun, 01 Sep 2024 05:34:02 -0700
In-Reply-To: <tencent_27C9A8AECAEEFD8C8FA7E286C892D0865106@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000018212a06210e0a75@google.com>
Subject: Re: [syzbot] [ext4?] kernel BUG in ext4_inline_data_truncate
From: syzbot <syzbot+8aa6090cbe3c97dc9565@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, eadavis@qq.com, jack@suse.cz, 
	libaokun1@huawei.com, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ritesh.list@gmail.com, 
	syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+8aa6090cbe3c97dc9565@syzkaller.appspotmail.com
Tested-by: syzbot+8aa6090cbe3c97dc9565@syzkaller.appspotmail.com

Tested on:

commit:         431c1646 Linux 6.11-rc6
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15146cfb980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=94f4a91e4d2a2d49
dashboard link: https://syzkaller.appspot.com/bug?extid=8aa6090cbe3c97dc9565
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17cfab47980000

Note: testing is done by a robot and is best-effort only.

