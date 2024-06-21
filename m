Return-Path: <linux-kernel+bounces-224677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D63049125B2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 14:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7655B2A0CB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 12:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53CA5155323;
	Fri, 21 Jun 2024 12:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="kYSasvLy"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2049.outbound.protection.outlook.com [40.107.8.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1606015625B;
	Fri, 21 Jun 2024 12:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718973484; cv=fail; b=OGH9LM/Ionm/L188GwoX5jCSfi4S7OQLQ7D4+H6gcogC7+JjaIv0DBIyte9/3KZmx6wTwtiqEywo3VGLfDlzyIPb1vP86Xf04PIjZAmOYRXkOjvfkii9gZrP1iRy5zS0kVI2acMpPY1ZQpBZ872xl2FiFTGWQfnW3GOoSxGVsb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718973484; c=relaxed/simple;
	bh=zXINWow/446qh/oJ3wBnSQyvR9Cx80nOyq6KxaBqgj0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=CWX2HqSKkqGqfmse1jHr6TiM6pNX/sz1uicdeNcC7Rkzp9c+vyjhPjDHJwPlvMnojKiZYB5kLpZSa0pKYPAbtxLaXU3/Vjln91YPaITmoAH+h/sylRH5CwiJumLKwskguG3zrjvoRkR9cZRxcD/JC15U7JX8uS1FR3qr4VJCdQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=kYSasvLy; arc=fail smtp.client-ip=40.107.8.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q5l7tHj/fnr+qwMGOAJbHoi2RcOBUbmUDG3ujOrJaPY86cU+WekqZf4YB56qN/pfjv+lSGJyR/2fdtN0JGjOyRN6DPy3NQc1wKVIh8Vn3fGO6y+mnqOdNux80SzIfywCiFChbTGhkh56ir/QufpfDPZihDqepBHd5FN8g5kHBZJAEsbL64ul63SM6XoiU1NFc+lAWUSFU8qe5A0cxprrLqflmVx4oVGsrOcfoUjTQcH5HAIknG+T4OVhk0i4sdId9ISKeK+tVLt799U3mX/kACnfzhJ1GlXh81txVGtMMkptShz4wzSxyyKQkIuBabLHjlOZvIabFNaLaI2SfLX0dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tQvBX14H9kyEKhbZC5fZD4gy0s6Y6n56TvnFOyYliek=;
 b=c4k7B41ODJ7+oKZK5y0etHoSBilIb0R/rVxSEFnTPSgNo5wjriOE2CYgWtwdEcSySJdIrZx972y2gcsxROZoG9RRowNxcUqocLtL6gkiie8JjIMtgP8Gp+Jr7NtGzB+CrieHSkgwy2KeQp45B3RFVhLmGnVvWWx11kiNulho58t3ysFS4LgCg4BGDjISS3JsEnpEa3KsVsWOStJncb+DWUjgQ9Qr4KWMorv5Rv8syd7OCIYLclbnZZFyxcoCUqgwJpAkdSybpyD8xoPDzjk3kKzAKJdRhZpvtwRP6wRuU5LsHNdZTvQCLRwFURTSXH5W+QUY45uwgZFC4JvHVsAf6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tQvBX14H9kyEKhbZC5fZD4gy0s6Y6n56TvnFOyYliek=;
 b=kYSasvLyaoNlWZcpLRXgmzTm6Es/3Tokqdgz0RWMwH73nqvrrIxRPAnvR7HQKOALqxZC2nCEEZfipd8OegBydtrnStVU/wRgeut60JgUIycQKcZHY7OaEzgpNt0K9HVWpwyt/wSozhdBiOnmmUAnRZ/O2ZYv0UIs/n7oAm/Fj/g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
 by VI0PR04MB10757.eurprd04.prod.outlook.com (2603:10a6:800:26a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Fri, 21 Jun
 2024 12:37:58 +0000
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256]) by AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256%4]) with mapi id 15.20.7698.017; Fri, 21 Jun 2024
 12:37:58 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 21 Jun 2024 20:46:58 +0800
Subject: [PATCH 2/2] firmware: arm_scmi: set mailbox timeout value from
 device tree
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240621-scmi-mailbox-v1-v1-2-8ed450735f46@nxp.com>
References: <20240621-scmi-mailbox-v1-v1-0-8ed450735f46@nxp.com>
In-Reply-To: <20240621-scmi-mailbox-v1-v1-0-8ed450735f46@nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718974025; l=6769;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=tz2/NaWjI5asca5j9w8U1Oak8RkVbzQDFFcujBPkR4g=;
 b=SnwXei2qTLUnmzPkCSG2PDPK/D0m3cc8HMQwV6GcYObxn6ynU4vulft4XOCSIZeYxtVBcjyS2
 2vP2xL1ZqvFBJtWDXDQBtJbFCORbzP97xzaEMtUYNPOcJnW3DGdVvrc
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR06CA0241.apcprd06.prod.outlook.com
 (2603:1096:4:ac::25) To AM6PR04MB5941.eurprd04.prod.outlook.com
 (2603:10a6:20b:9e::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB5941:EE_|VI0PR04MB10757:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ade757d-7c5c-4f44-c08f-08dc91eefb68
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|366013|376011|52116011|1800799021|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NG11eDZWUSt6UldTeUVlTHZhYzE1eTl6WFgra0MvbkpvNWsyRnhHUmJIYVln?=
 =?utf-8?B?TjdvczdrSDljN0JjTG5iYk9odlBVa1JZVGRmemoxeDVDYU43L3FnMGxNb3lD?=
 =?utf-8?B?dzA2cXpMczJVa3pVT3BJV1R2STlEZVk1bHJ3aVJjMGQ3YVp5SGdlV0E2cExC?=
 =?utf-8?B?ZWN6TmFuT0NmeDBVQXRCb0NQb2VCbHNOR2kzTHd5UmpxR0lhb2tndm05dGhZ?=
 =?utf-8?B?WlEvdFFiMCtqK1dscWNUaWtZU05jZHpwR1JLM1cyQzlSTjFHYy95ZzJZQVpR?=
 =?utf-8?B?cG1QYmtZM3BSUHNTZ1Z2Mk9WVWFud3JjaWVsd1o0eWdja2p4M1dPbWhSVFNK?=
 =?utf-8?B?cXdZNnBDeGh0eWRYam5jM2o1QWFHWUcwSHI3eE0wT3FpZE9sK0Eybmd0UzIy?=
 =?utf-8?B?azh4SUNWNjV0Y2VDZm5ndVh2bGZlekRHb3ZoMkpxVEJtVmU3YStHbDhxd2lt?=
 =?utf-8?B?clpwVVlxL09keWNhZUs5anVlZlB0ZkhpZ1I3SlNlYWVsMy80c2pqcm9wME4z?=
 =?utf-8?B?cEdpc3NiZ0JOa0lDTFZCZWNSVmdUbGZhdDkwODlDaUw5a01OTFZ1ejNERkVn?=
 =?utf-8?B?M05JR01mT1ZMNUVqaG1TNmp2OXZFdHNRdzB6eElhTlRNMFFYakN3VEtod1JO?=
 =?utf-8?B?bS9ubjJKU0k0WWFEV3ZuMnFxd0l0bU9oWHF6R3YzaHRnSVBldEFhSnlsLy8r?=
 =?utf-8?B?QUxJSW96TmlaeXN2UlBudm1rSnFQMktyZWMrNHBUV00vQVNITllUMVk4a0hy?=
 =?utf-8?B?TkwwczlKQ1p3UXBDQ3p0N21ZTXBTczlkdHZId2ozYzFkbks5cUJ1MFYrWWVG?=
 =?utf-8?B?K1p2aDdqMkMvMUhXdGY3cXU0TnREc2pCN3h1dDdaTUhBMTVoRnVDS2I1eisv?=
 =?utf-8?B?aCtvOWVmMjkzK1RTZG1sOFZ1citMRFB5eGRJQUY2K2ZkWUQ3ZGNyZVNrTCsw?=
 =?utf-8?B?cjJzUklqZk1Db2FDTUZyOUxHbTZhTTdiRHdhVGNzQkhjYTVWcmRxWXdYdlpp?=
 =?utf-8?B?Q0hGWWNuNXYwTFFGRkVCd3A2T0Uya1FFcUlNaUlScGpNSExTQUpIOGJUNUw5?=
 =?utf-8?B?RGU2YWhIcGt1ZWJvOVJiTG1LUjhXUEtmZW5QQlUwSXIwUDVFSUlzTkhYUStE?=
 =?utf-8?B?NUYrUk56dkVBN3pDQW8xaVVrcmh2Y3N0N0xjRVBrTlBHWUxsL0lxNkpwenBL?=
 =?utf-8?B?ZUVyVEZraUl6YitSYTVKc3NTYkJjQ2FJS0hvUi9PWnhEQm5BU3ByQVRCYTJ6?=
 =?utf-8?B?VDNia1A4RHlRZ2VReUwxMjNEZi94ZlZkbWlyanIxTmtaaDFMbWo2dStCWWRS?=
 =?utf-8?B?N3N5SENPbzdXcFhmaW5aTXRIVG9RQm9DN0ZncUdERDE5VmdJMTByUVFtZmJ5?=
 =?utf-8?B?L3g2OVk1RlNHZytlNTBoS2FSNytoVE5lQm8zMlpZKzl5NHQ5R2U3RENabFRN?=
 =?utf-8?B?SEhxejhPN0xzSkFhKzhneFlWYk1RM3o5YlZJcjlFNEZUNGpaSmNFZlR6cDNa?=
 =?utf-8?B?L1BOZElEc2N4cDd1YmRZZW15QmJWRnZCSldheXh6MmVibzRjcWVHN0lrWk1C?=
 =?utf-8?B?SHpVNFZvTmlORVZtdkJaMGkwWm1aNldmcDZpUkdJMGxMT1NJc204Q3Rjd3Mv?=
 =?utf-8?B?TDRwMTBZK0Rod05sdmtSY1FPSUsybTlxbm4xYWR1UTgvVjZ3bWwwZFFHUmZr?=
 =?utf-8?B?QXk2cTl1QkZ0bG1JQ0ZRN1BobS9aVEx2QVYrbjNRbjE4QkNrN0NLTDN3TkNz?=
 =?utf-8?B?OFVMNW0rMnhCTXMvMDJJcS9GS0VSRHhzVVZTd1dwOU9tTW9YblBtaHJTU1Jm?=
 =?utf-8?Q?DoFsxpEwIP+5bkQAn1bK3xdruQwKXI3bX+hI4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(52116011)(1800799021)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dG9HSUQ1RlRzVXN4ODB1dUxFNnJ3TG41THd2UytrTUdpbUd2YTExR241K1Vm?=
 =?utf-8?B?TDQwYlpZdytyZlRnc1N6NHVDdWU0cmZhU2lnczJqNWxrT0FVUjlGSlR2L3V0?=
 =?utf-8?B?b092bXlKTlZJb3liVFhXbTdTRE9TQmJHdzduODlucDNZU2pjQm9oK1lwRDAx?=
 =?utf-8?B?QUNqZzVWNXZHek54NFhBamVJWldEZkptRUxpNzhva1ZGbGNBcGFqYlk1SGJN?=
 =?utf-8?B?QWZyaGVsVFcwQ2V5S3VuVTgxZzcySXk0M1AvcVZEMXdKZ1FiR3UySThBL3Nj?=
 =?utf-8?B?cU92aG5hQUJLQjVMa3RLTXhkSzlwS0wzWncxeUN0cGdWRjA0d2RBRm9lWWpZ?=
 =?utf-8?B?UHd5NU5Edld4cEhOR1pKdEdxNHU3bDNXTWdFVU5PVm1xUytvZHIvRXcyZzll?=
 =?utf-8?B?V3g2bWJJQVJsNHFrVUNRQWNYalgzcFRwVGFxbFhudzVUR21ycjZjZDZxckNv?=
 =?utf-8?B?VytVMHZKWVVRbVUvbWtXdm1OMElTdjlDUG9sby9YUS9MOXNCT0tOVFNWZnFE?=
 =?utf-8?B?Qk5XeE9TWGtjSzEyWDlXQzlQV0l0MDJ1MVhuWE9oZ2RSeUtHdjQ1Zi84eDZu?=
 =?utf-8?B?UklIY2d4TUpBUzVFMTc2NVpyeWhyRGNBY3NReTlZQ2FGRnRtU2VVcXdIaWpk?=
 =?utf-8?B?S0MwdklSTGJNN1ZOYmlDOUYvVkl0Y3ZGYzNVMEJ2cEZiQWx0SHpsbHdjUXd2?=
 =?utf-8?B?ek1rUDg5a21iUUdvd2l4cHM4NFl1MTFoYUNEVFczNFhiOWtTL01zemFtbGYx?=
 =?utf-8?B?aEdiUTE2TjJhdXkwUjlJRGhzeFE5RTFhVlRJMURwMEFCZEtsQ3p4NEZTdTV1?=
 =?utf-8?B?OW90QUJ5TWVjdWNmc0FmU1BZcXpvVWNKaW5DVjFhaVV6bnZONEpPRVo0RXpX?=
 =?utf-8?B?NFh2dlV0WnJTOHlVakhyamRLaUtuR3o0anJSYVBEamVBak04UExNSVNNRlFm?=
 =?utf-8?B?cG8vdGVzeElweHhOb1JkTHZrUVllRnlEMVI5VHRkQkNON0JOVkJFRkV5NFdm?=
 =?utf-8?B?Mi94MTN4a0Z2MEQ2L1VoVEFVWEdOYXc2WlRBU2J0UVFJMWt3MXRhNThiODc3?=
 =?utf-8?B?dlRSK20vK25kZG5GNE1HMzJjcGZYcnVuckczSW5UbERDWWlIUFRIRUVrVU50?=
 =?utf-8?B?aHpIcnFIdGtEaEpRaXpGV20xOUZ4VVJNZDVBcnNESVJqN2Fkc2JhanZrQTVJ?=
 =?utf-8?B?ZVJVY3ZlclFUZjMwNWlpSGM4WUFPOHNiNmU0YWZnVEc4V1hkR0t3QU9EZUJa?=
 =?utf-8?B?YUt3SHN4ZjF1VkVkNFhOOWZxV1pPV01tQ24zNU5ac0pEZ1hKRW1sRjE5OGVQ?=
 =?utf-8?B?NHMvWFhHTjNxeTRDUFJKZXZodmxNY3FVaFNlMHZDcmJqU3FMRXArdFZjdGRw?=
 =?utf-8?B?aVFIMm90eUpFK0NwR01QZFZXN0h5Vjh6bEJMejBmQ2YyKy9KdEVQTm10STVq?=
 =?utf-8?B?K1F4akFKQzlGTlJ4UkNPcHpsRVkxK1libS9LZ2lLbjJrNlZPVzV6cmo5bWpK?=
 =?utf-8?B?eE50WHZpQ0xqTWM0VUdpNHhMVWltV0JGditvekRrQSt6M3ZtWGp1WmlEWTB5?=
 =?utf-8?B?VjQzamVQVjd6R2EvRUpCczBqT2NtZlJ1ZTZRa095QWh1L3lLSTFEc1BESjVM?=
 =?utf-8?B?aHN6cVQwN2JSRVRsaXFkbFdUUUoxSWtyUkNFUEZaRTV4N2ZpZUsvU213VlRn?=
 =?utf-8?B?ekdGTW0vb01lZS8yeUtoZDdWT2NlL3QwRUJYek5iRHNML0NHdEYzcWlHUTlj?=
 =?utf-8?B?cFN0SlNyS1VIaXBOQklYL2QwSTdFOG5mSXdmMjNESEdkOVh3TFBhU1NSVDhI?=
 =?utf-8?B?aFhEQ242S2VaN3I2TjNuREpPQ3R2U3M4eWkwL0dWejNTdUhhRkJBZDE0RkdO?=
 =?utf-8?B?OGUrSU9jKzhxWUZlTHVtVTd5WlUrWnZJL05wQkxaOXhMdGxidWFSWXRlSmYv?=
 =?utf-8?B?MWlRNEU0UkxkajVERWNjUE5ROTdmRGtrcnl4Y3d4WkdhZEN4OVRzUkdrS3RG?=
 =?utf-8?B?Yk1QTy9tN2FNbFJzd0hFc3o4SGhWWGlnYUNkdXJHb0ZTQm01TXdFRHZFemU0?=
 =?utf-8?B?RXZFeER3ZWppc1ZpVTZBWExRdncvSDZvbXlwRVo1QlJyL2dqdFdmdHlyMERS?=
 =?utf-8?Q?CHC9OpCx6SwKp4T0eMhPIDcMj?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ade757d-7c5c-4f44-c08f-08dc91eefb68
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5941.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 12:37:58.6971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cJV9GPI/TBdPOssBM+w73SJV5wLC1uIzBN3Xadxu+WocCuyFPmpC/25lIJ6X7X6cNfiQ2FxB5QJcdi6m0oVerQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10757

From: Peng Fan <peng.fan@nxp.com>

Each platform might have its own maximum mailbox receive channel timeout
value, so get property max-rx-timeout-ms from device tree and use it. If
the property does not exist, use mailbox 'scmi_desc' fixed value 30ms as
before.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/arm_scmi/driver.c   | 19 ++++++++++++++-----
 drivers/firmware/arm_scmi/raw_mode.c | 11 +++++++----
 drivers/firmware/arm_scmi/raw_mode.h |  3 ++-
 3 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 6b6957f4743f..1aa613d4cb43 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -162,6 +162,7 @@ struct scmi_debug_info {
  * @devreq_mtx: A mutex to serialize device creation for this SCMI instance
  * @dbg: A pointer to debugfs related data (if any)
  * @raw: An opaque reference handle used by SCMI Raw mode.
+ * @max_rx_timeout_ms: the maximum receive channel timeout value
  */
 struct scmi_info {
 	int id;
@@ -188,6 +189,7 @@ struct scmi_info {
 	struct mutex devreq_mtx;
 	struct scmi_debug_info *dbg;
 	void *raw;
+	unsigned int max_rx_timeout_ms;
 };
 
 #define handle_to_scmi_info(h)	container_of(h, struct scmi_info, handle)
@@ -1302,11 +1304,11 @@ static int scmi_wait_for_message_response(struct scmi_chan_info *cinfo,
 
 	trace_scmi_xfer_response_wait(xfer->transfer_id, xfer->hdr.id,
 				      xfer->hdr.protocol_id, xfer->hdr.seq,
-				      info->desc->max_rx_timeout_ms,
+				      info->max_rx_timeout_ms,
 				      xfer->hdr.poll_completion);
 
 	return scmi_wait_for_reply(dev, info->desc, cinfo, xfer,
-				   info->desc->max_rx_timeout_ms);
+				   info->max_rx_timeout_ms);
 }
 
 /**
@@ -2614,7 +2616,7 @@ static int scmi_chan_setup(struct scmi_info *info, struct device_node *of_node,
 	if (!cinfo)
 		return -ENOMEM;
 
-	cinfo->rx_timeout_ms = info->desc->max_rx_timeout_ms;
+	cinfo->rx_timeout_ms = info->max_rx_timeout_ms;
 
 	/* Create a unique name for this transport device */
 	snprintf(name, 32, "__scmi_transport_device_%s_%02X",
@@ -2888,7 +2890,7 @@ static struct scmi_debug_info *scmi_debugfs_common_setup(struct scmi_info *info)
 	debugfs_create_bool("is_atomic", 0400, trans, &dbg->is_atomic);
 
 	debugfs_create_u32("max_rx_timeout_ms", 0400, trans,
-			   (u32 *)&info->desc->max_rx_timeout_ms);
+			   (u32 *)&info->max_rx_timeout_ms);
 
 	debugfs_create_u32("max_msg_size", 0400, trans,
 			   (u32 *)&info->desc->max_msg_size);
@@ -2940,7 +2942,8 @@ static int scmi_debugfs_raw_mode_setup(struct scmi_info *info)
 
 	info->raw = scmi_raw_mode_init(&info->handle, info->dbg->top_dentry,
 				       info->id, channels, num_chans,
-				       info->desc, info->tx_minfo.max_msg);
+				       info->desc, info->tx_minfo.max_msg,
+				       info->max_rx_timeout_ms);
 	if (IS_ERR(info->raw)) {
 		dev_err(info->dev, "Failed to initialize SCMI RAW Mode !\n");
 		ret = PTR_ERR(info->raw);
@@ -2953,6 +2956,7 @@ static int scmi_debugfs_raw_mode_setup(struct scmi_info *info)
 static int scmi_probe(struct platform_device *pdev)
 {
 	int ret;
+	u32 timeout;
 	char *err_str = "probe failure\n";
 	struct scmi_handle *handle;
 	const struct scmi_desc *desc;
@@ -3002,6 +3006,11 @@ static int scmi_probe(struct platform_device *pdev)
 			 info->atomic_threshold);
 	handle->is_transport_atomic = scmi_is_transport_atomic;
 
+	if (!of_property_read_u32(np, "max-rx-timeout-ms", &timeout))
+		info->max_rx_timeout_ms = timeout;
+	else
+		info->max_rx_timeout_ms = info->desc->max_rx_timeout_ms;
+
 	if (desc->ops->link_supplier) {
 		ret = desc->ops->link_supplier(dev);
 		if (ret) {
diff --git a/drivers/firmware/arm_scmi/raw_mode.c b/drivers/firmware/arm_scmi/raw_mode.c
index 130d13e9cd6b..d4f37ee664a2 100644
--- a/drivers/firmware/arm_scmi/raw_mode.c
+++ b/drivers/firmware/arm_scmi/raw_mode.c
@@ -379,7 +379,7 @@ static void scmi_xfer_raw_waiter_enqueue(struct scmi_raw_mode_info *raw,
 	trace_scmi_xfer_response_wait(rw->xfer->transfer_id, rw->xfer->hdr.id,
 				      rw->xfer->hdr.protocol_id,
 				      rw->xfer->hdr.seq,
-				      raw->desc->max_rx_timeout_ms,
+				      raw->max_rx_timeout_ms,
 				      rw->xfer->hdr.poll_completion);
 
 	mutex_lock(&raw->active_mtx);
@@ -437,7 +437,7 @@ static void scmi_xfer_raw_worker(struct work_struct *work)
 
 	raw = container_of(work, struct scmi_raw_mode_info, waiters_work);
 	dev = raw->handle->dev;
-	max_tmo = msecs_to_jiffies(raw->desc->max_rx_timeout_ms);
+	max_tmo = msecs_to_jiffies(raw->max_rx_timeout_ms);
 
 	do {
 		int ret = 0;
@@ -574,7 +574,7 @@ static int scmi_xfer_raw_get_init(struct scmi_raw_mode_info *raw, void *buf,
 			dev_dbg(dev,
 				"...retrying[%d] inflight registration\n",
 				retry);
-			msleep(raw->desc->max_rx_timeout_ms /
+			msleep(raw->max_rx_timeout_ms /
 			       SCMI_XFER_RAW_MAX_RETRIES);
 		}
 	} while (ret && --retry);
@@ -1162,6 +1162,7 @@ static int scmi_raw_mode_setup(struct scmi_raw_mode_info *raw,
  * @num_chans: The number of entries in @channels
  * @desc: Reference to the transport operations
  * @tx_max_msg: Max number of in-flight messages allowed by the transport
+ * @max_rx_timeout_ms: Max receive channel timeout value
  *
  * This function prepare the SCMI Raw stack and creates the debugfs API.
  *
@@ -1170,7 +1171,8 @@ static int scmi_raw_mode_setup(struct scmi_raw_mode_info *raw,
 void *scmi_raw_mode_init(const struct scmi_handle *handle,
 			 struct dentry *top_dentry, int instance_id,
 			 u8 *channels, int num_chans,
-			 const struct scmi_desc *desc, int tx_max_msg)
+			 const struct scmi_desc *desc, int tx_max_msg,
+			 u32 max_rx_timeout_ms)
 {
 	int ret;
 	struct scmi_raw_mode_info *raw;
@@ -1188,6 +1190,7 @@ void *scmi_raw_mode_init(const struct scmi_handle *handle,
 	raw->desc = desc;
 	raw->tx_max_msg = tx_max_msg;
 	raw->id = instance_id;
+	raw->max_rx_timeout_ms = max_rx_timeout_ms;
 
 	ret = scmi_raw_mode_setup(raw, channels, num_chans);
 	if (ret) {
diff --git a/drivers/firmware/arm_scmi/raw_mode.h b/drivers/firmware/arm_scmi/raw_mode.h
index 8af756a83fd1..25d4a46261e7 100644
--- a/drivers/firmware/arm_scmi/raw_mode.h
+++ b/drivers/firmware/arm_scmi/raw_mode.h
@@ -20,7 +20,8 @@ enum {
 void *scmi_raw_mode_init(const struct scmi_handle *handle,
 			 struct dentry *top_dentry, int instance_id,
 			 u8 *channels, int num_chans,
-			 const struct scmi_desc *desc, int tx_max_msg);
+			 const struct scmi_desc *desc, int tx_max_msg,
+			 u32 max_rx_timeout_ms);
 void scmi_raw_mode_cleanup(void *raw);
 
 void scmi_raw_message_report(void *raw, struct scmi_xfer *xfer,

-- 
2.37.1


