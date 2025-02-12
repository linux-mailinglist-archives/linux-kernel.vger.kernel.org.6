Return-Path: <linux-kernel+bounces-510485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8EEA31DB2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 06:06:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14D7B7A34E9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 05:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A51486353;
	Wed, 12 Feb 2025 05:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sdore.me header.i=@sdore.me header.b="bvkhKi2I"
Received: from sdore.me (unknown [95.165.1.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D862BD10
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 05:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.165.1.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739336758; cv=none; b=sqpOpWwaUiVWyNVQMLj7fOIKng+6bRO1HZke3V6LsQSkHJrIKKs1/J5AM5HX3OkF6gCr+fRxOvp3dTr0MWaRiuVjjygxSGKNcoj3J5KSnMeqlOTUJitEbQDsktkRHD+8OLwSCRSc7XDkn0Nf/wD/tvCMD2bk+NwcQMh0QnZ9/YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739336758; c=relaxed/simple;
	bh=jBow0XBFS4NkVA2SAiZo353ClhCTYHuSKNX+QguRRms=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=Lt6uRQT1jDydTRbfetINI9BiEUFWlMWmcBRRMPwDgZH9Wt8/W+5ByAnf3o4cbK2comEKl9UuTegz5pZD6o0ubS8lAetlXOsIzeZObzQULVdqJsFHkzikdygdFWOunEoSQWG+xHnBixYIoX5V5k6VByag6Il0Zu9iB9WdRInu7s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sdore.me; spf=pass smtp.mailfrom=sdore.me; dkim=pass (1024-bit key) header.d=sdore.me header.i=@sdore.me header.b=bvkhKi2I; arc=none smtp.client-ip=95.165.1.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sdore.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sdore.me
Received: from [192.168.1.2] (beast.lan [192.168.1.2])
	by sdore.me (Postfix) with ESMTPSA id 80C11EE79A0C6;
	Wed, 12 Feb 2025 08:05:54 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sdore.me; s=SERV;
	t=1739336754; bh=jBow0XBFS4NkVA2SAiZo353ClhCTYHuSKNX+QguRRms=;
	h=Subject:From:Reply-To:To:Cc:Date;
	b=bvkhKi2IDfgS1+SaLEqoNVl59MlZOPT/q5z0Kj0o9cVMWKkKIXwSUMOrGBkYJ3eEr
	 /iQc0SfkeUrPvJZdtTPhP/yTMClS6yaK/Gqzkj+WMP045CYYMTbGVSL6LMU9rvdqkK
	 v69X6HM3CwOVyy9W3gSAPiu1XMQJcoCa6A+IP4tw=
Message-ID: <7cab8349bc8bb6fa08d2a7127a724efea155f154.camel@sdore.me>
Subject: [PATCH v2] drm/edid: Implement DisplayID Type IX & X timing blocks
 parsing
From: Egor Vorontsov <sdoregor@sdore.me>
Reply-To: sdoregor@sdore.me
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, Maarten Lankhorst	
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Jani Nikula
 <jani.nikula@linux.intel.com>, Egor Vorontsov <sdoregor@sdore.me>
Date: Wed, 12 Feb 2025 08:05:54 +0300
Autocrypt: addr=sdoregor@sdore.me; prefer-encrypt=mutual;
 keydata=mQINBGDSFnMBEADfvtLiuRL6CHdMzETKrux7sNHWG+eJ2+pgRZ3Nc9pH/YWqjoed8OpFx
 OLeUxr9YSQ3uMD//JEe3+Sgte29Z3PAAHVkCwKBIucCnhHpXbcQZgC9xYMCd6GWR5+DpXN9szOIyb
 kvnEtuqTddz6Q7fYsaFDs0pH3jUUWmSAyCn2JCIRfT22XgO44B/yoqnM3JXHAayeHbEAQOzMe81q3
 deauI9W7SC9ScRT6VkgLuc+SxqH99el/OkiKTe/QpO6I6cVS8leesqnOGffkRPos/o2eRonqgDu0e
 Mw4YTu0x5iNr8Lbr4TefU2W1l6M3MNwOsLmI+58+3fK1vh0QqZ70NC4eyD9UEXk3mJyV7epfNU6fY
 0mFJbAhGV1TXomcy2MlOD1rDixw85zdK5uUwp0tfEkpxqKtihJmrTdApOTTVed303CLzgDsMokTIe
 aUOPqVZoWFDkvOzq6IppBkApJHBf1lcLlgwEn3cLQlGpYRSSi5NY3+UYtcOEZLDbF3TO6ncY8W2h3
 yQH/sAcSllfKKvkhdqEz4/Mha3GbZQXWgjrLy9BcISsQFj+DBN54I6a6kLm2n5wXH99sOp7s3jMeN
 zSU6PtuxZq4Gkt2K5JGT8yrIdfJfOH7yRUVm+8JqKNKqd6oczlDKV+lzRk9M/kjb8VQivaNSNwTo9
 3NxEuft0+tZgwARAQABtCJFZ29yIFZvcm9udHNvdiA8c2RvcmVnb3JAc2RvcmUubWU+iQJOBBMBCA
 A4FiEEXlTCjXwaPBiJP3U33a9iH2xv60MFAmDSFnMCGwMFCwkIBwIGFQoJCAsCBBYCAwECHgECF4A
 ACgkQ3a9iH2xv60OquRAAgbgenXi+Ud0tYoAz6giuFKYqzuEYuoSVkjxYvZq90ODrzbu7EdvMVuKA
 qNqYjs3VRBPBMHXhJKEftKbX4bZwCoC2o2wB5oV5O13jVN083r49FTLCxmOoufCkaqscBBxi/X2T6
 +i0n5Nqx5NLBL0kE4NMTk1jxEEyuEjv7bBMs196G/d3EpNJT3YGkLXBUibpaSaVjE6zBr3UygieLD
 2QXNkRJubx2d0FoD8TezSt5hsHWg9FOElsW6ZImRI+5q+ptL39K3cpjxHMKyhmo7xypD5XNWdmsmV
 1+STnK7R+id18xs7JUDxHBtG7Z/3K6txgF5CPbPvtaEi9fB3K/uS03BnIzsY2/cY3r9UHHrHa/sP6
 DhDwj9dr2xIFG5w6ZNh4mUTHEJoWKEEsYKwXy2eJCB3XvP7GURAm8fXdIapONbHDYj7XX49Mj+LBr
 s4PNBuKaZTFgGQ6RSc7LpAR56xaEDR93m7zNy84mQtpab/owaox1A+BEujzKK/vEDvj9f8EWlWZRa
 DH2auNNAxdr2ACR8RzkojcFDCErAgc5sFQrgVUlvNmMdn3VL0CWmndzEQxsOdgVk9SwoHHYpHf4Cg
 gtchq3pTQ5XSRaP/wxOtQpzqJWq5uFERBTLU8WRXYv3mM3KMdvtTJadF8+P+KSSnn+/yHahR0HKVx
 PtHSH7Px/vI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Some newer high refresh rate consumer monitors (including those by Samsung)
make use of DisplayID 2.1 timing blocks in their EDID data, notably for
their highest refresh rate modes. Such modes won't be available as of now.

Implement partial support for such blocks in order to enable native
support of HRR modes of most such monitors for users without having to rely
on EDID patching/override (or need thereof).

Closes: https://gitlab.freedesktop.org/drm/misc/kernel/-/issues/55
Suggested-by: Maximilian Bo=C3=9Fe <max@bosse.io>
Signed-off-by: Egor Vorontsov <sdoregor@sdore.me>
---
 drivers/gpu/drm/drm_displayid_internal.h | 13 +++++
 drivers/gpu/drm/drm_edid.c               | 63 ++++++++++++++++++++++++
 2 files changed, 76 insertions(+)

diff --git a/drivers/gpu/drm/drm_displayid_internal.h b/drivers/gpu/drm/drm=
_displayid_internal.h
index aee1b86a73c1..88220c107822 100644
--- a/drivers/gpu/drm/drm_displayid_internal.h
+++ b/drivers/gpu/drm/drm_displayid_internal.h
@@ -66,6 +66,7 @@ struct drm_edid;
 #define DATA_BLOCK_2_STEREO_DISPLAY_INTERFACE	0x27
 #define DATA_BLOCK_2_TILED_DISPLAY_TOPOLOGY	0x28
 #define DATA_BLOCK_2_CONTAINER_ID		0x29
+#define DATA_BLOCK_2_TYPE_10_FORMULA_TIMING	0x2a
 #define DATA_BLOCK_2_VENDOR_SPECIFIC		0x7e
 #define DATA_BLOCK_2_CTA_DISPLAY_ID		0x81
=20
@@ -129,6 +130,18 @@ struct displayid_detailed_timing_block {
 	struct displayid_detailed_timings_1 timings[];
 };
=20
+struct displayid_formula_timings_9 {
+	u8 flags;
+	__be16 hactive;
+	__be16 vactive;
+	u8 vrefresh;
+} __packed;
+
+struct displayid_formula_timing_block {
+	struct displayid_block base;
+	struct displayid_formula_timings_9 timings[];
+} __packed;
+
 #define DISPLAYID_VESA_MSO_OVERLAP	GENMASK(3, 0)
 #define DISPLAYID_VESA_MSO_MODE		GENMASK(6, 5)
=20
diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index 13bc4c290b17..9c363df5af9a 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -6833,6 +6833,66 @@ static int add_displayid_detailed_1_modes(struct drm=
_connector *connector,
 	return num_modes;
 }
=20
+static struct drm_display_mode *drm_mode_displayid_formula(struct drm_devi=
ce *dev,
+							   const struct displayid_formula_timings_9 *timings,
+							   bool type_10)
+{
+	struct drm_display_mode *mode;
+	u16 hactive =3D be16_to_cpu(timings->hactive) + 1;
+	u16 vactive =3D be16_to_cpu(timings->vactive) + 1;
+	u8 timing_formula =3D timings->flags & 0x7;
+
+	/* TODO: support RB-v2 & RB-v3 */
+	if (timing_formula > 1)
+		return NULL;
+
+	/* TODO: support video-optimized refresh rate */
+	if (timings->flags & (1 << 4))
+		return NULL;
+
+	mode =3D drm_cvt_mode(dev, hactive, vactive, timings->vrefresh + 1, timin=
g_formula =3D=3D 1, false, false);
+	if (!mode)
+		return NULL;
+
+	/* TODO: interpret S3D flags */
+
+	mode->type =3D DRM_MODE_TYPE_DRIVER;
+	drm_mode_set_name(mode);
+
+	return mode;
+}
+
+static int add_displayid_formula_modes(struct drm_connector *connector,
+				       const struct displayid_block *block)
+{
+	const struct displayid_formula_timing_block *formula_block =3D (struct di=
splayid_formula_timing_block *)block;
+	int num_timings;
+	struct drm_display_mode *newmode;
+	int num_modes =3D 0;
+	bool type_10 =3D block->tag =3D=3D DATA_BLOCK_2_TYPE_10_FORMULA_TIMING;
+	int timing_size =3D 6 + ((formula_block->base.rev & 0x70) >> 4);
+
+	/* extended blocks are not supported yet */
+	if (timing_size !=3D 6)
+		return 0;
+
+	if (block->num_bytes % timing_size)
+		return 0;
+
+	num_timings =3D block->num_bytes / timing_size;
+	for (int i =3D 0; i < num_timings; i++) {
+		const struct displayid_formula_timings_9 *timings =3D &formula_block->ti=
mings[i];
+
+		newmode =3D drm_mode_displayid_formula(connector->dev, timings, type_10)=
;
+		if (!newmode)
+			continue;
+
+		drm_mode_probed_add(connector, newmode);
+		num_modes++;
+	}
+	return num_modes;
+}
+
 static int add_displayid_detailed_modes(struct drm_connector *connector,
 					const struct drm_edid *drm_edid)
 {
@@ -6845,6 +6905,9 @@ static int add_displayid_detailed_modes(struct drm_co=
nnector *connector,
 		if (block->tag =3D=3D DATA_BLOCK_TYPE_1_DETAILED_TIMING ||
 		    block->tag =3D=3D DATA_BLOCK_2_TYPE_7_DETAILED_TIMING)
 			num_modes +=3D add_displayid_detailed_1_modes(connector, block);
+		else if (block->tag =3D=3D DATA_BLOCK_2_TYPE_9_FORMULA_TIMING ||
+			 block->tag =3D=3D DATA_BLOCK_2_TYPE_10_FORMULA_TIMING)
+			num_modes +=3D add_displayid_formula_modes(connector, block);
 	}
 	displayid_iter_end(&iter);
=20
--=20
2.48.0

