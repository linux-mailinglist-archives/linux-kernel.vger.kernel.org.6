Return-Path: <linux-kernel+bounces-439284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 361FF9EAD2D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:57:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0796188D6A7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C212080EF;
	Tue, 10 Dec 2024 09:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="U9ZsYRgF"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2114.outbound.protection.outlook.com [40.107.92.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C8C78F47
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 09:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733824043; cv=fail; b=rcGDzzr4Zh6WtlfeGguxMI9sTPeic2u/YvdKk2Q+UScZJTDQPonnSQ8IQRMmBIXgp7iNJAOl1NDEbQnRel3kHuM4o2KwmsHfmrEPVjk+6/7WpVDf2JgsVhrlF5FiK3Sj1RJL+8W5nbYk/rxodcsgiHfkTAeeIQ4VhfgI/7d2xkU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733824043; c=relaxed/simple;
	bh=UF0sGRxryVlJNrpZ9CmvSvw/3lDcjgQRyarQHP8t7Qk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=X6sKDyK/RsdROSTGJIseypY23WJyI83qNJXUjX2tibg13EfYUe26VY95mYrUij30bLenkSMObSYGrhofkehxVbdD+fJL9GUZ91RgllMbrheTilyijQYBjre3GX8W8BgwX9/vjkpLeVMQP9h7xgEvLyKITeoLTUPDoJluVb5AqiM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=U9ZsYRgF reason="key not found in DNS"; arc=fail smtp.client-ip=40.107.92.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L+0nmYS1SGcbMe6Mw2M1BQcfGnwXnW9SXrgOVx2nxKkNBntcORDENJa60SSJsFd7m+YeDCsx1CnPsjAZBE0BCLsJfo+i9D3u2duhotEv7/lyLGiGX7EBT0AE9+UaVFVX+Ah2D5cp25pWZJrRZAAzhJY6Apofe+KuZOKheSkUJnYSt0Z2an+8oid334/XmMoqgp7r+2g9mn/xF342M1pjLA5MJtTbQy+oOhtJQs0J7u9OFRSC6xFd0ytzLnL3DEN+KtOOx5ilBOxXlT0tXmKrqRzHz8STRrglvQkiWfMioHiSwPboWA7+BYBbe8y4GCytAqVqa9KfWNa4JjPTmpagsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PLpRNpCOEl1Ng9umB3Fm2/UNMtzGSNm6vherY5TgtVk=;
 b=RcJpBFYt3dGjEfcJylKVrRzrgJjB2mQnK+j8X0C1FejvD85XFdfxmA3k7IKFT5JueXFIWRwjzKiQfHywi8anzcyyoo1dA2uEeSNjo1Z1c06kFFmibYlR+/NMInsHVY4zRVdiw9CcubbNej9xdk7Q3Fz1+4f5t1NXI9wZ+1Ksq1QqXZgIzRBkSr4j6lXGDGlpKmhyqtNe7xkjQwPzEz+N6NjbLUQQh0fawE/RW/2DrDZmYWUOENpKP6knkzEagjmdvn6s2MEnOUNbEPIWjqVzRDeuGpRDJejHAXnIaZT3ibY/s0+hPAuU4RYlAL5dgEBKBbpMKOijvJebXkTtDfacaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PLpRNpCOEl1Ng9umB3Fm2/UNMtzGSNm6vherY5TgtVk=;
 b=U9ZsYRgFrOSwC+oJJRaw9k9VOZ8N8Siuj7aCG2B+RKndIaJMt48UnRGtE2FmRCdAca3y/eu8tzsqy7ken0xsU3E7F4Gi4vpikQRAo4CtGfEyXzYDHfL8y2K09BINvI7K59GmQtVN2zGJhIcYlPNGWoyKePI5GtiaMtz1eLTcD3I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from PH0PR01MB7975.prod.exchangelabs.com (2603:10b6:510:26d::15) by
 BN0PR01MB6894.prod.exchangelabs.com (2603:10b6:408:168::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.14; Tue, 10 Dec 2024 09:47:18 +0000
Received: from PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::6926:a627:118e:8050]) by PH0PR01MB7975.prod.exchangelabs.com
 ([fe80::6926:a627:118e:8050%3]) with mapi id 15.20.8251.008; Tue, 10 Dec 2024
 09:47:18 +0000
Message-ID: <808ed933-fbc6-4ace-812c-08170b51d699@amperemail.onmicrosoft.com>
Date: Tue, 10 Dec 2024 17:47:05 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] arm64: refactor the rodata=xxx
To: Anshuman Khandual <anshuman.khandual@arm.com>,
 Ard Biesheuvel <ardb@kernel.org>
Cc: Huang Shijie <shijie@os.amperecomputing.com>, catalin.marinas@arm.com,
 will@kernel.org, corbet@lwn.net, patches@amperecomputing.com, cl@linux.com,
 akpm@linux-foundation.org, thuth@redhat.com, rostedt@goodmis.org,
 xiongwei.song@windriver.com, inux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20241209072020.4743-1-shijie@os.amperecomputing.com>
 <20241209072020.4743-2-shijie@os.amperecomputing.com>
 <d13f1879-7fbc-458d-8fd3-4340b51165fd@arm.com>
 <CAMj1kXFJhFfhy=Gwm=QrdN6XPUd=7SKNKFBF_Z4eQ30r509BCg@mail.gmail.com>
 <0224b253-5eae-4921-a066-308033396a73@arm.com>
Content-Language: en-GB
From: Shijie Huang <shijie@amperemail.onmicrosoft.com>
In-Reply-To: <0224b253-5eae-4921-a066-308033396a73@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG3P274CA0015.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::27)
 To PH0PR01MB7975.prod.exchangelabs.com (2603:10b6:510:26d::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB7975:EE_|BN0PR01MB6894:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b0ab4c8-fee1-4671-ec8d-08dd18ffa272
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N2ZmblJYcGNYMDJWN0orODFwQWF5TE11c05va0lCZlZLamh0NitKZFBkM2lx?=
 =?utf-8?B?VFIrNnRoMGRIU09td1JJTVFFUHhQTVN4ZDBEWkRabG1YcEx4M1R5VVZMOWxL?=
 =?utf-8?B?dlZSa3h1UmFtVU1EYytJUlZDQ0VrZDJNdGFKRnhlejJjWEgySW9KY25jcHN3?=
 =?utf-8?B?bHpMNmpVZUpxNG0xeXRVT3dXS05YRW5QS0k1L1pKVlF3VFQxSkVTbkp6T0xB?=
 =?utf-8?B?b1FxVytUSnJjek5FbnlWNVltdVVZL2t1T0plUXhjaCtXUTlZMnlxOEtjaE83?=
 =?utf-8?B?dStTTnJpY2VTYk1oNzE0Y3BFcm1ab09HRXI3VFpaY2hLZkl4cGFzUDZqVmNI?=
 =?utf-8?B?bjdSSWIyL3VSNGd2cFl0cEpIaXNtVm42SE1IeTlWWVZyQUJEdzlzS0lTZ3Zy?=
 =?utf-8?B?YmdCTi9NV3lOeGN1a054NXlsZUdSQTdPbG9QSFdNRHdJTHFvVkJLalgyeDNq?=
 =?utf-8?B?Tkpsb09rTnpHd0Y0UkJHNktaNXVwRXI5OVVzTmpXd2ZtWXVxSlFOeG5tRDFi?=
 =?utf-8?B?eFkrLy9HV0JrUWlvaUd0K21kUlZxdjRJRHJnMHU1c1RvQklpYWlBQTVNSkgx?=
 =?utf-8?B?aytnUUh0aE1jSmJJTlBQcXlpNnA2VkxpMVhQKzVvUjAxc3FGUHNZdXhwQWww?=
 =?utf-8?B?OXpIekVPRXpIMHdpakFoUWhiZFdWb0VqVlY3U3d6RjBTdVNEVTRkb0l3T0JQ?=
 =?utf-8?B?bGdMZ2RxUHZNcko2TXY0cW04NmVWZUVrejIxZC9GUHRZR1Z0MnV4VUt4UGJY?=
 =?utf-8?B?QmcvQlppMG1Eb3A0ejBWdU5NWitGY2l6QWVlU0k1N29zcllYc2hpTnV3WWh3?=
 =?utf-8?B?RVU2SWRyZzUzbzh1aFZNWGJzTmJWb3hTazQ4ZHJaR0oyeXI1MGhNTCtxTS96?=
 =?utf-8?B?YXZDWmRka0FuMzRKcU5UQldlRlBaYy9pOGRoNUFXamg3RjdxZzJyTHk4cXB5?=
 =?utf-8?B?MlFyVitUdXNFTUtjOWwyUi9QTlN1WXhGYzJTZHZobmx5WVNpcmpZMS9kVURQ?=
 =?utf-8?B?dzNIdE4zVEZkUkZBbVBvNmFDK0hFUkordmRNMmRLeW9xQ2pjZ1YrWURmMnJJ?=
 =?utf-8?B?Vm9UcmZEamViLzE4LzJKYW15bWdETXBMYUg2QmxNZnB5VTM4cGNVS05BT3JH?=
 =?utf-8?B?SnBSUUQ4dGpWaW9zVWFvT3hIUkI5bDVhTlVCc3dPVmlhL1luTFJvTGVFVlZv?=
 =?utf-8?B?ZGVSQW10WmRXWUlUME1Hb1BFeFpES1JoTE9SaVIwaGM4SHkvbDI0NzdRS05M?=
 =?utf-8?B?T3VQUkZCQXFpdGVYRVVBaHFYMmE2WE1SeXlSQ3p5R1pzRGNxcFFoQU9uWlI4?=
 =?utf-8?B?elZoZjA3UGJBT0llWGRpQ0hjQUJQYmJ6RWZMOEp6V2NybWRCd1JjNnEwQnNI?=
 =?utf-8?B?T21nSGFRRDhrcldNZjFPYUYwd0ZhcGUxQUNyWlFHdGJNOGpuZG9uWmpGRzNF?=
 =?utf-8?B?ZE9hUjV6bzhLOUN3Um4rbFZPN3NqYjU5NzhidFVJckdBSFBSaGxnU2EzckFI?=
 =?utf-8?B?aXVTNTRiN3JCRkpVRWJNMVNoeTBQTFl0dnlNalF6aHgxYnZuSXFrMHJWem9k?=
 =?utf-8?B?STJFT2FHRVp0Yi82UElsSHJ3S3VoMkRMN3NPLzgrL3pPQThCa1FsUFRFYVgw?=
 =?utf-8?B?SmZRNndVcmpuMmN3dDB6bkhwaktWR3QyYThIZGp0bEROVHpUV0t0OXJZY1o1?=
 =?utf-8?B?bG0vRkVBSlFwZmRjWnVUTTV3MjB6ckxmZUExcmZibXRadmZsZDBiamtsdEpz?=
 =?utf-8?B?Q29qUGVzdm9zKzBFN3Y3b01IdnZ2aDZCRDJzazdTUU9RT3pZRHVCUXFYa2VW?=
 =?utf-8?B?UTJWMUo1b29jWXE2MVRhdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB7975.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eWovK3hCbzNpYUpNMmZVUE1qUVFzejZiSVhrWnNFbFEvN09TYjZaNlJtY0kz?=
 =?utf-8?B?NW40TmNYVC9RM1BRRndOMGVSdnV3NEtERlJvcERWN28za3ltSTA4VE5CMFBw?=
 =?utf-8?B?OVVxWGlCMWJHVG1laDdnejBLRTFRSXM0MWVQdFlrTHhnQ3Z2N3U4ZHhRcEFF?=
 =?utf-8?B?K0tYNVVHVENlaHNXWHl1NWtmNktEa3FxMmh0eHFBZ3ZNWEhzd0tzaGlSdVJZ?=
 =?utf-8?B?anNZci94WG9BZjk5bnJ5QzZkZ2hUYnlrQm5qSjkwdFRwT2tINkI5ZHl3ck9Z?=
 =?utf-8?B?Z1VEK1JZREhSZE5nMWF5RFVwNy9EQ012ckgvUUtWQmp5czY5KzV0M0VWbFlq?=
 =?utf-8?B?M0thc0lnaXU3NktnMXltajk3S0E4VHp1T3Q1bFprQmdIQ1FxbmljbDhDQzRh?=
 =?utf-8?B?aU5jVlZUaSsxN0p3a3dCZG94WmxuemR2cytsdUpCNXpZdGc2SkpXTHFXRGZ1?=
 =?utf-8?B?cTlGTk8wbHk3dzhQUXlPR2ZNNXg5SHVPcVV1NzJudlRORGJwdzN2WDFlZjda?=
 =?utf-8?B?QkFwMjNCbmRialBjdE44ZEMvNmZYNkJ2Z0l5Sk9mY1BORnp6ZkF6Q24xNVU1?=
 =?utf-8?B?YndCaFg3SGY1RkF0cmtGL1FBKzUvUnV2ODdaK2JRWndERDZTejBld013VEow?=
 =?utf-8?B?VE1VWlJQRWE4VDlVMmJnbUFHNUwrUlR5bzhWZEZ0eGZmR2ZPelcyZlBMcHEw?=
 =?utf-8?B?S2xWa3BaRlNZMlpOdFNtSHUwSGdSSEhQTTB0UFRQdlpYNWlWbXpxT25HMUFI?=
 =?utf-8?B?bUNFQ20zU1ZzMDRGY0FzcVZrMXFCNnFCaktET1RqYnNaUnhYaVZmbDVFK2JF?=
 =?utf-8?B?cERpenhTTkFCR215NnJJejFiQkdQVlNkbWt0aG5DNE5DRi9QL21LR1gwd2F6?=
 =?utf-8?B?cG9EdmVJUkwrY2x3YWdYbWFtN3ZsVVNKY2NGTWJJbGpKdmZmcW1wdjQ1RlZ6?=
 =?utf-8?B?bkNpdnRlcVhCckx1aWRHbUV4WkRyTTd3QUlOT1l6b2VlbURwVGFVZkVYOStU?=
 =?utf-8?B?NWQ5Z2RTdmhxN1VVdTk1dEl5WmdPbnNaR2duOE9KUldUUEhxSFR1dHZxOEhw?=
 =?utf-8?B?OE9QeWdldFV0TnU2QTdWRngxcysyY29CdXUwOCtUVlI4bGVKV04wYjd4SW0w?=
 =?utf-8?B?NVVWQWJrZ0dJWTVTTHIvZkFHTGFIRFU1NFZ0M295dWlyT3FLUlhkZ0Ruc3JG?=
 =?utf-8?B?Z0hmQU1xMUZIMm1tSTRzSjR5Z1ZpR0dPOGdHUWFGVGwzd21CZ1gyYXVzU1FM?=
 =?utf-8?B?V0dmRnNUN1BlZzBYUjZWM1pya0R0U29WbVpuQjBYeERKMDdkY1N6Nk11Y1lW?=
 =?utf-8?B?NGJwYkNkSHlIRUQyUmFJL1FlT2Q1UzRmckthZXZyM09PUGRZY3A4Ti8rODZo?=
 =?utf-8?B?aEQ4TnN1YUV0T0EweEd5c3pVWXV4VlZ6MnNDSUVxZHJuU0E0ditwOTlNQ3Ft?=
 =?utf-8?B?LzAvME01UVp4cHVhbUo0TzZaazJQcjVrVThmN1VwcVRxVmJGeGt4TW9zcHI0?=
 =?utf-8?B?UDFnbzYvY3Rnak1WcUxTVFZXWUtsWHN6ZzRNODk0ZzlpREllck4xTStTVEU2?=
 =?utf-8?B?YXN2TTRnVUhZZ1hLSWY1bUR6N0paUVRKRUEzUXczMjI0RVVUdFdCUEl2VVlR?=
 =?utf-8?B?SWF6cnJySFBTSG5udkNycFVOUWt1TzVlcDdTYk0vdjJhZmdCR1pjdnpkaFFD?=
 =?utf-8?B?UVdVbHRITWtrSmdnZzB5Q2lvSncyU2cwenp0Sk5uakpLVC9rb01tZm5JenYr?=
 =?utf-8?B?TWU1TG9LV2VDb0xEdFNtbUpFN0FkSXMwU0JDRHVlWmJQaGlFWnRqRFFaRFdX?=
 =?utf-8?B?bmxVRVV6ckhkSEdxOUtEVWxuZkVyOFdDMldicHdiRXA0TldXNGh6ZmUzWjI2?=
 =?utf-8?B?TXp2WDV2b3BsMDZ4UlhkVFNiUWg5ZFk1NEhVTnBudEttTERaQm1FS0htZmhm?=
 =?utf-8?B?VVovMG9oRGh2Y1hkc3Fmb1RGamtGWGNOckZkL01yRFdtWUhNRlZGNVVUWXFh?=
 =?utf-8?B?VHAxK0F5dmJBK0Y3ZTh1WGZkczhHNk12MERxWG9VZnk3WlF5T2EvK3Awd1dj?=
 =?utf-8?B?cnJyZmwyL2MzRFF4NnRMdm1vcWFnVjEvTVY5TjJYUnF6WVZtQTNsd2diUFhv?=
 =?utf-8?B?cXhwRGM1T2lUZTdqWTZubW1JRlV4VlZhbFlxN3doa0ljbW1VZ2czb1RORWho?=
 =?utf-8?Q?jGiSZmt7dR6K4YeKNTouyls=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b0ab4c8-fee1-4671-ec8d-08dd18ffa272
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB7975.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 09:47:18.0368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i48H4iCIpo4SKeBk/cTqU04povJ7JoJolM/VOzd4koTratXbr4Fkq5KjuLL+VVXipLtjzUn0e+p1dEeG1nv+1zJnJ9Qwgh+F3rUX7qyBdmQz+1H7yS+57DjgF2MqXgWX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR01MB6894


On 2024/12/10 16:38, Anshuman Khandual wrote:
>
> On 12/10/24 12:51, Ard Biesheuvel wrote:
>> On Tue, 10 Dec 2024 at 08:17, Anshuman Khandual
>> <anshuman.khandual@arm.com> wrote:
>> ...
>>> Reformatted and cleaned up the above comment a bit but feel free to
>>> improve it further.
>>>
>>> /*
>>>   * rodata=on (default)
>>>   *
>>>   *    This applies read-only attributes to VM areas and to the linear
>>>   *    alias of the backing pages as well. This prevents code or read-
>>>   *    only data from being modified (inadvertently or intentionally),
>>>   *    via another mapping for the same memory page.
>>>   *
>>>   *    But this might cause linear map region to be mapped down to base
>>>   *    pages, which may adversely affect performance in some cases.
>>>   *
>>>   * rodata=off
>>>   *
>>>   *    This provides more block mappings and contiguous hints for linear
>>>   *    map region which would minimize TLB footprint. This also leaves
>>>   *    read-only kernel memory writable for debugging.
>>>   *
>>>   * rodata=noalias
>>>   *
>>>   *    This provides more block mappings and contiguous hints for linear
>>>   *    map region which would minimize TLB footprint. Linear aliases of
>>>   *    pages belonging to read-only mappings in vmalloc region are also
>>>   *    marked as read-only.
>>>
>> If linear aliases are marked as read-only, how does 'noalias' differ from 'on'?
> Right, the last sentence can be can dropped.

Okay, no problem.


Thanks

Huang Shijie


