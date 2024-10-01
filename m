Return-Path: <linux-kernel+bounces-346633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2265998C6F5
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 22:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 720D0B236F6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 20:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AFC01C9DFD;
	Tue,  1 Oct 2024 20:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="ZBYLI9U7"
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020139.outbound.protection.outlook.com [52.101.193.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB232194A43
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 20:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727815655; cv=fail; b=GtapGqEiVK0rEYwRlwgsh/zZZ7t8TO1RMEb3OLwOvWfa9DveF7nXFxH3Z9Nif0AYsLe4QUd1of3M5AwE0igVmI4//8wQwyLTefmpIHv7R0IUOA3EFRkv4IyMMHN228Cvxupf/P3YOvm1a4/eQWl8ZIUHjCrouKkGz3qMVcxNU7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727815655; c=relaxed/simple;
	bh=mbFKZwcFIh+/gIH5F4ifdDuzU1CnQWnHmKU1MW0CZYo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EZv/f9LSmTf/qhgjXlU+uSoD/Aq0h+GoaD+mKWI3exvMcWfeuQ9e5R9F8//NRQR9j0nGGVnzKAnb4qflsOWn6Mn6e1WgMb0fSSiBA8kFfkTUHEgFUdVUFXLQBvoTa4ZKanAbAwrB70M0mYkT+4h76MM2oeleBu4w7N1e26ehKis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=ZBYLI9U7; arc=fail smtp.client-ip=52.101.193.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KiC7vqvveWJsKfcBuxCm+TJ2AmuG02SzfwGaGov0Q2KJTLF4SJiz6jKq1jM4HC6Wpi3i21IMnxIc4eDj4EyO4s0RmlVRYk50d2FmO5BtnBjezqj5h2h5VyeJZKWkK/I2rfCIVqoo+5FFP3xoLUpcypbC8j3CsiCdQfgZuM3im/phQbBfrm7nLYjCPgLIDnc0KbjwVg25yqw1i4zzT3WYo6GDsmMGn6f171e9SQzMM/NqypJ4j9+KvkNA9FlIWBhYdJj6Jqdrc8Qswdw9rSw7KI0CutOLuaR8TMRhWs8f/83C7AGjvW62rEaeSK16FXbw0vL0brDbXT2Y7IToi6ZxIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j2P65OrHgLPC1fWIezxEF5kArVFG4yBPyIOICgZtd/w=;
 b=fTE7Kk33C8H4J8MRoFFSb1qgg/65rDMvq/E3tQ9a6BvgAucSqEMKl/yDEC27oQthe3UrOw9vh2J8Zilj2ARxj8Ai/+MMorPV+VzfW+wWdsnQjfPwexgzIPKGRxIXY76CWQeaimN+ba3/IB9fuAG5IuXAJIRKqqxtCyg+e5xQmyDKjfEcQU7FeiWpo/NKYTwmSoMKWrlAaIHn+4yjbct781DMk17J3VDVCyvy9urlFUBq94Rs0wM4/dk28iPXka9U0cprvF9N3YLGRB6QkpCLV5wGkDOXVpprmsOdLXSz3bGLPzhxe1ReBufxuhl8AxsxXbJYIDgKcv2MCvPQaU9YIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j2P65OrHgLPC1fWIezxEF5kArVFG4yBPyIOICgZtd/w=;
 b=ZBYLI9U7HPNX02n57iTn4SbcUQWt2Dox39NHuWh05CoN60WDYAmG7jCvZ/xKzZ3gNnfIAhMGMmEk0wb+3qqKLL/D8DcwrviaVBQK+bZ1iTs+77+wkc5T+ZZtCorYF6BslYzklIebynV0dECKWckbfxkbIKO1Yekwqyuj0TRms18=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 LV3PR01MB8511.prod.exchangelabs.com (2603:10b6:408:1a0::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.27; Tue, 1 Oct 2024 20:47:29 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%5]) with mapi id 15.20.7982.022; Tue, 1 Oct 2024
 20:47:28 +0000
Message-ID: <e374e8ec-29db-48a2-95d7-6fc9ac6317d9@os.amperecomputing.com>
Date: Tue, 1 Oct 2024 13:47:24 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/arm-smmu-v3: Fix L1 stream table index calculation
 for AmpereOne
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org,
 robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20241001180346.1485194-1-yang@os.amperecomputing.com>
 <Zvw/Kghyt9zUkupn@Asurada-Nvidia>
 <45b97496-29a2-4111-ba38-3c8bcf9f8b4d@os.amperecomputing.com>
 <20241001191800.GA1369530@ziepe.ca>
 <0e84f3c0-09d6-4485-ac76-ca296d1ee07e@os.amperecomputing.com>
 <20241001194620.GB1369530@ziepe.ca>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <20241001194620.GB1369530@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0P221CA0008.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11c::9) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|LV3PR01MB8511:EE_
X-MS-Office365-Filtering-Correlation-Id: c06101da-24f2-4cda-d3a0-08dce25a4314
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R3RXcWxRZEtSMzJlZG0yUW9iYjYrR0dOYzZzTzJSTExXWnZsdjhLZzh4M1Y0?=
 =?utf-8?B?SW4vL0xPanQ5US9RSXZYTXlSWExVNmc5cUQxVUdjMmc0MmV6b2hmZ1h6QjRi?=
 =?utf-8?B?ZFhML0h4RG1YbVpWZ1ZwaEFmbzBNT3M1dmxTMDk1ME1NMWxCRkkxcVQ3S2Rw?=
 =?utf-8?B?YzBZUHJvOG42Q2J2VDhMY0J2cXFrci9oa2I3VnVyaEVXUGxzV3g4WXkxL21R?=
 =?utf-8?B?aXBXU1dUZnNBOWRza0FWVWI0WXl4YTAxeEJhZnl2L08wMHJXb3lPMGFZL20x?=
 =?utf-8?B?UUpUNjVEMW90QkJ4Z2xlTzlyVTBON25KdmNpb2tvQXpqZ1U4UFMzdENnNmtj?=
 =?utf-8?B?UnhObVdrS0dIaFNVUDVlKzRoK0NKelJZMEE5TWZxMVA3Vm1EeENlcWJLYjI5?=
 =?utf-8?B?SFJDcTdtdkFWckVLdUp5aUZHT201UExCWHBaU055Ujl2ak1IaWJzWkNxTCtG?=
 =?utf-8?B?RFRoRWEwZHVPTTJWcnEwb2h5ZTFnRWprQnl1ZHU0NEVQQzdHWjY3U1VPSlI2?=
 =?utf-8?B?amNlck1ZcFFhMjZtdGw0ZjY1bkxYTEdRd1hmZ09FdlA3N2dTMzIxTVVNZ0hK?=
 =?utf-8?B?cm1hWkJCRVpWaWZQbWFpcUFxaFFhRnFYVjN3ZnNSczMwRkx2Y2pNRXhONWl6?=
 =?utf-8?B?VGFwVDNIamh6N3RuUGpsdW5xalBYUTVwZjhVWDVyZkdicE1hanlTSjlnNWRE?=
 =?utf-8?B?eW9EYmVmWXA2ZWhCaHJMM0pJaWdjRkNQTlNoWXNydmN3ZUxpTVUxNXNjZ0ZP?=
 =?utf-8?B?QjJEWE15NFc0QVltcHFub0Y0VS9qdVhjS3lSU09jWlZpQ0dGVzNVcTRZUkxT?=
 =?utf-8?B?cDE5UVpDZ1hzVWVaeTJWU3drY2o3TkJseE1qYy82WFE4aWhJOVhxdkdNMWYr?=
 =?utf-8?B?L0NXMG1qUFZyS2ZKclByUWVocmlRUnZuaDlhWGtHQVVrODFQcm9sZ2RXNFdC?=
 =?utf-8?B?ZWtvWS9CcGF0TU43YjBJMnoxand6WXUzbXljSDV6T1J2NDNCUitidjFDRnhl?=
 =?utf-8?B?Z3Jkd3hjcTJXUkE0REJTbm9oYXRMNlAyS3UwTXFmekxNU2V3cnRCMkg2NkZu?=
 =?utf-8?B?OVZQUTkzWWdEMy9mSVV5WExXdnROS3BLSmFBVklUWmVTblA5ZzBTVkMwc1V2?=
 =?utf-8?B?OGFsQ2V2cnU3NEhnM2FEUzdvb0x2UnlRNnRQbnpVVVpnbWY4T2RDNjVIS0hQ?=
 =?utf-8?B?SG5kQzk0NTZRSldocFZoUFpZeWpKMWo3eXhuZ0pDbW5DUHlxTzdJQmpocDRH?=
 =?utf-8?B?REREbk9pT09nZVBZWE1GZ0swS2pWbFpXNU8zRk9GL2l3ZmZ3RVRqYmNkKzNU?=
 =?utf-8?B?d0tqU3VMeVNCM04xMmZrWGhUWml3MUtIakdNdVlYYk5BODduc1ltQVRVSCsv?=
 =?utf-8?B?Q1FpNTlFNnA1Q0YxSWJWaEVGcC9DWlVJMWtSME8vcm1xMVJBNVduVVpxc2ht?=
 =?utf-8?B?YWJCR3ZOQzRwMXYvSGpvYjMxbDZObHFHMjl6Um5oSlJDRjhMTnMvYjBBSlEv?=
 =?utf-8?B?eElnc1RzM0lZRXZlNHpuOEkwM1RSa2pNTHYyS0J4dEFnbFh2S2dpV3QvUGFU?=
 =?utf-8?B?cFpocDRBN1hJZkJNNTdBM1hGWmx3RFFJdnF1NnJ6eXlZL2Q5SEs5dkNPWklq?=
 =?utf-8?B?cGRNeENZYWRXODIydWFIUVhEdytobXBNR1FmclBOT3lCcXcwc2NndkI3MVhh?=
 =?utf-8?B?b2sxZUJpZjZKeFhlUVBISVZZdmk2dHpTTm9hZHJrVWtESTduWlo2MXgxcWlN?=
 =?utf-8?B?UmRsZ1ZOcE16ZmNOTy95eXJrY1h1RFdhVmhiVTZSN2s4UFJrWDBBNzRoTGNj?=
 =?utf-8?B?NU5yK2o3Ynl0ZXZCSStiZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QkMwbmhzb0NxUFYrc3A3MHcyV3NnMEwwNUYyL0xPajlXNE1yYXFtWjBlRWJP?=
 =?utf-8?B?WXF4WlhqVEJNdWNTdEk5SUwvdGVNRVdGZ1U5T0E5VTJHTEpaWmlVeVVuWmxh?=
 =?utf-8?B?bUpCN3IrdGZ4M0g0Z0hpUzF4S1FITzYrWW1BcHdTSHdGS0dEcU9rK1ZjZCtL?=
 =?utf-8?B?RmI1a2FjbTlwb2Zqd2dqeW16azdTMkpPci9ETjBOQ2hERzRWUHhBRjgxVitD?=
 =?utf-8?B?cEx0NFA1Y2J0d09LSjhOdDFEWlZ0U2NaSit3Z3pkRHRFSTcxbXNhZVo0Nm9w?=
 =?utf-8?B?Z3lyTjNId1BpbFhLZWl5YmNSNXM4OTdCbjRqbnVoK2JrWS9OSjQ1WGx5NmQ2?=
 =?utf-8?B?dGE3eWxjVU96VGFkVFlVWWRCUGRtVWFwSnI5TVo5d2dCY0lKanFaR2oyRWoy?=
 =?utf-8?B?Y2g1c3pwbnlkRmNlZ0Z0NGUvaTgvT2labzI1V29BMyt3ZHR0YUx0RFdqRmNx?=
 =?utf-8?B?enJIY1pGWlZhWFByazlHdGZJZTBkWFlpc3Y3OU1tcXA0djhPUmRIajF3T3hh?=
 =?utf-8?B?S3M0dkhBSGh5aEpOWDVhMUEvOHlNNy84U0xvelFuVC9RVjZUMzZiOVB4am9o?=
 =?utf-8?B?eXlWV1hJMHJTQ3ZEeDVxSHZlZEliVWFDYmV4Qk9SYTR4Z1l6Zy9FUmFiSUxa?=
 =?utf-8?B?M2lJdVh2SlMwOHIvY25Nb1BFTjBENndwUGpiem1Ec2FqeDdEN1ZJWStuUGtm?=
 =?utf-8?B?NERIYWE4Y2FESDRUTkQ3WUxhWW9KUTdydjlZZlNLOHpzUXNQcHJlbjFZZXpn?=
 =?utf-8?B?blkvQ2xabWtkWlVaUkRpYmNmVWJaTjZRZWtaTW1OVVYwZkJEb3I3cjVmdEZq?=
 =?utf-8?B?MTNPa1dOcnRJeDY2VWl1VU04ekQ1Yy9Pbm1UT2hwYzBvM3FIQUZ2T3plYkF1?=
 =?utf-8?B?UHJoYm5vVGdLNnpoejJ3bXVjTGhiTGQ0alFXa3VDWkh2dGcxVlhFUVQ0WE4y?=
 =?utf-8?B?bjVyRFZJUTk0TlhxS2VVVmlVZnl1NGk0VzlLY01qNEVlQkcyTE5DS3lVdGky?=
 =?utf-8?B?YUUrNStDbFZqRkNmRkY4eFdXeW12VkdBVHJuMWFYM2pRQ2hkZUkzUWNYNmts?=
 =?utf-8?B?dFRpNXNaaHVMMXhucUZSQXJnM09hQ2NQVmpTNktDL2ExZ2dYclQ0M0tOa3Rq?=
 =?utf-8?B?OFpxL1M3UjFXTm9CbTNkMWxFdHlUMHhDZUxkVHFhSSthSG1GLytxeFNpMXNi?=
 =?utf-8?B?VlJnUCtMVGRqRmljMnR4UE5lMVVpSEoxQ3Ura2ZOdjVJYVV1N0xGakpwYkFw?=
 =?utf-8?B?TmdxK3p1dFFvNnFjRUtoaVF5eGNVOVg4R3JTUCtZTjNhNWFORTFqMWl1Wkpa?=
 =?utf-8?B?eXk2YWhTZkJBT3Q5ajRacVQyWHRaMTkvQ2FmZmlqbCtmeWFBYmx6bWFxTVpK?=
 =?utf-8?B?RGJVWGFzRUpuZGkvczAzR1U4L0JaZEZyWUdzWHJONXRMRTNoR1RwMjZkUjBm?=
 =?utf-8?B?b1gzZFVxWmdmdVl2WGlZdmlOdVRqTUY2bjk2aGVuT0lHUjQzQWg1RG1ZSkJw?=
 =?utf-8?B?ZUZSOUY4aUxwVEQwN1BnQk5wVUhRbkNDOFZLZDl5WjV5VWlDYzZ3SUVYbnIr?=
 =?utf-8?B?dGxmcm9wMXJkcldadjA2dGJQNFh2QUNZdFY1bDBEaFdHYkt3ZTRQbFgwZGNt?=
 =?utf-8?B?RWc4N09QTno3dVZUNzc0bjkrSjErdXRKMExRbVhOU3FNUEc2NzZ6YnhwSEVC?=
 =?utf-8?B?SnBkdFJ1bGdJUHRYSjZpdjBjbmFRQm80aU8vOTFTaUozZjJsYTY2R0pBWWsx?=
 =?utf-8?B?cW4vSnVDbEVveS9lK25QV2pndTRkTWZkeWpnTlFHTmkycG4yV0QzUlVPU1NF?=
 =?utf-8?B?ZjFZTjFIejcxZVNDamRaU2Fnc3VNeWprR1N2aHRKV1VuMytDcUVvd0tqbE1o?=
 =?utf-8?B?SWRJMFdXVlJxRnpkekwyd2tKQTFPbVJBSjdCb24vOE55d1kwaDNONjVxb2pI?=
 =?utf-8?B?SlVLZEtkQ3dzbXNNTjc1cDd4MndUdk5IVVRDcUJCb2FhT250NFBNNXZRU3ZW?=
 =?utf-8?B?RFBMNFZZNlZISHpFaXROZ3d1bk5rVmFYYnZjTFBiRXF4b1c2Qmc0bXlxTVRH?=
 =?utf-8?B?L2JLU0tnNjNjQjFvNzdvc2V0UEhNZHczM1E3VE5ERE9QRzBUMTJ2QU5Dc0lw?=
 =?utf-8?B?TEttckZTUXpRRVUxZWRHTjB1M1o0R2tVcy92d1FFK0oxM3RaOHl3V0poMnVu?=
 =?utf-8?Q?5uAgjeWaiI1Ju5CQzkdZrDI=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c06101da-24f2-4cda-d3a0-08dce25a4314
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 20:47:28.1199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: riOj4YvA0lhGYgeoHToWUnx7mdHpXT+GoJX0xtLz+ouG3dBWsFTUbfodOq7U3ZM2pAFKs0G5fI6hadD8xvoj2CsvdMh5hqrgkjQB1RApTrQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR01MB8511



On 10/1/24 12:46 PM, Jason Gunthorpe wrote:
> On Tue, Oct 01, 2024 at 12:38:56PM -0700, Yang Shi wrote:
>>
>> On 10/1/24 12:18 PM, Jason Gunthorpe wrote:
>>> On Tue, Oct 01, 2024 at 12:09:03PM -0700, Yang Shi wrote:
>>>>> Also, there are other places doing "1 << smmu->sid_bits", e.g.
>>>>> arm_smmu_init_strtab_linear().
>>>> The disassembly shows it uses "sbfiz x21, x20, 6, 32" instead of lsl. 1UL
>>>> should be used if we want to take extra caution and don't prefer rely on
>>>> compiler.
>>> Still, we should be fixing them all if sid_bits == 32, all those
>>> shifts should be throwing a UBSAN error. It would be crazy to have a
>> OK, will cover this is v2.
> Maybe just make a little inline function to do this math and remove
> the repated open coding? Then the types can be right, etc.

Something like this?

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c 
b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 01a2faee04bc..0f3aa7962117 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3624,8 +3624,9 @@ static int arm_smmu_init_strtab_2lvl(struct 
arm_smmu_device *smmu)
  {
         u32 l1size;
         struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
+       unsigned int max_sid = arm_smmu_strtab_max_sid(smmu->sid_bits);
         unsigned int last_sid_idx =
-               arm_smmu_strtab_l1_idx((1UL << smmu->sid_bits) - 1);
+               arm_smmu_strtab_l1_idx(max_sid - 1);

         /* Calculate the L1 size, capped to the SIDSIZE. */
         cfg->l2.num_l1_ents = min(last_sid_idx + 1, STRTAB_MAX_L1_ENTRIES);
@@ -3657,8 +3658,9 @@ static int arm_smmu_init_strtab_linear(struct 
arm_smmu_device *smmu)
  {
         u32 size;
         struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
+       unsigned int max_sid = arm_smmu_strtab_max_sid(smmu->sid_bits);

-       size = (1 << smmu->sid_bits) * sizeof(struct arm_smmu_ste);
+       size = max_sid * sizeof(struct arm_smmu_ste);
         cfg->linear.table = dmam_alloc_coherent(smmu->dev, size,
&cfg->linear.ste_dma,
                                                 GFP_KERNEL);
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h 
b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 1e9952ca989f..de9f14293485 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -235,6 +235,11 @@ static inline u32 arm_smmu_strtab_l2_idx(u32 sid)
         return sid % STRTAB_NUM_L2_STES;
  }

+static inline unsigned int arm_smmu_strtab_max_sid(unsigned int sid_bits)
+{
+       return (1UL << sid_bits);
+}
+

>
> Jason


