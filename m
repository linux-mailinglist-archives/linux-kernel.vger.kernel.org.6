Return-Path: <linux-kernel+bounces-527769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F241DA40F41
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 15:27:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 489E23A0F8B
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 14:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7B2204F85;
	Sun, 23 Feb 2025 14:27:06 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503AF163
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 14:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740320825; cv=none; b=ArptA9/4Ukwb4ZW11yEZGvtAvqZIXI6mrSAhqQGzdWKFHyEMOUBtz5hpFq5rsGTY6Qjp4I55T9MtcsCKsBYYCBKXB5hDpx4qrYNoC21s/dMtAHMbgCHMJvamBc9YlUOC3wHZgHN4dZKW8++pRaht7TtIRVziVzbbLjgxQXES4XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740320825; c=relaxed/simple;
	bh=q3wpTlGlciLSP/UVECGCoTzbLNXbxK+PewMz/NWOwik=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ARTidn4M7Wsvg1Ipu3xJT//Jsj2vB2GikpzLBYJjsp1yORYZCw13zAVcavh3m0/ti3H7cmb444/VI1aHB5waiJaMxdbBtL5Xc4cg7bJ5WP9HhnCWUJ84/i9lCEC/IGuwcyuiZQmHaaVzJA1XDCn5S6M6dG0W3HFOhpisJ+INxdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-849d26dd331so339366839f.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 06:27:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740320823; x=1740925623;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qnqzAn6nHAo2ArwrLdRnw67mOrbL3ryXc9yqew7UnMU=;
        b=u9O76dFWWg0BNA8K5izE1ujOusN3aIrsT/7yxNwMqMmlVcEMccGqIk/A7cdXWWPUvS
         tWkgLttjWAPGOemJiHCBl3wcBWyaZneRF+AkfivAcywOE88nhkA3E080y8FpSXPsPBYA
         w+G7+8GXx3JUd6VJkkHL7gGk8YiqCss3y48gbh91KYI1G5z6AySvt/0H3TiKvanH7lJR
         OUvVvR8kIsELcGZyWTR0Wz08nsRt4TmqXuq1OXpACujElEmOH0AyOeUWBihJXBYLDHsL
         zICU5yl8PXPvv0Ku1rYrTvNvOPOy8jP12RX7NKOBXoJmk0gLNJ8TwcLc6RujG8vcuea3
         RWKw==
X-Forwarded-Encrypted: i=1; AJvYcCUwTTcAZFW1Z7J3uutDHEQiiW4GRxUYAYpUL8GBtq/e6+UgzeY/HYbbJo9N7mOgjV3UHuK1hiUAJURPsfk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwSU2qTY0qfr6VjMDoIRd0n3ya1vTqNhBfu2hoq7bJXF5oijKR
	GzZpsNVQnFrb3qU4ilGQtbvVm/edbxtmugHZ1L5U8mxQvtE6+WBA5CaIAepT1iBI1G0zZjZS6am
	SCx9MvMumk1akVfWZmYuJwt0Hr/+NskeO7SJg6GzcRDeAj+KstDT+xBo=
X-Google-Smtp-Source: AGHT+IHRQxwuGw4RpPC4oKTrZhzhuvWnjgLHG0Lpa6rAvERvT+LkDxJhkCLq9HDHonVAfpz2pSYnS3UI5XueChnKz6dxCKfNz8L4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:d108:0:b0:3d2:a4f9:e117 with SMTP id
 e9e14a558f8ab-3d2c00bcab9mr128426445ab.4.1740320823438; Sun, 23 Feb 2025
 06:27:03 -0800 (PST)
Date: Sun, 23 Feb 2025 06:27:03 -0800
In-Reply-To: <tencent_610D8DA5A60DA31253DD9D5DA59909CFA807@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67bb3037.050a0220.bbfd1.0028.GAE@google.com>
Subject: Re: [syzbot] [input?] [usb?] KASAN: slab-use-after-free Read in steam_input_open
From: syzbot <syzbot+0154da2d403396b2bd59@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

drivers/hid/hid-steam.c:1090:136: error: 'input' undeclared (first use in this function); did you mean 'iput'?


Tested on:

commit:         c749f058 USB: core: Add eUSB2 descriptor and parsing i..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
kernel config:  https://syzkaller.appspot.com/x/.config?x=f429368eda610a89
dashboard link: https://syzkaller.appspot.com/bug?extid=0154da2d403396b2bd59
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=147acdb0580000


