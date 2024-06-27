Return-Path: <linux-kernel+bounces-232328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D8591A6DF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 14:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30D34B26ECD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 12:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CBDF17839F;
	Thu, 27 Jun 2024 12:49:06 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC991779A5
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 12:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719492546; cv=none; b=do9CibFTceeGvrFy5c8LyKhe2i7nAvIfKrRTvJyvc6EgthBbE12M6086OMCgdeENrFeVqzQ67O6Ax35zd5G92Mj/vSJXzDs56hFFeqgo+dUZqZalNjYm4KPzT7uDLJJBKGE7U7Shfxmc1Q+dLebMAA03vdVb8aeSR4m8rY+k1zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719492546; c=relaxed/simple;
	bh=i4UPPcwMGROM81wPxc1K6PjYB0JATb2oBfQE6iVn28c=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ug6zDwiRpXNq+oT4aq8Hn8J98saVfDbuLeiw4VJblJIwTHi7q0O3NvlIyv+gCWShqHcg8hhmPitPc5K/KENDxp89QJ+5KPaGZ6dUshM1848Lwcv+lA6NS5FeJo2JNX9NfxyPp7WuNXynf+vZLXMAH2O1jrG5vyFRyi61y5Mi/TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7eb01189491so1088792839f.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 05:49:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719492544; x=1720097344;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2+t+2dktM8QICbDT0n8yNuhGnlGjJkxDoRqjoWU76xQ=;
        b=YuxxSI9qcm5ouP5F20D+DbA4V4OkJsX4DLuYQjnDEPY0F/sUuxGR/vXclaP9qRbR/h
         BRUvwj9KqXvT0E3rRNHSy3wyzB5kqPOtc6cP5Mckr6och9x38uLojqbpn6mRXDS/u5ZO
         abK7JioyahESImmySi/zm0TbBSBN4egXsbYdJ0wqev7EqXirtGa2Vfb2x/mnEgheZXIo
         1/o5zNY6fvjbeJmirHaumuNMYQGfZzo+zxK+KBrWzk+gJV9N6EMURKAwT0qqWf/V1Nuq
         WkYP/GJmvzqLsx0MxJ5o/Z0X17qvzsPeaqShb1O3bYd/iEmm/4b7O8X3+uNFLfNHVYRO
         Qr8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWtaWkXFc9LH/MRXgWUakNo4M4ZXgeuI9EJmqLOtk1cEdl/+Y62nISydcE5PgYgr8Mv0/Cz1wxq/2s+tj4hpGsw8pLQlMu0FOP7wrVp
X-Gm-Message-State: AOJu0YzoBbPXmgYOsw0syspCq2T/5CspwVgecvA6mUBct1tCOqzAwD1p
	XiQgDhSM4RkhpxTRx5YEnB27FThPdBtj5vNth3L1wV79SYdScbM1YsDzVSPzoU6brXMGqcSHZ1J
	3TsgE7EebA/Rhx38zEUmDQWlkHEfJag3UvVF7UIMRfDKQJg2Ioq/mUL4=
X-Google-Smtp-Source: AGHT+IEttkXdDYXLnD7gJKjvnTm5Vt0felOepe5s4wxfxRsxp+HVDJyKzyajFjSZ1Gvtcr1W7JZ6S4S+agnLZnuWczByXNQUYmDN
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:d702:0:b0:37a:330c:1979 with SMTP id
 e9e14a558f8ab-37a330c1c32mr287555ab.5.1719492543859; Thu, 27 Jun 2024
 05:49:03 -0700 (PDT)
Date: Thu, 27 Jun 2024 05:49:03 -0700
In-Reply-To: <tencent_C7923A5DABDDB2191E4F830DC6A58B8DEB07@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000455cc6061bde8e52@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Write in l2tp_session_delete
From: syzbot <syzbot+c041b4ce3a6dfd1e63e2@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

kernel clean failed: failed to run ["make" "-j" "64" "ARCH=x86_64" "distclean"]: exit status 2
Makefile:83: *** Cannot find a vmlinux for VMLINUX_BTF at any of "  ../../vmlinux /sys/kernel/btf/vmlinux /boot/vmlinux-5.9.0-0.bpo.5-cloud-amd64".  Stop.
make[2]: *** [Makefile:192: sched_ext_clean] Error 2
make[1]: *** [/syzkaller/jobs-2/linux/kernel/Makefile:1361: sched_ext] Error 2
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:240: __sub-make] Error 2



Tested on:

commit:         f76698bd Add linux-next specific files for 20240621
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=e78fc116033e0ab7
dashboard link: https://syzkaller.appspot.com/bug?extid=c041b4ce3a6dfd1e63e2
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=175c26c1980000


