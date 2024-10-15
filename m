Return-Path: <linux-kernel+bounces-366424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D7A99F524
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 20:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B33F728475F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 18:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E861FC7CB;
	Tue, 15 Oct 2024 18:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IyJ0dXru";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LM+IsZyA"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD46417BB16
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 18:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729016604; cv=fail; b=uQfh0ZdorxUzpWEG07pPeKAfYkrI2ra0h4jDDCEW1tbnxse7VaErmvtR6oRSwdAIeRiUbbp+wYiX3WbkzRitpcieINXpnucqHHQnI6ycH9q43TkP2H6JahbNkFGyv+pj1BWsOfMoWovpy2iY8OYYFGmgIcT3L3uh+Qb6t38dZNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729016604; c=relaxed/simple;
	bh=OBL8lRDcJ1u/Ffe9OqCWi73WPw0rA7JRx+LIJvtB7Xc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kZzFpAT1dg4RPqVVOhJN/vI7jgUQ9WDbi1O6b2S/P1jRYCANi/Rm+hfq4x3XDk1wjMA6/3nl6w4yfaR5CPJKBJcVfghR1zAJiB8TPzFtnh1diFH0XIa+/MZYCjTrwXvM244PFsgjZyIbLnSMcFzTVEV60OJEnWH7m/OhTr16Sew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IyJ0dXru; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LM+IsZyA; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49FHte6d011672;
	Tue, 15 Oct 2024 18:23:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=+EPlmjSTD/Q8YxeMjN
	14+NJB08Qdd92vwzx1PND+rP8=; b=IyJ0dXruGgy7Sr7wZ7B49Za2Lw8wl+8sxD
	0XZfjvDnf0YOB64hvWv0Zwvb4PB4Ajt99cCNFj+Z/b8YJTjADbiTHCAAJrD9+b8I
	gGJKKZI4XdbtQpaciBk7NIhstSdzY5MzNFYhxCX2Yzk0MD44nPEBGkJZdinjC+f8
	5jPv5/dWy5+a8AL2/CSJyiPLVimq1chPjMx40ZJ+VKER7UT0WRLh+rFD4/+PjClT
	EY1CRHHLCY7eNQVORsvowQM6cpyS55lBvaMNzgMdSQZZgaHCGDuO1PG/drVjRdwK
	YW9nIT4dlf23ueGRVonLHw+z6d2dEwDCYfzCcEImV06p8iW7sfNA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427gqt1twm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 18:23:07 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49FI82IO019943;
	Tue, 15 Oct 2024 18:23:06 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fj7u8n4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 18:23:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lDLIzY5Pel8WX+aXjyJBSun16cO4j+NMMkorN9csDbSevwEeed0OpRo2faTdQBuxdF4gyVE2VU94FFKMKarktlzrpvOZg0DxZeg6CJRrykQAVbcj+FlHRwYPnKJXUd7HuwGdyMR/S8lBBFijWxkZPUzr7ImodGmbGcVuUgE2NM2Uwmktw5HgKrbhAfMrSgltzKnfoc6gG3m9hTIZeW4u6/q0oJUoMAoNv26Fm/zGxn1YJX6AsmN+jioJrk5tu+DZfTx42HrFg393LmnaHiummkYQxmANKbdIAaYfjh06V7AvtLsGMgLfVJy4DC7OhcgHCjtPDY86LlSbO55EaMoQUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+EPlmjSTD/Q8YxeMjN14+NJB08Qdd92vwzx1PND+rP8=;
 b=W84kkn29t8UU13IgkcOBG18eSg76iEBhAu4rlpxWxCq14Fb7nVXlqolbqRY1RhQax4JDc52puwdDfcwQvfZjG09iTVSZ6NmwExaZ8AqFeXMFKkfVUpMVYqonOUmHYkdGxg87Pd+53TY+YfN3l9kNj0OCv0mpBe7N1m44NmxzrG+MuLymxZQrnj9K5bnULh13BuW0ISuCrm3eDHQ9zaqRWR8PIWCTZdB3vpMw/lA0bz/UEsLNIB0azNZvrtBBh6/zqIZxnqf5eLHkQRUOOqL0NX64UCzS6/qjRCYRqhJgUgDJv8LQyQsFUANfPqj/wqxMtdANNJ8v/rVz4bjn4ncwKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+EPlmjSTD/Q8YxeMjN14+NJB08Qdd92vwzx1PND+rP8=;
 b=LM+IsZyAGbgOay4dsmrf+mmG10L4/i/g8mvu7j7yEi4LRqHTpxlh2fnju0OwnGsCRvklAJ1vrqSvniIC5G061cDX4/ubsOH9anUsAeI8mIAYHsQu1upuHV3FlhSNRk7NFbgYfmKnyJ0hCGsQsYHr4RRIG7M63IqPWcd5UQf6hfA=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by DS7PR10MB4848.namprd10.prod.outlook.com (2603:10b6:5:3a2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Tue, 15 Oct
 2024 18:23:03 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 18:23:03 +0000
Date: Tue, 15 Oct 2024 19:22:59 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] mm/mmap: Fix race in mmap_region() with ftrucate()
Message-ID: <6bb63c4a-2ef3-4f38-8639-db1f0455c870@lucifer.local>
References: <20241015161135.2133951-1-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015161135.2133951-1-Liam.Howlett@oracle.com>
X-ClientProxiedBy: LO2P265CA0021.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:62::33) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|DS7PR10MB4848:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d29464e-8c9c-4cb3-6f11-08dced466816
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Y9djsRWFdcdEjBkg3ShIRhYwBpzwPGUT41qoHitEYq0Uvqt/eVAj69gQHwmP?=
 =?us-ascii?Q?qIz28IFhB5v3McMYscvGv3MqIccnLBdlb2S7gRxfSrRZDDClu4jgHU7wnFWJ?=
 =?us-ascii?Q?Ph0vgcnCB2uNMPL5iWjjwWO4QkMqyR18BCn7FZW44/E1dU8NeleiUubp0XAZ?=
 =?us-ascii?Q?Gp7Zoq4dCA+WxCoXOoEZmBCbue4n4yrUE+G2rOThg1Zbjc331CgYBlScv4gA?=
 =?us-ascii?Q?IRvvFBl+ranF06RpmP/ULsARJ4dbe1DCa15a0i6nrghSbqRQKAV8qM6R0G4q?=
 =?us-ascii?Q?Bht02oSB34GWkwaHWspK20gspXG34dE83LIz3vT0BVFcX8TN70Ifw6NV3bQb?=
 =?us-ascii?Q?8cof9eyD8V4YoJQQvNb8V+dKvsG5j4s3KqaTegm8CWbsDvBYw0+SeXQ58HF/?=
 =?us-ascii?Q?D2ucfKjh1m8+lyLPGoXYCc3j4PWwj/NaXsf2fqExGuJbk8nl4jRWnlUUyZMt?=
 =?us-ascii?Q?8mocQwlCKB996Rv92gCF/KoxpFj7rMIGT9ky1OOLaPAxlUGj5l6fLn3c7pVf?=
 =?us-ascii?Q?bT33jmUvTseV1NPmVsAEBnS9Stl6qgQ7ojJYrb6/tqd+b3kbeg5KoxFAtCFt?=
 =?us-ascii?Q?wLxjftIxrEXnPzzmYv0FuWcU+mQfwzOvkJ307Chqho5fBhrVcR0JnM+YlFD/?=
 =?us-ascii?Q?eWyS/jyF1HdeO0ooHxcwCZ+hpUjbcLTPQ3Kw1wwNa2WaJ0DJagDXAmRB+Eya?=
 =?us-ascii?Q?f9iQcl118k6ishX3VDBcMU54/hz4H8S+bkgHLfbc6q/+Mc/OgaLaze19AlUe?=
 =?us-ascii?Q?KYyg36M25JzsKWqevnSnXDnY2JDqGbI4U/3wg7U4BmuhdxMe/3msSk1M558U?=
 =?us-ascii?Q?HlHgKa3aQYFpi4ToOUzRwWleLCEaIzHauwcFuNmIWFz11zHV8StHb4mXAwTC?=
 =?us-ascii?Q?X6oAHcGaIZgdQp01PjNPI9ZlT6cXxukOEUZVyL8zWR9+mz+Lrp2E6YOCBZ/2?=
 =?us-ascii?Q?lqFlZ1IZRaOj0qNozjwq9z54LMrVOpgANe/0VsvYTmTXUbVgMVwANy49orjv?=
 =?us-ascii?Q?HudmjqsHd8FKujsZtTjOfYGxHKy4LbKYI/GrGMGd2I0Z3/lGSqxItqVP8hyq?=
 =?us-ascii?Q?aIfAqOhLqb83b/cVlvK7yYFEwU49EWpfZQohaVCZblJopbzqANffWIRSRluu?=
 =?us-ascii?Q?BaWTeAb2OwPCdlzNz9amfLtVtE+ceiTCGxvO/Oh5jQFeCJRhSjTqkE7VJisK?=
 =?us-ascii?Q?H1rBHqOm7q7Z1/3azbSQUv5vCz6dDs+dp5JDBs4PBbSdFTHIo8LkFkYO5yOd?=
 =?us-ascii?Q?nBEpeyG0lBnJjPOf4MnCP44FPTVEHL20X2VLCMdrCQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lv+zkiPz6su9hexPiXSzXDz8qgugLpuz35ssERoJ02bvxQhGbwRbqb231Odl?=
 =?us-ascii?Q?G4z4yTgV6cQAZY/8x5Iia4RWiHQ9emUKyCVmOzBPfNE3kU2PzGHdXFJZnCjN?=
 =?us-ascii?Q?ZnO+kxhPp3x9ngGCLbCZby/YeQYei0FkRusSn5xO1Ie4m3x3G6zkY45XPZJy?=
 =?us-ascii?Q?gJVYBy9HGEfeUAf4neJ4vDfr/H7FMq6mMdptrX8sJ15ITQDBFpU+dzPEzoZF?=
 =?us-ascii?Q?IBpz+ioajV1Di8bK6pYH1+8kDVUxfa2fTiXG0Hzgxxa7h3qqYHjJsOZiI832?=
 =?us-ascii?Q?JodVtrtoFE9583SrQInKtZozLdok7+oaPcS+3ReHl62tC8MXDhj5GLX4MSnq?=
 =?us-ascii?Q?zNHvzP76xBR32NmfPAq5nATu+vQXh0RlGohE6VgeP3BAhrAr+4lYeCxVhW7d?=
 =?us-ascii?Q?Fabjge1dX96ZE99AKO+9IQ6ul/L+z+uMPgaclBQQpRo2yvxmTkB7H4NQ/m5u?=
 =?us-ascii?Q?/ii/6uuEaNGPSHggzScYDcxRO2aGUjU3dFMATMs6abZB/ofhQOentiav59vx?=
 =?us-ascii?Q?p74FYoYtri5F+mkc8ejpZZZIbhwzPK0DE8rIKnFs/KbNwfqwsGRjjurz47qb?=
 =?us-ascii?Q?hOygpYyvZvmtISFfgRxjlgKyCQFQclWZQ0LyUX7/70mIyMXDouVzZuob8EVP?=
 =?us-ascii?Q?k5c4RcOLdMEXNsa8i4caeheqLOwKwFcIPGmeCv0A9TQwflgrbcmNI4sB2PuK?=
 =?us-ascii?Q?04cO2DeBIyeO8V2PTncMqMUZXoX5cOGd/ZjtkbX2Sx/g6Aou2y86RkBpFvwU?=
 =?us-ascii?Q?G6371TPDfwNyGF/PoVH+936aw6CHB5ycOmt3Grz4s4axJE0N23IONDvN8Xzt?=
 =?us-ascii?Q?e6AdS5fpaEytlGrOqqBWItWcmAqZhuIb8s8KTLPqvqSLZt5ud482hl45keaw?=
 =?us-ascii?Q?Wx83p0FjWnJoWu+yUBUGscgfI3J8Hr2hwcLEmC/rgTCSJ/sT415hZNCnGKBh?=
 =?us-ascii?Q?o/plyp0VVnTP6KhDPZcVWAPCEyyZBSClnFFr0whLf+JhZe8mr3bocMQrOfNc?=
 =?us-ascii?Q?B4ns8iXNMVWu3rPX5KWAg8XlrJyqZTGUxH0GoONTomEXp0dgHpjSC+yCQaT1?=
 =?us-ascii?Q?zfkhaBbAEbdpyW5+NTtfmAIEdvmILRZXDFaSOITTapK2J+DE7m1v5ryy/ZcS?=
 =?us-ascii?Q?HzqfDJfols0jHGgdbZF91LX9bfLsrn2o+646lv43+LuEfezn/PuzkJXrNLic?=
 =?us-ascii?Q?L1LFQ94i0G7w+/I3RHhhyIE5CbV1uBVFRk4sLNJunV5+hwEdWhzCQwMUITlS?=
 =?us-ascii?Q?dwWVKUuunmRa9bEO4wAgbdHs8SyBDjlCZFgG27uRU0Bo6bVvLi/3IxKhDIWY?=
 =?us-ascii?Q?46TEEEGpHWWtGw7CUNd2TIrSWny66GXKcc5BPLI0ee7YGrq3IKrKUCQECsd8?=
 =?us-ascii?Q?f27t1f2j7d9ZLndKAvyxEyddpl51Y5dhHl7bpPZnkapbqMCwtSQxz5OT5iTd?=
 =?us-ascii?Q?K22hsp0WGNDa/n3mQVc228j7p6JtUrQ/WKb5ioIYhMISYm7X8tU6CDGG2xyi?=
 =?us-ascii?Q?2kkXSPFSCuxkwXG7+grcVXHN+V7jn5jdxbb5c7PGrrNWSYVD1F3rgR8YaKId?=
 =?us-ascii?Q?VW8YzQZQV/F1J3OqjGietr4Tf93tO1e/rPCNhuhN5ZBpeMkhJxknlPK9ilul?=
 =?us-ascii?Q?qA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	aEm2MFdY0KByvl09EAa+42W2Bw36wTUHYpOYMC1BsYU53rBJ1d5FG9dXM93Rg0iT/AwuZTZ/DE+ubk4ykPBtM+YCVSXtBFggSym6UttEgTyWjz6oSLiqoPWRUlw8J7ODh+E1UVHobr4+2wq2P2KhO8dIWAwjFZSDkMNNjzW6Lipg08CWxZ5KTz3NbgM/ZZ9k4wFlqFP/yOeorEaUzzjTiCBzK2Luc2CG/c7qJ+O7+vogivqmUmd8P5wl3ptVL9XxIBW167s1DEjvoyWwGX5Ejj170EyewA0VTny+GVCZZ/X2kMMu0xvBqxNoDjifyYIfai75o1/qbmA4tCrKOajGTIScaa9XxWklDqOWA/iv7+++2iWeou2sahMhjfqxpizV9zZrGXPnaYjpdLGa5w2O1CHL+7nS3vYnG8qbeuSl1Y57XfLp7LKSRt2RMnXjLw6ZeH+wuCMNIcHl3Cvx67c++QNPEosGCi09Jwni4YTFmgNAdSpmsiMrGbU2GVxzirEXKeED8EWX4oVWaAmz/KcWmrjKG7V5+/Swz5g57xzMkUFJZHK8NTlOYvKRB71As/3vW2/dDWQguMG0jY4Ma4jL4WLX1ABnhAzzXsDM9rOAwFw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d29464e-8c9c-4cb3-6f11-08dced466816
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 18:23:03.0599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r6DJGV1I9UTWQyZLOu9AZLoi9iERTiyc+/JvubGokQNDl9kl386Rrx3a7Z25LQT9bHA4MKtCB85f6bWlFKeQ5MxiUdd/TXPLc/zgvMPgqSg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4848
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_14,2024-10-15_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 phishscore=0
 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410150125
X-Proofpoint-GUID: gIjdKtpn9IoXegvyzPrQNs24rnb2e3Oo
X-Proofpoint-ORIG-GUID: gIjdKtpn9IoXegvyzPrQNs24rnb2e3Oo

On Tue, Oct 15, 2024 at 12:11:35PM -0400, Liam R. Howlett wrote:
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
>
> Avoiding the zeroing of the vma tree in mmap_region() introduced a race
> with truncate in the page table walk.  To avoid any races, create a hole
> in the rmap during the operation by clearing the pagetable entries
> earlier under the mmap write lock and (critically) before the new vma is
> installed into the vma tree.  The result is that the old vma is still in
> the vma tree, but the page tables are cleared while holding the
> i_mmap_rwsem.

Nit: old VMAs (can be more than one).

Hmm this is not correct I don't think. We are not holding the i_mmap_rwsem
(nor could we as free_pgtables() ends up manipulating this lock.

Rather, free_pgtables() unlinks the old VMAs from the rmap before removing
their page tables, the key point here is that we have not yet established a
new VMA that makes page tables within the range valid and accessible.

Before we did so _prior_ to this, making it possible for a racing
ftruncate() to grab a PMD right before we free it and then UAF.

Now we make that impossible.

So I'd reword this to that effect.

>
> This change extends the fix required for hugetblfs and the call_mmap()
> function by moving the cleanup higher in the function and running it
> unconditionally.
>
> Cc: Jann Horn <jannh@google.com>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: David Hildenbrand <david@redhat.com>
> Fixes: f8d112a4e657 ("mm/mmap: avoid zeroing vma tree in mmap_region()")
> Reported-by: Jann Horn <jannh@google.com>
> Closes: https://lore.kernel.org/all/CAG48ez0ZpGzxi=-5O_uGQ0xKXOmbjeQ0LjZsRJ1Qtf2X5eOr1w@mail.gmail.com/
> Link: https://lore.kernel.org/all/CAG48ez0ZpGzxi=-5O_uGQ0xKXOmbjeQ0LjZsRJ1Qtf2X5eOr1w@mail.gmail.com/
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>

Other than that, LGTM, so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  mm/mmap.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/mm/mmap.c b/mm/mmap.c
> index dd4b35a25aeb..a20998fb633c 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1413,6 +1413,13 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  		vmg.flags = vm_flags;
>  	}
>
> +	/*
> +	 * clear PTEs while the vma is still in the tree so that rmap
> +	 * cannot race with the freeing later in the truncate scenario.
> +	 * This is also needed for call_mmap(), which is why vm_ops
> +	 * close function is called.
> +	 */
> +	vms_clean_up_area(&vms, &mas_detach);
>  	vma = vma_merge_new_range(&vmg);
>  	if (vma)
>  		goto expanded;
> @@ -1432,11 +1439,6 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>
>  	if (file) {
>  		vma->vm_file = get_file(file);
> -		/*
> -		 * call_mmap() may map PTE, so ensure there are no existing PTEs
> -		 * and call the vm_ops close function if one exists.
> -		 */
> -		vms_clean_up_area(&vms, &mas_detach);
>  		error = call_mmap(file, vma);
>  		if (error)
>  			goto unmap_and_free_vma;
> --
> 2.43.0
>

