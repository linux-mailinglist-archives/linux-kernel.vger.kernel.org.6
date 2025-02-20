Return-Path: <linux-kernel+bounces-522807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5402EA3CEAE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 02:28:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2F0F16D20A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 01:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F4D18E764;
	Thu, 20 Feb 2025 01:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MVQgUi8v"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCED2F3B
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 01:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740014888; cv=fail; b=JN7NKpVri6V/1w6jecZJUzCdxf2Yb5C15PNLCfPpgmFl222XoDCL10AuLk0dLBhW14YMVqrc4/TIzjh4wno1SpeSctrUlTWDhP5k4Ua6jUQ4ner46GG5Md1K2zTqwdWRxePHYRbb1Q8mwBYYaJwtwli2kyOVnthSO3G6TOeiXz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740014888; c=relaxed/simple;
	bh=CWqueOD7fCmU9t/gKfvFUsndyGEOy0gyGOstGRZoLss=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fsCsv//9ft/Ni7pBWIEegLSoypFvdyF2nzKFOCmg1kaNSkPfsEIQ2bbLAe3P2Zw4VygLcQXftD4uMcX/YDj1rJnpDJx9hUiyG3eE+RCkODlx4oL+8T57PVY8Jvv06W7dNZv8iukFBmWnkjFEskP/gzqJnevFNsX6Mq9hrmK9oYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MVQgUi8v; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740014888; x=1771550888;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CWqueOD7fCmU9t/gKfvFUsndyGEOy0gyGOstGRZoLss=;
  b=MVQgUi8vMVTMDgXFmVnPHyJvBadk9ywjj2pX6cEKpMJmJ5vUBEUs0hqP
   K25KLsHX9PaOHb5XouUSRWC4IA/9StVqHeS7qJPIx6XaLswRWEVrmHxGY
   d1NW+KrKeoSOoUKgSI4wvpZOH8JGdj78ukHhg4wBAj7CYUYF0jOIQ06ce
   Cy4ZENOiw7xRXu20Uy0Ib1Uw3EjC6qijrOcOvSDwWlaL4DbsWBEQc6vir
   glgM9NFpwe3V2zOe9fVJ3P73oBnBGgCx/RE2TpPSiGRX24AkpdNt8hdde
   DcaEA3qwVuRiK0EsfQKufXlwoxW5uv2egRnesiP5jjFzyFqe9HzE0z0Aj
   Q==;
X-CSE-ConnectionGUID: eLyRsGSIRUyDUKXEkIz05g==
X-CSE-MsgGUID: Ad/xPrXlQbSBcDAwKtCthA==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="58186913"
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; 
   d="scan'208";a="58186913"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 17:28:07 -0800
X-CSE-ConnectionGUID: UZtSZdPmTQSU8+Xnw4dyBQ==
X-CSE-MsgGUID: 64Q7qlzpQryc4HfC8+ISug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; 
   d="scan'208";a="114729227"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Feb 2025 17:28:05 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 19 Feb 2025 17:28:04 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 19 Feb 2025 17:28:04 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Feb 2025 17:28:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=smPQ9/nteFxrRXViTYuW/WGZDQSt8Bi5KTlunqBMal3QIQY7dCm7RCQmSAZNJcRb+WcvYpqwHUUKLnx1hgFlJFHKkKozI5XADWHvMpwa7Tzqxxl/YUClB4X1laB5lRNoBpfdVgZaAk6WQugCVX3bM1L7JUKjNTipKs/DOAeJVgYslO/0HbpaaOUfTnsg6AElUZcVzZlWKKlPPrephM2OqcVehX2qOiHy8NFShfCepHFh7hhTWylat5N3/vhdFQfs4HbWRZKw13SOrAWfv47QQwKaxI//uJk8xU1fPuVZy/Gy/mOK0U0mUEJrPR0K9XHsvFRVcpZAs24TLLad88aQoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=inf/TTTTUkKszkG3u4+QLuWGLOtldIgc8x5C3UyP7uk=;
 b=lwMBW6INRMgIXjg+fKMniSqAAcm3/DcDBeJ1jBc+xeYqmNw9KvhQmMhGidyFZ254VgpcOrFtEIPwmusiEpN/09X+pn3NudDxTgf0p8JXElmuVhrz0kY3VJfpOcOIZx+wS5swlsrq6sYzgJbYHnCWBJ5/i+i53VofpnXH0T5AMDxupKdLXe+lGBH66KtCkp9UHLZ0WSZ1hUKXe1pDpJx9xEa+KHa+uPPcPrXfbRXfjSQOv3+t1umcfqQet1VmzPxAmHp7C46tn3ya1zqOfJQGaxwzuAjqN5jIICS/0TsbE/qk8N8Z2UbfxHykxkA45MxNi/k/7GasSxN1L0yKCgJdSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MW4PR11MB6570.namprd11.prod.outlook.com (2603:10b6:303:1e3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Thu, 20 Feb
 2025 01:27:45 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8466.013; Thu, 20 Feb 2025
 01:27:44 +0000
Message-ID: <3749ab92-6f6e-43b4-8147-22775e31d21b@intel.com>
Date: Wed, 19 Feb 2025 17:27:41 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 29/42] x86/resctrl: Move get_config_index() to a header
To: James Morse <james.morse@arm.com>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>, Babu Moger
	<Babu.Moger@amd.com>, <shameerali.kolothum.thodi@huawei.com>, "D Scott
 Phillips OS" <scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
	<tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
	"Dave Martin" <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>, Shanker
 Donthineni <sdonthineni@nvidia.com>, Shaopeng Tan
	<tan.shaopeng@jp.fujitsu.com>, "Tony Luck" <tony.luck@intel.com>
References: <20250207181823.6378-1-james.morse@arm.com>
 <20250207181823.6378-30-james.morse@arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20250207181823.6378-30-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0020.namprd03.prod.outlook.com
 (2603:10b6:303:8f::25) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MW4PR11MB6570:EE_
X-MS-Office365-Filtering-Correlation-Id: de93dd5a-1fc2-4c55-df53-08dd514dc6d6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bEF3NjNOaGthWjhpNGhCMHFSM2ttRENLNzB3WHVUK01sOHBoNzh2UStmbXdR?=
 =?utf-8?B?RENGaGE1cGgzTGp1eWNLeEJyTXNtckpORnhxNGlyZ0pDZ0Zjb3ZpdExmRTll?=
 =?utf-8?B?WTlra0xBeGw5Zkx6MlVucUdKSHZTb1JTTGhLTDYvSVp5dlZuSlRCZEM2RS9S?=
 =?utf-8?B?UnpjSlZpQU9BT3ovZEZTdVZ5V3VBbGFqZVF2RklVZmI3aFExemZ3Qm4zM1N6?=
 =?utf-8?B?dWRRWUFIdjRwWG9VcFpjVUxEMUFYNWo0RUUxcTJRbWMzTUxxVm9FUmlpdmd1?=
 =?utf-8?B?MWdMVFNZd0NUNVpGdm83QnpaQThNMUlFM3dhdnc3YmlUVURJUCtRN29PYjM1?=
 =?utf-8?B?SXNHV3VvOGV1bC91aEJZbVoyc1NUL00zUzJnSTZzUXlPdnRHMjFaOVZ3NSt0?=
 =?utf-8?B?QjBJWDFPWnBOY2NJQVh3M2xQOGYwQS9LanRGakN2Rm4rbk94VmRrM25NKzRM?=
 =?utf-8?B?OUNjTjVSWjYxejlBc3NyOC9JTm1jblVOOGZTUTI5OXZMWXM2c21uRktFMFI3?=
 =?utf-8?B?K1lBQWVITXpselk4NTFzQitiUXp0L0RQanlPT3VLZ0pJVlhkOTljVWduYk5x?=
 =?utf-8?B?dzVZdGU3dUJFWFNvL1Y5eW15ZHdpRUJ4dnRoYlRpTS9obHdmOExZeEVhaWhI?=
 =?utf-8?B?VTZ0QTk4VVh3eE16YXZoOGxxQzZCWWZBajV2a212aXkydGdqZm5mMmJRUnZz?=
 =?utf-8?B?QjlrdWE1aEdiNDhEdS93YjJ4Y0JiQjZ2dnhTL2x5TWxZY2NZSVlhcDJvbXZV?=
 =?utf-8?B?Q2xzNkRQelZodnl2bEdTb2pxRi93ZjhjUWcxZjJxYnJWOWdkbERGUkN0STc2?=
 =?utf-8?B?enlFU3NENlBkWjZNdmtWOW96U2ZHLzEwbStIenpXWndMenk1RGQyMS80Z3hQ?=
 =?utf-8?B?SkQ1Vi9MQ0lWZ2RGTi9ua2pRRXM5V0hmNnhFSDJQNjVDdHplNUFzdUdLbUdW?=
 =?utf-8?B?aUExejNkUnAxcXhKN2lQeitGWVpjS1U2MUEvbEVFRis1bzhNUEdGZHIrODhK?=
 =?utf-8?B?Vjdqd3kyUmNscHFiN1lrSVMvc0cyYzFmaWE0MGlMczVkSUdRV1RMODIxM2Ux?=
 =?utf-8?B?TEQ2Q1RMamVFMHVRR1NKOUhJc25ibnh5eXVFb0dTRWJVZnJWTmloN3BOakRy?=
 =?utf-8?B?S1l6OWk4Uk0wVTdiMHRNMk5uM2pjaHd2R2wwalpkT0EvWSt5eS9lQ3Zidkt1?=
 =?utf-8?B?UTFZaDQwcXNHdUFTSThmcXc4bFBTWlZmRFZkRmpKaGlFTFB3ZzljNTBOc1Jj?=
 =?utf-8?B?eEV3bXcwVlBQN1VsdDVKa2U1NXBqV0gxSXZlTGtFeU9yV3BvMW1vNExDNEcy?=
 =?utf-8?B?R2tQdDlyTXRlN3B0ZWxtQmFYMmRrUFgwRXV1Tm9aUFhmU0RPa0IrNzNjOEpU?=
 =?utf-8?B?dTdBMmZ1cHhWQy96S1ZON2F4TmR4MGkxT3lGakZUSm5OV3BJM0pDbW04Z3o4?=
 =?utf-8?B?dFFOcWw2VnB5QWdiaXdubmQzdGtqbTIzR0ZsejdTd2ZPUG94TzhqMGkyV2I4?=
 =?utf-8?B?NG9kSzBneGh5cTFEUUUvaW9MZU5mYTRSWHlXU0UxTTNqQ1VOcFN5b08ySHRz?=
 =?utf-8?B?UzJ3UTVoU3hUcU1Wc1hpMnJlMXc3MDUzYnNvcG1vZ09kbWRYek4vdDJscjJv?=
 =?utf-8?B?a2g1TW1PTk9hWUZFaDFMUGFtY3AzUVlNRTNGaEZWOFJtS3dZS1R2WlNCeHlo?=
 =?utf-8?B?eXRpeVdyUW5NWkhEaXkwR05KeURwMUtQYm9HOWNOM29NdkR6S25jUWJQak95?=
 =?utf-8?B?cVVjUTBTbFNYdDRsS1EyMzVQYm1lOTdlQzF4bEUybVUweHRJOGZUdnZHQ3cx?=
 =?utf-8?B?VmlRTWFkTlEwSVFFVXhzZ2Q3Nm05Q2pRNWNVcHFPOWt5NjdJbUNWeXROUTFO?=
 =?utf-8?Q?g/IqWqZK0Ghr0?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHZ6U1ptd3A1ZHpZWnh1VlVSQlkyNUx0c05tdWFHVm1vM2VtZ3BKVGFaSVRH?=
 =?utf-8?B?S1hBZ3FRYW13WWtRK2c3anZLc01KdWRUUlMvWHowa3JENnlTaHVGTG8rK0Vv?=
 =?utf-8?B?K2d5dWRGL2FFdkFudzhHRG94ek5rSWNSVTJKTjRrRmtuaVZxNGF3SnZGOHU1?=
 =?utf-8?B?Wms0V0RTeGVlM28vUys3dkNxbVVVcEVxTmw0KzI3ZXB6VjljTzA0aTM1MENX?=
 =?utf-8?B?RGsrQ2JaMWFJb0RHd0lLMjdKa3BxR2QzSTJFUkkvVllSUUNjK0lKY0Y3bkw1?=
 =?utf-8?B?M2tOQUQ0aXRYZGZTUHVHKzN2SlBJZ3VrckJ3SENxcS9QaysvLzQ2QjZwTDdS?=
 =?utf-8?B?TFFuejExUGxqS1E5ZjBhcko5dUd6OTdYbFdXaUt5VWpPNFpKOGhHaUxpWHov?=
 =?utf-8?B?aWJWei8wUmFQZHdXVzUvUmhlRUZBR3NVSzA3RGpibE5GSVVVUjd4K00wOXhY?=
 =?utf-8?B?czVXM2pRQTdJV2tiMmdkR0I3RUlKQ2k1b0ttSXY5VURCUHB2dW9uaU5iSmRY?=
 =?utf-8?B?Q210N2srL2V2QmNGKzF2dHRBek9NdlFaMU5mNnFYZVpleHRxNWxoWFBXSTVG?=
 =?utf-8?B?REo5bTh5cTRFOCs4ZjQ5eFlTc2pwWjBYdll5SzBRZVpQVGpHNkpDSDcwRXV2?=
 =?utf-8?B?cTlxTlU2ZTYvb3lGTmhzY3Vycm9vL1hKWm1YSmJmUnlwMzFkV3pHVXBGM0FG?=
 =?utf-8?B?eityU2Mzd0dOekduTWtrWkpWd3EweW56ZjVPSUdtUWw0K0dSRlZ5NENDc0VG?=
 =?utf-8?B?MWhkYTNwcEpwRGhYdVdicmlBYjFZTGF1S1FJaVlzcmVFbkh6Tm5NQjJHYUt0?=
 =?utf-8?B?aC80akFvRFd3MWxHR3BXU0lsZlVzOG1jMklvSHUyck9SdTd6cWlEa3VPVGVR?=
 =?utf-8?B?YTM3UHBwa2lCdWVUQjZvZmR6QUx3dlhDR1o3S2dXK256OFFoWUtyUHBmRVBy?=
 =?utf-8?B?bHJCTzZqZGVXKzk1VlBObndZVDJ6VVR6dE8xcDdiVVRtL3hXa0NVTUw2aEJB?=
 =?utf-8?B?dTdkbzN6RTYwU0tIc2JmeUFBMk40Zis1Y0UzOWR4RkZlczIzNnNYRVhCWmo4?=
 =?utf-8?B?ZlNFWERSdUtMUTZNTU51cjdEMWtxL3ZIT29nVG1PMkQwbElTZWRkNGtwZFdO?=
 =?utf-8?B?ZkFYRStJZWxHVWpzVVVaNUR0YVNxMmFKUk9nMlJINldKWHQ1TEdlV0twWUZ2?=
 =?utf-8?B?VXZLcXJRZnpFZ1Q4TGxta0l2MnBNeElnT1hlQTJoeTBtb21tMzkvNC9lVUs2?=
 =?utf-8?B?cFQySjMzbURWVE94blowWlpieUU2YWdaSXE4UEk5RWpueFlKUVlmMHZSUlor?=
 =?utf-8?B?VDlKeExKMjVrN0pZbzdiUkJuZUZHSWxMdVdEOVBSbEtiaVNyRWFnNW5Sb2t4?=
 =?utf-8?B?VWI5WEg1QmhFcXBHK2ZOTUtYY1FqRy8yUGx2VUtHeHp2U3A5TG5MR2ZIZkU1?=
 =?utf-8?B?UXdxaWlrMzlKRGI2eER6a3BUM1JmUnlDU21nWHN2ZjloZ2JyblE3T2x2QitW?=
 =?utf-8?B?QTIrV0R1RDVaVmQ1elJOdUJmSTdkQm1aZzdlcC9nQlZNZGpCSDRDSjlHWjMx?=
 =?utf-8?B?SEF6bS9LM0tIUTBsMTNPVys0ZnJ3WXdvSDVxd0pKWElIdGNKUENSU2s0dGtP?=
 =?utf-8?B?Yy85NXdGSzVjWEtEYitUQUZmWlZIVTgzcDZuQ2VLTzF3NzBOSml1NE1LMnlS?=
 =?utf-8?B?aDZLUFBEV2Z4MkdSQ2o1WWZGUnFsSUlsSU43RzE0TGVXRmU5SHAxM01JTUdL?=
 =?utf-8?B?NUNneTBxWFpHcXpRZFJvK29Wem1uS1cwdGo3RVVjSGx6VXZaQVlHZVA1d0lI?=
 =?utf-8?B?Y245dE9xNGV5cXdFa0E4VWk2UzlxUEJQYkN6bjN5V2NrQTBWdFhFQ0RubGp3?=
 =?utf-8?B?UllTbUFzcWpkMEJ2TjRYcHFtUCtYeEUrdlFBYWV3NVdpZHVneTZkUXZMOGo1?=
 =?utf-8?B?bWRVUUlMdm5ZN2szdGxqUjhONk9tY2taT05tdlJqWm42VjJ0RmlZVFhNNHhz?=
 =?utf-8?B?R2VObmdFOUpadVRZdUJJSkh6Q0p4aVZpMTNRWm5YMUVicUxnaVhIc0h1Mzhs?=
 =?utf-8?B?S3dIWmg2OUYwSjZHMzdGMnJXaFB1SDFiblJRK05CYUlCMHdqWFY4VTY1NEhR?=
 =?utf-8?B?N0JsMmw3K1VFZXpiZ0FhMGN0cTBJdm1IRkVCTTFMbGUwUDMyeWNXTW1EYmxr?=
 =?utf-8?B?N3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: de93dd5a-1fc2-4c55-df53-08dd514dc6d6
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 01:27:44.7898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: elR1jmrete+uS8/o/BUkXDpX8Zn7Gd2AbHzXR/NrLIppanotNi265Z4oLxJ7iD9+VvLwaNPU4gWcoZN5k8Mni1B5YLqctW3yjaiquPbPD84=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6570
X-OriginatorOrg: intel.com

Hi James,

On 2/7/25 10:18 AM, James Morse wrote:
> get_config_index() is used by the architecture specific code to map a
> CLOSID+type pair to an index in the configuration arrays.
> 
> MPAM needs to do this too to preserve the ABI to user-space, there is
> no reason to do it differently.
> 
> Move the helper to a header file.
> 
> Co-developed-by: Dave Martin <Dave.Martin@arm.com>
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Carl Worth <carl@os.amperecomputing.com> # arm64
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> ---
> Changes since v1:
>  * Reindent resctrl_get_config_index() as per coding-style.rst rules.
> ---
>  arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 19 +++----------------
>  include/linux/resctrl.h                   | 15 +++++++++++++++
>  2 files changed, 18 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> index a93b40ea0bad..032a585293af 100644
> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> @@ -287,25 +287,12 @@ static int parse_line(char *line, struct resctrl_schema *s,
>  	return -EINVAL;
>  }
>  
> -static u32 get_config_index(u32 closid, enum resctrl_conf_type type)
> -{
> -	switch (type) {
> -	default:
> -	case CDP_NONE:
> -		return closid;
> -	case CDP_CODE:
> -		return closid * 2 + 1;
> -	case CDP_DATA:
> -		return closid * 2;
> -	}
> -}
> -

...

> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -384,6 +384,21 @@ void resctrl_arch_mon_event_config_write(void *config_info);
>   */
>  void resctrl_arch_mon_event_config_read(void *config_info);
>  
> +/* For use by arch code to remap resctrl's smaller CDP CLOSID range */
> +static inline u32 resctrl_get_config_index(u32 closid,
> +					   enum resctrl_conf_type type)
> +{
> +	switch (type) {
> +	default:
> +	case CDP_NONE:
> +		return closid;
> +	case CDP_CODE:
> +		return closid * 2 + 1;
> +	case CDP_DATA:
> +		return closid * 2;
> +	}
> +}
> +

Could you please add the motivation for the use of an inline function?

Reinette

