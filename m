Return-Path: <linux-kernel+bounces-284148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8875F94FD91
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 08:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2ECFC1F2390E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 06:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7691F383BF;
	Tue, 13 Aug 2024 06:06:19 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CEF364A4
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 06:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723529179; cv=none; b=YPmoL9tOsJA0sc+oeM1LBH1wbhXfduHngrgR9xWPAqTnUJKhoOUS1HSwR3rcScS6iPaQdSQVib5iaw030QU8YiwThqCE2NU0Yg72CjEN2LV9LYcPYWEg8Dupe5b0aekQHZoyMsWvMySZ45226AX5amxauyhxvMuNJxumj9Q27Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723529179; c=relaxed/simple;
	bh=etD6T0ZunzHX1hraq49sK2iAV+AHL79C0uiUZ/z0k/A=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=UTiawZdaL4TgQbA8YcGIyQmgFoifiMjQiKKHzD+n30+2HlVBIeSmDuxCPJHToMO5sGLDQ5b5DENFgmbu+vKCwC76K6uCP5c5JngAlzyGXF3dpTOKwhDkXPEfdFim9stdmqfprPEmWWcm2YJJ1xnjk8zhzO6VlAOF4AppOf+V8f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39b3dc8cdcbso76557395ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 23:06:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723529177; x=1724133977;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=etD6T0ZunzHX1hraq49sK2iAV+AHL79C0uiUZ/z0k/A=;
        b=Mmrw1jc+n9XvxL1AoyJesx3eQ8u94oft5+OuJXAnYFo4EbrkzCRc92NALnsAw6+739
         ebSGxlmb3t5lag2rEYjjK0vyeAupOXYsTaCIIiyKShq0/viBrfBO1NAD0h9FFEi8h/Cx
         phyM0v3j+iXJ5KiJfwJS8SIeo3cdjAyD7ujs6UKId1pEHHmj+GWsLjOertqDc50aCf46
         fGyJ4QF1o8DsUL7ApE/Xpaws1YiK43TMn9qlKbtU4g4/q7jciRrWiuE4cLD8nGWzoHUC
         NW7Bqfx4QF1Rgu7HgBJUCkMoTZt6oQ0AQj1N++BklCfusQtdvo0x/kDTTleKK15EdVho
         lA7Q==
X-Gm-Message-State: AOJu0YzG8u+WxRJ/GAcUy577GhBcedMkSbClUfncXRW7JXNsuRjzP1cQ
	+TqaYPGLnoCmlZ2BvzbuUuThl+7CLX7XlH5ryZOfipotpB1ZPA3tWMBOSBEBtHuDuVT8k9GrxZc
	m4UoIkNrPr+lOlVXBy2A777J0kB4pY5m/HyEUElSYqQ3DALA/RTfbZC8=
X-Google-Smtp-Source: AGHT+IGFzWhYbDYLnV4YBN1jgbJ7nvp1mVEIZC7MFQkSJ89PTYsa2TOswHMjynyagBex6sMDGZ7HbHE7i/ztDEv554BaBiEsQJ7q
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:18ca:b0:39a:e909:29f6 with SMTP id
 e9e14a558f8ab-39c476a3da8mr1704045ab.0.1723529176774; Mon, 12 Aug 2024
 23:06:16 -0700 (PDT)
Date: Mon, 12 Aug 2024 23:06:16 -0700
In-Reply-To: <0000000000004475f6061f548a43@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000578c25061f8a6877@google.com>
Subject: Re: [syzbot] Re: [syzbot] [usb?] possible deadlock in
 __flush_workqueue (2)
From: syzbot <syzbot+e528c9aad0fb5383ec83@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [usb?] possible deadlock in __flush_workqueue (2)
Author: eli.billauer@gmail.com

#syz dup: [syzbot] [bluetooth?] possible deadlock in touch_wq_lockdep_map


