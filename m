Return-Path: <linux-kernel+bounces-442875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1466D9EE350
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 10:42:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7111165F42
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 09:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3CFE20FAB1;
	Thu, 12 Dec 2024 09:42:06 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CBC20E6FD
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 09:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733996526; cv=none; b=BNPgT5BXjHlwLz0J+3fMipHdkBHO1MFNKcpPXxewSvllH8xF+F81D/MTuDm9olmsM7gVKLmvzgI0Cn00CgYepr3ysAEXfFTRmHespnpBw74LgidrpRQSZ5/o4+hWfovdTPNYGWIly49Y6M5CwIQE3o8MBkSO4GM3x0DVI3jrGy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733996526; c=relaxed/simple;
	bh=OwYXylwfYH62gDE1vEppfvvoJhFrbItR9EK4tnFEe9A=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=A+RMkjED1C7G2lgyWqI5jvzA689Y3wbF6TR/eyhVgbK7/mXb9D70AjtHGc3ddEmjZLGQCGEzqEYk+FPL2ipdLAivOiw9rVxeHmDa6WYhsbob+jSSo124qpTMKdsj9kkwWeI3RRl3q32KzOAGZYmETQH9h/6e4e78P1S0DfI8nBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a812f562bbso8567405ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 01:42:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733996524; x=1734601324;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IoGw1IqN0FR0iMUViX1uqkkOZgTQLNI4d09xwAsG7gE=;
        b=ewlGd1JvBVE8HU0niv/Mu5jDxNs8tIoEgARK+IlQKH1m+EN3ohNn5b0vj5HKm6SyI+
         fLqYFkVuGS/tW/xvXTy11dbDEJKvRdZzTRsfxyyltCYV1HNplux7CHxvcEtsvrzpaRQx
         289OCKotprDn4ikxtL4MCPUBIV69OjzoZ2NJBiEvjIfHcMEZTijxP6/fhIdeZtBoTy7g
         Dz7X5uw6lHl6S+jkxf8jGVMTyzkL3/tT46dX8ufJqHLOycQxv8IruHdvHADwLyUpkDD1
         QBb8GVtbaFveQlE32MbD8xyLg+dfavi0GhSBGaj5b1QL8hETHpcQVBcwuktkkr/xHoyB
         +pEA==
X-Forwarded-Encrypted: i=1; AJvYcCXIDbZjfszHVlShjkuTTm54urVnD/bJTcAC+u0ltlHu1VIHnVZjtH9HbNJ4ND8HFJlauInnvtI43RSIx7I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5gBTto7377ESEUmXG0hrZkYxOishWMsCF0qI1/6bxpz8RwGJW
	5L48v2NpF6OyiapEUTqFnOXp7nXIYVLbg7si8zbNCTwhs8uyU46UWQerqW0oL3pZQexTP++jINu
	Q5t703SuzQFD10IaIhrw2+mfLXDUnjQP7nFgzCCvHTGd44EUjIDzeV/E=
X-Google-Smtp-Source: AGHT+IGg6LOgoMkIWV+xPyT2+bTdbaRhI7WxXVTs1zA9pXIMLOM7hYKFYPYRTtgK7PViQbQQuggyrBGX7QONdZoHIawLgpZqZFfr
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:19c7:b0:3a7:5cda:2769 with SMTP id
 e9e14a558f8ab-3ac48d9eda6mr27140315ab.12.1733996524016; Thu, 12 Dec 2024
 01:42:04 -0800 (PST)
Date: Thu, 12 Dec 2024 01:42:03 -0800
In-Reply-To: <20241212082232.rr5qK%dmantipov@yandex.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675aafeb.050a0220.20c8bc.0000.GAE@google.com>
Subject: Re: [syzbot] [hfs?] KMSAN: uninit-value in hfsplus_rename_cat
From: syzbot <syzbot+93f4402297a457fc6895@syzkaller.appspotmail.com>
To: dmantipov@yandex.ru, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+93f4402297a457fc6895@syzkaller.appspotmail.com
Tested-by: syzbot+93f4402297a457fc6895@syzkaller.appspotmail.com

Tested on:

commit:         231825b2 Revert "unicode: Don't special case ignorable..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1313ebe8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ff1d7fae8f4492d7
dashboard link: https://syzkaller.appspot.com/bug?extid=93f4402297a457fc6895
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12e3fb30580000

Note: testing is done by a robot and is best-effort only.

