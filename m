Return-Path: <linux-kernel+bounces-277622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F2D94A3E5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 11:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 837301F23341
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 09:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA571CCB4A;
	Wed,  7 Aug 2024 09:14:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C821C9EC8
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 09:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723022044; cv=none; b=KdvrYu+pk9nq2SYDyKnAbbzWXx3VmpyI4VsEoaKiZsjcBdunq7B++ob9m0acqI0LMQEFlUqs6IxAYHUJRNxyivdxtRL5WMFOW2FFrI4jzIzWUx42Qm0fXGkHubL6TpSsxXGXqDQ+Spe6Hd2fJD2WL9/mOmGc2K0ZHGQ6jfU8ag0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723022044; c=relaxed/simple;
	bh=emCO2YeOsb1zqYxVRrE9GtSYYrVOrjmpBBAN3Zw/91U=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ZWN6t5myYMWYACxzOLL+PTonZeUJSQWQzMuFcSkN+Knnnudnkt/zOOT7QpE3Fyf+No2fMWqDDTtVWN9xHXz8eBnOVkC0UrQoDEGW+xHbb6hCPEsmJo4E7lwasstf5EOqeN4H8zyHcAgOHPQO3eLtDGmzHIwLZHyH0luZQdUFWOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-81f959826ccso207250739f.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 02:14:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723022042; x=1723626842;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RCr0Gck4DNCSSN2TmN+6tNkJA2GFfNHbokmXJ6SaAhM=;
        b=RYoDZq7vcKToXthL/SfeAjaWUdMJwqw2KEWM/wyRNSaGB/7d97tlo+oSNRTqqmvAPz
         oT9J4ExgOKU0Uu3+Cc7VzQ0cgl7mSR3eNuaL5uR3jJcufXrNGPvYBG0FsZOMudthkAep
         HYyqRwEv245uPDa2LnDG23HJjQhpp6kWzcEgsrTotN9bdJxKLR4dzj/lerEHHLdLo8pM
         PbUjF70oVXaxvpO8J+M+AtaNG7//UpJQp/hOB/iHSkt4jsDfzqSYQEDS2GzvAeRLYIEl
         IaepIi7+y8jGxCHjfXPJm9ymimngy+ay8bZTtL7+Q3ul3Do1K/gSU1RdWPpiNrgu8YjY
         /Lnw==
X-Forwarded-Encrypted: i=1; AJvYcCWWwMIznK4fLbE7xCsOeN9CiGfOZENhkgONU2FOOms9lxCW0iFNwyEzE6XbInpiineEU4qslgIbh0y1lan3UFH1kwZ7XKMRL6dlOH7u
X-Gm-Message-State: AOJu0YxCCPEy/7GttAPw1Rl/lxz6mkB4se4EtQflP55AOqCJneVCWW0q
	rPzCKZruiH+an7i1CdcZSHxHt6MTYwuhsNBaVZ3v76MyWesgEXggTreyxBY8iHtEeZcWeSXPsMB
	UWLU/spBQTw0cnJpyAEMQ3f500BboHeGjYbFIF+8chmKRYsMJCw9HQgQ=
X-Google-Smtp-Source: AGHT+IFPGH7ElEWP2b5cCRgp65H0g77s36OvjdzrYStYNsGQ1sEx7MmrtdAly9bjUaIXpRGF+Thu7nr4Y92YGP1oxzNOYH7Hqa7g
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:410b:b0:4c0:9a3e:c264 with SMTP id
 8926c6da1cb9f-4c8d560a101mr702024173.2.1723022042504; Wed, 07 Aug 2024
 02:14:02 -0700 (PDT)
Date: Wed, 07 Aug 2024 02:14:02 -0700
In-Reply-To: <tencent_EF9E7E1BB84BDC1B3825FFBA27BBE0333908@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c8a982061f1454e2@google.com>
Subject: Re: [syzbot] [can?] WARNING: refcount bug in j1939_session_put
From: syzbot <syzbot+ad601904231505ad6617@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+ad601904231505ad6617@syzkaller.appspotmail.com
Tested-by: syzbot+ad601904231505ad6617@syzkaller.appspotmail.com

Tested on:

commit:         d4560686 Merge tag 'for_linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17569f75980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e8a2eef9745ade09
dashboard link: https://syzkaller.appspot.com/bug?extid=ad601904231505ad6617
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

