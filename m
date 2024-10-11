Return-Path: <linux-kernel+bounces-361846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB7D499ADC3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 22:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F84F28A0C2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 20:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 052301D14EE;
	Fri, 11 Oct 2024 20:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="br1bzJTf"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2042.outbound.protection.outlook.com [40.107.96.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18C3199231;
	Fri, 11 Oct 2024 20:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728679995; cv=fail; b=trpW+p9g0IKqQ1iBnnWHeq2xmF1U66PdkHrd9olT3oqo8wcudMsczouIR+F2YJvtX2vYWYeTqQ/fQ0Xyddp7N4lcC+nWE6Uydgjk9b1aIz89qBHrAjX3a436oHBkoqx5xsSfvJefNIToLL5kgfpdgAkZYm8BNx6ai773TbjfO9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728679995; c=relaxed/simple;
	bh=QTG0jnLQQZl7+rjmrpZEXKoVLPS15lKEs53b0t4VSbI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qgg7WhFYTFVoCXD21HbkXkscyzLaOx0XGxcwIIBgRDx64KIy//8pUJxna+B7XdiG4VJWcdYGbKytLx59kFUG5NIzERp++9DLVGFLfz/aP0SXPEgTUztjz9hSd/L+s6eHuxI1v6jEgv09Qd2XGuWc73NXZeDf3WZXapLtL5PKxP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=br1bzJTf; arc=fail smtp.client-ip=40.107.96.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V4W6lhOmDgWZo1oa+MzrZw8JyhVtnnlL7U4A6Dwy9HGdWMyi1bU/5qyrke8Wbet/7cU7fzUVlLvVHQ+aUT73yL4ToSKf7yn2+cyIpHay4PfEHP1p7sKRF3qu5dImSUN62R++qNVt9iC3VaqP7H9J0qXfXR9lXEkRjpVg2eWRBZ0ZU4YeJO/naxwWAiM2OKJeKWCndu1CypKM6E9bEIx6pA5mF/K7SdSMhc2JpoHISI5YoR4pkySbrjJp5vw5TnIFKATmwVyuDyn+zfF9v3BE63c+5s4Xsuu1yaK4pIX8rwr85CFZjBZ+Ttm0a1vgpMkQyyMzFphIcjc/843bkN+3Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gop5ot2eV9bKoo4leMnlWQbgAfHc+8qsf8fTwPEGAa8=;
 b=fN/WjuL627gaiP8Iuc0rawHkcUqTnI4VikSvtAaUmeT/P5nYYGu2TJ3rfNOcKODnQVm9WqMjrn0lIC8ofV1qViu7jCduYLfgcPQc1WTcoTxfok56QFYAJbS9GkQChYAoBgjFyokJ+d2fcTmXHAhKDY2O/dL1ESa4ORtEgSqdQUh0RGfOsHUklV4VG4QS/J0/ScnABTk4noh8SFG/ExOlA8u1uNUqEgHA/ImfzaQgbbUl3DhtmG6MHTbaNWbKr6H1buVMcVF/LR6SIXrYH1rnTgxmIf+5F5RhXAbC+3Dg2c9+k+wK40uyxkOHCltKlmssMV4v49ig9VaOYD66gykOiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gop5ot2eV9bKoo4leMnlWQbgAfHc+8qsf8fTwPEGAa8=;
 b=br1bzJTfw8dogabrDdSFQg0M/PNIxe96g1HZ9HIIoaYc2F3XoUetfpvta8uYdzc5LozcHSBhFJgPxpXyaS7RnRsmKaBPSyJcTzsJnqmKatTboRh/j6sFcS5FWPk4/lOPuI0+y8jBtVmm7zB0pBqtrWdD9vTvXWl7VUjyVSTO2aw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SJ2PR12MB8034.namprd12.prod.outlook.com (2603:10b6:a03:4cb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Fri, 11 Oct
 2024 20:53:10 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.8048.020; Fri, 11 Oct 2024
 20:53:10 +0000
Message-ID: <79991a6f-6071-8f25-5539-8237dd612e1f@amd.com>
Date: Fri, 11 Oct 2024 15:53:05 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v8 06/25] x86/resctrl: Add support to enable/disable AMD
 ABMC feature
Content-Language: en-US
To: Tony Luck <tony.luck@intel.com>, Babu Moger <babu.moger@amd.com>
Cc: corbet@lwn.net, fenghua.yu@intel.com, reinette.chatre@intel.com,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 paulmck@kernel.org, rdunlap@infradead.org, tj@kernel.org,
 peterz@infradead.org, yanjiewtw@gmail.com, kim.phillips@amd.com,
 lukas.bulwahn@gmail.com, seanjc@google.com, jmattson@google.com,
 leitao@debian.org, jpoimboe@kernel.org, rick.p.edgecombe@intel.com,
 kirill.shutemov@linux.intel.com, jithu.joseph@intel.com,
 kai.huang@intel.com, kan.liang@linux.intel.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com, sandipan.das@amd.com,
 ilpo.jarvinen@linux.intel.com, peternewman@google.com,
 maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, eranian@google.com, james.morse@arm.com
References: <cover.1728495588.git.babu.moger@amd.com>
 <66b9a99a06b3cdd208dd8c490c47342bafc62ae9.1728495588.git.babu.moger@amd.com>
 <ZwlrFxLTq4n6fnaJ@agluck-desk3.sc.intel.com>
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <ZwlrFxLTq4n6fnaJ@agluck-desk3.sc.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0206.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::31) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SJ2PR12MB8034:EE_
X-MS-Office365-Filtering-Correlation-Id: c41e8064-cc0a-451b-88d1-08dcea36b750
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TlZWU0w3aTYxQjJBU2tjSk5QSVV3dzc1UkNwNEpOMVZhaUZ6ejhnV1ZTaDFN?=
 =?utf-8?B?WGxXZU1taFdKTUtGcVkrSzZPdkNjY2I3YVVHYUJpT09ERlVhc0NDQkdZeXdh?=
 =?utf-8?B?Tk9kTXUzak1UTk8rdDNHWDk3dzFXVUJXMzN1KytsK1NkMnhJdUc2dW5VTis3?=
 =?utf-8?B?ZTl2ZUdESU9vakZ2Zm9EQXNkR1o2YU5Da0FYSlJ6bmw4SDMyM0toWWtsek1k?=
 =?utf-8?B?ZFpZZ1FPdHJuWnV3eTFzTzJJai9JYmtZN0JoM0ZzMDZ3UWVRRGF6Q2hsRm5L?=
 =?utf-8?B?VEtWdUFUbzhiMnluZ2wwY0VJUmJ4dVBzbnlzTjROK01iOENoU3pkR0ZWeDFw?=
 =?utf-8?B?T2ZKR1JWME50YkVSQVBFeWd2eTZtRWlnV3kwS2swbHJQalU1NkwxZUVTeGZP?=
 =?utf-8?B?K04rNzVvTCsyMW9nS3VxM0V5MDBMVVR6eUs3Mm54NVFqZjlIMDR6WG9pMldJ?=
 =?utf-8?B?U1Y4M2VVRC9FcmQ3SStlenAvTUhObTV2OVRjQWV3R2dFb3VRWmJsMTVoY2dV?=
 =?utf-8?B?TmZZQURkTDZZNWRTYnJDQWZ3RXpmeEN6aVNuanRDMGpLY2ppYzY1VWozWXpz?=
 =?utf-8?B?RDNodGxkams3L21rYlFlT2ZWL2xCaEtxSHY3cHZ0U2E3VDBtZE5qZzlNSTJ3?=
 =?utf-8?B?TWRPOUZKbjdWeW5YR1NhWklxQnNuYkZaNDNEcndhTys1bjVGS1JXMVY2Y2JS?=
 =?utf-8?B?N2kxRzJIQ3BGQ3VJazJ0TFBSUkpoakVJaW4wZTJzcUJJZ1Z2dVJYelBnUm4x?=
 =?utf-8?B?d2M5cTBidnh3ODdMUStqMGF4WHVXU0tLVWZYUWFMN2hWblVGRzdnSjhQTEJW?=
 =?utf-8?B?WXhFSHgreUF1M3VzbE8yQmtlRzRWL2h5b0NOM051aVRZaThYN0xVMjB2TXY4?=
 =?utf-8?B?SGUrTHFXNmlJdXJRTVdVa2U3R2pxWkxwSVVmbFpFV1lKbWt5VytmYzNDNFZx?=
 =?utf-8?B?Sy9ESVhNajQrcllrbTNHTEZidVBIcEFJQ2MycC9qRnprSmFRZlRrM1doVVdi?=
 =?utf-8?B?T3BBZnRIL0VNUnZRU3JibXFuNnpxZ2pXNTR4d1FMa1c5UlRBKzdjTm5ETjZh?=
 =?utf-8?B?eUhqUVJVS3R1dzJPUzdiSWV0bjVmMnM3VVNieVkxYWlJRzM0QXJ4bDlWa1JF?=
 =?utf-8?B?REhRUWY5WEdKYUdFTXhPaGs4MktVNTRBQkUzZmVNZ2ZFZGc4WFRldnNlUUY3?=
 =?utf-8?B?WjFxRjQ0UDNYVmlodHIvRngxMjJneXUxd3ZIZ3ZVMVVPOHlCMmFCNEQwK0FL?=
 =?utf-8?B?b3Qrb3Y2UEZEOEhEblFqKzFrR09ZK3hLMVhKbVdYY0J6ejlIT1lZcTVucml0?=
 =?utf-8?B?NGZVMEZFaldlV0JwVXFUYlVsc3JvTXc2NDluOTVld1haT3FSTm1iYXltSkZ1?=
 =?utf-8?B?MmtBbHBwT0hLaDM5cXpjWEsxTVJiZkdLZGpxMGh1OXVzcXl3bUJCVWJ5QWdX?=
 =?utf-8?B?M0k4bGZ6T2JMS1FjOElUYlNXcFpnUWtySUk3bGtjUFFQSnlwc2l5RElUMTdk?=
 =?utf-8?B?T0ErRHF3QlV1SEsvdWhRK1R3THI3MWN3REtPdmQycW5rcDNYeGpNMEFzNFpW?=
 =?utf-8?B?cHZTL2h4WXcrdzhqYTkrR3ZwWStSRmcvQ3hFOHE5UXVRNUFqeHQvdld2QlB0?=
 =?utf-8?B?djNXalNVMmVvZFBNRG1FY1c5b3J0OVFTWFhDWHltaEUzT3grdkJrd25HU1ZL?=
 =?utf-8?B?NElJdVBlTDcvQmdFcmNDNi9MTXptdXJaRkM4ZTRWMGh0WmZIelJNR3p3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dWY5SU9GMGZwbjAxYnN0WTEzSVZXZEVzN1BuK3RwYVZaK0M5N3AxUEUweENW?=
 =?utf-8?B?czVoSXFMSEtISThkeisvWGt1YlFnZStWT0Z1SjY4L2JZTHFEVFNFL3JKQXNW?=
 =?utf-8?B?VkpHVEVEVGxLcXZwWkFVY24vRG9Mb0F3SG5JdU9XVEQwT3BnYVQ3a1Z2Mmlu?=
 =?utf-8?B?MTY2V3Vqd3pSNk5NeXhTZlZ3cUVjWTZqSWcxc1p1Z0RoK2UrNHUxQmtmaEIy?=
 =?utf-8?B?UWltWStHbWZORWtmUnk4ZFA1d0MyUnczeEwrNlUvTDY5TWMvb2R6bTFCbEFV?=
 =?utf-8?B?SmtpellxdUZOaW9LS2RjNkVnTm9ncGx3SHB2dGR5S2xFM2hpNk9nMXM5ZDY3?=
 =?utf-8?B?OWNrS2FKUzdzWDMyVUo3cEJVYVR3WG0vSkdacE5tRGhFbWtadDlxWWJjZUdI?=
 =?utf-8?B?L0R5Q0wvS25vYUdLSmpQUVdYVFdQNzIzSnJGUk5xVzFUWmpvS1MzeTZDTHZz?=
 =?utf-8?B?M2Fna045am5uRTluekhmakltTkdDSDVpcTRwbDl1Tml6aVdMT04zVkQ4UmVL?=
 =?utf-8?B?NUt1NXlpbjdJSmNDMWRpU0MwUWlnRlFHdmNPZjJBWEdTVk9vcHByZEI2ZnZ3?=
 =?utf-8?B?dFdKQzJtcXlzWXoza1JhMHNrQUZVQ1hXUGlRR1lEejJhK0hjbVZPb0Z2bWx1?=
 =?utf-8?B?Q3k5QmdQMUx2a1dnQmdyVCs1eURlVXNucnpsQ1NkZmZDenU2TklQMXc2cTZM?=
 =?utf-8?B?U1g2S3FsVG5jdENoNTVvd3JkQklFMy9TUEIySW9UNVhHZ2c3MVg4a2d1RVBY?=
 =?utf-8?B?Z0NRYU1kMEtpTmdMYUJHeXloc09oaytRc1lnazQyeVByT2pqWnVMdmFSTVBI?=
 =?utf-8?B?S0JmSVJFS2dzeExoK2g5N21vc1lWQk9BMDZBTWJkMmNoNWdUZjFBM2ZDcEZT?=
 =?utf-8?B?TUp5VlNSV21UN3pmVnZRY3VTOThqdzBGN3ZxRmtoazcyYlpiSzEyT3VPcmsw?=
 =?utf-8?B?Y0ZxWUtUVm8rOXE4QzZPanNIWSt3SCs5aGlBK0J6dmZ2RlRHb0NsYVdiSnEz?=
 =?utf-8?B?c2IzbGwwdExqekNNbW8wKy9RK1JmelVPSmJFU3pGcjI1Y3FBbEtzVURWbnJC?=
 =?utf-8?B?dEY1M0drR2YzMzA0dmFJc1puVjM5TERqTUtsekZ2UVFnSUhMMVlIZHRVVGtO?=
 =?utf-8?B?bXZnL1RxaWwxQ0tDYklZcUxqWDRvbVhIWjBjU2ZRRDh4ME03NDhBbkJla05v?=
 =?utf-8?B?bkx2NHc0Rno2d1hnZ0JPMDdLSmpZV3oyQ0xjek44RGdKM2xlelQ0NWgvTXpU?=
 =?utf-8?B?RCthU3gzZm1adEd3M1h2NUpwMzJaM3UzbFNUbHZFUnhGQ1FYOE1vMGdjRFVp?=
 =?utf-8?B?TDVBMjhPcTlhb3dCWmRiNXF2eWxkRDIzak9VK2FEMHVNY1BkeUdQTUV6b1kz?=
 =?utf-8?B?OEFJd0s1VXB0MFo0L3VWa1JXdXJSSnhhTHRpTlRBSTFZV1RJZEdsa25lU0Np?=
 =?utf-8?B?cUpWc0JqR3R3SXlNZGJQMzhKZ3lpYkFnYmsvWEh4S1QxUFpuUW56c1lrVTNz?=
 =?utf-8?B?TkowVG83NE1lbjVJcHNXQzFmSzdWSHM3T2pzZjV2bVZNMlBmSERwNllBNFZh?=
 =?utf-8?B?K29kd3JYVkNNbWlFTjZRNmRFU2F2YWM2d2k4dW0rbVY1ZWxPVnhJM2lSVGhW?=
 =?utf-8?B?bStZTnpCVWp4YkVBa2RXanduMXIva2RPcVJmZUh6ZTJmemUrZTRNS2JVZkFx?=
 =?utf-8?B?WUZ1TVRGd241Y2tEUTZ2TksrWnFVSytlTmxWMXNpVHJQWkRVRTJ1NG5FU3dW?=
 =?utf-8?B?UGV0TVZpMVQyMlZMWjBxcDE2cktxRVNZSDY0NHZ2RStzaXV1L2ZMempRZFJ6?=
 =?utf-8?B?SzRBSkZkNk9MTGRubDBZYWoxdWVtbEVZaER1TWhzRFB0UzBjZnhqcXhHMXM3?=
 =?utf-8?B?MmlkbGQxa0crOS9TOHo4SDdDdmxiT2g5Rzl1alhZSUdDMWpyQ1NzMzU3UWN4?=
 =?utf-8?B?QU4vUFlxckRpR3ZPOVUwRmcydCt3TE5JM01Cd3J2blVNaElrSzBNcG9vd1J6?=
 =?utf-8?B?QTVRYVRXM1dmdGZXM0tra2Nrekl5K25aSS8xNFB2OHNTL0Q3dDRXWGhyT01Y?=
 =?utf-8?B?T3dsMGFVYUkzcTNUb2NObW5KaFIxRFhDNVY2dnZ3MmNvZ01qbEY2T0txUjRX?=
 =?utf-8?Q?oeMw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c41e8064-cc0a-451b-88d1-08dcea36b750
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 20:53:10.5937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wA3XrRyVt/JumVGTiARwDfkIH8tulZIazUkpxZJDvru8Twrn1luOeemAjwsdqvFP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8034

Hi Tony,

On 10/11/2024 1:14 PM, Tony Luck wrote:
> On Wed, Oct 09, 2024 at 12:39:31PM -0500, Babu Moger wrote:
>> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
>> index 3ae84c3b8e6d..43c9dc473aba 100644
>> --- a/arch/x86/include/asm/msr-index.h
>> +++ b/arch/x86/include/asm/msr-index.h
>> @@ -1195,6 +1195,7 @@
>>   #define MSR_IA32_MBA_BW_BASE		0xc0000200
>>   #define MSR_IA32_SMBA_BW_BASE		0xc0000280
>>   #define MSR_IA32_EVT_CFG_BASE		0xc0000400
>> +#define MSR_IA32_L3_QOS_EXT_CFG		0xc00003ff
> 
> Nitpick. Most of the MSRs in this file are in numerical order (within
> each functional grouping). So this belongs before MSR_IA32_EVT_CFG_BASE
> 
> Same in patch 14 which adds MSR_IA32_L3_QOS_ABMC_CFG

Yes. Will take care of this in next revision.

-- 
- Babu Moger

