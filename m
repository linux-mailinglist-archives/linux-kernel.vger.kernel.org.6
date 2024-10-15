Return-Path: <linux-kernel+bounces-365639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D32999E550
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 13:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58CC42844DD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 11:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0BD1E5022;
	Tue, 15 Oct 2024 11:14:07 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B281D8DE2
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 11:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728990847; cv=none; b=dWoE2oyG6FSohQJqBcU3SKH3/EEOEq4DAjg4MgRACFbAFlB1Bkh95FPDVwQv6UY0nKXOtRhWVkNLA94B72SHWicZvVU68GYV/+krkgZeu2OxAGK5uWxTQpECY16X0BxdxBjPUXXl5iBG08x8kq3UjZ32khqKnOpz6IBXoCT3mQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728990847; c=relaxed/simple;
	bh=k+obqg8ez/kSYPrpCwInoZCgoVi5lbYkCXruaWxb8/o=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=or+EzYOEYidDfr8QeiClvM0ZPG0CcLBNbGncOp4vDHiUN9c2qTxhCXowPANovaMz1pRbJj72V6ldztEtvhJ25PImPPkU3KL1V/NKGseBukuBZz03iuDnV8AzYwRZiwb2pu4Dyrf0l3mmYLtXNn9Xrx8MU21n+WQIjQotWomtEMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3c4ed972bso13697185ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 04:14:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728990845; x=1729595645;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tEhk+TpqMKJ9G+Us2Yb7tiq8D+TvLmpB6pPJUPZauiA=;
        b=crXVG1XZGaPcGAZC8Sfl8F+ECUp0BJUZMXUIFB8AIbhQxOIZePZH8DWjUmyQmnZ2C2
         bAtsPr6lRTIVt0hIoyjKjTTcV7hbn2tOG89cJOs4piuXqsDSmevHJjFIc4tk10KUvI03
         FqYExJpcbk59SvV+KWzLf/RQ1A+bQm6E1MwQjKlwfUQHmHBHJrdZY4VC1nZ4DCWcVX6h
         K8CMRsVYU1BjrN/geA6Pc9Tb+F4TfWy9Qw8XySiVhVi5OpGDftLgIFU7PPQRXETegg1A
         cadGCL3vdNVB1c4OCvAPJZr0Gr0j7jQyOlImbmyNv4MF3PYSOW0TYSNN4yvswqqjw1jQ
         pKAw==
X-Forwarded-Encrypted: i=1; AJvYcCWP8zubfDX7Nlv2Xp4Y+WmwBIehxXZclO0eVUndJYsKigdd248dA8DkNxWqOB3fUFrEEpgawqGL6K/Ydz8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS4D9fGOpSJtKXuXZHh4qSvylg4TS0Z7IsZ5QGzkm7mn/zM/Zx
	FyVlupjT0toJkY5wgGG7rNuaHPCsrbDNoaAEfyRRWWmD+8ZQXiDMtyw8RQosECe7xH620NNb5tj
	l124PJYn3xaRkAq2XHZyfJrW87of9lEaQK0cl0lMOLFPTKMUjdhWA9m8=
X-Google-Smtp-Source: AGHT+IHXesyNdgyZZeho/BS9jHfkCc9WHMifKPZ92CHfRQgwg4mrpdBO59kJHlA5JY+d8fL0SNb8noMhH7cm8xCklvgoGlliQfLC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:178b:b0:39f:36f3:1957 with SMTP id
 e9e14a558f8ab-3a3bcd9575fmr75597205ab.3.1728990844839; Tue, 15 Oct 2024
 04:14:04 -0700 (PDT)
Date: Tue, 15 Oct 2024 04:14:04 -0700
In-Reply-To: <tencent_C4C8065D09956EC9EED90C8727FC06D75206@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670e4e7c.050a0220.d9b66.0151.GAE@google.com>
Subject: Re: [syzbot] [btrfs?] KASAN: slab-use-after-free Read in add_delayed_ref
From: syzbot <syzbot+c3a3a153f0190dca5be9@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+c3a3a153f0190dca5be9@syzkaller.appspotmail.com
Tested-by: syzbot+c3a3a153f0190dca5be9@syzkaller.appspotmail.com

Tested on:

commit:         b852e1e7 Add linux-next specific files for 20241015
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=143ec030580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3cb0191818709a2b
dashboard link: https://syzkaller.appspot.com/bug?extid=c3a3a153f0190dca5be9
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16ced727980000

Note: testing is done by a robot and is best-effort only.

