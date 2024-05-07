Return-Path: <linux-kernel+bounces-170533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 973958BD8C7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 02:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E761283267
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 00:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE4D1862;
	Tue,  7 May 2024 00:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PiMzGA1r";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cSFcfZs7"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBECD138C
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 00:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715043526; cv=fail; b=CxDbkQ6KkrF1oNd1X9uuJi3GjTssPasmSVmw+LwZq0paob2mKv0aCvNE6uDMMDYpEHUusZ0tCSESAFagzd8LWRtJk+3Jzt4slnIRhi8wriG8tnOzbZtD9BUUmeMjWRnljcHljNXT4/VIRbJrejVLy/EUjrTatEgqKf8MY6BeeJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715043526; c=relaxed/simple;
	bh=26Fku1mXecUdURCSQLjw1ffPsZhAulo/rvdvRi04HY8=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=g8l839s2BpoSwDTDInZCnDzOGVkbaHx+GiA9QnBC2V3YJLD8Hwj0mvxqs0SB7prBcWt0dgwiBKCvTJhhjstlB0zFpe+W+11a5AyZi1SkOUlO6V4Ts2vvlzg/VsddZuBEgse5R+QiNBoXuepu6jp1L+pWsZGk24tVF4AJYVcWrss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PiMzGA1r; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cSFcfZs7; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 446Mmi2P018449;
	Tue, 7 May 2024 00:58:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=nAlmvuwFzKK7B4vljuG3d7d2qkBd3iyKI0gNGaceLwo=;
 b=PiMzGA1rHneUCh70dlDefkzhyYb4CJgCxXxJ4CFgJrX0rNfs78VIy7No/5+fjpTQSQRc
 8qSePdLPS4FLrc/JPVWKo+vVgHJs8WJ2wXwkquFETwIENC4Mq71N2h9Ci8H9iijOxQZ2
 0utA1hdJNkv0U+voH8bQLCKzTj5/oRx8hRf0uS5O5UsGPSrBKVSg2x9hbjfY9XPS/VYT
 dYaRBLupajoG1bsaCLRFOkoxKjnOvrX8pP2Y2GuJZj2vDEpB3gJYBOBG1v+iMHfxNiz5
 hZXB5+kZDsY6TsNcWDbfFJc1VGEVlW9ky3Qm7fivDX+L2N0XUulEz/xS5/4rDNFMjDlT Bw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xwd2duu48-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 May 2024 00:58:24 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4470mr8M040905;
	Tue, 7 May 2024 00:58:24 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xwbf6jw2c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 May 2024 00:58:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a/ylmtOX6N9o03RqeVpeJxsnW8KVo0cH/G7CQ5S34Tw4+smZb/60eYonzfU2NmJeO5EyyEpgmsgTT2g8/AzOO9W/MUCZa3Tm1gHLyO7DKcCl+UbB7kP0TNciU4YCBqk1YWBAMQZXAgrqW1xY9Hfw8GfBuqjfZ3p9I4Bm8aBH3yc2Wb2FCNCBtUDNVycqmbSaKMaSUcqTLOyjLivd8PvVjeugnQIpln+D55kI9LSWcemhQOkZ9s1aqpopB9DSE9S5u+U5dsoZg7XeK5CkhFuWyKaf3nROOVHl0XccU979Uvau9IceeXV4/mYdNnnpyUrX18MbvLtXc6PXcJlPBfMrDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nAlmvuwFzKK7B4vljuG3d7d2qkBd3iyKI0gNGaceLwo=;
 b=N491f2T/5cWcJi2JTWr3NCNTbd/Y1CRRuano6IE4FU4HV7j5GzVuap6De/hQ4KaxHFLnS0iUQB6AkmisDnVr2bLENsRnmfj0P/nFwdax9zCPQWCfByp4UJFW/1xJ2XMogSGPNYiwiGAcltFTjEdZKpwwfwd/CkOuf7OO4xEYdV2FGqTakHZjqXUAx3jJn0gFkjCgOhl4iZUtQyORsuJIPNKdZPwNCAi1UFY8KTmbe/rM6Y59oMNANk7zDqcSXe9E+zV+rMB70z9wPvyb0dWzQfloUU47nWg+4i0+qVzZUOGKbyI0KeD31FZYjMGzqUCHgvq902Oxd5tysM5rn/noHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nAlmvuwFzKK7B4vljuG3d7d2qkBd3iyKI0gNGaceLwo=;
 b=cSFcfZs7eLol8dLSoA0WBEoLLIgkhnCzd4vCdDFvp5LDD4jGdYauf67pOfhtG68wKzbH2cNHCKDNOH/R6euGEw1zf0tq/SUpO91DGrhDI4bO3rAB3jAAEx9wkYSxk17E2t1aVqWv+qB2PH4XPUMhEwE56tAhC7qY6YjI3eZTtzA=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by DM4PR10MB5943.namprd10.prod.outlook.com (2603:10b6:8:a1::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.40; Tue, 7 May 2024 00:58:22 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::485e:729e:c0a4:e562]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::485e:729e:c0a4:e562%7]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 00:58:22 +0000
Message-ID: <f0a0d637-a4c2-48d0-b6f6-45688c8ef7da@oracle.com>
Date: Tue, 7 May 2024 10:58:13 +1000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/irq: Use existing helper for pending vector check
To: Jacob Pan <jacob.jun.pan@linux.intel.com>, X86 Kernel <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
References: <20240506175612.1141095-1-jacob.jun.pan@linux.intel.com>
Content-Language: en-US
From: imran.f.khan@oracle.com
In-Reply-To: <20240506175612.1141095-1-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0177.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::33) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4468:EE_|DM4PR10MB5943:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c1a9190-b1df-408f-57e5-08dc6e30cab4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?QjNHcmd6VmxQbEIvbmV3a0NFNEZISEVFWG4xUUI4QnR1eldhQWJpVXVUQWky?=
 =?utf-8?B?dFBoV3BnbXZMOUttS3c5Q1VkSnVOMnI2OUxsbDIxdnUyTlhwb3pnbm5xMFg4?=
 =?utf-8?B?QXEvSTZlUTVpajhwMUJiTkl3dWJsaWx4UGxLczBLekpuamU1S3MwSEU4S1ZN?=
 =?utf-8?B?dFJPd1Uzd2xwSkMzWE9mNDljaUhwTDk0OXNUUTlsYnBnUGs1Y09SNWtkRHdC?=
 =?utf-8?B?TytUQjhyUEJvMkdsZml0UmR2SlFlVkMrMFVXekpQZE9oSXJ6ZGZNOVBPcHdW?=
 =?utf-8?B?d2dwWFQwSWhZUU0vMU90cmdaa29VQzByazVFZ2hQTFVaVmtBZ3krOUR0Q1Zz?=
 =?utf-8?B?RTlheEpSb1ZYUDhwRHQzUDFNQ002TGdSZ0lKUDRFbU5oZkpydjZ0bCtDQkd5?=
 =?utf-8?B?KzJJWHNCRnFITUEwUkh6eEI3ZFRVclh0enNUclRKNGwrakl1YXpTaDc3YnRT?=
 =?utf-8?B?cDVqdi90eURhOWI3aXVkUUxEd2NHZUgyVUxEQUh4Smx1ZnlUcktvSjJ0Y1ln?=
 =?utf-8?B?WU01RzlGVmdJRkZNNFlaOUdUenNBWTJIczBQVnJ6dTBYRmk1c21oeGVHNXpv?=
 =?utf-8?B?cnJERFNjTFY0YjU2Ri9DbEp4V3k4NjZZNHVweWxPTGZ3ZmJ4MGordjduVzI2?=
 =?utf-8?B?UDlrWEJhQkFPeGxTYVdFTkMrRGtvWTZ0N1N5cXpSQlN6WXltajZ5NG01QTlF?=
 =?utf-8?B?WTFXNG1JbjJSRHRyUFZvckllRVR1VDNjOWxFVWNIVS9EQnVHWS85WlhKaTRY?=
 =?utf-8?B?NTdDUWdWVTBWWUFQdHh2SWRVZmNFWHFGQTlQdnU3SmhnNGNveGp0TjBzMDhk?=
 =?utf-8?B?WDJTWWhmZW9FL0RvUXFndFdmWlNlUU5SOXNnYWZhUitSek1WUVBTTzI4NEMw?=
 =?utf-8?B?TitPTTNObmd2cVMzR1E2aHhCRjVFMXZsbGNVU3VHQjZRMUEza2gzVEVlQWdU?=
 =?utf-8?B?UFlvQ0kySmRCUEtxMkRKcGdkSDcxUHpCWnNXMk40VzRPQVAxQ0ZZSnU5RS9v?=
 =?utf-8?B?M1kwdVhGSEhmNkgyY3FadkRDTTFvMDZDMDViaERXK29FbVQyQU50NDN0RXc1?=
 =?utf-8?B?QWMvNzRkd0FTWEYvVGlISCtpcDM1dTVWajdCaFovOVlzZVhJMGNDaGt1R3RO?=
 =?utf-8?B?dDFyUDJoN09iUWJEaUtqb0dmTkVGTVhITG9kWURtNDdqSlgzbWhkWm5ITXZx?=
 =?utf-8?B?TmhMemtnSHdoZmo1MU1XSHZRQ2ZXWllzSWpEYkFxTmt2UWhxQ2NTL0hKTytx?=
 =?utf-8?B?dkNDWW1ueHBrUzdIL0JBTHpmOHBSeGRvR2NEdjdBZ2Z1c1ZiL2Q4UGpVTFFo?=
 =?utf-8?B?MVZjSUx1TmxsVVQrSG9xajhlRmlUZklzU3Z3Z1VhQk82aHVLdXlLOG44bGtj?=
 =?utf-8?B?cXJRRkpGajdQVkJVZUZmY21Pbkp4Mm5zcEZKZWwxYkV2ajI1MTZWSEtvdE5r?=
 =?utf-8?B?N3VqRXc0TkR2bDFSQnRWZFc5ZG9DSnFuVmVEbFZ1dDM5bzIwMnBXMDc1TEUr?=
 =?utf-8?B?MEtxZDdNUWZHY0ZkUm96aGM4U3Z0SFNuQzQvSTVTS1JyZEd0M1lUQktKQjMz?=
 =?utf-8?B?UzNsTjFOc09NZXN1MSthdXExdFV3Vmhpb3lqbzQ0SDhKMkdDdllSSE9vUnRK?=
 =?utf-8?B?QWxWODVjMWs0RVV2bExQUkI5aEJISW80ZVFUM1BraFJZVGRrSlJMY1VDQTJD?=
 =?utf-8?B?bmEzaThXRFVCU0ZVVEdKK3JZYTRUdlk4L2tGYW5nZGFiR0tQeDdMWFhRPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WjJjTHRXVG5JZFIyckQwalJsNnJBZzZlbHdmRHFiZ25Ca3Z4cDhwRlRjMEdD?=
 =?utf-8?B?dW0yRWFUUGV5eHU2UlBMT1didHlRYTJodlN0eW9lTWZqMFRtemtwZU9hTHZI?=
 =?utf-8?B?Y1BsMXNMVXcwd0ZHVXliT3g5U0dpSjJDeXZmZnRZWkYvcWh2OTlyZTJxNTY3?=
 =?utf-8?B?c1FBMlRBNEFSd2pRNkhqdUowK1AxRU9sOXV5OXdadGRTYmNMcHR2aTluUk44?=
 =?utf-8?B?ZzBBOEk4RlFSN3loWkYrYXhoc25yeStXTVhPc0JmZng0dkxHU1FQS3VETFlm?=
 =?utf-8?B?cm44eDY0dWw4c2tSUCtTblJiTGZ0b3hVUFpaRmVtUjZvaXpjdFByaUFuTnB2?=
 =?utf-8?B?YmpGc2ZZYWFEbDJldXNtYnp4RTlJNHQ1b0M1MjdlSVhTOTB2MVFyMGNFU2kr?=
 =?utf-8?B?VjVodzdKMm91T3hzZVVTMVRObWlXcWtXZmZ5WWtuNHZNZXpsRncrL3V0alJy?=
 =?utf-8?B?TlZ6dEowQVN2SHZMdDNoL2oySjdBOVBRSllwK3BwWms0RkZjTUFNNUNxUWdJ?=
 =?utf-8?B?Ri9VMHVaMnREZ0toclZqWGE2TFE4NjVRSkZyZjVkM0VuMS9qN0wzdnJ2U040?=
 =?utf-8?B?NmErTTBRRDZqVURUeWtJNmNjZVRhd1Q0MmUrZTZaTkJ3dnBJYVJtaUZETU9L?=
 =?utf-8?B?V2h3VGIxdkVDVlJpREVxWU1sSmFEMC9sclhycXNFOW9lRVUyeENPRTNkQUZG?=
 =?utf-8?B?WDhrN2RXWS8xQVE5Y3pudDg1YnAxM016a3J5cmtCOXlPV3N2OVQrYzRmbU5N?=
 =?utf-8?B?eVNmSThQc3ZjTzF6QzJ0SFFDSnYrQ2F1N3pvamR3ZjBGZFhJU2dsdWR5NlRX?=
 =?utf-8?B?S0dQdTJvQ1gvK3BESTZtNnozNE9Ha2FwYnNiQ3N3YUZPdDJJRFpZcUkvWkhG?=
 =?utf-8?B?aGNtMlErV2I3a1FLeDNuNUlGNEtac1VOTkhrS3BOSldwbmxVVlNrZkdEeE9C?=
 =?utf-8?B?RjlRaEY2UUFjSkpMeElkMzRzREdaQ1JyQW05anQzZFVuMEhhcjRQdmVSSXVO?=
 =?utf-8?B?THVncGUzbW9qcXFZMTZ5Qi94WEQ1U0N3emhxUzhHSDdiRFpOWmY3alhkdUNm?=
 =?utf-8?B?NHF5OEVKUUtkdDFHL3lpT05JbkJVVUV1Um5KMmJvQzZaVklPUEM4Y0lBV2tO?=
 =?utf-8?B?SitrUW9LcWVZMStkVkMxMTB3TFNWc0NyVVVxb2RMTVRieTNBRkxzb3JYemxK?=
 =?utf-8?B?VlNrZ05MSnVtV3BKWSt5MkgzMUN6aFJTR3kyeFVyblptRVVOSStiK1NzdDVQ?=
 =?utf-8?B?N0pqV2pVK3BLQkJqTHhFL0QwaGcyWjJ2dXVsbHhSZ1hJR1ZkTWdXU3ZUNXpS?=
 =?utf-8?B?UTI1YW1YY0hYRERQR0VsK0U1MjdOWktXTFg2TkNiRFpJZEZ3SGJPM1JLejNV?=
 =?utf-8?B?cnJZeGJxREJmTjhGS29qZm5HUERYMGR6blpISE1UVC9oQ254Tm1YZFpOS2Jh?=
 =?utf-8?B?VVFTRHNxTGhNRjIzZUVMeE1qRGx3T0FPWDNKZ0dzZFBGZi9BTUdLQ0dIMC91?=
 =?utf-8?B?ZWtGMjZWQWk5K0phS3V1NFpjeWxIajJKU3Rzak9vOVloQTFwc1ZVSFdScWRj?=
 =?utf-8?B?dUFaZzZjYlVVTi9wc3VHUkE4d1AvZFJDNENJV05zUkpKS1NFcHhUWHVLM3RK?=
 =?utf-8?B?SFh4TEg5RkRxYVN5TEdyMEJKUG9kd09KM0w3TWxwQkZnNFl2OUMzT2wvbWpT?=
 =?utf-8?B?b0J2MTUyVnFUNnQ5QVFvZ1ZmYTd1cDJndGdSbGVIRWkxbFFmNjVTWEV6OHhE?=
 =?utf-8?B?ZnBEZ1Rnd3owM1lFVWt3dVRKckxkeG9ET1BYQjh3bm9LWkZOdEg2MVl5Y09E?=
 =?utf-8?B?S2cyYUtBc2J6akJsbXJrQjRYUWt1QTVwWVozZGZxZWVZYmZlekwrTjIxdGVM?=
 =?utf-8?B?cUNUbkVpZldnUDNDQ0NHcklBVGtNZkF3eGtnWG5Yam5zcGg2bUNYb2V0WW9l?=
 =?utf-8?B?ODIvRklweVhQYWFacFdlS0doa2dJaUlURTZGSTZ1SjdiT1Z3VnBjUmkzOUlv?=
 =?utf-8?B?MTh6OTJna0pZVEZ5M1B4eG5SemhSeG5mdnpjV3h6bkVEQ2ZrMUNZK1R3VFE0?=
 =?utf-8?B?MFdJb05OYVM5WWc3b09KVGhqUTNlMzM4eC95anc1L0R1TkM2aWE2OGFvNUpH?=
 =?utf-8?B?b1hxd2wwVWptNzdBVGNnK01NSEF6c1Z5SERCU2YrZFlRL1FMU2FnanZWckJr?=
 =?utf-8?B?b2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ENSMuiQoNBZZVg0shUHf8xn8dflGfQqJSjNkPubPyh2STnUhPjkShXl/0dxqICE7hI/ldbzbMIdCCdYWU1aZijKJJtZjhSrDa/uVY2Ljg0Df9HZaha344oNe8fhfuQAisTPWCALNasMV0MoIqQVbzYNtzzD07T5a4pXMDuD1b1FklCchABHT5mJV/dyc1IhiO66DvC2fKNbiqtoDuA/DFgTxudB4cG+xDru8WhfweetRswFxyA4OPgF7Q685sDRtVIo84Ymh1F3/gTm6EU+MXY9KalzLXUd702q1MYGZu/SDu7/Rsbx5KnO38FiZwGbBtnDogDjhfPmwzKN8x+JeypjFC4q01qyFHXaDIP6pQdCvzbETN9ZgXOFXDivHKk41oCtHwqbIDImpmuAYJzm6riQAVjy78Gp8tIxTqtEly7PZicV9q7FW7nsm141UdSiycrOxMahdCkV434V4AdeWkXbDkwZiAWaJOp1TC5pPcRRtpMMwimrK/RFQ9FexMGFjvSo17on7qVo1A0ChZ+EP44OkETKmtxRw/OYxPYSoYudYxZCy4lFT+LcNAxLzSpr/NUguLYE6l0s1FSi5XIa+3wzK+Lbg7UxVzYDvOknOWrw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c1a9190-b1df-408f-57e5-08dc6e30cab4
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 00:58:22.0446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l9ySU0aMYjSXOg++EGvk710lzHBu0Bi183jq/6Oy1/y90YIhAMkr55+1+pKu7pfpjjSG7X8HgjORUj6FPAmZgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB5943
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-06_18,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 suspectscore=0 adultscore=0 phishscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2405070006
X-Proofpoint-GUID: oQOPNYzTa-bMk3DMPcaGr3GhSUc3uZ3F
X-Proofpoint-ORIG-GUID: oQOPNYzTa-bMk3DMPcaGr3GhSUc3uZ3F

Hello Jacob,
This looks good to me.


On 7/5/2024 3:56 am, Jacob Pan wrote:
> lapic_vector_set_in_irr() is already available, use it for checking
> pending vectors at the local APIC. No functional change.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Imran Khan <imran.f.khan@oracle.com>

Reviewed-by: Imran Khan <imran.f.khan@oracle.com>
> ---
>  arch/x86/include/asm/apic.h | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
> index 9122e93b89ea..d7a8ac961af8 100644
> --- a/arch/x86/include/asm/apic.h
> +++ b/arch/x86/include/asm/apic.h
> @@ -505,13 +505,7 @@ static inline bool lapic_vector_set_in_irr(unsigned int vector)
>  
>  static inline bool is_vector_pending(unsigned int vector)
>  {
> -	unsigned int irr;
> -
> -	irr = apic_read(APIC_IRR + (vector / 32 * 0x10));
> -	if (irr  & (1 << (vector % 32)))
> -		return true;
> -
> -	return pi_pending_this_cpu(vector);
> +	return lapic_vector_set_in_irr(vector) || pi_pending_this_cpu(vector);
>  }
>  
>  /*


