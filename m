Return-Path: <linux-kernel+bounces-349858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE62998FC4B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 04:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 814FF1F2243A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 02:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6426721340;
	Fri,  4 Oct 2024 02:26:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9914C18C08
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 02:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728008765; cv=none; b=pxj7AaM46KsXbWi3PXaDtWNjre2uHfGwKvSXe2XVmTshOBv25UHr05ESCybYoGQAn7j07BgLoXFAchUOCy0eu3qJ1/pxzt4vup4nLtTUIYGskI1gl8RNoZ9YIWk0fHA6MhWXlU6rCDDXy0QY1VnHC/mJXr2DuCfpNAArjK7tu2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728008765; c=relaxed/simple;
	bh=4HWecSz4M7EUkOXXBP9/ZooJcAR5jb16syVtiRjEbuE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=uVbGjv79WbghMhU6ISoom8hagjVTIDh/blJYIkd55+cvbjPUu6eHCNeXFvrAqBvPPJ2z2A8xwRUy357DnHwDe4i9xi/Xw+pb9Wf60MzXu9Rf1gcm6q6fD/Ph6vAWlzMU1Thx6odUCjPQmdLLOht+wz95S6Xrn3zK8yq9FjAR4/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-82cf147a566so147311839f.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 19:26:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728008763; x=1728613563;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b0TKGVjZnvG+gbyWukrboF5mMhpG4D08XO678TzzDo8=;
        b=CyuuZRTqa47TGjw+8TLspnSkPbTLxXcW/kTE3sr+UrB8SdYNlipnS2AS7cujVYHeKg
         SZHuE3Js0ZO7AM/cNJjpXBQim+10w2yh5pPoLwJk2rwj1dCbMJTYmJBGoWezdgNxAlUV
         /c2UZp92/vO3Ss7BkMF+p8sobXMNNlNUQEb4GBxKHSh0rXYAQgfXXNQhhXsUc73fwVfr
         hzm8CNidpSotcQV98R0zAAxlSzo3rFRYSjKwqB4I/OR8eDhj/T/sMT0axI3OtoOvEwDZ
         BB/Uv4LkzwmRjqKOSfrHCysT1NgjqysXRnKn+Ph93lB/kvs4BkLpfIi9xWHbjx8i02mX
         exBw==
X-Forwarded-Encrypted: i=1; AJvYcCUpTf6D/AW4ZlJ+9W4tw9W/vA4AUXZMfxXFYW/8cKcNInDKky/Cf65JG2CVnb3lwYQz7Xhyf+eM7NDIUbA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6OpN4nJ7k2uzq4ZguTa6ah0LIfstUQpDWVDe2vJm54+7uClFz
	YX+OanVKEBiOkoQgxiGWew/WDXXJIuxj8+n2JFJihUWS3Bxg3kpcb2O/t7wnnMSTXclgbKrstjl
	oxMsBBywhELViXOteqjjNvn8W42o7JACjXHkMGb3pxIsl1NAJgN4dUMQ=
X-Google-Smtp-Source: AGHT+IEDAq1L/9hrIQmAijk45oUjCKIMrvI/y9UrO5WjjEY5d2oTq1wpaIDF3b9kOodsAS2tymqxR4Uv1qQWjX4YOA7zaZ9iXeNT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca07:0:b0:3a3:6b20:5e33 with SMTP id
 e9e14a558f8ab-3a375a9b3a2mr8900805ab.12.1728008762724; Thu, 03 Oct 2024
 19:26:02 -0700 (PDT)
Date: Thu, 03 Oct 2024 19:26:02 -0700
In-Reply-To: <00000000000094740b0620b32b4e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66ff523a.050a0220.49194.0413.GAE@google.com>
Subject: Re: [syzbot] [net?] general protection fault in phy_start_cable_test_tdr
From: syzbot <syzbot+5cf270e2069645b6bd2c@syzkaller.appspotmail.com>
To: andrew@lunn.ch, christophe.leroy@csgroup.eu, davem@davemloft.net, 
	djahchankoike@gmail.com, eadavis@qq.com, edumazet@google.com, 
	florian.fainelli@broadcom.com, hkallweit1@gmail.com, kuba@kernel.org, 
	larysa.zaremba@intel.com, linux-kernel@vger.kernel.org, linux@armlinux.org.uk, 
	maxime.chevallier@bootlin.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit ad78337cb20c1a52781a7b329b1a747d91be3491
Author: Maxime Chevallier <maxime.chevallier@bootlin.com>
Date:   Tue Aug 27 09:23:13 2024 +0000

    net: ethtool: cable-test: Release RTNL when the PHY isn't found

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17bee307980000
start commit:   f9db28bb09f4 Merge branch 'net-redundant-judgments'
git tree:       net-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=df2f0ed7e30a639d
dashboard link: https://syzkaller.appspot.com/bug?extid=5cf270e2069645b6bd2c
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10542a33980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=178c6225980000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: net: ethtool: cable-test: Release RTNL when the PHY isn't found

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

