Return-Path: <linux-kernel+bounces-540905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4751A4B650
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 03:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A22F188E51D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 02:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F7A1AA786;
	Mon,  3 Mar 2025 02:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="kIpo/mqh"
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2048.outbound.protection.outlook.com [40.107.103.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA661BBBF7;
	Mon,  3 Mar 2025 02:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740970476; cv=fail; b=re1QYwmjW12crQlNPKB1mUmLq8FF+Q0mUVVLHic/+W8eou9IYjJuLc7L5gHdBdp0cK5RHC2Sp+cuQKj2qOxsMpxFOypD3vipNB7a90kSE0xP2UqQMITXVM2WH9A0RUJlQaFC3BpNPPn5tPt3DDUm8g+nmKdTTx1aidD0KWrDokQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740970476; c=relaxed/simple;
	bh=3fwoAkYxgGX0AUVArnSrBB7Qzie0Gb7ilLd8okexyRs=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=TlSsmzdp1Vofzg6/GhFM/E9m9DlzyR9Lrmnqu1jQoOerbI61EKoCUYAh/5wUTkWrCAlrvOjxM6Es3uAS/LcWCA5jH3gqJ67KcN14IbYUER5/8dX1vS9f2SwkVVFzEzDtZP1PPtZzbq/cjgxcUrwq3FSJdQhGBnB6Zj2HToLH96E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=kIpo/mqh; arc=fail smtp.client-ip=40.107.103.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KtALiVPgkjrxdJFBWaCRv4ZYzVHs8/jyNcVjQhWnYeEAQ7zFgypoGN/C04n0kVrM62a3mBV0AV90BjmHnt4I95gEl4gqAjiWOOIPkXvp5uvCa83ymGfAMDNcbhV5+bb4NBnA12V+vtkADhDBBXCZyn6KduOOCbkJ0vLc3hDZQW3q1K2KbyTPBopImn3GsyS3fhBFNLYhb42HSVtsDWMOaRgem2252N9OWS/o5zVrY6dH/sJ4cu1GmpcQfQ/XixZRv+1PYv5vu3Cy7DTRvots/8degrl2trytvvRI6o5oM8SV8OeRNkIDlbdoFtFRtRjZyC/E34h9qJQPxH4/4A7Mbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7gzJsKKd/gFb6Cl2H7/ZvIt3/fHfCRfViLqTMeYuSjY=;
 b=yILqyhSLa1oPFKo87PjzzyxikP/HGsZHK+hmgqDEI8kb28PB563nIjAZkcociwEejV4PO+EV5vfvAa5phHTzgH1rYigZYxaTJ1nyfCri1ehdUc/uymQCnEES4hubkfNZiau2Mq0rdeGyTRHGXlmUSDHY2QZiwlWlkxvCsTPM2cEPtHX1ojOBerBSDTjbOtjCwmtRvglzHmEFyjCDh+KD01tgjfhSjB4bxyPLkoFhhzJmjtUFkg+kdmByMiSEY2hC+daHqhkfi6WMS92KNd5vzPbnr/vgLaFzr3FjkCLW8kf+EsVLx3OhjRzItxE0Cb3xmsbUdcXZF+TB/Bb05rCpgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7gzJsKKd/gFb6Cl2H7/ZvIt3/fHfCRfViLqTMeYuSjY=;
 b=kIpo/mqhLjwewa++kW6khofKCLQKPazu8Hj8nhnahsJahPYbR08tv4JYkw+7xtpYApa0ThlN36BoTZkarb8uq+4rkYRVrMbjCikI+iSey+ikInZmB/NOBS/6Uxuq4jWIjKnKybnHdzTb04Wxfi8FxaiBlnE/46ycrT32KBA/GikkNwE894+XK1HYMFTFAR/XnBL4K9JDgigtU6yhZwvY9U+7XEbOFR4lV9MVWudY6aTfEh+lwRDYZZep5VUzhdOpV3LmsObEltn0sCsoVCJULDcL816lsJ677DYdWWO6J8BOcQpseJB6YjvD4uc/EDhAAFz2YhrDmUa6N7TcfpiubA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM9PR04MB8308.eurprd04.prod.outlook.com (2603:10a6:20b:3e3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.27; Mon, 3 Mar
 2025 02:54:29 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 02:54:28 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 03 Mar 2025 10:53:22 +0800
Subject: [PATCH v3 1/7] firmware: arm_scmi: imx: Add LMM and CPU
 documentation
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250303-imx-lmm-cpu-v3-1-7695f6f61cfc@nxp.com>
References: <20250303-imx-lmm-cpu-v3-0-7695f6f61cfc@nxp.com>
In-Reply-To: <20250303-imx-lmm-cpu-v3-0-7695f6f61cfc@nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, linux-kernel@vger.kernel.org, 
 arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, devicetree@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740970413; l=50950;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=IUWUj3IQfKQpTOOM6LFzTWSHHcTuR0Vqci8CxaXdL9s=;
 b=OzzaIZW6dVn/JYCLqUbSUS7LS7QiPiRQQC97Vw7+xtlLfM813v/Erb80388LZNgZ1MR50/TkN
 4IlbRIzaZsKBqAdoVEGOQnGsHZ3Z/cM/c6uNoHu8HMdhqRbVzfoezKd
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2P153CA0014.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::6)
 To PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM9PR04MB8308:EE_
X-MS-Office365-Filtering-Correlation-Id: 68a91b9e-03e1-45d7-00e7-08dd59feb6fe
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RHhrUHBQbXRrdkx0WTMxOEtQZ3pHaGlTY0ZmS1BIRCttOExFUGZURmNoV3R6?=
 =?utf-8?B?bHdyN013WFlDZXp4MktFQ2h4akRURjlkMUJ5Vy9KVndXb1lEM1kzbERSMzdu?=
 =?utf-8?B?OS9JWTBsa1cxVDFoSmU2UE1Ca1Y0WG9EWWJjUnV5RUpKb0RmL0hFNHpFWldV?=
 =?utf-8?B?OHVaRWtpYXJFYWxRYmlQV2dzYlFVM3I4Yk5UaXBVcTg4ZlVxa3FGRXh1NG9o?=
 =?utf-8?B?bXdXcm5Ham5Qc2IvL0JMZVdnMVZNNExVQUMxN2NTM09zUnp3c2ZRQ3BhUWI3?=
 =?utf-8?B?NFlBbmFYUGttSUJWNko0OFd0QlZLLzBqTUhKN2RNZ3U2N2xQNEptbTZNZ2Rj?=
 =?utf-8?B?VFpKNlhlV1BIZDRGT0NDZURJcC9ncjR1MHRFT3k0c0NkbXhDK3ZFSVc4eTRT?=
 =?utf-8?B?MjZaeVA0dnY3b09QWk9xem15cFp0TmF6REVNVCs1U3A2cWNQUVhRMjNlcVNp?=
 =?utf-8?B?RXJmbU5PZ1d0WlFsSjluQU5ERzY5eUtpNzEyS1diZ05MT3M0WUlLbzJKUFND?=
 =?utf-8?B?WXBabDJQZWN5WkRBZkZOMldSU3B6SGVPdWkvenZHOTZuZDBIbHVwN1I2RE9z?=
 =?utf-8?B?TmM0YzJhSkVhME1iSHNxZFJiUFJGZjN0VVM3REJPZDZxTHg1Ni9zb3AwaStj?=
 =?utf-8?B?aVczdlUxZnl3UjQzMzJsWTRPL1JyUjN5UUYwQ0h3clE3ZnRMUzJ3TDRRUEFV?=
 =?utf-8?B?dTFLbFhKY3JmVi9jWGlWVTVFeHRYaEtqYkkzWGZrd1B0YjZaUDRBZ1VjQ0pk?=
 =?utf-8?B?cXI5WVJjZThOZms3NFhBWkNsS3dxN3kxS2ZRa083MzFhaE1ZTmZZWE94cmdz?=
 =?utf-8?B?S0JDZFBLK2dMMTdIaFhaU0Z5N0RwUDFyUW5EMVVFYmZtRHRKT2dTN1lTMTdI?=
 =?utf-8?B?RnlmVEorYUQ0WmNGNkd4NWJTWjVsZ3FHRERpTDhXQW1PcTZaMFNvcUlVckgx?=
 =?utf-8?B?aEp1UFV5K3ZWSTJLLys1WTYxY2FSdzBqOWwzN0VRUnBmT1RVN1VvTkJSQmt2?=
 =?utf-8?B?MDlBVG5OTTYxc0JyaDJIZWdmaExTaG1LOU9GSWwxV2NnUWlIWlNtWkRMQlZo?=
 =?utf-8?B?dWY5UCswbzNNN0UwWHRBbG5kZEZKMi96YitiRUQ0MFlLSUN0NVY3TU9vWjA3?=
 =?utf-8?B?bTBBMVB4WVRIeTdFOVk2ZE9zSm1BcnpaaER3d0ovRklSaDhlczVrVnJFcDRY?=
 =?utf-8?B?ajRzQWVKMzVaVXI4ckNFbitqbzNoRmprdmczM0JDcUhyWFpRZTJGVU9rK0pv?=
 =?utf-8?B?V0NqVXlSYkZiZ0ZEa1NVUFlseGNEdGlOYjYzSjhoZEVRTTBERmw3VEpIRjNJ?=
 =?utf-8?B?UElsNWpwem0yRVBCeitlSFVGaXJYZVlvVC93YmlJNUtYTCtuYkpjaWxrZ3Q0?=
 =?utf-8?B?bWxyK2dEMjJjWTlvVS8vV0VoSEl5R1MxVXhzLzhTUEZKM0NSdE1LbHZlUmhM?=
 =?utf-8?B?MXoxTk5FVXp0U2loSWp0K0tMV3Uxb3dMNVF1MVZBc3hRQTF2VjFzMU9CQ3ZW?=
 =?utf-8?B?ZTROTlFyV2plY1cxNkh2cFFhMm5CL1BKYUZDWGFBWDV1WnVNNjNMRjBKNm5H?=
 =?utf-8?B?bTg5UXhxM01WU3lDc3VLNi9rNDd6SGNRcCtpdDJETllhWFE3RGM4Qzcvalc4?=
 =?utf-8?B?SVdXSWtFbXhvMTVKSnp3SFl3YU1JOXFlaEIrYkpuVW8wQU8wd1JtbEY0cGtR?=
 =?utf-8?B?RmxoTEkzeFhyL3Uxb1YzOGVJWVBvTkh5Q0U1aExtM1AyNzRqUkt3QVNwRHox?=
 =?utf-8?B?WEErS1JHSWIvM1BlSWY5OFVhMnZwK1JxZkhzU3VnUjkrbWFpdkxGUFBXTCtJ?=
 =?utf-8?B?R2FIbUFWbFg5V0ZybXdEWWIrbEZ4UjNiOTB1SGtuUUVjYXR2UGJxQmJRT1ZY?=
 =?utf-8?B?aFZNc3FkYm9XZVd3UUlCUW1FeFFwQXE2blhsbzdKcWxBZHNRMm1zM2NrNDdU?=
 =?utf-8?Q?WoWtJtl7CYIkcc89vrtgR3yelA5kgroM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WTNOaG5HRmthNU1oeEsrRmM5eHR1ZVNXRWdjNHZ1N3hDUWR3dGJ2Sy9lUWt3?=
 =?utf-8?B?U2FDeitmVDI5amJpSmxvbjQ4Q05rRTdDemt1Zm5FcGZWYzI1RCtuelNVWGtN?=
 =?utf-8?B?NDF4ZXUyOC90SHBpdTNLOWdEbjRYbGsvSFhRYWR1eEV4ZVZHOXRDMFNlcjdF?=
 =?utf-8?B?VkVuZHd0VDlMczR0blRWaVdCQ1pSc2Juclh1bFlsSy9MMy9lOHZhT29EWjRZ?=
 =?utf-8?B?a1NJUE91RkNXQXlza1pod2NHYmlhdkFhQlJ6ckVLbkYzaEp4S20zc2ZZaDh0?=
 =?utf-8?B?RzlQTVRXTWJtaEUwQWEyeG0zWThYOERQWHQwSXJzbCt1UDMyQU5OWDVNeDR4?=
 =?utf-8?B?ZitnWEhhZU5pTlZPM1dHMkpxdGVWZG5zYjFXUWVyZmxkSU9RRE80Q0QwdC90?=
 =?utf-8?B?LzB5NDFsR3drS2xoNS9wMjJCd1VEQ01MYWhYMEJhVERiYkVJc3F3TjVsbGZi?=
 =?utf-8?B?eFcwSDV2dmFiOWRJaTJIcGxvQkp1eDFnK0JnZzlNdFJkUVNPUUpsL0NERG9R?=
 =?utf-8?B?R0RFajgyb0tSaW1zTHZ2UG5jeGNpWWUxR0dkcWQ5VUg2dmNaOUtGUnNSdzZy?=
 =?utf-8?B?SGFybzVYWXJta3kwbXhDL3VrVDVHL2d4Q3N0MXFJbzY4OWR2dVJXdWhQN09y?=
 =?utf-8?B?TTRIK3RGSGllRlZrdkNnell6UThleUY0Zk1kZFN5M3VEVERNSEdURWJvUmtX?=
 =?utf-8?B?eTRsc3M3NXpsNndLMnl3cmhiVm5zeTRJLzhYdFh3cnlOQm1PRlZVMHlDVHd6?=
 =?utf-8?B?T0dhMWJGZ3RrSUJ5YWZaaXM3bWk0ZW1ESVZIUlM4ZGdtS1N2VHJSdUVuOCt5?=
 =?utf-8?B?VFN6cDFLM1ZSRFc4aXkzREc1NHN2N1Z4Um9nSTZuVnMzWFBUK01GWFhxR1g4?=
 =?utf-8?B?U2lLUklYbmYvdGduVzRwbVdIMjJRcTQ2cEk4SU0yRHZack45ZUF2RTYzOE9T?=
 =?utf-8?B?N1E1elBESHR4MVYwRUpNQUNuQ3BTWVNrQ0lDQllYVFRicUNFUUZtTlMwdWNv?=
 =?utf-8?B?eUNhTjRCWVd0VGlGbmxZWTNmNFpHZ3FQZUJsR3VLd2tXR25GclUrV3JnbUR6?=
 =?utf-8?B?N25sMnFrTjFuUFJLOWFFMXlaa0VNSXprRXQ4RUlwaDYwUkQxMGV5bEF3OWVK?=
 =?utf-8?B?akJyYXJPZEhhU0tXYlV6OXBJN2Z2aDdzbWlrQ29OVWxITDYwcXBHbWo3WW1D?=
 =?utf-8?B?dHgzYUFQTk5UaU9Cb0NuMTBCUGVYSVNrcnNSKysvMVViSVNSMWNWZForOFJG?=
 =?utf-8?B?MEw1WmdOLzJ4OCtiWmJHSkpoODJjcjdSYlpoWjNKM2Myc2tpcXllWGdrVmxN?=
 =?utf-8?B?TzZqUEQraEV0THZVU04yRkF3QXJFV1pYU05ZRjJGQ0hzVWdqNElWYkNnUkR6?=
 =?utf-8?B?dFVyOUUvcTExNXF3TDdUSUVOTXNJOG9Mc0lhL3EycWNFd05BU3JvYmZQSXI0?=
 =?utf-8?B?empmMnA4NWo2NUpjK3RoR0tNVkd1Vnp1RlhSYkpJOWU1MWlyOUZPUHhiRUhQ?=
 =?utf-8?B?bzZ5MFZFY2UrWC81SHNySTVNZmxwdDZkK3NZRWVEaTNIRC9TNnNRTitzMUEv?=
 =?utf-8?B?SHlMeE5DbHJnNlZnNWVUR25rQjR5aWVtN21TU28yWjJ2M2o0aVZtYjVpeXE5?=
 =?utf-8?B?RmJ2ODhqa2dkMldQSGxXbzlXR1FaMXFlUFA4QldZZ0hiaUlTUWdDOG5hV3Ji?=
 =?utf-8?B?a0pISzBIeXZJNkJiTHU0M01SbXA2dzVyWDNLRitnWnpER01SbzRZeXRRQU9i?=
 =?utf-8?B?elI2cEtET2lJaEZFNW1YcUQ2VWUzNVdwY09pZ2hiSDlrcFR2UVNBa2c4VzQx?=
 =?utf-8?B?OXdpUW9VUjM1aXNJVmZFRjFaTCt4VWVYMk8vaEdnb3N4ekxzY3JjalkwT1Q0?=
 =?utf-8?B?SzdqNWdlT2xoWjVBa1pVQVBITWtmVmZMWkJCbWF6eHpKVnZYSVFpQnBaSjFo?=
 =?utf-8?B?OFZKQ1VnQjA5Q1Z6aGpYNms4OGZ5QXFBd0tvUGp4OTFkNnF5MEtQNDBjbTBB?=
 =?utf-8?B?NFVKdTJJSmVGd3hTRGN0Z0dtVnRheDZpdnB4SUQ1ZkVVNjVDSSsrOFFVMlhE?=
 =?utf-8?B?ZVFmK2tkell6V21TR1FaYlEwWFNheG1tWWdUckNybDFmOVorc1J4YVFuUHRk?=
 =?utf-8?Q?xqcmgy2RMROF2lKXJ05dCwaSR?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68a91b9e-03e1-45d7-00e7-08dd59feb6fe
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 02:54:28.8590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S8FB5TVMEdjOa8z4NVi2YjPkXsAOcjJnuo9fOS8WlWx429zKeUFe9NaGqgo5VGRdHfYh6SdDPoE0qi0g3GVGow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8308

From: Peng Fan <peng.fan@nxp.com>

Add i.MX95 Logical Machine Management and CPU Protocol documentation.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/arm_scmi/vendors/imx/imx95.rst | 801 ++++++++++++++++++++++++
 1 file changed, 801 insertions(+)

diff --git a/drivers/firmware/arm_scmi/vendors/imx/imx95.rst b/drivers/firmware/arm_scmi/vendors/imx/imx95.rst
index b2dfd6c46ca2f5f12f0475c24cb54c060e9fa421..74326bf2ea8586282a735713e0ab7eb90ccce8ff 100644
--- a/drivers/firmware/arm_scmi/vendors/imx/imx95.rst
+++ b/drivers/firmware/arm_scmi/vendors/imx/imx95.rst
@@ -32,6 +32,501 @@ port, and deploy the SM on supported processors.
 The SM implements an interface compliant with the Arm SCMI Specification
 with additional vendor specific extensions.
 
+SCMI_LMM: System Control and Management Logical Machine Management Vendor Protocol
+==================================================================================
+
+This protocol is intended for boot, shutdown, and reset of other logical
+machines (LM). It is usually used to allow one LM(e.g. OSPM) to manage
+another LM which is usually an offload or accelerator engine.. Notifications
+from this protocol can also be used to manage a communication link to another
+LM. The LMM protocol provides functions to:
+
+- Describe the protocol version.
+- Discover implementation attributes.
+- Discover the LMs defined in the system.
+- Boot an LM.
+- Shutdown an LM (gracefully or forcibly).
+- Reset an LM (gracefully or forcibly).
+- Wake an LM from suspend.
+- Suspend an LM (gracefully).
+- Read boot/shutdown/reset information for an LM.
+- Get notifications when an LM boots or shuts down (e.g. LM[X] requested
+  notification of LM[Y] boots or shuts down, when LM[Y] boots or shuts down,
+  SCMI firmware will send notification to LM[X]).
+
+'Graceful' means asking LM itself to shutdown/reset/etc (e.g. sending
+notification to Linux, Then Linux reboots or powers down itself). It is async
+command that the SUCCESS of the command just means the command successfully
+return, not means reboot/reset successfully finished.
+'Forceful' means the SM will force shutdown/reset/etc the LM. It is sync
+command that the SUCCESS of the command means the LM has been successfully
+shutdown/reset/etc.
+If the commands not have Graceful/Forceful flag settings, such as WAKE, SUSEND,
+it is async command.
+
+Commands:
+_________
+
+PROTOCOL_VERSION
+~~~~~~~~~~~~~~~~
+
+message_id: 0x0
+protocol_id: 0x80
+This command is mandatory.
+
++---------------+--------------------------------------------------------------+
+|Return values                                                                 |
++---------------+--------------------------------------------------------------+
+|Name           |Description                                                   |
++---------------+--------------------------------------------------------------+
+|int32 status   | See ARM SCMI Specification for status code definitions.      |
++---------------+--------------------------------------------------------------+
+|uint32 version | For this revision of the specification, this value must be   |
+|               | 0x10000.                                                     |
++---------------+--------------------------------------------------------------+
+
+PROTOCOL_ATTRIBUTES
+~~~~~~~~~~~~~~~~~~~
+
+message_id: 0x1
+protocol_id: 0x80
+This command is mandatory.
+
++------------------+-----------------------------------------------------------+
+|Return values                                                                 |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|int32 status      | See ARM SCMI Specification for status code definitions.   |
++------------------+-----------------------------------------------------------+
+|uint32 attributes |Protocol attributes:                                       |
+|                  |Bits[31:8] Reserved, must be zero.                         |
+|                  |Bits[7:0] Number of Logical Machines                       |
++------------------+-----------------------------------------------------------+
+
+PROTOCOL_MESSAGE_ATTRIBUTES
+~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+message_id: 0x2
+protocol_id: 0x80
+This command is mandatory.
+
++------------------+-----------------------------------------------------------+
+|Return values                                                                 |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|int32 status      |SUCCESS: in case the message is implemented and available  |
+|                  |to use.                                                    |
+|                  |NOT_FOUND: if the message identified by message_id is      |
+|                  |invalid or not implemented                                 |
++------------------+-----------------------------------------------------------+
+|uint32 attributes |Flags that are associated with a specific function in the  |
+|                  |protocol. For all functions in this protocol, this         |
+|                  |parameter has a value of 0                                 |
++------------------+-----------------------------------------------------------+
+
+LMM_ATTRIBUTES
+~~~~~~~~~~~~~~
+
+message_id: 0x3
+protocol_id: 0x80
+This command is mandatory.
+
++------------------+-----------------------------------------------------------+
+|Parameters                                                                    |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|uint32 lmid       |ID of the Logical Machine                                  |
++------------------+-----------------------------------------------------------+
+|Return values                                                                 |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|int32 status      |SUCCESS: if valid attributes are returned.                 |
+|                  |NOT_FOUND: if lmId not points to a valid logical machine.  |
+|                  |DENIED: if the agent does not have permission to get info  |
+|                  |for the LM specified by lmid.                              |
++------------------+-----------------------------------------------------------+
+|uint32 lmid       |Identifier of the LM whose identification is requested.    |
+|                  |This field is: Populated with the lmId of the calling      |
+|                  |agent, when the lmId parameter passed via the function is  |
+|                  |0xFFFFFFFF. Identical to the lmId field passed via the     |
+|                  |calling parameters, in all other cases                     |
++------------------+-----------------------------------------------------------+
+|uint32 attributes | Bits[31:0] reserved. must be zero                         |
++------------------+-----------------------------------------------------------+
+|uint32 state      | Current state of the LM                                   |
++------------------+-----------------------------------------------------------+
+|uint32 errStatus  | Last error status recorded                                |
++------------------+-----------------------------------------------------------+
+|char name[16]     | A NULL terminated ASCII string with the LM name, of up    |
+|                  | to 16 bytes                                               |
++------------------+-----------------------------------------------------------+
+
+LMM_BOOT
+~~~~~~~~
+
+message_id: 0x4
+protocol_id: 0x80
+This command is mandatory.
+
++------------------+-----------------------------------------------------------+
+|Parameters                                                                    |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|uint32 lmid       |ID of the Logical Machine                                  |
++------------------+-----------------------------------------------------------+
+|Return values                                                                 |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|int32 status      |SUCCESS: if LM boots successfully started.                 |
+|                  |NOT_FOUND: if lmId not points to a valid logical machine.  |
+|                  |INVALID_PARAMETERS: if lmId is same as the caller.         |
+|                  |DENIED: if the agent does not have permission to manage the|
+|                  |the LM specified by lmid.                                  |
++------------------+-----------------------------------------------------------+
+
+LMM_RESET
+~~~~~~~~~
+
+message_id: 0x5
+protocol_id: 0x80
+This command is mandatory.
+
++------------------+-----------------------------------------------------------+
+|Parameters                                                                    |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|uint32 lmid       |ID of the Logical Machine                                  |
++------------------+-----------------------------------------------------------+
+|uint32 flags      |Reset flags:                                               |
+|                  |Bits[31:1] Reserved, must be zero.                         |
+|                  |Bit[0] Graceful request:                                   |
+|                  |Set to 1 if the request is a graceful request.             |
+|                  |Set to 0 if the request is a forceful request.             |
++------------------+-----------------------------------------------------------+
+|Return values                                                                 |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|int32 status      |SUCCESS: The LMM RESET command finished successfully in    |
+|                  |graceful reset or LM successfully resets in forceful reset.|
+|                  |NOT_FOUND: if lmId not points to a valid logical machine.  |
+|                  |INVALID_PARAMETERS: if lmId is same as the caller.         |
+|                  |DENIED: if the agent does not have permission to manage the|
+|                  |the LM specified by lmid.                                  |
++------------------+-----------------------------------------------------------+
+
+LMM_SHUTDOWN
+~~~~~~~~~~~~
+
+message_id: 0x6
+protocol_id: 0x80
+This command is mandatory.
+
++------------------+-----------------------------------------------------------+
+|Parameters                                                                    |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|uint32 lmid       |ID of the Logical Machine                                  |
++------------------+-----------------------------------------------------------+
+|uint32 flags      |Reset flags:                                               |
+|                  |Bits[31:1] Reserved, must be zero.                         |
+|                  |Bit[0] Graceful request:                                   |
+|                  |Set to 1 if the request is a graceful request.             |
+|                  |Set to 0 if the request is a forceful request.             |
++------------------+-----------------------------------------------------------+
+|Return values                                                                 |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|int32 status      |SUCCESS: The LMM shutdown command finished successfully in |
+|                  |graceful request or LM successfully shutdown in forceful   |
+|                  |request.                                                   |
+|                  |NOT_FOUND: if lmId not points to a valid logical machine.  |
+|                  |INVALID_PARAMETERS: if lmId is same as the caller.         |
+|                  |DENIED: if the agent does not have permission to manage the|
+|                  |the LM specified by lmid.                                  |
++------------------+-----------------------------------------------------------+
+
+LMM_WAKE
+~~~~~~~~
+
+message_id: 0x7
+protocol_id: 0x80
+This command is mandatory.
+
++------------------+-----------------------------------------------------------+
+|Parameters                                                                    |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|uint32 lmid       |ID of the Logical Machine                                  |
++------------------+-----------------------------------------------------------+
+|Return values                                                                 |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|int32 status      |SUCCESS: if LM wake command successfully returns.          |
+|                  |NOT_FOUND: if lmId not points to a valid logical machine.  |
+|                  |INVALID_PARAMETERS: if lmId is same as the caller.         |
+|                  |DENIED: if the agent does not have permission to manage the|
+|                  |the LM specified by lmid.                                  |
++------------------+-----------------------------------------------------------+
+
+LMM_SUSPEND
+~~~~~~~~~~~
+
+message_id: 0x8
+protocol_id: 0x80
+This command is mandatory.
+
++------------------+-----------------------------------------------------------+
+|Parameters                                                                    |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|uint32 lmid       |ID of the Logical Machine                                  |
++------------------+-----------------------------------------------------------+
+|Return values                                                                 |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|int32 status      |SUCCESS: if LM suspend command successfully returns.       |
+|                  |NOT_FOUND: if lmId not points to a valid logical machine.  |
+|                  |INVALID_PARAMETERS: if lmId is same as the caller.         |
+|                  |DENIED: if the agent does not have permission to manage the|
+|                  |the LM specified by lmid.                                  |
++------------------+-----------------------------------------------------------+
+
+LMM_NOTIFY
+~~~~~~~~~~
+
+message_id: 0x9
+protocol_id: 0x80
+This command is mandatory.
+
++------------------+-----------------------------------------------------------+
+|Parameters                                                                    |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|uint32 lmid       |ID of the Logical Machine                                  |
++------------------+-----------------------------------------------------------+
+|uint32 flags      |Notification flags:                                        |
+|                  |Bits[31:3] Reserved, must be zero.                         |
+|                  |Bit[3] Wake (resume) notification:                         |
+|                  |Set to 1 to send notification.                             |
+|                  |Set to 0 if no notification.                               |
+|                  |Bit[2] Suspend (sleep) notification:                       |
+|                  |Set to 1 to send notification.                             |
+|                  |Set to 0 if no notification.                               |
+|                  |Bit[1] Shutdown (off) notification:                        |
+|                  |Set to 1 to send notification.                             |
+|                  |Set to 0 if no notification.                               |
+|                  |Bit[0] Boot (on) notification:                             |
+|                  |Set to 1 to send notification.                             |
+|                  |Set to 0 if no notification                                |
++------------------+-----------------------------------------------------------+
+|Return values                                                                 |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|int32 status      |SUCCESS: if the notification state successfully updated.   |
+|                  |NOT_FOUND: if lmId not points to a valid logical machine.  |
+|                  |INVALID_PARAMETERS: if input attributes flag specifies     |
+|                  |unsupported or invalid configurations.                     |
+|                  |DENIED: if the agent does not have permission to request   |
+|                  |the notification.                                          |
++------------------+-----------------------------------------------------------+
+
+LMM_RESET_REASON
+~~~~~~~~~~~~~~~~
+
+message_id: 0xA
+protocol_id: 0x80
+This command is mandatory.
+
+This command is to return the reset reason that caused the last reset, such as
+POR, WDOG, JTAG and etc.
+
++---------------------+--------------------------------------------------------+
+|Parameters                                                                    |
++---------------------+--------------------------------------------------------+
+|Name                 |Description                                             |
++---------------------+--------------------------------------------------------+
+|uint32 lmid          |ID of the Logical Machine                               |
++---------------------+--------------------------------------------------------+
+|Return values                                                                 |
++---------------------+--------------------------------------------------------+
+|Name                 |Description                                             |
++---------------------+--------------------------------------------------------+
+|int32 status         |SUCCESS: if the reset reason of the LM successfully     |
+|                     |updated.                                                |
+|                     |NOT_FOUND: if lmId not points to a valid logical machine|
+|                     |DENIED: if the agent does not have permission to request|
+|                     |the reset reason.                                       |
++---------------------+--------------------------------------------------------+
+|uint32 bootflags     |Boot reason flags. This parameter has the format:       |
+|                     |Bits[31] Valid.                                         |
+|                     |Set to 1 if the entire reason is valid.                 |
+|                     |Set to 0 if the entire reason is not valid.             |
+|                     |Bits[30:29] Reserved, must be zero.                     |
+|                     |Bit[28] Valid origin:                                   |
+|                     |Set to 1 if the origin field is valid.                  |
+|                     |Set to 0 if the origin field is not valid.              |
+|                     |Bits[27:24] Origin.                                     |
+|                     |Logical Machine(LM) ID that causes the BOOT of this LM  |
+|                     |Bit[23] Valid err ID:                                   |
+|                     |Set to 1 if the error ID field is valid.                |
+|                     |Set to 0 if the error ID field is not valid.            |
+|                     |Bits[22:8] Error ID(Agent ID of the system).            |
+|                     |Bit[7:0] Reason(WDOG, POR, FCCU and etc)                |
++---------------------+--------------------------------------------------------+
+|uint32 shutdownflags |Shutdown reason flags. This parameter has the format:   |
+|                     |Bits[31] Valid.                                         |
+|                     |Set to 1 if the entire reason is valid.                 |
+|                     |Set to 0 if the entire reason is not valid.             |
+|                     |Bits[30:29] Number of valid extended info words.        |
+|                     |Bit[28] Valid origin:                                   |
+|                     |Set to 1 if the origin field is valid.                  |
+|                     |Set to 0 if the origin field is not valid.              |
+|                     |Bits[27:24] Origin.                                     |
+|                     |Logical Machine(LM) ID that causes the BOOT of this LM  |
+|                     |Bit[23] Valid err ID:                                   |
+|                     |Set to 1 if the error ID field is valid.                |
+|                     |Set to 0 if the error ID field is not valid.            |
+|                     |Bits[22:8] Error ID(Agent ID of the System).            |
+|                     |Bit[7:0] Reason                                         |
++---------------------+--------------------------------------------------------+
+|uint32 extinfo[3]    |Array of extended info words(e.g. fault pc)             |
++---------------------+--------------------------------------------------------+
+
+LMM_POWER_ON
+~~~~~~~~~~~~
+
+message_id: 0xB
+protocol_id: 0x80
+This command is mandatory.
+
++------------------+-----------------------------------------------------------+
+|Parameters                                                                    |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|uint32 lmid       |ID of the Logical Machine                                  |
++------------------+-----------------------------------------------------------+
+|Return values                                                                 |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|int32 status      |SUCCESS: if LM successfully powers on.                     |
+|                  |NOT_FOUND: if lmId not points to a valid logical machine.  |
+|                  |INVALID_PARAMETERS: if lmId is same as the caller.         |
+|                  |DENIED: if the agent does not have permission to manage the|
+|                  |the LM specified by lmid.                                  |
++------------------+-----------------------------------------------------------+
+
+LMM_RESET_VECTOR_SET
+~~~~~~~~~~~~~~~~~~~~
+
+message_id: 0xC
+protocol_id: 0x80
+This command is mandatory.
+
++-----------------------+------------------------------------------------------+
+|Parameters                                                                    |
++-----------------------+------------------------------------------------------+
+|Name                   |Description                                           |
++-----------------------+------------------------------------------------------+
+|uint32 lmid            |ID of the Logical Machine                             |
++-----------------------+------------------------------------------------------+
+|uint32 cpuid           |ID of the CPU inside the LM                           |
++-----------------------+------------------------------------------------------+
+|uint32 flags           |Reset vector flags                                    |
+|                       |Bits[31:0] Reserved, must be zero.                    |
++-----------------------+------------------------------------------------------+
+|uint32 resetVectorLow  |Lower vector                                          |
++-----------------------+------------------------------------------------------+
+|uint32 resetVectorHigh |Higher vector                                         |
++-----------------------+------------------------------------------------------+
+|Return values                                                                 |
++-----------------------+------------------------------------------------------+
+|Name                   |Description                                           |
++-----------------------+------------------------------------------------------+
+|int32 status           |SUCCESS: If reset vector is set successfully.         |
+|                       |NOT_FOUND: if lmId not points to a valid logical      |
+|                       |machine, or cpuId is not valid.                       |
+|                       |INVALID_PARAMETERS: if reset vector is invalid.       |
+|                       |DENIED: if the agent does not have permission to set  |
+|                       |the reset vector for the CPU in the LM.               |
++-----------------------+------------------------------------------------------+
+
+NEGOTIATE_PROTOCOL_VERSION
+~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+message_id: 0x10
+protocol_id: 0x80
+This command is mandatory.
+
++--------------------+---------------------------------------------------------+
+|Parameters                                                                    |
++--------------------+---------------------------------------------------------+
+|Name                |Description                                              |
++--------------------+---------------------------------------------------------+
+|uint32 version      |The negotiated protocol version the agent intends to use |
++--------------------+---------------------------------------------------------+
+|Return values                                                                 |
++--------------------+---------------------------------------------------------+
+|Name                |Description                                              |
++--------------------+---------------------------------------------------------+
+|int32 status        |SUCCESS: if the negotiated protocol version is supported |
+|                    |by the platform. All commands, responses, and            |
+|                    |notifications post successful return of this command must|
+|                    |comply with the negotiated version.                      |
+|                    |NOT_SUPPORTED: if the protocol version is not supported. |
++--------------------+---------------------------------------------------------+
+
+Notifications
+_____________
+
+LMM_EVENT
+~~~~~~~~~
+
+message_id: 0x0
+protocol_id: 0x80
+
++------------------+-----------------------------------------------------------+
+|Parameters                                                                    |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|uint32 lmid       |Identifier for the LM that caused the transition.          |
++------------------+-----------------------------------------------------------+
+|uint32 eventlm    |Identifier of the LM this event refers to.                 |
++------------------+-----------------------------------------------------------+
+|uint32 flags      |LM events:                                                 |
+|                  |Bits[31:3] Reserved, must be zero.                         |
+|                  |Bit[3] Wake (resume) event:                                |
+|                  |1 LM has awakened.                                         |
+|                  |0 not a wake event.                                        |
+|                  |Bit[2] Suspend (sleep) event:                              |
+|                  |1 LM has suspended.                                        |
+|                  |0 not a suspend event.                                     |
+|                  |Bit[1] Shutdown (off) event:                               |
+|                  |1 LM has shutdown.                                         |
+|                  |0 not a shutdown event.                                    |
+|                  |Bit[0] Boot (on) event:                                    |
+|                  |1 LM has booted.                                           |
+|                  |0 not a boot event.                                        |
++------------------+-----------------------------------------------------------+
+
 SCMI_BBM: System Control and Management BBM Vendor Protocol
 ==============================================================
 
@@ -436,6 +931,312 @@ protocol_id: 0x81
 |                  |0 no button change detected.                               |
 +------------------+-----------------------------------------------------------+
 
+SCMI_CPU: System Control and Management CPU Vendor Protocol
+==============================================================
+
+This protocol allows an agent to start or stop a CPU. It is used to manage
+auxiliary CPUs in an LM (e.g. additional cores in an AP cluster or
+Cortex-M cores).
+Note:
+ - For cores in AP cluster, PSCI should be used and ATF will use CPU
+   protocol to handle them. For cores in non-AP cluster, Operating System(e.g.
+   Linux OS) could use CPU protocols to control Cortex-M7 cores.
+ - CPU indicates the core and its auxiliary peripherals(e.g. TCM) inside
+   i.MX SoC
+
+The CPU protocol provides functions to:
+
+- Describe the protocol version.
+- Discover implementation attributes.
+- Discover the CPUs defined in the system.
+- Start a CPU.
+- Stop a CPU.
+- Set the boot and resume addresses for a CPU.
+- Set the sleep mode of a CPU.
+- Configure wake-up sources for a CPU.
+- Configure power domain reactions (LPM mode and retention mask) for a CPU.
+- The CPU IDs can be found in the CPU section of the SoC DEVICE: SM Device
+  Interface. They can also be found in the SoC RM. See the CPU Mode Control
+  (CMC) list in General Power Controller (GPC) section.
+
+CPU settings are not aggregated and setting their state is normally exclusive
+to one client.
+
+Commands:
+_________
+
+PROTOCOL_VERSION
+~~~~~~~~~~~~~~~~
+
+message_id: 0x0
+protocol_id: 0x82
+This command is mandatory.
+
++---------------+--------------------------------------------------------------+
+|Return values                                                                 |
++---------------+--------------------------------------------------------------+
+|Name           |Description                                                   |
++---------------+--------------------------------------------------------------+
+|int32 status   | See ARM SCMI Specification for status code definitions.      |
++---------------+--------------------------------------------------------------+
+|uint32 version | For this revision of the specification, this value must be   |
+|               | 0x10000.                                                     |
++---------------+--------------------------------------------------------------+
+
+PROTOCOL_ATTRIBUTES
+~~~~~~~~~~~~~~~~~~~
+
+message_id: 0x1
+protocol_id: 0x82
+This command is mandatory.
+
++---------------+--------------------------------------------------------------+
+|Return values                                                                 |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|int32 status      | See ARM SCMI Specification for status code definitions.   |
++------------------+-----------------------------------------------------------+
+|uint32 attributes |Protocol attributes:                                       |
+|                  |Bits[31:16] Reserved, must be zero.                        |
+|                  |Bits[15:0] Number of CPUs                                  |
++------------------+-----------------------------------------------------------+
+
+PROTOCOL_MESSAGE_ATTRIBUTES
+~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+message_id: 0x2
+protocol_id: 0x82
+This command is mandatory.
+
++---------------+--------------------------------------------------------------+
+|Return values                                                                 |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|int32 status      |SUCCESS: in case the message is implemented and available  |
+|                  |to use.                                                    |
+|                  |NOT_FOUND: if the message identified by message_id is      |
+|                  |invalid or not implemented                                 |
++------------------+-----------------------------------------------------------+
+|uint32 attributes |Flags that are associated with a specific function in the  |
+|                  |protocol. For all functions in this protocol, this         |
+|                  |parameter has a value of 0                                 |
++------------------+-----------------------------------------------------------+
+
+CPU_ATTRIBUTES
+~~~~~~~~~~~~~~
+
+message_id: 0x4
+protocol_id: 0x82
+This command is mandatory.
+
++------------------+-----------------------------------------------------------+
+|Parameters                                                                    |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|uint32 cpuid      |Identifier for the CPU                                     |
++------------------+-----------------------------------------------------------+
+|Return values                                                                 |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|int32 status      |SUCCESS: if valid attributes are returned successfully.    |
+|                  |NOT_FOUND: if the cpuid is not valid.                      |
++------------------+-----------------------------------------------------------+
+|uint32 attributes |Bits[31:0] Reserved, must be zero                          |
++------------------+-----------------------------------------------------------+
+|char name[16]     |NULL terminated ASCII string with CPU name up to 16 bytes  |
++------------------+-----------------------------------------------------------+
+
+CPU_START
+~~~~~~~~~
+
+message_id: 0x4
+protocol_id: 0x82
+This command is mandatory.
+
++------------------+-----------------------------------------------------------+
+|Parameters                                                                    |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|uint32 cpuid      |Identifier for the CPU                                     |
++------------------+-----------------------------------------------------------+
+|Return values                                                                 |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|int32 status      |SUCCESS: if the cpu is started successfully.               |
+|                  |NOT_FOUND: if cpuid is not valid.                          |
+|                  |DENIED: the calling agent is not allowed to start this CPU.|
++------------------+-----------------------------------------------------------+
+
+CPU_STOP
+~~~~~~~~
+
+message_id: 0x5
+protocol_id: 0x82
+This command is mandatory.
+
++------------------+-----------------------------------------------------------+
+|Parameters                                                                    |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|uint32 cpuid      |Identifier for the CPU                                     |
++------------------+-----------------------------------------------------------+
+|Return values                                                                 |
++------------------+-----------------------------------------------------------+
+|Name              |Description                                                |
++------------------+-----------------------------------------------------------+
+|int32 status      |SUCCESS: if the cpu is started successfully.               |
+|                  |NOT_FOUND: if cpuid is not valid.                          |
+|                  |DENIED: the calling agent is not allowed to stop this CPU. |
++------------------+-----------------------------------------------------------+
+
+CPU_RESET_VECTOR_SET
+~~~~~~~~~~~~~~~~~~~~
+
+message_id: 0x6
+protocol_id: 0x82
+This command is mandatory.
+
++----------------------+-------------------------------------------------------+
+|Parameters                                                                    |
++----------------------+-------------------------------------------------------+
+|Name                  |Description                                            |
++----------------------+-------------------------------------------------------+
+|uint32 cpuid          |Identifier for the CPU                                 |
++----------------------+-------------------------------------------------------+
+|uint32 flags          |Reset vector flags:                                    |
+|                      |Bit[31] Resume flag.                                   |
+|                      |Set to 1 to update the reset vector used on resume.    |
+|                      |Bit[30] Boot flag.                                     |
+|                      |Set to 1 to update the reset vector used for boot.     |
+|                      |Bits[29:1] Reserved, must be zero.                     |
+|                      |Bit[0] Table flag.                                     |
+|                      |Set to 1 if vector is the vector table base address.   |
++----------------------+-------------------------------------------------------+
+|uint32 resetVectorLow |Lower vector:                                          |
+|                      |If bit[0] of flags is 0, the lower 32 bits of the      |
+|                      |physical address where the CPU should execute from on  |
+|                      |reset. If bit[0] of flags is 1, the lower 32 bits of   |
+|                      |the vector table base address                          |
++----------------------+-------------------------------------------------------+
+|uint32 resetVectorhigh|Upper vector:                                          |
+|                      |If bit[0] of flags is 0, the upper 32 bits of the      |
+|                      |physical address where the CPU should execute from on  |
+|                      |reset. If bit[0] of flags is 1, the upper 32 bits of   |
+|                      |the vector table base address                          |
++----------------------+-------------------------------------------------------+
+|Return values                                                                 |
++----------------------+-------------------------------------------------------+
+|Name                  |Description                                            |
++----------------------+-------------------------------------------------------+
+|int32 status          |SUCCESS: if the CPU reset vector is set successfully.  |
+|                      |NOT_FOUND: if cpuId does not point to a valid CPU.     |
+|                      |INVALID_PARAMETERS: the requested vector type is not   |
+|                      |supported by this CPU.                                 |
+|                      |DENIED: the calling agent is not allowed to set the    |
+|                      |reset vector of this CPU                               |
++----------------------+-------------------------------------------------------+
+
+CPU_SLEEP_MODE_SET
+~~~~~~~~~~~~~~~~~~
+
+message_id: 0x7
+protocol_id: 0x82
+This command is mandatory.
+
++----------------------+-------------------------------------------------------+
+|Parameters                                                                    |
++----------------------+-------------------------------------------------------+
+|Name                  |Description                                            |
++----------------------+-------------------------------------------------------+
+|uint32 cpuid          |Identifier for the CPU                                 |
++----------------------+-------------------------------------------------------+
+|uint32 flags          |Sleep mode flags:                                      |
+|                      |Bits[31:1] Reserved, must be zero.                     |
+|                      |Bit[0] IRQ mux:                                        |
+|                      |If set to 1 the wakeup mux source is the GIC, else if 0|
+|                      |then the GPC                                           |
++----------------------+-------------------------------------------------------+
+|uint32 sleepmode      |target sleep mode. When CPU runs into WFI, the GPC mode|
+|                      |will be triggered to be in below modes:                |
+|                      |RUN(0), WAIT(1), STOP(2), SUSPEND(3)                   |
++----------------------+-------------------------------------------------------+
+|Return values                                                                 |
++----------------------+-------------------------------------------------------+
+|Name                  |Description                                            |
++----------------------+-------------------------------------------------------+
+|int32 status          |SUCCESS: if the CPU sleep mode is set successfully.    |
+|                      |NOT_FOUND: if cpuId does not point to a valid CPU.     |
+|                      |INVALID_PARAMETERS: the sleepmode or flags is invalid. |
+|                      |DENIED: the calling agent is not allowed to configure  |
+|                      |the CPU                                                |
++----------------------+-------------------------------------------------------+
+
+CPU_INFO_GET
+~~~~~~~~~~~~
+
+message_id: 0xC
+protocol_id: 0x82
+This command is mandatory.
+
++----------------------+-------------------------------------------------------+
+|Parameters                                                                    |
++----------------------+-------------------------------------------------------+
+|Name                  |Description                                            |
++----------------------+-------------------------------------------------------+
+|uint32 cpuid          |Identifier for the CPU                                 |
++----------------------+-------------------------------------------------------+
+|Return values                                                                 |
++----------------------+-------------------------------------------------------+
+|Name                  |Description                                            |
++----------------------+-------------------------------------------------------+
+|int32 status          |SUCCESS: if valid attributes are returned successfully.|
+|                      |NOT_FOUND: if the cpuid is not valid.                  |
++----------------------+-------------------------------------------------------+
+|uint32 runmode        |Run mode for the CPU                                   |
+|                      |RUN(0):cpu started                                     |
+|                      |HOLD(1):cpu powered up and reset asserted              |
+|                      |STOP(2):cpu reseted and hold cpu                       |
+|                      |SUSPEND(3):in cpuidle state                            |
++----------------------+-------------------------------------------------------+
+|uint32 sleepmode      |Sleep mode for the CPU, see CPU_SLEEP_MODE_SET         |
++----------------------+-------------------------------------------------------+
+|uint32 resetvectorlow |Reset vector low 32 bits for the CPU                   |
++----------------------+-------------------------------------------------------+
+|uint32 resetvecothigh |Reset vector high 32 bits for the CPU                  |
++----------------------+-------------------------------------------------------+
+
+NEGOTIATE_PROTOCOL_VERSION
+~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+message_id: 0x10
+protocol_id: 0x82
+This command is mandatory.
+
++--------------------+---------------------------------------------------------+
+|Parameters                                                                    |
++--------------------+---------------------------------------------------------+
+|Name                |Description                                              |
++--------------------+---------------------------------------------------------+
+|uint32 version      |The negotiated protocol version the agent intends to use |
++--------------------+---------------------------------------------------------+
+|Return values                                                                 |
++--------------------+---------------------------------------------------------+
+|Name                |Description                                              |
++--------------------+---------------------------------------------------------+
+|int32 status        |SUCCESS: if the negotiated protocol version is supported |
+|                    |by the platform. All commands, responses, and            |
+|                    |notifications post successful return of this command must|
+|                    |comply with the negotiated version.                      |
+|                    |NOT_SUPPORTED: if the protocol version is not supported. |
++--------------------+---------------------------------------------------------+
+
 SCMI_MISC: System Control and Management MISC Vendor Protocol
 ================================================================
 

-- 
2.37.1


