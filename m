Return-Path: <linux-kernel+bounces-293010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6809577F5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 00:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 418C5B24F4F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 22:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E7A1DF691;
	Mon, 19 Aug 2024 22:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WzSHcJOF"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45AB41DC49B
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 22:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724107483; cv=fail; b=Ys2M8nw8CTdtrydWtv5Zzv0DObVoD8VUY1SRCNkg610IA669mk0AxiMwLndwCSgrX6gUE940rVWdPXMRr4lWYEm7gO9LgFBKo2L+1ZheDnFcYBkuiYHgf0oaaE2tFVo1YoDFxUv2F+AizvrbnOYIXV31Yiu83wxGkrbAOAvHVDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724107483; c=relaxed/simple;
	bh=atzRkGA9+xwKM0cGvS1+C/x7fYWEtvPIycZ8biUMUVY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IJuOa9LjrFUMdf0dvGgtb/ezzDVXFA30nP+ZHQvOhwgPY6dXHpM8No7vszlQdqiWXplWIVC59u4CtKR6SXrSA6VgZaqAfUEorRQwrEydFj8QbJOC+ECc8HZAuKT8mTXjX0KEW25eDddU4yx/Y4GS30O6RnWM+epYZo1Qg6tODdQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WzSHcJOF; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724107483; x=1755643483;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=atzRkGA9+xwKM0cGvS1+C/x7fYWEtvPIycZ8biUMUVY=;
  b=WzSHcJOFBa2odGvG6g0ig87EnraHjCOfweaAmR1cMFvLsi7pqCY3c1TD
   gVuwJmSPJSdtm0+y9fZ4ugXYW1KktOuBQyEc12kcsUkRw0Z4BFPm++Qxg
   qM8Waj69ETtXHZQhWvJhvg0K6PuvDCdV9ZrGTcvuo7sj6t4HkICqDF2bt
   gfTXIaVadOdUSEFvW86BxKfnb61q4OJ2O4jIs7QcWQN07IQ7DfbIbdoAG
   sQKFYrAtxkVpvzj/tZvk5vMpQHZbrXQ8M9SnQB2CjMD3jNb0Kba6klyVu
   UCxch/CjfL10uFeMjFpcLrpNoNOaqZCI5OTlljQEQWjzlZ7McnwkjvMpS
   w==;
X-CSE-ConnectionGUID: aPu8wdjNST+28foeWjTt6g==
X-CSE-MsgGUID: K/LJiyYIRnesZo30IHD+Nw==
X-IronPort-AV: E=McAfee;i="6700,10204,11169"; a="33536001"
X-IronPort-AV: E=Sophos;i="6.10,160,1719903600"; 
   d="scan'208";a="33536001"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2024 15:44:12 -0700
X-CSE-ConnectionGUID: mrlR4iLxQQetvXDwBCbIZQ==
X-CSE-MsgGUID: omnqO7xOTEewytneGtN3gQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,160,1719903600"; 
   d="scan'208";a="61290390"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Aug 2024 15:44:12 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 19 Aug 2024 15:44:09 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 19 Aug 2024 15:44:08 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 19 Aug 2024 15:44:08 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 19 Aug 2024 15:44:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GykYCny57MrUvz1AruT5Fg0pofFL0+d7umPk+0PBj0TW4RoxVWFwIVeIYToyneqqlf8pRO8rEmk9X+75fdC5rSRDC9ee62RfyhzQxymL/SsxZoPYSfPet5+m/GdGTTQrl8Eh/CeZo64pr59Os3zz+iktzZEAI1zr8KYkjD8z2julmfxVVgCPjnBHVAuFiwKWBYL87pR9Gs8Dml425Pyo9me+pViflDV/bWNKIdNpmGVhtUGhfknBeD+Ka2IS5+5LwHM7qocM8C80RBjuhTI3O3ICotOx7vn0w/ruJXlGPm/ZrJydxAsezKvccddscJWZmYW6rdSu+Ps/o7W8qbtSDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D1WrOlAZT+j0fiBpeJFhIAtSqXDjifnrKemdI5FBmNY=;
 b=S1ZEenIzyTDorW1PeSnXXi2l1ODEzrztu+9CirLwBUA/iE/OIt9FHAVYfJ0x+ruGp3Da5c+lOL/x7ye9mlOfYSpI2NqVroBRfIvJ8YzvMv59tmcjrzM8h7sE6m0wt7qmz3Xeegn99+thScgJh14j+0bnbZ8f+fAmf7KFZ97wvGLhzlDbtGNhp3IXVqG/SBQfmzzKXaMx85AXrzAdyMCuEg3WUsn82rKl3Nb/kKDIpTbjuYF4xkWPdMEHebI+9dXjvUSYPoKTB7frbmjzWfXMRmMOhXlC+VYhhbeSv86IW5gM5kpEan8x17CPLoqZk5w5QnAefzMSjczKEJsGhzD8JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SJ0PR11MB6574.namprd11.prod.outlook.com (2603:10b6:a03:44e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 22:44:05 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b%7]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 22:44:05 +0000
Message-ID: <f4b60d0e-bec7-45d0-bbdf-fb04362c863a@intel.com>
Date: Tue, 20 Aug 2024 10:43:55 +1200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/5] TDX host: kexec() support
To: Sagi Shahar <sagis@google.com>
CC: "bp@alien8.de" <bp@alien8.de>, "Hansen, Dave" <dave.hansen@intel.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "kirill.shutemov@linux.intel.com"
	<kirill.shutemov@linux.intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "luto@kernel.org" <luto@kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "peterz@infradead.org" <peterz@infradead.org>,
	"seanjc@google.com" <seanjc@google.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
	"x86@kernel.org" <x86@kernel.org>
References: <cover.1723723470.git.kai.huang@intel.com>
 <20240819212156.166703-1-sagis@google.com>
 <29fba60b-b024-417c-86e2-d76a23aa4d6c@intel.com>
 <CAAhR5DEEsFNqdxbd62tGh9Cj7ZQMQs6fEjAKs6djkZzgZALOfw@mail.gmail.com>
Content-Language: en-US
From: "Huang, Kai" <kai.huang@intel.com>
In-Reply-To: <CAAhR5DEEsFNqdxbd62tGh9Cj7ZQMQs6fEjAKs6djkZzgZALOfw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR10CA0026.namprd10.prod.outlook.com
 (2603:10b6:a03:255::31) To BL1PR11MB5978.namprd11.prod.outlook.com
 (2603:10b6:208:385::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5978:EE_|SJ0PR11MB6574:EE_
X-MS-Office365-Filtering-Correlation-Id: 288c074d-bcde-41ac-9344-08dcc0a06dee
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RFZETGlUWmtSbnRGU2xOWWJYQU0xZk5BTGgxNXFzalRXMTJEeERtZzZXUjV2?=
 =?utf-8?B?bkNqQlV1Vk9ERFFGOEY2WThGbzc3SklnVjVEVXU4cGU5dS9wVHJ1aTd6dDho?=
 =?utf-8?B?R295cmJ0WmNEK3Vpc00yTHBpMm5YSWtDVWc0d0pENUJkUnZUODVWeHprNFhw?=
 =?utf-8?B?Vit3ZjNUOTdUUHM5ZnRvbnE3SWFwWnlBQ3dFdXJxc0dPeU9WR25mS0NVbzkx?=
 =?utf-8?B?aG40NnNPLzVLYjdBbmdkMkFlTmdJNUU1N2dCaDRiSks1ekkzNHpvQ25XZEk3?=
 =?utf-8?B?VDR6YjFlNC91eHB4aHNocXZldkVoS255RiswT2NUVVRRSWt0SjRFNVQxdnU3?=
 =?utf-8?B?ckVTaEY1MlltWWtYVnFxNmY5MlM3Zm5rN0puOFlxdU1BUUw2ZzBiUG9lZUt1?=
 =?utf-8?B?aldkcDZwYzV1eExHUVlNajVuTW1DTVQzV2ErS2VOQUdjdEFoWUFvQzVuTW1z?=
 =?utf-8?B?N1dkTlRFb2VWcmdtb1c4YkhiQlhtS0F2THRXcUhWRStjNW9sS1NvKzY0RGIz?=
 =?utf-8?B?TEdhYlNUblRlQUhueHVjWjR6aXJqRTdIOENGS2RTMzE4RVdyZysyUU1jRG5s?=
 =?utf-8?B?enN4Z0JEYXYzNzJISjJlRWhBK09VYmJTa3FIaDRDTEd4WDNnN1BYemE5WUpO?=
 =?utf-8?B?TFBrbmtXdFFQRkViTFhFUVNTb3BDY3Vvb085WkV6Sk5ab3BnQ3ByOERGQ1V1?=
 =?utf-8?B?aDFJSFl4TUd5TldIZW43cWlJS0F4azFKSlhTMEdnTlJsK2dNbzFMUXpiOGlD?=
 =?utf-8?B?RnF3NURnV0RxczJ3ZEx2M1RSUFV3U1haUFlwSjdGVHpZYUlLaFZ0WWpFVS9Y?=
 =?utf-8?B?TkVmTUYrZm5BRGFqWkFIRjN1dHY4VmFtc25UMzFONkdMcTdXVldUbktvWlVy?=
 =?utf-8?B?cTFHK0pJd1NsWGFTd1BjY0x6UitNNlozdXBjbTRUMDlUYmc4TzliOGQrOWpS?=
 =?utf-8?B?V29qUzU0K1o2ZUZLQzFtbk5RM2hkUXVyRzVKRDhhRnk1RyswOHRYejB1dzdZ?=
 =?utf-8?B?ZWlrOTJ1a2ZhblBGdHpXNi9QRDJNNFdpbTVZRzhhUUNFWW9oMzlIT1kyUi8v?=
 =?utf-8?B?L3JZM1lhL2VSQXRoeEFRNmN5ZTlTanN6K0s5OU9UV3Y1Q2RvenMxOWh1a1FV?=
 =?utf-8?B?bnE1YkV4OGxtOEFaV3Z6UnFiNE45RnUzWnJXN0JubStmSlB3UU1FaHFUZlpu?=
 =?utf-8?B?djN5Y1Zqa1RZTGdreGxXbFM3QlRmWDQxTmtkdTNBRTJiRXJ1c1ErY3JhcFJk?=
 =?utf-8?B?MDlrL290R1ZiM1BuUmZHdzFiL2htZm10TXJremZrNjVvZ2ppaFc1Y2Q2VnN6?=
 =?utf-8?B?aWFNWU02dlBZZURBa2FTOUVuMkRsM1pLYzMzRE9IMExpczh0MUFhUHFGSzZo?=
 =?utf-8?B?UFBua0FDbVg4ZUJtdDJqUjhpYWhqZi9qU0lGc1lMZXo4YW53a3NjdkxwTWV3?=
 =?utf-8?B?UXZpQUxSeFZVd2lHcm92ay9rb1FoY1RNVTlnTUVuOUNpdUVhSnkvaDFoczV2?=
 =?utf-8?B?WlE4NndQRVdFbWV2eE92ellZVDd4eUNOU3I0T0w2Mk45RGRRTDJ2NTFrSFBo?=
 =?utf-8?B?dXhvQWxDMENNS2M0SXZBMHdJa0JLMXlqL1RWVS9UUDFydzdhaXMvTVNKOCtt?=
 =?utf-8?B?ZzN1bVg2MHBYd2NZZzdIR3dYZ0d4SkIvek8rdFVCZFZUcElhNlJOcEJzb080?=
 =?utf-8?B?Zkp4Qkdxamt1QXYwU0YybzBJdlBxbklHQUlrT2RkM1B6YXhRa0NCUmowbW9F?=
 =?utf-8?B?WW5wMy9WaFpoajR4dmxuNjdQZGVpa2RFbm5JTVYvOVBXNjdiUVJ5RW5jRmhq?=
 =?utf-8?B?L0FIZC9aUjJPOURlS3dzUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M280RTZvR0xVVDY3clJnUkUwV3lTSmNEWVkvVFJOTW9QbGlSV3YxZnFqaGRl?=
 =?utf-8?B?VTVGNGxRcDQvd2Q0RTBsS2tDazdKaENMbUh4c245OWVrWFF6TnA4bVBLMEJ4?=
 =?utf-8?B?dUFCN1hCN0hadGZsQmNHVXZxZVUxMjN6SHUvL1dhU0J4U00zR1RmdUM3M0Fh?=
 =?utf-8?B?YVNOVmR2aktnbHZ2MjlhWkN5dVRmK201M1lkRGtIUWtkSnlYMlZldDVZV0tt?=
 =?utf-8?B?RkRZUjFHWWtlODRNejMrZE5mQnJJRU8zR2xINTd6Wm50eU9TRjhyeVBScHBh?=
 =?utf-8?B?MEJXMElLajNFSGlFRmI5cUhQRFo2YzM4N05rdGwzSVlvRkpOVWhCS0pReXFV?=
 =?utf-8?B?dmF3bEl4VUd6aVZ5WldQdmtPZ1hmZXh0OC9kQjN0Z3o0QmNZK1F4K0lGVUtB?=
 =?utf-8?B?TG1WdzVCVXdUUU93WC9vaWw2ZXRSUjNzNWF1V0pxdm14c05lSEN1UzAzdjJG?=
 =?utf-8?B?VlJha0ZNQ2NlTDFuZFJEbzcxVHRQQnkyOHFtYzB4d0tNQ3haVjNPMWZzajNh?=
 =?utf-8?B?QUkrTmlrK1JJWDQwQkY5UFlUdXFqdGk0dXo0bTdIZitKWVlrUjZQUnhyL3lN?=
 =?utf-8?B?N3FNT3hWTWZjRnhlZmorMEFQbWNOa0tpL1JmVURwL0lRYzV5alV6MUcybU1J?=
 =?utf-8?B?RUZyb0E2clB0UU00bHBkSVNPVzZnVlFlQnlheXBybXBLK3ZTdXJWMEZQektO?=
 =?utf-8?B?YjdtWW1KZVRaZ0VDaXgzVDc5OExTU1k0UUFuOVgyMW9hWmJLUFNNZVJtVlpv?=
 =?utf-8?B?Z0xkTWNuNkVSWGJ1RkZOVU50WmtMR2U5SU81VEp4R1FjakE0ZkNLVGFBYllk?=
 =?utf-8?B?Sm4vcDZWdmxrT0xGZ0tmU3hmZ1d4RTFaWVJSSTByNXY5Nm5DYy8vdmdNMmxp?=
 =?utf-8?B?K1hkK285Q25IbTNkQlc5dm5oaUhuMWdETGRuWlB3cGZkSENXeVZhUzlQUm5X?=
 =?utf-8?B?RmR5TCt4YWRjZ1lmTU8zUTZCWGt3UTExQkVyVG9kTlAxTVo0ZTBQSG5MbGpi?=
 =?utf-8?B?c1hsTUZhY0hzaUltODRRUjF6TzRGQkdRR2ZJZm05MjIvVXBNS0szOVJEcFpt?=
 =?utf-8?B?dW5SQ2F4OUh1VldmUFZubUhYWFE2MVpxMEZtZ013L2ZtUmJJRlA5aml5Rngr?=
 =?utf-8?B?T2xZQ01adDBnOXNycnhtZmhBVmFOcnpPS2RpMzViQWd0S082VVkrMElWSkhK?=
 =?utf-8?B?VUVhYVdKOFVpQ092bWg1V2ZNMS85V1RPVFpUT0lIbnlRQi9uaUY4Vyt0SW9B?=
 =?utf-8?B?Z210QlVrbjUrNGpsa0dwbHNWZVNtTnBBa0dWd1doaXhPa1hpR0N3VmtFK25W?=
 =?utf-8?B?V2lPQzBocVZoVGdqeTNoR3ZYZUlMemkwS2R5S0ExVndwazRhQUZ2S2xQUUx1?=
 =?utf-8?B?NCtYazVZU3JJdXA1MFIzRG9vMGhGOVQ1dWhsUjY1MW1oWWd5N2pKZWVwbWpi?=
 =?utf-8?B?MmVQR21DRjNRWTZtb3RBZXJLTjhMaHhUeUNrYUJkK1FQcmYzYmVtMXZDa3V1?=
 =?utf-8?B?T0t3b0I3c3RRcGtvdjAxS1hja0JzczRPVVdZTnFUM2FGa29WdjBYRjVGSTJi?=
 =?utf-8?B?Mlp6YUdVUkhaVlJYMURGbWtjYkVLMzhVRmhBYis4QlA3akdJeWpUZ3p5RWVk?=
 =?utf-8?B?TkdvNHhsdmZFbW0yYWVJR05VSlU4M3hTWmNWZndCL3pTcEpNb0Q1aG5vYlNs?=
 =?utf-8?B?MFo3alFTVDVFNHB2YW9ISzlyOWZXQlVoaWFjUmswMWsxUXRTZUtVUGE5SkZO?=
 =?utf-8?B?Q1llNC9PcHhlYm5KU1AyMU96bmxTUlVSaU9jcS9QbGkwR3VnWHZZQnVTVDFQ?=
 =?utf-8?B?NXBBZWdwNUhOcThZeDZVZ3hCQWNUOU9jdGVYVlZNWmV6VjhVblZKS3FZWnBR?=
 =?utf-8?B?bUdrZXpyUlFmNzdCZFdHSDhvVytQejFPWDBJc2o4aHJndlNYd2RLaTdWNnho?=
 =?utf-8?B?YVd4QmFVNlJLVmhkK0tFS0lDeW0rRDk3TGJZNjFhTTl5VGYzeEJ3UnFOcS9r?=
 =?utf-8?B?RlgvN2txL3gvZGdpdFR3cHRkOC8rOGlpZWZVeFU2M1ZuM2VaM1U5TWZQU0xj?=
 =?utf-8?B?UVpnOUVsbkhyWkswU09SZXZCSnBtWk8zcjgrWEdoaXk3WVJ0WTZNdTIwa2xr?=
 =?utf-8?Q?FfOHgwl7oMpD/oo1RoBlzQe+W?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 288c074d-bcde-41ac-9344-08dcc0a06dee
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 22:44:05.3019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pq3aoRyBm/p0Gu2MCO3TB8pBN/k63VxHJBEfsfhicaR0p+ydVm1gjcg5YQLP7KrwrSZQrkd+rPiB1SBKvP8J8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6574
X-OriginatorOrg: intel.com



On 20/08/2024 10:28 am, Sagi Shahar wrote:
> On Mon, Aug 19, 2024 at 5:16 PM Huang, Kai <kai.huang@intel.com> wrote:
>>
>>
>>
>> On 20/08/2024 9:21 am, Sagi Shahar wrote:
>>>> Currently kexec() support and TDX host are muturally exclusive in the
>>>> Kconfig.  This series adds the TDX host kexec support so that they can
>>>> work together and can be enabled at the same time in the Kconfig.
>>>
>>> I tried testing the kexec functionality and noticed that the TDX module
>>> fails initialization on the second kernel so you can't actually kexec
>>> between 2 kernels that enable TDX. Is that the expected behavior? Are
>>> there future patches to enable that functionality?
>>>
>>
>> Thanks for testing!
>>
>> Yes this is the expected behaviour.  If the first kernel has enabled
>> TDX, then the second kernel will fail to init TDX.  The reason the first
>> SEAMCALL to initialize TDX module in the second kernel will fail due to
>> module having been initialized.
>>
>> However if the first kernel has not enabled TDX, the second kernel is
>> able to enable it.
> 
> Are there any plans to support both kernels being able to enable TDX
> in the future? Either by changes to KVM or the TDX module?

AFAICT we haven't received such requirement so far.  Let me double check 
internally and get back here.

Btw, if we want to do this purely from software, changing KVM isn't the 
right thing to do.  We need to somehow pass key data structures managing 
TDX module to the second kernel, e.g., module status, locations of 
PAMTs.  And the second kernel needs to be modified to understand those, 
which means some old (second) kernels with TDX support may not be able 
to support this even if we add this to the kernel.

