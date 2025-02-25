Return-Path: <linux-kernel+bounces-530720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82AE2A43780
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 09:23:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 039273AC255
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 08:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C273261399;
	Tue, 25 Feb 2025 08:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="wiFZl8xE"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012009.outbound.protection.outlook.com [52.101.66.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090B426139E;
	Tue, 25 Feb 2025 08:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740471495; cv=fail; b=ESmVvkehcz6kVhn5R3Rspf6O06Xph8IvSxpFkL0PpCVav1wSmN5dNp/CGNV8iYRH2ctYFli+n8oM6g/VZTpG5V+M4GGC2Sm/C0NW/+2nR+jCbWCPDRtN4ZzX5mssr3nUqEHwoHxIqnDOHyqQAt5znGVgqI7p0PfDmxPi6NWaL2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740471495; c=relaxed/simple;
	bh=kvrFOZZj4pNKFZaYyHZOgY45/hvSKqUoiqIK6LOdHFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=e71A0A08uzTAzjIw3KioPSvuLvHi9128k1mAz+B5woLvaTBOXyQyRf6RF0yCiVjDgqcA1KndQgutoR90BszE6uRjzSTia8rS/PXsYCt2mGhaQ+/3pFDN7jig7xioomkIOQN+cxCjteyBZAUL3kdBX6ejakKd3D0/NnMFcPclvrY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=wiFZl8xE; arc=fail smtp.client-ip=52.101.66.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wxVEq0SxORPdaKIIHvm4JGsGsXlXQEkHRhValt5h7acecuyxlVY+I+hwECxdt8VZonWTVEHGlSzdkZNFi36XiluTLX5SnOI/aJYEsBhHOkIzbZeix9Jfsm7s+IaVVX7PH+ojQ+dj9GxAqoAD1qfCDj1Km0eXnnzy/iZLNhz6JtRan03kZVW4jYokjMZsGOqQ1pOBT1aSF6cVqPaBjIheof8XKr7iRBsEyEWLVTGgiqeD/PviQMYeDDkggP6gvwKiGrKSTIxaKtMPrZmbUj+5P5scDCXYmY/fH/xNnvQJbAVtzXKrhu83aOS8ilGN9Y1GVlHEeWc1TtuzobAAGvYl5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=50O4UI3VYydFwSDrUR8rkObc+8B/yThHB7b6YzvYZv0=;
 b=CtlhhXEjFRZqtojXEepRonZJvmh1ttaKoFtNyNis+0xMDURqJ1CJPeU8RqR78/oLvZ9gxk8nqEuFlwAuRWdN4gk245FZkd6Cx5L5MtU85X9IMVJDR32kTzFWGmE8ei6psWHBO9RQdKoT63EkhoeOSNslRaUdl2BFp0/fL4k5Gt64d28by1Hr362GCy3zh1QmUoZx4AZrgMOEcmtJmigLASSL5ZKUc0N/ZMnsZN8L7+4O3lRsHV7Pg++Ez/VP1k9hTanglpZausH0g+Ax7aXq70pHJL47Zwgss/pwfETXiaZ/Z7nx9tHhyLcM7IdRRNnJf+npWQeXu17LTnzfbDDYIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=50O4UI3VYydFwSDrUR8rkObc+8B/yThHB7b6YzvYZv0=;
 b=wiFZl8xEUbbdS4I9puUex2dscpKIJhBHgD0/IwiIQDxLNgKEiIxPXAjRmuIWWBgnDStECriTZJoW3urULfzd8WCIj7HB8d8zJhBRLKGIlqXCQn6E2ZT4F3ViVQFsgf882z82c9lWJ/Gnq2rcJynW8xtbgkZjhMJhqzbrmpjhLZEuAO723hrWSX7uCxuLKo9MW/p0qTGVpsj4LkbTBHLEcPJ5W7aqYhBftDlPMHYF9RfvRiilLMefoYC77aXFuCgfUvb/nERrHfpspypUEHUUJ8ObHQPhs41smB/2C4OojjpPG40a/+GbtJoPqxHdyo9OEmbt6J19ZRilz8c4fYWn8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DUZPR04MB9945.eurprd04.prod.outlook.com (2603:10a6:10:4d8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Tue, 25 Feb
 2025 08:18:09 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.8466.013; Tue, 25 Feb 2025
 08:18:09 +0000
Date: Tue, 25 Feb 2025 17:25:23 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Cristian Marussi <cristian.marussi@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	linux-kernel@vger.kernel.org, arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	devicetree@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v2 3/7] firmware: arm_scmi: imx: Add i.MX95 LMM protocol
Message-ID: <20250225092523.GB25303@nxa18884-linux>
References: <20250212-imx-lmm-cpu-v2-0-3aee005968c1@nxp.com>
 <20250212-imx-lmm-cpu-v2-3-3aee005968c1@nxp.com>
 <Z7yWK3E5inW39jeJ@pluto>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7yWK3E5inW39jeJ@pluto>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2PR04CA0001.apcprd04.prod.outlook.com
 (2603:1096:4:197::12) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DUZPR04MB9945:EE_
X-MS-Office365-Filtering-Correlation-Id: 86123006-150e-45b5-2f93-08dd5574f023
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|52116014|366016|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?grw7vtQSXFE9Q0sHvuouty5UtLf0Ve1VRjQ/TGFY9MPDcY2smGT/6wBHe+wP?=
 =?us-ascii?Q?tlzMH5EQZbBnq3xOAoCClAnlVR4kyOS1rQ2+pep/jNWVULInHCgSrnAqOCNG?=
 =?us-ascii?Q?hDVj4zdX7ZQd0XQCVQZOFT7pEEzK+z9hM/KqhxoHSJjYG9hlVlPYizT07OWM?=
 =?us-ascii?Q?ZPsBHFEKbQ+UcixdctW4j5jvZCMp6FKa73PuBdyRq8kxQ4izgsrfgwnJ4R+p?=
 =?us-ascii?Q?o2K3wH+EIbwVW5fXbpd46jmpzUx8mNulHBk6vaqvRfJ1P2Ce1AAHgf4L0FK7?=
 =?us-ascii?Q?GXDan9gfKyitVQRC1gw6tGLue8gtMuYKjkUc0DLRFHEsD6eaMP3C/WHh99a+?=
 =?us-ascii?Q?t/uMZK7irOUhsGcHwbqsyeGvBCJg3c4xkd514iTVSCRwIgbVnKp3SuDolnd4?=
 =?us-ascii?Q?FTnnPIJPazxZgQwPY9NB5WpG3+AAuYQmXK4C/cyOAxGY/OxQW2QoKkWsHoFN?=
 =?us-ascii?Q?1D9awnwqvUqOxVh/H++kXwS9mX8YYck5nDYVfqgXgvZgChq0uJ2MdofCQ1OY?=
 =?us-ascii?Q?W+Hqa3L3R9sT6BkL0d8H/xS63fRQfuSyebBWHKI8adj0EYRNYpRn7GSzUSg+?=
 =?us-ascii?Q?7zeWatxsMyR4mBx3/yefnc4WQ3H3seqBAV0kKbAWegztrHb0eEpybDGwI6CP?=
 =?us-ascii?Q?xLQGlEOzIO09xCpUzSSfcq6EFC4TIPSAVNXhOfD3l2uSMA2zeCH0tTBFaQm8?=
 =?us-ascii?Q?CKiupMy5RfDbQi0htWfcaalAu+9V/02yb43xw2JkP+PrE1suZaZxmvkqFcAJ?=
 =?us-ascii?Q?hTbIkizNAYuvMC/WcZfkvGDRJFq0CPyaeiX5f1N6uZMfI+ze76C7Fh04RqZA?=
 =?us-ascii?Q?0yDSqP4PRSy8e2vZVLqRPRMRREIKusyHLFsqTYY8dIB6TmvaJMR+Mi9dfsvp?=
 =?us-ascii?Q?NZEMgWctgspKbBTOF+Asi0JdV/fqjg4dzzKOdvQitrZN2NXo/9ibHUsIBXI6?=
 =?us-ascii?Q?uzUROeNeNO03cvDGvVwYXviH8aL6rkR1C8wOtvm8Ahzbzvwb3Tw4HlbNyjmx?=
 =?us-ascii?Q?Yu8lxQD5DA1v47ZfTnopD0tuyFAULOrCnkKnvyjWgpHROrCwzNdIvqS0lwol?=
 =?us-ascii?Q?l2bs1dgwhZajd3mIXttAvXRNohp4niwrrs2/jpMB8j4MAYk/gNSFBzD6EHJq?=
 =?us-ascii?Q?WV8CH1Ks8dHPggGWN+7VwinxEn0Rc4hrEE8bAI+lKW2lh89AqcaVK7FCu4Ie?=
 =?us-ascii?Q?BPpS27R6xHSNN56/mPcrRTVXJ5orAu/rlj6KU/fWYpYZxAx5gAzvKoeuu5KL?=
 =?us-ascii?Q?+h793Q38P9XQeEjE9LC3mwecdqkzzLVUWYUP0gDxYE1MJk86t8Vx/UUWNFX4?=
 =?us-ascii?Q?85E8I84aiGAK8boreDcYF90mXv6TXtNwqLskM5yHMuF55OObEldWK36mtlCI?=
 =?us-ascii?Q?k3TOADq/e7qkmYVKzu26L33IeNqDUtQY9nU58/c8XFJ+Kji55lkEti5wK2d3?=
 =?us-ascii?Q?WloM5tEy2IAR6+mrMAoE1jy2UneIaAoR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(52116014)(366016)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ucaIg1G/voH2xaPdhnJphhyULcGFbrZ4v+Pmb4mRarhoEB5oqMdD9ZxyREKW?=
 =?us-ascii?Q?ZXA1JnLbh6W8QKD/VzukCpD5puW9V6gtbC4DOIrhOJsIolmWJDTfhyFgzHkP?=
 =?us-ascii?Q?FYJ5w1OnH9cDxLf8Ed9oDTOXVWFfVvPnDuGl3v8TIS57wuvd5SxgmIwyqdsW?=
 =?us-ascii?Q?495TDi1eB6Q16GeKhI1V/hSxS5o9vwnagVeRfCqU2Z1dqWCAuHPXOvehTCvA?=
 =?us-ascii?Q?ubzwRB513jfvqRVLaQxvsMd1xcps9t0BErp3pVGT8+QbOlBWTSRuetVw5Fwm?=
 =?us-ascii?Q?MlICSuD82e8iCitsKbixs8AyBUYV7gTnzgDvcZyDSTReBwOK2GfzCPdOha6Z?=
 =?us-ascii?Q?Bx65p2U7ssDLwaPJnXa1wIm+xY9qI0jrN+gfZc8cEZn9X5xDtIsB2Jx1ZU29?=
 =?us-ascii?Q?Z7U4BNT4S5IxGGIz/RNt2eMPxm4omKyUWhfRYvhZMG8KAiGjtfPdA3GoJllj?=
 =?us-ascii?Q?1YLEBpQ3WssUMdXSiroOEnf8pZ7P1qSHCvqiac1TLQWxDdYLpOWdW1oXN/va?=
 =?us-ascii?Q?gK+TYagroga9UZjnZY1Dl0JlGUyrgqCP6gFkk/7keXk2YYRuG7lZBxYtJSFd?=
 =?us-ascii?Q?Llo++Xwx8JFz6itSWKR3kx0ArALnG95RUV+Pp9Siy+nuIbOq9Lsdzor9Lv+U?=
 =?us-ascii?Q?zY5CqCgex8Rrbvew7nvszpgnxqeIyR82eT/AQW2feenHfP0os7WlbTvr5lTg?=
 =?us-ascii?Q?vqGU1PXJbkmlhxtbEtQNY8Qb7N8JMLPRqZEJ+wDLp7z2VoLzWH0ddXS6EUgY?=
 =?us-ascii?Q?QqmMMvnDJPufSl67KSgEYOmS7Imht7ESRRat51TZYu9ZrjLu/q5UNp2DarFR?=
 =?us-ascii?Q?Hv3ier4q+oUlXnh7MXoay5DPeFdTEBCTeQhrk9EkMj/q/OX+cfBH8o9qBzFp?=
 =?us-ascii?Q?EzFpv/X85DBfjgN+8rIf35ZEK96tMpDiBVuCTVx4w7UN5faaqIg3xoz5qSX3?=
 =?us-ascii?Q?bKVSTdjI2Yin7+Cn3300eCF4cv35Foa+BO3VeihyV1g9EoCsJ1PCBhOTHdVx?=
 =?us-ascii?Q?ghQYDROv0ju2J3spkeZTI2xz6hpPzoQvZSpOippiMBO7P0c3pzKnH2XQhd2S?=
 =?us-ascii?Q?2pKwefrDOZiXWX9JQWCstqOFeSohyDtn6IyQv2oCDLduX9EU5MDe0dC2+Fja?=
 =?us-ascii?Q?dea82Aj3LByn1fOiZ731gTuMDI60c4TSRq8gi3a6yRkJsLmPaSE5WNCI82e1?=
 =?us-ascii?Q?a3bEdM2awm8SH+oe2m70YsLbP+cW32l+5Z0icHG8EQaOeNziyFlRtjhBB6xE?=
 =?us-ascii?Q?0awxoPL9RaY7foEIALn45UjVAPyk+8TYmhOK4zhgocxBfzJEraDQFFbGbULI?=
 =?us-ascii?Q?oyyp8bNLDe6vYOA3LETYAoWrOYPAFFntd6TcN9jj+VJ1EGDrBxVcIItEm/Zm?=
 =?us-ascii?Q?W2fUCdv9PiioPNL7H/OzXonNEiZT+15O9lQUUkjp5ILpsTIgIr9XgmfheWvV?=
 =?us-ascii?Q?rjdg6cTrcnQITKJrGxrV+G3484OEOlLF5YyeqS5jNSeGDXW9MqW0SUnLU0QW?=
 =?us-ascii?Q?esqgHeCc0I5jyPZgL7kWtSD4dTtcvjm+wCSuiea+1GV3znpLFFkSFEBZlSEH?=
 =?us-ascii?Q?H69boI+IawWm0CcpCmczofYYszSD8OFoa4Vz2sbv?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86123006-150e-45b5-2f93-08dd5574f023
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 08:18:09.2682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2ls7cC376S98qUQ8C6OSRvK8ZlDuVBAfmngR5Qm8MLaLLPImCRON0UaayyI9OkLB5SLX8VMctQvEAHY835xV0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9945

On Mon, Feb 24, 2025 at 03:54:19PM +0000, Cristian Marussi wrote:
>On Wed, Feb 12, 2025 at 03:40:25PM +0800, Peng Fan (OSS) wrote:
>> From: Peng Fan <peng.fan@nxp.com>
>> 
>> Add Logical Machine Management(LMM) protocol which is intended for boot,
>> shutdown, and reset of other logical machines (LM). It is usually used to
>> allow one LM to manager another used as an offload or accelerator engine.
>> 
>
>Hi,
>
>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>> ---
>>  drivers/firmware/arm_scmi/vendors/imx/Kconfig      |  11 +
>>  drivers/firmware/arm_scmi/vendors/imx/Makefile     |   1 +
>>  drivers/firmware/arm_scmi/vendors/imx/imx-sm-lmm.c | 270 +++++++++++++++++++++
>>  include/linux/scmi_imx_protocol.h                  |  31 +++
>>  4 files changed, 313 insertions(+)
>> 
>> diff --git a/drivers/firmware/arm_scmi/vendors/imx/Kconfig b/drivers/firmware/arm_scmi/vendors/imx/Kconfig
>> index a01bf5e47301d2f93c9bfc7eebc77e083ea4ed75..1a936fc87d2350e2a21bccd45dfbeebfa3b90286 100644
>> --- a/drivers/firmware/arm_scmi/vendors/imx/Kconfig
>> +++ b/drivers/firmware/arm_scmi/vendors/imx/Kconfig
>> @@ -12,6 +12,17 @@ config IMX_SCMI_BBM_EXT
>>  	  To compile this driver as a module, choose M here: the
>>  	  module will be called imx-sm-bbm.
>>  
>> +config IMX_SCMI_LMM_EXT
>> +	tristate "i.MX SCMI LMM EXTENSION"
>> +	depends on ARM_SCMI_PROTOCOL || (COMPILE_TEST && OF)
>> +	default y if ARCH_MXC
>> +	help
>> +	  This enables i.MX System Logical Machine Protocol to
>> +	  manage Logical Machines boot, shutdown and etc.
>> +
>> +	  To compile this driver as a module, choose M here: the
>> +	  module will be called imx-sm-lmm.
>> +
>>  config IMX_SCMI_MISC_EXT
>>  	tristate "i.MX SCMI MISC EXTENSION"
>>  	depends on ARM_SCMI_PROTOCOL || (COMPILE_TEST && OF)
>> diff --git a/drivers/firmware/arm_scmi/vendors/imx/Makefile b/drivers/firmware/arm_scmi/vendors/imx/Makefile
>> index d3ee6d5449244a4f5cdf6abcf1845f312c512325..f39a99ccaf9af757475e8b112d224669444d7ddc 100644
>> --- a/drivers/firmware/arm_scmi/vendors/imx/Makefile
>> +++ b/drivers/firmware/arm_scmi/vendors/imx/Makefile
>> @@ -1,3 +1,4 @@
>>  # SPDX-License-Identifier: GPL-2.0-only
>>  obj-$(CONFIG_IMX_SCMI_BBM_EXT) += imx-sm-bbm.o
>> +obj-$(CONFIG_IMX_SCMI_LMM_EXT) += imx-sm-lmm.o
>>  obj-$(CONFIG_IMX_SCMI_MISC_EXT) += imx-sm-misc.o
>> diff --git a/drivers/firmware/arm_scmi/vendors/imx/imx-sm-lmm.c b/drivers/firmware/arm_scmi/vendors/imx/imx-sm-lmm.c
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..4b9211df2329623fae0400039db91cb2b98cded1
>> --- /dev/null
>> +++ b/drivers/firmware/arm_scmi/vendors/imx/imx-sm-lmm.c
>> @@ -0,0 +1,270 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * System control and Management Interface (SCMI) NXP LMM Protocol
>> + *
>> + * Copyright 2025 NXP
>> + */
>> +
>> +#include <linux/bits.h>
>> +#include <linux/io.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/scmi_protocol.h>
>> +#include <linux/scmi_imx_protocol.h>
>> +
>> +#include "../../protocols.h"
>> +#include "../../notify.h"
>> +
>> +#define SCMI_PROTOCOL_SUPPORTED_VERSION		0x10000
>> +
>> +enum scmi_imx_lmm_protocol_cmd {
>> +	SCMI_IMX_LMM_ATTRIBUTES	= 0x3,
>> +	SCMI_IMX_LMM_BOOT = 0x4,
>> +	SCMI_IMX_LMM_RESET = 0x5,
>> +	SCMI_IMX_LMM_SHUTDOWN = 0x6,
>> +	SCMI_IMX_LMM_WAKE = 0x7,
>> +	SCMI_IMX_LMM_SUSPEND = 0x8,
>> +	SCMI_IMX_LMM_NOTIFY = 0x9,
>> +	SCMI_IMX_LMM_RESET_REASON = 0xA,
>> +	SCMI_IMX_LMM_POWER_ON = 0xB,
>> +	SCMI_IMX_LMM_RESET_VECTOR_SET = 0xC,
>> +};
>> +
>> +struct scmi_imx_lmm_priv {
>> +	u32 nr_lmm;
>> +};
>> +
>> +#define	SCMI_IMX_LMM_PROTO_ATTR_NUM_LM(x)	(((x) & 0xFFU))
>> +struct scmi_msg_imx_lmm_protocol_attributes {
>> +	__le32 attributes;
>> +};
>> +
>> +struct scmi_msg_imx_lmm_attributes_out {
>> +	__le32 lmid;
>> +	__le32 attributes;
>> +	__le32 state;
>> +	__le32 errstatus;
>> +	u8 name[LMM_MAX_NAME];
>> +};
>> +
>> +struct scmi_imx_lmm_reset_vector_set_in {
>> +	__le32 lmid;
>> +	__le32 cpuid;
>> +#define SCMI_LMM_VEC_FLAGS_TABLE	BIT(0)
>> +	__le32 flags;
>> +	__le32 resetvectorlow;
>> +	__le32 resetvectorhigh;
>> +};
>> +
>> +struct scmi_imx_lmm_shutdown_in {
>> +	__le32 lmid;
>> +	__le32 flags;
>> +};
>> +
>> +static int scmi_imx_lmm_validate_lmid(const struct scmi_protocol_handle *ph, u32 lmid)
>> +{
>> +	struct scmi_imx_lmm_priv *priv = ph->get_priv(ph);
>> +
>> +	if (lmid >= priv->nr_lmm)
>> +		return -EINVAL;
>> +
>> +	return 0;
>> +}
>> +
>> +static int scmi_imx_lmm_attributes(const struct scmi_protocol_handle *ph,
>> +				   u32 lmid, struct scmi_imx_lmm_info *info)
>> +{
>> +	struct scmi_msg_imx_lmm_attributes_out *out;
>> +	struct scmi_xfer *t;
>> +	int ret;
>> +
>> +	ret = ph->xops->xfer_get_init(ph, SCMI_IMX_LMM_ATTRIBUTES, sizeof(u32), 0, &t);
>> +	if (ret)
>> +		return ret;
>> +
>> +	put_unaligned_le32(lmid, t->tx.buf);
>> +	ret = ph->xops->do_xfer(ph, t);
>> +	if (!ret) {
>> +		out = t->rx.buf;
>> +		info->lmid = le32_to_cpu(out->lmid);
>> +		info->state = le32_to_cpu(out->state);
>> +		info->errstatus = le32_to_cpu(out->errstatus);
>> +		strscpy(info->name, out->name);
>> +		dev_dbg(ph->dev, "i.MX LMM: Logical Machine(%d), name: %s\n",
>> +			info->lmid, out->name);
>> +	} else {
>> +		dev_err(ph->dev, "i.MX LMM: Failed to get info of Logical Machine(%u)\n", lmid);
>> +	}
>> +
>> +	ph->xops->xfer_put(ph, t);
>> +
>> +	return ret;
>> +}
>> +
>> +static int scmi_imx_lmm_boot(const struct scmi_protocol_handle *ph, u32 lmid)
>> +{
>> +	struct scmi_xfer *t;
...
>> +
>
>..this....
>
>> +static int scmi_imx_lmm_power_on(const struct scmi_protocol_handle *ph, u32 lmid)
>> +{
>> +
...
>> +	return ret;
>> +}
>
>...can be refatcored to use one common workhorse fcuntion sued by both
>ops...

ok. I will merge power on and boot into one function.

>
>> +
>> +static int scmi_imx_lmm_reset_vector_set(const struct scmi_protocol_handle *ph,
>> +					 u32 lmid, u32 cpuid, u32 flags, u64 vector)
>> +{
>> +	struct scmi_imx_lmm_reset_vector_set_in *in;
>> +	struct scmi_xfer *t;
>> +	int ret;
>> +
>> +	ret = ph->xops->xfer_get_init(ph, SCMI_IMX_LMM_RESET_VECTOR_SET, sizeof(*in),
>> +				      0, &t);
>> +	if (ret)
>> +		return ret;
>> +
>> +	in = t->tx.buf;
>> +	in->lmid = cpu_to_le32(lmid);
>> +	in->cpuid = cpu_to_le32(cpuid);
>> +	in->flags = cpu_to_le32(flags);
>
>...bitfields in a flag field must not be enianity converted...only
>eventually subfields representing numbers (liek you did above)...
>
>..I feel FIELD_PREP should be fine...or even BIT(0) really given what
>these flags represents...

I will mark flags as reserved as updated doc, because this flag is not
used as of now.

>
>...again check issues with smatch....

yes, I will try this.

>
>> +	in->resetvectorlow = cpu_to_le32(lower_32_bits(vector));
>> +	in->resetvectorhigh = cpu_to_le32(upper_32_bits(vector));
>> +	ret = ph->xops->do_xfer(ph, t);
>> +
>> +	ph->xops->xfer_put(ph, t);
>> +
>> +	return ret;
>> +}
>> +
>> +static int scmi_imx_lmm_shutdown(const struct scmi_protocol_handle *ph, u32 lmid,
>> +				 u32 flags)
>> +{
>> +	struct scmi_imx_lmm_shutdown_in *in;
>> +	struct scmi_xfer *t;
>> +	int ret;
>> +
>> +	ret = scmi_imx_lmm_validate_lmid(ph, lmid);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = ph->xops->xfer_get_init(ph, SCMI_IMX_LMM_SHUTDOWN, sizeof(*in),
>> +				      0, &t);
>> +	if (ret)
>> +		return ret;
>> +
>> +	in = t->tx.buf;
>> +	in->lmid = cpu_to_le32(lmid);
>> +	in->flags = cpu_to_le32(flags);
>
>Same here, smatch would complain if you remove straight away this
>cpu_to_le32(), BUT this is a bitfield and does NOT contain any
>longer-than-2 number value that needs to be endianess manipulated...you
>just have to be able to set the required BIT 0 and 1, whitouth pissing
>off smatch :P

Only BIT0 used as of now. I will update as you suggest.

>
>> +	ret = ph->xops->do_xfer(ph, t);
>> +
>> +	ph->xops->xfer_put(ph, t);
>> +
>> +	return ret;
>> +}
>> +
>> +static const struct scmi_imx_lmm_proto_ops scmi_imx_lmm_proto_ops = {
>> +	.lmm_boot = scmi_imx_lmm_boot,
>> +	.lmm_info = scmi_imx_lmm_attributes,
>> +	.lmm_power_on = scmi_imx_lmm_power_on,
>> +	.lmm_reset_vector_set = scmi_imx_lmm_reset_vector_set,
>> +	.lmm_shutdown = scmi_imx_lmm_shutdown,
>> +};
>> +
>> +static int scmi_imx_lmm_protocol_attributes_get(const struct scmi_protocol_handle *ph,
>> +						struct scmi_imx_lmm_priv *priv)
>> +{
>> +	struct scmi_msg_imx_lmm_protocol_attributes *attr;
>> +	struct scmi_xfer *t;
>> +	int ret;
>> +
>> +	ret = ph->xops->xfer_get_init(ph, PROTOCOL_ATTRIBUTES, 0,
>> +				      sizeof(*attr), &t);
>> +	if (ret)
>> +		return ret;
>> +
>> +	attr = t->rx.buf;
>> +
>> +	ret = ph->xops->do_xfer(ph, t);
>> +	if (!ret) {
>> +		priv->nr_lmm = SCMI_IMX_LMM_PROTO_ATTR_NUM_LM(le32_to_cpu(attr->attributes));
>
>This seems wrong to me...you have an 8bit field to extract from an
>attribute field...so I would at first cut the byte out and then convert
>to LE, NOT the other way around like you are doing
>(i.e.: le32_to_cpu((attr->attributes & 0xFF))).
>
>Even BETTER to use:
>
>	le32_get_bits((x), GENMASK(7, 0))
>
>...the thing is, being a single byte you really SHOULD NOT need to address
>any endianity concern (i.e. FIELD_GET(GENMASK(7, 0), (x))), BUT I fear that
>if you dont use some of the le32_ accessors smatch/sparse will complain since
>the message field is, correctly, declared as __le32.
>
>So le32_get_bits is the way to go (bit check with the static analyzer :P)

Yup, fix in next version.

>
>> +		dev_info(ph->dev, "i.MX LMM: %d Logical Machines\n",
>> +			 priv->nr_lmm);
>> +	}
>> +
...
>> +};
>> +module_scmi_protocol(scmi_imx_lmm);
>> +
>
>
>Should this also be added:
>
>MODULE_ALIAS("scmi-protocol-" __stringify(SCMI_PROTOCOL_IMX_LMM) "-" SCMI_IMX_VENDOR);
>
>...after this went in:

fix in next version.

>
>>  };
....
>> +
>> +#define	LMM_ID_DISCOVER	0xFFFFFFFFU
>
>What is this ? Documented anywhere ?

LMM_ATTRIBUTES if ID is 0xFFFFFFFF, it will return current lmid.
I will update in doc patch.

>

