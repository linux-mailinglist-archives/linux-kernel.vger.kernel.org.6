Return-Path: <linux-kernel+bounces-512772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED9AA33D94
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 12:15:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADD9A1887D54
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 11:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC4A2153CD;
	Thu, 13 Feb 2025 11:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LsvtghUo";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CfNQHa4m"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51D7214800;
	Thu, 13 Feb 2025 11:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739445303; cv=fail; b=kqXXvrI6BFPr/GofznJWZLBTc2ra5w6SRngv2KdayvCe1JHLuqZJG+sFhIM7UphbRX2Nf4+ANXbplrJRY5PToCqdMo5gnLDX4hmUVq2Uq7VGyJyDE/17DPNbqxVthPwdf2ULLEpRuArYe1qEJuq/Y6iIM3U393Hg2/PigIlBdnk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739445303; c=relaxed/simple;
	bh=r8JyKYfG0lG1P1bkb90yORYYGx3j6Z0EiGYP3Jauxkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bpuoWpyn9J8bqF/bewnohLQKJnvHTpZv1pfXAnUvJnJ1vlgTGgBo3zy8w0akCSvurL9nLzLPX22Ha2Xz3g2e8ux0enGqY0P14N4ko2Gf/N0m4BTBeNR9MqIXFJnSG5V+OsGbdhGRcaUceifh4CaC0K9rTqhzx/qdhZfVCAhiHTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LsvtghUo; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CfNQHa4m; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51D8fV4M022165;
	Thu, 13 Feb 2025 11:14:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=UkI6rL4fkI69bTSQVZ
	4DejYTeFtampS44T6A4lNmPIg=; b=LsvtghUoH3vP/WRAujhNuV1qP1l86ubrN/
	w/54YRoVEXfkJaHAESs2X7nDgVrdJqvsrbIgcDkatvxNojrn1CY+9WpeuC0rojbO
	8n34AdyquWOygsEY149psPBy/zZZggD/F0JRN4RxCX+EyR/2RnR8NZS70ydHkzgL
	HUm4gU1sPoIZ2fcsRVlFEnjC+37OvFR2Hnj6HE4q7FtbAILxL2hsjX3wbrjH7EFz
	92YgEgb4XLoFNOp4XM7NApkwBrR5F0/hgRbc2ZfJzgmhdrGnl/n9gAtwySNaNIt+
	wIKdjJ4nBDVFxAONI/OouCCcZuSYdZumGyi4NRK+voHfPm/fieIQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0sq9h8f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 11:14:34 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51DAMvep009818;
	Thu, 13 Feb 2025 11:14:33 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44nwqhvkdc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 11:14:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JkT+t/ncnWNZmGHQgDjrfe02uyctnpw6D7jpcWIav+8L7rjhHOxcPcgPFRrtpDUf2/q517WBhwelwfq0oidm/59xB39305SfufjtffOSYDkvbvOn0n1+bp1nu5+n8wejkcqOkZfcE1XddPHMgF0+2E3h8JHoMDEBgqYc9LZ+pkdzYK7GvF0f0jdFDSkt6gIMKmQpeBshYyMrXyEmc1Dl9rTqZZkpolH5IRzdiOJy3PZmOvkPrUW3Vga9mUYD1t4bZu82q7X6/Fm6XFSIv+dz2352agnwaMiuweKq9ThdlsQGOVsz7nTNEjY2/vrqwKI64j5oa8CgCf0K6SiQNOxyOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UkI6rL4fkI69bTSQVZ4DejYTeFtampS44T6A4lNmPIg=;
 b=Mx51vASIgwgCCvKE1OOqttbmXGnQX4CpTr1Tf2SJlm7h906CSGtNIxuL6hTEjHOJLLrXb0BujN9ZVNN6Pwmd2Z+g8RhfmuQzY7sPCCekuIhz+AQ2ApiZbuoFC6M6hJYgVpzg2lQZpXnZjhcK1oEETXU6bOXeI+laRtucdt9gDO0dyOBU+MoEvsEFkovPnFwF49UNN1j8GuQONCV0QOezpIoh36To4Hx54QD0OFCuzezkkHOBaAdmHblXJjdRYFiJkimSviuXEb+k+GEBDHUq5x4JRzq7Mak1aWdricSbpt/C6ZqTlzkGMHIMKeP2dtbSJstGz6V82CwRa0/VWiiD2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UkI6rL4fkI69bTSQVZ4DejYTeFtampS44T6A4lNmPIg=;
 b=CfNQHa4my0+A4dVUIIMiE5luVaWrDk13GQelgdhLGlc/k4DvWNN0Af4Iuvpz7kZSZ0y3RhtWmxTRc1yBI4qAhcGP+LPgkXYayD3Xo1SHYmrPh/t0BHGxeqGNjuTez78iUwP67v5C6LqUdlXft2RkOs57OaBHZBM7Ss7DhN47KBo=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by CO1PR10MB4706.namprd10.prod.outlook.com (2603:10b6:303:9d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Thu, 13 Feb
 2025 11:14:31 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%4]) with mapi id 15.20.8398.025; Thu, 13 Feb 2025
 11:14:31 +0000
Date: Thu, 13 Feb 2025 11:14:27 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>,
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
Message-ID: <8130a6d5-a7e5-402b-b05c-2d0703ac1ed2@lucifer.local>
References: <20250213-vma-v14-0-b29c47ab21f5@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213-vma-v14-0-b29c47ab21f5@google.com>
X-ClientProxiedBy: LO4P123CA0641.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:296::7) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|CO1PR10MB4706:EE_
X-MS-Office365-Filtering-Correlation-Id: 437bbd44-c50a-4273-8c5c-08dd4c1f96c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6HgMEw8Dk6xHgM/m2tt6ZM2n2rjYZBKOE+AMsBO4+DXdy5sFnLWuz11yhrhO?=
 =?us-ascii?Q?vVhcNMB1XF1VEdTIQcStPfRBN8OToyNSYz3JxZJY+mg65IdoO0qEimRuCv8N?=
 =?us-ascii?Q?AkgfbYAWW57PBxYfyGJ/O3PdDqlpDF21Mh2daYOb36vG1qHVOrIScx7HSfi5?=
 =?us-ascii?Q?u8Xiaiqn+5B5MFE+ISZDB7RYQ1vQcJvfhcuqtBBKcatbpbBTznWYv1xaw5Iz?=
 =?us-ascii?Q?TLl+a4U8gpRDBV0CUykFCxUHfVbn0ynVEr/2k+6w8dFao+NlEoVCbTPi6TjO?=
 =?us-ascii?Q?E5csiBUrXwsS5wk9q6bruzlHZyjjX1/oLzweWE1X4z1omFvgCGCw1rqO+/BD?=
 =?us-ascii?Q?AzxiD8G41HeLX80rwmM3eRnne/s0fNMRR7Ovewy8YyZoCODlABgVF6gDJrZi?=
 =?us-ascii?Q?Uo0FwD3/zA87ij+dn/Vyo9SNemuFjRVFUb9b8m67c19x2VLWibPe4mqzSME6?=
 =?us-ascii?Q?QFzNZduxfGvnnS9tALYq0lc87LQiNkw/y4Ni/oHdnA+y33u6zCR8R9riN67c?=
 =?us-ascii?Q?TMRfeUAZESHfoZNu2qnas18KDrkaBKg0MEkfm6E3UqjCvFceZn7frtTLAswm?=
 =?us-ascii?Q?BZl6DD7wpLNRBwDfpIGEkJsTYlZ59vc3r+7gKtU+a/f5ScLV3pl5Yy0EY2kV?=
 =?us-ascii?Q?qq19hdOpWp//BEV7vTGAbKFG/QP914msV4zABtJ6e2tOhFvjMttFIuOYCFAs?=
 =?us-ascii?Q?ZdMMmAoN5iw0bqHZb5KIHhAURoL02D0/tP7eBiPdL+9FoNwWz02VwIcgkizB?=
 =?us-ascii?Q?B6cm+qmHrLKcVF1JHIaPzFMgaWVq9lL6JeveE6qrDLXZKuGPqx8Ofpj60LqF?=
 =?us-ascii?Q?rf+ZH0Q6m6XUB3aM7YJ6U1rd3dn72h4mJgONr0ekQOuKkGHY+MkcRpuuR7PX?=
 =?us-ascii?Q?tSb09oN1Ek8mOvZAWw/3L3z9b+7hwXWUpx9ySVrjkUvLCLLBkxF7qH5jQXKO?=
 =?us-ascii?Q?j5X56Nj8FY54MCXCkRkW9Bs5MPAkEh03OuNjSDMiqxNurUsTkrUNlO8RFnsq?=
 =?us-ascii?Q?enytDjlZ8Tf1/LNE4vy1Q6J1QyhZtDGqA0Ys7+twmyYzG9oNRPmSQ9n0sLLS?=
 =?us-ascii?Q?OWCf7vJIac4Cs/YSmYOLKI5S3qLetlFRg+nrX33eJr2axXBNVdr5HNWmpvHC?=
 =?us-ascii?Q?9Nx3e7jeRRVpE5/cxc6Iymv4iuPblXXoAWJ4QMNG9MH6HGdJLjW5haSq+pv0?=
 =?us-ascii?Q?S++WX+9B1dtGr77FpIQS68Sw2bTt3Fqxwp1WVF0tC+jRcf62eBNW99/Pn5t8?=
 =?us-ascii?Q?R9DHdvVQYsjT/0QxMEkkea7i7r+sBclJQqDCZ+L3zY4YKKTkuA6dGmezZKwA?=
 =?us-ascii?Q?pMY1p70sZn8g+5GZiLtwVwYpi/2c5NqMk7Bw+wZzyM6pLk1hMBB7eBzwe7aW?=
 =?us-ascii?Q?+8W3Ya4sPGKpKBINKPwEzuOhQKUmUc8zdSBxifognQ4UnDIPkw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?K5IzAb2NTxpM07njigJ+goj70xtjyw5ESoHhjJ53iMAh8ZoxHgUKdbrMwVkF?=
 =?us-ascii?Q?QW0dMLKNb2pL/hCPwKzex6vOnTGn7ZVXP3Jmrj4YSYL4ZrNUgt1V6ZYvCcCC?=
 =?us-ascii?Q?b8oDMhjI6hkCdevtUhck1I3Vk1jtjNkB7LqPl0DS1OqvKmr0HeArg7YhV33U?=
 =?us-ascii?Q?1zqy60yhWl2d01LsA6WyzCVxFgnHPDkc0zlVU7IuA/qKzjsThZrBq95Cg21r?=
 =?us-ascii?Q?RhEydNSv00xuuCotaslsMHGuvHawTISFJE8pVoX+Pb/TctVgxqCYr+gdG7dj?=
 =?us-ascii?Q?wlzZRSabThK19ybzd13FqrXaUz+6A+1UJE2a2bZfP1qsfrMwCqBswhpznwWA?=
 =?us-ascii?Q?RRdXBYer9g8hmtySF1kgaoiW8gCJn7jdzByVbppONwu8ACS6/NI4YLY597Md?=
 =?us-ascii?Q?h5MRTdqSZW959s0kWLa2RZKhIwqsky0inH7IVWxawVdXCRIT3uAW1WB2ef1j?=
 =?us-ascii?Q?Td1zfrytM5HSiOAq2wkPa/XJnY3xcz4TqlYygo86cORvCh/CDwBu1NSnflyi?=
 =?us-ascii?Q?/CpWGW7d7JxIetAocZ7spNkySXi3iTW6PwtnyP1tTjIo0sEkXkjkA80/D4Jg?=
 =?us-ascii?Q?BmUOqll1WsM0a1U2DqN8Ak2zZfMO8hO1YbICjRYKnQSjOEN49AwQbolOUNCq?=
 =?us-ascii?Q?LpBGUmwmjnQHNB1iGRhjYIUDqiq1tyxnc3yj3csQ0Es+YZW3UZTZ1xbPcalv?=
 =?us-ascii?Q?YfCT3QOYqoxrU7YAW48t0UJ6fRUAj+G8UwqVvF3vQbF9XzyUoUvTw7qCjJTI?=
 =?us-ascii?Q?ECqtwVlNo4OQIPW/eD97aQi52b/xl35+TwD2kX8Q//GuXenMPE22Pe4KrHzo?=
 =?us-ascii?Q?nTjvWvz9tNo+kQzc5l5p+Q4BB3I9eIj83FtAk992yC1niParGMfJ21uoXvNe?=
 =?us-ascii?Q?jYxutBNj9eoZX8pohlh8HJ2U8pA8Rn+MJXdV5oFrJzdBrV//8SFQkG6ALDTx?=
 =?us-ascii?Q?BVaQx6Np34V1fnhQoCpuRxdNx7PD9wR2SOk8+Kowp4S3rKh1X2/Y96OD/MuZ?=
 =?us-ascii?Q?/6Qo8ByAKme7GnX5JjX32zvvZJfsb7ME/eO3QSNqNOQxn1Nmtt5bGLTYWVa+?=
 =?us-ascii?Q?Je6/k2Wr2sXYwRIXQVPXaLb0RzJGC5A8rLW8+KjhAyObkRKTDja4J1bim48w?=
 =?us-ascii?Q?3r6F0uXQS04iKLr4WaaLBmNrjVfO5NJXT0Y3qHjetKmVFW55Ta90+5M1snl5?=
 =?us-ascii?Q?hVE+ksyOCyk9h0lhpGB1goqeJePEsoY54Vz4qgUUP5sa4eyPdNzvTculPD1f?=
 =?us-ascii?Q?YZ+JklyRUuaDxEqjVpxG2hMOGEs2rIyLF+bFJatHYmz2rCguNE54cxW4xJzs?=
 =?us-ascii?Q?FjXUy1tWeX9iV+e03ZTUjvFpZdMK4uGaq0maAriLiK5x5T+jPtgKHc8L2z6N?=
 =?us-ascii?Q?vIB+lYLEOCQVImgMnasvU4xMcdFyF84btRtPKz1M2sQ72jlto85WiL5JXYZ6?=
 =?us-ascii?Q?1fK4/C0/cAcK7lPEbGpk48abjWKf4Pi0aqU4jLaJdUAZbdZztFzPIYt+Rgc5?=
 =?us-ascii?Q?NAgT5RkbxF9I0VR1s1m1MSRPhWr09fBcyoACF2xohGl6vD/esaUJSOaPcgAF?=
 =?us-ascii?Q?rnOXzhrlR1eQ+81j3duXLqM4q7lcrdEbJnl44WFNq8CRSav8+AdOppWQs5Ju?=
 =?us-ascii?Q?qw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rl697K3DGsiKmGwXnUgJK54s1EzbzNnd+pIP910EBNYkzLf8XkWycmbnTuddCg7ukAveS1NSOrCrvqHQNNgLy2PBo5GC2jn8pTmAtx1loJ6s/CPv2c3CLexuY/3lAezDJuzH+bnE/JuThjoEjy5WDIVOBHzHOiQ1uP2PAUv47y20OAygl5osHJ/T7lNiTP8twaYdELIVXy3gC5bX9BeC7dE/GzADnQX3BCTgHtXxuXI7WWBvlAkTc1VMrAbOV8IXif+1O30LnLKneXC/Nk9AHVcGqjYI8gpd+1UfnvZduJI+fab28uW+pUHvtY+vTuxOjECq2OsSP+jzGDdQgC3CDytFIYPffhr/WQrRaz0zwIHSF9DozHCZbbmnCQlF9q2lJAQPeYKYtla7E03pmVh334ixdkz2qW9WDX9aUxSA/pvq3G+bmhRW239sUU/TkNjl3pXPR21XZrb1qj7raDe1msAQvCG1tcK8t/uz/GzAdsUh9v31GpDR5xdasWgsNagi06JZ4xcGyVZVplkV+2OPi9Iq2roW1ZCWj+n42gIQpALTNluESry7Jsbh54U0NHIrNDU9E3OEHeY/vlOrJhonET1s3ExqaL9t0XA4hoWp7sg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 437bbd44-c50a-4273-8c5c-08dd4c1f96c0
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 11:14:31.4582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T/OXipd1NZ7MErKSK8zILGoYOz12obG50BpoGoiO6aC4eBCEuIk+iQj8lpXs89BlBfu43U1LNZmRr0CkJfwLPbWKzzU5WVGyNrcogaZ9GqE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4706
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_05,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502130086
X-Proofpoint-ORIG-GUID: FTHbtF0WVQHOrWQz4CdwGrBeVtNQYCQf
X-Proofpoint-GUID: FTHbtF0WVQHOrWQz4CdwGrBeVtNQYCQf

Andrew - this series has significant review and all feedback has been
addressed, I believe the procedure for rust things is that, where possible,
the maintainers for the subsystem generally take series (though of course,
it is entirely maintained and managed by rust people).

Would it be possible to take this, or do you need anything else here?

Thanks!

On Thu, Feb 13, 2025 at 11:03:59AM +0000, Alice Ryhl wrote:
> This updates the vm_area_struct support to use the approach we discussed
> at LPC where there are several different Rust wrappers for
> vm_area_struct depending on the kind of access you have to the vma. Each
> case allows a different set of operations on the vma.
>
> MM folks, what do you prefer I do for the MAINTAINERS file? Would you
> prefer that I add these files under MEMORY MANAGEMENT, or would you like
> a separate entry similar to the BLOCK LAYER DEVICE DRIVER API [RUST]
> entry? Or something else?

This is one for Andrew to decide, but to me it seems most logical to add a
new entry like 'MEMORY MANAGEMENT [RUST]'.

And I think it'd be ideal to do so with this imminently landing, not sure
if we ought to merge as part of the series or separately - again, one for
Andrew to opine on :)

Thanks for all the hard work Alice and co, this is great!

>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
> Changes in v14:
> - Rename VmArea* to Vma* as suggested by Liam.
> - Update a few comments in patch 02.
> - Link to v13: https://lore.kernel.org/r/20250203-vma-v13-0-2b998268a396@google.com
>
> Changes in v13:
> - Rebase on v6.14-rc1.
> - Remove casts that are now unnecessary due to improved Rust/C integer
>   type mappings.
> - Link to v12: https://lore.kernel.org/r/20250115-vma-v12-0-375099ae017a@google.com
>
> Changes in v12:
> - Add additional documentation to modules at the top of mm.rs and virt.rs.
> - Explain why the name Mm is used in commit message of patch 1.
> - Expand zap_page_range_single with docs suggested by Lorenzo.
> - Update safety comment in vm_insert_page
> - Mention that VmAreaMixedMap is identical to VmAreaRef except for VM_MIXEDMAP.
> - Update docs for as_mixedmap_vma.
> - Add additional docs for VmAreaNew struct.
> - Rename `get_read` -> `readable` and equivalent for write/exec.
> - Use mut pointers for `from_raw` for VMAs.
> - Update safety comment for fops_mmap.
> - Add additional docs for MiscDevice::mmap.
> - Don't introduce and immediately delete mmgrab_current.
> - Reduce active_pid_ns comment at Andreas's suggestion and link to get_pid_ns.
> - Fix documentation test in rust/kernel/task.rs.
> - Fix warning about unused variables in lock_vma_under_rcu when
>   CONFIG_PER_VMA_LOCK=n.
> - Fix minor typos.
> - Link to v11: https://lore.kernel.org/r/20241211-vma-v11-0-466640428fc3@google.com
>
> Changes in v11:
> - Add accessor for the vm_mm field of vm_area_struct.
> - Pass the file to MiscDevice::mmap for consistency with
>   https://lore.kernel.org/r/20241210-miscdevice-file-param-v3-1-b2a79b666dc5@google.com
> - Link to v10: https://lore.kernel.org/r/20241129-vma-v10-0-4dfff05ba927@google.com
>
> Changes in v10:
> - Update docs for `set_io`.
> - Check address in `zap_page_range_single`.
> - Completely redo the last patch.
> - Link to v9: https://lore.kernel.org/r/20241122-vma-v9-0-7127bfcdd54e@google.com
>
> Changes in v9:
> - Be more explicit about VmAreaNew being used with f_ops->mmap().
> - Point out that clearing VM_MAYWRITE is irreversible.
> - Use __vm_flags to set the flags.
> - Use as_ and into_ prefixes for conversions.
> - Update lock_vma_under_rcu docs and commit msg
> - Mention that VmAreaRef::end is exclusive.
> - Reword docs for zap_page_range_single.
> - Minor fixes to flag docs.
> - Add way to access current->mm without a refcount increment.
> - Link to v8: https://lore.kernel.org/r/20241120-vma-v8-0-eb31425da66b@google.com
>
> Changes in v8:
> - Split series into more commits to ease review.
> - Improve read locks based on Lorenzo's doc: either the mmap or vma lock
>   can be used.
> - Get rid of mmap write lock because it's possible to avoid the need for
>   it.
> - Do not allow invalid flag combinations on VmAreaNew.
> - Link to v7: https://lore.kernel.org/r/20241014-vma-v7-0-01e32f861195@google.com
>
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
> Alice Ryhl (8):
>       mm: rust: add abstraction for struct mm_struct
>       mm: rust: add vm_area_struct methods that require read access
>       mm: rust: add vm_insert_page
>       mm: rust: add lock_vma_under_rcu
>       mm: rust: add mmput_async support
>       mm: rust: add VmaNew for f_ops->mmap()
>       rust: miscdevice: add mmap support
>       task: rust: rework how current is accessed
>
>  rust/helpers/helpers.c    |   1 +
>  rust/helpers/mm.c         |  50 +++++
>  rust/kernel/lib.rs        |   1 +
>  rust/kernel/miscdevice.rs |  44 +++++
>  rust/kernel/mm.rs         | 341 +++++++++++++++++++++++++++++++++
>  rust/kernel/mm/virt.rs    | 471 ++++++++++++++++++++++++++++++++++++++++++++++
>  rust/kernel/task.rs       | 247 ++++++++++++------------
>  7 files changed, 1037 insertions(+), 118 deletions(-)
> ---
> base-commit: a64dcfb451e254085a7daee5fe51bf22959d52d3
> change-id: 20240723-vma-f80119f9fb35
>
> Best regards,
> --
> Alice Ryhl <aliceryhl@google.com>
>

