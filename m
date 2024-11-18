Return-Path: <linux-kernel+bounces-413175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 140639D1497
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 16:39:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9602282957
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 15:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7AB12EBE7;
	Mon, 18 Nov 2024 15:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hdINoTFs";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="x7ljZR2y"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8116428EB
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 15:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731944339; cv=fail; b=Int1pAmBo1uGHN1ToaqZ1p96jaJElhbzPVsvnpE5MsJwT8RQ793PA4zWHU9oSuGxmIwIPVNW1p/rPAddg2Kyuoji9Q9chkTRXvIfFnLeNANRltTMy+j9LugS2WIMp9sx7DkK38lzV0LGfitt4c3dSdzxht1txKNbIWbqp5/4g8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731944339; c=relaxed/simple;
	bh=HvB5EdW62bBP0eG+RPXHbf6Yr+Jpbw3i9NXzCvgsDQ0=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mKQYKQyCcxxGrZA89XfdToA9WvI7MzcI7u1FQLoTv6rTWvUqkrnafn64irN5MbOUbhy5TfwLQ7xQMeZz2Fn6o4yErDcYHaIoBDxruyilRYFVK4lEeT+xshz2FQ/YOMT7L9s6jnAcxmEx8K12GLGv/s7IirIIVOQ44b+DMBTAVw0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hdINoTFs; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=x7ljZR2y; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AI8QZ7D009023;
	Mon, 18 Nov 2024 15:38:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=/Hmos1xS+yreCIzEu0mTfsjL7RE/vt9K6KcYQQ/O+jU=; b=
	hdINoTFs24CfisZZAUZLSwWKO5ca541xgr2eLjDCtKEWvGPTwtTror9QULx6r2U+
	X2nzXSZaBMZyKuuRZJ9ZF7qBkC7i5RHXXMXdMpidFQOgexibGp+BFJfGbgMXaUgY
	TxkRTt/dSv4f28iUu+VEZnEuVPJN7f0bbmhhgl/m6c0zW09kQDzzYgf6LtRv7J0H
	jf1Ne6Ed3XNaVqL4nMlr/BTjB4N8ztUU66O5MpWSV5ZH6JNrcz3onn5D+YM/CU9H
	bNKDvGwOlObJzA/ClE/7MwgKuAykgLGHXveYBgRrGdVjpHkMr4mog0tMby7hNSbT
	sWDZbkNVhBEn/nc39Vt6QA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xjaa30fc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Nov 2024 15:38:15 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AIEtWab023381;
	Mon, 18 Nov 2024 15:38:14 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2044.outbound.protection.outlook.com [104.47.55.44])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42xhu7ke7r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Nov 2024 15:38:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K6zu1aeeAe5qr7vNNIBkAzriupWUXApXrvgyEAz7e5/II2qLC7mCPOCBXYz2SU+AOidCnizRLFTYDvF/8RJBsUL92dwQUBhGkfs7lY0KMVDxFQkmkhBjgTCsUkvMdgEntiD+L6Kq4jEggjyk0f19yrUYxhlMhEPpnG1z0X96JAlSttI/HFniVKxGbKmIR0C+K8LsdY1iB5ndfbgQl36EIIgq3rPfP13Lsc7eST1t+e7z81PEe0ZtArk5tTFUn74m8+sZ1+KcgNDBdDm5roNXfjOpFPnEel/yaHVl0zHrZ+ae0sTNziiQ2NGVLomjBK6YojdIL2/eUXQs/whE9ikV9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Hmos1xS+yreCIzEu0mTfsjL7RE/vt9K6KcYQQ/O+jU=;
 b=tL7N1UG1ECh9c5xYCjsKLym2nOoLSjEQr0KJ69MZcQPKCozuSHKx1yokvWSJDnFRIxpbSoxm5OYuSrATDF82RqRJaps+PMLKEnY9oy8erBvgT4V0H2GMSZTwzg/sT752+mhMbHMtoxZ6+6tl3I3hqv+9WdDq7WirUBUVyEa4bm1vNKoHbQqgSqzqgL8kJcvNO/WGBEvNQDhIxls5pWzuiJ7tmIUL6WtKGPo8/fI70kzXVL5PFxb8SuEfIPpY632/8bjcC8flMOb8aLvtEBCflyitDp5YzXKivuA0pDbXPEjscOVPWy8VQXnBb5/PNWZpeETOzkDEhLEFZldx5vw6ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Hmos1xS+yreCIzEu0mTfsjL7RE/vt9K6KcYQQ/O+jU=;
 b=x7ljZR2yojuA4nleXW2UKAtbEBYZAuEcQKEi2LKCVEZQ1gVJzqstkXj2GV3iwTsIjSu1kygVMzMIlfvD3ru9xQILyJd7Hjc5njSYMDp2nn++l/4qu0zQ+QADRqwYuqXOTcuQJR1nrn/z6p/aLfc3inbR+GPRqcCamtXwX09zN2I=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by DS0PR10MB7936.namprd10.prod.outlook.com (2603:10b6:8:1b6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Mon, 18 Nov
 2024 15:38:10 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%6]) with mapi id 15.20.8158.021; Mon, 18 Nov 2024
 15:38:09 +0000
Date: Mon, 18 Nov 2024 10:38:07 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Aleksandr Nogikh <nogikh@google.com>,
        syzbot <syzbot+bc6bfc25a68b7a020ee1@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, jannh@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        lorenzo.stoakes@oracle.com, syzkaller-bugs@googlegroups.com,
        vbabka@suse.cz
Subject: Re: [syzbot] [mm?] general protection fault in mas_store_prealloc
Message-ID: <b7jh32d5xgliuohzkbebyjegtwj44qjfkxnez7lv2cooe3nnds@gw67fqr7jlin>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Aleksandr Nogikh <nogikh@google.com>, syzbot <syzbot+bc6bfc25a68b7a020ee1@syzkaller.appspotmail.com>, 
	akpm@linux-foundation.org, jannh@google.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, lorenzo.stoakes@oracle.com, syzkaller-bugs@googlegroups.com, 
	vbabka@suse.cz
References: <6739c892.050a0220.e1c64.0013.GAE@google.com>
 <ko2rebsgpuw3akuwnsghjsjokhh2m6jshbr2ahsipkyk3txylr@3xpad7pj23in>
 <CANp29Y4YHHXQJ3qyd_bnDT_xz8Hkwpsckj_YM8v0XswyeBuObg@mail.gmail.com>
 <lcxrbfsd2b7prbxecdawlzht3m6knl3kopuomkqelbten5nkud@cyfqy26ndbzb>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <lcxrbfsd2b7prbxecdawlzht3m6knl3kopuomkqelbten5nkud@cyfqy26ndbzb>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0250.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10f::22) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|DS0PR10MB7936:EE_
X-MS-Office365-Filtering-Correlation-Id: b9392c70-3432-431f-7706-08dd07e7014d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T2QvV3JmQVE0c2NWNy85bi9KTy9nclZJMmxabHROanFSODhHUFB0M3NMbzk3?=
 =?utf-8?B?cjRBME5pZGNrUEx5Y2wzdENPMlJwRVUxcmJONThsRW5jOHBCb0J1WVA4alVU?=
 =?utf-8?B?alhRb1k5QW9FNkdiUHVJTkxnMjdDUUROL1lYOFllQXRVckFnWlVGUC9NMkxY?=
 =?utf-8?B?UnRBQnFIakd5clh5Nk9zeDB1cUZWN29qMDJxa2xXUlh6L2h2OVpoMlFLblJG?=
 =?utf-8?B?RG9hSGlmZ3A2Ny9RdXhSZlpDT0tiMkZ4d0ZhUmZTTlFsTG85N2N1WXpudmhR?=
 =?utf-8?B?dGZRaFlKaVdzR0lzQVNzZURlOWRhYVRLM0hPUHFlak8vR3ZaOVoybnJmOUNx?=
 =?utf-8?B?ZnJUVWk5S29nb0M2Z25zYmhYbWZvbkpqendyZHpUY3VvL1RFWmI5Ukc3Z3Np?=
 =?utf-8?B?Yno2OHJ3QjdVZVZRdTRraS9PcGlHbzY3MnkvaGxKMFVLaGR5M1JHanV6YW8r?=
 =?utf-8?B?Q1JxY0ZxMVZzdWozYURsdlpDeHA3YW93emM1UVQvRGREbWRVcUxMSkNkbGIy?=
 =?utf-8?B?WUVxMzZ4ZkdxbFVhQUF1RUJRSzlRMHBXRWZ5dGF3UlRMMkpuWVBDOUpFQi9z?=
 =?utf-8?B?Qk00ZXczejFBM3luSSt3SEovb2lyd0VMYVQzaDlYaGZaelpKL1I2MGRaWi9Q?=
 =?utf-8?B?bGpDeC9UWFc5aGtZMjEwSzNxMnBydDRTTEtIRlkrL05hTDdDVE5KeEZnQ3N3?=
 =?utf-8?B?MmlDK0Y3UHA4ZkpGU2xGZE4xRVlNYVAwVFNxdFNtd29VeFNxdmVKbU9PODlD?=
 =?utf-8?B?ank0ZENpL0hzcHFyUDhiTEx2b3NKV0s4by9RaWJYMWh2ZXM3WkZqdW5BZ3Z1?=
 =?utf-8?B?bnNVZEdFVU1IK2JrQWFuTVBnM0lIQjhoM0YrTW16NGp6N045VkdXYmNreXBs?=
 =?utf-8?B?dkxqam9BVnR6R3FYQlRVWEJ3VzhYaElrYjNzdXJBbE5RSFM5WnNRdllzOVBs?=
 =?utf-8?B?ZlIvbUcrMFdYQWVxOU5VSjF2ZnRYc0VDd2xGUDROK2wydXRoWXZydGFhY3pU?=
 =?utf-8?B?b2hHeFgyQ2ErV09OSlI2N241em9SZHpZa2dSVXlGdlNiNVFrR1lQQ1dwZHJu?=
 =?utf-8?B?cDB4ajhLKy9PRHNKd2dNaFI3eTBHN29RRXN1TGcydUZybHliZjZXQVpUejBj?=
 =?utf-8?B?V0pJbXNRNGZhNU1pODlicU8yY2RrSEZFQ2pYTHZsUHZwcXJ5SlJ4Rk9ubEtJ?=
 =?utf-8?B?clc2bmVYc0IzdjVHTDQ4NDFXRHpiV1VyQWd5cFcyRWRydGNBdnFZNE81ZkVB?=
 =?utf-8?B?WGtVc1FEZ2l2VkhkVXZtcGNuQ245R25xcVhnK1hvSmNzS3RLdHY3cy85QUtj?=
 =?utf-8?B?aS9YbDNUUG5ETFNnMUhYUXc1YVNkM1lqRDVFWDN2S1N6TTJzZ25RM2oxa0kw?=
 =?utf-8?B?eDdGVlRyMFppSlU5Ti9NaDBtMktUREJ0NDBTazM3eGxDYWorUWpIWDJZOEUr?=
 =?utf-8?B?RWpoMTNJQ1NNK252c0VJbDdMK1l0dkxLMGszelNNYjdla3RkdU5WSW84ZjhB?=
 =?utf-8?B?VE92a2lpcUZ2YUVtbmh4WDNwT0pWaWxtczhQQ0JWVG9lNHFBNVZkN1A4ZEwv?=
 =?utf-8?B?aW10TEtSdjhKbGZZZXlZZU1EWlIva1dEZWFyc3JVZ25DS0NVZHE4UENGUTQ4?=
 =?utf-8?B?TStJRXh1Y3ZSTDhJLzZPT2dzQ0w4d1J0WXJiNVpjQm54Ritob3Zrc0hKcjhE?=
 =?utf-8?B?dkwrbzBsVUtqcnJRZ3o3T3NrQSthKzI0dUptMHFQNkZiOWJEUk5kSTdnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YzBoWmc2WXozN3BFQXZWOGxVQU9BNk5sUFhCSUNEdEVuL1p3RHdOb043SHN1?=
 =?utf-8?B?eTlhV0hmczkxTWJMT3NnRmt4UlJOb1oyQUlESnJacFBIcW9sRFpGWEw2QnJ6?=
 =?utf-8?B?TnFIbnd2UXBBT0hDOElyYUtFT0VYaDF3blRNU0ovdVJhUHdVdG1QeGFrN1JP?=
 =?utf-8?B?cjV4L2lLbkU5NU5KRDF0MUVCVERQMittY0R6a05pR3E2UEZCYjFCVUgrYlVt?=
 =?utf-8?B?ZUkwUkdoT1BrZGdwVVNTSnBoc0tUQ1M1dnJhT2VSemxMR0FKSjlnOXVTNGpt?=
 =?utf-8?B?ZzVhUzc2QmVWSkpuL1hrbUVjeUlZVjZCMzRhaGxZR0FzYjk3MTVkM2lkODhx?=
 =?utf-8?B?TG94Y1ROSWsraHJMNWl5bUYvRkNyS2RnVTlUcGtlM0FtM2lGZ0hMOFA4WjFG?=
 =?utf-8?B?T09kdnBFcnVuVjZwYkdqTWd3ekN1NW1WcDBDL0kyUVFzUWlhTDI3a25QZi9F?=
 =?utf-8?B?UzZmdFViaHhiZHlpYjNjUjNzT29uMEhlZFpCS2JUSWs4Vm5KWVFJM0F2blht?=
 =?utf-8?B?QmlnVG9LWVhZbFJ0eDNZT3YxOXBzVkJiMjdYeDdlbXBOSTVHQXk1MlRVNzlG?=
 =?utf-8?B?YXppVW1DYUxFSTEzNzc2RFVCcW16ZERIUmxuTzFZOEFHTDFSTW9UZ1c0VXpp?=
 =?utf-8?B?cjFxSTgyVU0rUmpwZFlxOVZFSEdrbzFLeFdwdk1zTm43MjJnUnpoVndyNDg5?=
 =?utf-8?B?cWhJUDZKdmIrN1pxeTVPQTNsbHBIbmZPdWg3MEZxdWpibS8yQnYrREpuQ2pX?=
 =?utf-8?B?RlpEb05SaExCSEREdmZXWEpFeFJiVW5GakluUWNPOXROR3c5WUkxM3hHaU1t?=
 =?utf-8?B?THlXYWRwcjNxSTliWkZDZmp2TElleWJFMUs4Y2lwMngrb1hhdWg5cXZ3dFpn?=
 =?utf-8?B?bnhsbHhmRlNya2lrNysxOHdBeHNGajZhL3hjVU9OYlVjc25IeXJ0UVlickNq?=
 =?utf-8?B?Zm45ZFk4dDJKVWlBTjlSVXExc0dzTDlwTDByZXdkRGFOYWNqK3N4S0FQQWZK?=
 =?utf-8?B?WFJmR0p2WUN4d1lUdlhJbWlCV255bUtWbkxZMnZ4ZTNKeWd3R0JPNDAvL2c4?=
 =?utf-8?B?T2dSWVZtTGYzZTdLQVMxVGIvQ3BDM00yR0l4cExmeng2bFhLVWJWVmNGbSsv?=
 =?utf-8?B?Q0s4T3M3VHo1b1RuOUJ0cnpFR09CV3Jvb05QaU5yRW4yUlJKK1hWMUNxSG11?=
 =?utf-8?B?eWFrV0w1dXY0YUxzSUkyYm44SW5OaUQ0S2lDcnNvSVJVbWo4RHRNOUU1bld1?=
 =?utf-8?B?dnB3ZHRjcnl5ME5vWnpqTUtFSDkzWHdyN1lmZmVqaXdaL292UnJ1VGlvdzMx?=
 =?utf-8?B?Z2YvdEkwbEFLSXlmQmpUUWZOY3BKcDl3ZDZoUWVPOUpTdXowMjlqMStZVEFF?=
 =?utf-8?B?dHlrc29kaUs0dUQ4b1hiQm9wdVJOelNzVG9Da29ZR1hNaXJPTWJlRmZuUFV3?=
 =?utf-8?B?TzJzMytWallwaExZVHNWVlNMdDVaQUYrTHBPTmM1clc3MWk4NUt4dHJva3Uv?=
 =?utf-8?B?TTlCS3Y0c01mNE9sT3J1ckFDd043blZrS29sb1JndmttVGwwTis1Vi9KekZj?=
 =?utf-8?B?b0U2WUZCck44UlEzcjRHa2JRWUVCYXlJUkxGQTRUTFFWWXozSTl6RG5SNHdE?=
 =?utf-8?B?SWR0N25Lc1RyeStIT0lIM2tZL2JIWGdsdGVqVWJuZXh5dytiL0ZiNWhobnE0?=
 =?utf-8?B?b2YzcGNVN2RqOGFHNzVWOURqYVdLSXM0MTM5S2FLcW9XSS8xVURKVTJ5aWJO?=
 =?utf-8?B?MGxZbkNVNHRla0dsU1N3dm43UEpxeFRwZ2NlQkVEcVlDZUhHVjlqc2xYWTZ3?=
 =?utf-8?B?NXZmejBNeURXckZIeHkzT0l6a0Y3dmZZWjBzZUZSWTh6WG9kMG42b09zVEkw?=
 =?utf-8?B?YjIvUk8wbU9aT0F5WHplYm0yTXIxdDZVcHhVOENkMHc2RkZLc3B4c2I0VmZt?=
 =?utf-8?B?Zko0SGJZQU1OY2RnU0E3MUZsYmd3bkRYWXpVRklydEZqTVZEZ2NtSWxqS3VO?=
 =?utf-8?B?TnpxblIxYzhuVE5xcmJ6dnFYbG5tM2RvLzlmeGt4cGRBRkp2dVNVUHNDUUNR?=
 =?utf-8?B?MFh4TWZObTdZaFZ4YWQzbFlzeUQ1ZFdkaGpDb1Z2Z0s0bGdzcFBvNDJRZWY0?=
 =?utf-8?Q?3JiMzOM3umz+oXz43Va4o7sub?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	O8Jf1cI1dDKD9BlKhyIqCW/SeVcpeQxaqz1Qj3YLxZO+OthdXJXBwpO159bJddWtx+MXW4Qg6RJkyH3aYwM8Rfc+XLrP1Kz7Hzib+2iC7fSY4hwpTlFyHI8O9nmNrEHhz8aaLRMwv8qWkQbkWqR60rqSR001Np0g0MuX3KCpVACBawSZNOkaCorL87V6TFtFyhnF8LXjwlmAc5h9ExO/gB1A/hcVWaUQZNkD2L43dH35kXq9EAj9EJpEdvaJvBvLSenT8XT1ZAfGdmywzKgSDVIyTXsF4z3/IF6O7jNkOBvG206RUgAXtD54NOLmjNgXbH4x5O+dyCdpl83H5/NixhV9XETJdqHXQqyquQl0P0sk+vBuq85Ory1MrjilsI8RGJgTtD9JlB3140FZDQ2nf/vclz7RX7yRFMXlSTu4mBcLf4uWp9jiFB439C2e1SABGZmiaKdwcCazxkAiInDJNODHLD+xbvICieMlYoLGEbw+PmFrkn9HpwHkmYp3bVAP12JVrP3naVeo6LHKKDFvwx09pMCy93/Gq7F8lVjh1OrJ8WVr9FGDSp3Ro5N7nU8vEx+csu71kBo7mUeiXuabhATQKPzfivMGN4HMnr5ook0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9392c70-3432-431f-7706-08dd07e7014d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 15:38:09.8969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I+RgIh7bISHVS81a3zas4u6RzCPrUN6Mbwq7cwLR3zD835XZWtwTPI2rOLs314jEVyZYzG825jWhm7J5RCXJcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7936
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-18_11,2024-11-18_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 phishscore=0 spamscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411180129
X-Proofpoint-ORIG-GUID: sM77_-zTJM0VTE0zXyDGNG-7cW391Nr0
X-Proofpoint-GUID: sM77_-zTJM0VTE0zXyDGNG-7cW391Nr0

* Liam R. Howlett <Liam.Howlett@oracle.com> [241118 10:21]:
> * Aleksandr Nogikh <nogikh@google.com> [241118 08:13]:
> > Hi Liam,
> >=20
> > On Mon, Nov 18, 2024 at 3:49=E2=80=AFAM 'Liam R. Howlett' via syzkaller=
-bugs
> > <syzkaller-bugs@googlegroups.com> wrote:
> > >
> > > * syzbot <syzbot+bc6bfc25a68b7a020ee1@syzkaller.appspotmail.com> [241=
117 05:42]:
> > > > Hello,
> > > >
> > > > syzbot found the following issue on:
> > > >
> > > > HEAD commit:    8e9a54d7181b Merge remote-tracking branch 'iommu/ar=
m/smmu'..
> > > > git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64=
/linux.git for-kernelci
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=3D17b0ace=
8580000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3Da1eb85a=
42cb8ccec
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=3Dbc6bfc25a=
68b7a020ee1
> > > > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils f=
or Debian) 2.40
> > > > userspace arch: arm64
> > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D14752=
1a7980000
> > > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D102e14c=
0580000
> > > >
> > > > Downloadable assets:
> > > > disk image: https://storage.googleapis.com/syzbot-assets/ad658fb4d0=
a2/disk-8e9a54d7.raw.xz
> > > > vmlinux: https://storage.googleapis.com/syzbot-assets/1b7754fa8c67/=
vmlinux-8e9a54d7.xz
> > > > kernel image: https://storage.googleapis.com/syzbot-assets/50315382=
fefb/Image-8e9a54d7.gz.xz
> > > >
> > > > IMPORTANT: if you fix the issue, please add the following tag to th=
e commit:
> > > > Reported-by: syzbot+bc6bfc25a68b7a020ee1@syzkaller.appspotmail.com
> > >
> > > I was unable to get this reproducer to work on my own image, even usi=
ng
> > > the config and compiler specified in the report.  The injection was n=
ot
> > > happening at the same location as the crash reports.

One other point that could have helped find the issue faster (although
I was able to find it pretty fast with your tools already), would be to
include the injection portion in the email.  I was able to find it in
the logs on the dashboard and in my own testing, but if it was included
in the email it'd be nice.

> > >
> > > After using the provided disk (which was tricky), I was able to get i=
t
> > > to work.
> >=20
> > Just in case: did you follow the official syzbot instructions on
> > reproducing the bugs from the attached assets? [1] If yes, what extra
> > information could have made the process simpler for you?
> >=20
> > [1] https://github.com/google/syzkaller/blob/master/docs/syzbot_assets.=
md
>=20
> The instructions on getting the source we need (without adding yet
> another remote and fetching the entire repo) would help, as well as
> booting the kernel.
>=20
> ie: --kernel <file> --append <root=3D...>
>=20
> The missing part for me was that the commit listed was already gone, so
> after Lorenzo responded and restested with code in the repo, I could
> pull the kernel.  Maybe I could have just fetched the ref somehow?
>=20
> So these instructions are good.  I didn't see them in the emails or on
> the dashboard though?
>=20
> Booting my own kernel ended up in panics about the rootfs missing, and
> some fool around with that.
>=20
> >=20
> > > Booting was painfully slow, and makes me wonder if there is a
> > > better way for reproducing issues in the future.
> >=20
> > I guess that unless you run it on an arm64 device with a nested
> > virtualization support, this bug's reproduction will be slow anyway :(
>=20
> The initial boot of arm64 seems to just sit around for a while thinking
> about booting.  My installed vm was using uefi, which turned out to also
> be a pain point.
>=20
> >=20
> > If you recompile the kernel image without CONFIG_KASAN and
> > CONFIG_KCOV, that should speed it up to some degree.
>=20
> I think arm64 on amd64 is just slow, but thanks.  kasan seems necessary
> a lot of the time.
>=20
> Regards,
> Liam

