Return-Path: <linux-kernel+bounces-526531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A35A3FFE7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 20:41:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5F963A7D65
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 19:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653FA252907;
	Fri, 21 Feb 2025 19:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="djVfgPls"
Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020083.outbound.protection.outlook.com [52.101.191.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C72D1EEA56
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 19:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.191.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740166898; cv=fail; b=o7zI0BnYs6XJxfnpSDbPQpyQWur0y9UyRZwKQnjnsbjreSfyKh7YqTcwO92UOnZ2IgLJHENCMSEuVX/zSJkZkD4ENdxHC9VgfvNbjjyyEHtXgnEqrbAJx3klRRDbpgzxJgaxOIq0LxFIcEWWPnj4qRFb+81hNNKhGzFD6fKs/Tw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740166898; c=relaxed/simple;
	bh=C3Rbu53CXEuLcg8daSQkqYgZojPN6WPCvm2G1/SBVtY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nyMKr0wipGyKNC+a6cwV5+0dJtyhjGFHXIdKwucLIGhVmqDqvTwRGrbeEfJSp1g1e5H9cSD8Ko+qssA3gibVq8l18s3M2F58YygahY14SWKq41ieHgx5axeL1g3YnJnb4y2p1MX3lh/QI1iMbew6lwm7FgHs6kEs/8bQZhzkH2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=djVfgPls; arc=fail smtp.client-ip=52.101.191.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RgOE+4/h2AGiyf67K2GuBOJP9qDXOjk8hl6nwktQ8DSI/5F367kfP9uVvkMxxHWPZUvSfxrZ9+eJc/kqBMkbXyRGZEI7UOW21KlmgHPAlvZVmhVIb5gLu7HyuTotWN17NZJWoW8uVy/3j+sOMDyjKs7KPE91+ye8Zc4QTqQKw7WUux34GcTO1nsfysor4nEHoxUcLO7L9nsQiIiC+mhyW3S1mi8S82bE58a++1tc7JsxuCi1Znl5224L0iVavzyaqu83xZzh/wo41x1h0RdFhA8tu5MKPmmwU2ixavb3hplF8Z9YuJ9CN4hmFrRk1QRWqjezUmdalBP1xRydKZsxGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6FrSnwt8oTZBksz4x9sgrbu0TkltPjlTUnlVgFxpdNU=;
 b=wPGJY6g3FvcW709itGwmocIUtY6Scr3IrMtNw3+hfcwD1rAJjxlyrYbeDJcuSGArla5l/PF/Amnr5zA+r09yvU+2yf7a47pL+DQFgNKh+8SE5cGt7rPRwFa04rT6G5tIaTr+yUGWoXpPpRojyjg7gQjFBkW0BRnoNPW0FtfpFjHPNbIIBcAtSOW27CZ732piY72VF7G/Nimy5cfnwXoIIV8sAs2cn9c3Pv5EmFdSWweM1JK+OP25PEc/RGYAZVXOPWnMN8QNJHu7m9yvFuUwhRD0VrDdx3eXu5fxTWUyhMXJW6JY1pangzKXDoy+es8jKV3JmbbgEA5nMNy8Yhkf+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6FrSnwt8oTZBksz4x9sgrbu0TkltPjlTUnlVgFxpdNU=;
 b=djVfgPlsRW0jYwcv+zGsDoS0wapGzBBaSm+1PMjNZh/UZkZNLtqobNl2VNGxJH0ATQlWuOo4lSQ/zF6DKW+iIMH6gotGGqGMNZrkXH5ZCBcuTguItwZHi2p2N8iuKlBja4V11eF1+UXTr+4Ma+xapoD4SxssvsOoyZ/Fep4l+1ft1kaZq8T85lVsftOVrqob75t9347c/gajDDqk1nma5DfQNuwCCpl7XmkbzhnuNiwJWLF9ZNIUoFTkxjCOTeacl5IllZV+06ZDgpFzfnSs/h9T5mEx9Gs9662lAZmuI0FG+NVQOOAsiYJpI5Hbk4kLDUhQJ7ZTfV7jd43nIEZ30A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PR01MB8776.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:bb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Fri, 21 Feb
 2025 19:41:33 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%4]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 19:41:33 +0000
Message-ID: <2e634c94-c9b0-40d2-ad51-c91c3ec36382@efficios.com>
Date: Fri, 21 Feb 2025 14:41:32 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] rseq: Make rseq work with protection keys
To: Dmitry Vyukov <dvyukov@google.com>
Cc: peterz@infradead.org, boqun.feng@gmail.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
 aruna.ramakrishna@oracle.com, elver@google.com,
 "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1739790300.git.dvyukov@google.com>
 <0d0e0a0a7136d49af9a8d6a849e1aa4bf086c472.1739790300.git.dvyukov@google.com>
 <f68741e0-0cc8-4faa-8144-e1786b9591f1@efficios.com>
 <CACT4Y+Ym7=9mLS8b=Rq6cyHMgyboMqh15nqkRfgru-qFVTx_0A@mail.gmail.com>
 <cf7af2a8-c004-481b-ad2e-6aa991aacb67@efficios.com>
 <CACT4Y+Z3PCBWDdR5PifXoMBSYJ-cdUmzLRdgbjTUG+A2S8Qq1g@mail.gmail.com>
 <2bcfeb11-74a1-497b-b271-06dfb51eace3@efficios.com>
 <CACT4Y+bu3WtdMLEOj0qFC_MK4G20Joq52Cr8W86Xx4xK3MsB9A@mail.gmail.com>
 <CACT4Y+bKde42MqWsxXD99RZhDZkkNs58kv1H9dxPAh13QLqNEw@mail.gmail.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <CACT4Y+bKde42MqWsxXD99RZhDZkkNs58kv1H9dxPAh13QLqNEw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQXPR0101CA0007.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:15::20) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PR01MB8776:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cbed2e1-340c-4e86-3023-08dd52afbf30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YnhjZEF1VGFoa1ptNlI5MkNya29ienN2TXU4OGlmV2hQald3KzFzWnZXZTdS?=
 =?utf-8?B?Z0g1WFBuYTJxb3JTalpBeWk2NWVHY2pXMU9Jc1ZrKy9VM3grN0t6TDFUaEFE?=
 =?utf-8?B?dnZhQkNQOVVYZTNFRVEyOFdyWGpOS2RxMUdtT0V6WjJRbjRvYTN0dFN4RE5L?=
 =?utf-8?B?cU00eUlSdnpWN0tOejVKb1JMN1RmOExhdHNiMGk4QVY4T3lGbjh2QUp0SitK?=
 =?utf-8?B?Y0luZVZMSy9PSDI2cGR4Q3c1MEdMYWNBdXpicHpIdmFGR1kyV2Z4VXZaenV1?=
 =?utf-8?B?bVM4Q0pPT2lqRGphZ3dJSXVSMzMyWHBGeXg0WXpZZGVmNU1VMElsdXZRWi85?=
 =?utf-8?B?RW9hQ0dkbEFDMVdRVGIyK1J3SDlUdlExcmg4R0J1UnBjVERMNG03WHNvMWY2?=
 =?utf-8?B?WDhlS294U1JZb1FyRVJTZW1lcEF5T05VOThaQUVnQmg0ejV6NkNrVFJ5ekZL?=
 =?utf-8?B?enBYdldtZ0dORzRrMmN4SlJyRUJSbkg3VkpESm15T2RQQld1TWdtODVpOTQ1?=
 =?utf-8?B?VE5yKzhHcFowbE4xUlI1QjZlSkVrWGdCTXU5bGpxWUx4L1RENHhMKzJxcit6?=
 =?utf-8?B?Y2hxK2NLN01YdFRNWXRXK3YwWHpLT2hqcHF6bVJkdHcwMjFrMkEzMlFUYW1V?=
 =?utf-8?B?SUVjKy9LZTc4eG5MLzQ3d1R2NjV5TUVkRnlYT3JDclM1OTR3MFRpR2FJSk95?=
 =?utf-8?B?M2NzdUtpemEwVHlGZzdxMkkvN3VUMks0NENHc2s5RW1ib0sxdnpyUkF0VDVJ?=
 =?utf-8?B?UWJITWhqSjFtMWpCdzlEUEtSaDV2cEJIbHIwc2o5M2lnWHlZajQ1YTRiMVFS?=
 =?utf-8?B?UzUrMm9PRmhZQytJZDR0eTk2NzZuaUYzenFNL2RrRWgrRjFDWENnc2VyMy9Z?=
 =?utf-8?B?UDBGdGNBRXFiWmFGc2JLbW5Vbyt2Mnowbnc2djlaMzYvWFdrc2VqMG9Ta01r?=
 =?utf-8?B?ZGJUWmdFM2dFdC91U2FSMDFSOXNSZUVsa0Q3bnZWN29tQVBFNms2VFRucFov?=
 =?utf-8?B?RVp3a1NvamMxSWpHS2dKM083T09aZ1hab1NoRmpiOGpLUjFUdXp1aGQyL3ha?=
 =?utf-8?B?TitqTGY2bXFzTHFsN0g1eGdMWXE2NU5KOTJTMVVCRjVybkRVemNxMG42TnFO?=
 =?utf-8?B?dkdZN1VTWHA1anpqVVYzbndXWFd6ZmNBRkpReDljWlE1NEtwTkx4Uzc4VWZt?=
 =?utf-8?B?VFdHeDUrRmFqaFArNktmTTd5UUh4L2tab01Ma0thaDV2SG9jUDhmaTlGWkdt?=
 =?utf-8?B?YzJzajQrMEMyMU9aczRTcENuRFZDZXJnNHZmdThEeGdjWmlhWnhhMzRvaE40?=
 =?utf-8?B?MzZzVmFVT1lYbm1IQzJoRVVKdTJCWllKZzAzQ2FXQU9waUlzR1RBUENVby9t?=
 =?utf-8?B?TUozOTFJMjhTbFZFNHVkTzhteGRXZERwOUFPb3h0LytKM1dVRFZaaHoxclhz?=
 =?utf-8?B?aWpvVjFBRlA2aXBUN1duV0JFK3lBSlpmU3ljSlh5MEY4eVpPTXZXZ0VtbzM2?=
 =?utf-8?B?d1hVTSt2WmZkL2RsbmNXei9mRUJLdXNyY015UzBVd01VQkozN2ZwVWwxM2hh?=
 =?utf-8?B?Vm9SYVpnbUgyRTVVVDBqNzUxREZLTk9BSndhdkxLbFhaUUZJSWxGb0k0Zjhy?=
 =?utf-8?B?UjE1Zm0zbUlRcHl5V0xkK1k4L2NVSWx0eDVwVlYrUXJBcDd4Zm55WlMzZzlK?=
 =?utf-8?B?MVZPeGdvdWVkNnAzWnVyNk9JZFlVem85QnJva0dhdUlRaUFFVExTcUkyWEVS?=
 =?utf-8?Q?bkJjMavPiz7eLGHbbDR8W6Gd05wYJldftq7eVjT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WElVcHQrLzFBVlRJSG9xM2FMNmZkSGZIVVpRdk43UkVwTXFwRnQ2MGJVYUsx?=
 =?utf-8?B?aE1LQ3FQV3hsOTZEaWs1MUZtRHRUTWNPbXJ0RG80THQ4Qm00THcwbTNSQUp3?=
 =?utf-8?B?Q3JNNitDS0htSmZSNHFIK2tCbXRHVXk5dWdRcDd2M0QzWkVxeDR0NTdXYTNj?=
 =?utf-8?B?NEt2elFSc3F0bUVjbzJoMTF1YXVGTGxvdThlTk5GY1pNTXFWOVJ5eGV3NlVK?=
 =?utf-8?B?WHA1anlNbDZDVkNvR2l2MWl0aVA2eWQvbmFqRTJjL0NWNXdlTTIwSzBQdjlV?=
 =?utf-8?B?OXAyOGpDQUdUN29hOVR0WW1jVnNkdXg0KzJTekZRUFlhN1luRENoMkFscW95?=
 =?utf-8?B?WVIvYnFQcnFxSWpXT016NTRxcDFJcWt6UUhLMFlXSnZnTVBmN3JUeko4b1pv?=
 =?utf-8?B?UnVoRzhnaFQxWnhhL1ZmdW1wSkZsbEJ6czZ1TGxMbVRFVUhueGdNSHE3cFJR?=
 =?utf-8?B?MGNDSWxoTTIrK09YN1hwMXdra3pnaHFxbDF2TndiaUUybndXUm9Da0ttZ0Zt?=
 =?utf-8?B?WmwwbUdVVm82RlcwQzNOQUpNUVg1U3hyWTFRN2Zmbk43SUkxT0txL2RKc3Zn?=
 =?utf-8?B?akxISk1DWjZ2MVludGl0N3duQlAzV2lEazdxUG94Q25TMUlVZDgxOFR3cmZY?=
 =?utf-8?B?NUcyWjFrY0xpZ0xpb3pjRFljMmN5S2ovUnpyZHl5UWo5WnE2OWhGUk5PaEtn?=
 =?utf-8?B?VmR4RXlPS3BWOFE5eXJHd1FuSTZ6cW9jb09FY05jU3ZIUGtIM2FGVDhXZks0?=
 =?utf-8?B?MlYxWnJlSWs2TkJuL1ZrTlBBU1lQcGVJQ2NuSnZ1RUlVYXBSUDFtdUhyTmJU?=
 =?utf-8?B?VE1QRlZCSEJYenQrOVBXa0lRNmJ5aFBsZzlrUC9QT3BOK2xWbmJoY3lnVEJX?=
 =?utf-8?B?TS91V1pNR2sveHQyNU5adkpTQTczQit6eDM1QXFsTzZERHAySHNPd3RWUmw3?=
 =?utf-8?B?eUR4cTFNU29yRDFhZk9lczYyVlpFWXpKT1F1aW9lSFZYdVZFMEJNdklhOUVL?=
 =?utf-8?B?dVZvQUxIN20zWUZxTzVNb1RKNlpvRVIyaHY0bk91TG0xYStEa3Nqai8vZ2w2?=
 =?utf-8?B?YktDMTZEMHg2Y0ltaHV4aEsvMGl6Rzk3WmtLVi9UbUxNbzZaTldHVndmZDli?=
 =?utf-8?B?NHJlSWFhRUNwdXhOQk9MWHgxQnJCMXZBalErQzdNNHZmYlZUWW9GWmkvL3VF?=
 =?utf-8?B?K3BvcjFuSjFLRFR2Q0RsSGpEcnpUZ3IvWCtSY2UrcUJsMU9WRHJTWVJkczBE?=
 =?utf-8?B?dnBVRUZUMTZhaHBGK1ZLM3hRWlZDd2Flb25FbFpXcktxczc4MW1NMmNEelFK?=
 =?utf-8?B?bzhoYXNYMVhsRjQ2Yk5NZlRSS0dLcUEzSEFJYjVPbkdheDdpQkhjejRmdGlG?=
 =?utf-8?B?Z0U1aW5UbDBoYXlnajV3RTZjYW90MDMzVmhoUkkxcENpVFpnRkFTMExqS045?=
 =?utf-8?B?TklObFhUZVFxeTUvYktWOEVuUVhWS1h4eTdNZ2JUMGRXUjhPV3ZyQzRPa0Rp?=
 =?utf-8?B?dE9ER2liMmRpd3c5VDcvYmFKaXU5VWFSWnVBcmJzRUd0ZEpHZ1VCSE11eitG?=
 =?utf-8?B?Q2JqcWZLYnpPZ0M1aVJ2aXVoM1crSUZSUDBNOUw5cUxxN24yZ1BqWTgwNnlo?=
 =?utf-8?B?WGdCWjB5SmhUSnhSYksrRXo5Q245d3pGbjMyL1g3WkpHWWNvbEJHclpHV3VZ?=
 =?utf-8?B?VU5BdVRMZ2dFd25CR3ZZK2tvajBHTDVqMVV5MTlXVFFNV0t3TWY4MVgzUWhN?=
 =?utf-8?B?WU5RUlZYaTBtbW1vYlNZOEJBQW55VU42T3plazh6bFBIbDlTeUtPOFlOZnRJ?=
 =?utf-8?B?NXBvdFJzeXd1b1VjWis4bWlIUGV5N2hLajhjWVNnZndsMFpHb3dZZUVBNDJq?=
 =?utf-8?B?dWhJTmdoYW5QTUlmaXY1aldTbmMwcnYxeHlXVW9jR1pBaVZyNWtOOEVYTitS?=
 =?utf-8?B?dkZlM0Vxczd1QjlRenlNVUJJRmhEempYakd3RUVFSVFiZ2JtWVpVVm40Ym5p?=
 =?utf-8?B?b3RWQzhYdHZNSEVNUGF6Z1RnV2tDSHdhbHJSNmxzNnF1eGpKU1JIRk4yQ2ZO?=
 =?utf-8?B?MVowdlRLbWF6bWhYbzVZUGlQeThoaVduUFRPM0JRbnp0MkFPU0o5bC9jdnpu?=
 =?utf-8?B?TWpaZ2dMN1VWWVUxZi9UYVdNaHo4ZHhOdHdZTjFMd2VwMWo5a1BidnJRSXpu?=
 =?utf-8?Q?CQ2we1D6yBzmf6HOEMKQNsg=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cbed2e1-340c-4e86-3023-08dd52afbf30
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 19:41:33.8253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iLiNJBQ4jpjfMEGHmgwxO3ijcCtth2eWqPkx2ZKhPqXOlfQ1AuzYbuvdvAGNupuTIFrHpM7tP5HbP1nbt+cgWlsn9HpkCl2ktMURxA0A5/o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB8776

On 2025-02-21 06:22, Dmitry Vyukov wrote:
> On Tue, 18 Feb 2025 at 16:37, Dmitry Vyukov <dvyukov@google.com> wrote:
>>
>> On Tue, 18 Feb 2025 at 16:27, Mathieu Desnoyers
>> <mathieu.desnoyers@efficios.com> wrote:
>>>
>>> On 2025-02-18 10:10, Dmitry Vyukov wrote:
>>>> On Tue, 18 Feb 2025 at 15:57, Mathieu Desnoyers
>>>> <mathieu.desnoyers@efficios.com> wrote:
>>>>>
>>>>> On 2025-02-18 02:55, Dmitry Vyukov wrote:
>>>>>> On Mon, 17 Feb 2025 at 21:21, Mathieu Desnoyers
>>>>> [...]
>>>>>>>
>>>>>>>      we still let this function read the rseq_cs.
>>>>>>>> +      * It's unclear what benefits the resticted code gets by doing this
>>>>>>>
>>>>>>> restricted
>>>>>>>
>>>>>>>> +      * (it probably already hijacked control flow at this point), and
>>>>>>>> +      * presumably any sane sandbox should prohibit restricted code
>>>>>>>> +      * from accessing struct rseq, and this is still better than
>>>>>>>> +      * terminating the app unconditionally (it always has a choice
>>>>>>>> +      * of not using rseq and pkeys together).
>>>>>>>
>>>>>>> Note that because userspace can complete an rseq critical section
>>>>>>> without clearing the rseq_cs pointer, this could happen simply because
>>>>>>> the kernel is preempting the task after it has:
>>>>>>>
>>>>>>> 1) completed an rseq critical section, without clearing rseq_cs,
>>>>>>> 2) changed pkey.
>>>>>>>
>>>>>>> So allowing this is important, and I would remove the comment about
>>>>>>> hijacked control flow and such. This can happen with normal use of the
>>>>>>> ABI.
>>>>>>
>>>>>> Thanks for the review!
>>>>>>
>>>>>> I've addressed all comments in the series in v2.
>>>>>>
>>>>>> I've reworded this paragraph to simplify sentences, but I still kept
>>>>>> the note aboud malicious rseq_cs.
>>>>>>
>>>>>> If we would not be circumventing normal protection, then, yes, these
>>>>>> cases would be the same. But since we are circumventing protection
>>>>>> that otherwise exists, I think it's important to think about
>>>>>> potentially malicious cases. In this context inaccessible rseq_cs
>>>>>> values that resulted from normal execution are very different from
>>>>>> malicious onces. Normal ones will point to a fixed set of real
>>>>>> well-formed rseq_cs objects, while malicious ones may point to
>>>>>> god-knows-where in an attempt of an attacker to do things we can't
>>>>>> even imagine right now (e.g. rseq_cs overlapping with protected crypto
>>>>>> keys).
>>>>>>
>>>>>> It's as if a particular instance of copy_to_user would allow
>>>>>> user-space to write arbitrary kernel memory, and memory of other
>>>>>> processes circumventing all normal protections. In that context we
>>>>>> would need to be very careful regarding what we actually allow.
>>>>>
>>>>> I'm considering that we should clear the rseq_cs pointer whenever
>>>>> userspace issues pkey_mprotect.
>>>>>
>>>>> This would ensure that no legitimate scenario can trigger a load
>>>>> from a rseq_cs area which has the wrong pkey, and therefore we
>>>>> could accept read/write from/to a struct rseq which has the wrong
>>>>> pkey, but kill the process if trying to read/write from a
>>>>> struct rseq_cs with the wrong key. This would prevent userspace
>>>>> from making the kernel read/write from/to memory with the wrong
>>>>> pkey through a pointer it controls (rseq_cs pointer).
>>>>>
>>>>> Thoughts ?
>>>>
>>>> I am not following.
>>>>
>>>> There are pkey_mprotect calls, then independently installs on rseq_cs
>>>> pointers that happen concurrently and after pkey_mprotect, and
>>>> independent set of pkey_set calls that happens concurrently and after
>>>> the previous 2.
>>>> I don't see how doing something at the pkey_mprotect call for the
>>>> single thread avoids any scenarios.
>>>
>>> Hrm. Sorry, I mixed up pkey_set() vs pkey_mprotect(). What I had in mind
>>> was actually pkey_set(). And that would need to clear rseq_cs for all
>>> threads belonging to the process, which may not be straightforward
>>> because those could legitimately be inside a rseq critical section.
>>>
>>> OK, let's try another approach: rather than kill the process if
>>> read/write of the rseq_cs area with the wrong key fails, could we simply
>>> clear the rseq_cs pointer in that case ? Technically there would be no
>>> legitimate use of this except for the case where it is meant to be lazily
>>> cleared.
>>
>> This may work, but 2 concerns with this:
>> 1. We don't know if the failure happened due to pkeys or not (at least
>> not easily), and I am afraid of touching the logic for other failures.
>> If the rseq_cs was a bogus pointer, or protected with normal mprotect,
>> what does it mean? Are we masking a programming bug? Are we
>> circumventing some other protections that were supposed to lead to the
>> process termination?
>> 2. This will complicate __rseq_handle_notify_resume() logic as it
>> would need to handle failures when accessing rseq and rseq_cs
>> differently (+plus there is signature check). The more complex the
>> logic, the higher chances of adding a bug now or in future.
> 
> 
> Do you see any problem with the current code? What exactly is it?
> If not, can we merge it as is?

After discussion with Dave Hansen, it appears that pkey is not really
meant to be secure against a malicious actor nowadays, it's more a
page protection tool that helps identifying bad memory use.

So I don't think we need to care about the security-related concerns
I raised above.

Please see my comment in reply to Dave about making the code simpler.
Once that is done, please send an updated patch, and the rest should
be OK.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

