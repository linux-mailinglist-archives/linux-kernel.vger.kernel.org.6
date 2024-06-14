Return-Path: <linux-kernel+bounces-214309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1249082A4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 05:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4E09B22438
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 03:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B39146D71;
	Fri, 14 Jun 2024 03:47:14 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834981459E0
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 03:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718336833; cv=none; b=GTtPaPUB00LwMeGyLJ4K7wFHIKD1ezCz0/9SF5WsFORmT/Ft1RGQ2cjs+iPE8CGPHjGUguJudP2KTG9tbjm2Zmq6s1K/NWBDTiwBp3scCYjuzlUO4MomGmLKgvGOE6o9WIcH3psVx52k1m6leHf1HVFXHRG69ukx5ZunYjs3tb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718336833; c=relaxed/simple;
	bh=4rfaUAidddvblASjtkMKjWyJL/CQTzUgNAb30NvOGhU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=f5HBzAbNoZLwSgG1+hJxZMMQIbugQMxfSI1uXd1sAkQ/0IIwIY8xKevHmuG4l76+2JbiL8h5s4YgoOkTH12Nwa8iuso8wBZk+6bdV0v9tMivUxPFw3lpYJxNVCM1wdb0TSA+QSACkknKJPa/Eu6A5bb2EhRO0I3qgnyx3O+klhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-37492fe22cdso14259355ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 20:47:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718336831; x=1718941631;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4rfaUAidddvblASjtkMKjWyJL/CQTzUgNAb30NvOGhU=;
        b=TEYTZBFWiqCjNO6Rzc92uP5VSoZOW0aWa1EPRnzscgJXWGXNtyIpXQv2gUX+IGTKnC
         d9JkS1sgNhaoatDg/94F17DMLwLrxHTCrrmDzFtekXler8pL+8uguZIoIwAGH42JUHwf
         4uld/tLCiuvYd+IR2Qua+72hPd9WdFXLupKHX9KH5SAEfnyjaG1fC+G5lSxBZEJQr37w
         8uazyHFoQ9Rg9wOmlbLNv8OLhJkRRi0BQVNpBLsAi4BELq0Ch8QRtaZ89AZONfn0OwPI
         9+vXQ0lJf+nzKbu3CUvwqfrt7tOrTDG2Ob2LbcnnO9ALzdXon8fc82IMHxvHDkebJteG
         zGvw==
X-Forwarded-Encrypted: i=1; AJvYcCVOeeIXDUv5zyZq5nRYyZsy+pSTigKd2oK4Jl0juj1rv8u79h+iRA8EtJLOQ/Vg1srmwwZkO6SoPVRziLQwwEwcPd+P7GgHw9IRiRVd
X-Gm-Message-State: AOJu0Yxav9WzNNyeX4gu0vUloddsE413dyvwm0J2SORLJtI+8L4LsHjm
	BHiywjajCYLXTFkJH3pS7dMILbRKhtz4woal5Pl+eKbeF9NuCa9h4v0koPtuRNy0aOnxWdhSHcA
	nUm/KDtoFPdqxvGXR8bbpPEKPMCuJ/Mfa3Njnww0kdN2PJntDr5VaCQ8=
X-Google-Smtp-Source: AGHT+IEKxi6GNaWi+R9YfJxWIznc2xKYuKXmBGS8WoUzkTSiA5OuyEBc8xGupOmjy3zTJ3UmWO1ib4ELCthvMmcu3bKb+UmfOAZ5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a48:b0:373:8d04:28b2 with SMTP id
 e9e14a558f8ab-375e00059bemr712485ab.0.1718336831592; Thu, 13 Jun 2024
 20:47:11 -0700 (PDT)
Date: Thu, 13 Jun 2024 20:47:11 -0700
In-Reply-To: <000000000000dfd6a105f71001d7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000073ab6e061ad17840@google.com>
Subject: Re: [syzbot] kernel BUG in ext4_write_inline_data
From: syzbot <syzbot+f4582777a19ec422b517@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, eadavis@qq.com, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nogikh@google.com, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

This bug is marked as fixed by commit:
ext4: fix race condition between buffer write and page_mkwrite

But I can't find it in the tested trees[1] for more than 90 days.
Is it a correct commit? Please update it by replying:

#syz fix: exact-commit-title

Until then the bug is still considered open and new crashes with
the same signature are ignored.

Kernel: Linux
Dashboard link: https://syzkaller.appspot.com/bug?extid=f4582777a19ec422b517

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

The full list of 10 trees can be found at
https://syzkaller.appspot.com/upstream/repos

