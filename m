Return-Path: <linux-kernel+bounces-418578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E75C79D6330
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 18:33:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 406FEB23754
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 17:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420691DE88B;
	Fri, 22 Nov 2024 17:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VMvuNtsZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sbZFL9bG"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EACB41C72;
	Fri, 22 Nov 2024 17:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732296825; cv=fail; b=bMO1UMYSqnuxdaSPJRAoni637nilAQiEVGVbNF5yqUBhZXydWzfRszgq7GzRpB0tRAvshB4XLvJxYxkP3iRzznZcb566caTzLe1NS8v2LbpelSUF9f4Vk/XouIqt0JS+4Cfb0OmSKGWrBbaeSd09pzRBgmiocCgb0XdOTrzxh6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732296825; c=relaxed/simple;
	bh=IALddpzVrujuQlHZR76dR9vVW7IkpRmWwk73FH0H5wY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OlV/YJ3+/KIcZiqbnPiUXZPoG3Z+Iy4QHO/pi+STnHd/qT45nA+Z6QKEufiMiBMMeHM+kJJfq4CjCH7IToCkopG4NINZ2fb5zqCUhrWrwFhT3LNogrC5lWE404bCAYq0BMacmsTLFA7mvAmIeWMazx2sY+Svi0thagILL6r6id0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VMvuNtsZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sbZFL9bG; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AMGC66S018304;
	Fri, 22 Nov 2024 17:33:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=wgpXyMWekGNGGaGpPo
	Mg+L5Q7sTPGRTmcNdGd9YuJMc=; b=VMvuNtsZN2H+A3Riblq+B1CKKy1xFYJaZ3
	gN4HDu7kwinPmHs+xKWwPmCPKJxLGm2cp7hk/pPjMKsqFH49qJK9alKpL1Rvxzr7
	WrqhOVNZLAKtPKvktFxhyuRXSfCn1ZNbNytOOyr0wreSnLaEYVrd5uFcpVygh4De
	JA53+QLH7QNe0UQJfHqEPyNkjclraPCOahSmK7gXejIwcHU7SiWvPFvuz4sj7DWL
	lBUIT2y3M9G8pJ8KS7Kp3c5kL5ROVuziJUGWUb5sYnqz3pHd6kdfJI5b7PuQz0V+
	3mXw0b47eDJTCFowKVU+TicHtphK+G1hCppfaz84DkSvymonLUkA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xk0svkcs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Nov 2024 17:33:19 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AMGHn1p039202;
	Fri, 22 Nov 2024 17:33:18 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42xhudctxk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Nov 2024 17:33:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ynVniSOOzrRB1SIzJ0NWBqEi/7JqtL6eGFoYQ4BS1AbLsSGrdexUpQQR603vrM1t86VsYgGflgElIVNfoyV3N2axEpLENQX8RIPAwmtdNvNSoFbZVIn70m6ThGKMbtkXYTAhshgbDs2dWrOQ6CQOuO5K5fnguXLqb6kfIzITC8GYP+UNosFwV7pJSlr1YB9o6yTjGfzi5lsRPrML19PayNXzSieMnOYnSzpLc3bt/RlkkOeaOeSCeBZ1qwCGZzQ0wBpNZjJHoWpJn6qf/pkMFXP2RgRsEnAT8tTfehkj78i8Yx0gF7ihKdLrFskjy8ZHWHpPVbMpyGEVPD6aFn8jtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wgpXyMWekGNGGaGpPoMg+L5Q7sTPGRTmcNdGd9YuJMc=;
 b=e0pmLJddtc4Oksl/siN+/6tjRBqwsYaH85JFoFafyrNM2mpiqE1Rg6EtWTVPO9Z4be6MUD8DDJTsF070QludOxuM1m8+87cFLT963wl3B19AezKfyaqQfww4R1mIlV0BYIkBYzNmFQrqysqpfvJ7dkm2tWUUWA1F1gSyRBHxV0rutVyYlqqdITwnOPA0gqVC8P7Ig5UVIT9ol66pvp8Owh2tJ24z5nPDwkw0wE+4MEOYXrm0ba3C40ZHjA7aWBh6KQsPg8v44fiEuEcrwHQXYI4uJrvXbtjp0dTa/MOoy2CobAAkCNhlj2aoZRfUPWbfpSCl0Ga5s0+t6Olx8gJF7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wgpXyMWekGNGGaGpPoMg+L5Q7sTPGRTmcNdGd9YuJMc=;
 b=sbZFL9bGPOgaU02eetTt7aVMOdPSCdCSi+bFXCIr626rtHeegEEGNnnyOWGMFXlMYyL80ifYW+kue0nH0Kuek7kOMj4pTJbkUP+mQvCmvmzUEfjjuspCTYsUI9WPr3kgEBr5Nd5s3chTwJeKPO2USBjvXD9mtxSU9KU5zEJmyxc=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by SA3PR10MB7023.namprd10.prod.outlook.com (2603:10b6:806:313::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Fri, 22 Nov
 2024 17:33:15 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8158.023; Fri, 22 Nov 2024
 17:33:15 +0000
Date: Fri, 22 Nov 2024 17:33:11 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, John Hubbard <jhubbard@nvidia.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Christian Brauner <brauner@kernel.org>,
        Jann Horn <jannh@google.com>, Suren Baghdasaryan <surenb@google.com>,
        Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, rust-for-linux@vger.kernel.org,
        Andreas Hindborg <a.hindborg@kernel.org>
Subject: Re: [PATCH v9 6/8] mm: rust: add VmAreaNew for f_ops->mmap()
Message-ID: <652edb4e-ff4b-4d97-8aea-058358e32a76@lucifer.local>
References: <20241122-vma-v9-0-7127bfcdd54e@google.com>
 <20241122-vma-v9-6-7127bfcdd54e@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241122-vma-v9-6-7127bfcdd54e@google.com>
X-ClientProxiedBy: LO4P123CA0194.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::19) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|SA3PR10MB7023:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d658920-c360-4121-a79a-08dd0b1bbec7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GxNn6LNESRZhp1TXauGVfYj41wa2g9++BBQBSRHgTBPy4Wlaz08wOfrAG9Q4?=
 =?us-ascii?Q?bpxotZO69buI+QMV6XHsC0fPN3u9UC7TVWI99ewurhbXsFN7g/1KCDSdcTkk?=
 =?us-ascii?Q?FEXfmOU29HQ75uP+f03nOwAoU2D86bbp4DIV5qXQ2TPTVRlkqwQDCv23iEL1?=
 =?us-ascii?Q?z6sU2VjYegyaQcm52e77O/mTHXSQf7YRtfXENnxKxXWz8SLDa32wfHZVM/pW?=
 =?us-ascii?Q?VnBRBgU8uPpi+/iqyTLMSpuiu+ErGuWOWdbpky9R0z7JUi2sX94b7GfuMs6X?=
 =?us-ascii?Q?QjlrgLjSdBGUWB4JSQTnDGpzkGw5eO6FEDvzhy0ISAcd8EwSJtfjXDiWwTCK?=
 =?us-ascii?Q?nvlM/yh6bJa6aGIxbE3PZ/9RFcYgE/ZYoU6y1z/Gp+/2xI7mlx+KpRy1w2HW?=
 =?us-ascii?Q?GanPZ9fuSNDB8CpT4WTodygHKNvIXca56nQsoaYCueIU5fWpViyRWaf3zZY0?=
 =?us-ascii?Q?UuC45xqXO5FY55N1RLpKxiU2gh4+bDqwxEeAh0EoiIKEvNGXBxkjcCF+iIm1?=
 =?us-ascii?Q?NZF429S69+o7FI9hPurD5H6JgpRUNv0LY7HEORWxYZ4QGOAQduEDQHeFBRPw?=
 =?us-ascii?Q?OZO91Oj5uMPi2dfPa9MqmmiDzeJJzQbxwBl6wnEUZf92YeGxmHY4ulQli9Iu?=
 =?us-ascii?Q?8P5FVttcqLAfWD3EPco1/JiUaqSAPHvT5mUbCAVARQJ/Q+6TQCfGhMZz7Fwg?=
 =?us-ascii?Q?mHc/on1h2gO614lYj1fRE8rfRZcmJeONnAMyIgB44uLp7Du5rfsnBDSy4J89?=
 =?us-ascii?Q?sNM7VqMzkV1za1M7sLjGChQCpU504TTYEXr1T3Z8o3714+OXbK0WNaHQjwOX?=
 =?us-ascii?Q?3Rk+b5RwkifHQD4kEUgjhD1Ru4pVMNMG6QQVVdglZbL4VBz7zxWct55Rxp2C?=
 =?us-ascii?Q?2rGOS3AwmWDC/eXU740Sye1X+KwGB2XSHmpwpxhJcObUlHGLUCtylyu2WsYW?=
 =?us-ascii?Q?jhTgxMEV75rqfU3gT8XV0OK4raGiymVONx40qKO4p9EXwMCwLBCrfIlH/RJU?=
 =?us-ascii?Q?EfOfwYG6HSqtMyUJnFE0v1ZV71pE6c7nNWGYOadwT6u6SLCR2hmLdeXU1gBL?=
 =?us-ascii?Q?0VyAkqn6Oxe1ttgH3/LyAtQPkWYsxKvUQc0h7zJas3PEU3Hr6mSM+1ogDMYk?=
 =?us-ascii?Q?HVmqWwm0Ubp2C3/WY/dpRIr/E0SDifu6e+1K2gVEE4mGd/cJQWg+NEJ3r5zs?=
 =?us-ascii?Q?3ypTYC1nBmYu+k08hYwsoVJI43wXOqzaQUJMaA6qZBGFXVCk+sBVJ9nw8Xzj?=
 =?us-ascii?Q?niy00imKx2YV7hXR7WWYPl4ippywLLhtiz1ThhePMyFrLiN7K0wzehur4qcc?=
 =?us-ascii?Q?Qf1LyxbxhRxIZ5+zsjLZdtrm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gN6Gv3X2M7Zn8Mnyn5BSgBsEL0jRMTQUAJC3x+vqcc6wHs1snVJ+hFIsIe1z?=
 =?us-ascii?Q?U4oUQkD1jvWz+a7fWXQWVuCHD3x7YwsxikkGvnftcYUI19bWJGGEetH0nf3B?=
 =?us-ascii?Q?oAt4RFFZJkBShv0gzSnMpFO3f2efN8rVYzs+G84/40F5I+ELCZoBRPMNoLhZ?=
 =?us-ascii?Q?CwOfhy3NiRnmrRyUZAEhNnCNsgFk1D//wiy1q4I8N543RvLiuSXENagCEEYy?=
 =?us-ascii?Q?23YwXm0gjlinWac839fVZl/r9dYdY+OQpvM2eQRPsncCrZL4bOXnWDYKb7ir?=
 =?us-ascii?Q?WcKAsAiKVeKe9330z4RFDCf4XmkCeO3ZT6BfUKb5KmY80tCMTD126uTlDV/5?=
 =?us-ascii?Q?YEbY/pu5s1DinWm/B0kPy5U4w0X8oGoNx3zOjBnBx7KUIUDNIVVfnURttH6Z?=
 =?us-ascii?Q?anetF1UbHI7uh2S/70B3xnFVfhVGaCXSwmFTjQonxkz3bQXGVd1YHUJ5X5ps?=
 =?us-ascii?Q?NtlYtZ0+8Ja61vHtXO02FIoN8ztFww36tyD4qsoiMDusebosGwq2rk0hFL3s?=
 =?us-ascii?Q?xLAyc6z5Oal7E+4KALV5PdHjqWJHStdd9zZ+IXPSeReJAotGyptLEQLKqK/6?=
 =?us-ascii?Q?4E82/RW4iWDHwQFUND9Az30OWB30/4/JWy/U+dTmiVn1nmxoCDQtbIC1A4eg?=
 =?us-ascii?Q?Jsc9X9sF8dGYXtw+k1PG28HK+gOYBVg7yT0agwEpKAgOM0ZUgouGGaB9vqFB?=
 =?us-ascii?Q?aGLhaL3uS6+/4KwoXKmxsQlfQNj2ukKFrsyN1qSm+VeFalQ3CGwBYnZdzCzs?=
 =?us-ascii?Q?lSPRrIrC+ylJrVOXJswSwsxkhp4YgDN8lRZ8wFErIAtR+QI4M2dZAG/B/X0b?=
 =?us-ascii?Q?J2S0By2RmUDBMs7+KRSwP2VvyzeI9zbO1hQNVmKlVo6HkFoVryTfoss6+srW?=
 =?us-ascii?Q?t2qF/c+MUsbr2QjXH/1sO0+2aRN4q+RWA7iYHouA2x7SSwFMxEgpg4leOW77?=
 =?us-ascii?Q?vxmj1k9RbYowl9lpes5ySsOu3DfvM0dJ9OfpGOxpzhPXtdpAMlbztDy2jZLL?=
 =?us-ascii?Q?Jh/vuFH8SV7t9saBc6JycM58nHA59R96cvXK+xe0sedkInl9D1OHTUs0ei+G?=
 =?us-ascii?Q?TjDTbEYogF36KuJTpxYquAjWFnE+rj7LGBlO3zZBwUxmkY1lH9KR4AND+gxM?=
 =?us-ascii?Q?WxE3ExJDiveN4gfjke1Bve+eHIwtYEMHBch1pfL+3sHkz3JiUVx1EcC2jE0v?=
 =?us-ascii?Q?KI/0DSXY88nWwNjwrZ/13ZfXiRG8fNxAZUkKhUfWh6fSSTw8HQOQMZbv2/g5?=
 =?us-ascii?Q?oQQvTLgKDOt+lhHCsTz4pk/9suiaadbO06a+hhb0lFdShCHhS2u8phJ4TlT9?=
 =?us-ascii?Q?H+FdkkyX+J3Lpl8zzv245HzDoOgvHKqelSHjqfOnmgs4BlDXGBU5K04SjKx2?=
 =?us-ascii?Q?DUqVG9wGNALgFrqeQQ9YMJHNqtwuDSCgZVDf/XQtK4ZeXww4ggImdsfL4fYN?=
 =?us-ascii?Q?zpUcjHi7TRNaMmGcBUCf7mVbtXmLjSm/hqKmdIARQfcA3TPDhpN6fXtB5Ovc?=
 =?us-ascii?Q?559xOb89+8K934RnnTO/7komPguA/qwAYRAaQfGFbIpoqqVOHm99qDkzfyDO?=
 =?us-ascii?Q?Seu2ThFxhGLuQPsKUnPfRmR9q044rE4UIXXa2oEvRcuG4h+QTd49I1f+JrWl?=
 =?us-ascii?Q?0g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kvr1pNlkus77hHPyskuktbBoJ3GFkjuFdZHwiOK8hKC/3dZfEA6hvB+8cK/+gJKsE1Nqb8VavckITOcVyfygvTDjRAEbtCJlcHvA6Q+N0L9TygcF91OAw84Xs70wbLb75lrSipt6Pjss2uLuXAsXCWIx6Ilx1MRIwQ/r/KtPpjZZ0rVsPb3H+NVXKOA38WkrXXJT7imrZ6WIcjdBOcbtxJVQJNyG1ZRObtU5JZink+nYHXD4sWtaHueGhzBx/wplHBrw9npEQbAGxSzaUnNMHpZPyVALyglAleMk0mP2K4z9KJbNvIHxcwzTF1zj/ps/V5jrosCO3h/0u3IKcqFeoM8E+7gM/YGk5eiRSA6+KOSVVRmLhcYK0to1LV9J+pPuTIHkRGeZ9LROHW8afBjLWK2ZqxZ1JCBbi6CgH5HwdqbA1ecXuXRQT1HzyaOeVuSmwPbFcvZyktHNBqcUjVNU1nimzV+pgxYyhbUcjCS/+4CD5Iv4h5v/fZo1ZU1o2zahI+O7Jwl0BPebj1JpIoPp2jMXrMQ2B7U7sgqz1+LCGtJ41E1Jk3RAVP0ykU+gBCAz20BJLoKkt+5NUKOmaJiZGcM3ZuINLoAXdy5ikCLoSGU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d658920-c360-4121-a79a-08dd0b1bbec7
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 17:33:15.0432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JJ3b0HP3P0kgq8EhUDZZvwYRiDfg1ClKOkOhzeo4iVQXSxj46QbSsasOle/3MIp3hVXyDgEmphfQgpO7rDjfyqUe3JefJCTTVmbVRAKxp1I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB7023
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-22_09,2024-11-21_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411220147
X-Proofpoint-ORIG-GUID: FnFhdi02TxtFtN1lbMTLPcx1Gj5KRs5v
X-Proofpoint-GUID: FnFhdi02TxtFtN1lbMTLPcx1Gj5KRs5v

On Fri, Nov 22, 2024 at 03:40:31PM +0000, Alice Ryhl wrote:
> This type will be used when setting up a new vma in an f_ops->mmap()
> hook. Using a separate type from VmAreaRef allows us to have a separate
> set of operations that you are only able to use during the mmap() hook.
> For example, the VM_MIXEDMAP flag must not be changed after the initial
> setup that happens during the f_ops->mmap() hook.

Nice, thanks!

>
> To avoid setting invalid flag values, the methods for clearing
> VM_MAYWRITE and similar involve a check of VM_WRITE, and return an error
> if VM_WRITE is set. Trying to use `try_clear_maywrite` without checking
> the return value results in a compilation error because the `Result`
> type is marked #[must_use].
>
> For now, there's only a method for VM_MIXEDMAP and not VM_PFNMAP. When
> we add a VM_PFNMAP method, we will need some way to prevent you from
> setting both VM_MIXEDMAP and VM_PFNMAP on the same vma.
>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

LGTM, so:

Acked-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com> (for mm bits)

> ---
>  rust/kernel/mm/virt.rs | 179 ++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 178 insertions(+), 1 deletion(-)
>
> diff --git a/rust/kernel/mm/virt.rs b/rust/kernel/mm/virt.rs
> index 3e494e40b530..2a49c29a49c7 100644
> --- a/rust/kernel/mm/virt.rs
> +++ b/rust/kernel/mm/virt.rs
> @@ -6,7 +6,7 @@
>
>  use crate::{
>      bindings,
> -    error::{to_result, Result},
> +    error::{code::EINVAL, to_result, Result},
>      page::Page,
>      types::Opaque,
>  };
> @@ -155,6 +155,183 @@ pub fn vm_insert_page(&self, address: usize, page: &Page) -> Result {
>      }
>  }
>
> +/// A builder for setting up a vma in an `f_ops->mmap()` hook.
> +///
> +/// # Invariants
> +///
> +/// For the duration of 'a, the referenced vma must be undergoing initialization in an
> +/// `f_ops->mmap()` hook.
> +pub struct VmAreaNew {
> +    vma: VmAreaRef,
> +}
> +
> +// Make all `VmAreaRef` methods available on `VmAreaNew`.
> +impl Deref for VmAreaNew {
> +    type Target = VmAreaRef;
> +
> +    #[inline]
> +    fn deref(&self) -> &VmAreaRef {
> +        &self.vma
> +    }
> +}
> +
> +impl VmAreaNew {
> +    /// Access a virtual memory area given a raw pointer.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure that `vma` is undergoing initial vma setup for the duration of 'a.
> +    #[inline]
> +    pub unsafe fn from_raw<'a>(vma: *const bindings::vm_area_struct) -> &'a Self {
> +        // SAFETY: The caller ensures that the invariants are satisfied for the duration of 'a.
> +        unsafe { &*vma.cast() }
> +    }
> +
> +    /// Internal method for updating the vma flags.
> +    ///
> +    /// # Safety
> +    ///
> +    /// This must not be used to set the flags to an invalid value.
> +    #[inline]
> +    unsafe fn update_flags(&self, set: vm_flags_t, unset: vm_flags_t) {
> +        let mut flags = self.flags();
> +        flags |= set;
> +        flags &= !unset;
> +
> +        // SAFETY: This is not a data race: the vma is undergoing initial setup, so it's not yet
> +        // shared. Additionally, `VmAreaNew` is `!Sync`, so it cannot be used to write in parallel.
> +        // The caller promises that this does not set the flags to an invalid value.
> +        unsafe { (*self.as_ptr()).__bindgen_anon_2.__vm_flags = flags };

Thanks.

> +    }
> +
> +    /// Set the `VM_MIXEDMAP` flag on this vma.
> +    ///
> +    /// This enables the vma to contain both `struct page` and pure PFN pages. Returns a reference
> +    /// that can be used to call `vm_insert_page` on the vma.
> +    #[inline]
> +    pub fn set_mixedmap(&self) -> &VmAreaMixedMap {
> +        // SAFETY: We don't yet provide a way to set VM_PFNMAP, so this cannot put the flags in an
> +        // invalid state.
> +        unsafe { self.update_flags(flags::MIXEDMAP, 0) };
> +
> +        // SAFETY: We just set `VM_MIXEDMAP` on the vma.
> +        unsafe { VmAreaMixedMap::from_raw(self.vma.as_ptr()) }
> +    }
> +
> +    /// Set the `VM_IO` flag on this vma.
> +    ///
> +    /// This marks the vma as being a memory-mapped I/O region.
> +    #[inline]
> +    pub fn set_io(&self) {
> +        // SAFETY: Setting the VM_IO flag is always okay.
> +        unsafe { self.update_flags(flags::IO, 0) };
> +    }
> +
> +    /// Set the `VM_DONTEXPAND` flag on this vma.
> +    ///
> +    /// This prevents the vma from being expanded with `mremap()`.
> +    #[inline]
> +    pub fn set_dontexpand(&self) {
> +        // SAFETY: Setting the VM_DONTEXPAND flag is always okay.
> +        unsafe { self.update_flags(flags::DONTEXPAND, 0) };
> +    }
> +
> +    /// Set the `VM_DONTCOPY` flag on this vma.
> +    ///
> +    /// This prevents the vma from being copied on fork. This option is only permanent if `VM_IO`
> +    /// is set.
> +    #[inline]
> +    pub fn set_dontcopy(&self) {
> +        // SAFETY: Setting the VM_DONTCOPY flag is always okay.
> +        unsafe { self.update_flags(flags::DONTCOPY, 0) };
> +    }
> +
> +    /// Set the `VM_DONTDUMP` flag on this vma.
> +    ///
> +    /// This prevents the vma from being included in core dumps. This option is only permanent if
> +    /// `VM_IO` is set.
> +    #[inline]
> +    pub fn set_dontdump(&self) {
> +        // SAFETY: Setting the VM_DONTDUMP flag is always okay.
> +        unsafe { self.update_flags(flags::DONTDUMP, 0) };
> +    }
> +
> +    /// Returns whether `VM_READ` is set.
> +    ///
> +    /// This flag indicates whether userspace is mapping this vma as readable.
> +    #[inline]
> +    pub fn get_read(&self) -> bool {
> +        (self.flags() & flags::READ) != 0
> +    }
> +
> +    /// Try to clear the `VM_MAYREAD` flag, failing if `VM_READ` is set.
> +    ///
> +    /// This flag indicates whether userspace is allowed to make this vma readable with
> +    /// `mprotect()`.
> +    ///
> +    /// Note that this operation is irreversible. Once `VM_MAYREAD` has been cleared, it can never
> +    /// be set again.
> +    #[inline]
> +    pub fn try_clear_mayread(&self) -> Result {
> +        if self.get_read() {
> +            return Err(EINVAL);
> +        }
> +        // SAFETY: Clearing `VM_MAYREAD` is okay when `VM_READ` is not set.
> +        unsafe { self.update_flags(0, flags::MAYREAD) };
> +        Ok(())
> +    }
> +
> +    /// Returns whether `VM_WRITE` is set.
> +    ///
> +    /// This flag indicates whether userspace is mapping this vma as writable.
> +    #[inline]
> +    pub fn get_write(&self) -> bool {
> +        (self.flags() & flags::WRITE) != 0
> +    }
> +
> +    /// Try to clear the `VM_MAYWRITE` flag, failing if `VM_WRITE` is set.
> +    ///
> +    /// This flag indicates whether userspace is allowed to make this vma writable with
> +    /// `mprotect()`.
> +    ///
> +    /// Note that this operation is irreversible. Once `VM_MAYWRITE` has been cleared, it can never
> +    /// be set again.
> +    #[inline]
> +    pub fn try_clear_maywrite(&self) -> Result {
> +        if self.get_write() {
> +            return Err(EINVAL);
> +        }
> +        // SAFETY: Clearing `VM_MAYWRITE` is okay when `VM_WRITE` is not set.
> +        unsafe { self.update_flags(0, flags::MAYWRITE) };
> +        Ok(())
> +    }
> +
> +    /// Returns whether `VM_EXEC` is set.
> +    ///
> +    /// This flag indicates whether userspace is mapping this vma as executable.
> +    #[inline]
> +    pub fn get_exec(&self) -> bool {
> +        (self.flags() & flags::EXEC) != 0
> +    }
> +
> +    /// Try to clear the `VM_MAYEXEC` flag, failing if `VM_EXEC` is set.
> +    ///
> +    /// This flag indicates whether userspace is allowed to make this vma executable with
> +    /// `mprotect()`.
> +    ///
> +    /// Note that this operation is irreversible. Once `VM_MAYEXEC` has been cleared, it can never
> +    /// be set again.
> +    #[inline]
> +    pub fn try_clear_mayexec(&self) -> Result {
> +        if self.get_exec() {
> +            return Err(EINVAL);
> +        }
> +        // SAFETY: Clearing `VM_MAYEXEC` is okay when `VM_EXEC` is not set.
> +        unsafe { self.update_flags(0, flags::MAYEXEC) };
> +        Ok(())
> +    }
> +}
> +
>  /// The integer type used for vma flags.
>  #[doc(inline)]
>  pub use bindings::vm_flags_t;
>
> --
> 2.47.0.371.ga323438b13-goog
>

