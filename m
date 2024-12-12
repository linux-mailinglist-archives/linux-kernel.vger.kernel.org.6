Return-Path: <linux-kernel+bounces-443799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E548A9EFBEF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 19:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6C4728DABF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 18:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB001DE2AE;
	Thu, 12 Dec 2024 18:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XCGLIwQI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208D01DC74A
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 18:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734029781; cv=none; b=ZtMZERooWKKMUXlcM3+d5B8QrwOVQhaQK/6rBUb3Xfe9rnv1iR0p9mOMw2lMjjdSH0Y40CHBs2WYuFc0jHK5KOURCvScgAiC8VUqsvJlMah3aHokDKMeBCVK5azIYtMyld9R/0hbepigeI/kSXLoGrC7uvBcYhYGElTRI/TM5tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734029781; c=relaxed/simple;
	bh=Jb3qT4TmnZMP8uVZZjxg2Ed7PY7sXJzKKGv+4+3M3bQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Ui9O3xSSGQicCOiTRZE8nMsJ1VatXHDM6UclpyHHh55BjLC/2cfNY9OHfvfT0yz17pOAsn7LIO5MKvsUiklf2PkOoe0kJUFOGtyRI1hT6dKrDsx20YCSHXg7Wfjws1x1cfft/Ry5BlJ1aOyY8HT3xtTOQpBQLDrSBnVG99fLePU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XCGLIwQI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED7A8C4CECE;
	Thu, 12 Dec 2024 18:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734029781;
	bh=Jb3qT4TmnZMP8uVZZjxg2Ed7PY7sXJzKKGv+4+3M3bQ=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=XCGLIwQIRgQvOM1yafcjvY48m3anHZmTls7W07bVeT/Clp2qm5t6fSaDGDlZx1lXL
	 sHds5L/EPbS5Wqhbl8A/6hYIEavW7+x263EECHPkKy++LkRuxHsa9GqTlkTVJNWtjE
	 oxqudui9Sg3/TyKK77NFHL4V6gKFP0Ht6xzwawkRu2aDInyIImEQ+lprvXIlViRj+L
	 R74xmDoisaNyum5QxpOji6ZjdWwnQCF02LI1nkYPs/2mWqfIh2WClBfynaIzF6uJbt
	 R36RkCTqJbuzNgsuIBxnBOotGiHBYP8K7aT3bN93fP910LRY0x4eAK/yi6SwvMCH/G
	 J/Luqk7zEJuqg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 78DD0CE0808; Thu, 12 Dec 2024 10:56:20 -0800 (PST)
Date: Thu, 12 Dec 2024 10:56:20 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: jstultz@google.com, tglx@linutronix.de, sboyd@kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, riel@surriel.com
Subject: [PATCH clocksource-wdtest] Print time values for short udelay(1)
Message-ID: <717a2ddf-a80f-490b-aa3a-4e4b74fa56ca@paulmck-laptop>
Reply-To: paulmck@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

When a pair of clocksource reads separated by a udelay(1) claim less
than a full microsecond of elapsed time, print the measured delay as
part of the splat.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: John Stultz <jstultz@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Stephen Boyd <sboyd@kernel.org>

diff --git a/kernel/time/clocksource-wdtest.c b/kernel/time/clocksource-wdtest.c
index 62e73444ffe45..38dae590b29f5 100644
--- a/kernel/time/clocksource-wdtest.c
+++ b/kernel/time/clocksource-wdtest.c
@@ -137,7 +137,8 @@ static int wdtest_func(void *arg)
 	udelay(1);
 	j2 = clocksource_wdtest_ktime.read(&clocksource_wdtest_ktime);
 	pr_info("--- tsc-like times: %lu - %lu = %lu.\n", j2, j1, j2 - j1);
-	WARN_ON_ONCE(time_before(j2, j1 + NSEC_PER_USEC));
+	WARN_ONCE(time_before(j2, j1 + NSEC_PER_USEC),
+		  "Expected at least 1000ns, got %lu.\n", j2 - j1);
 
 	/* Verify tsc-like stability with various numbers of errors injected. */
 	max_retries = clocksource_get_max_watchdog_retry();

