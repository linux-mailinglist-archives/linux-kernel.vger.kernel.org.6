Return-Path: <linux-kernel+bounces-364506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D3199D583
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 19:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14C4F1F247F3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 17:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A69D1C233E;
	Mon, 14 Oct 2024 17:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="luJndiDm"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BE11B85E4;
	Mon, 14 Oct 2024 17:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728926437; cv=fail; b=VwJTjrmvuWYCobfluW3eDoFjc0g2lI+WVHt7eFO6KfGSNTUK5o3sv3aAduU+oiGtoSZ8AYp6f2ruEPh179NnHNuIdpbScnItfk+zL4/KoQ5Jx2YRrBLOyoJ+eedU6T7kTRLpF8uzyETowk2ti4rPx1lF215Cxdf1VBEyXAQLHjw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728926437; c=relaxed/simple;
	bh=nfgDxO2Ny0hKfdMbamMjeFtRPMJSi7SvXNNvJNvPnYE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eCXurRgpDTl8ltDcv1j6FdQsyYHB9dsX1lk+hQiwREQCu7YIqiQXwRSAR3Af+mIfMvvJtkQfjxTbd7UVK79Hu945w5YC+0ulH27TKSx6Q3S1DE1U9Wkcikrha7jRvxPMqyB+XtPtpP8jCR18OJ1eIjz7BwMdORIt+Tswy/ERKqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=luJndiDm; arc=fail smtp.client-ip=40.107.220.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zRY9cmXKztUTBtj7iU7zzYPIJjXG9rtZ0oqv/t826/Ez6grJND80xAp+BMLpqLC6o4Im4OQxM+LPMvbSZ4XH8qR24Ug6pZ3C/RT6gvh0/AaAgmiDViUuSiCwLJU+bIaCy5Dxmo5tjLWc6NUj63vI0BNBnhlTn7uONP22STs4UYb+vjLJTa3xAcy1UBtjfOPPS/zBER33PfYdeRfxsT68lxyDMjIiiK7MOS6nEaKvXtfiW/m3e4rRe+s4hTUyfq7BI0KU2CR6gPW5czKX+46wK1rbrNtW2fRaGbydOSWk4S5pRCoiofHHBGvT69pagmv6hhYOuUmu3USu877pD4hbMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0eLfQDtrOK2KG7jRRfZllt+mhr7PDUXEcr5/LHe5zIM=;
 b=noH7Koov70gIL6YpSb3aQrr7u+8ANzzW0o+hzMzYHC+Jqp4NyJobj+PLKpX6f8vKex03QNe6D7dPBM9FL3jYWF6MBpX25zuDdtMJRdklcPEQ2WZU4Mspjs+wL0jkzLVZQbWiW0hFi0Eolczgg79ve4WilR2QKWfwQ7Il9PcSjKEvT6d98z+wuAf//Yeaf1WveJxXXecRbZ6HU3piKZ7pbh3ghnjXriuvs6f8ILkzARjsnrs7MOyrbEfGVRFirbwdQ4CtQnvq8YNQTfOhl1qfyz5l/miKzlv/fsB6nccect9bIBJks9hQmiWPn091ySnC8PXBgd6fZtmWdWrpnEg02A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0eLfQDtrOK2KG7jRRfZllt+mhr7PDUXEcr5/LHe5zIM=;
 b=luJndiDmLj1uSar3WHBxQXw2zr8yV811+9TTHC+9/cuv8hk0ZHrSDzcLfpRXtSQdz4bk5GEivRkp1M2nW0iOrMnVehPZd8kccLoedD5W5fO/KS6uaY9rDThq9OtPzPb6zUZ4/YnY4oU6r/MfybZfKDA737+WGycaoqvxTfl8w4g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DS0PR12MB6656.namprd12.prod.outlook.com (2603:10b6:8:d2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.25; Mon, 14 Oct
 2024 17:20:33 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%5]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 17:20:33 +0000
Message-ID: <0ee2e67d-c1dd-489e-beef-1f255c5629d6@amd.com>
Date: Mon, 14 Oct 2024 12:20:29 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v8 08/25] x86/resctrl: Introduce interface to display
 number of monitoring counters
To: Reinette Chatre <reinette.chatre@intel.com>,
 Tony Luck <tony.luck@intel.com>
Cc: "corbet@lwn.net" <corbet@lwn.net>, "Yu, Fenghua" <fenghua.yu@intel.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
 "paulmck@kernel.org" <paulmck@kernel.org>,
 "rdunlap@infradead.org" <rdunlap@infradead.org>,
 "tj@kernel.org" <tj@kernel.org>, "peterz@infradead.org"
 <peterz@infradead.org>, "yanjiewtw@gmail.com" <yanjiewtw@gmail.com>,
 "kim.phillips@amd.com" <kim.phillips@amd.com>,
 "lukas.bulwahn@gmail.com" <lukas.bulwahn@gmail.com>,
 "seanjc@google.com" <seanjc@google.com>,
 "jmattson@google.com" <jmattson@google.com>,
 "leitao@debian.org" <leitao@debian.org>,
 "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
 "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
 "Joseph, Jithu" <jithu.joseph@intel.com>, "Huang, Kai"
 <kai.huang@intel.com>, "kan.liang@linux.intel.com"
 <kan.liang@linux.intel.com>,
 "daniel.sneddon@linux.intel.com" <daniel.sneddon@linux.intel.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "sandipan.das@amd.com" <sandipan.das@amd.com>,
 "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
 "peternewman@google.com" <peternewman@google.com>,
 "Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Eranian, Stephane" <eranian@google.com>,
 "james.morse@arm.com" <james.morse@arm.com>
References: <ZwcIkf_oy2oKByNu@agluck-desk3.sc.intel.com>
 <8ceeb50a-70d7-4467-b7c1-4f62b1a1eec8@amd.com>
 <SJ1PR11MB608381B9DA3AE26749070BE8FC782@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <0fedcbd4-487c-4d55-8151-69dc34f41f1d@amd.com>
 <SJ1PR11MB6083FFA19F9387F21C058A09FC782@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <d1986f3f-9db7-4ac9-9fea-56878548ad61@amd.com>
 <SJ1PR11MB608382EB9F40FBDC19DF71C4FC782@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <1baa07f6-0ccc-4365-b7b8-09fe985963cd@amd.com>
 <Zwlj5TQxZphcuDSR@agluck-desk3.sc.intel.com>
 <8af0ce3a-1327-3ffc-ac5c-e495f9cdf5d0@amd.com>
 <ZwmadFbK--Qb8qWP@agluck-desk3.sc.intel.com>
 <ee7771e4-3768-456c-9990-fcd59b4f74af@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <ee7771e4-3768-456c-9990-fcd59b4f74af@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0201.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::26) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DS0PR12MB6656:EE_
X-MS-Office365-Filtering-Correlation-Id: 14a4da4a-4e0a-4e19-a43e-08dcec74829b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Um9odUNuWGR0WDBTZXlGQUlFNXRSMnlNbVlxTVRvbUwwbTlacE5mOFowcUFz?=
 =?utf-8?B?d1UzRHVHYkppeENuUTBtckMwV3RUclZxdEFFZGJZWldnVXl6RDJMOUNuSU9H?=
 =?utf-8?B?QzVjaGIzREVMNmhQdlFHdURCN2lRTkNHTkFLRVo5Q0lBUDU5UUtCV1h1cnV0?=
 =?utf-8?B?bE5GMmN4UWNrZkhBbjZtYVd1QkEyQTUrK0NVaFBqRmpsQWtYcHdFcis0dlZu?=
 =?utf-8?B?c21XRDV4VTF1UUdROUNMYVZXNURpTjZJVVhKeUlPK3BsWVJBZzZvYXBsclVO?=
 =?utf-8?B?MlFWV25HNVgvZXFuU2JnTCtocDRDV2t1enB2NDA4N3VEcUV4MDFKRDFZTUZq?=
 =?utf-8?B?OWF5ZzZBb280VjhSaWFEU3FRM2VORjZRb2cwL1FwV1NlSjFpT3h5OElHN2U4?=
 =?utf-8?B?MWdpQ0hraUxzV2hGbDZZRjgrTlRHZFdlL3hMa24vT3RnQ3ZESlFPVEFEcUVL?=
 =?utf-8?B?M2wxZnlDckFObHkvK1M0ZmZnQldOZ3ZJQnBRRWFjM3FFUFd4cHdUb0lIL2g2?=
 =?utf-8?B?VDZDbVd3VHNTY2ZuY3dCNTJpdkxWUjJ3R2RQSjlLZ08zR0YvWEdoM2RmYWtT?=
 =?utf-8?B?NWJtWXJJUDcyNi80b3FzMGExTGhzR2FieTBpOVVsV0JzdWJzR3hvdkRVdndQ?=
 =?utf-8?B?Y1J3dnhhbkJjWWV2TDBYVVkrNklRNmxXa1FSaURDRHBpSjlISzJMaSt0L1hE?=
 =?utf-8?B?SDVLYWVxbm1JKzBrRFNPajdIb09DaDhVUS9LSGtMcDU1dTlTY1NqSXJSbHVT?=
 =?utf-8?B?UmgvQ1NQRnZvMW9hbHQ3QVpEdnNleDMwZ283S3IvVTcwendCalBIRkdjMEsy?=
 =?utf-8?B?YzJPeldzczVrOWFOR3B5ZjlpTWI1VXIwQjY3V2JDZ0JvdHNWQlJMVTd0S3NX?=
 =?utf-8?B?NUFLeGlNMStNTHRZd2hHa2FNU2JLaG8vVkloSHdZZjgxTHA2YzlQMTcwMUVT?=
 =?utf-8?B?d0hXYUVacVRzUk1QR2hXa0RZekRKTWlJSGNLV2VJMk9pcTQzek1GRkhqRzl2?=
 =?utf-8?B?QjUvM21ObkplOVNDdG90R2plL0dMemhpTEZlbzkvWmR2bjJaNmYwdXJzL0U1?=
 =?utf-8?B?cG9EWDlLWTZWblBjMWY2aWt2b0FkSTNqVzYyWEVsWUtGNGFQQmxhb3BwSis3?=
 =?utf-8?B?Nm5WUjd3djFFYm1oNXhOZGhOQ0VPYW1vd1dwNnFsUWJ1MVlWcE5SbVhjc1Rh?=
 =?utf-8?B?b0Jqa2loaDc1dWREUFVvZjF3NDd4ZlZ2M1Y3OFVUTHZCeVFZVXZ6UFUrL29R?=
 =?utf-8?B?ektQL3dlRkFTM1piOU00TEFKU2NQM2ZsVFJRN2dxd3VWVGZCRnh6aTc2b1By?=
 =?utf-8?B?bzl3TnRPZTViNzBSL2FLUVRBaTNaR3hoekVpUkxJVFo1YzJPQ2dJc0xxWWRV?=
 =?utf-8?B?Ti9NTWsveVRxQlBuSHdrbERKdlQyRFRFWlVEeHZteU5BekdXc1ZTYTZabys4?=
 =?utf-8?B?bnczUmlIK1VuWHBRTTZJUURtRWJ5WEExNkZrekxVK2NtdFNuZjR4a0h2QW50?=
 =?utf-8?B?aEtzOThRZkY5MVViS21OamhpeXM1RlBOMm1VdjltQ2RyNUY5eWF3NGEvUGd5?=
 =?utf-8?B?SVhMVTB3R2w5dk9TbDV2aFJWa3QvcmhvSGR5ZWg4SFRFemxmOTdlQ2ZualRO?=
 =?utf-8?B?Yi9OZ1RVQ0owL2hBSVZZZkgyUERTQnJtbmptOS9OYlZpQ0loajJUdDRYYmNt?=
 =?utf-8?B?VnRYWExaNGlDYkluYko5MTZFUVBpQzFiSzFiTkR3WnpzcEYxbWJqYlB3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TEZ0ZHZxVG8ycjg0aGlrSG1CSG9oWG1penBkQ3dUdmV6T2o4MlV1cjljQ0pk?=
 =?utf-8?B?bDg1N1piWlZVa0ZPSFcwd25yZHJKRmlhMWd6bEdXdDRQb1l5bVZ0dUJiNmtv?=
 =?utf-8?B?aTZBTER2MERRb0hTYi82bmZOZzBkcDl0NTJxT05KRk1FT3lIWXAxQ1pXWjBJ?=
 =?utf-8?B?dkZHWTZFZURNbkRxeVN5MlFDR0FLdWJOY3lqaDRYQXFKRE9TRStxOHQ5ekRG?=
 =?utf-8?B?VVBqcEdKakYzRXUrYnNJMmkzTmRpc2xWWkVVSnZSdGdkRTJIc1ZqZmJTRHVz?=
 =?utf-8?B?ZytOSGx1bXBUdjR0WTBqd0NmTHlQZHdhSGx5ODBmSTZzY2g3ajdtZUFZWEVL?=
 =?utf-8?B?cmIzcURjTk0wb2ZpSitXZ1FtMXlJL2IzUTAzU3lvS1hmSWNjWFNFRXpXYlpx?=
 =?utf-8?B?NUpnQXZWcERuQnFkZmkwak5oMDQ0dlV1cXVUL2ZGWHZCWFJhQVVxUGpORXd4?=
 =?utf-8?B?SURJcW8zRFdxRXdzZExXSE1mY1NxREVFVG1CZHhUSm9pY3lJV3M0cmt4KzNG?=
 =?utf-8?B?U3pHUUNHcTc5cGtSdS9iSm02QW85VmFtc0k2SEMwQ2s0dXUzZTF3VGtxc0Zs?=
 =?utf-8?B?U0Fha29JblRSRUVGeGFFN0xPQThJcFdQeTllR21JTW1ZcGt2c0FSbFNDNDJx?=
 =?utf-8?B?SGl5QWNaSmQwbjNOK3RyTllKZW5kZ0VGQ0lkYzlMMU1jd1JRVmdNb2dTZmZv?=
 =?utf-8?B?YXJXT1ZUdG1XN2dDNWk5Sm1QaXJQYlV4Z2VlckdpSGM4ZExROTl0ODArMGwv?=
 =?utf-8?B?VWtyeUV0bjlpVWY0cW0yVnVwQ1VGV3dhTnNsb0NGeXpBaW41NVNxdGt3SDZT?=
 =?utf-8?B?TmU3NTVwZFBwRHRITTVTbUtWQy90R3ZiTmxZMytzWVdCcGlVNkxkcFZXdDU5?=
 =?utf-8?B?a1hySHhMZ2M4Q1YrUjd4dGVCWWNIcUJ1ejdYWjQ1b1FtcWgvOU9PTzgvL09B?=
 =?utf-8?B?WWpCcHJia2NCWERoV3JyZDlLS0dEL0YzRDJXbGxIUS9XK3RpUFA1dHkyT1ZY?=
 =?utf-8?B?U0hnMHEvWTRValFuNjFRME1aWHNYZVEyTXRsWVRYd1V4N0ZyNkkwNjgwbWVN?=
 =?utf-8?B?Z0FJOTdna1llU2EwYmsvNzRvRnI2NTJIVVBVOFZMbmE2TnIzUjdzYXR3d0NU?=
 =?utf-8?B?RXU5UUdEY0lXQTJZbmdRSDdpdXdyY0tBdmdIZnFrdWVNOXJ2dExmVTVQVG84?=
 =?utf-8?B?UERIQnRRamNQRjhjTEtnN1BLNWtJdlNqRzgwY2oycGI1V0FNMk9GeHo0WWRN?=
 =?utf-8?B?RWgwaTNzSlFzZ3h5S3pTa1FKbG5Idm55aGV3RDdscXZTc0kvNm1uMGxJQWF5?=
 =?utf-8?B?QjBiY3VZN3h0Si9WNHYzbWhEVVZ2RjdGVldhS0xTT2NtTTNaajZZTk9FbXBh?=
 =?utf-8?B?VktiRUcxMXdLRXJjVFA5SE93RGNaanRIaHdmbmttcWwxb0ZjbFpYbDB1R3lo?=
 =?utf-8?B?bExuajZ5bGlPSjg3MkJ5aDkxcktvVGN2VXNnNXF4UEg3dWIrUFk0SDdBSGpE?=
 =?utf-8?B?N0V3R2V4V2MxamNpSE93QkVkSm8wcnJzeXM3WHRNTXFWU2FGSUlRZ1N2b0Rp?=
 =?utf-8?B?NU5NbEJMRCtDajl4T1J6VDhFVHlHN2prTk5ZVXA2aFZKdk5iZG4yTFIvbTZs?=
 =?utf-8?B?Z0o1OEtNSXBxL3RoQnFPa3lwTjg4RTQ4WndIYTZValBqTnFWZ2JickEwZ3pJ?=
 =?utf-8?B?ZGRTVUJNakdBOHFUNFBVU0FNeFBQZmtjZ0VRZElBRHg0WDNJYWFqT2txN2xw?=
 =?utf-8?B?K0krUlZoMUNLVDVkUlUvM0VqODB4SnV5NWlwSE54dlZMRmpZbTFlbzczWTM3?=
 =?utf-8?B?SlpBeURuNXpzTytQL01UbmhJTThzQ1o5aWM1Q0J1YUlIZ3ljOTk0T0hWcUZN?=
 =?utf-8?B?WFMyRkVZYmkxNWlNN3lFVlhvTTZ2K0pzZXFDelU0b0NlQlBlNytiMVJRcXlK?=
 =?utf-8?B?QUswVzFxaUV3UVJpa2oxOHNLWm9WSDQyVVhyRXc5MTZjYitlV0N2TTN3SHZQ?=
 =?utf-8?B?Ynhkclg3VGhCUU5DRDNKUitGUVpUUDg2b0t2bFR3YjEyUStEMFBCenJIYkNq?=
 =?utf-8?B?bVJRMlBJaitVbVVELzFvbXZGZDlONW9oMUJaRTdyMUtyclNiYzQxNE1sRWJs?=
 =?utf-8?Q?YgPo=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14a4da4a-4e0a-4e19-a43e-08dcec74829b
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 17:20:33.3182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9fn5jVosiUBPfhqDikz5M+Nz+Oxo5KAuBtRDIk7C8h1Ea0Lj85LauDEKvruTDJ7Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6656



On 10/14/24 11:46,  wrote:
> Hi Tony,
> 
> On 10/11/24 2:36 PM, Tony Luck wrote:
>> On Fri, Oct 11, 2024 at 03:49:48PM -0500, Moger, Babu wrote:
>>
>> I.e. the user who chose this simply gave up being able to
>> read total bandwidth on domain 1, but didn't get an extra
>> counter in exchange for this sacrifice. That doesn't seem
>> like a good deal.
> 
> As Babu mentioned earlier, this seems equivalent to the existing
> CLOSid management. For example, if a user assigns only CPUs
> from one domain to a resource group, it does not free up the
> CLOSID to create a new resource group dedicated to other domain(s).
> 

Thanks for the confirmation here.

I was wondering if this works differently on Intel. I was trying to figure
out on 2 socket intel system if we can create two separate resctrl groups
sharing the same CLOSID (one group using CLOSID 1 on socket 0 and another
group CLOSID 1 socket 1). No. We cannot do that.

Even though hardware supports separate allocation for each domain, resctrl
design does not support that.
-- 
Thanks
Babu Moger

