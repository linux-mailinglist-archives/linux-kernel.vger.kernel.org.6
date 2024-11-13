Return-Path: <linux-kernel+bounces-407834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 905129C74F7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 16:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E7B128A04F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 15:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E010D1C695;
	Wed, 13 Nov 2024 14:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Z38ot0RT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="b4wbTI+0"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157F813AD33
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 14:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731509955; cv=fail; b=lwS65XEcvuKmDsaUtzwHzVBpAOKH+AF0kDI+3MoCk9bBNChDfcHwZxBvMD0RKtOhuLYLTk+fB0mdTw0r3RuUE7/3dv29n/mQ0CfSYu1mDLefB1x4QatVQxz+r3Wkju3yx13TtCV3jEkyljkdlSKUYwBueCPdwUxhRhtGs/jFqI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731509955; c=relaxed/simple;
	bh=VRVNZr17W6qJF6tYp1wJDYyGm3nzUQ6PMefwaB+ugO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NZ6WtuQgNlovkmV7LHm+WBEIHwYHg9dbiZO1rCoAY9ZOlFM6ZFEtPwZf2HXWuQokDlpEuYCrMmnC9zfg/J1piJQilEtDapHHx4mXvDK6UkDW8g0wIJmfo0ATv4WRq43bwuITjB3fSws28OjkjL7IvsOIR8ZrFEx1r/dDOS6MzVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Z38ot0RT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=b4wbTI+0; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADDXXQN013722;
	Wed, 13 Nov 2024 14:58:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=WSs1K46Qu9XQZqeueE
	vdW1wRzZvKv+wK/M2sp1QGf8w=; b=Z38ot0RTf1XMKZRsVgP0Fv9A0bQ/5fBqNB
	BRqOWpMkroDVKkE4kwaVIAiAZEk03+Qz6FT8EX6UY2cs/l+j+u48nw/hUitLGkH+
	idLzhdvSMSWumfN3afLMw3N+lrICLgVZ9QRuNx4sArIUFAAyNyBYhU3cxfuwllCo
	XoXtx2Abqk/epWfYvzO9YXZKfL93v28lSCa+mr2XI8rArIKVnrq0FvBBXM3Tu9UK
	ugqVmJ5iIT2ib+vL1JqU47jEYZjGe8ndUdYj2TKngt2BWandzESQiaW4OoZuRFe8
	oiQ6JbQbrjG8QZ3AxmMKlte01DkpPLmjYiKMHuXKoopxQLm3H4NA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0mbf3x9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Nov 2024 14:58:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADE2AqZ001322;
	Wed, 13 Nov 2024 14:58:31 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42sx69r19q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Nov 2024 14:58:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iKSAi2cS9TOXAZLrtM4Mnn8Oe2KJ8IScNulwD1LM5cJsQb5RGVum9yDNHch0Pgh+oUCOq4jDrERYx6fxl7bJokZC6P3NJz1yCLUMyEgsZsxn9X7OdONyK7Pjsm9tVFRv1/HxKSRUB94lodYXT0gN+O02rbV+qbPz/wKqq83Ued5zEe8lauS2t5hankUFMzBZPrm/LV9csLtmq0soK/8rcB4ALe+mMmgKnax0IQ0nJASo5aWnLvTI0NOlVA72fc3TM+vjeOY3I1V3F0D0V5i4KksrpfJxf/jNtatan7NBlbvcqaVDjZIiOzwJOLWKhZPUgIJtEbomgY5OoKn9qrzGxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WSs1K46Qu9XQZqeueEvdW1wRzZvKv+wK/M2sp1QGf8w=;
 b=xaJd4gJJNcd74RxJ8+kkJs978xJuZHS3kLLAur0987dWzXzGqbGSVQcrmTQ5kvb6A5FaSp/nvPlFCZjvrwCAVvGbZoKd6flBNZBgjneuXO4RgDfsSmmgLarURxgKBfRMqMWe5Jsh+VLgP2Iasom+aloHE/IpdEWHeHXgCoNm7HWhUGVk8wVmwN3LqHKW7VUus3x1yoWZlccxigjtxwDyFn+BwNB0/FEmVhJX5xEm3QKrI+3qPvkncCPbgJXglN2R3hNfTE6eBF706YHV/r4kmtBTkNh7R/ZYckK8rxF4yF2zaTPWQzJ7dHCg+x/Ub5Gc73SrJ2+ctN55jcb9qfVQ0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WSs1K46Qu9XQZqeueEvdW1wRzZvKv+wK/M2sp1QGf8w=;
 b=b4wbTI+02Pd4yisEhY/jwk9Ja4em2+GsvRH6iMjqFhJhxtmuCbpMHCdufla9MbHX/KOgXMpFcb2E2biuu6ih+/m4HAIdal8WUYdzUydaYAlpdt0o2+El1GG+p0pe4vFYJ8kfg7Rd94ryNxgUPjKtIRQAGvstrQ+/aqz4+tA2miU=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by PH7PR10MB6179.namprd10.prod.outlook.com (2603:10b6:510:1f1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Wed, 13 Nov
 2024 14:58:22 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8137.027; Wed, 13 Nov 2024
 14:58:22 +0000
Date: Wed, 13 Nov 2024 14:58:18 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
        willy@infradead.org, liam.howlett@oracle.com, mhocko@suse.com,
        hannes@cmpxchg.org, mjguzik@gmail.com, oliver.sang@intel.com,
        mgorman@techsingularity.net, david@redhat.com, peterx@redhat.com,
        oleg@redhat.com, dave@stgolabs.net, paulmck@kernel.org,
        brauner@kernel.org, dhowells@redhat.com, hdanton@sina.com,
        hughd@google.com, minchan@google.com, jannh@google.com,
        shakeel.butt@linux.dev, souravpanda@google.com,
        pasha.tatashin@soleen.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v2 2/5] mm: move per-vma lock into vm_area_struct
Message-ID: <7eea5f41-acf0-4feb-8138-a93b67473ccb@lucifer.local>
References: <20241112194635.444146-1-surenb@google.com>
 <20241112194635.444146-3-surenb@google.com>
 <637370b8-3e3e-4457-81d6-5913a3ff1d4e@lucifer.local>
 <dc1453fb-e066-46df-96ad-fb70cca985a8@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc1453fb-e066-46df-96ad-fb70cca985a8@suse.cz>
X-ClientProxiedBy: LO4P123CA0483.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::20) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|PH7PR10MB6179:EE_
X-MS-Office365-Filtering-Correlation-Id: c9256b22-e9a1-428b-e75e-08dd03f39e3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WiBnl69jfYj0mqH2T2BbUrN0ZxiObOTjiDCAV89Cejo531RgxCPqj7HgCbzr?=
 =?us-ascii?Q?OFJ+EyazyipQ7tWIPpjYV4n/r6jCjtWBi02xbTg5snM4oxHJAiJjzPOgbsC3?=
 =?us-ascii?Q?si2oXyTjLpEknuLEobQD/X3Ck3DeA8efhCwPIDYYRXmQegakc6qZFxVeeHEK?=
 =?us-ascii?Q?CNyScJ9VNByK5zoRFQLTf84d20RI7S6bBgkpGuFwPV8VdwLtrrhSG/gT/NB3?=
 =?us-ascii?Q?VOoSvKJOHMW76h3d3wmI85UPTsfg4u0oJKL/Nr9aCPi+fpWbWWmhYAKpMguy?=
 =?us-ascii?Q?VRdGItwRmUMFeo+L7DqP+DitqzkBpbCKGey5e47THeKODSI6Skcl3jLRoXdU?=
 =?us-ascii?Q?1deElBv8zddPxN/tX5ipii8nBctBAVW/beD0I3JhPVqI47rLtgisi1bV9OKW?=
 =?us-ascii?Q?lLoSTM66jQt8YbOxR+MkBUcblYPa1ni/P35tLhkUS4AKUsP4bfSScO6C7GUd?=
 =?us-ascii?Q?qPafw2hB2FMbLEDDmPK9KtB61jtDv8eSbZaNX1w4nGqXPWo21GR5KmcckQD1?=
 =?us-ascii?Q?TYuCWcdGRFhfaRl8rEeVrdjhd0a6jRcjfQOXSypJ3F9PdbIg1yG1cKqWTyto?=
 =?us-ascii?Q?arLkVBplTVacz2KxoJuXYkC3WUhbVe4hNfNEK0P9o7A1RpN/X8/4Ci4KloIl?=
 =?us-ascii?Q?6Jjsitq+yF1yFKpmbnj/+FNg3eMvZDWvOOxSraaMWR/zAybSopYzpVwBHKxu?=
 =?us-ascii?Q?rMB/3g2u45LHoF8Rz0GVruimYwvbu3LyaLGyFFD1Mmtuvzp/vFtBtr+yDv0/?=
 =?us-ascii?Q?aGHzjahv0RPLMk1tG9EvHGewLCIQ1LSFmobu70Xd8gsl21mUoXKoEtxLxzU+?=
 =?us-ascii?Q?gOaXXILe8h1YE3rBEYjNkYty2XWTG7qKAgnbjQwUDGi6CUllJImFqswW39iV?=
 =?us-ascii?Q?YIxIsgpC81ywb5U46HD1aZXrnE48Wn+Kgp14wyUmjpt4pQOgQnccPU8VpRwD?=
 =?us-ascii?Q?lj/qQBWAbWKOBwN9yEafblyHlOC8v1KJ5norPIwTR3TX3eO8Qg2y6rFbtLdL?=
 =?us-ascii?Q?wI41Tx4gbU2/O54zjMsEc0qXIykC2snS+97K9xj203AtWqv4MdaHg0+F1SKo?=
 =?us-ascii?Q?LD6FJ+NETNdx+rcPvJjQTaKQ2rtC7eyVtkYkZ25QtWYPExaiT7RHgafvNSvc?=
 =?us-ascii?Q?ZVHYucdtZ9SwqZhr00Z+A4YmUBdZpd0S51M/1atA3qBgiYfKoFjjl81tLlZt?=
 =?us-ascii?Q?vD7zXRGoATSc0wKnMx+I3D2imvNZ5WmO4upzS+mrvHXHugxUnqaGIpNljZAh?=
 =?us-ascii?Q?6PQoRxwfK/FBfcM3NyG3/rY5SLs3wnWG9yG0+pNbFw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SbQZ1S+shOHB6XVx0fxUoMqYBREAeHAseT0O8OtJ6yTRujkHnUlhzYfHDjI4?=
 =?us-ascii?Q?SDhzL24tq6JzgapG2GWuFICE5uj3q+XU4SpqmMcntyR2lOglI2thSF4LIRUc?=
 =?us-ascii?Q?B3GIGzY3bDkWIUcUEufiVU2nP8u4WgBhYJ+Pi+ilQLpUJDOk9GLbyBb78Xcz?=
 =?us-ascii?Q?3GBSeKX/MOblOdOvcgJi+hacMEdJJm11k4tRBE/MWOV3ka4hQOECoUssdmJc?=
 =?us-ascii?Q?6zO1Ij9+k/bNGmfNbYCAQVSl0hHlvHzHdiwgaMN+JxFQ1XuoRNUXmzzZ3P/t?=
 =?us-ascii?Q?YhWVLNl+wN0LGZJP0E9GXiK5V1Rzqtx/5/ukSbbmJppzf4hAzAOvn+TAXKiW?=
 =?us-ascii?Q?XCWEmixOD+UzZsxw+4nlewHi+KZCye9NAhcOuQ9his2BkqFDuTUyze8ovury?=
 =?us-ascii?Q?2DZYe/Cuv0kfcmX+RA4iCjJ8G9IkUbTLOQnTPREIkJeoC8QhI5iiEhBxvu8Q?=
 =?us-ascii?Q?lNUPmFk8/SWjrZO787mIrcZ9QzpHGdniOZvNM8K5Uf86H+uMaTT214mygVea?=
 =?us-ascii?Q?4yGoR6kXL9FWM11oBqALDGBQpTL4fIf4pyrDAsxHlEC/27XSAW32pkHRVekC?=
 =?us-ascii?Q?YofIXmMKKHQXn3GxHUXU4AmIPGaWBQi0HxaridiA5HSvBqeyUYd5/wyrnThY?=
 =?us-ascii?Q?T0DJbXB+Kgo0GC6x6rFySB6HJsS+0xui1nb0s77sOiO5AIgMd69MWUWhH8jt?=
 =?us-ascii?Q?nQ2O/wY1j+DJMaDEDjkE43wFQVFi935RReWe3kC5XXbvMesUVerXpryr7jw2?=
 =?us-ascii?Q?8f6N41ph8aWN/2QT4AElI+dgTzDEeTxH19Mf/Py+AmtJA0/gianvqV4S+3/d?=
 =?us-ascii?Q?DDWsvhZfpX1nWi3IOhIjVtTE4/gHAyELUl1pCnVc+T4HHKzH2hXjIeolkdGI?=
 =?us-ascii?Q?bLYVtoPJyp4b3eWvoT2/uZSIEITUuKj1Vz4Rw6eBhB+ApzftejzxC0eBDCzN?=
 =?us-ascii?Q?Xw4OhAvRuniNK1Kvr3yKRWyktxPUDRynft0fMgdDcgKkkquvu+Jp2slFuLzH?=
 =?us-ascii?Q?0r1QMWxhffL7wHqb6ND6FDc7JIAo2UIX14w1JRYG+W7tCL7g/zWO2SdbxTOq?=
 =?us-ascii?Q?EgqdnOBUgkVE/+iEl9ccJAczEuSmZbHIhkt9K9ARZfax1F/hJzAhVJnqJqtE?=
 =?us-ascii?Q?q739tiuac1JBoU5UITz6x6cbGPX+K+n5TmP6JohdgLySYZhAfU9lorlmBSQg?=
 =?us-ascii?Q?1u0LBX5kRlczyIcTIvwL2KOn0ExThl5JfFQrmbcjmXz0AmFTTbLm1Sufo59Y?=
 =?us-ascii?Q?CkvHpWaOX4GHZkSbjF8HmTb7cWQhScmnL0P8qiYTmf3gnSVMSdq6q1zwhvjo?=
 =?us-ascii?Q?OZVWqQRKCqULHbR9qnSi/CYkPSuMTdz5bIW9ZXvyKQCDEE88POLInlIUZlTj?=
 =?us-ascii?Q?j9dPeXa5mObY29zzlePcA59o/RDQ/AEFfdwgSftzF2yFKqQEuV7i8QaeOXyC?=
 =?us-ascii?Q?8UO37kf0MnhCLdmu9P/Eco4B903rZolcg0N8PzIZlq+EEMNxfOjAqHTnTwj6?=
 =?us-ascii?Q?+dBVwKgvFjwF/E1lTuETHWrhiO2nlRIm+++tF4N5k/BDU5WgUci0KNaFI6eH?=
 =?us-ascii?Q?1ZeXHmXdJlZGQUuKdtJcFqkg/angEPI+ecbj/WGq4QSqs5ouqLLNqIUPMH2a?=
 =?us-ascii?Q?hg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	KiY7dBTLhz8zMWX8js21NdqZwl6C7CX7RsB5bst0NAqSdwt1PQVFppz527wnqNW62WAaWDfvGukg87OouY1V/JtlC1v/bBzMxRrGRGxrvjA5L/BpOvyHlriH3JrxZH4Xktixp1KXlvDq3tW9sFVYXu4DZyzSwiUBwygT+oQR7z7hiy61xTx64PfRJLVfn6Z3lkT9EIVW6wVdwKbPAU0SUuZeP6VthxfBU3Kzjoztb1enmIxsu/MGT2V/OZ7SjGwdi2MdrE3HCkSKEKIDB5Q241JLt54V3i9su8npmSjL6o68q4MNYiuU362JqTv80EbElAWgdbVDRIXdvAeY6TcjuLBVGBOqhMDkPlBTKpIa8DMsfpa5AK1wMmHSZFN6HSZPHFy9VcwJCB9Yt47y5tGpN0OEAwR/wTrzEMBOTE4Mz8ogk+BfVmQ2cHc6Ly/K5ALPyCemws4KKh9JQHN9puqVQLDN7Wh0pE+WbFnC9tbo/QwdIQIjTzIpfhBWv4Rl5Qld2BMrU4hReiOm1vEdFNYf7wbA9KpCH6iS4ahirlCpV3hdYEMDUI36J+3Pm4sUhAISVdoWrvb6VGBWBF8P7VoZ6Lh8cakuTABSbTsq3VusZ5c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9256b22-e9a1-428b-e75e-08dd03f39e3e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 14:58:22.5770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qUXnsRbhj+Us3hG3pyHBdwkKxFg/Rva5367pPW+h4L5Zo+aJnwQHhv0fo4kkwhl8HRk2+Ib1O18rmYfVN1mqJCYyprgajrv6vG+6/foKemg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6179
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-13_08,2024-11-13_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411130126
X-Proofpoint-GUID: 243-m_lPyElNozAqhhkuTdJOaGyc5qKt
X-Proofpoint-ORIG-GUID: 243-m_lPyElNozAqhhkuTdJOaGyc5qKt

On Wed, Nov 13, 2024 at 03:45:24PM +0100, Vlastimil Babka wrote:
> On 11/13/24 15:28, Lorenzo Stoakes wrote:
> > On Tue, Nov 12, 2024 at 11:46:32AM -0800, Suren Baghdasaryan wrote:
> >> Back when per-vma locks were introduces, vm_lock was moved out of
> >> vm_area_struct in [1] because of the performance regression caused by
> >> false cacheline sharing. Recent investigation [2] revealed that the
> >> regressions is limited to a rather old Broadwell microarchitecture and
> >> even there it can be mitigated by disabling adjacent cacheline
> >> prefetching, see [3].
> >
> > I don't see a motivating reason as to why we want to do this? We increase
> > memory usage here which is not good, but later lock optimisation mitigates
>
> I'd say we don't normally split logically single structures into multiple
> structures just because they might pack better in multiple slabs vs single
> slab. Because that means more complicated management, extra pointer
> dereferences etc. And if that split away part is a lock, it even complicates
> things further. So the only motivation for doing that split was that it
> appeared to perform better, but that was found to be misleading.
>
> But sure it can be described better, and include the new
> SLAB_TYPESAFE_BY_RCU conversion part as the motivation - that would be
> likely impossible to do with a split away lock.

Right, my point is that there is no justification given here at all, and we
should give one. I understand the provenance of why we split the lock, but
there has to be a motivating reason if everything is working fine right
now.

The SLAB_TYPESAFE_BY_RCU one seems to be the key one, but also something
along the lines of complicated management, concern about ordering of
allocating/freeing things, etc.

Just needs some extra explanation here.

>
> > it, but why wouldn't we just do the lock optimisations and use less memory
> > overall?
>
> If the lock is made much smaller then the packing benefit by split might
> disappear, as is the case here.
>

Yeah, but the lock would be smaller so we'd save space still right?


> >> This patchset moves vm_lock back into vm_area_struct, aligning it at the
> >> cacheline boundary and changing the cache to be cache-aligned as well.
> >> This causes VMA memory consumption to grow from 160 (vm_area_struct) + 40
> >> (vm_lock) bytes to 256 bytes:
> >>
> >>     slabinfo before:
> >>      <name>           ... <objsize> <objperslab> <pagesperslab> : ...
> >>      vma_lock         ...     40  102    1 : ...
> >>      vm_area_struct   ...    160   51    2 : ...
> >
> > Pedantry, but it might be worth mentioning how much this can vary by config.
> >
> > For instance, on my machine:
> >
> > vm_area_struct    125238 138820    184   44
> >
> >>
> >>     slabinfo after moving vm_lock:
> >>      <name>           ... <objsize> <objperslab> <pagesperslab> : ...
> >>      vm_area_struct   ...    256   32    2 : ...
> >>
> >> Aggregate VMA memory consumption per 1000 VMAs grows from 50 to 64 pages,
> >> which is 5.5MB per 100000 VMAs. This memory consumption growth can be
> >> addressed later by optimizing the vm_lock.
> >
> > Yes grabbing this back is of critical importance I'd say! :)
>
> I doubt it's that critical. We'll have to weight that against introducing
> another non-standard locking primitive.

Avoiding unnecessary VMA overhead is important, and a strong part of the
motivation for the guard pages series for instance, so I don't think we
should be unconcerned about unnecessary extra memory usage.

I'm guessing from what you say you're not in favour of the subsequent
'non-standard' locking changes...

>
> > Functionally it looks ok to me but would like to see a stronger
> > justification in the commit msg! :)
> >
> >>
> >> [1] https://lore.kernel.org/all/20230227173632.3292573-34-surenb@google.com/
> >> [2] https://lore.kernel.org/all/ZsQyI%2F087V34JoIt@xsang-OptiPlex-9020/
> >> [3] https://lore.kernel.org/all/CAJuCfpEisU8Lfe96AYJDZ+OM4NoPmnw9bP53cT_kbfP_pR+-2g@mail.gmail.com/
> >>
> >> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> >> ---
> >>  include/linux/mm.h       | 28 +++++++++++++----------
> >>  include/linux/mm_types.h |  6 +++--
> >>  kernel/fork.c            | 49 ++++------------------------------------
> >>  3 files changed, 25 insertions(+), 58 deletions(-)
> >>

