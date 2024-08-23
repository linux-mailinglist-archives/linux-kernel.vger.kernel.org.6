Return-Path: <linux-kernel+bounces-299745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7200F95D98B
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 01:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84DE81C21FC4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 23:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D4F1C8717;
	Fri, 23 Aug 2024 23:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="mhyxNLq1"
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020101.outbound.protection.outlook.com [52.101.193.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C17181B83
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 23:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724455161; cv=fail; b=O8z4dRleg6WxD6KYR4z4U5fFEd9lFrQc/C3pgc8LL68RnlqsmHTHy0DhhwgdA1UxEvO8iabVh0rsyn4XiJ606OmCjzvV6Ae1ScMrcd6q5h449ltq6HvZX3roFhzRGnWsFgcugdmBXkHbY4TfhR/Enq8YI0J2SnR+SaMZzX1z8BA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724455161; c=relaxed/simple;
	bh=836D2/pTOgDu4bmJkhwXpvnrmDp0CWBMTT9djVq9p/c=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 Content-Type:MIME-Version; b=aRSnPTwYQPOuuwv0g+3lRrbrCdjhneuzUDR7AYY3pIdDTVSWsdJBiB3tofu9UkK5kPJHrUGBRsSoaBFFbJB0yw6ZWF/Om+HyN4lUK/9Zsx4/zHI2qOgD3iNrFoxZaKS0yqebUInpzmxTTq2KN+59YeivTy2UHa8u5WhnZpX96Kc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=mhyxNLq1; arc=fail smtp.client-ip=52.101.193.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z9rVcg8A7/iLmKEopPWDIndVMZgjj/WOePQLhRBtTj7mOEafNFeAH0GRcAflBKRnm39FCe77gLSfgY7cVXpJ1W6m2goeOVlOxMaKFOSjxFIDhBL6sLdhep+8H9NqL8PR/hVvYwe6D5OXFpl7BAGXE4Us01F/qM52LB789PaBNVmxIT0NmB307cZfe+MohM+PYNyofxaKJq+6/CBEg7tHdWEhs4MnyCxiIGNYIUBwN54JWRC5fuoL4mp2g/ubRsUgja5THRB9U7HSzBF/d5c+Ks7Q+LyKB6PDdVZpwiIIlPDYJGW3AZ/aUhmPLsf6luAIEfWWS7OK1F5LwiuWwBQxYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1k1RNh82rA9yzOTHbL/IX33Ate/VH8Vg87/gyuo5uqM=;
 b=xpWjxYd3icWXNeAuGOaAn+k9Jiv2lUFDJsNvU3KCs1CUlv+Vio07slGMk0fM8JarRnSGg8zw+bQiePVarTs6A0FyfGRaQXW0cAfowQdpCa019xzw9uWpmdrtohk67/3XnpnNVnFULpS1SYezUBEGcImj1/ASi1N1bpgaRU65+hJYjYhf1G5xHV5WxkSEuLwd1+CIysxCQQqt8C8aNffUM2ybQgUtGwyzvhuTFUChimFSGP2b49xJ4SrfGH4EL7F62I2ofA7ZvUmHJADClGshoJhdjCCoVUMDtvvKaYoRfDkWPIB6c/zYqX5QnIrXbFnAXlnirCYrV4MSWzK6Xh7hsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1k1RNh82rA9yzOTHbL/IX33Ate/VH8Vg87/gyuo5uqM=;
 b=mhyxNLq117Q9ckLOQ58/0FidvwQ6hBdbL6WDUNhrwccdOODbPfseiNHm2CMQ+4G12HGX/K7ufG7NoZxFd7poFjMFYG+X5qbnpfrbXKwVX0rp0dK1ppUqZYMSAhB0OHCGYpj2bPnOh738uW35gPYRbl7WlnW7O7iCtDWPla3UVOw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MW4PR01MB6228.prod.exchangelabs.com (2603:10b6:303:76::7) by
 PH0PR01MB6585.prod.exchangelabs.com (2603:10b6:510:79::5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.19; Fri, 23 Aug 2024 23:19:15 +0000
Received: from MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::13ba:df5b:8558:8bba]) by MW4PR01MB6228.prod.exchangelabs.com
 ([fe80::13ba:df5b:8558:8bba%5]) with mapi id 15.20.7897.014; Fri, 23 Aug 2024
 23:19:14 +0000
Date: Fri, 23 Aug 2024 16:18:45 -0700 (PDT)
From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
To: Robin Murphy <robin.murphy@arm.com>
cc: Mark Rutland <mark.rutland@arm.com>, will@kernel.org, 
    linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
    ilkka@os.amperecomputing.com
Subject: Re: [PATCH 2/8] perf/arm-cmn: Fix CCLA register offset
In-Reply-To: <d506e4cc-fa7f-4881-885b-e2665c063524@arm.com>
Message-ID: <b54f8cf-d37d-6eb3-cbac-9852a6802b7e@os.amperecomputing.com>
References: <cover.1723229941.git.robin.murphy@arm.com> <e73b31da42a7840d4247fc8a4a3cea805c2ab618.1723229941.git.robin.murphy@arm.com> <Zr8jJq3l9sfvJuil@J2N7QTR9R3> <d506e4cc-fa7f-4881-885b-e2665c063524@arm.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-ClientProxiedBy: CP6P284CA0053.BRAP284.PROD.OUTLOOK.COM
 (2603:10d6:103:1ab::19) To MW4PR01MB6228.prod.exchangelabs.com
 (2603:10b6:303:76::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR01MB6228:EE_|PH0PR01MB6585:EE_
X-MS-Office365-Filtering-Correlation-Id: 9546bbce-708a-4cab-94cc-08dcc3ca00ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xVUlndepI3ER6RAKcSR/sNAhaTNCoEihucoHX/FkP3+MT9JFDY8Za8qMg18s?=
 =?us-ascii?Q?8b5ZoYv1vaZwCJuw0rOIGvsb0aheRIrVzsnj/3qRHCEDS0yssOFU3fGBQ4V2?=
 =?us-ascii?Q?8SoOFqYn/sRKscpDn7lM7zmyimjwhQJsJOTSi+o6NBXOap7nj0nGxwmBOUkp?=
 =?us-ascii?Q?3dEQTOHh6qXzh7oFDwUFNlwZJ8j/8x0bsM//3Mevh5cFvwQeB1BVvJDhqYvg?=
 =?us-ascii?Q?HHcHNm+X6y+GIFK9ntabRB9gLj4oCbLv1qHQ/3b+EpbPo7CdRtJrvVhlhhGK?=
 =?us-ascii?Q?o3loL6pr22zXHWx5Yt1ZCYH76we3WGShjJYjL7xwPiLUMVJkGQvEBuoZQbdd?=
 =?us-ascii?Q?k4pwel9j7NME7UJlHUvzip/5b9caliQiH3Wz8sIZaPLyg+WtlA1rQ44GKPI8?=
 =?us-ascii?Q?QQvWw1tcLhgmN3P7E11bXMXcRAiMhlhIAeSZkppTpmcBjs0cQ3OfE1P0tPxZ?=
 =?us-ascii?Q?8xnciuh+HlT18sJ2QkBWFJoYCc3hZa2Ju5HLJiV+mYRZ17pEgKSh2ZKOPm3a?=
 =?us-ascii?Q?bHB26fNVYUh1sjxKCLDMrMFOlxoHHYaP99oxoV1Xp2CXWZsdvgAfPA5IG7UR?=
 =?us-ascii?Q?6YBWsXW7Zk0ygdGcOgCx9gy9LQBduby4E0jJbw3LDHMQN8WLIgS+jZPVMwPt?=
 =?us-ascii?Q?bkdrrq0vmlRFOcTfhabnNU5i4L9OcFuN8FGbR8hsBD3gBWqn1/bcVnchl1lD?=
 =?us-ascii?Q?DVjV/qxAKN/BOMI5Mapa6EbOEwsnN/RNztlIJDYOF5kRSFqKQHyvxMh3inEv?=
 =?us-ascii?Q?I0IZIJbacP27gozNmPwme1K/RA1wSWOGgYPTZ3c2fWiMLxkD7hL+hni4jdZ6?=
 =?us-ascii?Q?ln2/NOn4G7CZGv7+vkmqRbHuynASAzPXN/KiqGc1A1kcP8EGPCFiWJdSB0Et?=
 =?us-ascii?Q?0RGaIFlUvbiBwSd+lufmc7KYV+N0H/Um2dGmSC6BNJHvgFPR4H6Pa8onaGCG?=
 =?us-ascii?Q?fFCOxSriknatpWabh6N70895OCX8i1OPMYg60WCFEBmbiRy1J+ETD9dSeFzm?=
 =?us-ascii?Q?fm0xAFyzxZ7kcmvo2f03wSE+Om7R/hBSjHoWRr8bo80w+nRPLmkheY9MDQi6?=
 =?us-ascii?Q?8/XPIXN3ROHPpXuZ83GDCyjiS7JryFqUNnUkH28Za8B1NVEZKBgxwWU2ILsI?=
 =?us-ascii?Q?z2KyLfV5VX60X94trG3pimea1zmstFAK4uSEuFkDKB37eoAEecFjf1zPw2Wp?=
 =?us-ascii?Q?LklqBLTQ3JM5w8jDFIBIU+s1liWHOO+PS26lfsaqOWTqidog0udcCePE6LR/?=
 =?us-ascii?Q?OywqVy/WDqtkKADJhRx7VdA90CoqLwLxkv96MW5I9yEsYBTWFF9h3QX6c5ex?=
 =?us-ascii?Q?/U3bSuc/NWhpPZeg9JP2RcsXWwXNG22QuopX3uHGDA7Ui7CXK+9Njjb+KIN9?=
 =?us-ascii?Q?55TKvKjBNEuP/Pm9lvuEWtdrlNjCCYJYIm6FFGmSg2maX5J7hg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR01MB6228.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aW+JrGQuSH/AVzv1wzQBQBzC+nwZDUQhzol5teSvFfi3CmX5n0sjkk+8+lH1?=
 =?us-ascii?Q?GEwC7Zrq4yfsKsO/WPTbHY6HTvIsqX3DGcwv10Zs0IQR2lPZkH5Mzldvfq5w?=
 =?us-ascii?Q?6XOUyhHgMvQXPw/1KnRrfsCVoIhkxTHl97buFSSgof9fRd6ctX3L2vC9UQHE?=
 =?us-ascii?Q?aF8DD/dkJibZM9HOWllQE0aXyruWXFDtIBERWZ0j/gT6ClfwVdyvfc+NTBEF?=
 =?us-ascii?Q?8IQ3Z+XMuGwzKFlaQR5ZSkBTE8XAxSoOPkEah3e7wvk+rIrXsAFoWfKu5ICL?=
 =?us-ascii?Q?fQ70wDohUS9idUD25sO3oNdjsUmFyyl7eZlS9OEO8UTDBF86GWrFn4ewEp5x?=
 =?us-ascii?Q?TqtPikU/9G/OFqjViP8Xtk+vIcb3gN6ZN09l7NjYjyO2gJz4XhNCYNxZINPT?=
 =?us-ascii?Q?ToZdP98czKBljMgtW7BYkpKGWkJR6+6bPc7w7ZaMz3H4lq+o8Rhb4RD7S5vl?=
 =?us-ascii?Q?jvGCaTvsvAjTPBhQNZdZV1IRw5/HSB8m6TMScfW5jFi4dO1hr+sOyaHO3TLP?=
 =?us-ascii?Q?wjVqedPbpNcq7bPChwnElJfdn8aBrcxX/69uwgIHfApzAlHQRbjuVq1mdBPu?=
 =?us-ascii?Q?gjFdcKGlxYYBsqbGwgtLTTvNN8KZ5RS3ka5hwzWSTm0IMnoNeO2L2+4nLGw9?=
 =?us-ascii?Q?9OCyswjxzCZejF8lzMtftIyhaI0sldrvoz8UtYG1lkdXP+u6skhvFrVMk16x?=
 =?us-ascii?Q?vV9dIbIRBoNW/Qtb8JVGHduBafk8PMRP/RT6g6ZDEGR9MiIKnt+OvNkD+Hz2?=
 =?us-ascii?Q?j6GQATOwHAHvQK80hFn6CriPz1jLHxoa5D0fPLC7NLFGOSfA/eaZ1Fu9gr7P?=
 =?us-ascii?Q?FjISeHBZXNET0V2jnKeWKhY2lUw/T5iKD0+7xBGnwSqrxABUYbzR/3iiLlNm?=
 =?us-ascii?Q?JW85WBnvdkMubSVdvF4LBoSHC7t2sMe31kQVAsNIMGnMpHIX3qXYARCmbA3X?=
 =?us-ascii?Q?zy/r04EfB8x1SrSixwEnr3psa3ICJXmE8TufYkQVcO2oCMGTKMeKvlO3HLNE?=
 =?us-ascii?Q?8LKquf+gwss2xBsqXoS+LvLDw7WPKg/vsWn6v2Gty/RlhyDd+Dkjo2eYaFT4?=
 =?us-ascii?Q?XvcYmn955iNBqi6exZNUB1mFtbhsj5exvej7k3LHUUEJtfiBJs01bIMfVeQM?=
 =?us-ascii?Q?92gHjwYH6syqfD7J31D1S1C+noYsmTlq44aCSMwa+NXIANKWITnNG51fTkbL?=
 =?us-ascii?Q?FTxGDm/b6lyNa8W/FzhkrqspQe0ljv8JEUZ2qorUs06yUsAC74kElDg5/EDU?=
 =?us-ascii?Q?Hcjok0WcKNxV4bLXEsr3nxqwVC1WIpniotytKJMaw7Wz5baRxfG661BM8ui1?=
 =?us-ascii?Q?Tb4lvbPAuT2gkmGIwoFiWGdrKUTOowwkoHsTAQiwEYAHDduRxtHXWf4QLzCF?=
 =?us-ascii?Q?wSFq8hNCcYw3aTjkTytI6XqHlaO4QLLvHxOgx/vSPCKb3SDf2P6nYegj9vLM?=
 =?us-ascii?Q?IOpyO9FGN0LU9Ib0yZbjsZTWm2DM4uDChDQmun69PvdKuPa20vWktKCd1gFm?=
 =?us-ascii?Q?ln3E/ahnKToPBWSkOdxROkb/rIgmUi9d9gc3T15BQC/l2djHHfHhX2avadv8?=
 =?us-ascii?Q?H1moja1DmS32f3RtCcIDx7HAsRyGBE9iuu3jfNAPFlD10lrvYhT40/KpbPqt?=
 =?us-ascii?Q?G6SkoIzslPM+o55AbmOfBGU=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9546bbce-708a-4cab-94cc-08dcc3ca00ec
X-MS-Exchange-CrossTenant-AuthSource: MW4PR01MB6228.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 23:19:14.7692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eulOQW1+N4pOZAJQ5fo+Zw6MPP5lnPkiKWB1Iin4mkyxeYvc9FFjgNsDaUkPXewfoJQG6JBoJmJY2wTqXjq9F3vTALB2dWhIF+t9GFjtcPhP1sryCDLZTA8ueWmokL9z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB6585


Hi Robin,

Sorry for replying late but I just got back from my vacation


On Fri, 16 Aug 2024, Robin Murphy wrote:
> On 16/08/2024 11:00 am, Mark Rutland wrote:
>> On Fri, Aug 09, 2024 at 08:15:41PM +0100, Robin Murphy wrote:
>>> Apparently pmu_event_sel is offset by 8 for all CCLA nodes, not just
>>> the CCLA_RNI combination type.
>> 
>> Was there some reason we used to think that was specific to CCLA_RNI
>> nodes, or was that just an oversight?
>
> I imagine it was just oversight/confusion helped by the original r0p0 TRM 
> listing both a por_ccla_pmu_event_sel and a por_ccla_rni_pmu_event_sel as 
> CCLA registers, which I could well believe I misread at a glance while 
> scrolling up and down.
>
>> Looking at the CMN-700 TRM and scanning for pmu_event_sel, we have:
>>
>> 	16'h2000	por_ccg_ha_pmu_event_sel
>> 	16'h2000	por_ccg_ra_pmu_event_sel
>> 	16'h2008	por_ccla_pmu_event_sel
>> 	16'h2000	por_dn_pmu_event_sel
>> 	16'h2000	cmn_hns_pmu_event_sel
>> 	16'h2000	por_hni_pmu_event_sel
>> 	16'h2008	por_hnp_pmu_event_sel
>> 	16'h2000	por_mxp_pmu_event_sel
>> 	16'h2000	por_rnd_pmu_event_sel
>> 	16'h2000	por_rni_pmu_event_sel
>> 	16'h2000	por_sbsx_pmu_event_sel
>> 
>>> Fixes: 23760a014417 ("perf/arm-cmn: Add CMN-700 support")
>>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>>> ---
>>>   drivers/perf/arm-cmn.c | 5 ++++-
>>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>> 
>>> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
>>> index fd2122a37f22..0e2e12e2f4fb 100644
>>> --- a/drivers/perf/arm-cmn.c
>>> +++ b/drivers/perf/arm-cmn.c
>>> @@ -2393,10 +2393,13 @@ static int arm_cmn_discover(struct arm_cmn *cmn, 
>>> unsigned int rgn_offset)
>>>   			case CMN_TYPE_CXHA:
>>>   			case CMN_TYPE_CCRA:
>>>   			case CMN_TYPE_CCHA:
>>> -			case CMN_TYPE_CCLA:
>>>   			case CMN_TYPE_HNS:
>>>   				dn++;
>>>   				break;
>>> +			case CMN_TYPE_CCLA:
>>> +				dn->pmu_base += CMN_HNP_PMU_EVENT_SEL;
>>> +				dn++;
>>> +				break;
>> 
>> When reading this for the first time, it looks like a copy-paste error
>> since CMN_HNP_PMU_EVENT_SEL doesn't have any obvious relationship with
>> CCLA nodes.
>> 
>> I reckon it'd be worth adding CMN_CCLA_PMU_EVENT_SEL, and replacing the
>> existing comment above the definition of CMN_HNP_PMU_EVENT_SEL, e.g.
>> 
>> /*
>>   * Some nodes place common registers at different offsets from most
>>   * other nodes.
>>   */
>> #define CMN_HNP_PMU_EVENT_SEL		0x008
>> #define CMN_CCLA_PMU_EVENT_SEL		0x008
>> 
>> That way the switch looks less suspicious, and the comment is a bit more
>> helpful to anyone trying to figure out what's going on here.
>
> Sure, that's a reasonable argument.
>
>> With that:
>> 
>> Acked-by: Mark Rutland <mark.rutland@arm.com>
>
> Thanks,
> Robin.


I like Mark's idea. With the change,

Reviewed-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>

Cheers, Ilkka

>
>> 
>> Mark.
>>
>>>   			/* Nothing to see here */
>>>   			case CMN_TYPE_MPAM_S:
>>>   			case CMN_TYPE_MPAM_NS:
>>> -- 
>>> 2.39.2.101.g768bb238c484.dirty
>>> 
>

