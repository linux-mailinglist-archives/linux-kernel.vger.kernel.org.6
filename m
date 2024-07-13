Return-Path: <linux-kernel+bounces-251522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED089305CC
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 15:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 923E0281C2F
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 13:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D687D13667E;
	Sat, 13 Jul 2024 13:56:07 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA864C8E
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 13:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720878967; cv=none; b=RqTYiy8uDUwKqRtG8WQz1ifICdVixgZ4pvf9SyA1kN4xFivjIC/zy5vAC4jvuizvDAoSfU/bk3Bs0d3QfSNWAit9Y+5+tDIEoORTm+orJvqN6QWd+naKIV+F7/WXVgCeUu564252s8LVJHuZVVl4Z+fIe4oYw6S3+QW1DD1pfSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720878967; c=relaxed/simple;
	bh=JeGtDOcIQs4mI2WVCBl+PhQAci803C55/WwrGHdrkKM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=iN1QfUy13oXJNyxRPJ02/vB+v7RKPaRhYadZi6mNVu2c77rHn0yxXrZNDtQu41b5KVCee7kwd3WLknVXV6Q5nJECnlOgR4geulDuB6uqOgYtPpbkR2KsTUoqtza06UQAanjBLX1xV8QKr8/y6PnEY/HBqKZnOTUnAuAcLxhCahE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7f664993edbso314774639f.2
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 06:56:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720878965; x=1721483765;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A7sLVogeCnoKRts+tr4CeZJTR8epLP4Y2YGyRuNkri8=;
        b=rLl07vnNqojFYT5SHMEEmDUcQMz0TA4ZOirts1E1AY4VAsoABD1RZuSYWJip0viUiY
         5eX2lqMRynq5iQtmwOJ9wdnQ/F25CHRKFkt12q9e0rPWumKLrfFEZufsbJuD5aymp3Fb
         C3MZ/BCNT67Yx+2hSEeLwd6Io587byOA30e47/xCc/BbuGWnOlpHW+kVNN8dlSd6Pst0
         9MLK0bi7OCRFISj7vxRM1LHWAqaixYDfxcEz9OVWrlPFjLQ0LIMPuhsRn6g8xI6NATaV
         dN+PgBzvA7vPW6kmTHVlVyNlIa5PeL78dyOKSbo1CaoA7nUGRJDv6q+9iL7WOf79zeat
         Ppkw==
X-Forwarded-Encrypted: i=1; AJvYcCX9YdsUe7NusE1/8SE2aAdDJwJMtZGdD9rBrH4cizBRSd7MJhU5ZfokaphjVAiP2bGtvKaJWLVyCR48yFm5Xb/6UrvP2WEjwqJ3l7l0
X-Gm-Message-State: AOJu0YzuLdkGfi/E0/AN+zVrp8GjNVDb3td6e8tPVhYSEwnxkM361CQG
	N6zqYH6EXt3+IoFTi5Ep7ZJ7ztj23aZGo+fvFNfO5/Bjwml0Z/fUoxnIRCsHjoix9miIt5VhNck
	J8Jw1lHA57SQxWjJ7a4Xr7dbss+3q1AabBdjccjD1Ox9iuBqTwSAHlRs=
X-Google-Smtp-Source: AGHT+IHsOlZiOJg4gVfdgihkqwNltvHxgAUHBUb8jejbn9RymfZ0WG2EE5kHEGeUvygFwBlBFC4wCtTKWMA78k5aJuXPChaLGMpU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:270a:b0:4c1:b049:25f with SMTP id
 8926c6da1cb9f-4c1b0490ac3mr747958173.1.1720878965113; Sat, 13 Jul 2024
 06:56:05 -0700 (PDT)
Date: Sat, 13 Jul 2024 06:56:05 -0700
In-Reply-To: <20240713132101.1009-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006ad1d3061d215bf2@google.com>
Subject: Re: [syzbot] [kernel?] kernel BUG in binder_inc_ref_for_node
From: syzbot <syzbot+3dae065ca76952a67257@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+3dae065ca76952a67257@syzkaller.appspotmail.com

Tested on:

commit:         82d01fe6 Add linux-next specific files for 20240709
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=12f2eb6e980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=95a20e7acf357998
dashboard link: https://syzkaller.appspot.com/bug?extid=3dae065ca76952a67257
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10120b85980000

Note: testing is done by a robot and is best-effort only.

