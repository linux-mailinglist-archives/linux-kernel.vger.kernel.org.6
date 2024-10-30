Return-Path: <linux-kernel+bounces-388703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F629B6348
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 13:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAED12822EA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 12:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061121E885B;
	Wed, 30 Oct 2024 12:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cKkIk1s/"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1531E4AE
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 12:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730292554; cv=fail; b=fRP03S3OPp1RIBd2X9SlKoWhnYVGPburg22V7/9Vga/JUCVnhbACIZg4jWpLzqHXILTOECF/c+/8B8b7r+k2snDs7Q33K2mqAXv+x1J5q4X1Q48ob2rg3Jwaf/aSLkr9j+crMYMUVY6DiZFFhccSUEEPbRi7AYFhYAt/ny8IDIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730292554; c=relaxed/simple;
	bh=3tJfrm4MtQ4nASFHrnE5WXU5cm4Bt0A7TmO4VIX9AEk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JnDg9K20RqFI9vLr+nwGUHNMlkTpLO532opf5j7bxptznS5K//GfJr0+c6cCNUjjvr8b1MsHapYVilE2eknY70G1czyJ+dRQv6Sx21GWuLRiDka9gEGYcouVR2XQvM9/954KYwpY4ey8cxHFAtanZzrDWMopkpZVodsLuG3+Mj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cKkIk1s/; arc=fail smtp.client-ip=40.107.92.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AvWSQUycjLfSAJ+i4Mj+OOp4Jaeb9Ua+Eo+oijhbbFIb1qK3C2PoexHzu7ksekXzUCyZdbB/SdCO7kUh3zUaMrU9exG3HWK7r1eXwp+asr9W40/V2cXlnZ4JYQ7pZvCyg1ULaE10zz1KBeFSa4EZIMALVsn40R4gBq5HnHnWOpS/VSBEfyfaCIrTKzV60WXRAESUCSmA5WiQTtEsnqw0i+CRwuzUcZhJ/1Jrrb8zZZRMH7XkAljikwTSmVk0tGZP+De6kAhFePg0l11iqHBys64LGvj7Vh1K668eH+h/Qm1DGgpbzDZmbgzD2adeg4hFN+hnTCDSylpmjCpqJ3gEZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2wg8YBx0ualwm/F+4rv4EmUZo2p8vPid1gRZg0UB8VQ=;
 b=vOL+BucB5oEAqbfvZ4QpIjwO7/ASAdru/VovqBExqnIprLxs/JBf6AMNka3hj3AmKdFPZZeiGCG5lEPFM4Tw2Gt9RNVxhfvmNH/eZBeAwvBPKXNX50z8uQzPN8HNB7OYFc3PcUjk+heG9e67GhmYNISac0HKfXYvMfHADvieEJAhrSsxXBObTXF7J3wTEX9aL1CFEGduDLhli6uLBp+464YkrMPgg14fOZK62P5M6MbFFTjTQU8mgCU5bHcOjsWSPcswAqO6NyJ7CvbX9Qanget0Vw6WrwpPA1RhPqGyPlVblRUh8hsByt+w9nUovC369wYTQV7BIbWUzuFOU5V/wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2wg8YBx0ualwm/F+4rv4EmUZo2p8vPid1gRZg0UB8VQ=;
 b=cKkIk1s/itQc6ydi8irtPLkatwKYnuayDD+h6BQX0cw36hMMoUfV4lEZIyCgJBeQqFOc5B0gnwcHRitSK7P44uaBaZHAs749H3iNjKzOazFORF3HVAW8/ioWBVIM1/FraX6q9N0LkthkVg/yBV4e5+5zVmGkgSxY9tIRuNTr8J4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by DS7PR12MB5768.namprd12.prod.outlook.com (2603:10b6:8:77::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Wed, 30 Oct
 2024 12:49:08 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%5]) with mapi id 15.20.8114.015; Wed, 30 Oct 2024
 12:49:08 +0000
Message-ID: <8c81835b-97fe-a0b3-a860-0bbd5c0341f6@amd.com>
Date: Wed, 30 Oct 2024 07:49:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 1/2] x86/mm: rename the confusing local variable in
 early_memremap_is_setup_data()
To: Baoquan He <bhe@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, dyoung@redhat.com, daniel.kiper@oracle.com,
 noodles@fb.com, lijiang@redhat.com, kexec@lists.infradead.org, x86@kernel.org
References: <20240911081615.262202-1-bhe@redhat.com>
 <20240911081615.262202-2-bhe@redhat.com>
 <20241029181101.GXZyElNXVuF6596TKG@fat_crate.local>
 <ZyGDlYsg6YWNXSVo@MiWiFi-R3L-srv>
Content-Language: en-US
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <ZyGDlYsg6YWNXSVo@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0038.namprd13.prod.outlook.com
 (2603:10b6:806:22::13) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|DS7PR12MB5768:EE_
X-MS-Office365-Filtering-Correlation-Id: 80d26399-2ddb-43c9-571c-08dcf8e13e9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q0ZkeHVtY2grSFVvSXBkN0JoR0gxOURsUDU1ZktQdTdRczMyM3BUcmN1b2Y3?=
 =?utf-8?B?TWluem9SVXlSNk84VEoyRFhJUnNzMTlXOGREamp3eW5WMEdINndTRURKN1V1?=
 =?utf-8?B?V1ZoV1ZkcXU3WDVLSzV4aEVGS01zUHEwWE85SlVaL0hwdmdJMDY4ZEFkN1VO?=
 =?utf-8?B?d3UwbDZ1dU82dWRjL0ROMUZQK2ttMVk5aWtjMGlrRlZGZE9zRFUxb1o5UHRJ?=
 =?utf-8?B?bFlydUwwTkhDVkdzbUREZjVTZTUyYmU3UU1VTkFTMlE1K0NmWWlvTDdRTHdB?=
 =?utf-8?B?eTlQM2R0bFRsMzVkdFRDdEtrTG9RMTd3ZkFHZDhGN3hMYWUrbFprMGdHbDZw?=
 =?utf-8?B?aG5XWlBPS00wYWN2eE5kUzcvUEszSzA5cnNoN1E1ck5lMWJMS1pGUHNoNDhS?=
 =?utf-8?B?NHI2UXpCdWxkN0ZLZlVlMXpMcjFJb0RLUmpLQjR0NlNSdndGTUswTkZCVUwz?=
 =?utf-8?B?SmFZWmo2M1RmRmhROXNBWk94T1BIc3hhZHBCd0ZVdmdjUUJhaEVwYlBQQ0hO?=
 =?utf-8?B?S3pZMERJS1dEa3RBREZFaDBtNXN3UElqQ3ovejNpTjlTU09XU1BzWCt1Qjdo?=
 =?utf-8?B?Uy82TkVMdGgrUHUzcXlFZXAwalhRTEwxUUZhS0huME82SDROQnNOR3ZUVEg2?=
 =?utf-8?B?UlBkR3Y1VmloTXp3eENuWkUwczRRWGhaYWlBdUtCdUhuMzZiZzdPQzB2VFhH?=
 =?utf-8?B?Y2R5Umo0Unl6WjFhSHk1UkY1VlBncXhqNGhkSWZXNXhtaWppSFk0WWxsY2t0?=
 =?utf-8?B?VTdGcEowSVdMNzVuZ1p5QlNDSXZtSldwMXdKeWV1UHcyaDJvUTFuREplOWRG?=
 =?utf-8?B?MVpVajN5SjN2Y3piUm1DYXAydlVHa1lzeW9STmp1cjd0SWVWT3RlOEZVNkg3?=
 =?utf-8?B?b045VU52Q0NXbzJGQWJ1UUIvVklHR0c5RmpPMnk0ODdvVFlZUzlrVHpndEJr?=
 =?utf-8?B?S0ZwV0V1b2RiZFhrR1ExekFHSzBrVElQejcvYitWalV4V3ZlQkhMVHZ5S0Jp?=
 =?utf-8?B?cEVra08rOFlxamE5UDVBbXB2QUJVZk53Tk03Ry9Wa1k0bEJkdENxOXlFZFZF?=
 =?utf-8?B?SXE3M2NDNXkwSjVXN3RMajBxQm1McklmMlZuWjdITlJNMnBRYkl4UnJ6amlJ?=
 =?utf-8?B?ZTA4U2prWXRNZjMxNzVNdXpFc01NK0llU0w4WFNQSDQrS01qbi9JaUx6RzRR?=
 =?utf-8?B?eDZRM1FJYmZ6U2g2NDZ6N1l0Vld0bnkvNVplR2FmK2VNck5iV2s2bkxiTEha?=
 =?utf-8?B?L3EyM0hBTUwzWDlaTzREaTEwVU9GaXk2bTFJOXE3bnprNjVpRmRkR0d4U2tB?=
 =?utf-8?B?eGtackZ3R0NBdE4ya1ZIZWxWUFF2VGtGOGVlSks0eGFSR3poT0Q2NEpDREdH?=
 =?utf-8?B?bDBWTjBiam1uZzIrSTlRYmhJQlJVUm1naElJWElFOUlxRWliYWs4NTdKL3B2?=
 =?utf-8?B?QTBTSjNkODhQU2ZaU0pXZEs3MjB1RzNWTDlXTFVobTd6OHZ1b0lTM0diUFdu?=
 =?utf-8?B?WlVJNHN6WXpka0pLUTNQMlkxVS9YTU8wbWVlMnprdTI0RHFYZXlkVlc1SlBj?=
 =?utf-8?B?cWpXMjQwTkJVN1Z5UmRNdGtsVDIySjlIZDY2enYxNlRlcjArMzFaSEtObHRS?=
 =?utf-8?B?WEZFb0lvOExIbzMwMWo2OVRHRmNMby8yQXREbGV3cDQzRnZsd1g0MHo3U24r?=
 =?utf-8?B?SXp4MG5HbXBiTjBldjRVbmVSdmZTYmVKM0E1Qkp4ZkNiSVhlR244aS9LSnp6?=
 =?utf-8?Q?oq64jtnYVZhHc8C49P5CHg4FNR52mYpy4AgAtSR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eWRPaTJqUy9FOHIvQTZUTUgzZmxjeTQyY3dNclUvQk9wTzAyb3NPYk9Bd0NR?=
 =?utf-8?B?NncxRzM5MDZueUNRL1BMaDNyZzdTTjg0ZEg3aXYrUkpTdXFLYmt4c1BPSXJa?=
 =?utf-8?B?ejdYR243RXJFMiticzhPV0N5SjkxWm9hV1Fjd0lVdDY0Y1l2L0pKL3NFRVFE?=
 =?utf-8?B?UHZyelpiRUpCeW5wSFBLUHUvdFpoTm40dU5HRXZzMUpaYlRqVFJVS25XZGZL?=
 =?utf-8?B?bS9Gc2tYN1J0ZnY2UjJvWG5NOE5neE5hNmFRelVXL214WWtsdzZ4aXBBclBG?=
 =?utf-8?B?VXA3V2c4ekFxeWYrR1BSenFUdWo1OE16ZG5heGVrTWhYZFJIcldpelBpVFRR?=
 =?utf-8?B?Q21tUWtQbzExQ0t1Y250Qmp0Z29xcW5TTmlLNzZyWXZVUHZQZ0lxWFNSRWxR?=
 =?utf-8?B?eTY4UTllWnNNKzU0VUlVZFZHR1RHQmIzYTJlMyszekFRVytFL2pPeGhZOFJJ?=
 =?utf-8?B?NGFPbk5zRWszZVdEU1hUMmc3YXFFNE1YTHlMNTlLdnUwUm1KTFhKeWhZWmF2?=
 =?utf-8?B?OXFLKzBQTXQrN0E4RzVQNXlseGZXUmUvbVhDanoxTm5hUG9KZWhyZWdtdkN3?=
 =?utf-8?B?djh0RnhnQmdCQVJKNEwrU1NTemE1dEFOb2E2dDFXdEU3c1hmK3UvVmRmcEFE?=
 =?utf-8?B?MUZqdHN1RmpSendqK3MvY01sRmtxbDdTVFF4TmRsNUFtRmFFNG8vdWZqWGxE?=
 =?utf-8?B?ZGZWZmVZdWI0VStDUlE1ZkUwcU1WaW5LRjRwSWhBNkJjcTZWWWdVOSszNWJ5?=
 =?utf-8?B?TUNpZGFsckJNOEJrOHpTQXFRMDBBVi9wT3BMbzdBNHhkY29lZUQxclBLNnFi?=
 =?utf-8?B?NlZsOXo5UDVoT3haRWVzT2RxdHBwTmtKWE5hSHJwQWxUdUM4VU5oalp1SEo4?=
 =?utf-8?B?R09EVGtUb1RNdWxJRXRpRHhRNGNIMmJqZTJHNXpMLzFqUlhkbFJJaWd1WjZI?=
 =?utf-8?B?K1E0Tk1EQzV5MXU4cWdsMTJFRWo3RFAzdVhxT3Q1QVlwL1VUQ1RSbGRPWG50?=
 =?utf-8?B?WWZtZHNZVk8wbnl2cWdWZk1iS1VsaFF4d0w1dmI3NkpiRzlaZkF0bEdKU2Ez?=
 =?utf-8?B?TC9LemJ5eVFVaHNqTmNmZXVqRW0xZFNja3Z3RHY3QVNpVnFsQ05JaXpRRVFM?=
 =?utf-8?B?dkRKakpaL0ZIU0FDSzRld1REQk0vYVUvaHFzdFZlR3NsbzFmdjV6YzJsUklz?=
 =?utf-8?B?SjJOY1NPbFljZG1JWnFsZHczRFhpSG5nTUNkZmV0Q1ZtM2Z3eGtkcHVBOXNP?=
 =?utf-8?B?M01SN1JUYVRJYi8wbjZzeU1HSG9qbnFIMGdPcnBlRGRjbGo4Tk5HL1Bwb2k4?=
 =?utf-8?B?eU1NQ0ptY0wySWpmL003S1cxMGRMa2s1VG4wcGhXdU1SVWliNTVDdS9PN2JN?=
 =?utf-8?B?L29hMG0vbzczRGpyczVIRkR1Mk1idmFTdkw3dnd4M01aQS9qakN6aEtXbHBT?=
 =?utf-8?B?cmpJL29zd0dvYkRwSUhqRUpMUWkwSWxrK21US3FKTmNEUmNGZGx3ZFVBY0pv?=
 =?utf-8?B?aU1GMGpGa2ZHdjJXMEFpTTUyWEdSWVcxZDhtQXducHhldWljRnhHM0VFc3lV?=
 =?utf-8?B?RFk2a21yU1RzR0NaR3FheWU4R05ENlBic1piNUNnYlRaaUE0MG83NWcwOU8v?=
 =?utf-8?B?djZpLzJWZlRrczR6Q1dZOGZ4dnBCSHVqTHl4S3A1U1NxeUFEQ1RoQ281VnBZ?=
 =?utf-8?B?ZU1vOUhoZVhQWG1obWdhUjdCdXRmVVp3Tm5Kd2hmNlRnMUd5UTROYlR5QzNC?=
 =?utf-8?B?YnN2Sjl5RjlwSVppbVlpU1hzdFR3QU1kb001ek1ZSkdpdjNVR1V4cnl3Qndm?=
 =?utf-8?B?OVBWYUs1TmY1MFMweDJ6ZC9ac1RTaEY3K0ozNkNYTDNsVUJnUXNhUkRUYThR?=
 =?utf-8?B?WjR3TEVIQlltNk1ZQlRkMmVLZTJhZURlQ0c3K0ZLOVBybUt5WDNTM2d0MzZH?=
 =?utf-8?B?R2l4UXZrKzdNQmNrSEN0YVY3SGQyQTdoUXhycldpZFhRYVF6dHkvWXRtdFJm?=
 =?utf-8?B?SlVKREFBbUkzb2d5VDZwRVUrOXVVWFhRRHdNUzFnV0JKMTc4aWs4TUJ4MFZv?=
 =?utf-8?B?aHRvWVlVUVNIOWtJU1VHVkNXcEJOVTRlNDV2bzRRdjR4a3NCdUFPRWRveklJ?=
 =?utf-8?Q?nFWcVT2rVJLDGVyao1/liQy5S?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80d26399-2ddb-43c9-571c-08dcf8e13e9b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 12:49:08.3164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9kBSRWocN34EgYHZIXicNH9pL4p3QzKTHDduDoaq8TeruHNfnUMGzWe1gGGEQXbq0Jb5EMuQU/I719c7qKr6xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5768

On 10/29/24 19:53, Baoquan He wrote:
> On 10/29/24 at 07:11pm, Borislav Petkov wrote:
>> On Wed, Sep 11, 2024 at 04:16:14PM +0800, Baoquan He wrote:
>>> In function early_memremap_is_setup_data(), parameter 'size' passed has
>>> the same name as the local variable inside the while loop. That
>>> confuses people who sometime mix up them when reading code.
>>>
>>> Here rename the local variable 'size' inside while loop to 'sd_size'.
>>>
>>> And also add one local variable 'sd_size' likewise in function
>>> memremap_is_setup_data() to simplify code. In later patch, this can also
>>> be used.
>>>
>>> Signed-off-by: Baoquan He <bhe@redhat.com>
>>> Acked-by: Tom Lendacky <thomas.lendacky@amd.com>
>>> ---
>>>  arch/x86/mm/ioremap.c | 18 +++++++++++-------
>>>  1 file changed, 11 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
>>> index aa7d279321ea..f1ee8822ddf1 100644
>>> --- a/arch/x86/mm/ioremap.c
>>> +++ b/arch/x86/mm/ioremap.c
>>> @@ -640,7 +640,7 @@ static bool memremap_is_setup_data(resource_size_t phys_addr,
>>
>> Huh?
> 
> Thanks for looking into this.
> 
> I ever doubted this, guess it could use the unused 'size' to avoid
> warning? Noticed Tom introduced it at the beginning. It's better idea to
> remove it if it's useless.
> 
> commit 8f716c9b5febf6ed0f5fedb7c9407cd0c25b2796
> Author: Tom Lendacky <thomas.lendacky@amd.com>
> Date:   Mon Jul 17 16:10:16 2017 -0500
> 
>     x86/mm: Add support to access boot related data in the clear
> 
> Hi Tom,
> 
> Can you help check and tell your intention why the argument 'size' is
> added into early_memremap_is_setup_data() and memremap_is_setup_data().

That was a long time ago... I probably used it while I was developing the
support and then never removed it in the final version where it wasn't used.

Thanks,
Tom

> 
> Thanks
> Baoquan
> 
>>
>> ---
>> diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
>> index 70b02fc61d93..e461d8e26871 100644
>> --- a/arch/x86/mm/ioremap.c
>> +++ b/arch/x86/mm/ioremap.c
>> @@ -632,8 +632,7 @@ static bool memremap_is_efi_data(resource_size_t phys_addr,
>>   * Examine the physical address to determine if it is boot data by checking
>>   * it against the boot params setup_data chain.
>>   */
>> -static bool memremap_is_setup_data(resource_size_t phys_addr,
>> -				   unsigned long size)
>> +static bool memremap_is_setup_data(resource_size_t phys_addr)
>>  {
>>  	struct setup_indirect *indirect;
>>  	struct setup_data *data;
>> @@ -769,7 +768,7 @@ bool arch_memremap_can_ram_remap(resource_size_t phys_addr, unsigned long size,
>>  		return false;
>>  
>>  	if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT)) {
>> -		if (memremap_is_setup_data(phys_addr, size) ||
>> +		if (memremap_is_setup_data(phys_addr) ||
>>  		    memremap_is_efi_data(phys_addr, size))
>>  			return false;
>>  	}
>>
>> -- 
>> Regards/Gruss,
>>     Boris.
>>
>> https://people.kernel.org/tglx/notes-about-netiquette
>>
> 
> 

