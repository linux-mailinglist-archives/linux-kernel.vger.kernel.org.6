Return-Path: <linux-kernel+bounces-289830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE38954C0F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 16:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F2191C2445F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 14:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9891BC9F0;
	Fri, 16 Aug 2024 14:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ii+L9pyz"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E861AD9D6;
	Fri, 16 Aug 2024 14:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723817716; cv=none; b=ndv9mnslq1EWBNqExFA3jt+0EHU1KQHJYHz3D3Kw/djbGyCWI22TSdj6vQ9JpaYvEqfXn7h2SE0sD+oDlU/eYYGhKs0neWge+38diHCWJxR0Q0RAL1+mN999FLWhBHGkefBB4ryTCIZO0Ab40LP5yEHj7Sn2KyB2CG2uH0adThc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723817716; c=relaxed/simple;
	bh=kxQ8LdJsE9TFVX22ZLXdxRAkZCbvjNZRZjxJVwJD5G8=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ZSjJtBRLUQ/Jd5SuFzjeIQ4oXUSKs/U1Ar84qwwAeBCsMqKQr/MBo26LH/rHy4D1P7Th28ZO2n+XvAqoOqQ4cvIysLufcVAnlc0ZdCjUKHnB1SmyEWy6PfncKhNS1G/tkS5KICZMHY/7TAXlZA84yVMz3oKRf2Mp1OLUMnBBio0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ii+L9pyz; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723817715; x=1755353715;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=kxQ8LdJsE9TFVX22ZLXdxRAkZCbvjNZRZjxJVwJD5G8=;
  b=Ii+L9pyzXpwWpcjjL1pfUuYL7MLkVDKWn/TjQHRbVJ6KGuvh93faNtjM
   ofE1hI2TPlm8y4Lb3S61JPgwD+LlA0ES7FoxwtYLGA16KEjNiJBZPoZMI
   2DQKRLqeOcGg++OoPXK2W+rULGffaSX6CNYMkSQa4eLKsbJ/ZqOzNlZGP
   hLVxvhH7TN/hMT7E1kemdSHoDGWaJ94prkmVptDxKaO33cTF66nlL+Sg3
   S4331txxo00ozXN7GzmszmKdpEXcbipiEqNjJpDZJ9Uzqo6gd9RT99Ecf
   S/f3MsRMaA8lNvJyfgb5biSFQldzLv7poRejUhshkvY9qLUvDgy1znN3X
   A==;
X-CSE-ConnectionGUID: lLtHnH/rREWDsmQ+yjFg0A==
X-CSE-MsgGUID: yQqE68ZNRUOOMP67ML7oHQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="32748830"
X-IronPort-AV: E=Sophos;i="6.10,151,1719903600"; 
   d="scan'208";a="32748830"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 07:15:14 -0700
X-CSE-ConnectionGUID: Q6NfC0G6RaWw2d3Q3weuzQ==
X-CSE-MsgGUID: mLHjXzO3QrOvlSqjg/nRZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,151,1719903600"; 
   d="scan'208";a="64081123"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.28])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 07:15:11 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 16 Aug 2024 17:15:07 +0300 (EEST)
To: Matthias Fetzer <kontakt@matthias-fetzer.de>
cc: hmh@hmh.eng.br, Hans de Goede <hdegoede@redhat.com>, 
    ibm-acpi-devel@lists.sourceforge.net, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] platform/x86: thinkpad_acpi: Add Thinkpad Edge E531
 fan support
In-Reply-To: <20240816141228.134529-1-kontakt@matthias-fetzer.de>
Message-ID: <212dd31b-7506-31ae-afde-7ebb93b24e24@linux.intel.com>
References: <e1fe661c-281d-9d59-be53-968f7a0bc18a@linux.intel.com> <20240816141228.134529-1-kontakt@matthias-fetzer.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-239761419-1723817707=:1024"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-239761419-1723817707=:1024
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 16 Aug 2024, Matthias Fetzer wrote:

> Fan control on the E531 is done using the ACPI methods FANG and
> FANW. The correct parameters and register values were found by
> analyzing EC firmware as well as DSDT. This has been tested on
> my Thinkpad Edge E531 (6885CTO, BIOS HEET52WW 1.33).
>=20
> Signed-off-by: Matthias Fetzer <kontakt@matthias-fetzer.de>

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

> ---
>=20
> Changes in v4:
>     - Remove unnecessary variable
> Changes in v3:
>     - Add missing newline
>     - Remove redundant code
> Changes in v2:
>     - Fix typo in EC memory description
>     - Split plausibilty check for better readability
>=20
>  drivers/platform/x86/thinkpad_acpi.c | 143 ++++++++++++++++++++++++++-
>  1 file changed, 142 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/=
thinkpad_acpi.c
> index 397b409064c9..96c58bc59018 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -7751,6 +7751,28 @@ static struct ibm_struct volume_driver_data =3D {
>   * =09EC 0x2f (HFSP) might be available *for reading*, but do not use
>   * =09it for writing.
>   *
> + * TPACPI_FAN_RD_ACPI_FANG:
> + * =09ACPI FANG method: returns fan control register
> + *
> + *=09Takes one parameter which is 0x8100 plus the offset to EC memory
> + *=09address 0xf500 and returns the byte at this address.
> + *
> + *=090xf500:
> + *=09=09When the value is less than 9 automatic mode is enabled
> + *=090xf502:
> + *=09=09Contains the current fan speed from 0-100%
> + *=090xf506:
> + *=09=09Bit 7 has to be set in order to enable manual control by
> + *=09=09writing a value >=3D 9 to 0xf500
> + *
> + * TPACPI_FAN_WR_ACPI_FANW:
> + * =09ACPI FANG method: sets fan control registers
> + *
> + * =09Takes 0x8100 plus the offset to EC memory address 0xf500 and the
> + * =09value to be written there as parameters.
> + *
> + *=09see TPACPI_FAN_RD_ACPI_FANG
> + *
>   * TPACPI_FAN_WR_TPEC:
>   * =09ThinkPad EC register 0x2f (HFSP): fan control loop mode
>   * =09Supported on almost all ThinkPads
> @@ -7884,6 +7906,7 @@ enum {=09=09=09=09=09/* Fan control constants */
>  enum fan_status_access_mode {
>  =09TPACPI_FAN_NONE =3D 0,=09=09/* No fan status or control */
>  =09TPACPI_FAN_RD_ACPI_GFAN,=09/* Use ACPI GFAN */
> +=09TPACPI_FAN_RD_ACPI_FANG,=09/* Use ACPI FANG */
>  =09TPACPI_FAN_RD_TPEC,=09=09/* Use ACPI EC regs 0x2f, 0x84-0x85 */
>  =09TPACPI_FAN_RD_TPEC_NS,=09=09/* Use non-standard ACPI EC regs (eg: L13=
 Yoga gen2 etc.) */
>  };
> @@ -7891,6 +7914,7 @@ enum fan_status_access_mode {
>  enum fan_control_access_mode {
>  =09TPACPI_FAN_WR_NONE =3D 0,=09=09/* No fan control */
>  =09TPACPI_FAN_WR_ACPI_SFAN,=09/* Use ACPI SFAN */
> +=09TPACPI_FAN_WR_ACPI_FANW,=09/* Use ACPI FANW */
>  =09TPACPI_FAN_WR_TPEC,=09=09/* Use ACPI EC reg 0x2f */
>  =09TPACPI_FAN_WR_ACPI_FANS,=09/* Use ACPI FANS and EC reg 0x2f */
>  };
> @@ -7924,9 +7948,13 @@ TPACPI_HANDLE(fans, ec, "FANS");=09/* X31, X40, X4=
1 */
>  TPACPI_HANDLE(gfan, ec, "GFAN",=09/* 570 */
>  =09   "\\FSPD",=09=09/* 600e/x, 770e, 770x */
>  =09   );=09=09=09/* all others */
> +TPACPI_HANDLE(fang, ec, "FANG",=09/* E531 */
> +=09   );=09=09=09/* all others */
>  TPACPI_HANDLE(sfan, ec, "SFAN",=09/* 570 */
>  =09   "JFNS",=09=09/* 770x-JL */
>  =09   );=09=09=09/* all others */
> +TPACPI_HANDLE(fanw, ec, "FANW",=09/* E531 */
> +=09   );=09=09=09/* all others */
> =20
>  /*
>   * Unitialized HFSP quirk: ACPI DSDT and EC fail to initialize the
> @@ -8033,6 +8061,23 @@ static int fan_get_status(u8 *status)
> =20
>  =09=09break;
>  =09}
> +=09case TPACPI_FAN_RD_ACPI_FANG: {
> +=09=09/* E531 */
> +=09=09int mode, speed;
> +
> +=09=09if (unlikely(!acpi_evalf(fang_handle, &mode, NULL, "dd", 0x8100)))
> +=09=09=09return -EIO;
> +=09=09if (unlikely(!acpi_evalf(fang_handle, &speed, NULL, "dd", 0x8102))=
)
> +=09=09=09return -EIO;
> +
> +=09=09if (likely(status)) {
> +=09=09=09*status =3D speed * 7 / 100;
> +=09=09=09if (mode < 9)
> +=09=09=09=09*status |=3D TP_EC_FAN_AUTO;
> +=09=09}
> +
> +=09=09break;
> +=09}
>  =09case TPACPI_FAN_RD_TPEC:
>  =09=09/* all except 570, 600e/x, 770e, 770x */
>  =09=09if (unlikely(!acpi_ec_read(fan_status_offset, &s)))
> @@ -8147,6 +8192,17 @@ static int fan2_get_speed(unsigned int *speed)
>  =09=09if (speed)
>  =09=09=09*speed =3D lo ? FAN_RPM_CAL_CONST / lo : 0;
>  =09=09break;
> +=09case TPACPI_FAN_RD_ACPI_FANG: {
> +=09=09/* E531 */
> +=09=09int speed_tmp;
> +
> +=09=09if (unlikely(!acpi_evalf(fang_handle, &speed_tmp, NULL, "dd", 0x81=
02)))
> +=09=09=09return -EIO;
> +
> +=09=09if (likely(speed))
> +=09=09=09*speed =3D  speed_tmp * 65535 / 100;
> +=09=09break;
> +=09}
> =20
>  =09default:
>  =09=09return -ENXIO;
> @@ -8206,6 +8262,32 @@ static int fan_set_level(int level)
>  =09=09=09tp_features.fan_ctrl_status_undef =3D 0;
>  =09=09break;
> =20
> +=09case TPACPI_FAN_WR_ACPI_FANW:
> +=09=09if (!(level & TP_EC_FAN_AUTO) && (level < 0 || level > 7))
> +=09=09=09return -EINVAL;
> +=09=09if (level & TP_EC_FAN_FULLSPEED)
> +=09=09=09return -EINVAL;
> +
> +=09=09if (level & TP_EC_FAN_AUTO) {
> +=09=09=09if (!acpi_evalf(fanw_handle, NULL, NULL, "vdd", 0x8106, 0x05)) =
{
> +=09=09=09=09return -EIO;
> +=09=09=09}
> +=09=09=09if (!acpi_evalf(fanw_handle, NULL, NULL, "vdd", 0x8100, 0x00)) =
{
> +=09=09=09=09return -EIO;
> +=09=09=09}
> +=09=09} else {
> +=09=09=09if (!acpi_evalf(fanw_handle, NULL, NULL, "vdd", 0x8106, 0x45)) =
{
> +=09=09=09=09return -EIO;
> +=09=09=09}
> +=09=09=09if (!acpi_evalf(fanw_handle, NULL, NULL, "vdd", 0x8100, 0xff)) =
{
> +=09=09=09=09return -EIO;
> +=09=09=09}
> +=09=09=09if (!acpi_evalf(fanw_handle, NULL, NULL, "vdd", 0x8102, level *=
 100 / 7)) {
> +=09=09=09=09return -EIO;
> +=09=09=09}
> +=09=09}
> +=09=09break;
> +
>  =09default:
>  =09=09return -ENXIO;
>  =09}
> @@ -8284,6 +8366,19 @@ static int fan_set_enable(void)
>  =09=09=09rc =3D 0;
>  =09=09break;
> =20
> +=09case TPACPI_FAN_WR_ACPI_FANW:
> +=09=09if (!acpi_evalf(fanw_handle, NULL, NULL, "vdd", 0x8106, 0x05)) {
> +=09=09=09rc =3D -EIO;
> +=09=09=09break;
> +=09=09}
> +=09=09if (!acpi_evalf(fanw_handle, NULL, NULL, "vdd", 0x8100, 0x00)) {
> +=09=09=09rc =3D -EIO;
> +=09=09=09break;
> +=09=09}
> +
> +=09=09rc =3D 0;
> +=09=09break;
> +
>  =09default:
>  =09=09rc =3D -ENXIO;
>  =09}
> @@ -8326,6 +8421,22 @@ static int fan_set_disable(void)
>  =09=09=09fan_control_desired_level =3D 0;
>  =09=09break;
> =20
> +=09case TPACPI_FAN_WR_ACPI_FANW:
> +=09=09if (!acpi_evalf(fanw_handle, NULL, NULL, "vdd", 0x8106, 0x45)) {
> +=09=09=09rc =3D -EIO;
> +=09=09=09break;
> +=09=09}
> +=09=09if (!acpi_evalf(fanw_handle, NULL, NULL, "vdd", 0x8100, 0xff)) {
> +=09=09=09rc =3D -EIO;
> +=09=09=09break;
> +=09=09}
> +=09=09if (!acpi_evalf(fanw_handle, NULL, NULL, "vdd", 0x8102, 0x00)) {
> +=09=09=09rc =3D -EIO;
> +=09=09=09break;
> +=09=09}
> +=09=09rc =3D 0;
> +=09=09break;
> +
>  =09default:
>  =09=09rc =3D -ENXIO;
>  =09}
> @@ -8359,6 +8470,23 @@ static int fan_set_speed(int speed)
>  =09=09=09rc =3D -EINVAL;
>  =09=09break;
> =20
> +=09case TPACPI_FAN_WR_ACPI_FANW:
> +=09=09if (speed >=3D 0 && speed <=3D 65535) {
> +=09=09=09if (!acpi_evalf(fanw_handle, NULL, NULL, "vdd", 0x8106, 0x45)) =
{
> +=09=09=09=09rc =3D -EIO;
> +=09=09=09=09break;
> +=09=09=09}
> +=09=09=09if (!acpi_evalf(fanw_handle, NULL, NULL, "vdd", 0x8100, 0xff)) =
{
> +=09=09=09=09rc =3D -EIO;
> +=09=09=09=09break;
> +=09=09=09}
> +=09=09=09if (!acpi_evalf(fanw_handle, NULL, NULL, "vdd",
> +=09=09=09=09=090x8102, speed * 100 / 65535))
> +=09=09=09=09rc =3D -EIO;
> +=09=09} else
> +=09=09=09rc =3D -EINVAL;
> +=09=09break;
> +
>  =09default:
>  =09=09rc =3D -ENXIO;
>  =09}
> @@ -8701,6 +8829,10 @@ static int __init fan_init(struct ibm_init_struct =
*iibm)
>  =09=09TPACPI_ACPIHANDLE_INIT(gfan);
>  =09=09TPACPI_ACPIHANDLE_INIT(sfan);
>  =09}
> +=09if (tpacpi_is_lenovo()) {
> +=09=09TPACPI_ACPIHANDLE_INIT(fang);
> +=09=09TPACPI_ACPIHANDLE_INIT(fanw);
> +=09}
> =20
>  =09quirks =3D tpacpi_check_quirks(fan_quirk_table,
>  =09=09=09=09     ARRAY_SIZE(fan_quirk_table));
> @@ -8720,6 +8852,9 @@ static int __init fan_init(struct ibm_init_struct *=
iibm)
>  =09if (gfan_handle) {
>  =09=09/* 570, 600e/x, 770e, 770x */
>  =09=09fan_status_access_mode =3D TPACPI_FAN_RD_ACPI_GFAN;
> +=09} else if (fang_handle) {
> +=09=09/* E531 */
> +=09=09fan_status_access_mode =3D TPACPI_FAN_RD_ACPI_FANG;
>  =09} else {
>  =09=09/* all other ThinkPads: note that even old-style
>  =09=09 * ThinkPad ECs supports the fan control register */
> @@ -8766,6 +8901,11 @@ static int __init fan_init(struct ibm_init_struct =
*iibm)
>  =09=09fan_control_access_mode =3D TPACPI_FAN_WR_ACPI_SFAN;
>  =09=09fan_control_commands |=3D
>  =09=09    TPACPI_FAN_CMD_LEVEL | TPACPI_FAN_CMD_ENABLE;
> +=09} else if (fanw_handle) {
> +=09=09/* E531 */
> +=09=09fan_control_access_mode =3D TPACPI_FAN_WR_ACPI_FANW;
> +=09=09fan_control_commands |=3D
> +=09=09    TPACPI_FAN_CMD_LEVEL | TPACPI_FAN_CMD_SPEED | TPACPI_FAN_CMD_E=
NABLE;
>  =09} else {
>  =09=09if (!gfan_handle) {
>  =09=09=09/* gfan without sfan means no fan control */
> @@ -8917,6 +9057,7 @@ static int fan_read(struct seq_file *m)
> =20
>  =09case TPACPI_FAN_RD_TPEC_NS:
>  =09case TPACPI_FAN_RD_TPEC:
> +=09case TPACPI_FAN_RD_ACPI_FANG:
>  =09=09/* all except 570, 600e/x, 770e, 770x */
>  =09=09rc =3D fan_get_status_safe(&status);
>  =09=09if (rc)
> @@ -8937,7 +9078,7 @@ static int fan_read(struct seq_file *m)
>  =09=09=09 * No other levels settings available
>  =09=09=09 */
>  =09=09=09seq_printf(m, "level:\t\t%s\n", status & FAN_NS_CTRL ? "unknown=
" : "auto");
> -=09=09} else {
> +=09=09} else if (fan_status_access_mode =3D=3D TPACPI_FAN_RD_TPEC) {
>  =09=09=09if (status & TP_EC_FAN_FULLSPEED)
>  =09=09=09=09/* Disengaged mode takes precedence */
>  =09=09=09=09seq_printf(m, "level:\t\tdisengaged\n");
>=20
--8323328-239761419-1723817707=:1024--

