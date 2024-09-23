Return-Path: <linux-kernel+bounces-335604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 490D097E7FF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 10:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BBC41C213B3
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 08:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E0E194137;
	Mon, 23 Sep 2024 08:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cM23nBol"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCA25F873
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 08:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727081860; cv=fail; b=bH9Xs/2c2LT0FxQGx5euFiASn6a0dS86ONKDHSSvxCZrGY1sSenvPkcisdfA+x5H2LZib6Bzs1uk89uC+jyVIUD5taGeG5Y/8oyGxC5ohLskBmGgK7uvG9FFSbi52Y9gUbIUR8oygjDzgjM+WqRm+bmsk53BMOMDc+la2KXuxZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727081860; c=relaxed/simple;
	bh=3JyttdKqhd3NaqH7/osb4rUKtOV+NgXwZiA0ImGQW8w=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kHxFWaN5iPDWrRl6T1YktRJWfJ3kKInjMPr1EJIEunHbAMHIm1f3ic3BAcRC4/DwtTLT94CX9ApcyjpKJarifeQOJfPOm9ffwRgdIHoFhnf2MABrvtJU5lLLIdCCjYnjwCYOcldMmJURPeISx8Pn8FqP816mlffDb1o7f/AxNQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cM23nBol; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727081856; x=1758617856;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3JyttdKqhd3NaqH7/osb4rUKtOV+NgXwZiA0ImGQW8w=;
  b=cM23nBol2gx0EG+jd476jymDTUR7IXGq6iUkIjeQFR2NFQsAtkhMntYt
   j4X36nCLZTTYgQARWT7qvh+jkXBkC68rjGC+NvPQwbIvdSIfV3xMECbFg
   QxY4vtBMo7KG1J2yh9vUdy4usmFq2l9SYf9GOw8+rXailP8F8w3ZGj/mg
   SO5romne212WkPxXlCswBHS8CceJKEudt800pHRjvw2r4IGsmxPPYHBRC
   KUV8sxTI5UGLf8Dd2I49HIwKmlYZUqXqO2ve1x11gvwn3SDCeoTBhbiUg
   2UwohZs7X08WYin259qkR/53of/lvN9wh57fQP+S5BDZ36y89IInNjbU3
   w==;
X-CSE-ConnectionGUID: h1Wwg52nSxmsxjELf7sVJQ==
X-CSE-MsgGUID: Z9ULmqwySeuSiZXAamaebg==
X-IronPort-AV: E=McAfee;i="6700,10204,11202"; a="26138119"
X-IronPort-AV: E=Sophos;i="6.10,250,1719903600"; 
   d="scan'208";a="26138119"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 01:57:25 -0700
X-CSE-ConnectionGUID: /scE7JJbQ9ar5jWazDFNjA==
X-CSE-MsgGUID: AsE2GH+ZTH6bZgOGiDzS1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,250,1719903600"; 
   d="scan'208";a="70895681"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Sep 2024 01:57:25 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 23 Sep 2024 01:57:24 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 23 Sep 2024 01:57:24 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 23 Sep 2024 01:57:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OA3S774Jk9ETYIqVDJxbGJ56jT+gU5XZRKEUiEk9wGbLcdn404L1XSLePhBlzHma3gMUp5w7CkdEZg0fAxeR40bung7Uvnq8+9vehohwVWat3ZSCo5su07uhu5aBJLZipz0WtKVGdhNN1sTpu8SXnvYYyitF9dRVeqd0yr8Zp01bd2AYIB1kIUjw5Z6v1H5MKWjGuPXaX2gx7+DlsLjGhBjn8jyaLwL4aSBqccRjqhHtb+nWxpxmMwDzfV2vq2hquF4y8QiwoZ+hpXE4xaAiHIm2XWS6t9VZfstmxZzKbge+bCTeVuJy5llZc5M+H/RYD91vIgTISalnRbY6RhRQbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wym2xXNd/Qa1zqA2lW248TSQ9lLckLEVIdlULWXlOuQ=;
 b=lo+AAkKV3Hl6OH7KzBkqKDSNVepB35JNZAjZmvqvhw3hJtA9h4mhEb47zCI7aezhutrmliyVbhXN7qBTmR8c73WRqd0wtZsBBZC2D41PMw6ZHH7Z2pLyJv/p+TAa4ArbfGjirHC+M+CMMcIkMLPpMiea69flxWDsoK9K2NQ4iI+CkzhD1k90imvCFOSC8fvYnovIU21dBtcPhJcHWpY4QJEpOmZpZT1C5c5Ab9MBms9LY8VB9ZQGHUJP2xTHP2ARdAXtniIIWdAow18/fWIijXQLyhzf+HX0B9zR5TPA5zIl3CRB1opM46CWhhRdBQQqoXCsrrv/i7tEBBs16ElrnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by MW5PR11MB5786.namprd11.prod.outlook.com (2603:10b6:303:191::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Mon, 23 Sep
 2024 08:57:15 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.7982.022; Mon, 23 Sep 2024
 08:57:15 +0000
Message-ID: <db2c96f3-c35d-42ee-a4e6-5233ccbac7bb@intel.com>
Date: Mon, 23 Sep 2024 10:57:09 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ice: Unbind the workqueue
To: Frederic Weisbecker <frederic@kernel.org>, Tony Nguyen
	<anthony.l.nguyen@intel.com>
CC: LKML <linux-kernel@vger.kernel.org>, Larysa Zaremba
	<larysa.zaremba@intel.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
References: <20240922222420.18009-1-frederic@kernel.org>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20240922222420.18009-1-frederic@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0032.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::21) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|MW5PR11MB5786:EE_
X-MS-Office365-Filtering-Correlation-Id: 15929a21-4529-4a6c-675c-08dcdbadb881
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bDhBelBFVTZvSVNJZmJsT1piNllxdGd5Z0RObFRsT1NiYTVrdGtwTFRULzZY?=
 =?utf-8?B?UnVQR1F3bC9kNThRTkZST1lQZDEvcnFFbGhBQjQ5czRsRXBWQnA5SlI4MWFO?=
 =?utf-8?B?SmZaYlRuSFJ1bXgwOXQrS2VVVWlhb3g0MTJYcEswZXBJb0JRWlBmRi96VUta?=
 =?utf-8?B?S1h0TlM4ZGtSUEVDNENPQmRlWEJXdG9PWjUrbWRKRU1MSGtVcFF4QitoZlBj?=
 =?utf-8?B?Zi85aU9FQ0UxSnBKVXh5U3hwQS9JdzJ3NmxMUG9BdDdrK2ZRcE4vc0I4anda?=
 =?utf-8?B?V3Bka2VOc0RRSmV4QWYwaS9STzVMSkxQM0piQnBwVW9HQkxaK3dkb0pRNlpi?=
 =?utf-8?B?MFIvWnUwd1hBTHcyTWRTMWZ0bWV5Tkxzb1ZUY2M3bmtlZVdTdHZrUTAvUHpZ?=
 =?utf-8?B?OWNxUitRTzhiVEhXdjBOUkgxTFVtbGg0SUVSS3BGaCtkOGtrQWhlSzJwMXZh?=
 =?utf-8?B?K3VCUFJmRHBOMzJKcnE1SjhyYnlsTzdzSURpeXhraFNmUnZFOHF6WndMYnV2?=
 =?utf-8?B?dXZjRjRwejZuRGhqajk2bGZ6RVg5amd1NW1YYlZkRFBmbE02UlBKSkRkMW0x?=
 =?utf-8?B?OW1rc1djS1NhNjU4Q1c1c0ZNb25rdVdoMnlTNmd6NUptS2kzOThoRGFvT0FK?=
 =?utf-8?B?MjZJWnZma1h4Q0VFb2g5cTlwZkp0Z01xL3J1V0RlcHhxNkhVc3pOMXVXNVdW?=
 =?utf-8?B?dlNvek03SlhzM1ZJcWx2ZU9JYUNMQ1A0OUNqQUplWnZoVW5SOWJNTWw1QkJz?=
 =?utf-8?B?VTRtdzhkOEx2ODJJU2NIUlNhZE1FWmEwSGpSMWYxNWtXYjJNaDJoNCt5bjVY?=
 =?utf-8?B?Nk4yZUJmWVdsaDJOR0lNZkRxVXZUd0xOdVlNaUYrdDAzeFJwb1BmTC9ob2JQ?=
 =?utf-8?B?MkpsODBwblhQN2U2WEV2Y1M2ZXRoTW1mS3V2VG1uNFZzeFkzcEsyMjJ4azBS?=
 =?utf-8?B?ZEg1K3dDb1pZVGJMOFRUZHRvMGVERDRDN0IrUCtjelZ0bzF2UlIzdTN1UUJD?=
 =?utf-8?B?RmM0NUhabVV0eTFhNXhrMldUNjlnZkRVK29yRlovQW1nS3o0YzAxeU5heHFQ?=
 =?utf-8?B?RktJTEdrd3hGVmovaHFUUUsyUnlYbFozM2pxT2o3OUdqSzI1Z0JHTFB1b2VH?=
 =?utf-8?B?ZEEyQ29qWG1BcVZzV2NxQ2VuZVNnSEtHcXd5WU5tTG9CSkpuKzFrVjFMdy9H?=
 =?utf-8?B?VWtkNkNOcXF2ZWhSR012b3Z5TFFicVFJaG05WGorYmg0R1hPWWpsbEJiTVhp?=
 =?utf-8?B?dFVucEEyYlRobk00eFR2dENRQjVLaEpVSUtWcDhOd01vOEE5NFJONUtNUkhF?=
 =?utf-8?B?Ymk3YVZEam5DMGlTeUhyUjBkUUtvMzJycDNqcFU1N25zVER6Nlh5OXZ2NXFr?=
 =?utf-8?B?Vnl5MnEyQ3RLRWtuT0g1bC83aE1Dd05LOWlLTkpDcVVYVWdsbHMwcHEzOXhF?=
 =?utf-8?B?Y3d4SDErQXYrcEpYdG0wZFdta0xxVW1MN1VBaFU3Y2tuVk5tU3c2b3ROT2RR?=
 =?utf-8?B?UWN1bmphZHluNlFPaDRBOVpsWTFpd0RqVTdvTmJTSXhOMTJ4VnlxMXErbFhG?=
 =?utf-8?B?MjdiczJrcVdsb2Rjek1pSGZYWE5vOEF4V2FxeTk4YUoxTEpZcWlFUnp1eUdE?=
 =?utf-8?B?UmJLTHRDTkVudW4xYkFIbkRXUUpURWhOeXdNNHFhd0JJZlVxSWdYaGhZOEhm?=
 =?utf-8?B?Z25GTk5hMWNaR0oxM1RFQjdtZ3VLRkF6SVRsWHBDcjZQM3l1RDZ0WFlRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SlNITDVYZjFIWGE0WGpra1Q0aEVHYVZGSUtTV0pzeGtLZVRpRzg2Vm52UkZY?=
 =?utf-8?B?bTJxdlAvSkFvTTVzSlpRUENUT1IzUlpvWkRiZUFqRExGVWxmbXVGcVRYellD?=
 =?utf-8?B?R2JNWnEzZm5zY2ZsTmdqRFhnei91Y2w1cWc2emdnL29qTlptbnJocytKc291?=
 =?utf-8?B?dVUvZ3BES1pzdzBlOHVBNENxVWNYc09RU0x4R0ErQUxqOGNwTUNKZk1naHRQ?=
 =?utf-8?B?Z1pyQVF5ejlzMFVjWWJsdkcxYTB2US90NjZIRnR2RHhrSzVWUXBDVFdaS1Mr?=
 =?utf-8?B?NDlvUXZTV3V6N3NDTWFXU2FPaWd2alIvNW1wQzd3c1MzVmduSzlpSG5HNTJX?=
 =?utf-8?B?c1RvbFkzRUVGNldRR0FkbjRpZFQxMS8zUEJtQWxnc3NnYWJsb2JhUnk4cVhX?=
 =?utf-8?B?WXpTMW92YUozNXRjU00rN3lSVmp6bU8zdjVGakhFY2xwMGF1WENDVm1rV0Ni?=
 =?utf-8?B?VHk5RjFzbXdhQzhkSDk4K3RFM2RVMGVqSzY1SWJodWp0VWpQMFZ4SWFlYytu?=
 =?utf-8?B?b1dyRXgzdWRqQzJJd3hTT05zWkhOaDU4NTJlcThMN1p0dkp2WDd2bGRFZWhV?=
 =?utf-8?B?U3k4N0d0S3kxUDlZOVdMRlpNaFUzQmJnZmFmeUh1Y0JqczRjL1BjZmV5VWdl?=
 =?utf-8?B?WXFXV0x1RlpNODcwa1FZOXk2VnpHQjRjeExMdXRxakVTVVlORVFoSUNpaTlH?=
 =?utf-8?B?Q1FSdis5a2tzTW5hclRER25QNHdReFdmSFZ2TG9BUFRiekVvT1hiclBRMjVZ?=
 =?utf-8?B?TFVYNVc0bmRMM256S09GTnlGRWZCMVRWWjV3Rko3eUkyMnJmaGk4OWRMRkdS?=
 =?utf-8?B?UGNMZm91UklTVkwreVROTS9DTGtoeXRBSVlEM1FFWnpEK2NjRFY5alVlQXht?=
 =?utf-8?B?ekw4SVdaZDU1b0tEeHc3RFBVYWtGOFNoQW9iZStYNGk2UDk3c2huT1VDdHdR?=
 =?utf-8?B?TmJPaXhYWDBrOU9jc3REL0xISWdkN0hKUWFNNEVVakgwOWQ4bXBtYnNEek83?=
 =?utf-8?B?NEJrVUhGczIyTXN2c3Z4Qzdtc3ZFaDkwdmpCTVN4TnhEeGtjOFhKbzJMdnMx?=
 =?utf-8?B?VGhrc2pNeHlvWHpCWGE1TFcvRDZKTzdOUS9RU3lXellDNjNtZHZwMk9pSSsv?=
 =?utf-8?B?bml5bTBmdk8zTlI5Wmh6L0liU1p0VEtrQzE1NElxU3NQdjZuZzBXaGc2TWlJ?=
 =?utf-8?B?SDlQTHVid3lwZEludEZLSVZXekgrazBkdUgxTlJBRUFDR1Y1TklVb0l5a2xp?=
 =?utf-8?B?UXZRZmlyUWhGODY2L25rakxCVmF4VVpKK1M1M1VmaTBWQVhlVGF2OHUzUGhv?=
 =?utf-8?B?Vlgwd3FBNmh4U05ZUnl0c1NXSVlLbXVFUlhIMlJNN2pERWtqNEpuclBJd1p2?=
 =?utf-8?B?cmdNY2tmSFMyMkYyRjJnTEhtM0l4WDRhbjlSWnFDbTIxUVcxSlFyVXVZUy9r?=
 =?utf-8?B?WWdlSlNuS2g2V3J4Q3ltVkNxYWdRNDVzYjNNb3RxRU9tZFBjTFVLaVNtd1JJ?=
 =?utf-8?B?WVExK1lEbU9sa2VWSWpGb3dQU3hKRlBRUmF4b0lDZllqOFJGaGNwRDBHSk15?=
 =?utf-8?B?Z1c3dlEwUzN5K2tDQmZUWEJBeFhNN2c0NFBJODFXZDVLUm1CcVZOQjRSWWpn?=
 =?utf-8?B?aTBtbEh1Q0J4dlNFMkJPUmxkbkNTNk1PaGVCamNUNzU2ZFZOemxFMnMycDlz?=
 =?utf-8?B?V2dhWm1RdnBoL3o3NkJZdmNRNG9Hc280MFI5a0xZVENuMEM2SjM0d1hwcG8v?=
 =?utf-8?B?bkhyQW44S0pDdFBPQUI4bHo1eFNSR3Z5dnRncXM0V0dNUFBiT2NYM0FXOG83?=
 =?utf-8?B?dUM3R1RRM3R4SVFQbjl0NFZlQ3VwNkRBWjJzNUFRWVZsQnNjNTk3dnY4UXhV?=
 =?utf-8?B?cWVnMEhkSGdlQ3hoTUFFRGp2VVJPVVR5NnV2aU9abkhrdXVjT21GbERKSkla?=
 =?utf-8?B?NUxCMzN3R1RCNXRWUUpOZzBxWSt1WUx6MElqOTdqa1pkR2NidEo3VU84NXQr?=
 =?utf-8?B?NWlnOWQ3aDdZaWxZMk9wV09qemppVE9KVUxjUnp5L2N6aWtSQ0xrdjBPWWg5?=
 =?utf-8?B?Z045QTZ4dWh6a0hUL0xXaUhQYmtwL2FXR3czdWxFQnZ0TWxoQkI4S3VxQmRV?=
 =?utf-8?B?T2xVbGplREtUTERCRi9DekZmOGNlaU5mRDFrbFFvTER0NXQrTm8vWFR5SFR0?=
 =?utf-8?B?Ync9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 15929a21-4529-4a6c-675c-08dcdbadb881
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 08:57:15.2935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Suv0boeKou4sFnsbA9lgo/sMHg4xJeEjeUXbPmKBOhu0cdBF0imZZybgTIz319zXmf2wuGfnmm7A4FOIW1X6PJdRL2nPCxlpKne5x8uSX7Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5786
X-OriginatorOrg: intel.com

On 9/23/24 00:24, Frederic Weisbecker wrote:
> The ice workqueue doesn't seem to rely on any CPU locality and should
> therefore be able to run on any CPU. In practice this is already
> happening through the unbound ice_service_timer that may fire anywhere
> and queue the workqueue accordingly to any CPU.
> 
> Make this official so that the ice workqueue is only ever queued to
> housekeeping CPUs on nohz_full.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>   drivers/net/ethernet/intel/ice/ice_main.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index ea780d468579..70990f42ac05 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -5924,7 +5924,7 @@ static int __init ice_module_init(void)
>   
>   	ice_adv_lnk_speed_maps_init();
>   
> -	ice_wq = alloc_workqueue("%s", 0, 0, KBUILD_MODNAME);
> +	ice_wq = alloc_workqueue("%s", WQ_UNBOUND, 0, KBUILD_MODNAME);
>   	if (!ice_wq) {
>   		pr_err("Failed to create workqueue\n");
>   		return status;

Thank you for the patch, it would make sense for our iwl-next tree,
with such assumption:
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

@Tony, do you want it resent with target tree in the subject?

