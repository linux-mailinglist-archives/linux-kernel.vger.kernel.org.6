Return-Path: <linux-kernel+bounces-272774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFFAB9460C8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 17:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBDF81C216F6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 15:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7121537C1;
	Fri,  2 Aug 2024 15:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fis4Egpi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4742837A
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 15:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722613580; cv=none; b=GsRTWS2nMiAlChIY5AO6erq8d0FnYEzDWws4+lQP9urpUd9MTTIkJ1ivVYF/zTjsNAoxxFTuSYeFglXuQ/dj98GsFdrZ4FqO1e7eGiHX7UI22LuVaAIZBBJZA0+8RdnyV/7K55We9etroHUQXra8maeGiQMW6FwJywRaDmxWBMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722613580; c=relaxed/simple;
	bh=wu/zhjKY8+yKuGmCQ0dFEhh5AEYVsRws4e6U2BZc7DU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HT2wsrvSVv0Q6yZPXRX5+knKFYzSE9oiqIQN4IhHVX05jzgtxRlepk5iQdN4C1IuUJFD1IFvA/FF+jMWXUtC5WZ+y1rkAYhSiXD4sMgiEIkmA9zBRHvCu4orwbD1TwJPr016zqzoBzFBunhIDkuKJKYuK4RTqEZo8izlc3Q/Wpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fis4Egpi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56962C4AF0B;
	Fri,  2 Aug 2024 15:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722613580;
	bh=wu/zhjKY8+yKuGmCQ0dFEhh5AEYVsRws4e6U2BZc7DU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fis4Egpioj19AzzSD5qEkENsadf+v0dTZKLwbAHtgPzmjGk0yDPH5Vh646kJcZDCb
	 X6vESJFXD1JxM/9kFGPTaCvvTy4A7vrHzRoUvw7eqFb8cAjf+qp5RvlmBzU+XPJK+H
	 Aod5UVTcSOtApO6WBw8P354sz0ebSCMnyF2B2LP6zJ7HA3eeQ972JLJqKZaMZJ6C6b
	 XyYYw5SKvqj+BzhTrKEcmdIrlOjQX9GRMxTNfAae8IQMYYwSVEksGOA0BCcRwQDTzs
	 5gGV5zxWqk7l5i6RC98YLQ+OcEa9RYxGM+nKIRc8HlpFhfd1STwnPfk6GOLntBmuhM
	 V7YEtwyGSSg2w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 02E9CCE09DE; Fri,  2 Aug 2024 08:46:20 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	John Stultz <jstultz@google.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Feng Tang <feng.tang@intel.com>,
	Waiman Long <longman@redhat.com>,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
	x86@kernel.org,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 TSC and clocksource-watchdog updates for v6.12 2/5]  clocksource: Fix brown-bag boolean thinko in cs_watchdog_read()
Date: Fri,  2 Aug 2024 08:46:15 -0700
Message-Id: <20240802154618.4149953-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <dac058b2-68c7-4b9a-a428-afb2b4b03ea0@paulmck-laptop>
References: <dac058b2-68c7-4b9a-a428-afb2b4b03ea0@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current "nretries > 1 || nretries >= max_retries" check in
cs_watchdog_read() will always evaluate to true, and thus pr_warn(), if
nretries is greater than 1.  The intent is instead to never warn on the
first try, but otherwise warn if the successful retry was the last retry.

Therefore, change that "||" to "&&".

Reported-by: Borislav Petkov <bp@alien8.de>
Fixes: db3a34e17433 ("clocksource: Retry clock read if long delays detected")
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/time/clocksource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 9ca4e8d2a70f8..581cdbb538448 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -253,7 +253,7 @@ static enum wd_read_status cs_watchdog_read(struct clocksource *cs, u64 *csnow,
 
 		wd_delay = cycles_to_nsec_safe(watchdog, *wdnow, wd_end);
 		if (wd_delay <= WATCHDOG_MAX_SKEW) {
-			if (nretries > 1 || nretries >= max_retries) {
+			if (nretries > 1 && nretries >= max_retries) {
 				pr_warn("timekeeping watchdog on CPU%d: %s retried %d times before success\n",
 					smp_processor_id(), watchdog->name, nretries);
 			}
-- 
2.40.1


