Return-Path: <linux-kernel+bounces-403408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD5F69C3549
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 00:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4F6D1C21641
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 23:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370F7158214;
	Sun, 10 Nov 2024 23:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Lt0QJWl1"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F05D39FCE
	for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 23:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731281659; cv=fail; b=opuepoM1Vi00YQN7k5CU+o+mupblfiX9PGscufFVfx6VB/xNXzyHePJP1yENDFtXbrn1a5NQefjMkk0nOsJTfV123c9AKClHeTf8fTiZF6Kk4t7Ir6c3oI+P01YRMkKqK5zMsM2z36NlGU6e78L9lEaVHbmP8znDNnVxVuANdM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731281659; c=relaxed/simple;
	bh=ERcrSErW1a4IP5PGliLLHXKaHvjokSstJqski9bUlyg=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 Content-Type:MIME-Version; b=uRmRQBwGE5arQHbxCHxRK3yP8LD44munLewg3bAHxku29oqA4qD0E4ePAmgDufbWvKqDMiejhAhqeKWaVk4/cowvkF6N7SGy13kbE4Ei1kZzbB7WDN0i4icrs/jCUO+CqIXDKrgBJmWSsKnYRcNO6vTBrFv6DjcBn07sOePZwfQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Lt0QJWl1; arc=fail smtp.client-ip=40.107.92.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BwMd3kd3R18apJDvzoIIuRjvswAl3tmerXIetBJpJDoKzs7M/w0HzWoS4kgPBQXNPQ5ZSptjKy+Brn5loiVCFofiHqKoDx1WRUOxhOEqhOGYMsHQjmce4y81vYBIPHI1oSI0y5H1qk36Q8vPy+wjhPngmWzmmesW8aiRsoeDXUuz8BPGo4AVmOibI+VxI2BT6AlfVPwxtyBN+IZair/Vrj9tTVEJuHnBdtTYzsvXNf2Kpz4Toa/6iFIFpn1el7gVRvha4ktJRv9QW3Y+tT+Aqzzwm8+Wp8+nven5UAGhP/yCIuMKkCfaDKVDnbB/KzpztR2voiHDNE+bFY0F+oorNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IOpoLgHcG426YvRyEJ26lPAlsB4A+RfiiI4LBYlvybA=;
 b=tpq1WBEh6STQ4KUV+qmks9HCndpa/ShAjaclnh1eVJcbWqtNPp4vmv4l+vT6IvWdmf1PA+jw9uPj3RHNE/D/UmSWWRwBYP52TgTSuZ5sxq6xAA58CHrgyAvipdrnyLzTk7KS+jS1MhBUg3lrnXJYch37edHzz9TCh9q0VSj0z8ht94fPG1ov2M/hxOeyd2KwOtNLjJqHiMAaYrvyq/4io+8Ousvpd6JhHmjkf1FtPgWhNDcpCU7RRR4JbQLG+DsR852Rrs/VIoQAOberj3WHTMXP6FS7v8D0w7dHI8lah38nw4kSu6fmlH44cyLgrX1enOl9as3OQl7kpipw85k8MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IOpoLgHcG426YvRyEJ26lPAlsB4A+RfiiI4LBYlvybA=;
 b=Lt0QJWl17RPUZOo5oxQAyHnAVHtSNQKPQM7JeWl3SVy1zC30wd3hpjRIcR5PqLWF/HLh3nUU+2oP4hvh9KJVhtEkHAYtemuSGqC1zYC/ou5Iuo5+LocygjhMLhh00u3xCs4XIedlYFZRg9rA0wMlTSymPxxr9N2HWpTbEmuo4B24Wh983D9aQYt7m7jKZC8ay2UccyZCoJAb78J2KKGiPnf+gN/zm48Gmz99q4L/LYVgA2QcTghgSpg4tiFF4bGr8EWXM7EaDIpsmlXb75EridArJUN25XCYXlfUSuqKXXqwBB0KbGkMApeE7EZGhBhTdHRZFs/a7omnurVFXJKyBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 CY8PR12MB8242.namprd12.prod.outlook.com (2603:10b6:930:77::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.28; Sun, 10 Nov 2024 23:34:13 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::953f:2f80:90c5:67fe%6]) with mapi id 15.20.8137.022; Sun, 10 Nov 2024
 23:34:13 +0000
References: <20241101-mm-remote-pfn-v1-1-080b609270b7@asahilina.net>
 <c00226ea-6e29-4432-a1c4-a25e9e05df9c@redhat.com>
 <2d8380b9-3d03-4263-b5bf-7e0227c83ba9@asahilina.net>
 <0977a33b-8318-43a5-a5a1-4eb8c93ca270@redhat.com>
 <64d386e8-6684-4213-8aba-7d1daf94f2cf@asahilina.net>
 <412298ff-80bc-4111-8c72-29a5263a5d32@redhat.com>
User-agent: mu4e 1.10.8; emacs 29.4
From: Alistair Popple <apopple@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: Asahi Lina <lina@asahilina.net>, Andrew Morton
 <akpm@linux-foundation.org>, Sergio Lopez Pascual <slp@redhat.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, asahi@lists.linux.dev,
 Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] mm: Fix __wp_page_copy_user fallback path for remote mm
Date: Mon, 11 Nov 2024 10:24:53 +1100
In-reply-to: <412298ff-80bc-4111-8c72-29a5263a5d32@redhat.com>
Message-ID: <87ttceu0i8.fsf@nvdebian.thelocal>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SY6PR01CA0100.ausprd01.prod.outlook.com
 (2603:10c6:10:111::15) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|CY8PR12MB8242:EE_
X-MS-Office365-Filtering-Correlation-Id: c6e3a032-8b1a-4c78-2c8f-08dd01e02efd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MDFpT1ZqWXkyUnNTdGttSm5PREw2QVVOM2FOdzZaTmgzOFBWUlZFZDZNalVE?=
 =?utf-8?B?cWwzNG5PUWM0cVdRMm82bjV4YTJtS1NvWVA2RHRNbkdCbVdDRlp5SlM3YlJ6?=
 =?utf-8?B?T2REM0swZFIxWUdBVi9JWXcrbkpMWUljL2Y2WUgvVGx6M1grZGd4dmRqbktK?=
 =?utf-8?B?WTVFeWhnRkc2dkxHcU9xdVFESDA1UFpnNGRLbVY2OEpENTVxNDNhaDRTTSth?=
 =?utf-8?B?dVNYd2ljaUVxRDJXdzZ4NUZqM0h0RXNWcDVFNlVVbmkxWGpxc2dzam1Ya1RV?=
 =?utf-8?B?RlVobXBKWElEaTh5YlBCN0pud0JhbVl1ZlFnVEZCbjFCdWh1QWNWTGNleW1K?=
 =?utf-8?B?dEhwWG5hdTUrclMzZDVweEdJT1Z3aXYrY1RCYlBCYkdJa09nTy9qc1YvTXZr?=
 =?utf-8?B?YVRscUxMcEF6R2xtU2ZNRUpMeGluUXlaTWo3ZGFsUUVBTjR6SGl3cjJidVJK?=
 =?utf-8?B?YVdrQTdtN1JCK1JGRVJZbzlxeFNTUzFuMS9MK0RMREJZcmtJZWFPajcrUTJ1?=
 =?utf-8?B?K2NzWnRIRitzVEo0d0xwMzFVQ2pGMUNJM3ZvY0Z5ZHJ3SkEvd3Zjbk9BS2g4?=
 =?utf-8?B?VkJOVVAxc3NpV0MxWm52QU9XSUVMaVNNQVJNWmVuVUNqcVJtamZSUUFMVlBm?=
 =?utf-8?B?ckxWOVI1b0VEaVE2aUo3UDIxaS80bDczK1l4RldjTlR3L0Z5bnVMUERSQy84?=
 =?utf-8?B?M2xCLzY1Q3RETEgvWnBBaGUvV1pnV3hjS2hHTUpxbUJPb2NUcW9xME9TWnRv?=
 =?utf-8?B?cmxmRDNvcVVCWnI0UUU0NVVReTJ5MTRxNi90TzhsMGR2SU12ekhBdGhJRkFk?=
 =?utf-8?B?aVFNSHdDeWpnMi8remw5YjBCRGgvaUFsUEhmbFVINUtrMjdjZ0hSOWtBMVky?=
 =?utf-8?B?WVdMcld2aGhsM09qTE5PODY4TnRhM2VTMkxtUmxuRWJpVllScWZZZUpXc3Fh?=
 =?utf-8?B?dURtNnlvL2R3WUUzQ1poZHJzUFJsclJBZXBLbzV5TjNiK041eFRLcUtpNEV1?=
 =?utf-8?B?T05YTmE0bkRabWJlZFlyUGJVT2xkbjVlUHA4YWE2Z0c1ZlY4dFNQZklkcTJ3?=
 =?utf-8?B?amdtNEp4T1pFVStKeUFLRkc2RVlvbHlNMHdzUDk0dWxzOWx0NitndEtXRWxM?=
 =?utf-8?B?MEF5T3BIVDBTS2l2OHB0d21QTGk1NVJCOTlvNUV3RGYyc1hMb0pRRlJhMDk3?=
 =?utf-8?B?TTB6UFdERGViNS8yNzdON0hHNUNzUzdMVlBwUjBhUUtoSzkwK3dMd3BMZVBY?=
 =?utf-8?B?T21pckYyamFBd0k3SW04RFpvSXFSdW5VMGEyWCt2bEFQTGQ5VFgwVXVMN054?=
 =?utf-8?B?U1JLN21hSmFyeG9ncmk3Yzl6ZGpUa1RiazJiTVBNWXgzd1ZSdisrcFdkWUw0?=
 =?utf-8?B?cDZKbGxmSlNMb3RJYlp2cXlnM2pxakxnaGRqb245cDROMHVGd1Buck9BNE5Z?=
 =?utf-8?B?LzFEazVWbFJWd2h5bG53OWJDZ1RmbzUwRVhiNnNFMmJpRTNIbHkzMUppTldS?=
 =?utf-8?B?S2hxbXF1VFcvOWQwMWVGK3RwQXRWYkF4V3NSdzhWNktSVWxCenNaOXpIdVkw?=
 =?utf-8?B?dG1Eanl3OVNtR2hWYVZmVGRjNTVSMktQT1h3K1BJb2Z5NUZScTlRUklHNmlr?=
 =?utf-8?B?aXk4cHBCZEdqOVVTblFSUkc1Uys2bkdVNWZiYUpIQ3QvR3E2SWJEUjhmZ3Jw?=
 =?utf-8?B?TE9HSXl2cXlFVVl4SVU1S3RqL1I0eWRCWG9HMG54QURyWHc0SFZLQWljemxa?=
 =?utf-8?Q?K3OQwy7CYaBg+OHyDIAm/Pi90kEFZTrtoYGQlSJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7726.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VWFWZ0N4WUZjeDJHVnlmblNIVUoyUkVRcmV2MG81VUlCdUVOMmsybFJnYyt0?=
 =?utf-8?B?cmpJU0k1ckdRTTBxNklLRXJLS3pZOXdFdkxkTnNwWS9lRXN0OE0xUVV1RjFm?=
 =?utf-8?B?ODYzeFA1L0lReFdJMDV3QStQZjFWUWhoVGU0elNjQnZtRVlGMkdFaG1MdEhJ?=
 =?utf-8?B?T2M1MEZ4T1piSUJIZVFOYW4ydnI2RE5qdFhONkQxb0N6ZWN2MUlRYWNpVUww?=
 =?utf-8?B?b2VsN1ZnenY0czVlbllmeDIyS05qenVTSEQwL1VDWVZXa3hJd3NFVUtaZ0xP?=
 =?utf-8?B?c1lYcEE1K0FJRmdUZ1U2Yzc2dWRuVElwQ3JwTUFhUHpTTkcrQzQ2YVp2ZWp3?=
 =?utf-8?B?cElSOHlSaGpmaXBaQnh2WFFHMzFvUy92YmpsUzRHMkJydXJQS2RieXJia0lv?=
 =?utf-8?B?b3JPZjlXTDI0bjEwbzhXYkxxd0s5OEEyMFZoVFFxcTMvZ2dwdW1SMEpGenI1?=
 =?utf-8?B?WUNWdkFNaktTdnpZdXl1eUNtSTlPdlZSOW9vTnlVRUd6QWVjN09RY3A4L2V1?=
 =?utf-8?B?NU9iTndaQktZamhac1dJUkpJSWNkVndEUllJMFBXWFlFbEFmdkJGUnFnV21a?=
 =?utf-8?B?WFJUUzl0SFZocWRiNmdyVElnNUxDSHVsSnQrWlpWZmc3VVY3K2xETW1tWWxS?=
 =?utf-8?B?M25ZSGRVc1F5ZkJrdzFGMUk0SVpYdXN0eUcydFhVMFhJeDhvelIwVHpuN0sr?=
 =?utf-8?B?ODNteGJhM3YyR3NjL282b1BNWm04R3UyZ1h1enJ6TTViRWNxaS9MSS9Demlo?=
 =?utf-8?B?YUVXUys5bVBzTEtaMlVIWnZvSkI5S3VycHpCbWVSQU9LdlNzV3gwZE41bkhD?=
 =?utf-8?B?M2JBVmd0endSU1lYY0huT20rUlIzMU9WQWtnTXc5cTQxbnJWVlZSQUJoK2d1?=
 =?utf-8?B?Z1dMQ21VNzFVdFVJOTd2NnN6R1dkK0ptOWErOG5NVEZ6MzAyeTVqNEhnSDBD?=
 =?utf-8?B?VkVrUHF4NkFWWjVNdXlsK1F0VDFtRm16SEd1bSs1R0hLWElQeHp6b1VnRTJ5?=
 =?utf-8?B?N1Iwa2QvMFpqdUZrOWphRlJvMWJmeWxpaXpCdzQwRWUzeEgxTTMrSDZwbW42?=
 =?utf-8?B?Zk4wM05qbk92Z3VaY1EzTzQyVHpDMVoxVFhjVjFmZ0hVb294MGpYekRKNHlq?=
 =?utf-8?B?MFFKdDllc1lHVS9yMGd5R1JXZmtJMGIwRHM3TWttcXVYeStvd20xN1FUZFpF?=
 =?utf-8?B?UENDY3pZczZlcGUxVmdzTG8ybmJTbVdEQktyL001djJBQmV2SUg3RUt4eE9E?=
 =?utf-8?B?YzB3MzhWY0p1RVhoYXlmdGtxRjJuR2FUTVNhUEhwKy9KSCszb1ZYdW1OaktU?=
 =?utf-8?B?REtUbUZGaURpd3VZTnVvRkdjM0NrNkVBY053V2lWSGdmQm5uZm5DSHY0OVNV?=
 =?utf-8?B?V0hqL085MDZDVmdQa1VHUUw5Nkt6TC9TMXpJdnFSai9ydW1ZWksrL1M0UlhW?=
 =?utf-8?B?K0R5bkZkZlBnMUZSSGVDS2hvVEVndEN5ZlVUekI3N25JWThBTVk2blZGT0RZ?=
 =?utf-8?B?cStwY0RkYU1tV2FKcEdvRVBndTJ5VDlHQjZKcTFJdDNBRjN6OUppNFFxSWF1?=
 =?utf-8?B?THBiQ2NqQWsvU1BCV0hEdUp0ZWdQYktnRTMxWVdPTU92OHF1VXdRTU5FRHhH?=
 =?utf-8?B?K2ZObk54czZPTFZ2VWY5clRzYjNESk81REp0RFVMV0pNR2lKMTA5cUx1NHFM?=
 =?utf-8?B?S0xkcnNZOThtUUlCby9VdmxrcXBZUTRBMXlESTQrUElYaGh5blQzOWEvcURm?=
 =?utf-8?B?VEYrY1BiaVgxd1RHVStHVnZ6SmtUNE1Zb1dZS0FnRyt0VmlLQU01VWJ5Z3d2?=
 =?utf-8?B?OStzRUhBQkR0ME1nMitveGZ1UTVSZjlEQWhaRjJLdGd3NGFyUW1GMGZ0dmFR?=
 =?utf-8?B?ZDJodnMyMWVRQ05WSitxQTBCd2lNU0ovY3A3TlZtTkRjVG9xN2t4SWRpeGZW?=
 =?utf-8?B?S0puNFJoMHFCV20raWJPbnNJWVNaK01kdVFPYURlSHlaUGJQcGhyUEtielFD?=
 =?utf-8?B?U3UxMHEyd2JqZHFTVWNEemJvQ213SFd3U1ovVDc0WGJuZXg5T1dKLzAzeUJO?=
 =?utf-8?B?ZzRjTWEvUmpFWDYvUkZHTm1ocW5qeDRFSThVN3YzRXRIa29iTVRXazgvOUc5?=
 =?utf-8?Q?izOCgyozyNkwuDF5qaCTIlPtd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6e3a032-8b1a-4c78-2c8f-08dd01e02efd
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2024 23:34:13.2220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X4RAgPFMylFsQy1tN+59pL0zwU/N+ZkzRUnouw0YtQB28d3hDFen+63gZZdOuI4UMgQt33XrCWbRJfXH854qgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8242


David Hildenbrand <david@redhat.com> writes:

> On 07.11.24 18:32, Asahi Lina wrote:
>> On 11/8/24 2:14 AM, David Hildenbrand wrote:
>>> On 07.11.24 17:43, Asahi Lina wrote:
>>>> On 11/5/24 9:03 PM, David Hildenbrand wrote:
>>>>> On 01.11.24 13:08, Asahi Lina wrote:
>>>>>> If the source page is a PFN mapping, we copy back from userspace.
>>>>>> However, if this fault is a remote access, we cannot use
>>>>>> __copy_from_user_inatomic. Instead, use access_remote_vm() in this
>>>>>> case.
>>>>>>
>>>>>> Fixes WARN and incorrect zero-filling when writing to CoW mappings i=
n
>>>>>> a remote process, such as when using gdb on a binary present on a DA=
X
>>>>>> filesystem.
>>>>>>
>>>>>> [=C2=A0 143.683782] ------------[ cut here ]------------
>>>>>> [=C2=A0 143.683784] WARNING: CPU: 1 PID: 350 at mm/memory.c:2904
>>>>>> __wp_page_copy_user+0x120/0x2bc
>>>>>> [=C2=A0 143.683793] CPU: 1 PID: 350 Comm: gdb Not tainted 6.6.52 #1
>>>>>> [=C2=A0 143.683794] Hardware name: linux,dummy-virt (DT)
>>>>>> [=C2=A0 143.683795] pstate: 61400005 (nZCv daif +PAN -UAO -TCO +DIT =
-SSBS
>>>>>> BTYPE=3D--)
>>>>>> [=C2=A0 143.683796] pc : __wp_page_copy_user+0x120/0x2bc
>>>>>> [=C2=A0 143.683798] lr : __wp_page_copy_user+0x254/0x2bc
>>>>>> [=C2=A0 143.683799] sp : ffff80008272b8b0
>>>>>> [=C2=A0 143.683799] x29: ffff80008272b8b0 x28: 0000000000000000 x27:
>>>>>> ffff000083bad580
>>>>>> [=C2=A0 143.683801] x26: 0000000000000000 x25: 0000fffff7fd5000 x24:
>>>>>> ffff000081db04c0
>>>>>> [=C2=A0 143.683802] x23: ffff00014f24b000 x22: fffffc00053c92c0 x21:
>>>>>> ffff000083502150
>>>>>> [=C2=A0 143.683803] x20: 0000fffff7fd5000 x19: ffff80008272b9d0 x18:
>>>>>> 0000000000000000
>>>>>> [=C2=A0 143.683804] x17: ffff000081db0500 x16: ffff800080fe52a0 x15:
>>>>>> 0000fffff7fd5000
>>>>>> [=C2=A0 143.683804] x14: 0000000000bb1845 x13: 0000000000000080 x12:
>>>>>> ffff80008272b880
>>>>>> [=C2=A0 143.683805] x11: ffff000081d13600 x10: ffff000081d13608 x9 :
>>>>>> ffff000081d1360c
>>>>>> [=C2=A0 143.683806] x8 : ffff000083a16f00 x7 : 0000000000000010 x6 :
>>>>>> ffff00014f24b000
>>>>>> [=C2=A0 143.683807] x5 : ffff00014f24c000 x4 : 0000000000000000 x3 :
>>>>>> ffff000083582000
>>>>>> [=C2=A0 143.683807] x2 : 0000000000000f80 x1 : 0000fffff7fd5000 x0 :
>>>>>> 0000000000001000
>>>>>> [=C2=A0 143.683808] Call trace:
>>>>>> [=C2=A0 143.683809]=C2=A0 __wp_page_copy_user+0x120/0x2bc
>>>>>> [=C2=A0 143.683810]=C2=A0 wp_page_copy+0x98/0x5c0
>>>>>> [=C2=A0 143.683813]=C2=A0 do_wp_page+0x250/0x530
>>>>>> [=C2=A0 143.683814]=C2=A0 __handle_mm_fault+0x278/0x284
>>>>>> [=C2=A0 143.683817]=C2=A0 handle_mm_fault+0x64/0x1e8
>>>>>> [=C2=A0 143.683819]=C2=A0 faultin_page+0x5c/0x110
>>>>>> [=C2=A0 143.683820]=C2=A0 __get_user_pages+0xc8/0x2f4
>>>>>> [=C2=A0 143.683821]=C2=A0 get_user_pages_remote+0xac/0x30c
>>>>>> [=C2=A0 143.683823]=C2=A0 __access_remote_vm+0xb4/0x368
>>>>>> [=C2=A0 143.683824]=C2=A0 access_remote_vm+0x10/0x1c
>>>>>> [=C2=A0 143.683826]=C2=A0 mem_rw.isra.0+0xc4/0x218
>>>>>> [=C2=A0 143.683831]=C2=A0 mem_write+0x18/0x24
>>>>>> [=C2=A0 143.683831]=C2=A0 vfs_write+0xa0/0x37c
>>>>>> [=C2=A0 143.683834]=C2=A0 ksys_pwrite64+0x7c/0xc0
>>>>>> [=C2=A0 143.683834]=C2=A0 __arm64_sys_pwrite64+0x20/0x2c
>>>>>> [=C2=A0 143.683835]=C2=A0 invoke_syscall+0x48/0x10c
>>>>>> [=C2=A0 143.683837]=C2=A0 el0_svc_common.constprop.0+0x40/0xe0
>>>>>> [=C2=A0 143.683839]=C2=A0 do_el0_svc+0x1c/0x28
>>>>>> [=C2=A0 143.683841]=C2=A0 el0_svc+0x3c/0xdc
>>>>>> [=C2=A0 143.683846]=C2=A0 el0t_64_sync_handler+0x120/0x12c
>>>>>> [=C2=A0 143.683848]=C2=A0 el0t_64_sync+0x194/0x198
>>>>>> [=C2=A0 143.683849] ---[ end trace 0000000000000000 ]---
>>>>>>
>>>>>> Signed-off-by: Asahi Lina <lina@asahilina.net>
>>>>>> ---
>>>>>>  =C2=A0=C2=A0 mm/memory.c | 7 ++++++-
>>>>>>  =C2=A0=C2=A0 1 file changed, 6 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/mm/memory.c b/mm/memory.c
>>>>>> index
>>>>>> 3ccee51adfbbd007b24331fe6874265f231a877b..dba25d9734063ac02cdaeb0a5c=
d5432473f6372e 100644
>>>>>> --- a/mm/memory.c
>>>>>> +++ b/mm/memory.c
>>>>>> @@ -3081,13 +3081,18 @@ static inline int __wp_page_copy_user(struct
>>>>>> page *dst, struct page *src,
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 update_mmu_cache_range(vmf, vma, addr, vmf->pte, 1);
>>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>>  =C2=A0=C2=A0 +=C2=A0=C2=A0=C2=A0 /* If the mm is a remote mm, copy =
in the page using
>>>>>> access_remote_vm() */
>>>>>> +=C2=A0=C2=A0=C2=A0 if (current->mm !=3D mm) {
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (access_remote_vm(mm,=
 (unsigned long)uaddr, kaddr,
>>>>>> PAGE_SIZE, 0) !=3D PAGE_SIZE)
>>>>>
>>>>> access_remote_vm() will do a mmap_read_lock_killable() and then call
>>>>> into get_user_page_vma_remote() -- fortunately read-access, otherwise
>>>>> we'd be in trouble :) .
>>>>>
>>>>> So we should already be holding the mmap read lock from the previous
>>>>> access_remote_vm() users (who we end up here) ... doesn't this compla=
in
>>>>> with lockdep about recursive locking?
>>>>>
>>>>> I keep forgetting locking rules, so I might just be wrong.
>>>>
>>>> You're right, this complains with lockdep:
>>>>
>>>> [=C2=A0=C2=A0 23.154031]
>>>> [=C2=A0=C2=A0 23.154093] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>>>> [=C2=A0=C2=A0 23.154193] WARNING: possible recursive locking detected
>>>> [=C2=A0=C2=A0 23.154229] 6.6.52 #2 Not tainted
>>>> [=C2=A0=C2=A0 23.154270] --------------------------------------------
>>>> [=C2=A0=C2=A0 23.154306] gdb/349 is trying to acquire lock:
>>>> [=C2=A0=C2=A0 23.154343] ffff0000862e3450 (&mm->mmap_lock){++++}-{3:3}=
, at:
>>>> __access_remote_vm+0x3c/0x3a8
>>>> [=C2=A0=C2=A0 23.154431]
>>>> [=C2=A0=C2=A0 23.154431] but task is already holding lock:
>>>> [=C2=A0=C2=A0 23.154474] ffff0000862e3450 (&mm->mmap_lock){++++}-{3:3}=
, at:
>>>> __access_remote_vm+0x3c/0x3a8
>>>> [=C2=A0=C2=A0 23.154553]
>>>> [=C2=A0=C2=A0 23.154553] other info that might help us debug this:
>>>> [=C2=A0=C2=A0 23.154598]=C2=A0 Possible unsafe locking scenario:
>>>> [=C2=A0=C2=A0 23.154598]
>>>> [=C2=A0=C2=A0 23.154641]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CPU=
0
>>>> [=C2=A0=C2=A0 23.154665]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ---=
-
>>>> [=C2=A0=C2=A0 23.154685]=C2=A0=C2=A0 lock(&mm->mmap_lock);
>>>> [=C2=A0=C2=A0 23.154712]=C2=A0=C2=A0 lock(&mm->mmap_lock);
>>>> [=C2=A0=C2=A0 23.154741]
>>>> [=C2=A0=C2=A0 23.154741]=C2=A0 *** DEADLOCK ***
>>>> [=C2=A0=C2=A0 23.154741]
>>>> [=C2=A0=C2=A0 23.154790]=C2=A0 May be due to missing lock nesting nota=
tion
>>>> [=C2=A0=C2=A0 23.154790]
>>>> [=C2=A0=C2=A0 23.154838] 2 locks held by gdb/349:
>>>> [=C2=A0=C2=A0 23.154868]=C2=A0 #0: ffff0000835b53f8 (sb_writers#4){.+.=
+}-{0:0}, at:
>>>> vfs_write+0x84/0x2e0
>>>> [=C2=A0=C2=A0 23.154945]=C2=A0 #1: ffff0000862e3450 (&mm->mmap_lock){+=
+++}-{3:3}, at:
>>>> __access_remote_vm+0x3c/0x3a8
>>>> [=C2=A0=C2=A0 23.155023]
>>>> [=C2=A0=C2=A0 23.155023] stack backtrace:
>>>> [=C2=A0=C2=A0 23.155060] CPU: 5 PID: 349 Comm: gdb Not tainted 6.6.52 =
#2
>>>> [=C2=A0=C2=A0 23.155112] Hardware name: linux,dummy-virt (DT)
>>>> [=C2=A0=C2=A0 23.155148] Call trace:
>>>> [=C2=A0=C2=A0 23.155167]=C2=A0 dump_backtrace+0x98/0x118
>>>> [=C2=A0=C2=A0 23.155209]=C2=A0 show_stack+0x18/0x24
>>>> [=C2=A0=C2=A0 23.155240]=C2=A0 dump_stack_lvl+0x60/0xac
>>>> [=C2=A0=C2=A0 23.155292]=C2=A0 dump_stack+0x18/0x24
>>>> [=C2=A0=C2=A0 23.155320]=C2=A0 print_deadlock_bug+0x260/0x34c
>>>> [=C2=A0=C2=A0 23.155364]=C2=A0 validate_chain+0x364/0x4c0
>>>> [=C2=A0=C2=A0 23.155393]=C2=A0 __lock_acquire+0x564/0xb64
>>>> [=C2=A0=C2=A0 23.155420]=C2=A0 lock_acquire.part.0+0x9c/0x1bc
>>>> [=C2=A0=C2=A0 23.155448]=C2=A0 lock_acquire+0x9c/0x140
>>>> [=C2=A0=C2=A0 23.155477]=C2=A0 down_read_killable+0x44/0x158
>>>> [=C2=A0=C2=A0 23.155521]=C2=A0 __access_remote_vm+0x3c/0x3a8
>>>> [=C2=A0=C2=A0 23.155562]=C2=A0 __wp_page_copy_user+0x13c/0x3a8
>>>> [=C2=A0=C2=A0 23.155611]=C2=A0 wp_page_copy+0x98/0x4d8
>>>> [=C2=A0=C2=A0 23.155640]=C2=A0 do_wp_page+0x290/0x594
>>>> [=C2=A0=C2=A0 23.155671]=C2=A0 __handle_mm_fault+0x258/0x25c
>>>> [=C2=A0=C2=A0 23.155712]=C2=A0 handle_mm_fault+0x64/0x1f0
>>>> [=C2=A0=C2=A0 23.155755]=C2=A0 faultin_page+0x64/0x138
>>>> [=C2=A0=C2=A0 23.155798]=C2=A0 __get_user_pages+0x11c/0x340
>>>> [=C2=A0=C2=A0 23.155843]=C2=A0 get_user_pages_remote+0xc4/0x404
>>>> [=C2=A0=C2=A0 23.155895]=C2=A0 __access_remote_vm+0xf4/0x3a8
>>>> [=C2=A0=C2=A0 23.155922]=C2=A0 access_remote_vm+0x10/0x1c
>>>> [=C2=A0=C2=A0 23.155952]=C2=A0 mem_rw.isra.0+0xc4/0x218
>>>> [=C2=A0=C2=A0 23.155996]=C2=A0 mem_write+0x18/0x24
>>>> [=C2=A0=C2=A0 23.156023]=C2=A0 vfs_write+0xa4/0x2e0
>>>> [=C2=A0=C2=A0 23.156066]=C2=A0 ksys_pwrite64+0x7c/0xc0
>>>> [=C2=A0=C2=A0 23.156109]=C2=A0 __arm64_sys_pwrite64+0x20/0x2c
>>>> [=C2=A0=C2=A0 23.156152]=C2=A0 invoke_syscall+0x48/0x10c
>>>> [=C2=A0=C2=A0 23.156196]=C2=A0 el0_svc_common.constprop.0+0x40/0xe0
>>>> [=C2=A0=C2=A0 23.156249]=C2=A0 do_el0_svc+0x1c/0x28
>>>> [=C2=A0=C2=A0 23.156293]=C2=A0 el0_svc+0x54/0x140
>>>> [=C2=A0=C2=A0 23.156334]=C2=A0 el0t_64_sync_handler+0x120/0x12c
>>>> [=C2=A0=C2=A0 23.156384]=C2=A0 el0t_64_sync+0x194/0x198
>>>>
>>>> I guess the locking implementation is recursive so that's why this
>>>> didn't actually deadlock...
>>>>
>>>> I'm not sure what the right way to do this is then. The underlying
>>>> reason why the fallback code is being called is that do_wp_page() call=
s
>>>> vm_normal_page(), which returns NULL for VM_PFNMAP pages. So vmf->page
>>>> is NULL and __wp_page_copy_user has to use the fallback path. However,
>>>> the reason GUP works is that follow_page_pte() and friends have a
>>>> specific fallback path for the pte_devmap() case that grabs a struct
>>>> page anyway. Maybe similar logic should be in do_wp_page() so it can
>>>> grab a struct page for PFN mappings too?
>>>
>>> There is currently WIP to remove pte_devmap() and make vm_normal_page()
>>> return these pages as well.
>>>
>>> But that would not be in VM_PFNMAP mappings, because VM_PFNMAP means
>>> "don't you ever look at the struct page".
>>>
>>> Likely, you do not have a VM_PFNMAP mapping here but instead a
>>> VM_MIXEDMAP mapping(or likely no special mapping at all)?
>>>
>>> vm_normal_page() returns NULL for pte_devmap(), independent of
>>> VM_PFNMAP, because pte_special() should succeed on them.
>>>
>>>
>>>
>>> I recall that there is still a problem with false-positives on
>>> folio_test_anon() with ZONE_DEVICE pages, so it's maybe not that
>>> easy ... and the whole get_dev_pagemap() stuff is nasty.

Specifically FS DAX reuses PAGE_MAPPING_ANON in
include/linux/page-flags.h

    /*
     * Different with flags above, this flag is used only for fsdax mode.  =
It
     * indicates that this page->mapping is now under reflink case.
     */
    #define PAGE_MAPPING_DAX_SHARED	((void *)0x1)

FS DAX pages are never anon though, so you could probably test for
!vma_is_dax() and/or add an implementation of is_fsdax_page().

>>> Likely we would have to do what GUP does, and temporarily grab a pgmap
>>> reference. Gah.
>>>
>>>
>>> So if we sort out the pagemap stuff and the possibly wrong
>>> folio_test_anon() on some ZONE_DEVICE pages (but not all, because IIRC
>>> DEVICE_PRIVATE can be anon ...), it might be doable.

Correct, DEVICE_PRIVATE and DEVICE_COHERENT pages are always anon (at
least for now).

>>> But it sounds ugly, especially because that code might change soon and
>>> not require messing with ZONE_DEVICE pages on that level.

Yes, I'm hopoing to get the next version of that series posted this
week. I found a couple of other FS DAX bugs that slowed me down.

 - Alistair

>>> And then, we'd not be able to handle VM_PFNMAP cleanly ...
>>>
>>>
>>> Maybe we could test if the PFN has a directmap and simply read using
>>> that? I mean, that's what kmap_local_page() ends up doing on systems
>>> without highmem ... and without !defined(HASHED_PAGE_VIRTUAL) && !
>>> defined(WANT_PAGE_VIRTUAL) the kmap_local_page() really just is a
>>> page_to_virt(), which is mostly mapping a PFN to the corresponding
>>> virtual address ...
>>>
>>> But it doesn't universally work ...
>>>
>>>>
>>>> Or if the problem is just the lock, would just eliding the locking wor=
k?
>>>> I guess that only works if all the calls into wp_page_copy() are
>>>> guaranteed to hold the mmap lock already, but I don't know if that is
>>>> true...
>>>
>>> The whole "GUP recursively calling into GUP" code looks concerning.
>>> Could we even trigger a case where we get a recursive page fault handle=
r
>>> call, because of some odd race? (concurrent MADV_DONTNEED or similar)
>>>
>>> I think we should much rather fail this remote fault if there is no eas=
y
>>> way to make it work right now.
>>>
>>> At least I suspect this is primarily a "debugger" scenario that didn't
>>> work so far and we could leave it "not working because not supported" i=
n
>>> a nicer way?
>>>
>>>
>>> If this really must succeed, I can spend some time thinking about how t=
o
>>> do this cleaner ...
>> Well, this breaks debuggers in general on a virtiofs VM mounted with
>> DAX, which is a sensible use case I think. One reason to use DAX is
>> avoiding duplication of the page cache between the host and the guest
>> (or multiple guests).
>> I think the main reason not that many people are trying DAX across
>> the
>> board for virtiofs is various bugs that have been slowly fixed, and this
>> would be one of the remaining ones...
>> (Full disclosure: For the use case I'm working on we're no longer
>> mounting the whole rootfs with DAX right now (only a subset) since we're
>> still evaluating the performance, but I'd like to keep the option open
>> and having it break debuggers is kind of a blocker...)
>
> Thanks for the information. So it never worked and we primarily care abou=
t
> virtio-fs DAX support, not some VM_PFNMAP mappings or other DAX mappings.
>
>
> We should first fix the warning using something like:
>
> From 1ca7e9cf8067112ccaeb3c67230093d3aef8f2a3 Mon Sep 17 00:00:00 2001
> From: David Hildenbrand <david@redhat.com>
> Date: Fri, 8 Nov 2024 10:34:01 +0100
> Subject: [PATCH] mm/memory: silence warning in __wp_page_copy_user() on r=
emote
>  faults without a src page
>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/memory.c | 36 ++++++++++++++++--------------------
>  1 file changed, 16 insertions(+), 20 deletions(-)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index 209885a4134f7..720b20f71ba61 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3038,28 +3038,29 @@ static inline int pte_unmap_same(struct vm_fault =
*vmf)
>  	return same;
>  }
>  -/*
> - * Return:
> - *	0:		copied succeeded
> - *	-EHWPOISON:	copy failed due to hwpoison in source page
> - *	-EAGAIN:	copied failed (some other reason)
> - */
> -static inline int __wp_page_copy_user(struct page *dst, struct page *src=
,
> -				      struct vm_fault *vmf)
> +static inline vm_fault_t __wp_page_copy_user(struct page *dst, struct pa=
ge *src,
> +		struct vm_fault *vmf)
>  {
> -	int ret;
>  	void *kaddr;
>  	void __user *uaddr;
>  	struct vm_area_struct *vma =3D vmf->vma;
>  	struct mm_struct *mm =3D vma->vm_mm;
>  	unsigned long addr =3D vmf->address;
> +	vm_fault_t ret =3D 0;
>    	if (likely(src)) {
>  		if (copy_mc_user_highpage(dst, src, addr, vma))
> -			return -EHWPOISON;
> +			return VM_FAULT_HWPOISON;
>  		return 0;
>  	}
>  +	/*
> +	 * We cannot copy from user, so remote faults without a page are not
> +	 * supported for now.
> +	 */
> +	if (mm !=3D current->mm)
> +		return VM_FAULT_SIGSEGV;
> +
>  	/*
>  	 * If the source page was a PFN mapping, we don't have
>  	 * a "struct page" for it. We do a best-effort copy by
> @@ -3086,7 +3087,7 @@ static inline int __wp_page_copy_user(struct page *=
dst, struct page *src,
>  			 */
>  			if (vmf->pte)
>  				update_mmu_tlb(vma, addr, vmf->pte);
> -			ret =3D -EAGAIN;
> +			ret =3D VM_FAULT_RETRY;
>  			goto pte_unlock;
>  		}
>  @@ -3111,7 +3112,7 @@ static inline int __wp_page_copy_user(struct
> page *dst, struct page *src,
>  			/* The PTE changed under us, update local tlb */
>  			if (vmf->pte)
>  				update_mmu_tlb(vma, addr, vmf->pte);
> -			ret =3D -EAGAIN;
> +			ret =3D VM_FAULT_RETRY;
>  			goto pte_unlock;
>  		}
>  @@ -3130,8 +3131,6 @@ static inline int __wp_page_copy_user(struct
> page *dst, struct page *src,
>  		}
>  	}
>  -	ret =3D 0;
> -
>  pte_unlock:
>  	if (vmf->pte)
>  		pte_unmap_unlock(vmf->pte, vmf->ptl);
> @@ -3369,23 +3368,20 @@ static vm_fault_t wp_page_copy(struct vm_fault *v=
mf)
>  		goto oom;
>    	if (!pfn_is_zero) {
> -		int err;
> -
> -		err =3D __wp_page_copy_user(&new_folio->page, vmf->page, vmf);
> -		if (err) {
> +		ret =3D __wp_page_copy_user(&new_folio->page, vmf->page, vmf);
> +		if (unlikely(ret)) {
>  			/*
>  			 * COW failed, if the fault was solved by other,
>  			 * it's fine. If not, userspace would re-fault on
>  			 * the same address and we will handle the fault
>  			 * from the second attempt.
> -			 * The -EHWPOISON case will not be retried.
>  			 */
>  			folio_put(new_folio);
>  			if (old_folio)
>  				folio_put(old_folio);
>    			delayacct_wpcopy_end();
> -			return err =3D=3D -EHWPOISON ? VM_FAULT_HWPOISON : 0;
> +			return ret =3D=3D VM_FAULT_RETRY ? 0 : ret;
>  		}
>  		kmsan_copy_page_meta(&new_folio->page, vmf->page);
>  	}
> --=20
> 2.47.0
>
>
>
> For MEMORY_DEVICE_FS_DAX, we should probably wait for [1], CCing Alistair=
 and Dan.
>
> As discussed, maybe the following would work (as long as we don't get any
> folio_test_anon() false-positives on these MEMORY_DEVICE_FS_DAX), but I'm
> not quite happy about leaking these legacy MEMORY_DEVICE_FS_DAX into the
> core code, especially as it might soon no longer be necessary.
>
>
> From e84309bfa4772485b2340712d7b53a8a7ba1b0fc Mon Sep 17 00:00:00 2001
> From: David Hildenbrand <david@redhat.com>
> Date: Fri, 8 Nov 2024 10:50:42 +0100
> Subject: [PATCH] mm/memory: support legacy MEMORY_DEVICE_FS_DAX in
>  do_wp_page()
>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/memory.c | 28 +++++++++++++++++++++-------
>  1 file changed, 21 insertions(+), 7 deletions(-)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index 720b20f71ba61..b3830aba08c53 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3667,7 +3667,9 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
>  {
>  	const bool unshare =3D vmf->flags & FAULT_FLAG_UNSHARE;
>  	struct vm_area_struct *vma =3D vmf->vma;
> +	struct dev_pagemap *pgmap =3D NULL;
>  	struct folio *folio =3D NULL;
> +	vm_fault_t ret =3D 0;
>  	pte_t pte;
>    	if (likely(!unshare)) {
> @@ -3702,9 +3704,15 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
>  	}
>    	vmf->page =3D vm_normal_page(vma, vmf->address, vmf->orig_pte);
> -
> -	if (vmf->page)
> +	if (likely(vmf->page)) {
>  		folio =3D page_folio(vmf->page);
> +	} else if (pte_devmap(vmf->orig_pte)) {
> +		pgmap =3D get_dev_pagemap(pte_pfn(pte), NULL);
> +		if (pgmap) {
> +			vmf->page =3D pte_page(pte);
> +			folio =3D page_folio(vmf->page);
> +		}
> +	}
>    	/*
>  	 * Shared mapping: we are guaranteed to have VM_WRITE and
> @@ -3719,8 +3727,10 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
>  		 * Just mark the pages writable and/or call ops->pfn_mkwrite.
>  		 */
>  		if (!vmf->page)
> -			return wp_pfn_shared(vmf);
> -		return wp_page_shared(vmf, folio);
> +			ret =3D wp_pfn_shared(vmf);
> +		else
> +			ret =3D wp_page_shared(vmf, folio);
> +		goto out_pgmap;
>  	}
>    	/*
> @@ -3736,10 +3746,10 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf=
)
>  			SetPageAnonExclusive(vmf->page);
>  		if (unlikely(unshare)) {
>  			pte_unmap_unlock(vmf->pte, vmf->ptl);
> -			return 0;
> +			goto out_pgmap;
>  		}
>  		wp_page_reuse(vmf, folio);
> -		return 0;
> +		goto out_pgmap;
>  	}
>  	/*
>  	 * Ok, we need to copy. Oh, well..
> @@ -3752,7 +3762,11 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
>  	if (folio && folio_test_ksm(folio))
>  		count_vm_event(COW_KSM);
>  #endif
> -	return wp_page_copy(vmf);
> +	ret =3D wp_page_copy(vmf);
> +out_pgmap:
> +	if (unlikely(pgmap))
> +		put_dev_pagemap(pgmap);
> +	return ret;
>  }
>    static void unmap_mapping_range_vma(struct vm_area_struct *vma,
> --=20
> 2.47.0
>
>
>
> [1] https://lkml.kernel.org/r/cover.9f0e45d52f5cff58807831b6b867084d0b14b=
61c.1725941415.git-series.apopple@nvidia.com


