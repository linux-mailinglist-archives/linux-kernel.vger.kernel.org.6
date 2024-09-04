Return-Path: <linux-kernel+bounces-315242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6778196BFBB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 16:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42EFFB24C0F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 14:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC061DB520;
	Wed,  4 Sep 2024 14:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b="dkZSUBDm"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2099.outbound.protection.outlook.com [40.107.104.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687211DB53F
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 14:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725458987; cv=fail; b=W1ywV5dmhJj8AUEnbgNkAR5QMK8jXmpQ4okXz6enDm+oi/QZSFzCqMlRRNaVHDPq9rc9mGcr8ia3dPF5rmHxXx/qWmfE4WezFlekcCRt/ZDHW7Yuo6cVUiKYHhv4K7jNs9AB5E24/vTnmY4di951wBkjb1OhB5tBjLLWqfa3zDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725458987; c=relaxed/simple;
	bh=bz8t3YJH19mdjZNo4o/2mMutLKoTvfrSLBF1+VICU3Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=F4OfPHbCTMeARmgXjeOwAYENZyQeQc1U92k75xaMGPK4Tr6PhouIjugUTvFzf1ceZQF10RPurbNseLQnZMxL1dmSEy7pJy/8eq7pCFC0vpimmWhGLy8Q0T5ryV8Xigjpj6EYP6rWxOUUgbqz/Ljd37GGeMZ9UwQO3B3kZluOp0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de; spf=pass smtp.mailfrom=kontron.de; dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b=dkZSUBDm; arc=fail smtp.client-ip=40.107.104.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IvuySaiKUXhF9H4EfRSZQXJ42vXZb0aN3ajDwkyHrDkjr+QAB8g0loe4Gk/0M+z23s+nxqyZRyopmKBTRqL3vwAU9xGaaIbSD7lZ3Z9Q7tdIfXmeJMTn6Dw/ARolVShjm9gB4pqPW9JKvYZFq2Oi9rLThFQ3Fxv2wAe/lQwLT8m2GQsCUKy2AJfWHNkDQ+50FVWKC/FitG5/4PwINN3sLpq0P9NTssVf9iH0lsMkALl/V6EGAsuFrO0d2Z/BBi13KO0cZtkMlQJsQYZLazt0/FmIV8hXL5/fZD36iJJk8KM7gJYgbCzZTbV9vVXimUyIrvLvPAGf3W3IcNKjAEpqsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oYkJnduJvkNzFGl30LI8R2L3zbAIi6nC1Ak9jJhX2/E=;
 b=PMEBzgbQgSX3Fw0dHWk6bRa8uEt0Ok65PBtYwcxDwvjrIyn+7nOQHjZZ2UltCP9n3G3iRxBK9RxjoQuxQ3npoBHc2hIg8oOHjDGnwNS2J8zmrpLjnknz3BZCG2MpOKNo1SjRFp4X+YSiKhyf/YKJUEHLCy27qwx7BUEe9XuMEE34rhYFknc2Hb4tSEUP4T93upeSmJ6T4KioiAI41UdIF/x0CN1IsRU1+5zTp4e3ReeyPz6H/AzrmT4RFiX79euioUyq+ehbtRf+qGc3vVqq9agI31wiHN37mJR8XLakmc+eJLB4yQsPe1GzDYa/ZhcOg1p0Cd8GcZNux40SeHT+VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oYkJnduJvkNzFGl30LI8R2L3zbAIi6nC1Ak9jJhX2/E=;
 b=dkZSUBDmbMCex2QLewtrAdYGBCMj1/0J27WZc6hTvV6GXwBuueWCfmqpCxCRo6bQHd3Fz6i0eRHaX4AJHIE2+fxE7tfT+pRjpabkihj1BFjY1y6VyK5GLl99D5cfIpJYEqpU/755xcBaV6oRcdoivK6ymaFxyaw60Qx6AFUrHEU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by DU0PR10MB6726.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:402::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Wed, 4 Sep
 2024 14:09:41 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%7]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 14:09:41 +0000
Message-ID: <a40d8846-6a6b-4da0-b7d0-dbea1fa76c63@kontron.de>
Date: Wed, 4 Sep 2024 16:09:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 3/5] phy: freescale: fsl-samsung-hdmi: Support dynamic
 integer
To: Adam Ford <aford173@gmail.com>
Cc: linux-phy@lists.infradead.org, dominique.martinet@atmark-techno.com,
 linux-imx@nxp.com, festevam@gmail.com, aford@beaconembedded.com,
 Sandor.yu@nxp.com, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Marco Felsch <m.felsch@pengutronix.de>, Lucas Stach
 <l.stach@pengutronix.de>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org
References: <20240904023310.163371-1-aford173@gmail.com>
 <20240904023310.163371-4-aford173@gmail.com>
 <c882eed1-9f36-4382-89fe-f56dd457a45f@kontron.de>
 <CAHCN7xL4WikbY+k+QdBS64-Kt2oHTQU1i_G44PGJDZZKkRaymw@mail.gmail.com>
 <739a8732-532c-4ffc-b3ef-d01793c70d4b@kontron.de>
 <CAHCN7xK+JTE=Xdf3m+xyiJ5sjvN0QrZ-VpNnwrD_3XM+LPMHNg@mail.gmail.com>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <CAHCN7xK+JTE=Xdf3m+xyiJ5sjvN0QrZ-VpNnwrD_3XM+LPMHNg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0141.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::12) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|DU0PR10MB6726:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c794efb-cfe6-48cc-3bfd-08dccceb3831
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WUtYTUJWR3QyVE9XYXhvSUhXMHlXQ2ZubVhPSUpJS0pDeHI1cTN5SzU5bGVY?=
 =?utf-8?B?RldFcExobDNOaUN2RE80M3QwK2hicGsyczlBcElpRC9SVnNxRGRSL0tkWCtP?=
 =?utf-8?B?MFhTd3JFN3Y3WjhzeFJWcXZKbjhrbEVHWFZnaFdDRWpoQThsZ0RHbUplS0tq?=
 =?utf-8?B?WDhoSXlka21VcmVHSDByeTVyRmxYYkFNcjFSem5TendHZ1RnbmxCVkNpeUVn?=
 =?utf-8?B?emp6U1hPZWtpOUVrU1dObTZ2clRIYkJYVnJkRkpadFVLM1p1NXdURVpjTU5D?=
 =?utf-8?B?Znh0SkpjczN0dVVIUWhrTGh5dThNNzNhaVVXSG42bEl3L1BWUkdDanJUanYv?=
 =?utf-8?B?OFdMdUxZb1c2ZUFoZW5vdkRCMkFoMEg3TE1JNm5rblhBUEd6K0lRY2VVOGRz?=
 =?utf-8?B?OGdMYjBvNXZ4K0ZuUlRiVG1tZk8rOUxFTUVlMHdiYUpVWFR6djBtQklhUDVV?=
 =?utf-8?B?NjJYdWo2SWFkV1I2dTZmdnN0emJBS3ZWWk9jOGNzVVU3Wlk1ZmlzdHcxSHVY?=
 =?utf-8?B?VlFxOVc2Y0UzNkEwNmtSU2s1VXBuSUN4QWZYN3hkRU5qWlZIYngzRkgxamdx?=
 =?utf-8?B?Y2pyakxUTXFkeFRQZzdBbE9weFVzOHhGZEhqcDRhaXFkZHR2Wk1pb0RaQm1E?=
 =?utf-8?B?MlErTFVZVm1xcHdsZEQ4KzNzMXNjK290OTNMRHcrSkk0TU9RQ3hlc0czbGlt?=
 =?utf-8?B?N3VKMHJLVW5mbzRQcFZHMFNZRTVzOEQzSXRndU8rTkJCWjhlek80V1ZMSHBZ?=
 =?utf-8?B?Y29BWlBGTVJKKzBMaXZULzZjZktOcC9aTHVMVzExVFRIYzIyS3FJakFHT1Jy?=
 =?utf-8?B?VzBPSmdpcStodkxFVmQvVCtRNTNISEdHekhPZzQreDBtSXY4ZWxIVFBSRWUz?=
 =?utf-8?B?V0JSUDMvSU92ckZJZXU0dFFLSWk3K1NVRmsxeHFaV0d4V2ZPTlZTRDRXbU1o?=
 =?utf-8?B?SEx0WkxUYzR0WkxEblFxc05kNWZiTVJ0dFF6dTF4Wkk2TkdBL2hVcGFaOVVP?=
 =?utf-8?B?djF6WnRaZ1Fsa2U4bHhyYjlPOG04K1lyUUVVcldQbitJUGpZQzVRWCtPdytL?=
 =?utf-8?B?U3N6MzFaZlZJOWlYVjcxeUNjMDlhUjJRUnppK0RNdHZLbThEMXM5NVQ0bVBF?=
 =?utf-8?B?c0U3K3E2SmJzUXNINUlQczAxbnpMT3d1cStablUvVmQ4NFNITGNHTGFxQnJo?=
 =?utf-8?B?K2tSRzRIK0ZUR2IxQWU4NG1wVkVCUjVFMEN4VWROaWo3S1hPTVY3Skw0SXFV?=
 =?utf-8?B?OVkwU3RNVlBlbk95QkVIMHRMOGdoR1NjZ3AxWm14QzNsUitlMHBJK0RYSzgx?=
 =?utf-8?B?UXFmdXdsK2RNVDdaci8rZXlZcjFacSsySEVocStBWlFBZE1kcWU4WkdXY1k3?=
 =?utf-8?B?WGRXbkM2VXhYN3ZtdCt5RE9mTlE3M0U3Mk9kSVVRcndtT3NGMExIeWpycWJC?=
 =?utf-8?B?cnMxalIrUGw4NzJxRjFudHk0VytrY1dBSTZPcVE0ZmEreU5sVzJXUTJRQlJz?=
 =?utf-8?B?NTR5SjhvWjcvQm9oMyt5SDFjYTRvQ1dEQkxqZG5lVTVXTkN4UUxUZThjaDlR?=
 =?utf-8?B?UnV5WE5XU0lleDVJVll3VENLTWIvdmtmejJ0MndUcnlYUXRYaEdXY1kzamJT?=
 =?utf-8?B?NFp5M2VJVERUYUJWY2hQMmQyeWtJTi9rRkdDUjY4K3IyeEpHTEx0M21mZW9u?=
 =?utf-8?B?QWx3aVdPaUh1S0dwTml5L1FNc2ZaWHl5Qi9CZnRPVElxb3hlS1dPSHZVOVJ0?=
 =?utf-8?B?d2FCbzZsSDFNZVhScnYrTm1IeVNuNG9HM1QyMGxVRThNdGp3NjJPc1liWUdV?=
 =?utf-8?B?SnNUZFQ3dDFNMXQvakVvUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z3pXTFk1K0F0a0FyS2k5TXpRRjVtRlB5U1hRaUx1WSsrNThPWHptQVI4ZWpS?=
 =?utf-8?B?NDdTckZ2c3UvY3lLRnVFNS9CVWwzblRSZ2JIc2Jkd0RhUmJYdzJ4b3k4bzcy?=
 =?utf-8?B?YWltQlB1S0JQMTFoZEJvWldzZGJwSllOc1RsajNNM2lXaGVnSnBZSkpOV0dm?=
 =?utf-8?B?dFo2WDc1QlZSNEdQci85YzkzRlMvem1NbStqRVpRb2VyL3UvM05meWlZL3Fk?=
 =?utf-8?B?enAxVzVhenlNZmFoWkVucmNWaFR2SHB4MDBJS0RMNUx4ZEt3T0ZjZFRRYURk?=
 =?utf-8?B?aXVCV2d3RjNQRkp1eE9uMmoyL0dJT0laSENoTldhTThxNkhZQ2ZHSG1aajF0?=
 =?utf-8?B?OEVsdnVPN0c4WHp5NmVsbEd6R2FCVHVsTU9QRXUwdDVVNXZCeWtwOGNlL3pH?=
 =?utf-8?B?dGRHSDJhVFZDWDNoODZ4SDRXS2U1TmZzVTgwRzlPUm5TSFBKK2VjRkRNNWJm?=
 =?utf-8?B?a0tSU0xHTlBlMEd0Tmw0Qml3NzMwYkZSbmVZaXJPbTBSQlRlcVQ4Vys0SXl1?=
 =?utf-8?B?THRpRjN3bzA0UjI3dU9GWjNQRWo5WTdGS3ZVYkF6MUFGWFZvN3Qyc0pvTnJs?=
 =?utf-8?B?TFI1VEJ0akFHQjBVSHhUcmNuMm1IUk5KaWFWTGRKWFg5TUg5aUF6YkROU1BP?=
 =?utf-8?B?S0xBM1pHSGJPRHRlQUJ6V1dRVmFZQ3gyRXpBUVlrNGxYcnB2NjRKOG1zbDls?=
 =?utf-8?B?RWorNnk3aTRQZlBhNXpsVFFTZ21YVnI2NUswSGhnWVBReGJQTVB2LzhId3ZP?=
 =?utf-8?B?ZjZnVHI5N0ptMXZGVk1MYlBEVGJMektXenZpYjI5ZjRyQldpZktGMjlGUGhD?=
 =?utf-8?B?Si8xd29GcXZ6SjRTTVlDZk5DTzdmSEM0b2ZhZ25EeWh4aEZjMHdTYnk0TTQw?=
 =?utf-8?B?QTVvR3E5cjBhSDNsUERQZEp4Ny9UQlJaZVV1NlU5SjZsWTVQWHNrLy9OdWVQ?=
 =?utf-8?B?V1FtWlN2SCtZbmI3RGhwMDJJSm0zNUs5VWhSNi9oOThHYi9XWEx5UTRLRFVP?=
 =?utf-8?B?UUp4Y3N6N3Q4Ni9NVnRTZWp0N0pnLzNiRURlbTFLTW1mR2FPb05adTlkb1VD?=
 =?utf-8?B?eXZsWFJZMEdZY1pubGhSakJBa004RnJkUE9NYlo3cjhLZjJUandlL3JscEY4?=
 =?utf-8?B?bHorTmRoalg3RERrSnU3STBzTjY1cmhCU010b3lEQ3NVTUQ2WFZxQWJFZ25D?=
 =?utf-8?B?UGUwd2hobHZ6cUZoamJMTjNYYWJUWGpYQzVndWRZYlQ1MlRzWkxKZGhmTXFt?=
 =?utf-8?B?QTYwTzlGTXZWamU5NzIvL2RTenFjTmRlMVdyWGJodFNhQlJaTnVHS3VMYnls?=
 =?utf-8?B?eWh4NFZmMXZWNEFaM280VjNYYVVqenZtc3BTb0paY3cxTFIwRVkvODhkejlM?=
 =?utf-8?B?dzVzRE1tMFRDc3A4QzlRY0NoeWdIRk9tMFVhUVFyR01GRU5icnBHbGExQ2M1?=
 =?utf-8?B?MVNUcGF0bW5QYk5YSW5KY21aN2I0RVQrclpHcGY2SFgzcE9CR0loRGRiUVRB?=
 =?utf-8?B?SlYzY1p3MXhjcVZ4UFpQZEdqaUErNERJaUdZZkVFS0F1Ti9OZlV3WFZUTW90?=
 =?utf-8?B?cGpzcWxMM2FHZEpEWXMwNGZvUkloUlg4R2tSejZxTnF6Tm5XN0xQeThTc0lK?=
 =?utf-8?B?OEFicVoxL3FiU01mMnNHZ1hpb2NocXRrdzFGV1dXay9NSjdseE1oeDZwSnZ6?=
 =?utf-8?B?R2FabnlsZFE5MTVLeUZCQzFNamdSNzVOVit5YVo0RUdvRVA2cmYrK3pkelRw?=
 =?utf-8?B?cjFGNjFlZmpDNGNmdGREVmRteEFBeUdyYTVDMG9XeEoyejNMVTl6bFI4SDNr?=
 =?utf-8?B?ZWZFcG5hazM1OXpYOHZzM1lHcXdaa2p6SkpkT0U0Zytkd1QwQUZ3MUNwQm0y?=
 =?utf-8?B?dXFremJMNWRjTkVoTVQ1WkNISmh0d0Jub3VyODBmWUpJZElKNDcxWWpNTkNo?=
 =?utf-8?B?NlZsU3RKNUNoU0JrRXdIR1lOWEtJRVBEUUFlSGRYZFh4b0dVR2FHa0N4QlJL?=
 =?utf-8?B?OHBVN0tkSnlpdktUUkRKaExQNHc1VFFVN05USUFvZjZxMk9aa2xJY3BRanBX?=
 =?utf-8?B?cTAxWVZGUlhsZEM5eDFHdnN5elljMXhaSHZ2QUVqT1lLaUU0ZUdCT2FENFBs?=
 =?utf-8?B?NlM5dm5Md1RmRExoMnVIOGNDZlRIOEpXbDk5akp4NTdEVVZZTDZ0cElPbFpI?=
 =?utf-8?B?SFE9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c794efb-cfe6-48cc-3bfd-08dccceb3831
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 14:09:41.2815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MWAeF0PZCQXObAKIjwANnMBfjhXLWh35xvGps5s1BbCcdvab3trK8safVhKtjHcilE63xpVkWnVh92YJJtfNb54L2ZqpDrLNDC3r7IBYR7k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6726

On 04.09.24 4:05 PM, Adam Ford wrote:
> On Wed, Sep 4, 2024 at 9:00 AM Frieder Schrempf
> <frieder.schrempf@kontron.de> wrote:
>>
>> On 04.09.24 3:52 PM, Adam Ford wrote:
>>> On Wed, Sep 4, 2024 at 8:35 AM Frieder Schrempf
>>> <frieder.schrempf@kontron.de> wrote:
>>>>
>>>> On 04.09.24 4:32 AM, Adam Ford wrote:
>>>>> There is currently a look-up table for a variety of resolutions.
>>>>> Since the phy has the ability to dynamically calculate the values
>>>>> necessary to use the intger divider which should allow more
>>>>
>>>>                        ^ integer
>>>>
>>>>> resolutions without having to update the look-up-table.
>>>>>
>>>>> If the lookup table cannot find an exact match, fall back to the
>>>>> dynamic calculator of the integer divider.
>>>>
>>>> Nitpick: You have thre different versions of how to spell "lookup table"
>>>> in the paragraphs above. Maybe you can decide on one... ;)
>>>>
>>>>>
>>>>> Previously, the value of P was hard-coded to 1, this required an
>>>>> update to the phy_pll_cfg table to add in the extra value into the
>>>>> table, so if the value of P is calculated to be something else
>>>>> by the PMS calculator, the calculated_phy_pll_cfg structure
>>>>> can be used instead without having to keep track of which method
>>>>> was used.
>>>>>
>>>>> Signed-off-by: Adam Ford <aford173@gmail.com>
>>>>
>>>> The comments I have are only nitpicks and the patch seems to work fine
>>>> for me. So feel free to add:
>>>>
>>>> Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
>>>> Tested-by: Frieder Schrempf <frieder.schrempf@kontron.de>
>>>>
>>>>> ---
>>>>> V5:  No Change
>>>>> V4:  No Change
>>>>> V3:  Change size of pll_div_regs to include PHY_REG01 (P)
>>>>>      Create calculated_phy_pll_cfg to containe the values
>>>>>      Eliminate the PMS calculation from fsl_samsung_hdmi_phy_configure
>>>>>      Make the LUT primary and fall back to integer calculator in
>>>>>      phy_clk_round_rate.
>>>>>      Check the range right away to ensure it's reaonsable rather than
>>>>>      trying to find a clock only to learn it's outside the range.
>>>>>      Overall added notes and comments where stuff may not be intuitive.
>>>>>
>>>>> V2:  Update phy_clk_round_rate and phy_clk_set_rate to both support
>>>>>      the integer clock PMS calculator.
>>>>> ---
>>>>>  drivers/phy/freescale/phy-fsl-samsung-hdmi.c | 341 +++++++++++++------
>>>>>  1 file changed, 235 insertions(+), 106 deletions(-)
>>>>>
>>>>> diff --git a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
>>>>> index 4f6874226f9a..8f2c0082aa12 100644
>>>>> --- a/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
>>>>> +++ b/drivers/phy/freescale/phy-fsl-samsung-hdmi.c
>>>>> @@ -16,6 +16,8 @@
>>>>>
>>>>>  #define PHY_REG(reg)         (reg * 4)
>>>>>
>>>>> +#define REG01_PMS_P_MASK     GENMASK(3, 0)
>>>>> +#define REG03_PMS_S_MASK     GENMASK(7, 4)
>>>>>  #define REG12_CK_DIV_MASK    GENMASK(5, 4)
>>>>>
>>>>>  #define REG13_TG_CODE_LOW_MASK       GENMASK(7, 0)
>>>>> @@ -38,281 +40,296 @@
>>>>>  #define REG34_PLL_LOCK               BIT(6)
>>>>>  #define REG34_PHY_CLK_READY  BIT(5)
>>>>>
>>>>> -#define PHY_PLL_DIV_REGS_NUM 6
>>>>> +#ifndef MHZ
>>>>> +#define MHZ  (1000UL * 1000UL)
>>>>> +#endif
>>>>> +
>>>>> +#define PHY_PLL_DIV_REGS_NUM 7
>>>>>
>>>>>  struct phy_config {
>>>>>       u32     pixclk;
>>>>>       u8      pll_div_regs[PHY_PLL_DIV_REGS_NUM];
>>>>>  };
>>>>>
>>>>> +/*
>>>>> + * The calculated_phy_pll_cfg only handles integer divider for PMS only,
>>>>
>>>> Nitpick: Remove duplicate 'only'
>>>>
>>>>> + * meaning the last four entries will be fixed, but the first three will
>>>>> + * be calculated by the PMS calculator
>>>>
>>>> Nitpick: Period at the end of the sentence
>>>
>>>
>>> Good catch.  I ran these through checkpatch, but I need to tell myself
>>> not do work on this stuff at night when I am tired.
>>> Sorry about that.  My grammar isn't normally this bad.  :-)
>>
>> I know. I already assumed that you were tired as the commit messages get
>> worse towards the end of the series ;)
> 
> I do this stuff as a hobby at night after my day-job is done, so my
> brain is somewhat shot.  Most of the actual work that I do for this is
> done on weekends in the morning when I am fresh, but I do the cleanup
> at night.  I should probably reevaluate that decision.  :-)
> 
> Thanks for the understanding.  :-)

No worries. You are doing great work. You have my full understanding for
any of such flaws. :)

[...]
>>>>> +                      */
>>>>> +                     tmp = (u64)_m * 24 * MHZ;
>>>>> +                     do_div(tmp, _p);
>>>>> +                     if (tmp < 750 * MHZ ||
>>>>> +                         tmp > 3000 * MHZ)
>>>>> +                             continue;
>>>>> +
>>>>> +                     tmp = (u64)_m * 24 * MHZ;
>>>>> +                     do_div(tmp, _p * _s);
>>>>
>>>> tmp already contains (_m * f_ref) / _p, so we sould be able to reuse
>>>> that value here and simply do do_div(tmp, _s) without recalculating tmp, no?
>>
>> Any reply to this comment? Can this be optimized?
> 
> I was going to investigate it before agreeing to do it. On the
> surface, it makes sense.

Great, I just thought you may have missed it. Thanks!

[...]

