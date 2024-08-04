Return-Path: <linux-kernel+bounces-273660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE7F946BF3
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 04:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32A5E2820E0
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 02:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B302E4405;
	Sun,  4 Aug 2024 02:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZjoytfX"
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863933D76
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 02:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722739254; cv=none; b=p1fQjWVC3Usw/vKAfD+H/HwscylnbmKkF2WWaOQpPrgKW1AaQ6ACHfzbzxtRP9acV7aseR0xn6VDobtu1/AelcPTbbdCyf0QORn2vHspMOkkN0JSAspyuJSOWV6WOkjpRdIL8/Lr1s43X2BbAKnStoUmk2C7qrqG3ZBJWlljAME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722739254; c=relaxed/simple;
	bh=AkLBJuSDjhH3kXStspZuYmDnw1qb3FoyeYFSQQuGc34=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cb6xK4HvfenEoss1H3M4G9ALIRyfFnpbMoDgVv3IV59QZdsjC8PJvn2GY7XADML1N8oXiwF+1aF6b6IV676O98g6+r0Lu0MtLaVhT877kysxrkbcDCXgaUDksZ+4LDi/g/YfpKG2dLwaUNlrnbALgAVlhsa2FGQWQ/0D0/8aRbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AZjoytfX; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3db18102406so6569275b6e.1
        for <linux-kernel@vger.kernel.org>; Sat, 03 Aug 2024 19:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722739251; x=1723344051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=7lWcHly6QVTr9M/r478+ddW2UpE3bBkYbNxSgAo1Ik8=;
        b=AZjoytfXDQgxzPB8YXnWsweaETrBnmlta81l0i8Lq3OX+nVIX4xTqHIfKLI6ylFf9G
         zqVN6G9dQaJCRnjGqEBbbUaPEKt7aw8pA9B34jCWcpaDUMnJ2WNIY7ZYHx29L4khRjFE
         I7jdr6wVn/FqncSbS6SuKDJOp+dzgud8USr53/adPaAjZh4wIul4bZO5vA9C5xIBdTbu
         E5O5TEHcQIfqXvJ1fjXr5deFbBlMbLSVNF3pijGNLMZFbLgasKo0jYNWNtlpPYdvBS8a
         L5dpfvr3IHr50lofmuX72REI0GggcSiAMdlCwd3BqXhU1yFWnup5ryVHWOGp4M7z1vhD
         4VsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722739251; x=1723344051;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7lWcHly6QVTr9M/r478+ddW2UpE3bBkYbNxSgAo1Ik8=;
        b=Wamn+H/nsTRHJyi0LaMrCnM0G5hnWDAQml7fqoygo3r3bXMRAMMGTVtWjecO1V4x8k
         gHTsIr3rcrWJj1ksb9ymnL/1gIvYue2HnNE2mGzJhUKZaI7ciDVfbBbkPLcgbcUf+6BU
         aQQXtYlrjDIGYL2D62cvTRCcQOFmiNtdCvwVUETbIteWH0s2Gb4Q6UhKTAagfwIUNSgq
         L5yyg86Qou38fMXSXk0EUasnxOk3Ui417BOMQbS+DCn+hx5hqQNrUz0qxKmAPjNhlFA4
         VsID/fXV+CaRZrdW3qc+eBiF+aBeTYaVOcvppDnAW9yYXxLdGCPCHl//MZ3iOvf8aw5h
         8Tow==
X-Gm-Message-State: AOJu0YwWfKYveEp+Z/Qk58ZqMUBC5FrGQWe85F4tHyo1i7bvuUZUGXBB
	Oz8Lhy1DBC7/8s/19RWG+DQ5uv+cNJMNScKRxWSJh0FzXmqzcp92
X-Google-Smtp-Source: AGHT+IGUucXhk7aStIub9r1/a35ZOiGtEI8cYl9CMhogzjqfqWrjQIuxNkk9vHNtX6WWYiNxSvHPpQ==
X-Received: by 2002:a05:6808:1481:b0:3d9:509f:221 with SMTP id 5614622812f47-3db557f86c7mr10228412b6e.7.1722739251349;
        Sat, 03 Aug 2024 19:40:51 -0700 (PDT)
Received: from localhost (dhcp-72-235-129-167.hawaiiantel.net. [72.235.129.167])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff58f53416sm42093505ad.101.2024.08.03.19.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Aug 2024 19:40:50 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com,
	peterz@infradead.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	mingo@redhat.com
Subject: [PATCHSET sched_ext/for-6.12] sched_ext: Misc updates
Date: Sat,  3 Aug 2024 16:40:07 -1000
Message-ID: <20240804024047.100355-1-tj@kernel.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Misc updates mostly implementing Peter's feedbacks from the following
thread:

 http://lkml.kernel.org/r/20240723163358.GM26750@noisy.programming.kicks-ass.net

This patchset contains the following patches:

 0001-sched_ext-Simplify-scx_can_stop_tick-invocation-in-s.patch
 0002-sched_ext-Add-scx_enabled-test-to-start_class-promot.patch
 0003-sched_ext-Use-update_curr_common-in-update_curr_scx.patch
 0004-sched_ext-Simplify-UP-support-by-enabling-sched_clas.patch
 0005-sched_ext-Improve-comment-on-idle_sched_class-except.patch
 0006-sched_ext-Make-task_can_run_on_remote_rq-use-common-.patch

and is also available in the following git branch:

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git scx-misc-updates

 kernel/sched/core.c  |   14 ++++------
 kernel/sched/ext.c   |  101 +++++++++++++++++++++++++++++++------------------------------------------
 kernel/sched/sched.h |   20 +++++++++++++-
 3 files changed, 69 insertions(+), 66 deletions(-)

--
tejun


