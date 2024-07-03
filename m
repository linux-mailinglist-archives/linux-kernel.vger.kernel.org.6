Return-Path: <linux-kernel+bounces-238604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EDC8924CBF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 02:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDBAF1C21E59
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 00:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05E91361;
	Wed,  3 Jul 2024 00:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="h9iBsA1j"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2105.outbound.protection.outlook.com [40.107.237.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8E0621
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 00:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719966051; cv=fail; b=q6I5t9siXnMbNTwqRHjBD190xMob+rXO2iCtKj8MDwD65Xw2i9HBBzpx+v7DuRqTjivOh+Y/PgIYjCYyk9fM83XVupA+8TMCy/w2j7J5RPcJjFReOlI9Sb/CSBc3KsVatvzkEyk/u/oXYYVsqNYUlqY5hv+Cy0FoDNOH8JyamW4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719966051; c=relaxed/simple;
	bh=Em9K10AxXreW6yymhV9mKzsf45RFMNq2sc+c57EIodo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EQ0SlVf4x2Kpy+YwJAYLCdEnyG25TOcHsPcJXbxnwjl51hXVmV0e0SE5bfOWfrGZMR/qcXzER5qDmr/uNVW/TjzzE1oLMrYkO3hpcXyReKNF0o0cR6pjhZXJ9aXJ7rmnB8w2rT/z6aSoi+ff0wG60nQcGkNwX/r5vc35HsQTC1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=h9iBsA1j; arc=fail smtp.client-ip=40.107.237.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GZy5evqgxzQllCva6HsB93ZgPB3xAfIqqqDYC24Dwax1UWfPhhz7yzJ7M9UQzjhXUiOxX/sgHwKWvr0BcH2T+Sw48IN3aSOlkbulKZOpe7UKhth6FnTTPKk7uUQLA/o722NxBgUUbnyQYHFHu3BhtSkwjaefyz9aMqducdMywtJu2y8L67Vq0lgFQyUtQ+rdE4aScJlEXIt4+MFbol69fAE52DZtjzwvzgNvkpemE1TNS0DBXH3TnjdWzOXlQ7sSpM1DSOJvgtw1BwnW7S+W0YY5ZtfMaF5bl66CVmhJp+31Awdo4s35zXfym6AM+ByjwaalUu4wdEG6li1t5yrwaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rz3H88hTrMXfT+li1M+O4YO7yLIl3bkym8lvJcTVJ7w=;
 b=mw82Bc8kgwsmg8l61TvRyZStd75Z/3dKA07k8sD7IjM5qX1mtcXKoEm1KbdH2/U9WIIsUS0HxcvaquFhOZCVQ13Dl29lEKvqdSWrjcMo3/Fj1s548vtYVUdzft99oJ3iowmKIMRb3SJJKe4WBDU5nPUrvVSnbrTSHCJU+0nmbTxaQpqU0UunL+COcirw0LkluL8YcJz1Si9JAs2VwpbkzE+edwk1SyVOkFtwGL5HtWdxTBbEKNfUCi5Egz8ZyheXf/eZHEeS9LEWeMlB7MFbK2vb3Wak0QxqxyHZxjOqIEKxVEQ/odBz3igAiQ5owLCh0S/w1hXUUPFbjKe4nHOIag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rz3H88hTrMXfT+li1M+O4YO7yLIl3bkym8lvJcTVJ7w=;
 b=h9iBsA1jX/57hB80u8gzAAKYWR/K7t3s0GLREgHVXL8uRH77Rn5Y+usO3c8VD5YfD9JMrW4IdDzvN0W96mfXVSttdO0D3VJCTsvY/DB5e0o9Pp2hi5nqU1F439IAHiM/BTxbqcTUNSMZU3ycMBZibQ73ea0wulpJiOkzpokz2Xg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BYAPR01MB5463.prod.exchangelabs.com (2603:10b6:a03:11b::20) by
 SJ2PR01MB8228.prod.exchangelabs.com (2603:10b6:a03:53f::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7719.32; Wed, 3 Jul 2024 00:20:45 +0000
Received: from BYAPR01MB5463.prod.exchangelabs.com
 ([fe80::4984:7039:100:6955]) by BYAPR01MB5463.prod.exchangelabs.com
 ([fe80::4984:7039:100:6955%4]) with mapi id 15.20.7719.029; Wed, 3 Jul 2024
 00:20:45 +0000
Message-ID: <9dd065aa-f377-4b4c-893a-df69c9f67360@os.amperecomputing.com>
Date: Tue, 2 Jul 2024 17:20:41 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hugetlbfs: add MTE support
To: David Hildenbrand <david@redhat.com>,
 Catalin Marinas <catalin.marinas@arm.com>
Cc: muchun.song@linux.dev, will@kernel.org, akpm@linux-foundation.org,
 linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240625233717.2769975-1-yang@os.amperecomputing.com>
 <ZoPz14fYSqVyvRTw@arm.com> <fcf036e1-d65c-4a4b-9280-19024bb4da1b@redhat.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <fcf036e1-d65c-4a4b-9280-19024bb4da1b@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CYZPR20CA0009.namprd20.prod.outlook.com
 (2603:10b6:930:a2::20) To BYAPR01MB5463.prod.exchangelabs.com
 (2603:10b6:a03:11b::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR01MB5463:EE_|SJ2PR01MB8228:EE_
X-MS-Office365-Filtering-Correlation-Id: a6ef5527-8bd6-4f06-16e1-08dc9af5fb5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OHFSOUc0VDF0MmpJMXoyZCtSQno4elRyUEUxM08ydFppdUxiUW4yZUIzczlH?=
 =?utf-8?B?TkNzbkpOekp1dkpHTmZFSFY0SWNqWG5uSDV2Ym13Qi80T1Vic2lLamhjdDB1?=
 =?utf-8?B?ZWRJUDNpb015K1lYdGZ4bFNZNi8rajIyaWg4OWUwUm5qdDhDWXNmZVg4QjRz?=
 =?utf-8?B?WmQ4UXdnS0pUMWtBY2ZDR2ZKbEJacjdIZ09ucXkwejZOSktGVTlid2xabE1Y?=
 =?utf-8?B?ZWdpaFBiL3RzMHc3Q3drRk5Sc0FDbGRvQjFveWFLOXNxc2NoVEFyUHpCWU1y?=
 =?utf-8?B?RjZpc3JrQlFLWjNBUmlOaXlMdElHT0toM3I5SmRPNFRuZkx0YnZuTS9ZeDc1?=
 =?utf-8?B?eHhkMXFhOU42TVMzb3QyejlTNnJpMnZkTXh4Z21qbjYwRzBOVG1OSENvR1pI?=
 =?utf-8?B?a3JKNzJ4VzRVWFZBV2wzdWxnSzEwOXF5NVkwRUhncm1KUXNCNEVNc3RFWklY?=
 =?utf-8?B?QU9yMS9VS04xVCtiS0pqeHBFNEtIakN0M2djOUI2enRZcSt0a1pHc1VGUXVZ?=
 =?utf-8?B?L0lLVW5YV1VYcXdXblpxdjY5TjQ4cFpONVpsQjloZFdMQ0pBQzdyU2FwRWtI?=
 =?utf-8?B?VWlRb3FPbUIvYWtiNHlCOWZzZlVLUk5iWFNodmVSMzVuM0V3UkRLTm9WNFQz?=
 =?utf-8?B?ejIyRE5NWWZoOHpGcDVGaDlld05oVEtlNEdHb1FaN2FZd3dvL2pMSGoyZkNR?=
 =?utf-8?B?aGNMelhNakNSWS9SbGpHL04ycDdIZHZLN0lQQjJyMG53K2NidDZwQUhZYW5W?=
 =?utf-8?B?d2l5aU1oa2Q4cUoxR1djakh5ZFBsTVhSQkNqN2VlaHdoMXBVV0dSMEpaU2RZ?=
 =?utf-8?B?ajQ5ZDkyU3FlUDcvQU5JY3ZuK1FNVXJGd01XKzl5bkhpMUxvUEhqRlpiWURa?=
 =?utf-8?B?VmNDS1p0emZ1dnhoR1Vlb3d6ZU94QmxDdndVbUo0Njg5TjhLb1VFUGpyWnRo?=
 =?utf-8?B?ZjNINmREczZ3ak13aUNMeVNHa3prc09Oc0kzL1pEanBWeHFKbWJ6YTFLT0JO?=
 =?utf-8?B?NlpYUzdKZUkrMGtIeng0d3VTcm1jRG5ZZGMvdUxSRzhTdnovL3R6dlhYOXho?=
 =?utf-8?B?RXR6VkNBT2s1elA3citrQWdJeHZqSFZYQVlTeUJBK0d0UTh4ZFZpbVd0Mi9Z?=
 =?utf-8?B?VHRPaEZOb1hmSklmanRzRmFRY0tjU3BSSi9GMFhBWkdrYTNoU0ZrQXNmOUNO?=
 =?utf-8?B?Wjl2TUtPV0wzbFJaSE9jMzd5L2lOLzJHSGdWZEZDV3BUMFJDbHVxeHpkbFpF?=
 =?utf-8?B?M25FNTNiYVJhWkZvVTVNQ1pJZUdLckt3Q3RlVDNmaHFGaURiNlgrWGVOdEpr?=
 =?utf-8?B?aTYxUG5XejRDZkZrSVQ5L1g2a3p4UUpQRktGcDJWcHB5Sm9xMmJEUzNyNW8w?=
 =?utf-8?B?Rnh3UzZiK29VQSs1dWUxd2N5S0ZudnA1cW1hNXY2RE5XWjdIT3B5YjhQbjNN?=
 =?utf-8?B?UmVuWElNZ3Z4cnd4czh0dDRiVzZiS0VwUGdQVlZqWDBRVkFqaXVIT3cvY0lO?=
 =?utf-8?B?T0pZYm1VOVViRGlxTXpjbnBnS2hQaXNPaWpuTTlrNnU3ZThBZWNoUndYNFVh?=
 =?utf-8?B?aTVEM09MMURnZ2VDbU1LdVBkODNXY1IyMGVxWWlUZjFJQzhvNFZsY0FHN1pt?=
 =?utf-8?B?V0c5OTcxeHl0YW5RRTV3VXo1azdZMnIwbXlVaGdnNVREWkY1bEN5RlUxQWdh?=
 =?utf-8?B?WExKbHhyUHEyYTRybERMR2Q5ZGl2SmNSK0tXTDRUV2hhYTRQR2w2SEpjZzBo?=
 =?utf-8?B?RVFvZ1hPSWJOVmx2eEhLdkMxbGZjaDlNcW96Mkt2OHlyL3M5SDVIQjBiSHlx?=
 =?utf-8?B?S0ZRaWdNRFY3aFYzQ2F2dz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR01MB5463.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cHhRb083TkpOeXRtYit5bkQ4cXgyK0dRcE9uOVdvL3RYeTQzNEhjdzRoNVBV?=
 =?utf-8?B?Qm4xRFkzM2t1QlVpL2tLSUtBcUJycTVwZm9rODhmN3MrbHdETnZXbkNsVzh0?=
 =?utf-8?B?SnFJcHFobzhQdzlFd0M4eGFQS1VwZ0NVSzJvRktpdGlxZmZ0TnllWDZ0bjEv?=
 =?utf-8?B?RFo0SUlpeDNlQ3BEaGFCWDQyb1FVMk80dWR1ODBmMXRzRmZvc1d1YU5JeUpk?=
 =?utf-8?B?ZDIxR2IzK3hJeWtiZ2Z1L0tQejRTMjB0S2grVTd1bVBMdUZUcGpCbzhUVDVU?=
 =?utf-8?B?NTd2RWlaN1JvQ2NrUXVFb0xWcVJQaEFSSXB5cUhBZFpHdGhIWCtNb1R3QlE4?=
 =?utf-8?B?aVZUaFE4c1pwbFJwMTFlRGsydXRHS2svMVY1NjJtMC8wQ1dYYUFPSmdmdmpt?=
 =?utf-8?B?d2lpUzBvcmRWaGhpQXRBM3NZZzQ2d0V1SFVjT1lsMnc5Q0dRV3AzUWlQUDRy?=
 =?utf-8?B?ZHBFNXB3Z043TXVqM3dxMHZHLzZ0cW9mdDA2RS9LSUtaRTF5ZlFkTW1YWURu?=
 =?utf-8?B?aTdtZzBBQXlzTHpJVTJNV0NBT0lVR0xtMzFTQ29DdSttMFlJVHByN3VERXg0?=
 =?utf-8?B?M2ZidHpaaFpZUVZJa1BxRDd5UjZGWjVkbEpsK3lDUWN1bmNxNzVsYjU2SmRk?=
 =?utf-8?B?NmhGdEZMMDVQSlVzajlGSnRORVpVY3lTczIzbzFEUTRLakE2QkpHVE90M2oy?=
 =?utf-8?B?amJWZ3NWc0FlNTBwRnpRRXlxNjdrTG5Xd2hldHFnOU5Pa2lzZVBEcFJBeHhD?=
 =?utf-8?B?TXdqVXh5clNMcDVDeEVGMFc4YWtxU2llSjlLYkFhWGl6MlR3YkQ2ajdNSEp5?=
 =?utf-8?B?ZjhqZjMyVUk2ZnNTbS9od1RNdWhzeU5RU3Z0R2didEs1bFR2Q21YK1NPRHo0?=
 =?utf-8?B?NnZaYmdsdUprTWVOVXRDY21EYVY2bFJNTmg0UW1mRWRGQ25FaEV0eFZLY0tE?=
 =?utf-8?B?TzVFQnF2TWVpZmRoaWpNMmwyNjVlWEtESnQ2MUo1Yjg5TE0wMWhBcUdrV2Q3?=
 =?utf-8?B?dklQYTl2d0p2RnpPc1VKQ0FBOGZ6SVpTaGtoQ1dMZ0JHcm9yMzR4OG9KeVFk?=
 =?utf-8?B?c2J1MUhnTmV3UUN1aUloSjZKOCtUTUx0dVpneEdQbko4OUsrZTMvYVc3S3BR?=
 =?utf-8?B?Rk1FOEd5MFZaRFhWek1DbU5XSHBwK2tDOG8ydzlRQzR6RmxuSmpRMjYvaDVC?=
 =?utf-8?B?Yjh1RGNZaVdmVWZUbUM0a2FEQTZ0RFlxcEo0SEkweURGc2pUMW1FKzN6VkhV?=
 =?utf-8?B?U3o5UldvNEVxUm5DelV1Yjh5aWhwdUVTeUUralBiTGFiRTRaMHZ5MVJrU1Bj?=
 =?utf-8?B?eDlRNFEyckRIUTN0SWx2UzRSUzFFMEdqZTlGZEJRRWVhQVZuS2FINERtalox?=
 =?utf-8?B?cTZaUzYwZDVXZldsYkszdzJuTUhaRjBCeHdRY3MyS29SL3RQRTdTRWJZWXAw?=
 =?utf-8?B?Q3hYMVVFTGtXMmdOaVlvZTlqU013N1I2N2trd3FpcmVta1ZNcE5CMEhQVHhT?=
 =?utf-8?B?NkluREFoL1h3R0ZHWnpVbDIwZENzRzVLTGdIZDFWVjgwZ1Q1OVpkWlhvMkll?=
 =?utf-8?B?UkpXMkNTbThoQnV5RU5iK3EwS09rWUZ5Y29VelB2eS9KZzk1ZUdKSUR4ZTBa?=
 =?utf-8?B?QTYyTTFLdXBuRm5ueUlvV3BDZjcxWUZZZ2duaE01YUlTQXdya3gydUZpT04w?=
 =?utf-8?B?Y0ttSG1WK29mRDI2b0w0V2xraitQUUVETmlZTG5IQXhWdENja2wrVm53QkxW?=
 =?utf-8?B?STQ2UGdZMUZwRktmaVNSbWdjekpOMitPTDBWN20zL0sySmp1R1EwVThLSUVS?=
 =?utf-8?B?WnI2MmZiVmM3empmRE51L0RBQ0dqZFVhWlkwWU5tOUhQUVlhTGJ2VmJGWlRQ?=
 =?utf-8?B?QWNGLysyWTJ4QTRtNkd1Vzl3L3JWbWY5SWVzQm41T2JFVVAvcCt6OW4xbWtH?=
 =?utf-8?B?VUxVWXdKZGJwQ1E5QzJ5dU1wdjJ6RDVwSXNGdmlxa1N2Y1RpNEFhMG9Ncmls?=
 =?utf-8?B?dGc1STVxRnlaVUdmNGRBNy9tNmZtVG5XSExZUk5mZFpZOEMrY1FlV1pVKzZW?=
 =?utf-8?B?SzRJV0lzMUo3K3NaREFCRUVHdHBFRDdkQnJPK1k2MU1DT1dUQ0dXUHFFWjdl?=
 =?utf-8?B?anlVK29SLzYxbmZ1aW51SFYzZVdRQXdoclE1M1NIMGhJK3phTTJpNWo0RzlE?=
 =?utf-8?Q?zRR0x+EqO7rgdgUinruhLOQ=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6ef5527-8bd6-4f06-16e1-08dc9af5fb5d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR01MB5463.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 00:20:45.5887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NoEGULoZ7mQcLNJrQryBVSCyliuARZ3KzUrR6xDVr8sWqLq/ekXgB+qkDMOHlPBIvPVRIbUT2KLHheErj9nK4oqF2LwOOsY6b73c9hHDAm8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR01MB8228



On 7/2/24 6:09 AM, David Hildenbrand wrote:
> On 02.07.24 14:34, Catalin Marinas wrote:
>> On Tue, Jun 25, 2024 at 04:37:17PM -0700, Yang Shi wrote:
>>> MTE can be supported on ram based filesystem. It is supported on tmpfs.
>>> There is use case to use MTE on hugetlbfs as well, adding MTE support.
>>>
>>> Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
>>> ---
>>>   fs/hugetlbfs/inode.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
>>> index ecad73a4f713..c34faef62daf 100644
>>> --- a/fs/hugetlbfs/inode.c
>>> +++ b/fs/hugetlbfs/inode.c
>>> @@ -110,7 +110,7 @@ static int hugetlbfs_file_mmap(struct file 
>>> *file, struct vm_area_struct *vma)
>>>        * way when do_mmap unwinds (may be important on powerpc
>>>        * and ia64).
>>>        */
>>> -    vm_flags_set(vma, VM_HUGETLB | VM_DONTEXPAND);
>>> +    vm_flags_set(vma, VM_HUGETLB | VM_DONTEXPAND | VM_MTE_ALLOWED);
>>>       vma->vm_ops = &hugetlb_vm_ops;
>>
>> Last time I checked, about a year ago, this was not sufficient. One
>> issue is that there's no arch_clear_hugetlb_flags() implemented by your
>> patch, leaving PG_arch_{2,3} set on a page. The other issue was that I
>> initially tried to do this only on the head page but this did not go
>> well with the folio_copy() -> copy_highpage() which expects the
>> PG_arch_* flags on each individual page. The alternative was for
>> arch_clear_hugetlb_flags() to iterate over all the pages in a folio.
>
> This would likely also add a blocker for 
> ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP on arm64 (no idea if there are now 
> ways to move forward with that now, or if we are still not sure if we 
> can actually add support), correct?

IIUC, it is not. We just need to guarantee each subpage has 
PG_mte_tagged flag and allocated tags. The HVO just maps the 7 vmemmap 
pages for sub pages to the first page, they still see the flag and the 
space for tag is not impacted, right? Did I miss something?

>
>


