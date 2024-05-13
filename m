Return-Path: <linux-kernel+bounces-177521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F18C78C401B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 13:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B1851F21E4A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 11:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD24814D2BC;
	Mon, 13 May 2024 11:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b="Z8Ota244"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2045.outbound.protection.outlook.com [40.107.6.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399E243AAB;
	Mon, 13 May 2024 11:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715600962; cv=fail; b=eiM2uQ7cx0Ldjnl9IhEQuc2GL6sEIKVeGl7OgaERPBPmudtzVnZP1sT1eERMLGOk8EhHSQTDUeWYPN4Cnq+GaKIjzdpL4IBIglKuVu2ebhMf87ZpN/dPNmnaXKORiIxTrlNGoSi00sjjkFy3QPO3AKM83pK7+Sj9nHn+Tz2ZE8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715600962; c=relaxed/simple;
	bh=UsmkF+WSBAk8aCGjwKZ/3s+hCUV6uhVUz39MnURhfqU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nqRTYek5ClxLZaI4W4/j7ORGOmULYgWV+W1dNmbhuadly0AGjUEcr8axw34BoQE+XObnj1VTIEkPZxZVpderFK1QJu1P3XnBDCtFQBdPMVlzPn6ufK4ywn0u0+RWew8hVXQKjMBjyaDmH7Z08QlE/v5Y83JyvchT80Wv+xQSFlU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk; spf=pass smtp.mailfrom=prevas.dk; dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b=Z8Ota244; arc=fail smtp.client-ip=40.107.6.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DzirSeos+fYaaLePDrvL4EGd4bCTbFt/50OKpJAD1HW4TzVs8VPz/7iMRGKxkQgA/OBOi9nBA0/c0+O3bGlNjiSO2454YHNjRVgSRAWZRdv3nsbz5dG7powioSmpabMie8e3F0X411iZQJBIFkpqNq+NBMNf53jc39U2wpCgqKtQr8IkaS6zxOKDjKKt82H61fX+nNxiIH5rCwaNjkWST2tsGUpCS52iIWH7lBcmLkif8S6GhY3CDFiIZQCnPAIp02y7nMkQDrRSzge86PabvfcOPchvlz4WASkO1Oq/bkd4VGlWIaYWsUkR7tFrU7h/gr0TYD7DDG0TyUa0eD7MOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nPsQc+qF3ZSKhZ0eETmnwIrTyPjESplZkibZ2fnliGM=;
 b=dPDJawSXDm63Yj7FInoAkB9SgYuFz8iPf6GI28YMWpdQWm1uDDz3v1VgJLBDD4q+DTiFcxZKPJCOPPNqQvjeHImzyeGPp0rPZDmAnX0jUaFpdSAWM3DOZVBeWtWga/UbxLrONFFx0uP9B+3wVuzzPQP9+iQ65Kxt103beKc4clmXsHr2zkEZty8eG3gSXt3gSza88vRLkcvbGlDCGOXJ28ObNFcgyVQkMRbVH4Q+xexnxqlRe8yXwWkTVUK3FSwjpa10YjDR+j7NAZlNNCP5H2pF4aNdTFsRcyc9GPw3bEqQJqKewXBb9de0YuBH00V/R8asqoyjVAIkJbb6aKwDuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nPsQc+qF3ZSKhZ0eETmnwIrTyPjESplZkibZ2fnliGM=;
 b=Z8Ota244jhpk0dubZYB9TK+CfAlnRprelFHLLJe8aEwK3jPRLNHyU8JjgtVNyxtFGBTJtYFVd/QnBJFfRWULipEEl6s0fiDvQT3HtcIP0H5jDqJJlrxMC5v0l+27KIJ17Q4dRcG3mFF3s4mGKSC+zAOOm2IvwAEmfG23rEIkx7I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by VI0PR10MB9009.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:214::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 11:49:14 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%3]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 11:49:14 +0000
Message-ID: <cfceb49f-ffe9-4473-9877-ed92ab0ace1a@prevas.dk>
Date: Mon, 13 May 2024 13:49:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/17] clk: imx: pll14xx: use rate_table for audio plls
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Abel Vesa <abelvesa@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Jacky Bai <ping.bai@nxp.com>,
 Ye Li <ye.li@nxp.com>, Dong Aisheng <aisheng.dong@nxp.com>
Cc: linux-clk@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Abel Vesa <abel.vesa@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Shengjiu Wang <shengjiu.wang@nxp.com>
References: <20240510-imx-clk-v2-0-c998f315d29c@nxp.com>
 <20240510-imx-clk-v2-6-c998f315d29c@nxp.com>
Content-Language: en-US, da
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <20240510-imx-clk-v2-6-c998f315d29c@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0005.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::35) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|VI0PR10MB9009:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b0e257b-751d-4413-c616-08dc7342b637
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|7416005|1800799015|366007|921011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VFZMYnpTVEZqTmxzUjBrT1ZEVEpHTkZDUVY0ZUpqcXZ2cW50RU1ESlFXNFlu?=
 =?utf-8?B?T1B0V2FwM2o3WlgrUld1azFwMXdOQVhJN0dBUnpnYVRHekdYcmNHSVBpOGxn?=
 =?utf-8?B?cGt2ZmFXRHJ5YnhDeTVrR3kxeHRkYzBiMEdsc3BkSzZrcGxiRDNoUldQMlBm?=
 =?utf-8?B?dlhsb0FTTWYrVzYzNjZYT0lEUmRraVhEbnVlaTFyL1V4MzVDWGVNMi9XRlhU?=
 =?utf-8?B?V2hWamcwVUoybVBEZ3ZLb29yQTVoNVYvVVBVcWhzT2RJUmhWY3V3U2EyWkRu?=
 =?utf-8?B?NzdDQWFFOUR5aW9YenFuWU93Z3F4OG93dFBEdURURFZWNTQyaVNuTUNYT0l2?=
 =?utf-8?B?a2hjZjF4OUdEc2owTVBnNXNIUjMwVXhPbXU0SjVmRldZdjhOT2liUi9uQmlD?=
 =?utf-8?B?b2tkR3RIOUUwazRkZU1XMFlLYjBlN0l2WmV3a0JsU3QxS3d3ZmYzUDNKMERq?=
 =?utf-8?B?WER1Sjh6eTFFdEM2cTlHN2k1TzIwUS8wNjZ6UkRjNWduTmpBaVN3U0VPaFBY?=
 =?utf-8?B?TXlkSTdhTWVDc1hZSlhPbUtCTFdlSWZtNTBuU1Ewdzk0VHhjWTJtWmR6Y0hR?=
 =?utf-8?B?MnN1d2RoRHpFWlBkZys5TVU5QmhxOHJhTFYyUjhpazNwZDlSOHRmOXJmL0Iy?=
 =?utf-8?B?bG5JbWswek5pWm5lZjFkVEh5WVYraHM2SkNibmgzdk8wL1orQkdzdXpRcy9Z?=
 =?utf-8?B?WW9HeXBEblpnSytVSkpuZHZUREp6bzR3WWdiaVlZaFVYd0JFak9TTGxYYzcw?=
 =?utf-8?B?ekM2c2V0UGVsaW1MRjdYSnFPYlRJUkRQNnpkcTBHcjlINXBGZkVCZFY2bWtW?=
 =?utf-8?B?dEVjUXZ2c3A0MUV0dEpzZXhVeVc5dVZqbXIvaHBiM3RwcjMvZlg4MDRBQllo?=
 =?utf-8?B?OUo3c2puaVdtRVhDR1J6YXVVTzhoeVBpOUZ6VzZYT25IS3V2SzllcGJsMnBt?=
 =?utf-8?B?bEtMNnFxL21FYUtsNEJ3WFVITVhTYXFLTU1NR3NoSmJlUzk1L0g2NTRGZE9Y?=
 =?utf-8?B?UWxzWkVpWnR2dFlCZ0QrKzlpN1k0NjdzL2tQdkwwQmVXOXppOUtOMmNjOHdU?=
 =?utf-8?B?OHhnZ2ZlRWthcTlOVG1rM2VGYVlsUWJCQk9VejkyWGNSVlNFRTJHbVpYSExv?=
 =?utf-8?B?NjZFQUZSa3plL3Z0VzQ1TTJ0Qis1UkJYRjUwOHNyb1RhS0RUTXNqMnpQSW9x?=
 =?utf-8?B?eGczM1RCckFRLzlNWXRXeDhHelJZeVZwaFdXQlFmNHMreHFhZEU0WEpma0xL?=
 =?utf-8?B?OTFOZmRZUXU2Qk52dmROUGZtMGJOUldYTXROSGVYVVlOVXBOMU1ab2tMeXJJ?=
 =?utf-8?B?N0RUY1lRUzJ0TTVYcEg0T3NJamJ4NkF1N2lpdlpVa2dON2V0anBCZ3hEZzUy?=
 =?utf-8?B?S3hFcFZQZDJDMXc4SUJybWcrbE1ncVhoZC9mTmtaY1Zjc1J1b1RCeFRuM3FV?=
 =?utf-8?B?enU1b2VGZjkrWjN4S2sxblB2d2VBcDJ0dVpDZGU0OHVDZjMxaXFhYzBVZ2Vn?=
 =?utf-8?B?QldyQlR5VjFJM1kwUUM2WUczdFNtQXk3aXVVWlN0ampHN2pibXRZYjFxYmJk?=
 =?utf-8?B?S3MrRGgzMU5XOHJpcWdtU3Q1UDJjZDlQY3Uvb1QreHdQZEw2QmRaQXpRUGd0?=
 =?utf-8?B?OW9FWGdsZ0RxemlacTdvOVF6T1Vjc2NReGxpayt6d2lmMzh2ZElqSktUZVNr?=
 =?utf-8?B?cDZTL3FnSjZQVDZHMHNYZ3JjdTlGVzhBZFhBS25LU3FzWmpSWlNsOThiWm1N?=
 =?utf-8?Q?48Ou4D/aMAJklu+PfCaSvsxrhHScjEkQUFetRHl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OUlWRnF4SGtxZGlUaGVReUhId1h3a1hzL0N0ZXR1T1RtaUcrWWp4R0gvUWhl?=
 =?utf-8?B?YUszR2grK09OaHJ1NXpQclQ5dXhHYzgvNGRkb3gyUmlUUHJweFpYcWdmbmxZ?=
 =?utf-8?B?bkxGSHR1UnNRbzgvWDMvTVc3cWNtZFFKMm40QnQ5aVBTOHE1RURoa3JHNU5U?=
 =?utf-8?B?OHppeTdySUlrQ2NJcmxRa0xQSSt0QjZCTTVweEhqVEVzKzk4RFFOL3RMVzJl?=
 =?utf-8?B?M0wxanBQSjgrMjdSSlJkcjlwcWZlL3hkUlFndTBNMWYrSFN2cC9hQ3Z6T0RZ?=
 =?utf-8?B?WDJ6R09QdGg1UmhpNUZBZjc0bHRyRXhCbUF6STlYN0NRVXVmZW9tWUZkWVp3?=
 =?utf-8?B?MUZtZ2NNdDIyVGlyZkYrb0FJeUtmRVY5Z1Bodllwb3FNSko5WWFPbmtzTWMv?=
 =?utf-8?B?dkd6QmZ6cktpSGNoOXNHQmQ4RUJTZTM2YVlOdFl1WjBhYlRIRlJ4dWZrdEZL?=
 =?utf-8?B?bVJNa1h6TDZnbW1jbmdkVjNyNVEzd1dJWEViazNYWGhHa0FiYU1VKzJQRlU3?=
 =?utf-8?B?ZWkvSnRXazlCR1owaXExTmI2am44TGRhSk9yVTdYTHZhM1VNVGE1b0s3aURM?=
 =?utf-8?B?bnlDbURKWHcvcjE2dG5VQ3RBTjVQY0I4Vk95RFBFS0VudzZzeS9MVENkYW9Q?=
 =?utf-8?B?Ym9saldTcjRnaGJMcnYxc0plcDd0TU01Sjc2YXJvTG0rM3E5cXdYNFpjQ3BZ?=
 =?utf-8?B?S2p4dy84VU94bXlCNmw5WUM5eVhNYWxQUU5FSnp0Qjk0V2F5TkZmcmtTcll0?=
 =?utf-8?B?c056aG9sT1gySnN2WTFyU1hxZ2ZGRUtQZWFtc3FveGlLQktXNWNmLzdZMjZ2?=
 =?utf-8?B?RnhQNU41Q3k5cSt0ODVtZDc0R1B0SXRTNXZCSnRCR3QwQnljaGFlcHdiWjkv?=
 =?utf-8?B?YUdyd0owbGw2ZThSQTJpRjN1Z1FYQ1B4bEFBcFk4eXlSRHFxS2pweE96enZF?=
 =?utf-8?B?a1lzZ3I2R2YxY2VLT1RMYzBoRlQ5RWZ3Z0k5SjR5andGWWJDaFk1eU9SR1dX?=
 =?utf-8?B?MjlMbmR5bjlVZlJnVmtXV2RXaVVwM21iR1h4TDBFWnVWZTl0dFl1UWNYQ1FJ?=
 =?utf-8?B?ZEN0VFNuM0tncndJTjZaenZtUnVpL3VTcVd1OE45MzdEekZxbXVIMFhZdUR1?=
 =?utf-8?B?RDgrSlFrM2plV3pxQmF3V2hqUUxJazBoUEM1MlVOeEhMbjVBS09wT0JlbWk3?=
 =?utf-8?B?ZHZZZjZoL1RXYjE2bG9iUk5iVTNGcU4yekRBTkJpM0VZYkdUcHQ2akFMN3RX?=
 =?utf-8?B?Qm45STk1ZmF2TUFqSk1scmpJVE1rT3l2ekdNK0tZdmtPZzNpWnFHMVdEWG5M?=
 =?utf-8?B?NUZUaktTb3BORnZFclhnNURSd0FiQmJMQWdSaDBKYTV6T1piKy8zcFRYUVU2?=
 =?utf-8?B?a1cxaGtSSG1Uak9OZDhPNUllZVlZZXVMSHJzYXdQcitYamxLckFyc1Y3dFhl?=
 =?utf-8?B?QTUxZjRQaXlFOFR1SU5UeDcyZm51UFJGdklHR1BrS2ZDdDhoLzZ3RytNSjRP?=
 =?utf-8?B?RnZsa2Y1MEo4VndWZE5waUs5OG9tSk5RNWJUNTB2amF6ZXJ2T20zcVRlV2Ra?=
 =?utf-8?B?Wm1BT0RtNE9ESjZ3RGRhKy9od1MxNnlENmtLVWpRUlpZZ01QYnhxUEFqU3Z5?=
 =?utf-8?B?V0tCK2lIN1IzNkhZT0l5U1NSb3E3d3lGaDR2cUQ0cFp2WGVxZzdzbUx3dnZu?=
 =?utf-8?B?Z3hnbTN5ZndHOFVYZURPbTRSdC9OVDNzOTJuTXI0czRteTl6MlBiUWJRS3lt?=
 =?utf-8?B?dG5LaEdJOUZKc2FUa0pJRkVuWjRNdS85Vk82aEV1Sm4yb09TYllPdkIzbnpq?=
 =?utf-8?B?SDlGY1J4dENpdnUvL1AzOXFyY01BOHpKQlo5WnJIT2g2QWVCdmZTZ3pERzd4?=
 =?utf-8?B?bEs5MWJwcGRHdldIRjVZTERyVTBhRVI4c1p6ckNOcE9GVHlzVHQ5NEVsd0U2?=
 =?utf-8?B?T2thQzVrVG55MjJYZ2Rlay9ObzJITXRHd2xiUUxkYm1kVDRMZkx6aVJBcS9V?=
 =?utf-8?B?cXVCTFVvR2tvNFp0dGlhNCtqWGR4QzZ4S2hrNWp2QUR6c0cxMkJxRWI4ZXJG?=
 =?utf-8?B?VCtjZ2UvMUhmcnVjRmZxQVQxOXQvUGdlcG9NVDdtOU5SaTdXRW42eDh0QWVD?=
 =?utf-8?B?WXZrTlI2R1ZMdWZ0cmNBblVFZHo5dUZaeWZjeGdRRWdZTlphTmJMd2Ztc0xU?=
 =?utf-8?B?Vmc9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b0e257b-751d-4413-c616-08dc7342b637
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 11:49:14.3363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iMQbgRCQ1DOM7HPoyp/omA9zP7a6dOL0Gt9lSkuqdhLfMENqxynJ/PLjTbS7vGBFL+XFbwTIu1X9uuiJFg/sjM11YWv0YKpycrYZgvp6/+Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB9009

On 10/05/2024 11.19, Peng Fan (OSS) wrote:
> From: Shengjiu Wang <shengjiu.wang@nxp.com>
> 
> The generated clock frequency may not accurate, for example
> the expected rate is 361267200U, but result is 361267199U.
> Add rate_table for audio clocks to avoid such issue.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> Reviewed-by: Jacky Bai <ping.bai@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/clk/imx/clk-pll14xx.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/clk/imx/clk-pll14xx.c b/drivers/clk/imx/clk-pll14xx.c
> index 55812bfb9ec2..6b2c849f8b71 100644
> --- a/drivers/clk/imx/clk-pll14xx.c
> +++ b/drivers/clk/imx/clk-pll14xx.c
> @@ -64,6 +64,17 @@ static const struct imx_pll14xx_rate_table imx_pll1443x_tbl[] = {
>  	PLL_1443X_RATE(650000000U, 325, 3, 2, 0),
>  	PLL_1443X_RATE(594000000U, 198, 2, 2, 0),
>  	PLL_1443X_RATE(519750000U, 173, 2, 2, 16384),
> +	PLL_1443X_RATE(393216000U, 262, 2, 3, 9437),
> +	PLL_1443X_RATE(361267200U, 361, 3, 3, 17511),

Sorry, what? This reintroduces the two entries that were removed in
72d00e560d10, claiming that this produces an exact output, whereas that
commit very clearly states (and it's easy to do the math and verify)
that those entries actually resulted in output values of 393215995 and
361267196. So even if the dynamic computation would result in 361267199
(it doesn't, it gives an exact output), that would still be better than
what these hard-coded entries achieve.

Rasmus


