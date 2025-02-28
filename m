Return-Path: <linux-kernel+bounces-539111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66004A4A10C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 19:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06E2B1895F2A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 18:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395931C07F3;
	Fri, 28 Feb 2025 18:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KazD6XY1"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40631F4CA3;
	Fri, 28 Feb 2025 18:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740765670; cv=fail; b=kOKPwLQFI7qgZCKqTUMUz3DMO+l+JT3EORseQ68Q33R3JSP0ad9qT31C6nnf4FykkPOxy9BzxkdjI6IO0k472XA3WBxb+DbEapWBdQMnOobxRBCapWjPeqsJDwMUO1brDGl9vm3YSi02sklrLck2YVhSBZG3Ei+9sj2L8W7gx2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740765670; c=relaxed/simple;
	bh=rdxnwYLUMsdKXnaMKox5ZXlKAoScD171OggPM8zxMt0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rKg9hXQ17pBfTCXDB/JMmHhFfHyvazpQQ3mAizsw21T5BmgZlH/b0XE5XlL8MTzmLiSOTn4o0dfo1e+bh13XS5l9Cb2ZzumJBgojDe+mXl17qd2j809TE+ZIil7G3jlmE3OmyVqsMtrCQVx9PyH5pWC8EQ5NmZmh0t0fWk0dnU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KazD6XY1; arc=fail smtp.client-ip=40.107.94.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=btS1tubpR7nLhSz63B034tYrMdcqqpciCu30ajiz2ej/40ruLmK7Ge4C8a0Qm+JDTlDkXyCGJstNm3vXjXifimXEylaAs7UduAX1wKzBv0D0mM0wWu40MGIiL+fz8M+6lD59mQ0y4rGLEjstwi+9P/PhwXC9Ait6oKBAMYNTlUqMlYjy+Ax08N9A0G4FcpQcu1rpLXsXjXoREnlP5ruEPfDcymKkocctyZKeK8Tj9fHPCmb2a60CLsU0XqOPLT94SG2F/vgeDSvwRsbVO6yCOK8wOuBZXRNiXyvrxPqRrVN/ONWzq6aAfgWcF3ZhubzFDz+LETnJc/03FsuYVJFxZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xc0iu+EKQtPkguz0CVz2oz3P44S963n4ASMkJpyydC4=;
 b=LlIPdmxikk65EJo+j5TZAH4eqdQdYfjAYirNi+q8k9+ZVtUu8rQthvs3ttO1cioFWpPb8r0+mPCfk2nuNRPX+lalrDdICIF6CNeuNMal4mRG9gNcvy2siiEE9xoS1Jv6PrK4Ks1Q6CsjvH1BdviBFwxgzM41Gks7rPAuGqIqFnMbdtikmYILZOBpcIYvrKJ5+jL8R7P59v4Eu/I627zYv5TJJuCe+pknatIkT8wnD/eFBmABIwP8riPP9R3/WoMgOYk2sdRgNfP4+rMSIVOQWeCYxCu7F6ibJxtMfCb1H89fi1H5sVG12kTsAJ7yh4qnAMsfD5VA0dEZhVRRjEE3zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xc0iu+EKQtPkguz0CVz2oz3P44S963n4ASMkJpyydC4=;
 b=KazD6XY1SynNoqfVBCEmhT7q+wFJsGuf3VQrmZ/Qi9TSvewoi0nQ3sW7wWllC7d2dnH642BWKEs7PFuduAmv/jiD+wetSdRdTtgkRpFW4lgUHU4ILF5TY8SB8ANPRF5BHfKDsS8bh/FdM1ZsDbBDK0kZ7VrFQnfAdlA74gTFKFU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH7PR12MB6489.namprd12.prod.outlook.com (2603:10b6:510:1f7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 18:01:02 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8489.018; Fri, 28 Feb 2025
 18:01:02 +0000
Message-ID: <b27adf7b-1618-405a-9036-665c4605e5aa@amd.com>
Date: Fri, 28 Feb 2025 12:01:00 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: amd: Add ISP platform info
To: Pratap Nirujogi <pratap.nirujogi@amd.com>, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 benjamin.chan@amd.com
References: <20250228170238.3484860-1-pratap.nirujogi@amd.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20250228170238.3484860-1-pratap.nirujogi@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR04CA0003.namprd04.prod.outlook.com
 (2603:10b6:806:2ce::7) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH7PR12MB6489:EE_
X-MS-Office365-Filtering-Correlation-Id: d981ee81-02a5-4803-8ea3-08dd5821dd10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TWNpaDFtdG0rM0s2K3U0Qit2T1lMWENlaW11cURSMFV2bFZzUlhXbm51N1hJ?=
 =?utf-8?B?L21YWng2TUNzV09SalhKa2dmU1hwb1AxamlvcGNmN3NUM0wyQ1VoaHZWWFBH?=
 =?utf-8?B?TElCWEhBOWEwSHhlckx1djA5amU0LzYvYjZBYUxtTitlYXlGZkJPRVNYT2Q1?=
 =?utf-8?B?MWJZdFZVb05zS2lpK0t2WERId2hraXJLSjBIRW1xUnVBekw4cnhtalpiYmxy?=
 =?utf-8?B?TUZHcEFpTXQvbVVRR3V1RTB1QWszcisxWkNuSExNU2ljVzE4c1NvY1FVbWJ2?=
 =?utf-8?B?UXZqN2xKMEptUElkM0ZGRzNhelJVMmp5UTFvTWUrYmg4RDFDT1JvTTZGdVJ1?=
 =?utf-8?B?Sy9CN3VINDVHdUJYRFdzbnVQUDcxb3o2QWlSQWVjTVFLOU1BdG9oOXg5cHR1?=
 =?utf-8?B?bDZNaHQ0Nmswb2F0dlozR0ZCNlFWMXgxa0gvMXFlbkZWNFB1NVB6R2RaeS9W?=
 =?utf-8?B?YjhsNWxMY0lacDVnMWg3OTVnaDVzY1M2TkZncEpyU0wxVit4S0tiZHkzOC8z?=
 =?utf-8?B?Zk9RbnRIUjFOSlJXbHJqTHoyZW5ML2VHSWhjZlpoUGR5NXpNRVM3cVF2ZzNP?=
 =?utf-8?B?eVVlU3JYcU5VeEdYS2RDZ280NnpYVTh4YWpmT0gyNkxTOGYyaUc5OVQzL2xM?=
 =?utf-8?B?aWpHeWhMc2lNYXZldGdtRlJ5Z2ZQdnN5aFVYRUdKV2dDMElGd1Q5ZVlILzJ2?=
 =?utf-8?B?NjI1SG5RUnp5VFlZQ2NYU2lFcW1lY0ViT1FtTWxySEJhNjlOdDlyTzJVSk1o?=
 =?utf-8?B?VjR6OXREOWd5ZWZ4Zm95LzVJVFZUeUtIeHkyaktHdUptTERLV0JSemVZSStT?=
 =?utf-8?B?WHJhS0gweVh1bitWM3VpdGY0V3FHRm15VzZwdlRJTW8vS3ZUUEF0bzQ4YnYz?=
 =?utf-8?B?VmoyZVE2bjNuYWY4ekdSNU5Nc2RlTkJqVXZCM09tLzFMbG1aTmpDMktGbWpY?=
 =?utf-8?B?NllnT3NrVkJYV01SbDNzcHN2elRaeHhWK2ZUcWxWRGdmZWlLdDRhamdkQ21w?=
 =?utf-8?B?UkxkY250N1F4Wi9RdXFFODhXeld6ZGp2NzlBTmxSYngweE55WGFmekNkOE9y?=
 =?utf-8?B?VkY3S3ZSM1JRS1I3eGxtS2hZbFRWSnhOMVdlQllLQ3lGMWR2V3N6QWlmZUE3?=
 =?utf-8?B?OUk5OFNiSSs1Z0FqMkRka28ycllLZExMYm84czZ1UlVuMWF3WUZQdkh3Ty9v?=
 =?utf-8?B?eHZSczUxODBqQUtFaTNsRjM3YkNaNkdaVHFxaDdIb2NxQ0k4RXdMTzJONmpo?=
 =?utf-8?B?Sm53dmN3eW9PRXljYm9aOW1WNkdUdTh4U1dOZnRCNnRXU0QxVE9lcGpRS0JP?=
 =?utf-8?B?OUhxVGlRdHh0MnQ3Y3A4V0tYdFROamxkSTZMSkJXN0xiZ1NWRzVzOHRybmho?=
 =?utf-8?B?d2gweU5wQkpQeXU2ZHFVR1dnWndsZHV0NWwweFhDTkN5MDIrT3F5UjU0WVc5?=
 =?utf-8?B?eVhuZ0RnYjRzY1YyTTJ2bzJVYVRJdmZwcjFQbEZpVUhGSFBvUG4zWWdkQTR2?=
 =?utf-8?B?MWdNcFRJSWdFWDBHbncwN3VjMTZzZGh2UFFjSk1UN3l2STdySHRZSWZjNFZC?=
 =?utf-8?B?L2FqQjJ4aEdDVGlneE54eGlZUEtncFNFdmVSYUs3Q2tyQlM2OTM4VnF5VHZw?=
 =?utf-8?B?K2pVS3RHQWo1eTF1U3FiT1R5bWVpWnlDdzl6NTdRSEU2YTdQT3RQbjZQVjZT?=
 =?utf-8?B?Sm1hTExhS3RWd1JKd09mR1d5eVlRc0RwNVNGKzV0ckovOVh3WlNkUUhKMGRE?=
 =?utf-8?B?a0hKM3h6SjZWTGhZcVJTYXE2WnlkdjZPUWI3WDJ1Q3F5Q1hBTXFMNlFiYXE4?=
 =?utf-8?B?RDdUV0FpUEtEcDdWTDJuWWRmc1RiTDR2WEE1bGVTeFRCYmFTU3FVWWVhVTh6?=
 =?utf-8?Q?tJU2p9KkATojk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YjBUd2h0cDgxdmNmOWJ4SnZ2ZjRiSW5IK2QzdWRwZ2RmdGovWjRocWkxNmR3?=
 =?utf-8?B?ZVF3NkFLTEJRcDNRczRHdUYzSUFtQUVsaXZaZlJhSXJ1Y3l0elF6M2h1THFr?=
 =?utf-8?B?aWJxNmtLTyt3SzhGRXEzUHJPUEJUZmRDc1ozRzhvdXRWNm4yTTF4eU4xT29u?=
 =?utf-8?B?bUlXUnRHdU5OODlXZmpKNWFMd3RrUG5SS3luS0d3eHdEempaQ1QrU3BtaGJK?=
 =?utf-8?B?eC9Kbk82aVkrRWljMURBelhzK09LK2VzY20yK3dZZlUyU09ZUkU0YnRsVlFC?=
 =?utf-8?B?bHBGQVJMeEI5Tm5XQXJRc3gwbDNrL2NNWStBbkFFRWNTQ2hKaER1UXNoMEpO?=
 =?utf-8?B?VXB2Tll0Tm9mN0lxMm9oeFdXUUt0citoYkhYbUQremFCcE40NS9QcHZ6VzdB?=
 =?utf-8?B?bTRmUFlLd1BrWW5Sc3czTG9LbE1YbWJXUFNaN3Q4OU54TFpMWTZYNmt1Q0s5?=
 =?utf-8?B?a01qMG93MVRXRlNvNWM1TXU3d2Mvam84R01xbVhjcUZXSG5YN2FYcHJHbkp1?=
 =?utf-8?B?b1ptT0hiaC83SGVwQWhaU1hIUjJPcnRXc1hybjBvU25CRGZIRkxJZDZ4RU11?=
 =?utf-8?B?M3ZSbUVoMURZaEZSaUZSRGMvcFZsV3ErUkdGV1Yrazk4eVExQWo4VmxOOXc5?=
 =?utf-8?B?V3BOaUcwZVlBMjVWNUdRTmxUbFJzbU12dk1NNVl1QWxNT3hKU2V2ems0am9y?=
 =?utf-8?B?ejNibWg4VE5NaUtWdDVMUFpZOFdrUXhYdWFiU1gwOFFzQndjMjR6SGxaeTdu?=
 =?utf-8?B?bkRoQWRkbmZCTitxL0IzN0FlWGNNWkVsOU52YkRBdzU0NUtzeHpHYzdaSVZu?=
 =?utf-8?B?cVlGWk1PUHhTaUlBTWlWZE9BMkZOZHdhTWJ0aDNxcjNQYlFCeUo5LzFObHdn?=
 =?utf-8?B?UlpndjlHcnZuSDRJUkxvbk4xMkV1ZmpTQzFvZWJvYW94N0FMTU9XeVNoUEVP?=
 =?utf-8?B?cm1oZlZZaCsrVVQ5ZGZ2c3ZBd3VIZWc0WUNlS0tTaTN1dVp5bXFLMHQwRWpH?=
 =?utf-8?B?OG1oSEZRdEtTTENKbnF5SUZUeHgweThZV1VRaWdydW0zbkQ3UnRsWWgzanNF?=
 =?utf-8?B?ZmFRSjBXZ0pWVGdKb3hNcFNneDZFd25NZ1A2ZnZDTmpiaGhVTlUzbjFZemIw?=
 =?utf-8?B?ZjdHanJKeHBEODZPVWs0c2FHRmJUdnl4Tm1xeTNvY2FPL3plOWs3WjhvcEVu?=
 =?utf-8?B?SnRWV09sWDRWZWNaa1pidDNWYVRmbXk0OFVWZlJUeC92UE82b0E3SkVBODRH?=
 =?utf-8?B?YjNBOHAwMHZaeHd0ZlFVMnh5UFVrbWRtZ0hLclZRL3o0SlQreWpyYktxTVVv?=
 =?utf-8?B?UFhqNVNFVWZYTzB6bXMrai8vWFJaUU1LcTBpZURwYXMxS21hL0RBak9vSHUx?=
 =?utf-8?B?NGZqbDRNeHZDMFRhdGc1Z29STVZSS05RMVg5dTQrOFlZeDg2VWtXekZ1NWZ1?=
 =?utf-8?B?Y3BXWCtRU2pqMWxWZ1BaaE9UVHljbFkrcDk0NytTQzBpWlgvK2s5Y1JVSVJI?=
 =?utf-8?B?R05ScU1hdDR2NEIxTGcrbXN2c1ZUR0xWMDVNOXFMUXhOdExqUW5QeVpYWEVP?=
 =?utf-8?B?ZmtrR3FzN01xb2NGK1RJYVVuK2hTM21ZUDBnTUJreEIwQ25qa1ZRenZiWTl1?=
 =?utf-8?B?RWxldlI4ejNtODlQUTZ5R3VpMllWZzZjdHUrU25PNGlacDEvMS9uazUrYnVq?=
 =?utf-8?B?ZUs2QzZpQnZlclNoaWs1bHJBdld6QlBKU3RUZy9JTE1GWUJFdzVRbFNOVy8w?=
 =?utf-8?B?UEZOTXFzTk05QWZ4R3gzdjQ4MWNBSE90YzhkdjZWbGExRjVLbjVjai80RGov?=
 =?utf-8?B?UGNYRnM1UVdnMWhxRm9JblcvOENYWS92dVZXdmpEdHZIVHVkZU5VcmhwQ2I2?=
 =?utf-8?B?MVBrTzZpZkNEZE4yczF3TWp4dENOeTdtYW5FZ2gza0NLUElCeEVvWWNsdEZT?=
 =?utf-8?B?RkFZOE9VVW9vd3JPZ2liYTF3MGRIYTMvQ1dqRzd5U3pMbmlQajdoNTBHSkNR?=
 =?utf-8?B?WUtVS0xueW5HeXRnVjhsVDdBSzZUZWVLalNXSlVlSWFVd1VSQ1hKaU5oZHl2?=
 =?utf-8?B?Z0RGM1dCVk5NYmx3K3o4eXloWkhVV1FCOXc0Nm5zYlc3YzA0Rmx2YVNKOHZm?=
 =?utf-8?Q?AiP45Qh0z8We+A6TVh3Udj06b?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d981ee81-02a5-4803-8ea3-08dd5821dd10
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 18:01:02.3947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p0Mh9zGIWbdOzzmvuZIxsGhyba+iLvFS2cfjHour/jYTVR8cAjOFXGEOvzN4UMb7+A7jG0TC3Nx8hfkTV2SCHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6489

On 2/28/2025 11:02, Pratap Nirujogi wrote:
> Add ov05c i2c boardinfo and GPIO pin info for AMD ISP platform.
> 
> Details of the resources added:
> 
> - Added i2c bus number for AMD ISP platform is 99.
> - Added GPIO 85 to allow ISP driver to enable and disable ISP access.
> - Added GPIO 0 to allow sensor driver to enable and disable sensor module.
> 
> Signed-off-by: Pratap Nirujogi <pratap.nirujogi@amd.com>
> ---
>   drivers/platform/x86/amd/Kconfig   | 11 +++++
>   drivers/platform/x86/amd/Makefile  |  1 +
>   drivers/platform/x86/amd/amd_isp.c | 72 ++++++++++++++++++++++++++++++
>   3 files changed, 84 insertions(+)
>   create mode 100644 drivers/platform/x86/amd/amd_isp.c
> 
> diff --git a/drivers/platform/x86/amd/Kconfig b/drivers/platform/x86/amd/Kconfig
> index c3e086ea64fc..4b373edd750d 100644
> --- a/drivers/platform/x86/amd/Kconfig
> +++ b/drivers/platform/x86/amd/Kconfig
> @@ -32,3 +32,14 @@ config AMD_WBRF
>   
>   	  This mechanism will only be activated on platforms that advertise a
>   	  need for it.
> +
> +config AMD_ISP_PLATFORM
> +	bool "AMD platform with ISP4 that supports Camera sensor device"

Thinking forward to a hypothetical "ISP5", since this is "ISP4" 
platform, should all cases also be ISP4?

IE
config AMD_ISP4_PLATFORM
amd_isp4.c
amd_isp4.o
> +	depends on I2C && X86_64 && AMD_ISP4

Doesn't this also need PINCTRL_AMD?

> +	help
> +	  For AMD platform that support Image signal processor generation 4, it
> +	  is necessary to add platform specific camera sensor module board info
> +	  which includes the sensor driver device id and the i2c address.
> +
> +	  If you have a AMD platform that support ISP4 and with a sensor
> +	  connected to it, say Y here
> diff --git a/drivers/platform/x86/amd/Makefile b/drivers/platform/x86/amd/Makefile
> index 56f62fc9c97b..0d89e2d4f7e6 100644
> --- a/drivers/platform/x86/amd/Makefile
> +++ b/drivers/platform/x86/amd/Makefile
> @@ -10,3 +10,4 @@ obj-$(CONFIG_AMD_PMC)		+= pmc/
>   obj-$(CONFIG_AMD_HSMP)		+= hsmp/
>   obj-$(CONFIG_AMD_PMF)		+= pmf/
>   obj-$(CONFIG_AMD_WBRF)		+= wbrf.o
> +obj-$(CONFIG_AMD_ISP_PLATFORM)	+= amd_isp.o
> diff --git a/drivers/platform/x86/amd/amd_isp.c b/drivers/platform/x86/amd/amd_isp.c
> new file mode 100644
> index 000000000000..751f209e9509
> --- /dev/null
> +++ b/drivers/platform/x86/amd/amd_isp.c
> @@ -0,0 +1,72 @@
> +/* SPDX-License-Identifier: MIT */
> +/*
> + * Copyright 2025 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a
> + * copy of this software and associated documentation files (the "Software"),
> + * to deal in the Software without restriction, including without limitation
> + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + */
> +
> +#include <linux/init.h>
> +#include <linux/i2c.h>
> +#include <linux/kernel.h>
> +#include <linux/gpio/machine.h>
> +
> +#define AMDISP_I2C_BUS		99
> +
> +static struct gpiod_lookup_table isp_gpio_table = {
> +	.dev_id = "amd_isp_capture",
> +	.table = {
> +		GPIO_LOOKUP("AMDI0030:00", 85, "enable_isp", GPIO_ACTIVE_HIGH),
> +		{ }
> +	},
> +};
> +
> +static struct gpiod_lookup_table isp_sensor_gpio_table = {
> +	.dev_id = "ov05c",
> +	.table = {
> +		GPIO_LOOKUP("amdisp-pinctrl", 0, "sensor0_enable", GPIO_ACTIVE_HIGH),
> +		{ }
> +	},
> +};
> +
> +static struct i2c_board_info sensor_info = {
> +	.dev_name = "ov05c",
> +	I2C_BOARD_INFO("ov05c", 0x10),
> +};
> +
> +static int __init amd_isp_init(void)

Keep in mind that distros will prominently enable most configs like 
this.  So that's going to mean that anything compiled with this driver 
is going to run amd_isp_init().

With that thought in mind; I think you need some extra checks as a proxy 
to know that you have a relevant platform.

Can you do a PCI lookup for the PCI root port or PCI GPU perhaps?
If those aren't found to match the expected value then return -ENODEV.

As for the 0v05c sensor board, isn't it technically going to be possible 
to have different sensors?  Is it possible to do an identification query 
over I2C to validate that this is the correct sensor board before 
registering it?

If it's not discoverable in some way; I am afraid we will need some 
hardcoded quirks to only bind on the relevant system(s) that are known 
to have this sensor.

We don't want it being registered on a system either without the board 
present.

If quirks are the way we have to go I think it makes sense to also have 
a module parameter to allow it to be forced, to allow any other systems 
to be added to the quirk list.

> +{
> +	int ret;
> +
> +	gpiod_add_lookup_table(&isp_gpio_table);
> +	gpiod_add_lookup_table(&isp_sensor_gpio_table);
> +
> +	ret = i2c_register_board_info(AMDISP_I2C_BUS, &sensor_info, 1);
> +	if (ret)
> +		pr_err("%s: cannot register i2c board devices:%s",
> +		       __func__, sensor_info.dev_name);
> +
> +	return ret;
> +}
> +
> +arch_initcall(amd_isp_init);
> +
> +MODULE_AUTHOR("Benjamin Chan <benjamin.chan@amd.com>");
> +MODULE_AUTHOR("Pratap Nirujogi <pratap.nirujogi@amd.com>");
> +MODULE_DESCRIPTION("AMD ISP Platform parameters");

Should this be ISP4?

> +MODULE_LICENSE("GPL and additional rights");


