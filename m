Return-Path: <linux-kernel+bounces-326326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE4397669A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 12:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0872D1F244F0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 10:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8DF19DFAC;
	Thu, 12 Sep 2024 10:20:50 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E050618BBB5
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 10:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726136450; cv=none; b=EiHgvd3MiEkccXyXdC3mIyXJo0NAHg+IjRhfg3K5W8UF4Bj83ut/nbfvIKLJ+mpy9wCveRdRKjFDmGICG4NuAWSZIbW++CoYYazObD4MuMbH/N7jzmtw2dKSheAkbMKuzRmZ8w517PQYDfUCcJljz6Ch3TNx5JxMXoe0sWO1yiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726136450; c=relaxed/simple;
	bh=3qPnp+viawjKft5ZJ7M5jxq4+u+MdLbTncu2dsksPHY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=AIIWkhkb+UMeL4WoyR+NNSYYgaiFWKVFckzqgAkliRxCmn3p3mnywAn6PAzDqxbg00xJK9V+PtXUTDZXLZ2P9GUc8mcw/FFERE5NZ9H1kNv5D+tuMeURK6XUXLj9etMtj8b66viPiq3DGDqoHYNXVtOTyyobs/iaYbcFzwgWeNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-82d0daa1b09so127386539f.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 03:20:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726136448; x=1726741248;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3qPnp+viawjKft5ZJ7M5jxq4+u+MdLbTncu2dsksPHY=;
        b=Wa4Gm68bwOU/fVBYrWHXtuF5InM5Rc4ZtHBt80SY/tf/zvMABrOUv72YG9T9PYb33+
         IKJ7S4UzoKfjCZAzDWUEGhaWDuNyidtPIB6LwJSsveK5KNhcl02X+pXIlqAOKULCUJBs
         uh6wSJsD/yCzYVDgRTPm/xID8EV7ceUsXeVumYXh5r9JB/NONi21sHos5tWjr5jGHTGz
         UD248yBVwI7HtTfG9R3vfLk08NdeyWAkUwxbZFMxfVPtq3dHF4oKdmFJr+hkOTLC4ABv
         DwGHpviXR6s6PUn4dkH3fNOcSqfpfC1YOW04QN6eq461d5o15LQ9eHvyeq8Lluf+U4/o
         GNIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlfTl6rDl1sYiu5VRyQKtQXfOVAJ1wsNsdW60v5lSjUgQ6i4bCv5OGzWthwuqpf1FRxLahQlw/NSF5bfQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi0Gt3eOgpbyhfIgXIgeGiVVVRdTx9h+TY4v+fcXXWW5LwULrO
	3/VF3wlJj4+dr8GIEFQGJp7xTWvxCqRduiP2Od37Ot+rxUknUmcKgS3gZ9vowebmcrYq0aypQzX
	PuQXI4xQX2aVVy6uXGaqoxwhP7krO99EZ4M0EGK2d3F3SlQ5IoYcX8mA=
X-Google-Smtp-Source: AGHT+IHNbUxZB93m0tmYiXdizi/bhQkl5jhf6ngb78OsB09wSCYglV0KbOglNb2VG0hkD8e/GybNvhNT9iefMX2ExZyrneDaMltx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b07:b0:3a0:4df8:1054 with SMTP id
 e9e14a558f8ab-3a08494ab1cmr21636495ab.25.1726136448077; Thu, 12 Sep 2024
 03:20:48 -0700 (PDT)
Date: Thu, 12 Sep 2024 03:20:48 -0700
In-Reply-To: <CACb6ct1hN+xLbMyKvmxuExkSqoSgahV30HFsdo0Epm4sjqWfkA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d2644b0621e97561@google.com>
Subject: Re: KMSAN: uninit-value in mii_nway_restart
From: syzbot <syzbot+1f53a30781af65d2c955@syzkaller.appspotmail.com>
To: ksjoe30@gmail.com
Cc: ksjoe30@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

> #syz test:

This bug is already marked as fixed. No point in testing.

> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/ master

