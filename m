Return-Path: <linux-kernel+bounces-175634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 73DD78C22E8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 13:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D812B21933
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 11:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B062816DEAA;
	Fri, 10 May 2024 11:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J0XX3asb"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F20921340
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 11:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715339577; cv=none; b=BuhANcljtxXyl3u+K+AjGdNTbPcK0pkJgY7vGeOXbFWk+WD67mo8LW2NhH/qH3Sh0FLZcTPe8wspOe6Llu0Hng/+UyiUSZ7cej9yw4eL0hEyZRGSJYTf3ZrHRD1UlqEuGRBzklpj2ze8jetZITVCzUKTker+n83dipZx+2sclP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715339577; c=relaxed/simple;
	bh=p6m3l1R31R082uYhqQ+dWpTZbipscGtH242yObQA5iI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MBKladZ+PCJCq3D+oekyspzNxjROMr3vSeUpIb2CbyMgM0Y0r5T6DxzmOiWR5jTh7QUm7USqU5XDjFNW3JsVPOLQPXW39OxhBUgiXA6aQU7cwxj8p1W08WSs2IoTUBQpkWgY4ci5Nz0mjFg1URaR9BBcXbO8HGcB8imc9DYyUJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J0XX3asb; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-41fd5dc0480so9782325e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 04:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715339574; x=1715944374; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=PZq2UDOGo/lTFgWTebUCehGZqrSS7VfO9csjzP2Ciio=;
        b=J0XX3asb5yDC5peJMPVoE7rgO1ILvZMnsjcj9BjEY5Elt2Ck2c5LVRnMMst2+Wm5LQ
         hZ3qu65vI01Fym27qm+HAKPcHdpWNIIUersu4HLjt/e4touGzI4Yp6LLPizfD+ZmWUeg
         lIvzUbX753hTFIgBJjenMiyh1BSSlGz6CMDPnivo0dllmnK+Pf0eob945QNhzMsmGkJy
         0PWwvXrVzfOCswAMywF2DgmfgUnhuZyTtkSNE8QcJtHfyt6tP7N8pgjNPKdh04Vlgp2c
         bscaiyqBcl4o/P5y3UtkxNiHM5ENBok5f2tOKUv80WgV2lh4T4hrCIn67VZqQsgP4kfw
         Tvvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715339574; x=1715944374;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PZq2UDOGo/lTFgWTebUCehGZqrSS7VfO9csjzP2Ciio=;
        b=Bwvh1l5WP+HSg7ea6lk9+dI6lgb8KTNKOClM4BKDP2TNJV668TdMj5MbCNCMNMzrNn
         D2Exxkv2DgbzrlVmB0X2WOorghWRRNRh3z/3raJz76QDb8gtdtHXZB6YUEsbS2CUqsih
         WGS/owUKa6ProjJoH5PciVzFKLozwzXauPeGUUgZbPm+StYsM4LXvfb8rgO4isjky0DM
         wVCoz3XsSmIEgIrwCr5bnDk+KIlNAlPUnwwApgSUwnDtZc0BhFHf248fxwa361yUdur6
         CRy6f/GISOJ6BZvAHSI9Ly+3MtDK1j7EPLQ4XdLou2GTPIv+tLfL0eeieij7iKFZwTyy
         e3Pw==
X-Gm-Message-State: AOJu0Yzek1Ie3QjJazoSouPagpg5cSILCDLJvgaLd0RrNtmZCQGuWPn0
	TS85nLvUCKLL7xQEOuuh9DhBMhfgJwlo/w7B56O5pJPgVbcMYESI
X-Google-Smtp-Source: AGHT+IFDi0bM4Q+CWopew03Q7DXNDMpMHY+tiqJAaZJUrSe/TWic1FRrkVDnijcj8PJXdJohm9VxgA==
X-Received: by 2002:a05:600c:19c8:b0:41a:41c8:d8e7 with SMTP id 5b1f17b1804b1-41feaa2f3cfmr17056035e9.3.1715339573193;
        Fri, 10 May 2024 04:12:53 -0700 (PDT)
Received: from gmail.com (1F2EF402.unconfigured.pool.telekom.hu. [31.46.244.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41f882085dbsm95267525e9.41.2024.05.10.04.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 04:12:52 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Fri, 10 May 2024 13:12:49 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: [GIT PULL] timer fix
Message-ID: <Zj4BMV2Cf9s0X/mn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull the latest timers/urgent Git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-2024-05-10

   # HEAD: d7ad05c86e2191bd66e5b62fca8da53c4a53484f timers/migration: Prevent out of bounds access on failure

Fix possible (but unlikely) out-of-bounds access in
the timer migration per-CPU-init code.

 Thanks,

	Ingo

------------------>
Levi Yun (1):
      timers/migration: Prevent out of bounds access on failure


 kernel/time/timer_migration.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index ccba875d2234..84413114db5c 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -1596,7 +1596,7 @@ static int tmigr_setup_groups(unsigned int cpu, unsigned int node)
 
 	} while (i < tmigr_hierarchy_levels);
 
-	do {
+	while (i > 0) {
 		group = stack[--i];
 
 		if (err < 0) {
@@ -1645,7 +1645,7 @@ static int tmigr_setup_groups(unsigned int cpu, unsigned int node)
 				tmigr_connect_child_parent(child, group);
 			}
 		}
-	} while (i > 0);
+	}
 
 	kfree(stack);
 

