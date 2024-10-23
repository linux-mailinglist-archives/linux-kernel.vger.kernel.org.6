Return-Path: <linux-kernel+bounces-378909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F159AD71E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 00:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D75A61F23870
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 22:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E531E282A;
	Wed, 23 Oct 2024 22:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H/mQa3Mt"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E4A15B551
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 22:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729720866; cv=fail; b=DM4wG1xVhJwqdJIZ0Pb1ffX3tcAXO2Nnnh07pFfTPuhNefAu0P+j3vhoQrvTqdr2Gg9zNRDC1niQYzQc+jSm5ECn7v9KqWP3nAKSHL3Oz0Vnk6BbCJX/E2wzg6YXp3zJmZZRKohXhgT+gGpUPoTng1IkIFjCg/VI7mgVFyZbFgk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729720866; c=relaxed/simple;
	bh=ryWbsXPmj/LYasgRYa3Kxb1IuCu0sy6Rrf/GypjAFDo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VTqg+1l/mJmtVk3blZ4jXmp8N3o5XktksUoUFjkHV5jnpJMt82juDA+e0jzBViSZmWjyTgmw+hTiRo6MQRkB7I/oCpijBKJLSE5qD9ghWVAludw2fjB5wbzQ3CJexLkGfU2+0140h2Zb5ryyUiCS9ZG0y4euSfq0+8naV5QHduA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H/mQa3Mt; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729720865; x=1761256865;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ryWbsXPmj/LYasgRYa3Kxb1IuCu0sy6Rrf/GypjAFDo=;
  b=H/mQa3MtwlUjgRcZ8ObWzTaD1a6uf4uOpTR0VvN13c+2bW6mU8lSTObb
   3ErUZSbWcRU2oxryC0HWj2ZE6l69JspaWg026/kkJ7l7YvT+gbRNZgQeC
   LE7xUZfK6vAfbU2gOloKm/Imy8V6Tsfqpe3I1z/CRcASzDvGCu055qhr0
   y2GVzTFl845o5N0UgC3GfQQowllPFST+s3liAJNu8OLGE0KU88nKVUk4F
   kMSS2bzAyygO4K35LsgL9PcVCkIlLYEX0Wf+0R1qLizVwkqhO2qVblY9t
   ym9FB0h95hc/sJEmVxV1iAeeWKbJF6MkSvlUl9+414s5xkVQxwLUfIYpD
   A==;
X-CSE-ConnectionGUID: /nifsmB1RzOuXP22a/xh9Q==
X-CSE-MsgGUID: xW1DekCDSIil1JhHAhGJgg==
X-IronPort-AV: E=McAfee;i="6700,10204,11234"; a="33244414"
X-IronPort-AV: E=Sophos;i="6.11,227,1725346800"; 
   d="scan'208";a="33244414"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 15:01:03 -0700
X-CSE-ConnectionGUID: U/U83j1bS3Wi4vROKDnYyA==
X-CSE-MsgGUID: nZLVll68T7uwHjkrwmbB+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,227,1725346800"; 
   d="scan'208";a="80322095"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Oct 2024 15:01:03 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 23 Oct 2024 15:01:02 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 23 Oct 2024 15:01:02 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 23 Oct 2024 15:01:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PNGZVCewm7v54qU8Bc+aIfdPZVU15odFqFk76KBdyk7mHvdaw7M59FaH0slvEELlZzJwr7xy3nIy00fKYciDCHBlp2bxkACwYTLfk4sAqLPHabpVhX9NGU2ZH3OjEZgHp49TRIUophHBZNnkjZ9WDIeBcQ+Aihh3X+GUGcO36hTLjJR9dSM3rpwkET6Oi2FA9NqUC+v5mRptmvPyBe9Nc99tciAHUOnhi+FI7boGrIO3su3VzabgY7wpOETRfjgrw+FH4fGWY5j+MxrKJ2+cFFH8d0S7ZEDrSnv36XdoQ+kTUSP2GzNUkEMuHWLz15yp0WO1IqkypQHLDPIUlgBqrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g0X//lchuThZVao4avcVK7aX2E6FekQoOZpO2QnS2VI=;
 b=pFD/7/g+xrrZ94xnqUGjE8g+64uApBtwMfnaUOuEfJFY3KbmxNIojz7jjGPHnC8/tRV3dxyyoaX2xZ40pwCnT6XqvodmGCG0Njd9Sk3HjotRu8EcRRUvEoedRwcJuv5z+pVhFv7jF/NGglsuGYA7cUdnW0cUM75jXL4mMhe2HUrQRdysnAZ2l0n3KFTjIgUS9YA0NJ8YDRPLIn+2Omlj6+N3qwRoUHcCmOGYEsYQdLWEdNljE6tkU5gaoiUmdtH5EZhCQLwgSCECh8QzL9RYBI/jo0vhsXDAOmpT629lcaDc+SAkZZx+P5WNlaHCBZfvXEVjZaxfNZ1TSYHx8xuDmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS0PR11MB7287.namprd11.prod.outlook.com (2603:10b6:8:13f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Wed, 23 Oct
 2024 22:00:53 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8093.014; Wed, 23 Oct 2024
 22:00:53 +0000
Message-ID: <49e78ef5-b500-4135-a32d-003d3d62f239@intel.com>
Date: Wed, 23 Oct 2024 15:00:51 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 18/40] x86/resctrl: Export the is_mbm_*_enabled()
 helpers to asm/resctrl.h
To: James Morse <james.morse@arm.com>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Fenghua Yu <fenghua.yu@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, H Peter Anvin
	<hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>,
	<shameerali.kolothum.thodi@huawei.com>, D Scott Phillips OS
	<scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
	<tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
	"Dave Martin" <dave.martin@arm.com>, Shaopeng Tan
	<tan.shaopeng@jp.fujitsu.com>
References: <20241004180347.19985-1-james.morse@arm.com>
 <20241004180347.19985-19-james.morse@arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20241004180347.19985-19-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P222CA0011.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::16) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS0PR11MB7287:EE_
X-MS-Office365-Filtering-Correlation-Id: abbc2e1c-1649-426e-56a3-08dcf3ae29fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NHdzQ1ZOelI0WXlicXJmZ3pSUmdaMlA2RzlDZy90cFlwa2d0ZGxZT0pGT2pn?=
 =?utf-8?B?TjAwc3pxeHM4Z3k5L0ZzZngxbUI1YTN1cUEzelJnczkrODJTRnlGMloxOWQ1?=
 =?utf-8?B?ei9xaVNZYWJocU5kT0Jha1QzdEc1V3ljVE5KRVlhdU9sSUVDRnFLM0w2ODls?=
 =?utf-8?B?aENDV0JZNW0vTkdOR3h0OW0rQVdobGN0T3VmWTZlanNNcm5pQ0x3UVhaQklu?=
 =?utf-8?B?cTdoazUxK0xVMCtWdkpiNEVKaHlpMkphUXNWdVA3R3AvREJFeEpOcS9NL0Vx?=
 =?utf-8?B?Y3FaVjArSFRrTVAyckhaRkZGYzNjKzZ2YS9DU2xmazJpaFFtN3AyZTcwVGJ5?=
 =?utf-8?B?cm5zUmljTWxYYlR4bVd0SFUrcS9GNzRzNGlubHptaENQUWJkTnFIK2w1T2F2?=
 =?utf-8?B?aERGR0dvcUs0U25GSGxCQktYd3NrNFBQR3RWeDBnV3FYdDM0QnJvVXFTek9j?=
 =?utf-8?B?R2lja2UrZUFKN3I0SXprMVMwMHZib1NndEl1NTZtTWFwRmpvUk0zRFZnU21q?=
 =?utf-8?B?VTV5UFI5QUljdHVUVFlWdWp5bTN4MkIrNGdkR0RVdEFERHNvbC9lSUVyK1BV?=
 =?utf-8?B?MmdPZ1QwL3RmWFpudXdMa05vR05RMGVNb29EWjJaM1FtaWI3YVQzNVRidDlu?=
 =?utf-8?B?aDU4NXZVeW1GRGE3RXpnSW1oU2hPRHhncEdRbFVvbWdidTNKUW1FVUFKMEl6?=
 =?utf-8?B?ZmkxcE0wbHpZc0dBblRJZnhLczBzWjlJYzM2N05OdXFPRUdHUWRmT3FWTUhy?=
 =?utf-8?B?cTZrYmNkRHpvNStiZ2hrV09FMlZHNnVPSXJiUEJzeVdoeVJ2MmFuemt6MzVZ?=
 =?utf-8?B?dU1QaERiTXJPWVZVblNQc3JuK3VXL3JCMG9CY0lwS0JJUE4yVW5UNTk5eHZU?=
 =?utf-8?B?ZmlRSlVTYkdYV1Zrc2tOS1hxOVl3VEJSZCtiTUZzTzEwU0Rsc0JkK0NXUTUr?=
 =?utf-8?B?cFFmNCtKSytpTmFidnk2QTRPU2VRSy9hK3QzeGJrSWVjR1Q3aGF5cVFSZkZ2?=
 =?utf-8?B?K2VybHpTNEQxV01tci8rQzNpeXBScXQ3NDNSZ2tibzY5MjJDWld2c0FSU3NF?=
 =?utf-8?B?NHBHV1dQSEFFTElGZzFMRjB5T0o2L0J6OFpGQUc2NnB6cjZRcWdYbEhpdC82?=
 =?utf-8?B?UVlnSmc0dXl3dXI5TW4xL2tUbHk5TTVJYi8vbi9nUHVrdFNkUUR6NUlBblFF?=
 =?utf-8?B?YWJjTU1PV1hUQW0weTdIeG5WZ3p5S0xjU1UxRUhwYkJWZjVrdEpkWFQ4OGdF?=
 =?utf-8?B?aFV6ZjBuNnFvOFZ4ek9lWUNvVkVLT2VxVEZvUjdOSGdQa1RJVDg1WEo3Nzl3?=
 =?utf-8?B?MW9RQnVrNmNhVjduejV0WVU4cTNGQUVsSlZHd0NJNHEzRUNNekRqSFhBUjhV?=
 =?utf-8?B?Yy9oVlh1OGE4dTlKejhFNHBRSWVQSlJxdlEwc01uS0YwK2l1VXhlbTJpWlRo?=
 =?utf-8?B?ZzR6Z3FYclc1dFZ6QWlURUJFWEhaTHZBWkVybTE3eTB0MnVRMDZFRStsS3lR?=
 =?utf-8?B?bFc0Lzd0a1VsRmlzVTVXR2p6aTFVZU5Kc1RwanJCVEIySUFCcmllOXBnczF2?=
 =?utf-8?B?Y2ZOTGQxTTJONjIrSUJpSWtpVWk1cExjWUtWVUlXaVZMVlpuSmFMeXVDeWRn?=
 =?utf-8?B?eDloVkVNZlBRZVNRNHlYKzZ6TkUwd3RSVUNLQndhUWJHRzFtYXd6YzBoR0Rt?=
 =?utf-8?B?WEd3RzYzcWNwVmZqSVduclhrZUlnMW9hSlR6cVljeVMxaCtESmJNV0xGMm1J?=
 =?utf-8?Q?eAKmrpNlBltxdBXEpBEEPNtMqLX7JAdtmjLZInl?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eXdHU2NwdC9iS2Q0M2ZsV2dVd2lpSGE5M1hORHMzY1oxRFY5UGV4N2ROUDU2?=
 =?utf-8?B?cjRTUTRLY1BoSU11ZlNNenpvL21LcnozS0lERnBHQzVQYU5Cb1FWYXBkZ2JZ?=
 =?utf-8?B?U0ZISXBra205Z0tNY0pYd2NwaDhNend4Y3diZFQ2WlZTRjRGR041K09ZbmMy?=
 =?utf-8?B?OFZ2cUdlbW1DeWxUYjFWajRJR2xvMlNGcUVqOCswbW84SCtEYlBOY2QrbnJM?=
 =?utf-8?B?WFgxZ2x6cVd4RFR3anFWb2JwczZXd0Z1SnE5b0lZZXZYMWgxaFlKdmowd3Yv?=
 =?utf-8?B?ZndSSlptZWI3Yy9WNjVTQnZnNGQvbFRZZTE1aUZYWmpvVDcxTXFhd3MyL3JO?=
 =?utf-8?B?aXU4ZGZ2ajJtbEo5QWs0VzVWcENMdWxHZmdNSUlldHVlRmJVUVROWTBYQ281?=
 =?utf-8?B?VXRKODB5RVhKMlQrbkFMRks1WlcrNFlvMW9hVUgzQVgrRXdRakVlblh5YThy?=
 =?utf-8?B?Yy9zb0pNN3c3akozN1NYbWpDVzNIYUl2RDJZYStzN0hMemFPMHAzdjZubCtr?=
 =?utf-8?B?bnZydWlIN0Z6WndRTFE0UU01TmRyZ094RFd0cEJGSHZJQW1jTExtZWFFdWZN?=
 =?utf-8?B?dFVVenhUeTV2WHFidGg4Q0xtQUFaL0dxcU1ObmNZNUtPOGExVkVrYkd0WVRE?=
 =?utf-8?B?cFdndk9QYVBQdVhwVU40QVJBTzllZUozZkxIQllXcjg0NFc5NEM0QUFzWS84?=
 =?utf-8?B?VEpTWFVyZDhmdFBuZE1KZWpTbTQ3cGpyejl0Z09lRk5xQlh5elpmUWJyKzNt?=
 =?utf-8?B?bG9hZW5oWXJJTWxZQlozb1orZ0tkb2tXb2ptOFEyMjQ5Q3plb2NZemJJdXV3?=
 =?utf-8?B?Zy9jdm1aN0JpK2lHUm5pWkJ3cngzRWVzSmFkaXRTemxCYlczc2xnWkdGc3JB?=
 =?utf-8?B?bk8yRUcvMGNNNVd0VXN4cktyc095SzAvcjdITEtUWm5UM3FscU9TYjZVTUxT?=
 =?utf-8?B?cjNZYWEyL2NOdU9HOHpKOXFQQTNvb2VHZ08wM2l2VVRxOWdFa2l1MUdiRTJo?=
 =?utf-8?B?TE1rVzhNS1Y5YndxenJSa1ZpdjZwNXJnZmNHaDk3Z3RpUlFmejZpVDhFeGJu?=
 =?utf-8?B?aHFzUnowWFI3RmxXdVdkeHJvZTA3dmZlNjcrT0hLSGYvMnZ2bGVJbG1Pcno4?=
 =?utf-8?B?bTcycTVORTY5YXVrbjFZZWRmTENiY0NaTVZVTkpGZ0lyZGRvNko4VW9GVW0z?=
 =?utf-8?B?VHcwdXREblRKWmYwY3NlbUVPZm1WRmxaOElsTlZKREJ6NUtiajVETW1FWXRP?=
 =?utf-8?B?bnJYTm1tODcwUVdjWGlrSXNCNHVqcEduMDI2WEFPK0VURlRBSUtwYjNDM2gz?=
 =?utf-8?B?TnNKQ3RHN003RHJnOTFudW5aZG00eVNQVzRQMjAxdldkTDdMZVU3b1lCeVg2?=
 =?utf-8?B?MVZDMUY1cXhtZmxYcXlxcHZGRTNJS1F5c0FuVFFBckZVbnQ2cTBNQURIQ1U1?=
 =?utf-8?B?MDZEbjh0UndhQjk3Vm5TcW9QNVF3cEpQK0VYZkJueDRURDJQL3VkblFvKzNk?=
 =?utf-8?B?RUdmTytPOHdBL04yMnYrQ1BxZE9wajAxNnluOGhvM3pGZU1LN3JHbndzVkpt?=
 =?utf-8?B?ZzZkNElMcHZ4c1Y2M1lTK0JmRCtRNWN1MEN1Y0ZkSHlPMmZiQklYQ1pUMUE4?=
 =?utf-8?B?dHZ3UnZBNy8xV1I1ZWN1cTBjQVNLNUdLVHBoZTdsZDIxS2FRbEdCenZRRG9y?=
 =?utf-8?B?TE91QmRtN3hTRmphbGY3UHpOU1RjaVRoeFVUQVllMncwVEJBeXFWTTJ2T3Er?=
 =?utf-8?B?a05MM2ZYYU5hbkNyS3pzUU45bnptaWxLcFJhZWNwN1ZESnlPQU9PTlRSYUZL?=
 =?utf-8?B?aE9kejcrM3dYUWI3NGk4cGJsRVV1YmxzN1dwbW8vZ214VDJQcXVFN3Y1ZzZl?=
 =?utf-8?B?dStadGRtZHJzUjBCQVFZR1VwZVI1OTlkbjVTRGw5MkJ2dlh4SU5zRGlpVmxn?=
 =?utf-8?B?QU1DOUc3WWNVYzhJN2cxTW1RcitwSFQ3dUExbjZvZER5QVh1Mk5PcE01WTRM?=
 =?utf-8?B?dnE3YUREcFhRSS9FYkxwVjFJeU4zR2NUVldnWGdmM21YNzFPdE43Y1VCS3Y0?=
 =?utf-8?B?Y0lKbk53SXpkaEIxZmxNS1pzR05Zc2hFaVREaUpzeE5NdlpCbWxhZjZ4TUFY?=
 =?utf-8?B?TG8rQnFxUHJ2VGw2eUVFYXZYc0xnSmQ4emhiZU11T1FicGlqVzZLUkEzazlD?=
 =?utf-8?B?UWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: abbc2e1c-1649-426e-56a3-08dcf3ae29fe
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 22:00:53.6038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5pMKo/udHtLUcqoaoV79OEQ3W7npOZvwdZEbTwAPcuTcdhWAZZf/nnbMEPu+ZCBHSCi1I2sux0Ssb0gjdIkpsXWrd2NkxfxKpgCdERRc37s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7287
X-OriginatorOrg: intel.com

Hi James,

On 10/4/24 11:03 AM, James Morse wrote:
> The architecture specific parts of resctrl have helpers to hide accesses
> to the rdt_mon_features bitmap.

hmmmm ... no ... this patch creates those helpers.

> 
> Once the filesystem parts of resctrl are moved, these can no longer live
> in internal.h. Once these are exposed to the wider kernel, they should
> have a 'resctrl_arch_' prefix, to fit the rest of the arch<->fs interface.
> 
> Move and rename the helpers that touch rdt_mon_features directly.
> is_mbm_event() and is_mbm_enabled() are only called from rdtgroup.c,
> so can be moved into that file.

There seems to be a contradiction here ... earlier patch moved the
event IDs to common header so this makes these events shared between
resctrl and all archs. rdt_mon_features bitmap positions are
the common event IDs. Why should rdt_mon_features thus be considered arch
specific if bits that can be set are not?

The patch may be ok if MPAM wants to do something different here but
motivating it as "this is arch specific and needs to be hidden by helpers"
is a stretch since there is nothing arch specific about it.

Reinette

