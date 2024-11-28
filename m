Return-Path: <linux-kernel+bounces-424991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C649DBC26
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 19:28:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 364C1281AEB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 18:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE15B1BD9D2;
	Thu, 28 Nov 2024 18:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OXQSWj/t";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GWo/ObRV"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEA7537F8
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 18:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732818474; cv=fail; b=D6t0D/4mVSzV+NaKe+6zYKUV+ODwz844tv4+la7kGFLF8NI8a5KCseHQQiTBRMD2uGg7lTUpAl1aOXzWp5liAEhE+1hP5IlDQNN9FeA/eHb49krAUM8NOBjWdgzpaE7GnlKmUo2GZCw6/3MBXVifsWG5zyCnNkiEwKLnzBtTQt4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732818474; c=relaxed/simple;
	bh=GKqqBHWJCyOxicy7LDGcUG++Xdu72FCUNgSUMgHHUh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nFzyAoFAzufbwHjtV9hvG+VrEPmyXx+fdmpjvlpwRRDQBtaci1sy2VZxW9IWYH9i/n9+TYUvW0Grs9yb0pWZUNN2ZXlQPJVwYNHeIuGYE1S/9CWWrY74LDMaI0l2azsfSlG+rmyu48tlX1TAdUZobNJ9PrM5syQNsTE5ouyLHdY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OXQSWj/t; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GWo/ObRV; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ASELUPk006883;
	Thu, 28 Nov 2024 18:27:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=GKqqBHWJCyOxicy7LDGcUG++Xdu72FCUNgSUMgHHUh0=; b=
	OXQSWj/tfBC7cn44vwBwFuAuyP0EU/ggvlRfyY0idQcE9mguetM6h+7O87Fodfi4
	Hz3CSUBcw7r1lK4y+9pI7ptADMaFGMiyoDaVuF+pHSH5MZyEPIelF7aChMKkILux
	ak4z3p0gcKhaOyXG/8nSK+qqFTw37VVZKACqIQ4Oa5TA0P24IntgCPXQ0yIvNWWy
	Kv/djQGl+AFivqOhYz3ROxzAL+F37e8gcwCiFiSa1DOL+6A5PLXwAtQT1/5gokTc
	DW7Ay36bSZSim64Y9tEsL52y7dAARP9XVAd4wFbSiRMHq3YR3WkTmnIJBH9eOrPB
	TOmItplrLYI94gmruhfDuw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4366xya93d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Nov 2024 18:27:39 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ASFHcMU027440;
	Thu, 28 Nov 2024 18:27:38 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2048.outbound.protection.outlook.com [104.47.70.48])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 436704c0cy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Nov 2024 18:27:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nkUFijR1pgQRy70ywnAl2qzYQXsDnOvtTDJ6ZvaIefEu3DVPtJZUpfZLNWJEKjuusQn4/mDQBhOSvwjNtlZg0jfMGnha9cMISaHimFIiX1hrYpQybtjmkZO8YHNgD9OLRdXUvsHDWiJx91GW9/KF9mJunNkQhEn8ns6OWl4+JwNHJTeKf+qtlooCIX+bzr8AL/eZl8Ka1UeT6Olu6u+Dx3stqtl5ars+f9szf5idC8+SDzW/w5BL9h87FKpyLgiYarbs+rvo5l1QZVWNT8NHfBs+L7Dax+vgIn16JMfaxHZhJZyISxktJ0NW6J0a3YB3S3NwvXDE6A5R6db4g0C5KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GKqqBHWJCyOxicy7LDGcUG++Xdu72FCUNgSUMgHHUh0=;
 b=R4Kws4xzw8X1NgkdzW5eTCSH0re4VUN8IsMdhBF1vguYpHbb70i7Xu6/SVRRyHIj35WOM6chRSomQl9FOfWnMIWOOvgcftokDtZaGFQwDmnX0L3S+PKETbAlfJKAYqV82PqpstS/XvIslbGSFlcJWTt3lyvHxsk3w24v66waOV2pYaaqdVY9fPB1/k5Uqhx1h5j50JzSbstKrUm6xUOmC9zRsm/piPwhiSI4g6babGXqBcmma6tewL+qx37ZEEWiMa80nTbSYFTnmIxO/ybxaswsZAvl4II1ZNh1xtrUnb7pJmrFNvr/mhltFgs3qQ0ATF9v/OLISvGtuuwuxe8SCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GKqqBHWJCyOxicy7LDGcUG++Xdu72FCUNgSUMgHHUh0=;
 b=GWo/ObRVZW3g8AoaA34hkj04ROBsbFeDplIwBY+tRn14zMCb7JSE2EzRR7MyfwWSGx4xPxkzMHdq6I9CGo+TZI2GFfIYFbmrORCys3YbxIVpgXPTx9Z+UXBEc2S0NssXhmU4hkviNu9tsExtxVTzR2IXdRB5dvK0BwUzoJe+FCs=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by DS0PR10MB6870.namprd10.prod.outlook.com (2603:10b6:8:135::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Thu, 28 Nov
 2024 18:27:35 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8207.010; Thu, 28 Nov 2024
 18:27:35 +0000
Date: Thu, 28 Nov 2024 18:27:31 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jann Horn <jannh@google.com>
Cc: Julian Orth <ju.orth@gmail.com>, Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Shuah Khan <shuah@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: reinstate ability to map write-sealed memfd
 mappings read-only
Message-ID: <36882f0d-4a0a-4877-8c42-ea807e4d3f6d@lucifer.local>
References: <cover.1732804776.git.lorenzo.stoakes@oracle.com>
 <99fc35d2c62bd2e05571cf60d9f8b843c56069e0.1732804776.git.lorenzo.stoakes@oracle.com>
 <CAG48ez1OQWsaFGBs_EPz+9C=FwddyKG=r1PMbfDtwHNow2SYOA@mail.gmail.com>
 <8219cfd3-f488-492c-8d4c-26e9f0169e8e@lucifer.local>
 <CAG48ez16vhr_D1o_3tMetCWq3NiGm__PAECyprdePtq40ag1gw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez16vhr_D1o_3tMetCWq3NiGm__PAECyprdePtq40ag1gw@mail.gmail.com>
X-ClientProxiedBy: LO2P265CA0119.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::35) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|DS0PR10MB6870:EE_
X-MS-Office365-Filtering-Correlation-Id: e5f3bfbe-cb4e-4262-9d1f-08dd0fda549d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dUdaa0pZQkFudlRzb2lzajBRSEJyL2R4bVg2SUM2dmN6RWE5NjRHTGE5Uk53?=
 =?utf-8?B?VWJ6cVViVlV4eXdDRGUxcVVYN095bjlJOWZCTHBPWVNmSyt0aTZGdGw1c1ZN?=
 =?utf-8?B?Y2J3Tng3SVdRM3ZUNDMxSjFpNHVreXlwTG5iUlJKRTNldFZGams2ZmdrZ2dU?=
 =?utf-8?B?VTR1ZmlKYlNldlFHWWtYRGUwSXQvQmdQaHhZbW1HcGY1TXNaVXdjbDdqLzhN?=
 =?utf-8?B?bTFGMWV5eUJySzRJY3NxMkdUUjF5Vnl3Y0V6WGRINlkwbmZHZGxzMW4rclcz?=
 =?utf-8?B?SEx0ellEQUZvMGVpdEdsRlUzWDYxaTIwNkZlN0JpbGEzVndmT1BpUmlXS1VJ?=
 =?utf-8?B?My9ydlRmWGNQcXhVKy9namxPVTRWT2ZLUmNOdjBoUzV5cXNtdlQ5bnZTQjhp?=
 =?utf-8?B?a0FFVWc3cEFyV1NUQlRaVmxpNjFweHNiejh2dXErZVVpT3VENlpqOUY2d1li?=
 =?utf-8?B?TjNUenBKYk52bW9EWXhkTUtrNnJsSkZNU2lYYXFYYk85c1dnWTQvd3ZOMjFl?=
 =?utf-8?B?dVBCRCt6bXU2cTBraFZyOTVtWUtCNEtVUUtXeWRVRExkWFI3emRCaUwvR1BU?=
 =?utf-8?B?cnVqSURUTWRYRlZKMGRhUnJ1UlVyNSt5ZU5JczhMdmZFNlc2VkVQZG4yYlpZ?=
 =?utf-8?B?WnVFUDAwME9JdWdvM2NjYjRWNmhXTlFnYWtWeHZwNHF0TTlUcTZUcXExb3J1?=
 =?utf-8?B?MFdTZ3haOG5Xano4VlQyWUVoTjBNMWx3aEsyYzVMcTdFV0IzR1lyTkMxQVFW?=
 =?utf-8?B?NU4rYWRlTkcwR2NGSm9rYWZlZklyMUpPZXhvcDVEZnFaaWd3TVB3cVpVNlZj?=
 =?utf-8?B?bkRXbnBqbGVEKzZNc0RySkhOaXhubUhjeGNpUVBwNnZxVm9JYW9vWUhKV0ZF?=
 =?utf-8?B?OUJjVHNPWUp2cmRBSExBbTk4K1d6ZVA0MUF0eC96WmJETEV5VDRRSXhKMmZL?=
 =?utf-8?B?cmJEbDNuTVhPb0haSWp3d2wyQ3R0U2YraEhkLzZOQnB1ZWwwOU1ibmQ3ZjBk?=
 =?utf-8?B?ZWQ3Ry9aNDJJR3hXakM0N1gyajR6NDl6bEFGdURkK3RqN2hsT1NyVy82eExn?=
 =?utf-8?B?Qit3NnFFUHV6MWZMMmcrMm1TNHZSb1FwWlFMVWw3N0tKQXFhdmdRZnJ5K3VP?=
 =?utf-8?B?dDdoTUdVbGVDU3gzVk94cDZWSnBkS3lwQUN3TVpmb1JiR0ZaM05WclNpVWdY?=
 =?utf-8?B?WC9lRFg0eWhvZUpvRVlERlRoZUlYa2MyenorOXlneVRNWHRJMWxJYTNUb201?=
 =?utf-8?B?Z1hsNE9oS3NQdURBNEJrK21XMVVqNHN3QUp5UGxSdHg5eWwrYmovZ3ZydTl0?=
 =?utf-8?B?YVR1bjFvUlpoelJVRjRKNkwwL2tsYlE2clNqaHU2aXFUazdFWC96U3h1N1VP?=
 =?utf-8?B?d3pES01weEJoUG95S1B4cXhMU0RydWdaWUtmY0h2M3JGVXR0UVlSMklkbjA2?=
 =?utf-8?B?cmVOZGZuSEZmRHczN1BZbEpwcG4rTDR1cTJDVHJTeWtOMklhQ2NPOFZOeFow?=
 =?utf-8?B?UDZBWVhCZ2JMdlZ1bGx5dmJER3NSL2lac2MzdlVqN0dTTUNoa1VqZENxSTR5?=
 =?utf-8?B?ZlJzcWoyYURXSExyYUt3dWNkTm43L0ZVOUtWdzdsMU1UMm5veEFiQytDVzdH?=
 =?utf-8?B?M09BUy9GcC81QWtNcUNGVmx2ejFFZFBQOG5XQ214SGx3aFZISjlkYzh4dnE1?=
 =?utf-8?B?SVdtcWlvSW5kcWl0enFENklVcXFmTW5oVWFtdGVhR0tTZFdDbFMyWUZXU0lq?=
 =?utf-8?B?L08rb2FOYm9LYTNWa3VRamQ3azA4eGlWcTlxSmlqZFhqUUVPc29KUVhyRWJG?=
 =?utf-8?Q?BjpPm3PHwiay9R2W/dkDGrkAcXIi7MGobN2aw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RnJNQzRxWnVBdzdyNU0xakd0czd6ZzM1L1V0b0g0eHRYV2huUzV1c0QwcGxU?=
 =?utf-8?B?N25OTG43MldVUjVGVGowNWlyam1RRTQxU3pxcW50VitBTDFhc3FrT3I2UGhK?=
 =?utf-8?B?bXM2Ym4zK0RrVmhMc3l5ekY2TVI4WkthOFlyZk1FNy9wWVRGUnY0Y3Q1a1pm?=
 =?utf-8?B?c0NqSXp0ZUcwbTlFRjdybzhUTWs5ZEhPcVdqSGtGZ2EvRlk4SU9XRjJKZHJK?=
 =?utf-8?B?VmtJdXBXZEF1ZHEwWkI4aW9JeTBJcUVBTGl1TS8wdzE0cmE5MWxqa2c4RWQr?=
 =?utf-8?B?YjFKU3IwaHNaSkNiMWdKWEYrSXJMYVY3eWYxUGFkdE1HZDFPaGFJdzZLL2Rw?=
 =?utf-8?B?cFJJSFJQNlM3ZDBJTS9hNGlhTlFVanZLMlk4S2pNQWgyMXpSQS9wSGJBbkFE?=
 =?utf-8?B?Zm1JcDE2RXhvSXR3dXVPVDRZMHJWS2IrV205dXFvS0FJaXA3K2tGQ084OFMz?=
 =?utf-8?B?SWRjZURiVGNuQjhMYVp1MEdHdmdRa1NMZVJlaUFPQjA3OXNlRWlUSUtHUExF?=
 =?utf-8?B?bFJ0emwyaGF1dXYvRXh2WnFMWWs0K3dSRElKZUxtbkdqeVh3czQxelV4QlVu?=
 =?utf-8?B?eEFBbHJ0ZVFUUnBBdFJQeEJqeVYzckIrUTBpRlJCdlBEM2VaMGxoTWhMd3lR?=
 =?utf-8?B?b2JqaE9ydTIxb3pnOCtDOFBtaERxRXpKYWo2cjV6MHZpVUJOeElwSGFuVzAy?=
 =?utf-8?B?eXRhTjhqMjBqUmUxeForWG0wWndiVnVJU3g5WW0vRUVsRGR2Wks0czBIc29w?=
 =?utf-8?B?VHlQcVVFTVRDVkQ1ZkNHeXVWNWcwb2pVWUthc2M5RHdLeXIyMGtMbXMzQzRh?=
 =?utf-8?B?eENWTEEwWXczOHI1WVdMaHYzRjNDQXM1bWxHQUZQNVVaYkZZMWlPU0V4Y0dn?=
 =?utf-8?B?a042aE9HVTg1TDhSRmw4UkFlY0JKY0Q1UFpUcTA1d2gvcExBdmZRNWVKd1d6?=
 =?utf-8?B?V3ArM2NoVzlXYU43bEhWY2l6K0ZUVWpQcjJyblQ5U3hVeVUwbmFoZWJ5TFpx?=
 =?utf-8?B?MDhLOUhjeHpUZ240WXNTUHpjWUwrZnVyNDdteUEzNXczRmZiZnQ4TXRCRkhw?=
 =?utf-8?B?MHBESzJiODdFTE9OMHIzS1BOU3E2L0NiN0FWKzB3aVRBYlZtV0p1SXNMZnYw?=
 =?utf-8?B?dnc3THhMR09aRGFSZndjVFRuemtrcVNsZ3Y4TUZCbkN1dEJZZXE3VklwejEy?=
 =?utf-8?B?QXlKNGp1djc2Zmh1Y0N1TkRST0tjR3FDQTE3RzlXdUFMekdldkhXYWtQY0pl?=
 =?utf-8?B?ZjIreVcxZDNsY0htQmRUaW5JNmRWOFVNMTd4cFBNWE5BdlI3UndTSm9ubUV2?=
 =?utf-8?B?ekppQmNtSm1yNkpPMGcrdVBVei9Mb1JTVURXbDRRRUZSRWZGRG0wclJJUXM0?=
 =?utf-8?B?bEpRelRrUWMvdjBDdVFtOFVjcXV2RU9MMGdxTDJhQ0FiVnl2K2ZXdkZKUm5o?=
 =?utf-8?B?L0ZCem5icUtmcGxqNGk5QnZvZEh6VlVqNytxbk1Rb00vSUxTT0hMcXdYYWpz?=
 =?utf-8?B?YXJVaWF3NlFnWllhUWFIbFFRMktsUitFclFBWFVNN0FYWVVjaVhRMUJ1anZy?=
 =?utf-8?B?UjcwZFVabEFWQjNmWUw5emNicVFOU0ZUbmxRVCt2dkZZYkdhelozNVVyYUdx?=
 =?utf-8?B?TzBIekFBRlZwYXZ5SUVoTkdFZUZ1ZEtXRzJvRVJhT0toa202d2pjZnVxM2cv?=
 =?utf-8?B?NEZPTjFSdmk1MWloY2Vvd2wzZzg3bG9sa1hOT0trcFJEUndPM042L1Z1MjQy?=
 =?utf-8?B?bGVTbmx0aFRtSlZOVnpka25VZ2xLeWZYelZlU1ZxVEVrTGFhcXNRSmFwbWZO?=
 =?utf-8?B?YnVUTThNZW1xOUUzYjVJRTI4M0MvdlY0M041SW9tUXdKMXlnYm5TRW0yaW1R?=
 =?utf-8?B?WVNsVXNSc0Y0KzRmTjJpN1JvWlo4cFJqRmEyWSthWEo1cnNVang5eDBhZXJn?=
 =?utf-8?B?dFBxai9HTE5MVStLQkxFRkdmU0RzNmNReHprRHoxRmU4NmpWZkpLeDR3M0lV?=
 =?utf-8?B?Q20vQXpmQjNGM3BIbmd0WkxaNFFYZWhNZkVudTRENDRjQ0liNXVkay9TN0p6?=
 =?utf-8?B?YzN2STQ2cVdoMEI5VnFMYldRUmdQSkRJQUN4Z0lZc2FNaytNMjhGLzBMdG1o?=
 =?utf-8?B?QUxKa3pOVDFtalhzT1FPUElBb0phWml6ZGRiWkhBNnR4RTB5WVV3WU5oWnZS?=
 =?utf-8?B?bFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UI9JGLfwfrxd3e9M6d7oNARyO5QDS+RtUutJYKAuA9z8j8GRETtEw6prRHdbtdQfwBMxe7mt7ZKiz9DEkGfgpnPjx8CAMf3K2vzU4sN8jj10VhlwtXcILinR9umExzJ1EmXKoN69Euox1Dq5aSNri4eCzOb3IOyNUNx0eszlOLkA3dmlR3OZ0JgPFtLTiHAnIAsywSt/OS48TWmg3CNzpIEls4IRS9HvfKa0okL/Mvy4+X8aNRL+D4tfyUHYJ/lj0rCV9rgVQknqNf24Yk0WupvZR2NO8Hf6dHgJbw247b7uVGjWqRd06FU+/1M47BNbt223xVKDhs/3O5OdNSfw/+guBysjeBkejkCzqYXuV5xbmSTf6lsJzl4pyMDx/+QcGDyjH7NirrRX3pgeahmsPB+VF0bU6C73sPvuL0JvumSdX7nTkHXQu1jNMkZ5LlSEVxISXS0SYgqmhFSas/Jl+FS0WXes6uAJ+kJFYATJlAdzM9Krrd5q9T628xQIn7ifosVE2cz+5Tg8Klq7Gt7wn05NAq8c/7tew889NS+XyWnkiLgE1SlN7ZB/XdRhdhhO11tXdISc9P81PJ4UJq3Hbi5E5uyZeu7ZidsmlNnBoa4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5f3bfbe-cb4e-4262-9d1f-08dd0fda549d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2024 18:27:35.5856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yNbt3woBpf74wur38rr91IyjVpA1rt/zLb00p/AboMSvHRv0jWOMv9uuC3MRV6m6E9cQEMmZE1I+53MtyxypsQDCHI9CqqHtIWsS2GvJZLQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6870
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-11-28_17,2024-11-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 suspectscore=0 mlxscore=0 phishscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2411280146
X-Proofpoint-GUID: rLwRObyiRvBxdx_U7z8S5svUdAS_b1Sd
X-Proofpoint-ORIG-GUID: rLwRObyiRvBxdx_U7z8S5svUdAS_b1Sd

On Thu, Nov 28, 2024 at 07:18:20PM +0100, Jann Horn wrote:
> On Thu, Nov 28, 2024 at 7:05 PM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> > On Thu, Nov 28, 2024 at 06:45:46PM +0100, Jann Horn wrote:
> > > On Thu, Nov 28, 2024 at 4:06 PM Lorenzo Stoakes
> > > <lorenzo.stoakes@oracle.com> wrote:
> > > > In commit 158978945f31 ("mm: perform the mapping_map_writable() check after
> > > > call_mmap()") (and preceding changes in the same series) it became possible
> > > > to mmap() F_SEAL_WRITE sealed memfd mappings read-only.
> > > >
> > > > This was previously unnecessarily disallowed, despite the man page
> > > > documentation indicating that it would be, thereby limiting the usefulness
> > > > of F_SEAL_WRITE logic.
> > > >
> > > > We fixed this by adapting logic that existed for the F_SEAL_FUTURE_WRITE
> > > > seal (one which disallows future writes to the memfd) to also be used for
> > > > F_SEAL_WRITE.
> > > >
> > > > For background - the F_SEAL_FUTURE_WRITE seal clears VM_MAYWRITE for a
> > > > read-only mapping to disallow mprotect() from overriding the seal - an
> > > > operation performed by seal_check_write(), invoked from shmem_mmap(), the
> > > > f_op->mmap() hook used by shmem mappings.
> > > >
> > > > By extending this to F_SEAL_WRITE and critically - checking
> > > > mapping_map_writable() to determine if we may map the memfd AFTER we invoke
> > > > shmem_mmap() - the desired logic becomes possible. This is because
> > > > mapping_map_writable() explicitly checks for VM_MAYWRITE, which we will
> > > > have cleared.
> > > >
> > > > Commit 5de195060b2e ("mm: resolve faulty mmap_region() error path
> > > > behaviour") unintentionally undid this logic by moving the
> > > > mapping_map_writable() check before the shmem_mmap() hook is invoked,
> > > > thereby regressing this change.
> > > >
> > > > We reinstate this functionality by moving the check out of shmem_mmap() and
> > > > instead performing it in do_mmap() at the point at which VMA flags are
> > > > being determined, which seems in any case to be a more appropriate place in
> > > > which to make this determination.
> > > >
> > > > In order to achieve this we rework memfd seal logic to allow us access to
> > > > this information using existing logic and eliminate the clearing of
> > > > VM_MAYWRITE from seal_check_write() which we are performing in do_mmap()
> > > > instead.
> > >
> > > If we already check is_readonly_sealed() and strip VM_MAYWRITE in
> > > do_mmap(), without holding any kind of lock or counter on the file
> > > yet, then this check is clearly racy somehow, right? I think we have a
> > > race where we intermittently reject shared-readonly mmap() calls?
> > >
> > > Like:
> > >
> > > process 1: calls mmap(PROT_READ, MAP_PRIVATE), checks is_readonly_sealed()
> > > process 2: adds a F_SEAL_WRITE seal
> > > process 1: enters mmap_region(), is_shared_maywrite() is true,
> > > mapping_map_writable() fails
> >
> > I don't think this matters? Firstly these would have to be threads unless you
> > are going out of your way to transmit the memfd incompletely set up via a socket
> > or something, and then you'd have to be doing it on the assumption that it
> > wouldn't race?
>
> Ah, I guess that's true.
>
> > The whole purpose of this change is to _allow read-only mapping *at all*_. Not
> > to avoid silly races that are the product of somebody doing stupid things.
> >
> > >
> > > But even if we fix that, the same scenario would result in
> > > F_SEAL_WRITE randomly failing depending on the ordering, so it's not
> > > like we can actually do anything particularly sensible if these two
> > > operations race. Taking a step back, read-only shared mappings of
> > > F_SEAL_WRITE-sealed files are just kind of a bad idea because if
> > > someone first creates a read-only shared mapping and *then* tries to
> > > apply F_SEAL_WRITE, that won't work because the existing mapping will
> > > be VM_MAYWRITE.
> >
> > I don't think so?
> >
> > If they try to do that, attempting to apply the seal will fail as write will be
> > disallowed. So there's no risk of overriding the seal.
> >
> > The idea is you establish a buffer, write into it, unmap, write-seal, and now
> > you can mmap() it PROT_READ.
> >
> > Obviously it's not sensible (or really probably sensibly feasible) to try to
> > find every VMA that has it opened VM_READ | VM_MAYWRITE and clear the
> > VM_MAYWRITE, so instead we simply disallow that scenario.
> >
> > But it's totally reasonable to be able to mmap() it readonly afterwards.
> >
> > >
> > > And the manpage is just misleading on interaction with shared mappings
> > > in general, it says "Using the F_ADD_SEALS operation to set the
> > > F_SEAL_WRITE seal fails with EBUSY if any writable, shared mapping
> > > exists" when actually, it more or less fails if any shared mapping
> > > exists at all.
> >
> > No, it's when any writable mapping exists after my changes :) but people
> > might not be quite aware of the distinction between VM_MAYWRITE and
> > VM_WRITE.
>
> To clarify, do you read "writable" as "VM_MAYWRITE|VM_SHARED"?

Yeah. It's a nuanced thing, and I don't _think_ there's any way to mmap without
this so yeah in a way you're right, _except_ that I explicitly make this
possible.

It also protects you from mprotect() later making a F_SEAL_FUTURE_WRITE mapping
mmap()'d PROT_READ from being mprotect()'d PROT_READ | PROT_WRITE.

I really get the feeling that people felt F_SEAL_WRITE didn't work the way
anybody expected, so implemented F_SEAL_FUTURE_WRITE instead, which doesn't use
the address_space atomics mapping_map_writable() et al. use (since it doesn't
have the 'disallow if anything writably mapped now' semantics).

Not being able to mmap() read after applying the F_SEAL_WRITE really limits its
usefulness if that's how you want to access it too.

So this basically is a convenience thing just to let people be able to do that
as well as read()'ing data.

>
> > > @Julian Orth: Did you report this regression because this change
> > > caused issues with existing userspace code?
> > >
> > > > Reported-by: Julian Orth <ju.orth@gmail.com>
> > > > Closes: https://lore.kernel.org/all/CAHijbEUMhvJTN9Xw1GmbM266FXXv=U7s4L_Jem5x3AaPZxrYpQ@mail.gmail.com/
> > > > Fixes: 5de195060b2e ("mm: resolve faulty mmap_region() error path behaviour")
> > > > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> >
> > In any case, we are not discussing my original patch in 6.6 that permitted
> > this behaviour, whether you agree or disagree it was sensible, we have
> > regressed user-visible behaviour, this change restores it.
>
> Hm, yeah, you're right.

Yeah, I mean at the end of the day, unless we explicitly want to just get rid of
this feature here and possibly break userspace (probably very few people
affected to be honest but as Julian demonstrates at least some), we pretty much
have to do this.

I think this implementation is a less awful way of doing it than alternatives.

BTW we do at least fget() the file before we interact with the file object (I
mean mmap would be broken if we didn't), though at no point were we protected
from a racing seal being applied.

In the end, most users will want F_SEAL_FUTURE_WRITE anyway to be honest :)

