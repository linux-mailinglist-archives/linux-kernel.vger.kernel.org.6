Return-Path: <linux-kernel+bounces-186865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D028C8CCA28
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 02:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D884E1C212E1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 00:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06DC817F6;
	Thu, 23 May 2024 00:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="WkuVpMsp"
Received: from esa14.fujitsucc.c3s2.iphmx.com (esa14.fujitsucc.c3s2.iphmx.com [68.232.156.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B7717C2
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 00:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.156.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716425304; cv=fail; b=J+g2T9Mh5U7J7VMZGDhKR/dyD7CFQGt04YYUms2sGwnR1YYbRxJHgQ2WWySJUk78ZHNPeaaRvOGPBEHiIQep9JkoyRukQNl2SX7zB2FJ2mJMczT3bEm4b5jIhjk5k8+zeKog5ecQJOHWz/26xfhPa4N/Dm55getEz4Ji7JqrP4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716425304; c=relaxed/simple;
	bh=cf0akKeAOE9ZOeEeiP3SDNj36G1ZefxXSMxLd1NWKj8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JgtB99C5qO8O6achZk0TBLM4pXOrWgrJjcHQdIgZ3MDMWe5pd7PWKcCXtmVI8SsyjwYTyuMV+8Kt1ATOuQ90xaMvrFRe0BKT2AaCRyO89OaKPYPcztJ7awmb/RtDsqzzkCi3PV33eTSe/C8kR9PVGwsVFrwvC74PTA6HtzTKnEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=WkuVpMsp; arc=fail smtp.client-ip=68.232.156.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1716425300; x=1747961300;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cf0akKeAOE9ZOeEeiP3SDNj36G1ZefxXSMxLd1NWKj8=;
  b=WkuVpMsp0ldSuOSrEU1X7rSOnKcuVI4sc3G8NyI4nF89SArCM7p0jJZc
   UiP7axQ/GYjeFIRks1bZfivyiVf3rObHRVVFbecae5b+z6PVaEPUAZXXO
   VbOhclgirYeOb0uFWDAovPzYK7sTUT7Fw0H1OCxqy15FKX9Oec2gNlmg/
   XbYaDrW7OiI5uSKpOHU7AslhBJgXNiCApOdU09Jgo3h6Re9IGepsiW945
   5pm0cfaf8oGWD/Mykl/4ek7LPb2tvgTNDButju07vbsAtt5qNAkT9zSbK
   jMqEOJjTRTAF8S7coJYzzBbmaqPhmCmpBvvw0TXBy3q7nuKfNsXjMlKoc
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11080"; a="119757395"
X-IronPort-AV: E=Sophos;i="6.08,181,1712588400"; 
   d="scan'208";a="119757395"
Received: from mail-tycjpn01lp2168.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.168])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2024 09:48:05 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gyKJT+ENkBt66QUJmM5FET06+A2cmVuiuYmEqQql14hGK9Q3yYMs9FLBLTG7of3bKnYPIm5E36b0fdSxYQ/hixA1aMLEPSwQwF9xqKvwxAh5634lOxH62pYxVrWc50pAennfkC0FXb0K2b5g0w707jCnrTE73c/g5rr50BC95aTT5CuKZt3QjSBWdkkSQL1D8t7I48ZEkQGLVmJdAexRPpnwjuICIIoHXyieXKDXbySBY1sKDdk0lXOdjEnwjjJWe9wkMjoFc1v/oQ9j5lDnJrTtU80dedPcHtiQDfm6cukfaGKP2kM2PvyArMJlYLpQDMsHMNafXLEcYMEXCt+vXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6IDBY+/p6IG8gIV4hx6lT0HyrnEwMT++mJW+H79BXNQ=;
 b=mXl+jlSSTCZ3cIzymihQptuOsZg5FJ8TdG+Rbft9UfxZv9g7+K+x8t1xqcFUhTktm9I8SOXSwnx1fKyVphc22fCNa+wB9Lx2SeqgsB3ohuymfalPcfBVKTKEwNoIAVbL3o/C5StX0YLZUDrS+XVDfAjDYKrlldHqC7djspfUqOvpdBQ7ytCn3Rw4GR26WQrahrBXruAAs/XXp/zLo3VJXhofwgOIbxoahcGng5ysWRtEKvSyNLrshNUNiUMPA6NNXHlYxf0sivArTWTqont5PwYYb2y9SDtNrJj8wOmbVLtMEGUIYuJBSv8cw4c4h5jgWRAfMtltfygrODBt5Agpzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com (2603:1096:402:3e::12)
 by OS3PR01MB8842.jpnprd01.prod.outlook.com (2603:1096:604:17f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.20; Thu, 23 May
 2024 00:48:03 +0000
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::14dc:625a:548e:aa7e]) by TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::14dc:625a:548e:aa7e%7]) with mapi id 15.20.7611.016; Thu, 23 May 2024
 00:48:03 +0000
From: "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>
To: 'Dave Martin' <Dave.Martin@arm.com>, "x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: James Morse <james.morse@arm.com>, Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, H Peter Anvin <hpa@zytor.com>, Babu Moger
	<Babu.Moger@amd.com>, "shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, D Scott Phillips OS
	<scott@os.amperecomputing.com>, "carl@os.amperecomputing.com"
	<carl@os.amperecomputing.com>, "lcherian@marvell.com" <lcherian@marvell.com>,
	"bobo.shaobowang@huawei.com" <bobo.shaobowang@huawei.com>,
	"baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>, Peter Newman
	<peternewman@google.com>, "dfustini@baylibre.com" <dfustini@baylibre.com>,
	"amitsinght@marvell.com" <amitsinght@marvell.com>, David Hildenbrand
	<david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>
Subject: RE: [PATCH v2 06/35] x86/resctrl: Export resctrl fs's init function
Thread-Topic: [PATCH v2 06/35] x86/resctrl: Export resctrl fs's init function
Thread-Index: AQHal+vBaOHmm3zrHESHfqJ7mh+G7bGkJONg
Date: Thu, 23 May 2024 00:48:02 +0000
Message-ID:
 <TYAPR01MB6330F32C63F53E2B29B0B91E8BF42@TYAPR01MB6330.jpnprd01.prod.outlook.com>
References: <20240426150537.8094-1-Dave.Martin@arm.com>
 <20240426150904.8854-1-Dave.Martin@arm.com>
 <20240426150904.8854-6-Dave.Martin@arm.com>
In-Reply-To: <20240426150904.8854-6-Dave.Martin@arm.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ActionId=ca4f72b0-5044-4d28-aa33-b51bb15d18da;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=true;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED?;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2024-05-23T00:44:27Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
x-shieldmailcheckerpolicyversion: FJ-ISEC-20181130-VDI-enc
x-shieldmailcheckermailid: 7efdc230662841edb3b39036957a62bc
x-securitypolicycheck: OK by SHieldMailChecker v2.6.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB6330:EE_|OS3PR01MB8842:EE_
x-ms-office365-filtering-correlation-id: 43580b22-a679-4f55-fd90-08dc7ac20073
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|7416005|376005|1800799015|366007|1580799018|38070700009;
x-microsoft-antispam-message-info:
 =?iso-2022-jp?B?TG8wb1JQUk5sMjBrWFN3N3Bmblc5R01BeWpVZ2dUK0tLeUhtSWg1d3FH?=
 =?iso-2022-jp?B?ZE9HWWRvQ3ZuWTI4cHNsQWMxN2IzVmFjRXJtVXZoWEFBaUx0ZHdsMWt5?=
 =?iso-2022-jp?B?enhVSFBTcm5WNEE1dUNXb1NmbXM1cWp0Q1hoMUY2Q0JDT3JITFUybUFp?=
 =?iso-2022-jp?B?eHM4VTY4ZFozRExaVFAvVUJsVGVad3Y3QS9WTWowbHl2MlR6dE44dUY0?=
 =?iso-2022-jp?B?RHVRcGxPenFqZWh0SU02b1NHOVdpaW5MdWVvRWxuQVJiVlpocFFwL3RC?=
 =?iso-2022-jp?B?cnE3WFhlUzRKM3ZYTkVqSDNuVWZPZ0ZOZXJLcWM5cElYS2FNV2Y5VmtM?=
 =?iso-2022-jp?B?c3N4S3NsZDB5K1pSbUJHQjZYK3VzS2NwcU1rQzVqazRMNm1SNkpRbkJN?=
 =?iso-2022-jp?B?aDBwcGdReFRibEc1aXNaTXZpWENzZjdYanZ4MGEvczZmcHlTVnRLN2g4?=
 =?iso-2022-jp?B?Y21MMCsrTGZRdHY5UWg2WStYYzFMMDJCckdmWEM5Q0IzbFYrWjJqditN?=
 =?iso-2022-jp?B?ZVNBZ0VVWWV0THUwQUFVMVZ3aU9rWmhXYWdRVE5iYlZxOUM5azlENUdw?=
 =?iso-2022-jp?B?QkF5a2ZoalNCa2J0VUpYZmd0M3hoRlU0ZFQ3V2N6RUNCanRuM3VnSVpW?=
 =?iso-2022-jp?B?ejJ3bTh0TW5aUmJIZ0praTZac2JNWlBEeDdZenBEN2UvbVhIUW43VzVl?=
 =?iso-2022-jp?B?ZzQzcDBMVE5uc1dDeUhyTklZeGN1YTQrSWpTa3hHeGZSNE83T0Z4blFK?=
 =?iso-2022-jp?B?dXFUYk05L2Rzb0syOXN5OHVhK2wxSjdWTnA3aUNZQ05DUk51NWNxOTkr?=
 =?iso-2022-jp?B?Um5DOGpPVnRxeG9uT0dxeVdsNmVNWEVrYnlBQm1oak9ETm5oQnV5bDQz?=
 =?iso-2022-jp?B?QnpaVml1SWFuT3RacEF5RitWVENDNGFBNmJleGsrcFpOTThoRU43Ynk1?=
 =?iso-2022-jp?B?TXVHekgxUi8xUUxSSlg3VVRiVVpHMkxZV2ZnRzBxd1daU1QzSjZZL0M3?=
 =?iso-2022-jp?B?RmhZQU9hcCtEdVpCUnRqL0JPRi9aYXNCM2lWb1orWDRZcytSV2JBK0Qy?=
 =?iso-2022-jp?B?N1h5WXpVSUVzc2xkeG8zblJCbS9sckJianlhUkpHMjY3YmNHcjB0QzBJ?=
 =?iso-2022-jp?B?UXdHTWJYeG9iZVdqbjdJZnQ5ZnBrMEIvWXRPTGRRdHc5dkNOQ0pzMHc3?=
 =?iso-2022-jp?B?QUFhZE1mWG45dzRsemsrMG9WSWs3UmF4VUs3TzZkYStTNmZyWjhkUVpi?=
 =?iso-2022-jp?B?em5Cemk4YWVxbFhyTGE0WGlFeUR0RXliZFVFUEgvQ0NUNjZIQURBVDJK?=
 =?iso-2022-jp?B?bnBMRzVBKzJOdEdBUEp6M3pPVGRrczhhdkkwVjdPbkFBREVMOEpEUmox?=
 =?iso-2022-jp?B?bVBEcEFmNk9RalJ6WTdFUUcxVHZJZEQ3QWR4UkZ6Z3kwc2pkWWQzdHRv?=
 =?iso-2022-jp?B?ZUl6bEIxbjhiOXlyWXlSd0dIZmRFdDB2OUFhdXFQejl1dEVEQzQ1Y29V?=
 =?iso-2022-jp?B?aEgzTGRRanhvN1dKaXZWb3JkS0d0d1ovQnZLNnBqSTBRVUU0a244YzJ5?=
 =?iso-2022-jp?B?MFFVRmNhTk5mQmUwRzArOWJzRktFYUc1dHFyZzRTdUlOcy8yMDJUVzFu?=
 =?iso-2022-jp?B?cWl1Rnh0MFRkZjlQR3pReWg4UmFjVjVmcE9Mam80aHF5UVJWTWJYOWpM?=
 =?iso-2022-jp?B?MkdHcldOMjg1MTBWeTBROHMrYVJGZHptTUV3QktOcEpheWVKTnRaSjZJ?=
 =?iso-2022-jp?B?aklvSXBTT3FHT2U3WEgrcXNKZ1JtRWxnMFZwZmxDUWNPeDB6Szd1M2Vk?=
 =?iso-2022-jp?B?K01udWdZQzZPM1AxRG9pdy8zcTk3WVQ2ZGRTZ3J1aldTUlJuY20vMGFn?=
 =?iso-2022-jp?B?bjlQSHJDRGZ6eW4yUGFQNEZiaEdSeXpMUjN4R0RPOVMwN1dlSVVJNXNI?=
 =?iso-2022-jp?B?SUJnVU9iV1B0OWFEeTlRRGpoTkcrOXVGcUtRUmJNclh1QVJWUzNaVDk1?=
 =?iso-2022-jp?B?MD0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6330.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007)(1580799018)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?SHdvSURRZGM0cWNxREVUa0VLWkFaSndWcGlFWmtUUnM2NUxaNWJkWE0w?=
 =?iso-2022-jp?B?WklncURWOGRLRlJjR1AxbFJzam0rZjZKSkR3dW16R25sNTNGTGszQ3Fr?=
 =?iso-2022-jp?B?SGFpSHhqK3ZjWHQ3QXpNU1k3eWE5VHlpRlcvTDRKMS9BbndHK0txMkxR?=
 =?iso-2022-jp?B?cGZJQWp1ZTJYYXUxay80OUxjQkpsTXgvSTM0TzMzd0t0NzV1WDZoUHNm?=
 =?iso-2022-jp?B?dDJScjVXemVJVUluQ3FMRVU1MndqNXBjZGhXTVdZV1RvYk5pTTRIZEYz?=
 =?iso-2022-jp?B?M2Y4ZlBxWDNFVG84Ym1jNms3RDc2SkVlM0xJamRQend4ZkRsTEs2NHF4?=
 =?iso-2022-jp?B?dm5iN1dyYWtIbXFPUzNYUUpNTVRKdEN2bVZaUFZIWXRPYzQrWURvWnh5?=
 =?iso-2022-jp?B?dWVRRkQyZDBYYmtZaDlpZzhGTklsUXZCTytRNG82c3A0VXpnMWxoelNW?=
 =?iso-2022-jp?B?M1pxZFBHMFBJRms2VVgwSzJPdjVETHhEdVB6UTVySmtkTm95OUZBdyts?=
 =?iso-2022-jp?B?YXdhUitGQ2N2MUZkRGlqQk15V1BqMjc0SnpWTVROTzNrLzByU3ZSS2pl?=
 =?iso-2022-jp?B?RHYybTNTL29seXlTcVE5NHdFM1BCeTNab05KZUd3WnpuQzYrQ3Y5QSsx?=
 =?iso-2022-jp?B?TzlTL1RMR3B5RWFTTEYrK3FDenF5N2wvTWtxR29FY3pwR3k2a3Zudi9H?=
 =?iso-2022-jp?B?NWVXWEp4NWVtVU1OM29Na3lZOEpQWk11SGFqaHVsVjZ0QUhXa1FGOElQ?=
 =?iso-2022-jp?B?NVp5b3huYmR2ZTNMcHZUbmtEd0I0SEJnMGlUUUw4bVVTbzM3UXc1c0tQ?=
 =?iso-2022-jp?B?cDdpNXg2NGhJcmI4NDdvQ0pHNTlJeTJpS2U1TkdBMFl2WUd5R3VkRGpi?=
 =?iso-2022-jp?B?OCtqdko2Yk12RDJHdXhMby9obzU1OUUyZUR6UDE5TmljZFpndVBsUFNI?=
 =?iso-2022-jp?B?OWNzTDhHZTdUMSszQ1ZGT05yeW5pVFhudTZ3VHBZa2ZuWVUxNHlnTitT?=
 =?iso-2022-jp?B?WGpxT1JSM3BpUTdrVHVReE1nNzlzQWpzMFMzTUNKQU45YzNMZVNCUitz?=
 =?iso-2022-jp?B?VDRIcGhHUGJ3dVhhSXNtU1lnTGRxMFp5ODFaeEZBemxlZE5vL3VmQXlP?=
 =?iso-2022-jp?B?U2hCZEkzMlZUSXpUMWROVVd5V3Nwb2Zqdys4d0NjdW9pTUpIZk9uWTNB?=
 =?iso-2022-jp?B?ZWhPTnFTamJuVjVkQ0ovYnduZXRzMXNqQXFUM2Z6THRzL1BCRTBtUkdP?=
 =?iso-2022-jp?B?d254U2s4WkRrZnpMeHpGalIwRHN0bmRDQzIzSjg2dEI3Wm8yRkticXR1?=
 =?iso-2022-jp?B?SDBWckxlU0I1VXFUT1J6QWdwM3R0bDlicVc0NXdOVFphN2NiOHZmK1BK?=
 =?iso-2022-jp?B?cVZXNXBmVHNBODdkeGFKUW1qUVV0TlYzWERnTkkrWjBZeG1HY1VGaHNN?=
 =?iso-2022-jp?B?dkErcGMvM3p1WllWTUx2Q3NkWDBnY1ZNRnBwRGdnNzBTTGVUNEtWNjJk?=
 =?iso-2022-jp?B?L2xHcmlENExNRmFCKzQ4ZmJqWUcxUkdvelExUVBsUmo3RFRjVU1HS2Ex?=
 =?iso-2022-jp?B?UW9icytIVnRMYVNZV2YwOGlxU1g5TytlZzU5QTdBTzUyZm1QQnJYLy9x?=
 =?iso-2022-jp?B?OTRsV2NvRXVTb0ZyTUQvT3dKNnk3VUtHZm92TUVVejBDRkhhYjVCVVlV?=
 =?iso-2022-jp?B?akQrWUYrbTlERHJCN2JvR3VOdDRNVkZYbEdveDFqck1oQnB2UFJFWmh0?=
 =?iso-2022-jp?B?QWRNWit3WGtWRWNTRTJNenVRMkhuTTFlblBNTC9oRmpLb1YvekZzR3FI?=
 =?iso-2022-jp?B?ZHpZbTNkNXVBUDdKOHFqTG40SVVWT3VYQTlUUkNvRC9xQjE3U2RmZzF4?=
 =?iso-2022-jp?B?UDhuLzRGa0JiVWhEbTJtWU9lZThYMkFhK3d2dzB5cDE4MFltU3l6R3pn?=
 =?iso-2022-jp?B?VjdqZXh6NGhOOUxKbWJ0RnhhR3BlRExKeW9WN0xwTDFhSTFqRVh3dW1C?=
 =?iso-2022-jp?B?U0svNnNqa1RkdEY0ZzRjUlE2bUx5MElIQXlERzZjUVd4VUVwLzlPZFNC?=
 =?iso-2022-jp?B?L05GWlMrblZuRWh3b1pIUUNCcjlOWlhVdU1vcXdkcWU4QUhjMjZVNC9o?=
 =?iso-2022-jp?B?SU1pcFJjWW9hY2ZMR0ZiRDJYa09TdUFyakZSZ3V5SzRRYkxyY29uUVFs?=
 =?iso-2022-jp?B?bXl1dWMxc2ZMYjFtQ1ZNSjJVVm1haFE4TERWWnIxMUJxNHh2YXNmWE5H?=
 =?iso-2022-jp?B?NEJjeE5YL3dlZUE4T2FtcE9xOGNEYWRPL0hSZ3JCS3h2R0p0eHpZR2s3?=
 =?iso-2022-jp?B?ZW1tM3p5UVBpTC9mQUNWZkMxS1dJL3YvTmc9PQ==?=
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
	JSjnvAtEZ0cPJ0Ax0n9SKi9S5EER0aFHMI2KVHcy5grsWYcdC5iYfSH4bZZrfRLbukJM5osTqOIM9U0Ykf4zG1xG/YPw9/CIYuR/3SR2tmBXIeFbkf8oD5KQCuzYH5B77d0bcqH5/rRi/XiZByy+gBbb6jonbXrwl2bd2X3UOcM3pb991IvYtvBZOjLMe1asF+e8+wdkDJalw6HJ4RN7pESl/dQ3fN4IthG3FJoF/BajEchIbSpvVKf9lTIHTbYLPLT1D4gecw1nYSoKmQztjq0e4ZQUm53ckfiWcNDDpIaMRJBBixFjGF6DzimAJsExlKm43SytPZ+8j4jujOR8MRFtnJifcL1UzQ9a7bQP7Fs7ePLgzq3hB8Y5RoPKhTpJCDfWMGVhj6ZK+MONM9muhXpNvBb7C3NOHadbYAZ65iuQ/evh4AcrLhRvJXa0HAgn/4g6+ZbJa8A7QM+/Zy3qhf6BFJOVEyYMAj6sbSSZDKvWBfbW2tGQPhN9Vro4TePlyCnpVqdjaTgm0qqMneEBB0y+YMclXNyj6ckdVfvcbduFnLuvR7O/MbwTunnkmeZfb819phNFcbVdciVWst/Ooo4M3zLN+rm1xV21n+dGOF8bIVO2vOABRvr6VU/dO8Yf
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6330.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43580b22-a679-4f55-fd90-08dc7ac20073
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2024 00:48:02.9502
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s/dpZ5krBhxtBjuXTD+7vVQhwoOkJncqPeztWT14udKPW9bJSSWJE6iwqT/q4H+MEaUhI+Rf9CBrvf+72KzJf7pQqPV8ZxXa+EAKE59or9c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8842

Hello Dave, James

I think there is no problem.
Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>


> From: James Morse <james.morse@arm.com>
>=20
> rdtgroup_init() needs exporting so that arch code can call it once it liv=
es in core
> code. As this is one of the few functions exported, rename it to have "re=
sctrl" in
> the name. The same goes for the exit call.
>=20
> x86's arch code init functions for RDT are renamed to have an arch prefix=
 to
> make it clear these are part of the architecture code.
>=20
> Signed-off-by: James Morse <james.morse@arm.com>
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
>=20
> ---
>=20
> Changes in v2:
>=20
>  * Rename stale rdtgroup_init() to resctrl_init() in
>    arch/x86/kernel/cpu/resctrl/monitor.c comments.
>=20
>    No functional change.
>=20
>  * [Commit message only] Minor rewording to avoid "impersonating code".
>=20
>  * [Commit message only] Typo fix:
>    s/to have the resctrl/to have resctrl/ in commit message.
> ---
>  arch/x86/kernel/cpu/resctrl/core.c     | 12 ++++++------
>  arch/x86/kernel/cpu/resctrl/internal.h |  3 ---
> arch/x86/kernel/cpu/resctrl/monitor.c  |  2 +-
> arch/x86/kernel/cpu/resctrl/rdtgroup.c |  8 ++++----
>  include/linux/resctrl.h                |  3 +++
>  5 files changed, 14 insertions(+), 14 deletions(-)
>=20
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c
> b/arch/x86/kernel/cpu/resctrl/core.c
> index d07eff7d6750..b4e7d655e242 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -938,7 +938,7 @@ void resctrl_cpu_detect(struct cpuinfo_x86 *c)
>  	}
>  }
>=20
> -static int __init resctrl_late_init(void)
> +static int __init resctrl_arch_late_init(void)
>  {
>  	struct rdt_resource *r;
>  	int state, ret;
> @@ -963,7 +963,7 @@ static int __init resctrl_late_init(void)
>  	if (state < 0)
>  		return state;
>=20
> -	ret =3D rdtgroup_init();
> +	ret =3D resctrl_init();
>  	if (ret) {
>  		cpuhp_remove_state(state);
>  		return ret;
> @@ -979,18 +979,18 @@ static int __init resctrl_late_init(void)
>  	return 0;
>  }
>=20
> -late_initcall(resctrl_late_init);
> +late_initcall(resctrl_arch_late_init);
>=20
> -static void __exit resctrl_exit(void)
> +static void __exit resctrl_arch_exit(void)
>  {
>  	struct rdt_resource *r =3D
> &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
>=20
>  	cpuhp_remove_state(rdt_online);
>=20
> -	rdtgroup_exit();
> +	resctrl_exit();
>=20
>  	if (r->mon_capable)
>  		rdt_put_mon_l3_config();
>  }
>=20
> -__exitcall(resctrl_exit);
> +__exitcall(resctrl_arch_exit);
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h
> b/arch/x86/kernel/cpu/resctrl/internal.h
> index 9048bd32e86f..7c073298aabf 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -300,9 +300,6 @@ extern struct list_head rdt_all_groups;
>=20
>  extern int max_name_width, max_data_width;
>=20
> -int __init rdtgroup_init(void);
> -void __exit rdtgroup_exit(void);
> -
>  /**
>   * struct rftype - describe each file in the resctrl file system
>   * @name:	File name
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c
> b/arch/x86/kernel/cpu/resctrl/monitor.c
> index 06565153ceb2..9f2fafcf78f1 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -941,7 +941,7 @@ static int dom_data_init(struct rdt_resource *r)
>  	/*
>  	 * RESCTRL_RESERVED_CLOSID and RESCTRL_RESERVED_RMID
> are special and
>  	 * are always allocated. These are used for the rdtgroup_default
> -	 * control group, which will be setup later in rdtgroup_init().
> +	 * control group, which will be setup later in resctrl_init().
>  	 */
>  	idx =3D resctrl_arch_rmid_idx_encode(RESCTRL_RESERVED_CLOSID,
>  					   RESCTRL_RESERVED_RMID);
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 871b59c2c886..997f31ee5de4 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -4118,14 +4118,14 @@ void resctrl_offline_cpu(unsigned int cpu)  }
>=20
>  /*
> - * rdtgroup_init - rdtgroup initialization
> + * resctrl_init - resctrl filesystem initialization
>   *
>   * Setup resctrl file system including set up root, create mount point,
> - * register rdtgroup filesystem, and initialize files under root directo=
ry.
> + * register resctrl filesystem, and initialize files under root director=
y.
>   *
>   * Return: 0 on success or -errno
>   */
> -int __init rdtgroup_init(void)
> +int __init resctrl_init(void)
>  {
>  	int ret =3D 0;
>=20
> @@ -4173,7 +4173,7 @@ int __init rdtgroup_init(void)
>  	return ret;
>  }
>=20
> -void __exit rdtgroup_exit(void)
> +void __exit resctrl_exit(void)
>  {
>  	debugfs_remove_recursive(debugfs_resctrl);
>  	unregister_filesystem(&rdt_fs_type);
> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h index
> bf736ec22f71..de0297f6167a 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -336,4 +336,7 @@ void resctrl_arch_reset_rmid_all(struct rdt_resource =
*r,
> struct rdt_domain *d);  extern unsigned int resctrl_rmid_realloc_threshol=
d;
> extern unsigned int resctrl_rmid_realloc_limit;
>=20
> +int __init resctrl_init(void);
> +void __exit resctrl_exit(void);
> +
>  #endif /* _RESCTRL_H */
> --
> 2.34.1


