Return-Path: <linux-kernel+bounces-220968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0795190E9ED
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 13:42:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9056828AEA8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 11:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214C813DDC9;
	Wed, 19 Jun 2024 11:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="LVSF4waw"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2056.outbound.protection.outlook.com [40.107.255.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3A013D63E
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 11:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718797138; cv=fail; b=G2RRQ9g2O4hB9eyGjSSGbyC5qsJUxSiw6Gb4C+UjMhwxKEkIaFuCo54mhXSDEmqsIgyQ27OM+P8IaUODYTMrDDBkLpG0mulIh4KzxXCRV+GuA3cY91A5wviBP1F5N+NKWtY2zJ2tgLzGSmdwmOF5eSvlaxx4EW5MWmUVRkx2SI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718797138; c=relaxed/simple;
	bh=Z055YOUvlZI8vtlM1wrWfy8kn0gstnCG+d+67o4J1yo=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=dsFCUad7nFfBwtHHwv7o1q13SrBJpezGHB9LWVC6WR1D0b/jiFbSNBdAaZezzOFJS0G1b+iMCy50XPgXkeO1LEjvvyUdiWyTGHMCwr1ZomMqoRKZ7SVQ+r3cgmc4urVuOXqeSpZlY7RS8lZImQwmy3kR3EQ31FXUdGerYIJ/ZcQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=LVSF4waw; arc=fail smtp.client-ip=40.107.255.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XrbNJd/K4733J4iwFO5+7dha/5ZjupzNYcTwUAzZG3kdbsElyuDBB225kJX1myOGPupMqgX6qnodg4PhHvbEL9dVfUcTxuWq37od667xiw9DQghZNVnfn96/0ar3C9Ptj0+EBz6I0xyqhdyDZ1xDx3Yv4PAbLVXtsi6qqiDcCMgJDgy1uDzC8FmoDDPme3hroQCaYOSuf+YysjZ2jEbbM08A/HwhrouXg0RJQk6rkh1FNHg8rLcLb2ZFMZTBH7e1fpiS1EbrFfaqfsNDwGCzDWvJE0fvxZOsQ4iF56M/DmEHVewvxyO7zB7ts6R0z71hUKd6AtJjcNo3QwNP2NWoqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CNHlryStF25GlE/3MsQY7ffFb2GB9JzZu2s+EhO+tCk=;
 b=B8owxs9lyfcCN2exb8wu91i5U2YJFO0InCuZTnxyL3wHyWg7EaKFtypw+z5Nlm34scFqX1WqhtGcxK9CWS65CF6o3WU07xYSFPcXiyuPEeOO+DXJSZpz3AKnj0+9frAF3ka4YIRNJ6mvW+eZJ9XpcrZbLufcDpLVG51CY8dmKin143w9DA85J9pgqTtlpp4xI/bqTgg3A1jTJ0LXOZJaWs1YtVJrk0ozV/1rMi5m2uYVc03RVQECqeNUJNiE2Q9a868+xh5z9OEbAbhCj7DZNCtuJgELcaJJAy/lTk6SA1ZezWosCFQRPQXYea87Chbe5rL2g44ovpSbBRv+MA2GZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CNHlryStF25GlE/3MsQY7ffFb2GB9JzZu2s+EhO+tCk=;
 b=LVSF4wawvfqvf6HEhaJ5NSFprUFEt23WIHMq1bwrPDDrGa6UobD6YaxU5qbCIAKpJ+jlQ/KFKrkkZLhpzFYfwDZbUAqXfRvS8nS0rLI6OGr0Fqc+t47YwMagp1se/9zv6cbOIBYQeh1LAXiJfpMwGHXlymtjXwhj8FrdfxOeW1C4EqSZPKwTLHzTuhrxEdNiRImF6XOP6sU2diTut/yjJJCmggE43CM1IVfPpA145kFE8LNKdcv0F9s5iscuwALhp7H5F54y9hpmPeN1EegI6cdFSxkOJEyTfi7zl4kP7IoJssAf/yA2sBvQOS0l9etia3sIQwWS7jKIgxo02ysDWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5624.apcprd06.prod.outlook.com (2603:1096:101:c8::14)
 by KL1PR06MB7085.apcprd06.prod.outlook.com (2603:1096:820:120::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Wed, 19 Jun
 2024 11:38:53 +0000
Received: from SEZPR06MB5624.apcprd06.prod.outlook.com
 ([fe80::e837:10e3:818e:bdfd]) by SEZPR06MB5624.apcprd06.prod.outlook.com
 ([fe80::e837:10e3:818e:bdfd%5]) with mapi id 15.20.7677.030; Wed, 19 Jun 2024
 11:38:53 +0000
From: Lei Liu <liulei.rjpt@vivo.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>,
	Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Christian Brauner <brauner@kernel.org>,
	Carlos Llamas <cmllamas@google.com>,
	Suren Baghdasaryan <surenb@google.com>,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com,
	Lei Liu <liulei.rjpt@vivo.com>
Subject: [PATCH v4] binder_alloc: Replace kcalloc with kvcalloc to mitigate OOM issues
Date: Wed, 19 Jun 2024 19:38:40 +0800
Message-Id: <20240619113841.3362-1-liulei.rjpt@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0279.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c9::6) To SEZPR06MB5624.apcprd06.prod.outlook.com
 (2603:1096:101:c8::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5624:EE_|KL1PR06MB7085:EE_
X-MS-Office365-Filtering-Correlation-Id: 04894b80-0d1a-47f8-fcf6-08dc9054656e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|366013|376011|52116011|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3zyL8oOoOicQEPO3SEQfNM4qucCCSR0uZ9BBloHWbz7L90pjquvvSbe5nU1+?=
 =?us-ascii?Q?hsyNRB9Y6KHjgMHXd1usP5nJAPYf1KNYb5MQjTXdEy+YFrDyYhkpdAL6gUS0?=
 =?us-ascii?Q?D7hrhIeeNz8h36+7mjb5kZhe20jkl/CvjaLfDQBXol9YZoqeIL6tA0G6N/aj?=
 =?us-ascii?Q?zan2PrA0cauC/xhv2tobHmFoSX5IdNO5QbO4x4onpyjPMbliP3zfVBRqKM1A?=
 =?us-ascii?Q?RTPN3irLE5eRMP2KRpnBRsFaWMLrQTEDHvpwKy/lrm4o2hUf+5tv/S0nKbkK?=
 =?us-ascii?Q?SlLO2MFicEsdG65IypGX33HFHGtze/wFX1slbrlhVuP9nSbR0eXZMVTyonrS?=
 =?us-ascii?Q?sxTHoEaVJhRhlSpREF7JEzqJfu9IRKtwNbohsUpgVjiO8lmWTGika94Xd2WD?=
 =?us-ascii?Q?KCD4k5WgYChC/snWC0AwWyTpkrJE87vRrFk+g+vJd3Ug7hQmo9qReg9Ic/5/?=
 =?us-ascii?Q?SCZHuVjDEI2m6p65gswfdJZraTG+s7Zsui9aCSXmElntkjykukI/MSm0XLQr?=
 =?us-ascii?Q?RR+h5YYAWkkMhAydQoJ/XgzSrWKQOKh3EodCjbP5HqVScjY8gxTRi+d436x2?=
 =?us-ascii?Q?6WRnGQQ7E8EaDoR4q+N9afdQXlb4kUZv91hnJ9fn4/0VE4mXeHZtwTKA7Uca?=
 =?us-ascii?Q?xJyey5YLMaSeiTQ6y+rumcFmbLPZPg8ZjQXmIP+TrlMn+tVbpIT+IeqF+zPR?=
 =?us-ascii?Q?UbppiqgWcuWzkovhRVCMIXv0FrVpIZ6eQOn0UXJ/LXk9ItM+qBYYfW/XPi8x?=
 =?us-ascii?Q?EftFJGAHMii1YQmAHbMY/rcUv/vKQQxg7BHRiPgmZA7B32uGy/W748CEwM97?=
 =?us-ascii?Q?T1I+cAdFv83l9XewEUo252L6Y9ehVsR366SraaYFlR2nbjO7V3FvRzvrnxQ2?=
 =?us-ascii?Q?g6zVJ10d06oDOR3nu3Vf19i0MPWLBRjv4qcJ7Vbevge6/edSRWy96aC2dU5Q?=
 =?us-ascii?Q?t193/X2SfyVU/ZBxcRW1Hj3Xf34XcIbYLCsKOco9t8208i+8v6CYhNb7DMU6?=
 =?us-ascii?Q?VUcwKDcCRDnT9dAfOwGx3AvsxKdQVAd6I+oaJecH43VhBYtbCiHPJE/kfd9H?=
 =?us-ascii?Q?VKTGv/JZFMfem0k0OmuBcQoBiVFln6XEKe5etx/1uTCwFz1ea3BhrPpIp6CO?=
 =?us-ascii?Q?Nk22TiCb68gGNz42QdU7h453FznGViW4yMA0kdSfRYwVehBU075gLEFjZVYO?=
 =?us-ascii?Q?P2IFHaCzcdRhntOqj1lTrLGrIoPFYKEOn9sWYb2jZXGLb5eXqYWmGIe7XPQr?=
 =?us-ascii?Q?iU32eG1Ify6xjwkuILq7U3FVQdX3mo/7O5bZ3lHS96rdvcF9xO3CEL3avA1P?=
 =?us-ascii?Q?1DB4v36ITLES5hM4HyCGsGb+cIT9F8sO5pgMyVw0RECQY0OO5FkLo6oWlbnZ?=
 =?us-ascii?Q?477yJZQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5624.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(376011)(52116011)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pNRYTHKhiznY1YbCNPu0MKhAizIzSCV/tv421vXytYoXVMBPDzVvhO808K4A?=
 =?us-ascii?Q?Ea1yCW7qkopKJWRPmZtkgW+gpcVEqotPaCS7rlCkxWlfgmX5pnS/Bpn+uG5j?=
 =?us-ascii?Q?GqxCRse4kYGQVoUAbOImtZ0SPkjwx4fYBzB9k+r+tGYM2Lz2f0scE3I7ZOGB?=
 =?us-ascii?Q?as3KJSW/dUiAJtwBnLlW+5MDHwqtaEcEBBFY3fpni2H9RXNGFOcUCpXZ1X1G?=
 =?us-ascii?Q?F8Jt/HymJuCErtF0Mn9TjfBsAGSWz5zZLxEMQ9EWsm//O6Xe4gMbMYy8Qu80?=
 =?us-ascii?Q?oZqCCwR9Xgw85cgQqtBKNGYZ5jUEwaHJiYajIRbdtnHSaBdX/jZKhha/rHxH?=
 =?us-ascii?Q?ttYeQXYsr27KdOX86LBouiD/B07Yj2eFwczVmyFRbKStAWyB/qVb8ZIaEqo2?=
 =?us-ascii?Q?sYJXxCbeoAWjFS6y/9SDFcAWZPxL61oZD/VheS6+c0WyC5dEEeckb9KhtS59?=
 =?us-ascii?Q?VPMsqOBeekyKyByZ3sJHF0gh1105FsOuqRh7HmsKAMVDkMaHjZsgIPl13q9S?=
 =?us-ascii?Q?mMkGim1gwYnEahi5xPtzGotXSX+LeC/TUsT93yhpKT3At07A1r38moLcc41l?=
 =?us-ascii?Q?tpN7z3U/r/DSYOX1HFneJ3prItv+apSs9tUDoGH31nHzXplm/l3tvfJbPP/m?=
 =?us-ascii?Q?r/2fHyRS7PB0+T17NtOpLTkdCTTklIA0ETWoFQq2DIsaDE+05bKjk1rw3c8/?=
 =?us-ascii?Q?foXLkdh7Jotcv7g9+VzFhDXnCatNBzA0tF4VzegQ6YS851kJfBjIo8A/GHXK?=
 =?us-ascii?Q?SegXl89SnzRUurDN7ihfVtJ7gScdUn6svOALWYxFp7e0NqEnDs13Q/1aNBLx?=
 =?us-ascii?Q?C1xG9gAgecQsIiG3b3sqb/k2O8D00OjZasTX5vExAZFvDi82e2upn1PrNjpU?=
 =?us-ascii?Q?qfwDmC7wFbXdGE6r+edlHbMm+D3evS5UozglbyY/mzaDVpfYTA0uvGtIVh+4?=
 =?us-ascii?Q?AlmG5fKkUlFGQUe0V/FY77KNUsz2yQ3KWp72dA0q0UowaOG9D2Phr9D5FHvn?=
 =?us-ascii?Q?cud/b37kCIOZF/ipfZn5spBKdDvnVzDhUIBvqr0WxZPxPhqUcf2vVapngZo9?=
 =?us-ascii?Q?oxPh944DI9Jh+OYPbyO4L8c6ucGx/EAM4vLyHxKQFlTRsn52JxfC6ijdj02y?=
 =?us-ascii?Q?rfKiHbF+9nGe0vKgpoPztnY2O4qren/jgq9ovqI7LeaURL2sSE5mX8OZwtkM?=
 =?us-ascii?Q?poVgO5w1dIaJgDoIxU9jJvVxV90u/6XM2yBFaOafpugkoyEpzK2uX5SETGSQ?=
 =?us-ascii?Q?dsekH8tDD0zsmUzUqqQafCwCn47kIhZu3xif8ffTB7mBMkGhJYW6nfyJIktz?=
 =?us-ascii?Q?UURRqoP1tNvl5zgbc9xxqRQ2cKRsuoEg4NqLi+Y5LqODyY+K5HUqD7ESkbFH?=
 =?us-ascii?Q?dZbWuJc3ml482lNZHuG66fBrR9kPW3J+X8HSvk0gBYJB+f+UwQ70HIlSou/T?=
 =?us-ascii?Q?xPEF63Xwv8xTszzdqxVjYKeJQ9P9lvyZF4TsNWEqA5MuYkx1ww/qEsWwT9fT?=
 =?us-ascii?Q?FVxKu3cJDar4LjtTxDmOyN7rz1Whihx3Osl4H8WBprMZ5IgzRR9gBpzCG2lq?=
 =?us-ascii?Q?J+NBRHa2sd0gVhUWLrYugHAdVyMvszIV5rVwEEZN?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04894b80-0d1a-47f8-fcf6-08dc9054656e
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5624.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 11:38:53.5218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EHmwmse/cNuTv0Tp4+3dPNIXqaWOvJL0Ui5as5FslIwwWuk+L1DvQnKnN3ds8ClPl/Z+IxANk9Cs2azWxTsKkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB7085

In binder_alloc, there is a frequent need for order3 memory allocation,
especially on small-memory mobile devices, which can lead to OOM and
cause foreground applications to be killed, resulting in flashbacks.

We use kvcalloc to allocate memory, which can reduce system OOM
occurrences, as well as decrease the time and probability of failure for
order3 memory allocations. Additionally, It has little impact on the
throughput of the binder. (as verified by Google's binder_benchmark
testing tool).

We have conducted multiple tests on an 8GB memory phone, kvcalloc has
little performance degradation and resolves frequent OOM issues, Below
is a partial excerpt of the test data.

throughput(TH_PUT) = (size * Iterations)/Time
kcalloc->kvcalloc:

Sample with kcalloc():
adb shell stop/ kcalloc /8+256G
---------------------------------------------------------------------
Benchmark                Time     CPU   Iterations  TH-PUT  TH-PUTCPU
                         (ns)     (ns)              (GB/s)    (GB/s)
---------------------------------------------------------------------
BM_sendVec_binder4      39126    18550    38894    3.976282  8.38684
BM_sendVec_binder8      38924    18542    37786    7.766108  16.3028
BM_sendVec_binder16     38328    18228    36700    15.32039  32.2141
BM_sendVec_binder32     38154    18215    38240    32.07213  67.1798
BM_sendVec_binder64     39093    18809    36142    59.16885  122.977
BM_sendVec_binder128    40169    19188    36461    116.1843  243.2253
BM_sendVec_binder256    40695    19559    35951    226.1569  470.5484
BM_sendVec_binder512    41446    20211    34259    423.2159  867.8743
BM_sendVec_binder1024   44040    22939    28904    672.0639  1290.278
BM_sendVec_binder2048   47817    25821    26595    1139.063  2109.393
BM_sendVec_binder4096   54749    30905    22742    1701.423  3014.115
BM_sendVec_binder8192   68316    42017    16684    2000.634  3252.858
BM_sendVec_binder16384  95435    64081    10961    1881.752  2802.469
BM_sendVec_binder32768  148232  107504     6510    1439.093  1984.295
BM_sendVec_binder65536  326499  229874     3178    637.8991  906.0329
NORAML TEST                                 SUM    10355.79  17188.15
stressapptest eat 2G                        SUM    10088.39  16625.97

Sample with kvcalloc():
adb shell stop/ kvcalloc /8+256G
----------------------------------------------------------------------
Benchmark                Time     CPU   Iterations  TH-PUT  TH-PUTCPU
                         (ns)     (ns)              (GB/s)    (GB/s)
----------------------------------------------------------------------
BM_sendVec_binder4       39673    18832    36598    3.689965  7.773577
BM_sendVec_binder8       39869    18969    37188    7.462038  15.68369
BM_sendVec_binder16      39774    18896    36627    14.73405  31.01355
BM_sendVec_binder32      40225    19125    36995    29.43045  61.90013
BM_sendVec_binder64      40549    19529    35148    55.47544  115.1862
BM_sendVec_binder128     41580    19892    35384    108.9262  227.6871
BM_sendVec_binder256     41584    20059    34060    209.6806  434.6857
BM_sendVec_binder512     42829    20899    32493    388.4381  796.0389
BM_sendVec_binder1024    45037    23360    29251    665.0759  1282.236
BM_sendVec_binder2048    47853    25761    27091    1159.433  2153.735
BM_sendVec_binder4096    55574    31745    22405    1651.328  2890.877
BM_sendVec_binder8192    70706    43693    16400    1900.105  3074.836
BM_sendVec_binder16384   96161    64362    10793    1838.921  2747.468
BM_sendVec_binder32768  147875   107292     6296    1395.147  1922.858
BM_sendVec_binder65536  330324   232296     3053    605.7126  861.3209
NORAML TEST                                 SUM     10033.56  16623.35
stressapptest eat 2G                        SUM      9958.43  16497.55

Signed-off-by: Lei Liu <liulei.rjpt@vivo.com>

---
Changelog:
v3->v4:
1.Retest and update the test data, kvcalloc performance is close to
  kcalloc, with little impact on throughput.
2.Streamline commit messages.
3.Modify the code style to comply with community requirements.
---
 drivers/android/binder_alloc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index 2e1f261ec5c8..b00961944ab1 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -836,9 +836,9 @@ int binder_alloc_mmap_handler(struct binder_alloc *alloc,
 
 	alloc->buffer = vma->vm_start;
 
-	alloc->pages = kcalloc(alloc->buffer_size / PAGE_SIZE,
-			       sizeof(alloc->pages[0]),
-			       GFP_KERNEL);
+	alloc->pages = kvcalloc(alloc->buffer_size / PAGE_SIZE,
+				sizeof(alloc->pages[0]),
+				GFP_KERNEL);
 	if (alloc->pages == NULL) {
 		ret = -ENOMEM;
 		failure_string = "alloc page array";
@@ -869,7 +869,7 @@ int binder_alloc_mmap_handler(struct binder_alloc *alloc,
 	return 0;
 
 err_alloc_buf_struct_failed:
-	kfree(alloc->pages);
+	kvfree(alloc->pages);
 	alloc->pages = NULL;
 err_alloc_pages_failed:
 	alloc->buffer = 0;
@@ -939,7 +939,7 @@ void binder_alloc_deferred_release(struct binder_alloc *alloc)
 			__free_page(alloc->pages[i].page_ptr);
 			page_count++;
 		}
-		kfree(alloc->pages);
+		kvfree(alloc->pages);
 	}
 	spin_unlock(&alloc->lock);
 	if (alloc->mm)
-- 
2.34.1


