Return-Path: <linux-kernel+bounces-355132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7E29947C6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 13:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC7881F25B4F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 11:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43F61D6DD4;
	Tue,  8 Oct 2024 11:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rmKjV2pW"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D231D8E1F
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 11:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728388372; cv=fail; b=Zr6Wxok7EwHs0tkN73SFqaCwyZvEEYR4DHE/px0dI3YJDRerBmCa6itSgCeJLjO1EHmS6SfkSNMrw6xeVPfgMVzNsThXxT7fq7uNhtaKEjxtgyINtHQWSkhOdza6IqJ1eUXVolQZboUBsOfxrwv4qPj8nCZ5nTSnmNDhL6zC6/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728388372; c=relaxed/simple;
	bh=RpePcu/mAmMYvwRdM8GnxCdiRng+BnZV4a1BN4CjaGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NENCie/dZixyjD66HMFH6A0dZqjq9+9QAsErXGXb99VKUXE2pJigxYm0lRqBw9+0RL1XQI8vTlm/H4x1rNhfBHaXIlVzPbhAwP+tZWWi7gGmx1PlmwG0wRRSF83JqA7lRBw9WDMrw63wrRfo6JbviUcHMg1IwZmZLghkxPiFW2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rmKjV2pW; arc=fail smtp.client-ip=40.107.223.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k1ZjjUwMcIDtuoVODH+PLOvPiFXBYDR52daAsAjMr8Z5hGeAX+jznrXiCD4l8M1oqxzYAWP4NJ6+UAJvYgqCgWwdtMY1lq462/aa9ZjZv0ozxVnhRKPciRNAHmHzDSAzV/dbUOqay0i27U/2CFLUaHCEy/JzvhWL7Xl0tdpuY5QeKQ3B5HnM10U2YWqz7E70xTnKgLc3VhdpSsrPTtfH0gw6gUR4X3hiofpSZr7V+FPwT4lxgvL6Po8WJRZ1PQAa33LTW5quRWKxRoHKE3vrpyBQGWIrs4+6Gips2wNsLtBL0D26U5IkCdRHg4gMUeT/FXenAbKK2yn7kKEGYEJ4JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0fORafGRF4rqI41yqbtir1/+ryKAV5Yd+IlqOS/5grw=;
 b=BamRZeXrWqUraDaxO/0ILZRp/64Da+w/Yvh5I3BIYWeyQ9kHcwnQ68FY8b9ekNwK7OGaIW2YSLzLIfrVdq/ghL4YSnJ/BP81RgOy/im9RSSCGT5mBkj+sJyI3kiSFmadlDrngHPnok26Fv8oqAY04G+zwjELmYW1CG2vvkIqYtLp5cre6xbLBjL0KVe0So3+6inCzM0u83j9F9jCTb3x9g20B6o6Mp77+2vYJu85I6J8F4xJ7BrLxT2Wfo8jfwPSM+E6vdYSeoeNqgDHnMCsR0abu1EzWAL6qnQmg27heynUjtvof2Jz1i8gaVj1TDihhBi84QVb1vatGIpFh2Hwdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0fORafGRF4rqI41yqbtir1/+ryKAV5Yd+IlqOS/5grw=;
 b=rmKjV2pWEJb+JCpQpRN6zdLMCDAxtraPrII/YMeiicIrziE7xp6BU+Lm2caRpQTXSLUd7KgjhqCWbQnwRg/ywYvi9y6FAMwBsBBOlPsNxBNiiHDBdf4FiwnDu1G3Vgm1vyQbYidvlG6Qh+6znqLNx2xO0SdHPOkGV9gnqDdqlJX6ErVlkaJoOThNnTI2ipo21A1MNUK2EtYQuWuPjRdflW/M1Yrud+S6EsTjQBS1zUMiwThFMBWJ1hFa1XHKdje0DxQehjNWyaNfdSCixMB5dxTXZlbXk4fJ0Gxbw7mGAoJagppXQ9+TZCylWwtGmcCdrhCPjnOfzXqhkva7z5anHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB8324.namprd12.prod.outlook.com (2603:10b6:8:ec::9) by
 CY8PR12MB7755.namprd12.prod.outlook.com (2603:10b6:930:87::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.16; Tue, 8 Oct 2024 11:52:46 +0000
Received: from DS7PR12MB8324.namprd12.prod.outlook.com
 ([fe80::c45e:51b0:e1ec:1a32]) by DS7PR12MB8324.namprd12.prod.outlook.com
 ([fe80::c45e:51b0:e1ec:1a32%4]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 11:52:46 +0000
From: Zi Yan <ziy@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, Alexander Potapenko <glider@google.com>,
 Kees Cook <keescook@chromium.org>, Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Miaohe Lin <linmiaohe@huawei.com>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 John Hubbard <jhubbard@nvidia.com>, "Huang, Ying" <ying.huang@intel.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] mm: avoid clearing user movable page twice with
 init_on_alloc=1
Date: Tue, 08 Oct 2024 07:52:43 -0400
X-Mailer: MailMate (1.14r6065)
Message-ID: <84D24C40-AC10-4FF7-B5F6-63FADD523297@nvidia.com>
In-Reply-To: <9e4e3094-00a2-43bc-996f-af15c3168e3a@redhat.com>
References: <20241007182315.401167-1-ziy@nvidia.com>
 <9e4e3094-00a2-43bc-996f-af15c3168e3a@redhat.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_B345C429-C6DE-4483-8E4B-DBC3D57583FE_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR06CA0025.namprd06.prod.outlook.com
 (2603:10b6:208:23d::30) To DS7PR12MB8324.namprd12.prod.outlook.com
 (2603:10b6:8:ec::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8324:EE_|CY8PR12MB7755:EE_
X-MS-Office365-Filtering-Correlation-Id: 15f19fd5-177d-4ad7-ce01-08dce78fb9c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VWhJQVZucmp5ZzljYXNOd3B6dkhjL0RJVDBuNTJud1o5ckxWTHJPT0Yvai92?=
 =?utf-8?B?KzZ5TFdoa1hSbWE5RjZsQnZybWdIWUNyWXFiSnlJc2VPbnh6a0R1VGE4bkR0?=
 =?utf-8?B?ak1FSFpTdDg3NFI1aWdsNXFualpXa1J5Zi9MMng2OVVHUzdYNUpqYzEyQ1FN?=
 =?utf-8?B?SHpUZHlUK3MrcG4yaUx0NzJVQ0YwOFBmNzNEb0dLMVR1TTY2Y3N2bXRhcjUr?=
 =?utf-8?B?UjZIOElVd0dFeDZ6SW1yaytOUmphSTN0bHJiVnF1T0tCcElYSFBHeXpROEhx?=
 =?utf-8?B?VCtuVTFySnNsU0pPWkVOcnplRlBBbndoZHdLUitOTzVHVUYvdzJ4YVkvbkNX?=
 =?utf-8?B?cTFKakpHZ1RjUW9sZlk0ekV6eG8rbWcrcVRsdGtrZGJ1S1lGM1owK1JTR04y?=
 =?utf-8?B?ZXphYzhGUUJ2bE5zeHBZbUZ0OHdlMTZOSHlvWXNObkg1Tk9CMFJ0WjRWVEgr?=
 =?utf-8?B?Z0JtMTN3WkJkS0xuRmUzK0t6djI2djc4SGhvdWhkRlVacDZuYXNVVGEvWXU4?=
 =?utf-8?B?VUg5VTZ4RTRIUTBNeGY1bzFnZ2xkM1RYQjA3bGVRUktNeHhSQTJoc0RpRVAz?=
 =?utf-8?B?aUtlbVBOejB0c0M0SlZPVTZRUVZCRVJWWk5WclNjNnVSUUk3NXduRFRFSVJ2?=
 =?utf-8?B?WUZydnF4ZENIUjZjSHlrOVhVdkFhUDlxbXNZUXVoaTBOU0h5ZGdBWCsyNkZY?=
 =?utf-8?B?dWFCTDNzWGFNU2RLeGljKzhxRmVxTUhQRExBaFc4VzE4Q0pzSU9xNXRsdGRq?=
 =?utf-8?B?WWVJSjNuU1p4VWNka3hScTMrWFpOOUlBNURDSmRjcEtWOFdXcUNFcS92M242?=
 =?utf-8?B?dG8rM2dRZTh2dGZCT2J2UXVFSEU5d3l0Nk5wanJ3d2d5b0FMamx1WGNBZ3RD?=
 =?utf-8?B?c3ZFdk54WWorMTQrZXVCdzJ1bkZVUkZuZ2xLMWtFRVVJd2h1VXRTdkpVaWYv?=
 =?utf-8?B?TmtNSnI4MC9ydHFjSUt0N045aTZIVCt0RlBmMkpHZGhQc21valVyKytoWDhu?=
 =?utf-8?B?MHJ0OXM5YnBMNUhSVUlIN3NDc0xOYUx5SWl1VFFRa2wxVER2ZnE4UktOTWdS?=
 =?utf-8?B?Ly95Z3pGRUQwQ01CVU1nd0tWUVRkczlSbmMrczBuWFRyMHR1NDRFNlB0SVVK?=
 =?utf-8?B?N1dkUXM0YUpjYlJwUmFJY1BuaHM5UmlxVUY4WmpkcTJqMUZLVFBvMFZlNXZD?=
 =?utf-8?B?TTUwSHhDcFRGNlY2V3VBa0dvdm1rMlhqK1RkbFlpVHhCbmkrbDNZQms1K1dR?=
 =?utf-8?B?MlIyZDZFbW5lZWhPK3BtcnNKeEtJeU5BaG04K1l6R0tKSXBjL0FWRkZmZGZj?=
 =?utf-8?B?ay9HWlN2K0RsN3BUT0RRUCtNdzFkUXdSWE42TmUzbXNSR0wyV2JzcDFsOXZS?=
 =?utf-8?B?UEdyeG1TVTJxeUJENGFtZTMvVkMzY2poalA2UjEvUlFYSUp5OTl1WlN2TkF1?=
 =?utf-8?B?OWJ6N0RTd1BHWUtlM3dUTXhPL1Q3TE41OGNjTGt0NmxudzhZVFh4WSttTVo1?=
 =?utf-8?B?bWlBa0NQK29nZ0pjcUZIOTZTcUFFZWJTbXJsK005UHdoUjlKaFRVajZWQ3Q1?=
 =?utf-8?B?aXRJS25nM0h4bG16NEhpWGc0ekN0ZmhmSFFaT3IrT2dmVk5xR1J0VVNzVG5u?=
 =?utf-8?B?YVZBZWdsa3YzajJ4b29sOG9YMkNXRzRpMGdEVGxoUC9OVCtqOGozTTBrY2NK?=
 =?utf-8?B?RkdoWXA0YVBXdnlhcVdZeDhuS20yeUUzeDVzSFdYTjVEVUZqZlIxRzJBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8324.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ajVYd3g1TVB3ZXJ4Uzhyak5CNFJwWlV4RmNsUEpITjlvQTdBVzNQR3VsUndB?=
 =?utf-8?B?ckJ5bWdEc1hRK0loWDN4SlljNmlMSnZWOTNLa29UamJBaUkrRGZrM0g3Sm0x?=
 =?utf-8?B?NXdnRmk3WlNNcVR5djFVVHpCZUdldUZtd2UzRlpOMkZldk9DYVVQN2FmWXFD?=
 =?utf-8?B?K3phQnp6RHdjaWMrVFEvQWVHZ2d5ektlRmo0eFlJTnFYbkhMeHF6VFMvMHFq?=
 =?utf-8?B?S3NzaC9adFJNN05QY3k0enhhdWY4cy81ZmxKZ0J2OFVrMktnbmxlV21ockNr?=
 =?utf-8?B?cnBOWmlaTjA0alI1cms0Y1F3aHlFSUkxMEQwUFVUWVR6WkRoNU5jWmZ5VEFr?=
 =?utf-8?B?dDF6TlB3bzBjK0hVTExEL0tqc3ordnJ2TTVkSGhaRVlZcDByVU1SaW9pWUFU?=
 =?utf-8?B?bjdXR3ZmZG9IZVV0ODM5dkxvdlNUbk0waWZtSUNLR0I3RVdaWE04OEZiZkpx?=
 =?utf-8?B?RzFzQWRucVB1QmlzWTJ1OU5Kd0NZSEU1Zno4Sllqb00rTWVsWEIwRC9Gd1dU?=
 =?utf-8?B?dS9NVXQvUHdwbGhFTTlHS0FxQlRpZlEvZnErMTUzTThPcXlJVENMUUR6TWwv?=
 =?utf-8?B?VXZoUkV2UXQ1SlFKTXVHZHRrWlR3TWppY2VlbTRRWFIyMDhWQTFlWWFNUkt3?=
 =?utf-8?B?TjA0cFA1MU0zc2hJTXRac0RSV2tnSXFNeDkyRTNYSk5ScEJLRjNQQ3VJdWZj?=
 =?utf-8?B?VS91ZVlPWFhMM3UwNHc0czN6b1dGSkNaSnYzeU13K01iZS9jYVIrOWY3OUp5?=
 =?utf-8?B?WHUrbElBZkQzUER3ZVZiNnJpcXFVT1RGWFJtYnp2VDhPOXgybTdOcmxMbnJC?=
 =?utf-8?B?R2dvd2oycUg5WHFJMDJ2UlFZL1R5bjhKSXBkelB2OVd3THhsbVVPZHAra1Fz?=
 =?utf-8?B?anpyTm5hd0pFNnRzVHpZZmt4Qmc4eU5hN3lwLzM4eEhxdU9FUXkzREI1ejhS?=
 =?utf-8?B?aUJEc2VHWTRTYytaS0JibisvYUcrQXRDN25JczJISHNJN0c4MlQxSmxKK0hS?=
 =?utf-8?B?TlFFWi83T05VclY4R1VrWE8rZkp1T21YNHUrbklVMlU3ejdicUEyZ3UrQ2xx?=
 =?utf-8?B?QVJtVGFsMUJGMHlqZ1hNM0ZoRUl3MnRjeC96MjlSOC94STRDTmxLZVhkaERF?=
 =?utf-8?B?S003NFE4N204VytwWmNGQU53TCsyZjVlMC9jY005NTBENFF0K3p4UFM2cXhL?=
 =?utf-8?B?OGd3SHowSTd2K0JzSkRsUDRxY0ZEN04wS1gwOCtJallGWCtnelNmREFleitM?=
 =?utf-8?B?WlF5ajVnSWsxMVIxa0s0T0hXQks4YzRQSUU5eTFrQ3RYUjNXbHVQVW00cUdv?=
 =?utf-8?B?WHMxdjRFNW1DYzRNdzA5Mkcxdi9BbGRrSXc0eEVsV291U1BxVmFMbVBnbW1t?=
 =?utf-8?B?NEdxRURyRDhTZXhsUFBjUG44ZGtXYWZHMXpOb2t2RFZoYkU3amtUT2JMTTZw?=
 =?utf-8?B?cEtUVXZmanR5Y1JBMXZNbkNWWitPQm1SL3VNV3hUOC9sOVMxK3Jrd1RFNzdB?=
 =?utf-8?B?RHJFNEhiQWhpNEJid0l6ZnJaV1ZNT2RyM0h0SFBOeU05NG9seFFYZm5OTW5B?=
 =?utf-8?B?Yk51eWp5QlhiTzE3RE0vQXdJRWtreVk4c0NTZ0lOMUpJNlFQRVkxYjVpQkRO?=
 =?utf-8?B?U0xXVG00UWFoUTB2TU9yMFY1eUFqMy9vd0FtU2xBVHdHcnlUL1VKbFU1VEE1?=
 =?utf-8?B?NkxTTVJQWDY0MnJXMnNPNUJWcCtWcTNlNFdhUUZ0RlBMditUa3ZoR0Z1Rzho?=
 =?utf-8?B?M0x2M0YzUHhubHMzNHhmYzZJRXlVWHhOSmFLU2JualRQU29rWHhlN1I5ZUhK?=
 =?utf-8?B?K0xRS2syNWdjcWhOVk5KdlJmQUd5cW1CTGk0Y1FLMW1SdFNwN21HWW94TDRs?=
 =?utf-8?B?T2djY01NWUdZaURaNndDdFY3N0pxQnk4aEZuUjNhSFF4S2U0VmhLUStXNHF1?=
 =?utf-8?B?RlgydjlUUUxocmlZTE1TWkxFR1ozTFFBQ25nSkdTSzh0NStlVWRjbjBKdC8r?=
 =?utf-8?B?OHcxSENZKzdXTFZNenc5eGlBVUJHaXhYcEgwUHhMdEwvdTNucTgxQi9PbUps?=
 =?utf-8?B?NjMzaHhUN1QyQkdyUTdDRUZXRk9sSlZUdzl4VFlqMVlnUSt6TW5tMUVNUVBV?=
 =?utf-8?Q?Xktb3UJ0AdY9nFWsVWd+pWCW8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15f19fd5-177d-4ad7-ce01-08dce78fb9c8
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8324.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 11:52:46.4726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TNdD1zn7SvQuXkEPniCrJlmB/5cjkm2mx9wbPKMQlvJTsKuURiicmoh153FAbQmz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7755

--=_MailMate_B345C429-C6DE-4483-8E4B-DBC3D57583FE_=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 8 Oct 2024, at 4:26, David Hildenbrand wrote:

> On 07.10.24 20:23, Zi Yan wrote:
>> Commit 6471384af2a6 ("mm: security: introduce init_on_alloc=3D1 and
>> init_on_free=3D1 boot options") forces allocated page to be cleared in=

>> post_alloc_hook() when init_on_alloc=3D1.
>>
>> For non PMD folios, if arch does not define
>> vma_alloc_zeroed_movable_folio(), the default implementation again cle=
ars
>> the page return from the buddy allocator. So the page is cleared twice=
=2E
>> Fix it by passing __GFP_ZERO instead to avoid double page clearing.
>> At the moment, s390,arm64,x86,alpha,m68k are not impacted since they
>> define their own vma_alloc_zeroed_movable_folio().
>>
>> For PMD folios, folio_zero_user() is called to clear the folio again.
>> Fix it by calling folio_zero_user() only if init_on_alloc is set.
>> All arch are impacted.
>>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> ---
>>   include/linux/highmem.h | 14 ++------------
>>   mm/huge_memory.c        |  4 +++-
>>   2 files changed, 5 insertions(+), 13 deletions(-)
>>
>> diff --git a/include/linux/highmem.h b/include/linux/highmem.h
>> index 930a591b9b61..4b15224842e1 100644
>> --- a/include/linux/highmem.h
>> +++ b/include/linux/highmem.h
>> @@ -220,18 +220,8 @@ static inline void clear_user_highpage(struct pag=
e *page, unsigned long vaddr)
>>    * Return: A folio containing one allocated and zeroed page or NULL =
if
>>    * we are out of memory.
>>    */
>> -static inline
>> -struct folio *vma_alloc_zeroed_movable_folio(struct vm_area_struct *v=
ma,
>> -				   unsigned long vaddr)
>> -{
>> -	struct folio *folio;
>> -
>> -	folio =3D vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0, vma, vaddr, false=
);
>> -	if (folio)
>> -		clear_user_highpage(&folio->page, vaddr);
>> -
>> -	return folio;
>> -}
>> +#define vma_alloc_zeroed_movable_folio(vma, vaddr) \
>> +	vma_alloc_folio(GFP_HIGHUSER_MOVABLE | __GFP_ZERO, 0, vma, vaddr, fa=
lse)
>>   #endif
>>    static inline void clear_highpage(struct page *page)
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index a7b05f4c2a5e..ff746151896f 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -1177,7 +1177,9 @@ static vm_fault_t __do_huge_pmd_anonymous_page(s=
truct vm_fault *vmf,
>>   		goto release;
>>   	}
>>  -	folio_zero_user(folio, vmf->address);
>> +	if (!static_branch_maybe(CONFIG_INIT_ON_ALLOC_DEFAULT_ON,
>> +				&init_on_alloc))
>> +		folio_zero_user(folio, vmf->address);
>>   	/*
>>   	 * The memory barrier inside __folio_mark_uptodate makes sure that
>>   	 * folio_zero_user writes become visible before the set_pmd_at()
>
> I remember we discussed that in the past and that we do *not* want to s=
prinkle these CONFIG_INIT_ON_ALLOC_DEFAULT_ON checks all over the kernel.=

>
> Ideally, we'd use GFP_ZERO and have the buddy just do that for us? Ther=
e is the slight chance that we zero-out when we're not going to use the a=
llocated folio, but ... that can happen either way even with the current =
code?

I agree that putting CONFIG_INIT_ON_ALLOC_DEFAULT_ON here is not ideal, b=
ut
folio_zero_user() uses vmf->address to improve cache performance by chang=
ing
subpage clearing order. See commit c79b57e462b5 ("mm: hugetlb: clear targ=
et
sub-page last when clearing huge page=E2=80=9D). If we use GFP_ZERO, we l=
ose this
optimization. To keep it, vmf->address will need to be passed to allocati=
on
code. Maybe that is acceptable?

Best Regards,
Yan, Zi

--=_MailMate_B345C429-C6DE-4483-8E4B-DBC3D57583FE_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmcFHQwPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKw1kP/iJooWtHk6wofTYAhfWnBVucUcVhnq1FmSNc
J69MvGo5ZMj/vNNQ51gjBjPwwPitlf2Y/MBcML8qf150q6TBJsFJswLZnbUBkEgg
zys2KCFc5ieOsR2JdqGEY0xMTTAILnr5Ec6/dnWOYdX/SowcdGBZtLIv697bGm7U
ASv6gOPbPb8visfnCF+vy5MlZWM/RuGWzPOnnTCLAH03oGjfEJ48PM7Crs9xbHxA
nfb4JvQTGh6G/EGk/XTaTWg4tbdAXw2r0/r9x4EFUOKI8lE3dzxtW9QxaqozVy9O
bQDp5IDpOOxgCLdaaSreK7YHSfkwW9KpcP0f2KAVz0bed1cvc7u1aq2mRya3duNY
A2W943AvGPDIEdttLPUCD/PkqcNy1yP1eZAnpOry/l7wHX2R1tJRdPIa1dgIZBOT
bw9n2HlhF0iBnfzvpLmj/1SpKcIlI+bf1cZwvnrciqLyd1zGmRT5eG/dLXEJ0Klr
Pg1F+mxvgMHCM1+SP+RcPGygd4CliO6fcjkJ349wRLEkjHrDzmuH/Q3xQe7yXIdy
KUGVTMJp87pIaJy0U2LZyrXl2fnR3KwjtocF/omA1I1Ebae8XU+rSdgeIyXunjUl
6/TSPpLkcH9MtLGbO9uCv+fHqVykPrMwwhLgLSe/R0v7EMjH4OodE8WwR/xkq/Ux
tTJucM6u
=YyUK
-----END PGP SIGNATURE-----

--=_MailMate_B345C429-C6DE-4483-8E4B-DBC3D57583FE_=--

