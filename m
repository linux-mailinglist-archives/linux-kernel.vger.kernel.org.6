Return-Path: <linux-kernel+bounces-282274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7BA594E185
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 15:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 949A92816F0
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 13:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59BBE149C5E;
	Sun, 11 Aug 2024 13:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BuZ7zdLv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MUhMintu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C45514884C
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 13:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723384691; cv=none; b=QUsYqHBbtxTtlooP16rQDfCwa3cD7ckBum2JUeMAQwSfmNybkm+bhMlOIU2PvsOsNMchs9koThADnQ/qgSuL42TgphYLGmtsgQnkbhrE90h2Ncu5b1dBFeszEFUt32J59Gv3RXYLBB3dYUC9F3adplfj0Il7TsGQrEHkaoNDOAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723384691; c=relaxed/simple;
	bh=oU9uqGSdmXK11gTUzIJ/SQBG1vbHug91j7JTDgKPx8A=;
	h=From:To:Cc:Subject:References:Message-ID:Content-Type:
	 MIME-Version:Date; b=EpuRe85o48szDT+a9X+LxDTs6O1zArl9JP3INE0cV5ffRuwl3CfRrmI4VZFC0vqylRWvWfPrDXRLL339n4Tv0UTWQKWGQuYo0pCW/8w4rkVQR6W24kodgUksYfs+5sjPqgU7AirJ3B8JLOPFsA+F2QRPGEJrduO3/b5eX4/6xPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BuZ7zdLv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MUhMintu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723384687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=okbW1cunU7TgFyPkXQxrxOtSIXGv17jmQh1GuMM3h0M=;
	b=BuZ7zdLvcJ+/ZJ29VsP02ogzbodmpl6VU/3VvTO6KQ4R7Rd5GfMU7Q5ni0dcvWI86GhE8+
	Zmd9Sos1eXLFvKvfy6+zAf4CfogUtNWXecehy1k49dBRp7wnqBb6qeCIBPpUDYiG8ZiCrl
	jw/ViNhcoZXct7e2cQljpMm47uY24gsQLZ77zFqSO9iPQAhkjhlDEf2SsrNQzPdRr6MQnE
	7WT2HNYK8HkPNu5HFiYEMk9hEvHs9AEwVds3wFYBQc3dwRK/v9ZdPFWFs1Lg9G0zanhdWL
	S+RE2OwVf2T8cyxReE2kEbkDqd9Z2IPGDYrArRAhT3Rd3gCtxImBojZ2LckppQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723384687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=okbW1cunU7TgFyPkXQxrxOtSIXGv17jmQh1GuMM3h0M=;
	b=MUhMintuiwWRtrNhi0D+e3D7SNIkPZ6zEzWBTVMXg8PbiEHDS7EqG7PoJjNyuINmghTbps
	Y/WbphoFdlWD2ZBw==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] timers/urgent for v6.11-rc3
References: 
 <172338466501.1168419.15927287413698158262.tglx@xen13.tec.linutronix.de>
Message-ID: 
 <172338466622.1168419.14975326329561608062.tglx@xen13.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 11 Aug 2024 15:58:06 +0200 (CEST)

Linus,

please pull the latest timers/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-20=
24-08-11

up to:  5916be8a53de: timekeeping: Fix bogus clock_was_set() invocation in do=
_adjtimex()


Updates for time keeping:

  - Fix a couple of issues in the NTP code where user supplied values are
    neither sanity checked nor clamped to the operating range. This results
    in integer overflows and eventualy NTP getting out of sync.

    According to the history the sanity checks had been removed in favor of
    clamping the values, but the clamping never worked correctly under all
    circumstances. The NTP people asked to not bring the sanity checks back
    as it might break existing applications.

    Make the clamping work correctly and add it where it's missing

  - If adjtimex() sets the clock it has to trigger the hrtimer subsystem so
    it can adjust and if the clock was set into the future expire timers if
    needed. The caller should provide a bitmask to tell hrtimers which
    clocks have been adjusted. adjtimex() uses not the proper constant and
    uses CLOCK_REALTIME instead, which is 0. So hrtimers adjusts only the
    clocks, but does not check for expired timers, which might make them
    expire really late. Use the proper bitmask constant instead.


Thanks,

	tglx

------------------>
Justin Stitt (2):
      ntp: Clamp maxerror and esterror to operating range
      ntp: Safeguard against time_constant overflow

Thomas Gleixner (1):
      timekeeping: Fix bogus clock_was_set() invocation in do_adjtimex()


 kernel/time/ntp.c         | 9 ++++-----
 kernel/time/timekeeping.c | 2 +-
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index 406dccb79c2b..8d2dd214ec68 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -727,17 +727,16 @@ static inline void process_adjtimex_modes(const struct =
__kernel_timex *txc,
 	}
=20
 	if (txc->modes & ADJ_MAXERROR)
-		time_maxerror =3D txc->maxerror;
+		time_maxerror =3D clamp(txc->maxerror, 0, NTP_PHASE_LIMIT);
=20
 	if (txc->modes & ADJ_ESTERROR)
-		time_esterror =3D txc->esterror;
+		time_esterror =3D clamp(txc->esterror, 0, NTP_PHASE_LIMIT);
=20
 	if (txc->modes & ADJ_TIMECONST) {
-		time_constant =3D txc->constant;
+		time_constant =3D clamp(txc->constant, 0, MAXTC);
 		if (!(time_status & STA_NANO))
 			time_constant +=3D 4;
-		time_constant =3D min(time_constant, (long)MAXTC);
-		time_constant =3D max(time_constant, 0l);
+		time_constant =3D clamp(time_constant, 0, MAXTC);
 	}
=20
 	if (txc->modes & ADJ_TAI &&
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 2fa87dcfeda9..5391e4167d60 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -2606,7 +2606,7 @@ int do_adjtimex(struct __kernel_timex *txc)
 		clock_set |=3D timekeeping_advance(TK_ADV_FREQ);
=20
 	if (clock_set)
-		clock_was_set(CLOCK_REALTIME);
+		clock_was_set(CLOCK_SET_WALL);
=20
 	ntp_notify_cmos_timer();
=20


