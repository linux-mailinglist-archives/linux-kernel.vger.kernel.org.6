Return-Path: <linux-kernel+bounces-276040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B05948D9B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 13:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDAFA1F233B4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 11:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE371C2325;
	Tue,  6 Aug 2024 11:25:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5211BE860
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 11:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722943505; cv=none; b=gQLvOfJujzdCH/1t0h+HHyep2Y368m7h0U1vdUyr1chcpKOry5o3NnYC+x7fhSYUrArDpN0XxVzeeLh0odtN0yCQS0lNEow0A6Cg5m4M6y57/aZ7mqoRZ7MpsTxxU4fY7A4Pj3RCifC5JScjA2MdhTT2cItCx9mVlbN9D8mwEaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722943505; c=relaxed/simple;
	bh=6L6/GAzLQO87eGts9A62XkImFZ+QV04iAlBbFPhel00=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=bT83u8pgYab7ZUxDifsVRIE1qMTYexrE8QhsZoym3Ew5+MsXQNvGVFNLGvyhKmPZI7Jdb46r7GzL0eLg8U5OKUhLGke9CqDBpWE0/OzZXlL1Ei8iod8HW1Y1ZuMeGQL8DuCkH96KwH4JtNzqO4CElD73tpTZdE1moZ651jTde3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-39b28ea6f37so8942905ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 04:25:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722943503; x=1723548303;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dPLs6GYpISNHA6KRlDwrxff6K+pIg+ZZS8gje1aRwOY=;
        b=nXFJvUJ6fe9yh8mFCsA8vrpUWPxDjJWGF9WG173PQtACfPYFBrRuAVblZj2wM/m+d1
         1UdpBeLyC3IsQeFZCWAZwLsRriHIvhYPGQNkNVDOgsjVTYfZKiaJiSTMmvY1s2MqkSVm
         eQMPk8LAlwUouxCpmut4+7/JLz88sTWtcTBvjElrdYgyxCZ/BFig2seiwcRgh0Jx1Tg4
         BB2b9a20ej8wltpdM8kr2AXH/DbIxPWMliim3K5kV4xc513pLLNJ20H2l+CeTADUpVCg
         iVaNV5FJADhZ+9OJIFcZ65wWmjP8FZsZaK/yc2XuJK7xhcB1FS43fMA89HcglUZcbmc/
         F1JA==
X-Forwarded-Encrypted: i=1; AJvYcCW7sDl5OFtQfkiTmSSaz/PEQbQRVf0Jhug5uNHoGn1HE3NoplG1D/1E7zx26Hu/VoQpmFCTBEND3+DXKJEEiehxv2AcEnceaGKtMnie
X-Gm-Message-State: AOJu0YyhiW+5GaDNWKX5RcVRW1Dppc+etOIKapWzlIsbG8JodkDJWfTi
	brkUI/CR11OhHvWMbvzzXvcoJ5q44s+sKFPCcb5kCAN1INyDs9ZMawEG7/fRHIqpwN4l9N7JW+2
	O/fAw4xktr2OzFIxn3PGT2jyj9CAkyJBLluLr6OqG1lo5nNwHbj076ys=
X-Google-Smtp-Source: AGHT+IEZt7rdkBD85PZ0nZRBlQzTDNhoiY+L84sEiWNWCgeL3woPw+d8x7EMi+93A+95D4zjA1Uoe9XXkWQnY7W569QyxGHHhQls
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d0b:b0:396:ec3b:df65 with SMTP id
 e9e14a558f8ab-39b1fc356damr10323505ab.4.1722943502677; Tue, 06 Aug 2024
 04:25:02 -0700 (PDT)
Date: Tue, 06 Aug 2024 04:25:02 -0700
In-Reply-To: <20240806105106.2667-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000720d29061f020b8a@google.com>
Subject: Re: [syzbot] [can?] WARNING: refcount bug in j1939_xtp_rx_cts
From: syzbot <syzbot+5a1281566cc25c9881e0@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+5a1281566cc25c9881e0@syzkaller.appspotmail.com
Tested-by: syzbot+5a1281566cc25c9881e0@syzkaller.appspotmail.com

Tested on:

commit:         743ff021 ethtool: Don't check for NULL info in prepare..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1482bd73980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5efb917b1462a973
dashboard link: https://syzkaller.appspot.com/bug?extid=5a1281566cc25c9881e0
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=156bf061980000

Note: testing is done by a robot and is best-effort only.

