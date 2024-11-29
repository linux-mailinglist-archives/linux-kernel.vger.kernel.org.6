Return-Path: <linux-kernel+bounces-425917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A585F9DEC85
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 20:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27578B20F95
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 19:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63111A2C3A;
	Fri, 29 Nov 2024 19:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="bgBid7pt"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366681AA1E2;
	Fri, 29 Nov 2024 19:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732908865; cv=none; b=swZJ79GvmqythW1WWsY+8I9BYYxTQlxWZTtHHiQeKwAxtHItCNbC1KdSCqNc/t6AkULHRR8Z3zregzCdAq7KYl4Lw1CkWOVMr8WGvV9aQfjwLcZoqovxLJ1qsxr08EOuLPRXCsy7L6+ZNnGojOqjSvJN9SujfJRdDWbB+tX6+eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732908865; c=relaxed/simple;
	bh=05k/9UcKLbPpUNI20HD7zkO4ItYfXtjrurnHnRktDT0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OMFco7jnANTMbGvubcW/xXoA4zvFmdNswItkP1+rMnfHqti8enGx0iyobYqCbSVGPvTQTK8Qkb8JulryhOqURndvgo01wzGrscbWtlWuGJNR/oZjpNIwRaCXhtG4Zyc0LtgAwLG5PLCPcLQqaYKe0Q98XQqCqJwUTq1bDcG7irs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=bgBid7pt; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1732908855; x=1733513655; i=w_armin@gmx.de;
	bh=t6ZQnbK0ISvkSX2rlaJconU2QD2RLMH+szPFATosBag=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=bgBid7ptiT+N4bWNNQuiH3LrXUL6rGxMTNmvfwlOxxJgiW3UCY6+tgDN/6uzlqkP
	 bTw5veVkw4p0DsWXbzbwT9jHCAHvY9P2Nyo/Na5LDst3ADyFHWWddTGz/NcGK5JV/
	 XvrM6mszwfazZFVqPKJzIBYbjSrgCvnHi3FngAQFUAFc07kGwy1QQcRQEXBMvxL9k
	 mHFpucpHhkYIhrV6z2a4+Po722CGSppYTGYo8AArfUNA6zclN+PYCqUU9nWUjdzlQ
	 HIZP0iyqo7aI23nyWC9H97CgUuk00WJtoqkYuyrvi6Rjcujg/IpOxBDH0qNeN42zI
	 rm6JiHQK3c+1HWPV4w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-inspiron.fritz.box ([141.30.226.119]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MIdeR-1tVh460pE5-0020HT; Fri, 29 Nov 2024 20:34:15 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: jlee@suse.com,
	farhan.anwar8@gmail.com,
	rayanmargham4@gmail.com
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/5] platform/x86: acer-wmi: Ignore AC events
Date: Fri, 29 Nov 2024 20:33:59 +0100
Message-Id: <20241129193359.8392-6-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241129193359.8392-1-W_Armin@gmx.de>
References: <20241129193359.8392-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9cYNdBGfOHpmRWvfy6JWc9X2lD6GF7p6JT/rfTMaHN30+qnNXPA
 mFzkoarIAX07Lijj60s29W1bReT9rdEzNjLV8FaDAXkCsiJgHCj4c/WtAfW+bMxh/Peayqi
 AmdS8TKvZmAJSJHX9/VHILeq+Pvzp7/LRuDDmA340G6PwygbRfbPz9xcVTv2dnAeEfdYn7T
 l1xOCj/BHgqTwIUk17zRQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ssdQnrYdjhg=;0cVrCF3VkamVbuGtLsEIPvOT+aS
 tGRDcCYMKpjqvKwv0HDBYFJzxPYXf4bQaoZiMePMzSBjaYm6asVPGPxn4wVarO0wr6hxhfr9e
 TP1GJFgDP6IdZkkqaJlamkY+ymhA2BYLeR0cqMdzKItlTix1Wo7ffAoqfaNnMHh1PAw4afyT9
 BMkvSMK3X+xxd+0URrdpsVBITh3bEeNYT1vnzcIgHn0EfkmX71I6lKioVQi395uS/4t0wFqbk
 3NIrALImcp9JRuwFwr96yOCG5rHYNQ48T0G4odKqKmA8EGj+fDCxFzHV2YV7JK/hI+yNwbbU7
 XfHKR97uZvZ0XfplMa7CfrHovDjIQPzO9TDwRdWH5wKlHfyz/KKycYa9hNb/xabs5tyRXfuZf
 CRkVdYnEXXl6Xw6RphwFmReArZHchLtHX3ctyp38mLAYIK8lb8i+T/WYXVmMwnYI4pNnUrTxc
 2AYgvkaFsX0vIdKUk4God4pxPIUY+3DPu4KPDAjQDUfNQt4Mul8/vhjvVLGkcPTgPp5+frAD3
 prJBhaaGsGzVYTyv8TfzFcOiFdBAUXPBsVGZNqIZ//WanB3bnKZHn8DYSPhN8lM5gz23MkF3G
 /KNJjK6c+mjYeVxVGvvBbv2LD+MjLSnara/3AvbyK5BnqJ55rBnRyxmLpvn4W0kntX5dmdaj1
 5nfaP0vdUCCo9/RYQOu0TsspfSwkliF/ez1BFqTu16B4PWcKBp3PWKVv6RRi6+uRysAlHkdSl
 0r0GAgcW+aRziYZrQGcokjH9HFQQOX2i3FzAd0taO1D4Hxj6LhduGkJDBpJre9hvhf4Qu0VMo
 Kw4nxxCpXu8tFL20xLQ/eHCn5jv979G0becQ9UFGD2BqoiOCKe+8RVDdUq7xyVDHP4LVC5b8p
 ECE4x2t1Lk80PPp+77ZlpgNRVh1qFmcrI2JioypB71x2PRPGz8yY5iPS6GDyMBsLcDG+JAoZH
 oMxYzESlwajJqd/rcZjwYDc7pB/9iztWllkKuCweIH4exH0CAYQGnktTQhst9Oe8OZVW6zqNd
 Uni+LckXvX6BJB+AUduuWrfPpUn15GS5MdWaDAGhWUrjJ8Im2a0/cBonGmkMGiJxqk9eBUXBa
 5slMJ3+dV5W2MTSZDtebNkBU0GFerI

On the Acer Swift SFG14-41, the events 8 - 1 and 8 - 0 are printed on
AC connect/disconnect. Ignore those events to avoid spamming the
kernel log with error messages.

Reported-by: Farhan Anwar <farhan.anwar8@gmail.com>
Closes: https://lore.kernel.org/platform-driver-x86/2ffb529d-e7c8-4026-a3b=
8-120c8e7afec8@gmail.com
Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/acer-wmi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-w=
mi.c
index 2c1ea6155bd3..18fc706ea752 100644
=2D-- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -100,6 +100,7 @@ enum acer_wmi_event_ids {
 	WMID_HOTKEY_EVENT =3D 0x1,
 	WMID_ACCEL_OR_KBD_DOCK_EVENT =3D 0x5,
 	WMID_GAMING_TURBO_KEY_EVENT =3D 0x7,
+	WMID_AC_EVENT =3D 0x8,
 };

 enum acer_wmi_predator_v4_sys_info_command {
@@ -2305,6 +2306,9 @@ static void acer_wmi_notify(union acpi_object *obj, =
void *context)
 		if (return_value.key_num =3D=3D 0x5 && has_cap(ACER_CAP_PLATFORM_PROFIL=
E))
 			acer_thermal_profile_change();
 		break;
+	case WMID_AC_EVENT:
+		/* We ignore AC events here */
+		break;
 	default:
 		pr_warn("Unknown function number - %d - %d\n",
 			return_value.function, return_value.key_num);
=2D-
2.39.5


