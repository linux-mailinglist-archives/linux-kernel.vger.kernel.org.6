Return-Path: <linux-kernel+bounces-438613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 803FE9EA385
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 01:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCD501887C74
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 00:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9866741C7F;
	Tue, 10 Dec 2024 00:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="jHEe/Jcc"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C12022092;
	Tue, 10 Dec 2024 00:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733789838; cv=none; b=fi2ZKOcZVHy5cQyrjDvvJZ4w00r514tyYVNsETVqkcwIoOAhoLRchxomniYTpZJjfwYFEpQMIuU2AjOTZ3RG8D5LGsnu8goAFMoaaZ/nSl9l/PpqexWgpgS8wC/o6PW/mL/wB3WJmhvvmkRq972ZMUJvwFFB70c37MhW7A3f2xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733789838; c=relaxed/simple;
	bh=v+sXfz1oM7wXmwoHIze+M52VRroFDA8ocPKQT4ya83U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KgjG3XIyvlwkeM9+QK51KvLGC9ppj+EcYwH8g5pmlBIN1MemjBmdqP1/ovIhlhFhVGwwO4GFK+6C3t8+F5HkevUCZR1Hq8+uDxCAwiFRjZ2M75fxEdWzg1alFKkFkjCBpPeBUy3sdUEvNIUTFi2RmGcJmlueqgHzbRbB4BTxtxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=jHEe/Jcc; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1733789825; x=1734394625; i=w_armin@gmx.de;
	bh=6AZZ9ZIj8Gv1TL0afhlCyYIVoAXwvnQSYV6fyId62+U=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=jHEe/JccWPzfVtbTZSgw5cNA8AKTyBjgGU0BcG5yI7n8B35nH6kd/K/tRaj1b4qg
	 ssGnxYK2pNzk1zhPT/lZU013u/gCUTrs5vpnpHy4HXtiHaROaSyfAH0JX6Okv91Cu
	 qAZXnGx6Bn8P0GxP9KuPg8GMaicv513qW7iEpG/j2/hScK7TvhoD+pfLUAnQUVqJX
	 d1m0vVfmjj5vYdUlnUUMkhtDYzkz4m+wNcewA8FcOYn/wT1aHwRSLBR62LmjEftzk
	 dsvgW+uwjBbyUqPfAJxwTY4DEoqFafF3l2kZ9xJASes1IUIOobp/VijQaDRubRHUd
	 KwBXpmjrbOWZxZKtGA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-inspiron.fritz.box ([91.14.230.110]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1N3KPq-1tkcWh1tw2-00uNuv; Tue, 10 Dec 2024 01:17:05 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: jlee@suse.com,
	farhan.anwar8@gmail.com,
	rayanmargham4@gmail.com
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kuurtb@gmail.com
Subject: [PATCH v4 2/5] platform/x86: acer-wmi: Rename ACER_CAP_FAN_SPEED_READ
Date: Tue, 10 Dec 2024 01:16:54 +0100
Message-Id: <20241210001657.3362-3-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241210001657.3362-1-W_Armin@gmx.de>
References: <20241210001657.3362-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/9K+nQ0rQIcNAzYw+vbKh3op/m08fYp0qv5Zh/tbl7Ru7pBsfkr
 srRPBO3xyk2l4+z+0BJtDgSA1J73TsIRnYCviy0wfc4MJMol69ac0bXpdWM3/Y5Y4yQBavA
 LA9++0TGeep1T06WuQxRxLmrcemfEWwGmgTvlePMoxnxa/OOzBy7Cqa8IaqSoxHee2q+hl1
 sQoPvAAhJ+iezULmadNQA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:2TRRqFzabrA=;8w8O1SJrm6uPbtqYD/7rDnB4uD6
 8UFRXE7zwUgLPrRlvN9jbK2FWAypLXTPGTRowNYPwRuA15q8oGUFiOD9beG7eqyxIOJmKJGHy
 PplgI4HQVRghcCOe69xy6LXFXopHgO8DjWICrLRUdnnqq1w6RY/AzlnCroBzkh5vqYRunZRjA
 9uWUp7Pjn+LTC6dZxmGrQnlKvnkd13TUpmpw0Dvzf++KcJCpYFijXPPNFA9Mrnhxl1eoGDwEE
 XtZgH+BBr7wygnP0vE/DJyohNUqWbv8uwhLK+y0pdFn3kKlNuhR5q/iloJ2YaRW/wqgcyIG9t
 xuNBfiGqeX662JsqneRRVyh5qEVPmqgctDnyqqQIaVZ1sVPmYr/4zq4EaIY2OTvz1CFYYMWcO
 0BF67463QCiu6EfUfh99g3rsL1BKytmqA3VeEdD579wIHBayBbXYWvoAAMO/i/o1V02oEwUTr
 WTciptRj1xrV5mAIE7GPLioZS7k9jpQQeEsPmOihIt+uaAFgXESwtdZbqKbUf/Iqgu1qoFa7n
 lihSA9PG2WM5RQfKBxzW4DfNnS0Bu9EgnWfVctrofxYwmFef3kbs/ADR9PqIg8nUUQ7vZA/MQ
 KhjDjwDHGB1BJkD5XFg53T0A0RfuFrxJkNuNkHDRMuXSovVsrXPy0/ei+Go3EPKV4olzLazg8
 08DrNfH9uC3WeDfqXlo8DH6IU6tvh35eC5OxAlV5w0Z/wFI9x14GxAfb1M707FBf8hWDodewI
 sLfAYT4RM9yuXQd8AcND5QYGQ3CN/3/9lYCmVEEKqLMJmlXxstUycbz/WsX/Ew6BZta46bjjW
 GJUQB01RnsKm3fcJD/sUSSete+XiX4DjQyKgIMCDU4hZOdzz9WuRmD9O1i865Bg5QyHQ4Tmw6
 Pst3Qa04Zdb9YKY1fUn+9d2KLd1YU4YYOPdEfqZiPJYmvVWNKgGegsuQLrDjITUQBWsPkRAqx
 e8dUmjmh0+rBYNdv7NGiWsUutW2u7FcghXW7VCIHL0tAj5vkKyWijmHBqCrR9T/oFQ1UxN1xW
 hd5WyPxzoq/RbynHOIIotPsDxko1k/yWiOyFBam4Za37sXbll1+4azpbOc6OucWQfonkQK6Y5
 rva30adqLTZMKkZjMcknIL3tn+h7cI

Rename ACER_CAP_FAN_SPEED_READ to ACER_CAP_HWMON to prepare for
upcoming changes in the hwmon handling code.

Tested-by: Rayan Margham <rayanmargham4@gmail.com>
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/acer-wmi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-w=
mi.c
index 5cff538ee67f..dd57787466b9 100644
=2D-- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -246,7 +246,7 @@ struct hotkey_function_type_aa {
 #define ACER_CAP_TURBO_LED		BIT(8)
 #define ACER_CAP_TURBO_FAN		BIT(9)
 #define ACER_CAP_PLATFORM_PROFILE	BIT(10)
-#define ACER_CAP_FAN_SPEED_READ		BIT(11)
+#define ACER_CAP_HWMON			BIT(11)

 /*
  * Interface type flags
@@ -358,7 +358,7 @@ static void __init set_quirks(void)

 	if (quirks->predator_v4)
 		interface->capability |=3D ACER_CAP_PLATFORM_PROFILE |
-					 ACER_CAP_FAN_SPEED_READ;
+					 ACER_CAP_HWMON;
 }

 static int __init dmi_matched(const struct dmi_system_id *dmi)
@@ -2551,7 +2551,7 @@ static int acer_platform_probe(struct platform_devic=
e *device)
 			goto error_platform_profile;
 	}

-	if (has_cap(ACER_CAP_FAN_SPEED_READ)) {
+	if (has_cap(ACER_CAP_HWMON)) {
 		err =3D acer_wmi_hwmon_init();
 		if (err)
 			goto error_hwmon;
=2D-
2.39.5


