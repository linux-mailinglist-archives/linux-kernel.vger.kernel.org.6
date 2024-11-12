Return-Path: <linux-kernel+bounces-405166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6690C9C4DBE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 05:31:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AC371F24EE5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 04:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BDE6208996;
	Tue, 12 Nov 2024 04:31:09 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B26719D8AD
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 04:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731385869; cv=none; b=tMtDFferGdltqAzs3AAXEbS3BqysdGrVOqsJhokftAsil+QEhSU7rPBnWgwgDKsIPvRhxUEJKFQv8jXkeDy1pUOlP6xykkOE159AmNKLDVbVv7vOW3L+JUHDQMzrq/bt6ksx6j+QVtDemD1sX1usC3YyeSELmPqMRmRGasy5AR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731385869; c=relaxed/simple;
	bh=UXtpxBefUNr3VcIYNI9rVjNQrYCyWHXXzZkWnLQ35Tc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=PMB0BgCRZ9ZLI/Cnk3inLCfmm9ZwI2szKVdmoeOdTPY3Gjr2rpdecOWQqoSS8MQ2wj+xyxvEAO6sN5Qn/7wwdAfAmB6b7dgoQUrEXxaa1piItlXp55cWcnHD3fz+FW94Hd7TWJbjWgNA4fjScJa/5oqxbEnhI10kH+EzP/sbBU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-83ab4cadf05so586939739f.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 20:31:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731385867; x=1731990667;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=57INWnZiq0HfAnj9yObF5CBGSGscztNUCHjuo+6K0KI=;
        b=YljbfbBKr1iZfUnAa10kAVFVDgp5Zv7xC7DtQrD4HY7GubGkwagmqZM0U4RuUeM6ux
         2lVH002xQNnoaGYvqL11xDCYSuc2Kk0mtvg/unR1GtF+SExg24Z9nzrZsukABlkCma1/
         9MdnRI6Hl9SJfXq7xNBc2Mq+8eMuAZVFQuvgulCASmrEcIdH6HlJki1Bn2x7BiO34pmX
         6c2JJdn1/H1vjl4pQhHhfvQRon/YZKdkAowFx6DLjVKDeuSryVdQtwC5vyATX6KC0DXM
         YVGtuUaK6khZrtXSzPgRayv2zSeCMmIUEGn2subBtdMXlfEbWfmAXpqnupVSDiyNxp9F
         psSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQWFXJyrG5KBcu9LN+5bx704KffjGMbitMTMXT9JSBnDnIR0ahJpu4T0GQaBxI49r01WnowVucMtGXTZw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoVipPC40QO7CZM7BOK6Jrfu3In7U/K7j/n9ZcNBr20ExN1mcL
	6Pyj6gS8MKo3OsFUymgfj37LCOLWIIyVBb82YOPWzGEs0DlKKxAZ7Dy5/aWF2COIJdWappta9ff
	0Z+Ig8pzItApZYhFA/u5kLnrh2qb5YMSSbZyfQ4vHYArc8AYta8or6Fk=
X-Google-Smtp-Source: AGHT+IFFUDjXKPivqzf1Tpm1sYMybaBdZY0FjaiXxICZysfVPEn6SL2GpDXPpaOREbFWte39HRrYxumuNBSVZgs5bBmZdVwHU/rz
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1908:b0:3a4:ebfa:2ac7 with SMTP id
 e9e14a558f8ab-3a6f1a0a674mr158303905ab.12.1731385866731; Mon, 11 Nov 2024
 20:31:06 -0800 (PST)
Date: Mon, 11 Nov 2024 20:31:06 -0800
In-Reply-To: <20241112002134.2003089-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6732da0a.050a0220.5088e.0005.GAE@google.com>
Subject: Re: [syzbot] [wpan?] [usb?] BUG: corrupted list in ieee802154_if_remove
From: syzbot <syzbot+985f827280dc3a6e7e92@syzkaller.appspotmail.com>
To: alex.aring@gmail.com, davem@davemloft.net, dmantipov@yandex.ru, 
	edumazet@google.com, horms@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-wpan@vger.kernel.org, lizhi.xu@windriver.com, miquel.raynal@bootlin.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, stefan@datenfreihafen.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+985f827280dc3a6e7e92@syzkaller.appspotmail.com
Tested-by: syzbot+985f827280dc3a6e7e92@syzkaller.appspotmail.com

Tested on:

commit:         2d5404ca Linux 6.12-rc7
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1608335f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1503500c6f615d24
dashboard link: https://syzkaller.appspot.com/bug?extid=985f827280dc3a6e7e92
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=109ed35f980000

Note: testing is done by a robot and is best-effort only.

