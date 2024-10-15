Return-Path: <linux-kernel+bounces-366897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C40A99FC00
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 01:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F7981C24411
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 23:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73AA71D63DF;
	Tue, 15 Oct 2024 23:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XmZVLvVh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yMbC90aV"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B8621E3D1
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 23:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729033300; cv=fail; b=RJK1FU282wOIS9QviYUEln7Ks/fTY8w458lLMd/vSBNhUdgZ5B036wF3dtDGynlTXYJmGnd/ozqHU9EAA4ERHlKO5abyk9XUHr3++xoR+frdUpejbRHu1djMaGGUJD9DHP+m4TUPBxImb1J/G5FXo6o2DbO/YjWcqac+v80bFhw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729033300; c=relaxed/simple;
	bh=fuIbBWyw8kidJ2+Zl+tp2CZvBm9zLW8Op58/B43MSLg=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=rlaLNujSuLFNO0ihGv0B8zC/w7yTIJi76Yy+bb0UlAdalAuLGSeYsA19R4kg0NONf2qAJyC6fasnI+ZgH2vUGoq0B5RB/rgbXERFdaQsRfqJJBVqq9K9f8PqXXIPN93o04YLIn6WAxdBKUQOYyV+QesdB4RKFRReMPoNip6VGv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XmZVLvVh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yMbC90aV; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49FHthwR023483;
	Tue, 15 Oct 2024 23:01:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=fuIbBWyw8kidJ2+Zl+
	tp2CZvBm9zLW8Op58/B43MSLg=; b=XmZVLvVhLvjY3qvtcxpI/pzwOSumNgGWxy
	qF1aU4LQbwQU2d3Ef0b6paKj8OwoeWIcGFhD4DAxvW9YF5AUmw9JKhXqhf3TCPyd
	5+kURBm2e2QyrGOkvw0tSxEsrWEgYQ91cdj2GD3G8joU6P5ZZdXlo3wn0mhY5Rf1
	V2HAV9tutbGFI+BRRdjkH3MbbcDsNnYJbi+rKO6OY3yNhWxaOSZU501ATqWxpjrh
	Sxg7DZ4gyqKVnLeTU6S9q4/uvIZ0LDzfwQujj69dqiPlxX9pQs2iCYwj7cgXs4BY
	9q/G0GLe6B2NC6C1hOMEufAinGiHi0ySlBmoCHeT8eD2ETt38oSQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427h09hxff-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 23:01:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49FLWOls014021;
	Tue, 15 Oct 2024 23:01:18 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fj83a3h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 23:01:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lfkKd2UML1CPNirDyR4PEnB2V3mCIz1gic+214nlDsejlLKpS5LSGrUXAoBnQ+lrYJTPLO6q9GRBi9d4n7c1vUXF9MSGvuDtO/SDBIyBoiHizNQSb8EYMxJwZs7JVk3TnoAKGq3abKEt4W9bdozV1urzJi+HjfYfELbwJuVhUQH4N6z21QwxyS4/KoASouNm/99PTujSHT7hWE9QgUvnblR8fxQ72eq9MWTK38ZJJzOlm7M2j1TpzbQouMQ0d/yd41LGKRBbc9s4DKb31TNs46B5THWIfcRQF+KAf90nzY0BfrRDjjmr1KwKnXa5icnkpEAeq/5qCt5Y3hayXCP8uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fuIbBWyw8kidJ2+Zl+tp2CZvBm9zLW8Op58/B43MSLg=;
 b=HWg5Qzoy483LCRiaIovH6p+rJql+75/zIdtUWgPd9Yqc+5qbbt1Hesd6pAsP3lhdGQDaLfuhcwINZNlG4jW+hLBfupQYXyYPzhMuouQiXVQLS5KMNzjEILSqYp97APuDkGARDlsN3QjgUYG/YS2khbyxM8e6NuLsROl78KGXXXwGL3Ki8Z2OPYLcjwqs8a9CXpko1K77vdYNhz5teDU4HSngg/KIalEZ0wYF/0mUtbzsYCrg9GilPfyUzhxKdXAvNYMq/XYTxoykw5Nt6vmKH6AIF6Ts9KAfidOxrD7PBO9SvXRzyDLlhvh426jpGXl9QaqvfCvXKoaN+PB3NYgLGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fuIbBWyw8kidJ2+Zl+tp2CZvBm9zLW8Op58/B43MSLg=;
 b=yMbC90aVCKUm6l32oFCXpux+X41JtaMIjSSD37h+8bTyEqG882zWmZ6n4clue5cCezoobzdCQZORv+wr2e6LCL1VNI6ld8xahU7oyjhEvhI1gYBNvHWqzUV8OXibv527rBnT08lGXYpJI+TTk30RjCyelLTa5FJfarCCbrLik08=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by PH7PR10MB5879.namprd10.prod.outlook.com (2603:10b6:510:130::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Tue, 15 Oct
 2024 23:01:15 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%4]) with mapi id 15.20.8069.016; Tue, 15 Oct 2024
 23:01:14 +0000
References: <20241009165411.3426937-1-ankur.a.arora@oracle.com>
 <20241009165411.3426937-3-ankur.a.arora@oracle.com>
 <20241009180117.GS17263@noisy.programming.kicks-ass.net>
 <37af80bd-a54f-4ee4-9175-6f0f27b685a0@paulmck-laptop>
 <20241010063207.xIrynIqO@linutronix.de>
 <20241010081032.GA17263@noisy.programming.kicks-ass.net>
 <20241010091326.nK71dG4b@linutronix.de> <878quvamjm.fsf@oracle.com>
 <20241011075843.WABHhY70@linutronix.de>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Ankur Arora <ankur.a.arora@oracle.com>,
        Peter Zijlstra
 <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, mingo@kernel.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, frederic@kernel.org, efault@gmx.de
Subject: Re: [PATCH 2/7] rcu: limit PREEMPT_RCU configurations
In-reply-to: <20241011075843.WABHhY70@linutronix.de>
Date: Tue, 15 Oct 2024 16:01:13 -0700
Message-ID: <874j5drmx2.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0070.namprd07.prod.outlook.com
 (2603:10b6:a03:60::47) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|PH7PR10MB5879:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c68ffab-1fc2-412b-215d-08dced6d4529
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+Tz+aY8Wn3178NuBBfueLNroh+D+NecEQVTBg3h4kBBKpUimeivb7ZbkTsDx?=
 =?us-ascii?Q?nQRFYIl62CR5uH1WdJt+VLYPHduyn00g5QkaZK2+NG9QaUruLEnZRuv04Dni?=
 =?us-ascii?Q?mqZSYgQQspUyi7L5aADb2S52nXVqsEqpAc4YVlR+m18rJdLbTgmKB/Kj9wqo?=
 =?us-ascii?Q?9DlLT/6kGYyV7Yw+pQKfvH0Y4QP8BNw5UeWr81CCEuIriaEUUJrkuvL0tlRK?=
 =?us-ascii?Q?VTHo0/twFf5Nw6zEio5zCE9XCqXJv3Ak0z5f473mdaTdOD2eWRDid6Lb1bRV?=
 =?us-ascii?Q?8+m6CK3UBOsis+Ctx82Ht/hLixF6pgOH8AAD2sNP5jCORiMOmtaFeVcFXEpX?=
 =?us-ascii?Q?Hv+U8OHPZ58xmtm1ygYwUj6m78SbU4GZTk21X5Zk4+z91f2J4KYGHBtfVL6j?=
 =?us-ascii?Q?XMydAaagJKmYnB2nD0oystTM08uCNQu+vRvcy8Rjd5r7vaLoxHJGLJUyV5uc?=
 =?us-ascii?Q?ekKU9tEx93HSqEvDqv8XLxxp3dF0RlBawkwq0VQUkx/IdvWE+klTuQ50J0ue?=
 =?us-ascii?Q?Qd9Bv9I3pjE/PVFJIGKqtfB8ODHH8eQ07XK3JOMae4NXFhQZxI7r110TsXJ1?=
 =?us-ascii?Q?B287M0GcGWYU+r0nka98ECyOFxgjZvLQfVd4cfa/DzluIZVPyXy4Kh4yn3GD?=
 =?us-ascii?Q?Y/NZfSz2dAg2J+bU9I4WsalFnjmM5SOUOtZyS3Xap8xUID8xVtUFTcYn218U?=
 =?us-ascii?Q?7kaKWEHkTtD6PswfdGw5pNjM8F94ghqScbjPr8BFuWoUp4S0PasWMS20owPe?=
 =?us-ascii?Q?v0lMGjBfFbA6zHqOZ+TtucAVqAmIZ+XTiWyQi9ULytzeG5mKyWv3jnvAAZVj?=
 =?us-ascii?Q?L6Jx7t+K0s8C7fjOhoE3EgxNmdqHloO7WAG95TcUM1zOPyPtG8clDPRwX4Xs?=
 =?us-ascii?Q?8JnAAwYtKJYlPHAjlo6kyfJCBepJJTldnt/+eTcNM3SCt1qrm+NrXBFfNkc/?=
 =?us-ascii?Q?krkDpmKiyqp8bRbJQGgFfVf3h516/pdSod3g4IFEV168nu6N/PnTmoumX5cr?=
 =?us-ascii?Q?KX6Q53j6wXZ5P+oqAWU8fDZIYWLKdW4nLyN9oE2eV+mHVQTmUVrt0gKdYdUk?=
 =?us-ascii?Q?oc465ga6D32Ls+fYXmp9Km3M3X/pUctuKUyukpNp4eGvRsuFDRVrtvmRJJJu?=
 =?us-ascii?Q?zQWGudfVnORRw8pKUEjsBlZV6c6raB2k+5gzORZ/cu95jtyBbB7GwmrDJ8Hr?=
 =?us-ascii?Q?bw4YJ26hva3KoJxQcjjaYQsslb3ej1ape7VBTFhYmHZbWbCu8rpgDxOgamAh?=
 =?us-ascii?Q?H3qPLxpb0/3RFeUIDS/v67rNVzkXYxk+DwzMCUjGSA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0SvK1Mo3MOXcM/K/XNpOKDBtreiAeO1Tdu41rzKerNQsixJWHdZfXxvTJeth?=
 =?us-ascii?Q?lI1JHi9cyHNCENVlEhEMT4vePcrW8sidMR9Br1WN+rToo0PAN7jZXHsC6byf?=
 =?us-ascii?Q?mE1+vxnJwoInkmY7xUhnMmhoNqVC9NcNDIBwpQRGwqWGZd1pMG1cbF8Iz0PF?=
 =?us-ascii?Q?TJb2+OLQDHGt/yu2eHzb1XWWGJmFiIAr/lcuKofTANtLBMbeSX3WTn0ufJeW?=
 =?us-ascii?Q?FMV9v5U3h5sUrZUc8d09U1ScnHkLj6pmx15W1mkHu4+FI4s3mBnJsFUafXf9?=
 =?us-ascii?Q?cppn7Qq/r1zDB/ZWm17zgbgwIbllWezwL4gCcZYcnIPRQxkyTWcQXvq0c8b4?=
 =?us-ascii?Q?g3zf/dePQEH8yI/iWjx3Yzg33U0DQza6MMD/IIelVmQ2LdJdKDvLl+7MTQO0?=
 =?us-ascii?Q?zXXP6kTjlFalzXbTRb4K8TEN9kcaVkuLv5AgmtFiS31KPQWH2xhCEj+v86WL?=
 =?us-ascii?Q?11J5eJSEAcLRx057xIoQr5p6kFeWlGQ1Cui9S/Nn15AIMoFmZw2DlSAaEVnp?=
 =?us-ascii?Q?rixtcyUz1BtlMivJ3xnhksguEOrQTfIx4A2woxUTT2HlRGqCwSlNY9yS5I9s?=
 =?us-ascii?Q?Bfc7hWSpG/09EE4yTfBLb/Em5MpZlVP8on2fcEDyeuABStuI7jlKxfjuGTp3?=
 =?us-ascii?Q?ALQ2djKWIas9/gVPRFf1flLKFMCBmAFl4qDj3MjtxCdLDYuLzJRMEWIM5rMd?=
 =?us-ascii?Q?ox0W5crfUXli7/5zkSLukxccuR39TphutiMRGZFq9cN0Oq0RLvsbfsYLOWz+?=
 =?us-ascii?Q?L9HWjK6w6oUznu2XaXfjS3f/gIyWmxXWSQ0t4+thXBnj1iGVR9XWCGk8Lr5/?=
 =?us-ascii?Q?/1trGQZkN4DKcUbE8nsbOK4Zlgm5u3zPy4zx/xak9n5ZcrPEV2xChs5LLJrn?=
 =?us-ascii?Q?EeFQiJbCWbFYG3hAS60wFrMUoMoa8Lw7ZhEDu2tdm0M8jwhEo1eQ8vydkro4?=
 =?us-ascii?Q?iPVdVwuVhQ58KdeW7wlcE/iro2Eww42oW3kHk49ldJLI+OxMfWhkhKN0nb7c?=
 =?us-ascii?Q?j8BchkDeJ1ucapNbmHWcpdRiyPTq5CuX5qoUu0IT9xHarnA73Vsl+wXs72dr?=
 =?us-ascii?Q?g/CnR8s8SYt5WZD68XIFSgplOQZV5MhTGuVkPp0/jhpvkrS/V5dbGApyHV11?=
 =?us-ascii?Q?mU41nvXDNnDphK2QODxXmluinyikSS363FaOFzJA0scoDSSusSiHLg2UGhJK?=
 =?us-ascii?Q?zFfRuWDRif+hhizt4+bgAlMuGvLkNpuD8viXU8rzQX6pFbOjVKXyXG07dTya?=
 =?us-ascii?Q?pj/pwpIQzXKd/8wcNNO4ckoOM1SBHSd+u7NuZ1Wq7Ic2viyKBVijGTL0Z/wc?=
 =?us-ascii?Q?mHRC4xmapxs/YwE4kB8VifV7NpgFwX5fzGacVARjnABEmw8nU4psYLhSAu1P?=
 =?us-ascii?Q?QrG5yktej29HZckkKkXDLxTCGDLWbC6dAFELc5yBYYUYuc+0l6wWxvjvH4ZY?=
 =?us-ascii?Q?vvvL8x796bn/EfoIx2F5SJod3hlqMCmUVke8nd1q0BtDLo53KgtWcISiqaNw?=
 =?us-ascii?Q?2JmmUfW3TRQu563RrN0FUmzwdtV/U7RjiTWn0QoCZ+xbT+RpgPPqKyBIN/mq?=
 =?us-ascii?Q?nyunmXhNmwYOVxAJyv6p9ehvwgz7tpaAKMjqa0u6pdfLq049l2xddTIg/1gV?=
 =?us-ascii?Q?xw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	31O0/cJ4iIjCvobbxBK7oVNnr8TI7RuDG4wW5u9D8f9t255rVDkpbs4n6pflCsS02E9hO2xVbyz2z2L/NsWtHCwjmksSXuctmXwqj64TAkBAT6sHNQowmMBf1Utb3VGkfrVpdpVIzDf+xUwntCjkjeieR5B76U1h1a60ZJYpQmzf5zKpUhWjfV2Talq7XT+sV2i/xZ4XALN9wmHHjlEygWXt+eNb55N6eyAZaG/4k+WcDaVNDt+CL463KwurcPKIFeTpb9nt6OJNEciYZltYIJN3LXE33vqis8Vv9zDW0ETeIRMjtNFH2odQwgIjlaypdcJtaJCzeVAOKsKAWB6iLhd4uGe6JzZVCHiN0sgV2b724gzsWBWs5GdddHqS6vv4XH4OOpyNG7VJ335zn4yA1mYD+LjiRyegAzrT/BrKJmG3OwdKx3SyCGhuVkV1KPskyslYE3lE6xb5eIo6WK77XNgbVvWsBeXb+TT9GQ0xHWLN+F1FEKv7mBkPyhT5qUd5nOgHRdj9dtfagnvj2mM4NuwAyUWPsn/2jotNCHuXoaxCTBuF3gtoG2kem92xrqEmP49H+V5UzR9pHYjydnf2CR0B50bTZqnOx9tBfohHYnk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c68ffab-1fc2-412b-215d-08dced6d4529
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 23:01:14.8770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n2+etZUwdPcdbaGdLsf2p4CxFUzPcnmPXqy/b/kbrpJVXVy0ZtzeYC0e+2NHymBo1b4I2vdSpPnkbFEjgfrNi+wg0gQ1uOqkyMTc9imdZ7w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5879
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_18,2024-10-15_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 mlxscore=0
 mlxlogscore=890 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410150147
X-Proofpoint-GUID: _jVJgiCjiAZzS622kgPzxMSmV2I3ldbU
X-Proofpoint-ORIG-GUID: _jVJgiCjiAZzS622kgPzxMSmV2I3ldbU


Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:

> On 2024-10-10 10:35:25 [-0700], Ankur Arora wrote:
>> That's odd. I have that exact configuration (PREEMPT_DYANMIC=n,
>> PREEMPT_LAZY=y, PREEMPT_RCU=n).
>>
>> Can you share your .config?
>
> Sent offlist.

Thanks. So, I tried the config and your config enables
PREEMPT_LAZY=y, PREEMPT_DYNAMIC=n.

That forces PREEMPT_RCU=n.

If in that config you change the preemption options to
PREEMPT_LAZY=y, PREEMPT_DYNAMIC=y, we get PREEMPT_RCU=y.

Is that also the behaviour you are seeing? Seems to be doing
the right thing.

Also, quite similar to how we handle the PREEMPT_NONE/_VOLUNTARY
case. And, lazy is meant to have similar preemption behaviour
as those models.

--
ankur

