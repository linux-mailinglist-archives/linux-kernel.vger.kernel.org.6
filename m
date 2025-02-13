Return-Path: <linux-kernel+bounces-512863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC0BA33E88
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 12:57:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0834B16A178
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 11:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76DE921D3EB;
	Thu, 13 Feb 2025 11:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OHITgY/M";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xkPfxVZg"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00C021D3D6;
	Thu, 13 Feb 2025 11:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739447820; cv=fail; b=FyOIVilGFy2IE+nG0W4s3BCyeTGlh5qamb1Wb3Mr+P+ictG4S35Om2LTQ86xQ8j5j4AJ6E0UD1eOF4AE+NDA1u54pLBeXjEy3uVqRqAVVv0E9a+mEfKMmdd6TxgKchc1xhdtlwuZ9iYZ+zhu2m1/eBFKbGsfX2v0vWqpyXH18sQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739447820; c=relaxed/simple;
	bh=oGLgKRH0ccbISwIiQCX+2ylRrVo0FxJhh0b4YkUpJ5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NW4F6oIbcHgKxGkvuoCCFy68JugqySFUozHDvSeOqDCBHL1yudJodsdtDKp+T2xRSpddA15ZEK8seUucHYzVW2BGnSO3PRpTpIy2gLa615qmP+swtm5UBuVK3VY+yBI+iDGkrAbuR3MGoKGlSDq0bIBk7spgr+ra7DWlj+b7dX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OHITgY/M; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xkPfxVZg; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51D8fXrN001469;
	Thu, 13 Feb 2025 11:56:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=HiP3MOR4W2jcOfiaF9aCv46AAI4By3nR0tmTe6I2iNY=; b=
	OHITgY/Ml4ii6Qu2bihmcKaFl9fes0gVeBI/RmtQdaWQSeYzc3uVNWBw3fya/cGk
	Rb1xNBchkyKxLlcR4MesaElFoNR7gjU9NIJnCxKcQhZQIuVFOwLNO/IsdPR30YMh
	ucIz/zsH8yuYMQL7gVmg0aOlkIUDG75elJVQosHpm0zNKuOeHhdxVE+jnPgEC1P6
	G9RvJN3Aqpfu3g9gTUNUhYzifZmrx7sXn2UQGTPxxW+aPLArafkzAUGMlAwYrCF3
	j72eKCXesIScFdWJbnpqwXttpsEfRIC1T2QiR6eVwW07DoS9JjbciLfzskbSK+c5
	EApPUWtmOzWEK7N1N8H94A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0qahcux-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 11:56:31 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51DBPBFv002624;
	Thu, 13 Feb 2025 11:56:30 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2043.outbound.protection.outlook.com [104.47.58.43])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44nwqbn29d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 11:56:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qndAJ8JhqbwPxMrKdFWv9c+DC1LxSaMVyUEz9iUSg/Owcwuv23q1pvHo7DpuIcALeRulRCVQB4s4ujbJsnV//kcyfVI5ElEK9lt0O7q9ddJYnrpkGYiL6qr8/7CD9NCKaq5Ipa95WBwYQXx0Z+UAJlUlS30tmvrKb26cKjeRgjTFeUuuszdcH7A9NSIsn2wfJAOyohdKhFDLT0ylN34cBWQlmpIp1inSfBmKOvuIQRJd2+Vu3aINOufy5JKsvWLKrTkwOt5DUUvsa2Exn8qcnRKzd89FjX5u0USD6FI/okOmSuEtPqHqE4deWeB9EXDaNvvpBy538MXsdNIom9SiSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HiP3MOR4W2jcOfiaF9aCv46AAI4By3nR0tmTe6I2iNY=;
 b=aqAfIt8Y3OigPRsVRwbhtDtv0oCn3B2dXSZhFuz+64SHl973lvRHtGbqxkJGmGMjHhZ1NrQxMg04Ydx/+zU1WbGc5t7fIAIWgnOrX+pngOyvrefLt4iBCVrdXISQu7UkmZlJd8knNjoI952khAlxVDtyCyjCkCMijEV4xzr90AXBRD7TOTiwntrq3OY30fTXPlQw6v5O6CIXyRJSTvmsFZptJxJRGqoFX1zXL0qOwxJfS7ilsCd9/yZyU/FNbpzk7VxuUYUSV5UBYmPqCnK7NRYIiWqxQKLo8oHGYK3UlYHdQym6hQ0WhjnaMtoQsU0s8i3nlc7G1G+pUPoeTMZxMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HiP3MOR4W2jcOfiaF9aCv46AAI4By3nR0tmTe6I2iNY=;
 b=xkPfxVZgbmnSPvrviJGF2ZEAUmBIiIMYvXoR8rBx3xR93WvYP5SZXb36Nq+csGAEDSy64dQNvqhRPFCaY3HS4me5iIwQZ+tZ/UawVp5HaaRRE8gw3xGJ6b3PUx/X48K7/nQPYaqfcrLWYCK6dRyVlojQB5mo3HjA2koK/Ov1u9I=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by CO1PR10MB4770.namprd10.prod.outlook.com (2603:10b6:303:96::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Thu, 13 Feb
 2025 11:56:28 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%4]) with mapi id 15.20.8398.025; Thu, 13 Feb 2025
 11:56:28 +0000
Date: Thu, 13 Feb 2025 11:56:25 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, John Hubbard <jhubbard@nvidia.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@kernel.org>,
        Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, rust-for-linux@vger.kernel.org,
        Balbir Singh <balbirs@nvidia.com>
Subject: Re: [PATCH v14 0/8] Rust support for mm_struct, vm_area_struct, and
 mmap
Message-ID: <793241b9-1ec8-4695-b29a-7b1a5a0f3735@lucifer.local>
References: <20250213-vma-v14-0-b29c47ab21f5@google.com>
 <8130a6d5-a7e5-402b-b05c-2d0703ac1ed2@lucifer.local>
 <CANiq72nBx3cRTUC9HWVR8K64Jbq3GCVMss5wuABzra3OLhRUQw@mail.gmail.com>
 <c8e78762-1429-4ab6-9398-ce52370eec08@lucifer.local>
 <CAH5fLgipyRs+0qMkMN4EZDewtEy_8FvcJgvB+gd=58RgaddN1Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLgipyRs+0qMkMN4EZDewtEy_8FvcJgvB+gd=58RgaddN1Q@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0076.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:190::9) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|CO1PR10MB4770:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c9b0fd5-af59-4e13-67f5-08dd4c2572be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VS9sQXl2V0dzT3RVWGIrNUFVbWJXS0U3M0VkTTlRajU3ajMwUTZZQjlyMURZ?=
 =?utf-8?B?T3dYWmVlOWRMVnBia241a3pKVGJPS2Y3aWdqQjAyN0FaRG9ENG9oOEJ3VmhB?=
 =?utf-8?B?ZDdibWxhUGk4TnBMelhDQlIwSk9ONm9aeGlxTmVhWkIzbGpVRkp1a3Q0d2l5?=
 =?utf-8?B?MzljUWZNbjNHOVpINDQrN2xjTkNDWE5vaXkvdFhibTJhdnRCUlNnZ1psU0g3?=
 =?utf-8?B?M1JPUVFQeTYzbGNVWURubzM2UFIrUnlPNW51c3FxcS9HdVNHYUdEQ0lSNXpY?=
 =?utf-8?B?SzhZM0oyVFBXWWY0TXpkeUJCc3hTMlk2M2ExR0cveTJYMFQzTTNGU09jbjlk?=
 =?utf-8?B?RlhyVzFBWGhTZXhNZlJUNkxRMUpLVlhjdE5kT0RXbjA1UDY5TGovcWhUUjVy?=
 =?utf-8?B?VjBybzF4NFQ3NzdEWG5lUi9qM2hsZzBYVjh5VmxKM2h0TTJwTkNBQzdsWldQ?=
 =?utf-8?B?ZDhwMmdNcm8vZFlkV1ZoV2VvalZvQUtFZktycXB1SzVtQ3hBNmErOUJ4Sllv?=
 =?utf-8?B?djY2VkZmZ1lNZThnMFJLcVY1Qm1CaXJzeElwTytVb2IwZUtVZ1NtS1R4ajhT?=
 =?utf-8?B?YmllS0o0Sm5UMHNiUlFZV3praWF5NUh2TUgyMmhGanlySmdSa3BpVm5rK3lD?=
 =?utf-8?B?dUxPanlzV29yN1NUSEFickNkVHc5RjlrNW9yOHlQZ09qbU9VZVFra3g5L3hW?=
 =?utf-8?B?bHpZR3JPNmNHQjhmNE1FYkp6S0FqbGFDd3VvSjIyWm8wbk1oU3kvY1JVQTNr?=
 =?utf-8?B?WHB5cHZoUytYWFhxSytQSEt5VXVtdlpIQnJISENjN0VNOGEvNUZ6Q3NGM1VM?=
 =?utf-8?B?UkJvaXoyQk5RNmtEbitwOFYrWkZ6bWlPa256RkJwTTFySmIxT2daOUZGSXVG?=
 =?utf-8?B?bVE1VDcrNEFKalV6MWhsTkQwZHMzVzJFZDhCNisvVXgwMmprSzBmWTBoWE5E?=
 =?utf-8?B?dXp3NzB4RWlTN1c3MERiQkFaaXQxNFNnYm9ONHErM3JlcGREd0Q1UklEQ2ZT?=
 =?utf-8?B?ZHRQS3EvTnY1UDJ0aklzOHRuRlVyRzdWd0wxU0tmUmNwQ0VGSjd0b0pnNUVQ?=
 =?utf-8?B?RGZyclhjaXR4L0QxNWdaaEZTTlNpRW45Z044cElhNGxhWXk1bktCVlJmbGVu?=
 =?utf-8?B?by9sTUNwdW1FbG0xZVJxZDVOdkFZRy9YMU5ZTVY5bVJheWIzZWNyMmFaT09S?=
 =?utf-8?B?K1lYWmxSa1ZrUG92TnRvS3NPZXJ0RE9NMmo3RGt5QkZwMS9nK3BHbGF4cFNm?=
 =?utf-8?B?WlR6ZDFjQmlLOWRmUENNRGNpc3pWZHFmRnhIZGd6U2RYb2pYeFR3RzV5d0Jo?=
 =?utf-8?B?UkVNci9kM04velZ6R1I1Sk5DeWlUeVlKZjNEZ01xdm15dlMxazdWV0VPbEZJ?=
 =?utf-8?B?MFMvdWt5VDl2OUFjZEZuM2VkM0dkODJQMHRUZmNrcFNaQ0hPZ2w4V3k3WEdn?=
 =?utf-8?B?dS96dGZqZUZsQ3dKRnR2ZjczTmlZZDhkNFZQNVNkbmZvSitQbkI5MytWUEUy?=
 =?utf-8?B?ODNqLzU4TVM2V0pLS2ZCUmFaa0FjR0ZUNzZnQjc5VVZoZXdhS3V0bEFzdkZl?=
 =?utf-8?B?bzJBNzZQK1VhYVNXNUpMMTd0TTJGR2V1bk5DK2R6QTJQckNPUGs1Rk0xWkc4?=
 =?utf-8?B?enUvSitZaTNrNWRjY3h6Uk41bnZ3YXZTeTNESlV0Z2IzZjhyQ2pqVlFkSUdh?=
 =?utf-8?B?Smphck40YXJHT0d3ZmFiTmdBaENKOWg0NCtDaFUrb2xLT2U4eHBIZHkwZm9j?=
 =?utf-8?Q?dwkj/bOStEbbXY/NT9fFcJozuo5dbKxT0hXzbX4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M3BvY0QxUXRaWkdpSWJsRFFGdU9GVWo1a2lvQU5ock1rQTVMOFJqdFF2aElE?=
 =?utf-8?B?WG1tSFBndll2cks2UGs2MUlLK2NXQlMvQTJ6dks5cnN0QTV0M1lZNXlRZUo2?=
 =?utf-8?B?Y2RIMkdaV2tHdWUrMm54RTJEWFNQTkdPemwrWE9FZm9kMGhYb2YzWG5tZU02?=
 =?utf-8?B?RDEwNFE3dFhsU0xCWE5WeUV1VG8zQjMzbktvbHRVampseEZoeHhmWXhXMm4z?=
 =?utf-8?B?T2NxZ1JMRk5VY2Y4d0NFdHExaWpqQ1ZvaWJVeXdoSFZmVFpxdDBNWk4vUlBL?=
 =?utf-8?B?Yk1IQ3IvTmIyUDBLajdRUEpOSGRwaE9NMnIrK2xibHlPM2hseDVsUWREeGdu?=
 =?utf-8?B?RkxEMUIvd3EybURuMlo0dVRzU3FHTjBXNlFObkRYRHBwbHliejJwYkFGcWFi?=
 =?utf-8?B?SVh0RUIyZTkvM3VhSytVMTFEWlh0SFo2dUFJUVZ6dnZJbEViUytlYTN4S3dI?=
 =?utf-8?B?U012d054dXpaOVhVa3JiRFNwZnY0QjVLcWlOeWhqcEp5bG9TZVJGMThmVWxL?=
 =?utf-8?B?cW9Md1pOWTh5TS93SHVNU1kyQXQzK3loaXhqZDFsR2R2NkNwLzZXcGY1aGZW?=
 =?utf-8?B?OVpRWUxycDdYU0VQbVE1Tnp5TmIrT0Z4MGJENi9sVmlUbFdJUDQ4S1czMDFx?=
 =?utf-8?B?ZlZqNGozR0FJcHc4Z3g4Wm1JT3Q3MEVFT3N4WXoxMDlVWTZwSk82MEZVWWt0?=
 =?utf-8?B?UkZVNnFTb01aYVlIdi9tTnd3RjZQRmZ0eUlhTzBxSG1LdEVqNkxValRONTN3?=
 =?utf-8?B?SmVoOUlHdWl3eGJXRTUvSEE0SUQraXQvQ2RIcEpaYkZjQ0hjM3ZpS2psMUR5?=
 =?utf-8?B?WW9IMTl4UVcyQ2lRZloxNnZaYkpZN1lwY082U3ZlanBUQlR3ZkxILy9qN1ZW?=
 =?utf-8?B?NVNabFhkeVFySVhkWFY1cGN1NnQrVkMvV2xlQXZ4cEZLVDlqVkdpUk92eGpa?=
 =?utf-8?B?Y0N5Rmo2c1FOdlBLOVpKTW1GTFA1L1pyallsak40bkIzbFRLYjkxMzR5UDhT?=
 =?utf-8?B?K05KNkpJWW9yYXBqbzZLbFVzODN4enQyTmVMejhldUJUWkpXdjZSYytoQ3Uv?=
 =?utf-8?B?Z0dPOS9SME9uaWlOcCtLMkdhSlkvTktYTFNmM2huRkFaN1RqdDlCdUxURDlI?=
 =?utf-8?B?alBxK0lmWTAwS2xPSElsdW9nQ3hsNlhmOTRCVXJmSFQ5Ym9wc0tadUpoVXhq?=
 =?utf-8?B?ekh6VFhCYUhrOXl1Q1JPYnlkNnNnejV4dEMvQzZ2WlJHZHZyMkFpTVZUOUV3?=
 =?utf-8?B?QkY4UWczUkl3anhrd2dhUDEyWVdYV2x6OFRTTlM5WER0QlJONk5zcElvekNO?=
 =?utf-8?B?a1RFM2UyaGtGQkRqS01DVklBV2xkUys0MWNoUFFzUnlhL0IvenNKNENWdXkz?=
 =?utf-8?B?N0hnQXlvSm1oTWZkVU1TdmlmUk9BcUt5WXdDWll3K1NpdUZyc3p6V3ltMnNp?=
 =?utf-8?B?RkpVRGM0eUp4dkdNY3AwOGQ1UzFsUGxSWGhKbGtmNkNLUUZtWmMrNFRjL1VJ?=
 =?utf-8?B?V1VKL0ZocVhtWU9kbTNBb3RaSnhiVTRmZXhMcVlQbzhLdUgxTklTZGpyVlNN?=
 =?utf-8?B?Si96Z3QvdkJKZ1ovc2NYZ0ZLS2pzTkFObjJKZ01GSm5UaFNINDllVldmQzFX?=
 =?utf-8?B?bnppRjZ4SVdUVTRBUUUzZmVKcnR6SnZVbU5UdExhTjFsK0V0TjhDMnUvOEtq?=
 =?utf-8?B?NDdFNzVQZUZscGovVmN1NFJrcUlsNUN4MHRzT3BKaHBadWwwY3N3dG9sWW55?=
 =?utf-8?B?QVdxZk5iTm1VQ2c0WTRVdk9LclpBaTdkdm9Xc0hFNUd6Z0tMNTFqd2hOdlB3?=
 =?utf-8?B?bEJycnlLZGtJTWhWb2pET0FFY1BoMjBrb1hsZ3B4bTQvSS92NlM0MEVWS2RY?=
 =?utf-8?B?UWZhUGkwWElZay8wRm9seXdic1F2bldCMjVWUzBMc2RUYUttbW1kNEtXZlFq?=
 =?utf-8?B?RDlNeTNJSzJmV0Z6Nk5hZnpFc3crYzlJQW9vOG9LYlVNK1AvNkJhdVl5dEhp?=
 =?utf-8?B?c0laa3ZEaE5xWlJqRFRXK2lBY1pqd0V4aWpyZWhPQURvUTE3Z05MWjkvN3R2?=
 =?utf-8?B?WEhlOXYySjhmZEtUclVKa1VLbWNTL0xzVk8rN0xsT2U3TEVOSUlma0ZFQ3ly?=
 =?utf-8?B?dnQycjlsd2NNYk1ORUZZbDVSeWYvWElHeUVRRUN1dXhraHNvWXZad0hlaE92?=
 =?utf-8?B?MWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mjHHr4HdxgjpWxZ+04deKWayJG50TR5CmkA0+sXFqZLZ9TbyQ6W6wLwVHMvXAra+fNIQLOIXBvZhrbOnOpajwkEPQz5fpaX+2RQT8YKR+xOOSH7gJ8+Sr2o+e7IMF1elV/J4DIGWNBuUNQfb8YRY+9/QRRUJZfvizvBcKZHpiHG3t68dGkwGqVymD+5gfvjIRbtkz9Q2rqf75XBQ7tHZ6flqZJDBq2zXqyJ55YaN37H+Rd/AWwFrM33vbVXPspvcQL5oawSMMYdIvsI//tVzbakCrZs+NLKs+mDCBDDly5u17yp41VKR5f/s4FTfZdxp4Vr0pT1HLXEjyrwY1G4mz9RI4gsckUHAyC6lLOJ/wIIOfLJwOUWXJRVlYIuOgX3b7e7Lb5l/eJaXND+vWBmfxeynKGPlA4wNorkSFEBhuVpRHyD92rUYnVnX6eGOvRnaT4rrCMPHI7bbgy5ysseFldvuh4pAx25O9rHgkK/i1s+RDdVCCAYeG7uXzCF2tiK5hy/hzSnwwZ3vx0Vfv2HXQvHDTUXHAX4OmHs7JP4Dv6H1npl1YDrDSxb80ektmFNfsHGc1HN0fhFuARJnK7rN0Pehh1WExIcoP1uUftVP/nM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c9b0fd5-af59-4e13-67f5-08dd4c2572be
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 11:56:27.9830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DWt7zdZr5/s89F5CGnBSCg+8mA2zBme2SSL045KfU7rEBiSdhHT1mHBEdOeME0tqWLzB6sYnD3IN6Deo+lIlPmJjovFNeA6Jw8jJj6SNnik=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4770
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_05,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=998
 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502130092
X-Proofpoint-GUID: 2K1vFiBF_C-_cmtpwJhsdWuCtY0C4bB5
X-Proofpoint-ORIG-GUID: 2K1vFiBF_C-_cmtpwJhsdWuCtY0C4bB5

On Thu, Feb 13, 2025 at 12:53:51PM +0100, Alice Ryhl wrote:
> On Thu, Feb 13, 2025 at 12:50 PM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > On Thu, Feb 13, 2025 at 12:32:27PM +0100, Miguel Ojeda wrote:
> > > On Thu, Feb 13, 2025 at 12:14 PM Lorenzo Stoakes
> > > <lorenzo.stoakes@oracle.com> wrote:
> > > >
> > > > the maintainers for the subsystem generally take series (though of course,
> > > > it is entirely maintained and managed by rust people).
> > >
> > > Just in case: I am not sure what "rust people" means here, but if you
> > > meant the Rust subsystem, then it is not the case. Maintenance depends
> > > on what the subsystem wants to do (including how to handle patches,
> > > but also the actual maintenance), who steps up to maintain it, whether
> > > the subsystem wants new co-maintainers or sub-maintainers, etc.
> > >
> > >     https://rust-for-linux.com/rust-kernel-policy#how-is-rust-introduced-in-a-subsystem
> > >     https://rust-for-linux.com/rust-kernel-policy#who-maintains-rust-code-in-the-kernel
> > >
> > > That is why the cover letter asks about the `MAINTAINERS` file.
> >
> > Right, I don't mean the rust subsystem, I mean designated rust
> > maintainers. The point being that this won't add workload to Andrew, nor
> > require him nor other mm C people to understand rust.
> >
> > As stated, I agree we need to add an entry to MAINTAINERS for this, which
> > is why I explicitly chased this up.
>
> I am happy to be listed as a maintainer of this code.

And based on my highly positive interactions with you and your clear depth
of knowledge in rust + endlessly patient interactions with us mm C folk I
for one am absolutely happy to endorse this + ack any such change to
MAINTAINERS :)

>
> Alice
>

