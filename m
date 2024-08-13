Return-Path: <linux-kernel+bounces-284999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C477C9507E7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 16:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E88BD1C223D1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 14:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C004119E7ED;
	Tue, 13 Aug 2024 14:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ha6iqGif"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF3B19E7DC
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 14:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723559905; cv=fail; b=kTC5+opyYEXtUW2wTxDaQIX3o+kQ9smOTJ6RPy1nGXTlQ3c9V2oez3YgDCy9Z8PoMjBTbo7ypOTl5/FYMOdGJQ2/gglwpe57wVdkYp02W1tLmhCDwcvAr1qAps3zfUopeKYid8RyJoU5mlcqn/CukMqA5HS6kUn+nhkP3BczdrE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723559905; c=relaxed/simple;
	bh=CHZCTuW2HQdJRM5eDWymAn5WmHh9q/IxMsFeEaLvG7A=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=noIf1TeRWhFp60RACpVaYAVZapcetYwQnfze+Rv3gKGij41eZuypdLcrlTa/ra4BOTsUMCw3UpQUcUYpAfEYxikCHtovhYlSXByA/VEv0vWS1y2t3gBDQSup4kS1+9T5nJ4Ekh6m2ld7GbC3xZHb5FOcOr4Qj7ZoQDjzyUfqSYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ha6iqGif; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723559903; x=1755095903;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CHZCTuW2HQdJRM5eDWymAn5WmHh9q/IxMsFeEaLvG7A=;
  b=ha6iqGifLytXE6bnrrlTdvet67nFxGHEY9uatm3fsjc57ytgQRKVqkeb
   O3sFadrbOE9KnN5bbyc9zzdtrduICJNLFTeLojQgKRTa3lxA/wTLsgQKX
   M9IXwB74/xuLH6r8wvuRNXESSJDHa92/gMaNfjpvkBvx3OgegSy/IKKwf
   SbSf//2A2jiQnQr+h6PacpwcwMjJLFL+dutA0tEvRfiJlr+YSpqPwl/Cr
   P6VuVERpxN5ezEURAu1gf8ylkhYIPT7blSaNwRDzhc2p4iGLkIwN2OFGG
   1WAzGUHt/dihHTarEiIY+Q2gdz0J9Cnprfnbcg2SezaFNEXQbR8MPioNX
   w==;
X-CSE-ConnectionGUID: FNLdGNl0TkSIqAVdRSaALw==
X-CSE-MsgGUID: iUjuNTw/TfKS9WWYRe8bew==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="32301382"
X-IronPort-AV: E=Sophos;i="6.09,286,1716274800"; 
   d="scan'208";a="32301382"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 07:38:22 -0700
X-CSE-ConnectionGUID: HyyYhwjER5GPbiKPPDEwWg==
X-CSE-MsgGUID: pOydBpRnQcGMN1NZWuPuDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,286,1716274800"; 
   d="scan'208";a="89354654"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Aug 2024 07:38:23 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 13 Aug 2024 07:38:22 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 13 Aug 2024 07:38:22 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 13 Aug 2024 07:38:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HI/wtSNvQt0Zmbd62lIYDjePlZvHRMnF68jT/4sAOj3dGufaiIZ5t+86iGneIsRrJwRJaouthgBeK2JBFpgSHJeZlrmoifqn8ZHxmpvr2RvbRUZqAG6PHSu6tezGU3Tsdy9YK21SMtGy9uYugTk1BniJSlWfZRgq/He182s7DvDGdk3Gq/UMfyVRTciWEwtH5lVIJcH0R3RtVKXHB/yqrd8LD9IyJAT+gVP9m9dxcZRpYrrEBexqj28ZeT9wattg8mNpyUxc+6bBLZEB8+RPdcTFuFENmZI2sYfG1wbWfii93+MOnE3pHdP5RRDHevJ925FsorvbbHSg9CSvvGs8oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yRhlhMv0NqWUEetrYdyQ2zUG0iYE4m1Ck91te9H5y2c=;
 b=EijEhYXg2q5h0ughzCTkMgZXWzMPlsgsymFivmwS0h/VWC5ZK4Rx1Z1Ftr8mIZMqVOHPcc0alIVYgQmzbpJw+duNzBRXsoSKPNs8DWq3jNF17FEGXg4zg0taqmlqCJ6lEyRJiU76osn4/HUHCEOQ3M2EP8yCt8znjHSRrbPP3vNCVNivNefTRbBznk42Sgc1lELphwSoIXPaxSlLf7MufuJiIH+ineGeLEinY6d4Kp83gxB8tlsLdsmMx5lgUBNayjlnpRcGMxSvMNnH0MQMsw62XFSPLGaOEkGWcUfWmvrm6+6fIn6JJsuoPm0D2Zd8vaLc6dJ5JFcPAmv9GdBsrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by PH8PR11MB8105.namprd11.prod.outlook.com (2603:10b6:510:254::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.30; Tue, 13 Aug
 2024 14:38:18 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%5]) with mapi id 15.20.7828.031; Tue, 13 Aug 2024
 14:38:15 +0000
Message-ID: <2690861a-e726-4149-98ff-d26ec6d595ac@intel.com>
Date: Tue, 13 Aug 2024 16:38:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: lib/test_bitmap.c:1278:2: error: call to
 '__compiletime_assert_127' declared with 'error' attribute: BUILD_BUG_ON
 failed: !__builtin_constant_p(~var)
To: Yury Norov <yury.norov@gmail.com>, Kees Cook <kees@kernel.org>, "Nick
 Desaulniers" <ndesaulniers@google.com>
CC: <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>, "Przemek
 Kitszel" <przemyslaw.kitszel@intel.com>, kernel test robot <lkp@intel.com>,
	<llvm@lists.linux.dev>
References: <202408131601.Aj9JmK7K-lkp@intel.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <202408131601.Aj9JmK7K-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0142.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:40::21) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|PH8PR11MB8105:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e64e93f-655e-4150-f67e-08dcbba590f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YThSVnVBMkk2MEtCUWNSeVUzUmlUS3RMSFFMWnRrUW9KSmtYTEdZVXZ3L2Uv?=
 =?utf-8?B?RTlwWWZHc3M5YzRIUDNCMFJlK3psbCtiSlVLVTV0QkY4NHJaRHpQdWFydWtP?=
 =?utf-8?B?OUtnL09lcHFaRHJucXhDbldpRWcxdVVWNVVhNGFWSWNwbFVMUjBvcmU3elFC?=
 =?utf-8?B?QmU4SFBHWi8wQmNyaDROMElER3BoN0FqaFZ1a1pXRTZqb2l1c2FOd0gvblpR?=
 =?utf-8?B?VlpTVjRnL20zMXgzeTh0dUJ0RkFyMG0yeHlnSUhmbkZpS2xyZXJqYXBpQ0xK?=
 =?utf-8?B?dlhZNk40TlRROVI4S1hkT1hZYjFsR1M5cXRTKzBLWi9GYVNUVy9IZGVOLzln?=
 =?utf-8?B?R051U29ZRmVJR1FuNGNMRWNsYS9Fc2hUSFFWZVZ1YW5TNm84YUFNOVdrLzhZ?=
 =?utf-8?B?UlU1ZDdEQ3pwRk9VUVVla0JvUGZsQW1CcnF5ZHFkSHRudTBac2htZEJzeFhr?=
 =?utf-8?B?bklpQUdvSFhwd005K3YzaTI4T1NqZzdjWDhZV0cxVlRHd3FjU3pvNHBPaUEw?=
 =?utf-8?B?WTk2cWZVTFZhN1VIK25TVk1uYXdUSnEvaW54c2FGRzNORmhzK2ZyTlAyS1Nn?=
 =?utf-8?B?NTA1cDhBb3djSjVNZUtpWXV0VXBrcFJWYnUxeStlb2VVR2QzQU9scWliUjE1?=
 =?utf-8?B?bTBFVlNGckdSbjgyVnBGdVRQbDh3U2l3VUFFZzJMdUd2WWZOOG1OeDlGcWZF?=
 =?utf-8?B?VE9iUGp3UXZTd1pYb3lvSnROQ1hISVVaazVJSHpBUWhZcWtuUE9FZ3JQUkZB?=
 =?utf-8?B?cUZLNkJoYW9FTTJFNXpHcSsxaitzTldaU1I5ZEROVm9ZTjJzQVR1QVRuQ2V3?=
 =?utf-8?B?dG5vUWRWR2l2RGV5OWZDbzE5dGRaTFVWU3ZHZkVrVFZCTWlsaEFpcWtuTnBL?=
 =?utf-8?B?YmhNaktCZlB1SVg1WWJGS0c5eEgzalk5NmVzRWg2emdYMjNXazQzOGRQZHRn?=
 =?utf-8?B?Z3dvVkM4SlJtWCsyVEI1aExseWswNzFhTjhNMXRWbFAxbEUzaFYwdDhnNnFJ?=
 =?utf-8?B?NTVobUR4Z2RLTkJqQUc5eVlPUVdERG1iNUdleXVnWjd2SWIrd0s5NzVnR3dk?=
 =?utf-8?B?N3ZaQWZDUzR6cjJZV2sza0VmM1lad3U2S2dRSW9qeU94TURnSlgrZXBpRHF5?=
 =?utf-8?B?Zi8rVlFnbDk5QjdPaHVmTmxaampGS2I3M0s2Y3pYMW5XdlNqTG5tNU9jRFN1?=
 =?utf-8?B?ZjUyTnVPaUVIcUswL2hKZ1NZTFk0L3ZRRCtsbkxvN2crZW1ZOHB1THRzNGhu?=
 =?utf-8?B?bHRXcjUzTE1Qc0svbnZTcW5aN3dWaTNnT0xkVnJHYXVTRFlCcDQ1N0JOTEFW?=
 =?utf-8?B?NEoxNENQcWpSR1RITm43RFdyWFFmaUIrMFliaWZGOWFXNmNnZ1N6SzhmdzJC?=
 =?utf-8?B?WndsbzkrRDhoNFRlUks2YTdHTGk5am9neVRWVHdobG5YNjEzUUNtbUhGdG5m?=
 =?utf-8?B?emZxV3h1TEE2Z0dXRFZPcldQODh6QnR3ZEowWWYyTVZ2OFJkTnIrT21NVVU0?=
 =?utf-8?B?emw1UTk1N0ZnU3BBVWJtWmYvOE1icmJSN2wrNklyWmNwb25iR0J4MlNXeXEx?=
 =?utf-8?B?S2N5eXdYSytsbjNET1REUHlsb29QQmVVNXZhVGtnd1N4bU9Xam0vb0hvb3BX?=
 =?utf-8?B?UmN2RHVOck80VXE5N1ZZek5hMm5jTGV0SFAzU2t6RGQyMmdSQWZPS3pGVHl6?=
 =?utf-8?B?UThaVkdlRVU2ZUFsczBMa1BNenM1UExlNzdteldrRnkrcUVxUkhTNi9VTDNL?=
 =?utf-8?Q?xdZE/Tf2wa+6Hy4hStGBNQGiIP0FSpRWmpIvxb8?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFNrTUdjMm5wd0xPeSs5ZVk0Wi9QUFNYUWNNcCtDU2Q5YWZVNTQvNHBvZFZ4?=
 =?utf-8?B?K1ZqYU1oZ0NLdnZhTS9YM1VSUU9WVUNTZUh6MXE2RTlsWE02UkZtVTJtb2FP?=
 =?utf-8?B?Y1FtWGdMei9UZTY1eHRhZGdjUUt5ZnBlODQreWtDWVBZRHJXWGRrc0ZLVDBy?=
 =?utf-8?B?ZXdMQkp5NGI3V0VqZGhQL1JkSHVkYXdXU2dud0R2ZVM3LzlQQXVjcmMvK0NB?=
 =?utf-8?B?M1FKQm9QK1BYa1hvNkxMekxPRWVtVS9GRWtqOHV1OFM2Yzk5MWkvWkhGOEh0?=
 =?utf-8?B?ZHI0RW11WFIvdCtBVWF1aExJdUhwVDBneDFzRFNJQWJYVDhUbzVKKzBoVDhL?=
 =?utf-8?B?Rm9xK0dTbzA3RTNPdmJ6K0ZtZG1UNGNIMEZ5dURTMTRqSXJhQlpzd1VDRDRC?=
 =?utf-8?B?b1BVM1JJUVpmUjRXQm1WenR4azMwQVl0VDFaMHRwRGFDaWtJOE5scDVUVHJG?=
 =?utf-8?B?a3I5TXlhWlovUHBRejNlalcrQ1Uya3J1eGpnU2xCMVdYanFCWllHc2tMTXpG?=
 =?utf-8?B?N2VtWjNwMGFVYVA5QmEvZGtTWDBsbkViQUVFWlpNTXhQMmlxQTcxbFNMSUVB?=
 =?utf-8?B?NGpSQ3d0VXRKREM0L2JxRVpTcG04QTRkY1FCSTJCbktjc1RvU1lqbldDRC9Z?=
 =?utf-8?B?N2R3MVBnL0x4TWFIaWpmOG9xKzN0RFEwNktpalMrdWFPYkluS0MyZ0t6NWdn?=
 =?utf-8?B?VmpOdkwvMWk5M05TWFNvRGhkbTR5SGtYc0p4NDgyVHY3T3IzTG54WFBPeVZN?=
 =?utf-8?B?eUdyVGsrV1RSSVFtcGVGVmJIQ2YraTkvZytkclpmL3VCOGp5YzJzWmZrbllO?=
 =?utf-8?B?WWJrVjRKZjFOdStiOXN3WUQydUt4R3BaTlloNEdmVExJYVM3WVpuK281VFdE?=
 =?utf-8?B?SThmZ01UN3JXNmF5dUtGU2MyYk1yNUI2akdOVTFXUGRIYWNldEdMSjF1MU52?=
 =?utf-8?B?WndDdVdvTHJIN1BKNWgwM2w4ckRJVEZHMWlUZElCcm1oc2R3dVBFV24zcWEv?=
 =?utf-8?B?R2JIMyt5RW5KVndKek9HTlhWdW82ZUxnOHRVWVdFcFRPL094WC9TOThaeXh0?=
 =?utf-8?B?WWVleXdPY3I2UHJ2R25YQlNlUEozZ2M2bk5RNG9VNTRidDdtUDd0Qm9xZFZW?=
 =?utf-8?B?aU5zRllHbnNQWDVCaWgwZTZuMTVJenkyWHhHWDZWcUtvai9IVUoza1dGRGpw?=
 =?utf-8?B?SFM2RUpkcFVaWkJTTTY3UUk5SHZXOGh0NVlhTGMvTzZYRjh6dTdaaGZSTmdO?=
 =?utf-8?B?b0cxRERCUFphdG1adDhaU2Z3UVFIN1pqVXRNUFcvQ0lDMXc4cmUyQ2NJNE1G?=
 =?utf-8?B?L3JOVWF4MVpRMFJGSTgvSjVSdTdLOVhheUd0UVVlanJ1RXFmdTdHOCtibG4x?=
 =?utf-8?B?UDhHQ21nbzdwL2RvRDRQNW5RRGkzSkY3REJ2TVpOOWkwY0xLTXNPSzZYOXJl?=
 =?utf-8?B?bk90UE0vb3NqV1VtUzZtZEMxaWlUbGsrMktSN0t0NVkvQysrbUVQVGEvVk56?=
 =?utf-8?B?b05RMnhWRDg3S1BORm5BSHA5bU1MM2htUzVGem1CM2xMQUtwWlNMMUkya2Rx?=
 =?utf-8?B?QW0yS2JPWTdkWS9SYWNOWkJLNkV6Q3VyVUhjeXRHYVdDcHhkWWxFNkJacmVP?=
 =?utf-8?B?eXBMNS9TcU1kRnhHajZVT3RJL0FwUmVwVEZ0dXVnbzRnNnBGT2ljNUtzVi9h?=
 =?utf-8?B?VXB4SCtUTWRWalhGWW1wLy9VRmNMSnNmU253MzBDQUpRdW01SlMycTVQbjlj?=
 =?utf-8?B?Z1FtVVY2bEUyQU1iTGpRbzM3bnd3Z3EvTGtLNzJyQ3NOcFp6Y1l1dkhUb1lz?=
 =?utf-8?B?dkVzQzdTOW8wdFJlL1p5NHYvU0pka0N5R1MweEh6VERLVm14QzJEWWxNVWwr?=
 =?utf-8?B?K3ZjOUF3NExqd3Jpb3Q2K2c2UDkxSFlsRFBLTVFvM0JvdThsUDhuVzF1eWd0?=
 =?utf-8?B?M0N4ZHJFM0Zia3NVOTl3Y28zdDl4ckdaZkIwV0lYaEpsYU9ZczBFNTltNWY5?=
 =?utf-8?B?M012ODN6alpKK0FSL0VtMm9hVkJTT1VLNTZqK2wrejc1SWpBakozVEtndnJj?=
 =?utf-8?B?VDJGZkZRSkFOUGJtR1ZOM2dYcWJhZU93dHk2K1czWHZtS2krNzNsUmVMWkps?=
 =?utf-8?B?UzkzL29BcGdYbGFaZGphM09rOTFaSmY2bVN0Szh0WGNDT3lpL2Z2R21ySHdj?=
 =?utf-8?B?dHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e64e93f-655e-4150-f67e-08dcbba590f1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 14:38:15.6581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7PNu+NTDeEF7YNOHdRErodgOUEZfdyBDcyPeSSZw+rMhmuDnSsQij/NZHmr5mIXNhKS6b3rsmWyumfSYLvKxiUaEEBUtDdkhBaaRC21m21A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8105
X-OriginatorOrg: intel.com

From: Kernel Test Robot <lkp@intel.com>
Date: Tue, 13 Aug 2024 17:00:56 +0800

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   d74da846046aeec9333e802f5918bd3261fb5509
> commit: 7adaf37f7f104a7ee5f150af491674ccbbfc4114 lib/bitmap: add compile-time test for __assign_bit() optimization
> date:   4 months ago
> config: um-randconfig-r132-20240812 (https://download.01.org/0day-ci/archive/20240813/202408131601.Aj9JmK7K-lkp@intel.com/config)
> compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project f86594788ce93b696675c94f54016d27a6c21d18)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240813/202408131601.Aj9JmK7K-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202408131601.Aj9JmK7K-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>>> lib/test_bitmap.c:1278:2: error: call to '__compiletime_assert_127' declared with 'error' attribute: BUILD_BUG_ON failed: !__builtin_constant_p(~var)
>     1278 |         BUILD_BUG_ON(!__builtin_constant_p(~var));
>          |         ^
>    include/linux/build_bug.h:50:2: note: expanded from macro 'BUILD_BUG_ON'
>       50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
>          |         ^
>    include/linux/build_bug.h:39:37: note: expanded from macro 'BUILD_BUG_ON_MSG'
>       39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
>          |                                     ^
>    include/linux/compiler_types.h:460:2: note: expanded from macro 'compiletime_assert'
>      460 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>          |         ^
>    include/linux/compiler_types.h:448:2: note: expanded from macro '_compiletime_assert'
>      448 |         __compiletime_assert(condition, msg, prefix, suffix)
>          |         ^
>    include/linux/compiler_types.h:441:4: note: expanded from macro '__compiletime_assert'
>      441 |                         prefix ## suffix();                             \
>          |                         ^
>    <scratch space>:193:1: note: expanded from here
>      193 | __compiletime_assert_127
>          | ^
>    1 error generated.
> 
> 
> vim +1278 lib/test_bitmap.c
> 
> 291f93ca339f5b Barry Song        2021-08-06  1227  
> 2356d198d2b4dd Yury Norov        2023-07-17  1228  /*
> 2356d198d2b4dd Yury Norov        2023-07-17  1229   * FIXME: Clang breaks compile-time evaluations when KASAN and GCOV are enabled.
> 2356d198d2b4dd Yury Norov        2023-07-17  1230   * To workaround it, GCOV is force-disabled in Makefile for this configuration.
> 2356d198d2b4dd Yury Norov        2023-07-17  1231   */
> dc34d5036692c6 Alexander Lobakin 2022-06-24  1232  static void __init test_bitmap_const_eval(void)
> dc34d5036692c6 Alexander Lobakin 2022-06-24  1233  {
> dc34d5036692c6 Alexander Lobakin 2022-06-24  1234  	DECLARE_BITMAP(bitmap, BITS_PER_LONG);
> dc34d5036692c6 Alexander Lobakin 2022-06-24  1235  	unsigned long initvar = BIT(2);
> dc34d5036692c6 Alexander Lobakin 2022-06-24  1236  	unsigned long bitopvar = 0;
> dc34d5036692c6 Alexander Lobakin 2022-06-24  1237  	unsigned long var = 0;
> dc34d5036692c6 Alexander Lobakin 2022-06-24  1238  	int res;
> dc34d5036692c6 Alexander Lobakin 2022-06-24  1239  
> dc34d5036692c6 Alexander Lobakin 2022-06-24  1240  	/*
> dc34d5036692c6 Alexander Lobakin 2022-06-24  1241  	 * Compilers must be able to optimize all of those to compile-time
> dc34d5036692c6 Alexander Lobakin 2022-06-24  1242  	 * constants on any supported optimization level (-O2, -Os) and any
> dc34d5036692c6 Alexander Lobakin 2022-06-24  1243  	 * architecture. Otherwise, trigger a build bug.
> dc34d5036692c6 Alexander Lobakin 2022-06-24  1244  	 * The whole function gets optimized out then, there's nothing to do
> dc34d5036692c6 Alexander Lobakin 2022-06-24  1245  	 * in runtime.
> dc34d5036692c6 Alexander Lobakin 2022-06-24  1246  	 */
> dc34d5036692c6 Alexander Lobakin 2022-06-24  1247  
> 7adaf37f7f104a Alexander Lobakin 2024-03-27  1248  	/* Equals to `unsigned long bitmap[1] = { GENMASK(6, 5), }` */
> dc34d5036692c6 Alexander Lobakin 2022-06-24  1249  	bitmap_clear(bitmap, 0, BITS_PER_LONG);
> dc34d5036692c6 Alexander Lobakin 2022-06-24  1250  	if (!test_bit(7, bitmap))
> dc34d5036692c6 Alexander Lobakin 2022-06-24  1251  		bitmap_set(bitmap, 5, 2);
> dc34d5036692c6 Alexander Lobakin 2022-06-24  1252  
> dc34d5036692c6 Alexander Lobakin 2022-06-24  1253  	/* Equals to `unsigned long bitopvar = BIT(20)` */
> dc34d5036692c6 Alexander Lobakin 2022-06-24  1254  	__change_bit(31, &bitopvar);
> dc34d5036692c6 Alexander Lobakin 2022-06-24  1255  	bitmap_shift_right(&bitopvar, &bitopvar, 11, BITS_PER_LONG);
> dc34d5036692c6 Alexander Lobakin 2022-06-24  1256  
> dc34d5036692c6 Alexander Lobakin 2022-06-24  1257  	/* Equals to `unsigned long var = BIT(25)` */
> dc34d5036692c6 Alexander Lobakin 2022-06-24  1258  	var |= BIT(25);
> dc34d5036692c6 Alexander Lobakin 2022-06-24  1259  	if (var & BIT(0))
> dc34d5036692c6 Alexander Lobakin 2022-06-24  1260  		var ^= GENMASK(9, 6);
> dc34d5036692c6 Alexander Lobakin 2022-06-24  1261  
> dc34d5036692c6 Alexander Lobakin 2022-06-24  1262  	/* __const_hweight<32|64>(GENMASK(6, 5)) == 2 */
> dc34d5036692c6 Alexander Lobakin 2022-06-24  1263  	res = bitmap_weight(bitmap, 20);
> dc34d5036692c6 Alexander Lobakin 2022-06-24  1264  	BUILD_BUG_ON(!__builtin_constant_p(res));
> dc34d5036692c6 Alexander Lobakin 2022-06-24  1265  	BUILD_BUG_ON(res != 2);
> dc34d5036692c6 Alexander Lobakin 2022-06-24  1266  
> dc34d5036692c6 Alexander Lobakin 2022-06-24  1267  	/* !(BIT(31) & BIT(18)) == 1 */
> dc34d5036692c6 Alexander Lobakin 2022-06-24  1268  	res = !test_bit(18, &bitopvar);
> dc34d5036692c6 Alexander Lobakin 2022-06-24  1269  	BUILD_BUG_ON(!__builtin_constant_p(res));
> dc34d5036692c6 Alexander Lobakin 2022-06-24  1270  	BUILD_BUG_ON(!res);
> dc34d5036692c6 Alexander Lobakin 2022-06-24  1271  
> dc34d5036692c6 Alexander Lobakin 2022-06-24  1272  	/* BIT(2) & GENMASK(14, 8) == 0 */
> dc34d5036692c6 Alexander Lobakin 2022-06-24  1273  	res = initvar & GENMASK(14, 8);
> dc34d5036692c6 Alexander Lobakin 2022-06-24  1274  	BUILD_BUG_ON(!__builtin_constant_p(res));
> dc34d5036692c6 Alexander Lobakin 2022-06-24  1275  	BUILD_BUG_ON(res);
> dc34d5036692c6 Alexander Lobakin 2022-06-24  1276  
> dc34d5036692c6 Alexander Lobakin 2022-06-24  1277  	/* ~BIT(25) */
> dc34d5036692c6 Alexander Lobakin 2022-06-24 @1278  	BUILD_BUG_ON(!__builtin_constant_p(~var));
> dc34d5036692c6 Alexander Lobakin 2022-06-24  1279  	BUILD_BUG_ON(~var != ~BIT(25));
> 7adaf37f7f104a Alexander Lobakin 2024-03-27  1280  
> 7adaf37f7f104a Alexander Lobakin 2024-03-27  1281  	/* ~BIT(25) | BIT(25) == ~0UL */
> 7adaf37f7f104a Alexander Lobakin 2024-03-27  1282  	bitmap_complement(&var, &var, BITS_PER_LONG);
> 7adaf37f7f104a Alexander Lobakin 2024-03-27  1283  	__assign_bit(25, &var, true);
> 7adaf37f7f104a Alexander Lobakin 2024-03-27  1284  
> 7adaf37f7f104a Alexander Lobakin 2024-03-27  1285  	/* !(~(~0UL)) == 1 */
> 7adaf37f7f104a Alexander Lobakin 2024-03-27  1286  	res = bitmap_full(&var, BITS_PER_LONG);
> 7adaf37f7f104a Alexander Lobakin 2024-03-27  1287  	BUILD_BUG_ON(!__builtin_constant_p(res));
> 7adaf37f7f104a Alexander Lobakin 2024-03-27  1288  	BUILD_BUG_ON(!res);
> dc34d5036692c6 Alexander Lobakin 2022-06-24  1289  }
> dc34d5036692c6 Alexander Lobakin 2022-06-24  1290  
> 
> :::::: The code at line 1278 was first introduced by commit
> :::::: dc34d5036692c614eef23c1130ee42a201c316bf lib: test_bitmap: add compile-time optimization/evaluations assertions
> 
> :::::: TO: Alexander Lobakin <alexandr.lobakin@intel.com>
> :::::: CC: Yury Norov <yury.norov@gmail.com>

+ Cc Clang folks.

clang-dev 20 issue?

Thanks,
Olek

