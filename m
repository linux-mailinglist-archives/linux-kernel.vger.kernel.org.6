Return-Path: <linux-kernel+bounces-393069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F42F9B9B87
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 01:18:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6B19282A5F
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 00:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E49FA939;
	Sat,  2 Nov 2024 00:18:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8F98F5A
	for <linux-kernel@vger.kernel.org>; Sat,  2 Nov 2024 00:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730506684; cv=none; b=mfcuLYeOoXZD5cD5bx9AL6vee1mfO8fg0BIKHoYvNvHq5qkGPEPa8BCjNx7RYnmGoJoFi+Haa9KLzc3d0UZAPOjf1ZZdmvfiuRz8Ickazd4NxRHb+j9XGbMrpYzs23FB1zzkP7Ba/dxZKx6/Zfwgmonjzx9ozvX6qx3IqlC1SAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730506684; c=relaxed/simple;
	bh=s99+F7ajIE0icnytMLSpEHM8ayYu7YUCrxluhW73tfY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Q6PwJEjGmGc6KHr9jzB2dpsgup11cbupc41FCgST5A09wz7Qg2/vaPMk44i2n4o1GCqmL14dsHk7RMQhdDr7fdSmU830hGbO9gDpV9UYj3qeSZy3qdqf/fo3OdlEpsUSiPOCHUl8k81zZASOdvTVATYyUi8aN03WFhskf89fNH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-83ac79525b8so225583639f.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 17:18:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730506682; x=1731111482;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sh1fuR1adzEigsbKwuk9VLe5oJQ3w5Nqup7MNszuiAY=;
        b=UDMX0L2QHAyejUKpMt7f7bBwO0Oq82/8VWWQkAgRm7DXpl8S2mse1SRk6d4Wfo40F7
         9D+1ul3ypqSt9QtlwFI5bmTWY71516/EqbTf5XSLaskal8IEicOXMB1SsQQHwKaa50SE
         D0erArvQEdE2sLQCFhAYKitAK/NElGfMEMJsLYVk4ua9xVoC9jYargSYjbbSfjDwBP9Y
         3iffSHjO2Q6H2pcGYAeiuaqdX1tmiUbTegwjD5YWZoBxIm8xIODJYLOExN/Gr2E0mH0A
         jUhvuhw8K+X+R6rux5sTNSFqQ8GBJefMiAR3yFM+UJg29g1tPUUh3WiLVzSnyGOzk/B9
         WbeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqAZHNNmO3QryLl9ain9/go0M16bP2vxr3oh4h+kOdF5umsPtSKdA/YCAoOK36j2XVYLME7xc/DzOliHM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzthI+hVt3z3Za5AZVe28DqCSGq/6VWleLBEdJKbqYzz3Y268qz
	kDfsRxfbnsjfH4eOiYYdmP7bmQcYodXwpJ17fRTpToGCiTeBuUjHphJ1OyymoCT4o4ONNV3KvJo
	GV3eUwcAvo//Osq8f2RtPd6Lv0KLp9ubrXWUyvtKDf/xW1qxQRNSkKJI=
X-Google-Smtp-Source: AGHT+IFlQWM4R/n4nNdjX+pvb2SBM/eb6rhkdLDUVeOudgfINa3pD1/vwX9UDLPmbhFyddJRr98x8/zH5EZ2GfFE0gL9Qoau8d+J
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c28:b0:3a4:eb9b:650 with SMTP id
 e9e14a558f8ab-3a4ed2de153mr263847405ab.17.1730506682277; Fri, 01 Nov 2024
 17:18:02 -0700 (PDT)
Date: Fri, 01 Nov 2024 17:18:02 -0700
In-Reply-To: <20241101235205.2735-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67256fba.050a0220.35b515.017f.GAE@google.com>
Subject: Re: [syzbot] [net?] general protection fault in put_page (3)
From: syzbot <syzbot+71abe7ab2b70bca770fd@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+71abe7ab2b70bca770fd@syzkaller.appspotmail.com
Tested-by: syzbot+71abe7ab2b70bca770fd@syzkaller.appspotmail.com

Tested on:

commit:         c88416ba Add linux-next specific files for 20241101
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1607d340580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3ebcda5c61915e91
dashboard link: https://syzkaller.appspot.com/bug?extid=71abe7ab2b70bca770fd
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1368f2a7980000

Note: testing is done by a robot and is best-effort only.

