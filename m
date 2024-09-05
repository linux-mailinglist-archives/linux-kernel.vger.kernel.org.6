Return-Path: <linux-kernel+bounces-316528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7484896D0BE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 09:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99B3A1C22920
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 07:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A52F1940A9;
	Thu,  5 Sep 2024 07:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b="iAluDvJd"
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2120.outbound.protection.outlook.com [40.107.103.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7749A193070
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 07:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725522575; cv=fail; b=Mq5QLxS4fq7+6ZYrrO5T8BMidIJrWK0+ARijSXDDV6qAgvTEd388SvsSM6MU2z4/Wd9WowGvBwyFbA2Nj9EvoHXgMaMXwSNQA8jV4t9rkwIMyp924yk8v/2iyOMVxYJ7BcBlEaCFev1/dK1NUK9kGB48Yy5RYfl/ZVBkfhh+Jsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725522575; c=relaxed/simple;
	bh=2wbPUP/2dISQqhwiGsjn0qTG/Hh5ki/tIQ9SUG2hmBk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bF2IxAE8hUaKabeal+ObrEQD+TT+xJv4mDCGy5PHaX2CICSgu5d5vQXS1WrGW0zz5GqXjLIRq5EPXJySaPDULAVN3g0DqRuU/35AdAIKD/ZLRH3N8aiceu+GyTAjdOFke9wj2KMWXLHbbScm7MwThaaYFRpGzgheaEcF6DPz1+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de; spf=pass smtp.mailfrom=kontron.de; dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b=iAluDvJd; arc=fail smtp.client-ip=40.107.103.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PkI+1ZhHnhqi0TEJYZ7IzIX9ekX7dyVSMNHx6cJR/SlWl/szp6i10MWGPM18NRbUzQYIamebQJVBMlykZc+LyItbKfGYFgFZqCGxShJhODi6GHVzBoLpHav8vCj5hMm0LsPdYewDsFoWoBTvFBkG2V+SZRfOpauiJ9Gwnm0qOyz8u/mxzkFAtYiUn6SiaVFG4c/WJn9/PKhhO86XJ6XXb/u239W35OApUytSPyl73evz46ySKanf/a+mFx7ZBFBKktAxgEbIOBRIFcDRkrnT1OKVSUSgGKylKkjy+4nR2T00ooWEFkp6+UOuSzv+731eTUp/LR/RsKt2FWgVp5Lzdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CBbmO4N7lNSbYNhJfWy3Ljx3gyhMHljRfVAhoOk9CWQ=;
 b=ZzQi49AYIFFLfw6KH0V8FyJ6ReEulmMUnBMlxqRhXVLB4nAGKYRDj1Snfei04jihCNyEWSGB2mvIm8aPuQ2MlINZyKDBaPs7BE89vG5k3CxuEXwqtqCUan8zGMj86cintNuxFyYeJdGIoG61HD5PHI+ewFur+wpV70agSszYuSdSJOrmghU0k2zHA+i2qthlPUYmYTaO13YFKftnXfppKjLkvFsDIR8F1omSy1VogYcuBA/S28HKT3SM9tM2saVD1AZh5FeoZtyNjfFj7QhvBAjFT9ycm6vLD7sPQhX52dZGohPMjuFew+hFCr3d9iCndoF7ckWbnsnofqrYOX3u6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CBbmO4N7lNSbYNhJfWy3Ljx3gyhMHljRfVAhoOk9CWQ=;
 b=iAluDvJd3imoV9lo/h49qui472yCi233ARfEU2EFkKxWKw5fRLcILpgsJVgqFUD/s0DX2x/e/L/Mcxd4hEKERBnciEhImWKcnOpyDnxEYzyKABSvjpTDhfsWG/mnbu+rCE7gUaVfhP6Dh8spdPj6GznrkSmNj+R1ZYgSSS3ylTA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by AS4PR10MB5720.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4f6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Thu, 5 Sep
 2024 07:49:30 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%7]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 07:49:30 +0000
Message-ID: <0f9c3794-6bb4-41fa-8bc6-c00ecaf506a1@kontron.de>
Date: Thu, 5 Sep 2024 09:49:29 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6 0/5] phy: freescale: fsl-samsung-hdmi: Expand phy clock
 options
To: Adam Ford <aford173@gmail.com>, linux-phy@lists.infradead.org
Cc: dominique.martinet@atmark-techno.com, linux-imx@nxp.com,
 festevam@gmail.com, aford@beaconembedded.com, Sandor.yu@nxp.com,
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Marco Felsch <m.felsch@pengutronix.de>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Lucas Stach <l.stach@pengutronix.de>, linux-kernel@vger.kernel.org
References: <20240904233100.114611-1-aford173@gmail.com>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20240904233100.114611-1-aford173@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0416.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::19) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|AS4PR10MB5720:EE_
X-MS-Office365-Filtering-Correlation-Id: 17e25ef3-45f6-4951-a6b1-08dccd7f4634
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YXpUSDVBeWFtcGh2UmFOL1Vjb2QwZ0pKa3F4TTgrazJsYVFneGFBbkVza0g3?=
 =?utf-8?B?RG52L2FmUEI4dWtjVC9LSFd2Y0Jib0lYMytoREh3RXBZNWNlbnFndXBoak9v?=
 =?utf-8?B?VmtpNzJWbGZMemVUSFNuWjBhcjJGY29UZHI5SjltdlBIRXJ5dVNkYmQvTisy?=
 =?utf-8?B?OGk2QWFaTnpreG5JRGVIR1RoMHlKd3lkUkJ3cEtkVEhBSzJpZklZUWoybE9F?=
 =?utf-8?B?eDUzMFNPTWZtK2dpL29ON29wWmphd2Zad0FkbzI0SERlOUh2WldsMEJBZUlr?=
 =?utf-8?B?dUM5SEh2b01MSnhaKzVDdHNzYTlwTGxnY0lscFlPeURnZnJPWGZ3V2d2MEpi?=
 =?utf-8?B?WVpBUXZGN3N6bkRhZHI3RVFaSit3UHVOOHlONnRwTWRMcHlWRXNTM0JTTFVO?=
 =?utf-8?B?aW4xdXNuQXBkR1VzRjNtNU5HYkV3dlBRZU5uSmpGbzU2NVdhVzlzeWovV282?=
 =?utf-8?B?RXBrd1d0RG1Tem9sVlpCdmJqL21GTmpGby9NS0lGeE1udDE3R3NmaXMrV1NG?=
 =?utf-8?B?MldkdU9RelB0ZkNKbGtkNytIODUzK0ZmMjFTU2ZaczBjcnZDKy9zN0RjS0l5?=
 =?utf-8?B?cEJlbEJnNUJkWnpzdEgxMkVhTHAwNHU4Zk5Kb1dzbnVCMUpWZWFoVHlBZnBS?=
 =?utf-8?B?c20vN1ZybmNWb0d2bnZVODhJSm5mMTJYakFUTXd4d3A2Wm1jTHNoWVJ5Mm42?=
 =?utf-8?B?d01XUndOYjFjQTZXaE5CNXdDVlJPcDl4UTVBaEpFdDhuNzNnWUEzYUcwblFS?=
 =?utf-8?B?bTFqZi96R0orTUhHWHhmWFRPWGhoYTlxTTJWa1NmOEdaZ2RoM05Bc0kxTE1F?=
 =?utf-8?B?SUI4RmVoelhuNnQ4aXNQMzVHdUh6K1dPTytCVEFvNk1XRHlkalBOb0VUQzNx?=
 =?utf-8?B?cU4vMVJjOTAyTEN1ejN1Um1ZZW5MalJ3MzRLSGxOaGR5ZU1sNmRWbGJVZDRQ?=
 =?utf-8?B?OWpNcXRXRlF0ZXNTVXViTzZyTzBjQTJ1bSsyRWlDZzFWYXVBVWRFUFplak9v?=
 =?utf-8?B?eUU1Tkh3NXJ0ZWZCdjBhZ1I3L2FDRGo1ZDFEUnVVTUtXSjFKSElza3VOU2Jx?=
 =?utf-8?B?SThqa1QzK3B3V1BmL1daUVY0ZFBNSHpCYlEwclFSOXdpYzdQbHhwTno3SUFP?=
 =?utf-8?B?ZnJGZzZsL295cW9kbGtNUnBoOUt0cklOUkNQOC9zYlF6cml4TWQ1KzZCektG?=
 =?utf-8?B?RWVFek1tNmhRRmhlOStTazBON1lJUTZ2UjhkUStjR1U4K2NGaitMUU1EeVV5?=
 =?utf-8?B?RTV6aSs0Y29yck14RGNPbURnd0J2eTRSUG1zOUpEb1ppbmpPY1FmV3BpWVNs?=
 =?utf-8?B?N1VkWGxxTC8xa2lBRExHd3pwc1FuTU1sMGo4dDhMZzFmQTBTRFo2Nk00UlN5?=
 =?utf-8?B?WFR0UFdpK1Y2MDZKdDloWVhwZUZrOEZnTnBEeWdCMTRDUFBoYUUxc0hKcm1S?=
 =?utf-8?B?NVhCZlA2U3NCMWUyODlSUXJaVU9tYUhXTWZCd0R6ZVJSZG03d3hJdWl4d21z?=
 =?utf-8?B?RW05Vm96eFRWaFc4RUx6eUQvZnZ1Z2c3eTFMVkRGeGhjZW9IbWtoWGcyeVgz?=
 =?utf-8?B?bVBUa0g5M3RJTnlWbFU3WW40b01COXhOWXNFSFBRcjdSbzFSWGNzZE1SQm1F?=
 =?utf-8?B?OWR0Z2syWkJDMGpVOXo5Y1pSYTZ6QVNlYXpaYlpRdFQ4cUhGQWJMV21GQXpk?=
 =?utf-8?B?OENnQmtBVmJoaEwyL2VEN1hYdHlHTk9Xc0k0Z0E0NnNLMndYalVVMUN2Nmcv?=
 =?utf-8?B?dmxZM2FaTmZOOWpjbjJrOVNjeTd4b285TzU1T0lQSmRLbmRjVkc2RjFjVXZp?=
 =?utf-8?B?YlpzV3RHSkVlVG1EQmY4Zz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZTFYd1pOOWNIMmhRazdiRFJxdERMZFI0ZG9aNXNYbnQ4UDhJMFMyRU9HOG1u?=
 =?utf-8?B?V2RTODVvR1Q1YWwvdEp4TzlaQXYwTXdEMkNuNzl2MFpQVU9CUmFmY084elFS?=
 =?utf-8?B?SDdVSldHL1htQ2lySlBuTC9JalRDY1VJdXVWYjBEVzltQnR1OTFaNStHMWRy?=
 =?utf-8?B?UkxJODhCdlRQL08zakF6KzVhQ2E4T0VQcDZaN1p0YXQ5a1RpS3ZEMnBUWGNm?=
 =?utf-8?B?bWZDWnJLOERncFFaZGJCay9ib0wvN2lPcHUvNkFOby96R25jQlJTS1JFbzdm?=
 =?utf-8?B?cG5zTVBXOENudE1nOUcvZVI1ak1zc1ZEcWpWWXQwaGpFSXA5cndjMFZEakVV?=
 =?utf-8?B?aEgrOTJCZDNURklZQU83MzMzNjVlODVCSDFpR09VeXNUTERZbkZSU0xNZ0FK?=
 =?utf-8?B?SGNua2dCcTR5TWRYUUprNDJMNEt3VTdNMEV2aElRUGtZckROT2ZHMUs2NXk2?=
 =?utf-8?B?Tm1ybEZPbTZ5eURDeGN1SXhKR2lPbXBQQTBRK29HNWVJbkhiSDlNUHdWaHlD?=
 =?utf-8?B?V3I3SjJ1ZE1hODQvT3F1ZWJXYTZCam81Z3lmTVFFMlI1SVVzbHgxK1JQMzJF?=
 =?utf-8?B?NXYwdUc2NkU5aVlQcURsdThnTnNNNmpPNjc3cFR2SnQ0K3pMRHp5cmF6ZHpT?=
 =?utf-8?B?c0dudG83aGpsUUJoLy9zL243cHdPb3RiczBOM1RKUmVCS0VsbjMwcXBWTHlX?=
 =?utf-8?B?eUFhb3o0Sm5nR2FabEx4UUtpbmhObk9IS05EQ0l0ak45YnBWdW8zQlRaSWVn?=
 =?utf-8?B?ZGdKSEFRZzMxajhNK2hoYStCV1lKbWYrWmthTy9LMzZTK3lWcldVUllRK1pT?=
 =?utf-8?B?a25neEZBclBwRDYxUXh2dWZlTzlIVWhPWHYyWGFsekYzYjZHbVZvME11UWhq?=
 =?utf-8?B?RytlVnZnMjFZV3R6T1YvblRpQVo2U3VTRmhacHlFdmcxTHBCZzZiT0FvTkpS?=
 =?utf-8?B?YkJ3d3UrQTFsdndTWGRJYzlqOEpUL2xIUFk1T1g5SkNOT2pieW0rNjJVVHI5?=
 =?utf-8?B?ZWlTblVJSjVVUzdDUXU0cUFJNFFsMytydlg4TjY5MVZVazZiNXU1cDgrYTdX?=
 =?utf-8?B?NEE4T0I1eGhZY3k1aDRQR0xyaWdBVEpLZHlNT1FqQm5wY1IvMWdzMUNDWW5r?=
 =?utf-8?B?ZERURGdOejF0Q3ZCZXJNdTF0UzduOHZVRk14eWRuU1k3YjhBRGsrbGtGWC82?=
 =?utf-8?B?MEFMZW5qSlZVMjJoSmRWSGtiUnZ2TGM3aEJrQlJsb3JrM3N5d1IreXR4UFhj?=
 =?utf-8?B?SDZoU250SndxZmhpSFc5VTVhdjFUeHg3NkhFY2RhbnAwNDczNzlZV3dpV2hr?=
 =?utf-8?B?cDY1UFY2c3hjbjBRYnJiWU5qWTUzZ05RN0tTdUlHMldGSHEwQi9iZ2tXTjd4?=
 =?utf-8?B?bGlOYWVFYVE3V216UHJOc25qUTEwa1ovSjJBdU5OODdZRld1TklyZy9JaHB4?=
 =?utf-8?B?Qm9GNkdvZnN4L29sM2ZRVWVIdFMxdTladk5QRHhwSkljRFhKc2M2UGlnZWpZ?=
 =?utf-8?B?TTNiTWZSNk5Gb0VWZTBQTGtySVdpRmM0a0Jkbk14VzFXVUVZUk9nbVNWL2lt?=
 =?utf-8?B?bTg0SGgwb0tXOHJMSTJEbllkeHV5RWpnWDRJM0xoTEQ2M1dHdzFSK3BnWE1l?=
 =?utf-8?B?d1VuYURSZ25iN0o1TitsVnhXZjNRZGg4VG1nTDBnNDF5ak0zVjBER0RvbVhB?=
 =?utf-8?B?cFNJWDJUYkpwL3dJdGxPQUhBZkIzTDBsM2NYalZ2MHo4a2h5WHE2Z1lZWVE0?=
 =?utf-8?B?WE1JTUE1WGZBV1Y1TVF3ZDRNb3UvSkZSenF5bHV0ajdkV1BtWno3ZlMwcU5m?=
 =?utf-8?B?dHBtYVkvME82MzN0cWdvNytUTWRIR24vS1AxT2FQbm96M0pNQTdLYzFuZVg1?=
 =?utf-8?B?RnBuTGcvSSs5eE9aUDZ4Z0N0eGFnQ0J2dDZBdGdaNlg3bGdoNFV2RjRZODFU?=
 =?utf-8?B?K2J2azh0RW5yZkRGMHU4aWVpTC94V01rRHp0MGN5TWNRN2xkNytMcENMSXph?=
 =?utf-8?B?UFdNTW9mZ3k1WlArTXdrZTZGa1hqaE5DOXBoc1VTcUFhaWtDSDh4c0xZUXVk?=
 =?utf-8?B?bHZwS3Q3blZ0ZFpTc3pUSzV1d2VvSHdEYzRhVzduQ0xZL1F2blNPNmVRaVN6?=
 =?utf-8?B?QUc3aTA0cWtjMVg3V2lBaElHakxtWi93V08xRFRYaHd4eHV1blNCUFNQY213?=
 =?utf-8?B?QVE9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 17e25ef3-45f6-4951-a6b1-08dccd7f4634
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 07:49:30.3343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K8AbDkWI4OQTQoZNf8pALtWRSTzMrv1H71TavRJkOr8Rl79g5vB/GsAbpdJWSMaljKiB668NP9llZ84if2mQ3/faT7Ln+gks3MNf48/JB6A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5720

On 05.09.24 1:30 AM, Adam Ford wrote:
> Currently, there is a look-up-table to describe all the clock options the HDMI PHY
> can use.  Some of these entries in the LUT are using a fractional divider which does
> not have a well documented algorithm for determinging values, but the the integer
> divider can use an algorithm to calculate the integer divder values dynamically
> beyond those listed in the LUT and also duplicates some of the entries.
> 
> The first two patches do not do anything functionally other than simplify
> some of the register accesses and de-duplicates some of the register look-ups.
> 
> The third patch adds support for the integer divider and uses it whenever the
> clock request is an exact match.  Otherwise, it will use the LUT as before.
> The rouding is still based on the LUT if the integer clock isn't an exact match.
> 
> The forth patch updates thes set_rate and round_rate functions to use either
> the fractional clock LUT or the the integer divder mechanism to determine
> which ever clock rate might be closest match.
> 
> The last patch removes the integer divider entries from the LUT since by then
> it'll be comparing both the integer divider calculator and the closest value
> in the LUT.
> 
> In my testing with a AOC 4K monitor, I was able to add 4 entries in my modetest
> table.  I do not have an HDMI analyzer, so I just used my monitor to determine
> if this series worked.

So I tested this series and it works fine. With Dominique's patch to
allow for 0.5% deviation for the clock, all the 24 modes of my monitor
and 30 out of 42 modes of my HDMI grabber are working now.

I still have some issues with LCDIF underrun errors on modeswitch with
v6.11-rc6 but these are unrelated to this series.

Thanks Adam and Dominique for the great work!

