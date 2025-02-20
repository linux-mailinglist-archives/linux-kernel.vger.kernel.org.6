Return-Path: <linux-kernel+bounces-523948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8FBA3DD42
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:48:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EF673A81E5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 14:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F401FBEB7;
	Thu, 20 Feb 2025 14:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="d4GpN4Xo"
Received: from YT5PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11021112.outbound.protection.outlook.com [40.107.192.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6FD13BAD5
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 14:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.192.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740062572; cv=fail; b=q/MOUgEBwkhJUTFX47QVNvTwZ/9e33+ZWnUosYYtZJq+riB3Hewn5NXOJyqImoylmDRPNPwOPAjXxWPGHwY0eBFSku4Qen7L2aAjZQhENt4pRFQBkLKv36BqgaqHX7vYZO3XQH8zfiiWKvjr0FwHhwbO6bBnlwA3P6jw0iQ6S+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740062572; c=relaxed/simple;
	bh=tQRKToSefQlmcNb2pv5NZhW/ProHSqRsnbTRR+tVDFE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RX980oIJ2J0BfuTnsXRdj0kGdYWEQeG3Wq8I+DyXCb4Fag8gy2IDSBpJw0hr3JwDoa9GLtklO5TcKjW9Hneq/a9YoYVPe3hdvYxdtCSS1bncBPEGDFvL+21KuChVpLcUMbMJQQ+GzVH9GuIbeE9HmC02NJQ8gc/9J/H/CrVXPXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=d4GpN4Xo; arc=fail smtp.client-ip=40.107.192.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UPUkI+v5LPYBQDKW5vCwaq9xQloJPWpVvVCC+o6KaJ9YcTg3AJxXAEkKIJkXNKr8IR/MPUstXeS3YEUguzgCUCS32osNNHTtKw5YFq9EcIMExRMRSVJ+FiEklncxQllRhbHrgUKryeQ6D/NiXn0OyNoBdxVEMWV/+5XpcPlVbMHu/6fprhXH1Ie2VvGrmyvRIw8NBDUSTrHpQQHpSEtJx/wdKtRIgRWu0mFbmhJH7b9l6M1CiukoYvN/iVOquz46EgePPrp5cYSUYZuu2K6cjuubmdhNppe7RyAjkO5TRsOo42nloTlKXDz0Q0gvh3C5r0Pf1cYckCDClTsR0Ca7Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XH9TOeiEUhPxuoWrIhdBKFStCDn39PTdcdcvz25O/VE=;
 b=B+WdOmap4mTNnr3SPUvzXGaymJMco+OhCz4GX+00cBxKzLDEa94XJRiuAuVa8EjD+y3GK90NFivfudqiS58zu176g3AL19RE28YN3NqIV8nmZOFIfkpBQYV8MlFa4icKvxit3lVqwqKp3yWQrktP67Ibcl+5EXhSuHhYxS7vMBd6Th/oaJ7AdX9/8i650LJoMG8IL1Euh5sTyfqwXdCI5affGlx9kLM6TCDgKp5gIs3d5d31CAaKNeaOdRsbyi7J12sIKWdusjJICSD6dmTnPX8vDVQOzyo/gBQENPGzFTRPBtFFRS5Bpbcco0ZjmJL8D26dSZEnetFGJ0iKCiA4Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XH9TOeiEUhPxuoWrIhdBKFStCDn39PTdcdcvz25O/VE=;
 b=d4GpN4XoBNi3BnGbHGA26CQdbzzbDYup0MOaTqhRfJy1nhAiCjToQs75Qhy7fHqv+WJm21qDlvhKUeUtbTO5m1BHgbM+gZUiPL4CaUVDJUyzE+4BHpifLIfBp8fjEtgu9SwRK0rHBUPTGNGc4oeaqpKdNWvjqjCmoUSkZOaG6/+/RUqZG+xegQFSiDxeO1NKknkt8ygdQ63vEWVem4/Dyyqnw7vSB1/ksLPaRIL2cjI9b+f8HvLlZjICPYJ8B4fXoUKPYj2p/XaWkwRfyDNGoaUby3cifc2ZGOw+c4Sm2QzzIaPo4Y8l1OMdu+393Yz2cNs/zqemNasYMmUC0FWWyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQBPR0101MB8367.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:52::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.17; Thu, 20 Feb
 2025 14:42:47 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%4]) with mapi id 15.20.8466.015; Thu, 20 Feb 2025
 14:42:47 +0000
Message-ID: <c9026605-da1b-4631-b0dd-68ae0700ec87@efficios.com>
Date: Thu, 20 Feb 2025 09:42:46 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 1/2] sched: Move task_mm_cid_work to mm work_struct
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, linux-mm@kvack.org
Cc: Ingo Molnar <mingo@kernel.org>, Shuah Khan <shuah@kernel.org>
References: <20250220102639.141314-1-gmonaco@redhat.com>
 <20250220102639.141314-2-gmonaco@redhat.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20250220102639.141314-2-gmonaco@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQXPR0101CA0051.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::28) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQBPR0101MB8367:EE_
X-MS-Office365-Filtering-Correlation-Id: 2619410a-399f-4581-79ba-08dd51bcd7d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R2Z3UTFCdFNqWUoycGIyMEN6OXZEYklpUyttampCZkNJQ0NrUStkSkFIUGRM?=
 =?utf-8?B?aDJ6Q1VUb3pUelpGMmVLZlpHN3ZsazNXNCtxaWdPbGQvN0xpbE1wMVhKd0pp?=
 =?utf-8?B?bTZBZ0RCa2k1TEttVnoyUCtTUkdTelltZjZEOE9RMTZtWVBML01nMlFkSllG?=
 =?utf-8?B?OTBKNVBRamRmM3oySnJNK1dDekJWTFduZWtSNEljNG5WTlFjVUVMY2Uxdkhv?=
 =?utf-8?B?cVpHSUdnMFRZQUw4MGQ4WjVlL3FHcVQxaXYwb3QyQlFRTmllMDMzMTNjYm5M?=
 =?utf-8?B?ZUdzVGdoZlFRYk8yMDNqcEFyeG1rUlE1ejQwdUlkSlJ4NXFrN0xkYkhtWXh4?=
 =?utf-8?B?RnkyY1N2OW5TNEJpekJLU1ptNzNXMUQyWEtFY0hRUm9IWkxZU1hvZytOd1F1?=
 =?utf-8?B?Q29kbWNBYWJKOEc4K2tjSWRHYkk0a2d1Q0liQm13ZmRXWjhZcS9VcHcxVlhI?=
 =?utf-8?B?b0dlc0RvVWdOMTBYYzdGUFdsVC8rK0YvdHgvamFrdkpxMXAwQW56YlFPSFdw?=
 =?utf-8?B?UWQybXJnWkFkSzF3OUs3L1JNNUJOVlhWRVlmRS9yOHdUdit1cG9JQjl2VkZh?=
 =?utf-8?B?bU40RElQYUdmM1h1ai95K3NuZE4vcUNtZ0FZUEdybWU1SHFSTHJ5Z1VoYlFF?=
 =?utf-8?B?RnFsVW5oMEpocHVUNkxIZ3BnZnRJcGtkeEd5bUdxc1l4NmJ6WXEvS3Q5U0l2?=
 =?utf-8?B?QU5ud3ExdTNPcVBPODBTTGRQY0Y4VEFYVmptT1FHV1BjekNoZDhPZ3hhR0Q5?=
 =?utf-8?B?UWVObU8xNkxVdjJqaHEraUc2M1A2SkZpcElUWmo0dlJTS2dlMU5UR3ozQ0lz?=
 =?utf-8?B?UW5FTVh5dGpWcS83L1RPczN3TGh1dGdGWktMVExMN0g1N3d0eDE0N0JQMjla?=
 =?utf-8?B?R2VvcTVjY25UTlc5eUpycllOMWdJSXo5Z3BmZUJpNUVkem9NREdsaUoxeVJF?=
 =?utf-8?B?RER4Y2I3UFFMVmNXMzVOWUN3QU5uRWJLcU04MkVRb3U2VlVGSC9xSmVsV1Ja?=
 =?utf-8?B?djQzanJMbERQZVpNbTcxVkJGblZBRHJhUFJabUQ5STdiVGw3dDBKc0dWRTlw?=
 =?utf-8?B?bGh1L1dGYlhFRFloRkc4V0VjcHN3VVV5L0dDMklDZWdkeHpSOGF6bUY1TWRF?=
 =?utf-8?B?a2RaS0VEOU5ielVBcThZRms1Qm8wdU9ady9lVWE1Yk5uOXpzdG9VZDlBYjlz?=
 =?utf-8?B?MzhUdW92WXdubC9RVDBRazhBSkVBUXA3TjNzRHF5RFpRSkdORUhSRjJaOUQw?=
 =?utf-8?B?cGk5Q3NraUxpelNzMGVyUHhqdzBERTZxbzZRdmpOTkpNNEQ3aW1zQU8rcU1m?=
 =?utf-8?B?RmdhTlVnbnhnV2czWEdxTmwyeGFMWEhHdXByeStTNm1Md09NNVZhWmhtck54?=
 =?utf-8?B?WmdHcFFtdGFaK3NBZnBGRG1WUUg1ODJuSDBBU1lBdEM3VHIrMTVCUVdUalZK?=
 =?utf-8?B?cHRDVVlSckxuZXQ3clVsNW5ZeHNWYlg0ZkJwUjg3Vkdobmxra2VOclBNL2RZ?=
 =?utf-8?B?clBJU2dqSDNnMGlWcEViakFlTUtRcnJhMzE0SnpOQkE4L29IR3FXai9ZUEFk?=
 =?utf-8?B?bjlCTU9zV0VCR0ZLR1E1c282bHg5c3ZWaXpCNDdHNUtwaVBDaVBnNENzMHE1?=
 =?utf-8?B?YjhOZHo0RUo1NEI4SkJBaHk2ZkxmRXhCN3VqTHorUkNST3dQSlN0ZUNxdVdl?=
 =?utf-8?B?Q0lXeUFuRk44TThkUi9kUzNvUWVWaVZ0MEJRb3MwbkVLNnNadENlenZqV1Vn?=
 =?utf-8?Q?Wozlmbohp7PRixoR5ytMGVxHgX3UwllQKxD58UV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SzAzU0RTakI0S0lvQWlSRzVQMW41TEUyZXdrc09scXl0YzcwbDgzSzBZQjFs?=
 =?utf-8?B?ME1QZE1IVXFGUnhzOWFhVk10d3Vwd2kzS2kwYjJwblUzZ3dSY2VmUzgrb2lR?=
 =?utf-8?B?QmU1OFpZR1FIT3NMWGdmUm1MV3hLWDBxOXVGRFV0K0M0MHowQ2xqMHUrYkIx?=
 =?utf-8?B?akkwanZvblcwMHROb2dCKzBSUUhuM2ZralRjdFdLYWF3Y0hCVkVBbUxIanM0?=
 =?utf-8?B?ZzBHdzNJNzFvN2FDcWVaNXJkaGlTVXFaMjNtM0VQbStsZEtNVm5kMFJLZWdv?=
 =?utf-8?B?ajdkVyt2cGFDUHhNdUlMS3NwdmMySmw0WkNReE1WTWRiMk9RZXZ1OFhmaEtv?=
 =?utf-8?B?UXUzUnNpeVBaWGZBblNNS2I1eFk2OHEzVWtDRDNMTFBvM2FqbGtudThBSGc3?=
 =?utf-8?B?eXBxUTBYL1pwVisvQ0FpTWpYQTlFN3Q5UHhkMFBzV3FUeldHcFphRHpVYUNL?=
 =?utf-8?B?d1NqdEZySGFWWG50VVp2OXJXZGZwOWxwbzRERVFqS3lFN1N3RDdMUUpTYUNB?=
 =?utf-8?B?SmFJeVg1NjFNL0tWOVpRMGlKOXRPSyt6UkZTc0w4NGl3a1p3bWZ3WWJ6Y2Rv?=
 =?utf-8?B?WTJBRDBqYnFIdW5PcEkwbjNsb2JsbEpzcmZyNmhVM2FxS3JFVHNqUEsyRHgr?=
 =?utf-8?B?R0YrMS9KVERuZU12U0h2NjRJT2ZlWUhjQktaL1BxMGtPcUNVVUZpYmlNbzQz?=
 =?utf-8?B?QzVMQTNPNElRYTFVbTlVaWh5a1dnT09OSi9HSzVDY1lKM2pNV09rMFRWeHow?=
 =?utf-8?B?Zk42V2IwV3pJZmlEYzdMZWQ0VFZqNFdFOGdnV3RVQ1hVSGxyUm9nakgzbEtI?=
 =?utf-8?B?VVlscjE3OUxQd2NMQzNSTzJrbHl5L2NCNkVaWW9QeXMrUWtxNDRrNTFIN0pG?=
 =?utf-8?B?QnVKS0Z4czlaNTgrZERTTXVSR2NVdkNwNzdRUDhlY0ZsbDN6RVd4ckdTb2t1?=
 =?utf-8?B?OExaV2lXL00wMWJYSFV3VWxyMG8zTUJqamZnWmVWaU1tY1MzL29RUFhVbE5P?=
 =?utf-8?B?VHQyUm5DMmdITmgvT0RJNE53ajhSOWpIUTY1S2dMaDVmSG1sTEptSkNkUy9r?=
 =?utf-8?B?YXFEVWlFRHo0ZFBRNngyUUFrMzYxZHFKVkY1UHEvTkRiaGFTQzgvQnVlcDdy?=
 =?utf-8?B?czRSV3VGZDloN1F0NlA2WVpKN3BEY1Vkd2tjSUErUTQ0QXNDNTZ1c0pOT1dW?=
 =?utf-8?B?NVFaSTgveUpOTERMNkFKV3M0Z1NITXVnS1Joa0RKajdBRklvWnowUWh5QUpt?=
 =?utf-8?B?N1lHNzY2eExpUU1xUERZMEk4R0FiU0JleUlSUzBDbU9CbWNEZlM0N28zak9R?=
 =?utf-8?B?THJDZW5MbkdQSVhDM0lHYkJiV2JVMlRsek1JTU84S0tseUhueTVEM082eEMy?=
 =?utf-8?B?Q2t3YzRNa1JuaEVsenJ3UFRhblRxdFkxQkdQdzdWbGtSNnp0ZDJCWmNVY2Qx?=
 =?utf-8?B?Tk9mbEVSSDRBVVBqL0o4alYzNkNxazVkK0dDWjJieTlBaXMvYXQyVGMzVkhC?=
 =?utf-8?B?MlBERjNvT3FPNk0zZ3NFeVJsVTVLZC9YZXhwYTl4Z3VTQjlxcGdWSW1mY2xz?=
 =?utf-8?B?YjlFYUtaRnFZaU84c0FaMm5TMytSTFlRYjB3Rm44ZmltWW9OelBnSUs2V2N4?=
 =?utf-8?B?TjluZnU0UVE5RVhyK3dmdXdBMWpidDVFRUJvMW1RRGVjdU9ieFB2TVRPVzdO?=
 =?utf-8?B?Y29GWmRyL0pyWDVSSnM5NWFzc2NSRjU1T2FjSVRFd0MxWnZQaC95d2tnUVFq?=
 =?utf-8?B?UlAvMjhyckQwVkYzWm1jUTg4MDNZUmFRa0p2eEw3WkpCaU1lSUxONTIwNEhs?=
 =?utf-8?B?bVc3SFFjUk45KzI5N0VoQ0szakZjYXhjbjM0bC9oVHQ4NFh0ZXU1ZnN1b3M4?=
 =?utf-8?B?UXRoOHcrY3dNcUVxSnIvY2pJV0g1ei93eFI0YnREUmgrdnFjSk1rUjAxcGk2?=
 =?utf-8?B?U0V4SkY1Z2E0QUdjVG1IZWlscVlRSkhGTHd5SzJ0aTc4TTVzbjVTUmYraGw4?=
 =?utf-8?B?blkzSTBPekFiaGxvVklMaUo4K0NQOXhlaC9IM3ZRNnlualNaN3JGTWQzbnpX?=
 =?utf-8?B?NFBRbW1Td0NEcmpmY2ZYS1dLWmdDTmFtamxNbXIvdE9wd0NZdWZ1UkhkM3dK?=
 =?utf-8?B?UmlFSThqdEwyekFEU1JheVZzRzZhRkxUdytDSG9Ga3RFZTdhYWJmK25XSGxy?=
 =?utf-8?Q?d2tZgllXioSYH/DZXEAu5Xc=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2619410a-399f-4581-79ba-08dd51bcd7d3
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 14:42:47.4508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EkcP3gyPXEXVYQCFi+msQB6hVwYSCNixPyeZr9K1xf7X5z9OG3RUwMKhupBaVaEiSSMezJ6Qf78xiImWPQTEnvBXHzLWJzBSicxK5aTEv0Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB8367

On 2025-02-20 05:26, Gabriele Monaco wrote:
> Currently, the task_mm_cid_work function is called in a task work
> triggered by a scheduler tick to frequently compact the mm_cids of each
> process. This can delay the execution of the corresponding thread for
> the entire duration of the function, negatively affecting the response
> in case of real time tasks. In practice, we observe task_mm_cid_work
> increasing the latency of 30-35us on a 128 cores system, this order of
> magnitude is meaningful under PREEMPT_RT.
> 
> Run the task_mm_cid_work in a new work_struct connected to the
> mm_struct rather than in the task context before returning to
> userspace.
> 
> This work_struct is initialised with the mm and disabled before freeing
> it. The queuing of the work happens while returning to userspace in
> __rseq_handle_notify_resume, maintaining the checks to avoid running
> more frequently than MM_CID_SCAN_DELAY.
> To make sure this happens predictably also on long running tasks, we
> trigger a call to __rseq_handle_notify_resume also from the scheduler
> tick (which in turn will also schedule the work item).
> 
> The main advantage of this change is that the function can be offloaded
> to a different CPU and even preempted by RT tasks.
> 
> Moreover, this new behaviour is more predictable with periodic tasks
> with short runtime, which may rarely run during a scheduler tick.
> Now, the work is always scheduled when the task returns to userspace.
> 
> The work is disabled during mmdrop, since the function cannot sleep in
> all kernel configurations, we cannot wait for possibly running work
> items to terminate. We make sure the mm is valid in case the task is
> terminating by reserving it with mmgrab/mmdrop, returning prematurely if
> we are really the last user while the work gets to run.
> This situation is unlikely since we don't schedule the work for exiting
> tasks, but we cannot rule it out.
> 
> Fixes: 223baf9d17f2 ("sched: Fix performance regression introduced by mm_cid")
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> ---
[...]
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 9aecd914ac691..363e51dd25175 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -5663,7 +5663,7 @@ void sched_tick(void)
>   		resched_latency = cpu_resched_latency(rq);
>   	calc_global_load_tick(rq);
>   	sched_core_tick(rq);
> -	task_tick_mm_cid(rq, donor);
> +	rseq_preempt(donor);
>   	scx_tick(rq);
>   
>   	rq_unlock(rq, &rf);

There is one tiny important detail worth discussing here: I wonder if
executing a __rseq_handle_notify_resume() on return to userspace on
every scheduler tick will cause noticeable performance degradation ?

I think we can mitigate the impact if we can quickly compute the amount
of contiguous unpreempted runtime since last preemption, then we could
use this as a way to only issue rseq_preempt() when there has been a
minimum amount of contiguous unpreempted execution. Otherwise the
rseq_preempt() already issued by preemption is enough.

I'm not entirely sure how to compute this "unpreempted contiguous
runtime" value within sched_tick() though, any ideas ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

