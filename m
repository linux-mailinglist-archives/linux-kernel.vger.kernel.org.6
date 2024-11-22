Return-Path: <linux-kernel+bounces-418569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D3BB9D630A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 18:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB35CB21B12
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 17:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2C51DF725;
	Fri, 22 Nov 2024 17:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hEncJetn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EUrPrX3D"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE15518AEA;
	Fri, 22 Nov 2024 17:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732296493; cv=fail; b=LymD1U5O51tbovB4XOFdwC/G4P2+vEnyIH2gKDpuvzuADjqzP/pDxqLVfmlJtknZ6y5Nmvfl3kYtaKiw+E9NjhntnuLdkuO462/8+hssOETfTxGBj9yPRwAZS06Wp1EEXEyQjI5D4B8ynvBEK5czMxmqHa2EHExp9RNMG+lvyoI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732296493; c=relaxed/simple;
	bh=YYIafnWqTTMb23pU880oey89Xl1nR3HBXr+5Ffc8BgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tVaAqEb04edmFtiLgSJYroCgQDps4fFnqMhjWHU1a6TQhusyF+4gYqQK+KL9PGZ53PFeXoND6pspco/vmwvCvlgpnjal/lKAxXMYG0VizEMEqTjC3Z3C8u2VZ7pOpqEzNgntcmpDgHbCmTH+WrHUZb98GRLjvJai3rDRRB9I94o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hEncJetn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EUrPrX3D; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AMGBbMh016291;
	Fri, 22 Nov 2024 17:27:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=OSUoKqsbKjNnMedwWk
	R49gLpXbX3BCySCt2w9Hvi7wc=; b=hEncJetn7PoJsm6bpSdReqQnO4zMIucZT1
	EaISqdjL9Op1xheHwL/Dns7CCYImMdVu4/GjRvCMTmHj2EgPmlt8BECHsqI/6ESq
	cbh3g56JUwBde1PCDdp8O9ndaCff26MPSnKuIxhZx9kQTEL4TC1nU6ZaYZuupw3y
	JbqYUwpCco9XzTMbE9TQw0Qz0JMKVuHvS6qaOm8DU+OKCvWqrq30jz4G6HLN2WN3
	Mz/ueMj/ETYp7j/MFGRsrd6tidx1yc7ULUwp2tx/04lBPYjBZITrlr3UDNG+iT/W
	cS9IoUFwElY4ixqY0EQYTZw1pnkd1DJ0uXm3sq6YVzJ/7RE2Lx+g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xjaacpf0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Nov 2024 17:27:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AMHFBxv037310;
	Fri, 22 Nov 2024 17:27:43 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2043.outbound.protection.outlook.com [104.47.58.43])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42xhudmegm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Nov 2024 17:27:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wMe4A+nzl+MmJR9vOgAOOy17YQMnTbrWHqfOKzCXi+gnL06XyufQxnz9thTwQohxi+r7fdG2ExH8yJ7jqYls7bFTUY3qS0mQUAFujuXp/AwtMSAcBvzYxd1qaXgGQbINWBfnrqBOv1pR/BgnQTqB/8ahX3HgSxuLVnLxAaNbjTCFkgSGn4N2FgVScJcnNXCWUGsASjcnkwem1vdMCFVSKVNB9TLZjEI8xDvyign9Frd62hIQgWnX3AB8aArMD6dt3JpTvjrnPNpzwkhd73gTMPLAAA+G7QhgK1WN+q8cljn3RWDWvOWlKrhKfw+FHUe0H8/yqgfKWSHeqjE+V4ZTCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OSUoKqsbKjNnMedwWkR49gLpXbX3BCySCt2w9Hvi7wc=;
 b=VFCPcVfhElKsij0kynaft1zgrfhYKBhKW59Y3c0QSo1IgTi6QDYw3N2rgpKwbNVYCE7ucTqFUj5Hlt9+NYROpZz0+E78cv6z0AT8IIEZqS2F84YfLC7coG4AY9q1mXLXkSzOl9Vzv+2IAO4e3+2mWc60MojiSvvFLZRCcdJjlzdlExnC/xe+1AvB8TxABqzIM9sZeZiGEltq6HKny6GorD8ucBRLThw6+nu0uww+GIWkMsOUwq5deJ/FSIOq45ZAkM1apUO9guuAIbSA3kl4j5WEl5K8hHmozUSV1iXuVVc2FcxWFD8lFLbJi5F+olD4yw949O0yrD/iT/Q3QPK5bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OSUoKqsbKjNnMedwWkR49gLpXbX3BCySCt2w9Hvi7wc=;
 b=EUrPrX3DApIX8wC5pCgZEV0mIvgbRhUMLMrJ2Y51wlEvHFuv64LIZvgG4ipDyjEbrsmiCWEHt8i2OILYxDrvU2+hr7w78ipvb+EN1+quPfsYCYxhdkWTR6VsSbosIGtCR842+qs1mvbVR/xDBFX6NekFrHDdt7hZ1hopYOheEJ0=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by BLAPR10MB5139.namprd10.prod.outlook.com (2603:10b6:208:307::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.27; Fri, 22 Nov
 2024 17:27:39 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8158.023; Fri, 22 Nov 2024
 17:27:39 +0000
Date: Fri, 22 Nov 2024 17:27:36 +0000
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
Subject: Re: [PATCH v9 1/8] mm: rust: add abstraction for struct mm_struct
Message-ID: <9f26e6d4-77db-4dd2-a934-c83008cf1bdd@lucifer.local>
References: <20241122-vma-v9-0-7127bfcdd54e@google.com>
 <20241122-vma-v9-1-7127bfcdd54e@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241122-vma-v9-1-7127bfcdd54e@google.com>
X-ClientProxiedBy: LO4P123CA0482.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::19) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|BLAPR10MB5139:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f094cc5-e94c-4dbe-0354-08dd0b1af6c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5AvEWP2c6TV08vLh67+OzQXzjjBqElwR87xk78aEIR6aHb8HIlkAXWPJHgaV?=
 =?us-ascii?Q?LB+0rEtSJFQTm61uS9OzJTDZSJwrw8J8soOtLqQaYl2CpGMNFd7ijhCqekIa?=
 =?us-ascii?Q?RvV8WYhp6qbpy782zSxvlkAhIVyH2k5oyhxqFNjna/NT9nrO2giKnoEQLAFn?=
 =?us-ascii?Q?KOLYeCMCLc58yGN40iKfBrlgKabQdcUfAIq5p5AehdwA5fu7IWQRySyxE2O4?=
 =?us-ascii?Q?tLKYI5uxRi6whVfzgE5BHQrVYfOtWFQ7BQ++k5LsMx2BxskWlAKIaiKX9PB5?=
 =?us-ascii?Q?s93qI78NahME/Ud9rp0/qPtnmmIOAWiRGL7Fgx69/8hcz4Uf3/oiGPTWZeRo?=
 =?us-ascii?Q?OlEvwXO85rw5WDgqet8Fk8jAh2A3C3Wz15ifWKzWpEYSXQdtTcIF5nkvinDX?=
 =?us-ascii?Q?1PrDs3ddqyXTJEESMKwVKOhcOSaS7HP4YiFixaoQP1xkR+aNdN9m67v9B5Xc?=
 =?us-ascii?Q?H2Whhaf2gAFvCl+jcfAVTwl18YXYaYafXm/sYuPJjZ0E1RDdocg3DzEnUhwJ?=
 =?us-ascii?Q?yXDJygancgvHnpMgQpvlT+LoRmDt0m3TTXP2yMQZrJTZK/o7dfDTzexuVJxS?=
 =?us-ascii?Q?hd1xAOObCLPGZ/SsCCUKBrk4rmrEfquYhUQFuUIiDFs/myRoHnTf0MdKRSNu?=
 =?us-ascii?Q?AuRi+0uPu+2fXbu5PNbzXgnMRV1solfXRaKYwpKQk90CGPChV3eshmH/IRQ7?=
 =?us-ascii?Q?uDJo4wOYzGnUBTichKnOymBYgY7MF65R2rKWCZ9AiCg38iz7fxVPaec3Uj3/?=
 =?us-ascii?Q?7ScJltyEKYob7hdtHeSJlhUd3v5C553j9Y0sjsAcI/yQ84rhDhA9vi4i3o6B?=
 =?us-ascii?Q?zz3KHH2Nodq8A6SSF5TtJgaJoEYniIUTw0TWKC76KcaLRRIIC+13vN7uKF7H?=
 =?us-ascii?Q?O0HkzV+4Iwdsl+Briqw7Kh9I0R47T5W+q1+cjcKkF33uAIdJcYp1iP8Y6tI8?=
 =?us-ascii?Q?agMgi4WIAMbdTrZtsK1Nip4JKlJnM1wPJ4esi5nLwgGIfCUoP+Xfpesz4Y1t?=
 =?us-ascii?Q?AMIBlcIHX+ZqZoDl4t1L30e/I5hfnNfwroZWVicpIL0mBRnO2oUOdCCWHTis?=
 =?us-ascii?Q?WYWuHmSUDGVrMTPyRb2MvrCSghPq/krgdoVYhlSZJ5+GEyWOHF08brlaZCwr?=
 =?us-ascii?Q?t0ZPXr9rOPBT9gmo8g7m3WYnRxBMEruj4UybiJfK7wA79X4G2K9+fKjZO/Rw?=
 =?us-ascii?Q?8dJEvoebKCtcl/+rI9tOgHkZVZPU1BKRLnrb+7eGNpD9PUsNueEzRZRDXAbF?=
 =?us-ascii?Q?Mvpo8NK5sf4j5TUzwuuUKIvF2sH7KLAHyaCeLEbcYYzhpe/btTLxTioWTFrB?=
 =?us-ascii?Q?cE4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rMynlYZ/44dPSLrkljJPQ36h700X8JZB332/hSkhVYaM4sx20ylk3epWJRM/?=
 =?us-ascii?Q?+8wUL7s0ubzeab2E+8sJtCRXKQWg871DQCMn202JW9wHYagLsBaAn9oHRE5A?=
 =?us-ascii?Q?NResI1o/iybYwjsTJy3bj5xhLOTxF3Q9YiTNstIh/CZpeAA9+xSV/LVWVVSx?=
 =?us-ascii?Q?ndxeZPH7xuGPEHW1hJrzf/RupiKug6TUH92CORdIEonVFnYbxxVCMPBEOGx+?=
 =?us-ascii?Q?sUgDsB4F/XoDJ4ebTLBlPQzauVRjTej0/2/32yBy+BL4YSF3n7Nxtwz9nVWH?=
 =?us-ascii?Q?PSHhL7QlpQcjAu6CQIVQSZKXa9DuIlbzp1PzLHHD1Kh5sI3jPqK9OnuANpK/?=
 =?us-ascii?Q?xKkjyC6SbDmjI7HJcbZSp+syjtHyeDKrRmGUei8yGTWSs0k0Vq7Qdq7E+upu?=
 =?us-ascii?Q?bvUidxwFNkEuEA3UlSdvlKO/ps5YjSdQMdjcMOVOGMRRRhDe4v8rg87ilhIh?=
 =?us-ascii?Q?sQfAQm3eFfmCFkNBv6QuNNDEBjS77WemxeLgNTfwxzW8cj8SABjmXzPbvWWB?=
 =?us-ascii?Q?HhqnKDHv0nYwjfhtLpeCT4sxoxZ8Bb22yVaqv0lRtuj6fl42ThuwaidPAj7M?=
 =?us-ascii?Q?+AvN0R2xKOQR/ZSQ76uhbmOm+m1zfu9Dr4gAarQAciLES5xtir2NUOFBxPvd?=
 =?us-ascii?Q?THMMMWsjaV1pp2HwCsitLkVNfgb0Qr4xVywYreCxvzkneaiO6p7cExdey8wc?=
 =?us-ascii?Q?d0InAA+V1xRBrzVhEtFAYhdH8uWtFXKLWzS2rGkDLVg+Bgg+/k4usGIXvdMX?=
 =?us-ascii?Q?QQgn8Kf4enL0wOK9XYJ2RdsOX+LaVKuA2hdzPUEkKlx6alQcgLAodDQ2bxSI?=
 =?us-ascii?Q?dvbcsV1/hHMCWI2nJe/OtK+BFL8EmyWCpDx5SDbZzq/diTF7xjrPdPnpr02i?=
 =?us-ascii?Q?Q25OXQiWfk+tk8/p56s3L2XOHAFOS+m5QuxNZhEg6Ni3bk7eWVdM8ilTxxsT?=
 =?us-ascii?Q?VGKdB+ATvlM572dRYE1P6i4vK8yxTRdF3H5p/42eYeVJ8CxwbpU0yp/ZLvCm?=
 =?us-ascii?Q?z+jk92GylteLScTD72VqofB13HMv+D4pVu8ekCzqj/mNOR2mTK6t5eVJtzG/?=
 =?us-ascii?Q?R3XFhjvp8lA7yubzcuohPuc2t3W4qQTxFMtAey4dvOaal32TWiWIBjQFtp53?=
 =?us-ascii?Q?uh72X0o0ehuYLf0pwvTYsDtqwoWbKg9PJRmA7NtvK+COMth2h+M/TrdS5riG?=
 =?us-ascii?Q?Trkkf69euQ/7cMI9RHDtnXzLGuzKTi1NbyjQdhfjqR/aW6VIkWbT2fl+gcEl?=
 =?us-ascii?Q?9Re6PYXWkU6NHDFvlvIw7QbX3lKEfsMzWCfb+BlWx7KWdUO73bTVUWdlCRbj?=
 =?us-ascii?Q?+antrMozQ9Cn0Qw9tQ+tkcMH/uJqBe/gBhaK7XgN6NIcrFOquhImAVDgHftw?=
 =?us-ascii?Q?nZvx+tt4yAbpr8ZGHUJ1Hj/89PDX12GUi+BF5uksRbcEQF60190uzTTdW+4L?=
 =?us-ascii?Q?4mRq9CmEiKVrxP9+6hr6rXlRZdMjGcuH81aBi/BwcmhtqxBN+3vjPYIyreEE?=
 =?us-ascii?Q?SnMgVGm72XMHxY96cN6G7PU7wBJILi+rwwtRf1G5yuADy+8PFT0ZhO0cL9hs?=
 =?us-ascii?Q?G42UCbWATG/5OpXlRm0frBp320NeCZMgWDcU+wdP+ccen4fg/mOaxEt1TWpx?=
 =?us-ascii?Q?dw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nST411oTiIpNvA/xCADJfGZ2z/v0q57Sdzs08wjTbVX6BZ9fKdQHO2PiPTppvIS+OGtdoI0zDaMj05XGkQKHkv+vJp4TQCWKu8aQsbTCp7X5ZWKdQoKoG4/+kl98NjfVjvwSSEJoDNzOZfaT0V/v+TcEzwD3TpWQ7s3K3FLnwOtUuKqM8SFn80v1t+4OSlHRVmqPyBBpJbwysPBtGCGxankQxCQZFsDnRFYD6+m6X9MXuLt+YX8PVHflKpuqcx059CZv3oP2wsGNk951kJjXjznR6+VBOYZ/buaKskPo5AR36E2rPwy/5BWEXvVO07T7uwnCNQeUh7wWjAONmun2yLkCXCosVLgBkKJ8hK/6KG5GH+hUYSn087k6WnSWSgjlLbb59ZrAGPZcQN8pKVHmAUTd/kjlkHJ58+AuMKHv5ugxc7I+OGjaHLAEhSLFL0OKlLQl54TJ1Vg7+1dwF/6VEZv34hiR+NYMqUd5A0IilfakIcqlPNTIRClZarx66na5l0gcU1GHtAJ6OiMJBgt744FrykQMHmW7m+uunHjJeDGsbTSHI2zSqgixlFwvTAmQerD5H/lIv//8Y8RRCwI2mRf+7wqobcZ6ybIpwdAksyY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f094cc5-e94c-4dbe-0354-08dd0b1af6c0
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 17:27:39.5798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wFVJ4Cjjg+xa/Xn78gasACe0YUa/0VBZwQzFziqETQdpiKYwooooYGcs8+qHwG2O5DTnwnVnxZQmWJ/HKAwy4cHaoFUWDbsIIrp/Yc7tSIE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5139
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-22_09,2024-11-21_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411220146
X-Proofpoint-ORIG-GUID: PXX1dTwjTU4aWmSyOj9sKX1_0jqUXjno
X-Proofpoint-GUID: PXX1dTwjTU4aWmSyOj9sKX1_0jqUXjno

On Fri, Nov 22, 2024 at 03:40:26PM +0000, Alice Ryhl wrote:
> These abstractions allow you to reference a `struct mm_struct` using
> both mmgrab and mmget refcounts. This is done using two Rust types:
>
> * Mm - represents an mm_struct where you don't know anything about the
>   value of mm_users.
> * MmWithUser - represents an mm_struct where you know at compile time
>   that mm_users is non-zero.
>
> This allows us to encode in the type system whether a method requires
> that mm_users is non-zero or not. For instance, you can always call
> `mmget_not_zero` but you can only call `mmap_read_lock` when mm_users is
> non-zero.
>
> It's possible to access current->mm without a refcount increment, but
> that is added in a later patch of this series.
>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

I see you address the current thing in a later commit, so as the rest of the
patch looked fine previously (with help from your kind explanations on the rust
side :), so:

Acked-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com> (for mm bits)

> ---
>  rust/helpers/helpers.c |   1 +
>  rust/helpers/mm.c      |  39 +++++++++
>  rust/kernel/lib.rs     |   1 +
>  rust/kernel/mm.rs      | 219 +++++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 260 insertions(+)
>
> diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
> index 6d90afd38c40..2ee3af594633 100644
> --- a/rust/helpers/helpers.c
> +++ b/rust/helpers/helpers.c
> @@ -15,6 +15,7 @@
>  #include "err.c"
>  #include "fs.c"
>  #include "kunit.c"
> +#include "mm.c"
>  #include "mutex.c"
>  #include "page.c"
>  #include "rbtree.c"
> diff --git a/rust/helpers/mm.c b/rust/helpers/mm.c
> new file mode 100644
> index 000000000000..7201747a5d31
> --- /dev/null
> +++ b/rust/helpers/mm.c
> @@ -0,0 +1,39 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/mm.h>
> +#include <linux/sched/mm.h>
> +
> +void rust_helper_mmgrab(struct mm_struct *mm)
> +{
> +	mmgrab(mm);
> +}
> +
> +void rust_helper_mmdrop(struct mm_struct *mm)
> +{
> +	mmdrop(mm);
> +}
> +
> +void rust_helper_mmget(struct mm_struct *mm)
> +{
> +	mmget(mm);
> +}
> +
> +bool rust_helper_mmget_not_zero(struct mm_struct *mm)
> +{
> +	return mmget_not_zero(mm);
> +}
> +
> +void rust_helper_mmap_read_lock(struct mm_struct *mm)
> +{
> +	mmap_read_lock(mm);
> +}
> +
> +bool rust_helper_mmap_read_trylock(struct mm_struct *mm)
> +{
> +	return mmap_read_trylock(mm);
> +}
> +
> +void rust_helper_mmap_read_unlock(struct mm_struct *mm)
> +{
> +	mmap_read_unlock(mm);
> +}
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index bf98caa6d6a5..104e619f5dbd 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -45,6 +45,7 @@
>  pub mod kunit;
>  pub mod list;
>  pub mod miscdevice;
> +pub mod mm;
>  #[cfg(CONFIG_NET)]
>  pub mod net;
>  pub mod page;
> diff --git a/rust/kernel/mm.rs b/rust/kernel/mm.rs
> new file mode 100644
> index 000000000000..84cba581edaa
> --- /dev/null
> +++ b/rust/kernel/mm.rs
> @@ -0,0 +1,219 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +// Copyright (C) 2024 Google LLC.
> +
> +//! Memory management.
> +//!
> +//! C header: [`include/linux/mm.h`](srctree/include/linux/mm.h)
> +
> +use crate::{
> +    bindings,
> +    types::{ARef, AlwaysRefCounted, NotThreadSafe, Opaque},
> +};
> +use core::{ops::Deref, ptr::NonNull};
> +
> +/// A wrapper for the kernel's `struct mm_struct`.
> +///
> +/// Since `mm_users` may be zero, the associated address space may not exist anymore. You can use
> +/// [`mmget_not_zero`] to be able to access the address space.
> +///
> +/// The `ARef<Mm>` smart pointer holds an `mmgrab` refcount. Its destructor may sleep.
> +///
> +/// # Invariants
> +///
> +/// Values of this type are always refcounted using `mmgrab`.
> +///
> +/// [`mmget_not_zero`]: Mm::mmget_not_zero
> +#[repr(transparent)]
> +pub struct Mm {
> +    mm: Opaque<bindings::mm_struct>,
> +}
> +
> +// SAFETY: It is safe to call `mmdrop` on another thread than where `mmgrab` was called.
> +unsafe impl Send for Mm {}
> +// SAFETY: All methods on `Mm` can be called in parallel from several threads.
> +unsafe impl Sync for Mm {}
> +
> +// SAFETY: By the type invariants, this type is always refcounted.
> +unsafe impl AlwaysRefCounted for Mm {
> +    #[inline]
> +    fn inc_ref(&self) {
> +        // SAFETY: The pointer is valid since self is a reference.
> +        unsafe { bindings::mmgrab(self.as_raw()) };
> +    }
> +
> +    #[inline]
> +    unsafe fn dec_ref(obj: NonNull<Self>) {
> +        // SAFETY: The caller is giving up their refcount.
> +        unsafe { bindings::mmdrop(obj.cast().as_ptr()) };
> +    }
> +}
> +
> +/// A wrapper for the kernel's `struct mm_struct`.
> +///
> +/// This type is like [`Mm`], but with non-zero `mm_users`. It can only be used when `mm_users` can
> +/// be proven to be non-zero at compile-time, usually because the relevant code holds an `mmget`
> +/// refcount. It can be used to access the associated address space.
> +///
> +/// The `ARef<MmWithUser>` smart pointer holds an `mmget` refcount. Its destructor may sleep.
> +///
> +/// # Invariants
> +///
> +/// Values of this type are always refcounted using `mmget`. The value of `mm_users` is non-zero.
> +#[repr(transparent)]
> +pub struct MmWithUser {
> +    mm: Mm,
> +}
> +
> +// SAFETY: It is safe to call `mmput` on another thread than where `mmget` was called.
> +unsafe impl Send for MmWithUser {}
> +// SAFETY: All methods on `MmWithUser` can be called in parallel from several threads.
> +unsafe impl Sync for MmWithUser {}
> +
> +// SAFETY: By the type invariants, this type is always refcounted.
> +unsafe impl AlwaysRefCounted for MmWithUser {
> +    #[inline]
> +    fn inc_ref(&self) {
> +        // SAFETY: The pointer is valid since self is a reference.
> +        unsafe { bindings::mmget(self.as_raw()) };
> +    }
> +
> +    #[inline]
> +    unsafe fn dec_ref(obj: NonNull<Self>) {
> +        // SAFETY: The caller is giving up their refcount.
> +        unsafe { bindings::mmput(obj.cast().as_ptr()) };
> +    }
> +}
> +
> +// Make all `Mm` methods available on `MmWithUser`.
> +impl Deref for MmWithUser {
> +    type Target = Mm;
> +
> +    #[inline]
> +    fn deref(&self) -> &Mm {
> +        &self.mm
> +    }
> +}
> +
> +// These methods are safe to call even if `mm_users` is zero.
> +impl Mm {
> +    /// Call `mmgrab` on `current.mm`.
> +    #[inline]
> +    pub fn mmgrab_current() -> Option<ARef<Mm>> {
> +        // SAFETY: It's safe to get the `mm` field from current.
> +        let mm = unsafe {
> +            let current = bindings::get_current();
> +            (*current).mm
> +        };
> +
> +        if mm.is_null() {
> +            return None;
> +        }
> +
> +        // SAFETY: The value of `current->mm` is guaranteed to be null or a valid `mm_struct`. We
> +        // just checked that it's not null. Furthermore, the returned `&Mm` is valid only for the
> +        // duration of this function, and `current->mm` will stay valid for that long.
> +        let mm = unsafe { Mm::from_raw(mm) };
> +
> +        // This increments the refcount using `mmgrab`.
> +        Some(ARef::from(mm))
> +    }
> +
> +    /// Returns a raw pointer to the inner `mm_struct`.
> +    #[inline]
> +    pub fn as_raw(&self) -> *mut bindings::mm_struct {
> +        self.mm.get()
> +    }
> +
> +    /// Obtain a reference from a raw pointer.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The caller must ensure that `ptr` points at an `mm_struct`, and that it is not deallocated
> +    /// during the lifetime 'a.
> +    #[inline]
> +    pub unsafe fn from_raw<'a>(ptr: *const bindings::mm_struct) -> &'a Mm {
> +        // SAFETY: Caller promises that the pointer is valid for 'a. Layouts are compatible due to
> +        // repr(transparent).
> +        unsafe { &*ptr.cast() }
> +    }
> +
> +    /// Calls `mmget_not_zero` and returns a handle if it succeeds.
> +    #[inline]
> +    pub fn mmget_not_zero(&self) -> Option<ARef<MmWithUser>> {
> +        // SAFETY: The pointer is valid since self is a reference.
> +        let success = unsafe { bindings::mmget_not_zero(self.as_raw()) };
> +
> +        if success {
> +            // SAFETY: We just created an `mmget` refcount.
> +            Some(unsafe { ARef::from_raw(NonNull::new_unchecked(self.as_raw().cast())) })
> +        } else {
> +            None
> +        }
> +    }
> +}
> +
> +// These methods require `mm_users` to be non-zero.
> +impl MmWithUser {
> +    /// Obtain a reference from a raw pointer.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The caller must ensure that `ptr` points at an `mm_struct`, and that `mm_users` remains
> +    /// non-zero for the duration of the lifetime 'a.
> +    #[inline]
> +    pub unsafe fn from_raw<'a>(ptr: *const bindings::mm_struct) -> &'a MmWithUser {
> +        // SAFETY: Caller promises that the pointer is valid for 'a. The layout is compatible due
> +        // to repr(transparent).
> +        unsafe { &*ptr.cast() }
> +    }
> +
> +    /// Lock the mmap read lock.
> +    #[inline]
> +    pub fn mmap_read_lock(&self) -> MmapReadGuard<'_> {
> +        // SAFETY: The pointer is valid since self is a reference.
> +        unsafe { bindings::mmap_read_lock(self.as_raw()) };
> +
> +        // INVARIANT: We just acquired the read lock.
> +        MmapReadGuard {
> +            mm: self,
> +            _nts: NotThreadSafe,
> +        }
> +    }
> +
> +    /// Try to lock the mmap read lock.
> +    #[inline]
> +    pub fn mmap_read_trylock(&self) -> Option<MmapReadGuard<'_>> {
> +        // SAFETY: The pointer is valid since self is a reference.
> +        let success = unsafe { bindings::mmap_read_trylock(self.as_raw()) };
> +
> +        if success {
> +            // INVARIANT: We just acquired the read lock.
> +            Some(MmapReadGuard {
> +                mm: self,
> +                _nts: NotThreadSafe,
> +            })
> +        } else {
> +            None
> +        }
> +    }
> +}
> +
> +/// A guard for the mmap read lock.
> +///
> +/// # Invariants
> +///
> +/// This `MmapReadGuard` guard owns the mmap read lock.
> +pub struct MmapReadGuard<'a> {
> +    mm: &'a MmWithUser,
> +    // `mmap_read_lock` and `mmap_read_unlock` must be called on the same thread
> +    _nts: NotThreadSafe,
> +}
> +
> +impl Drop for MmapReadGuard<'_> {
> +    #[inline]
> +    fn drop(&mut self) {
> +        // SAFETY: We hold the read lock by the type invariants.
> +        unsafe { bindings::mmap_read_unlock(self.mm.as_raw()) };
> +    }
> +}
>
> --
> 2.47.0.371.ga323438b13-goog
>

