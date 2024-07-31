Return-Path: <linux-kernel+bounces-269100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18260942D99
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 13:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0D452856A2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 11:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533481AED23;
	Wed, 31 Jul 2024 11:57:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790C11AE868
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 11:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722427024; cv=none; b=P7UFEDvC1iua0VTt0lh2uwLTh5vjGITFQ1bGMBov6h4fTQWttU3TedizOK5WgJyvdv97+4NLJd//GYpi3LSoRmll/llUrM4WLIOCg5c2zyYpk2+wuhjA5T4AobiB4F2lKenFTAIxm8gL36KUp4l98xnMECNBxQqps2hrdX1vh+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722427024; c=relaxed/simple;
	bh=hQUoUT6P370vSdku525I9ZyIqVpjyDqZTAwNNZoSxuo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ronZmex5t1svpYx6xQHyvQycMRwQW60A0+bhDti2c7fqWmM44mp1pqj3hlvNCPYiDgYOFplPM34zXDs+vYt5US8136Qj58hm6P0ehOjqPDgHFfCBlAQq4ikSaLDqjj9qQ7FLm3TULPVM2+A18MKdjA4NPkA+9BB/gDkyITOQTxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-396a820a8a3so13130255ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 04:57:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722427022; x=1723031822;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xSrgeN+yuzirQre8G4sG5Sw6kVPo4mH3hIOR53sJbwQ=;
        b=oSSPyfTwskJL7F7XUTE6G/+8Nk+71u/WEkJJjJXw8JdK/23tetK6sEDgLsCJtMEvyh
         tBDbUR/wY/4i5R1q47ZdZVfUEm8ePGvp+KGNWs5lt93mUiNLiM+S+VtaL+JGqasaStyU
         Fe6+db4l+0KPFKYKutGLCzZBpbSfmmtEE1B7P/EhTmMYSaSYLwDzhu8+WMPgbJemFUQY
         LERHzgehMKb00mFjiB2543BGYJdMaE51AI25QbQfVnv90DA6Mu7ZX/F/Z9LOd80awAm1
         rY4tyS4b99A5WGcTxEUs+IG/3E6FxqGmrCwTyKSal0EuiMCCyXDpHE0vqhWIhachDOhm
         /yfg==
X-Forwarded-Encrypted: i=1; AJvYcCUUCly2sl/kATU4pSkr036pPu0PrinZ2dAbxYwb9OXmWKfrTDhHth3GA4jvGeICo9qQPjHNgeaZGEJSd1j8t6B5tuz0/irvOyEmvVRs
X-Gm-Message-State: AOJu0Yx4TQhE+M5YQZySiPhMMGBXZ3X2Y9sfCn5Qkbt3M4nnFqxP70eX
	pDaFryIClour9UBnBPHbLRYqnznz4MjqkBqc1p0l0f9QSPhjvZKYOhnlQiIX2QIW6UiVNqsMQiC
	jmInbfs+b7WBxnwcdLT6tJIWz1n6FhLRSso7WeHf6sdGQ5nRrAEP8TUg=
X-Google-Smtp-Source: AGHT+IG6yJHm71PfnjSzpzV2tajfrhXIQF3DZ9LmFmTF0gSF9zc7EprT5Loy3CMpp2Oq1hqsKdRV7a+B3kc8FcJHdRu9wenzlL2s
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aa2:b0:381:37d6:e590 with SMTP id
 e9e14a558f8ab-39b06af47damr3064295ab.2.1722427022641; Wed, 31 Jul 2024
 04:57:02 -0700 (PDT)
Date: Wed, 31 Jul 2024 04:57:02 -0700
In-Reply-To: <00000000000022a23c061604edb3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d61bb8061e89caa5@google.com>
Subject: Re: [syzbot] [usb?] INFO: rcu detected stall in __run_timer_base
From: syzbot <syzbot+1acbadd9f48eeeacda29@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, brauner@kernel.org, davem@davemloft.net, 
	dvyukov@google.com, elver@google.com, glider@google.com, 
	gregkh@linuxfoundation.org, hdanton@sina.com, jhs@mojatatu.com, 
	kasan-dev@googlegroups.com, keescook@chromium.org, kuba@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-usb@vger.kernel.org, luyun@kylinos.cn, 
	netdev@vger.kernel.org, pctammela@mojatatu.com, rafael@kernel.org, 
	stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com, 
	victor@mojatatu.com, vinicius.gomes@intel.com, viro@zeniv.linux.org.uk, 
	vladimir.oltean@nxp.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 22f00812862564b314784167a89f27b444f82a46
Author: Alan Stern <stern@rowland.harvard.edu>
Date:   Fri Jun 14 01:30:43 2024 +0000

    USB: class: cdc-wdm: Fix CPU lockup caused by excessive log messages

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14f906bd980000
start commit:   89be4025b0db Merge tag '6.10-rc1-smb3-client-fixes' of git..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=b9016f104992d69c
dashboard link: https://syzkaller.appspot.com/bug?extid=1acbadd9f48eeeacda29
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=145ed3fc980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11c1541c980000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: USB: class: cdc-wdm: Fix CPU lockup caused by excessive log messages

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

