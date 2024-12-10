Return-Path: <linux-kernel+bounces-439818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3EE9EB451
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 16:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C756285488
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 15:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B3923DE87;
	Tue, 10 Dec 2024 15:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YiyABz75"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE4E1A072A
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 15:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733843237; cv=fail; b=pqfzFlgeI5lTa67mtnXET8aBx0/x8/JIqej3h4MPBuWHXPVcznkBkQholzbg0wqafYPK8MFMceIJueBxZMVZbHhgUj+Tafj1d0pz2oDYWiwf5Gyu/telf8Kppc2UbiRn9nAwhOqJWx6iGmR/h6EUTQu3AoblvTG3MmJ4nGE7K9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733843237; c=relaxed/simple;
	bh=LMKob+NinAKUjyT/9DqwIW8cFeJm33fBbML7pmbdnZg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WIo4MLkRXX9caim+hzmR0ElF18XMOxKK1ECfhkztmQqui2LNwpUF2s6iH1iYd7zizzRO3+fRsI9oDorqG2bVX6w0BA5jkniKO7BDlbTT4g9Mb7JmFscHyBwNdsetx2CFjw5IA/qtrPREDr0OShkhsju7zdszpszo7seCGTFEPeM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YiyABz75; arc=fail smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BAEgnTa027354;
	Tue, 10 Dec 2024 15:06:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LMKob+NinAKUjyT/9DqwIW8cFeJm33fBbML7pmbdnZg=; b=YiyABz75PgnLUItR
	YC+Tfu4ybDGaJJP+n0OBKePHkxP6mAErYaCj/cF8NqeWu/KG2+hHBPPuSmGOQRjM
	ByuSTpLsDG+U10oxonHhuvQgfnKbd5ihqM8xJm8zb2zlqvo+oymvqB/q7bO5yHPz
	REqx0tD7nqfGuo+2Ea3m/rXTYjDQnI47NMRbZttYuOSADsE1ByF1btuUqAPa4ZYx
	KD6ozdTEOyIeMgWzHF3Ki1PQ2B5N398xIWYhAhdJyezE0FJ5ymdFIa9B1aSz9Sni
	+Ji6FI9ub033lq4Y/a//I0GA1ZRCH7kTq4uWC9MnpuFFaXtCc5tOLsylLOAB9R6X
	CXAs8Q==
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2043.outbound.protection.outlook.com [104.47.57.43])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43ceetrygb-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Dec 2024 15:06:55 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l5Q1H2Kad0HGz7/OE4jfmIiVZLwlqQh5BsruOawek02kPWjR8A0hud0+7cWXxIVWCsjmE5pqdXDLa9jkhNgD8n5sr8Adk8vsjpxyuScrUR8M4d3Fa5bqEBKvFxnZoWXF21FabyKhLRlXDNSyA2/LB2EycJVrhvqzrQJP9YpwyxUG4vWiHlXpE0vOKHDBSM8/cBCmqQRlXzS0OTotJ+7DgeWN/AP4ZA2QuuJE5AyqUZz8Knw14LD34hemb16YfUuEX54NMCZI8kwIZNiC482adoFIlHjcobVY+MlJb6UnDZZuROfVESJs13OSDZCaOC2NeJo7IzbRyghOSxTETRc5hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LMKob+NinAKUjyT/9DqwIW8cFeJm33fBbML7pmbdnZg=;
 b=Y4iEhk1x1o/fMSAu3bTq2C5L8bI/xciPkV85Pl6E3mvhTZiHe1aTbgcMMFnYn7mcp9Ct+bJhVqXZos/iRiQdPtd/W+XZdRiPebOFgGxoaA4wFoMk2ThwX+Ajjz4PwvUIwQV3NucC86AlX32wpk0+JYaqG1WQWxdY7ZCN9dfntNrI2hjbvJWAPORVxj1tEvyO1DUVifW2JEEAh5zF3ehP9AFOrcHN9NXYwErPAKYIMTZ4X1sdOIZRc/yy4F6o9w5wuqPlLirg86tMGnxSEVkQoQnRJgFlYmu0bNtqVuazvegGMickfrkCk9L0PglUXjmOvhlSmGHsGBE8XsetySsp+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from CH3SPRMB0001.namprd02.prod.outlook.com (2603:10b6:610:153::20)
 by SJ0PR02MB8500.namprd02.prod.outlook.com (2603:10b6:a03:3f1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 15:06:51 +0000
Received: from CH3SPRMB0001.namprd02.prod.outlook.com
 ([fe80::1e96:7417:cf8f:8102]) by CH3SPRMB0001.namprd02.prod.outlook.com
 ([fe80::1e96:7417:cf8f:8102%3]) with mapi id 15.20.8230.016; Tue, 10 Dec 2024
 15:06:50 +0000
From: Brian Cain <bcain@quicinc.com>
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
CC: "x86@kernel.org" <x86@kernel.org>, Anup Patel <apatel@ventanamicro.com>,
        Vineet Gupta <vgupta@kernel.org>, Wei Liu <wei.liu@kernel.org>,
        Steve Wahl
	<steve.wahl@hpe.com>, Joerg Roedel <joro@8bytes.org>,
        Lu Baolu
	<baolu.lu@linux.intel.com>, Juergen Gross <jgross@suse.com>
Subject: RE: [patch 2/5] hexagon: Remove GENERIC_PENDING_IRQ leftover
Thread-Topic: [patch 2/5] hexagon: Remove GENERIC_PENDING_IRQ leftover
Thread-Index: AQHbSu8T4aX92HbfHUaLKGreMac/T7LflFcg
Date: Tue, 10 Dec 2024 15:06:50 +0000
Message-ID:
 <CH3SPRMB0001915B7156AC26CDE913E1B83D2@CH3SPRMB0001.namprd02.prod.outlook.com>
References: <20241210102148.760383417@linutronix.de>
 <20241210103335.437630614@linutronix.de>
In-Reply-To: <20241210103335.437630614@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3SPRMB0001:EE_|SJ0PR02MB8500:EE_
x-ms-office365-filtering-correlation-id: e4fa287c-6ab1-4a14-676d-08dd192c4666
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bjFQbnlvNk1DTmN5MG9yaGVUblZUaldaVldPYTA2MEY3N1VKTDRxc3B6VG5M?=
 =?utf-8?B?U1hTbmsvazh2anZmeFFUQmFuYWc5ODZtckVMNWhJanFFSjh3V0ZCczQvTENG?=
 =?utf-8?B?M0czblhFS0xPWnZGK3Rlc1N5enJWa0VEQ2h4VmsweEl1UTFjV2Z3akNTa1JB?=
 =?utf-8?B?K2JxN2tMWEFvWkprdjdTVmlobGh4YnltSzlWYzV2a1Z0MGtWY1JTTHhKS093?=
 =?utf-8?B?NnE4Q0pCeUlGZE5XNzRvN2o1VXdreUxySlpya2plVTFxNkxleElVT2RuUDNN?=
 =?utf-8?B?ZlRxSENnT2VoNlA4SzlFQnllNkU1dFRMdE8rYUEwRlFKcDFvbVl0WmU1ejU2?=
 =?utf-8?B?VmVnUU9zMTZGdktvc2xjYnNnNWpIRVJxVG5KaGVkKy9UWE80K2RMTnNhbEho?=
 =?utf-8?B?MlNpY2g5WWZxVC94OWljVVI0M1NxaUZnUThIcXVrSGVGQmdlTlp3MjB5RTFR?=
 =?utf-8?B?S3JVWm44NWF2MHIyOUMvWU9hdTZ5VVpOWW9Db3FBSlNHQnFWSzl0Rm52ZmF2?=
 =?utf-8?B?bDZ0Nm9Ja0pkbnJKYWxvRnByc2JrcCtza3JtS1N1MWRqSTFIdEMvMWo1U1VG?=
 =?utf-8?B?RDQ1T3RGY1pKSG50dzVUYzRuZDhlY1F3NWZONDJ5anRCYkZOLy83eEd1cFI4?=
 =?utf-8?B?QU1nOHdELzZWM0RyT0VZa1JJSUpTbGRFVGZtVUI3N29UV1lCTzhsQ3RycWRa?=
 =?utf-8?B?c2xNMkx2S0FONjVKOWV1dlphbGRkZ0dHTzlyTFl1bTNZQUVrblpOSTF4MWpV?=
 =?utf-8?B?NGNQMzkzUUk1aWpPOGVFWXNtd2hVZVcwVnUyZnN5TjBTcFFrcStqcXlQYjdq?=
 =?utf-8?B?dmZGNGZYaE0vajNPOVdPTzY2U3B0RXgwMVcxbk5abzBlNjNNcGJKdjU5dDRX?=
 =?utf-8?B?czU5R3hjdWo2M3Z5c3VLMVQxUkpWa0hOSmkrcUZDaVJyVXNJQXgyT3NXeFE3?=
 =?utf-8?B?WDFTQzFvT2lWVnh6aWRkWUZLYlo0c01DeW55am83YWVNNi96WGVsNGhXc0RV?=
 =?utf-8?B?K0p5dk93VjdsVmx5TWJuNnRiaTlBK1paV1FQeGtqK0QyeU41a0NKQlRGQjdm?=
 =?utf-8?B?SC9EOEVVenFHWHhvaXlwaXVDR1NFeVFZQXdhT1d1WVBZbCtoSHpwa3M2TExa?=
 =?utf-8?B?a2U0akhqc1pJa2tEOVdpOWQyZWo3bldVT2t1MVNSRGJuMkVsbFJtQklHc3RQ?=
 =?utf-8?B?YXRKZTg1UjlyYTdUU1pqcTdHMkJVZ0pLVDNwblRkODdFRTZQZHFnRWNIRXRE?=
 =?utf-8?B?ZnZpWlhUWTRMMzJ2czdTVEkyMnlkWU1pamF3QXg5TFpQQ2lnUENXZnhUUDNo?=
 =?utf-8?B?aUlQOUhMNWkraEJJaHZzMzVEY0ZuQWZUNjlGNnlHNmhsS2UrVHI0SzBCcGRG?=
 =?utf-8?B?d0JlTjIvcnJDNDF6Nk9ma0VHU2gwcnJLOHdWS0NZS3VvUE5VMm5PajhBczdU?=
 =?utf-8?B?Vk0xWi93MVdxc3gvTmQ2dmFMVDZMU29KRC83YkJ0OGRzWUdQakhRMXRpTU14?=
 =?utf-8?B?VzkrNEZPcG9vTTBHVGExeC9tUU1WdjVJUldkbU1QaURNSnFwTTJVNG5iQ2Fx?=
 =?utf-8?B?bnVnVTljSklTZ1JWajIvV2RuUW8xdzFuSWtyQkhmTjc2a3ppYlBIeHgrcHZL?=
 =?utf-8?B?N2h6Q0Z3OEtRa1d0Zk9SeEw1ZUZVb1F6SHY5aFV5b1NKbmxJVUV5dlR6Unc2?=
 =?utf-8?B?Mk14K1NhTUhpRHBKOExaMlJnc3ZucTZIRGhRQkRBYzNVS1ppa056ZGFaaWds?=
 =?utf-8?B?bkt2dWNzdkszNUJCVXhjMlIxMXpHbzJqaVFUT2NsNmY5YlNndzJzbGRWMEVB?=
 =?utf-8?B?YzJPUU1GVE5MenA1SWNHV1dXMkRzSmVYcUREdEUxMXF1N2lZbkhuaHdXeVlI?=
 =?utf-8?B?TVlDU3dURE9MM1N4bFIvZVlDWkE3aHFXckJraENFOExxRFE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3SPRMB0001.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UlB5VjBuUDhQTFJMajBEbGVPUmFoN3FMV2xRbEo3RE10dk1hVldveEgyc1VP?=
 =?utf-8?B?R3ozajkvZko2Zy9CUU1wUUlEemdtUlJhSmp2UUdYL2I1SytKRXFVZXNHenBY?=
 =?utf-8?B?Sm0yWTVtRm9LMGFsYUhyS3BFT1hmSEJYWHYyVWtUTFNXZTU4QW1peUFOYng3?=
 =?utf-8?B?RWhsLytPYW5SZlgyVXpzVzlhV2Uxcm82cFJ1emJJRlMzdUNkcjhYdG8vRW9u?=
 =?utf-8?B?bExmZ2JBUTBUcHNGTkJ4SENnNGN3SzdFcndLU0JqRTVxeTY1eGhXSlRmWDIw?=
 =?utf-8?B?aitJRS8zNTZWbkNBcDYya0dUYmpJYTJhaXNvQU9DVWNGMDhrQ0h4SHdpR1Zy?=
 =?utf-8?B?MElKWDZVMWcvQitrWTdVMUtmREIrd3VXdWdJSksxK2M0S0I4R2pLNGluWi9n?=
 =?utf-8?B?UE9xNTBGY2NYMTlFdjhkT1FNeTB1Z0xHaCtvSUdSM0FnTkhwa285Qzk0dTdt?=
 =?utf-8?B?SG14dUVtSWJSZExSUlFpYkdYU1ZteER3RHBkakJBTjhKNTZSdUxhbklja0pX?=
 =?utf-8?B?bkxFYjBsaWEyK2lpNUZzeVZsWjVBTTRrK0diMms3eEQ2bzJOb0IrYjI1UEZ5?=
 =?utf-8?B?S25XTWgrd0JQajlqSUJncS81OUk4b0g0OTFjc1JSekRjakIzdzF4R3dUQ3FD?=
 =?utf-8?B?YTExMWpBSHR6QktFRlRNQk1JUTBhb3dPTVdteGZRaWFscUYra0pXRXpDZjhs?=
 =?utf-8?B?UmhiSm1BV01rTXlIdW0yWnZKb0ZpSWpRWS94S1dkL2tENkI3dFQxcDkrMGRY?=
 =?utf-8?B?bVlFdGxjSUoyYVMvakRTOFRhN3VWc05Td2RsSUFwYkVyN0N3ekFaZzdBMUh0?=
 =?utf-8?B?ZmRUQlh4cVNDdGFTOVhONS9Vd2pENzhJZXlpZGowbG1EUTdkTmQ2bFpvVCtq?=
 =?utf-8?B?Q1YrbFBTMERHT0p6N3lhSlBnRmtublJDcVBDNHQyS0RvRnlEV3N2WXkvUU44?=
 =?utf-8?B?MTc1ZkVNSHNDWWxZMnJ4NjRCbTBvM3ZwVnVrSWd1NjhaSHNUN2tkQ0wvd1NS?=
 =?utf-8?B?bkdlTGhVZjVRMitwUkNyeFhMUkJ0aWR4OFpNMnhWTzQ0ZjY0WCtiSnhQalpF?=
 =?utf-8?B?bWdqc0dQdGVBZjNOUmJJZzZETkp0cDh2WnVvYU5peG13T0lXTXRKUzVaaEkw?=
 =?utf-8?B?WW4wS0lYRUk4R1BwRFFNZ0gvUzF6enBvUkl6Unp0dXpnMnBuWWN3VHYySnc4?=
 =?utf-8?B?RVI5Y0VkTk4xM2FKeW9JOHJoaVZ2UnpxKzVsanBnYUVYVHdJZHdQK2hMVGRB?=
 =?utf-8?B?Y2dmbm50TUljZ2RZdVVnUVBxdFM0OGJwT09jZlB5N2xicC9jUXNaTE9rVHVN?=
 =?utf-8?B?SUo5R3RCVm9QTUZzSjZSbmFyS0hCbmgxU0VGMFlkUmlSZWszcE12YzJRNzNt?=
 =?utf-8?B?SlhMdTVKUEhRYVJBcU1jSEEzSGNoWjBwOGp0dnVFdmlKYkFReUdNYWQ3OUZP?=
 =?utf-8?B?MlZ5eEw2UGFNUGtEQ1N5V3FKUGowMjloem52ZHRDc1o5OVZSVEgrWXZpNWhn?=
 =?utf-8?B?RmFEdjFRUVJnODRLcVhHU2F0L1lyamFlbWg4Y3M4SW1TcnBtWlNmdGFXNncw?=
 =?utf-8?B?ck1ydnREbURraG90OVVYLzlXTi8xMkhVV0Y3cStjUDYrWm5VTmJQbTd6eHlv?=
 =?utf-8?B?bXJIdHQ1MzBqczFUZnBYUzQzck9HRE5rU1VVQVZtQnp6Z3E3Tm85TlhQZ1JO?=
 =?utf-8?B?VzNXbC9iTzVJblBxQXFYbmpYcE1wN3VuQkd6YThNaXJiM0UvVUpPZXkrNFIy?=
 =?utf-8?B?Z3NIdkFkSHlFNERweDhUdjhtVkRsTCtBb25zdGVrN3ZwUzQ4TzVCS2NpdEc2?=
 =?utf-8?B?bXhTbE5wZ3F0ZXpjcnhDODc2aTdUcDFCNU1md1I0QjhlQnBQN1pSaXMzUUtC?=
 =?utf-8?B?dUduU0xjTjJ1ZW5VeFp1RHcwY2NId2FLUTJSdXVkN2NmZjVrSFBDVXc0amZC?=
 =?utf-8?B?bk9hR2hLOC9pZTdwZTBNdkx0TE1NajZLNzl3TE9WeWNOd1A3UFBQUDAyTitu?=
 =?utf-8?B?YStrRGFuT3QvNW5IcW9sbDRPTVFsNkVxMUFBemIyN1dmTkJLb0Rpa0pwOERr?=
 =?utf-8?B?ZHBJVXdBU2JIVnRpczRqZ3ZjV1o2THRVR3IrQkZBeUR1Y2cvN1BsYTExRlBJ?=
 =?utf-8?Q?fYoc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	X2l9P4NrPJBOf6lfNdlnpHWRjruOJMkG5tow6ZM+SeCyoO+foEaaRKUFhb1YBVzRQoHwqBDK8hpGTA1GfnAb0K2wXK/kyM55sADS4Hd6JNSZAnx1KqC7FJFoa0k1HfbSXmn2LIdtCaI0GFHF902bzB8Lu3/UCcFfUhp8Q6GgmrSrMovCfl2p/u+ZIH5vDDFA60PN9oupGkwaa24xaa5n0BbPhhriJUKb9JpGYVNHwN0wCBfFKCKDKhvX3t549gvgiLRYAsrjWvvY7IA4aUcIYYEt5JuX+wBoGf5gjMjV6Bii2970DopY/ccaw858wJhK5GrGofz7lh0nIg42CYe8i85kr+jIurcjlTDh13rBJYijdwrXLNEYtWzZ4hVec3cz94cTechzaMDxdISOq9K/eogcgh3NfMHjGsdbL27kfSByMEO+UsooQZTpKdGOY5WC1HOIvdT/pZ+Y67TlFUOlmNbOfY8SGLSTLkJvW64lgvIcm++dmG4GaTmdelBktcQ2Kuv7Sa1kzrPelt/yYj/dQ4jTbvJFt3yLgnblfk8opgDUenJOJaqiriw5J4N9bldxzHIwDiZ+tsmUsZTj2d4WMqgfvCXxwSQDttQZqdQWjUazrYRF6HgtPnKmWvfyWeRX
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3SPRMB0001.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4fa287c-6ab1-4a14-676d-08dd192c4666
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2024 15:06:50.6334
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C1UkTr6NlgP2E1uz16PnS89AfmL42tYwd8Esx4aGAl//UA48apewJcfuRRSizyhe0vQ0nDBX9ck1LLsDKnxIkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8500
X-Proofpoint-GUID: dr8bT0QGUsGcYvd-Fdl-HZPs-WFa9z0Q
X-Proofpoint-ORIG-GUID: dr8bT0QGUsGcYvd-Fdl-HZPs-WFa9z0Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 spamscore=0 adultscore=0 clxscore=1011 impostorscore=0 mlxlogscore=588
 bulkscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412100112

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVGhvbWFzIEdsZWl4bmVy
IDx0Z2x4QGxpbnV0cm9uaXguZGU+DQo+IFNlbnQ6IFR1ZXNkYXksIERlY2VtYmVyIDEwLCAyMDI0
IDQ6MzQgQU0NCj4gVG86IExLTUwgPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+DQo+IENj
OiB4ODZAa2VybmVsLm9yZzsgQW51cCBQYXRlbCA8YXBhdGVsQHZlbnRhbmFtaWNyby5jb20+OyBC
cmlhbiBDYWluDQo+IDxiY2FpbkBxdWljaW5jLmNvbT47IFZpbmVldCBHdXB0YSA8dmd1cHRhQGtl
cm5lbC5vcmc+OyBXZWkgTGl1DQo+IDx3ZWkubGl1QGtlcm5lbC5vcmc+OyBTdGV2ZSBXYWhsIDxz
dGV2ZS53YWhsQGhwZS5jb20+OyBKb2VyZyBSb2VkZWwNCj4gPGpvcm9AOGJ5dGVzLm9yZz47IEx1
IEJhb2x1IDxiYW9sdS5sdUBsaW51eC5pbnRlbC5jb20+OyBKdWVyZ2VuIEdyb3NzDQo+IDxqZ3Jv
c3NAc3VzZS5jb20+DQo+IFN1YmplY3Q6IFtwYXRjaCAyLzVdIGhleGFnb246IFJlbW92ZSBHRU5F
UklDX1BFTkRJTkdfSVJRIGxlZnRvdmVyDQo+IA0KPiBXQVJOSU5HOiBUaGlzIGVtYWlsIG9yaWdp
bmF0ZWQgZnJvbSBvdXRzaWRlIG9mIFF1YWxjb21tLiBQbGVhc2UgYmUgd2FyeSBvZg0KPiBhbnkg
bGlua3Mgb3IgYXR0YWNobWVudHMsIGFuZCBkbyBub3QgZW5hYmxlIG1hY3Jvcy4NCj4gDQo+IENv
bW1lbnRlZCBvdXQgc2luY2UgMjAxMS4uLi4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFRob21hcyBH
bGVpeG5lciA8dGdseEBsaW51dHJvbml4LmRlPg0KPiBDYzogQnJpYW4gQ2FpbiA8YmNhaW5AcXVp
Y2luYy5jb20+DQo+IC0tLQ0KDQpBY2tlZC1ieTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5j
b20+DQoNCj4gIGFyY2gvaGV4YWdvbi9LY29uZmlnIHwgICAgMSAtDQo+ICAxIGZpbGUgY2hhbmdl
ZCwgMSBkZWxldGlvbigtKQ0KPiANCj4gLS0tIGEvYXJjaC9oZXhhZ29uL0tjb25maWcNCj4gKysr
IGIvYXJjaC9oZXhhZ29uL0tjb25maWcNCj4gQEAgLTIwLDcgKzIwLDYgQEAgY29uZmlnIEhFWEFH
T04NCj4gICAgICAgICAjIHNlbGVjdCBBUkNIX0hBU19DUFVfSURMRV9XQUlUDQo+ICAgICAgICAg
IyBzZWxlY3QgR1BJT0xJQg0KPiAgICAgICAgICMgc2VsZWN0IEhBVkVfQ0xLDQo+IC0gICAgICAg
IyBzZWxlY3QgR0VORVJJQ19QRU5ESU5HX0lSUSBpZiBTTVANCj4gICAgICAgICBzZWxlY3QgR0VO
RVJJQ19BVE9NSUM2NA0KPiAgICAgICAgIHNlbGVjdCBIQVZFX1BFUkZfRVZFTlRTDQo+ICAgICAg
ICAgIyBHRU5FUklDX0FMTE9DQVRPUiBpcyB1c2VkIGJ5IGRtYV9hbGxvY19jb2hlcmVudCgpDQoN
Cg==

