Return-Path: <linux-kernel+bounces-343540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FAA2989C43
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 10:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFF6D1C21003
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 08:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B4017BB24;
	Mon, 30 Sep 2024 08:11:06 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4231A170A0C
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 08:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727683865; cv=none; b=HeCbiza3yWGTSdec6Jlx3biy0yHZUAR7Eu55kGp7ab0VGJHVARBh3N8zGv01kaJOjlTYQgGaWO8RDUEj2vA9LLeOqMVD73mmr5Q7OpBcmdWT60cY/BhSQS3PmtKB7WKKmHTDX3lEqHB9j+E7yiuaj6UVPR0Hh23004w0pCsJi8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727683865; c=relaxed/simple;
	bh=xMwGTWrsEdKN7v+VjUj/BA/7EWhSzjGhkYUmcVEn1z0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=sIDfaYJ2ZU+f4c5ov6kG8u1p0EQOVtFvFHkND6akJUFAzI570CgnML+adRDL/BZWOklVDOvMPaeebHrDxHtMgqFFOBFWCeCbbAvWA0+21nRaXZ1luSUQEi8rA+OEI0ugfZFA694OFhjOWS4ItjB/BpsmkFnjvbufiQazT/VHxhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a1a8a4174dso33245995ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 01:11:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727683863; x=1728288663;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BOMAlPPJQ0qmeXsSKqzswLvH+410QFkLvVhwq6MD400=;
        b=L8VstrOJFRJ0vgMdONbuY22kskZsHVh88txZ0y3ncYNUQq0IkoWWSPuNX2bFnTTp6I
         pSZWdeSVjtyREdXqdfT+fDQbjcxVuDtesPFb0grfhgNcb2DqOFk4dMVPbUBQ5M/+ExQZ
         JaSdjphO5juCCUyVbmHrm3ZhCD2DzO7pylyNtE1NnifPICQeTNkldyDUeh2XpIBhGXYi
         LcQoimthqRcVFAJ6AfsgZGrriKD+4h/wKuNr/uG0Umnqds4QBOGZY1qHMm4vkBdwgrLz
         dFzSZ4S0ty4raHG6dCoN8Cy4cU0ggC0ubMLejdCaka7LUQfPxz5NeK08hAIJZzrdTzB1
         BrfA==
X-Forwarded-Encrypted: i=1; AJvYcCV0vfOobmK8NNCFqkbI3WvaCdfgitP97l7LPbBSh1tLyk5Fk3hBG96L6d/432SnJ/66bk5lGR4epYtJ/h4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/IZwHX9eLN8VUVyZlaOTcJTKPJcpL9gGPUsBdipUQpPOyHjcg
	mBK+weDxEmWv8w6eRkWKv4/pye8DuvM+XMpuDRI2JQbdE0OEgIKg68OS1Kr49+NiSZCugwLV6wD
	dFhYgkmHuAAcIgwrrwxxrjNWxGtSvaOyYNyuOuyNvrBmt3KxkLuneg1k=
X-Google-Smtp-Source: AGHT+IHY0/i2rXiRAAOi+a16WS4cosT8crvPPjYcMEv4V+HQydfF/vwvaQ0b8ka1WSmIq8B9qrBmKNHUa7fsat1ulSLbvS8+dlOB
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d92:b0:3a0:49da:8f6d with SMTP id
 e9e14a558f8ab-3a3452ba629mr73085005ab.22.1727683863311; Mon, 30 Sep 2024
 01:11:03 -0700 (PDT)
Date: Mon, 30 Sep 2024 01:11:03 -0700
In-Reply-To: <CAG-BmofkSGc2Zq1GtJjoCgYwMrVhBP29Ohyhw1YfRH9pJWL3+w@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66fa5d17.050a0220.6bad9.0033.GAE@google.com>
Subject: Re: [syzbot] [jfs?] UBSAN: shift-out-of-bounds in dbSplit (2)
From: syzbot <syzbot+b5ca8a249162c4b9a7d0@syzkaller.appspotmail.com>
To: ghanshyam1898@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+b5ca8a249162c4b9a7d0@syzkaller.appspotmail.com
Tested-by: syzbot+b5ca8a249162c4b9a7d0@syzkaller.appspotmail.com

Tested on:

commit:         9852d85e Linux 6.12-rc1
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14153d07980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=49ee0717ac2351cf
dashboard link: https://syzkaller.appspot.com/bug?extid=b5ca8a249162c4b9a7d0
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15793d07980000

Note: testing is done by a robot and is best-effort only.

