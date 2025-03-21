Return-Path: <linux-kernel+bounces-571775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6A2A6C21F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 19:08:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E6D63B9DB6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 18:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B1C22E414;
	Fri, 21 Mar 2025 18:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="akxOGM2E"
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A9B1DB366
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 18:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742580483; cv=fail; b=Lr16IEco/JamH3uIFR1nOS/EKuhkhsKWsshf9WJ83qLsZKWQ1vHR18Ur9zHqspvoNuWnXW5IUwaVPK6HbUFZXy1cj3gZSCUG1gPZ2Eoxt51aZhDkBS6uj+IY0EWSVyvxOyFrV1nbmH8iFe+WAfnDd6AbDJ58t4WmMmd2f38RQrE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742580483; c=relaxed/simple;
	bh=0C0Iy/gl90mBbr+gzsaWKEqWoNdmyYxrNqffAM5QS/g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=qlJZcAjVCXe+tQgwPHYz3sw5yq3mkHLDtavfedq9CyxXcE1E9WPefg27tHHvjncX3eKWzQzLhQKV/RDlciOZHud1x4Bcf7fG0/ib0/sYmUyNKdM8x184o8xHdY1gytBZH8gu+dQ0WZ9JUWTcstlIEo+p9gOyZeSGoIss/TtW+2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=akxOGM2E; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52LI7th6006038
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 11:08:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2048-2021-q4; bh=QmOc9BjwVlZ+HFxq6KhIhlnD2DLCj10/cKSPG1teuR8=; b=
	akxOGM2EJ6YSaqpd9jFSCN88LF+Oh9JiUiUwfSfj3WsttaooRMgPNwLprLmb04r8
	EtlnEH0onzYr6g2P1vHprSVadeDO42fHsGq0wiB0tYhl8KZqIWOoH/UYc01bCOv0
	PfvV+51weCJ5Lyh4gmP8bri72q0Wh8Xp5RpeMDxbWA4nrF2wFsdH0SFvCwVDZgKE
	/F96v/AugWRZm3B5gMFbdbXSEhT3taHkR23l+rpOSZbuatyIjcsJHTW68PuMZ8Ck
	uSQwo5Sk/NWAQoUX1n5YCIQaQggZT4MJHPZMIthTNtU0Br0U6d26g95oJMnA45N2
	AT6Q4oKl1DD+nwIr7sMzUw==
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2046.outbound.protection.outlook.com [104.47.70.46])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 45h0fhcn0f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 11:07:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eYUCzwIGa/bCTG5HENPFtEi72i9grKyo49LfY0hqGLoBhP7OX0aSa7pyTrcyGJo6VeQqhUqKATBX90Vnnd/8QWg0y53vzX2eYv59O/QKHXQoa497NOT2ah1lv5JSs5UuhD7hwxoMsep1RFPZoCuwJmMRmAVoJtsXuxpCa415kU9vPvZkG/q95N+lAUZutO/6b4nWchL360RtgcOTT3nDbmyeaUixSnwhYYt58+gvnHb93fmruITvvKSuNrmqezliR0Fz4sU4csoUyr+zO4/re4gtlgrgvLRLgEKLsIPONb8x3h+7PifXd12M0lQQhFKaGK12m4hfn/getkpJFnlsOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zCYGWTfvrmHZXYYE+ZC7Uui7QErP72wOm5/WJUilJ6k=;
 b=PMqaI6goUR1/Zq/ooG7bdqbf+nxRPiFngyEvfVnQPSumSIaSENxBl5sdr2qWRpQ9AEcxWb5CC2esM+TD9po1rS31U1X1chewhr5POWpXS3Islpzfj7ffmD2ay1Yqga9/btsV3cT1xqgesMYTjHt0826kS33vUezIIT9VEdB1/G13zQLlbYl9V+SDMOhTFvdtoIlbxXeOUimTdrt+BOvu58pzS2dJvnbY3O5TYMrqTVTYKaGTskY8g6sPrHfotXFv/neGgWbL343TQMBzZt9Rg2/gHnUNW9S/KnKJckQmYZiRYIuwg3pmGpE/vFxIj6aUGIIJYXikJZDAXmgN1L7Vjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from MW4PR15MB4732.namprd15.prod.outlook.com (2603:10b6:303:10d::15)
 by PH7PR15MB5175.namprd15.prod.outlook.com (2603:10b6:510:13c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Fri, 21 Mar
 2025 18:06:47 +0000
Received: from MW4PR15MB4732.namprd15.prod.outlook.com
 ([fe80::f3ab:533:bb24:3981]) by MW4PR15MB4732.namprd15.prod.outlook.com
 ([fe80::f3ab:533:bb24:3981%5]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 18:06:47 +0000
From: Nick Terrell <terrelln@meta.com>
To: Michael Kelley <mhklinux@outlook.com>
CC: Ingo Molnar <mingo@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        Nick
 Terrell <terrelln@meta.com>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "brgerst@gmail.com" <brgerst@gmail.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: Compile problems w/gcc 9.4.0 in linux-next
Thread-Topic: Compile problems w/gcc 9.4.0 in linux-next
Thread-Index:
 AduZw3CVEeBLGArOR7mAlPxdXuU1qQACZlCAAALC4gAAArDlMAAUVscAAA/WCVAABhwAAA==
Date: Fri, 21 Mar 2025 18:06:47 +0000
Message-ID: <323A7651-9BD8-4C8B-8784-8C9DAEF5FC88@meta.com>
References:
 <SN6PR02MB415723FBCD79365E8D72CA5FD4D82@SN6PR02MB4157.namprd02.prod.outlook.com>
 <CAMj1kXH-awwT99FTaBJqyEbgBoxc20h4LfbzXMP00NQHBs03+A@mail.gmail.com>
 <SN6PR02MB415765C109AF9820DDC3AF0FD4D82@SN6PR02MB4157.namprd02.prod.outlook.com>
 <SN6PR02MB41575C4BA0C467B1C95EEB21D4D82@SN6PR02MB4157.namprd02.prod.outlook.com>
 <Z90XZqJVwuWkarnX@gmail.com>
 <SN6PR02MB4157E2AC0708EB2074302E6FD4DB2@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To:
 <SN6PR02MB4157E2AC0708EB2074302E6FD4DB2@SN6PR02MB4157.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR15MB4732:EE_|PH7PR15MB5175:EE_
x-ms-office365-filtering-correlation-id: d9cf2720-00f7-4cef-650d-08dd68a32563
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?OW5oMUxXM1RkL3B6RkpDWHhuNUxLU1E5WWowM01RanZoM0p0QXJ0OS9mekhI?=
 =?utf-8?B?VnZPWGtyb1N3RkU4ak5MWVpUR0YvcGljNklkWkpTRWx4QTc4VTVMcDNiTkx6?=
 =?utf-8?B?aHhBN1ozYmVjVFFBN21zaU8yTHp0Z3F6dDUyVEV4V3FmY3hSeVNST213SEFK?=
 =?utf-8?B?elhENTQwVmZITzN1Y0JlNEcyY3hQM1VZWDZsam1DcURQd2drL1RaNUlBb2FH?=
 =?utf-8?B?bUJqZnV6TUxOeFNPaC9od2hOQ1QrYXRXUFZRS203QjMrd29ZZWFES0liYndu?=
 =?utf-8?B?SzJmSDN4cys0bVBNTEN4cTBKbWNWOTdqUmluck1RajVsUldUMy8rWDdKdGZi?=
 =?utf-8?B?QjRnYVJ5bm9BWjc5TW9QYXhkYVM5bFVaTFZrOExyVzNmaVlNaTFKU2VRUG9Y?=
 =?utf-8?B?a0MxK2tJN2ZPMGJWTFNOZFJFbUVOYlN4dVAxZ05PcFlKaG5sa0pGS2ovbzdo?=
 =?utf-8?B?b0Erd2NuS1RrMUJvNW5JKy9yWjBKTXJwWVBJSlB1YUNvYk9lYi85emd4R2ZW?=
 =?utf-8?B?QWs4TDVIMEt4WTRGTVJUWHhvRWFSK1JTdkNlNGJTYlllOEpzNzU2bmh3VDJE?=
 =?utf-8?B?SG4xK1F4bURtdzVVOU5vTG8veHQrcXV4VXgvUVZuSm5VYXFaNEZYOW1YNDg0?=
 =?utf-8?B?SDFQMElkb09JNzRPZ0ZHZUF4VlY1MlFYRU9QSzd0dnZjNSt6NFZxTGFBeVNl?=
 =?utf-8?B?RUk5UGkwc3h0eHd2OXRJbjJST2EwR05ITjY4NVYvWEpxbjhKNzZQK3VhRWtm?=
 =?utf-8?B?VnFsM0FaQ0Z6cEgwYU1ObWlPUGtSbnAwUVprTFhFM051eDNnd05wMnYrc2hM?=
 =?utf-8?B?QTNhcXpRNS9vc0VBRU5lRFMwM1J4b1pZNWtTUndxWm1CN0hSQWFxNk84RjBm?=
 =?utf-8?B?WDFDVUFkbmZFV053NzJHSFpYK3BDZy9NNWZueFZQazY0VEdZNDYrMTRhcFFj?=
 =?utf-8?B?SzBHbGtNY0lkSWdMeDB3V25jMGcxODZXZyt3ZEVNRHZqSXQvMjhKeVhBS0d1?=
 =?utf-8?B?WUZhQW50dGJJY2dwSGZ5bW9CbkRya0x3SUs0WWFKYUlaMUZ0WkFNaWIvTXRx?=
 =?utf-8?B?UGZFL1JqSlE5WVgvWkMzOW0xU0U0ekFKdm5vbVR5RklUTUZBT1JjOGl6TEpK?=
 =?utf-8?B?cDlIZ2I4ZGszR1ZlR2RQWnNzSXgyMmhGbmRxR0dwVEhDTWJ2WHB5U2JTZGRJ?=
 =?utf-8?B?cmNpaE9sWnhQaDBqdm1CdHdUdTJWbTREMnQvMzc0NHZDaGlaNVhIT2cvNWJE?=
 =?utf-8?B?b01obDlHR0p4Y1RyZ05mSmgrTUFnTUNDVWdCMXMrTGR3S21naHg4Ly8wWUdV?=
 =?utf-8?B?dEN4Vk9UMDgyN2M5V0JXKyswaWh6OEZhQ0dGRXdnT2haMlVnVFRxR3lTbUV6?=
 =?utf-8?B?b0JMYmFLQ0NBVHhZNGJDQlpycmxibHN0RXVlc1Z3WnQ4MEVmUlpYQWJRb09B?=
 =?utf-8?B?WUh3WkNPRER1Z3JOaks1d2RLQTVMWWg4MTJoVnNyckFWYzloOEJnNVB1MVgv?=
 =?utf-8?B?aTIxVXJVdVlYL0w4REhTcGltRmFQeUMxUHJEVjZQaVBvbmNMdU9oVUoyVXBi?=
 =?utf-8?B?VHFNdFlWU0tJRks5ck50SERGT0tUdnZnYTFxT3prcVhFTUtCMVpUVFIvZEN0?=
 =?utf-8?B?UjFqVWdQSFNyS0oyZTZkVE16dTYyd2tQVVpiOTlySWRWR0NlWGRPb3E0SFlW?=
 =?utf-8?B?VUJkbzg4NkxES1Q1QXZFUVBEamwyaXpPSHg0ZG56K0EvaXZwMjhXaHlOZzZD?=
 =?utf-8?B?OXozc1JGcURLUG5PNkZyL2hGcm5GazVBbktTam5IQ0t5ZUxHcjV6VXVOV2tB?=
 =?utf-8?B?QkQrTlBhVFBHNWZnZ3FEQTg0NjhPQm53dFZ5Ly95V3RPYkZBWU9ra2g1QUxD?=
 =?utf-8?B?dmZkK29LRXZhZExpZU9iMFRqbzZwZGQ2RjBZTUt3bUQ1U1VZbWdYTFlpTVBR?=
 =?utf-8?Q?k4Sh7AWNV9I0kvEhLnro2a4MzhcO7kXD?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4732.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Ymh2MnZjVmdlY3pOdXNXQnE3ZlFUSzVRTHljSVg0cGU1TkUzUGN2V21LU3BP?=
 =?utf-8?B?SXhOa0J4em1OS0I3TTdjOGs2TVQ5KzM3SFBNb3hDSjJRMVNZTFE4bXIvOEJL?=
 =?utf-8?B?bW1xSmNoa1pKMkw3NzY5RGl4dSsyWHZjSmFJV3RqMVNKclp4MlJzblJ2ZFEx?=
 =?utf-8?B?Y0lwU2I1ZzRaajhpZGhiaDg4aDhsRU9kMFRQZEM5TktnRWhVL20ybXVVUC94?=
 =?utf-8?B?WUpGNWkyWXFtbDlOTjF3M3FJUVpzUjZ0QzdSN096bi9oNVg0cGYwVDFsb1Nr?=
 =?utf-8?B?cUhPd2xTcUZURFlIdG5GYkZXR3Y1U3RCdDNETWZuTnZ0S0NxdXdETjJnZzJp?=
 =?utf-8?B?Um9XY3RYS1p5NG0vZlpReTUxY0dhdFBWcE41NnpneDFZcDVBbmtWTU1mV3o4?=
 =?utf-8?B?NVRqZFhRN0x0dk9rV0R1cGgrUVN2Uk5HSkI1NDJWVisreExJRFVBSnNNc3FE?=
 =?utf-8?B?SVBnbWxZb2daeDZyMWxXRlozR3kraVhYTjlYVWk2bkp2RHhCcUdDS3V0M2J0?=
 =?utf-8?B?b21LZUlPdVN2Rm1HZ0VkUU55Q2p6OGVkdTJjYzVnUlpsZEJoODYxQUxtb2Y4?=
 =?utf-8?B?OEtYUEpKVGFYejdIT3FHdlNoWlY0eWFSMzFsVUQ2b2tyckU5NHA0dDZqdElE?=
 =?utf-8?B?cm54bXBVS2lqR1U0VUF3VHFta2huV2NQK3dTQk5JdFFZUHZaMUNDUHBFZnpC?=
 =?utf-8?B?K3hKMWdBOGdVY21LQVRNQTVsVGhtU2dJeDRxSlQyOVVxbnJhUnI2V01BMkpI?=
 =?utf-8?B?Y1VQbFV1Z2orclUrbXY1bi96RmEybXdYanducjVNNkx5dWdnaG01c3BQcS9B?=
 =?utf-8?B?T2dvQzNBRVNhQjZ2YmxRMXNvNXE0VzBHazdDVHZ6RzhIV01xaHFKcWpxcnBE?=
 =?utf-8?B?MlRKVUdRQjkzNlpCcXg1Q0o0Q0xPNTNPZldKR0pmTkg0OE1KYmRYa1hNQWhD?=
 =?utf-8?B?Z2k4Y1owR2pteGFzMVY2Wi9nUS94TFlSYTdKZk5jYXhEVXhzTlliUW9IMmJE?=
 =?utf-8?B?WEM1cjlxeTZvaDk5ZHp2YTJ3QnEzd3dya1V4dnpTN05kL05QL1BrUHBXcWxo?=
 =?utf-8?B?VHZwRzlpaS9oOUFIaGtwNGdjcmgxN2dwYVdBK3N3SHF2WUQxV0hXVnY5ZGx4?=
 =?utf-8?B?Y00yaGhEbEhUcFRtWnhXYUE4NFFNcXpNdDBVNlN6NE91OEtIWGxSSHpXKzFR?=
 =?utf-8?B?T0lhRUloNDBJcCtDcUpYcEpUVmhhZTNjd2k0Um9yQTBaTWovUi9sRkpxRFht?=
 =?utf-8?B?eGZ2YmZNQnZNNG44Nm9xZHNPZk9qSHFLa3ladEZ5dDBFWUIwWk9LNjUvSmVK?=
 =?utf-8?B?dVRJeXpCa1FUMFQrbThNVUl1WUhQVUlqSlNqZU52ZFpGc2JoYVlHYkxIT1Ns?=
 =?utf-8?B?NFQrcm5oRk4yS0dPYitRVG9GNGpIVlVDb3FmR2s2Y1p3dDUvS1I4SlVnZFln?=
 =?utf-8?B?TEFMdXBOVFU1dHB1dU9NRDdvdUdhRm9NeDNSZERmQkdLbG5CTE9Dd20rdGF2?=
 =?utf-8?B?bVZwRUcvZzJPcW5LdzlkeGZZN0xUZTl3dHdvYm11S3g5SjdGZEQ4dktaSVIv?=
 =?utf-8?B?aVd0Y3hSS3V1ampab01GN08wSkF6Q2QrZjllTk13UUc2VTEySUh0V21IQVpE?=
 =?utf-8?B?YzNXb2N1MGY1b3AxZ2RCUklJancxSjZHYmNMeGRoT2o3akM0M3IxY0tXalEr?=
 =?utf-8?B?ZkFpL2ErYysyRUIwMGlNUzI3aE1PamFpZWlwOHJueFF3TEhOY05RckVuS3lQ?=
 =?utf-8?B?OGJ0alc5NEE2MXpRVDk1TlNRSTlCNkRYWFBsZ2hnVzMxelV2WXd1eGJVMHVZ?=
 =?utf-8?B?a2Fsc1ZYYUE4NGxCeEpFbnNJQ1EzWVAzMEFlOXphWmljWEZLcXlZUlFSK3hj?=
 =?utf-8?B?TUVuc3lvNkd3SUFEVW5ZRVhVSkZ2bGx6TVQ1SC9DYktkekduQjRrTEFzNXNy?=
 =?utf-8?B?SUxSTWZ5TnltRVpCZlRRWjB0aG1ud2V2bmVGZDVGQzdqLzRVS2g1UkE5bFkv?=
 =?utf-8?B?ZVE1MWZkR1lkTm1zY0NIRENkSHl0NjV5dXJFVnFWRnBaUXBkTWU5c1ppb0N2?=
 =?utf-8?B?YVl4WW1KU1VvWG5HMnFlVkFKWENQQTdGd1p1cDBhZzh5TG1XZWExb1VsYzhM?=
 =?utf-8?B?TmVuSTJzU2Jhd2pyTTNicHJ0bkhtSEdFYWR3QVdZVFg3ZDUxZzZIK3M4RkpT?=
 =?utf-8?Q?hS+HDfs7Vts+NEH4lUwr/fA=3D?=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4732.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9cf2720-00f7-4cef-650d-08dd68a32563
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2025 18:06:47.2639
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xikQk//17kM+nPXIsASAget96lnebhjZi51ZaPm7+DlmsuYaQWY6n5b+dIjC1fLPnxoPW1C18ZzALHL6H2p+jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR15MB5175
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-ID: <FEAA340B4F67684DA31BFCAF89D0B09C@namprd15.prod.outlook.com>
X-Proofpoint-GUID: ixwm3Pb-tIT0W18HeOmVHCsZsTT4IhjE
X-Proofpoint-ORIG-GUID: ixwm3Pb-tIT0W18HeOmVHCsZsTT4IhjE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-21_05,2025-03-21_01,2024-11-22_01



> On Mar 21, 2025, at 8:16=E2=80=AFAM, Michael Kelley <mhklinux@outlook.com=
> wrote:
>=20
> >=20
> From: Ingo Molnar <mingo@kernel.org> Sent: Friday, March 21, 2025 12:38 AM
>>=20
>> * Michael Kelley <mhklinux@outlook.com> wrote:
>>=20
>>>> What are your thoughts as maintainers of lib/zstd?
>>>=20
>>> FYI, the same segfault occurs with gcc 10.5. The problem is fixed
>>> in gcc 11.4.
>>=20
>> So the patch below would work this around on GCC9 and GCC10?
>=20
> I've confirmed that the patch gives a clean compile with gcc 9.4.
>=20
> Note that I confirmed yesterday that the gcc problem is fixed with
> 11.4. I don't know about earlier gcc 11 minor versions. Lemme see
> if I can get the original gcc 11 release and try that to confirm that
> your patch has the right version cutoff.

Thanks for the report & proposed fix!

If you can test gcc-11.0, that would be great, otherwise we could just
cut off at (__GNUC__ >=3D 12 || (__GNUC__ =3D=3D 11 && __GNUC_MINOR__ >=3D =
4))

I am preparing the zstd-v1.5.7 update, and I will pull a patch that fixes t=
his into my tree.
If someone wants to submit a patch I'll pull that, otherwise I can submit o=
ne later today.

Best,
Nick Terrell

> Michael =20
>=20
>>=20
>> Thanks,
>>=20
>> Ingo
>>=20
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D>
>> lib/zstd/common/portability_macros.h | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/lib/zstd/common/portability_macros.h b/lib/zstd/common/port=
ability_macros.h
>> index 0e3b2c0a527d..0dde8bf56595 100644
>> --- a/lib/zstd/common/portability_macros.h
>> +++ b/lib/zstd/common/portability_macros.h
>> @@ -55,7 +55,7 @@
>> #ifndef DYNAMIC_BMI2
>>   #if ((defined(__clang__) && __has_attribute(__target__)) \
>>       || (defined(__GNUC__) \
>> -          && (__GNUC__ >=3D 5 || (__GNUC__ =3D=3D 4 && __GNUC_MINOR__ >=
=3D 8)))) \
>> +          && (__GNUC__ >=3D 11))) \
>>       && (defined(__x86_64__) || defined(_M_X64)) \
>>       && !defined(__BMI2__)
>>   #  define DYNAMIC_BMI2 1
>=20


