Return-Path: <linux-kernel+bounces-522556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D333BA3CBC7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 22:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F8C13B11A5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 21:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F66A24FBE0;
	Wed, 19 Feb 2025 21:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ip+H7vMV"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536B91A841F
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 21:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740001737; cv=fail; b=ORQMAPUpgj3pbPH6ukyaLGxfTA5DJA20F2iloxblF3qo2s/9NrEBwvpgdk4bcnsOR1qKAKLQLmsr78T89vhzJGWtyZmnowUIlzQmxluXiPH+IprYIEAn2RZkZUdMCSvVWjbNxVOU3gzoaUDdLDl7P2Z8WtNo8E2Qa2D1d6C2u0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740001737; c=relaxed/simple;
	bh=vQg7+wakkne/MeY+BsgM7ae25RP2w13B1s7rokpKzD8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ncOTCVp4cA8rRcRRQpSev1v3wzuAA3zv8BcN2Oc9OJb/3pe7XkA1onWKMH1zuzz1E2ptp2Gg6LJp9y8Bltqt80Myy407x+QLs4V6aGLguZ8/7fXfbdT+In+ajZLOcfhV2lXLcEo4pDFoxZ7wn2veJWZw+1JN5ql7aOfcat5EqvI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ip+H7vMV; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740001735; x=1771537735;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vQg7+wakkne/MeY+BsgM7ae25RP2w13B1s7rokpKzD8=;
  b=ip+H7vMVNkKkuzP+t8LtE5xKsHdVjTrZkaVGKJZZeAomrsg39iL9DWFn
   cKkfkrfc9a4J1SCBGa1fHIyrS8wVbPeM1u6q07ANDg8skeUi30av9hqmG
   LXAp9UlEiUpyNoUiWqhQqoQ43QKsbKTs/YMgX3H7s18n3X5rK+pSK6Y1X
   xTNq3qH4zEm7ImR6oJBKK0aL+am5fBMj7KlUb5Czs65UX2I5GeTuPQSkh
   evWd2KiK4EkxaF1k+HGQ69C0HAfXxySPvuO/wH/Bl+zQjcq+A/ULf03OA
   /bbD4VGzr5D+feLTQL9Cde+B/MceIRs7GmdzieRo26B3v1EzwFWlc3ziI
   w==;
X-CSE-ConnectionGUID: nVAyK/D0SjChTpTFVzUmYg==
X-CSE-MsgGUID: T3YEJBThT6+nDAbwZziHZg==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="63235895"
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="63235895"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 13:48:54 -0800
X-CSE-ConnectionGUID: 0KKGzIZ6RVOHYukOX0eDxQ==
X-CSE-MsgGUID: Az2gKGRQStuiRlLhKACY/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="120058512"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 13:48:54 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 19 Feb 2025 13:48:53 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 19 Feb 2025 13:48:53 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Feb 2025 13:48:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OO1qz7Prv+RXJhWlqMPzTTtAKsYv7OAAr+8ATRbC8rTgBDsuiiz4MPvX0ASVfV4qAFW5QbwcluQkozxfMvS40G5YmD5cNNiJm8xmN59zZrAlKowwZHxxgK0JyjgWAqe7h/fkyuBldLy2SBCUUB4P94T0YTjp39H61Troi4PpeGxhr1HqdHFOozWRc8HoF63xRP/pLbkAsGXLiRKKJ60lGtfzbzjoIoBlC8BlcZyEQDVZfwVf4dYgcyN4hVx845INNQRUWNhRYlvs9aX5xU3aVwpqg8HnsXvVCR0xwUwQF095TjcJqeqT30C8hq5ryhMeqHfvUVESx++EMcXfYpr7JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kBLHTy3c7mTeirckAvf48ipo/xnM5kaGfMJGX8pXXX0=;
 b=MfZhjuJtsMHNhxd9sJruLHLAkKgx46gUonB702mNDYwlMAeZ83FBcJndwh0SqDbQ/1pdF0LaLY2XDREnxLz8nJM6u91wwv0EQRGrrdpPOu2gJah7x6ba/h+SgSPmCB6903dE67Hgi+S/B2b+OszKViTuCAETxSWx6vF7A7FwcM1wkqrk3JsJD49wkotQaG3Pi0yjtWEBPHRhk/wAaxWVcXXDSrXzMGCP0vDtNbzG0QxN7zR+79vmAyyX4H/eZWgUwzUqeTUZy15uJzu8KoVuF4ytXV64s3ZFV6cNLRoc5VJ7y/6mBqiiirToC05Q9Ku3YXzgenEd1N2WyIxXaLqCEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7566.namprd11.prod.outlook.com (2603:10b6:806:34d::7)
 by DM4PR11MB6335.namprd11.prod.outlook.com (2603:10b6:8:b7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Wed, 19 Feb
 2025 21:48:22 +0000
Received: from SN7PR11MB7566.namprd11.prod.outlook.com
 ([fe80::2b7:f80e:ff6b:9a15]) by SN7PR11MB7566.namprd11.prod.outlook.com
 ([fe80::2b7:f80e:ff6b:9a15%6]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 21:48:22 +0000
Message-ID: <db92c74f-2b03-4145-b253-dc72808a795a@intel.com>
Date: Wed, 19 Feb 2025 13:48:18 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 03/42] x86/resctrl: Remove fflags from struct
 rdt_resource
To: James Morse <james.morse@arm.com>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>, Babu Moger
	<Babu.Moger@amd.com>, <shameerali.kolothum.thodi@huawei.com>, "D Scott
 Phillips OS" <scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
	<tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
	"Dave Martin" <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>, Shanker
 Donthineni <sdonthineni@nvidia.com>, Shaopeng Tan
	<tan.shaopeng@jp.fujitsu.com>, "Tony Luck" <tony.luck@intel.com>
References: <20250207181823.6378-1-james.morse@arm.com>
 <20250207181823.6378-4-james.morse@arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <20250207181823.6378-4-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0199.namprd04.prod.outlook.com
 (2603:10b6:303:86::24) To SN7PR11MB7566.namprd11.prod.outlook.com
 (2603:10b6:806:34d::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7566:EE_|DM4PR11MB6335:EE_
X-MS-Office365-Filtering-Correlation-Id: 79b25d67-a987-449c-994d-08dd512f2137
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b1djeEhTOThPTy96RjZvZjE1V29IczBPbnZoVUY5ZDFmZWcyV1EwNDV1N0xF?=
 =?utf-8?B?TFlobFJPTFEyU01oMTM4aXp3WThxMEcxZi85bTNOdnVySXFZbUFicnVad3Ry?=
 =?utf-8?B?U0tkclNROXdYOTNyNHdZUEY2ekprTms0aldmZjlWWDJqUlRWYzdMa2R6TkFX?=
 =?utf-8?B?V3BOWkhpak1HbE1aK1dENmNXN3F0MEtEUHZOM2lJTzBVcUluYldrck01c2x5?=
 =?utf-8?B?ZHJhQjZPTHpVRlZIOVdzYWRyRi9NSHVPZ3ZnRjdsMFdrd293Q0lmUXppU2Fy?=
 =?utf-8?B?MXQ1VHA1WU53VkNNNkM3MlJZdXE4WW11WTI5VXhyOGZ3enpHSmtISGw1M3BK?=
 =?utf-8?B?TG5RNTU4WnlQQlk1blBibHBkK0VHZWhXWnM3S2RIaG1mMSs1Y2ZLM2ZjQUVT?=
 =?utf-8?B?dm1DR1NTSC9zRVBxNTM2MENmeXB4ZmY0clUzU0dtMmJXMk1tdE8rT1JCNk1T?=
 =?utf-8?B?Z3dkemFHODc0TXJmaFlhcUd0L3dLMXhDWnFnbU01QmtYTXdEZ1lPSnJMOGcx?=
 =?utf-8?B?NmFaSXM3QWxuclc3ZXVNamRjLzZLYnNOc2laa2FMSW5JcXZwL2xRUjU3a08w?=
 =?utf-8?B?U2swSVJlNFRBZWlVMWxiS0NUdmFYVjJ1VTRrRW14MEdvbzVYVENMOVMxM1Bv?=
 =?utf-8?B?eFFoenk4K3pYZ0JEdXlLUDNhTzNMaUFFRkhuZ3AzOGtjZWplNHJBQU51QXZt?=
 =?utf-8?B?K1JsaGhoMU5TT2pCRzR5TmQ3dEJqZ25URHNJWDI1eUg0N3RRWWd2RUZLZ04z?=
 =?utf-8?B?NEExWDZ3VGhzY1Z6WDE0d1VTUFEvekhMVmlXTW1TbmxUZS9ldGpuVW55VGJB?=
 =?utf-8?B?UmsxVTROOCtuQkwyYVFBSTNDN3MyZ3U2SUVGaXZiY2dUOXl6Q3NYZmhvSU50?=
 =?utf-8?B?K0VTdE1iQ1J6eG5xSHVRcTM4MmFIMlBiUnlhNDBFOC93cEcwY01OQXZaTlpr?=
 =?utf-8?B?ZTVwRzBUaE1icmRFaDBYTzVDNnR1a0dHRGVoRGhiNlR4Ty84aUwrcE5hbjQw?=
 =?utf-8?B?dTlGa3Z1QnFjclZoMEpScHN2M1E2UmxYcWk0b3hoU1MybXVQTUYvSkJsdXRW?=
 =?utf-8?B?U0dsTnIzdnN4aUJ2Q0tiK2ZGTlR4ZGJNQ1BzOW9tWlR5bmxXRCszRlhFS2Rh?=
 =?utf-8?B?MGN5aU4yTzJFczV3Z0o5SmdxVHBtZTVYSTRnd3pXT3RVZkpPeEJJOUY1OHRK?=
 =?utf-8?B?MnlLYjRZcjJpVnJrWkhUMUlUWnY3a2lmU01nZFpjNzIvY3JBbUw4L3dobHFz?=
 =?utf-8?B?cjJZbXhTQ05FaHA5VmVBT1BSVWlERFk3aXppQzhKdUplWkY1enRSYnhkajV0?=
 =?utf-8?B?M2pjRWF6WGlndHUzdUkzQ09teVl4SjV2ckRmbm9ZZ2Q0U0pwdFV6S2JudUo4?=
 =?utf-8?B?UC85dXpoN2JDblR1Z2RCVGI1OUwrTFg2aFBqbEx2OE1RODNiY05RZ1d6T2FW?=
 =?utf-8?B?Sk5mKzF1b3VvVWxTaEFaNmluZVYwOWJMTExUSE9PNnFHZDE1NlRlTjdrQTE0?=
 =?utf-8?B?SWJ0THdMUjJZOFNRRUU0Y1o5QTgzUElUWVFNckxwMGxLaWlzUTVSYmE3em8r?=
 =?utf-8?B?L1FQcnhYRzJIckEyR0RaRi9lWVhuOTFSYldObVBHK0dSaExPNGQ2endrQ2xQ?=
 =?utf-8?B?QkFqdnQ2SG81TXZiZ0RRWVdqZktIOUVZME9JQnRUY2JCSXowSlpMZ1ZSdmlp?=
 =?utf-8?B?Qy91NDg3QjIrMWlYeUUvS2FteGRLUFQwQWdtNXFDR1ZJVWdvVy9FRGMvRWZx?=
 =?utf-8?B?ai9vbm11eWFlYkVLejErUjZKUVhlUFI5Qm5kTnMzYWU1N1BGeFVlMENaTUVG?=
 =?utf-8?B?YlloK1YxNER4Q2FiUlRxRVFtbE41UVhlMWU1VDlNRkhWR3ArV21SclhsalJ4?=
 =?utf-8?Q?bVVfIlOp8nGEP?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7566.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TU1NZEhCQmpOYTVwVUs3L1NWeXVqcGwxeWpNMnpRQWxSeDlFOCtjNDZkSFRX?=
 =?utf-8?B?Y09Gd2VnSWxwRUE0TDB4TmZ4YTRhcTRtSzNHaUZGa0o3TlFHc2xpenNTcGFH?=
 =?utf-8?B?akRRUjc3RkhBL0EyNEtWMllGZnZYNHl4QUxwOUxnRGhtRzdocjRDdzcwTTZ1?=
 =?utf-8?B?SEh1QjJvTFcwenBxU3g5aTZobFhLWG9WZEt5bkthOVd3VDZmNDlMR2RPeGE4?=
 =?utf-8?B?eUQ4ZUVDU2tkdGZ4cVpDeGNKRnd1eWNaZlhZdVVkcGx3NEtBdHhjOEdFaEpF?=
 =?utf-8?B?R0dzSjhVaUoySmxaaUZjeVRXSnZhQ3pka0hMUDVpdnRndW5lY1FBZmZrcGVk?=
 =?utf-8?B?cmhTTWViWDVjdXU4Nm8yaE11dmx2c3d2TDlnTFBGTllXYmFrR2o1NXpVWXk1?=
 =?utf-8?B?b0JEWXhCTGluYWtaRzRMWnlOcng3SC9Vc0IwR3ovR2xCbEdqYU4xV1YyTG5I?=
 =?utf-8?B?bkFnSFhOajFGN3VURnVIbll6eFF3YWhuT2t3MHdCSGZwNHlCMk04TVd3RGFo?=
 =?utf-8?B?Z1EwT01nRW80MjVkRzF5OGZWcXpxNXNzank0VHpBUzBmZlhVaEs4Tm1tZytI?=
 =?utf-8?B?Q0xabmhWZnluM2FKSytEdXJ5N1hzR1UyeXpRb0d5TG1nMEs2dGEyMzJDS0JY?=
 =?utf-8?B?elo5K1BveEJKWTMrQk02bHFNZE5TcTB0c1lmSFRQVGthNGlRUmFZcVA2NWgz?=
 =?utf-8?B?WHFmZzBNNkJiWGsvK3NyUEc4OWJ0RHhiSERVa0R2eU50RHRGVlpVZmdzYjdp?=
 =?utf-8?B?ak1mUTlLdXI0YjBSU2lRd1ZPdnRLOWh6a0MvcU1Nc09mSEJuZmUvd1lMVWxZ?=
 =?utf-8?B?ZmoxMnFsS3ZiMHgrWERqa3Y0VldpQTM5am9xSDUyKzM3dkZNRVJrZys2YTg3?=
 =?utf-8?B?d281KzQzdzNST0dUME5BWkFIOEZUd0h2ZFRCUzIwY3BtWlJwTDN1d2kyYzUz?=
 =?utf-8?B?bURaRjRSNE1DQ1dFVjhaNG12ZFF6TDFWZkx6VEdqZkkzUkl0aHBpLzBpeUxx?=
 =?utf-8?B?eWNiYksvc24rSFdOVjVLTmlNQm1CWUVWT3RYS1AwdzcrUXplSVVpbC9nQjRk?=
 =?utf-8?B?NTVIaUtDMWNTeGpuVU5pWVBwUVJJVWEvOEtncjMxaTdOcXBXWVlHUHlWZTZN?=
 =?utf-8?B?SmRubzFUZmRKOHRaQW5wODJvMXBHeXUrczJLNnROazlMQk90a3piYjZwNUZQ?=
 =?utf-8?B?NHR6N2FaWUZWdUxXdmFwWXhVaGpYT1NqMC9KNmV6cnBmbEhyOUEzOFVXZUVV?=
 =?utf-8?B?NURHdkVYQnU0bFVjNndiNGdRZkxIY0hkY1VBQkZoMkFtNlB5Wm1MV2xIR1da?=
 =?utf-8?B?L3FUNlNDUXZkYjFSQWNTTzN3bFFXQzZvLzFZK3FNYXhyaEdTVElId3k1SnNn?=
 =?utf-8?B?S1h1SHUxdGowamxjSTRtZlVVMElhakNmay8vYW0vUERoVnJCdTR0TGp2aW1B?=
 =?utf-8?B?NG1VSHFVeWYrcG5lT0RnczNnQ3J0YXdqYWRPaVd2bzVzVzRSZGVscy95Um9p?=
 =?utf-8?B?TXkyY2tFZTZMSnRsMXJ3c25TWFAyMW51Q3dCYWxyZEhTOFVpdmpKd09CVk9C?=
 =?utf-8?B?UEd0a2JsTEJMNS9iRzRmeHREUDJ1WHhDWDhRNldtVitXcGx6RE01VU10ZGZB?=
 =?utf-8?B?MzFaS3Exd3RrMjRuN3ZleGZoSFhVNEtXY1NZUzk5amRUbTlidkgvR2U2VDRq?=
 =?utf-8?B?b2I3bGYyNFRNc3hRSStHL3lGbEhTRzRQWFJqVWRQZjFIQnkrQVgrVWswclZa?=
 =?utf-8?B?VEJIeXRNdjdwRHVSN2pJdG56UWZ2anVISzRYaXpxc3FuUEZqa2JKWGF5ZzRR?=
 =?utf-8?B?U0Z5SkdHNVhLOGppU3M2M1JZSTA1ZlZ5bzQ5K0JLZitPVERGa0tycWRicGo2?=
 =?utf-8?B?L3Znam40ZStFNnpSMHM1d0twUjMvZ2R6SXZ2b0NRMjEyb3I4cFo5TGkxWUc2?=
 =?utf-8?B?ckdOR3E0RjFpV0JuMEt6RnF5djE1YTk0cTFYMDN6cDY0MmRtbEZoQXhPalRp?=
 =?utf-8?B?Rk1WWklaei9tZVNkRk9JYUZCa2ZBYW5LTFVuRlpJbW80UUJ1MW4xUXpQZWFw?=
 =?utf-8?B?eGdJOGtRY21UaTQ4aVNRcTgxSXIxczV3UmNBUS9QZ2FZVnJZVDl2MHBmWnpn?=
 =?utf-8?B?YmZOSTV5NnJ0b0p4SWtWd1loZHlMNnFpWHdHS010S0t6YmdHa1hIbUJ2ZlRV?=
 =?utf-8?B?OVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 79b25d67-a987-449c-994d-08dd512f2137
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7566.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 21:48:22.0841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HGGsnMaUFt4BNuS51ycRSn8L9QXTI8AW+vjdDGHsl67GyDalwz6y87oE6tGghwkz6M9zDnB8RgSASJoJ2yR8kSDRLVlqCwX6G5M9xHLth1A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6335
X-OriginatorOrg: intel.com

Hi James,

On 2/7/25 10:17 AM, James Morse wrote:
> The resctrl arch code specifies whether a resource controls a cache or
> memory using the fflags field. This field is then used by resctrl to
> determine which files should be exposed in the filesystem.
> 
> Allowing the architecture to pick this value means the RFTYPE_
> flags have to be in a shared header, and allows an architecture
> to create a combination that resctrl does not support.
> 
> Remove the fflags field, and pick the value based on the resource
> id.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

