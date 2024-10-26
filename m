Return-Path: <linux-kernel+bounces-382846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C989B13F3
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 02:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B5CD1F2296F
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 00:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 131868488;
	Sat, 26 Oct 2024 00:49:53 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001F7217F3E
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 00:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729903792; cv=none; b=UJrQVVVjmoIKARdUQDVKNFdMmvnvw7K1cfTFoyfMK3T5R2twQp/TXsX/9GojgNEQmYJpedO2US36XdDTMTttC1scrldpLH51Y4GdMR6n46ekPCb3XDCNrZpwQyfmUCs9FP2J85zdVPk09neSjp5sM8RZXEBLnPCGfQiF6PVB9Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729903792; c=relaxed/simple;
	bh=JRgEwiOyUoVzjakg5Yg/vbUPRoFDA4J7/RHih+JoDw8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=q+pQvKEze4QPF+hDybBtlrrDgvm5MGdqPQDxESVX7JeDbbsEFwtNthlci5G+xojDVf26jrS/VqdnixAF6z0SSshl+86AZrfPfgzSfk3TzfjPQqM2bUslaT4kZ46In1twXOjDbY2seUCv2vyhjIq98CsTM2/0JxVR9GSwPuxIJ3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a3c72d4ac4so23008255ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 17:49:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729903790; x=1730508590;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tcIpEwRs5CQOZghr5CA4rkaIzAN0DGJqcoX4E/bYT7k=;
        b=R9VAr9XW4opXM0nzWjXw6taZJnh+IaXxSB9SlixfUpmSqQUq2CvXw+CRdTN3Q8xZxY
         yFCpmyCgNJa4QWbxG9HuyQQrO+M71nPMLov1vSVp8lSWlnM9RV09zDWXg08WsKMK60MI
         8TZbMImmBBtQzzjBB+WxSMYeXnECVndi1ZpRjzoHNRKMRcZeQuca2SPTo7uWQM/esT+x
         02itSkLXYhJdctmctyMvDSsr8K5DbF9ZZASMQT16MLqdF0xUf5kXmavuYVe7JX7mrEQm
         0ZblADybMb9kAoH1KDolI2lWFHZPmmuGunOdOrwY+8JOVp8avdM1enL+1owKVt2Ukg4P
         Ljuw==
X-Gm-Message-State: AOJu0YyggZCQSE8LpM0I5TKmjCbw7zgIzLGVRmZw2q88dnQ7nynTyELJ
	aMaktWH48p0Jg0LbT89M6FrE5o+zLdohaZhbHkBygXWc4qhhiUVr7ht4cQzvTbbapI19XQ0cKm6
	NWXJax5s86cXW29WKs8pzMAZSNVL2zINSRg7M6Sf1bp6pR/sawl3shJQ=
X-Google-Smtp-Source: AGHT+IELbqksU6stKENjiI5J1us3AvFgzvvbXdJW4C/M6uSF3j/tNrmVITZaTRzWJc28N9MvITDAPRdTIh2e2E9JQGEsmLSWUWFf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cda9:0:b0:3a0:480c:6ac4 with SMTP id
 e9e14a558f8ab-3a4ed301481mr9920805ab.22.1729903790050; Fri, 25 Oct 2024
 17:49:50 -0700 (PDT)
Date: Fri, 25 Oct 2024 17:49:50 -0700
In-Reply-To: <671907d4.050a0220.1e4b4d.008e.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <671c3cae.050a0220.2b8c0f.01ac.GAE@google.com>
Subject: Re: [syzbot] 
From: syzbot <syzbot+089fad5a3a5e77825426@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: 
Author: kent.overstreet@linux.dev

#syz fix bcachefs: Fix invalid shift in validate_sb_layout()

