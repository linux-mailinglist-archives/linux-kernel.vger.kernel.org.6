Return-Path: <linux-kernel+bounces-331157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC6D97A93E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 00:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A4D328688D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 22:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83F114BF92;
	Mon, 16 Sep 2024 22:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O45jYrAg"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635814965B
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 22:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726526017; cv=fail; b=svf9i34NfBMew/HOnFP2rZypwPTlftBDYWGIw+cNC4bhKGohs+R2mzvABbSt8EcpeCdRisGhOnFKTUrxSGrNnxb29T6O5zJjBKqgwCH62gkJDUAI4heO7Y5A99PSE5RQzwThU8tSI6l+5kAofa9LJ9uAVA5rGoG3mpccNgypSsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726526017; c=relaxed/simple;
	bh=9gZ/DjTR611uWkY+YK3P1gILVseIC7m38I+gyaAUyoc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DiS6C0mVrmoB7a+lV0qi8oGrJzLJgCm9uNsZeUzvhFfRS02mjiWQ8rFN4pUkzLGVgNCv62ApkP+XF4Bhq+bQt9dIzM2BNz8G/KMh3xm+0xUWUHBbTIhdbMnXulGhAVMuolvNlcK46jgDl6OCBoGCpRkxqsDfLrvwPf214Rx/Rjs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O45jYrAg; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726526015; x=1758062015;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9gZ/DjTR611uWkY+YK3P1gILVseIC7m38I+gyaAUyoc=;
  b=O45jYrAg2Q5YmIcY1/zsGsJ/09SbxJk4Xupq/kP+jnQ7y3QN3nUWUYjX
   1GDoqDxLoOP+SSSv6u/Ech7SLOPDrm1SqdsAqKSRCjZaMURiKSvHSBSf0
   fM/uCgnqwVWQr3DJYcQkHY1i2AUiGkR2E3mRZq03tNPZkUo+nTCTXWq8Y
   aM+OxbGWi1H9z9uIx+B0mTwMLFwafZms9v28gGy4yNBzfqzHl7pgN9/cc
   KMxuy8CNPEnYxpvVrxqFRO4B6ZVuMpP4WH1RAeF3hb9E6xQpLfWx7EENC
   U9MWcWl2ivAqWbWRgOfVF3QUiKo2ziFNI7BXr7dcG3PVGV0Z0uh2CIp8b
   Q==;
X-CSE-ConnectionGUID: wUI8+4meTluYQrB+Y1j5mg==
X-CSE-MsgGUID: rEnqrJdITe6TIgVPMj6RQA==
X-IronPort-AV: E=McAfee;i="6700,10204,11197"; a="25526232"
X-IronPort-AV: E=Sophos;i="6.10,233,1719903600"; 
   d="scan'208";a="25526232"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2024 15:33:34 -0700
X-CSE-ConnectionGUID: w41QMkB4ScCvbbe1W8APyA==
X-CSE-MsgGUID: +8dOVwKjTgitjZ6DdKCHuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,233,1719903600"; 
   d="scan'208";a="99851886"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Sep 2024 15:33:34 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 16 Sep 2024 15:33:33 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 16 Sep 2024 15:33:33 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 16 Sep 2024 15:33:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yXz5smETzT7wbS1vdon+xg1ks4uFcTn8UN8iJFVPAjoDeQD+NsLb9fZ2F/Y1Sl5eNSAWbyOnP9hazO8KCv1EmAfJuF+NQsFPUeM+lv8l9vdOaIsObq4n3yEw2DUyR9QwmN1w2Al2eWgRKLp47JDKcv07iDdjhzITC14dufobWRHNnmY7nqK63THAcfYrkCHs7nEJjTaik+rTOvxPldUncoQZCHqQtUmz7COIsE7gUUoYGSEQMZ3hC0jzr+fuAgeXZxd43IkXL5EL+eH1nIT0VyZrg7wIhrR6ocdLesHHFhibxYM10Zk5+xyiUc2FO2TZMFry4wrDgzPsoXIurKP9Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1jCj0ZiCWLd3qOsjjc2f4Qw0j7XZA/X/YHEqWMZP758=;
 b=jbZcAowlqKxPCnZOM+F4MP//z5GCLL+013PQiMBRxvSmk/THFMK3A1+kYR4UESMIVXea5gi7cNKpMAEvC7+1Laa2OnGB6CHT0c8YKnnhV73U2bRBcmNzxhuivOnqIyO9RycYhzf/Z+dy4VKpu3qZElWpfZqN1IZdsfnooIOyNf8LmLdD97tPsnLTAdgUhg7YkOwiIwiaKtrRpdO+LlqT/9iDqs75WJOGFnNm93qiw8vgQtVUPEzA1qa+xS/BgD/o7yOGTlca+hE0cqkzxnmqi0lGyVvj8bqAdNlvHvlOAZVQz2ZxuYJXfzHDurK9+zVVYxJ4vZxws7rJgOhtbMGq/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA0PR11MB4623.namprd11.prod.outlook.com (2603:10b6:806:95::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Mon, 16 Sep
 2024 22:33:31 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7962.022; Mon, 16 Sep 2024
 22:33:30 +0000
Message-ID: <6941deab-0bec-41e1-975b-274fc9d6b8e1@intel.com>
Date: Mon, 16 Sep 2024 15:33:27 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/39] x86/resctrl: Use schema type to determine how to
 parse schema values
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
	"Dave Martin" <dave.martin@arm.com>
References: <20240802172853.22529-1-james.morse@arm.com>
 <20240802172853.22529-5-james.morse@arm.com>
 <5eea2e6a-f062-4ff4-9d11-87d8af0306dd@intel.com>
 <4a1da47f-655a-4ba1-9b68-baaad297dda9@arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <4a1da47f-655a-4ba1-9b68-baaad297dda9@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0115.namprd03.prod.outlook.com
 (2603:10b6:303:b7::30) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA0PR11MB4623:EE_
X-MS-Office365-Filtering-Correlation-Id: eb97c2a4-0b97-407e-db28-08dcd69f972a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OTlyamh4azdQbVNHbUo0dzBVVVpibVZDcUZSaFdwMkdZRjcrc25SaWU4YXJN?=
 =?utf-8?B?NlBwbmY4VCsxWERvak83OEtybzdUYWRvMlFQUVdPZUcxVVovL0w4MGNxU0ZE?=
 =?utf-8?B?MDJIelJlVlV4S0FTTGc2dW1DUnM1bUlSejRFQllTRUtmVUxjd01nR2hwUWRV?=
 =?utf-8?B?R3NtQkNheHRyYjRva3M5M0dpTEtPWHMvdG95YXl1YXBtMHp1cHFkak5HMHJG?=
 =?utf-8?B?a1lOWkVKU0FjNmdvU3hLem5kMi82WWg1K25QT3cyN3d6R3JIc3lSRHVYYWtX?=
 =?utf-8?B?a2tIWU9WelBZOHhiYmUvWjNkQWZlaXpOU1Nob3BPT3E5VVJhVlE4a1RQeWpD?=
 =?utf-8?B?NmVrNWRVNUZoRXRWUEtpS3R1a0htQzdYTmNOZStOTHJMMTVndytITysvU0tF?=
 =?utf-8?B?bmhtdklCZ3U4UDIzRk1oaGVMM3FyaTFpMkEwOGVzcmYvc3hVVHRPdFZPdVl1?=
 =?utf-8?B?R2o2NmRTdE41UENrM254M056c2FiN2RqV2REc1ZQUDRPL3NKSmlmNnpwQTdk?=
 =?utf-8?B?eU00am50VTJKOWcrcXhCU3A1WFVURFpJbEd5K2NZUVlVTE5uV003QlVmM3A4?=
 =?utf-8?B?M2ZwT09YWlZySTZhN0hnWDlHQ054czZzR2laRGlyWFJKOXBJOGdqdlVHejhs?=
 =?utf-8?B?SGczZWpxUjdsWGVkV0NwOTk1aUc5NFFSM2ZwTUFSdS9pWk1oWDRDL04wYk1k?=
 =?utf-8?B?UHE1N2tBaGp0Vng4OExBa3NXTXo2c2NRUzZVUXBzYTZMU0tsUktJU2lnNXZD?=
 =?utf-8?B?WWdrTkl4aTBFZEg4MW5id04vdGk3VjZzbEtWQ0RaOWZlN3pUZVUvSUxWQ0kw?=
 =?utf-8?B?dE4ycy90aXNkZ3hlSGM2K3cyY0VjN3BSZS9zeEJvUDhXMU9aY0xUR044RUFO?=
 =?utf-8?B?MHZlVW9oTEsvS2FTWnkyRFNjWU1ZVzA1aUlQaVl2MEJTa2NoWFkwRkdYQkd3?=
 =?utf-8?B?N1grN1Y0SUJSOUVsY1dkMXhaVWJmbk9GZ1pFOTM3blV4Nk5pSmR4VlRjQWlM?=
 =?utf-8?B?Tjd6TFoxaURCQllvSVA2KzkwVi82M0E2YTFPK3EzT2VVQnlETzVDZWVxL25a?=
 =?utf-8?B?cGNtMEpoa0lRcmhmMERMU0IwOURzVk5sT2I5dkVFdXF4TU1oV2lFa2tOTkxu?=
 =?utf-8?B?b2tmNGYyRExiSEFVUVdpZ0k2L2UzcERiMDhuZC9XazMrQ2xCVjBRNjh5YUZz?=
 =?utf-8?B?ZjVWY1I4U2FlTlZuUVlOT2FSMzJNVk9XTWZ0cml0QlVDeGY1UVIvdndXQUpt?=
 =?utf-8?B?bHJwT3YzNHNuSDhHbHEyQy9qcUViZ3MyQmdMU0xLUVBoc2NpaDFpQVAxcGRT?=
 =?utf-8?B?VU5rd29OTi9FRTZIdC9takFlclZlNW12UDNkYUtmaWI0RVVLL1ZoM1BNV1Ja?=
 =?utf-8?B?U1lpQi9VZDlxSG9lMnJ6UFluMFVjZDZSN05sYUFsOHpvUlk2K1gvem9zZEtu?=
 =?utf-8?B?YWgrc2ZQT1BTZlBrRXZabkxmdUFXZzZMSTJYQ0swNFJXMkRGVENPTE0zRVBr?=
 =?utf-8?B?Tnd2UVBBTWF6R202S2I5QlFFTmR2eSsxVDNLM1BDQWhsSDVBMU1rSnhSUWk2?=
 =?utf-8?B?ZjdkZmY1WlJVVjNDemJkQmVjSXQycVBIUmFWUnJUeTA0UHh1aXppSTlEUmNy?=
 =?utf-8?B?anFXZnA2Y3JwTktYZXJudXBHQ1Z3c1pZc1hBdVQvdS9IVHlrVXhhQjRVRks3?=
 =?utf-8?B?NkxsU0RBWE5jckZ1VVU5djgxQXRobm5jZVBEOXdTajNLWU40c1hjL2ZXNVRa?=
 =?utf-8?B?UmYrVHprNWRQVnpCL1F5SlIrNkEvY2RtOGh6c3RQYzdidXIvMFFWa29nVEVS?=
 =?utf-8?B?NXBpczk1czFBNDg4OU5UUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWZYKzFRYmdYS0lqZDBkM1R5ckRrS1BSK3I1NU1Kc0ZHZFo4VUttRk4ySnI4?=
 =?utf-8?B?U1ZXM29XWUV5NW1JL2FpZ3RoVFltSHZnQVAyTm5xVE9jZExuNlJvQ0lEaERF?=
 =?utf-8?B?aVJjZDVwUlI0R3VrT1BpUEtrWml4d0trTW1lZ04vUi80cnQ0eXdaUXRtbFQx?=
 =?utf-8?B?VTJldDErSDZQSVpIQWtrUUJLN3M0WE5OY3lNNm54Yk9mK1dtVVdjYmtMUHY1?=
 =?utf-8?B?OWY0cEdycTBrMnpKL2Y2aXVhU0dOOGlORWZmUDM2OWZLR3JqbjRyOEQ4Wnl3?=
 =?utf-8?B?d0o0YXVFZjloVmJEUGEwSW5ua2paUXNBRkZsYW1mU09EZlhxNjdhTUhkTHdy?=
 =?utf-8?B?bzkxeEVPbmRQbmMzM3RvUjdoYklPTXNsb3dWMm9nd1BhcUxyWW5iNFV0VWFi?=
 =?utf-8?B?VHNYajRTZ1RsdGZlVVExVG1EcnJYZnA4RHRDeEZsUG91eGlPWEFDVCtSOGND?=
 =?utf-8?B?R2Z0cFBZTWh2azlWSTBRU2FzQjJyek9Xc1JqMWlDMEVhR3d1MUt5NHFsS3pD?=
 =?utf-8?B?dTNVckZGZzlBTXR1ZVU0K2NSeEEyNldDMmFlVVpnaU4ydW1MaVE1ZDFTMGdY?=
 =?utf-8?B?TVRleDdLdGRtKy9QZjh2ZTZtblRUNHo1WlRIeHg3OHR3amxNZDJXUlFkSEE2?=
 =?utf-8?B?MnRBakp6aitQZVVKd2xCMzQ5L2YzY2JWUlF6Y28zOXg1dkNveFc2UUZnaGtE?=
 =?utf-8?B?dWU2cWt1cG9VWm00Rm1IcU43c24wUnhEQXFUdWVkMzhOZ1JsU3BEYmxSek83?=
 =?utf-8?B?VjRKY1J1VGhweHg2eFJsemZXeXZ1aG9qWmlmNFY1NUViOWxzeFNyNzh6SmhF?=
 =?utf-8?B?ck42YXlPbGU3cG9tVFVpeloycHFlUnhRM0Z3WlZBV2VraHNLbXl2TVYzQnB2?=
 =?utf-8?B?RW9Ba3BFTkZid2ZnS1pUUXBXTVpTblZsKzhSRC9BekZqVUM3LzFSTTRVLzc1?=
 =?utf-8?B?QWhsZ3NlbTlvcFRKdWM2aWRrOTR4Zm13MGZxaTdTclZxbHc4Q3VyUzhuTXZt?=
 =?utf-8?B?cFl5WDZOcDIvd0ZlZngyaHhsNVJUNHhRK0szWVpsVWYwNkNZbU9iYmMyeldS?=
 =?utf-8?B?WUpSZzlMSDc1eG8wNjBqR1VSM2tzT0QwdlM0d0t3b1c3WTNLaldheVQwTENn?=
 =?utf-8?B?ZEFoa2o3dERwWG1iV0xYbjFWYW4vd2Z0VlE5Vy93NFJOd3VudmZmVDB5WkND?=
 =?utf-8?B?U0g2Z2w4ei84Q2pmV293Ty8xNFMwY214TGdwRXFxYWErYjlzZkMyMzRQNktZ?=
 =?utf-8?B?N0s5MFlMNXJaMnNZNWhzUkI5emNrNHdMa1pBZGlXbFNDTjh3K0t1dWJnc3I4?=
 =?utf-8?B?elE5SWYzMnJmR3FpUkJiS3dpVGpjUmhpbVVoTTV5SUJUVHQ4V21meFhTdWJu?=
 =?utf-8?B?eDhoQWZSUExGN3ErSnp2amhSVDdWYW4vNmpXekxNTHZLK2lTVTJQc3VqaW1I?=
 =?utf-8?B?aTVGbm1iMXBHUytSUGp6WnRLZVdBaSs2bXhBSHV4eEt4dEdCZlB3ekJwNmty?=
 =?utf-8?B?OUJ3K0wva1RPUGYyajVhWFpqRUNNUXpUR0FaYVRnOTViSzA2VWlhWXYzZnEx?=
 =?utf-8?B?cWttcEozbU9XNTYvMktkZlJvSUMwdUhFdE4yWEk5Tmt6Z3BRWE90bE5uVU1Z?=
 =?utf-8?B?Z0djUTlwa21IMGs1WWR6cXVvOWo5NmRVdklVeVd5QXhlSjQxdEJZNThYVE1p?=
 =?utf-8?B?MXRvdnZOZkdiR1czUnMxSDRLVTA1SmJqblplTXdtdzlHNW1PY3BuazMyVUJk?=
 =?utf-8?B?NTM0SG5mSU1LUkxhUXAzNTVoNy9oQ1BnZ0hURnVmaURMUndGVU9KMkJFMHFt?=
 =?utf-8?B?cmdtVkNVeVlOUlBBeG91Q3ZhYmhHM0Z4cm5hWlNQQXJ3MmpjbmtvdXBPVTNl?=
 =?utf-8?B?TUVyRXNVTVlxaFhlQWx0VFB6L0tBQ3I4b1ArSnRsMTdsblUxdDg5SC9hNnZ0?=
 =?utf-8?B?VGdpRmR1SlNNYzNzUFJrK3k0WlU4eFVaZVJSR1pLT1pSTDgvR0FEOTNkaHJ2?=
 =?utf-8?B?aTZhUEtCU0NNNjVEbkJUa0d1QjhUdjhicGxCS25RUWtGVmJzd1dxQzJsSE13?=
 =?utf-8?B?VlUyVFlGZmpmNFdEZW5XMTd2T1o1alR0Wk95cExxd2J6YnIxZVJidW1sZ2dO?=
 =?utf-8?B?TlNzOEE2T1F5Y3RWRXA5VnZiSEhTQ0xuVmdTMzByZHVwbDZMQmQ5UzE5SWIz?=
 =?utf-8?B?M2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eb97c2a4-0b97-407e-db28-08dcd69f972a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 22:33:30.5025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cdg3rxIilZGJPkEbcLztwirauCSEG5Zn2r/CRa080fI8Jn1FrMpEL8J3bdiD4yfUxD3JQTslG91QDl7kXOBvMjQNFDJM5MszhomwSLBG8CI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4623
X-OriginatorOrg: intel.com

Hi James,

On 9/6/24 11:06 AM, James Morse wrote:
> Hi Reinette,
> 
> On 14/08/2024 04:56, Reinette Chatre wrote:
>> On 8/2/24 10:28 AM, James Morse wrote:
>>> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
>>> index 9ca542a8e2d4..57c88e1c2adf 100644
>>> --- a/arch/x86/kernel/cpu/resctrl/core.c
>>> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> 
>>> @@ -192,6 +191,18 @@ enum resctrl_scope {
>>>        RESCTRL_L3_NODE,
>>>    };
>>>    +/**
>>> + * enum resctrl_schema_fmt - The format user-space provides for a schema.
>>> + * @RESCTRL_SCHEMA_BITMAP:    The schema is a bitmap in hex.
>>> + * @RESCTRL_SCHEMA_PERCENTAGE:    The schema is a decimal percentage value.
>>> + * @RESCTRL_SCHEMA_MBPS:    The schema is a decimal MBps value.
>>> + */
>>> +enum resctrl_schema_fmt {
>>> +    RESCTRL_SCHEMA_BITMAP,
>>> +    RESCTRL_SCHEMA_PERCENTAGE,
>>> +    RESCTRL_SCHEMA_MBPS,
>>> +};
>>> +
>>
>> I believe that the choice of RESCTRL_SCHEMA_PERCENTAGE and RESCTRL_SCHEMA_MBPS has
>> potential for significant confusion. The closest place to where user space can enter
>> a MBps value (which is actually MiBps) is on Intel when resctrl is mounted with mba_MBps,
>> and as per above it will have the "RESCTRL_SCHEMA_PERCENTAGE" format.
> 
> It was AMD's QOS that I was thinking of. To pick the example from the documentation:
> | For example, to allocate 2GB/s limit on the first cache id:
> |    MB:0=2048;1=2048;2=2048;3=2048
> 
> How does user-space know that its not a percentage? Suck it and see...
> If those values aren't in MB/s ... I'm not sure what they are.

I agree that this is an issue.

> 
> 
> The schema format isn't exposed to user-space. (I think we should do that).
> I agree if it were, we'd need to report MBps/MiBps for the mba_sc case.

I agree that it would be ideal to expose the schema format to user space.

>> What is considered
>> here as RESCTRL_SCHEMA_MBPS also cannot really be considered as "MBPS" since it is used to
>> cover AMD's values that are "multiples of one eighth GB/s". Any new resource that
>> _actually_ uses MBPS will thus not be able to use RESCTRL_SCHEMA_MBPS.
> 
> Isn't this already covered by the granularity?
> AMD platforms are unfortunately reporting '1' as the granularity.
>  From the 1/8th GB/s it sounds like the granularity should really be 128 MB/s.

Unfortunately the existing interface makes consistent use of granularity (by user
space) difficult.

As the doc highlights:
	"bandwidth_gran":
		...
		available bandwidth control steps are
		min_bandwidth + N * bandwidth_gran.


You are correct that setting AMD's granularity to 128 MB/s would make the expected
bandwidth clear to user space. The problem is that the existing schemata displays to
user space and expects from user space the value of "N" for MB on AMD while it
displays to user space and expects from user space the value of "min_bandwidth + N *
bandwidth_gran" from user space for MB on Intel.

> 
> Any platform that did have a real MB/s control could report whatever granularity it really
> has here.
> 
> 
>> Considering that RESCTRL_SCHEMA_PERCENTAGE and RESCTRL_SCHEMA_MBPS use the same parser,
>> could "RESCTRL_SCHEMA_RANGE" be more fitting? I acknowledge that it is very generic and
>> better
>> ideas are welcome. A "range" does seem to be appropriate considering the later patch
>> (x86/resctrl:
> 
>> Add max_bw to struct resctrl_membw) that codes an explicit max.
> 
> Yes because the AMD platforms have a firmware-advertised maximum value, I presume that is
> an achievable bandwidth. (otherwise why advertise it to user-space!).
> (I'm not sure why data_width is 4 - it looks like that was the hard coded based on one
>   platforms limit ... that probably needs fixing too)
> 
> But if you had a MBps control, I'm not sure that implies you know what the maximum
> achievable bandwidth is. The control may have a range based on some power of two, which is
> unrelated to the bandwidth.

I believe that is the current resctrl mechanism, with the huge caveat that the only
implementation is actually software defined range limit.

> In the arm world the hardware never knows what the achievable bandwidth is - that is
> something only the SoC designer can work out.
> 
> 
> I agree we can parse both values as a range, as resctrl doesn't need to interpret the
> values, its just whatever the hardware does.
> 
> I did it like this as I'd like to expose "percentage/MBps/bitmap" to user-space so that
> control types user-space doesn't recognised can be programmed. If arm64 and riscv each
> want to add new schema types, it would be good to do it in a way that is low-impact for
> the resctrl filesystem code, and unaware user-space can do something with.
> percentage/MBps/bitmap are the control schemes we already have.

Adding bitmap will need more thought, since resctrl does not support that today for
MB there is some flexibility when adding support for it.

> 
> The MBps/range difference matters if the 'maximum bandwidth' isn't actually an achievable
> number e.g. ~0, then user-space can't treat it as some kind of percentage.

This last statement is not clear to me. It sounds as though you are considering the
underlying implementation treating provided bandwidth as percentage as opposed to
the interface itself being bandwidth or percentage? hmmm ... or are you referring to
the software controller?

I wonder if bandwidth and percentage can continue using the same interface as today
by using bandwidth_gran as you hinted to ... but with the backward compatibility of
needing to distinguish between schemata interface expecting the total or the steps.
I do not know what (if any) impact there will be if AMD's bandwidth_gran is
changed to 128 MB/s.

Reinette

