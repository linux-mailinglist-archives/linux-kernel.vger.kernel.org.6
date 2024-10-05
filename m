Return-Path: <linux-kernel+bounces-351613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D5C9913A1
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 02:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEFBD2844E9
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 00:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF577482;
	Sat,  5 Oct 2024 00:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NfEZDphN"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E0A12B73
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 00:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728089586; cv=none; b=f11qpt6Q/61Ei2o+PYTflbUA6lec0yz64n5ank62ZhH1plNYkadMa08Al+uBRUc14r0YnJciJtdDY3XxFozmZvfwJpQmc7yGzQ7Q7aKz5ZDOt/XmfaQsgiFJeDJisS0nAl1htplQrH+uAwDE35UniEgvUPm6TVYxnazjv4tT8mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728089586; c=relaxed/simple;
	bh=xkOW6XsTzTN4ONbDbWeX/1R0hi1V6+d3T7AwHHnk0Zg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bItascSHU78RWr6CxYt8RWqjGeVtkyi2tcCA6XAyCaqh0uKLNtw9ofXEtraZBVytr2hnYu2su9JeJhLNG83WfVpHfyu5XBCEGIV0otAf/toeueSUTt+LLhrGoefHf2p2eRXS3s8Itcrh+r+DkSLpXLr5Sf4o2XpyIzdIijRkdss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NfEZDphN; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7e9b3693513so1117576a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 17:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728089584; x=1728694384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n59NEsbW/I5l6Bb8OXPiSeC2re5on9GOeJk8rKxyTUM=;
        b=NfEZDphNqQcdkPpv9Sv50+E1j3KuI9bUoZ/uMuQ04OWs3EP+xyhKoC4+Xr7yDhlHvf
         bZMnLQtcok1pA18oV9tKRSYS77qEn8bKbcTQ3i7K1zCyS4mvFFbBiDB0y7wb8FPdgudK
         XWISlJx91vrafyIFPHUHHM9r7ab4ouEZinthQ8hipOtAGgTX4cpGt3JvobJGQCuaobge
         QETSy+5iyMEB1t5SfMULrGs/t5LOGRuK1V2ESdeOvKDo0Z/YGWtpEQY5W+sZVHaesjcc
         4mw75aZv7MueaV5gzwVx+DDP2Y7vgXiqPajfio1x5Qnz18+L/BkFOzKRa1BQnrAL4Tok
         G5yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728089584; x=1728694384;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n59NEsbW/I5l6Bb8OXPiSeC2re5on9GOeJk8rKxyTUM=;
        b=eE14KFhr7Oeh3CBkRUjizEC4UYf28r+xj2rJs84pJt9XfYeXWKjA0VjEb1+5hLZxgB
         Fcq14cYbXjC0JCC6BWwftcsWv5wyah3kOzEmBHQfQMVHr42m2lU4LO5UgqDNvebFrd3T
         YU2iaYwL3Hey6lChx/BvlHf9vOfSo0XniTQAdO0N5ThTXnAsh/Pog0suL/s4aweJ7jP8
         8T1GOzw6s0DUjGZrYw1OJBijfIquH2lEf/lVN18ISz2kw9WdkdM35JYqEca0Hlct1PzB
         1TuB+YhFy015P3C5jcfH3swrPxfZWgpVrhdVxu8Cua1H6CuOTGXY1NULFx7sMChIuQrz
         KTQA==
X-Gm-Message-State: AOJu0YzZbB5i3OroeUlgx83ggl6FMpVFxMBiYc3sp43CwRdcBFeKWIuK
	Sh/xjj86vU7p/JoQ55sV8qpGcy1o7t6Ma17KzlrhYnxM5zKwbVPAEugRqfZO598=
X-Google-Smtp-Source: AGHT+IE2vl22qL2um/BNj+mcLS3m75QDtrlJtbM0r09/7rWN03xzc+Stu5VZBMptMAgdn+wb+p/+yw==
X-Received: by 2002:a05:6a21:1584:b0:1d6:97f2:5f72 with SMTP id adf61e73a8af0-1d6dfa279c8mr8064359637.3.1728089584442;
        Fri, 04 Oct 2024 17:53:04 -0700 (PDT)
Received: from localhost.localdomain (140-211-169-189-openstack.osuosl.org. [140.211.169.189])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e9f6c4ce83sm605009a12.91.2024.10.04.17.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 17:53:03 -0700 (PDT)
From: Zhouyi Zhou <zhouzhouyi@gmail.com>
To: linux-kernel@vger.kernel.org,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	bristot@redhat.com,
	vschneid@redhat.com
Cc: Zhouyi Zhou <zhouzhouyi@gmail.com>
Subject: [PATCH] sched: Fix typo of head comment of ___update_load_avg
Date: Sat,  5 Oct 2024 00:52:45 +0000
Message-Id: <20241005005245.829133-1-zhouzhouyi@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The head comment of ___update_load_avg illustrates the principle of
PELT divider. "unwanted oscillation in the range [1002..1024[" should
be "unwanted oscillation in the range [1002..1024]".

Fix above typo.

Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
---
 kernel/sched/pelt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index a9c65d97b3ca..565171fb2138 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -233,7 +233,7 @@ ___update_load_sum(u64 now, struct sched_avg *sa,
  * When syncing *_avg with *_sum, we must take into account the current
  * position in the PELT segment otherwise the remaining part of the segment
  * will be considered as idle time whereas it's not yet elapsed and this will
- * generate unwanted oscillation in the range [1002..1024[.
+ * generate unwanted oscillation in the range [1002..1024].
  *
  * The max value of *_sum varies with the position in the time segment and is
  * equals to :
-- 
2.34.1


