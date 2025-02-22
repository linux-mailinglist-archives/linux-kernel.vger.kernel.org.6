Return-Path: <linux-kernel+bounces-527475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D30A40BA0
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 21:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46EB43B6956
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 20:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B7E203709;
	Sat, 22 Feb 2025 20:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="Hym+9PDY"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857A2202C39;
	Sat, 22 Feb 2025 20:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740257868; cv=fail; b=buuDbGbS32e4i91bgxXNYUFZvruyOzNV9X7wjsMP/DxFuoXrLaxDJlmrgIBjpD1+EXITAvbn9Ohaa3QlfSgph03j+nfaHR1HbwSiq+TosdJtbCOoB/d1LbbnCB2512eq+LJU7PU/OK93cBnZF8A6I+JyD+hOUW6zYqisRyq1l78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740257868; c=relaxed/simple;
	bh=7XnMkxAqzX0lhXKAvrTLxsRpeF4pmE/zoFCSa7vicr8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=V7TCQzeKAEqNTjhjcIrIAfUnQHczPlkehcP+49lG3P9POYtcyUJ84JnUqMjVW2QVLmwsJUZuqtObDf2I4q5Xb5K8toOuSjFgtj+EbLaWvrJ0wLNa9SJE+Q+DcYR75e1A2/sIGBB1UGsEgX8iXIOHLp7iCW9ZFq4BTw6g/Znubhc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=fail (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=Hym+9PDY reason="signature verification failed"; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51MKo9LD016579;
	Sat, 22 Feb 2025 12:57:18 -0800
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2049.outbound.protection.outlook.com [104.47.58.49])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 44yeykrfua-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 22 Feb 2025 12:57:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a6qtUM/kKFQ2gxGO9yL5FdGNb7cNI3Mr/xbm9b+wFr8ZDH4Z99DppTm4YdXg/gVD0v8otqaMb443LD+P/31vE5nJ/rt75jjqY4YpkRr4EvcGXsGZGoNVgp5JLBslMSzb0kmugPKeBAZggBJAfyeB7POGFJJ+aATDXXeiRk3+4svsljgsiKdQtE9U3q6usuimo4kpARSs0S+truXPkB4ummpz4mn7/pxJGVjkot9Rsnit+h8ltKKSx7DruB1b02u/cyslplxqPn0aa7ZHqy02xyyhG1TiHXELar3dfsqgblyac6fly19CWVtTnSIU8jKKamVCuftVfag/CLyrq1cvjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hQPd7PvTKqhA6s4n24TNfL8QpxgX4OVccQRWTgLj5hQ=;
 b=I+QWp786ivAvhU0hI+5wldaYGWU8PdHgJxdxKpzD59iyZcO7cVxorV5jjuwKicFyYI71rUTVDy3DKUi9gf07fdBCp2Ga2XtUxK3Tkvy0M8fsFDcOYrCs3/HQsKlk1kqL9nZFmmnv6qkJRZ3GyQ+0GzNCTx/Z0j4VZ3nH+NOyuKx5jMMzANqwKd1dGLxs7B+j3mjGN6ldHtbjogWsVMzjGg73v5J1dSY+FFgwiTbHMwP6wKAQVQFTyigCSsKmJaZhc2rc9S0cFs+DAMcONq7xFZgmsnxvJQJXGL2v3dJ9PBxieBVC1X0w0nxzsFtsp90XoLcRpVw5ijJxx43xGlpz6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hQPd7PvTKqhA6s4n24TNfL8QpxgX4OVccQRWTgLj5hQ=;
 b=Hym+9PDYTK5ry/w+4d1KZ2uyNDznmJP4KILVXOUZkDh9GufOgfhhqCBHLXUc33I9zY+Z1q93CvQZx9XYjx/3iPB9LMSdi0IBIAlAwS/w6GQpqtJkhLtv5cd0pv55qRYS0IAVBoISa2HlEBR0fb4svn8LikBPi3+vr1cK57zfD4Q=
Received: from BY3PR18MB4673.namprd18.prod.outlook.com (2603:10b6:a03:3c4::20)
 by SJ0PR18MB4430.namprd18.prod.outlook.com (2603:10b6:a03:303::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.18; Sat, 22 Feb
 2025 20:57:14 +0000
Received: from BY3PR18MB4673.namprd18.prod.outlook.com
 ([fe80::fbd6:a3a:9635:98b5]) by BY3PR18MB4673.namprd18.prod.outlook.com
 ([fe80::fbd6:a3a:9635:98b5%5]) with mapi id 15.20.8466.016; Sat, 22 Feb 2025
 20:57:14 +0000
From: Wilson Ding <dingwei@marvell.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "conor+dt@kernel.org"
	<conor+dt@kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        Sanghoon Lee <salee@marvell.com>,
        Geethasowjanya Akula <gakula@marvell.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: reset: Add Armada8K reset controller
Thread-Topic: [PATCH v2 1/4] dt-bindings: reset: Add Armada8K reset controller
Thread-Index: AQHbhWxZLiQyNPIeNk2TKZdUrH8ckQ==
Date: Sat, 22 Feb 2025 20:57:13 +0000
Message-ID:
 <BY3PR18MB4673F55565B70458E1F3F9A6A7C62@BY3PR18MB4673.namprd18.prod.outlook.com>
References: <20250220232527.882888-1-dingwei@marvell.com>
 <20250220232527.882888-2-dingwei@marvell.com>
 <20250221-icy-flounder-of-potency-ee1a05@krzk-bin>
 <20250221234041.GA387671-robh@kernel.org>
In-Reply-To: <20250221234041.GA387671-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4673:EE_|SJ0PR18MB4430:EE_
x-ms-office365-filtering-correlation-id: d775fec0-9bc8-4c90-d618-08dd53837be1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|13003099007|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NjFHaDZndjZSU2dyZ3oza3FybnNwdHRqcVNYbFdDM215M3l2a2FwUU1oRFJk?=
 =?utf-8?B?b3V6T2NLd3RZd1dXeDc5L1FkMDlwT256MnpGUFM3VGtBRnZGeFdIR1lkRzgy?=
 =?utf-8?B?YjFIQnFpcTZEaVhSbGJyUDRucmJGZklGVzg4WDJqbzUrNDZPcVVpL3BpMmZ2?=
 =?utf-8?B?bFJZRHJuRDJNWElJQUh6VDRhMjk0NkdxVW9Ua3FuN3FHeDQzQ3AvSHRZWGxz?=
 =?utf-8?B?cWpWWTBBMFFUQkJIdlZ2d0dDKy9HY1BvbTBKb0ZJUU84TVpZVDFSNjJRVXZt?=
 =?utf-8?B?MlBFWXJlaW5nRXdGUzlkUmVPSEVQc0lLSlJrazQ2Y3Y4WkNMUVNQaVlNVXNM?=
 =?utf-8?B?ZXpUK01pallhNXhPV1M1Yk41bW5BTC9obWliYXlFQ0VBbW5pRW8wOHl0VnZh?=
 =?utf-8?B?UlRuRVZaTlZldzVzL1VjMVNRaXJIcENNNWF3S0RWRDVqU2ZkcGoxaHd5eHBW?=
 =?utf-8?B?Zm5qM05yMmdIQXJURHBoUVZYUGdCSTlWWVJrNE8yc3pvdUViSnpraU1FbEo5?=
 =?utf-8?B?NXNubHJYa290cG5OeWM5ZXY1K2phbFdpQ3ZQN1VYUWFVaUl1dHBiR2k0SWRh?=
 =?utf-8?B?bUQ4NTJBSm4xR1dmbUF2MjFrNm1YY0N1VStiOWVaeWk1Y2lUL2ZjYVIrVTFn?=
 =?utf-8?B?N2hBcEZJblhwRXZ4NVBDUlFVaWd4WG5CSnBLQ05BTlZERmgyWEcwOEVlT2Z5?=
 =?utf-8?B?ajdoLzFER2g4Tjh2OTdKek1HQVAxTVQxOEhISmdkSGtzbWZ3dDI2R3ljaHBU?=
 =?utf-8?B?Z1NSQnhEQmNTVFZnVVRubDFyQ1NhdjJXeWFMRWJ1VGxkRDBoWTBYcmlFaHBq?=
 =?utf-8?B?WDBvb0NEcUJqQlc0V2dickZDckNXcDgrWkZiaVBHRGptZU80SzIwWlZnd0ZY?=
 =?utf-8?B?TWEvRGszNDkzSzRETElrNGswRytwZmxDMXF1ODZkOGErVS95RUQwZEhNanFi?=
 =?utf-8?B?YW9wMS9IRk51WjVSbUE4ZmkrQ2ZBOXR0UVdwVktiWWRoMThJQnhLNkVZU3lw?=
 =?utf-8?B?MitCdWQyNDllTWJGSFN4Vnltcm1XcGorRkdOb0dWUVRaT0R2UHNMMldsSWdH?=
 =?utf-8?B?NGdjSVhSblgvckdzWlgveDRiSnRlVW0yMnF6d1I2TzkwNDFjWld0allUVUxU?=
 =?utf-8?B?b2xTVXREcUxITGJjN1p6eEZ1M0MzNGNvbjByL1JWditQOG90VTBTWVpUU3o0?=
 =?utf-8?B?Nzl2dE1ReFNCc01WbS9qVkdKeHR1Y3ZwcW9ZSkRHLzl5Y3BMRVRnRFd6UmNi?=
 =?utf-8?B?cHVJcjE3UzgwRk5FL1JzNEZzS3lqTUZKWUNFWFMwSVRzT1pvdkRIVzNtaVVB?=
 =?utf-8?B?WVdWNXMxWllsRVVMTnVZQ3dIUlF5Um1zamlsUnJWMFZpSUl0S1M0RVRiSkli?=
 =?utf-8?B?QWsyYlJIMlBVRjVqMVptMU4raTJabm5TbllnbWFXQ2NZbWVVQmVrd1FYMjFR?=
 =?utf-8?B?UExuVjNJS2VueEdpNzJUb1ZQeVZPc1dxVHE2Zi9ERm1xZkxyenJ6V0tNaDZK?=
 =?utf-8?B?MGw4OExiSXBSaFAzMVJFeE9MMElWYnBJeUYvc1ZlT2piUEJvR2R3a1d1L0RK?=
 =?utf-8?B?K2xzNjFPNXJnOFRXdDFoNm9OUGhKT2dIa09IdzJTYzdZdmdIZFVrTmxiQWpl?=
 =?utf-8?B?ckNGbWFlRXpDSGxyYUErQjB5RHkwRzFLdnpsRzVuNzAzUzVPUkdPNUFQczMr?=
 =?utf-8?B?U0V1cE9ldnEyeUhmVUJvdXE3dHhrWG52SCsvS25xRzlraDBjVWlHZUY1aSt1?=
 =?utf-8?B?eituc0c0dTQ4S0RQODIxejRZVE82dnZGRDZPZFR4TXBib0huUzFDbGppS0xP?=
 =?utf-8?B?L0FmMDF4NVFOVTArWTAxckJvV2FvN0kwcHhBbmNzekJjelBVVmFzVWwrbHNF?=
 =?utf-8?Q?19pCHVl8dwT4F?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR18MB4673.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(13003099007)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?alplL3cydHlQa2IzRUhCRUpDWE1USVppTWFsaTRqcnBsTzVZUXZ5WWpuWXJF?=
 =?utf-8?B?Qk9KajFtaTJiQjNIUDZJMnNjUjVDclBFQ2s1YVdSY1Uyc0YwekxyMGZpRVFP?=
 =?utf-8?B?V1JQcXJsRTQ5WW5LTy90ais3ckJGb1pQeGFsNmdMcVZwL1ZlbmNOSEU0VDJD?=
 =?utf-8?B?cjIzcUNwWnAxWUZGRVlibUdwQTJRM3IrNjBWSDdLZ1p4dGhkR3R5V3hrVDhN?=
 =?utf-8?B?N29nSFhodVB4Rjh2ZkloeHVaUjJ4aEx0R2kzRTJUdmgrYmRza0FLL1BiRXRq?=
 =?utf-8?B?WVVsbXA1TUlvZmQvblo2Z28vdFVDckhHUlMwVkpwc3pLc3FtTEI3SHVvUklC?=
 =?utf-8?B?UWhLcTMzRkUxK3AxSFgwTVNZbVRqRU56U0lrNFhMVnRSb25jYVRDVm5FV1BC?=
 =?utf-8?B?Z2JpN1hCTzRKRXFwY3lsSWNpMXhYdEsyMWo3WFZCdEZpT2xzYzRIZDN5Wlht?=
 =?utf-8?B?MTFHSGJxUGRpMEd1QUpLMXNOb0p2cHhZTWF0a1BIRVkxczJoSFRRMWdROWNX?=
 =?utf-8?B?Yk96ZlVmZnJqcUtGNTc2WXE3T3pPMW85bktNdjYvNFdkKzM3TDdBZlZ1YmRw?=
 =?utf-8?B?M0NCZ0E4RE5xSHR2WUJ5M2hTZjJNK1VLZC9Fd2NGVWJFYWlhU0tGeXJONno2?=
 =?utf-8?B?d0tCdmtXdlR3Q3ppR2VpUlFhakNFZXZqWG53bW1kZWdxQ1RFRW1ObjdYZUVY?=
 =?utf-8?B?Yk1UWkwxaC9RdjZPUWhhTy9jS3FHNTZKNnUxdWJLN3lnbUlBa1R1UHkwaWxa?=
 =?utf-8?B?T3ZCSG5DZFpzaXNTUzNrMHhkTlBRdzFlalRRY1hwd2lvVUZONDdPaHFNclRO?=
 =?utf-8?B?djZTeFNkekoyUy94N1IrTXIxZklFNlI4ZEJwVEpVQTZQN2dRZDVIQVJrcjl4?=
 =?utf-8?B?NmxFQUd1RlhaSFVDMVNjSEt6RTRoWWJUT2szTEVYNktTQUpaUDhGVWcrd0hE?=
 =?utf-8?B?cXJybEU0UVo0K29uS3UyL2lFWEtHdU1oV3NaM1Fvb1RERXN2TkJJSmhkb2tm?=
 =?utf-8?B?ZkFLaDJpblRxUzl6VVZXVStUWjZxbVlFcTE2NWlJdTIxMER0cTlIclFxSnNx?=
 =?utf-8?B?Z01Ud2k4aksyK3BJT0Y5cVRPbXdNNjNQWDU3akRIUUxnY2lrTnhyMXFMenh3?=
 =?utf-8?B?dHFQLzdSR2NITm5EMGNCNS9LODNFN3NHYXFzWmRYZnFvdm85bkdZK290eXZY?=
 =?utf-8?B?RTZJZ1hXMmpnWExIOEJLSGFlMk5jVkRVdVA2OGtuUjBFZzgwWXh1OGpBSHZo?=
 =?utf-8?B?QTBQSkt6OTI3WG0xWlRGV24yejluTTFNbjdYNUdMZng0cXduT0NZQWlSWGV3?=
 =?utf-8?B?NGo4eGdCcmZsTEVWVExsajdrUzNwR2c2Ry9JNnF4aWxhK2VuWW9zZkpabGJT?=
 =?utf-8?B?eW5UMkQ2MDh5SEphUWhMaUhZV2UzeVZocmFNekd3WmM4VVQrRkxQUDZwRkQz?=
 =?utf-8?B?YlBEQXhJWG1YYk5jT3VpdUJxMnJPdkFVeDk4RnRiSWl4bnloODYrbkRzWjhR?=
 =?utf-8?B?c3RuWEgvb1BkQTRCMEhscUgycFJFeUJuY29nck1NYjk3c0JQM1B0bTRIek8w?=
 =?utf-8?B?bGUwWFJIdUpXSjhJWmlrVlpJK0NRSitFbWp1WUJQSkdHV0wyWkdPbXhwOGpX?=
 =?utf-8?B?Zk9PdzByNUJVcmxJK1NHcDU0MHh1NktjQzNIaFVmMVlSazJiSWdNaUk4S0V6?=
 =?utf-8?B?RU5ZYmlGTlNqNVpTdU9ndHRZYnpHVTZqRjFGRDBKVnlhRDhEWlpvMTEzRDNL?=
 =?utf-8?B?bmpMVkpXa0daRFJtUE1MM0pxbWlYdTZBazlFYWJWZ21xdzFMdElaRTUrU09m?=
 =?utf-8?B?VTM0UGNoTzgvS1hCZ0tyYkFTVVlXYVhZK2xnRXROVDZqbTRpTk1Ncit2bEJn?=
 =?utf-8?B?U0U5czdnSzlOQ3dLbkNKaXA3Q1pMVmMzclZLd1ZteERzWGg0MmZhZ09qRlY4?=
 =?utf-8?B?ZXRkVnhLK1NDQnE2d21Dc04yTmlISDBBNUFOL21uN3pCWGIvRE8ya3MyYXRY?=
 =?utf-8?B?VVJXbWpLd0xUNm42N0pKUWduOWFoZ05ORnJzNHdncXpCV0hGNGwyekd3RW9R?=
 =?utf-8?B?L1Z2YUV5WjFBYXRGR3NCVDZ1THNHUG5VbFd6Nno2WHNqQVpYamdvKy9iZlFz?=
 =?utf-8?Q?VPaI=3D?=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4673.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d775fec0-9bc8-4c90-d618-08dd53837be1
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2025 20:57:14.0299
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EsY0KM1hpYmI5KJOiz8MyuOBKM6ZEgyYKPRFUMSsWywEM29PH+wBznRqABpZQuf2Xpa0M5OvnOXs4yaAmYJ4oQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR18MB4430
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: B7ufZx2zJZblnEGWCWkhrUowYnnPq-4C
X-Proofpoint-GUID: B7ufZx2zJZblnEGWCWkhrUowYnnPq-4C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-22_09,2025-02-20_02,2024-11-22_01



> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Friday, February 21, 2025 3:41 PM
> To: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Wilson Ding <dingwei@marvell.com>; linux-kernel@vger.kernel.org;
> devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> andrew@lunn.ch; gregory.clement@bootlin.com;
> sebastian.hesselbarth@gmail.com; krzk+dt@kernel.org; conor+dt@kernel.org;
> p.zabel@pengutronix.de; Sanghoon Lee <salee@marvell.com>;
> Geethasowjanya Akula <gakula@marvell.com>
> Subject: [EXTERNAL] Re: [PATCH v2 1/4] dt-bindings: reset: Add Armada8K
> reset controller
>=20
> On Fri, Feb 21, 2025 at 09:=E2=80=8A46:=E2=80=8A01AM +0100, Krzysztof Koz=
lowski wrote: > On
> Thu, Feb 20, 2025 at 03:=E2=80=8A25:=E2=80=8A24PM -0800, Wilson Ding wrot=
e: > > Add device-
> tree binding documentation for the Armada8K reset driver. > > > > Signed-=
off-
> by:=20
> On Fri, Feb 21, 2025 at 09:46:01AM +0100, Krzysztof Kozlowski wrote:
> > On Thu, Feb 20, 2025 at 03:25:24PM -0800, Wilson Ding wrote:
> > > Add device-tree binding documentation for the Armada8K reset driver.
> > >
> > > Signed-off-by: Wilson Ding <dingwei@marvell.com>
> > > ---
> > >  .../reset/marvell,armada8k-reset.yaml         | 45 +++++++++++++++++=
++
> > >  1 file changed, 45 insertions(+)
> > >  create mode 100644
> > > Documentation/devicetree/bindings/reset/marvell,armada8k-reset.yaml
> > >
> > > diff --git
> > > a/Documentation/devicetree/bindings/reset/marvell,armada8k-reset.yam
> > > l
> > > b/Documentation/devicetree/bindings/reset/marvell,armada8k-reset.yam
> > > l
> > > new file mode 100644
> > > index 000000000000..b9f7f3c24d3c
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/reset/marvell,armada8k-reset
> > > +++ .yaml
> > > @@ -0,0 +1,45 @@
> > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause) # Copyright
> > > +2025 Wilson Ding <dingwei@marvell.com> %YAML 1.2
> > > +---
> > > +$id:
> > > +https://urldefense.proofpoint.com/v2/url?u=3Dhttp-3A__devicetree.org_
> > > +schemas_reset_marvell-2Carmada8k-2Dreset.yaml-
> 23&d=3DDwIBAg&c=3DnKjWec2
> > >
> +b6R0mOyPaz7xtfQ&r=3DsXDQZu4GyqNVDlFUXakSGJl0Dh81ZIPlU26YS4KHGIA
> &m=3DQ8Y
> > >
> +WjAVZaKSaPD0B9Hb3Il6KsiVTSpeB9Br9zI5bqQ9MyW0LQnEdiE2kzdfMRQfa
> &s=3DVRF
> > > +OPAwNVByPfjGNG1IWJt_mAet2LVsQmFVALenV7Ck&e=3D
> > > +$schema:
> > > +https://urldefense.proofpoint.com/v2/url?u=3Dhttp-3A__devicetree.org_
> > > +meta-2Dschemas_core.yaml-
> 23&d=3DDwIBAg&c=3DnKjWec2b6R0mOyPaz7xtfQ&r=3DsXD
> > >
> +QZu4GyqNVDlFUXakSGJl0Dh81ZIPlU26YS4KHGIA&m=3DQ8YWjAVZaKSaPD0B
> 9Hb3Il6K
> > >
> +siVTSpeB9Br9zI5bqQ9MyW0LQnEdiE2kzdfMRQfa&s=3D3F_XMbPCmCHx0pRO
> vv0KP1cZ
> > > +tvjQBFPSBpdty-yVZjY&e=3D
> > > +
> > > +title: Marvell Armada8K reset controller
> > > +
> > > +maintainers:
> > > +  - Wilson Ding <dingwei@marvell.com>
> > > +
> > > +description: The reset controller node must be a sub-node of the
> > > +system
> > > +  controller node on Armada7K/8K or CN913x SoCs.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: marvell,armada8k-reset
> > > +
> > > +  offset:
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +    description: Offset in the register map for the gpio registers
> > > + (in bytes)
> >
> > That's neither correct nor needed. Your device knows ofsset based on
> > the compatible.
>=20
> Or use 'reg'.
>=20
> But really, just add #reset-cells to the parent node. There's no need for=
 a child
> node here. The parent needs a specific compatible though.
>=20

I am not inventing the 'offset' property. I just tried to follow the other =
existing
sub-nodes under the same parent node (system-controller). The mvebu-gpio
driver also uses 'offset' instead of 'reg' for the syscon device (see below=
). But it
seems also not correct from your point of view. Now, I am a bit confused wh=
at
should be the right scheme for the Armada's system-controller, including GP=
IO
and Reset controller. And dt_binding_check complains "system-controller@
440000:  compatible: ['syscon', 'simple-mfd'] is too short". Can you point =
me
any  reference for me to fix these issues.

CP110_LABEL(syscon0): system-controller@440000 {
	compatible =3D "syscon", "simple-mfd";
	reg =3D <0x440000 0x1000>;

	CP110_LABEL(clk): clock {
		compatible =3D "marvell,cp110-clock";
		#clock-cells =3D <2>;
	};

	CP110_LABEL(pinctrl): pinctrl {
		compatible =3D "marvell,armada-8k-cpm-pinctrl";
	};

	CP110_LABEL(gpio1): gpio@100 {
		compatible =3D "marvell,armada-8k-gpio";
		offset =3D <0x100>;
		#gpio-cells =3D <2>;
		...
	};

	CP11X_LABEL(unit_swrst): reset-controller@268 {
		compatible =3D "marvell,armada8k-reset";
		offset =3D <0x268>;
		#reset-cells =3D <1>;
	};

};

> Rob

