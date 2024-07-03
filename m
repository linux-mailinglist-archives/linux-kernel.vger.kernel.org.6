Return-Path: <linux-kernel+bounces-239625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53EA992633B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 16:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 853B01C21505
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 14:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5D2173348;
	Wed,  3 Jul 2024 14:19:07 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3ECA1DFD1
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 14:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720016347; cv=none; b=KYUnsHWjhiLmZPljL32qGGNKVDEqde0q/7cs8/TH2b4KpLlkceB4OHBEcihN0Y+idGRw5w5rKspr15+S5x/OjIctvgTNmVLzDqx9YvBYoiror1T8BnbD565aTiEIz5xZdaUx3vqObseTTRju8i2U19hhA/6DhcgKLqc6Ligv6Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720016347; c=relaxed/simple;
	bh=q4eg6drIy6DH72j1NHP7S9Zo9qL2srIu4X1K16+Qr1U=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=F5oZjBbDAYc5Hm1idK9GLl9SC7+6DnNfyBzfgLeXTE9p7zLYbS0rq8RV+NOARN2W2eT2nMa9Z307MqcWx2bwtCke5loJ7SdAimm09qKe1iCLGmh2cONG2l9AgQf1H9Rr/ku8dFyqNbhe7YMX7an9ksL0+AmB3k7mkCGu2l4+KFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7f3d2d068abso614293839f.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 07:19:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720016345; x=1720621145;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O9q58miR8wIlfVuDVujDa22xj+USozsKkdWYY+PrYOU=;
        b=EavDdQs3ep7fPUp9a7c4Ef6tVqWCjwkop+pWXQYDj12IbaZXeUe/ysODdM/xh4x879
         6V1L41yvFpAslLdcjRJaU/Vw1XzX7kCtHThMIRgxl/Dd9NxUdxobK+Q2ex5RDzFSaBny
         /ql3HIgwoGrGKcJ/iU251Wehyf9Xrq30IAn7uZcdrvmbHYJ6V0dN/TJMXUv+P9wS6Vpv
         8U/soZ7t4oVz4hSHa8QwQCOJ5HiPOJAOo8pflApsDbdOnDRNBLkq5E1bAhfaSSS4ul68
         rnkpLlDM226m94C6Y358vxNSYEnTMMhq8B7ZvPYaCdjb3zR/Ye3MFgZVP6hWOAEycoKW
         w5Pg==
X-Forwarded-Encrypted: i=1; AJvYcCX1sJbo3xQlIiTULZZZqWleFcjcweD4eyfmmrMaA/resdNW+0YbZFY9AyQOddCyrYG7M24PE1YTch97fMI6/d+Ps8DNWbZ0OwoKn6e+
X-Gm-Message-State: AOJu0YyOvRMXCsHNRiNSAmGdDoV+0f96RrBAwM3wh+SS1k7QZ+FcM5uB
	m8C8NEeYGKC8A3KXdNN6WEW+I2KuitFoJqhdvrjuXY0fteKHmvLK8ETsfVtg35Koq26vI/cI8Qf
	7vJd2M1FRgl/xfqtrIHlceY8j0ML8GP666RjXo9Pd5q/xjGCQ9AN510o=
X-Google-Smtp-Source: AGHT+IGSKwQ++2S+hDwKbL7OdyRhG+SFIZi3UQZmgms0HpStCqPEyhpQM1b0mxFzk8N44ghqPmFc86f/ODZ0dVinjKts24g4zSxR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2c8f:b0:7f6:5c77:ce33 with SMTP id
 ca18e2360f4ac-7f65c77d27amr22157839f.0.1720016344823; Wed, 03 Jul 2024
 07:19:04 -0700 (PDT)
Date: Wed, 03 Jul 2024 07:19:04 -0700
In-Reply-To: <20240703134439.79904-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003dca20061c588300@google.com>
Subject: Re: [syzbot] [net?] possible deadlock in team_del_slave (3)
From: syzbot <syzbot+705c61d60b091ef42c04@syzkaller.appspotmail.com>
To: aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+705c61d60b091ef42c04@syzkaller.appspotmail.com

Tested on:

commit:         e9d22f7a Merge tag 'linux_kselftest-fixes-6.10-rc7' of..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16dbf4e1980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=864caee5f78cab51
dashboard link: https://syzkaller.appspot.com/bug?extid=705c61d60b091ef42c04
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16fc5485980000

Note: testing is done by a robot and is best-effort only.

