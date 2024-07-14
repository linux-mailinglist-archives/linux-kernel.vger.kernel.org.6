Return-Path: <linux-kernel+bounces-251921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2CCA930BA9
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 22:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E7FB281F39
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 20:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900C713D28F;
	Sun, 14 Jul 2024 20:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ajTjAryy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iA5BQrFX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD9818AED
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2024 20:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720990209; cv=none; b=laQuJe9Ti84/bToynRJHfWafuCHxNvBc7wYBw8mnmUW3YX8puKaF41DcbtGs+rx69l5CDOMA/07A56sWsvR64VO4ZX/s0slJI9WDPJk0usQDDlwBzIKRaKeW/LcnMSV1VYEvh7oVTtxw5PA6ld5mkDc3TSTBx6H4+sA/AHomDbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720990209; c=relaxed/simple;
	bh=hwiXlZWx6CN0SQMz8QkESNeIJHVGOjNdpTPujvaKC+I=;
	h=From:To:Cc:Subject:Message-ID:Content-Type:MIME-Version:Date; b=I0tpXj/KCSA2AKL//eK7XRVE/o1W0gvO2hZgDRpSiY5D2N+85DVi/9eHHESLnmnvaJvxF8g081n+c5nW1SqUorqJohPvgkDo/mYghQ/MWioKbbtZAzGexeM3h+1+orBlfK1ZjwK2rtMolus1k+pLstVi/PXh7BH6Jf0/XDuspK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ajTjAryy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iA5BQrFX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720990205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wjl9tIIspzOSi0BWLjAbBtNsY8Mon818Ft4dB0oSek0=;
	b=ajTjAryyzdvHuiV6OGFtv/IZ25FN3UuOPxGHkoRYJJMdY7msFfQ10mEIVOvpIkrg2IH85r
	w8vWzXn9dPALvXtT9FnUMxXtm4ilsFrnWK7EH7hMC5isva3We6fh+JWqA9qtUizMPU4DkL
	omIqKNUdSVX9jLbBFk+TVW35wHChl1Hq38IXye2gGcD58YAX13AVSXxFuMg5BXG5JukK1C
	vEPEM9BDOXRCw4zDvAImW+k8DwRykvNbFhwsniAPlgIkQIYT84olTgC1+3Dv2UOrTcPkNP
	KB8i6QARw7aTxPi968hDghXfR5K4ZKI9KUpQzJceRoRszTufjIxcirroMMTmjg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720990205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wjl9tIIspzOSi0BWLjAbBtNsY8Mon818Ft4dB0oSek0=;
	b=iA5BQrFXlZ/23EYT8kFKixQ0eBPpxv73dt/6LxQ0mdVbnhx9H1G3JaXQig4Jjs1ENa4zzF
	G9U9GPZRDcMb5PDg==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] core/debugobjects for v6.11-rc1
Message-ID: <172099001487.1942258.17671805941963584080.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 14 Jul 2024 22:50:05 +0200 (CEST)

Linus,

please pull the latest core/debugobjects branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-debugobject=
s-2024-07-14

up to:  5b5baba62222: debugobjects: Annotate racy debug variables


A single update for debugobjects to annotate all intentionally racy global
debug variables so that KCSAN ignores them.

Thanks,

	tglx

------------------>
Breno Leitao (1):
      debugobjects: Annotate racy debug variables


 lib/debugobjects.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index fb12a9bacd2f..7cea91e193a8 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -78,16 +78,17 @@ static bool			obj_freeing;
 /* The number of objs on the global free list */
 static int			obj_nr_tofree;
=20
-static int			debug_objects_maxchain __read_mostly;
-static int __maybe_unused	debug_objects_maxchecked __read_mostly;
-static int			debug_objects_fixups __read_mostly;
-static int			debug_objects_warnings __read_mostly;
-static int			debug_objects_enabled __read_mostly
-				=3D CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT;
-static int			debug_objects_pool_size __read_mostly
-				=3D ODEBUG_POOL_SIZE;
-static int			debug_objects_pool_min_level __read_mostly
-				=3D ODEBUG_POOL_MIN_LEVEL;
+static int __data_racy			debug_objects_maxchain __read_mostly;
+static int __data_racy __maybe_unused	debug_objects_maxchecked __read_mostly;
+static int __data_racy			debug_objects_fixups __read_mostly;
+static int __data_racy			debug_objects_warnings __read_mostly;
+static int __data_racy			debug_objects_enabled __read_mostly
+					=3D CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT;
+static int __data_racy			debug_objects_pool_size __read_mostly
+					=3D ODEBUG_POOL_SIZE;
+static int __data_racy			debug_objects_pool_min_level __read_mostly
+					=3D ODEBUG_POOL_MIN_LEVEL;
+
 static const struct debug_obj_descr *descr_test  __read_mostly;
 static struct kmem_cache	*obj_cache __ro_after_init;
=20


