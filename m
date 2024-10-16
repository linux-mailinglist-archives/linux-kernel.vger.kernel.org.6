Return-Path: <linux-kernel+bounces-368843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B82759A158F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 00:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D9C81F224C3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 22:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9DB1D2F5F;
	Wed, 16 Oct 2024 22:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dg7LdMZX"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2051.outbound.protection.outlook.com [40.107.96.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C241D2780
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 22:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729116335; cv=fail; b=pTBesy51VhM/nFEqdNijOQyEeA2lbqjs8uM3hKb8Ue1ZHUK9NrEZk7JjvWEOBFNJSe3cKPiZ7p6ZcL41vpOZAsA+NyEWncrW8kor3Oox4RsZ+dbdMz8D8uVkDBZ16ADzvQpJi6byC3fjXwi4IlSjjh1mWHQAnl25GKpL52iJlYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729116335; c=relaxed/simple;
	bh=/nAggUQuvOo5V2i68km1lyrLzf4qIGGOhSN7lyQWfWE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=a9KDGMlWmsvOej18Ueoz6Il7wvWioO/b3BoSfVB8epVkFBICGZy4RKoBCHXCVMfbaKQYuEIUNQ12e+WzqRk20W8F6OB+8+FApE64qDXAxJwSOVhWY/BNKA7CW2WBkxQqWME1HauJewT6HXbj6lLkRTZhdP4f9JlVQWQJzAdaaS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dg7LdMZX; arc=fail smtp.client-ip=40.107.96.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m0XB9A/05cCoiIJAHGq8FuFOUCxKBOsx23IlaBd0iKrAmbOj8tK6hy4QI4fL4N+BKH8M/9hOUI81O05XfRALBho+ien7KXMtVbucaxf2OfgKtmWdQipOjKiZKsAqT6J/gM16dJqSf0VteAddgvSOcaT++w9MoWuidOtTtQVCf1bAwUkuMgJ/iB3tZ+ZCOWbJ7e9T6xFhsXT4L87dpYOAnWEgCCuwkOZJLIuZDHw0pOXKdcYCJ3Qd1NlBJjGVIzFr07nCzDfzLl+DFTdOz4pBDNbmWL+oGyj5gisH7gCf+0c1CZgN/x9cXfbxazIXVGb8BpruqYRll4d9EjjxopiWkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sh41bIRknF2uJaoEg/G3xclh2/9P5Sw22DU4DuXq9KQ=;
 b=Jq5b8X0ahImbouVBfRhQg4rVOXwtBtA2g5dqfqyegieaOXKnUZVwMtWz2q8XuPi96DYyOfF9iHgbNEiFCQy3loQ5hX+GV4t/KuLMcDbntf+/n3OoZZ85xVjGWgkwObdClabmc90UEK8IbVT/cUz+o7L4FaUQPfiUDuV9bTFQK6WZgiZh0E8wcmjBWP83nYl2mGo6sMdGy7K+i5Jgp/B2YDXn8I+hkLbe7d3mvh//9QGMz0wtZzgIFjq+ByaO4AjmRXh+k49FEtt5WLXXyGzDtyxcsoPY9gELEQaR89cNYvllcofNhM9i5ar+EnOD5oc972WLkmBWkbLtgPZmEQRI3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sh41bIRknF2uJaoEg/G3xclh2/9P5Sw22DU4DuXq9KQ=;
 b=dg7LdMZXDEoOfAumod3Rkb59E25AS43X40hl5MY7RQUYTjG4Y3gmiTQyQHCZGeanPvRG+8KrBeF87XOOon6XG/79PnWfw/C3x0SvXg2dhqJfVoOjmp4mTQ8JrCpV7amgss1SyTF9BhCAL6N+t5DF6QeEu+yaXU13kyzdMv4L/bTChY2FDx2uYPHT1495NJ+zlj9qqIFK88+D66yT+VfKUcffwYfBw7rAsOGgk/fEQhwI0o1ZnT37+pCDWDiimoA0IsNrFQqrL7obGWthe5TBeqtVCCLBVxrTMImvSiZ/7XbcppUWbXd5fniTQLvgNcwhQfVnNlJO8Gqx2Dxsf526YQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ0PR12MB5469.namprd12.prod.outlook.com (2603:10b6:a03:37f::16)
 by PH0PR12MB7930.namprd12.prod.outlook.com (2603:10b6:510:283::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Wed, 16 Oct
 2024 22:05:30 +0000
Received: from SJ0PR12MB5469.namprd12.prod.outlook.com
 ([fe80::ff21:d180:55f2:d0c0]) by SJ0PR12MB5469.namprd12.prod.outlook.com
 ([fe80::ff21:d180:55f2:d0c0%6]) with mapi id 15.20.8069.016; Wed, 16 Oct 2024
 22:05:30 +0000
Message-ID: <5e499b63-8b38-4ddc-82ab-848301fd8d2b@nvidia.com>
Date: Wed, 16 Oct 2024 15:05:28 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/gup: stop leaking pinned pages in low memory
 conditions
To: Andrew Morton <akpm@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
 Alistair Popple <apopple@nvidia.com>, Shigeru Yoshida <syoshida@redhat.com>,
 David Hildenbrand <david@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Minchan Kim <minchan@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>
References: <20241016202242.456953-1-jhubbard@nvidia.com>
 <20241016145739.770543d44313967f611f3810@linux-foundation.org>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20241016145739.770543d44313967f611f3810@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0248.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::13) To SJ0PR12MB5469.namprd12.prod.outlook.com
 (2603:10b6:a03:37f::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5469:EE_|PH0PR12MB7930:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c3a4623-0a7e-4eef-a305-08dcee2ea5e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SUR2bEc3V3VFYUY3SEFaQmlKV29zYUhoMEk1cVcxM1BQZGlhYzdhQkRzS0VB?=
 =?utf-8?B?QmFGaHozU3ZHRDllL2Uxd3lxdWI0ejJZRk1hclNSUzhqSFp1TWJWdFVWMzZk?=
 =?utf-8?B?QVRUd2dNQUhTNlN3cWszNitIcTNHbHIvZXdLaTJ4RVNLWVoxczRwU0xPbFpK?=
 =?utf-8?B?Zis0enFKckdLOXgvUUowSm9hMEJFc1hKZDJidVJTeGtXcXU1K3FpTG5nbU9O?=
 =?utf-8?B?U3JKcFBOS3dseWRwTWpTVXVBTTVDQm5GYTF5UVdSdktrVWQ3OUFBTC9QaVA0?=
 =?utf-8?B?Sy9FdGk2RUtJWDFrSHhUdXgwYjhDanF3VnFkaWtvczlCNlRSVVIvNHljU2hh?=
 =?utf-8?B?WHRaR0ZEaFdhdThHZUh6MkwxOWtydGEzdEZzWmhURXNtdWNnYzljdEwzS1Rz?=
 =?utf-8?B?aEpxWURZVkdEbUpIdksvbHZvUkE4YzNkYzFUMjhNZDJTVk1QaFFjM2lnMnJC?=
 =?utf-8?B?SSs5eUZXRDVtbkRqdGlmMk0zREIvR0RHOFo0TEVVNG84Z1JHVEVvemw0dTBZ?=
 =?utf-8?B?OUxRYUhwTHNoRnNraEFNUlhKL1d5RzBxNFFZOWZKV1pyMklZRGM2aVBQeXhy?=
 =?utf-8?B?L2I1WkI0N3k5NVVPektKTFdtZ29NOURYeTY4VFpjTzNoMDBCQXhJQ1hmZDdr?=
 =?utf-8?B?cnVGeDgralEzSUtGYlM3UzZIWUQ4ZVJiUWVzcDBkM2pFV3ZwQ2xvZTl3cG9D?=
 =?utf-8?B?bTkyR0JLankxN1VLaHNKYnFPV2JYNjB5azR3Rjk1ckVidVQzUCtPdXFPVlNp?=
 =?utf-8?B?VktLOTJXKzgvTDZVUm5PbDF2S3lNaGJrNWR6S0YvU1lCM2ZvZklMTXlGeE5G?=
 =?utf-8?B?QXRLR0tZMUNMYmV4U2FVT2pMbWtYc0J4aWVGVGxaZk1pVFdRVzVOWWJScmgx?=
 =?utf-8?B?SVhYWmp5RmUwWUk1L01KemhVZFVyRC9Uc3E0VnpmSGxZNHRMNGpzWjB5Smoy?=
 =?utf-8?B?NnE3dm8xeEg0aUR1UzdRSmdmdTdCbC82QVBzV1Jpd2QwVXo2U2w1cXI3c1ho?=
 =?utf-8?B?d3A5amo3bkc5S1h0K0J2S2g2SXgyM1FraEN1bFhHdDY4SUk3V1YyMVhQSUQ2?=
 =?utf-8?B?WXBjWVlqQXFwN0piVDZlZlRTMk8rSmZPY3NKQjc5R20xdW4rdDNGUU96M0dP?=
 =?utf-8?B?T09VTktYSWorN2Rvd3k0OUptWmMwWG9nOU0vU2hYK1VZQXVOM204SUlpUUFX?=
 =?utf-8?B?WGtMSnJBTkpMRVhNVkxNTklHbVpGZzkxSks2ZTR6aTZwdGsyWUswQm5Ya0I0?=
 =?utf-8?B?c0VaMmsrN1F3aUdXbkpYYjdkNzNVRDlzU1dvVEd2NnVhZVpkVDBDNHNuL0ZL?=
 =?utf-8?B?Qk84aGMzUWoxOGlkS2xQL0lXeUFsNkF1N1d2SlY2M05IMUY2dE0yc1g4Zy9q?=
 =?utf-8?B?aHJaODkzUkhPYmRkS0RoR21PRzgxZ3Fmd0hGTVJCcGlNZ2k2QkwxUTRUVVV5?=
 =?utf-8?B?VHducjJMUWE0Nkd1VUFwNFpPcjNqYXEwVzBGZXlmeGdGNDVZUUFJSTlJVmIv?=
 =?utf-8?B?cXd1ZnliR1N5L1pjT0FYczZMUDFCZmpGMENxdWlJMjRKL2RaZ0xoZnZTVWRH?=
 =?utf-8?B?OHd3SFN4TXpPY09rTXE0RXRhcVVVcCtkRmpqeHVzblhIUnEzU3FTUmR1VzNX?=
 =?utf-8?B?SkZJVFhCcDhXY1lZeERqRWJTdlZ2QXhtb1dtNjFvRmliRVUyL2tSei8vS0pG?=
 =?utf-8?B?NEJ4SDRBb05zSWN0bUJOMzJBMUxtVHRIUVVtUXhnY0FHZGV5YndrUitRZC9B?=
 =?utf-8?Q?IHGebcg/iLHyFJBvDAHTsmm1GsnpAaSOoraLg/H?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB5469.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VCtNWjRDUG05WnlqK3VSMFB5cHlSK0lWOEpXS1NyVUFaYk1LL21CcGpocHJF?=
 =?utf-8?B?Mjd0YS9XcUFsakdJVDg5QUZwTUgvMzk5QlROQWlPS0JNSFgrZlJFNkNydDMx?=
 =?utf-8?B?SXJocG5iRnRkUkNLWkliSFllU1hZcGYvcXVsUDZUSy9kNG9wcHBqOE1RM3ll?=
 =?utf-8?B?bXRmU1JiTzNWSW5lN3R5L1dBb3NJT0RxMTFWQ050MW1oYUFBa00zN3JaNmty?=
 =?utf-8?B?emJ0NTdia3RiUG5kVE1zT3NtTTlFWW9aYm0xYWlRTXh2OHltVm9CUDE0Sjdj?=
 =?utf-8?B?UEZmdmFzSzBWdFZEUE5rb252empzUU83a045N29KYzhUODNFUzV0cUlHVWtM?=
 =?utf-8?B?Zjh0MitlNVJQK3lOWTF3dys2K3pIUUw0ank4bEJaRnAwOEJCaFhlRVJhcHZX?=
 =?utf-8?B?bU54cWU1ZU5CaTR4UnlEZittcko4QUR6SGZWN3lST3ljYzBWTm5VWWdsaFNL?=
 =?utf-8?B?eTNob3prWms4aVpId09sUy9QdEdpVWF0UVlDSGJhTVZPNEl6MFk3T2k1SGM1?=
 =?utf-8?B?MVpGVWlhNExzZDJtdFRFRTdsR0x2QWtycXU5T1pmb2hjN21BemppU0JMMStQ?=
 =?utf-8?B?aEhoUUZUU1h4cjQvczVCNDVPVEIzR1VTenFlNENUdUdMUUVKZ3Zaa3JvOFdi?=
 =?utf-8?B?TE1HUVJLOXZqS3RpVmdybVY0VlU3cDhPWm4vclg2cGRueXB4SVFNTXFtbkJB?=
 =?utf-8?B?bEdHQTVnekMyMEp2b2ZhMDFBdkIyVmtTRThDS1czL3U3V2RldGw1ODRSRmhj?=
 =?utf-8?B?NGtlTG9YYVVUSUxxaVBaemZiUlVqRFlhT0hod0tHVkwzdWVHUTJ2RVhrWUlz?=
 =?utf-8?B?U1JQaVZDRkZOU2d3OHN1ZmtOYkpsSXZad1BIUFozU3hZdllZK25NNlJoZnBY?=
 =?utf-8?B?TWxqd2VrTFVHb3ZxQ0Vlb2M2NEVBS01uRkhrQXdFNEYyOEpzTjYzUi9CMnBa?=
 =?utf-8?B?WDhYMngyTDRia1RISkVqejlpUlJETFFuOFZvcHpsamVGN25rNFRDc2lKYVZW?=
 =?utf-8?B?R2xoZzJMNHpiTFFGNnJPYnQ5M1g3a1Y5ZmRlYXBsQk1lSXpicHdQczhMVWd2?=
 =?utf-8?B?UHI0NE9VcFVQZCtpckhNMzE4czlSdEJiUjhhS1JVOUNkTmJaNVBNWGtGN3kr?=
 =?utf-8?B?djI1Yk10QkEzMm9JRXArMnFlYURGSHNGSEN0ODFWR25BL1R6QjErM3Foczl2?=
 =?utf-8?B?U092UFAxNnlpQ2Z0amExM3VqSThSS3VXOE9LeGVvOW4zeU1qZDFwc0s2bFF3?=
 =?utf-8?B?dW9EeVlHcVJvSzREWkFla0ZlWVMrQ3M3dUNHRThRMXRNQjhpRjVFRjdQT2lT?=
 =?utf-8?B?enVKMEZkZEVCdC9qSW91TmtSekpqdTJJdzZQZ0l4U1VQbSs0UzdNVm9MeXZj?=
 =?utf-8?B?blp2YTR1OXNpWmozNzhNdDB5dXh6eVZXaU9zbEVNdS9OWHVUelpLSlJmQTl4?=
 =?utf-8?B?MCsxUTVlNDRBYTZsWW4xYVMvZ1ZzWFBYRXg3T2lsNVNLc2pvY0xHaVpyUktZ?=
 =?utf-8?B?RDNjYkdDVWJIdmhYVm43Z0Iza29WSThKMVFOSkVaTHhHNmVwcDdnR2M4S01n?=
 =?utf-8?B?VnJUN0NORHNjNmhTcGNTWnU1RlZreVgyc2Fud1JoTVZVT3FudmxzRU9EeGpU?=
 =?utf-8?B?aGFCZTVsSDlKRk5YZ1BaRkUxNW9vTzg5ZnVRLzBpQzA3RkV6dUVNaXBhQ2Nk?=
 =?utf-8?B?WW5IWmg3NjhkTjlTWXV0Y3BqVEk5OWx2TGhzVjlOZlpLTk5xVEhtdnZLSmxF?=
 =?utf-8?B?NnNvMSs0SlNQVlFOaTZhVGFyL0VuMEd5K0RPcitKYkQyRDlUVzdZenJWMm0z?=
 =?utf-8?B?VElBcjk3bGF4bHJsYVRDaFR4K3JxRXpBZ1Z6RHI5aWtZalpqODErZFZTNS91?=
 =?utf-8?B?L1MzNmV1RndYS1l1aFFvMDF6dmJMMVI5UnFpbmdSUU1YOGt1Z1l4ZmJ4WkpW?=
 =?utf-8?B?RnJ5ekRiN2ZlUkJ3NjhrQUQ1YWEvQ3JYa3pIb3lYVE5Wb0l5dFpOQ3hYUnFE?=
 =?utf-8?B?a05tR0tHZ2haUVNyUzN4clhXQjFCdzI3UnZWOU1RbUZKNHBWRnV1VFVSTUM1?=
 =?utf-8?B?TzBhMHcyU3BhZXJKVXZ5MFd4QkdoZkV3U05xSXdPN0R3MlZzcG9ackpFdTln?=
 =?utf-8?Q?WtqydbW6Ju/qKhAH/dqOgdsQW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c3a4623-0a7e-4eef-a305-08dcee2ea5e8
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 22:05:30.0171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VonxjVjEcEuNjyrz4EtGr03fWbpDJMwbz/iCzubhM+aMPyox7MJHik4be0Fi137IJmde12IKd6f2Yeb5GhQifQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7930

On 10/16/24 2:57 PM, Andrew Morton wrote:
> On Wed, 16 Oct 2024 13:22:42 -0700 John Hubbard <jhubbard@nvidia.com> wrote:
...
>> Fix this by unpinning the pages that __get_user_pages_locked() has
>> pinned, in such error cases.
> 
> Thanks.
> 
>> Fixes: 24a95998e9ba ("mm/gup.c: simplify and fix check_and_migrate_movable_pages() return codes")
> 
> I'll add this to the -stable backport pile, although this seems a bit
> marginal?

I'm on the fence about that. It is marginal: you have to
exhaust memory. On the other hand, a real user reported
this bug to us.

I guess I'd lean toward "correctness in -stable", and
add it to the pile, in the end.


thanks,
-- 
John Hubbard

