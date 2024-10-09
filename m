Return-Path: <linux-kernel+bounces-357224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C115996E06
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 16:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 087321F22237
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 14:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17D01A2541;
	Wed,  9 Oct 2024 14:33:04 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB9C19EED6
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 14:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728484384; cv=none; b=j6VpV0IbAzlv9x94SRL5Y7pVqHvnEmw1kk2lZB6WQEZbgiMFPR2MZv+10OViH5+usObtdmUpJuKF91G+2QaOVF9XWitzq3I8aQNKsVGeM70T4GYXVDLWeDwi+2qCxEnjepdBDg9NGaQFcuJbCcyrgt/C55Sumpme7fw0hIcYJXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728484384; c=relaxed/simple;
	bh=hMXHjOnJvWGurxDuTKozlaQWMPvREEzhqH4wD7ocs+w=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=DpNC2XIlV8h9hCK4TCKV+tcd19j3740yX62aqt3+OEraPi9k4nQQT90VhQeJ259axtkG8EcwK2rZ5CFWi4Pq30tpDtFxBBp8Ge1LKMP4jNFHkDrJqu9KYuoKcKbQOjGHK2xMD9IFZiOqo4k2ajP51X/YR3wAK5HziT4MN1QULQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a3479460f4so57287405ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 07:33:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728484382; x=1729089182;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tGAN6gUE3kEqpKptUspj70+3SY93x5uBlVMliyPILWE=;
        b=VGiygi4L2rkSwsM+plxW4M2qO4VVrifIm2Mb+EM9gWzKxGT+4rjBUPfvBWyUGCW90B
         bhK3Qjvg8Q5DhbW2o3fcCmRYrKCO9PmwWJOHUDBBRiTsDW1cpscCbwMn1c3qi4tXecB/
         om4bzeemR7PTRV2JTYqhErdHo1U5t+bhJqHUz9lfkd6epIxxArcpF9lBeuG9ET6MkNjE
         yAesIP9RFrjVHBzkrZ+1wo6HHjKged1KjNsS6fs9/mpV62wSG/RYX6v4Y3AJPOCfcSUC
         17FO2e4uBZ9Vii6+7J2B9tiuNAjy3TL+unvLvQbUy1LvnKmF7LDWCBk60E/T17BDr7BG
         PHyg==
X-Forwarded-Encrypted: i=1; AJvYcCVFtO1aiNf0UaGUXaF35taLeO480QLtT890IOg7WABtMLbFnZicRdjcA/GrVrq7LZ07APjJsji276U9jDY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzywpyxapHShVIo+m34aqxavN/5O4Nn8wbzsEadKWcyME1jiqKo
	+xnyUBqx6Zh2ETrgfSBK3HJyHK8f/UopEYyVDmhRGVWr83EjkeBt2yMYXbzcBmpl3JNNk0fDx1w
	eBX9nwsLtgh1MjUrx8wumUeXnEKx7DOdkUwWa+NXQFOCThpJM5KFlGUo=
X-Google-Smtp-Source: AGHT+IH1fiIktRuF9PnMRBTcLba7txNYVHSsv+ZKQucxuaRr6e36y+zEx/wEbx3xjPYAsHuy8v9JtQLV1HuCvkg3JP+iPKs/tbSw
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c8a:b0:39d:351a:d0a2 with SMTP id
 e9e14a558f8ab-3a397d17d3amr28533805ab.25.1728484382149; Wed, 09 Oct 2024
 07:33:02 -0700 (PDT)
Date: Wed, 09 Oct 2024 07:33:02 -0700
In-Reply-To: <tencent_A51B5C25CDBA1CBBBA33419EFB1B3B4B6508@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6706941e.050a0220.1139e6.0003.GAE@google.com>
Subject: Re: [syzbot] [usb?] possible deadlock in usb_deregister_dev (3)
From: syzbot <syzbot+1f8ca5ee82576ec01f12@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+1f8ca5ee82576ec01f12@syzkaller.appspotmail.com
Tested-by: syzbot+1f8ca5ee82576ec01f12@syzkaller.appspotmail.com

Tested on:

commit:         4a9fe2a8 dt-bindings: usb: dwc3-imx8mp: add compatible..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=14cac04b980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4510af5d637450fb
dashboard link: https://syzkaller.appspot.com/bug?extid=1f8ca5ee82576ec01f12
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17ec5780580000

Note: testing is done by a robot and is best-effort only.

