Return-Path: <linux-kernel+bounces-400653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A66BF9C108E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 22:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C6421F21ADD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 21:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CBE6219494;
	Thu,  7 Nov 2024 20:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=stowell.pro header.i=@stowell.pro header.b="W7RzPxiv"
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F384219493
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 20:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731013189; cv=none; b=jcuwToLXWBlWv6d6j5KIMKI1tpB+l31goLSA9gi85OMgT8d7idJsGfj0EfyvvO9wwb5613/Oci+THh1eSh9kGLcYP/q74OvfmBzrAxwSqIHBkN78if33Lh5m7PGmO6XccBQUz0+L2clCPSilOdHrIWzcAKEg8ytObWsn0Bd4VOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731013189; c=relaxed/simple;
	bh=VoW+AYdBn5gDEVrzqejl/zPu6fJnlNOqEnSv20OCuAQ=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=m3XvccghEk1KF3OmTK7c94S3RR9hdj8RQt7i/n61WTL/4HBriovkHqVwZnTdA+YTjIPtyrkynmet92Et2zb1eHHUle8o31T8cIq7Tyd49cuZfs5YJ5hBRVT4Dde4V/IlNFh9PdD7FqBF1j8niNTUcwNlYzDtdYFOQkrXj0fHpq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=stowell.pro; spf=pass smtp.mailfrom=stowell.pro; dkim=pass (2048-bit key) header.d=stowell.pro header.i=@stowell.pro header.b=W7RzPxiv; arc=none smtp.client-ip=185.70.43.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=stowell.pro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stowell.pro
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stowell.pro;
	s=protonmail2; t=1731013179; x=1731272379;
	bh=2KKVWwxWrzZiJudXl2IJdjfWIC9VUE6VdAF45niX7AM=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=W7RzPxiv7EtzhX1UMj/Qg9pERHAxVGzL0LF6Wukm0V7OxtcS0kt0RvoiGwYhEkge7
	 3H6DbfIOZLuqrDErGdkTbe67f3rRoNgXwLSjciFxRdnYHDFjcirFzotUxBMIJNae1g
	 diM5nTvxJ1Xb4QLyrELIsh/2AN1Ka85Yye5DQNqujAZvyY8q2r4IMxdQDN0FVuRJW2
	 Ued6PaMPGAQy/Z0txjBJA1Lq18YZvxCinca5SOEBleYu8cILYZlVW/yVdicTKc4OrC
	 B4eNEpZCOtVu3Apb61SrYHwIKg3s9ihMhbCfzrUs3A5zJHFfqp9DUyG+LlNOxsjRo6
	 /XQu3KmTg7ADw==
Date: Thu, 07 Nov 2024 20:59:34 +0000
To: platform-driver-x86@vger.kernel.org
From: Cole Stowell <cole@stowell.pro>
Cc: linux-kernel@vger.kernel.org, ilpo.jarvinen@linux.intel.com, hdegoede@redhat.com, alexhung@gmail.com, Cole Stowell <cole@stowell.pro>, Mary Strodl <mstrodl@csh.rit.edu>
Subject: [PATCH] intel-hid: fix volume buttons on Thinkpad X12 Detachable Tablet Gen 1
Message-ID: <20241107205908.69279-1-cole@stowell.pro>
Feedback-ID: 52027723:user:proton
X-Pm-Message-ID: 69dba8408ba6a9b7f1ea045692cf3f00a9751864
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="------6ccf60ec37fdeaadf84b2f486a6a80766953055f5159cc843b264bf7087ce119"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------6ccf60ec37fdeaadf84b2f486a6a80766953055f5159cc843b264bf7087ce119
Content-Type: multipart/mixed;
 boundary=93d17a1c425e04f8d3181cdb373a4041be4f3ddf37cacaf8a88cf0bbcaee
From: Cole Stowell <cole@stowell.pro>
To: platform-driver-x86@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com,
	hdegoede@redhat.com,
	alexhung@gmail.com,
	Cole Stowell <cole@stowell.pro>,
	Mary Strodl <mstrodl@csh.rit.edu>
Subject: [PATCH] intel-hid: fix volume buttons on Thinkpad X12 Detachable Tablet Gen 1
Date: Thu,  7 Nov 2024 15:59:08 -0500
Message-ID: <20241107205908.69279-1-cole@stowell.pro>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0

--93d17a1c425e04f8d3181cdb373a4041be4f3ddf37cacaf8a88cf0bbcaee
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Volume buttons on Lenovo Thinkpad X12 Detachable Tablet Gen 1 did not
send any input events when pressed. When loading intel-hid with the 5
Button Array explicitly enabled, the buttons functioned normally.

Adds the X12 Detachable Tablet Gen 1 to the `button_array_table`.

However, the driver is unable to call INTEL_HID_DSM_BTNE_FN and prints
the warning "failed to set button capability" when attempting to enable
or disable the 5 Button Array. I'm not sure if this is normal,
but the warning seems harmless.

Co-developed-by: Mary Strodl <mstrodl@csh.rit.edu>
Signed-off-by: Mary Strodl <mstrodl@csh.rit.edu>
Signed-off-by: Cole Stowell <cole@stowell.pro>
---
 drivers/platform/x86/intel/hid.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/platform/x86/intel/hid.c b/drivers/platform/x86/intel/hid.c
index 445e7a59beb4..48ad75a56199 100644
--- a/drivers/platform/x86/intel/hid.c
+++ b/drivers/platform/x86/intel/hid.c
@@ -118,6 +118,13 @@ static const s
truct dmi_system_id button_array_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "HP Spectre x2 Detachable"),
 		},
 	},
+	{
+		.ident = "Lenovo ThinkPad X1 Tablet Gen 1",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_FAMILY, "ThinkPad X12 Detachable Gen 1"),
+		},
+	},
 	{
 		.ident = "Lenovo ThinkPad X1 Tablet Gen 2",
 		.matches = {
-- 
2.47.0


--93d17a1c425e04f8d3181cdb373a4041be4f3ddf37cacaf8a88cf0bbcaee
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - cole@stowell.pro -
 0x146D8A8D.asc"; name="publickey - cole@stowell.pro - 0x146D8A8D.asc"
Content-Type: application/pgp-keys; filename="publickey - cole@stowell.pro -
 0x146D8A8D.asc"; name="publickey - cole@stowell.pro - 0x146D8A8D.asc"

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tClZlcnNpb246IEdvcGVuUEdQIDIu
Ny40CkNvbW1lbnQ6IGh0dHBzOi8vZ29wZW5wZ3Aub3JnCgp4ak1FWXROQ3l4WUpLd1lCQkFIYVJ3
OEJBUWRBdDFuUjNGc0RpRTQ4MysvNy80OThpWFJLRlZUa1VINlFEWmZVCkI3dmM1Z25OSTJOdmJH
VkFjM1J2ZDJWc2JDNXdjbThnUEdOdmJHVkFjM1J2ZDJWc2JDNXdjbTgrd284RUVCWUsKQUNBRkFt
TFRRc3NHQ3drSENBTUNCQlVJQ2dJRUZnSUJBQUlaQVFJYkF3SWVBUUFoQ1JCUzFKbHFMdngyWXhZ
aApCQlJ0aW8zc0ErZFRGTlFMeEZMVW1Xb3UvSFpqZnRvQS9SNDhmZ096OENDSGg1Z0RNYm9NT0JT
bDdaVzVuYmtwCnRvWkFmRTJGUUVadEFQc0czbDdPY01JOXpqOERIbDRCMjNSUUJ1cXhGdUcvU1Bo
YVZyemRUeHVpQ000NEJHTFQKUXNzU0Npc0dBUVFCbDFVQkJRRUJCMEFEckFkN1JhWVgwTEhxL1Fh
MTBGMDJPM3ZzaTRRUm1IbGRhdktUQ3RUZgpSd01CQ0FmQ2VBUVlGZ2dBQ1FVQ1l0TkN5d0liREFB
aENSQlMxSmxxTHZ4Mll4WWhCQlJ0aW8zc0ErZFRGTlFMCnhGTFVtV291L0haalltRUJBUGVzSVll
WlRCVTFra1ZNQ011b0xrSm4wdUlmRTlHc2FZKzJCajBUSXpxaUFQOWwKZ3JYUkpoVm13d1pQVHFK
aFNXb0NSTFFRdXR1bnRBNm5neWlvd01lS0JRPT0KPTBCTDkKLS0tLS1FTkQgUEdQIFBVQkxJQyBL
RVkgQkxPQ0stLS0tLQ==
--93d17a1c425e04f8d3181cdb373a4041be4f3ddf37cacaf8a88cf0bbcaee--

--------6ccf60ec37fdeaadf84b2f486a6a80766953055f5159cc843b264bf7087ce119
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wnUEARYIACcFAmctKjUJEFLUmWou/HZjFiEEFG2KjewD51MU1AvEUtSZai78
dmMAAJ/XAQCcr2za6oMkL8WGR9iRYjehNoqmJzd9yKzBKEX5QdFhJQEA6JtG
mpFT3uWC7e8bI8qh0HaY7wnOcAyeFneYUmcgBAc=
=qpQI
-----END PGP SIGNATURE-----


--------6ccf60ec37fdeaadf84b2f486a6a80766953055f5159cc843b264bf7087ce119--


