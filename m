Return-Path: <linux-kernel+bounces-275792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C41069489DC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 09:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B433C1C2221D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 07:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8216165EFA;
	Tue,  6 Aug 2024 07:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="AAqAkdoM"
Received: from esa19.fujitsucc.c3s2.iphmx.com (esa19.fujitsucc.c3s2.iphmx.com [216.71.158.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A54BA53
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 07:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.158.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722928515; cv=fail; b=uYfY++yK2nwGQocXbCoyd40TiwkIh0Dp5mtu2h86vUyGsEDvQ1YXCI47xyqbNf/XuQ/+0uIzUCFyVDuaVlbz87C3Igh96EJwMynD5QyjgypgvKyEY35G82DKnp9VGNNvv7qhJQHkQ0HAow1pjZL0P4wjg5+urkvHpJmAX0lwXoc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722928515; c=relaxed/simple;
	bh=xWN6GlMZUP071P2HbJuxxFMm1ekNPMSMfChTIeW+D24=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=spfEptpMF3Z9FzjZXdWiXd2wIJAr+wQxFkZeChTBomDplkpesBHKdpeQiOjPxQ7omZxswzxYinRyJgbYECFJSfNA0sc2QGevWk8yFK756jfnpCK+tkJztNqvVdIXcePufvF9fdKnvMr+3MglRIfmNCGTJ8BQbBfLaFjmcbg3MEs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=AAqAkdoM; arc=fail smtp.client-ip=216.71.158.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1722928514; x=1754464514;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xWN6GlMZUP071P2HbJuxxFMm1ekNPMSMfChTIeW+D24=;
  b=AAqAkdoMzjsSx0BbZcMdyQKWXqRapjQQOUGFKpLoMbObQsc4SclPkH2i
   YRYcgTnnZyHcuPGiJkPueziapvl+RvUtm2pEihMXu7Zs+lVIZUcmlpbcg
   3WJYDYebNH652ANoQEcrhRLuYZ7hsimiVmo3faxDUan1f46fObRgXTTO2
   1qwMUaY/I3me574iQm4zUz8DPecR2Ouobe28Y1QFd3o72Rdxtf++H2PFr
   WOn/4OW1x14MzNR0sfwdM5udCidIPbri+ncSImCI+K1eGhvafI/OsWijC
   lQum58seYzY6zpn5UDuXytNSAFnvPgZzONRvMlN34oYJXIJ27G1g72EAt
   g==;
X-IronPort-AV: E=McAfee;i="6700,10204,11155"; a="126884681"
X-IronPort-AV: E=Sophos;i="6.09,267,1716217200"; 
   d="scan'208";a="126884681"
Received: from mail-japaneastazlp17011030.outbound.protection.outlook.com (HELO TYVP286CU001.outbound.protection.outlook.com) ([40.93.73.30])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 16:13:57 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uoR2mE5+nwVH/S6Jy0UFD51h1Kuv84WyEja5mqwaYT5Fpan3vkGECUmWWp7iyU5dIVlu1gvHzjWJR+zmSD22QpXU8cF53UdtKjBKRYXhFo28QHL7mkdL46tsyHzmdKzOa9kQaWZDJax5HDmH6sBX/kiYU7Ww/+ZzEkoemleuXySw1smyKTKy9NVZrmVap71siskgZcnFO0ww4CWiKfvfARhZPVdccJ+csxum8GTm5dL6xLKeOpxyVENLkGZ3U7Wi5qoWuCtM2VbSPumwtfMNGlLQsjVm2wmDRR/89ECbL78N8LOEBTCoAwglfa0DzrnkvDvc30z85++GmdtUOUBb/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xWN6GlMZUP071P2HbJuxxFMm1ekNPMSMfChTIeW+D24=;
 b=gA3bmsoMKNHCWwEHbMuuG16nzH+fU8WwHg4zumrAWjwwpUvPH1WzMucN1t3zLa7uilUj5o912Xh1hjpFIu0jI9ERxkIDuWtIgwJjp5FQBMtofmAkdtuMz/82tD+XMu1drt9zG3uIUE59p+W2F/Qq3UsZn98ZBVzq8gzcl3cJMu0PX7uWnDoP0VzDNOGVJg1u6pKPK8LUn60qhbpX+NCtyidpomff8tHKaoUjvWA7Dz0LpuYx0ZLLWfDuS9TwOQCoSRD6R0a2RqJbC/lXXPl0hrZNf/aqO2WKyQ6lqLmngF6pb3m2kJM/cGAPchWDb1iAGJ0rgMtOfEO3Ma3m/4fViw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com (2603:1096:402:3e::12)
 by OS0PR01MB5588.jpnprd01.prod.outlook.com (2603:1096:604:be::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Tue, 6 Aug
 2024 07:13:52 +0000
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::14dc:625a:548e:aa7e]) by TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::14dc:625a:548e:aa7e%4]) with mapi id 15.20.7828.023; Tue, 6 Aug 2024
 07:13:52 +0000
From: "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>
To: 'James Morse' <james.morse@arm.com>, "x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Fenghua Yu <fenghua.yu@intel.com>, Reinette Chatre
	<reinette.chatre@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, H Peter Anvin
	<hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>,
	"shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, D Scott Phillips OS
	<scott@os.amperecomputing.com>, "carl@os.amperecomputing.com"
	<carl@os.amperecomputing.com>, "lcherian@marvell.com" <lcherian@marvell.com>,
	"bobo.shaobowang@huawei.com" <bobo.shaobowang@huawei.com>,
	"baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	"peternewman@google.com" <peternewman@google.com>, "dfustini@baylibre.com"
	<dfustini@baylibre.com>, "amitsinght@marvell.com" <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>, Dave
 Martin <dave.martin@arm.com>
Subject: RE: [PATCH v4 00/39] x86/resctrl: Move the resctrl filesystem code to
 /fs/resctrl
Thread-Topic: [PATCH v4 00/39] x86/resctrl: Move the resctrl filesystem code
 to /fs/resctrl
Thread-Index: AQHa5QGB2y4bkNkbb0KYlfVozs6ra7IZsy5w
Date: Tue, 6 Aug 2024 07:13:52 +0000
Message-ID:
 <TYAPR01MB6330C74036E795940F032F5D8BBF2@TYAPR01MB6330.jpnprd01.prod.outlook.com>
References: <20240802172853.22529-1-james.morse@arm.com>
In-Reply-To: <20240802172853.22529-1-james.morse@arm.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=27ffc02d-bde1-40a4-9059-b7d7ab27dc30;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2024-08-06T05:08:09Z;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
x-shieldmailcheckerpolicyversion: FJ-ISEC-20181130-VDI-enc
x-shieldmailcheckermailid: 6fb633aa88874ef580dafdf0c8e28a7d
x-securitypolicycheck: OK by SHieldMailChecker v2.6.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB6330:EE_|OS0PR01MB5588:EE_
x-ms-office365-filtering-correlation-id: 5c508a5c-1e8d-4470-d915-08dcb5e75380
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?SEZzdDFtSFpCQXlXKzd4NlY2YlEvZURWeCs1UHl5NG11QUhIaU9MWDZB?=
 =?iso-2022-jp?B?dnZKNGZFZHJUZ3hHMkZrKy93alpCNnlmYWxNWjdWVjJCVkh1OHNwZkRm?=
 =?iso-2022-jp?B?Vk5iRUwwYVJaSzVjaFJvSDhmOWlKOHdRcnplYkkxbmh2N1ZNUDVKZ1N2?=
 =?iso-2022-jp?B?UEVYaW5aM0lwN1BCcDk1UDJZWmt3a1dtVDNJQjJMT1U2eC94b0JuRmZJ?=
 =?iso-2022-jp?B?a2FiTHYvL3U4TWpBQXRqYmxlOHBHZk96TU5WT01FRkMyNEVWOFhwMTZK?=
 =?iso-2022-jp?B?Qmcwd3k0RU1yc1FRVXEvaDVtSk5RbXRxMHFxUEtId0lwODJ5RHJ6dUtP?=
 =?iso-2022-jp?B?ZVhxMVdvNnlDaHJ0dklDLzhCa3BDTTFhTEJqRUNFdDJjWjc5b0MxRXQ3?=
 =?iso-2022-jp?B?aFVzREdSNWNkVSs2YUlETEd4MjFJbitZQWhteXN6eWpRN1M0TzdJdEFM?=
 =?iso-2022-jp?B?bnd4cFRVZWRDWlI2L2NOUWdRUVBxV0hKc3dFdWZ0UFd5L0VsQUlWMWcv?=
 =?iso-2022-jp?B?WHc3ejR2ZmFhTzlhekpQU1pmWFJ0L2QxZXgrUC9wTS9zNGF1MlY4U1Nx?=
 =?iso-2022-jp?B?OGpqZUNoaVdFb2lMN2RsclVLTzBaNXpiNitRWVB2a0RQNExtTWFhVTNG?=
 =?iso-2022-jp?B?ZnhHYVZlTkJ1a0huWEtFbm9aZEdHaWhFNWd1bFJDQXY4Yzg1RDR5Vmdy?=
 =?iso-2022-jp?B?SGQzVE5XK3YvOXhwcEV4VjhzTHJoUVo3SzUrcndZa3gwdnhtOFFHOGFj?=
 =?iso-2022-jp?B?ZmF2dzZmZFJtMjJGS0V5MXduK0xGR0lMQmtPQmlsZHBJVCtmUi9INWJl?=
 =?iso-2022-jp?B?RkJGTXZIWjQyVllSSVg2dFpRTnpLMklIQWRwRTY2TDZnVHRlVy9rRVNC?=
 =?iso-2022-jp?B?UC9GQUl2eit6VC9lUkxvNWx2SVNEenlDdDFlQVUzbEpyMFByT3dYc3pB?=
 =?iso-2022-jp?B?WmhNejVsZ2lYT2xac3VzcVY3bDM2Y29pVnplekE4Y0oydXZjcVFUaGZT?=
 =?iso-2022-jp?B?bnUxNk4xQW9DVE1xYTdUZ2ppT211aEx3TGgzMm95K2lmeU55TmROc2Zp?=
 =?iso-2022-jp?B?OXpMcmtzOVRYaTBjVFBmNE1PaTdlUHZBRGlWbDFiZFA0WjNlVDRkYUp3?=
 =?iso-2022-jp?B?blRGbU02QzNBa3VLaWZ6dmtJZzd4b1g3V0VsZFJBWnFRVVJ1Uk1ETWhJ?=
 =?iso-2022-jp?B?MmZGOUFOREw4ZWpGZTVzbDIzNlBvOWsyVkZBTE04akZ3TXNzeU1jYXdL?=
 =?iso-2022-jp?B?NGp6dmNORmdjUjBMVGFQMkVtSExKVnlHU0xhcHdVY0FuQjRYWjFldlhC?=
 =?iso-2022-jp?B?NDlocFViSmxsSGZTekVPbTB3cWZza0lkZHpuQ2JHcXg5TTJISDh3SDBa?=
 =?iso-2022-jp?B?UUFPVlR4OXZTdGFEQ0ZRcjlsa2ZtS1EwMy9UU1lrVXJSMG11dVAyZFZN?=
 =?iso-2022-jp?B?SmdTNVFjTWswM3B0SlA4VnJmb0JLcTRwYllvT0k3WXU3ZWI4akYwQjZV?=
 =?iso-2022-jp?B?UEttVVhxRllDdDF1em91Nzc5WmJ4OTRBVDI5Q1lsU090cHduK0NpL0hI?=
 =?iso-2022-jp?B?Y0lhWFFiMld5OS9lQkkxMTVqR2M0bXhaRzBjRlFmLy8zSGt4VFJscXlD?=
 =?iso-2022-jp?B?NnJ0VXowcWlPekMvUFBOUEhZc2dRZTZmWHhkZ3JaTUVxNEZDMXNiVlZi?=
 =?iso-2022-jp?B?UGJGNGpDRWNpNnpVd01SQkVqVEpuLzhhL0RxZEtmSUZ4MlRiSUZzYzFn?=
 =?iso-2022-jp?B?VzlNUHpOdk0xTWpLTDRyTGhrODdTUVR2VFRyVUFXMWtlWnhJbDJHd0VL?=
 =?iso-2022-jp?B?cm1hazZvZE90b045dUxQUmNyN2VKZEtHd3prdWVOempxWkJqV2hQV2g2?=
 =?iso-2022-jp?B?SGppZTQ1dFVBeUFacXNIU3NKTERiSmQ5WVl2MFNNazlzeG42K1pTMW1r?=
 =?iso-2022-jp?B?Smo5ZFVKSVVNSy93Q2NNMGd2OWJ0aWJ6NDJHME1paVdjV09YQmZrNTR1?=
 =?iso-2022-jp?B?TVFXUHVpNjZ0dFF6UkRBNVIza05ZcEEzaFhKVjhXNmdJZ1FtbUd6UWpl?=
 =?iso-2022-jp?B?Sms5TlRtSUZqRjMwN2pmcm0ybTVzUUk9?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6330.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?TlVveitEc3huWk90M3ZuZXdFNE1ETTloS0w2VUNqNDRtSGF5RVlsNzBu?=
 =?iso-2022-jp?B?NUhOY2s3VDFMRWZGY1VHZmhYc2R1b0FQWlNINThTQ1RnUlBBVHB2VjBH?=
 =?iso-2022-jp?B?c1BIMFdJSURsV1RtZm56eTJSdGVqOWNvb2Fnd1hHemNGVnBWYWVhRy9W?=
 =?iso-2022-jp?B?SzMydFMvWjNGdmhnR3FBUFExN2J5Z2tuOTRsWnowUGxyMUQyVmZjMDNY?=
 =?iso-2022-jp?B?WDcvc1VnZ1pMdTdramgxZFlzelFUTFNYcmdxVjVzem5RZkpScFZkeU8v?=
 =?iso-2022-jp?B?UlUyM3FtZ1RTRFpibVgvQ0Qwc0ZNVXFWa2VvUmxFQkFwaWxhN1NjUkc1?=
 =?iso-2022-jp?B?a2dlOGVwOHVrZXZQYk0xOXJCVjZ5dm5TdTNOazMvYUg0SVZqRlFUT2tl?=
 =?iso-2022-jp?B?d0VJSHQra1l1d0lkNERMZXQ2cGh6VmZqRXJvSzh5M1NDNUc3eEZTcWR4?=
 =?iso-2022-jp?B?R1cxR0tJcGsvYzAyZ0hKYk1NUUZ5RGdvbjIwMHZFM2lYSFRYWE51eHV4?=
 =?iso-2022-jp?B?RUQxVm45MTYwUEVlakh6Njl6WFhjYlkxaW4vREQ1TloyTGxDQWF5Y2kw?=
 =?iso-2022-jp?B?ZXNTcE9wTU9rOHdjWS9YcDgvcFVQanp1dGY5dmNjZGVlRHBBWjE1MnVn?=
 =?iso-2022-jp?B?d08yOVprU1lielh3QURXVzVlcnFDb2hUdDdpTWhFM01FVnBqdURUS3BT?=
 =?iso-2022-jp?B?SEZTTjRiTFVCaVUwNGczWE9RanlVYjhhdFpLS2ZSaE1GNjVKeFdURnFP?=
 =?iso-2022-jp?B?N3NHdFg0QXkxbFFXYXovakJ5WXA3MXY1NkdsdzZ4eW9vcHB3ZXFWcFlL?=
 =?iso-2022-jp?B?ZzRqVTE2SnhMSEFkWDd6czdJM1hpSmlSYVdERXRnV1FObUNzZjhsbVBo?=
 =?iso-2022-jp?B?cXFhNm5waEVBVURubExyUXRLSldVMTZJdE1nOVJ2bzNGbEgrVWFqVnM2?=
 =?iso-2022-jp?B?bXkvZndWYXlmaW5BMERUb0VPYlB3UFlmVTJlRVB0N0NlYWhaUk5pQ2ti?=
 =?iso-2022-jp?B?NkNmWEhPSVRDMzF5b1R3R2J6WnBXUFgrQ29XRXdUTENZSVNsdWV0STRr?=
 =?iso-2022-jp?B?MHVORWRLVTJ2UjhFL2xsNE9obzMwcUNFNkJBa01Oc2NYV0w5V2Q0U3Z0?=
 =?iso-2022-jp?B?NjZCVGJmZW92TktmTVJ3c0puWVczWklTUHY1T1k3eGQrbEZwak5uWWpr?=
 =?iso-2022-jp?B?cXdkWjM0L2lMU003ZkZQblpUcm4vai90cVV4OThKV1FQeGM3WVFBdUJN?=
 =?iso-2022-jp?B?eDhMMkNmVTd2d0RkckJGdlJNYlJWUk92M21zUklLd2dNMkZjb2xiY2tX?=
 =?iso-2022-jp?B?dlE2UmFQT2p5aWZjczRJWTlpU0E0N0J5OFBmZ2diUDMzWTdDMkJuTmhI?=
 =?iso-2022-jp?B?SU1kL1gwR1ZTRDQrYzlJRHNDQk9pV0czQ3N1L3FrSmpodlJXek54TFJ2?=
 =?iso-2022-jp?B?TUFya0VZcVk4Uy9oUmtTV0FDOWRidFkxcFQ1N3RFUVhmdzE0MEk4cVlX?=
 =?iso-2022-jp?B?bzRDZHJkWlpEdXVjb2d4ZTFGWmwzMVE2enJ5dzVqTzg1R0lyNjdVbzMw?=
 =?iso-2022-jp?B?YWlZeVhoVkdvZjJZRFJUYlc0OHJRTXZpVlZjOWc4b1NtaWZta2o2RHFC?=
 =?iso-2022-jp?B?dTVRbWNaSHgvM09hMlB1bEFNS2V1NTVDVGdINWFNMG1EVEN4bSs2eGNw?=
 =?iso-2022-jp?B?RVFOcml3T3B3blJEajhZMUhLb05jWDRad0V5dURoRjlKSVNnWHJVQlMx?=
 =?iso-2022-jp?B?ajhMMFpIdmMvNXpndEVWcXZYMU03QURoYjk0eUh3aWFNOEYrb2FobytV?=
 =?iso-2022-jp?B?dDlMaDBWQkcvWjBma1hJbWdIcGpxSk1sWFFDTndEelRPcXU1WCtpbGtx?=
 =?iso-2022-jp?B?VVAvbkJLT2U2T1ZCMS9lTVc4cGxadUJGYkFGankySDlWdmRrQTlNSmho?=
 =?iso-2022-jp?B?Z2dmODhPTlY1emRqdkM4djhMRGtwTFQ5bTBENDVMcDBUNVl4Vkt1WEZT?=
 =?iso-2022-jp?B?a0VVNlVEaHZwa3hZQitpVXdBWU5FS01ZcFA1TnlCd1NycmFtcW5UQ0d0?=
 =?iso-2022-jp?B?NXM5aFQ4RW9rdjR6M2N6VGVuTm1XU1JEWTQ3b1J4ZitBYmUrSXJLejI4?=
 =?iso-2022-jp?B?TGp3U3h6TGozNkVmR0loNThCWmdzdDNtZ1hnRytZOUZRRFEwZmhScllQ?=
 =?iso-2022-jp?B?K1Q1Z3VqUXp5YWNPYUc5S3kwejFyZ0xIQkEyUW1iSGZtei9qaFRxRmFh?=
 =?iso-2022-jp?B?dGsyczJJcUJVcG9Dd2hNL1BwYklKVnp6L3NkUWNHYnJZTnVHS2JSU0dX?=
 =?iso-2022-jp?B?UW5xRkp6Z1BaenZ2MTZGWDhuV3VGWVRWaFE9PQ==?=
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
	j3izBSlDH0VvubYe0ChRDpIgPn8Igpm4zhBS5eOSXEnYlrjaGvN8/bUCM/rVg/DApMgzIMDW05zD/8nghX+eFFx/nqRkBtdy9I74IQbro+o1XM2wIPmG5vxsVi030vc19bQv1VLiJO5jxOvPYivfsBwB8dqqyBXlVnSiJjRnxCkfvHTGkZOsuOmOsANL7f+2hhbLKHg1zSZKa0YPbUVhorlBkP+DekpXCJEjVebgdWEPH3KIfD127teTIb2aD89ZdWccXp/l8DI/QrqNKO1Y339vu3apZWkHaiMH7rXfP3M8rticyfOpgTp/X41NHCX9sDvEciryaD+m/szgtAZuH+w8KpqJWAXlpRfWszy0bDLJPNELGaSdNDbceEcwULeOJ7c+OvfD8ra9Zg4qWGdCm8EbdUYy8uCVPGXu124IcxJLwTVPa4EOORV8EZ29PRMZ8gWb1Pkj58ba1MfQcJVF9tdus+7Yut/EGaYiazPs1okkIc4P7C4a9wLbjEZR5czX4qSTsYFevBgttIM2G6TNa7eWd7Ax1lNG3K4cLYMxDRoEjnOpuI1Hv53LqSYBXZwtCWgb44bG3h4M03vaW46qgdIUHkUIr8wwKcbiqxTrBG2rOvIzhm9RDL1yFZoargYH
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6330.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c508a5c-1e8d-4470-d915-08dcb5e75380
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2024 07:13:52.2279
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qBr86MrXXnGN6UIUGeHfy/Q+ROSnODcs2ryCFZgL6JFkhS0OlAdWg8CL6Dj+djH+rtnITFK0rjcWN8xEXzNDJp/5cQRm9p3FnLojHoGpyPA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5588

Hello James

I ran resctrl selftest on Intel(R) Xeon(R) Gold 6254 CPU, there is no probl=
em.

Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>

Best regards,
Shaopeng TAN


