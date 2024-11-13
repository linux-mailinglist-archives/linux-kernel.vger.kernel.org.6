Return-Path: <linux-kernel+bounces-407836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C592D9C7577
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 16:04:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D6AAB213C8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 15:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4B21369A8;
	Wed, 13 Nov 2024 15:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jy5Pxz1Q";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VqcOaKdg"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06B51CF9B
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 15:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731510034; cv=fail; b=bdSPf8JbhoeGNwmEuTYXF8EQ+wrQpeAt5B5V/KSF6is52xadItjgBYlohERMNH+RN9XJcU9cgZMuiP0AY89PbFDmVg1Y4SIjzBae6bdnpYrjNKqo4QJUsg08skeQTv3za/0t+7DWif2dqGavQ7h67Mm/oqfU21kv42u8aidwE8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731510034; c=relaxed/simple;
	bh=OEgHO3SBXEMq4GR454qeQRrvNN5qfBneVy4yw7ECbgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=clOkojQmCyxEsiHB00BXdcHYAAj2rn1UoL3O3Kukucrs61XK9D2DUp2XNncP3oovSkEYDNxz4cabEOSWxvXNOhF3PIHLOKoliK9Qb8vEDAEutkLFai+jypBlDFVdkFrpnOMQ+F1uzRsG7NngwsHxH24hYiWLO6TknjcpYkOwfUo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jy5Pxz1Q; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VqcOaKdg; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADDXXFr010688;
	Wed, 13 Nov 2024 14:59:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=OEgHO3SBXEMq4GR454
	qeQRrvNN5qfBneVy4yw7ECbgA=; b=jy5Pxz1QrgXWLhS0abQt+FKXwDWSZZZh9A
	oN0oifM92ymnhBy6Z79ENlusTBdvuyiuX1POfXFmrIzJIAfhnsWl+xWJNDzkudbw
	DGO794TDh7I6178rQ9FcJ6D1xvWXE+h6OmuxKYOvKLryTPoYNR2j3VOjpNg+he2G
	XvXtt7pQ1AKCMCqK/c+J3qxBy/sdcCKACfAjedc1TkLiBPoGSNwO6/uB2BcxcUI/
	C4f2lIbfU5J4ZMHVtHIOerYzqVhctH+OKcAVJ4D0T8Y/4Qr+flw/SIWMYdQlswT+
	edSErOCB+WTaTBQR6Bt4vJesx0HDZttMBQODS0G5DY5CcnsymVAQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0k5ex5u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Nov 2024 14:59:37 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADEH0a9022816;
	Wed, 13 Nov 2024 14:59:36 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42vuvywsna-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Nov 2024 14:59:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R9NT/reccxXuPCYrTxRBuVwM3bVRqbegApavEFlF+06hO4oEvDseZJDjpi4b1j6k+4Lw5kYjRQwLCFkkUYyE2bWWPdMHygL/fBMufZBHa8M3+285akwYldm86njdrmcihhcsFiR62uJjrtxXqXOvVlaHzrXDlRaKcGU8lWU41YtdjwCR2esCG72m8BOIhrFOauQcZDyd0aUEY2dKMFfEzPeQwmgmGnzLFn+NM86UYs8QXXjrUNV4i0p3joumnuqqpYBDiFkgeGcUKA6/WvdNid7RxRTRzzqW8GnpLQ8M8/SbGDWdrkVvwV71jC8qMM/iGQhmOeb8cHcOATD14pv0qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OEgHO3SBXEMq4GR454qeQRrvNN5qfBneVy4yw7ECbgA=;
 b=Tgk+2GquYhkY0NNsljAvuqTMpgem/bOhiQiG2G4y+ioVQqcknhVg7yLOI7w0AYrbNFCk9PPQk7CpvRJ6b08Ps0lJnbaSL+jQDkyvFTJZsOWCgAJLVeA6LsK0qytIuEtB4pmjrZKkE6DN1usDMetwz42DhbxArAcGGhpSNW4++BOyIaL4qpoXV47cyh4K+E1KFK5IMwt4ZKQxxrpSm/T/A3KCnuw5BKhGQKV0xc5eKFjAiq6xkfJ7CGEWXrhp5ee4Ru982hkRPjDWgiHBxjn1NPKEoGnktodBqG8kf6O76FqaMNQt9B7MScqY9oDkhBYXywMGA5OyytY0Htlh4q5s8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OEgHO3SBXEMq4GR454qeQRrvNN5qfBneVy4yw7ECbgA=;
 b=VqcOaKdg4Y43tDpXhNuTzR8DMihT0iHslvC04ILqb1LY8MO9b+qAygXsYd9s5U/H8K1sPe9km3xNa1V8Nsb4s3Rg1KXSOeSCkgrrIyT6tucyGZd/Wgmp6OA/W3HQ/TxDtIIOyf0J/clY0sX4sKMJOdkK3FGNoIFzLJ/w+N6B8i4=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by PH7PR10MB6179.namprd10.prod.outlook.com (2603:10b6:510:1f1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Wed, 13 Nov
 2024 14:59:33 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8137.027; Wed, 13 Nov 2024
 14:59:33 +0000
Date: Wed, 13 Nov 2024 14:59:30 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
        willy@infradead.org, liam.howlett@oracle.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, oliver.sang@intel.com,
        mgorman@techsingularity.net, david@redhat.com, peterx@redhat.com,
        oleg@redhat.com, dave@stgolabs.net, paulmck@kernel.org,
        brauner@kernel.org, dhowells@redhat.com, hdanton@sina.com,
        hughd@google.com, minchan@google.com, jannh@google.com,
        shakeel.butt@linux.dev, souravpanda@google.com,
        pasha.tatashin@soleen.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v2 2/5] mm: move per-vma lock into vm_area_struct
Message-ID: <b8a8bf77-da29-4fd1-8def-437e23c35601@lucifer.local>
References: <20241112194635.444146-1-surenb@google.com>
 <20241112194635.444146-3-surenb@google.com>
 <637370b8-3e3e-4457-81d6-5913a3ff1d4e@lucifer.local>
 <hcwwxvl4bzyejjtdmrzwvwfyejzi2so2kke2b5yls3z2o67gou@67hxetrsr5ec>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <hcwwxvl4bzyejjtdmrzwvwfyejzi2so2kke2b5yls3z2o67gou@67hxetrsr5ec>
X-ClientProxiedBy: LO4P265CA0121.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c6::9) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|PH7PR10MB6179:EE_
X-MS-Office365-Filtering-Correlation-Id: 449dbf75-8b70-4f53-c983-08dd03f3c86e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Fy0saQkV4KrrvLRnUFP4ikHj1CiiJdXBrFRVA4XZimr3DD81lsQ0qLp9P+T4?=
 =?us-ascii?Q?kcxSx+HHAfbj74l1Jdgaq+Zty+X2NAMdsbKQhLR9LoQ6mdfm0Wa0kN+/6k49?=
 =?us-ascii?Q?s8W4Mb3p2BcRwRm3kqzXDnK37CbPS78tk4/OJDIdvI46LFWU1D9yjaJTnQl8?=
 =?us-ascii?Q?NvhqaTwDQshLujz/sHWTzhqFgncq3otuVI0XMuXT7XTxsZx6Q8sLStdyt+7k?=
 =?us-ascii?Q?0QdRtxpGWb+WFTjVGPOQyS8uKwIVMtRjTUFUciQtkFCwAIxkPdhzjoNTv9uq?=
 =?us-ascii?Q?WARannOnFQUky9gj0Vi61+rSSXCh35hxiuWuxn8fGiMLeS5AgrRhsinWOqaG?=
 =?us-ascii?Q?a58B3CjY8h2d8ias4+PFVbaWU8Ci1hpYGJDOY197c95N+Ch5qqLKD15p0fJZ?=
 =?us-ascii?Q?nmno22Kbd41w8AxxZ55w2nEAS+n6a9KR0yrBeJEieyHx3qPmWo07XGSzVuaO?=
 =?us-ascii?Q?JDOfLBO8DUHKKxx6FUSH3ub/9Vfkz+CP+NZYsYRPqfk0ChPvQJ7PZEH3qJ3O?=
 =?us-ascii?Q?GH40Q5mjdpLxCFMp7HQYM4v5SWJiLRVwhprbigbNHKcj0Dk9Iz15O/JbjxLK?=
 =?us-ascii?Q?82TUawrlW02B7GHSgj+rPCLDyV0YVfNfmbSfNUGbaOowmdHSVlH1ttQntsqU?=
 =?us-ascii?Q?nUE5BKuKO3GlvY4K4kSyPzYW6ai184+UymgTFQmuwHQhvhADivCBAmP+4Jkl?=
 =?us-ascii?Q?cq/9JeEJH0O5koCACfqaZYlrSQ5gLsZ+nm3JRm1p0S8DvkDLFQzN3yKVh8yf?=
 =?us-ascii?Q?k/Wp7Cyo9zzJACmu/Exlkh4XmLAfrYB3ngy4poBSG/Jwkr1ZA3PZRRPkvrXf?=
 =?us-ascii?Q?CzW+UP7cpHO0bnGoqyFodicYbXh2suV9qZyWPNmjrdwC2iUTeG/FDVIjw6jx?=
 =?us-ascii?Q?CgAryKNueK9f1zH1E/+fskUzzA8DuaXhW+4VzNDORqT4T1SbnvTnCoWASxXE?=
 =?us-ascii?Q?bfF4cfnHdC9Q9M+CS2loW4ITe8RmvnpDr+kHI/S43F1iDzJsAVP6/JkGJcuc?=
 =?us-ascii?Q?u2EKS3a9fqPV5WjXcvyW0J39B6X4w2MJeCZ3NKJ4DA71F/ww9SNxqn0TjpZK?=
 =?us-ascii?Q?Yk7ncVd9ulhyLqTSeRMBB2uuPPHjYoI1Z8nLkhLQ/i9r4Xk/aBKDtD65fbNw?=
 =?us-ascii?Q?+MFF0BtSOS6Ue9/PAIq1JoDM/k/Eg/NM68NhG+o26d3o1anKyFCI1VqhRIi3?=
 =?us-ascii?Q?MF5BDTaGPXvMNy6XbBVm6RwiorTGLBkd6TSkWL+SoZapqR7GWzDKl0CPWnhU?=
 =?us-ascii?Q?gQwqmpKWeOfjGBGu9seHSLleu+hBAQUE91OIW6CZWYcoFHD1hPuCF6/9yDSP?=
 =?us-ascii?Q?UU0CcB7JrxHWJNxoGZXSnmKK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Mi1Ow91ZrLJLo/4KrvBZIJBDjbeIMwpJXQGKJtNd7WqSUQAH71P5jkVHprfr?=
 =?us-ascii?Q?cPiwgfmWiHh49jQ0rNI8TGi1+svoxrFJB/LmV7n5WrKUpwWQtwNJNBkXqe8s?=
 =?us-ascii?Q?xB2MMBorfx5UOsJVdhXbW0OUWeLCrfvV3c1g85tvH6dGRAyQX+7iI4KIrGrR?=
 =?us-ascii?Q?9Ukft+9+4jwqD4Ih8onYexcwUswuc1SCldxxlTlMgpHjTIw06Qwb4I/V1Lio?=
 =?us-ascii?Q?pvKkarj7CzBC7TdFTQgNa4YeN2nwo+qhX9J2MIzsss5wiwUSL/66tzvyJDFS?=
 =?us-ascii?Q?pTMwNEdYoBj8db3ElsbGqzaxN6S/8kIL4vXACN3VmVqpIeJveEPHASSZoekx?=
 =?us-ascii?Q?aVI4zSDgVex0woqezygifEsqCfgHeJ9IzLJfVY2hPlJf9zQDItc6g8L+lPh8?=
 =?us-ascii?Q?sO71EItvrhUopdWq52XwTbaNp5OKHbrqAr/FWm++nF4JVuZs4edYmQ4HdyrH?=
 =?us-ascii?Q?ueS6mpuHrwKHqzrMbcq6+erIY0JrvZ+T4/NU1gpJUAzYGNy/97RIcrPz1Kbs?=
 =?us-ascii?Q?7663EO4wg9oPKuBEbIo7w7PCnkkRKu097Rp0y9DrRbZ6Bxb0vzoKGN569U0m?=
 =?us-ascii?Q?VcRjQ3SMtOmsd6qWaOi5mFVKCz/ZCGD1WwnoD1WbDzMDZL19/p8Dazrs9Wvy?=
 =?us-ascii?Q?d7EXbcqRDF8YSP7LvVuuTg53Jfoel342ndMEUNEwhNNk417qgPQ/59rzzPTb?=
 =?us-ascii?Q?lJ9lQPCRqwHd1GKCdymM0ISUuWEf9XLwx3PIXJKPS7vMFHaJagyTYEyG+O3g?=
 =?us-ascii?Q?XHyY2gGoMwC20IhdXPRKB5k772K4+nPWsJCZ/H6pk7nMN3KIZXDFe8bme7RN?=
 =?us-ascii?Q?DvFccoTzD7Djrcp1jkezOLH62ZRaTgEM6E2OcZ3N89kDfzJQLP2ftn0evwS8?=
 =?us-ascii?Q?W3O2vBmxCFzSnmfXVbZVNv1/IkpHe6th7F258qoHGsdKYUFn3ODOF/fMYIEX?=
 =?us-ascii?Q?bfa/HpMxxT9MYtM1MwkIoUAv/1/OkfGLJPy0MUXqiGZxLfHCuq47u1ouTEaA?=
 =?us-ascii?Q?f6YQMR/zQjV2IxUn/g4hm57YWNyjt9aBNjYJS/5Far/UQ17+NgaEw4pBdl07?=
 =?us-ascii?Q?5HS42LfSxGRmZ8hho3akMydtJ+Qe/43W+jkbreaT2Xsev+IxeoB7wxMpowVJ?=
 =?us-ascii?Q?S2sJYoBPdUbW/YDcTIenq+mzUcz5T//UlSHy6ujCDbKrfVohEfQAKOzxyejn?=
 =?us-ascii?Q?zq1jp6pVK4qBF4HyzYhNrBVRsA1FhOaAu8Pzvyk1utSpk6fidPT4w2dafr+z?=
 =?us-ascii?Q?+n1UnqVQ3rTWXUABNPDkxXo3J1uZWfrLFx+XmFFptdvLvNgI1+eOb5OVB3r4?=
 =?us-ascii?Q?pmcFDwho01aGQpbo9oB0UVTcdScxlcBiuxhZQ7LY1BdQeLjQRaKybOP5qKl5?=
 =?us-ascii?Q?4JkfeYC93X4xDZqhBrWT3Ae0ywkmHCVhe/oTifLKna3B120uNtZ+/7HGtykV?=
 =?us-ascii?Q?toM5ZMfBTplOfxIFbjWu5/Cf7P1S8BnqsPqIZL8TMjz/BE7GmYC5fQvcg0Rx?=
 =?us-ascii?Q?GhXup1+qs6iu/rvNveY2zYDBJZeyvxZMFXuz9JcMGZ4uqTWo/XgwS+VX91ea?=
 =?us-ascii?Q?PM+z4mv2hDRrA3KpehZW4Ph1b07YFBU/djsLR9FcsD0CEzTiGDW09h67MF65?=
 =?us-ascii?Q?YQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	oP4EfHFfBpGPF9jRS17/GZQ+I0wRQi952TvO9KKb+18sfuCih4lCxr52HOSHz5jb4Pzm0hMzHviG8L6PvS+AHJ1SDHoAIaMGYk1C0PzI5CvL4Tw9zIcAtfPlOAVVCzDmpq0Ig+oKsmllSpgaRNCrXORIvZ/k3JG7YjrBCGtiTHY0/Wkaei2l06nC9CFDiCIMfuHYR1IjU0bSWBv0GproEQQo7QWymjnLHDc+jYHbpEBQUEoGw3jBN3jRoc7cy0Hf6B0zA5b908Mn23OKJtLgFsD/Nt8opSBESo93XxYndlXw0QXo+vJyPjisZXf8ZUq1JrTwZ8dGz0A3uK9UvI+OlxALNGJirfffhxIKtO8Hbz15cykzGRnXYjjN+Dst5UmmIbL4jvUvINiJBdEzLgty4kvRv2rL42XMjUjzLUBoY60OA/ODFdU7vhI+x2l8qhb0QuHcOi3daSqWBnATlx18cgKHguhd5qcjO9mq5cBu8a3MKE50rn6PRLmuYGqowGTeZOt4fl7kQrIyVeo2+rihbxLJ4M/0UlrjCZrj63k4SA2vLSR0R/aSyQrAJ+UVBkK3GLge9ddoX4FDGjSI2CSJ1REVMghYBI73HtO5voDl+uI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 449dbf75-8b70-4f53-c983-08dd03f3c86e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 14:59:33.2060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zeWgJQAJuVAvRR1CiFIOnzswyY76YjeNAIp4yltU0Sy0GmCtl+uzlY9iXvGpCyfvuB2c1PAzq5VvYnIj2o7ImG7eq4iNoFgT8TzDyEajnD8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6179
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-13_08,2024-11-13_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411130126
X-Proofpoint-ORIG-GUID: mUhGUSI3h7XEGeTswSl1tXqCaECUB7Fu
X-Proofpoint-GUID: mUhGUSI3h7XEGeTswSl1tXqCaECUB7Fu

On Wed, Nov 13, 2024 at 03:53:54PM +0100, Mateusz Guzik wrote:
> On Wed, Nov 13, 2024 at 02:28:16PM +0000, Lorenzo Stoakes wrote:
> > On Tue, Nov 12, 2024 at 11:46:32AM -0800, Suren Baghdasaryan wrote:
> > > Back when per-vma locks were introduces, vm_lock was moved out of
> > > vm_area_struct in [1] because of the performance regression caused by
> > > false cacheline sharing. Recent investigation [2] revealed that the
> > > regressions is limited to a rather old Broadwell microarchitecture and
> > > even there it can be mitigated by disabling adjacent cacheline
> > > prefetching, see [3].
> >
> > I don't see a motivating reason as to why we want to do this? We increase
> > memory usage here which is not good, but later lock optimisation mitigates
> > it, but why wouldn't we just do the lock optimisations and use less memory
> > overall?
> >
>
> Where would you put the lock in that case though?
>
> With the patchset it sticks with the affected vma, so no false-sharing
> woes concerning other instances of the same struct.
>
> If you make them separately allocated and packed, they false-share
> between different vmas using them (in fact this is currently happening).
> If you make sure to pad them, that's 64 bytes per obj, majority of which
> is empty space.

'I don't see a motivating reason' = I don't see it in the commit message.

I'm saying put motivating reasons, like the above, in the commit message.

