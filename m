Return-Path: <linux-kernel+bounces-428419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1B99E0E16
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 22:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EA3C282026
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 21:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C5B1DF733;
	Mon,  2 Dec 2024 21:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bIGZydCD"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89186A50;
	Mon,  2 Dec 2024 21:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733176071; cv=fail; b=m0Q9e+rDuMPFeiivcUb07y5W2FgpW5vsIfRJwcEHyJSJVgigrTmsLarBSziKDi0+knhcy2l6HZIF2jHgWoKVd82fneR+niNKgPh/E0a/mozJY2HWxUk64Aoe35CLnbAahH7iw/NjuxQI/TM57OoTH9dJE+1pT+C4zHs6t2Qa3RU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733176071; c=relaxed/simple;
	bh=jsfShFk24Vh85FiU+u39mOAXDpw5PJJsx5n6w3bBK50=;
	h=Message-ID:Date:From:Subject:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OyphTyijdylbdAEHp3enG85+Jw0Rgn7egufRMtHPty+/1s/6838ITNqAahElJIDWwVkpy0ce5NOYU5MYpXe29ZSLXm8saabtBBm5aR+tYMSbWmPoEtqxscG4amWwJI4dISt5crpFQp4h6gtVxAAtx3tgWav+aGbVZwbsD6nQRTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bIGZydCD; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733176070; x=1764712070;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jsfShFk24Vh85FiU+u39mOAXDpw5PJJsx5n6w3bBK50=;
  b=bIGZydCDF5UATsPmfiabskBPn8Z82/ApfB2oJJrpzPLFyuebPLqXZOBv
   8luBeO7FhTOEU/I3WCAPf0CX2uhZ4E3wm3rpE3rPliv9Zg7AB6DA8pbwv
   zp5unnh8VIAT1LSY1BSSjt9lPXEMpBz2NYQTFIxAkSN34U7K5AiODGSR8
   gKkZTdyWc0jtLaUVEoDsYum/Th3zdS7LmqzxtZzyALbvnuw+h5cfp3t8l
   v9DzyhTRW+NOZ3mxou/DEEQK+8zGWDwpbJcGFJduJi1jRLCgDgPgkXqMF
   vD78e9aRNwf8uZkEt8fTyV7KsCeifDYuqSdyWHfM/B0mZZwmLGgaxqtpJ
   w==;
X-CSE-ConnectionGUID: FHWVWvyAR+2E5IGcP62gBQ==
X-CSE-MsgGUID: k2WfM9xqQCGfbx8qZ98qtA==
X-IronPort-AV: E=McAfee;i="6700,10204,11274"; a="33284001"
X-IronPort-AV: E=Sophos;i="6.12,203,1728975600"; 
   d="scan'208";a="33284001"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2024 13:47:49 -0800
X-CSE-ConnectionGUID: ZCEarEctTD2mwcHe3t3y8g==
X-CSE-MsgGUID: pquBFV/FT1ybqoUGbSoCFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,203,1728975600"; 
   d="scan'208";a="116490299"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Dec 2024 13:47:48 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 2 Dec 2024 13:47:47 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 2 Dec 2024 13:47:47 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 2 Dec 2024 13:47:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XmdTjv+5aL8iLc7RxIe9JU3tlntmSpdLh+rQLKyOZTMwZy/KASGnJ6xONLExaC+gVgt/B/QGdS+AYlfXlM+noxECBF/kpclAtOpjd6UoOdWgo4mJ9npS//dR7bqbqZ1bYV8YgeSeBLqBRRBDToSzI7RJO3CpYtxTRHBl/6oIOnrEOLg0OHA1iTCcyoMZSsJu3LUuOsVtIp1qBYeCE95CYZq35NLs03EqXXZ0Voa51NL70mqw8/ZbM1PpPn+nk4i4KbpOMJgVYtHe4uHU+GTN4nOOIhLpuViCO0Svy3okKvK4KkH640qh9ggy43JklgjuTb2O5n5BNwPx46mB1yUvDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EWMFWsjmeP3s1pgTRva3vhTDP79t2V1R8/udVMluzcY=;
 b=imQHu12YbAUFnSO8uytWOH56Y1il3MQFp7jjZD9YM8yxxyy3yObuRXxp/ecucn3dozP5mz259/JNn89SfhNl6kV3xjAPbo4tPMGvXCa8AvLqM5X1FwZkYVyxr1Nl/dbMjVtghlVSH9Y+ua9OZpFsNX1v5x+trTPpKoS55bDtEGLaQ/MQSbP6mVsngGkgVmThRNELTxz3nBlAvF+IZ3/t8MWuV0lEm1clbD4eZ4R0R1A1mzIZPgZSDI35pJvkajNADKzg+dgIccwS65Uf6uIj5iU9WfTrOye7USCJOKAL0ZO8C4epSDsRwLuMfw9vLMMjW2fFUIq6BTRnuxn29YhbSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA1PR11MB7855.namprd11.prod.outlook.com (2603:10b6:208:3f8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Mon, 2 Dec
 2024 21:47:44 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%7]) with mapi id 15.20.8207.017; Mon, 2 Dec 2024
 21:47:44 +0000
Message-ID: <10a197e4-bfa8-4d42-a229-b755378781b0@intel.com>
Date: Mon, 2 Dec 2024 13:47:41 -0800
User-Agent: Mozilla Thunderbird
From: Reinette Chatre <reinette.chatre@intel.com>
Subject: Re: [PATCH v9 14/26] x86/resctrl: Introduce interface to display
 number of free counters
To: <babu.moger@amd.com>, Peter Newman <peternewman@google.com>
CC: <corbet@lwn.net>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<bp@alien8.de>, <dave.hansen@linux.intel.com>, <fenghua.yu@intel.com>,
	<x86@kernel.org>, <hpa@zytor.com>, <thuth@redhat.com>, <paulmck@kernel.org>,
	<rostedt@goodmis.org>, <akpm@linux-foundation.org>,
	<xiongwei.song@windriver.com>, <pawan.kumar.gupta@linux.intel.com>,
	<daniel.sneddon@linux.intel.com>, <perry.yuan@amd.com>,
	<sandipan.das@amd.com>, <kai.huang@intel.com>, <xiaoyao.li@intel.com>,
	<seanjc@google.com>, <jithu.joseph@intel.com>, <brijesh.singh@amd.com>,
	<xin3.li@intel.com>, <ebiggers@google.com>, <andrew.cooper3@citrix.com>,
	<mario.limonciello@amd.com>, <james.morse@arm.com>,
	<tan.shaopeng@fujitsu.com>, <tony.luck@intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<maciej.wieczor-retman@intel.com>, <eranian@google.com>,
	<jpoimboe@kernel.org>, <thomas.lendacky@amd.com>
References: <cover.1730244116.git.babu.moger@amd.com>
 <5d426af4-a947-4115-b7b7-4eeecfa13fec@amd.com>
 <c587f94a-7920-49cf-94b1-4c52140db914@intel.com>
 <ef92f1fb-086c-4ee1-b8ec-e08ed68f963a@amd.com>
 <e065b193-dbcc-451b-98db-68a5a69e6ae0@intel.com>
 <20959b58-a882-4ef7-bd11-e8bb0a998945@amd.com>
 <1a93f4e3-d3d2-4764-90d1-728b9cb70481@intel.com>
 <36d8fe9f-0000-4d0d-a097-efddc3881a2a@amd.com>
 <5aa7924d-b27d-4ee6-b8dd-4bae0e25267b@intel.com>
 <CALPaoCj+zWq1vkHVbXYP0znJbe6Ke3PXPWjtri5AFgD9cQDCUg@mail.gmail.com>
 <4bf82744-da09-43c3-b8f1-7fc203d1c1c3@amd.com>
 <CALPaoCjL6FEmVgX-h3_GQEVZNAT3FcH34t9o1PwbUacVzXjZPg@mail.gmail.com>
 <18adb251-b340-4820-a808-e1583b44480a@amd.com>
 <5a08b85f-af79-4294-b953-5957503e2caa@intel.com>
 <5a8eaf67-baaa-4278-abe5-cf68f795d4bf@amd.com>
 <c9b0115e-d994-4239-b2b2-12359878ec7a@intel.com>
 <03b5f7f2-d347-44de-85bc-0a346651d487@amd.com>
 <83abb31a-c2a6-4319-8b56-174b7848f4ec@intel.com>
 <bc26b599-0a0e-46f0-bfda-83330a34293e@amd.com>
Content-Language: en-US
In-Reply-To: <bc26b599-0a0e-46f0-bfda-83330a34293e@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4P222CA0007.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::12) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA1PR11MB7855:EE_
X-MS-Office365-Filtering-Correlation-Id: 690b9489-9aea-42e8-6934-08dd131af440
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MUk4QVZiMXdwL2tLb3RwM0VaQWdpS2JVckswZytCeEhqUm4rQjdLTml0OFM0?=
 =?utf-8?B?YTUxMDFXTHBHeW9aWlZTT05ITGtuaVFFM2wzWUtiU0ZMeE4yaFR5bmc5NFor?=
 =?utf-8?B?NnBnZjVpR3FCcUNCMlNTdDVTcUFXNzRtUDRMZit4dGIzbVp5eHl0dThDeUFm?=
 =?utf-8?B?QVNhUDQ5Qm9qR2JiS3F5aDB0eEVoMDRRR3JRL0NoZDVzazJTSVd6NVQ1ZXNv?=
 =?utf-8?B?SVdzdCt6MC8vSlFKTWdtVkRra2N5U1ZzK3RkcktBcHNLTWhqY2hxUVJlRHFQ?=
 =?utf-8?B?RFVJdXR1UVlCVTBPclppWkw3akprMEk4VjBzNG9BMm5pbW16cmdKT0pQMDBu?=
 =?utf-8?B?ODNiTitnOEhKaDhsS05vSXlva3A1bklLd3lGUnpZcFNpMHZwdlRIZWxlWmRF?=
 =?utf-8?B?Y3VHaDhtZ0ZYa0JCYXhhNThIZXRRQW92eU5LYzRxMWR1MFZaa1UxY3cydlB1?=
 =?utf-8?B?S1VGUlNqd2VIM2ZMODRxS0V2WHJld3hrM3F5TGE2RE00RFZ3M0NiRHZSUWZI?=
 =?utf-8?B?amtPZTRQQmZId0tUS1U3YW1tNmY0TDNwbnUxVHBPUHplUWJQc3B3VHkvclZZ?=
 =?utf-8?B?TXZlbVMyKzBDUXJSc3BveUpCWDloY0MvKzl4ajRLWmhTaExaTHloTW9LbHpn?=
 =?utf-8?B?RFBPNUw4KzBYclc4WnB3MmIydkxvaFBRUGh0QnhPbU92SCs2MWRPcTZJc09T?=
 =?utf-8?B?VVlFdE14eWN4cjcrT3J3OFNpZFVWVFNZbEJldVYya2FrQitMS0ExSWJMc0g1?=
 =?utf-8?B?cnFLZVB6bjB6WmFuMERLMU9hR3licnNjWWJXUlEvQml0ckxrbHY0ODJibWRq?=
 =?utf-8?B?VHMwQjdxUEc5ZXZFNitoMWJSQ1NRaGRZNGVGeDhnOVY5cThqY2RPWlkzTFhV?=
 =?utf-8?B?cUZOTlNEdEZuZ24ycitoN0k2dVhEQ21haFZVNkJLSW90NzVkRW1yVmwvaWxs?=
 =?utf-8?B?ajh2a2RmOWFjWFFkSlJpNDB4eEx2RjZQaCtRTTJDa3BVWklJUEJQRmo0MWN6?=
 =?utf-8?B?Vzd3VzBhOVlEWFo5WWFPeU43ejBJc1hQSXVSanlwSjdwbFJPem1tZkprTVJN?=
 =?utf-8?B?K0FRajBxL28xVC81eHBINGdsMS9vbDFERk9Pc1ZBTDUvbXh5N05VZ2RGaFhh?=
 =?utf-8?B?QnhzMmVvN0Y1b0ZUSzI1cDhLNlFNNFgrZjRsVDdIclJtVGdxK29qcFlaeEk0?=
 =?utf-8?B?R3dNUTA4MytZbVI2SzVzMkFBRkx6bmoxZ2dmWndURXBMVkJkQkhQKzMxZnp3?=
 =?utf-8?B?cEVIUmFKakZNU2JpdzR5NUVlUTRPUkFTc2QwVSs4K0txV212Z2dvL2VXUXZY?=
 =?utf-8?B?RjFZTzV0dzY2ZVEvc0cyTHhRMnAzR1B3NG1ZclMvYXNyRVlyeVV3blAyUERi?=
 =?utf-8?B?bzVITjhLT0xWaEFaVVVFYi9xUDI4SElZQzlaa2FvUExVcFpNK01vSzVPN0g0?=
 =?utf-8?B?bE9MTWc1THNvQTBCd2FwTitXeDIxMjMydmFJYnJBUXFESHBZOStXQkhGMm1k?=
 =?utf-8?B?NDdsK0tSbG52YWNwUW01NVJhTVFxRWh6eUVXdWJBZVFPVnpRU1I4VGdYZ0JS?=
 =?utf-8?B?ekhqNjQ5UXRoZU9NaTEzdUhhWXFWY2J0dWF2YjZaYWM4dlVmb0xCUFhOWnQz?=
 =?utf-8?B?VzhFTlZjRTBKZjVNVk42aXNzNGtBaW5COXJkc2wyL0FtV2VGQWo1c1ZMSGta?=
 =?utf-8?B?OS9wMkFZak5zVVNMSkhGVkJ4dzhicS9PN3JKMTV2b1lOcWxzRWcySG5mbzEv?=
 =?utf-8?B?L2lEd3k1NHRsaFZYRmVLdUc4YVM1YStPb3Arc0EwTEw4NEhUamFma0ZLVVN1?=
 =?utf-8?B?a1l3aEtEWHliVnpmOXZKUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFRPR2NGaDNxQ2xNbE4rWmV6cEpwQ09vQ1hha2l5cFZuMHBCaVpTc2l0b2ww?=
 =?utf-8?B?blZNSzN5ZHYyUEdDZnFIb2VLOHhaNHpMK3RDK0pJSWhRQ1JtQWw2Y04vS0hX?=
 =?utf-8?B?WkhIUXNaeWN3Y0RMVjdhblRKS004aGFuSFRtSitHWHdSdmNWMSsraGE5Z3Ny?=
 =?utf-8?B?Yjl6N1Zxb0hXOXBQU3dIZGo4b0plUEQyUVNKQnBaaUxlbHJWMHJDQ2ZkVDlP?=
 =?utf-8?B?Nno0UFBrcUsweFR3NXlCdXY0TGdaS3N2WTkrdWVGM2c0YXZkREdjMWZKTGVx?=
 =?utf-8?B?SktsSC9JT0lyeml4UGYzS0tzTXUrUDN2b1VXQ2FqQkExSlZaQ01IN1lJY3hp?=
 =?utf-8?B?NWpDYThEbW1COCtPZncwMlIvVkgwM3VFRHNublNKYjBHakVUaGVFd29zeVVZ?=
 =?utf-8?B?ZlhabHlvS0hiS0swWWo2YThRVUFDR3RmbWxFVFJyS2V6ekoxcUZBWGJEbkRi?=
 =?utf-8?B?UHRUdmJHUEZlb0ZTTS9YVU1IMU02M3MwRTZRYzdvdHM1ZXdVNDVubDMxZytR?=
 =?utf-8?B?MnlKQ1h6aHhTUVV1ay9iNkdpNVRIeFkwMGk5TlluVXdsVGpYcVBjQWdrejcx?=
 =?utf-8?B?NnM1RmRIdTZja3RYOFZPK1dWUUZsNkx2VEdJcGhQanFOdXpuMndCVzdlcGd2?=
 =?utf-8?B?SFg1a3A1ZllKa0hDbUZBalJ0MEswblJSMDU4Zm1uczBRci92T3RsNlpBbEpl?=
 =?utf-8?B?MmRxcEhhOXZwQUg0dyswNzhzUldpSlVTcjFvSmdId0ZLSUNFdnBWcElpNFVB?=
 =?utf-8?B?TGN2aExUck5UYWh0YjBSbC9qV004bkNWK2hnZlhpbC9SSmhZK3NYUEw3UFU3?=
 =?utf-8?B?UHdaK0RqdlFNTXBWSXI4QTdoRlNtQ3JFcmk0WCtFamkwRkRDUU1pVXkvb0Nw?=
 =?utf-8?B?eWxlU1hBcUdmTGNMZXhIYllQSHRtL0NvdC9FL0VYRTFwZGJxQVkyV21QeVJp?=
 =?utf-8?B?Q1FJS2I5d3B3KzV2K1ZsdzE5ZDBOY2FFQ2RweHVDWEhzQ1FjSkdRVnFmWi9n?=
 =?utf-8?B?bXZLY2g5OUJQR3JYSlgrWHBZSkM1T05QSzNUSzNnbEtrQlloK0NDNVVPczla?=
 =?utf-8?B?OU1JMjgzUGFrUk9lSlJhemNTU0RVVWtUTUZ2Ujk3TTBUZm5ManplVm1Ld2RT?=
 =?utf-8?B?ZjhLU3RrTFFLRTVmeDUzVXhoRk00emVWM1RQaHVuc1RGaDZWb2R4UHJiRWZ4?=
 =?utf-8?B?amNoM3NJQWxWMzRaSEl4MXlqV0x3UGhKb1dyREc0K2pJQnlNZEJxVTdzZEpL?=
 =?utf-8?B?eU03Zk42U3ZNZnhoamNZOTJiSWo2ZnlrRnhWTXd3MCtIdy9kaXBCN3U1OHlC?=
 =?utf-8?B?V0tVT2RDMFZPN0lSNGFMMDF4UFRFeWhkVCs4STBpbEhIQlRvOEhFRVVQZFhH?=
 =?utf-8?B?OTYrSE43Q1ZBQ1RjamhBRVRVM3Q5SVpQY1E3aHhIeVZrM0toZEtYWmp1a2Jn?=
 =?utf-8?B?OTlTNXc1ODN5Q1RKS2FPUHZONCsxclhORFlqOWJSTmtmMW9EWTZ6bHRybVFT?=
 =?utf-8?B?U1kwejFnd2J1V1pCV1N4bXU0ZlNvd0VsSTlKdjkwUnpsc2dmU0szcXFrcEgy?=
 =?utf-8?B?aUtINnBpUGNSWXhIU29EQlU1ZEFURGRGKzhaWnRSYzRjYkNiK2M4VFFJa3N3?=
 =?utf-8?B?WXZFU2VNcWpqL0N2QUM5aktUbmZkMFJXbmczb2xaOTIyNHM3ajByUXVhRVF5?=
 =?utf-8?B?WEl5OUtNL1h1ckRNZWQxNFl3cWphK0hoZEQvNVI2dGt3QzNvNXRWRTZuUTlG?=
 =?utf-8?B?bTlZYkZwNitpOTcwRnlIUk9PUU9uSE82cnZWd2p5TW9HZHFhczVuelN1TDVt?=
 =?utf-8?B?dC9NUXhTT0hVSDdoN0hkNnN4YU93Y1FWMTIyWkNJb3gwUnA0ekhZdi9LUTBp?=
 =?utf-8?B?bXQ2ejQ5b1ovNTFtL2VEQmlvZXFuMVg3SVRsM3ZaL0oycnBHS3VHRUJxSFhk?=
 =?utf-8?B?ZHJOakN4OVhONGdSTFFuV0VtTlZxQmlkTzYxN0xpeVN2TmNURTg2RjVUL3Y2?=
 =?utf-8?B?ZkNzOUo1SVpLd2ZWQ2poUlhhTjBBb2hucGxHQmUrNXNKQzF6UmJtZWFUeEpo?=
 =?utf-8?B?VzFwVWNSY3RDNlRRYWE2RUlrME9ROHdkMExYOXJjVFFUYzBFYXlmdUxKRUgx?=
 =?utf-8?B?V3ZQSkREYk1VS2ovM3lpbTZDMVd1RCsrYy85V1JrUVoxZnBKejlSWG42YTEz?=
 =?utf-8?B?dVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 690b9489-9aea-42e8-6934-08dd131af440
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 21:47:44.6534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qubqtqi/MLi7MnCK1YvnaQt3uhuRH6dQHsA/MkX1+YBccE+Q5umZabdhT8ZzdUigzcRBEvMGfwrPepkPLe2EN3eo+UgyNc6CHysAgJtjg+U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7855
X-OriginatorOrg: intel.com

Hi Babu,

On 12/2/24 1:28 PM, Moger, Babu wrote:
> Hi Reinette,
> 
> On 12/2/24 15:09, Reinette Chatre wrote:
>> Hi Babu,
>>
>> On 12/2/24 12:42 PM, Moger, Babu wrote:
>>> Hi Reinette,
>>>
>>> On 12/2/24 14:15, Reinette Chatre wrote:
>>>> Hi Babu,
>>>>
>>>> On 12/2/24 11:48 AM, Moger, Babu wrote:
>>>>> On 12/2/24 12:33, Reinette Chatre wrote:
>>>>>> On 11/29/24 9:06 AM, Moger, Babu wrote:
>>>>>>> On 11/29/2024 3:59 AM, Peter Newman wrote:
>>>>>>>> On Thu, Nov 28, 2024 at 8:35 PM Moger, Babu <bmoger@amd.com> wrote:
>>>>>>>>> On 11/28/2024 5:10 AM, Peter Newman wrote:
>>>>>>>>>> On Wed, Nov 27, 2024 at 8:05 PM Reinette Chatre
>>>>>>>>>> <reinette.chatre@intel.com> wrote:
>>>>>>>>>>>
>>>>>>>>>>> Hi Babu,
>>>>>>>>>>>
>>>>>>>>>>> On 11/27/24 6:57 AM, Moger, Babu wrote:
>>>>>>>>
>>>>>>>>>>>> 1. Each group needs to remember counter ids in each domain for each event.
>>>>>>>>>>>>      For example:
>>>>>>>>>>>>      Resctrl group mon1
>>>>>>>>>>>>       Total event
>>>>>>>>>>>>       dom 0 cntr_id 1,
>>>>>>>>>>>>       dom 1 cntr_id 10
>>>>>>>>>>>>       dom 2 cntr_id 11
>>>>>>>>>>>>
>>>>>>>>>>>>      Local event
>>>>>>>>>>>>       dom 0 cntr_id 2,
>>>>>>>>>>>>       dom 1 cntr_id 15
>>>>>>>>>>>>       dom 2 cntr_id 10
>>>>>>>>>>>
>>>>>>>>>>> Indeed. The challenge here is that domains may come and go so it cannot be a simple
>>>>>>>>>>> static array. As an alternative it can be an xarray indexed by the domain ID with
>>>>>>>>>>> pointers to a struct like below to contain the counters associated with the monitor
>>>>>>>>>>> group:
>>>>>>>>>>>           struct cntr_id {
>>>>>>>>>>>                   u32     mbm_total;
>>>>>>>>>>>                   u32     mbm_local;
>>>>>>>>>>>           }
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> Thinking more about how this array needs to be managed made me wonder how the
>>>>>>>>>>> current implementation deals with domains that come and go. I do not think
>>>>>>>>>>> this is currently handled. For example, if a new domain comes online and
>>>>>>>>>>> monitoring groups had counters dynamically assigned, then these counters are
>>>>>>>>>>> not configured to the newly online domain.
>>>>>>>>>
>>>>>>>>> I am trying to understand the details of your approach here.
>>>>>>>>>>
>>>>>>>>>> In my prototype, I allocated a counter id-indexed array to each
>>>>>>>>>> monitoring domain structure for tracking the counter allocations,
>>>>>>>>>> because the hardware counters are all domain-scoped. That way the
>>>>>>>>>> tracking data goes away when the hardware does.
>>>>>>>>>>
>>>>>>>>>> I was focused on allowing all pending counter updates to a domain
>>>>>>>>>> resulting from a single mbm_assign_control write to be batched and
>>>>>>>>>> processed in a single IPI, so I structured the counter tracker
>>>>>>>>>> something like this:
>>>>>>>>>
>>>>>>>>> Not sure what you meant here. How are you batching two IPIs for two domains?
>>>>>>>>>
>>>>>>>>> #echo "//0=t;1=t" > /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>>>>>>>>
>>>>>>>>> This is still a single write. Two IPIs are sent separately, one for each
>>>>>>>>> domain.
>>>>>>>>>
>>>>>>>>> Are you doing something different?
>>>>>>>>
>>>>>>>> I said "all pending counter updates to a domain", whereby I meant
>>>>>>>> targeting a single domain.
>>>>>>>>
>>>>>>>> Depending on the CPU of the caller, your example write requires 1 or 2 IPIs.
>>>>>>>>
>>>>>>>> What is important is that the following write also requires 1 or 2 IPIs:
>>>>>>>>
>>>>>>>> (assuming /sys/fs/resctrl/mon_groups/[g1-g31] exist, line breaks added
>>>>>>>> for readability)
>>>>>>>>
>>>>>>>> echo $'//0=t;1=t\n
>>>>>>>> /g1/0=t;1=t\n
>>>>>>>> /g2/0=t;1=t\n
>>>>>>>> /g3/0=t;1=t\n
>>>>>>>> /g4/0=t;1=t\n
>>>>>>>> /g5/0=t;1=t\n
>>>>>>>> /g6/0=t;1=t\n
>>>>>>>> /g7/0=t;1=t\n
>>>>>>>> /g8/0=t;1=t\n
>>>>>>>> /g9/0=t;1=t\n
>>>>>>>> /g10/0=t;1=t\n
>>>>>>>> /g11/0=t;1=t\n
>>>>>>>> /g12/0=t;1=t\n
>>>>>>>> /g13/0=t;1=t\n
>>>>>>>> /g14/0=t;1=t\n
>>>>>>>> /g15/0=t;1=t\n
>>>>>>>> /g16/0=t;1=t\n
>>>>>>>> /g17/0=t;1=t\n
>>>>>>>> /g18/0=t;1=t\n
>>>>>>>> /g19/0=t;1=t\n
>>>>>>>> /g20/0=t;1=t\n
>>>>>>>> /g21/0=t;1=t\n
>>>>>>>> /g22/0=t;1=t\n
>>>>>>>> /g23/0=t;1=t\n
>>>>>>>> /g24/0=t;1=t\n
>>>>>>>> /g25/0=t;1=t\n
>>>>>>>> /g26/0=t;1=t\n
>>>>>>>> /g27/0=t;1=t\n
>>>>>>>> /g28/0=t;1=t\n
>>>>>>>> /g29/0=t;1=t\n
>>>>>>>> /g30/0=t;1=t\n
>>>>>>>> /g31/0=t;1=t\n'
>>>>>>>>
>>>>>>>> My ultimate goal is for a thread bound to a particular domain to be
>>>>>>>> able to unassign and reassign the local domain's 32 counters in a
>>>>>>>> single write() with no IPIs at all. And when IPIs are required, then
>>>>>>>> no more than one per domain, regardless of the number of groups
>>>>>>>> updated.
>>>>>>>>
>>>>>>>
>>>>>>> Yes. I think I got the idea. Thanks.
>>>>>>>
>>>>>>>>
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> struct resctrl_monitor_cfg {
>>>>>>>>>>       int closid;
>>>>>>>>>>       int rmid;
>>>>>>>>>>       int evtid;
>>>>>>>>>>       bool dirty;
>>>>>>>>>> };
>>>>>>>>>>
>>>>>>>>>> This mirrors the info needed in whatever register configures the
>>>>>>>>>> counter, plus a dirty flag to skip over the ones that don't need to be
>>>>>>>>>> updated.
>>>>>>>>>
>>>>>>>>> This is what my understanding of your implementation.
>>>>>>>>>
>>>>>>>>> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
>>>>>>>>> index d94abba1c716..9cebf065cc97 100644
>>>>>>>>> --- a/include/linux/resctrl.h
>>>>>>>>> +++ b/include/linux/resctrl.h
>>>>>>>>> @@ -94,6 +94,13 @@ struct rdt_ctrl_domain {
>>>>>>>>>           u32                             *mbps_val;
>>>>>>>>>    };
>>>>>>>>>
>>>>>>>>> +struct resctrl_monitor_cfg {
>>>>>>>>> +    int closid;
>>>>>>>>> +    int rmid;
>>>>>>>>> +    int evtid;
>>>>>>>>> +    bool dirty;
>>>>>>>>> +};
>>>>>>>>> +
>>>>>>>>>    /**
>>>>>>>>>     * struct rdt_mon_domain - group of CPUs sharing a resctrl monitor
>>>>>>>>> resource
>>>>>>>>>     * @hdr:               common header for different domain types
>>>>>>>>> @@ -116,6 +123,7 @@ struct rdt_mon_domain {
>>>>>>>>>           struct delayed_work             cqm_limbo;
>>>>>>>>>           int                             mbm_work_cpu;
>>>>>>>>>           int                             cqm_work_cpu;
>>>>>>>>> +     /* Allocate num_mbm_cntrs entries in each domain */
>>>>>>>>> +       struct resctrl_monitor_cfg      *mon_cfg;
>>>>>>>>>    };
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> When a user requests an assignment for total event to the default group
>>>>>>>>> for domain 0, you go search in rdt_mon_domain(dom 0) for empty mon_cfg
>>>>>>>>> entry.
>>>>>>>>>
>>>>>>>>> If there is an empty entry, then use that entry for assignment and
>>>>>>>>> update closid, rmid, evtid and dirty = 1. We can get all these
>>>>>>>>> information from default group here.
>>>>>>>>>
>>>>>>>>> Does this make sense?
>>>>>>>>
>>>>>>>> Yes, sounds correct.
>>>>>>>
>>>>>>> I will probably add cntr_id in resctrl_monitor_cfg structure and
>>>>>>> initialize during the allocation. And rename the field 'dirty' to
>>>>>>> 'active'(or something similar) to hold the assign state for that
>>>>>>> entry. That way we have all the information required for assignment
>>>>>>> at one place. We don't need to update the rdtgroup structure.
>>>>>>>
>>>>>>> Reinette, What do you think about this approach?
>>>>>>
>>>>>> I think this approach is in the right direction. Thanks to Peter for
>>>>>> the guidance here.
>>>>>> I do not think that it is necessary to add cntr_id to resctrl_monitor_cfg
>>>>>> though, I think the cntr_id would be the index to the array instead?
>>>>>
>>>>> Yes. I think We can use the index as cntn_id. Will let you know otherwise.
>>>>>
>>>>>
>>>>>>
>>>>>> It may also be worthwhile to consider using a pointer to the resource
>>>>>> group instead of storing closid and rmid directly. If used to indicate
>>>>>> initialization then an initialized pointer is easier to distinguish than
>>>>>> the closid/rmid that may have zero as valid values.
>>>>>
>>>>> Sure. Sounds good.
>>>>>
>>>>>>
>>>>>> I expect evtid will be enum resctrl_event_id and that raises the question
>>>>>> of whether "0" can indeed be used as an "uninitialized" value since doing
>>>>>> so would change the meaning of the enum. It may indeed keep things
>>>>>> separated by maintaining evtid as an enum resctrl_event_id and note the
>>>>>> initialization differently ... either via a pointer to a resource group
>>>>>> or entirely separately as Babu indicates later.
>>>>>
>>>>> Sure. Will add evtid as enum resctrl_event_id and use the "state" to
>>>>> indicate assign/unassign/dirty status.
>>>>
>>>> Is "assign/unassign" state needed? If resctrl_monitor_cfg contains a pointer
>>>> to the resource group to which the counter has been assigned then I expect NULL
>>>> means unassigned and a value means assigned?
>>>
>>> Yes. We use the rdtgroup pointer to check the assign/unassign state.
>>>
>>> I will drop the 'state' field. Peter can add state when he wants use it
>>> for optimization later.
>>>
>>> I think we need to have the 'cntr_id" field here in resctrl_monitor_cfg.
>>> When we access the pointer from mbm_state, we wont know what is cntr_id
>>> index it came from.
>>>
>>
>> oh, good point. I wonder how Peter addressed this in his PoC. As an alternative,
>> could the cntr_id be used in mbm_state instead of a pointer? 
>>
> 
> Yes. It can be done.
> 
> I thought it would be better to have everything at once place.
> 
> struct resctrl_monitor_cfg {
>   unsigned int            cntr_id;
>   enum resctrl_event_id   evtid;
>   struct rdtgroup         *rgtgrp;
> };
> 
> This will have everything required to assign/unassign the event.
> 

The "everything in one place" argument is not clear to me since the cntr_id
is indeed present already as the index to the array that stores this structure.
Including the cntr_id seems redundant to me. This is similar to several
other data structures in resctrl that are indexed either by closid or rmid,
without needing to store closid/rmid in these data structures self.

Reinette


