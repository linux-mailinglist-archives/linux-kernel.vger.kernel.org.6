Return-Path: <linux-kernel+bounces-221631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2BE90F674
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 20:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94C901F25173
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 18:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F0B158DAA;
	Wed, 19 Jun 2024 18:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Am6jDhIK"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B244A1586F2;
	Wed, 19 Jun 2024 18:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718822810; cv=fail; b=dVIuYxevEMDnRbcZbIZrmCAWDbbMwAXhM0WiHFSaqon7i66gYkUYooI1bK0D54TZ6gPq3EEjGBpfRU6k1sLYzHybfEo+UXW3w7F+TNiGWbU32tDbNid4EQfIRhRUM2beGFie8g//ny85OGE/RpahunyT2RHfN1kha8ddJL7V1kY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718822810; c=relaxed/simple;
	bh=AD0e4Oy7tXh4jsvoVtgQfE0Q+zHIOxUV1lzMLHN2W5w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hyiBWMdVQITKnQhNdYWe9W4O5roTArEuYOoYkfrexej8GWUBqyNQ5iDkdU2TIAsy8iat9J+6GgQZUq+qU4Y5SmBV9G4VbBcLr6W0EdG+qC6VwyNL2PXwMNCwesxAK0t75yNR1tz1PsYHujmy6nstfugfihPPj6KxA+bNCYTAA/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Am6jDhIK; arc=fail smtp.client-ip=40.107.93.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lVAYnxqYIlTzyPg3irNUTymTbRvxpBZNajZ46BCd2/sqMJNCfmW+/1FW3FplEB8mJ9+FZyZPu3nL+gWuulLwRhXiPdYpoIUTWxplr1BuQn4jsH6KSunV6zEk6FL+ACGvbmDGmZee0STTtjphIx5skuCpdCVbqms5De5Vwf4xHBFOb2809aNDpNJwkedtcdEAMOuqnoJauX9Of6BVFcKV8kA/ahkknPlEqfN8XvlHGz8P+INzafUXvSciIVWeqSvKg38icXMZu4+tp3TdARrDlUh2iim7BSfFAmtxCy9u39ZMpea7OeXpYsuoGyz0lYKZqc7oRchImVGRp/gpwZ8zvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=edloutD1tKttnTCeIa1t3t8e4//aZfQLlSysfPQ2Dm0=;
 b=MVwbHm7lDJ9GDUGR0Un4VTrJgO6yIu3AiYGcPGO/hdLPLqY19D2W7ikWdBxSNZLpIPfSdJGS3KjhqrGHOAlbfChEvlZwnSFxQHOtNLSusYMBQ1qF9nGWaTfoADSXje9Z78jZXnJ5q7io3zbhPO52j+rN4K8pAqP3TRzrPwlZD9qI2ewP3XikvcsuWmSAAcSs4gwkKeg+mNPJyXkcqtC3qds07H/jvEyf9lgFqKzUcgWAP5IPk35gEu6oCMe3ZQ6dJ4i0eM6R8cQJ327+KrOcWgKM3pZ8Cgeel90Y6gjYvW9n6RkVBogRACCo7+UUWBjh4DXsAqN4dKYsztbF8WwGBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=edloutD1tKttnTCeIa1t3t8e4//aZfQLlSysfPQ2Dm0=;
 b=Am6jDhIKMiWhKt3s5v8N7oWNfCZWtAzM+/a0PfSk9WnSjKxmag22Fi0jxPOIqU1XK66bsuVJgMkq3XEPvyZXc6x3uy2X3YxNNMZcfE/aufXTcJZ8NWbvYbOA/FYQ2jRs0F66NL4/zQWc1bmkLjPzfbndyRDT3FpoBK82dZBFpEk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by LV8PR12MB9183.namprd12.prod.outlook.com (2603:10b6:408:193::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Wed, 19 Jun
 2024 18:46:42 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.7698.017; Wed, 19 Jun 2024
 18:46:41 +0000
Message-ID: <865d2f2d-7dcd-4371-8e98-9e6f9115c04e@amd.com>
Date: Wed, 19 Jun 2024 13:46:37 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v4 11/19] x86/resctrl: Introduce mbm_total_cfg and
 mbm_local_cfg
To: Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
 fenghua.yu@intel.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com
Cc: x86@kernel.org, hpa@zytor.com, paulmck@kernel.org, rdunlap@infradead.org,
 tj@kernel.org, peterz@infradead.org, yanjiewtw@gmail.com,
 kim.phillips@amd.com, lukas.bulwahn@gmail.com, seanjc@google.com,
 jmattson@google.com, leitao@debian.org, jpoimboe@kernel.org,
 rick.p.edgecombe@intel.com, kirill.shutemov@linux.intel.com,
 jithu.joseph@intel.com, kai.huang@intel.com, kan.liang@linux.intel.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com, sandipan.das@amd.com,
 ilpo.jarvinen@linux.intel.com, peternewman@google.com,
 maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, eranian@google.com, james.morse@arm.com
References: <cover.1716552602.git.babu.moger@amd.com>
 <a02dd2b9fa06f360eabe923c5c6d17fa4036aa9a.1716552602.git.babu.moger@amd.com>
 <48e0d78c-5ed8-4b93-8f12-3ce3fd74116c@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <48e0d78c-5ed8-4b93-8f12-3ce3fd74116c@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0047.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2d0::20) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|LV8PR12MB9183:EE_
X-MS-Office365-Filtering-Correlation-Id: e821c7e3-47df-41e4-2103-08dc909028f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|7416011|376011|1800799021|366013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZHNLNDlLWldNTDRPMTRqSVpORVhrYjZBRlg3RVVyeER1VlhtRHMzUndzWHE5?=
 =?utf-8?B?TDBrOTlQUHdKYTdXdGlaVU11SkwyNGVFeFVpOUY5UnJjQXdDYUYxVENTWm1m?=
 =?utf-8?B?Vk5iV25VbHh3bEN5YThDbXg2TzMxZk5LYTBVZDNwYmpzdHdjU29zVWN3SUw0?=
 =?utf-8?B?Y2t5Mk1xTDhVVjViSWdFWTA1TWJjL2dCVmMvTENkZkFXYndhZXhrK0xJN2ds?=
 =?utf-8?B?czEyeEdNeFdIa3ROL3ZjOTlUNGV5eVlXVVVaeThtMnZWWnVLN2duaEdydE5z?=
 =?utf-8?B?NWRiYm5KTDNTcVRZaXhFcndrL3VrL2x0OVFqWTdXdEtwQTg4RHpjdVFyNWJ6?=
 =?utf-8?B?eVlpY2N1aFdhRUxQTGVBSXpaaXVVaU80RUhqVGs2OTRnYzhmc1FoVW9JSnZJ?=
 =?utf-8?B?N2k1ODJlSlB0TzVVNCtjRk1tOTdZRU9JVUprZlRKRmthbGxDaU1WeFlsbEVa?=
 =?utf-8?B?VituejdlbmVUWlhCNmVvZjZUaHh0R1dydW4xNWo3d0dUNDNDRGtkMlVHNFdX?=
 =?utf-8?B?S2ZCRm1HS3FuZmZRRU5lM1BpZVdrUFROYUtpTEpJdDFETXFDZUlrTFVGNXJ1?=
 =?utf-8?B?c3hoQWpoR1RSRnNmaVlCdUg4L3U5ZHFjeGRpN01zR2lvM245d3BQM3VtY1ZY?=
 =?utf-8?B?VUtpbFVNZFpFL1hQeVZzK0VNekUvRHZ1d2ZsdFpYWG9iNHlORWZGZ0NMTVgy?=
 =?utf-8?B?Qys4NCtSbTlPZkNDcTVCbnZYbEEwT3grSE5KK0ZKcEZLa3dGdXpoOWduSmNo?=
 =?utf-8?B?cmpwZmU4Q2pXQlYwcmdsTzlXRmFKUHdyUnVxNkRLMkV6dHU1d3p0U2tOUVVp?=
 =?utf-8?B?cmNScVVJVG92ZUdqYkRleVA5Q3NMa0ZqelBDOTlnQUVxT01yNzFTQ0tSZmND?=
 =?utf-8?B?TU1BOFpidUtuTkQzUGJyMmk1bzRwK3NWQXRseXZYWnRoMWRnUXVjZFNicExt?=
 =?utf-8?B?OUFYd2JWTiswWU5wZzNoZWk3UHEyYmZ4Rk50SXdKN0lGQ0hwb1RUUklmQktv?=
 =?utf-8?B?UFNtMTBLM0F5R3NxS25lSlZocnozVUhrVk9kS2hISG1CTmoxSFRMR0xtOTNz?=
 =?utf-8?B?S2J1T0dmZWhTcndhSFA2dFV3MjE3SFpXVzJlTHEyZGdNNWRRSWxXdWRUNVJE?=
 =?utf-8?B?Wkcvd3dnaEc2RHZscXovSkRxZ2pzU1U0SWhwd3NPeFF3RkU1Z3FvRmVyQ2V6?=
 =?utf-8?B?ZHdMNGdDYlV5RFlSYlZSNnhKbDBla3luWXBLQ3BpT0VQTlBqVG5nQTVPeVdp?=
 =?utf-8?B?UW0veGhnZ1BNclh1RG1yWG12UGVJaVJGUlh0azIranJweDBQYktwVGI0OVFC?=
 =?utf-8?B?TVJoRkNlZDRVbFlFRyt0SFNESi9kdHFFOXgydkxJbUpJRnAvNkg2eE40Rkh1?=
 =?utf-8?B?NmxucGJRemREVjZFZHp6bGsrWTNjeVYrMTFoR2VEblh6MUNJenhxMmordEtM?=
 =?utf-8?B?SmR1Nno5dG9sUDhTeHNzd00raWR1eXR6ZS95S1NBd3kzZndLb2FzWE1CMnRr?=
 =?utf-8?B?bzAzNk1OS01PRDJJSVpobmJ4SjBVMExudzhEeTBCTzdSNmlPR0ZHS0FNdU8v?=
 =?utf-8?B?bjk4OC8zRk1sZ21NSVp6LzhmUjl1WHB6OTlsai84aEZrdnd4eFYxaEhNblNv?=
 =?utf-8?B?SVVPUHkxM0ZubnNicHBaalliM0MrN1dzVkduTEl0WVFBZUZrQXF0UHg4aG55?=
 =?utf-8?B?N29CL1BLbDF6bmU1YzFlLzY3Z2FZU3N1QTFIVUIvM3hVS3UzVnpWTUFBRHQ2?=
 =?utf-8?Q?/PW0QRTnezQbdVyxa0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(7416011)(376011)(1800799021)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OENQSHpXRWZLZ1Rvd3dBRzJ4QVVpSkhzem9MSmdZYnBvMFVMeFJtVW50MmJk?=
 =?utf-8?B?a0cyeTdJWTY5djJ2a1FzMmlVRWpjUDlVM0xmQ3hJUlNuWSthMm9XKzRlRVB3?=
 =?utf-8?B?WGdnOFpsZXZxeDd0Z0Zrald6elpqOS9PUzV5cUNQdHFWZkpzZjZ2aUlNdGc4?=
 =?utf-8?B?ZG1hcXdmakdpd1RKTnd4RFJIYWFrMEFhU0tvMXFYUVh6c1o3b3lWT1lkNm9p?=
 =?utf-8?B?NHQwV21wNU9NODVSTUw0MTBjOWEvSFdBSlgzTjk3a0F3dXVObGVxRXZJUUJS?=
 =?utf-8?B?d1BTTnZ6U2FISXlNNzBUeHBNTFY4T0NVd3V2NUM3bUlrSXhsejQvTjlDSXF0?=
 =?utf-8?B?MVFHclRUUUlGNm9DaWxXcVY1VEh1UC9aZE9uRUZwTzJheEtiUThkYjBpU1h1?=
 =?utf-8?B?bENvS085aURsMmExamZBZVVpalh0NUNPa0lJN3cwWW1waHd2YUtTdWRkaGRH?=
 =?utf-8?B?YTdoNDh1cGpoZjBxUmY4dXgxVzZYNVN1UUx2dnZxRlc4YTdTT2VFd1NabHlo?=
 =?utf-8?B?MnV2OFhWVm1EbW01Ni8wTEsxU29GYlN5anVxOGYyc1BVRVFPSEU5aGtjbm15?=
 =?utf-8?B?bW94M2NlV2pEd3FzN1BTWkdPaStUaUc5NWR2dDRuSlFrZEZjUVBlSlI5dGhQ?=
 =?utf-8?B?R1VVSHJnM3cwWUN6c0RuT3hWOFljSWkzV0hQQVNscnpZbFJWNEFJOU9CWHl5?=
 =?utf-8?B?QkpsblpXR2orZWRxeVJiNU0wVTZmQWJnSVJpSDNDb2owdE50anlPcGMvNk1n?=
 =?utf-8?B?L3ZiUWlyZS9QSHZCRWhMbjFkUjN0YVgyZlVwbTg4SzZHS21WV3k0WGk1Wk1M?=
 =?utf-8?B?U0k2ZTFESEJWTldGL0lOV3hzNFlCeXpzZ1ZKd3dmVFo5UnMrNE1UOXJPLzNh?=
 =?utf-8?B?WWdvc052MHFOZ0RzcncwaEpqZ2ExTGtZNlZyZk9QSWg1dHQxVzIxekIvNGNW?=
 =?utf-8?B?eWVyT2hCQnRtQ0pxdE4yQ0phV1Qzb2ZVMGNvUEJXc0hhekRGV2FWUnkxQ0Fz?=
 =?utf-8?B?cVBqb0hHeXVuY0JrcTF4WDBURjJxZmhCQ2lGZm1lclN0R3RzT1BDZmVCR05Z?=
 =?utf-8?B?NDZJem5LNEVBUW50ZTlFUDJCYkRsaENtMmVVS3FBb1V0QkR1QlY1QmFnS1Fj?=
 =?utf-8?B?aWJkVHFOUGRlNGZoUGd0SlpLZnRLSVd4LzR5Sys2bktDV3d6M2tJd2Q2bG9P?=
 =?utf-8?B?T0ZGcjVXaitXcXVrbVhubldqNlBQUW9Dd3pSSFpCZ2c5M0hxL2h1ZkxUcUMy?=
 =?utf-8?B?NDRNQy95Mk02dGNkZzhHY3Y0M1JSMEtQQlVuZll3Vlh0d0toTUlseDNLWkxz?=
 =?utf-8?B?VkdLSHFlWlNXSlNENzJPY0thc1hwL3VjcFU4TGRIYjJkd0g4MndrQnI0TkhB?=
 =?utf-8?B?R2RtVUJOL2NrN1p6Z09hdFY5dWxJWjNLR1hOWVBqVkQzakpxM3Nxc0w0aVgz?=
 =?utf-8?B?ak9vM09COHNWV3N2Qjk3bXA5RCtxcmptRFEvdnVPTnVQVlNaMVMwM0FBd3l2?=
 =?utf-8?B?OGVsSml1VjBJK0dZZlR6cXhjOTZMYitCU3Q4cUlBYWxIaHhBRmZOVGZKNGpX?=
 =?utf-8?B?dU5BQ0dzdVhmSCtJdkRHYjIzZURjZGxUSVhiVHhqRTVRUFQzVk05d2I3YW9v?=
 =?utf-8?B?YUhrTmhtditZY2dqa3lJY0R6VUYxUUZYU0Y1WXBaVUNsZmJ1enRJbUNIRHRT?=
 =?utf-8?B?YWVUWWtMV01PWW9DdGhKL0FMTWFONmVFNDBhNHZJNlJxKytwdFpKNUZsSGpE?=
 =?utf-8?B?bENjRUhScnhFdEZTemNHZ1pqbEpYWFg5YmdiNmtib1h6WWlpb3ZIbzEzcHcy?=
 =?utf-8?B?NUhlclpxSEJVdWJpcFVIR3RaVUpnME9TOXBGUVVkd010SWlLc2xMRnVBWFg4?=
 =?utf-8?B?bGxVN2UxVGZIdE95TTF2MDR6b25CMjA1K0ZFcDcrZS9md0sxaVhiSy9CQzVK?=
 =?utf-8?B?YkswUkR5YlZyc0t3NUVSRkEzVGpCQlkxQlh5SUtXUEl6dGtXTVU3alhmTkhj?=
 =?utf-8?B?b255TUh3ZGZoeUNNRXlQMmpueGtJSjk2YXZMTTUrU1NBWkt3Wld0ZHd2M1FV?=
 =?utf-8?B?dllLa1doZVY2RTNkUm8wKzQwWDlScGl5TitLdGdTZ3VJMjJkNVcyb0tNVC9U?=
 =?utf-8?Q?aTDg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e821c7e3-47df-41e4-2103-08dc909028f2
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 18:46:41.7932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CZELnsXXxj/4BW1wadgkcjkO/myeQYMQUVzcWj0mJKryHxNJ1OwtAcj8JcHFOhOd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9183

Hi Reinette,

On 6/13/24 20:43, Reinette Chatre wrote:
> Hi Babu,
> 
> On 5/24/24 5:23 AM, Babu Moger wrote:
>> If the BMEC (Bandwidth Monitoring Event Configuration) feature is
>> supported, the bandwidth events can be configured to track specific
>> events. The event configuration is domain specific. ABMC (Assignable
>> Bandwidth Monitoring Counters) feature needs event configuration
>> information to assign hardware counter to an RMID. Event configurations
>> are not stored in resctrl but instead always read from or written to
>> hardware directly when prompted by user space.
>>
>> Read the event configuration from the hardware during the domain
>> initialization. Save the configuration information in the rdt_hw_domain,
>> so it can be used for counter assignment.
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>> v4: Read the configuration information from the hardware to initialize.
>>      Added few commit messages.
>>      Fixed the tab spaces.
>>
>> v3: Minor changes related to rebase in mbm_config_write_domain.
>>
>> v2: No changes.
>> ---
>>   arch/x86/kernel/cpu/resctrl/core.c     |  2 ++
>>   arch/x86/kernel/cpu/resctrl/internal.h |  5 +++++
>>   arch/x86/kernel/cpu/resctrl/monitor.c  | 21 +++++++++++++++++++++
>>   3 files changed, 28 insertions(+)
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/core.c
>> b/arch/x86/kernel/cpu/resctrl/core.c
>> index ec93f6a50308..856c46d12177 100644
>> --- a/arch/x86/kernel/cpu/resctrl/core.c
>> +++ b/arch/x86/kernel/cpu/resctrl/core.c
>> @@ -542,6 +542,8 @@ static void domain_add_cpu(int cpu, struct
>> rdt_resource *r)
>>           return;
>>       }
>>   +    arch_domain_mbm_evt_config(hw_dom);
>> +
>>       list_add_tail_rcu(&d->list, add_pos);
>>         err = resctrl_online_domain(r, d);
>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h
>> b/arch/x86/kernel/cpu/resctrl/internal.h
>> index 5e7e76cd512f..60a1ca0a11a7 100644
>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>> @@ -373,6 +373,8 @@ struct arch_mbm_state {
>>    * @ctrl_val:    array of cache or mem ctrl values (indexed by CLOSID)
>>    * @arch_mbm_total:    arch private state for MBM total bandwidth
>>    * @arch_mbm_local:    arch private state for MBM local bandwidth
>> + * @mbm_total_cfg:    MBM total bandwidth configuration
>> + * @mbm_local_cfg:    MBM local bandwidth configuration
>>    *
>>    * Members of this structure are accessed via helpers that provide
>> abstraction.
>>    */
>> @@ -381,6 +383,8 @@ struct rdt_hw_domain {
>>       u32                *ctrl_val;
>>       struct arch_mbm_state        *arch_mbm_total;
>>       struct arch_mbm_state        *arch_mbm_local;
>> +    u32                mbm_total_cfg;
>> +    u32                mbm_local_cfg;
>>   };
> 
> Similar to the abmc_enabled member of rdt_hw_resource, these new
> members of rdt_hw_domain are architecture specific and should never be
> touched directly by resctrl fs code, for example, from mbm_config_show().

Yes. Understood. Will check all the accesses.

> 
>>     static inline struct rdt_hw_domain *resctrl_to_arch_dom(struct
>> rdt_domain *r)
>> @@ -622,6 +626,7 @@ void __check_limbo(struct rdt_domain *d, bool
>> force_free);
>>   void rdt_domain_reconfigure_cdp(struct rdt_resource *r);
>>   void __init resctrl_file_fflags_init(const char *config,
>>                        unsigned long fflags);
>> +void arch_domain_mbm_evt_config(struct rdt_hw_domain *hw_dom);
>>   void rdt_staged_configs_clear(void);
>>   bool closid_allocated(unsigned int closid);
>>   int resctrl_find_cleanest_closid(void);
>> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c
>> b/arch/x86/kernel/cpu/resctrl/monitor.c
>> index b1d002e5e93d..ab0f4bb49bd9 100644
>> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
>> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
>> @@ -1093,6 +1093,27 @@ int __init rdt_get_mon_l3_config(struct
>> rdt_resource *r)
>>       return 0;
>>   }
>>   +void arch_domain_mbm_evt_config(struct rdt_hw_domain *hw_dom)
>> +{
>> +    u64 msrval;
>> +
>> +    /*
>> +     * Read the configuration registers QOS_EVT_CFG_n, where <n> is
>> +     * the BMEC event number (EvtID).
>> +     * 0 for evtid == QOS_L3_MBM_TOTAL_EVENT_ID
>> +     * 1 for evtid == QOS_L3_MBM_LOCAL_EVENT_ID
> 
> This is what mon_event_config_index_get() is for, no?

Yes, it is. I can change it.

> 
>> +     */
>> +    if (mbm_total_event.configurable) {
>> +        rdmsrl(MSR_IA32_EVT_CFG_BASE, msrval);
>> +        hw_dom->mbm_total_cfg = msrval & MAX_EVT_CONFIG_BITS;
>> +    }
>> +
>> +    if (mbm_local_event.configurable) {
>> +        rdmsrl(MSR_IA32_EVT_CFG_BASE + 1, msrval);
>> +        hw_dom->mbm_local_cfg = msrval & MAX_EVT_CONFIG_BITS;
>> +    }
>> +}
>> +
>>   void __exit rdt_put_mon_l3_config(void)
>>   {
>>       dom_data_exit();
> 
> Reinette
> 

-- 
Thanks
Babu Moger

