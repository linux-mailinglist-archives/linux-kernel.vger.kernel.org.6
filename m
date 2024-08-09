Return-Path: <linux-kernel+bounces-280728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BBE294CE10
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 12:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FB2C1C221E6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 10:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33CF51922D0;
	Fri,  9 Aug 2024 09:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iMCJ2LmU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="phby3Kyi"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C14E191F80
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 09:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723197472; cv=fail; b=EKV2/wLh09PU53K4IffzmS5eaNqfm6W81D88MSHB5Nrc0p0HC9IvHDsyPo/K+o7a0ow64xXYStDVtVquMs8drJ7ff+BXniQ5YX9b6AU2kwVA543peu8yh4aNcB4c5LUghpefjK1DnW+vh+yS4jx4C6g9qutMixdu/jwnrqgyB4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723197472; c=relaxed/simple;
	bh=ODNESSVO9RHWU8TRB9kgmHPQoplhX9+qgXg0+Crwdos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rdkwGX8209e2/4Xvms7LphjRJBvBPOlASK1JFrdMZ7mgEMuG6qyPcma5fsV6X+lOh6HRqiYJlK4KlS+8zyzzXSib1jhL7Apgh/k7+okZRFkwKOichjtn3tmKpWL3B0yzz7FcM75nWuTsDNhjTZabe/TrHK5/rmNbDp1ttkIr6Pc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iMCJ2LmU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=phby3Kyi; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4798fVUP004785;
	Fri, 9 Aug 2024 09:57:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=VJ1FRl5F4JZcYV9
	uSDC7OUa4VJ39aA/pJ9o2J+/QGX8=; b=iMCJ2LmURgpq5puoNKUOSj/kUMcmXaj
	bMPfuzvIJZwRnrZw13HA+v0MIzJ/Q/b/RpJF/wAKRNe0AkEcY/ElW87X7u81ZDGx
	DdTh5ySApJHum2TQeyODlLtfBF8P//jAPbAswJzu5p/TwKyTV4P0Mk97G0GLqaEd
	2bm7fokUgRrvMhd1N1Vl1h4Jz3/cTHhirnQsi/IcV4lVvXLF04i0bvjKIvNEItnJ
	Jd3WPFL09asknsS7/n1X6bu3s7KUvme3s7D9KSy/i99sd1vEEBJ3IIOEO+PS4VTH
	8wumyBMQkw7isYNmhbbwdYze2QINCFy87H8lDZvv1yrvePew25//fSw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40sb51kq46-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Aug 2024 09:57:33 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4797MX0Z021869;
	Fri, 9 Aug 2024 09:57:32 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2044.outbound.protection.outlook.com [104.47.74.44])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40sb0jq9q2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Aug 2024 09:57:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uVXroT9TA2VE4/acNFYFS3kKq9Hn1WkOyCDq/pJ80XYIk6IrAoWCRtPhGSe8fzewJnWn54O/9PsqJ3N0Up3H60vdv1II6lKGNQXR4wVwbQk0e5jCMA3xu8bBXFd9NZ3RGXEx2PeAUOPSM6KLvW8dV+no8tvtH4ZH19+NzjvhXP1vrPRgksoZot8Z2BsH+N0SwFft0h1d6rTUGM52CpuL6RfPaelr9Syhn7qnqneOJeiHHULHrDat61HoJQiU+5Zk+NKDgwyyCmn3e5D+cD18nk1wLMo8BcWdMxeKPnFlY79CvMESOxVpcBQhbtBsM0In+FwN7HC9C1aNJg9rTc1NLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VJ1FRl5F4JZcYV9uSDC7OUa4VJ39aA/pJ9o2J+/QGX8=;
 b=lB6DOOl4maeO7w4UfcFFxxwA/1ManJX47c6qLuT8Cecy9mqRhEwoZVBuku4pzcLAdQwzIgc85rvcZuctofbXQz+QchFtapAXqmWT2GC4TUmb5dHpn1XBuuQDZcYD9FEE36LoPc/y1YVaM6TCK0O5vVoMKJn2XTo7te2CIEnE9v12l6tTgpPvvkGwp93woxA2QpWtOZxjZJ51Tj1T8a2P+q7gXkq+LR+SzMez7a2yzSJcFiZZXtIILbgAHt7MIpmeU7eZ/bXk7setstF/OK9Z5D0bubP98nwVlH4b/qrMpPj1OqO7GkunnrHf7l9pJnjaoA8aIfquSZiPXRj2xIfojg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VJ1FRl5F4JZcYV9uSDC7OUa4VJ39aA/pJ9o2J+/QGX8=;
 b=phby3KyipOGvUtRiDeaL9Jsk9IuN1M+L4LBWKnqe+eDYTTnhXoZ7YlstoKjLopyBAu6r8jJxtSpsOR5XwuU4dKgR6bv8APjWRBPyh3dWFY3o9SqtNDzVqUqMs3PoRg/D1riR6jFS4MsxW+ChWa5D/A4wvDPjyRanqmAnIPCMxac=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by CO1PR10MB4705.namprd10.prod.outlook.com (2603:10b6:303:96::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.24; Fri, 9 Aug
 2024 09:57:30 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7828.023; Fri, 9 Aug 2024
 09:57:30 +0000
Date: Fri, 9 Aug 2024 10:57:25 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Pedro Falcato <pedro.falcato@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, oliver.sang@intel.com,
        torvalds@linux-foundation.org, jeffxu@google.com,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v2 1/6] mm: Move can_modify_vma to mm/internal.h
Message-ID: <8833a9f9-b85c-4a0b-b8c8-ec7f8468aa49@lucifer.local>
References: <20240807211309.2729719-1-pedro.falcato@gmail.com>
 <20240807211309.2729719-2-pedro.falcato@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807211309.2729719-2-pedro.falcato@gmail.com>
X-ClientProxiedBy: LO2P265CA0062.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::26) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|CO1PR10MB4705:EE_
X-MS-Office365-Filtering-Correlation-Id: 09af5c1e-2b55-43da-cccb-08dcb859aea6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RFfx51aV+C4EYm8iEEGsRvpAF2Kb7K8rhEvaJX/P7WaUwBxYucpieIx3HpyM?=
 =?us-ascii?Q?OkVDmJhVj9diuBDWmxsC3kDfQI9spmbZeU6pEyR31aA3XdrME6e3u/yh2Pgg?=
 =?us-ascii?Q?MdlwFiXfVMy6fobw6N6iY2LzqHAAW/vP/gqdhJxHGgwRvvmpM43QDJFKAb7c?=
 =?us-ascii?Q?xwRoAQejgvIzqb2ipEU52KFHGSNc0PB8so6J5grE04jBriWpONz5xkPgLA2D?=
 =?us-ascii?Q?qXRKNdZT3UfawtByubzRZQjJ9oI+b+NL27Nx+ynGThodmXhkmdsK16G7wx0l?=
 =?us-ascii?Q?xzKP3Td0ewOI3oIhB0HVnvv0sIafpPlJeuzEXrkX3cp/5pYMKKpJU0xNMkPE?=
 =?us-ascii?Q?vTV5Ta68yRIpRHKHAo9AQYSL4Pm3cx+i0j2EC4ytVyjkIQ7rDW3yeBPXhSJH?=
 =?us-ascii?Q?Q26pC7NOJEXhYmpDqQ+uXjLHnQYEwZfY57AoFTgI6dDzX07TVNdkJ8UE/ILt?=
 =?us-ascii?Q?Q1sIi2W7OcfLoFhXjTReoXtukc9rqRlHMz/XQh32wQ1L4O6A8qFL5lDgAEe7?=
 =?us-ascii?Q?mdzdpkMqJaUStGrYGkIss/ZgOfn7A5ikfpFn2CGjoQxuW85Y+/Rla9GLBzVD?=
 =?us-ascii?Q?X2H7PqWFGxRM8qK28JAcwXVDtnURIs5OeTeBe9eMoNFHhyAT/ZVnq3dY73CT?=
 =?us-ascii?Q?oB+bznxm4f4saFpd5isaVKb3M9zLDGY7AEzLucJKWh2oG4WMxHLvEx+c1sts?=
 =?us-ascii?Q?jmhU8GiRIo7fnZ6Lqbr+bUC8Lmm5k2lwotIjDUgFNqeSj3RxYY3faiYW5kCj?=
 =?us-ascii?Q?8mdtqier67YuMUo27UA9Uf3tNA+rJey25CeakpBmHkmaJoavoqtrXpWdL3gi?=
 =?us-ascii?Q?YmVcIIkOE5+8zgbGPqbkMwWkfftq4ddtL+8HBvE05Me2jmakXE630fyiGb7X?=
 =?us-ascii?Q?LgZg2hNrEc9Y/Bs4qHdPimy8Sdi8owJW/8wvlBRBxMJeeI5n60PmYYv+H4pv?=
 =?us-ascii?Q?MoQ0dso2mB8VtaZtdkM53ibFogpcX5mSTBWJllqvcsXG6Xn8u3/zog3oyDBe?=
 =?us-ascii?Q?QA4tmWXUMsx75405QNvqLeIRGMM8xHE5/8Gm2PdhoUtC6QaF2IhqvAWiBAnD?=
 =?us-ascii?Q?ENiPMwFDlvDtlljSmCYljUZEW94BtX/ho9SQJtOZS7oipJzYRe6dJTPBXG+x?=
 =?us-ascii?Q?MeCaSEHajrhtQnsSOjomC1JDsnAExKCYZ3yvryfovFu8g9sP+yi0zU3uRaG3?=
 =?us-ascii?Q?b+Gq0XkXhwF2UEbJuJrsZjQMfHBGSZ4I6+Yvq9yaDgNLf8EfE4+azoDLzRgO?=
 =?us-ascii?Q?3bDw+4sP2Dd9urAJaeBLFU5dnARXmkwGNsFETn9PGEudfGQEpsIbk2m8EWUX?=
 =?us-ascii?Q?zBCN7hBSpRNr08Gj59Jc5omb6NTnG6p9mck1JtagpWKgpg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?h6YP0RtVfkkHt3UFzgmkMbAzBas4F+WFVbldEvGqJh/0k9amHp1uGwUailds?=
 =?us-ascii?Q?q0TRgzvPz1a3EEPcFmcDm79PnmW63LTwwNd056q7JZKprNB+8w4NSr34ojdx?=
 =?us-ascii?Q?P/x5T3B/RmMzqSgLtxJeG8wEvOHbTSsr5RI8vT7XWd1xqv/wXtjRuBRI7Flv?=
 =?us-ascii?Q?I60ySB2iaVoqh+NJCsnxqGuVlmAHV2gZOe1W19MuzxTwhoNl67kWNLS0SDMa?=
 =?us-ascii?Q?UbEAYng9nOYanY04fQZ1bWNTicX0bo92jw7yekVvuPld8+HWbCkXcRaMdgth?=
 =?us-ascii?Q?xrtUrpcTP0cdudQ8plrnu9/g+/dwBnUg79sjxXJFVdBCO4js5JyYnkGmH8m/?=
 =?us-ascii?Q?9R8M4Qt2Iau/cjEMpVVjdhiut09iVsLagxJS3QN8LVJNVr0gLJ9YGT2K4V3+?=
 =?us-ascii?Q?2caHweGLE67wqRduj/kzafNDLqJpM/OGoPThGBFvZPwGGbIBV4O76dJP+kRe?=
 =?us-ascii?Q?htZxmUA46Mgmd0lcm2mzWSOl9ABjSSSf267FWOUCvFMXSRV2lQHHs7BHp03P?=
 =?us-ascii?Q?iK0EyzR3crk6LRL8XI+awQ0VpRq3ft3pb7Ki9HFJFpyRGCFIDaCoYrRGBQ6y?=
 =?us-ascii?Q?EeuJXS+CqDEpI6bJyhRooLFyHNuP4L1EA5zoXBHJP07hyg4Xce3ecLDE5ypW?=
 =?us-ascii?Q?bkb2dL1LtrQsGRo0fBwOl4KBXqIvIXqPilhZP+gC7U+bLLZlIQ6mOqhOi03M?=
 =?us-ascii?Q?/s55I36RwtyAqrv+FnkfgQv5yH+BcZUO9W7zrNeeqW5eV4o4VMw7ZW01AfDo?=
 =?us-ascii?Q?1v6dL19cNTNVszIOkNei9MoTFYzD9uWgJ0oEUDDRBGV24nkBXCsDoRO8gmQx?=
 =?us-ascii?Q?20zLTZBVOgSlv1RXIa7rvBHxN/3QvnlxcqYElMOhLMzfzlPRVSbh5eE4ZB97?=
 =?us-ascii?Q?mSY93nufhiisldWkyY4K8iXGcyL/2b0mrq873P5FtnrNvoM4NMHa7ON69OLV?=
 =?us-ascii?Q?zBYUG2kEeeiFIPnI8Dzp+ltwkhqGu1aI8O6+LyukPhAW+D/A/FlBVZ4blOzK?=
 =?us-ascii?Q?lcqQkkwk7JntThaQYHaexEk86kaCiR6/Y/f2nfzj0Yqxu+WulsrdBAR0pTOn?=
 =?us-ascii?Q?bUEnIuENYYsmOy0u/w/jp92id+8eWP+fm+3KZbaxnESH9NyQEn+I0fhek80n?=
 =?us-ascii?Q?ngHltzSLRQmuzbKseeoSt1ru7znNxiChAIc76EooAdqMAxp2H+eohx0Exl2x?=
 =?us-ascii?Q?U2sPAXU13pinIEHTOL9aTl+b1Qggp/Xm8vnbcCgugJsMRa0eeuI6nKynaJ18?=
 =?us-ascii?Q?wtre2xCzto6V0Ns74hXKeP6g0DtybXa31hY0mxLqWJECjgaKFJF9UN3IGvUP?=
 =?us-ascii?Q?xCtDzqqc0AsHCB5Xc7rc/HbukUF/bks5oUX+qbtDGAWoHhGDYaOqYjhN5osj?=
 =?us-ascii?Q?KrFIFoMLXY312c1LPxmYIpg2HTUF4P7SIdRcS4OWi+sgUaVFDaWuR+3vWeGT?=
 =?us-ascii?Q?wwHO6DYOeK7cZ3Vf3uWk6h6b+vFgq9IXJk+kfPABA69jIYV5kWwNXxPbbm3u?=
 =?us-ascii?Q?XTIbkZ98CtWEuSFa9sZ4S0R3l3YUsubwj2tyU1eT7dWeFcdX+zN/QNDP2ILg?=
 =?us-ascii?Q?d9R2ts5kM+z+nHc05/k3Cw8dSgl1u8kAt1cIo+iB7jJDkmieJSF0FvYFGAGf?=
 =?us-ascii?Q?02CznaqtRYd573tQm8C01vC38oLyaVKJ6BlTivekqy39sHELmT7rOAi+g9/f?=
 =?us-ascii?Q?SdayWw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Tv+446Sx+65Y4+Iwr3XWke/HMoml03Hsb0TFewXyYYvw0JRRn+lkhsm8Dj0VGEhYk6fmvzESvfOsdEPDO+oYLVPEk/oy3R5PNL2fhBUtJtJPW6XDNYOvavaOwdGS8UKQFNKLUeOJ8jOWQ+xiRi1aQ27a/OhI5wgpsY9lC36YpPLGv9UYlbX4fzLWM4s0yfAhs4bN/8enuh9xFSax3STI1Lr/8hjKrL73BLmWAl9srPGawr8bsR724WVXopdzGELhiM4AgNHihvPJnAwWPJULVgkPZdMqjDThCUO6QvTOFz+kmwbmMpdY8JxKrD/y30tviBX5X8eNH+faam2wwZqalW5aAsl0ySLvGVSXBxyV24NKSMWetHBQBDvwvVdIJOHs9kWDydH8VH2TvcYnHCgCEB+PWDtlCBftlb+2PKjsa0MypZlE+c4kue6RURSx258pTKdkvQaJMFFiHZ/1OlVVzbd2BS3X4PNAF1kpJ6iMi0jM4pA3rV9rdNJcqmXKTR/bYw8ScouIwsQrAxizy0+inlWhtPGU/7mqhiPkaSh/t1Cw/Z08Y+ToPc9ZHQYTtiWVpCCyYqjG/5wORx3WL9k4/B51jP9uSC5eKBgY9VGTXMM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09af5c1e-2b55-43da-cccb-08dcb859aea6
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 09:57:30.3950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aFihhmqTzpruskCv09M9UbANE1MR78rh+jOeZQOUboz5UedOyyHfPG4v0lrUmWNtffkOMgscXvOFPOaQ0gjac465bx139+rMUXhfOS977BI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4705
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-09_06,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 adultscore=0
 phishscore=0 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408090073
X-Proofpoint-ORIG-GUID: jdV35OFACIt-duy3G9QkqHt8WZxsnwl7
X-Proofpoint-GUID: jdV35OFACIt-duy3G9QkqHt8WZxsnwl7

On Wed, Aug 07, 2024 at 10:13:04PM GMT, Pedro Falcato wrote:
> Move can_modify_vma to internal.h so it can be inlined properly (with
> the intent to remove can_modify_mm callsites).

This is kind of petty, but it'd be nice to move this to mm/vma.h instead as it's
a vma-specific thing.

This also makes it testable under vma userland tests.

>
> Signed-off-by: Pedro Falcato <pedro.falcato@gmail.com>
> ---
>  mm/internal.h | 24 ++++++++++++++++++++++++
>  mm/mseal.c    | 17 -----------------
>  2 files changed, 24 insertions(+), 17 deletions(-)
>
> diff --git a/mm/internal.h b/mm/internal.h
> index 52f7fc4e8ac..90f50f3c4cf 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -1353,6 +1353,24 @@ static inline int can_do_mseal(unsigned long flags)
>  	return 0;
>  }
>
> +static inline bool vma_is_sealed(struct vm_area_struct *vma)
> +{
> +	return (vma->vm_flags & VM_SEALED);
> +}
> +
> +/*
> + * check if a vma is sealed for modification.
> + * return true, if modification is allowed.
> + */
> +static inline bool can_modify_vma(struct vm_area_struct *vma)
> +{
> +	if (unlikely(vma_is_sealed(vma)))
> +		return false;
> +
> +	return true;
> +}
> +
> +
>  bool can_modify_mm(struct mm_struct *mm, unsigned long start,
>  		unsigned long end);
>  bool can_modify_mm_madv(struct mm_struct *mm, unsigned long start,
> @@ -1374,6 +1392,12 @@ static inline bool can_modify_mm_madv(struct mm_struct *mm, unsigned long start,
>  {
>  	return true;
>  }
> +
> +static inline bool can_modify_vma(struct vm_area_struct *vma)
> +{
> +	return true;
> +}
> +
>  #endif
>
>  #ifdef CONFIG_SHRINKER_DEBUG
> diff --git a/mm/mseal.c b/mm/mseal.c
> index bf783bba8ed..4591ae8d29c 100644
> --- a/mm/mseal.c
> +++ b/mm/mseal.c
> @@ -16,28 +16,11 @@
>  #include <linux/sched.h>
>  #include "internal.h"
>
> -static inline bool vma_is_sealed(struct vm_area_struct *vma)
> -{
> -	return (vma->vm_flags & VM_SEALED);
> -}
> -
>  static inline void set_vma_sealed(struct vm_area_struct *vma)
>  {
>  	vm_flags_set(vma, VM_SEALED);
>  }
>
> -/*
> - * check if a vma is sealed for modification.
> - * return true, if modification is allowed.
> - */
> -static bool can_modify_vma(struct vm_area_struct *vma)
> -{
> -	if (unlikely(vma_is_sealed(vma)))
> -		return false;
> -
> -	return true;
> -}
> -
>  static bool is_madv_discard(int behavior)
>  {
>  	return	behavior &
> --
> 2.46.0
>

