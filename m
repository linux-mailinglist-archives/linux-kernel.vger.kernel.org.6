Return-Path: <linux-kernel+bounces-346266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77BEC98C20D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 17:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A99871C221E0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 15:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868E11CB31F;
	Tue,  1 Oct 2024 15:52:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F4F1C7B73
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 15:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727797925; cv=none; b=VrRNuJ9K9LwTULOeFxeoLF8T6IOHtMQPtT1dFE8tf6FmAOO6TRYNfVS23gJd2DPd5wEIS88IKDMAD5vZ4tGC1eDXCRaFZOYfkxN/4WcNHq6ymF3aNXya+TYe/z0ge0Gv0lEh5dhVSFG7zMy4dyfUBlZwEhQnFAmfToOgyQNfpKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727797925; c=relaxed/simple;
	bh=hLaGC1unzGRXv60Ntnixr0kWcN7sp3RmvbIHbphIIHs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=RjkuYLKO0j31SZlPpzTOrpLtwEYaG3WyLVT8dqIOp5acw/s6/of5fiuZyIM+3huKjfh2l0QBjyCWvuehlBT41aZqIOTHDb5t0mcI/0DvyVGWW3Tba1PXKkN+eGxdXr1HbzdY74S+Ho2vSJ0a/JTXJsOeL5ldPs9cA1PTTOIb2gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a342620f50so56374445ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 08:52:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727797923; x=1728402723;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=59SB+V8kGrCj4j9f0TQBf0du/i+6iY0rJlO9QAMoS3E=;
        b=PDwaKgvtl0rQ++dVpd9dkvtg+rUPccwyIswbsRFHGQzgXxKWYhh5ABXYMymH5T3/H+
         Ma4t0IHW3N5tOTKcInuKtt1eg8jrrs7NcXlFCCEHdBj9NUvB/11wpgeB07a9KGM04haw
         A/Nq7CcIUbznHM83lT8NEywiimtX+WOaP5j9pz2Dh++SBltz4ae7ihJ/zKQiYfuOWvau
         uCjLYa91YHsV+tftekJkmMh0oL1bF/YwCNbBpubDKdWhe0THINGOUArNiSex5URE18qr
         wOeIe34laytcwnHhKV4Pg3hCuxm3heQW4Mrfg5ezrXpVQ/2gfNW6qDYIPjA9rcrfv5YO
         6Sjw==
X-Forwarded-Encrypted: i=1; AJvYcCUNoN12SJfYOgpwiSeXF3L2JLEKOEaILFpiRmP4d6qP6x7Koc8hzJIs7Sh6qsHGb9SiOBdrKueVsDl/D/0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFGF0cAdDLYBBhB0v1DzQzdof8qOkatwKSnLM8surlcbTNoquP
	O1DCo5jsHVijyQCiMtmb8PVhPMeOcscnP8q96JgzMUXPUx0MG6glFnWMe+w5VcLncpAE0msgOJ4
	+T+Sqtn30QoRY2BK/auqgO9BG4YZcYkeitZYqYQsphaw/HbOcdGJFmZE=
X-Google-Smtp-Source: AGHT+IFdWoiNWcHPm7jFLXmcVI/1in0+qYG6NCF5Na0y45if1mwde/nXQrJqUMPRxxVtuBaXQSHmr3Z4XNxlNmZwjRmdIZxyiaEG
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c26e:0:b0:3a0:c820:c5f0 with SMTP id
 e9e14a558f8ab-3a3452bb9a8mr143447325ab.24.1727797923000; Tue, 01 Oct 2024
 08:52:03 -0700 (PDT)
Date: Tue, 01 Oct 2024 08:52:02 -0700
In-Reply-To: <CABBYNZJvjcnQm33Qn_ZbdPcrd2ZTF9jOQGJJcva35YigkfchAQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66fc1aa2.050a0220.f28ec.04b2.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] possible deadlock in rfcomm_sk_state_change
From: syzbot <syzbot+d7ce59b06b3eb14fd218@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+d7ce59b06b3eb14fd218@syzkaller.appspotmail.com
Tested-by: syzbot+d7ce59b06b3eb14fd218@syzkaller.appspotmail.com

Tested on:

commit:         e32cde8d Merge tag 'sched_ext-for-6.12-rc1-fixes-1' of..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12a33dd0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c9c87051d13eb9da
dashboard link: https://syzkaller.appspot.com/bug?extid=d7ce59b06b3eb14fd218
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=139c139f980000

Note: testing is done by a robot and is best-effort only.

