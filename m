Return-Path: <linux-kernel+bounces-213638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C749907831
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 18:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96AE0281755
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 16:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A641474B5;
	Thu, 13 Jun 2024 16:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CJSwJKi2"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93085149DF4
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 16:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718295675; cv=fail; b=q2hyHJJKNI72c2wAa1J5k21o/UZR0ybhkIBGsoS/vmToNQhrg/bw4e3t+Iok6dknQrNv/O8gnMaZkNPXgti8NYPmZdIXCOtVZUnlbbmXa3NckFVa1sST2iUXwAx5hQgp1W/g0BC7ciXondk9Vv0tBFdqrmrfoUBfv011d3md8HQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718295675; c=relaxed/simple;
	bh=aOn58chPagjuvMdSTQphV5b5hNqHWkTz7u/4jOW0wPY=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AqOtLZrhRdO42HEIwQhBrW5HgNTTZDiEHH639aIV7HFsSdGU5YZuZ8WkT4GSS+BGiXlLpycVut+6ca7DWe2JHzeTcMKwbsIsgf0pwrW45V/xB615ogkQWZhXsiRCpFwdSY/80rMQD50OLmB3HvkQ3u2kT4v9aDjKbqznrwTpqwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CJSwJKi2; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718295674; x=1749831674;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=aOn58chPagjuvMdSTQphV5b5hNqHWkTz7u/4jOW0wPY=;
  b=CJSwJKi2Y0JvE4Kez7Nnx7t/n+ivokVKNCsqYLsCwhtaT2n1ZoiHK15x
   +xiwl/Kvxpfd2+fe6SJ4FlqrhUaOY3MPxnW68PbA2O1rkeY4HGvnFh4q5
   xPOOFgFHLdupehG0UKmlkSzBf2PMD3QlOQVAibh0InIIM98+o/0BVXf3U
   K7ShzN+imEcDj3HpbfKVOdTBt+9lCrq9HCZCpTctBfJBmpWq8wI7gXVaz
   1cFnLHRa6wqAyshgUim0itFYk+BHnXGdaqJxrEV8SjXf5jwCtyGs8kxBi
   PwN1WR9Abo/u2pOWzZhJ7i0f4SAvu1BjdA9GtAbRPR4ozH3LfJAki1Kgo
   g==;
X-CSE-ConnectionGUID: aqDHd785Qom5dSTvusBRfw==
X-CSE-MsgGUID: 9NGqaqNKQ7K83uXcEfY7fw==
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="25715146"
X-IronPort-AV: E=Sophos;i="6.08,235,1712646000"; 
   d="scan'208";a="25715146"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 09:14:01 -0700
X-CSE-ConnectionGUID: S5tByiwKRhWx5t25yi7U4A==
X-CSE-MsgGUID: Bb39DMf4QK+HaPhf5tllDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,235,1712646000"; 
   d="scan'208";a="70986510"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Jun 2024 09:14:00 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 13 Jun 2024 09:13:59 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 13 Jun 2024 09:13:59 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 13 Jun 2024 09:13:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G7Xw8vhndlL/jdm2EnPlSfyrGbEtbe5AYy6KD1cz2yEfUPEnX41iYfXcemwC8i5OxS7EIA86f3nzkXaXqJfNptxz4KNVgw8hEL3kDEvOsd4J6caHI5I7tQVULks/RF7ByIwMgjBbPcY/fz7+rPIu6wLXj80oNWcdngTTL0F6cKBu2sQJWqrYu7FWLbRJckQGG08cgJbcXbVuSH8UXb3noAeSwR8lod8Yd1tazjGnF436awIZiDVIgG3u3RVs4jhV6sYf1bSU/q5vNClkYh9EWiIZV8vKwpwkb0stLt/ACNwouh6Xk63YmhH5FwGieRDGDNA0YNoDUNis+P2aQFPmLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aOn58chPagjuvMdSTQphV5b5hNqHWkTz7u/4jOW0wPY=;
 b=VpBmcSypzVsK0edR/u28tHCidVqtioAEA4Iq9wyke6zk71jUUIz5E5A6Xo+tzC3KQXr1PycP+6eE79W0V817v6zHjlwtYyanWN9OoTJUGdNkaw0qEGtGKsF0IMwXZpmkQ+/i3yeJoqH6XOgPVIAdz6eBsHfxTaKLNtQ4VqFB3VsuvkJZDfWGSmtmAT1Xzsq9lStHsaB3DoBXoDnyTQ/doPOGjiRJg+GeqNG5wL4pcG8weQDe9+HlK3Fuh03DQfnc1tSx7GaIw25Fnb5oCvvPEZ49i2WOOL0Zi7EQfpDtRDR0SAYfx74CM5HjLxmFjNXQVC9SCGRyelp2nuC/l4dZrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV2PR11MB5976.namprd11.prod.outlook.com (2603:10b6:408:17c::13)
 by SN7PR11MB7491.namprd11.prod.outlook.com (2603:10b6:806:349::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25; Thu, 13 Jun
 2024 16:13:57 +0000
Received: from LV2PR11MB5976.namprd11.prod.outlook.com
 ([fe80::d099:e70d:142b:c07d]) by LV2PR11MB5976.namprd11.prod.outlook.com
 ([fe80::d099:e70d:142b:c07d%3]) with mapi id 15.20.7633.021; Thu, 13 Jun 2024
 16:13:57 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, "Hansen, Dave"
	<dave.hansen@intel.com>, "lirongqing@baidu.com" <lirongqing@baidu.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>
Subject: Re: [PATCH] virt: tdx-guest: Fix the decrypted failure memory free
Thread-Topic: [PATCH] virt: tdx-guest: Fix the decrypted failure memory free
Thread-Index: AQHavawihwGjZ7/u30eHuKhcq8lQN7HF3gkA
Date: Thu, 13 Jun 2024 16:13:56 +0000
Message-ID: <5e059a683582799f8676b77052aeab2597f97e60.camel@intel.com>
References: <20240613111931.43123-1-lirongqing@baidu.com>
	 <32eddae1-14bf-42dd-afdd-7dca8bc8a131@intel.com>
In-Reply-To: <32eddae1-14bf-42dd-afdd-7dca8bc8a131@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR11MB5976:EE_|SN7PR11MB7491:EE_
x-ms-office365-filtering-correlation-id: 62ff3d81-fb17-43c4-32b7-08dc8bc3d3e7
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230035|376009|1800799019|366011|38070700013;
x-microsoft-antispam-message-info: =?utf-8?B?Z1JNOXhDbWtpQUF5cTNuaWlJejZITkRwb3JOOFlrbVYvdnBORHgzRUtMbWFa?=
 =?utf-8?B?c2dmeW9laE1OTkt0eXdSTGdMNlJpZEhndzExSnQ0ZmlTTDdXeFdpQ1ZYelVs?=
 =?utf-8?B?cTJtMG02bEdJdFllQ0xjOFhvcjdCSjF4V3hBTUZxYWYxRDlLMGtpTnJlQnlF?=
 =?utf-8?B?am1SdEJmVEdVV1VKemNVTWhpd1BSbzZSSnViOHZGaU92UWFzd29UVnFBdCtW?=
 =?utf-8?B?LzB1SHdFSUVNdFRCYTVHZ080SnZBcktHVUlmQ3p1YjE3NGp3Sm56UWFmWnkr?=
 =?utf-8?B?MUlpeXZqWlM3T0FqaDJLK1lXakI3VVZrSVpEeWFkdmd2dVJaUEdzSEQzeEYy?=
 =?utf-8?B?WGdJeW1tY3g1UGR4bms5bUx2bGZZSTZtaEY2bS9GU25XaWtrejlQY3BoeE8x?=
 =?utf-8?B?RkEwQzR3QWlKeHpuNjZyNXVtQW1xMG42OHB1RWhpUnNzMTlYc0dadnQ0Mkgz?=
 =?utf-8?B?RjdBbVYwSERZTnFnVSs1aE1KNDJCd2JqcTdsU2RQdTVLZUhzbEN5a3d1QnN5?=
 =?utf-8?B?VkNMTFlJTEFDNmZ1TDlQdm4rS3FIMndnODZ6b0JnL252YkhTMlF2bDJBdlFs?=
 =?utf-8?B?S3hoVVJuOGFNQm5VZ3pLbDY4Qy9IMzgrNm9id3lLYTJpWFVld3BSRS9RMGhz?=
 =?utf-8?B?RUEzYTNxc0NPYUFIQldsVDZOS1NBVndOTnV2cWRFMmk2S1JoWHRYVkRHb0Vx?=
 =?utf-8?B?ZWJCeks3RHZDNjR3MkFPcENlZnZvMW1wVG93VDBVTC9pQmpQZmJBMkVsVm9x?=
 =?utf-8?B?eDN1RXI0M2NvRVhJaEdrc0Y1SWZXQ1dqVnBVODF3dG5ycTZXRFZibEc1dHRZ?=
 =?utf-8?B?aTBUQkhHLzNnZFhwdFY3a2pHVEc4TzNrYkt2M05UYXpIQkp0UXhVbmtGYk02?=
 =?utf-8?B?Zlp3WWMwM29hYVdUZG43U1pDZUlCNE5hdVA4UW4zanNoT0IrNFZmWlQ0RlJl?=
 =?utf-8?B?Q2sxeTFRU2h4WVo4YTVMckFTam1MMkc4cmkrSXh6eENoZnNrQWIyNXBlbXI3?=
 =?utf-8?B?QnhDeHVSUXFacVhvKzRYZG0ycnNFN0FtaXhKZlZiMEhSdjNjeHB6YzhTdHRN?=
 =?utf-8?B?SlhSRFk2LzlQdW95aXlvUWFQZzloR1hnc3hGOFhudU1QMEZTcEJCLzBVYWdk?=
 =?utf-8?B?V0s3VmRlVldSNlY3azBxcHVMSkVtQ1Q2bE5RMWx2MUVVSVZZNXRFT0hTaFRU?=
 =?utf-8?B?eTZoaDlFbnlzMDB3VFRiM1V0R1F6ZGErazE4RTRFYnB0Tytmam53NytyNmxu?=
 =?utf-8?B?SjlxSDdTTnhueFhGbmIxNkZtZGFPWTNKL2lEVnZJenAxWTVlbzZNeU5GQnJ4?=
 =?utf-8?B?aFJOWnhGdWxnckZYdDl6dE9JWGd3Q1krYXZ4RjY0R0JXNFNqbGVWSEs5aWZC?=
 =?utf-8?B?b1RHS2RBTEpKMXNiQlI0Um5qd0JjdE0zeHRlS3JwVlFxMUJldk9pejV2Wklz?=
 =?utf-8?B?YzFUam9oWklGRjhoNU5kUURweGJLNElNajJpLzU0a2NPK2xnZGNoaCtHd2xq?=
 =?utf-8?B?R2xZREtZeDhMazRPYWdBSkxpS1NKMXBsVkNmUVVhMGVuOHVCSndQcUN2L3cw?=
 =?utf-8?B?ZVBnRHpIQVZJeEtwQUYyVTNtdmNRaTlOOExMMUt6SVBrWjBZZ05Id29lTUhq?=
 =?utf-8?B?UUtNWFNnOEhzcG51aTV4WHRGWVByeG5XUmlKVEhZZmNwVEw4dTVCM3JpNVBy?=
 =?utf-8?B?SHJqVElZVEdpVzdWelZQTXBsSU1uQ0M2bXM5a3RESmpiVUhNdUU0SFFMbEFt?=
 =?utf-8?B?K3pSRVBoZ1NpQ2JxZVJCdFFLcWdKQStxRlN1WjV0RWc5NGJ1S0pXOTYxT2lV?=
 =?utf-8?Q?wmi4e9eY6zyf/YnvGW3vKDetxjbsf3/g6a8LQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR11MB5976.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(376009)(1800799019)(366011)(38070700013);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SzUrcHdzc0o4MjZob2thKzhiTkxRZFJuandqM1dnb1k2UnRyc1ZlZnBmK1Bk?=
 =?utf-8?B?MlNTbmNWOWVBdVdEb3YvSHZyOS9vajc1NVl0c212UlhBT29UQVpSKzh1U1ZR?=
 =?utf-8?B?QVZaaUE4MUV3QXRLK04vb3FIcDhJdlJ1R2JyakFQbVRWRUxjZThhVzRIbEl4?=
 =?utf-8?B?aUd6UXZxWndkNlBHNGQwdFFqVXBpZzRUWURBSXJscWM4dkNXWkZsMVhleEY1?=
 =?utf-8?B?UlRDdit1a3dUWnc3dFhva0xHMjRGNTVDTlFJZHNNSXlJL3MwY3Z4dExpZ0F0?=
 =?utf-8?B?YTZCbW8zZDZ2eWwzVlhzWXVzcHpPeTdMQnpPSVRTL3FxcU1pUFg4MHFHUk81?=
 =?utf-8?B?VnFwRGtzTkRldTFKMmhHVVA1Z2J5QUUyZUZMaTk4cXFrR1RkUy9oUDJvTkNz?=
 =?utf-8?B?YWZlWGh0MjB3Ri9vVHM4Szh2RkNRaFBwNyt3MkxucVVlcUkxQnNjbis2V2pX?=
 =?utf-8?B?Q1NualMwWUFoZnFmMWNsalVRbFkxOTFNVTBQVEZzazg4Z1cySVRuTDFJRmFs?=
 =?utf-8?B?R2xURDFjNzd0WnZCcENjdHIxcVg0QkpIM1ZONE0yQ2ZReVorSHZ0TUFOT3dt?=
 =?utf-8?B?ZklXbVd3S0NnMkszQk9qYnoycDFRUENhaEJmQnh4OCtiUkFKeEhHUUtmUmV0?=
 =?utf-8?B?b25BUkE5R0UyYWxGb3Nma2hpSFQwVUwzY3phOVh5TXNNVk5Vd0syMVA1bS96?=
 =?utf-8?B?eG9BeUx5b2wwa2xwcXpUQXo1QWJkUTR0YUtmMHRSZ2ZpOHFzaisxRmN1aVVP?=
 =?utf-8?B?VUZtQ0wzc3phWWMvdkhKejFvQTdsRnNpVDFaSUxPSUo3R2RoM2wrdDJraDdt?=
 =?utf-8?B?T0hoM1F1bXFlSDhjeEJOYXBLSFN3bHNQRWRYMjJ6cHdqdjdZNFBOU0xlZ0l5?=
 =?utf-8?B?RFRoanZMTHpOdC8xaEVyQi9oT2dua2ozWEJ0WVMzVXBXOHZrNmJiS0ZjSnhm?=
 =?utf-8?B?Q0hEMk9yV1liQ2tHQTExbTl0NEtDVUY2MDR0VmU2L01CcmhKZk8xTi9Zekxs?=
 =?utf-8?B?U1VOLytMR3FkNXdSZU1UQW1sT2k4OVVyTDVPNVBDZ1VyTjFDd2tVZEw1bjBl?=
 =?utf-8?B?YUFFeDVRaDQ4UWlEUTN5azlndXgrMlZVNGZSL2F0ei9vR2t0dGQ2bWRNcmFH?=
 =?utf-8?B?R0VVYnovNTR6bTdjN3lFdUgxRUYrS3IxU25hNk9rWGg2aUFGS1NPQ3M5NXdV?=
 =?utf-8?B?OThOaStjVzE5VXFnbWFLMUYrbmsvT3lvcHFyVGRrT1kwcTQ4T0t2aWNETUVL?=
 =?utf-8?B?QkVKZm1zK3F3WWExMnFJQjU4d3JXVm1JM0g3UmNrUjdLRmRGOTBYaS9WYWJ1?=
 =?utf-8?B?Zk94YzVUZVp2R2xITlhrSXFJZjdQcDFTN2FyWEhrem9qTFBXMlY3dFl0Z2ts?=
 =?utf-8?B?dGVNbkR1Y3pMaEQ5MVMxUkZsakViNkN2RGVMWElDVFlYaDF3d081eFh0RTdR?=
 =?utf-8?B?emZyeG1FS0pSS0YvT0p1MmFVSDNDM3BPeFdHYjkrNURQNjdHbFVETi8zWG9k?=
 =?utf-8?B?dmp1SkZFdHJXUnNUemtwa3JvREVVWloyR21uY0RVVW1mMW1zZkxHMFl4aEJn?=
 =?utf-8?B?UFpITSt4dTZQR3EyVUJxdDlHVW9TTGZuOE83M1BiYU9TWlFZU3NMcHJuVHhE?=
 =?utf-8?B?dlZNRk1ZTjFBM2RCU2FOY1E3ZStFRko3d0VvRFJ1czFDUkZEN0FWQVJibm4v?=
 =?utf-8?B?T2U5Vy9mVE5BS0V2eW90M2IwaGhpTmc2Rm5idGF1M1E5MDd0TmMzOXd1MXdO?=
 =?utf-8?B?VWFDdmUzUTc2SjhBVUkzLzdyVHpBeHlBQW91TWpIckFuUXhwbEY1OWhmMENp?=
 =?utf-8?B?ZzN4T3h5dThBRjY3b3daMVdTU3BSSmdiUHh2SkVpditkSFhjVnFBZTNja2g3?=
 =?utf-8?B?allVRUhUYmp3WGF6UEVQNVJJME9Sb3AwUnBDamxDWlp1bHltQmloY0xNWVpC?=
 =?utf-8?B?OEovNlJGRUpFakdHVzVjdXZHZkdRck1qWXNmeEttNFUxdGxDSENSYWZmZDRK?=
 =?utf-8?B?NHdsY25BWkVQZTVIU3BMc1RoTm5OQnVEY3I3dTQzTnFCWDluSmxPaFdJMWl0?=
 =?utf-8?B?N01LdkNMUmw4UnZlTEVVanI5QndNUGFOakNoZXBVVExoODRkNWQ2b0ltS1V2?=
 =?utf-8?B?OXFLTTBod0ZvZ1YzVnl0Sno5M3ZaVE1xckhWYXc0R29KS1paSXBMbVFQTy9x?=
 =?utf-8?Q?E/8GV0j8KqLTbuhSj9Kg7oM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1125BD7A6CC5AE40B049E7C53CA4230B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB5976.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62ff3d81-fb17-43c4-32b7-08dc8bc3d3e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2024 16:13:56.9746
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lQyIbUzuWgW5omeMA3Az756r67dZuymDfa99cpHqLmSsFe1TQ0SxcvKgmV7Cjb5y/iH8Fhv4IipFov8TGAlyzAtwBI66bluFl4LlAiwcJNw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7491
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI0LTA2LTEzIGF0IDA5OjA3IC0wNzAwLCBEYXZlIEhhbnNlbiB3cm90ZToNCj4g
U2Vjb25kLCBSaWNrIHdhcyBsb29raW5nIGluIHRoaXMgYXJlYSwgYnV0IEknbSBub3Qgc3VyZSB3
ZSBldmVyIGFwcGxpZWQNCj4gaGlzIHBhdGNoZXMuwqAgVGhlIGlkZWEgd2FzIHRvIG5ldmVyIGxl
YWsgbWVtb3J5IHNpbGVudGx5IGluIHRoZXNlDQo+IGZhaWx1cmVzLsKgIERvZXNuJ3QgdGhpcyBz
aWxlbnRseSBsZWFrIG1lbW9yeT8NCg0KVGhleSBkaWQgZ2V0IGFwcGxpZWQgYWN0dWFsbHkuIEFm
dGVyIGEgZmFpciBhbW91bnQgb2YgZGlzY3Vzc2lvbiB0aGUgc29sdXRpb24NCndhcyB0byBhbHdh
eXMgbGVhayB0aGUgcGFnZXMsIGFuZCByZWx5IG9uIHRoZSBXQVJOIHRoYXQgaGFwcGVucyBpbiBz
ZXRfbWVtb3J5KCkNCnRvIG1ha2Ugbm9pc2UgYWJvdXQgaXQuDQoNCkl0IGxvb2tzIGxpa2UgdGhp
cyBpbnN0YW5jZSBwb3BwZWQgdXAgYWZ0ZXIgdGhlIHN3ZWVwIHRocm91Z2ggdGhlIGNvZGUgd2Fz
IGRvbmUuDQooYXQgbGVhc3QgaW4gbXkgbG9jYWwgYnJhbmNoIHdpdGggdGhlIHBhdGNoZXMgZm9y
IHRoZSBmaXhlcywgdGhpcyBjb2RlIHdhcyBub3QNCm1lcmdlZCB5ZXQpDQo=

