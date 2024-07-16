Return-Path: <linux-kernel+bounces-254028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43FDE932A78
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 17:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BCF2B2316C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 15:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66D31DFDE;
	Tue, 16 Jul 2024 15:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="eIqD6Im6"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBAACA40
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 15:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721144054; cv=fail; b=KMD16HMufzMyJJ538rdlDFqLdUPyTVkQiVTx7iiq61ei9ORL3dcNZLBcCrmfHayq/oFW0nPJ8iS5IjQUf+6FewFu1G0X1ApEh8LfUkguLyN9tltclS0hdalWp+pD5Kr7i5qrTvVTZ5Q3IuuqltnAf1ioEBUWBbnqLH4tpYYMYk4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721144054; c=relaxed/simple;
	bh=H7bBCQba5hdbX2AeTivs7MipegcO1qQTr3H/XaeXuv4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=RkJWhS7aERPJxV7OQkpoc7NSzLx/kuQxpFb26I+xoDD2XiDzIezJRQhrcS6Row2+rId5zp8cgvUdgLd7sc0ssjVv8cpu2JTga/HEz+vKiCdMEGYDQqHpZnZRaLF3WPxyAlBYUlkgzpUEzWfUVPY2LPxdD662Ju6c5SsSV1jbtgU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=fail (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=eIqD6Im6 reason="signature verification failed"; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46G8G1Cl020182;
	Tue, 16 Jul 2024 08:33:53 -0700
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 40dn6y9ex7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jul 2024 08:33:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QIdyjbj4GvxNHHaOmtVcdzfrdxzWM7gArzrdwalQYb/9A6+7DFqpRjQYCJKrZuzF6XvsPsmVj+cjDVvDRYd6JIyOJojMJ9n947aGg6jmVr5d0KQxOL1V+20+Pn12rLMzIXqFkKYaNlu1XUNSUGhv9kQf013/NP9pyiXiAQBEmg9QpZj/YBqZU9GnFnko8ygb9WwpV9JYresqCIxQWe3oK/K38KIJ8rvO2Osulvx46t3FHOwmNPrbl+rNND/Ka9zcWj5qRAv4p3jhw5NZd98O7W7z3jv+UYNpEMNwOdczCl8mYAWRo4CTV2zNbvjfQ2PEaruCK0GxfGRvCL1ECZA7NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fGdI7YDCLJh7Iv365BHPD6A1jJWg0KO68vzfae3DxO0=;
 b=HQ9nVtZetmS7KRy4qYxSId/cOGiQNnaPVLvN0jJgBqFsn6hJ/g7SuVUxgKNKN2yKfmyGUPlga7Sbpf/G6siFOEidiMwQ6d2CWyGDGSv5sMnqR0lfPj7FeZVH8ENQ01PBdCT4Sc184NVPL8FjkSsNjb6FkmliIk26eH0HmCKvVsQt34nxJJPSPHVdFRpp23PdSLgKHRPNY4lC57xG61RLK45nFH/XCodjBp6cPZiDjxZJglwbVTJSBGsPZhntpscnQDmsB02N2MhnJAjizN6n7TSgwSLAAo703jlthXWiLmZu3EqKPaZ+qVP9D0j0MEg0HXx5Bsh5LvQ+dINQJ5s/zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fGdI7YDCLJh7Iv365BHPD6A1jJWg0KO68vzfae3DxO0=;
 b=eIqD6Im6rfALwMYAWv6LKDAhKaSCHAW1ygtZ40hqWLCBJrNDWbvZUQcd6q/tBiTIaqvK7qFP4SFfvoWEie+NIzpCnPHe6tXtcOCCCi+Ig8M1jzIwvm2mylRgxAo/H0EnlbhSxa3Za8EmtbfA5hp4bQ8CRAC62LtkNwbOUA5AacI=
Received: from MW4PR18MB5244.namprd18.prod.outlook.com (2603:10b6:303:1e0::16)
 by IA3PR18MB6381.namprd18.prod.outlook.com (2603:10b6:208:532::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Tue, 16 Jul
 2024 15:33:49 +0000
Received: from MW4PR18MB5244.namprd18.prod.outlook.com
 ([fe80::52f3:9792:ee42:90b]) by MW4PR18MB5244.namprd18.prod.outlook.com
 ([fe80::52f3:9792:ee42:90b%3]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 15:33:49 +0000
From: Vamsi Krishna Attunuru <vattunuru@marvell.com>
To: Arnd Bergmann <arnd@arndb.de>, Nathan Chancellor <nathan@kernel.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH] misc: Kconfig: add a new dependency for
 MARVELL_CN10K_DPI
Thread-Topic: [EXTERNAL] Re: [PATCH] misc: Kconfig: add a new dependency for
 MARVELL_CN10K_DPI
Thread-Index: AQHa04oXt5mMdFhNZEuhWZ7W7UjoL7H5YFSAgAAHAgCAABkkMA==
Date: Tue, 16 Jul 2024 15:33:49 +0000
Message-ID: 
 <MW4PR18MB5244F75E2D16051A5B838FF5A6A22@MW4PR18MB5244.namprd18.prod.outlook.com>
References: <20240711120115.4069401-1-vattunuru@marvell.com>
 <20240716132603.GA3136577@thelio-3990X>
 <83ac6b91-c7f1-4b18-a522-8188d6d1298b@app.fastmail.com>
In-Reply-To: <83ac6b91-c7f1-4b18-a522-8188d6d1298b@app.fastmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR18MB5244:EE_|IA3PR18MB6381:EE_
x-ms-office365-filtering-correlation-id: 2728205c-38de-4c52-0a02-08dca5acb054
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?czY4TTVkb0VyNUJ6WmdmRnk1VFVCQnhXQjIzaVJzMloxd3hJN3FIQzRmY1p6?=
 =?utf-8?B?M09uU0ZxRFFYVU0xa2h2anFJTlNUb0JzNHZMU3h3Y1o5SnZIV0hMdTBJd1U4?=
 =?utf-8?B?Z0poUmRtOXJodXdSQU1JeG1qYnM0THYyZjg1ZW00ZzJ1Wm1NeE40K2JWM0Vo?=
 =?utf-8?B?NHdwRnE4RHRhanR1QUF0elcxdHVKdSsyWXZyWnEva3FueHZ5ZnZiTlROdXpr?=
 =?utf-8?B?WW52Rko0NEdDc1JKU3hWdzZPWGh0ZWZzaXlIaUF0eEpnNHhtbUora2djNHR4?=
 =?utf-8?B?emt0ZFJDZnZVNG5qaTJKYW5pcWVGeFpWTm8zc3RlZnVpTFRTVXZSd216Y3d3?=
 =?utf-8?B?YVZtdXlUczNsdURjK3lGM3Q5Z0R1MjlkeG83bzNZSHpFL25qTjdya2M2N3dx?=
 =?utf-8?B?elRtcS9md2R4WnE1bE1IS05FMEJ3WXJDSFNCZU5pdFNEVGx6SzBXN1ZqNWxp?=
 =?utf-8?B?WkwzNG11bUJCOFNIbHpPRm54NmhJVjJsdVg5d1Rvb0NqSXFMb01QN0xXRjJO?=
 =?utf-8?B?MWJ5Tk1IYjlmMXpvN0k3NHRGZlI2cnhSK0tPRFRwVXM0b3hjNi82WDdRb0lL?=
 =?utf-8?B?VjJ1VFdvZjVzUHVzR2VvbmxVd2s3Zk9tWFpSUXdncm5qeitmRndDQW5scEFO?=
 =?utf-8?B?cUUvZWo0UFd4cWZpMW43d0lid3lUYVV6SmpuQTQrK29JQnZ6NExsNUJQcTJr?=
 =?utf-8?B?aG1WSm83U0doeEEwSUkyWUNPY25tZ2JRR2lCY3g5QlNyT2lDbHgzajFneCt5?=
 =?utf-8?B?WkUxTzFkZThTMVByb0I0U0FqR2kzTGxrRUtab1J3Q3l0OStyamtqYTlXSUJS?=
 =?utf-8?B?OVh4b3BpWmZiUEtlZmgwcEg3djUrdUdEWnU3WEpSZGx4NHMrVHJBa1RHOHJG?=
 =?utf-8?B?WSs4ai84V0NqU3A1dTFZMHhXYW14eUlHT2NyRDg5bm1jYUF3Nk9xV0gzdVhy?=
 =?utf-8?B?bHE1RkFVVlFRb2N2WlJkSm1xUC9pbjQyWHdvTE1sQ3Rveno2dWRpbW12RVlh?=
 =?utf-8?B?Y09adEorL01uLzduTno4Yi9INXplcUszN0piVUJUZlc4Qk51Q0QvL1lURlRa?=
 =?utf-8?B?UmZLOHlBZG1RZWlKRktVY08zUStYRVJUcEdrOVpkNGtqVnNYZnA2SnNsalFx?=
 =?utf-8?B?VnB5bStxSjFzemZ4VzNyQWFrWG5ENElkTldFY1ZlYWdmL2xrSmgrRW45VWJX?=
 =?utf-8?B?R2s3N1BZSTRXWlpEQnErS0IxWHF6Tys0MjloZllVeWFrRE9mWm52N3VkUkFP?=
 =?utf-8?B?dGdvcCtLRlJFcjNPQzE4dnRRRDRHVkZJUzJweERDS1FwUmlZTE9uSUpKOUVQ?=
 =?utf-8?B?UTdLb1JRYmNmNE5FZXE5V1AwdmJFT3FPcEw1Y0htRVpVb1JTNFRiOTFGQjJE?=
 =?utf-8?B?b0hxaWVlbEY1clQ5cFdaQ0owYlNaVGV2ajZ3d21IQmhmWlNlUnhvQTMza2N0?=
 =?utf-8?B?THA2OHZJd2RmT01JK1R5Mk5kL1dkK0RkWk5KVk9admxObERsMFprYzFqbXpJ?=
 =?utf-8?B?RW9zT2FUczVMdldtWktYalZyWFJMbS8zZ0NWNDZmb09PNlFOdGp2UWhvZlY2?=
 =?utf-8?B?YlROK1NCYUZPclY3cDY2TDhKQkVCQlpIWUcwYjNLWG9ET0pQTUVydCtWODhj?=
 =?utf-8?B?UXpIcWNuTkp4M1ZUN0xBZkNDaVA5UHlNY05aeEpjeWdHdW44YXg5aWdVS24v?=
 =?utf-8?B?bjdMeFlJdnhqcW9UdlNFcWtRcENZN2FqK1BXQnBWM3cxaHI0SnlrY1VzdmUr?=
 =?utf-8?B?eWJDTXFRNXM1aXpJeERIU3l3ampWU00zZXp5VVMyUC9jTWsxUGEyaGJJUm9x?=
 =?utf-8?B?WUdFaFdHaDZkMnEybVUwc1hCL20ra2M4b050TmVuY0oxakZBRWd3b09MbElD?=
 =?utf-8?B?QTN6ZlV3K0VKZUJHcFNnN3NFWmRDV3F4K3huVEplTFcxTFE9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR18MB5244.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?NE5sRytOdTBocWFiQ0plQU1BWkVCLzNEWkRZbmQraHY1bFZyVXBzUnNEZVhL?=
 =?utf-8?B?OEtkbmZVY2daSGVRSG8zd1dpNUtSbDVvT0k5RGRzb082WHAwRHJrTkRYaU51?=
 =?utf-8?B?MVczUVpkR3laT3BRd1dmczVZYXliNDFnS1ZDNjJMY2Jia1FuQjh5aHJIaEJB?=
 =?utf-8?B?VHRhRldneW5RT3NhSjlmcFZVeXJYMEVuZEhrWkJqVXlxUlRzTjNxOWtZWnV4?=
 =?utf-8?B?WDNHdFpDZ1ZUNWxPeFh3dGpSRXZWb1luNjBJbzRrRkcySWdjQW5MdCtGRE9s?=
 =?utf-8?B?MjVEWU1YWXNlRWtFbUhuWGc3QXo4U3FPaEEwQ3lLV0dSdFF0c3lyakNEUFJu?=
 =?utf-8?B?Vm9YbE1RNVNPa0s1VTBweC8wR0ZmVkVpVjAyTHA4Vld3UGpiZW5YejZVejBh?=
 =?utf-8?B?am1jQkJzODNJQjQrZy9tZ1dSWkRXOWNXVHd4MlZyOElLZFBLZFRhdkpJbWVn?=
 =?utf-8?B?MFRWZnRvdSthT05UcStrcHBzK09qL3I1OGNaOGZyU0o1cFlMdVdxVE14UHgx?=
 =?utf-8?B?b0xKQVhTMUpjSWE1aFlGRG45cGRxNThGZDNOcEIyamgwSXpyQ1lHQkR6alN2?=
 =?utf-8?B?cWdXRk0vejBHcmdtYlBXUm5PTXNyWkJ4ald3TWt5OVR3cVlRaWtta2w0NHpx?=
 =?utf-8?B?cVJ1TFptQmtGV1VKWlNiNldPN08vTmxpUUcrTE00N3Z5blVlemtLQmEzVnVX?=
 =?utf-8?B?TXNWS3NyM2J2c2tmL1M5Slp5ZUZjYkpldlRpYVlyc1BsVmlXNk93c1VmblNl?=
 =?utf-8?B?WWM5Um52ZkhiK3Uyb042QzFJUVJKQTd6Q0d6UVNsaU9OZlpsWXZjSEJ6REg0?=
 =?utf-8?B?R1JZaU1EbTk3d2ZUWGNOT25JWUlQZlRWcXNUWk93cGFZOWh2bmttMFVieEJT?=
 =?utf-8?B?bjUrZ2wrYXVmR0lIY2QyMFJRN1ZMVG5aano4YXU1NGRDSU1idXBpTzJGbzk5?=
 =?utf-8?B?NWRPWkUzaDJiK3VXUzQ5RDcvaFRvSllEODJlTW1ReENTZ3BUc3lhazMxSzFL?=
 =?utf-8?B?U0U3c0dzZE9uQXpxOEtjMzJkbVpqazRRNnlpam5Ca1o0dVVKY0NZd040c2Jl?=
 =?utf-8?B?cGJ5bDFZWmxqSmFZdHVLOGdNcmk5NnMzTGo3M1Fsa3NGbmpMUkh5K005NEJw?=
 =?utf-8?B?L0hCRndST1VvSWp6S1RqcWxYM1RsaFpxMGFVMVcraytQOXJJYnUydjNPZitI?=
 =?utf-8?B?a3pQakRKRm1idkluVUNvRnZ3OVEwMFFDRnJjYXpkQjZsWnNoQXZCdjJFdnFi?=
 =?utf-8?B?MHV1Q0s5Q1NDUTdGaHR1YVF5cmc5SW4xZTZJWnZLc2hVRXU3V1hQamZTdXZ5?=
 =?utf-8?B?WlBFNzlkdVhyRlFnbGt2Y0R0RFh3eEJjblphbUhkTXg4MXQ0UE5QRlFXcVdY?=
 =?utf-8?B?Znd4Y3J1ODZ3aGd5dmw2bjVMVFU4REtNUnJMRDVPSW1BMkcxUVpOSi9qMTYz?=
 =?utf-8?B?WG4rbjl6cmY2QkxaQXFRUHF5Y3pUZlpOOEU0OGp1Y3lUN3Z2Zzl2aldSajhC?=
 =?utf-8?B?alV5MzhOOC80MWVNR3BBclo1R0xhS3U1Rk5HN25vOW5lR3Z0UDhrWkxyWWZH?=
 =?utf-8?B?V3VkM0xWbkVJMVlEajFoaVBYd0RYUElTYUlMVU0xeXlOaVpGWUhjQXZIMVMy?=
 =?utf-8?B?S0VxcmRvemtyMUZUbldxdVRmOHgvSjBTQzdZUk96a2FVa3Bpbm4xVHQrRVdE?=
 =?utf-8?B?SnE0SHBUbnBVTnJFRnd0Y3llYjBXRnJReWQrRGpjN01jQlIwa1JrU1RjR1Vy?=
 =?utf-8?B?OTFpMDViSWN6UW9ocnBlNGNTb1crcngzTnBaYkkyc0NEZXhXSE95RUhvdmRt?=
 =?utf-8?B?V1l0K2FvcjlwQVBZb2pQajVSYnM2bTkvbTkzaHJ0ZFhMc0J5QmthMG5zYTRB?=
 =?utf-8?B?ZEtMeTh1M01Ub2YvUHVXZ2hPTEl3Y09tS3B6UU0wdmhuNEZ6SFZkV1JNdEJo?=
 =?utf-8?B?eFJ5Qlh4NmNZU3kxQ0ZvbG1lam5NaTY3M21CM3lCMUNGQUdzRGd1TUlTNW5W?=
 =?utf-8?B?bS9UY2l1WFdQbUpmNGN0ZkZKWlYvc3NVei92N2x5ckFVYlpBd1BmRTREWFBT?=
 =?utf-8?B?TG42SjBCRjRqYVd6S2pHRUorSnlRdENZQVFocFpZT3A4Slc3QmlueTRsS01W?=
 =?utf-8?Q?TGJVtIJ8GTRCyMiaqgJpcivy3?=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR18MB5244.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2728205c-38de-4c52-0a02-08dca5acb054
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2024 15:33:49.0830
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bNdJSbdir4x/LJLsdBdIhU6C7Y3nNIYOa0hLsKS4NUfz+hirl15wqZY5ralSWttNiYp2hzWpYMtkn5mum/uSaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR18MB6381
X-Proofpoint-GUID: oUdNtOsDQafU1N30YuPSwFqHmJZzJFbH
X-Proofpoint-ORIG-GUID: oUdNtOsDQafU1N30YuPSwFqHmJZzJFbH
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-15_19,2024-07-16_02,2024-05-17_01



>-----Original Message-----
>From: Arnd Bergmann <arnd@arndb.de>
>Sent: Tuesday, July 16, 2024 7:21 PM
>To: Nathan Chancellor <nathan@kernel.org>; Vamsi Krishna Attunuru
><vattunuru@marvell.com>
>Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; linux-
>kernel@vger.kernel.org
>Subject: [EXTERNAL] Re: [PATCH] misc: Kconfig: add a new dependency for
>MARVELL_CN10K_DPI
>
>On Tue, Jul 16, 2024, at 15:=E2=80=8A26, Nathan Chancellor wrote: > On Thu=
, Jul 11, 2024
>at 05:=E2=80=8A01:=E2=80=8A15AM -0700, Vamsi Attunuru wrote: >> > > After =
this change,
>ARCH=3Darm allmodconfig fails with: > > drivers/misc/mrvl_cn10k_dpi.=E2=80=
=8Ac: In
>
>On Tue, Jul 16, 2024, at 15:26, Nathan Chancellor wrote:
>> On Thu, Jul 11, 2024 at 05:01:15AM -0700, Vamsi Attunuru wrote:
>>>
>>
>> After this change, ARCH=3Darm allmodconfig fails with:
>>
>>   drivers/misc/mrvl_cn10k_dpi.c: In function 'dpi_reg_write':
>>   drivers/misc/mrvl_cn10k_dpi.c:190:9: error: implicit declaration of
>> function 'writeq'; did you mean 'writeb'?
>> [-Wimplicit-function-declaration]
>>     190 |         writeq(val, dpi->reg_base + offset);
>>         |         ^~~~~~
>>         |         writeb
>>   drivers/misc/mrvl_cn10k_dpi.c: In function 'dpi_reg_read':
>>   drivers/misc/mrvl_cn10k_dpi.c:195:16: error: implicit declaration of
>> function 'readq'; did you mean 'readb'?
>> [-Wimplicit-function-declaration]
>>     195 |         return readq(dpi->reg_base + offset);
>>         |                ^~~~~
>>         |                readb
>>
>> Including one of the io-64-nonatomic headers would resolve this but I
>> am not sure which one would be appropriate (or perhaps the dependency
>> should be tightened to requiring 64BIT, as some other drivers have
>> done).
>
>Right, a dependency on 64BIT makes sense here. The alternative is to inclu=
de
>linux/io-64-nonatomic-hi-lo.h or linux/io-64-nonatomic-lo-hi.h in order to
>have a replacement readq/writeq implementation that works on 32-bit
>architectures. However, doing this requires understanding whether what the
>side-effects of accessing the 64-bit registers are and whether they require
>writing the upper or lower half of the register last.
>

Yes Arnd, I am checking the functionality using lo-hi calls that you sugges=
ted.
If it has any implications, I will fix it with the 64BIT dependency.

Thanks, Nathan, for reaching out. Could you please advise on the branch whe=
re
I should implement the fix.



>     Arnd

