Return-Path: <linux-kernel+bounces-576923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B40FA71606
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 12:46:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E9227A2C06
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 11:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF951DE4DD;
	Wed, 26 Mar 2025 11:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uJFoZpkF"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2057.outbound.protection.outlook.com [40.107.96.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317921DE3C1;
	Wed, 26 Mar 2025 11:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742989604; cv=fail; b=fOPRG2oCHb135RYMj3hHHzS713gPGA/L5cHNb7/+hTtSlJbF6OpBVFj8FedlixSf6SOWocqbrVX8vxqGS2qyvdwYygipbQ42/w5YrUZcxW+RXhVfwUBO2Uv2sWRtx7L376+5oecPhZuXk5zcWADoIWdkma4spRyP5uejJ+p0T2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742989604; c=relaxed/simple;
	bh=11hpVdh5bn4dy4/r9nJLo5zMMjhez9a9z7tJuodgzV8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gaQ1WbnWoAaWDKuIK5xrpaHItRHXwHdwQJXvlsKLFsg0pVj/bOt2DYIqMzOeuu+ZL6p/tA+NU6dvHfn3N7lX8IRfLr5VEu1tvG9wApr6dCnwDnyGOhG0SwfEBp+te7y5O0o7HbrXdYvgmv1jaNrhwS9sYl8uaktWn2hUBvwuTJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uJFoZpkF; arc=fail smtp.client-ip=40.107.96.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j4MrTUyW+CkxowvNzsRL85tgkyUEtgrTVkBisjnNyiDM/IOrS55104laBiGAkG24N12qJg895my/5d2tiTURMmPRquGAlBmbCrvod7ePKToTW3XUvVF/fJGgNOEbb9FFoOM5/o+H/TRkU9ZsaZw+ZLTUyal7REA29ijKz7cNCxvoW9VhOHV1bSZtzycZrguLmnevLK+SQlbZFMb6nnyb+Sea6nvNC/Iz0TQjGTNJ/wULInI+0XeKHrpkKAcyVOOPkeTw0QaIS38VU3BDU6ge/tvHXitBzKT3ueVCiBYEOMA1rFnjfSjglKqfu5uLEmnySRQjL0duG5LSFbP9xGKJQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1nQP7AIcXPzDtxJnRNEzrBPfR4xvcjmBTQT2d/cq2FE=;
 b=KjvCWzN0Fhzw5Qxg7nq1eNohxvKTl6wn3vFoH53Vh1MNbScgsLOn8gUaxtTR88+rNFwMVwQjwAub21oEaejg96qJLrbvUwuJBAe36qlG2Q38DVmjTG4wbUmrOeKaN7V7Br9pR5XhYVzkjwx4jchH0G6AM4Tn0GqNMY/a4SZlmBqQzwM3kCNHa8DWVSe0REL9rP0do/Ki0bNw/dMz4RV9QwkB+2sdfTVHr3HVK1+Ngtv7WFPYf/wpXZKRfxDyxs7djbBVToWY6ghF3UwYMOmPmCMjg8IDtO8M/LfMZzaEmAerUMnAQIhcw5panqyrfvm1ltgEQdkeppONm/HY+ORP1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1nQP7AIcXPzDtxJnRNEzrBPfR4xvcjmBTQT2d/cq2FE=;
 b=uJFoZpkFjdjVlkfSR0clStl9LKIKuL5o9BbM1CovD+O+2dNB0a9OF81N2meaUf5py824R28L/H+CQlhi/G6KLFpiLkPBAWqtUbA16oHX3iOc3wdQC1Yx9zOoRUHL0+WPqiQYXD5nfauyEJWlZrf5jWrz8kOtX86Wd2CAKc7m+Qc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8909.namprd12.prod.outlook.com (2603:10b6:610:179::10)
 by CY8PR12MB7610.namprd12.prod.outlook.com (2603:10b6:930:9a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Wed, 26 Mar
 2025 11:46:36 +0000
Received: from CH3PR12MB8909.namprd12.prod.outlook.com
 ([fe80::b55b:2420:83e9:9753]) by CH3PR12MB8909.namprd12.prod.outlook.com
 ([fe80::b55b:2420:83e9:9753%5]) with mapi id 15.20.8534.042; Wed, 26 Mar 2025
 11:46:36 +0000
Message-ID: <56eebdc4-c78a-4e05-9ed7-8427ae41052d@amd.com>
Date: Wed, 26 Mar 2025 17:16:28 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 06/11] misc: amd-sbi: Add support for AMD_SBI IOCTL
To: Arnd Bergmann <arnd@arndb.de>, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Guenter Roeck <linux@roeck-us.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, shyam-sundar.s-k@amd.com,
 gautham.shenoy@amd.com, Mario Limonciello <mario.limonciello@amd.com>,
 naveenkrishna.chatradhi@amd.com, anand.umarji@amd.com
References: <20250324145815.1026314-1-akshay.gupta@amd.com>
 <20250324145815.1026314-7-akshay.gupta@amd.com>
 <c9138dd3-6a09-47a2-a8fe-716c8894042e@app.fastmail.com>
 <b26e9abc-10bb-46a0-be05-d0cd2ce835bd@amd.com>
 <eedd6e17-b6e0-4e02-8c12-ba835b0dba15@app.fastmail.com>
Content-Language: en-US
From: "Gupta, Akshay" <Akshay.Gupta@amd.com>
In-Reply-To: <eedd6e17-b6e0-4e02-8c12-ba835b0dba15@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BM1P287CA0020.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::23) To CH3PR12MB8909.namprd12.prod.outlook.com
 (2603:10b6:610:179::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8909:EE_|CY8PR12MB7610:EE_
X-MS-Office365-Filtering-Correlation-Id: ec223bf3-a456-4ed9-5c0f-08dd6c5bdce9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SThFZmxMbUVBMmh5dVhBVCtUUHJkUFM4ZkpQSmZWRmc1TEpxbzhVMURMODdp?=
 =?utf-8?B?WkFFdVRHdUhqc3UyQWgzcituVWVNTjJDMEt5ZnE4cG1GdHJFUzhqN0lzcFh0?=
 =?utf-8?B?NlF2eG9sUS9LTlNNTE9LdU9OTVlvSmtkTVlUeVpqRUd3cFpiUDVCUXMxVzJz?=
 =?utf-8?B?anpzUHpLckYvbk1rOGVybitPZ3daMm5GOFR3dkxjT3BUbHBpV21wanRzNU90?=
 =?utf-8?B?WTdJVFNoeFdzc1lDOHZORGViVkx6QURScmdnZ25GYUM4Rk9IYjdwM3NBc2RY?=
 =?utf-8?B?STZnRXNPNjdqQS8rR25sUzZ2bU5HZDZHT2xZRllaK0orNWl0REtqT0M4WFFT?=
 =?utf-8?B?SWVobEx6eGlCdys0MWJ5Mk96UGdmOGdKQkJWcG90N2h0M0pja2RBTDUwNXpJ?=
 =?utf-8?B?K25hQkE0SWRoTk9ZRFdsby80MjhOTlFLcEtIU3NpR3djbjYwUXJXOUYvYXFE?=
 =?utf-8?B?SXVPK0Z2ZjBpK3d4NTg0OGZrVUVDRzRvZUNoY2pmemp3ZkZ1K0lFQzlmYlMy?=
 =?utf-8?B?OUdEWXZBdjR5NEVpMFdLZVZJb1lPQ1NJYnBxOEVvdTdITHNzMklma0hwVFJw?=
 =?utf-8?B?QUtOSXJ1bDBWNzA3TTdoN1h4cGI4NWR1MXhFWlNseGNRUHlEbmQ5YnpTN09k?=
 =?utf-8?B?WDV4bzNTSlBUcCtEZWxDUlJmK293dVNsMHJUREZZeHJMdWF1QlY1Qnc2ZXpz?=
 =?utf-8?B?WGVhU0xEcnBqT1NMU1dWVkJjVER6Z0I1NUVCdjFVRXo0eHAwdE92eGl3ZzI2?=
 =?utf-8?B?KzA0dUE5NFNkNVpnMkhJK1UrNXM2ODBTd2xNWlpFa290SXFRelVueXRSUk1y?=
 =?utf-8?B?dkxiVlNoYzFsQ29NaUFoRlFCU0M3bWdqUDZzOENjVzJwclI3TGlLMWYzSkR6?=
 =?utf-8?B?SWxQZE5yd0xOOFlUTjVKRUFXTm83K3NjSTh0ZHRuYVVlRmN0K0doSkZYS0tF?=
 =?utf-8?B?SStWSkM5VkhOZFZ1UUs2SXl4M0tCZ3pUR3lja3BYblJVeURKeVNMQktVYVlY?=
 =?utf-8?B?NE5VY3VjeHhkVlg1UHRGZ3JNaDlnblpJVjQyOW5OSytlTkw5OTRjcDdzNGVk?=
 =?utf-8?B?SkVwM2Z5NDZvQ1dtcmhQMFRYdEQvM0N4LzZPUTYveTRRdElhT2FFVEEyejNo?=
 =?utf-8?B?a1Y2aTZDM0tLUUdIUzJTcThkRHFORzVBb2lsWDNQYjA5ekJ6Tzh6M0ZkMFE3?=
 =?utf-8?B?NjZDWXpUSXc0RjJUZFIrdjB4MlBTVTdjdVRYMXVUUkx0VitabkduSEVyRkho?=
 =?utf-8?B?MHpwc0ZrVnkwUVRWMzBEcmhIQmRvdnZhNWpjY2RVSks1K2hkTGlNcGd4ZGFU?=
 =?utf-8?B?YVU0S0xOTUEvVHJ5aXlHbDhvZUdIdmxtNVZZRDdOc2pyU0dwUWd1UGdlUTFo?=
 =?utf-8?B?QUppdjZFU05rRTJmUW5WeFdYZFkvWlZacGxWZm5qQXQxZUNuWTVsTzlVS2hn?=
 =?utf-8?B?bXNHblNGbkVmSTZVVnY5YzZha3VQZmoxYTNZRkNLTDdyTnBzMnpYa3lkNkFS?=
 =?utf-8?B?TXNGVkhmMlJpejNoZ3U5VU5FbjhiSVpqZUlWdHlBSFE3MmFNRHFqVFFrZkl5?=
 =?utf-8?B?L1h4OWc5eVp3bE5xRkZLTmNBc3kvZVBSbjJ3NGlTN3M1enkwM1I2SVRNWWZq?=
 =?utf-8?B?N1RvQlByYTRYL0tpRVYzVnByckRxSVNvcHZSdXFFODMrR3JyUHVVS3lkdE50?=
 =?utf-8?B?S1NyRUt1SDk0QnR3NjhiWnZuWjZTRnphMEI0Sk5vQWplbHRjU21SNEg2RTcv?=
 =?utf-8?B?UE1weFB0UkhBT01CdWtrbDZRWXNIcGE2NlVoOVhNU3B2ZEl5ZHlEUmc4RnFX?=
 =?utf-8?B?RlpySzJESU5vSHpsZVFxaUxPS0VoYzIxejhTanFVZzFSYWpxaHBRZ3VsTUMx?=
 =?utf-8?Q?xJFIn5Qgi+2yW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8909.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UmdXREJpMThuTkJCTjlvN1N4Q1NTSWI4ZnozdlRaQm1hU2FFVENBZWp4YWpF?=
 =?utf-8?B?VGNZdnhlZWV5cXBLK3l3MzFwUEwzRXNmTks0NWZ0QytLejVxVU9jelQ2N2dI?=
 =?utf-8?B?R1cvTVZoZzNFT3prTkprSzVJci9WdTdZTnB3cjdNTCtDS2RqZk1iUUdsRjYr?=
 =?utf-8?B?RGNlKy9xT1JjKzUzZ0ttWEhmdlE5c3JlMU1yOVkzemcvRTVRMWZwUHBQOEhi?=
 =?utf-8?B?R0drTEVmaHBsellCSGpPMGRrMExhNGEvaWxqSGtNS29uNlhTaEF2cnduWE5M?=
 =?utf-8?B?NDdPeG9sdnI0b1BXT3Vhd1dtSGdXRFBDU1ovTlg1OU5vUFkzcHdURHdmS3h2?=
 =?utf-8?B?SitIaGF6eUsxeVdpUlRaUkVzSE80SGRaRmM5Ry8xRjk0eUd3VGtzd0tJNStR?=
 =?utf-8?B?amd2U0NNa0llN0dZSE9VM2tmeE9keHNGTzhrNWw5VjVNMHpuTzdBaWRYaW1K?=
 =?utf-8?B?U1pZMlpERmJmbTY4NXVjUDFmWGNJU2VNeUw5QXlQVHdKUytUSm9CdDFZQU9q?=
 =?utf-8?B?RFFrbkwxdHJZeE1GejVWanNBNHdlY1dZTU9mWHZjc2FlaUJLL3VHSVNTR3h5?=
 =?utf-8?B?VlRSRUpNMlRJc3I0OUVtUVBHL1pjenA4bWpCYVc1K2k5U1krb1oxRVJXeUtN?=
 =?utf-8?B?TDFCdzNrdC9jMjVOWEZkUURORWRhSHVtcmpMZzRxOHJNdzc4VjZYTzVHcWdl?=
 =?utf-8?B?QmcxdDVzK0R5dmFDQ3prczRzNUJpbkJQallncTIraGdxNE5hSkkzM1QzN1o1?=
 =?utf-8?B?NFQ3dWt5Ty9FUFkrNXcxNDJBajd4WkpGOHZIS2Zkb1U4Umg4Z0FDNkoxODVw?=
 =?utf-8?B?bFFFandodldiT2VCUnlSUytrREZFa1Q2VFpBUU13c1kwVWlhODhOYmx1NEZ0?=
 =?utf-8?B?Vkhrdy9LNThMeUorNVJzdzdJeEtKYUl4V0pRY09FUkpsR1NPRmZXNnpMQUNH?=
 =?utf-8?B?L2V2UkNUd3Z3dDU3MFdDa1VnSnRvTm5kd2E0cnFiYWxZSlhsY1V1N1hYZTZL?=
 =?utf-8?B?dzNYYi9YQmQ1TkVxWDBQb1dHMjBaZ2JSczB4VkhsWnA0R203QzN5QXl4aFpL?=
 =?utf-8?B?OXlvSFZsWnBHRllpVGFNdnM0Uzd4Q0pPSFh0U25MbkFDMEhISFJqZVhZWXh2?=
 =?utf-8?B?V0lXQTBNektCc0NKeFBZT0lCSjZtS3NLSWRCK25MSExCb2NYNnlQek9UM0FB?=
 =?utf-8?B?MnFRRWFPdHU1SEkxeDlEaGFXNXdUbUxWRzVHbG4wbnhXNjljMzBKS09ud2hC?=
 =?utf-8?B?NnNYemoxVldFZ1BReE1KRDVmZXlHb0FDZjllVTVvV1lGbDNnV2lNT2kxeSs1?=
 =?utf-8?B?eXVZVkxnSHJyVU1TM05QRGE1TC9uYU9CYlh2dlNLajRMNGwwamduYmNaTTRM?=
 =?utf-8?B?TFpBRHhvSnR3R3cwQWpsNW50b3lhcVcxM2tvY0pwS1hNZmhzc0VGbWx4d3E3?=
 =?utf-8?B?Y0FrS0g4Z1lxazdUNnIySkdlRVBOTVkxbHUrcWF0ME1yQ1dSVC9xei8vTVhE?=
 =?utf-8?B?Y05tU0w2QnJua0hJSG5YdWJJbFNkTlFzQnNQUGMrQnhrc3RsQzQzZ2FFZVVM?=
 =?utf-8?B?d05GeHYwMzUzWnNCYkxBS29vWDU3dGpFV091NnR2M1NIajNSM285M3dzMVNo?=
 =?utf-8?B?NHRuK2J4QldnaU52M3ZBOUJhMGpqTjJKaUNpbDB1c0pYV2NyUlNCRUM1Q1RB?=
 =?utf-8?B?Zk5VTXNnaUQ4aFU5bXZLWjZDMC9ncUJDUjJmL0Zpc2k0dS9qN1BTTjg0bUdk?=
 =?utf-8?B?ZGM1c3Q3NitCdndQTGY0K3VjUTRycHcrTXZiUzIwWHZRek5FdDUrSWRJYjFG?=
 =?utf-8?B?MTJ3eE1obHM4TkZ6b21VUEpCZ3I2YTRJbXhBWGtpc0FwL21GUUJ1cHNNeFl5?=
 =?utf-8?B?OC9waFowOHdrWGhzTmRZeGxxeXVkeURFNEpSQzU5RXkxSkM1NDVaY0JKRkVG?=
 =?utf-8?B?OWNWcmpuckJzdDJ0cG52UUxwdHdBcGtML2NIYzNXQWRUcjAyY3hvUjI2Ui9W?=
 =?utf-8?B?KzNBZ2tkY3lhczc1aTVhN2NXa3c1Ym9mTE5QZDVEcU9MV2xFOWNOL29kUFJm?=
 =?utf-8?B?NW1SUThDKy9jSGxQU3RSeS9icFJuRG9hNWtRZG1OSVpScGxjK1Q0a1lkZkFL?=
 =?utf-8?Q?F94HI6zFOG/5gO9csatyDcD6A?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec223bf3-a456-4ed9-5c0f-08dd6c5bdce9
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8909.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 11:46:36.3998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hHwPMjeKRoww9NQFII58KzZrkcWiwTR+wz/lqQGGChg+51U0gGT1cJOL9fmwspzrwZMXTy4z95LKuQcdTnw8rA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7610


On 3/25/2025 7:07 PM, Arnd Bergmann wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>
>
> On Tue, Mar 25, 2025, at 13:35, Gupta, Akshay wrote:
>> On 3/24/2025 9:10 PM, Arnd Bergmann wrote:
>>
>> Link for the documentation:
>> https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/programmer-references/57883.zip
>> <https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/programmer-references/57883.zip>
>> You may refer to section: 5.4.2.2 SB-RMI Mailbox Service
>> At present, more than 70 mailbox commands ids are supported.
>> The number is increasing with each platforms.
>> however, the input and output for all mailbox commands are maintained
>> as 32 bit, hence, we can use the same structure and differentiate the
>> functionality.
> The large number of mailbox commands is exactly what I'm worried
> about. Having 70 well-documented ioctl command numbers is not a problem,
> since the numbers are cheap, but having an unfiltered pass-through
> inteface between userspace and a PMIC is scary, and it's worse if
> future hardware version has additional registers here.
This side band remote management interface(SBRMI) driver runs on the
Baseboard Management controller(BMC) connected to the processor(not on 
the processor itself)
to provides system monitoring and  control capabilities to the admin 
using out-of-band interface.

User space application on BMC calling the IOCTL would invoke a mailbox 
communication between
the BMC and System Management Unit(SMUFW) to addresses the individual 
command.
SMU would return error code: "Unsupported Command" as per platform support.

+--------------------+
|Processor           |
|Socket              |
|                    |
|SMU RMI             |
+--------------------+
             A
             |
         I2C/I3C
             |
             V
+--------------------+
|Driver <IOCTL> APP  |
|                    |
|                    |
|BMC                 |
+--------------------+
>
> A lot of the values reported through this interface could simply
> be sysfs files, some look like they should integrate into existing
> kernel subsystems (scheduler, pci, ...) and not be directly
> visible to userspace.
>
>        Arnd
We have provided integration to the hwmon subsystem for power sensor.

