Return-Path: <linux-kernel+bounces-553217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E45B0A585CB
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 17:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DD2816A2B7
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 16:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171121DE8B8;
	Sun,  9 Mar 2025 16:20:04 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CBB1FB3
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 16:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741537203; cv=none; b=UE2cSBHmhRjgbC5qk/tDx6KKUsKToJi0kvGxlicYHUSwKkPtTUNACUBxJJQcXXW0z+UCJEAA4hvlmR8/1FF8MaiLKRgZvW9+pLenKlq7MirOspWywTDCBMfYZN82JncUYdw7WXJqx2+PMwnvKyX0IA0DwI5svzx0dBqu3n2vgvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741537203; c=relaxed/simple;
	bh=UJv+3p818hAynouGODGqPemY4sdL2sg5sl1CQD4WCAY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=KWnbnTu0IE6EIqF39DPuaz4fbu2Z/ywQK0kNk0BGCfo6SsmdXO3fUvYA96VCaEPjgbGbUrKRBrx8BFA1N/+/7elNb+RzNoX4EwbuvFPgTwnvn3N7mn7vNTFFc/03JXAWC9q/oA/jw3GYzP4+1e5KrFdvFEjl/69M4Mj29JzNsAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-84cdae60616so285628139f.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Mar 2025 09:20:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741537201; x=1742142001;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kvHzXY7sxLiJE9tWVn3P+7dA0tfrkLHjWoYFez7ztlI=;
        b=UfYBXorZrw/MJBaFiZKHge1O3LItK2bVrmm0Z3EDXidDFh/S0bdIl1gGUuMDO5XS/7
         EemaTN63oX+rfY0nZcWB97FDUKMsuIwqdg+wHGlxI3buBPHRHplBVFyj6v8cNjoxqouX
         LfU20JUEpNOMA5Dt6f4ptHBcvNSUMt3XUrDCubO7MEwqf6hz3YbmYMYKrk7h9PIbScfJ
         2QELe7WVUSJ+LUGOnghV26fMrmRW3TWojulmgTdBVIUWWYv2CTL/XNWggoBLME0K9xM+
         lh1lAnUOkeCxvECttuny1UsehjAvLAUvLyud0yT0HOxzmQyvDXMkHfD2Zj51rL79K984
         gq1g==
X-Forwarded-Encrypted: i=1; AJvYcCXA6jbH+OG3jSepcHNi9a/PJ1Xe0ydLILhwC17ty+IID5dLjww7MRJavz+3CQdULp8xMPavcSWQuO3+7Ng=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeWfeEShkevexIvqrjqv3tz6QJxNfyaOJr/I6yRp3uvBv077ym
	+atvnO3Vy7vXoTie2qHcriNNAmvbn6cxCDo4QbBpAnnwzayHNApAUSJsWesMsW1i1hlvyFAubAN
	wS79AcOkJhgScwuy2NTd16khDC4sZ8iyF4InBXbt/+huwiGA6GvtDqLU=
X-Google-Smtp-Source: AGHT+IGzBV6/Mmw1jYJbp4k4xeAwt6EP5l8CLTLHNIXSvmWfgnNG3Eq5hlJ73B1hltOvdNhKNoHGM4Vwa3Q3wdVte9AmRIZsV4VY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:240b:b0:3d3:fbae:3978 with SMTP id
 e9e14a558f8ab-3d4418ed8e7mr107345105ab.9.1741537201441; Sun, 09 Mar 2025
 09:20:01 -0700 (PDT)
Date: Sun, 09 Mar 2025 09:20:01 -0700
In-Reply-To: <CAOQ4uxj49ndz2oJcQMhZcXTAJ+_atUULNLPzLAw-BLzEdFwV+A@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67cdbfb1.050a0220.3d01d1.0000.GAE@google.com>
Subject: Re: [syzbot] [xfs?] WARNING in fsnotify_file_area_perm
From: syzbot <syzbot+7229071b47908b19d5b7@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, amir73il@gmail.com, axboe@kernel.dk, 
	brauner@kernel.org, cem@kernel.org, chandan.babu@oracle.com, 
	djwong@kernel.org, jack@suse.cz, josef@toxicpanda.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-xfs@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+7229071b47908b19d5b7@syzkaller.appspotmail.com
Tested-by: syzbot+7229071b47908b19d5b7@syzkaller.appspotmail.com

Tested on:

commit:         b63f532f fsnotify: avoid pre-content events when fault..
git tree:       https://github.com/amir73il/linux fsnotify-mmap
console output: https://syzkaller.appspot.com/x/log.txt?x=11fd1fa0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=afb3000d0159783f
dashboard link: https://syzkaller.appspot.com/bug?extid=7229071b47908b19d5b7
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

