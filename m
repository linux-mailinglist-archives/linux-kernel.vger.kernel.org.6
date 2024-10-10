Return-Path: <linux-kernel+bounces-359645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43CCA998E80
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 19:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B12F02809AA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 17:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D634019CCEC;
	Thu, 10 Oct 2024 17:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="c/kbUF+4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iw9G0SsT"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FFA6F31E
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 17:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728582168; cv=fail; b=e3aOL09sHmOVEyZRi6EXQD/xLcQm1JZgcEeRSGWwaBdd/YPigwxx+2Pf22zalH63XhVu5GFmc2aTDmzKj68Ola6IyqY6Yrtn+6y0fFRKQ1qiJ0GcXrrJKmnCMnkPwAublHo1Ul0j4r+KBvqj5HTDU9SYeXurifFXheI2q6kA5m8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728582168; c=relaxed/simple;
	bh=4cdQUoGgoZfJWHmxRz2dj+5s1NV/va7bU4y84+aOqY4=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=SkTujy4y20dcUl142tH9MJwIReSj/iz41XGswn3dutbxdPQ6psDC8bfxxuLSUHGwFvCO1CZcdVxUf9FqEDJ09slKOpLEo6WkhUOcnSIuxkvdXuAj7RsMaa6AfqwDM+/IK/2PdRNzD2RFMK5u5MKkxSTL1PZPmaLz04lt82Aevqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=c/kbUF+4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=iw9G0SsT; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49AHfaLV018462;
	Thu, 10 Oct 2024 17:42:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=5O1ov00njNXG6zNqI6BLBsg55JG6sVnBXC3+AUSS6ng=; b=
	c/kbUF+4PUx5Eug8VRoO1WXcg2TsP1MAV1n8CMA1dl+0HNWwkuXLVGMHbp7GRqcd
	qsGLKUtVEfTjTPTHAwHPOv//2HDu1WDy2WUD0FK12eTSTcTwudSNrjVXy85vEWIg
	yMhUwWSYJUHvhfl6iaprAnkfLiuad/A9G2Mz0UsIZQqdXG+13LeZ0rfrzmj04TOL
	tt3UfvnKyMkjarUz3pHq1r6iKmB4EbplxN+9ehkvJSM/t1wrYLWFpOVD1zCUNkzY
	g33ofoPyl6MOTyYyvsysdGydh6WwTYyc1oTLd7DnmEjGbzNOlZ7FSEkEsZfb2fLF
	QexIYvY2t7TEi9Cn6xrTrQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42303ykbb6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Oct 2024 17:42:17 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49AHFto7017337;
	Thu, 10 Oct 2024 17:42:16 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 422uwgptc5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Oct 2024 17:42:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DEhX2p/ez8u+DOkihW+trymlsR5gQ+1y4VTDVYIwuELmK+ivYJWkHDrMUImtkZhCz6TToj3BYatLG8aTMWTijrm0tUS2G1RIBbEGnegJnH+xD3lornZd52KrhyUGykQPD3pAxHSCty/8PFA8LrSTSsYePqEzburGmD5wnOrly5UcVZgebSpKyC/szSiXSQUfAPEbABBybncdHf6FFsZ7qjdl0XuidwjR1dVZc0hoey/D2w7BAZOWr9Y2TzREC0V1jzbtpcy0ngC2AnGpueFpoMC7yl25vEszNAXkAkwEU8o4JWA2IOaOn7f7vfcRLFmGJY/PLVHNgVQZA8Nht9mgkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5O1ov00njNXG6zNqI6BLBsg55JG6sVnBXC3+AUSS6ng=;
 b=zFfr09ew/aHUkAbDFdvKVltchhZxF6v//qEZWuCfldtQgZBeA4CsJYydiHBCNy84RLk0wbY/avE6rkT19hXvwDHqRfvW3MCjoYbIaevwZ3XAMp/527YIH7LeTXEJxwX9gb/2HvZ2dz6RU7vlBg3VbOzfKPuxFeQLS09+CykKoh2TLT/hqYZObBtNbDtkDMSI4q9crgap1X9R7uItH1K6edez6/Ck7OG+v+A/Hg3dMPa0/z/tOOaaK2nfnaL/rsUx6u2POWTAENmIrQ2+edwhrQvXPh+oNR8nD8kmszngzrQo0qhHYyzBL/HJqXnoYqVSFtER4gRxPyoDMj2TFPrLhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5O1ov00njNXG6zNqI6BLBsg55JG6sVnBXC3+AUSS6ng=;
 b=iw9G0SsT+WCc8GH9GBbstcb+zlkMvUKZ2ZpjXv0aUbCGhvq6peIFCW8KXB49vYSaj+IESPmuJKXTMcmq4NugX4r+c/LFgeCR2/kt1cZI5AEMU53GBdfPdLXY5z0gRnQgflp2h0oWrad174p0ie+twmKFj5necP62VnpiBmPYgO4=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by PH7PR10MB6309.namprd10.prod.outlook.com (2603:10b6:510:1b0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Thu, 10 Oct
 2024 17:42:12 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%4]) with mapi id 15.20.8048.017; Thu, 10 Oct 2024
 17:42:07 +0000
References: <20241009165411.3426937-1-ankur.a.arora@oracle.com>
 <20241009165411.3426937-3-ankur.a.arora@oracle.com>
 <20241009180117.GS17263@noisy.programming.kicks-ass.net>
 <37af80bd-a54f-4ee4-9175-6f0f27b685a0@paulmck-laptop>
 <20241010063207.xIrynIqO@linutronix.de>
 <20241010081032.GA17263@noisy.programming.kicks-ass.net>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Paul E. McKenney"
 <paulmck@kernel.org>,
        Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, mingo@kernel.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, frederic@kernel.org, efault@gmx.de
Subject: Re: [PATCH 2/7] rcu: limit PREEMPT_RCU configurations
In-reply-to: <20241010081032.GA17263@noisy.programming.kicks-ass.net>
Date: Thu, 10 Oct 2024 10:42:06 -0700
Message-ID: <87ttdj97o1.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MW4PR04CA0363.namprd04.prod.outlook.com
 (2603:10b6:303:81::8) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|PH7PR10MB6309:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bda41aa-eb15-438e-ea5b-08dce952dc84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SVVpMzEzQ01sR3hQcVdCYld6ZXRjS20yOHA0NllXOE5nNTFxOFpYUzJqOWYv?=
 =?utf-8?B?dTVHSDRvNElCOWd2cUlFTVNKcVBDcXNDRlpON0NxTldKelBwRmFtSTRhYnNv?=
 =?utf-8?B?MkN4QzRIRFJDaEdpbW1VNTQ4blg0aHdseG1nbFlHdnRyVjZRbXViZU45Zyth?=
 =?utf-8?B?OFpzWTdzK2tFMUJNL21pVzFHRDBMdlRyNVJTWEp1U0dHK3pjUHJxR3BLNjkv?=
 =?utf-8?B?YXVUeTZzSW1UbzU1UXhDYnRjaVhRSjVTUVRyMHVNaGFDM1Y1ZE9XK1lSdzlQ?=
 =?utf-8?B?Rk5iaE5LQUVjbXppK2F6UG1KdmtvT1hFcUN1U1M4bDF5dm15SHIyakl1dlNi?=
 =?utf-8?B?TVplWHE3Zmc0U3JUZXdzbmlkWk00NUNDT1NqNXdPTytabysvTnUvQWZuWWJh?=
 =?utf-8?B?aHNSUHI1THN4MllEM3B5MFl4T2lscHk2TXNMN3JybG5hekhWVHVuQmwvUksr?=
 =?utf-8?B?SVpnaWoxMTFKVkpqclFzQ2FveEpGWHdGN0l2d3JuUW9KSHFkazgrVWljOGtn?=
 =?utf-8?B?djlHWXhkSHNiNjNCZUxsOXlQblZ6Mm5CV2ZOdTgvelBEV2x3NUFzOFhFWTFZ?=
 =?utf-8?B?NXFNN2VTbEVRMHRpL2ROWW9vazNQU25oZGJKaWlVc25QTTB6dVczaXhHU0RK?=
 =?utf-8?B?T2J6WkZJNlFSU0ZIMzRWZkx6ZDYrUXNoT2tUcXNXa2FhQk4zMmxHdkd2NEgv?=
 =?utf-8?B?U2tkWDNQY0xXR3lXME9ndUUzNmFNR2g2V2NleDRhaHhJQlhOeDdOK0NRUXRJ?=
 =?utf-8?B?WmJyWE9PMEtWMFpmdXMzcmt2emlYSVlwMkZsRWJNem1OeGcyajArNnFsVnhQ?=
 =?utf-8?B?R1JPWThvQUlqTktTWWNvMFJMVWFmNngvZERJNUlUczlOWkxZeG9uZklnbXc5?=
 =?utf-8?B?a25Lb2ZId2xjMk13RStDYzJtSFRQVVo4ZWRGZnhOU1Q4OFJBN0Z0Y093VEhk?=
 =?utf-8?B?TFVwMm1XVnVEUUJ3dEJueXpjbDFzUFNiN0pqL1JNRGZ3b05kWkNkaUliWWNy?=
 =?utf-8?B?R1NuUHcyY3hnL1luNEExS215MEtDMHlqbkRJR2IyUWg0dWhLL3FrN3FXM1cx?=
 =?utf-8?B?dlVVZFY1eDBsU3JjdDhFaXBGbWxlaDFuZVFiQ3didkhqdWpDSHVlT21qNDlZ?=
 =?utf-8?B?MUNyaDJuWlRVTEpqc1M5eXFrcWswZGMvL3lkMytVNUhGWld5S2kxUGNEYWI5?=
 =?utf-8?B?OWRYYkFicU1tV2dJS1Ivc0w1dFkvYU1LWDVHY0hMSkhKZStWN2FHeVdOb0xW?=
 =?utf-8?B?WkdpRFI1ek15TzVWVWFSdzlQS3BHWm9KVkFrdGNXc29NOWZYZ2p5N1Q3WENQ?=
 =?utf-8?B?Sy9ib2w0dVpGZDJya3RyYmQ1OU53QkZQUSt1ZG5EbzN0OER6K3A1M2lnNHVh?=
 =?utf-8?B?bFh1NTI4TmJ3Znppd2YzWWFsSDduUy9GcEJmRE5Qd3V1M0lHaW0rRzkzTzhQ?=
 =?utf-8?B?c0hvMDRzVUtVN3RuOElZQStYd0xHUUpTeGhNZmZ1Ri91cHlnVGFpVzAyRW53?=
 =?utf-8?B?Y0thOWt3VGx5bUNqRkthSGdTNDFZVmRKOGJPaHdDK1JjejNZbHhkVFRIWFEr?=
 =?utf-8?B?c0hGQUxzMlFjK0pmd2t6ckNvZUVsb04zblE1SGlnT3d1a0xMZmpWNDlUV2hx?=
 =?utf-8?B?UW9RUUMzUStXKzU3RkJmeGRRZGpHamlwRXNzMzlqZTI2QzdiQmxaUGtVektl?=
 =?utf-8?B?QVZoKy84YTNZWDh4a3VKTnRiUUJoU08xcWpMWmo2ZU9EaUhQNE44a3NRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cmlIdnN2R2pDV2h3Ti9qQmVKb3VKeDNnaFhOTUNBekszbndZb2hETXhQcWY0?=
 =?utf-8?B?QnQxYTBxWmgrZVlQaTQwRk8zbElacVk2T0ZITU8rL3lzUlRDRlJNZjh3dVdn?=
 =?utf-8?B?TWp3YnlJSE83ak1PUnVoamJDUlBIdTZNZk4wWE9jcE5HRXRoT1NXbmEvS3U3?=
 =?utf-8?B?TksxZjkwR2FuMEN2dkpUT3ErcmxpcWhRWTdkelk3cUdFbmpHSTdWSGtTeHpq?=
 =?utf-8?B?M3hKR2NXd3RzY0NrZkZSejlqSkVxM3h1dDZhYm5yVTcvamhVa0Z3d2t2a2c2?=
 =?utf-8?B?M2k2d094L2U4K09xTW9WaWwycFprbGRNd2hYVnlhM3lyeklkT3N0QmRXc2tD?=
 =?utf-8?B?aW5wb1hQb0NYdXJmVGhub1ErblRYd1FJY1F2SHpLdXIyWGtjT3pFU3dtYURx?=
 =?utf-8?B?WFVEMGo1MUJhTDRkL1BrVllkMUlnSzFkVitFemVhSDdxTUd1ckpzYUlpSlV6?=
 =?utf-8?B?OEczVEhocHFhNEpUMTIrM2hPbFdpZ2RVeHVMUWVNdElETi8rYXUveTBrZXNW?=
 =?utf-8?B?OTdSTDh5MnloK1BJQ1R4TzNoSUxTSVY3elJydS8vUndNYnZhd2VtRkhBRTRy?=
 =?utf-8?B?dDZNRjJRdjRZeUZlQXdObFlibDZaeXVJNmxPQ0FQaG5PSDR1Q0hSVzQzOXlv?=
 =?utf-8?B?QmhTcVUyb0hUM1ovUklLR0VBbzUwNXNiOGZLcTdMejdkTlVNL1RCaGtxYUhN?=
 =?utf-8?B?enRvV2tkZk5xQVROaHhrQ21YZk9KQ1NocUtVaVJuSzlQczFHVXNNRlQ2enE3?=
 =?utf-8?B?cUxUVDdzNmdQYVF2bkw5UHZWVzFnWE1yQmpmNDFWWXhOSWJSczB4YUNPUEZj?=
 =?utf-8?B?T2p6aTVUS2pWc2hoVGU2VG5qMXk1SmVhRWI2eTR6VGthRVJIK015a2VhVWJs?=
 =?utf-8?B?L0tqVUI2MXdscXlKdHB2a0lBbDV4LzFYRmNnbTZSTDBiOGRONlFNK3N5WVIv?=
 =?utf-8?B?OFdPNW5Xc2lCVWZYaE82Wk9RbXFBY1JlMlJTRVpmTVArL21zODBzb3FrR3Zm?=
 =?utf-8?B?UGdXN1JONndIQjhaeXhsQjdJTHRjMnlsYmRLd3EvR0l6RThjelovZmV3Mktn?=
 =?utf-8?B?Nm85MjNlR1BNelZQL2JObXU5SEVFd1hQTUw1TlBTRGM0clQ1NEdmS1lLeFIz?=
 =?utf-8?B?YnE3Z0xLanVTUkMwMm9UeWVlS01vaVRMMEcyT3JKZVZXM3pyQlAzeFI4enpu?=
 =?utf-8?B?YUlvcnkwVmIzZ1c0UHFHN21GSUFzQTJLYmM2eE5KdHo3NFVTMVZOaWNnSngw?=
 =?utf-8?B?cEJ4QThaY0F2ZUlBTU1zcGpxcFRHQ1VNV3RRU0prNWZ5RlRicUhxcUdCdlkv?=
 =?utf-8?B?N092c053OVMybStVYld2VWd5MCsvZndydmJ2WDk2ZDZFdUNwdE05eDJ6V2Z3?=
 =?utf-8?B?VjZjMWNrZXdvYVhYUnBZbUNuN1VkdHlBN0R0RUZoVU1KZk41azRvVitjMUhI?=
 =?utf-8?B?dkNlRVNmOHhjd0ZqaWUrTFhRbVBCUi84L1pOb0puNlpLYWsvVWVUNXQ4N0lY?=
 =?utf-8?B?dUNESGQ1RlFvb2RsdHNMK2wvMmxHOWl6K2cwWS9XRWkzMDhlanREbSt0Tk9F?=
 =?utf-8?B?U0xwOFNaTnkzbVBNTkJPUTUreDdoRmdyalNmKzNHOTV0ZzF1dStoMmkrVjVD?=
 =?utf-8?B?REp2ckx6YUlhcERvQ09JVlNNS0dYRkk0bkJ2VHpZd0J2WVdmSGZrUGMrdUE5?=
 =?utf-8?B?M0hVeVRnOGtYcHYxd0tqbVk1WlIyclpnbXF6QitJMHY4ajFhdUtvZGFicUx6?=
 =?utf-8?B?ajFEcGRVZXlsbTZSekZONm5QdDdqQzIyM3Z5UFI1ZFBvN1hjSmlGdDVYN2JZ?=
 =?utf-8?B?dW1uTkpCc2VDK2Nsall2bkNwalE4RFRHTU83Q0J5YXMrT3hUVDRSQy8xdG1E?=
 =?utf-8?B?M1BuUy81OWRwSFp2M1NTU3BKMWczVnJUa0NlOGVhM1QwdFZCdmNBT2R3MFF3?=
 =?utf-8?B?WmU5TE81OUpveUFaRFhxdDJ4ajd0c0N2dURDZUowZzJXdG1odXlmYmQrcWNO?=
 =?utf-8?B?MHduanRKSW5ENSt6OXV4cVBFUlFhWDZUTjdhNUxuRVlBZVY1d3NQVEdHK1Vu?=
 =?utf-8?B?T2s2UnZUb09BeGJpOEZMUGJUYU1RTE1UeE9ZUjgvUnpXL0ZHQnRlTDJuMzdL?=
 =?utf-8?Q?f5Z0BEa2/jgDciCFU6ttUfeHk?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fR9N6ttn1xelsMXjiT3FHqCaaX6xgrERNmMTFwwC1w8DwWMn/ZrFG5FEPXwQTGW4M/REtbiGlJ9dUUHviGkssaDOxw/Y5jFUdFqNIm0L15uuTQWhL0j6MMTFDFqidAURdcBe/hf04nlNQjzql61dgPWBCTCc74Qm7Az1WBE3o3pPzDZdU8J1i3AzfdC/P3pLJ4fIDgIkkTqNMNJTy1vSHX4jTrsJfEmgsO21zpn+TBXy66jZCUVG1zwmm+ChH5SXf4E9hCFtvuDgIFFczZ70ZpzS9eNtb7rwP5sMA5FuLjhntEPn9OJMpCtBp2YebCW9LPXGBOp9OK6MTWf4xJbp0vBY13mtdGjeq5TaAhLLrt5/3G9FRgc5B375hPGNX+DrwS6cA1f1D8wCFbBm7q4Ppg/F4MyKnJ5WYdIcB+GW7XSOmKTmgoiJl9smn2EpFBNJnSFYEBV8Uu/4tr0JVpYlDtTVvNGA4JMtWsPnBnoOWOkFE+k6S+GQI5UyRpoh9VPwEU+hRFr6NjLQfrOr6fF/Tvnb+SihtJCHj0sStYOp9bccRRCzzWAgSxS8Ur5J1C0weesUXrwB8LSfS0oRzjFOJ9//r8b2twsDAChmh3XwWzk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bda41aa-eb15-438e-ea5b-08dce952dc84
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 17:42:07.7396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /H0qQP6+gKLWs7zo4TslEehMZ8e2BWk/Rwdei/tfFI8RyQpfaGhYOx3OhtmZ0aAffX1qGzN7YUxfnzxTksfFTmEx0uXfxe/9v/bg/04Qxy8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6309
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-10_12,2024-10-10_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=907
 spamscore=0 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410100116
X-Proofpoint-ORIG-GUID: P6uKR3jUbwiWnwUhF9JtORR6UGa2g5fm
X-Proofpoint-GUID: P6uKR3jUbwiWnwUhF9JtORR6UGa2g5fm


Peter Zijlstra <peterz@infradead.org> writes:

> On Thu, Oct 10, 2024 at 08:32:07AM +0200, Sebastian Andrzej Siewior wrote=
:
>> On 2024-10-09 11:24:09 [-0700], Paul E. McKenney wrote:
>> > In order to support systems that currently run CONFIG_PREEMPT=3Dn that
>> =E2=80=A6
>> > Or am I once again missing your point?
>>
>> The change is:
>> | config PREEMPT_RCU
>> |        bool
>> |-       default y if PREEMPTION
>> |+       default y if (PREEMPT || PREEMPT_RT || PREEMPT_DYNAMIC)
>>
>> Now:
>> - CONFIG_PREEMPT select PREEMPT_BUILD
>> - PREEMPT_RT select CONFIG_PREEMPTION
>> - PREEMPT_DYNAMIC selects PREEMPT_BUILD
>>
>> and PREEMPT_BUILD select CONFIG_PREEMPTION
>>
>> so in the end, this change is a nop, right?
>
> PREEMPT_RT selects PREEMPTION *and* has one of PREEMPT / PREEMPT_LAZY /
> PREEMPT_DYNAMIC, all of which in turn select PREEMPT_BUILD, which
> selects PREEMPTION.
>
> (arguably we can remove the select PREEMPTION from PREEMPT_RT)
>
> The proposed change is not a nop because the config: PREEMPT_LAZY=3Dy
> PREEMPT_DYNAMIC=3Dn will result in false, while it will have PREEMPTION.
>
> That said, I really do not agree with the change, it makes the condition
> complicated for no reason.

Isn't the behaviour identical to how it behaves when you choose
PREEMPT_NONE/VOLUNTARY and enable/disable PREEMPT_DYNAMIC?

This option is just choosing the RCU model suited for the kinds of
preemption supported.

--
ankur

