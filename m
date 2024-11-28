Return-Path: <linux-kernel+bounces-424227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD129DB1CC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 04:22:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12BC52820E9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 03:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97EE84D29;
	Thu, 28 Nov 2024 03:22:00 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C17256D
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 03:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732764120; cv=none; b=LkZtGAVWJwZqq6SEEbWUrRIb/g7aeqrr8MeW5PDtKgrLf9+pqDp7wM+xUDmEjvtUGq+mDpiG4BqtEHwjB/Kxy3S8uZLfqPmpU7+vVZXglWBTCpOiq6nWj1kWcTgaA0oUTCVXOyFjE3ogRaVepjGZr1/KUHsUqenl/YAVbOT4kQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732764120; c=relaxed/simple;
	bh=hb2PBBvwufkpWR9fveOWwse8C73X3fPGYWIm3h+Z4Zw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=RJkEy+9EoLeQAlK7DD2A6SCEJ16oSXdh1eGsyuqAJhR0F11aPOVLAOMMM/QkGAUYwy/LB8/Q2PDEw37YTU4epMbI9+bAABVQ85xKCK4ub6URwfw//sVcKGAe+cNaKB9tnwh7IYVmeSLjky6cuO7jA1+XdXRhXoDAlq4GnWWI1K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a79088e7abso3355125ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 19:21:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732764118; x=1733368918;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x5OfYs7iW05qw4f6R/a4MpnNi731f3XkcedW7Ckf6N0=;
        b=EyoGEL725+jD/kMrL55DNgoYgnKABuxTxQvpT8NYUerKN5eiHX7ZtKhZZGNCNxWCoe
         ZZExfRES99ExPwjbia5felr5p0vUGSSSUIRpYqlVxOYmkyMkbRodD/TUMu47MFxz+o+V
         VfFLNFMyQeom+T7bOirtILrKV7MjOczeK8C8V7iXTKiOZz7jO429vDOmkQmUZ5iTOkPy
         NcrrCbMiPHK1L7kgjh3vPNFVNkFV8vvaz+L9VYLfasZfbV1kzy1aUXzyZE/QxvRN+Os2
         dkZoPixSu3V9o8MXGdDYaefelTuL4EKspj4MqeBQ9uIp0Wdr6LHrVpvK/RK3bQj5yWWz
         p0HA==
X-Gm-Message-State: AOJu0Yy3/pGKAtx+ItKVEGDrl4xOFs18jMWMjaUt10hSX9PUmp1+o/Ds
	hE96N1tNI7kUrcdCYD5XvK2kCezvNjPsBqcZ54XCWWkizjg4pGxjXyspDETCJYP5dpVlbRZnnJC
	rZ3Kzk71WhbTC3D/t+GGwjSAgYjsRGNYZOlbrXSUFGjb8NzXtpbsovTE=
X-Google-Smtp-Source: AGHT+IHs1QA3DqVHOpJXt5mgaKfpOAHNiNITljU7KmkCUiIXy9MqiV+oEffb1x/Z86c+L3uIfF7JMLB0ltCgLRMpjQwt1oE8lH0M
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca0e:0:b0:3a7:635e:d365 with SMTP id
 e9e14a558f8ab-3a7c5540e9cmr73238835ab.6.1732764118352; Wed, 27 Nov 2024
 19:21:58 -0800 (PST)
Date: Wed, 27 Nov 2024 19:21:58 -0800
In-Reply-To: <671fb289.050a0220.21b2f.0005.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6747e1d6.050a0220.253251.0069.GAE@google.com>
Subject: Re: [syzbot] 
From: syzbot <syzbot+4aff7bdaa254c1d9f008@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: 
Author: kent.overstreet@linux.dev

#syz fix: bcachefs: Guard against journal seq overflow

