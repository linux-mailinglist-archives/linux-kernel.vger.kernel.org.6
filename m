Return-Path: <linux-kernel+bounces-234427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A577191C682
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 21:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2ECE9B22E81
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 19:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723DF6F31D;
	Fri, 28 Jun 2024 19:23:40 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEC71B94F
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 19:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719602620; cv=none; b=NdJMVyGfobOhvQjLgt/42aY9kFyqgfgHmDWVD24xvUoTn32J7xltr2kRx6z2TM4J580ykR4tYym+TEHh0erj/lNERFKLPaqCa145oxfGSV0VYHHZqPT2nk/Gb44hGEmdObYaxvqcLpvWB7CesNZEAUv/2A7Y2fp7wXCFVd+PqB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719602620; c=relaxed/simple;
	bh=234UVdOBF/dwYhzz2rROisaLbsEPQWui/WXIKAZApso=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=pj9+7LjVfDbyjAwgAYWTRvYv0DDHuuq3/cmrcFGKWebMtN+bM9oRWZznN5zpJiE5vQhGMcE5kzRrg1F4Pp1PqZV+RVs+p98/BnTeYu4EN9gjfdvJRezKZklaz9179qgDhzK2oVYNqcGiu4wiFatVugTKeKQ8CYhgMYzTxTsVo84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7eb01189491so97489339f.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 12:23:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719602618; x=1720207418;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=234UVdOBF/dwYhzz2rROisaLbsEPQWui/WXIKAZApso=;
        b=lpUl7jBeIqrqBieuSziQ5qXN41B/KIOpcKj0LZjNp0HW6P6vmQjPLYTDIZKl/8hPkR
         xgQfhP1vnNfIpZmj1I9vcDcAbepb/bRtTedsf14iFuvze24YbcsxBPbntyr39E4fgvlD
         NsxAH4RG35NK1zxzfUwK3EzruVKiCigmMTLs3k1v1XxKR6fUIOr4MKTIRdxHLwhA0i2C
         Scekrd4omZzK5ybSP0szXTNRuIAbKHW3oTAf2YYVYJ4PAdfWzST2DxZZNed+DzicOQhg
         azTKyS/GyqbixvGUbg+JmhPQr3Q8FlJgkahRWzEUE0xXens4r4vFNddySStuVDnzdw5y
         pcJQ==
X-Gm-Message-State: AOJu0YwWwMM8te4tvKZTGW+Yg1LTiVGH4uEhjG4Y7lEHZsgFaWiAcOez
	OoQKr/5TIEUwIuAlyAdUlQy3o4zfXrLXHId8dV5QvdimTzQs52JWoGK1M+htoTnvSQHUhllEvdE
	n4iQEtGG3O1hlXcNC29b2cxemxuYpI6ThxXOveWYxTbsv09xpflZuoWY=
X-Google-Smtp-Source: AGHT+IEaxAJzLsvLhBleZLwtv12GQF0/UJoI7bIzAvZ1RcMqQeNbkRJvrPX/on2uA9L5Azs/66Ru6A8avj6+iFCibn9mZXx31sJ6
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:13c1:b0:7eb:85f7:5fd with SMTP id
 ca18e2360f4ac-7f3a4d73044mr35419639f.0.1719602618071; Fri, 28 Jun 2024
 12:23:38 -0700 (PDT)
Date: Fri, 28 Jun 2024 12:23:37 -0700
In-Reply-To: <000000000000615c23061bd15fc4@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000348d4c061bf82fae@google.com>
Subject: Re: [syzbot] WARNING in drm_mode_create_lease_ioctl
From: syzbot <syzbot+6754751ad05524dae739@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: WARNING in drm_mode_create_lease_ioctl
Author: peili.dev@gmail.com

#syz test

