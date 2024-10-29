Return-Path: <linux-kernel+bounces-387189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE4E9B4D59
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 16:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72DC61C22575
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 15:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509A4192B66;
	Tue, 29 Oct 2024 15:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KBv4khiS"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A361747F
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 15:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730214950; cv=fail; b=EOjHadme/umuAFKLglmyY44Eh2qev/5z23dZx4mLdDxY5XQi8QDlj+VC0dEwORGt4VX7+u7YmMmccfJKRfVm79gBMtgwU9FEpeTUwwByls12xMMdKiKd7ue4khd7N2NPSXv2JNOVJ5dHZX/tz+luyObIhWjsd06zk5QAulYgeg0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730214950; c=relaxed/simple;
	bh=OnBODEYfFOyFP+vlGBLU9l7Qxhgt+2ICGmPOXhLBWys=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=diljMYVt4DTl13c4S8Y6H1R468GTn9LMizoZaw5fuyHJgjmkqIc31gqXYV0Jlx5RMUNANCpxMHJiktxxHb9+2HLrOWvaVizV0+5GH3TqxGAZSEc9cI/WEAIsj8PfXf7m0hCTxKs/f/nvGEX+6kDBi94g28lEaEM17+90BVp2OxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KBv4khiS; arc=fail smtp.client-ip=40.107.94.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ytuXck4F/RDqmxN7uL1Iub0c/AyLa2+c4a6fIszL97TRJF1WkGq5qDluyTvYfuWacu4NZV7pzm/B6JH0SG3CN3P7cDQ/TzylPFyUcXrnfL9jPHV0lg17pZBTlmMipfBfLWxfTXjDwhgOzG16LdhK2kL8ajfJ7PldMFvUOw4OVUDpWEtrvPsHbw5OwwXbf1esoEPOhm/I6EjOco1hzPzOsAP+q4uYyPv/KoX2/Utw1a08lCuG4LpDpngHJ+dHLv/2nX19TOCnsP76Dexct//W7MJQLfiOAYT+z24ftxUWbkD4w7poscQfa2lrDCMJq73KSNjXQj3rRltnNRF+0DE3ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uQJXeJ0SIDHz1F8vCh65Fch+V5XfiyLWLJQIKKPZqXU=;
 b=WnbWDBVD5+xbjnfFgCsS8jxR+8vMxK4C1bUY6JChjTEk9LrElhYXOU//krddEGIb9UWt0WuVIgdho8Bau/ocACddgZjt4x6lYd+Nsv45S3a6BXYRSPKarVOE399+HAQNosv6Q2lms9ckveOhEKAoc2jzOq4Ntl6SA2EAJ4Z4yzYzbm43zNpeXN9YHynMMYM48NStp+85VngjZax/QaH5Y4ADLuezjVfyn+7aOGGG1kLLIvHI03F7lvUxI3ot8ydB1cTeLVxvh86Jo5Dy82dZAbIChPB03qFGmGVZLQZXwHl+VAGtIvwI0OUtZXQkPpAtsKOHqplErmUbcL7uAyriEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uQJXeJ0SIDHz1F8vCh65Fch+V5XfiyLWLJQIKKPZqXU=;
 b=KBv4khiS9nTc8w5tsCDuycd3EqLjQ8EcewlCJTu51p83dg1l237zJK1clPAk07xAUJxqnqvX2kvqkQVM48H4m4/IepLqDZKK8ufckdA5g6ecAy1MfILlVkMRxlKs39v/aUFYAbym1HswzBhMK1fQEsx9nGIFPrpAkLtYnbyQcCQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5176.namprd12.prod.outlook.com (2603:10b6:208:311::19)
 by SA1PR12MB9001.namprd12.prod.outlook.com (2603:10b6:806:387::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Tue, 29 Oct
 2024 15:15:33 +0000
Received: from BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::ed5b:dd2f:995a:bcf4]) by BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::ed5b:dd2f:995a:bcf4%5]) with mapi id 15.20.8114.015; Tue, 29 Oct 2024
 15:15:33 +0000
Message-ID: <990cdc00-92e2-41fb-bbcb-26f413b97494@amd.com>
Date: Tue, 29 Oct 2024 20:45:27 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] Introduce initial support for the AMD I3C
 (non-HCI) to DW driver
Content-Language: en-US
To: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Sanket.Goswami@amd.com, linux-i3c@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20241023055118.1400286-1-Shyam-sundar.S-k@amd.com>
From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
In-Reply-To: <20241023055118.1400286-1-Shyam-sundar.S-k@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN0PR01CA0020.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4e::8) To BL1PR12MB5176.namprd12.prod.outlook.com
 (2603:10b6:208:311::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5176:EE_|SA1PR12MB9001:EE_
X-MS-Office365-Filtering-Correlation-Id: b58a670d-addf-4bfe-879d-08dcf82c886c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L2hlSFcyRllsNFpicTdIRkpVYjRWaGttc3NtVHIrWXROUjEzZE10cU8wclhh?=
 =?utf-8?B?MVRwbzNJcnY0dk9FQ1NGaXZpcWdOWlBDZ3dMcmY1MlZzVFVIS2swTm4xMVo5?=
 =?utf-8?B?QzdPa1Z3LzRTU3AwZmJNMTZzdGdXUUs0VE1CZTUzQ2dRelAzM0RoQ1JnbEhS?=
 =?utf-8?B?WlQvSmNna3Y5U2xYd3EzZ29oUXFqV042bFZXQnd1dTk4QnhFdDV0OGh4d3lJ?=
 =?utf-8?B?MnJJRUZ6STdoclg1QkhQbjVDamtwdlRCOUpzQXdEMGRpZUVNRXhVdmRhRkVt?=
 =?utf-8?B?OUdWazlxVE5UUnpqNlJPeXlUUlJiUW5KS2kwQ3p0UmhKbUo1N1I0VUJ4M0F4?=
 =?utf-8?B?Z1VUU2IyWlFkWjRDR3hxZWM3MEhzQ1JtOVJnZUdlT2JOdjlOeUs1Z3paMndG?=
 =?utf-8?B?NjZqVEYwUGg3bzk1TnZjR2lzaVBXdXZhdE4vbXp4eGE0Q0RYdGZsbUhEUnFi?=
 =?utf-8?B?V1hFOVg0dmxrODhWdTM5emVnT1pFQTZzdHp6cTJadWEvam9BazJmRHBtVlR6?=
 =?utf-8?B?dWcyZ3ZGMXE4TlFVS0xPWVBuVjZFUUVqaW1icXZvTTltQllzRFBkdkRpZ2sr?=
 =?utf-8?B?NHNwUXY5Z201Q2FmQlN4N241ZEY2a1NDM3lDd0RBS1dsL1JkS2Y1MVhVYnRn?=
 =?utf-8?B?S2wwNnRqemVKMHlJdHJjRjdVbXVWQVdacHJNNHA0ckJkQkdZa01KQzgwbEwr?=
 =?utf-8?B?OFVXOU5ZQnZ1K1Z4WU1MTVpTTnAyUUliL0l3dzJRblVXd1ZPeForMml0YWNO?=
 =?utf-8?B?TXBaMVQ3dFRXNUhOMHlEWE1aeTlodGZiRlNGa015RytTSmZsVnFUa2Y2R3Nz?=
 =?utf-8?B?emdPd3NZNU1JTnJueXFtV3JsVVl2M1JXUzNhNlhDTmF3Qi83VHc0bGdrWXVP?=
 =?utf-8?B?VktKWUViZEhNd05XQlN0bFNlbStwMy8rZ0ljdDZZVUxVQml6ck94dnlKTzFv?=
 =?utf-8?B?cXYvaUJna2hxWUFOUXBULzNtVWhTREkrNmo4R05IUEhnTW14ZThPQmkvNUQ2?=
 =?utf-8?B?ZkxRMEh5QWc1cUFVSHE0Vk9KYkxRRk5WK3JQTlBkbnROcDRlSSttdklLNEpj?=
 =?utf-8?B?cG12Y2hnQUg5RHFBWTNMRFlQNXowN1hUTXRxcHhXcUpUTWtDMFFMalcvcjdT?=
 =?utf-8?B?MTNCRXlTbDAzVjlwSlZscXc5N21ielloUFZuMExrTEpjdjVnUzJYd1hJSUVk?=
 =?utf-8?B?bUNPV2V6L2pnYmdNcE5vNTVtdUZBK3N0OUZpZCtTMS8yK1RzZ1dpVGZSbjQv?=
 =?utf-8?B?VWUvTWtMRE0xOFgydnlVb1dDV3lOVG5RSUU5SXZ0VnlRc09yV20rbjNzVWhK?=
 =?utf-8?B?dmc3TklWUUpZUlduVllaOGFmclVjVExaY3BNOGdNenRlcGZ1bzhUWTlpbkpH?=
 =?utf-8?B?MytnVFpOVGRZNjRTL2VNK0RFMEkvVUpzN0ltNnBwaFJDYSt4NWRRTjlYb05l?=
 =?utf-8?B?U1U3U0cwcDZ5dWpoS3FRWGhjcDJ5T2ZTallxTjFVSkovNE9Kb2VBUUJSeTFB?=
 =?utf-8?B?SklXeWR3NlN3WjdxR1l1bFRTaVV1RDBjV0MwOFNsUDhkdXlLbWlTWElCQ3Fa?=
 =?utf-8?B?TnZRV0ozYlYra3pWUmh1LzVTZkV4VlJhN3Y0QnB5SXJOVjlCaXNKd2N4UUJV?=
 =?utf-8?B?R0tXdW9aaWNraTFQT1ZTSis3STJaQ2xWVXZtNkxDSEJhUkZKMFdCcXNEdm5O?=
 =?utf-8?B?Ni95dEJyK29XSVVHbzFVZVN4bm9MZ1JSeElqSThLVmdLb2cybjRTS3lycjBj?=
 =?utf-8?Q?QXBOEpbCNxmvB2L5zw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RmxlMUxDZG9xdi9Sb2J4VG9Zb3dPWFcwSGhFUjZBOU5pcDMxZk9oVmwzeGFu?=
 =?utf-8?B?ZWx6bTNkWEVBQmdoYlM0c3l5OUpEdUZoYjBTdyt0L0dBWmtiYlVtc3Z4NjdN?=
 =?utf-8?B?ekFlcWx4OEV6LzdMV05mY0VJOG5kVlRLR3FOTHp6c0s2cnhGb0ZabXlEakZI?=
 =?utf-8?B?Qy83aEJGYjczWlA3Vkdobzc4RUgvb3g5ZXU5OXBEZG9VaDF4NjBzMXd0TFhS?=
 =?utf-8?B?Z1JZU20vd253MkM1ZGYrQlhqdTM5R1B0NUdPRlVLZEwyL1dOa1QzWlNscFhY?=
 =?utf-8?B?R0s3RVRxc05acGtDdGl2Q0hqeHlrTEtVNXhYc245UVJqZTU0M3RubHhRMnhN?=
 =?utf-8?B?Q0hlZUZoOW5hZnNtdDRUcnFVUjA1RjNqeHFDWXhRV1F6Mm56UTdWU3BSbVQ0?=
 =?utf-8?B?UnJKMEF0aFVycU1oMWZaQi9qdm5YRzV6K2VEN0VFQVhQUldpQ21qeUJBNTJY?=
 =?utf-8?B?RDFVQkJtV080QU9vTHVIUGZTVW9leVFTakFHNzNCNzFlSzhmVDdRR21MYXp1?=
 =?utf-8?B?S1lLa2JTeWlCNFpTckJXaE5mSTA3QU0yV3BJbHRPRVdGaGNBMkM0RWM5SGgy?=
 =?utf-8?B?VnRTVjZGelhZZkIzLzNRbi9mQzJYdDhpNmNISVZOS0d4ZzM2UkVlWUhvdzR2?=
 =?utf-8?B?aHVyVWZUK2EvSGxZR2dXd2J1aDF4cGUwU2FRYVg5dk1OV1VnY3kvbWNtWXEx?=
 =?utf-8?B?cXlERENxS1dtTzYzRHYwZklabE9KSjErVXNBc1hyUkRMTlluazBGVXpONERG?=
 =?utf-8?B?TkNHVGc2TEs2ZnFDU21adEx2R2JHMFJNUEc3a2JFZnBnTzBXZkVsbzEwdksz?=
 =?utf-8?B?bWFVcG55cEgvRGtubCtBdkhVQTlyM2pIY2Z3dEpDNnNsYjFhS0I4VkF2RWkz?=
 =?utf-8?B?T0wrYmVFNWI2NjVHQW0wdFk1VVIyVlZoOFZZTEM1cExYR1hqMTZmMnJFTld3?=
 =?utf-8?B?cHN0amxmVHNMazVVd3JpcGxRSThhSS9sRTRWb2hPeGZqenZwc0lPNWx6NXkw?=
 =?utf-8?B?R2lTUFBHOHE3WUppenEwcmRvZ1g2TVJtaUsxS1RFWnBEMzNwcFBOM1Y1T1Z3?=
 =?utf-8?B?NTdtOTVUVDJTZEYvSzVLd0U5VUpsSzd5cjFmUS9lbVdXdVYvUTFUN1RaeG9V?=
 =?utf-8?B?OFdzK2wzczU4aURlbmdwam5WRXkySmxCNWMraUdnMjNtWmFCdzBXc01NUGZT?=
 =?utf-8?B?SDl3elY3QmxRdWJaeFlwOGFxOThHOXlxSXF0T1BRYTArWG9aYTNsS3dwaWdz?=
 =?utf-8?B?SFo1UlZzM0Q4bXJmN0RUYitvVXROdG56N3V6OGhXSGZJUWlvVTBYQm5WZWgv?=
 =?utf-8?B?WFd0MG1xZFlwQzBHMjNzVnFWbzlmUWx3THF0UmJNNHBFN3BqaEVJdUk3bzZv?=
 =?utf-8?B?Y3MranVlY3pBMGFuZm9wTFZLTmlGUDF1Si9KS2V4NktKT3hlc1lWcWVxdDc4?=
 =?utf-8?B?bjZqVVdLeEZtc1Riak1JQ01CVTBmcVNnUlhaSU9ZbVN0endwVXFpWEs1cFJ4?=
 =?utf-8?B?aHdteXJnNHZkTE9xNmFHT1FNRk9iMkNiVStBbHlmbTkvSTNWV0VSMGFNeHg3?=
 =?utf-8?B?WCtrZnRnWVNEQ3VYVDluSVQ2ZXc3TjFBejdDYkpPS0NYUmFNekJ6M05mZ2V0?=
 =?utf-8?B?MHF2V2c1QTdvUGxhUjdQb1RoTkxZa3FkcG9oWFBIaDFiOUJVQ0FsK254NWNs?=
 =?utf-8?B?WVZrUGJLMFFJOEpnZ2c0QzUvaHpyZXFETXpxYUN6U2pIM1l1RjA3Wk81ZTdn?=
 =?utf-8?B?N1lHcGJRL0pNc3ZocGEwWWQ2cSs2dEVlMTNJT2VaZVB3RVdGWWZWRDE4cnB1?=
 =?utf-8?B?LzZrbEgwZmRGTnJMcDBnVXdzMGY2K3RUa2twbHRicDBjRE1VNmpIOHNWc1dL?=
 =?utf-8?B?V21BZFhIVmxVbzk1dUpIaklIQ1ZXazJhNHB1R2hSRjZvRVJlajNZU2c3bTUz?=
 =?utf-8?B?RFJNLzh3UEQ0TDR3Smh5bkNIZFlRaU1scGd4L2liL25ZcXByV3hJWDJSQ2g3?=
 =?utf-8?B?S1A2bVZsT0RNS2J0L2JHV0VQWERVTHVtQ0R6MjhiWnI0Vkt6TEc4ejFpdG5H?=
 =?utf-8?B?Uk8rQ21Xc1VnZURjTjgyak9uYkRaeG85em9VZUcyQ0JIRGwwb2wwNzZFMXN3?=
 =?utf-8?Q?0abM8kPUbpA1JcE2Q106gYHwX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b58a670d-addf-4bfe-879d-08dcf82c886c
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 15:15:33.4231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8kLFzTHOdd/X5pzEl77btVZQIKicTDbFyW2ARG6aEoLtkrMIUOIUYjZNl2G4FCk8DiTkbee4jaMS9y2rM3LsSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9001

Hi Jarkko,

On 10/23/2024 11:21, Shyam Sundar S K wrote:
> The AMD EPYC platform design has DIMMs connected over the I3C bus, with
> each DIMM containing three components: SPD, PMIC, and RCD.
> 
> To access component-specific information within the DIMMs, such as initial
> dynamic address, static address, and provisional ID, ACPI support is
> necessary for the I3C core. This requires adding ACPI binding to the
> dw-i3c-master driver and retrieving slave information from the AMD ASL.
> 
> Currently, the code is closely tied to dt-bindings. This initial set aims
> to decouple some of these bindings by adding the AMD-specific _HID,
> enabling the current driver to support ACPI-enabled x86 systems.
> 
> In this series, support for following features has been added.
> - X86/ACPI support to i3c core
> - Support for SETAASA CCC command
> - Add routines to plugin a SPD device to the i3c bus
> - Workaround for AMD hardware
> - Add dw-i3c-master driver with ACPI bindings
> 
> 

Any feedback on this series, please?

Thanks,
Shyam

> v2:
> ----
>  - Address LKP reports issues
> 
> Shyam Sundar S K (6):
>   i3c: dw: Add support for AMDI0015 ACPI ID
>   i3c: dw: Use IRQF_SHARED flag for dw-i3c-master
>   i3c: master: Add ACPI support to i3c subsystem
>   i3c: master: Add a routine to include the I3C SPD device
>   i3c: master: Add support for SETAASA CCC
>   i3c: dw: Add quirk to address OD/PP timing issue on AMD platform
> 
>  drivers/i3c/internals.h            |   2 +
>  drivers/i3c/master.c               | 157 ++++++++++++++++++++++++++++-
>  drivers/i3c/master/dw-i3c-master.c |  44 +++++++-
>  drivers/i3c/master/dw-i3c-master.h |   1 +
>  include/linux/i3c/ccc.h            |   1 +
>  include/linux/i3c/master.h         |   2 +
>  6 files changed, 205 insertions(+), 2 deletions(-)
> 

