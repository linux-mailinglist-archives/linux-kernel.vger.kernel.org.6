Return-Path: <linux-kernel+bounces-287588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A6895299C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 09:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D1C6B2169D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 07:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96112179954;
	Thu, 15 Aug 2024 07:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="pmntJHTk"
Received: from esa3.fujitsucc.c3s2.iphmx.com (esa3.fujitsucc.c3s2.iphmx.com [68.232.151.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F870BA20
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 07:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.151.212
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723705485; cv=fail; b=YlCvkCkeuY9LG7E544MfA1JlpNkhLqZFJfo7MlP0v/5dm0olXDuD9ULE7+lLzyLqFN+6CdWXHVvSaYeoKpiNwAsl47csOM9KMRqauDilIcNt2TAKi+hErLiEti6sE8KHc2nmV73Hwi5SUJUZ7vX8rl10QyTNoqFJrEnzryUEpUo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723705485; c=relaxed/simple;
	bh=oo2mnIiVUaSOh7c9jJel1QhinsTZOVpmGhDH06ekIS8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hff4e+adoWSGx2oETGS8LNa/MLKPfXXVzZW5YrdcdJphpslA0FzbzelVGdIMbaHENCmSwEn/ooJD61U+1jRU1T/yDfTNit4PnhpJjcdtqmcS93J2/excEvBtikdZMbEwc4G/XjPHQb8pE+EperqfPNTC6S0Rnq9R8RTypuQReIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=pmntJHTk; arc=fail smtp.client-ip=68.232.151.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1723705482; x=1755241482;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oo2mnIiVUaSOh7c9jJel1QhinsTZOVpmGhDH06ekIS8=;
  b=pmntJHTkXqG+iR3Z2X44HBvKVEa6/pz+RmZzdpezYfVxDCx3EIARDAMs
   XpWGlPfeeNark9EtFZ5mg0ctMkpHmepCL7vBp1JggY+z/DXOc81lMTgSp
   FAtdIQmh8vGPkgqBwo+KRKx8bL4d2i1sUClL3WFTXH+zQuhD5lcoLvzj7
   wheB/dv2jPFFk2F/MX6cHNrK8kqaIb2f7TuI//r/HmOC/eg9HbD3xt+dO
   ULxZp9vi2nEGfUYqxfSs8f+0mY4K2NyRHkgf21o0Hk+51ggWP9hkXk6Cz
   Tcl7lbmYE0hFALR0YtgYYPYnjBF0ipBe7koKaSXuUGKgrOIipQybsslw3
   A==;
X-CSE-ConnectionGUID: TK4tSwwDTci3fr1lovBq8g==
X-CSE-MsgGUID: TBd/XN+AQ3OTvlvdQwN8Ew==
X-IronPort-AV: E=McAfee;i="6700,10204,11164"; a="39286639"
X-IronPort-AV: E=Sophos;i="6.10,148,1719846000"; 
   d="scan'208";a="39286639"
Received: from mail-japaneastazlp17011029.outbound.protection.outlook.com (HELO TYVP286CU001.outbound.protection.outlook.com) ([40.93.73.29])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 16:04:33 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p51t6ytQEbqn5RDFP9z2gOP/0PSeupnkMeT0vU01B0sSb7yqRmur23B6/7kLEp5MkKscWjGNKqdRL7Of7IZVHpcisHGuSEKNb6aVSi4LDLQTdNEbQDJ7dPBaAqHL/mRdI+X1s3QiP/j5Hc/I/DTYx2yqUuBpqnzMS6yPWREnq4PKhIyOZETQBZWJby/1U0n8QuOnzGmcj1wy/fKUVMqRqsfRIqeU/wcabyJQiaz1JRShdLQ16u+abV2+eCCbF9aFJAkLzDb8ICCNBvK2kCD2VwuzOXHl26bOS5JX58pc1+Du4K3b9qVsM65pC/qhfiCFh5zx9NPEoUF9+1Q9jR98aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oo2mnIiVUaSOh7c9jJel1QhinsTZOVpmGhDH06ekIS8=;
 b=I2AtmXmZPCwDO+KKjQX6lluhQoYeSVeJ9CrilgbtXWS659TNcQDEb/A1lxY2GiMd4zMovYDlztTB7GEeSMTR4Q81MfhTLIX9YzMf3wDGFhGpScKycK2ApyAWpJQqdT88Lj18ALHH4fxSsJ7hXsx3mPanKHQjWhdvBBOFczRJx42qLCqrM/foh48dlU/RKNTvzqzjluXdOmJPGV9zfkMfaeFH1HFIUcyG5wY7DKckipFzowxGpq++t1mXaDaobYgI4PgydjwdYDBZmGTbzuUD41UDdKZj/NwY0UZelfF7bSGQRKRNcV+Jnw9MYUuqKjuy5r7PfMxurAHLI0LC5ikW5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSZPR01MB8798.jpnprd01.prod.outlook.com (2603:1096:604:15f::6)
 by TY3PR01MB11843.jpnprd01.prod.outlook.com (2603:1096:400:40a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Thu, 15 Aug
 2024 07:04:29 +0000
Received: from OSZPR01MB8798.jpnprd01.prod.outlook.com
 ([fe80::4344:1f7b:e34d:c672]) by OSZPR01MB8798.jpnprd01.prod.outlook.com
 ([fe80::4344:1f7b:e34d:c672%5]) with mapi id 15.20.7875.016; Thu, 15 Aug 2024
 07:04:29 +0000
From: "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>
To: 'James Morse' <james.morse@arm.com>, "'x86@kernel.org'" <x86@kernel.org>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
CC: 'Fenghua Yu' <fenghua.yu@intel.com>, 'Reinette Chatre'
	<reinette.chatre@intel.com>, 'Thomas Gleixner' <tglx@linutronix.de>, 'Ingo
 Molnar' <mingo@redhat.com>, 'Borislav Petkov' <bp@alien8.de>, 'H Peter Anvin'
	<hpa@zytor.com>, 'Babu Moger' <Babu.Moger@amd.com>,
	"'shameerali.kolothum.thodi@huawei.com'"
	<shameerali.kolothum.thodi@huawei.com>, 'D Scott Phillips OS'
	<scott@os.amperecomputing.com>, "'carl@os.amperecomputing.com'"
	<carl@os.amperecomputing.com>, "'lcherian@marvell.com'"
	<lcherian@marvell.com>, "'bobo.shaobowang@huawei.com'"
	<bobo.shaobowang@huawei.com>, "'baolin.wang@linux.alibaba.com'"
	<baolin.wang@linux.alibaba.com>, 'Jamie Iles' <quic_jiles@quicinc.com>, 'Xin
 Hao' <xhao@linux.alibaba.com>, "'peternewman@google.com'"
	<peternewman@google.com>, "'dfustini@baylibre.com'" <dfustini@baylibre.com>,
	"'amitsinght@marvell.com'" <amitsinght@marvell.com>, 'David Hildenbrand'
	<david@redhat.com>, 'Rex Nie' <rex.nie@jaguarmicro.com>, 'Dave Martin'
	<dave.martin@arm.com>
Subject: RE: [PATCH v4 00/39] x86/resctrl: Move the resctrl filesystem code to
 /fs/resctrl
Thread-Topic: [PATCH v4 00/39] x86/resctrl: Move the resctrl filesystem code
 to /fs/resctrl
Thread-Index: AQHa5QGB2y4bkNkbb0KYlfVozs6ra7IZsy5wgA5A9tA=
Date: Thu, 15 Aug 2024 07:04:29 +0000
Message-ID:
 <OSZPR01MB879814A1694F789D4DA4BABF8B802@OSZPR01MB8798.jpnprd01.prod.outlook.com>
References: <20240802172853.22529-1-james.morse@arm.com>
 <TYAPR01MB6330C74036E795940F032F5D8BBF2@TYAPR01MB6330.jpnprd01.prod.outlook.com>
In-Reply-To:
 <TYAPR01MB6330C74036E795940F032F5D8BBF2@TYAPR01MB6330.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=27ffc02d-bde1-40a4-9059-b7d7ab27dc30;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2024-08-06T05:08:09Z;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
x-shieldmailcheckerpolicyversion: FJ-ISEC-20181130-VDI-enc
x-shieldmailcheckermailid: 9d57ebf46f4945f2b37c6e145cf26441
x-securitypolicycheck: OK by SHieldMailChecker v2.6.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB8798:EE_|TY3PR01MB11843:EE_
x-ms-office365-filtering-correlation-id: 3ef0ba67-c4cb-465d-04fc-08dcbcf881b2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|376014|1800799024|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?N1g2NU1aVFJNdFZJNWUrbnF5bG5QSktjRHdvV3pTUnQ1aWUrMklDOHJw?=
 =?iso-2022-jp?B?OGVldmkwNCszQjRnbWNnNXNjSUpJMTFUSVl5bTQ3Kzh4b2JsRHlrV3k1?=
 =?iso-2022-jp?B?NFNBbzhUWC96WFV5NUZ5Y3Q4ckp0cllzTWRIbGdJMmlFcDFjUHhnMjlX?=
 =?iso-2022-jp?B?U3pZV2packd4SmZ3WXRicEw2T0lpOXRoeEk1dmIrRjI5YlFoL1JtNWJ6?=
 =?iso-2022-jp?B?N3hKSlQyYW1vZUZEMlVsbkd4RVY2RTNPUnNWZklFak9iNVhXZ2hqbzgv?=
 =?iso-2022-jp?B?QUpySGdTakFpMlMzWUVhVndqbGlERjJyT2VHaGIwQzM0bFY2Z2dNSXRo?=
 =?iso-2022-jp?B?UE9iclB4Tmh4RHluQi9HS0dBdUNkUGUyY0ZwWm9nOHRTbThqRmVyMExv?=
 =?iso-2022-jp?B?UFJiS1pQQjR0Z0hSa0pYMWxibDRkSlcxbzVpTzRoa2JJNk9UY3JNUXBX?=
 =?iso-2022-jp?B?V3lPYktuVjN0bGIvNmlCSHgrYjFoN1JQWk83bVE5K1M0bzJkNUFHdGJV?=
 =?iso-2022-jp?B?ZVdWb09Sd2VDeUFuaEFrazFMK0dlaDd2NEFhMXBpTDY5QUdRYUZIMzkv?=
 =?iso-2022-jp?B?T2hCVkIyenpvdXJQU0VRNWxYRHBQWk00eEtJdWJWNnByb1REY08xVjk3?=
 =?iso-2022-jp?B?KzFoMXZIR1NvTEJnTmVpbllFczdBNEJDVGxtMHg5dm5VeENLTGdSUUdr?=
 =?iso-2022-jp?B?ekZEblhZQTllc1RURjRkWEhYcjUzQVlhd0hxaytsTmRKZXI5SlNQcXFN?=
 =?iso-2022-jp?B?KzF5ODI3SnlSOVZIK0ZSNXh4MkxuL3IxRUNrQncrT3FQb2hVZnpXWlZL?=
 =?iso-2022-jp?B?OWFLbGNWT0VwSk9Vd3VKbDA1Um1nTHE2K2lMcUFCV280ZnorOG5KYXM5?=
 =?iso-2022-jp?B?dWV2SFZBMWg1TDRvUXlhdi8vUE9uL0lFQkdBNVVKcXRwbkpOMWdzVktP?=
 =?iso-2022-jp?B?Vzc4MXU3RUp5cVppTk5rN0pJL3F2RWJ4SEpkRGNuRzJqUzRXUkRHVkp4?=
 =?iso-2022-jp?B?TXptSHBvZVVWTGhPSDNFUGJYQ2dTdmlOUExPSFcyeVZDUmN4eklDd2E1?=
 =?iso-2022-jp?B?UDRPdmtIOVI4VlV0bWRPeXV6Q0NzRmh5V3dKSU0yaHRTMzUzUWNnbzAw?=
 =?iso-2022-jp?B?Y0ZOVkxLMjNUakJpMEdoQ3BiZXBoMG1MamRINndMNXRNaHRlUHN0bUJk?=
 =?iso-2022-jp?B?MjhwaWpvQnM4clRqM295YWdvMFh0S1dXQWVJVERxejUwZU53WVZRbVNx?=
 =?iso-2022-jp?B?V0gyVWV2dERqRnZZdmgvQTlxMHhBSndoSi9QWEtrVmc2RHVsblRrL1Fy?=
 =?iso-2022-jp?B?d3g0Ry85U3krUVM3dEk1SEN0MGcyY2FWVkF1N1ZyR2JYUmpBWkJHbmJQ?=
 =?iso-2022-jp?B?Q3piWmJrOWllNVRydmN5b0VFNDJxRFRPRWc5STJ3RmpYRitoeElxUHpP?=
 =?iso-2022-jp?B?blBGUGpRclZ4QXp4WVhVN0ZJdmovN1c0S3ZXckszanczSHdTcE1uWitJ?=
 =?iso-2022-jp?B?cHBXQUx2dmZjbDZiazVzcjlnZlNMQmtta2NwcG9PRWUwT0gvdzJ2K3Yr?=
 =?iso-2022-jp?B?andhUzNQSHlRL3RFSW9qbzcwM3Bvdi95eUduVEtjOVZvQlQxNER6SHFN?=
 =?iso-2022-jp?B?cm9XN1hMVXpEcnc2VVpsdGI3NEdDdnRSTndjcUM0a0p4Si8xY05GMXVm?=
 =?iso-2022-jp?B?VkJVeW1OSkYxRW80YjY0cE9HT0ZMQjcwdi8wQnJvdE4rK2F0MW5ZZCs5?=
 =?iso-2022-jp?B?NXdWeEE1ZEVWRm5iTjhOTjJQY0VkRkQzelUwYWVVczBPRmY1V202RHZx?=
 =?iso-2022-jp?B?eml2Sk5NVG9YMFhZalU2Yk5JM0NlcFhzM20rMGxvVis0TlJaTG1qZXQ3?=
 =?iso-2022-jp?B?N3NmNVRMZnI0SU4zRk93QU4wMDFQbGJibmxSSFhNek54dDRtSFZ5SU03?=
 =?iso-2022-jp?B?ZnFyR0NQZlNHaUZnaWUvUUNBN3NsODZWa0orckJyY05TZmFQZnNGcGh0?=
 =?iso-2022-jp?B?Z3ozbnYwUDZwMWZMQ3pUMHRlYTVBeVVQdStqOUgxTnB5KzU2UlZqaXlw?=
 =?iso-2022-jp?B?U1JUZnZ3bUNLcm5FSUtiZW01VjhabzQ9?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB8798.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?L1o1bFpKOHlyeWpWWHhoVUE5d2d0aEsxUmRxbkcycmo0cTZsYlJXd3R4?=
 =?iso-2022-jp?B?akwzZVNqUEprU3NLaHRyY0RpZzVXekNQYlNuMjRKQTRWMGZKRnRCbjlw?=
 =?iso-2022-jp?B?dUdyLysxNzFkcUlYZVlNNHdCTDh3UWl4b0g1VEhiNGFDNHdZU0JXOWts?=
 =?iso-2022-jp?B?OW1CRFFhV0NDU1lNakFsa0E2UTFjbUFkQ1E5aEJRK1haUU1nc2tQVmtK?=
 =?iso-2022-jp?B?d2dSb2o0UXRUOWpRdnJnRXZ0dnVxZVozcjcvdk5uOVp4S25TMXJEMnlQ?=
 =?iso-2022-jp?B?c3ZTSGJ4WUVXUEpURFR1K1J1Y0ZvNjRvd2hldDhYL2gvU0ZjV3c0OVlm?=
 =?iso-2022-jp?B?Ly8wNk55ZElYNnlueXorc0h4RmJ2eDZXK3FLVCt6aWlsWmZOZWFsT1JB?=
 =?iso-2022-jp?B?Slh4S1VRdmkxbE1mQWxDbEhvU1JQek5VZ1FVakMxVW5HazZDZmRORFAw?=
 =?iso-2022-jp?B?elhrWWdQNTJYQ1lUcC9GcDF3enJlekdnZklyV2pmSFN1SzUyNTA4c2lE?=
 =?iso-2022-jp?B?NnY2b3U4ME9Fd1phZXdvMUtLN2VTeXlSeVN0L1JiNXEzR1Z2ZlBPTlEy?=
 =?iso-2022-jp?B?ZU5xL0doNU1rdFVReWRUMTA2L2dPVnlaM25CT3Y0UTJsSC84NktoV3o5?=
 =?iso-2022-jp?B?djVXVTlNZG5xTGs5MUo4eE95SEFpQWkrTlEycjgvZlU3clFielA5SlY2?=
 =?iso-2022-jp?B?OXk4aXNnR2d5em5NaUozM25lZXpLRHZZL1lWN1EwWGxMd21mU2ZRUlA0?=
 =?iso-2022-jp?B?dDF3aStwV1FadG9KWXVDOWhYTkllYmdYMndTRTU3S1QxeE1GTEU4b2tj?=
 =?iso-2022-jp?B?TnByOXlmNW5mR0ZBUFRWbGVsWFhUR2sxSDR5aGgvRlcyZXZuZVZsTi9V?=
 =?iso-2022-jp?B?QldXakNNaExKaXU0RkxMbGpTZUZQSzdZSENiUnNZZnB5OWY0bERlS2VQ?=
 =?iso-2022-jp?B?V0JrZ0RmTU1kaVRNS3ZuVDVJdTNHRWg4cldxaDJRY09JczRZdUxEZEd5?=
 =?iso-2022-jp?B?V012Q0ZWb3VCdUlkQmN4d0FCMlI1OFF4MDJXWFhrMlhZZVFvajliWG1u?=
 =?iso-2022-jp?B?Ujh6cnFzWE9HZWp6LzlUaFBuREdPZXJ5cVlONTdTTWZlZHNpL0J0NVFs?=
 =?iso-2022-jp?B?WVdnaDZsVEprYVJWV3Y0anFIcytrdHhRYjlWeDVrN0c2QXJRZjgydTNl?=
 =?iso-2022-jp?B?QmZqSE1DYTV5bEs5ZmRJR0RxK2pKdVpYdkxSN3lqUjdQMTgrRzNSL0Z6?=
 =?iso-2022-jp?B?aFRUZE1ZSkdhUmI1Z1Z1RFNLWFRCa3pwTExmdmFFTXhVQ0hZTDcyb05w?=
 =?iso-2022-jp?B?Q25zS0c3TVI4YWlSTkllRjJoN2x0Y1hZNFV4TDhOQlpLb1pTL3V0OXc4?=
 =?iso-2022-jp?B?S2hFRDFpZTExWGt1dVlPYWw5YlFCYms1aG1jcDg3M0dUZnJxZjRjcEZa?=
 =?iso-2022-jp?B?UGxIam9XWHpuM2FoRTF1czFEUmJ5U0cvSThCdGxhbGM0RW91NWJRS21B?=
 =?iso-2022-jp?B?b1NBTjNUTnZId3hYaTBNSlZ6MnJOem8wRzlJTVVNUHNIUGY2bEJnWHNB?=
 =?iso-2022-jp?B?QXY1djZXeFBMYTdXTXpNQ0hqbi9QSGtpNTRpaWg0RDZjZWFmSGFXMXo5?=
 =?iso-2022-jp?B?cWc3cEhRUHcwbzczY0tmYVErbWp5ODc1VWxyOElqUjQ2RXpXZ1N3U1FT?=
 =?iso-2022-jp?B?d1pNc0E1eDhFd2dQQlhUaGtXZ2NaS2ZSUERQbjBUYVN4VTNsZlpuZHlE?=
 =?iso-2022-jp?B?ZjZmOEFHTXJCTTljT2djaEI3TWh5Si9zQUhyVnBnYlNmV0FrQ2VJS1pH?=
 =?iso-2022-jp?B?MGdVNTFUWFYxMllCZGpmSEFCVms3YUlBZ0ovN2JrZnVCTnFoTFJOaHVP?=
 =?iso-2022-jp?B?K0IyUTllVURBWGhFbzBXeERJVlpyMGcyRzJRTk9WL2RTSnJlZVVJRTNl?=
 =?iso-2022-jp?B?Ym5BZGIyT3RNYndZd0FYeTJienUwdjUxcExTTDNGTDY0bWc1ZVdhakRU?=
 =?iso-2022-jp?B?dkFxODFMMlBOL2dTZXVvMllOSElWSGRLUkJmMndySVZuUVhYTjZhcXNN?=
 =?iso-2022-jp?B?K291WlBxeWN4cmxnbW96U24yaXREOE96bFczNmo4S0RnUmFBS1M1dmtF?=
 =?iso-2022-jp?B?cFdYZmdWQWk3eU1QcTl0SnVUZ0t6ZnBzM1pDMjQ1VGUzOWVaSVJmd3lR?=
 =?iso-2022-jp?B?ZmZkWXBucG9YNG9ib29zT25HeFBmaHhFVTVVOFZNVmpKWnJ4Y1o1WmlI?=
 =?iso-2022-jp?B?REt4UGEycy9ZVWhNczVCWmd5YTdFQ1JtSVloYThWdWV6Ly9rOUdxZTJo?=
 =?iso-2022-jp?B?cGFQSFRpQ1BlNjZNUGppY3VlWUVEZ0oxU0E9PQ==?=
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
	nWnKm876zBb7ZsEeTnjEOWJ+eHpaxX1Mu3+JB1J7+8zOalOC3RUTytMirbirPRIMlrnMFDUP1X/+M2N/yQR9H0PA4r8Q53ZkST66vjY0ZloVCK2gxAGidSEldlya52cEtIzTPIacIjxdsYpYtVmCRbUkCqbYK/sOWHnE9F/Oa+KVEzKX2EqNDNUpMODzgSgfMrlP7DXL7J7BmdMzEK4EW2GceSxeZ3K7uDO8pAM3SyiLE3hsC4X0xot6r0EDIIQknSw3WxI2Bv+CdlM1vnUOKjnNI8YekTZ3SGuNK0tb5dc6+66HG8K9NA2crlUVAjJuOsRk9+zwhpM/zsykGeB8GqFVbIxqNZwfP/nh3U2b4eaOFmb33QhnWQZXdHzMzGSP/2RN9mm5iHmAM/lYn08MVIQa+CwnBgGdgRQaGNP5lxcRSY4eHDSzMJ47nUfKB+DLxetPiFuV/ZMLp340sl0HVeLIaoP+tKFk/tfhGqJFf9OMEivSWi/YtUs2nekSQL9bhwetMviPPbzvanQrC0ZKXyAmRQLUmoXUXG5wJUG02t4ASdYj0PkEaJwiytxOK48FqMXnB432941Gs/sQQ9PpFh14xhg5WJ5IRgkv6o6hUBXLn2E9V9TKZdciZkv3M8wz
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB8798.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ef0ba67-c4cb-465d-04fc-08dcbcf881b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Aug 2024 07:04:29.3298
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VqPKR1mDEHsj7pZ3GY3prPnh7Zfw2cXKMtSwQsoqq+CZ8/66WbyuRgSatWz6jsUj8h4c5iuP8ERblKVNJr0vurl++HPxn0aVNyRNUmqhYlY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11843

Hello James,

I have no other problems with this series.
reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>

Best regards,
Shaopeng TAN



