Return-Path: <linux-kernel+bounces-395620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C109BC0A8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 23:14:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16994282D19
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 22:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19DBA1FCF69;
	Mon,  4 Nov 2024 22:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kH8mTd/J"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB231F7553
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 22:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730758456; cv=fail; b=lIjBzsVspBfgYxZZKTXsnbz5e5uWHpGXleiehuXoGaj4WCi/5b025IemOOUdmZaFh/6fLfJb5/Rzm1+hcz4ad3PvQSbZ129gKsGnDqBg7fBKXrYczw4OmoNghVd/IF5qIcjaguQZjSbdJiAGOOXYWhQdfg49yxw6S3KBngEZY40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730758456; c=relaxed/simple;
	bh=okJjRu4oGFPziB5qYmNZuw/9U+6LObYqmU/LD7D7fgc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pL0e+rrdswvBfunTD1JB2VxkMFxU1PquZpWArRkpoEU8sLjl4CjDfW1C/+XE83N9KdPN1wLZ/NUkaPLka/Qd5Q8xk0mEu5HxtfShYd63DjbR6fpv6wpbfHp54wGfDIPgeU7MV6/oJVmP/fhRjV0UMM6o1N9/TJ58i3C1n0DdOPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kH8mTd/J; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730758454; x=1762294454;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=okJjRu4oGFPziB5qYmNZuw/9U+6LObYqmU/LD7D7fgc=;
  b=kH8mTd/JkV1f1UTxeBvDlBIK4KUWYq5Ct6SUsg3PkO3D3Awo/HVZT15z
   LDddfsngCb98xsvXFwkSlJ/Grg5TaY8Oygmp+bKHFwSpNd5mofHC/aLXO
   Wq3yINGMMvVWKyQTRwzcqMqqKosMLaJnSTvpiSoyp4KwjGyfvuxQpXjTh
   tS8LcwsUdsmOhwjBeCLewFBAe/5s8y9zIqf28eg6bcAAdnjK7XrqpLQ2m
   mepjs3lcCmmRgc38trjOTqgJM/IcZFvUwNprk36n64znFeMf+mmlJTkNR
   nCZiqM1jQvJSsOMq6oxRp80V2vDN7T0tNpk36mAXKPp3jNXjvEPWWyhBF
   g==;
X-CSE-ConnectionGUID: xufOzI3GRMy6x36L0TLSaw==
X-CSE-MsgGUID: m+e3FPgoSqqI2SimgT2quw==
X-IronPort-AV: E=McAfee;i="6700,10204,11246"; a="34264567"
X-IronPort-AV: E=Sophos;i="6.11,258,1725346800"; 
   d="scan'208";a="34264567"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 14:14:13 -0800
X-CSE-ConnectionGUID: jzQMGrnsSJezkRkWzCJIwg==
X-CSE-MsgGUID: sVKZERFhS9qwsTm/X4UZGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,258,1725346800"; 
   d="scan'208";a="88361742"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Nov 2024 14:14:13 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 4 Nov 2024 14:14:13 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 4 Nov 2024 14:14:13 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.49) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 4 Nov 2024 14:14:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CSoDmfPTtIE8MIJ7l0rmmbB6jItaNni2t5ZuXLKr5sIAbUH0xRrG1b/C5da8MAOpk4E0B0c8v6Ws7cdNiFB/cB/1BVaMvCCFSxPLqbBcbtmuBIiMMzWqrJYm2VnmVbrRlcENCCKg79e9qUUig0sZrPaAFmtNthWUrj398JN6zPwmkqrR126ZcSEKhn3wO1kUbJ0e7keJo81rZPgrAqoI4mV3TjQc42eGa0KsKrVooWrZ4sR2kwlW3yYsJ5bnTHsX0QgDvMVPcfianRki8tBPY9Em36G6BtykD2/1kJcNdZLLeTBwrEow5ffWVOt72/OiRYw+s1Y+h+0UAZbFgzPy2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xzJuJyJIBtv2ZwoPfKudspT0rwLVotI1R/SVq444vw8=;
 b=XNR8p5nXxi990ODXSV1hzyhrH3SkHp3LkR2gZKpy0ZYMCKtOCQSqm2RlcEjBNB9fdBBj2kouyk/A8RgOGYhAgNE2KKozr+7y0Y1TxxX4QZ4Bf+6IOxLDniSpr2R3K2iVcfwqZopEhm+4OQx9rW5ioaZk7MNo+eH6LwhJRcHfjhOOASJmzxGDAYxb+FYQV+gsMOmMnFA7x6A0k8r36nBnx/TU1a32+CntOweWRc3DqDj195lkSImBGrTQJO0nfA1Uuu8OWHKEyRDZ70670BDAmWCn3znvSlWJN76RiuP/MotsXO2tGaXGvwfHIVz7ldisgYWQMdyKVPuJaLnUSre3BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB6269.namprd11.prod.outlook.com (2603:10b6:8:97::14) by
 PH7PR11MB7148.namprd11.prod.outlook.com (2603:10b6:510:1ef::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 22:14:10 +0000
Received: from DS7PR11MB6269.namprd11.prod.outlook.com
 ([fe80::af1f:dcc:49bf:1a26]) by DS7PR11MB6269.namprd11.prod.outlook.com
 ([fe80::af1f:dcc:49bf:1a26%5]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 22:14:10 +0000
Message-ID: <f51ce51e-cf78-499f-b03a-cb45d5364b13@intel.com>
Date: Mon, 4 Nov 2024 16:14:05 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 1/2] tsm: Add TVM Measurement Register Support
To: Alexey Kardashevskiy <aik@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, Samuel Ortiz <sameo@rivosinc.com>, "James
 Bottomley" <James.Bottomley@HansenPartnership.com>, Lukas Wunner
	<lukas@wunner.de>, Dionna Amalie Glaze <dionnaglaze@google.com>, Qinkun Bao
	<qinkun@google.com>, Mikko Ylinen <mikko.ylinen@linux.intel.com>, "Kuppuswamy
 Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-coco@lists.linux.dev>
References: <20241031-tsm-rtmr-v2-0-1a6762795911@intel.com>
 <20241031-tsm-rtmr-v2-1-1a6762795911@intel.com>
 <46609f9a-8451-4961-b307-a13512bbd92d@amd.com>
Content-Language: en-US
From: "Xing, Cedric" <cedric.xing@intel.com>
In-Reply-To: <46609f9a-8451-4961-b307-a13512bbd92d@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0215.namprd04.prod.outlook.com
 (2603:10b6:303:87::10) To DS7PR11MB6269.namprd11.prod.outlook.com
 (2603:10b6:8:97::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB6269:EE_|PH7PR11MB7148:EE_
X-MS-Office365-Filtering-Correlation-Id: 96224a14-4745-413b-66d2-08dcfd1e01d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MVBZOWFXYS8yaW1Md1lDd2p0NHl6ZnljeHZvTjBuVGF2S09FQS8vakl4S1di?=
 =?utf-8?B?ZXEyQXpudFJkRzlMTGlGUi81THpEcUsvRDJmUGZ0b0YwSG9tZU40elZqWGtE?=
 =?utf-8?B?b1Q0Mk5CY0xodExWZUIrdUx3NDFTejVrY21QUURaUFpMaGtvNXNvODZUQzFk?=
 =?utf-8?B?L01HM09KVmpaRWx4SGpzRFNqNzBDQ2F4MktEbGt1eThkbEJYY21RNFkwaDhY?=
 =?utf-8?B?S0lkY0ZweWY5SVlHYThOTXZZUEE4ZFUyOW5yYTZUdDB6SitEcGNwdnRBWTh6?=
 =?utf-8?B?OWRFeXR2RUNMUUhaQ1EvbmY5SC9DcWlLRUgxbG1nR2VNQnNDYVcvT3Nxa3lh?=
 =?utf-8?B?Q2xHdmxNVjBXR0FtUTNIQ0lsVDVQbGdMSWdIZE5IWDJZbUlnNjVER1lSdG4x?=
 =?utf-8?B?WVlXa0NmWStGYmc2NmtYYUFKZmxIbkFwbmcrZ2pkZHF5WC90bHJDUUltcUNy?=
 =?utf-8?B?VVk1cEt6NGY5a0s1MGNhNHVWb0plUWdtVEN0UG8rcjErMGxPQks4Z1hoczJS?=
 =?utf-8?B?NFJSeDh6SzhFV1pPOEJwcWpyMEJpQkpWenl2ekszL1YyNFZyN2Y0TjEvUlQz?=
 =?utf-8?B?dTZ1ZFZpYTNSMnNRb2NRcjkrcUtFcHdtQndBV2NHSlNNQnFKMHFycVVRbGJj?=
 =?utf-8?B?SEVhUzhZNllsT2lCVWYvL3JPeHJaaVRSYkY4WmJBN3JyN2h2R2Z5QThpaWxw?=
 =?utf-8?B?K2pRMUFoSFIyOXpGcWRQM0dqNzJoclI5OGN6d0QvMjgxN0VaYzd4dW5BOGla?=
 =?utf-8?B?QTBLYjJlUWwxbUllR0lOSnJxcmhhZTQyK2E4ZmhXNzZDVEF3cHB2OW9CZnVj?=
 =?utf-8?B?MG4xMjJOYnVQNGVMeUhCRGpLOEFCNVVFdHU1dUxPT1NlV1lOMW1Dd1BJTFV1?=
 =?utf-8?B?UGlwVVdFOTlkQUZUSzlrWlNFdkVKbmdlOE40UDJiYlFDVkIzVXB6MFQ3OCtG?=
 =?utf-8?B?NGtHYktvemRGMTJIQzMyYU0yWHRReU9nazE1aHczVERVY3RUL2hpSWlFeFl0?=
 =?utf-8?B?T1NXRFhHUHBpK0x0cHJEOEFWMzFZNS95VFRxd1ZLK1ZxN0owK3Zmb05kTG5P?=
 =?utf-8?B?ekpKaWZzZ1JRMDB3L2xNcWYycytKd29PRWNoTVc3RHpKbFpoNzFoRlB6d1JY?=
 =?utf-8?B?RXh6M0FSWitnaGJqbGYyaXdhUUJCbG1Hck4wZTZESmV1QVdYdkpiTlB4cXRS?=
 =?utf-8?B?MTMzQTBRbDZiaWI5K2NyamhuNjV3RXlDRzhLQm4vT2g5cUxIQTNnQ004WHdT?=
 =?utf-8?B?N1R4QVB1ZHl4akJzUDlGTlJ1RlRWbDVNdDlSdkx5VzdZYUFEbm5hUFRHTWVC?=
 =?utf-8?B?eWo1U0xhMVhqNzB0clhhc3VWV2swa0NRVjBCblplbGhjdDFOS0w2Vy9xelds?=
 =?utf-8?B?eWNQdWNWVndBSUVrOVZManRrZTZtZHhwS0hvWlQvMHArZXk4VWNrU3gweGY4?=
 =?utf-8?B?SzdQSGlXUlR2a0o4V0RvNE1tWHlad2o1MXFvTW41eEswUHZ5N0hLYmJlL095?=
 =?utf-8?B?U012ZXRsVzhlcjZGSjNTR3l6R0RTckdkVGc1RS8wdmhEUW5hM29tYkVuV201?=
 =?utf-8?B?algvQjNibFFzMzJkeCtDV2k2aHRDODR4YWh5VU1Rb3RZa2syMU9QejBiam9p?=
 =?utf-8?B?L1QyUUVvRHF1Y0pORGVPaWsyUHBlZTNwUDUvNER3dmdRaTBwUjY5bTlpK0tY?=
 =?utf-8?B?d09Uc08rekxzUU5OM0piVzROTlNDU1BlanViSnJnM3hlNnBPWlpuOEdXcWtu?=
 =?utf-8?Q?PzUnJ3UBJqbWXabsal7Q2dcW5el3earcN8/+Pl2?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB6269.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?clk4K2RVTHlxTktEYk4zcmh1MUZ0d0xoMzArSDlMbHh6aDM2MXI0d1QyaDcr?=
 =?utf-8?B?aTRNbkRoTkZDVVR3UTNsQm0rVmtPazNxM3FRbU1TR3lMVWt2aVRBdFlGSVZI?=
 =?utf-8?B?Uk9DbWNRdmJoUnlZbFJTTFNpc0NhWTZESnEreVcyY2NvRFpPY1RjREIwQitn?=
 =?utf-8?B?UTVpLzVzcTdKK253RWFneWVmY3F2ZVNsTGRXT0pka3RhV3NzaVc2dTJxZWpG?=
 =?utf-8?B?QUl0Zi9YNEgyQlJpb0psR1dpV0QrbkViNFhYWWc3a2NueGNwNkJtN3Z4Y1M1?=
 =?utf-8?B?UGpTeWp3a1lPYTVWcHhFUW5wdXZwdSt3QUZJcWNXRXQwaFl3YzNGYjIzY2oy?=
 =?utf-8?B?OWdCOXdkdXdlQWxlQXZTNzE1WnBtQVhUV0Y0Y0svOWNWbEJhK0lxOUkycC96?=
 =?utf-8?B?TUVKZ1h4eHFvbjNZRXJuVnByYXdqZ3plNFY0Z2VxenF2OGIvMXZHcGlWVEkr?=
 =?utf-8?B?dmxsRURzZEpCVDB6OGhhVUFjRzdNOXdzSENUdmtXUW13SFFScjJGc0ZaRDUz?=
 =?utf-8?B?RURLa3JzR0tWT1NaRVFZMmFiTmZBeEZndFVWeUY4aVlnTDBJcDF1TzQ1WW8z?=
 =?utf-8?B?azAvTGp2TFROOWVYVGJzcmhSck1iMGlGMTdXZWZaWDlyMUdLWUtNOU0xZm0x?=
 =?utf-8?B?UWIwYlcxSXR4c3RRWDNsVisxU2RIdG9lZmtFTlVQTHF5Rmx6UVlDc0o4a0Iw?=
 =?utf-8?B?MlQ0YkwweDBzdnkzSThQcmZBOU1OcVJ3Q2JFZ1p0eVJ6eEp1MlErNUM1Ujkx?=
 =?utf-8?B?eEJkTUFyWUtHLzRzQkZVZTk2Yk5XbzVYcHU4N00yZWJkRDcycWxOcDNZaHBY?=
 =?utf-8?B?Mm9TcE53QnM2bHJtcFFPTG5jakFJNmU0M1NnckdHOG55MGhKdllMRzB2bU1P?=
 =?utf-8?B?V25UZVpKc0RhcDVRTGhnNk8wS1l3eFBRSGNGQUdkejNlZldEa3ZsVU84U3Vq?=
 =?utf-8?B?VjJIdDNkN3dES1V1NmNrZllveGlheGFuaE5TdG9kUWgveWdMWVZQeElXM3pI?=
 =?utf-8?B?emRzckFjeGJSN2gyWkFrdTZsZ1dxNFBMeHpsTlZSeVF4cFZtbitUc21pWCtE?=
 =?utf-8?B?eFljSGFacTdMZnJrZUdlNnlRTlYzSTdDVTc0ZGloa05ERHJERFdIWjZXLzBM?=
 =?utf-8?B?Y0RUQTVPNURselgrY1pzQUtPdXJ6c1dBWXJsdlVlZTlQemRGeGZaaDVPSDlB?=
 =?utf-8?B?MXlTQkhxeEw2VWkyaXdlR1MwRGRVeDhEclFyRWdCMXh2dlZhTkl4b3VQOUpX?=
 =?utf-8?B?eTJFN3A1bE1MM3lBQkNBZXJteDB5VytuWEtQNUs5NUxZN2hUVXJXL2xqR3Zk?=
 =?utf-8?B?UEFOYWpKNXdzdGtQN1BxRFNBTWNUdWdpTFF5dVI1cXYvL0diR1BOdTBBNFRU?=
 =?utf-8?B?TFd6ZE52bHY1VkVaT216R3hlTFJ6NzhSMW5QZm1qOGFBeERtR3EzWk5tbVFO?=
 =?utf-8?B?bnR5QWNDdy9oY0JydUd6U29McjFzS1ZOMW8xU01xb3VsdUhBM3NXeDBsbVZV?=
 =?utf-8?B?V2JJcjR5SEthMExtQzRxS3JOUGtoWSsyUWg1SGk0N2pMUjFsbTZXSHQ0TFRS?=
 =?utf-8?B?Zmc2K0J3M3hwd21LNXR0QzdKSmgxZWhrSWhvZi9WcVJ4d3puN1FvOStSOGtC?=
 =?utf-8?B?OExra0MyN3Z4VVZhSUFLYnlpaXdXR3ZsQjU0YUlpblJaRENVQWs3K2g4aDZN?=
 =?utf-8?B?NTU0UjBHcXBhSFhoS1drZ1BWenM1b1AxakZMQ2pvZWtyS3NXbHNuczFjRTBq?=
 =?utf-8?B?U09za20vbkJnV3g0RUZ1NGdoLzJRNHBuNGtKcFM5Sk1qdGRzZktuOERPMFRo?=
 =?utf-8?B?aXN6RDBXQWZmVXowcTVhUGgvWjAwWnUyL3NhbWtvYUM0bUZkT243bjIrM2Ux?=
 =?utf-8?B?SDVlNzlNYkVwM0p5MkhvcXBsN0dXa2NzbFNOQjR6WlhiUElKN1UrWThoYTBK?=
 =?utf-8?B?SHB0OVpTTXdHOWttOEhzRnVEK0VybE4yUTg2Z3Q0UU9KQzJmN1RNRTVvTVBE?=
 =?utf-8?B?UVlNYnZPRUZJVzNwL3JGbXZHRlV3ajNsUmQwY2FUQ3R5ZTgxa0pwTzE2Q1Fi?=
 =?utf-8?B?R0tyVUpiaDdvV2Y0REYzZ0g4RlRkYWZEd3hRTDBINnNkUis2Mkl6Yytscy9u?=
 =?utf-8?Q?nycVjo5T1Uf/H0PGpoLTMal4E?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 96224a14-4745-413b-66d2-08dcfd1e01d5
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6269.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 22:14:10.3921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vI80dqqyBIa96tcESdx43DcsrKxpJd/EeSrnDg6lsFxPxpFb0dVv5pxEnPVVfKm4rxDDIFy24GvqFKK1dIMYGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7148
X-OriginatorOrg: intel.com

On 11/3/2024 9:51 PM, Alexey Kardashevskiy wrote:
> On 1/11/24 03:50, Cedric Xing wrote:
>> diff --git a/drivers/virt/coco/tsm.c b/drivers/virt/coco/tsm-core.c
>> similarity index 95%
>> rename from drivers/virt/coco/tsm.c
>> rename to drivers/virt/coco/tsm-core.c
>> index 9432d4e303f1..92e961f21507 100644
>> --- a/drivers/virt/coco/tsm.c
>> +++ b/drivers/virt/coco/tsm-core.c
>> @@ -1,8 +1,6 @@
>>   // SPDX-License-Identifier: GPL-2.0-only
>>   /* Copyright(c) 2023 Intel Corporation. All rights reserved. */
>> -#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>> -
> 
> Why remove it?
> 
It's not used anywhere...

>>   #include <linux/tsm.h>
>>   #include <linux/err.h>
>>   #include <linux/slab.h>
>> @@ -166,8 +164,9 @@ static ssize_t 
>> tsm_report_service_guid_store(struct config_item *cfg,
>>   }
>>   CONFIGFS_ATTR_WO(tsm_report_, service_guid);
>> -static ssize_t tsm_report_service_manifest_version_store(struct 
>> config_item *cfg,
>> -                             const char *buf, size_t len)
>> +static ssize_t
>> +tsm_report_service_manifest_version_store(struct config_item *cfg,
>> +                      const char *buf, size_t len)
> 
> Unrelated change usually goes to a separate preparation patch, otherwise 
> too much noise.
> 
You are right. I'll capture all the "noise" in a single preparation commit.

>> -MODULE_DESCRIPTION("Provide Trusted Security Module attestation 
>> reports via configfs");
>> +MODULE_DESCRIPTION(
>> +    "Provide Trusted Security Module attestation reports via configfs");
> 
> 
> Seems unrelated.
> 
Are you suggesting an edit to the module description or simply 
complaining about unrelated changes in the same commit?

>> diff --git a/drivers/virt/coco/tsm-mr.c b/drivers/virt/coco/tsm-mr.c
>> new file mode 100644
>> index 000000000000..a84e923a7782
>> --- /dev/null
>> +++ b/drivers/virt/coco/tsm-mr.c
>> @@ -0,0 +1,374 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/* Copyright(c) 2024 Intel Corporation. All rights reserved. */
>> +
>> +#include <linux/tsm.h>
>> +#include <linux/shmem_fs.h>
>> +#include <linux/ctype.h>
>> +#include <crypto/hash_info.h>
>> +#include <crypto/hash.h>
>> +
>> +int tsm_mr_init(void);
>> +void tsm_mr_exit(void);
> 
> These two should go to drivers/virt/coco/tsm-mr.h, along with 
> tsm_measurement_register and other TSM_MR_F_*.
> 
TSM_MR_F_* are part of the module interface and have been defined in 
include/linux/tsm.h

These 2 are internal functions called by the module entry/exit points 
only. Their prototypes appear here merely to avoid the compiler warning.

>> +
>> +enum _mrdir_bin_attr_index {
> 
> Why do so many things have "_" prefix in this file?
> 
All "_" prefixed symbols are file local. I should have used a more 
explicit prefix. I'll change this in the next revision.

>> +    _MRDIR_BA_DIGEST,
>> +    _MRDIR_BA__COUNT,
> 
> One underscore would do.
> 
Are you talking about the double "__" in _MRDIR_BA__COUNT? It isn't part 
of the enum logically, so I put an extra "_". A precedence is 
include/uapi/linux/hash_info.h:41 in the existing kernel source.

>> [...]
>> +static void _mr_provider_release(struct kobject *kobj)
>> +{
>> +    struct _mr_provider *pvd;
>> +    pvd = container_of(kobj, typeof(*pvd), kset.kobj);
>> +    pr_debug("%s(%s)\n", __func__, kobject_name(kobj));
>> +    BUG_ON(!list_empty(&pvd->kset.list));
> 
> Harsh. These days people do not like even WARN_ON :) None of these 
> BUG_ONs seem bad enough to kill the system, dunno.
> 
This BUG_ON has helped me catch kobject leaks in my code. I don't have 
problem removing it. But is there a guideline on what kinds of 
BUG_ON/WARN_ON should be kept/removed?

>> [...]
>> +int tsm_register_measurement(struct tsm_measurement *tmr)
>> +{
>> +    static struct kobj_attribute _attr_hash = __ATTR_RO(hash_algo);
>> +
> 
> Extra empty line not needed.
> 
>> [...]
>> +        for (int j = 0; j < _MRDIR_BA__COUNT; ++j)
>> +            battrs[j] = &mrd->battrs[j];
> 
> An empty line missing here.
> 
Thanks for pointing these out!

>> [...]
>> +    pvd = NULL;
> 
> Is this needed for __free() machinery?
> 
Yes. I should have put a comment here.

>> [...]
>> +    struct kobject *kobj = kset_find_obj(_sysfs_tsm, tmr->name);
> 
> Empty line missing. scripts/checkpatch.pl should have detected it. Thanks,
> 
Will run scripts/checkpatch.pl on the next revision before sending it out.

