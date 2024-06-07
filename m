Return-Path: <linux-kernel+bounces-205181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 588D18FF895
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 02:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6FBBB21E2F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 00:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3D0468E;
	Fri,  7 Jun 2024 00:15:23 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C19823BB
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 00:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717719323; cv=none; b=OTslPb4rPg3u3l90s0LZYFlagM5xEV5whJh0sj/YrE60Om5tV7SBfSDg4bYazqQWIODas7Xjjn7uU/955g9J3WF7ilEWq2eYv6kN0uf8CbJHMoyKvg1qYCLbduQhoFDv0IE6siUCq6yncSuLPg/6QJW81gnIm2ILQE9HN/wUN78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717719323; c=relaxed/simple;
	bh=CPKlspD/ZSfWixUM8SglUnOrdGxitKBWwWP9lEY6reA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Nq0bU6F4uck78tuPVJlI/nwyDUhGbC43pjc4yGKgdlEMK2XbVf4go8wcqLE7qWCY/2CWtUvqRirrplSH+hc8r6GZpSZRGJpjT7ecQYjVPRfDVTr/5K5po2AcPCiF/p1+iTMaXcyrScnIP06xGsHfDmImQfc/GbiFGzx6V3rCM1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7e212ee8008so154117639f.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 17:15:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717719320; x=1718324120;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CPKlspD/ZSfWixUM8SglUnOrdGxitKBWwWP9lEY6reA=;
        b=G/mK4vxe8s+N1QzunEaF4+RU/kyk1TDuos0lWkYKB+Ftvnv4JUly6cBlivjf9cdfLC
         21iFdCLI4yIvhAfaPulmhSF/LTwoUsCkVmFtJeTVC+JBLnni+WLnBXKFoI+G5sfiUCKM
         LAtwKZv/t4mGV5Gd6Y94EVcgJ0STNGTeO/uQPQfrgdG7ilULTdmvNl+LI/dAr3XK8f+Y
         wa0DwAR4/4dH6slIZJZz2dTZsd7u0HQpPEXl8Xrmz2L0okQLyQzcJJwQ40lD6gMbk71C
         fS0Y3OxozL8tM1SvniNW8OUYANuR678k3HaNqpI6Ev+HjHnfvGKT63JlteSo5scpvQaM
         p/1A==
X-Forwarded-Encrypted: i=1; AJvYcCWHYpXQRCiC1tdP+Xn0Y1RFy2QEER9iKg96/s/L3zqf/YCUaqwPcybflZrZTjm+VE+qOthZbJd9A7wJqNeFh6LAdz2Za7Jrd38/eWkp
X-Gm-Message-State: AOJu0Yx73ZpoCa7sMs8hPxSFEFN3cd7pbBgMY9FF0qRHIjihQdL1NW24
	aGgSMpmpJAv84JMbx2ZFTv65/GNZLTTPrUjUtxNPHxQKuk4rVuMQ7qL0biL4+XaUcgixmORM549
	lsE2IsEaNe7l4KAJMAoxyQI0jm31bUZb6XWdsIgk2R1DRsPfHLHc8j/Y=
X-Google-Smtp-Source: AGHT+IG5Thx0BiwdKnBqeBFBtnMlWjsuCgPzW/VGb2soX7R1sfkuz/vVj6zDBFaPEs1yVLrdiIW4qaqG5nConq5H20oCXlHKnp90
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fed:b0:373:fed2:d92b with SMTP id
 e9e14a558f8ab-3758030a0e1mr876255ab.2.1717719320681; Thu, 06 Jun 2024
 17:15:20 -0700 (PDT)
Date: Thu, 06 Jun 2024 17:15:20 -0700
In-Reply-To: <0000000000006fd14305f00bdc84@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000eeed79061a41b140@google.com>
Subject: Re: [syzbot] kernel BUG in ext4_do_writepages
From: syzbot <syzbot+d1da16f03614058fdc48@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

This bug is marked as fixed by commit:
ext4: fix race condition between buffer write and page_mkwrite

But I can't find it in the tested trees[1] for more than 90 days.
Is it a correct commit? Please update it by replying:

#syz fix: exact-commit-title

Until then the bug is still considered open and new crashes with
the same signature are ignored.

Kernel: Linux
Dashboard link: https://syzkaller.appspot.com/bug?extid=d1da16f03614058fdc48

---
[1] I expect the commit to be present in:

1. for-kernelci branch of
git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git

2. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git

3. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git

4. main branch of
git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git

The full list of 9 trees can be found at
https://syzkaller.appspot.com/upstream/repos

