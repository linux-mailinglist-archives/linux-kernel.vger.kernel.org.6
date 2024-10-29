Return-Path: <linux-kernel+bounces-386957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1719B4A2B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 13:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D932A1F2352B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 12:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6ED20494C;
	Tue, 29 Oct 2024 12:52:06 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33485621
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 12:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730206326; cv=none; b=dOzu2x5bEJwNqN7/GKkGMr6moytzf38ns0bTzubhlJHKMBVbv0NGslh4KB0o4eURPgwJ1mnxA5i4+zOzJYzpYc5Tvv9lOib9W4gUF+7zEt35ibMg4FT2GaBMhFhEiwoWzwSO9cDgr9YWEscvgV0jrE86TG83cKZc+RO8VJvOA48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730206326; c=relaxed/simple;
	bh=caOJf6mpgtFGvGhsHDikQsnjWCOLTDJBunHgp11pfXI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ISlDv6WI6Qh9T9an2Fc/HxHVCnxM08VdxmJXpX//kp/M4/ccFi4tdti82ltRIs3LETWfc6F9In+wUaCGgQ9+0UYvi7BpTCq8K3PyhDtsc7xLxJhd8jsHqZF0Su4XmW+kcVwlYwJINslwuKGruXQvEzBeL82TjU97RS5H0VZRW/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a3b506c87cso51360625ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 05:52:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730206323; x=1730811123;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5yPiuVvBQ8fqcNSnI8mLFFSAlhog3T2DwpnxWA7huOk=;
        b=jMA1YdM/mSV++HNSi03MP1CtZiusrSuEYLSf+MWo0WhAEBMAO7a58GOe0H2sPhCCxF
         cd2/HEmMXng9bZDyg7SMg7Uij9t56zohZ5uTJ/0CHhJwaB+PVZR+BwJEmdOJH7RI9haI
         aMqv4b2PDWuckmyTWBdnRTtB4/g+6UtSPxah+ntYyAQb4L7PIrri/K3JovK2HZRycCJQ
         qmXgGElnTmxqC+T7uH/gfAXzCHQQkQRR7eJ0Gi2ki+v4LHEW0lPvjmIcgWyoqeGtkzDK
         kXD3VXEuSbCfLHjuykgCUEOJnwtlVdIq+tM/BSZmbe49n9x/lmfTtAbdvVOxFl4M2vvi
         4wCA==
X-Forwarded-Encrypted: i=1; AJvYcCVuwLLKAXf8dXeYwzVC80o+pP4crOerbpV85U52nBJ85X0XrT6aK7R2S22AYWFny7EorPVtNuGNFlYiKNc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxutizdbwGtsNBOCL9aTbeErfI8Mo/TyXe2C/ItY8VRHdaYI1S1
	Y+VTzJY9Ll/Ibz9E+7C7kIe7b8VJqdoYVRBBzNUir7LwG3+IRu96oCobGu6RFijbUt9BbbPLxum
	YIJxC3efBDxVS+1sdFc59nRnhW+zWunl75EO2igfcCCM5u937Biu93cQ=
X-Google-Smtp-Source: AGHT+IEXNy6rCTS+Iz8YvNDrAhVZwpERcxjMOiv9ebNIjOspbi+wq9JgNzscK9sn5x9ZT7sWXIRSEQyxOMkjeae5/ZVYYzqY8Uvi
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20c5:b0:3a4:e865:b5ef with SMTP id
 e9e14a558f8ab-3a4ed2f6d0fmr107941235ab.20.1730206323361; Tue, 29 Oct 2024
 05:52:03 -0700 (PDT)
Date: Tue, 29 Oct 2024 05:52:03 -0700
In-Reply-To: <20241029121505.7nTrE%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6720da73.050a0220.11b624.04c1.GAE@google.com>
Subject: Re: [syzbot] [ocfs2?] KMSAN: uninit-value in ocfs2_file_read_iter
From: syzbot <syzbot+a73e253cca4f0230a5a5@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+a73e253cca4f0230a5a5@syzkaller.appspotmail.com
Tested-by: syzbot+a73e253cca4f0230a5a5@syzkaller.appspotmail.com

Tested on:

commit:         e42b1a9a Merge tag 'spi-fix-v6.12-rc5' of git://git.ke..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=14abc687980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8c11ea7cf15419ce
dashboard link: https://syzkaller.appspot.com/bug?extid=a73e253cca4f0230a5a5
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=102e4a30580000

Note: testing is done by a robot and is best-effort only.

