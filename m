Return-Path: <linux-kernel+bounces-231691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44EA4919C19
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 02:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01D582830D5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 00:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F7A5221;
	Thu, 27 Jun 2024 00:51:40 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3C64C9A
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 00:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719449500; cv=none; b=h9epp7zjY6uN4jz0rgKIBMhgOxXF2kyrSvP4HCdwKeV/NvnK0IQHKr+RsgSYlGQbousNIXckQY5WzorT9vs3mmOdNrhJjDX1fspx8HiNE9oNebTaIUrQjJGGkqtP6TLnKEsUu+mOCY6H/QYHkjboVPOLzDnALvC2hsZNSoYgbPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719449500; c=relaxed/simple;
	bh=vINZt9V0NXfDoxsYCTNbn+xHZ3z8ZKH7kGzyBgD28Lk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=GFS105dp+A1fdPdVnCKwwTcsIaawJ2vFrb9+XFhzwV4jou/AwTcfUfTV5vuWyVS/ZUxDhDn6R9N+/MhSD1XHO2cZ/GPXvxm3FDaiF9s9isS+qVT6bvAPtFvYilWP6ecFmrvFp9ebhppCw7vjH1PYJAkzdCOb/CCFAqdsCKOgKFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7f439f51960so22335339f.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 17:51:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719449497; x=1720054297;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vH6r4RfLDuG5fT7I6Hsco4u+FaIwHKXQ8MVkHJLPADs=;
        b=CWC9GU5ukIp11bESqusQD08D2ZZtSKIM4k9WzhP0CsoAulaCMzENZP6jeVA4BmtPLz
         OUrrZJWDcTD/rCcLApLDLXKfZXVOHnSrXFpqGhLmebcvxO4820s5ObFdDcg1/V0H4oNY
         0T9WyB22wBlTh+CFbfq/VC53CZ5xfResnLIDVq6cnLI68g+zWbz02roMMDMtkhlXKFlx
         Uyumw/eO90A/668qyw77oN8TIMd+eiijMzYKrmQFcP5Vwlkk9FEcabYa8f1oMoGE68Ha
         MvSf8RRQYKI16bO5avz1YReO0xMzA3hyKLmClsGI7AGUMbSFiuQz3eK9hC1GnlHDSUpx
         sZCQ==
X-Gm-Message-State: AOJu0YyGohBQGqa8DeDYXEwuL36lSbNtK1+zDeM56+60lpXT2zoIQVU9
	22D1Y5JpYFTpQ8IXjVZBxP0vKR4OAODcsanlIdLLSquGn0XrXPhroBoc68kO/uqf3gZuCHu74+3
	e8h+3TDoQVZCO+fzW45rMtuYV0Ik3Zy0PH2Wj5fUiLwIfYwAm5G4M2pA=
X-Google-Smtp-Source: AGHT+IEa3+8j7LExy1ujCo+1N08IILQqsc8oCJXRfr/T6W1TCd0KsZhSNWQJtg2Ltot48ABelWVe/UG6NbJKuKXDy9t4f+s7xmxz
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:154f:b0:7f3:9d18:8e7c with SMTP id
 ca18e2360f4ac-7f3a746d52fmr47164439f.1.1719449497660; Wed, 26 Jun 2024
 17:51:37 -0700 (PDT)
Date: Wed, 26 Jun 2024 17:51:37 -0700
In-Reply-To: <0000000000001f253b061bb8a953@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000847e34061bd48823@google.com>
Subject: Re: [syzbot] Re: [syzbot] [jfs?] INFO: task hung in txBegin
From: syzbot <syzbot+eda89a33c5856f66f823@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [jfs?] INFO: task hung in txBegin
Author: lizhi.xu@windriver.com

#syz test: upstream 50736169ecc8

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 92a5b8283528..0209ebe97e7f 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -2123,10 +2123,12 @@ static long wb_writeback(struct bdi_writeback *wb,
 			queue_io(wb, work, dirtied_before);
 			queued = true;
 		}
+		down_write(&work->sb->s_umount);
 		if (work->sb)
 			progress = writeback_sb_inodes(work->sb, wb, work);
 		else
 			progress = __writeback_inodes_wb(wb, work);
+		up_write(&work->sb->s_umount);
 		trace_writeback_written(wb, work);
 
 		/*

