Return-Path: <linux-kernel+bounces-401861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C6A9C203B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 16:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C50591F2406C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 15:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A4920262D;
	Fri,  8 Nov 2024 15:19:07 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5D62003D5
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 15:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731079147; cv=none; b=hIqhcQ8+0xAK4okakhUshRGOMRAFjfbedLZea93vi+m519pFmivCzon7+3K3yGGp5ru1KTGInYefT7znZDDrw5No8C7pRdIYc6KpDZhntF+yD7YpnxYJ6Gab/dKCPCWipKYZaw6omYARoRJxUSPChSGgZzz275IeZT6YzgVFFtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731079147; c=relaxed/simple;
	bh=NTlSyeoD2+4EQKqu/2Gh4WGqdk3IDoK71aSW0ypZhJg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=TSnsuJFybuVkhmNucrBC6Zq52NFK1dCRy7XOa2pheZ6FJeAIgCGo7TUte1nr8MBproxotBsV8QHcsvqDwnVyN6sgFbwhkBTMqmcpLqGk/2e74QKjfjrKGUVF+fSglsKIe5IUuk8eOlkiwt45tetfFLEvjxJOlWLIv9l/uSyukn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-83ab3d46472so235625339f.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 07:19:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731079145; x=1731683945;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bo+njan6p1yRRIokQZvopQsTfBYUHrG3Vr76u9l3srg=;
        b=ine4JrxL06zM3LhAnRYEzwCWqbKKDaYD+KdWsoMM3ubey8a8d1rNeCXpcNltTb6bMi
         0m38Wbm0H+nAtnTetdAa7aCa2laK70sg9Y0u3jG7VUBEyoF2lHZdRSP4hAkt7YPxPOYF
         HNSAA9JDmIDb7bD/hj86LafN6+USxeW8IlrR/sAGpNMcoDQhHpf62hFe/aYkfYc+RkNS
         wOsSQJ3bWGRb7TilSy5iQ7NSLV+1wu5MP06BcfdKLN/IISe3DdmlYIdESU/mAMlTtIl0
         ylYUBxvEgdRKXUu6ikcqWOlLMoCFaLJDbes/LJQUUjIDX7bR4/iYZpW64aiHecpPhX5u
         hjXA==
X-Gm-Message-State: AOJu0YzZGJXcKZ0TQTxAK5s+lpTxHyWKmdD6rf1due+qfWgllfX8Q8r4
	lshQxGFRsnWsH6z5DMgrSmJLqz0HbPu+vXA7a/wfQNFZpGDS1hfhm48IjdPH14AwavhXceTkgeR
	mDstZf/Sy5WR78Du28GCb0qfbseyfzcM6bHZoTY6VMz+4szCjpzvM8BE=
X-Google-Smtp-Source: AGHT+IEKoS9Wb3KaLv0vzUXaqlOb4GGG8H0Mu8s/1eGI3S+mj+V6VvDG1tEi+vMhY1j8ITI0IJohiJOFZXGlmtQAE/g2itJ4fdns
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fc9:b0:3a0:9fd8:f70b with SMTP id
 e9e14a558f8ab-3a6f19a221cmr37673755ab.6.1731079144825; Fri, 08 Nov 2024
 07:19:04 -0800 (PST)
Date: Fri, 08 Nov 2024 07:19:04 -0800
In-Reply-To: <CAHiZj8innKODZYdJr0mV8CJrR_vk8VKw7Gf+wkoUYCp2Mq=v2g@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <672e2be8.050a0220.69fce.0019.GAE@google.com>
Subject: Re: [syzbot] [acpi?] [nvdimm?] KASAN: vmalloc-out-of-bounds Read in
 acpi_nfit_ctl (2)
From: syzbot <syzbot+7534f060ebda6b8b51b3@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, surajsonawane0215@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+7534f060ebda6b8b51b3@syzkaller.appspotmail.com
Tested-by: syzbot+7534f060ebda6b8b51b3@syzkaller.appspotmail.com

Tested on:

commit:         906bd684 Merge tag 'spi-fix-v6.12-rc6' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1207ee30580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=64aa0d9945bd5c1
dashboard link: https://syzkaller.appspot.com/bug?extid=7534f060ebda6b8b51b3
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=174220c0580000

Note: testing is done by a robot and is best-effort only.

