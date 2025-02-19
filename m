Return-Path: <linux-kernel+bounces-522462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E12A3CAAF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 22:01:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 340083AE24B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 21:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE22253324;
	Wed, 19 Feb 2025 21:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2zEgMvHg"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2089.outbound.protection.outlook.com [40.107.101.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B01252917;
	Wed, 19 Feb 2025 21:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739998839; cv=fail; b=QrFWpcGQjRIccUFo+GDMtrYC3r/Fe+bLhDjj+h1gGlvMAMvFYB9+UF4skf7Zuq2SKPReoEc1/mzWAXrCRrj/fskOvEhy5WyD0PBjHwYPN4AxdgQixzb3eOOOPrm5UGCTmNNMIJH5bXo+PIe0d1jmYc+d+bgs2jLNIs3MsQeVOOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739998839; c=relaxed/simple;
	bh=Q0ftO3SaXfuPhHR7/5z7XWdymi5ZL1+Y8/0nl70TiNI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pdPQgKqoszblbkGhL0hvDYREJISrQCC1rkXEODI1OyshZPNvMK2d5FdOhnGTDNzH9TUkF+oX48wBSypyAf/4ZiOh2GHhZjLuY1whhQZzNA3sVHsmyICwpGjJ1OxgsahZ+ZydBcr927eTxBUXxD7wXkyr+t979SV3b00f4rZMDJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2zEgMvHg; arc=fail smtp.client-ip=40.107.101.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w0NayTiUqoo3gs/nTg9YPFaDg/p0o4JuM6lzXZCesGh18P4/iwWPhNqbODLK0TkoqPWYZwrMqrVmrFClgd3IBq4E353UgQpo56WEOVN4hIv1xo6NcA7dHSTEbevbARndMYhYo+wVw0zQzLFZ1gUkxnxabacwqoq95FCj0aCu+TaBUbTp2SNosUrI3rQrQ8mx1MUEBaB+aCUoo09o2uwWHRqa5AgWvwyEykPhFFKai6uP7RQ4tOCsOd8RaBWOmF/cjQ64GU3WYD5w+8ipo2XjACHriqXZW9e632X12k4Wms0eCERFd5PV0LMrk1GPdBeDqYoYykLCPz3p7CrVuQQQcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v8a+2l5d3uzIPrqBAj+Ctb1TjuJxRZvwZ+LMNXpw4zI=;
 b=yg0STnb8uJbBDpgDxDP7E+HtaDdi04Tnfs4GfI7mrljnj8YWFVga3/LhQZIHEZs5BYtrEVR8RRZRHpf2AZpDorHZDgNc2JntusdSvpbogaVlldKMn8p1ml5LW+lLHBZiz1E2wwD5pZssQsyEcuz7fj55TTMt9hCgw/IaBmf5657rik3NGFA4razreciG3syxMwERf9Od0LaKxRCW0kbnV/CNDTFC8GChgKVGxu94XfomPMt016858bIFqE3gk40i5R51exanXDSWL1enQFDh8Bzs5xSqJVG+3o93hznaGtP+oA+aVYJot5KLdxi166oF+fb1teSwPqyXdx/7WJIAPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v8a+2l5d3uzIPrqBAj+Ctb1TjuJxRZvwZ+LMNXpw4zI=;
 b=2zEgMvHgwycfP3GXqZDaqx7y7pSgxoVlVRrqbXjXUJuiIDcYOGrWb8Uj7iO26KsLikhdicSBe3jdbRMEa5R8WnLVVvtWPKviam1PXZ32dufUZ6jS6EOqt6nmnTOaA6r8IJ+2REKzmpPJ8OgeqkkfOGhy8Ze6HUQuFIuoT3x43x8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by SJ0PR12MB6927.namprd12.prod.outlook.com (2603:10b6:a03:483::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Wed, 19 Feb
 2025 21:00:34 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::d22d:666e:be69:117f]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::d22d:666e:be69:117f%2]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 21:00:34 +0000
Message-ID: <43c7dc71-3fa6-48ef-89ef-518580996ac8@amd.com>
Date: Wed, 19 Feb 2025 15:00:31 -0600
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v11 14/23] x86/resctrl: Implement
 resctrl_arch_config_cntr() to assign a counter with ABMC
To: Dave Martin <Dave.Martin@arm.com>
Cc: corbet@lwn.net, reinette.chatre@intel.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 tony.luck@intel.com, peternewman@google.com, x86@kernel.org, hpa@zytor.com,
 paulmck@kernel.org, akpm@linux-foundation.org, thuth@redhat.com,
 rostedt@goodmis.org, xiongwei.song@windriver.com,
 pawan.kumar.gupta@linux.intel.com, daniel.sneddon@linux.intel.com,
 jpoimboe@kernel.org, perry.yuan@amd.com, sandipan.das@amd.com,
 kai.huang@intel.com, xiaoyao.li@intel.com, seanjc@google.com,
 xin3.li@intel.com, andrew.cooper3@citrix.com, ebiggers@google.com,
 mario.limonciello@amd.com, james.morse@arm.com, tan.shaopeng@fujitsu.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 maciej.wieczor-retman@intel.com, eranian@google.com
References: <cover.1737577229.git.babu.moger@amd.com>
 <d0bc17f3f5be4175df34011a366136cddc8df6e2.1737577229.git.babu.moger@amd.com>
 <Z7XdagRzP6cX5yn4@e133380.arm.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <Z7XdagRzP6cX5yn4@e133380.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0103.namprd05.prod.outlook.com
 (2603:10b6:803:42::20) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|SJ0PR12MB6927:EE_
X-MS-Office365-Filtering-Correlation-Id: 69b91b78-69eb-4a72-6693-08dd51287392
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MEdPcnZtaXNDQUdYeTNneWltVVZzSjVrY0owZGNoM1UwTmQ4ZVd0QXp5b3c0?=
 =?utf-8?B?cVcrclFoR0ZrQUQyREdKWUY4UloyZ05UbzlBbXNsTENnMlZVVGVsbDUvbzc3?=
 =?utf-8?B?UU1uVHZNTll1SkxGOTRPWU5ZTjN5UzRQY0t4WEtaQ1pvYjRnaEMxekNIeTky?=
 =?utf-8?B?cGpka0xRYmJkK0xKNlhyeUE1Mm1UOU15RlFkb0YwcnhTckVtTUhUcElHdlRq?=
 =?utf-8?B?ZVJ0M3NYTFJlSjZXYm5MZWpzNnR6RlBGT0pmbE9SWXpjYVpHWVk1U0tycHJl?=
 =?utf-8?B?bll6YlZjWXh2TlFiVE1CQkFYU0FyN3VOVnNlUVpzekJpN2xqblBMTGVyc3NS?=
 =?utf-8?B?a05TSkxXdklIK2RidnRUN0FTN0ZsYys5NmtWQVZ6cDg1SlM2WW1QSzBqRDdy?=
 =?utf-8?B?dHA3TDQyRlVSWjNGQU9KdERGeEFiNE9vaHNxUDRQcDZlSEVYTzlXaEppWkJO?=
 =?utf-8?B?eWNiVU1xK29JT0NQVXhZTE4rK1p5NXJwV21YL2ZXOGR5SlZvdENWZFF0ekJD?=
 =?utf-8?B?SUhpNFZXMFdzVEttaUVBRWR6REtlNVhlS1AySFZQWVN0ZXRlUXlVRG0wK0Rx?=
 =?utf-8?B?VjNWQ29kTUYxbVBSclEyTDBMOGVQbFFWdi85K2NtRzRXeFhLR2dnYnF4c2U1?=
 =?utf-8?B?SGpRTjJIMUxkenNDZjYwanFmcVBKZFg4dzJwSWdSL1ZKYWlkSDdOZVd0Rzdx?=
 =?utf-8?B?dUhYSkIybVo2alRQcjRBVjdDM3VMSjZNVGk3RVZwWTViY1RmYWxEZS96bDEw?=
 =?utf-8?B?NW9KOEdFRTRxM0xtazV0a042VjRVSEQweUt3UTh1Z1pZc254aSs1aWovWGZQ?=
 =?utf-8?B?eDhPcVRjdVhXcE0xUGd4WjBCUm82cEVXNElLUU5haThyNXlOSFpTMjBLOHlB?=
 =?utf-8?B?ZTQ5K3B5YUhnV05rUXpabEJaWTR4ZFBiTmg5aGp6SFIvSG8xUWNVR3hOY0l5?=
 =?utf-8?B?QjFleUpxZldLbTBZaDVKRkljb3ZZelhVUVZ1Wi8vYi9UcVkzSkVaUFFmZzhT?=
 =?utf-8?B?NFBhVVVZV0FnbVZuNGZvbHFRdjNsNVI0amhUOEZpODFYd2xDNWp6Um85bExi?=
 =?utf-8?B?WW9laFhJRHV4T2xXNzVxRThzL0N5ZjlFaTNwdkt3RythbjFhNWVDOFhLTVhZ?=
 =?utf-8?B?dWUxM2g3U2ZCSjZOczlrT0xEc1lOc3pVazYwUXVpOFBGZkxUVndIS09LdnI5?=
 =?utf-8?B?YjY3U3V1eDdQZUNsRlFSQU1ZamV2ck1VbVpKd3dsWE5aZXZQOGhtVWJJL2lX?=
 =?utf-8?B?c2ZXSmhNLzFoRUdMMi9ya2FZMjN2eDNpclFHQndIS3NJSEMrblZuWVA0bmZt?=
 =?utf-8?B?Z1pHSnl4Q1pML3V6Q0hoSDVOQ1FMdExvWXVQdStkTzlUUFJlVmFNbHh2bFBl?=
 =?utf-8?B?OTZJdUE0dUJvT2dpUzcxcWdNempBVmlXWS9sOGx3OXdibHdXWDRMckU2anlX?=
 =?utf-8?B?NkpsVk14L3dqVUIyMmNXREhocjg5WGpvVU5NUFVocGV0dFFMTGhCWW5HVU5R?=
 =?utf-8?B?bms4clMyNUlPRUNXMHVTcnRYU01yMHE5dUFCaTIySUYxSERhVTVTbEd4eVB5?=
 =?utf-8?B?NlV4YUdlQmRhL3pkMDVEb3R5eVRuM0taQjh6S0RSOVRBM2ZSdWNraDdSMFVC?=
 =?utf-8?B?RUJzTVNXYnJOdzJNd1diNG9oTGFGdVdhelFndytiVXdRVlh4ak0xZzZnVGYw?=
 =?utf-8?B?TU5qaVM1QUkxTXA1KzEyWllWdG9HMWFwSmtKSy9LN2p1REtBZ3ovcFBWcjJD?=
 =?utf-8?B?Nlg2SWdzcXRqOW9sd3JZT0l6Wm95eTdkUGVvVDdnTE9ZdVQ0N1l6VGVpTzJI?=
 =?utf-8?B?NzYyUTM1QWNQT3QxUzZydz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L2dqZmdTY2FqZzB5VUk3TERIVkd1Y0RGRUdpamtOT2p0QndRVHVqTFU1eURu?=
 =?utf-8?B?R0h1OUhHdjhTNlNjalpXdDdGa0tzcmJhdytQL0M5K0EwM0dTUGx5Sm0zSUhY?=
 =?utf-8?B?RGdKVlRucDhTcnJwY284cVJMVDQ5SEg1WjY1bnRsY3kraXBCdTVhM1RVd2g4?=
 =?utf-8?B?ZjQvZHBSNThCSUdKT1lTUDUwT2RWZHVBL0xvOWd2UHNxdktrTzdoUHNLS0ZI?=
 =?utf-8?B?MG1ZemdpTVJ1NnFXYWlhdVFMa0hyRElLNnhuMWlZTFpuTEhObDdNOXR2VkpM?=
 =?utf-8?B?K3VTcnFiMW1BMUNrVE1EWENEb3ZWRmIzZE9VdExBS1Y2YytTVGxWQ0J2VDNP?=
 =?utf-8?B?REcrSGx4clVCTStOc0gyQm00M3Nidkh0dGI4TFdXS1BvQWhpK1E2RVd1UFEy?=
 =?utf-8?B?dTlWTjVBZjN0eEUyUUdVanFhUmc5SUdyT2ovUldEdStBODlTaVNTU0J3UHp4?=
 =?utf-8?B?RWxvWGEvOHZTdENqR04xNlBKeHBMNUVFZXowaTVkNFc3Rkh1M1JEa2hNQ2p6?=
 =?utf-8?B?VUgrRmRtbHRLMUM0SUtDL2huWDhPTlhXNlA0Y2s5Yk1DYyswZWdvMi9lTFlK?=
 =?utf-8?B?MDF5anpGQ2dtZkVSR1FydFlEM3orTUVnK0JWaThYQmp5MnlpOTFUR3NjQmIv?=
 =?utf-8?B?R3hNcG53MXRoTUVEbUFVREIxd3o4cG5LTXQreGp0cmlYZmowYmZQL0U2T3p5?=
 =?utf-8?B?bXJSb1MrVGlZbk5Wb25ZUFRab21Id2hWb0I5U1FUUWdzR3J6THhWZ0RqTkxV?=
 =?utf-8?B?WnBocThURnNITTRIMmxZR2N2U2dOMHpXMmFMNnVwRlVRVXZSWW9SakYydzF2?=
 =?utf-8?B?cDRlK1ZpVXJIdHZ3NkdPWDVSVTRJVUdyVEFVdmI0MTdrcWxoWnJQMURnQ0p3?=
 =?utf-8?B?RjAwNzcvZ2cxejZFSWZVTS9mMlIxVnBpcFliQWd1b200TnpDanJqaU9sd3V6?=
 =?utf-8?B?d216dDcyRG05cXQ3b3lubXYyL3lPZUo0SUZmcitHZkhRTndxN0p4NlpsRWtW?=
 =?utf-8?B?bEJOOWF4djcxYmQ0UUVPNmprclY2ZGZPdGwrS1NJS29YaDU5ZDNhc2gvd1Ir?=
 =?utf-8?B?cUwzckh0ZDJaRDdLbUlaNlNTK1ZDbXhDLzZBalpuRnlLaDRjVnZ4TlFCbXFR?=
 =?utf-8?B?cUtPc3k0NThmQmtGdjFlT0N2SFZQNWZXTFdPRzVvbVVYTUhpTFJhKzdGcERK?=
 =?utf-8?B?M1duUlhhOVJMR0QxU2JXWkNPdGV4UnlxUkNJUEgraHRWS2s0N0x6azl3MGFN?=
 =?utf-8?B?VnlLb053NTJoa215anB1eWMwUXN1NWMyOHJ3cHZtTVRrRVpOWDFEWGlTTEk4?=
 =?utf-8?B?WW00ckxpSDNlUmU1cjM0alhOOHV5MlBsZFFud0EwYmVKRjc4ckxYaEc1ZE1o?=
 =?utf-8?B?WkdMbnh5bGdjRmFTQmVNalhUb210VkJBanFoU0dRdkFyb0EyamhhMjJGZWRy?=
 =?utf-8?B?dVcwNEpmNm95bGtzOHpwWi9LeE9SdjQrS2xLdmxGVWI3ZUJRQXEybGdBbG9v?=
 =?utf-8?B?RFJabnJBdWd1M1VMSWI5eGJqSnRxVnlpNkJBNDQ2NmJpZEJudEN1cDFnVVhL?=
 =?utf-8?B?MW9SWVQwRVNKWDJyOGVLZHZLUE1mVWRWVmxDclZjamtuN2FxZmRpOGdGYnVQ?=
 =?utf-8?B?MDRoNFM5c292cld5RkxyRUVqNzd2dkgyZzJPYXZNYkhXMkhPazJMMi9jTkFr?=
 =?utf-8?B?RWdiWHN6MXd6TXFMaFVmWmhhRlNIWlZwMEE3VWtWOHZJZTJOQnI4S2swaVFR?=
 =?utf-8?B?QTVyelVmeDFzVUxldzlKTFFQR1RuUTl5WnlsUTRGd01jcGxYTFNYNk1xSXdY?=
 =?utf-8?B?SlJUWWpNbE4wVWhXalNUbllUbElYdnQzSVpPc0FtQW1DQnVWWHE1UWd4eVNN?=
 =?utf-8?B?S3IvUWphMHdPb1Q3NU15QmdpWWRpRm54TUt5RFFXeGgxbmlyVVoxaUI3dWdH?=
 =?utf-8?B?ejVodnRXWmJNb3FGa2N2TWExWXBYd3dzM1lGaWJEa1RaUmpscE1PM1NPelBq?=
 =?utf-8?B?TWZlY2VhZlNFTzBicTYvRzd3RUZnODBpRkpmY0lJbHEzQ1F4dDJYb0FTYkx2?=
 =?utf-8?B?QUw0WjAyZFVNNkgzNEJlNHRjQlRmU0VsNS81bllmTUgvUGJlMzNNVWcranVz?=
 =?utf-8?Q?saHQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69b91b78-69eb-4a72-6693-08dd51287392
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 21:00:33.7641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: obZyOGOe6OZD1DCXsRjNmhpSE8GvLTJyiL7gIFJOl9mxeWX7EGjrKw7hD3TQNuZI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6927

Hi Dave,

On 2/19/25 07:32, Dave Martin wrote:
> On Wed, Jan 22, 2025 at 02:20:22PM -0600, Babu Moger wrote:
>> The ABMC feature provides an option to the user to assign a hardware
>> counter to an RMID, event pair and monitor the bandwidth as long as it
>> is assigned. The assigned RMID will be tracked by the hardware until the
>> user unassigns it manually.
>>
>> Implement an architecture-specific handler to assign and unassign the
>> counter. Configure counters by writing to the L3_QOS_ABMC_CFG MSR,
>> specifying the counter ID, bandwidth source (RMID), and event
>> configuration.
>>
>> The feature details are documented in the APM listed below [1].
>> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
>>     Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
>>     Monitoring (ABMC).
>>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
> 
> [...]
> 
>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
>> index f2bf5b13465d..ef836bb69b9b 100644
>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
>> @@ -1371,3 +1371,45 @@ void resctrl_arch_mon_event_config_set(void *info)
> 
> [...]
> 
>> +/*
>> + * Send an IPI to the domain to assign the counter to RMID, event pair.
>> + */
>> +int resctrl_arch_config_cntr(struct rdt_resource *r, struct rdt_mon_domain *d,
>> +			     enum resctrl_event_id evtid, u32 rmid, u32 closid,
>> +			     u32 cntr_id, bool assign)
>> +{
>> +	struct rdt_hw_mon_domain *hw_dom = resctrl_to_arch_mon_dom(d);
>> +	union l3_qos_abmc_cfg abmc_cfg = { 0 };
>> +	struct arch_mbm_state *am;
>> +
>> +	abmc_cfg.split.cfg_en = 1;
>> +	abmc_cfg.split.cntr_en = assign ? 1 : 0;
>> +	abmc_cfg.split.cntr_id = cntr_id;
>> +	abmc_cfg.split.bw_src = rmid;
>> +
>> +	/* Update the event configuration from the domain */
>> +	if (evtid == QOS_L3_MBM_TOTAL_EVENT_ID)
>> +		abmc_cfg.split.bw_type = hw_dom->mbm_total_cfg;
>> +	else
>> +		abmc_cfg.split.bw_type = hw_dom->mbm_local_cfg;
>> +
>> +	smp_call_function_any(&d->hdr.cpu_mask, resctrl_abmc_config_one_amd, &abmc_cfg, 1);
>> +
>> +	/*
>> +	 * Reset the architectural state so that reading of hardware
>> +	 * counter is not considered as an overflow in next update.
>> +	 */
>> +	am = get_arch_mbm_state(hw_dom, rmid, evtid);
> 
> Is this necessary when unassigning the counter, or only when assigning?

Yes. It is only required when assigning. Will add a check. thanks


> 
>> +	if (am)
>> +		memset(am, 0, sizeof(*am));
>> +
>> +	return 0;
>> +}
> 
> [...]
> 
> Cheers
> ---Dave
> 

-- 
Thanks
Babu Moger

