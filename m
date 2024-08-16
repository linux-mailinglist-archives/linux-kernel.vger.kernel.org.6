Return-Path: <linux-kernel+bounces-290048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F94954ED0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 18:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76ECC1F23707
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 16:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E731BDA94;
	Fri, 16 Aug 2024 16:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PvttXtwh"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2042.outbound.protection.outlook.com [40.107.102.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9967A54F87
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 16:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723825810; cv=fail; b=Ay3T4puvNYXsvHy41/jXdCweQCoDMQAjUDBMq+2qLdQLPC+mZvy0qNEuvkfy9UkbqXq8y4oBmwnBgeVhENKUgM3ffBj0eyMRLdyeWmrIdyqpU9kAsFv7moDPijXQ7YaMpkgPnX0zpUYs7GdWEKBwr8/xUDH/uWH3RwEXQC7dOc0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723825810; c=relaxed/simple;
	bh=qhl9QTNWHAQ/hwDd9s8LMfdTGOGQTBDh19lC2bGMaPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q/6fkRjGNZ0uNqlKT5d43ock30REa4cyNTpI7pOtgWNg+u/pmGiIRsCMkIr3oc4qvKMna1KVzu0pDEao5G/SYl6rLm7jXBBfXJ/9kSjtS4ktOyii8XQ998wiVftSELlUp4B5a5fG31swRiVvBKHvSoEvfsAxleOz0f0CFqZqU+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PvttXtwh; arc=fail smtp.client-ip=40.107.102.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kb+DjZdgGSH0nx8tudhRTBho8CyAVkEv10kB2axFSjXI4qekHc8JQ8MAAeklCkNv8lKqhnW+bmAzbEg3otWqCF/hy4l6+lWtsljPn/1bzb0CUsEYGrZM/IA1MbGQZAzryVFGncfrWucpgsmO5mBZQTNw59xwnzPJJEcPd5czuv5akQOz1X0Ag2CVS6aG/Q2g+4dH7BWshpSqW6fErB50nUpKBVAc2p2HNWw8uKuBSjSpVEPOMjdNSJnSVOdw+LYd964kRZuWtaTqe149NRGeEynU0Fja78G2hzF2Iufm+bqVJUVNKAywjVO4GGDids7fnPzgl7F3brIikGmpiWNM0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=isb9ejXEIck0F/r0GWOvZ26SBEhu2Y+l1RseLvdRKbE=;
 b=fRDa9f/Ow/I7IT+Qz+NeLP6v7BkQlbVCWaoWHa6Y4IkWP/vK2QshUBzkLVgDbDFISv7hIqcidKiluh49X6UJU5sPdo9iCgjrEdolEN8VTBMgRiHgrHznNr7jwiiifr+88l8aKWf15OqX8uw5gn+Wgvf79LhOjB0DDLXPE6V5K1EN5OQd+axuZQ1yKzHA+c9rdMQfMdl8DI7HVY+DuwIi/oyOg95N4j+HcKD3n0yP+bx/FS1KX/8rRb8uIFYPmv/el+KTxipu8JtZ0WDAF0JrNr7phNmESBZsw04IrqEmqy561gLOUx0NMU6L0e9fuSFK/QjZUvtnGr0C2urKc76p6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=isb9ejXEIck0F/r0GWOvZ26SBEhu2Y+l1RseLvdRKbE=;
 b=PvttXtwhD5K/o2f/ktd1b2qW+suD9VLhT7SSzlFkmVKnGXjKeJcyZuPHf1IbZvDBtUxjavZDXs1shqyP3IjwGXYiygMuNixSCZW8OrivX3RB2SzAFexlW7k2gXWxku23U1k7a2ylksBvaMO8gPKBlfPD6A4FwLR1FABDumg5WANiXjB72pYUV4V5NyN22fYLOdj6o429XyfMZdB3ARazRdrcML0kkMLeykcxCYFMZcFaTweMwR3D6Z1gDor1En+pwxoj2eKfeBsDG0aEeAA7cRh3tLcHfRGFSOARONsJGjQfv9+XapsFIROcv326QnTXgGmQBHekBhR0L1nD8s1exw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CYXPR12MB9320.namprd12.prod.outlook.com (2603:10b6:930:e6::9)
 by SJ2PR12MB8033.namprd12.prod.outlook.com (2603:10b6:a03:4c7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Fri, 16 Aug
 2024 16:30:05 +0000
Received: from CYXPR12MB9320.namprd12.prod.outlook.com
 ([fe80::9347:9720:e1df:bb5f]) by CYXPR12MB9320.namprd12.prod.outlook.com
 ([fe80::9347:9720:e1df:bb5f%4]) with mapi id 15.20.7875.016; Fri, 16 Aug 2024
 16:30:04 +0000
From: Zi Yan <ziy@nvidia.com>
To: Yu Zhao <yuzhao@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Muchun Song <muchun.song@linux.dev>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Frank van der Linden <fvdl@google.com>
Subject: Re: [PATCH mm-unstable v2 3/3] mm/hugetlb: use __GFP_COMP for
 gigantic folios
Date: Fri, 16 Aug 2024 12:30:02 -0400
X-Mailer: MailMate (1.14r6059)
Message-ID: <29B680F7-E14D-4CD7-802B-5BBE1E1A3F92@nvidia.com>
In-Reply-To: <CAOUHufY65h356h3oyZgXQM-2PjxEkBnMvkweXS6y5AKxR8oN1g@mail.gmail.com>
References: <20240814035451.773331-1-yuzhao@google.com>
 <20240814035451.773331-4-yuzhao@google.com>
 <24CDA80A-1CC1-4AD7-A35C-D1919DAA707D@nvidia.com>
 <CAOUHufY65h356h3oyZgXQM-2PjxEkBnMvkweXS6y5AKxR8oN1g@mail.gmail.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_FC24F859-2E4E-4834-A030-3BC9C8A6062F_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: LV3P220CA0003.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:234::22) To CYXPR12MB9320.namprd12.prod.outlook.com
 (2603:10b6:930:e6::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR12MB9320:EE_|SJ2PR12MB8033:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b6fff76-ea97-4d4e-84d5-08dcbe10af1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NCtDeGRtYXlLWndROWdnZEVWYlFaN2d0SUF1dC9RQWV3QkRaK1RETkNHZGZ5?=
 =?utf-8?B?OWgxc3AxUE5IR0ptTGtzUDhCQVR6eXlPazN1Lzd5VUVscnEzL1ZkU3h1Rm9s?=
 =?utf-8?B?Q0VoTWFMakhJOEZLbHRQeHhRYytsUHVOUjhhM2wzeUdkSWhoeGtDb2ExQXRh?=
 =?utf-8?B?dUk0TG52ZndydEJ6YXMrdWYvZmQweW8va0tZNXowWFRjY3VCUTBEbVFnbEU1?=
 =?utf-8?B?Y1lySFM1ZWZLZ053dW50bmlvOThBTjdRWlBseWJVbzlHRVFZZ0lEYllCNDl2?=
 =?utf-8?B?K0Y2a0N1M3k2MHNrczJiSFdERFNxaDJPejZ6TytBclNLMUU3YXpKaWR0ckhU?=
 =?utf-8?B?WW5NS0N3MFM5N0IzWmYxS3d5TS95UU5OTnErcmJQdUlSM29yQzRqRVJNbzA2?=
 =?utf-8?B?RmpPNDdBSnB4NW52NmtmcGYzRlg3SXVxaWJzOUhJVkpzTnppNnhlWWRzbDUr?=
 =?utf-8?B?OVpMektDK1NpVUlRYWsrSXFKNmJ6dmxOaUlEZGRPREJ2OEpNcnFTQnd5UUZB?=
 =?utf-8?B?RWdBaFNHRlZjeXpoMlpzYnR2NFdSdjV6L1VqNkltZFhLMHU3UmtadHVmbHQx?=
 =?utf-8?B?bHNtVy9SY0k1TE9jVnMwT3crYUV5MkREWkJsTnpjZjBIL1JXN3JKYXhodnE3?=
 =?utf-8?B?MHBiQkJQbHgyT2ptWjlLbGtvVzVwSm5FMkVSRGtHVXpxSmJEQ0Q2aURkSVQv?=
 =?utf-8?B?TnpvdmZDZU5JQnVXczc4ZlZiQXEzNWJtWE1DVjNlVEpWajZHNFBmR21OM0ti?=
 =?utf-8?B?SnlZbEh5TXlZQTIvM3MxUEtabzUwUjIwMDM2RXhYZ0xCWWlQTy9ZelhRbHJw?=
 =?utf-8?B?alBlNDBZU2h0QTVxckNGZjVKQ2ZUM1oxTTVTT2p2US9CS2JpYVlUT3A5WE9M?=
 =?utf-8?B?RGVtWHdRdEVta0lLNVdabSsvM2pLU0pGdE9nSmdpV2VFQnoyNVB1aTE5ZjVQ?=
 =?utf-8?B?LzFxZ05vcEJ1V3Q0MVlhQVFSY0FyTHdyeGFkRVNsNGVDdkZhL3FNTVFUOXEv?=
 =?utf-8?B?eXBOQUtPQlMxSjRDUjZDVWliY3I3RE04OWJIajRBcUU4YmRpUStCdHdmU3FE?=
 =?utf-8?B?S1k3UWZjN29ySjV2VzE4Z0xwU2NZdk9sSkFQWWpHMXRtS3QwZ0dBMWxwNUVv?=
 =?utf-8?B?VzladzVWa3crbi9RWGtHSkhiOTVIRXVrdjBBK3VtL1Uydkp1SUZkY3NNRVRl?=
 =?utf-8?B?bjRnRC9XREUxQ21TUzRMQzI3R0FBcmttcTN6VWxHZ2t6cmRhWkdsbDlDaUtW?=
 =?utf-8?B?ZElIcjdCdmh3eGQ5bnhTTFFDWG5iWXdtRzB2TGxWbnpadnpZem0xMnE1Qklx?=
 =?utf-8?B?d1VxWUhWUzdvV3hSNTFNS1Y5dUFqQkt3ZzRjQU5kU2lsOU1KSmt0TXNibDlk?=
 =?utf-8?B?TEg3RlFianNYeHVWL0V4YkVnWDdyTjltQnZJdGZRU213L3VqS2NjQ1V1Nm1E?=
 =?utf-8?B?VUM0aGJ5L052SG9lNXIxcGt2S01zSEZnbWpNdVhpeXhad1psY0NxL2RsNW5N?=
 =?utf-8?B?dkF0MmhYVFEzbERTVGViV2lHczRGbFhEOW11NTE0a1JwUzc1M082N3VPaGdB?=
 =?utf-8?B?M2ZuUzFxcEVGQkZwS3VoZHUyTkVkTVNScjBXUnAwMWlha2dGRWk3V1FQM09w?=
 =?utf-8?B?TThPWTBtVnQ4WWs1OWFNelE4dEMxN05icE9lZ0FuUmdYak9yTFJ0VjNtM0pF?=
 =?utf-8?B?MHZhZTBRcVhCc3lRZHpxcGV2SkRKdnRhTm9mUndoM0NQZ09WY1E1UmNQK0lO?=
 =?utf-8?B?RXErK0c0ZEcwU0ErQ1JxNTNqeDNZaVJVVm9wVlBJZVlhUHJFd3ZvTlk4alVS?=
 =?utf-8?B?NGpYdzhMMEgrVEVLNEZaZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9320.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WnN1U1VkUmtCNFNVQ2dnejNudzArWXZaL0d2TVdmY2hsK3laS0Q1Nkx6VUJ6?=
 =?utf-8?B?YWQzays3M1d3RG90WTB1dVlCbkZ6czJ1ZEZLQm1ObG1Za2VuL1ZyeG91elZP?=
 =?utf-8?B?QmFaTzI3RkJrNmJyVzJRTSs3ay9uK0RwWi9BZ2dKOXpCZnF6TE9McER2aWJM?=
 =?utf-8?B?ODhhWkFhZHIxNFk1REdrWWJBR1hXWXhGQjlZcUYyNXRnM1BMb0N1enZEY0U2?=
 =?utf-8?B?OWpINTV2SllQT21jWTNZWm92S001Y29iemlLVG95L3pNQTJUVUhqdVdKSVN2?=
 =?utf-8?B?V2cvT2xnZlJTdWY2V2FKMnllT0NKRU9SY1M1YkFVNVZvQkgwclpyRkc1OHBw?=
 =?utf-8?B?eCtyVWFPeE5EZ2M0YkZyc0Nqc0pobkV4OHEwS0MwNWRrL1pTSnRDSCsyL29l?=
 =?utf-8?B?bHFweDR3Mko3SnZCVjE3WjBEYmU5QXZJNHhZaVF6WkJoK2NNdDNmNjdVWnFP?=
 =?utf-8?B?U3RZSHJGZ05TVGswVElhNE9OdlF4KzZxYmtGRkdwMzRLaGlwNkdGeGJ3OXZP?=
 =?utf-8?B?OENRSGdDU0VqbXhkT2JzZHMrUEtSS0RFSWdrbktxazc5T1gyUTdhcnVZZmEw?=
 =?utf-8?B?ZDRjdEFybUl6LzJvQ01lZlRnUjlNOFpYTTF6Z1dRVE5CL3ExZnBCSVBRYk92?=
 =?utf-8?B?NDF3VjNUQ3NhNXBScWtWK3JXSEQvMEdRNXhVcU5JejFiSHIyK0RnVDZLV3U4?=
 =?utf-8?B?SVkwNGlSNzY4c0FEaEw1SGM0bFplcy94d2JuZ2VlMTlLbTJqc09tWXNEckti?=
 =?utf-8?B?M25mbE5FUWJVbVl3TjBPbElvZXdQR3VNSUVaWVJ1S3JlblRlNk9vbHhMcmRa?=
 =?utf-8?B?TTYxMElIN2lmbVhiUENFbzF6T2FnZ2p2WUI1Wjd4LzRGdFI4ajNNKzVaQjBo?=
 =?utf-8?B?NHpORGIvVnc3TXJJSTdydXlLWVFZc2V5M3VEN0hkUFgwNjVUYm5nb2xaMDFD?=
 =?utf-8?B?eStYWXUwc3dPZGFVZHllbUVVUmdQMjdkSzM1N2tzWS9YdzAyTStDT2hsdDIz?=
 =?utf-8?B?SzUzRmFSS283dHpzdFFrb1pxWnZXYnJ4eUpDZlNqZDg1ZDVEajVzMzBVOCt5?=
 =?utf-8?B?VWFNdktOcktocUhZTWM3SXBGSWs2aFpYQ3pVc1VJS3lPYWZmaUt6cGN4RktD?=
 =?utf-8?B?UFgzdStZa3ZvSGZSQm5xU3Z4eUVpR3pCbERCRzhJbGtnQ3VxcUhtTm5kc2tq?=
 =?utf-8?B?NDJWcVpNOHYyaHZxWjdIYUhSVG5CRE5JV2tkUmQ0NDVlNk12cGl0RVJnU3lq?=
 =?utf-8?B?dXBuRTQ5ZlRzdk9Pd1VLUVhIRVQ4RDQ0bDV4ck0xREdoMXZENGVzYUwyM2U1?=
 =?utf-8?B?bVJpa2lqKy8vbEFsdWlYNXNvN1pGenlsaXBrUS9CeWJoSWZXUU05SDdVOTRE?=
 =?utf-8?B?Zng3OTY1S2E4Rmw2ZnhRWFlqdTlJM3g4blQ5alRVUGFlYzRiRjhFaDNONG5M?=
 =?utf-8?B?SFFONGdTUXRueVF0RkRvRGZBMzNpV3p2VEhxSERSZ0JKWkpyaGRLS1hZNS83?=
 =?utf-8?B?SHlidFV1K2d5M29mMkdJSWdpZmx6Z29BVXgvSWU4V0JrUlAxdlVJUEM2akE2?=
 =?utf-8?B?OHZ1MG5ZbW95ei9mbktIcTErc3laaXJJa2MxYmc3V3MzdjZIS1MwVWJDSXFh?=
 =?utf-8?B?dTZkU2VnN01KVWNqMTBTL2QxNmZmKzczWXc2c242WWxseTlpSVoxaEhZS2xF?=
 =?utf-8?B?cXVKTlpreVJTTE1mUnZxYjZFdW0xd3UxdndKajRqdWNKUFJNSkpWUWwwaFRK?=
 =?utf-8?B?WlBBZ3NhU2lyRXRCYmU2QXFteDNQRFFYN2cwaVVIbUN5TEk3MFdUdGtNR3Yr?=
 =?utf-8?B?OC9DVVovZElobmp6Wlg4M05RdzhwV0RaWURISzIySVdnTWMzTFlhUHdMTW9u?=
 =?utf-8?B?aFI1aVdOTnNzK3hLbE1lOWJOeHVBaGRTZGQ1WjMxZFNqazdVaDltZWFNYlpk?=
 =?utf-8?B?MjZ1RUVnY2c4Nm9vYjdHVEpGYnh6d0d6eE01MGtlUmNnb2ZoeGdwTzl0ZHRu?=
 =?utf-8?B?eFlWTnk4YWFoTHBTcDlLNWxqbG9LVkQ2bmxFeENzVW8yZ3Q0WkcvZnI3M2g3?=
 =?utf-8?B?WVRrUHcrOHh6bU92VVJLbk8vTlViWlgrQXliRkxwanRHdE9xWVhmWFZUY3Mx?=
 =?utf-8?Q?HRDY76Tib0TuBEfAbnjfDL1GJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b6fff76-ea97-4d4e-84d5-08dcbe10af1d
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9320.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 16:30:04.7672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iNKye73GPkHPWiCOzmcXfRx90Lh5wpUGlWN1NoPiuIA4nD0By/KDDShaZHXStjJ/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8033

--=_MailMate_FC24F859-2E4E-4834-A030-3BC9C8A6062F_=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 16 Aug 2024, at 12:02, Yu Zhao wrote:

> On Fri, Aug 16, 2024 at 9:23=E2=80=AFAM Zi Yan <ziy@nvidia.com> wrote:
>>
>> On 13 Aug 2024, at 23:54, Yu Zhao wrote:
>>
>>> Use __GFP_COMP for gigantic folios to greatly reduce not only the
>>> amount of code but also the allocation and free time.
>>>
>>> LOC (approximately): +60, -240
>>>
>>> Allocate and free 500 1GB hugeTLB memory without HVO by:
>>>   time echo 500 >/sys/kernel/mm/hugepages/hugepages-1048576kB/nr_huge=
pages
>>>   time echo 0 >/sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepa=
ges
>>>
>>>        Before  After
>>> Alloc  ~13s    ~10s
>>> Free   ~15s    <1s
>>>
>>> The above magnitude generally holds for multiple x86 and arm64 CPU
>>> models.
>>>
>>> Signed-off-by: Yu Zhao <yuzhao@google.com>
>>> Reported-by: Frank van der Linden <fvdl@google.com>
>>> ---
>>>  include/linux/hugetlb.h |   9 +-
>>>  mm/hugetlb.c            | 293 ++++++++------------------------------=
--
>>>  2 files changed, 62 insertions(+), 240 deletions(-)
>>>
>>> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
>>> index 3100a52ceb73..98c47c394b89 100644
>>> --- a/include/linux/hugetlb.h
>>> +++ b/include/linux/hugetlb.h
>>> @@ -896,10 +896,11 @@ static inline bool hugepage_movable_supported(s=
truct hstate *h)
>>>  /* Movability of hugepages depends on migration support. */
>>>  static inline gfp_t htlb_alloc_mask(struct hstate *h)
>>>  {
>>> -     if (hugepage_movable_supported(h))
>>> -             return GFP_HIGHUSER_MOVABLE;
>>> -     else
>>> -             return GFP_HIGHUSER;
>>> +     gfp_t gfp =3D __GFP_COMP | __GFP_NOWARN;
>>> +
>>> +     gfp |=3D hugepage_movable_supported(h) ? GFP_HIGHUSER_MOVABLE :=
 GFP_HIGHUSER;
>>> +
>>> +     return gfp;
>>>  }
>>>
>>>  static inline gfp_t htlb_modify_alloc_mask(struct hstate *h, gfp_t g=
fp_mask)
>>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>>> index 71d469c8e711..efa77ce87dcc 100644
>>> --- a/mm/hugetlb.c
>>> +++ b/mm/hugetlb.c
>>> @@ -56,16 +56,6 @@ struct hstate hstates[HUGE_MAX_HSTATE];
>>>  #ifdef CONFIG_CMA
>>>  static struct cma *hugetlb_cma[MAX_NUMNODES];
>>>  static unsigned long hugetlb_cma_size_in_node[MAX_NUMNODES] __initda=
ta;
>>> -static bool hugetlb_cma_folio(struct folio *folio, unsigned int orde=
r)
>>> -{
>>> -     return cma_pages_valid(hugetlb_cma[folio_nid(folio)], &folio->p=
age,
>>> -                             1 << order);
>>> -}
>>> -#else
>>> -static bool hugetlb_cma_folio(struct folio *folio, unsigned int orde=
r)
>>> -{
>>> -     return false;
>>> -}
>>>  #endif
>>>  static unsigned long hugetlb_cma_size __initdata;
>>>
>>> @@ -100,6 +90,17 @@ static void hugetlb_unshare_pmds(struct vm_area_s=
truct *vma,
>>>               unsigned long start, unsigned long end);
>>>  static struct resv_map *vma_resv_map(struct vm_area_struct *vma);
>>>
>>> +static void hugetlb_free_folio(struct folio *folio)
>>> +{
>>> +#ifdef CONFIG_CMA
>>> +     int nid =3D folio_nid(folio);
>>> +
>>> +     if (cma_free_folio(hugetlb_cma[nid], folio))
>>> +             return;
>>> +#endif
>>> +     folio_put(folio);
>>> +}
>>> +
>>
>> It seems that we no longer use free_contig_range() to free gigantic
>> folios from alloc_contig_range().
>
> We switched to two pairs of extern (to the allocator) APIs in this patc=
h:
>   folio_alloc_gigantic()
>   folio_put()
> and
>   cma_alloc_folio()
>   cma_free_folio()
>
>> Will it work? Or did I miss anything?
>
> alloc_contig_range and free_contig_range() also works with __GFP_COMP
> / large folios, but this pair is internal (to the allocator) and
> shouldn't be used directly except to implement external APIs like
> above.

Oh, I missed split_large_buddy() addition to free_one_page() in patch 1.
That handles >MAX_ORDER page freeing. It also makes sure the pageblocks
of a free cross-pageblock gigantic hugetlb page go back to the right
free lists when each pageblock might have different migratetypes,
since the page is freed at pageblock granularity.

The whole series looks good to me.

Acked-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi

--=_MailMate_FC24F859-2E4E-4834-A030-3BC9C8A6062F_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAma/fooPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKtVAP/3lTI3KqN6Rx92hQigeAII66d4bDn9KC3G4v
kU8SPy5tIvyQf0as9FYCZxFLFNhc1Q4s41pFo7UhW/V7RSzLGEdooLFB2BoA1OXd
SGfESo/dlRsAwtE+9bs9I2U2pWIx/gF8z2ul39XGVc4d0h9YIz7lmHFC7LKmBfZa
NStonNqEghkF5IagEjsRE07BBouVjPGh1Tobxhf+iiOVWcIH18ZB6BdMIjfjgH8y
hNvhnEd2h/tJG+UqQmrMV8XMmHiPIl+mL8ilzknsnpKMELrN+9XXQ5B+zzRD8ESn
ZLKc24Z/uD0SHnYy+Njar4IuGRMjh8duYCiL08giqbtuDCO7ITHxpPRZ1hvN7Ddw
1mUTaM6SyGPFbDTTpuFypAt8r9db1zu6ITPofYakwRUWgavTW+aL42UiX34v4Hoa
TBfRzHnQ+I0NOokQraaunBDb3+moz830XXH6FOmvI4/U2wXEoHhmpJ3b7cX5VQVM
zhygq/7AZtf/T34CvZFXfEUss2Z10IiEF4MF74YbfLPJ3FBXgTWtnsxUWEJRv0DD
2KC+v9d73DRdhgU2ggoqePfy9m0U02KB6Ac+AF3mU1CO3wOJh0iZe7t9wx3aSVRx
tzAfFD+u0fzpIyHl0xgU2Uwqwm4BgmZ7E06ATzuiRUJ2bxs0k+azFe7JMGuyB0Kx
g8OHfC1h
=pVXQ
-----END PGP SIGNATURE-----

--=_MailMate_FC24F859-2E4E-4834-A030-3BC9C8A6062F_=--

