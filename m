Return-Path: <linux-kernel+bounces-557574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B30DA5DAED
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 11:55:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5C70177B47
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 10:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E7E23E32D;
	Wed, 12 Mar 2025 10:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="Or0PYM5i"
Received: from esa3.fujitsucc.c3s2.iphmx.com (esa3.fujitsucc.c3s2.iphmx.com [68.232.151.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9974923C8AF
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 10:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.151.212
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741776933; cv=fail; b=K7WETTvKwHiehpaGb+wqi2rjqLqQcIL0aEmY8ACYjBgAWnDeNZxxF4/z3OrE6W7S3OZH9D5m4CgIXRr2m4wc7Fj5TKPaO92toVpeF/3VlVFB/k7cvQOGAHNWqiwBRFwfIxMN27DN9Db3OtKTd1ZOHehMdAQYvoeBzo/wEpT03/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741776933; c=relaxed/simple;
	bh=bxzFU7VAcWVes1AZTc1H9a6KC1Sxh/FPFB5rRNJlXu4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Z64hS/411J/IuRWcrnM5ClrkVfbPX8AWZ+8fDipcIIz0Z9rqVbBI/TCZW3nUwHnIjbJmhWq8g0ygXtN0fYZHG/2M3gnMMgqYv4OwdMl+bjPG83ktzdLrRqJvYC7Y1zu7uLcZ1F/0flqykLSmdy2Pqtw/MZyhxSdlRirGW5KM+xU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=Or0PYM5i; arc=fail smtp.client-ip=68.232.151.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1741776930; x=1773312930;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bxzFU7VAcWVes1AZTc1H9a6KC1Sxh/FPFB5rRNJlXu4=;
  b=Or0PYM5iv2IQPyx+cSYHbtE7cxuLfUTowZnc+B7Wwy7KHcNkwxxXsuSi
   XdFHhRikrRGqHYQVlDw5+ZzY4xge6BVbmHjATT5GmeCqd8BCxGvlNp6Lh
   OEOejEmJi29FW7leQQGFctNmahTfj2+QiWHI9bQuDAiksmKFgUc436kxC
   hGJhIePXr7hzJjQ8RPGc/56B8t5pa4kkZNq+6Dwv1Gy5x6+gfhf2pICpH
   3kz72q5WyNQntIaPZORuXtjEKaY8Uh60Ybr4v6mW7qQ7/JDm9MpmkIzun
   i6XYaZVGGSZoCsEZUiWBFSgyMRbk8aYT9Dt9yM4NR8ujzxgbkHWruYeni
   w==;
X-CSE-ConnectionGUID: Z1JtarFnR7iCoTb0v903wA==
X-CSE-MsgGUID: 0fmbEs+FTu+bv1vMmyK/+A==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="60458349"
X-IronPort-AV: E=Sophos;i="6.14,241,1736780400"; 
   d="scan'208";a="60458349"
Received: from mail-japaneastazlp17010004.outbound.protection.outlook.com (HELO TY3P286CU002.outbound.protection.outlook.com) ([40.93.73.4])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 19:55:21 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KFEtRS1KrtlaXwGIJXe3ocRL0sNBWlFHxQR+MO7e2Ekjk8owzSOV10P7phByaQLJC/MiOX27iOwJmSSdqkeVqbiGkpnV72cO06K4gOZ1O9lhTQpRyuIhIN1m6VChC9BH2L1iXwMQQ09fpfbN3BkWPUJ3pBJtxcFr/6RNf1zm66zUMOPFR3ZSAYv7/t+qpYGnuaqi/ETSFtbAha30RP1NjhutgNM7peislmyL0B8BlO4WHF4NSZtqyY8HcGmyTd6Vi9nBbvaErcL31gP1fKKPvc+eAQiJSFiIznMkAwKejUja3jf5Udf1ntewCt582+WFJRwn7w8H/yspYf5Pad2DVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mFWce5DyV3ATlk0aorZxbi8dZZXI3dPyObUIGY+IW2A=;
 b=mt57Fwew4afPKwjnm9195wqlUof/iMIaZ6V28VT4nJwSAI3WN3OEdAQyFEW9ZacloO4EGUE0fFKByQUhLTc7J7n1fAneapw1Nt+CLaW3kur9FL+u4s0i71UJDXWFR2K+WLqVS3stKASFL7Qh0dH7SiAIlGWMPq8TfVf/mOaeRiKUCNx32oa6phZpscnivPiQUToMjsP86rAxB3m95F+lfAiroit8M+MXOBslaym75gHPjuJpNAySudbrLodBVykdf64GrpCiB4l5le42Vly21BP1zGehABoVbNzZMM4Er8UQuwnT2ZoAeh/VDu42b0COtYAi0kwuZJHYukDzz05xCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYCPR01MB8804.jpnprd01.prod.outlook.com (2603:1096:400:18d::10)
 by TYCPR01MB10335.jpnprd01.prod.outlook.com (2603:1096:400:243::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 10:55:18 +0000
Received: from TYCPR01MB8804.jpnprd01.prod.outlook.com
 ([fe80::b2f6:161a:adee:a32c]) by TYCPR01MB8804.jpnprd01.prod.outlook.com
 ([fe80::b2f6:161a:adee:a32c%6]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 10:55:18 +0000
From: "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>
To: 'James Morse' <james.morse@arm.com>, "x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Reinette Chatre <reinette.chatre@intel.com>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, H Peter Anvin <hpa@zytor.com>, Babu Moger
	<Babu.Moger@amd.com>, "shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, D Scott Phillips OS
	<scott@os.amperecomputing.com>, "carl@os.amperecomputing.com"
	<carl@os.amperecomputing.com>, "lcherian@marvell.com" <lcherian@marvell.com>,
	"bobo.shaobowang@huawei.com" <bobo.shaobowang@huawei.com>,
	"baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	"peternewman@google.com" <peternewman@google.com>, "dfustini@baylibre.com"
	<dfustini@baylibre.com>, "amitsinght@marvell.com" <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>, Dave
 Martin <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>, Shanker Donthineni
	<sdonthineni@nvidia.com>, "fenghuay@nvidia.com" <fenghuay@nvidia.com>
Subject: RE: [PATCH v8:for-boris 00/30] x86/resctrl: Move the resctrl
 filesystem code to /fs/resctrl
Thread-Topic: [PATCH v8:for-boris 00/30] x86/resctrl: Move the resctrl
 filesystem code to /fs/resctrl
Thread-Index: AQHbkrT9Rw5eUSkS6kaP7JkEZT9PuLNvU8QA
Date: Wed, 12 Mar 2025 10:55:18 +0000
Message-ID:
 <TYCPR01MB8804C3B3169809A6DE1A9FBE8BD02@TYCPR01MB8804.jpnprd01.prod.outlook.com>
References: <20250311183715.16445-1-james.morse@arm.com>
In-Reply-To: <20250311183715.16445-1-james.morse@arm.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=5bc51568-4845-4bdc-b52e-f4889c36e79c;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2025-03-12T10:50:38Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB8804:EE_|TYCPR01MB10335:EE_
x-ms-office365-filtering-correlation-id: fbabb018-0817-45a7-6434-08dd615460ae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?UjJOSHhDd2F1YWVhQllZTlhLeDg3cDlDeVF3WGZDQWdoaTM0LzE4Tm5T?=
 =?iso-2022-jp?B?WGtKem5OS0pSald5M08vSGZHb01hL1pzRVEzSVlyNExsUmdYUHo4cm02?=
 =?iso-2022-jp?B?bFBxNjlGaHpHMnZYNDk4aHlmUlNGOXZPdmxTSWgyVVZhTEJBUXMrazZx?=
 =?iso-2022-jp?B?ZnFscVdpa3lRT2hWbmpLMGlncER5cS9BS0dyYUV6ODdud2lVM1JQamRk?=
 =?iso-2022-jp?B?MmdqNUFsQnpHK0EzNWQwaURrVFMvUlJXbHRQZElQa1dwRm5najUvSVVw?=
 =?iso-2022-jp?B?TVBiMFEwcm50Ky9zbzcvVDdWRm9idHRNbnI3dWVKQThDWlIxK3pMUExq?=
 =?iso-2022-jp?B?bURGZUR5czVYT1FUMDYxeEhSOVcyck9XNjlhNThnWUZTYlE0QllJZlo2?=
 =?iso-2022-jp?B?U3ZMZmRnU1JnMTl0MzdjaldwMGltMVBTd3J0MW5CbjRvY2VObFhVTUdG?=
 =?iso-2022-jp?B?aElKMG9Bcld1RUJocEN2M05tT0I4UzlIbVFDSDU2emlldVZmckI1alZM?=
 =?iso-2022-jp?B?b210WjFBZFpGTmd2NnJ5RWw1cXYwbEYwOFR4aHZBdWNkdFpTTG9DcTAr?=
 =?iso-2022-jp?B?TWx0S21XUXF5MTFEWlIwNVBja2IxV3Bzc0w1UXpoR3ZlbGU4Z1dxZlE2?=
 =?iso-2022-jp?B?MDF3ZVcyKys0QmJEZXNlUUhZdjRGTG5tSk9uU3d4QWx6YitmMEFMRVlm?=
 =?iso-2022-jp?B?bmpaSUR5OW0xM0NUMFc0YUJxcEcybWVOeHBISGtYcjY3YnVvUkJKRFNW?=
 =?iso-2022-jp?B?YVYzTmNSSFA5cnFMK0d6SVVZT1Z6QkROcXRldEtNdzRPQzVBYmVpVS8v?=
 =?iso-2022-jp?B?RmtmOFBzRlBGbXg4SmZJOUErNkNCSWZOMTM3bkg1Y0Z5OTg1WWtPOUZ6?=
 =?iso-2022-jp?B?ZFluRFdzbkoyV2o3V2NDcmpyc1o2WnoxVlgvZUJ0OVVrOGlZWlRGMkpx?=
 =?iso-2022-jp?B?aVdGTXFjTVkyVGtGQU1OTm1MQm5BNlpmVXpkU2V0cUVjNEhCb2ZXNUZz?=
 =?iso-2022-jp?B?UGMwTVFlSjAxZ0RES0p1eWlrcW53SlVndWtTcDdwY3I0Z2FYejJjbW43?=
 =?iso-2022-jp?B?aHRtL1pwSHo0a1BFRDVld3JqeEg5WnNBVkdYRWVkKzhQbVVBSm1Gamtw?=
 =?iso-2022-jp?B?UUpqUGwrcTNMN2NwOWtVZ0t3SWUvYk9MR1VlS3FQakRNM1ZuWktZMnYr?=
 =?iso-2022-jp?B?UnA3dWJmQk51Q3QvbHRReXY5WUlJRGNrYUMrZWJhRy9Uck14TWFzdWE0?=
 =?iso-2022-jp?B?dVVNWThrekg5NzkzbXh5OVpzUUNoUlJ0V25CSUZ4bHFrSFlGbHRRSURR?=
 =?iso-2022-jp?B?ZlErNkNsbEEwK1R5T243SXFpUHJoUXhPa3VQVHlLeDNRRjJ2d1BZMmZU?=
 =?iso-2022-jp?B?bGljcjg0NVlNSURWZUNsSXlVcE9wd1pxRWxCQ1lPR1dGaklpMTdqR2Jv?=
 =?iso-2022-jp?B?TXZJR3Vleko4MUxMaUl2S2tBWjBHa0pwMmRiZXp4djlEMGNvSkVCSmRD?=
 =?iso-2022-jp?B?L01TaTkzU0U2UGNkUHIxWGVEcXgvNWdRRnM1bWptWEVxYjgrWHI1Q2lR?=
 =?iso-2022-jp?B?QXNkYUx2QVJUWlRPYi92RFpYbGt1RlN2QVByMjhNRWh4UStqU1NZdnpi?=
 =?iso-2022-jp?B?KzVjT0ZxRmJ5R0dYV2ZVVVRiNlo1QWwyOTBmT0pSeGpmTkRCd0RGRWIw?=
 =?iso-2022-jp?B?ZkUwMGRSajdiUXMwYnZXa01qM1lXY1JxU25wL1doS2dHMTFjWkZRZkJJ?=
 =?iso-2022-jp?B?MFZKQ3hoSlRuOEdlbnZNZVg5bi9KSnNFaVdoaS9tV2g5cm00aGtvdk5C?=
 =?iso-2022-jp?B?Nk9GVzJrYUlXaEY2V1l2dzdnNHJ3WGtoK2lzeWl5cGhicndFYkJ2STVo?=
 =?iso-2022-jp?B?ZW9yUUp6ekMzdGVLczJtZU5RVlFrRjA3RU1QV3M1bldCZEpDWnUrakdL?=
 =?iso-2022-jp?B?Njd6UjhQbXR1U2ZzK2N0ZEdIYkVRdHdKaXA4b1ZydFFIeTR2TnI1NDJ5?=
 =?iso-2022-jp?B?a3NLUTVFQTR5a2ZZb1VodkFBS3M0SERFZzRvei94WDhwdWNZUmErSFNo?=
 =?iso-2022-jp?B?OFVmRit4Y2d3bXBUMEc0ajBJejVmS0J3T2VoK3NqYzZsbHVMTHJVc1JJ?=
 =?iso-2022-jp?B?cS9PemMramxwRVVqUDhEZ1JocjUyQkV3STNGRjBJYXNmU2tBYzg3dmFv?=
 =?iso-2022-jp?B?Z2VFPQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB8804.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?OU1vTUVJM251UHE1V0U0dVNGSC8vM3FlWkxVdk1pcUxWN1FzdkhCUzYy?=
 =?iso-2022-jp?B?Vlp4Z3FINmJSL25pQ3lpeHlhUVg0R3RqWk0wdy83YVpBUnN4RU10NEdh?=
 =?iso-2022-jp?B?alpmY1hOSE91dHVQdjB0d3ZlT0huR0RwV2RmYmVTTE9qSENSWm4wZWZw?=
 =?iso-2022-jp?B?czR5YzVrNWZtRTlNSG9IWmlpM09GSVhMOFFJUDJ5ZG5SeWZEcUhPSzNX?=
 =?iso-2022-jp?B?VitQYlUyQ1FSMFhtMUc1VTFmcXVkS0R4Wit4QkNFNEw2dGNDaG04MVMv?=
 =?iso-2022-jp?B?VzI4T3BnZVoySnlQalN0eFNUaFY0RC9lWk9GMk43MEJHdmtCQWpDL0pG?=
 =?iso-2022-jp?B?MDRueHYxZ0J4YWE3UUZZZEs3ME9TRWMrblF1Ny9zRXd1cU9rL3VLS2NR?=
 =?iso-2022-jp?B?dVFoTFZkNS9tRHZCdjhCYkZ1Zys1SUNTWkZqZTUvdXVjdldyWFo0VEtj?=
 =?iso-2022-jp?B?NFJBdW1teUpDTW9sYitTeFN5REd3cG5lWFU0em5pdVRFWVpTSnhHVnoy?=
 =?iso-2022-jp?B?Nm1OQ2hQSU5EWnhvc1dFYmNzV0NxaGVPV1crN3ZwNjNVSlZFV3V0SFFm?=
 =?iso-2022-jp?B?UDB5bEJMRVZUcHRSOCtqMGw0MjhXT2ZKbWJ3a0tEd09lZ1F6d2M2SXpX?=
 =?iso-2022-jp?B?RWNjMEJXQ0dzZXQwMHBRa0JWdXhEWFVodFhhd2dFVXBzUlRrVFBOQWtr?=
 =?iso-2022-jp?B?TFIyMXpnNGR4THIzREtpeDlpS1Z5amRNSzlVUW92a3ZLamxyZmRManZT?=
 =?iso-2022-jp?B?NmhWbjdzbVI5bkJyQk5adHhBUm5BL040WmVITlFHWEZ4d1Y2cTIrNk8v?=
 =?iso-2022-jp?B?b1J6L2lrQnJQM29NcjlIYWwyMEpjSFQwSGVXQ3YwQkhoWjJmbTQxbHk2?=
 =?iso-2022-jp?B?UmsveGluakRCS2xENlBpc05nYTA3MXdVd0t6WHNjVERBV1FNbkRKdW4x?=
 =?iso-2022-jp?B?ZXlSK2lwV1JCMUc4M0VkOUdLdDMvVmMwMEN4ZjFFd2w5MDFyK2ZkalhK?=
 =?iso-2022-jp?B?OVhZTjNuNnFNbWpkS3RycWMvTlgzNzRKWXdjZUNjaFdnK0lWTTl5d284?=
 =?iso-2022-jp?B?c3Y2MHdJUTVpRXV2bnhmVTNGNkxsWjY1WVBQSnN2bEZ4Q2FwTlU3eFps?=
 =?iso-2022-jp?B?dHg2VTN0cGVqL0ZReTNXU2VOV01yVTlEcis5M0hzRUdhcVprL1NLTlNJ?=
 =?iso-2022-jp?B?eVl0cEtUTjVVZHFsRUszZ3Y2YjFieWRQODdDRzRTYXpMa1lxbWJwRWhM?=
 =?iso-2022-jp?B?dHlRWklKMkRjd2dEd2dqT0Ntc2xwdU5oTjBIYStldHRZMFcrTE5jTW1M?=
 =?iso-2022-jp?B?UXN1OFFaZ082c0ZBOHBlYkdUbmd2QXZTR0hTQmtxcnBqMXRmZGE1TDNk?=
 =?iso-2022-jp?B?NVI4aWdNZ1Bvd05vdUlUeGJYNFN1N0JxdFc3ZVZFdGsyam9uR2hrVEdz?=
 =?iso-2022-jp?B?YTNaK0s2d1BGV280QXB5OW14SVQ5QTY5YU5sTmFVcnB4bTcxL0daOEFi?=
 =?iso-2022-jp?B?N05VVm52RGV5d20vbWJFbDlFQzlZWU1aRTNFOEVEMUxYM3N3eExTUVd6?=
 =?iso-2022-jp?B?SlJpYWwrUUJ0cytRa0I0YWorNk9vejlXS3Y5bVlsbXlZUkdyTC9HZXRn?=
 =?iso-2022-jp?B?aUFydU1ONGQ0Z0NsQzRnczhvQTBob20zZ0VRT1F4eEFMR3RlTVMzRHNl?=
 =?iso-2022-jp?B?TlExRU1IVDZXSW1nc1U0Ti9xUWw0NkFxVkxWR3MyOEU4dWhteU1ycFJi?=
 =?iso-2022-jp?B?U3lid2ZGSGM3ZHVPTURKMGhQRlExbEloZGpvdjd4MjFyUGN4bTV3OUFK?=
 =?iso-2022-jp?B?UkZLTkRyYmJuang1QXAxTmxSeGUxcWdST2dHUyt5NnBrdUVYeTFET2p1?=
 =?iso-2022-jp?B?REthb2tqd0cvL09pakhUODdkUElyZC9MSmtlUlVFWUtkZkdDUm93Mitk?=
 =?iso-2022-jp?B?bGpBVkRVL0pwUlRXQ2F4M250RnlFcThlUEphZEFZN1NDNXlEN21QamhL?=
 =?iso-2022-jp?B?SXp0TUFuRnI0dUROTEZuSDhSbTJNSjRiVmVxRUVjNHJsQURBVGE1bHpo?=
 =?iso-2022-jp?B?cVRnckFNcGVPRko4a0dOQ25KbkltcE50d0tvNVNxYWxEZWRKeXRiL3o0?=
 =?iso-2022-jp?B?OTZMVHA0MGQ2VTVCcGZFZ3hsMXRidTBRa2t0M09MTlA4MXJYREgzSFYz?=
 =?iso-2022-jp?B?bjNBQlU2aUxYM3pSNW42MFZZblZMdkdPSTJYKzdGdjd0ajk5L1F0Zk9k?=
 =?iso-2022-jp?B?MWVRUlNiVEVvUStiemxYc0JNYldLSTBGQlU3NGRyMjBEWE1MK2thNXhU?=
 =?iso-2022-jp?B?VDVyZ3BGOHhhSUVXNXlaYmsvK0tVMjR1UXc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	h/XQ6NjVhwi6MCd9TRUJ8AR79/t8T5lWuFlE4ZqqJobcUNPRWW/8vPjrTg3wvV94nxtvoDnpJgsUeL6enu8sJ02Eb9WL2x/T/TLDxP46oqOVkuRaq1mSP+o62KEvkfM2A3N2ZMyXUsAzo/PhwFpLRXZSka0cRs5ivr2lTCK6rEykslWKd2h+xKt+eChkVuX0HpD1eugeWN43NH/ME3LpmokWgn55aQLJrpp0Qfzc/2bLk7G9Lv87Ivv2CoYdsnPWkMKRQ9q79+QaiIf0OxLAJ1opPS6jK61ND8HpGA0p4QUFLzM5yufTXEy+QzUANNUKWDDYBkk6s1+iaC5MLqiRNlAzSfx99jOGbOlGMrTIwwvCoWZ9meK12uGnfke64jjalWpEJYFVUiwZGB7nOsSimLuth5SlCd+iPQIia/XO8LxW0a+4dJ4iuNI7H+Z1Q5RVYdPdlRGQvh9wBbC3XuTwGhY3B8MC/sWEvCEQ0nTPvmjeo0c1PjgdO5ITu5hyL0iFA/KM2dqA0MOUK+HMUSGxfmvmHfiT6cezXCV475ERga9QK4l67+5vCLY3jYNcmd+SOM7x25FgYmmpv716ih2JJzUT7MJQmn66NIzJV8BhjDbacoK8Qy3rX+xoa01kR4HR
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB8804.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbabb018-0817-45a7-6434-08dd615460ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2025 10:55:18.3215
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sifOMlaxOzOZnMht7crnRnQTr43fWUgngdwS1HaZWsEV/KcrQ15UtVhl9zlBac+gbFD554I3w+JVR5wyCW3bzKFlQUWsFGY+XGiLPSSw1sA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10335

Hello

I ran tools/tests/selftests/resctrl on Intel(R) Xeon(R) Gold 6338T CPU @ 2.=
10GHz,
and reviewed all the patches.

Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>

Best regards,
Shaopeng TAN

> -----Original Message-----
> From: James Morse <james.morse@arm.com>
> Sent: Wednesday, March 12, 2025 3:37 AM
> To: x86@kernel.org; linux-kernel@vger.kernel.org
> Cc: Reinette Chatre <reinette.chatre@intel.com>; Thomas Gleixner
> <tglx@linutronix.de>; Ingo Molnar <mingo@redhat.com>; Borislav Petkov
> <bp@alien8.de>; H Peter Anvin <hpa@zytor.com>; Babu Moger
> <Babu.Moger@amd.com>; James Morse <james.morse@arm.com>;
> shameerali.kolothum.thodi@huawei.com; D Scott Phillips OS
> <scott@os.amperecomputing.com>; carl@os.amperecomputing.com;
> lcherian@marvell.com; bobo.shaobowang@huawei.com; Tan, Shaopeng/=1B$Bk}=
=1B(B =1B$B>R=1B(B
> =1B$BK2=1B(B <tan.shaopeng@fujitsu.com>; baolin.wang@linux.alibaba.com; J=
amie Iles
> <quic_jiles@quicinc.com>; Xin Hao <xhao@linux.alibaba.com>;
> peternewman@google.com; dfustini@baylibre.com; amitsinght@marvell.com;
> David Hildenbrand <david@redhat.com>; Rex Nie
> <rex.nie@jaguarmicro.com>; Dave Martin <dave.martin@arm.com>; Koba Ko
> <kobak@nvidia.com>; Shanker Donthineni <sdonthineni@nvidia.com>;
> fenghuay@nvidia.com
> Subject: [PATCH v8:for-boris 00/30] x86/resctrl: Move the resctrl filesys=
tem
> code to /fs/resctrl
>=20
> Changes since v7?:
>  * Series split to the first 30 patches, requested by Boris.
>  * Fixed stale function names, definitions/declartions and typos.
>  * Dropped the use of the default ctrlval helper in cache_alloc_hsw_probe=
()
>=20
> As ever, changes are noted on each patch.
> ---
> This series renames functions and moves code around. With the exception o=
f
> invalid configurations for the configurable-events, there should be no ch=
anges
> in behaviour caused by this series. It is now possible for throttle_mode =
to report
> 'undefined', but no known platform will do this.
>=20
> The driving pattern is to make things like struct rdtgroup private to res=
ctrl.
> Features like pseudo-lock aren't going to work on arm64, the ability to d=
isable it
> at compile time is added.
>=20
> All this is to allow the filesystem portions of resctrl to be moved to li=
ve in /fs/,
> which allows resctrl to be supported by other architecture, such as arm64=
's
> MPAM.
> (What's MPAM? See the cover letter of the first series. [1])
>=20
> This series is based on v6.14-rc3 and can be retrieved from:
> https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git
> mpam/move_to_fs/v8_for_boris
>=20
> As ever - bugs welcome,
> Thanks,
>=20
> James
>=20
> [v7]
> https://lore.kernel.org/lkml/20250228195913.24895-1-james.morse@arm.com
> [v6]
> https://lore.kernel.org/lkml/20250207181823.6378-1-james.morse@arm.com/
> [v5]
> https://lore.kernel.org/r/20241004180347.19985-1-james.morse@arm.com
> [v4]
> https://lore.kernel.org/all/20240802172853.22529-1-james.morse@arm.com/
> [v3]
> https://lore.kernel.org/r/20240614150033.10454-1-james.morse@arm.com
> [v2] https://lore.kernel.org/r/20240426150537.8094-1-Dave.Martin@arm.com
> [v1]
> https://lore.kernel.org/r/20240321165106.31602-1-james.morse@arm.com
> [1]
> https://lore.kernel.org/lkml/20201030161120.227225-1-james.morse@arm.co
> m/
>=20
> James Morse (30):
>   x86/resctrl: Fix allocation of cleanest CLOSID on platforms with no
>     monitors
>   x86/resctrl: Add a helper to avoid reaching into the arch code
>     resource list
>   x86/resctrl: Remove fflags from struct rdt_resource
>   x86/resctrl: Use schema type to determine how to parse schema values
>   x86/resctrl: Use schema type to determine the schema format string
>   x86/resctrl: Remove data_width and the tabular format
>   x86/resctrl: Add max_bw to struct resctrl_membw
>   x86/resctrl: Generate default_ctrl instead of sharing it
>   x86/resctrl: Add helper for setting CPU default properties
>   x86/resctrl: Remove rdtgroup from update_cpu_closid_rmid()
>   x86/resctrl: Expose resctrl fs's init function to the rest of the
>     kernel
>   x86/resctrl: Move rdt_find_domain() to be visible to arch and fs code
>   x86/resctrl: Move resctrl types to a separate header
>   x86/resctrl: Add an arch helper to reset one resource
>   x86/resctrl: Move monitor exit work to a resctrl exit call
>   x86/resctrl: Move monitor init work to a resctrl init call
>   x86/resctrl: Rewrite and move the for_each_*_rdt_resource() walkers
>   x86/resctrl: Move the is_mbm_*_enabled() helpers to asm/resctrl.h
>   x86/resctrl: Add resctrl_arch_is_evt_configurable() to abstract BMEC
>   x86/resctrl: Change mon_event_config_{read,write}() to be arch helpers
>   x86/resctrl: Move mba_mbps_default_event init to filesystem code
>   x86/resctrl: Move mbm_cfg_mask to struct rdt_resource
>   x86/resctrl: Add resctrl_arch_ prefix to pseudo lock functions
>   x86/resctrl: Allow an architecture to disable pseudo lock
>   x86/resctrl: Make prefetch_disable_bits belong to the arch code
>   x86/resctrl: Make resctrl_arch_pseudo_lock_fn() take a plr
>   x86/resctrl: Move RFTYPE flags to be managed by resctrl
>   x86/resctrl: Handle throttle_mode for SMBA resources
>   x86/resctrl: Move get_config_index() to a header
>   x86/resctrl: Move get_{mon,ctrl}_domain_from_cpu() to live with their
>     callers
>=20
>  MAINTAINERS                               |   1 +
>  arch/x86/Kconfig                          |   7 +
>  arch/x86/include/asm/resctrl.h            |  36 ++-
>  arch/x86/kernel/cpu/resctrl/Makefile      |   5 +-
>  arch/x86/kernel/cpu/resctrl/core.c        | 181 ++++----------
>  arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  93 ++++---
>  arch/x86/kernel/cpu/resctrl/internal.h    | 201 ++++-----------
>  arch/x86/kernel/cpu/resctrl/monitor.c     | 119 ++++++---
>  arch/x86/kernel/cpu/resctrl/pseudo_lock.c |  55 +++--
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 284
> ++++++++++++++++------
>  include/linux/resctrl.h                   | 212 ++++++++++++++--
>  include/linux/resctrl_types.h             |  54 ++++
>  12 files changed, 769 insertions(+), 479 deletions(-)  create mode 10064=
4
> include/linux/resctrl_types.h
>=20
> --
> 2.39.5


