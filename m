Return-Path: <linux-kernel+bounces-411079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7478C9CF2B3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 18:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC64C1F2384A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 17:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0821D5CFD;
	Fri, 15 Nov 2024 17:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Bm7v4ZAr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WZd9dL9Q"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1FE12B17C
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 17:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731691244; cv=fail; b=h/D7cIzbD59+7wLwUyb61lu0fL0KryzuIukfQQkdZWUzYNfHcDNkwds0Y2tmkcGokEJsucByRvIbaZ++XLscZaqTVzSJmMB4Eq31wjDpnvlJxhDisu+CyvrhB6rlMIgzllbTrdADptCKnbQ07XyeKE9Uf7M7KLnjxAuVr1+NJ0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731691244; c=relaxed/simple;
	bh=HuVeW1wc9NCHVbArwQLmZY5PNmtSK5IZ7Uc7jJGJPt8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dSQOlfDlR0TcNcsHzRLV5iggLePIBNR5S5dgdR4cO8fDU6K9hwnTrBhGZfcVGL/mhDsnXNV8io4mQt9Yq0EKAJnAVT30VYxU7OgawNMlCzTNhTw7t8Y5xH5gOfp9FF815kpahpftLPs0xaVraHzFCPTtJ0KjsAWFFyURr8cYinw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Bm7v4ZAr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WZd9dL9Q; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFGMsMN005902;
	Fri, 15 Nov 2024 17:20:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=HuVeW1wc9NCHVbArwQLmZY5PNmtSK5IZ7Uc7jJGJPt8=; b=
	Bm7v4ZArd0p+4sVhpZZ6+2wyYq2OnkgBwVkQXGYKccn410REmnxjOwBUktDMiQP9
	Mvbi+QpOjb8kwCHn/YbMVP+0aOI8xLXTPtTebUsXfpAPyDCKTMMWlYSqeUF2UVjt
	BylG5G1ooLmSaVPDl+yMw7CVpyF4+daCAqp4aOELABfp4okep/5D78/KRWEMsnIg
	YtdeWOrVB1Fhrr/ONtoQ4WAFmQsjUgq1D/J34Yh9XosCT//IOnAFZBVWecZ6eqtY
	kL9u+y/YhFcWLZ+L78x6kDLHv2N7gR0Ppf/sSKkWvKh01cw3UMGrO5NIetbcO6Ej
	bb6zsaL+XVlpeVhjM+Lk6w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0heuqp2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 17:20:24 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFGj0Jb023937;
	Fri, 15 Nov 2024 17:20:23 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42vuw2xrs9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 17:20:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OtSQY/GcOC5WJRerCU7SdNthGtNvt/jb1HK79Av2VQKVKlhkzQUQxTgUM5M8MOYEsFQEwM8KePmy06PaOgg/u1nubze9ND/4sreeTm0K+sXTrbbkdRCPBvZtT5+TPm/T82I43mhYbf8wuRQVCEMMmQWsiyUkUqsWW3IRsd+o2njMKU1sA6P7YjEzaLj1n8e0th2R3wtzanHa41N4qf6x2DXb7fWBSv1L668AwRD79F9xe1flSoNsQCVXei0p2zpEbZ0KSo+XZcfo7fJ0xSOk2xSvgHEhr9z1WkCQs/bkpcqxffRrGnaPdzRaHrkKwmiekxVT/4vuN8TM6ExOtP1sJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HuVeW1wc9NCHVbArwQLmZY5PNmtSK5IZ7Uc7jJGJPt8=;
 b=hl3wfD/xVDw/qeJikNVG1aIbJXy+IuTcNUhlCPTt7ywgL9SBTFcPBbVRNnkpIFFJUxPAPREVBmJUC+43wJ9sA6PCQqXhFC1lUNQoy3Yg4//9OrN62slA0u7Ae0Siqm9Q2XBEqGArrgYit/UGvQtBlbhcxGYMpc34+JmGxsFu92YOY/LMnxtOBiQpIpOOYJaqiMqmA7u2koCvwZ8HdcxUG32cGZps1iJN1qbpQPUvk8pUV/JtNoxd6+auV2773En/7VMTkRqjMfz/+AizRj+0iBpINZvOuBXCSTpRhWQv0KNgzlTgyESnwz17LV0yekIniCFbZjpm6dfbj0NHHc2ZPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HuVeW1wc9NCHVbArwQLmZY5PNmtSK5IZ7Uc7jJGJPt8=;
 b=WZd9dL9QK3fSu7q3x+sPDnH1Bp9PAL02Ki3mZrbuoVkn21pJpExuAsACcdVqC7DVTw2pme/94GRyKQgmSZ/jyv52iKbbP/sfjhWXQtiicUFEGwK58y7QHo8HDj1XPeUpssI5m/UZS5bov9j/lNYWHXxlalIXpZip7syq6A8LBMY=
Received: from IA1PR10MB7309.namprd10.prod.outlook.com (2603:10b6:208:3fe::13)
 by MN6PR10MB7465.namprd10.prod.outlook.com (2603:10b6:208:47a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Fri, 15 Nov
 2024 17:20:17 +0000
Received: from IA1PR10MB7309.namprd10.prod.outlook.com
 ([fe80::818c:4ed2:2a1a:757a]) by IA1PR10MB7309.namprd10.prod.outlook.com
 ([fe80::818c:4ed2:2a1a:757a%2]) with mapi id 15.20.8158.013; Fri, 15 Nov 2024
 17:20:17 +0000
From: Prakash Sangappa <prakash.sangappa@oracle.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: Peter Zijlstra <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        Daniel Jordan
	<daniel.m.jordan@oracle.com>
Subject: Re: [RFC PATCH 0/4] Scheduler time slice extension
Thread-Topic: [RFC PATCH 0/4] Scheduler time slice extension
Thread-Index:
 AQHbNV85xP8mG8bGMUONwn7IqXYau7K1jv+AgAANEACAAAlsgIAA77AAgACalICAATaggIAANB6A
Date: Fri, 15 Nov 2024 17:20:17 +0000
Message-ID: <27F0FD0A-2443-4947-8598-5550EF2AE825@oracle.com>
References: <20241113000126.967713-1-prakash.sangappa@oracle.com>
 <20241113185013.GA22571@noisy.programming.kicks-ass.net>
 <f0f681a0-22b4-45f4-85a1-18f140286cbe@efficios.com>
 <896BA407-E19C-4CEB-BF5E-9707543BA365@oracle.com>
 <20241114102834.GM6497@noisy.programming.kicks-ass.net>
 <CF032474-7725-48C1-BA31-A8728C6C06E7@oracle.com>
 <d86d463c-14ea-47cf-adc6-d3e9caa4ebf1@efficios.com>
In-Reply-To: <d86d463c-14ea-47cf-adc6-d3e9caa4ebf1@efficios.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51.11.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR10MB7309:EE_|MN6PR10MB7465:EE_
x-ms-office365-filtering-correlation-id: c08ed432-6ba4-4012-5143-08dd0599c67b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NDBtU0FkNUFiOW5wVHcvTHNDSVJidkFGdDNCNmRXcGt1dzEyOUJyQ0lkdjR3?=
 =?utf-8?B?NWMrdmEyYVhMQkh5VmRlUm9oZXlRRTlwbnRrczJicXhhcDBaMFlwTzcyakpj?=
 =?utf-8?B?MEFYN29yV2dla1FTNGhsSE5JMHF1c3R1d3FYOGFZaHZYOVcvUDIxbEtoODNj?=
 =?utf-8?B?VHIrYy8yWGxIOThhRGhnMm4yVXk2K3NFcGFvbURnMU4xVmN1UkxkbkhNcTl1?=
 =?utf-8?B?Z2Ztc01FYTJwbWhPQWNEM3JQYTR1UTk0aTVuVlBnUkdSZ05iUUpQaS9RSzV1?=
 =?utf-8?B?V0FJai9XbXFPTTJEYVZocjRLMHRpR0ZTQkwxbUlMdzIwT0RKSGVpMzByWHY2?=
 =?utf-8?B?dC81S3FWNTFaOXdicmVTWGp5WEU4THJjTE1HT2Nsd3pQcVBSV3hOOWpoNXBa?=
 =?utf-8?B?MGJoOWZzaVRQd2p2VWdvNnhWR1hYdTdibzB3MjBVZWpSNHlMbUF4eGN0RDRZ?=
 =?utf-8?B?cmVMeEhHblc4WlZGWkM1aVJJRjF6VStpVmxEUUdKVmRYcVFMazE5NTd5bGU4?=
 =?utf-8?B?bXFsenNBQVdtU0pZZUV6a1F1N1RTM2ppMmVtNnp6TjIxZWthaWttMlk0M1gw?=
 =?utf-8?B?SmVyV2dBWmRhQ1h5TVdOVEdwU3N1MlBVdXNLYmFCUkZJTjY4ellhWTdPMGxz?=
 =?utf-8?B?dEJSaTJsWmw3bi9aMlZYN1MrakVTMmtTaWNUYW5jWTVGQXJoREJqU0xDU21w?=
 =?utf-8?B?K3JkMHIwYnUvSk5jQ1ZOdlBvVnZyTVVFbi9wR00vOWRGNWdPUzZmbXV4Vm54?=
 =?utf-8?B?a0hNdXpFRmFsbEVyN3k5OEsxSTZLVjV0Z3RvRjNPMjF0N0pnN0VySVNSV29z?=
 =?utf-8?B?TFBvVndWeTJyWVRJMy9EQ2REN3c5Q09mNTA2ZjJDOS8zbTBMN2Vhcnloa3lF?=
 =?utf-8?B?a2RGNEUvWlBVc1FlNktJOFhaWEtEY0tRL2pjdHZWblI3SVlUMmxKaSthMTl6?=
 =?utf-8?B?UXBobjZyT0hoY3ZZdHFKWm9Vd0UwcGtTVlZMc2k0WmZSeTdWRUM4WXNEYWl0?=
 =?utf-8?B?V0Rka2hiWlpReENLZFN1OE02bTZVemwxWml3TkhmSGZkMmFXdUozWnp3SWVj?=
 =?utf-8?B?N1I0aldLKzVMUVltbUlpendudTBUMTI1bWFBTTk3RVF5eEJzbmRabi9NS2JU?=
 =?utf-8?B?VFEySjFsdHBJV1QxSUNXc3ErbURXZmJuWUZkdnduRHVqTjJ0NllkbDJKVDRT?=
 =?utf-8?B?VUJIMTFHa1JIUEdzRWtHVENyM3JZRWNnc0ZKUXhZQUltU0pndGhhNU9HVFc4?=
 =?utf-8?B?a2JyeVdwK1ZEcXVIekZFTnFCeFVYS21yckd1STBpcmt0ay9ydXBkWHA2bEpT?=
 =?utf-8?B?cFoySmVVemV4WGRQRy94dklRNS82M3p1aWhqQlJnUU81U2hqdlhzRUs4ZmVt?=
 =?utf-8?B?WHpXUVZNWGNWc2drTUZtd21Md3IvcXpmcFVOWk8raFZUcWh6Vm9IcWM1cUlW?=
 =?utf-8?B?QUhyQTM0UWtHb1hPMkhTUU1LS3c0Q3pMd2E1dXU5TEhTUDBHTWxETjNvSlcy?=
 =?utf-8?B?UXNIVlRxUW9hamk3VE9GcnZYQUVkU0w4cVFLSmp5YVpBVmovWUxWTUl6eTBk?=
 =?utf-8?B?aTdhOFhjZUNEMlY0VTFoTWZydFlrbVd6RXduQnFmK0hEa05pZzRLOVBmWWF6?=
 =?utf-8?B?elc5d0ZGVm1jUlV4RzlNc1FCbDRHSEI4UjNzRVJIdmlUREtWdXJnbnJJNW5U?=
 =?utf-8?B?Qzh6ZWg2QW5LcFBQMGNHb0x4SVMxRmFlNVlRbHRiVG1qK29PNTZJU0ptc25R?=
 =?utf-8?Q?5GrkbuFFwtfzihX0+IqeVdX6IXTyZOVv+CMhak5?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7309.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TzVaSmk0WE14VUpTN0pVNXhBQVpMMVFYMzI5dWJtZmkvbmxxT3RUM3RQcGN0?=
 =?utf-8?B?QVA2T01kYVUwMzdVc2podGxJQkNlR0syVEIxVkQ5aS93RnZTMW4xYnRsckE2?=
 =?utf-8?B?UEl0L2hkZmV5YzR1THpIbW1Da1MvYnc1THZqN0thYzB4dVBLUFZDWDBMNmQy?=
 =?utf-8?B?WUZ1WEZEVEJuaXBwby9qVktZbWU3SDBRL0pRd01pV0xpTzlhdU9JNFdFVEky?=
 =?utf-8?B?UDMyR01YTFQ2cTh5c3JJamFiN3pQRk9peThFbEJ2REx1aU5EeG9GOTg1SzQ3?=
 =?utf-8?B?SkpRZXkxbldFZ2lrcEV5d084WWk4WVFwSUxZd0VIUzh6dnp1VWtCWEZwZm5D?=
 =?utf-8?B?OUNNSVVnTzFtWURXcDB6L1NTWE5JZGFlSjg1MEdsNlVBKzFzVW1QTVhXYUhE?=
 =?utf-8?B?WnpHTkVhQmlSTCtMeFhsUEd2NU9RRXlZSjA5cC9vdGphRlpnLy9hZUtMOWJC?=
 =?utf-8?B?VnZkb3poQUhxOEljZWc3bVNjb2RmU3ViS0VUM1VyRjNLeXQ4T1RLbVJZdkd5?=
 =?utf-8?B?djJnQ21PNk9PbmtxUzM1cEs1K2RXQy9UUTU1ZllNSVhIQUFhSDU3V1VmZ3Ru?=
 =?utf-8?B?MkhMMUQ0RmR1SjJmQW0ydEdyVnhpUVVBQjRrd1RLbm1tVHJDMEM1L0tqekJa?=
 =?utf-8?B?WXF3WnNmZndGQ09DdG04MVZVWGJ1R2xXUkFNeGVpVlhuaVdnT3pQanUzcEhp?=
 =?utf-8?B?TG8xL2plWmQxM1JNQTRFSHhLWHpWbWJtakozQnpKVHovZE9xSXlwVUZMc1Vy?=
 =?utf-8?B?N3dUMjA0Z1RYVnNpdVJmWXpGMmtCV0ZMenJXWGVNOE01ZFA3MWk1NmYzUnJI?=
 =?utf-8?B?MXUxeEc5OHE1Mk54elZTTEl4ZWF3R3h3bjFWd09ucStFVmZCeHg0N1RzNFdS?=
 =?utf-8?B?Nkt2WEx2d08zbHg0aWxaVW1rbFh5VVdyOUh2cnZEQ2Z3QzEyM1h3ZHBNL2o1?=
 =?utf-8?B?bmwxQ3dFY0tNNmt0QzlEelRHUXVoUnc4UXRKZ1o0NzhTV0lDb0dtWVM5VlUy?=
 =?utf-8?B?N1ExeDZ3bHJKSjJZMEFnWlpNVXFPK2VYNldFY2V1RWJRY1A5S3AvRTRGU0Zn?=
 =?utf-8?B?UllkZE0zUXpGWWlFUG8xMlZ3RnVSM1QyYWI5aWRWNmF3K0RPV0xGQWtOa3Yw?=
 =?utf-8?B?dTNuVWZZN2lJYXRPZlhmTERBWmZYd3ZXelJ4K1Z1Qk1MaW1DVW9jNm5EYUoy?=
 =?utf-8?B?TlNEdHFiamY4cWhUU2dIYTBCYVNRWFQ2OHYzeXlQVnE4VjgweE91amZCMnVJ?=
 =?utf-8?B?VnhYMHUrWXdaTUZSSEhMU3ZtWWo4SjdzcHJnNFNYYzZsZDZYd0g5QmxjL2gz?=
 =?utf-8?B?Uk5PWUhKYmpmb3cvcVZyMlFlZzNSZ29ZZEQ5MGpYWFlta3NVNjZOcE9vVlY1?=
 =?utf-8?B?WDRISUZyMUc5L2xqMHI0RnU4TGIzWEtFQms5YXdCankxMGRCVHhoMnpxckJz?=
 =?utf-8?B?QjRXZmJBSWhTZUNiVkpPOTcvOFVySkJVbjh2V0JranFqcWZMczVFbVozMzdy?=
 =?utf-8?B?UEVzbVNTdHBjYi9xY3Bmd2VyUUpMKytZMFltLzl6K240Sm9PdVdJeTFzWFNz?=
 =?utf-8?B?ZTYwaWdqYXhNeU1LTytaZWU4RHhxZW5NNFBOSjhONml2S1lOZWlKT1p5Ti82?=
 =?utf-8?B?SW80NWRiU2V2Q1dPRWhITGVHeFFLWUJUUlFJbTRteWp1OW40bnFWQ2dzclVj?=
 =?utf-8?B?Z2V6T1VmQnRBNDAxVGFyY3NmdXg2SVltS01Pa1ZtNmRGc3pxL3JFbFdXSThv?=
 =?utf-8?B?dk8wY3lJYjFSdFpJTkdUL1l1OGZTQ3F0U1Bxall1cWt3MUFVWHBkMFBpb0lO?=
 =?utf-8?B?enpUSVc4SURhSE1wVnh4dVpEZko5dTc1R1d5V2hrVi9pb3FHLzd3YUxwOGRT?=
 =?utf-8?B?M0lsekx0QnpUQkV1MWIrRURySTI4Slh5Y2NNV1NYU1lORlFIdWYzUmY1MXZG?=
 =?utf-8?B?emFmQ3RDMndHV1hmQm1CRUJPazB6Qk12NG9HQ1VrK2ZSb1hYMjAwVjJzOGMw?=
 =?utf-8?B?S0Y2MEhJeE16czV5MnFXZHAxRi9qVTJzNktNY29CbHF4d1hjUk52blFLbVJB?=
 =?utf-8?B?QUxua3ExTFFmUTNTUTUwT1A5ZnhmUmJNVjJZZWFjTFh2amdoenFlWCtNdVAy?=
 =?utf-8?B?dVpwT3VoVGZYTkV2S0dYcElwV2NiWFMzZ1VKbEN1V0wzeXVHTVFEL2RQTmt1?=
 =?utf-8?Q?mrg1rGMq4koXLPuVsZaYahSRgWWb8Gqq56M8gZWTIO1/?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <454DEFFE7CC4A44B9F4AF2F8905F24B6@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0QX313fHedXZYrVqOH81IwFxXheaNS34MwmmearFOmd8QDXwRJ6o+B21IC54Iqkc9S+ZtJR0Ek//MT4Cperf8Z/aJAx3Qd3aBZ6vOl2uhp/at6Oa2tiqu0jVFGVK5FH7Z05Fy0BlF/5LQ4UdkE4exfBUB7GZygrpv1l4fudHVHoP9LOw21QXMSvXEYt/o0yuZniY6VsSRqQVQ6IpzW5+3ilqjxp3wM2f0N/acEMBMi7HAGOebPbW7BZNw8172I1AplC8pIgqzLim3K8nEljqePHUEROJwjRuZFLlVe0qBd9d/34t729Z/k3qrwPPofy1rHllnkXr6ZkMrjvpbpcMMK6xH2cs0IDyf3YN405bRqvwZHruOqvwewA4gN6xxkAhbqIW1BvD3VBvfj93TC8iBUWG47wiqVQW5KtgmfU/SZ+DtXDIwEZRnBhGM/taAs6fO9MkVFZDyDCC6IAb0DfjOLfmBXTl3Hg2IlKb1JkI2qNmTwwuSj5DMs31ZGaqqHAQmy0A45FMlxHinJ8Qe9JtaNP/SegBB/+YhKydgmbqadz6xK1Tl92DiA7jXD5Jp8FAheLRYsHMOkqR6nYl/rxxnH+SuHawfPNPb6dAuL8LHHM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7309.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c08ed432-6ba4-4012-5143-08dd0599c67b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2024 17:20:17.4224
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZYHfv/Qq/CVZk9VsC0nvf/7Izlfp9DMIclpHOqrpS9Bk2O7h/bOv08qk57qQ0Pq+FscYeH4oM6fWbAadIE+KKemJDPYWKKC+2ouHPYne3ns=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7465
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-15_04,2024-11-14_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411150146
X-Proofpoint-ORIG-GUID: vtau_5GMfW09jqMGMzKqvB4EQ2CK6LrL
X-Proofpoint-GUID: vtau_5GMfW09jqMGMzKqvB4EQ2CK6LrL

DQoNCj4gT24gTm92IDE1LCAyMDI0LCBhdCA2OjEz4oCvQU0sIE1hdGhpZXUgRGVzbm95ZXJzIDxt
YXRoaWV1LmRlc25veWVyc0BlZmZpY2lvcy5jb20+IHdyb3RlOg0KPiANCj4gT24gMjAyNC0xMS0x
NCAxNDo0MiwgUHJha2FzaCBTYW5nYXBwYSB3cm90ZToNCj4+PiBPbiBOb3YgMTQsIDIwMjQsIGF0
IDI6MjjigK9BTSwgUGV0ZXIgWmlqbHN0cmEgPHBldGVyekBpbmZyYWRlYWQub3JnPiB3cm90ZToN
Cj4gDQo+IFsuLi5dDQo+IA0KPj4+IA0KPj4+IFNlZToNCj4+PiANCj4+PiAgaHR0cHM6Ly9sa21s
Lmtlcm5lbC5vcmcvci8yMDIyMDExMzIzMzk0MC4zNjA4NDQwLTQtcG9za0Bnb29nbGUuY29tDQo+
Pj4gDQo+Pj4gZm9yIGEgbW9yZSBlbGFib3JhdGUgc2NoZW1lLg0KPj4+IA0KPj4+Pj4gUGV0ZXIs
IHdhcyB0aGVyZSBhbnl0aGluZyBmdW5kYW1lbnRhbGx5IHdyb25nIHdpdGggeW91ciBhcHByb2Fj
aCBiYXNlZA0KPj4+Pj4gb24gcnNlcSA/IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAy
MzEwMzAxMzI5NDkuR0EzODEyM0Bub2lzeS5wcm9ncmFtbWluZy5raWNrcy1hc3MubmV0DQo+Pj4+
PiANCj4+Pj4+IFRoZSBtYWluIHRoaW5nIEkgd29uZGVyIGlzIHdoZXRoZXIgbG9hZGluZyB0aGUg
cnNlcSBkZWxheSByZXNjaGVkIGZsYWcNCj4+Pj4+IG9uIHJldHVybiB0byB1c2Vyc3BhY2UgaXMg
dG9vIGxhdGUgaW4geW91ciBwYXRjaC4gQWxzbywgSSdtIG5vdCBzdXJlIGl0IGlzDQo+Pj4+PiBy
ZWFsaXN0aWMgdG8gcmVxdWlyZSB0aGF0IG5vIHN5c3RlbSBjYWxscyBzaG91bGQgYmUgZG9uZSB3
aXRoaW4gdGltZSBleHRlbnNpb24NCj4+Pj4+IHNsaWNlLiBJZiB3ZSBoYXZlIHRoaXMgc2NlbmFy
aW86DQo+Pj4+IA0KPj4+PiBJIGFtIGFsc28gbm90IHN1cmUgaWYgd2UgbmVlZCB0byBwcmV2ZW50
IHN5c3RlbSBjYWxscyBpbiB0aGlzIHNjZW5hcmlvLg0KPj4+PiBXYXMgdGhhdCByZXN0cmljdGlv
biBtYWlubHkgYmVjYXVzZSBvZiByZXN0YXJ0YWJsZSBzZXF1ZW5jZSBBUEkgaW1wbGVtZW50cyBp
dD8NCj4+PiANCj4+PiBObywgdGhlIHdob2xlIHByZW1pc2Ugb2YgZGVsYXlpbmcgcmVzY2hlZCB3
YXMgYmVjYXVzZSBwZW9wbGUgdGhpbmsgdGhhdA0KPj4+IHN5c2NhbGxzIGFyZSB0b28gc2xvdy4g
SWYgeW91IGRvIG5vdCB0aGluayB0aGlzLCB0aGVuIHlvdSBzaG91bGRuJ3QgYmUNCj4+PiB1c2lu
ZyB0aGlzLg0KPj4gQWdyZWUuDQo+IA0KPiBJIG9ubHkgcGFydGlhbGx5IGFncmVlIHdpdGggUGV0
ZXIgaGVyZS4gSSBhZ3JlZSB0aGF0IHdlIGRvbid0IHdhbnQgdG8NCj4gYWRkIHN5c3RlbSBjYWxs
cyBvbiB0aGUgZGVsYXktcmVzY2hlZCBjcml0aWNhbCBzZWN0aW9uIGZhc3QgcGF0aCwNCj4gYmVj
YXVzZSB0aGlzIHdvdWxkIGhhdmUgYSBzaWduaWZpY2FudCBwZXJmb3JtYW5jZSBoaXQuDQo+IA0K
PiBCdXQgdGhlcmUgYXJlIHNjZW5hcmlvcyB3aGVyZSBpc3N1aW5nIHN5c3RlbSBjYWxscyBmcm9t
IHdpdGhpbiB0aGF0DQo+IGNyaXRpY2FsIHNlY3Rpb24gd291bGQgYmUgbmVlZGVkLCBldmVuIHRo
b3VnaCB0aG9zZSB3b3VsZCBub3QgYmVsb25nDQo+IHRvIHRoZSBmYXN0IHBhdGg6DQo+IA0KPiAx
KSBJZiBhIHNpZ25hbCBoYW5kbGVyIG5lc3RzIG92ZXIgYSBkZWxheS1yZXNjaGVkIGNyaXRpY2Fs
IHNlY3Rpb24uDQo+ICAgVGhhdCBzaWduYWwgaGFuZGxlciBpcyBhbGxvd2VkIHRvIGlzc3VlIHN5
c3RlbSBjYWxscy4NCj4gDQo+IDIpIElmIHRoZSBjcml0aWNhbCBzZWN0aW9uIGZhc3QtcGF0aCBp
cyBjYWxsaW5nIEdOVSBDIGxpYnJhcnkgQVBJIGFuZC9vcg0KPiAgIGEgdkRTTywgd2hpY2ggaXMg
dHlwaWNhbGx5IGZhc3QsIGJ1dCBjYW4gZW5kIHVwIGNhbGxpbmcgYSBzeXN0ZW0gY2FsbA0KPiAg
IGFzIGZhbGxiYWNrLiBlLmcuIGNsb2NrX2dldHRpbWUsIHNjaGVkX2dldGNwdS4gUHJldmVudGlu
ZyB1c2Ugb2YgYQ0KPiAgIHN5c3RlbSBjYWxsIGJ5IGtpbGxpbmcgdGhlIGFwcGxpY2F0aW9uIHB1
bmNoZXMgYSBob2xlIGluIHRoZQ0KPiAgIGFic3RyYWN0aW9ucyBtZWFudCB0byBiZSBwcm92aWRl
ZCBieSBHTlUgbGliYyBhbmQgdkRTTy4NCj4gDQo+IEkgd291bGQgcmVjb21tZW5kIHRoYXQgd2Ug
YWxsb3cgaXNzdWluZyBzeXN0ZW0gY2FsbHMgd2hpbGUgdGhlDQo+IGRlbGF5LXJlc2NoZWQgYml0
IGlzIHNldC4gSG93ZXZlciwgd2UgbWF5IG5vdCBzdHJpY3RseSBuZWVkIHRvIGhvbm9yDQo+IHRo
ZSBkZWxheS1yZXNjaGVkIGhpbnQgZnJvbSBhIHN5c3RlbSBjYWxsIGNvbnRleHQsIGFzIHRob3Nl
IHdvdWxkDQo+IGJlIGV4cGVjdGVkIHRvIGJlIGVpdGhlciBpbmZyZXF1ZW50IG9yIGEgcG9ydGFi
aWxpdHkgZmFsbGJhY2ssDQo+IHdoaWNoIG1lYW5zIHRoZSBlbmhhbmNlZCBwZXJmb3JtYW5jZSBw
cm92aWRlZCBieSBkZWxheS1yZXNjaGVkDQo+IHJlYWxseSB3b24ndCBtYXR0ZXIuDQo+IA0KPiBB
bm90aGVyIHNjZW5hcmlvIHRvIGtlZXAgaW4gbWluZCBhcmUgcGFnZSBmYXVsdHMgaGFwcGVuaW5n
IHdpdGhpbiBhDQo+IGRlbGF5LXJlc2NoZWQgY3JpdGljYWwgc2VjdGlvbi4gVGhpcyBpcyBhIHNj
ZW5hcmlvIHdoZXJlIHBhZ2UgZmF1bHQNCj4gaGFuZGxpbmcgY2FuIGV4cGxpY2l0bHkgcmVzY2hl
ZHVsZS4gSWYgdGhpcyBoYXBwZW5zLCBJIHN1c3BlY3Qgd2UNCj4gcmVhbGx5IGRvbid0IGNhcmUg
YWJvdXQgdGhlIGRlbGF5LXJlc2NoZWQgaGludCwgYnV0IHdlIHNob3VsZCBjb25zaWRlcg0KPiB3
aGV0aGVyIHRoaXMgaGludCBzaG91bGQgYmUgbGVmdCBhcy1pcyBvciBjbGVhcmVkLg0KPiANCg0K
VGhlcmUgYXJlIG5vIGV4cGxpY2l0IGNoZWNrcyByaWdodCBub3cgdGhhdCBhIHN5c3RlbSBjYWxs
IG9jY3VycmVkIGluIHRoZSBjcml0aWNhbCBzZWN0aW9uLCANCmV4Y2VwdCB1bmRlciBERUJVR19S
U0VRLCB3aGljaCBwcm9iYWJseSB3aWxsIG5vdCBhcHBseSBmb3IgdGhlIGRlbGF5LXJlc2NoZWQg
Y2FzZS4NCiANCkJ1dCB0aGUgcXVlc3Rpb24gd2FzIHNob3VsZCB0aGVyZSBiZSBjaGVja3MgaW1w
bGVtZW50ZWQsIHByb2JhYmx5IG5vdCANCmR1ZSB0byBzY2VuYXJpb3MgeW91IG1lbnRpb25lZCBh
Ym92ZS4NCg0KDQo+IFRob3VnaHRzID8NCj4gDQo+IFRoYW5rcywNCj4gDQo+IE1hdGhpZXUNCj4g
DQo+IC0tIA0KPiBNYXRoaWV1IERlc25veWVycw0KPiBFZmZpY2lPUyBJbmMuDQo+IGh0dHBzOi8v
d3d3LmVmZmljaW9zLmNvbQ0KPiANCg0K

