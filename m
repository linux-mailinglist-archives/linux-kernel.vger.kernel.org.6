Return-Path: <linux-kernel+bounces-331159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6800E97A943
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 00:34:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 958B71C26F2B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 22:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4E31547E6;
	Mon, 16 Sep 2024 22:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gejNjXpl"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964A413C9A6
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 22:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726526082; cv=fail; b=fX92QTaL3WJytPALimhbm0MGtjsQAx4j4pTuYMNrtlcFGvbB0HI4eV+C7oavm/ysc5qrJfeJp38WGiDHWfkPr3ANk7esVrLF7ewOOJFHOisuyfLQjgxy3teWTGFCCWAiPPiPB6QfvNfD4i/4w/Pd5kzge6mEI++okTNuuCdQnfw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726526082; c=relaxed/simple;
	bh=wqNxE04e+jcClUR5Xghz2KYSp1+Soot38RrgmWxzC58=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=acQvYWVl8fS4fRlqkTgBjwVPeBf3zj7Fg+bR3WB+0ZryjL8hA/QmDqxFnK/bq8ZxgWvlmtkyUMeCgkAxZ3A4bpdhXwgKiIYgJPM/gZuaJWTWCIaVWjicoxzY3iqM1sR+4g7enfhlNi32EpYGXyylseXXEvsr2eAheW1qNxlchao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gejNjXpl; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726526081; x=1758062081;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wqNxE04e+jcClUR5Xghz2KYSp1+Soot38RrgmWxzC58=;
  b=gejNjXpl434MS9VtQBgYHVxwD8zvd5k7Qm2oTGzhlLCPzlrBZmAJ67oB
   InOzHIh5sk+H0DesmfbyIQ0dNjCiiCAXcjzfJGcivdEFXNGdNMjpeDJ2e
   OSNJa7ZknHJuV0yYh26+jEpiEmCTqeFwMwgkVsrm1qXHCEL1TnRQRejSl
   y3syOO68cssq8bJT19s/V+8UUYnxRtYK+0cij1wrzXWqu9zH76x7TQ7YK
   LMCBw6oefAM8zT45zwyLCG/pTgZ5X7V252nsrxVNGyjzkMSIhwI3TfSdm
   Uq/jr0I4rjHuPJEI1I2TABtdOEJXRWq5QwlkH6a60wN0OSh6nOqXcVu6b
   w==;
X-CSE-ConnectionGUID: oiSNdNOaR6a32NZXLErz5g==
X-CSE-MsgGUID: vPFtoX1ETn6fIwJSIYh8hA==
X-IronPort-AV: E=McAfee;i="6700,10204,11197"; a="25526433"
X-IronPort-AV: E=Sophos;i="6.10,233,1719903600"; 
   d="scan'208";a="25526433"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2024 15:34:40 -0700
X-CSE-ConnectionGUID: cZxC8BCGScyzG7/B2ys5Jw==
X-CSE-MsgGUID: 2rsDbGb9Q8yJFlzmOUqehQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,233,1719903600"; 
   d="scan'208";a="73072982"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Sep 2024 15:34:39 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 16 Sep 2024 15:34:39 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 16 Sep 2024 15:34:39 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 16 Sep 2024 15:34:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wys86z85UYdzlSB+pdihQuZADe8l+Yyy0gJ1WL1OTp39GDnBXOe8nkvOTkcQAXptANMbhdqs2k2GjPgPlHdo1yAbANDtngZ9CCzkoHBgYDfL5TFbtCxvrNpwncUCbP4QqVaMmV71BCmDdxJqTVFCXfOFaAUSaMoCGxtFjXsFMxLNtzRvzlc/oKHYomk+zT5BAKPH6+YV4mwCE/mpvI/jbOXOHcUDF2aj1Vfi4btESAeWWX/niWOPF24B8sRnJtDfl4pOGsnMV30Br2mMFLMBFLbvvprX/LtxkAH3ygNIiAw/upS8Hd1Iu8pvTbGzQTu6kDts+8aEuurGo2qNNBHlJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wD9PTt9HSdt44GfbZIsGQLAF51gm/FDE3u0tAkglYZI=;
 b=gknrXUgYAwVVUS5rQiiHPfKSZgWBkDDfiJB3SUeSuOKjgK07nCbfC29ofdstfKGUSnQqT8yLEzChkPIYgH5Dmb/uRsPkm3vUcp3s/ct76gtYOWs8wC5FSB5hQmLyWz4xq0HJHf3XWV+eU7+y7BetQDQOhVw5cSDbIcXiPQTqW2mUoGx5Bl2fj3aWWmDyV41kPNhoGnUfFoaL0HoKjwK/psyKuRlgXsc8b+SULa0zhl2BJHdxSQyu3rrAH3mubjklBVxLSzETdLQrdHqJtqmj6ED0FHXCA190m6GVUW9EHjj02a8Xy3vtYMac/A0ByL+4zlte3cOGWKrxLGYtxJMbgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SA0PR11MB4623.namprd11.prod.outlook.com (2603:10b6:806:95::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Mon, 16 Sep
 2024 22:34:32 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.7962.022; Mon, 16 Sep 2024
 22:34:32 +0000
Message-ID: <538114ea-57fe-4553-962b-edbe331ef573@intel.com>
Date: Mon, 16 Sep 2024 15:34:28 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/39] x86/resctrl: Generate default_ctrl instead of
 sharing it
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
 <20240802172853.22529-9-james.morse@arm.com>
 <72e612b3-0840-4cbf-b5fb-85ed3be4cfc8@intel.com>
 <8b7ffd4b-6e04-4c3a-bcc4-33d72139414f@arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <8b7ffd4b-6e04-4c3a-bcc4-33d72139414f@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0103.namprd03.prod.outlook.com
 (2603:10b6:303:b7::18) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SA0PR11MB4623:EE_
X-MS-Office365-Filtering-Correlation-Id: 26fb8405-1988-494b-c839-08dcd69fbbc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aWFqVERHZkZreCt1alNzdGJRKys3YVArUUdmSEVOSTlBZ2NOejRUdHhNUDF3?=
 =?utf-8?B?RTlPbDRaRU1OMmdRb3pQMlNTTnkrVHAvT0pWT2RjOW5xcGtqMDRQQTdOTmI2?=
 =?utf-8?B?NjZuQ1hsL2lyeVRIT0ZNQUJjb1c5WHhGU1ZIVVFYL2hKTXRmMDB6SDRSS1lK?=
 =?utf-8?B?SVVZcGF6ZitqdnVtRVR2K214NWdHbkV3U2VKdVJhK3ZQTlBwOE43STFSeHdq?=
 =?utf-8?B?M0FnTjNtWTVBRWVYU2l0bURKZHAvU0k5VmI2SEZad3ZpZ0o2TFNtQUtqM1Nj?=
 =?utf-8?B?UWsyK01TVnZrdk1uclBHS3hJdmlmbTB6WEhqTnA5TEpBUEFlZllHTHg5L05p?=
 =?utf-8?B?UWhIbVFiTjV2KzRMZTVadHI3Wm5wbDFsR3AyYnV6SDRCaVR0ZWlwUkMvMEZH?=
 =?utf-8?B?MnJNNUJmbE1URlowQWlkMlZKRHo3YWZmcG9xWG1waUNPTmlKeHlad08za3pw?=
 =?utf-8?B?ZmlHSjR3cUpCODRGQXcvL3ZhMUVyZTlsQnVubk5RdXhkYjNGSCtxWDNCS1NK?=
 =?utf-8?B?NlRVSWxjc3MrZm0ybFBPb0xrTHF1WnpCbFk5R0ltVUljOHNOTkhIeGt2UGZX?=
 =?utf-8?B?NlU0RmhZMzlMQVYvdHJvc1QrMGlSaDZ2ZlVVUldwRmdnOGJIejZ5SzlNMmda?=
 =?utf-8?B?OWlXRkV6YUhIc29nT3lIZXpIU05uUUszSFFzWTAyY1gxOFV6Q2NLbkh0L1U5?=
 =?utf-8?B?aUs4c1VCY0h6SWF5OStRdVpiYVZmV1VsVzUxNit5KzVkdXRQYkFNTWk2NzBz?=
 =?utf-8?B?bzkzYmxFZmNlUzF6cTB3ZWNwdFZkLzFWMk42TTF0WVEyZDIrbG1sVUJiaUZl?=
 =?utf-8?B?dnZIYWJaTnlNa1l4Rk4zSGNBeUI3bU9lTVBQK3lrNnFpTmZ5bWFYZ0RZOEQr?=
 =?utf-8?B?OCtVYlNLVEZMT0pSTDBLNDFaYjZtQzFWZGpHcW5vdlQwd0lLNFlhTE8xdXR6?=
 =?utf-8?B?UzhDZkNKZ29NckhQYlduS1VheXpaOTUvMmFQVWtDYXU2QmViSWNla3lTRlJn?=
 =?utf-8?B?eEJSbEhhNjZYNjliSDJXYmNDeDNiT0grYUxwL01mY2Jvd05nY2c0aUV6aE9I?=
 =?utf-8?B?VHZGUG1RVzcxZkRBN3VBcFZ6b3dHV29aVlBOdEJhL1JhaHNrR0xLMExmSVhX?=
 =?utf-8?B?MUJ6YjNIeWxrem1VRFYvSVJUWXVRK292c3dmUnFWdWlRM0g5aWFhWWVSTWo3?=
 =?utf-8?B?ZEpHVzBpaGpGaFdUaDgxZGZQUGNtdm1pVnpEc3E1Z0svRkpnZ1lXTGQ3WmZh?=
 =?utf-8?B?dEVlMDVzOTFtaVpsbG9maEh5ZFZzc21EdjA5R25WVDNJUTNkSnhDMFFyNUhP?=
 =?utf-8?B?TDVGSzI5YjlOUHVMaFFrb29xZndnRzBIZ3l1ZTdod3JaSFJDb00ydzIyUlFv?=
 =?utf-8?B?UnZFOGJVSDVsQTc3dWplMUkxVFpwT1NYOS8wMVI2NC9JdzZoWUZrOGZOTGho?=
 =?utf-8?B?clZreXd1UFZMenRLak16ZXJ2VVBIRlQ1d095eElvWStudThJU2hBRzZmS0tT?=
 =?utf-8?B?QzNWTGI1Y1FPM2o2ekhyNHJWbUZSMzBaMmNodXNtWU0wZnFta3hIRndlZjVs?=
 =?utf-8?B?YTFDd0VXdEpSSzc4UkNkeFVGZGs0Z2cyTHVnYXRITDdvVUM3OFJTMXhqSDVt?=
 =?utf-8?B?ZWlKQkExeEZvUTcrMW5GTjdnd1RjUzZXeUpEdERoTzl4UlNONW4zTXVUM00r?=
 =?utf-8?B?RG1wdkxwTnVodVdERVB5azY1TnhrTjhBa0VJSFJTR3ZiWm1ZWFFIL1ZhTFNL?=
 =?utf-8?B?VXZYcGUvdjR1NlZwaDVUSUtaKzdqbnZaVU5pWCtSU2VIQkFMS2did2JteWhw?=
 =?utf-8?B?WnlpeG5JYWVEcnF2Q0NJdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDhRQUVoVTlSS21HS3NjNzlSUnd2K1NjRlEvMXphUE1KSndNVlZOU3ljRnk5?=
 =?utf-8?B?Z2pHSUREc0xBdFlBQjhtYjBIT0grZTNSd2IxRjBtS1A5WmsvbGNFVzlCL1Vi?=
 =?utf-8?B?eHV5WG5wOUhsQWpuZlQrcWs0ZGFKKytrNXFnQnVqSWY3VnV1UkFQbXVFelRa?=
 =?utf-8?B?dE9Kam10a2JNZytKOVJTc0I3RVhLWHdQMXQreFJZVjhkTVpWc1ZjRlh6U21R?=
 =?utf-8?B?cmVubjFzQXY3RlU5ajlDVEYyVllKRzVCTWRHK3VvS1hQbi9ZOE5UcWtNLzl4?=
 =?utf-8?B?K2p0SVA5Ly82enk4UFlML0pkUzM0bHJlbWEwa2RaVFMzQ2kwMm9JZGxnQ2w4?=
 =?utf-8?B?d0ZDZGFETk5WNFZhOEVtM3FyL2dIRU1wRHY4cHBIaCtTbHk4L0VnU1NsZktW?=
 =?utf-8?B?WHNGQ0FYclR5UUk0c2dwc3hJTW05aElBVWxwbVVYRXBnaXN1RXUrN3pYY3Vw?=
 =?utf-8?B?blUwSzlkak11bzBnaU1Wa1IyTGxKTm9zRnVHNEtoRHFsQ01NTWxqRUhEbXpX?=
 =?utf-8?B?MjBoZzBXdXBTZHNSNnRLYThYd2pXSTAzUmoraXppVWFmYitmZC80TGVrZ3ds?=
 =?utf-8?B?VlQ2RndTTnRnOENzQ3I0SkdNOTZaM2NYRGFyNXRYdmZRWmhZQWRiMXd6SnJv?=
 =?utf-8?B?em1iWWRqME9BZE8xNlVnSnhnZVp1OTlBSVRkQ3FVM21zWGpnMmhYQU5tZ0dy?=
 =?utf-8?B?bksxVWx4b0JLemhZT3ZMVUl2VSs3VGtBclB1eElaU2lYZWhyaHJDT2NVNmJy?=
 =?utf-8?B?NG9XbEpwRmVVb0NFUWRXaWU2NVhRZ3dpUlhySVVxVHhrWXVxNzlhWC9qQkV2?=
 =?utf-8?B?OW1Qck5Gcmp6WEt4Zkp5bTRWd2YwUTgza0VCSUJpQnIwRDdNWFhZZHBzMmZv?=
 =?utf-8?B?M3VuNDNBdzZrRnBpbS8yTkdSQUFQVFJodXUvVDZSZGVxOVVhaVRxVWpRZnhV?=
 =?utf-8?B?SjdoZFByWVVzT2NjR0dCQnZhcWxKNzVkREpEbkJ6T0RGZ3NDcmtLcDgzSHor?=
 =?utf-8?B?SzMvVHZBbWhPMEo2TTRCSitXODQxNllzbW0wWjJwcEc1eVN5MzExMitMTVdo?=
 =?utf-8?B?OEVPS1ZadjVZSGk4VG9TUVNLYmVYTW95c2hrQ0ZFbE1JblJUK0ZBc1JsQjNH?=
 =?utf-8?B?SU96N2Q4MkhEWHRHdUpsT3ZMSExoYU5Uc1c4VXZHcDFQNHdvSEgyRkRSdEw0?=
 =?utf-8?B?QStEMHNoNDdKdlU0MXVYdlR4NGFkQU5tTjhhUllLdEpJb1dYZC8wNnYwL0hM?=
 =?utf-8?B?bWM3M0hJZ3g3TWtUZXFvdEw3UkM4QzlsU3hOV1BDa0ovMXFDZ0MwditZbWxr?=
 =?utf-8?B?U0FVNDFoUmRhd2IvSUtqeTh4WUNyc3J6M1ltMko3eThSUVF2eVViVnNXRW9W?=
 =?utf-8?B?Wm5ZRlA4R1hMOWRxM05WS3ZhRWNYK3ZVZSs3RzhFL0NSMFJNNUJaV3duRUhI?=
 =?utf-8?B?TVdXaVV2Ykd0YXY5aTZ6bVg0eGR4K2JibXpFNmVQY2NpdkNhWldmMWE1NWdF?=
 =?utf-8?B?RlUwNHlrcXhrY1g0bmxUSDZ4eUEvSlppcGIzNEZrdXlTSHlUWXhRT2FLZHhF?=
 =?utf-8?B?cFcrT0ZkcnlaSDM5UzJJUC9kb1pGdFg0NFRKOE1BaStGQzNncUJwQ2tKaUt1?=
 =?utf-8?B?VXdHREpwcVV4Ylp3b2VUaEwxNHZxbTZXM2xNTjhOaUlEcnk4U1h0TVZJTnNk?=
 =?utf-8?B?NXA1d0g4Qm0zK3B2Y0JRVmROOHJ4a3drNjQzU005dnBkOEF2T3d0ZTlQM3Bw?=
 =?utf-8?B?T01XbDdDMTIwS0ZyckhYanFHaE1nazl2R2d4L0NPYmxYSFFIbHJWSUhXYTBW?=
 =?utf-8?B?UGJYcnVDb3pGL2lrcFQ2WnZDRXFuVThIbmYyZEJVbXpGNmMvbjBRc0FPTmtE?=
 =?utf-8?B?WG1zQ3JkYXRVamRRUm5aaHptcnhmUkx0Zi9aa1JZQmJ4RDV6NzdDeStPblJC?=
 =?utf-8?B?ME9jenNkTEpHMHZieXhMaHR4NzJXd0EydFl6cExDTTlHMHk1YXUvQkxZNVhk?=
 =?utf-8?B?QU85d2R2cjZGalY4RDE1bFdGYXhQS2NYUmpJS3g0enJZNFFZOVE3enU4YjJh?=
 =?utf-8?B?OWVmbzNVUG0rUVhKYmVDS0RUdTd2N1FSRFRBTnZ2NTFoNUlja25rZ2pDUDhj?=
 =?utf-8?B?YjJDR2crT25TOEc1OUV2RHRnazhWMGo5SS9HRDNqeXhRTVBUY3hZQ09jRVpv?=
 =?utf-8?B?UVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 26fb8405-1988-494b-c839-08dcd69fbbc6
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2024 22:34:31.9489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xdUHmfaLdG9pPuul3m39KI8qmcIFSz/v3VWO7L78fCcFGfA1KrmIiHm9ooPMXCcydEhAJNGKwbGQ97NPzRPUqsZLU0V7oW1P/MJ1LEKNGvM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4623
X-OriginatorOrg: intel.com

Hi James,

On 9/13/24 11:07 AM, James Morse wrote:
> Hi Reinette,
> 
> On 14/08/2024 05:00, Reinette Chatre wrote:
>> On 8/2/24 10:28 AM, James Morse wrote:
>>
>>> +/**
>>> + * resctrl_get_default_ctrl() - Return the default control value for this
>>> + *                              resource.
>>> + * @r:        The resource whose default control type is queried.
>>> + */
>>> +static inline u32 resctrl_get_default_ctrl(struct rdt_resource *r)
>>> +{
>>> +    switch (r->schema_fmt) {
>>> +    case RESCTRL_SCHEMA_BITMAP:
>>> +        return BIT_MASK(r->cache.cbm_len) - 1;
>>> +    case RESCTRL_SCHEMA_PERCENTAGE:
>>> +        return 100u;
>>> +    case RESCTRL_SCHEMA_MBPS:
>>> +        return r->membw.max_bw;
>>> +    }
>>> +
>>> +    return WARN_ON_ONCE(1);
>>> +}
>>> +
> 
>> I am concerned where this is headed. Since RESCTRL_SCHEMA_PERCENTAGE remains
>> in use when resctrl is mounted with mba_MBps the default cannot always
>> be 100u (it should be MBA_MAX_MBPS when software controller is active).
> 
> I agree - and we can certainly tidy that up.
> But today when mba_sc is enable the bandwidth_gran and min-bandwidth files both report
> '10' (%?), which isn't particularly meaningful.

Indeed. The complication with mba_sc is that it is a user facing MB/s solution implemented
by percentages in hardware.

> I think these should both report '1'. There will be a minimum bandwidth, buts it not
> something that can be discovered by the mba_sc code.

I understand that it may simplify the interface but please take care that the implementation
relies on these values to determine which percentage to use to accomplish a user
requested Mb/s.

> 
> This was an oversight because the mba_sc mode doesn't update default_ctrl or the format
> strings - it hijacks the parsing elsewhere. The default_ctrl isn't visible to user-space,
> the value used when reading the schema file comes from the mbps_val array, instead of
> ctrl_val.

Right.

> 
> 
> Some of this has been booted over the horizon - I'll add straightening out the mba_sc
> behaviour here to that list.

Ack. I think it will be simpler for this work to focus on splitting existing
implementation. If clearing these up are a priority we can also work on it before
the split, but not as part of this change that I believe was intended to not
include functional changes.

Reinette

