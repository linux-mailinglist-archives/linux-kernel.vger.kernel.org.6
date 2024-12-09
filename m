Return-Path: <linux-kernel+bounces-438131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 498C49E9D4B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 18:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC95C167023
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 17:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C457E15746E;
	Mon,  9 Dec 2024 17:44:46 +0000 (UTC)
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C80C14F9E2
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 17:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733766286; cv=none; b=qIZMmRMV2epqpDb4BfV2TOVT1GQhH4sShRmy5CuDit4Crw+DiMC/HyoogZHZPYG+FCnqZ3PJdF8hPph0FZqzBQWEteMcigSS/8AtixjcYAIY3rbTHX0vNQE/TnhWQD5xa9u5QUEfobTuRLJwlodznHI37Gm6MODVHscousjZfeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733766286; c=relaxed/simple;
	bh=h7YOfjTXOSvd3M250B43KWtjLtkwCt4pfx1H1CxFAW4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=QtY2DO6UWH5EgDLuf8gYqyyK6MasxuzgaxR5TnYjFVxa8obVK29rEtSFvubasqE7GPcFQPbGv0YsyrdsfLC01LXIEtUIIImfZl49S/k03FkVoMAysbNQCiSYk80tYETqhP5Qtj8T7hzffsP6rsxOb6OLTMVop/JCXz3mMmDsuJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from [2601:18c:9101:a8b6:82e7:cf5d:dfd9:50ef] (helo=fangorn)
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1tKhnn-0000000018A-2Cdt;
	Mon, 09 Dec 2024 12:44:11 -0500
Date: Mon, 9 Dec 2024 12:44:11 -0500
From: Rik van Riel <riel@surriel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 linux-kernel@vger.kernel.org, kernel-team@meta.com, Thomas Gleixner
 <tglx@linutronix.de>
Subject: [PATCH] locking/csd-lock: make CSD lock debug tunables writable  in
 /sys
Message-ID: <20241209124411.5b588faa@fangorn>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: riel@surriel.com

Currently the CSD lock tunables can only be set at boot time in the
kernel commandline, but the way these variables are used means there
is really no reason not to tune them at runtime through /sys.

Make the CSD lock debug tunables tunable through /sys.

Signed-off-by: Rik van Riel <riel@surriel.com>
---
 kernel/smp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/smp.c b/kernel/smp.c
index 27dc31a146a3..a33e575f97ab 100644
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
 
-- 
2.47.0


