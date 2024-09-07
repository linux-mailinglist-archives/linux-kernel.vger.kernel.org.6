Return-Path: <linux-kernel+bounces-319931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE829703E8
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 21:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1385FB22A2A
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 19:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF09165F02;
	Sat,  7 Sep 2024 19:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=benjarobin.fr header.i=@benjarobin.fr header.b="qz4O51mJ"
Received: from 2.mo572.mail-out.ovh.net (2.mo572.mail-out.ovh.net [178.33.110.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784FDEED8
	for <linux-kernel@vger.kernel.org>; Sat,  7 Sep 2024 19:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.33.110.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725737224; cv=none; b=bKiGfjfict4AzBQbxaPh58JogeaKKVrZi0nF9kazRGVrlIaZE9zzOJT2dycy2pGGPS+6mySVfqCDRJeY2xuPdvafwiQE0r9hNxREKM3KRjvLsFUP3A9fyece2jkBpS1v2oS6fokquMm5S98rMifoB9DLtP+5h6xVhOCbYOKx6E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725737224; c=relaxed/simple;
	bh=86oxhar7PC069Kgf9yLrAIGkFh4hbMuuAr6G4etCXCc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gIbBaZ5+M2XqZRwWGPUbNqqPMKu+hm3LyThhJZJ17eaJzNf7IJJE9H6cHH4/ow0qpbm+rOd2u6spqDoPdAuR/X0HqrwTbQ8Iv78p2D8/U032muaq6vtaw6Amzqv9b/eRr7P9kRk1VKg3Cp/kGLEZGTSoinMQ/WCl3O9V+geJ7J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=benjarobin.fr; spf=pass smtp.mailfrom=benjarobin.fr; dkim=pass (2048-bit key) header.d=benjarobin.fr header.i=@benjarobin.fr header.b=qz4O51mJ; arc=none smtp.client-ip=178.33.110.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=benjarobin.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=benjarobin.fr
Received: from director4.derp.mail-out.ovh.net (director4.derp.mail-out.ovh.net [79.137.60.37])
	by mo572.mail-out.ovh.net (Postfix) with ESMTPS id 4X1N2d5TSmz130t;
	Sat,  7 Sep 2024 19:10:01 +0000 (UTC)
Received: from director4.derp.mail-out.ovh.net (director4.derp.mail-out.ovh.net. [127.0.0.1])
        by director4.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
        for <dev@benjarobin.fr>; Sat,  7 Sep 2024 19:10:01 +0000 (UTC)
Received: from mta3.priv.ovhmail-u1.ea.mail.ovh.net (unknown [10.108.9.3])
	by director4.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4X1N2d4nYGzy9f;
	Sat,  7 Sep 2024 19:10:01 +0000 (UTC)
Received: from benjarobin.fr (unknown [10.1.6.1])
	by mta3.priv.ovhmail-u1.ea.mail.ovh.net (Postfix) with ESMTPSA id 050CB3A3583;
	Sat,  7 Sep 2024 19:10:00 +0000 (UTC)
Authentication-Results:garm.ovh; auth=pass (GARM-98R00236806a87-179b-488d-9c0c-1185a8460ae6,
                    032CD832329D7EDFD22D017F66308F0C35F9A440) smtp.auth=dev@benjarobin.fr
X-OVh-ClientIp:92.161.126.4
From: Benjamin ROBIN <dev@benjarobin.fr>
To: jstultz@google.com,
	tglx@linutronix.de
Cc: sboyd@kernel.org,
	linux-kernel@vger.kernel.org,
	Benjamin ROBIN <dev@benjarobin.fr>
Subject: [PATCH] ntp: Make sure RTC is synchronized when time goes backwards
Date: Sat,  7 Sep 2024 21:09:00 +0200
Message-ID: <20240907190900.55421-1-dev@benjarobin.fr>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 11892036292404526043
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrudeifedgudefjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepuegvnhhjrghmihhnucftqfeukffpuceouggvvhessggvnhhjrghrohgsihhnrdhfrheqnecuggftrfgrthhtvghrnhephefhgfejkefhleejteeukedtteduhfehfeeuhfekjefgiefhjeefueevieegtedunecukfhppeduvdejrddtrddtrddupdelvddrudeiuddruddviedrgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepuggvvhessggvnhhjrghrohgsihhnrdhfrhdpnhgspghrtghpthhtohephedprhgtphhtthhopeguvghvsegsvghnjhgrrhhosghinhdrfhhrpdhrtghpthhtohepjhhsthhulhhtiiesghhoohhglhgvrdgtohhmpdhrtghpthhtohepshgsohihugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhglhigsehlihhnuhhtrhhonhhigidruggvpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehjedvpdhmohguvgepshhmthhpohhuth
DKIM-Signature: a=rsa-sha256; bh=r6gCvxDT5H8Wms3pngKOUB9kSSO764vlBI7NxgzHJgw=;
 c=relaxed/relaxed; d=benjarobin.fr; h=From; s=ovhmo1728415-selector1;
 t=1725736202; v=1;
 b=qz4O51mJ+PT6WjPuwre+GSOFoLFjEeOxQb9tNqnNPY1ZXf0YthD4Jkiq5oKg/Kv0MfqAwmRP
 Jq6598WgLRmpp4iKc5o+p0b/clBP+GjxIxfaL5H+vcXGZRfGRn2pRkTbU8uJtY8Nac/wCPR5a6m
 vR55SxTbPoMxp3z56n7ofwN3lG0Pt1skPElxhL99M12wWsQLs5oSEIsNtBEjU8qGmDFb0tf9dGq
 RUUbyHXwe+xWa0JEeU3gD31piwUQxyEb1EIx+nv63o2K18kSVPmQW1DFt0WTsyaBqKEXH5je8w1
 XUAQJLz1To46gYQhmYk7SpqKw3ImLxcr4oY9wIXi/JrUQ==

The "sync_hw_clock" is normally called every 11 minutes when time is
synchronized. This issue is that this periodic timer uses the REALTIME
clock, so when time moves backwards (the NTP server jumps into the past),
the next call to "sync_hw_clock" could be realized after a very long
period.

A normal NTP server should not jump in the past like that, but it is
possible... Another way to reproduce this issue is using phc2sys to
synchronize the REALTIME clock with for example an IRIG timecode with
the source always starting at the same date (not synchronized).

This patch cancels the periodic timer on a time jump (ADJ_SETOFFSET).
The timer will be relaunched at the end of "do_adjtimex" if NTP is still
considered synced. Otherwise the timer will be relaunched later when NTP
is synced. This way, when the time is synchronized again, the RTC is
updated after less than 2 seconds.

Signed-off-by: Benjamin ROBIN <dev@benjarobin.fr>
---
 kernel/time/ntp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index 8d2dd214ec68..5c8dd92cf012 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -751,6 +751,9 @@ static inline void process_adjtimex_modes(const struct __kernel_timex *txc,
 
 	if (txc->modes & (ADJ_TICK|ADJ_FREQUENCY|ADJ_OFFSET))
 		ntp_update_frequency();
+
+	if (txc->modes & ADJ_SETOFFSET)
+		hrtimer_cancel(&sync_hrtimer);
 }
 
 
-- 
2.45.2


