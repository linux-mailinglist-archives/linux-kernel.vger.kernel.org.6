Return-Path: <linux-kernel+bounces-390845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0459F9B7F0E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 16:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D8E12817E0
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 15:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B42991AA78A;
	Thu, 31 Oct 2024 15:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xAL/gbG+"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD8D136664;
	Thu, 31 Oct 2024 15:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730389886; cv=fail; b=ZZB5WrKla45MVsGnS0hL9ac03V/7WC74kKC/FBgRkaPQMXfXFs7aRkKcz+gCFU5WnGvHDJ7qAzaO7szp0zi7+QkNN61Zj+jW8GQpt6l6BZgsbufqsCwEFKbRSYaL0ZeYU2lzK/e50k+1yeyXDOiseXhXp2jySUJ5P/3ToBywi6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730389886; c=relaxed/simple;
	bh=H7D9iAEAz6TusxfFi1O6Xd6T6HgaPfEDOTGjpsWNl3Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=a+1z0DZBl4QCf6iPTrJa42ad3iuc0pfdOGXWq/tycnbiAlX2neu5Hnz9jg/8c0H0P7TaIiQ9LPPdLsU/DrJqDXwqrU1cFPUNSt7MsnrOTigAW4KmiM2d5I7CarxbLxg7CJF9mkIv+45ol8GDss8+6F+EbpWMskq+eVFbFMlznZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xAL/gbG+; arc=fail smtp.client-ip=40.107.220.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iEAQ2J0PMscWJLXwY1JCPos2jYw7qaCH3TtQNIRwMcpnpiKjarE33y1Bxzp0jxo2oxc93U2xsF6/YVG4vIVBI2zrmIML51zRUN/LGJPKkm+zS2Ukkkg4rlcd8kKogT1fxfGZjQFtMPyYYSZO9SJYmXJLjjNf7H9yQh5GRzkFESkjD2iIViqfPd7i++FYWLTcV40+avOHZkjL2iX5fX422gzO1aypC0U8FKcm44+Ep0IpSGP655H0r4aK1CgO8jpDdf9PCaERV0/52ThntLn6uLw9rFGSoNyzjvs51/nHLPvM8fXfsMteldtgDrmSl2PjJnRZ5icMOCr6bBnydYiM/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BdlfjdrE178eUu1M65yFykoPvlmDhW9q78bx4aLA/pg=;
 b=eesyn/t72gl0C1kGrTeZD3eTKsw8Yli7iC550kSgiXc5JE702ak10GE5uoZSumK642EGZaB0rLKPV2qMZ99vTTKhigBXg4F6fFK5Y+JtPcFnVbGpCJo6Dci9Thed7AsIWlCIyH3MCT8NeuvdlJYOI64iKqXcdiAnZ2B6BEpYsYC3q31X6AogXty52FbmVvgHi4xCpyZrezVD45x2LQscXDsnb/GhvF82P4gIrelQTtScYyaMNdJabanDA7ePagnO1Awsmn4axrj8BHFgdHJpyqHSe6IyhRn8fknRF7ARWpaX5xRCsNeWj2Ey4/285DlIQIPRm4ir2GhQVdbWNYUJEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BdlfjdrE178eUu1M65yFykoPvlmDhW9q78bx4aLA/pg=;
 b=xAL/gbG+RXHWZ+kYtFBFBSkRmtGl/O62x5w/mfoOuYb3wIEVzXfvT/N2t6TCB4xM08ZKT2sQVdB7lIXwxETDtyr7VJt+SQ/+pMYRW7pQ79htV+1IWxGw2f9EGdHAtk4v/3sIrdOl+l8EJJVIPyFaYaig1p7ATToaXV4OXqTAFOU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by IA0PR12MB7721.namprd12.prod.outlook.com (2603:10b6:208:433::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Thu, 31 Oct
 2024 15:51:20 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8114.015; Thu, 31 Oct 2024
 15:51:20 +0000
Message-ID: <0e4d68a3-2e27-4fb8-af07-e11ae6b844dc@amd.com>
Date: Thu, 31 Oct 2024 10:51:17 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dell-smbios-base: Extends support to Alienware
 products
To: Kurt Borja <kuurtb@gmail.com>
Cc: Dell.Client.Kernel@dell.com, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org,
 pali@kernel.org, platform-driver-x86@vger.kernel.org, w_armin@gmx.de
References: <20241031154023.6149-2-kuurtb@gmail.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20241031154023.6149-2-kuurtb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0138.namprd13.prod.outlook.com
 (2603:10b6:806:27::23) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|IA0PR12MB7721:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e1b445a-615c-49ea-b899-08dcf9c3dd15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SUFzRTZ3YlpiT1MwRzVnZHZnWVV5VjNEM0NzcmxPL210TnNUQ0dyL0V2VThC?=
 =?utf-8?B?dHJ3V1B4OGRjcHh4U0MxalViOVZZZmQ2WFhkUkJxRWVEcHJESnAwU3NlWFFD?=
 =?utf-8?B?T1p4VmZnOS91Qi9ZUjZOVUdFaDA0SkNjYm5aT2drRWFDZTdiZUk4a3VIZWJL?=
 =?utf-8?B?TkxxRWpGUFUwWjBxU1grWFN6NnRQanpmQmNBbEV4ampmYzNNT3pKZjhIT2lW?=
 =?utf-8?B?V1EvNDEzRTNYNjRjOTg2QlhnSzExZzAwZ3NFNVRMM3NuNGFFaERzMU12clc4?=
 =?utf-8?B?S3pXUzAvdFFRTDZCVERsU1MzdWt2OGVZU3FjZnV1U0ZyZU1ZNXJzbHJUNTV3?=
 =?utf-8?B?NEg4UzEvWWdmMGwvS3gxdE9yTWkyOGY0TFFyT0tGSjZQRE1VMHFKaHgrY2xL?=
 =?utf-8?B?TnVYMWtGZFlpUzRSRGMrY0ZiUytRRWcxVFZyTkpFRDhicVJxekIxcWxlN1hi?=
 =?utf-8?B?MXNYRElUQ3dEMWZEZXc2cXhlbXFOMW9DN1RQNDF2RzNadWVxUG1nYnBkQk8v?=
 =?utf-8?B?UzRkcVZITFlGQXlJdURPM0g3UE1ZSUhaeFEzcXNYbUk1b3NlelFZRTFiSVlW?=
 =?utf-8?B?VTJQZ0F3dDRsUW9rRklDeEhndUl6ZkxXVis2M0hqZkMzZllVWld4dzdHd3Fn?=
 =?utf-8?B?dExtTmpEaXl5U0oxS0xXWG14T1B1YjljQ0hJc0dSc3JxNzF5LzRiQUt5WlBh?=
 =?utf-8?B?NnZqQnJPZE1rQU91Wm1xK3lOVUl2T1BXK1VBS0lGcFMxODBoQ3VWUTR2ZGNR?=
 =?utf-8?B?REpkUnZVcUhhenp5V0xGamU2U29IdnJIQXZRRS9oVWpMVm8raVNZYVBXajY4?=
 =?utf-8?B?YXdtY2FPYmJ2bUEzemZrME5UZWlvcXEyRFpHR3JoUDdaYnFFTnlwa3c0Njg4?=
 =?utf-8?B?eUVFVjh6TDhmQVJicFh1QzBKNUFSRFR4bExFTDlFTUFOT2x3ZUlnakhRWUs5?=
 =?utf-8?B?cW4xSnRwanBpSFp4VDJDYWJNZStvZG9LeGdia2FvbEJjdFFjMlk1SVFVVytP?=
 =?utf-8?B?aXJvd1RtU2Rjc2RYWU5jcWVPRG0vYjlpbnpuTzh5eC96NzVMeVFPeXhRcEl4?=
 =?utf-8?B?dGxEdW1pYmVuUThXbWtNTUk3VnFRdW9heGdwSC92SUUrVGlKNVJnblJPRVRw?=
 =?utf-8?B?K1hHamNXRjVWMW84OWJZdVZ0OEJrakpqOVNNRjRLS2lrc01aOG8zUnRBWTVy?=
 =?utf-8?B?YVFhQmU4QVdVMFVIWnBnSWxnUWcrcjE5bFNUNW80YVlodTc1b25wcUdDendD?=
 =?utf-8?B?bUU1MmFBbHdCcmkyME44d1duWUswY1BacU9GVUxXemlOWlhiRFNsb3RJekh1?=
 =?utf-8?B?SWsyQ0E5eHEycU9LQmhKclB2VzRWYlExUjlHWEZqRDkreXZSaTh6QXBGMFFh?=
 =?utf-8?B?cU5aUXpjd2FydHEyeE1IaVBUSUtYakY4UUlhSHVFU1BDYnZtZTBSeGNkZG14?=
 =?utf-8?B?RVRFdldOa0ZDQ3k0VktNWHVlcWNzc09Ob0x3dk9Ld0s4dUhXVUVzVzdxa3R2?=
 =?utf-8?B?VmRnUXIvVTVPTXduTjdVQWx6N1lEaDZIbWVZMFpMek9Hb042VmM0R2dYREVx?=
 =?utf-8?B?UFFUdi9QejM0OE01UVpPVHRITTl0VDhoVU01UG51MWJhM3FvcjNZWXg4RVJN?=
 =?utf-8?B?dWdZSDdmRDV4NytMeXhwdHozUlhyeE5odmdJemd6Vk5Zb1V1TUk4WWpmYXph?=
 =?utf-8?B?QjZLLzVyUnBCdytWN0VPNnNUUmQ3S0JMd0gzaHdGeXgvS3JoQnZIa1ZBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZjU5WjlubnZkVVcrWmhWUGdrSlh2NE9CdHVRQ1BXbktPVDhwQmNMZTd6ZEFR?=
 =?utf-8?B?VklkMklLbEtuN0x5MGlpdU1JYjY0K3BrS0NpWWkrckdBM2FUK0JhYjcyWXE4?=
 =?utf-8?B?bFV6TSt5ZzVZNk5pVCt6OXpHMS9QRk8wOXJZaklOWHFmd2hmWUZHOXVlRGpW?=
 =?utf-8?B?RUJXYWpnVkp1c1dabW1QOGo3RDBYL1dWaWlrcHJGVWRqSW5iU3NEOS9nTjBz?=
 =?utf-8?B?R0FtSW1yVG9LVlJUODdicE9TRXdVTzk0UmxKcGF0clNvbTV6WENpTXZ0YUpx?=
 =?utf-8?B?bklMTyt4NHZCWEZFempGUGl2emttRU5aNzJNT1BNeUVjZlBhUDVXc3RWM1B3?=
 =?utf-8?B?QmhJdktOSFBWVzdjelpTbTN6M3dKT2JBdWFaVy9zZ0pNc0tlSnVYMEYrNzBX?=
 =?utf-8?B?NDYyVU1yT1o5YW1ZZkN4M2lVYUpxbStCLy8xcjY0MlNZajZLRjR1bmErdFZv?=
 =?utf-8?B?K3R1YmVwb2lTSDBzcFJUdDlqalpHUVBIVVROMHJ4aFJGOC9NTWQ5VEJKUzB0?=
 =?utf-8?B?VFZsMnFtQnE4NHdWd2k0b0E0Q3BscC9EY01HWHZKKzlZZFhuSm9vaGpQdWFH?=
 =?utf-8?B?KzF3djVXQ2VNQ2k2NmlqMHM1NStxTm16WHNLRWJabTFrZTgyQ0lXYVo0V1hK?=
 =?utf-8?B?bG9raVRiMGpDQTdTZlZaZXowVGh1RDhrS0p5blM0WWZBcm5aL0JvdWgwclRZ?=
 =?utf-8?B?S3VUSGJyL3I1bjBrRGxUdno3S1ltWFA3ZlN1cEtoNXZCTTRkWklSM2lLMjZ3?=
 =?utf-8?B?eGhsZmx2b0tMM2daQVN2RFhqNG45WWVwZkdQUXJTR084WU43R0tmbXBoSFVj?=
 =?utf-8?B?LytqRlE5ZWlLYTNpQW1nZkhhaTZsSDZXdEI5S2IyOHgxcnpCV1VOQ0V3cnBx?=
 =?utf-8?B?TlRiNklVN0JxTFlzYmJOTkpyNGVHa3FZNUNqdnJRalVsMHpzcTJPY2g4Tjg0?=
 =?utf-8?B?MXpQd2QzdlMwR256QXRnNnNsejE5VHFkNWNrRFJzVDRjUkJwN1QvNWZURlVa?=
 =?utf-8?B?TkY5UUxwb05zUTUyWmFZWis5dTMvUDFKbW1QSk9UVDBrbk54dE9MdUdLcGFX?=
 =?utf-8?B?WDdJdjVubmw0NnNBMXJZcGpCc3AwU0RLRC9FZnR3UEVoajE1ZzlpNlhVRWcv?=
 =?utf-8?B?WTU0bU42LzkzdVplRDhuVEpkUmc1TFFBQnFra1lkVk5YdVJWajJZMEtQdUY5?=
 =?utf-8?B?VzNiQy90MDREN3ZBZHpJdHpnUTZuL1dRZWlJNFJZenA4YisweGErRG9jc2ZN?=
 =?utf-8?B?OWR1RjNyMjVzNy9QaDU3M2g0VXNZWk5jYVdzYzNjeTVBbjhDSGVBR0VLOEM4?=
 =?utf-8?B?N21MYTFDUmtoZTREc0dPenVIK2Uzc2t5cGFiQWcrREZrR0xqN01NVUp4SitZ?=
 =?utf-8?B?WGI3R2hnTzE2OE5jazdWdWpTdGtaMVJtK2xJaVFUWmlhTWgvMkNaeEhLbjRn?=
 =?utf-8?B?YnBQb0xlVG5kOHo3MmQyRFBCbzlIWHBpZkRTQmVDa2ZKdUhZZXQ3OUc4Rjhr?=
 =?utf-8?B?UmZFenI4K1dsQ29BY01UdkNNZHkrOWZOQndwUnZoR2ZZUk5UODU4ZVJqR3BR?=
 =?utf-8?B?QWlneWp3TWltV0xNZ2dqZDNNalFrMVlUclJURmFSeHZ0MDJlWXl0cWVIcXBX?=
 =?utf-8?B?OVFLZVJCbGVhdFlCbDdKVnhXc0pPcTk1UlZ1NEpFUDNFMnczcTNQaDliYmZY?=
 =?utf-8?B?RzFBTnhPbS9pT1BzMFh1Z3dVbjZISVR6L29XdEIwRzQwbkROTzhjc3hrMm44?=
 =?utf-8?B?NXdxQmdQZWJvbWx5VGNFUTJyU1pwbHhpUkJLRUI3M2dNVC8zZXU1aWF6Q1dH?=
 =?utf-8?B?ZzZGaTEza3grdlMwc0o0dzdFd29QUkNnamVHbzROVjFSUkVkdjFlVUZPelhI?=
 =?utf-8?B?K1FOcWE1Nk1oaFpFbjBkNE5WL0hSc2hRbVkxeWVNUTMzYkc3Ymd6cW8zM2gv?=
 =?utf-8?B?b2pLcm55SVVka0VBQ0N1UHRHbnhPMzhHS1VkZ05tNDZSV1Q4eUVnajZQdURJ?=
 =?utf-8?B?eTZrMFp3RlczeEJSTUlVclVDQlZZQmNsV3IvUzBubmZCQ0ppNVBsTFgweXgy?=
 =?utf-8?B?TXhCUms2eGlMMFpaNm9YazJEdlY1QTJxQW9WQTdSY1RZMmdZQVNtbE4vNlFn?=
 =?utf-8?Q?s6WaLzwpbkTuOF9ChX6IvB9za?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e1b445a-615c-49ea-b899-08dcf9c3dd15
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 15:51:20.4404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cVWHd++avLLh0qZftWOfHlLldcTTg/foF/xMPYtJ8C+DULqeR9NSca+OPDuXBTJY8/iGDoojK/vLqEMopciU2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7721

On 10/31/2024 10:40, Kurt Borja wrote:
> Fixes the following error:
> 
> dell_smbios: Unable to run on non-Dell system
> 
> Which is triggered after dell-wmi driver fails to initialize on
> Alienware systems, as it depends on dell-smbios.
> 
> This effectively extends dell-wmi, dell-smbios and dcdbas support to
> Alienware devices, that might share some features of the SMBIOS intereface
> calling interface with other Dell products.
> 
> Tested on an Alienware X15 R1.
> 
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
> v2:
>   - Commit message reflects Alienware devices may not necessarily support
>     the SMBIOS interface
>   - Commit message now has "Tested on"
> ---
>   drivers/platform/x86/dell/dell-smbios-base.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/platform/x86/dell/dell-smbios-base.c b/drivers/platform/x86/dell/dell-smbios-base.c
> index 73e41eb69..01c72b91a 100644
> --- a/drivers/platform/x86/dell/dell-smbios-base.c
> +++ b/drivers/platform/x86/dell/dell-smbios-base.c
> @@ -576,6 +576,7 @@ static int __init dell_smbios_init(void)
>   	int ret, wmi, smm;
>   
>   	if (!dmi_find_device(DMI_DEV_TYPE_OEM_STRING, "Dell System", NULL) &&
> +	    !dmi_find_device(DMI_DEV_TYPE_OEM_STRING, "Alienware", NULL) &&
>   	    !dmi_find_device(DMI_DEV_TYPE_OEM_STRING, "www.dell.com", NULL)) {
>   		pr_err("Unable to run on non-Dell system\n");
>   		return -ENODEV;

There was a really similar change that got committed recently to 
dell-wmi-sysman:

https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/commit/?h=fixes&id=a561509b4187a8908eb7fbb2d1bf35bbc20ec74b

The lines are identical now.  Is it also worth splitting out to a 
helper?  Not sure.

