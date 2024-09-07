Return-Path: <linux-kernel+bounces-319731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8D097017C
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 12:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B21EF1C218C3
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 10:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D22A1494A5;
	Sat,  7 Sep 2024 10:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=felix.moessbauer@siemens.com header.b="QEfHz9QM"
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16173266AB
	for <linux-kernel@vger.kernel.org>; Sat,  7 Sep 2024 10:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725703341; cv=none; b=h3PNYC8TYWXg9tFHWKW3sR9Ca5Syy/MtGXgZCg2Kueq7ArxO4kWe2SfEtnrIOxF1NokuDCnRWw3ZXOPzRKyzX6qX81CnlROf5/Vo6LfjBX7ZHvdo/000Ril7LtWJuDCQUUgc5I5Vjz01QW053naynVbBg4DHnRy7C1zDHQATXes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725703341; c=relaxed/simple;
	bh=ygaw0iQ4if0wmh1A0SwqpkKterIPJAxl9O47aPadSIQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=n0LY41Ts+8cyrkwa3X6sDhJmBUTTKfJVNw/+hEZvhuLPLyXfkAklsMZiqE6jogM04IH6IlM/Tk4JtSGQ+cv6hbb2h4mru5nqNfc3xCCmajGrZrpJwSCTM+L4IPsRqFBTd3ZsCH+OjmfGuPga0uaOhg1F8y06prtGdxsVW7YI0bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=felix.moessbauer@siemens.com header.b=QEfHz9QM; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 2024090710021172baf84a4c86961e12
        for <linux-kernel@vger.kernel.org>;
        Sat, 07 Sep 2024 12:02:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=j2hxCV9kxaihF+Ww53ZONcD+/QxZDY7mdYu0UHPKwF0=;
 b=QEfHz9QMNiD7l4xIijjcV9SgTpO5UQ6olrY7RM9AHfSawPrGpaj6zbUsP/LP5z3XPPtvLJ
 +H2f3NxFf3TD1cs0JHXcqrsxGRrMFTIu0fdvPnQmW6+grvWL2j6uZdGH6xjsCy0VGNHrPuyj
 66vthWheVhh8mMUrWVaBsmYdwxR/COpwAshIrPehiOA8a4DGdGKtLgzfV7HqnUr2jupsUyKl
 BAnO3azFORybLfsacE7c38M0Bp9Keir4HHIeRck+ZDgbvz1/YgY+htgl84IRf9xiHMXfJNHa
 5i2Mr1lYNj40DLg8RQoedkFjwn1YJD7M57Kb3xxaJcNmUsAjkCp2N+5w==;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: axboe@kernel.dk
Cc: asml.silence@gmail.com,
	linux-kernel@vger.kernel.org,
	io-uring@vger.kernel.org,
	cgroups@vger.kernel.org,
	dqminh@cloudflare.com,
	longman@redhat.com,
	adriaan.schmidt@siemens.com,
	florian.bezdeka@siemens.com,
	stable@vger.kernel.org,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [PATCH v3 1/1] io_uring/sqpoll: inherit cpumask of creating process
Date: Sat,  7 Sep 2024 12:02:04 +0200
Message-Id: <20240907100204.28609-1-felix.moessbauer@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1321639:519-21489:flowmailer

The submit queue polling threads are userland threads that just never
exit to the userland. In case the creating task is part of a cgroup
with the cpuset controller enabled, the poller should also stay within
that cpuset. This also holds, as the poller belongs to the same cgroup
as the task that started it.

With the current implementation, a process can "break out" of the
defined cpuset by creating sq pollers consuming CPU time on other CPUs,
which is especially problematic for realtime applications.

Part of this problem was fixed in a5fc1441 by dropping the
PF_NO_SETAFFINITY flag, but this only becomes effective after the first
modification of the cpuset (i.e. the pollers cpuset is correct after the
first update of the enclosing cgroups cpuset).

By inheriting the cpuset of the creating tasks, we ensure that the
poller is created with a cpumask that is a subset of the cgroups mask.
Inheriting the creators cpumask is reasonable, as other userland tasks
also inherit the mask.

Fixes: 37d1e2e3642e ("io_uring: move SQPOLL thread io-wq forked worker")
Cc: stable@vger.kernel.org # 6.1+
Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
Changes since v2:

- in v2 I accidentally sent the backport of this patch for v6.1. Will
  resend that once this one is accepted. Anyways, now we know that this
  also works on a v6.1 kernel.

Changes since v1:

- do not set poller thread cpuset in non-pinning case, as the default is already
  correct (the mask is inherited from the parent).
- Remove incorrect term "kernel thread" from the commit message

I tested this without pinning, explicit pinning of the parent task and
non-all cgroup cpusets (and all combinations).

Best regards,
Felix Moessbauer
Siemens AG

 io_uring/sqpoll.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/io_uring/sqpoll.c b/io_uring/sqpoll.c
index 3b50dc9586d1..713be7c29388 100644
--- a/io_uring/sqpoll.c
+++ b/io_uring/sqpoll.c
@@ -289,7 +289,6 @@ static int io_sq_thread(void *data)
 	if (sqd->sq_cpu != -1) {
 		set_cpus_allowed_ptr(current, cpumask_of(sqd->sq_cpu));
 	} else {
-		set_cpus_allowed_ptr(current, cpu_online_mask);
 		sqd->sq_cpu = raw_smp_processor_id();
 	}
 
-- 
2.39.2


