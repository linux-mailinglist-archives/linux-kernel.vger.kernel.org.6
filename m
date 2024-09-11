Return-Path: <linux-kernel+bounces-324601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C168E974EA4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 11:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 277A8B2891E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 09:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73D917A596;
	Wed, 11 Sep 2024 09:34:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2C114D2A6
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 09:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726047245; cv=none; b=JVqVols97C4NRUYyy7fU7nDe+qbxPCYRcg7XSr6IxBbuQNQEtaQXtX17/3ZzF/shz2L3EhOfbVIatUkY9mhwMW9+iDJ6Rq8raxurak7jiSdsLvBsW45IE3prrTY3yDgxlhhzVr2T0M6n+0xzgMLa2XiNSs/wvWj7MYeqBeCaEB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726047245; c=relaxed/simple;
	bh=63xahsFAqaCrQC0ZXDUaAFhulQ+z38ZxsJ5/tw8sPx0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=LAAjFOfPqch2/W2+qAnD/CW9EmXYYSRVAaLxFC7xxNrUV7aaLXh+jEJVqbHral6JtqmtRciigJmytGn/KG5C1W/Epc4U8BbnC2HJA2gGr31x+zKGvJIGAa1QVns0u/ZuBf50fxNc/OELgOfM46xPj9qITNx9/60l8Gps0aGR0/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-39f37874297so117601405ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 02:34:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726047243; x=1726652043;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i9m3f2loULEaH5DInWXZD5yy6fLhpK+Jj+zm3BPTbR8=;
        b=ulgzEUQvgQSDHULgfrRT2A0F9pZG6G4oMxcZbMLvGrXQDXbEVGnbZmvNOLPxGFNLl4
         XUNL1NH199ZjeWPQ7wcIYNlhk5FvMtCzAWqAID8h3saftV0C0aiJ30vv9X5fPGEwse7w
         17ApzLyt4n7Lg7vap7CvKm+bKFUKvo4y/TjXfLIlNTur9QtRvHr+sodCFg6St5cWT2/y
         Q/K/FwMgUczWpyz9xOkR2NCqQ6vR656lagxqPokR6Dos6jJ6ZYmhQzS/eH7aOJ2UwiyL
         ps6kFKFk0xLDYfwuK/7ZO+zlLpcZAASXqstzC0UorSHz3vBwPEKQH3CgFwzZAA2/cIhL
         DtWg==
X-Forwarded-Encrypted: i=1; AJvYcCVNDrMj0kE9JXSbchAVu7isI7ngU0tA3/mQSkRh9c6+5u4pndJFKqeVIPY5dS37ul5gWLEvaIpeMrC2/Mo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn4Cv3R7G0m8xgvP8q5KHSjGl37bYDVPl2R360GTejfGBKuLSP
	b2Gg36f3HfGoMKZJEIIHlrg0/g/5RsyLXODz20uhgWw7t2sGHF9Z5/GRtrSyl4jHWbdMWTpEdB6
	SG3AyXIk4z7mOUk9KkHVocrGHaSj4rnK6ChHwccrNAZ+rJQfLa0A2ERQ=
X-Google-Smtp-Source: AGHT+IGU8lapek9PIMGVnjoLgEWjJTt+hR/ZXDyh2VB1iQEr9Ni9Syt+Zp9RzEumD5pO6+Xhg179h3ewlAtdz1OzpDKigWycudjf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:13ad:b0:37a:7662:7591 with SMTP id
 e9e14a558f8ab-3a04f070a8bmr229719355ab.6.1726047243294; Wed, 11 Sep 2024
 02:34:03 -0700 (PDT)
Date: Wed, 11 Sep 2024 02:34:03 -0700
In-Reply-To: <a29d13cf-c55f-4658-bfb9-99f48a0d65c2@linux.alibaba.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cd6b2e0621d4b009@google.com>
Subject: Re: [syzbot] [net?] possible deadlock in rtnl_lock (8)
From: syzbot <syzbot+51cf7cc5f9ffc1006ef2@syzkaller.appspotmail.com>
To: alibuda@linux.alibaba.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file net/smc/smc_inet.c
patch: **** unexpected end of file in patch



Tested on:

commit:         7e3e2c7f Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
kernel config:  https://syzkaller.appspot.com/x/.config?x=dde5a5ba8d41ee9e
dashboard link: https://syzkaller.appspot.com/bug?extid=51cf7cc5f9ffc1006ef2
compiler:       
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=148a1807980000


