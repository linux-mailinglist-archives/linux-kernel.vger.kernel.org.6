Return-Path: <linux-kernel+bounces-381774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D049B0449
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 15:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BAE8B21957
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 13:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E531632E6;
	Fri, 25 Oct 2024 13:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YYm4FpPJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="H3v2NXw2"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9EB212178
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 13:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729863546; cv=fail; b=vFuOSqmK2+Q0ac7FtQZByLQFUyuQI+x6EL21APu8/YmVCIxsyG16Osi+/24zLwJbBD6J2cpLqUM2qZ7nt2oFV8baOzXw2vZwDRbA5ZEnf6vURzH3/iUqPg0W+Au87ONmYYR6dsL+iiv56kwA4tCGx/BYt6G+1bovSgeB60gIgH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729863546; c=relaxed/simple;
	bh=1Cs7jrHCLw2PHqwCJSTja9+5kGQYAHMsvHJ1XrayIzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=d94UJgqZ6xjqq8eIYFcTVofrOikFyaInrkjg8Ho3+B2qwy1ittvbWX25Xgx6g7swQLtjCL9wYUXFqe9ETZcriufZG2wydqz2KcsNDXOcWPp3lphYwHA1Rl+pPFpMzmqP5kqs3C1ZFX52PRh2DV+VE541x8ruobbAC/aoorv5qI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YYm4FpPJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=H3v2NXw2; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49PCU2KH030374;
	Fri, 25 Oct 2024 13:38:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=HZUPGouiHVw+o3OUu3
	U9lzbZ25BsUIV4aZ1kDzMqzK4=; b=YYm4FpPJLQ/MbjqHtG5flbh8JFH1U3tAjz
	VSVwuXsmXlAPwOp+uDIcLADn9hM/wMgptTxUQUfT2pS0+3lp2If+3157kEVJq/S1
	CUjXnFhgC+5wdbjQZmY8EThFp/If76LEq9juTRgFHpg7TzZUX2mEhCj5uFVLzKm5
	UGgNMS7UR+CJfjhQERxyzOLIiVsHy+MQsYfinQBSBynUG/dS1ydkYQW7pczVqTEm
	C2YhOEu4Q1cKY3hZTG5uK7bv/Fwo8IYjAVLTGADRmq13wu/afU0AP9YfTqiLYJIb
	7nYEerlSn4Ow+lHgJdCUK+sZXlkkDrhbNtqWwLCtBgVxk5Ta42FQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c55emuph-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 13:38:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49PC2CJW008699;
	Fri, 25 Oct 2024 13:38:33 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2042.outbound.protection.outlook.com [104.47.70.42])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42g36aguq0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 13:38:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HmN30vMNjngR+wtHn+jkU5K4hBJbPoNzv6P7RoevtTzwJZHea+jgDlMEOrFxvpbWTNHRV2Lz8axNSXF5h6dywn6LtKXU5e+FLRr1LO/55zkSUGujTIfEOoeMXu2Kf4E70YIUhleHl24iYB9k/+t9/7W8TjRV93TMSjfVUWSjuYVyVATDVNC2dw7mJZ1Q3J5RgdzyLw2XOXeb7FZ9LPokMobvw9MY/BDbt+/csmwqtO0yt3CTBt9Bt/HicpTmnPLbozeKtitbzQrM2BjKVWlI8qAOgEKPnvfinTxwG/rRIRT0xWockUscUJTVFIdHt4e2neRM8klCRFtqVmNtCSpD9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HZUPGouiHVw+o3OUu3U9lzbZ25BsUIV4aZ1kDzMqzK4=;
 b=W7O9clVqfL8hZdZ2SLmzU9PAFgaOw87gBG3JNdQAtcffyS5fJ/2LD19rmeTtjUy0So4zOWUOORxQRLj2DTFtDXSlFa6kdxOxrmI4fcC9WM9C42nQm08bToo4nVS4CV7Bmyn1qb4ts3zZJLtgQ3UjFQfoBc410hf4fRIfiyzMMEwQ7tNGV7r6pDgy7tNJnnHbsEMJdegaPt87qInaPiu3vt50hhLEgb0oOLMf9gxuCUHYYH+cPfNSGMAHIFRBxolRQ9mu/qLjdqwEl6HTOhKa7RR3jCbPs+8rtOvc5Bf8LHu9OPa+veF0N40gLvz6UBlIeVU5iv+65h+y/O1BrQxcPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HZUPGouiHVw+o3OUu3U9lzbZ25BsUIV4aZ1kDzMqzK4=;
 b=H3v2NXw2NINZykjLDppUTXs+lGVWfr4pBt3LerD3Bs58drRJtWMcBjbb0l4VNLXyd+VnBGNxxz3rAB2fS3i4FKuuxv3zrDTHjQZ+kxJw9g4DVX/C9lQHpo2RaUxktLlpCRZprbFjgCaz4Nt1kFW3p/1Ia4vASfGTe2NtlvnsY5Y=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CY5PR10MB5962.namprd10.prod.outlook.com (2603:10b6:930:2d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Fri, 25 Oct
 2024 13:38:30 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.8093.014; Fri, 25 Oct 2024
 13:38:30 +0000
Date: Fri, 25 Oct 2024 09:38:28 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Shawn Wang <shawnwang@linux.alibaba.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, baolin.wang@linux.alibaba.com,
        mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com
Subject: Re: [PATCH] sched/numa: Fix the potential null pointer dereference
 in task_numa_work()
Message-ID: <rackpsb5traqwwyqirfo7r5k66m73k7n7nxvyhz53v77gprqy3@zzj7dayxltl3>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Shawn Wang <shawnwang@linux.alibaba.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	akpm@linux-foundation.org, baolin.wang@linux.alibaba.com, mingo@redhat.com, 
	peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, 
	vschneid@redhat.com
References: <20241025022208.125527-1-shawnwang@linux.alibaba.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025022208.125527-1-shawnwang@linux.alibaba.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT1P288CA0026.CANP288.PROD.OUTLOOK.COM (2603:10b6:b01::39)
 To DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CY5PR10MB5962:EE_
X-MS-Office365-Filtering-Correlation-Id: f1dcdcc3-3789-4fe1-bb90-08dcf4fa5001
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bEV7oARJERgxELbk5+XqN0e21ydOA9wAbN1STwo3b2w0WRXVWKniU6UkNTuw?=
 =?us-ascii?Q?Vs/z+yn6pUWnsn7ivxf/h3iNsLSKVFnLC2eJ8yvbrTbF5VDVWEhFfCpqz4n+?=
 =?us-ascii?Q?K94wDmp57Kvr7oRd0YgRYPFAzq09KHZh4lrSiOrYDCRmuDSOhnWnI2U0/VEz?=
 =?us-ascii?Q?AT3yMZW59os9ZCk5eF8qxb9ZoFT3bCUmfJMswCWow5XiojHtq7/8zt5iYf0p?=
 =?us-ascii?Q?HHxIrs/pij4xBXbAte5bIuTgGQSepPV+pdAgXxwR1gF4e37JA168+sHNnTBP?=
 =?us-ascii?Q?w5oEckl7U+l/xslr2yfxkjqRa4OQYWdq7XTvJW0VdTqRL6JH/GvPCOz/yB2j?=
 =?us-ascii?Q?woI6deO9RJemmjy30lMQEP7D8kJRgmmqibPgMGwQ1dgl53NK/SLdB/nUr4Bi?=
 =?us-ascii?Q?ghmJCK8ByCrS1rh82ZH36eQuuwlB6T8Qf5dtgFzIMuFON4udwUDv9qhf9x7G?=
 =?us-ascii?Q?yzs+f3MFXw+2fOO/1OUnjPUMm2l/o3nemJSap4AIt3a6dsITywDjtkdrEqKW?=
 =?us-ascii?Q?fEG9cNlLDUelDrkTtMwOnALM6IfnzWFgBMDewtE8zLXKG5LP1TqPcGgCVrn9?=
 =?us-ascii?Q?J8XID8u3ck4ARo6/j1B+6cBU6VGMFubBIzPeIyyG8ATW3nzJ6uc6aU1ix+up?=
 =?us-ascii?Q?DFVoQty2eEnpjPcGjQxaxJDAD9yxZH198j+jOFc4/Z+ozBoVofdMIzC5gv+X?=
 =?us-ascii?Q?zBj3HmPmW8i2Tqk0MdagHVB/ZbRsGnHgy11cgAUCUI52eD8u0m+4PUwVoCWO?=
 =?us-ascii?Q?gz2aYZUJk/75M4EJShzDt2AruzmfFa3CUwKfw3Lk+HSb86YTJcLIXu24EITk?=
 =?us-ascii?Q?maqKHmtShxfGSdkJISOacbggp62o1yT4QIfwQNDflqqjp7SiCZl5S2356NAu?=
 =?us-ascii?Q?t2MHq2VvUxlXlSJhdDFgvq1oC2fc7UFwXNs/v2wMpl88B2v9ay0Wn24fNdyO?=
 =?us-ascii?Q?lJ8EXR8VrlrdhtdX11skBcafNkcOPKNyrwGpFVYiiuKesviy6zvJQukHRhL2?=
 =?us-ascii?Q?3T3GFiMuQfLeRnFZma2B2NKpCuUwwd7JFBSR+aqlI9t8KLlYub2soVT9OZ9R?=
 =?us-ascii?Q?Y38Qp2dWfBNVVgoOuUUeIQcbtYFya1XDBqlLa7TqV+AzffmQc5PR5B8Xkzw2?=
 =?us-ascii?Q?IF1cTKEir9CnX6stn3MpESrbBdMxtqX82qVyhMfyMLhPCciUNS1SObDGIL60?=
 =?us-ascii?Q?bvIYE9MLmRdTMTS2ezpGTDfj5Pmu5N4ba6GhhhQkI7RV8JkWK6btDZ6lnrEk?=
 =?us-ascii?Q?L8nyQkbefyNisKldyF5pWkBumIsHC1bb03cvPCqk7A2IoVvNFvNV2jgV3GR2?=
 =?us-ascii?Q?qNZjqlXtUBzgP6tlQd7bWiFC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v6AdWk7+WxEl46ONhuunDyzQeSVZzNB+bjlXRQL8ZX05H+POym3ygeR5ouA/?=
 =?us-ascii?Q?/mssDdLxda0W4fm14ZXz8pLFSoLAEiIL4DiWIt+xzbAQvsvgQLoFbsYKB1PN?=
 =?us-ascii?Q?crIMHn0E3bxmihcrZ+jx/on3aUSU9zkBI7MyiNMFSHLjIayUVY/qLwXEfJbB?=
 =?us-ascii?Q?NGNf8tQVjlwn0UnjCbF0Uy72xkrOYRJ55rmn8GYUUxulNc8ZpU696LPzif1F?=
 =?us-ascii?Q?Lt+PRk5oNI0bkugV0Lw6IQOeZTSaXYP6d357bed3rpRdsKkc99drDYqucU1M?=
 =?us-ascii?Q?ck/nab0Ov2QJZiiGukqQb57tjmYzJK6lwAJkXaegFUovMw/q/Z1HCL9xj98o?=
 =?us-ascii?Q?ozUzaa/snMv4zDNcHQpYKtx+hhi5vCQcolyYN4jjMKleCk7BS/aJXOOr6+QA?=
 =?us-ascii?Q?lp2t/V4l/Sa9E058yZhwT4JW0vr0qbkqELi0SpM7jGqzUN4odRcNmGUgl+/W?=
 =?us-ascii?Q?pFVHfIBSDxr+FvQ/YAazv5B2rBIAHr+C5EOjPEk0CeyWLJwuGg3d7DgybR5w?=
 =?us-ascii?Q?2qL/f1IwGMY8vO/usjyoe17YvwtX1lpj8JqFDumyw7tj3Ago8egXU5Lm/xfC?=
 =?us-ascii?Q?DGO3Z4Wz+OTY0alnOADuyod/+acneID7fSQ/f6xmq92bVFPqFIJbAVi4H3A4?=
 =?us-ascii?Q?IdUxwyjs3S9c3eKy6Y1n6NgPlhFey1fjA2VtvyIPYN+gO/2n6j0SvNcYLOQL?=
 =?us-ascii?Q?HiH+MXz/0eucVOc0vb1LiZFb5Q6+LtcF+MpuJjNRCXy8rA58snweeAFloHXR?=
 =?us-ascii?Q?R1Eb6KVsnKLp4OycPfRPM1RB58SKccRsQUrxaNgTqL+TNCpdhAfQ+f1V/YIX?=
 =?us-ascii?Q?3FaMJTsMScd3GprdzWbVBygouYUhGvxwjPGSjoPOmODMPVY7732rwatWOsH/?=
 =?us-ascii?Q?NfW/Lp11RwCV1qxwvtrUEDHqJ5VcaLsewO9/dJfSwEsLhyGG9wFM5+F6QGw8?=
 =?us-ascii?Q?6cQmg5zM6hbfCW7cEZJfx2EhXaA3OKHaoeh5OWyGSo6GMGMkk36pITg7Dz29?=
 =?us-ascii?Q?dOw+UFikLEdAfXceEOTA28TJskEP7W+8v7LBM/8kxQtlH9IlKB+6sJzvDfvd?=
 =?us-ascii?Q?P5c1+mEdvAyR8unTiNUu8pUwIJaPXMPpXpWd3c/nO1sDHQwbDU4yiVBulAf2?=
 =?us-ascii?Q?hEpE3t/fxFIk/OXxaWiD++ny2WA+KhvfJhvMoRA9IHxVUjIkIth3xkNZGwGF?=
 =?us-ascii?Q?tZL9ZZ2XxSDChADAu2EVef7KwkqVf6r/t3HTsLIakiy3XiiGd0aJ4hFWAjXl?=
 =?us-ascii?Q?A7u+oiHx9d0T8BE0T4HhqKkJDY7RQU/P3ftKHa1l3LtbJgvhgaXrilqFOU0v?=
 =?us-ascii?Q?tjm2luFLvgUcaWclPLEDqPxgtP8v2f6M4UrY+5pfZGSNgqmNtctkD6Dx1NdG?=
 =?us-ascii?Q?0BW/aaGTEbbC/QufyPUj5sz8Ohqrw1RmzkZXtnPnj1tbyGOLInGSdpRhcCzy?=
 =?us-ascii?Q?b+V6G0qGn98hqHWxDnLIVSTEAUpz4KsVjIibbmq7ktBXh3p/scoyl/oDQW9l?=
 =?us-ascii?Q?yn+YjfTN4XMtJ9V53t6vBSTI18BbDO4HLbKlcE2PM9ORjkA1dUA9Z98p1f+l?=
 =?us-ascii?Q?/eZdZtOQaqUoWdJUu/4vjcWmqeAC3/zGL4h15dEy?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MCzBzDc0koVAG+YOWT3MXN69FB2GWyZbtYenoiUR+8Lec/79yVMTjm8cJHB7AHn70bkYgfyvwsQfHvj5sUHeOYVUrDuVKr/GYDQpPECWHl64I89alZWSLIyCumprRSMp8GPIsnB9DDmysMTEtKP9JpI693K62eVEgjD4/zPuXA8AsL/vfsMSE7ARPF4StG/lS1MzMfmRIuXDbHODUbWDwguEz9E2pAVkOXCfCCiCurgyUHo8ePNXAlFblk9zxCsPHT1r8nQvNvtK2kCW3n6eISTy0lTuyCGizesF0xACeiAZna30md7GtVGg1r9/ygu7FEiX3/K9eyotK9zKZzYO2I6EP/mQ4jQILNCCjutioxnSD5WHFBcTylaUgHvC9/rtMAkU7oPUjlIcMT193QH1KJr9kZy7clmmESYmJQcA92qj7UYSMPdvM8VXiIaoNDdzeVeEgSq1GLcF9w880nbBKamfk0s6v5RP0qd+F8HVM7caAvx3eW/8eSxiUIRV20hzj+uNfjZGsFdat5WgpYLgbEGPP6B44ghelggmWZUssy2ilkGWU/iz0sJRs40+i5qjw7+w0zc0VXoS0xmz7uXaOd2t/psiz2Ch4qV8LwAafuI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1dcdcc3-3789-4fe1-bb90-08dcf4fa5001
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 13:38:30.2415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8WGIhjoEIa581oOhqygJ9U6Rq9xfJeDqToe1kF/Urej5DWuf+L6Q3nn/z4sYnWvrDbsIX/BlIQdyRKTslJtPKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB5962
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-25_12,2024-10-25_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 malwarescore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410250105
X-Proofpoint-ORIG-GUID: i62T-9mx3_3oN2N7R3fKFj3bIMUS2tfE
X-Proofpoint-GUID: i62T-9mx3_3oN2N7R3fKFj3bIMUS2tfE

* Shawn Wang <shawnwang@linux.alibaba.com> [241024 22:22]:
> When running stress-ng-vm-segv test, we found a null pointer dereference
> error in task_numa_work(). Here is the backtrace:
> 
>   [323676.066985] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000020
>   ......
>   [323676.067108] CPU: 35 PID: 2694524 Comm: stress-ng-vm-se
>   ......
>   [323676.067113] pstate: 23401009 (nzCv daif +PAN -UAO +TCO +DIT +SSBS BTYPE=--)
>   [323676.067115] pc : vma_migratable+0x1c/0xd0
>   [323676.067122] lr : task_numa_work+0x1ec/0x4e0
>   [323676.067127] sp : ffff8000ada73d20
>   [323676.067128] x29: ffff8000ada73d20 x28: 0000000000000000 x27: 000000003e89f010
>   [323676.067130] x26: 0000000000080000 x25: ffff800081b5c0d8 x24: ffff800081b27000
>   [323676.067133] x23: 0000000000010000 x22: 0000000104d18cc0 x21: ffff0009f7158000
>   [323676.067135] x20: 0000000000000000 x19: 0000000000000000 x18: ffff8000ada73db8
>   [323676.067138] x17: 0001400000000000 x16: ffff800080df40b0 x15: 0000000000000035
>   [323676.067140] x14: ffff8000ada73cc8 x13: 1fffe0017cc72001 x12: ffff8000ada73cc8
>   [323676.067142] x11: ffff80008001160c x10: ffff000be639000c x9 : ffff8000800f4ba4
>   [323676.067145] x8 : ffff000810375000 x7 : ffff8000ada73974 x6 : 0000000000000001
>   [323676.067147] x5 : 0068000b33e26707 x4 : 0000000000000001 x3 : ffff0009f7158000
>   [323676.067149] x2 : 0000000000000041 x1 : 0000000000004400 x0 : 0000000000000000
>   [323676.067152] Call trace:
>   [323676.067153]  vma_migratable+0x1c/0xd0
>   [323676.067155]  task_numa_work+0x1ec/0x4e0
>   [323676.067157]  task_work_run+0x78/0xd8
>   [323676.067161]  do_notify_resume+0x1ec/0x290
>   [323676.067163]  el0_svc+0x150/0x160
>   [323676.067167]  el0t_64_sync_handler+0xf8/0x128
>   [323676.067170]  el0t_64_sync+0x17c/0x180
>   [323676.067173] Code: d2888001 910003fd f9000bf3 aa0003f3 (f9401000)
>   [323676.067177] SMP: stopping secondary CPUs
>   [323676.070184] Starting crashdump kernel...
> 
> stress-ng-vm-segv in stress-ng is used to stress test the SIGSEGV error
> handling function of the system, which tries to cause a SIGSEGV error on
> return from unmapping the whole address space of the child process.
> 
> Normally this program will not cause kernel crashes. But before the
> munmap system call returns to user mode, a potential task_numa_work()
> for numa balancing could be added and executed. In this scenario, since the
> child process has no vma after munmap, the vma_next() in task_numa_work()
> will return a null pointer even if the vma iterator restarts from 0.
> 
> Recheck the vma pointer before dereferencing it in task_numa_work().
> 
> Fixes: 214dbc428137 ("sched: convert to vma iterator")
> Cc: stable@vger.kernel.org # v6.2+
> Signed-off-by: Shawn Wang <shawnwang@linux.alibaba.com>

Reviewed-by:  Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  kernel/sched/fair.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index c157d4860a3b..b4c3277cd563 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3369,7 +3369,7 @@ static void task_numa_work(struct callback_head *work)
>  		vma = vma_next(&vmi);
>  	}
>  
> -	do {
> +	for (; vma; vma = vma_next(&vmi)) {
>  		if (!vma_migratable(vma) || !vma_policy_mof(vma) ||
>  			is_vm_hugetlb_page(vma) || (vma->vm_flags & VM_MIXEDMAP)) {
>  			trace_sched_skip_vma_numa(mm, vma, NUMAB_SKIP_UNSUITABLE);
> @@ -3491,7 +3491,7 @@ static void task_numa_work(struct callback_head *work)
>  		 */
>  		if (vma_pids_forced)
>  			break;
> -	} for_each_vma(vmi, vma);
> +	}
>  
>  	/*
>  	 * If no VMAs are remaining and VMAs were skipped due to the PID
> -- 
> 2.43.5
> 
> 

