Return-Path: <linux-kernel+bounces-244306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31BA692A272
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 14:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 564F31C217B6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 12:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEBA580BF2;
	Mon,  8 Jul 2024 12:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="q2g8iXsR"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2040.outbound.protection.outlook.com [40.107.117.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77EA080BE5
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 12:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720441037; cv=fail; b=fpe03vpGyPPXvR7cBjqyyv6qCETa9ZqMoO2VII5FpoBIjsWyMNMpQbZ+2/Y2pCDwKvvfLQmXydtNWALwpkCmcw1+VOFej4dOKSgEoBcYwivVNmz1FmH2/Ghn5wZUlO5mj9X05ITYqD7dWs2EbqFPehhnbiP+tyvjoeQNiKb7ZpA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720441037; c=relaxed/simple;
	bh=HQV+hSshia27DmJBha2HgdRu3z9XgCPUsTAvusK8Znk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ACuleL5Hr77EA51fQNpU8e3ELAGv9uzI76vAjVqOi8ebpiUBLw9Jzlc98wrgmVfsYpJOvOd6krT+4+y63nkxW41Lv/7FPSeTnzPpGsJlHxVTQCgvS+F6U6guaUWsfhXZEAMzkcROtt9owckXj69W+UXfPBP0hVXmAcLa4TPRhdk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=q2g8iXsR; arc=fail smtp.client-ip=40.107.117.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kzwkkyWr8PRWne/2QUwg0fUsKpEA0J98eG2lXiKYCB5IUAl/DPYhDQAa1I54muQxRH+i0sGNHWL6yICWbG3/CAqCXKaAkpna66Y8E9ovNe6PpSv3YfGdfbpC7ZmtlOvyh3rb9XuDcDC+aTKlTtvhHIYBgBKtp+lL9AzMLLrC3mmN+NauK72NkFy2IbTi0t5Bjn/dNwEXRyr2BbZOwKTMRBx6Aj2lZ3c4GkFemLBfScr3lrO00e+NrriCd2i/7+OARd19KM71auMFe+AdkKjrCoKbyNmic0Ifrf61irx12VkPu8QY6yrVRVOmK+5AhcQfl1DlA+yaVaSojYsXMIwpGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RMq1nAdYC5ar9Cc5D5zlPB/7fAy7CYUfl7mmv5Zvz00=;
 b=KxWhTrLGGnuG1P2kHFW92WkblWw0agJqn364rOtaEbQ/9w080kQd+VzIHyWJUsT/3NYFiIGJYW0CXpWQLljs051/LCHac8iG72qs+apX/FEtSmxYc2VH0ZFwnKyB2Yfdz6cHFfHwHZQBXbj12hQgrCVxyb/k3cXic8Ks1kiF4rP9kbjQMlUu8avbKZ+CDn+EzCkIg96aU7qX/tBsRjBpUTpyxOb1ng2qWtG3MXuKz4TYO7MlUIRTgWGtG9rKCf72WrwT83YAfstSHPnClTWNTpkjNgVy4UYUnoazeu+CylbSqyK57CoYoZS8YL2s+7nFJXbYq2eGBBqS1B26ukYZHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RMq1nAdYC5ar9Cc5D5zlPB/7fAy7CYUfl7mmv5Zvz00=;
 b=q2g8iXsR5HAOTRXxkVBt/m3IkKpD3dZQErFb6uRpIDJLBDeeMko2vQ45xkpTv7m3AoZ/b+t9EGZyHw4d2s6iOlpGA+ZFJBpCwpbvrX/J19YmTPUQHd+6NZ4P5kxfpcrcnHn8pHYNED3e++Dujxq/+6EZk+DWdy8UA7Ce8jzvFew3N1FW2THyGL/Sbe/l4PEIFSjFpFY0cfMb0Z8dTWaLW6A0LVdtmMMgiIrHiw0PFUUPGm0buj4Lqxniz+qK9a5u/k9fenmoXVyLx+rt9c66Qu0mkQFpookBjvOZYX1ELIKi1Z8ZYaD5J5fE/QDejnwVBg2Cchx0qo38SA1lLkQayQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by TY0PR06MB5804.apcprd06.prod.outlook.com (2603:1096:400:265::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.34; Mon, 8 Jul
 2024 12:17:11 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed%3]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 12:17:10 +0000
Message-ID: <122bbe20-f2ab-4d44-97ac-76df8469d3fa@vivo.com>
Date: Mon, 8 Jul 2024 20:17:09 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] mm: shrink skip folio mapped by an exiting process
To: Barry Song <baohua@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
References: <20240708090413.888-1-justinjiang@vivo.com>
 <CAGsJ_4yrGR5ULU=MDXZq+hEDb+TWuRkfbg9V9Rg=mGAWOpUkxQ@mail.gmail.com>
From: zhiguojiang <justinjiang@vivo.com>
In-Reply-To: <CAGsJ_4yrGR5ULU=MDXZq+hEDb+TWuRkfbg9V9Rg=mGAWOpUkxQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0163.apcprd04.prod.outlook.com (2603:1096:4::25)
 To JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|TY0PR06MB5804:EE_
X-MS-Office365-Filtering-Correlation-Id: ad022ab4-4b78-4d40-dcf0-08dc9f47e47a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014|43062017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UjFKRU4xV01uMHdmYlZ3bThRVFRXeVZvT29WQXhBTjR1UEI0WUNGMDNUQ2g0?=
 =?utf-8?B?NGs3dUFGeUVLTnkrNzE1YUE1aUhSV0lINlFTSEZBZlNUcU5KUkZ0dWx5TmdZ?=
 =?utf-8?B?S2xWNXFNZi9kRW5rai9jMVpmYVpEelpaWU9TdjRFc0RrMWVsdjVEV1JZcFlp?=
 =?utf-8?B?U0w1R2V1VXlERlNSVUxxY0FZTnUzZEdia2phNHQ4c2dGUWtKeDJ4Nkg0S0hC?=
 =?utf-8?B?Ty9jK2YzdXhpT0xZZTllL2tRS0ZaN0NIanRocFdDQ2FLeWoxSTZhSVZpRTZ5?=
 =?utf-8?B?Q1hCaTM5MGFyMnpWeTNEb1NSa1pDNDZISEVhdU01eFRKUHhKWWFCY2llc3NO?=
 =?utf-8?B?YVN2WUs0UHZxajRCaVlDTllvMXBIaWZrdDdaWnczRi80UjMrMGxta3RHMXRL?=
 =?utf-8?B?ZFFOdUFtSjNjRlR1dDRsQ0pZQUE4ZGFLNWVjTklhdEtML2RFb09Tdy9OVkdW?=
 =?utf-8?B?TmNpVTR4SzVaN1pzdk44YXZxRUpxOTY1TzNHSFJ0bW5QMUJBRVlYNFRhL0pF?=
 =?utf-8?B?SEdBWEVHQ08zTmp2aS83RlVrUVJKQzd2NTJhYzV4d3FDRDJyYnpUYy8zRTcw?=
 =?utf-8?B?OWx1NG9udjdGWGpvWE1CMytiWHFlMXRidHR3OXNtSUllaHk4eGNrRnhpS2lx?=
 =?utf-8?B?aGQ0MFMrSXNSVXRDcDJhckY4ayt0dDBDT1VWUHc0VFAxekRJZkw4czI3M21u?=
 =?utf-8?B?UENyUTFqUFc1TWFreHlwNExpQlZmMjROSkdOUDY1MHRwdWRTRHlrRklERmpn?=
 =?utf-8?B?aGFKTDJKR3Z6YkN5eWVTSTk0bkg2RFZMOWoyU2drRWNzZUhWRlpkRDZ6TytD?=
 =?utf-8?B?cW9Eb00vZi9PSnVDNEZITnFqenBSMmlpZzdGeW1wMG5za095ZWlaNGsvaU5D?=
 =?utf-8?B?T1hrd2J5WDdNcWx0Ymk5SGNwR2N3empJbDJIb0oxc29YVU00eklsK2pKWENP?=
 =?utf-8?B?OU01QThuV2dGRE1YMldCN2VWRmlpMFdhU21XdFFJdi96a0QrbmdadnpkTERN?=
 =?utf-8?B?V0VLV01LRWcvMG1BSkFlNTBlakRIVVR2bVlocGFneStGUGY3V1lDTS9KTTMy?=
 =?utf-8?B?M3RJOGZtL2dvb0pXVUpBd2xpVGJadjZiU1ZxcUh6RUZiUVMzMTByMG5oa2ZL?=
 =?utf-8?B?VmRhMkpHbEVsKzh3Yms4Y2crZmFXeEl2cC82VEljNy96SVBjd0F2TjN6MUlk?=
 =?utf-8?B?S2plL2YyQVZLNU5XNVlEaTNWaXRDZXNRa01xV0dGRnNvK2RGb3ZlV0NRVWNo?=
 =?utf-8?B?Kzh5WTFKaVM0bEhzZUNteG9UYTFRYmhtNmFnblRBWGplK2w0ZUxremprWXVK?=
 =?utf-8?B?Q3BVTnl2Q0plOGU2TjlNS2U0V2dWVnhvRlVLd1M1dEZlZ1VvbWJVNU9mYUx6?=
 =?utf-8?B?M2JFSmxzRHhlcWhZRUtHblFOeU9kMUpHdzhybk5zYnJQZm1vbUo4dXk1YWtG?=
 =?utf-8?B?RWJIQ3ZIS2lBd0ZpV2hIN21WVVlZTDBuQWFTY2JIdElzL1hVK3FEUGh2eU1N?=
 =?utf-8?B?L0FzYUZHd3c4OXA4Q0NUL2lPdkVibThPcDR1aE4yWEhGVHZEaFlFSm9XZEU2?=
 =?utf-8?B?ZDJINWFFZHI2M1AzRDlWQ25Zc1NQUmJLMXpOQlRoQlZEOHh0YnNiWHR3bFcw?=
 =?utf-8?B?SXo5SnNMK01XeFk4c1pWQUc1N2phcVlMS1lXWDFRc3VuTUN1QVhjdWJpeTMr?=
 =?utf-8?B?TWZzUUtCL2hQelI2RHVLb1E3M0VrNzFoY05SRmFScWQybUZJL0t3bUNTZUE0?=
 =?utf-8?B?Rkgxc0Evb2lOa0hOZHV3ekZ4Y0NodjVjbFFIQ1lTczhucE1YUG8xc1dCWHRY?=
 =?utf-8?B?ZEZqTzl1T2pYZGlIRFRMZ0VCSkhwQ0xjeWRLNkRmbHVDajQ3dlkzSlRKcDkx?=
 =?utf-8?B?aXovNXNDcC9TaTlacHBiR0plTlREVWtqMUl2UmdpSTdXajZ0S2hGcUR6anZG?=
 =?utf-8?Q?NYK+2Gfybng=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014)(43062017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZXhncmx5VFZOSEViQTRGWWFzMFRLWG5CMGlZMmFmNWxFKytDTXY5VVIzUTZw?=
 =?utf-8?B?SDFQeE1xK2gwK0dBdjlpWEx6TjIweURKTkptcmEzNGxhSU9EcG1TTFROYXFv?=
 =?utf-8?B?ZXVWSU1kWnFmZHNld25EcDZLbjg2NkhOYXNQTDdqRXZ0eHgxMHlibGJySFBo?=
 =?utf-8?B?bjIwanV4VytlRUhBU29mS0ZYdi9VOHgxYjVvZzd4bFFhSzIrWkpMbWV6U3Q0?=
 =?utf-8?B?VFJoSkVvdFRicnhiYTJ0MWhOdDJQSytHcWRsd3YwSjA3VG1qbDBDQTdrRHZw?=
 =?utf-8?B?TVN3VXFDTkVvcGhOcHVpL01acmdELzBxR2M3dHEwaFExRG9iTDNmdlROU0cy?=
 =?utf-8?B?ZE9QdmthRm1mdjd6MjdMNkF4K2ROSjJJZWtRK01wbzZVUFpZUTJDclNJM0VY?=
 =?utf-8?B?SXcxQ1dtTjU1UXNtRitpb2lhU0d1aHpqc0tBNlNhRkY4aHdzV21ZdDRHazda?=
 =?utf-8?B?bnFXZ29hdFNVa0M2STFSM2doY3AwZ0VlQ3ZCbEg5RDZFL2hlWGF6aUpKeWJn?=
 =?utf-8?B?Q0hQTnV2UHQzdy9CMEkzY0hETS9FWTZIZE5NTGdtMXg3eDJ3SVBhamd6bW9D?=
 =?utf-8?B?enU3MXEyS2N5b09VVlBZcTZMYnpjd0JLQTZhUWxVcm1EbWhvOWJReGx5ajdU?=
 =?utf-8?B?S1dCRmJaUjhsRGEzOG5ZYm12UjJjSE42aC94QnJHNFdTSnd0N3B1bGZtTHJE?=
 =?utf-8?B?TSt6Vmp1VEYxWVBuQWFQeFROd3hOWDBCQ2E5NG9nQnFLUlhndlFzajR5SlRC?=
 =?utf-8?B?R2F3SFhNQWx4ZmpqeHdzY2N5WW9DV09YZ2ZIOU9hMmZpdS9ZVFlhRkRJOVZF?=
 =?utf-8?B?bU44RDR5YmtWZUJjbmpGNFgvblZaZHFoeWxwbzlVZDl5OTBqUHpzc3duYzE2?=
 =?utf-8?B?Y2ZDc0pwdzVKN2l2ekJRQXpvS05MRVdJdnJXbURQS1J4L2QxekJ0ZFpVdWgz?=
 =?utf-8?B?RlY2MzdXdzFxdXBCMmF0VlF5L3lBaTMvRkQrclF4MlV5Tkh0QjRjcUlENzJ1?=
 =?utf-8?B?OEhJa0xkNnVZUG5COU10YWxZMnEzbis1aFVGSGtsQks1cG5JMnlMNC9RVE1q?=
 =?utf-8?B?MzlSZjZEZkIzeGpsODRmbWVuaEpqVFo2MVlEczNzTmN2NXlWcWV5eEZQaWlV?=
 =?utf-8?B?NmJEYlFtVEN1NlBkc1VxaHpoYkRYQXArd25Gc3NSa21jeGcxR3dSSVhETHZG?=
 =?utf-8?B?UWN6Y0hCOERraXM4RXIwcjB0VnEwUzdEQUFKYVNXU0Z4WDJvSk5ubHhYUzNq?=
 =?utf-8?B?bTlkTEE4RUc3MGhaZEwyNUY0NTRDcWtObXB3SWdpd095TnhsQnZVZEovdjQx?=
 =?utf-8?B?d2xrblBtaEh2VXA1MWV3NVFmaVBuWGtYSG5yVlNwNCtCSlNDVFNDK0JlVk1C?=
 =?utf-8?B?TXNRV3hkOFZjWHUyUFNzbFpEZ3lNTjFjdzlpZGtDZzE4T3hVNjhqUkdYNGEx?=
 =?utf-8?B?OTYyY1ozNHhwdXJaQmNieWk3RVhxUlZEcXJNSmM3YWlxN1pGV3Zkc3pmb3hE?=
 =?utf-8?B?RWsrSzVYeENoM1M3bUxzbjhFNXdJajhWcnFjQlVCejFudmxDbWlSUUc0QVRT?=
 =?utf-8?B?M0VuNk5XdU5FLzZwck1SdHZDN0JFZmI0UkRadjBPekN5MFJYMFhSWDB1dXo3?=
 =?utf-8?B?ekpFMVhVUEYxTWJzZHBZVUVla25RRGd4SisrTmZzM24wSU5wSHh1QVE1bHJ2?=
 =?utf-8?B?Ui9ac2s3R2lUNzBjRFdmVWRpTU8rNVJFdDRHRVpveU1RY0lGc0l4Q2NySmln?=
 =?utf-8?B?bVdCUUxtY2s5V01uekRoOVQyc1g5WHV0eEluQWVMaEpaaEV6dTYyQ2k5by9H?=
 =?utf-8?B?L2IrTmJtVy92VGJIbzJUMmdpUlJIbFRYNjhpMXJPNDZmYWpLcThIT3cyNHFa?=
 =?utf-8?B?UFRhOVduREtpYmtNb0VUY1RGZlFOakRhM25jd3ppTkxWOWRCZmprR1lGRjVk?=
 =?utf-8?B?cmx6WjJ6V291SGNzTHpBLzdIcnZZZkh3K05WejNMRlRlaTE3SC9uL3NqRDlj?=
 =?utf-8?B?K2ZiTVNVQmMxVmFDZ3hUNUpUZGlENEw1a3g1cVNsaEVWbEdXdUZMcUV5bEVU?=
 =?utf-8?B?MENVUFlobGVMb0VxQlFydEpoZDVlS0RTNklRUnBnaS9PaUxsTTJmOVora2tt?=
 =?utf-8?Q?JtXtEFmji0phcoq0jv8eMvdQJ?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad022ab4-4b78-4d40-dcf0-08dc9f47e47a
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 12:17:10.5437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3d/aYuz45t3cLpJfdTMuEwhbCfmUpb+5/TiBVFt00ViTEuJH1uGL4aRXbb6gwp/xo39jMaWH49eSqHoxmMWRtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5804



在 2024/7/8 19:02, Barry Song 写道:
> On Mon, Jul 8, 2024 at 9:04 PM Zhiguo Jiang <justinjiang@vivo.com> wrote:
>> The releasing process of the non-shared anonymous folio mapped solely by
>> an exiting process may go through two flows: 1) the anonymous folio is
>> firstly is swaped-out into swapspace and transformed into a swp_entry
>> in shrink_folio_list; 2) then the swp_entry is released in the process
>> exiting flow. This will increase the cpu load of releasing a non-shared
>> anonymous folio mapped solely by an exiting process, because the folio
>> go through swap-out and the releasing the swapspace and swp_entry.
>>
>> When system is low memory, it is more likely to occur, because more
>> backend applidatuions will be killed.
>>
>> The modification is that shrink skips the non-shared anonymous folio
>> solely mapped by an exting process and the folio is only released
>> directly in the process exiting flow, which will save swap-out time
>> and alleviate the load of the process exiting.
>>
>> Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
>> ---
>>
>> Change log:
>> v4->v5:
>> 1.Modify to skip non-shared anonymous folio only.
>> 2.Update comments for pra->referenced = -1.
>> v3->v4:
>> 1.Modify that the unshared folios mapped only in exiting task are skip.
>> v2->v3:
>> Nothing.
>> v1->v2:
>> 1.The VM_EXITING added in v1 patch is removed, because it will fail
>> to compile in 32-bit system.
>>
>>   mm/rmap.c   | 13 +++++++++++++
>>   mm/vmscan.c |  7 ++++++-
>>   2 files changed, 19 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/rmap.c b/mm/rmap.c
>> index 26806b49a86f..5b5281d71dbb
>> --- a/mm/rmap.c
>> +++ b/mm/rmap.c
>> @@ -843,6 +843,19 @@ static bool folio_referenced_one(struct folio *folio,
>>          int referenced = 0;
>>          unsigned long start = address, ptes = 0;
>>
>> +       /*
>> +        * Skip the non-shared anonymous folio mapped solely by
>> +        * the single exiting process, and release it directly
>> +        * in the process exiting.
>> +        */
>> +       if ((!atomic_read(&vma->vm_mm->mm_users) ||
>> +               test_bit(MMF_OOM_SKIP, &vma->vm_mm->flags)) &&
>> +               folio_test_anon(folio) && folio_test_swapbacked(folio) &&
>> +               !folio_likely_mapped_shared(folio)) {
>> +               pra->referenced = -1;
>> +               return false;
>> +       }
>> +
>>          while (page_vma_mapped_walk(&pvmw)) {
>>                  address = pvmw.address;
Sure, I agree with your modification suggestions. This way, using PTL 
indeed sure
that the folio is mapped by this process.
Thanks
> As David suggested, what about the below?
>
> @@ -883,6 +870,21 @@ static bool folio_referenced_one(struct folio *folio,
>                          continue;
>                  }
>
> +               /*
> +                * Skip the non-shared anonymous folio mapped solely by
> +                * the single exiting process, and release it directly
> +                * in the process exiting.
> +                */
> +               if ((!atomic_read(&vma->vm_mm->mm_users) ||
> +                                       test_bit(MMF_OOM_SKIP,
> &vma->vm_mm->flags)) &&
> +                               folio_test_anon(folio) &&
> folio_test_swapbacked(folio) &&
> +                               !folio_likely_mapped_shared(folio)) {
> +                       pra->referenced = -1;
> +                       page_vma_mapped_walk_done(&pvmw);
> +                       return false;
> +               }
> +
>                  if (pvmw.pte) {
>                          if (lru_gen_enabled() &&
>                              pte_young(ptep_get(pvmw.pte))) {
>
>
> By the way, I am not convinced that using test_bit(MMF_OOM_SKIP,
> &vma->vm_mm->flags) is
> correct (I think it is wrong).   For example, global_init can directly have it:
>                  if (is_global_init(p)) {
>                          can_oom_reap = false;
>                          set_bit(MMF_OOM_SKIP, &mm->flags);
>                          pr_info("oom killer %d (%s) has mm pinned by %d (%s)\n",
>                                          task_pid_nr(victim), victim->comm,
>                                          task_pid_nr(p), p->comm);
>                          continue;
>                  }
>
> And exit_mmap() automatically has MMF_OOM_SKIP.
>
> What is the purpose of this check? Is there a better way to determine
> if a process is an
> OOM target? What about check_stable_address_space() ?
1.Sorry, I overlook the situation with if (is_global_init(p)), 
MMF_OOM_SKIP is indeed not suitable.

2.check_stable_address_space() can indicate oom_reaper, but it seems 
unable to identify the situation where the process exits normally. What 
about task_is_dying()? static inline bool task_is_dying(void) { return 
tsk_is_oom_victim(current) || fatal_signal_pending(current) || 
(current->flags & PF_EXITING); } Thanks
>
>
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index 0761f91b407f..bae7a8bf6b3d
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -863,7 +863,12 @@ static enum folio_references folio_check_references(struct folio *folio,
>>          if (vm_flags & VM_LOCKED)
>>                  return FOLIOREF_ACTIVATE;
>>
>> -       /* rmap lock contention: rotate */
>> +       /*
>> +        * There are two cases to consider.
>> +        * 1) Rmap lock contention: rotate.
>> +        * 2) Skip the non-shared anonymous folio mapped solely by
>> +        *    the single exiting process.
>> +        */
>>          if (referenced_ptes == -1)
>>                  return FOLIOREF_KEEP;
>>
>> --
>> 2.39.0
>>
> Thanks
> Barry


