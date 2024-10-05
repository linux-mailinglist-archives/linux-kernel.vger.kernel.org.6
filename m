Return-Path: <linux-kernel+bounces-351802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A26991635
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 12:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EAA71C21981
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 10:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A1D13B7AF;
	Sat,  5 Oct 2024 10:51:04 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4BD231C87
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 10:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728125463; cv=none; b=HFRod6klzfvduEfhjv2ytWU+mnTXrD0XccSC6DJRFmAY8irwIK2rAQKxUlaq9FRw8JTHjqu8UKgRrB+O+tdUp4ChcNKg+rXrzrhC3GplkvFHHz1dqK+PBTmnLfiepxAdMd+SoVCZEyMYEax2yZFWZg9mYCp9lSK2Ns6GA8/rwQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728125463; c=relaxed/simple;
	bh=NxyU9nUCsSgkON5O2lxEwFubpms7qTUo9JLUnCO7ii8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=CRTQ2Q3TWPmqCkHk/IV8kxai5fmCXkPiGefoO+WGLShpt3CPvdltBM65HEpqTBllUhPUvq2R4crNXJfpjBVtq1veLS22OQP0LxFt0l1ryJAcc0s3uzM5/iFjRTjTei+yFQuJAxEUPxnIZhxZ4Fba9A2ko7j4B9p7tVeFBrzjsGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-82aa499f938so321545239f.0
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2024 03:51:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728125461; x=1728730261;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=anhF7OilqNw/V1vwJD6fWlrrfYeQAh4r7ZAbYmfGYJc=;
        b=t+pw4KpV9Z+5V8kZhJRGmHTZC5qarFsxsYTkM6EOEn84OzMJ1cBw6MWlUQPYk/cevU
         pjQZ+xi9GvCnVy/Op0okHZQPGv29Ocjn00dKi/76Jqtgtfc7f1mmJ6H4JEZD94qFyRbi
         39NFQNiSPPctmp2dsizWOdzyGMRoDB6pLmin8mnN+xioGp9e3zAoZolGMtDEefOhZf1J
         cZGKJ4/2twKp49sFeYjp86U2damYlOvQ4kx0h+wWsM2vOEGdfBTqNecyrGTk5y7EJGVL
         h0kEjDchtReGEgVit94ePiK6cWH1Xsf0SRcw0b0Mtac1TEYsShZ9QD/N9CjRRk1+4H6H
         EK9Q==
X-Forwarded-Encrypted: i=1; AJvYcCX85YI+Dlzzeu89IEnkS8yNmdRHouYL4041tyDwFWONbZ9C4pv185fVXydyAGhN4eqoNSFt3f/3g2dxOqg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMRqA0anc06LbgIy+IuRu1f6Ck4Au+jPHELrBkAa4cewdfuQqN
	vAsRO//PBSntjkli1bemHhfcT2v145joHQK66kJoi62EvMTyYIbUxH9iYGF3kkvdKXtTiMhhVvD
	EvE9nXI5OXclFCAU9ynUTsCJS937Eyp/o3jfDZfX6QsLvtrzfX60b9FY=
X-Google-Smtp-Source: AGHT+IEvijPTYF13ZC+76LQBGvEA4RUUT6MHwfmVXAKfc9yueA8V0SRkS1R1pPXSwhWZkKMfvDI9Dpz7hoeUCmXDZd8Of01pwfEX
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:219d:b0:3a2:762b:faf0 with SMTP id
 e9e14a558f8ab-3a375ce0f15mr41351735ab.11.1728125461684; Sat, 05 Oct 2024
 03:51:01 -0700 (PDT)
Date: Sat, 05 Oct 2024 03:51:01 -0700
In-Reply-To: <6700d799.050a0220.49194.04b3.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67011a15.050a0220.49194.04bc.GAE@google.com>
Subject: Re: [syzbot] [hfs?] general protection fault in hfs_mdb_commit
From: syzbot <syzbot+5cfa9ffce7cc5744fe24@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sandeen@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit c87d1f1aa91c2e54234672c728e0e117d2bff756
Author: Eric Sandeen <sandeen@redhat.com>
Date:   Mon Sep 16 17:26:21 2024 +0000

    hfs: convert hfs to use the new mount api

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17b2bbd0580000
start commit:   c02d24a5af66 Add linux-next specific files for 20241003
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1472bbd0580000
console output: https://syzkaller.appspot.com/x/log.txt?x=1072bbd0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=94f9caf16c0af42d
dashboard link: https://syzkaller.appspot.com/bug?extid=5cfa9ffce7cc5744fe24
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=114be307980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16bef527980000

Reported-by: syzbot+5cfa9ffce7cc5744fe24@syzkaller.appspotmail.com
Fixes: c87d1f1aa91c ("hfs: convert hfs to use the new mount api")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

