Return-Path: <linux-kernel+bounces-403667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C2B9C38D3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 08:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57D36B20521
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 07:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC8A155A30;
	Mon, 11 Nov 2024 07:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="mF7Rmlt3"
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8CD132103
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 07:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731308647; cv=none; b=gmxOagY43N5LyjXMui9bi5viS69uGxd41nmqrynBwLiiAdlJm61q3Z+270j1TxBDBcaP3vHc12y1cYq6F8boD685sZ0NW6B86sopjSNGuuF4kHqEICKD9TvtR3uv59PDaJgOLtALUkHlCCkGFT06QRz/FVXT21yWzjgDigXgmoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731308647; c=relaxed/simple;
	bh=h1Lp+74v5Gp0xfm8d1Kqc/OCw/eQjiZYqPWs4HmGNDY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rnO7eGPFz5cqDHP+dzdo5MHywTdhFaNc30/yHrfoeSk8BkwZimubuzFjjppJjUWCp+htjgpE2bhHLhlUs4KOARjEirbAmhdLhdfXrVdAQQ8y7QIWT0/E96hiHM4Jw/HlQhI4leuqotBlu6lRvuhlaOHdvw6/t8H1ODGm6r504ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=mF7Rmlt3; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1731308638; x=1731567838;
	bh=TPL79cIiJp3je7o1IBHWDuduVOSHunt1XT5WlRAkT2E=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=mF7Rmlt38j+DD24dC/ZUhCkebUPOeizLvfXr73JOt3fXwU9Of5+of5Km8AocdaN9z
	 8rygN3XvrukXN7+/x/kPp7YFNa0VzWJAk0Z0q1hV5bN4uK9uKlC/eSPJm2UKVPCBpU
	 TctteTJIhcXibXSn3xPjOBIFu+Y9QrkQXgcGe2IC0CON/WYsHiYkgpYWG4vLGn7U/J
	 uVjQOHbxMpLEyaduIetOxKuDkkdmomXpUAQSRadSxuBoRGoH8aiMy8zs0QJk508bDk
	 XNrZQyvusLKLYUIMCwUiCO48pOY7IqG2hSNqB0By72T/QMgc2SgFh9cMrOvUzTlttX
	 i5qXwmBnMEHVw==
Date: Mon, 11 Nov 2024 07:03:51 +0000
To: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>
From: "Michael C. Pratt" <mcpratt@pm.me>
Cc: "Michael C . Pratt" <mcpratt@pm.me>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH RESEND 2 1/1] sched/syscalls: Allow setting niceness using sched_param struct
Message-ID: <20241111070152.9781-2-mcpratt@pm.me>
In-Reply-To: <20241111070152.9781-1-mcpratt@pm.me>
References: <20241111070152.9781-1-mcpratt@pm.me>
Feedback-ID: 27397442:user:proton
X-Pm-Message-ID: cad3d90d2f5de12067301438db8b714478bcc4fe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

From userspace, spawning a new process with, for example,
posix_spawn(), only allows the user to work with
the scheduling priority value defined by POSIX
in the sched_param struct.

However, sched_setparam() and similar syscalls lead to
__sched_setscheduler() which rejects any new value
for the priority other than 0 for non-RT schedule classes,
a behavior that existed since Linux 2.6 or earlier.

Linux translates the usage of the sched_param struct
into it's own internal sched_attr struct during the syscall,
but the user currently has no way to manage the other values
within the sched_attr struct using only POSIX functions.

The only other way to adjust niceness when using posix_spawn()
would be to set the value after the process has started,
but this introduces the risk of the process being dead
before the syscall can set the priority afterward.

To resolve this, allow the use of the priority value
originally from the POSIX sched_param struct in order to
set the niceness value instead of rejecting the priority value.

Edit the sched_get_priority_*() POSIX syscalls
in order to reflect the range of values accepted.

Cc: stable@vger.kernel.org # Apply to kernel/sched/core.c
Signed-off-by: Michael C. Pratt <mcpratt@pm.me>
---
 kernel/sched/syscalls.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index 24f9f90b6574..43eb283e6281 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -785,6 +785,19 @@ static int _sched_setscheduler(struct task_struct *p, =
int policy,
 =09=09attr.sched_policy =3D policy;
 =09}
=20
+=09if (attr.sched_priority > MAX_PRIO-1)
+=09=09return -EINVAL;
+
+=09/*
+=09 * If priority is set for SCHED_NORMAL or SCHED_BATCH,
+=09 * set the niceness instead, but only for user calls.
+=09 */
+=09if (check && attr.sched_priority > MAX_RT_PRIO-1 &&
+=09   ((policy !=3D SETPARAM_POLICY && fair_policy(policy)) || fair_policy=
(p->policy))) {
+=09=09attr.sched_nice =3D PRIO_TO_NICE(attr.sched_priority);
+=09=09attr.sched_priority =3D 0;
+=09}
+
 =09return __sched_setscheduler(p, &attr, check, true);
 }
 /**
@@ -1532,9 +1545,11 @@ SYSCALL_DEFINE1(sched_get_priority_max, int, policy)
 =09case SCHED_RR:
 =09=09ret =3D MAX_RT_PRIO-1;
 =09=09break;
-=09case SCHED_DEADLINE:
 =09case SCHED_NORMAL:
 =09case SCHED_BATCH:
+=09=09ret =3D MAX_PRIO-1;
+=09=09break;
+=09case SCHED_DEADLINE:
 =09case SCHED_IDLE:
 =09case SCHED_EXT:
 =09=09ret =3D 0;
@@ -1560,9 +1575,11 @@ SYSCALL_DEFINE1(sched_get_priority_min, int, policy)
 =09case SCHED_RR:
 =09=09ret =3D 1;
 =09=09break;
-=09case SCHED_DEADLINE:
 =09case SCHED_NORMAL:
 =09case SCHED_BATCH:
+=09=09ret =3D MAX_RT_PRIO;
+=09=09break;
+=09case SCHED_DEADLINE:
 =09case SCHED_IDLE:
 =09case SCHED_EXT:
 =09=09ret =3D 0;

base-commit: 2d5404caa8c7bb5c4e0435f94b28834ae5456623
--=20
2.30.2



