Return-Path: <linux-kernel+bounces-558011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C4EA5E062
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 16:32:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60B01189A4CF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 15:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15DF2236A73;
	Wed, 12 Mar 2025 15:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZP5iqRNK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PfiaRiM0"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A8922318
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 15:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741793552; cv=fail; b=QgFVilA8jwEguLMK+DBAJYwtwUYsUa2va2fR5SNN+MtsVx6FSn5I83EYPHqeROsT/2hD24VaBKVCo+FVPYDpu3fWdhSMZtGUrVt1EJ0eJ/O5yCpopiPlyumALn7oiIAsTAMbCFbYCstglJRx/R/NAk3n74cCQoNLW/1s5od3fT8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741793552; c=relaxed/simple;
	bh=gnVpTSioQfn7cVB5uyQwKM7Xk09VwACNRUNajzkMaH8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=q2jmNA75TnsZnWc5NMUzxADwaP0asSVC7fJga15ec58ICw0/yO1kMGIXggGoZQYPzyWAfMQqfur/FiKbkuS8IxkqIQbDk8y01NoBDIfFDW7IBWm6zilR7epEH1zWZOeVjrqANoj0LSMH39Ex7uevh5stDgbdDIf9+cGPSE++0PQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZP5iqRNK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PfiaRiM0; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52CCAusj027978;
	Wed, 12 Mar 2025 15:32:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=FT+erI+ZbcT7iFJxa8tdo7eeJMa7DpBHoTF9+MC2AOY=; b=
	ZP5iqRNKlUup/y3GrUtCbj7wCbIEMCpxSVLwb3rH2RevO2Fy34WfUF7yknHes1Q1
	VKSQ3rZfe+P/zfdgxCQEIi+Ly20HokIrWteu0WS9nZ7mWYeE8XXa5BtH1z6O+xoE
	FxYG2D2bVzCGWSe+cza6VqKDUQl1/BrsWKoVvn0JbQUq9Bvz5ENptearIKgRDoEs
	S/Pm4ROs8zlVe/6x6B3lYEpilYPe0Ta2wAdOxPN4L1fgPHasaKuXrNNV6wy7PGjd
	vQqsmFgeJKu0pINLpp+Kj6JIDSi3juMN6kzgHjn4XXa6Q5bdJgu4IYlVAwgCwXBf
	mxziQMd1BvzlmDX/qpqOSw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45au4dt2f7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Mar 2025 15:32:15 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52CEle2l019563;
	Wed, 12 Mar 2025 15:32:15 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2043.outbound.protection.outlook.com [104.47.73.43])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45atn0nu0d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Mar 2025 15:32:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iJLT1EqclR7qVCEl1u7WfJjq0kcK0dwY4A6XK9FxE7NvedXu5KQe28wbdqa5KmnNAZdlPwuSHIaSIV2IYwOr3rAHIK3jfTRq38lFWfFd5+8HudMhadrg84G05nT5w/H2XvOm+Xv8vSPQD+QTzPJE/TF9ODRZsPxv3ywXuEyP5szxskG4xbzLqnXVS8LiW83vM9ebQ/TVeWasyfMTY6FNWs4AadKGS+2aRAOOxALzpuVd2gROIE20wV/S98nujnLpze9kQ5QgMcIfKHMMWyBa4N+19yMcbQ9qmWSy/I69IeyX40w8Aejr3SOtR0X0CCQhABspiRWqS3/7LJ+RdhbmkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FT+erI+ZbcT7iFJxa8tdo7eeJMa7DpBHoTF9+MC2AOY=;
 b=UFxB49TBgZA2UYVu/H0FkCkwSZydx2K1Bl6GXO9qyVUpZ/p+l7YqfC/R6a73FbYBsLypG98zHUCyhSrJEgZixTD5ymjltGVLtexzlFOB4jEKNDz74kGFdWb3F6PK+sMntPWcs1Vb9P99qR4e9hbr3AAO7+zk4wI3rSYvgGDSlC6JxNxScyaW0a+XPMl/GhAvNqifwkFP9KBM+XFEwyIhe0F93C+KKvffgDs3oGFbeyZGDnpHm8E5e2v1Z4eUNplxwu+GyPM13WMHl6gephXwebKp6uUd2aoq9m3Ykcv4ng+nP48RyZXZ1m05yA29QEblCzMS3I5UEXKgZ1jv+waZaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FT+erI+ZbcT7iFJxa8tdo7eeJMa7DpBHoTF9+MC2AOY=;
 b=PfiaRiM0M+E15/R6swJHp+Gv+MMdub56+CRU+OyI1FVdALlXnxpyo9aeFf2OHxnwWW2fyTh0o8v2FEQblZ6UR5SVXenvP2lLlhnFDrGN+paK6V1SND2m++rHArL18VpRdShcCXqxYAKuJxKCJgRMc2lEvqi+5wee9QQkuDX3dTI=
Received: from BN0PR10MB5030.namprd10.prod.outlook.com (2603:10b6:408:12a::18)
 by CY8PR10MB6826.namprd10.prod.outlook.com (2603:10b6:930:9d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 15:32:12 +0000
Received: from BN0PR10MB5030.namprd10.prod.outlook.com
 ([fe80::44db:1978:3a20:4237]) by BN0PR10MB5030.namprd10.prod.outlook.com
 ([fe80::44db:1978:3a20:4237%7]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 15:32:11 +0000
Message-ID: <e6046eff-0b16-4ae7-a8f5-0f765a7e2836@oracle.com>
Date: Wed, 12 Mar 2025 15:32:04 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] x86/coco/sev: Move SEV SYSFS group to
 /sys/hypervisor/
To: Joerg Roedel <joro@8bytes.org>, x86@kernel.org
Cc: hpa@zytor.com, Tom Lendacky <thomas.lendacky@amd.com>,
        Nikunj A Dadhania <nikunj@amd.com>, Larry.Dewey@amd.com,
        linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
        Juergen Gross <jgross@suse.com>, kirill.shutemov@linux.intel.com,
        alexey.gladkov@intel.com, Joerg Roedel <jroedel@suse.de>
References: <20250312144107.108451-1-joro@8bytes.org>
 <20250312144107.108451-2-joro@8bytes.org>
Content-Language: en-GB
From: Liam Merwick <liam.merwick@oracle.com>
In-Reply-To: <20250312144107.108451-2-joro@8bytes.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P192CA0004.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5da::12) To BN0PR10MB5030.namprd10.prod.outlook.com
 (2603:10b6:408:12a::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5030:EE_|CY8PR10MB6826:EE_
X-MS-Office365-Filtering-Correlation-Id: b3c4fea9-df91-4905-8d75-08dd617b0ee3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cmJPSmxZQ2pMQjBDZGtPTmhSVlhnRWdUZUJNTUdRdjBjVFk4aDFIMms2ZGZl?=
 =?utf-8?B?R0ZxVDFnK3BqTDVsZXJYSnF3V3BXMzhBZFR3Y2JES1RFNE9nWk5UNGpqWm9p?=
 =?utf-8?B?d1dzYnQzK0lrNkdQMEdCTjh1NWNMamd6emtjejArdFFYVGp0WFJhUmlwK0Q1?=
 =?utf-8?B?b2pCbVl5NTZBV2wxc0IzOS9EMjZhQjVzMjdadFh2a0ZON2NwSThqVFB2Q0Vx?=
 =?utf-8?B?Y1pwczY5azQrbmdSNFE3NmdhK3NURit5d1JqenFxMGhtN1VlNTJMWGE0VXJu?=
 =?utf-8?B?MzFDeW0ycXlMWjNVYmVaVUk3OEZUeTBuNVhyQjAwajljMTBicXBrdmdtRWsw?=
 =?utf-8?B?YnJlZkpPRWlMWmtxNUY4c1o5aCtoVWVKbC9XdkZySGd1NW9ucnhrb2pBdjg0?=
 =?utf-8?B?MkRnZ292VzJnM09DTStRSDFBMlBFYnFERjBDbUg0c2k4M1Z5ZzhhVmxqaTRU?=
 =?utf-8?B?QlE1bkljTFVhVDY1RU5kZnAzRlkvUFFQNnpqeVVZbTUreG9sV2ZLS1k3R2VE?=
 =?utf-8?B?d3pRWkNlKy9BZldWVjVXSkg3SjRzS2dkVTlKYWMvc2hYWlg4WVcrd2Z0U3p0?=
 =?utf-8?B?RUZzenVvbTdVTkxzYlh1ZWs1d3R0R2hSSDVIVnFETHNOUHFZM0JBVlRHWitG?=
 =?utf-8?B?K2N1bG1USmRralhvR2l1eHVDdmd1QUw3SFFGTHY3ZmxNZHdzU3ZZQWp1QVRV?=
 =?utf-8?B?TEJRN20xMk5TOFdkaE11M0xZelZPd1JhdmVqWWZlS1lxSWtCV1Arang0Qyty?=
 =?utf-8?B?UVVtdGQvTTE0TktjdUI3cEVtbXZydHk5SVJoM0lvRDRuZ3Z1QnN1dDRCUHMz?=
 =?utf-8?B?YmpwTjhnNjlzWXlyMnpxN0lRbDlGdUlDaURxRi8yWENtb0lpVGlGWFBGRFd1?=
 =?utf-8?B?Z2VqQlE3ci9wbmlzN0R1MGJ4YTIyTTdxbnZKc3hwWDhUTVcySnVFRTBESGgw?=
 =?utf-8?B?dXlsdE5XMTJkOUlFNVlHbXJ4RzFRY3BrVi9zRDE2R1puZGJ2V3MzenVIMmcz?=
 =?utf-8?B?Q1c5YTRtTkhXN2VBSHBLOFBtRFhUQjZnNjZndys0M0cyclhnU1k3aVozRVAr?=
 =?utf-8?B?bmE5aFJCcGMwMXlIYXF3RHRSd1ozSHpaVkZtcms2Zy9uS0J3Tk50d1VYRm16?=
 =?utf-8?B?dVF1MlJrNVVaNGJGTmV3Sld1N2o3TWU3ZzZRUi9tb0dWcllZWWVOYmQ4bFl5?=
 =?utf-8?B?T2MzMWJieEFGTm1VNkNRRFdVb0I0ZUlYV04vUzgzTGJzZkNjZVJVZXVCYVpV?=
 =?utf-8?B?b3RTZDZmZXB0UWtKaEY0R3ZlTEluTjV4ZFdZTFcycjJpb1FsbGNERGxGWXdX?=
 =?utf-8?B?MVFlV3VGRUtocmc2dzhvVm5QNFA3Tjg2ZUYyOFA4Q0hvTGJTRllmNnY4Lzdv?=
 =?utf-8?B?NzhXaFFDRXVwd1c2MVFiV2c5enI1UmFJU3VsMCtrcHUxZk5YNVRqKy8zNWVt?=
 =?utf-8?B?Ry8zS0MyQU11a29jT0wrLytTUDNjVVNpNXBqYkNJeFBDcUo3QmxJdXozUmJj?=
 =?utf-8?B?dklEU21kMU5udHlUemdTcFhvWDZYeEtRNGFFUWpIWVRZdHdRTUhhTzUrMWhV?=
 =?utf-8?B?WXN0anI0Y1UzWitIcU9MQTFKamJCYmk5TVc1K2dYNm50OVJ4VXJGYjFWNjRo?=
 =?utf-8?B?TnovdWtyeHJKY01Vbkk2ZGo3djdpeXlsMVArMGpmeDM0WkZQUS9mRWVGSTJK?=
 =?utf-8?B?azBBUE9JZlJpTi9uSmNHaUI0R3U2R2NmVEFBbjBnQ0NPOGo5cktsczRpWENP?=
 =?utf-8?B?UnVLU2lPWGxJM1FDRjQ2SURRZG1XZ3dlODlWN1FoNDdjTldFV0lHdW1mVDFD?=
 =?utf-8?B?ZDNWVkJOd3pUVGFEWENvMWVsU1BacCs3Y05jd1h2YTY2a2YrSlZ2Uzg5VnJS?=
 =?utf-8?Q?Kz97FMajCfopX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5030.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q2szSzJYWmhRNHpGWHVPRmVVWm9VT1JreHNURDVEWGwrR1F3QXBKTVE2a0lE?=
 =?utf-8?B?dlEzdUt4T255Z1pxT1BmZlQ3dW9HL0lFSTRZRGw0RndlMytXa29uYmxvUUI1?=
 =?utf-8?B?eWJad3pReU9qT2lWNERiRFNoTzdzVXVoelJFVzIzem1BV3FPU3Rqd0tkcXJS?=
 =?utf-8?B?WGJTVlhldllCRlQvYUkrMmhKZlZWSzZJTFlDODBvZGxCWGd4cnJZZTNldUM5?=
 =?utf-8?B?cFErUkQ5SHQ1WE1uVGttamlBSFRXZFA2SU1KaVR4d3k0WkZxUjVjYk1kNXRo?=
 =?utf-8?B?bkVxNWthVUlMQ0FSOEd1akJ6amgzdWYwWjVST1YrQUFzWU9yeVB3U05qekZO?=
 =?utf-8?B?Y3d2THN3YUIramhUTFM0dGQ0TnN2bTB2Rk9VbFJjeDhldGFEOFNGM2lURkhQ?=
 =?utf-8?B?TGZDeVI5cVJ2T2tXWnNTWHhiRHUybzBVcGlhcEExTUlSZDBhSmlEc2tSdit2?=
 =?utf-8?B?WkF0aThFbWFEajV3YmdleXN2WGRCU3lDY0ttSi9QSmZSWFpHRFlnMjd3cEZh?=
 =?utf-8?B?K3ZFUUs2bWwySTZXMGNpSGhnVVpOK1licnRzRFFKbDlwNVFNRHN2aVpMcWhK?=
 =?utf-8?B?YThzREI0Mlc1RUM1NEV3c1QxTFp1UFljVDNWQitoS0tkaGVJN202L0JUbXhz?=
 =?utf-8?B?dURMdXdLYjN5RDhjYWdETUpTUHA4QTczeVJCNDliZDQvNURjYmU3S0x3ZjI2?=
 =?utf-8?B?NzJNK25wMnE2Qk1tdG4yeGZybk03cnBNL0RCMjN3QSthamhiNkhWbFkzK3lO?=
 =?utf-8?B?U2J3UTM3elJocmpnODlaRm5IVjZ2NUpxZ2RBbmVBck1aMTZoZHd5NEp5VHlS?=
 =?utf-8?B?S2FvdDFrRmJ4Rkp1RnI2K1lQb1YxbWJiUGhDNjdsMU9aUzVIUFZ6VzYvdnNQ?=
 =?utf-8?B?K0M4N2kzNm8yc25iVDE5clliNkx5MGdBQm5FOG1PWU5FeUd2enVKTFFOdS9v?=
 =?utf-8?B?aHVWUmU3NGY4YWdhNXp2MTBpcFJhcVR5R3h2c0dsd2FXSUNLNzVGeVZZV3A3?=
 =?utf-8?B?c01CdGUwa2huekx1U1RWZkNnNFU2RzVIc1FuL3FiS1JqN2JNOUcvYk9TcEt0?=
 =?utf-8?B?UkZaNjRzU2VabkkvWmhONWNOaSt6b3lsbFJFQzJTUGg5eEV0dlowMzBrZm9P?=
 =?utf-8?B?aFFpRHlnNTJNb0N0djRHU2IralI4ZUo4SUNERDd3cFNHcDQxTUpDSFZZdEpp?=
 =?utf-8?B?UWJESys5cVlMTXE4NHhlbGZsRGZaaERwWjc2SGRBZ1NNakRxTWdUZjJUREtF?=
 =?utf-8?B?UWNMWU13RzNSRGlpZkFoZnZ5TU5iNUdZcGdRY29zVU45ayt0WTJWREVOT2w1?=
 =?utf-8?B?S0NBajhKb1BHa0UraElXVFFSK0lxTktzYVZoRE1keThJSFNnV1dRRmY1WDFS?=
 =?utf-8?B?LzRNRWpnWm9DRWdhR1lEaTNNK3loN3QzZ3ZQTFZSeDFVSkxKSERETXNRUmln?=
 =?utf-8?B?aFJ1aGI0Z0N4T3BSaWFwWjJ3SjZkMU9GMmtkanAxczFrV2NuV2ZkZ1RLN2Y1?=
 =?utf-8?B?RWtRUmM5d09CVGNHVXlRV0p0cDNjMWFXOUkwMW5DbHhONjd1citxRjNzYW9P?=
 =?utf-8?B?RzA4STNJdTQ0WGVCSTlEdzFIU1QvcFIxRkZiY3RLMEh2dUhWVFM2bWh3b2NR?=
 =?utf-8?B?cTFwbnI1RkRCMzN4c1UrMW5OSEdEVEY4MnYrRjNISkRmR0ZSYTE2NGZXUlBE?=
 =?utf-8?B?czBwTzMraGZySmFrOWI4NlpqUEVzUFdDaTYvRTBIODZUbmthdSs0cmkwTW1K?=
 =?utf-8?B?TTYwVWJFd3VDS2RpZmN1VEd5TmRWR1NtNFNjYkJIdmtmcExqNk44TnRPbkdy?=
 =?utf-8?B?NW0xcmpQZzcvbkZmV1hsSVBpczR5NE1Xd2x6enEweTA2YkdiS3paejFKV1Rs?=
 =?utf-8?B?SEdsWDFyb3dwaE1HWE9ENXVuUVMzUDNaTm1XTlJsT2JYSm8rS0NSNGU5RHhV?=
 =?utf-8?B?a25LRzhtR1JyQ3RRSHpldzRYb2tDdVhxZDl2SDQyTS83dEEyM2JvOWJFNGJi?=
 =?utf-8?B?SmlUOC82clFnL2NUZC9MM3NOV1FIZGxJRFlnRndISkVvaWRiYmRUU3VhWXRL?=
 =?utf-8?B?bEgweVAvUllpd2d4ZzRoNmRzTUorSitKM2hCckIyMzBTeXpBUUpoY3JKUHJH?=
 =?utf-8?B?MHVHWDRjMngxeTI3VVZSU25lc0RUVlVwQnpuY0g4ZE1tK2FnRTJmOGwxanpz?=
 =?utf-8?B?U1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BRWhFiLDRrBdhDfSLvvuBR1Vja5f4MIVs+KSmeprlSIQBiNiT+HHrqsGnC12uUIPr96jW1nCNdFU6bOvI2c7Kl9rltI+PBfiMQqMKkpsWrsDqjDoObxnWeehWPjxYRMQf7CzSgnLPf7F1TkdJYLHZo6HNJLZcpMmXRvuWlBRgErO7urEm6H9+JcU+z7taL12lMDUESac4Hd9aLhkUjfILSs/A5Th8qKqCJuJ/EwHlvOnlZvZ1M3mqgl2eQf1LEfaCDB26etBHdYJoJIalHFRHxRuwcSqYaFDSu9XvgZegzCF/GnpKqwyhl1mZ6Mr5wx/MjJmRZMmHk95Ieg3v0XP9uzaB609ubmYeE+hqcoCRU5vsyR/G8ZNx+GomDYl0sxrwX873Pe3cfYdOwL8jGBf5JtChUyBPTBBNou+mwk4y9zF3FoKB1HLZR6Z8axo2UaX4Zwez8phlPRFKz5YecR9GfpPq8ZNjzw7XcOLT/SBeghoxWAM5EfVmZqy0pEa1gLuJPREosZFdxc02MSnyrpMbB1CnjXw5ntRYope3MgeEqlKJZbry2sT7DxqSIHGUDO7mXB1aqHUT4klIdmdDuB870rS3JIYl5MdwY4md5cA9O4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3c4fea9-df91-4905-8d75-08dd617b0ee3
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5030.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 15:32:11.7046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LRXffRs1N1HuzLPufzjMUXLLnBqsUHPv7z4f5G93FeD8FhtSZLWoki2cbs2NPuJCFaM7jIhoxudMyRGrHXDAVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6826
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-12_05,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503120106
X-Proofpoint-GUID: LxCJi-z_DjEWs3MlZZKcr05FAG-5u1h8
X-Proofpoint-ORIG-GUID: LxCJi-z_DjEWs3MlZZKcr05FAG-5u1h8



On 12/03/2025 14:41, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> Move the SYSFS information about SEV to the /sys/hypervisor/ directory and link
> to it from the old location. The /sys/hypervisor/ hierarchy makes more
> sense for this information, as it is only relevant in a virtualized
> environment and contains values influenced by the hypervisor.
> 
> Signed-off-by: Joerg Roedel <jroedel@suse.de>

one suggestion below but either way,

Reviewed-by: Liam Merwick <liam.merwick@oracle.com>

> ---
>   .../ABI/testing/sysfs-devices-system-cpu      | 11 ++--------
>   Documentation/ABI/testing/sysfs-hypervisor    | 10 +++++++++
>   arch/x86/Kconfig                              |  1 +
>   arch/x86/coco/sev/core.c                      | 21 +++++++++++++------
>   4 files changed, 28 insertions(+), 15 deletions(-)
>   create mode 100644 Documentation/ABI/testing/sysfs-hypervisor
> 
> diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
> index 206079d3bd5b..f056c401a550 100644
> --- a/Documentation/ABI/testing/sysfs-devices-system-cpu
> +++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
> @@ -607,16 +607,9 @@ Description:	Umwait control
>   			  Low order two bits must be zero.
>   
>   What:		/sys/devices/system/cpu/sev
> -		/sys/devices/system/cpu/sev/vmpl
>   Date:		May 2024
> -Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
> -Description:	Secure Encrypted Virtualization (SEV) information
> -
> -		This directory is only present when running as an SEV-SNP guest.
> -
> -		vmpl: Reports the Virtual Machine Privilege Level (VMPL) at which
> -		      the SEV-SNP guest is running.
> -
> +Description:	This symbolic link to /sys/hypervisor/sev/ is only present when
> +		running as an SEV-SNP guest.
>   
>   What:		/sys/devices/system/cpu/svm
>   Date:		August 2019
> diff --git a/Documentation/ABI/testing/sysfs-hypervisor b/Documentation/ABI/testing/sysfs-hypervisor
> new file mode 100644
> index 000000000000..aca8b02c878c
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-hypervisor
> @@ -0,0 +1,10 @@
> +What:		/sys/devices/system/cpu/sev
> +		/sys/devices/system/cpu/sev/vmpl
> +Date:		May 2024
> +Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
> +Description:	Secure Encrypted Virtualization (SEV) information
> +
> +		This directory is only present when running as an SEV-SNP guest.
> +
> +		vmpl: Reports the Virtual Machine Privilege Level (VMPL) at which
> +		      the SEV-SNP guest is running.
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 1665ebaba251..5b717f6ccbbb 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1497,6 +1497,7 @@ config AMD_MEM_ENCRYPT
>   	select X86_MEM_ENCRYPT
>   	select UNACCEPTED_MEMORY
>   	select CRYPTO_LIB_AESGCM
> +	select SYS_HYPERVISOR
>   	help
>   	  Say yes to enable support for the encryption of system memory.
>   	  This requires an AMD processor that supports Secure Memory
> diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
> index 96c7bc698e6b..51a04a19449b 100644
> --- a/arch/x86/coco/sev/core.c
> +++ b/arch/x86/coco/sev/core.c
> @@ -2698,12 +2698,10 @@ static int __init sev_sysfs_init(void)
>   	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
>   		return -ENODEV;
>   
> -	dev_root = bus_get_dev_root(&cpu_subsys);
> -	if (!dev_root)
> -		return -ENODEV;
> -
> -	sev_kobj = kobject_create_and_add("sev", &dev_root->kobj);
> -	put_device(dev_root);
> +	/*
> +	 * Create /sys/hypervisor/sev/ with attributes
> +	 */
> +	sev_kobj = kobject_create_and_add("sev", hypervisor_kobj);

Given hypervisor_kobj is created elsewhere, and the caller of 
hypervisor_init() doesn't check for ENOMEM, would it be worth
adding a check here that it exists before using it?

>   
>   	if (!sev_kobj)
>   		return -ENOMEM;
> @@ -2712,6 +2710,17 @@ static int __init sev_sysfs_init(void)
>   	if (ret)
>   		kobject_put(sev_kobj);
>   
> +	/*
> +	 * Link from /sys/devices/system/cpu/sev to /sys/hypervisor/sev/ for
> +	 * compatibility reasons.
> +	 */
> +	dev_root = bus_get_dev_root(&cpu_subsys);
> +	if (!dev_root)
> +		return -ENODEV;
> +
> +	ret = compat_only_sysfs_link_entry_to_kobj(&dev_root->kobj, hypervisor_kobj, "sev", NULL);
> +	put_device(dev_root);
> +
>   	return ret;
>   }
>   arch_initcall(sev_sysfs_init);


