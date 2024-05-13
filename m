Return-Path: <linux-kernel+bounces-177578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD638C40FD
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 14:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63F51B22894
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 12:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D23514F9F7;
	Mon, 13 May 2024 12:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="y3g4edEZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PncxH9W3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1A114F9C9
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 12:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715604605; cv=none; b=T19R8pY1TgVuQ+F/xuyzKDP0wtwjyu+shhs3S2IP0s9hGDt70tsB4QlueibUZRmdmC2KDDs97Iw4oI34llTEQQeCQbkIthTWnMaX+YydHOZfOAm4iTFREURZXhpbsVt5yDefWwswSSb0J94eHsIxaEqhJhlf7YmYimh9e4jRb40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715604605; c=relaxed/simple;
	bh=N5Y56Y2TdhmTcS0wPaae6uOxJO9iaTwgEEDTRTJEfRY=;
	h=From:To:Cc:Subject:References:Message-ID:Content-Type:
	 MIME-Version:Date; b=IqwEFTOTb/qE72YsYO2SZEojAYNbkYioCg/0PLcki4I2WYGVdlgMyEua8yEd6DPXD2RRP1MwDpwK9jcripNBgVVglJ2hCxczhivRWOn9X+zm5QDn0azJEQcOxd4c1DyIkzwqVPopdUJrJ/iAznUEeL3uYUrV89iFOP1HPpUXpPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=y3g4edEZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PncxH9W3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715604602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=wOlaj9mDxhp1TY8owHYfJbnZf9zkKuB1uVd0RHg00mw=;
	b=y3g4edEZYYeGs5XKduf+p6cxzJioAAU9tqcich1ofX9uKW53rUTDKbd/iPneUf42haSWtW
	r2qbnenTfPnnI9ANtzwTx8TZW7kyZFz360lG3RqWsFvVDp1INOyOhkmp2fRgFZEnwfmb3Y
	NkpmO6jGeBBPwO/MYNzbLK05oppr4FsPAbd22jZ+hnvOfj/O1ZnBLZXdI02JZekZoPvieB
	8qSeaiBfPxvySzaplEXU9tKNS2co7qHX1kGhgZRTMEpCfE3caYX1QzAx1AVz0wOrW5kClq
	N4eBjZaR/4p7aC4f4weEzLVflhybWl9Ms6oxOZxVY5HyG1iWTURHhUc6vh8eBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715604602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=wOlaj9mDxhp1TY8owHYfJbnZf9zkKuB1uVd0RHg00mw=;
	b=PncxH9W3FieA5KzsB3MZtlpCX1S7yGPoc4c/DYUk+YABOOfkojod5LQaoDGKX3uMbOR+uW
	u4SVWwtKg6HXQAAw==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86/timers for v6.10-rc1
References: 
 <171560454635.3871325.5773365584560034962.tglx@xen13.tec.linutronix.de>
Message-ID: 
 <171560455005.3871325.1102142666677911813.tglx@xen13.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 13 May 2024 14:50:02 +0200 (CEST)

Linus,

please pull the latest x86/timers branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-timers-2024-=
05-13

up to:  455f9075f144: x86/tsc: Trust initial offset in architectural TSC-adju=
st MSRs

A single update for the TSC synchronixation sanity checks:

  The sad state of TSC being notoriously non-sychronized for several
  decades caused the kernel to grow quite rigorous sanity checks to detect
  whether the TSC is valid to be used for timekeeping.

  The TSC ADJUST MSR provides the offset between the initial TSC value
  after hardware reset and later modifications. This allows to detect cases
  where firmware tampers with the TSC and also allows to correct the
  firmware induced damage by resetting the offset in a controlled way.

  The universal correct rule is that the TSC ADJUST value has to be
  consistent within all CPUs of a socket.

  The kernel further assumes that the TSC offset should be consistent
  between sockets. That's not really correct as systems with a huge number
  of sockets are not architecurally guaranteed to reset the per socket TSC
  base synchronously.

  In case that the per socket offset is not consistent the kernel resets it
  to the offset of the boot CPU and then does a synchronization check which
  corrects for the inter socket delays.

  That works most of the time, but it is suboptimal as the firmware has
  eventually better information about the per socket offset and on sane
  systems that offset should just work in the validation checks.

Thanks,

	tglx

------------------>
Daniel J Blueman (1):
      x86/tsc: Trust initial offset in architectural TSC-adjust MSRs


 arch/x86/kernel/tsc_sync.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/tsc_sync.c b/arch/x86/kernel/tsc_sync.c
index 1123ef3ccf90..4334033658ed 100644
--- a/arch/x86/kernel/tsc_sync.c
+++ b/arch/x86/kernel/tsc_sync.c
@@ -193,11 +193,9 @@ bool tsc_store_and_check_tsc_adjust(bool bootcpu)
 	cur->warned =3D false;
=20
 	/*
-	 * If a non-zero TSC value for socket 0 may be valid then the default
-	 * adjusted value cannot assumed to be zero either.
+	 * The default adjust value cannot be assumed to be zero on any socket.
 	 */
-	if (tsc_async_resets)
-		cur->adjusted =3D bootval;
+	cur->adjusted =3D bootval;
=20
 	/*
 	 * Check whether this CPU is the first in a package to come up. In


