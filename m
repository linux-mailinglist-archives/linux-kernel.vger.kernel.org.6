Return-Path: <linux-kernel+bounces-431658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6CBF9E4008
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 17:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 679AA28363D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 16:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD01820C474;
	Wed,  4 Dec 2024 16:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kbjPdnce"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097E420C473
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 16:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733330902; cv=fail; b=a0zOpHcktS8YOBsGI4A3Wyl8/jT1lCBMNu9xspSApbM1BQbVcO/tzvN+/Xsd551s1nVbcy0UW5WCPdwLijg9JW8vYWiMmJg1lrTJ6xLPhAa1R1QrePxVJhGzomIpBGSDN74c4vxn2Ftyg01jaRx5ih4bZqrFyTNi1lV88WpEQ4M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733330902; c=relaxed/simple;
	bh=sSoo8Y8OQBtv+YAnJNV2/e6bo4PbQUJQ6ghekoYLjQA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OKVz7G3C2zA5p8bbG9C0tuIsXrhNNuY8UQjHH8GY+Iuxqt3jExktTiOFV64CyqYp+PtIW+M0k16LdkcsJmOiSGdGEOLvadfSVXjp+AiknI2otkuVzlUIEnVk56kSlaX+86Aw6yt+Tz3VECkqrrzl8OqsQr/BN+kAnA0AsU1N6Wk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kbjPdnce; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733330902; x=1764866902;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sSoo8Y8OQBtv+YAnJNV2/e6bo4PbQUJQ6ghekoYLjQA=;
  b=kbjPdnce6XOoabX54Z4STvbKkX1DP2lrHk/3quK1n/5hY1izJqqYnqme
   qlNbTrpI+T7ioHjU1xswFL5aHBTM7or1vCUzDJo8f24GkLWv8+qfEbrQJ
   1b+8R6dRmjVfkZ0AUzyeEUPHoJKTKuEMM2E7MB44LrlPA5Fb7sVVsjgmi
   csBDzHyeX5sf420vczHC2VQQHYDYxbd0EO91EQRUxW4TqYtEs1jiMZv5i
   bYLaYkR4E7FPUfuLDf3xftWChS9PQfnZI32qkD9Wu91fqvKAZl59oPjOM
   087mYQsxbmVTAhDTLJUAX/V4+c2fI01heVYwnXZFAPz/2RPBL78fUm/hG
   w==;
X-CSE-ConnectionGUID: XRFM6C9kRPyI22+BidQXzw==
X-CSE-MsgGUID: ivYN8WR3Sp+7z6/xq8cLsA==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="44638425"
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="44638425"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 08:48:21 -0800
X-CSE-ConnectionGUID: 1odrVu9BSvGuvxB7y1+Bng==
X-CSE-MsgGUID: y4/axTmJRAmV8pS6NWZHCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="97880353"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Dec 2024 08:48:19 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 4 Dec 2024 08:48:19 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 4 Dec 2024 08:48:19 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 4 Dec 2024 08:48:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kJG/xATuhl4Rm6Q0shDFZfDubhZqnTp0g1uXh+AFHwV7GwP8QlNiXumuWZHex7N/amWhOcu2/d/pF/UWWAsV+8eeK9oUlLrMAF9ixuuXbxS0xL7yIiVHahLjrvA1+9OF4gPr0Dr5WuxhlKHv6k5wuloxmN7Bne6cf6xblLIJCYVHn5G8WLJmJIzBzXxk8rpyq/02AehX/9faY+D8B096Y08URC/eXgzFTjkhf5rOAWuL0p36sTZBXkdsZlau4ZAYS0k1oWbBMAm6tQXuYHcWFVPnO0IPPyyLjMXVXN+g/A3hcrnqCR9IBkdYWUObAIozWMrv3FyoWp65OnGPvaq+OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+VCCfCmsspoAIvhqtaR1VlUKcnjAyj7kUARo/VuoL6s=;
 b=IOiDkrZVFmb0TImGUD04efs9HKyOvGz1uqEC3AF9gVewi8qD5Kqsh4puIJa23SVzKvJs2MVDbm69ibrbxCDiEDxlwJrlyxlIezWvgE76fx+6EoZW2w7y9gacpO0P5cYTISkayjIXz30tGwf/6oGy4CoXcSAsDegLDRJ1WaaW3JPEJJOp6AdPRQu8NC41wzF73Fi/qsjMYVfhGfL+jURwfZ1JgZ05bPjDWVM+9sNRNao2A3RHjTPxlb32dhLUNWWaZLvEcDyJQz8xn1FmdSSaawlaIJbjgq5UsI6LU8LELegZ8au7VtCnS0hVpOvt0qUqDRqz/jz8HqsVlJ+GlfIpVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CY8PR11MB7828.namprd11.prod.outlook.com (2603:10b6:930:78::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Wed, 4 Dec
 2024 16:48:16 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8207.017; Wed, 4 Dec 2024
 16:48:16 +0000
Message-ID: <95e33677-66e7-458d-937d-e1b5842666d3@intel.com>
Date: Wed, 4 Dec 2024 08:48:14 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: resctrl mount fail on v6.13-rc1
To: Ming Lei <ming.lei@redhat.com>
CC: "Luck, Tony" <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
	Peter Newman <peternewman@google.com>, Babu Moger <babu.moger@amd.com>,
	<linux-kernel@vger.kernel.org>, Borislav Petkov <bp@alien8.de>,
	"x86@kernel.org" <x86@kernel.org>
References: <Z04pz3AlvI4o0Mr8@agluck-desk3>
 <868b451a-fdba-4b45-bff1-9ac1023080c8@intel.com>
 <Z05xSqIeNeHh19MZ@agluck-desk3>
 <e1dc44c7-94e4-4055-84d3-8fdd5c22d161@intel.com>
 <542a0c87-935a-4b39-8210-22a7d46de6e5@intel.com> <Z0_MHEoSNdiQvXNK@fedora>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <Z0_MHEoSNdiQvXNK@fedora>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P221CA0025.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::30) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CY8PR11MB7828:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dbc8a0a-707a-4332-b70f-08dd14837342
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WE5kVGJMMTgvTk8yU3plQ3RqK1laRHVINkVGS3YxQ0lBMUhCdW4rSERsRWpM?=
 =?utf-8?B?OVlsTTh1WXpiK3FrWHNWbTlTcVk0WGZVM1RxNTFkUTZyNFBuS1FVZ3pva0d2?=
 =?utf-8?B?eUxjNUVoM2x1R0hxSHNjc0pPcG5QL1FPSEU3K3JNTnlGTnZEL0tjQ0owY1pj?=
 =?utf-8?B?MU9uN2E5WWxZbnBXTlZGaTQwSHZsNDM4eUFRMFg4ZGd1M0tyZGRtTktCUzJs?=
 =?utf-8?B?dHhkNHczaE9Oa0J2SFNRNHB3QmFmUm5EemhGMHhoNTEzQ2ttQllJVE1VZU1Y?=
 =?utf-8?B?Ry9NbjAwUnFVYU1VWVJDVkhFdWpMcHlBRUc2MlBRMmVzOE9DMGVsNHdYR1RU?=
 =?utf-8?B?eEdPeHovMGw0RUwrZmpEN0NqWVZBNUpmVFl4QUhtVmlkTzY5TXdkSjNNWkdH?=
 =?utf-8?B?akNTcmJhWEJaUlNWV1A3eUJ2WEVMZTNqcWsvSmQrOWZGaVpjQXZLeDh4RWI3?=
 =?utf-8?B?bGJLM2FhQm5abThEQW4wZ0ZOUityYWd0MDZ5QjlwalZ3SjhxcDIxYzM2aG1h?=
 =?utf-8?B?aEo2WnBFbFQxZ29vb0xBN3BrTHc5bDBJYW12Y1AvUVNZdVRoeXhyYkgzMmtE?=
 =?utf-8?B?WmdLVVlPbVVOOW9XOGFHeUFzbDBZeGZZYmx2N05iQlVSc1FwWkFaVFA2L2tQ?=
 =?utf-8?B?NTRFOGU5NTRwOU1GYitvVjVJbzVjckZGM0FMdkdwR214WStCSkJsR1doRTVX?=
 =?utf-8?B?QWNUeUdNTy9zRVdrMGl6aHRJVysvU0FyOWxQSG9lL2l1THMzUFhrYkovS0lJ?=
 =?utf-8?B?NS9qOEFpLzBnbm05dlY1cURoVnNnNXZvMDc5c2FKNUZRS2ZxU1c5d2NjKzc4?=
 =?utf-8?B?blFIVEpaQUo3RFJTL001N2htLy9nUTljdExFaGxTdDhyUWdaWVdKcTcxMEtB?=
 =?utf-8?B?ay9uWkowMElnZDhXZitQUWZuTkhibWYrbGtTSnh3TEJUNnhxejBrVytRbmc3?=
 =?utf-8?B?NDJDRVd6UTFhekk4M2tOR2tBQXp1TnQ0MFdoQitHVUZnV1l2Z0l1K0gvY2hQ?=
 =?utf-8?B?MU1DK3hFVHBxcGsySGhvMHRWZDh4OHlTMmxwZW9rNW1zVTltOXZaSk95cFd4?=
 =?utf-8?B?SjVZMWtJQkhHQ043ZlVHWENZNzd0a1ZBZzVPSEd4azdYMU0zaDFKWkk2M0tK?=
 =?utf-8?B?MEtnd1ZGK2NWSjVRZE93akthc2d3ckhKSzVHSjU2RmtyTUlWY1pKaU5mUkhJ?=
 =?utf-8?B?K1YxWUNXTEZtTkJ0M2wxNkdUMWRpdit3RHNCOC9XUlBzUHBwWmJTRnVYYnVF?=
 =?utf-8?B?dWxvdjI5Z3IzUG1vVHRqbnpRWmthRGVxR1dVRURJeTI4TW54TG00bjlET3VI?=
 =?utf-8?B?SHUzZnY4blRNSlQ4aTFxSzZjeVF4RlRCWkVKdHFOV0xvb2t1ZlR5aFlaZjZV?=
 =?utf-8?B?bjhSSWk3cWY2UDFlb0hQM3k2WlF3K2JSdjVqVDd6M01rVHhFcjNtT05DYUVt?=
 =?utf-8?B?ak9SWi84OW9LbzZvbHBOWlpYKzBzaWx3b2w2OUNpQ05oZUt0Tm94ajZwaUhY?=
 =?utf-8?B?RVNROE5wc0J1K1pvNllpSW9KZEVUZWFwb09FTFZGNlBtWSt3RTN0dWRydGJy?=
 =?utf-8?B?WUJJNWNuZlRVMzBpeU9QKzJJUVBmOEdHQzJjMVNiS3dUWFQxRG1lRFRyajNV?=
 =?utf-8?B?Z2VPRTdzanBPZ2E4bms4djNXVDBldFV6RThKd0pEckhvOEFUVmtGbjVTOXhy?=
 =?utf-8?B?eFRJczlWL25mQmNab2RmWFVvZUF0eGZGTnZpeUpEdTNDZXBJTnJ0OVR1LzNk?=
 =?utf-8?B?ZnhTT2RnakozQk5uSEpCNVNjbGI4WEZOUmt3VzQ4eGc1R3FVVHNvR3pjZW1P?=
 =?utf-8?B?Y3V0QnBmdlMzYmFGVHJndz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDZjQkdXMFgvdENLZGdNS2FPYWk5L3h4NjNPU3piYU5xTHB0d3E3Z21tZkVk?=
 =?utf-8?B?VmE4bTA1UzBMRXNGWUVSTU5wYmVzbzJyMm5GYWUrRTlHaHVubEhFdU1XSlZD?=
 =?utf-8?B?Z2RzSmp6ai9ZeVhKUDFrd3RsNjJicC9ieFYzbGZTNjlGTzJsRUJ5Rkw1Tzk2?=
 =?utf-8?B?bGNWOXBOTTRWdTV5Q3ArQ00ydWZzSEgrLytlR3hWTy9mbDRhK1JPQkJWa3NC?=
 =?utf-8?B?NFgwTjJoWFgzTW1GN3krNDF3SEpHSHhvSEhQbU5peVh0WDloYUxjSkFGTDY1?=
 =?utf-8?B?c2U4UDVIQnlLS3hnL0pxU1JKdlVTYnkvQ28rUXR0emYrLzVHcTUyUldlL2Rj?=
 =?utf-8?B?Rk9xK2JEbmZKbUFYbXp2aDlsa01wY3JkRFVFSjRPdGZiWWc1dGpWSmNFbU5n?=
 =?utf-8?B?aHR1N0pidE9nWCtxQk5yUXpzOUFrSC9Iem0vL1JQT3Q4Rm1YOTVqWVNoOTA5?=
 =?utf-8?B?b01LYXlsSGNvaU9xRHdtUjRMOEd4YW1CUjJhUHNoQlhMU2FybFhPckNRR21h?=
 =?utf-8?B?YUFSRlhGd2JjWDAvWmwyWVJibW5jVDdjcWpLZytQM3loYzhwL3JQWldJUXMw?=
 =?utf-8?B?OFNTK2xYYmpvUjFyOFJ0QzlYOEM3bGkxMXp0dGl6czFCZDY2Y0QxZ0dEaFV2?=
 =?utf-8?B?bWIrWjVibHBVL0E5ZUtSOUxGQ3pGTk4zblg2V3doTkV0bjYyTlhOd2xyYUNN?=
 =?utf-8?B?MU5PODR4K05VR2hMU29JRmNXdW9qMVUremVheithVU5XdjVxZ28zam5Rb3ZH?=
 =?utf-8?B?YzdsSVZJODEydENQYmh1U2xBeHhMWi90VER3OVhURThzZzNnb05ESXo0b0hS?=
 =?utf-8?B?eDlJcGUwL0E2Rk5sNnBLcDhhTHpGZ2FpWHVHUGNtTjAvWXUrM0Q5a0c5ZEFI?=
 =?utf-8?B?SHdxVHZERHgyNkRSZlR4OWJ5Qng1RkNYelZUU2FyZzZCOGFpWnFrYmpFS3NB?=
 =?utf-8?B?U1dPdEE5dDFsY2Y3bU43NkVoZU9BbTB1Umh1MHlhK2JnZ0hoZHRTOFFLUmQ4?=
 =?utf-8?B?SGdWVDMxY01yVGg0M3lSNU13Y09TN3RmNGFLblBRWEFTV3NkTTEwTXdTL2FJ?=
 =?utf-8?B?eEllaVpmV3p5ZnpuTXdVTW1aeElkaXZaVEJaY2ptdS8yK1Btc0xJNngwMC9s?=
 =?utf-8?B?VFVXZnFRMGszSmM4c3d4ZU5mdHJtWW9ZWmVDRy82UndlaVNZbGdNQUNIcjk5?=
 =?utf-8?B?blB1ZWNlaVF6VFovOW1aSHYxZ1d2TW5tVkdwdlBtTFJEWms4cklYTWlBdTI1?=
 =?utf-8?B?OHh0c05CdEdkWGFWa1dJc3lQNWZhb3B2b0x5WDJRcjRTeFplZkd2TllqMlVB?=
 =?utf-8?B?MEhnSG5vOEd5Qmo0cnhneTBNdjhnRitON1QwZjZldnNCWU1mZDZON3ZUeUZT?=
 =?utf-8?B?UEt2eXdVc2xacVlZb04wLzllYXZ0b0FCUGkxdjJEaFZMb3JmWDFGaGQrcmd3?=
 =?utf-8?B?T2tFWXhGQUlkQzU2Vzd6M2pwNnRTdEYwYnRhK3luNkNYWmJkcHc3UmxSVDBn?=
 =?utf-8?B?cFJ2RVpoK3lCSTZJRkRtLy93V0lVRVhjYlpTalp5c204aWpnVEU2eHRLVkRX?=
 =?utf-8?B?cUxWamFUZjVwWWJqRzZDdHZxNlVtRFdvSG1uY2lYZ1hiaTdYdWhyWTJRSEZG?=
 =?utf-8?B?eVVkT2toSDk0dnZKWGwyZzdOUFRrODlGdFh0WUY5REdFQTRPQ0JPOGNDT2xr?=
 =?utf-8?B?YU9iM0p0Z1VCbkxTN2x6YXYzVmdHM01kYU1kM1h6TC9xa2JzOGdZSmYvQVA5?=
 =?utf-8?B?anh5VSt2amx2Z2dmYi8vMHBTQWk5Z1RBSmVjc2I0NnBOakZ3Z2hnWER4MEZG?=
 =?utf-8?B?cTlQRXJUY1JiR1o5bmVCelROcW1HSEszZWF5NUE4dElpMnBSak85Y0xHUDU1?=
 =?utf-8?B?YnpmeW5WTlp0aDBkeGhuK21hMFpwZXBmVmQrQ2xvVTRJSjdEVFNrNGsxVlM5?=
 =?utf-8?B?YUhpNng4eWF3eVpDWDdkNUdBeldJMkF4aUF5WGgzNzMvZWRnK3M5QzYvNVlm?=
 =?utf-8?B?VFFmR00rSEtTUzczeERZcllOODROWjNpazk1a1EweUc2SzZNZnlGVSttSGhl?=
 =?utf-8?B?Wm1OUEYzRDJFQnQxaXYyK1pXeFFoK1VBakMzUDNLQk0rMlFPMTE4aWF5UlFP?=
 =?utf-8?B?U29Sb2NiKzBtWVdwUExFNnNGQ0VzNEFCTlZ2bzFtVWMwWmgxOTNrMjBUbjZ6?=
 =?utf-8?B?ekE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dbc8a0a-707a-4332-b70f-08dd14837342
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 16:48:16.4832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h56oRF7Ws3Q6aI1whfIqPsCyCLqx5OnAORPGkFt9bErC7oN5tZvfbPffZBn13ru6DF0lHk/93uahiuO5KhZIWgpbDMcwTX37WGgXBio6Aos=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7828
X-OriginatorOrg: intel.com

Hi Ming,

On 12/3/24 7:27 PM, Ming Lei wrote:
> On Mon, Dec 02, 2024 at 09:02:45PM -0800, Reinette Chatre wrote:
>>
>>
>> On 12/2/24 8:54 PM, Reinette Chatre wrote:
>>>
>>>
>>> On 12/2/24 6:47 PM, Luck, Tony wrote:
>>>> On Mon, Dec 02, 2024 at 02:26:48PM -0800, Reinette Chatre wrote:
>>>>> Hi Tony,
>>>>>
>>>>> On 12/2/24 1:42 PM, Luck, Tony wrote:
>>>>>> Anyone better a decoding lockdep dumps then me make sense of this?
>>>>>>
>>>>>> All I did was build v6.13-rc1 with (among others)
>>>>>>
>>>>>> CONFIG_PROVE_LOCKING=y
>>>>>> CONFIG_PROVE_RAW_LOCK_NESTING=y
>>>>>> CONFIG_PROVE_RCU=y
>>>>>>
>>>>>> and then mount the resctrl filesystem:
>>>>>>
>>>>>> $ sudo mount -t resctrl resctrl /sys/fs/resctrl
>>>>>>
>>>>>> There are only trivial changes to the resctrl code between
>>>>>> v6.12 (which works) and v6.13-rc1:
>>>>>>
>>>>>> $ git log --oneline v6.13-rc1 ^v6.12 -- arch/x86/kernel/cpu/resctrl
>>>>>> 5a4b3fbb4849 Merge tag 'x86_cache_for_v6.13' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
>>>>>> 9bce6e94c4b3 x86/resctrl: Support Sub-NUMA cluster mode SNC6
>>>>>> 29eaa7958367 x86/resctrl: Slightly clean-up mbm_config_show()
>>>>>>
>>>>>> So something in kernfs? Or the way resctrl uses kernfs?
>>>>>
>>>>> I am not seeing this but that may be because I am not testing with
>>>>> selinux enabled. My test kernel has:
>>>>> # CONFIG_SECURITY_SELINUX is not set
>>>>>
>>>>> I am also not running with any btrfs filesystems. 
>>>>>
>>>>> Is this your usual setup in which you are seeing this the first time? Is it
>>>>> perhaps possible for you to bisect?
>>>>
>>>> Bisection says:
>>>>
>>>> $ git bisect bad
>>>> f1be1788a32e8fa63416ad4518bbd1a85a825c9d is the first bad commit
>>>> commit f1be1788a32e8fa63416ad4518bbd1a85a825c9d
>>>> Author: Ming Lei <ming.lei@redhat.com>
>>>> Date:   Fri Oct 25 08:37:20 2024 +0800
>>>>
>>>>     block: model freeze & enter queue as lock for supporting lockdep
>>>>
>>>
>>> Thank you very much Tony. Since you did not respond to the question about
>>> bisect I assumed that you would not do it. I ended up duplicating the bisect
>>> effort after getting an environment in which I can reproduce the issue. Doing so
>>> I am able to confirm the commit pointed to by bisect. 
>>> The commit cannot be reverted cleanly so I could not test v6.13-rc1 with it
>>> reverted.
>>>
> Gi> > Ming Lei: I'd be happy to help with testing if you do not have hardware with
>>> which you can reproduce the issue.
>>
>> One datapoint that I neglected to mention: btrfs does not seem to be required. The system
>> I tested on used ext4 filesystem resulting in trace below:
> 
> Hi Reinette and Tony,
> 
> The warning is triggered because the two subsystems are connected with
> &cpu_hotplug_lock.
> 
> rdt_get_tree():
> 	cpus_read_lock();
>     mutex_lock(&rdtgroup_mutex);
> 	...
> 
> blk_mq_realloc_hw_ctxs()
> 	mutex_lock(&q->sysfs_lock);
> 	...
> 	blk_mq_alloc_and_init_hctx()
> 		blk_mq_init_hctx
> 			cpuhp_state_add_instance_nocalls
> 				__cpuhp_state_add_instance
> 					cpus_read_lock();
> 
> Given cpus_read_lock() is often implied in cpuhp APIs, I feel rdt_get_tree()
> may re-order the two locks for avoiding the dependency.

This is not possible for exactly the reason you provide ("cpus_read_lock() is
often implied in cpuhp APIs").

resctrl relies on hotplug state callbacks for its initialization. You can find
the callback setup in:

arch/x86/kernel/cpu/resctrl/core.c:

static int __init resctrl_late_init(void)
{

	...
	state = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
				  "x86/resctrl/cat:online:",
				  resctrl_arch_online_cpu,
				  resctrl_arch_offline_cpu);
	...
}

Since resctrl code is called by the CPU hotplug subsystem with cpu_hotplug_lock
already held it is not possible for resctrl to change the lock ordering.

Reinette





