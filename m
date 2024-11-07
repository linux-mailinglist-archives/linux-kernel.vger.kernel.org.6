Return-Path: <linux-kernel+bounces-400821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4F59C12D0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 00:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C4551F2218D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 23:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD1A1DF72F;
	Thu,  7 Nov 2024 23:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZF9aLMND";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nMuSiys4"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4081F5835
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 23:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731023808; cv=fail; b=n57TBpGzYI9MSFMxMXFQeIsUfFnAUukQ5zVqwNCYnF1SaVZqE8l/nlf8Nh3ou2Z/+8Mln2P4JP8rJo7uNK47JfpcG06d57ioxeHmHNqJ87XfcZBJ6VO3uueGzD2PdzVtCD2bmwx+2TdCzTJpAgylENfMQDwKDodgsJSCn359nsw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731023808; c=relaxed/simple;
	bh=bVQAWPUQlY68hmj50Sl0cMiPweL42WvF7/mNjr1XtlM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HA+h/9EC56DMM0VYepwLyxw3tL6CezjK99Uaf/VmS6nSoWMe/uviNGRJwmPV2Cj3JjW0te1YOcW3QqX2kjTZL4yg1hpqkXVbj+tUTodZFwR5Gs5VhjTI9w4qb7IkkYfpzBWkB096mqgLNmYGI5+8poZ+4iUDOoPk/CmitL1aOvc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZF9aLMND; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nMuSiys4; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7MtaIQ011975;
	Thu, 7 Nov 2024 23:56:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=bVQAWPUQlY68hmj50Sl0cMiPweL42WvF7/mNjr1XtlM=; b=
	ZF9aLMNDGRcIp1aL0+/Rp/7grSuULY1p8AAibH+onFjYisLVeRKHFbkptG6sYz1b
	IQzdWJlcAQbYNBUFTBj+aElpvyJEuXXgE40Uvbka9kOgLVTtymfp9jfZhZGcTauq
	MYq+jn7qEqfHA6fHpn9lklshwhRavRP8VNc36hOOHYkOIy8s5AprUNgcethjVLPm
	olD7USFpC2p1mA8rgB9YqJjjDALod4VuXkZ414/i29I/CSLdzRq672bodLMsBLPV
	kIs6w4F1iqQktrAqryVXkAOBQnMdMXebfMqsDXAYp1XRY22nJnFETyhaAy8MQcSs
	zqsb6olxoISLeX4SJMOpzA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42s6gkg2rh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Nov 2024 23:56:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7NtZkH031469;
	Thu, 7 Nov 2024 23:56:11 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42nahafnmg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Nov 2024 23:56:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IDkzg2cyIMIws48NntcJVhnC9z494baxylAjDdQ+KvX1fVvv5Ye/kxBKLAi0cknzsyX3J7iUVudQ/fi2s4O0/wXoytGx1cOOC68WdwYtkPJdX7YpBRadesMUCtzYP3xFTYqe/WHubxm7GiMYEDnNnuk6IIePKvywccerWir9yTNQnzCfbePF8elE1Lc2ByyN9ib6wt5KUkamY8chn2xc0v8Ws3+hNxiiOcoVO4h3JSEJfzydXtVo045mmFDQFN8OpAEgXDM0TShJs7fqU0Xq8Ec7NNro/a8oPSVDXO2zq7CAn87CBd/ZRu6YNXRMjNkym2rkJGPiWUQ5ZjGE/NeJlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bVQAWPUQlY68hmj50Sl0cMiPweL42WvF7/mNjr1XtlM=;
 b=Oj7pMfFtM3D1x+EyxKb5uX4KBrXa6V4zX7d3x4ErSsD5uMQIhbd5+FeY+v1uezGKjEmC+cvT7m8S7n0shSYQYKBnSUdE5tQiLo5vj3rJ3N/KbWj5b0fSnTkA4WYAPEPibjAvmRxFvQCYJmdzzEKMArmbYku6GMYRmEoC6QEEtNTgxxDDTYVpYY5GT5O3yfXK+XFSWenx13SoyNABrfXp2ocXp/YbptJ51XkYSuF0pDMdvGCAxpr16EGrhw7YPKTbZNXifWzQR/1cHoX3WbA518024SoxVqHuhUxX804euxmR7LYUF4snvU6gIhtPLt01Cxq9vJSGVlfIK4EFtvAX0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bVQAWPUQlY68hmj50Sl0cMiPweL42WvF7/mNjr1XtlM=;
 b=nMuSiys4UK1/rlPVdxXHZKvqDTwpkqUcUsq5zG4t4TEU2WkPC6ariiJfgxlCZk4xQW+YuVmB+8VGCNDLuop+7Z3+f9+woQ3MvgQnFLvo2dWOCU9p44YdydE3u34XFwJnJ5pe0CV1KP2A1b3qlo1YXHg2yJxn46lRcX47ZCkJt2A=
Received: from CY8PR10MB6708.namprd10.prod.outlook.com (2603:10b6:930:94::7)
 by SN4PR10MB5640.namprd10.prod.outlook.com (2603:10b6:806:20b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.21; Thu, 7 Nov
 2024 23:56:09 +0000
Received: from CY8PR10MB6708.namprd10.prod.outlook.com
 ([fe80::3cb6:cdfe:1028:4199]) by CY8PR10MB6708.namprd10.prod.outlook.com
 ([fe80::3cb6:cdfe:1028:4199%5]) with mapi id 15.20.8137.019; Thu, 7 Nov 2024
 23:56:09 +0000
From: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
To: Dave Hansen <dave.hansen@intel.com>
CC: Rudi Horn <rudi.horn@oracle.com>, Thomas Gleixner <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Joe Jin
	<joe.jin@oracle.com>, Jeff Xu <jeffxu@chromium.org>
Subject: Re: [RFC] Restore PKRU to user-defined value after signal handling
Thread-Topic: [RFC] Restore PKRU to user-defined value after signal handling
Thread-Index: AQHbMHpuH5Uv1vq1UUi4UXxKBpQkarKqosSAgAEQLoCAAEdwAIAAhdUA
Date: Thu, 7 Nov 2024 23:56:08 +0000
Message-ID: <4111AC83-7A7C-4268-B294-3AB75C0EC451@oracle.com>
References: <4225E088-6D34-421A-91AA-E3C4A6517EB7@oracle.com>
 <4d484280-3bed-453f-b2f6-0619df4e9914@intel.com>
 <SJ0PR10MB47208C97D877C27053E546DC9C5C2@SJ0PR10MB4720.namprd10.prod.outlook.com>
 <7819c425-5792-4cc5-96aa-9c8b012f1a06@intel.com>
In-Reply-To: <7819c425-5792-4cc5-96aa-9c8b012f1a06@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3776.700.51.11.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR10MB6708:EE_|SN4PR10MB5640:EE_
x-ms-office365-filtering-correlation-id: acc5eeca-81f3-44bf-3537-08dcff87c030
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZUJGZ1hGSzBUYld0KzRlTU1wSDhNUW9QTnJaSkVNYm1ybGNQTVVwWUNJaTZr?=
 =?utf-8?B?ZmRCWCtYNnQxSThYMUpZNi8rN2VBZzNyWlFOb1RXMllyTHFYbHlNVXRVWFZv?=
 =?utf-8?B?T2RWcmhSaElxKytrYkYxRSt2M0ZESlRwY0YyUmNkc2xNZnA5QzlVQyt1MmZn?=
 =?utf-8?B?RFkzbFl5bEF5VmxSbEFJSlJyWHpHdldpS1NsdVByQnlVWVFnQlhDL01DcnNs?=
 =?utf-8?B?Wkl1MkZhTlh1M3p6czVENUVacFd0SHBRRTFuYk4wYjZYUjEwQm5yYk10YnNP?=
 =?utf-8?B?TVpkVDRScGFXMWQyWlg0RXFsbHZmMXZWQ2pZSitLR1VsTG5QVHFRSks4bG5m?=
 =?utf-8?B?djJBQ0xoVzFqUm5na0ZBMjFqcVpaSDZkUGtLRllyN05xdzAvVmlUdkduR25G?=
 =?utf-8?B?aE9vRUV6ZWFoUUFwaEl3d280SE9YbGh5SS8xQ3hRQXQydGdxV1BML2tBbSt1?=
 =?utf-8?B?d09nRDhQZGExSjEzbjdyeFpmM2pXaGw2b3lvRmcxRVp1ODRkMDdQVm5tNERH?=
 =?utf-8?B?SnVVelU3TVZZMFRUajluenNRUGJsaUlCOU90SVZHWVlxVGZ5aVhZdWhLYzJr?=
 =?utf-8?B?anpHVUQwRnpvdHo1SWY4TlhMbHJqMmxheTg0TkhJSk13aWVRUGRwTzhVUFBL?=
 =?utf-8?B?VHRmYzB2Yk9yeDc0WVVtckp2NUpCMGRpMW9Jd0hRNXZuc3Z1RjNhTlRoTUNE?=
 =?utf-8?B?NGVRODJOcUlMek5PRTV4dXF5c1VnbDhSZFByTy9nMG1nWWEyT08ydjhvdWpB?=
 =?utf-8?B?RU9ESnAycitEVXJxS3VycjJyTmVKcG9Yc2hSZTJaZ0dSZDBMQko1N3J4TmJv?=
 =?utf-8?B?eXZqVjgwTDlCNHRDdFpjWTAwY3VmbGtCRS9NdVZ2cC9mN25KYmdwNVQ4TnZV?=
 =?utf-8?B?enh4WWdhVWppSVUwclJ1Z3ptczVNQnZDdnZGOG4zTmZGRUFpWWJ4b0dCMWsv?=
 =?utf-8?B?VHJmS2UxTjdpdWZDVUVDZS85RkJKNnBETXlBd21Tb3BFdWpYb1BJNEZaY0lY?=
 =?utf-8?B?TVEyU2JFbHVqN1h5TFF1enJsSzF2NTVnZGpFaEZsU0NIRWVWayswckdKSmJC?=
 =?utf-8?B?YVlBRStFcmJzNTRBNzFrNmJtclZrWGRMdVFCM0lDV2Z4YnRoK1Y3bUlZQTZn?=
 =?utf-8?B?QWpCdVdhQ3Y1MGh1RURGWDF0QlVudG1MWFk5UVRXbzRSWjlHQjJTOW9xRTlv?=
 =?utf-8?B?YmtFa0lmQzdBS0dVWlJUY3Jzb094QzM3dk1KT0oyUDREWmZMdURUWTJjVzhx?=
 =?utf-8?B?OFV0Yy95QjhFNmF3SVF1Ky9UVDMvdlpCS1NQcWNyUmJGek9mN0RYNVN1WFBF?=
 =?utf-8?B?U2NWNVBtdmxRYVdUM016c3hIL3R0eTZQMlowT1VZUE56MEU5Z3cxTFpFd2Iw?=
 =?utf-8?B?a3ZIaDNOalFHU1ZnUVU4VXpJOFI1UUh4NG9xSjJ5R3NscXpJQ1FXdnNWdWVG?=
 =?utf-8?B?cjV3ekJiOTZTbndJQkhyMGdwSXd1WXMrVHpUWEhRREpNU1B0R0VxY3Y5S3JS?=
 =?utf-8?B?c0htc2hPcVByOUpuN2Rya0VYS0ttR29SRklsRHBYZUFCWWxYRWZIb0VHa1hV?=
 =?utf-8?B?ME8reEF4WHk1TFUrblMrSzh1V1BWeFNOR2FBTFQzVTdrVlpBeGVsenZBN2Yr?=
 =?utf-8?B?OHV2amhmU2ozaHZsUmVHRm1GajJxLzMrWU44a2tESXpYV21DZ21tQTVocXNx?=
 =?utf-8?B?U3A1akp3R0F2VmJ2cnFJZWFnZkFBT0hZTWtDaEF3NGpCZlNRajNITE1aUnN4?=
 =?utf-8?B?dzVDOVMyYjBQRUxsTUR3cDllU2tYTVIrMVEvVzl4ZWVUSktZYWYrTmZObDQr?=
 =?utf-8?Q?bQSTD9iu1xqVJSllNTH/8zbbZdGHN3xoj1ap8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB6708.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cjJ4TVJ5UGNQYUEyQ1o5MTkyNjNoY2JqRlVqLzZYOHo1OHUvSjYvb2Q3ajcw?=
 =?utf-8?B?VHhseXNPTDczV2x0QXRtbFcwZXhRdEF2Y1lBV3poTmZZbjQ0MEJXVkloZ3o1?=
 =?utf-8?B?RjVBajZ3RXZsaC9sdzZoK29ZOEt0TklTMnFjbUd3U1MxRWNLcXVMa1hhcnZI?=
 =?utf-8?B?dWFyblVtSGlSWmJXR1h3THlCZzl4RVo5K2hUVFJydmFyRE1LTHBiU3lmVDY3?=
 =?utf-8?B?cGFLMDg5RXJELzdmczNLR2l2UjR4aG9hc2xKaWQvWjVsSjdsRlU5Q2gwc1dG?=
 =?utf-8?B?Qm9kWFJZTWlBZldVR2ZTMVVCVjNlVHhoMzZTT1I3L0pLVHFsMlNWdHZLSjA0?=
 =?utf-8?B?VDJGUHhRNFJ5cDJCbzNXZTJlWitzcm9BUHpLeHZXYjVWWEJmWjFPVW51VUMy?=
 =?utf-8?B?Mk9HZGRQYmFWcWJGcHVLU2J0TlhQV21UYVRIS25lZDliMURFWUZXS2pxR1g3?=
 =?utf-8?B?dXN1SXNqK1RianY5S1pnVWRWR2w5VWJLNllDYTNLS2FVWkdiTlNxRUI0U3NP?=
 =?utf-8?B?dXhIb3h6dXZwQkdMbHhLMGgrMTNsNHR1RmN5VkFFOGlqWE9xNVliaVdGOFB6?=
 =?utf-8?B?c0x6MGZaNGpobmJkVzFXUEZITmRnSHBHUHNKbzVLclV5cjNTeW9qZGdRZXFG?=
 =?utf-8?B?alQ1eEtySk9uSHZPZStXeno4UXVmUHlDVmNYY2g4bmZzUCtsMWl2YWhPMnY3?=
 =?utf-8?B?aTkwTjhxYnN4NUdYSnIrZ2twK1h4SmJGQWZSYzM3OXFlN0E5bldxL2tnMi9I?=
 =?utf-8?B?N05vYzgyTThOZytXV3h4eUh5NzJyOWFtVVlNZDB5V09QaHo3ZE5PT2ZpbjBp?=
 =?utf-8?B?SmpVbGRVMTZ4SmJob1VidXVFbXgzQzhWV2Vyb2JnVWhhQjFLbHVvMUEwR2VW?=
 =?utf-8?B?S0Q4bkxrbVhhcmNSSE1KS0hoSkl0VkV4bEtUQmxHdUI1TWFGMUFLWlhhUGhP?=
 =?utf-8?B?RWUyR3dOeUxvSWc1eDl6ekVPanVGWWJFTWp4YzVwT0E2alBZZFZxRVlkVDZq?=
 =?utf-8?B?ZndmK0ppOWU2ZnkwQ205MWJJYm10czhZZVd4L1l6YUNCbXdETERsb2VWYmkr?=
 =?utf-8?B?NVZwS0F3SEY1T0ZPSjcxWXdBNDg5NTg4cTc5Nm84dFZkVUpLLy9nNHZVTm5B?=
 =?utf-8?B?VFFLeUd6VDVSRDZIQktYTUR0NEMrM3krNmFzOTJjSkczaCt6TVFWTmFsT0NI?=
 =?utf-8?B?RzBLVFZnTStOVlZneHBrbXg5UjdEYkV1ZDNYb005ZFZtTW8xT3RPMy9NdFpE?=
 =?utf-8?B?bjlBR0VxTUFyb3l2WEQ3WW1LSFBNTlRJRUJ0NTVBbno1TmtwUUhnMTFGRkZN?=
 =?utf-8?B?NXd2ZEY5Rkg1cW9OYmRtejJGclROeHc4dGhzUmdEeVRjSHhzWGdib1BmNHhK?=
 =?utf-8?B?U3AwMmNyRzRwNGdiamZiRURDRlF5RnErb3Z6WDcrcit3L2hPRlRGTE40aXNU?=
 =?utf-8?B?cC95cDRsNll4QWtHekRDN1owUTR0eUxNZHlLd1BZOXJlTnlGajRGbVFTdWdY?=
 =?utf-8?B?ZnB2eGMxUktHcjVCMDhFQjJ3SC9qeXYxN1lVN3hzSUpicFlFbHVsTlV0ZTBN?=
 =?utf-8?B?VWZjdFFDck9NWk9VeStWSjVyLy9QNGtRRk1CTzJ0MVV1aTNoRzIxZmdnTnZK?=
 =?utf-8?B?N3VXNWRIYnpKTG5UVGRlUTBrT0FmMnlyK2VNUnFub01WZlVUaURFMjdrYkFw?=
 =?utf-8?B?bHhpZ1RBNXBaUU13YmJwVE1hWld5bjRrcDg2VVdUOHdwbEFLM1h1RWNwVUl5?=
 =?utf-8?B?ZCt5c2lETjRrYWtneDMyWDZMMUVRb2cyR01ZMDMrMStYb3lKSW5UbThINlZr?=
 =?utf-8?B?Ty9TOHJveVB1alk3U3V1QUw4eDRMYW96YzJ3UGhJNnY2QldHK25hMEYrakdj?=
 =?utf-8?B?NTFlZlY1bnoxcFc2K2lrMyt3bnFiNUhQN2hac0c3RzJFV2o2T2dXT3BORlky?=
 =?utf-8?B?aGdjMVNoM1hTcWkvZ1FUaGxjYjQ5TWQxWEFCbHF2RDY5a1l0M1VQcFkwYWRl?=
 =?utf-8?B?WlozYkVWZzhadS84R3dnUzZ1SGtmWXdnSHVQa0tqMXdQbGh6SkxwdG9rSG9E?=
 =?utf-8?B?Szd1NloxNWwvbWN4MnZSSGpIT3RBZzAxdXdiUTFRMTI0YjJTdzFBeHVWODNp?=
 =?utf-8?B?TGd5eUx0ODZiQXRUZ0JhUnNlRDZ0dkgrbitLUnZJTmNQbm9RUW9TbS9hSXYw?=
 =?utf-8?Q?WHBLrITTx6YW6Oy791GkpkshjvjqemSXmTiJI3KJOl4J?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <62DF46B80105C347A082D77A26274239@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	44WhM8TDm1yasMRyHUuebR2qIdOj80Pim8S2M0EJcwQsZ0hX3N9As1KcFhMhLTjLnbFLUXgC9TseLLHm57cJhgGqcxobLPBYO8k3L+lch0z7tWtfrggYp23pDm9WvsSiG9sIxHGY02meppYHXuIa4i/SAu0WEXO1qe4fNFk3ZSsmLbIG1ajhqvZem4lxOOFGH+O6s9iFJlHYxGux2OlAEk8dDDr+w4yFM0K1ikXj5dIrLNcbwNji9fC2u9/iX9rj2f7EcGhDIYNJMQGtw4hAsIoCsoFn3vkV1tHUZGFWl5fqpNCASMetXJVi43QiN3nqAS8CANZboyhEEtVpwxh6E2aJK8rMDQUOiVjhJ7gYmJ3P1QQSGFRsRqWHNyoh5fm5TU4kkrQ/stL2X44/hscZ9SNbZvc4vm2yJy+GZY3HWSn+i58F/5TDUpQ13sADfZBsZOeHAOWloyjtlZZc+ZPHNAYfecw59wB9aWcZqMnJTQOs5YQF0VMEdOupT/U7ogC9guhcKYLe3yd3cRuL/WS+nWhJ5QIrWD4DoefDfggNx2OgmqJ2gVhosNHZf/5zi4bn7pXSqJIyw68h3H+tRmmuB+BLrcZA0qfpc60T/TFa7QI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB6708.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acc5eeca-81f3-44bf-3537-08dcff87c030
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2024 23:56:08.9725
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kLumx3qWsa7IC4I8SZygqkPL1ynex2jMt5xMUhcLEfBF8A2+CUprmvOmJhTnAqQREOEOKa8ERP/rBoIuDMI7U+6KBjDqiGNFSgqYQOnXWbk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5640
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-07_10,2024-11-07_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 spamscore=0
 phishscore=0 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411070186
X-Proofpoint-GUID: G-2orM8BO4HLeQLvFtduvAiaHMwC0Uzx
X-Proofpoint-ORIG-GUID: G-2orM8BO4HLeQLvFtduvAiaHMwC0Uzx

DQo+IE9uIE5vdiA3LCAyMDI0LCBhdCA3OjU24oCvQU0sIERhdmUgSGFuc2VuIDxkYXZlLmhhbnNl
bkBpbnRlbC5jb20+IHdyb3RlOg0KPiANCj4gVGhlIHF1ZXN0aW9uIHN0aWxsIHN0YW5kcyBhcyB0
byB3aGV0aGVyIHRoZSBuZXcgWFNUQVRFX0JWIHZhbHVlIHNob3VsZA0KPiBiZSBjYWxjdWxhdGVk
IGJ5IHRoZSBrZXJuZWwgb3IgcmVhZCBkaXJlY3RseSBmcm9tIHRoZSB1c2Vyc3BhY2UgYnVmZmVy
Lg0KDQpJZiBpdCBpcyBjYWxjdWF0ZWQgYnkgdGhlIGtlcm5lbCwgaXMgdGhlcmUgYSBjaGFuY2Ug
dGhhdCB3ZSBjb3VsZCBpbmFkdmVydGVudGx5DQpzZXQgWElOVVNFW2ldIHRvIDEgZm9yIG1vcmUg
Y29tcG9uZW50cyBvdGhlciB0aGFuIGp1c3QgUEtSVT8gU2luY2UgaXQgaXMgDQpwb3NzaWJsZSB0
aGF0IHNvbWUgb3RoZXIgY29tcG9uZW50IHdhcyBzZXQgdG8gaXRzIGluaXQgc3RhdGUgYnkgWFNB
VkUsIGJ1dA0Kd2XigJlkIGJlIG92ZXJ3cml0aW5nIGl0IHdpdGg6DQoNCiAgICAgICB4c3RhdGVf
YnYgPSBtYXNrIHwgWEZFQVRVUkVfTUFTS19QS1JVOw0KDQpJdCBzZWVtcyBzYWZlciB0byByZWFk
IHVzZXJzcGFjZSBidWZmZXIgYW5kIHdyaXRlIGl0IGJhY2ssIHNvIHRoYXQgd2UgZG8gbm90DQpt
b2RpZnkgYW55IG90aGVyIFhTVEFURV9CViBiaXRzLg0KDQpBcG9sb2dpZXMgaWYgSeKAmW0gd2ls
ZGx5IG9mZiBiYXNlLg0KDQpUaGFua3MsDQpBcnVuYQ==

