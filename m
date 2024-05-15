Return-Path: <linux-kernel+bounces-179812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E16898C65C3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 13:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC96D1C21245
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 11:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7016F073;
	Wed, 15 May 2024 11:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oCaeWDFO"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBC7433DC;
	Wed, 15 May 2024 11:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715772669; cv=fail; b=G3Y60bwuDUiexNq5Jv9Y32s0XYs7BnBZpUMw/Z3GSQF42EitGzhTPSLFFbKanLuLHqLhw+Y+ixGN3yvBg6Sq5do5jg2KOiP/RGIKd2UcJFGy1f3kmLpX4UTWQ2U1ZmBXkgsZ0c9Kzky9WCfbaN8oNVWFMmjpxIdinkvEffy25h4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715772669; c=relaxed/simple;
	bh=+3hNia/XDXiOlD+o3S2rrVj8PA6I2dlPB/mbcFusBHA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Iom6Sr92qmSyer5BKuY711rNGXywO4QFsx6FGwjFWuzTdxU2+fi3FEej9UWRsNHfQ/m1+sYdDiM7YZodn9ThZC1Rtj9RXknW/2dajGV+einz6djJEkRb98oKLXPS1+95g2BzSuUNPsWIrsjYp35Vj4TOmvq02AKlS63ZdVd4wLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oCaeWDFO; arc=fail smtp.client-ip=40.107.243.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FdQ43rGjRvd7UCU/CeyTUy92vIzjeNndW3PqLgTKJ8C4PcHObhfM4AmL+O/yu/Y8LrizBZyfobL8VSM5UPmuDn5AthdKnC2xscZjrmJ2/xoc3GlffiEBHJbnnLxZtx/0xFVgDW5XEoKa+EOMv1JN4WnpVTzntu4/nZLz27IJRAnIaTggGmJrJ3xLpl4Qs/u4Qy1NV4Xv4FNUt2hXWKieQBX29jvR7MzAcV7f9HfiZOVMiBRmL8J3L5j+na/BUDUF+ThQVgNcUaB01aCuwEuxmvBP8j23BiLRYVR/cLAPG7+FRW9HUfUppZ/FmfJXBm580YjRTWqQ0Aj44v2OEF3Trg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FJ5t6EZOKVkCJLxAaGW86LUg4sVpOuMr3itWthGnbF8=;
 b=LEAFDBZU92pcUW9h7x1hBsoRjcMG1FvCIFRq7kDo7Sq40LeHMHgCOktfuijgUvWOGbnuSJz0CatzeOP6hzIETpn+UoKajqYCt/bwjaRNkhkiGVToGcg8vNxNfD9cfVCijBj4gmf0QjVSma0cMXDKR6fhzYJhkM8urrEjj0qZA7HOYd4G+c6i4QeEvH+y0WQG3e7syuprE+Bq7amv1/s5wI6qmVPhp8LATSe42pz2ffuozSAI4hucl/HG6yNsxtGUxGWh2APZkpQcoEP2gXUeibmbPE/qO3ovFa5JeRELfcqAl9qrrB7dQaPUcEK8WHlVDXu2Qphh3/0FxnaoTgSvKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FJ5t6EZOKVkCJLxAaGW86LUg4sVpOuMr3itWthGnbF8=;
 b=oCaeWDFOXAfkzw6hBLMq9OcE4suXmORWLbjyRGEmVSfJ1l2m1tXzev2Zk/hORasMAImVrtLZWeBf3PBzi/qEUO9QvX1yCgoAmr6r5Gr/beIeeROZhkBPwl2QnmM98dib4GyhwzW0Pxqfu1gXBzhr6uBRjtLhJdZPBUMC17PlheI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5286.namprd12.prod.outlook.com (2603:10b6:208:31d::6)
 by CH3PR12MB7571.namprd12.prod.outlook.com (2603:10b6:610:147::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Wed, 15 May
 2024 11:31:05 +0000
Received: from BL1PR12MB5286.namprd12.prod.outlook.com
 ([fe80::295:5055:c88b:cddd]) by BL1PR12MB5286.namprd12.prod.outlook.com
 ([fe80::295:5055:c88b:cddd%5]) with mapi id 15.20.7587.025; Wed, 15 May 2024
 11:31:05 +0000
Message-ID: <269884a8-da86-4cb5-b4eb-2827578608d4@amd.com>
Date: Wed, 15 May 2024 17:00:57 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] sbrmi: Add support for APML protocols
To: Lee Jones <lee@kernel.org>, Guenter Roeck <linux@roeck-us.net>
Cc: Naveen Krishna Chatradhi <nchatrad@amd.com>, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org, Akshay Gupta <Akshay.Gupta@amd.com>,
 arnd@arndb.de, gregkh@linuxfoundation.org
References: <20240502220554.2768611-1-nchatrad@amd.com>
 <20240502220554.2768611-2-nchatrad@amd.com>
 <dd4ef0b6-8272-40b6-9a50-edbeec14d5e4@roeck-us.net>
 <8cf0d519-ae6c-4ed0-899e-899f67479052@amd.com>
 <488e8eed-e0f0-4055-b43c-5422b6302632@roeck-us.net>
 <20240515103217.GA6035@google.com>
Content-Language: en-US
From: "Chatradhi, Naveen Krishna" <naveenkrishna.chatradhi@amd.com>
In-Reply-To: <20240515103217.GA6035@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PEPF00000180.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::50) To BL1PR12MB5286.namprd12.prod.outlook.com
 (2603:10b6:208:31d::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5286:EE_|CH3PR12MB7571:EE_
X-MS-Office365-Filtering-Correlation-Id: c006c197-3464-40f0-5dbf-08dc74d281e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SEpQYU1nc1NQYk5OQzFISmlCM1NtdWxWRDhtUDhGYkZKOVpDMWJycFBTNEM4?=
 =?utf-8?B?eTFmOU5FRVptS2RFLytKTW42NUtFRDdyOUxtdjNHQ21CdkxZNHo2ckNscW9K?=
 =?utf-8?B?Tk9BbEMyVG1FNEdYRFVTZmFaT2RGelVIUEx3eGJXYWRWVitiODhEc2lzWEZq?=
 =?utf-8?B?d1NjY3dSTGFXY2UzVmh4a2RWQitzSXJSYk9VUEV5RFFEeDVKbEkzS2ZNY2kr?=
 =?utf-8?B?UE10Y3kxVnRFM1ljZlB0WU1tVlZPZS9PUjdFOEdqZ3RYUEN0VzN1OUdNQUdM?=
 =?utf-8?B?Z2FxdGZjdWorNlFrWnV3N2xvd1RLb2xwc3VrcHJOOWRGWWpSc2NGT0RGZUZl?=
 =?utf-8?B?dWJSZ0xzT2xudEpBMkF4U3lHNnVwb25ZN3pJc2ltVG9COHVVRDJlYzJ4d1Bk?=
 =?utf-8?B?ODQxRGVndTZHek9iMEE3Tkp6V1dadFlCTS9OZStUMFYweXdNakxndmNVN0pZ?=
 =?utf-8?B?L1VObTZiMGFJbFAzdmdZbGRCK2ZybHFaRnA5VytmdnBtczdGS1QxZTlNKzdp?=
 =?utf-8?B?dWx6NC9LL3BTMmxacWIvSldFWkgxR2FTUjdNdE9VcHp2ckdUVDNYTUhhNDFq?=
 =?utf-8?B?OHluc3pPR094T1h5UTBxdC9McDVyWUVkTlZXd3hyaldtbmxRM3RiejRHZThw?=
 =?utf-8?B?QlBjSWd5cjBNNytTWjhiaCtiTEl1QmNaYzE0NnBGZ1V5UGtybWd2cGgvblpI?=
 =?utf-8?B?MFBYS25rekdKNnpPS1dTWkpubEJnTEVNNC92UXJVM0ZTOGhMQkhQQzdLaWEv?=
 =?utf-8?B?S3JFak1oT1NvWS8rd0pOZENLckxRaGxXc1ZnYXRkYzh5Qi9CaFpJbTJmMEVo?=
 =?utf-8?B?NG4reFd1VDJJQ1BFbnAwWlpsNXE2bFdSdHpzajJWdEhiTXBFbFY5emtTN3Fp?=
 =?utf-8?B?QzdCTVRFS0NpblVpZnBXcEc2Rm93VnV5ZkQ2SG42Qm9qSEg5QlRpL29lQ2l1?=
 =?utf-8?B?MVJSVlZSZmFtVU50VEJpNU5xdXNLYXVPd1hKYkZzckFQUFJHbXUzQW5UK3Vo?=
 =?utf-8?B?NXo3RkRXakQ2eVB1UjZ3a1RST0VESnMvdnVxbXlOYjZJRnBWR096a1FTK05C?=
 =?utf-8?B?Z1hibmlJUTJzOUhFSlJmU0RndG5YT2czeHVBU3ZxK1JYU2FkN2l6VGthNnl3?=
 =?utf-8?B?VEVnSzdnKzZ2TkFBTEFNUTJUdkV1VWJkSlcyS0lSd0M0Snl2NkVsd0RQN1Iy?=
 =?utf-8?B?MEVPYnd6TTYxUlhEM3JsU2Y0RHgwY1hodWZ4TmpQbjBXTGtZYlg3bVhJdzJa?=
 =?utf-8?B?Z0h6Zk9DVVp1RCs1MGpjTk9qMG1vaDZVelhhT2NZL29ycXR6WmRJSkhLeHQ3?=
 =?utf-8?B?b0FRcDRIZzFua012S3pJelVSbFZVazEyOXEzUjBqc1E4SUprUUxVUDVXVVFH?=
 =?utf-8?B?QlJaM0daRjdUQ3FmS3lQVmxQWSthbkdvbXYzSFlxTHBoK3kzMFl5NzJGQ1BW?=
 =?utf-8?B?Snp4TU1VcjRrMmMrNlliRVJNOHhHMW91U0hzVENqUFVPZ0VVb0grQ29yNTlv?=
 =?utf-8?B?NEF2bGdyN05hU3Yvem43VURuK21IMFM1TnNvdzJQejV3L3N5Q0lrYmx3eWNv?=
 =?utf-8?B?SFg5eUdRZkdINjFXdC9FTXF0cENQQmZDUnp3Y2x4SzRncWg2OVNnK3drdzRI?=
 =?utf-8?B?WFJCR1Nqc3l1TVQ2cXg2OElDaFhiOXBaYzFsbnJ0QjN4RFBRL0pUMy9zUStR?=
 =?utf-8?B?QTRCV1ZDSVB2Z0l6Uk9Ya3JzaFZRd3ZaN3BmRXNQL2pHQklRNDI1ejNnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5286.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TTZNbEJmaWJ6bjZLMjJKVUplcmhFVU5xUlVvb1htYnRKTUJYTFRXYWdaWU01?=
 =?utf-8?B?Yi9iQXlkem9PZ2ZJRExKdVMrL01XZ1ByWWlucWxtVnBZa29zOEVMS2tLOHlO?=
 =?utf-8?B?M1B3RFNQZmtlS1ZRZ3FVZEZyNi9sdm9ucFJYRnZ0b1ZHUUJxMTBQNHM2YzA4?=
 =?utf-8?B?b1NiOG1VSzNNbnlDdWUwbW5IZllTZVEwTDFaQjYzQW9TbVhjOENCeTUzazVV?=
 =?utf-8?B?ZXVBVWd2N0lHaTJjK3pJQXJxb1NTU2Z3OEEyVjJhYmNvR0NMQ1lsOEM5L2Nz?=
 =?utf-8?B?ZUpIZ0VOUnlzT3lwUTdoQ0pRQXZTRnBubGFuRENiejdBRWtwWEZRcEF6OGJt?=
 =?utf-8?B?TkNBcm9pRUwzN0lVUUxYUTVMSVNvL2xzYzdkZi9sV3QxVVl5SStrT3gyWlRo?=
 =?utf-8?B?UTNKMks0WjkydC82ZmtxRGwyQlRYZFN2NURwaU05eHU2VWN0ekhPK1BCTk9v?=
 =?utf-8?B?R3RpblBJUGJ2RG5YaDNLWnRoY1ZUSGhCbzNkeUdQb0JISTZlYW9ScVhTQWVl?=
 =?utf-8?B?MUJqQ3ppeUZGUHdkcWhIOHd6eU5uQ0NTWm5jc3VkMW1GeDZiczV5VkkrS1VN?=
 =?utf-8?B?Z2syREgxZTBrSzM0MFkvVDlSdEpKRTFBdTRFUkVIaUtzVmhmVHpUbmJnSEw4?=
 =?utf-8?B?RGhKVjFjdXZvOThqOHJhSWhland6aHdva2pmU0xmbGVWZk50WDZlV25zdVRn?=
 =?utf-8?B?WGd3ZU84eDN6L0plTnptNG1CaEhDNkNyVXQyRzJGZkZCNXI1ZE05NUd4OXdw?=
 =?utf-8?B?NHRDQVAxckJZOGZROWJtSDJCaXdrelVscmFiK0FPdmJHRUtTd3YxUG0xZVBL?=
 =?utf-8?B?ZkF5RlB5YktCd213bDljMHI4QnUyT2JZKzhXRkxMUzRudW5Dc3hZRWZTODlX?=
 =?utf-8?B?NGUzMzc2dTBOaSt5MTZOU0NIRDJwWjBwR0ZYc3NZa3dLRWc1QWNveERzempx?=
 =?utf-8?B?Y2JDUGJzL0o1UmFRT1lTS01mMEhWaTYwT1VjSVB5bzl3Vk1RVFUzYUlpUGFO?=
 =?utf-8?B?c2cyQm5oNnZNdjhWMTQ2Vk15RFUxK0c3NUhaczVPbkZaMm44R2x0OXhiZkFB?=
 =?utf-8?B?UXdYeFhuTStxWFFFTHZkRnNicUZWSFYvSitGS3Y3WDU3NFNDYml3M24vZG9G?=
 =?utf-8?B?eWNCY0wxbk5kTmNFRXN6QXBiWUh0aTNEOTAySElqbStvaHZpdmdwOFJMMzNw?=
 =?utf-8?B?UnF2NVlveElYVnRRR1Z6a0N1d1VjY0FmRU1Pdjh4WFYxRDh2aTB0elc5NC9Y?=
 =?utf-8?B?WVZuY2QzaFB5ZHR4M1BhcmRjanFVdHM5ZXV4YWR2Q05ERVVrYVZxMkFWTHVY?=
 =?utf-8?B?TW41UGFDciswWEg0bzZuSU91bmtqby9QNEN4eWV4RGgxaExDcGdBUkxrTk0y?=
 =?utf-8?B?bFJVYlRXNDdLMnNVTkdNbjgrUTJPMXdkL3kwYnBBSkRyZ1drMkpDWmx1S3dy?=
 =?utf-8?B?amk4aVZyaVdmMURzTHRzY01WTUFoYVZuMXNjREt2REZONml3L0FpdkJ0Wkla?=
 =?utf-8?B?Nyt4YldSZHAzOXRVU2wxZk5DY3pyNVk0M3JsTmM0VURxVkpoSGNleFZHKzBw?=
 =?utf-8?B?dFVXdVFEdXZGWVVaUzdEeTBIZWZXdko1UWt6OVRIZTZWbFh4Y09TRmJNWmN4?=
 =?utf-8?B?RERhdGFkSlJ1Zk5JT09INEtkazFlMlIweEhrZitiL3lNRk5PWktjM2R4TlFS?=
 =?utf-8?B?WWVrTVhXNW9mcVZtWElqYzNNeitQYU5lT2xjMVBweiszd2R6K0Z5bU5lS2Rk?=
 =?utf-8?B?bkNNc29RMkYvTVc4dlpTTEhlVERqWlkwZlZuOWlYWllKVHE5SDQ1WTBaMWI0?=
 =?utf-8?B?Y2JibW5Hd2lueDd3TCs2MUhtdUxQRDR2WHp5cExHNmJwUDF4enp2OGpXbzdy?=
 =?utf-8?B?SHF5ZzFZRzROQW5ZRUU1aHFmSHpUSTBQZ081b2FCaTNTcWtad2QzS21EMEFO?=
 =?utf-8?B?YU5TM1c2S3NMYTlDNGtTekpQZXBKZEZVVnVnaFcxdFg4bWY4dUZNTytkT2x5?=
 =?utf-8?B?Tm9MSHV1MW1jenZsUUNMdjFWZ1JUSkpJcGs3RU1NY3BzR3dwYXdrSWFxTE1x?=
 =?utf-8?B?WmxNZkVkamdGd1NOWS9MWkc4UkZIN01HNWt3dVRpaU1kcWQ5NVcxdVo4cmRP?=
 =?utf-8?Q?UW6Cs/tjxwl1+Bwe0DJgdj1j2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c006c197-3464-40f0-5dbf-08dc74d281e2
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5286.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2024 11:31:05.4094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 78CBtMeduirvqKyQXfvDC551jEYzKooJ9PmGBDprndTx0qUpFB/UsfdECQXq2YGrAemx4EMVDiYWfWGzuLPidg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7571


On 5/15/2024 4:02 PM, Lee Jones wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>
>
> On Tue, 14 May 2024, Guenter Roeck wrote:
>
>> On 5/14/24 12:15, Chatradhi, Naveen Krishna wrote:
>>> + @Misc and @MFD maintainers in CC
>>>
>>> Hi
>>>
>>> On 5/3/2024 3:56 AM, Guenter Roeck wrote:
>>>> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>>>>
>>>>
>>>> On 5/2/24 15:05, Naveen Krishna Chatradhi wrote:
>>>>> From: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
>>>>>
>>>>> The present sbrmi module only support reporting power. However, AMD data
>>>>> center processors support various system management functionality
>>>>> Out-of-band over Advanced Platform Management Link APML.
>>>>>
>>>>> Register a miscdevice, which creates a device /dev/sbrmiX with an IOCTL
>>>>> interface for the user space to invoke the following protocols.
>>>>>     - Mailbox read/write (already defined in sbrmi_mailbox_xfer())
>>>>>     - CPUID read
>>>>>     - MCAMSR read
>>>>>
>>>> This is not hardware monitoring functionality and would have to reside
>>>> elsewhere, outside the hwmon subsystem.
>>> I thought as much, please provide your opinion on the following approach.
>>>
>>> Background: Present sbrmi under hwmon subsystem is probed as an i2c driver and reports power.
>>>
>>> However, APML interface defines few other protocols to support OOB system management functionality.
>>>
>>> As adding the core functionality of the APML interface in drivers/hwmon/sbrmi is not the correct approach.
>>>
>>> We would like do the following
>>>
>>> 1. Move the i2c client probe, misc device registration and rmi_mailbox_xfer() function to a drivers/misc.
>>>
>>> 2. Add an MFD device with a cell, which probes the hwmon/sbrmi and continues to report power using the symbols exported by the misc/sbrmi.
>>>
>> afaik mfd API function must not be used outside drivers/mfd. The mfd maintainer
>> is (or at least used to be) pretty strict on that. The core code of a
>> multi-function device might better be implemented in drivers/mfd, with
>> drivers in drivers/misc (for the misc device) and drivers/hwmon/ (for
>> hwmon functionality). The misc and hwmon drivers could then communicate
>> with the core using regmap.

Thanks Guenter, for the inputs.

> Yes, please only use the MFD API from drivers/mfd.
>
> There are 'offenders' that slipped by me, but in general if you need to
> create an MFD then it should be located in the MFD subsystem.
Thanks Lee, how about

1. Move the i2c client probe, misc device registration and rmi_mailbox_xfer() function from existing hwmon/sbrmi.c to a drivers/mfd (Instead of drivers/misc)

    a. Provide an ioctl interface through misc device node /dev/sbrmiX for the user space to invoke the following protocols.
      - Mailbox xfer (already defined in sbrmi_mailbox_xfer())
      - CPUID access
      - MCAMSR access

2. Add an MFD device with a cell, which probes the hwmon/sbrmi and continues to report power using the symbols exported by the mfd/sbrmi.

>
>> drivers/mailbox/ supports mailbox style communication. I don't know if that
>> would apply to the mailbox functionality implemented here.
I've explored that path, and APML mailbox does not fit well into the 
design, we do not have a dedicated interrupt line as well.
> --
> Lee Jones [李琼斯]

regards,

Naveenk
>

