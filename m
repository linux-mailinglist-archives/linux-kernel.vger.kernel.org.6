Return-Path: <linux-kernel+bounces-555384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B8CA5B6BD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 03:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E0223AD78D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 02:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454ED339A1;
	Tue, 11 Mar 2025 02:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gTj2uQE5"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE4E3C0B
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 02:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741660251; cv=fail; b=SixWpK95XhZs5WH95IBCdkjv/rmhBDWffyWC2Q4PuuXLOHforfPEVvv7skjEaXw2aNzs9jIJn5lYhUTtOSJ5SobrBpW42+d5XmxGoXiJOSvQRJVXB3kVYE575JDbaiT1IIkyCeM8PMwBoRexLCwLcQFwj0QauL/IUPzeZ0zQrZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741660251; c=relaxed/simple;
	bh=UE5eziL3B/xl6mxzOuDTRr7+pQY63c3ewmF+aeladmQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UnCT/bkTMhcrzG/1iSVtbMlZIFMDcyiLdJ5ts0qNYhwtPzOeiyaY/3z5ovZCppBDzCj8CV4QMl4tAI1WHIFmSUWNZ07Y1OJ8MQAWO1mklRH/Ry+/bpPRbdKCWxi9wOdGNgjypamTbMwmdYFS6sMBHAw3e5KqmisADjmcow0jc4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gTj2uQE5; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741660249; x=1773196249;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UE5eziL3B/xl6mxzOuDTRr7+pQY63c3ewmF+aeladmQ=;
  b=gTj2uQE5Q8ku9h4RX5dOjScDK9tGFhBMNBIJ5o9H2RaruCz4fYwM22Ts
   tvv54MPLAe8RCTC1V8LnllUFcR65TlcX/QtmQnVN8xWfRxP1HsPF7uWRR
   cjGM1nfFc1V3bNUc3YdXaaaEDitnr1uJwAItuUBh4ORkQCvfCyF+fanrS
   V4kYTjS0zXzH9evMumomp7DkmGVEvJ5r+ESPUWJ9uv29PlrWaAwOv4gam
   Nv4qzoYKI+HdNogBCaVJS6QOp3+98BpIAsPBq5xYxjD5YVbBWEYNUg4OI
   K0nPOCM2Q9ztySlElj4KXgYzUDXQt03phcmr6O34KSYcd94ttAPb8Vchy
   g==;
X-CSE-ConnectionGUID: KBSqjNGkTXOltX99QYZPqw==
X-CSE-MsgGUID: 5lvC9odCSQO9kyzzL6XuIw==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="53322400"
X-IronPort-AV: E=Sophos;i="6.14,237,1736841600"; 
   d="scan'208";a="53322400"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 19:30:48 -0700
X-CSE-ConnectionGUID: YSXyr2sXT9ikMidTsb6p4A==
X-CSE-MsgGUID: p90NgBkMQqiw6b6Ez6vvpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,237,1736841600"; 
   d="scan'208";a="143363847"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Mar 2025 19:30:45 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 10 Mar 2025 19:30:45 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Mon, 10 Mar 2025 19:30:45 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 10 Mar 2025 19:30:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bKkVRco1z5dm3ybwubz9TM50DVLZTj68P4/PwbAp8pqNryIfwqbW+vZoRff5WLp60dZp+JW2/xcofOmjvAzTYia7D0WiqB2daO+3N7Nu9YsnfxuNyJr4sG7IvOvPbs9HtFluXQcBOIcoCTmE/QoFlDOnhwChW3O/9VIZCFaY1yXYUp1JQ7/bJ9HeOLpgLKolDqyXP++y35aS0V4DX4/PpViU5F3iCJHd8QBOkqXqENF1+emUQzYwrw/2rTE1vdC1kbbjReSXXBtUsSNIy2e3lQuQD4AEPYJrl5OFnpNWg2UBJV5LoAarNbKTSsz2oJK5iqK61QzSwbvqep5K15+FwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a1XoXDLnAjjiD/oSmz2heg3s44lz9SjR5qc9Z8WVxus=;
 b=r+UN2akPXzw47+J2jvTTKGsAqLEwJj7/o0oq3cQmvE09MNW+Vw87YjfeYsjUNKEuBMupGhD6ADjARap64j15qvTuZbrKjw9iNnVcfsK9s5u/82944Y9o0KCWbTYsbqNJHaNsDPmHVkbm97EGcU8tfRawPizE6GLqkKfgbxUKHy2dByUxjFOIthO9i47hwibJsyGcVJ5733EH6P3RWR/NIuqDpJcG9e/CtdpTRiecqtx0cNjqKxRUrpfp0O7eYRLVoSOcX9YrLtPOq+eOoxbktMNV1ZnLQfaOn9E0pI8cxfYtQfNZRKZLLPfAJQ66IKmrkas/TfbToqC7k7ZaqfcAsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CY5PR11MB6317.namprd11.prod.outlook.com (2603:10b6:930:3f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 02:30:42 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%4]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 02:30:42 +0000
Message-ID: <47c6a2cb-76a6-4e7e-b6e8-3896f78f2f65@intel.com>
Date: Mon, 10 Mar 2025 19:30:40 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [morse:mpam/move_to_fs/v7_bare] [x86/resctrl] 0021800a46:
 will-it-scale.per_process_ops 18.4% improvement
To: Oliver Sang <oliver.sang@intel.com>
CC: James Morse <james.morse@arm.com>, <oe-lkp@lists.linux.dev>,
	<lkp@intel.com>, Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>, Tony Luck
	<tony.luck@intel.com>, <linux-kernel@vger.kernel.org>
References: <202503102156.d70c4800-lkp@intel.com>
 <6cd8d37e-19bd-4fb8-8b91-e5b2c5f6f7e7@intel.com>
 <Z8+QEEKmnlLK4E/+@xsang-OptiPlex-9020>
Content-Language: en-US
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <Z8+QEEKmnlLK4E/+@xsang-OptiPlex-9020>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0359.namprd03.prod.outlook.com
 (2603:10b6:303:dc::34) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CY5PR11MB6317:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d819d31-8713-49e7-07d9-08dd6044b811
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SjlVNjRnZVhaTy9PdU1tdVBDOCtoVmMwWTNFaXNqL1lRNnY2cWNjdlZUTENI?=
 =?utf-8?B?WFZlbmo1TTNYcExtdERuOTZKbWJiNGJiaU5Cc2ZMdDFhU2pXeUsxOWkvTTV5?=
 =?utf-8?B?ZG9kK0hsVGtMNlhESzVkU3RwVkJhbWQ1S21IVWdlaFBrNVZxRFM5bUNqaGFk?=
 =?utf-8?B?LzhycW9lbVZmVTR4ai9KVEg0V2lUVGJFZzd3VnNBZEtqanZqOWllSGY2b0FU?=
 =?utf-8?B?MGFvSXJHR3pPMTlScjErSEdTOCtLWUhOOVBLaHNLaml1bUNtWm96aTRrWUJk?=
 =?utf-8?B?SFJ3bTBvUHVoL004TDlIRFZHVW4yQUkrUDdxQlphNUdzT280c2Y3dWZDM2Qv?=
 =?utf-8?B?dUxUb0FCUm9EKzl2WmhydVlUaWlvbnVEQzJYeDFNWXZwYnZ6R2MwUXEycVZB?=
 =?utf-8?B?UVExRFN6dzRGTktuckdxRVZKQ1VKeE9FNStmQXVtUWVlT1F2NTcvMnB5S3JJ?=
 =?utf-8?B?NHprSmg2S3ZvaEZ5RUhiRy92REdFWlR3NWRrY0NheUJPUzVuVG5DMWNQclkx?=
 =?utf-8?B?ckphSDZoQUtkZ3VuZ2xMdndVQnRNY2sybWNkR3MzWnd0b2tWdHpiTTUzc0pK?=
 =?utf-8?B?MjgzbzFzZE9nN1RPL2xFWVVNRlhKZXIvbGRBM1FLdFRMbFArdiswYjFWUEVz?=
 =?utf-8?B?Y2F1R1Y0UFpQOTBXVXFnUkZSTEdhZjJ1MmdhamdxdnhEcFhLdVdKRlBaSE5v?=
 =?utf-8?B?NGxZM0VORXdEeFlCSWJCR3RmK3BRMHBsaGtHSXJRR2E4T1FUMlRmaVNEZU5z?=
 =?utf-8?B?YlpUZXBOeXFhSFdWRE5Fa1oyVFdHTk1GeUJYZm80S0t1bUpZa2piT1ZjTzNr?=
 =?utf-8?B?L3lsNUNJR0J6WEFZS29yZUVGdDc0Qm8zY3R4cHNHMXduLzEvZGZKNW10Uisw?=
 =?utf-8?B?Y2tLbDhiNHZMRW1udW9ERnRaQWhhaHNia21TcDVjeEtyTVU1ZWZaVGowbEZH?=
 =?utf-8?B?YjVId2c0TDFNN2lZSERnRWRRUDdTQ1JueW1TWGZMMERRR0ZQRTdQYUFKTytF?=
 =?utf-8?B?V1l3MERrVytqSlkvTS9DQ3M1VHNCKzVQM0p5SUhNWTZwUWhIRllpdkhMMUEv?=
 =?utf-8?B?SzFqTklwY3ZJWnZzbERZQXBYRy8wK3hHbjlYRVl1RFMwYk9ybDQreHo1Mlh6?=
 =?utf-8?B?RWdXaWpNS3FpUExJb0QwRlBudlBRSm9aVlpkVXZ1VEpCQXBtaldSR0lXUzYz?=
 =?utf-8?B?cFVhbVFLWXBDa0MvNFoxNWVJVEkzdktJODdOTHNIMlNCcmZxZUVMS01TWFJi?=
 =?utf-8?B?TjJ6OUQ1UUIrWU55Uno0MTdPdytEY3VYeFcwMUdVT2oxU3hqRVRiOXg5NEpB?=
 =?utf-8?B?Y09GaWY3Y05uQWFKRUw1YjBUWW1hdm1VcnZOS0JtamFKR1k1YVJEbkZhNTNW?=
 =?utf-8?B?S1pvUW1jdzFkdXhmWU9qaWF1R3Fkd0VJaWNhVUxOaHA0TDllbVJNajlzN2hG?=
 =?utf-8?B?N1dPUytMZ3BQTVdVNUxzR3duaG53cHRKSi9EZEprcTcxYjRveS8xYXByczEz?=
 =?utf-8?B?b1BTY0NjMzRGNWUzU0pCbjFEdFg5T1IrUjlVWXBOSXJXeHB3cWRPdVkybHJM?=
 =?utf-8?B?UmRmc3p4V2FBc1VnYWRtTDRnZWpleFRFMnQvVVNhaUVKa1E1UUg1bzJIWkNV?=
 =?utf-8?B?ajBpd3c0bEhIV2wrR211dStGWXBOMjMyS1B1SFdTdU9LUVhuZVlDZllLdTdD?=
 =?utf-8?B?S1czZHFod1k5UDlCaWxVeldlVTkyWmlaV1BCU0VtMi94N2NKSlVETHRWWTBr?=
 =?utf-8?B?UFJrcEZvdHRHS1cyTkxLZjRjT20xM0twL3o3dW5icDJWUlBRV2J5VU1CSms0?=
 =?utf-8?B?RWhiaFB1VllIU3VDYWRlQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFhhc2phWmlxZjdHSkZmd09LUjNldXo1OE1CQUhiQStvYXgraTJZSHpITVc5?=
 =?utf-8?B?MmdTOVlmTWdTVlltZ2FnRVEwQ3NzaHY4bjVmU29ENEk4aFdWZ3p2OXJpVEJX?=
 =?utf-8?B?emhYR2FycG5Ed0YzWFY1NTR6MGhIMHpvd3BRNzdhQW1yODZBUG9hTVlaZ2JC?=
 =?utf-8?B?L1BHN0pSLzh1THFubGpxbkdmblE3cTd5RjhXN2s0VEhGamlTeHptQ1BWdWdE?=
 =?utf-8?B?TVpPcDk2YU0rTGliUFlPSjJkMFArV0M5MHloOTZBcHh0TUpmS001SU1EeGgx?=
 =?utf-8?B?MHFlVnloUnFwbE1CSDc4VFp1ZUJkSmtFL1Z5OWhFTjRIU0gxVWdPTElGWEpW?=
 =?utf-8?B?dzU5NHdNV2JHT0ViblprVE5oS1pZRElaSnN4TWNlTkdpV3BVcUwrKzF2VkFm?=
 =?utf-8?B?dmE1d0E4bXJnSUVZT3dibXpaR3J3eVRWcTZQN0RrVWpFc1M5bk9ESE1USGcx?=
 =?utf-8?B?WGRXYytzNlJRekVYbnAvek5aZW95b3hqR3lGT1lsRHVjaUFvbWpNOXZFNlVY?=
 =?utf-8?B?SXJ0NmcrWHlXMThZSnp3aTJ5Zkl3SlRDdzJWbUx5bDM4MW41SVBVeEorS3Ev?=
 =?utf-8?B?YUkwNURtN0ZRQXJGcnJNQ0ZOQ3VtcmlyYWRSK0gxOE4xYmRvWWRDOXcrZGZD?=
 =?utf-8?B?cVVvSzZRMkw0bDRGbmJaQnVZRnIxYzVWUVNoWVUzNG93eDJ4cFhTTllOajIw?=
 =?utf-8?B?N0xrZkE4bjZnTmxEZ2ZScGNUTzBudVhoZUF5TkVyUGJQTWF2cFdYY2NrUHJW?=
 =?utf-8?B?ZlUydGpXTUxDVndsZXJqWU1ZQ1k2TmhEMHR1b2hrS0ZJbTBISXJ4TzA4MXkx?=
 =?utf-8?B?dC9UeE5HcGtCK2xDbzlFb0F1OWFVVTFUL21GWkNoWmlvcXhVVnozRm5JVXpt?=
 =?utf-8?B?MklmMkt3ZE8vK01TRVRQZysrbXRIME5QNXJIYVluZ0JHdVRITjdIbzlrbWk2?=
 =?utf-8?B?TEdlNEdDV3RWcjA3YUF1VmttcG85NmIzM2dJWlJseE1jU29wb0hBLytZYmhm?=
 =?utf-8?B?SXFjTnpuVXVka2hkTjdaRVloZWVzMnUvNjh5WEJoSWp4endmOUZPRzVnL0Jy?=
 =?utf-8?B?c2VON1oweVVwb09EM09mRVloVTAvUEplN0dGRHBpZmZjeWlabVhEbmo2Nkw4?=
 =?utf-8?B?NU15ZzlyOFhzUGkwaTNNNXYyQkxoUmxXem95OElaSm8xTmFzT2NyWUxWajBs?=
 =?utf-8?B?dnFpbG81ZDZtbmowS3lzNTVFOXpXQVovdS8rSG01eDMvSXNPSWJsY0pCQVRE?=
 =?utf-8?B?SlZxVmxKdVhUMWFobVFQRndES0ZmZW8xQmhDVWJFVVJ2cWdOaVJCaE1wOERo?=
 =?utf-8?B?RlJRbUxmS0o5THFDVnlLbUhVN0x4WDdCZ01jc3o2cUx4d1ZheXNuMnYwdnpI?=
 =?utf-8?B?RjNsazRpa0l6Y3pLSm90V3dTZDlGYUJVaWY3LzNkeS9CV1M1NGNCN0FRVS9X?=
 =?utf-8?B?Y05rRUpvRUVOVHVxa3V5TmxTU0ZURHo4YVJwN0ZSM0kxck1pQUhCb0ozQUV3?=
 =?utf-8?B?dnpTNVc5VC93ZWhsRjdCVVpJZk9pVkJYVWg3NW0yRVprQXJ2VVFhWWE2OGpq?=
 =?utf-8?B?RDJUWHJvT0E3ZzJKbWF5NWdjQnZ5TGk3K2IvUWtzOWhlK1MzNmZYMWVDV3JP?=
 =?utf-8?B?a1EyQUE2dWdkRW1kNlZnZ0I1dk96Z3o5WkhNTitkVGpSeTZMQ2ZuQktTKzBv?=
 =?utf-8?B?Q1ZoVHdJcDBSUmZCS0FJQzJNRUhtQUpUUWQ0UkJNUzBEVlh1S1BjSVlXUzVZ?=
 =?utf-8?B?eGd2c3dHNXJUb0d6REZwTTNpNTh4M1dBQVN2TUdVY0lWeDBWK2xmUU5uZ3dz?=
 =?utf-8?B?Z3cxTHRSU28yS3l6MGxQWkhqTjJWZHN2VDRDandKeDhLUWZFVkh3VTVDVWlT?=
 =?utf-8?B?a09oVWJ6TVA1cDN2M0cwRjhXc0ZzbDg0WDhtSFU0VDJBaWtGRVJtVlgxUTJN?=
 =?utf-8?B?M01WZkFTRWc4K1QwY2kwaTZYYVpZYmNYOGVxUGZkd2VEbks0MUNVcVdDdHlt?=
 =?utf-8?B?aVBXWitGbjdWdW93MEZvVEpSOU03TG5BYy85QkwyRkk3RWVSUXJXVHRMRllj?=
 =?utf-8?B?Wlk3NHEvbkV2dEJDeUVJckh3SC9DMG5kaXpJemplQSs4bVpJOHF2TXBuUm1J?=
 =?utf-8?B?R1BWSDQwZm9NM0FJckIvcUxDaWFrb09pS1o1VHpIbVdYMTlVUjROb081QXla?=
 =?utf-8?B?QUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d819d31-8713-49e7-07d9-08dd6044b811
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 02:30:42.0100
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T4ldz93uMSvvXwO8pMUqSZlfKwbab6eqMpLlUt//laxoRigohdjVwV7aHwMgeRyU2utzsTLe7fM7iXgLDUEtLqTU3eO08rqYgeNP7dxizfQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6317
X-OriginatorOrg: intel.com

Hi Oliver,

On 3/10/25 6:21 PM, Oliver Sang wrote:
> On Mon, Mar 10, 2025 at 02:17:51PM -0700, Reinette Chatre wrote:
>> On 3/10/25 7:06 AM, kernel test robot wrote:
>>>
>>>
>>> Hello,
>>>
>>> kernel test robot noticed a 18.4% improvement of will-it-scale.per_process_ops on:
>>>
>>>
>>> commit: 0021800a465d495a536265c52f8a031da43948ed ("x86/resctrl: Use schema type to determine the schema format string")
>>> https://git.kernel.org/cgit/linux/kernel/git/morse/linux.git mpam/move_to_fs/v7_bare
>>>
>>> testcase: will-it-scale
>>> config: x86_64-rhel-9.4
>>> compiler: gcc-12
>>> test machine: 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 512G memory
>>> parameters:
>>>
>>> 	nr_task: 100%
>>> 	mode: process
>>> 	test: signal1
>>> 	cpufreq_governor: performance
>>>
>>>
>>> In addition to that, the commit also has significant impact on the following tests:
>>>
>>> +------------------+---------------------------------------------------------------------------------------------+
>>> | testcase: change | stress-ng: stress-ng.usersyscall.ops_per_sec 18.0% improvement                              |
>>> | test machine     | 224 threads 2 sockets Intel(R) Xeon(R) Platinum 8480CTDX (Sapphire Rapids) with 512G memory |
>>> | test parameters  | cpufreq_governor=performance                                                                |
>>> |                  | nr_threads=100%                                                                             |
>>> |                  | test=usersyscall                                                                            |
>>> |                  | testtime=60s                                                                                |
>>> +------------------+---------------------------------------------------------------------------------------------+
>>>
>>>
>>>
>>>
>>> Details are as below:
>>> -------------------------------------------------------------------------------------------------->
>>>
>>>
>>> The kernel config and materials to reproduce are available at:
>>> https://download.01.org/0day-ci/archive/20250310/202503102156.d70c4800-lkp@intel.com
>>>
>>> =========================================================================================
>>> compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
>>>   gcc-12/performance/x86_64-rhel-9.4/process/100%/debian-12-x86_64-20240206.cgz/lkp-spr-2sp4/signal1/will-it-scale
>>>
>>> commit: 
>>>   a13ae432a6 ("x86/resctrl: Use schema type to determine how to parse schema values")
>>>   0021800a46 ("x86/resctrl: Use schema type to determine the schema format string")
>>>
>>
>> It is surprising to me that these commits make a difference in these workloads. I searched around for resctrl in
>> https://github.com/intel/lkp-tests but is seems as though it runs the resctrl selftests only and do not
>> use resctrl as part of any tests reported here. From what I understand, by not even mounting resctrl, these tests
>> (a) do not exercise these code paths, and (b) do not use resctrl to control resources allocated for these workloads. 
> 
> thanks a lot for education! this could be an alignment issue.
> 
> since we found similar performanance impacts on different cases, so made out
> the report FYI. seems a false positive. sorry about cost your time to check.
> 

I think it is important to understand this behavior, but unfortunately I cannot explain it by
considering the patches identified. resctrl can only be built into the kernel so indeed may impact
alignment.

Reinette


