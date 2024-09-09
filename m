Return-Path: <linux-kernel+bounces-321935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75AB4972177
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 19:59:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CE671C23A91
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 17:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3655D17BED4;
	Mon,  9 Sep 2024 17:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vR8U2wt2"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E943178CE8
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 17:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725904748; cv=fail; b=G7VihBAwEguEGcM6HuqxKo9gVAD52Kx5drQyWj/vQ/L6XfwrAXMbFfq5BNadXprQTmO/+7+zNHBOj/wQIucmszgbcZifhDURAnvSpR1zgC5c3xj53zBFcChDXiMIkkDFY/Bw3BcqnUmqle4k4yGLCaIzd9JwdxOhXOClk2Ou8TU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725904748; c=relaxed/simple;
	bh=JwWp/1qpr0HLfw5fUK9U802YJcW+eRPVY6Cx+SlbWSo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nXK5gMqCJbPy4AyJSbJZGWjg2lqEiHEZDlDNBz05jAEO3AzUhS/EoMaszvVp4821L5OdqfU7MR6+pBhTDSND5lDh4c4xi6kPk9l0Ob4ejLTHoINsGCs7ZSeA4zJXDORYeqmsjY7ScCBsz1MY0KVBYSc3+e2eX4fDiy97GKE6+qM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vR8U2wt2; arc=fail smtp.client-ip=40.107.237.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iE1M5s0vzvR1RMU5lIZblwm6+iNMos4N9s/k0a1UAc+QwPBZ+Bj4fvznuosMi/r32NzDD5znpoxIr8krJ9OC2bM/Ivnm6DyTrzMYDS1cxV5lan90isF9DQhzabFaZEUzXh4c37fUPyU5YxBdwlOqi/AFPdam9MRhCz6E4JZKrDC2Ms/zp+dOwZVLRG31poygxdfHze5BBmvj8lqIHcRE2HgD0NFhR7el6mP6IN4znoGCLcltT/gBQPChT4bJjEXxnxRxd4Qpm3f2J4rG/tJozT2M4jJkiUMXl9/2rN2HSguMuSK/rFoywDLiIxACKvm3I2o0X2IvYd3Iv7co2PZhQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UbhgbFlZ4tb6Z05dvDF/s6njTC5IZA+VUA0coD0Q+rc=;
 b=Qsj9N6SGG6H6xKo8V2THM4tvap8Gyhuunlp/DorJ58Qr/S22395rKJrsXLM6LT4LUbJ2mma1ir5BpOzS726mjGbexTRSY2iZ+ccgkYcy8FUjzzFeB01jHAfTH+FSNBoQXKIIxNg4N1VeR8mmtAIFhAKYyhTqE5r4R2ohG4RIgyokDU9udnZR0x45dpSi/qatE95XJ15AaDQSBug0EJAoK+gOjmtrVEQ5p0X8T0EE4yCoHfVj8GH/DURlcSIA09e0V5MTcL6DaW0Z0XobJz3X646lsKX6tHPsXdhbUD7L999oj1lON78evBzT4RpX3v2JaQEuSuiOhU5QGOFwfeY06w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UbhgbFlZ4tb6Z05dvDF/s6njTC5IZA+VUA0coD0Q+rc=;
 b=vR8U2wt2QYSkEliWPoPZx6tiUBBTiXX5PVrMKXzRh8stlMRn7oWcB7D6QDnbfHZeBmfMargS8o9caCMXmbghs79dh6wFZoR/G0Ka0i/BLneZYYfX6W+3tUMG9Kh6giMgRhfyGDwSmakxr1KpG3uQFCSfwMxbDIZKlBMUMFqGf1w=
Received: from LV3PR12MB9260.namprd12.prod.outlook.com (2603:10b6:408:1b4::21)
 by LV3PR12MB9214.namprd12.prod.outlook.com (2603:10b6:408:1a4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.31; Mon, 9 Sep
 2024 17:59:01 +0000
Received: from LV3PR12MB9260.namprd12.prod.outlook.com
 ([fe80::e5c3:25dc:f93:cb99]) by LV3PR12MB9260.namprd12.prod.outlook.com
 ([fe80::e5c3:25dc:f93:cb99%3]) with mapi id 15.20.7918.024; Mon, 9 Sep 2024
 17:59:01 +0000
From: "Thangaraj, Senthil Nathan" <SenthilNathan.Thangaraj@amd.com>
To: "Jain, Ronak" <ronak.jain@amd.com>, "Simek, Michal" <michal.simek@amd.com>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] firmware: xilinx: use u32 for reset ID in reset APIs
Thread-Topic: [PATCH] firmware: xilinx: use u32 for reset ID in reset APIs
Thread-Index: AQHa+sQXZ0PGhZ/650qt77VTcWNPQLJPzkww
Date: Mon, 9 Sep 2024 17:59:01 +0000
Message-ID:
 <LV3PR12MB92605B94761C7F9E6DB1ECFCE2992@LV3PR12MB9260.namprd12.prod.outlook.com>
References: <20240830100042.3163511-1-ronak.jain@amd.com>
In-Reply-To: <20240830100042.3163511-1-ronak.jain@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9260:EE_|LV3PR12MB9214:EE_
x-ms-office365-filtering-correlation-id: 3f0c0b3c-d9c4-47ad-7ff9-08dcd0f915f5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Ta10SxI6AhdYSYYdDE+EX8Zj8zsD+ldLMFvSXKjqRhMtHX7mOn9HHiMz46iF?=
 =?us-ascii?Q?HgZKwH36nhQoeqM5HuVbeXH+pVtH0z4Gutk0xe4SUX9jG28a7haA5dNz9GXD?=
 =?us-ascii?Q?yYJ/EOGN3Yavbv1O2Y+SJWEhixyztVljVNXFK9CNhBu2csjH9Tmp5Yn5cD52?=
 =?us-ascii?Q?FsP+hxduhdpMe88ORC7qXL6lpkd3FXjjBE5RQnEGmqh4i2yG2j4slSLV/nPQ?=
 =?us-ascii?Q?bstsPfMYy2jiCTnxjvD4swOOlXAF/5YrnacenCg8nXFFupRHlic3SYfRKLq9?=
 =?us-ascii?Q?4GMWOHPhd6qIwpm2GlepJ3+S4IV+QVmBfGQpNZKDIJiCDEYoeQ6eLp6MM7h+?=
 =?us-ascii?Q?Yvpq6nXUKva0IXuL6jk80nRzKYizv8OOf5oB9+TioKRWQzYWDhlLTJYgNFIQ?=
 =?us-ascii?Q?6Ws554+z7x02uaAF6KZDJp1BndmVhqejZyeh7X4sEimrGAuND0k1T9lXbk/o?=
 =?us-ascii?Q?pTGdzOkfPudKnWUzyoMh4vwI1SiBNntN96b2aqseN5QJsGKjbTcpGGDzcLEr?=
 =?us-ascii?Q?Sxzj76w/I+kshY3mlTkkjUHMV4nJxTfVgRrcbRu+xD/fwOprebXXjWnZS2/i?=
 =?us-ascii?Q?LG8gPFTR/o17h4R247//fsAXSgxsuIkIC+AgiNovnUdZ8L3GHvICiI8Bl9g7?=
 =?us-ascii?Q?ZwdwqcpaRDC90hJTICveoRV9rzhYrKARBL2c9xHJ9dgof9MPar34YCrcWwVB?=
 =?us-ascii?Q?UadBZLuN56nNmjnByFvHNLaAr3bo6t+3Mq1c3N7oIVWYE8ctCYbYdYrqQSmg?=
 =?us-ascii?Q?vUj4aoK9NVkv6N/gIgipwrcfvmOY01Vn8fp1yqFkOUQxgOmhLQoJcBSKyJNf?=
 =?us-ascii?Q?Lgy9OnejGNyXl5lTB1ozo7IQydd5ji5FUag6aDfcXRaoO0Nufg2GLw5gfCHX?=
 =?us-ascii?Q?mYXrasqiMFupEG6yeGz0uciPJIHMkpb7esAF6jxiGxS7W4ajYMvELNauU0HY?=
 =?us-ascii?Q?BeBFAacpNUHHreTkXCxQRt6MsUtlBkKfUyAeHeioIHdevSjK9zkb2pOPrKeD?=
 =?us-ascii?Q?bAQcca9SGv+Ffh89GiN+kdkLasxjQOAwm8OwGibiNLAx8dSGWxVgI0UesE34?=
 =?us-ascii?Q?1wfJ9N7GkVCPQf01fzMBDkLXmUu8r557kjKVefSVwhmuM3Rv8dtNt8+MkstS?=
 =?us-ascii?Q?wY2JiNTyWcec1WRNNFeKcN/g6I6DNuwVMopwvCIuoYHfKnII9+voyEGiPqy0?=
 =?us-ascii?Q?lIJi8r0+zDZIEGtmIUL+Ieu4JgbwTcr4GsxXh5mGgno/x/qe2pOXVUlCQ7Uk?=
 =?us-ascii?Q?cHGiB84u9NleMPULjLeu2RVBy8A0PjpDrxWauhX9hC48ssLa9Alr4AOfUW5v?=
 =?us-ascii?Q?zSeGKwJu1hI2ggUkSlkKo6OXXrxtHvxCF1xucHkzaQdqxdCx43QCRA2fbrD+?=
 =?us-ascii?Q?qTTuT29i2apZjcMdAvKkNPk6dijzDLFctc4DF3YlcffRzFRzzA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9260.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?EVA0MxUsmluB2IAbmHnXigdBICqTLImjjs3j5b5OcUyhWoz/kb+IdrfCKkAC?=
 =?us-ascii?Q?l5yPJ0j6pzVH8NpT0c2OvDAtwxPdxVYlO4/K9F1rqO3XtPOKM94Kxodmkp4T?=
 =?us-ascii?Q?uN/rKM+fppyKWl7hhBnz9YObLsu4GzC8VwYw6zcwMiijzOzV0ZDSEnLZYepW?=
 =?us-ascii?Q?Vd/MJylcZiuQKxvMmHL/2eAQ07zZfZoOlRz3Y6KXG+ub6gOQ6JGktsIqcrmC?=
 =?us-ascii?Q?hDcEpam9QTnxrPuNBpqWWEWAbeiIPizT5DCUVTOvnH1OKrDkn9U1NcXHHmK7?=
 =?us-ascii?Q?vSnA/E62hxtCo20HZhGYb9N4r1cRBPKP1j4vohkBv775z6/QkJEGKxM6swtm?=
 =?us-ascii?Q?Bz8KTUfhNF+T6w5EtwBb3W9RLLLrfSDOtHNKn3KSri3mEMDc+Et7GD+KN67/?=
 =?us-ascii?Q?WjDz3CHSLKKdnwhSJVcESZRb2ZN1J7T1mJBBaDq/7h2T+GGVTmLSwAQRFbH/?=
 =?us-ascii?Q?X5ozie/kk/njzLwYpjcB8uAxlZHShqImpECVgNtE2L5K+l6aESHX11GyMfEI?=
 =?us-ascii?Q?kZYSeiOOle3mESr8j5ph9EIXrOXn0rvLExRzVzBCWAnPwX50xWCJxU6rb0GU?=
 =?us-ascii?Q?0egR4NAz4GTYYXfptTI+/5xhE8u60FYf7q+8tMmsUJDUrA6sMFXTopH/IerK?=
 =?us-ascii?Q?5GJRCk85X3XBa8241vlfVvZx0AD9xbJ0e/QJt7zAKcyMlf5FDe+6579n8IQ8?=
 =?us-ascii?Q?5KS4LzLaXtqiT7X1/2mF5tnqNKxfeAqoxUo/BGv8LjK0dNzcy0lz01nFfpuv?=
 =?us-ascii?Q?S2yU9rRWNKTziFa4hOobbUVb5YIbiuZTJLlrZ8+YuiyTRZS22zAhXr2s98wl?=
 =?us-ascii?Q?qXlIG35V5K/0U2Y364+Hjd6wwI2MwJgq5GK5YNQxAemC90bRaYxXRHEI+9iZ?=
 =?us-ascii?Q?zhYVZ1uW1Rv17c6BcSLdflMDJUqjGfp23cY+py6cflKC6dp5MvB1x8HT7Wr4?=
 =?us-ascii?Q?td28TsU09w9cpN52ZtPTP7pPv2JjoVY85bqHZU0YmeudsPUs53HBQDPGmssn?=
 =?us-ascii?Q?B/oCKgPtJT1HLPPsW9TEweeNEBDqoYgJ5928M8yZ6q2/g7ulJaKtcjQjIRGn?=
 =?us-ascii?Q?S8Vih1rAhxqe8eDMyCwpBTAFNw/WNN9CpB57tQhOEHGuFTAWO+ejPkjlxKkU?=
 =?us-ascii?Q?CUjvtRY00GEnuGoky7adRy7b7UFDLgPmUhlPaPVA7Lu6Gg5NcICzrUMeBBey?=
 =?us-ascii?Q?HokeciN0vGn6XSWX2qhC+oI5W4PaIenJpuHxuG5MiPCZY/9oE8hO5XLbfe33?=
 =?us-ascii?Q?TBlFZceel2++2444S9EbHmC/34w8k5J0KnLrwX2BVOhixUUmcAwshFiFZDXm?=
 =?us-ascii?Q?r97adslDGaKzUIIueS0OEYmFSADbx1jwXB6L5mMyXKa8/hBXbmnnmoSeFJoM?=
 =?us-ascii?Q?n9Wfy3dXldX87bkndDlgt509WJ39KD3Fiko3ofTlTaydUPuM/kn0N68AWwhB?=
 =?us-ascii?Q?G2LOJjn457LvbzvvpocnTsRLKZxe7zSb/J8TjJLH0rFfOb3fgYO/3I+5ic7a?=
 =?us-ascii?Q?EnnBRjrPMnbWTfma9J+WpfmXL1r3iwrsKOOAUr/KZXcl6H6CMDNTIBib8TIh?=
 =?us-ascii?Q?W+w+6kuBE+HFenqYryw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9260.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f0c0b3c-d9c4-47ad-7ff9-08dcd0f915f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2024 17:59:01.3518
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ioU7vTkszjtrqrtWflvcIr6Kl92xTlyBLJ4Ws3RGrA9OZvd0UYZXkNxmuLZRaSAUgzw87iXELW4fvvNEX7AiYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9214

LGTM.

Best regards,
Senthil

> -----Original Message-----
> From: linux-arm-kernel <linux-arm-kernel-bounces@lists.infradead.org> On
> Behalf Of Ronak Jain
> Sent: Friday, August 30, 2024 3:01 AM
> To: Simek, Michal <michal.simek@amd.com>
> Cc: linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> Subject: [PATCH] firmware: xilinx: use u32 for reset ID in reset APIs
>=20
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>=20
>=20
> Refactors the reset handling mechanisms by replacing the reset ID's enum =
type
> with a u32. This update improves flexibility, allowing the reset ID to
> accommodate a broader range of values, including those that may not fit i=
nto
> predefined enum values.
>=20
> The use of u32 for reset ID enhances extensibility, especially for hardwa=
re
> platforms or features where more granular control of reset operations is
> required. By shifting to a general integer type, this change reduces cons=
traints
> and simplifies integration with other system components that rely on non-
> enum-based reset IDs.
>=20
> Signed-off-by: Ronak Jain <ronak.jain@amd.com>
> ---
>  drivers/firmware/xilinx/zynqmp.c     | 4 ++--
>  include/linux/firmware/xlnx-zynqmp.h | 9 ++++-----
>  2 files changed, 6 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/firmware/xilinx/zynqmp.c
> b/drivers/firmware/xilinx/zynqmp.c
> index add8acf66a9c..c8be32d9c6af 100644
> --- a/drivers/firmware/xilinx/zynqmp.c
> +++ b/drivers/firmware/xilinx/zynqmp.c
> @@ -920,7 +920,7 @@ int zynqmp_pm_set_boot_health_status(u32 value)
>   *
>   * Return: Returns status, either success or error+reason
>   */
> -int zynqmp_pm_reset_assert(const enum zynqmp_pm_reset reset,
> +int zynqmp_pm_reset_assert(const u32 reset,
>                            const enum zynqmp_pm_reset_action assert_flag)=
  {
>         return zynqmp_pm_invoke_fn(PM_RESET_ASSERT, NULL, 2, reset,
> assert_flag); @@ -934,7 +934,7 @@
> EXPORT_SYMBOL_GPL(zynqmp_pm_reset_assert);
>   *
>   * Return: Returns status, either success or error+reason
>   */
> -int zynqmp_pm_reset_get_status(const enum zynqmp_pm_reset reset, u32
> *status)
> +int zynqmp_pm_reset_get_status(const u32 reset, u32 *status)
>  {
>         u32 ret_payload[PAYLOAD_ARG_CNT];
>         int ret;
> diff --git a/include/linux/firmware/xlnx-zynqmp.h
> b/include/linux/firmware/xlnx-zynqmp.h
> index 563382cf16f2..5b938fc2adad 100644
> --- a/include/linux/firmware/xlnx-zynqmp.h
> +++ b/include/linux/firmware/xlnx-zynqmp.h
> @@ -557,9 +557,9 @@ int zynqmp_pm_get_pll_frac_data(u32 clk_id, u32
> *data);  int zynqmp_pm_set_sd_tapdelay(u32 node_id, u32 type, u32 value);
> int zynqmp_pm_sd_dll_reset(u32 node_id, u32 type);  int
> zynqmp_pm_ospi_mux_select(u32 dev_id, u32 select); -int
> zynqmp_pm_reset_assert(const enum zynqmp_pm_reset reset,
> +int zynqmp_pm_reset_assert(const u32 reset,
>                            const enum zynqmp_pm_reset_action assert_flag)=
; -int
> zynqmp_pm_reset_get_status(const enum zynqmp_pm_reset reset, u32
> *status);
> +int zynqmp_pm_reset_get_status(const u32 reset, u32 *status);
>  unsigned int zynqmp_pm_bootmode_read(u32 *ps_mode);  int
> zynqmp_pm_bootmode_write(u32 ps_mode);  int
> zynqmp_pm_init_finalize(void); @@ -702,14 +702,13 @@ static inline int
> zynqmp_pm_ospi_mux_select(u32 dev_id, u32 select)
>         return -ENODEV;
>  }
>=20
> -static inline int zynqmp_pm_reset_assert(const enum zynqmp_pm_reset
> reset,
> +static inline int zynqmp_pm_reset_assert(const u32 reset,
>                                          const enum zynqmp_pm_reset_actio=
n assert_flag)  {
>         return -ENODEV;
>  }
>=20
> -static inline int zynqmp_pm_reset_get_status(const enum zynqmp_pm_reset
> reset,
> -                                            u32 *status)
> +static inline int zynqmp_pm_reset_get_status(const u32 reset, u32
> +*status)
>  {
>         return -ENODEV;
>  }
> --
> 2.25.1
>=20


