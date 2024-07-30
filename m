Return-Path: <linux-kernel+bounces-267434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9D2941170
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 14:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5F35286095
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 12:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5C519E804;
	Tue, 30 Jul 2024 12:02:34 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5361991CC
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 12:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722340953; cv=none; b=oANtBhpUJbQtNQOLrQkItjdW/FaJwI8VWr25/eeecEVrWqjNS/1vj+ZgDqiHG7szYajr68Gga0ictUKvZppctfeg39XxDl8rJvVrofp+lPWVMPukNgTTwrXEEZRi3R4Ar2XdHNyX7oP9G03NoqbqAk3n0mYZEH6cmf2lfYIE1Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722340953; c=relaxed/simple;
	bh=Dni9mzsdk3z8ttQfg40ozZbiPry1CG2bm0J6Cth08FY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=hSZmEwXGSlmTdWfP10QCunzSaLBcVaEPBOc+XQ/JEcOLZo2UtIQPyjBphJEw8Uoa0m3m/jRiRHPyOioAtP2JhvvApQCtJtcuPtBbdRUOJ5IF0bFrSPQZPcLMlr7mPQ08T0qUKyKVimXMe45kWhfyaLcbzIesTsF4UeELCNq2neQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-39a29e7099dso73079275ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 05:02:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722340950; x=1722945750;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7UVRLoW76axzmR9JNfwOSYbdYDTeDFhUwYH4fPWEeCE=;
        b=dxkIsKcnvdHYmRES1Q5gEI4y9hNNlI+K2+o5enZqNfoUAtesbuZNLz7+a96XcBexDr
         OkuCo+2KfuDulw3z7zH6ZZtzSZAE+mOligac3YHJktgsPC/7uctCog9z4W7O2G+OPu3B
         /A867HFBdHSNOZ86O2DOXaVWK+SgO5vHLApVvfwaQ5AoD4FUTaEihP1OCLhBTM+HYIAn
         CQUhhfVRLma+xUinCMsp/79JTeYnX5lAIRUlBuFUQL2D9XuPJTd+xTA6/1BTmaUgCsV5
         oW2l1i/sel6P3vKMTHTvgrxohc+/9lw08Ts64LesOaL7IxNhaW1dO31VHjswpy5Y6Mjc
         7dLg==
X-Gm-Message-State: AOJu0Yy9/5HbojpF4nYgffkqk507xJqmMa0zJ5608bgolXu9aPoFrsfu
	2XxnjkbEzklYb7JE58euVMpkERAXu8ypkLcvXS3srqAUV7m4MFMgFJ4os9q2baMtkyVZvNDtxbN
	0BUyA3wRqVRY/ognGINWn/CljhkUmZLr7zsFnFfMrQXJadIXlTTOaRtE=
X-Google-Smtp-Source: AGHT+IGKXo35uDYUI/+NR/jwpGWQ1PrLiKPEK55w3We/D34CGoHfZJQ6dson7ecbqGGyLoTYb2EweiRuqPpQBLoq7yrhBYCrwIBa
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b22:b0:397:35d4:3811 with SMTP id
 e9e14a558f8ab-39aec40159amr8959635ab.3.1722340950412; Tue, 30 Jul 2024
 05:02:30 -0700 (PDT)
Date: Tue, 30 Jul 2024 05:02:30 -0700
In-Reply-To: <0000000000004da3b0061808451e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000881e74061e75c047@google.com>
Subject: Re: [syzbot] Re: [syzbot] [net?] possible deadlock in
 team_device_event (3)
From: syzbot <syzbot+b668da2bc4cb9670bf58@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [net?] possible deadlock in team_device_event (3)
Author: aha310510@gmail.com

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

---
 drivers/net/team/team_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index ab1935a4aa2c..056889eff6b1 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -2947,7 +2947,7 @@ static void team_port_change_check(struct team_port *port, bool linkup)
 {
 	struct team *team = port->team;
 
-	mutex_lock(&team->lock);
+	mutex_lock_nested(&team->lock, 1);
 	__team_port_change_check(port, linkup);
 	mutex_unlock(&team->lock);
 }
--

