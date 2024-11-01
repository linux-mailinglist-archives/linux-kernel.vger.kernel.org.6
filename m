Return-Path: <linux-kernel+bounces-392775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B899B97F8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 19:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC0F32825C1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 18:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20AF21CEE8B;
	Fri,  1 Nov 2024 18:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maxima.ru header.i=@maxima.ru header.b="Wng5xmnK"
Received: from ksmg02.maxima.ru (ksmg02.maxima.ru [81.200.124.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85432E62C;
	Fri,  1 Nov 2024 18:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.200.124.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730487367; cv=none; b=FfMrTfFOCxv1m8bVOsG0U7qfrQkDtNouq35ig3RxHQLILbpZj5eoMgRw61X2WToycOs1eWv4zc3uvJ+Y/e3UAPkwOjUStja23s1ubnpToLiCCgt/evTO84ppgEyK6TsS5anorjnyFwzIlr4864VKIsmaCr+77RC8nOWqwFCI0bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730487367; c=relaxed/simple;
	bh=cyibAUBc3nH31Y5bGIhi81fOdMfwmNkmQSSTQXnNcX0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bJoQ7Gm1c869eWbM5Nc/Fyp/3mYRVeXouI7rigixSfGgAURsFa7NDYdMSAU+fuGuFYucqJGmLaAWKZ8ijS7FCnzG8x781rPzu9HNZjdZw9nD/XjEPKAdOpTdgqceaXN6wPAdq3st+dIM8pXpKdbqwPVus63J5WnSIIKDydF/fTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maxima.ru; spf=pass smtp.mailfrom=maxima.ru; dkim=pass (2048-bit key) header.d=maxima.ru header.i=@maxima.ru header.b=Wng5xmnK; arc=none smtp.client-ip=81.200.124.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maxima.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maxima.ru
Received: from ksmg02.maxima.ru (localhost [127.0.0.1])
	by ksmg02.maxima.ru (Postfix) with ESMTP id 04E8A1E0018;
	Fri,  1 Nov 2024 21:55:57 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 ksmg02.maxima.ru 04E8A1E0018
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxima.ru; s=sl;
	t=1730487357; bh=NUPsggGiv381n1ARMdQIdkqwV7+9gs+JmfmHBwCQ0Aw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=Wng5xmnKVC9gqB2NWMDUrYBg7910xxrWjAVdqdL74Kr82nPZeyFOtUQiZHQRekwAE
	 4WTtHcEGwomA7vp20pQ5vWWKCbVpFzoindZUL4GvUUbBA9k8EKeeC7h53EDercY9T8
	 geyc3R0TabZOpDSqa17CkigkyeR9qJF5+CTLHLHniWZ840RB0XsWn9xz//dF3P03jt
	 8QfR+nSBZ6ZOFHIBgA+yd27HDI24/EUfbsrGrSeUmRGzbdECePHsz+S0qRolqGwqSN
	 i7YyABNuiGQCoeahh3P8H6kjmxV1fh5f2vWuZ0Yk3rlIqpcexKr/iBYOaqVPHHOO+7
	 yBIuHzjxxotYQ==
Received: from ksmg02.maxima.ru (autodiscover.maxima.ru [81.200.124.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "*.maxima.ru", Issuer "GlobalSign GCC R3 DV TLS CA 2020" (verified OK))
	by ksmg02.maxima.ru (Postfix) with ESMTPS;
	Fri,  1 Nov 2024 21:55:56 +0300 (MSK)
Received: from GS-NOTE-190.mt.ru (10.0.247.10) by mmail-p-exch02.mt.ru
 (81.200.124.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1544.4; Fri, 1 Nov 2024
 21:55:53 +0300
From: Murad Masimov <m.masimov@maxima.ru>
To: Clemens Ladisch <clemens@ladisch.de>
CC: Murad Masimov <m.masimov@maxima.ru>, Takashi Sakamoto
	<o-takashi@sakamocchi.jp>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
	<tiwai@suse.com>, <linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH] ALSA: firewire-lib: fix return value on fail in amdtp_tscm_init()
Date: Fri, 1 Nov 2024 21:55:13 +0300
Message-ID: <20241101185517.1819-1-m.masimov@maxima.ru>
X-Mailer: git-send-email 2.46.0.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mt-exch-01.mt.ru (91.220.120.210) To mmail-p-exch02.mt.ru
 (81.200.124.62)
X-KSMG-Rule-ID: 7
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 188915 [Nov 01 2024]
X-KSMG-AntiSpam-Version: 6.1.1.7
X-KSMG-AntiSpam-Envelope-From: m.masimov@maxima.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dmarc=none header.from=maxima.ru;spf=none smtp.mailfrom=maxima.ru;dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 41 0.3.41 623e98d5198769c015c72f45fabbb9f77bdb702b, {rep_avail}, {Tracking_from_domain_doesnt_match_to}, maxima.ru:7.1.1;127.0.0.199:7.1.2;81.200.124.62:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;ksmg02.maxima.ru:7.1.1, FromAlignment: s, ApMailHostAddress: 81.200.124.62
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/11/01 17:50:00 #26800554
X-KSMG-AntiVirus-Status: Clean, skipped

If amdtp_stream_init() fails in amdtp_tscm_init(), the latter returns zero,
though it's supposed to return error code, which is checked inside
init_stream() in file tascam-stream.c.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 47faeea25ef3 ("ALSA: firewire-tascam: add data block processing layer")
Signed-off-by: Murad Masimov <m.masimov@maxima.ru>
---
 sound/firewire/tascam/amdtp-tascam.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/firewire/tascam/amdtp-tascam.c b/sound/firewire/tascam/amdtp-tascam.c
index 0b42d6559008..079afa4bd381 100644
--- a/sound/firewire/tascam/amdtp-tascam.c
+++ b/sound/firewire/tascam/amdtp-tascam.c
@@ -238,7 +238,7 @@ int amdtp_tscm_init(struct amdtp_stream *s, struct fw_unit *unit,
 	err = amdtp_stream_init(s, unit, dir, flags, fmt,
 			process_ctx_payloads, sizeof(struct amdtp_tscm));
 	if (err < 0)
-		return 0;
+		return err;

 	if (dir == AMDTP_OUT_STREAM) {
 		// Use fixed value for FDF field.
--
2.39.2


