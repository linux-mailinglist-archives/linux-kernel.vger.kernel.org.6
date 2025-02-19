Return-Path: <linux-kernel+bounces-521859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E78CA3C345
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 16:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D60433A868B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 15:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C6F1F3D5D;
	Wed, 19 Feb 2025 15:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="McfO2n+c"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA6E1F4628
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 15:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739977980; cv=fail; b=MPkVeu1tEJF4wS17DrVGQNu9OTDi2W2BHOh4SCdc3U/o/gasy54EZWxfbwwvonrYNV6rqxiNfdvoLsEja2U04OUfwrV99eqW8/zU8Giwklp7fHn2R+XLXswTfN5VWDs8r6yKdYe2Gnu3YFLYitXWSQxTB0L5g0vM6/UH9LmegOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739977980; c=relaxed/simple;
	bh=Itqy/V/9EROQ7Rzl8kwV53jdd2x+FA4+Km6Cmpo4UfI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=D7fxlUca15mYeNVwNSZWlk6iRzvjJznJAaUN+bQJujd+UbZBM0TA6SIv5slAdEFtsobIDCurjQBcah3r0AgqPtbXjMYb7Okz9PSLYIkExG6FcOLwq9UzM7xxf9MU93T0yzRPMNRjRx75rpbyTpFkLPDY0S/7QXxVENnmWjzQPcE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=McfO2n+c; arc=fail smtp.client-ip=40.107.220.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BfgHtvKZYFTiO0ntvOASHrjCyvrxdUc9Uv7/Hb6yRC0ApMle7TppwbG+45uE0hr+InulP8iFx9XitbdyDUy66Idgb4OZLlfUzfJ6J2UMp8yJHObW0/CS+EnzTKzb379AoO0KS4C4wcHzfSDvc0p6x0GE4uLDsH9HWCzFjaZPi5BGBEfJ3udD+tTHRt6hf9+yH99HYueh67fLARFQGD87G0q9o7AO3mlY38EEYbQeUUi2CyrRCiv401w2obwSP8AXtuIQWrKe+5SxQKgNoQXUxKS5FRpm/1fs3ByUHaDgro6DDhsc9ViZsfPDHbpvVeFk/oeW597HFXzcgKZjmeMeWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BujtahoDzt2lof047Nbxj9bF7FMYmPgI/b+vaGhbLUs=;
 b=rjzJdmfrJDV6Z42KNav6261q0GxFzn5RULN5/lTL1wRZ9pXefXOMfu4URMa6qtfs/OMTfIqqLJRyeStufz46N+ajZSE++qrUd46aPIVdrJLTrbK8Q82TnFbucB+H+7L4oY87ewa0vD/HpflJwr+uopKf8/lgNfeYpLGOfWa5VFOIEzL8w6dyufARnxomMLhQuzkpQ38fmnHQBik3Oeo+VpWyTEk+lgNSu9AU9d3mrCXDk12TvIhCTAY9ZN6kSPNWNfYwmYtzU5SdHv7h0L8eejlZxOww2ldnrYEuzQraybZCmWAwvBB+B90C0R4u50Z4NeEIeNZgfNFOBhg/vwS9Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BujtahoDzt2lof047Nbxj9bF7FMYmPgI/b+vaGhbLUs=;
 b=McfO2n+cZbyTf/EKT8+UUzLQ1zYw9oYZQHPBVXhtyj/ziaHyGwgVP5ccDT74X8QJocVcAOh7De3uml+eMcF6hf4KT465NByKo0gPLK4Qp8H54Fhhi5SFftoR+oY5I0MYYIChMPlhzPYvZcYSqPPne45J03iNSXqTDhf5YOCkERI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by PH7PR12MB5688.namprd12.prod.outlook.com (2603:10b6:510:130::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Wed, 19 Feb
 2025 15:12:56 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%7]) with mapi id 15.20.8466.015; Wed, 19 Feb 2025
 15:12:56 +0000
Message-ID: <12d1df13-0386-14d8-f07e-32e6363ca17d@amd.com>
Date: Wed, 19 Feb 2025 09:12:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/1] arm64: realm: Use aliased addresses for device DMA to
 shared buffers
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, will@kernel.org,
 maz@kernel.org, catalin.marinas@arm.com
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 gregkh@linuxfoundation.org, steven.price@arm.com,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
References: <20250212171411.951874-1-suzuki.poulose@arm.com>
 <20250212171411.951874-2-suzuki.poulose@arm.com>
 <yq5apljj9tkc.fsf@kernel.org> <yq5amsen9stc.fsf@kernel.org>
 <3ac6b21a-9c78-4801-ad33-d1d0028ca6b3@arm.com>
Content-Language: en-US
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <3ac6b21a-9c78-4801-ad33-d1d0028ca6b3@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0057.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2c1::6) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|PH7PR12MB5688:EE_
X-MS-Office365-Filtering-Correlation-Id: e0b0ace2-966d-4b22-da51-08dd50f7e390
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Uklwamx4SjhmSXMzMitDVjNzZmxWempYY0VFUmZYUUs0b1ZwV2xJdGJobGNM?=
 =?utf-8?B?M0tYTTA4Vks0cC83U0ZzNk03N0FRM0JHbUlDbkRHcGVpT0V5b0VIRlZLYno2?=
 =?utf-8?B?aXkxV0FPcnBPdFozMnlvZHBVWWNiQXpzOTk2dUc3Wms0RXZKMndvV0I1OFlm?=
 =?utf-8?B?VjZXRWdFMXBXcXRKVnd4U2NyYTRFQ09lbjFNN3V2NnRHdjNPMlI5UXE5SDJJ?=
 =?utf-8?B?V3dXNExNbklYZWQ4ODZzb0VibEtyQ0hOY3g5NEpYQXM3UkdScVBTMTJTMGlG?=
 =?utf-8?B?K3I3dXpMc0w0b0tWL3JRbmZXdVQ1TWZ6Uy9vZW85NksyQVpPcWRhYVE1anY0?=
 =?utf-8?B?aTgzbmo4SUtuVnBKY1p1TmpMelZpMG1lQU9LVHR6Nzh1YVhndFp3dDFDTnNZ?=
 =?utf-8?B?VXNUWFExb2NFUVdwWHRPNWlQc3VXbnNpNUFqc0tHQ0MzdVB3WlJQL2sxQnBE?=
 =?utf-8?B?cytyTlFoNjA5aGxXYkFTUmhESnNPM2R1emFiUHFnb0dXTWhtR1JDeFFUenFP?=
 =?utf-8?B?ejdjejNwb2dYelEvcHJ1TXJET0dLNXJrYmdhdkJhLzhJSTMwWThvTTR3bVE1?=
 =?utf-8?B?VWhxM0tBZ0U0VE1VdU1WRk9KcDRwQ21hN25HeTZpZUNaOEtzYlh6SkZtNVdH?=
 =?utf-8?B?QVNRYkdDUHJzWXRYYjF4djhXcUpVQ2xyTDJzSnVHOVlWanVaWlNpZDY1ODdM?=
 =?utf-8?B?SmRaNXFyMk9XZTlRdTBZeWtiVEJEYTl5bExjdG9hRFN4dDZkd3FQMVQ1WHFz?=
 =?utf-8?B?blBFaGdWNXNRditNSldESVBOU1U3YWl4OWZCL0JvSXRxeVNoNGxIK3FZRFdL?=
 =?utf-8?B?VTFBWk84V2VZb3dTSHk0eFRHN0FWT2lIWVNPSUJnbm01YkFucVk4ai9iUnNC?=
 =?utf-8?B?UXFaWFFvRmlNemxRaVRSN2NqMU9OcXRRd3d3dTBoc1dBdzdYdHY4dEdTcGhT?=
 =?utf-8?B?b2RIQVhOSGNvK3BkVk9ya0Jib0dqMkJDbitDMzYxRXhIbWN1c2Q0L1JuakJq?=
 =?utf-8?B?VlVNRDJBVi9rcUlpc25YWkdWMG5IeUVCcjNESVVzd25GNlVIOW5wVWIvRDRn?=
 =?utf-8?B?Q0xNaW9CNmdwbEkveXdyUzB2QmFsTkRrQ3BvcC9IdUg0UU9tblhTWWNKM21M?=
 =?utf-8?B?U1lpTi95aEROQkVZV0hPZlNoWko4OEpPeXhZbGZaSWxBRHZiWDBCRjVCSnls?=
 =?utf-8?B?eU5JdkY0Z2lzYVFRamROMGp4YllpNTJZcTMzMmJ6NzR4MFdJYUJxTHBHTkRY?=
 =?utf-8?B?djYwRmF0c1Z5UXBSODZZcmRNTjY5VnRzUDNGSGo1TXJZUXpDRG5vbzZ6SW5I?=
 =?utf-8?B?eVFlY2VpVTdxRU04T1d1alk1T0g0d3d0MmtJRjBaaE5STStVa1IvTTZKZGU1?=
 =?utf-8?B?RW1PNWlBNVlvMGVFaDA4S0JUa20vWVQxZGgrS3BoZ3lwOFFtRHZSSGxnM3hI?=
 =?utf-8?B?UWdzeWIvc2RCU3F4alVSYlozTC8relhNa1lDWTVPQ0lSaXVKT1BBZ2Q1bWZ0?=
 =?utf-8?B?bkdiS1EzNmNHTWtaQ1VPQzFZTWk5dlBoMUFsYXc1dU14a09xZnc5S3QrVjVj?=
 =?utf-8?B?WFIzYkM5SlBEUXoveUdPYWwreEJnL2o2eXZCME83N0pPSTgwTC95RTF6cVFM?=
 =?utf-8?B?U0doS05xUWg5UFJJbFhOQW1uOHVHQjlIS0lycjVBSnZibjZsUW5reDlmWWFJ?=
 =?utf-8?B?KysweVU0c0VlS0d1MjRsNGRFeDV4TzNySy9LdzdBRnNYUC96WWhFYXRqUzdo?=
 =?utf-8?B?RVk0TkVhdXpUcGFTdDBzQjJycnM5VEoxRE5SSkpJVzlTbk9nbURjMXZQSzUx?=
 =?utf-8?B?MFJQVE5aWmFHZXVUNjZrSUNlWjk5aThUcUNTQmFsOGpSbVlmWm5jaFUzVTVP?=
 =?utf-8?Q?l6l50gkLhRKIg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SE0zbnlNem1JWDJ0NnlrYlo5dlB4Z1dDYmlhQ3RTN2tzWnZkTURveXBTYUVj?=
 =?utf-8?B?OGxRUnRzQjZFSlg0eEUzWnpHMkZiRjlmU1dtSnJjWXNHemNLWHBTdEZib2Vn?=
 =?utf-8?B?Y3JybXRxYkRrQ0ljU3BmZnlRZ0dEZjRWeVZ5MUNrSFIrWGJCWXVPZHphSWJE?=
 =?utf-8?B?c3IxUVdZVEdwSkF1bWZ0dmg5OURDMkhDYUtjaDhiZ3ZOd0RocDlBNDZ1UndN?=
 =?utf-8?B?dWFUYThlSUFpZjB6MERMc0J5ZW1xYjRyWkF3bzlPM1gwc09uYWcyMmY0YTRq?=
 =?utf-8?B?dnEvY0lDM0FVZTlhREgwZ2U1NGh6SnBLVFM2L3dtM1ljUzB4eDBTY1NncUtu?=
 =?utf-8?B?eUx4TTJzVXBZeGd1bzk4Y3JTQ1oxWTMvQTh3azNYeTRWMUpRWnhrYmhLellR?=
 =?utf-8?B?QmN4VEVHbnA2bjlpd3pjdExNSFRySU50d3JXWVlYQ3QyRjdsWkRDQWdlZTdM?=
 =?utf-8?B?TUJ4eGxGWUtiWmxuOFo5QndUZ1hvd0wvT0puSFpqcUFZR3ZDMW5iUklaNWVS?=
 =?utf-8?B?dDJmK0FmTUZUV2ZEYVk3SFh2b3JWTllFaStBZkQxYVRvZml4cUMwT0tMc2dO?=
 =?utf-8?B?RHpxcjR0L3hLYWhNTCsyNmZwU1Jmci9ldGJMR2V0ZUtqaitoY2FxNSsyOCtz?=
 =?utf-8?B?c0NWdWs5QW9zenpoQklPWEN5c2prS0VrODJjVDVRZUtCeEo5ZWs3bEpFN25y?=
 =?utf-8?B?RlN2ZlFFMU9UcU1GV1VDcnM3Z3p2aDY0K0dGVTg3MTB1VjM5OTdQSE1taU5q?=
 =?utf-8?B?eEhJdFVwbUJvbTBXeUVtLytUd1ZZakE3dUNYTE0vKzV5b05pN1Q2QWNiMElo?=
 =?utf-8?B?VmhyTWRpZlQrNE53UERjRWJqUTVsV0ZLRXBEVWd4bm14YkVLZE5BZUlTSS9K?=
 =?utf-8?B?WkhLWW1DQmw2RzJ1ZXFjdU52Y1Zva0N4SzlhUXJaOTVicEg5Z1k0R0Zsbldt?=
 =?utf-8?B?VkxiM0JudStSa2xlK3R3RlJ2YVNMQ1l4aHJMMkJZdXlUUTFRV3o5cHdNVXdw?=
 =?utf-8?B?UjVtZXFhL3g0UzN6Mmx2c1I0eFBMVWRCekxCUzFlS21iUHovVDJmTGovcTZU?=
 =?utf-8?B?czlidG50ZTBSL09pQk5Sd0pKNmpiMlBoU3lxalVMRXNxaHI0VmpSTEFkUTJj?=
 =?utf-8?B?a0VSUGpneC9qMEFWWlNZbVZiNzdlUTJoL1hTalljRGZCRmcrWDcwd1ZuLzEy?=
 =?utf-8?B?NnJLS2U5Z1ZUL1RLY3BpeTJVcXJ6MXJvWW0rdkVrRWRPRWF5dmlIYkhWOUdq?=
 =?utf-8?B?S3FOTzhIR2VGR1BwSm04MDFBTVVGSlkyZm4vY3hMeTlOVHBURmNUalRXeHM4?=
 =?utf-8?B?UllHZzFGajVueFQ4TktZNEluODdHWWsrNlo5YXVuSkVQb3Y5R3IxZ0xXakU5?=
 =?utf-8?B?d3ZWTnJ6RExkUmpRcUsyUlJVYjJWZFFrbVJiRkhsTXBjdVBiRHh2Ui96NVl0?=
 =?utf-8?B?VXdaSjNTN3hyTVFQTzFnQllOaHpIQTFYYzlIOGJZUlVSa3h6UzBEZDUvRFRx?=
 =?utf-8?B?NFlNMzh4cjBndVRQUVVNNzJJbjZnU2MwR2o4ejNIYXVMd0lyRnlUZ0VqN2Fp?=
 =?utf-8?B?NXJiQlF5WFQ2ay9DcnN1V05qU2hkMUFqeHV0aVc3TlYxdE52b2R6UHNRYVYz?=
 =?utf-8?B?V1ZaRFdES3pHekIwYUQyaHdtSUpXcU9QbnBJOEZ1dzJTdXJTOWpWYWFDQzFu?=
 =?utf-8?B?MEZhd1dKUmRkS1JqOVI4ektkRG5CMk1TR1VYL2laWDM5dnJabDBrQWQ0ZDRk?=
 =?utf-8?B?K0VJdG5IaG9KOFJ3RHJ3SDE1NUxEQ2dGVXlzbmZ1Vkt4d1ArSnpLRXZ3NmN5?=
 =?utf-8?B?S1pwS3kvNkZlUG92RnFoR002YUc5YnZsdDBHZzZ3YXlNVng2VUNSZGdITDMx?=
 =?utf-8?B?RXlxUDVQWnRoektYb2RjMlR5K1llcTlwUGZud3hvaVY5WDNOMVNsK29uRDNr?=
 =?utf-8?B?Z2RNWEdUaFVxeFU1VHNSK0lIWXZaL3hXblpvYVN4QlVJWUduNTJsR3lXOVFm?=
 =?utf-8?B?MWl3SzhWcm5OTkJlZVZ4WW1hdW5JTU5SV1RKVEM1RFVtdytnREZvOTRGYWVP?=
 =?utf-8?B?SUNEMWVoN3NFYlZaMCtBQ1pmVEwzcVRTd212SldxVnpjd2JHQkkxZnh6clhj?=
 =?utf-8?Q?F+ltBNT7nC+eOmx25gjq6TTUP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0b0ace2-966d-4b22-da51-08dd50f7e390
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 15:12:56.3340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F1zP0nyuJubQZufQKIY2RLwzqf14401+TucM7sG0nJfBvcCiVLFE4CD3p9IA72GdRHgG1Ky8ZIX0Z/SqZP/tfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5688

On 2/19/25 08:51, Suzuki K Poulose wrote:
> On 15/02/2025 14:38, Aneesh Kumar K.V wrote:
>> Aneesh Kumar K.V <aneesh.kumar@kernel.org> writes:
>>
>>> Suzuki K Poulose <suzuki.poulose@arm.com> writes:
>>>
>>>> When a device performs DMA to a shared buffer using physical addresses,
>>>> (without Stage1 translation), the device must use the "{I}PA address"
>>>> with the
>>>> top bit set in Realm. This is to make sure that a trusted device will
>>>> be able
>>>> to write to shared buffers as well as the protected buffers. Thus, a
>>>> Realm must
>>>> always program the full address including the "protection" bit, like
>>>> AMD SME
>>>> encryption bits.
>>>>
>>>> Add the support for this by providing arm64 version of the
>>>> phys_to_dma(). We
>>>> cannot use the __sme_mask as it assumes the "encryption" always "sets
>>>> a bit",
>>>> which is the opposite for CCA. i.e., "set a bit" for "decrypted"
>>>> address. So,
>>>> move the common code that can be reused by all - i.e., add
>>>> __phys_to_dma() and
>>>> __dma_to_phys() - and do the arch specific processing.
>>>>
>>>> Please note that the VMM needs to similarly make sure that the SMMU
>>>> Stage2 in
>>>> the Non-secure world is setup accordingly to map IPA at the
>>>> unprotected alias.
>>>>
>>>> Cc: Will Deacon <will@kernel.org>
>>>> Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
>>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>>> Cc: Robin Murphy <robin.murphy@arm.com>
>>>> Cc: Steven Price <steven.price@arm.com>
>>>> Cc: Christoph Hellwig <hch@lst.de>
>>>> Cc: Tom Lendacky <thomas.lendacky@amd.com>
>>>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>>>> ---
>>>>   arch/arm64/Kconfig                  |  1 +
>>>>   arch/arm64/include/asm/dma-direct.h | 38 +++++++++++++++++++++++++++++
>>>>   include/linux/dma-direct.h          | 35 +++++++++++++++++---------
>>>>   3 files changed, 62 insertions(+), 12 deletions(-)
>>>>   create mode 100644 arch/arm64/include/asm/dma-direct.h
>>>>
>>>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>>>> index fcdd0ed3eca8..7befe04106de 100644
>>>> --- a/arch/arm64/Kconfig
>>>> +++ b/arch/arm64/Kconfig
>>>> @@ -41,6 +41,7 @@ config ARM64
>>>>       select ARCH_HAS_NMI_SAFE_THIS_CPU_OPS
>>>>       select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
>>>>       select ARCH_HAS_NONLEAF_PMD_YOUNG if ARM64_HAFT
>>>> +    select ARCH_HAS_PHYS_TO_DMA
>>>>       select ARCH_HAS_PTE_DEVMAP
>>>>       select ARCH_HAS_PTE_SPECIAL
>>>>       select ARCH_HAS_HW_PTE_YOUNG
>>>> diff --git a/arch/arm64/include/asm/dma-direct.h
>>>> b/arch/arm64/include/asm/dma-direct.h
>>>> new file mode 100644
>>>> index 000000000000..37c3270542b8
>>>> --- /dev/null
>>>> +++ b/arch/arm64/include/asm/dma-direct.h
>>>> @@ -0,0 +1,38 @@
>>>> +/* SPDX-License-Identifier: GPL-2.0-only */
>>>> +#ifndef __ASM_DMA_DIRECT_H
>>>> +#define __ASM_DMA_DIRECT_H
>>>> +
>>>> +#include <asm/pgtable-prot.h>
>>>> +
>>>> +static inline unsigned long addr_to_shared(unsigned long addr)
>>>> +{
>>>> +    if (is_realm_world())
>>>> +        addr |= prot_ns_shared;
>>>> +    return addr;
>>>> +}
>>>> +
>>>> +static inline unsigned long addr_to_private(unsigned long addr)
>>>> +{
>>>> +    if (is_realm_world())
>>>> +        addr &= prot_ns_shared - 1;
>>>> +    return addr;
>>>> +}
>>>> +
>>>> +static inline dma_addr_t phys_to_dma(struct device *dev, phys_addr_t
>>>> paddr)
>>>> +{
>>>> +    return __phys_to_dma(dev, paddr);
>>>> +}
>>>> +
>>>> +static inline dma_addr_t phys_to_dma_unencrypted(struct device *dev,
>>>> +                         phys_addr_t paddr)
>>>> +{
>>>> +    return addr_to_shared(__phys_to_dma(dev, paddr));
>>>> +}
>>>> +#define phys_to_dma_unencrypted phys_to_dma_unencrypted
>>>> +
>>>> +static inline phys_addr_t dma_to_phys(struct device *dev, dma_addr_t
>>>> dma_addr)
>>>> +{
>>>> +    return addr_to_private(__dma_to_phys(dev, dma_addr));
>>>> +}
>>>> +
>>>> +#endif    /* __ASM_DMA_DIRECT_H */
>>>> diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
>>>> index d7e30d4f7503..3e9bf6ca640e 100644
>>>> --- a/include/linux/dma-direct.h
>>>> +++ b/include/linux/dma-direct.h
>>>> @@ -72,18 +72,36 @@ static inline dma_addr_t dma_range_map_max(const
>>>> struct bus_dma_region *map)
>>>>       return ret;
>>>>   }
>>>>   +static inline dma_addr_t __phys_to_dma(struct device *dev,
>>>> phys_addr_t paddr)
>>>> +{
>>>> +    if (dev->dma_range_map)
>>>> +        return translate_phys_to_dma(dev, paddr);
>>>> +    return paddr;
>>>> +}
>>>> +
>>>> +static inline phys_addr_t __dma_to_phys(struct device *dev,
>>>> dma_addr_t dma_addr)
>>>> +{
>>>> +    phys_addr_t paddr;
>>>> +
>>>> +    if (dev->dma_range_map)
>>>> +        paddr = translate_dma_to_phys(dev, dma_addr);
>>>> +    else
>>>> +        paddr = dma_addr;
>>>> +
>>>> +    return paddr;
>>>> +}
>>>> +
>>>>   #ifdef CONFIG_ARCH_HAS_PHYS_TO_DMA
>>>>   #include <asm/dma-direct.h>
>>>>   #ifndef phys_to_dma_unencrypted
>>>>   #define phys_to_dma_unencrypted        phys_to_dma
>>>>   #endif
>>>>   #else
>>>> +
>>>>   static inline dma_addr_t phys_to_dma_unencrypted(struct device *dev,
>>>>           phys_addr_t paddr)
>>>>   {
>>>> -    if (dev->dma_range_map)
>>>> -        return translate_phys_to_dma(dev, paddr);
>>>> -    return paddr;
>>>> +    return __phys_to_dma(dev, paddr);
>>>>   }
>>>>     /*
>>>> @@ -94,19 +112,12 @@ static inline dma_addr_t
>>>> phys_to_dma_unencrypted(struct device *dev,
>>>>    */
>>>>   static inline dma_addr_t phys_to_dma(struct device *dev, phys_addr_t
>>>> paddr)
>>>>   {
>>>> -    return __sme_set(phys_to_dma_unencrypted(dev, paddr));
>>>> +    return __sme_set(__phys_to_dma(dev, paddr));
>>>>   }
>>>>     static inline phys_addr_t dma_to_phys(struct device *dev,
>>>> dma_addr_t dma_addr)
>>>>   {
>>>> -    phys_addr_t paddr;
>>>> -
>>>> -    if (dev->dma_range_map)
>>>> -        paddr = translate_dma_to_phys(dev, dma_addr);
>>>> -    else
>>>> -        paddr = dma_addr;
>>>> -
>>>> -    return __sme_clr(paddr);
>>>> +    return __sme_clr(__dma_to_phys(dev, dma_addr));
>>>>   }
>>>>   #endif /* !CONFIG_ARCH_HAS_PHYS_TO_DMA */
>>>>   -- 
>>>> 2.43.0
>>>
>>> How about the below?
>>>
>>> The function name addr_to_shared is too generic to be included in the
>>> dma-direct.h header file. Since we don’t expect it to be called
>>> directly, we can either inline it or find a more specific name.
>>>
>>> Additionally, for dma_to_phys conversion, we first retrieve the private
>>> address/alias before switching to the physical address. While both
>>> approaches yield the correct result, this change more clearly defines the
>>> conversion rules?
>>>
>>
>> Also translate_dma_to_phys/translate_phys_to_dma work with private dma
>> addr/alias right?
>>
> 
> You're right, that needs to be fixed. Luckily (hopefully) DMA ranges
> are not used by AMD SME.

I'm not sure what you mean by this, but DMA to an encrypted addresses is
allowed under SME and eventually will be allowed with TDISP support in an
SEV guest. So the DMA address (assuming no IOMMU) could have the
encryption bit set.

Thanks,
Tom

> 
> Suzuki
> 
> 
>>>
>>> modified   arch/arm64/include/asm/dma-direct.h
>>> @@ -4,14 +4,14 @@
>>>     #include <asm/pgtable-prot.h>
>>>   -static inline unsigned long addr_to_shared(unsigned long addr)
>>> +static inline unsigned long shared_dma_addr(unsigned long addr)
>>>   {
>>>       if (is_realm_world())
>>>           addr |= prot_ns_shared;
>>>       return addr;
>>>   }
>>>   -static inline unsigned long addr_to_private(unsigned long addr)
>>> +static inline unsigned long private_dma_addr(unsigned long addr)
>>>   {
>>>       if (is_realm_world())
>>>           addr &= prot_ns_shared - 1;
>>> @@ -26,13 +26,14 @@ static inline dma_addr_t phys_to_dma(struct device
>>> *dev, phys_addr_t paddr)
>>>   static inline dma_addr_t phys_to_dma_unencrypted(struct device *dev,
>>>                            phys_addr_t paddr)
>>>   {
>>> -    return addr_to_shared(__phys_to_dma(dev, paddr));
>>> +    return shared_dma_addr(__phys_to_dma(dev, paddr));
>>>   }
>>>   #define phys_to_dma_unencrypted phys_to_dma_unencrypted
>>>     static inline phys_addr_t dma_to_phys(struct device *dev,
>>> dma_addr_t dma_addr)
>>>   {
>>> -    return addr_to_private(__dma_to_phys(dev, dma_addr));
>>> +    /* if it is a shared dma addr convert to private before looking
>>> for phys_addr */
>>> +    return __dma_to_phys(dev, private_dma_addr(dma_addr));
>>>   }
>>>     #endif    /* __ASM_DMA_DIRECT_H */
> 

