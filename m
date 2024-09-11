Return-Path: <linux-kernel+bounces-324640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 150B8974F29
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 12:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4D0A288065
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 10:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7888517DFFC;
	Wed, 11 Sep 2024 10:00:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B929A17E005
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 10:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726048805; cv=none; b=qMCn5vA85iFDz30bI8AAcTYRNzuT4JrlzRj7MkhgBfi1sCvq8yNRqbqyxsVxjPvbM/UBcc+V4iQUKyyeN+eSEgHTJ3MyBwp+24VlMDHC2YYmEAiN++gMcM75tanU6kIX7fa7ICi1c2/Yrl6nZ8MSEO0gS03VM7cGpmK8cYB01oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726048805; c=relaxed/simple;
	bh=OoSSIQ75dzcQSwQedpZ4mNlEi/G40UgPaQ+6mN9Xkuw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=S9sbAYnkE55G0K1z+z+A5bB2KSCHgeEsEnw9pBrGoLhYg6SybWwbacgeA88AHbgilx6xRydd6WvzE+TeC+M952FxnGirlSqlvfhCBo4sdh+sqhyCxzrCDFinfPh0T5dHhGtuEJMQy5Sv/yB2q6k7c6BEp5M0Wd8SO+RrTyhA3tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-82ce3316d51so658695039f.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 03:00:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726048803; x=1726653603;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u2GKodS67y3/WL2/PJ4/4RMpxQSMMiSDGT9gzV9p4GY=;
        b=RuQtN6pxZJhxQiUfmPIO8PTOtEKjm9NczzmendjQCFHB6J1OC4cKZEnyGC48RJUCjo
         Rg7K7pbjOu+7A+tnrjnsiCyH1RG9HPhVJZCF6PtvGUQGEW+sn20xo9A0rAnjnpDEQQXg
         YpWvBv424q32h9tjJvBgm4YNF7/jsTf74iVg7czxomK63Mt90RacJCoO+PfPs9cWErXn
         8sePpXB/8llOpdiIA6Z8Y2G7bb+I4hAidBhW5LwQFlNL1zPFwKc9PIHUNyvVFVHjU3Ay
         skaggyaxjv905jKLH91t8RrAH/tPmDlkhqqnWT4nAAly/2QymCz0iW9wlnNVe5uw0eB6
         FsTA==
X-Forwarded-Encrypted: i=1; AJvYcCVCrjAcTfR4wRFBk7UVqOtDoNRpQoX4O3Q2/0MohTJJKceIwi6rirFtMesIgOgEDeMG13MJsYSKb00Gsq8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywwaj+GUjE56nH70I/lMPkbaHLOgejcjKaxAoHwCSIL+hjP6tPy
	hBaLcSHh//CJh2cVWSBsOSVnttTK3+9/gvBBaRtlmc91shthpy7RL8Eu5TFA4ssAmmaC43U8y6O
	6GK+fa9KiHvXXf0M+pg1N1HouvbLgbQYHyJIagEnUZcKos918v57rkgk=
X-Google-Smtp-Source: AGHT+IE1rKmrzfzO0Sm+9IclnOAF3hU3jAHb/Nt748YJ/GmGwCI9MLlvKt0jQsTYRhJ5RzsUjGOaaGRaAEO9XqAg2jRAx9oMcvxb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:29cf:b0:806:31ee:132 with SMTP id
 ca18e2360f4ac-82a961891c6mr2412517539f.4.1726048802876; Wed, 11 Sep 2024
 03:00:02 -0700 (PDT)
Date: Wed, 11 Sep 2024 03:00:02 -0700
In-Reply-To: <2d1b512d-c591-46b4-8dce-9990f6154dc0@linux.alibaba.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c2bdc70621d50d50@google.com>
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
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1699a477980000


