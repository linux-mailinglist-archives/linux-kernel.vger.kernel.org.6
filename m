Return-Path: <linux-kernel+bounces-271481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2CC8944ECF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 17:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F5A6B239E7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 15:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B065213C3CD;
	Thu,  1 Aug 2024 15:11:08 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5E822064
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 15:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722525068; cv=none; b=C8ibB3oZa5qLjg93ejaV2Csn6IabqHqar/zSCNaRoh7lKBoLN7z26yDEoafojvSzQsvXPotNvUBdDT9tdB1fEuXv6iV9GhO9WC2L2qqZR0sZxEeB7OTI9F0XSW0EnQlS8O0crb54NXUQlCzXLCOTSXqT6fxG/bRrPMSpfqSp0nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722525068; c=relaxed/simple;
	bh=X0gV25enG43TJIbZzQE+1PQuve2gQDaP/sVqtao+vkQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=CHh53a2Ls3fsvPfYRYIeRqIrDSIG356QXm5ql644eSP8UsejKYX10yLMd8/0P5PJo6q80/wPOeEm4+JWB4dA6sjKsekl/a+o9QokonvLlkKOWUPZW7K18Yso7IJRUtNR5JfJgNtKfHVYC38ThFHKWFSsm6gP9QTo2LGCd/KbnhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-81f86fc9fdaso1027917039f.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 08:11:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722525066; x=1723129866;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CnQz1ISpSV5mSTinLI0vXUTO6lR97It81nLS1lNoxLM=;
        b=UIn3/UvI10r5l19IR8jgudZy7r2KS+k+xWPDc8wMr6NjszP78R/nhFDvRat1lWCVsW
         3NgBq5XUGtWYEtUHXsQixoNQhnHzX3xR+gVAoaUtnwRzsB36ucTS+JfCyvPdedEOeBML
         7P9nX6JAKkfeXMCkUFR2PHxptGnIBvwHhibVYRnhqcunV+ddtH5P52jin3A2qV8RSqQr
         Nh+1kQk9MvZIM6Ej8vifx1hpTeC6MofabfPmwpKQtyG7PqM8JCFAtK0FGTRDAjWGki9k
         gZiBFIX3SugTPXzYiJm/1tlFHhij65RWjCy+JVzt9Kciy0zBAVgycLpG8bPE8zPP9Gm6
         fQIw==
X-Gm-Message-State: AOJu0YwjhuJjhwn+ecshw5tInO6lQ0zOHCZRrJlrZmOlTLSP73V3CVZ9
	+4EHQfXa0VkPOtQnLf2lzvHyYvlrlXdzzkkL6vP/kFI2TrFJ/SWYa3xA+HZK5Lnbgdd1rZ6HBMg
	2XfAguojs6hnEJJ7BkVTP4u+xQXdl8CBLIMN7+/i2WHlqVtSG0tMR64k=
X-Google-Smtp-Source: AGHT+IEK2e6laXFKINXJWRxNPtSkXx4YZz7LiFK2NxUMW+jzfSBP3q3B1528OBso/TiCzof3wSN0tyodKZfiYSGVfXcCVadmdf47
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2cc9:b0:7fb:ff2b:5116 with SMTP id
 ca18e2360f4ac-81fd43edd24mr1616239f.4.1722525065939; Thu, 01 Aug 2024
 08:11:05 -0700 (PDT)
Date: Thu, 01 Aug 2024 08:11:05 -0700
In-Reply-To: <20240801143944.78059-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ac1d11061ea09e68@google.com>
Subject: Re: [syzbot] [squashfs?] KMSAN: uninit-value in pick_link
From: syzbot <syzbot+24ac24ff58dc5b0d26b9@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+24ac24ff58dc5b0d26b9@syzkaller.appspotmail.com
Tested-by: syzbot+24ac24ff58dc5b0d26b9@syzkaller.appspotmail.com

Tested on:

commit:         2f8c4f50 Merge tag 'auxdisplay-for-v6.11-tag1' of git:..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1121afad980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ea3a063e5f96c3d6
dashboard link: https://syzkaller.appspot.com/bug?extid=24ac24ff58dc5b0d26b9
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12f6f94b980000

Note: testing is done by a robot and is best-effort only.

