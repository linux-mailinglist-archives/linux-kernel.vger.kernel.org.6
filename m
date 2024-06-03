Return-Path: <linux-kernel+bounces-199751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D34E88FA554
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 00:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 651BE1F23071
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 22:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173F313C805;
	Mon,  3 Jun 2024 22:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="t1w/nl2+"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2064.outbound.protection.outlook.com [40.107.236.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE93D84FB7
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 22:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717452118; cv=fail; b=lGdh0LDzLgYYcPTaEx45zcUtnRUpXFgezJxCbPssGtQnSJ3MO46uBRIDJ2Oe97/fFuOW3tzLKi7ISukszHFx1WpRvNFFBEqPwtIpidMH9Va4AL4VHMQRsLg3Qr3Tz24Czf/3H2DBTzCMoYQ09M/Xu6H6K2aUh9iuvmNOK834x5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717452118; c=relaxed/simple;
	bh=20e3a0+/Pg0pbB5KLxKSWgtXI9GLUczQlZ2WIn2tsvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RQmHotM9jR10zkOFOoe7HZLPfzpSLci3XACXOMNOU+o01CNu+nVrOJCApsnL2Q41KArIosJZHAYX6DKH+oE3AjwlASvYHJNu6xAPtET9D+pg4cSwYV3VN6keElxj2mbEkH2mzdC3zEtnp6ZpvpfGvVxh5xjoVl+EB2mzyN7S124=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=t1w/nl2+; arc=fail smtp.client-ip=40.107.236.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C/RzHqqElhs0ITinI0bHNRuREezFAYGNyFpNioHXlUWe0LlobSxam+T3EcfTxz4bH6P8SXT0WTDC5eBIZZnziRxYxUo5KDExx83Zyt22t03UkA/69pWT/wE/InWHJfJRnXoO6erKfdT1Jq+uYWpr21Zf54lk1n9r6CtAHHb1x8cey1MofVDNXycXgMJIUUN7qu67nnbjfxb2OL0TRUWBSWgWLv2QJ3LWaPhSaZZGMpITE9eCCceBJb9MT7qFzQUm6DXy8/usUPMoUyk79henx9aBgZargq0DVdfuIavwVWdaH1Cifpu5/7wqtN/uttwX8qpTeA383Pt5Hft7U4C4iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ka3AJOmkUPM3UeyIy2TP3sDy8rSNI4UbwZWYR4OLdnA=;
 b=SQpXeoHFlYf51c4e2pyQ4CQKkY8xDXHRqCkxdUEkyUBEaMvr8XX4oNHBPedwxMN8vJt2rhWJK21tr6b+VpDciOOJohpneT0RM8aKv56d88tIwdHly6jTfH0X3XFGfJDFXZflXKZydFCX26FHGNtITAPQVkl+AHQt+MyBN28DoYwBTu18CqVH+p/M4E3Gc+rIhlXeTx78b6lbY3PPlvTBJNxURBlplJBA+Qt/t3akcIHEZ+SRRiLzn802TCrhY1bpuYBJAi1RGiokj3xZmZX1SZk5aTV3WWYGrMYJjSpCRhCYy99SWU7Kd8ixT3BNiFK4m/4hYks5eV3RIB94KyTAWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ka3AJOmkUPM3UeyIy2TP3sDy8rSNI4UbwZWYR4OLdnA=;
 b=t1w/nl2+2KBJt1J8qqrNIE8SbEEsrnvGCZTeQYKWbXDPywcVSirb91ZwTu3gl41JoqE5Am1AW50mKHd9xdvEnbK4SL0aO7OZ9L3wLerDhma6Ry7y27LOo2n74ad8sXe1Bz6yzXd6JZ3kHrpvkAof9iR71jcnjtQnaG5VzACjLToyEgOBEId+jq/MWhwk+7SVVVjDgt/TcpzGO5W866w2PCPuv8JZEPMKRekuAxhPRtp2fhmXvzdwBuAkLBU1sA7yS1ZE4jP8LUgjJv/xuHflKQ/5za1URnG2nS4YK6aIX5cB5fUpFz5mMYbVRWweFsMqXT3lEbUhWrElwe/Tj7W3Dw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 BY5PR12MB4323.namprd12.prod.outlook.com (2603:10b6:a03:211::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Mon, 3 Jun
 2024 22:01:50 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f018:13a9:e165:6b7e%5]) with mapi id 15.20.7611.034; Mon, 3 Jun 2024
 22:01:50 +0000
From: Zi Yan <ziy@nvidia.com>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>,
 Huang Ying <ying.huang@intel.com>, Gao Xiang <xiang@kernel.org>,
 Yu Zhao <yuzhao@google.com>, Yang Shi <shy828301@gmail.com>,
 Michal Hocko <mhocko@suse.com>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 Barry Song <21cnbao@gmail.com>, Chris Li <chrisl@kernel.org>,
 Lance Yang <ioworker0@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/7] Swap-out mTHP without splitting
Date: Mon, 03 Jun 2024 15:01:46 -0700
X-Mailer: MailMate (1.14r6030)
Message-ID: <396D71B2-6881-4A64-A89E-1E6674F8B7BF@nvidia.com>
In-Reply-To: <CAJD7tkYyRCTVwiVeN_AXmzagpAPKKhPg-9UkWk=EWDVYMchvxQ@mail.gmail.com>
References: <20240408183946.2991168-1-ryan.roberts@arm.com>
 <CAJD7tkYyRCTVwiVeN_AXmzagpAPKKhPg-9UkWk=EWDVYMchvxQ@mail.gmail.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_F76A067C-EEE8-4F1C-85DD-6F13FD7EBEC2_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BY3PR10CA0008.namprd10.prod.outlook.com
 (2603:10b6:a03:255::13) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|BY5PR12MB4323:EE_
X-MS-Office365-Filtering-Correlation-Id: 0983c43b-1f8d-458e-8553-08dc8418c533
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QjF0L2xJYU0ycEIxTmlLTWREVTJKU2JDNk1EUjBjVzVQZ1gvbkQwRmtMS2Ey?=
 =?utf-8?B?aFViVmZJTGd1TWlYL3BlMDFIMjlDK2dQTE9xdkxwZTAzaVM0YUtGcnNmWW5y?=
 =?utf-8?B?K29mWFphRVdHRE9iVHBuUGNZUFRIWmJ5SmFBTWxvV0lwSHU4RUl2NDJBVzhT?=
 =?utf-8?B?Uzg3R1k2WmRGSEdBTEd4U2NkR0ZUc05MUUtxWkdHVldmb2RKU2dEWTF3UXp3?=
 =?utf-8?B?NlI2VEZlbkw0dTkzU3pKaHdpMENtaTJHc1FEM0l3aGV4MENtVThiazZLWFA1?=
 =?utf-8?B?M0tZU1hibHdJMGkyRElFUnBqZkZBdzdrNllDM3VOOW9QaXhRd0M1U3Y2cG5N?=
 =?utf-8?B?cHpEbkozdEJMRnFqUXAyZ1VVdnJZaXk3dVYvZ2IxamFCSy9ac1F1WjBRNnlS?=
 =?utf-8?B?UDAzQUFnOUpxSy9sU0JNbWJCU211aTZCTzBFeHZ5a0Z5QzlrSWxwVnpBdU0y?=
 =?utf-8?B?bVBOYWpQaTBtbVVxcjJORDVocXZhRDZXeGJRM3ROemJuTitSbWczUG9lelBT?=
 =?utf-8?B?TFpNKy9ibTMwSTBPUVNWY0NHTzIzTnNCZ1EvWVVRQjU0SHZGaXJraXpkSG9H?=
 =?utf-8?B?NjVjWUIwUFpoaUhKNFNwN1o2alZkNHAwUDBndnpxVUlObnVDTWtTTXFkQkg3?=
 =?utf-8?B?ZVdJYjBxbkI2UXViUHRoRkh5TzhBQW9FcmNLRE11T25tWno1WGp0eTJSMTAr?=
 =?utf-8?B?VElGMlNPOFhsREpJcVc4WmR3TkhEWWdzUmZaT2ZoRzBVQWo4emVWV2FTWlNB?=
 =?utf-8?B?N2JDZHhBYXp4bG9GZ3FpbTBqRjNWOUF2cExkcVZwaS9WSkJUWjRjUmxJZ3Uz?=
 =?utf-8?B?Z08xdkc2WjZ4WjNYNVY1MTdNcFNYL2ovRzN0Tzc3KzYzU1JYRkMycUZxL3ps?=
 =?utf-8?B?aTJlNXhiNjNwWGtWNDVvZEhyRC9ZMUh0dTdvN1VJUTBnd1ZKVnNTN1NvTUFB?=
 =?utf-8?B?MkRoTG5oWStHV3pXdktaUTNNOURPQVU0ZGtrd3d0VmxUTkFDNWp0aDZqVDlm?=
 =?utf-8?B?Vy9WVzNMNDVYUlVYK3dva1p6d3RsNm1JdUhDT0d2NDhyKzE5SjhSbnFvNjJl?=
 =?utf-8?B?TlhIWkVQTU9DQXRpa1dYYWpRSDFxdkxFTGhjdkNRakQ4aXRQcnJ3d1lPVXRk?=
 =?utf-8?B?TXJ1NFJiTTUwZnlxYW1wVnJsdldtaDlhMHNiSEhSdDBXNi9NVFM3eHpVYi9p?=
 =?utf-8?B?a1lacUpFem1NdUtNOGp1dnc5V2VZU0syS2QxblQ0d0FycXZObklWUnhEb29T?=
 =?utf-8?B?U2Vrc21lTWQ0ajFuaUdPVXpCNTAyS3lXR0tsYzhhcCtxTE90R3E4OUJEUjlY?=
 =?utf-8?B?QUovTmgxSENYYUlaVml1d0hORVB6UmJXaTQvVCsrWjRGNjZoVUJtbUpCdzRY?=
 =?utf-8?B?bk96TGc5aDdYT0puOFh2VTZYTEZ1ejFQQ3FPYXVOcHc1eHRXRnJuODVKdi9l?=
 =?utf-8?B?SFY5SEhqY3RlbzZtM0lzSWdiYnIyUWk0dGEyQnVFQ2xFYk43VlJBQ2Faazdu?=
 =?utf-8?B?a282VWY4QU5HcVkwdnV2TW42YXB0UTRUZnpCejJzK2VDK2NWbFFJWTcvK2Zl?=
 =?utf-8?B?dlY2N2twaGEyWnk1TnlaKzZRM0RFUUV3bFFkZ1M1aVRTbVFpREhpeTlDOU1V?=
 =?utf-8?B?emhZQ0NTalhlOW9QRzZxeWh0aWwzRHlXL2gzRHJZQW9BZ1I2bFZqSWtnNlpj?=
 =?utf-8?B?ZFlReXZsNFU5UWh1cHozNE9oVVkxdXltZVUyRGZFWTRsZDUrMXpxMU51SEpP?=
 =?utf-8?Q?hFIMkI5n/Rl0Kd0u7o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TEJEKyszdXBEczJJMDVrbVlrL2hGK3BNZlBNalBHSzZSNlFPV1dFdjRtTnNN?=
 =?utf-8?B?WjIzME12V2JyOG1XRElWdm1lRzFxV205WUd5MHFISnFpN1d3S0ovZnlxazZC?=
 =?utf-8?B?OFdSSSt2NXBKdzhxVGNuc0VvRzkxME14eGlmZ244ZndRL1NqU2tNOUl5TWJM?=
 =?utf-8?B?YlJqSUNBNXI3U1Z1cGE4dThzZlBHYWpPSDhQMGZrMG1LV3k2UmdlSyswR29p?=
 =?utf-8?B?cHEyQ0N0QXcyRmhoQ2ZuWXlBT1k2YTlrOHlEdllrQythSE5ETTJsaVBsc3RB?=
 =?utf-8?B?bmo4OXJFbTBLanRTM3JuYkRHSXhSaTYzQjNQN3h0cGZpZUxOcFZRQnRRL1VK?=
 =?utf-8?B?OVBROW9hUjd1ZEZiK2NHaHJ3c0U5RG9kMDJZZXF3MndGUXgwS0tmeFFQYUkx?=
 =?utf-8?B?eWxVeFM1eGZSWjBrMzk0ZHQyMmFpYTNSbCt2THZBSzYwZnQ0MnBuN2RJU0pQ?=
 =?utf-8?B?STJHeVVjWUZ3RExiOFVyb2lQUnBXeThvYmlla1pYbGEyRUt0OXl6U2g0SWtB?=
 =?utf-8?B?NW9aaXdzMnpuVWpDU1MxaENQSFlVaUw4cEc5OFE2MnpZWllKRlRjTC81U000?=
 =?utf-8?B?ZER1M0VrODdTc09Bc0xoVktmWDZoVWljdFlqNCtPaXNkdm1PdXJzSlpuSTQw?=
 =?utf-8?B?Q2JicS9ZTkNhUVJOYWpnbTVyVk1kbE4wVU5NVkdJTjM5NEE1SmpxZDdXNENs?=
 =?utf-8?B?VkpJM2lndVVKZDYxclZhYWRXWXAxNndKVGRCTUtNNU5ScEl2dGp2VkFTZkR3?=
 =?utf-8?B?dHJ0RWRNdnFkdk80TUtvbENIUUNJN1lxZXRkMHh2bWtLMlJheDh4dXlwemlZ?=
 =?utf-8?B?a1NENTJGOVJtanBHSkJNc3pFS2RsV2lsQUUzM3ZFRVhpK1NsSGFraHRpV2NR?=
 =?utf-8?B?V0FTcVVCMmRQTU1nNFRSd05lZmtOYkRQRkhDZ29LUU5yTnJXNDJJMzJmM2pE?=
 =?utf-8?B?b3AwZkpPVHZlOUJTa3MySG9ZbXRLUy91eE5DdlVmbHp3cXNPNzFBMytPVnpk?=
 =?utf-8?B?UDNRUUxSRnJFMkhTTkkrWld3ZGk2bEd4bDJjemhmNmtRcDRXK3hVYUNyYjBY?=
 =?utf-8?B?VWxJU1R0bjZseWwyUnhrU0pMSmdEVjdHUkxsT2NObXFQaXZxd3kvRnRGVEVz?=
 =?utf-8?B?U2RnaEM1M1VQWEM1ZW1TdjVoSlk2bFpZUWlvVmV5U0lNMFhOYVljdmhQZnI2?=
 =?utf-8?B?alc4bnBodW1sc2NmVStaZUkvNk9SaUhUcmJNWDZlRWxZb281aDlqRlBtVU81?=
 =?utf-8?B?SXVoNFoyMnAyQm41RHdFSEVkSi9BblJQbkFoTmVSaDNNNE03TkJHby9YS21n?=
 =?utf-8?B?U0djaTZiN0plK1QrYnJzZ3l5K0wyell6YVMrVlp3UUg2bUd3RnJ1blhwTkFG?=
 =?utf-8?B?cTBmRHJHdUl3cWJGNDZ2dnEyU3U1STdVaWUyNTd5ZmlHRTNsTjlhODNUM2pW?=
 =?utf-8?B?Y1hxZjdrd0lsOFN3ZHRpRHgxU0xIYnNZRGxhc1ZHb0hrWHh1QkRxNDlqblQy?=
 =?utf-8?B?VXJjWlptUUNCMVpLZzhBUXl2TGxnVVAybmQ5eWthVitrcDNVVjVJeklKald1?=
 =?utf-8?B?aEJLWk5XR0k3YStZQ3JjYm5CS3FDelJLS2tIVzk2aFBTWVNCY2NLZmlTb29x?=
 =?utf-8?B?TjlPdUVvWVJ6a2MwbWdkZ3hMMUEzRURsUllXVnVuWkk0TCtkN0ZQSDBORUlL?=
 =?utf-8?B?UlJlT1pwUHA5SVpIRVIzTnB6MTFLVWF2YUMrMXlkYWpOOE5CYnZEWDNCSG5j?=
 =?utf-8?B?S2hrQ2pZNjQ5dkFmTXVIc3hCODc2N2tnNXBsWW5QUFVvN3JuTWRWY2dob0t1?=
 =?utf-8?B?bHhkOHVNZVkxSlI5dVFNR0lNMXRjcnZYRTdwRFdiak5wdlk2TjVqN1RpQXFa?=
 =?utf-8?B?MDZIc1VmRzE4TVlXTUlhSTR0M2tHYzd6K3pHVG9qcEhoNGptV0E3SUxvdW51?=
 =?utf-8?B?ZFMzSExHbG9Ec1RZWVZ3dUN2Wm0wZHhtVDE3UXl3ZmppdXdlR0tHa3lJVDVp?=
 =?utf-8?B?aHl5eTlxNkxyWnhnT1J1TlN5VDdEZTgxWWR6QVZVL3VkNGlDYnc1eXcwcmxp?=
 =?utf-8?B?clRuSmZ1TmdmeTBJTkpGZmwwblhVckJ6emhacnpBbnFTZ05LaS85cllpRFhW?=
 =?utf-8?Q?RuErxz5daJTxGA1CuBJotLqyC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0983c43b-1f8d-458e-8553-08dc8418c533
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 22:01:50.3684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 15XJ5Sg8M0UdBEpU0pD2mOrWrF21JJzYfy6pnJChEAl8M7biCCAaRfQegqLG2Dmq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4323

--=_MailMate_F76A067C-EEE8-4F1C-85DD-6F13FD7EBEC2_=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 3 Jun 2024, at 14:18, Yosry Ahmed wrote:

> On Mon, Apr 8, 2024 at 11:40=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.=
com> wrote:
>>
>> Hi All,
>>
>> This series adds support for swapping out multi-size THP (mTHP) withou=
t needing
>> to first split the large folio via split_huge_page_to_list_to_order().=
 It
>> closely follows the approach already used to swap-out PMD-sized THP.
>>
>> There are a couple of reasons for swapping out mTHP without splitting:=

>>
>>   - Performance: It is expensive to split a large folio and under extr=
eme memory
>>     pressure some workloads regressed performance when using 64K mTHP =
vs 4K
>>     small folios because of this extra cost in the swap-out path. This=
 series
>>     not only eliminates the regression but makes it faster to swap out=
 64K mTHP
>>     vs 4K small folios.
>>
>>   - Memory fragmentation avoidance: If we can avoid splitting a large =
folio
>>     memory is less likely to become fragmented, making it easier to re=
-allocate
>>     a large folio in future.
>>
>>   - Performance: Enables a separate series [7] to swap-in whole mTHPs,=
 which
>>     means we won't lose the TLB-efficiency benefits of mTHP once the m=
emory has
>>     been through a swap cycle.
>>
>> I've done what I thought was the smallest change possible, and as a re=
sult, this
>> approach is only employed when the swap is backed by a non-rotating bl=
ock device
>> (just as PMD-sized THP is supported today). Discussion against the RFC=
 concluded
>> that this is sufficient.
>>
>>
>> Performance Testing
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>
>> I've run some swap performance tests on Ampere Altra VM (arm64) with 8=
 CPUs. The
>> VM is set up with a 35G block ram device as the swap device and the te=
st is run
>> from inside a memcg limited to 40G memory. I've then run `usemem` from=

>> vm-scalability with 70 processes, each allocating and writing 1G of me=
mory. I've
>> repeated everything 6 times and taken the mean performance improvement=
 relative
>> to 4K page baseline:
>>
>> | alloc size |                baseline |           + this series |
>> |            | mm-unstable (~v6.9-rc1) |                         |
>> |:-----------|------------------------:|------------------------:|
>> | 4K Page    |                    0.0% |                    1.3% |
>> | 64K THP    |                  -13.6% |                   46.3% |
>> | 2M THP     |                   91.4% |                   89.6% |
>>
>> So with this change, the 64K swap performance goes from a 14% regressi=
on to a
>> 46% improvement. While 2M shows a small regression I'm confident that =
this is
>> just noise.
>>
>> ---
>> The series applies against mm-unstable (as of 2024-04-08) after droppi=
ng v6 of
>> this series from it. The performance numbers are from v5. Since the de=
lta is
>> very small I don't anticipate any performance changes. I'm optimistica=
lly hoping
>> this is the final version.
>>
>>
>> Changes since v6 [6]
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>
>>   - patch #1
>>     - swap_page_trans_huge_swapped() takes order instead of nr_pages (=
per Chris)
>>   - patch #2
>>     - Fix bug in swap_pte_batch() to consider swp pte bits (per David)=

>>     - Improved docs for clear_not_present_full_ptes() (per David)
>>     - Improved docs for free_swap_and_cache_nr() (per David)
>>   - patch #5
>>     - Split out change to get_swap_pages() interface into own patch (p=
er David)
>>   - patch #6 (was patch #5)
>>     - Improved readability of shrink_folio_list() with longer lines (p=
er David)
>>
>>
>> Changes since v5 [5]
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>
>>   - patch #2
>>     - Don't bother trying to reclaim swap if none of the entries' refs=
 have gone
>>       to 0 in free_swap_and_cache_nr() (per Huang, Ying)
>>   - patch #5
>>     - Only update THP_SWPOUT_FALLBACK counters for pmd-mappable folios=
 (per
>>       Barry Song)
>>   - patch #6
>>     - Fix bug in madvise_cold_or_pageout_pte_range(): don't continue w=
ithout ptl
>>       (reported by Barry [8], sysbot [9])
>>
>>
>> Changes since v4 [4]
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>
>>   - patch #3:
>>     - Added R-B from Huang, Ying - thanks!
>>   - patch #4:
>>     - get_swap_pages() now takes order instead of nr_pages (per Huang,=
 Ying)
>>     - Removed WARN_ON_ONCE() from get_swap_pages()
>>     - Reworded comment for scan_swap_map_try_ssd_cluster() (per Huang,=
 Ying)
>>     - Unified VM_WARN_ON()s in scan_swap_map_slots() to scan: (per Hua=
ng, Ying)
>>     - Removed redundant "order =3D=3D 0" check (per Huang, Ying)
>>   - patch #5:
>>     - Marked list_empty() check with data_race() (per David)
>>     - Added R-B from Barry and David - thanks!
>>   - patch #6:
>>     - Implemented mkold_ptes() generic helper (pre David)
>>     - Enhanced folio_pte_batch() to report any_young (per David)
>>     - madvise_cold_or_pageout_pte_range() sets old in batch (per David=
)
>>     - Added R-B from Barry - thanks!
>>
>>
>> Changes since v3 [3]
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>
>>  - Renamed SWAP_NEXT_NULL -> SWAP_NEXT_INVALID (per Huang, Ying)
>>  - Simplified max offset calculation (per Huang, Ying)
>>  - Reinstated struct percpu_cluster to contain per-cluster, per-order =
`next`
>>    offset (per Huang, Ying)
>>  - Removed swap_alloc_large() and merged its functionality into
>>    scan_swap_map_slots() (per Huang, Ying)
>>  - Avoid extra cost of folio ref and lock due to removal of CLUSTER_FL=
AG_HUGE
>>    by freeing swap entries in batches (see patch 2) (per DavidH)
>>  - vmscan splits folio if its partially mapped (per Barry Song, DavidH=
)
>>  - Avoid splitting in MADV_PAGEOUT path (per Barry Song)
>>  - Dropped "mm: swap: Simplify ssd behavior when scanner steals entry"=
 patch
>>    since it's not actually a problem for THP as I first thought.
>>
>>
>> Changes since v2 [2]
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>
>>  - Reuse scan_swap_map_try_ssd_cluster() between order-0 and order > 0=

>>    allocation. This required some refactoring to make everything work =
nicely
>>    (new patches 2 and 3).
>>  - Fix bug where nr_swap_pages would say there are pages available but=
 the
>>    scanner would not be able to allocate them because they were reserv=
ed for the
>>    per-cpu allocator. We now allow stealing of order-0 entries from th=
e high
>>    order per-cpu clusters (in addition to exisiting stealing from orde=
r-0
>>    per-cpu clusters).
>>
>>
>> Changes since v1 [1]
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>
>>  - patch 1:
>>     - Use cluster_set_count() instead of cluster_set_count_flag() in
>>       swap_alloc_cluster() since we no longer have any flag to set. I =
was unable
>>       to kill cluster_set_count_flag() as proposed against v1 as other=
 call
>>       sites depend explicitly setting flags to 0.
>>  - patch 2:
>>     - Moved large_next[] array into percpu_cluster to make it per-cpu
>>       (recommended by Huang, Ying).
>>     - large_next[] array is dynamically allocated because PMD_ORDER is=
 not
>>       compile-time constant for powerpc (fixes build error).
>>
>>
>> [1] https://lore.kernel.org/linux-mm/20231010142111.3997780-1-ryan.rob=
erts@arm.com/
>> [2] https://lore.kernel.org/linux-mm/20231017161302.2518826-1-ryan.rob=
erts@arm.com/
>> [3] https://lore.kernel.org/linux-mm/20231025144546.577640-1-ryan.robe=
rts@arm.com/
>> [4] https://lore.kernel.org/linux-mm/20240311150058.1122862-1-ryan.rob=
erts@arm.com/
>> [5] https://lore.kernel.org/linux-mm/20240327144537.4165578-1-ryan.rob=
erts@arm.com/
>> [6] https://lore.kernel.org/linux-mm/20240403114032.1162100-1-ryan.rob=
erts@arm.com/
>> [7] https://lore.kernel.org/linux-mm/20240304081348.197341-1-21cnbao@g=
mail.com/
>> [8] https://lore.kernel.org/linux-mm/CAGsJ_4yMOow27WDvN2q=3DE4HAtDd2PJ=
=3DOQ5Pj9DG+6FLWwNuXUw@mail.gmail.com/
>> [9] https://lore.kernel.org/linux-mm/579d5127-c763-4001-9625-4563a9316=
ac3@redhat.com/
>>
>> Thanks,
>> Ryan
>>
>> Ryan Roberts (7):
>>   mm: swap: Remove CLUSTER_FLAG_HUGE from swap_cluster_info:flags
>>   mm: swap: free_swap_and_cache_nr() as batched free_swap_and_cache()
>>   mm: swap: Simplify struct percpu_cluster
>>   mm: swap: Update get_swap_pages() to take folio order
>>   mm: swap: Allow storage of all mTHP orders
>>   mm: vmscan: Avoid split during shrink_folio_list()
>>   mm: madvise: Avoid split during MADV_PAGEOUT and MADV_COLD
>
> +Zi Yan
>
> While looking at the page splitting code, I noticed that
> split_huge_page_to_list_to_order() will refuse to split a folio in the
> swapcache to any order higher than 0. It has the following check:
>
> if (new_order) {
>         /* Only swapping a whole PMD-mapped folio is supported */
>         if (folio_test_swapcache(folio))
>                 return -EINVAL;
>         ...
> }
>
> I am guessing with this series this may no longer be applicable?

Yes, you can remove it but please make sure the swapcache code below is r=
ight[1].

[1] https://elixir.bootlin.com/linux/v6.10-rc2/source/mm/huge_memory.c#L2=
868

Best Regards,
Yan, Zi

--=_MailMate_F76A067C-EEE8-4F1C-85DD-6F13FD7EBEC2_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmZePUoPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKxwIP/2WIxfArtD/OK/ttBcb0syfdZvrBBLT6PjVQ
ayUfc8D2Grv6hk80s5Wnuo8CSec1j+ObHQC1Ebis4hoPWgZQyJkiueCFXKA/QMFr
LxnVwgPwv+r7RZ4aU+nbe0Zk+SgDEwFrjxHVFgT8ySFE+pxTDIUTFdPYrbg9h4an
kGoCgQKDELTRyk+X9ZXUGpM15++UegQH6W26nOa0FcpFx27JLrut4znXsN7oZv2I
WAXNGw8Emmfv89uM+J2xZFdXjlqgK0GwsXXqHoRSZ6lvSEJObiUQGlmCDQ0wVERb
2V13NWgCfwF1QjLD2DewK8hb/xtZOJ+sIElQ7Gc4MZJyHW0HhElULGAG56kRH+0P
xjn03OHNMBGt4AufkDwjqpiWJ+SJ1ZCBPgRLl0FQzgDgNrHeBay3yH2sdS9f2SBy
wPkxfYyH3r00nUcVs5xzEZ1offkiujmm2zwPnkp8fcAgRGLV0eh+I+rWsZnNRLRv
4NsCWOwO/IN9Wl9ttlx/NB5ebuzNg43EB5pcJ52jrl8Q57IyJ+Oa39lQAHWn3/6B
slbEdtgh3bEd3N9/E1x1U6wGmixTc6/8VeNNG/tXlGGXhm75pOx9AEYcfvbKfpUg
TL9sBr05zbdEJ+VZOaLDzZDQVm5q9sqpdhfZrOV7bmJEjr3Cqz5VzXouGp5EGoPa
vjSC3Ss3
=SlVe
-----END PGP SIGNATURE-----

--=_MailMate_F76A067C-EEE8-4F1C-85DD-6F13FD7EBEC2_=--

