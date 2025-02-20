Return-Path: <linux-kernel+bounces-524078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F55A3DED7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:39:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BF75189D7D0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D9F1DE4CE;
	Thu, 20 Feb 2025 15:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lWypxNfT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xvNZWit4"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385941B4243
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 15:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740065946; cv=fail; b=LcjdVJa0YNj09P7Li4VCZyhzo7n0J1mGHce7e3YANAfh+lDcAhh55irMZ+sgmDguilt2DU7qDuwC/KFzaq07B0gS7ix+lSaFrNOSUb6iBCR6sHXMBV24bB5nFkmt492N9K2pq7WjA+KnEgU8qGnnfVpPv0TLiey3orb8hp0P63c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740065946; c=relaxed/simple;
	bh=URPGHUKAwnJA8jcqgpmE1ntgspjPK8K+jyqGDbBpfQc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ee0nnbOShe0D7Js6B/qQdhCxGceC0liJErz+QA/ga1BJiSAOJvpLlql7dSqKARePb7J4m68qgbqdeuKNlnulsc9IzdeHVl5AtKO34k/vzUJeekDBJ9+WYhO4xeKzVL4y24jOpQY1/xsHQRcEwN4vcgWRmPkRwOqzrJL5W80uyoE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lWypxNfT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xvNZWit4; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51KFMZDI007043;
	Thu, 20 Feb 2025 15:38:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=L6Hd639uAWy5CyDO6PdR6HzwIQpQut4Wp/DErsXOA3Y=; b=
	lWypxNfTaf+KzxoJyrDf4G215ocmmxrlsInuhrk6L92dPr/MxESg7/4L6EEtz246
	EQOYPi/sG3s4njUq/ec+KBKgtkChBPoPlUOhMLWKI5613CEmD/kN18hDsBZ+c20W
	0pFLsirjtc7LYvKeV2CM3HHd4svH089CuP1uFZVDN0qMbn4GtdcUCU0K9Zj5UzG0
	UcCcpJwwTEk3m3zM7MAIhtGrnkUZWSHoiK0zhpFRw2tjZJSvbywVMewwjuRZLzCo
	WIV7s8Y99K8gKZyihxPoZuZUWf93fQ/MOSnPhiilZVFmeWvElpmxgYOmtSzJy2Fw
	8VBH1/tje1pUzFdyPkuOzQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44w00n4d0t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Feb 2025 15:38:45 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51KFAJKB026196;
	Thu, 20 Feb 2025 15:38:45 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2048.outbound.protection.outlook.com [104.47.55.48])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44w0sqjbar-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Feb 2025 15:38:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r00AbR4y1WONdC8xjTDwmmW3FpWX367OOKwDey2mSkGot59fRbbGtnEvzaVzMm9CDGOOfzlbKBLQ4+cN+C3OP50daSdVlMbGMfEb8dSNCjiOZSIPEsjT7Lf2NF12FCghWbH9QQLjP/VEHrLzbyUvkNtnCINjxhlZn7Cepnf33Hg3Iud9X1u2JPTsoCixcLxeQAyj6dipaJlY9mxVgSCLmMlnMGxz4EBvD3hJuYgH4meWBeYdnh7saglEeU+eQLQOa3EVkZ1kY7w/ReDSyIruEJYkSGrohz922HZRkzPaYWdKG99y1rASCTGiih23lpTxAwkHmJTUk8cPpwn8oxAHnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L6Hd639uAWy5CyDO6PdR6HzwIQpQut4Wp/DErsXOA3Y=;
 b=XSW4NIMufeXBt3Xekz4+Qlkp834BL/1wbQcMG632TzPbDDk9TLMONR48qWuin3c0/BFBY2El9tuMH8HmJSYGVne85CMI4HKEIByJ1Ori8xmvS0ZG750cw5+GXQalW6PHxg0fLXoe4TxbHfCv3hpKLcigLDERSuLWZ6/Tq/sTq29ACjv59m3E380zXve8910OhWpEV5HqYpqSKQjFNzv/+CAr5NVmAu8ri7WZS8Kh5g34CYChRk6TWJwkpkgJ34gqBp2Z28eqUe31MMq7pkCQP1RAWB0oaQ6qg1Jgl9nZxg8LKBzBj8lG0x43J8NcSo3nutNTpaidl9H3YHMkepc0Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L6Hd639uAWy5CyDO6PdR6HzwIQpQut4Wp/DErsXOA3Y=;
 b=xvNZWit4aCIMZtDtiZfueOZ6DQIyKrPatQpyRFO1IAn0ytVE6XqSLMfSuG6OD+K70r1FhiZIJJeiQY1Pv+5ypzLLnF8ZK9XWezM2IycW35msasPS7dwmgJgOpD2VQkBfBJbH+pHtGcuIuK5g9cvGVovfJkTqI4V5stfMQQlLZZk=
Received: from MW5PR10MB5738.namprd10.prod.outlook.com (2603:10b6:303:19b::14)
 by CO1PR10MB4596.namprd10.prod.outlook.com (2603:10b6:303:6f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Thu, 20 Feb
 2025 15:38:43 +0000
Received: from MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::187b:b241:398b:50eb]) by MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::187b:b241:398b:50eb%6]) with mapi id 15.20.8445.020; Thu, 20 Feb 2025
 15:38:41 +0000
Message-ID: <f1c5490e-8d14-416f-bfbc-0041263870f5@oracle.com>
Date: Thu, 20 Feb 2025 09:38:39 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/jfs: cast inactags to s64 to prevent potential
 overflow
To: Rand Deeb <rand.sec96@gmail.com>, jfs-discussion@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Cc: deeb.rand@confident.ru, lvc-project@linuxtesting.org,
        voskresenski.stanislav@confident.ru
References: <20250220094349.1685195-1-rand.sec96@gmail.com>
From: Dave Kleikamp <dave.kleikamp@oracle.com>
Content-Language: en-US
In-Reply-To: <20250220094349.1685195-1-rand.sec96@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR07CA0040.namprd07.prod.outlook.com
 (2603:10b6:610:5b::14) To MW5PR10MB5738.namprd10.prod.outlook.com
 (2603:10b6:303:19b::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5738:EE_|CO1PR10MB4596:EE_
X-MS-Office365-Filtering-Correlation-Id: e5114a5f-a7d3-43da-b2e0-08dd51c4a72d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OFFkZzdPbkdCVmg3UHg5VVhHWDhQUndEVUI5Nno5UXZiSW9pVnRHOFRvWWFJ?=
 =?utf-8?B?VVM1TExlVHdyQnp3VGJIRU00d2dPcjVzN1NWaDJUSU1RanVaSkIwZndRU1V4?=
 =?utf-8?B?OUg2cnVGcnlGWjg4Tmo4RE1VOStFYzdiZEtKNGZwUDkrR0lleWdkQXFQYlMw?=
 =?utf-8?B?VFJ4QjhZaVBUanhjVnA2YkxWcGJrajNRNkJLb0lKQWFCYU9DSUhXaTR4S3BJ?=
 =?utf-8?B?T3dUTnp2UTZVbW5KbDJkL0xRenZDUVR0RlptbGF3c05xK1hoVWg1L09sVEt6?=
 =?utf-8?B?bXNIUXRWRHJHTUdVY1d5ZUZiSU8wemxPcHBRRlk5ZlRHU1ZMNXlOTlo4N3BM?=
 =?utf-8?B?SmozNTVPTCtYSGxoSkNYUWFtOGpIdHJxRHhVVFJSZkg3dk5FUngxZDlmaTZl?=
 =?utf-8?B?cGpLRXd4NVA2c3dIenZRRWxZdjRyUTl0c2VITUZLdTF6NStrWG9pSUxtdHNZ?=
 =?utf-8?B?eG14dEhISUNqdmtNclpkYkJHWGVxY1U1WThPYXpKTjE3b1psMWM5b1dDSUVa?=
 =?utf-8?B?Rmxub0xJL1Rxbk1nUHk4SnpkUVY5VW5TclpDMkZTblBhaVVwS1VLNUErZ2dx?=
 =?utf-8?B?V2pXU2ZDeGtIL0xCZzhNbzk5elJaTXZSU3hnRVBWYWNKTVZZMXc0alNOVkhC?=
 =?utf-8?B?TDdadXJEcVg4cFk2TlBZbm80dVFwakUydlNFMkdZUjhHd3kzWmhHa3ZMVjJa?=
 =?utf-8?B?L2JRMFNCV0QzMVhjd043QTM4QXdZbDkwRjFqcURqZlFxcGY1bW5Yb3g1MVdC?=
 =?utf-8?B?Vi9QUlFac0s4L3dPeFJMZHdMNzIvakwvYXdVNHRHMFpySXFNT25sVytoVUR6?=
 =?utf-8?B?VDVoUGw3V3U0cVMrRWU2TTNuQ3RKNUNVN0FHTHhFU2NMeWY0VWFSTjAyZVpX?=
 =?utf-8?B?cFcvMjROK21CTm9oVHd2WkFHb2VRNWcvWFM2dVA4WkFvckUwZXpvNVdFbWc2?=
 =?utf-8?B?Tk8wQWxkZlRTNHhhdThHbGFXSEJMSXYwcEcvYkZwMEtYOUFqNHIzWmN5WnUx?=
 =?utf-8?B?dWJDRFpOTDEvenBzdnlPcllha1Q4YXZkN3VTVUEySEZnUHhrN1RidTh2TjhI?=
 =?utf-8?B?czNtMS9MU2k2NHE0MEdkYmUxbDJWdStvRnhJUGxlVGU3dllBVzVPV2NIY2FJ?=
 =?utf-8?B?QnNhdHhIN3lJRjFFTGpmNi9HWWJKcFJPTDJvZm4vRzhBcVc3K1NmQUhVQUNP?=
 =?utf-8?B?ZUFLSFJ2eHdOS0hFNTZ5TGJZQnl3UFh2MlBiWkIvbFl5UnlwRDAyTWVEVEtE?=
 =?utf-8?B?K2VzK3hMVnhZV2pYcnJKTVF1ekxPZ3hwWlRUQXFJN1ZWNWF1VytoQlVMMkNO?=
 =?utf-8?B?VFJjWk5hcGJ1UXdxdXA1S0V6Q0w1SGF4K2UvVytpRUl3SEpGTDlBY1RyeXJ1?=
 =?utf-8?B?RnpYZy84ZytYWXErMWN2RlJQS2Vnc2dOVUcvYVB1aEZ0VXBrYjkvV2VhSHRZ?=
 =?utf-8?B?cUoyVFRYcGowbWV4NHp4Z0M5alNPK0wzbUFpc2phazRIdUIyMTNralhOZzBm?=
 =?utf-8?B?dk5PcW1KalNnL29ycGQrL1Jqa0VBR1FOanF4eDh0Y0VLTlFseWJqeHB4bW4z?=
 =?utf-8?B?b3dnL2NDZU1QNkdwRno5Z0tLRHBtSzlOMUxGU1pncjFaRlR0aXJlaTEwb0Vk?=
 =?utf-8?B?TDAwUTJnUEF6cmpTVENjQ0M5ZERtL00rTU1qamVkREhJYlc0L0Z1dVlqZEJ0?=
 =?utf-8?B?QldHajNXc0cyUlg2MVVjbC9HWkJyeWN2R1pXVTEveFNNMFJ0NTFOUDRsTlFq?=
 =?utf-8?B?dDJ1K2xOOVVxOHpKbEpWT0gzeHZxaHV4bnQwNnFuUFRqYWl0OG9DTC9CUUlh?=
 =?utf-8?B?dnNoYzFETXhoZEdrdnZIalEzVGV6djBqTW9tZ1VXMkYwNlpKUGIvYkVZRmxQ?=
 =?utf-8?Q?Ujndq8HimT6JL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5738.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SE9veXl0MlZYTllwK3ZhaFgwNUd1Y3JDd0NoMlk2R2RidXlGWWxJQ2lscEZL?=
 =?utf-8?B?cWJqS0NBaGVGRzZTaVpuZXZyNzFjNG1jcldKSVlhWWxZL2dYdUFOU2xpa3Jr?=
 =?utf-8?B?aXlTcUZqOVhSbFFDc2Z2eXJlT09LdFQ5enFObi9tL2Z1Y0p5TjA5enJrUTdO?=
 =?utf-8?B?YTZzTjZQQm5nQzRSRjMxRnBhdkUzbGJ2NmhucVMyUFhURmY2Z2lCYVdjeDVj?=
 =?utf-8?B?UUZoTEZPYmtxcGE2Yk1qbzJ4eEJHYzJCYXdCTXFQcXFWbjlGdk5BcndMcmRL?=
 =?utf-8?B?aFdLMTZnYVNiYnpuQWM0c1NQOFdmQk50TUJXZ2NvUlVtUGI4Z3FQR0tFKzY5?=
 =?utf-8?B?S0I3Q1pTZy9SZG1TRlRRL2F1VEh4ZFZzNGU3Z3J4anQyeGQ4UTZ2WUxuRDdO?=
 =?utf-8?B?S1RWcGtNVS9FcmYwVEdvRmJBQk5XRXFTM0I4S2xLTlh1K3VGZitiWkxsd3dT?=
 =?utf-8?B?ZUt2a1NwZkxuY3BmcDhVL1B5QXFnczFtNjJuL0tlbDBJU21iN2dWMk5oeUNL?=
 =?utf-8?B?a2I4dTFBaExsQXhaaFdQRjVPU3o4UEN0WmhSVlN0aEhJYjlkK00yMEFHYk9N?=
 =?utf-8?B?MERGWU9tWEtrMjYzY05YYWZwejhocEZnZEdsd09SVFVCNWxYa1l1NGdRK0Zm?=
 =?utf-8?B?WkxOQWVBbWd4ZWNMUUdDV1ltU2k5aUtPUHJkZ1hZOEpFS0tBMHkvNlBPZDQw?=
 =?utf-8?B?VE1FR29nRlE4bXZ3aENSMDhoekYvRCt3anBvbzFVaDIwaHl6ZDIrMXhKNHFB?=
 =?utf-8?B?NTBkWmlFckZtZGJtSFhoZ0VGZlBVOS95cjJ1em1ISmFFS2VwYitJRTFKV1Nu?=
 =?utf-8?B?SHNEQVVnWVZMdGhscFNEMUI3SkRxZkJ5ZTc3aU4reTFESEUwUmE2SWc0MFdu?=
 =?utf-8?B?dnRWeVJmMTByWml5M1ZzczlCVDMzM3ZEWnBtR1NJUzkydFFCN3d3aXdyTHIz?=
 =?utf-8?B?QzlrWTJOZEY5dXNGYVlydVMzaGlvcDFQRytTQUpOdUMwRXpNeHFPU08raU41?=
 =?utf-8?B?NXNRclhwMUY0bjdEWWlKZXhLbUVDa3NRMTVlVVhGQ1ZrRTVjRlUxc0txQkcr?=
 =?utf-8?B?d29rcjRzaytLcThRTURGczFhWktWRWorK1Y5bnN0K1dMSnNOUVFxejA0Tnha?=
 =?utf-8?B?MUhRNDZjZlhzYno0V3ZNeW1MUmMrOCt4ODhxeW1RNzAxU0k3cmpsNHVKZ1R3?=
 =?utf-8?B?VDdJb0xOeVRTS0NSQThDZ1RiK20yOXZIMHVoMVFHdk9Kdkl3TGgwZ2x3dDgz?=
 =?utf-8?B?T1ZWZi8xc2E4eTBTd1JwcEFTWEk1S0ZPblhFbVNEM2F3bjhQaWUrVklIYTR0?=
 =?utf-8?B?RnZFWHUzSVN3MkFHU2Ixams2VFdScVlUSGU2OFJuU0RwNkNnQktVbG5lNXVC?=
 =?utf-8?B?aXVQSDBCMWlOVkZKU05IMkxwMlYzTk1kc0hwY2VvRWRFQnlsejczVUFTaGc3?=
 =?utf-8?B?MXJ1WHI2RTNUOTZ3LzQ0eVBqZDk5dGhZWnBZSEVLeE15QmJuMWRpWEFvSWtx?=
 =?utf-8?B?b3ZYU2RtVzhpY2sxVHljVUpZQ2JKOGhkN3ZZNUwyd0l2L1p2OGJrN3JlNTdN?=
 =?utf-8?B?Mjl2S2dFSFNSUEg3RjVYeTlYZEZYV3RDdWt1QjZiR3VuV1pOQ25HVEl3dFNp?=
 =?utf-8?B?aCtmMzVSSVJqZ0R1NzhBU01nLzd0ZEVBaG5xQVIrNmFMTnJoQVNwK2tRVjdy?=
 =?utf-8?B?Qyt0TDVxaiszWmVnMnRmWnFINDFiNWZoVHZ0U2R0SCtxVVJYRjFXQ0RUTjNY?=
 =?utf-8?B?eXFXVTZmMHB2aXNhV1JpTDIwWXFGU3RTcDNPTXdCak8rc2pTbXhOK1lNcXZr?=
 =?utf-8?B?UTNKZkdCZHBuS3JDNlZ3bXZhVEEwWkM0UFBtNEJSTEhkWkxkZDhOVEp4b0ht?=
 =?utf-8?B?MzhoSnZDTDJKbS9hWEhxWUNSOG9jNXhBRXV4bDgwWCs0ZHF3TUk3bGhOeFZJ?=
 =?utf-8?B?S0ZzUTFxNHN6L0p4V1ZEM0VSTWtYWm1sb2MwSlZuRUxZQnFzNFRtc3RERXgw?=
 =?utf-8?B?bHM3QUExcFNBclhFd1dYczhsZG1PU09tekEwMWVFYi80Rkd3MjNncTdpbHcw?=
 =?utf-8?B?S2NQbDM4V2pCSVRTa0lmUHNKMEJuSlNXNFBwWDd4N2xja0ZBMWpLd1VDdGlJ?=
 =?utf-8?B?T01OelBtZkJRaVhxbzEwYkVBK0JiWE44ZHZ2YmNDWlQ0SnF4RE1Gc09LUlFF?=
 =?utf-8?B?NWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	298hbDu09UY22n0i3sAD+zyLxXYUeVaACSgnm6u6H+xUdeKQ5aW8Ls1me8njpEEr6A4MujfqGBc6U6ed0joQMNp1+VXZ43AFsoGyLJkFTxa8d+pcmjJA/5qM43qb59aipQsy9vINBrX/kVc6t1Zidw4zkCijFY9vher2/F2lnBa1dt7Ce5QvtXCHC5a3R/K9H/T211NC11s1AINyjENPffzxQcH+NLemK6w0hXqV+1i/gfkkk9KNZ1fJoF1RLbfQUMPxdu6vHrzBc62ojKqAE5CwJzGphsT7WDgzk4V+BYIe2RUz8XKnY+lbg8/0HrmsAEntsAibE29yYsF5YmtiTo6+trhJysXhEc9YTt3SApS47YQC32gmd9dNoTfRjbMe5OLccFsOmyNCS0Ulrnw82i4tDzX71XFX/QRJkCVfHBd4MxcKITW5gU8vmtNSu1o/ju2PgKheo/HbUa9AduEGrF3CJw8ey92H/4YWC18TwBTB3s6vvuRYEmQgmP7bSyWqoQrg6O3jV7vLwazRQqCMKzJb/pQcqXmVe82GsHkPn6vvAIVeUzEatiK09Ovp1WiI6zFmOo5RmVbw6q6LAV954GW/Q2Efyq31BllLgjPqsc0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5114a5f-a7d3-43da-b2e0-08dd51c4a72d
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5738.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 15:38:41.8846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xt31fB+McqIDXJoeXSUpoSaCYdWII6EvoZL/r1UWh/k1UbuPcAL87u8Xj8tbDre8xeX7yJzg3hR9bNCq8ZOl1UfsRKo1VDwl7emDylDck64=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4596
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_06,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502200111
X-Proofpoint-ORIG-GUID: 0AuURaw0bruJvyuuy6OWCjfAwyZPOAW6
X-Proofpoint-GUID: 0AuURaw0bruJvyuuy6OWCjfAwyZPOAW6

On 2/20/25 3:43AM, Rand Deeb wrote:
> The expression "inactags << bmp->db_agl2size" in the function
> dbFinalizeBmap() is computed using int operands. Although the
> values (inactags and db_agl2size) are derived from filesystem
> parameters and are usually small, there is a theoretical risk that
> the shift could overflow a 32-bit int if extreme values occur.
> 
> According to the C standard, shifting a signed 32-bit int can lead
> to undefined behavior if the result exceeds its range. In our
> case, an overflow could miscalculate free blocks, potentially
> leading to erroneous filesystem accounting.
> 
> To ensure the arithmetic is performed in 64-bit space, we cast
> "inactags" to s64 before shifting. This defensive fix prevents any
> risk of overflow and complies with kernel coding best practices.

Looks good. I'll add this to jfs-next.

Shaggy

> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Rand Deeb <rand.sec96@gmail.com>
> ---
>   fs/jfs/jfs_dmap.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
> index f9009e4f9ffd..f89f07c9580e 100644
> --- a/fs/jfs/jfs_dmap.c
> +++ b/fs/jfs/jfs_dmap.c
> @@ -3666,8 +3666,8 @@ void dbFinalizeBmap(struct inode *ipbmap)
>   	 * system size is not a multiple of the group size).
>   	 */
>   	inactfree = (inactags && ag_rem) ?
> -	    ((inactags - 1) << bmp->db_agl2size) + ag_rem
> -	    : inactags << bmp->db_agl2size;
> +	    (((s64)inactags - 1) << bmp->db_agl2size) + ag_rem
> +	    : ((s64)inactags << bmp->db_agl2size);
>   
>   	/* determine how many free blocks are in the active
>   	 * allocation groups plus the average number of free blocks


