Return-Path: <linux-kernel+bounces-219778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36AFA90D7A2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 17:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 287861C22210
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 15:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F6845BFD;
	Tue, 18 Jun 2024 15:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kZPbOTzt"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB2E36AFE
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 15:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718725488; cv=fail; b=hc/8yFif846bGP9iWxukZe2PUFko80oL/yZ570UXpdyFgMRlQD6xA0q4ajgY1/U4jW4kFpsVjRIO0nrNm6j5sekULANg3OQ4L8sGZBaztK7d/h+2BIYjSzSQ08/jUOCmfXgksJ3SPfhLUd9dMgCnSzULrlMGdTS0YdEGx7RbKhA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718725488; c=relaxed/simple;
	bh=K0LLaauTJDCOi4sf6iIyThok3+RgsyJiXy4U6Pjmmig=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FinL4xlFbdWlZXyR4K166zYS5JqS8fLpiNpN7+DzZ6Xdtf6zgxLl+VL9/nvaJJ34R0ihR3eQXFdBbhJtHXTt7soxvctsS0yiV15Pk5iPVe7EN9Moahq6bLo7om2jNiWOLiTMy5/ofw90ayAjj9A6aK+fTXoPP1Jo8kNS2lmGb+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kZPbOTzt; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718725487; x=1750261487;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=K0LLaauTJDCOi4sf6iIyThok3+RgsyJiXy4U6Pjmmig=;
  b=kZPbOTztufcq3536WdhRq+kd+8wJXZyOEh0/M7ylB/X/8ojVx4oeZ3xq
   re+EnzQnrbWlTqmsArNR3LCoI1gWeYJzdtOKDmB+YZJQpLq24ne2ZoWsl
   7n5bU5bjuVAVrTjcCC5bTs67/Armi+8AfiRWzQTt7tfRo6CqNUIQnKr/t
   Cd4h1Zcb1NAXqNsy8OA9p3bg2K4HRp+0WhC2xKqPW0iq+xr+Jy0lQUvxD
   MZA6fudpJ89T0yb4VHLu6GJvq3YLpp+3hTP7aHFrrua+7dyBR4YQI/am6
   gO+sUU2gO8ZsX8CnEu4WXYrzcBBnxWeTlrls3oZo8E+LU0pu34tsA61bE
   g==;
X-CSE-ConnectionGUID: pRdX0+BpS0q+mpKjV8nMxw==
X-CSE-MsgGUID: /b/ak302SjSNEJTKqTeP0g==
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="15746313"
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="15746313"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2024 08:43:58 -0700
X-CSE-ConnectionGUID: mVUK81AaS3a6WTdFG+VnrA==
X-CSE-MsgGUID: dPyJEVcGTo22pan7k8iE1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; 
   d="scan'208";a="42300758"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Jun 2024 08:43:57 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 18 Jun 2024 08:43:56 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 18 Jun 2024 08:43:56 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 18 Jun 2024 08:43:56 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.46) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 18 Jun 2024 08:43:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aOunO1m4muXNBJHNktGC1d3/E7iY8wCR970KuhHEr1Om+YvWz5vYoy0I9HjJI55L2Fk9ghveSq0wR/qbeBhBv5L9LNIVyNZ790iXLc4CgmvAz59DpZ9Dh76vhYGtMrnxrl4+ZUlEVwZPdMSgDw76JV2u2E/zpJqTaaRCcjra6TcCu5UlSqa3AJet4DWgjvXhBBTM94HrdeeWrQyOfctgK5csWcX4+JN5WIkcbqGv+i7xhAmtB26HJ+Y5ryGovqojMWMFV18D3OVCib3q8RelQbNtbk6ZbfPmfmWHpb05QfRwE6kRQ2L83cUrpHLY3+W1kQ1pzTpOeT52R2U243tQEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zoxRJVLQDQ5s1ssP65RSE9QO+uPjQzHyNi+JzkktUdU=;
 b=MmSUldIVgOiUEBM34bta9ggMo9bcNUEjHYi6aR8jShYLx5RXtViT37/YtqR0RGWuH9ZiPLY27fFl9JuUMwMevy+fyrU+UeU0r6rSJmCbO59iIhZZ4yPRtScJHZbTOdohQlkUz7eiXAOmjpe5fDyDA88DRjsZtA28KNSAcQIcUmlUygc5iJbHTeklMpQ3CsLHyadSrc6FzIerEAGl/L1156pOso7wrdeEvrDTfzmz6jYh1EYEsXfonN16M/qsEaeumckRtaM6r1h/Zsv3poO21ADZ87FHNPz4SdST5uB8ipOpA816wWxP66/yH4fygQknY62QWDDFmwOgLU39+MNgEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH0PR11MB5094.namprd11.prod.outlook.com (2603:10b6:510:3f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Tue, 18 Jun
 2024 15:43:54 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 15:43:54 +0000
Message-ID: <d476585b-3cfb-494d-b25c-4aeb6244e21d@intel.com>
Date: Tue, 18 Jun 2024 08:43:51 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/resctrl: Don't try to free nonexistent RMIDs
To: Dave Martin <Dave.Martin@arm.com>
CC: <x86@kernel.org>, <linux-kernel@vger.kernel.org>, James Morse
	<james.morse@arm.com>, Fenghua Yu <fenghua.yu@intel.com>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, H Peter Anvin <hpa@zytor.com>, Babu Moger
	<Babu.Moger@amd.com>, <shameerali.kolothum.thodi@huawei.com>, "D Scott
 Phillips OS" <scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>, "Shaopeng Tan
 (Fujitsu)" <tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie
 Iles <quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>, Peter Newman
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>
References: <20240614160843.11006-1-Dave.Martin@arm.com>
 <1e3bba2e-5cf6-4a77-b92d-5c7ab1661d17@intel.com>
 <ZnAkOhFWzDqhlSyt@e133380.arm.com>
 <a37917d2-8ad9-4192-a3f8-9789193d53d6@intel.com>
 <ZnFTnzm/jctgN2wf@e133344.arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <ZnFTnzm/jctgN2wf@e133344.arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR06CA0003.namprd06.prod.outlook.com
 (2603:10b6:303:2a::8) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH0PR11MB5094:EE_
X-MS-Office365-Filtering-Correlation-Id: ef4575dc-b0a7-423e-d187-08dc8fad755a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|7416011|376011|1800799021|366013;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bHl0Rml3UUZuUWlKWThKVGRFbDRVdHFudklEVTJXdnpoVXcyU0tXUmtrMjli?=
 =?utf-8?B?bUdyNG01aEV6dHNDM1JQSW9pVFZHcWtSRzMvUFVlT2RQZ0Vmdjg1c2c2QllF?=
 =?utf-8?B?UlF4MlJGdVhKOE1XL0R3RFFmVTgzSTF5QUJaS05mS2VsaVdSUk9lNmRSZHVy?=
 =?utf-8?B?MnlpVHBuaThvZlZ1SEE3YzNJUFNpbjdLOWdoUWN5SzhVRGlDSEJ2WHZJekN2?=
 =?utf-8?B?WlRoYVJnWllKV2tYQ1Q2R3JiUFhOTFBTMTFnaktPZ3J5Q1hINVk3OVY2Q0E2?=
 =?utf-8?B?TWliMkhaNXJ0anR2c2hNbjYzamhhZ05idU1jRVJKNG1jZk82Q0t1aFFNVDB3?=
 =?utf-8?B?bDZUVGcxckRkTi9JT0hUZEtBakhHUjRqWWNHQ04vVklUZ3hVSmNOa3oySHRX?=
 =?utf-8?B?LzNDL0RoVHlwM2dXQmtaMXpCd1U1UVBPcWpwNjgreWlPVnplME9NNHRqRXli?=
 =?utf-8?B?SHNTM2drV1lJRWZaVGdQMnhFTlRydXBMdGhrR25QNXJIZU56WkZWSVNPamV3?=
 =?utf-8?B?RU9Ta0p5TmVSRldWcWFNdHdiWTdGS2pYVTlwbklGUlhiQm1rcUladC9pWVRi?=
 =?utf-8?B?ZE1nOGpJNXBGMmdJRW5iM2ZySkk3TWF5Y083K1VmeVFiUUxYMERFVXZlWC9G?=
 =?utf-8?B?VW14YVg2b2s0VnByMW9mTXYwQkhKRnJ3WW5xOXF2cjlmdVJTaHduN1hZSzRr?=
 =?utf-8?B?VnBqVzVXZmNGRnFyaENUN3FQNzBLU2p3MHN6RjBmNFVoaWVkTGRrMEhjRjB4?=
 =?utf-8?B?YTBISWJOZE1lSlkvQUUrdU5sTXh6cHdWZHZ2UzFKNFI1bzFnVEVBODFqT1V6?=
 =?utf-8?B?VVN0Q3E4bmpPYzduVlM3bVZEQnF5RFpReTY3WGNXVHoyZ24xM3pFTXZ2Qmlr?=
 =?utf-8?B?RU1aV2w5L1VudXkwSDdkdWlCRUtKUm5WMysxNVFTWDAvVEJsaVZyT0UxNnI0?=
 =?utf-8?B?bERGRDVkR0JJbW9ZTTE2ekpBVVgwYkFaU2U4L0ZvQi91TkJldHpnc0pSUmxJ?=
 =?utf-8?B?bGRFNTFUK010Z1l0L2cyVmUxUUVaNGRhaG9hMWltVTN1N0h2RkhIOTR1a1du?=
 =?utf-8?B?WFFYRXlWRVgzWTVDSC84Q09WNkFOdXhRVzJYMXFldWMwVGFYbi9XdzRLZnh4?=
 =?utf-8?B?MisyMU1mOGhlbkw3aXhvdy8xa3lQUlBidTcxVHcza2EvSi8zTTNXN2sxUGQ5?=
 =?utf-8?B?bktPZFRFYjVSVG8vR1hqODVNQTl6WGcveEozNitLYjlrYnN3dGxuUG5kZWpq?=
 =?utf-8?B?VGNQT01jSExHU05adVhyS0kvTkZjcFZXbjArR2x1QWp2dE03ZU1ibjM4Q3Er?=
 =?utf-8?B?TVVEV2Rxb09ReTVsazdEVCtuM3RZbGVBMTdNTmxPbVA5UFpaODlVanBOc01k?=
 =?utf-8?B?WEdCdElFVHRIYnhKNWozZGY2SUlWKzEvZHpMV2x3aGRQUDZRVkQ3bWtCM2dz?=
 =?utf-8?B?N3dSMiszUUFBSS9OSlN3cUJLOVpEWnV1N1llQTNzL1dLZFJaaVBEemtucFpD?=
 =?utf-8?B?YVljb1NQdklLMWpyMHdTeEZ6Q2hQdTVvbUlCaUVoVkVkdHZFb1BIaHM0aGFl?=
 =?utf-8?B?Z3NVZjZxc2NUSnFpUlJLVzlkL2NydFhwUlpab1NqNHlsNWJKbDVEK0hpR0Vj?=
 =?utf-8?B?a2lTQWNNUTdZSnA2S1ZKMVV1bDV0dTZKZkMycmhtNHVRVFFUTnJLQytzT3Rr?=
 =?utf-8?Q?Bswj6/9UrxlI8xtuEuA0?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(7416011)(376011)(1800799021)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnhEdVVOSElWcWpHa2pNcmkzNDUrald5aWlCb0pIVzJ2MEVBS0dMVnZmYVBv?=
 =?utf-8?B?T1NlZ1JzWVUrNmdwbTJXMlRhdy83WTFXT2ZGVittemdVdksyeERQNFhlK2lp?=
 =?utf-8?B?ZE1TK1RSZWt4L1F5ZTZLZDRuMlJuRFRBeW90M3ozTFVReEl3TkNKSXRTclo4?=
 =?utf-8?B?VXBLYjZRcGYzRFBGYk0yOTNQSEFVY0xOWnBkd21STTJMa0pGc0lJbTJwc3Rh?=
 =?utf-8?B?c0lrT1BsampnTnYyeS91OU91OHFobVA3TE51eHN2YXprd3paMkVRNzhOZHlj?=
 =?utf-8?B?amZ4Y2xvNnNWblNVWWFLRVB2Wk9IWkhNVXljRzAzdWlvdFRVaGJlSzdTSmtR?=
 =?utf-8?B?WjlBZVd0K2EwN0lYdTlUcExBdWpaWGt5WU1DclFIUkxlZkZsSFVOZVhRQ1hU?=
 =?utf-8?B?UzVONDY5YU9CWEhuSUM5dWYwTXZuOElPaXhhWkg4NW5OK0RzQWFxUzRJTFVS?=
 =?utf-8?B?K1E1NXRIQ3AwcGF0dXRaaDdiRnpRMkNXbUlxcUU3ZGJSZWNSanFjS3VZZGFp?=
 =?utf-8?B?dnpXSjF6Y01tM3VRTkUxS1dpR3dRNGc0YXk4LzFCVXZGdHg1a0Z3cnRjZjRT?=
 =?utf-8?B?Ym9sZmxTR0ZabEl5b0t4bk9SRGlsaFg2ZkVzQk80S0VHYmU1RndhS1lvVmNT?=
 =?utf-8?B?bi9LcC9ENFZVZCtWQmZXWnNjYXVZamtud1NWa2k0RGtlTzFxUXRtdnlEWVhQ?=
 =?utf-8?B?V21VcHlSMVJpa3dMT0pLM3VQL1RDdUhTTUx5S29jdGIzTUxpVWdXNFlya0NY?=
 =?utf-8?B?dXhTeEdXenZueE1QVkpLaWwyUWFHZzNzeEpPQ1NQZ2F3dHBwTy9QNzhSWmhz?=
 =?utf-8?B?MnFXRVZBMFd3bERCY3R0UmZoNThFRzErUDlHZmo4b3NLTUFScURBN2hPaHhr?=
 =?utf-8?B?eGUrVnNqSkFlV2VnYmEvaFBPdGc0dmRzWGwyc2w5ekRGeUZkT0hHcGsvNDl2?=
 =?utf-8?B?WnRxWVJoQ2hla1RyS2V1anhSRVFQWURhWGZJazFhS0FkNHJRMkdRcUhIdGdO?=
 =?utf-8?B?OWNsQUd0YUUxRWp1OTg5djdhWHg3c0Y3TkE3em91NVR3WUNEc1FFbHZvVUdz?=
 =?utf-8?B?bWtyRHBVMHlOU2M4aGxIQnl1YUsvSlVWUGo3Zi9LTHkzTG15U1RJREpxdTRw?=
 =?utf-8?B?N2pjZlcvaXdBbnVFNEg1bUdVeVBlZFJUb1p0TGNuWTkrNGdYaUwrMXd4bUNT?=
 =?utf-8?B?Mko1VWY3SXd5M3NKME9VU0wrNThKeTRQZzZBZ1QxaXc3YWd1T2p3V25hZGRZ?=
 =?utf-8?B?dHZQUzlrb1pJZUZzRWxuWXhMZkVtdFNUMUhlMDBhcFVRSWhyclN6SjI0VnRi?=
 =?utf-8?B?R2xxdU1DOXFEWUpiRlgyR1Zqd04vTHRNM2VGRE1ZcUlCb0FwdGMwRkpGYU5r?=
 =?utf-8?B?Rk0rbk9FY3RIcHIxbVhSMnNpY01pcUJQTDdmNTMycHdVeUFiSGJNS2UvRWRQ?=
 =?utf-8?B?RzUvN1ZqbUphbXpmZzhaT0dlblhPSWFIZlVLUG9jUTNjd1FlWW0vRmlwVmc0?=
 =?utf-8?B?TTVLQUkrdEtkZW9CV1ZjQXBMVFNGa2VsaXd2SHB4UktKVnVLYWpwVEhHY0s1?=
 =?utf-8?B?Qjl1UnQvM0dFTGlqV1ZUZ1BQVC9XMDlYUjBnVGJuUllFNnIzTkJBZmdDVEJL?=
 =?utf-8?B?Zkg4VWRIcXJQZTN3S2dmV1JLbWVoYzFHRFNNQm5CRDVvM2x4b0NwU01tTTVX?=
 =?utf-8?B?Y0FvejM1SVJLK1pkZW45WTEwM0xmc3crM3pQdFhrb1JmTzVTVUxnUGg4Nnk0?=
 =?utf-8?B?ejFJY2FLRGE1cGYzTDM4UEhzTGJrWGRrekJmcjZaQ2tzdmhhcS9HbjNqc2NO?=
 =?utf-8?B?SFlCSjBOVCt1UDNmbmowc0ZZMEFqWkovSzYvTXJaTEpUMHhWVVpoTFRSTk9L?=
 =?utf-8?B?VERESXcwSGxvd0o5bnU3VlJzUXNqTG9xa1B4QUJ4WlM4dWdRRGYvSXZtWGJJ?=
 =?utf-8?B?dmFsSSs3bFNBT1ZVek5YTlB1YlVONm1aZXE3Zkpacnh1VUE2U1JmME82WkMr?=
 =?utf-8?B?czZEOEg1cm5JTHhMNGF2Q3RZcm4rVW1SVFgxVGZhbDhtSzFpUHpBeVhTeEFy?=
 =?utf-8?B?NVFxaVF4UlFJKzlyL0lvdnR4bG9mNzRNSFNuSHNoSmhSWG1uWnc2YWZwN0V3?=
 =?utf-8?B?cDF1OUh3akFHZjU5QUVyTU54OWtXbDJ3V0ZlcjF2WlB0cU90VEVNZ2tQMURx?=
 =?utf-8?B?UFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ef4575dc-b0a7-423e-d187-08dc8fad755a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 15:43:54.1690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dYv1FQXtdnHmdU/+TmTJIxyHewyAfZmvVmoJSe8UN3HLc2jXR9cbxFCVjWoH6g5tK6wrn/s8kXDWgHfYZozcag573RdDuUEz7EBM/Em1+us=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5094
X-OriginatorOrg: intel.com

Hi Dave,

On 6/18/24 2:30 AM, Dave Martin wrote:
> On Mon, Jun 17, 2024 at 08:53:38AM -0700, Reinette Chatre wrote:
>> On 6/17/24 4:55 AM, Dave Martin wrote:

>>> As it happens I tested with rdt=cmt,mbmtotal,mbmlocal,l3cat,l3cdp
>>> (though I made no effort to exercise these features other than running
>>> the selftests).  I can note this in the commit if you prefer.
>>
>> hmmm ... those parameters should not be necessary unless the system
>> has those features forced off by default because of errata. Doing
>> functional testing on these systems via such enabling is fine
>> though.
>>
>> Reinette
> 
> I got these kernel args from James.  Apparently some of these features
> are defaulted to off by the firmware on the box I'm using, but we're not
> sure why.  I haven't dug into it.

resctrl does not provide capability to override features that the hardware
does not advertise as supporting. resctrl does sometimes force hardware
advertised features off because of errata (for example, see [1]) and the
kernel "rdt=" parameter can be used to override that. This same option also
enables administrators to ignore some features on their platforms.

Reinette

[1] https://lore.kernel.org/all/3aea0a3bae219062c812668bd9b7b8f1a25003ba.1503512900.git.tony.luck@intel.com/

