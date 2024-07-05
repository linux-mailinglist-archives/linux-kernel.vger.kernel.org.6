Return-Path: <linux-kernel+bounces-242869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB73928E1C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 22:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8821C1F22C77
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 20:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3DB149C7F;
	Fri,  5 Jul 2024 20:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="kf5Yh2XB"
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BE9135417;
	Fri,  5 Jul 2024 20:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720210957; cv=none; b=ZIaIDGwX99YInJttPhwi4hw9Wk1sS8a9H+jD0CKAyegbwfWbhptflmXhtbGl8Cx3aGVXoL918QSujE/4Fs7VShn4keaEHHswdA/hVDH9nPmLkqYnhTHdc/JjliM4RBKXeiY3WJktWvLmlfpYa6zPqQ2iUWtXv0ZwrYWpaqOpLLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720210957; c=relaxed/simple;
	bh=iQ+b5Jx7WMdrTUsanaaaUzqA8tHQvM7MXl7JMEqouCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=u6PagdB1IRgvFBZlvHJFv4F8oLpQH1HelUpmuSU3Fo+KF3WMmLFjyc9NEO4jFlUQ3ukMRJc00V3mc6LsJ6uFF0i9QwMvjVRk3mrEaB+h8K+62w1S5I/ngvDnazEGa7Mm7zhZe+x7heF9kJ9ZlhkuPx3lmIHPcyJf5SwncnBYMGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=kf5Yh2XB reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id c4c2457a26282e1f; Fri, 5 Jul 2024 21:22:32 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id AF27F7F5773;
	Fri,  5 Jul 2024 21:22:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1720207352;
	bh=iQ+b5Jx7WMdrTUsanaaaUzqA8tHQvM7MXl7JMEqouCQ=;
	h=From:To:Cc:Subject:Date;
	b=kf5Yh2XBwtGJA/bx0D7vX12i68f4o/QJakhWRzb1ZRmzVHEIVXXp7wPgMDhgPUDfM
	 UcymDvABuizND04yru9QsOhXihS+tMXPdfgDzjYX+AR8MG41fq3rPgYQiOAvrBu0wh
	 YhzmB58RRtfkNHL6NMYv5Qoqlt4T6oSIaiqfLZ308MDWe+yP2mPW4RWV5quOBLZETs
	 goREv6/q9yHelrk8bxmlCEFLJG/xIuArSDludk5jyUn9PqDaXZODIJdy46RDEDdwFh
	 MIF1e5007tb/QYKW4KAyYv+jPdC7t7AFMbaw6v7k8m6U/uRccwTEz7QDoyPCeRc0Eb
	 Pfl64nIiHfJ0g==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>
Subject:
 [PATCH v1] thermal: core: Simplify list sorting in
 __thermal_zone_device_update()
Date: Fri, 05 Jul 2024 21:22:31 +0200
Message-ID: <2745398.mvXUDI8C0e@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 195.136.19.94
X-CLIENT-HOSTNAME: 195.136.19.94
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeeftddrvddugddufeehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepffffffekgfehheffleetieevfeefvefhleetjedvvdeijeejledvieehueevueffnecukfhppeduleehrddufeeirdduledrleegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepudelhedrudefiedrudelrdelgedphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepgedprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhukhgrshiirdhluhgsrgesrghrmhdrtghomh
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Notice that it is not necessary to sort way_down_list in descending
order.  Instead, it can be sorted in ascending order, like way_up_list,
and walked in reverse order.

Use this observation to simplify list sorting slightly in
__thermal_zone_device_update() which also causes the code to
be somewhat more straightforward and so easier to follow.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_core.c |   10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -487,16 +487,14 @@ static void thermal_trip_crossed(struct
 	thermal_governor_trip_crossed(governor, tz, trip, crossed_up);
 }
 
-static int thermal_trip_notify_cmp(void *ascending, const struct list_head *a,
+static int thermal_trip_notify_cmp(void *not_used, const struct list_head *a,
 				   const struct list_head *b)
 {
 	struct thermal_trip_desc *tda = container_of(a, struct thermal_trip_desc,
 						     notify_list_node);
 	struct thermal_trip_desc *tdb = container_of(b, struct thermal_trip_desc,
 						     notify_list_node);
-	int ret = tdb->notify_temp - tda->notify_temp;
-
-	return ascending ? ret : -ret;
+	return tdb->notify_temp - tda->notify_temp;
 }
 
 void __thermal_zone_device_update(struct thermal_zone_device *tz,
@@ -525,12 +523,12 @@ void __thermal_zone_device_update(struct
 
 	thermal_zone_set_trips(tz);
 
-	list_sort(&way_up_list, &way_up_list, thermal_trip_notify_cmp);
+	list_sort(NULL, &way_up_list, thermal_trip_notify_cmp);
 	list_for_each_entry(td, &way_up_list, notify_list_node)
 		thermal_trip_crossed(tz, &td->trip, governor, true);
 
 	list_sort(NULL, &way_down_list, thermal_trip_notify_cmp);
-	list_for_each_entry(td, &way_down_list, notify_list_node)
+	list_for_each_entry_reverse(td, &way_down_list, notify_list_node)
 		thermal_trip_crossed(tz, &td->trip, governor, false);
 
 	if (governor->manage)




