Return-Path: <linux-kernel+bounces-417005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5109D4D8A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 14:11:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4838E1F21241
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 13:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8817C1D7E5B;
	Thu, 21 Nov 2024 13:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="g49WW1sa";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nSsjEMcz"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80461B0F0C;
	Thu, 21 Nov 2024 13:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732194701; cv=fail; b=H/iAoLv7x8MqpEcA+JCDwfuJ1ECvg+H7ypjyQK/QdU9xk1T9E7cIQ/XDi9g6sFgOPFqydeTdajFKGP+3JG57RhGVu5Xn3iiIrVavjI9XbDhSXm8VaP9GjpwFjWCPxzN8agOaCcFDZImqVrlA/6VGuM/DErKhGAE/vAOFj0yWefs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732194701; c=relaxed/simple;
	bh=Q2RiYH034da/JExgqVI2jniQydGtFRE13PlzncR3P6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SwVGaZ9V0pAFNNYzPlOnZ+scz7O8+LFanYzDafFmAIsgXBs8Q4dKh00UyeLnFgTG6WRREdT4ozGam6rjfpfJl3ttDM2YK1AWgxdpaMgVHTuU7nOvItwgE6y+kCWY+VSHOY+vf3FZznArlz3mpPHrvCw84qQR99x5hR1Trv8BVzk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=g49WW1sa; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nSsjEMcz; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ALCtdx6028948;
	Thu, 21 Nov 2024 13:11:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=jClsrkTGT1HtWZfRhMIp34UkG9DjQ+cZ+EO+hqwAR1Q=; b=
	g49WW1saezIwfD8e/OKOp/tj/K3UME7w0ab7nxKHv+W+zoyuQumamZtWKZBgH6Fh
	siWsBB85JUCzPq/TgX1lbxTrQdkmY4vOhcZHxpJcjzQKP/FcWUxNtAX5RxpXKz05
	7o9qaFaKxxXcstoUZE8gpfSJeXFNxYQpoGJsQXNnE6kz9yx6MCGueiLxTzIr37a/
	8NiwCduYueK7ACUyK5hwCekuhWEvWmUqFuIyPot4iwqJXDEnOxJ0cSQ4KEZztG9B
	AkoCltG4SZWfyzvNmNcH759NYfYz/jrhuTEuR2k4qlw/+BLqiCKxY8ZIR7TbABxY
	Bt/s0SF7Doh3Leobt7Za4A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xhtc9m7t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Nov 2024 13:11:10 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ALC0ifl009754;
	Thu, 21 Nov 2024 13:11:09 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42xhubsqhg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Nov 2024 13:11:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HGH6pZfGjJCdp9kdcVdQNf904eKGbycvEFWEx6MmkM8ucEzscSEhV1Co7mUq4uF1W3wECqNVcloX9mIEfg8zpBi4hjKubJx/Fi9VKpEoMrnFgi6Ohr1kP4sq/gk/t+IuRPQgPWFihrzG3IexDZiQi4hZSBwPpq/7z0ol2SFMUxvN6JEpZPmyaAlijJlBMHWtzdyiID54KATX38GnyBCvEJgAgPPQkMiXRl28vaP8dKYelM71OWAnE90xd2QVwXW1BKBquok2b/BV5H6d6QdzsqW4Dew5w0GAc97YOB/DO+BsRs8IQKQLrl+DygX/8yY7PUnvvvcBaYYxRSr8/5EGHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jClsrkTGT1HtWZfRhMIp34UkG9DjQ+cZ+EO+hqwAR1Q=;
 b=OaASwJJ7g9RgXkmgZsQxUdrN6hyS3D54pMrvF9dpwhS+oo1COuU8d9eqeewJ5ER++Ln1PLoLFHYgSh9MAjmH2xXCz17M0GH9UXqJY615VBV/8m2LHT8SKyqFqTV935MgSr7OnmQ43owBuBvzsInhgTZcvhn0Qr2wgJqg19oB6J8i2AwOiczi0v+2vWjtU41YP8KlLCmVHD2vicSnDwb+cPPRB2ULHCE6bk6nOJNOZJaPZmDjDMctYv9N7jR5LNz1VmK8kFDJBJ9CW1FcdBaQIaymTfsweSVXED6w4HpGTPI6qyU984oOKC3t5nWn3nQPiHy7rj8WJmL7pKkLYKbJQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jClsrkTGT1HtWZfRhMIp34UkG9DjQ+cZ+EO+hqwAR1Q=;
 b=nSsjEMczXu5xnsmpm6fwFSoG45AjI/6H1oenXNsQF6pkKro4RGpyYCWWe78UN5USNifvYDfBzKvn4sUREX1YgMHn4X/8qdWNq3uJjwzdzgcj8yYCHDd6C49RMjScV75xYmWDmEJ/qQ1vhtmVSZSM1n/rMXKYBtsvr4llapZ/nmw=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by IA1PR10MB6267.namprd10.prod.outlook.com (2603:10b6:208:3a1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Thu, 21 Nov
 2024 13:11:04 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8158.023; Thu, 21 Nov 2024
 13:11:04 +0000
Date: Thu, 21 Nov 2024 13:11:01 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, John Hubbard <jhubbard@nvidia.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Christian Brauner <brauner@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, rust-for-linux@vger.kernel.org,
        Andreas Hindborg <a.hindborg@kernel.org>
Subject: Re: [PATCH v8 7/7] rust: miscdevice: add mmap support
Message-ID: <6a8b01a7-0088-4635-a542-cb1a8146ecfa@lucifer.local>
References: <20241120-vma-v8-0-eb31425da66b@google.com>
 <20241120-vma-v8-7-eb31425da66b@google.com>
 <bd95657f-0fcf-4c13-a02a-d7293aa5f5ea@lucifer.local>
 <CAH5fLgjz7nd2DfqKJfDKFpODJ_TUMP1omN+7DqTnpqTNrXTC6g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLgjz7nd2DfqKJfDKFpODJ_TUMP1omN+7DqTnpqTNrXTC6g@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0100.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:191::15) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|IA1PR10MB6267:EE_
X-MS-Office365-Filtering-Correlation-Id: 185577ca-e052-4757-b9e5-08dd0a2df43a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YnNlTkp1a2hHZGkyRmtNUGJiVklBL3FPcis0Nlp5Z3ZpRTEybWVvUjRCcGZN?=
 =?utf-8?B?UWczWFdFMGtEWENGQVFoaUVpVVFqcFBOS2t5MDltdVozMC9pbGd4VWhGajlQ?=
 =?utf-8?B?RHdvQ2VXT3p3ano5ZXZzVVh3SVdNaFQyZG9PRFM3RHBzWG1qME1xTG5YQXFX?=
 =?utf-8?B?VDhjVUVYWVFNbFJDckl4cWErS000RXhVODRrcGRYMkNKUVhldGJoWFN2cXJY?=
 =?utf-8?B?S3oyVXBjZnora0VJS0FLeUFnc1Q4djdwZm5ZekRSRlFOaFdYZ3ZWazc4MWZC?=
 =?utf-8?B?eDNsaDVNcitIZUNHOWVnT2dHYVYwTFMyb2xrSnc4dzRnUi9vcXplNmNNQnd4?=
 =?utf-8?B?SkFOQVBLc0R4Mk5VSDZKOFNtQnNBNStjMjZtMWFVU3d6VzVqa1RJTERKMTN2?=
 =?utf-8?B?NUdjYkpBMm1Xb29iZWoyVTlMaEpJaEpvd015c2pvSXN5bkhyUElCUFZYY3FP?=
 =?utf-8?B?L0RlM3BZdldTR1pRM2ZLNm9paDFlbzIwa2Y4bldCaTNpNVIrRktaamVsYkpi?=
 =?utf-8?B?MHlCR0I1bkhLZXBJUzlGZFdSU2g0T3cxc1ZYbXR4OVNETHg4TFBjeXJjSXlq?=
 =?utf-8?B?bXNNaWp5dkdONWVKNlAzTEttRytEZmpKZldSbTFRQ0dSa0V2M2M2MGQ5NUNo?=
 =?utf-8?B?b3RGREVOTDYvY2JmZnVnWUU4K2ZHVmVpdUhoK3ZHR2ZHdzhvWmNXa0d1ZFdN?=
 =?utf-8?B?bTVzOGZtYlV3d3VjU01YTStKR3NBS0wwZjJqT080bVE1ZnZmaW90R3hoNTBw?=
 =?utf-8?B?K1dvdXJVRytzc0FQOXBCN1NIQ1BpSkpLYkl1WklCaDVxRVZyOTdBd1ZCeXpN?=
 =?utf-8?B?VW5scXIyRHkwbjFYTDJXUTB5VXdnNE9LSmE5WjZFUERtS0dUaCtIejZlUTFu?=
 =?utf-8?B?MG5PeVVYVC9JbXYranRHOU9mTUV1ZjBPdFArdUkvK3Z4VzRWN01UNjcrWWhC?=
 =?utf-8?B?cW40SitFSkM1REhmOGNWdmtmZmRHTytEWGxVTDhaWkYrNDQ5MkszeEJlaytv?=
 =?utf-8?B?c2xuMkdoQWZQYTN3Vi80aEM2Tkc3RzN2aEM1ZnJMSHhnRE5yc25FS2ord3Fp?=
 =?utf-8?B?dE1OT3hkLzhiT2pwVWlSUHd0dHVUWVc1aDVRaHc5d3JDQ3pIbGRPV3BKamVW?=
 =?utf-8?B?cjdSZ2pSRkwrR3BuN1BtVzFzMmNJU2xMekdyRjlQclJIcFpIZ2FYUmVJVHJi?=
 =?utf-8?B?TlgwdkxZMldtbUlWL3M3SEhmUW9MNnJVVWlLZHlpQWNwN2dQMWN5cTJkanp6?=
 =?utf-8?B?VlM0bTM1eE9IWUhIdzJJeWxxY0lXRXNHZjZ1QVN0bnR5K3FJTU41MFdCTDI2?=
 =?utf-8?B?S0VKb2pYblJrVjhpYlBiMzVPWjFLR1JtVXovTGVDQTZyL2tiL0tzcm1pSlF6?=
 =?utf-8?B?d2VkT2I2bVVXd2xwREI0Wk96ZC9RbGZESFVkMXcwV3JLbUs4c053K2lVVVZ5?=
 =?utf-8?B?QTJTbUVKVzVXTUtka1liK2tjYUMyWEVrOEdYQ0VYRy9sZ2hNTmQvSDI2enli?=
 =?utf-8?B?UnMvMW9DMW1vY0tsT1gxakxtS05aaEtJc1ZvVEtlc290MFRlcDBxMUxJY1dz?=
 =?utf-8?B?ZUttZSt1WE9naFFXcWFEMGpoRFova3BBeWZZSUQyWnhmN25jWXVMT2cvSWFG?=
 =?utf-8?B?MnhzZ0E0M1FIV1JMVWt6R2dsVmM3UFh1K3ZLWTVhbUFDQW9wV2Y2SGJaZVBL?=
 =?utf-8?B?SHp2ZnVOTCtDandRYnpkU3FpckFGMzJRenp4TXllazlKanFTWlYxZWUwdFJN?=
 =?utf-8?Q?NIUsrLtvFccA3MNju1QeY+3H1gjyTz2fFGKnWky?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y3M1ZTdCVlZhcmwrd285ZytNd3VjcTgyMURYam1kWWkzdXl3amVQYVBFVzJ6?=
 =?utf-8?B?cDJiaEN3NEFDQWt4ZkM5Rlp4eDVvSkE2WGJVaHRVdXlseFpidnhlWUE4TCtI?=
 =?utf-8?B?QWdza3B1d3RmWVB4THhyYStiU05kYzNHV2V4ek9WdGxoc0o4VnV6K2pTNk54?=
 =?utf-8?B?TjdJL2FCM0JGM0cvbzIwOXdBcjd5NlVQU2crSFVnOGlQVUFkdmZ0WXFnZUlI?=
 =?utf-8?B?bnNEZVBRdXdRWUlEVkFsVGhzNWcwVnJuSWtQeHBYMThJeEJiNStzcGdHV1Fi?=
 =?utf-8?B?ZUltOVpvdSt3Nk5tOCtUY1FLak10c3J1UDVhR1hoazRlb3pabUFkWURFakZo?=
 =?utf-8?B?WHUzZWtCNnYzR09CNHJNK1ZGRi9BV25JUXdadTBTMi9CQ0U1U2luMHg1WGt1?=
 =?utf-8?B?U2krbTFpTjB0N0N5a0twditvWEdsVDIwem9uWFFUSEJKVVhTOWIyWnJrOHZO?=
 =?utf-8?B?bkRXcjFyY2pESWEyZ0F6TytvTFNNOHh3b0JJVWlHZGgyS3JJVDVrbFQwcldx?=
 =?utf-8?B?NkJXU2lkRTNXaUhhdEp3V3F6ZUQ0dm5GTTFnb3FJNVFJZnFqZnA4WWdSV3dw?=
 =?utf-8?B?K2hzVW4zU1FYMU96OEFsRnludUFzQjVkdnc3a3lHbUNQVURENXYzbzZ6NFdq?=
 =?utf-8?B?eUFaKy9DMWtlclp1bS9UZjlYMmJldW9yU2FTUlM2WXlxU1FhZVFEODMyNi9T?=
 =?utf-8?B?SWpmcmxzU1ZBVkRpNkJUcmZWck54R1ZVbzF1OHhmUWs2UWx0cDllTHRZOVFm?=
 =?utf-8?B?ckdrQlFzWkxCbktVUElXa0VyYklEMkxoK0VyakY1VTVzbjg3MGR2Q2wzSk1I?=
 =?utf-8?B?ZUY0QXZFZWdiSmp4MEFWWjY1TjNkQnozSmZUL05UbWZtUlBFM2JNMTI3S1E2?=
 =?utf-8?B?YWpTZG00bVU5dERhWHR5RlVHMkwxdGt2RzRxWW8rSGpRU2tYV2ZycnRvUWtG?=
 =?utf-8?B?NnVwTnRYRkNBWmI4Yld6ZEtXRzYvNjE4KzliTDJGTnlWeXk1STMrYUVxSWVL?=
 =?utf-8?B?bXJoenlJbDRVMzRxY1piV0JoUlZvTUV4UzZEcEJrTHVFVUtZdDhGaEpGdk9L?=
 =?utf-8?B?cUorU3RmUUQyZ2tBWWVpQ1VKd2VPSDJzd3YwSFE1d3JCZitHN2RpTVNvem1x?=
 =?utf-8?B?RUZKUUtESG8xd1E5TGdUUXNFTS9RUWJrTXlZWVJpbURpcjdXWk9LOWw1M1RT?=
 =?utf-8?B?UE4zVWJWOGNHem9KalRBUEZmdy9jeTZ1ZWNjRjZXZ2xXa0Z4cmFkdFNDT0Qx?=
 =?utf-8?B?TDU4KzlkdUpaT0txNzJMMUR4MElBUzhwb3ZqSVZ0WFFzejFsYzhURGJWTlI5?=
 =?utf-8?B?YjFEUDRjaC9hWkI3YnB4Rlo0cUtsRmQ3bWlHbUZWZzVBaGdMNC83amE3c0hV?=
 =?utf-8?B?STFsaHdHRnZWQTNPY2NWaVlhV25GaVJXS2puRVFjdThBbUZtRVlreFBKbC9m?=
 =?utf-8?B?VS8wMHFiNGh6ZDJtYXpjQUV5NENqbm9RclQyZ1E3WHpXRTNqR2c1Z29IaVB4?=
 =?utf-8?B?NnVjcWFyV3RFSWZKUFFnaEUrUUpwb3N3c2w2SGF1bXFTUHJRMVpSeGxBQWNn?=
 =?utf-8?B?QUZBZzVkT0N6MWo2czdMMzhkdXNPNnZ2R1p2bGlTWHlWZTcrUnVyUWJYMHlQ?=
 =?utf-8?B?RTVkM1lUb3g3YWU2bWpDUHZtUCtJTFlvbG84a3I0WXpDSSs1UXkzZ2hUT2Iv?=
 =?utf-8?B?Ny85VE5YNDU3TnNNcXF4Ti9WYWtLUVhIWFJLMi8vb1lXQjNlK2IrWEtRWXlw?=
 =?utf-8?B?ZG96TnJOekN6T0VyY1NWMXo2a3Y4M2UzdWtBMk5Fbm1DUHVuUU9kUWNvQSs3?=
 =?utf-8?B?aTF5cFpGUVF3RGc2ekJxSk1va0FtL2RiYk9ZMGx4NDYzT1F2eitTeDJUSkU0?=
 =?utf-8?B?U1FwdDlzcE1MbnZvYjhlQ25iUVlvRDVIWlpEZGhyUWNWZEFhMHZsN0V5MGx4?=
 =?utf-8?B?VjVVVksrMHZYSU9zTUFJekpDUmtTZ0NuV0xwWUhjR0xOekNHbjRERFVFank4?=
 =?utf-8?B?MkxXekdyRE0vZU1DYmIydkYxeDc4SS9xdUdldGRQNWRhdXF3MXcwa2RpS3B6?=
 =?utf-8?B?TXFaenhDaWFEWEpmWWR6QXFMSVVEK1B6ZmZaMTRTY2phSkRSYWRkN1ozRUxC?=
 =?utf-8?B?MVIram92VEU0TjFKZTNmdGRXdG5tMnF4RVZNYTliTkhTVFArTEo5NWhKR2VN?=
 =?utf-8?B?VFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BfSE4x2v238jV0NY574bJ5N+SSXngl2Kef8IUBXffxooslFwMGXFBV2dUkvf9ZqXGT2bS5UXLpQNfDlvF6QDOXGQxFlx/kZTbc8Q98FmMfFHWzPO0oKhvPCB6nXImcXcS0u+EdMsZvp0/oJfmjGzpPmU0KndyY2zPzrVUtTJixqMOSxWaJOAHpVh1kh/7uId/U0Eg8Gg0nB/lkdKpvQs9/gDjrdjHExjqUuhoN/OSqerUrgffJy0nBlx8nmzQlpDy8xZOclA446UYMGoO/iD7uGJvUcj3W7CFAjGMzPP7ryu2kA0IYVsMGZlmDVrxf6gWvGln/hf12+Anr3+1Gu2+z7pFhKXTKiyP9ROEHwIpXkNK0D1OpdUXsxHV9G+9yubZPGcdT/NYHGcfuv+hKk39R1XuJmfzU6VQ3tjv28LBtF5XNVZTqo+wzZpqe6IOwH/0I4o+qGHFMmIzoUIEZpkJ2SvPJem7ie+oM48q9gK55K8WPNa5jOya1CTzn+vJWJ84FWH7+1wS3kTsUzcf+IEEvaaFi92lKhG7szShRqkVNOt9dU6MdxMsfn0+SmEMJu+6GCszr/CyDnkQuUqgzltOP7CY0Qf1fMGu092T+AdeH0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 185577ca-e052-4757-b9e5-08dd0a2df43a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 13:11:04.6157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EHb/OwSTNde9RcmHHnRO0nTK+SwPwOnKr2CmQ9V+AkqQXZccbtbePbTqcS1tn1ye5NNHx99+GLV9OMBdQVw281Z5nWcR2/EbhZ8JBNB7QpA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6267
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-21_09,2024-11-21_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411210102
X-Proofpoint-GUID: grltO0Pa5riJdH5fQgsqWwP4--e0WIXp
X-Proofpoint-ORIG-GUID: grltO0Pa5riJdH5fQgsqWwP4--e0WIXp

On Thu, Nov 21, 2024 at 11:08:05AM +0100, Alice Ryhl wrote:
> On Wed, Nov 20, 2024 at 9:07 PM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > On Wed, Nov 20, 2024 at 02:50:01PM +0000, Alice Ryhl wrote:
> > > Using the vma support introduced by the previous commit, introduce mmap
> > > support for miscdevices. The mmap call is given a vma that is undergoing
> > > initial setup, so the VmAreaNew type is used.
> >
> > Again, I'd be explicit about the VMA being passed to a struct
> > file_operations->mmap() hook on mmap. Otherwise this seems super vague to
> > me!
>
> I wasn't sure if vmas could be constructed in any context other than
> mmap. Will reword.

Thanks.

>
> > > Signed-off-by: Alice Ryhl <aliceryhl@google.com>

_Definitely_ need the commit msg update above, but other than this from mm side
looks reasonable, so:

Acked-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com> (for mm bits)

> > > ---
> > >  rust/kernel/miscdevice.rs | 28 ++++++++++++++++++++++++++++
> > >  1 file changed, 28 insertions(+)
> > >
> > > diff --git a/rust/kernel/miscdevice.rs b/rust/kernel/miscdevice.rs
> > > index 7e2a79b3ae26..4e4b9476e092 100644
> > > --- a/rust/kernel/miscdevice.rs
> > > +++ b/rust/kernel/miscdevice.rs
> > > @@ -11,6 +11,7 @@
> > >  use crate::{
> > >      bindings,
> > >      error::{to_result, Error, Result, VTABLE_DEFAULT_ERROR},
> > > +    mm::virt::VmAreaNew,
> > >      prelude::*,
> > >      str::CStr,
> > >      types::{ForeignOwnable, Opaque},
> > > @@ -110,6 +111,11 @@ fn release(device: Self::Ptr) {
> > >          drop(device);
> > >      }
> > >
> > > +    /// Handle for mmap.
> > > +    fn mmap(_device: <Self::Ptr as ForeignOwnable>::Borrowed<'_>, _vma: &VmAreaNew) -> Result {
> >
> > You will have to help me with this :) ForeignOwnable, Borrowed<'_>, _vma I'm a
> > bit lost here!
>
> When you implement the Miscdevice for your own type, you write a block
> like this one:
>
> impl Miscdevice for MyType {
>     type Ptr = Arc<MyType>;
>     ...
> }
>
> Here Arc is a pointer type (very similar to ARef) that represents
> ownership over a refcount to a refcounted value.
>
> In this case:
> * Self refers to MyType.
> * Self::Ptr refers to Arc<MyType>
> * <Self::Ptr as ForeignOwnable>::Borrowed<'_> refers to ArcBorrow<MyType>
>
> The last step is resolved to ArcBorrow<MyType> because of this impl
> block in rust/kernel/sync/arc.rs:
>
> impl<T: 'static> ForeignOwnable for Arc<T> {
>     type Borrowed<'a> = ArcBorrow<'a, T>;
>     ...
> }
>
> Note that Self::Ptr is short-hand for <Self as Miscdevice>::Ptr.

Thanks!

>
> > > +        kernel::build_error(VTABLE_DEFAULT_ERROR)
> >
> > What is this? Is this not yet implemented or something, and this is a
> > placeholder or something?
>
> It's a build-time assertion that this function is dead-code eliminated.
>
> There are two cases:
> * Either the driver does not override mmap. In this case, we store a
> null pointer in the fops table.
> * Or the driver overrides mmap with their own implementation. In this
> case, we store a function pointer to whichever implementation they
> provided.
> In neither case is the above function present anywhere in the final executable.

Ah nice, zero-cost stuff.

>
> Alice

