Return-Path: <linux-kernel+bounces-443801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B86139EFBF3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 19:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79B9A28C847
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 18:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB231898EA;
	Thu, 12 Dec 2024 18:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aLvTrWfB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B6017AE1C
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 18:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734029913; cv=none; b=Z03X5ec9UGcaPm/RGnUs3DJP/2k/0fnQu0WbZr/BFC06UPU1fit0WgxsRp4LJa16Ozwk0N+I7+lGs47tJx+/JDusNiv8rtfzKkXxb+SfgkJCPZ53h4mFEWSN0D8T9xJhqj+/K1BZ/qXL/Pj6Q4dGeHSB1TLoJpyQT5C6kbmyVfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734029913; c=relaxed/simple;
	bh=eSrak851tLU99jlnsjs6QVnnCugJAxR9PXoVZJmC7NQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bvqnIhwkYlqGVK0YvbZ5+vHV51cGDNz9cT4CC8PF82KmeCzopHXPSf0SaBoUjx1UfyAt8AUJBG8AMqdwXoUxPozkH2UW1TdtN6U5vv7rWODRUe+WyooPCOeDiDOGzqwU7+nKPSPjsIVK5GeMnQnI7A0UDvH4n27ux/4GuHhkCMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aLvTrWfB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B531C4CECE;
	Thu, 12 Dec 2024 18:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734029912;
	bh=eSrak851tLU99jlnsjs6QVnnCugJAxR9PXoVZJmC7NQ=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=aLvTrWfBrVNB8Wg5wMAWyfsEfaer/jj+gQneN9XdSPXE5xL/YVwjTNz83UYnJnPLQ
	 UuQkDR4MSuYlfx3yg6wvpWyFLF/LU0EcD5QdKr2tOZGWJDz+RvEtEaKr55HFW0WKet
	 CIpUKoGAOmXiEOiuKUcUe2aCMQaFmDCiUC6zRw1zn+PpRNFKGI+D05Jh+GYxR8BKFm
	 98PjRT/hMBOS+SJQD18AZtsaq2e0oGwXiirnTfnnoGofoqGom32QO9OHp7+oFU4Nlq
	 CHr4dzFGXWhe/AOW9Z3LFdxx0o75o3N8SufEXssD94kFkgkEnEqZpwmpOu1NZJ0u25
	 709ftscYPXa6w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 3AA6CCE0808; Thu, 12 Dec 2024 10:58:32 -0800 (PST)
Date: Thu, 12 Dec 2024 10:58:32 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: neeraj.upadhyay@kernel.org, tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org, riel@surriel.com
Subject: [PATCH locking/csd-lock] make CSD lock debug tunables writable in
 /sys
Message-ID: <1bb69e82-af7c-4805-bd93-11c454261a47@paulmck-laptop>
Reply-To: paulmck@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Currently the CSD lock tunables can only be set at boot time in the
kernel commandline, but the way these variables are used means there
is really no reason not to tune them at runtime through /sys.

Make the CSD lock debug tunables tunable through /sys.

Signed-off-by: Rik van Riel <riel@surriel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/smp.c b/kernel/smp.c
index 27dc31a146a35..a33e575f97ab9 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -170,9 +170,9 @@ static DEFINE_PER_CPU(smp_call_func_t, cur_csd_func);
 static DEFINE_PER_CPU(void *, cur_csd_info);
 
 static ulong csd_lock_timeout = 5000;  /* CSD lock timeout in milliseconds. */
-module_param(csd_lock_timeout, ulong, 0444);
+module_param(csd_lock_timeout, ulong, 0644);
 static int panic_on_ipistall;  /* CSD panic timeout in milliseconds, 300000 for five minutes. */
-module_param(panic_on_ipistall, int, 0444);
+module_param(panic_on_ipistall, int, 0644);
 
 static atomic_t csd_bug_count = ATOMIC_INIT(0);
 

