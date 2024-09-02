Return-Path: <linux-kernel+bounces-311038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89FEA968435
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 12:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19F661F21588
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1B613CFAD;
	Mon,  2 Sep 2024 10:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Cj4W5hmr"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011071.outbound.protection.outlook.com [52.101.65.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A7C13D8A4;
	Mon,  2 Sep 2024 10:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725271848; cv=fail; b=qARzwL4KdDozLY1YaQlNj3q/WAv+ibd6MQAvtbR7xyvxF8BTMgRPVip5mhD36a5SJAGi1pvhgdFDMHKZhYpoNvUaknIwT7lgcIlNPpt8lLGdOT40SbBjDmle9dNNviSyH2m4cMeYk/c8KMc8bDcUSTDwczybTSHTHDd8Z6wGzxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725271848; c=relaxed/simple;
	bh=+lVIv8BXgiXbFq9omoa1N048WJeZkhJu5pNu5ItbpJQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=CoRu912okN/MIFzatu8SvqEOa9hJ88jMKT5mROsj7W5PfJKLnBS9VmBV0o+exI+DcXQfuoo/W8I00mqlAl+ONRcCTW9hG0LyiulBUhy4QfkTA3cy34xDFtg39gmyu0yzqWinoVpiMDu/atMxQXD5LjGHoCVW+IgiCYuYulXP9/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Cj4W5hmr; arc=fail smtp.client-ip=52.101.65.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NFJo1+caUNVr+A6fhCcUIFOoCRPixopNXNnSCfo3GqFF6bT9c0tsJ9HHGpzJdsarPlWWuRdktlzKtEmYrKLFC13SppgJt7xTPIPC5tHsMhMz1YIT6IE+XH8ps9kqByHTOuOWp7yQ17fID7edJlPj8wA+AhJHg/r900od9f37Ted5vYYIuxl52hy/3Jm1AXFIWJq/1NvSw/RS8k2Z84fMuCEFf3Bi1Od4CEZwewUZc1fOPCInu7WqmfLl06m9785O37kGIo+XeVJF6T71Z7GG6nTpkXKF0bLtkBETemSxm/n1IKeLBQJozkliFeexPBzItNQwG7gIhmmlkjX4TPUwiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z7dZsVBV0sNZ7SH7sU6wrlcfKVgC6d+/3wl9oTECxhc=;
 b=eNE0Wm+f6OxMN+BDfcGyjTNGw461d1V8GVpsrg9TWELdh0BUCsvl8DawkmwCcPCM6VOjV2wQXdezlDOy0lxF1kQoK5nXArI2TI+BQVzET3mEbtG9kV5/s808itALt6ctt1DPfYbcVMpBn02Kvmatf5qvQhmM8U9OhqOV8XN8TeJfYb4j5n3bjGzyjGD9s66oc7+wcHIfWbKLi5UPs0c7XWLUUGtZLyQ8wHOxLLjKktPmhqjM6Wc8MRxAs6kerNY78gyB1BdgtMQd87TLHunMyyLLvxcXraNCVDKa8loiLum1pLaXpmJGPQNiq5SnNkuQ714U36SxL4H+rv18jp9RdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z7dZsVBV0sNZ7SH7sU6wrlcfKVgC6d+/3wl9oTECxhc=;
 b=Cj4W5hmrMT/7pZG1nhfFvPXI3trcCmSwrH4QQAjB6+wJU+yXWIEAhD/ixOy8pZJGKclqRzsz4c5qosrK88AJ3ZOUbeta4f8PLq3sZjCnYVraPzcP19Ris5/WxMblLL6Dy4u95266oLMnQE5Ft0B485h/+myryQZJQImjLzqG/i2M4QfmJXTyXGpxjUObJQpLyDKACr+GsUdKBtHe/snOX44GmxaK3HuyVJiH5mSCvyY0DpPYRgLJBM33QOBtPBaPaEnDS0olXKbPm5XaOZTZW2q1ucEOgDZOw1bPjQh+Czt/KbP9x5jiGFwac1mPluhIJztGqNxsnHoaLmBp5ZGupA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA1PR04MB10099.eurprd04.prod.outlook.com (2603:10a6:102:45d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Mon, 2 Sep
 2024 10:10:43 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7918.020; Mon, 2 Sep 2024
 10:10:43 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 02 Sep 2024 18:19:24 +0800
Subject: [PATCH 2/7] arm64: dts: freescale: imx95: add bbm/misc/syspower
 scmi nodes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240902-imx95-dts-new-v1-2-a1f798f4f746@nxp.com>
References: <20240902-imx95-dts-new-v1-0-a1f798f4f746@nxp.com>
In-Reply-To: <20240902-imx95-dts-new-v1-0-a1f798f4f746@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725272373; l=914;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=jKMLZnwqOMB8RBv1H3mut/xvZe058iNtUdblLGQkkJI=;
 b=oLJEvHxS2iaOh3e3svohrYAbAwbHQqStFGVn0CEi3qHvnmTarefRO7+kVLqQc6K1qjohF471Q
 hfiQf27fPs0D/75CN5smz7XBP8Y9GEc4KdEFzg0xnrZDEhd2+Hif/aW
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SGXP274CA0021.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::33)
 To PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA1PR04MB10099:EE_
X-MS-Office365-Filtering-Correlation-Id: b34a34f6-0f30-45ad-0d30-08dccb378120
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SjRuT2xhSzlVdWN1LzhFcFMxeEdFRGFSemtMZWxINlpmeDZGd1NZWnNUWEJq?=
 =?utf-8?B?NFZTbVZjVFJzOE1Sb2VMVHJmdHh0REEvZ2hwaEpodngxZGkxTythNGo2Mmh0?=
 =?utf-8?B?THRDSkswaXU5Y0xSaElZN1ZhdWN2WUJZcnUrSEhQM3QrbnVwMWNBTlNQay9s?=
 =?utf-8?B?OWNXSFpMNDhVUUhKQ2NxNmY1NENsemNEQ2I3SUlSQUtxL3dVTGI2ZUxIS0ZO?=
 =?utf-8?B?cTFXb21EUFN0czZROVVqd0ZzSVBhZGJ0Z21qd0xDenRvR21rOS9FU0NSNnI2?=
 =?utf-8?B?QmlVL2VuZ2RGMnUyblhqUXJrQkxVTWQrVGorN1VWQldtUGVXQjd0VFJ6R25i?=
 =?utf-8?B?SVIxbU81bTB4TWxGcGhDUTJ0Y3hNTk0vemtja1BXdFZrUmRsRXZHbnl2aThE?=
 =?utf-8?B?UDRLaWl5QTJwSllDYXZoRkJsMGVldmIxQ1JBUkFGeWtNdFVmaGtTbGY2V1Aw?=
 =?utf-8?B?dGxFMUM2QUJrOGVBbytBczlZV205TGdRUVB3UXgrOWxPc0prV0pCc3FLaHY3?=
 =?utf-8?B?RlkzMWQrc1FEZlFpU0VzbFh1RzJNWEVZSG5qUE5HdzN6QWRyQzdERFh4TDBO?=
 =?utf-8?B?Zi9JVDFsa09ybnZKOWtJN2piWmxaQnhZNkJySUhoY0UzYTlBN3hWUys4aWlv?=
 =?utf-8?B?R3ZzWkdyMk5mOTg0WXRmQTJzRms5NHl3UW4xa1JZQmptZEJLdG5OZGFCWi84?=
 =?utf-8?B?ayt4QzEyd3RpbGU5RWR6TzdNdi9ZRXYrMzJ4ZDBpWWhXd2dpUXBsc05wa3hK?=
 =?utf-8?B?b0dxZUpqQ0srdk1UK09ISy80RDFpZWNMYkR1YjdZN0FaNEppYWtXMmh3eXR2?=
 =?utf-8?B?ZnI4Ymd4SkdTOWdHcmxjbzVHbjMybmd6N2xoSE4xaGhMTkFXREE4ZzNzZEFt?=
 =?utf-8?B?bEk3UFlpL25hYi9OdnNyQlh4VmpVeU4vMW5hVHlxTTc4U2RWeXZ5VXpKYmdz?=
 =?utf-8?B?UHV4Q0lCTFQrRDBRZitQL0Zxa1RIZ0hBcVZaVnprTjVTUjJ3NU9IRTlyNHpB?=
 =?utf-8?B?VnlEWEV5OEhWSS9tVWU0aFp1R0E4eFBvcFVlT2daV0l1UFJtN2d1TlVSQ1BK?=
 =?utf-8?B?M2htOTEzVG94c2ZFakF4Ukt1U3BLS1dpMW45c3owMkYraTBZZEVUSFFJRWgw?=
 =?utf-8?B?RWRPU0tkZXdsUG5HNmVIQWdLYUtFdTdVR1IvVnNrSHZGK2YxZFZvYW1HcGFt?=
 =?utf-8?B?WW11TXNtU29wTW9MTFgxem01L2NOVE5Oa2hqVnpWZjdyYVg5dU1Zb2FDTzBx?=
 =?utf-8?B?QUk0SVBSNGFHUUdhcUl6TEorRllrZUl0N0gvcms0Z0I1Z3pVSWoxakNlMDFz?=
 =?utf-8?B?bkdhd0g1cCtLckdXMVgzSkhjUEgyRkNiTXFJMGhHZXgwZks0YVdMLzh0b2N2?=
 =?utf-8?B?SGswbFRxME82UVUzNFZJckR2enJWc0FVd0xLOWIvdkZYbG9xbzBsYTdpOEpv?=
 =?utf-8?B?dXZSdFZxbHlCY2hrTXpmNnFPUVpBbFpZYjRESndJaHEzbGN2YjR5RnpDc1FZ?=
 =?utf-8?B?d1p6MlFrZW1kbHE1aldRRFJ1d1dRb2w5RzUvN2NVMlpMdmdXc1lVTjRMOG1P?=
 =?utf-8?B?Mmt4Nm1CaElLQnRFZnMxWGI2ZlpLSXgvcGQ5RjFna21wdDFSTFBDYkJaMmIw?=
 =?utf-8?B?WjlGdzNBSGtsYWdYM2EvU1RxSWhhM09tVlhFU05EMmE3Wi90L0pIeWNBSGgz?=
 =?utf-8?B?b2llV0J4ZmQvR2l2bXJ3Smg0UnptbG5lNGpqUFl3VjlzRTJBNC9uaHFRUExY?=
 =?utf-8?B?Um5QMzkwNmhkTloyai81RkdJb2ZTeExNamdybTI1ZSsrQlFCazRUdVdYY1BB?=
 =?utf-8?B?Zm9rbGpGK3dZRjNWWDMrYUphVVVUS0JBcDlycUhZaDdybHJDekp2RC9obmpT?=
 =?utf-8?B?WTRITWJJSzlkeEVwN0Y0MzJKTHlvSlZaRU5ORUUvaUxiNHc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WENDcmQra1F2Y0VzY1M2bFIzNVhxdElOZWVsakJySGY0V1ZHc1FtRnZHc1k0?=
 =?utf-8?B?M1U4YUNka1Nib2lpbTFOd1VVR0Jrajd5Z3RnMCtwSm9IRDRpVnVKbXNGSGtv?=
 =?utf-8?B?ZmVYRVY1N1VBUVg1OWNNZS9YajUrRThyZDlUZm44QzloN1BnVyt4QW9aYXZ0?=
 =?utf-8?B?L29BN1dQbGZZa0VmWGoxTy9KVkFNVk1OUXJBOTBRQmNLaDdMd1lqZ2l0NnVG?=
 =?utf-8?B?a1UzVTRIRStZRDZoeGx6dXd6ZlI4YnpmWkNCYisxelREQkdETnIycE9zT1VE?=
 =?utf-8?B?SlkvVitEM3RBdzBKUGc5cE80djRTQnV5dUV3SHBVUWxyRm9LSW92c1Y2TTly?=
 =?utf-8?B?d0xSWXMreHd1SFBEc0VmYVI3VjBCajU3WjJQNVpNNFdIblFzbmgrVlc0dUF5?=
 =?utf-8?B?anB6cDFjNTNzTSsybnRSMHZ0cXppYStmVEVSaWxqY0NHTGlhekFsTFNvNXBD?=
 =?utf-8?B?SnhUREN1R3B3RzR0NEJBWXdhMENJRmhkdFdGS1dMUGQyejUxVTBiM2hWRlU2?=
 =?utf-8?B?YXBUbDAxMUhGMUM0M2ZFazhqaElleW1aOFpZd2I4UDlTWEhtbmJVc2lLUWc1?=
 =?utf-8?B?aFNyRktnd1RRd3JoeEdyOU9OckxwdWpWK0psdkNtMUpEUk1NN1ZNb09UNFhY?=
 =?utf-8?B?V3JFOUxwV1lQVjdWeUltU2hVaGEvR1drWHVuR2phckVqU2M1R2U1aGlwUEhp?=
 =?utf-8?B?QnVxQUt6RVRSdzR6dFVINlZPamNxRHJkd3dOL1k1alFSaXZxTlhTbmZneHJu?=
 =?utf-8?B?RmdRQjAvUlkyMHFYVG9Fb3RFcVE0NCs2bmo1NXpOVTEvZ0NuTTBRNk5OZERp?=
 =?utf-8?B?SUc0QVhOcDQ1bVhMb1J5Z3dsSVJZbS9xUC94NEVxVGRZNTFMdFhVSlphaldp?=
 =?utf-8?B?U3FqWmhIVlowbEd6SzR5MmI2NGJld0xnQzFLSldmRlhSSU5HZ2VFd2RkbUZ5?=
 =?utf-8?B?R3lKR2lSeXI2MTFVdnFXcnNiOTM5KzhqV2I3YklPK2QreXl0VkpGb0hDRjVH?=
 =?utf-8?B?RzdaN1dEUkJUb3ltUnU2QWsyZVFmVHUrR0dYZWpCd3ZVOWZGaHoyaFAwWWF1?=
 =?utf-8?B?MUREaWVUU0lOV1VGMzE3OFpCNW1CS01RRHdZTDAydDlIQmFuOWpqY2xHZmR6?=
 =?utf-8?B?Qmd2UGtGdmZkYUpaYXIwZXRJaXUrbGZCdUxSZyswbFZiWDZaWmRITTByRnlD?=
 =?utf-8?B?NktiaFFXR29ZWmNaZVZNenpxWkhrMHV4NGRSeWtYSnBQY0JydDYwdDZrV1hE?=
 =?utf-8?B?MU40WGZpUG51SGkxam5rTVRnRTVoTW5tcWo1TG5zN1RnYXZncVBHYndQeU1E?=
 =?utf-8?B?Vmd4UXRtMkFXcm80RUVRSVNVcGpZZkdFakFQdDlVbGNxRDRZQ1RKTkZEbmR2?=
 =?utf-8?B?aTMranRZSVppRUpuL1l4NnU5OGlwMFU3QjBhS3pyOTdFdFBWZzJVTFdHd3Ra?=
 =?utf-8?B?SDVzMFo5V1c2RDF0TFMxcHBIY09Ld21FQXJMNkUwOG5ybmpaN3dsenFIMFJ6?=
 =?utf-8?B?VGhxYTlIZGpKd0Y1MUFoYWVXRzFzUFdnc3NxL3pOTDdVOTlDYmRmZWFXd1Bk?=
 =?utf-8?B?dVVWR0xpZkFVVnp0UmFXK3VURkhLdWdCOVJYQlB5c3lNMld2a3plMnp4QkxX?=
 =?utf-8?B?cW5BSnJKbEVKRTVXYk5IS0dtZ0MzdmVtMm5hMlhPbnQ4L2d1aU9ycW9udUNN?=
 =?utf-8?B?M0R2L29IZ1hrYW96cWEzQ1MvOEpReUVrcitISDRrdGNkU0drTE9vUVBLOUlu?=
 =?utf-8?B?c21vS1UvbDJnbzJJVUNhM01pRDJhS1JrNStaaVJLRWd2UXA1VjhyQmZRVVFR?=
 =?utf-8?B?TFIrQjBKaWphcUtuQ05WZjBVNlRBTi9IbXgxVzdzTTIwMUpNWHNqclFNZXVV?=
 =?utf-8?B?N05hbjlDeGsrdEZOZnBndm9rWENxbWxBQ0hid0Z2dEpQYkFDaUY4Y3NhZEpM?=
 =?utf-8?B?S3Z3dkdJNGJuMVNMaEdQMmkzM0lXbmJ3WHRUVlZMOE9hZG45K29IbFJla1F5?=
 =?utf-8?B?NFZFVEtqMGY4QlJPSXlwdVRCSENscklvVXNWRWx0NXh3TjVWL0VFRVBJRVlE?=
 =?utf-8?B?RTlaMHQvVjVGRmMzNk96eVFaTlM2aUZiN3dRYS9MeFp1SUtldUxWaWdDNnJV?=
 =?utf-8?Q?4CJzmvhN2GqaJ2+4jHLizzbUS?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b34a34f6-0f30-45ad-0d30-08dccb378120
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 10:10:43.0602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jf4Fo+qIPqqd7Kfu2DqpEJgSLdErxTw42SdEjmMsUW1nnoBnlCb8CQSVyk6sLUVc+Bm3LRqrEICoR83nxPnfzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10099

From: Peng Fan <peng.fan@nxp.com>

Add SYS Power, BBM and MISC nodes under SCMI firmware node.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx95.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
index 7880d3efbd7e..314a45e82c38 100644
--- a/arch/arm64/boot/dts/freescale/imx95.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
@@ -301,6 +301,10 @@ scmi_devpd: protocol@11 {
 				#power-domain-cells = <1>;
 			};
 
+			scmi_sys_power: protocol@12 {
+				reg = <0x12>;
+			};
+
 			scmi_perf: protocol@13 {
 				reg = <0x13>;
 				#power-domain-cells = <1>;
@@ -320,6 +324,13 @@ scmi_iomuxc: protocol@19 {
 				reg = <0x19>;
 			};
 
+			scmi_bbm: protocol@81 {
+				reg = <0x81>;
+			};
+
+			scmi_misc: protocol@84 {
+				reg = <0x84>;
+			};
 		};
 	};
 

-- 
2.37.1


