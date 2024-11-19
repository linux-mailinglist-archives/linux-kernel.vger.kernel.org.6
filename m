Return-Path: <linux-kernel+bounces-414068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E639D229A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 10:41:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CA111F21499
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 09:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4011BCA0A;
	Tue, 19 Nov 2024 09:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="xDgbirBe"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2131.outbound.protection.outlook.com [40.107.22.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FA41AA1F8
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 09:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732009308; cv=fail; b=IyW4+ML7QLqib4p/YvMN/3uHZpEYI5riYEQJEmwftVDGZtwxULXiIGVs0VfspOFoOtR3G7naBgfTEqdMS7iFhPLjlpVXTVsZcjk9QCl0eSJdgHNTsh3YVP89SkaT60qS7SXz74A+EcW7aJLNpfo5ioX1noxxzEuFA/p9d4e0iss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732009308; c=relaxed/simple;
	bh=4zmRwFJr5DtEp1FXwf+BL1VLcSxCaTacVJMpgvHQ0fU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=R/8gqcf+KubtQ20w7EaSHTme31eidKJroNVnx5sjuMX4UKHs1IA55SmI2szpbfGg1hidr5MmLMpHSYJJMcRwwZa6pIPkAui5O94/chIRTlnn4FA3KywZuWJi/qULSsFisyBDwcX/zNbSomRSMPqS1UXxr3upACSZv6MohCyKbmE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=xDgbirBe; arc=fail smtp.client-ip=40.107.22.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GQ/U+HdauwJHY8iaiffbwOgp8s30CXTFJB+znIbxi33hevYUcMEJP6tIzteUQEAkc0c1qRB1T8g14aMbtM6MRTUbInEPcTaRGzeG1Cgb4NawprVgsm/cPOPgAPbOd3Qyqo8MWOUi8zWVXX76tJhNbF+9ojN+Dv/Ns8NIEJ1kOv+s9+sI4IrgqiiVLnr50Y02S0ipjpYEbMS0xOcqCNX7t0oUY8IOgtPuFI5WW2f8bMr4IU51xHnfhJwOVx9h1CnMSkaFkuS+F+oxBwAhz5vUjPW7YHiD2Lwg7yueS3GTmsi8Xjb26YiO/nYuBQuzngPxqUbj05hkrtxgykhU/9OMXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oU32XrD+lPx+l+AD+nDzU+k+1W+R0AWLlwzcQP1sDDo=;
 b=Z3vz6abcSU0JebgZyWyLaLHtXlJSiMgJk33U/Bv8BH6iMYXBg+87uNNjKEj/JhpB6VUHojhB9VVEThOM2WYiDr18UKF8z3vatTLiJF91zWsw7BUMvHOFxkziE1N9L9yUzVZ0RFQt16sdZXaZ0vmCtr3i/MOpogHxlwG3Hov4QRfI2ZRHB6dCiz8Q6cXIhU39NBtlOZZRG31jDHQqZWKOqgmShkRZTd/Ue8ah6cxgF0+gU1EpCZ3OB2uwr67d/o/8ObDbZM3ov9v7IqRPJ/UPFnoq7VvnOgVdMDLrYokU6A1KoyBhdjOvV7edLdsDLDJU0BFdqd1AjcjdqTzm2aOK5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oU32XrD+lPx+l+AD+nDzU+k+1W+R0AWLlwzcQP1sDDo=;
 b=xDgbirBeFswwiDCfGuUNN0G+DOIAXS8Id0MTBJRsaPBIsgBWVrgYHmweUqfviLiYc+7qqOT43zZXHbOp1q2HGJWtpP8Wp1Wyh9ssHZ/wFzzH243HyUadhO8yrVllBWlo9OHTeZIlMIRuZYybZydqXJIpkTttTyWxAC7JlYOYmGTbeEZjCsTYRtXOp0TVDHiHiDsONu34nRJ+jht4BzlrW2Pb9xUkUvxaCOj1Ro/bLUqFEXPvS+u+431WruOWT5MxozFQ201gh649lycDnLwwBqQneJt+Abe7UswNLNMXj1Hzpx67Hg29/TAjlccfPnEPyN2xPIwdSPZttIg3w3MIlg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DU0PR08MB9003.eurprd08.prod.outlook.com (2603:10a6:10:471::13)
 by DU0PR08MB7689.eurprd08.prod.outlook.com (2603:10a6:10:3a7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Tue, 19 Nov
 2024 09:41:40 +0000
Received: from DU0PR08MB9003.eurprd08.prod.outlook.com
 ([fe80::7261:fca8:8c2e:29ce]) by DU0PR08MB9003.eurprd08.prod.outlook.com
 ([fe80::7261:fca8:8c2e:29ce%4]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 09:41:40 +0000
Message-ID: <84510487-9a1e-4431-9443-3dae91d34048@virtuozzo.com>
Date: Tue, 19 Nov 2024 17:41:35 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: Question about vmalloc(GFP_NOFS)
To: Michal Hocko <mhocko@suse.com>
Cc: Linux Memory Management List <linux-mm@kvack.org>,
 lkml <linux-kernel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>
References: <112f93f3-455a-4b89-94c9-d12844d972ef@virtuozzo.com>
 <377a6aef-46a7-4492-a44f-b2a46869a9d0@virtuozzo.com>
 <ZzxMW-AzPY7C27_L@tiehlicka>
Content-Language: en-US
From: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
In-Reply-To: <ZzxMW-AzPY7C27_L@tiehlicka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1PR0401CA0020.apcprd04.prod.outlook.com
 (2603:1096:820:e::7) To DU0PR08MB9003.eurprd08.prod.outlook.com
 (2603:10a6:10:471::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9003:EE_|DU0PR08MB7689:EE_
X-MS-Office365-Filtering-Correlation-Id: b09fdc9e-6f89-4fdc-474b-08dd087e5e8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|10070799003|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WkNYZmZjazBGREwzWHhqTmhEUVpZOXhPV0xwT2Y4eit4TVh0M0hnQk9wc1NM?=
 =?utf-8?B?YVZ5eC9QNXQ5NkJJc044azhqM3dhekpzVEMvNE5iS0t6Z1c0TXpRZFR1Rkto?=
 =?utf-8?B?QU9SeVVxRGhsSUJaQUk0V09HRFp4eTZXbXNlblJROHRwa0graVRLM01RcnlF?=
 =?utf-8?B?YnZhakhnbnNycW9Yb296KzJqMHBhamxIcEliTGg0MXBjNDg1bjhzWkRjaU9l?=
 =?utf-8?B?ZStkRVRzTHZTcG12TERWV25yY0RWOHlQWCtOZWwrd0NhbW5GbDBrVXNsd3I2?=
 =?utf-8?B?UUJnR0NOSFMvUE9CaGNpaXFjUnBWamVpU2E2d1Rva3M5UUIzSEplSm1DSi8w?=
 =?utf-8?B?eVNwUEh5WDFwWTRsejJlREZHSStqR3UySEJ3bE9HM0dmOW1kY3FBTFRUMzFn?=
 =?utf-8?B?QjZxS04zMWdmVENRM3Rpd2QzMFNkSUhCaXE0YkpGaDhIdE5KdFB5MGFNSVFw?=
 =?utf-8?B?bktHd3V3cTVNZC84TTYrMGxvQmJjeWhma0dYR1pTSzQ0NVNxY2JYbHBFVXRH?=
 =?utf-8?B?NmxDL3h3Y2VGNVFmK1RxVlg3NklnTVhKTXhzeHkwaU1QWCtGdFU2MkpOb3l5?=
 =?utf-8?B?WmcwcnBzVE1oRFBzZGJPZEtoVUtpZEFSYmZOZnMrVXJvWkFCdW5oS2VhOUhL?=
 =?utf-8?B?THV6c2Jjb2NZSi9wNHdPRXNQVWRxTVZIUDlqN2ZLeWNvMEp2OEEza1ZmTUdv?=
 =?utf-8?B?S2loUXppd0RqQ2owdmplWFRaaWp6SS80VE5kNXgreEU5ZFRYOWVBU213YW5M?=
 =?utf-8?B?c0RKOVEwTlVZWHgrMnJjdk8veDAxOUw0bU4vTVZkUG55ZmkwT3BsWVcyd1lP?=
 =?utf-8?B?VW0zQWtFRnVtU0FaRzNLbzBLckRIV2pZVVJYV1MwYXVtNENZWTZvRGVCTTBU?=
 =?utf-8?B?SkRGbEtYS3VJblcvakNiTmxtNHhxSU9OQlh4QlF6VjM5U1ZoR0FNWnFUd3Vz?=
 =?utf-8?B?VlZUVlZUQWltRXFzcnArUE10RkFtUjFwVVYwenVuVEw0ajdKbmxDMVBpSnJO?=
 =?utf-8?B?TGpQNmtKdjdQQTF4Q21GdWt4aUVpaStEejFIdCtsREFpM3Y1MklkS0ZjVmZQ?=
 =?utf-8?B?QUtHR3VISzNZMkFiV0FSK3ErQURqK09FMnFRZk5hYVhCdjFxdkhaM3hCS1lR?=
 =?utf-8?B?ejlXejVyYkc4M1hmU0hNZEdLa3BJQjRhK3JpdXJyQTNLNlN4cTBhaUp4U2hy?=
 =?utf-8?B?SU84R2N3ZENiZ0U3STR5YjRtQjlUK1RKRTBXM2wxdWMzK2x6K2dtRFpwMEpm?=
 =?utf-8?B?OUlyeGk5em5GbGNnOEkyZmdYUTE4dlo5eExKT2ZDRzJOai9uSHFqZDBmNlpp?=
 =?utf-8?B?cTBjckF3NWR3T0dUT1lQWmZ4ZlEwQ3pJRUxiZU02dTNFNkhWZFIrdjQ3Z3Bm?=
 =?utf-8?B?YUpvSUVUdEszYXFDTzU5SHR2ZGRWUndzaVRsa3dnbGdjVUVPS0YvSm1BQ0tv?=
 =?utf-8?B?K1BJZnp0V0g4L3NiMTd4M1FtVjV3aWIxNE55L0p1Q1RNYndzZlR5YVpUeGtW?=
 =?utf-8?B?ME9XQlNjZ1FiYTZTVDRFWE10eVZxT3EwRnNERTdvSzA1UXd3SWw5eDYrc2VQ?=
 =?utf-8?B?WS90S2lkTnp6MlNZZktNYm03TG5pMXRySGpLZUZlUkdLWUYwQ0FaaS9MZWFB?=
 =?utf-8?B?a0JiTnlkdkIzMEZWcFFWNjVJSmI0Q29nSWdKeVAwRG5rWW5ldGkweHozWXQz?=
 =?utf-8?B?OFNPdXVGME5yQ1hUbDZCVEZSeUFMbFhVL2NiRWd4eGdsR2tKUmFoOFhDME5K?=
 =?utf-8?Q?WaGg1WvVvUsxh0bJKhJY9tVpIh9X+Ut1UnIxf41?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9003.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SGgyTzZXTUJ0ajB6SWFhMWR3NmFHNEFrY0tWcGJiQktUV0laYTY4VVEzNi9Z?=
 =?utf-8?B?ZjY0M3ZpT3JJc0lITkpxdEFtOWlLOEx2MUMrTzFqUm9ndFhzdi9QcnNxb2Ny?=
 =?utf-8?B?YkIzL0JJdSszSWw1aDE5eUJmNzZGWVVFWmVOVmZ0VENhSFhRQnNHTmhnUFlQ?=
 =?utf-8?B?QXJIc0dyZFpnV2xoaFZmMVJGeGpJNmYyTTUxb24wR051T21TL05RZm1zcFRw?=
 =?utf-8?B?cTUwbEpIZ1BhR1kycDFUMXlGOUQ4WktteHVBY3V5SmRpVnBkNGRZWlA2Q2I4?=
 =?utf-8?B?U3pWSmRvU05ucHpOMDYvUlRTM2Rwa1lzS292QXZTRUNQZU1CQVBOZkRQWllh?=
 =?utf-8?B?ejZ2Z0pyaTRGQVU5T3JDMjh1RzVBUnNXQWlOY2tTUFora1lxWlYveWZMamV4?=
 =?utf-8?B?N0d1RzkyMDRyYTNTaGNXVURsZEkyTkpVc0dXcVpCYkVwdG52RzdnYldlaUh0?=
 =?utf-8?B?YUVjdnhUUGZoRFpNaHNDV0toNWJRZ0haQXNrTVZDbGNod3hsa3IrUXBleUR3?=
 =?utf-8?B?c0RDYzI4TnJhbTVzNm5ITngzUFdBV1FSRWU0Nmt2ZFBueHBCSUt2Y0NZWGw2?=
 =?utf-8?B?c2lIc3dXL2h6SS96c1R0c1BWaFplbTYydmR6bkw2c01tcVJYVTRBQllRTVM3?=
 =?utf-8?B?V3JKeFRNUE5Od3doSGdXcCszaVNxTXR5TVVtZUhYODFzUml6Vk1VdnV5ZWJn?=
 =?utf-8?B?bDJ5dzZnUk9rWXFoSk0rVksxN1dMWkEwNGRTbE9TS2hocjVRbE9OMHJNVkVn?=
 =?utf-8?B?K1MwTVNrdzJyczBFSERrYmZGYWJDeUI3ZTNhY1pxL2NIeWZtL1Vjd1lMVjc0?=
 =?utf-8?B?bVpZUlVzQTZSTW5zb1RKMXFsK0pXK2hpVXVxOW1ENHJhaEt4S0dHVTNXV0Vo?=
 =?utf-8?B?b2FlZTRqb01PVFpyeDZDSTlJdVhmb01CVG9Sc1kvRzNyMmpKVVRjMi83U3I5?=
 =?utf-8?B?dXVzTS9uNGVKUlZPelJIZWFlNmVCcjNzV0JjZlgxUGdCMjJJQzcrWklSbHpW?=
 =?utf-8?B?aWJ4VzUyanpGcStCdzE1b1Y4ZW1JR1Qva2tZcS9xZlhFeUdFcmQ3TGRpRTls?=
 =?utf-8?B?aTc2M3NFc0JaTzNtRWI5UTFORjJrV1lvSk1mdHZlaENITU5RbXF0NzIyWmRU?=
 =?utf-8?B?aUhJaFZPcllVS1NsdmFYL1B0SEE2STREOE84TVVRRjFKQ0cxZEdacEt2MkFW?=
 =?utf-8?B?a1BtdHBqK3p2VXJFYVkvNnFVa282QXFFZGhNeVVsNXI3alhnQUYySG9xQWtw?=
 =?utf-8?B?dlVKM0t5QWlvd0RseWxnWGVLUHBxa0RON1NkUmNNblh2cnFjQk1hOW90QVNC?=
 =?utf-8?B?SWlxenZEWVAwaU5TZFRrU0pVL0dvOFVVWm1TbXcxU0MwK0JLQ092am1sTUNs?=
 =?utf-8?B?aFF2T0EzaEdDYURoSTh1UmxWeDhEaEdMOVV5TG42ZWhtZXorbzREOFg4aFpH?=
 =?utf-8?B?VkZzZzViVFhLY2NsWFB1WGdwRkdpU0wwQXNTYWwySG83MlUrbEc3cWUxOW5V?=
 =?utf-8?B?MXZLaVFqcjVMcVVFbWg0eEtPMXpuZ0Y1eTU1MXhQS29NZi91N3Jod0owYTZT?=
 =?utf-8?B?UGtyalUwNTl4K05qRGRlamdMcjMzRzczQjhqbFRrS1JHMHRoOGI2cFNBM3JX?=
 =?utf-8?B?ZDNyVER0eXRrS1c4ZWdTSXR1N3dEazZCQ0NzRndaTWZEYjFMMjFwa01yKzlJ?=
 =?utf-8?B?MXZ2U0F0OWVOY2dDSlJENDQvRnMvK3lyWlBNQ2JDYlpEZTdGV09TajFDbGlO?=
 =?utf-8?B?M1hpYUFCTzBhR21NTElrRHhOYXBLSkgzVjZCODFsS1JQYStRS0cxTllIRFdV?=
 =?utf-8?B?NEJFblBMei9GQUh5UVFMa1hTS1RxMG5TRlFNMGtoUG1DYmZCbGY0MHNRN3pu?=
 =?utf-8?B?dFJ5TzJ3cE5RRmYwMEE0Q3lnNmhEWFdlWmd5aDB1cUFqT3NETnpyMGRmOXRU?=
 =?utf-8?B?ZGRaVFlYVFpCZzVXakdlNjA2eHJpVE4xaTMvYnplQjNQRkowT1BzYkpGVWFo?=
 =?utf-8?B?cmptZVRHck5wUFNXRGNkU2NZU1FQazlqUXBodkZJRWtpOVpQbEEydlJRR1o0?=
 =?utf-8?B?UHNWMWtyTTlhSE5lUm5WdzlqUjQrcFNHcWJSSFBuSm1ob1QxZVUvK3dCQkRL?=
 =?utf-8?B?TVd6KzhIaW4zdUJrMEVtL0xNWnZLSGgvc0VRTDQ3SHErMlFZamdueG8yMVBY?=
 =?utf-8?B?R3RLQit3OFQ4d0huNjh3WWdjZXJmblZhUytnNHREZVVBSkVDM090NFhsVzN6?=
 =?utf-8?B?VUNmN1hoTTJqdmpMQ2cvcXlaTjVnPT0=?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b09fdc9e-6f89-4fdc-474b-08dd087e5e8c
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9003.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 09:41:40.4820
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3lC5GUYpU7nIDRor4LkE+ggxYwQ5JrVeCJBqZvii/vXLRLP2mm6YRvjv0M9nEfeCFjOwPAI+ji9PXYXoJP3WIcw+hMrgbPDBnZM+mjvVqK0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7689



On 11/19/24 16:29, Michal Hocko wrote:
> On Tue 19-11-24 15:24:03, Pavel Tikhomirov wrote:
> [...]
>> In commit 451769ebb7e79 ("mm/vmalloc: alloc GFP_NO{FS,IO} for vmalloc") we
>> add implicit memalloc_noXX_save/memalloc_noXX_restore at this code path:
>>
>>    +->kvmalloc
>>      +-> ...
>>        +-> __kvmalloc_node_noprof
>>          +-> __vmalloc_node_range_noprof
>>            +-> __vmalloc_area_node
>>
>> So kvmalloc should be safe now with GFP_NOIO.
> 
> Correct.
> 
>> Should we correct the documentation?
> 
> Yes, please. I think it would be useful to explicitly name the above
> commit because pre 5.17 kernels or those who haven't backported it are
> still in same position and that could get dangerous if they try to
> backport [k]vmalloc GFP_NOFS patches. Thanks!
> 

Done 
https://lore.kernel.org/lkml/20241119093922.567138-1-ptikhomirov@virtuozzo.com/. 
Thank you for confirming!

-- 
Best regards, Tikhomirov Pavel
Senior Software Developer, Virtuozzo.


