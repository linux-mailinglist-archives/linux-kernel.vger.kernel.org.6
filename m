Return-Path: <linux-kernel+bounces-551213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE8BA56968
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 14:52:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 425A216F477
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 13:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B51121ABBD;
	Fri,  7 Mar 2025 13:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="KAgSqy0/"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECAB192589
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 13:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741355535; cv=fail; b=MFspSk9ECp67VMwz20nDbSd9shWnrJCZs9CvAUZ1q7uN7UVIlZQrP0QFqMvavkqdVPlGn5ioTKwSEk2QCxISPOqzOao52gtfNo7skq9M1LxCuEXQKhBxqcGTXoYbzj2UioDRox6MSndpr2CPi4MI1Wd40VEeNF4tLUmhbz2ZePk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741355535; c=relaxed/simple;
	bh=22LK5ENxUj787+9GVbCRFPfk8S+t8vmaW09TJjWvz4Y=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 MIME-Version:Content-Type; b=Oj7EN6Jzpb3epN4Hl0SsohkmbkOgVI7RBOe7uyk3km9cdm82qFh6/wa1MIJPxYxr0ShLzJVOiku80RIzTY2m1YqV9IvJbJFXa6FQZ1IirmTDMfg3IhKAWPTSJbeib5GSveKoD6NWyTt4vHQcqWVRJXc0lGQMcRmk3/d/clxqRYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=fail (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=KAgSqy0/ reason="signature verification failed"; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5279T0Vm021636;
	Fri, 7 Mar 2025 05:51:02 -0800
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 457x0cge7p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Mar 2025 05:51:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FV1+Bru3qoNx8h/SYXOhiUxFOD7tXwKSL27nxibajhi+JGPcwOTio+g7tyHR5nvuymEqNj8rQAcJPRTGEmIDhiVy61rlT6QzbE4qzLhaOtX91jY/b2NQD3kk2H+gYpUT8Slc6dh7nmVLZGRvJyYi1uEX+/+4qfy9wKp64lQPxdUv6zJlGKWiv9OqLDNazh5beZxOjEvGBFrLWX+pZkHJpwC6RpcP0uZqatryl4op4yIb+iEo5wLaYIk7Qq66fPyhi+C5cP9Sn5vB5tI4Oo/l5epu5O78pyMr3/ESTZhKCYaxfNcoa25zbB2MisbnXuBE03UZB8UyRJvLWgSBoLbIsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yyBETQtdmw3l1jLGNfx+oLiMiCMqsCU1u2Q+/8zAswo=;
 b=kmgtolWt17RjAYLl2qhOhaLYLyLI3eOUlZs/tHXr/utjgNyqwS9Rfp1aGPopILVrX17eZW2ypcsqxYs2LJWr87Hd/z8/IKmjqtDp5AToXTJs6dPiLAxjWIwuts3yU2x68OWrW5XCsvek/Qg4+TsvYbbtgkeCNVuR0J/0gGgcMK2H5nj4zzZDGXwxW0YrMCib/2oz11bo8j9j37nJ/FtLvQNDsDime63udAEPbmkREOkK8dRp5q81V4uCU24oUbxI9+PRiA1sX7BRl4XjeB+wJDvJR1uvZDMX/yXt1tFbwz1zztnxEXIX0kD41jVbmEu266US8H8E20B5FuVC9qnaFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yyBETQtdmw3l1jLGNfx+oLiMiCMqsCU1u2Q+/8zAswo=;
 b=KAgSqy0/b0glyUR3XfTnKoG/DD+kAsrIORh44UoFSobahdsvF40ZTiJYRuqBMi0PLrWuJg1FeYwrgxiC74TifUx56etADGA/6tCZ1ab2g67cTk+u4SqNKgvGSuhccwqJxD7rIQrMB0WL1vvS7EzHkH47HMFpc9HM+niYGWm7Mtk=
Received: from MW4PR18MB5084.namprd18.prod.outlook.com (2603:10b6:303:1a7::8)
 by LV3PR18MB6284.namprd18.prod.outlook.com (2603:10b6:408:26f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Fri, 7 Mar
 2025 13:50:58 +0000
Received: from MW4PR18MB5084.namprd18.prod.outlook.com
 ([fe80::1fe2:3c84:eebf:a905]) by MW4PR18MB5084.namprd18.prod.outlook.com
 ([fe80::1fe2:3c84:eebf:a905%5]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 13:50:57 +0000
Message-ID: <5f3171e0-d96e-47ea-92d7-0a3e3e3f8147@marvell.com>
Date: Fri, 7 Mar 2025 19:20:46 +0530
User-Agent: Mozilla Thunderbird
Subject: [PATCH v7 00/49] x86/resctrl: Move the resctrl filesystem code to
 /fs/resctrl
From: Amit Singh Tomar <amitsinght@marvell.com>
To: James Morse <james.morse@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc: Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>, shameerali.kolothum.thodi@huawei.com,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        carl@os.amperecomputing.com, lcherian@marvell.com,
        bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
        baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
        dfustini@baylibre.com, David Hildenbrand <david@redhat.com>,
        Rex Nie <rex.nie@jaguarmicro.com>, Dave Martin <dave.martin@arm.com>,
        Koba Ko <kobak@nvidia.com>,
        Shanker Donthineni <sdonthineni@nvidia.com>, fenghuay@nvidia.com
References: <20250228195913.24895-1-james.morse@arm.com>
 <5436632b-cdc8-4a55-8766-0cc2aec0b807@marvell.com>
Content-Language: en-US
In-Reply-To: <5436632b-cdc8-4a55-8766-0cc2aec0b807@marvell.com>
X-ClientProxiedBy: PN3PR01CA0115.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::14) To MW4PR18MB5084.namprd18.prod.outlook.com
 (2603:10b6:303:1a7::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR18MB5084:EE_|LV3PR18MB6284:EE_
X-MS-Office365-Filtering-Correlation-Id: 69590a50-ac76-489b-cd03-08dd5d7f1627
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aDNXMVVHNkRmMHptNncxTjlQMk1ITFhUZkthMkVaelVyN09xZjJzY1RCL2VZ?=
 =?utf-8?B?bW5lS0R0RThkd2E1akMrckkvNTROVkxIL2oxblJUc2NYanFJTlBuRUtyeHhS?=
 =?utf-8?B?TTRLTUhMc1pKSzZITmJUNFh2QzJjUWNwc2pXZ3lrUi9UWit2MzJtTVk3dlA4?=
 =?utf-8?B?azVzNnVjK0VrVjdtNVZOYTN6aG9pK010MXJ1alc3NytFcVhVK04vNlB2WEJU?=
 =?utf-8?B?VHU2dDdTNFBnQXN3TmcvanRubnJhdmMyWGE5MUU4TCtwMlN2TTRYNXJOMExy?=
 =?utf-8?B?VThkYjA5TDBxYkFhT1R1N3B1Vlc4UG56eU1TUlRUVVo0M25QMEtFUmtPZVll?=
 =?utf-8?B?WU9GR2d2eGZyWHRRYWFuTkhFeHFSekVnVFlIRjM1L1hOcHJvaDZaTFdwai9h?=
 =?utf-8?B?Q2lHQUdwRjFibmw1SDhYcEZqanlFOE4yc2hkck9SKzl4NnV0azl2OHVqNUdY?=
 =?utf-8?B?cmptNHI4bEl2VExtc3dGVlpUOVptaFVyK2diSmw4akd3ai9lcFVUbGF6RHR0?=
 =?utf-8?B?bUtpRjY5RW1PUlpSQ3JzYnU1S09MeXJHMVNzU0VqaWdHdnpudEVVUGhJZm9a?=
 =?utf-8?B?SnE4MnB1Y0JmZklPRy9VaDhaMGpCbnlvOVdQOHhhZVZtKzJ0Wk5PSDhjK2ps?=
 =?utf-8?B?UXN0UXBLZUJUOE1PcER3NzhzYjBaN3VLNkhwUk52Y2xmM2hzNmZHck8zS1VJ?=
 =?utf-8?B?aVNkSVBJTDNpQXc3QmR1ZStNdjhyV2tYZmdPa1Q2aTNCQ1cvVFNzckZRVzI1?=
 =?utf-8?B?MVpvcHNQYUVTRjlCZWEwd3pNNi9CNkxPcGlQMVJUUGRHbUg3cUJpRnY2d1Nz?=
 =?utf-8?B?S0RRQ0JhdFgySzVxWEdaYkVkSnd5aG1QNGZoSHgzSm5ZUmdMZFNHRTIweVpC?=
 =?utf-8?B?WFI1RDM0UXpnU3V5RGlLcEc5ellzUUlJdnlweE56RUxxL0NaQi9adzloZmJ2?=
 =?utf-8?B?YzYxOVdrRXVDRmNZUlBVaE1RU3ltUDVSS2J6TUkrRVlUUUpsckRWOEphdDY0?=
 =?utf-8?B?T3R0L0xKMWw1S01XS0ViNldTSU5aTVd6Yy9mOUtNK2VLNFpRakdZM3ozbjBG?=
 =?utf-8?B?QjVidnloeVVmSEZNSGQwZjkvUzVIdDlKSWJBUHZ5K0NhSDRXZk9PeWEvVzBB?=
 =?utf-8?B?WFNZcHZKYlpPamE5SU1sUmNWOFB4OHBZdTZoMm9xQ3I0YkN2OHRjTFZQZ2Iz?=
 =?utf-8?B?OCtIV1NVbjlGVnR6b3pBbFMyZWxoV1BYS0NPcHRwSzhOcnFxWXRTdCs1RFo4?=
 =?utf-8?B?SHRUSW9YODlQaXBiY2xtMlJadyswS0hWTnJEVTg2aUpqUytlNGttOWVCVDhP?=
 =?utf-8?B?MUphZjdCdlJPUlkzRUNIVWFVL3hoSmRsUHVuZlE0VjBsc040Q1JkeHN1Mjl4?=
 =?utf-8?B?MmhWME56U1k4NWZxMDVlMnBwMVh1TnBhcTAvbS9DL25lenBzWHJzaWpmTkdo?=
 =?utf-8?B?dEtWaGlEVTgvT281MzNmZCtjMzB4Zk9Pek9VdkFaUTV1dENRejFPbDV2NStR?=
 =?utf-8?B?Q1dFbUNlQmdyNkx3OU1URE1LSUtyVEt1cVk3YUVFMllRcDJRWGIxNVZPWGdK?=
 =?utf-8?B?YWs5NnNGdkswSlBUY1AyZ09oNkMrMENZbHN2d0lwYkxIanE0NXBIbmo4bEcv?=
 =?utf-8?B?N0k5cGNPQlVwUmxhM1ZWYWpjbmlxdmVYbWpDK0FGUFhjOG54aXBXRFROd0Y1?=
 =?utf-8?B?eE05bFBzTFVYdnkzTmE2VEErSVZrZmRmaTVrSUdQLzY2dnFyUEY4RVhPTmlC?=
 =?utf-8?B?OFFxZUo0eDBGMHFpLysrNTFrZ1Zob1dzcTNZY3lzaU9RMHRHZkF6ZlVIZ3Jv?=
 =?utf-8?B?YVIreWZER29YQUJMMVpmZ1g0bXVkVEkzS09NRGNDUlJpQ0ZZTS9hYit0OTQ0?=
 =?utf-8?B?clFqUXRkWTc4dlFRaEpFZWY3cUs5ZEY4UnZuSnRjMUVEaEE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR18MB5084.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(13003099007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?LzRKY21sTEYwQ3diVWx1MXZta2k0aitxamc0VzJ1QmU5dlc0cEJtY1J3TnEv?=
 =?utf-8?B?Tjl0NFYyclhxdU9oZiswdW9uU0tMMnVYcXBUM25mek5QaVA1NUwzWXFlZjdF?=
 =?utf-8?B?OFFEc2dzN21MM2FrTktZaEs3RCt6UFN2OUlSbkZPcEJJM2dKSVpEeUlWVGVM?=
 =?utf-8?B?bXlCWGhtM01TS0hjM1pHMWxSVVJFLyt3S09QQXdscGtXdWJOMVVQRzBPcitx?=
 =?utf-8?B?WWhGR1JPMXlwZDg0RXkvNzFEc2YyOTVmNFdRZmtuSjZ1eXNzZkVPUE16by9S?=
 =?utf-8?B?OGh0d1I3NVluNWFSUndhUkNucml5T1ZmWXRMeW9IRC8zenM3cDdVRkxUQ2xv?=
 =?utf-8?B?d0IyUkRiUWNoR0pxbmgwQlhlR1VkbjZoQVVpS1VvTDNpQThJdVl3Q2NKZ0d6?=
 =?utf-8?B?ZEF0a1dVKzdPeHllMEZmRnYyZ1Z3UHh5ODdaUWkyeUxGK0ZlajJwNmFaOUl5?=
 =?utf-8?B?M3cydFZQT0Z5NE1sVDQyZUtxV1gvR1FkcGN2L0dneTYxM3haUmlYSGJmVHcx?=
 =?utf-8?B?SXorRHdBYVB6UFp5M3VDWUZudVBHbVhQQ1l2akRJLzhWbFUrNmNISlhFbWpv?=
 =?utf-8?B?bmpxa04zWTdQbkt0bzNWejIvOUpLRlQyMi9rT1NNM2NkUHEyWnNjc1NSUllG?=
 =?utf-8?B?S0dhVitjdU9nZTBoaG9ndUpabUxITU9CeWthUHFPS1lPSDREbDRSYUNGbVg0?=
 =?utf-8?B?cTcvOEFpd28yRlhDb3dOL0NQSXliMGk0WmQremtQVmhTcTFMeUYyT1BZRHBH?=
 =?utf-8?B?aDN2U2Zma3BROWxlcGtjdnhpMGJnMm5TeEI5LzFsd1BHZHBUcldrenhJN2pk?=
 =?utf-8?B?OVRGWkIzdyszbjlyQlpidzdydmc1akREbnFDZ2l1M0QzbHdvU1U2NkxCTFVD?=
 =?utf-8?B?Z3pZYnloSE9idmZKaURWc2x3OFZjcCtJNmUvQnlpRzMyRFRBOEhlRXBZNGc2?=
 =?utf-8?B?bFJIREJibVphVjF1T2RSSXZqb2NFYmJrR0c4MzZyNk8veFpBQnNyTElKMlNQ?=
 =?utf-8?B?UGtnU1J1blc0bUVnQ3JUaTE4Qnpvb0RMVlF6bGdQNDFtV1FMM0poVms2TXZY?=
 =?utf-8?B?aVVTZGRHT0o2ek8xdzl6NjgvM3NlM3FoOExYaFNoSkowM0NOZjR6cEgwaU90?=
 =?utf-8?B?c3YrZ2d6VExvb1hXY0wzdWFoRnorTnluRnoyb3AwSXVGVXZjZEtkMnpQa05X?=
 =?utf-8?B?T0ZRZ0VqMGhpeU1hZUFnY1dvbnFoZmQ1UjU5VVhtUjdnaW1iSlBzZWJOZTMy?=
 =?utf-8?B?L1MzaW5qM3l5SUJQejR4TXRFNVc2WWF5b0p5UzJ2OHlCdDJuUkR2MDBtSU9r?=
 =?utf-8?B?V1owMFlrV0JVaXduWmNPNG5jZTRWamFzZVlBZDNZYlRvOThHdkVOdmtGT255?=
 =?utf-8?B?dnk1TjQrUWlPUzFBVDBYNytqUzRKNkovcFdicWxQamJqdnlUOUlMS2Q5SDRj?=
 =?utf-8?B?MmQ0V1Z5cWFLdWUyelArSXEwaUt5dHRPcmFQS2FKOEw5STdKQnAzL09hYSs2?=
 =?utf-8?B?Um5QVE9qdU1QaUo0NUZzOGtxK0ZGYzIvblFlWlFyc2FzWTA0enZaNCtuV3Jo?=
 =?utf-8?B?M0NVNVFFRFgwd0w3K3JBYUpEdFlIdzFPRURqUmdDK3pPbEVvcnNUNE9lekN1?=
 =?utf-8?B?bzgreXVVS1BIMjR5eThnUmxZS1Z4Uy9LQVVlcFNSVlNzN2dLeGpReitVRUJF?=
 =?utf-8?B?Sm5vRVoxcW5TaE1abiszUlFSaXVkYlROMUtxVXA0dG1jdjlrYjl4UnpZMmhI?=
 =?utf-8?B?NHZLNkhjTm4yVHBGQ0RPd3YzZFpkWDhpaVBnRVNOUnU4d3RCQkFlWWJyT0dy?=
 =?utf-8?B?UWhjejdDV0RhVGN5eUdYcXVENTQvRTdNY21vQ3doSWltcUloTW5NdVZFVGFL?=
 =?utf-8?B?THVrREFRdXBRZHpnMFBsenNsSnA4WTUzdklUZHZTVjdTazJheTFwcTlsUENM?=
 =?utf-8?B?N2Vyb2s5NjRqMWZ1MDFNVzJBc2dVOUhRbUJ6S29COWZrQndLV2ZPOVQ1ZFBY?=
 =?utf-8?B?M0R3bmx6SVpvdVU4UGZCVU9pR2xxSEw2bzhvRDJCUzAyd2MvYjNhVURLcmY1?=
 =?utf-8?B?YWtUT2hCNE13aVBTL09kMVRtTTVBNjVxQjB1ZFhlcW1lUTlpTm5nQzNmdlA1?=
 =?utf-8?Q?PM0eWEcw6z2B5t94PRKafTm2N?=
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69590a50-ac76-489b-cd03-08dd5d7f1627
X-MS-Exchange-CrossTenant-AuthSource: MW4PR18MB5084.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 13:50:57.4256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1mQCnoQAOOChQb7avCE87+dk/dgrNhNhhh6jhXExTGjJCvSAxHQizKusqwAjwP7m7i6pFkOzVgAQ9AIyPGrSaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR18MB6284
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: 8CAdP33g4MIKxDlM50Xf8_969W-l29l8
X-Proofpoint-ORIG-GUID: 8CAdP33g4MIKxDlM50Xf8_969W-l29l8
X-Authority-Analysis: v=2.4 cv=PKr1+eqC c=1 sm=1 tr=0 ts=67caf9c5 cx=c_pps a=gIIqiywzzXYl0XjYY6oQCA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Vs1iUdzkB0EA:10 a=-AAbraWEqlQA:10 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=RpNjiQI2AAAA:8 a=M5GUcnROAAAA:8 a=zMTwtOGfznqj2wOGA1IA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=a-qgeE7W1pNrGK8U0ZQC:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-07_05,2025-03-06_04,2024-11-22_01


On 3/7/2025 3:57 PM, Amit Singh Tomar wrote:
> Hi James,
>
> Changes since v6?:
>
>> =C2=A0 * All the excitement is in patch 37, turns out there are two=20
>> rmdir() paths
>> =C2=A0=C2=A0=C2=A0 that don't join up.
>> The last eight patches are new:
>> =C2=A0 * The python script has been replaced with the patch that it=20
>> generates, see
>> =C2=A0=C2=A0=C2=A0 the bare branch below if you want to regenerate it.
>> =C2=A0 * There have been comments on the followup to the generated patch=
,=20
>> those are
>> =C2=A0=C2=A0=C2=A0 included here - I suggest they be squashed into the g=
enerated patch.
>> =C2=A0 * This version includes some checkpatch linting from Dave.
>>
>> ---
>> This series renames functions and moves code around. With the
>> exception of invalid configurations for the configurable-events,=20
>> there should
>> be no changes in behaviour caused by this series. It is now possible for
>> throttle_mode to report 'undefined', but no known platform will do this.
>>
>> The driving pattern is to make things like struct rdtgroup private to=20
>> resctrl.
>> Features like pseudo-lock aren't going to work on arm64, the ability=20
>> to disable
>> it at compile time is added.
>>
>> After this, I can start posting the MPAM driver to make use of=20
>> resctrl on arm64.
>> (What's MPAM? See the cover letter of the first series. [1])
>>
>> This series is based on v6.14-rc3 and can be retrieved from:
>> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__git.kernel.org_pu=
b_scm_linux_kernel_git_morse_linux.git&d=3DDwIDAg&c=3DnKjWec2b6R0mOyPaz7xtf=
Q&r=3DV_GK7jRuCHDErm6txmgDK1-MbUihtnSQ3gPgB-A-JKU&m=3DnuwqirfPj-0yJqyDZfy25=
skE_NJ-fYFcygpI04RUICnSUBYHutdqE6Gakd1Z3I8H&s=3D34Q-cAJD41LWUgU21FvoSkXHOM-=
uSrOs2a1vEwaxrNE&e=3D=20
>> <https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__git.kernel.org_p=
ub_scm_linux_kernel_git_morse_linux.git&d=3DDwIDAg&c=3DnKjWec2b6R0mOyPaz7xt=
fQ&r=3DV_GK7jRuCHDErm6txmgDK1-MbUihtnSQ3gPgB-A-JKU&m=3DnuwqirfPj-0yJqyDZfy2=
5skE_NJ-fYFcygpI04RUICnSUBYHutdqE6Gakd1Z3I8H&s=3D34Q-cAJD41LWUgU21FvoSkXHOM=
-uSrOs2a1vEwaxrNE&e=3D>=20
>> mpam/move_to_fs/v7
>> or for those who want to regnerate the patch that moves all the code:
>
> After rebasing mpam/snapshot/v6.14-rc1 on top of this series, Tested a=20
> few MPAM controls, including Cache Portion Partitioning and Memory=20
> Bandwidth Partitioning, on Marvell CN10K ARM64 platform, and It looks=20
> good.
>
> For this patch-set:
> Tested-by: amitsinght@marvell.com
Realized I used an incorrect format for the Tested-by tag, correcting it now

Tested-by: Amit Singh Tomar <amitsinght@marvell.com>

>
>> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__git.kernel.org_pu=
b_scm_linux_kernel_git_morse_linux.git&d=3DDwIDAg&c=3DnKjWec2b6R0mOyPaz7xtf=
Q&r=3DV_GK7jRuCHDErm6txmgDK1-MbUihtnSQ3gPgB-A-JKU&m=3DnuwqirfPj-0yJqyDZfy25=
skE_NJ-fYFcygpI04RUICnSUBYHutdqE6Gakd1Z3I8H&s=3D34Q-cAJD41LWUgU21FvoSkXHOM-=
uSrOs2a1vEwaxrNE&e=3D=20
>> <https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__git.kernel.org_p=
ub_scm_linux_kernel_git_morse_linux.git&d=3DDwIDAg&c=3DnKjWec2b6R0mOyPaz7xt=
fQ&r=3DV_GK7jRuCHDErm6txmgDK1-MbUihtnSQ3gPgB-A-JKU&m=3DnuwqirfPj-0yJqyDZfy2=
5skE_NJ-fYFcygpI04RUICnSUBYHutdqE6Gakd1Z3I8H&s=3D34Q-cAJD41LWUgU21FvoSkXHOM=
-uSrOs2a1vEwaxrNE&e=3D>=20
>> mpam/move_to_fs/v7_bare
>>
>>
>> As ever - bugs welcome,
>> Thanks,
>>
>> James
>>
>> [v6]https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lore.kernel.o=
rg_lkml_20250207181823.6378-2D1-2Djames.morse-40arm.com_&d=3DDwIDAg&c=3DnKj=
Wec2b6R0mOyPaz7xtfQ&r=3DV_GK7jRuCHDErm6txmgDK1-MbUihtnSQ3gPgB-A-JKU&m=3Dnuw=
qirfPj-0yJqyDZfy25skE_NJ-fYFcygpI04RUICnSUBYHutdqE6Gakd1Z3I8H&s=3DGiw7Cw-bC=
KcY06OE4h_CYGNmKoeW3Rnf9Ph433fTflg&e=3D=20
>> <https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lore.kernel.org_=
lkml_20250207181823.6378-2D1-2Djames.morse-40arm.com_&d=3DDwIDAg&c=3DnKjWec=
2b6R0mOyPaz7xtfQ&r=3DV_GK7jRuCHDErm6txmgDK1-MbUihtnSQ3gPgB-A-JKU&m=3Dnuwqir=
fPj-0yJqyDZfy25skE_NJ-fYFcygpI04RUICnSUBYHutdqE6Gakd1Z3I8H&s=3DGiw7Cw-bCKcY=
06OE4h_CYGNmKoeW3Rnf9Ph433fTflg&e=3D>=20
>>
>> [v5]https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lore.kernel.o=
rg_r_20241004180347.19985-2D1-2Djames.morse-40arm.com&d=3DDwIDAg&c=3DnKjWec=
2b6R0mOyPaz7xtfQ&r=3DV_GK7jRuCHDErm6txmgDK1-MbUihtnSQ3gPgB-A-JKU&m=3Dnuwqir=
fPj-0yJqyDZfy25skE_NJ-fYFcygpI04RUICnSUBYHutdqE6Gakd1Z3I8H&s=3DNuPo6XsrzJWg=
oWgnhpf5PxXdFEozS_Zgk_XBTnhAn6k&e=3D=20
>> <https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lore.kernel.org_=
r_20241004180347.19985-2D1-2Djames.morse-40arm.com&d=3DDwIDAg&c=3DnKjWec2b6=
R0mOyPaz7xtfQ&r=3DV_GK7jRuCHDErm6txmgDK1-MbUihtnSQ3gPgB-A-JKU&m=3DnuwqirfPj=
-0yJqyDZfy25skE_NJ-fYFcygpI04RUICnSUBYHutdqE6Gakd1Z3I8H&s=3DNuPo6XsrzJWgoWg=
nhpf5PxXdFEozS_Zgk_XBTnhAn6k&e=3D>=20
>>
>> [v4]https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lore.kernel.o=
rg_all_20240802172853.22529-2D1-2Djames.morse-40arm.com_&d=3DDwIDAg&c=3DnKj=
Wec2b6R0mOyPaz7xtfQ&r=3DV_GK7jRuCHDErm6txmgDK1-MbUihtnSQ3gPgB-A-JKU&m=3Dnuw=
qirfPj-0yJqyDZfy25skE_NJ-fYFcygpI04RUICnSUBYHutdqE6Gakd1Z3I8H&s=3Dx0enrBNor=
LUBSyhg_SOJl9itXA4Ht_65SifVAOpMEO4&e=3D=20
>> <https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lore.kernel.org_=
all_20240802172853.22529-2D1-2Djames.morse-40arm.com_&d=3DDwIDAg&c=3DnKjWec=
2b6R0mOyPaz7xtfQ&r=3DV_GK7jRuCHDErm6txmgDK1-MbUihtnSQ3gPgB-A-JKU&m=3Dnuwqir=
fPj-0yJqyDZfy25skE_NJ-fYFcygpI04RUICnSUBYHutdqE6Gakd1Z3I8H&s=3Dx0enrBNorLUB=
Syhg_SOJl9itXA4Ht_65SifVAOpMEO4&e=3D>=20
>>
>> [v3]https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lore.kernel.o=
rg_r_20240614150033.10454-2D1-2Djames.morse-40arm.com&d=3DDwIDAg&c=3DnKjWec=
2b6R0mOyPaz7xtfQ&r=3DV_GK7jRuCHDErm6txmgDK1-MbUihtnSQ3gPgB-A-JKU&m=3Dnuwqir=
fPj-0yJqyDZfy25skE_NJ-fYFcygpI04RUICnSUBYHutdqE6Gakd1Z3I8H&s=3DFPG_ZTHC69sP=
w7sz4QOvpKZ76X7VQSTuO2yN67LY4VI&e=3D=20
>> <https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lore.kernel.org_=
r_20240614150033.10454-2D1-2Djames.morse-40arm.com&d=3DDwIDAg&c=3DnKjWec2b6=
R0mOyPaz7xtfQ&r=3DV_GK7jRuCHDErm6txmgDK1-MbUihtnSQ3gPgB-A-JKU&m=3DnuwqirfPj=
-0yJqyDZfy25skE_NJ-fYFcygpI04RUICnSUBYHutdqE6Gakd1Z3I8H&s=3DFPG_ZTHC69sPw7s=
z4QOvpKZ76X7VQSTuO2yN67LY4VI&e=3D>=20
>>
>> [v2]https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lore.kernel.o=
rg_r_20240426150537.8094-2D1-2DDave.Martin-40arm.com&d=3DDwIDAg&c=3DnKjWec2=
b6R0mOyPaz7xtfQ&r=3DV_GK7jRuCHDErm6txmgDK1-MbUihtnSQ3gPgB-A-JKU&m=3Dnuwqirf=
Pj-0yJqyDZfy25skE_NJ-fYFcygpI04RUICnSUBYHutdqE6Gakd1Z3I8H&s=3DC--gCozXx-zNw=
x631Snz1h6SShLrm546dr0_ISKSC9A&e=3D=20
>> <https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lore.kernel.org_=
r_20240426150537.8094-2D1-2DDave.Martin-40arm.com&d=3DDwIDAg&c=3DnKjWec2b6R=
0mOyPaz7xtfQ&r=3DV_GK7jRuCHDErm6txmgDK1-MbUihtnSQ3gPgB-A-JKU&m=3DnuwqirfPj-=
0yJqyDZfy25skE_NJ-fYFcygpI04RUICnSUBYHutdqE6Gakd1Z3I8H&s=3DC--gCozXx-zNwx63=
1Snz1h6SShLrm546dr0_ISKSC9A&e=3D>=20
>>
>> [v1]https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lore.kernel.o=
rg_r_20240321165106.31602-2D1-2Djames.morse-40arm.com&d=3DDwIDAg&c=3DnKjWec=
2b6R0mOyPaz7xtfQ&r=3DV_GK7jRuCHDErm6txmgDK1-MbUihtnSQ3gPgB-A-JKU&m=3Dnuwqir=
fPj-0yJqyDZfy25skE_NJ-fYFcygpI04RUICnSUBYHutdqE6Gakd1Z3I8H&s=3D0PJ7kJsoRhwO=
qCcYwUYrJwbRM9zTssWuhqkgaqXdPNY&e=3D=20
>> <https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lore.kernel.org_=
r_20240321165106.31602-2D1-2Djames.morse-40arm.com&d=3DDwIDAg&c=3DnKjWec2b6=
R0mOyPaz7xtfQ&r=3DV_GK7jRuCHDErm6txmgDK1-MbUihtnSQ3gPgB-A-JKU&m=3DnuwqirfPj=
-0yJqyDZfy25skE_NJ-fYFcygpI04RUICnSUBYHutdqE6Gakd1Z3I8H&s=3D0PJ7kJsoRhwOqCc=
YwUYrJwbRM9zTssWuhqkgaqXdPNY&e=3D>=20
>>
>> [1]https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lore.kernel.or=
g_lkml_20201030161120.227225-2D1-2Djames.morse-40arm.com_&d=3DDwIDAg&c=3DnK=
jWec2b6R0mOyPaz7xtfQ&r=3DV_GK7jRuCHDErm6txmgDK1-MbUihtnSQ3gPgB-A-JKU&m=3Dnu=
wqirfPj-0yJqyDZfy25skE_NJ-fYFcygpI04RUICnSUBYHutdqE6Gakd1Z3I8H&s=3DsYrXz5z6=
dOOGmy5Xjm0lsmdUCAN25SnhDjyq_hUSYi4&e=3D=20
>> <https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lore.kernel.org_=
lkml_20201030161120.227225-2D1-2Djames.morse-40arm.com_&d=3DDwIDAg&c=3DnKjW=
ec2b6R0mOyPaz7xtfQ&r=3DV_GK7jRuCHDErm6txmgDK1-MbUihtnSQ3gPgB-A-JKU&m=3Dnuwq=
irfPj-0yJqyDZfy25skE_NJ-fYFcygpI04RUICnSUBYHutdqE6Gakd1Z3I8H&s=3DsYrXz5z6dO=
OGmy5Xjm0lsmdUCAN25SnhDjyq_hUSYi4&e=3D>=20
>>
>>
>> Amit Singh Tomar (1):
>> =C2=A0=C2=A0 x86/resctrl: Remove the limit on the number of CLOSID
>>
>> Dave Martin (3):
>> =C2=A0=C2=A0 x86/resctrl: Squelch whitespace anomalies in resctrl core c=
ode
>> =C2=A0=C2=A0 x86/resctrl: Prefer alloc(sizeof(*foo)) idiom in=20
>> rdt_init_fs_context()
>> =C2=A0=C2=A0 x86/resctrl: Relax some asm #includes
>>
>> James Morse (45):
>> =C2=A0=C2=A0 x86/resctrl: Fix allocation of cleanest CLOSID on platforms=
 with no
>> =C2=A0=C2=A0=C2=A0=C2=A0 monitors
>> =C2=A0=C2=A0 x86/resctrl: Add a helper to avoid reaching into the arch c=
ode
>> =C2=A0=C2=A0=C2=A0=C2=A0 resource list
>> =C2=A0=C2=A0 x86/resctrl: Remove fflags from struct rdt_resource
>> =C2=A0=C2=A0 x86/resctrl: Use schema type to determine how to parse sche=
ma values
>> =C2=A0=C2=A0 x86/resctrl: Use schema type to determine the schema format=
 string
>> =C2=A0=C2=A0 x86/resctrl: Remove data_width and the tabular format
>> =C2=A0=C2=A0 x86/resctrl: Add max_bw to struct resctrl_membw
>> =C2=A0=C2=A0 x86/resctrl: Generate default_ctrl instead of sharing it
>> =C2=A0=C2=A0 x86/resctrl: Add helper for setting CPU default properties
>> =C2=A0=C2=A0 x86/resctrl: Remove rdtgroup from update_cpu_closid_rmid()
>> =C2=A0=C2=A0 x86/resctrl: Expose resctrl fs's init function to the rest =
of the
>> =C2=A0=C2=A0=C2=A0=C2=A0 kernel
>> =C2=A0=C2=A0 x86/resctrl: Move rdt_find_domain() to be visible to arch a=
nd fs code
>> =C2=A0=C2=A0 x86/resctrl: Move resctrl types to a separate header
>> =C2=A0=C2=A0 x86/resctrl: Add an arch helper to reset one resource
>> =C2=A0=C2=A0 x86/resctrl: Move monitor exit work to a resctrl exit call
>> =C2=A0=C2=A0 x86/resctrl: Move monitor init work to a resctrl init call
>> =C2=A0=C2=A0 x86/resctrl: Rewrite and move the for_each_*_rdt_resource()=
 walkers
>> =C2=A0=C2=A0 x86/resctrl: Move the is_mbm_*_enabled() helpers to asm/res=
ctrl.h
>> =C2=A0=C2=A0 x86/resctrl: Add resctrl_arch_is_evt_configurable() to abst=
ract BMEC
>> =C2=A0=C2=A0 x86/resctrl: Change mon_event_config_{read,write}() to be a=
rch=20
>> helpers
>> =C2=A0=C2=A0 x86/resctrl: Move mba_mbps_default_event init to filesystem=
 code
>> =C2=A0=C2=A0 x86/resctrl: Move mbm_cfg_mask to struct rdt_resource
>> =C2=A0=C2=A0 x86/resctrl: Add resctrl_arch_ prefix to pseudo lock functi=
ons
>> =C2=A0=C2=A0 x86/resctrl: Allow an architecture to disable pseudo lock
>> =C2=A0=C2=A0 x86/resctrl: Make prefetch_disable_bits belong to the arch =
code
>> =C2=A0=C2=A0 x86/resctrl: Make resctrl_arch_pseudo_lock_fn() take a plr
>> =C2=A0=C2=A0 x86/resctrl: Move RFTYPE flags to be managed by resctrl
>> =C2=A0=C2=A0 x86/resctrl: Handle throttle_mode for SMBA resources
>> =C2=A0=C2=A0 x86/resctrl: Move get_config_index() to a header
>> =C2=A0=C2=A0 x86/resctrl: Move get_{mon,ctrl}_domain_from_cpu() to live =
with their
>> =C2=A0=C2=A0=C2=A0=C2=A0 callers
>> =C2=A0=C2=A0 x86/resctrl: Rename resctrl_sched_in() to begin with "resct=
rl_arch_"
>> =C2=A0=C2=A0 x86/resctrl: resctrl_exit() teardown resctrl but leave the =
mount=20
>> point
>> =C2=A0=C2=A0 x86/resctrl: Drop __init/__exit on assorted symbols
>> =C2=A0=C2=A0 x86/resctrl: Move is_mba_sc() out of core.c
>> =C2=A0=C2=A0 x86/resctrl: Add end-marker to the resctrl_event_id enum
>> =C2=A0=C2=A0 x86/resctrl: Expand the width of dom_id by replacing mon_da=
ta_bits
>> =C2=A0=C2=A0 x86/resctrl: Remove a newline to avoid confusing the code m=
ove script
>> =C2=A0=C2=A0 x86/resctrl: Split trace.h
>> =C2=A0=C2=A0 fs/resctrl: Add boiler plate for external resctrl code
>> =C2=A0=C2=A0 x86/resctrl: Move the filesystem bits to headers visible to=
=20
>> fs/resctrl
>> =C2=A0=C2=A0 x86,fs/resctrl: Move the resctrl filesystem code to live in
>> =C2=A0=C2=A0=C2=A0=C2=A0 /fs/resctrl
>> =C2=A0=C2=A0 x86,fs/resctrl: Remove duplicated trace header files
>> =C2=A0=C2=A0 fs/resctrl: Remove unnecessary includes
>> =C2=A0=C2=A0 fs/resctrl: Change internal.h's header guard macros
>> =C2=A0=C2=A0 x86,fs/resctrl: Move resctrl.rst to live under
>> =C2=A0=C2=A0=C2=A0=C2=A0 Documentation/filesystems
>>
>> =C2=A0 Documentation/arch/x86/index.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 1 -
>> =C2=A0 Documentation/filesystems/index.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 1 +
>> =C2=A0 .../{arch/x86 =3D> filesystems}/resctrl.rst=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0=C2=A0 0
>> =C2=A0 MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0=C2=A0=C2=A0 4 +-
>> =C2=A0 arch/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0=C2=A0 8 +
>> =C2=A0 arch/x86/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 6 +-
>> =C2=A0 arch/x86/include/asm/resctrl.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 43 =
+-
>> =C2=A0 arch/x86/kernel/cpu/resctrl/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 8 +-
>> =C2=A0 arch/x86/kernel/cpu/resctrl/core.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 214 +-
>> =C2=A0 arch/x86/kernel/cpu/resctrl/ctrlmondata.c=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0 606 +--
>> =C2=A0 arch/x86/kernel/cpu/resctrl/internal.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 504 +-
>> =C2=A0 arch/x86/kernel/cpu/resctrl/monitor.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 863 +---
>> =C2=A0 arch/x86/kernel/cpu/resctrl/pseudo_lock.c=C2=A0=C2=A0=C2=A0=C2=A0=
 | 1120 +----
>> =C2=A0 .../resctrl/{trace.h =3D> pseudo_lock_trace.h}=C2=A0 |=C2=A0=C2=
=A0 26 +-
>> =C2=A0 arch/x86/kernel/cpu/resctrl/rdtgroup.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 4031 +--------------
>> =C2=A0 arch/x86/kernel/process_32.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
=C2=A0=C2=A0 2 +-
>> =C2=A0 arch/x86/kernel/process_64.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
=C2=A0=C2=A0 2 +-
>> =C2=A0 fs/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0=C2=A0=C2=A0 1 +
>> =C2=A0 fs/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0=C2=A0=C2=A0 1 +
>> =C2=A0 fs/resctrl/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 39 +
>> =C2=A0 fs/resctrl/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 6 +
>> =C2=A0 fs/resctrl/ctrlmondata.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 660 +++
>> =C2=A0 fs/resctrl/internal.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 435 ++
>> =C2=A0 fs/resctrl/monitor.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 933 ++++
>> =C2=A0 fs/resctrl/monitor_trace.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0=C2=A0 33 +
>> =C2=A0 fs/resctrl/pseudo_lock.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 1104 +++++
>> =C2=A0 fs/resctrl/rdtgroup.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 4329 +++++++++++++++++
>> =C2=A0 include/linux/resctrl.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 216 +-
>> =C2=A0 include/linux/resctrl_types.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 =
59 +
>> =C2=A0 29 files changed, 7992 insertions(+), 7263 deletions(-)
>> =C2=A0 rename Documentation/{arch/x86 =3D> filesystems}/resctrl.rst (100=
%)
>> =C2=A0 rename arch/x86/kernel/cpu/resctrl/{trace.h =3D> pseudo_lock_trac=
e.h}=20
>> (56%)
>> =C2=A0 create mode 100644 fs/resctrl/Kconfig
>> =C2=A0 create mode 100644 fs/resctrl/Makefile
>> =C2=A0 create mode 100644 fs/resctrl/ctrlmondata.c
>> =C2=A0 create mode 100644 fs/resctrl/internal.h
>> =C2=A0 create mode 100644 fs/resctrl/monitor.c
>> =C2=A0 create mode 100644 fs/resctrl/monitor_trace.h
>> =C2=A0 create mode 100644 fs/resctrl/pseudo_lock.c
>> =C2=A0 create mode 100644 fs/resctrl/rdtgroup.c
>> =C2=A0 create mode 100644 include/linux/resctrl_types.h
>>
>> --=20
>> 2.39.5
>>
>
> On 3/1/2025 1:28 AM, James Morse wrote:
>> Changes since v6?: * All the excitement is in patch 37, turns out=20
>> there are two rmdir() paths that don't join up. The last eight=20
>> patches are new: * The python script has been replaced with the patch=20
>> that it generates, see the bare branch below
>>=20
>> Changes since v6?:
>> =C2=A0 * All the excitement is in patch 37, turns out there are two=20
>> rmdir() paths
>> =C2=A0=C2=A0=C2=A0 that don't join up.
>> The last eight patches are new:
>> =C2=A0 * The python script has been replaced with the patch that it=20
>> generates, see
>> =C2=A0=C2=A0=C2=A0 the bare branch below if you want to regenerate it.
>> =C2=A0 * There have been comments on the followup to the generated patch=
,=20
>> those are
>> =C2=A0=C2=A0=C2=A0 included here - I suggest they be squashed into the g=
enerated patch.
>> =C2=A0 * This version includes some checkpatch linting from Dave.
>>
>> ---
>> This series renames functions and moves code around. With the
>> exception of invalid configurations for the configurable-events,=20
>> there should
>> be no changes in behaviour caused by this series. It is now possible for
>> throttle_mode to report 'undefined', but no known platform will do this.
>>
>> The driving pattern is to make things like struct rdtgroup private to=20
>> resctrl.
>> Features like pseudo-lock aren't going to work on arm64, the ability=20
>> to disable
>> it at compile time is added.
>>
>> After this, I can start posting the MPAM driver to make use of=20
>> resctrl on arm64.
>> (What's MPAM? See the cover letter of the first series. [1])
>>
>> This series is based on v6.14-rc3 and can be retrieved from:
>> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__git.kernel.org_pu=
b_scm_linux_kernel_git_morse_linux.git&d=3DDwIDAg&c=3DnKjWec2b6R0mOyPaz7xtf=
Q&r=3DV_GK7jRuCHDErm6txmgDK1-MbUihtnSQ3gPgB-A-JKU&m=3DnuwqirfPj-0yJqyDZfy25=
skE_NJ-fYFcygpI04RUICnSUBYHutdqE6Gakd1Z3I8H&s=3D34Q-cAJD41LWUgU21FvoSkXHOM-=
uSrOs2a1vEwaxrNE&e=3D=20
>> <https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__git.kernel.org_p=
ub_scm_linux_kernel_git_morse_linux.git&d=3DDwIDAg&c=3DnKjWec2b6R0mOyPaz7xt=
fQ&r=3DV_GK7jRuCHDErm6txmgDK1-MbUihtnSQ3gPgB-A-JKU&m=3DnuwqirfPj-0yJqyDZfy2=
5skE_NJ-fYFcygpI04RUICnSUBYHutdqE6Gakd1Z3I8H&s=3D34Q-cAJD41LWUgU21FvoSkXHOM=
-uSrOs2a1vEwaxrNE&e=3D>=20
>> mpam/move_to_fs/v7
>> or for those who want to regnerate the patch that moves all the code:
>> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__git.kernel.org_pu=
b_scm_linux_kernel_git_morse_linux.git&d=3DDwIDAg&c=3DnKjWec2b6R0mOyPaz7xtf=
Q&r=3DV_GK7jRuCHDErm6txmgDK1-MbUihtnSQ3gPgB-A-JKU&m=3DnuwqirfPj-0yJqyDZfy25=
skE_NJ-fYFcygpI04RUICnSUBYHutdqE6Gakd1Z3I8H&s=3D34Q-cAJD41LWUgU21FvoSkXHOM-=
uSrOs2a1vEwaxrNE&e=3D=20
>> <https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__git.kernel.org_p=
ub_scm_linux_kernel_git_morse_linux.git&d=3DDwIDAg&c=3DnKjWec2b6R0mOyPaz7xt=
fQ&r=3DV_GK7jRuCHDErm6txmgDK1-MbUihtnSQ3gPgB-A-JKU&m=3DnuwqirfPj-0yJqyDZfy2=
5skE_NJ-fYFcygpI04RUICnSUBYHutdqE6Gakd1Z3I8H&s=3D34Q-cAJD41LWUgU21FvoSkXHOM=
-uSrOs2a1vEwaxrNE&e=3D>=20
>> mpam/move_to_fs/v7_bare
>>
>>
>> As ever - bugs welcome,
>> Thanks,
>>
>> James
>>
>> [v6]https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lore.kernel.o=
rg_lkml_20250207181823.6378-2D1-2Djames.morse-40arm.com_&d=3DDwIDAg&c=3DnKj=
Wec2b6R0mOyPaz7xtfQ&r=3DV_GK7jRuCHDErm6txmgDK1-MbUihtnSQ3gPgB-A-JKU&m=3Dnuw=
qirfPj-0yJqyDZfy25skE_NJ-fYFcygpI04RUICnSUBYHutdqE6Gakd1Z3I8H&s=3DGiw7Cw-bC=
KcY06OE4h_CYGNmKoeW3Rnf9Ph433fTflg&e=3D=20
>> <https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lore.kernel.org_=
lkml_20250207181823.6378-2D1-2Djames.morse-40arm.com_&d=3DDwIDAg&c=3DnKjWec=
2b6R0mOyPaz7xtfQ&r=3DV_GK7jRuCHDErm6txmgDK1-MbUihtnSQ3gPgB-A-JKU&m=3Dnuwqir=
fPj-0yJqyDZfy25skE_NJ-fYFcygpI04RUICnSUBYHutdqE6Gakd1Z3I8H&s=3DGiw7Cw-bCKcY=
06OE4h_CYGNmKoeW3Rnf9Ph433fTflg&e=3D>=20
>>
>> [v5]https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lore.kernel.o=
rg_r_20241004180347.19985-2D1-2Djames.morse-40arm.com&d=3DDwIDAg&c=3DnKjWec=
2b6R0mOyPaz7xtfQ&r=3DV_GK7jRuCHDErm6txmgDK1-MbUihtnSQ3gPgB-A-JKU&m=3Dnuwqir=
fPj-0yJqyDZfy25skE_NJ-fYFcygpI04RUICnSUBYHutdqE6Gakd1Z3I8H&s=3DNuPo6XsrzJWg=
oWgnhpf5PxXdFEozS_Zgk_XBTnhAn6k&e=3D=20
>> <https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lore.kernel.org_=
r_20241004180347.19985-2D1-2Djames.morse-40arm.com&d=3DDwIDAg&c=3DnKjWec2b6=
R0mOyPaz7xtfQ&r=3DV_GK7jRuCHDErm6txmgDK1-MbUihtnSQ3gPgB-A-JKU&m=3DnuwqirfPj=
-0yJqyDZfy25skE_NJ-fYFcygpI04RUICnSUBYHutdqE6Gakd1Z3I8H&s=3DNuPo6XsrzJWgoWg=
nhpf5PxXdFEozS_Zgk_XBTnhAn6k&e=3D>=20
>>
>> [v4]https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lore.kernel.o=
rg_all_20240802172853.22529-2D1-2Djames.morse-40arm.com_&d=3DDwIDAg&c=3DnKj=
Wec2b6R0mOyPaz7xtfQ&r=3DV_GK7jRuCHDErm6txmgDK1-MbUihtnSQ3gPgB-A-JKU&m=3Dnuw=
qirfPj-0yJqyDZfy25skE_NJ-fYFcygpI04RUICnSUBYHutdqE6Gakd1Z3I8H&s=3Dx0enrBNor=
LUBSyhg_SOJl9itXA4Ht_65SifVAOpMEO4&e=3D=20
>> <https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lore.kernel.org_=
all_20240802172853.22529-2D1-2Djames.morse-40arm.com_&d=3DDwIDAg&c=3DnKjWec=
2b6R0mOyPaz7xtfQ&r=3DV_GK7jRuCHDErm6txmgDK1-MbUihtnSQ3gPgB-A-JKU&m=3Dnuwqir=
fPj-0yJqyDZfy25skE_NJ-fYFcygpI04RUICnSUBYHutdqE6Gakd1Z3I8H&s=3Dx0enrBNorLUB=
Syhg_SOJl9itXA4Ht_65SifVAOpMEO4&e=3D>=20
>>
>> [v3]https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lore.kernel.o=
rg_r_20240614150033.10454-2D1-2Djames.morse-40arm.com&d=3DDwIDAg&c=3DnKjWec=
2b6R0mOyPaz7xtfQ&r=3DV_GK7jRuCHDErm6txmgDK1-MbUihtnSQ3gPgB-A-JKU&m=3Dnuwqir=
fPj-0yJqyDZfy25skE_NJ-fYFcygpI04RUICnSUBYHutdqE6Gakd1Z3I8H&s=3DFPG_ZTHC69sP=
w7sz4QOvpKZ76X7VQSTuO2yN67LY4VI&e=3D=20
>> <https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lore.kernel.org_=
r_20240614150033.10454-2D1-2Djames.morse-40arm.com&d=3DDwIDAg&c=3DnKjWec2b6=
R0mOyPaz7xtfQ&r=3DV_GK7jRuCHDErm6txmgDK1-MbUihtnSQ3gPgB-A-JKU&m=3DnuwqirfPj=
-0yJqyDZfy25skE_NJ-fYFcygpI04RUICnSUBYHutdqE6Gakd1Z3I8H&s=3DFPG_ZTHC69sPw7s=
z4QOvpKZ76X7VQSTuO2yN67LY4VI&e=3D>=20
>>
>> [v2]https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lore.kernel.o=
rg_r_20240426150537.8094-2D1-2DDave.Martin-40arm.com&d=3DDwIDAg&c=3DnKjWec2=
b6R0mOyPaz7xtfQ&r=3DV_GK7jRuCHDErm6txmgDK1-MbUihtnSQ3gPgB-A-JKU&m=3Dnuwqirf=
Pj-0yJqyDZfy25skE_NJ-fYFcygpI04RUICnSUBYHutdqE6Gakd1Z3I8H&s=3DC--gCozXx-zNw=
x631Snz1h6SShLrm546dr0_ISKSC9A&e=3D=20
>> <https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lore.kernel.org_=
r_20240426150537.8094-2D1-2DDave.Martin-40arm.com&d=3DDwIDAg&c=3DnKjWec2b6R=
0mOyPaz7xtfQ&r=3DV_GK7jRuCHDErm6txmgDK1-MbUihtnSQ3gPgB-A-JKU&m=3DnuwqirfPj-=
0yJqyDZfy25skE_NJ-fYFcygpI04RUICnSUBYHutdqE6Gakd1Z3I8H&s=3DC--gCozXx-zNwx63=
1Snz1h6SShLrm546dr0_ISKSC9A&e=3D>=20
>>
>> [v1]https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lore.kernel.o=
rg_r_20240321165106.31602-2D1-2Djames.morse-40arm.com&d=3DDwIDAg&c=3DnKjWec=
2b6R0mOyPaz7xtfQ&r=3DV_GK7jRuCHDErm6txmgDK1-MbUihtnSQ3gPgB-A-JKU&m=3Dnuwqir=
fPj-0yJqyDZfy25skE_NJ-fYFcygpI04RUICnSUBYHutdqE6Gakd1Z3I8H&s=3D0PJ7kJsoRhwO=
qCcYwUYrJwbRM9zTssWuhqkgaqXdPNY&e=3D=20
>> <https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lore.kernel.org_=
r_20240321165106.31602-2D1-2Djames.morse-40arm.com&d=3DDwIDAg&c=3DnKjWec2b6=
R0mOyPaz7xtfQ&r=3DV_GK7jRuCHDErm6txmgDK1-MbUihtnSQ3gPgB-A-JKU&m=3DnuwqirfPj=
-0yJqyDZfy25skE_NJ-fYFcygpI04RUICnSUBYHutdqE6Gakd1Z3I8H&s=3D0PJ7kJsoRhwOqCc=
YwUYrJwbRM9zTssWuhqkgaqXdPNY&e=3D>=20
>>
>> [1]https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lore.kernel.or=
g_lkml_20201030161120.227225-2D1-2Djames.morse-40arm.com_&d=3DDwIDAg&c=3DnK=
jWec2b6R0mOyPaz7xtfQ&r=3DV_GK7jRuCHDErm6txmgDK1-MbUihtnSQ3gPgB-A-JKU&m=3Dnu=
wqirfPj-0yJqyDZfy25skE_NJ-fYFcygpI04RUICnSUBYHutdqE6Gakd1Z3I8H&s=3DsYrXz5z6=
dOOGmy5Xjm0lsmdUCAN25SnhDjyq_hUSYi4&e=3D=20
>> <https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lore.kernel.org_=
lkml_20201030161120.227225-2D1-2Djames.morse-40arm.com_&d=3DDwIDAg&c=3DnKjW=
ec2b6R0mOyPaz7xtfQ&r=3DV_GK7jRuCHDErm6txmgDK1-MbUihtnSQ3gPgB-A-JKU&m=3Dnuwq=
irfPj-0yJqyDZfy25skE_NJ-fYFcygpI04RUICnSUBYHutdqE6Gakd1Z3I8H&s=3DsYrXz5z6dO=
OGmy5Xjm0lsmdUCAN25SnhDjyq_hUSYi4&e=3D>=20
>>
>>
>> Amit Singh Tomar (1):
>> =C2=A0=C2=A0 x86/resctrl: Remove the limit on the number of CLOSID
>>
>> Dave Martin (3):
>> =C2=A0=C2=A0 x86/resctrl: Squelch whitespace anomalies in resctrl core c=
ode
>> =C2=A0=C2=A0 x86/resctrl: Prefer alloc(sizeof(*foo)) idiom in=20
>> rdt_init_fs_context()
>> =C2=A0=C2=A0 x86/resctrl: Relax some asm #includes
>>
>> James Morse (45):
>> =C2=A0=C2=A0 x86/resctrl: Fix allocation of cleanest CLOSID on platforms=
 with no
>> =C2=A0=C2=A0=C2=A0=C2=A0 monitors
>> =C2=A0=C2=A0 x86/resctrl: Add a helper to avoid reaching into the arch c=
ode
>> =C2=A0=C2=A0=C2=A0=C2=A0 resource list
>> =C2=A0=C2=A0 x86/resctrl: Remove fflags from struct rdt_resource
>> =C2=A0=C2=A0 x86/resctrl: Use schema type to determine how to parse sche=
ma values
>> =C2=A0=C2=A0 x86/resctrl: Use schema type to determine the schema format=
 string
>> =C2=A0=C2=A0 x86/resctrl: Remove data_width and the tabular format
>> =C2=A0=C2=A0 x86/resctrl: Add max_bw to struct resctrl_membw
>> =C2=A0=C2=A0 x86/resctrl: Generate default_ctrl instead of sharing it
>> =C2=A0=C2=A0 x86/resctrl: Add helper for setting CPU default properties
>> =C2=A0=C2=A0 x86/resctrl: Remove rdtgroup from update_cpu_closid_rmid()
>> =C2=A0=C2=A0 x86/resctrl: Expose resctrl fs's init function to the rest =
of the
>> =C2=A0=C2=A0=C2=A0=C2=A0 kernel
>> =C2=A0=C2=A0 x86/resctrl: Move rdt_find_domain() to be visible to arch a=
nd fs code
>> =C2=A0=C2=A0 x86/resctrl: Move resctrl types to a separate header
>> =C2=A0=C2=A0 x86/resctrl: Add an arch helper to reset one resource
>> =C2=A0=C2=A0 x86/resctrl: Move monitor exit work to a resctrl exit call
>> =C2=A0=C2=A0 x86/resctrl: Move monitor init work to a resctrl init call
>> =C2=A0=C2=A0 x86/resctrl: Rewrite and move the for_each_*_rdt_resource()=
 walkers
>> =C2=A0=C2=A0 x86/resctrl: Move the is_mbm_*_enabled() helpers to asm/res=
ctrl.h
>> =C2=A0=C2=A0 x86/resctrl: Add resctrl_arch_is_evt_configurable() to abst=
ract BMEC
>> =C2=A0=C2=A0 x86/resctrl: Change mon_event_config_{read,write}() to be a=
rch=20
>> helpers
>> =C2=A0=C2=A0 x86/resctrl: Move mba_mbps_default_event init to filesystem=
 code
>> =C2=A0=C2=A0 x86/resctrl: Move mbm_cfg_mask to struct rdt_resource
>> =C2=A0=C2=A0 x86/resctrl: Add resctrl_arch_ prefix to pseudo lock functi=
ons
>> =C2=A0=C2=A0 x86/resctrl: Allow an architecture to disable pseudo lock
>> =C2=A0=C2=A0 x86/resctrl: Make prefetch_disable_bits belong to the arch =
code
>> =C2=A0=C2=A0 x86/resctrl: Make resctrl_arch_pseudo_lock_fn() take a plr
>> =C2=A0=C2=A0 x86/resctrl: Move RFTYPE flags to be managed by resctrl
>> =C2=A0=C2=A0 x86/resctrl: Handle throttle_mode for SMBA resources
>> =C2=A0=C2=A0 x86/resctrl: Move get_config_index() to a header
>> =C2=A0=C2=A0 x86/resctrl: Move get_{mon,ctrl}_domain_from_cpu() to live =
with their
>> =C2=A0=C2=A0=C2=A0=C2=A0 callers
>> =C2=A0=C2=A0 x86/resctrl: Rename resctrl_sched_in() to begin with "resct=
rl_arch_"
>> =C2=A0=C2=A0 x86/resctrl: resctrl_exit() teardown resctrl but leave the =
mount=20
>> point
>> =C2=A0=C2=A0 x86/resctrl: Drop __init/__exit on assorted symbols
>> =C2=A0=C2=A0 x86/resctrl: Move is_mba_sc() out of core.c
>> =C2=A0=C2=A0 x86/resctrl: Add end-marker to the resctrl_event_id enum
>> =C2=A0=C2=A0 x86/resctrl: Expand the width of dom_id by replacing mon_da=
ta_bits
>> =C2=A0=C2=A0 x86/resctrl: Remove a newline to avoid confusing the code m=
ove script
>> =C2=A0=C2=A0 x86/resctrl: Split trace.h
>> =C2=A0=C2=A0 fs/resctrl: Add boiler plate for external resctrl code
>> =C2=A0=C2=A0 x86/resctrl: Move the filesystem bits to headers visible to=
=20
>> fs/resctrl
>> =C2=A0=C2=A0 x86,fs/resctrl: Move the resctrl filesystem code to live in
>> =C2=A0=C2=A0=C2=A0=C2=A0 /fs/resctrl
>> =C2=A0=C2=A0 x86,fs/resctrl: Remove duplicated trace header files
>> =C2=A0=C2=A0 fs/resctrl: Remove unnecessary includes
>> =C2=A0=C2=A0 fs/resctrl: Change internal.h's header guard macros
>> =C2=A0=C2=A0 x86,fs/resctrl: Move resctrl.rst to live under
>> =C2=A0=C2=A0=C2=A0=C2=A0 Documentation/filesystems
>>
>> =C2=A0 Documentation/arch/x86/index.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 1 -
>> =C2=A0 Documentation/filesystems/index.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 1 +
>> =C2=A0 .../{arch/x86 =3D> filesystems}/resctrl.rst=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0=C2=A0 0
>> =C2=A0 MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0=C2=A0=C2=A0 4 +-
>> =C2=A0 arch/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0=C2=A0 8 +
>> =C2=A0 arch/x86/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 6 +-
>> =C2=A0 arch/x86/include/asm/resctrl.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 43 =
+-
>> =C2=A0 arch/x86/kernel/cpu/resctrl/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 8 +-
>> =C2=A0 arch/x86/kernel/cpu/resctrl/core.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 214 +-
>> =C2=A0 arch/x86/kernel/cpu/resctrl/ctrlmondata.c=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0 606 +--
>> =C2=A0 arch/x86/kernel/cpu/resctrl/internal.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 504 +-
>> =C2=A0 arch/x86/kernel/cpu/resctrl/monitor.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 863 +---
>> =C2=A0 arch/x86/kernel/cpu/resctrl/pseudo_lock.c=C2=A0=C2=A0=C2=A0=C2=A0=
 | 1120 +----
>> =C2=A0 .../resctrl/{trace.h =3D> pseudo_lock_trace.h}=C2=A0 |=C2=A0=C2=
=A0 26 +-
>> =C2=A0 arch/x86/kernel/cpu/resctrl/rdtgroup.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 4031 +--------------
>> =C2=A0 arch/x86/kernel/process_32.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
=C2=A0=C2=A0 2 +-
>> =C2=A0 arch/x86/kernel/process_64.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
=C2=A0=C2=A0 2 +-
>> =C2=A0 fs/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0=C2=A0=C2=A0 1 +
>> =C2=A0 fs/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0=C2=A0=C2=A0 1 +
>> =C2=A0 fs/resctrl/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 39 +
>> =C2=A0 fs/resctrl/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 6 +
>> =C2=A0 fs/resctrl/ctrlmondata.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 660 +++
>> =C2=A0 fs/resctrl/internal.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 435 ++
>> =C2=A0 fs/resctrl/monitor.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 933 ++++
>> =C2=A0 fs/resctrl/monitor_trace.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0=C2=A0 33 +
>> =C2=A0 fs/resctrl/pseudo_lock.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 1104 +++++
>> =C2=A0 fs/resctrl/rdtgroup.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 4329 +++++++++++++++++
>> =C2=A0 include/linux/resctrl.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 216 +-
>> =C2=A0 include/linux/resctrl_types.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 =
59 +
>> =C2=A0 29 files changed, 7992 insertions(+), 7263 deletions(-)
>> =C2=A0 rename Documentation/{arch/x86 =3D> filesystems}/resctrl.rst (100=
%)
>> =C2=A0 rename arch/x86/kernel/cpu/resctrl/{trace.h =3D> pseudo_lock_trac=
e.h}=20
>> (56%)
>> =C2=A0 create mode 100644 fs/resctrl/Kconfig
>> =C2=A0 create mode 100644 fs/resctrl/Makefile
>> =C2=A0 create mode 100644 fs/resctrl/ctrlmondata.c
>> =C2=A0 create mode 100644 fs/resctrl/internal.h
>> =C2=A0 create mode 100644 fs/resctrl/monitor.c
>> =C2=A0 create mode 100644 fs/resctrl/monitor_trace.h
>> =C2=A0 create mode 100644 fs/resctrl/pseudo_lock.c
>> =C2=A0 create mode 100644 fs/resctrl/rdtgroup.c
>> =C2=A0 create mode 100644 include/linux/resctrl_types.h
>>
>> --=20
>> 2.39.5
>>

