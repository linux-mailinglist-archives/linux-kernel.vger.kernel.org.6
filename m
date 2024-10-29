Return-Path: <linux-kernel+bounces-387001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E40249B4A9F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 14:09:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4B442828A5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 13:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89861EE017;
	Tue, 29 Oct 2024 13:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="S64isXL6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JpTarItr"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A09CDF78
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 13:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730207336; cv=fail; b=Uf1sLkurmxhCHqHW6E3Nf9y5qRbLg769c4C9qEudPvxmHwYMQKEjUekH3npgf8K6Y3hPzv7dSFJLMbAu633tVBaKgOKExwDYDckEV3zSIcW8PL9sW2it5H+hG0IJeDcwSdN39bnlL7f3evHDG+uo1oFLK3RTkY0idEvIYASw1a8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730207336; c=relaxed/simple;
	bh=v67ld+xylOxH+Hi9Jqfw2+8tK5sfSSaDT8HUcaOvbZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cspF/b1PGnIIcUdoFPR/81T+rHmsbj64ODKCmyR9A8mfIXA7yErbA5wLtimXFJIOl5l2wxRF4nSK7HqQOVPdiJ2/iGvDs/K2nORHRISeJKYVl3moY3xKKk7Re0W04bou5UCRfYwyf6Su27M02FM4UMSEV2f/ILExv0zeSmpYmGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=S64isXL6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JpTarItr; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49TCbok6032716;
	Tue, 29 Oct 2024 13:08:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=Qey808Nx0GIRO6iNa1
	T19uSh958nDcyhAo9zUXa6PDk=; b=S64isXL6al5zKYVd17Tvpm5u/R6l1VlLBx
	v6VxiCO8VLxaV3bn57t3GE97TtDnm2/zmW8udpRT/RyhwuHC6OxFlv8ydL1eBUM/
	sMQ63DcwrYBUrIfU7Sp7l9SKm8FCNvTrsCD+/yCXO3g64O0A/I62HITv/xJHtYF+
	BFEc1sO3SMC+GrZi8qWOPqkRiVsMkHZzj7Gvwj9nkCxmfcKh11MqXiJUzIOAqTX6
	JTHbrJM+ab+IOb65NsayhlZBNUHWksDbZaiHnd24sMAG9akRQB0/Cz8l5XiNzMbr
	DVeCMFuUaCifGW9586mZVMzo2EIQyaDJrDAulYyli85V7n0YIB4w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grdp5c85-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Oct 2024 13:08:42 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49TCg724011737;
	Tue, 29 Oct 2024 13:08:42 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2044.outbound.protection.outlook.com [104.47.55.44])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42hnacfupx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Oct 2024 13:08:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ORCN8edh7bQyQcP1BBpfIJ6Dsjccx6cPXg5+gvAWui2JjLPtVXUgPECzOJCmJ9gmCQZvnMsNU8afJWVfypkYmvT4YzZc3vEe6+z+KgxXZMI/hlDUJZMUZ8quRG2uI//D/7vmsf+xd4BfQtfvSIABEw8B0erbV6LfKw238zEg/DGe6L7gMvBIgvlMazQ8uW0rvGnOeq/NEn2Pxc5/gtCQwZkdr+WGaO0136g2dt9dBryos50utvthVI2uBWpJLIIAFCk5LRXE38w5BZbO49UXA7p57k9/0vaz67GNBuQHnKu7877S1yWbUb7YY7G5IXEZNUA6NaPT8RmhRgCNTAcaCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qey808Nx0GIRO6iNa1T19uSh958nDcyhAo9zUXa6PDk=;
 b=WrLPXPu5XalTXD+VJyW3TSUVrD1Izk0aE/Gu+X7EPOZG3IyRpqzgicSTkwZKWI3Lg0mrEhvSwRoPCqAS2HMftPzB4wDldm2HmzcZvC373GgiwyC4Unx28/7UPSzxBTYfwdGp4Cii49x6blE0wmph/Jv5Y5nEBjMeEk+bL6RNQhHUQSSmE4hjrjaud8pkFdhfGwF0A0UqP3bs9U9d1NcpzKErL98omC07bt92ewUwmNY9ByxZfWf1//2XMBxu68B7gWi5EGaH8Rv62AlxgnKAzXUZsUQzltRA/GGek21EGROiUAFfhWT0K69Gc35wRdJfMrw7Va4vfYfKqsgc1ptjAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qey808Nx0GIRO6iNa1T19uSh958nDcyhAo9zUXa6PDk=;
 b=JpTarItrjWVMz16Emsd6FCruZqKdjZcSan0ARNTOLnj6XUuQL+cSoKo+F/akpfQAmZv1oYzMCxrkAraLkgvtzzyJwoOtp6AS46tGzpGkbHPKx0hJtkRZf4ycBvBUOwEZ9zrOelJMNhMyh1KfBV44fFvNZycFmeDcGIkAL4o2CtM=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by MW4PR10MB6462.namprd10.prod.outlook.com (2603:10b6:303:213::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Tue, 29 Oct
 2024 13:08:38 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8093.027; Tue, 29 Oct 2024
 13:08:38 +0000
Date: Tue, 29 Oct 2024 13:08:35 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        syzbot <syzbot+4b5c704012892c4d22fd@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] kernel BUG in zap_huge_pmd
Message-ID: <7fb3e230-9e50-49fe-9bf5-3a37f929f05a@lucifer.local>
References: <67205708.050a0220.11b624.04bc.GAE@google.com>
 <ri2667onovzkphvyxqnxe724ymxqs52pkzpdesina35v55ccnr@4kghwz6eevom>
 <3b06d23d-de9e-471f-ab99-54c96cb077bd@lucifer.local>
 <lifszx2644jx4dzc537w645wtk3qo7q5xxeam7ad7lihagvt7z@dooml2xm73dx>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lifszx2644jx4dzc537w645wtk3qo7q5xxeam7ad7lihagvt7z@dooml2xm73dx>
X-ClientProxiedBy: LO4P123CA0025.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:151::12) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|MW4PR10MB6462:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ff96515-b0ff-4b56-a906-08dcf81acd51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?B6jhiKQHd7clSHMd2C4ajl4kGho8w9tDxFBMtuPiYD40cJSdu9iPxqQM341a?=
 =?us-ascii?Q?SsQmrSwDzFAeSyjR8haP4kOYL3sbMg3rcdhlcJjjmsGPcncH9G+ui/XqJXkO?=
 =?us-ascii?Q?BWSE+YbTC/UuPdUjdC6kG4gAb3OFTrdg2y2ieUAdR9qDmk+Ch22s1MZdcXAU?=
 =?us-ascii?Q?WIJUASe7gfYFWQqrgdQp7GuLTpzNAfnL2pFJUIedEnmFfOacg8+5TWNVdpC4?=
 =?us-ascii?Q?6FotsWqjn5v9ntDWsUMbTuW0L2GpTiwRbWpDwl5ZIiuM8pdowH80RrcfOMtn?=
 =?us-ascii?Q?XkL6A3aH+sgKKv2EsCHX7hn5boaM3O7DZLqjsl3TBQziCqZlCjfXun+xEDF5?=
 =?us-ascii?Q?CBj1CxCIFcZumTu3hLVuIMm3ASUYz1VR8gqFKEoF/+5nuXCykrfbv7ATYpba?=
 =?us-ascii?Q?GEYeir8LXwpo/IR+eQ8CXvJTzI6eHKKaNimW/lHnfw463TTL+LEw5eZtiDgr?=
 =?us-ascii?Q?UPArHQFvVns5nCf4q7COOzPBN6d1N0HK3poI+rsnPefmnkDfdRxtwc8YoVng?=
 =?us-ascii?Q?NxuZwfraD15rha+6Zb/xXD0QOHbtD8/y7u0qFBpwAGUSE1RBKQCbGH+NVgJ/?=
 =?us-ascii?Q?EZzX93NKmXHkBwZfLU3PSeFQOQd1dlHeO3j5oCPDmUhQpRi7+MR6gupw4wZQ?=
 =?us-ascii?Q?3k1ZfEM57TGj8PM7M0IfTDEmtL5LWFfFiPi++HesBNjAJlFc7+9D2680B4XD?=
 =?us-ascii?Q?t80fb6cM+oTdVhxDxM+1h5tO4FHg8J28nH+n9BlNyDv8KdYiepj4InX8+XHf?=
 =?us-ascii?Q?qQBjre3TT33u6Wc/l2/wnxlVjdvOQWGIQqvK0tj5M5EcTQsin7hQ9fTlSy34?=
 =?us-ascii?Q?xxdk/sorBM3XcvFkYxPtbJ5A4sRxEDFhZyZ6yirs/zDgyyQMX4hrT4D0ao9U?=
 =?us-ascii?Q?YtQ/U0VAH3PAp8QitiiTCt8Dlf4+s/o28c1RJwsEVnR15y/yg5GRMttgrJVX?=
 =?us-ascii?Q?cgsvrkak4GdJn37ryi+M/44jFVhAphMn6daaAuNrRJr960holzcW3i1iFKru?=
 =?us-ascii?Q?I4EGC0r8yA7rUMkAGEwTCO4AOvc0xBMJLszi2Gc5lH9rmcFYYpFq3Rm1ujcB?=
 =?us-ascii?Q?yXkctNem3lrEeu0+VfkcYtaznp/ZEbUFfwKeh+vhGYfiwwufA9D8ywrc3IBG?=
 =?us-ascii?Q?Z8dSow+3rY+ii5pYlw7Nl7Vo3Z6V7TNtMPcYvywiyj7ZnqKePzKyV6x39hFz?=
 =?us-ascii?Q?Kc3m4Wxk5lcJ8PakW+6kqIsem28ZrXGened+wrMZeDgeDqqHPtnv3jI3pJVq?=
 =?us-ascii?Q?6pwBN2iwY6hjb7KgLsOwKufUVC4zWKbyHWyjtymV0w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NUf6y9DxRnB/OBV+fJzfY4fwR/wx/HavdMpj6RpITKNwVmMUBejB0ugNivFJ?=
 =?us-ascii?Q?T9+5UMWOZ/cttES5XlrZ4xXKmlrjFYHhFV4UnHmpr1lFEs+b1wUXhq1aZRMn?=
 =?us-ascii?Q?BsDaOU1rTciE+XMF8XitYfqlJlIwxQlfh8nG971zOMi6A9uHJLDGOAdT0LxS?=
 =?us-ascii?Q?5TfQ4Mj6ThftpCyxcvETCq2orf18frm4s4RVLkOBUR/dGkgicCLXK5ishKE7?=
 =?us-ascii?Q?ZHVWUbYTyRq7Of23HH57VZTgD120j6dK4UuQ5q91sobMNbHRcNWoHKn+egmR?=
 =?us-ascii?Q?O5X/he5J9rbBgBAoJbMo+2JLAOLrcG1U54jxYpxCNCCjahSWMJaUGA3Mn5c6?=
 =?us-ascii?Q?I/piyk8MKsKSaMuIGpMpwrPl6lVj6ge2cZp8ioUtsnPU8oGZiVpCiS//eCuB?=
 =?us-ascii?Q?hMEiuAm6aQ8WcEbjloAVhOvRU3KDfX4OyDqL0DtBx2+Cb4Tvr9aqjHiIV6nK?=
 =?us-ascii?Q?hwrfl3o0RSEUC7zbIDP+7qYwobtwZHSICIcf11kx/tDy8E5gOjOs3m2kpv+c?=
 =?us-ascii?Q?GctAt41368aGIJNnFKZcAUu4o5W72Q+hyYiqUQ/zRVor/MfDp/w/Dxc5wl6k?=
 =?us-ascii?Q?OGiIVQgcyNfBml3MYy+9BUR+7pV4uG8L/GaYACtR3IkOWCg6Avx6Av09br3k?=
 =?us-ascii?Q?+4Irr4R0NUpn/loDgD67hWPXZ9/asqFLoiYUxmLktXeoorJamg6h0SRqHePu?=
 =?us-ascii?Q?uLpIe8Y4Nsdb6uffVx9iQ6RNvw1BKZZ2VzcC6XwVUjf4p78ZFpYFHp3OfhrL?=
 =?us-ascii?Q?bO3bv2OjNHtGecXF2ywkZYDe7s8zSQjPIxaoKX8a+SdRVxFn/wCiasDHFo+P?=
 =?us-ascii?Q?lF5fLgZJXijLOpIJb/JA23VF4D9SH686S45YC7Xg4wrmSWbdBwLxW8FF39L/?=
 =?us-ascii?Q?GWX9AvkUnG5+5SGIQy229U98xU0gVkiARofn9qqH55WiiTabCuE9of6lSzFA?=
 =?us-ascii?Q?Q9wBk/JdgsFxbjt9Aw8DlqT+c//lWKgmQzZM7qDXY6VvR1cRZU61fQwPsNWO?=
 =?us-ascii?Q?d4c/KJ9uh8GScjjBIIhDpMDW4lR2JFhcYOeT/9vK1D0OMtFBvcnw0WKZJ5VE?=
 =?us-ascii?Q?qVWcAyJnlNlHrGbawGLB7B+dxEuieKro6Eg8Flc6W20bWQxdvdMgoUK6PkSn?=
 =?us-ascii?Q?ArCRU6+Er3JayCEn8MbuCqFT5SgY9WIJtBD9Kd1Vq1C01IUNWHIdTvu2J4Ud?=
 =?us-ascii?Q?HirtDxIKiHh5wvFRMCXrqe3LWpbeK0vHi+DB9iTT6PK5hLb8IyahW+ZeJhJA?=
 =?us-ascii?Q?FPXNcDi4ePf7vpA75D8MdeHRDXkQpLSpMcPtmXE6j8PDjIflCp5L2k464cTE?=
 =?us-ascii?Q?6ADi7SFR6MymKI6i9/V06qcFNi7AcOXFxnBejpMHIrMuYZjmPDTkJfhnE3S1?=
 =?us-ascii?Q?1Fu/qYplCOBbXu+zMCGzw/CjfrSvPetsI8VAwm4cwWVyDlYQQCEsp8nHL2LZ?=
 =?us-ascii?Q?DysjlLXbDPUKa1Hzur0k8MWZAyEJSHdlgfyAE8j3g3HIkOvl74RQ62/XEkDP?=
 =?us-ascii?Q?pqJHyNrUi/GXfj8RA+ZjPLv/Hnc87O71Xn7UKzaZwkIAnWZoGuIsslc58Jez?=
 =?us-ascii?Q?ZoKaQ8czpmXbNyk6mbSxtRmM5tSIKCbMG6q82Yxw+bC9RnCft+0xmELiHh0y?=
 =?us-ascii?Q?3Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	oV/7JHDn1f/VHtSiOHbjWQTK5LwcFVUCz1pKrnOrK4UFMr6yvAPnM7ol1T9zXJyUx0mIz0iGhOM+BsBBKWQQcGJKJarNTb7t5/x4JkBykd5Pv1zQQglkBFSPrnPtfEmiahuSHKhZ7pa0wDrSMctFgmBg17soQfpff1CRCMjLPVo8sp2LkdM2UgdCTvEhFYkQP5yD2MdlzM22LNgOBsfvlCBSlO6JLpAi1jsx0+qn0g69TZfu/gSw02QZ4/4IwmYfYFGEOc6S932c9fXDwy/LJT+nnYXpMrkcsWaRMdblQe2CftVvyacHpxwrITfkIUdbjPXhaDrvrcePWmgrQmblTOu7dDIAF4QFLPVBFSigtfYF/frUGJOftBX39viDx9cHMyMYxMk4iG7awaoaUoFmavNMqVBPvrIuW9LQNJOOGYyozEck9YKG05qqBcgC4mJ94AXzMk/d4WXFe0AYjkWMN5R2mfZcfNp9lYM0mWL2Z0cOXgzLL9Mt1QCnn355fPwtf9TnBsjx3L/RqNv1jOWdLxfJDzd7g2kM2TFbf6sJ0KXI9dxcmMrq0nebgoLzqTwMQpcWunUvG/u+KPrYQIKLbLkC7qKKeOQlvs36dFoprWM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ff96515-b0ff-4b56-a906-08dcf81acd51
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 13:08:37.9671
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5supx98wU5SlubfzgLIun6YE3VGGflIYzNsi3/VF36r/Cyye13eWYhLlNEIG7dGVH/6+YyXYeT2PcKPJcSYLzKV982IGmxJ1twW4e+HFuy4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6462
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-29_08,2024-10-29_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 bulkscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410290099
X-Proofpoint-ORIG-GUID: 4XoA0FBV8KygaI7Dz6fQyAWZDJmbCBGT
X-Proofpoint-GUID: 4XoA0FBV8KygaI7Dz6fQyAWZDJmbCBGT

On Tue, Oct 29, 2024 at 02:58:02PM +0200, Kirill A. Shutemov wrote:
> On Tue, Oct 29, 2024 at 12:07:00PM +0000, Lorenzo Stoakes wrote:
> > On Tue, Oct 29, 2024 at 01:44:47PM +0200, Kirill A. Shutemov wrote:
> > > On Mon, Oct 28, 2024 at 08:31:20PM -0700, syzbot wrote:
> > > > Hello,
> > > >
> > > > syzbot found the following issue on:
> > > >
> > > > HEAD commit:    4e46774408d9 Merge tag 'for-6.12-rc4-tag' of git://git.ker..
> > > > git tree:       upstream
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=10fb2ebb980000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=fc6f8ce8c5369043
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=4b5c704012892c4d22fd
> > > > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11f730e7980000
> > > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=177eae40580000
> > > >
> > > > Downloadable assets:
> > > > disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-4e467744.raw.xz
> > > > vmlinux: https://storage.googleapis.com/syzbot-assets/058a92aaf61a/vmlinux-4e467744.xz
> > > > kernel image: https://storage.googleapis.com/syzbot-assets/0b79757fbe5e/bzImage-4e467744.xz
> > > >
> > > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > > Reported-by: syzbot+4b5c704012892c4d22fd@syzkaller.appspotmail.com
> > > >
> > > > R10: 000000000401d031 R11: 0000000000000246 R12: 0000000000000004
> > > > R13: 00007f33ed7673fc R14: 00007f33ed737334 R15: 00007f33ed7673e4
> > > >  </TASK>
> > > > ------------[ cut here ]------------
> > > > kernel BUG at mm/huge_memory.c:2085!
> > > > Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
> > > > CPU: 0 UID: 0 PID: 5095 Comm: syz-executor380 Not tainted 6.12.0-rc4-syzkaller-00085-g4e46774408d9 #0
> > > > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> > > > RIP: 0010:zap_huge_pmd+0x953/0xc40 mm/huge_memory.c:2085
> > >
> > > I believe it is bug in mmap_region() around handling
> > > vms_gather_munmap_vmas() and vms_complete_munmap_vmas().
> > >
> > > What reproduces does is:
> > >
> > > 1. Creating hugetlb mapping
> > > 2. Setting up UFFD on it
> > > 3. Creating a new that partially overlaps with mapping created on step 1
> > >
> > > On step 3 an error is injected which makes vma_iter_prealloc() fail and
> > > unmap_region() is called in error path.
> > >
> > > The unmap_region() is called with the newly created as an argument, but
> > > page tables still contain entries from hugetlb mapping that was never
> > > fully unmapped because vms_complete_munmap_vmas() has not called yet.
> > >
> > > Since the new VMA is not hugetlb, unmapping code takes THP codepath and
> > > calls zap_huge_pmd(). zap_huge_pmd() sees PTE marker swap entry installed
> > > by hugetlb_mfill_atomic_pte() and gets confused.
> > >
> > > I don't understand vms_gather/complete_munmap_vmas() code well enough.
> > > I am not sure what the right fix would be.
> > > Maybe call vms_complete_munmap_vmas() earlier?
> >
> > We just changed around how this stuff aborts in a hotfix series that should
> > avoid this, actually.
> >
> > Unfortunately I don't have the netlink setup syzbot has locally so not sure
> > how reliably i can repro.
>
> Build the config in the report and run it under KVM (virtme?).

No need, syzbot tried the branch with the pending hotfixes and it passes [0]

[0]:https://lore.kernel.org/linux-mm/6720d587.050a0220.4735a.025e.GAE@google.com/

>
>
> --
>   Kiryl Shutsemau / Kirill A. Shutemov

