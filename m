Return-Path: <linux-kernel+bounces-539454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16656A4A477
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 21:59:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 790C216D3BA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 20:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4661C5F2F;
	Fri, 28 Feb 2025 20:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CmzvJtmc"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C969C1C5F10
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 20:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740776357; cv=fail; b=p7EZlHy1fAtsykPnkLcy2agzLWhfJHZy1M4daENOfPQ9fvb/V/dJROtRnwaUIkStCIhxE7mPZJIG2UxdX5jqtgbHK6bBe8q0iPMzZ4YE0pBQAwREuT8vIB1Gi/bhhO5CbgRIuoMxCzCOSBSfvfN4fGoWYzPFofmUAgKw96OW4dY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740776357; c=relaxed/simple;
	bh=+wqWlNcfGP4euc5r9AQc7lkp663KvmRGJPH7DJR6PhA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Pmjdakx24mSwghsUTvKPAqSgYIZL2IqEhJm5dkrcNAKqLECDQr0jMDhX0HQ83zSFNoUX7h41RZ9AjqKpUuLdghGYbqQlqYxAYJfO1wnD88pgSRZQk3iWUsP8g2EXMKb2yX7CK2WuWb+HBHucbuBHy3qFeR8ssV62z9EGHa+GMQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CmzvJtmc; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740776356; x=1772312356;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+wqWlNcfGP4euc5r9AQc7lkp663KvmRGJPH7DJR6PhA=;
  b=CmzvJtmceh7X/EFIWri4KerchPKvH8XEyHus3L2dl86iPYPh/aMlIGlJ
   ecrhFmXChdTJUJoIyDIzrHe9w7bCLnBsNO+KbxG0nLM4WrXgiDgFoUQXg
   I8/CYexbxsC1QN0+wQV5ibCSoG60i6I5ikl8+9qktFSLqEFzZuN0q/MXu
   7PF0F6nQ2a86eBHxJw40KrjYJcPTChzvAjLao0HA6eoq24/y8Dqb65MJo
   OuyERU7dxqcsi+31V3houcvbEQ3+xhHRuBq6ZHlqKbyd60SjeGv7Vj915
   r9Ir5RiHuh9oNnT9IIDEkY+FdZMtutTPRniUydWif4uyLSFGBjo1x6WzW
   g==;
X-CSE-ConnectionGUID: ZccJZ6ttR4abEQo7nl3xJQ==
X-CSE-MsgGUID: N6T5tki1R7OwY592I3lB9w==
X-IronPort-AV: E=McAfee;i="6700,10204,11359"; a="41603763"
X-IronPort-AV: E=Sophos;i="6.13,323,1732608000"; 
   d="scan'208";a="41603763"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 12:59:15 -0800
X-CSE-ConnectionGUID: frCYvif9T9ql3wFXfc5FXQ==
X-CSE-MsgGUID: zc5NRKJtRaOfmZ0lolW6nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,323,1732608000"; 
   d="scan'208";a="117939194"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 12:59:14 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 28 Feb 2025 12:59:14 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 28 Feb 2025 12:59:14 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.45) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 28 Feb 2025 12:59:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VXngp1yZRg5eWKG9DPJK3Tnu6S0Sc3TXOxtWYINEMtDbHUNxV9AvceF1zUbu4nrO7/wtRYwyl5IervXYHwUA52Y1Fr93Uw3bOaE3OIDqgcWj3Q3yXcu4BWaJANgNfIKY8rDLuA8ZTWz7KIpJohYzTl2XAeueJYeGE/3Its8sryozUmchxd5KoiYcJlOwTkbliqJ11WOSHKVnTpG0CnqxlWvV/o5zU9Ba5af6gGs2CqD/M1YUwVAjS8QxyjafL1+9Mveur0jDmLkbJa2p3UrYzZwfgKptLw2ca5dPnyeQtefqeK13tejaAFX7utBhp5iCVVC/wYIFqy5dopuVd9KlwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+wqWlNcfGP4euc5r9AQc7lkp663KvmRGJPH7DJR6PhA=;
 b=ZvZkGFiLjXTBu9yaTJ8tfCmCauoZadhg862WOs+NepGmSDE1VUryCVwbSyhKZJ3xbCByN9qId/lJGhVTenfwuCoPfwN9pJUnO58Pj/pAdnjjXKvJXEJVL0r6Z4jFWG4MexPpA3dIP1tWfs2F9ml6bLaGIYobTrizbzMY251RnlK+9YBwdy9KxPqvIdyCNm6FlVkRfQLPU2jM2EHl7VibOkcWyhd8Q/sgU04zyDwT5iJVZcPkP1f1NFneH7e2j1pSFi4aVCvzrhrOC3hogqHGf0Eckfjqlwc7N6noRP3PdoPclUkyJWd1CbPA5MN49liNGComEilWaxwyAEWXcJGM0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by CH3PR11MB8155.namprd11.prod.outlook.com (2603:10b6:610:164::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Fri, 28 Feb
 2025 20:59:10 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::acfd:b7e:b73b:9361%7]) with mapi id 15.20.8489.019; Fri, 28 Feb 2025
 20:59:09 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: James Morse <james.morse@arm.com>, "babu.moger@amd.com"
	<babu.moger@amd.com>, "x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "Chatre, Reinette" <reinette.chatre@intel.com>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
	"shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, D Scott Phillips OS
	<scott@os.amperecomputing.com>, "carl@os.amperecomputing.com"
	<carl@os.amperecomputing.com>, "lcherian@marvell.com" <lcherian@marvell.com>,
	"bobo.shaobowang@huawei.com" <bobo.shaobowang@huawei.com>,
	"tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>,
	"baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	"peternewman@google.com" <peternewman@google.com>, "dfustini@baylibre.com"
	<dfustini@baylibre.com>, "amitsinght@marvell.com" <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>, Dave
 Martin <dave.martin@arm.com>, "Ko, Koba" <kobak@nvidia.com>, "Shanker
 Donthineni" <sdonthineni@nvidia.com>, Shaopeng Tan
	<tan.shaopeng@jp.fujitsu.com>
Subject: RE: [PATCH v6 36/42] x86/resctrl: Add end-marker to the
 resctrl_event_id enum
Thread-Topic: [PATCH v6 36/42] x86/resctrl: Add end-marker to the
 resctrl_event_id enum
Thread-Index: AQHbeY0jJx1L8yPTD0W0D6o/t4DA9rNbuLEAgAGJl4CAABDSEA==
Date: Fri, 28 Feb 2025 20:59:09 +0000
Message-ID: <SJ1PR11MB6083221B0AACE9A732EED878FCCC2@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20250207181823.6378-1-james.morse@arm.com>
 <20250207181823.6378-37-james.morse@arm.com>
 <f91e1dd2-2ab3-4c23-893d-a87d4d38e43e@amd.com>
 <7562c41a-42f1-4d33-a543-d92ead1d72da@arm.com>
In-Reply-To: <7562c41a-42f1-4d33-a543-d92ead1d72da@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|CH3PR11MB8155:EE_
x-ms-office365-filtering-correlation-id: 8c0e48fb-5fbb-42ab-2e4a-08dd583abf63
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dk5tTmZmRUdpUFp4eSt2WUo2VTBRSDBTRjVmc25nVXZuL3BSWmc1aVlGUVhs?=
 =?utf-8?B?enFROWZwU0RnZkZXcVNoNkdWcVZJaGhnUFZ0UHg3bDRyMHFHZFFDS25OZ3lY?=
 =?utf-8?B?U1NjU2gzWjRvNWs3ajU3Qk5sOFB3dFduRStmMXl3Sm9jTllkK2NvU0pZRmxw?=
 =?utf-8?B?RWZucFhsQ1BjcjBZV3AwaEs1ek8waFdGOGoyY3VxekxXWjdySGpZRk0yQWtw?=
 =?utf-8?B?T1B6NTlhbTFQaFJWQUp4NXQ4SVJvbmhwZEZGZVA0SDZhUW90L2krTjd5dWc5?=
 =?utf-8?B?QStlWFFOVkpoWnpLZ1Z3SXdKUnFWQ0JWbWtXMllKalZOZlVEZ1dYMFNCaFJs?=
 =?utf-8?B?M0ppOUNFNllTUUlyQW5RTG9wM2NrRUs0TDBQQk1hSUY2UERsek1sRUNWL1ht?=
 =?utf-8?B?RS93U0NJVURybzloaVBIWEtOeVpVOVI1OGU3bEV4UjNWUW0xQno3TytsS0tx?=
 =?utf-8?B?S0Fvbi8zSCtES0tQZy91WUo5bmdYUkJJSTVXTU4rQVVFL0s4U3hKcFh1cnlt?=
 =?utf-8?B?REw2SXpRK05DN0w2bGpEaUxNOTI1OFloa1ZSMFNUL3BBZHNzL0pzdXptRlVW?=
 =?utf-8?B?aTE0ZXBNWGZ0dWtiR2M2ZjdlRWpnYXNKVFBZZUpTV2RHcElLK3l4cTJCa2dK?=
 =?utf-8?B?ZXBrOUdnQWF6WSttL21sMjFpMVNFakFuMkk2d2dqUzh4cy9aUkpJc0JKeUZG?=
 =?utf-8?B?UEZmd1hFM3JzN24xeS9pRHV2bmkrZDBTRytRZmFFZ2s1Vzg0S3N1RDdwa1Jk?=
 =?utf-8?B?c1QwR1hQNzVsT2RPTlNTRGI4WnRwTDg4NzhDanVBVXhTbHNhTXR1RjNtcHND?=
 =?utf-8?B?UWRBWVBNMzhLLzFZbTRXd2psWHpBQ2R6RDJKYzNkNEFoYVNjVDVHOEplMUlW?=
 =?utf-8?B?VFR3NVM2T0hjVkV0d01oQ0tpdzdKYS85M3FQUFE2TmRMNmxCSVJCdjhlYkJT?=
 =?utf-8?B?MEM3UHdGRVRJNlFqRFlPcjJMTXhzUmw2d2E4RDlMYmtiOGpUaWh1eU9xQW5N?=
 =?utf-8?B?ekJDbUdMblpmU045TFBWdFhWYlA3ZkEvR3VjRURaemxTZmpmYnZvc2pScXRt?=
 =?utf-8?B?MEszdFdZYmM1UFVDSzlQNE1iRmYvdzJYZ1pBQ2t4ZXNRZEF3Sm1BVWY3SWtk?=
 =?utf-8?B?cy9wRzdSZ2wvdE1haERoTFJIMm03SnJJamNOcnZ5ZFJxYmlEV1RoMEN0VUI3?=
 =?utf-8?B?b2JJWTNhRXlJUE8rUC9tUEV1Z3ZpNWpaWG5id0dFeVpIdUhTSkRZR0NkQ1Iv?=
 =?utf-8?B?RmE0cm91NktNb1pLK1lkOHRKdS8zV25BSGgzMVJKWSszZ25PU2l3SmlQeTRB?=
 =?utf-8?B?RnhRZTJISTVMK24yekgxVi9XM3MvZ2ZHVmwyZDNtbmM1MjJ3Q3BEKzdnaFpS?=
 =?utf-8?B?VmpjVVpsUWR2QkhLT1UvcTY1VnBLa2EzN1B0MVMzOVhiRDFFY2xFMGpQQUEr?=
 =?utf-8?B?MWNlRVNHSUU1b2N1dUJsSmNSMk9uRi9oZDhwSGVjbVJpRHBTdjNXSm5ONWtu?=
 =?utf-8?B?b3BOZjZkeG8wUStSRm94TjVhUUpmKzNjV3k0VFZLSGtIR1RGbWxpWlRYRG80?=
 =?utf-8?B?dDNzTURQTU0yS1VicnpMdXRRVEY1Q0FFSnhOdlhibFhCakQwd1RHNWpQK2lE?=
 =?utf-8?B?elIyRUoyVEFFWmsyMzFiTjJDYWFaSHlSZmRHS09hbEtQT3VDNUJ3VG43SzQw?=
 =?utf-8?B?VVA4c3V2RlJYdFlFRng4RHBXMTl3cmQ1cGVhSndwZnpReVpnREs2QmlXY2ty?=
 =?utf-8?B?L0U4T25yOHJzUWRqZzZvZEphcjFVdjFQbWpyWUZxdkNaRGlSVGJQcEl2Vmp2?=
 =?utf-8?B?M2JBVjJ0dU5YMVJXbkdNNmQ1bVNYR2FUMk5VTlNROFRxdUdHRk9tV255QzVW?=
 =?utf-8?B?aTdKajZJNThoUHFBUE82ZG94MWlycmlhejN0Sm1NWGdtU1B6bmgrYlFKMi8z?=
 =?utf-8?Q?8LQ6ljlNaGpKmsEN4AdmwWA541qy30Q4?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QWh2S2hSbzJWUlFQZWEzNDRna2Nxenp0aVEwcHlOdC9Xc2JsQThIb2cvRlFa?=
 =?utf-8?B?WXNGcVB3bkFQaHI2TFI0NXZhanRzUEJpTU9VL1lQamxtbFZxNTl5REhLNmYz?=
 =?utf-8?B?TXUvdm1IMkdaMkpQZVJmR0pOUVYrQmpoMXhmQW5oNnRzbjl2QWxTTGRaeHY4?=
 =?utf-8?B?WUhBOVljcnNaTm9XTnhuZW9nNDJNU0ZKY1ZXZEVwRnEzVGZyUFlPUEJzaWpL?=
 =?utf-8?B?elFXeDdKMTZuanltYTNNQ2QzMHREZ1NxRHRSaW1rS2Z4cGxLNURqbGsvQ2h0?=
 =?utf-8?B?YUNoMm5zUWxsTlpWTTh5UVRtSkpLcEROS2MyZEs4L2NjM0tsSkdaL1c2dTNM?=
 =?utf-8?B?eXZCZEtxNk1uTFR5Vmowcy9lUXRnQ2VqOE1odU1rbS9haFZIdDZQMExnUmps?=
 =?utf-8?B?bWU2VHVkSW9kWTQ1L1YxMktnS2haamEwVEIxSzdIdXNwemNwWS82MERzVGE0?=
 =?utf-8?B?MDA2eTduR2tWZnh3NUQ5VU9oYUkyejNuK3JQdUIxOTVwVFhtYmVmUDdGVmd3?=
 =?utf-8?B?QkNsOHFJR2FCbEVpKzFRdTBHeTF0NFJsdC90Q0YzUHlnbDlWcHI2SjRiUWJC?=
 =?utf-8?B?d0NvWFNCandqK0FaM1phNElyMVd1djlKZFl4R0NXQzIzQUltcm8rNzRQUmhm?=
 =?utf-8?B?bUJJZzNsWGMvS0xwRjc4NHFsYWgrZTBCL3YwanlEeEZORVFiQ05KRVMyakh5?=
 =?utf-8?B?WDRoWkVrZ1BWM3ozWEgwVkdqUk5LaTBGWXpLK3RNZWNpYWsydmFOanhpRUhZ?=
 =?utf-8?B?ZW1wUEpwRk5nN2NxQklYUG05dTFDRkZVRy9vM0k4a3hqV0NDM2NyMXZJSlBa?=
 =?utf-8?B?S0RoWC9jV1JsS0hHRTFyMU5kZ1lUeFlINDVwcUg4cWMrNU15eU44VGVOK2t1?=
 =?utf-8?B?L0s5MzBPN2oyMkVyeDRlQThMSFlLZnA0RTluZWVnd25yN3FBeHkydW5nVDVx?=
 =?utf-8?B?TFhtQXhBZk1hS2VZSVZ0TjZPU290a1hkOG1BcVN6cEZNRndVWjlvbUIwYnF3?=
 =?utf-8?B?NmtoTUtCUWVvenljRkgwVjBuMWJDOE8yTlN3UmRVRE5qeGtxWHFMMXNjbjhO?=
 =?utf-8?B?L3FHL041U3AxbVpkR0dxUkQ0bm50b0hUQXV2WG8zVkdQc2Q4c0k0aXFFbEZT?=
 =?utf-8?B?M1M0SThnZFJ3OVMvOHdFemJORFlnZlBma3YzOHJzTUhJOEpjWmVzVGF4YnVx?=
 =?utf-8?B?ZENDb2d0TTE4NisxTllHZzZoOVBMN0M1U3F2TGdTNXNGREtqZElhalgvNDh4?=
 =?utf-8?B?T3BTaFR2K25scGFSdXZjN2x5eDNmNS9rRmZLdjluY0xVS3hqSlhaUUpXNmJW?=
 =?utf-8?B?WFVOUUZmMUs5NG5uM2ptb2JMbjU3cExTN2Z5MUNqTDlVSHd1ODI0MlJhcm5q?=
 =?utf-8?B?UFBpM3FjeFF2UTBsd0xIdkUrMHdsVFMrYlBEUmp6NTh1Z0xBc25TRlZ1OFpS?=
 =?utf-8?B?V0RRTXBNSGhqeUFRQXM1cXh6bHc5Wms2bCsxZWdpTzN0b2UwU0wrZmNrcm1N?=
 =?utf-8?B?dURUTlVDN3RoUjFJcWFMd09xR0JpTGUwZXZZQWlqMEZWNTIvVkJ2MTBLdXU4?=
 =?utf-8?B?Z2E3S3F3QldneDNpREdyZERUeFVKRnE1SFZjaWZsNXZwcDZEN09uYlRWMU1S?=
 =?utf-8?B?NUp3REJPUGdHdFZ5VzlybW5rM2NxVlE2TjJ5emZ0Qkt4OWhrVUhpczcyVU1T?=
 =?utf-8?B?RVdmd2llSjlrOU1nMDJ5TkZIeXFWdkVYWDBxQ3pYMjhYV09EZ0l6eHFuTHFD?=
 =?utf-8?B?YW1jaGFqeGdNeVFnaHNmMzBNS3djaU5IUXlSOEZTT1hXQnBydlFDWHN2bThG?=
 =?utf-8?B?ZFNOR0NyQXZqWDc0bE5IUFFVMmdSbFVJanlWUGd2MU50L0FiSFUxUTlhaVBm?=
 =?utf-8?B?U0FENjZSVkxMeUlRaXhnN0ZwRzJPNTRCMlcvcWFDUzI0bytSVUhxVWxIZHVZ?=
 =?utf-8?B?SllMWFdxazBtZzdSSEEvWVNhMEZSTDVBcXc4TGJjVDFvTnNKYnc2RHpRakVL?=
 =?utf-8?B?TzgxOENKYXdsM3ExQitkZ0JqTk43Q21teDN0UUI1OXZmMDFPUzQ3WDVtd29r?=
 =?utf-8?B?V1JFVzMyM3doY0hsTkpZcnd4UmI1MXRtT3pBSW11QzE3NVBWNmNUUVgzSXZE?=
 =?utf-8?Q?BgV/WB4zlyIBslP3NvTW+W9dD?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c0e48fb-5fbb-42ab-2e4a-08dd583abf63
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2025 20:59:09.8612
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hfBi/8jppKd1P8ZaWGn5I+HTcOJXjO3AGjFkkb3IhUwfnIPjYPyjLkhjoEoRiphjO5E6aCc3t24bl1RvrxcN7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8155
X-OriginatorOrg: intel.com

PiA+PiBAQCAtNTEsNCArNTEsNiBAQCBlbnVtIHJlc2N0cmxfZXZlbnRfaWQgew0KPiA+PiAgICBR
T1NfTDNfTUJNX0xPQ0FMX0VWRU5UX0lEICAgICAgID0gMHgwMywNCj4gPj4gIH07DQo+ID4+DQo+
ID4+ICsjZGVmaW5lIFFPU19OVU1fRVZFTlRTICAgICAgICAgICAgKFFPU19MM19NQk1fTE9DQUxf
RVZFTlRfSUQgKyAxKQ0KPg0KPiA+IFdoeSBjYW50IHRoaXMgYmUgcGFydCBvZiAiZW51bSByZXNj
dHJsX2V2ZW50X2lkIiBsaWtlIHdlIGRlZmluZWQNCj4gPiBSRFRfTlVNX1JFU09VUkNFUz8NCj4N
Cj4gTWF5YmUgaXRzIGEgZGlmZmVyZW5jZSB0aGF0IG9ubHkgZXhpc3RzIGluIG15IGhlYWQsIGJ1
dCB0aGUgcmR0IHJlc291cmNlIGFycmF5IGlzDQo+IGNvbXBsZXRlbHkgYSByZXNjdHJsIGNvbmNl
cHQsIHRoZSBwb3NpdGlvbnMgaW4gdGhlIGVudW0gZG9uJ3QgbWVhbiBhbnl0aGluZy4NCj4gTm90
IHNvIGZvciBmb3IgcmVzY3RybF9ldmVudF9pZCAtIHRob3NlIG51bWJlcnMgbWVhbiBzb21ldGhp
bmcgdG8gdGhlIFg4NiBDUFVzLiBSZXNjdHJsDQo+IG5lZWRzIHNvbWUgdW5pcXVlIGlkZW50aWZp
ZXIgZm9yIHRob3NlLCBhbmQgaXRzIHNpbXBsZXIganVzdCB0byB1c2UgdGhlc2UgZGlyZWN0bHku
IEkNCj4gZGlkbid0IHdhbnQgdG8gYWRkIGFueXRoaW5nIHRvIHRoaXMgZW51bS4NCj4NCj4gSWYg
dGhlcmUgYXJlIG1wYW0gc3BlY2lmaWMgZXZlbnRzLCAoY3VycmVudGx5IHRoZXJlIGlzIG9ubHkg
dGhlIHJpc2sgb2YgYmFuZHdpZHRoIGNvdW50ZXJzDQo+IG9uIHRoZSBMMiwgb3Igc2NhdHRlcmVk
IGF0IHJhbmRvbSB0aHJvdWdoIHRoZSBzeXN0ZW0pLCBJJ2QgcHJlZmVyIHRvIHN1cHBvcnQgdGhl
bSB2aWEgcGVyZg0KPiBhbmQga2VlcCB0aGVtIG91dCBvZiBoZXJlIGNvbXBsZXRlbHkuDQoNCkFs
c28gbm90ZSB0aGF0IHJlc2N0cmwgY29kZSBoYXMgc29tZSAic3dpdGNoIChldnRpZCkgeyIgY29k
ZSAuLi4gaWYgeW91IG1ha2UgUU9TX05VTV9FVkVOVFMNCmEgbWVtYmVyIG9mIHRoZSBlbnVtLCB0
aGVuIHRoZSBjb21waWxlciB3aWxsIHdhcm4gaWYgeW91IGRvbid0IGhhdmUgYSAiZGVmYXVsdDoi
IG9yIGENCiJjYXNlIFFPU19OVU1fRVZFTlRTOiIgdG8gY292ZXIgYWxsIHRoZSBvcHRpb25zLg0K
DQpXZSBkb24ndCBoYXZlIGFueSAic3dpdGNoIChyLT5yaWQpIg0KDQotVG9ueQ0K

