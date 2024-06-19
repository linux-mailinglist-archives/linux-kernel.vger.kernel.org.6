Return-Path: <linux-kernel+bounces-221160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B2B90EFA3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 16:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EF5428221C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 14:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 252021494A9;
	Wed, 19 Jun 2024 14:06:06 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693C51DDD1
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 14:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718805965; cv=none; b=Cma6J3nuRB7lPsAqeKo59buBf4LlcRjQSphUXM2T0U5iJ/z8wncy8al26B9mHMB+2/+GLr0BMV0Vi/ASlW9TZiL4qIjB4Tr2PsesxoAAriwug7XeW9zITndjTJwOlLLU+Snj1BwJNcWMwtp1/pQ8NLEcaNrjIfMBi7+DJQZT8FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718805965; c=relaxed/simple;
	bh=kB4lsL9Jk7hqhWXCSeLpXGnCTQYvqJXtlIDXrQmdAV8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=gxdDcBSXZ7krp7ZUAvb6OMulNBJOCtc2y18bJKqhiYT6a0a9od4c+X5dinUicooX6LqWFladleD5hQ0X0veSxGOOhJIrgvGPVttfycDeBmDVK/+PmrEBH1cJeMrq3Qx4IIQw11N+dn3oGNnH9GsCSzzaP7eFxdKzsL8HS5zBjOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7f12e60c050so74325239f.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 07:06:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718805963; x=1719410763;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PxFNes5Jm5DOsCIyQ7YcMiVGoIgxFwDe6xXlvIMbJF8=;
        b=A1JJmVnjbrx2I6xmYbWVfkqxm9f6UEYVjOm+9uONHFsK2WoVvgNBwg49HXJsGLQ9sw
         qF9Dedf8nsuTbmHbZzQq+X7oa1B/PHVnsE0zbtlOb8bNCnBEGROfVi3C0E2R5LPWyU75
         nGvYTrEnokrKRtkjuucB5CWk4QxpU8tAKat6JBvM9L/VUTrCrQrqItwOKL0hEeGFGqxR
         Aeil9heOO+d9/b86Xk5stxB0VwFF8SZiJXNGprN/6uhRkn6/vCwqI5Nxc/7wuEtd1c9y
         40EBQww/KQZEuE9uRBpfAzt0/H8pJZD1uinrQJIiUTrgm1gPh3Shwii6OXjamNn3vma5
         Oclw==
X-Forwarded-Encrypted: i=1; AJvYcCWh57CZj3lXYDzJoq9O7GgheOKbNcqJ3ywH+Z9HWw3pL23nWPuegm95oOhTAuCc+vu3A4HKKVjLFArrhYJllu9GEjieWcDWuYH58+gc
X-Gm-Message-State: AOJu0YxirSXkdEFxSeTmcfzo7nt+OfItROJEZrVSK4+P0Qt8LmPSItSM
	pU0/uNYPa0s0bilLuA5WcMC5yz2D2Bh67L1CiWqhUxI565thSMz3M+2bHXD4ZZgtyEyKRLPWBIT
	1TuXYNJS/yeMI++8ZD493ma9YDNCoiHIOwRQAaYOwMaREOYlctnLQuaI=
X-Google-Smtp-Source: AGHT+IEXkKWGjSC/wASvvyqgD+piXiWsSMejoV/+LLMEb4SPrrfiCz+Uv78wkaOg87txnTGNO1FVKj17WE+JPAYpnUKeEncD1pnG
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c564:0:b0:375:cfd0:393d with SMTP id
 e9e14a558f8ab-3761d14694emr1752295ab.2.1718805963657; Wed, 19 Jun 2024
 07:06:03 -0700 (PDT)
Date: Wed, 19 Jun 2024 07:06:03 -0700
In-Reply-To: <d0e71ba0-d0bf-4ec2-8222-1c1b6c49353b@paragon-software.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e6ea9e061b3eb27f@google.com>
Subject: Re: [syzbot] [ntfs3?] possible deadlock in attr_data_get_block
From: syzbot <syzbot+36bb70085ef6edc2ebb9@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file fs/ntfs3/frecord.c
patch: **** unexpected end of file in patch



Tested on:

commit:         92e5605a Merge tag 'linux_kselftest-fixes-6.10-rc5' of..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=9d7ea7de0cb32587
dashboard link: https://syzkaller.appspot.com/bug?extid=36bb70085ef6edc2ebb9
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16bfe146980000


