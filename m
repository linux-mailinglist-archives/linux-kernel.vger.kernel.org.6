Return-Path: <linux-kernel+bounces-410806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D9E9CE12C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 15:24:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A867C2811A5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 14:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EFCD1CEAC7;
	Fri, 15 Nov 2024 14:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eUKhypDg"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2057.outbound.protection.outlook.com [40.107.101.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FD01BE87C
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 14:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731680654; cv=fail; b=lGIhFXbaOkvzIx2eoakWTzQvnC2A0PGh86CbDjvHKpN8zb2bXHJTnWApUYcSKUS0xPvMXGqTDh5mIzBuEjxZ8u5tRth9Qfu7KyfDUBx+3G/iOXrz4a1guns/gv6MofP/OXsWvXZK/Bsd/bxLIvUXZXGMbA1yL7zdDu2v8zUafzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731680654; c=relaxed/simple;
	bh=DoAa5i1Zy4+WlWNcQKBlRbCnNkOeTz8PyImKUU2pWAw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GHdAfrVrIZJtEesjimc+BB93OwTC5JXt+tKqZvByk9bD/Gw2o1YEQQVnQS7ysGxbHAQyo39jetKQksEPbPEeAHnw27P11xQzGVVq0sEmPivXjLCEDjb844wSXFIGkHHV5yIG1zt/6pzC1c+lcqD0jaen+q23qS7Cu4aK9HUt3iM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eUKhypDg; arc=fail smtp.client-ip=40.107.101.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qldJ5RCkxbESXCNPT4M8VXTvpAPoxYC9VZ5vDp4QaFXPF5tAS63vDhEQbS+Fe23VxWO4kEANnBTGYaJ36rp8NkT2vSbBrEHUnXKRh0I4T8E75OqM6SSvbaCzkIEEPBLqR2TgULvtfXDJILfIuE2RQ7NOj05jREGJDJLiqn5pSuqN2YVDOIKdeDbYrmFwcZND8pWdr84Zt/IC5GMTRCOYPCxboN4YKArrmoEgMuF0z+QSZ/xMn8bW92hMwCv5u4m1AczTq7GO0JJGslY6myG45g3VQDtm8ledr4iByPQOFljfRnPEAxL8X1sQuIrl4RWUhqI9soEA3xNY80lWSp3J7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=okdankMRXVWSUlLzZipoyXh2ga6TIqTKOSZN1QGhnQU=;
 b=Np0gP1KHh06isP0qVze4k9QMqysaPSDlsG29PuavbTFkiP7s5CgyZl0x335PKsjgWLitLsTdweMX7jEwDwx3t9WzhLfUXpZiiRSBIK4DfF2hLH1SceLqfZ9S3xHEhT920jv5m+ZmpZvbiWwOl2KcfX18IdtsNlSl/Q6u76HTy4UefYW9fouDxSIk6mpIwRjRPK2qbMqQrD9rgCYUHwjnS1a8jX0rKe4Y33Qx84oOwDSAvY6ydK1KZvu9w9B5Q/WcWBzdW3lefHqKOxh1DEn1l5QyjsKBC+Nl9ieyIyWoV6x79Lns6FtveQjZmDResqttWD7GrSwh74t9bo/P7LjbnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=okdankMRXVWSUlLzZipoyXh2ga6TIqTKOSZN1QGhnQU=;
 b=eUKhypDgjGtBlLD/m4mFDZxvKwp+ZZOmufX3rfQuKNhSAnSAWYVT+zKXCQ1JTPoUFffYdRIbcDT+lMZi+btWNqVZ32BZaGxd6VlBJv+krlg+hYw3/rOgj573fFKr1i1Xn2iRxNjC8E15+eE1tsyk6ydnHjfm1MV7fPCbPFpf83w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by DS7PR12MB8229.namprd12.prod.outlook.com (2603:10b6:8:ea::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Fri, 15 Nov
 2024 14:24:10 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%5]) with mapi id 15.20.8158.017; Fri, 15 Nov 2024
 14:24:10 +0000
Message-ID: <0dd9802f-ee28-180e-98b2-854c32288a72@amd.com>
Date: Fri, 15 Nov 2024 08:24:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 2/3] x86/ioremap: use helper to implement
 xxx_is_setup_data()
To: Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org, bp@alien8.de
Cc: x86@kernel.org
References: <20241115012131.509226-1-bhe@redhat.com>
 <20241115012131.509226-3-bhe@redhat.com>
Content-Language: en-US
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20241115012131.509226-3-bhe@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0115.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c5::24) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|DS7PR12MB8229:EE_
X-MS-Office365-Filtering-Correlation-Id: ecf59856-ba7d-4287-d3ce-08dd05812c10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VGZpVENTOTZpVkY3TkZQUktnaitjUU44LzBEOGthNzhRRlBqSUpYZFg0L05S?=
 =?utf-8?B?dEFQMW1NN1RIajEyekRpOU1KN3FNK2ovZkFqNCtxOXA2aCtwLy9xaitrb0N1?=
 =?utf-8?B?QUlaM3pYZXJiWHovblBuc0ZUeFRaUzM5ZDFhY2hSVHdnWklSQk9oUXprQ2kr?=
 =?utf-8?B?cC96dDNjMi9Yalk3VjN0MnRsUnlMSkxVWkNleHluY3hqTlJiaGNaTitENktC?=
 =?utf-8?B?Y2lLNGhrSmkrQlZJR0tVWTVCSGtuMUxpZEtYczZtbENDMHRpMFczQXJObkpy?=
 =?utf-8?B?SXNsdXlmTDVXUE5ocng2SUR6bFgyL3dScW1CME5XK2VQUXlpNlUzVHhTSUU3?=
 =?utf-8?B?WU04eDVtM3B3OTY1aTFvZVRQV2Q5T1hXUWh2TlVpWFFpWnFCcnZ2OFV3cEFX?=
 =?utf-8?B?UGdZYU14R0V5WXlxMTZYWnNRZC9tWTV2aEszbHFYcTByVkY0eFJaNklpLzhD?=
 =?utf-8?B?SzNjckdJeDE4NmowRU5BVzg0U21KS0NwZERxdCthRGlTTEIybkFKQjNPa0VK?=
 =?utf-8?B?OG42MlZGZW5iZWsvTHBFTEZnOEJmRWdWSit4bDZMZWNwYVIwRlNIZFZBNnBi?=
 =?utf-8?B?cTlkU09BcmNFT1p0ZFp3SE00WkdDRHN2NDljSE1XaWQ3SUw3bUhIb0p3NFhm?=
 =?utf-8?B?SHd2WEhsand4RlNFb0NDaHI1c3VUb1JXckhMWlFNQXJiemtvS0ZaMmg3dytt?=
 =?utf-8?B?Y0o3eGNkcFM5cU1sSnBjNXFDa0FYbVcyOGg0Tys3aldDUTJ4SzZubDBKenNW?=
 =?utf-8?B?SGs3TW00c0hZRVZxR0lwOXp5d1B1a2VkVlBJamlYOEZKZ0FoamFKd0c3TUNm?=
 =?utf-8?B?aTh3by9sMzRwSWNWWFIrVU1oV1F6YnlTakhPRHR6c2lIM2phZnVnNVNUN1Na?=
 =?utf-8?B?OHQvWGhPcXllZ2t4cXhuaDBEUjd1MXIwYmxmQVJYYXd3TlVOd2lTWHcvR0sv?=
 =?utf-8?B?SEJrOWI1MW9sNVFvY1FqejcrRjRjUExIWjh0Yk9udFNvMTRpQTN0c0RkaGwv?=
 =?utf-8?B?eWtQWSt2MDIzdUltK2J0bmZjUnFDMU9kbUJhR1BlZ1E5R0RRSlRMQjdNNnEv?=
 =?utf-8?B?WjAxSXBaUEtFZ2NIN1RiV3duZjdLaTFZRjZKeUJQaWhPNXJ5ZzhybGZOY016?=
 =?utf-8?B?eFdhdGxnNm0ycndxZE9uNEdKMCtmRWtqRlV5VHVCQTJVcEduQTQzSk1LVm8y?=
 =?utf-8?B?TkswNVFxTEFiTkd1Q21xMDF6dG9DRVFtdDh5SlV0V0xkRmZWTzlaanBzSVhv?=
 =?utf-8?B?YU1sMjkyNzE2T0hRcDNhZ0NnRlM2bllSaDlha3ZSbTMzRUhBNjJXcnI2NGls?=
 =?utf-8?B?a0xpdStkRWRGMlB2ZFBUZkYwUWNQTHB0ekpQeEVOUTlNcVUvOTNWaHBQbk15?=
 =?utf-8?B?WS9nSEh5M2wyOHJjSUNPS292MHBtR2oxcHFOWkpVQ21BUkVwNTZxam5PS0tS?=
 =?utf-8?B?NHRYTE1MQ0lFaDNFWGh1cjYxa3pvczFJcXJZcVpKbFpQKzRRRjhoUklWRS94?=
 =?utf-8?B?dXFYczRtWjZWMnNJRjhQYjh2KytTK0ZkYlNHWk5kSm95YVhua1U0M3dlaGRK?=
 =?utf-8?B?ajFxK2piNnZjUUNkVlU2TTRITDMvenAxR2VwV1p5bWphRStyVDJZWmFjcUMw?=
 =?utf-8?B?VWJIWXpDZ2p4M3BZZ3o3eGhtWEhZeEYxUjBRVjBodjZIelBLYXBNTUFSVVZi?=
 =?utf-8?B?WWpDamczL20wMFJrOHljaEtnS3IyZVozZ2hocDJxZU9LaDZhZytZVisvNkx4?=
 =?utf-8?Q?lRtLdec8jJYxOGu6xKoPcFui1EfXotsrbe9Wlzz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V1haV0d5TEk1a0pKQU83ajVVbDdDQVZDQ2VTRmVjNUd4QXlXdVNMREVQS1d5?=
 =?utf-8?B?QTVieGRkS09aSEppaUF6OWc1MU4xV2tWQ3VtMVNMZU1ENnBkaFROL2YxRXU2?=
 =?utf-8?B?VWFMa2dqSCtPQlB3WXd1RGFzQ0Q2eDNrUHZTa0kza0krby9qd1VIYytxMXBP?=
 =?utf-8?B?ZFZZbUh3VGcreGdvNmdyaCtLNnZJbS9KM1FDSklKamQ0MERLZUlVdTdOTzhp?=
 =?utf-8?B?ZlVycllOWklTUmpoa1J1cHI0QkMxVldjQjhyenZQUm1YU0hBUkw5eEFLVzls?=
 =?utf-8?B?bURSTjdURzdvcURXUEYwL04vaDhPM294dG9OcXE3MTh0Rkk1ZGRPTVpORkZN?=
 =?utf-8?B?cWRaSU1adTlmYWNPWWtIdHo2WjNnTHh4WXlWOElIRTRxQklOK2tQbThDTkZx?=
 =?utf-8?B?MmJOVHM3cFd4Q3hYU3NZT0o2Zy90ZkhsNmF2UFBCcktYa3ZscXVkOGdjOW5N?=
 =?utf-8?B?V0MvZ3pWcDNldElkd29wUjVQWXF3eDhOdGlPL0p2RWgwNytkQWQ3SHg1OHAy?=
 =?utf-8?B?OERRcnlSODVkQzJWR3BjdEQyYWdvM0N5amZYK0NlZ20yYkZGbXhvUk5zRnlM?=
 =?utf-8?B?M0lHbzYrV0FHMjdDVExkVlhnVm5PQTVMdGR0QlVpWUtMTy9sbkdldWUreXJY?=
 =?utf-8?B?Y0VxNnVjM0dsTEN5MWNWVWZPQXBHQk9HZzZ0WDFjWG9sWG5BZkpIWlBSZlFR?=
 =?utf-8?B?Ulk2U21HOEpBTFJpRWZMRkxmQlBBZFpSaW8yNkVmd1ltR1d4S21lREVadzlr?=
 =?utf-8?B?OTVlZ1RNTGRvS3lFK0hxdndkMVZ1clIzbWdGaURNMzNCZkhYbktQSjR4ZTFL?=
 =?utf-8?B?Y1Q0TVlHMEJqMWRMNDA2ZjlnSnV6cnkrTFYzNzllUUMwWW10WkVDc21wR0pC?=
 =?utf-8?B?eWNkRDJPY2dnNjBZSEtmcXNsNlN1VGdBd2FORHVJcGtyOXVidXVORm9aK3JZ?=
 =?utf-8?B?MFBHQnM3a1Fua0luV0ZOeU9yQXdUay80VWE5ekxpNTYwb0pDMGtMQUNCV3dn?=
 =?utf-8?B?bzB4Q1duZnJCN0UyRDZuTmhBTmw1bnZXVk4xT0YxWDVPNXdQNmVtWVF1RWRV?=
 =?utf-8?B?OXYzWFZ2aFpJZGlQOG9uY0hHYndkTk93WkloYnFqOTFLUXlrVWVhTGI3MW4z?=
 =?utf-8?B?NCtQWVNwV1IxTi82ZHdOc1FiLzZ5YkRocVNPTlRZVUdQNFlPSGNaVjg2dTBQ?=
 =?utf-8?B?Z2R4R2hxd3RKTXk3WXU1Rm9Xb3dpTUwwdEp2RnloTmdLNHZwbnRTVVFFVk5E?=
 =?utf-8?B?ek90RUVlV1UwQU9meDROTjR1WHZIN2F0OEIrWisyNkxTUkppZldBalRvTEZk?=
 =?utf-8?B?Mm1RVDVqdTFhUEltTXRXdzJ3bXBycGxnWWlxMDYwaEU4T0tnK1Jyb01pT3RD?=
 =?utf-8?B?Wi9NYWlpT0RDVVQ3UExJdGhuV0FaVlRmb2ZXVFZDd1JLL1ZoRUZUcVZjR0xD?=
 =?utf-8?B?ZVkycWliSzEyc0x5bmgyZTdwVWtPcWo2aG5wNkw0eElFQzkrNHBRR2xCWFdT?=
 =?utf-8?B?dGlCVnBXaUxXK1FvakhsK3VFMXFCRUtZM2huMEhhYzJIRFFzVkhHUWZ2UGh5?=
 =?utf-8?B?V2ErR1U4dVFHdmcrK0RmWkRhUmYzbXNnbDM5a1hqQXlJUUVuU2xZbUZVeTc3?=
 =?utf-8?B?MDl4V0xyNHlHZFUwOFJFSmczNkRkZ3QrSHNGTkx5dDcyb29HUnlrV29JNitN?=
 =?utf-8?B?QmFjWSt6S0xtbkF2amZaZG5iUFdSUTY0ZHA3NTBtUjRFVTd6VHZIWjgyODc0?=
 =?utf-8?B?T21EelNkUitvRDFyMGt3azdqMWxIOEgwM1Y3K3FWVUEvamw2WFFEOVlBWWtF?=
 =?utf-8?B?N2RDSHduamtHczF5cEprV0NRa3BNWGtrTG5NcFJjOW1jbzlKdUIwYXdncDJE?=
 =?utf-8?B?MFpNVHh6dVBWblI1VGNUR1d0SXZtVGQyTGx2VUlrV0hDN1V3MnZSUHNBYkto?=
 =?utf-8?B?VUtGeC8rNFpVQkRkOU03Y1ZlQ01aYmJ0MVY2amdySE1rYXBDNDEybzV1NW91?=
 =?utf-8?B?aHpib2NpN0NRbldRMnRXaFJ6NnBIY0pPOWpvdWQ5UXo3bm94K1JNdHRUYm5Y?=
 =?utf-8?B?M29rejVIOGhUUWlNYnVEQjEvUWd0cG9yNUd3QVNBQ1VIbVdkTHpUSUdFQVg3?=
 =?utf-8?Q?dzbH5uEAsmk7oQkuSpcPvxk6Q?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecf59856-ba7d-4287-d3ce-08dd05812c10
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 14:24:10.5779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iZh/227cKAEwZb07/dNyEHsjybziK3Z5DEu+U3lPObjIAvBKPaWvOUg5ZW6Q58ZjS2PCtF3KdpppUOJ08uXlKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8229

On 11/14/24 19:21, Baoquan He wrote:
> This simplifies codes a lot by removing the duplicated code handling.

You should probably squash this with the first patch.

> 
> And also remove the similar code comment above of them.
> 
> While at it, add __ref to memremap_is_setup_data() to avoid

The __ref shouldn't be needed if you remove the __init from the helper
function.

Thanks,
Tom

> the section mismatch warning:
> 
> WARNING: modpost: vmlinux: section mismatch in reference: arch_memremap_can_ram_remap.cold+0x6 (section: .text.unlikely) -> __memremap_is_setup_data (section: .init.text)
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  arch/x86/mm/ioremap.c | 119 ++----------------------------------------
>  1 file changed, 3 insertions(+), 116 deletions(-)
> 
> diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
> index 5ef6182db630..5d1b5e4a8756 100644
> --- a/arch/x86/mm/ioremap.c
> +++ b/arch/x86/mm/ioremap.c
> @@ -709,129 +709,16 @@ static bool __init __memremap_is_setup_data(resource_size_t phys_addr,
>  }
>  #undef SD_SIZE
>  
> -/*
> - * Examine the physical address to determine if it is boot data by checking
> - * it against the boot params setup_data chain.
> - */
> -static bool memremap_is_setup_data(resource_size_t phys_addr,
> +static bool __ref memremap_is_setup_data(resource_size_t phys_addr,
>  				   unsigned long size)
>  {
> -	struct setup_indirect *indirect;
> -	struct setup_data *data;
> -	u64 paddr, paddr_next;
> -
> -	paddr = boot_params.hdr.setup_data;
> -	while (paddr) {
> -		unsigned int len;
> -
> -		if (phys_addr == paddr)
> -			return true;
> -
> -		data = memremap(paddr, sizeof(*data),
> -				MEMREMAP_WB | MEMREMAP_DEC);
> -		if (!data) {
> -			pr_warn("failed to memremap setup_data entry\n");
> -			return false;
> -		}
> -
> -		paddr_next = data->next;
> -		len = data->len;
> -
> -		if ((phys_addr > paddr) &&
> -		    (phys_addr < (paddr + sizeof(struct setup_data) + len))) {
> -			memunmap(data);
> -			return true;
> -		}
> -
> -		if (data->type == SETUP_INDIRECT) {
> -			memunmap(data);
> -			data = memremap(paddr, sizeof(*data) + len,
> -					MEMREMAP_WB | MEMREMAP_DEC);
> -			if (!data) {
> -				pr_warn("failed to memremap indirect setup_data\n");
> -				return false;
> -			}
> -
> -			indirect = (struct setup_indirect *)data->data;
> -
> -			if (indirect->type != SETUP_INDIRECT) {
> -				paddr = indirect->addr;
> -				len = indirect->len;
> -			}
> -		}
> -
> -		memunmap(data);
> -
> -		if ((phys_addr > paddr) && (phys_addr < (paddr + len)))
> -			return true;
> -
> -		paddr = paddr_next;
> -	}
> -
> -	return false;
> +	return __memremap_is_setup_data(phys_addr, false);
>  }
>  
> -/*
> - * Examine the physical address to determine if it is boot data by checking
> - * it against the boot params setup_data chain (early boot version).
> - */
>  static bool __init early_memremap_is_setup_data(resource_size_t phys_addr,
>  						unsigned long size)
>  {
> -	struct setup_indirect *indirect;
> -	struct setup_data *data;
> -	u64 paddr, paddr_next;
> -
> -	paddr = boot_params.hdr.setup_data;
> -	while (paddr) {
> -		unsigned int len, size;
> -
> -		if (phys_addr == paddr)
> -			return true;
> -
> -		data = early_memremap_decrypted(paddr, sizeof(*data));
> -		if (!data) {
> -			pr_warn("failed to early memremap setup_data entry\n");
> -			return false;
> -		}
> -
> -		size = sizeof(*data);
> -
> -		paddr_next = data->next;
> -		len = data->len;
> -
> -		if ((phys_addr > paddr) &&
> -		    (phys_addr < (paddr + sizeof(struct setup_data) + len))) {
> -			early_memunmap(data, sizeof(*data));
> -			return true;
> -		}
> -
> -		if (data->type == SETUP_INDIRECT) {
> -			size += len;
> -			early_memunmap(data, sizeof(*data));
> -			data = early_memremap_decrypted(paddr, size);
> -			if (!data) {
> -				pr_warn("failed to early memremap indirect setup_data\n");
> -				return false;
> -			}
> -
> -			indirect = (struct setup_indirect *)data->data;
> -
> -			if (indirect->type != SETUP_INDIRECT) {
> -				paddr = indirect->addr;
> -				len = indirect->len;
> -			}
> -		}
> -
> -		early_memunmap(data, size);
> -
> -		if ((phys_addr > paddr) && (phys_addr < (paddr + len)))
> -			return true;
> -
> -		paddr = paddr_next;
> -	}
> -
> -	return false;
> +	return __memremap_is_setup_data(phys_addr, true);
>  }
>  
>  /*

