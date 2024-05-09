Return-Path: <linux-kernel+bounces-174611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5CC8C118A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 16:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 323E8B210D4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 14:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E249134CCC;
	Thu,  9 May 2024 14:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XJRfT2DC"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2056.outbound.protection.outlook.com [40.107.236.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A4D12FF9B
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 14:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715266430; cv=fail; b=TKoqWpy+UFSqylZ1Z6oTkzeWoQcGFH1Q3aRS+fopdfWILEhQgtiWcZxXQGbxRQhUTqYG60ZkwBs6qlCfQeUWU5kKSGtJCSFpk8GGrQCdPzJXoQQADTHMt7dip9AfiI0bTZQbIOZ1B0b7t6VlTcLKXGm/ox+8HUHj9SgBZ4lMPE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715266430; c=relaxed/simple;
	bh=pgme6OVXfZ8icZIBwErIulg4D2es9Plq2VPXK2wtmUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JTwWzi4RY6iCaVCrM8wP2rKws4Ub+MuMdJUyb9GUb+d7F+ANtdy+BPBrPGiBqmHSvrHNJSi4/E586c0KEAX0B5MkwZaAJlxLeTStFwjigMIe2DRdJmNB5P1qYn5mQTzye2VdZPK6QEwqrxLbEuETGJhrp1E6EcEYcCXJq2pzFPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XJRfT2DC; arc=fail smtp.client-ip=40.107.236.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h0SvzNsbuW/NniZfhkYUhz98SAcZmam2iKNh84gABsx5qbBQwPLK2GDfQk6LIXkXLLHvWEqUWGTTfPR8c3FV4tC7w5V+rZMFfUPrQV6T3eqm4WghVksH4OX49zyEmvQPCrEJsH/IJdN+0PVbsQxLbF/tKq0IYeHhHGZsZkkUpYACYobsYsx6gTyHripJrpSVruWMzt4obLZx9C/wOIon7FAPexywtNLHsKUOGPBz6/LkIq2aNIWeSwyWppUQNCyoPmezUI4q4HXl35iIaxuTBcL8CqNAtrRcTZC+FkXZcw4jTBI+rp9NyJ+FE0zGAer/1djfdCQnMssm63K3Pf26AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pgme6OVXfZ8icZIBwErIulg4D2es9Plq2VPXK2wtmUg=;
 b=YlHPUZo+Z3v4daGXW+5u88c9Kopcrrn7XYuax/bbH0Mwg3WB315bjbCwscxkQaLd+Yune26KXFbnfG1I/tJt7uZbZm1iY9JaOmxtb5NfvLjxm/vy1HRtP25V5/sWDDUxONE1xQs81bv3taqV/iuhbrA/ZvzUknXNOerRAMLytBhusGlZlfx9gAnjr79g2836tt2MchndSJi+ht10KV4yQNMeIrFF7BEqFbz7SJNPu0tVz1t6MoOyZVx5KLtZ2UuoDBXn50wD9VG5Vqk8biPCAEtxhja7wDTEueH5pQ9XkELrois6mB3nNvLDApsWMwLvxXqrZXlHPxZ18EiuvC2uNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pgme6OVXfZ8icZIBwErIulg4D2es9Plq2VPXK2wtmUg=;
 b=XJRfT2DCzdbijpnm6R18GnUdd4RawtGxl1/I61AiGtb5znTj7eulSh9d2XGaRRF+2Aadh5ZRWwRuLdHmoSX2JkFbIubnvxNrk538Pz3F0CIyRd7rDk9OMEKqgT24hAiBb8WV7cXNEQgoPzrdO1Vso4iHXvME3qp9NBcV1dCVrawDKDEATANi0RN+oK9lNxDwAUKiLW/r00fnqTTrf5rUw+kkV2ytK4WsomiewFScwfKDTSXS3Gl8jg4UB9zwy4996QdI+QYRMjM+Bt9KAkMZjQ9Aq65Wwh+hTdcDdBlkmOJcHdXrFv2g9H892mvpDNNrdRshIMkP4PcPAByiL8x2kw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 DM6PR12MB4452.namprd12.prod.outlook.com (2603:10b6:5:2a4::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.47; Thu, 9 May 2024 14:53:43 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e%4]) with mapi id 15.20.7544.045; Thu, 9 May 2024
 14:53:40 +0000
From: Zi Yan <ziy@nvidia.com>
To: Lance Yang <ioworker0@gmail.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 akpm@linux-foundation.org, willy@infradead.org, sj@kernel.org,
 maskray@google.com, ryan.roberts@arm.com, david@redhat.com,
 21cnbao@gmail.com, mhocko@suse.com, fengwei.yin@intel.com,
 zokeefe@google.com, shy828301@gmail.com, xiehuan09@gmail.com,
 libang.li@antgroup.com, wangkefeng.wang@huawei.com, songmuchun@bytedance.com,
 peterx@redhat.com, minchan@kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Baolin Wang <baolin.wang@linux.alibaba.com>
Subject: Re: [PATCH v4 2/3] mm/rmap: integrate PMD-mapped folio splitting into
 pagewalk loop
Date: Thu, 09 May 2024 10:53:36 -0400
X-Mailer: MailMate (1.14r6030)
Message-ID: <5E6C3511-EEB5-4DE7-8838-281E3053A0C7@nvidia.com>
In-Reply-To: <CAK1f24=PmS1RMQ6=0dgX_q9xqUthWOjJBz_FE-Ndb7MwGLWYdg@mail.gmail.com>
References: <20240501042700.83974-1-ioworker0@gmail.com>
 <20240501042700.83974-3-ioworker0@gmail.com>
 <0077A412-0AF1-4022-8F49-EE77AE601ECB@nvidia.com>
 <CAK1f24mRVam3w9CZkq4O0smGUTVUQfdvA48mqsU+NKxMUxdz1A@mail.gmail.com>
 <B1DA2DA4-AFEA-4541-8DFC-0D815249A064@nvidia.com>
 <CAK1f24mpt+ZGow4LLdXKZcwopmkZDrM_eh15SnkEgpiBXTmOwA@mail.gmail.com>
 <10BA9EED-A2BB-44C2-B80A-26527CDFFA50@nvidia.com>
 <1B2017A4-A252-4C1F-9608-D43ECEAD53B1@nvidia.com>
 <20240508155253.GK4650@nvidia.com>
 <30469615-2DDC-467E-A810-5EE8E1CFCB43@nvidia.com>
 <20240508163526.GM4650@nvidia.com>
 <CAK1f24=PmS1RMQ6=0dgX_q9xqUthWOjJBz_FE-Ndb7MwGLWYdg@mail.gmail.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_AA8324B9-3F0F-4E0A-8AE5-E5A4FE698CE5_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR16CA0004.namprd16.prod.outlook.com
 (2603:10b6:208:134::17) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|DM6PR12MB4452:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ce294ed-9567-49b8-fa50-08dc7037d03c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|7416005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OFRFYnVjTndkT3hVNFhUdXNkZmNreDZ2YURQOW5hQlZ3UGRiV1pEVmJqVzcr?=
 =?utf-8?B?cjlnUndaREN6N0FZdFI4VW92SUpUZitIdzF1WWxGQ2VSaGhHVDN1MUVwV3Fy?=
 =?utf-8?B?NkF0MHpIYWh1dFlteHErYWJ1RFVjdXBoQWREbkV0OWpaNnloeEVzLytuMUdk?=
 =?utf-8?B?cXozTGxPRTFzMDdMM1V0N1ZFNzgrNXRQem4yaS85R1E4cGcrZ05MOEhaS0Y2?=
 =?utf-8?B?dnh4dGdra3E0VjBJMjlFSDZLaUxYdVFSb2tGV05JcExYeG5XMXJRanFGWDBR?=
 =?utf-8?B?NmdCbHkwUk5DdDhWZzFjeTJ0M3ZNdmlZRXVPOTRQSFZ4V3BhVTh3Z1E3Z0Rl?=
 =?utf-8?B?V3ZaUGZLWlJnUy9hWDM2STZDcldFSjhvUC9yOHh6M29KeStjMFA1OEs1TklB?=
 =?utf-8?B?dGZoLzdSeElMZ25mUUJyM3M2RzVNNUNSOFNSUnEwbk83dEE1UU4zOVdnUHc5?=
 =?utf-8?B?cDZPRlRVUGFTaXR5d0hHeVRxQzBqdVV3NnphQzZ2MUlMUmlPZmdJTi9ZQ3Bl?=
 =?utf-8?B?d1lsblVXaWZZYStQeG1nZVZNZGR3ZDBvZVlmcCtrQWt1TjE5SERvbW8zVEJn?=
 =?utf-8?B?QUl4Vzh5QTFvcXYrRmR1TXlTT2loRjhHVWJCemZiVEFQM2lmS0svQ2hkemcv?=
 =?utf-8?B?dWtDSS9rcEt0dUVQQ0N3VUhZeFYwd05aMEVkOFEvQmE3M0Exa2R4UjFqV3BZ?=
 =?utf-8?B?L0lEY0h0WmJ5VmpIbVkrMDZYMXErUjFzOFpqMlQ1NHkzVnBLR2tjdmlzbXpp?=
 =?utf-8?B?RGlXOUlQZ3VZRXR4a2pGM3E3TkxpQ3dLaTA4SlM4TXdNRmRRNXNLUkxPT2E1?=
 =?utf-8?B?NnJ4Qi9uMWVmM3pmek53cjRPOS8vOGtkMUh6S0ZHN2Z4WEZHaXZRQ29VV2FL?=
 =?utf-8?B?NTJXbWZ1SkFTWEplZTVqc0IwZkNHR2p0TUFJSVozc21zRjNGNXNERHJQSjFq?=
 =?utf-8?B?RktHVFovNWs0UThZK2ordHdkaUQveEE4ZTVPSWpqV0VTME8yL0JsRFRDeXly?=
 =?utf-8?B?eE5mTDRrVytYYjhmRWdINEJ1QUNtWmphSkNkNXhpd0lKYzZmMEl5UDYvV1RL?=
 =?utf-8?B?bDdENGk0eU9LYjdQc2FraWN1SjNzdm50bXk4K25ZcnVHYXVGWFhyWk9XSlNr?=
 =?utf-8?B?RDJNWVNiMjVxaldLeEdaMXlyU3ZZS21pMkVWUy9IMVZwWVZrcWhDbGN1SGgr?=
 =?utf-8?B?cUFvd3hnbk54KzNqUXBzbzZTdUVzL3B0ZE9RangzYTJFd2oweVBVT3JjVFlP?=
 =?utf-8?B?MUxSd1RNNnRmTjQvZlZISnY1SE5yNlI0QUNyZVBVUmNZUldoRmFiRTE2REZk?=
 =?utf-8?B?NGx3dlBvSFVubzJRMEZqdEM3RmFrRUdmQnE0bTN5K2xNcm5GWmhiZ2RoNkZn?=
 =?utf-8?B?V3lYcjRMZ1hEb09xNGxua21QVWdveDRna09IbVpJbjBJYWdqcXFqRHBJTDlF?=
 =?utf-8?B?bjFGZVR0VGg4VG1ZRVllS2J2TnpVLzdWNnF6a2h2a3QzRnFGUHdRRG5iajNB?=
 =?utf-8?B?ODVTeUhBeTV4NXFaL0FXZW9NdExQY2JzdEZKakk3RHlSZUJqMk01QjB2U0kw?=
 =?utf-8?B?WThCb0h5OHNGNHF2QllXbXNUZDJJRjdxbFAvTFZuS1FOdFQ2K25BM3Z3U2cy?=
 =?utf-8?B?cHRBaTZPanhtS3o5S3Y5UER2K1kwOTgvekZtY1JaZTA0ZE9BanhtQTYwdFNL?=
 =?utf-8?B?cENKbEM5dFN4aGFHbi9hN1VHYkE4RkFHb2lzNEp1ZytoUjJlTWFDdC9RPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R05pMi9ZKzZ1WnJhV0pHT1RqVjUrUkpiOXVzOS96RHkzRjBYaENFOXJQd2x2?=
 =?utf-8?B?N0dUVnhyRllZbHJSS05xU0tmQnlKZzVrK0loMkJOTGNwLytEdE52TldUR2hu?=
 =?utf-8?B?ZTg0MnNTMzluQ3RoVWtFTFlnY1pKeFdQZlB6QlFvOTFRWGYxS3AvOGJDZVIz?=
 =?utf-8?B?WnlWTUh4b3Q3Q051a3dFbmhtSjQ5R2FQamdYVkE4Z3pETFhPNkxKcUVISHJY?=
 =?utf-8?B?WDJiMzRnbHhwSldTWUh2MzF4eUZuMzZzQ1V5VGpSYm1WeUtkTmJRY1lZWWt4?=
 =?utf-8?B?Mkl2Q3NIT0RXUDNaem1GV1huRnpTTGk0c3hyQmhvSUJ5cFRRcUVXUFZFcS9s?=
 =?utf-8?B?eWpQaHV4bTVERFRzRlpwZkluZXZrb1BERklWZ09oM1VMQ3cxNWJLWlJhOG9j?=
 =?utf-8?B?UXR5OGt6bnI5cjlmVjN6akVzcmZFMENNZ24zVXdGYkl1b0drcmdpVHF3dVZu?=
 =?utf-8?B?MEpvMDNwM0hJc2JVblhFTVQ4WWRUN2o5UzZ6eHFvUmFNMEpTdTJIa1lCbjNo?=
 =?utf-8?B?aGNIVjJTY2MwaWQzNzFoVmdyRnBZV1lZbTZkZUk2am9ZQkRnS0ovam9jQ0t0?=
 =?utf-8?B?M3FOb0NWcndQcVNCYWxXS3k0QXhFMndBSW9LeFBBcHVYVlB2MFNqRG51VEtj?=
 =?utf-8?B?QlNuV3E3M0NrT0hCUUptTXNERTVmb0w3ZlNRbldDNEZPbmNYeWI4SUYrSExE?=
 =?utf-8?B?aTE2SlhwbGR2VzNDVDRiY1pwc3dYZXpWRmpKSGU1cmh4V2hqanhlUkhta0Yr?=
 =?utf-8?B?UjBtYnFjcWYrLzg0bHZXWGdPWUNyRldFL0V1cW9IQmsvbmdTYmtvTnVxTW56?=
 =?utf-8?B?VnVJU1FHL1pmYVFBM1k1UFRPUUlZeVE2K3A1Ui9TNGtTSEtnN2JVWWFEdXRl?=
 =?utf-8?B?TnllVFdMbTdLWVN6MDYzZEk5aTVMZ0Q2YzR4OFRYZnMweHFGZXdSZlR0S3NB?=
 =?utf-8?B?WVMrODBsSU9tRWFxUm9EREI3UGk5czhOUTU2RzdlcHZRQlluWmh1dzBNQjNh?=
 =?utf-8?B?a29HTjllSUowYUNmNGNubElFTmNGY2dCc2J0N2dYMVJwUWc4ZkRKZG1qdWpW?=
 =?utf-8?B?QkxuYkM5ajcwSmVPM0diOUlDYzBuMGdadkw4MEVTREZIazkxdlRia0c2R1o5?=
 =?utf-8?B?TkxZTDROWHYyQi9kWGRLQldRMVdXRXI4elBXMG1zeXBLNjNsWjc4ZHpiUmFP?=
 =?utf-8?B?NGRoeHBPNDNudXR6SzZRL01GR2FicnU3SHhZVmtpdUlJTlpFR1p3cUt1WDZp?=
 =?utf-8?B?MFNrcFJiZE1uSFkzbkRCbkJHL3kyazFuaUM3L044ZlZnZmtXS3JybkZ2VG14?=
 =?utf-8?B?RHJDUHpISXVQc0tZQzlXUXJoVU5jYXduNnc3U1VBMnk2d0NMZC9lY3VYMjJG?=
 =?utf-8?B?cVY2UUNJK0lBTG5ieldXNjdHWUhUUWVISVJ5cFBWVGpNNTRMTFhYK3RVVnJU?=
 =?utf-8?B?Qlp5NVhwd2RDRGMzYTdsQlV4LzZuWXdZU0hWZzNySUxSeVRJTkNIUjM4bEV6?=
 =?utf-8?B?YStTSGFHOWtYaEQ2bUFVNWRmOWdQV21NM3VOdVllOVJxOWRhdFVDSDQ5SS80?=
 =?utf-8?B?NXZVL2U4aXdQbTF3MStkV2VGbE4zZ1VnbVBsakZHUjFldWZwWmVaNnZHUTBQ?=
 =?utf-8?B?cVVpT3g5aGJVczNlR3ExSTJRNFZsbnRQTjYrVmlaRys5K2hOclB2R1dRSUl3?=
 =?utf-8?B?S1lBS0wwNjV2Z1V5T09veFpxbE5uTTBlU0djcHFtQ29EZUQvcWJrWVBaeWZ1?=
 =?utf-8?B?ZmRuUmZVUkNOU3RIV3NGUnF3MGxTcnJybHFUZGdnU3dwdGY1djlpRUFId0Jz?=
 =?utf-8?B?UURpZGFuSjVSc2JuYlhtV3FIUk5NNGswWlBoeGJzanEzQ3VRMnRVZ0pFLytX?=
 =?utf-8?B?QmM2SERudS9hWENuQW9LcDRqNHN5R2grOStrakQxVCtTQ0U5UURxS2tJT1hY?=
 =?utf-8?B?N3ZoNlRnLzJ6TVExbTltRm4vMmpDV3FjaXlJOTJoRVFNb2lUWVVUUVE2V0ZK?=
 =?utf-8?B?endIelB0WTdxWm5pakpQS0ZDbnc4THpiM1d1ZnlNUUQ2VW16V3RXZVJRWEFm?=
 =?utf-8?B?R2VEc0ZvNUF6VzhKVlREZWRuMjlIUnh4S290M1VBRGFKMHpqUUpYZlpxNHlI?=
 =?utf-8?Q?fPu5DrYCuVokE2vLHoh6v/fT5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ce294ed-9567-49b8-fa50-08dc7037d03c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 14:53:40.1762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FgSmu3CMwmuLRWwx12TJST1GasPwM/cRG0x5VgaJlbcQcgyD+SkMH9Xr9O9jqZZJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4452

--=_MailMate_AA8324B9-3F0F-4E0A-8AE5-E5A4FE698CE5_=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 9 May 2024, at 4:21, Lance Yang wrote:

> Hey Zi and Jason,
>
> Thanks a lot for reaching out!
>
> On Thu, May 9, 2024 at 12:35=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com=
> wrote:
>>
>> On Wed, May 08, 2024 at 12:22:08PM -0400, Zi Yan wrote:
>>> On 8 May 2024, at 11:52, Jason Gunthorpe wrote:
>>>
>>>> On Wed, May 08, 2024 at 10:56:34AM -0400, Zi Yan wrote:
>>>>
>>>>> Lance is improving try_to_unmap_one() to support unmapping PMD THP =
as a whole,
>>>>> so he moves split_huge_pmd_address() inside while (page_vma_mapped_=
walk(&pvmw))
>>>>> and after mmu_notifier_invalidate_range_start() as split_huge_pmd_l=
ocked()
>>>>> and does not include the mmu notifier ops inside split_huge_pmd_add=
ress().
>
> IMO, It might be reasonable to exclude the mmu notifier ops in
> split_huge_pmd_locked(). IIUC, before acquiring the PTL, callers need t=
o tear
> down the secondary mappings via mmu_notifier_invalidate_range_start() w=
ith
> the range aligned to HPAGE_PMD_SIZE.
>
>>>>> I wonder if that could cause issues, since the mmu_notifier_invalid=
ate_range_start()
>>>>> before the while loop only has range of the original address and
>>>>> split huge pmd can affect the entire PMD address range and these tw=
o ranges
>>>>> might not be the same.
>
> As Baolin mentioned [1] before:
> "For a PMD mapped THP, I think the address is already THP size alignmen=
t
> returned from vma_address(&folio->page, vma)."
>
> Given this, perhaps we don't need to re-align the input address after
> starting the pagewalk? IMO, if any corner cases arise, we should catch =
them
> by using VM_WARN_ON_ONCE() in split_huge_pmd_locked().
>
> Zi, what do you think?

Yes, I agree. Thanks for sorting this out.

>
> [1] https://lore.kernel.org/linux-mm/cc9fd23f-7d87-48a7-a737-acbea8e95f=
b7@linux.alibaba.com/
>
>>>>
>>>> That does not sound entirely good..
>>>>
>>>> I suppose it depends on what split does, if the MM page table has th=
e
>>>> same translation before and after split then perhaps no invalidation=

>>>> is even necessary.
>>>
>>> Before split, it is a PMD mapping to a PMD THP (order-9). After split=
,
>>> they are 512 PTEs mapping to the same THP. Unless the secondary TLB
>>> does not support PMD mapping and use 512 PTEs instead, it seems to
>>> be an issue from my understanding.
>>
>> I may not recall fully, but I don't think any secondaries are
>> so sensitive to the PMD/PTE distinction.. At least the ones using
>> hmm_range_fault() are not.
>>
>> When the PTE eventually comes up for invalidation then the secondary
>> should wipe out any granual they may have captured.
>>
>> Though, perhaps KVM should be checked carefully.
>>
>>> In terms of two mmu_notifier ranges, first is in the split_huge_pmd_a=
ddress()[1]
>>> and second is in try_to_unmap_one()[2]. When try_to_unmap_one() is un=
mapping
>>> a subpage in the middle of a PMD THP, the former notifies about the P=
MD range
>>> change due to one PMD split into 512 PTEs and the latter only needs t=
o notify
>>> about the invalidation of the unmapped PTE. I do not think the latter=
 can
>>> replace the former, although a potential optimization can be that the=
 latter
>>> can be removed as it is included in the range of the former.
>>
>> I think we probably don't need both, either size might be fine, but
>> the larger size is definately fine..
>>
>>> Regarding Lance's current code change, is it OK to change mmu_notifie=
r range
>>> after mmu_notifier_invalidate_range_start()?
>>
>> No, it cannot be changed during a start/stop transaction.
>
> I understood and will keep that in mind - thanks!
>
> Thanks again for clarifying!
> Lance
>
>>
>> Jason
>>
>>


--
Best Regards,
Yan, Zi

--=_MailMate_AA8324B9-3F0F-4E0A-8AE5-E5A4FE698CE5_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmY843APHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUTIwP/jZGFz5r5pIOTMCOd0j7KG66OQhe9bQzvLXv
Bakih2ZBF6xvY4JoOflVHHtfA1cEAnnoE8vEpGbtUktF9Ksh6M/mqKn3JgXkNtyG
E9GIPPUC/OrXSA0u+/X/I0olAk9MmOWt5hhaKfXDXsZz4azugF/00KAeEHqh3Mas
oCd0zVh0dijusy8DDHAof7YptiOBTSKcRzCyYKfkmvMQBYG/o0/BYw4D4UkPo1Tx
6XBgOGufIqppHFaOicasX/06ZgJ/emSFwtCBTGHca2c5ANABx5rr7DFRVOCNXrsd
ViWMimXJwx+G/kPEarNgh+VYeQ/i4NN2T13o1heXseFMBPsGiK8hGHk4I9nX/NBL
6OuX2WUqt3rn6eVxn1B4B1I9NRXOyDsqFJ1k7MhIJksc86rPKCPdcKe+hAUueoNo
tHdiLuDc/JfFQO3TC9EkDE8/4L3fLDw77GCDMfGfsn21GDEJGqbGVr+tEKNc+g9Y
GTlmUCbE46glEONgQVsIhJCDlYqFfpqzFJCj008Kq4j+Co+kd1eXUaP7+TRrSmke
1Pcjaeg+RrQfpQ+KL/EA5iUlb+M1piAy+JynWacD/bEuOZMqfP1JNvXXznPBWA4j
qQ+oAcxbtrfpSKSmbjJQQy5BkTY4R0Rc+DkMrTUuUyGtg35KdZ3mCKKeGjBWvdUb
doz/FFVI
=FlXf
-----END PGP SIGNATURE-----

--=_MailMate_AA8324B9-3F0F-4E0A-8AE5-E5A4FE698CE5_=--

