Return-Path: <linux-kernel+bounces-308725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6079660E7
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 13:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41513B20F79
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 11:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2AB8190674;
	Fri, 30 Aug 2024 11:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="E3qWdtHP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="O9UKbdUq"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7265D17DFF3
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 11:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725018126; cv=fail; b=KfHWt10Csv5Q8bbWPe6spzbdPvCJQ9fpc02Uj7S6TEqYzHruSJqYqXXI9yl5OfGr0JoXI3kNYjZ39HzBkT4dxqT/9Q8hfQFaPcuaE1Zq07YpxsFg2Mzv989ovvORh0Y/gpJN43cb0zP0CoNTVE4ttD6i9xS5ZjuvOihnv+a/Wus=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725018126; c=relaxed/simple;
	bh=fUv0rLv6NZPlBnCxPEU6TjACxFtB9zD/4sPuiJuK/ko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TEMJhhDfdxKt0ODhwRKYw6sOEC4idui5e52Di1L2h9yJzRYAZT8vk1aK7Lh4avb0tL/WQz3Ahgme7o3WDyd/wkPvbX6qlTUHdCGJqU05RYrQiegukAysVgJos7709deyk1N3XckWCoctmIpULLreXuWm5V45zNJlKW7kfotCYsE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=E3qWdtHP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=O9UKbdUq; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47U9YUYZ031074;
	Fri, 30 Aug 2024 11:41:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=I+fYVKoYcD8/cST
	42yOFSvE/hZMs8K7Kofo8YT01nrA=; b=E3qWdtHP7LRcYb9d7qAZkNbp56aRbsF
	n+B7y3bf+OeFPe0MBqCMucKVEwJsQkAC7c2tKg0C70FrpkvqtFkBcvDNjkQb3xHD
	RwwggBxaDhV7Zng6/MK5Old1yzOo2Pee+tsCLFxWymVW5FELMlGBRnzvR3DV4Ri9
	XL43n04jnM35N0cuXaFQDWkBqCyhZOKCMWJe/qt/IasvsGnHXkRX8dwUKy5LVkGx
	yaw6jdXJkdjogsNGLKBxnObwKvt7ZubVp77rQwglvOGtrG/iZr5QyrMnxOy3ad51
	1J0tjABqjf2Uo5ydt3bbsAOzthnHkzZX6dQdNOhP1rxZV65uNxgd4gQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41b9v7gct2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 11:41:47 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47UB85Vi020182;
	Fri, 30 Aug 2024 11:41:47 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2046.outbound.protection.outlook.com [104.47.56.46])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 418j8rq78v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 11:41:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rTsiOUGMroaK/IkAozz1azYvjrgJwdjCvIfFxDVmKM9H0jqxSHHptDwQ/c76ST+XgnMt05o33wLJmJAuZsjZEirAySmMHVmRj2lSvReQ26OYXGxBtXbFTyNl37QdvWDB8DjE399lsQ6Dhhilugs54TFMCDklCf8Njyp0BwOII3fSCsI9ofBWCR7NgkX3TTxN5PEKJ1fdBemdZ7PWrSDou2b9JTf55zlN7Zy0PyhgNc3b2YT14FXtTHxETpRREGjwYbv0hQTUFWhjbgXLATmGcserGHu1hic/CAz7/onKlPc5BhVmSHrtRYPIdAEdy0KjS00ZD45cowoHSveuyyM2UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I+fYVKoYcD8/cST42yOFSvE/hZMs8K7Kofo8YT01nrA=;
 b=gfXKY6bWzwxNoJ1hrju+EuTKse5faEEg7YZQYXUMDVFfum+EWTMfJx3wWenscW46Hnd6stggwXkZ9FIM7BdY1ITWYOL2eRs9vEv1rPhO0iNaQolPlJixYQqXFD8tUjt23xoUXY6Io+7m4w6E52vwXaTfkJFGjaU1zZV2PXScKiKpVV5VsRdY0Yku5twzs13xwIS+iFH+qd6EwpVMCSnMnD4kaQsYQV33rLLXG4PgaQIw6ItbO67OSSxyP0jo1unLUwYbG/4kj4PKhrZf6xi+qCSXwaQwD5hlzFO0D9DztXAYgnx6LzrGh5Q0SH9JRcHjUI5n6bv6HSH7wvJ+mwyu+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I+fYVKoYcD8/cST42yOFSvE/hZMs8K7Kofo8YT01nrA=;
 b=O9UKbdUqQpBQJ0xmhuInGUR5sXVZVwyrFzUloIcDSCF+53NTMnzuiA2zz6aSAKMo1e8fgja9HPvjSTCUB1ypeN2aP8Z1Ma5j3BfgZvMJdJb0xX0/nhzyFVs5JsLT/OxBIczuBGhBjG9bCXD4nGu9ldNwaaasLChLiGe4QhB4OLI=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by IA0PR10MB7256.namprd10.prod.outlook.com (2603:10b6:208:3df::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.17; Fri, 30 Aug
 2024 11:41:42 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 11:41:42 +0000
Date: Fri, 30 Aug 2024 12:41:37 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Petr Spacek <pspacek@isc.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: Re: [PATCH RFC] mm: mmap: Change DEFAULT_MAX_MAP_COUNT to INT_MAX
Message-ID: <90f07fec-3f46-4b38-86fd-07c9f8201904@lucifer.local>
References: <20240830095636.572947-1-pspacek@isc.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830095636.572947-1-pspacek@isc.org>
X-ClientProxiedBy: LO4P265CA0093.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bc::18) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|IA0PR10MB7256:EE_
X-MS-Office365-Filtering-Correlation-Id: 66a8b096-4332-4b32-dbf1-08dcc8e8b7f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?L+AzPZEBG0hHiCxUIQLqnwKj749DNquB7VAT1bQebA7C3creIo7WSyd/7qr/?=
 =?us-ascii?Q?nQWeTTHjFzQeyCJUioffvjM6gzZdvu1OGsPa/oY9BtGl0iqIrK9REaTu77C4?=
 =?us-ascii?Q?Tr4s2eoDhPEVOeOAmc+yYSjNDLh/XNPdyOkUaXrnwtitSsopQtb+5Bl60TGz?=
 =?us-ascii?Q?O2RpeHwHais6EHB4tyjgrVdVqJYIuKCFXcZeKL6su/HYMQt/2p0lxND6nkxY?=
 =?us-ascii?Q?0AJpwjAEz8OVPou0bFODeJwVi79RTMZjFbnXqlvFpPixMMXg0BgPF9b1N6Xd?=
 =?us-ascii?Q?msNjaPKKKnaccS17hbUdgUCAwSGWk7U7cjcGS7lXJ85tS53C9usK4n43xPtX?=
 =?us-ascii?Q?aeIjxbc60xAxOAYr1809nf3DdY3377aoL1jYB60lc4rRLJ0VmmbRR6XIfJhu?=
 =?us-ascii?Q?Et+ojLtuRYE2SZFDDR5PxlX71SaYfbXDaUg6ovhNDSw6ZPc/55tbjJ2ZUZJc?=
 =?us-ascii?Q?qp51E59BPDb9EQrgi/sVgAMFT/5CyU02DApzrjXtvS1k95V4xVRplYgA9lyQ?=
 =?us-ascii?Q?mdAN58Y7x8krdsyEOobzTOBIQyvYSQ4r0cxMb0t1XXw+rFwCL+WJNmkiuVM5?=
 =?us-ascii?Q?4XEbOrHzcgVU+vngNkIvCHUXHkB96dRO4ugtMoXolMAktqPxfYNZa0a2Qcsv?=
 =?us-ascii?Q?kkW5N9MEXugrVP2CyZpPW921EF+F4HWzOgBHJy+bHo/rNRGyM4bYOLshP7u2?=
 =?us-ascii?Q?gNee7SW6tfg1iFyuJ0bP8scfSamyAbEpu+5bjkEHtMP4ofsZMAV6x503xdUr?=
 =?us-ascii?Q?s8CoXH018d1rIm7CW1mg0w97BxFYgV4yQyzRFdvwniMUY4dnF1yclkrab/gw?=
 =?us-ascii?Q?CH1gXA/JSLCDGrodCJjdwxqTK7hVPQVg2h6Eo+Bm2Ln2Gy57/HD0JV2k8nMu?=
 =?us-ascii?Q?dF0KsaDfz7rojbHqDDYhnrW+XzVb+73uslEIac7Ylhg2MvLhBrvuFilH+8c2?=
 =?us-ascii?Q?8gqsTg5Cf+mTnmE843eZ1+Su7rAl4pVostvi9khJ6bOHCKM7WJQW0//f+M5/?=
 =?us-ascii?Q?JojlUDv6i+GxLSsctJlDMA0Svt+Pk6YkiAPCyq/FFHsWY0apnjvhd7kNbCCn?=
 =?us-ascii?Q?sx5oKApnXjvjcHxKZTVUPboOHjx8vSorfvjN0s+8e4/BvqD6PoHyI/8cz2t9?=
 =?us-ascii?Q?t9H1xOEJEmbWseMRYAkT8nNU1vSMiZeuQjNEHr1Kvv34fPa4ffyECJ87Wrze?=
 =?us-ascii?Q?OP3KVMNoc4e7ugA7xDMB0B+U7HzKtCURIkf2uJQ4nE9Ebv50mQz4NirVSxyf?=
 =?us-ascii?Q?eR+EmM2nfATHvBp1VFtYTtwpWE8owCkpqmri7uBDFKinF6Keqb5CTO0rJqLf?=
 =?us-ascii?Q?p9w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Drn3dE33hDTtFmpG7frzfzgUtsbkmrmykPQKRQ+5r/DNaiq6dDy1cEXb0uiM?=
 =?us-ascii?Q?mIrt/qHitRLMvVfng0XORYEWUMRpZTL4J6G7xP9UkDQvnar882nz5rK309U9?=
 =?us-ascii?Q?LPffA5TYJ8N3I1FEVhg3lotD3D7V2atq4uhZ2R4JRSQ8/Fw22aOYalbLYMdb?=
 =?us-ascii?Q?WA7X4e3Oq2e1GbrVGLPEGbNQOHHcJwBS3g3JyiGch9DhuVbkWcr8L5VCdVkp?=
 =?us-ascii?Q?Q1I8yO4wGFx8SNWgjeypXTyO4yHqxS8Dj+d3YDgrkyTwfbGi05DLYpAdSQWI?=
 =?us-ascii?Q?k0AQItyuDS0UA4bju/jWZGJ4N4ztNUCtvxkGvwCYYR9OPlOboINjj0O6eI4k?=
 =?us-ascii?Q?u7iaTL+kUb3cF+j2h2Bz9rIYtIiMdjCpz4b+3Oqdkhm/qB857/wo13nTctl+?=
 =?us-ascii?Q?N5Gr164US/jokPUV03wSHhhnDGz5Tpf7FW+CGhwYchu4s31gm8TqvQuXUwGT?=
 =?us-ascii?Q?35drBZNLEtzfaYoEoq0t9J7nT5v8bnTH8Gt4+QeUY4xgkIHXp+3nioFUFB2w?=
 =?us-ascii?Q?CIicR5uVlHUHewZZk0s3rfX8L0aSndtQpVPqzMD2p+CHffdAS7JykWWUb/RJ?=
 =?us-ascii?Q?qfKUJ120Q2ouYTX9oleoNW9vFMMDMedRLhjzjYGAL5ha6AjpA++mPAUjNGF1?=
 =?us-ascii?Q?ht3rU4yEuO7wR+q3ZABOy4kk5Ub6Mz52Hx5/ayLuZOs83UbWevQnAyci8RfU?=
 =?us-ascii?Q?9aM6s6gFRuXalbcAyp86f2cB4H/yx8fb9BPyzJadY6D/IhmLUIK1D4uqt9vh?=
 =?us-ascii?Q?G69dE53UVxuIY96Sg/saI6YnFWwZ9grQLfVmRd8kz+F7U/owpcgbmQzMqtIC?=
 =?us-ascii?Q?RR3Mopkxybv5B1U8J3Rr6CTfrusaf7bfmqU9ERe5NFapqN77XLICUMLc9RAS?=
 =?us-ascii?Q?aNCFGiyj6ifBvb0x4bMjtR39NFm7AP47oEihe3V0lIbpXjzeUt3sXbhktKgO?=
 =?us-ascii?Q?IhyA6GPJYVLhQJ+JdDIkBZsstn6nBDOtR9jQ/yAX6rOqe8n92yDiDOBUEV+9?=
 =?us-ascii?Q?FByqvs8+uV6OhWDIRf2ZFlSCq8PLkDNB486gFJqXeyd/BceAyrUwfXXagGPF?=
 =?us-ascii?Q?7FoTNJTwQdPNyn+vXAlKZx+fA+j2mGbr8aRp91/q5pa78YeUaQ01sb+vMuUE?=
 =?us-ascii?Q?OTpLspcsKBv1LKw/X4xO0Um3xQo/rZ53CVtap7mE1QVy7WyuOY6KUh49pwku?=
 =?us-ascii?Q?hykQzZCP4ZCc3s6fPqTuVKyMiJPb1B+xvliWb+TxSL7nFvx/IRUE37YQrxiJ?=
 =?us-ascii?Q?9Kq54EYxJFoTudxvsYMHIWClkwLWwEYvLf2yyHFPimqH+uSbZKouu2QZP6gl?=
 =?us-ascii?Q?NaFlb1ACqWJbkGgVQy8RZu7pxSAjqA8HUPnAxz1ytSEMnisYh+6cuyIM/wgS?=
 =?us-ascii?Q?G/dzy5otfHlNsbZmDwu0xC4e8WYYgmyQYk5akuDeNf2X0vt52fIIFbqnLkUS?=
 =?us-ascii?Q?EZHGb4+f6+CXONJD2gD3ma2i9hFWY2MQY4905KS+8zS0mBVYGxueL0Xz6s+h?=
 =?us-ascii?Q?xrC8aYjbKxCyc5b4e8wVX/+BXtRLmYLtRaSekvRMtM9wcc5uc7OnF3TACmAY?=
 =?us-ascii?Q?I8IkNOhnR72jJpJPeuzEG3V/tuVnpdCbkqt8ffyQHKkbqKcqiUN/ELfAtN52?=
 =?us-ascii?Q?98izavuadznHcaXl6tf0Qg4kiGWkl0qd1u2cOVxObyWrw2zJRKxL0melWfkE?=
 =?us-ascii?Q?xLWMNw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HgCRMcH3SO9jYPBZyRKtViE8CKGAnydm1DkCMullDynoS7CUvW86oXUfQGaG0un9xGyRdDnR1d5x+z4qsjJdw6DZfauxaI/L8Jn7dV0YJUGrjkYcnJxxJcvWx9u6egTA7GFVYE8wUUFVo8Lh8qn4qVsJ0DBnKlsgKGKYt94dKtKGVCg99gaO5E2o6qoUDew1xCdU08co5JTjH0v8EL2/X1098rOJq4sY/QYtishD1u0KwzvieCEpTH3RKxxP6xMSUb1agzY5cf7+GTak+3DiPxUQmzQPidsdFK3RYAkz2WDu9XUBDC5670rPcTzanolYnxn06k4VzxBlfonAZwopfphzXfocPriRq/2XMsj/OsBv1CkxRCaCzUUTYgE3ZsOtE13GzPP5yywMy10mMJ0U8iem50yqW4V9tFBXvlnna8ibgbahrCzJbutIV+DILv3a7QZflcxsXwu5X1nOeoq0am93SbdnE1dO+coK1Gw8c1uabmkCZR36Xnt7yyPn4Zdv+5ibqnlCATC1DYbY3oRzRX0RswPMF2HAjG7akTc8ectUU1W1TJYvtR5sCj6TqzLPjP+9mm7afZtnL7FOM7mUgngcnBMT8cil/ybgHmK+/XA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66a8b096-4332-4b32-dbf1-08dcc8e8b7f3
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 11:41:42.6315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cfYp7QhGn+0jPb/VUKu/h11xgGaRSQo881Bu/Wv7hhv5NVWm8zsJA3zzsc2iAL9k2400WLn+sRH1kGAqEdoMzDJpcvxdrKY3EHgip+qpfro=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7256
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_06,2024-08-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408300088
X-Proofpoint-GUID: Nbho8N6uK3GjStBuzD8lF5ocafl4bPHs
X-Proofpoint-ORIG-GUID: Nbho8N6uK3GjStBuzD8lF5ocafl4bPHs

On Fri, Aug 30, 2024 at 11:56:36AM GMT, Petr Spacek wrote:
> From: Petr Spacek <pspacek@isc.org>
>
> Raise default sysctl vm.max_map_count to INT_MAX, which effectively
> disables the limit for all sane purposes. The sysctl is kept around in
> case there is some use-case for this limit.
>
> The old default value of vm.max_map_count=65530 provided compatibility
> with ELF format predating year 2000 and with binutils predating 2010. At
> the same time the old default caused issues with applications deployed
> in 2024.
>
> State since 2012: Linux 3.2.0 correctly generates coredump from a
> process with 100 000 mmapped files. GDB 7.4.1, binutils 2.22 work with
> this coredump fine and can actually read data from the mmaped addresses.
>
> Signed-off-by: Petr Spacek <pspacek@isc.org>

NACK.

> ---
>
> Downstream distributions started to override the default a while ago.
> Individual distributions are summarized at the end of this message:
> https://lists.archlinux.org/archives/list/arch-dev-public@lists.archlinux.org/thread/5GU7ZUFI25T2IRXIQ62YYERQKIPE3U6E/

Did they change them to 2.14 billion?

>
> Please note it's not only games in emulator which hit this default
> limit. Larger instances of server applications are also suffering from
> this. Couple examples here:
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2057792/comments/24
>
> SAP documentation behind paywall also mentions this limit:
> https://service.sap.com/sap/support/notes/2002167
>
> And finally, it is also an issue for BIND DNS server compiled against
> jemalloc, which is what brought me here.
>
> System V gABI draft dated 2000-07-17 already extended the ELF numbering:
> https://www.sco.com/developers/gabi/2000-07-17/ch4.sheader.html
>
> binutils support is in commit ecd12bc14d85421fcf992cda5af1d534cc8736e0
> dated 2010-01-19. IIUC this goes a bit beyond what is described in the
> gABI document and extends ELF's e_phnum.
>
> Linux coredumper support is in commit
> 8d9032bbe4671dc481261ccd4e161cd96e54b118 dated 2010-03-06.
>
> As mentioned above, this all works for the last 12 years and the
> conservative limit seems to do more harm than good.
>
>  include/linux/mm.h | 21 +++++++++------------
>  1 file changed, 9 insertions(+), 12 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 6549d0979..3e1ed3b80 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -178,22 +178,19 @@ static inline void __mm_zero_struct_page(struct page *page)
>
>  /*
>   * Default maximum number of active map areas, this limits the number of vmas
> - * per mm struct. Users can overwrite this number by sysctl but there is a
> - * problem.
> + * per mm struct. Users can overwrite this number by sysctl. Historically
> + * this limit was a compatibility measure for ELF format predating year 2000.
>   *
>   * When a program's coredump is generated as ELF format, a section is created
> - * per a vma. In ELF, the number of sections is represented in unsigned short.
> - * This means the number of sections should be smaller than 65535 at coredump.
> - * Because the kernel adds some informative sections to a image of program at
> - * generating coredump, we need some margin. The number of extra sections is
> - * 1-3 now and depends on arch. We use "5" as safe margin, here.
> + * per a vma. In ELF before year 2000, the number of sections was represented
> + * as unsigned short e_shnum. This means the number of sections should be
> + * smaller than 65535 at coredump.
>   *
> - * ELF extended numbering allows more than 65535 sections, so 16-bit bound is
> - * not a hard limit any more. Although some userspace tools can be surprised by
> - * that.
> + * ELF extended numbering was added into System V gABI spec around 2000.
> + * It allows more than 65535 sections, so 16-bit bound is not a hard limit any
> + * more.
>   */
> -#define MAPCOUNT_ELF_CORE_MARGIN	(5)
> -#define DEFAULT_MAX_MAP_COUNT	(USHRT_MAX - MAPCOUNT_ELF_CORE_MARGIN)
> +#define DEFAULT_MAX_MAP_COUNT	INT_MAX

NACK, you can't abitrarily change an established limit like this.

Also VMAs have a non-zero size. On my system, 184 bytes. So your change allows
for ~395 GiB to be assigned to VMAs. Does that seem reasonable?

It _might_ be sensible to increase the minimum, not to INT_MAX.

Also note that you _can_ change this limit, it's a tunable. It's not egregious
to you know, change a tunable.

Also please cc- the MEMORY MAPPING reviewers for changes like this. It wasn't
obvious because include/linux/mm.h isn't included in the MAINTAINERS block but
that's me, Liam and Vlastimil, cc'd now.

>
>  extern int sysctl_max_map_count;
>
>
> base-commit: d5d547aa7b51467b15d9caa86b116f8c2507c72a
> --
> 2.46.0
>
>

