Return-Path: <linux-kernel+bounces-323894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D6B9744C3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 23:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0F20288642
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 21:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919EF1AB522;
	Tue, 10 Sep 2024 21:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LRV4bATU"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F17323774
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 21:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726003585; cv=fail; b=ONShAOE3earLDLHCSDRSibNoeR55KjfhiJm2fo+g5Qk00/2GboaB2IUABFH16ahFcYnudcU775mnvwd2BmzyXUxRqcPYqXFyzuCIG0GVbsUM/BXacN6hMVLeb4e8jgQ6agkKY/2yAOY2SeGcxnSCXDoxAjzxYla/mo5vYD4MupY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726003585; c=relaxed/simple;
	bh=yH6Eu4ilhxIxBO0o+/WfBMCelEJ4jexjwoyjWFrKqUo=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=srOC2uRtpjOKHznweKy9kfZheqz9z1ymq0apYDVHFMGb9LrjUz/+IIn9sAvNJ1GQ0Rwstp2qU56Wv2l67ms4ZZvWD/Rqvy2EG/XezXjuEoIBwia2aaZS5A5TnLgMpzlDfs8WzfKAGzS35ML5NVknkEMwRuth73NsLSdSwVd1u1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LRV4bATU; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726003583; x=1757539583;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=yH6Eu4ilhxIxBO0o+/WfBMCelEJ4jexjwoyjWFrKqUo=;
  b=LRV4bATUA8nhrBtaprrCOVudH7yK6N51G0zDp80LxwELkgi24ang4D+x
   IDc/3P6wAOI8kFRNwu/ryu2h6BIOb6vIcoPfNDzfS7s2F27vzXkdv9eSU
   wPLzgjtaSoO64EDS7kB6kDbndFNN09QJyaDcwdu/YMvIceHpBlgyoPnHU
   qIudp5Y17Jw5BH9KiUVrqHzZMLdIupYZfW/oRN/tNo48CXQsvnrDauxmN
   gldVartQ24qvSBVZLUxZzqPVWjWxXWL/K1ZurBryM3F88tb2ICmU8qjf3
   CT2iVcomx7+GQauOQOAZdRI72w4dhUo9yVeWKODpFdXl+fwvR6gPA5Gsi
   Q==;
X-CSE-ConnectionGUID: ruyC/qaMTpKxI4vFu3XFYw==
X-CSE-MsgGUID: ZntpbsuLSgmMw8Wj56V5UA==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="27697653"
X-IronPort-AV: E=Sophos;i="6.10,218,1719903600"; 
   d="scan'208";a="27697653"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 14:26:22 -0700
X-CSE-ConnectionGUID: Elvo1uYFT/+iESizLoQfFQ==
X-CSE-MsgGUID: qt6cV1BAQdqUQ2t3HqqsRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,218,1719903600"; 
   d="scan'208";a="71954158"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Sep 2024 14:26:22 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 10 Sep 2024 14:26:22 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 10 Sep 2024 14:26:22 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 10 Sep 2024 14:26:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a+7p9LQvWtvLgR1HXCycfpma+yXowmc70Zkzi7ITL8PibcLfSyp3XpT/v1SvV2xkCebqH5JRpH6gNXKUDXTT/cXLfDF/BGhkMZtziYuYMHQdi3D6PpMdT0c3urjAJABi4ket1vQ6dRpZYNZ7Yeh+Ny8ngxsG5dlca6h9hIu6utXiL5MseRUGfwssynofbz+wwHXweZ5tGWFm8/rakQKKB8iI5YzdFk2K0/dHjDlJ90kppQ3HDljw4jvRSKQwgewqm//TMNom6SV/Zn9B49j0TW84TuL/kcvnk/EF6V6To294jI89pd3t9RTTEP3Prs81UZnK3nhhUfGvq1ZOmfJ8gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sp4arj9tp067qWLVXWYL09USNgkltjr88WB3LwYOZUI=;
 b=vy5yIrunqH+QxeCYM46P6Cj4/8Khm81PYO+ZkiXOW/KQX16VbiB1xUuqX5OtTZttvvTWQDN0V5f4SzM7rQBM9qrdTf4HY5qSkcQ3755XPiBibjVanU2bB3qfOaoLrGUPwpecRwjlPaY3TFIFLzLtlxsJ0cxMmvur6dGmmsW21fk4f/uZK7ARJ3nVsFKe9UA0/OSUq5kvzi16XRj15iTdPpIk1rDJZvRFKWecjC3MxXfCQ3rZXVnsWj+VWBVNPA8lohB9v9izisvjnP2QvyryxLNSj6RwFxfXjpgFISgCz8oZSpN6VsAcJMbw/4RevzW4aZ8kkqvDdUx3QDU5f8Wzmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH7PR11MB6724.namprd11.prod.outlook.com (2603:10b6:510:1b4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Tue, 10 Sep
 2024 21:26:19 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.7939.022; Tue, 10 Sep 2024
 21:26:19 +0000
Message-ID: <eced6aba-cef0-47d1-a200-3934dd483d94@intel.com>
Date: Tue, 10 Sep 2024 14:26:16 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] lib: Export the parsing functions and related data
To: Shawn.Shao <shawn.shao@jaguarmicro.com>, <linux-kernel@vger.kernel.org>
References: <20240910024751.1841-1-shawn.shao@jaguarmicro.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240910024751.1841-1-shawn.shao@jaguarmicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR04CA0005.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::15) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH7PR11MB6724:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d2a9a83-27b9-4095-043e-08dcd1df35e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TmZPVFZES29ZeWlJODR1S1JCNjVsdisrRzJrZ2wrSHd0QlFSWXVnekorMVF6?=
 =?utf-8?B?dWlKb1ovdXdPSHl2WnU4SVFyWVZ4ZHg1K1JaUTdxSlJkeU00dVRMUUhOQWdS?=
 =?utf-8?B?VXFJUnIzQXl1ZjRST0xkbTdVTGZTbExDT29oN1ZuVWN5Y2FjQkZwNDlGODVT?=
 =?utf-8?B?d0syT2cxVjhjYXR2VFpiMEswOXoxWmxwM1R1czlhZnF5ZlRFTmRqZEUvU1Vu?=
 =?utf-8?B?aFIxZkJYNVBnV1VYOGRhRllKMHVzZlZva24vUUZxZFpxZFRjd3FHdkR2VjZF?=
 =?utf-8?B?NzJNRllzOXB4WjJGajkyTWVXTXhuQjEzaUhGQkVWTS9ocEsra1lrcHptSFZT?=
 =?utf-8?B?UGxXTi9wR2pwdzBVZmZpOVpXRUlrNlhIUm1pQnVyYnl4ejJlc3YzaDkycmth?=
 =?utf-8?B?YWY5UEN5VFRJRVppVFdhUDd2RlE3djc0Y2VsTThpVnVwVFFSQnBRazJQUDdK?=
 =?utf-8?B?SDBNV0RGcVRNWTV0RUdKNDZiZ0p4bUZNYzQzK0NGM1RiajY0eFZMcmpqSndj?=
 =?utf-8?B?a1dBZkdsT05zVTI2NUVRY0xtdnNxZFBTcGgzbzdhaWY5N0FTMC9rSm5EaklC?=
 =?utf-8?B?MUptZnQ0YlNUY01BRk1sc2VFZ2RFVzVIVDBva1JrOEFYQTBrTWVKRURtMEFv?=
 =?utf-8?B?VkFzZ1YvNnptRm1YNXJFcVhCcnV4ckllSFVDamJ4SlNzd2lsSHJUMEVwdEpZ?=
 =?utf-8?B?NjlEWDRDamRMYUk0bjNOMlJFK0NnZUp3bTNQZHJURk82a0dPWjdqa294RG9u?=
 =?utf-8?B?SHV4OG1BenNWdnhuRkJMNE1tdndTeDJFOVlEUU1melhRa0NwcmRueUNMbTBr?=
 =?utf-8?B?Q0svNWFmUkRteStsSVZaekh2a0RuMU1NUHVjWnF1WDliWFNINVVkd2kybXl1?=
 =?utf-8?B?TkJ1M1BpNDRsRDBvVjgzSWpVZWdWZGt0dVdWRFNZSmgvTTBaZkY1cWFJRk56?=
 =?utf-8?B?SlF6eFN5RHdubitGZitNNVlsM2NDbVpzcnVnR3FVT2xlUThHTUd2VVBudW9B?=
 =?utf-8?B?eHhKdzZXY3JCa3paRDFCSStNaTlQS2hHL3lERmVyVk8wNCtWSXYxNXh1QnN0?=
 =?utf-8?B?emppSitQNnhORFFCOUhVVWdadklXVllQbmc3S3pNS0RQVSs0REZKOG9MellL?=
 =?utf-8?B?MFV3ZFd2Y3FNWXlYaHErc1prSlFnOUxmQ3ZyNDNPRXhhSXFaNXc0YWVFV2lT?=
 =?utf-8?B?bGNrL1FSQ05vajdZeHVBSnZUZ1hDSnRNQlhMZXBsUDFtNkNVT3FyY0dWVURE?=
 =?utf-8?B?NEJFNmZ5Rzc4UE5hckJDSGNNNytVVDAwaEV0RXg5aGgyQUdiWHVVOW5RRCts?=
 =?utf-8?B?Q3hEVzgxbjVJU3ZsZFBiS29UQ1lIYzFSWCtaZXdIdEZKMTFoN01kN2U2Ylhk?=
 =?utf-8?B?YnpGV0V1TXZFWHk0eTJVQS91NjlpL3BWUGNMbHp3Zk1Yb3M4RSs3ZG16L3c4?=
 =?utf-8?B?aFlUTGUrcUNsdjN1UDk3bGRtTTViODZtbWFUQXpsZUl4S2hyZzMwM2NuYW4v?=
 =?utf-8?B?ZWJWaWR6WHIrejMrRWFSYU9oMlVPdnFobkZKbUpaSW1mdmplREUycjk1WXZI?=
 =?utf-8?B?T3dWZE1jUkJ6bnZxVFYxbFhhT2RzOWRpVDhnMUFzUGxVRjhoUEFsS0FaalJj?=
 =?utf-8?B?a1VDMmNNVDNQMFp4QnpaM1FEYkVVTHQ1bzMwTHpBOVA2MVNGcWdZOWIxcCt2?=
 =?utf-8?B?S1FMTFZ6aDJNQXl3M05SbXdncUVKM2dYL09Vem94UTg0Q2NueFB0bWpEVHBw?=
 =?utf-8?B?S3NMUmhYbjF0aFFSYWR6d2xLbUl0bmJqTVBCSmVJNVVDc0dXcDEwVEVHaGc5?=
 =?utf-8?B?U0ozV21nY1Q1ald4aUlBZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VURtbXdNdVlVOGN0bHoxbE9VN0xpU29JUkYrWUY4U0dSUmxkWUtldlFlREhy?=
 =?utf-8?B?QUxOTmNzM1RncjZkd0t1UEhjbDRKK3dvekhwR0JBczFQV0hEbHhYaTBkVnBv?=
 =?utf-8?B?dmNybUtVd2ZiSWV0STVDYUNBeWg1LzdObS9oemk2bEhCN1c5VlpQbEdrL3o5?=
 =?utf-8?B?VG5Nanp5Nm41ZmpscE13bDNCK1RXVTNuc0xGS3hIVVl6bzJJZFllVUlqcC9i?=
 =?utf-8?B?NUZMTTZRQW1Ra0lxK1dzVmkyeXN4bTFuV25hVFJhQTlyRGc2MmhGRE0weW1t?=
 =?utf-8?B?SzFvWmRzTk5LaUFwRFgrK1NRNXpHTU9PRjJzRitUcENFcHBsVXJsZkhqbWk2?=
 =?utf-8?B?elFRa0RGNk9DRnYwT0RrTTlkUXptSzhrU3NwdllyemVQdFlpdmIrUDZ3TnFZ?=
 =?utf-8?B?eUR2bWtqYXc1NmtXN0EzY2NsVTJJWVhiNlg0MWhiaGZPL3N2MkdKTkVXc3Bq?=
 =?utf-8?B?ajJmRk1hczc1Y09KVDZEcExFdld6UEc1NzRFcFlBYVpTRE5rdWR4aWxjLzQy?=
 =?utf-8?B?WU52aTRFb1RmQlpOcDA2VnNQcVJ4N2tJSEYwYXlHTjdzajM3Yjljc3dENUMx?=
 =?utf-8?B?dHpYZ2tEN3pzNWNPRWZ3UW9mVFVvcmc1NmV6R3Bna0dlNkxVQ0QzTkVmWmdj?=
 =?utf-8?B?eXorNng1V3kzTTlxdmp5eVc0TWJ3RGtTck10UEtad3pLZUYwbzVzYnJ2RTdO?=
 =?utf-8?B?OXZKWk03WE1pdHR3bWxkYmIrZU1GTWpTRmYxcGtheHpsMDVzbjhiejJkL25B?=
 =?utf-8?B?N1llckZqMWp0MzVKc2dCSGM2THg1cFhBUFhJRlZ1aVE1QnlRakVOR3RGVmZk?=
 =?utf-8?B?OTVSUFRNemVHaG1NVHlSK1d4UFFEZi8zOWlGMEZSMVlIY3k2bFYvYkE5Y1ow?=
 =?utf-8?B?blRMcWk3Z2lwVTNueXdDZlR5NHdyZm1vY0FyaVdaMkRlZkFIVnhGVUt5M0t3?=
 =?utf-8?B?SjFzbWthNVFGUUJpcnVaWUxMWWowRG1oMVMrck5tZmJ0a0N2NDQvRkdLdURq?=
 =?utf-8?B?a2dtNStSM3Z4QzRocVJydW94TzVacWpmdE9pL0ZRVzRNb2Q2SWs5WXJnb21L?=
 =?utf-8?B?c1ZMaHNWeE1HSVhrMUFPTHZwTGV2eVlnbE9PbkIzYmV4RkJNYk8vTStHUEFH?=
 =?utf-8?B?OTFaeXhlNlpianZLL1JTdllVVFpDdFFldkxubWVHSUhSb0hQWmtVZHMrWVgr?=
 =?utf-8?B?YlNxa3c4eXJacmxqUlhpT1J3QUNBWkpPc3VjdHZ1TUp4anh0VVQ2TFZHVlJu?=
 =?utf-8?B?cmJ2T2kzbnJhYWh0L1lYR1FRYVJabU0zbzdYTlFHZ3U0QitqUWU3SGlGaWM4?=
 =?utf-8?B?V1lKNjJKSERRdlVrbW1yQWpHcUVnRjQ2aGZmT3RjNXNNVGwrOFRHTW1FWDd5?=
 =?utf-8?B?SEh5NFpzQUtHbEM5MWdDZ3Nxam1qTiszSUlQTHNqckM1b29kWTM0TXdUd0d2?=
 =?utf-8?B?UG96QlRJQ2t4M1g1cVVyK2xyVW9UdktiVDlSQjE2Tk9KaGswNFg5YXFpQzQy?=
 =?utf-8?B?U2JFZ2cweXdxeG9tZWJSWEZwK0JEOGxhSXBaU2ZyQ3c4TjVtR1FmdFduUEcr?=
 =?utf-8?B?U1VqL2pnVDllUXR4V0s4ZzlOc0Q5aFVBMDN4T00wQ3dTNXpqMTZyWEwyY1pE?=
 =?utf-8?B?Y2xxUnR4VWJRRklxaGFUeUZadi9BeFNhQnVBZGJ1YXlYMjdiZStoc3ZRUzUx?=
 =?utf-8?B?K0IxcHRsR1BxTXVNbkM0c1hxaUdMUjJrUWZNZ0pBM3hJT0JYQ0pKNDl6WjFP?=
 =?utf-8?B?RXJTd1hyMmUzYnIrYytHNUh0ZGxHWkVPamJRelQxcktreE00WE9XZldiZlha?=
 =?utf-8?B?aHpoLy8xYUhmbFRWTzdkYysxd3Y4RDVmQ1ZVeEgvZjMzdmw3b3BCaDJuREhY?=
 =?utf-8?B?eWNtUDh4RmlDSGlycVNkVTIxelg1VDJsZ3ArVjd1WFNwUURKMTFNUngxRkdT?=
 =?utf-8?B?ZHZPZDdVMExqaHdWbTBEN3phNlpHeUFsa1FHTFMvSUl1S1JRSVQxOTRiS3lI?=
 =?utf-8?B?TEZXTGI3cCt1UGpKV2NESHJDcEVzbUlsY3REVUUvU2ZxTHQ4a0IyUkdYZ1ZO?=
 =?utf-8?B?NDEyayt2a0NLeVRQRHU3aXdvUjRBV2lhb2dhQ0Q3NFo5SktPR3JER1BReDFM?=
 =?utf-8?B?YjhiNjY2T1AwNGNDQWZSVmZCZ0ltN25INjdObjlOMEJIVXlRWDdBQmlBK0NS?=
 =?utf-8?B?R3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d2a9a83-27b9-4095-043e-08dcd1df35e0
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 21:26:19.3954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0orLmTNLYkENEhIjQbo8JKVPIXXYi++gpQduRb8mmYcpnB344HqEkKT4Dg/lP9qSxafQi6PP3iumrjg95wcpf0G7rMsskg0fw+DUSUvloc8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6724
X-OriginatorOrg: intel.com



On 9/9/2024 7:47 PM, Shawn.Shao wrote:
> From: Shawn Shao <shawn.shao@jaguarmicro.com>
> 
> v1 -> v2: Updated the commit message, added a description
> 	of the changes related to `DeviceUpdateOptionFlags`, etc.
> v2 -> v3: separate the device_update_flags into another patch
> 

Minor nit, not worth a re-roll on its own, but the new title does not
mention pldmfw.

> The PLDM library is used to implement firmware upgrades,
> but the current library functions only support the
> `pldmfw_flash_image` function to complete a fixed
> process of parsing, sending data to the backend,
> and flashing (allowing users to implement custom
> logic using `pldmfw_ops`). However, this poses
> significant challenges for device vendors using
> PLDM for firmware upgrades.
> The following scenarios are not supported:
> 1. Only using the PLDM parsing functions, as the
>    current library does not support this operation.
> 2. The firmware upgrade process differs from this
>    fixed flow (the firmware upgrade process may
>    vary across different vendors).
> 	|-> pldmfw_flash_image
> 		|-> pldm_parse_image
> 			|-> pldm_parse_header
> 			|-> pldm_parse_records
> 			|-> pldm_parse_components
> 			-> pldm_verify_header_crc
> 		|-> pldm_find_matching_record (xxx_match_record)
> 		|-> pldm_send_package_data (xxx_send_package_data)
> 		|-> pldm_send_component_tables (xxx_send_package_data)
> 		|-> pldm_flash_components (xxx_flash_component)
> 		|-> pldm_finalize_update (xxx_finalize_update)
> 
> Signed-off-by: Shawn Shao <shawn.shao@jaguarmicro.com>
> ---


Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

