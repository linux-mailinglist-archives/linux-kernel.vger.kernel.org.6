Return-Path: <linux-kernel+bounces-284132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 621A894FD56
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 07:41:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 876391C2251F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 05:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4FE9446AC;
	Tue, 13 Aug 2024 05:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QlQIAsH9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HuUVlML1"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AA32C6B6
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 05:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723527660; cv=fail; b=Meu+OeU3NWuSI4iPd8ww/cqhlL4HDi5RmQXoNnM5c3GwomOskhEUlt5L4sCibR9UxnjfBU1z/wy5v5BtV7A/7ehbpgdTb9u1hSDhuOO168lWjhfpX6c9jFgq4e0OyMwx3Ua7UGUTV/4MjjRjSybp/NkjgfgZK+pnwAOAymTqTH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723527660; c=relaxed/simple;
	bh=+UQDRb06B9LEnnCKfndyOAuBM34M188ECP+EQiYnG84=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=Ayxktz5VfK/y2ckMk5lkOh5aoR4D2a+CMb7t6v9sr6rIp9lDu5vu42TLfgwkuudMY3OaItgnQ0wzGzdUmdA7xl1NUUJevhe2fCO8tmx1lD82/lnb9mbO5/Cv/gEddak+m9UFGT6MAMjuIFuOkAe3Y6Hw3CwcvrZhe91IlfANVp0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QlQIAsH9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HuUVlML1; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47CL7K9Y017552;
	Tue, 13 Aug 2024 05:40:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	references:from:to:cc:subject:in-reply-to:date:message-id
	:content-type:mime-version; s=corp-2023-11-20; bh=A5+7MazFZnJQZ2
	MrOrkCESO1HpnA13zS7a3i0G6K1Es=; b=QlQIAsH9/V89B1yEwHJ8gshoynyhNA
	fshW8IwhNBEddo56iXF/CYCUz5Vy1SvGrKlF2fM7jmDuUTVK/2vHncrxJZPCmmJf
	6gzKi5oZPqZ0S+E9LckIe2VmZ+m2avgnjIoDQ7XoRAWzLuRQimq1LMMuH451CLd3
	Z8T0diWi4t3GMRbnFuqDOk9anuRGrlVpyQm77+hfX75/hovVOqI2p5oS8q13YddV
	VYs/D13nsd/6ocKP3efBdyglRNsDxtzYtZ9bvTVR9z16k0bHXKtbVbPjfNVrjnt5
	/JS2CtCHFXHLBYRBhjDBxBTcVOhaM8gzAqkD/nXAzrygZIYq2ZlHVHxg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40wxt0w58n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Aug 2024 05:40:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47D4a312021064;
	Tue, 13 Aug 2024 05:40:31 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40wxnejrv3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Aug 2024 05:40:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KNOIE08MSWrI6pxZB+PNI2lwckG8u0PkkwhWk2I0T10c2PwrciqwKwpDiIjiX+1KeyI2g6cf/NVGSoyEbbfvVemBohMsnwoG0wvi9ljSLZf/UmwDvgc3xzHlV/5IWBOnhev4Y02A6V89u6czuqRsPjFYoAn6UdPRWtVf+Oj2jZqvgeZQkqfgdfuT/blVnsx3/wNi9Lw72F+g1Y3QzTkeuFuN9XMNX++E0HTfWkEXNuVlwYU5yoXuLE+RV3+mGdFIziR+HeKucL75NMf1areYmPCb+uH4A8bOTI4WZUhe2wDVtKJx/HFJgxsptks5HU2MO+qiEl8QdwD2c3cpTIQfPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A5+7MazFZnJQZ2MrOrkCESO1HpnA13zS7a3i0G6K1Es=;
 b=cvjx6Ls0hJTYDTvUBQ2l3WQ79NuVRVzOtDEw8/yT48SLJ7rphRZImtyxIf8S2ykcPexHUN1cy+C4lafgkTq27zU6X2xbzly8Nbuo/J2qT6wjCC94yyLpUpl6aJu+7OTLgswOHYL91Qq2sP9BA41j+iYCFwRqUyKV2yKf+C4pG1zHVqVlw7DA94IAnk2fFSrpi7o4pynJYUxWZmrRaR7bvhR5qIem2gLBF+iLQPnvYXw1Sqca8iEH0AMYz7WevKOOHxhNpjNGA4I8jIQ48XEGa9JY/E1vxM4Rb3Ekk8FrEnwQREkR2zccavKEpg97goQJsY2iVd42YsfQUb/yvZHCJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A5+7MazFZnJQZ2MrOrkCESO1HpnA13zS7a3i0G6K1Es=;
 b=HuUVlML1UW23e/UBIpIKmYk186GiYBNcDoLBiJdxKmsOY6X57yxrfU907T0+fec4EGZVgIEXYeVuvacrSWE144aoY31LSDgWs/wJEFwxhwRUCWLDG2eOPpNYMIHe7PaNgkudBLc4FugANpvxQypsOBSHLoc3/C5CU0m+TAwruyI=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by BLAPR10MB4868.namprd10.prod.outlook.com (2603:10b6:208:333::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.16; Tue, 13 Aug
 2024 05:40:28 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%4]) with mapi id 15.20.7875.015; Tue, 13 Aug 2024
 05:40:28 +0000
References: <20240528003521.979836-1-ankur.a.arora@oracle.com>
 <2d6ef6d8-6aef-4703-a9c7-90501537cdc5@linux.ibm.com>
 <8734pw51he.fsf@oracle.com>
 <71efae1a-6a27-4e1f-adac-19c1b18e0f0c@linux.ibm.com>
 <bbeca067-ae70-43ff-afab-6d06648c5481@linux.ibm.com>
 <87zfrts1l1.fsf@oracle.com>
 <17555273-a361-48b8-8543-9f63c2b8856b@linux.ibm.com>
 <e7e2126f-40ca-44af-9287-888f4ec34b35@linux.ibm.com>
 <871q4td59k.fsf@oracle.com>
 <14d4584d-a087-4674-9e2b-810e96078b3a@linux.ibm.com>
 <87msn785f0.fsf@oracle.com> <87sewzkjy5.fsf@mail.lhotse>
 <e8efdade-161e-4efe-8bd3-abb12ad45dee@linux.ibm.com>
 <87sewr6o5w.fsf@oracle.com>
 <1a973dda-c79e-4d95-935b-e4b93eb077b8@linux.ibm.com>
 <CAHk-=wi+VFeT7e04kMr7jhoKWb4iKgb1szb7BxXC_-M38_qAKw@mail.gmail.com>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>,
        Ankur Arora
 <ankur.a.arora@oracle.com>,
        Michael Ellerman <mpe@ellerman.id.au>, tglx@linutronix.de,
        peterz@infradead.org, paulmck@kernel.org, rostedt@goodmis.org,
        mark.rutland@arm.com, juri.lelli@redhat.com, joel@joelfernandes.org,
        raghavendra.kt@amd.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, LKML
 <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 00/35] PREEMPT_AUTO: support lazy rescheduling
In-reply-to: <CAHk-=wi+VFeT7e04kMr7jhoKWb4iKgb1szb7BxXC_-M38_qAKw@mail.gmail.com>
Date: Mon, 12 Aug 2024 22:40:27 -0700
Message-ID: <87jzglq8tw.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4P223CA0004.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::9) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|BLAPR10MB4868:EE_
X-MS-Office365-Filtering-Correlation-Id: 891f4784-c673-4256-90c5-08dcbb5a702b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YHxVSYRliUxqYVK/w9eHk6rbAu3W+rG1qIagx5rjpQ6VdW8mIv9AFJ5GQtFF?=
 =?us-ascii?Q?/66BhHdQncH7BrHNT5/mFeeG9fYryG4p+d2fGb7ENNEeVrSvUuDjHRf2QvuY?=
 =?us-ascii?Q?AM/Ier3V3b25dD9LccKz64EIrbvST2a/AezFkSyEK74oHIFAlhts4wpQbpSq?=
 =?us-ascii?Q?KTDZHRo+Sa/XfNrpPkhkDF6vN4jy8AnW1ylHksj2DFaHCIuCmCtgbF+ijUZz?=
 =?us-ascii?Q?V+LXRomlMgOtgqjASnqcrtkY3JAo5txxctE/twsszbwRfgmnX7JC7LrxBRDE?=
 =?us-ascii?Q?2O3tdXnaWKo8UWvNpHtd9nzpTUQp/9B6a7IfEPVBvuwjT3WRrCdmJ0Y2v46+?=
 =?us-ascii?Q?OjhJp9PqNfev6ul8O4TuwTx76EtIWJX6HzD4SJ9Tv441npEIuhH7IBmGgRYn?=
 =?us-ascii?Q?5OHX0UN1E0paL/yjpnaIUnHqm8NjRtnuhqugstdAxCSq2SAR7Rqa8ZrHbXXi?=
 =?us-ascii?Q?N+2fLb/u6Ps6tQxfAMPlQQiHmtNlg68gW3HFcWx5Mj8xPF0x9SoLQBgDbfG0?=
 =?us-ascii?Q?/EZ8ig1+oP8ZaI0Z4b57ZVj44HPyhHevJddFuHb1BgmRInwOD5q8KF4hP0qo?=
 =?us-ascii?Q?EwgUf5iAc17mouHQ+Dhgfyl1KxXUNkpNMiFWVuS0lADxUD4HZ076874Lf4dW?=
 =?us-ascii?Q?8gnAzvSqVYBIxxQ86w89nD0elmjR42ey4FnM2SBTxepLAHLdh56xJWlI9/xB?=
 =?us-ascii?Q?JGBP7IVOCO465Jcih1N/NAOwXRYoNox9DvSIvq28CY8UMcR0zATDQ53Y/e5k?=
 =?us-ascii?Q?X8xSN9H/Jul2TbEzMGvCJYkZuCC+UI7Ohv1OCcI1YiqkSbQhigQ2D3Gzf9NZ?=
 =?us-ascii?Q?tGlu+z6yDTezfsba9uwxB65ssK/rXpnYE29TcqxqARcR3lrK8Z/6uVPMeIiW?=
 =?us-ascii?Q?XFBFjymSafiOBBxizO4m8yVLGvtBUaRdBbaHuFBJ9KNgEPwtJWEDBIA71hKq?=
 =?us-ascii?Q?jBZpbVPZDHsYPCJayG16i/j1KXM6i/hNNxsYjUMl3BiaXEWUtynVc0kMc+Js?=
 =?us-ascii?Q?jE2bAFVOsmLqARPBDmc/HKggUmtrfpvXOYFEYDH07EKPU+vuC1onMLXgvRv3?=
 =?us-ascii?Q?OSfE3nbP2JxEkMU+ArmVtULYg8G4brwNmtS/n2b8Wx4GrPn3IS+zfanjiObW?=
 =?us-ascii?Q?U9iWl+bp9Z1hEkUvc9NORkL+pYR31bg7w7MPRuezohPVghXko0shQatZ5fHV?=
 =?us-ascii?Q?mgO5fYtLFjTp43t49YYtxz9OyF4MeKDVk5LzuTQcdNmASPMCKsOkxAxtMao/?=
 =?us-ascii?Q?2F59n8aadngiT32LrDS1PPY99djXTB5QeXqciU/d7PmRbdR0ka8FKBlNLgaQ?=
 =?us-ascii?Q?uHVwiNOZvHsEdLy4KFmfwQ5rvTFCcZ8OAmy5RWTjiwPGOw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7XZLnuRstP37mIFzeOplXX1dmylX96WtQ5zvOzVfuo5Z83EVCELVJS/eQB5W?=
 =?us-ascii?Q?7ixpVrky6GnMh2Qzh0pLWOCKZBirX4V3L4a6Yn/5e1h5oIrBMq15HDvVfg/0?=
 =?us-ascii?Q?lk/uMm9nT3YsvkltFH8Bf374WpKn13+ynYPMuwjQsd/+jvr/sostaASyonr+?=
 =?us-ascii?Q?TU8feXQ/givcl+he47orio9rddeDPIhGWWuEcAdysMklYtq4UGMVh4gSUCGI?=
 =?us-ascii?Q?eVxXcJzJk/EVYBfJ6uoRUcov95PeMkS1Gf5/+LzVrv1Lj/wdCjHeAvlg/xud?=
 =?us-ascii?Q?Qxm/n+6UdfWwehXnVumvWYlYFDbxsLJmBtGbMaXXiCzC/Fdqc0FCQ6dZc365?=
 =?us-ascii?Q?xJo8RppY+gsaWjlRdbeALgP0nAgbbNxF+rsfVZiVKlCtROGTATApfMaomsyn?=
 =?us-ascii?Q?DjJ7A5wvf9Rvpr+3+jGBHRo9FcaZUPs4mhyET4cxSI+v7kI+dvfmg9N5cVFb?=
 =?us-ascii?Q?1FRG7N1RNgxnt/4kDiCcFZwBUOrnJOKFuA/2PKNh2z/e07NRq78BQb52TPSb?=
 =?us-ascii?Q?iZbIACTa1+8GX8WCznvvSi10jrA9UApYgO2+UL6pyFGFRRz3ceVmCoCQp6dO?=
 =?us-ascii?Q?k3r1mNur6HAhkMuhxUyo11iCoe2SmYwsahZ6gLFbgYz0gYfL4hjw2ow8JI5F?=
 =?us-ascii?Q?75WEnLxacDxN1Gsf7FHiZCPTfZqzC1S5uZHZ0KiZp/7QabRtpqHv2QnB6BH7?=
 =?us-ascii?Q?08DtJsfGUJONq+6joLJ020JdUAQpqVPTLRloGLJ5oiwPgG//K9l6VmVV5WjQ?=
 =?us-ascii?Q?X+xyFlkok5MDAsILpdYl2qiyv6g1dBFWx2I9pLrOVd95jIQT86UJllRLckCS?=
 =?us-ascii?Q?u26RvtYqpKkydCkmwGsaXzpl/4DIQF+DK8ltp9drYiqNdcLucksBJAH27YqD?=
 =?us-ascii?Q?rgdeoZjpYfxNKhT11yyQ5ElgdDHp1PFqS9nYE4iXjO4IyVDxVYcabjzmhpVC?=
 =?us-ascii?Q?oJjqLZJ5OZrl+M2UaI0qvojQrGQEoZcobXkaDk2FQtk8OcD1nXqS2qFsU8qk?=
 =?us-ascii?Q?tO43MSEa9A2b4sEPmPI8WfLhkzkjRYMpbnb7YoPzqL57FjZ4Kr39fFSCovPd?=
 =?us-ascii?Q?ThCAH5omhNmLrqTAZA8LLIKYa2+7TN/LmVuYw+M5tr41t6I9eAPDC/18Ol5Q?=
 =?us-ascii?Q?g2P+LXIlhS4VeDbJO8VIgkEpBxl1c/jlxOmmKPiqMIArJpsxKw0B/GDqbcHG?=
 =?us-ascii?Q?xnMDYrzPwn/bojF7hos4Z5RJWZiS9B3sEI+PaXs4YR3NagAJHbI4kBNpIGZg?=
 =?us-ascii?Q?dcEN7AuurqhVRW+P0b8mAH/s1Hre3h92K5WttiKxTt8owFItegu63GVsMI7y?=
 =?us-ascii?Q?gvPcJYa4T1LoXUNDHC7xpwMiBoPOMHUFJ+DJXBVQuZdbo3qQWtWuG87JUI2T?=
 =?us-ascii?Q?psh5RnO2OXVgeXWbc/2WUkBrhaQ9JsRmKeexIS/en65BjXuHgwHZEkgJ0xXA?=
 =?us-ascii?Q?iM6KjZXiplhfz8G1RD6AnTfSJOX23G59EPq73NA2TcR6Y9O8Q6BtUjB6wloW?=
 =?us-ascii?Q?7cXXq7xD0z8w81Kmz87mSTld23nH/74dgJL41ltFkojJudfoMwY9cwFDhh5/?=
 =?us-ascii?Q?JjAsD68WyIjYIJcd9dEfSTqtEVwm2LYrL7zezg21DyUbGKeB5hPL5Tazb1CQ?=
 =?us-ascii?Q?ug=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	01xMKYvfdFWcrUcEgn1w55xjPhRJ1LkZOp3Lx2OGiO7ZRm085YJWVL0mY9xPMBI6phWTH1KJrsro31ym0gzdHIA+GbRmeUXGtC1238g7gdBR3EjMdG8FT14lTEjvXxHvOfSvCPG6LOc68sHMojvYYXSR9Z/BJbveLSaYWVPB+b3is+o5+nqZg2mYxyTHDYFaT0EqRXtXhb+g0+2KgLbpkYPiQ/rTbqgqzYYOQjZlW7aj+I5TiY+3XXXawDFPyGHcHpiM95VhU9iabuyu1qO63Rl2jUdlJtkabQE29sK9neWzc50cmP411fHxMmTs9wO2Cd76QooH8xNV32phOvBppF34UAOUHG/qQP0zZM89qXVVCrUeOyL4n28Qv+zzs3cdpK56VFtpEgA3KkdBkjpD5Eel4VBQ5jBnTk0BWD6ipici4vUDhzF1f1n+ngt1SXdFvkwrPIg0+8geBRYWaHlWvx0GAw8I0rG4yKrbkMmpKoq4Bow6ZX36N7Br6E1j7Hhc2l832yPY9qWtPJlp2KJn2fR3viVeLaLI9ijSgMvZYduwN0spQjUkM+cAn3yGIFvSl7vCaO5C0z4iEpV76l+NLwem4RHICrUsYjrV3DaVZ/c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 891f4784-c673-4256-90c5-08dcbb5a702b
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 05:40:28.6864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5XU+W6yuCRRgMH9CTAFI1E1sFiFqBAqqYDasvV3hB7QNUjBKO+gfjMUmzZe66N+jjAEYBL6P6a59pDThnhnvhQ3DeZFOSxN1UOcjX9tg4mo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4868
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-12_12,2024-08-12_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 bulkscore=0
 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0 mlxlogscore=968
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408130039
X-Proofpoint-GUID: sZSCQRjZb1i9SIp8L4wHecDdEXibjnW-
X-Proofpoint-ORIG-GUID: sZSCQRjZb1i9SIp8L4wHecDdEXibjnW-


Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Mon, 12 Aug 2024 at 10:33, Shrikanth Hegde <sshegde@linux.ibm.com> wrote:
>>
>> top 3 callstacks of __schedule collected with bpftrace.
>>
>>                         preempt=none                                                            preempt=full
>>
>>      __schedule+12                                                                  |@[
>>      schedule+64                                                                    |    __schedule+12
>>      interrupt_exit_user_prepare_main+600                                           |    preempt_schedule+84
>>      interrupt_exit_user_prepare+88                                                 |    _raw_spin_unlock_irqrestore+124
>>      interrupt_return_srr_user+8                                                    |    __wake_up_sync_key+108
>> , hackbench]: 482228                                                               |    pipe_write+1772
>> @[                                                                                 |    vfs_write+1052
>>      __schedule+12                                                                  |    ksys_write+248
>>      schedule+64                                                                    |    system_call_exception+296
>>      pipe_write+1452                                                                |    system_call_vectored_common+348
>>      vfs_write+940                                                                  |, hackbench]: 538591
>>      ksys_write+248                                                                 |@[
>>      system_call_exception+292                                                      |    __schedule+12
>>      system_call_vectored_common+348                                                |    schedule+76
>> , hackbench]: 1427161                                                              |    schedule_preempt_disabled+52
>> @[                                                                                 |    __mutex_lock.constprop.0+1748
>>      __schedule+12                                                                  |    pipe_write+132
>>      schedule+64                                                                    |    vfs_write+1052
>>      interrupt_exit_user_prepare_main+600                                           |    ksys_write+248
>>      syscall_exit_prepare+336                                                       |    system_call_exception+296
>>      system_call_vectored_common+360                                                |    system_call_vectored_common+348
>> , hackbench]: 8151309                                                              |, hackbench]: 5388301
>> @[                                                                                 |@[
>>      __schedule+12                                                                  |    __schedule+12
>>      schedule+64                                                                    |    schedule+76
>>      pipe_read+1100                                                                 |    pipe_read+1100
>>      vfs_read+716                                                                   |    vfs_read+716
>>      ksys_read+252                                                                  |    ksys_read+252
>>      system_call_exception+292                                                      |    system_call_exception+296
>>      system_call_vectored_common+348                                                |    system_call_vectored_common+348
>> , hackbench]: 18132753                                                             |, hackbench]: 64424110
>>
>
> So the pipe performance is very sensitive, partly because the pipe
> overhead is normally very low.
>
> So we've seen it in lots of benchmarks where the benchmark then gets
> wildly different results depending on whether you get the goo "optimal
> pattern".
>
> And I think your "preempt=none" pattern is the one you really want,
> where all the pipe IO scheduling is basically done at exactly the
> (optimized) pipe points, ie where the writer blocks because there is
> no room (if it's a throughput benchmark), and the reader blocks
> because there is no data (for the ping-pong or pipe ring latency
> benchmarks).
>
> And then when you get that "perfect" behavior, you typically also get
> the best performance when all readers and all writers are on the same
> CPU, so you get no unnecessary cache ping-pong either.
>
> And that's a *very* typical pipe benchmark, where there are no costs
> to generating the pipe data and no costs involved with consuming it
> (ie the actual data isn't really *used* by the benchmark).
>
> In real (non-benchmark) loads, you typically want to spread the
> consumer and producer apart on different CPUs, so that the real load
> then uses multiple CPUs on the data. But the benchmark case - having
> no real data load - likes the "stay on the same CPU" thing.
>
> Your traces for "preempt=none" very much look like that "both reader
> and writer sleep synchronously" case, which is the optimal benchmark
> case.
>
> And then with "preempt=full", you see that "oh damn, reader and writer
> actually hit the pipe mutex contention, because they are presumably
> running at the same time on different CPUs, and didn't get into that
> nice serial synchronous pattern. So now you not only have that mutex
> overhead (which doesn't exist in the reader and writer synchronize),
> you also end up with the cost of cache misses *and* the cost of
> scheduling on two different CPU's where both of them basically go into
> idle while waiting for the other end.

Thanks. That was very clarifying.

--
ankur

