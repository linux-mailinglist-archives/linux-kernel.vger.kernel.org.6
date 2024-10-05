Return-Path: <linux-kernel+bounces-351697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4A49914E8
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 08:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E5311C215C8
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 06:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F287754670;
	Sat,  5 Oct 2024 06:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VDOFMdxd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="m10FjYbh"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC31427452
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 06:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728110502; cv=fail; b=U+BjLhhbQZ8KkhlKFzg5ExdoVM0fSMxKA/rK/jVbS8fVr7pIRRhi0Bgdwq9lPhipbR6+SKLnFuqI+jG33TOHXyxuR2nYQA8Ns8tFP7GcMqQ+myWJjMEPQzh0k+wM3X1yWsPRpd7JNO4CukEwOaJZE9P1i1S7VvwIGpt68AuaEfI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728110502; c=relaxed/simple;
	bh=Hl91LTbR06LOxco/WYGWoiPoSkHXDu2GfXHCM4E+RTE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=aJ9AVBIRWSwkBg7yOcpKLfqNKmiOkxljL2iYdw1MzRJx5nJ/EZAHNFYfIF3gS1q3+S8+07l+o0nPl88Ft32kcvWOn8qjcsY5V9zpysajQpB9HoTqUPPVYOawTP2p9wHk3Zfwn/ZjlkslqQDvBDJfMZnEbWS8hWkqi8mP8ciphic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VDOFMdxd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=m10FjYbh; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4956J7dn028698;
	Sat, 5 Oct 2024 06:41:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=yHIp+Ttfytb7zmio
	nUFzdEy8ZUaJVxCqNEMeg3kp04k=; b=VDOFMdxdThSJEG1cemMnxI/ToZPPzL8b
	dImDcpTDXiIQbr51Jzk/gdPhz10PyBF1tt8rRb4lkmXLCyyCXHVSySLJKxrHsgN8
	z8aDlZgkTyvIydTs6h+rCB/5QP9AKBrlfTD7cJQNm/sHKF6LkQhSNtv2P/dKcRFX
	ymsLhs7oHjA2Bjz9hzSoOAKWv9g0aIh33y2vLdRc5x9rMNfS1gKgYaquLYkP5nZ9
	FozVcLGItfZi4BVItXksEAZrROR3QjEj4fl3nqR7g6hv/PsAvi6mtYi7LKOsY5F4
	+RtPw5wUFLwrXv1BRfmLr6mEozyi7emsenk60eivXeZTRysLAoe2lA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 423034g0bg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 05 Oct 2024 06:41:29 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49566w58004682;
	Sat, 5 Oct 2024 06:41:28 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 422uw44dd6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 05 Oct 2024 06:41:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dV0nGBWqsSiSgUKfqEX2G5g5e8h3ySoJja4E/nvhkBt45KZiRY8jCgcjpI8oPClOXQoJqJp6saRPSSWz9SZ4bRKg7WpCiIY8VRK6uLn6gew/w15C8j+h3WWe9fgWhRrRHLzbS4IYG3Kl/0Kt7svP2QN0bl8wjIChpmFmYwpWn8yoJd2nPEn9XYGPCX+gS6ilDLhuGji9cU3cwsPFgpZmMtxBelgZyEG8ld4onAWWkuY/uW362Qv+hUwo9cy0MzyRSjnPHZ0NJVw8B1fGtNS2NSyndkbTk6q+ceVCYKad0KpbseNs5xKMyWqx+MzFbRkRcg03LafxD3Och+XBqOWtMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yHIp+Ttfytb7zmionUFzdEy8ZUaJVxCqNEMeg3kp04k=;
 b=isoz8F1g5NAhXYMHfJDgJpK4Lop2NAB6FdVGoPIUnikAt7Nw0jNKx7f6Lr8QmDBnyDRalZLCecG5r14ACmO02Mgrw94oyHpnA9wpNwT6oi7gHTb92Zm3csDofQvb04qXLpz/yymWil+nv9pZbl/RqS4gAxBAQhQsohHhMwB4pGRgBYhPv7hNe8JGTnbXTGXks5UUtN/dnYK4SmJiarTwzL/NmAxZ18WTXzYJHGnVw5ziM8N8qvf54w9KE7Cn1c4ettanX0mlQoENwuZel1YzkvLffGoF0YVmvCzrTmA8WAMsdjCm1JNXGEZMltvyhrSiWlx2mXeTciM3jP1YUCaqYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yHIp+Ttfytb7zmionUFzdEy8ZUaJVxCqNEMeg3kp04k=;
 b=m10FjYbhiPSc+7ixupuBmBHdQYGXIH/nFgE75G2ftAy6iJkIko5zSE0RUnaJwtTWM1xFzoccYXVOWF1zRUjgR8h0deIfQp/yfwmg6PfSJ9ZFEwM48LHbvAp4D1KME2VuNR4BJxXEia4p6A09zHTYsh+I5hUA9Lkpv++VnBJBEew=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by MN6PR10MB8192.namprd10.prod.outlook.com (2603:10b6:208:4fd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.19; Sat, 5 Oct
 2024 06:41:26 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8026.019; Sat, 5 Oct 2024
 06:41:26 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Bert Karwatzki <spasswolf@web.de>,
        Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: [PATCH hotfix 6.12] maple_tree: correct tree corruption on spanning store
Date: Sat,  5 Oct 2024 07:41:14 +0100
Message-ID: <20241005064114.42770-1-lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.46.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0299.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:196::16) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|MN6PR10MB8192:EE_
X-MS-Office365-Filtering-Correlation-Id: 77a10436-ce5d-4ce5-e9c5-08dce508bc3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|10070799003|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+RNpb0BKc1ER35U1T2lY8cyP+ASH4eMq3919+/gA2m5gGyM5u82cqIHc5G0c?=
 =?us-ascii?Q?vM8TjtZc0m/+pAbh/DvpUrqCaD6QzbeKKAVNY0BdRUbeIAG5HbONvxJjvZ7m?=
 =?us-ascii?Q?H2SEC9FZQiBG4MulTJOQv3tbxO3V1ixQh2JGcKOjLTDZLOblxAKDP5vCkReD?=
 =?us-ascii?Q?41AdoIrusImr9voILixikIe/atqiLwc5TT3WVB2rvOBsTViRqTQZ+k8FGszB?=
 =?us-ascii?Q?JfxNVx4LfVRyVePn2xwWvZp2w3S2K1QAphr81uBIk45gWh7IRztIt/6bqAKK?=
 =?us-ascii?Q?hr6S3TYXKRryAptZdTqR1mRindtfiEULpH9MY1moAXIeSMMzUobXLWvBSvUm?=
 =?us-ascii?Q?GpwJ7N1QGw6DiozOtxEA54g0Wio4zh26zmuGVqAsbfr9Kk240NXCYUrOoFIx?=
 =?us-ascii?Q?6voEMp+zcRdWYzDg6L7GfsFsVTb3ALIU9b/0K+egRW++QZNMDd9RmbKykujO?=
 =?us-ascii?Q?6bfkeBolvbCSNkFeUuFXsJGnqwDzfrXeRgXJti72QAtbw9cgjMvAOSX1/3cT?=
 =?us-ascii?Q?oILcd6rQXOJu7QY/JTIqrcraiXIL+R2rNNvj8suSU+KF8xyFeCAaNwO28Kgh?=
 =?us-ascii?Q?ejrQn7MAjtaz8DJLa10b5MaMq4+yb6vM5K4HU0D7552gzjHkPT+0xNctSqe7?=
 =?us-ascii?Q?oS7AleYznXfZ++Yj0XTpWY006s9mrG7lum2MkOv0lF2IBHQgVksInQ2cIwFY?=
 =?us-ascii?Q?n5e75w9eVtj4RKKBnV4rmytY1Zw1IJ2uWmd9qb05c3xYnsZshbAHzUjDcZRG?=
 =?us-ascii?Q?AksTv8B1V7DamXTuut9MjKnxSVf0wcIsHgRn1YaqRw/Vpr0MwWe+r2bFCCBK?=
 =?us-ascii?Q?4j/e+6zkmeXzJtfLwcMwgPXougKIZeInh7oOa7PDIjlneUs+GnhZccyzT5UR?=
 =?us-ascii?Q?Q9OEtTZzH+GZnyiUdmNqmyyRthxBNLFPmmOKEv78x8WwybI/yhxHyrzhOVZs?=
 =?us-ascii?Q?M0Zgx+iaN9UPNbeuCqZor+GHlHCRZA7On1rp/n6TEAby1JaRdsJTREchRuLi?=
 =?us-ascii?Q?0WL7RHvGyqOmO7Tz7hW77iwjZhk9zELvMwTttVShfXRpPFKSmg5T/Xdon2VZ?=
 =?us-ascii?Q?nH3ElDLB6VEeVlcPnNOqNr+RmGfikBF1Vd9rzT9/PSlUxttN2OwSpz+vCqSU?=
 =?us-ascii?Q?dvckM5u3s3Jd+eRGfO3fAhPZmlM/ujNzRXQcpDmJ9km9ZVmXlXG7PU9ttiQQ?=
 =?us-ascii?Q?d9ebcPAtuZhh4PiMjpjMT9EIF/XewG7c/Koc6vm42kOcR7InSGXICdyECwI?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?m329Tnm058/s7PHQpKMc7s3lrqhCmNX/96QFelni69ZsN0OMYsJgPWd4+1Zs?=
 =?us-ascii?Q?Mf573fUIV6QpzGxcxZkwmT4Zprqz8vgW5RkQcTQL99EVfbSWvfWTFvaBd7/I?=
 =?us-ascii?Q?L2aaLBWSDIw0kwoYsM+hQr5PYAsVDE4uFFXvE+uhWeEbdPKaPvCT+0h0w6cr?=
 =?us-ascii?Q?t0qY19BMDh91N+fIWydaHfD4cDJvzy2+7SRFRa1LiKX8j3mzICpz+4YQ0Z2w?=
 =?us-ascii?Q?bMYwu5SHC9Kn/rBTU1bR6p9RIgz+L3IUeD0iX65rNtY3ogFuNS2lPCKOxK6w?=
 =?us-ascii?Q?4IcRQrP8dTzQin6U/Eq8rtv86N3t8E13/W5pnjj9uYfky6OtxOP3BG2F4Sw8?=
 =?us-ascii?Q?IF6cO++iLdA748gUPurmHXMzkoysHG7RAeM8HjA2QDyNhWmDMtBVgm2f6oO4?=
 =?us-ascii?Q?CyrGapnHgRqCEfo0Fi5223R0S0Lw3DYiZ2TtbKliX3KkNdoBgn88t2cvXZeV?=
 =?us-ascii?Q?mA+6f/hUcH9Xfgsg/2UuhvKN0m057/wG6IReM2fInJ23CZ++Tg49+5YcqEuW?=
 =?us-ascii?Q?RB0nOZ88DgMTSIrTfKFwtvF1wvD3oCY5YoIJ6/vHlnhwaDTgNRSzAi7liYNs?=
 =?us-ascii?Q?30CLQ769XXwcevs5oQDwO2uBgyaubpFZBthJL7YMZKvgQG4oEBLEDVVWF4ke?=
 =?us-ascii?Q?4udFRUUzVEfcBqnGYKs32SacRVG9D7Rq1x4gUGmKqzUbMI+zTxOsF2jEb5Ds?=
 =?us-ascii?Q?ttV7WV1dIOLcvaDh2jPv4RyjU7Rqc5xAku9mAUtEsoBxljypdM1t1NTbs+gX?=
 =?us-ascii?Q?Qn7O5I07qlZoGtbY62vzEtsyISRDrvxefJlzekmcI2zAuvNwlGrtqBSP0tvX?=
 =?us-ascii?Q?RRGobD8G+viRjM9fOyrBPHTD4nnG+yz76FVK3nrsdutqbDPcDNuiM4iFcYBF?=
 =?us-ascii?Q?gklkVtkxk67KZYFtGzcfHhmpcElyEv1S4EoRwPmP+Evm4JlMI1xYK/aPOneu?=
 =?us-ascii?Q?BoV+96gqExIaFw6jqIR/3fQJFQwPQBWW5pYZYgMwVPRD1iyUopZW61I5Z0wx?=
 =?us-ascii?Q?/nPHasBw0MRBc7b3Lttgo+6Ogvo96rm324cwG+8r9bBs08P4tFMMLHFQl1a1?=
 =?us-ascii?Q?j5EFRXGK531+dd7Oo+Cvu71GixLo4FFWURZ5EiXLqqfeHRD39FKgmm3deMch?=
 =?us-ascii?Q?IPaaB/fYYMMHv3ZdwBNqdXkf4ozR2nqcn1cnvGJSRf9pJssTR8XCT9mJV6D3?=
 =?us-ascii?Q?EzygjEPkkkWZMAi4YUYdqgbHtE7UNIgkt0xn3S09jUFtWMNoHOuKeuLLBMXG?=
 =?us-ascii?Q?Mz2jpFpwqs+Lr/r+JdjbnDfvVGZPZW34psSlrvM61UFvfQsedjebwQiz16gD?=
 =?us-ascii?Q?DAW0fXcKyoP96Q4T96Xsvmx8bUAwP8WJme9ubk2Fj8LDt/qfY0B6UCHDsm7a?=
 =?us-ascii?Q?YbpO9Hfq/z8euGk9giQCnb3PmYlNLkxONtiv4dRiMVGTrgaRNBffSVgarqQT?=
 =?us-ascii?Q?+GHXXOHHC4wEZl8YarAbZvefyT0Fsg3ng54X4kqfoBWgSO4YxRf0Q1XLhkqu?=
 =?us-ascii?Q?QYonzLFe/Lpaq0JZVh+wFC2gXDaomBuys+zgwF0b576fET0P372J+/+TDe15?=
 =?us-ascii?Q?yOi1m9A3kUR1f1Ol9yjUP3wwtP1T05mJLKgBz0QAhZ84V9I8EAW45io4o5Vy?=
 =?us-ascii?Q?hDi9vCFa9v2uRysNaIhn08n5WfxrCKt4RPnuGE4IkgJmYCKtgQMsMS4MmxRm?=
 =?us-ascii?Q?FiMOkg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4cpZnTWH70VgRibR9gAG6YJ1Cj7eWXQABeJI2M06mlB2MTAleZDhLAI3LJao7oiTSZY49QS2pV+elGVhGdLUaol2fO4FJoxAbdZRNBiLinUnDzAKI2tF/9isqbRCNfotU0zCdEX8OGCDZ+hYzytFaGQ8qSVeitoEg3GX3MSsNvWtB7wCgb7h3imf91rNTAE2dnVVgABpMPQrwFTMS39M5sGyQ4IJkAaSX0HYsL3ZIWueCfeh9lhfmTOz71GINhT6Jyif8EEsJLTk2lxGC1/cCWDqC42T3C8sfKIl+9KaCWYiTuCrU/VCq6ul+4RpnRH+eCVtJx83j+RSMv95ipkwo7rF2pg7BP7JQIX16PFRIyVupFBWK8NMh7l2q035tMHvxZCVvS3hS0YJKLROs2uVtCXVjJz0nhITxfrcOu7h+FCdhoMPcEf6Ha/1iiHxeXSB1th9auxwtLbVeq/W4LTahXal4G+uHgOs7xbHJzBluu5NazM1K0RtQr8H+5XJ/AFyjW+1YU9VuemWuxP7o+05M34qWsO9BZswH309lspyIv0iefGf49NNIxPXI+RD/Z1cHPsR3uAiU1698weL3ZYTWFhl34V4eEOL5shmas+Yj84=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77a10436-ce5d-4ce5-e9c5-08dce508bc3e
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2024 06:41:26.2694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ihubEKXxTgDrvicgqKhUVOeSpKo34WQzytt/Enc74YjBgLLa4v3ZGQcsHfAtiOe2MdEMd7KrHvqTbMV6J/6mpBp4SACK3jIziI0EzXJ8hBA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB8192
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_06,2024-10-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 phishscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410050046
X-Proofpoint-GUID: _1-R_h9JdQSS9AILaQIC04o6psiGEaNC
X-Proofpoint-ORIG-GUID: _1-R_h9JdQSS9AILaQIC04o6psiGEaNC

Writing a data range into a maple tree may involve overwriting a number of
existing entries that span across more than one node. Doing so invokes a
'spanning' store.

Performing a spanning store across two leaf nodes in a maple tree in which
entries are overwritten is achieved by first initialising a 'big' node,
which will store the coalesced entries between the two nodes comprising
entries prior to the newly stored entry, the newly stored entry, and
subsequent entries.

This 'big node' is then merged back into the tree and the tree is
rebalanced, replacing the entries across the spanned nodes with those
contained in the big node.

The operation is performed in mas_wr_spanning_store() which starts by
establishing two maple tree state objects ('mas' objects) on the left of
the range and on the right (l_mas and r_mas respectively).

l_mas traverses to the beginning of the range to be stored in order to copy
the data BEFORE the requested store into the big node.

We then insert our new entry immediately afterwards (both the left copy and
the storing of the new entry are combined and performed by
mas_store_b_node()).

r_mas traverses to the populated slot immediately after, in order to copy
the data AFTER the requested store into the big node.

This copy of the right-hand node is performed by mas_mab_cp() as long as
r_mas indicates that there's data to copy, i.e. r_mas.offset <= r_mas.end.

We traverse r_mas to this position in mas_wr_node_walk() using a simple
loop:

	while (offset < count && mas->index > wr_mas->pivots[offset])
		offset++;

Note here that count is determined to be the (inclusive) index of the last
node containing data in the node as determined by ma_data_end().

This means that even in searching for mas->index, which will have been set
to one plus the end of the target range in order to traverse to the next
slot in mas_wr_spanning_store(), we will terminate the iteration at the end
of the node range even if this condition is not met due to the offset <
count condition.

The fact this right hand node contains the end of the range being stored is
why we are traversing it, and this loop is why we appear to discover a
viable range within the right node to copy to the big one.

However, if the node that r_mas traverses contains a pivot EQUAL to the end
of the range being stored, and this is the LAST pivot contained within the
node, something unexpected happens:

1. The l_mas traversal copy and insertion of the new entry in the big node
   is performed via mas_store_b_node() correctly.

2. The traversal performed by mas_wr_node_walk() means our r_mas.offset is
   set to the offset of the entry equal to the end of the range we store.

3. We therefore copy this DUPLICATE of the final pivot into the big node,
   and insert this DUPLICATE entry, alongside its invalid slot entry
   immediately after the newly inserted entry.

4. The big node containing this duplicated is inserted into the tree which
   is rebalanced, and therefore the maple tree becomes corrupted.

Note that if the right hand node had one or more entries with pivots of
greater value than the end of the stored range, this would not happen. If
it contained entries with pivots of lesser value it would not be the right
node in this spanning store.

This appears to have been at risk of happening throughout the maple tree's
history, however it seemed significantly less likely to occur until
recently.

The balancing of the tree seems to have made it unlikely that you would
happen to perform a store that both spans two nodes AND would overwrite
precisely the entry with the largest pivot in the right-hand node which
contains no further larger pivots.

The work performed in commit f8d112a4e657 ("mm/mmap: avoid zeroing vma tree
in mmap_region()") seems to have made the probability of this event much
more likely.

Previous to this change, MAP_FIXED mappings which were overwritten would
first be cleared before any subsequent store or importantly - merge of
surrounding entries - would be performed.

After this change, this is no longer the case, and this means that, in the
worst case, a number of entries might be overwritten in combination with a
merge (and subsequent overwriting expansion) between both the prior entry
AND a subsequent entry.

The motivation for this change arose from Bert Karwatzki's report of
encountering mm instability after the release of kernel v6.12-rc1 which,
after the use of CONFIG_DEBUG_VM_MAPLE_TREE and similar configuration
options, was identified as maple tree corruption.

After Bert very generously provided his time and ability to reproduce this
event consistently, I was able to finally identify that the issue discussed
in this commit message was occurring for him.

The solution implemented in this patch is:

1. Adjust mas_wr_walk_index() to return a boolean value indicating whether
   the containing node is actually populated with entries possessing pivots
   equal to or greater than mas->index.

2. When traversing the right node in mas_wr_spanning_store(), use this
   value to determine whether to try to copy from the right node - if it is
   not populated, then do not do so.

This passes all maple tree unit tests and resolves the reported bug.

Reported-and-tested-by: Bert Karwatzki <spasswolf@web.de>
Closes: https://lore.kernel.org/all/20241001023402.3374-1-spasswolf@web.de/
Reported-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Closes: https://lore.kernel.org/all/CABXGCsOPwuoNOqSMmAvWO2Fz4TEmPnjFj-b7iF+XFRu1h7-+Dg@mail.gmail.com/
Fixes: 54a611b60590 ("Maple Tree: add new data structure")
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 lib/maple_tree.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 20990ecba2dd..f72e1a5a4dfa 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -2196,6 +2196,8 @@ static inline void mas_node_or_none(struct ma_state *mas,

 /*
  * mas_wr_node_walk() - Find the correct offset for the index in the @mas.
+ *                      If @mas->index cannot be found within the containing
+ *                      node, we traverse to the last entry in the node.
  * @wr_mas: The maple write state
  *
  * Uses mas_slot_locked() and does not need to worry about dead nodes.
@@ -3532,6 +3534,12 @@ static bool mas_wr_walk(struct ma_wr_state *wr_mas)
 	return true;
 }

+/*
+ * Traverse the maple tree until the offset of mas->index is reached.
+ *
+ * Return: Is this node actually populated with entries possessing pivots equal
+ *         to or greater than mas->index?
+ */
 static bool mas_wr_walk_index(struct ma_wr_state *wr_mas)
 {
 	struct ma_state *mas = wr_mas->mas;
@@ -3540,8 +3548,11 @@ static bool mas_wr_walk_index(struct ma_wr_state *wr_mas)
 		mas_wr_walk_descend(wr_mas);
 		wr_mas->content = mas_slot_locked(mas, wr_mas->slots,
 						  mas->offset);
-		if (ma_is_leaf(wr_mas->type))
-			return true;
+		if (ma_is_leaf(wr_mas->type)) {
+			unsigned long pivot = wr_mas->pivots[mas->offset];
+
+			return pivot == 0 || mas->index <= pivot;
+		}
 		mas_wr_walk_traverse(wr_mas);

 	}
@@ -3701,6 +3712,7 @@ static noinline void mas_wr_spanning_store(struct ma_wr_state *wr_mas)
 	struct maple_big_node b_node;
 	struct ma_state *mas;
 	unsigned char height;
+	bool r_populated;

 	/* Left and Right side of spanning store */
 	MA_STATE(l_mas, NULL, 0, 0);
@@ -3742,7 +3754,7 @@ static noinline void mas_wr_spanning_store(struct ma_wr_state *wr_mas)
 		r_mas.last++;

 	r_mas.index = r_mas.last;
-	mas_wr_walk_index(&r_wr_mas);
+	r_populated = mas_wr_walk_index(&r_wr_mas);
 	r_mas.last = r_mas.index = mas->last;

 	/* Set up left side. */
@@ -3766,7 +3778,7 @@ static noinline void mas_wr_spanning_store(struct ma_wr_state *wr_mas)
 	/* Copy l_mas and store the value in b_node. */
 	mas_store_b_node(&l_wr_mas, &b_node, l_mas.end);
 	/* Copy r_mas into b_node. */
-	if (r_mas.offset <= r_mas.end)
+	if (r_populated && r_mas.offset <= r_mas.end)
 		mas_mab_cp(&r_mas, r_mas.offset, r_mas.end,
 			   &b_node, b_node.b_end + 1);
 	else
--
2.46.2

