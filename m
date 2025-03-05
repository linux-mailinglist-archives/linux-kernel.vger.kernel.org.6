Return-Path: <linux-kernel+bounces-546232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A02A4F824
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 08:42:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9366B3AAF9D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 07:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CEB41F4CA7;
	Wed,  5 Mar 2025 07:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="culvlxCt"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB001F3FC2;
	Wed,  5 Mar 2025 07:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741160502; cv=fail; b=E6jReBmq3kvjGi8gJx7NYDGLDChO9ktOXN+N4dpch2WiQzm7JVqJRqyIT7lzwiGT4iu6Z3ajnj0ZKz59UrqG1ISWlntRCDERt5yxEae59Eu/dTsDNFX4ap0KRSuwvnUvFRvb1gkNPLvtQDsgZ9y/CQA5N9m7Lbd3Jn1RtSXx8aU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741160502; c=relaxed/simple;
	bh=UQbUit+5zZWvM3SlWjrJzXkwH86fS/D5nSszFoJyIuw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sj/J1KOXCLEele55fDRuj67OB9/aOkP3yAPwvXzly6FzTTb2NG1EkfaXnVceyutzs4/PVeD5u2wuWMA13uggvkU/1aAv7eVYrsYfZ3Gwo60EVe8XNUY6Xy5H5xZkeDJXpmnfhyQ3EXkm75jayCIZkUqAk636RrKjNFPq0v3bybc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=culvlxCt; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741160501; x=1772696501;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UQbUit+5zZWvM3SlWjrJzXkwH86fS/D5nSszFoJyIuw=;
  b=culvlxCt1gWEVbdr1xH8XJPuneMiiAgcqGxMSCuVpYTYHeihQg3MZlLu
   m72oVWUSRdjuw+EEOCErWA7P+p3FQGUqvvkkmazJjg0tM4e9DXYDas0hr
   DZ6yPEbNGQyZqPqhrSiH025yoT2kCEut9s5Ib0RA0Stofl558iBJmrAdz
   Lb/P5jh/lvVZq4qOaSNY5hBgdUSOIsi5A8W2AcSPA//fbJ1yXhQXPuzJN
   B+4CleexDZplu5rxrMkMOHdiPlkxQAciLi/ifRH0K8Nf72Af3/EKNOvdN
   jA+YDV7GnDV86BG8N0DreUeNDwCoRF1D7BHFX23HH9O0lWmTJOt6cIytH
   w==;
X-CSE-ConnectionGUID: 7szK7ENRRLaC1k3c+kHcgw==
X-CSE-MsgGUID: o9vPJP0gT5CHyLygOuk7YA==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="42233592"
X-IronPort-AV: E=Sophos;i="6.14,222,1736841600"; 
   d="scan'208";a="42233592"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 23:41:37 -0800
X-CSE-ConnectionGUID: S4sHzSLjQ8aa96ZEGbHlhA==
X-CSE-MsgGUID: 8g4Ihi6SRPyRnv3nLjH4VA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,222,1736841600"; 
   d="scan'208";a="123713217"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Mar 2025 23:41:36 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 4 Mar 2025 23:41:35 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 4 Mar 2025 23:41:35 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.48) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 4 Mar 2025 23:41:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ETZJDZPzSKBO8z6yoUQtOozwCNuScV8VB84wbOgGPJUHXLfwMYTiEwZ/ziEe7Ag3ym7jcNtl7duRigAviYxxOlaAlfmV6SUbHAF/Etq29Azj+5rKC46cAaIhoqMt1qKpn/cBwwCSlN4kCupytAwGBOuDirYUIWkH2ECSA0d1ZbAZwexoYPwXkuupkmO2Pilc2zTpkYCXVrCfAJgPxVhEBt57VGsTYUqr+Y79E3ncABjIi+9OcbWXfT6RYmPblLqKo7eHCkrsB5vr8kEi5e/Bgr1c5UtVodqNqjy+6uwlo25U6/QSUSPLPgPF9jonuNWdlv/i9vOLsbLgI5mDhB9vow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UQbUit+5zZWvM3SlWjrJzXkwH86fS/D5nSszFoJyIuw=;
 b=YdX8wAO8FllC2d+WqPDpSRVAr2V4kzzdC9S3J/UMgPPxJOornJVUIcxVvXDZAw58dVXCPBHvrV5ecpLbh2OpzW/Nyngcd3qhXRmxCaRzOnP0M1S+cQTHwzx1aPaU/e7XzB8Ira6BP8lRW53Rwu+vuhJncm5cSIG1NOWB8jawjYEj9TjB2xBpc1iiMxTG/RU4UKLK1LNT3H/K9n9iMrpM0cXqqXA5ajnc+Pb0oWMoKTUfJL8oHvsYN22LEEh04WnZstDITb0KwfHruU3NklhQyA8rLlSJamf/502mgptmRsaE9rQ3I5vcu3GpGzlt9beEmbJ8qAq93tHwpIlnkEsMxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY5PR11MB6366.namprd11.prod.outlook.com (2603:10b6:930:3a::8)
 by SJ2PR11MB8514.namprd11.prod.outlook.com (2603:10b6:a03:56b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Wed, 5 Mar
 2025 07:41:25 +0000
Received: from CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::6826:6928:9e6:d778]) by CY5PR11MB6366.namprd11.prod.outlook.com
 ([fe80::6826:6928:9e6:d778%4]) with mapi id 15.20.8511.017; Wed, 5 Mar 2025
 07:41:25 +0000
From: "Usyskin, Alexander" <alexander.usyskin@intel.com>
To: Markus Elfring <Markus.Elfring@web.de>, "kernel-janitors@vger.kernel.org"
	<kernel-janitors@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>
CC: "cocci@inria.fr" <cocci@inria.fr>, LKML <linux-kernel@vger.kernel.org>
Subject: RE: [v2] mei: Improve exception handling in mei_cl_irq_read_msg()
Thread-Topic: [v2] mei: Improve exception handling in mei_cl_irq_read_msg()
Thread-Index: AQHbjaGo/h7lckMaCEGr+8VcG23btrNkKB7Q
Date: Wed, 5 Mar 2025 07:41:25 +0000
Message-ID: <CY5PR11MB6366E6F52B68E8258EE47F3FEDCB2@CY5PR11MB6366.namprd11.prod.outlook.com>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <00589154-00ac-4ed5-2a37-60b3c6f6c523@web.de>
 <b7b6db19-055e-ace8-da37-24b4335e93b2@web.de>
 <MN2PR11MB40930A824DF68F96A93E1B7FE5859@MN2PR11MB4093.namprd11.prod.outlook.com>
 <df3ce733-955b-45f3-98bd-04ddb2200eca@web.de>
 <CY5PR11MB6366D07A7F302780A87160E6EDCB2@CY5PR11MB6366.namprd11.prod.outlook.com>
 <ccdac63a-4a04-4243-9350-05acc23f413b@web.de>
In-Reply-To: <ccdac63a-4a04-4243-9350-05acc23f413b@web.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR11MB6366:EE_|SJ2PR11MB8514:EE_
x-ms-office365-filtering-correlation-id: aa54ba6c-3b70-41f1-5697-08dd5bb92213
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?MU9adXlzdTIrRkJyRVlkTmxnZW9hRWxpQU56YUg5RytVS3dBc1FBZy9GL3ph?=
 =?utf-8?B?WDQ1TG9QTCtsYU9GalIySWVJekZmSzBwUDY5cTVXNXd6NWFwZm9xNURiNW5C?=
 =?utf-8?B?K3VuVDZnSlliRS95RDV1NzBacUVOcVMzREdqcXNHVEVVWTFiZ2kvSGxLOEtR?=
 =?utf-8?B?K0NWdWhwV3JUNzNoZzlVYklUWXdWYk53UFlZUXlOMDNMdU0xa1F3NTZEeE80?=
 =?utf-8?B?US83RFdKUmhqZkxDSmhvanFIK1JENmRHTlVMZFREQ2t0V3JlaDdIUzVydlZN?=
 =?utf-8?B?M2xxdEdPVUxQYkZubWlxM2ZNK2ZhbURxWnRuZ3E3Q2hLRitnY2hrSHByYktP?=
 =?utf-8?B?aiszQTc0My9JL0w1NXJqK0NSL3VvT1RCYklNZkJLVFFYd3g5VU4zZW5BV0gw?=
 =?utf-8?B?RStWVXN0Y1kzMjFSZHlSUDZwcjhvWXpwMkVaZHU2amtmaGNvVTIvSDdjWTVN?=
 =?utf-8?B?NGNZUjVyY3N2d1ZwN0tJamtPUkdiRXJBVHJsRXhxR1QvTkNjanhvK2VWNXZ4?=
 =?utf-8?B?eldZWlQ3RU16OGdtMGVBalVKS1F2S0psQWJuTk10Q3JWQ0RQZWNGVkxnQXZ5?=
 =?utf-8?B?UFp5ZGNDM0NYZ1pGZm04dThWWVYraERFbGM3UTJwdFFVOGxmcWNBWGRHKytG?=
 =?utf-8?B?V2s3WTRKekhkSEwwMDQxQUYrdll5QVVOai95VXRVWU9ld0Naa0ZZaGlYL2Zt?=
 =?utf-8?B?Zm54UHYzeTErRU5Ea0dMcFh5dW1sdUpNYTYvbnFVeHpSeUx0VzltaklDZ2ZY?=
 =?utf-8?B?dERMa0pXUzRqSC8xNnllMzhjYTQ3cHNDZlhTdSsrZFl4TWRrMWpUUjZwRlZz?=
 =?utf-8?B?Sk44WEtacnlHY1o3OFJVVWJmZURjUkVwQ0w1d2FEcG1rVkE0TFZJVjVFTHVl?=
 =?utf-8?B?cko1dGhnLzV5dkNrK011dXJsek1lR0I4WFI3MGtScEFBcFZKaGJtYjBVOGEw?=
 =?utf-8?B?UERmWUZpM3Z2MXVsR1l2Z2FZOHg2RGpnYnJQdjB2Tjdna3pvQSsrMVNuRHg2?=
 =?utf-8?B?Q0FjOXNpVGR3ay9TR1lVNnpLRXFSYllEek1CckZTU0RUSlpqWlM0cjM2cmNJ?=
 =?utf-8?B?Ujl2b0NjWUJEM1ovL0JwblRiRHFEcFU0SkpISVFhY0NoR1pXZFhqRlc4bGlw?=
 =?utf-8?B?bXZJWU1IVWQrckM5ZmN4RGpEdHlHQWZxQWdqNk5RNzZQdXpzN2xoWkVwdlhM?=
 =?utf-8?B?ZlJWZXN2clJoajJJdWJGSDYvZW1UdDNjcW1mdy9nb2hhKzY1RWxMU1hPNlVk?=
 =?utf-8?B?SjJmUzh5TmNYclU5U0kxY25YMjlic3lDMGU3T2dSUkM2UzhPM0VSNFhKamx1?=
 =?utf-8?B?ZjdnTlF0WXhEb3ZZRFRqRXJnK0pYUHh5MFFVcmV0NG1nOXErWjBkeXRBbHJv?=
 =?utf-8?B?NTZOMGNlaGpqUk5talE2MmxZWitOK3VrdGt2ZHh5QldkMHpFK3BZcHpUdjZJ?=
 =?utf-8?B?SmUwZHlSaGhXRW5pdzZBZjZMaktERUxoU21sa3oxNXFaTTh0YU5MNVBXM3Vo?=
 =?utf-8?B?UUFsYnpyVjljc1lkV1Y3aGd5V2RGWkFPb2hKanpPbkxmZVg3UXE5Ymg1OVdC?=
 =?utf-8?B?TkhTUjdueXRWc1BocXNadFJVaU1QSDRKdklCdmQ4L0VxWDZjSGtvbk1sd05j?=
 =?utf-8?B?RlVFTzZ3QWJZNnRCSTVJLzdlemM3ZFROZHpBZUhha0M1YVZCR1dtbzI4ZFdx?=
 =?utf-8?B?Qlp3enV6aW1Oa0w1cTlGd3d1TVlna1MyYmtXUzJJN29xNjYzL1lMNTQrTStP?=
 =?utf-8?B?NTdBcGtYR2RJaEorMFBiTDdETXJVK3BoSEt5VDJUKzBMa2luTUlDTGZYZElZ?=
 =?utf-8?B?d0sxSmRrdmlYc0lSOUNSaEY1eVNtYVBrcHVnTHZHUWN6c05lQXNOWjRLdCsw?=
 =?utf-8?B?Q1FlM2txajYvaktLQmNjUjcwcEpTK3BmRUp0bUxZRkdtVFRUV1BHTTVOMXBn?=
 =?utf-8?Q?eGG20btv/6zXazpCkbsSWCs18MD6qFOD?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6366.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OC94ZU1YOXo0VE5iUmVma3VQdk4zcXE5Uk5oS0NIMndlUEdBcFpkai8yWkI0?=
 =?utf-8?B?OUF1NVRkdC9XcE4rM1plb0xscVU3K3hmeS95bDRHZ3JxWStjVGFxVXlGUEw4?=
 =?utf-8?B?VXlrTnNJaDJLbDhWbFI0dnZwLzROSExkQmVUNE1IZTZaQmhreGZyUnowZkg3?=
 =?utf-8?B?WFhKeFBzVU1PdytzOWduWGhuYWtrNlVHSDYra2pBdW13RHJ4K1pSQnpyNGtW?=
 =?utf-8?B?NUswZFEwOHJGVWl3VU9wQ0UybHZkbUo5anV0dlV6QWRPMEdhSXY0aHpjK2xR?=
 =?utf-8?B?dUlGWTJXZHVSZloweGlUaXhxNjVZZkpuc0FqT2pvQWkyYVdtRW43T1ZET3NE?=
 =?utf-8?B?bFArMHJzbzA4MWdxaWpITW13d2pkRjlxaE9aYWdJeTJ6Y011N1dUMGFSeE13?=
 =?utf-8?B?aU9QVkwzOThzVXRqU0U5WUZpQ05jWlRQTTJIWjg4cFlscnhuSnd4K3dsMVhq?=
 =?utf-8?B?T25wcTI3NjIvTnRkajNYemJqYlN5Tlc1TFNLa1N4NWQ0b1VMWTNMcmdzM2RK?=
 =?utf-8?B?Rk5KUzRBa0d5d0gwZzJWWlFNTUVLTzdpeTd4UENYR2hXK1JYcXIrOWluNVlF?=
 =?utf-8?B?MU83LzQxREZwMHBvVkxzbzFUbGtyczV1ckVVTlRRaUl5Qnh5R1p1K1Q4eTd6?=
 =?utf-8?B?Tmo5YUlQT2piWmxSL0hBQWJJb0dGbmhkWEVhN2dUdGVCb0lvTGFrRUNjRWVy?=
 =?utf-8?B?NWlraWllUFRwc0lCMGd4L212NkdBWjNRNmdYc1p2cjNPY0NTTGU5UWdidks1?=
 =?utf-8?B?bTFPVU9xR00rMnBEU2lab0ZvVGhQSFlNZmlCN0lpVlEvQkMvMW5ud2Yyc2pJ?=
 =?utf-8?B?cWVINDMyMi9qVXVNNmRVNnh3RTlPdk5MSFFzNFdnN1Zod0UvVUZLRDFidllU?=
 =?utf-8?B?dnNiUEZwOWhxbndMRU9zdXBySU00Vy8rSnVISnFZRTVERm5mRG4zbTNtbmJw?=
 =?utf-8?B?RWxGdkhaV0hJM0MySlpvaEN5NTYwQjlwNWdUUUNLYVNSdllWbzNrQWY3c05q?=
 =?utf-8?B?Y1Z2TkVKNTJpNU5zZzU1eStOWmdQMHo4YnAvNE9VZ00xbVVXTHZySTVqTTEw?=
 =?utf-8?B?RkhEUjE3TWU1R0dTSWF5a3ppQTR2NU9ZbVV0Ui9XM2RyVUJHMjhNZ2M2cGlU?=
 =?utf-8?B?VFlsdDROOHNoc3FzTkFMM1ZESzM5VzlGaW1HZDdhWHBJSEVUL1dZWjNIOS9h?=
 =?utf-8?B?cVlVSEF4K1krQ3d6TGsycWt4NmMzTWI3VFNiYytqNEkvczloR2MxRThSUFZo?=
 =?utf-8?B?Y3NZU0I4ZjA3Ky9CVUJPdXh6ZFRrUmlFTWIwMGsyOXAreE56MHAvbE5mNHB4?=
 =?utf-8?B?TTJzSjFsRFBYd3kwL0dsbEZKZEJXQjVtKzhQdlhLYTBncFg3NmNmdXZFZVY2?=
 =?utf-8?B?a09WRnl6Yzg2Q2l1d3JQb29LYzBJNThkSmsyc0pMcHlYdVJBK0ZqTmpMOWxN?=
 =?utf-8?B?em5Pb0dJbW9pZ2ZyNU9jY2tkY0ZtL3ZRVVBPcmtJTWhHd1N2Zk8xc2N2dkVQ?=
 =?utf-8?B?VHAwMXFSTVNJbmN3T3hyT2dlWURsSlJXdFRQbWpRQWRlTmlSbWV4bWk0Y2c5?=
 =?utf-8?B?SVE1V0pQR1ZybGd4VXVGTVY2YWZuRGFsaHlvZmV0TVM3amtHa09UcU5LdGVi?=
 =?utf-8?B?TlFIb1VlYW40U2ZPV2paVjdaWnJYR3ZjaGJ4Z2c4NUw4RDJ2RFhWUnp5NCtQ?=
 =?utf-8?B?TVhPR1gxbXdaSGhHSFB1bUQ0cHA5cCtBejJGYlNmQVNxVVJwYmZoaXMyQzEx?=
 =?utf-8?B?M3g4dHlSN2JrYkJVWnlKMmFuZ3haMVZlMEl0RkpHSXV5MGlDTzlxS1FBZFBv?=
 =?utf-8?B?bTZ5ajlhR2NVS2xKSkxRYkpJcm56ZFpMdUVUejJ3L1VsTFVTbnV4OUViMU5Z?=
 =?utf-8?B?REpHS2UrVEdCUERQVTUzM0R2eGFyVHdzZFpneXRQN245WmZEdjZSZ3VyUEJu?=
 =?utf-8?B?akVhdy9kdEVyUEZjRzVYeHBaYktVbGFiOW1uRkw5RVNncXlwNGZMMkY4Rjla?=
 =?utf-8?B?aVV1bXI1NnJaeU8rbmRXV3pwT3BRbTZ2eEFEeHY5akdNMjdSUlQ0NWxxd2Ez?=
 =?utf-8?B?WDB4TGlxK3RReW1BWjZ1b3p2TDJ1YjhtMGlUZFdYY1R1VWdkc3YvdkNNRjh1?=
 =?utf-8?Q?RV9AweizVZvzKrU30yDzkyFWX?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6366.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa54ba6c-3b70-41f1-5697-08dd5bb92213
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2025 07:41:25.5225
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JXqsEBwb18Cy6XcfaKdo22txgG3X9Hg9PJDK4XLY4Q5hA/4PrRjQigKwYusUF9+cWytmXpMM3Pa2LxDt1l1H3rxnBwM94Gvn3f8OWydUj08=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8514
X-OriginatorOrg: intel.com

PiA+DQo+ID4gSW4gZ2VuZXJhbCwgd2h5IG5vdCwgYnV0IHRoZSBsYWJlbCBuYW1pbmcgaXMgYmFk
Lg0KPiA+IEl0IGhpZGVzIHRoZSBvcmlnaW5hbCBpbnRlbnQgdG8gZGlzY2FyZCB0aGlzIG1lc3Nh
Z2UuDQo+ID4gTGV0J3MgcmVuYW1lIGV4aXN0aW5nIGxhYmVsIHRvIGRpc2NhcmRfbm9jYjogYW5k
IGxlYXZlIGEgbmV3IG9uZSBhcyBkaXNjYXJkOi4NCj4gPiBBbHNvLCB0aGUgcGF0Y2ggd2lsbCBi
ZSBzbWFsbGVyIGluIHRoaXMgd2F5Lg0KPiANCj4gRG8geW91IGV4cGVjdCBhIHRoaXJkIHBhdGNo
IHZlcnNpb24gYWNjb3JkaW5nIHRvIHlvdXIgbmFtaW5nIHByZWZlcmVuY2VzPw0KPiANCj4gUmVn
YXJkcywNCj4gTWFya3VzDQoNCkkgcHJlZmVyIHRvLCBhcyB0aGUgY3VycmVudCBwYXRjaCByZWR1
Y2VzIHRoaXMgY29kZSByZWFkYWJpbGl0eS4NCg0KLSAtIA0KVGhhbmtzLA0KU2FzaGENCg0KDQo=

