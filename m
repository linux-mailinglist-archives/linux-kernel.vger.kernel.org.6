Return-Path: <linux-kernel+bounces-513955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77615A350B3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 22:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AA7118873BF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 21:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C48226981D;
	Thu, 13 Feb 2025 21:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D964YCYc"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CC2266B7E
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 21:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739483432; cv=fail; b=MH+FaU1Rk+PwcyyQwClC6jUKzzOCxIal1pnTo+X3ElIy6eM71lNsIKVGRnHDFUud2CTza3NXuuSslLGaz3sMPpBd/t2uehiIMKKCy44BMbVAfzgvl/p4x0cOV+wwG0IP7wQGK6AQyLG9654YaAvjUBfE7/4+ofNiVoMFrTt6xxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739483432; c=relaxed/simple;
	bh=c5Y4qEZQEEbcfbZYcSxBFQgrH+RkqRprNjTnNCSeN3Y=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Wnfmj2iU6ytUsqVrHREKKuaoFTWelP98n4v9QOeRNJWbxGCQD1f85wUVLhM8MnVobJxyCboaAkrx2ZmgXB5BAEZ5fEQdDs4Qk3jMBgM3o4MDPT+ESgP2i1G+WVc4ANdBFOyYriyHSWP04MquFXIzdDINxhmkYQBx9tGvwqzYwEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D964YCYc; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739483431; x=1771019431;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=c5Y4qEZQEEbcfbZYcSxBFQgrH+RkqRprNjTnNCSeN3Y=;
  b=D964YCYcQ1P9u4bQzWPYMhSLzNrfrnlIkjmmdmXRv1EOn/WHGRHzVeiG
   aAvgyEwBv5g4wCc847kBXGK8Sf2mwajKgMWV9sQCtYIqQiMXzDgLf0Vhy
   t+os8SFF5oQRlIpYJZnk8d5fb+wqWN7lrSL0mtu+ePgAFiq+RHljFFUuk
   UNlgMcNZavGg/9or34B/fwJLn5YHQNWjPQI2bWQqS4zqe0nB1k1X4qNLm
   +No1nx7Nq3fJwd8IQXaRJuu6r2ZbMf9GjyaKVuhtpLiJLv1GOmJ03QFZU
   0XQGyDp6KJ8nJi+8TQMHM1MVKCI0gZJANZ328yShMhV2Y6dHiVZt3hdgm
   w==;
X-CSE-ConnectionGUID: plofoS18RAKhN8AG1WxbHg==
X-CSE-MsgGUID: pPbVQS1aTe2f4ovmfprepw==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="43867932"
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="43867932"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 13:50:31 -0800
X-CSE-ConnectionGUID: gfCBOMkMTASJ3tDSrLV4qw==
X-CSE-MsgGUID: yPkjqpPxRv+nKIYQhKjr9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="113448343"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Feb 2025 13:50:30 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 13 Feb 2025 13:50:29 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 13 Feb 2025 13:50:29 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 13 Feb 2025 13:50:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=alRrcFymXSg08mt9Dl6riFuL6iV/rey1hTH3OgD4XM2OYZihYU2WWj84J31v9y5E4s6PuMYf5GUNDcI3le4uhviqffSidpKWOG2+PZmqA9fELGZsLavUIplB9waWnmKWOIqk5Fl6I1F9Cgrvl0mBMcaDRatp9KbfAbRBa07Ro4a5iyzsiGe+Wu4BsR2ZbO5qqHudjKUPEWNGqctTACuVbadRWWOQ85onJ2dTfQd9EicZaDZ12xXjhZYytr4BQph4HyKqwVF5jtFO+ZmU2dphiq2xClWKyUNyphGSlissaZYyfdyuvAfNNugY/BDyqiYM647D+QTWNmKWjj/4dRx/Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n6sZ40RpctsxUSbW5DwJnUkyRU6NBLsMsQhut4gt98I=;
 b=yfxlLkVb3dPJ2RJV1uvd1SdY4hBRnc2Qq2otyeWmvVE6aFNbZE1TjzQUxWajHd699Nv5OxPaqOcHYN925T6uoaZSfDJafvfjNHeFF5Z5mkvCLjn5dd8dWDECmURZGIC+QVvhjK7UmfDdiGPyZT6qtrw8uD6LFxYhBJY9wltg4DCwTgcr3uvo1OwnxZGVTI8kyX/xJEGxOe0s6A4EwCWANcAgDuyoGenIvNccfHnh0YaONzjA8bqlNW2uspx9zij/+bXuL1xxNkWlKQh1r6XVstKodbFtcBxFit6crsceUa4QBeADcW2QtDaM937fl9Aouu2ZCNi7kAsVmEcspF6eww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB6269.namprd11.prod.outlook.com (2603:10b6:8:97::14) by
 SJ0PR11MB7704.namprd11.prod.outlook.com (2603:10b6:a03:4e7::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.11; Thu, 13 Feb 2025 21:50:25 +0000
Received: from DS7PR11MB6269.namprd11.prod.outlook.com
 ([fe80::af1f:dcc:49bf:1a26]) by DS7PR11MB6269.namprd11.prod.outlook.com
 ([fe80::af1f:dcc:49bf:1a26%3]) with mapi id 15.20.8422.015; Thu, 13 Feb 2025
 21:50:25 +0000
Message-ID: <d8f3eb33-d902-4391-adc7-005e4895b471@intel.com>
Date: Thu, 13 Feb 2025 15:50:19 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] tsm: Unified Measurement Register ABI for TVMs
To: Dave Hansen <dave.hansen@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, "Kirill A. Shutemov"
	<kirill.shutemov@linux.intel.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>, <linux-coco@lists.linux.dev>, "Kuppuswamy
 Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20250212-tdx-rtmr-v1-0-9795dc49e132@intel.com>
 <15c69d57-4ffb-4ea1-8cbc-0ba6d3d7b14f@intel.com>
 <be7e3c9d-208a-4bda-b8cf-9119f3e0c4ce@intel.com>
 <015cdddb-7f74-4205-af8a-b15cad7ddc22@intel.com>
Content-Language: en-US
From: "Xing, Cedric" <cedric.xing@intel.com>
In-Reply-To: <015cdddb-7f74-4205-af8a-b15cad7ddc22@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0045.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::20) To DS7PR11MB6269.namprd11.prod.outlook.com
 (2603:10b6:8:97::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB6269:EE_|SJ0PR11MB7704:EE_
X-MS-Office365-Filtering-Correlation-Id: a0c441c7-bd27-442c-1500-08dd4c786c21
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UUFkRWM1N3VrVlBBQjVKNGdUemxFeUpnTm43UXVxUjBzbU1YbGJUTWxwbTIy?=
 =?utf-8?B?RU54elhjRytYVGJ6bERPODg5d3pzUUxzMTZKZVZWWWZaV2tNNEE3cnhpVUx2?=
 =?utf-8?B?S2tlZGxVcjAyQUhZNm5PNkNINlJnSDNIdS81WnBmTzNhUFBxR3dVL1pXY20v?=
 =?utf-8?B?akE0Z2l5Qm1lRkZ0T09NalZyU3daTnBQTDJTcjE2R3ZPZmV1a1pZSk5QWXZx?=
 =?utf-8?B?S1JHaUxsNVdFNWlkR0wyN3pHemtyWE0rNXlNMkZjR2I5Mk1UY3hiejRHM05t?=
 =?utf-8?B?WFZwbTRNSDZmYWQ1bUZONGF2Y1lWV1A3SFp2aUJLeXUzNlB1SFJJZ2tPcEwy?=
 =?utf-8?B?QS9qNmltbWxWM0Y1bHpRa1JGODBFKzB3TzZmMlgxTjlmaGtoaDVwaFB6Qy9C?=
 =?utf-8?B?TmczdDJZRFB1SEFWWG5idWEwQmtHSW5XNzdaS3VST2o4NkgzT0lHQkV1blBP?=
 =?utf-8?B?WUdMK3JDaUJMQkpyZGovcCs5Z3NpOVg1UFAyM2R5U0E2VDZQUUNaMzVwN25Y?=
 =?utf-8?B?RjhXc1c0WTd6NWdDeEhZMUxPTm9RTDVWYVlOaVoxajZMMU1XVklEWEZyT0tn?=
 =?utf-8?B?T2Eyb3NLazN2YlpQRFFVdDFHNUxwOGtIeWs4R3BTazRjZnMybElWRkJGcHIv?=
 =?utf-8?B?WFFZb3pLV2hlb01UNE1GWG1WTzlUSmZ0ekNTMU8xaGdQNXhEcUw1aHhwdnJC?=
 =?utf-8?B?WllobTlzNWQvMEpyYzFEOThLSk85U3Ardmdac1B5azZsZFcxNTdualpQTHkx?=
 =?utf-8?B?NitDVmZ0aTV3cjFJblg1Ti81REVqdFlpQnpaVzdMSXhwOU04UkJDM1R6aWNM?=
 =?utf-8?B?ckIwSGhJQytlaVduRUVzSGxvck96cnZWY1FNY2xRazN3Z0V2NHBMYmthM1U5?=
 =?utf-8?B?TnJXSXIvMFdhaEdJclR1Qk52MkZFRW03K0twanhPMFlEb0h1WmxPZnlMOTE3?=
 =?utf-8?B?Wkx6a2REY2hUQWFmODNZNHdtVmdtMUpQRkJiR2djalhPQ1pwWU5IdGdoOFJv?=
 =?utf-8?B?TTQyMWlLN2syS1V0Y0ZiQkpnSldhTlg3Wm1WSXBUVVRwQ0RoZXJPaFBiUmF1?=
 =?utf-8?B?TVZCMVhCTFRRQ3prNGZnSVNnRDJiaWhVSzF2eDhUanhJNWptTXdQZjdYWGNn?=
 =?utf-8?B?QXAzblZpSDA5OStOdHh3QUZjQkF1ZzVHUllSSkJObDlCeW9VT2d1T2pJbzZs?=
 =?utf-8?B?T1hlYVh4MHArcU1oNDdHSjVleVZ2SUtNTTZkWWprNmFiVDdhMkd6ZkJZMWlB?=
 =?utf-8?B?cTFiOUkyOGRPcmdyanp4VlB1UXFUTGVOaVFWZ0dkSGhXNE02TXZjdnNOZ3FH?=
 =?utf-8?B?Y3lGd3l2V24wSWl2b0VEc2tKVDZ4eFNnaG5yWXV2UGxvdVFiU3ZIRkJiQVVC?=
 =?utf-8?B?WFVwRnI4REdGMzF3RUxZclNibDhJZFFqTDJoejZmdHRqRFM0SlFZdkphZ1VP?=
 =?utf-8?B?MFJnSER0aStvUzNrdC9vNkVLaUdWUW5UWEJnc0E4cVRabjJYbkgzUW94UVlx?=
 =?utf-8?B?QSthZ00zenRScmk2NVY4bmdQYU9KOEJWMENORjlweEpoc0pZVDBmd3pXLzVD?=
 =?utf-8?B?WWdYR2U4MnQzbGJvYUQ0ZjZySUw3d2Z0YXQ3ZkNVWW1HbDBHZ1RoK0l3Vkxw?=
 =?utf-8?B?eGd3dThMQk9UeTN4Y0tTZ0VGbnNDRzZ3OEE4M1hmN0VWQU11eUNjL0oxeVpU?=
 =?utf-8?B?YzRWRXBEUUFjZmQzZUZJVTI0Q1lndW5qTmhxZHBKQ2h1ZDdlRGFzLzJSYkVD?=
 =?utf-8?B?b0VlbHdqb2N0NER3YS9RZHBmd0J3bDJqWXlza3JWTUZ3K0xDMUdxdjNCZGVr?=
 =?utf-8?B?bXBwcDJKZXhhNEY2aWRNUkU3aXB0cjJYOUc5Ukp2TUdZcTNLM2lYaHl3RmJk?=
 =?utf-8?Q?0tPWQr0gHkAxn?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB6269.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUhkOGtEd2EyMkUzZTQrd3pZOUhTeVFncVE2RmlxenNJMEt5TEkyMkc2cCsz?=
 =?utf-8?B?SFFkZnVxSkh5OHF1ek9mMmpNWFNoYSs0cFhtZmUvRC9FdjlCdnZNMUZITmtt?=
 =?utf-8?B?TjdQSWI4OTdLR0NkOW5pYTRIOTgvUTFwTHluOEVFRmVWQmUwWmpKa3dUNjJV?=
 =?utf-8?B?eFdGc0laL3AvRU9yRTRzUWhkeU5MNUhNclVENWJyWE9mTjlNWThpRnlOK1hz?=
 =?utf-8?B?TmE3N0lMb2VLWlpHWGUxQXVjYU1HUmhPY1JJZ3lIQXl6N21CTytvU0U4eXU3?=
 =?utf-8?B?a3o0aHJob0J3Zng4aVA3T0FlYXkxZml6eVpUVTFzdElkQnhCMzZ3WWswNnNS?=
 =?utf-8?B?ZzZUTGNoV0QxUmR6L0RJUXhWRk1LVXU2UUZuVDQ3TlhwOUNCOEwwR05iZng1?=
 =?utf-8?B?bHY4Tm5peGF3MUhxYUxKSGhHRHE2aENYWTJvNHIzamdRcTFoek5IeTJmR0g5?=
 =?utf-8?B?OFhRNXUxa3FaT0xweTV0SmpLbHNBRE81ZHZIK1pFQVBtYVJnbGNyc0lWV3Ny?=
 =?utf-8?B?d1B1MmRyU0VDUmZrMC9BcDdhOEJYRWc4cE9McU5TNStRM1VMRG5yUUdabE1k?=
 =?utf-8?B?dkJOZTZNNTc2K0hQK2s1eHhxWldmQTIyeVdlSEtNcisxbGtBWGE3M1dRa2d0?=
 =?utf-8?B?L2Y3c1UzUG05cW0xZ2srQUxDNjRXR0ZJN1RZT2h0czVjSzhZZ2JTc3MxQVQ3?=
 =?utf-8?B?SUZRcFJWcDg2a3lrKzR1eEFEYTBwTmhCajlxaDRYQyt3K01oZXBWbmxGYWNN?=
 =?utf-8?B?NXdFWm1JV2ZHbHNFeVhvTHFPT2FLUndYQmQrbG5SayttdjBPTTJnNlc0NVBF?=
 =?utf-8?B?ckhnTHdoQmVnZHczeXVwOUZvWW8ydnNBSVV5M2JtY1QvTFJ3Tk1RaDRhVlk3?=
 =?utf-8?B?R1o1YlRMUjFWOVp6dmVzK0lHdGpWeEx0SXBpWi9iMlFsQ2NLNFAvV245UHN4?=
 =?utf-8?B?Mk5oZUdHMU5ZRldhOGtOcFhBYVFxL0FOZm55SCsxSjJDZWQ4RzN5YXFJb2Y4?=
 =?utf-8?B?MVc4dFpBMzFoVTFyMDJySFNWRkNYYXRDcFZWSVVYeVVsN1hDTjlCNWlCbXJX?=
 =?utf-8?B?aldNNmJMQm9OM0hJUUFIUGxVZFBGWUFzY0Foc0VXL2RuRERJZHN0T3JIS1lO?=
 =?utf-8?B?M3BsTnVxTkZOR0twcDN3MkU0cG1lOUx0MXIzWTgwdVQ1N1N4ek9KOUhQczdC?=
 =?utf-8?B?Z3hPeXhkeTJvbzcwQzVzVTFRS3EwTFFmU0ZQeU9WK3VJUTYxSjZDZUxGTW8y?=
 =?utf-8?B?a1ZSUXpwWDVHQkNLZnY1R09ZclY3K0UyTC9WSGFZeDFsZlNwTVIrTFgrUnBs?=
 =?utf-8?B?SWxmcGc2eVVNdEg2N1ZzQkh3N1NtNSswM2pIVVd3d3QrcXU3dFlPVVZ4eGZE?=
 =?utf-8?B?ck5paFVhY1BwODgwNWlwSE9QdXhBcTA1N3JqUzVadUY4N0JTNnJQU2Mxb1NG?=
 =?utf-8?B?RnI4VzkwcG1vSC94K1ZEbmh3cU5xTzVxZnpUdTJzVGNRS09iRkZ0ZStFd2Fz?=
 =?utf-8?B?SWJhY0dpY3dhYUNndE1XbytYaWNtWFptUzc0K0NoQkxvSDdzK25WLzcvYVhM?=
 =?utf-8?B?L0FzVFhabGtmV01Jckk1WU1GNm8xOXQrWkIyaU5HY3hxWUQveFUzZENpM2dB?=
 =?utf-8?B?NkYydUtpOEExUnRTN2xZNUhwSzF1U1d0eDJhUDNheEJza09IbzNVNC9NVndp?=
 =?utf-8?B?WUxFSnd2bmJGVGF1MnFmU2wva0d0RG9MamhoenJJK3o1NXBPdjRYeVdxYkdq?=
 =?utf-8?B?T3ExdjlMeHVGakYramdEZXppRzd1UDRHRFBVanJaV0RXbkd1R1JxSUlsbVBY?=
 =?utf-8?B?N0o1aXZRTnFOdkUwTi8zQm9SVVd6NjlldnNZOVlpbFlkMDhxVFRTbzZBME5P?=
 =?utf-8?B?V09MTDB1MG5kWGpwNUFqUFg4THIyM1ZmSjdWdjZBTEJNZ3hJaG91eVFFQXUz?=
 =?utf-8?B?MmVpQmljb1I5UjFPZnBmaEZ4VmxpL1NZM2hwTFI3UTRwMUxVeVhoSHNRME5r?=
 =?utf-8?B?NXVibit2dEJUazl4bDJJVGVkV2pueE9HVVR6eHZ1c1I1SnpOcnNTZS9nTEhV?=
 =?utf-8?B?aFdSb08wRVJ6SnVUL2pteEJQdW1vVVdQM3cwNHdrdVYxMnNSc3RaZ0YxeWh5?=
 =?utf-8?Q?TS/gZ59KMHS4FjD3Wq+xDEtG8?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a0c441c7-bd27-442c-1500-08dd4c786c21
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6269.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 21:50:25.2239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ygww9vDcxQg4ZSzawL6LQzEzHy4R6J/DcEdskdew5iWwtCqj5Tmn89ZerIM+uldCvNjK6hnqsoSCFv5iKqAoKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB7704
X-OriginatorOrg: intel.com

On 2/13/2025 10:58 AM, Dave Hansen wrote:
> On 2/13/25 08:21, Xing, Cedric wrote:
>> On 2/12/2025 10:50 PM, Dave Hansen wrote:
>>> On 2/12/25 18:23, Cedric Xing wrote:
>>>> NOTE: This patch series introduces the Measurement Register (MR) ABI,
>>>> and
>>>> is a continuation of the RFC series on the same topic [1].
>>>
>>> Could you please explain how the benefits of this series are helpful to
>>> end users?
>>
>> This series exposes MRs as sysfs attributes, allowing end users to
>> access them effortlessly without needing to write any code. This
>> simplifies the process of debugging and diagnosing measurement-related
>> issues. Additionally, it makes the CC architecture more intuitive for
>> newcomers.
> 
> Wait a sec, so there's already ABI for manipulating these? This just
> adds a parallel sysfs interface to the existing ABI?
> 
No, this is new. There's no existing ABI for accessing measurement 
registers from within a TVM (TEE VM). Currently, on TDX for example, 
reading TDX measurement registers (MRs) must be done by getting a TD 
quote. And there's no way to extend any RTMRs. Therefore, it would be 
much easier end users to debug/diagnose measurement related issues 
(which would almost always require reading MRs) with this patch.

> Also, you're saying that users don't need to write any code, but then
> provide... sample code. That's unexpected.
> 
The sample code is to demo how to expose MRs from a CC guest driver, but 
not for end users to access those MRs.

> Oh, and you seem to have forgotten to attach the sysfs ABI documentation
> patch to the series. You did write the required documentation, right? ;)
Documentation/ABI/testing/sysfs-kernel-tsm (new file added by patch 1) 
contains a description on the attributes added by the patch.

