Return-Path: <linux-kernel+bounces-229797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E0A917451
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 00:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 219AC1C22E92
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 22:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE2717F4E3;
	Tue, 25 Jun 2024 22:35:23 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AD5149DF8
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 22:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719354922; cv=none; b=NJfudGptfqo1r0z66FnZk8SX1ncl9qdVxulg9k2iigMiIPzvu683Nq6heaIy0fVY6LgnReOPzyhKRXCAoAMI8Gta42GPAbIymaAPqk76x+0/W/FaGl5o3aarYDtmPsK8CwnlMIvBeQFlWxmCvBpuPlyxeHb1XXiWHxyvqH8OgmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719354922; c=relaxed/simple;
	bh=zVIZkJDsTU3GHO5hOysdPrHBDMWqSuJTptF9C5/Up7s=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=DoKvRo/yQEKfH1mNdTY5JiW0/GrCFpluUyNXP4W0x//6JYES7jYxseTznQA0Sx+pnfXKMiXTgRt3Gjy4/cPNDwMExJgWZuq6wmCT9zTK847/Xw5pzHOGdvvTG2QNHKuwCX154jLQGRn7vNYHL9ehOIX7tbKu68TbrSuwbdEWKXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7f3c9764edbso94666839f.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 15:35:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719354920; x=1719959720;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zVIZkJDsTU3GHO5hOysdPrHBDMWqSuJTptF9C5/Up7s=;
        b=lDEcojb+Y3rArwh76LthEaDvc0Jw6msjzJqcXs+dF7+MITy5HaVfxBAq8o66ej3NUo
         8IdGeGyj/SOcW0ft30Rp0Ix0uwGtVzaT/vzcNRr026//MQ6pqGI5XLFiMmP5WnB13fTw
         jG43SF5FxI3GcIA3/YjkojZHM9XCz5opH80yfpJI0UM90n3tZGhgQqF+3KPMt7CxuWvr
         o26voAjsWfNcBHhymnvlrnC7GAX1CiyN0W09nzqJoiMlaXeLd71mToIKNpoDirUpaEy5
         A7PfQrnd5wj2xKeARq/XBx5tMMMIF011E386QEd51UEiDqXxJ3lHsqVA9GFs1/PxETgR
         6e4g==
X-Gm-Message-State: AOJu0YxZCi8hKE1h3KvtgwRTzjtsfOSdOwR30ry9+s/QlOYPMagMJ2uh
	W3N+kDbk/uFnX+roVvEg3Ihwi+kec1g/Y27VS7GhG8tPCjTE8WySbSod4UWZfllYpICPHPWtMFh
	JoEMvkAYmG3qBjDSXWTbHdwNbo2KL+9SYXIBJYaF6XzYYZVB9JX0CJPg=
X-Google-Smtp-Source: AGHT+IE6kpSZXO6rZa0v9glFBIWrGcR+raPOutHyJXw6hQsXs8jf7FHSlgboKLJqHwRPGxqFsU6FCf0aW5und8ToTNvWdHLroXBQ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1543:b0:376:4a4f:2c7a with SMTP id
 e9e14a558f8ab-3764a4f2d38mr6731575ab.2.1719354920561; Tue, 25 Jun 2024
 15:35:20 -0700 (PDT)
Date: Tue, 25 Jun 2024 15:35:20 -0700
In-Reply-To: <000000000000256ed406199cda69@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000487b60061bbe834c@google.com>
Subject: Re: [syzbot] WARNING: kmalloc bug in __snapshot_t_mut
From: syzbot <syzbot+770e99b65e26fa023ab1@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: WARNING: kmalloc bug in __snapshot_t_mut
Author: peili.dev@gmail.com

#syz test

