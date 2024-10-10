Return-Path: <linux-kernel+bounces-359733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28160998FAF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 20:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA3EB28280F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 18:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF741CCB2A;
	Thu, 10 Oct 2024 18:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="o1ykai7i";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AhRMLoF/"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B1238396
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 18:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728584412; cv=fail; b=KKEIkpznRePa/ijyKvVJZYK1yzTxkm55HacYjs0l4R+mLv5fMVM/pD93I/KgIazYz5sN10+ztj4v+OBkmowGMCgErgPIhOdkWjAGGxPyWZxZg/8qQU2vNCrI3Cm2z8VQhWO3wblcRCHGAP4K1753GERaMXNlG4BFeYvlj8Ga+OM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728584412; c=relaxed/simple;
	bh=tsbvYZqwSJgog5DiEbUMr0Kh5+cWXFVboT33zYkQMc4=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=ukGQQFQ/KO9yHFVuvbGkegZifrQSAf8/6hjLGCPcHsxvkpc3t+gr0OvQOuIDu5OkeJfqfhJrCxGPKgvISbva0WEXPr+RYBSHOrLzljrDXYizF0nkAa3lNFeTSqloGTDQEoiroEs8qDF3TTT5BjVVOq2ca42H79CPspREg6CQ/KY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=o1ykai7i; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AhRMLoF/; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49AHtdmS013522;
	Thu, 10 Oct 2024 18:19:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=nWTiuKLd/VWHPhniWxoNRL6nrx40nGnsqbxw30UXhJI=; b=
	o1ykai7i60A1sKV5alrzfb08pbEbDykbxCEuK2xmVsvsZfpOFIVAPn4rgMurWTPA
	2ftUmgKmXqehDzGpltfe4Z2hc4S3iaFT7x3Q3Qdf2IQk96zZ2r1a0fWQasUh+ZuV
	psQ0chXdL9WFAnNcufNmtiERNrJ3enx1dVsV1gzgwHj6yD+96f2XpqMzbOws01H2
	DlS3iO3wqR1+tzQ/JHdrZ5cknIYD8qYK2SDKcwUJxvj0UONcYJqM1k6YcQWXwwDj
	USrIRoTaMQQg+G1R9DUTyvlVt97gNRm/XX9lnnXAezMJ7y3oIdjDM2MES5U7RLZG
	ia2lRWnOuPPEbslWwBvAZQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42302pk8vx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Oct 2024 18:19:51 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49AHINg1009063;
	Thu, 10 Oct 2024 18:19:51 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2048.outbound.protection.outlook.com [104.47.55.48])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 422uwada51-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Oct 2024 18:19:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tykg3tnIOcHkNUaQujTrMV/U28ei+60Wm78bkAcuZTIWz/bFm+PoHd3YE6WsM/OK+1sgzZUxC5cHV6zlklLrFpwUorZ3KnyPCJpZtDHnjeEF2m+WsZTWUf/ulldTx/bbpzHqjbLyejGkmFUY2OV0l6JAM/C0Z8Br+Oqfn+7kEYGzB9HBvIPayfdlIIEcEsxEu3HOCFmQo5gk86KZfjCuUTFlTORtoisrjQUJC0WfiqEG1o1fpj5xZW9wt/cQZsVh8Xckq2RZCQlmg1IWlUatRvfyVcpBxZiL006sSDGqN88xhbE8xvLRjflPrf/yjcNRQcZtbnOrs2Iz+pj9NyS7Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nWTiuKLd/VWHPhniWxoNRL6nrx40nGnsqbxw30UXhJI=;
 b=CJ1AiHxcehAB+M6rbxDpdj3UfqOVVOLlq5vqZqw6KU8ARskWpEmB81j9L3t6/byS/m41c6LsRK4wwOFGkQm/kQ5d4lrJC4M5r0Cprh+Du+J5Wv/5GoxEridbh2WrFvLtGwIvQ1Gdh5u6i3RPfPeQBjrkECOfLQXgI+PNUzLV2q8FyQ/sUMuhLliYuojZQvduTVkIt1ppARn7Ha2Fa1ZvMIfiJZYJW4uvQsWwiPpjX5CQnpVdp7v7DbpgLWWu6A0920XqlthQrDI5QnOJv+cy74SZ5U0+/DE8BxXkH0ZzKKGUJNH1QfoCtQzT/6kmZ9jYb1hASDhcKUExHJVzK2jS/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nWTiuKLd/VWHPhniWxoNRL6nrx40nGnsqbxw30UXhJI=;
 b=AhRMLoF/89k7/UkcgqIl7UqQ2DWcUc1OfcYTyeYEugbazgSVJvWTqt8Uu0NPNvKTd/nG/j+x7nYgGiFnghzX2WMWiTsdxz1QUu+09HtNT8UB0B3IsR+tkw9aBmJq+75RIbm0rHVO2IrsLtrf/E2QqTNIZKqzK680iagmKrQ3DGs=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by LV8PR10MB7920.namprd10.prod.outlook.com (2603:10b6:408:1fd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Thu, 10 Oct
 2024 18:19:48 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%4]) with mapi id 15.20.8048.017; Thu, 10 Oct 2024
 18:19:48 +0000
References: <20241009165411.3426937-1-ankur.a.arora@oracle.com>
 <20241009165411.3426937-2-ankur.a.arora@oracle.com>
 <20241010063727.Ckx0eeMC@linutronix.de>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        peterz@infradead.org, tglx@linutronix.de, paulmck@kernel.org,
        mingo@kernel.org, juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, vschneid@redhat.com, frederic@kernel.org,
        efault@gmx.de
Subject: Re: [PATCH 1/7] sched: warn for high latency with
 TIF_NEED_RESCHED_LAZY
In-reply-to: <20241010063727.Ckx0eeMC@linutronix.de>
Date: Thu, 10 Oct 2024 11:19:46 -0700
Message-ID: <875xpz7rct.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MW2PR16CA0046.namprd16.prod.outlook.com
 (2603:10b6:907:1::23) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|LV8PR10MB7920:EE_
X-MS-Office365-Filtering-Correlation-Id: 51f2aeba-d183-4a4b-37c1-08dce9581fe0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aWpmN1pzd3VFVlBBcko0K1htcXFvMjZkQUV4L1o1VFIxbUhSNVBPSHlLNDVH?=
 =?utf-8?B?QnpINVVaTmtYcGd3bnNIWWgyZThuRXhYNHViM29vd3RzNEtKUDU0NXplZk1H?=
 =?utf-8?B?Vm1kVzl1ckRQTVRoOHJtSTlFTExrbGpmb1RBOVVpQXFZZG84YkNiM0NZdkhH?=
 =?utf-8?B?dDdQbGNnK1NpRk01Q2ZWNXNCQVN1d0ZxN2ljZ0FrVUNaZzgvdC8vcmxKZDR5?=
 =?utf-8?B?UGFDZGVSbytwSUZJMDJWQ0JJdEMzc011NDUxVGxsVHdyVW81Q0ViTG9KL1ZF?=
 =?utf-8?B?Wk5MZ1dKZ1NvZDVGNU4xRjlrNC94dWhBZXhOQ1VCYjEyeGl3dnRwelpwT1Zy?=
 =?utf-8?B?NUYvVmxFUFdZV2pYTnNNdXNOcVVkbHhzN2t5VVJlZnJIV2tOYmYvQ3RLMy9y?=
 =?utf-8?B?cmo5NjBWaktMZlE4MUxCYi90dXVTaWRySzVzc2l1M3Q2T3hZMzJPdENoVFJN?=
 =?utf-8?B?WFdPbHRvU1FMTllRUENLdm1XWmRaZ1dITno3TzJMM0lkdW9ZUDNXZTRtV3lW?=
 =?utf-8?B?eDhydklXUlM4b2NScG9rYmpUUHZ0VHdwaGJKcW1Gd0w3KzBydloxbHI3L0w2?=
 =?utf-8?B?ckpDOXJHSEdadXhaNGlWeXArTmtueFNiM0NDOTdLbWJLV3N1eHdsdCs5TEZI?=
 =?utf-8?B?VlM0TUt1YXBpODBURHpkajlWWlh4MUpOd25PZkJaUGdLbm5sZjAzN2c3YkRC?=
 =?utf-8?B?RXBSWFJZM2tkSzBwRkszZjI4MjE5bUpvL0dnM0lOWnJ6RHQ2cXgrdUg3eVBI?=
 =?utf-8?B?N2tYRW9xVWVOOVhqaHNpNUxMS1dVR0xPSGhzd3V3N21PcXZaZ2FHRWJHZ1h4?=
 =?utf-8?B?ZVlnVnM3eXNKeXVVMDRrRkZSL1JHWUhWb2JQSU01OGdocFZEVFVxbURRaGdG?=
 =?utf-8?B?bU9idTAyWVMxbjFrcGNlSlp1dHlWM3UyRTFJNTh4OW9HWFBzR1VBYjY5RUpm?=
 =?utf-8?B?ZlB3Z3BJRGtqQ3diU3hhaER4Tmd1Zll1eFpQb0VGK2p5YWZpc01MeGdjVmxq?=
 =?utf-8?B?UlAvZXFISjRQRnRKcndFM1RRbnVySDF5amdEWE13RTlCN2NYVm9zeVJUVkE5?=
 =?utf-8?B?YW95eS9zNkFOVE9Nd1NScHVwRkwrYWsrSm4wU0JMQ1VZc2R2TmF2QXBIYUxY?=
 =?utf-8?B?QWZQdVpsMWlSbzhsVGxmTk5UdHdOemdycmtUWGFDVFRKTDVqMGwzWTY4M0w5?=
 =?utf-8?B?VWo2ZUMrZHhLcVpTYkxLZzhIcnZqMkpJR2tGOGtTL0MxeUk5NDNjYWZmeFpN?=
 =?utf-8?B?ekUzYThKNG5WOThheUJxZVVLT0J0bVBST1E0aWU0Q200NXNvMWl0VUpLZGtw?=
 =?utf-8?B?UmNDTzdQTm51KzI3clU0VzdlQnF1RUR0T3dUQ2xSdWxvTFQ3ak1LVnBmZFJx?=
 =?utf-8?B?aFpTbnNmdHo3WGZ0eUw5M0IxeEdjSWdiRXgwVlFWOHpXR1Y3OGZPT2c0T1pz?=
 =?utf-8?B?ODN6czZEK05PV2lzM2NnRG96bjluY0Voa3RrdkxwL1dYMnZsaFAwNXhXSEZ1?=
 =?utf-8?B?NG53VHZSQjczMVJpcGlaNTBPYms0M3pMVEVBWmFOTDVwU0lnWXFGZFFIVHlT?=
 =?utf-8?B?aWdTRWF3LzVSM0E4b3R1YjNRdjBiRUpBTmFBTjZzb1UwLzVzclpBSHpzcFpj?=
 =?utf-8?B?OE1iak5EOTdPclFIdXUzaUh4bXZTckZHQzYyNGZKQndSS2Nqc0Y4RzIrL3kv?=
 =?utf-8?B?QlgzUWt5OU9WbHNETlE0VElKbW1WWTUzQ1hpSGIwWVREdGVzcG1Ta293PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZTNRMSt3NkZNUEptVWFnN3NGWmxRZEl3azR1R29HSVJJS3J5djE3QjNOSWR6?=
 =?utf-8?B?em96RncwZ1VFV3hkSEpNV0hlRURtV29lYlhML2JOc3A1L0dNdkhUdkFBSHlS?=
 =?utf-8?B?RmlCenJZZ01RYlQ0SlliUDk2L0srMWhlZ3QvbVRXcUM1emxZamNWVlg5TEVq?=
 =?utf-8?B?V3dncFdrOGo4MzIwWHcxVjg0anJhOVRmdmNXQ0thQWw0WVNoZ0JZQmJSWHpa?=
 =?utf-8?B?TUp2ZlpxNXZYQU9tWGZmZm5CU1hSaWE2Z0dVK3JVK3N5dlBWMU53MUtUVWdm?=
 =?utf-8?B?Vk9SU0p5a1Z4SXRpNzdMNXNXMVhlWnpib1ZiaGRmZ01JajFZU2ptakZOOWpr?=
 =?utf-8?B?VE4zdGxNQys4OHg3R1dzYVlRNXJSSXBRWFhiY28xSmwrQldHdFc1emJ0NHdi?=
 =?utf-8?B?UXE1SDFKcGpLaCtTRCtQVjA0NWt3ZEtrMU5KZzFBQU94V2V6eGMxRWYrMUsw?=
 =?utf-8?B?a2tVbFI1aVpGK2ZKK1NaU0JWcTV1aEMxUkEwcTlyR3A1TWI5NkFLRExBOHFm?=
 =?utf-8?B?bXN6Ym1SSWc3YnY1SkkyRVFDOWg1bmt2aHp2MWpHemQ3aE5WQUFFdVgxc21C?=
 =?utf-8?B?bVdkMk15YTU3bzJIV2FiLzBtaUxwWllzQ0FFL2IrWGFSMkZ1VWh3OVRTS0d2?=
 =?utf-8?B?czdCTUk5UXhDYUJwRVJibG9ScEV2d29JSXBWSXBpR1Y0RXgxRWRuYkJpSkxE?=
 =?utf-8?B?aHp5d2l1UkhReDQ1dkxscGJsYTk1aDRmWEE2WlhRZS9GVC9tbi9rSXdYRVVo?=
 =?utf-8?B?em4ycHpUeS9tdnFvSEQ5M0pXUmZ2MitmeUVUcHhqbGNSQmQ4djFJbUJnN2VV?=
 =?utf-8?B?VVIzR0FXMTYvemNUR2hJem1sN3BYNFVBKzVRdEpDRHZzbTFaeWpUTHUwblhz?=
 =?utf-8?B?Tm5XSVBucXVMN09qM2R1cklSa3pqVFVUdE0zUFpBZTE0VHFLU3ZkSUZjUks3?=
 =?utf-8?B?SWdFZUl5UDE2bDFsUzZETk1GVUlRazBYTGJBWUhpRUtjU0J2NWZnWWFqODE5?=
 =?utf-8?B?UStUUUxZc28zME9NSnpnSE9EVU1IN3hrL05kbkFNZG03MWdJVlhzRTR3Y0dW?=
 =?utf-8?B?VDkzOE5nUE1uSFRLY0ZKZ3hHNWJ1VFptUzM5bkNmUks5akxCSnZJVzFYK3FY?=
 =?utf-8?B?Z2liT1BXS3NQbzM0elZNbUJoeHJaZHRrOHd0V2hUeTFqVy8xWXVzTnkrYjRC?=
 =?utf-8?B?TWJYT3JBQnQ3L2phZTd3T3JlZGZTMTdxbVFDdDhXN0FVM1hOTzFUTjQvc3Q1?=
 =?utf-8?B?VExnNjRVVGRwT1k2M2ZJaWZDRURXbEkvSHlXY01SUVFFOFV2UjUzWFh3Mnd3?=
 =?utf-8?B?VFhFRE16WmdBRFV0cGdSeUllUzVUaXJ5dWMvdFhrQ1g5Nmg4OWdWTjBCR3pH?=
 =?utf-8?B?MVp1dW9HVjJKYXErUVN1cmVSWmdKK2ZEREw4NGx4dzlxdCt4dWxXYjRHbVJo?=
 =?utf-8?B?bjdTY0tWNlZIcFBveUowUVQ1Qm90K2NKRFBpQXlia1dqMTNYSkVac1lDWW9h?=
 =?utf-8?B?VGQwVHVUbmkzbStQTDQwSXc3K28xck9Od2NENndKQ2NJMU14cFkzUnAvOEN4?=
 =?utf-8?B?UjZsUWNBcW8waGw0MXBGTGFZdHNWZlg5TnJoQzF4T1NpU3lVWUpjb0JZZ1p6?=
 =?utf-8?B?ajJTaE1LbGkwb2lEVStyUmw0RnJWNXR1S1lMUG9iQ3BuTFZkaUIyTFZSUTZD?=
 =?utf-8?B?dkQvTUVQOTZieHdkZHRMZmxZck1BcFRWUnBGazdCbUhPSEpPSk1uc0NWSVA1?=
 =?utf-8?B?TWo2V29EaHJRK0E1ZVJ6NEh1WWllYThmVlV5cFJWWGxDMDZ6eVFXZXpNaWZN?=
 =?utf-8?B?UnVyeDBZd2gxOUhhSlJVeHkxWWNZS0hjdUJidE4wTXlwSzgwVE1YNFJoei9X?=
 =?utf-8?B?M1lKNVBnbC90b245WHI2cHM3RExrN0NpcUEyeWNEeWZYdHZsZnRiOFM5dnlp?=
 =?utf-8?B?U2VPLzFWWTZkckV5VU5DeUdQbTBQUVkvS3NDQUMrTjRMQVRSaXVCbno0Tnhm?=
 =?utf-8?B?dFR3T3YzRkgzQjZHbVd4L0lDOFV1VmVya1k1czJqMHVaQnNFQjZ0a25sOEdG?=
 =?utf-8?B?L0RKb2o0b0lnUVZkTndMUmxDQ0dWY21rb0wwaHMxTFNFWEpiUkhkbTIvc3NP?=
 =?utf-8?Q?FiCv+wqTXOeAYqumjqi4+3WFs?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UpSvPlhSdj6xRdppSWUy9HOnqGICM7zB7kxxqZI9n+jtb9GNRHB/5Rej46DrfW9hcjt1crel3lwmanX9wGbb8i5dkOahncOs/8053/m6FX1ZFe+EKf7amq433naGmfLCEEhiAvTD5DUePU69T7eZKgEsgscE9aInQ5GsHmuL3UQ3QImO8v7uhfLBiMukU5AJkVhDDJS7j9YZCZza6LxUElMsmek1kjFqdlFNuxEWKgoVhT7DH51xWy6jIW0qEHRiyDNGLDIvhKGiFF8lB/YMydaH/BUovv63v5xOnl9/QpcjvH4QP2WjGtrX1bbT/UAbQfVKkJTer7V5UVu8dVdmmtgcegEoV1ZgnBmDspF7s6eNz7Mo1Iw/2oQs4EcV9Ey2YskLEJIzxqvWHmchbUUAgz9stsYXOl5u4aCy+9kghAtVQiReK0p+s6PNHTC7NPmnEM7pWLKKxk9h506lNE9A+KutgVDVka+ZTSG88RdwqQyg8WMkYT20/VU18XUkc3zxz7K2wZLmAza4tvA9h8r8B6yKv/79xcwcpU2HzTwOoY3umQ0EKuGPeLseEzHsBG4R+PX+1yJ1INlU4TxM5zo8zl1yZ4hu9sEd2IexUDElfKg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51f2aeba-d183-4a4b-37c1-08dce9581fe0
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 18:19:48.2795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DVFLPcTBiZXFGD/Rrj/KTtXFgjokjhVc8D9DpNsjJc+QirzOy0F3DI78zuG46KYuFpZPjAvFE+zIt4LWIiWjl5Lcdd68g9Hxf2HlFF8JQxU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7920
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-10_13,2024-10-10_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 mlxscore=0
 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410100121
X-Proofpoint-ORIG-GUID: Nl1iPyDazSA9xledW6nia2RSNWek1vTj
X-Proofpoint-GUID: Nl1iPyDazSA9xledW6nia2RSNWek1vTj


Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:

> On 2024-10-09 09:54:05 [-0700], Ankur Arora wrote:
>> resched_latency_warn() now also warns if TIF_NEED_RESCHED_LAZY is set
>> without rescheduling for more than the latency_warn_ms period.
>
> The description is odd. I think you want to say that
> resched_latency_warn() does not warn if a task has TIF_NEED_RESCHED_LAZY
> has set for longer periods and you want to add this functionality.
>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Peter Ziljstra <peterz@infradead.org>
>> Cc: Juri Lelli <juri.lelli@redhat.com>
>> Cc: Vincent Guittot <vincent.guittot@linaro.org>
>> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> =E2=80=A6
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index 694bfcf153cb..1229766b704e 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -5571,7 +5571,7 @@ static u64 cpu_resched_latency(struct rq *rq)
>>  	if (sysctl_resched_latency_warn_once && warned_once)
>>  		return 0;
>>
>> -	if (!need_resched() || !latency_warn_ms)
>> +	if ((!need_resched() && !tif_need_resched_lazy()) || !latency_warn_ms)
>
> tif_need_resched_lazy() is not doing what you think it is doing.

Thanks. My bad.

> tif_test_bit(TIF_NEED_RESCHED_LAZY).

> Either PeterZ makes a helper for this or you need
> tif_test_bit(TIF_NEED_RESCHED_LAZY).

Yeah. tif_test_bit(TIF_NEED_RESCHED_LAZY) and need_resched() will
be identical with !ARCH_HAS_PREEMPT_LAZY but that should be okay in
this context.

--
ankur

