Return-Path: <linux-kernel+bounces-388971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 516449B66C4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 16:01:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5FA11F217D9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 15:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55FE61F4FA8;
	Wed, 30 Oct 2024 15:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="HUuwUEMC"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2132.outbound.protection.outlook.com [40.107.244.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A811EF0A2
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 15:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730300444; cv=fail; b=EjV3HzjeanXSEUKRzc9d+kOIma9HDXdLC32/ISJiXQvJHEbZmIX3Lj6hI3xCqElu5d2w0M6I9FRF5hM7X6APp/y21BEt8kN48uqQ+QINQl8ww46AYyf4qQywjV1gmtiC7HDEVGXgWIMm84vydB33EXH9GoD+nbkuUtPdb+Lxkcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730300444; c=relaxed/simple;
	bh=RdhnRHU1NZI5h+/PC6OmV+peAZWrG3L4G7xcAXt42jE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZFr25U9ihOv+lBV+WWByxW0GG6GD1s3hcmAyX2fWPZBIiXXxskC9P2Vlld/t9lxIXkCInIH1tHN+2qy1fhpqJgHejeS5sAY0HstrcggJGq5T0+LH5yRlGIqAOvpWydSJ+ux5I+gEcrS0PCkgTF8vuQYrlE1N8cikjtbARRNo4nU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=HUuwUEMC; arc=fail smtp.client-ip=40.107.244.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FuR29Yx8PBLJUm+StoidS1yWi9Z0PTF/ZZbKIW2z7Mzj1qqzmqShaQ4cCAeJjQs0Ohm4OW3pTapLsEcQwJJLlVqaFnlDFQSJnS9fDEvUN28rmi+CiRJZBM35S6Edu+bpoAcClt9iMxGGxj6FNg1WFtX2MNa0f/liNms3SGSbbz3xBonrH04MUs8L7j5lmDvRvApk0SuROgRMRivDGK39zU1X+K8qNTq1NEQfnqobyoOh3LifNx9QE8LCoE/i3l0Hb369bWVnruq34C+DI4YXruqc+CH9uI/Tz+CWXpSfx0nSlYeJaQ2rADJgZkZRfXhQO8XkKMyIkfqrfYGAu3hj4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X7eEFHBruordrUvclxgBfSKptx6F4JTAjGY/MSyPlAo=;
 b=AxeRbmra9d6130+XJZg7xElOlnryMMjwAcGW/SiHSGZxvzTiJrIqjrM4bC8fpT5uBcmAGNrfg1KjXL5JeYirlCtEGYCqKfq5/9+kf9kaeGFV5euXE8o1apggP9VRbYrcoyjVVBhtvM/zeUh4mqejpAqRBIpLjKQJVi0eR2aahgrwfHmc9W8Qq4r4pJr7dr5HBgdZzIIrj0hooFcuC9qKfojIJscxPR9uxyj68Vnv5witUGWhr1kb+S9GU7atAujQ9eybh4ybJAXF2L06pLhBdRztfQIbZyBSXvPzDnSIXu6uBi5hVhyjAGVvVebgoSUyzcidXdqB4Po4XMPoqUHPMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X7eEFHBruordrUvclxgBfSKptx6F4JTAjGY/MSyPlAo=;
 b=HUuwUEMCGZ2g5mVTReekqT9cGZNRuJpWKu549J1E6hwOKydhdefZhLb2Ehh4dZOg+POBXwmF8ulovSBPU/GFBkf3rOu8iTvwa3ZkhBeczkFOijqoBDg5XTDaQygFUPlWlAMDtvMOSW8ITr8CiMXS8UeDNtheqZREtABU8XJju4c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 CH0PR01MB6969.prod.exchangelabs.com (2603:10b6:610:106::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.20; Wed, 30 Oct 2024 15:00:40 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%5]) with mapi id 15.20.8114.015; Wed, 30 Oct 2024
 15:00:40 +0000
Message-ID: <d8ae6912-66f3-4910-bc61-cd653d8dbf36@os.amperecomputing.com>
Date: Wed, 30 Oct 2024 08:00:36 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH hotfix 6.12 v4 4/5] mm: refactor arch_calc_vm_flag_bits()
 and arm64 MTE handling
To: Catalin Marinas <catalin.marinas@arm.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Jann Horn <jannh@google.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Linus Torvalds <torvalds@linux-foundation.org>, Peter Xu
 <peterx@redhat.com>, Will Deacon <will@kernel.org>,
 Mark Brown <broonie@kernel.org>, "David S . Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>,
 "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
 Helge Deller <deller@gmx.de>
References: <cover.1730224667.git.lorenzo.stoakes@oracle.com>
 <ec251b20ba1964fb64cf1607d2ad80c47f3873df.1730224667.git.lorenzo.stoakes@oracle.com>
 <f5495714-19ba-40b8-a3ac-fe395c075a36@suse.cz> <ZyIRbbA-_8duD2hH@arm.com>
 <c8760d0e-acbd-4fd6-b077-58b5c374cad3@suse.cz>
 <3f184fad-e0da-470a-888e-70a17419e206@lucifer.local>
 <ZyIpAwt0MSAhgs2t@arm.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <ZyIpAwt0MSAhgs2t@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0058.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::33) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|CH0PR01MB6969:EE_
X-MS-Office365-Filtering-Correlation-Id: 7697dae3-a9ac-42d5-10c0-08dcf8f39eb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bTR5Q0owYlJJWitzMzBXTTI3eGk0K0Y5SGh0MFFlNzNVcTNhS2owSzZsTTFP?=
 =?utf-8?B?K3BSWVlMMnBZUjgyVEZoSUJmK2JFa2ozWlZzVG56NWdwb3NOajcvK0dFMHgw?=
 =?utf-8?B?YUphYjRSSDRhcmFzM1FoZGhLaFhBTEo4WVBnWDZaeUxPMXY4eUZIUVA3Smp3?=
 =?utf-8?B?OEcySFIyNkcxOXprSzB2YWszRUdCbE81ZW9Eb0cxUlg0bEJOZVFodzJ4Rm1S?=
 =?utf-8?B?dGNtR2ZqeTVJK0tLRENROWh6TkVSb25BTFNra25UL3l6cHJXY3o3TWt3dS9q?=
 =?utf-8?B?ZTg1aTRQVUttMkpGbVRKMUE2WENZRTlxLy9FYU1yNndlaW1kNkZnUHJaK3d4?=
 =?utf-8?B?K3pxcnpDT2J3cmltNWxXNG9TVnFFTFRiTWM4NlcrdC95cjRrdktWeERDY2Fp?=
 =?utf-8?B?NFp5U2NuZXlJZkt3MjZXdXF2MzR6NDJrVitPVHc3TmVFK0lURE1VWUEyMk9o?=
 =?utf-8?B?OHY2cEJROVk1RHFZcm9rZUpwVFg3b0JQWHFUSlJLR3F4c0RoUGhnMmpMVWNn?=
 =?utf-8?B?UHpQRzl1WUFhaHlha2hFMEVzMThOUm5zUHoxZElEVWZ2cFBJK0trYk4yUk93?=
 =?utf-8?B?Zko1cktzQ0pYSnhTRVVYTytqYUs3MEZkN0ZMUVUyUWNHQTlSTS9NVnFNSWRT?=
 =?utf-8?B?NnRHZDJ1c25NTUdLVjRWdlBiWFhObXRFYVd6RDZ4a3JaSmxDeG5WWjJ6c2Y2?=
 =?utf-8?B?SXowUk1iM2dzTWFreFl2RmROeWh1aWMxaHhXeG5BL3lIVDZqanRFMEZQdHJy?=
 =?utf-8?B?cmhrWG9MQWQvR0lLTHp4US8vM1I3RVppVFFGVGVuUEpjTTFSZllhZHd3dkhz?=
 =?utf-8?B?QUs1Y1hvTXVoc3poMEYxUzVPK2pGTVhBYkl6N3VWQ0NKNUFybXh2RzY2RXlN?=
 =?utf-8?B?cmpBaGtZTHkrNC91U20xb2JsdlF1YW1Zbkdoc2xLTytKNkIxeEtmaGNVWko4?=
 =?utf-8?B?SzdoR0RPYThwRUkyMXpHdDh5ZUdaV1NsU2dYNytiMElZd0VNcUVTU2JJTmhv?=
 =?utf-8?B?QmpOSEQ5ZFg1ZEpGV2Q5Nm1pNzg5MTYyVldFZVJIemQwdkRhSUVNa1NjNlE3?=
 =?utf-8?B?NzIxNEg2MDViY3hYZDVKNjdIYVBQQnhPNG1INEtnSHdrcWNVNlptTUxXMjdq?=
 =?utf-8?B?Y0dFbUF6R21rQ0VEdkVLUXJVdUZOTjFlNU0vUWNRdjFibUxUam83SXlSaHA0?=
 =?utf-8?B?UnpYc0kxT05MSjZWMmdlb1krcndXL016NDlXNXBRSDREd20xdFdyNis1aklD?=
 =?utf-8?B?UFVPSXlRdklnSk0xRlhJUnVsREI4Z3ZiRjlUb0pHN3lXZDgxc2NheXV0TlI2?=
 =?utf-8?B?TjdVZ1M0Z3JkZWg1eTFsejhpK1RDWVlTTEIxZEVod21xU0o3SllWdUVBT2p2?=
 =?utf-8?B?Uy9DV1E1NUlqUmJTU3RiZ3V0YjJERk8xeW43YitZbWh5TTVtVDZjMUMvem1l?=
 =?utf-8?B?QzBTWXlUZFJKRXpvbEh6SHdCMVFtZk4yeEVYQmZFdU5CSHA5djB4LzVvZW5j?=
 =?utf-8?B?cjVWWlY3WlNMbkh5cEUvcFVDZWpWWXZma1V2NDJiOFd6aHREaFh3L1NWbS9x?=
 =?utf-8?B?N2k1ZWw2UUZOK2w0cnJzZHBnNXdJRDh0Yi9HRlZ4cys3NmRxQmFLVVBOSmhL?=
 =?utf-8?B?Z3ZsNmROMU5idDRCdHlvQlNucXJRdEZaRmpwNVFzN0hDM2gzbDVOSUR6azd2?=
 =?utf-8?B?b2poNVErRUZQbVJQZjJEbVhmSVBEZ2k0Y3ljSHJ5WkdBSDZzTW04M2JZb2hN?=
 =?utf-8?Q?qYBCK73IDNO8E39YT3ZGF+4Knei+2ZqiSBlcLcJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RHhCTEIwQ2FDOVZydzBLUTVPTGw3YUlJRUxHdkZVRzRnbU9nZTJBNy9Zenkx?=
 =?utf-8?B?SDg1bGdmdHRYdnVvWTIrb0wwZ2ZhUk5pR1BNbUVoeVNiazJycXhsWHhXTjZ6?=
 =?utf-8?B?Y0djcUNkK0VGdXZoeTMzMlBDTUdCTnIvNFU3V2R2ek1zRHpMcDVMUGJ4NHpq?=
 =?utf-8?B?c0pDK1JCQzhWb0JBV21NN1JFYVQ0N2xVZEVWZ1pKNkNwMncrcHRQMktUNXN1?=
 =?utf-8?B?Q0pZdzVBTmlhdHc0cERiOEhLcEtJRmpRMFhwVU82bFdvck1PMnpzZVliNHRx?=
 =?utf-8?B?U0lQcGc1TXRTT2lDdmIvQUY1L3ZxVEVGR0ZacThQTTJBenovMzROSHBlRjgw?=
 =?utf-8?B?cVo4cWZWOUVKYnRoQUJyUjJHT3VrZ3RYNzVWRjJOdGVWYWdsM2U2TFh5WkMw?=
 =?utf-8?B?MlQyS1FjN3BFWWVacXA3TldNdHp5Nk8rbFZUU0RHaHdPTlZaS3BDdm1PRW9H?=
 =?utf-8?B?VEd2SmRxY2Z4R3Q1MjV0dE9ZN0tQeVFHT1AvNE51VTZDSHdIZllTanZSV2t1?=
 =?utf-8?B?WlpSazRTUEVUVktaaHB0VUV3RVllQW1EWTA2QzE3L3BFTHBtalBPY0duM3ZV?=
 =?utf-8?B?eDBaQzJaY0hGclRxeGtBTmFBVzNET01xSE9uVTFhY0c1R0pQT21lcVhRYWtt?=
 =?utf-8?B?YTVQUVV3Rk43TTNldzRzU1BDbnlpNmdWSERmL3VBL0l4K2xwNEtveGhNZytx?=
 =?utf-8?B?S1BBOEJVc3hEM1JFL1NyUFNFS2w4Mzh1VkJ1Zi94Q3NsUWZreXRBSXhnMW14?=
 =?utf-8?B?NzF1Qmd6T1U1Tkk1WFk2TXlGejlMNWlvbjZXK0JhcFE3cDdtL01yUm9xQ2hM?=
 =?utf-8?B?cGExaENWVVdEWDJGa1M0Y2dTZ1VJbjVVM3FrV1V0bTZWSzBsejF2cC8ybkwv?=
 =?utf-8?B?SnlpMlpSNU9lVHUyQkl3aFZmdlE4SU9UM2NMZVoybHRCRXpjaVBIVmRidjJI?=
 =?utf-8?B?c0RwUnRCbzlHclZlcjJlTWhGd0F1V1lacG9pd3hXeTcvMVMvWWQxblc2QzZC?=
 =?utf-8?B?QjdHRkNUVmdrSDNMeWRCV2tTQk9JNjZsL0ZTeDBrMG1WaDRvMDVpdVRsY09u?=
 =?utf-8?B?cWw0TmM0Y2xxTjFUTEFlV3cvSHo4di9zTUJsZG9zM0pIWVFLZFA5L2VHd0RM?=
 =?utf-8?B?Zkw1Smk3Y2hMenFHQUhyd0U1ZGNMcFpuSXBKQWpOaEdpQThkc2FjSVlNbW8z?=
 =?utf-8?B?ZVpqRFNKeWJRMk1qcGw3VzJ0cEFoa3pLaGRhUW1qUllqeTFtMFZsMFVadExU?=
 =?utf-8?B?OGhMNXEzLzFOc29pTkh6bnNUSkN3STE4WXVLS2ZxT1Fjc0tTOFVuRW1EaCty?=
 =?utf-8?B?S1hLdStEZEVkc0FuN21QMzEzdmUxMzVKR281eUNKci8rR0Z2cHJwL3VRTGUy?=
 =?utf-8?B?RlliYWNJM2piaG5iUytYOXdFK3dTenhtYWhxK05ReSs0Z0xDOXhBOEVoSDdB?=
 =?utf-8?B?czZ1N0ZqS3RESFVKUFBCeEIvL2NybElwaUtFenNQRW84OGRYZlVneC92ZjMz?=
 =?utf-8?B?KzgxNU5NQmdEelAyU05RdU4yMFJKaWp2Mk9jK0NNR3lZc2J4dzBJS1lKQmRu?=
 =?utf-8?B?ZWxIQk5IUGtlVldjWCtpZE5Qai9WeTRkUXZiVWtvNFAxUDBrNmpSUnpRcTZR?=
 =?utf-8?B?NnRxZmsxT1NVNXJzcHd2WEo0TDNPRWdvQzVJM1JqRGhGYUE5L3pOS252NWdT?=
 =?utf-8?B?QlZuMzhsa2ZEZm1sV05vbVljUzhZRFVqamJjSkNFT1pWNXdZV1I2TklLSHdI?=
 =?utf-8?B?M0g3T25Qay9kY0lFMjNJMzRWWU94Z21xY2ZLc1pmSVhQclFwQzJPdXQ5dFdr?=
 =?utf-8?B?NGRNOXo5NTNPT2NEczJpdEFhRTZ2ZXgwOHdZNDBXSE1NcVA3NXJEZ1JMci9o?=
 =?utf-8?B?K1NrYXl6Y1hZK052RHNRaHBIVFBzNlUyYWlqNGZ1dGVtekF3UnVjaE40d1Fi?=
 =?utf-8?B?NUlMU2I2eWhpYmFBL0orTjhQLzZLZjBKb004TXRaQkVya2d4MjRPaE5nUWlo?=
 =?utf-8?B?ZVBPRFkvd1ZOTXk0UTZkRUptTENwQjE4WGdHVWxjcFJCbVUxQWN1YTNka3Y2?=
 =?utf-8?B?NmQ0MzNXNW8wU3U4NTlNMmN6UjdxTU55Q0E5Zng1eEFTYUFPNlRteVJLNDIw?=
 =?utf-8?B?LzlUbGw2MFJvODhsc0dBajBqakVkYU1TaU1QZWxJTVFnSTlta1dKTVorcEpz?=
 =?utf-8?Q?OjBke1h2BzWYjFxqJN77Bys=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7697dae3-a9ac-42d5-10c0-08dcf8f39eb2
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 15:00:40.5385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xIT7ulD502Vb3RO2CZgsqkOP00yhUIIKDWhx7Zvhxz8OAi1uIyxTE7X1VfxSJitOsThMkUOLP9sE1LNGYgx8nBSJmacO8d/C7HdeYoYXPW8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR01MB6969



On 10/30/24 5:39 AM, Catalin Marinas wrote:
> On Wed, Oct 30, 2024 at 11:53:06AM +0000, Lorenzo Stoakes wrote:
>> On Wed, Oct 30, 2024 at 12:09:43PM +0100, Vlastimil Babka wrote:
>>> On 10/30/24 11:58, Catalin Marinas wrote:
>>>> On Wed, Oct 30, 2024 at 10:18:27AM +0100, Vlastimil Babka wrote:
>>>>> On 10/29/24 19:11, Lorenzo Stoakes wrote:
>>>>>> --- a/arch/arm64/include/asm/mman.h
>>>>>> +++ b/arch/arm64/include/asm/mman.h
>>>>>> @@ -6,6 +6,8 @@
>>>>>>
>>>>>>   #ifndef BUILD_VDSO
>>>>>>   #include <linux/compiler.h>
>>>>>> +#include <linux/fs.h>
>>>>>> +#include <linux/shmem_fs.h>
>>>>>>   #include <linux/types.h>
>>>>>>
>>>>>>   static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot,
>>>>>> @@ -31,19 +33,21 @@ static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot,
>>>>>>   }
>>>>>>   #define arch_calc_vm_prot_bits(prot, pkey) arch_calc_vm_prot_bits(prot, pkey)
>>>>>>
>>>>>> -static inline unsigned long arch_calc_vm_flag_bits(unsigned long flags)
>>>>>> +static inline unsigned long arch_calc_vm_flag_bits(struct file *file,
>>>>>> +						   unsigned long flags)
>>>>>>   {
>>>>>>   	/*
>>>>>>   	 * Only allow MTE on anonymous mappings as these are guaranteed to be
>>>>>>   	 * backed by tags-capable memory. The vm_flags may be overridden by a
>>>>>>   	 * filesystem supporting MTE (RAM-based).
>>>>> We should also eventually remove the last sentence or even replace it with
>>>>> its negation, or somebody might try reintroducing the pattern that won't
>>>>> work anymore (wasn't there such a hugetlbfs thing in -next?).
>>>> I agree, we should update this comment as well though as a fix this
>>>> patch is fine for now.
>>>>
>>>> There is indeed a hugetlbfs change in -next adding VM_MTE_ALLOWED. It
>>>> should still work after the above change but we'd need to move it over
>>> I guess it will work after the above change, but not after 5/5?
>>>
>>>> here (and fix the comment at the same time). We'll probably do it around
>>>> -rc1 or maybe earlier once this fix hits mainline.
>>> I assume this will hopefully go to rc7.
>> To be clear - this is a CRITICAL fix that MUST land for 6.12. I'd be inclined to
>> try to get it to an earlier rc-.
> Ah, good point. So after this series is merged at rc6/rc7, the new
> MTE+hugetlbfs in -next won't work. Not an issue, it can be sorted out
> later.
>
>>>> I don't think we have
>>>> an equivalent of shmem_file() for hugetlbfs, we'll need to figure
>>>> something out.
>>> I've found is_file_hugepages(), could work? And while adding the hugetlbfs
>>> change here, the comment could be adjusted too, right?
>> Right but the MAP_HUGETLB should work to? Can we save such changes that
>> alter any kind of existing behaviour to later series?
>>
>> As this is going to be backported (by me...!) and I don't want to risk
>> inadvertant changes.
> MAP_HUGETLB and is_file_hugepages() fixes can go in after 6.13-rc1. This
> series is fine as is, we wouldn't backport any MAP_HUGETLB changes
> anyway since the flag check wasn't the only issue that needed addressing
> for hugetlb MTE mappings.

I agree. The fix looks trivial.

>


