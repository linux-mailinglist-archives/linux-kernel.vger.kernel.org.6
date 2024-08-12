Return-Path: <linux-kernel+bounces-282869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F39194E9D6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 11:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 558C41F22993
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 09:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03AC116A954;
	Mon, 12 Aug 2024 09:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="guBijkpp"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63759139CFE
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 09:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723455138; cv=fail; b=mLOm4//8m1ThONBcN6wGadWsa5ON6bxS+aOk63hAicTdSbyHXIU2ZEgTVjsx+OrqgrXJovdB9Vq4YJpHkS06bAr+jjkl76nvsUFGl/bnhLEo/ZD66dnpFK2xOWhUkaDMXdu4beEXyc3XatdrlOe3UehY9dNeHiG6VEUn/jh3G1Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723455138; c=relaxed/simple;
	bh=IDzYU5a46iLg7zGyVZmWe57/h/vUHq8An5TvNLhJo/o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aFF1HSj1Frh4VYpSsfZtFGvqOR59i1GFejokT/gojysKXTRoVDUKcwx8WknYDO9VOxuohBZorsICupJI/j3ibWaY8ZwZmiYmQAyrvVmp5gVW1SxkAIhbWXjWRqrtmekgsSkBJvhZKm9tTsNQwr+OA8ucGLfknO+sdixrozECl/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=guBijkpp; arc=fail smtp.client-ip=40.107.94.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YyH1rC+qVSasI7eRWLgihwdaj36s+CKEQnlvJXrseBFW5yPIwZYneSdbGRscVOORw7yGTzYNdkj1qsrAAdcHHDnmKF5m2PhijGob3cWcGlpTZf+O/rGAx4nQ6wCrfwjCMiOcnwoyoya0D29uhyrtLX4RMAwHu2PdZZRZXenf7CqPWZXU5pDI4gib1k1QfiGKHC8HsmDbbTLegGksfWWX5dSKzTF0q2fat4v1aSeor4WVED06DcIW+oWAeXwQRYjey6YVOphlHQqpwjnVotXrkpIu25vP8vJ3pUbVidOdR/LDyvP0RoCTjhWMaiK1wG68zB11mbZR4bHSHpbkSrEfKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Quhn0C/fd5ech1bq0PBZaJheo4/gC4RfybUbs8owSfE=;
 b=c0HbJ6fcYQnwKSp7tbr3iIoPAIhE5UX5hYHUxUURoAgKkBPfV9hZWpE5rPtS9sgqfCRBJ8Mma/d7lqaKckOB1gStoPinz0onSuOE9B85NL5bFb7k3f5bOecyGk4MJCW4Aaj3ToHSmxROuKv1qPodVur9R1nAXalOjwHN6WoeWlJvFRqH6vM1pCfdERzmn83LgNnm+zk8AqvNZ22QyeUoY7zEtKhPHi5DFC3pZT1bISZBEK6BhQUrnotWsGyZtezlRUDK6NV+vCuMwoPfLJ+OG3HiupIaH0KxvGqarrBgIpL52RI49cUzVigZUdPEsBoYVDL+z/ZVdQK8GLd1eZJMtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Quhn0C/fd5ech1bq0PBZaJheo4/gC4RfybUbs8owSfE=;
 b=guBijkppO4blCmSn2bo2PpaTB9zyf1ycgdTt/yDaYN2o71/lHqim+kQMeVHuNEKhZaq/zi5lfkoFMElID8OFYjPZHws6peuLBipr5H5YpK+RUqYYDdrWFx7Yx0Z5fpY6LQtXw/NNojtmEGSrGE40RKkNgRQioPFPi5zXokfhy84=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5176.namprd12.prod.outlook.com (2603:10b6:208:311::19)
 by PH7PR12MB6419.namprd12.prod.outlook.com (2603:10b6:510:1fd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Mon, 12 Aug
 2024 09:32:13 +0000
Received: from BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::ed5b:dd2f:995a:bcf4]) by BL1PR12MB5176.namprd12.prod.outlook.com
 ([fe80::ed5b:dd2f:995a:bcf4%4]) with mapi id 15.20.7849.021; Mon, 12 Aug 2024
 09:32:13 +0000
Message-ID: <d0ca0a49-311e-4af3-95df-f7c6f85e184f@amd.com>
Date: Mon, 12 Aug 2024 15:02:03 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v3 3/6] i3c: mipi-i3c-hci: Add a quirk to set PIO
 mode
Content-Language: en-US
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Guruvendra Punugupati <Guruvendra.Punugupati@amd.com>,
 Krishnamoorthi M <krishnamoorthi.m@amd.com>, linux-i3c@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240807052359.290046-1-Shyam-sundar.S-k@amd.com>
 <20240807052359.290046-4-Shyam-sundar.S-k@amd.com>
 <2a9f6c23-9c7b-496b-9998-ea0afe526b46@linux.intel.com>
 <94e789ab-2e64-4a6e-804f-b5e7b2a952cb@amd.com>
 <0ae18e57-ef79-4fd8-9e9a-4c57b480b267@linux.intel.com>
From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
In-Reply-To: <0ae18e57-ef79-4fd8-9e9a-4c57b480b267@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BMXP287CA0015.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::32) To BL1PR12MB5176.namprd12.prod.outlook.com
 (2603:10b6:208:311::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5176:EE_|PH7PR12MB6419:EE_
X-MS-Office365-Filtering-Correlation-Id: 103d7201-f0d3-408e-47ea-08dcbab1a572
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?akFqbVllM1BCakpMejlHVmZERHk4RHlPTHl6QW5makt3TmZUUGNCSk56ZTBE?=
 =?utf-8?B?MUZkTllUamN3RXJXTUx3WlhTdGFmc3cyajFsb1g1c0ozNHVDYk9oUk5rUVhS?=
 =?utf-8?B?TXZ0aDNuSGM2UjVIdTY5ZlhDTit0b2JaSVVvNjl4OU5mUFZpUEQvWnZVZHlv?=
 =?utf-8?B?SmtZWVFUTktMYk03aTVVOTNJeXBNSFdEUEtPb01xY3hhNS9XWUZ1bFU0YTNQ?=
 =?utf-8?B?YStGWCtkaHRyV3BrVTdPOUYzQ0ZEaTg3K3gzNkVVeVUrVDZkYVhHRWpEMDhM?=
 =?utf-8?B?VDVmdXhQMGthUFQydlVIamZXNVhpa2hPMjQ3Z0NkY2RTTFpiY25GTWVPclJU?=
 =?utf-8?B?aUtDRjEzYmJlZDArNllkMWlYVmJyUkxhYjJyUlh4MTZneUMrc0EwU09xZ3g5?=
 =?utf-8?B?ZG42ckJlVld6bTV5QUU5UWlLMk84dGJXZjY2MGMzUkNpTlBVTjlnaHBlQzRO?=
 =?utf-8?B?RjIxMzNpZUR6UjZTTUtlMzJXR09ZMUc1Tm1VZjFzeVpGNnhndi95ek9CR3N4?=
 =?utf-8?B?SXkxWTRleFVHOHpxSytwSEwwN1d0b21BV3VqT094WWZsYWhCTHErMnJjbXYr?=
 =?utf-8?B?NDN0ZjhQUkFOcXNma3dzbDFDemVhRFlUekVrVm8vcFdHcC9WRFVpTDRobi9S?=
 =?utf-8?B?bDJpeXNnZmFML3RQYmltMDhoTys2a3I1aFdqc2Ixb2lzUzF2YUswczlENDdF?=
 =?utf-8?B?eHp0Y2ZrMGU2cTZRZGhNM2VBb2lXVExKNENYNmFSZTVKMThJZW1Yc2sxcUJP?=
 =?utf-8?B?dWFkanYwS0NSQXBQTzJ3Y2J4bFZnQTR1akh0UnJoYzNHZjZmeHJyVWdOUk10?=
 =?utf-8?B?dHA1Q0tnbGZRWGJZQkFDUFFoWmRsS0dFQzVNY2ZCR3RuWER0NmZNUzlPcEdB?=
 =?utf-8?B?ejQ2VWtFMk1KV0xJUDFrL1FvYWsxdEFYclZ6UGYvUFZRekVWTmxzanc5UVNv?=
 =?utf-8?B?NEhSTVljSFZMemJrWGRZT3FoY0VBbWZLL3ZDSUtuY0NCL2VobUxHYzNWYmpN?=
 =?utf-8?B?SzlNS1ZIbGMzdFFmU3BWdjhjdjNkNGg0MWx3U1BqakZNRGlUZnNXbTAxK0lB?=
 =?utf-8?B?ZFJOSWRYWXduNWJMRHBqZGV6a3g3WFh6Wk9SamJiL29wUnY4aXBRUGQvdkVi?=
 =?utf-8?B?UytnN2Vqd1NUcnk5MW9jM1JzdU9jN2VwUEFXMTNwV0dKL05QVDdGdlVnQUpz?=
 =?utf-8?B?ejF3M2VrUnpKT0tvN0tMTHhyRnl5NGYzUDdwZlI3Yk9pM0NjUlAvTVgzLzls?=
 =?utf-8?B?Nk1TL1FqYkczZ1BoTzF5YVNRcVdGZTMwZ1RXSlJDNENzWEIxQjlTM3lHUHJp?=
 =?utf-8?B?cTRJeGdOZVdZc1JqOFNJbzhRTjJWQzhOSWJEa0UvU1E2R2cyL09PMzdnb2ox?=
 =?utf-8?B?cVZVLzl6TnBwN0F6b0kydjhPby8wRXc5VHlQN2JvVlRWaDBXWVNpNUhFdy9u?=
 =?utf-8?B?ZXN5SnlSU1FPc0tnZkN4RUFBdVN1eGZoZEltdUFhRkZDY1g2cmx4OWUydDdl?=
 =?utf-8?B?V2pPbG1ZN1NKbUJGY0hicVFYaG5jdjByenlLZlFmSFVhYTI3bHlkTE5MK0pP?=
 =?utf-8?B?T1IrVnlNRGUyKzRjd2VNT2lyaG5qQVBuREMyazFrT1VGVUt6cUdpTXlncml1?=
 =?utf-8?B?TUtwN1pGbXFiKzQwVEYxS0tpZUFNYzhnSHBtZ0U2cUh3aUtabm5uYUFZSkY5?=
 =?utf-8?B?ZGpiRXBCbVpDMXp2WVh1WWI3djdrNG9WL1F5NDR5YUtiZ2JVdGNmcW1MREV5?=
 =?utf-8?B?SlNVRGhEL0k3NUF4VVUrdG52TmVrei9JTGJhenNZRktzK1pHTjJ0aWdxbTgr?=
 =?utf-8?B?cFM1NndBZEZldllNVDVBdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eDJ5SWxIelBwK2laY2JjRWJpOVhCeEJkVE1kVUlTbnQzalh4MEFPQXVRN1hP?=
 =?utf-8?B?UUZmaXYyTUVMRjF0RHJESTRwa0xtZ21XT21abVBmeS9kelh5c1NQbUFtL1Bw?=
 =?utf-8?B?R2l3Z1R0THFiRWhHRi8zeEFpRFh3SDdyNXlnRFN1UitZdmdjR3JUb1FOcENB?=
 =?utf-8?B?cCtqb1JkbTNaWGhKbzJwMXlKWnc3VnVjRWRtY2lHNURJbzU2SDB3OG05YVhK?=
 =?utf-8?B?Mm5TSEY4VEhUS2tKOVRMVEczL21iNlVHeXRtckpnSjMrb3gxTFM4N0dCckpB?=
 =?utf-8?B?RkozS3dBRUN6MnY0U3dDbzFNOHlKSVVVNWg0RTZHSUNIc2pidksvN3lhVERU?=
 =?utf-8?B?Q0lObUlFTUpnU3hWNFhCaDJVOW1hUE0yVksrY2d1WGtQZlcvenVKVGxoam5p?=
 =?utf-8?B?ZGpPRmpVYkFSaW5yQVlxUTlzQ2RKTFZYeVpTQWRRNlZXaDIwSEZHMXc4VWVG?=
 =?utf-8?B?aWRhd1pRK3ZNTEVvaG1XREpNa3dsNzNhL2JxQkc4a1RiN3QxRU9PcXUrUXFx?=
 =?utf-8?B?STJIcnpzQmhFWG5LamtVWlhJU0VUOGMwOHNicUsyZ2NBMG5MREt5RS91QVFL?=
 =?utf-8?B?TkdQa2hubm9rMkYyT0h1ajEzOUZ0Y0ZpaWtzdkpHVm51Z2lVcmpMRlYwKzc3?=
 =?utf-8?B?RnptUFVDMzEzTEhPMmZacXRDSVQyY3pKemp4R0JOSnY4TnM0YnkxNHJoeGNI?=
 =?utf-8?B?Y3dNemlzVlh5WVdIVXpYSVY1UGpaY0dmUGx4VXBBQzNaeFBhV1BrN0hkZFVU?=
 =?utf-8?B?a0grWkhxZVlveThuYXlXeXJ4ZG9WcUVIRGgrNytCVGVFbXIrRnFybzRGL1By?=
 =?utf-8?B?RWQwemFxWm93RGp2WUJtYllaUkc0dDRiY2xMUjUwYmZWajVtZTJhYkd1eVZW?=
 =?utf-8?B?aDNIUEZzUG5yZng3UmY4UUNla2hkZzdZeGs5V3JDMkl3bGRmWityU1lYcGNy?=
 =?utf-8?B?cDcyOUNmaXpmVVRzNllxNUg3dkR2alhOdmg1MDJQNERhMUErNnhzK3NFSmJS?=
 =?utf-8?B?WnYwR2ZmNjA5UW5jQjVHa2VWSk1vZWkvWFVabHF3MEEzR3hDdk14KzROc0Rr?=
 =?utf-8?B?NW9uRVVOV1VRQlllQVdpaDY2K1llMlIwN1dtMXBlMTkxVDhKVVFTUW9NZGxI?=
 =?utf-8?B?L2FoZmJaSTBjZGpxcnN3N3I5YXVqb3pLdWNxUGNDaC93dmJWRmlNbkRoSnJz?=
 =?utf-8?B?ZGF6TWVEWHZlK2R0bHBlSml4eE5RdnZRdzBZTXZSMHRVbzY2QXFvZmIxV29r?=
 =?utf-8?B?bGhjNTFaMUpzbkJ6UEdoUEsrZjVKWDUyRnFIYkVBaEhoU0FuWG4vT2MwK05u?=
 =?utf-8?B?dml4bkRheTFkUnJSWmFpbk5QRFRRZHRTamlhcDVWNHVZUGh6VjFJMjhRWDUz?=
 =?utf-8?B?akppU0NyUXFlcFhkS1JzVC9YUTMwSnp3Y3ROb2JrNGc2Mys0KzBmK2k2Q1hp?=
 =?utf-8?B?SGd0d28ybFlkSy9DbFlzZStEaHdmSkVLRklubHdNY2hxZHFuZ1N6RGxCUS9S?=
 =?utf-8?B?a3RPWVJGeWxaZ2d3b2dMdU9nNWVRWEJ5RmVOMDNmMGE4VTlJZkthb0NmenFx?=
 =?utf-8?B?YmoyUkJncTVQWm52Vll2Q1NTZFdpNXZ3SmtpbUVoYXhIMEJOeXh2Um1GcTRU?=
 =?utf-8?B?MDVHM2E3dStxSjF2RDRPMWE3T0E3T044MWh3d0tYMmpZZXA3MWRWM0FHbFNi?=
 =?utf-8?B?bEpRSkFDMkZ1ZVNhaGx0NW16d29aYmZ1VldnSy9ZVzRmSitUMzhualFFQlYr?=
 =?utf-8?B?eTZtOWxib2E1czJiRXBBd2FQT1pUV28vOVBIeGhEK2ZsTG5oWFVIVlM1bVRG?=
 =?utf-8?B?Q3dPN3ArendFTWo4YU1ONWRIVTEvUGp1K1NGMDZPYzdZbjlZeEUzQUg5dFk3?=
 =?utf-8?B?VGlMTkNsaXBLUXh3N2J5V1NWWHlrWlg1bEhJUmlNaTM4K0pabjlmamxJUjFp?=
 =?utf-8?B?TzhSWFRjMmlZWVg5NUV3R0x5dEd3NWJva1pTelFCbm9nMi8rT2xaaklYN3pa?=
 =?utf-8?B?cnVmcUhLT1dIckpDeiswNXJxY0ljMDlNTFVkdExsRU9nYXdOTXR0ZG5Bd2hj?=
 =?utf-8?B?OW95OGtKNEFES1c0ank2TnpraForTWoweHQzNFhoNFc1alM3MkJEVGZzTFlK?=
 =?utf-8?Q?c3tWlRaRuFLXuiHAf30z4P0Ut?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 103d7201-f0d3-408e-47ea-08dcbab1a572
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2024 09:32:13.0303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7TbsYn1r3hk95tGoyqlw36zuDHGyLHqR3gOSTiKxoKpSyJbdnVeHLhuTA4uhQVM+U/YzXWth3QwmXsPceEFJgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6419

Hi,

On 8/12/2024 14:47, Jarkko Nikula wrote:
> Hi
> 
> On 8/9/24 6:44 PM, Shyam Sundar S K wrote:
>>> I was thinking these quirks can be passed as driver_data more cleanly
>>> and be specific only to affected HW if AMD HW would have an unique
>>> ACPI ID for each HW version.
>>>
>>> Above X86_VENDOR_AMD might be too generic if and when quirks are fixed
>>> in the future HW :-)
>>>
>>> So something like:
>>>
>>> static const struct acpi_device_id i3c_hci_acpi_match[] = {
>>>      {"AMDI1234", HCI_QUIRK_PIO_MODE | HCI_QUIRK_OD_PP_TIMING |
>>> HCI_QUIRK_RESP_BUF_THLD},
>>>      {}
>>> };
>>>
>>> and set them in the i3c_hci_probe() as:
>>>
>>> hci->quirks = (unsigned long)device_get_match_data(&pdev->dev);
>>
>> Nice idea. But only problem is that MSFT wants to have the same ACPI
>> ID present in the specification.
>>
>> I have replied to Andy on patch 1/6. Can you please put your remarks
>> there?
>>
> Well this is implementation detail later in the series and I found it
> better to focus ACPI ID discussion in 1/6.
> 
>> Yeah, agreed that having X86_VENDOR_AMD is too generic, but felt its
>> good to have additional checks only after the HW is fixed, rather than
>> being speculative now.. :-)
>>
>> What would you advise?
>> Most probably there will be future HW with either exactly same set of 
> quirks, reduced quirks or new quirks and X86_VENDOR_AMD test will work
> only with the first case :-)

I can add an additional check with the CPU ID and distinguish them(so
the quirk gets applied to the affected HW versions) and just not
restrict to X86_VENDOR_AMD, would that be fine with you?

OTOH, Since these are quirks (where its a broken hardware problems)
and the idea you suggested is related to driver data (where driver
data is meant to store private information about the device)

static const struct acpi_device_id i3c_hci_acpi_match[] = {
     {"AMDI1234", HCI_QUIRK_PIO_MODE | HCI_QUIRK_OD_PP_TIMING |
HCI_QUIRK_RESP_BUF_THLD},
     {}
};

does that not conflict? quirk vs driver data?

I am OK to implement it the way you prefer :-)

Thanks,
Shyam




