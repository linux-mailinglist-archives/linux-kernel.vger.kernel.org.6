Return-Path: <linux-kernel+bounces-280853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD1894CFFB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 14:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32D311F220CA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 12:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F082E194080;
	Fri,  9 Aug 2024 12:19:04 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0821D19309A
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 12:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723205944; cv=none; b=qjXgHs5Flq9qb1dllJUCmOoEyb6HZpFYJO0+S98zgLugeDwXWPc+d6Vse35bo08e5z6ZVJ6hSt79seH2qoDH2d5sR7sc04eiKNLh+Zaku4aqqn5TWong3AZWt67leT/XrVbYeEENxvNjGQiwgj2su+BL/WJIjR4FBW/H1YePti8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723205944; c=relaxed/simple;
	bh=mLUq009FKgpMYsXAWUZPC2X8XlaMbQYF9bO/7JXEVkA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=CAcaPZdmAv9AskGBGG9s+p3Pts2u3ZnJ6uZyJwEMgmfpnJQ377mNBQVR7x3Y5q0SYU6d5INb6IxsfNHTHX32Uu2oS3l0WeiPHnRACHIJs4Xc7wQsRWgZCShjW+MwQIcdZ3lJdgjs2d6nPtnKt1KGp/CtZeJ1T8rMEqR3AJnNAjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-39b0bee2173so26895375ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 05:19:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723205942; x=1723810742;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2kTD/Jp8AP0PXR+VRkg/5zSd3peVQcIcVVEZtG0e1ho=;
        b=S5qyMvq7f9LXLhTM3SgJx0Nu2G3IzmPGszT8JjbdY7ky59pEItWx15Yp4iTzfrKNK2
         iZpMvU4xhtqUVCMhy2vcrRU6+AodJOt2tqojr12QHMyPxQMWVHM0EzbmdilDJX6w63Mc
         VInmhW8yoZwPSA3r4/PCNKrOUIzeTZp8L9F861s9Xg5TaZk4oHwyV1ukJu9BVyYvrFud
         d5H5vQkEoXcsTP5XyVyakj2eAKZQkzqNPb7GDcQFsW2dPU3EISjOfEtB/ijwL/G7e022
         k0mubbLhqLLWDFmb+h1lbZaU71Ghk1tBLmbWHXlDHFBoYp/oDxu3xANZwHGZ3FggJwnO
         3Iow==
X-Forwarded-Encrypted: i=1; AJvYcCWS/MQgNmyQ6ZJp9tyfkakZlwEvUrvPEdE7ztcVnanB8Yfyw4lOjjalaZkN3ddAk1JvE98WjeswnYTAa4QOLIoqddOiQqO4ggbkQum+
X-Gm-Message-State: AOJu0YzaHbE9Yt2vl5E6LTiXSmDDOgLSSc8ae90NGrPuBS9WJd0Klz3C
	ZKg8buMbC8RzWG8M4p25XM4F6KWaJh7FM7y9uZwPafzK4T8afW57Yl7XG0OQjOEVs171uZlAmSp
	kTi8CSKIL5etz0oZydsLPVIWoMbf0cYP1sCg9Qiuec82so4bgFQC6SOE=
X-Google-Smtp-Source: AGHT+IHQxmZP7IkGnuJUxI8ppcI4nguzWlJoiyBzyg9ywc25tjZYERpEFJNidpA2T5Zy+gwVDD04POd05GvXw0F2sC1H0NY61t+i
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aa5:b0:397:b509:6441 with SMTP id
 e9e14a558f8ab-39b81327de2mr1190655ab.2.1723205942150; Fri, 09 Aug 2024
 05:19:02 -0700 (PDT)
Date: Fri, 09 Aug 2024 05:19:02 -0700
In-Reply-To: <tencent_FABB2C33D59E661B6F4BAB1B3D2538BA2A08@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000e980e061f3f26ee@google.com>
Subject: Re: [syzbot] [v9fs?] WARNING in v9fs_begin_writeback
From: syzbot <syzbot+0b74d367d6e80661d6df@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

fs/9p/vfs_file.c:49:38: error: 'filp' undeclared (first use in this function); did you mean 'file'?
fs/9p/vfs_file.c:409:38: error: 'filp' undeclared (first use in this function); did you mean 'file'?


Tested on:

commit:         c0ecd638 Merge tag 'pci-v6.11-fixes-1' of git://git.ke..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=8da8b059e43c5370
dashboard link: https://syzkaller.appspot.com/bug?extid=0b74d367d6e80661d6df
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1082c67d980000


