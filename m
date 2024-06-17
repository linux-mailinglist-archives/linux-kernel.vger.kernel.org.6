Return-Path: <linux-kernel+bounces-218105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D56890B9CA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 20:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E9F2B2527A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 18:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3C119AD9D;
	Mon, 17 Jun 2024 18:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="t7Xh1Mc1"
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB261991A5;
	Mon, 17 Jun 2024 18:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718647998; cv=none; b=fskNJnbemHe/HgLVzIhfxK4k3Tadj/DnQ6g7k6+Nv/Wyu5KWHta0oDnBrGET4T0E53OEU5HUupjyK1JfNMUPiTZhPmXO4kHYWkp9uzx05BqmPk/nAeD6BGfFBkokR50pLH/c9ofiWJjqPPJmiUl/CGSk07BgzBNfV/a5W6N/UTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718647998; c=relaxed/simple;
	bh=ULktF8naJ9Rw66szNBQ/Dn3wRGt6CrZufx250lGQItc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M9hVCg+R+Gy+lnZlg88yKvtjuxsyO5WWm7A0aGL39X2NX489x4Rm9F9luNfNU7gDAKetMOSvhh7epp5kwoDDYuucj+0pzTg9Fy0OGOn7Bs1rOg9se5Jkp8cOqjv25jk84NtmjrBX8Al8sAGPB0Ux9nG7KQBfw48DbySYqHD0sYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=fail (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=t7Xh1Mc1 reason="signature verification failed"; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 6.2.0)
 id 431a277914fde2ee; Mon, 17 Jun 2024 20:13:14 +0200
Received: from kreacher.localnet (unknown [195.136.19.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 95D4816606FD;
	Mon, 17 Jun 2024 20:13:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1718647994;
	bh=ULktF8naJ9Rw66szNBQ/Dn3wRGt6CrZufx250lGQItc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=t7Xh1Mc1Pq/erPQkfWWtTSqjj7qyUP+oYyOoM07aybNDp1m3Uu1G4kgXcGk7L3q44
	 3gPs1SWU5neJ+TixLCtjGPfjH3hNEHlPzBR31MLfNnLROKdkW10S/yaOZh1bWIVTUm
	 5FmBwGit0Uw8cNt0RNy8hx2aD5aVE96TTa7zCfXrjFwBnpK23Jt6yYl6vsyylOZVXV
	 RfdZmJAcnY8mJ1A9VlKUuAxvq53JTN4udiU2VYuhwgs0d58ucL39hCdMEKSyCW2im+
	 XPI9Dn1FBA5WwRsJX2ZDxrmuqlt8i1ycET1g8gA7ipoqiwaAV4S9HPpRL0jyhxSjK+
	 GQJnXcR+T8yBg==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>
Subject:
 [PATCH v1 03/14] thermal: trip: Add conversion macros for thermal trip priv
 field
Date: Mon, 17 Jun 2024 19:56:46 +0200
Message-ID: <5499725.Sb9uPGUboI@kreacher>
In-Reply-To: <8409966.T7Z3S40VBb@kreacher>
References: <8409966.T7Z3S40VBb@kreacher>
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
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrfedvhedguddvvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpedvffeuiedtgfdvtddugeeujedtffetteegfeekffdvfedttddtuefhgeefvdejhfenucfkphepudelhedrudefiedrudelrdelgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduleehrddufeeirdduledrleegpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeejpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhhkrghsiidrlhhusggrsegrrhhmrdgtohhmpdhrtghpthhtohepuggrnhhivghlrdhlvgii
 tggrnhhosehlihhnrghrohdrohhrghdprhgtphhtthhopehsrhhinhhivhgrshdrphgrnhgurhhuvhgruggrsehlihhnuhigrdhinhhtvghlrdgtohhm
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Some drivers will need to store integers in the priv field of struct
thermal_trip, so add conversion macros for doing this in a consistent
way and switch over the int340x_thermal driver that already does it and
uses custom conversion functions to using the new macros.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c |   14 +----------
 include/linux/thermal.h                                      |    3 ++
 2 files changed, 5 insertions(+), 12 deletions(-)

Index: linux-pm/include/linux/thermal.h
===================================================================
--- linux-pm.orig/include/linux/thermal.h
+++ linux-pm/include/linux/thermal.h
@@ -79,6 +79,9 @@ struct thermal_trip {
 #define THERMAL_TRIP_FLAG_RW	(THERMAL_TRIP_FLAG_RW_TEMP | \
 				 THERMAL_TRIP_FLAG_RW_HYST)
 
+#define THERMAL_TRIP_PRIV_TO_INT(_val_)	(uintptr_t)(_val_)
+#define THERMAL_INT_TO_TRIP_PRIV(_val_)	(void *)(uintptr_t)(_val_)
+
 struct thermal_zone_device;
 
 struct thermal_zone_device_ops {
Index: linux-pm/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
===================================================================
--- linux-pm.orig/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
+++ linux-pm/drivers/thermal/intel/int340x_thermal/int340x_thermal_zone.c
@@ -62,16 +62,6 @@ static void int340x_thermal_critical(str
 		thermal_zone_device_type(zone));
 }
 
-static inline void *int_to_trip_priv(int i)
-{
-	return (void *)(long)i;
-}
-
-static inline int trip_priv_to_int(const struct thermal_trip *trip)
-{
-	return (long)trip->priv;
-}
-
 static int int340x_thermal_read_trips(struct acpi_device *zone_adev,
 				      struct thermal_trip *zone_trips,
 				      int trip_cnt)
@@ -106,7 +96,7 @@ static int int340x_thermal_read_trips(st
 			break;
 
 		zone_trips[trip_cnt].type = THERMAL_TRIP_ACTIVE;
-		zone_trips[trip_cnt].priv = int_to_trip_priv(i);
+		zone_trips[trip_cnt].priv = THERMAL_INT_TO_TRIP_PRIV(i);
 		trip_cnt++;
 	}
 
@@ -224,7 +214,7 @@ static int int340x_update_one_trip(struc
 		break;
 	case THERMAL_TRIP_ACTIVE:
 		err = thermal_acpi_active_trip_temp(zone_adev,
-						    trip_priv_to_int(trip),
+						    THERMAL_TRIP_PRIV_TO_INT(trip->priv),
 						    &temp);
 		break;
 	default:




