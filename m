Return-Path: <linux-kernel+bounces-415451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB159D3659
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 10:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7333CB26667
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 09:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EBE7189F3B;
	Wed, 20 Nov 2024 09:05:05 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D8F136A
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 09:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732093505; cv=none; b=sFWBk+YJgFAob/i25mE6Q+KYRltW5lw6aK/IiqN8f6HvxCzZE5eyOJr3mbS7qhjhOTeXBsjgz1leLyeouiC868vY0a5WfIUaMZdu656Knc2VN5k0k/g+Iibd9H+U0s3pAZhtWmkXBE4fgZ8J+H8BTRWLt5045mAn579pckVB3vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732093505; c=relaxed/simple;
	bh=LTsfuqobwOuYJTWSmPS2Is+RGXAY3qeHoSjZoR9SpVc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=cBvSxxlvQDgGErNGROQyEuJ/e0d5FDQb8thLlx9wV34LyJqOOKHSk+SiCGODzFAQ6+Sv2NRNoB8PZG5cIJD33dOXkcTyV1Ma2NZvfh8LjQcw+ZYIWoCoXL2T0kJHsTJUYQQZ8MmBTe2qCraM/4pKbmZUUoj66FDq9KwmiPldNRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-83b6628a71fso672787439f.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 01:05:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732093503; x=1732698303;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uvk3oMrAGU4iCjocAkLYzWcFnA6WrART8sfIGJYHVaI=;
        b=OnfdW00/d2TcFpE6jmeZ0TDKfwYspQ68YTBAQamu+WsWF5MC02Xb9wi48ZLv8djXqq
         klB5Qje4KrGd8Q6nL12UiSFGsoPsKhkppydaJ+82WR4VMp42LWYvrJkeV+avecNNn4Er
         BUvGh45nF8DE8Oc2+ycHBE3TA8A94MJqMY9hlOwYSdT0JLNBJtlEoW6CFz3Sg4ddFKpc
         Jo9cNThjN7iXsKBAn3VRQlPMkVC/8XP17VlxyVXAiPJ1g9Dtmvytzald3YMRd/zxNER0
         UCyciHsJP1FLlz557AAwaR9gly8lOAyTob7YuhbvKxyFGmHraAgodQzwOblbfyFccLz0
         R/AQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTaZAaeF1OSREnr1ovT3BuEZv42b+iq1z9qlm8zyYU4mG16qU+qd+X9ZY+q9cxY+5IYxuPSkMP5LfaEV0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw+gfj1R/BrDMcKR41ky7ycpCjXJ75/Qm1oUlSIIp7K6Uuv2My
	35LEoNB32Rmn+XC8HuinpDesEbbnun4D6YNX9O47tFa5g52Onlzn1XuKphy185lg9O5p2IZNLCC
	TVBJNd5iLEKHvifvtejeNAyvGmqm/IWiyc6pu21AVyf7I86ybtXH5C2U=
X-Google-Smtp-Source: AGHT+IEiej89K/rL0pcqhadvsesMvYT0TZ6b2o8M1aBONEBQbpwXedWa6E+KeekSxx1bGhATHKktxe8x4hG6k51KxydDnMIi3fjI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cd86:0:b0:3a3:4175:79da with SMTP id
 e9e14a558f8ab-3a7865019fcmr18847425ab.13.1732093503157; Wed, 20 Nov 2024
 01:05:03 -0800 (PST)
Date: Wed, 20 Nov 2024 01:05:03 -0800
In-Reply-To: <CAHiZj8hBjro1gqmVt7L8La2vBBNTa0VUY1kdb1i1kNJ-x_Dazg@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <673da63f.050a0220.363a1b.0008.GAE@google.com>
Subject: Re: [syzbot] [scsi?] [usb?] KASAN: slab-use-after-free Read in sg_release
From: syzbot <syzbot+7efb5850a17ba6ce098b@syzkaller.appspotmail.com>
To: dgilbert@interlog.com, james.bottomley@hansenpartnership.com, 
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-usb@vger.kernel.org, martin.petersen@oracle.com, 
	surajsonawane0215@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+7efb5850a17ba6ce098b@syzkaller.appspotmail.com
Tested-by: syzbot+7efb5850a17ba6ce098b@syzkaller.appspotmail.com

Tested on:

commit:         bf9aa14f Merge tag 'timers-core-2024-11-18' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11373bf7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=48190c1cdf985419
dashboard link: https://syzkaller.appspot.com/bug?extid=7efb5850a17ba6ce098b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=106b3bf7980000

Note: testing is done by a robot and is best-effort only.

