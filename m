Return-Path: <linux-kernel+bounces-268348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B97294237E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 01:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B5C61F2135D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 23:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E84A194096;
	Tue, 30 Jul 2024 23:40:06 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808DF18CC03
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 23:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722382805; cv=none; b=WyZu/MCzcuqO30GEDNZEM9JxdPC2vg3lEbCfWRuvwSlo2Y/hDzdS0Jf4EogVBZVG88RDiZnuTRK7yEQJ2qaBB7KFfX4fmvZZDdI6hX9s2+X2onM9Gi8Ab0bQVEln0UnD28O5N1N6dTd+wBrngs0a07VGB2bs4D/LrVda0gaJitA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722382805; c=relaxed/simple;
	bh=qWHahIrU9s8hD6ixIvASedZ4uS6lL1bze8Qu2NgIga8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=QAHhAYs8u3IIu7htYopxnHaoiOrdasRLZT9d3LzxX9HTyxh/lQTF57dg4T4Y2ewkaRFYmTLN/glFdsJjZeyZRVyvk9EdqrDD65yRm+S7I4Qy8jL60z/q68xMQWdBpoU/TIZNJE25CSV7aDGtAsGdWuXTmXyk/vYcrpaoLjae4pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-81f93601444so728122039f.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 16:40:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722382803; x=1722987603;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4OM0SWDGxNX5ZKlmle8TNH0xupqwI1FtyPAFrQ5g2Rs=;
        b=ALvHnG9wjaYOydVlQmU+Dit5sldNKdUV8YlP5KuroNf7uB4JBbbWEijodl3RVmqppd
         W/9XolJux701ZFkGtBPCB5iPC7gyd0HzZj3CKFLftiFSOf3wJkMznuC/TZqY3m6EedWM
         fQZfgSC187piEAMvAVU2W3n/46CKzJvsxaIjsHf1qJvH31J42HQTgJ/8cxIpjN6k0WzV
         nFAamzWlVfX1J2IlZhwZiAyE9oO6fUmvsX0KSGtoDN61oparHHfsA4hikRUgwnc2JzlD
         XYq3QTnwIzFR8zEUzrWlj3PdnCHn14cWMYfZuxMxslaagyiCj+d/2Wpuy9CwGCMwXlCn
         53ew==
X-Forwarded-Encrypted: i=1; AJvYcCWs/eKODyOfeMg+sO70w85O0muVECgIaPhE0uk7Mop1rRmMP9ejlBtwpDCGDdL1q4Q0HNHppSncVjE7GNI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmdCjGsvMUvWQqu3Y7vS+iIOdvOjzQCZGWKCh10Ric8l6OcKNU
	AKIyuNtbzvE06x+jj50LvoRPthsND/OrqMHk8dsDvjqOXjFuo8TKPSd4UV/xsdc8czeudxzBW7i
	sjLEb6PJGhGHtqFkY0lCfSJ1mqDsKjVNRv8/ebTq4Z71sNnQwFT/yS/s=
X-Google-Smtp-Source: AGHT+IHEvTA8mA4kvk1vVi7iR1nbzle4LC2nRZcngqaqrqlCxqUasoLD0R8YiG6s47i3e0hSFMoejJVdV7tk2KD/CoPaAdyXPF2V
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1587:b0:81f:c103:3e70 with SMTP id
 ca18e2360f4ac-81fc10340fbmr4175039f.4.1722382803710; Tue, 30 Jul 2024
 16:40:03 -0700 (PDT)
Date: Tue, 30 Jul 2024 16:40:03 -0700
In-Reply-To: <20240730230549.255753-1-cam.alvarez.i@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002ec5b9061e7f7fb0@google.com>
Subject: Re: [syzbot] [input?] [usb?] KASAN: slab-out-of-bounds Read in cougar_report_fixup
From: syzbot <syzbot+24c0361074799d02c452@syzkaller.appspotmail.com>
To: cam.alvarez.i@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+24c0361074799d02c452@syzkaller.appspotmail.com
Tested-by: syzbot+24c0361074799d02c452@syzkaller.appspotmail.com

Tested on:

commit:         1722389b Merge tag 'net-6.11-rc1' of git://git.kernel...
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=12f10303980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e3044dca4d5f6dbe
dashboard link: https://syzkaller.appspot.com/bug?extid=24c0361074799d02c452
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10e19b03980000

Note: testing is done by a robot and is best-effort only.

