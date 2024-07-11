Return-Path: <linux-kernel+bounces-249446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8372292EBD5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 17:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F1BD285D96
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 15:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B321516C846;
	Thu, 11 Jul 2024 15:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KjaDUcVU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nySu4KE9"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CDA28FF
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 15:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720712414; cv=fail; b=rF4kNGmBYPf9RmLsaR1Q7CpgcKdXffL5kQ0IF+lKwPEKqCBstaoN4LIBcimWxO6cyjrh6W/WifgrGi0XhsIK7nrmnF4kgsDrlfbbEX4WJOuNYaT9n8yHezHu43+v7P0mGXDO2KwtXukIfLzAPuDHwUt+7nwbzpbWaHwP4028sx0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720712414; c=relaxed/simple;
	bh=jCBo5CtrTrfSBJoum7ee9f5v3xRaiYxzAICm3MqZxjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qYeHt3dpHrfv7J+J6Vfq2ihiM8genvqqZFq/DjZcao2iQTsFxg/H09poADrENCNcOCic71rO/WuSzzFdZ03p5+bLPpvt15XYMXohLcd0mB7tuTo3+G3cvaHckT/fyV5S2bcnxVTu2B5/FKxrxGk72RbmwG3NANxwn0+nd8L3WX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KjaDUcVU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nySu4KE9; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46BFBWaZ012988;
	Thu, 11 Jul 2024 15:39:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=QZqCRjKiAgEqTas
	w6Ms6L0FXSw6lCgH1Ff/Ozf9Ikts=; b=KjaDUcVUviTeXzVxLsU4djcC5V1HqZS
	oP9K9nhYAFulswFpOPSWmjWX/wDacB14YklU3hxufE6QKWU9d/iiaZYaUNocJYO2
	BYW6/iBRX4arX/2fqMxc9vvhF6ed7DqedVo6yN96xe4EEqfeUpGw5TrewCc07skj
	1wIw1u2uEp56Z8QdTwzXc2ZUy8ZSCJVzPx5LFHKM6188R34Th9yCUyFJN5BqApGB
	jQbywXfX7YgKgW9Yp3Wpq1zhpcSa8ayJctkOgDBXQIDkGpt0nT/QEA3FyPvHpnRt
	ZbKYfeUsVwrKr9bK9jtF4cD1vhAB1pMw17jV/htDJDejEelwjehKRzQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wknsxr3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jul 2024 15:39:57 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46BESrhx028812;
	Thu, 11 Jul 2024 15:39:56 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 409vv5690k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jul 2024 15:39:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RKl4d+RMFz28qMFrp6DJgI8CQ966Ybm/nQoCmg/cojC9d1EeoSzc2+WBdr7TgVggFwY57xM9JnXBl1AmYZc2Zm6dAfPU1uPegiR0JQericPXskRmtck/rNPJ8d3z6ZoqFiHWhmUIWYXm+DFMjmvXWmgAb/MiWIJnUwPtVknnRQHyvShtSYe/ZSxQQe7xOaP9sFbl2iFNU+s+UtEFYlqjHHe35I774FYq0K912KOyDvPrWlwXL6/V8oSIprPtAYGEaRw1CeizMFN10MQV5yk47J43RgGS7tknvq6HO0VdH6BTbEdSA78u71NfaUyY9SXzF7BNMhIE2BC3UQP+dLSdqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QZqCRjKiAgEqTasw6Ms6L0FXSw6lCgH1Ff/Ozf9Ikts=;
 b=vOLbC8C5ObL3oIGQCatJM2Iahd2C5MZeK+nfeLLtH32tts/7kmYAO9cHlafyXED6InVe3Wswnfv8e9kOTWCI7i86HBmoVQQPMntJs/6KfA8kgN9/45/PYhdgPLA2UiJfsm4gEXDJQqlQNJPx6PB4lEoF9eKNNOiTiHhuP3GiR+T5E2y91o8ekLKMhPmxIiBmn54IjcOv/25Tj7pOLh3KQar8Uu9ZuX/Za3yTZhKUBIDKHTl08yjmDSUTHOGrV1ZkZ7AiGi1fQW6cuPiglYbxs/H3Ih7hFKwMpkwRxB8QmhqjlERmYflgIkN0COk6LbcJOfGnPbfeZv8XpspfLELX7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QZqCRjKiAgEqTasw6Ms6L0FXSw6lCgH1Ff/Ozf9Ikts=;
 b=nySu4KE9gsVk8vedWAHjIOOhisLMJX7F95OQpmWl4CcNejYOWjL2MlsLBi4//omTt0DJOET1WhSsVqr+avZp1DDexqylBo4xQZ9Wrau8cc054GKqms52VwC0O0HkLXk/ifufs8XDBWonQkM+P4TO4jKYeQWLAuL9BgcGbDb/hsY=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by PH7PR10MB5674.namprd10.prod.outlook.com (2603:10b6:510:126::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Thu, 11 Jul
 2024 15:39:52 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7762.016; Thu, 11 Jul 2024
 15:39:52 +0000
Date: Thu, 11 Jul 2024 16:39:49 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v4 21/21] mm/mmap: Drop incorrect comment from
 vms_gather_munmap_vmas()
Message-ID: <46405ef9-4b43-4d9c-a15a-b883ee416916@lucifer.local>
References: <20240710192250.4114783-1-Liam.Howlett@oracle.com>
 <20240710192250.4114783-22-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710192250.4114783-22-Liam.Howlett@oracle.com>
X-ClientProxiedBy: LO6P123CA0048.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:310::15) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|PH7PR10MB5674:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c0d2ce6-ec22-4fe0-5ed0-08dca1bfb4e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?dflXwosNjISN+37MZiHeiIjlAre9Fgk0VuBimTrszNErdhARD5LOmp6yReb0?=
 =?us-ascii?Q?bv6xXtv8k+GjT7gpUnIf5roqErQitKlliuFFuO9DjPExrjeuZoVccqMs5QP9?=
 =?us-ascii?Q?TLRds/93pnC1yqzLXklXuU8a0Pc2nU6IwmjC13Fhsyfl+yiD/G7V8aBWwnGW?=
 =?us-ascii?Q?sk2Py7US6HHVrZTkcXYS4Fip5T3lhVRJJxggEpcIbOh7F8cMdf3HcFfu+sL4?=
 =?us-ascii?Q?ZRP5QahRb1MXNg7P2ICSFbCEmRBegycmDFFYwz5SZGSoWlkKoIwGboc+rTOr?=
 =?us-ascii?Q?aZrdXHLPjhzq/u/WbZ+n1YtYBfCrjQyGp81dxHSfaqVIzb6U5pQUU01m1ZC5?=
 =?us-ascii?Q?32oLGBGN+a+HaWV0au8kLu2L7/IyFnFjSyJuIHdbcBqMyOGv5Uv32F2t19tz?=
 =?us-ascii?Q?EC+Z/UBxuNrDR6/mJes2ZCe2oZFDxsA5WdHz2o8ncPc4PZ1HeMHlswH2+y2R?=
 =?us-ascii?Q?mCiH6indOvuF699XCAiLs7hkQtxWwARyvdk+7Y6PDsS8VokMNM/xD60g2AA/?=
 =?us-ascii?Q?goOd/oI7saiqBLyfg10o0zzxR2ezoJ9wNB1V9yKLgs8IEEPAJbUNHKdx0Vp/?=
 =?us-ascii?Q?9AMqHLFIS6fnj3mZMdIBs+rsiObZ9+mvxjDvp04x0vulnSy3iuXW0COf/EKG?=
 =?us-ascii?Q?4Lg0BeQiUL+gGPKzFjawUN/kOOLwEI8/A+8OpXHjFEWz4i5qQKNvKeVH5Aor?=
 =?us-ascii?Q?mVFFKBVSeYFohEOo23Mk8tURKZ1ClwTSjG1IQjS+U0inm6QLcsML+n0KrvZl?=
 =?us-ascii?Q?zNvEPLNlvglpo7ldErTUCn+fyaI1lty68RzZg4QNwun12KtZEkAuqoYF7kH3?=
 =?us-ascii?Q?JG/n4q66wW5cQ1kZhfslvwXmqyYRbfnyP5uGZS7+BDFaLr4S2OQquNN32Itz?=
 =?us-ascii?Q?v8P8HsxPNnmzG8oY6LZEZ84DmZJAlefgtR9fhXzhl4NXWaXxZBqJeHMKhTd7?=
 =?us-ascii?Q?3W4vPMF7ppQjPD89sNSVBk9k7TS5aHc28sgbZXomGzihXKsUoeNZqYefA8/F?=
 =?us-ascii?Q?SMZOgMAHozV6FuUrqlMXFdVaU7qSIx1MxtQt6HaG3UfgnXXpAsRdDr/GdFHf?=
 =?us-ascii?Q?zPdvTZ4JnrlcM1RnJniH+ZRBGN8mYjmwvNgDWfY49UhByOCzkCBdtGLfP84z?=
 =?us-ascii?Q?SZF5aEQx8M0ZGjSemyZuunBFwbXFe4jwydi1114X7846uO02t1Zgp6ZohKT4?=
 =?us-ascii?Q?PovfXfYsBQXw5VJF311xnGfBf6GdLs/bsfo3ax9F6g+dWuXsMEjbl14y85pC?=
 =?us-ascii?Q?l0HZ8FApfWZH+Ci7XRqZfusJmjK+Vin9u2eP48z1flusg4+JXwMJGeFsm+GN?=
 =?us-ascii?Q?frBaeCC140WtZ/EvP6xXVm/ktK/vrCyP0IvSHRCQfh/IRQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?E9iYSVeEXBYJcV5Vv6265q/3tUJ97Kfkwn2GR6soL7ZbXCeEu+ff1SmLuULi?=
 =?us-ascii?Q?T22GUmnL9P8WndAt5ZtqTrgSyDrNsOOMOfjNcDqvFyRnTyx0aft3Bfi40EsE?=
 =?us-ascii?Q?YPzVQZf9YkDMD6Liv5gwHnyTM4bG+14NmoZXpSl1shQ3MIKL65HU5k6Ewqdw?=
 =?us-ascii?Q?ftQnGsV4ZJ65KAcLRjaJMpwVPUCcOQiUUEDdMG0zE/dG51t7pFO6oCi99i3s?=
 =?us-ascii?Q?nCZajdjSAnxSdBjXv5UfX4dfIspOYmzmo3Gw2bbQD5NBVRecuig9vOQteCj+?=
 =?us-ascii?Q?FNaNnFzwC3BhwcBOpKOtnLQJzwf/VQ2h7oBevuOIIohb/WCMluBTxDPeo/zu?=
 =?us-ascii?Q?VF+MVFcmyliDtkgOwrcCoeviXGXpHUjicMHl7qGMoerpTgwxJkxp58oDVC+6?=
 =?us-ascii?Q?IQf8NaoaqpRA1Acc3LNmZ3B++R1qVgZY1Ph71mmHxq+gEo0JlS9o5fET/hqq?=
 =?us-ascii?Q?BrgyssSFw150vGEDaaKE7vtvS0SYS3urnAa1Rx/5WrvmgT3MhgLs2ZVEabil?=
 =?us-ascii?Q?xEoFV/HJoWuxCUK44pL01hNPd9riaucOMBd8hkmeuE1cF6jACEPT/NzxM3MZ?=
 =?us-ascii?Q?tJpoZWB9BJGweexUDM/0X022jfErE3apF8innklUF45Xhiug1nn43OnG/yOm?=
 =?us-ascii?Q?MaojOwzxZvknq8vVLKcQOv+a30wh7O3xD8+Fyb0Crctb/4N1qWqxakKfOTmx?=
 =?us-ascii?Q?Q3N5Y+stgLvDkFd8//1i3EoRuxB+ur5kAosNyV2kyM1PbgG00pHbmL+1WPBg?=
 =?us-ascii?Q?VxBwuBawoaAMrYljII/EbDpTLa5KjleP8CUEVx0dEi41KNRPiEYIwraCXA/H?=
 =?us-ascii?Q?9brKIZpenTbtKVk4Fd2eE1eacA+VnjNIxBUdkiNRWhrJzxTSLqOmxaxvHC0P?=
 =?us-ascii?Q?UkYidYc840k1E4qDGJkH+JWrikTdvgjpqPdnO87GnuzsuIh1ctjqk+JoWVHp?=
 =?us-ascii?Q?wuAC8R5SqbS8mtopJq1mrn7Ue7maKREL31UzgPnBWwBdDwDLc9gCY4QU91qs?=
 =?us-ascii?Q?sCr1PXJ12FJjWFDREEYgV3n4211NVtmkTfs5iIhq8c9TCWKMxTXFvkrZMt3e?=
 =?us-ascii?Q?TVUqo2ytXW3Wga06ZS90p86/E9TX811H4piwlxSSDwimzCAl0QAdPow94jDS?=
 =?us-ascii?Q?RsBfiQtWw3zyo7bWDcFdqv2sJKMfGnkdBSxxh6IY9sysQ4J6BXqlEG+LhdRQ?=
 =?us-ascii?Q?i32SYegj9Qb+m1aqE8GYi122cpBoLzHh0fzq6JTdGXjovmGA8XPkqlkbly2P?=
 =?us-ascii?Q?8X1Qlarfrxrm+IztaiExitkQ+uVlWque6EkTXtBnU2XglGghE7zPbfVcxFhZ?=
 =?us-ascii?Q?QCxT7LgE+RT1zO+aiotS4Gs6enh/KNMZ10BfUH5eFdkgibNSTR82eejjBnrF?=
 =?us-ascii?Q?OeA/QgtiXYcaL+gRpUBuIaLRTnHcp/gSAVStirT95BryoKuquZjz/mCVxG4l?=
 =?us-ascii?Q?wvzCloiAQ2xRXinhHDsSGBCDKSYPdqF7mQpHrMMKybi5WCi/IhLQdrVwGboH?=
 =?us-ascii?Q?O+g+DrlS71IPQM/HqunoyM89BaaThFqEYlHVf2S24ibcO5JF4pW5M8TSW/y+?=
 =?us-ascii?Q?p15sXGG5425w1X9w7gogUPy3alhM91yyMwGFqgVOPA5Cu0KY7Bw/E8At6AaK?=
 =?us-ascii?Q?/KTcK8Aj1thw5IG/sdGeu7kVdLqCQSdK0cczmMpku3iQCbFdljDiULmSd+yk?=
 =?us-ascii?Q?Jvos6g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	xhvQ+uh8q1UpyEgE+87jnFFqjv9uwVbZBKTS+WS3FQJCEmjxPc16IajPuNKNjdSxvScNIgxvywblLiLOJ8/dPIbU/qUi1eWmLHFk9+5Z9bE7wiuzbxLaVbgEdzWjkL7CGqlWkCyTxz0h4TBGqCo3LIezmQIFIOsPtPudNUW8h47rsWJ0+W5O7m150lmuI3w39BFXmBr8cIC/XAt/7OTzuXX+J2IIgFIVB+4cqjcV7d11grbMi+oh4WkKUMPnQcp3FwGk6IMDxFfiBNInVYAQLMtNsL2wYXZHyk4zB4UYeb7BNXyEbaTe94vaCPOkDYPcinMKANvphQXQGxg/JON7PmuliGRHnldaFf0X0tDWnHNkr991pcqYoVHH94u+xr9y3KSctXTy2QsVAijk+uYX7nLx93Odz61qHbDFhQpB6IliFueaSxduQCZEuMeK68ouTfs6Um/87GF4ExpYpMA/XBF8igBYtOP/NqIsejz92BSSJ04b5GYVWD2PAyvPfrpUP81L18PHyfKmRwE09+5p939MH5EJ9Sl0/KsYsceocoVivC5AjQQORYvYj2iXDMCJKEs0v4rbDjvApKdw318Ipz4Z9/LTmUrRVYKA7GDipIE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c0d2ce6-ec22-4fe0-5ed0-08dca1bfb4e0
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 15:39:52.6099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CdfOfNPCxqfHt6pgVUyIKesjxjydIlvncqUFeYZtAMYEcpmfeOqbMWodqNBKZ0ONisbLhBVjhRXDYDvo50sUkBLk6ubMEjJ7N3dEKiFSraA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5674
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-11_11,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407110110
X-Proofpoint-GUID: QdCebCcfJY5PSx_iPEI7ZQ6c3NLD8a9z
X-Proofpoint-ORIG-GUID: QdCebCcfJY5PSx_iPEI7ZQ6c3NLD8a9z

On Wed, Jul 10, 2024 at 03:22:50PM GMT, Liam R. Howlett wrote:
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
>
> The comment has been outdated since 6b73cff239e52 ("mm: change munmap
> splitting order and move_vma()").  The move_vma() was altered to fix the
> fragile state of the accounting since then.
>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> ---
>  mm/mmap.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 7a440e7da55a..ca3872e5fbd8 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -2675,13 +2675,8 @@ static int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
>
>  	/*
>  	 * If we need to split any vma, do it now to save pain later.
> -	 *
> -	 * Note: mremap's move_vma VM_ACCOUNT handling assumes a partially
> -	 * unmapped vm_area_struct will remain in use: so lower split_vma
> -	 * places tmp vma above, and higher split_vma places tmp vma below.
> +	 * Does it split the first one?
>  	 */
> -
> -	/* Does it split the first one? */
>  	if (vms->start > vms->vma->vm_start) {
>
>  		/*
> --
> 2.43.0
>

Looks good to me,

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

