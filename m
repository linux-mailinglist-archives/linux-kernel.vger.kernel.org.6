Return-Path: <linux-kernel+bounces-256743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A1009352EA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 23:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4085281FCC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 21:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8917F145A1F;
	Thu, 18 Jul 2024 21:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qpECDzbQ"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2086.outbound.protection.outlook.com [40.107.96.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8055E1EA8F;
	Thu, 18 Jul 2024 21:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721337080; cv=fail; b=R6r39I9PaswNMISsaJoaHK614GDiiENkOiOP9JfvRFXB9NBrf9A0VoVyvOvNmjzuwZRKyGgQh6Vehb9mX1AwUSlKRiE+/vwt7Cba1DYXyp2HLiPwCbu0FKg/R/pEYN9mZrm/HVGIWm8EihpmB7er/fgrlYPRxKdjy/LpdeH1P5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721337080; c=relaxed/simple;
	bh=C+6+9xJtjwq9bMFFke0Eucufzu4qqVP8W7G9UWT0kg8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BjU8riDCEODvJAQH2RjuqWY4IWCKJrmxjd8cOlOjuE2+6hVsOs6CmlQF0sGBX386N0cCPlg7D8qlrGnN8llX7ll1aOVRAECgF9Jz4XJAY6oRHuLh2HaF9NKe17M1TOJ9C1iIQBCqPhhc/+Gt4VKKXjUl4f+1tyzr3jCPX/JpPd4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qpECDzbQ; arc=fail smtp.client-ip=40.107.96.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VPKhTKpcrenX4V1AEumLQXNJ5IuQdXKSl1YijF+/3YiyBhJJiQx33LNMPAAGvnz+pDBBCkY73iFxRLnvXQkh8YvQSeQ9IodWIWlersESur8OwZlRFBeaFhrM9aSNrZLWsjcpXAguacDPc6E5yi+fNs4CS6mp2u5JLwnR5PDP9U/ht66FlGtFbvRimC9iUkAVZmfm06PnzOrndpXiZ0zqwLBADVwj0DqgfiXWEnFwmpSRMuFY3LU3zFE4pvP+PD85p+eptSKOp5wx06fyijToTQ1Er5YP+dfT+oP0LMV+r1I61NNCJrZabZenuCghN63SxkNBqubeQEPT5x/VmzTtTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C+6+9xJtjwq9bMFFke0Eucufzu4qqVP8W7G9UWT0kg8=;
 b=Bv/CwGhydim3q5+xhExJ9gs3kqOv4WBNGta1oJM3aZP2nHh6n/aKV55/XvRZVef0wCXOHbNIQ+9AvFZCTCOTCTxTObNksfA4KLOcB4pbFPy9EXNughOPb+FXOCkd78J0gn/LKu0Ap4XhVyIlbKeL/arlCIih6KwCa/o2ex79WV24r66qMe0poI+ESDEYBpOCH11wv7JGP4ssSemOT7dmYiVksU7aMNR1VK1YsYiEhEjVLFwAejwJ/P+KhaCYOQDCwzPDsIJuRdYg9QQTF2EOLIuG5VMrnCnK/0PtUV8tnAmvVXVYYKcI7bcbGEDtfq/PpKQY+lGm9n3bh3p9wtxBbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C+6+9xJtjwq9bMFFke0Eucufzu4qqVP8W7G9UWT0kg8=;
 b=qpECDzbQew+lyEBJZCxbk9zGz9QRDyVZhxADsAjDc2LMgWirmKVuvxo7kNEX8dL2gMjqytzrYZhJpHA72gPZiEZ4NrLWz6qof7E/+Hkpu145ddPcCbXdWqsAvCTX3ROk3NUquhGaAa1ngqD4sqsLoL6iiGGY5UlDyy9N5nUt6ao=
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by CY8PR12MB7290.namprd12.prod.outlook.com (2603:10b6:930:55::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.19; Thu, 18 Jul
 2024 21:11:14 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%6]) with mapi id 15.20.7784.017; Thu, 18 Jul 2024
 21:11:14 +0000
From: "Moger, Babu" <Babu.Moger@amd.com>
To: Reinette Chatre <reinette.chatre@intel.com>, "corbet@lwn.net"
	<corbet@lwn.net>, "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC: "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"paulmck@kernel.org" <paulmck@kernel.org>, "rdunlap@infradead.org"
	<rdunlap@infradead.org>, "tj@kernel.org" <tj@kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>, "yanjiewtw@gmail.com"
	<yanjiewtw@gmail.com>, "Phillips, Kim" <kim.phillips@amd.com>,
	"lukas.bulwahn@gmail.com" <lukas.bulwahn@gmail.com>, "seanjc@google.com"
	<seanjc@google.com>, "jmattson@google.com" <jmattson@google.com>,
	"leitao@debian.org" <leitao@debian.org>, "jpoimboe@kernel.org"
	<jpoimboe@kernel.org>, "rick.p.edgecombe@intel.com"
	<rick.p.edgecombe@intel.com>, "kirill.shutemov@linux.intel.com"
	<kirill.shutemov@linux.intel.com>, "jithu.joseph@intel.com"
	<jithu.joseph@intel.com>, "kai.huang@intel.com" <kai.huang@intel.com>,
	"kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
	"daniel.sneddon@linux.intel.com" <daniel.sneddon@linux.intel.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "Das1, Sandipan"
	<Sandipan.Das@amd.com>, "ilpo.jarvinen@linux.intel.com"
	<ilpo.jarvinen@linux.intel.com>, "peternewman@google.com"
	<peternewman@google.com>, "maciej.wieczor-retman@intel.com"
	<maciej.wieczor-retman@intel.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "eranian@google.com" <eranian@google.com>,
	"james.morse@arm.com" <james.morse@arm.com>
Subject: Re: [PATCH v5 06/20] x86/resctrl: Add support to enable/disable AMD
 ABMC feature
Thread-Topic: [PATCH v5 06/20] x86/resctrl: Add support to enable/disable AMD
 ABMC feature
Thread-Index: AQHazZLo+/ZjlhcF3EGPP1P9w1CldbHztB0AgAXWHwCAACw7AIAC3iiA
Date: Thu, 18 Jul 2024 21:11:14 +0000
Message-ID:
 <MW3PR12MB4553D0871C86E1A29E56E77595AC2@MW3PR12MB4553.namprd12.prod.outlook.com>
References: <cover.1720043311.git.babu.moger@amd.com>
 <ed24fa5b599d6f0abe53a72613f7afd2dc9aeb1c.1720043311.git.babu.moger@amd.com>
 <ca8c5934-c531-4d5c-a765-8722e0eae5ba@intel.com>
 <706a061d-c9bf-48d5-834c-67ae1ba4729d@amd.com>
 <5e9d6516-abe7-405b-8db9-52c381559c58@intel.com>
In-Reply-To: <5e9d6516-abe7-405b-8db9-52c381559c58@intel.com>
Reply-To: "Moger, Babu" <Babu.Moger@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-imapappendstamp: MW3PR12MB4553.namprd12.prod.outlook.com
 (15.20.7784.015)
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR12MB4553:EE_|CY8PR12MB7290:EE_
x-ms-office365-filtering-correlation-id: b8b2925e-1224-4613-1208-08dca76e2846
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bE5HQ1kwQWNwalBKOURNVFl5YjFUK2xJOG1lMk50RWliZmJVaFF0S1VyVXRX?=
 =?utf-8?B?aGhjTm90UVJRZ0ZrT05VcWR6ekFUVi9JcmdtaFRoTi8xMmVKejBUSkVJc05E?=
 =?utf-8?B?a1gwNnFNRC9RQW9QR1hNMGZZYjQ5cEhzdkRPUVpMN1pnOUNFa2oyNFVPYXJB?=
 =?utf-8?B?dmFXeFIxd2hEbjR4SlVwVkY4a01Bc1c5eUFrODBCbDBXUTBPRkxMZzlWS0ZH?=
 =?utf-8?B?YTJTOGxPbTZpMklVTXgrWnhqQlNmQjAzZXlFUTZVMmE2S0gweUxBZlhEdU1k?=
 =?utf-8?B?b0ZwSlM2dDRxNHl1SVBLRmJ2OExtaWw5M0hVZFMvSDlmOXhsanQ2SCtncGE0?=
 =?utf-8?B?UDA4MTBuam9pcXY0WXZrTkI5cHB2bUxrYkRobVFsZ1owRHQ5VjBFUXJnM2FQ?=
 =?utf-8?B?ZWp5akI4WmNXMjdZeE85NXRhaU5MeGtxbTNCUGlqeE56ZlFCd1pLdFRUSG1R?=
 =?utf-8?B?V0VRTzdEdkZITzRuS0JmKzlvelZiRXlhL2U0TVFVUUwwU2ViOFJlOWFlYW9O?=
 =?utf-8?B?SHRjbFNGQkd6Q0V4YW80VGFCeWZ0cndxSW9mdmp0cW9GQ25xWjZKODc5dmh2?=
 =?utf-8?B?dTlLa3UrUjJXaHkrcHA3cGRFdEJBLzcrRnRIUGpTbE9hdGg0S3RDYTdnTlJq?=
 =?utf-8?B?a3JOK0dVQkxiRGRZNm9sSUtobThRTUpQSjRJT1RBZWtOV2hYNVFYbTFNWjhw?=
 =?utf-8?B?Y0MyektZc2RBUUxQL2I1RDE2M2l1SWx1MTh6UFNIcnRmVlR3K053amVtY29G?=
 =?utf-8?B?RUFKZWswTHU2emNCV3o3aGJvdVZYdlVpUWZWQ20yUm5LN1hydWNQQmdOTmVW?=
 =?utf-8?B?cmlRTzlpMDFPK095bXowYnBXUTNZSVBKR3BGRlBuN1d5L0JadGlzNFBSLzJO?=
 =?utf-8?B?aVhHWVNvN2JveU5lSU5IS3lFd0IrazNlaGdaOVhXbDRIZHJMTjI4RmlnWnFD?=
 =?utf-8?B?TzhkcUxyYXpZSThTSUczNytERmxIOVh6ZUtMMEEzZkpHL3BqQ21aNXVNR3Rp?=
 =?utf-8?B?eXljOHZOZWdRNTh4bW93NlREc3lPTjV1bE1zd3ZGVG8vTFRIRi96UlpmTjlo?=
 =?utf-8?B?Slp5YU14S2VPOXRtMm5XaGFRcE5oTFF3L1RmYStRb2FpM1o0VmRBUE9qY3Uv?=
 =?utf-8?B?VTJhTUJCdk1MVHNsazhKaFJhMzYvNnkybmNHM3NFbzJMQXFtUGN0QkMzTnU1?=
 =?utf-8?B?ZmdLMnJDYkFrUk1pL3JNK2ErcEpWdDNqTWttamVIUERiK2xyajBzeU9pUlVm?=
 =?utf-8?B?djhKWU1rVEYwK1o2WG9XcU5jaXV3Vm1HaitMWUV0RCtmT3g1ZlAyeHJNRWlm?=
 =?utf-8?B?czRYcVJLMUFZTnRNelpKN09yQm9RckdRdVFkRTRiZ28zM2QrSTE2ZExNR0FQ?=
 =?utf-8?B?MGx3U2JLR2xSR0xDbEtSNTU5N1FZalp0Zmk4cjFVR2JLUlR1QkVjS05PYVUz?=
 =?utf-8?B?TEJVUmZGNUd5UG4xaUZadUJYRVY2OEE1SFFHUVNqcjlGSDFMQW5vQ0RJcXZs?=
 =?utf-8?B?aTkwa0IxdTdxU0pmK05qNndlTW05QWRBUjlxWXd3R3hiM2IvMzhua0NwNWlE?=
 =?utf-8?B?TVVZMVlDUzNkYUg3OFovSDVrM2R5NFFvMFZYRWFHdUpadDZ4blFQTE5ydnh0?=
 =?utf-8?B?ZWtnVElXdHZJQWRRUWpMWHA5cUtISjlRckM4THdjb1doU3pTdk0yZjc0SkNK?=
 =?utf-8?B?dyt2NHdJdVBNWUxJaUluOGIvOSttMXdJTno1Zk5nT1I5dFVnUElwQXVlQkYr?=
 =?utf-8?B?eXF5Z3JOdmYxMkp0YUxrSkl2WkdpQ0gwekszaFA4Q3lVSk02QnNkL2lNYmJ0?=
 =?utf-8?Q?MEgyc89W+RqLGo9nqt8lF7/bbh1ZWT/HBJwsI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YXJTczV4OTl1TjhIS25HekJOeHJzVHFnWGZOV3A0TExOclFsZFRxNTI0UFdR?=
 =?utf-8?B?cXIzOTI5Q3lyWDBxbGI1N0R2d0pNdmt6L1cyWWMzRnMvajhPbWtDSnFSclRQ?=
 =?utf-8?B?aHBaWGM2ODlxaHg5KzN1Qk5TMGwxZkV1ZXNtakR3c3RrbnloY1lac2hzZ1Rp?=
 =?utf-8?B?TElBL0RXOXZtNDZsT3A3dElpbzc2dGczNHFLTStsR045eDZQOGpzR2lpWnNH?=
 =?utf-8?B?WlJyY3I3akdYZHV6TFZ5eDBiQkFTRnVIUmE0ZGxiSXFHUXZLbEk0TFFKRUc5?=
 =?utf-8?B?VFNwZjZLSWdmWWJ3RmQyWHBLTExGQjRBRDRiL280Q3F5WTJENnkydHdJZGhn?=
 =?utf-8?B?bkRpbU16UVJYdzg3OFYxaHUzdjNDL29iQkkwZzdnUGNGeTUzRkZrN3VsTm9x?=
 =?utf-8?B?WCs2U29CcStEdnY1WTl0N05yVzlybEJ5Z3Joa3l0N1ZTaDJqaTRPbGpwOUg3?=
 =?utf-8?B?akYxbk1ETk5veTZiQ2NSWVVlbzJPT3k0TjR6MlQ5aEtFN3BvTzNXdnc3T0g0?=
 =?utf-8?B?NjRodjFLZnlkWGhMTUcwYW4rblNMdFlGMUVnRWZGeCsvczIvRFJneFRrZ3hP?=
 =?utf-8?B?d1lPUWdJbi9jRS9XSjR0YkVDRE1CSGpXL2IzYWVnSlFWdmh3L21ENEtTTHlB?=
 =?utf-8?B?ZmZGaEh5UlJPbXVSS3pMM2N1NzUxSXI5N1J1TGNzVzNnYldGaFdWWXNhRHNl?=
 =?utf-8?B?bzNaTThiWVpRQldURWd5amc4ZVphQndzSGg0U0xnRHd0QmhQZ1Qyc0RMRnZq?=
 =?utf-8?B?a3ZwZCtzbU04cDU5MWpxTHVhRzVLTUYzR0JYakR4NVh3Nk9SRW1KZ1RXbWpp?=
 =?utf-8?B?ZHRmU1hZM0p5eExYSkJIenNYNGF3QStNOGJEUHlJTlBZMHNhRkdBSDlmMGF6?=
 =?utf-8?B?M042WEZ5UnpIVThLbmk0YkM1KzZvM3dUMExZbzhjK1hVSStZOWFOYlg3WUt4?=
 =?utf-8?B?Zk91ZTFtR0FtRWFEMTU3QzJnMGsydkxaR2k0dmEvbXZHVnIybzkrd25UVjlF?=
 =?utf-8?B?bUtYWXJaaHYrM3ZhOVBLM0pqZklKY1pXVFczdTJheTd6bWx3UkdkMFZraFJ2?=
 =?utf-8?B?ME9CVE1rZTJ0L050ZTM3TUg2QXdSR0xOTTVpUXN2bXdCc1p3Nkl2UkY1NGtV?=
 =?utf-8?B?VjFoYjgzNCtCZ3FFZlg5MENmdWNFVjBXeTROMGR3bTFPM2RpcFhXRE9pQkVq?=
 =?utf-8?B?SkpRUzRVZVEvdEl4VTNJTlZoRmhqaVYrSFRnUHczcGg3MGc2YkxxZmhJUk1o?=
 =?utf-8?B?M3FzQ2N4OU1relVsT0dmZGltOHdPS0UvMFJndFZhZ3o1UkZyOC91NTMydE5p?=
 =?utf-8?B?U1VLRzNNRlNJUXVrNjlPYkR1YjhKRzVvZHhxWnlVSFFqUWo0clpWOEhudWxX?=
 =?utf-8?B?dlQ3NWs3djFZbjNSRnJmQ3BVL1NUVWwyK1lDckJJbTZvQUpEbHEvNVYvQndI?=
 =?utf-8?B?VVdFQjRaNStHRkpFdG51MWRVMndyQnE3aDdjZXRoYTRveHRja0dmakpJOFJN?=
 =?utf-8?B?enc5djR3RTI3ZHhxR05LS0x4ek1HK1l0TElTb1JoUnFMK0tEaUVIVHo2MGZ1?=
 =?utf-8?B?NmU5a25hVFdFZnpFSE5MWmtETUpQZTh2L1BSdjRFUVdXYzVDYmtVT1lVNkkx?=
 =?utf-8?B?TVViK1lnbGp3NlFnNWlCbFYzQzRlZ0hoK1JMS0wvNDJ3S0pFRVBsVTlIZDE4?=
 =?utf-8?B?K2Zqd2l5YUxMVlcvNXBTaWJrc1ZweUxrcGIyK2QwV016Tlc0clEzQnppblBl?=
 =?utf-8?B?bThsWHVpV0VhampWeFg1V1hEamxHcTJUNDEwUHpwWlJRUktFenZhaXBUWGRQ?=
 =?utf-8?B?b1VqdnI4YVFkZTBmZG53bmQzM21ZZHFMZ3RRTEVKV1gzS3JtamdJZ3J4Vitw?=
 =?utf-8?B?VGdyREFJQXZZV2Q0Q2VMZUVKdkdxNmErdUxMdnlRaXlDQXQrbU0xbTdrYnRz?=
 =?utf-8?B?eXUvVExyWnpJYk84bWowNDZ2UE9CZGtIaWN0QlVIUk1GZ2JnRndhYk9lVUpC?=
 =?utf-8?B?SFE3UXphVUdJMmlZYTR3a0s0a2QrbDYycnFkS3F3Qk9KbnBnU0VuTGpyZlRi?=
 =?utf-8?B?QTYxYmJYRlJJenU4OXlWbUcvdXFwVFlDRlJZK0N1aXY5UTVHd0gvYzBzZFFu?=
 =?utf-8?Q?zIDw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8B0645E13CDBA14696CACA5170FA56E7@amdcloud.onmicrosoft.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8b2925e-1224-4613-1208-08dca76e2846
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2024 21:11:14.3304
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bH5zdT45o2QI3PQmEMMiPEZBmjIjSPJYowghXNk4mNare3r0dO67/JGJqFBYX+MH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7290

SGkgUmVpbmV0dGUsDQoNCk9uIDcvMTYvMjQgMTI6NTEsIFJlaW5ldHRlIENoYXRyZSB3cm90ZToN
Cj4gSGkgQmFidSwNCj4gDQo+IE9uIDcvMTYvMjQgODoxMyBBTSwgTW9nZXIsIEJhYnUgd3JvdGU6
DQo+PiBPbiA3LzEyLzI0IDE3OjA1LCBSZWluZXR0ZSBDaGF0cmUgd3JvdGU6DQo+Pj4gT24gNy8z
LzI0IDI6NDggUE0sIEJhYnUgTW9nZXIgd3JvdGU6DQo+Pj4+IEFkZCB0aGUgZnVuY3Rpb25hbGl0
eSB0byBlbmFibGUvZGlzYWJsZSBBTUQgQUJNQyBmZWF0dXJlLg0KPj4+Pg0KPj4+PiBBTUQgQUJN
QyBmZWF0dXJlIGlzIGVuYWJsZWQgYnkgc2V0dGluZyBlbmFibGVkIGJpdCgwKSBpbiBNU1INCj4+
Pj4gTDNfUU9TX0VYVF9DRkcuwqAgV2hlbiB0aGUgc3RhdGUgb2YgQUJNQyBpcyBjaGFuZ2VkLCB0
aGUgTVNSIG5lZWRzDQo+Pj4+IHRvIGJlIHVwZGF0ZWQgb24gYWxsIHRoZSBsb2dpY2FsIHByb2Nl
c3NvcnMgaW4gdGhlIFFPUyBEb21haW4uDQo+Pj4+DQo+Pj4+IEhhcmR3YXJlIGNvdW50ZXJzIHdp
bGwgcmVzZXQgd2hlbiBBQk1DIHN0YXRlIGlzIGNoYW5nZWQuIFJlc2V0IHRoZQ0KPj4+PiBhcmNo
aXRlY3R1cmFsIHN0YXRlIHNvIHRoYXQgcmVhZGluZyBvZiBoYXJkd2FyZSBjb3VudGVyIGlzIG5v
dCBjb25zaWRlcmVkDQo+Pj4+IGFzIGFuIG92ZXJmbG93IGluIG5leHQgdXBkYXRlLg0KPj4+Pg0K
Pj4+PiBUaGUgQUJNQyBmZWF0dXJlIGRldGFpbHMgYXJlIGRvY3VtZW50ZWQgaW4gQVBNIGxpc3Rl
ZCBiZWxvdyBbMV0uDQo+Pj4+IFsxXSBBTUQ2NCBBcmNoaXRlY3R1cmUgUHJvZ3JhbW1lcidzIE1h
bnVhbCBWb2x1bWUgMjogU3lzdGVtIFByb2dyYW1taW5nDQo+Pj4+IFB1YmxpY2F0aW9uICMgMjQ1
OTMgUmV2aXNpb24gMy40MSBzZWN0aW9uIDE5LjMuMy4zIEFzc2lnbmFibGUgQmFuZHdpZHRoDQo+
Pj4+IE1vbml0b3JpbmcgKEFCTUMpLg0KPj4+Pg0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBCYWJ1IE1v
Z2VyIDxiYWJ1Lm1vZ2VyQGFtZC5jb20+DQo+Pj4+IExpbms6IGh0dHBzOi8vYnVnemlsbGEua2Vy
bmVsLm9yZy9zaG93X2J1Zy5jZ2k/aWQ9MjA2NTM3DQo+Pj4+IC0tLQ0KPj4+PiB2NTogUmVuYW1l
ZCByZXNjdHJsX2FibWNfZW5hYmxlIHRvIHJlc2N0cmxfYXJjaF9hYm1jX2VuYWJsZS4NCj4+Pj4g
wqDCoMKgwqDCoCBSZW5hbWVkIHJlc2N0cmxfYWJtY19kaXNhYmxlIHRvIHJlc2N0cmxfYXJjaF9h
Ym1jX2Rpc2FibGUuDQo+Pj4+IMKgwqDCoMKgwqAgSW50cm9kdWNlZCByZXNjdHJsX2FyY2hfZ2V0
X2FibWNfZW5hYmxlZCB0byBnZXQgYWJtYyBzdGF0ZSBmcm9tDQo+Pj4+IMKgwqDCoMKgwqAgbm9u
LWFyY2ggY29kZS4NCj4+Pj4gwqDCoMKgwqDCoCBSZW5hbWVkIHJlc2N0cmxfYWJtY19zZXRfYWxs
IHRvIF9yZXNjdHJsX2FibWNfZW5hYmxlKCkuDQo+Pj4+IMKgwqDCoMKgwqAgTW9kaWZpZWQgY29t
bWl0IGxvZyB0byBtYWtlIGl0IGNsZWFyIGFib3V0IEFNRCBBQk1DIGZlYXR1cmUuDQo+Pj4+DQo+
Pj4+IHYzOiBObyBjaGFuZ2VzLg0KPj4+Pg0KPj4+PiB2MjogRmV3IHRleHQgY2hhbmdlcyBpbiBj
b21taXQgbWVzc2FnZS4NCj4+Pj4gLS0tDQo+Pj4+IMKgwqAgYXJjaC94ODYvaW5jbHVkZS9hc20v
bXNyLWluZGV4LmjCoMKgwqDCoMKgwqAgfMKgIDEgKw0KPj4+PiDCoMKgIGFyY2gveDg2L2tlcm5l
bC9jcHUvcmVzY3RybC9pbnRlcm5hbC5oIHwgMTMgKysrKysNCj4+Pj4gwqDCoCBhcmNoL3g4Ni9r
ZXJuZWwvY3B1L3Jlc2N0cmwvcmR0Z3JvdXAuYyB8IDY2ICsrKysrKysrKysrKysrKysrKysrKysr
KysrDQo+Pj4+IMKgwqAgMyBmaWxlcyBjaGFuZ2VkLCA4MCBpbnNlcnRpb25zKCspDQo+Pj4+DQo+
Pj4+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9tc3ItaW5kZXguaA0KPj4+PiBi
L2FyY2gveDg2L2luY2x1ZGUvYXNtL21zci1pbmRleC5oDQo+Pj4+IGluZGV4IDAxMzQyOTYzMDEx
ZS4uMjYzYjJkOWQwMGVkIDEwMDY0NA0KPj4+PiAtLS0gYS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9t
c3ItaW5kZXguaA0KPj4+PiArKysgYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9tc3ItaW5kZXguaA0K
Pj4+PiBAQCAtMTE3NCw2ICsxMTc0LDcgQEANCj4+Pj4gwqDCoCAjZGVmaW5lIE1TUl9JQTMyX01C
QV9CV19CQVNFwqDCoMKgwqDCoMKgwqAgMHhjMDAwMDIwMA0KPj4+PiDCoMKgICNkZWZpbmUgTVNS
X0lBMzJfU01CQV9CV19CQVNFwqDCoMKgwqDCoMKgwqAgMHhjMDAwMDI4MA0KPj4+PiDCoMKgICNk
ZWZpbmUgTVNSX0lBMzJfRVZUX0NGR19CQVNFwqDCoMKgwqDCoMKgwqAgMHhjMDAwMDQwMA0KPj4+
PiArI2RlZmluZSBNU1JfSUEzMl9MM19RT1NfRVhUX0NGR8KgwqDCoMKgwqDCoMKgIDB4YzAwMDAz
ZmYNCj4+Pj4gwqDCoCDCoCAvKiBNU1JfSUEzMl9WTVhfTUlTQyBiaXRzICovDQo+Pj4+IMKgwqAg
I2RlZmluZSBNU1JfSUEzMl9WTVhfTUlTQ19JTlRFTF9QVMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgICgxVUxMIDw8IDE0KQ0KPj4+PiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVs
L2NwdS9yZXNjdHJsL2ludGVybmFsLmgNCj4+Pj4gYi9hcmNoL3g4Ni9rZXJuZWwvY3B1L3Jlc2N0
cmwvaW50ZXJuYWwuaA0KPj4+PiBpbmRleCAyYmQyMDc2MjRlZWMuLjBjZTk3OTdmODBmZSAxMDA2
NDQNCj4+Pj4gLS0tIGEvYXJjaC94ODYva2VybmVsL2NwdS9yZXNjdHJsL2ludGVybmFsLmgNCj4+
Pj4gKysrIGIvYXJjaC94ODYva2VybmVsL2NwdS9yZXNjdHJsL2ludGVybmFsLmgNCj4+Pj4gQEAg
LTk3LDYgKzk3LDkgQEAgY3B1bWFza19hbnlfaG91c2VrZWVwaW5nKGNvbnN0IHN0cnVjdCBjcHVt
YXNrICptYXNrLA0KPj4+PiBpbnQgZXhjbHVkZV9jcHUpDQo+Pj4+IMKgwqDCoMKgwqDCoCByZXR1
cm4gY3B1Ow0KPj4+PiDCoMKgIH0NCj4+Pj4gwqDCoCArLyogU2V0dGluZyBiaXQgMCBpbiBMM19R
T1NfRVhUX0NGRyBlbmFibGVzIHRoZSBBQk1DIGZlYXR1cmUgKi8NCj4+Pg0KPj4+IFBsZWFzZSBi
ZSBjb25zaXN0ZW50IHRocm91Z2hvdXQgc2VyaWVzIHRvIGhhdmUgc2VudGVuY2VzIGVuZCB3aXRo
IHBlcmlvZC4NCj4+DQo+PiBTdXJlLg0KPj4NCj4+Pg0KPj4+PiArI2RlZmluZSBBQk1DX0VOQUJM
RcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgQklUKDApDQo+Pj4+ICsNCj4+Pj4gwqDCoCBzdHJ1Y3Qg
cmR0X2ZzX2NvbnRleHQgew0KPj4+PiDCoMKgwqDCoMKgwqAgc3RydWN0IGtlcm5mc19mc19jb250
ZXh0wqDCoMKgIGtmYzsNCj4+Pj4gwqDCoMKgwqDCoMKgIGJvb2zCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgZW5hYmxlX2NkcGwyOw0KPj4+PiBAQCAtNDc3LDYgKzQ4MCw3IEBAIHN0cnVj
dCByZHRfcGFyc2VfZGF0YSB7DQo+Pj4+IMKgwqDCoCAqIEBtYm1fY2ZnX21hc2s6wqDCoMKgIEJh
bmR3aWR0aCBzb3VyY2VzIHRoYXQgY2FuIGJlIHRyYWNrZWQgd2hlbg0KPj4+PiBCYW5kd2lkdGgN
Cj4+Pj4gwqDCoMKgICrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIE1vbml0b3JpbmcgRXZlbnQgQ29u
ZmlndXJhdGlvbiAoQk1FQykgaXMgc3VwcG9ydGVkLg0KPj4+PiDCoMKgwqAgKiBAY2RwX2VuYWJs
ZWQ6wqDCoMKgIENEUCBzdGF0ZSBvZiB0aGlzIHJlc291cmNlDQo+Pj4+ICsgKiBAYWJtY19lbmFi
bGVkOsKgwqDCoCBBQk1DIGZlYXR1cmUgaXMgZW5hYmxlZA0KPj4+PiDCoMKgwqAgKg0KPj4+PiDC
oMKgwqAgKiBNZW1iZXJzIG9mIHRoaXMgc3RydWN0dXJlIGFyZSBlaXRoZXIgcHJpdmF0ZSB0byB0
aGUgYXJjaGl0ZWN0dXJlDQo+Pj4+IMKgwqDCoCAqIGUuZy4gbWJtX3dpZHRoLCBvciBhY2Nlc3Nl
ZCB2aWEgaGVscGVycyB0aGF0IHByb3ZpZGUNCj4+Pj4gYWJzdHJhY3Rpb24uIGUuZy4NCj4+Pj4g
QEAgLTQ5MSw2ICs0OTUsNyBAQCBzdHJ1Y3QgcmR0X2h3X3Jlc291cmNlIHsNCj4+Pj4gwqDCoMKg
wqDCoMKgIHVuc2lnbmVkIGludMKgwqDCoMKgwqDCoMKgIG1ibV93aWR0aDsNCj4+Pj4gwqDCoMKg
wqDCoMKgIHVuc2lnbmVkIGludMKgwqDCoMKgwqDCoMKgIG1ibV9jZmdfbWFzazsNCj4+Pj4gwqDC
oMKgwqDCoMKgIGJvb2zCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNkcF9lbmFibGVkOw0KPj4+PiAr
wqDCoMKgIGJvb2zCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGFibWNfZW5hYmxlZDsNCj4+Pj4gwqDC
oCB9Ow0KPj4+DQo+Pj4gbWJtX2NudHJfZW5hYmxlZD8gVGhpcyBpcyBhcmNoaXRlY3R1cmUgc3Bl
Y2lmaWMgY29kZSBzbyB0aGVyZSBpcyBtb3JlDQo+Pj4gZmxleGliaWxpdHkNCj4+PiBoZXJlLCBi
dXQgaXQgbWF5IG1ha2UgaW1wbGVtZW50YXRpb24gZWFzaWVyIHRvIHVuZGVyc3RhbmQgaWYgY29u
c2lzdGVudA0KPj4+IG5hbWluZyBpcyB1c2VkDQo+Pj4gYmV0d2VlbiBmcyBhbmQgYXJjaCBjb2Rl
Lg0KPj4NCj4+IEhvdyBhYm91dCAibWJtX2NudHJfYXNzaWduX2VuYWJsZWQiIG9yICJjbnRyX2Fz
c2lnbl9lbmFibGVkIiA/DQo+IA0KPiBNeSBwcmVmZXJlbmNlIGlzIHRvIGtlZXAgdGhlIHRlcm0g
Im1ibV9jbnRyIiB0byBiZSBjb25zaXN0ZW50IHdpdGggdGhlDQo+IG90aGVyIHZhcmlhYmxlcy9z
dHJ1Y3QgbWVtYmVycyB0byBoZWxwIHdoZW4gcmVhZGluZyB0aGUgY29kZS4NCj4gIm1ibV9jbnRy
X2Fzc2lnbl9lbmFibGVkIiBkb2VzIHNlZW0gdG8gYmUgZ2V0dGluZyBsb25nIHRob3VnaC4NCj4g
QXJlIHlvdSBwbGFubmluZyB0byB1c2UgaXQgYnkgYXNzaWduaW5nIGl0IHRvIGEgbG9jYWwgdmFy
aWFibGUgd2l0aCBzaG9ydGVyDQo+IG5hbWU/DQo+IA0KPiBBcyBhIHNpZGVub3RlLCBJIHdpbGwg
YmUgb2ZmbGluZSBmb3IgbGFyZ2UgcG9ydGlvbnMgb2YgdGhlIG5leHQgZmV3IHdlZWtzDQo+IGFu
ZCB0aHVzIHVucmVzcG9uc2l2ZSBkdXJpbmcgdGhpcyB0aW1lLiBJJ2xsIGJlIGJhY2sgdG8gYSBy
ZWd1bGFyDQo+IHNjaGVkdWxlIG9uIEF1Z3VzdCAxMnRoLg0KPiANCkkgd2lsbCBzdGFydCB3b3Jr
aW5nIG9uIHY2IHNvbWV0aW1lIG5leHQgd2Vlay4gSSB3aWxsIGFkZHJlc3MgYWxsIHRoZQ0KdGhp
bmdzIHdoaWNoIHdlIGhhdmUgZGlzY3Vzc2VkIGFscmVhZHkuDQoNCldlIHN0aWxsIGhhdmUgdG8g
ZmlndXJlIG91dCBmZXcgb3RoZXJzIGl0ZW1zIHJlbGF0ZWQgdG8gZGlzcGxheWluZyB0aGUgbmV3
DQppbnRlcmZhY2UgZmlsZXMgd2hlbiBmZWF0dXJlIEFCTUMgaXMgYXZhaWxhYmxlIHZzIG5vdCBh
dmFpbGFibGUuIFdlIGNhbg0KZGlzY3VzcyBpdCB3aXRoIHY2Lg0KLS0gDQpUaGFua3MNCkJhYnUg
TW9nZXINCg==

