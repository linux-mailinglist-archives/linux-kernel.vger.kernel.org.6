Return-Path: <linux-kernel+bounces-372303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2CB9A46EB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 21:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 032052883CB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 19:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350C0204F86;
	Fri, 18 Oct 2024 19:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LQVnFV3Y";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YjfYW3iw"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E41A1865E2
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 19:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729279134; cv=fail; b=b0ma5cCrXapWs8MyhdG/dkdQzPbjcTPuA94LaYFkYCGvA20OBc03lDmlYRkDjK6IjSeqynB6ALO5UUf1hs0Xj+YfR22RcZus0h1jzc3fs2bj5xaJxpeIxmu5NUixdC4mcB1EirTN5eGf06W8/yfi0h1KlU5H87CT2NR7cp+d1wc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729279134; c=relaxed/simple;
	bh=hKvo3yfQnVS3dlklXWzg2Hmivhg+nAmLNANiScli6Ik=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=NFYac84yByof00NMGzbA67L10dMyf1hCqvwJQbf/jw7f47o//y7B8epFRdqTvvnqMYY7t/r/ESGNI3TS2ASYP78qieVH1uq3zomz+YTPV1bX/JMQ2wDgIZChR0ds0kooXPwMERS2I3AdSOb9KqbCsuvkwXCkS8HBLN0o5pTIo74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LQVnFV3Y; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YjfYW3iw; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49IIfr5m012739;
	Fri, 18 Oct 2024 19:18:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=IOjwvTxjfie+6Sq+Ks
	B/qk86Ijwg6wXjiIfplTR9sJw=; b=LQVnFV3YcEdrFghIZpMJlB7K5moDqMLksQ
	NduLVS3Ooh8YXWpDiuD2MK27b9EfK5MlP0kJ9rXBCMLbtP/SHEi8QzKnN3B8mL44
	qXvK2CGpV3uZzteXjmYxRRD6sYRIz2LFP5nm1Cj7991EaZ0Vg4PBVS40vB0qj9T6
	uQqU3N5FoFuQzHDQOAwjkblx8SPttlZPy1E/r0KM/K5admo17SpluUj9wntRq5VQ
	/K41GvnisnczMkIF1jJqyYZdwqHh3cvT5yGYoKj3uuVbaTzHI9mUw5s3Q+7sUVBf
	ecP7H3SB2bZdK6FDkYzkEUk3Le6tp97ToSHMAHtHJkRmw3m44lnQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427hnthhpq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 19:18:31 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49IIVDP5019910;
	Fri, 18 Oct 2024 19:18:31 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2042.outbound.protection.outlook.com [104.47.70.42])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fjbyxp8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 19:18:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LHRlrggkghzMsMNfY0jkfXHhst8vg4ukZ9e2yuuEK45fqOs/pTomZ61PFMTxWXFynRWxPR02S5N7P38ti28wr6s9pidjxisf+hsRU6wtHeZGDhe0dSw7XMetNtjSomiCa2xb8Hlv+jtOW1/8w+uXNm1ps89qcnc9/t54mDS3gkFvUeqoEGrp4tnf7uS0K9ZBun/Pwpat32O/qffPN7SI25jqhy0NBDg6mzfxQAmXY00RHoviOFDLO3zllhMT6rsj9260VLsb4iPuwgDiW4/1dG8tOzwDFyxWkBLb0ylt+eYceiiC0Q0bFPJFt5sG4EV0n+jazRtjxbUsZFyb0E4aZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IOjwvTxjfie+6Sq+KsB/qk86Ijwg6wXjiIfplTR9sJw=;
 b=x+ryvDCsIbez8rrIpetMxvbWX1/NLVQI+mPGdkggMRdBiSiYc3tplTx1Aw4UVmkYq13uX+Mblh23GWdZTEDHl80K/IzYcsG77sRNp0QYlVhsyHbuLSeafIs7rmSdJoFqZART8F0VB1/Ctn/e/3QF2LTwQOPodW62PESnk0eQm6MHkUYXY4FEPNG+CAptYNiMRXEbkCgakHayj7+dZZ+51uvwgvlsmgfBB3aeG8KP9RMbSjgQ8E4s92qW9hMemCRGiXWgP75aY9lbgnhdCq+gibta2DBKGXyJOQQNv2HvGE3nR8h6/0yLECw4hCEI+G88ZLT87vMWp5DG7PjZwnD/qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IOjwvTxjfie+6Sq+KsB/qk86Ijwg6wXjiIfplTR9sJw=;
 b=YjfYW3iwcFLmewyJVti+IyuJdSm6lC7krA7iLdIeHYG7ckj7dVUJdwfYD9TzLQY1Atw+mslTZNv2JkiS19zxo7RHAeq/7XLJxZb8ED4O9FrN2MZOSoa311zHig0zLdtawrkoNr0KlRsbEJSwag96a0Ex6Ia+bgBezdjUoeZWQ0M=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DS0PR10MB6872.namprd10.prod.outlook.com (2603:10b6:8:131::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Fri, 18 Oct
 2024 19:18:06 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%4]) with mapi id 15.20.8069.024; Fri, 18 Oct 2024
 19:18:06 +0000
References: <20241010104438.GJ14587@noisy.programming.kicks-ass.net>
 <c6cbc343-01c3-4a38-8723-cc44e83dedf7@paulmck-laptop>
 <20241011081847.r2x73XIr@linutronix.de>
 <db3b0a4b-bec6-4b2b-bb22-d02179779cf9@paulmck-laptop>
 <20241011144341.mQKXkGkm@linutronix.de>
 <dcffa722-986a-437b-abb9-af9f4de852df@paulmck-laptop>
 <20241015112224.KdvzKo80@linutronix.de> <87ed4hrp45.fsf@oracle.com>
 <20241017080439.9od9eoBO@linutronix.de> <871q0emji1.fsf@oracle.com>
 <0c04a986-91d0-4f6d-bd4e-ca00d1cd710a@paulmck-laptop>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: paulmck@kernel.org
Cc: Ankur Arora <ankur.a.arora@oracle.com>,
        Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, mingo@kernel.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, frederic@kernel.org, efault@gmx.de
Subject: Re: [PATCH 2/7] rcu: limit PREEMPT_RCU configurations
In-reply-to: <0c04a986-91d0-4f6d-bd4e-ca00d1cd710a@paulmck-laptop>
Date: Fri, 18 Oct 2024 12:18:04 -0700
Message-ID: <87zfn1jk43.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0263.namprd04.prod.outlook.com
 (2603:10b6:303:88::28) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DS0PR10MB6872:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c5beaf2-eeb4-4cb2-70b4-08dcefa997ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nf6PAks8/YmvKO4MePe0u8mfKIP/Ajg3Z9yWT5SvNrv8LucTfKwB7O+tTb4i?=
 =?us-ascii?Q?i64jTLfrrI8kJJtT+LfGqTTMmsTVfqRSXHu57h3jSRnod86GD+A+y0rQLT+S?=
 =?us-ascii?Q?Lnpa+iQ7nhHAssgLJ9eWwv9BlxWu3GObncNsMp4MhktYAdJfmlub4Orpudfo?=
 =?us-ascii?Q?8pRCefcybZcI3RdiOmPKcJDxTmu05oDdtz9SYwHrLj1DwP+0J7XwQWPJCZTY?=
 =?us-ascii?Q?MyqxeiIXwTa/GLmdsk/300dq7BoP5oNJifNVJTIg4x+15bhK9ZtAnJp//Kof?=
 =?us-ascii?Q?XO3hJ8M4CtBJqRIFraj5iKawGfSbLCsFL25mmQ6zy0SWtovGCkKOuntmCXMw?=
 =?us-ascii?Q?fzTL1ZxT54eHffvlgedI3KJ1thyd+qGUB6Z4FjYjPGcJEXgrDgZhVoXbzPv5?=
 =?us-ascii?Q?wPcC5H5RTqqKC6IcPCETSFDRxpZBkVrKyyK36poB7ywnA7h/3D0T0PFOUx5Z?=
 =?us-ascii?Q?BGK61NWssywrGH6+duLuJKRQs+bZQpye1x5RnvQ2PzSJmLlQYHDZ7ACYiTYF?=
 =?us-ascii?Q?oezn+gtSQutkFg9tjbL07a8eGKTgK+tU5owLmUtlTsJDjz1dvhBSWZT3KWDO?=
 =?us-ascii?Q?/+AIIglQ/fjOLR/e173fbE/SLVOyrH5l5XgBEpCfE8Kal8vY5SbzCwl0N51d?=
 =?us-ascii?Q?cTyoL0wrJ5cT/U+V9I67rDgIjWKCXiJjGFggILSYBzrASuuGAhSP6wv9jcPn?=
 =?us-ascii?Q?MCpl5gV3jqeBp+D6aXNWJ55g5p422fmLVTEPaNEdfIl/Pek9Pwu4pkg7p+bw?=
 =?us-ascii?Q?YnZYNoKFHsKDC8/s0mxx6NuFGMJrgYr82TPk3cWNSR+1KCvCgKr6rl0R/J8I?=
 =?us-ascii?Q?BxyAquCaSa3OV8oX5Hvq6SVocb2//1e/+EEV6tb5IGoudc2qajwZv4XB/8e6?=
 =?us-ascii?Q?ByzGT0CvMD61Y6+dlc7VtRAu7t6ZYovUtmldg7Vh25spGJ8FgY4NaVvMsfGZ?=
 =?us-ascii?Q?upKJldYm81jf7aRguJSomUPjaU8SvNlUBkilAFClGGI8SpHtNf6Wf14LmjI+?=
 =?us-ascii?Q?oKEmdtKVUzpEB95orGGtQKgmmfBRBRbQ1elJ4+TPn2I3rxjSbWmgieU6UuXj?=
 =?us-ascii?Q?6KBrFHlInaM1N/4ZB77d5DLnpEV3jCSLwrscUZBQomNcAHY6il2c1YdFqJ8m?=
 =?us-ascii?Q?dvD/k3iE0qUJ2E/aQuLnzYTVGnsg3VSXpgUYWYiI0Cl+YcKxO8vN8HAJVHGn?=
 =?us-ascii?Q?Nc9M4WJgmFPm0tJFmCktD1bX/rsMVbVH4sfOHiN84Mw11991yo6omairAiHd?=
 =?us-ascii?Q?VBy2xxf/CX1xq0nweknA6tR2GpguC5qtJWcFAdRG3L3U3vmu/EAY2v5jbyUz?=
 =?us-ascii?Q?sEIOe68Pm9SqusJBk0pqGdW6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?j1lcoBqfvcEvNGDNds/AM/95KC3/+/aXcLI/x1IciT/gT1rCLRQiDXN66kku?=
 =?us-ascii?Q?jSQzqgYVx0SOvqYy8cfCU2aJioBUOfFWv5Aj1iPR4Rfuf/Fxd8r/EnfjxmtX?=
 =?us-ascii?Q?nwNWxKVI8WnzBFSIBKyc4R7Ip3hWpIlgc406PCnQK1NY5GdZo9n78Ei8vz4k?=
 =?us-ascii?Q?x2H22ulF+IpUbT5g+fKIhmT+LsPJg5QygyIk2LNoybBICKXOVLV6bJyomd1e?=
 =?us-ascii?Q?+dMAqR+bd9b3NdD5B+hTP+u8QJbJhNNf3ePVW+77mU7WRRHeeTwnPpMVnjpX?=
 =?us-ascii?Q?kaF742rzKNcrpQiqJLMdz5lzzXkndboOjztaxTEdZk+kp6/Nkrb09FsfLh0n?=
 =?us-ascii?Q?/qHNpAm3RXZ/qxA5Qet0FQBEhxLhhPRqTE5rTTEq9SEYIS2Qoc3FqqniPbpd?=
 =?us-ascii?Q?sytklJO80fYk85Q3fbCvCP86VlddtT4taxL8BNQ6hGsiPp40Tfu6QS9wUvZQ?=
 =?us-ascii?Q?YnHv7e2Q6k3FEw6R1QaKnOqNBrEPnvv1Tq47nOsVvHoQPLJPuJeUFbMSBRa2?=
 =?us-ascii?Q?2QbuUgXNncRgsu/AB0kPoELtQ7+dE/fq3CxDK7gzz61PnMKEb/AQShTPT4Cx?=
 =?us-ascii?Q?ucVkhAu0PaDXQ4q/kpTM3rMGKLp1bYkquMLvhOwPw6uqOlLEWH2nQ9ehP87f?=
 =?us-ascii?Q?GpJ8UKwIU+Qrza+Hd52aHZDYsJ7nDbCowausNunPuVmkJGkoZ5+cNCHpaROF?=
 =?us-ascii?Q?R4Mjj2rpEvvgoXU1+ql29iBIQQGLb04qc1Cz9xNauqteBpK2zCn1dDkyHJhd?=
 =?us-ascii?Q?Su0NuZzOM3IRZusG0ZKMY5ZxWQSFpcyXFGCFP41rpFd27FQlOY8EPkXSapII?=
 =?us-ascii?Q?S8tLpiIgHPtUKGQ91H5vKRZEFm/0iXL+m5S9AbNygMWN9S5v7/MGplcRAS7W?=
 =?us-ascii?Q?bvrXfgEa3rpNSX3jqbFmyHWja12Ax2QOlaVP4acJdAVEW+c5FcapuuXioSH3?=
 =?us-ascii?Q?eA4iWyZPhZYvwDjeFxJdv+jt6Ma8PeXh5F8aiTpR805dJP0zmLQmusbY6dta?=
 =?us-ascii?Q?QgJCqtGtkxrOtMkrnHdBmjRgSaOns0I/b0lx/TUjHVUu9Q/8Biu9IzyNWeBE?=
 =?us-ascii?Q?6fe0/nS1vGibj+1+rHKJVBxCGeq2PHp7CMozRwS8kRISANjyzzoeRB6bJ5uu?=
 =?us-ascii?Q?ORwq0shbd8T2EdiHZznwpv9YRNtYQRHBshPEtezZ4Q33dKTx8KyEm13ncSig?=
 =?us-ascii?Q?yGUEqCYSFTgz9BEjRcKhs23HWB4jRF6HyXrHsOHjGkdjYIPc4Me7NZBILflT?=
 =?us-ascii?Q?Ud9jPUiFQet557JI9ZXsCAbp5ZRHrUtmwpiM70izUI8rmxWBBm2vmAsLsmeB?=
 =?us-ascii?Q?7XZWw70C9p6ELwrimRWHBKf+1w2FXxJ7EciUnrBnD9L+e0GpuGAsYxSyrSFa?=
 =?us-ascii?Q?KaO402nqdRf/WENaBOMpwXHs9edhRg5xTuciiIq5GFsKLwWFGPaoTqY3igyK?=
 =?us-ascii?Q?2AvDjkrvCv6l5CU/sjBBY1U+6YYikvJJqN+/1OcVFZR5jYuSfVguWFzjz091?=
 =?us-ascii?Q?dRoo+8Eerc8OvBfjGhknvqVp1dMIGGpm573i7ckUE0yijIEoEiK4xsmjse9v?=
 =?us-ascii?Q?Mg5OBkZhpV05sw4vcESAedfeu/2inJvQwlgQaoRizE7a74QbmkCmr/QiSE9D?=
 =?us-ascii?Q?xQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	it5y66L9ULuKmYJFbO3UF1E8nbW1WIuixq0bWYXpwjeEee/tL90wQNBnhxryoRH1AAMG+wFTJ1KoZr7yH3XoGixyT09f1TDBpLjCXrTxkG8K+xXvTwMSvwV5mqAGJ00dlvWKmBBjU9nNjUzA3Llrr9Eq1+k9LsJb1o+bP+yLeAoLxvZ1t9f6pk56bG95fy8XwnehoDT5eVrsDdzR10YzQEELd6zYnP/WsM2OLU0Rt+HFc2Cd86a035w913fJU2FgW5dcK4bXlfv/hPzXkgV297K210wuIrlQ9BuGL8wQJpvJmKiL5kt1KSDCiph1xVJlxXMYhBYQ2Nf6Gl8pf8FUUOrr8haRV7EIyt7G+UQ0EreR5f08SmnNZfDJ45NQ4UvJha23yX1TWG3rSJMDuaPtY0/yqaKpA7msSSCZUJYY40V1a8mF9KQkPmjoYyyooffJbYd58Oi4pHZYaXFp/KOMrs5hAxUi3DHbqQKxlPJomItPiMKRAx6ka1JsYO457bLBW5eoyAoca0drBrbrw1di94gOsPFavItoWJLjAWMiWW8bCRtAA6a+bwdJNoQuNphwXPkeaKPcprJQzgBcgHq4AapP67Pv80F6SJXyFcnhFi8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c5beaf2-eeb4-4cb2-70b4-08dcefa997ef
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 19:18:05.9073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bpZnjSeiBcjrbc2F9Mdb4ZWYQEZ5HfXwzrdDUFOAILTXVOh8oAERMqky0dQ5untkZouDIpTSRgcY+y9Criq7I96M/KSvvKIDsteU5Z6XW6g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6872
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-18_14,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=555 mlxscore=0 phishscore=0
 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410180123
X-Proofpoint-ORIG-GUID: aEVru-6l9SHrWGl8_uPpsbgutWlHQoZA
X-Proofpoint-GUID: aEVru-6l9SHrWGl8_uPpsbgutWlHQoZA


Paul E. McKenney <paulmck@kernel.org> writes:

> On Thu, Oct 17, 2024 at 03:50:46PM -0700, Ankur Arora wrote:
>> Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:
>> > On 2024-10-15 15:13:46 [-0700], Ankur Arora wrote:
>> >> Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:
>> >>
[ ... ]
>> Sure. But, that's just begging the question.
>>
>> We want _NONE and _VOLUNTARY to go away because keeping cond_resched()
>> around incurs a cost.
>
> When you say "go away", do you mean for your use cases?  Or globally?

When I say "want _ to go away" I mean: cond_resched() is deleterious
to performance since you are forced to have code which can do the
rescheduling check synchronously -- when this could easily be done
asynchronously (as the non voluntary models do).

And this either means poor performance (ex. in the page zeroing code
where it would be more optimal to work on continguous ranges) or
gyrations like the ones that xen_pv_evtchn_do_upcall() and the
Xen hypervisor have to go through.

And, as we've discussed before, the cond_resched() interface, while it
works, is not ideal.

Also, a man can dream!

--
ankur

