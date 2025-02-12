Return-Path: <linux-kernel+bounces-511965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 995FBA33221
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 23:09:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28BD13A7031
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 22:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F14204089;
	Wed, 12 Feb 2025 22:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q5+MvG12"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECA32036E6
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 22:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739398193; cv=fail; b=Vr7B/LAfd4klTyakN2mvBBEuvwR8DaEx/3Xw/B7UgxX2MIh4xWDg17HGT6f/0F9vSXNe3z5N0+GP/OXDALc1V+tIpYxEqhSxgJmsL1CtPkH+rAXNhnJRjgNw5jdl1SW1jDh4KhrnqpuW+TYBMLZnnX8SidwCxApdGE9YrnOsLKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739398193; c=relaxed/simple;
	bh=/S0K1UhYqn5j6znsQ7o5CmFIYvqxltlj4lYnhFMVCtw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hupnjgVr4t9lQok5rXOP+fBmKQ6HGhWtO9thVJt0i1WS2s1jxCCB2KzwVmO0znPRNUj9a+flf4ScbXUMgVsqJP8tWZ84h0F4CtdaA2mbsl4FV9wM6JQtnexsXPMVQ0PNwYzf2CnbodTUANicb85kDcxSoD1cMMsnup9zcejxv8E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q5+MvG12; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739398192; x=1770934192;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/S0K1UhYqn5j6znsQ7o5CmFIYvqxltlj4lYnhFMVCtw=;
  b=Q5+MvG12LDF36b6iDFlK0rQZzeoRj+v4ShEy3OAkXZoUcijHZNvfIVrK
   jnaGrQLpYWqiYNFMq540mC0+obypIs7F4K7ufoWoQG0+Cm8xpw9Z0nUt2
   xwNvoOLCyw+FRblyrh6DJI6OEQIYj79Xzixmtjx7n0Qt2eoft92nup/FG
   HjueqTkin6LPjOdGccmDwOQyJALDwu4Sk8Q6fD5cCJncqIJi0OSIN2R6u
   BGmJklQn1dcvIt2XNsWRmW6s8BiT3EYU914dSi4MHoOSXjpd3QFLdqUow
   qyHYe8u48kW08sxHqC1jfvhipL9h2TF/YREQrJoqQqL/GdBAEe+wN5Vwc
   w==;
X-CSE-ConnectionGUID: gdC25pQoS6mcO6ybAks+eA==
X-CSE-MsgGUID: 9qFdmF4aRvKTmsZmK1BH7g==
X-IronPort-AV: E=McAfee;i="6700,10204,11343"; a="40204797"
X-IronPort-AV: E=Sophos;i="6.13,281,1732608000"; 
   d="scan'208";a="40204797"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 14:09:49 -0800
X-CSE-ConnectionGUID: s2ME63ToRBii/SPqPTxmWA==
X-CSE-MsgGUID: kNMJ7yRpT8mVSQGi/f+TyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="113437379"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 14:09:49 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 12 Feb 2025 14:09:48 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 12 Feb 2025 14:09:48 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 12 Feb 2025 14:09:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h9Fg6utFbCV3ZuqGaCDXM6K9jMcbeu/m+cLF2f3orpJ62EL0aFXBruXzvrCZrdcezrK2SYW2xx/iVBdxeivqrTVmAqb0IR+JrLO9/HCFbzxS0YrRBi3mX9KRV3hkShQGleXdPwT+s/jNLVn8jjy0nl1sJetfypL+dvva0xf8WAz3AVllL32WQn31W6M/NrKa5QldYdrTtZr7h5QdhirZv1Rklb+aD5Cve1D/BsdUr1FPHeqVCYie4nEwCV3Fbc4OXjEaEu9Ep44ZWs1rrV8IZAdrN3MxmZ8GP/7kN1ivhjXGgIpRNbCcrmrjI8hcFoJerzt/up4/6Ah+NlE33U70+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0bSbQ4+44IY3HUaocyXcddcv3JvV+EY8R/XFBUeFMJU=;
 b=wIp+kNWkkpnNkTNYSiu0LEHfUrPRDXAq6J68bhxbVzXexY56C/mLD220tvNMEiBx/THZmARTljoT+a10GtpY0s6WSQYrlkAqbjjkHux4w6yHPTVIV2R0QVz76JrB9WDkvk+R5GdStwb/WqOo7byZlVOF4FSflZfHn0/wCBwQiPim+monm6w2a9b9/+2R4zMUbLF+ZHfGGq0UD/+ekqRLOKm3hEICHleuReFWZXq2+9m6v7jpatFwTTe0JpTKeYzyBUiM52+s0jCK48Nvde7q+ck1YGlZarbQ6SCj/ZRY4H0OcM52/l+RnIQ6VVTT2CfgNqyz73PQcT8n38u1aaFduA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SA2PR11MB4859.namprd11.prod.outlook.com (2603:10b6:806:f8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.15; Wed, 12 Feb
 2025 22:09:46 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fdb:309:3df9:a06b%6]) with mapi id 15.20.8445.013; Wed, 12 Feb 2025
 22:09:45 +0000
Message-ID: <b2bd829a-99b2-4dd1-b5f3-58072fe98a60@intel.com>
Date: Thu, 13 Feb 2025 11:09:39 +1300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/virt/tdx: Correct the errors in the comments
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Jun Miao
	<jun.miao@intel.com>
CC: <dave.hansen@linux.intel.com>, <linux-coco@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
References: <20250212075805.2906200-1-jun.miao@intel.com>
 <r7shaamvucw35wqymhkmceu3gpu2fedgv2umlcgdglglw65m4o@heaniim3gikx>
Content-Language: en-US
From: "Huang, Kai" <kai.huang@intel.com>
In-Reply-To: <r7shaamvucw35wqymhkmceu3gpu2fedgv2umlcgdglglw65m4o@heaniim3gikx>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0097.namprd03.prod.outlook.com
 (2603:10b6:303:b7::12) To BL1PR11MB5978.namprd11.prod.outlook.com
 (2603:10b6:208:385::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5978:EE_|SA2PR11MB4859:EE_
X-MS-Office365-Filtering-Correlation-Id: d36f5296-770e-4526-e71f-08dd4bb1f525
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dHNkSExlK0Y0a1VraFAwVnp5TStjQk5GTFlIQ2t5dVRlem9keGFRZUMzMGVm?=
 =?utf-8?B?YUhOYTdtcFV4RWMybkx3VCtWU0ZldEVKTUNSSVhxKytPQ2JteFpyMU1JRXFF?=
 =?utf-8?B?ellTUmw4SDN2SmVWMEJxR3IraGhKSmczQ3BtVnplSC9GNXh3dkVzU1kyQUxZ?=
 =?utf-8?B?aU1MTzFSUGxjWjZQUTZKZkhhMWZmUGFEa1F5a2lZS3hvNDJKMzI0MWZ5cGVU?=
 =?utf-8?B?U1JjTUdEbnMzSS9oNzdGVmg1ZlNid2FiS0htYVQ3czlWUktuaWgwdHZSVlJ1?=
 =?utf-8?B?Y0dxV2t4OHArK0ZicS9SdjJ6VTNmcjNEbHpvWldvbGc5ZUtLVDlsd3RsSllE?=
 =?utf-8?B?N2xESDZHaGI4S2hkM3FBRjZwcHg4RUszbFlmMzNsVDgvQTVjWS9kK3pQb3pF?=
 =?utf-8?B?UkdBZnN2Qm96ODkzNmdpUGtaUE8yT0F1Z3phRWduemUwUy85WTZqYXQxV0JZ?=
 =?utf-8?B?RUxleldCa3d5OU5WemNQRDIyQzlwTktia0pZS2x5QnYwUXphdm5lZ3RqVzRS?=
 =?utf-8?B?aXA0cUdLL05YanBBYVM4bWVPeVBsODkvVjMzbEZGNWlERDhRdEZ2ak9odWU5?=
 =?utf-8?B?ZWpBU2FKOE5iaFN6NzRZYTdPMWVzUjVldzBXdm9wMjdFRllVUm5WOUlTemJH?=
 =?utf-8?B?cXg4WU56R0RyYTFsWHBxbmpYRldPZHZROGtyb1lTVlhkMEtkSTBpcFRRSWcy?=
 =?utf-8?B?MXREck84WGRoZEVOZmRObTI1MTBkRTJ1U1FrZ05SS2J6MEV1RVVhZUFxSjBS?=
 =?utf-8?B?S2ZrUUZLdUh6NXhaTzVpYStDeU1XUXVMbUxuQUsrWTRsbVQyNVZrYWlGSFov?=
 =?utf-8?B?SE9laEE3OSs4eW1sMVhFclRvVEFkTzlDakZLZnQzMUlJY3M0c1BDcmxXbTJM?=
 =?utf-8?B?eEw2UlpNYTlUeWhTWGd6SnBwZFpKRjRROFRmNHY2eUhrZittQ21vc0NKeUw0?=
 =?utf-8?B?TmNPQWl3a0l6K1FzSENlNVBSSVVxMTh4c2s0NVNJQVFnNURRRVJuS0tWUk1Q?=
 =?utf-8?B?RHpVTFR3ZkttZlI1a0I2K2ROTzU3OVJydENNc0J1cE9BcXNCTzZtZzJyR0Fr?=
 =?utf-8?B?Q3c2RkQ3aFlUKzJBR3NMMENhK1kzTGNBdUVQZGRya1R2R1hDQ3JLYVVheUhu?=
 =?utf-8?B?T1BEWkFPQTYwWU9uMnM4cFkrNmpGV2xmdUdXcm1XYkg1aHhKaGR0bGY3eEtm?=
 =?utf-8?B?Z0FlMi83azFQRkhQeTJiTW9SZDhEUHQydWpxYXdYeExjaG9RWkd0WjhSWFlK?=
 =?utf-8?B?MlRWZU05OUpseS93QjNrUmRpU3RiQ0NQQ1FOVFRYSUJUbkkxbGZvM1VSWTJG?=
 =?utf-8?B?OEZQMStkYkFDV3pXWTJUbDVmR2ZXcnJ2NFdKMlkrS1Z3WEJSODh3S0tNY2VD?=
 =?utf-8?B?VDJsbGpZYW1NNDZZbllkOHF2UjBHVGpYZEsvc2pLQ1Q2UFZaeU5odnJ1d2J3?=
 =?utf-8?B?a0cwM2FxOHNnUS9lcHN1bjhxenpZTnFTeUw1aUx1Y0xQa2FUckVoSVdnUWln?=
 =?utf-8?B?dnUxdmdXeEZzeEhnc20va01yOGd5QjNWbVZqcldhUy9hRXIwbEtPSXNwMldB?=
 =?utf-8?B?T0VWclA2bFRURFlSd2NYNkpvR0tISFRNTTlwcWs1RGdUOGFVNkxiU0FZekJi?=
 =?utf-8?B?SzEzNGx5dUlTNXJlOEpFemwxQjJOS3grQ1UvWUFLalVLT2JqWmJ5eU9ZQW1W?=
 =?utf-8?B?Z1BjRXF1QlNKTGw2VzhWUTk0eWVaMUY1V3VzODBacGczY3AraDFiRnRQTHN1?=
 =?utf-8?B?WlZLY1Q4RmRUbzNyZ1lYek9ldGRnRUhSd3VGdWNVN3ErVlZzelVYTnY5ODl5?=
 =?utf-8?B?dHdwd3RBZ1BzTkVkMU1Mdlhsd3BBNUdBUStFK010aWxja1daOWFCL2V6K0VR?=
 =?utf-8?Q?3aqYyyJo39ZNa?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akhISnZXMWxmbFJJaTdoRTRjYmpZbnZiMDhUY3BQQTJ1VDBaakk5aXNuMzNK?=
 =?utf-8?B?TmNhYVlkd0ZUZnVrZkFneXRwaXU5ZnhEL0NnMzZWblpxOE1xL2JBZkxuMUZw?=
 =?utf-8?B?QlBjVm5iQXFvSis3MTVaTGw1cGpQYVhwY1NCTWt4bjV4L1VIZ0swaG9rTkFB?=
 =?utf-8?B?c0hzbGMwWUN3WFJZc01uZ3I3UG9ndENCRDROWkxHVE5FT2VQT2s2cW85VEx4?=
 =?utf-8?B?TitQSlJFMkNLS0gxZFdReGkxT20rL1NxVUNORHRXMGoxYWswZVJnd2VIaWRj?=
 =?utf-8?B?Rnk2VzFlMG5OdWN4WXpzb0JhTFZVTldhbWt1RWpDeFdvVTY4QUtRc2NiamVZ?=
 =?utf-8?B?eTZRb0p5aVZiVlkvY0NlTGNRM2FzZVJRbkRKQnRzTFRWR2VZS3BUbCtiNnpV?=
 =?utf-8?B?dGdrcGxPSUhwYlhGb0VjYU9TMnJVN2lwMkFHaUhNMjR2cGJJU1R3cmpwUkVi?=
 =?utf-8?B?MzV4NVBCZmM2N3dZRHVKRlNjc2czZjQ3WmlZQ1ZacVEwWk52UTl6U1NwQXg0?=
 =?utf-8?B?ZzNuTHNmcWVxeGlHOWVadGFrS3lRM0tCSUFnUnBwV0kxdmVVNEpiajhSNXhP?=
 =?utf-8?B?NTVzOFRGKzZPSSs5VGhuUFFjbEs5dzdpbkJvQm9WQzBKWmVUbEptUGNGWkdU?=
 =?utf-8?B?NFQvZ1NEcVJNWTZrKzhKU045QnYyZU1NTWhDTGtaV0FVMnNjRGhxQ2JSOGpV?=
 =?utf-8?B?ZFBkN21qMFNKSjl1QlBlTjlFTWVzZkhXOFNxemRFeXI1dXdGU05kQnUwQkxC?=
 =?utf-8?B?NytMOWd5ZjgraXZtb1BZR3hIZUNZNTFHajBRd2ZOR2pvTlhxYm1HOWg1Sy8w?=
 =?utf-8?B?Zkg5NjF3UjYwNU1EdHpYekJSTzFqNnNSS1pLZXMrNTdIWTY5YURSKy9MZXlH?=
 =?utf-8?B?SXo4YUlCaHAxcURwUFRlWUY1UW9KeE5aeEtpQVJDM3oxUDh0VlF4OEw3cEhG?=
 =?utf-8?B?TjZ5R1ZJOWVQb05tQXMweERRaFQ4dmFpNmttRHlTWnIwZHhpTG05elpwbEZN?=
 =?utf-8?B?VXViNUhFQ2IyM0ZaRFUyU3htL3ZXSTFjdi9GY2IrTFVVUzNRK1VaQnpHeUVF?=
 =?utf-8?B?c0pCWXlIWW1ONzg2b0p0NllXT2VQNFNYWnF6SFQ5ZElSWWJMcXdGaFpLcW5F?=
 =?utf-8?B?eVZMbkQyUVdCSVp2ZUwrdlkzNTdTUzU1UThzMStCakdCL3hTbys1NzJnVmkw?=
 =?utf-8?B?K3BBWW4waUxLY1cvSHZTbnYwQkQ4SXFXWUtZajdtRUxDYU4vdUx1KzA2Y2JQ?=
 =?utf-8?B?TFF4N21mQnFBUU9EVCtxVGRzVm9wK1c2UFhxYTUwVFZDSjZQUUZZMUV1LzdV?=
 =?utf-8?B?WkQvUmNWZzBEd09uRlhLMkpqZWxaVFR1L251eVhIRi83ekdadXZZOFNZZFFT?=
 =?utf-8?B?d1F6WEpWcHpxeUhEZ2hoUjh3MGkxc1M5OFUwYlNEeTF6endSRWVQbTd3Z2F6?=
 =?utf-8?B?dGt1TG9EM1pkQ05JTjhISU82MXdrcGd4MGxXNW8wU09TeUZuZUFBTHBhRXVI?=
 =?utf-8?B?a01xMy9kZzY3ajFxam16dWJsalVaUlpPaDdPQVFibmZPc1JZcmdXNFY0QXFD?=
 =?utf-8?B?WVhiOEhrL0wwVmFHWi81b202aG5CazFXY0RkMmRRTW9lckhnWW9hNElhZzV4?=
 =?utf-8?B?alhFNVZCSjlyQlFZTktZU1o2TWlyYmhRTW9xMmhSb1JsdzlIMEJyQ1ROci9i?=
 =?utf-8?B?Z3NQRGJmbFc3SmJFVWNrTllONHNHaVJPRXdkNlJ6OXZERFRpWXZBK2NNNnFw?=
 =?utf-8?B?NHVlcktOY2JlTXR2bU00UDlzS1Y3OXNtbWVBbjdUbEcyQ21jcHg1aitocWpY?=
 =?utf-8?B?VlFvakQ0MnpSWnZHRWZUNSswMUVJYW5MYjRpdVFJSkR3b0RMQXowazJjVDZD?=
 =?utf-8?B?eU1vbnhhaVduZkFPTDNEZGNnWUNtUTNyRHFuVHczV2pncFhwWWlSMEF4UzZK?=
 =?utf-8?B?UnlxcndCQkFCNEFKQ0J1ZW5YWjJHL1hOM2RLeVhGNEdIa280QzA2L3p0V3RZ?=
 =?utf-8?B?bkhLWWVBSWJ1Q0RPdi84VHpzeXVja0JCa1ZaUHUzZ3pETEpuNXorcnFxZlhT?=
 =?utf-8?B?a2taZEhDSzZVdUpUbFBYS2ZVRFRweXdXZkY0SThTajFMeUxkWGVjWVRuanBT?=
 =?utf-8?Q?uToSblPdI6BWYVY7YHf+fHXww?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d36f5296-770e-4526-e71f-08dd4bb1f525
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 22:09:45.3298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xqIGYsry+iW/qS96zSHTfNu0QBOe3gQOgTGU+BOaHD5QjTOrN3/AZlLqiug7K/JApkr7Rgg3ck5iLCghpcjHnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4859
X-OriginatorOrg: intel.com



On 13/02/2025 1:01 am, Kirill A. Shutemov wrote:
> On Wed, Feb 12, 2025 at 03:58:05PM +0800, Jun Miao wrote:
>> In comment of config_global_keyid(), the "will fail" is duplicate, delete it.
> 
>    In the comment for config_global_keyid(), the phrase "will fail" is
>    duplicated. Remove it.
> 
>> Signed-off-by: Jun Miao <jun.miao@intel.com>
> 
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> 

Acked-by: Kai Huang <kai.huang@intel.com>

