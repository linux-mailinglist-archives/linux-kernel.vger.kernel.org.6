Return-Path: <linux-kernel+bounces-211458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25FFF9051D9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 13:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAE1C289ADE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 11:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E28516F287;
	Wed, 12 Jun 2024 11:58:07 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3B316D4D3
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 11:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718193486; cv=none; b=d6RCHAxc+X2fXOiTAG8R53epzxmOqR5GOZHmGnw34onMdYi5alxmjXuFLEiW/NbZZnqs5jzQ2TOcTocxcmbfurc9nIPS907Q8YV75aJuxLsJcfObdfoiN+oU3648sF2ObfG0pjSEOXiPJmLe7g1dsia2GAOsQxeuF+i4ZPd+vJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718193486; c=relaxed/simple;
	bh=xS/63wRKaKU0Wayi9VDY0udyPi1iW5NI1/aIwAXJvsU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=lPsTUFpGjS2cQgu4xuZzx0nIhiGugrN+I2Sclc5f48ISXQqnPoFlw+BvpBQ39/ubjpK6nYlPrWyAtLgeCXtpGArtvIavyAapXpQkcU7nl8AjIbj8bokJRa/AgJP5r/IgQyDRPK75EE+G7ktNozF5Q1ddyAnGTXwIVCRuquD2bOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7eb7c3b8cf8so209610839f.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 04:58:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718193484; x=1718798284;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UH8qBVaCa01Ff20+nfDvD/vKdbSccNB2gSxFLitfNvs=;
        b=SjSc8aFMOEzrR+Nw87pKTnjgT1ioTPQkp6X8fTGHu399299XeoiLMy+RP3BHqpT8nY
         NATNHz8MQbLEj+uaqGksdyKjsp5D7Z82GP1nrw79lCbyKsfkUix97SymDsLy/RVdhhdF
         Wlhk2z1dG4EuJPYPY0Mq82OfUM6F4mQCxBF25eh/EIqko4yVZj2EBDQx77z6t3UJhiE+
         CbBeLzvNiL+5UolkJ5SwvR0QDOrWvLOplbVC/IBOou7mPL3IThjztkjkmEKFh98z9HJQ
         zQdcSOljFqb+CZaHXCID7/S45hji96G0kbJ96Ck5bqt4eGDOPSV45qFrN1PxzauoFmtg
         SuMg==
X-Forwarded-Encrypted: i=1; AJvYcCX/gw4ipXEU0hkURZcBJzk+xzT3SC59Z9rMS+uvaLeUcTPLIXK9bWTWTD80jckUSx6tXJMJHfZF6BS2HKugBTFHLAZLV59KLfDUsLmn
X-Gm-Message-State: AOJu0Ywq0sBw+C9rZFDHUExpV3XKiMHwBURUDZIbRijun4SlXMtecW3r
	dKhSmGmXBHYodV7k5GCKism2EdcTQoiLd5c4JDl5bCfTs5+Kr5Ot0HkPrwiDa/1wh58FQtQELZP
	ihfP8eUdS+Dzqu5RifztmrppocDVyXB4Aj197GuKurjwOS+D2cDkaDDc=
X-Google-Smtp-Source: AGHT+IEp6wv4wPlWMGiy5qWcoM5qf4ugebQ7KN7CLbQlyazwMsxHbasLnWDudlrb68LCCThNf880tiV2BUwsHUWHH4DUsSta8u+R
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6d0c:b0:7eb:8321:330c with SMTP id
 ca18e2360f4ac-7ebccfaa14cmr6903139f.0.1718193484381; Wed, 12 Jun 2024
 04:58:04 -0700 (PDT)
Date: Wed, 12 Jun 2024 04:58:04 -0700
In-Reply-To: <0000000000004f12bb061a9acf07@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004acf7b061ab01899@google.com>
Subject: Re: [syzbot] [mm?] general protection fault in dequeue_hugetlb_folio_nodemask
 (2)
From: syzbot <syzbot+569ed13f4054f271087b@syzkaller.appspotmail.com>
To: airlied@redhat.com, akpm@linux-foundation.org, kraxel@redhat.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, muchun.song@linux.dev, 
	osalvador@suse.de, syzkaller-bugs@googlegroups.com, vivek.kasireddy@intel.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 265a5cde9462d3a816b18c6cf4f0a231f1c29d1b
Author: Vivek Kasireddy <vivek.kasireddy@intel.com>
Date:   Thu Apr 11 06:59:43 2024 +0000

    udmabuf: pin the pages using memfd_pin_folios() API

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1617ab6a980000
start commit:   d35b2284e966 Add linux-next specific files for 20240607
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1517ab6a980000
console output: https://syzkaller.appspot.com/x/log.txt?x=1117ab6a980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d8bf5cd6bcca7343
dashboard link: https://syzkaller.appspot.com/bug?extid=569ed13f4054f271087b
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15eb5e86980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15db597e980000

Reported-by: syzbot+569ed13f4054f271087b@syzkaller.appspotmail.com
Fixes: 265a5cde9462 ("udmabuf: pin the pages using memfd_pin_folios() API")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

