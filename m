Return-Path: <linux-kernel+bounces-290714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E94AC9557C5
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 14:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A46B6282DF0
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 12:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5580814AD1A;
	Sat, 17 Aug 2024 12:23:05 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825077DA97
	for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 12:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723897384; cv=none; b=c8M+6Rf/VrNHB61sFk6B+4NTVqStwKM1c3pHk57PArRp5EzlqnX8dThC3z84DekAi/zNeME3+g79wpwCylVl1Jc0gJIF6B2330sGVlob1Jl+5VDsDZYgldYs4P3uW16fTtH1Q2qYH/oozerHB2Sto/xmIqjHyZVJtBpxxGruH3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723897384; c=relaxed/simple;
	bh=M2JFaKTsiuHqZmMXyQO+i3zGAsyICPaFJix/PeOLh9c=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=dXMtGuLrf7qrfO1kwYLpSlRx/HZnkxYQi5RClurMdEbCAiKK4PHwgQt3H7CC0ptDbOuWCJon/pqfJG8jqzlkZpLZ2KLJRcH78Kp8T3RFgrDpKl3Fm+BdU4LQhGokqfhje1ClyPiw4DrN2bseg6fTRf9huVQ/MmOWcOcujv5EEnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-824cad19812so268362739f.1
        for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 05:23:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723897382; x=1724502182;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3DxxM8VsWF7N/zIg41gFFo5G05CE9L5PQpWvUmkqFMo=;
        b=VeItp0G7k1W0IyaHt1t7H/fWcdFSkpWhZ7shZ9vuwpsEcCTuSnZZYaQ4PCTkyo3C6P
         9ZR1eFtlut4RDMphsjP0+VcONqKGyty7x/ilr7TSymk7UoUv1idcq3YNXwNyVDdlzyon
         lnhk4tm58W7xTiri5VkRaz0y86bMgSuTAd5aOK3kJUEUdswdY20PS88JwlXGQ+HBz/vS
         U77vdntuXKjcdZaT6KMTkw0enhQjvc49c3zb7HYbEGQ0S3m21Bkrracq8m6brDJ8vxqj
         RFt8sxKQFOD4VUCR8X1kOl9q/bGVWjRtk4aUGD/lGKelcm2eVQ6T8RYk0BVzxjTsgNNf
         NMPA==
X-Forwarded-Encrypted: i=1; AJvYcCUprQHMaixfvMEGg3wxQCZjkXYIrqUMOBAKPCVmnPN0mSBf/FDJoCmVt9Z0V5brCnTSUMY5ZbFPJn1NbvvtCvcViqVdgNmC2lyQNnM3
X-Gm-Message-State: AOJu0YyytUmm36oAU2S1TEt3X5mFj/o/zeIRk38ZunepqZ9FKYaSxHti
	Cee8J6RqrUb+SX6nfX1RwVEog4yjWHNr0WpEom8ZIhHSdD5c+fX/XV62WeXyEY/evt2cO8zw4Pq
	kmSAW/DHOq6j2rMj7+SJJxdr3v29GameigXCNabVmbzkgltPHQaMDI+U=
X-Google-Smtp-Source: AGHT+IEcG0BUYiKTlsLqCF8vEug/sD1qmrmr7quqUMp6NccU6cDrvA34aiQNGEz2We1eoMBA8RaozHnQWyCHarNI5Olj2OKD+TSo
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8903:b0:4b9:26f5:3632 with SMTP id
 8926c6da1cb9f-4cce1735129mr270545173.6.1723897382496; Sat, 17 Aug 2024
 05:23:02 -0700 (PDT)
Date: Sat, 17 Aug 2024 05:23:02 -0700
In-Reply-To: <20240817115756.672-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001cfaf3061fe023ce@google.com>
Subject: Re: [syzbot] [cgroups?] possible deadlock in task_rq_lock
From: syzbot <syzbot+ca14b36a46a8c541b509@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+ca14b36a46a8c541b509@syzkaller.appspotmail.com
Tested-by: syzbot+ca14b36a46a8c541b509@syzkaller.appspotmail.com

Tested on:

commit:         367b5c3d Add linux-next specific files for 20240816
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=16b7edf5980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=61ba6f3b22ee5467
dashboard link: https://syzkaller.appspot.com/bug?extid=ca14b36a46a8c541b509
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16eaba05980000

Note: testing is done by a robot and is best-effort only.

