Return-Path: <linux-kernel+bounces-547643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9257FA50BEE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 20:50:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEC1C1894E08
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 19:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE5816426;
	Wed,  5 Mar 2025 19:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JEOpdwYd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FKQV44Qo"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9194524C07D
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 19:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741204221; cv=fail; b=Exm0961abv4gzWpDLBJ3KHAMSqnbZPqoHwkHjeWVnZ5jV8HZ2SOhgpehocjCrKt4i61apiGvtRleRIZnJAMAidIiSw9q30GqO26YKvjVAKmBurmUGWqdsZtDTCFFlV+jgRy8q5LpWXrNDfDqacfhr16c/ouK9PGPkPN2/reozcc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741204221; c=relaxed/simple;
	bh=23SNkHqkWViNafAy9mXfWNOrNgnvrDEp4XdXFaCfqu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OUSX+k6hYpzuuMCQGd5YDUEPMey6+oTHJSiseUfT2BGpEfgz5f7SjpvdCAtLZg4Co8c55Wjfr7yWDZ2df23wzcrTv+Ngb1hTcDdsCYVr+VD2GUzLXJ3h8P8af6ApssPSgql40aD1zHeltMqcKrMtbndBLSQVjVky4TvZ1JYryZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JEOpdwYd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FKQV44Qo; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 525IMfnG019618;
	Wed, 5 Mar 2025 19:49:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=hEeykiBbJ7MiMNOPUm
	V6GyPzH//QX/c7TfO6oAgzLiM=; b=JEOpdwYderozb8tF7z81Pzzu71xGF5+DBp
	lHHibmFPqBhipmzlGFXBotiv5XywhQouH4MXpppOc7PSHrUxeE0L8WiQkJh04M8u
	zf8yx2wjtZuCehPKaWnvKRGrM/aRmj4v8iab0ftO4N1+ULuiZphjsGXFGf6swe0D
	ysTQWnJEnVjuIFki1esREuinoDjekgHihFE6PcwMUDznLwgdUHCRp3cUSMcC/Qg8
	QXk+0/UAN9dXXvAbi4YjRStdUpKGr+0Nie5ajBdNGLrbkHhukqo67/tHy1+x3UTQ
	uT6qIXKOb6KiXfUD5SL0uJNCsborgAuPtmg9l2ES218WHMjdRk1w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453ub78h2t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Mar 2025 19:49:56 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 525JiCmP021940;
	Wed, 5 Mar 2025 19:49:55 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 453rwwuumg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Mar 2025 19:49:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HRPJnhT41p0Fv5/5UrCZcHjbX14L+bASKZrZaLIzBvACuiljMPBC7OhZ+66ahfecrf7wP3liHHyr0Bl6L8M9HF6haL1K/4H+O6a5Xt8nTWnigCbUDTQJmm4y0El4MinVincObgsNYBbjJMNLUv4WwBGRhlzPUKYaoKrYKfbhGb8q2zJucKSD5rmPPrvnVRJxBJgxf/WXIeeFHdB3g113UWuPvomFqJnUA6GLznK1Kq/c0O9P+OGJdz+CQYIU5bHM/7YKR9fo270WZPdox6YfnH3dqrX6FzP7sunA4I14gjMxJyVXSE5t+iv/RJ/usFirlvf1BIhb4wLxspA9Gr09pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hEeykiBbJ7MiMNOPUmV6GyPzH//QX/c7TfO6oAgzLiM=;
 b=BZXfVDn0vJ0rBSpPmwEZ2RUWqpNZoysHlKuNA3b14o1190pEjO0vEMUkV5qHrI+xkU20M5qX/LFNzI3Ul+DOhK2ySxrSOUkhMlr42oSwF/+y59o1aB5ekFWoAqDNLr4cFdnbUO2ruNulSLLW9Mfy+MH04P+s6avyV+kCPo0rqxckAz5sasZW/yDXe3fZOz5PYYFbXqGIm3JKhASphv9NCYt7ZBZoquJsbyJQig+QSCG2phfw2pnlmv+cGu/Kce9uHauFL0wfUXnXr0UnpIQb0xBuA7FFWFNDq71ZffQrVZDaTQlRmMldOmlCM4/FRCKmjwImXAgkieZoBEXDVtFbbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hEeykiBbJ7MiMNOPUmV6GyPzH//QX/c7TfO6oAgzLiM=;
 b=FKQV44QoFRTEk9Ch2UccgTDW81LU4864wUpEz15ez2pjy882zQCety+opeUvSorxCNzRnHdK1m3aWdXtU0LcOxIFliD4Fk3p2YVuzWx1oW8/vqN2KZr/5eRfvSI57AfukQ88QN4bu2G32L2AOHc39L3jaKGZntw8/NQNlwwaWyk=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by DM6PR10MB4220.namprd10.prod.outlook.com (2603:10b6:5:221::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Wed, 5 Mar
 2025 19:49:52 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.025; Wed, 5 Mar 2025
 19:49:52 +0000
Date: Wed, 5 Mar 2025 19:49:50 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>,
        SeongJae Park <sj@kernel.org>, "Liam R. Howlett" <howlett@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH 00/16] mm/madvise: batch tlb flushes for
 MADV_DONTNEED and MADV_FREE
Message-ID: <815d1f2d-4bc0-40da-ba07-42593ae7ee45@lucifer.local>
References: <20250305181611.54484-1-sj@kernel.org>
 <Z8ieZVFEa6vAouvu@casper.infradead.org>
 <46960f37-0d12-4cfd-a214-1ddae2495665@redhat.com>
 <snby4wevysj2hr6rmqcwezcujhwmjgtby6ogkrc4wmqnzcqcsv@tu23rsyltc2m>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <snby4wevysj2hr6rmqcwezcujhwmjgtby6ogkrc4wmqnzcqcsv@tu23rsyltc2m>
X-ClientProxiedBy: LO4P123CA0367.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18e::12) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|DM6PR10MB4220:EE_
X-MS-Office365-Filtering-Correlation-Id: a376ae97-7465-46d7-f87b-08dd5c1ee526
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PJGwD+B1GBTDH/IP5F3bZ3liiVowEU4+rJgZiQhGTK0+5dzYAxwTKIRar26R?=
 =?us-ascii?Q?QdpngeyMBLGdZs5p8FLi4jOc+1mS91gL2e6ukBRCuwgBbDnU7hCPsHQFfbzP?=
 =?us-ascii?Q?UAnitYA18g7+nIh7giQ/e88zaLMo3kPNfpwfkuQ3w/l4LpmXPYGHuFQdiKsH?=
 =?us-ascii?Q?ZKLLrbSOacr+kptxXedWjUBN/FZ1yyaTWMExJCjjO27yGrIuFPuzPjOIxAjg?=
 =?us-ascii?Q?WVptaRl7OHJjXpMd7zXHP07uRPP28qs04hRfOxTzs+5p83R9Qng9mFX9f4rS?=
 =?us-ascii?Q?XxnhepK7lR/KQwJyydJdEa3ICuNONCuiqw+EB4fBLzaNRYeClnqNmRf+S3x7?=
 =?us-ascii?Q?JC3n8WJNE340TZaXez5HwuyjDPRm1MPv7PKxnVWuUAVXN53E8ClJdLfz+702?=
 =?us-ascii?Q?eAYivVDYEl6tIeaOaNPdtFPhkTCiyqVaiscf2iyTMQI4k/st3SXyAsT4zZbw?=
 =?us-ascii?Q?vMbeBBga+nRmb25sdrosR3xa9PI7zgR7uU9hJ+yxMunDw8PTqssIEfC9u3QT?=
 =?us-ascii?Q?o7hj98DAJiBV4TZwALRxcq9p1rOr3XwwHjPlsiRXCb2JqXru9B6tQoqinYom?=
 =?us-ascii?Q?EEK4gjtndmXtBEkn7oiYRO1g9xTFB8pAkqx//fky9mIUizew4X7qB5/UQL0w?=
 =?us-ascii?Q?0FPBwGriuLt7EedEzu2yviXM1YgVnne+GHA+PW1Jy7rhfsyqgSfsVBf+CcSY?=
 =?us-ascii?Q?ZXY1fB+lHmblY1ok6ptR+/EXwGLDHuPAqq+nexoGFq1fGqqqgIIWGAv6sTm7?=
 =?us-ascii?Q?X9MmB2cVXSiMcK+P76G4bOQZvaJsRZqsZ/ae6yqSxTUVFMfANTmHhFTu8p4m?=
 =?us-ascii?Q?qfQ2sOl/3AynZDF8P2kEw0q6Jlcip1ZelE5YGnim9Xqn/bHs2uoObB88fj+e?=
 =?us-ascii?Q?w8YhfVLAjCglPJu0ci9YxCP3zGmMbYvgxLQXU7PVcY5Vjbfd98EFa7qF+mk7?=
 =?us-ascii?Q?JQD4uWusTYHXlbdp6TSw/LYwzhW2s0aHZoxlM8GfFD/YA7dtGqUpiBqcIAb9?=
 =?us-ascii?Q?JVGWMEym5+AiL8YRIXVPi41CoCk4yv9LOkQXf8F7qCx3TVIxgp2DE2o3JsUo?=
 =?us-ascii?Q?ArMbQc6upNhD2KgxiBFYOeT0y3W2+LGXpK1lhz87th7Nj7JBlJSCY1wzLztG?=
 =?us-ascii?Q?qfarA9heyFfxjNrBAVaxK2t5X8hhVl3aQDm6O8QCajaIIgtJ848qkbuLrOqz?=
 =?us-ascii?Q?ebl0Jh9PIzRgzsZJzNCgSmPfqEMqFX9UVb2I7AqKMQM093XWiskkuTWdF3UH?=
 =?us-ascii?Q?Hs9p6ntmJnIf25ZXahx+18/VdgIv0yh1P9cSdZng0pON6qX3KUPL1pozaHRC?=
 =?us-ascii?Q?rj7AoQnIhA0CWGzB4BFnYsUkAvTgDPgr3rdahS6dSRuR1JwujFOMDkqsTClp?=
 =?us-ascii?Q?vnHlH8iTEJaCh0RXI0gX04CnBFHi?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aJYitp+l3xqR3GzvXqsXXXUWNebWgXjwwBfQo0mn+8EK8CMTPz5AaV7W2ezw?=
 =?us-ascii?Q?/b40Twn6yqm7ZvFZsVCaiifIX+PaBsZJ/x4/BOOTu4xYZxRotw7bwQqdHzVv?=
 =?us-ascii?Q?8nTuUfJkyiAG89Znpdae+51apzFUwA21bR+pYH+SIG8T+mdeo7455oQfaaDL?=
 =?us-ascii?Q?uGUKJPlyrjq9WNgxVxkSjq7SDysb36Krs3rqmxcOMcWvS04LyZZBEjXwCuZW?=
 =?us-ascii?Q?AmqCpX0HWgeMG9gKI7XUsxmPOJ+UinYE1xK4ppsGEsdQuemUH/jB/Y+th7Fc?=
 =?us-ascii?Q?3t/gWo4vZ8ApnP8jpr+I1thztgOIgwI/gIWkLOVccn3MhpBGFRqCJGCh3xDD?=
 =?us-ascii?Q?nfWFP+DG0+AACQLlCvGLep4kkQB7Fudnux1Gj1LBAamtrvj/bzBJPEbrZxBO?=
 =?us-ascii?Q?2eaPV2Jbw9W7O9Srm5oBpLgmJvs3KEeXxJ5Cq0WaPYcQOtgdM6MeXzm6ADrp?=
 =?us-ascii?Q?yMLrThY2ERfoHxR3PotCIjopJ4GK+9nJv/w8+rNjqwRUySN5SLllqvwVl7qM?=
 =?us-ascii?Q?y1knhkKMezb86NQmMItAR35Svpk0QvKQUDETMOAxpO2sbxo/558RUN/t0gea?=
 =?us-ascii?Q?KtU6JiOfWA60EsIGQ/k4VIfgtHpR/HsNtnv3qg1fvJY2qdYh1lot0ohHbJAL?=
 =?us-ascii?Q?mwziRKLqgYuGuOi/bAt6Fh3zrF7uvOzIc+WpVDL68v4/dFP3seZZ07k9JGMz?=
 =?us-ascii?Q?6sbjCx7yAkP/B1VE7Zcrc/mHKZEC/mIkSrfWvcxlqthnjY4Jz8pj2SasO/Hn?=
 =?us-ascii?Q?dnbRp1X2kIFoNR/ofq59b2/zLEzH2Bak19jhKygd9GvdtP4CMtAt5e8qIOvq?=
 =?us-ascii?Q?w4sr1g8swvFVr7rI2oSLe5p7mFQw/oijw7qTE1ySA9vroxdZcQ3VsrNRAi/P?=
 =?us-ascii?Q?1wE31QD9ArTcRGo9XOlAvzVP12j1aZ4sOVrzCv09x9G825KU4YCzY9O/wyu6?=
 =?us-ascii?Q?+7UgNre2JfyUqDCLzXxdOSQ2/mDH4hssx1YV8K9Soe8C6O3q25DMHyoZY4We?=
 =?us-ascii?Q?WCWMMH8Yug946Tg3cG8+06T5HBXpgfHFcViK5rIC8OJamaI1lCb50R+IqV/D?=
 =?us-ascii?Q?hJ6O06cnHN83GdwIOefa/U+8GdScl3iMd5ozHPWhliVh5GGEl65ShGz1bUu/?=
 =?us-ascii?Q?CsiMebHZVAQBBU8o4SFz49i+EW/SRZ4o3IApj6QwfxSNVvy9y2WMp9vIxfsL?=
 =?us-ascii?Q?UZBm2BWEe1fKMGFJSmMFIOaL8eGyigwrO4SbRVh23TDLAWt3tm8GqaS/ac5P?=
 =?us-ascii?Q?mbHA6KtZk9eKqVrjNknBc3Aumhcg96biax3H3jGZHX3/aXN6H+qqWsOhvFnV?=
 =?us-ascii?Q?XJF/8ISJyUv42ZR1BIg0OrwHsU1RttsNIyyYDGDFMWx+1PBwv6FdfXMETIDC?=
 =?us-ascii?Q?PNTUnA83Wh67Wna+ZUejxIf3fKzrSHJhdEybjOMQAfbZyLV9Wrp1XIuvHoi5?=
 =?us-ascii?Q?NECSrozzXK7nCaT+AqkPE8WmlKENxIPZRxDqc2TxBrBTg5ZNe9JYpPkmyhHG?=
 =?us-ascii?Q?GnBNlue9x8G89cmYTYJHNOgLfXOpzvcgZVZZTleo2CUYcg/vJL5U9DXptkW5?=
 =?us-ascii?Q?Ikb1Kv0E+clRVQrjiqHcL4u44x5YJJjvoUqijtO7ovDHT0Jv4lcqdfvkHaA4?=
 =?us-ascii?Q?Sg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	k1kD4lZdLZDkK0N58bh0BHrrKZhTfq0G+EeME3apjbkvxci+lnSTCHZxs4NcA3y9nnLaINbrGthiDSUqwxTlFPm3BHti1Ptg3Yy4xsAy6+cj1h6fKRHY2Vg03AITxzgQFz3urkQ2CWEEyEszGVHhayF9/q7A/8J94nO/VB+pnXxZG7X1OIoXhw7jkdVN2oQg/bOKGTY1df3lvEfh9/fEXJXo7mGDPgdQH8cEfNe0tjOQDlCZhK5Mnp/4p92lmBVWx0HZ2Mw4Z+1P7vg7uIQR6gy4TEY7R68y7icZTMOUc/OxkYV4g/Vep3NwvxOyWwp7lSI9LJtzSB/GgP7pWVflYmzdR0Tl4oy4I3nuescwjWqfCC3ApltKM5KTcuNU5RhBZbEuqbHUk2D5ZkslNW/OITZyW2sVzIfMPMZO+TYoAE0TGdHSS/hfUmVhgd803WPSrv/LUXmXjtYPAqEVT1deuE/YPHdLYi6hQp14+Fl2nv37lo3eR3TMAcbuTOuQtvUntENXhoIJpVUfuQvHmmd57a8WFOW/Uh6BHj0+SD0tjrerxtuk6/03twEtRWwgmoBmGalzzU6zJCjtKp/1ZcK12U3MZ+zI91jNKNl5Qdv3JlU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a376ae97-7465-46d7-f87b-08dd5c1ee526
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 19:49:52.0712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VwgiS8B+aKYmcQLcugUSYD8kW3iMi6PGQaRehbdZ0PzZQBxDLZuTkC+eiVzlfVxNXb6ET5i9iXpnLY3R5QsxvjlYW0HolBMcBgZDrx2xy0c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4220
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-05_08,2025-03-05_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=863 malwarescore=0
 bulkscore=0 adultscore=0 suspectscore=0 spamscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2503050151
X-Proofpoint-GUID: fLIRxChwzkMqn496qp1cl_LNDC2vJECr
X-Proofpoint-ORIG-GUID: fLIRxChwzkMqn496qp1cl_LNDC2vJECr

On Wed, Mar 05, 2025 at 11:46:31AM -0800, Shakeel Butt wrote:
> On Wed, Mar 05, 2025 at 08:19:41PM +0100, David Hildenbrand wrote:
> > On 05.03.25 19:56, Matthew Wilcox wrote:
> > > On Wed, Mar 05, 2025 at 10:15:55AM -0800, SeongJae Park wrote:
> > > > For MADV_DONTNEED[_LOCKED] or MADV_FREE madvise requests, tlb flushes
> > > > can happen for each vma of the given address ranges.  Because such tlb
> > > > flushes are for address ranges of same process, doing those in a batch
> > > > is more efficient while still being safe.  Modify madvise() and
> > > > process_madvise() entry level code path to do such batched tlb flushes,
> > > > while the internal unmap logics do only gathering of the tlb entries to
> > > > flush.
> > >
> > > Do real applications actually do madvise requests that span multiple
> > > VMAs?  It just seems weird to me.  Like, each vma comes from a separate
> > > call to mmap [1], so why would it make sense for an application to
> > > call madvise() across a VMA boundary?
> >
> > I had the same question. If this happens in an app, I would assume that a
> > single MADV_DONTNEED call would usually not span multiples VMAs, and if it
> > does, not that many (and that often) that we would really care about it.
>
> IMHO madvise() is just an add-on and the real motivation behind this
> series is your next point.
>
> >
> > OTOH, optimizing tlb flushing when using a vectored MADV_DONTNEED version
> > would make more sense to me. I don't recall if process_madvise() allows for
> > that already, and if it does, is this series primarily tackling optimizing
> > that?
>
> Yes process_madvise() allows that and that is what SJ has benchmarked
> and reported in the cover letter. In addition, we are adding
> process_madvise() support in jemalloc which will land soon.
>

Feels like me adjusting that to allow for batched usage for guard regions
has opened up unexpected avenues, which is really cool to see :)

I presume the usage is intended for PIDFD_SELF usage right?

At some point we need to look at allowing larger iovec size. This was
something I was planning to look at at some point, but my workload is
really overwhelming + that's low priority for me so happy for you guys to
handle that if you want.

Can discuss at lsf if you guys will be there also :)

