Return-Path: <linux-kernel+bounces-530488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B9A0A43419
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 05:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75847168052
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 04:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B11D18B477;
	Tue, 25 Feb 2025 04:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="UcnN/8t7"
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazolkn19011027.outbound.protection.outlook.com [52.103.43.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EBCEEA9;
	Tue, 25 Feb 2025 04:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740457518; cv=fail; b=RAyVRE7wjrlSEbzyUDdzmlh3qWNkZiOu1DXxI0rlKzcN1RbvcvkosC84oGk/cbUz2db2M58nPNipq5t+8H3k//fJNPRwQrk94ymxtotCk+c3B1U0d7pRFVoC9i6Rgr9daEEK771vixoGfQ5kwyiteCWWXJIexdAF2q53VbuGYqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740457518; c=relaxed/simple;
	bh=AX77UlsrEg+ZxN7un4sVt/+vTpblCt96AQWkc0GY7MU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=l1V7O7uSL9/IXDUVXEay46GWwQFVpUc6ugAzPGHJZTkvyG9qX5mHCXXAtKdXaA93V0L5L/rdcHA5PWOmX/ntDZF3qLOoYcv4tapa0Ve1jKuqXGwo6h+OxWZdfkENwtZXRKyTnugFyk9iebNEAlrJj9nEdyElJ6JAjUZwhLNeb80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=UcnN/8t7; arc=fail smtp.client-ip=52.103.43.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YdKcXqqvjVi2ejyK+lDUR0Vo05MSKjNxvwaBH5t5gYnnsCPoqsW43AbYF1zsu/T/zrzaGPl3xpTH9PFKxgQoeSHHkErIZYJr8sjo0QTtg2R1KI+JwnHbC+hjo0rhE27+rsp4ABV+FLbx57zMiCI670OKcUFnpuqvOQfKsfwLUT6kWJKKGjkzkpyMMx4MkL5QSB9t6ersU+7ZKENR8T9uvqvPSDVNTJ/LjLdWhA172lff1ioGizI77L9tG7e1h2y1Eu5QfLYsjroaHqWs9SVilS6e5WwEADOGyjBVYZ4YCXc6d9M9GcY6pepCWZj397s03gyy3x9+xNEu57l1yua8mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9b5SmgOeYNihswM0NVFd7PxRc8zfPUHjUt9fli4wlIA=;
 b=FGu6cfZWXA+PU8VSUr06694bl2Qw6efH6j4bSavtc9aUaUotbjEbZZVBULFOXuXJbQ6RHvflPLETF+oS9cmud6B9gYqJW0ReNr9S6OetJCN1djceY6xglSbmHznNd4O6ST1/C5ySERMuxUf+c25YCNJO4bkW+XGKQ4vnfhOA5MNaL/AD84/TgNhw7eaXkqqbAqvMRfqT5QTODwFbJPGpMp5djPdgrxzQ1ww9DPe+uffKzGGaml1q5gYFZZUU/jnikOJhVMbeBMfZPVSYBDgIr7ZO9j6+R2srKFvYQpTV2MLwbKeb65DnHiyauqeiZtxazhbMLLV10A0qCEWj8k1eOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9b5SmgOeYNihswM0NVFd7PxRc8zfPUHjUt9fli4wlIA=;
 b=UcnN/8t7o16LzLC8knNb0d8Ryikjnz3sRIJVArHp5p+V/0H6Wyh5w1IYAO5k5JbolRJoHM1rkAcgH+wfCjfmxkNOEowf7SCcM1/Ha7sGjpDmaq4SqVix695p77AKNNyvbfEsp1qvKlaN85D/5LaapveTLw8w4ENSVNUnzy/osh76Q2assu/GOodkZQ3TTiERw6iyRTXjRnKWJVcnDU9Cocm03k2M2HGk6LTkayVwdrWYEuBjKaed++q76U+r/DW4fThPdQ8OM2BSOye9t4dsinqm4yTwbqhs/Qwz8310uBJi9Nt+dtF0bF3rBC5XZ42yk07Qhw+ITnDSWZbRhWcWOg==
Received: from TYCPR01MB8437.jpnprd01.prod.outlook.com (2603:1096:400:156::5)
 by TYWPR01MB9575.jpnprd01.prod.outlook.com (2603:1096:400:1a5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 04:25:13 +0000
Received: from TYCPR01MB8437.jpnprd01.prod.outlook.com
 ([fe80::83e7:751f:f3af:768f]) by TYCPR01MB8437.jpnprd01.prod.outlook.com
 ([fe80::83e7:751f:f3af:768f%5]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 04:25:13 +0000
From: Shengyu Qu <wiagn233@outlook.com>
To: jdelvare@suse.com,
	linux@roeck-us.net,
	corbet@lwn.net,
	eugene.shalygin@gmail.com,
	linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Shengyu Qu <wiagn233@outlook.com>
Subject: [PATCH v1] hwmon: (asus-ec-sensors) add PRIME X670E-PRO WIFI
Date: Tue, 25 Feb 2025 12:25:06 +0800
Message-ID:
 <TYCPR01MB84377BEADF97E8E7554EF0CF98C32@TYCPR01MB8437.jpnprd01.prod.outlook.com>
X-Mailer: git-send-email 2.48.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TPYP295CA0060.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:8::19) To TYCPR01MB8437.jpnprd01.prod.outlook.com
 (2603:1096:400:156::5)
X-Microsoft-Original-Message-ID: <20250225042506.9957-1-wiagn233@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB8437:EE_|TYWPR01MB9575:EE_
X-MS-Office365-Filtering-Correlation-Id: 12233d1e-6efb-4b5b-2134-08dd55546594
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|5072599009|7092599003|19110799003|15080799006|461199028|5062599005|440099028|3412199025|41001999003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ponirtIPFm7lhs74HvaL/WhUkz/eIMzfKmVQoLmcCDN4p9z8A2lkgeDgNctk?=
 =?us-ascii?Q?JRTUJXDOHuLU+ltHT5r7FbaPQwmoYOfXWIzgp/welzc+mCRFcnoN2/9NCbSm?=
 =?us-ascii?Q?5g8qA9D79htadBTpZBU5qa8a3otmB3v+QNhi7VDuWxKg1quLg1F7IiVZH4wE?=
 =?us-ascii?Q?8uecfdPSWZq5de3fuduJw7W8LYkzFt+OOo2NmeQaqBDg8uatF++FfejhAS70?=
 =?us-ascii?Q?Yzlm6PJFXcGIVosNmxA54rhA5RqUcNs5atzyNdTCS3uDRtccwweMIWPPBYxV?=
 =?us-ascii?Q?osQ8vA83Y4qX6OneOh1qPdRYUiOLhhZr5SUKgVp2V6ms2FbaQy9fGNJSyMge?=
 =?us-ascii?Q?e7BdzJx+YLPLvgM61+yI/6TL91KCMDup43znOIyHO7gLwq+qPRe/9hSLYp47?=
 =?us-ascii?Q?eNfuDr08XjmtRJKkG6gUtdQRyDkJMAC9D54/QpX98zgCUfzF0MHe/Q6EawgA?=
 =?us-ascii?Q?7zj1lgOoEAvf45zKRaNnuBg2oO3vwL9x1eexhsM0LL0vMBFWz2iXL2oitWPe?=
 =?us-ascii?Q?YjSoZTKvv2TUWgfaf4NvWex0gZ5nG09iPYidJ78ddQeglUl63FTUZaemLmbY?=
 =?us-ascii?Q?pzrHXmmeIXljfkf1fT5Re/euS7NqEj0DcvSt1rMovfxoX98GXJiGpubxYM9n?=
 =?us-ascii?Q?PqbaSP2TKKIn79CmMUGP4fJ6C8WCGczC7pwy+P/G976mPDwLWLXBzWLCbAfD?=
 =?us-ascii?Q?eCyOQxVi+YGofSCpjH4PU7gBKPJvgV5FxXS8FvUr28iOCYWQ/zsghbBWWhAl?=
 =?us-ascii?Q?9BZysQeXShwi0biB/aiVvISVgrBZzob4uVtfu9rZ9yCoImsiDZ+DKSSRJoJh?=
 =?us-ascii?Q?yckp5Ozj2QoYeITdwCLHpjgoOLym4LFqQcCH3X4j+KwyAgSMj/XfPPEFHZXF?=
 =?us-ascii?Q?TDjU1mET0l4UZaauZCR7DY3g4mAQt9FE5hTFTHr9t8q2lixSDSpv6wAuaKSb?=
 =?us-ascii?Q?okMcAg4UkXvvLgtp+vDHo4ZiZ4m4+zAagryul9uFmgNQhyXPHLxT5zM/v8Uw?=
 =?us-ascii?Q?S2oX8f4X/Z+YrZpzZgsgpPOdAhobOlGT6aWar3jhJvkkasQ/xDD/o5VcY82H?=
 =?us-ascii?Q?pg1/5bvQvLGp4/Y8YulNfvgDbJM/j45Pi72P+jT68i1JpwOneQ77VeUEaQPr?=
 =?us-ascii?Q?D5NNIUOlwHg8kpp2jsSKXKTMXwpxRawbCiGlnOzWdut7p058T60wzGU=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9OFDcEVxUX1OmPQ7N8pqB9dzqqfg4109au8DHfyLDFAOw3MJCddlbaKie7BK?=
 =?us-ascii?Q?XrSiflbtoS0T0bYYt/Vw3jr+88HHKYrRB3HxSZwj+9ZPtiytMQi+bK9lLimv?=
 =?us-ascii?Q?LMNhwrgZdtXQdPxMYkxmnTHAoBWWiYwUPayy6o5+ypbz6PjgB9OQ6t2qPhKY?=
 =?us-ascii?Q?oHiI0c+ufRFioJ8gKCCRkdtsndz4ilHeyKRnWqvpCEyq9zpIxlZ9T4Kk3vIj?=
 =?us-ascii?Q?eXU4liyHWe29mdhA4M1yf14zP+wuEMt75bQNvfICZpl4q2vtPthpAgVNh7m7?=
 =?us-ascii?Q?nD7d/m/Te4hOKnT9HVhEjeokqGqSazxNhl+hwf+d+bWhEDNHiJVgdcJq+227?=
 =?us-ascii?Q?cMqZfkqkE741LzLIhvnhB6k19UgPtsSiL2NbREWDs+gdT3ImCO7oDULzsCO9?=
 =?us-ascii?Q?GAZViuyTrs2GSA0x9jyzfgARJkYxNZnRUlcvcTG0Q7+e0k/s85Gi+wxZ/Gvr?=
 =?us-ascii?Q?RqoQgGqBOuZQ1IQp6R+szOybFvP/eUVICXSd2cvmiFnasJ9OZSKWgzSemGp8?=
 =?us-ascii?Q?sddByvGEr92+EefOEAjEk/tBWVYXoyGP9TbfNPhGZMx7KR5jWWHPZfAC9Iz9?=
 =?us-ascii?Q?4lg1s+US6dPNasMIEwk/Wxn/9FcuJA6sml0j44VkbxGE2pjoql3L96JckOQV?=
 =?us-ascii?Q?vW49MIvVj8ogKfG3ikGASxuxXPSLELXu/2RzL8qX1x/a/bpNKkZFZS7Pg1eP?=
 =?us-ascii?Q?qxGOKTBeRYe0qNt7vQiAuTwBZOz2uMNpfxU6bcrFlI8/iqLwM0Oati77DfVU?=
 =?us-ascii?Q?fhvt20jLSZ/D6cZDasdiStM6jZW0yBr9/Rj1o4XhjD0fGDkun16Xa50CvyV3?=
 =?us-ascii?Q?PgSXNlsvsjNxPPeZGDthwgQRk2oRR8Ov/qfcBGM5fPgJEa4XqQHGZW4mamz7?=
 =?us-ascii?Q?pZRE9e6cVoRK4QtYHWHAksq23a+KQwV/+5pw+8qoPBY3ZemeKZhYSq09psNG?=
 =?us-ascii?Q?ViNx37GhBNx9GcXp1u5lFXDvqnOYd8D9jY9GAEbyS+6ApNoTqWjrdLgMu9ZT?=
 =?us-ascii?Q?7VcoPtYnSPAX5agNLS2/6oqEQYH2dt0EtDZc3s//rvkxYQq2h/9b2mxQpUDz?=
 =?us-ascii?Q?+aN2R6e5cTqjfRjVLyckL4laTscxRZdpxWj/iQPUuLG+wmFr8yisbdbj/Dze?=
 =?us-ascii?Q?A6b/KQcq4Y3RauKFVwmAXkaQichQv9pNaOW1upKhMY+3EKUk4GwazQ39L0J8?=
 =?us-ascii?Q?NO71CeNvQj2Bb1EkZz4qUVo1C4tG3F1hmPi8fVFkTvNH8mWFcDw6zqRGxwbF?=
 =?us-ascii?Q?WsgBr+RMikOKPicl0VBxIxgALhUSBcKuZWuulC2E+aF2bZyvLnauHHtkZqlg?=
 =?us-ascii?Q?d6U=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12233d1e-6efb-4b5b-2134-08dd55546594
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB8437.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 04:25:13.1703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9575

Add support for PRIME X670E-PRO WIFI.

Signed-off-by: Shengyu Qu <wiagn233@outlook.com>
---
 Documentation/hwmon/asus_ec_sensors.rst |  1 +
 drivers/hwmon/asus-ec-sensors.c         | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/Documentation/hwmon/asus_ec_sensors.rst b/Documentation/hwmon/asus_ec_sensors.rst
index 739636cf7994..d2be9db29614 100644
--- a/Documentation/hwmon/asus_ec_sensors.rst
+++ b/Documentation/hwmon/asus_ec_sensors.rst
@@ -6,6 +6,7 @@ Kernel driver asus_ec_sensors
 Supported boards:
  * PRIME X470-PRO
  * PRIME X570-PRO
+ * PRIME X670E-PRO WIFI
  * Pro WS X570-ACE
  * ProArt X570-CREATOR WIFI
  * ProArt X670E-CREATOR WIFI
diff --git a/drivers/hwmon/asus-ec-sensors.c b/drivers/hwmon/asus-ec-sensors.c
index 43e54dc513da..006ced5ab6e6 100644
--- a/drivers/hwmon/asus-ec-sensors.c
+++ b/drivers/hwmon/asus-ec-sensors.c
@@ -316,6 +316,14 @@ static const struct ec_board_info board_info_prime_x570_pro = {
 	.family = family_amd_500_series,
 };
 
+static const struct ec_board_info board_info_prime_x670e_pro_wifi = {
+	.sensors = SENSOR_TEMP_CPU | SENSOR_TEMP_CPU_PACKAGE |
+		SENSOR_TEMP_MB | SENSOR_TEMP_VRM |
+		SENSOR_TEMP_T_SENSOR | SENSOR_FAN_CPU_OPT,
+	.mutex_path = ACPI_GLOBAL_LOCK_PSEUDO_PATH,
+	.family = family_amd_600_series,
+};
+
 static const struct ec_board_info board_info_pro_art_x570_creator_wifi = {
 	.sensors = SENSOR_SET_TEMP_CHIPSET_CPU_MB | SENSOR_TEMP_VRM |
 		SENSOR_TEMP_T_SENSOR | SENSOR_FAN_CPU_OPT |
@@ -503,6 +511,8 @@ static const struct dmi_system_id dmi_table[] = {
 					&board_info_prime_x470_pro),
 	DMI_EXACT_MATCH_ASUS_BOARD_NAME("PRIME X570-PRO",
 					&board_info_prime_x570_pro),
+	DMI_EXACT_MATCH_ASUS_BOARD_NAME("PRIME X670E-PRO WIFI",
+					&board_info_prime_x670e_pro_wifi),
 	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ProArt X570-CREATOR WIFI",
 					&board_info_pro_art_x570_creator_wifi),
 	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ProArt X670E-CREATOR WIFI",
-- 
2.48.1


