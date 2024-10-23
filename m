Return-Path: <linux-kernel+bounces-377883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC7A9AC80F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 12:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E68E41C21714
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 10:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2397619EEBF;
	Wed, 23 Oct 2024 10:38:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4151CA84
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 10:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729679884; cv=none; b=i0+uQrw6Cfpnm2u715EEJ5YZ+it+TanENv9Ztt66uzR/Rurs8U2ye+QjOpCSJ4zQPNd65hYe4QQPxbFzC0H9t8dF7SdRm+V0BkbaAO5XiiElwwsiPXlrZW4/TL+qy+AKTtynGtoAQcAtXe+CaLi4eAwinwdIEMSchrLsmbmuGbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729679884; c=relaxed/simple;
	bh=B+XcJb192v3YuuEOjMSBRFCQwKVSTU3vduPXMg9Vc1w=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=HlUb6u8df9W62Cnjm+jDcxqSpEZfTBYWKjEkdxsQRDt4ae/674p0WGgm+JV+dHFI3vVV2fZqopURIqkSSUrMFE4RrhARW/K1zmuQ/Jthrnlw7a9+XYf/IqetXb8wbznwNIN45uep4qnApOlQtsZwt8FVYTZMWYtdsNhEM7cq9Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a4d630bac7so5533935ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 03:38:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729679882; x=1730284682;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2M3PamQVhDSSmu15zLfa+CxeRn6M6aMFstsqsRrvm04=;
        b=w/PMUgOngDar0QgTprLm97hPSq65c44uNLjAEyOu5Aw7WySRhBaOPZC/rpZgHw5fe5
         RGwlcag8SQa5KOezKAHVAWN2Qf6N0/Gs6/Zhsy9FNroXZOVfJ1S+WgLI+RalC/GucKsf
         REOy1yJjkbqiXMldvCjkB/3mD3UeoZUZTLb6GzPpwJ5rU5RdxV3RDEvNe60P5JjJKizu
         XbYUn/jtzKm1aWXixncRvo70dQYAYe2yJsDNL2aBeB4u7WKKBQeqm7/cOzbrt9OS87ca
         PHUoByijwy9yQUF1DObr6zWRP+6Xit4q/yoJ5uC9VpW1PFc2524iVhDub3Y659QMRwJ3
         nWaA==
X-Forwarded-Encrypted: i=1; AJvYcCV9B/EhB3O2qnwwzhT3c+HhQX7CK1cjs+QtaZ1Fo+Ho0Nx6u9vnpfhxhGulVySHwcs6+WWpyoyXWLPldmk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEk+CUSf+21PIIGthnQngCg28bP+mFBewhOfX04egw+M3S6CvM
	1vGA55FGPlzqIeYNgpNcEBQoqo50fl25e2mjg/gLPsbVGaKvy94o2KIPAb73aSFyD761R9lElVl
	oJzda4SIXlGH79y+6+2NQ0LS8Y2oDPPtjZ7e1AJEZRe/wmVeQq9OJ2fQ=
X-Google-Smtp-Source: AGHT+IE6djL6DgXnByaa7OhcYwZ+Nr90QTr+qqwAzoFqSWCwJ8rHLqiEibK3josx02bKKh6yachf0z5VvRSQWUDgmTALM7wO7yYg
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c44:b0:3a3:4164:eec9 with SMTP id
 e9e14a558f8ab-3a4d598caa9mr22195265ab.14.1729679882471; Wed, 23 Oct 2024
 03:38:02 -0700 (PDT)
Date: Wed, 23 Oct 2024 03:38:02 -0700
In-Reply-To: <tencent_A7941CEA22EDEACFC87A5A6C242D5D6E780A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6718d20a.050a0220.1e4b4d.0086.GAE@google.com>
Subject: Re: [syzbot] [btrfs?] general protection fault in btrfs_lookup_csums_bitmap
From: syzbot <syzbot+5d2b33d7835870519b5f@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+5d2b33d7835870519b5f@syzkaller.appspotmail.com
Tested-by: syzbot+5d2b33d7835870519b5f@syzkaller.appspotmail.com

Tested on:

commit:         c2ee9f59 KVM: selftests: Fix build on on non-x86 archi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1278c287980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fc6f8ce8c5369043
dashboard link: https://syzkaller.appspot.com/bug?extid=5d2b33d7835870519b5f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12356640580000

Note: testing is done by a robot and is best-effort only.

