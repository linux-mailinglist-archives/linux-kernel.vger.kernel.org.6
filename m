Return-Path: <linux-kernel+bounces-540910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45013A4B657
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 03:56:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CCCA3AF6DA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 02:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC531D63C0;
	Mon,  3 Mar 2025 02:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="H5ehIdIE"
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2085.outbound.protection.outlook.com [40.107.103.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8C51CAA7B;
	Mon,  3 Mar 2025 02:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740970503; cv=fail; b=Ssa8rKquhQ5moMcteO456mKsuCRHK7+lVjFB5x9QfPjX90skDLyTxX0Zl7gEVy1WCKzGpb8G99I9pZ1RWGfef0X3LPumxLySwZhSmFGTEvbGkuc5OEwbpsTGsRxQ5rMK6IdwenmClRaZdSEdTnMnoYbOj6LmscspD3VrRVsU5C0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740970503; c=relaxed/simple;
	bh=YcXopkX3qiVWy7f+v/U4+OqOkGzfItqtWid7XOc4JLo=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=NjEvQnFwhtry2X+WnU+DG4cjbxs6vg+Jt1mY0IuduVtZqiTHVE8mqiXgRL0l7lX876w26YvqWbmNJrF+qdYF+LZRxMNouG4Rx2YtuiKO/78qId/UFxsKAhSJCwx23JlEsfEmBQRj75mYUYO6uz1u7Wlz9QjEYwbz10M+IgUtqHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=H5ehIdIE; arc=fail smtp.client-ip=40.107.103.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jPBKWyIC/nIfG2+Wh2JiVhZD90U3tylT9/qR7ZF4//7LDB1+aK4efLHZZlbE9JzcQm9FW4IbARqT+fVqbFXLb5J2ZpYnpJl8SRZm5c+J8XBwRvfoZyCijLeFyw+UNZj8wIcJsxI1LaSjpLSh4e4fWrsYlwPX5isD9iV3wPxtD9bpVJC3V3FiFRzlUjqrK3jr/dGNKrTiEgyf3pv/drHob9TeMSjUS9ZigWzstep2X9QmqZNypUgh8825LX6bv5ec5NC2OA21EjDl2PvgxknV3A48zjDnd9+YXSZMDJfVqVgUYpN+dbf0iH2rQzav/TdyVzXjaocV5FkW/OG0uNMcXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jCbS96ZWJsjZvrjwTAM4otcx9/p+SEnFPLgLPLvS614=;
 b=P/CN7vDwI/p2qJBUNQwmCmA3cFYyUmL+4gHgKYaN51gJ2puomTQMmq9zxDyd39VqgGyJ2u0EI71QJc5MC0h/qMkiptD7vOoBWEBpL6ZvEKOkDgkDxYgq/y4mOSkx+ySEM+VhMNyn1aNWBUKSVypjD0k20bTgnqR9YnoEk+duyduB0qFB4stIlg+gEhQAcJX8uBDZu57hVUZ/txIUPUzzeb9auAo2In0yhF05++hsEyxqU7r0URF7P9uIh66T5GHYEc9BOLUnrtiWJN32OPqUcDlsg7JPk6SvQMAph3UtfFz26r6ROQ5J/2bWK8Ks3mojhfHOHQGCv7wUppp5N1Da2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jCbS96ZWJsjZvrjwTAM4otcx9/p+SEnFPLgLPLvS614=;
 b=H5ehIdIE2ygDZQkIkWYT2j5z2EXhoVhcykZy38SrMjxb9qVbh76i6SZEkUKJfCD89XZ/NnDx7jtU6R2T8cmlXQdKRMxSD8Zl96BQa5iIgOvAxhKX4ojdfPvBtC6VhjlBh6hoC+Ewg3ggBiOy4eI7rsexrfVLX9MFpCOA0C/jypFAGbDLyE68f8Hq26ieIrI56SL+NsVyzHiagIJNY2Hpq+lbadJlO/7phss5Znt1ZsW0h4XfWdKegZ9FwleALKO9s9FE6y4+zw9Ev1De0ZM9IZMz/nFVdHSPWTgszzSUGH68rtIj2B7cPKlyVh5xOZliW6BbcAxH8stDmAECScvPIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM9PR04MB8308.eurprd04.prod.outlook.com (2603:10a6:20b:3e3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.27; Mon, 3 Mar
 2025 02:54:48 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 02:54:47 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 03 Mar 2025 10:53:26 +0800
Subject: [PATCH v3 5/7] firmware: imx: Add i.MX95 SCMI LMM driver
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250303-imx-lmm-cpu-v3-5-7695f6f61cfc@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740970413; l=6279;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=rd3I+t2nFc7Iz0+EcatlHc+yizA13sGbbHgtoWjJqf4=;
 b=RBVEydphNnVStTr5GuJ2qU4xWWa8JsXWed/F/3nUzr0Z7mGzYw7OwCgv2UdYI0TAnpoIaqXD9
 Y/4A7sC6050APQDVvHX0oHHAZsSN+hDRBfjXPYblIzxw/WRwJZ7xbgE
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
X-MS-Office365-Filtering-Correlation-Id: 131ac754-4af4-4ade-cba7-08dd59fec27d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QUhBckhOLzBOdzR3NEhWZlNuZm1UVkZZWGV0Nkx5YWZDbHQySWdZd1ZoZUsz?=
 =?utf-8?B?NkRaR0xYZFh0dXNnbTNjSCs1eVJLWDFzb0ZVeTZwdHZMKy9sNFFoQmNEdFZG?=
 =?utf-8?B?TkZSVzNiRzR6bUxydUhrYVp1dUJHQ2RZUEZGaGxSbGpEOXhmR1k3MGFwSEE3?=
 =?utf-8?B?U0JjMnhXbVYrWWZKcityWm5zTzBKeURZYy9QOUJCclRPQ0VhUTlaSUlZZkR2?=
 =?utf-8?B?UGI2T3NnK3hKQmgzYk03bmdZeExLSFlKSXJzMy95U0JTM0h4R3B5ZjVsV0lV?=
 =?utf-8?B?a29UNE1rRm5KMmRiNXRUNUY4ODdqMjhIU0IwYmpGL3YxSG9uY0tTNzE5N3FR?=
 =?utf-8?B?clNBUkMyRy94dFh4Q1NPdWgxV0MxMXlEV3FHTGwyYWVjK1ZsN2UyRzM3amlJ?=
 =?utf-8?B?cW10VkVKQlBRVTgzZW80WTJLNzhGTGtVZU9melRKZzNxUVU0bCttSUlIQnMr?=
 =?utf-8?B?MVNQWHJTenZHZmdCOHZwMHRYallVYWRBWFhKSFVvQWFGM25CaUYwK0hJN2wr?=
 =?utf-8?B?U21JcUNOd0FQOWdWRFVtdjBMVEFqRm52eEFzSE9kU0g4WmdlMkJWbk0vV0Zk?=
 =?utf-8?B?c0F4dGFKcUlxV3RHVjhQRTZvMFpPZ1U5UytOclRYN3cvc2JSVjYzM2hUZEox?=
 =?utf-8?B?NXgzRG1rL21WbnFVYUN0SG1iNkJ5YjVHR2tvNkFRVU5SQXJWMXlKU2tXaXFC?=
 =?utf-8?B?YVR4N3h3VXZtZjFjYllacWRyb1FURXNyckZCTlVJOElUSVlzYmtiWk02NzA4?=
 =?utf-8?B?aU1xUUxMbEM0cXAwKzQ5aENoenpTbWZoMFJiem1xaUgrZkVUVHU1c2lHWjFL?=
 =?utf-8?B?Q3d3MDdPSWJTWXdMQTBLaDBMV3EzbEsrWVBtL3JNL2ZKZFo0RXRDcnh5WHV5?=
 =?utf-8?B?MGtkYkNmazBXalRQYlVkYU41UTZJTnNDMk0zYlIrRE00QWtkeVZJekY1SG5Y?=
 =?utf-8?B?WTNGTDFJM1NwYkRXZVRFV05VTXozcEZmWXlUU0ZWTktNMDNJaGp2L1l3dENF?=
 =?utf-8?B?dGx4MDNGdUM3eXhvNG5GZXZkMThQRkdYZ0orMHFHWjFpL0RJdmNHcFdVZ2tT?=
 =?utf-8?B?aythTTNKSUVrdk1KRDU5UCtkSmRwd3RxSkpiVWxCNWk3eW5kOXVqa3hBR1dG?=
 =?utf-8?B?d3VqR25EZ0s1OTg2MjJtaDNrK1FPdkw3N2diSnIrckVwR3FkcWFCbzAzU3o4?=
 =?utf-8?B?cjBtcUJKUExjdTFTUUZTMWtsTmFWZGVjdHF4RGN2enQxMGVYV0Y1NlZUa2Rj?=
 =?utf-8?B?MHlid3M0YnBRcFhBaHBIeGtVRDdYb08yYml4QTZOSjBUUU5ENFVybE94YVBI?=
 =?utf-8?B?SFJ6Y2k1SldjY3ZOQWw4NjhFQllHbVdGRTFMeDdGVFRRTUJ3T3pvMmp2RXZX?=
 =?utf-8?B?aTRrL0dkbDJKWnZJS3R1eTJjYit3NkwycVVNSExqTjZ5VWFISHRsTUNQUTc1?=
 =?utf-8?B?WkRyTTNha2ZLUG9qZ0xLZENuOENGWllydU1vaDVvVU00OEZmTyt2V3J4YTdz?=
 =?utf-8?B?S1VVNGxraWR3enFIYjRCQm9WSTlKM3BWL3ZWbWd1TlVhZkdQRVp4Rzl4aEZP?=
 =?utf-8?B?TithaU0xMFpzNkNPQXJXNnViUE1LOGpHanBkbFdvRm5QUzJQNXl0dHlGWHlp?=
 =?utf-8?B?aDFDT3ByVWN4R2xBVDRTYWtkTzYxa2dKNHRhT1hPdXA0K0c0VkRZaUJMYlVn?=
 =?utf-8?B?QVU2bnFrT3ZRaXJrSVFVU1VkaXVMU1h1bWFmek9Oa2tXbTcyYXg5UVRRZXJz?=
 =?utf-8?B?VmdmN1BrV2hOay9LMkRPNVBMWnpkeGJvdXVNUXJVcnhuQ0FoZVo3RXRnNWxZ?=
 =?utf-8?B?cHZ2ODZrTnVBZkFxQmhRbnMvZmVhOUpBT3phNWpCVUl5UHVTSFlkSVNVTXk2?=
 =?utf-8?B?TUUwaUpsYlAwRjdDcDkrRGJQZWRXZ1ZCNllKRi9oUkRON280aFh2Vi9iQlpD?=
 =?utf-8?Q?j8paJVXMIAgBsk0javP+qMszO3ZcdEfc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S3QyMFBsY0RIZ240RVEvNVJybWRNblVnbkk3Wmh4d0dUMUY0U09pUVB3d3Vk?=
 =?utf-8?B?UEJrUzFvL1I0WUVvbElpVGNYYk5wN2RoUlZNRjNaSUJPbVhpektLSWlSdFN3?=
 =?utf-8?B?dDFZdXNickhYQmRXYlVJWFcvVFQxQnpQdXg0cCtvMEEwRGlsZnJLY0luWjFn?=
 =?utf-8?B?WC9rNUJqK1RPL1NPSzZmYkNlUVMwSFY2SlBJZVUzV0JJZC9TRnU1YnRjTklr?=
 =?utf-8?B?Q2lHUFpnMnBuMk9wMHc1OGZ2TzNSUm9TT1VoU0FSRWYxL3VnVFo0VzRzTkd4?=
 =?utf-8?B?ZTlMMExNQlpxSmd5am13ZkpLVDNSS05hRXVDRHg1TTdRRlFKMFR1a0szUGcy?=
 =?utf-8?B?TXl3M0xOcUREY0ZBYm1tTWtKTG5ReW5NN05wZE9Yc2pPSjl2aFFKQk1rZlNE?=
 =?utf-8?B?UXJZSkZ6dDcwRWVBYkMwTmFIT1M5VEJnUy91NUpqSWFvYmZmQXl2QlNwZTM4?=
 =?utf-8?B?ZHNXbnlHQTBLaVFzNE5BNXE4WU55UVFBcGl4OSs2bnA0WW42SjJVSGVOZXdl?=
 =?utf-8?B?b2cyQi9xV1JFM01RZ1BTWlUyWlRza216OTN3a0Q0YVB2RjM3SnhVdXFHeGRK?=
 =?utf-8?B?UkpkVTV6TVIrUmhSTkRZVElmT00waDY3bzNkaW5CTENmSWhnWURrYXFJVXJT?=
 =?utf-8?B?R3NzVGYybVFlbmtqVjllTjB6Z1IrNnpKWndkVzFJTzUzN29DR0J4RWNDZGZH?=
 =?utf-8?B?WXhrSXlnTjlpbHFJd2NWbW5QQ1MwalhEaXk1NzVXNnNtSTB1NEVoZ2JMWEg0?=
 =?utf-8?B?MUdlODZLWndYeGRHdFZ3YktpeGFZdlgvbUs0TVBMWG1WOFp4R1hiMFh3SnVr?=
 =?utf-8?B?QnNaNmVES1hJTGQ5MldTY0RCMWEvd1kxV3lwRlRoTUdRSnUvM0dUK3F4Tkg5?=
 =?utf-8?B?TUNRbk43cU11dE9oNjQxMnlsdU9HWlMxczJHcWRvMlFwUTFKbDRqOTdQSHlx?=
 =?utf-8?B?NVpaUEwyYWRQQXl2RTVyUld2d3NSSkUzbmpBalEvR0FIZm96USsrdEpXY2xl?=
 =?utf-8?B?TndJa0V6RTlxejJwNytMS1lrTFRFV3d0MzdOa09WYjl1bm0zOHVLY1V4RGg1?=
 =?utf-8?B?VGFDWGxvcDNZdTl6ODREUFhSVWRPcDVwS014Y0V0azhUMkZISTRBYTd0UFlH?=
 =?utf-8?B?T2VrcFFNcUhyczE2cjZ3eWF0SDQzSEZMaW45VUtQcjBNbnJ6SCtyejdBeVdV?=
 =?utf-8?B?K2l5NCtnbHU3N0QzeVRNMHZIQ09uMTBwdUpHTy9MWFU2cW9YREcrVDNmanlj?=
 =?utf-8?B?dnhGQmJiWWp0cDlPYXRhaVhEbHJEZDd4MlVnUTZFYTZDOGZYRm1kcERibVZL?=
 =?utf-8?B?bEhmTHE0SXdzMEZJVWRnNUdzbnF1cFZKOHlyQzJVaGVrQjdkS3VGZkQzWUxa?=
 =?utf-8?B?MUorQ2k2YW41RE9QN25UME1NT0NYYlRMS1doRUpCSTl2ay81VEQ3QjZmOG43?=
 =?utf-8?B?MjJiMWN2SkdWbkpJRitXMG05R2ovbEZXYm9QY1FVUzl1bmMwWThLTC9KM0FS?=
 =?utf-8?B?VGpDcnBXMnZlYXJ2M0p2cWFEMkVJMGtLc2wvYjdFelREWHdYNjdVWGxYdXhL?=
 =?utf-8?B?dmh4MW13V3lLT25BbkZWYUV1V0N1Zk40NUdXVDY2SzVKc1g2NmVUbU1KZkdJ?=
 =?utf-8?B?UjdSN1Zyd1BnTm5iYTFpRUVKZWhYYkRhSUIyRmZqVmRPRVhOQnp4djNNSWZK?=
 =?utf-8?B?ck5VbFdpek03bXNJb0RQRXo3bUFucVhFY2lNVEcyM1cwVVhMT0UwenVqTzVV?=
 =?utf-8?B?cnp0MHRLVkdTODUzazR5UnhtMWg4SkxxM1lUaldqaUoxQ2dxY1YwVmNZc05j?=
 =?utf-8?B?cmJ1Wjc4UzZoaWxWUk1OWVN2U0Y4Umt1TmVCelIyRi9CR211anVSaHhPMlRv?=
 =?utf-8?B?ZndnK2lnbUhpdWVrclVOem5Fd2dWSHNVSEdnSzlNSGd2VmdJWlBkR0ttaXlP?=
 =?utf-8?B?bDBCeTZxcmphQjlUU1pTQlliSU9CNXNlcHJONGNkeWxid2laVGZGNlQ2UU11?=
 =?utf-8?B?aW15UnR4a1E4NGZrV0k1NHpnZFhCSDRkNkc4dnplMGlZbWJVY3NhRVZXVGxY?=
 =?utf-8?B?NlJZNDlkRFFDejg3NEpVV0t6bnhoSG5iU0hqL1lId0tpTUlCb3NmYkp5UWgr?=
 =?utf-8?Q?jTxt51tMGPAqTKYJsZPKtFyBm?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 131ac754-4af4-4ade-cba7-08dd59fec27d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 02:54:47.8791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ifn1GCu9nCLZ253UMhuhw+jbpobK/7u/ZKFT+OyfxR/PJAMTQUVykFqj7dYJop/+vLoAx7ITAyz4lTzNCrDR7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8308

From: Peng Fan <peng.fan@nxp.com>

The i.MX95 System manager exports SCMI LMM protocol for linux to manage
Logical Machines. The driver is to use the LMM Protocol interface to
boot, shutdown a LM.

Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/arm_scmi/vendors/imx/Kconfig |  3 +-
 drivers/firmware/imx/Kconfig                  | 11 ++++
 drivers/firmware/imx/Makefile                 |  1 +
 drivers/firmware/imx/sm-lmm.c                 | 91 +++++++++++++++++++++++++++
 include/linux/firmware/imx/sm.h               | 14 +++++
 5 files changed, 119 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scmi/vendors/imx/Kconfig b/drivers/firmware/arm_scmi/vendors/imx/Kconfig
index b5f13d0e40155e485f4d1696e9550645d888ef44..4c24e17425f830810f8ba376ece9db93c8cded6d 100644
--- a/drivers/firmware/arm_scmi/vendors/imx/Kconfig
+++ b/drivers/firmware/arm_scmi/vendors/imx/Kconfig
@@ -26,7 +26,8 @@ config IMX_SCMI_CPU_EXT
 config IMX_SCMI_LMM_EXT
 	tristate "i.MX SCMI LMM EXTENSION"
 	depends on ARM_SCMI_PROTOCOL || (COMPILE_TEST && OF)
-	default y if ARCH_MXC
+	depends on IMX_SCMI_LMM_DRV
+	default y if ARCH_MXC && ARM64
 	help
 	  This enables i.MX System Logical Machine Protocol to
 	  manage Logical Machines boot, shutdown and etc.
diff --git a/drivers/firmware/imx/Kconfig b/drivers/firmware/imx/Kconfig
index c964f4924359fcd375560ee8263021b0fe65db1b..70c092424328067ea6b946cee59f072661e27e47 100644
--- a/drivers/firmware/imx/Kconfig
+++ b/drivers/firmware/imx/Kconfig
@@ -23,6 +23,17 @@ config IMX_SCU
 	  This driver manages the IPC interface between host CPU and the
 	  SCU firmware running on M4.
 
+config IMX_SCMI_LMM_DRV
+	tristate "IMX SCMI LMM Protocol driver"
+	depends on ARCH_MXC && ARM64 || COMPILE_TEST
+	default y if ARCH_MXC && ARM64
+	help
+	  The System Controller Management Interface firmware (SCMI FW) is
+	  a low-level system function which runs on a dedicated Cortex-M
+	  core that could provide Logical Machine management features.
+
+	  This driver can also be built as a module.
+
 config IMX_SCMI_MISC_DRV
 	tristate "IMX SCMI MISC Protocol driver"
 	depends on ARCH_MXC || COMPILE_TEST
diff --git a/drivers/firmware/imx/Makefile b/drivers/firmware/imx/Makefile
index 8d046c341be878bb6dd1e6277992ff66ae90e292..7762855d2a771169d4f1867d27e0d51be7c9ad03 100644
--- a/drivers/firmware/imx/Makefile
+++ b/drivers/firmware/imx/Makefile
@@ -2,3 +2,4 @@
 obj-$(CONFIG_IMX_DSP)		+= imx-dsp.o
 obj-$(CONFIG_IMX_SCU)		+= imx-scu.o misc.o imx-scu-irq.o rm.o imx-scu-soc.o
 obj-${CONFIG_IMX_SCMI_MISC_DRV}	+= sm-misc.o
+obj-${CONFIG_IMX_SCMI_LMM_DRV}	+= sm-lmm.o
diff --git a/drivers/firmware/imx/sm-lmm.c b/drivers/firmware/imx/sm-lmm.c
new file mode 100644
index 0000000000000000000000000000000000000000..6807bf563c03d21a68022ecf3469c38bee4fc2f5
--- /dev/null
+++ b/drivers/firmware/imx/sm-lmm.c
@@ -0,0 +1,91 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2025 NXP
+ */
+
+#include <linux/firmware/imx/sm.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/scmi_protocol.h>
+#include <linux/scmi_imx_protocol.h>
+
+static const struct scmi_imx_lmm_proto_ops *imx_lmm_ops;
+static struct scmi_protocol_handle *ph;
+
+int scmi_imx_lmm_info(u32 lmid, struct scmi_imx_lmm_info *info)
+{
+	if (!ph)
+		return -EPROBE_DEFER;
+
+	if (!info)
+		return -EINVAL;
+
+	return imx_lmm_ops->lmm_info(ph, lmid, info);
+};
+EXPORT_SYMBOL(scmi_imx_lmm_info);
+
+int scmi_imx_lmm_reset_vector_set(u32 lmid, u32 cpuid, u32 flags, u64 vector)
+{
+	if (!ph)
+		return -EPROBE_DEFER;
+
+	return imx_lmm_ops->lmm_reset_vector_set(ph, lmid, cpuid, flags, vector);
+}
+EXPORT_SYMBOL(scmi_imx_lmm_reset_vector_set);
+
+int scmi_imx_lmm_operation(u32 lmid, enum scmi_imx_lmm_op op, u32 flags)
+{
+	if (!ph)
+		return -EPROBE_DEFER;
+
+	switch (op) {
+	case SCMI_IMX_LMM_BOOT:
+		return imx_lmm_ops->lmm_power_boot(ph, lmid, true);
+	case SCMI_IMX_LMM_POWER_ON:
+		return imx_lmm_ops->lmm_power_boot(ph, lmid, false);
+	case SCMI_IMX_LMM_SHUTDOWN:
+		return imx_lmm_ops->lmm_shutdown(ph, lmid, flags);
+	default:
+		break;
+	}
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL(scmi_imx_lmm_operation);
+
+static int scmi_imx_lmm_probe(struct scmi_device *sdev)
+{
+	const struct scmi_handle *handle = sdev->handle;
+
+	if (!handle)
+		return -ENODEV;
+
+	if (imx_lmm_ops) {
+		dev_err(&sdev->dev, "lmm already initialized\n");
+		return -EEXIST;
+	}
+
+	imx_lmm_ops = handle->devm_protocol_get(sdev, SCMI_PROTOCOL_IMX_LMM, &ph);
+	if (IS_ERR(imx_lmm_ops))
+		return PTR_ERR(imx_lmm_ops);
+
+	return 0;
+}
+
+static const struct scmi_device_id scmi_id_table[] = {
+	{ SCMI_PROTOCOL_IMX_LMM, "imx-lmm" },
+	{ },
+};
+MODULE_DEVICE_TABLE(scmi, scmi_id_table);
+
+static struct scmi_driver scmi_imx_lmm_driver = {
+	.name = "scmi-imx-lmm",
+	.probe = scmi_imx_lmm_probe,
+	.id_table = scmi_id_table,
+};
+module_scmi_driver(scmi_imx_lmm_driver);
+
+MODULE_AUTHOR("Peng Fan <peng.fan@nxp.com>");
+MODULE_DESCRIPTION("IMX SM LMM driver");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/firmware/imx/sm.h b/include/linux/firmware/imx/sm.h
index 9b85a3f028d1b0a5287b453eb3ad8412a363fe6c..bc27b04afb2f68b048955f51c07a106f4c7e5852 100644
--- a/include/linux/firmware/imx/sm.h
+++ b/include/linux/firmware/imx/sm.h
@@ -8,6 +8,7 @@
 
 #include <linux/bitfield.h>
 #include <linux/errno.h>
+#include <linux/scmi_imx_protocol.h>
 #include <linux/types.h>
 
 #define SCMI_IMX_CTRL_PDM_CLK_SEL	0	/* AON PDM clock sel */
@@ -20,4 +21,17 @@
 int scmi_imx_misc_ctrl_get(u32 id, u32 *num, u32 *val);
 int scmi_imx_misc_ctrl_set(u32 id, u32 val);
 
+enum scmi_imx_lmm_op {
+	SCMI_IMX_LMM_BOOT,
+	SCMI_IMX_LMM_POWER_ON,
+	SCMI_IMX_LMM_SHUTDOWN,
+};
+
+/* For shutdown pperation */
+#define SCMI_IMX_LMM_OP_FORCEFUL	0
+#define SCMI_IMX_LMM_OP_GRACEFUL	BIT(0)
+
+int scmi_imx_lmm_operation(u32 lmid, enum scmi_imx_lmm_op op, u32 flags);
+int scmi_imx_lmm_info(u32 lmid, struct scmi_imx_lmm_info *info);
+int scmi_imx_lmm_reset_vector_set(u32 lmid, u32 cpuid, u32 flags, u64 vector);
 #endif

-- 
2.37.1


