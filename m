Return-Path: <linux-kernel+bounces-525336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DDE0A3EEB5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 09:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06FF2179109
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 08:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618C21FF1C8;
	Fri, 21 Feb 2025 08:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MOvwBMx1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="X9ihnpq6"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D241E1B0406
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 08:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740126696; cv=fail; b=IBYniOl1eTzseG2cuhilhifnmArAXi4bpz7phPWUVNhxVfTt7v345dt3wNBPB1iN63QHl7NFeVedgNAS2ar4zlIOC4lGmxCB5jCcNHJPlXO1ZTxzhfF3ryRGLrDp4VTLYKVuoDMyArZr9vgGs1bhN5fbCLnxWL/E2wg3Ehx5vVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740126696; c=relaxed/simple;
	bh=L8sbZVZ/PrvkTkned21x9qAeGwlNvxCcrfpdIuq7K6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AG9QZue0pHi1i2U6KycSa6pEU5JGDnbDjtwuSpmT7fpuCf1kuHUraCpbqwDIDdhzB+PDmT2ZU2d5EIyIpnPmvv2zO8NaOHcxVE1FOFnntialsO1u4p943Hg6yxI1hZ8vjnlM0eWOyVHPAKv8ZMauZFnltYrTpmFbzb6Q0M+w83g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MOvwBMx1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=X9ihnpq6; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51KLraEa027078;
	Fri, 21 Feb 2025 08:31:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=3KV/XwRoD+BBlyGQvE
	wVWAVtyN3795TPrYN4xojxULc=; b=MOvwBMx1ed1R2tSj+E2xU3mrP2cUbJs/t9
	YLN6Zjyw7RHCO77Qhu2V+O4Q2nvGLPRs7PqwnWGx5lpAvcgZNqVsXCAvO3Tm7YQj
	8r2wbxDsoY9OIDa5jHSXE6ftlgUYJC24zdXIzTFBYWZgGPZfI/wakeV6mTmqkd2E
	SVSoRelIuTaUanznOQG3XnAXitaVzbKohkqPP/gwiZKqsZXDz/t886a79JdcI+n5
	nQbXfGrCK5Bc8eeNmuYfzzD99OgDycHxl8yXTlvBLyGn9EMcr8wD6nhwHIFC56tv
	I8jsW/zRJmVeeA7ivAlaJDj5xwwa2YCJNWTETFJ5HoBdjmBQMh4A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44w00pwsw3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Feb 2025 08:31:08 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51L74NuU025341;
	Fri, 21 Feb 2025 08:31:08 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44w0906uv7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Feb 2025 08:31:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jg57ePd+dQUI5U0/eA40AycAUPsNvZ2dGSAceJBG3xJm1EIq4OlHx2GrtalsAigwFiBqdkQWY/G/wN86qJd+j6q3aOCDVo2pHML8f9UR5mkDGY/NISmIhWnQs2uTQ/a07K/KJfDVcaf7vg9MAqWd8grhACWKpEvaq/m6KrcxhnZOdwYWZ6EQ2BHVWX1/n04dy3YIotjyNRWBEqDRu53WadWxewhaOYIiYpDDh/EV+n2rgI/VGkysU5yXdFhbuUcSBZB9okiWCiT5q+NLVkRVuSiI7ArRiXtM5OSO2yKEdXWLYUJs8lBsmNf2C0v6zQFQS07DdDzUNQhhxHTLMlTuEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3KV/XwRoD+BBlyGQvEwVWAVtyN3795TPrYN4xojxULc=;
 b=jk22vHWVdDpuaS19nkFe011DrO8dnSGNb1UKDWBEUSA/M0czzqxBxIKwO5LUun6sPiLYvjoe505SR9WJdvWGxo5kh5qBORMRAMXvRAGH6WWPte9ugRWEBMh912xWNNgXIydnj1YHPtFoisEG3AEo/mwPIrnS4jlOiRiHbLKn47mtAmQVrakjtbgPYsmn6YGQjlpqEoX/SUIiSoti6PqBvaohuqYhzwzsKzEfL2BdtPMIM/sDhL/pkST3/x0v9U1J4dp2CzW8XYtdchCT1ulSnvhLsnWrvY9IG49uy2QVHOUpMntQLkYVZfd5Cjn8MVtxeGV6Ag4lL5dCNbvjq+eD7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3KV/XwRoD+BBlyGQvEwVWAVtyN3795TPrYN4xojxULc=;
 b=X9ihnpq6VCqKGMQ7NWxzWhvR/L3BeS+0cl1tQ73+4sP/h3RwahVWyJldoelVkOyDiB5iPKvai1lfppGQE/IAgsbDzByUscb56Ny/ilhnSQt5FeTnsIKE6UJWhOqQa1DvPg+3H22RbtRwhgfkf4rzcmKKklez7GvYXxglzjnyhPA=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by DS7PR10MB5181.namprd10.prod.outlook.com (2603:10b6:5:3a1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Fri, 21 Feb
 2025 08:31:05 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%6]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 08:31:05 +0000
Date: Fri, 21 Feb 2025 17:30:59 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Hyesoo Yu <hyesoo.yu@samsung.com>
Cc: janghyuck.kim@samsung.com, vbabka@suse.cz,
        Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] mm: slub: call WARN() when the slab detect an
 error
Message-ID: <Z7g5wyjsP1ktucDO@harry>
References: <20250220033953.1606820-1-hyesoo.yu@samsung.com>
 <CGME20250220034155epcas2p156b90cfb655a03cce4bfac9683f0bfe1@epcas2p1.samsung.com>
 <20250220033953.1606820-3-hyesoo.yu@samsung.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220033953.1606820-3-hyesoo.yu@samsung.com>
X-ClientProxiedBy: SL2P216CA0089.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2::22) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|DS7PR10MB5181:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b1ce968-bdf1-4247-6d68-08dd52521552
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZFw5U419SYTYYKBRfFe7++aqAPftYOXZY5rhOCE7S6YnLSWZyRoDdtjgeelm?=
 =?us-ascii?Q?cgeB4FZCvs6SoDQbPcuzKetkhR3xJtBKTq7L5bwnAFu1XRNuoZKHIpChQgOn?=
 =?us-ascii?Q?koSWASwnyyjO1BGHz7mk0kR/lsTpARbXYOeSKJuiDjcEbmksp0JVptwRlYxj?=
 =?us-ascii?Q?whERvPOkVc7LqYAneeqBJuNvZnee0Z+sGWsh3vMRVY6jsL02y8BEQx+jzW5B?=
 =?us-ascii?Q?DJN7jwewBQmd4eVp1ImTNC6+WKg3HMaC/5Y/smuJZqSrKw7O3zyGFfc5SpLk?=
 =?us-ascii?Q?P+/56r+bhQfLUmemvekujckn7Ah5KrutZdjRxbj+0RaHhf1DcP2GjSIf0dB+?=
 =?us-ascii?Q?IlqvhUpvspfURul8+PWyP5/Fu2/EFvG/ug3qUPh7uTP6xEUugPUuGLn6vsck?=
 =?us-ascii?Q?+bpq+3oFuJrKsjD/N2XfOMS0fRQPY5E4lUs+eHcIo9j7BMv2kWfZ/RiAaGa1?=
 =?us-ascii?Q?x8vXxn8JLPPWjhN3bQVwwJFOnbXG6f3ruJTNqtRbx1ETrpb1jGQTG/70kWUt?=
 =?us-ascii?Q?2QanaH6bt9Ppi+7HXCCk5KF/W9jMEfSXBdPF0XL7VGrleZXa1kAZEd+v8sNC?=
 =?us-ascii?Q?/XpO8ElISjCJwySYFw1yRsnSvELtcUxkPgeJnCYZluCXus+BZ226aewfs3y6?=
 =?us-ascii?Q?ZbdaunR8PKECk6agMt2tdxCvbSCUObbYISUgvnvz57hXazLmI5R8yP3yEqSn?=
 =?us-ascii?Q?oTX5aJkZI3W44PHBw2LGJX785SL0IUhgQUFISQkXaZEfvsIDtTgNRaITQhpF?=
 =?us-ascii?Q?c9TWOmxp8+IQaEteKt3s6WiAZuLRZ1xNmLSc5DOxzScACXs22CQwmtXCBDg6?=
 =?us-ascii?Q?2ibkPU8bfwHs25D3aBEZaAcyZpZU6gDaZymbTZvoVmGqR7LOQlAR8eh8+Goo?=
 =?us-ascii?Q?YVKrzbptChY3+M7m6PfmOP9s1gxwF4ZsygEH7+JVR3xk67vZ8l9aoNZ6AnSr?=
 =?us-ascii?Q?ZF0hFrrklfqSGzEcGZ5udIadsFhWLQUtZeRIBu138mDjLNI91etwb56xBy5K?=
 =?us-ascii?Q?GtzY7CLotBq9nXszgwXGegDTFKgWrLI2jKBck1atPmM91TwEOV5wt+VyjRZM?=
 =?us-ascii?Q?wePgXVkjLAExHj28xC1xnEwsLqRoodrszlonfUdAACQblOKnf5ncaSGSLUyh?=
 =?us-ascii?Q?YLR6Hi88gE+mLTSm8dPEUszx11s14k4TOx7YqH0B9jNDhzBT9o0g6OdiOrG6?=
 =?us-ascii?Q?2/eq/hqfid2jKOBymne4CMfs0wjo8QW8GwPPhrarzS0m7nKUvoIlJKNsQMFw?=
 =?us-ascii?Q?e1rqmj7rsU7qmZZx2jACtktU/wkfkAolhQJbhewov6k/b0yxCIFHdaR5PJUb?=
 =?us-ascii?Q?in2D1arZkN5ePW3MNUZlJENZV3cTzMdS5mr127+Owsk6IdhON9LMMr2kHAcj?=
 =?us-ascii?Q?Kx3eLttptkuNGoc9VpfDfqW+/czK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BbTm0WojiNy0uFUbqKObC8hI/FwqUgzZP+0b+zvZKY3lrgJKQnIr4XVJ38lR?=
 =?us-ascii?Q?q4ZLkMUOqpPKZcUG/HCY/MxE6QUb2FSIN2rQw7BQHBHStW9rHx7RkTIMOUhr?=
 =?us-ascii?Q?A8LqVulLsZIMJa5Gg55TzhyLOBdASv+4DN0v8YNI3IDeEV1dtqpxQiMUIyfF?=
 =?us-ascii?Q?6LBiATcuOh6lcgFF7C2MIcfM/5M+6H+lp8ddVag+5CirSPROO2ZNV/vHK1/4?=
 =?us-ascii?Q?SGKnEscZVxYwBu3rt9OPP8ob8UO67B2roDH6cGh84LsE1ZCwhDOBMLqrxYt+?=
 =?us-ascii?Q?tnEER78WDuBQK8Vg9/Shu5DWMlXE7GaEKkf06+XhnhdVSAEP6BOEXi8A0o7W?=
 =?us-ascii?Q?NfDwGhsYALmaTJa8r4xkczho1yrevCqJigDoeb1NVKQuegnDm8JystB2BbQd?=
 =?us-ascii?Q?mUu+3eRhNHD+NmT81bvsjikjjlIPNcrq1jSUGiDNTYH5Zi8+Q35gUHRPo/BB?=
 =?us-ascii?Q?Rvlqu/DMNW8sXVUZFWfMYQ9dYk7yQoGWiX5UMKLWiWjLLzVDCqiBwkGkJuPu?=
 =?us-ascii?Q?AZCaLz3Pa3osK6W9yP7ZXqeluWYPNZH33WyUkfgY2djjvgMrcwdEem4NeN6L?=
 =?us-ascii?Q?aJBDhQ4Lcwa+X4PRqhf9Y/2RAA832I5/woVPguf1owHU9ciJQAjx7vy3346B?=
 =?us-ascii?Q?NfvB/2Ogf20tleefYFLkgs0PKxu/EuWTJApJdOPp1rbFE+STHvEjuBP3osPO?=
 =?us-ascii?Q?rD81QIq0egOT6i1wtsDuPcub02GZXoN+GPDQ63/uNgvtMSZWuueuGkuSHZMu?=
 =?us-ascii?Q?Uxwvt9pzS7GkrMdwVHBiBJuCegAhbvEoU/rhYP6KHMzSDwycLti5lFyux0/l?=
 =?us-ascii?Q?/YDXT2nlt0tP2Scl6iQDkwY2tUMviiEFYn3qWVVSEt7ZawwAaA1tSSekx1HK?=
 =?us-ascii?Q?+hD8qGOrbFnRQUlPe3gHoUt/Y3iwflxkGRDfJr2x087Qd4yzvIZa9KG2BjW1?=
 =?us-ascii?Q?7837Kqh2P/oZdYaVBHOchJQ44cBTnS6I9cjkZmQfRwdAT8fuLawsVwBiTAw0?=
 =?us-ascii?Q?tRlmQtS3iGxrmPA7eTF7hYZez29WlPhZC9rPY/W5mJ5SgPvY/pGYx0Wxxt13?=
 =?us-ascii?Q?37I0yH9rnOCQldZXS0h87m82Nan3kD2DxJnaqNhjEz+9Xt7EtfPhY8ncmWwr?=
 =?us-ascii?Q?5SHq3UG3FojjqO12PGguJ+Lh05mv/mIz+wiNEIYVMQgVmkDDNKpgSG/Xg4M7?=
 =?us-ascii?Q?6fF4Ua1HthlD4uFg70eVPimVr53WYQTEU815InwcS7QOYLstNp8Bf+9apKuR?=
 =?us-ascii?Q?llFRyeYPTho5XpmcJEKX7GpRO6ufu59EP/rfF77e2C6tGoSmG1N0EaWKEeiL?=
 =?us-ascii?Q?qzUCYxrGkzWXJttbmMRv9R2t1ts5AgnEEoEgYy7K+6xWRTMRSlt80ef7pF+p?=
 =?us-ascii?Q?p5lJ4EMBhBRyI9cUYrpxXYAJ0cReyOyJcMpGw5L07EER1ASZa8w/G1hO3G8u?=
 =?us-ascii?Q?XqDlEYkxIojRkwugSZ35xx9s9hvIWB/OlB94owzlrFiNOtXDy5k16CZSVsKq?=
 =?us-ascii?Q?DYUxt443Yzu82QlftzHDUnC8XGe0S77A4x8DAWqX7rWQZYWofSnXcjN7Pv/C?=
 =?us-ascii?Q?Q9ONL0BJwRDjG8LzNBtx6Zyg54VdccF6cchsyVap?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7bNEiZFXxlHU+qVfqJyYVaKkDX3OszqXrSGksqIHAzEqlqn+6xFjFB5wX+oDIiBH5ernyElN+MHrPEQsP9hpbUdLTE5xJVq+32NngJ0w3qC+8Hfu+i2WOKLEK13Snzda9NVggCmIybT8tFPO+q8fR/Pe6Z9zEDLxZQQ5I32o5kh2PHDUVcHyjfB7m13bRceqEQ9O6E/Gicy07WHvF4gBXaw2gC+DsIaJ7av0ylb4sp4uDHOpXbp3tzWGFRuayUBOk/STfXbQNdPUrxGL4HLjZUgC4r571dBtofM8nPBTG3ftX7nHitL45o+qpmrex5xSbbQ07WYFhp1Tf6wLtgbeGcg6HX+AvXAWvg/yOK4/Rjp4RLbUs/x2phQdlGQk+x/UisMRgzrmW5hxGmGY/P2YE+l0DQgb3aRGNd452+ubWl17ln35spNAxId1/l5ssDPFmmJBMs6AknciuTdjTGIp3yrj6fHtz8bKEu7pHEeg9BsLe1lUoSE21i6v2UMGIQOYXYXk2OTa8i8RwGvWohq/Mki9gFUnl4xelQTXjQY/NOn/rTybBVHlEjZScibt33UtYFHDumbpm9aXcoHCdzL8PmgHwzMFchScxJD3LjrVHsg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b1ce968-bdf1-4247-6d68-08dd52521552
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 08:31:05.7023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IAP7fJQVuhHbFBfZ+Xr6oIyjsnqLa2Is+YkT/zPA4rBDOFrI6Jm/rbNRrvQYD1Zfh+p6xd6OTWRCsefAIuLNdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5181
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-21_01,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 bulkscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502210063
X-Proofpoint-ORIG-GUID: RWDNdAOE6qgXCrI91eNBqvJpi0xAQ3vY
X-Proofpoint-GUID: RWDNdAOE6qgXCrI91eNBqvJpi0xAQ3vY

On Thu, Feb 20, 2025 at 12:39:44PM +0900, Hyesoo Yu wrote:
> If a slab object is corrupted or an error occurs in its internal
> value, continuing after restoration may cause other side effects.
> At this point, it is difficult to debug because the problem occurred
> in the past. It is useful to use WARN() to catch errors at the point
> of issue because WARN() could trigger panic for system debugging when
> panic_on_warn is enabled. WARN() is added where to detect the error
> on slab_err and object_err.
>
> There are cases where slab_err is called before meaningful logs are
> printed. If the WARN() in slab_err cause a panic, these logs will not
> be printed. WARN() should called after these logs are printed. Thus
> slab_err() is splited to __slab_err that calls the WARN() and it is
> called after printing logs.
> 
> Changes in v3:
> - move the WARN from slab_fix to slab_err, object_err to use WARN on
> all error reporting paths.
> 
> Changes in v2:
> - Replace direct calling with BUG_ON with the use of WARN in slab_fix.
> 
> Signed-off-by: Hyesoo Yu <hyesoo.yu@samsung.com>
> Change-Id: I90b2ea9ffc58e3826f7ae9f1a774bb48c2d43bf4
> ---
>  mm/slub.c | 31 +++++++++++++++++++------------
>  1 file changed, 19 insertions(+), 12 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index de62fed12236..7f0583a71cda 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -5473,8 +5481,7 @@ static void free_partial(struct kmem_cache *s, struct kmem_cache_node *n)
>  			remove_partial(n, slab);
>  			list_add(&slab->slab_list, &discard);
>  		} else {
> -			list_slab_objects(s, slab,
> -			  "Objects remaining in %s on __kmem_cache_shutdown()");
> +			list_slab_objects(s, slab);

Could you remove WARN() in kmem_cache_destroy()?

When a cache is destroyed with remaining objects, two WARNINGs being are
printed, one from list_slab_objects() and another from kmem_cache_destroy().
The latter becomes redundant with this patch.

The WARN() is added there because it's good to catch such an error.
At that time, slab_err() and object_err() did not call WARN().

>  		}
>  	}
>  	spin_unlock_irq(&n->list_lock);
> -- 
> 2.28.0
> 

-- 
Cheers,
Harry

