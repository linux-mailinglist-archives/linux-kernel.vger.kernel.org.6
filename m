Return-Path: <linux-kernel+bounces-186630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 349578CC69B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 20:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 664E01C21A5C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 18:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0419E146582;
	Wed, 22 May 2024 18:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EquQbhP7"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB302143C5B
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 18:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716404089; cv=none; b=c1QtN4pABYK6xyqnXdKVek2kp6rtLWI1Y5SS11jMxDLl5ZMqiOoHlZOOuLQ7VGFaaLnFK9cAxFaidU2zD2iO2V84x5c4/cp6FI7UVpGJeQDjvrAnOchyrDM5+iD8Ym4FCFPHDPgdCmA4RSXJeoP1PV8GkGZKe/0x0eESFgGV1dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716404089; c=relaxed/simple;
	bh=Vi9DFTwatCAsZzZscB9uKauVl3qhNxSUs3JBSABQJPo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GHrW98clHTThEYeJ8C7NA7pqFKMxnWoV8O+DBvcRlFGwOV947WHdKDQw++6G0neDF5HbgkhWuZvMHU9gEfV/I0cVABSelZIjIk7VhDM92aiUpNaNFJUcdu88k0l4MqHWtW1e9WdnoneweRfqV89OU7MFqr4vo0sI9+0UYXuuA8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EquQbhP7; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56e48d0a632so14471877a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 11:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716404086; x=1717008886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hNDn38cEa80EVnk6aX9NYeZhhjh+9i1BJ/R1mRMwIHY=;
        b=EquQbhP71b+2p/uuI5NN5ig6NhK2eeu0/HSQtP85HZko7yV+uR+ka1LqCAy66hUYE3
         JEYkfQ5Wmn/XYY+F+l3d7IFUuwdjKPE9E0Ym8/Td8c1uPoC7Uw496W+AtdAS675TTcAN
         aYWJ5HQKzRBITKjEeY1hSu06v+CQEf+mFiJ6L6Hf+qw1A8W7irhz2F+ONjUOP12mZJHq
         /p/aAiyoLPJdjebDoN56h0OM5/jWu/FVFuwXySLuf3lJ5bwGfjNhQfvAMeUWzRBVugRU
         qJq+3GDs9OTULBMHlL8yqLGnWjtZ7cpMFxSkkwe1R+h8YDEqpJeRPpJNmoQD6sQ+48s1
         l5OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716404086; x=1717008886;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hNDn38cEa80EVnk6aX9NYeZhhjh+9i1BJ/R1mRMwIHY=;
        b=ilDGopZjLks3hbeeI7GdgSj7yBXF9t/qtIj9082lEy4RaBujFE11ekRAVR2GVXC+2r
         +P2VMCcymqKJ2pWrK86Zg3GYF2EFvXaTCqc3mBfr0fv6Vsg1FDrsKa3O1Lheys/v+lCc
         P8PUjNAhIHHHNnf8EFrpgm5hX83MyyB529Pjbm96DXPHzGJGwR1flnwTb//S6OsnNZOP
         PwWjoDIxnLL9XAmrnxAf3FX/mECXoPKrNr5oFBrgYXf4wEIRhIm40ZHHK3zzROxFdH0t
         pI/eLAh6yF91Idya8gXXJ/YbZ/nTvz5BY9cIAsdat2PvxglEiEhS9rjha4FrDNBfunHW
         zUEg==
X-Forwarded-Encrypted: i=1; AJvYcCXJfubadKnkE3Yl/5alADnk1jbL9LG20CqRyUHU98lvNNJDqYTO4oDSoKY4wTGjg2I8kIbcNRe1scbCACoNd3B/0qH/b4QgNB2WU5ya
X-Gm-Message-State: AOJu0Yw+qMDHUldoP9pzlCLcOolFt6msg/1IM4lAIYHT4wnsRCeP6saM
	UBlPJsxHg6uOLBlQNJszsotMMvcEHn7mEWRS5w3/PYM2pkeLKj22
X-Google-Smtp-Source: AGHT+IHFhfdm8S8hnJxiL1+33zmX8kFcIX8huxUkbefY+/1cpVAZi1uwrF4Tx5K2sxB/NcCD8y3YRg==
X-Received: by 2002:a50:9ec9:0:b0:56e:7722:553 with SMTP id 4fb4d7f45d1cf-57832a3b8fdmr2743928a12.24.1716404085920;
        Wed, 22 May 2024 11:54:45 -0700 (PDT)
Received: from f.. (cst-prg-19-178.cust.vodafone.cz. [46.135.19.178])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733bea6a36sm18638275a12.12.2024.05.22.11.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 11:54:45 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: longman@redhat.com
Cc: peterz@infradead.org,
	mingo@redhat.com,
	will@kernel.org,
	boqun.feng@gmail.com,
	linux-kernel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] locking/rwsem: cpu_relax before re-reading owner in rwsem_spin_on_owner
Date: Wed, 22 May 2024 20:54:21 +0200
Message-ID: <20240522185421.424344-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function starts with establishing whether there is an owner it can
spin waiting on and proceeds to immediately do it again when entering
the loop, adding another lock word access and possibly an avoidable
cacheline bounce. Subsequent iterations don't have this problem.

The sound thing to do is to cpu_relax() first.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

This is a borderline cosmetic patch I did not bother benchmarking.
If you don't like it that's fine with me, I'm not going to fight for it.

Cheers.

 kernel/locking/rwsem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index c6d17aee4209..a6c5bb68920e 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -758,6 +758,8 @@ rwsem_spin_on_owner(struct rw_semaphore *sem)
 		return state;
 
 	for (;;) {
+		cpu_relax();
+
 		/*
 		 * When a waiting writer set the handoff flag, it may spin
 		 * on the owner as well. Once that writer acquires the lock,
@@ -784,8 +786,6 @@ rwsem_spin_on_owner(struct rw_semaphore *sem)
 			state = OWNER_NONSPINNABLE;
 			break;
 		}
-
-		cpu_relax();
 	}
 
 	return state;
-- 
2.39.2


