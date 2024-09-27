Return-Path: <linux-kernel+bounces-341532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C221198814D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 11:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2C481C21C7E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 09:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65FF01BA88F;
	Fri, 27 Sep 2024 09:27:21 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB51249F5
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 09:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727429241; cv=none; b=EvTrn/42E7t4NDsL233g+k3GM6IlNMm5gpAUk2i3HQbMQN72SkBgOX+d6EPC+vY5wjExkaElLWCaWAIsnawiBruBjguTt99SP4ai69bfb+F9CLBoIAZiIgKWos1mm7HyBqxkTz3RLv7W7e0aqf70ZZcrYHeZEiCVFJFry8KxpHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727429241; c=relaxed/simple;
	bh=Z22YjYl95KgYVold/Ne8VNNI8GtMVCITmcNbFbYboB0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=F9W9QjJZnl8GRrejlSWdGQVda+bN7KBhx/cxv96F/hpttt/JFCx8WvXJ57CqNkGsf4egS4c03dSnZLRrC/nh+KIIsspQ5KThL+Et9+WgHofugoY8huHtkHqE76ZXHoTTc/WhFrD0oKSqkvZNipHV6Jsh69Nr6tVlTVazuwDkko0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a344da7987so10857895ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 02:27:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727429239; x=1728034039;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WnOIU+KyW2dDIrKPCNY0b+TWvJIRrdkQnVEP4SKBc0w=;
        b=MB/pdMuDM0TOw8imvbRDtNQCEYhHo8kPwWdAn7XFJ14MPpwpeLHcMJdyct3sbKzqXZ
         5oKmWk4Hctkpk+xk6x0USEqZvZNFuri4n5dw6Q+w3jH9xVqfF3bWatSWNgOVI3QG1D9g
         CmpleFMx25rJoSAtYvXqhks/3IKSiweosH5+XtP7pQUgSlfETUZXDGeSluflQJh3I1E4
         Dz2idVu2V4y3w7gT/GhrkSnbAaGjtKlk2gAbsN0cz32GmlF3/uxxmvaPQ0WqwgMZheBe
         P5IJnzhoeuIrSqUDiXXUazKg6OjhsQqtQSS/7aKSkIm4XET2+m073QwXzxgDMzPECQPf
         yCFA==
X-Gm-Message-State: AOJu0YyLIRLrZYsvp3MsxhPbH3nqicVpALfqshg3DM3IT2iMvAyYUFl4
	mttAafLKKZaj9XHzztIZQe/9Hb8Koa9GP2mGq4Ptg9ezxglAKyINdBTIUBR2CazS4kIRMXZ+qWm
	OeSwf3OefjHzBHPuqVVjOox0pSWCgMEECcVz/lVeV7Gg93XzyU4K8qvU=
X-Google-Smtp-Source: AGHT+IFkuvSjXmZ/cEz0dvDa4MaKH/oTXDi4YH6EAS83G0DtG6MHqZ6F68viHWT3qgE13/rrRpiGpv/RCnfii/Rv5o1jw7Kxbujn
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c56f:0:b0:3a0:5642:c78 with SMTP id
 e9e14a558f8ab-3a3451738c8mr24163115ab.15.1727429238940; Fri, 27 Sep 2024
 02:27:18 -0700 (PDT)
Date: Fri, 27 Sep 2024 02:27:18 -0700
In-Reply-To: <66eff723.050a0220.1b7b75.0000.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f67a76.050a0220.46d20.0014.GAE@google.com>
Subject: Re: [syzbot] Re: [keyrings?] [lsm?] [ext4?] possible deadlock in
 keyring_clear (2)
From: syzbot <syzbot+1b2d1134e0b675176a15@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [keyrings?] [lsm?] [ext4?] possible deadlock in keyring_clear (2)
Author: lizhi.xu@windriver.com

tmp no use nofs

#syz test

diff --git a/init/main.c b/init/main.c
index c4778edae797..7e08a69fc432 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1261,12 +1261,15 @@ int __init_or_module do_one_initcall(initcall_t fn)
 	int count = preempt_count();
 	char msgbuf[64];
 	int ret;
+	unsigned int nofs_flag;
 
 	if (initcall_blacklisted(fn))
 		return -EPERM;
 
 	do_trace_initcall_start(fn);
+	nofs_flag = memalloc_nofs_save();
 	ret = fn();
+	memalloc_nofs_restore(nofs_flag);
 	do_trace_initcall_finish(fn, ret);
 
 	msgbuf[0] = 0;

