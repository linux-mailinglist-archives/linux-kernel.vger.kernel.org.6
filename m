Return-Path: <linux-kernel+bounces-257472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D948A937A84
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 18:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1724C1C212FE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 16:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4A0146000;
	Fri, 19 Jul 2024 16:11:23 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1902C145B3F
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 16:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721405483; cv=none; b=tYF5R5RxIhWwMNy2BbbFKxjLe8RH4i4xtzbi5riPEM46A8S+D52Nv+syOIPMMtzt6ECLnPVWV/PyDidvkByolQerlgKFZmJqwc28pQBcmqnkMa+xjdO6ddZkapX3Kg9mndEid+h/cAvKUhzzacktS9gzAfGgqfO9vLkPlCHTEeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721405483; c=relaxed/simple;
	bh=dfBRawcr2glCEAMpyVpqh9p8zTcVwCn3sIfnaGnucac=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=UhNQWvHJUwkhQj3XAz/Is+4TYyHtU9rgjdHEmlOmYc0+hgxE/wePQQ5Id2bwiiqorN/dA8eHj71gC51u8Z+oUTrH4seANt8IuBhs5UeDJT3q/UjCWS1RaEZ25WzQ1U+Wa3t6o3HqXTTAgqXbjUYbozxnVqsThJt/fFiBl4cTA5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-398a01542e2so3091445ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 09:11:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721405481; x=1722010281;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dfBRawcr2glCEAMpyVpqh9p8zTcVwCn3sIfnaGnucac=;
        b=WSAZwFYz+BzUlqi6ktPNFZIU1g0cnMZb3sJqFsLvZldcXZIdhYTELEi60FHl/eWIPD
         C2TyU5HGdh5AuOlUdEG3/LeB9ukrlKLSAJ08xw1Ub9A9DzsuFYf7onct21W/ZclSKIMu
         UI7WttrohKJq/kUMnr6Tw8qiOJgXVMsu4z8bWgPwmn72LOjEozi9WxahAtzprElHU98v
         cTJNvQ2/DOXE12dcFL+6BVFRiN1h+ZbjM7WWtytzKA9dwtOJrq1ntkTo7AVdNf6q/nOk
         ByqbUYodnwihQQ8Q7Zd5ZJBAbEHw78oWAIQ3js5kLrtI8yvWJHK+ORiq4stiEZtXfB4H
         jWNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDSZCTlQdvySko4DOt5P9mDE3eaRwE5L+EUyTq7ph97qUiYUSPOPLTfusX5fpI16+fZCpmRXZEgmbePXifFhCDUp7qExglK54OYV1z
X-Gm-Message-State: AOJu0YwU7cSPp71ms8tsJM4QEb5WrePm7HHWFXb4Pz+R+Lkm2FhZoU0S
	uy6hgho7fquun/GPSD0VX8rEHuLtN1EUMHXYJdg7IVRE+KepPHW5uy0Mvr6NsetCidMVB7k9c6c
	/RrRkUith6BR0rGH4IkF+OVRlTna+DdgfyFhT+ny9nr68SaMHbdNhx28=
X-Google-Smtp-Source: AGHT+IGwYEixT6BqLiqvXjDMmTb7wMIy8BxZg/e6BjxjsZvp4vjzgKHeMXVEmyfHcDZgmx/TbUuz41yngryBR7KS+9ouYqk3j5TI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c28:b0:398:36c0:796e with SMTP id
 e9e14a558f8ab-398e4601721mr164315ab.1.1721405481153; Fri, 19 Jul 2024
 09:11:21 -0700 (PDT)
Date: Fri, 19 Jul 2024 09:11:21 -0700
In-Reply-To: <0000000000006fd14305f00bdc84@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000038105d061d9bf215@google.com>
Subject: Re: [syzbot] kernel BUG in ext4_do_writepages
From: syzbot <syzbot+d1da16f03614058fdc48@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, jack@suse.cz, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

This bug is marked as fixed by commit:
ext4: fix race condition between buffer write and page_mkwrite

But I can't find it in the tested trees[1] for more than 90 days.
Is it a correct commit? Please update it by replying:

#syz fix: exact-commit-title

Until then the bug is still considered open and new crashes with
the same signature are ignored.

Kernel: Linux
Dashboard link: https://syzkaller.appspot.com/bug?extid=d1da16f03614058fdc48

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

