Return-Path: <linux-kernel+bounces-401096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 924429C15EA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 06:11:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49A501F241C4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 05:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00601C3F01;
	Fri,  8 Nov 2024 05:11:11 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE68C158DD9
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 05:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731042671; cv=none; b=iYCNjAA5JjbmqSKvcyPBimOJfYxm5XHEUqU2V10EYczno6ASOFN1m+Y185HdGXjkz5DqK8pculEHPp45SZxI08VxrshAtpIAzmszexIAqSu0x4MVSqGDyqOmvfXandLpzH9rbuPZXcCIpeOwlpcEfaPpiDE6Oh0wz8yrGZzuAAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731042671; c=relaxed/simple;
	bh=vA7q3ey9IQDXsNVyxtJna/mpocsRlqsi6kDe717NzEo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ZIZu/iY3wajb+/8G9oS2tLPLalCaIhB8TQ7fqi6Q0qLhI3bA+R/RHTttsf4RwyriKPlNhJhQXSptlhFq7wGZmezdHj45j4+ZLyb3lwG60P75TC+rThkq3ARaHX48AtjJikPwmKQlhIT1KaLUkNkREF47kCRQipSmmpejBxOTPYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-83ab4cadf05so200231239f.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 21:11:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731042669; x=1731647469;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fHED95VNotAf9X/S/Kyf5Ay24kyu2cHoFcBFo1owXBs=;
        b=lMbuJFb80mUQugFx/HDqW/PvHtwOVbIBJAOJx940wW55jYY/HTqEupl8PzgDJN14/J
         JTYjJLMtbMXpyxlEc1WbSFEtQi0yMtSR+Kk3NkX9Hw8UGuPE1ye2QR3S3gqiUwChUv6p
         1+dV0nH9vRP1U78c/MmYvxAkVeWLKkyJ/9rjS1G/UbJXakrSWIgiqDSyOBLmD90Z49/G
         gVFNkeroPfpT2MVyLg6Gz2yNtTqM6deTN2eQdmJR4In+qRYHKqBufidmcH8P/Y3Jfx1C
         IVK8C9GdmUMM+qJdTAM9TEt1YNNzUU9peEPpeWQaATgX2TVxnYGAPrBQ95XG8hYabJKZ
         Oavg==
X-Gm-Message-State: AOJu0Yw2wW9m48B84Kx1+Nv61GNSb9vKhJwk0JN/fjGhkD/4lZoQWVvb
	UFLNFlsTrrbiz25sAiw3ZuKr3b9ADRYY4Jz/rSVoW/MNOPSEfnfFBb7+ks+ttY5aWq+Q6mgjFMD
	QBJ70Z6s4gE+zONmIOFjQ7fj22yiLwQL2ysm/zu2b4y4KfRDhS66ho9g=
X-Google-Smtp-Source: AGHT+IEhLVEQfpHgMiLgQe62ds6Egmnwelikqf0lZ3qYEIQLAswAyFAMzqqSMC8AqdLyPNJVh3BfAYW1Atp5OMp4cRX6CTeslkkm
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:148c:b0:3a4:da7a:15a2 with SMTP id
 e9e14a558f8ab-3a6f19ca711mr22366065ab.5.1731042669031; Thu, 07 Nov 2024
 21:11:09 -0800 (PST)
Date: Thu, 07 Nov 2024 21:11:09 -0800
In-Reply-To: <671d9308.050a0220.2fdf0c.0232.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672d9d6d.050a0220.0db4.01be.GAE@google.com>
Subject: Re: [syzbot] 
From: syzbot <syzbot+e8bd437eb38c35c5f35a@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: 
Author: kent.overstreet@linux.dev

#syz fix: bcachefs: Fix validate_bset() repair path

