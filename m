Return-Path: <linux-kernel+bounces-269464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E1D943335
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 17:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B1F9B2C4A7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 15:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13ED1BD031;
	Wed, 31 Jul 2024 15:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JcuiamWM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XPCc3oLF"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF7012B73
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 15:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722439189; cv=fail; b=MpS5uTkxoDbXUzu1Cf1x/4grt2a3aYx/DWiFtjNyhV66J0U1PzEr5gBqvavm6PYoMIsblvgZ+t4FtSRRYLv1WmK73a6NqCe605mfs3BYfS2LzAW2VPvaOa3WJC4yMQrTurDJ95gR0oBhNOwcQDq6EdVn7oS6IecKyuXRetlsnzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722439189; c=relaxed/simple;
	bh=j/XUFQJgKs0tYtNj5a+GC2ee4M9BEMpTEkiRxOgTJNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GZOtyJAzGou8ITUz+Dqx615YAtQ5qWHhYElrsJdjN4WxKNwICXu7S2b1pO5cCRRqnkf1KHW3d6UWhm0/JKKqJA+OSJRkJw8Kg8PFJXTOPmSosHsKDUB0NkUu1pqxqw8+ah+oOElQmoT4wIpXm1b+iSuSfhAF6NHbJMT396udyQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JcuiamWM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XPCc3oLF; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46V7tWWK024239;
	Wed, 31 Jul 2024 15:19:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:content-transfer-encoding:in-reply-to:mime-version; s=
	corp-2023-11-20; bh=aH44qn3jROT/FqoQBSnkpYZFTtl+ZSdQmYwVYnd2E7U=; b=
	JcuiamWM9x/WY2hpxVRYetgSBO9x5aSfYito9VXPMpoFxyItJ/OR4jMVh1BDPiul
	4xmM4nJLF5yR9tkKdjzyt5gbOWqTQQGeV9E/aoCP5B8Emy+oMj+qAURjUiwHorGd
	I7Kbh4NX3WatM1IN1MhE3Egp/etVsY0JMudP0Vsyg0zqa17bTlSubJbiFPiBwDKE
	n6XWpWf45zlMZbP1h5xmQRNGpdUzKyrcnM2KpGmoPGXs/jV7nWkDBCUH1/RGhDla
	OjCCcEvi1YnDoc5T4VFlrEEm4TOwZ3gcc27r4W367MxutUmGsVXc9VY+hM2wfUZE
	7GV/nphMogXRX13Q/27oxQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40mrs8qhmc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Jul 2024 15:19:19 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46VEXsc8000970;
	Wed, 31 Jul 2024 15:19:19 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40pm84r9vv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Jul 2024 15:19:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wsrFgW2I/Almo6wQ8yePHycRBlt6Iprg1554S6Xpy54v4yWD9KDTyMsncuB42ColbRm5bU+VrqwDTwl8fT3QKuBWdKhr6u/D+QtFmPl6ul6MNd4cDeGBsyxrdzT1oBoGpVs/yxHdsqCk53+qrVspMFpobYPbu/g2NmYv0bX4y9qV9xvcWasj3KnXNl1BculUJrJiAyP0M5x+I+2y/wlmRgCPIojwoAxhLzOB738NinGwcl1ftFf+1uJhKxAaEVolyTgfcNC+ZvlSliR+L2fXTl02cRHTjGyOKvnXKWYxGwfvlyre0k0H8km4T8/VaE5XKz5mzfxiLsl8E0QhDOH6rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aH44qn3jROT/FqoQBSnkpYZFTtl+ZSdQmYwVYnd2E7U=;
 b=mtpHYHpwSpM5IZ739LPX4CQyjacAiNm/RA/QG14Xhbn21lWYi7E1JRWXxlA0Y+dasexDEJ8M17NeE6MP+4NlQsVbkSlUd0HB5mTWWNZ1UdmA8rSKUATzy/4DNQOp6P3/5TH7Mcw/wxjxgAfT81vFORU0/vhVd+BFP/izk8BCUym7plpLRxVbZiyUoMZFD/wQZnTxyVuDR1iR6inO7kd7vXKjrzVv+RTe458ayL8IWTKxhKoio+O58isXe3GkN8yfHdGpb5HIopvjGHTq2y5MjVzGABEkgqo9hJuzuEWrjR7QxHzIMWknDf/axfSay9xDN30OmUg5ojnkxf6jOwrVuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aH44qn3jROT/FqoQBSnkpYZFTtl+ZSdQmYwVYnd2E7U=;
 b=XPCc3oLFQJ/IK8WBdr395PNZ0fvECOOWNI98HvGbTsdMFAoATd3qYi3HMTkTZxb8+vGDZnbE0aqH0Q+9wI786eXlyB/cP6l62Pw8spmPl2YBPJ7aGvGAYGN1C6Q/RaEujG8/qL6fy7lVO6Tpjj5Bgq+hFH1+ALxW4awIz+Bq7ec=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by DS0PR10MB7453.namprd10.prod.outlook.com (2603:10b6:8:159::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Wed, 31 Jul
 2024 15:19:14 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7807.026; Wed, 31 Jul 2024
 15:19:14 +0000
Date: Wed, 31 Jul 2024 16:19:09 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Oscar Salvador <osalvador@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Peter Xu <peterx@redhat.com>,
        Muchun Song <muchun.song@linux.dev>,
        David Hildenbrand <david@redhat.com>,
        Donet Tom <donettom@linux.ibm.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v2 6/9] mm: Make hugetlb mappings go through
 mm_get_unmapped_area_vmflags
Message-ID: <354e4db4-e257-48a4-9e05-7f0595728ec6@lucifer.local>
References: <20240729091018.2152-1-osalvador@suse.de>
 <20240729091018.2152-7-osalvador@suse.de>
 <8a57e184-4994-4642-959d-44dc7efbceca@lucifer.local>
 <ZqpTaKHdrYt61HYy@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZqpTaKHdrYt61HYy@localhost.localdomain>
X-ClientProxiedBy: LO4P123CA0667.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:316::20) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|DS0PR10MB7453:EE_
X-MS-Office365-Filtering-Correlation-Id: c4517a20-de95-417d-daa2-08dcb17422ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dU1mTmUwU3FXVE5VRUlneWFsVWczek90L3ZiYjJPSnZwUTNzMHArR1AzbHU1?=
 =?utf-8?B?V0ZRVTB4emZXbGFGR0E2MXNmMnU2YXh5NVNnYzIvWGxyK01wVEM3Q2s4cjZx?=
 =?utf-8?B?b0xoZlVwa3ZDL1k4WFZKaTlzYWhhMXJnVDVEeElCbm9kWVExNjVlcGJMTHdE?=
 =?utf-8?B?dHVjMXF1YnI4QWUxVEY4WmJ1azJhbHlqUHVFWjdPT0R0QmxUV2FSL1d2Z1Y2?=
 =?utf-8?B?OWNERDI4dHVwVWpNb2F4bjZJMmc0NVA1RlZPOXdVUCsyZXRYMW9aV3JEb29M?=
 =?utf-8?B?QktxNHRDVzhHNUJhWWI0dXZzZWY2NXNNbVV1cnpsb3EwK2VtSENiT1lxSjhB?=
 =?utf-8?B?MVVnVDU4V1p3UVNNWDgvYUJQekJ4UUVzQ1NET2Q1dDdqU0NMM1djaDJuWTFM?=
 =?utf-8?B?NDFkeVUycy9VRUttNWtTRGdyWWtPWUcvZnVzamo1eERtNUZNSnBOdVIzcmpT?=
 =?utf-8?B?QlRjb0F2Vk01ZVNkSlFOMHE5eUl1dSsyaHd1aGFUWGtacGYwamVOcUNFNnFM?=
 =?utf-8?B?T0FiQkg3Mnk0VER2UUl3Y0FEYjVrRVhlbmNPVVlFOHRXSHU3Zzl3THFscG1i?=
 =?utf-8?B?Z2VYUDZCVitFSitUSXNuQWpLVW5OVlpCRmpDVFRzL2h2Z2h0cjdQMm95VlhB?=
 =?utf-8?B?TXh4RUFoYkVwUjROTzhCUlBPS05lcFFqemhSQTY2RDUwZU00cW54TzhvMmJB?=
 =?utf-8?B?RlRLNjJ2SUgzVWNlLzNReUZNaTkzNnduOUdiYllDRTVtZ1NmZ1NQQ244NlBS?=
 =?utf-8?B?RkdTYUYvWGEvSmNFQlY1Sk45NkZHZXJJV1lzSzYySFljeHpyZmZrVjJzQWpH?=
 =?utf-8?B?WHFRQ0lLbVhQK0FNdjF1alYzY25rSWR4NzV5cERCR1VKSUZITkhoWDltYzBJ?=
 =?utf-8?B?UnRUWHZyL0w4dzhnMHVPTzZHeE5Hb1QxczkzVmJCR2lSZ3ZBekhrY01kSzJ3?=
 =?utf-8?B?VTJWdkt2a3UzYTRXZjE3cTFNZVk3a2hpWGRSSjM4bnN5VnlzSVZ3MlZQZ1ho?=
 =?utf-8?B?aXpNWkVPREd6SlhpMmhyaVl2MDVXakFDc0pIQzZ4SEF2eDBFbjZoUU1FckE3?=
 =?utf-8?B?cGFCTC9NVjRvSEZOVVFza2haOTB0ZmJCcGdTVTkxSG5aNHlUS1pHZTRSVDRx?=
 =?utf-8?B?Rzg3VTRwTUNtaVZ1N3RUcDlWTTQrWks0dEd2UlJOMS9CRDlrV3h2ZWp3bjgr?=
 =?utf-8?B?TUhvMS84eXY1NUFSZmd1MFg0aDZZTUhKOTdsNmJaeEhxMkZLemtFM0M4anJw?=
 =?utf-8?B?NGhlTlQvbHcvTVF5azVVa0dNbWVFTmJubnhLcUNHRlcxZjF3VTB1dDNMTnN2?=
 =?utf-8?B?KytvLy9ySGczUzk2VEhWZ0F0aUN6UDhBZmJwcWM4Sm1mejdKdjFoN2dISDQ3?=
 =?utf-8?B?TVF0SEUrdDhLc1hGK1JiNGJSbG1CWms4cWRxVlNqbyt1WmFBM2JTcjZUVG9N?=
 =?utf-8?B?NmpoTVRHQ2JHMXplOFovK0pQbEZLV2ozdnJXd2dxMTZ5dnN3elljK2ZvamFi?=
 =?utf-8?B?R1Rqc3RPb0YxSzRsUlo5YzFXSW9uUVhwRFRGd1Q1dENxQnNPbXBJaHlBUkZi?=
 =?utf-8?B?dmFqL3VOVFFSVVhkNHUxbUZQQ2F1dUNXaEdFZVd0Z2wyV0g1aDdYVWczVmgr?=
 =?utf-8?B?NXd6QkVXUnJJQytBdG1sbUZONmF0cnJkd2N4Mk5FcHYyY2JaQlJBK0xuSEc0?=
 =?utf-8?B?Q0JKNU00cEp0U3loREdUNmlEUmI4cFViU05jQ2hPcHdOblhEUjF6RzFEZ1c3?=
 =?utf-8?B?dnFiYm1Ra1Q0MGFGRExqMXNWcTV3SFhTM2hJY1JmRFEvOXRLc3dtUW1oMDM2?=
 =?utf-8?B?RW5NbysvenJ2NVNCQWdXUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bVhIbDVhZ1lVVnhXbGxtNklwb0RuNkdHU2hwZzk5WVo3R1pLdlZGL3pNMGhO?=
 =?utf-8?B?bTVwUVVlRU9GV244a0R0Ynk0Q0c4QTNRNS85djB0NkZKbFdudjhDQnB2U3RL?=
 =?utf-8?B?RkMrbTFlZkpHRXY2TXpVY0Q0QzJaMEw2VE5Kc1FGZXdlUWhsdnd1RTNVQ0Fp?=
 =?utf-8?B?eS9pc3ZEQkZ5eStXK08wcGVlamJ3MGNuRit0amNZUmJIbkQ1RDA2UnU2MHpH?=
 =?utf-8?B?T0M2OVlnbVU2WXJjNTU3b1VGTmFuMnJLUVhhbGpRcnRGd2pzdkhLWGo3WkY0?=
 =?utf-8?B?djg5RnFSbFc2L0JnZmFVNTRES2xaVmRQY0x0VkJtM1BaVU52bjN0OG9YSG5p?=
 =?utf-8?B?Y2JwcWk2RkI5TnVjR2VYbmdvY2Iwcm1RckJ2b21ITm9CT0ZzR2Y1VDN2UGtY?=
 =?utf-8?B?TEhsaTBlYjRtRlAvVU0wVS9iRFZteGR2NkloMTkxcFJKQjV5Z1FKd2pwUmlp?=
 =?utf-8?B?MDdFVmpjenh5SjhmclJjMW1nOXY1U3gwcDFpNVhjMFZTVDJGMklFUDlXbkdv?=
 =?utf-8?B?cW9BdE1oRm9pY2Z0b3NRQzlyNTFyWlJMTWZ2MGtDaS9NYVVPY0NwalpSdFJP?=
 =?utf-8?B?OFFnTE1iQ21HZ0w2Ymg4UVMzRVZpQ1NCNUIvSGVJRmQ0NG0vME03UHZkSkgx?=
 =?utf-8?B?SEU0bEwxK2NCZ3QvcFE5czRUNCttb3BjK21zV0REQVBlc1F4UU1xQm1aUDBE?=
 =?utf-8?B?SStKUWtHQ3o0Ynd4a2FJMGF4WDNObHd0YjUyZ0tXSVlabVhHOXUzYWJBYUpI?=
 =?utf-8?B?TGF4RHdxRzlCYnBkYlpPWUVwUjFoQnFRRmFtaEVmL1pzTStFOW1aRTZoWjlt?=
 =?utf-8?B?U1NLNUhlbEZDc2J2Y3YrMCtPUUNWNXBMdU1XdkxFdTU1TUtMRGViWFRrTWx1?=
 =?utf-8?B?ZmQ5MFNZZmZKa0dCMXZzWHkyclBTZ292bHBsN1lXUzdsZkNwRFpSd2wxNC9Z?=
 =?utf-8?B?S0hJQ2NSMkRnY2FzNi9oaXN1OTNnWjA1ZlY4Z0dNQ1JWOWtjWFFiTkVJbVlj?=
 =?utf-8?B?QXEweUl3L2x6Q2JoTUNudm5zMzVQT001OG43MU9ySXR6Z3ZycGQrTEM2UDVo?=
 =?utf-8?B?eWVmcHgxL1pNMXh0NEZEMHgySHYwc2NmL3IzVkdzMzljM2MwS2xJdUh5c2RL?=
 =?utf-8?B?ak40eU42aTd5SW1aTUUvOUlzZE1USC82bW5Lb3ViNkNHTGREaUJHSFlFRWJX?=
 =?utf-8?B?REMyVm1Lak1OYmM0T0RudWtvRis4YlpCejVWOE5IeUZpUWpJYXdGWWlUdG5V?=
 =?utf-8?B?d2JNdjBVdFNZd2JyWVYrWE1TTnBwQlFGWU12SGF1Qjdyc09GRjQ1RUluanE0?=
 =?utf-8?B?WTFCc2dwc0prYmUvdDlHUmZWTUcxZEpnNEtRWVV2V3JSam5xWENzUGIwVlJM?=
 =?utf-8?B?ejJjamFNWUtneWloUzFYMHdUdDdUSFNwN2xqTEZDakU5WTJoZG15c21xcmlJ?=
 =?utf-8?B?SUYwd01kSWdPUjFTejlyYmdVYzlucHVqQ1YwL2I5ZXlidHdSMFM4WHBLNEhs?=
 =?utf-8?B?ZktVY3RTY29xOVJITzRWQUZZWUlYK2pYZVNWTktrRlBIQWxHZGQyWHdSSVBr?=
 =?utf-8?B?UFJTczYwTVY1ZDNEa3Q4TkRNN3ZBMWJaTXJxUjZUUVROV0xPTEJTVnkzMi9w?=
 =?utf-8?B?TDZoanFqYjAwR0hpd1UxWld5d250Mk5rTkpaVm9iWHFVdFNqbjV6eXZvNjdU?=
 =?utf-8?B?a2lJUXJYK056Ui9hc3hsUStSNGlpS0ZQTjhua3R1NlBoZUhPV081bzI0R214?=
 =?utf-8?B?V1dkYkN5SlpLeUFEL1o3UWlEdWdLODJrSCtJaFcyak9VMmpiam5WRjVUM2pU?=
 =?utf-8?B?V2k4STlMMThDSGU5ZWdObUVmRkY4QlI1Q1UwZ0J0cy9GODMrYlZSM2hzTndt?=
 =?utf-8?B?TjhVZEVqRWE4L3NrMUR1TVVReXNEaWV3ZEVJKzcrd1pTbE9oSE11NGdzKzRQ?=
 =?utf-8?B?bTFLQmhqVGdCd1pObXVjdWlqQnljc1ZPNjRtVHQvb0ZOMnIrVTVvVEpKbE96?=
 =?utf-8?B?YnVrZEEyNlRtd3p4L1g3MHFIY3JMTUovR09Va2p0TUZwcGpFTmRzcDl0QnNp?=
 =?utf-8?B?eWhNOWQ0aHN0WWtKTWZPTGtWbVRqdmFLYlZoSXpGa1VZK0tTeHRVZWFYZWNj?=
 =?utf-8?B?Y2xoVlcxNlFhVWhlZERuTHhhcnFCbm5EMmhhWjJqc3lZOEN0RExidXRMQ2dw?=
 =?utf-8?B?Q3JrcmQrZGorWGtzcFQ2RmFPeWhjeWdaMmttU3pYaFlXZkpieUF6L1RsQmx6?=
 =?utf-8?B?cTFrUlZVOW00MjJpcCtkbGtteG9RPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tIUqbaMm33S/qOo7utJNTGuwv4Upz/G9/R6ns6wNDGxStJ33IXTeRnbmW+P454oV8tIdFRtPt3ViVfCx+N+ebXKyUlnN6DnyGUXmPxAIHjC7vd5zLabdxFgugW6z7QxWtwSEmp/Mz4m2lfbJbWUhH4H4LY7T7MxNib+Lj1ZvEYC0oV6E/0rKuxyRldeePjyRKLXmK84ncxlJaZqwodbSRL/HI5GxD0IJi3PFzgHzEMsXMX0Xfw+F2b9wyG3J16hT59QrRNpqfpNTF7z1366zo8sibEfR1GoQY4y8+ANkixp4ib/1+/aWlT4qdOTxmEl/Jh8XbkYU32Ow/AdsHa5c9NTNNc635z3qs36svkx7g+YD0Z0NAOplJ6IG/2g/MPahoVKcvBzQh8GtKK1zcRIg1/cOo2vIg2VVwP6tpSkcJa42LB8aYqbLwVOHUk4A1GKYhywfwzN5K1uqghUHnT9WRPmyCjflDQiCDfVUUL8fDeUAN0sUKuDdMgjxl1sPx+Hjf2xoqjQpdOMkni7hnt/8NA8Uca5GZKq0rYuq4xje8VYlHqRhomsO8KWqThgtvaF+rISNeOaBCxX2uAHMrNQA+SCBqiWR5FAqdhp4kRC/G+U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4517a20-de95-417d-daa2-08dcb17422ff
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 15:19:14.2299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pdZbK6k9+uHRRyvQsgtKF9MTzX3jY5Ko7pLIeJa55D1ymAXijCEPg7rdjJXz4FzXXmKzM8o5nJYWp7E3HF18uOnsEiUwtjwvum4O9BVojQo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7453
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-31_10,2024-07-31_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 suspectscore=0 phishscore=0 bulkscore=0 malwarescore=0 mlxlogscore=787
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407310107
X-Proofpoint-GUID: jn1aVPxJ332fxwl2hqPhapezmIfsaVEM
X-Proofpoint-ORIG-GUID: jn1aVPxJ332fxwl2hqPhapezmIfsaVEM

On Wed, Jul 31, 2024 at 05:08:24PM GMT, Oscar Salvador wrote:
> On Wed, Jul 31, 2024 at 12:02:47PM +0100, Lorenzo Stoakes wrote:
> > On Mon, Jul 29, 2024 at 11:10:15AM GMT, Oscar Salvador wrote:
> > >   * Someone wants to read @bytes from a HWPOISON hugetlb @page from @offset.
> > > @@ -1300,7 +1307,6 @@ static const struct file_operations hugetlbfs_file_operations = {
> > >  	.read_iter		= hugetlbfs_read_iter,
> > >  	.mmap			= hugetlbfs_file_mmap,
> > >  	.fsync			= noop_fsync,
> > > -	.get_unmapped_area	= hugetlb_get_unmapped_area,
> >
> > This is causing a NULL pointer deref error in the mm self-tests,
> > specifically hugepage-shm.
> >
> > This is because in __get_unmapped_area(), you check to see if the file has
> > an f_ops->get_unampped_area() however ('wonderfully'...) the shm stuff
> > wraps it, so this will be shm_get_unmapped_area() which then accesses the
> > underlying hugetlb file and _unconditionally_ calls
> > f_op->get_unmapped_area(), which you just made NULL and... kaboom :)
> >
> > You can't even add null check in to this wrapper as at this point
> > everything assumes that you _can_ get an unmapped area. So yeah, it's kinda
> > broken.
> >
> > This makes me think the whole thing is super-delicate and you probably need
> > to rethink this approach carefully, or least _very carefully_ audit users
> > of this operation.
>
> Thanks for reporting this Lorenzo, highly appreciated.
>

No problem :)

> I will check, but..

Yeah this is obviously the priority.

>
> > By doing this you are causing an compilation error (at least on my compiler
> > with an x86-64 defconfig-based build):
> >
> > arch/x86/mm/hugetlbpage.c:84:1: error: no previous prototype for
> > ‘hugetlb_get_unmapped_area’ [-Werror=missing-prototypes]
> >    84 | hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
> >       | ^~~~~~~~~~~~~~~~~~~~~~~~~
>
> Something is off here.
>
> git grep hugetlb_get_unmapped_area
>
> returns nothing.

Yeah this is at commit aee8efc95fc2 ("mm: make hugetlb mappings go through
mm_get_unmapped_area_vmflags").

If you:

git checkout aee8efc95fc2
git grep hugetlb_get_unmapped_area

You'll see it.

I'm guessing you remove this in future commits, but the kernel must be able
to build at every revision so we can bisect (I found this issue through a
bisect and had to fix this up to check).

A trivial fix is just to provide the prototype immediately prior to the
function decl, however the more correct solution is probably to do the
removals at the same time.

> After this, arch/x86/mm/hugetlbpage.c should only contain:
>
>   #ifdef CONFIG_X86_64
>   bool __init arch_hugetlb_valid_size(unsigned long size)
>   {
>           if (size == PMD_SIZE)
>                   return true;
>           else if (size == PUD_SIZE && boot_cpu_has(X86_FEATURE_GBPAGES))
>                   return true;
>           else
>                   return false;
>   }
>
>   #ifdef CONFIG_CONTIG_ALLOC
>   static __init int gigantic_pages_init(void)
>   {
>           /* With compaction or CMA we can allocate gigantic pages at runtime */
>           if (boot_cpu_has(X86_FEATURE_GBPAGES))
>                   hugetlb_add_hstate(PUD_SHIFT - PAGE_SHIFT);
>           return 0;
>   }
>   arch_initcall(gigantic_pages_init);
>   #endif
>   #endif
>
> so what is going here?
> Maybe the series was not properly applied to mm-unstable?
>
> I will have a look.

I see this being removed in commit 631dc86d2f95 ("mm: drop
hugetlb_get_unmapped_area{_*} functions") which comes after aee8efc95fc2,
so basically I think you should squash the two... or at least find a way to
adjust them so this error doesn't arise.

This bit is just a bit of a slightly nitty cleanup to make sure things
build at every commit, the first issue is the really key one, just needs
some tweaking to deal with the frankly bloody horrible SHM stuff... Do not
blame you for missing that one!

Cheers :)

>
>
> --
> Oscar Salvador
> SUSE Labs

