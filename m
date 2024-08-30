Return-Path: <linux-kernel+bounces-307949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC42A96556B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 04:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11D5D1F24300
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 02:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81B7133987;
	Fri, 30 Aug 2024 02:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Me5Kghpb"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2082.outbound.protection.outlook.com [40.107.117.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DCBEEC3
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 02:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724986412; cv=fail; b=C0U0dvwYBOzHhrrkxNGRII+zetakrPyoA238TZjkDkjLYpIK+CUucHGNrVan35EI0Ookma2PWIe2BvrEAe8+3W7YlbtitrDkq5WoGbszr57Oj2fAQvZGvcC7wHM43h0xuw1ODUW52bRsISskRJWwr18v5hEIu08qhkuOuh2gbus=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724986412; c=relaxed/simple;
	bh=B2czNGqGNI4EtcYlFPHt2gX/sleCtpRu/FfaeKZu2VU=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HlObq6dKA1bMHuHTO+Nk1ORhqq0R5ZPaL60SO11/a/dLpjkrnqinhY/X8Snh3TsxeHHHtWUT/lm0C8/0e3I7BiwuEVInREm0F06WXgSP+bXLleieegTJYxCvn8j+2IFntHeNxfn/dAqJlKqkeOkFa4vIdV+gsVYme/M0W694aW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Me5Kghpb; arc=fail smtp.client-ip=40.107.117.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mvJR4UAU+Hc5DA/sJtjfz8HMfexYjhf5iUHpWWP45c6zEMNWOMd0jel0H+XWoMrBlW5LrMtdvllpjDXvYFMXfah3oAJExYY+p3BdjSfWTsD4cHC2U9HPgIr6oIxUF4aisy/9eJZlJFwl2gOsI+Mme3uit970tSln0EkeBD+Q+Qwt6eNH+iENWliZflRN3d9c22inkXe2JeYsN58L3t3F9jzm5fvQmPRZxGVSr8O0gPgUbsEx+6CFIPo3rMDu//z/0d7Jmc6lXyq3WGeeXmf86bD3ZrihLGwCdvinL9P12nNJ+5YroJ7GrwkAnJGsVd2JMdm2X8eV9Mh9OkcqkDhRVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lN7tmZt/glISgy3zLkQ2c4OykI1P22OykqdSycLJCiM=;
 b=Uok3ZLvWyYCOxAYpiOD+SWQF7fMZoJZtVSLPgFO4uRAiBHwDiJwrLta3iIHEhabnpS83flE6bvx2SLjlhj4cCfcAKuquXEkgXABDIy7CjBp4ZNUszB0SDzZzfWc41U5VlvDDJGnNcLFkWC0HD81sUYt/xI4PZJiqUhMzeJRzvY2YdtATM8MDPFw46tfcvNhZ01apNEYZ1N+RrlUnE49zmLNBQOiu+H1k8ura5Fbi7DY2XoBTWW2Ip7MOWDlR+9mNzXBMrFULXXahulp6w5ZMnVkgOK4/DILOJ95B8yrLU8ERzwlZmLa2wG+vLF4C6qI3LZKPnvAhLylwEZ3NHfYT5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lN7tmZt/glISgy3zLkQ2c4OykI1P22OykqdSycLJCiM=;
 b=Me5Kghpb1vo56FR+ExsDIuVAPYnyd68BEfooYbXarWstRAXAZSUHYMieXxkBhodtMMoSAJ/t0MKnrzzNp2ralccpxylcpeKm+caY04IsHQ3jzw0xZ11R5ffVCerPYu78An2WB91tC0OyuOz15evyXwQdh5R1QLxQGWVWl2Uw23CmSHxQrfGD2FpA92igbbgF8se7CvfBG8feh1OX2mRl+Sw9Kmoe2kwRTFFowpI9eXvKXq9w6Hcy88Qx3DSWUbX6WBPnpQxgTSlsTlHsgiP5PdGRVbuNNAFmLvzTKvjI6MsVb62nZ7yzDR6evUZorTyemzrUaVefOSUMgE5U+vw/Gg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB5709.apcprd06.prod.outlook.com (2603:1096:400:283::14)
 by SEZPR06MB5270.apcprd06.prod.outlook.com (2603:1096:101:79::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Fri, 30 Aug
 2024 02:53:23 +0000
Received: from TYZPR06MB5709.apcprd06.prod.outlook.com
 ([fe80::bc46:cc92:c2b6:cd1a]) by TYZPR06MB5709.apcprd06.prod.outlook.com
 ([fe80::bc46:cc92:c2b6:cd1a%4]) with mapi id 15.20.7897.027; Fri, 30 Aug 2024
 02:53:22 +0000
Message-ID: <e891a5cf-613d-4d7e-b146-798f60777a63@vivo.com>
Date: Fri, 30 Aug 2024 10:53:18 +0800
User-Agent: Mozilla Thunderbird
From: Yuesong Li <liyuesong@vivo.com>
Subject: Re: [PATCH v1] kernel:time:hrtimer: Use helper function
 hrtimer_is_queued()
To: Thomas Gleixner <tglx@linutronix.de>, anna-maria@linutronix.de,
 frederic@kernel.org
Cc: linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
References: <20240821094633.161298-1-liyuesong@vivo.com> <874j739x57.ffs@tglx>
In-Reply-To: <874j739x57.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:3:18::15) To TYZPR06MB5709.apcprd06.prod.outlook.com
 (2603:1096:400:283::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB5709:EE_|SEZPR06MB5270:EE_
X-MS-Office365-Filtering-Correlation-Id: 853b123e-4bf6-4df3-c7d0-08dcc89ee94b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eWtJUzhWNWgwMk5QUWloeE1XL1F3TzZmVlkxOS84cGxiVDMyR3BHQStlcFpI?=
 =?utf-8?B?STA1QU9UbzMrVmZxbXVqa1F1MlNUSHJrUUc2YlRqYXhhWnZZN1VwVWRqODVm?=
 =?utf-8?B?ZlF5YlJyZTNWM0ZzSVpRcUNGWGp4SHhHYW5aMHoyQjlqOWtFSmNlQ3RSZ2JE?=
 =?utf-8?B?RE02NGJKbVQ4algvUndqOG1aU3pHOU1nSytQUmZQTDMrajFtZ3h6QUI5QURn?=
 =?utf-8?B?VHBRdWxYZjVQRm5PVVMwaTNUYmNZTWxUZ0h0YXR3QnJENnJBcG9mbmN5aS9N?=
 =?utf-8?B?TnBSSzllZnByUXUwcFBSb3RtR002STRWRHZSL0ZEZVdWaFI5Wi9VajZJMUY5?=
 =?utf-8?B?ZEVHNFBrTUMzWE45TEtEVW9TUTlmT01Xa2ZHa3l4UGZGSG1VS1hVUXBqeHFa?=
 =?utf-8?B?b0xmTE5Zd0xRUTZveUR2eEprdCtqZDRlVUhjNmVTU1FDVjY0aEpPQ0p4UXpM?=
 =?utf-8?B?MWdoSmFnakxxR3czTW9VYkxYYVZIVE1jV0o1bXA4WjdrS1l5UDZkRXY1blhw?=
 =?utf-8?B?OHluODBRdUU2d0JNZDZqUHMrUDFjVXhKOEFWaWRCQ2s4Qi9QWTlBc1BzZ3hi?=
 =?utf-8?B?VUdUUlVnV25URkdkN05jd0dwekFhTm1GNStlMjZzb2RZd2M0VzhUUHZteE5J?=
 =?utf-8?B?aGkvY2tKdVoxZjc3OTJ2dmc0RGd1Tjd1VGkxOWpNeTNNUkUzcVlLbEo3S2Jo?=
 =?utf-8?B?Ui9tZ0tBL3F3WVFhYSt6WDRSRWVhZUM1STY3bVRBcGZFcFNYeit4bmNCa2ZU?=
 =?utf-8?B?cHJWd0dzRmMzcW1QZ3h4aUdiZEpodGZmL1NKVXZkTUpvN0RxYzJqR3ExaC9R?=
 =?utf-8?B?cmtQa25ZMzdTQi9aSVFRNmFYYlF0TElOYmVNT2pxSThrZW1jQ09RMVArVHlx?=
 =?utf-8?B?dEhwdlBIMFg2dlhCcUczcDl2R2dXaG55UTJBb2tKQWtUSjVVOHZHV0NnM3Ix?=
 =?utf-8?B?c0xLcXFqeWlMeHZBZXBzS1pCTm1uNkMwZkhRMFJzOXlYeHpMWklRNHNWMXpo?=
 =?utf-8?B?TmQ0SDRFL2RDaXNDYy9IT0NDb0JKYXdVaTU1V2cvOTRRK1hpU1EvN2pVOUY0?=
 =?utf-8?B?VVNVWGNjTTNJWWFlV2lVd2l4YmFRME11aUlZN1VnMmR5LzJPMDdlVWdVZ0s1?=
 =?utf-8?B?VkdYTHhndW9WbzFzbUlVQUl6Y1lObjN5c29RYWhpdmtiYzJXTzBqdk1pNVJX?=
 =?utf-8?B?M1IyU2dkL3ZsRnZpMTkwNWVJZUtJU3NOelVtV25QbTBXUkZsWlhRTldHbWg4?=
 =?utf-8?B?MWhKVEhFci9pNUUrdll4MkxUclc2V21wSmhwWFdYWElxdHdYQS9ET1k3U0Vr?=
 =?utf-8?B?MWpsVHMzQkdqamdLellsQjRXQjBNTFdOT21HQlhJMTJVYmY2cDFGdU9WT3cz?=
 =?utf-8?B?YVhOczdtT2wxMGhNSkhRUmNHRDRiZjhhd3RsMjFaU3lYeTg2ejFLLzhQZ1Vp?=
 =?utf-8?B?MG4vRm91SWhsK0pSWFNQYjAxNWxwTjh4WDlVV0IvSTlLeHk4V3hIaytNL1g1?=
 =?utf-8?B?T3RKQ3QzVVQzam9XQk5vWjJFb1dmN1hOMDFoL21nZjdSSnlnNWYwMldLZnB5?=
 =?utf-8?B?RzA2RmFwSExaQ3Y1V0VEWm13WFF4NnlwQzg4NWNTL3Rrc3gxeFhpbURHUXYv?=
 =?utf-8?B?VE5heVAvdnlMV3ZkSTl1ZDN3ZHRWQ2poYzZqTHpYdjdLa0RjK3VBVFliaUNh?=
 =?utf-8?B?Wk1UTkpmd3BUVzZzSkFlek13dmVweWs4NGQzcWJ0SlErby9wSUZiVEoyMVoy?=
 =?utf-8?B?OUo1TkdqMkFlTzJ4cWxLa3hoWmFVYVdkUXFsQUJnMm40OEJiQ3dDdnZtcWFI?=
 =?utf-8?B?cTVXSHRvQnNETGVVby9OS1NGRjV2a0VvckoyUm1rMmc3S0phM3haeTBxNGpJ?=
 =?utf-8?B?UXVQdy8vZlgrcUdVQlJ5ZXJhTVFJUXM4bUtraGQ0SXd2cFE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB5709.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y29OZ1o5Rk5uYlArSWlvRU54MUxPTHl3eXpady9HeFI4dDh4TTFySUkwY2Ev?=
 =?utf-8?B?LzVYc1lLYXR6QTB3R0FHY0oyMzlVeGZ5M3EvdS9WRHFmQzk2SFdJOWd2OUE2?=
 =?utf-8?B?bWpmc25pM04zY0ZXajJsUXRLSEZQS0RmYm1LdExLV0cxdUwwazVsRmVXUGNw?=
 =?utf-8?B?c1ZYUnNaMHRaT2VMR0x1dGw5UnVCeENEL05NdkZrekhuRkE4aU1heEc2cXBx?=
 =?utf-8?B?NnVxSDNsYkwvNi9VYjJLR2dmYUJZSHNSMzAwb21aYWNkUkhHU3ArM1dkcHVD?=
 =?utf-8?B?MnI2bXMwT1VaQjNzaXNiMkFRbE52T3J5aVZITWphODZaMDUzelllK296WXdV?=
 =?utf-8?B?Rk81NXhCNGdFejdJcXpLZFVNTGkwWS9DdFdvcENiY21FQWNkdFY4cE1CN0Vp?=
 =?utf-8?B?N00rOUg2S0M2RmVhUkJXVjBNUzJlYmY1bitvZDl4ZDJTVDFwSzlQdjRaVWJ2?=
 =?utf-8?B?NnNyR3pkTDBsVnRlK3BsNHJwNDNmbzR0VnltMHAzM3RTRHcvUGJOS3AzZVB2?=
 =?utf-8?B?cFFmNGYvMmovSGFqaTN3eWl0amc4b01xTXhMWFZmeWsrV3l3YkhhMXhrUWNX?=
 =?utf-8?B?Q1NMNHBmVFhQTUFGVi8ybE9OdzlPS1BiV295TWNNVm9pcDNDQlBCeWZYQThW?=
 =?utf-8?B?NkhFdVZoZnMzbUlTMG4rRmtwbk10cUg1SkxkWVpFb0F5bzM2Tmk3U0VoZHFL?=
 =?utf-8?B?YTRQdDFNTDRjSWNNWnNSSDgzUHRYQ01uaU9UeDZtbURQUno5NUQvYjB4dnA2?=
 =?utf-8?B?NC96NkNNMTNZSGVWd2g4dXBPVU1VM0dlN1RzNUZJVTFsVGIvYWJhYVNFU0d4?=
 =?utf-8?B?akZhSlQyRzBkUHBQNXFaTERvUVMxL2EwUE9mSFRnZU9vODNHQ3JaTU0vOGYx?=
 =?utf-8?B?eEZCUUM4UWh3dFFjVXM3dkYyVWpSYXZCdy9tRzEvR0ZpY0RnazFMSmtkMTh1?=
 =?utf-8?B?R04zL3d0eFJId0F1aDV1NllkQkl2YkZQNTlud3U1RHdpZ0dYUUthYlFPZjhM?=
 =?utf-8?B?NS9VQW9wOXl6WVo5MHd6Z3Z5T284bXpia0VJWFovZFplRXpkSHg0UG14VTBM?=
 =?utf-8?B?RjdKd3A5TjkwL1JPd3hxMzVya0xHVDRWSTcwcm1DblJDRi80Z0NYMncra0sv?=
 =?utf-8?B?ZHRWTVJ4N3NHaUJPQ3Z2OWc3cGtYcEVna2U5SEVFVVJRc1hreWZ6N1dvY0Yv?=
 =?utf-8?B?VmpnaGY0UGRaaXRZY1krMDV3MXVMaDN3S3ZRMDhDanBpRFpMeGpGOE1mUDJt?=
 =?utf-8?B?VDVsejRVbWN1WjN4cVhkZ21oNXIvc0w2ZWlwWXdoeWhqcnExV3B2QnA2L0Fj?=
 =?utf-8?B?RFR0ZU80SktHYUw1MVRDWkU1eFFEK01uYngrWGE1dzllNnlmYVFHMWFFQjZX?=
 =?utf-8?B?QTZ0cVJBWFovVldFTHlvVEZIdk44NkEwa3JnWjd0UENWdVllSUJyVEEzVFcz?=
 =?utf-8?B?QmxaUm5jWXhYYTl1UGFYbDZNMlJxMlh6OGladHVHajdyZGFjdnVNSDJsM0Fi?=
 =?utf-8?B?UnhDMElnbmxxS2psVVpaNjFWdU9RRjRsaUhmUThBNzhiWmFXMFJUR0pYckFG?=
 =?utf-8?B?dHpodmtUeFVYaXFtN2U1Sld3THk5aXJxNW8wWjJBWEM3ZlhJY1F5U3hPTENY?=
 =?utf-8?B?aE5IZXhZYlF6bGFIQS9ndWtMNjJZcVlKOEI4bW1SZmFla1dKNUJ2blpOa2FZ?=
 =?utf-8?B?bXNYc3BFQk1PWldpdFhYeHhlZ0xJZFQ2UUYvUnZ2SUlFc1FIc0Nnc25jN2RX?=
 =?utf-8?B?NnZ2cHJBbTRJcDVOLzc0NnJBOTNESUVNbm1qVFNzelRRalRRS2RtT1ptSFNJ?=
 =?utf-8?B?akhVc0t4Z2RVSjVSdFBJS2pmRWNPc3pWNlZrYjNmNzdjSWNPR005QlM1Y2Zk?=
 =?utf-8?B?QUFIY2xmeDZSejNqVEQ2cyswR2RKbmpuV2NQSjQwZFlvT1FVMTExd3lha1lh?=
 =?utf-8?B?VU5EK1hSbksrczFyc1AySWx5UmtVSzZrdFJqZ1djQk5HemNrNE44SGlYZEFh?=
 =?utf-8?B?VlhtQmw5OTdCOTVmUkIrbURFNEdzOXBVTzQ5T1dJWUYyQkNzR3IyNkpmYkJI?=
 =?utf-8?B?OWU2Ni9NeHk2MDBHRU1PNU1mcnAxU2xMcEdkTWh0SFROUzBZL29FQ29MYlJI?=
 =?utf-8?Q?GKZLqujCppLgNdByKS+En2k+4?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 853b123e-4bf6-4df3-c7d0-08dcc89ee94b
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB5709.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 02:53:22.6410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZZnOdPmnAj08OBTmfnYfKeHrlD4lvf0zV++mV2fDaFbjw7z2u6NRH4MH925kE7NVjnvmeDswMqpNOATEvBs+TA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5270


On 2024/8/29 23:17, Thomas Gleixner wrote:
> On Wed, Aug 21 2024 at 17:46, Yuesong Li wrote:
>
> Please add a proper subsystem prefix to the subject.
>                                                                                                                                                                                                                                                                                                                                git log --oneline $FILE
> gives you a decent hint
I will send a v2 if you agree with my reason.
>> The helper function hrtimer_is_queued() checks whether the timer is
>> on one of the queues. Replace the raw check.
> Why? What's the benefit of this change?
Compare to raw check ,I think this makes the text more readable.
>
> Thanks,
>
>          tglx

Best Regards,

Yuesong


