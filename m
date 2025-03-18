Return-Path: <linux-kernel+bounces-566496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64329A678C6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 17:12:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F4DE188650E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 16:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30AA20FABA;
	Tue, 18 Mar 2025 16:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KiEHXjcM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ob5fXbFZ"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A153820D4FA
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 16:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742314355; cv=fail; b=RdpL8p3bS9D2HIMvrWJHsZ3U5jTdTWSrUy4/x5dwk6TT+8X5458A5A19Mv8GhjRg67gVBlR4PvPj8ZiOB7s071s4tAwT/frb7WyUrY+HkEMaV8jN6fJlVt63HOXfSMKcaot9H0yUFLDfUfY1bZEJEVLmjOd+9lqLFvhUzl1+FLM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742314355; c=relaxed/simple;
	bh=GWI8xEgjdljECxHfpkb7bQSZuEc6ccYqAmr2dn71Ncs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mJgTVTLnxCvBZxyZbtnPtYKeCLbiuCJQh28Kkx7M++7ZkY6fCbZLz52lmMfEuH/5wdUQ0znmi/ZcjxaSn666pRhsMzqX0VpOiNTeh6OSsxLr94Qdx80EKvSbmCQFAW57/UOAemnriFgUEb3uGijMAWIpkmWDCPAcSMwALpQACsA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KiEHXjcM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ob5fXbFZ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52IEfoUA001467;
	Tue, 18 Mar 2025 16:10:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=GWI8xEgjdljECxHfpkb7bQSZuEc6ccYqAmr2dn71Ncs=; b=
	KiEHXjcMiaicNJgd+/u6hta7T40TXptOpU+8iDHKS9LnWaSXugoAZ8tspo40SsJk
	a47pFDX1IeQcmanWrlc6byd38xZIPy86hdc9wlmRaXSoefpJmjDbizrNRT06BFuD
	7bqz5iUVXYP8ip2zx/48xtzy46t7tGI2i4TtsZwSnCS38kUhB1L8g7ApUiU5hxoX
	wfhr6zrtCs21w0CD5XgPacSU/oL/1ZqPNZSi+qJAObDLfRzifquUfFNbLxurCkvD
	XLzQSIpwtefub5DCuJjYpPOEkPrYKghdliwmHsmgeywx9sqEtpt5NEowAqtKmQWr
	2nUk33eVldeuffxqZ5qnOg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d1s8nkyw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Mar 2025 16:10:12 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52IFK806028759;
	Tue, 18 Mar 2025 16:10:11 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2047.outbound.protection.outlook.com [104.47.51.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45dxddky59-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Mar 2025 16:10:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i+2b/c95XYVOfTaHCBKig8QTan8/8ge6pb3QMtkNof/mAnrMXN1Jpq/jnHbiEkGzj7i01cmjg6CofvQMb5ydxgi2wAZf5hZwbdYv2GRJw5Ly5fohA3wMxx6mEGhH9quGuPbDQVOYdY4G8jb6HhbFs2wWsmEa9vT/v6fw8sdnCUwpprOaB9GRfz285K1TRYmGEKW9nfhpPwS95pkBLY3fZzvpb/vFOILrO/gJxzVZPkHC8rgL2TP3YcKCD6jhntH6wk5ch2W4iguGBmPvwW0emMVmAlFn2FqFqudlLBU3Kp/l0jD11MIi5vcsHwPykwWgIoitCoP51ZCY91hthtNLxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GWI8xEgjdljECxHfpkb7bQSZuEc6ccYqAmr2dn71Ncs=;
 b=inAQMzYuKTT7b3t6aR3XPhmD8n+YjKrd21jYf0tZg25PCmNxcV1L4bmOqw+LtVj/DVTqtmhJLxHiYhdDFbUtIQNZFEitkv9TNHuIAqWZF2Mn5gdJm4thjEQxsIu1GGT+luYSsxWytnoP1VCn9PkqukqSsQyrC4/0fTGaGzGTxb2YW8HxY+1bvs317o3bAOHwLrT1N0yb+540sOEl/82JFc/3Vs9Hv9OT6rVQzYgRXZypUnLRZ1QAlAeME1o46zLPCBtRI4oiuODVsPLdMfo8nttTvmEapGeoE+dBnUT8pvIvxyHHTDkF7AJzmnKyCFe1G0DW4LnpO1rgKBgG5/UFFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GWI8xEgjdljECxHfpkb7bQSZuEc6ccYqAmr2dn71Ncs=;
 b=ob5fXbFZyDbqLo20UlM2S4ICKsy4ccheFBHXKlCE1QcOTO05/KcnNtIofQkwJlmNP8EKrm3IBiPp4welefxSnDJZrURAlJMyCXX9o+VwvLsJff24TzmWVOXZBoFVs/p+9iuvBKqWy7kHFXGWtSibLOH9/Yv9TJ37b6+sspzdb7s=
Received: from IA1PR10MB7309.namprd10.prod.outlook.com (2603:10b6:208:3fe::13)
 by MN2PR10MB4157.namprd10.prod.outlook.com (2603:10b6:208:1dc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Tue, 18 Mar
 2025 16:10:09 +0000
Received: from IA1PR10MB7309.namprd10.prod.outlook.com
 ([fe80::818c:4ed2:2a1a:757a]) by IA1PR10MB7309.namprd10.prod.outlook.com
 ([fe80::818c:4ed2:2a1a:757a%6]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 16:10:09 +0000
From: Prakash Sangappa <prakash.sangappa@oracle.com>
To: Steven Rostedt <rostedt@goodmis.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>
Subject: Re: [PATCH 0/2] Scheduler time extension
Thread-Topic: [PATCH 0/2] Scheduler time extension
Thread-Index: AQHbf0Q2OR3YDnbdnE2tu2zJcXVlQrNLvDkAgC2FogA=
Date: Tue, 18 Mar 2025 16:10:09 +0000
Message-ID: <821926D8-ABED-4B66-9E2D-39594DB82FA1@oracle.com>
References: <20250215005414.224409-1-prakash.sangappa@oracle.com>
 <20250217120000.5ae1201a@gandalf.local.home>
In-Reply-To: <20250217120000.5ae1201a@gandalf.local.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3826.400.131.1.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR10MB7309:EE_|MN2PR10MB4157:EE_
x-ms-office365-filtering-correlation-id: c2d0aeb3-691f-4525-8bd5-08dd66375af7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TmNoUkpMZktHeUViSnkvRmxrN09Yek9WNjNoT1hDb0FRZG03RFhGR3EzeGl1?=
 =?utf-8?B?Nmpxbnp4Q3VuWVNzYTRoVEtveUFWNmlrRVRzTE5lWGYzSUd1VERwNWZ3SkVO?=
 =?utf-8?B?Umt1SnhyK2dQZ1NUQVYzcDNwTS9aRVIrT0hFdVF3L2phbnpac1h1aURScnQ3?=
 =?utf-8?B?aGR6MG14NDZic25EMy9sSXF1NktKUFJUbktaWU1iZGMzVWxjc2RieThpdWda?=
 =?utf-8?B?K1Q1eGdWOEs1eDZwRi9yNURiUlgybUw0ZWpZbWVsdlNOYktUS0tVSFk4S0VF?=
 =?utf-8?B?bVpJdkpoZkFPSUs3YWZ3ek43SzE3emJwWW5VZXQvaWZ5M0JxaTdFNmFBbTIr?=
 =?utf-8?B?bXFyOHBMS2dGYlB5bnhtd2FlR1I4cU9yWnlEZ2JnMmJHVytlK1kzNjRYeXNT?=
 =?utf-8?B?WW1NelNRQkcyR1dWVjBXS084WVJQM25BVlF4c1JxRDVWK0RZbUxteTFkMlRl?=
 =?utf-8?B?aHNWa3p6bUJHK2VOd3ZTYVkrMmM2cUVGeVc2V0lXd1RNZXQwdkV1UWRQL0Mx?=
 =?utf-8?B?aEhkQnVrMGk0QjVacFMwYkpPdDhuTVArelBydHdsSnFISjRSTGdVU1MyekVy?=
 =?utf-8?B?NGFRUWdEWURCa0xockxkb1NyelQvbkRqMDJIbTd1QmlTSGk0N2daTWk0V0Zi?=
 =?utf-8?B?RmZRZGtmT1pxdEF2T3FBUW9wNFRkbmRxMmxHWlgwT0xNdWNSUnlpK094TmJY?=
 =?utf-8?B?WjFrTWxRTFlhQlJTNVlIL3B4MEQrbGdCSFVMYmpjMU5QdVNFditGUi9tSGta?=
 =?utf-8?B?MTNTOGNDSTl5aWpBRTFxT09WYjBycUIwUFpTVlJnbEJWVmNPUlMvSDZsaFJi?=
 =?utf-8?B?SDV3czRqUWc1NVp6OHhPY1lzbGc4NmMyOWpzVFJkNUd1MW0zN3lJWVJnRkFO?=
 =?utf-8?B?eXY0WDkydUc3V0VvYi9NWXkxV0kyN2ZVcTVFdFJQdjkrZTdmSDg5UjJkaUwx?=
 =?utf-8?B?bnQzczZaeUE5cWYweUZhVWlXMTJyYjFUMWpYUmJ3eFk0b01nT2puWDZlT0dr?=
 =?utf-8?B?alBaQjZlTFVVdUhQL2tNTkY4bHVCRFZyWHFoVy85T2x3VFAwNmRrRm15dFZK?=
 =?utf-8?B?WEtnNVFyeUw5aFVSV2VFbER2dVc0TGJyc2o4dFB0NjRqbEFNdmNnYkp6bkVq?=
 =?utf-8?B?SkQyNnFqeVNKWFRSLzhvMkhWajFBT3BteGd4ZCtUbEw2d2xWdGQrR1JKQ0pU?=
 =?utf-8?B?anV1RitrR3ZJZ3RTYWVBRCtyaERIcklaa3Z0WVppODhBWkZ3M0M5MEJ5bVBy?=
 =?utf-8?B?SitaUEJlZHFvbDluMVN2ekNXN2VzSlhNWm9KaVJSU1RvNkRNRnY4cVoyRkcy?=
 =?utf-8?B?MmxlN1dsYXhqOXA0bUgrWWl1eFZWb212YTJzaGkyUE1sNVYrS0tkV1BTWDVW?=
 =?utf-8?B?OWJxQ2tIMFIxZFZzVTNKZjRkckJVVmpBQnJKNWpQbGNhWjVFYkRERXRIZnkv?=
 =?utf-8?B?NFFYTjlZUDRYZTVPeTZwK2Y1b01rMG54THdES3RBa2tjendadUNMeDMyd1Bn?=
 =?utf-8?B?U1ZYSnRYS2lndDFjU2pMV3hVZUQvdU43NjFlbHpJaVNleWQwYjRzU3dSRDZv?=
 =?utf-8?B?VDdZaGZZWFppbW0yVWVCSHZReFFEa01mZmpUWXQrZWloQmxFcnoxMFBtS1Jt?=
 =?utf-8?B?OVpuTmhJVHRwODhSeUg1VWtFcDZxelJkQ3djV0JzV2RYUmFGU3piaU4rem9J?=
 =?utf-8?B?Wm94RkZna0lrQjBYSjQ1YkpOOU9aVm1sWDMzSjlkQTNheXk4TWE1dStxVzNG?=
 =?utf-8?B?eWRLNmNFd0o1WHRNVjJybDJSakxIbnJ1aXFDUzBFV1pQdW9XVkR0MGloSm1O?=
 =?utf-8?B?NmI0ckNWLzgrODB3M0JoL0pYaWJLb2ZvS2ZnNWlMbis1R1lQcW9lVDcrMEZu?=
 =?utf-8?B?L1AyVk5QK1pFVE9jU1pxYzIrNmxTaVJockZRVTBLdnVoT2VNYSs5c1MvMFZU?=
 =?utf-8?B?SlQ1OEZtcEJTaVRWbWovSDdNNTRNN1pBRHFmalkrUi9pMDRCRTh3bzgyRXZC?=
 =?utf-8?B?T0ZGTTRrcyt3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7309.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MkhCbGNVcXY5VG9tYXdmcGNGTWdLR0I0RGFCNFhsVFVNdmRGckloUk54VjQ2?=
 =?utf-8?B?VFh3aXJWcjNoc1poLzRqdVZsYXprdSt2WHBvNVZyNjkwd3QwODd1NEdhWXIx?=
 =?utf-8?B?NXd1eXp5eVEyVTBaZFY4NVhQclRIelVhOTh0Y1NBL3BvbUxFUHdvdCtYdDBh?=
 =?utf-8?B?T2hwSjZIdGcrY2I1V3FEVkZ2b1p6SWZUTENiUmdLeHZySFpPelFGQ3JiWjlD?=
 =?utf-8?B?TlVRNWFnYkhERmoxS2ZPTmcvU3dTRFV2dUtBK0FWa2RNMEJKUEJveDBpSFds?=
 =?utf-8?B?dGNkbGxPYTJLMDZBbCtya04zeFF5aXVmcW1TMFd2eW9FZzBTUS9lZXdZNW1y?=
 =?utf-8?B?Y0RnRHkyVTIxbXNPYnVQbmJSK1drWUJpSzZraE5LZG1yYU9JRXZGSUM2WjRo?=
 =?utf-8?B?bEp0SzhZVU9Mcm4vTUwxRy8wNGtpMXJLTEJmVU5LYU9EelgydGJvSVV1alpS?=
 =?utf-8?B?WlFkQ0oxV1VDLy82aTZvbW5hdzdlU3IzbHJkZEx0TENDV3dDT00yWFZWcFZ3?=
 =?utf-8?B?S0U1ekhRVDVmVUgyeFFwS1NCUzRkZ0ozbmp3QWx5WjFnSlN3ZmhkeFhxdklW?=
 =?utf-8?B?b29NYnI4S1FzVWFldEQ3K1BwWm83bXZCQ2VPaURhOVZZRFZqV2g3ZENhUjg0?=
 =?utf-8?B?U1ZxTVlhNXZOVzFUS0FxZWlEOCszQTMyUTYzeFV2SE9UampCVDlpdHpHK3ht?=
 =?utf-8?B?NTVmMmgvSmdxSS8reXlBNHpucW1LQ0hsRVMxOVZDam9sejhRUXhkQS9JWmNC?=
 =?utf-8?B?OGREVVk4WWFSTHRvTkVYT01GM09weUR4VElTMnd3L3plRjY4MTlOcGphUGR5?=
 =?utf-8?B?cCtTei9SSUEwdHFadlYxTFROKzd4MEhzeUMxRXlFV1RpZkMveDg3dEhtUFc0?=
 =?utf-8?B?dERZNExMMzNBV2QyRDJqV1Jsam4vYkYvSmxleG1ENVJJRldxVzJIOG9wenI0?=
 =?utf-8?B?Y2Z1SURoTnpyUVFpb0pJWW9sRXBKYmVSaDVMSnBQR3MrVkFmTUx0V3dXZVg4?=
 =?utf-8?B?UTFha3ZWbmwvQkI0bHFCMzdwL1NyemM3VDdoWlpnUitESHFpVk9YL3Iwdi9K?=
 =?utf-8?B?Qi83TW5wZjkvSm00NEtlZHlieGlaVUhYUkxUQjFNak53YmQwVlRqd3EyN2JH?=
 =?utf-8?B?U0tBVXA5S1RjZTZoajllcUw0MWFDZGhlbXFUeStBYTZKSjNBdEtnZnRGQ1pD?=
 =?utf-8?B?bFR3QUhWbUFpTnZlc2NVOWZ6RVBSbmx2THd5eWNWWFBOUG9QOFM5bTU5bWFD?=
 =?utf-8?B?eWhIR3hHWTZNUmZnNHNaT0g4Vk0zbzRRbGlmZHdvZTFHa3pzYkVLSzR0WHpK?=
 =?utf-8?B?M2dLclV5VDU4bUJwellGajlYV3hWOEkwWDc1aEVLb2dEbytZaEQrZlJwSFBq?=
 =?utf-8?B?RG40Q3dKVkRDbFA4bWJidkFueVMwd2Q1YS9jSktGNWpJUDRJMmdUcllkNExi?=
 =?utf-8?B?OEF1bnFlQnFmVXpCOHNZVldBTnZWaUdqczBvOEhqM2k1STBzVDBYdHpubFZF?=
 =?utf-8?B?MTFkdzdUUVk0WUp3enNkOE1zMkpHWHh3Rm1rTnBLV1MvYm9LZTBsSHlUeG9o?=
 =?utf-8?B?TlRGSS85cno4eFlMMjVDMWdYanhoVHUvVGVxVUZmODBGeVd2Rkg5N3VETWVk?=
 =?utf-8?B?TFNGa1VnNlloOCsvYVVIZ3l0SVQxTlAxb1hQcHFjRS9wQ3NydUswT1pwNnlt?=
 =?utf-8?B?TlJZcnlJTlFjK3NOYlRqV1BCazBjT1RlLzd4UEN5bkR3bGFKYktESEFJNVlx?=
 =?utf-8?B?Zngvd1BLN2x0c3hIS014Q0pGSmtCYU1Hd2NFYmExMkdZUW5ocUxwWWRseFJD?=
 =?utf-8?B?bnp6NTlnaDNwY1BQT3JRR2Jma1BCcThTSUJmaW4wTE9mMm13WGJwN3RabUpP?=
 =?utf-8?B?UjZrOGN2M0FlSGhuczhRODJJTlVFNzJsVHhYcDQxUndxaW50U1EyQkhWUjlm?=
 =?utf-8?B?ZW9nMWZBNHRFSEtyakh3SkkwZzZrT21mUjdDSkVFUHVvMERoVXRaaHZkSzBj?=
 =?utf-8?B?NlNCcWJwckNFdlk3b2s2MnZJTjBVSmVFd05rSTZPdW1DaGtObUxiZnNqcGxH?=
 =?utf-8?B?ZHpJRnh0VERBMVAwZ1JZc21INXd3UXRQTzhvY3JidEFxc0VVc0xXSjlQSjlQ?=
 =?utf-8?B?L1RoY2Zpc1I0aDJqY0lyR3JaZ3JVTGZhYjFnN3NWTGk1RDQyb1I3bXljQTBk?=
 =?utf-8?Q?Tv1JS77MmWj046LGKEdga9g=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DDCC2802E3DBDA429498A3B66ED856BF@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	X84OHiaL5Mleo8o2QumrvHOpUSkOaaR29clTHMnptvdVDDOUAAnt9tVbw6LW/5l/s6fU74s6H2cKsTpG3r6qnRZnfkQWd0Xr4zv+3nUAHpR/iMvlInPhq4mB4sH4T+6PexFfBJd4bArOBads+K9d0pjcXekoemMgfreSrBmDVkwMjyVFuG4xDX+T1TeJHzFzAZLm7GY0OHcgzS/CoeGhDPvss56AxRItbl4+mP+MspjNbCOIM/E9K7jNAmnm0w4ubLk7erg/yPPz0ZkgwbR1FRt2DL1gFat8mY5Lxtkajdj+8W6uZOeYTlSIBBZ7R4dt9lPFcBPFMjgBuvIBkb3iO3m/gsE96ikgJEAjPzju4AGLIANhe3d/DWi4QFi06yWZ75KmvnkfWLPyb0lL/FCePCyHCxqPZFudqBKUx92GYd4AsGAPlPsqAnHxAQUCUO0BzVChtx1naS+RBf85fG+VcPCVPufmFHWYzVnD+8tVuCBj4O2hUr6c3+EZBNUA263Z7ZyjDelC6p3ssbL5cmsaQziNPxZPl2lhtm5eGRVr4c7Z98F9EKWsU55C9Zu3qvE4YDqcnuVWe8x8EQTbzaIuVk7ZwCHcmrhN4iiWujAdZdY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7309.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2d0aeb3-691f-4525-8bd5-08dd66375af7
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2025 16:10:09.1628
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G+JHoqzLtCUCstOgQ2GGNPc2XRw9Cc/3k/DqoDuJ6Rr9ay8+xHSn4jF8MGsYT71EvgsFXBtazTU/KRyRNDG9uZolk8q6vyuc65bgSOtnIBs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4157
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_07,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 bulkscore=0
 adultscore=0 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503180119
X-Proofpoint-ORIG-GUID: aGEV4-XOO5DSofpD1rjAVhEwdfJuYAZI
X-Proofpoint-GUID: aGEV4-XOO5DSofpD1rjAVhEwdfJuYAZI

DQoNCj4gT24gRmViIDE3LCAyMDI1LCBhdCA5OjAw4oCvQU0sIFN0ZXZlbiBSb3N0ZWR0IDxyb3N0
ZWR0QGdvb2RtaXMub3JnPiB3cm90ZToNCj4gDQo+IE9uIFNhdCwgMTUgRmViIDIwMjUgMDA6NTQ6
MTIgKzAwMDANCj4gUHJha2FzaCBTYW5nYXBwYSA8cHJha2FzaC5zYW5nYXBwYUBvcmFjbGUuY29t
PiB3cm90ZToNCj4gDQo+PiBGb2xsb3cgdXAgdG8gZGlzY3Vzc2lvbiBpbiBbMV0sIHBvc3Rpbmcg
dGhlc2UgcGF0Y2hlcy4NCj4+IFRoZXkgYXJlIGJhc2VkIG9uIHVzZSBvZiB0aGUgcmVzdGFydGFi
bGUgc2VxdWVuY2VzKHJzZXEpIGZvciBBUEkuDQo+PiANCj4+IEhvd2V2ZXIsIGN1cnJlbnRseSB0
aGUgZGlzY3Vzc2lvbiBpcyBvbiB0aHJlYWQgWzJdIGluIHJlc3BvbnNlIHRvIHBhdGNoDQo+PiBw
b3N0ZWQgYnkgU3RldmVuLiBNYWlubHkgYWJvdXQgd2hldGhlciB0aGlzIGZlYXR1cmUgc2hvdWxk
IGJlIGFwcGxpY2FibGUNCj4+IG9ubHkgdG8gbm9ybWFsIHRocmVhZHMoU0NIRURfT1RIRVIpIHVu
ZGVyIFBSRUVNUFRfTEFaWSBwcmVlbXB0aW9uIG1vZGVsDQo+PiBvciBrZWVwIGl0IGluZGVwZW5k
ZW50IG9mIHRoZSBwcmVlbXB0aW9uIG1ldGhvZC4NCj4+IA0KPj4gWzFdIGh0dHBzOi8vbG9yZS5r
ZXJuZWwub3JnL2FsbC8yMDI0MTExMzAwMDEyNi45Njc3MTMtMS1wcmFrYXNoLnNhbmdhcHBhQG9y
YWNsZS5jb20vDQo+PiBbMl0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjUwMTMxMjI1
ODM3Ljk3MjIxODIzMkBnb29kbWlzLm9yZy8NCj4gDQo+IEknbSBzdGlsbCAxMDAlIGFnYWluc3Qg
dGhpcyBkZWxheWluZyBhbnkgbm9uIFNDSEVEX09USEVSIHRhc2suDQoNCkhvdyBkbyB3ZSBwcm9j
ZWVkIG9uIHRoaXMgZmVhdHVyZT8gDQpBcmUgd2UgbGVhbmluZyB0b3dhcmRzIGVuYWJsaW5nIHRo
aXMgZmVhdHVyZSBmb3IgU0NIRURfT1RIRVIgb25seSB1bmRlciBQUkVFTVBUX0xBWlk/DQoNCi1Q
cmFrYXNoDQoNCg0KPiANCj4gLS0gU3RldmUNCg0K

