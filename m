Return-Path: <linux-kernel+bounces-378290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B426C9ACDAC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 16:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3602B1F21A3A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 14:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B441FEFDD;
	Wed, 23 Oct 2024 14:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=supcom.onmicrosoft.com header.i=@supcom.onmicrosoft.com header.b="OnDipduX"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2120.outbound.protection.outlook.com [40.107.241.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA101CCEF6;
	Wed, 23 Oct 2024 14:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729694706; cv=fail; b=ZvgklJuQaXfu1RBNANszUEfNJIHCGlMjyDMFLDdTX2x9fqkEJT/J2YWXA0Rp+7jrOtEzNHTm7VdVTup8owdB+EJTxAAGsv2djSBw+A6dMCEKT3UIt97u0zrEqI3tmM1NF/1mUUoROt2drAeCcpHveZJZsdu9glZjgolGeyeUnaU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729694706; c=relaxed/simple;
	bh=t73Lpg9enavXb2+RNSbWl4chXDfqpa08Xn6yhUM0Ows=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Sxr9GV/DNWiv7Rt6oPq7ul12rimBkk4e8TGMBk8MaGE0qNkClz9d1qt8jkr0v8s7hRm0H7V3GmAbhWg96Kcyr/ikfA0HNTqKy2EslkJTz41Ccxz2yZpUPdi6SnviOMXtafzHD+kzh0TU5uQOTBTHPdyDpedbXCQ/saH6VePKSqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=supcom.tn; spf=pass smtp.mailfrom=supcom.tn; dkim=pass (1024-bit key) header.d=supcom.onmicrosoft.com header.i=@supcom.onmicrosoft.com header.b=OnDipduX; arc=fail smtp.client-ip=40.107.241.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=supcom.tn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=supcom.tn
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ac9l2B7ME/7IdTAupDUqxb0vq+u2qJYS9uwFJS552ApTEVAPCCMcjWMI1hGWlxwaEX4wDVdE9+iWcLrSfBCwhku2regXGSKU9rKrZhtWETwKgPpwH3R8RBwDGKSrwDvnSSGOOQpOMRpIT2evIJs5eK+Nxj0UEtIkUhswy6uTCJOMXAtJ32dDm+hbNo+1UU98dYv7q4w5sSZvoJQbolIoAU4xxqVJ/P/RlfVGhS8OpH8urzhCkMF+Hi8bytoVUZqnLDr6XOXH7bfN1ZdAS5r4nV+lyGrBSHifun+DIqpKuRzZR7Yz/cem/jjaHEy5EKjBQaGoL4uKe5ozz9CehWjXQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M7QMxYcE3RRjg2KAfAMO0PI8dam/tnr8NjhUBbiQr0o=;
 b=yXESdDBNeYOYzYF1Zubq0pJiqw4D2G7A3HsYEvAB8cfsmFttDKz7P/jz6Q9aBSU9lfMRHcxTxjeesB3cMPb3R3k1msWHFDD16v1mqJN0cUwbAdVGNViYEpF5Kiy9LucE+2RILDxD7MI0Bur8B3+L21pq2tkuTsMbmfv3c+xHL8UAIbEKvL1iiwtN0KnO5ZXqBlvgt+82nIHF2cjLHfyN+YGDLa/RdOMs/Xjix5HwRWMz9WplhTOEJYxHCmoS6dxLZSmS7BdItkijcB9iRpJUcXq7VYRti4p6b5jbVWqyk/h+67iZFfek9+0g5lESTHgkRxK2rIIadc10lGsrfWXCHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=supcom.tn; dmarc=pass action=none header.from=supcom.tn;
 dkim=pass header.d=supcom.tn; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=supcom.onmicrosoft.com; s=selector2-supcom-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M7QMxYcE3RRjg2KAfAMO0PI8dam/tnr8NjhUBbiQr0o=;
 b=OnDipduXwntT88NM5U6MLjtZ9YIbwGZwTCCDneQ3ORGL5W4Oh5//oZFB6nD+Lt4nZ7K6baJ2FCjFqPgX2ky4UHMKDRwVcFeIi+CweSexE4T7DMZW5x0/eXagFLQSKRTsy7n5aY60wnf56E/bHcFlLR0dJ3s1EZwwf3KSRMHTUNI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=supcom.tn;
Received: from PA4PR04MB7919.eurprd04.prod.outlook.com (2603:10a6:102:c1::20)
 by GVXPR04MB10246.eurprd04.prod.outlook.com (2603:10a6:150:1be::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18; Wed, 23 Oct
 2024 14:44:56 +0000
Received: from PA4PR04MB7919.eurprd04.prod.outlook.com
 ([fe80::d550:6682:2c3c:a8c2]) by PA4PR04MB7919.eurprd04.prod.outlook.com
 ([fe80::d550:6682:2c3c:a8c2%5]) with mapi id 15.20.8093.014; Wed, 23 Oct 2024
 14:44:56 +0000
Date: Wed, 23 Oct 2024 15:44:31 +0100
From: Mohamed Ghanmi <mohamed.ghanmi@supcom.tn>
To: Armin Wolf <W_Armin@gmx.de>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	corentin.chary@gmail.com, luke@ljones.dev, hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com, platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Larabel <Michael@phoronix.com>,
	Casey Bowman <casey.g.bowman@intel.com>
Subject: Re: [PATCH] platform/x86: asus-wmi: Support setting AIPT modes
Message-ID: <ZxkLz6QBahA7WAyh@laptop>
References: <20241020065051.1724435-1-srinivas.pandruvada@linux.intel.com>
 <911ce141-8f20-48fb-bc43-e6d4262dbc81@gmx.de>
 <8d70bb6a-c6fd-49de-a494-e97c093827e9@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8d70bb6a-c6fd-49de-a494-e97c093827e9@gmx.de>
X-ClientProxiedBy: MI1P293CA0015.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::14) To PA4PR04MB7919.eurprd04.prod.outlook.com
 (2603:10a6:102:c1::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7919:EE_|GVXPR04MB10246:EE_
X-MS-Office365-Filtering-Correlation-Id: d3b51b67-994d-496a-ca17-08dcf3713d85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|41320700013|376014|7416014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WVNTNHhONGdFYkM3SkI3Y1NlMTNVVElvUVpXck5vaFF4KzUrejA4ZElCcFdi?=
 =?utf-8?B?YWpqcjdITEpFdjVzbjRmMFdVcHQ2c1d0ZThEUlNobnhxbWltTVZCZDVtUit6?=
 =?utf-8?B?SmlROVNGVVVkR09TbmM0UitOQnNQbm95T1d1SVAvYkxLb3UyMEI0b1p6N3JW?=
 =?utf-8?B?eFBUdmc3b1NVeGU2bWhycmd4eEpkT2toYldrQjRuSkhvVGk5RC9JU1FyOU8w?=
 =?utf-8?B?ZDhrRnAvbm80TDE0Nmg1SjhhUWdUSkNlcnIrdjJNMG1reFhpRzJldUlaNzlm?=
 =?utf-8?B?RURoNEVOeUN4RnVyeVpQOVNBM3dydFFNaU5PS21sOExhQUZ1eWlML0N4ZDdR?=
 =?utf-8?B?aDNVZktWbkJwNHRBZTVtcE9CZjN5ZGE2VEtKcmkvbGdFZTZLUDdwQ0Mza2lY?=
 =?utf-8?B?UXQvenlmbWphcFBLeTZMVlE1UFFadWg1eHJMMXBRdEtKME41Sjc4YkVJQXJD?=
 =?utf-8?B?ZlBHdUJvemk4dkRxN0NXeC8rTXF3LzEzZEQ5WjQwRXI0Tmh0YXdkSTcwWDFB?=
 =?utf-8?B?SFdlOC8rVWE2b1ZnRXVzcjNaaVJZSmY1UFFGd2hUU3F4UlRZbC8yN3NKeDM1?=
 =?utf-8?B?b3JDb0Y4Tm8yS25yVmtWOGFvVFV5WXd2cjBHVXRuOHVGLzVDRVBjM2EzZUs4?=
 =?utf-8?B?M3ZFNUVzUCtjem5EaWVEdThQS2M1ZCs1eGFvK3dlMlE0cVA0UzJjWUlPOFdh?=
 =?utf-8?B?MnF0T3ZScjFkSFlycDczR2NTYnpNQ3ZNVzBuM2JVMGcyL2ZtaTdMY1FmSlpy?=
 =?utf-8?B?RjIwY0lhdFlOVVBZZnZFMDY2bTY3ditEZ2FHeUtFMnZ3ZDhuZGZFSlo3RG5v?=
 =?utf-8?B?WTVCMFJZemdFUzFSS2xNRFZxMjZybm83S0Y3ZXR0V1NrbFBjeDU2Tkw5NGVI?=
 =?utf-8?B?ZGIzaG0wMTNsejdTK1dOb3VYdG1rb0FuOUtUb0d4YUREMmx1enVDUjNyVmQ4?=
 =?utf-8?B?cGQ0VEtFQnFMSEVUSDBFbStCMEFwdUUremdkOFVFYnRoS2swVkdSV2Rza0pq?=
 =?utf-8?B?RGZYK296bGFZZzNrU3dXYmFZeXN1bzRCTkZyYkRuUDRESFFNQlZVdXhDT1Mr?=
 =?utf-8?B?MktZMlB5RVZNVjhTaTJKQmNWOHFtc1VwVVcvUjJJbWwyS1piMUNqYXB6eXJj?=
 =?utf-8?B?Z01PVUhIRGtYb3VuMVUwUE80cUl4d0VlWDVxZHBTTE9FTHhIRERTUmtCKzBQ?=
 =?utf-8?B?ZVZBd2FsYjA0WmxmM1B4Vi83c0hOa0JKV2twb3pFYUdmMDJhbVFFMFBRdWxy?=
 =?utf-8?B?cFhPeWQzZVRLekx2a2Fta3RqTzFFNE5kS2ozdjR5WDZzUVJrVSs4cGg1NEhn?=
 =?utf-8?B?a0cvNitvRHhISEt3cWFvNzhFRytkamxzMUZwVXp3cVY4aEhrczNwUFhKeXg2?=
 =?utf-8?B?a3FhMjVzRFRjT1NsbkZqbDNTQ1psclAvaExnTEZRVUIrSGQzOHIxR3krbkVt?=
 =?utf-8?B?Uzh1VG1CZzk2cDRKek4xWS8zR0hkeWVrVGpFc2lxVHJ0cUgvNjBFaHhQU0tH?=
 =?utf-8?B?SDlERWNtMmhVVU1NSG9LanZiZG9YUDZMSjhZYktFS1dNaEdPVHNvQXZSMXV2?=
 =?utf-8?B?REt1Z3Vwd2Z3Wkx4SlNmZzNYclZGNEVNaEpZMVRueUtZL1V5amxqU3ArQ0VJ?=
 =?utf-8?B?MkJmWE9vRE5DSmxCWGdTeTBWMTRLRGhZWUNCVFA0d2JTcmdzZDVtWDFCWHNo?=
 =?utf-8?B?UFZraWRXQVhIRTRsS1dvYTBUaWFKc1BpWkFOUGV4S20vSjB4Z0Z4a3VBYi9Z?=
 =?utf-8?B?SEE3OVF5dlNHMWNSNjhLTktwbHNNVDJFV1dLT0xJZnBkYncreEh2VW16OWVu?=
 =?utf-8?B?QllOS2MzVlRiRzQwNks0WTZtNVJBRXBFZ211ZFRmR0FiZ29aZzJoQ2l3aGNo?=
 =?utf-8?Q?OsaOUuhTGiX8c?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7919.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(41320700013)(376014)(7416014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M2hTNkQ5clRhVXUzL2NlaDhqeFZ0T3M3VTV5NjN0aVhOSHlYY0lUVHpwaGZ0?=
 =?utf-8?B?QTZtRDlwRnEvYmpiY3NXTU9FSjlSRklKZ09nZzZVY0xVSFVhUkJUd2lxTEFY?=
 =?utf-8?B?UVVGdnlib0ZyNVF2SEV6SzRmWFNacTUxT2VzV0NzU1FMQjFBQ0RQK2g4RXFh?=
 =?utf-8?B?VFhTRFU0b2pqelFSWW1Ba0VNR3B4aGxaYUhwV3BLemJsQVRyeHAySllXUkNl?=
 =?utf-8?B?Z1MrdHNlQlRiUmU0TjN0WFh5MGNZNU5VOGJzUDlVZ0wwRVFwcjh1aXBtWW1D?=
 =?utf-8?B?SHFvWjJSaDZ6QVFLLzlBdkhxTm9IODYvK0FwZlQ2WGxmVytVWFpxc1BpNS9B?=
 =?utf-8?B?Um5MUkdnZ1VsTkIycGF0YXRWb09xb3pIZVJqMG5PZDJaWkYvTWVrSkRwWEMy?=
 =?utf-8?B?RkJMOURHZWJZRktZYjBHZ1M1T254NklrVnI4RVUvR3JQdXdxa1NJZXFEUWlj?=
 =?utf-8?B?QlFGL0hQMlVrUXgrd2pHNjBVc3BveEQycnNCdHNZWm54ODRWcXFCRHdpRTcy?=
 =?utf-8?B?ZGc2aENxZDBVOVN2SGxxN21pUkh5R2poTlpSLzJsM1MxbDJNZnQvUkc3SUJZ?=
 =?utf-8?B?VFVYcXVZblhkejAzdGF5VGN5TS9jNXM1N2Q3dDVkZXJLRGRZT0lvMU1HbVps?=
 =?utf-8?B?QVpCWngrNzNlRGZScHh3UjZ0VEVob1pWRlordCtYVlpma3ZDQVA5bWJmU1Ex?=
 =?utf-8?B?cHpud0NpR2k4SjhBSFhCa1VuUzhaaytXQ3pxRFdnVTVRTzVUby83Sk41anRw?=
 =?utf-8?B?VHhrQVdLZ1c3NEFIRWpQa041amF6dCtYNHFKY3BmdnBoNE44ZWc3eVFROGtU?=
 =?utf-8?B?K0llMDIzWGFpYjhtTlRRcTJQbHFLQ1kzTnErWER1SnJRWVZCbFkxNG9QWGxi?=
 =?utf-8?B?Y0ovcXNRdTRtcWpOMG4zQmtHUFJoclM5NmpXYkFGcVMveHd1emZBbW9JUml0?=
 =?utf-8?B?MzQwamttWGUzMDlYYWNRa3JxNnFoU2VFSEhINVM0Tjh0dTd0d2FqVTM0cThZ?=
 =?utf-8?B?cTQzc0JzbXc0K0k1ZTM3aDYyZVJiOWxtSVZnVDduRHIzNFJIT0lzTkpWVEky?=
 =?utf-8?B?QXZKbzRMaDYyQy9TenJpMTNydlo0ZXYzQ3E2K1lJckVFT0p1eTd3dndUcDkx?=
 =?utf-8?B?K2I0UmZuQVkxRUt0WUFFQ243ZVdLdWp1Wk5RbzVxUjExZlhMNXBUY2U5RWxz?=
 =?utf-8?B?Nk1mYnZmNW1GNVpkUEtPemFBWXYvL2lNamlvS3FXSlUwaGIyWDdrMmpabVVV?=
 =?utf-8?B?MS84ZStNSGVKNWdYYk9PdzJrK1RVSk16R3ZYYy9HNlNWZ3MveXplejgza2tM?=
 =?utf-8?B?dVlPWEp6TkNuWWswcFo1M3phc3RpZzU5S1BpQjU0QmIweUdIL3VKN2VNWkcr?=
 =?utf-8?B?cjJQZGNnOXM4YXBRdGJSbzRYVWlVMUNzZXhqTDVKQU9wbVQ3RC9vd0pvaTA3?=
 =?utf-8?B?Q1dHTEQ4RFhRQlBWc1Z4bG9ueWpLb2Z6RXBQWWo4OFN6ZjkweE9wMDdSRGVv?=
 =?utf-8?B?TDFHZ3ZYOHhXeDJWeEVNbmdXaDNtUnJsSHJPUUk0VWxRTmJIQXVhc3VUUVBL?=
 =?utf-8?B?dW9CZ3phQk9EY3l4ZjhPcnQvMGNpR1pLb2NjNUoxUjFRVzVBckQ3YnRjbXdN?=
 =?utf-8?B?N2FXdFNvS1NYUTdZSTdwRFFzZ2t2RXhNdlkyYjRiUzBLdCtkNVBrSldiRGVz?=
 =?utf-8?B?WUdIcXVYK0RsU2QvdGFDSHg0dENjR0liSm5JekZNRUdhOFNRNEFKem95QmxH?=
 =?utf-8?B?M0RaMElNU3lsaHZaczNnWjQwMHZjcFhwQlIrVWtPbWlNSFhxNzY3VzcrK095?=
 =?utf-8?B?TnlYaDV4RU1kOUJZazFQa1NKVTJwengyZEJZR0oxY2JBUHF5WGwyOXRkWE1q?=
 =?utf-8?B?ekNLblFGN1pOUWpSeDZkZ05nUkhETVREaWNaUUJVeUp4eHp4WENDbEVmM2po?=
 =?utf-8?B?MFRQcEhvRHBsbGZmN0JUS2pwU2Fxc3R1VFBwOUdSVGJWK2R1SEs3UTFya1FL?=
 =?utf-8?B?M25FUWZOeUxoV1JjL015VkNhRHp3K1dPamIzRFE1Z1ZJOWJCZ0J5ZDEyTGY0?=
 =?utf-8?B?ajY2ZkdHenRwMnZxQjNTQ3Npd2t0QllZbTV5Z3JWY2dDK3hOd0FPQ3lpckFM?=
 =?utf-8?B?N2hCQzZrZ0g5OEs5UG1acmNkSGVtU29TbnJ1Y0VqbGdDVUptNWhRUjRTN2Ja?=
 =?utf-8?B?cHc9PQ==?=
X-OriginatorOrg: supcom.tn
X-MS-Exchange-CrossTenant-Network-Message-Id: d3b51b67-994d-496a-ca17-08dcf3713d85
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7919.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 14:44:56.7425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8f85f528-6195-4e97-8e41-f5a9ad3bed4a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4QWRxMNM3lTB0o3w+uAo3jAriyZtQ9X2kcxXu7nt4SDfulhw5hht7p45aqJJbl+8uIufxAQD08QAI+V5Bcgsnx2Pa2wiMiD3qIatqUUwxTs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10246

Hello !
On Sun, Oct 20, 2024 at 09:42:45PM +0200, Armin Wolf wrote:
> Am 20.10.24 um 21:05 schrieb Armin Wolf:
> 
> > Am 20.10.24 um 08:50 schrieb Srinivas Pandruvada:
> > 
> > > Some recent Asus laptops are supporting ASUS Intelligent Performance
> > > Technology (AIPT). This solution allows users to have maximized CPU
> > > performance in models with a chassis providing more thermal head room.
> > > Refer to [1].
> > > 
> > > There are major performance issues when Linux is installed on these
> > > laptops compared to Windows install. One such report is published for
> > > Graphics benchmarks on Asus ASUS Zenbook S 14 with Lunar Lake
> > > processors [2].
> > > 
> > > By default, these laptops are booting in "Whisper Mode" till OS power
> > > management or tools change this to other AIPT mode. This "Whisper" mode
> > > calls to set lower maximum and minimum RAPL (Running Average Power
> > > Limit)
> > > via thermal tables. On Linux this leads to lower performance even when
> > > platform power profile is "balanced". This "Whisper" mode should
> > > correspond to "quiet" mode.
> > > 
> > > So, when AIPT is present change the default mode to "Standard" during
> > > boot. Map the three platform power profile modes as follows:
> > > 
> > > Power Profile Mode      AIPT mode
> > > -----------------------------------
> > > quiet            Whisper
> > > balanced        Standard
> > > performance        Performance
> > > ------------------------------------
> > > 
> > > Here AIPT mode can be detected by checking presese of "FANL" method
> > > under
> > > PNP HID "PNP0C14" and UID "ATK". If AIPT mode is present, this takes
> > > precedence over the existing VIVO thermal policy. These modes are set
> > > using "FANL" method.
> > > 
> > > Although this “FANL” method is not used in the Asus WMI driver, users
> > > have used this method from user space [3] to set AIPT modes. Used this
> > > as a reference.
> > > 
> > > Link:
> > > https://www.asus.com/content/laptop-asus-intelligent-performance-technology-aipt/
> > > # [1]
> > > Reported-by: Michael Larabel <Michael@phoronix.com>
> > > Closes: https://www.phoronix.com/review/lunar-lake-xe2/5 # [2]
> > > Link: https://github.com/dominiksalvet/asus-fan-control/issues/151 # [3]
> > > Tested-by: Casey Bowman <casey.g.bowman@intel.com>
> > > Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > > ---
> > >   drivers/platform/x86/asus-wmi.c | 93 +++++++++++++++++++++++++++++++--
> > >   1 file changed, 89 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/platform/x86/asus-wmi.c
> > > b/drivers/platform/x86/asus-wmi.c
> > > index 7a48220b4f5a..06689d0f98c7 100644
> > > --- a/drivers/platform/x86/asus-wmi.c
> > > +++ b/drivers/platform/x86/asus-wmi.c
> > > @@ -100,6 +100,11 @@ module_param(fnlock_default, bool, 0444);
> > >   #define ASUS_THROTTLE_THERMAL_POLICY_SILENT_VIVO    1
> > >   #define ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST_VIVO    2
> > > 
> > > +#define AIPT_STANDARD                0
> > > +#define AIPT_WHISPER                1
> > > +#define AIPT_PERFORMANCE            2
> > > +#define AIPT_FULL_SPEED                3
> > > +
> > >   #define PLATFORM_PROFILE_MAX 2
> > > 
> > >   #define USB_INTEL_XUSB2PR        0xD0
> > > @@ -333,6 +338,9 @@ struct asus_wmi {
> > >       struct asus_wmi_debug debug;
> > > 
> > >       struct asus_wmi_driver *driver;
> > > +    acpi_handle acpi_mgmt_handle;
> > > +    int asus_aipt_mode;
> > > +    bool asus_aipt_present;
> > >   };
> > > 
> > >   /* WMI
> > > ************************************************************************/
> > > @@ -3804,6 +3812,19 @@ static ssize_t
> > > throttle_thermal_policy_store(struct device *dev,
> > >   static DEVICE_ATTR_RW(throttle_thermal_policy);
> > > 
> > >   /* Platform profile
> > > ***********************************************************/
> > > +static int asus_wmi_write_aipt_mode(struct asus_wmi *asus, int
> > > aipt_mode)
> > > +{
> > > +    int status;
> > > +
> > > +    status = acpi_execute_simple_method(asus->acpi_mgmt_handle,
> > > "FANL", aipt_mode);
> > > +    if (ACPI_FAILURE(status)) {
> > > +        acpi_handle_info(asus->acpi_mgmt_handle, "FANL execute
> > > failed\n");
> > > +        return -EIO;
> > > +    }
> > > +
> > > +    return 0;
> > > +}
> > > +
> > >   static int asus_wmi_platform_profile_to_vivo(struct asus_wmi *asus,
> > > int mode)
> > >   {
> > >       bool vivo;
> > > @@ -3844,6 +3865,26 @@ static int
> > > asus_wmi_platform_profile_mode_from_vivo(struct asus_wmi *asus, int m
> > >       return mode;
> > >   }
> > > 
> > > +static int asus_wmi_aipt_platform_profile_get(struct asus_wmi *asus,
> > > +                          enum platform_profile_option *profile)
> > > +{
> > > +    switch (asus->asus_aipt_mode) {
> > > +    case AIPT_STANDARD:
> > > +        *profile = PLATFORM_PROFILE_BALANCED;
> > > +        break;
> > > +    case AIPT_PERFORMANCE:
> > > +        *profile = PLATFORM_PROFILE_PERFORMANCE;
> > > +        break;
> > > +    case AIPT_WHISPER:
> > > +        *profile = PLATFORM_PROFILE_QUIET;
> > > +        break;
> > > +    default:
> > > +        return -EINVAL;
> > > +    }
> > > +
> > > +    return 0;
> > > +}
> > > +
> > >   static int asus_wmi_platform_profile_get(struct
> > > platform_profile_handler *pprof,
> > >                       enum platform_profile_option *profile)
> > >   {
> > > @@ -3851,6 +3892,10 @@ static int
> > > asus_wmi_platform_profile_get(struct platform_profile_handler *pprof,
> > >       int tp;
> > > 
> > >       asus = container_of(pprof, struct asus_wmi,
> > > platform_profile_handler);
> > > +
> > > +    if (asus->asus_aipt_present)
> > > +        return asus_wmi_aipt_platform_profile_get(asus, profile);
> > > +
> > >       tp = asus->throttle_thermal_policy_mode;
> > > 
> > >       switch (asus_wmi_platform_profile_mode_from_vivo(asus, tp)) {
> > > @@ -3874,26 +3919,42 @@ static int
> > > asus_wmi_platform_profile_set(struct platform_profile_handler *pprof,
> > >                       enum platform_profile_option profile)
> > >   {
> > >       struct asus_wmi *asus;
> > > -    int tp;
> > > +    int ret = 0, tp, aipt_mode;
> > > 
> > >       asus = container_of(pprof, struct asus_wmi,
> > > platform_profile_handler);
> > > 
> > >       switch (profile) {
> > >       case PLATFORM_PROFILE_PERFORMANCE:
> > >           tp = ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST;
> > > +        aipt_mode = AIPT_PERFORMANCE;
> > >           break;
> > >       case PLATFORM_PROFILE_BALANCED:
> > >           tp = ASUS_THROTTLE_THERMAL_POLICY_DEFAULT;
> > > +        aipt_mode = AIPT_STANDARD;
> > >           break;
> > >       case PLATFORM_PROFILE_QUIET:
> > >           tp = ASUS_THROTTLE_THERMAL_POLICY_SILENT;
> > > +        aipt_mode = AIPT_WHISPER;
> > >           break;
> > >       default:
> > >           return -EOPNOTSUPP;
> > >       }
> > > 
> > > -    asus->throttle_thermal_policy_mode =
> > > asus_wmi_platform_profile_to_vivo(asus, tp);
> > > -    return throttle_thermal_policy_write(asus);
> > > +    if (asus->asus_aipt_present) {
> > > +        ret = asus_wmi_write_aipt_mode(asus, aipt_mode);
> > > +        if (!ret) {
> > > +            asus->asus_aipt_mode = aipt_mode;
> > > +            goto skip_vivo;
> > > +        }
> > > +    }
> > > +
> > > +    if (asus->throttle_thermal_policy_dev) {
> > > +        asus->throttle_thermal_policy_mode =
> > > asus_wmi_platform_profile_to_vivo(asus, tp);
> > > +        ret = throttle_thermal_policy_write(asus);
> > > +    }
> > > +
> > > +skip_vivo:
> > > +    return ret;
> > >   }
> > > 
> > >   static int platform_profile_setup(struct asus_wmi *asus)
> > > @@ -3905,7 +3966,7 @@ static int platform_profile_setup(struct
> > > asus_wmi *asus)
> > >        * Not an error if a component platform_profile relies on is
> > > unavailable
> > >        * so early return, skipping the setup of platform_profile.
> > >        */
> > > -    if (!asus->throttle_thermal_policy_dev)
> > > +    if (!asus->throttle_thermal_policy_dev && !asus->asus_aipt_present)
> > >           return 0;
> > > 
> > >       dev_info(dev, "Using throttle_thermal_policy for
> > > platform_profile support\n");
> > > @@ -4538,6 +4599,7 @@ static int asus_wmi_sysfs_init(struct
> > > platform_device *device)
> > >   static int asus_wmi_platform_init(struct asus_wmi *asus)
> > >   {
> > >       struct device *dev = &asus->platform_device->dev;
> > > +    struct acpi_device *adev;
> > >       char *wmi_uid;
> > >       int rv;
> > > 
> > > @@ -4593,6 +4655,29 @@ static int asus_wmi_platform_init(struct
> > > asus_wmi *asus)
> > >           asus_wmi_set_devstate(ASUS_WMI_DEVID_CWAP,
> > >                         asus->driver->quirks->wapf, NULL);
> > > 
> > > +    /*
> > > +     * Check presence of Intelligent Performance Technology (AIPT).
> > > +     * If present store acpi handle and set asus_aipt_present to true.
> > > +     */
> > > +    adev = acpi_dev_get_first_match_dev("PNP0C14", "ATK", -1);
> > 
> > Is there really no way of changing the AIPT mode through the WMI
> > interface?
> > I would prefer using the WMI interface if available, since the
> > firmware might
> > assume that FANL is only called through the WMI interface.
> > 
> > Do you have a acpidump from a affected device?
> > 
> > Thanks,
> > Armin Wolf
> > 
> I found a acpidump from a ASUS device with a matching FANL method. It seems that this method
> can indeed be called using the WMI interface using the DEVS() WMI method:
> 
> [WmiMethodId(1398162756), Implemented] void DEVS([in] uint32 Device_ID, [in] uint32 Control_status, [out] uint32 result);
> 
> If Device_ID is 0x00110019, then Control_status is passed to the FANL ACPI method.
> 
> It also seems that support for AIPT can be queried using the DSTS() WMI method:
> 
> [WmiMethodId(1398035268), Implemented] void DSTS([in] uint32 Device_ID, [out] uint32 device_status);
> 
> Using Device_ID 0x00110019, the returned device status seems to contain the following information:
> 
> - 16-bit current AIPT mode
> - 4-bit unknown value (possible values 2, 3 and 7, maybe number of supported modes or some kind of bitmap?)
> - 1-bit with is set when (GGIV (0x0907000C) == One) is true

I just saw this conversation and i think that the behaviour this
patch will implement in the driver was already implemented in this patch
that got added to kernel v6.12-rc3:
https://lore.kernel.org/platform-driver-x86/20240609144849.2532-2-mohamed.ghanmi@supcom.tn/

this patch introduced ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY_VIVO
0x00110019 which is the device_id that changes the fan profiles. the
naming is not clear because it was initially intended to add support for
fan profiles for vivobook laptops but it ended up adding support
for a lot of modern laptops.


a point that Srinivas Pandruvada mentioned about RAPL (Running Average Power Limit)
is valid for a lot of modern vivobook and zenbook laptops but i think
it's unrelated to fan profiles.

a lot of asus laptops that have intel cpus suffer from power throttling.
for exemple in my case using windows, changing fan profiles will lead to max power
changing to the values indicated in the table below (asus vivobook 16x
pro k6604) which leads to higher performance than linux

fan Profile		power limit
-----------------------------------
Whisper			50watts
Standard                120watts
Performance		149watts
------------------------------------

However in linux, even after changing to the appropriate fan profile,
the power is still capped at 50watts and i found the reason why

here is the results of using the powercap-info command:

intel-rapl-mmio
  enabled: 1
  Zone 0
    name: package-0
    enabled: 1
    max_energy_range_uj: 262143328850
    Constraint 0
      name: long_term
      power_limit_uw: 30000000
      time_window_us: 55967744
      max_power_uw: 55000000
    Constraint 1
      name: short_term
      power_limit_uw: 55000000
      time_window_us: 2440
      max_power_uw: 0
intel-rapl
  enabled: 1
  Zone 0
    name: package-0
    enabled: 1
    max_energy_range_uj: 262143328850
    Constraint 0
      name: long_term
      power_limit_uw: 157000000
      time_window_us: 55967744
      max_power_uw: 55000000
    Constraint 1
      name: short_term
      power_limit_uw: 157000000
      time_window_us: 2440
      max_power_uw: 0
    Constraint 2
      name: peak_power
      power_limit_uw: 200000000
      max_power_uw: 0
    Zone 0:0
      name: core
      enabled: 0
      max_energy_range_uj: 262143328850
      Constraint 0
        name: long_term
        power_limit_uw: 0
        time_window_us: 976
    Zone 0:1
      name: uncore
      enabled: 0
      max_energy_range_uj: 262143328850
      Constraint 0
        name: long_term
        power_limit_uw: 0
        time_window_us: 976
  Zone 1
    name: psys
    enabled: 0
    max_energy_range_uj: 262143328850
    Constraint 0
      name: long_term
      power_limit_uw: 0
      time_window_us: 27983872
    Constraint 1
      name: short_term
      power_limit_uw: 0
      time_window_us: 976


as seen by the output of the command, the intel-rapl-mmio is causing the
throttling as it sets power_limit_uw to 30 watts (readonly). so the current fix
that i'm currently using is disabling the intel-rapl-mmio leaving only
the intel-rapl which sets power_limit_uw to 157watts using this
command: powercap-set -p intel-rapl-mmio -z 0 -e 0

this will lead to the laptop being able to reach it's maximum power
limit.

after doing this, when i change the platform profile through sysfs the
laptop will start behaving as described in the table above exactly like
windows.

in conclusion, the asus-wmi driver already has the platform profiles
(a.k.a fan profiles)
implemented and I think that the power throttling is caused by either
intel Power Capping Framework or asus bios.

I also think that redoing the above benchmarks linked by Srinivas after
using a kernel version higher than v6.12-rc3 and disabling the
intel-rapl-mmio would be a great idea

Best Regards,

