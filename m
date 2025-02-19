Return-Path: <linux-kernel+bounces-521770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C58E3A3C21A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 15:27:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDBF1189A64E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 14:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8851E0086;
	Wed, 19 Feb 2025 14:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lLE3NInE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Wc90P+77"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29C91DFE25
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 14:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739975137; cv=fail; b=j3j+uMRUBwj7fe2PuuZqwlnr1FnN/7RvxJCZQGQanexCAbepa5VxoUSoelIR3ivezIu283KBLN4RlBSShACeA4wfaaESuwfDJhmLVEG4ki5FXkNdKJyVKZiSz15tCBc4AI73ShZWqDHGI/zCGyYZtMmIpy6kQN79JCtHbABbGWE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739975137; c=relaxed/simple;
	bh=9X2p/W8LOkUwu/Gh9apgaxVm0qkbEHZv2X4B6Lz4Ti8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WAV7X2HhWfWQ0daSsoQTGwOiwJOo1jKyugsQN7usTiHuzgyVl7v9t0HKnAct9XG4WabtaQwOgOy2QmD4J+H2syhiN79XPGMJlo+752DAJ++g4PRScO3OPQpKMMrxPRgrkLU0hUZxfDw+l01A24f40DyY+aH1GQO+QWaSSnZuioY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lLE3NInE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Wc90P+77; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51JEBmEj023173;
	Wed, 19 Feb 2025 14:25:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=IRBgCDTTkx695FrLHJ
	9s4a5V7Nbw/Scnf5p5t98ScDQ=; b=lLE3NInEBa1mJGS/MP4NUbvenMDHFrJbJa
	DpXbU2jIEiJhUASX9rcSaaWhQHoz4iRoNtmVwEy0grotqdOIiwXp368pPhXcE1Dw
	e94nE/x2OCn5QGR0bf414+0HTTCNcSQNzGY3dR9Jqge7qbPW5fOiAju5qIOpFaXh
	92mINm0jNgAhmIgP1wl78dqkI6FhFd43ZrDkShxoAUgTpmgTr3P4kXLiiuxO0bOA
	PZRk4q2FPweWFrKZo6INrx/AvkZMhej3clpkiWT3MFFtBnx5EIn5C4nRm+RWFayQ
	p2v7GekElUtmyigl6klVGb+WsYBwkFPyYwld2JGW3J6Hki4sdiyA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44w02yhr2j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Feb 2025 14:25:12 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51JDB0du010616;
	Wed, 19 Feb 2025 14:25:11 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44w07djp9t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Feb 2025 14:25:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lglM4TU0S0HZkXvt4oQA3XjQW/gql2yGbVFZOI2Y3qNjJpj/0PrtZQ6ieqs5wTloBvvyVqj0TD1nUDp28R3l5kgbBZZg/ihmnumdZSxwSV5MMd1d6h4xoUFQ/Zt5p4+FqLnc7b+Gb0ZigPCs+jBERr+wbnzvqaGNkNborDjeq3tEqkuuMZmI+jFJaFinEHvk/sRPyy0KzHGW35QyorycYXkLxJxQ7LhK691aBPYE6+51j+3VZ2j1XZGBYKbN/0k5E3LXw2LQexhMa/Ys8QGGug3Ub26vrEq/tc5t/SdUTgGw98zyRDeZ2zrmJglnzCgk0vOdVLGLlr4mDPlaZYEGtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IRBgCDTTkx695FrLHJ9s4a5V7Nbw/Scnf5p5t98ScDQ=;
 b=OEos/hDQNmAu7NGWbUmTRCZw9PhrbKU15sKJyT+6AWPnVeqn5AsQzYozY4/MgfyWYt3j9iX7RjiSfvY2HZ6I2icQTbcYSzX0TdXENI8c0NOB99B5fQgvtThDIwX8JIHYA5u8NkT87MXi0VbJcrjEdX5vA7xLMEORMtwepohSRWnhyRTXz1ZkKN6Z3T46GM764+xO+C0nPyr8vGSGl3GfL40WXTSg0OPP1QhwEBhVXecP5Hm7jNYoUhxIyKY9fSHwMpnGgRNDf2veM+7gSzJ3Cfvt1uum7x3baZz+T0PXZgAJw5UtKP6tw1U9CKw3sVA0BeziwVbp9T5gJXM2zd14bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IRBgCDTTkx695FrLHJ9s4a5V7Nbw/Scnf5p5t98ScDQ=;
 b=Wc90P+77wke4G0PVCi2/+RiQN/fz3W6F/c9F+UFlpjTyvanW0FltPuqAPIhUTNw60qrHBXIsGo5QU7WQaEuDfF5P7PJW/qy/yN4KI3M+qa7M+2gyJnBOeP7T7dkjWXXuSCkRy/2khHw1bHGgSoPa8W3FvpU/FRjmL+vn3j06ANo=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by SA2PR10MB4588.namprd10.prod.outlook.com (2603:10b6:806:f8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Wed, 19 Feb
 2025 14:25:08 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%4]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 14:25:08 +0000
Date: Wed, 19 Feb 2025 09:25:05 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Jeongjun Park <aha310510@gmail.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, brauner@kernel.org,
        lorenzo.stoakes@oracle.com, segoon@openwall.com,
        linux-kernel@vger.kernel.org,
        syzbot+a2b84e569d06ca3a949c@syzkaller.appspotmail.com
Subject: Re: [PATCH] ipc: fix to protect IPCS lookups using RCU
Message-ID: <uwyzgvvgclj2zdxtmfqvuxsgedqr7b6orpwrzjb47zcdzu4pj5@ylsuqebms5yc>
References: <20250219132905.8214-1-aha310510@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219132905.8214-1-aha310510@gmail.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT3PR01CA0058.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::7) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|SA2PR10MB4588:EE_
X-MS-Office365-Filtering-Correlation-Id: f60b0599-4d94-4526-2566-08dd50f1363f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Htn03/mnlzQ3P5QT8Mh8Fc/FJudlRZtffskwRxPLf4C10SGtNpuN/nD3kDja?=
 =?us-ascii?Q?IjBZc++JRhKq7e5nW6b/TSVCrNE6CO/dLPni7k9KsR72X7hvU1BTZXabrQaD?=
 =?us-ascii?Q?otzbEOt0ggsjQsNHM3s76CumTAhg1zcpDb/qAN9LGB7JnGqxVdnt3dvAkAwy?=
 =?us-ascii?Q?E+yJfKU7d5f/gLzWWS38JQSyaq3rfQ+CdZDmN55Mne+b6JbiRgBHwzYyHNu+?=
 =?us-ascii?Q?813kBDs/SkUYgrZJXyq6WjzE4YpqETmV6Lqd5JfFYhIvosV9LDY4eLpfv3T0?=
 =?us-ascii?Q?QrUcJ3Toe3fH1q6zSuSNYaHYKg+QfMFHM8L6f/1Y9yl/FVImCZTbZTe9G1F3?=
 =?us-ascii?Q?ZFRHDOt5bvvIau7NQvawtsfyLXTZkp60oOKJ7MKOE3QzJOtHvWzgpDsO4xNc?=
 =?us-ascii?Q?3D5ssUNNt9KuXsSDZ079aSp4it86aHtGBWzIlRkiCMeGWoLIPR7Xvtifq1CO?=
 =?us-ascii?Q?qSEDD4CxQWMEghRE2inBI5EiThLstacMEpLBy3mnazF4TvD/S5spLI/X4bJx?=
 =?us-ascii?Q?Tm2hzRXZqdQ//ocB9cTri1HxMmOGZVQpVSBdHhX0yKqDyRGUWfpgKnEHkBss?=
 =?us-ascii?Q?bswYnsW4PbVvzS2NzJTCEAKGFv4oB3HvzW/SOn84k33sBEjEhrgS5u0vpuCt?=
 =?us-ascii?Q?es3Ea0+QT9mGgvrJiWFdyxq/D2OSDpMdqCKdmHt9la2wP3Me+xXQJBpzdu5K?=
 =?us-ascii?Q?8r52Lz2uzKfWbsefDX+4GngCClpS5LpPD4ZMAFLeKUfkvqqsf+J0yLh0uH/h?=
 =?us-ascii?Q?mIYpjiaww3pczq098nB22a+d89HYi/rjvIbpOHCqQpLUV0OPHoV3Air61cUt?=
 =?us-ascii?Q?BooHNg7Pqd0FfsN5OcncAIRgljLcHSlzdw6NMOBLkB+AgAYncVIhVdLX5GPm?=
 =?us-ascii?Q?QM9HbhfUgfRpYsj9gr1HiiBVVlAOAF12E8OYaOOmLqunIvcnUgpZFkiTWXK2?=
 =?us-ascii?Q?XBsXPhptXoLvlloBxz+PPABrR/GaoMFK5thMGSTd1T1aTyt/fsfLubXA/vqX?=
 =?us-ascii?Q?8DenA9++y901fPM8QPKJHD2u2jDvYTa+FrDP3A47gKAV7OA6Y79r2o2jMmd4?=
 =?us-ascii?Q?lLwsKFsh103ZkrZ6ObIpPD7OlGDI0auMyE/HNo7BeWrkvON5pwfiMYQVCGa2?=
 =?us-ascii?Q?gda4Uckk1OR8ZQZNYd1/s1VuQlaRt4GktkK6Vos6tj55/OsVj8zJThYoBhT4?=
 =?us-ascii?Q?La/gOBBaQ/jwkZrIpzEfj/fGcM/7Gtmcd4OklGjlemSBfu+nDro4GPd0PBLh?=
 =?us-ascii?Q?7x1teCe3ItvFQ1trLc7wstZS+cbtK9L1aHtJYyHZztL/2To5V4NTfqdm4vGa?=
 =?us-ascii?Q?vEbn4yUOzXK435l5hSqYqNZexl/wqBhWGleGGXRpN0pE4wNKrYJh/ugbqMVM?=
 =?us-ascii?Q?L+83oAOAFqMJ0W1xfHrEdO3kltB0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wkhafVXClp+VtKlboU2BHfubIofaFJDYdKXJZ881hzy5pdJUpgs/3y7tAF9B?=
 =?us-ascii?Q?bGuHAQkpkUhtItH/Bm2nf1MkNphNUpkJV7jGOY1GsndfWrpDhkC5WWI994aB?=
 =?us-ascii?Q?9jI+c0b7wfpB4WYGSwIFQCgG0ekHqbrAPjFVBIa/A7FilpEBKPonc4uEjoHJ?=
 =?us-ascii?Q?FzxZri02AdBHUcOCbkqXDohMzDk17ww/oGJWBQgkuHu+3xk0WamCEzXW5vvh?=
 =?us-ascii?Q?eFyoXUB6paOhJ4fZbcINmveHih1N/ygjZBo624f5nT/OjTkadcJ4z97Ek970?=
 =?us-ascii?Q?BQDuulL1aQfqmgDa320AcFo7r06mR7jAmM2Rnf8c8w1/o6EkuoJ4HfRJAA/x?=
 =?us-ascii?Q?uWOWibk/RDv9w+rNcZe9XwHfizr1A6XSIE3Ens/cfl0aRAAmwlbb7Dfo0+7a?=
 =?us-ascii?Q?kc4GYJ0FDxqfeCIA2rQ6u3vqPErfGGwxCQRwbfUd3x+uDh2VIGvjelhGcVY5?=
 =?us-ascii?Q?hsQDH1Qr9Oefxz/11iAOGn5dfToWP2aeYz5RWcEsEB6wgBWpSZf5N6mzVgC2?=
 =?us-ascii?Q?YqyH0Nd0pvoqn2NlUBlzQxTd+xwFzmeb/QM7z1TJDAWVAJC/BQj2JGe/v0q9?=
 =?us-ascii?Q?zC1XYKN5oh8nHrbGr581VcupZvoWZSLXZwj6+GzLesI86+x9S2/VVPGLToqC?=
 =?us-ascii?Q?gh10WYPIBJuaWaeHwJkv9mg//g6+ZkmEC0HlGCXrmQcb6sxJ3pJ1epbEIX6V?=
 =?us-ascii?Q?/1AhLPdPM+PQF4eAP0aNVvqhy5d7JH05Zorf3bZNX2M+q7biLl1Uxz90ObrG?=
 =?us-ascii?Q?uNjcKYV2k7+9b2KCPtoRBXxpU6arV7zxHMY9ab5rye0ZqYOD8hd+5Ss02xc0?=
 =?us-ascii?Q?Kl/xZI5rrQib20N6jeNQ/mg61rjgf+zbRogubABlEmPS7SBYmegBsjMKzLU3?=
 =?us-ascii?Q?5gmxkYwYaDXF5LPhiALCrg4jkTqPBJ+RffN55bkkQ1UNQgC0goeahwO/gR7i?=
 =?us-ascii?Q?olePz3+CTEPLavQUwFQtw6QQiUDXy9v3sl7vAWqNeoHrQ0mfacPajr4emeVA?=
 =?us-ascii?Q?sfsQym0DXKZuQ0VapUxZPzrOUXtnrQeyQQ4W8fBK/LbB4MWp7Bl1EFmtIer+?=
 =?us-ascii?Q?8dJLj+2/Ka3dwCs5KVAoEQd6iKc60ZYTyddfKs8zPW4NGh0o09C5LzkLOvdR?=
 =?us-ascii?Q?hwBlqceLaEbRR0vEtEePaCR4oq3+8509Nj2kVfKoKbQmIlQlmeQr6M1rgOkA?=
 =?us-ascii?Q?ryysZPEDkyYUAFid4kOoTBJB5/dMcxGbi5F/LrH4mbVIHmqQGxZBsk8RQtuC?=
 =?us-ascii?Q?SiktuELCCYZTChi2aQXvyxpKBfSZjtdP6nGl7XEkkRKVXhYljFKuVBrPJbQx?=
 =?us-ascii?Q?Ks38LWEKD3Kd3aY1b3QpeyNli0L+jfTp3xuEc1vBu+URk9EP/EmXWmgF+xap?=
 =?us-ascii?Q?D//5N6Hlr/rUcv6s7gR+HQw3lPjBA7Dx4bCoTssDVsF1FqELm2BGYUoGJhF7?=
 =?us-ascii?Q?5fXAIMASBXmCCxxRkXnnxNHAqnoeOB3uTwEwca3pKfPWuE+sjf3QTeKanI+f?=
 =?us-ascii?Q?9dnXBvyEdur59By7cCsBLfcw8ydfkKRqCeou8uViGyalDEc6jNCztZBlN3/4?=
 =?us-ascii?Q?4kryANY6cdl4z0HOtFsohhUNkIn0oluuMHABMDs3?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	a6chGs+GXdqX20gHwqb/kasQWNyR6ybUGhIgLk703egF6vmfqrkZD+yONCE1QrOAg3t238AifPvVirf5arOthqb22m2iobCcQLvG1opSKB8jHYG/+wpePXhtcE8ffhP8hJgVhBO3ZREUcvx5X+3lB3EAJA8yhEpJe9NxYMnFnhIktgc3erfRTBg1eYrPHZQAOgbly/xLlr+S7GTXTGZwjuQG1sdobqux1MWbVeAfma95Bp4Rf1C0M9C8aq02Q7aF2Ks4Si6N6eOq3ZfbafjNzJSaSFAByuZ1bo4K7IQF/fkkM7jRVE7CEpLGpN4LYGav9lWE3uOEe7MGtyP+XVqt2lAQvQCfxJSdsGHIWCFu98MbI2UAolHgbBycrdIcepl7F+Vww3NGxhiMj64TsFQu7X9zKOi4cRHEgRj4rNjmg811u5PNW5iqp9iA2/triR/aY1s8uzwjx1Htn3F8b/yKVKWzO+FIKshQeI3P1yMZe2IYNUM+CUThCFUQNQnmdZKqrY1eg85sMJGHT68thByAPMkx0WU8cbx7TqTZC473nxiabfwRfMw8E7WW5DrCfBGhF1jUfM2HdHZRf6mM9+p2B8POQ2w6DZJhmu1ZK9RrOzY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f60b0599-4d94-4526-2566-08dd50f1363f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 14:25:08.5548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VUlD4Otaz/O8RZP2Lt92ofo6NAPteYCXgvWB1CuzjC/GfybMCDAPLRTMIrpunsIrC13oYiKcWHIomBB9Hw6rnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4588
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_06,2025-02-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=743 malwarescore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502190115
X-Proofpoint-ORIG-GUID: 92YPl4SFsUSXkwcqkhd7Ltj0m7s54sid
X-Proofpoint-GUID: 92YPl4SFsUSXkwcqkhd7Ltj0m7s54sid

* Jeongjun Park <aha310510@gmail.com> [250219 08:29]:

Thanks for looking at this.

Your subject should be v2.

> In shm_destroy_orphaned(), we are not performing updates to the IPCS and are
> only calling idr_for_each(), which can be protected by the RCU read-critical
> section.
> 
> And if idr_for_each() is not protected by the RCU read-critical section,
> then when radix_tree_node_free() is called to free the struct radix_tree_node
> through call_rcu(), the node will be freed immediately, and when reading the
> next node in radix_tree_for_each_slot(), the memory that has already been
> freed may be read.

The way rcu and reference counting is used in shm is very odd.

> 
> Therefore, when calling idr_for_each() in shm_destroy_orphaned(), it should
> be modify to protect it within the RCU read critical section.

Did you test this with lockdep and prove rcu?

Taking the rcu lock has some extra constraints that may be violated in
the call chain.

> 
> Reported-by: syzbot+a2b84e569d06ca3a949c@syzkaller.appspotmail.com
> Fixes: b34a6b1da371 ("ipc: introduce shm_rmid_forced sysctl")
> Signed-off-by: Jeongjun Park <aha310510@gmail.com>

WBN to Cc: the person that looked at v1 for you (especially since he's
already Cc'ed on the email).

> ---
>  ipc/shm.c | 2 ++
>  1 file changed, 2 insertions(+)

Since this is a single patch without a cover letter (which is good), you
can put some stuff here that you don't want to have in the git log to be
used for review, such as:

v1 link
changes since v1


> 
> diff --git a/ipc/shm.c b/ipc/shm.c
> index 99564c870084..baef5afadfb9 100644
> --- a/ipc/shm.c
> +++ b/ipc/shm.c
> @@ -431,8 +431,10 @@ static int shm_try_destroy_orphaned(int id, void *p, void *data)
>  void shm_destroy_orphaned(struct ipc_namespace *ns)
>  {
>  	down_write(&shm_ids(ns).rwsem);
> +	rcu_read_lock();
>  	if (shm_ids(ns).in_use)
>  		idr_for_each(&shm_ids(ns).ipcs_idr, &shm_try_destroy_orphaned, ns);
> +	rcu_read_unlock();
>  	up_write(&shm_ids(ns).rwsem);
>  }
>  
> --

