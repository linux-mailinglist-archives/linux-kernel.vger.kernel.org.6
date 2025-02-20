Return-Path: <linux-kernel+bounces-522782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5617A3CE72
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 02:11:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 689DE16E97B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 01:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4BB130E58;
	Thu, 20 Feb 2025 01:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="FbBgahdN"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2121.outbound.protection.outlook.com [40.107.236.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0F73C0C
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 01:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740013879; cv=fail; b=Jf9aUXs0YIpR7JiPuIhDnIxSQG5EJMZZ/O8xSZ/Mkqi8D0GrAUvVJ+XUWXHOv1iPQJJwh4v4s0PF/pvN42cnlkrJYLA9bygRZXJkb6BukGUMwAbGD5J3LzElY4kw/dhRO4uQ2l9myb3hBZ3MjynqPD6E8qGYWNfXBtjOg2siZeg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740013879; c=relaxed/simple;
	bh=BivIvxvLf6QtMFKQjjQtBp7U25uaftofNnV7bb23DFw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rrwpN76ZAgGDmML+PrRW/9RFQ6YX7Bk20b7qKjHwuWF7lYhyXqwI4lw/slGdZ9UsO3QWoH36JX8WFfR1sklXwfzP8+ZlF00y53m/KuDSPQduljpdg2KCxfynNyiyENmYfQgeNkwzIVZnFO9UKubcgc6oM3WfM4o8WG+NvfFVDTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=FbBgahdN; arc=fail smtp.client-ip=40.107.236.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xokNbTdH4ARbATpVKjkyd7OwbrFGlH338B5oIq3ZiGwqMwUxGi3UnjfY5o55Zu2wsQQXmxA+bZ+yvszXWP39H9ESr6uZ11s1oIy7U/n4mHqaJ8TbRTycr3CTjqP4ME7F2bceX2yd8+roViXPD1TKmXsgYbT6UJ582aBMYbbW5hU1RTixubq+JCAemjZCnEhRHc2tgYm78uC24I0WN7IV1cVnDCh4SnICiEZu2KwHAMQx7PRZ4Zt2Z988tJx5a6nN3PPRlm0dozbbVr40HgbLlYLmhluE1dFl0Ah+ODzjEatj9zN8k8QjU36V5QAFhcOWqXfiGfRkFA0x0L6bBHj4fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aPGCEdDk/KyuPRjKmLPjddpCyDmXQxtMiZstsj0fAc0=;
 b=At9U5GwDrshCnscsJ16D6NS1BL506m82EyUMsqkiau5ku6JhBb7DWUVgHIGBxhH5bDgZXDUeUSC706Wztk7r1XvtM/4v8LTmYI6xdkvlKmzbrBdpXLrXvzhniv3FU9aMtQuVb0/VpsCp8CGFlLhhfbO8EUzO2oawuj+H6/tQ7UMgYG6xOXRfB6FPGHuB8iujX6L6OP+Am/Wrv1SvXHMqQc5JJaZmSD6Fc+PWpCrFF6YenygrWaY6QYsEs5yenDp60f5r7Lki9VH5b9t4Q0r8I7s/KJ0W0UiJw4lrRDdirO1XAJQs1jI8zGYtznIuM5D7iDpOjwpiHokiMKcbp/+sgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aPGCEdDk/KyuPRjKmLPjddpCyDmXQxtMiZstsj0fAc0=;
 b=FbBgahdNvODuE0NgthI8S8vJwPCxWvj4ZXf+OYFNbJd1DBXJ9NmRvq6cmw9+WtKcgKtC8+uhxQ0AQmh/7ojlLukPvxzhueLD4U/xqi+TG6q7UB4xbwv9llV9aBO4qE/JO9KlyXHAozLI7PFKHZPrBYRrTEUSEWwwnLB5AwHGpTo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 SN7PR01MB8116.prod.exchangelabs.com (2603:10b6:806:357::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.5; Thu, 20 Feb 2025 01:11:10 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%6]) with mapi id 15.20.8466.015; Thu, 20 Feb 2025
 01:11:10 +0000
Message-ID: <898de91f-ca6a-4ec5-9539-067f5f176a71@os.amperecomputing.com>
Date: Wed, 19 Feb 2025 17:11:06 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [v2 PATCH 2/2] arm64: mm: support large block mapping when
 rodata=full
To: Ryan Roberts <ryan.roberts@arm.com>, catalin.marinas@arm.com,
 will@kernel.org
Cc: cl@gentwo.org, scott@os.amperecomputing.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Miko Lenczewski <Miko.Lenczewski@arm.com>
References: <20250103011822.1257189-1-yang@os.amperecomputing.com>
 <20250103011822.1257189-3-yang@os.amperecomputing.com>
 <caf29133-a24f-47e4-ba38-d1f99e998d27@arm.com>
 <be09705e-2f85-47e0-b632-f2fdb32e54ba@os.amperecomputing.com>
 <48678288-c7a1-48a6-89d0-06e34e3b904a@arm.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <48678288-c7a1-48a6-89d0-06e34e3b904a@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CYZPR10CA0012.namprd10.prod.outlook.com
 (2603:10b6:930:8a::10) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|SN7PR01MB8116:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ae63111-1a32-4038-f51c-08dd514b75c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TGJPZ2p4SVpwZjZmNFBURDByM1BGNVRobmwrVzdBeXJzQ0crWmNVTW5nc09q?=
 =?utf-8?B?Z01QUnJtZFp0VWt4UGQ5b1JiRFFMdmhQYmZNMkU0M3BoTlEyWWkyNVh5bjha?=
 =?utf-8?B?R3c1YkxEZ1c5VUMweXFvUmUzRXRDVG5UOFFoNExJKzFqK1I1bmJhY1hQQXor?=
 =?utf-8?B?VEpkUitDdlJtUjg5WkFIYTJWZGVXSWdPZUVDV1VHTDYvNy90Sk5wZVEvWGhm?=
 =?utf-8?B?UGVIMnlGYnhUNGFMdG9JazJSdytiZTluSU5iQlNTTGgrZVRWc0dCZ3hka3BL?=
 =?utf-8?B?Q1ZhTGhwT0RtS0ZoWlpnK3J0SWdYVVVHVzAvK3ZSY1dKQ09rUDkwam5IWXgw?=
 =?utf-8?B?cmIxQm45NFhzOHBNTWpXNUtxaElmUjRHRkM1SnRCaldab3NJLzRqUDBMNXV6?=
 =?utf-8?B?QW0wZnFMMG5EZElmb0xSMDRPSFo5dnE5ZGlwQnR2Z3c5Nzk4MDU5UkJjdUo4?=
 =?utf-8?B?VG9va0lRTHRrYUNFb1lUZUlxbkZMT3Ftb2IxWVpDUXJhcVVhc1k4WW4xTHNG?=
 =?utf-8?B?NTB2bFVDMnNXUkVmQ3lKcmNPeDkrTjBwZ2M5aEhGNWRLOEl1eWNJTDdDYmZE?=
 =?utf-8?B?M0gxOVpFeVNqTXl0NTNFckZiSDUxejBoc3dkZTZvdVlaR1A0ellFdVlKZkZv?=
 =?utf-8?B?a1ZnbVRXUHc3ZElvV1VEVjZkd1NkUy9BRHkyWTY4a253cDE2YW9ZaDQzbWps?=
 =?utf-8?B?T3kvV2UycGRQNk45SXNPeE5BajZ1ZllFQllBdjBnQVFHT3hJQVpmdHdjVFhZ?=
 =?utf-8?B?enRnRDNvWW5qU01vZWlmRStJQmVEY1VjRUxpb2ljUld4dm15MVhSekgvaTZz?=
 =?utf-8?B?WDhaUUhHK3dON1J0SURoV24walY5V1UxZHlrSnpPU1hCTVkxd3JBZVUyMytV?=
 =?utf-8?B?ZTlieVNlczRDUHo3V0E3VTZGempGTjJyZ1gxWW80L09vQUd5RDU0aFg1WnF4?=
 =?utf-8?B?L3hKU0hwNjZ2Vis5QTNrWUJUNWptTHZkUG9jTy8vSDBFZmNMUGFhTjRucUN0?=
 =?utf-8?B?WTBNNk5LWW0yaU1DaVlxT1ZjNmZ0elJETGNudXFMT3F0V2hCaEhjQms4cDBS?=
 =?utf-8?B?c1FGQ1ExT2JWK1NxN0NQa1JvbEVaSVVKRDNKZE9mekdsLzZ0c3pYVjZQaEIw?=
 =?utf-8?B?RGREMHliY3hqL2JaVHY0NWdnbTFwUWg4eThKZjRHMnhqWGhpU1RpUG5PSWtC?=
 =?utf-8?B?dWl3RUN3THh2SjNYZm9RNnY3U0UwdFZSb20zdlBQZnNQaFR1YzhuOERPd21s?=
 =?utf-8?B?eDE1TkFnZytNYjNxOG9XckNocHNTZVlOeDBNNGNpazZMRm9wWnlxdTFTSkdu?=
 =?utf-8?B?aVE5ckJXd3RCR1ZXV09QYVpROVQzTEpxU2lqK3A5V3lic1MxNnVzN243eGc1?=
 =?utf-8?B?VkZIbjIrajVja3JJQ0crZ1VWbW9PcFlLSjEvaGdzR2NPT2RzRW9OQVVlNW9W?=
 =?utf-8?B?WnBFbnFjeWo2SHZYQVhBMkNoUDM3bjlkL0tQR3BSTWxLOWZZQVFoY0tYRTZt?=
 =?utf-8?B?bi9WKzhuZ1Z3Q3dXTmFTL1lVYnhSL1lhQVZabGZ4M053MnVwMjlnbXZCVzRM?=
 =?utf-8?B?b0ZEemJkNWR2Z3o1Z0xENHZka1lKRVFXRHpyVXF4QzZnMDhQUm42WTgwbEk2?=
 =?utf-8?B?OTFycVBEd212b3JHL3kzWGYyVEVsYTdoUzMyYmxMY0dyVGk4WUJodXZwbmZ2?=
 =?utf-8?B?Zll4VGh2d1FXSE5GSjhicnEzYUJGMWs2MkJMY1FYRUc0ay9QcHRWdkkvT2xT?=
 =?utf-8?B?dmlTSWtnUXhVVkc0Nk9ndG9Xd0hGeWw2V3l5NWo0TlUrNkw2cDJ2UDZVUlRR?=
 =?utf-8?B?U3d6VVplZEViVU5sbjN0V3M1dDhBZm1rZzB5OEpnZ0xpcjFxM3B0U3kvVVNs?=
 =?utf-8?Q?iCLVA5fnz5Cml?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cnRnWkg0MXNKeXBxaXUxYVdlYlgxcWxQdlp4NnFBb0ZKQkp4KzRkbFpVaUFH?=
 =?utf-8?B?aWt5cWRjU1VEOHZZRHBiMVZyMUNGRkExQUF6UEQ5czQxdVVNMzFsc0RpRXIx?=
 =?utf-8?B?dzNFUDhMaXlkSWZuaytOTkIvYlpOd0Y0bjVXVEplc0FtQmVmK2pJN0wwU25P?=
 =?utf-8?B?MEVSYzhSUGlUVHJwTjI3b0VueVBLLzFmZ0xTdFYrUWdRMCtkTGkrdTdLZDN6?=
 =?utf-8?B?T09QREk4Wm05cmhraXh0MVdRd2d5VzhNdXM2b0liRzQzK003dmdxaWpCU1hM?=
 =?utf-8?B?VE42Q3YveFdaQTF1TkFBZTNOUDlVVnExRUpnVTkyb0VKSEhWRmxOOW9kaktV?=
 =?utf-8?B?K3VibXNOcUNPbmJRaXlCRlVBNUhPU1MzdHE0eGR6cUlmZHhuOSs2NnJIaVFa?=
 =?utf-8?B?RzNIOTRQbmRobEdEWUczYlNmejRRaGN6VWRpNGh6bjA5UXNCV1UzOGZ2R0Zp?=
 =?utf-8?B?L0xNaEI5R1VscnI2bzhsTUowRHZxYTlHN1VPbE9IanBHSFNlcDUrNnRzMmgz?=
 =?utf-8?B?aUlrMGxWSGJYaFdFQlE3eWYyMWJLamNRTSsyVExzZCtNTlZoTXVNUVpGby9J?=
 =?utf-8?B?cVk2TjNlSXd2U3MzMnppdHVReERjaGVzZ3BobzcyRXhTU241bXhHUEs3S05I?=
 =?utf-8?B?aHJROUR1NXU2VDBMN2lRaEgrdk83c0hBOTJDdlRpNkdqa0NMeWJ0VG9ucng4?=
 =?utf-8?B?QW9WdWN0aDAvaEhreStUT1BVZGx0VWVzQ3pWQXdtalN4VVJpZ3JwZWFzSGxT?=
 =?utf-8?B?dFRqRkdpMkdvcGxLTU44VkdmaWViZk9IMVIva0Z2Z2tYQjFoWEZKOWxCd1F6?=
 =?utf-8?B?enNBN3FMbDVSR2kyTEM3M0djR0FGSEZ6ZVJMVURkNXF1amxjcmFoa3NKVWdn?=
 =?utf-8?B?dE8reFp4aHJ0d2kxamtENkRFdlR6SVVIOVpsbFloOFRmTktLTU85ZW43ZVRC?=
 =?utf-8?B?ckFlNi9MRjFvTzhyMFJ4VXJVZlNxd25yVXR5eitrVUxZeWt1TVNmRTZpTnU0?=
 =?utf-8?B?RlZmYnp6NmNWc2l5QUlGT1JrNWg3MVlhSmpBMFQ1OS9ZbTFWenc4ZnRiVkVh?=
 =?utf-8?B?cjVLQi9sUzNBeFVyNHJMMGJyZ0xDY0NtTXRyeVF0ZjBiMmJpTVhHWC9rdHhz?=
 =?utf-8?B?YWd3SG5PbHYyblNXOVpGdTN3bC9nUUJzTFlYSmMvN0xVOVJPbnpScnU3aWEy?=
 =?utf-8?B?WFd1RHZVOVBubVF4YWdLRCs5UGFSVHJEOG9ZNTEvcmwxVzFEeXRwaC90NytJ?=
 =?utf-8?B?eG8wU05OampEY014aDFjK0RxV2dLNjdlWVpOSUZsLzVwYUZSZjEvZGk1UitL?=
 =?utf-8?B?NTVQWnozb0l2UVNyblRBQUYzTCtncjNGcWxuUHd0WkZXcFpkNDFJRUhiK213?=
 =?utf-8?B?L0RoWWRQT2F3M1NEa1g5M1ZBTFJrNTA0bkxIU0xHN0Q4enB0VDNlaEdjSE9q?=
 =?utf-8?B?WnhUU3I1TFRteUt1MTczVFM4eTdVdXNPalg2aE0yWktYWFZMQldJNjVxd01m?=
 =?utf-8?B?SStnVk5jTmdVQ3hGYUNib0Z4Zjh4anZjeVd6OHhJY3Y1aTNPejFJeGd0Y1VG?=
 =?utf-8?B?V25iNkdTb2MvK2txQ0lPSGlVVy91WnA0ZWlvWUZhdTZabDFVUkMzVnU1S3N3?=
 =?utf-8?B?a1kxNm1rZ05oZU5kMFR3V0NXalAwcnBoekw2bnlRN0w1d0x6YnVXNC9wMGJt?=
 =?utf-8?B?Nlk2Y0NRaE9xaGd2K1l5eDdTL3d5NUg3QWlsTS9wMEtYWk9iZWM3c3JsNkhu?=
 =?utf-8?B?d1BkT3crcmliVnJQeTlTMjhpUEl1eHVaay9PL3pGdTBTY1FCOGZ3QmhYYklB?=
 =?utf-8?B?Sms3dTNLcEdSbFRpQ1VZMWgxQ21IUVJYbGw4NTdxdFErWm81amFyd2h6blZi?=
 =?utf-8?B?UVVqbUJvL1ZVS0RUd2FsallQUkgwUUtTNVg2RGZOcHN2M1ZQZ2JMdlhQUWVw?=
 =?utf-8?B?NnAvZW9PZ0lkbTYxTFJadiswY2xZdDBjdDRVRmp1bUFOOWN1NDF1SytyNTRw?=
 =?utf-8?B?Nm4rM25BYnVqd3FsR3hkQU81a1ZJSGtYNDB6QW5aWnZDaFBCNkZhcnRpbUQ1?=
 =?utf-8?B?bFN2Y1BjazVZQVF1V3hUQ3FoazhvNzd6SExkV0QwM0kwUDg3ajY1amtQbVFL?=
 =?utf-8?B?eWYxcWpkMVYxcHovZzNpSHNzc0Qva2NuMEJMVHlxeHVaN3NlcHdLUmhBMU50?=
 =?utf-8?Q?vMP8xyMleCyfYsyYNKOl2sU=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ae63111-1a32-4038-f51c-08dd514b75c8
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 01:11:09.8477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QP+uikG7AU2t+AWXXWaVbLaKPw3F9ITCwPrLm/cCOsJAOc2c95/FyUrbFHOvg3YLBon/ZbszNu/+PHSlnwwtcONq0dcxPk9PTch6/lDjMHs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR01MB8116




On 2/18/25 5:28 AM, Ryan Roberts wrote:
> On 13/02/2025 21:18, Yang Shi wrote:
>>
>>
>> On 2/11/25 4:58 AM, Ryan Roberts wrote:
>>> On 03/01/2025 01:17, Yang Shi wrote:
>>>> When rodata=full is specified, kernel linear mapping has to be mapped at
>>>> PTE level since large page table can't be split due to break-before-make
>>>> rule on ARM64.
>>>>
>>>> This resulted in a couple of problems:
>>>>     - performance degradation
>>>>     - more TLB pressure
>>>>     - memory waste for kernel page table
>>>>
>>>> With FEAT_BBM level 2 support, splitting large block page table to
>>>> smaller ones doesn't need to make the page table entry invalid anymore.
>>>> This allows kernel split large block mapping on the fly.
>>>>
>>>> Add kernel page table split support and use large block mapping by
>>>> default when FEAT_BBM level 2 is supported for rodata=full.  When
>>>> changing permissions for kernel linear mapping, the page table will be
>>>> split to PTE level.
>>>>
>>>> The machine without FEAT_BBM level 2 will fallback to have kernel linear
>>>> mapping PTE-mapped when rodata=full.
>>>>
>>>> With this we saw significant performance boost with some benchmarks and
>>>> much less memory consumption on my AmpereOne machine (192 cores, 1P) with
>>>> 256GB memory.
>>>>
>>>> * Memory use after boot
>>>> Before:
>>>> MemTotal:       258988984 kB
>>>> MemFree:        254821700 kB
>>>>
>>>> After:
>>>> MemTotal:       259505132 kB
>>>> MemFree:        255410264 kB
>>>>
>>>> Around 500MB more memory are free to use.  The larger the machine, the
>>>> more memory saved.
>>>>
>>>> * Memcached
>>>> We saw performance degradation when running Memcached benchmark with
>>>> rodata=full vs rodata=on.  Our profiling pointed to kernel TLB pressure.
>>>> With this patchset we saw ops/sec is increased by around 3.5%, P99
>>>> latency is reduced by around 9.6%.
>>>> The gain mainly came from reduced kernel TLB misses.  The kernel TLB
>>>> MPKI is reduced by 28.5%.
>>>>
>>>> The benchmark data is now on par with rodata=on too.
>>>>
>>>> * Disk encryption (dm-crypt) benchmark
>>>> Ran fio benchmark with the below command on a 128G ramdisk (ext4) with disk
>>>> encryption (by dm-crypt).
>>>> fio --directory=/data --random_generator=lfsr --norandommap --randrepeat 1 \
>>>>       --status-interval=999 --rw=write --bs=4k --loops=1 --ioengine=sync \
>>>>       --iodepth=1 --numjobs=1 --fsync_on_close=1 --group_reporting --thread \
>>>>       --name=iops-test-job --eta-newline=1 --size 100G
>>>>
>>>> The IOPS is increased by 90% - 150% (the variance is high, but the worst
>>>> number of good case is around 90% more than the best number of bad case).
>>>> The bandwidth is increased and the avg clat is reduced proportionally.
>>>>
>>>> * Sequential file read
>>>> Read 100G file sequentially on XFS (xfs_io read with page cache populated).
>>>> The bandwidth is increased by 150%.
>>>>
>>>> Keep using PTE mapping when pagealloc debug is enabled.  It is not worth
>>>> the complexity.
>>>>
>>>> Kfence can be converted to use page block mapping later.
>>>>
>>>> Signed-off-by: Yang Shi<yang@os.amperecomputing.com>
>>>> ---
>>>>    arch/arm64/include/asm/pgtable.h |   7 +-
>>>>    arch/arm64/mm/mmu.c              |  32 +++++-
>>>>    arch/arm64/mm/pageattr.c         | 173 +++++++++++++++++++++++++++++--
>>>>    3 files changed, 203 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
>>>> index 6986345b537a..2927f59ae9e2 100644
>>>> --- a/arch/arm64/include/asm/pgtable.h
>>>> +++ b/arch/arm64/include/asm/pgtable.h
>>>> @@ -749,7 +749,7 @@ static inline bool in_swapper_pgdir(void *addr)
>>>>                ((unsigned long)swapper_pg_dir & PAGE_MASK);
>>>>    }
>>>>    -static inline void set_pmd(pmd_t *pmdp, pmd_t pmd)
>>>> +static inline void __set_pmd_nosync(pmd_t *pmdp, pmd_t pmd)
>>>>    {
>>>>    #ifdef __PAGETABLE_PMD_FOLDED
>>>>        if (in_swapper_pgdir(pmdp)) {
>>>> @@ -759,6 +759,11 @@ static inline void set_pmd(pmd_t *pmdp, pmd_t pmd)
>>>>    #endif /* __PAGETABLE_PMD_FOLDED */
>>>>          WRITE_ONCE(*pmdp, pmd);
>>>> +}
>>>> +
>>>> +static inline void set_pmd(pmd_t *pmdp, pmd_t pmd)
>>>> +{
>>>> +    __set_pmd_nosync(pmdp, pmd);
>>> I have a series at [1] which enables batching/deferring these barriers. I reckon
>>> it would be udeful to ultimately apply that same technique for painting the
>>> linear map if/when that series goes upstream. The benefit is that we wouldn't
>>> need to expose the _nosync helpers. But that's something to cleanup later. This
>>> looks fine for now.
>> Thanks.
>>
>>>>          if (pmd_valid(pmd)) {
>>>>            dsb(ishst);
>>>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>>>> index e2739b69e11b..65b5b1ba48a7 100644
>>>> --- a/arch/arm64/mm/mmu.c
>>>> +++ b/arch/arm64/mm/mmu.c
>>>> @@ -620,6 +620,19 @@ static inline void arm64_kfence_map_pool(phys_addr_t
>>>> kfence_pool, pgd_t *pgdp) {
>>>>      #endif /* CONFIG_KFENCE */
>>>>    +static inline bool force_pte_mapping(void)
>>>> +{
>>>> +    /*
>>>> +     * Can't use cpufeature API to determine whether BBM level 2
>>>> +     * is supported or not since cpufeature have not been
>>>> +     * finalized yet.
>>>> +     */
>>> I think assuming the system has BMML2 just because the boot CPU has it is going
>>> to be problematic. I think you are going to continue to need to initially paint
>>> the linear map with ptes then later, once the system cap is finalized, repaint
>>> with blocks.
>> Please see the response for patch 1. We may be able to split it instead of
>> collapse it.
>>
>>>> +    return (rodata_full && !bbmlv2_available()) ||
>>>> +        debug_pagealloc_enabled() ||
>>>> +        arm64_kfence_can_set_direct_map() ||
>>>> +        is_realm_world();
>>>> +}
>>> Previously the decision was determined by:
>>>
>>> bool can_set_direct_map(void)
>>> {
>>>      /*
>>>       * rodata_full, DEBUG_PAGEALLOC and a Realm guest all require linear
>>>       * map to be mapped at page granularity, so that it is possible to
>>>       * protect/unprotect single pages.
>>>       *
>>>       * KFENCE pool requires page-granular mapping if initialized late.
>>>       *
>>>       * Realms need to make pages shared/protected at page granularity.
>>>       */
>>>      return rodata_full || debug_pagealloc_enabled() ||
>>>          arm64_kfence_can_set_direct_map() || is_realm_world();
>>> }
>>>
>>> But now that you can safely split block mappings to page mappings when needed
>>> doesn't that cover some of these requirements? So perhaps you can do block
>>> mappings even when some (all?) of these things are active?
>> I did look into some of them. I don't know too much about realm, so I can't tell.
>>
>> But pagealloc will change kernel direct map to invalid when freeing page so it
>> is called quite often. The pagealloc debug is typically not enabled for production.
>>
>> Kfence will change it to invalid when allocating kfence object (typically when
>> allocating slab), but kfence typically allocates and maps its pool very early on
>> ARM64 and the pool is separate from direct map and mapped at PTE level. So IMHO
>> I don't see to much value support large block mapping for them for now.
> OK perhaps leave as is for now, and we can take a view on whether we want to
> extend later as incremental patches.

Yes, definitely.

>
>>>> +
>>>>    static void __init map_mem(pgd_t *pgdp)
>>>>    {
>>>>        static const u64 direct_map_end = _PAGE_END(VA_BITS_MIN);
>>>> @@ -645,9 +658,21 @@ static void __init map_mem(pgd_t *pgdp)
>>>>          early_kfence_pool = arm64_kfence_alloc_pool();
>>>>    -    if (can_set_direct_map())
>>>> +    if (force_pte_mapping())
>>>>            flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
>>>>    +    /*
>>>> +     * With FEAT_BBM level 2 we can split large block mapping without
>>>> +     * making it invalid.  So kernel linear mapping can be mapped with
>>>> +     * large block instead of PTE level.
>>>> +     *
>>>> +     * Need to break cont for CONT_MAPPINGS when changing permission,
>>>> +     * and need to inspect the adjacent page table entries to make
>>>> +     * them cont again later.  It sounds not worth the complexity.
>>> I'm not sure I follow the argument? As far as I can tell, you only ever split
>>> mappings. You never collapse. So I don't think it's too complex to check for
>>> CONT bits and if set, clear the CONT bit from the block? That's a safe operation
>>> with BBML2. It means you need to iterate over the ptes which you don't currently
>>> do, but you only need to check a 1 PTE in every CONT_PTES.
>> Sorry for the confusion. Yes, I don't collapse. It seems I overthought this
>> case, I thought I need to clear CONT bit for all PTEs in the block (for example,
>> 16 PTEs). But it seems I just need to clear one PTE.
> No you were right; you need to clear the CONT bit from all 16 PTEs in the block.
> But since all PTEs in the block will either have CONT all set or all clear, you
> only need to check 1 in every 16 PTEs. If that check shows that CONT is set, you
> can clear the bit from the block that contains the PTE you checked. It will slow
> down the split process though, because now you have to descend to the PTE table,
> check 32 of the PTEs (512 / 16) and for any CONT blocks, clear the CONT bit.

Not only PTEs, but also PMDs if CONT_PMD entries existed. We need clear 
CONT bit for all the PMDs then split the affected PMD.

>
> Personally I think it's worth checking how much slower that is though, given you
> already have a test case. In general, I've found that there is value in working
> hard to keep the TLB usage as low as possible.
>
>>>> +     */
>>>> +    if (rodata_full)
>>>> +        flags |= NO_CONT_MAPPINGS;
>>>> +
>>>>        /*
>>>>         * Take care not to create a writable alias for the
>>>>         * read-only text and rodata sections of the kernel image.
>>>> @@ -1342,9 +1367,12 @@ int arch_add_memory(int nid, u64 start, u64 size,
>>>>          VM_BUG_ON(!mhp_range_allowed(start, size, true));
>>>>    -    if (can_set_direct_map())
>>>> +    if (force_pte_mapping())
>>>>            flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
>>>>    +    if (rodata_full)
>>>> +        flags |= NO_CONT_MAPPINGS;
>>>> +
>>>>        __create_pgd_mapping(swapper_pg_dir, start, __phys_to_virt(start),
>>>>                     size, params->pgprot, __pgd_pgtable_alloc,
>>>>                     flags);
>>>> diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
>>>> index 39fd1f7ff02a..ba2360ecb030 100644
>>>> --- a/arch/arm64/mm/pageattr.c
>>>> +++ b/arch/arm64/mm/pageattr.c
>>>> @@ -49,6 +49,145 @@ static int change_page_range(pte_t *ptep, unsigned long
>>>> addr, void *data)
>>>>        return 0;
>>>>    }
>>>>    +static int __split_linear_mapping_pmd(pud_t *pudp,
>>>> +                      unsigned long vaddr, unsigned long end)
>>> nit: are the double really underscores needed?
>> No, not really.
>>
>>>> +{
>>>> +    pmd_t *pmdp;
>>>> +    unsigned long next;
>>>> +
>>>> +    pmdp = pmd_offset(pudp, vaddr);
>>>> +
>>>> +    do {
>>>> +        next = pmd_addr_end(vaddr, end);
>>>> +
>>>> +        if (pmd_leaf(pmdp_get(pmdp))) {
>>>> +            struct page *pte_page;
>>>> +            unsigned long pfn = pmd_pfn(pmdp_get(pmdp));
>>>> +            pgprot_t prot = pmd_pgprot(pmdp_get(pmdp));
>>>> +            pte_t *ptep_new;
>>>> +            int i;
>>>> +
>>>> +            pte_page = alloc_page(GFP_KERNEL);
>>>> +            if (!pte_page)
>>>> +                return -ENOMEM;
>>>> +
>>>> +            prot = __pgprot(pgprot_val(prot) | PTE_TYPE_PAGE);
>>>> +            ptep_new = (pte_t *)page_address(pte_page);
>>>> +            for (i = 0; i < PTRS_PER_PTE; ++i, ++ptep_new)
>>>> +                __set_pte_nosync(ptep_new,
>>>> +                         pfn_pte(pfn + i, prot));
>>>> +
>>>> +            dsb(ishst);
>>>> +            isb();
>>>> +
>>>> +            set_pmd(pmdp, pfn_pmd(page_to_pfn(pte_page),
>>>> +                __pgprot(PMD_TYPE_TABLE)));
>>> All the same comments that I made below for __split_linear_mapping_pud() apply
>>> here.
>> Sure
>>
>>>> +        }
>>>> +    } while (pmdp++, vaddr = next, vaddr != end);
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static int __split_linear_mapping_pud(p4d_t *p4dp,
>>>> +                      unsigned long vaddr, unsigned long end)
>>>> +{
>>>> +    pud_t *pudp;
>>>> +    unsigned long next;
>>>> +    int ret;
>>>> +
>>>> +    pudp = pud_offset(p4dp, vaddr);
>>>> +
>>>> +    do {
>>>> +        next = pud_addr_end(vaddr, end);
>>>> +
>>>> +        if (pud_leaf(pudp_get(pudp))) {
>>> Just do the pudp_get() once and cache the result. It's implemented by
>>> READ_ONCE() so your 3 invocations are actually doing 3 separate loads.
>> Sure
>>
>>>> +            struct page *pmd_page;
>>>> +            unsigned long pfn = pud_pfn(pudp_get(pudp));
>>>> +            pgprot_t prot = pud_pgprot(pudp_get(pudp));
>>>> +            pmd_t *pmdp_new;
>>>> +            int i;
>>>> +            unsigned int step;
>>>> +
>>>> +            pmd_page = alloc_page(GFP_KERNEL);
>>>> +            if (!pmd_page)
>>>> +                return -ENOMEM;
>>> Is this really how we allocate pgtable pages for kernel space? For user space we
>>> have quite a lot of machinery for this.
>> The userspace page table allocation does something extra, for example,
>>      - initialize ptlock
>>      - set folio type
>>      - update NR_PGTABLE counter
>>
>> We don't need them for kernel direct map page table, so just took the most
>> straightforward way. However, __get_free_page(GFP_PGTABLE_KERNEL) may be better
>> than alloc_page(GFP_KERNEL). It is used by memory hotplug.
> __create_pgd_mapping() takes a callback that it uses to allocate pgtable pages.
> The initial linear map creation passes in early_pgtable_alloc(), which allocates
> from memblock. I'm not sure if it's possible that we would ever need to split so
> early that we need to use memblock too?

No, AFAICT the earliest call to set_memory_rox() is allocating BPF prog 
in sock_init(). Buddy allocator has been ready at that point.

>
> For late allocations, we have __pgd_pgtable_alloc() and pgd_pgtable_alloc(). The
> latter constructs the ptdesc, although it's not completely clear to me when each
> should be used. Both of those functions BUG_ON() memory allocation failure which
> seems bad, especially given __pgd_pgtable_alloc() is used for mem hotplug, which
> really should be returning an error. Ouch.

I think __pgd_pgtable_alloc() should be good enough for splitting direct 
map.

>
> I think ideally we would rework __create_pgd_mapping() to be able to return an
> error (so we can fix the mem hotplug issue), handle collapse, split and
> permissions changes then use it universally. Or failing that,
> __get_free_page(GFP_PGTABLE_KERNEL) is the second best option.

I can try to make __create_pgd_mapping() handle splitting.

>
>>>> +
>>>> +            pmdp_new = (pmd_t *)page_address(pmd_page);
>>>> +            for (i = 0; i < PTRS_PER_PMD; ++i, ++pmdp_new) {
>>>> +                step = (i * PMD_SIZE) >> PAGE_SHIFT;
>>> Suggest hoisting this out of the loop, then just increment pfn by step every
>>> iteration.
>> Yeah, sure
>>
>>>> +                __set_pmd_nosync(pmdp_new,
>>>> +                         pfn_pmd(pfn + step, prot));
>>>> +            }
>>>> +
>>>> +            dsb(ishst);
>>>> +            isb();
>>> I'm not convinced by the need for this isb(). The dsb ensures that the table is
>>> visible to the table walker; that's needed. The isb() present in set_pmd() and
>>> friends to remove any "cached" speculative invalid translation marker from the
>>> pipeline, if I understand things correctly. I don't think we need to solve that
>>> problem here because you weren't working on a live table. The isb() in set_pud()
>>> is sufficient, I think.
>> I see, we just need one isb() when the table becomes reachable. Will remove it
>> and the isb() in __split_linear_mapping_pmd().
>>>>> +
>>>> +            set_pud(pudp, pfn_pud(page_to_pfn(pmd_page),
>>>> +                __pgprot(PUD_TYPE_TABLE)));
>>>> +        }
>>>> +
>>>> +        ret = __split_linear_mapping_pmd(pudp, vaddr, next);
>>>> +        if (ret)
>>>> +            return ret;
>>>> +    } while (pudp++, vaddr = next, vaddr != end);
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static int __split_linear_mapping_p4d(pgd_t *pgdp,
>>>> +                      unsigned long vaddr, unsigned long end)
>>>> +{
>>>> +    p4d_t *p4dp;
>>>> +    unsigned long next;
>>>> +    int ret;
>>>> +
>>>> +    p4dp = p4d_offset(pgdp, vaddr);
>>>> +
>>>> +    do {
>>>> +        next = p4d_addr_end(vaddr, end);
>>>> +
>>>> +        ret = __split_linear_mapping_pud(p4dp, vaddr, next);
>>>> +        if (ret)
>>>> +            return ret;
>>> nit: personally I would make this break. Then have single "return ret", like you
>>> have for __split_linear_mapping_pgd(). Then all levels follow the same template.
>> Sure
>>
>>>> +    } while (p4dp++, vaddr = next, vaddr != end);
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static int __split_linear_mapping_pgd(pgd_t *pgdp,
>>>> +                      unsigned long vaddr,
>>>> +                      unsigned long end)
>>>> +{> +    unsigned long next;
>>>> +    int ret = 0;
>>>> +
>>>> +    mmap_write_lock(&init_mm);
>>> nit: I think the locking would be more natural in split_linear_mapping().
>> OK
>>
>>>> +
>>>> +    do {
>>>> +        next = pgd_addr_end(vaddr, end);
>>>> +        ret = __split_linear_mapping_p4d(pgdp, vaddr, next);
>>>> +        if (ret)
>>>> +            break;
>>>> +    } while (pgdp++, vaddr = next, vaddr != end);
>>>> +
>>>> +    mmap_write_unlock(&init_mm);
>>>> +
>>>> +    return ret;
>>>> +}
>>>> +
>>>> +static int split_linear_mapping(unsigned long start, unsigned long end)
>>> As far as I can tell, you only ever split the linear mapping. You never collapse
>>> it. In that case, won't it just degrade to pte-mappings over time? I suspect you
>>> should aim to detect collapse opportunities.
>> In theory there may be kernel linear mapping fragmentation problem, for example,
>> huge number of modules are loaded, but I've never heard of anyone reported this
>> as a real issue. And AFAICT, no architecture supports this for now.
> I'm not really talking about fragmentation. I'm talking about allocating
> different portions of the linear map over time and having to split the mapping
> down to ptes due to changing permissions. Over time this will tend towards the
> entire linear map being pte mapped if you don't proactively collapse too?

I actually meant the same thing.

>
> I accept this is unlikely to happen due to module loading since you tend to load
> the modules at boot and they stay loaded. But what about other features that
> cause the linear map permissions to be changed? e.g. secret mem, bpf programs
> being loaded, guest_memfd (although I don't think that's upstream yet).

Yes, but those features cause the same on other architectures too, for 
example, x86 and riscv, and we can't tell how bad it is in real life. It 
may turn out to be a problem at some point. But TBH I don't worry it too 
much right now. So I'd prefer keep this series as simple as possible. We 
can add collapse incrementally in the future.

Thanks,
Yang


>
>>>> +{
>>>> +    int ret;
>>>> +
>>>> +    if (!system_supports_bbmlv2())
>>>> +        return 0;
>>>> +
>>>> +    ret = __split_linear_mapping_pgd(pgd_offset_k(start), start, end);
>>> nit: personally I would put pgd_offset_k() into __split_linear_mapping_pgd() so
>>> that it takes the exact same form as the other levels. Or mege
>>> __split_linear_mapping_pgd() into split_linear_mapping().
>> OK, I will clean it up
>>
>>>> +    flush_tlb_kernel_range(start, end);
>>>> +
>>>> +    return ret;
>>>> +}
>>>> +
>>>>    /*
>>>>     * This function assumes that the range is mapped with PAGE_SIZE pages.
>>>>     */
>>>> @@ -80,8 +219,9 @@ static int change_memory_common(unsigned long addr, int
>>>> numpages,
>>>>        unsigned long start = addr;
>>>>        unsigned long size = PAGE_SIZE * numpages;
>>>>        unsigned long end = start + size;
>>>> +    unsigned long l_start;
>>>>        struct vm_struct *area;
>>>> -    int i;
>>>> +    int i, ret;
>>>>          if (!PAGE_ALIGNED(addr)) {
>>>>            start &= PAGE_MASK;
>>>> @@ -118,7 +258,12 @@ static int change_memory_common(unsigned long addr, int
>>>> numpages,
>>>>        if (rodata_full && (pgprot_val(set_mask) == PTE_RDONLY ||
>>>>                    pgprot_val(clear_mask) == PTE_RDONLY)) {
>>>>            for (i = 0; i < area->nr_pages; i++) {
>>>> -            __change_memory_common((u64)page_address(area->pages[i]),
>>>> +            l_start = (u64)page_address(area->pages[i]);
>>>> +            ret = split_linear_mapping(l_start, l_start + PAGE_SIZE);
>>>> +            if (WARN_ON_ONCE(ret))
>>>> +                return ret;
>>>> +
>>>> +            __change_memory_common(l_start,
>>>>                               PAGE_SIZE, set_mask, clear_mask);
>>>>            }
>>>>        }
>>>> @@ -174,6 +319,9 @@ int set_memory_valid(unsigned long addr, int numpages,
>>>> int enable)
>>> set_memory_valid() actually calls __change_memory_common() directly (so it
>>> bypassed the split logic in change_memory_common()). Is it possible that it gets
>>> called for a non-split region? I guess you'll need to handle that case too?
>> The set_memopry_valid() is called in the below places:
>>      - kfence: it requires map at PTE level regardless of kfence_early_init or not
>>      - pagealloc debug: it requires map at PTE level too
>>      - execmem ROX cache: it seems like only x86 supports this right now
>>
>> I don't think we are going to support large block mapping for direct map for
>> pagealloc debug and kfence as I said above. We need make set_memory_valid()
>> split page table when execmem ROX supported is added for arm64. But we don't
>> need do it right now.
> Fair enough.
>
> Thanks,
> Ryan
>
>> Thanks,
>> Yang
>>
>>> Thanks,
>>> Ryan
>>>
>>>>      int set_direct_map_invalid_noflush(struct page *page)
>>>>    {
>>>> +    unsigned long l_start;
>>>> +    int ret;
>>>> +
>>>>        struct page_change_data data = {
>>>>            .set_mask = __pgprot(0),
>>>>            .clear_mask = __pgprot(PTE_VALID),
>>>> @@ -182,13 +330,21 @@ int set_direct_map_invalid_noflush(struct page *page)
>>>>        if (!can_set_direct_map())
>>>>            return 0;
>>>>    +    l_start = (unsigned long)page_address(page);
>>>> +    ret = split_linear_mapping(l_start, l_start + PAGE_SIZE);
>>>> +    if (WARN_ON_ONCE(ret))
>>>> +        return ret;
>>>> +
>>>>        return apply_to_page_range(&init_mm,
>>>> -                   (unsigned long)page_address(page),
>>>> -                   PAGE_SIZE, change_page_range, &data);
>>>> +                   l_start, PAGE_SIZE, change_page_range,
>>>> +                   &data);
>>>>    }
>>>>      int set_direct_map_default_noflush(struct page *page)
>>>>    {
>>>> +    unsigned long l_start;
>>>> +    int ret;
>>>> +
>>>>        struct page_change_data data = {
>>>>            .set_mask = __pgprot(PTE_VALID | PTE_WRITE),
>>>>            .clear_mask = __pgprot(PTE_RDONLY),
>>>> @@ -197,9 +353,14 @@ int set_direct_map_default_noflush(struct page *page)
>>>>        if (!can_set_direct_map())
>>>>            return 0;
>>>>    +    l_start = (unsigned long)page_address(page);
>>>> +    ret = split_linear_mapping(l_start, l_start + PAGE_SIZE);
>>>> +    if (WARN_ON_ONCE(ret))
>>>> +        return ret;
>>>> +
>>>>        return apply_to_page_range(&init_mm,
>>>> -                   (unsigned long)page_address(page),
>>>> -                   PAGE_SIZE, change_page_range, &data);
>>>> +                   l_start, PAGE_SIZE, change_page_range,
>>>> +                   &data);
>>>>    }
>>>>      static int __set_memory_enc_dec(unsigned long addr,


