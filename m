Return-Path: <linux-kernel+bounces-287762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0245D952C4D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 12:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 807F91F21B7B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 10:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88881C8FAB;
	Thu, 15 Aug 2024 09:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QTip9mKT"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C621714C4;
	Thu, 15 Aug 2024 09:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723715013; cv=none; b=sJv4PWYsRD7AUSH9xNhnge7k1f5TOPrPq/1/Vl4ko6tnFENGfyvBhhdzaTL/XsHjyIPjT9bTgXT3IqGpcbpa3mNXpmDNoeIBztyqQzcQkfhY8r/G55OpH1F8OPpFYMq4F7KAfjJRXnb0kraTxKp27+5A+DI2gZxd6ZlcB/oTfx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723715013; c=relaxed/simple;
	bh=NrLs93XFP0bBJYBfCivHBnoe5FqGMnlxEWXmj6A8rn8=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=p34Jeu5i/kRy+0+P58OazzgCcGQsm4VdnwVDy1yi7cZq/a3DPYKJoN7PbevWz+9ZVLBZ3rDBAnBeXEK9IhK/hGGr2wt4tdo51RHvtCQKMr2Rqz7AC+X7jwGWE6BLliK56i+0rG1j5+RYiUTH9ftkoUUZLzfBTcRxWQQkQaBM1MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QTip9mKT; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723715012; x=1755251012;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=NrLs93XFP0bBJYBfCivHBnoe5FqGMnlxEWXmj6A8rn8=;
  b=QTip9mKTMEl8GM16OwLR/yh3nGFHora/1anCfJVKM92wmPoCyFcEJ3GO
   TI940vWK5seOPII3HiriYXjeqSO2upjg9o/pxR8qFTT72xr4ngHHOQD5R
   MZQQifIcs65AoIbqLvZPjm/HeBtrlB/WiowRrQ12MDvz3DpaFcd+iLp5Y
   XUWQ8V5ob3nnRdsUan+Q2D5nwy89Jc9f0JOar5ziUOY1ZGOnIebw/C7K8
   eX2w6FhLh4M8zIGahMPBftw+bT7yLDnfEqkknOjmBDl2NRgY4gQecB12a
   bXMCWUwq1sV7ynYTl1y/aGyr+FwhHxMlZs6Y0zO4scqAXr2G13ZE7TvIS
   g==;
X-CSE-ConnectionGUID: pLmZovBvRiitivlsDTNFSw==
X-CSE-MsgGUID: F1WjtiqSQHixuSv8urppfQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11164"; a="25825960"
X-IronPort-AV: E=Sophos;i="6.10,148,1719903600"; 
   d="scan'208";a="25825960"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 02:43:30 -0700
X-CSE-ConnectionGUID: tgjsgnBTSaesT5WkCahx7A==
X-CSE-MsgGUID: dklTsQzTSXafDW2iRIjxpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,148,1719903600"; 
   d="scan'208";a="64134468"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.159])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 02:43:27 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 15 Aug 2024 12:43:22 +0300 (EEST)
To: Matthias Fetzer <kontakt@matthias-fetzer.de>
cc: hmh@hmh.eng.br, Hans de Goede <hdegoede@redhat.com>, 
    ibm-acpi-devel@lists.sourceforge.net, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] platform/x86: thinkpad_acpi: Add Thinkpad Edge E531
 fan support
In-Reply-To: <20240814213927.49075-1-kontakt@matthias-fetzer.de>
Message-ID: <919d4531-45dd-6edc-e541-63c1c79dc0ce@linux.intel.com>
References: <e4e32316-509c-28c6-fd18-38ed17e9e35a@linux.intel.com> <20240814213927.49075-1-kontakt@matthias-fetzer.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1790389497-1723715002=:2018"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1790389497-1723715002=:2018
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 14 Aug 2024, Matthias Fetzer wrote:

> Fan control on the E531 is done using the ACPI methods FANG and
> FANW. The correct parameters and register values were found by
> analyzing EC firmware as well as DSDT. This has been tested on
> my Thinkpad Edge E531 (6885CTO, BIOS HEET52WW 1.33).
>=20
> Signed-off-by: Matthias Fetzer <kontakt@matthias-fetzer.de>
> ---

Thanks for the update, looks good now.

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.


> Changes in v3:
>     - Add missing newline
>     - Remove redundant code
> Changes in v2:
>     - Fix typo in EC memory description
>     - Split plausibilty check for better readability
>=20
>  drivers/platform/x86/thinkpad_acpi.c | 150 ++++++++++++++++++++++++++-
>  1 file changed, 149 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/=
thinkpad_acpi.c
> index 397b409064c9..64d1b49b7e48 100644
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
> @@ -8157,6 +8213,8 @@ static int fan2_get_speed(unsigned int *speed)
> =20
>  static int fan_set_level(int level)
>  {
> +=09int rc;
> +
>  =09if (!fan_control_allowed)
>  =09=09return -EPERM;
> =20
> @@ -8206,6 +8264,37 @@ static int fan_set_level(int level)
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
> +=09=09=09=09rc =3D -EIO;
> +=09=09=09=09break;
> +=09=09=09}
> +=09=09=09if (!acpi_evalf(fanw_handle, NULL, NULL, "vdd", 0x8100, 0x00)) =
{
> +=09=09=09=09rc =3D -EIO;
> +=09=09=09=09break;
> +=09=09=09}
> +=09=09} else {
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
> +=09=09=09if (!acpi_evalf(fanw_handle, NULL, NULL, "vdd", 0x8102, level *=
 100 / 7)) {
> +=09=09=09=09rc =3D -EIO;
> +=09=09=09=09break;
> +=09=09=09}
> +=09=09}
> +=09=09break;
> +
>  =09default:
>  =09=09return -ENXIO;
>  =09}
> @@ -8284,6 +8373,19 @@ static int fan_set_enable(void)
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
> @@ -8326,6 +8428,22 @@ static int fan_set_disable(void)
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
> @@ -8359,6 +8477,23 @@ static int fan_set_speed(int speed)
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
> @@ -8701,6 +8836,10 @@ static int __init fan_init(struct ibm_init_struct =
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
> @@ -8720,6 +8859,9 @@ static int __init fan_init(struct ibm_init_struct *=
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
> @@ -8766,6 +8908,11 @@ static int __init fan_init(struct ibm_init_struct =
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
> @@ -8917,6 +9064,7 @@ static int fan_read(struct seq_file *m)
> =20
>  =09case TPACPI_FAN_RD_TPEC_NS:
>  =09case TPACPI_FAN_RD_TPEC:
> +=09case TPACPI_FAN_RD_ACPI_FANG:
>  =09=09/* all except 570, 600e/x, 770e, 770x */
>  =09=09rc =3D fan_get_status_safe(&status);
>  =09=09if (rc)
> @@ -8937,7 +9085,7 @@ static int fan_read(struct seq_file *m)
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
--8323328-1790389497-1723715002=:2018--

