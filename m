Return-Path: <linux-kernel+bounces-210394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52985904316
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 20:04:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C75E3283988
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 18:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA86884D12;
	Tue, 11 Jun 2024 18:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="X9kCJdvL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="R7zF95PN"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2F381AD0
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 18:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718128962; cv=fail; b=NpQD9n76HVTa49aw2hrQVUFfW/GXnPr3cwZBda3i34vF8Sy9mcLEWY7hNoFeydDo+K6+wdp8/qJk+hDiz/4Vh5dybtIuzqVJfK9ZrjR305uooA+qeyHjXrb1MHkOdDM/81Xv5vz+ogOExHDSAYYtDPPSsOATFkbtGMffZnuSMb0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718128962; c=relaxed/simple;
	bh=2Qxvlqn684ELb88HmNbn4S3Hq7wIhyhTAIJfO3K0Zno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VS3lrOtAkmHFnpW2TZVq5vBXJ4GOtSt8c/SmN09KTeQQP9wxjqVI7H05mZIp0N73vd0jK9YV9CQH4T0rudyIsJuEU2IbnxPoB6CS0olLc/iFaAQ6Asn20hK0TsH9bSDo+w5dn0t9kPCK2VtYMu+zXTdRBu/hZknzILQkHit+F1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=X9kCJdvL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=R7zF95PN; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45BFkYpW028066;
	Tue, 11 Jun 2024 18:02:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=bMNMMbkVdKsWL+X9S/u4EznZThp+EIj+7eh8ailBinM=; b=
	X9kCJdvLz/Dnl7kAgMYiERJQ2BT379238nsGBNUlSQkvoE0X+RcXgUkQwyWd9wwK
	lj7zMv//k2HLxrxe1HYH9b32GFACNEBW7Vs3uD0mJ/DGw5ACGdjXzJFqf6+88rcY
	2uuFcbf+7DHEfASaYWM1IXblyFIjIf+Ghkj9d8MuGj39NRjuSmAKk9v8gWjluSCz
	o7SxjZ+6kN4oYO4dg7PEWOpUtOreA3jWgw9Amz7nZ/91vYdXfcfeeb9LMDchsbrZ
	neOk3eA7K90iGl3u4FZQAaxedZSY5HD/pHRR7xpn7QQRs7kHOG0lMMm9OldXfur9
	eHIb+dF0ekeiTLb1mXhvaA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ymh1mdfxq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Jun 2024 18:02:30 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45BGVBTk036740;
	Tue, 11 Jun 2024 18:02:29 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3yncdwm88r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Jun 2024 18:02:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V/rGPrgSXpvlMPYciMgsd1+xUJDfKK5UIrEVivMgzaeUgWrp0DYgyPlYIauJFIRx9aWRhBckDaiYbL+SxGC/jNIq2yVXF8x8GQGwXlI2/FUB9ySOYz3NkydmMFOi54iQuBiiH1drtTFFsc381+cB1cTDqWlJplOKgCqzV5l0UFr9XaTdnpBmqfw4RHiiMPmvbZexuEEUeNJ2dyCFx+nHTpdDpGwCrNRNRQYnpLrsyna4Zda66p/jah6c755qG228O8+zbL7yXia77JNyq2FlP6SStPg/vZTtAl7C5vZsr5aMpMCoudmrqJFgx6j8GDnFkU1VagZPElcST7OgYPetQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bMNMMbkVdKsWL+X9S/u4EznZThp+EIj+7eh8ailBinM=;
 b=lNQaPNf3ietpYRiIqz11Ws8xVWI3W6DObdJXaWy0DSbEaw5GlBamQYVgvhBUvSv//JAQQBZQvXKes0imnIP4CKSK+M2eaaIZc+VSySIi0iOmwkZdDHdTgObVm2gZLgVZUdfNA02nxwiCnSxQGMk2Nmd5S1pTgZKKFQt7LgQwqWtX9zC8cu6JDjjYE/uqG73WEKmZbtxxFk/Oc7gKACTARwlDkJwqxXxl/9t9LVfchgCTD2JqhR2Mw6Jj2Um8x+i1xy6yAwKoVAumtlNBkt3NdKve7cP5AkLcc6t9wztFHVz3APb8hh8jbKSBL1Ud87rXJ+u5qThxsRBnNM+ZOlAO/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bMNMMbkVdKsWL+X9S/u4EznZThp+EIj+7eh8ailBinM=;
 b=R7zF95PNZt+tu5UCY3jKy2DX73A6J/uPMtI0hoz+LwbHZvdo/5l7RxxaDKS98fH+29RguYuwlDUahet2zvTXiVTYvMMidpzjfdC/btBOmhjJOxClHmWjkazmobtdPkxzvSiTP1NhrDf54DbJjsXQGv8bz/zVP6Qcc4MHbTYJA5Y=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by LV3PR10MB7817.namprd10.prod.outlook.com (2603:10b6:408:1b8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 18:02:27 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.7633.037; Tue, 11 Jun 2024
 18:02:27 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH 8/8] mm/mmap: Use split munmap calls for MAP_FIXED
Date: Tue, 11 Jun 2024 14:02:00 -0400
Message-ID: <20240611180200.711239-9-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240611180200.711239-1-Liam.Howlett@oracle.com>
References: <20240611180200.711239-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0015.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::24) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|LV3PR10MB7817:EE_
X-MS-Office365-Filtering-Correlation-Id: d7a2ba15-4c2e-4087-8e95-08dc8a40a77a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230032|1800799016|366008|376006;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?h/jw1PkvYZs3tplSB/lHzlMddBKywz55DpWVKPg64DblTOGue1CmiWFPB2e0?=
 =?us-ascii?Q?5iA1qag+Tk6rPMnRajAWzCKp2XvLPbZO+nGu+SCVrawsgDm7Ewmvfqd5XRNu?=
 =?us-ascii?Q?w4ieqkJfato6gm88Ocnos0sc6fNr1Nxsi+ncy9pHI7MNy2f0Pb63BYIZ4lLY?=
 =?us-ascii?Q?F1NPyIRnHt2WHhHWDxmFxPjKLxzv/r5IDB7pmeQABqYOxrrqUGS++SC0usgK?=
 =?us-ascii?Q?IkkLqgBcy+M8t85SyaNzvxKsqZ9MTAinGa3DccCWaJuxWMnb1HxPeGpOYzKV?=
 =?us-ascii?Q?aaWXS1WM1qJFp+BEEVdXUyMHAJLaaCxEdqMqOdl4muWb5eR1xmijQsHSghDx?=
 =?us-ascii?Q?0c3sWKbOwOkJFg11BAHZZPcA2K+TIcnBmwCmQ1kcHOhaDo79iDcqSQr5ERgz?=
 =?us-ascii?Q?dsVwf2QjbLPPvfRzrndua+pvM6Ikkx3HoO1vnyYOKWs37cGP/CynfntXL1a+?=
 =?us-ascii?Q?NarCUCZbnuTzHW4IXOENcOLSqjHRIwDcX8sE7kIILV085aU9n6J8vclHa78Q?=
 =?us-ascii?Q?AUYY0QfWI5cBKenABYPeBxg5B2HtTUNBxSFDyz30Zv+pV67riedNgGr8L/d1?=
 =?us-ascii?Q?0idyyFW1bTBo5fkYM4ivsuD3f2z3/aYXmu7ee/WA5Xj7YKQm+IVkErSz9V6R?=
 =?us-ascii?Q?s7FuqmfEHbxLIe9IEycRPGl0kc0A0BlrVCN8D0HBoAvasdBWrNkwoNVKrSN9?=
 =?us-ascii?Q?6ieWITqYbRpUrECBpfD95OnFkpswMsnAT6c06gL9I9pRUNkAkIWqM+dUVGoJ?=
 =?us-ascii?Q?Y3Sw7qg1XUiJSeHg0IPfp4Ysh9rcQbVk2G07CEK84JgwEBlfmLl5Bm5YbfHK?=
 =?us-ascii?Q?hoWbQe50L+J5p4zaDziMNN+IzvYvTNeZkA09bmTEYNeELpG+3SeiKB+1JAHG?=
 =?us-ascii?Q?8doKRhIObPGz7Dn1n/uFxPEIDuiSuqnig9NJMRhr3BoAhQPUMIAIyuqrSwOg?=
 =?us-ascii?Q?OBg1ZbUzrypmmt5wzL2MP/BUlVQYfGWhG6ww8zIZOe7vhlFFcDZFfN4TVwc7?=
 =?us-ascii?Q?KuZwBlnIi6FIFYAEw1BJzLAoIorD88zoBL5HQzH/GOarHnBkZmpbEJTbAX7f?=
 =?us-ascii?Q?yKtcohiLQGZ10pYCMEcA7amwjOhKoLkyfwrZ6qBD01YClbP0vB2y8uOqujuA?=
 =?us-ascii?Q?WdS1GmxxmmsmgYwN5L7HB1N1zeNKTSGhQIEv1RAptE/y54nZDNoqY9Kx24xD?=
 =?us-ascii?Q?thBax0rvWT8ZVsjHHzNmEwflNNsjxkl90nhXbeQUBKhaWFyjDYDLeeThQ7F4?=
 =?us-ascii?Q?1EOCLRD3kItMs8POjjxA+v1/aCCj+Kt6TkTupb30/3UjjIkTDTfey4k4JEVv?=
 =?us-ascii?Q?1EQ+xtX5IhwX7923Q6cYmhTi?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(1800799016)(366008)(376006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?jf6GsIjh9iPCsDf95Q2U6lVvbXAcNzHt270ExBOBbkiEX5tHYcGoKOO7ekGY?=
 =?us-ascii?Q?u/USv2EjicyMWwX2OG2PwYtZ5LGTpKWD1SlJnBPB/iHm3ZaAy8fy53H8kXT3?=
 =?us-ascii?Q?YGRluxup3LlPIEpn9Pf4+t4Yu/vG29DcNEVp9ltuU0YGGCiUsbjPw/WtwAZ3?=
 =?us-ascii?Q?TQYMq0MVJa3RiSloypc4DFcruXiXjy2FOi8rMyeuZtqTl7RWTyoi/bCL4t2F?=
 =?us-ascii?Q?af3xfYQQnGGcZUp863HDLOBNt/I26vRcNVJuHeA4iryikEn6TYN9yFkOTMzk?=
 =?us-ascii?Q?fKuN+t6ZOby7Zyd8A9Z3TBPz94Kiy0L+Ql30UjlaJH6pkPegPlQtu7Xj2R/5?=
 =?us-ascii?Q?vzw28YMAwmcatFmo8FKhXqtcL5Zs6HmQFOJ16R5H+JzNhXXS23Q5jU3ST4mj?=
 =?us-ascii?Q?CmFZFbnIx09DlLyeeGx/M6z4wqT4VFzNrlbMJaEqTEjpa6hfC9vD8OfMYiaC?=
 =?us-ascii?Q?Px7Y705+NMzTqgbd1qGh5KmxIKtRBQwEweRSTt6dRVw+MfbGpmNySj80rHTi?=
 =?us-ascii?Q?0BlzfWwQNlMM35uPWgABir0gyhYKjUpnXQ9T1cBc750aDyqh4cmRzulJOikG?=
 =?us-ascii?Q?YZrmIWQDXhQvHGaYzTxycc9EHuD4VPXBq0b5A5hGCT6lAy9Ib6jZegl2bfgj?=
 =?us-ascii?Q?PLqeHheNy/TT7IBl6UNX/2xwnbtuKJ2eGkGIL/Yn2TsmBF0R6d2gvA0EOZ8N?=
 =?us-ascii?Q?DoAMwBD+s9iZKcJz2wrG33RrCcCN58lL8JZVtsjasI8T4h3o7AEBPbjf4tB6?=
 =?us-ascii?Q?8NuWbxddR1whGlR6+7RoGe44+bNuen++ifyq3AvOyAIJcrT5YndNS8saL608?=
 =?us-ascii?Q?HjhiT7RPcaSSYeATO/Aian3D1/Wc0Aeuzg66HHKiIns1SlGnKXLyTaz5BHM8?=
 =?us-ascii?Q?QctJ5tALB+7Ypxywzx76Uln0x2o+1x4Nytv8FixLKY06ht+RQFXNublvQS7a?=
 =?us-ascii?Q?vMlYQkz7lKg3QLir/rrfvtWmo0mm6s1eL+HVKIsQxIHKs6vITtvpSDIHXc/d?=
 =?us-ascii?Q?RytWKQcg8tyicjqxK35HE6ot1nJjB5IEUxTkVwZeNNcHr7mxRkC05xA8wNlk?=
 =?us-ascii?Q?bog+uJiLUaDax5VQAVAlVZ5RkTRP/ltglqXLaSgQhvEtzbkIJtZRWGvWcJDw?=
 =?us-ascii?Q?Uf6In3luN03PNIYjQ7JDnIElG4i42ALfGywU98TAb5n4ucyijC6Zwr3/uA5P?=
 =?us-ascii?Q?uoluN2wV3u/alibFabcEGZIzahogMUw8fkQKHX4JciJiHpH4A/fWpwsupV/b?=
 =?us-ascii?Q?OMm2PRscEYnceSHsSJ1O31uzwOv0IMin/TVrKQNvFRUTgXb7IRHdEwGtLd4d?=
 =?us-ascii?Q?QOG/tqKfBQSwVDe6QAJ/4CFDKmmbQFszgXE+hD1npJkBT5ag8Xfk9vAUq588?=
 =?us-ascii?Q?y8CY1DU4xgaeDuWF5+RxYnBAeXcgHWw1s4fgN9kD2QlBQ7AKJSc7ZJ4Ocrxm?=
 =?us-ascii?Q?mBD4XsSnNpGLaa397G5pM1HD714BAln7oCeexj4hS56CtDeqqM9M+cpayKUp?=
 =?us-ascii?Q?8VleBkSlMtXZ702vfsJ5+9wnRhs8tiLV7LjF0GI6Rf/iDjR2sUOtAEGQOiBi?=
 =?us-ascii?Q?pRCSFXZRWSeShzma1hRmMwnHVhcMcaQFnWvfLF/v+F+rE2UONJDptvGicYn8?=
 =?us-ascii?Q?Gw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	7q9HAcuNcMq8hsO6KfBq/ofsMhgpU52EATv2ACEoE4VuOZFHhnMBmxwsjzK9tkfYdCp7Aj0xBceKvVJOMfBDOG+/Y8hzlFqDDmEL7X0YrrYCkJYnCsRZL8IVZQVy+sFb6HBcnAq51F6gq+z2Auw0Gf86svGZH17Eu6Dkvqgr1//MEmhIcq/sQADMiTQpjylDHMGcZkZehs4aYNWQnX+HwxC0Bcb9bcN92teJ3bu7Hns+AuL1BEyMzVgVzwIK+q2C2Au6UH3nuPwtVDuHABd9wJhrY9l1N0k6bI+wuB3sbLKp2PrGm2U2KA+yaY5/7fZTcJ0OFCNpTUaECj5T8kGNFJHS9MlbGkFoky/gYyAvxt7U9/mi1hu+Rnc13mi8IzXcuwAL74vUNDTSShhUcxWOENnE3DAoKfAhcRebQ3+2lI6rn+iY+qaQpYVOcBKt54KNrknRhnmeQpetSku/UcTEeeIc9EpKjbV73KFQot0OCEHSMyNgdNLhBYNRFIRZyaxPIc+s/Q6rIkBXIQ8eUZNIeu7bTyWET8N0cXE7ax8iHe1/gNSDZHvoVHieQOu+pDEwBo7Q8oMadcCKTjfrjWjGPy3e05sBERfEtVmN9C5tIaQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7a2ba15-4c2e-4087-8e95-08dc8a40a77a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 18:02:27.3447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kr0Ij3bgVe8GBlOBLnEtPBT3gZ41HtUZWy2KEc5B0O03RqAswbTkVUL9LW0Dh00i6c+5wBrNySworcHoGB56FQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7817
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-11_09,2024-06-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 adultscore=0
 mlxscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406110123
X-Proofpoint-ORIG-GUID: JH-8Vu6UdR-jT6FDVW5I5Pt1QCmeYvYq
X-Proofpoint-GUID: JH-8Vu6UdR-jT6FDVW5I5Pt1QCmeYvYq

Use vms_gather_munmap_vmas() and vms_complete_munmap_vmas() to prepare
and execute the unmapping after the new area is written to the maple
tree.  Delaying the unmapping avoids RCU readers seeing a gap in the
vmas, which isn't supposed to exist logically.

Gathering the vmas that will be unmapped allows for the accounting work
to be calculated prior to checking if there is enough memory.  Using the
number calculated during vms_gather_munmap_vmas() allows code to be
reduced in mmap_region().  This removes the only caller to
count_vma_pages_range(), so the function has been dropped.

This does have the side effect of allowing vmas to be split for unmap
and fail may_expand_vm(), but the number of pages covered will not
change.

The validate_mm() call in vma_expand() must be dropped as the MAP_FIXED
munmap may be in progress.  There is still a validate_mm() call at the
end of mmap_region(), which calls vma_expand().

Note that do_vmi_munmap() was previously used to munmap, which checked
alignment and overflow.  These checks were unnecessary as do_mmap()
already checks these cases, and arch/mips/kernel/vdso.c
arch_setup_additional_pages() uses predefined values that must already
pass these checks.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 85 +++++++++++++++++++++++++++----------------------------
 1 file changed, 42 insertions(+), 43 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 5334077964b9..e9f91b7b17b6 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -364,23 +364,6 @@ anon_vma_interval_tree_post_update_vma(struct vm_area_struct *vma)
 		anon_vma_interval_tree_insert(avc, &avc->anon_vma->rb_root);
 }
 
-static unsigned long count_vma_pages_range(struct mm_struct *mm,
-		unsigned long addr, unsigned long end)
-{
-	VMA_ITERATOR(vmi, mm, addr);
-	struct vm_area_struct *vma;
-	unsigned long nr_pages = 0;
-
-	for_each_vma_range(vmi, vma, end) {
-		unsigned long vm_start = max(addr, vma->vm_start);
-		unsigned long vm_end = min(end, vma->vm_end);
-
-		nr_pages += PHYS_PFN(vm_end - vm_start);
-	}
-
-	return nr_pages;
-}
-
 static void __vma_link_file(struct vm_area_struct *vma,
 			    struct address_space *mapping)
 {
@@ -692,7 +675,6 @@ int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	vma_iter_store(vmi, vma);
 
 	vma_complete(&vp, vmi, vma->vm_mm);
-	validate_mm(vma->vm_mm);
 	return 0;
 
 nomem:
@@ -2870,47 +2852,61 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	struct vm_area_struct *next, *prev, *merge;
 	pgoff_t pglen = len >> PAGE_SHIFT;
 	unsigned long charged = 0;
+	struct vma_munmap_struct vms;
+	struct ma_state mas_detach;
 	unsigned long end = addr + len;
 	unsigned long merge_start = addr, merge_end = end;
 	bool writable_file_mapping = false;
 	pgoff_t vm_pgoff;
-	int error;
+	int error = -ENOMEM;
 	VMA_ITERATOR(vmi, mm, addr);
 
-	/* Check against address space limit. */
-	if (!may_expand_vm(mm, vm_flags, len >> PAGE_SHIFT)) {
-		unsigned long nr_pages;
+	vma = vma_find(&vmi, end);
+	if (vma) {
+		struct maple_tree mt_detach;
 
-		/*
-		 * MAP_FIXED may remove pages of mappings that intersects with
-		 * requested mapping. Account for the pages it would unmap.
-		 */
-		nr_pages = count_vma_pages_range(mm, addr, end);
+		/* Prevent unmapping a sealed VMA.  */
+		if (unlikely(!can_modify_mm(mm, addr, end)))
+			return -EPERM;
 
-		if (!may_expand_vm(mm, vm_flags,
-					(len >> PAGE_SHIFT) - nr_pages))
+		mt_init_flags(&mt_detach, vmi.mas.tree->ma_flags & MT_FLAGS_LOCK_MASK);
+		mt_on_stack(mt_detach);
+		mas_init(&mas_detach, &mt_detach, 0);
+		/* arch_unmap() might do unmaps itself.  */
+		arch_unmap(mm, addr, end);
+		init_vma_munmap(&vms, &vmi, vma, addr, end, uf,
+				/* unlock = */ false);
+		/* Prepare to unmap any existing mapping in the area */
+		if (vms_gather_munmap_vmas(&vms, &mas_detach))
 			return -ENOMEM;
+		next = vms.next;
+		prev = vms.prev;
+		vma = NULL;
+		vma_iter_prev_range(&vmi);
+	} else {
+		vms.end = 0; /* vms.end == 0 indicates there is no MAP_FIXED */
+		vms.nr_pages = 0;
+		next = vma_next(&vmi);
+		prev = vma_prev(&vmi);
 	}
 
-	/* Unmap any existing mapping in the area */
-	error = do_vmi_munmap(&vmi, mm, addr, len, uf, false);
-	if (error == -EPERM)
-		return error;
-	else if (error)
-		return -ENOMEM;
-
 	/*
-	 * Private writable mapping: check memory availability
+	 * Check against address space limit.
+	 * MAP_FIXED may remove pages of mappings that intersects with
+	 * requested mapping. Account for the pages it would unmap.
 	 */
+	if (!may_expand_vm(mm, vm_flags, (len >> PAGE_SHIFT) - vms.nr_pages))
+		goto no_mem;
+
+	/* Private writable mapping: check memory availability */
 	if (accountable_mapping(file, vm_flags)) {
 		charged = len >> PAGE_SHIFT;
+		charged -= vms.nr_pages; /* MAP_FIXED removed memory */
 		if (security_vm_enough_memory_mm(mm, charged))
-			return -ENOMEM;
+			goto no_mem;
 		vm_flags |= VM_ACCOUNT;
 	}
 
-	next = vma_next(&vmi);
-	prev = vma_prev(&vmi);
 	if (vm_flags & VM_SPECIAL) {
 		if (prev)
 			vma_iter_next_range(&vmi);
@@ -2957,10 +2953,8 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	 * not unmapped, but the maps are removed from the list.
 	 */
 	vma = vm_area_alloc(mm);
-	if (!vma) {
-		error = -ENOMEM;
+	if (!vma)
 		goto unacct_error;
-	}
 
 	vma_iter_config(&vmi, addr, end);
 	vma_set_range(vma, addr, end, pgoff);
@@ -3082,6 +3076,8 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	vm_flags_set(vma, VM_SOFTDIRTY);
 
 	vma_set_page_prot(vma);
+	if (vms.end)
+		vms_complete_munmap_vmas(&vms, &mas_detach);
 
 	validate_mm(mm);
 	return addr;
@@ -3107,6 +3103,9 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 unacct_error:
 	if (charged)
 		vm_unacct_memory(charged);
+no_mem:
+	if (vms.end)
+		abort_munmap_vmas(&mas_detach);
 	validate_mm(mm);
 	return error;
 }
-- 
2.43.0


