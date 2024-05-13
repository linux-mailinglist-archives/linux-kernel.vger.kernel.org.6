Return-Path: <linux-kernel+bounces-177557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 847F48C40BC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 14:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ADD31C2146E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 12:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9995414F103;
	Mon, 13 May 2024 12:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b="Varx3K9N"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2058.outbound.protection.outlook.com [40.107.21.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100A714F119;
	Mon, 13 May 2024 12:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715603292; cv=fail; b=nyYolimizZkuRjVFzsUahoZIIf+lRrxNuvaM9lE9lMd6aMHsdxDP+AwrGv+ykvvxKNKgnt7LvTjGFP0FwH0jtAMTkR4QmoBchpv0PRFr4/yfgotJVjcYRhQd21/Yjj6p2+4d+StaG7c28xW1u1NwTrnsUHPcziGy0DY36t4OXlo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715603292; c=relaxed/simple;
	bh=qoMY1LtxHg/1wJOL2q6ImO4mcP6o1DhHD+epdR02FQI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Vjzsr/YckZ4+5YYruDs9H7Ss7ilSt7G5eRoY0KfXfs09HHFCXoSbopb2VdutIxKttWTsC+cVPPiAbmg4dMbNMsaKHXSGTplDEH3ebyie3WKOkskf02hKhKAhNesA7x9IT8u0bSYNuVK5tTT036laQJEiiVmjAza1cFaFPvbU43o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk; spf=pass smtp.mailfrom=prevas.dk; dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b=Varx3K9N; arc=fail smtp.client-ip=40.107.21.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WoCSE1f4iFTrwbZHC+dlfkIQZzpJT3ziHDCUJQurCWME+owfIeR9vzvqaCHSNF/mKs6gPmQBwIJM5Zk3q/C4BSPsd6I8ucoKCDyFXTyMAM+Bj+g4ZoXkfwHhKMW2djEOAE57o6rehQH6ZSn2mA60ahBxJSn/fdNjahYBZf4jsjG24sus4nqaY/pM3z619ovxXWD0TYskmTgqlcZk+XvYE0lK1AW1md6BFeN31myK49jG7ATIAb8VdSvMFDskxBulm88ylHCYCucvENoU0m3W5D1jARosYg4DGlR03339t6ByzHCVijZMItT04RhuT6UENL6swKB7woY8UatFiPSwew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LhAlsmrpS9BNXiixBg0heyh/somd7KSQjbQS3c2ZQY0=;
 b=ZKog1tkzfKBLzdEWeWWzF6++6eONOljpWErS+/h6RwyFZUvLacWr3gpuJzWJXB7Au7TPqUpLDESvjVKts13ZzrtWk2WSuRNKXt+oXHAYpXSfOGOjj+vNm+p5yDW9tcgnDP5fY7fCD4W4s+n4kbsUxTRw1hNJfybxUAzipzxmN01SQIaX+XIB9w1muMSSTdMeeE7vpsV8bpgriPoocTTVKa3Z/CDtbHVRKeTTu9SoycgkGkPTsiwcwJ0bAzcE70xtx6s9ZrhUmrhV468TvSwOZnrFhN+Qsyz9UT1BULqh6wjp18SJab2AF+Ag4VfmZeR/Fg0zHRCw0vPdsBLRR6BKfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LhAlsmrpS9BNXiixBg0heyh/somd7KSQjbQS3c2ZQY0=;
 b=Varx3K9NjSUyz1YwMlyzpXbiU5ig/pmEy5YRpR6a8XuBF2ZoggOD8YJAnwYrOVjiBP5Szx9Clc/+kRgXvjpxeY5vTUM+U73TNrJWTjnO/BXilGVD6qrCcZ56gTkknaABagPunjDasGepvh5hd5L7PoMWbuCmiD2MZtgqLdBoaxA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by PA2PR10MB8678.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:41e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 12:28:07 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%3]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 12:28:07 +0000
Message-ID: <2867ae55-ab4e-4a69-b24b-0535bc77ef31@prevas.dk>
Date: Mon, 13 May 2024 14:28:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/17] clk: imx: pll14xx: Add constraint for fvco
 frequency
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
 Shengjiu Wang <shengjiu.wang@nxp.com>, Chancel Liu <chancel.liu@nxp.com>
References: <20240510-imx-clk-v2-0-c998f315d29c@nxp.com>
 <20240510-imx-clk-v2-5-c998f315d29c@nxp.com>
Content-Language: en-US, da
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <20240510-imx-clk-v2-5-c998f315d29c@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0023.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:a::9)
 To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|PA2PR10MB8678:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fda2633-5723-472a-4fc6-08dc734824cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|366007|1800799015|376005|921011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZWdJT25kYTE0U3lxUjE1cUwvRkJyU0ZPckZtMmFQdlVZNU83cHZ2aFJ1MG9V?=
 =?utf-8?B?KzEzd2QrSlg3RFFYU1laZnlXNStyVmhYZlJ0Sys2Vy8zUzBmZ1lnbHpNSW0r?=
 =?utf-8?B?MDByRW8zenc0N0k5VWtrdVd5RXFrQ2I3OFdQZG5uWml4emhkcTZSd3Y5NHlw?=
 =?utf-8?B?bXM4SzdYN3VOQlpERS9uMnpySXRNSmxLdVJSSlV2WDdYWElYc3E1a3RmUVF1?=
 =?utf-8?B?L25nNXM4a1loZTVxZU05NFozVzhkNE0yeVdJUkRRQXBlU043WUFHN25mdTY3?=
 =?utf-8?B?NkQzZEd3Q2RSVi9rYVF5U2hRSTZtbjdZTGIzejVrbHlFOEhQbVloNU45SUJt?=
 =?utf-8?B?WmkzYW1QamIvU0NnU0ZEZzdveDBCblhxcGMwcytVOXBxUXFWbmw4VEpSeTk3?=
 =?utf-8?B?UVJ3aXJudm9pd0x6VVVNN2F1OVQ1YjlxQWdWYlMvek1vRWIydTRrbTBaeXV2?=
 =?utf-8?B?UTluais3dW5hQXoydkR6NXFzM3U3bkRRZ3hQNlFrVlhKWTQ5UENtd2tvSjNI?=
 =?utf-8?B?YVNQa2dOY1hlNnBNRHVFNnNERm5HNFVOV0lDSDkrM3c2T1ZCaEFnTXRjYUZt?=
 =?utf-8?B?cDJjYXVCL2RaZVJpZDFvQzBqQ1MwaU5zcHhjMEt6b0djK05aQnJqbzhWeXVL?=
 =?utf-8?B?ZTEzT2xwS2RueXlCRFlNd0ovVWFDak1VQVVXVEwrbnkzWmxHMVNvbHlmblBo?=
 =?utf-8?B?MVdxaURHeEJXeURNeFZVcE41VkcvaE11Y3M4cnlWZXNuVU1IZWp1WGdTR1RW?=
 =?utf-8?B?d3h0UU9rQ0E1RmRxUC9lQTg1Z1lWajR5QWE3cFdKV1YyVFRTNzZXT2FIekRO?=
 =?utf-8?B?Wjd5YkxUWVp6ckUrL2kvVFVDNHc0QUdEWkI2N0VPR3ZPcHJwcGkvd21Xa3FG?=
 =?utf-8?B?a3JVTTE0bFFGNlNCTGY0RlZHZXZoTmZNZEx4ZUtyQmxMZVBsaDlRcWNCRzl5?=
 =?utf-8?B?ODM4UU96WXF0OUFkdFBVQ1BZR1pESWtUTE9JZzdxczZZdUp2Wjk3NUF1UDVH?=
 =?utf-8?B?a1RCYkNFQ29nalkxa3NoaThXakIwRFJHdUtPdStpRlovaFNaU1psWm9SS1ov?=
 =?utf-8?B?MGltN0RNVThPdUVZYTZHYm9GeVlMK3dLWCtqcGVoamUyTWp1Z0RNTUcvSS9k?=
 =?utf-8?B?bkRzS1pubXNUcHdiYWcySE51WXdhUXdpYnhVSzc4UUpCZlkrNk1vVFVXSzc1?=
 =?utf-8?B?REhZYWtBRHpLTnFsREd2UVBiK3dqMjRVaHBVOUt4MlVnUnhBRklJdm9WZXJ5?=
 =?utf-8?B?Y3lFMnRxTzlDOFcwMGM5RnV2MGZwMm5GejQ2NlhkMG9xa0l2Z2RJYkxuSjR2?=
 =?utf-8?B?ejIzeDhxVDQ0YzBvR1REeks2MHBCQmltMVU2SThBQi9zeE0rSFIvSXZQM2Z6?=
 =?utf-8?B?bXpnSUdoOExzZmt2UlBXbE8xWHhYSTdvdEtVRXJySndsYzlGLzYvRzczMzNr?=
 =?utf-8?B?eGRWOFlqQlNVeWxhVFFTemhhc0tHWUl2RUNmTGc4eHFhL0IreWtHSXQ4ZFFZ?=
 =?utf-8?B?UkZoRm8yNnJZWG9GelMvTTl6ODF3Q1FCb0xvQ1lPVlJWOTk4VGhkMzgva0c3?=
 =?utf-8?B?cWhkYnBDenpFZzZ4b25FakppUkp1Mmd3aGlpcXVIMzZHQ0IxUVd1b0hCTFFO?=
 =?utf-8?B?OUMzL01SMXNYYnh1TTM5WG05SGRaQnZnaVM4enM1Z1RmWElwbXN6UjBObTY4?=
 =?utf-8?B?RjY4Vysxd1NWYVlUM2RWTjZQRk5YcWVtUjdYc1NYRFhRT2hkRktmZmxYUWJl?=
 =?utf-8?Q?ME1Y3GXpGA3vU2ZTWrb0efRRBD0tbA0Qe7dI4Xz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(7416005)(366007)(1800799015)(376005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S2hXRG9KeTFuUEJlc0M0dFUvV3RIZFM0RHRsaWI2RHJDZXdsOXc0aWJFbyt1?=
 =?utf-8?B?QkdrdFNZVndPejZsY0lLaTJLRnhZcVE3dFcxbXBzQ1VqTnZJWmtaUW5wRFBG?=
 =?utf-8?B?RGEwZHo0YlJkV3dLcDRnNGREMVM4MkMyYVZENTJHc1kzY1BGUWNnQ01samlh?=
 =?utf-8?B?SHNlTlZxaWxWUGRDUVJSNkFqY1lQK05zT2pBNHJ5TmZVQkFHbTluV3RZQUh2?=
 =?utf-8?B?dEgvK29BeTdUYVZJQi91a0czbGxUalEzSFJpbGRGdGlvSzVXMEVTdzd3RHVM?=
 =?utf-8?B?bWpJNDB3S2kxNndQY0lqaVN6ckpGZllyWnNXcTJNYjRZWmhYcHJDWDlHQXBE?=
 =?utf-8?B?eEpwMTNBSlJ6N25adGhEQ3pUV1RQdDJFamNXRmdoL3dmYlp6YkF0Y2dmd1RR?=
 =?utf-8?B?SnJ0SHh2VFNlYkljQWRxZjlaTE9uc0RoY0tha1NSVk5jQy95bzZVbDJPTkN5?=
 =?utf-8?B?UkplR3B6VnZzQUowN3VNTC9IV3Q5SzRheWxBbmJtUUZYT1VESFlhQURDTysx?=
 =?utf-8?B?OHZ4NlZtclJTUzVqWWZJREN3WmtwN0dnZ21LTHJIeHd3K2s1MkF5K2lsaEg3?=
 =?utf-8?B?S1dYaTNWakxxSXpZZDNrUm9TcDAxM25DMDVuRjdaaDFGZ0pKSjZPQS9LNEYy?=
 =?utf-8?B?RmFadDFUdGNONk9wRzBmUEptMGxRK3d2VnJNTHVCcnFJSU4wSTVsdVBtSTY5?=
 =?utf-8?B?OTFiZGt5UkNCM2tZblRUdkttSWhCVVcyVG95OUV2MSs0cVdQRHBpTUxZR1hI?=
 =?utf-8?B?UzdtQllBbStsbUI4N0ErdTJWYzI4TFhIN0hMR09XdmNEdFpmWlVmVVd6WWFw?=
 =?utf-8?B?Tm16MFo4K01OSzI5S2hFMHpSZ24zNFpjdDlNak12cHJTcmtYWm4zc29aNWtH?=
 =?utf-8?B?clhibVAvU1pUaThZdldEc1ZxN3gxZjNpUjI4UUxHekNDWlo3dG1vOHY0a01H?=
 =?utf-8?B?N3RkYlJnZWlNWHJwRlBpY0duMkpGUXVaMWtxaU1PQk5WeVoySlRMQXVNQmVz?=
 =?utf-8?B?ejNlVXZEU2FLL2d3dTUxUmF0WXJ2QThoMlUwLy96VDdVNmwvRkZDckppbjIx?=
 =?utf-8?B?SHFOdUVnVCtucUZQWXBLaGpQTUYzSFB4dTUyYlh0a1d1aE1tUEpzc2t6UU8y?=
 =?utf-8?B?cWg3aEhrRm9jUVNVajNkZHZ6aWdpemx4TEUwZDVhVFllNjdjSTVISEE5WGNs?=
 =?utf-8?B?a2hIQzBHTXErSGhvcUtNU29lbUpCUWo4UlpEOUs5NzZOS01oc3NUeklZd0pm?=
 =?utf-8?B?TzFINFc2Q3RsdkEzcVlLTVMrQ29lbmdWTUNUd0Y3aEsrNkV0clh1M2MvOENQ?=
 =?utf-8?B?U2thWkQ4YjhOKzg0VFdMU1lzWm8yM1VScVVyY0VCcnU0ZW9iUHN3N0VJVnVm?=
 =?utf-8?B?UlNnSnAxUHpiZ3ArNWc2SW9XRGF4dGVXS3FaclQvN2c0U3ZFWVJFQW9zL0JW?=
 =?utf-8?B?SEUzSUwrUVFyanp1bHFBbTdSMjBTamk1czZiVTVhanBxeXNyd1dNdUYyT0Y2?=
 =?utf-8?B?SDZWL0VsZVR3MWVhMHMxWW43dEs0YzdSYkFsTUtXY1FtaG5uRXBldmZDZ3Z0?=
 =?utf-8?B?VWdXalBQcTJZTmFJbnRZNVFzRlFQVFFSYmRzemdEQkFkZTVua0VoamNEcmc5?=
 =?utf-8?B?UnJrNzgzY0g1Z3phT055K0JyRDI4WWU1Wk9zMGJyZWt0U3RDRDJSRCtJUFNm?=
 =?utf-8?B?WnROZmJ3bUh6K1plOU5NU3NwczZGK2VUSE5RUGJrWkdBc1d0SUVkS2dGdEQz?=
 =?utf-8?B?aExxT2lsaTZsVUFJMnllTXBlMWZUN3ZFY081cGtjaVVqYTJpN1Q1WEhZQTk0?=
 =?utf-8?B?bHNIL3h4amFEU1d2S2ZzUDFCZDNoU1hvYjR2Y0VWMFVHS1hYUmpGR3ZWckVo?=
 =?utf-8?B?YWF6dHRScjYrVmVMSEgxUmdVdEhqUkJiVy9mSHR4V1loRE81RmFta09iYVR2?=
 =?utf-8?B?ZWRweER0TitPKysrc3Rod2NJZzRPQVl1S3N6YU5hUVdpdERWV3dFYThBQVUz?=
 =?utf-8?B?VXZHYjlEUEpwZjUrNE5xUlRraXhaWWpXcHVUeDFuWjJzeFErZUlDTFp2ei9O?=
 =?utf-8?B?RDNhZzVHOUJuRkJmQmorT2ZiN0FtSW84b2pyay9yN29TUlZWdE5PMjF2S1h5?=
 =?utf-8?B?STJLQU1jbVcraGdHWVlDa2gxOHdyUWpaS2ZFSVIyTkwzNmxCN2hJMVBUS2t1?=
 =?utf-8?B?SWc9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fda2633-5723-472a-4fc6-08dc734824cc
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 12:28:07.3837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cdDayhYy/f57SqeyzDL8qFbtcOiRItr6oMFSA1B35+94o/qV5CHA6r9FTt9AXV0l3beY231WIknPLmwJfya0jfkxS6ABv8/u/85wxUO1LUM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB8678

On 10/05/2024 11.19, Peng Fan (OSS) wrote:
> 
> Aslo correct the name for fvco and fout clock.

Btw., that part of the commit log is misleading. The patch does no such
thing, as that part is already done in f52f00069888 that went into v6.8.

Please don't mindlessly cherry-pick stuff from the NXP fork and fixup
stuff so it builds and just ignore whether the commit log still makes
sense.

Rasmus


