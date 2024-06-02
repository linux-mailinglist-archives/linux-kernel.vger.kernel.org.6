Return-Path: <linux-kernel+bounces-198324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 018928D76BF
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 17:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B26F1C20934
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 15:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3DA34D5A5;
	Sun,  2 Jun 2024 15:30:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066171EF01
	for <linux-kernel@vger.kernel.org>; Sun,  2 Jun 2024 15:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717342205; cv=none; b=OhkVwm06x1tNgnY/fTsFHU1/L+n9wF4hkV/zuQcPvb1bUFA99ghH/XUDowLPlqbhkeXLr68UoNjj/qIuPx3cb7GxN18d7Wd/CGbg2DON3NSVLQQ5EL2FhS5YPdLvOtEOKIlhbeQ3bclj6TRf8jn7q0qXqhEBUzMeJkbizZb7E6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717342205; c=relaxed/simple;
	bh=bOm9gWls7u3Ju5r4S+P0rlGua90hTb86K2Nx7PDj0PI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=q+qs0v1hQtI7CnMPEern/jYIoHu9b6Gvqj+bj1cwatyrlj6uf1Ym1LFlPwgzitmkS5Sd1p/oRRpWu5jH73tXSdPTcbnRqMMg1gm2WrV18QhmrlBDkTFfLkVOoD3akXlbRRyxE2ZKk4tqwGWOZzmmbeyn+E2DobiiDysuo2xG8jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-37497a1aff0so8187905ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2024 08:30:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717342203; x=1717947003;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WOcPbj2g/KS87dFDOfGs2GB8jKiVY1KgyNHsqEeYjUo=;
        b=WT8kzRwOyf1SefrNqN5MY6+JOGfa2w/WEOCECmjNLBG1bg44vWpvaIg6ZE3SVdqgoM
         +bLBr/8Jq/SuLXZ2kz+ARIVq6LP1znhmUZUWeuJ60zfA5urXb6oR6wZjE0LUv+UY30vt
         wH67iHjPETmlZDPWgj8c4B6ePm4T/j8iiMmrk3sTOU4OJa1bKrMF7ZbXeJPR6CQpampe
         8rze5ihgKtAyd+VvRZ8TGFj8aAlUbfch7QoJTZyrt2uaM3QaOeQ2Cj4wqxI/PncPdHpS
         0SXhhU3TJyDP02D7Wf4EMdnwOKVPZOxXNncuAlqyHfzr3eLoM7hI0ND9xJhgI3+ygcVQ
         /E0g==
X-Forwarded-Encrypted: i=1; AJvYcCVA/4ODj+fbbHjPpz/rXrYLXgScs6CgeY4Jhbki4LuJBWO+vLv20+D4+SJ+fDmHyvn3TAVINtM7hk8cr6P+djyJ7WcpY4kyR/N4Ue1Z
X-Gm-Message-State: AOJu0YzUPq25CpOJKp3UC7PNdmy0zjn9w1GC+dbJ7kzj6+pVTOqnoTGq
	jP1CCmuIiz//g2YUh3g7o/lBRwHBFyhcC5XBRuPuT8+1ZrPoW9hGtN+YTTjZmRL0uF+PuKf7C7m
	yVNTuk0i2r47XaEMMfnAtTXXuDq25LqoVCvJq+4/UlNtFgQTxgoh5vnU=
X-Google-Smtp-Source: AGHT+IGNFH7WpmuoUYSt/vcWg8NsJsKafOrSf7a1UACgOj50zR9yRqd2W1/qedHtJ+vKZZZEe4RSkLMEFw7wLpooTeo7dpAzNEBM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d9d:b0:374:9c67:1dea with SMTP id
 e9e14a558f8ab-3749c6721a2mr1304405ab.5.1717342203107; Sun, 02 Jun 2024
 08:30:03 -0700 (PDT)
Date: Sun, 02 Jun 2024 08:30:03 -0700
In-Reply-To: <e2e23c33-b318-472b-a9af-3ed787149b2d@kernel.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f971fe0619e9e3f3@google.com>
Subject: Re: [syzbot] [f2fs?] kernel BUG in f2fs_write_inline_data
From: syzbot <syzbot+848062ba19c8782ca5c8@syzkaller.appspotmail.com>
To: chao@kernel.org, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+848062ba19c8782ca5c8@syzkaller.appspotmail.com

Tested on:

commit:         9c84cdc8 f2fs: fix return value of f2fs_convert_inline..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git wip
console output: https://syzkaller.appspot.com/x/log.txt?x=15e10032980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=48a63c58ee55467e
dashboard link: https://syzkaller.appspot.com/bug?extid=848062ba19c8782ca5c8
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

