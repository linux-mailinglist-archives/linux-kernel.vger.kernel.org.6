Return-Path: <linux-kernel+bounces-260973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA7F993B121
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 14:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAB1A28605E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 12:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D6C158D61;
	Wed, 24 Jul 2024 12:57:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F977158A2F
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 12:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721825824; cv=none; b=ad46+4fOVogI+Nq9715pRkXLFXdeC5oPNWKFXe1+q7GPBk7rCFuj0KU/O3G4voyDyCzpsp+ANmJnuKnJj2mlFAm51x9xDx4AFxSCyrd5ZgWMVCyBk2OOy2Vs72kCRrfA8xCffJH4V5GyidXP3dNT/ZJXIgk/6EGLglKTGSK3bfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721825824; c=relaxed/simple;
	bh=eMO9oaTYJTw7/pYmgEFRo+hnx7JERKfTjoDMEGw7rvk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=oDGmykgZUxqilvYFC5tXsZkA/xlCECfF3y1uBGQlO0mRwlKJJPWApadeIw6yGNQxvgy+EMojIbY01CDuWjeIvKtttEqv7OaDw1fMScKetAwSMfLDBh4Ag0vQIiACJUnj/4x8OKLCt5GZBVMbW6sjVuN3wDSGB6GN6CJEr1o/WTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-8152f0c63c4so102362239f.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 05:57:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721825823; x=1722430623;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sWF/vEehNNZ8eqC7U5IQ3mszOLthKw898Ewf4PdqwSg=;
        b=rifp2eWuoI7vsUT6cNp18Nw+Uv07xXQp6Xr2otBj55G7kxytFyCQYhEKUMTowDsDSk
         yZGTvf95cjkIBcyFs3SCxqNEAzFmmNdeunrYQL7eUdS1qS/19eyCGDTTgoSKkxsTtlTE
         lzr82uxJKpFk6B/JF1axuOn/+R0A0rpVL9lE2+Mbv9WAmfn20viBi5KbxOqHvUknw/FG
         KUlEpvrF4UwHDml6Dt5pFOuomWimiyjX5BgZ9qc1SLM5mMCwha645obNXPc03OUYq/US
         X1o5tEjwAHEhebZIGX5S4Ve0h4Wic0Wp/bt0GROF8vIynF+wWzdRW2v7SofyazmUlzwq
         DjAw==
X-Forwarded-Encrypted: i=1; AJvYcCVDyc4awJcowC32oegev1m+H90KJ7vgo/CX5dKpIvxZ14fT2NOAuWHEsTjEjbUl5pCfElAQLC9A9A94/gyvCywwkhjaKJNf5AO2Tnjx
X-Gm-Message-State: AOJu0Yyx+tU9/FPM00ymMM4TLuo4leCPw1jK1HV6IuVBHLZPWc6hd3NB
	pYQcZL+Wp1dXNeMYcnjknK/8bRgnt0jbLEGWhqJ97i7quCDUKsMFIFwhNMeeLmnfMmA3sG1qziw
	slRsnOiE2G+XNafvdxO58MWXIZ8rICsisj/y8oc8QOcGtK9Usm5Cqkmg=
X-Google-Smtp-Source: AGHT+IE+80N05IIoyLx4suhOWzjDC4b3xUK6256qg6ywXqEciukJkJUXNqup5dDfum2WGGluw39Mcx+flqntE3d+GjVmQu9LF6j3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8412:b0:4ba:f3bd:3523 with SMTP id
 8926c6da1cb9f-4c28fd31a25mr100554173.2.1721825822776; Wed, 24 Jul 2024
 05:57:02 -0700 (PDT)
Date: Wed, 24 Jul 2024 05:57:02 -0700
In-Reply-To: <000000000000ce2dde0610db47a8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000883205061dfdd0b3@google.com>
Subject: Re: [syzbot] [media?] possible deadlock in v4l2_ctrl_handler_log_status
From: syzbot <syzbot+9948f8e188482c5d1a3e@syzkaller.appspotmail.com>
To: benjamin.gaignard@collabora.com, daniel.almeida@collabora.com, 
	hdanton@sina.com, hverkuil-cisco@xs4all.nl, laurent.pinchart@ideasonboard.com, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, mchehab@kernel.org, 
	nicolas.dufresne@collabora.com, sakari.ailus@linux.intel.com, 
	syzkaller-bugs@googlegroups.com, umang.jain@ideasonboard.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit eba63df7eb1f95df6bfb67722a35372b6994928d
Author: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Date:   Fri May 10 07:11:46 2024 +0000

    Revert "media: v4l2-ctrls: show all owned controls in log_status"

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=146553b5980000
start commit:   c942a0cd3603 Merge tag 'for_linus' of git://git.kernel.org..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=98d5a8e00ed1044a
dashboard link: https://syzkaller.appspot.com/bug?extid=9948f8e188482c5d1a3e
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=100b025f180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11abdfc8980000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: Revert "media: v4l2-ctrls: show all owned controls in log_status"

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

