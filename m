Return-Path: <linux-kernel+bounces-357798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF254997637
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 22:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20F6E1C21595
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 20:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3401840849;
	Wed,  9 Oct 2024 20:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="h3pvflf4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sQXTUSfj"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B1D1E0E15
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 20:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728504656; cv=fail; b=CjpwMjQV0lkh4nc97bY0AkB7lwI5hzPWjnqK9BVMTdm0U1Pop2gIKhH9eRmbKp5Yxkt0KgOgph2CV1IP2yg5Fn7e+AtvYBSRMzkUlMYHq/ES8J9tHEymF6+WBBrr2WWbBKaVK5ykIq6poTCiIMMIlckw2BE51tXcnwesko9iE0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728504656; c=relaxed/simple;
	bh=b5isig4RT8Gg//gybn9CORDhE5X/cTUdo3/QDj1hurQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=H1eCWtbW15J7D+K7bXA/atsbtTQiiZ+UWqR8RPvPgYTefrC0EbB6aswnwTZcWNve5ZhD6/rhTXn8hDLdxGN6M/bYogQNSUgsrhTklS3gQeLLuzNbtcmrtl82MKliC2gU6i6shKzTHw/+4JqLgnEdfqaE9z/nmnSMgnRoUGbciMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=h3pvflf4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sQXTUSfj; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 499IIdCc015148;
	Wed, 9 Oct 2024 20:10:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=nMCyywOP32NlC9mo
	DsOHpQVRSYscamXYbIRYyWflkno=; b=h3pvflf4WTuhbrBbiWqoOf5BAlDXfbNE
	+d/CNngSsiWtX55uORPT/01sgOkkRt814bbLxAbV0ka6GmgBUrL6BUyZ/dEGEgU+
	nh4n+lYL0GU7Zk5uL01V+wVGsfVDXCdCdCp3jNYZ9RAkrGVHNgsBcbW6tq+YZV9R
	YTlt7a1awznUEKmy/fnh4iF6EdW+9eIyZgCFAbEXFnBBa0i2ozDMltIcw0OJ25rl
	aW+pm865qJMZ6WP6ltdRKQM0NxJ9bLAaIJ5tyHb1VFcX65raVFhmBrQ3TRwVhTXx
	XkdmQJ+lxR9Zpuowxee1ppC+aQXcqiqV/5fMsiIM6qw2+7vvwIH5vg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42302ph55x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Oct 2024 20:10:40 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 499Ir1ga019066;
	Wed, 9 Oct 2024 20:10:38 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 422uwfeaht-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Oct 2024 20:10:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r2Ky7BvIuW3mbliUG0Gb37U1oXOsW3DENGxMCSZgVK01W25dsqHBDFhSXnGGnrhmpND3WLXQFalmoyhA78KnBl3zioOoU5vje0qJcqDwhVZVSZ4o4E5DoC5zQtB6ST403H/u51iyStl4EblmS6mJ1lkBbygfW8PFTvhcGDhTBddpB15WSJZ4Vsq7h9pjjpy3UOH2W6H5/YhCxp9EZi88lLwxZp47V5RtevfA/G+tDh7+302FDI78gx/EmGYEaPBQfWY2/AJdJx673GrIKHR8K5h0t8DSS+N7sLoX40jdo0+FeX/6AC4abLSHiEg/iD/uj+k9xyehqzcue2G4poX35Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nMCyywOP32NlC9moDsOHpQVRSYscamXYbIRYyWflkno=;
 b=xA32VNFRtw4NSB8O7Fvl9JRKAEqTM95illivgsyaA5iRMDRSEdYDXt83MB69TzBVqjcpOtJw6a3tN+KAXs4UBV3U1IBgXVkXOZeTfZxAC8/+QwruUl9TIxsv1/MmLOoPVk6UW79Sv0QJ6vPX9Y4KljNJ2OX3AHN095EuEFH7KoBQEF127opl5F5MYinf1ZWz2IbN0Ktunb4FwVY8B24oqU+F+o0qlIlaqooXGZ8yhcKR/lVCNEfvwvxcVIT6e5bXWZxBilqjUbLBrrC6D4AGlKh6HgNTpnHIUBXfSUwpVyM7rV7vmmDfGzzxmS0gkRPt+VSJIR8/x9mpXzAhGMAUDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nMCyywOP32NlC9moDsOHpQVRSYscamXYbIRYyWflkno=;
 b=sQXTUSfjdU+sGtr/1nrRopRwBd/eSobyDRz57AItEGAMJe6xGEg/AfhyEr6taWXnKWxhwtiPW/Jj6Y2V/lY4/l/25Abr/ms2HwuymorxkHj9KW+7RbV8kSQl4K+k/pbCl34lX0G1jhbyzGPDaayfCnAsh3c/RXnCMkTxmBBSz9M=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by DS0PR10MB6896.namprd10.prod.outlook.com (2603:10b6:8:134::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Wed, 9 Oct
 2024 20:10:36 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8026.020; Wed, 9 Oct 2024
 20:10:36 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Add memory mapping/VMA co-maintainers
Date: Wed,  9 Oct 2024 21:10:32 +0100
Message-ID: <20241009201032.6130-1-lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.46.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P302CA0033.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:317::8) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|DS0PR10MB6896:EE_
X-MS-Office365-Filtering-Correlation-Id: 11109551-fb34-4547-4029-08dce89e7031
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zqf8ZfNqFVykPY6eYA/KT9lmn1np8wVg/F8qXQhFzSCBckeL4q+aSPD0bkdR?=
 =?us-ascii?Q?PixU44M3nCek3sOM2jPo85SWK3ZEm0EZQ8Ry3G5XFCVDgsHRFvXlFR7ktVKI?=
 =?us-ascii?Q?EVG2KRRIV2RnFs/OvOh85Df5BElwitUHvOz34cIYB7tHCrMtjmEUeEDdDK8G?=
 =?us-ascii?Q?G3K8ZhseJIhWNfZpI0rXK1EbuVGDAVwfpVme4K/i7tSVXbHlfrBr6ak8kVe1?=
 =?us-ascii?Q?1qkdvk/TfP3ITLohwqc2T458QQ51Lh+na9yu/W5pEniAzq7eRoh1Jxi4/x1r?=
 =?us-ascii?Q?yLSvm1yNioAbL5tPTrB2TxHjsPNMo2+7QBVYtz61ij5jlhIWeq7tUGt4R4Zv?=
 =?us-ascii?Q?WaurDr4Rx/9ed65Xa7tptzpvjniVFrQCkw0z9zGChXiPUxxQfANLcFqCIhxQ?=
 =?us-ascii?Q?gHLRRM1KdYpRG0FVpmgIbbxP44+iUB0KjpmKj29GNnO3D3+22E+x0XRO1n5K?=
 =?us-ascii?Q?IjJNvw+VTe65oVdcMQovobPF7WxNdnuosNYLydReriHNzvKJE7RcwKo8CAHZ?=
 =?us-ascii?Q?q1FaBg9KqonHfn6f1ZcNeFp7M57uish8pEmK4FtoWtHdngZruiSg5FrBbMPa?=
 =?us-ascii?Q?Gx0FwlrbUAzpePRsEjO5+5sJmUbOY935qJHT9R2ObTqeejQc8cpX4wBjXk57?=
 =?us-ascii?Q?O52W03/Ysqf7Q+Kfjdlwq4G0Fv5Djd8HV0WDuQyTlwhZJiepfQxs2f5lnSY5?=
 =?us-ascii?Q?yAqb20z6FuQ0Fjcx0vkikmW5Ny7xetEAuRCWRykD812n4+F33d7Dk1DYE4Py?=
 =?us-ascii?Q?GcVqemWGawgW4SJDj8A4W8XoqNl9W9tp23SSFc6BetfE2Nq7kfyG9Moy+zjf?=
 =?us-ascii?Q?ufMcpkD+ZTUtDeMhP3gv5A1Kdz55gxoSSMMtfynOp/I7+RqfeVYAy64Q/VKS?=
 =?us-ascii?Q?XSxQtQCvvg7RwCPenwsQTmPRgWDu5t/dUnzUVXTI+0eoSM/kA8MN/Y3maqPq?=
 =?us-ascii?Q?XeBGNumUFbLQCAk6PkimSfvi9fxxnVZH4h5gD+6kIPVzeICOevOOgBa+9QKv?=
 =?us-ascii?Q?1+MIhLyw8J+XbRRAefKKBj/pHXgLBIuOOGhGe8MItTe2mRWW6Max3HIYzZpL?=
 =?us-ascii?Q?7EWBo2M1l+xAqRAZbyrjp8p3nHfrZSEfEKXOBYtBttrCL4kEykrAlUtdtA5A?=
 =?us-ascii?Q?2fRlR2F5phosq9HIuNwElFxdo86nZ8vuXh+qluSHs8G7J0amA/Or2ZS36SVj?=
 =?us-ascii?Q?sWiyzzlWkpj3tz//k9ncGCSEepI+mEVe0o8pjjzCRdDekuEzF8RepN4Lzbs?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TNWD8qPwhBJTwOdqEmo8TNn7FlQZ7xqXaER/7MOsM7wz0bRrYzNft9KZJUHv?=
 =?us-ascii?Q?YTym5qsxaFplSPcOFUDiH+LhpqiaOnPm6nWNgzi7KjNfqwlY50Yozk5ytjZC?=
 =?us-ascii?Q?+/4tyJroqNfKTneLCw2IR1cHuEtm7FGAuL+s8VvNzAWnqbeoO+FYOopiZ7T6?=
 =?us-ascii?Q?kgT7j/ToR6lrHlPJRrl5eNyhX0+mhpEsS6boMp0c1thdJS/RnjviH2j44VRL?=
 =?us-ascii?Q?9mV2rlJVIpXF02a8hPscsjaMGdk0zyDXqHS4ZX99PFNGxwWvQnO1gtHnYmKQ?=
 =?us-ascii?Q?NqHshrO3y1BkQjlBdf9raVE+y1OGHhqbbWlZJ4KbAPf9LKRVdSFKAaRxfPzX?=
 =?us-ascii?Q?63ABEfc5JoXJ56XXW4Rrae6QVs7TUcRZOXrrdhmz9hgT4JtUajEM66+egQtL?=
 =?us-ascii?Q?rFm0Ipa2Yb7T1ArxbIYsEFpHHBcjSEDW7pewGfLpcaBMZO4MOmZ1IBavXMpM?=
 =?us-ascii?Q?qtIgsyyD0DCggPRHxQrKDBUEvPOLh/6V13H6rvm2Uga7dyHdz2B4kreM/oxU?=
 =?us-ascii?Q?M+pcEXuruf2r18tOIwBSljKKFwFV6JTUkka+O7JM8ONlNcG+/CudraLKOZlL?=
 =?us-ascii?Q?Dk0aa4sd/OrB7pzN6SirMOC9IPUuhaw7wrNpI52PUr0X7fgvleedX9gDH69w?=
 =?us-ascii?Q?XiQEpx45suQPFF8i0C41rAQVCCm2NuACYb0AmYHUaogfvi2CKH2c0Dsiumh8?=
 =?us-ascii?Q?PrK8u1/uyJs3B+qoceGd88ucDLFKjQzMEwxexx2D88wmP3NoZJsVA4LSmYpo?=
 =?us-ascii?Q?FC20sa2g+MA2ao1Y8Gvz6nKFx8eZ36j7RCGg1z1Mrdrp7VM/URkKD+oTMvaz?=
 =?us-ascii?Q?PuNZ5YrsHjeOu8nFzBs99UkcJz1I9mMrM43mnpej+IsZHk/8KPEthzSHgsay?=
 =?us-ascii?Q?dpDc4/PAvfHAiDW7mKB0+QLNN6dSuEIAbZNVysQv9yRBowqpfOs8cKeV60si?=
 =?us-ascii?Q?yiVcZpPNFGdSYm7NqwZ4a1kr01Tii4+224OKSGVXwqJFC85xA71z4McLSBWX?=
 =?us-ascii?Q?ax9+FLbEM07VAgZgCFI7azCKXnX8SB5K/FVwqTe+JL/NSGD6+4y4j/P4LAui?=
 =?us-ascii?Q?5axrElo8bt1ZzdSQFh/OpWRhfG2OS4uE3oi4i6gC1MHlLRvP49qm9AlcYYlc?=
 =?us-ascii?Q?9kPoqtxwaiUCfHCvTAnLpKxvCT1O/1rVDwt31QehVICMMJbJQ+fg88hPFlEO?=
 =?us-ascii?Q?q+7mn4RxKbbq/v4/LDFejJoOImh92yNHHX5xsFZFGi8EBLgZQLugqILu8SgB?=
 =?us-ascii?Q?jHW2/Mg8hA9wfFEAPXg6bhCYnZ+P1qJ7YuRZKq7all43sROLsP/rb0eBrTj0?=
 =?us-ascii?Q?iP3fAK18kkWOi8UorqpKT5V5Lx2/k9llGBy2PgYW4pJV54dViDlJpAifIMRh?=
 =?us-ascii?Q?40J3rSdPashUHw6A4evEenc0SKd3glKOXF3WMVrFjNlQsqzM4aRJ/uxdImKO?=
 =?us-ascii?Q?FOvREfBkNieLTOQV3rKMgIJB0FSHOoAKJ2OXVt1smuKIGWGBFV39Mzb2hRmS?=
 =?us-ascii?Q?5zPqR+qYRWLEKF8MEQysKxbxV07ftl/lfNNYzeMqcKzWjn+OPIiuJ63jWP3f?=
 =?us-ascii?Q?Hd6EV3ESF8aUW5SdTlK+xSyPqdRru0Bek04Ks/Ao0n2MT92x5ULVSmJRF/y/?=
 =?us-ascii?Q?IaMBEk+uvTqG3EYJcQ/uGN5+BO1zFsVf4W2csDyOjFTOw87e3rkUg9KqtoBW?=
 =?us-ascii?Q?t+5Qew=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9E1kN1AjJmwzBUeHJr8NrRbYGZeCtEreX9gv2phYskaI8pJu1HAtuONhGQo7Q+0QGPeal+ULkxTZORrbbhkvuhTAStnx7FXQ0kxnd7jgmP4tC26ijRYKZPqexrvyyxt4nJrBX8hweiWjn12Yg8Rx7uegNAGwlfYdpbI3wKwJx744SgXHNoTk27RTqJNinXUJelRs5rcSPoJXveJ2XpaHYXRqafZVEYFhk7z9yW2DbMbSdUJ9iiZ9o0XFLN+R6lCLcaOWst15YOAMLepSMzjWl1fEN3ihvOUrDWhkby8IToAVrhQg+SOZ9J/cNTntNr3hC1jwu/I67/4ntmZs+k35hKaeuj2HM2kBoQs9d46peXLAXZQfotKG6jc6/tjkJV4INLJ2aYPsGd9ICuPH/bXzIyAI0JVj/S5AKRqXyimXmZ/gimfYFPfoLZHjeNXyKLvdZqy3hagbzUVql5qS/4KuvblppLsuwxR3rMXS3UUuYYmdD78J1Ets84httg0MMPJtzYnzfNbPciTxGwrbM2vyZGlMiAMhhk2xvAChcsfT2QQ0naIPRvzVKNS5wL6Eoq130bKsPxupLO3A+3x6c9LinLT+gDZSJq4Dvpns+xuWXW4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11109551-fb34-4547-4029-08dce89e7031
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 20:10:36.5294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VTeLKBihogfhYoW5d9ESY7PWmBTzv7HkZ5PnP4HyZ8WMzwfjGXs/qGhueDpblIXghGyFjwFTHwI4HOG9fMrdR7NDBLCw3h3LSYdrneH/3d4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6896
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-09_18,2024-10-09_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410090126
X-Proofpoint-ORIG-GUID: NrtkSoA_5NIN0-TwTvLyj5DarklssnqC
X-Proofpoint-GUID: NrtkSoA_5NIN0-TwTvLyj5DarklssnqC

Add myself and Liam as co-maintainers of the memory mapping and VMA code
alongside Andrew as we are heavily involved in its implementation and
maintenance.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 MAINTAINERS | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 220c1a01e361..8ebfc520e6e2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14913,9 +14913,9 @@ N:	include/linux/page[-_]*
 
 MEMORY MAPPING
 M:	Andrew Morton <akpm@linux-foundation.org>
-R:	Liam R. Howlett <Liam.Howlett@oracle.com>
+M:	Liam R. Howlett <Liam.Howlett@oracle.com>
+M:	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
 R:	Vlastimil Babka <vbabka@suse.cz>
-R:	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
 L:	linux-mm@kvack.org
 S:	Maintained
 W:	http://www.linux-mm.org
@@ -24728,9 +24728,9 @@ F:	tools/testing/vsock/
 
 VMA
 M:	Andrew Morton <akpm@linux-foundation.org>
-R:	Liam R. Howlett <Liam.Howlett@oracle.com>
+M:	Liam R. Howlett <Liam.Howlett@oracle.com>
+M:	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
 R:	Vlastimil Babka <vbabka@suse.cz>
-R:	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
 L:	linux-mm@kvack.org
 S:	Maintained
 W:	https://www.linux-mm.org
-- 
2.46.2


