Return-Path: <linux-kernel+bounces-204915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C79718FF4F2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 20:49:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFAE31C283C6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 18:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF3E1990C4;
	Thu,  6 Jun 2024 18:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TGJrilru"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2048.outbound.protection.outlook.com [40.107.21.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BEB197A6E;
	Thu,  6 Jun 2024 18:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717699662; cv=fail; b=Kn2Devn1IE/5tpojZRO0Gu9XfpAkjEgh82nWU0DeiqBChKOK9bXfR9T7XCaeVvvux3T7QKIIJH4XnUlAmke/CXVxwCoe6qBdX4f87BOw4GI5FcrahUWauxPK05aJY41MC98G4+2qiRI8LlPj72Tm228H3DzJsrutIvwtPMOYiCs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717699662; c=relaxed/simple;
	bh=V3aSz9OakazJIsc+Ir1XSAlA2aVt7bvWPkO3FQk4jxc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=dBj8IeeQc3BH6gnXO4Awvjj2VbP9BJZiN/skLIRd9y3ipdfY9dc/yAN/MP56bv9KKeoifcv1e5gFmgjopol/pDvUGQ/Zi/FcjAEBTBCpgptbkTRW2j4hrTgiDsmOoS24WI0n9cUouFRdcd494vtoNx5T5wh5IEcwW847lREgENY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=TGJrilru; arc=fail smtp.client-ip=40.107.21.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D5XoZKi79zjQht7nHCra1v5aT82o9uHmKeRF84OqR5t0IEME/890/aRn2o5Z9dANfyrI6dLM1kKx49A1PIEE7EZMuq3BIAZEzBFm7RwABQ2najSOlA2936Enhil0FdJtwemV6/Fc3jJMCuyzhhgwLrQMBvP3A21ru2ROPA2U0uLm4CcjnFnZnSB3V5DBBsoH7Lp3OYVsDagSNmRvvRhX9HUBd2Ska6zCognIE6qqJN8fugKMievqh7p+ccydzOs00KF3xrdJEayTFBLVEwdCtPdycLPTiPKYzwywckWlW9OoqBmsypPYbt6aHRdTvxxS/GJezGHmUNNiKKoP2qWusQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gMiZVQ5uikdAZbdSJmQz0HHKZZOr++Izx2iEEvyXRPs=;
 b=RquiDWDIN2ZXaSHX+rbugr15NCapiG1Y3dULAIT9wr4pdfewni9/XHM4cZ+/vDN7DSVAOiGH5L4CqvRKoaUhxt2sLVzq2Er3ZCD7j6uuG2rDC4aUWGarj9ZU+By6ajE4ZEImPErYUMu1Q9h3OHYXId15OuwiZfZ7STuivwdVBeFe1HM4tepMxcq4I715uo+Bc24UiHXOlerfPVTTWj7RjASGaOE/ZujliLm0UoGtYouTJMluoQlW48kiGAfwimT642/dgS8JUczIJsUjndFdLIkzKQkDBNf0yVRxrebmz2ie8pWA/yJg01iGptKdBwXp6gk5+DhKHLP+5B7YQEtlVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gMiZVQ5uikdAZbdSJmQz0HHKZZOr++Izx2iEEvyXRPs=;
 b=TGJrilruKYNfbGKx30xntyvqilu86OVMZI61R6goAcjMmQfTz3hZXh/DrCbhDRaXA9qGMz51jRbPwONKXEr8k8EZ5gvuT9GIY+lLSJieWOqwXXbQRTmfhXWPS+qrWTJcYM0MM601Om9sOIrl8dGu4jcSsoWe5IVn6JYxC/9z8oM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI0PR04MB11069.eurprd04.prod.outlook.com (2603:10a6:800:266::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Thu, 6 Jun
 2024 18:47:39 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7633.021; Thu, 6 Jun 2024
 18:47:39 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 06 Jun 2024 14:47:01 -0400
Subject: [PATCH 7/7] arm64: dts: imx8qm-mek: add usb 3.0 and related type C
 nodes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240606-imx8qm-dts-usb-v1-7-565721b64f25@nxp.com>
References: <20240606-imx8qm-dts-usb-v1-0-565721b64f25@nxp.com>
In-Reply-To: <20240606-imx8qm-dts-usb-v1-0-565721b64f25@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Dong Aisheng <aisheng.dong@nxp.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717699632; l=3008;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=V3aSz9OakazJIsc+Ir1XSAlA2aVt7bvWPkO3FQk4jxc=;
 b=a9hLZiTOJPt042ES1ZhCz5aBb52fNeB7ePrRoFwS5LPy6kBRGSk+Kc8hEWIaZ9GA3jcSgqILN
 HcmGOb4IuUhCtNPSWWqG6/ca840KNrVIiTJkcKBZi74oR7IHUJCXxny
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0178.namprd05.prod.outlook.com
 (2603:10b6:a03:339::33) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI0PR04MB11069:EE_
X-MS-Office365-Filtering-Correlation-Id: 2665ee50-34f9-4258-22d3-08dc865923d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|376005|1800799015|7416005|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VlpLb2hhdW5ZdDUvU3VseTVSaTZlZ1I5aFhmQlA2bEVGaTNXSWVEc052eWNH?=
 =?utf-8?B?V0RTZVc2VFZDa2NaMXpzM0R1M2Z0c2Fpa1dzZzMyTkdRWEpXSEtqRUdwdTRm?=
 =?utf-8?B?K1cxdldLU3Z0NGRNS1RqcHFqN2RNNEdEcElNZWs4SW5RL1Q3SVRWcWpPU0pm?=
 =?utf-8?B?bm0xWHc5WDEyZGNuWTB1NFhidEhMTXAvVWlyVXg3UTdEcEtwN3lnN3pyc1hz?=
 =?utf-8?B?OUsvMzBhQzRrWUZ2T1NYVnJtWWFGclk1cmZHYlY5dWM5b0UwYnZaZjRJeGFF?=
 =?utf-8?B?WnJMV3pNSzNyQmo4WE5EUlhrd0dTY2x5NEI2QWticnF3VzJnazduYmRNQ2I3?=
 =?utf-8?B?ME5ua1UrRG9ibFJLRWZGKytHQ2paYkRTMU5Vb2FnY2hLamx5bllXOVZsek1P?=
 =?utf-8?B?cE0rUkdWOGNMREJoMkZrQW1VcGV0TEtLWmVUNGJ5RzNRc3AxWDlJSlBCWStW?=
 =?utf-8?B?d0lybWNDbFRPTDRoSDFVVFhZNmpGOHFVYU9wbGJFdk1wdGRhaE5vM21NYzBY?=
 =?utf-8?B?Zk1kZU54Vk9lWTlscUh3Rnd4ZjQ3U1U3QXZkM2ltSEtMT3d3Y3VCM1czUlBs?=
 =?utf-8?B?amRMdTFRR0dBQk5ZV3Zjb054NjVseHg1V2lBMlpSUEtRYmNiYkxCUkxKb1FF?=
 =?utf-8?B?L3RBditLbzFId1c3RisvZm03MTlzK01GZmpTS09ENDNZeU1SODNBZDRIUHlI?=
 =?utf-8?B?MHRuQXI4eEZDREhNSUZ3OHpxdVd2bG5uam9aa05CdEE3cDJTUitJbzJISmM3?=
 =?utf-8?B?V3h6ckNZOVhvZERPblk4VTdKVkZSdnlldjZhaFRnT0lTc09acGgyckl1U2Z3?=
 =?utf-8?B?ODNGTmNwV2N5d2RaOGNLRFJuYldmZVIxMlZqcTRWNytaeWlLOU5yMXJUU1VM?=
 =?utf-8?B?dkhOS1Z1TDVFNm5sSDdTVURZd3JaOVlQRE1DOWpyR3pxV2JpdTIvVUNpN3Iz?=
 =?utf-8?B?RTVob2o2ZDBia1N1Q2czeGp1WndJeG9VblV4aHNuYjZ6NjNvd3J3c2cyZFpo?=
 =?utf-8?B?c3FwdGNpTmpRQXNPODlUZmFoelowYnpnSnY0MTNwYXRGRW5LS2h6eXp4SVV2?=
 =?utf-8?B?bDh2M0duR2lDVHVVbytqay9iaFNZa1Y5c2IyUXl2V29oME4vMFZoVXBLb2Vt?=
 =?utf-8?B?ZUZWU2JmRHp6akV5RHhQTE43VkhJYTVJZGc5YnJWOU9wREx4WUFzRUV6TVpi?=
 =?utf-8?B?VVlTTUlLWVpobno0UThxLzh6bXkrK0hnYlpFcVVGTitiQzkybk42WStuOVNr?=
 =?utf-8?B?SUhXS1hKTVpzU3ZDRWxUbTkzSDExOW9xVi9Fb094am1iR0Mva05MTWJnNGp1?=
 =?utf-8?B?cHlFWXMyalZNekFlWERBOThsY2xycnU3aW93TGZCQ2I3NSthWVdPYlI4NWQv?=
 =?utf-8?B?OTVIVlBVZmNWWEI3VkRkWEV3MWlMSVFqSElXaVB6TjEya2lYK25uNlJzbnEx?=
 =?utf-8?B?MGE0UVVMeEs5WGJibmVKaGRlYXB0NzROZ3JkbFdLUTBQUnNTVFREay9lV2R3?=
 =?utf-8?B?RHVjQzdFNHRPWkRzVkFtd05QTlYwVnBNajYvaUlvN1dEblR1ZHFxVm9sbXJz?=
 =?utf-8?B?TlpLejBLOEFmS0xJZDdTR3phYnNTcXprNENxZkMyMEQvVHBYY2N6N0dsK1k3?=
 =?utf-8?B?L2xNTVI3Smk3N3ptbWsvWTVTNUpRazdITHoxYXF1MytORnV3dkpZSUJpV0kx?=
 =?utf-8?B?UFNlNjNEU3V2SnRTcVowUFdIUVV0a2FKZENWMnYvMENyVll2WkRWdWtDNjlK?=
 =?utf-8?B?cmN1bW9tZXRtcG9mbTg2VnZBSXJKSExGNlRqV2VKVFFncy9tUkNyeGY0NitB?=
 =?utf-8?Q?ca0cm9EqTZi7m2xXMZq4WZDKGX5GDSo0sAjhM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(376005)(1800799015)(7416005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VjEwbm9qSmh2M3ZXTG5uUVNiUXhKVERVbis2Z1djejJPYW9FNlZqQ2VtRUVQ?=
 =?utf-8?B?bFpaVlkxMzBUNXZJU0YxQXpZMHdsRTcxK3RxZVAzb0tyQlNrMlpTTU9hVnlW?=
 =?utf-8?B?YllEOEtqZnRIa0ZnK214MW96TGZSMStFa0todjJYdmVWVzRFSlVZRlp6WFBP?=
 =?utf-8?B?NmRFakFGNU9WaTRoemFYOEJGcE1NWkRYaTBXOGhnSXhCbWNXbGdxY285RERq?=
 =?utf-8?B?cUkzZWV0UlovUXBrMnBpWnNNZnpPeExBY2RVS09nanhBSkxMVUlIeEZDc1Ux?=
 =?utf-8?B?cG53SzQ4cWMvK0F0NVFGQmNFU05WOE1tSVBhR0d4NXNVSU1KaERHZHZjZElt?=
 =?utf-8?B?Z3FPbG9NeGI1cnV4cmxobXE5K0hxZVlsZmh6blBjZ2pCc2pzQU5ZM1o5Z056?=
 =?utf-8?B?SlpTVXBJc1ZwWXU0VnRwK1pZN2F2ZEJpaXEyTTBiNjR0VTF0QmlpQ0tDb2lF?=
 =?utf-8?B?KzkvaEl4Zk12dVZXSHM4ZXdNMXFkOVVjN1Badm1HTnVqWmhoNWgzekJ1WnBS?=
 =?utf-8?B?aFAxSXRDVXprdFBpU2xlQkFNTWtVVDU1ajJ6L1ZWZWhzS2h1b0ZIdUl0NVcx?=
 =?utf-8?B?YTdCc2xDZjdUMkViYW9sK2x0RHB5bkdEWm9hTm1UTk13ZFhpa0E4Q0dlU0NJ?=
 =?utf-8?B?Z3V3OFNHZWFETGx1a21yN3RtOXd1bFRpWFkzSXVNR21udUlYbWV4TnUrMkt4?=
 =?utf-8?B?eVR4YUZqTkNRV284b2loZnNQTVRhRHZmSTY1d3lTMTJPcWxuRDBkZVlNaEl3?=
 =?utf-8?B?OWRGOXBYUU12Vy9WS0NRVXZhMmtIVzBCd2FPWXJnRWZCOHdNVDJRbFZWRWtw?=
 =?utf-8?B?djRyRnBUUURHSFp4UndPZlRnUlFmZmd4TDZ2MW9Ud1ZiNVRucDVCQXVyc0lW?=
 =?utf-8?B?bFZjNU5rcU43T2JnemI5UHNpaGlkYUM3VVp5V3djZHhMRGhDTnZHWUVSRDgv?=
 =?utf-8?B?UjRFYkpQdFFOSFcyazNrVFlJOUp2dWFFanYzSjluZ0RXZXQ2TUVydTBXR2tp?=
 =?utf-8?B?ZlhlWktrNDE2eG45Ni9iUVdEQTh5aWpudDN1WWlvTjVucDVNdTRpa2V3OEt3?=
 =?utf-8?B?R0NiSTdaaXVIcFV6bUhVVWxQMU1wemRidWFWbkFneW5UcTJpQ2E5WUcvVkFs?=
 =?utf-8?B?ZmxQWmM3UlE4ektTTDg1eFN2dGhPdVJqc0dTOXp3Q2IwZFhKZDNkN2VONDY1?=
 =?utf-8?B?V2Z4RXJyaVYwazFNWFNIQkhTRHpsSGttWmhGaTdmTVdSN21rSy9DWXUxMGkv?=
 =?utf-8?B?bjhKUlR1b1BqZW9STk5vbjNONEdlVlBnbWt5TCtWMncrVE9XaEg5KzllSGdP?=
 =?utf-8?B?ZllwRm9NVk9tR1FhM3Q0eFcyankwdGZLbExNVTh1cjlaUDNLYkJSM0VNV0tR?=
 =?utf-8?B?TmloMWlzRHNERzg4bUkvZm9QbE1pa1pFVTdoWm02N3djZ1o1emtScW1QQkFB?=
 =?utf-8?B?SjNhNXJKQm1OdTRzbzdZR0VkcXVGOW56TjYzTGpYT0x2MEZtbTVDUld4VE94?=
 =?utf-8?B?M3kreEhlZ3drbnRQTndteE9XcG0wZGFGTU04SlI2VnlLTmNibFRjTERsSkl6?=
 =?utf-8?B?RGFMODI0QzU5WkowRFhtd2RXTzNZcHNHU0VUL0t5Y0ZaanE2djZBMVpIT0Ja?=
 =?utf-8?B?TTlaYUYrUW9GU0J4SEVaNWlyVlZ5TmlpYXlLZU16TUR1aWxON1Bhd1pBb1hC?=
 =?utf-8?B?dGk2Y2dqa1JIc3VKaG0ybkxvTk9ma0ozT3B2eks4ZnkwV1VETWFQcXJaL0hH?=
 =?utf-8?B?bFdGVnF3NlI2RlBUb3J4bDBlNnpDSEVQZ3U2RVNhTEhUa1RBZWhWeWdnMU5Y?=
 =?utf-8?B?R1RFS2ozNW55c1hiemQ3azA3Zk1MS0F6ZzNtUHhKWFRuYmtSaG5xeVR5M0pm?=
 =?utf-8?B?aXYrNU1KWjNxQ3dvRjJhVWVXN1RsUkxaUTFOejNtc1ZlMkVHcWd3VFd0Ujhj?=
 =?utf-8?B?NkRESUErTUdzMHFnWmswZDN3ZFRHa014bTl3K28zdTFjQi82dGYyaUFYVGpi?=
 =?utf-8?B?Wndvd2N2SEFqY0llYVdua2VtNHFWOHhpV2xmN3hRWUQ5cXNMeVRoVmgxN3BR?=
 =?utf-8?B?SmJlVjdIMkhMdEtDUEpFSzJZZk5hTkhCM2dwT3owK294Q2ZwZEQyOWdYSjk5?=
 =?utf-8?Q?Vet5Af8gWnXUPFIXqXxeKlr9G?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2665ee50-34f9-4258-22d3-08dc865923d0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 18:47:39.1722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IjrRZMX+Zd6axMTUrgtooZOliSe/oVWhdUol35VIXWOI5Oj0jITzFUn3VhaYMeNv7llRLFzsmgKv63hRiVwCbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11069

Enable usb3.0 and related usb type C nodes.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts | 87 ++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
index dedcc1b1bf12f..f6e2f1573f6ab 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
@@ -7,6 +7,7 @@
 /dts-v1/;
 
 #include "imx8qm.dtsi"
+#include "dt-bindings/usb/pd.h"
 
 / {
 	model = "Freescale i.MX8QM MEK";
@@ -129,6 +130,21 @@ lvds_backlight1: backlight-lvds1 {
 		default-brightness-level = <80>;
 	};
 
+	gpio-sbu-mux {
+		compatible = "nxp,cbdtu02043", "gpio-sbu-mux";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_typec_mux>;
+		select-gpios = <&lsio_gpio4 6 GPIO_ACTIVE_LOW>;
+		enable-gpios = <&lsio_gpio4 19 GPIO_ACTIVE_HIGH>;
+		orientation-switch;
+
+		port {
+			usb3_data_ss: endpoint {
+				remote-endpoint = <&typec_con_ss>;
+			};
+		};
+	};
+
 	reg_usdhc2_vmmc: usdhc2-vmmc {
 		compatible = "regulator-fixed";
 		regulator-name = "SD1_SPWR";
@@ -341,6 +357,44 @@ gyrometer@69 {
 		compatible = "st,l3g4200d-gyro";
 		reg = <0x69>;
 	};
+
+	ptn5110: tcpc@51 {
+		compatible = "nxp,ptn5110", "tcpci";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_typec>;
+		reg = <0x51>;
+		interrupt-parent = <&lsio_gpio4>;
+		interrupts = <26 IRQ_TYPE_LEVEL_LOW>;
+		status = "okay";
+
+		usb_con1: connector {
+			compatible = "usb-c-connector";
+			label = "USB-C";
+			power-role = "source";
+			data-role = "dual";
+			source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					typec_dr_sw: endpoint {
+						remote-endpoint = <&usb3_drd_sw>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+					typec_con_ss: endpoint {
+						remote-endpoint = <&usb3_data_ss>;
+					};
+				};
+			};
+		};
+	};
 };
 
 &i2c1 {
@@ -553,6 +607,26 @@ &usdhc2 {
 	status = "okay";
 };
 
+&usb3_phy {
+	status = "okay";
+};
+
+&usbotg3 {
+	status = "okay";
+};
+
+&usbotg3_cdns3 {
+	dr_mode = "otg";
+	usb-role-switch;
+	status = "okay";
+
+	port {
+		usb3_drd_sw: endpoint {
+			remote-endpoint = <&typec_dr_sw>;
+		};
+	};
+};
+
 &sai0 {
 	#sound-dai-cells = <0>;
 	assigned-clocks = <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_PLL>,
@@ -819,6 +893,19 @@ IMX8QM_SAI1_TXC_AUD_SAI1_TXC				0x06000040
 		>;
 	};
 
+	pinctrl_typec: typecgrp {
+		fsl,pins = <
+			IMX8QM_QSPI1A_DATA0_LSIO_GPIO4_IO26		0x00000021
+		>;
+	};
+
+	pinctrl_typec_mux: typecmuxgrp {
+		fsl,pins = <
+			IMX8QM_QSPI1A_SS0_B_LSIO_GPIO4_IO19		0x60
+			IMX8QM_USB_SS3_TC3_LSIO_GPIO4_IO06		0x60
+		>;
+	};
+
 	pinctrl_usdhc1: usdhc1grp {
 		fsl,pins = <
 			IMX8QM_EMMC0_CLK_CONN_EMMC0_CLK				0x06000041

-- 
2.34.1


