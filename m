Return-Path: <linux-kernel+bounces-401306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE6D9C189C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 10:00:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8186AB24605
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 08:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A55E1E0B76;
	Fri,  8 Nov 2024 08:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kQsmOudh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lCpyIc21"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009CE1DFE3F;
	Fri,  8 Nov 2024 08:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731056389; cv=fail; b=DIXzzIZlBG7uI+ghsUN4IgSJVMPLRp99bDGo1UWLEFxoNOJuQaBlinlL8MkfEEOucA0hopobOmK+4gjQc8VCOaQitRThmbq9S4IrbWLHOIsrnVnsIeJqkt/7Dk+ZmzUcR35Ds9IX//vfZbt7arB8TwWZmD+uN+CLjkYc0EQl48A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731056389; c=relaxed/simple;
	bh=zeEbpm2cq9JTWXmt2cEgwFcKxePSJQwX/yTFxAqk9ec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TZSxksctuOb9F/S8XaFJiGhw1U9H2HSI8yUMy9u6NcNo+/7cUK2d1mTvNhSxAllPgis44cagcKHhH6fw6fpQ5dNjCvT2oAsocJ4rHeD0Wu3VfnIVC0Ro5nCVOzjBHfGyQ5efAbe1BwIdwO8wWUgAHggDLo9mUrTZ4qEVUGg8424=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kQsmOudh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lCpyIc21; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A87tWLV007389;
	Fri, 8 Nov 2024 08:59:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=zJIosuqpmHJE41XPMr
	F1OVLqbsu9qXv8duM4XpzMyLs=; b=kQsmOudhgVVHhbNWfENtB+ErwC+Fg5I+l1
	yBms3QFfLqA6SYnsSBYhe5WPda5K3CzeUmRyWhsQVCU6RlbQ7ZxOSI8Q12aiF2kv
	Z4jKh08xU1R3A2zc/AxYU4Ky4+pAm+A4DU68mw+4C7XujsywdZRMcdALt0i2qvUY
	6ffgXB2v0HbcTbRSJ95W4sQ2jfzlLRMEcGrK3eeTMQjXFmlHRZWXWU6bcR6Im4n4
	Sl0GF+nnmHhR/ji6Wgu1XsLa68AbWsnEWja1402Pb7FFibXW4sw56iAcTUvLfqP5
	rMbcchx6K0FMy5X31w99JO7bxr5iPa6l7P+ozj1eFdSAoXdbm1Kg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42s6gjgy7j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Nov 2024 08:59:11 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A88GvbY036930;
	Fri, 8 Nov 2024 08:59:11 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42nahbc3br-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Nov 2024 08:59:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=izyPjnuSsi2LRegpJiBDiQVhj/kvWBljdq4CUqe4QysZ1MAi/1fTg2zoT6z2bneRc7fOyQSsrYj2lVEDrt45zW6J0grfXZFbrf6VM76/UHvXYML36WqreEv4pHFLzRqYq4sZvkXZJ4EbB0INGQsWoiophd0ajOd7g9s+VDRG712oulMdX4QIunrrqx+lL1CXvxJG/jAxKKOV5cwJ+uNPXerPF9RNPcO0Tmy/XyMfDgr6Tr1ANlGaZ1XV44VWT8xz8RkpLeFArn5ld0xRqFf/7i6TzNFlAfjTKZeyuI3hbrTVvkmojxdHZmpKTAYJzoA8DdDyvIhcQA70VL0mIvITEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zJIosuqpmHJE41XPMrF1OVLqbsu9qXv8duM4XpzMyLs=;
 b=F69bACv3Ijw+NxB1Ypiz7C7ea7f9lFTKkkgir6xaqOKERm0hY5C3Mz8YWyRPOqKUKH4MqE66NHE/0DyIf8DcI3BJARdBMhQV+V1W677fw6cTfcDfbNTHjGSuLVKhyzBbngAKryp1GdOPkKOb5aFp0oLNft7wQ9OI8PHp6f95nCQsePldZA6Z1HwyYBJnJbKKdwON+DtUEVqBHPFBh28qSBM4BMGp+hgObTFwA7HyA8GJp/ZEz/CMFc1Aa0jl4VN/yCU2vIR0O+MP4YoRoMCrXu9ZBIL2dNoY4tq+Z+UrOnz41tQIkbH1hBUxFEPDaGfLh41WXg8M86EsPR1HpiF4cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zJIosuqpmHJE41XPMrF1OVLqbsu9qXv8duM4XpzMyLs=;
 b=lCpyIc212H7tPP+WYcpP7qQ1stnCdOB5eE0E7KlNwN05+i/VUbh1zb/4edjgf7/0MeeHNGOIFtgVQPurxA7Aq90t61kPBDGjlsp6KphQWXYdoqlJ7pycNvrHDDzB98foOj1G0MMjxY5LMRUBCw2OlEf0BGpJYBa1YI31qK2bwXo=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by CY8PR10MB6612.namprd10.prod.outlook.com (2603:10b6:930:54::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18; Fri, 8 Nov
 2024 08:59:08 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8137.019; Fri, 8 Nov 2024
 08:59:08 +0000
Date: Fri, 8 Nov 2024 08:59:00 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Alice Ryhl <aliceryhl@google.com>, Boqun Feng <boqun.feng@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, Mike Rapoport <rppt@kernel.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Suren Baghdasaryan <surenb@google.com>,
        Hillf Danton <hdanton@sina.com>, Qi Zheng <zhengqi.arch@bytedance.com>,
        SeongJae Park <sj@kernel.org>
Subject: Re: [PATCH] docs/mm: add VMA locks documentation
Message-ID: <aa859c52-d2b7-4a35-82ba-e59cccbec896@lucifer.local>
References: <20241107190137.58000-1-lorenzo.stoakes@oracle.com>
 <k2ugfhimeoos55l2ywxzdiagfif7cupkiyjfe7wd7ntvdci2xf@me536l2e5zjb>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <k2ugfhimeoos55l2ywxzdiagfif7cupkiyjfe7wd7ntvdci2xf@me536l2e5zjb>
X-ClientProxiedBy: LO4P265CA0005.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::17) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|CY8PR10MB6612:EE_
X-MS-Office365-Filtering-Correlation-Id: a0ccc218-dc43-4570-36cd-08dcffd39a9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?o1WFzqAKX3wlXr0OOM3Au+9Q84MVi+mc+vQfSrcokivWW6yaAgAnBahC/bvn?=
 =?us-ascii?Q?sLlqOBIzINb2OvKLC4evfols6u8wSUaUsdA2wx0dTB0sXzIff9JsN/oY++2p?=
 =?us-ascii?Q?PLoUdCggM4yNB2NaEoCxCE4rMaZd+KPIZkT6Vlg8Z1w7PWvB+rROCImRIinZ?=
 =?us-ascii?Q?xOHNHjVl1DLxW5WgqTdH3vNshdPiLZaDclxgI+vS69CYteD6lIidZ+wNCT6A?=
 =?us-ascii?Q?ohl0wsI+4scVyKC33AtZZjEQB4oTLecm4Cai/Bk/ENMwvotXhInOoM8fdNly?=
 =?us-ascii?Q?kYUi7RRuHp9wOeYsiuixb3ddLtFtwLE0Fn2E5L395y6bWQ+xBbKMXoMniapa?=
 =?us-ascii?Q?YJLZOI2LMFhLDbUsd9JzqIw9srzl2QPvwZ67LK63cG5hBzTWr7iwQjlh0SnD?=
 =?us-ascii?Q?XH1spBpRqHVSpr+R1a85xXRPlwsLsF5m3KIm5OSIeCOQiDkAnddxmIB3TdfI?=
 =?us-ascii?Q?yfMAcAyT5YgXaiU642/xAxoF/JK+H3IEiXufGgZ07TBICSIb8IJm356Jlxog?=
 =?us-ascii?Q?JldSBeYqa6+Y8pkTkRyOAUH1SfeUyp45F1mPG+rgIAH2lEjDhyyMtTI2oY7b?=
 =?us-ascii?Q?Rbbd0ESCPba909G0no7xeu7BHAaemS4ZaObmoQnfaBafsPBaiuC/5O1Lb+2i?=
 =?us-ascii?Q?O3dPXZHiltuUpUYQs84qUa0u3QLAkJZDpB7bv/f+tWKkb0BHlDH2lOAOftsw?=
 =?us-ascii?Q?Jf1q9Hg/f1Us4SBZa/T6VpELFXdRCaKc5WCBUZ8wD0Qfi1dk2gNTjG98u0Qm?=
 =?us-ascii?Q?vHlW/3ylZ1Fi4g7l2BVz5CF2HyUxnLoiXWSgQloyqLTd0LX7pPqmGktotAoi?=
 =?us-ascii?Q?I5Vp9sELB+ziY9VqmOPnaHRgWv03UKW61XhhFTRsSM8f2fUfgiE35rK+mS5E?=
 =?us-ascii?Q?8XDhBUwTg42Ec9NhVNdNlSvhgIZsxgbubB2AWb2xWdeyspn74NmFtzPm303E?=
 =?us-ascii?Q?pX9nuqoj5IGpZb17eWFnGhIHiREPlvoiMtvEQaFFkP8O+7VBPJ8+I9+69vqJ?=
 =?us-ascii?Q?KgHyjmSWIYnPWLpnG8YTeoQC4WOL42q+1NHVSw3hgnU2SDMkwg170tyEoLfR?=
 =?us-ascii?Q?Js7bMImhQiJhBxI2/ixNoT6eVdvAMQB2c1tWNKsXC0rKE0Ul1u21gtiaf7Yf?=
 =?us-ascii?Q?oX+XaWaDrIqcqNuB99LTywr19WUjN6ceGAOx/FOQrg8ii/Ip1fjEGue8J7cC?=
 =?us-ascii?Q?r9tRvcds1aVOaQ2yPtzwsJ1WxvEiObQqIXsADVRA0viWg9tPlpNJIE4tiGPt?=
 =?us-ascii?Q?5+wmRQ/+wj9zFPhVPK+X7EcPotGlnvHe+64hILqRF90rks0QNtzv/IwTaoXW?=
 =?us-ascii?Q?odA03fHhi+ksLCuoO9LCaqvf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qMl8wzclY/1r+6kVhCpESJXxp459/chSRhqigf0hW/drEseb/p1ER9KLQ6jB?=
 =?us-ascii?Q?SzGjS1VouBorNPKpPFOzy9WO6Q5zWego8+M3tDDcmtiDRKb86Q8DtIBPOTvY?=
 =?us-ascii?Q?JD8HaDK8DEcN4qyxAmQ+Neu7XBL+B5T5hHaqNspGSRzqEuekJ76V8i/t70Ve?=
 =?us-ascii?Q?vICr2+xf9uhca1wJxhgVZ0EYnDkMCDFFXT/8neHCW6JLaNkVkQkSNGoRagg3?=
 =?us-ascii?Q?kzy26qx+zWBg0hRuQXiC1XhvNId+I/q87DXU7ETeG+U+T+t7BzyIFoL3uKh1?=
 =?us-ascii?Q?C5ECmhF9mdOvRksWLXRRRPnR4PAMIZirP1HKO3HnrSIvczuFQ5EJI2G0jQkj?=
 =?us-ascii?Q?8TDIcbl27Q+z87QJ07KigVY4nhhA2PkgFqdZJlv71/R4PjAAK6g3qjzJ3sv5?=
 =?us-ascii?Q?SWYmdJmjNWrOuJ7iZOpSZu6xAwwlRnmIQQI/w/hPmVIXDKDQkaTGu5+rTW3x?=
 =?us-ascii?Q?3ke5UZ4w+XYUsIiThrzMXkIXmBzPutk57UV6nFAo/KSvR46+nsz372146f9Z?=
 =?us-ascii?Q?+1Zn7dDdZuW6+TD4FgJt0OoHilgqHKJBgwV8507h6fRhAv3P/YBI02oHafrH?=
 =?us-ascii?Q?7YW4AzZ5gNgM8ctBrkpKSYTq/J6rHRX+ZE/AW0lBLaux0kQY1svNIJgG0b0h?=
 =?us-ascii?Q?UuLIcEMK04dvuFahTTI5smSJjeHGk4bXKH+yi22PPzhmhZ8d/9G9VkTGQTY5?=
 =?us-ascii?Q?5fnJliAwN5eQn3SONridBmhJi/C+HoTY/5gczWygeegqt+QPwf5xp4rqKyoE?=
 =?us-ascii?Q?NJexQf/jLs+vXj3IhubjpFtEPkm5OUEv6I0wCkf28wcbCqNZd3HbXMLEF0r4?=
 =?us-ascii?Q?KUJ6As4x9OW/Mso7+a/cVOkRFyY3jeIrr38OSwkhgDJm+O5nhcp7ZwNKSJ7W?=
 =?us-ascii?Q?aADrufN95UvAaktsUybcoajwytbpQvMuWNmYQf5a295nKNNnt7BEmM/g5c0Y?=
 =?us-ascii?Q?U2+03F3TCycqiL5+JmGZQcn92Plv8S2PHE+L3m4TGKHKmx8CBt3nKLz0b8x8?=
 =?us-ascii?Q?96NxA/f8uHNp1EKL8sp6I6tPkBaoE/JopfEMPJkr/a0ELjoAheX9v6BRcwOl?=
 =?us-ascii?Q?e3ttrxEx0bAnmknjQwWsQ/t5baCbW74Cel1hC4Ao+OBpZAxa+awS5v4+oAgC?=
 =?us-ascii?Q?riidZkEQTiWLavRhzdD5/Pv/4afcTPr9eB4wL1foU7v4JYsB4ttnpaqJe2kb?=
 =?us-ascii?Q?/GSA4lCzHsRby4LVsfrou2S6BzkY8rNRrJo8S/Yaws8ro9POa9VPH9HlOxjE?=
 =?us-ascii?Q?oEANJmNmiaLrBGAa2TxVmzhJjIV6y7eO/IVXxgDQOIBtFYKVjCHqHiT3V8IA?=
 =?us-ascii?Q?QMpHKmlK42TbstIOHFhQSPC7kUIbGFk9qXBF4IwQPbCKLXgrrLxaWUVK2AOj?=
 =?us-ascii?Q?0cpfxy4YOZm7rVg4lzNJDxat3xoIH0ZdHUHAXSMk7e9JHE75j8R9MJTiC50E?=
 =?us-ascii?Q?IBwWOHCBh4DXMc0Kf/c7Vxi4UYZR/nhc98L+wrsUCd2gcVBDA4lQm+mcjQbf?=
 =?us-ascii?Q?ZrU0tI0cx5WChow5cMuLAP8krCcf33mZimvgRoYVKlvbawflff3TR9SliEaD?=
 =?us-ascii?Q?gLTqhfE67/7ln+taKDhHV3Fo6wFmWO+cqRExBz5BVLxed5PNJZlBJfM3SkAg?=
 =?us-ascii?Q?gw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XNzNBGutn44GT4upYrhHTTuPkH/EPsNMlfQ2yFnLQBvaBpq2Qfj0xRyepM0oDFsUgLt4vR6rcjzUBjKVrnS66AfNu9Q0KJrvhF1OewKjC1cMYx6I1v59CJetFKCw7vFHdem8+X24K7qd8xcFbkFY0xfiHJP9UVRdK2ys2eGKHTV+ViAwteGhq0Ca5XOos4YETSiI6GEEgG40neOuVlANpphbuDjIJUYpcJkO8Vn6kBXh2t7IjdFf07vZBBZUEkvhQ5ckemRYSX9nEUquR12+3Zd7ZWIfLSZsbRwUvJA/7OxqWnS61SOHRzDMXesIoXjqK24KyIuBEPVqQRBWi58Q98fh2GRAHS0Tsl5W2hAPVmedUjo4Js7oyhVMRNE4Fi4G0Ej4rnzi7G0Dn+RnBRq0xQ86kcE7BSTVhmEuiwy1OnXZVZ+CYwI3NLxT16i+aZY29PWFK0Gdlb03nXAYIUvlTrZ/91yjTKXif9kckEupdcjLn/Sb6Bqt6doQwswth2u8ZdD7HbzJCtLn2JPao8T/bnlPPqwRaFatOo4miV5mpbO5E4b9aTAGWkWSktH6s3U+qmtlZrsBqykznfu71ugnxmNKwzkfKMSBVGnuT8zSHtE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0ccc218-dc43-4570-36cd-08dcffd39a9e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 08:59:08.0021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zPyn1gv8uTugTDB5n+AUyxti8t3CQ2lLKH+TQWcXY5tOrPpGJI73Xg09XiwDFzAPINM3omeO+bicx46vTofeFUC8/v9sfiKU6a2ulGY1NfQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6612
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-08_07,2024-11-07_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411080073
X-Proofpoint-GUID: YrP6erP_rAxHa4-8NHIOxZMUzFscGY1F
X-Proofpoint-ORIG-GUID: YrP6erP_rAxHa4-8NHIOxZMUzFscGY1F

On Fri, Nov 08, 2024 at 10:26:03AM +0200, Kirill A. Shutemov wrote:
> On Thu, Nov 07, 2024 at 07:01:37PM +0000, Lorenzo Stoakes wrote:
> > +.. table:: Config-specific fields
> > +
> > +   ================================= ===================== ======================================== ===============
> > +   Field                             Configuration option  Description                              Write lock
> > +   ================================= ===================== ======================================== ===============
> > +   :c:member:`!anon_name`            CONFIG_ANON_VMA_NAME  A field for storing a                    mmap write,
> > +                                                           :c:struct:`!struct anon_vma_name`        VMA write.
> > +                                                           object providing a name for anonymous
> > +                                                           mappings, or :c:macro:`!NULL` if none
> > +							   is set or the VMA is file-backed.
> > +   :c:member:`!swap_readahead_info`  CONFIG_SWAP           Metadata used by the swap mechanism      mmap read.
> > +                                                           to perform readahead.
>
> It is not clear how writes to the field is serialized by a shared lock.
>

Yes I think there is a swap-specific lock, but I'm not sure it's worth confusing
matters by including that here, maybe here and for numab I will just wave my hands for that bit.

> It worth noting that it is atomic.
>

Will add.

> > +   :c:member:`!vm_policy`            CONFIG_NUMA           :c:type:`!mempolicy` object which        mmap write,
> > +                                                           describes the NUMA behaviour of the      VMA write.
> > +							   VMA.
> > +   :c:member:`!numab_state`          CONFIG_NUMA_BALANCING :c:type:`!vma_numab_state` object which  mmap read.
> > +                                                           describes the current state of
> > +                                                           NUMA balancing in relation to this VMA.
> > +                                                           Updated under mmap read lock by
> > +							   :c:func:`!task_numa_work`.
>
> Again, shared lock serializing writes make zero sense. There's other
> mechanism in play.
>
> I believe there's some kind of scheduler logic that excludes parallel
> updates for the same process. But I cannot say I understand this.

Ack, agreed, see above, hand waving probably required :)

>
> > +   :c:member:`!vm_userfaultfd_ctx`   CONFIG_USERFAULTFD    Userfaultfd context wrapper object of    mmap write,
> > +                                                           type :c:type:`!vm_userfaultfd_ctx`,      VMA write.
> > +                                                           either of zero size if userfaultfd is
> > +                                                           disabled, or containing a pointer
> > +                                                           to an underlying
> > +							   :c:type:`!userfaultfd_ctx` object which
> > +                                                           describes userfaultfd metadata.
> > +   ================================= ===================== ======================================== ===============
>
> ...
>
> > +Lock ordering
> > +-------------
> > +
> > +As we have multiple locks across the kernel which may or may not be taken at the
> > +same time as explicit mm or VMA locks, we have to be wary of lock inversion, and
> > +the **order** in which locks are acquired and released becomes very important.
> > +
> > +.. note:: Lock inversion occurs when two threads need to acquire multiple locks,
> > +   but in doing so inadvertently cause a mutual deadlock.
> > +
> > +   For example, consider thread 1 which holds lock A and tries to acquire lock B,
> > +   while thread 2 holds lock B and tries to acquire lock A.
> > +
> > +   Both threads are now deadlocked on each other. However, had they attempted to
> > +   acquire locks in the same order, one would have waited for the other to
> > +   complete its work and no deadlock would have occurred.
> > +
> > +The opening comment in `mm/rmap.c` describes in detail the required ordering of
> > +locks within memory management code:
> > +
> > +.. code-block::
> > +
> > +  inode->i_rwsem	(while writing or truncating, not reading or faulting)
> > +    mm->mmap_lock
> > +      mapping->invalidate_lock (in filemap_fault)
> > +        folio_lock
> > +          hugetlbfs_i_mmap_rwsem_key (in huge_pmd_share, see hugetlbfs below)
> > +            vma_start_write
> > +              mapping->i_mmap_rwsem
> > +                anon_vma->rwsem
> > +                  mm->page_table_lock or pte_lock
> > +                    swap_lock (in swap_duplicate, swap_info_get)
> > +                      mmlist_lock (in mmput, drain_mmlist and others)
> > +                      mapping->private_lock (in block_dirty_folio)
> > +                          i_pages lock (widely used)
> > +                            lruvec->lru_lock (in folio_lruvec_lock_irq)
> > +                      inode->i_lock (in set_page_dirty's __mark_inode_dirty)
> > +                      bdi.wb->list_lock (in set_page_dirty's __mark_inode_dirty)
> > +                        sb_lock (within inode_lock in fs/fs-writeback.c)
> > +                        i_pages lock (widely used, in set_page_dirty,
> > +                                  in arch-dependent flush_dcache_mmap_lock,
> > +                                  within bdi.wb->list_lock in __sync_single_inode)
> > +
> > +Please check the current state of this comment which may have changed since the
> > +time of writing of this document.
>
> I think we need one canonical place for this information. Maybe it worth
> moving it here from rmap.c? There's more locking ordering info in filemap.c.

Re: canonical place - yes I agree, once this doc goes I can follow up with
a patch that replaces the comment with a link to the official kernel.org
latest docs etc.? That would also allow us to render this more nicely
perhaps, in future.

Re: mm/filemap.c - these are getting into file system-specific stuff so not
sure if the right place but there's a lot of overlap, maybe worth importing
anyway.

>
> --
>   Kiryl Shutsemau / Kirill A. Shutemov

Thanks!

