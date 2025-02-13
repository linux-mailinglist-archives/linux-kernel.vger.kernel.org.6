Return-Path: <linux-kernel+bounces-513012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA733A34088
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 14:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E78D816AA97
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 13:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F345923A990;
	Thu, 13 Feb 2025 13:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YMBUdlwl"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A94D23A983;
	Thu, 13 Feb 2025 13:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739453966; cv=fail; b=Yu952gtsIiKt7MlyOkWV9Odv7q+C8QNrUnBkd9+2MxtNpeEiSyEnuXSyX4mTPqqbzAUdZoCuPCDm3rioK7iXTCcjXyZ+byH7jGXE0i4MLxef/nBS7rSdLbHwGAgV0JjUgeGbEeTKOS6ke73iMVXD8mIg6lm5WwO8YRGaJqafpAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739453966; c=relaxed/simple;
	bh=ZlH23s0ZZTzmCXRhoGV9aFrxwAJswnFJsxSnm3OGCo8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=n9+5J0eNodDNaQuodBpt0Gdwqjv64DaXZY0qX4AFbeuxHtGjGprdkOvbgFjB5CkRcjwGGnW812tqPdpQNv5B4h0TJqOnHt5p6HluUUrOpGkRujSqUJm4svG18Lfj7M4qo4nMG/YP3A+15wxg0I4CkpTPCNetdEokJ73UqAHYgCo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YMBUdlwl; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739453965; x=1770989965;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ZlH23s0ZZTzmCXRhoGV9aFrxwAJswnFJsxSnm3OGCo8=;
  b=YMBUdlwlUA7eUmHS53mgu5yP4X0rcRICLaRaXOX0mzHuh2b0airJAPgi
   oCxcGFOCtheyIWinxyZcoZolimrPjRlseELgD3srLlJ0wEQDHq4Q/rskJ
   hgtwLJqJBqk6W/IxYnUkkdgbHPnCXDaeXEJLmMCbat028z4SkTyw5/LR3
   2c/y1smrd/oAjY3CLFH6EP2zYnhk9yy7k0ykxQUBW7VJeh0BylRlD6Qpm
   VQTk9dp4OI1fhiq0pORwTTTfqYSEtvzbx3RVv2CVGPKHIM0CYcaQ3kqIs
   y7IbpJAsjEvfwngBQgrfQeXZASqmYdqfcrOacuYSYyRp2VTLwIiIr5j3E
   g==;
X-CSE-ConnectionGUID: YTnY8AYySsKg+7WWEXPV8A==
X-CSE-MsgGUID: naDuOO3WRsSBCa6MPrdJTw==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="50369419"
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="50369419"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 05:39:24 -0800
X-CSE-ConnectionGUID: vnwycQ5FQkOYGoTkjh1loA==
X-CSE-MsgGUID: 5ncjEgdeQwuXd1J0h/BsnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="113324505"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 05:39:23 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Thu, 13 Feb 2025 05:39:22 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 13 Feb 2025 05:39:22 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 13 Feb 2025 05:39:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e8b2VdRgOELsRSCpVj1ltpymDNY6do1lhSYuKrPbufDbojfnzlZSQLKKM/lTBf3W5hszJUirftLIxqZB9P7WE4P4bnV8GZDqoT+seL7JhNJyx7xDW80VC7LnXORueNnRyFr3JRzzvTDS8Kkm7Ud4mhbPOWyVib/TwSdbxckBcJ4X+u2L24H2EUpsq7FkuVP3WHekOhFjTnFoAE2Nat6ZjB0UBgJL7IgpYuaDi53G5N2yUXZcDHrDHvciJ8NPe1dYjDWDswWpCNtyX4sVSUNDzK6VEwdOSVMcuQR1nRWDbAtWQPbVd0/YvpAdsWSLvR+d8ibZx9f9cIQY6LrRoxuiXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6a5R1gCt87FzaNuxZa2sT6M2TBXGCMBOeKOGqknrGUg=;
 b=E8NCF5/7jWwdXMWOLeRpYWkkMC36oGrlfnhj2zrjRe2WeN+drLPgePshS58bae13pJFyrkaEqUlDdVoTzdn15jA4ZpNdrqJjzN7jji231aP2RAOaILxiJ+fndtoxWc9TvNKxqOUTZMPiBar2RVoqBPzpy3qmDO9ZZkfBk95WcqkQY+Ns++Vw72D4l72/K9iyDpvIXUKvCbhFaMazTKupS+Q7z5RwNAayG+MV2I1Ah1wamoyS7YR0GDC9wOgqAgjb4KxuKDgUxKZQGFrfBJi8cY/8tCvminkAkw+yo6auZJRIkM7kYvEDlWqn9Rh1aDWDc3e0Ae+dOMJc19ybz4uAyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB6375.namprd11.prod.outlook.com (2603:10b6:8:c9::21) by
 CH3PR11MB8703.namprd11.prod.outlook.com (2603:10b6:610:1cd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Thu, 13 Feb
 2025 13:39:06 +0000
Received: from DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::cd01:59f6:b0f8:c832]) by DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::cd01:59f6:b0f8:c832%4]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 13:39:06 +0000
Message-ID: <8c59618b-a9a6-4a0f-8200-2b7152dfe40c@intel.com>
Date: Thu, 13 Feb 2025 14:38:59 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: Intel: avs: Use str_on_off() in
 avs_dsp_core_power()
To: Thorsten Blum <thorsten.blum@linux.dev>
CC: <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Liam
 Girdwood" <liam.r.girdwood@linux.intel.com>, Peter Ujfalusi
	<peter.ujfalusi@linux.intel.com>, Bard Liao
	<yung-chuan.liao@linux.intel.com>, Ranjani Sridharan
	<ranjani.sridharan@linux.intel.com>, Kai Vehmanen
	<kai.vehmanen@linux.intel.com>, Pierre-Louis Bossart
	<pierre-louis.bossart@linux.dev>, Mark Brown <broonie@kernel.org>, "Jaroslav
 Kysela" <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
References: <20250212091227.1217-3-thorsten.blum@linux.dev>
Content-Language: en-US
From: Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <20250212091227.1217-3-thorsten.blum@linux.dev>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0122.eurprd09.prod.outlook.com
 (2603:10a6:803:78::45) To DS0PR11MB6375.namprd11.prod.outlook.com
 (2603:10b6:8:c9::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB6375:EE_|CH3PR11MB8703:EE_
X-MS-Office365-Filtering-Correlation-Id: dcef6f69-8e65-4e0c-9bf0-08dd4c33c921
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SEVUTWlHVFBuYWYvMFVlTWlvSDhRSlRHYVV6ZnhNcUQwRC90RDlQN1loMEwr?=
 =?utf-8?B?T1d6RlFJUEtoQlVWMEdRbWtFdVRwK1FGUWg1OXNhdS9WbFZaWGoreVVuMTRU?=
 =?utf-8?B?NDY1YUs3UUZFbk5TRVNERDkwMnVITDNwWXpJYTJIYXB2K3M4RUFJUE0vRDZO?=
 =?utf-8?B?ME40SS90NUJDNzh2NHpvN1dFK05iMCswa1lybDB4b0RVcFJtb0lsRWdOQjNH?=
 =?utf-8?B?ZXVXenhqSnB0TGNXZmd5WDUyalVnamkzbjNGUzkyNnB0QkpWdnJvejYvdmpP?=
 =?utf-8?B?aHZhR2owLzI4ZlY4N0xCOHkxNmh3c1htNk1ma1RwbWExeDVRR0xXTW5vaWtp?=
 =?utf-8?B?Vktkd1IzTmY1Zlo0M1J1STJjLytxUUpMTmc3VkhVNXkyUEdPVGp1TERkTHNI?=
 =?utf-8?B?U3lrRlpYUUlob1JDRDIreThwOFlwdHp1Qi9WekE0SUR1L0E2Sy91YlB6SDht?=
 =?utf-8?B?K0swUUlQK1VaRnNzdVo0Z2tGRXpxV1dXYjV5WXhCU1JRa2lwMjgyNGJ4ZWw1?=
 =?utf-8?B?QUZ0YTk5ME1sdlVLd01LZnRXRTZVYUEwZGxBREpiMVdqSUZtcGp3YTZlbXd3?=
 =?utf-8?B?bFhWMEQycnVSb05sUDNxdXFqbVNvdktWZWtEQzRtYVBxOXRMYlpBL2NDTU1i?=
 =?utf-8?B?MnVZby92QlQ2KzVGdDVURmhVODNLMXFuL0p0dCtoMnUrNEdPQWdENk5KMXhU?=
 =?utf-8?B?MWltTnpmc29uTU1LR0V5RGlOb1hST1ZMZEQrZm9UNlZCalhVMVMyYlBaRzRy?=
 =?utf-8?B?dVJJK242TVdRRHNCd2x6VXQ4T3JVbURYUTVSdWRnYkYwbGFKUlpVNEEvTEUz?=
 =?utf-8?B?b2N5U2RyT2JwSXN1dlhsUFZrd245OHM3c2hpV0VoWGhmVVpidDRFdVdOUUJp?=
 =?utf-8?B?VU1CRFB6S1g3VktsYStLWERtb0J0WjRnL1djbkViVmJuSnRDWHAwUkhpa3dT?=
 =?utf-8?B?MHN0MXN2emduZ0Z3UzdDcTlhczZTSXFyNkR1NkdjYWdXMlZQVlZTOWtZQlRv?=
 =?utf-8?B?S1BqNXNQY3RhZGIyQU5KaDR0MU5oV0pVTG9HbjA1Wno3VnBXY2Fpa3BkZmpv?=
 =?utf-8?B?VlkrOG9hRDZCUTR0cGE5d3ZxMlpuanlsU0M3a0FueXlxNGMySGhZd0d5dkk0?=
 =?utf-8?B?dVVDRGlES0FaRkJwY2pmMDliVkdmcW03VWh5dXJpbXFqYXlKOVp3Rk1mV0R2?=
 =?utf-8?B?RWJuazIyQjRwZU5zV2Z5WWlNY2xSeFBISEo5bWIySmp4eGV5MDV5enBKamhE?=
 =?utf-8?B?S3Zoay9MNzA5L3k4QlpyUFFyOENlbE1pZG5sUXRMSU9lQXlvYlVIWmR4VExN?=
 =?utf-8?B?T1gydFNxaXpxTGN6cWtJUDJ6UDk4bnY1eWxEb0RKem1seXM5WHluNFV6OXZT?=
 =?utf-8?B?bFVWZU0yK2tyNDFJRVFPNHo1NHYrRXNhY2xYbi9kSklCQ0J4U09MMWR3Q09V?=
 =?utf-8?B?TDA4Rm9JM0MrUHIwak92T3Uvdnlad1M1ekJYTTVmam1UZXNtM1lSdkVhVGY3?=
 =?utf-8?B?R0RTV3lyb1I3UEVYcFhLajR4YXJPNXdKbHhhL1pZSm1pSjNkMDdQUVBnU1B5?=
 =?utf-8?B?K0hTbzA5REVGMHFIQUNGTHJtUGRwMFJybXR3RXlGK2FHL1ZxamtodldHZ0V2?=
 =?utf-8?B?OUJhckswcmpPbDlxZytQNnBkRkEwdjlNVko4Vm4wR0ozRTRrMUhlenlRRitz?=
 =?utf-8?B?bTBmNnpDKzdTaXkrVnJ1bmp5ZFVibzdpMDhadk1FZnpta2JwbUNvcVZlcFVs?=
 =?utf-8?B?YW93TnNzRXRqK29pLy9ZMFlGb3NKSXkyTmNnRmlwMUR4NUdUNEI4ZERDUWNM?=
 =?utf-8?B?dmZTeWg2MDN5WnNnSzEydWlBc3dnMEsrV2hHenprZGdlQ3NPS3hveXAxSnpa?=
 =?utf-8?Q?1lIVJhdxI2kYd?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6375.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cCtNVExWcXRjSDFDZzluM0JRcXpPOEw1cGlDS3lPVUcvWWcweTlPaWl5WSts?=
 =?utf-8?B?TnY4NzRZU1RDN28yWi9IdmN6VGdRTGhzMHU3b0FGVkRKMGlZeFJySHdaTnIx?=
 =?utf-8?B?dG1FbFdSamcwVkFFQXl1N2JQVmkyL3ZYbjBZeXhLZFBXN1VJTnptM3E1VWpa?=
 =?utf-8?B?bUhJcWUya3ZONmJlK3MwbS9NanZBRzBUWlp2WmVDeVY5R0N4Z0RMcHZWQjh3?=
 =?utf-8?B?SU55eHBDam5QZXdIeVBZWFlobWJLQUFuT3grdm9pMXNVVzRMZUMrTWRqWEZO?=
 =?utf-8?B?NXhncVI3Mjl0REFFZEhYOS9BbXFHeG5IcnU3Wjg1WEN1SVNnYjdMZHptMTNH?=
 =?utf-8?B?OVR0bVhHQllOS0R4OFkwTkRxMmpnd3VyNzgvWDNXTzMvdXdxem5CRksvTGI3?=
 =?utf-8?B?TUhZNGhSWWlVbWltdUJuKzc4ZU51MEYwMXJodzJyQnp2L1dTNmJ3QUpJWHNm?=
 =?utf-8?B?eHlOKzhzbHNtYlR4SHgraXd5M2NrZSt3cm56elBESGp2NGEwaUFRMnlMWTF2?=
 =?utf-8?B?UUI2dWw2VE9vSVcvN3RxY0JxNFhGcjhMS1ZkZmdDREFvcFpwRTVvU3JqeEVV?=
 =?utf-8?B?UERkZnR1OWNVMkMvZFgxS1NwYkFiN3hBa1JXbnFxUWdvRWVkSERwYnB1S0VR?=
 =?utf-8?B?Q1lMZ2F1SmkxcE5qcjhGYWk2YzBMTjdoTzFwYWYwc3pEQnF6dFJMUWJ4L3Zo?=
 =?utf-8?B?Z2FmSTJUVE41NEFJZnkrWTlCZUlUNVdqdFdMQ29HN1VXdkxFUXkwMWhxQVpS?=
 =?utf-8?B?eGQvYmoxZU83YVdCUkZCdHM1eVVxcXpkOHNmcVBQVTJpVUFpd0x0bFo1OFlS?=
 =?utf-8?B?Yk9RY3lmVDBDUGFZWEpmOTNLVjdBam9hQllVUzFjZ05zU3Z3OWtGcDFDYldo?=
 =?utf-8?B?OXhhdmZoOTh1b2w5TUlaZ01JRFVLNVU1VDZtczUzQkhWQVFSNmlmV2ZycG5k?=
 =?utf-8?B?T1hEZjVkYWtSb2x1OTdzcXdIenhzMzJhZ3BiczBwTVNCT0VUOXlDYllSbXd0?=
 =?utf-8?B?bGZKNExIRElmRzllaEVDdjhWeG1lakZZWkcvTHlkdHFTYTMwY2dqZWlzeFVa?=
 =?utf-8?B?UkpmeWFkVW9tSFcyNTJtRGVGUGF6c2tnK3FXODJBVWVUc0ZlNS9WQ1NrRHBv?=
 =?utf-8?B?Smk5TzhYcTJmbTdtek1NSUtsSGM4ZnZJQ09SYWlhcjNvQlJCU0d5YlpmZFVJ?=
 =?utf-8?B?ZU91MnFKUEQ3U05mU2JRTTJFV1VacURBL0EvUTRlYWhmbEJCS2pHa3RTZDg5?=
 =?utf-8?B?bnV6YTZWUEtEQURQM1E1a0RNV2JITlBDckUzRWdYSE1LeUVidVkxT0NkbGRa?=
 =?utf-8?B?UzZhdmR0cGhndi8rKzVoNHpPcEx5S3NINElPVTJrYmZlaTl6M0RVdlNZS3V5?=
 =?utf-8?B?Q0YzNzM3em40dmxtUDM1VVVBNjNMWXNrTWVYYW5rVEIvVTJXalBvcTN1ZnBI?=
 =?utf-8?B?SDBYK21PczJ3OWJPQ1hqOHZRUzB4NmJKaVVTdUptNmZYeFRwQ1JOZXhDQm5U?=
 =?utf-8?B?NkV2US85Wjk4Y1lKRDJ6Y2tpMm1weTl2UW5VTTV3NFFaWVJqSFlXaXlGbm1I?=
 =?utf-8?B?OHBVVnk5SEw5cVFvNWhYR0JLR3c3NVRKbzkvNGJrTG4zQ29WcG80T3MzS1NI?=
 =?utf-8?B?SjYvTEZLMEJ3YmN6TEtUcVNTR2RJK2VoWlErVVR1akFFakUzc0hXcC9GcEk4?=
 =?utf-8?B?ZkdzWitCZkJGRUV5VTNoeGxNSm5VRllocSs0S2thcjg5d090TVpxK05KR1BK?=
 =?utf-8?B?M1dXTyt5ZUp0QU52ZUJCalZoZkNuUW1GZ204YzkxNzVhdWtua3Z6TTJrZUR3?=
 =?utf-8?B?cTE1VnZNdG5xRnBoM1RJUjdsRS9nRVNxekRzTTJMbzNOTTMwQkYzdHpocDcv?=
 =?utf-8?B?MW83VUU5TGJwR1lZbUFseTJaWnVnczJsVVNVZEJENzhTc2RlU0JnSkFkWVJi?=
 =?utf-8?B?YXhFVXNEK3BXUTlmYzZibFR0Y2hTTnp6WFNvQ1FxTENBR2N1TlVqNEZnV2gz?=
 =?utf-8?B?SnBmRVFtYkUvWGZma1Y1SU1DSHRGdUFHdG1UY045ejEwRE9qOW1DUlBaRjBv?=
 =?utf-8?B?VzcxRW14MWdZdFc1NEhDMzhqM0tpQllhSk55WUJ4NStIcGFCMmplNU1Kb2o4?=
 =?utf-8?B?eEJaOFdoWiswM1J6QnREZDQxbE94WGJyb0dXSEN6VUFmVGJyMWx6MFh2VExJ?=
 =?utf-8?B?dFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dcef6f69-8e65-4e0c-9bf0-08dd4c33c921
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6375.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 13:39:06.0716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l1P819PyWq+dUh0bZ1ruiH7ZQ/jpHxPOXvnHsaMBpchciXARY1ua+WEtolGxbich2WFzt20zIDe8ZYJwCgI79ixV4eWYZosv0ce/J4giwoc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8703
X-OriginatorOrg: intel.com

On 2025-02-12 10:12 AM, Thorsten Blum wrote:
> Remove hard-coded strings by using the str_on_off() helper function.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>   sound/soc/intel/avs/dsp.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/intel/avs/dsp.c b/sound/soc/intel/avs/dsp.c
> index 7b47e52c2b39..b9de691e9b9b 100644
> --- a/sound/soc/intel/avs/dsp.c
> +++ b/sound/soc/intel/avs/dsp.c
> @@ -6,6 +6,7 @@
>   //          Amadeusz Slawinski <amadeuszx.slawinski@linux.intel.com>
>   //
>   
> +#include <linux/string_choices.h>
>   #include <sound/hdaudio_ext.h>
>   #include "avs.h"
>   #include "registers.h"
> @@ -39,7 +40,7 @@ int avs_dsp_core_power(struct avs_dev *adev, u32 core_mask, bool power)
>   				       AVS_ADSPCS_TIMEOUT_US);
>   	if (ret)
>   		dev_err(adev->dev, "core_mask %d power %s failed: %d\n",
> -			core_mask, power ? "on" : "off", ret);
> +			core_mask, str_on_off(power), ret);
>   
>   	return ret;
>   }

LGTM

Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>

