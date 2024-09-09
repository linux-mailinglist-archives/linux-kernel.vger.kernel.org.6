Return-Path: <linux-kernel+bounces-321445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F82971A79
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 15:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEE2F1F2508D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 13:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4551BA27F;
	Mon,  9 Sep 2024 13:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MUsKGUSJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311921B86D5
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 13:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725887355; cv=none; b=M1n8ufLWTJblbGj12MduZFQ19AvXCUyNnYQdjKuMgz0VgtNElhd+l9h6Xp88pV9Uu6A1jQRlgQG3YUPoCqY+479NB3h/X1PtuCwMlObzV0X9/Oi5YqH5x+et3xJHqJ8GdnI7RwQQZpq04jG1+4MWm93kq568NgLAkGnFsQiTv9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725887355; c=relaxed/simple;
	bh=2fOjzaDByxMmlko0lODKQbWeVDECGs2xgz8V9K4q3gg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DLFOZH6ImnR8C3/3QybrUagj7AF6JJRdWkSaeBWRH1/VvDnaa0vtfKkNkMWYQl0mUq/7IC8a1wyFD1PTIV0synnll6MTVzfT97uV75ZDZ28XBTi6CsHCkQVfufALJNWoXd5l/MgN3TP7BRKG6HKcIsbkeQVKA+FCRATgBqUQU4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MUsKGUSJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725887353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lropL0IV79ofEMi+CoS5zuOzHMq1y8F7gBGm+DxRDOQ=;
	b=MUsKGUSJQj+O7Now6+2xw/cIuJTZpLJ2O8iOzXRDcBwGxmvbdhbqR68e4Um34Gt7ZwkouY
	dxfcvzApgdBE6ta5eYHigzjH5mlnnbWxmkCWMvtEz+0GnVrBYdDAjrauOj3gWyzu5X0kDy
	xDLVypRP/tWgHAhHFFl3uV+zmNRoK6U=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-215-YabDR4jGME-K6P6qxYmAlA-1; Mon,
 09 Sep 2024 09:09:10 -0400
X-MC-Unique: YabDR4jGME-K6P6qxYmAlA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A63431956077;
	Mon,  9 Sep 2024 13:09:08 +0000 (UTC)
Received: from queeg.tpb.lab.eng.brq.redhat.com (unknown [10.43.135.229])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C109C1956048;
	Mon,  9 Sep 2024 13:09:06 +0000 (UTC)
From: Miroslav Lichvar <mlichvar@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Miroslav Lichvar <mlichvar@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	John Stultz <jstultz@google.com>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ptp: Limit time setting of PTP clocks
Date: Mon,  9 Sep 2024 15:09:05 +0200
Message-ID: <20240909130905.962836-1-mlichvar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Networking drivers implementing PTP clocks and kernel socket code
handling hardware timestamps use the 64-bit signed ktime_t type counting
nanoseconds. When a PTP clock reaches the maximum value in year 2262,
the timestamps returned to applications will overflow into year 1667.
The same thing happens when injecting a large offset with
clock_adjtime(ADJ_SETOFFSET).

The commit 7a8e61f84786 ("timekeeping: Force upper bound for setting
CLOCK_REALTIME") limited the maximum accepted value setting the system
clock to 30 years before the maximum representable value (i.e. year
2232) to avoid the overflow, assuming the system will not run for more
than 30 years.

Enforce the same limit for PTP clocks. Don't allow negative values and
values closer than 30 years to the maximum value. Drivers may implement
an even lower limit if the hardware registers cannot represent the whole
interval between years 1970 and 2262 in the required resolution.

Signed-off-by: Miroslav Lichvar <mlichvar@redhat.com>
Cc: Richard Cochran <richardcochran@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: John Stultz <jstultz@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 drivers/ptp/ptp_clock.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/ptp/ptp_clock.c b/drivers/ptp/ptp_clock.c
index c56cd0f63909..bd7c5f534be6 100644
--- a/drivers/ptp/ptp_clock.c
+++ b/drivers/ptp/ptp_clock.c
@@ -100,6 +100,9 @@ static int ptp_clock_settime(struct posix_clock *pc, const struct timespec64 *tp
 		return -EBUSY;
 	}
 
+	if (!timespec64_valid_settod(tp))
+		return -EINVAL;
+
 	return  ptp->info->settime64(ptp->info, tp);
 }
 
@@ -129,7 +132,7 @@ static int ptp_clock_adjtime(struct posix_clock *pc, struct __kernel_timex *tx)
 	ops = ptp->info;
 
 	if (tx->modes & ADJ_SETOFFSET) {
-		struct timespec64 ts;
+		struct timespec64 ts, ts2;
 		ktime_t kt;
 		s64 delta;
 
@@ -139,7 +142,14 @@ static int ptp_clock_adjtime(struct posix_clock *pc, struct __kernel_timex *tx)
 		if (!(tx->modes & ADJ_NANO))
 			ts.tv_nsec *= 1000;
 
-		if ((unsigned long) ts.tv_nsec >= NSEC_PER_SEC)
+		/* Make sure the offset is valid */
+		err = ptp_clock_gettime(pc, &ts2);
+		if (err)
+			return err;
+		ts2 = timespec64_add(ts2, ts);
+
+		if ((unsigned long) ts.tv_nsec >= NSEC_PER_SEC ||
+		    !timespec64_valid_settod(&ts2))
 			return -EINVAL;
 
 		kt = timespec64_to_ktime(ts);
-- 
2.46.0


