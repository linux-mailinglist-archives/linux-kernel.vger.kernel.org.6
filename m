Return-Path: <linux-kernel+bounces-389379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E829B6C53
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 19:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 918E82827BA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 18:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57211CDFB4;
	Wed, 30 Oct 2024 18:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Q8Ewb47q";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="l3JlX4j+"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEF21BD9F1;
	Wed, 30 Oct 2024 18:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730314404; cv=fail; b=s+Sg56Ytx54eNuMWA2I+5rug4NNU5M+AbXFRFBZGIN+RJQJlMyKPX5OiZBq5ksEy9lvUz6jnEPaTfg82sciN8XWNfrMiqj0BxbjNFstJGJGbNC/m5pJatsqD4KN+LyjShX2M2mKB+eTYjjCeflyd/sX9IT5ZBNTsoEWz6SqIaNc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730314404; c=relaxed/simple;
	bh=r60SwrPQmy/ZU37BLa0WawThUNB+enJLtvN/YVS4ES0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LfsjUrOSPmMMHsNR1A/xpRQfbA2V/C01Dt2XgeEc21AIdxI8sn6ImpSjnZq0niAQC41Ox407jMa/EYX1phNvA3YrcEMi89muInD+23YVq1GyGLxKwEnVTB6CY2O6N6pQ2lMmmQeWMWZXDfiZCiafRo1cwNAfxbQ0fPOlz5MAMUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Q8Ewb47q; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=l3JlX4j+; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49UGXZcv017453;
	Wed, 30 Oct 2024 18:52:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=8vUap59fqhFLkd6HWz
	E+fzBag5HdxBdtNv7bJZHgdws=; b=Q8Ewb47qWIO2PCobcqpc692HItkVJEzB9M
	z/MdfafxBtZbQ1ejNvQ18cq7nGUQmJjgWIX1/GfXL1pCW0R7cAlkuxbks3sws44g
	+vBXA3dVKgjyc0Jrdw9lYYJntdEpq4WjvEZfBa2IDd/UbxDRvc5CKuGvugvof6pz
	dSqcl7bUNG211sTnNeMkbLGfqvI3nPN7mhodzXNMOq3QlW5H9+Ov/9aKhRPoJtX6
	JsMlVnknEiN7VG9DvFSnKl4+ZdYLLZlNxff7ux1x4g7qAntgiWzumTZ7j8943zE2
	N3QBpWa5TCp2Oxs9stfePH54AAD1F7k/mlMjrM1qH6XIifCt7KtQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grdxrsjf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Oct 2024 18:52:46 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49UHjmjF040035;
	Wed, 30 Oct 2024 18:52:45 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2044.outbound.protection.outlook.com [104.47.55.44])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42hnaqypn9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Oct 2024 18:52:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TOd9xrlzmwmZqd6gl4sH3weKtX9nxgmF4Img9JyaOiTMDfYgSjxblMMIHSlaSOq5bbgWtR+bqjjcMMUTwiBRAcuYPyiy42q/Np/lYDWP4nf24+927/X2fjReaIFqKjRmhMIgnXd/sIkRqxSD7GVbzzS45Lkffr3q51DWVAGcYr0PvJA9phejvw0B04WF4bCBDjdsKLiM0GFrnEn8vqDyWxLQeTie5r+E6gz/BvLjMRYr6jvx+2nanXZudYuvryITjAaWDJA/X3LPzJFBUvu4omNNMJAD713Y6GLmFVNAMCh4K6zEnuySKLHY3aLP2N0wPs3wec4X3l8Nr1K77oYlzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8vUap59fqhFLkd6HWzE+fzBag5HdxBdtNv7bJZHgdws=;
 b=Sum31O+HSB0HFFQWS1dcBAPsybDwk7DMifV5qCVdW6iH82m4ZfYYc+s154ubRFPa4Chrz3rCTWwUtNgjDhg2gX5GNy7hFbF8kRRGQIAR03YRshBRNO+7mFKEiRMtMPEiUIiKVTlsMADDfQQxnDuF1c5mIe9ce6fdt9KILH2J+B63eHgygJm3nhWKAFpCJdmSY8wqAcOqrLiLyhw2hEAPMy/HTJ9yowjbSW599pGbz1U/tKSnLnS6jAP1vKYXtlMfBSlo/kqFL17tCBKOVniH3t1dAzHCsuP8FSw8T6vpG8nBPj1+ETprTFY8xV1glEPW8NQjwVvEMd8fxlNs9Ajlqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8vUap59fqhFLkd6HWzE+fzBag5HdxBdtNv7bJZHgdws=;
 b=l3JlX4j+k+c6zFiJqtDWRIJV35+SkY6gsDxVXxLRbzC5CGaE/7Iste9G4GQqQ/lWgY8wiyINRl8t8GhtJXu6tc/cCmlPTMRFI2RMFrZGJLrvoE7dtrIBcj5sxeRuUwGHE6Xnh6uwxDeCki+PVecbMWP4ujYFl2ShplxZykUmL00=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by IA1PR10MB6784.namprd10.prod.outlook.com (2603:10b6:208:428::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Wed, 30 Oct
 2024 18:52:37 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8093.027; Wed, 30 Oct 2024
 18:52:37 +0000
Date: Wed, 30 Oct 2024 18:52:34 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, John Hubbard <jhubbard@nvidia.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, rust-for-linux@vger.kernel.org,
        Andreas Hindborg <a.hindborg@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>
Subject: Re: [PATCH v7 0/2] Rust support for mm_struct, vm_area_struct, and
 mmap for miscdevice
Message-ID: <92da645a-3224-493a-a687-1738cae1ec07@lucifer.local>
References: <20241014-vma-v7-0-01e32f861195@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241014-vma-v7-0-01e32f861195@google.com>
X-ClientProxiedBy: LO4P265CA0190.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:311::18) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|IA1PR10MB6784:EE_
X-MS-Office365-Filtering-Correlation-Id: b8dc9814-baa3-4403-dbb9-08dcf9140609
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tEkqZlorXZba302F8i515WrDWhzsKKX3tZAJLnsOTaj2Nq78ZukmtOwcs4Kt?=
 =?us-ascii?Q?xboNkbYslDUlmI64riLs112RvrgCT5aXCPONH+kn0ZHRoP4UPodsvQPMC/xO?=
 =?us-ascii?Q?32ffSzuQJrOFhfH1M5Hvca2ooyz29XuklboUAjV7J2KsVhuIb6ozHHWDwL4+?=
 =?us-ascii?Q?80ENfWW+wRY6bY8FkuNF2NFAuMZkfD1VYJGsnS+kyCtYZg60H492Osp6VdtO?=
 =?us-ascii?Q?iy/wl0kIU/Jprg4YvHOCL/EqsZAsycs/R1IWDql9kAtLwCnzemH66pb1hFAD?=
 =?us-ascii?Q?8Gw135VGIXMN4RYy/YtSniYdC7hmAvdn6JrPqKI35r37Y3KefB/MtSjB6Jja?=
 =?us-ascii?Q?cryta87v23ywBk3FIbqR8BwTUgpgEH2VlaS79jaeSFvF2CoRpVxiY48pJi40?=
 =?us-ascii?Q?RgSNA1uIz0P/9vuCflomm9ysa1xrP9u32vHNJJiGfpOHyMlw5I+blOOnlc1Q?=
 =?us-ascii?Q?wece+hGCKt7qRSMGXkFBA7ZRSBVngcZDP096nmG2gAxWcT+gwyyYA2zk+g6A?=
 =?us-ascii?Q?XFSnuv7ZMAESReMLwrrOaQHWmJcwcyIPx18OMPETro3otjJIHnlkkolTmxdi?=
 =?us-ascii?Q?I87JkyMlI6bym7zR6f+OZBh72tHJl5SoEsv9UbJSrTuzfDYNkCirEmM1EH3b?=
 =?us-ascii?Q?s0HKYkTXeytjDpslQuHWAGU6JnYBF3+86NE8k/BkA+Ps1FlC1vDC8Qg+s3ls?=
 =?us-ascii?Q?Qb6ZyfhQZOxmVRnKYf30sAfV5dlbwvdAMnChuSw0nA0tLOTFDcUDtJ8C2DBt?=
 =?us-ascii?Q?nV10aWgy6Dajc2GoQy4V6YvzSzTR0yyZGpKW53YqQHHU+4VGEudL41g2KgFp?=
 =?us-ascii?Q?3lZUnijj7eRa7TjMmjmFiWHwAxGN/2vb+gxq1xz5kXv9ay2yQ60nfUBjdtzA?=
 =?us-ascii?Q?DFv1iCLndYifQ/cwx5EElLJqdXadc+GZQjgW2Q7xCfuUaFiOdC5u3J9ecpeT?=
 =?us-ascii?Q?8hMVcyZ1C71vAZV8vS54otxnidL8F32WFzBYrf8h971hSBE5RIQN2aLYdIL7?=
 =?us-ascii?Q?uahYxmPDjJfZ4D29DAemyWh3AhWsIwrDR3c7Ag8Qww8YdnLnzMTIrIMRLWM6?=
 =?us-ascii?Q?SnjRqI6rLUdIVcPvD7dIXc1XaxPnJ5BrQm4+a4TQWBD++pS+VYzJsvc/KNiP?=
 =?us-ascii?Q?qbiL5fcTlzcWLaDBNJlOYyPxJ8NLH98jELVWfCoiExX2VE8RWpieLnMcweq+?=
 =?us-ascii?Q?X4QsoufvKLt7uh0q3Xk0KxdTpQOyH9G75nfWpAjxx0VhBdkmPOkxZPDtAgqJ?=
 =?us-ascii?Q?MipB70ID+LgpWbUm5/vGIjOsvqijXjmxGTaOafs1Kr93GneQKSFLhKkTdzI1?=
 =?us-ascii?Q?Inp1Teri2+JM2toJy2yUQx+m?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uFzZ0hDVegGUZiN9PvwvkvRTyZSQgQWNnP1nyml1uzuaAdzdyD0SUycgCy0k?=
 =?us-ascii?Q?0nMxtNRJeifNohTtTNiZjnivhCA9xnxw6nCYbn0MJQg9BWBIBlLTwz1vxy+1?=
 =?us-ascii?Q?TH3wd2oqWoo27brla63xbXojae6xzoWjstKudh2+TYlCouK+6qDGzOeuuVl/?=
 =?us-ascii?Q?EBqJNESi0KU1TQK3yHWTbOm0dG74GsWFnqZS6H01Y7tWpFWpn/ux4yemCV1z?=
 =?us-ascii?Q?bQEWSgGMbA5nBkSVmB+Ne5KSeQEfdpOuKH7TE7aG1BXXTD2blehUG3j+S2fN?=
 =?us-ascii?Q?hmQfTVjjhyVsvFlN/orH86dHemb95fmSx14fsGQ+ktYZd/UXPknl0Y/j/7jy?=
 =?us-ascii?Q?OtN2uWGJwtonf1vmORu2jJIqiZdoepZD1xfTmDxXF/8rx0+EkaawArDe++Qx?=
 =?us-ascii?Q?vSF659O+W4asZiNEIOZfOp8WltIRUlX+zdClVCQWFBQ53NbBZLePrO3E8PNq?=
 =?us-ascii?Q?GS4zsXLgkp1hUixUDoW86GX8T+zUmGwfKtSdaAKH4Mmxl6Gsm7ACWLCuqdA/?=
 =?us-ascii?Q?/4xqtg/7FC+A1QJJyfbF0fq5m4VlHaqPRyMcs5WObpufihdZPnYslesQ2T79?=
 =?us-ascii?Q?5hROQn/J6LKKOa8aLWjWPDuPat3uBTAA8U2n8jdOtR98i39YF+Wsx51yGh8u?=
 =?us-ascii?Q?4FDebu5D8Jl+3xKshp2AspngZrjKOulRRFlFJsXXZom/TgRPix6vcrplHKvp?=
 =?us-ascii?Q?RI6Ro7sr4SylCJ7ZbtztDENUH479ESajU434ORBapKor7OS/4TZcKluCpLm/?=
 =?us-ascii?Q?NTvUV7a85QAngTEQOwio849HPXcoxAyT/n3k/NjtkMdzfLug42Fj2D/D/1Xb?=
 =?us-ascii?Q?b0chpIrt1aTuaLQzw6HWktTrqmQYc4L+e+dkRIL5s0JZYi4ldr4pG/rm9Mt+?=
 =?us-ascii?Q?9Y+4suII6MMAfPTu4tP6TnXmkJPaTxq06eDkXv7MZuHcUv8ZO7lterxgSdkX?=
 =?us-ascii?Q?BAGcgx//CuqN1m4tJ8BbvgVTcG5sEqubGET4G7F9XKOTt9JqhFmAiXuJV++6?=
 =?us-ascii?Q?p/jlm3yFMJ/Q/ZC+IhAEHvHHxSpKP1Mq/Vir8bEPUXXUVCAH1goWvTSDHBeJ?=
 =?us-ascii?Q?ZboB90R6EO85O512Oam9afn0KmKXsA37AZs0jYGUOgs+ywaDXCYziIN8Ey2t?=
 =?us-ascii?Q?3jtPYkeML+lAC9Pv3yMSWhLkuzmsP5V4lIOzcNbrRizx8Bs6C7GXyxBRIqNy?=
 =?us-ascii?Q?hHo+Px2wQ+kdnk/3O06Ovsa6L7y6YUY/hsqe2HNqtYuNKQrX+t27sVrW6vXr?=
 =?us-ascii?Q?2JdHzKzmlAW6sb654VdMMN+3/o0ZELUn8+y1ssc6k50gU8yNPJ+mSajWBVwk?=
 =?us-ascii?Q?v29TL2DLmcOsmQn9ZGKho9uz7r4ddfvv5V3mshtw1lH7/XSQqiGBxdaX3K1G?=
 =?us-ascii?Q?imKnTzrjdXxvoa08Lb2Ug9FdM/BJqrHtTg+J/E8n4vXiJk7Qcov2BJuQuaqi?=
 =?us-ascii?Q?wICp0OcLP/SjEQpNL/VSwGNti0q66OmIdSH+xubPiERD+9rYVsS+wzSQwPg0?=
 =?us-ascii?Q?T23eDLNSfL+j+ZQYCWunpcyWqitFA197JlFGjjb0gQUZuuFGepRNeU70byzk?=
 =?us-ascii?Q?8bdgjPNy3fcZVaqL7uf8iIeJGuU9671FeYGZIOvczz4cVFgEh1cWujoC1zAL?=
 =?us-ascii?Q?pg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2K5JyoqZ0xIHhj7zs5tW0Fj46He+rEvt3cGJ9B+RV1EHum6dzE5cFl07ewtwSUgVvssA67KKQFqbOCQ/IlLfx5fXSVoN9gpvKmAEjQZ2zabI8sw0g617aAUr3OEL+JzOMk+NH0NeyWMEJuOcjyWVpnDTvnqcwXKktCI0TOZYwabsrmKY7ZoCJvn8IxQ0By4wGoAbk+CGJQkYSMFRu806SrxQA+pDs5IsVYBbo2ubMl9U9bs58//5ba6Ne5jUKuxK7N6uNiFH7A+ZfoFy7L0yQPNxylT1VxUzeZm4abM6dzV8gQD8zI5HZTbnYEJEvX+lPHThzfXKQsy620qfj59MTAKpS/+1hMfdT21mMJEBItw0eQb3ds4KVLzS7r+bELM0On7vWy/8WWDM0ixUweTBF2nDtG+fhtFH3NRZQEd6xhw8FLw/H4fuKwnviDPAFaDDaIfLAzmPnn+533jXj4QTiTw22SrNvTOXb2kf7pOrsFIXcyURhfnWyJsTBjvZ+FfabEvLXDBHc7sr3EmSjBBWL87lgC1lbNT0hD7ftfc835bpzvQWNVmTMX8g9UfZ6TcnOZFmS2EUIE+qEOgUXcmx6qgITDfSVOBUObHupoCG2yE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8dc9814-baa3-4403-dbb9-08dcf9140609
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 18:52:37.8441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MrUUagNBSlI0szsNbXD3wPRZUGZzuKG6NURI3JdOffN1EuEgUC3nq/09uty+FtqX5kTzXAIxPO4gqkkevN3Bp3W36vORohtue2XCeqk9gg0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6784
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-30_14,2024-10-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410300148
X-Proofpoint-GUID: uRuER6QpQX4Li-s0p-5kYjEdYFMZol0f
X-Proofpoint-ORIG-GUID: uRuER6QpQX4Li-s0p-5kYjEdYFMZol0f

On Mon, Oct 14, 2024 at 09:29:50AM +0000, Alice Ryhl wrote:
> The first patch introduces mm_struct and vm_area_struct abstractions,
> and the second patch uses them for miscdevice.
>
> This updates the vm_area_struct support to use the approach we discussed
> at LPC where there are three different types depending on the kind of
> access you have to the vma. You either have read access, write access,
> or you are initializing it. Each case allows a larger set of operations
> on the vma.
>
> The first patch in this series depends on vfs.rust.file for
> NotThreadSafe. The second patch in this series depends on char-misc-next
> for the base miscdevice implementation.
>

Hi Alice,

Just to be clear - I am very keen in seeing this land, and will take a look
a this from a VMA and locking perspective.

I've been tied up with other work which has delayed me, but am
simultaneously working on documenting VMA locking (with various tricky ins
and outs around 'implicit' rules) which directly feeds into ensuring the
rust abstraction correctly matches expectation on the locking side of
things.

So I'd ideally like to get this doc update done first before reviewing, to
ensure we have good clarity on locking, but I think perhaps a good way is
for me to try to do both in conjunction with one another (will cc- you on
docs series when I send it!)

In any case - I will absolutely give this my attention as soon as I am able
to.

Relatedly - we've encountered issues recently in relation to locking
subtleties so this is _highly_ pertinent and equally _highly_ motivating
for having compiler help on this + a programmatic representation in rust.

I know Willy is in full support of this effort too, we are all keen to see
things move forward.

Thank you for doing this! :)

Best, Lorenzo

> ---
> Changes in v7:
> - Make the mmap read/write lock guards respect strict owner semantics.
> - Link to v6: https://lore.kernel.org/r/20241010-vma-v6-0-d89039b6f573@google.com
>
> Changes in v6:
> - Introduce VmArea{Ref,Mut,New} distinction.
> - Add a second patchset for miscdevice.
> - Rebase on char-misc-next (currently on v6.12-rc2).
> - Link to v5: https://lore.kernel.org/r/20240806-vma-v5-1-04018f05de2b@google.com
>
> Changes in v5:
> - Rename VmArea::from_raw_vma to from_raw.
> - Use Pin for mutable VmArea references.
> - Go through `ARef::from` in `mmgrab_current`.
> - Link to v4: https://lore.kernel.org/r/20240802-vma-v4-1-091a87058a43@google.com
>
> Changes in v4:
> - Pull out ARef::into_raw into a separate patch.
> - Update invariants and struct documentation.
> - Rename from_raw_mm to from_raw.
> - Link to v3: https://lore.kernel.org/r/20240801-vma-v3-1-db6c1c0afda9@google.com
>
> Changes in v3:
> - Reorder entries in mm.rs.
> - Use ARef for mmput_async helper.
> - Clarify that VmArea requires you to hold the mmap read or write lock.
> - Link to v2: https://lore.kernel.org/r/20240727-vma-v2-1-ab3e5927dc3a@google.com
>
> Changes in v2:
> - mm.rs is redesigned from scratch making use of AsRef
> - Add notes about whether destructors may sleep
> - Rename Area to VmArea
> - Link to v1: https://lore.kernel.org/r/20240723-vma-v1-1-32ad5a0118ee@google.com
>
> ---
> Alice Ryhl (2):
>       rust: mm: add abstractions for mm_struct and vm_area_struct
>       rust: miscdevice: add mmap support
>
>  rust/helpers/helpers.c    |   1 +
>  rust/helpers/mm.c         |  55 +++++++
>  rust/kernel/lib.rs        |   1 +
>  rust/kernel/miscdevice.rs |  24 ++++
>  rust/kernel/mm.rs         | 357 ++++++++++++++++++++++++++++++++++++++++++++++
>  rust/kernel/mm/virt.rs    | 264 ++++++++++++++++++++++++++++++++++
>  6 files changed, 702 insertions(+)
> ---
> base-commit: 2d424646119f28780f3963811025c05ea848b85f
> change-id: 20240723-vma-f80119f9fb35
>
> Best regards,
> --
> Alice Ryhl <aliceryhl@google.com>
>

