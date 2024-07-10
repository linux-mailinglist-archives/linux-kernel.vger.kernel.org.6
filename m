Return-Path: <linux-kernel+bounces-248162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEBBE92D90B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 21:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03D3A1C20C1E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 19:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78B51990DC;
	Wed, 10 Jul 2024 19:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bC2AUAvM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="euir04r6"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87A7198826
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 19:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720639430; cv=fail; b=ING8okgyLt7pdbN2bmwPZwTubC3pdt6yZT9t7DJ44NG1PG8A2ksI0LlVfD6vsRioMKcGxbEej+aPhzZeVFHELlyMcm/CIuhP8BOXjWFHOxw1+R8naeO2F+uHAlxQ1HcLUV9uraXsrNcsj/9H05B2YRmNVh8CygJ+9H7QWm3aIkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720639430; c=relaxed/simple;
	bh=ietHNwlGT4B8Dki3b+48Nf0N4Iam8j2oUrvCfP3rXgg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mMzDvPbDGTuZUXC67BV1NkM3udcIRY+OYfXo3bQCWO7yzp6ReND9LLAWAnDJFm9Hst0NeoteRv7iywsPEEvQ3BjpVGSLRELl/ODJEjAdrOz/HqdbSCUPjUHMhlC7iEu/qv4SW37ln5apzOaPODjYzSv5pP8EDmHQ2VX3NpYTQ4E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bC2AUAvM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=euir04r6; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46AFg0oT013740;
	Wed, 10 Jul 2024 19:23:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=ZSFrB97cpv7TqMTUIBHaSA8OeLP/JU95xwMvxrLhrQc=; b=
	bC2AUAvMM1QZ0xdTRozCpoM1id/H5UzeIJ9dYNibUu8nRY+HWDCRzn96QHc926iw
	FTB3n4vppEN28FRfnuI6+tKBO2TrtCwS+MlxOufERfEgw1rGMlLA1GbmQaaHPFhQ
	LjMe5JRuy3R/4rCuTD2qJ41wEZEf/NaJSrEsAUNdwY1UbEnJaXTBW85fBoOfUtgk
	JDrgTjSWNv1Fr7Y+92yLNNe4gMJmS8s7XGuMyt1SX/3e0t5uFkporfZHS7gkHXag
	C+seboKNjDpt6cDPqkeZ/Boa9ISk9y/h3fzjIhXzq67gJHas039y+H2dxrasVV7w
	Kz4es31s+6hCncyyH/4Dtg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wt8fy0t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jul 2024 19:23:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46AIs3bi022604;
	Wed, 10 Jul 2024 19:23:35 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2047.outbound.protection.outlook.com [104.47.55.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 409vv1gwv5-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jul 2024 19:23:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZpbqVqQ6frx2wWG1Pw0z82Dh879Cc2j8zqvGo1/wYygg31alRvROgoEcxizaoG2FK7LvnbUeYKJoQdm+/FSYf3Dy3rCHdLw4B4rmhhGn+z3Lg9vssNmv+q7yJxk04Ly2b5saIqFj6A1Q0mwbPIgnN61+H0cfQlAsc+b3G6naVRgJ9KN0NFASDJIHBWEQKPMBOvbTa+sYmU0fuTj1VWuyQCIPC+uqPcvmVOtNov9tUqfDxTsj8ks8I96C7pD2gOXI04oQDdj0FvOpCTJz6UNxnXP0goZKLPoJIhpNMr5ECHQyDXYf5SJAKn+61z2jTM/H6fzAskkrPZDAGyCAfRoKMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZSFrB97cpv7TqMTUIBHaSA8OeLP/JU95xwMvxrLhrQc=;
 b=PaJH6Orq2sOOB/ASEIY4ny4Yrw8J0UqNrJQXvB8zfSCyR9u2Fb2loKgQp/Aj7XLyHDEfX/nrrYXeHUo0jfdTsUKNSlQ7Bf0bU559wj8WQk7gLHigR7dM1lu40V6gqI5k2+dPqY9SBtCBsNDglsoIEwoNa/SjmxloKTHZmQrZ6qJauUoC1Cih+xXj3k4IYgfNilFZgt4CoI08/TU6pa09IsBleGib08xvvjZvRHHEe6fak0fTZ31+kdo4D1OKHXeEhbk+GWftkBhT6keQHDGb82Qs3wVCvDamrnbGWkq5OchZU3v8fx5cNtlYP9VxljrnS0KlCm0pSPytu02uxXR+5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZSFrB97cpv7TqMTUIBHaSA8OeLP/JU95xwMvxrLhrQc=;
 b=euir04r6is4lyMsnf5yBGstQiRiQBb6fYJ7JMxpyu5jZuq7TdYZejwFF5rHjziU24U2JueraIlHoJyMp463oPS6tAmUe5Bsc/kfbUtWKNne1JA7O+jrhIUTtLqr6yOSLWeCxPp4Lekd3GbdlnnYQHFSGobAKjV447zHvTRdrCec=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CH3PR10MB6833.namprd10.prod.outlook.com (2603:10b6:610:150::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 19:23:25 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 19:23:24 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Subject: [PATCH v4 13/21] mm/mmap: Clean up unmap_region() argument list
Date: Wed, 10 Jul 2024 15:22:42 -0400
Message-ID: <20240710192250.4114783-14-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240710192250.4114783-1-Liam.Howlett@oracle.com>
References: <20240710192250.4114783-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0428.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10b::20) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CH3PR10MB6833:EE_
X-MS-Office365-Filtering-Correlation-Id: 1651b855-1d06-4d94-b936-08dca115c4c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?z6Zmb9XVOWepdjOkn85ILdgujcNnA3nKrHX1tQjmRtxGhmb9J0UTuW+Fxg/x?=
 =?us-ascii?Q?d9ypvAG6tQfiSnUu1sE2k6R++joFoPclbz0BJHsEwBbeUS3j6cqI/bvYIR7R?=
 =?us-ascii?Q?SCyvGjFJMhlUUUUvnZSnsmWejpPIWRxbH1Q2WZdmEvibUakoOvc2A1/DXphL?=
 =?us-ascii?Q?pgb87ixIlI2CeQ9TvfPLhTl20zZf26d0NZ9vmsbg2SdoO33CrCD/UIaCGoXW?=
 =?us-ascii?Q?RaJG9HTadU8vN1PhYgAnJd+xFe3GUVVVa10T5/+qH44efBYO+1mxL6p1wsEy?=
 =?us-ascii?Q?pGoxGtHlbOC6budyo3IaU5zEStfnSVYuCYNiWzaAVLRuYVUsDMCow5pWe7qP?=
 =?us-ascii?Q?N72hJJN1PkrOh/K/8cvucC9yqwdnqO0htp/rMi77vKoj8Pv8Ukz4gwxao/pX?=
 =?us-ascii?Q?/1WQGlgXknIfmcZghstRGev10gIN3oXd7VEdHM8kq9uDWotmAxdFyKNDzgWv?=
 =?us-ascii?Q?RcQEuY0d9x6vHh1E3D/OBpU9elTGlBMmWrQUBgDCfZiHbv4M8rN8vmM7/cjO?=
 =?us-ascii?Q?q06ntEYV8C+5Zjf4yV4SQXaCs9ZlGmZdn4YurTzlOB7QMBfZY9M8rm2P7rI+?=
 =?us-ascii?Q?d0iPXn9KBwD//6JlxjJ6CyMUVBQa9skVs7rnZdEYXPyln89B9unt/bj0S01B?=
 =?us-ascii?Q?lWyhmLptb1I5BP/GN3B/sqzDfiymkG80CvODYuRKipOjx61wwT/U9m76sA3I?=
 =?us-ascii?Q?CPpSDltDnQ12eS1mroxITlWLA+IajHaWZFDIS96Luvwe8xzuRLHLeMJfjNEq?=
 =?us-ascii?Q?fxDe15Tj2R8TbKe7mQjF4ckD9vWbR8VCSzj/20dCYoALaVIA1b+1OsTAa5Fa?=
 =?us-ascii?Q?AEUGuxVCm5I6fFUkUZ9svatL5fIYYEwLDZZBiByU3S0lPEVzSSQLUnQ1lNfy?=
 =?us-ascii?Q?50ws7neqMG7/vc009nimhFUclp+C5uBhJRKRN/ovAMURxGjxeLEGxUqjo+yX?=
 =?us-ascii?Q?LYuCWXgWtFQXan9dMBd0SHobdMN5bhlB+7h3pnq3VAsxNkH7qrm6N7OZXSHb?=
 =?us-ascii?Q?5PlTqk4eSWY+nmmkqT+noB3O8+pcdKPr6xwla1RqsHze9rK7HUjEd2nTOgXu?=
 =?us-ascii?Q?/7wrvAGxqK7JuMI57rCTtV06e0a9uxTPeQdiH7OTqUajx3rEgmLQHqun7d+v?=
 =?us-ascii?Q?S1miw3XlfW+DkX451aDEkm7SNZa4n8PK2u0K/s3D4M7FpzoVPugM7UyFmIjq?=
 =?us-ascii?Q?uaPbqolxTsvUsYbHOMZWRHuMyrE+c4QZa76vbSV1LlPYDcyk+VWWBJ1hf9gx?=
 =?us-ascii?Q?RwdXcHzpkycX2nCzCtWSB7nvTEDoQgIDXwF6t7Qmj5fCyR1IaRvDS4JdcIDK?=
 =?us-ascii?Q?Tq9V6BkQw7hGCTdOCkFxOflmI6OtSXWW7EAIcWJwbYCXAg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?c4JJ5egoK7lWe9STl6y3Vwh9P0ktTghl+cE6yM9EXovpXxqnsjTLn+6g/Oh4?=
 =?us-ascii?Q?nG/2zOuOjuvnXqTIbh6fRaNreco4GEPQecogW5+avE+w5CjWxwp1tvPAmetL?=
 =?us-ascii?Q?3dHAsMb9HG4aeqqPxdJq3Rk/oN0lvcR4l0lyvoAHF7+J5Cj32S8LVcRbhHc1?=
 =?us-ascii?Q?nQw9/0JWvXv7PnkJ+BF6VUmH/SiHIWL/ImaetpcuSjl841i8WAxO/7t3Uy2Q?=
 =?us-ascii?Q?tUqTOz1EYfyRbr0rs5CIEpOnU15zyRofJzag8KB1fhUWgegN2aKzVBY6rjui?=
 =?us-ascii?Q?Xeke8bW4F1Ty81xeQXV/NCr+SR3BxnEqdEjCFvEe9iz5+rynfrp8Wi0Sl3QB?=
 =?us-ascii?Q?hIy5iRieH211i97rX4aTA4/Zsyww4+pQCunDdVjIQZLi+HQ2a3IO47wrXYwl?=
 =?us-ascii?Q?VnaTnd45SccQrU34Rro2EJUTCGRK41z7MWNqNnKnyreUg0nlPEw4OMWERSAi?=
 =?us-ascii?Q?dXA/HQoQjupycDBSxFP2dNC9F7x+H20/G7sXELgY3DKRHrtPZrs6908qAQW2?=
 =?us-ascii?Q?kQ/KedMI9JYqs8KFPdGYVimTgC4INB18gyKs/mmu5Ssvw7ZwKNhE8yoYEx7K?=
 =?us-ascii?Q?SCIOhh2eLprPlGvHGVEb5hCs3Ei1nw85z1f2xPPl6uEpLwgetgGaOfNXBN53?=
 =?us-ascii?Q?IgFB+FsBCCfgBCrvxIjBo7YF2QMfPTZCYW3jG87vhLftlmetQkBt/+/ixjUg?=
 =?us-ascii?Q?6VCT5O3pE4Y70G2CMT6Nax/nVXGeLbNoAnUiX9OhVv59ai1QR4Pp09oZjEIu?=
 =?us-ascii?Q?B9LC1bKqYffYHSjanuK2PvlTXLMdfa3k79oe+P4BOI5TuYcr1PBXpE5EtbAT?=
 =?us-ascii?Q?6oSiwjzKG3UyXnpeb/IkMPVeYN3/rZTPuDbdSCow3gk/UJzEjNjJWP5cTwjB?=
 =?us-ascii?Q?zzpetNSKpXLyOZPmuCxiZP+KkwvVMF+VR0Xvb9toe3ANPt7lDLhfp690FmdE?=
 =?us-ascii?Q?lnw/WLGuaws1KXwEH6JCppW5dq6sP1O7817XEQBUPnVcmznZIo2G6K70mqaj?=
 =?us-ascii?Q?b8q/Twb2cWBqbF8EkoCT2yvA2JCn/ZPWalkGTrmabf84JIR3tbZRk7S3IK06?=
 =?us-ascii?Q?Xccel7MWriZ0l2REdNg2RTUjpLDt8wsoUFHxAMVc20noAaxUETfJvAUinyv5?=
 =?us-ascii?Q?fDvBMjTQUGK/my0xUydNo6KvjeS6U5YR6FNDPatp6cGjdXUfKnvVXEiBq2Qc?=
 =?us-ascii?Q?LWrRS+F0ZSoUdfRIVhl/h4cAFQ2yO2QxDZpcNjmCTxAl424R9Y9TmAyRHbkV?=
 =?us-ascii?Q?c9OXox+FOBbLGdgRjz7mQlcdsEY0sS+LLSu6bMYal8Qic/gIPQq4SuGPXjfR?=
 =?us-ascii?Q?Pb+Ake7Jlueu67x1g90n+sTbep9CsFj0FETYl5G1fTjb7wewOqe1jiOF2Ime?=
 =?us-ascii?Q?iqnuNi01urruSvaSZOqdsA7Dt+6gUrXsRRzK5984XYP8+rY6COuvf8n0SOom?=
 =?us-ascii?Q?ESRhgGkkkzRqNXQnozjynyWS9jvSdoA1bqZOJlAH1T+oqaADBvGRKglg2vL6?=
 =?us-ascii?Q?eypQxtiP83FtlU9KmCUPxTy2VTU71Q0eIOd6oekrgjtgkD2XXTlSHs1l8+/s?=
 =?us-ascii?Q?1CwHViyfoGDHpSKItMRaG39XzofY2pIEIZwj+Fr2xJDe3bJNQaz4Ne7qXInA?=
 =?us-ascii?Q?jQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	fl0DYop/vrvjrcClTfqKMYGkj86u30xpDhr8SKPAbWKTW0ZAf644o2l7srZdcxEIstRz46q/75/3g/X6Ag4alorv3z+8VS/RiDrIl2+Fonlz5fP7e9znf9iSilug1wwH8/lx8i1Elm4mEU4JAgBw+u1RV9WXpB7MQxLJlcx/t/Mb9qa26QElWbQ5bqVshVWoRCuw4R0/v+84Ucn4mOErXo5feyu3C1U+7NdZTa4B4r+/zO6/W4/QkusRmxrq8RQ8DOD1FTionh/DP4rlqeAxK+2tSzTtu/xrrSIY1+i5L4KeHyRiKOSmeXCmcTqIuyahpxOaJET7gXbz6A+gwED09ZyvZTMFToyXxITEs+XAcKiBJvXtuAb0NrTa0+m55WGdGPizdGI7rVbr/Ifnk8zIAYzHAkw8reKRhDFdfQqpDbR0OojvFMhGAd9jBV8I5rfTj62+Q5rl1GSMTssIOtxb1Crd77Hc1tF5WYoZmNLW0VmVlU6AummDv4TdOBk9wYEgLE+chWakwbxl/8ZSUPt9yDtYu6s2I5G7TV/Y0eG/BzeRhiR7Z82buXK1UQU2VYxCB7KgYhtngnbtC65e2Ru8JzeL/7oiRx+1Ub22RtaIOhk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1651b855-1d06-4d94-b936-08dca115c4c9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 19:23:24.8824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WEM0xdextXPRvo0SKVW/sUsKru7yYEM9cUeeFfqvyE4M7PK/B/YeNkObCBQS7a9pYRRyc5GgSQ1efsTbuaoZDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6833
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-10_14,2024-07-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407100137
X-Proofpoint-GUID: awGNE8qDrtChVNMTOThCEK3Ul8gYsoQv
X-Proofpoint-ORIG-GUID: awGNE8qDrtChVNMTOThCEK3Ul8gYsoQv

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

With the only caller to unmap_region() being the error path of
mmap_region(), the argument list can be significantly reduced.

There is also no need to forward declare the static function any
longer.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/mmap.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 12a5ca6c979f..870c2d04ad6b 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -76,11 +76,6 @@ int mmap_rnd_compat_bits __read_mostly = CONFIG_ARCH_MMAP_RND_COMPAT_BITS;
 static bool ignore_rlimit_data;
 core_param(ignore_rlimit_data, ignore_rlimit_data, bool, 0644);
 
-static void unmap_region(struct mm_struct *mm, struct ma_state *mas,
-		struct vm_area_struct *vma, struct vm_area_struct *prev,
-		struct vm_area_struct *next, unsigned long start,
-		unsigned long end, unsigned long tree_end, bool mm_wr_locked);
-
 static pgprot_t vm_pgprot_modify(pgprot_t oldprot, unsigned long vm_flags)
 {
 	return pgprot_modify(oldprot, vm_get_page_prot(vm_flags));
@@ -2400,22 +2395,21 @@ struct vm_area_struct *expand_stack(struct mm_struct *mm, unsigned long addr)
  *
  * Called with the mm semaphore held.
  */
-static void unmap_region(struct mm_struct *mm, struct ma_state *mas,
-		struct vm_area_struct *vma, struct vm_area_struct *prev,
-		struct vm_area_struct *next, unsigned long start,
-		unsigned long end, unsigned long tree_end, bool mm_wr_locked)
+static void unmap_region(struct ma_state *mas, struct vm_area_struct *vma,
+		struct vm_area_struct *prev, struct vm_area_struct *next)
 {
+	struct mm_struct *mm = vma->vm_mm;
 	struct mmu_gather tlb;
-	unsigned long mt_start = mas->index;
 
 	lru_add_drain();
 	tlb_gather_mmu(&tlb, mm);
 	update_hiwater_rss(mm);
-	unmap_vmas(&tlb, mas, vma, start, end, tree_end, mm_wr_locked);
-	mas_set(mas, mt_start);
+	unmap_vmas(&tlb, mas, vma, vma->vm_start, vma->vm_end, vma->vm_end,
+		   /* mm_wr_locked = */ true);
+	mas_set(mas, vma->vm_end);
 	free_pgtables(&tlb, mas, vma, prev ? prev->vm_end : FIRST_USER_ADDRESS,
-				 next ? next->vm_start : USER_PGTABLES_CEILING,
-				 mm_wr_locked);
+		      next ? next->vm_start : USER_PGTABLES_CEILING,
+		      /* mm_wr_locked = */ true);
 	tlb_finish_mmu(&tlb);
 }
 
@@ -3193,8 +3187,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 
 		vma_iter_set(&vmi, vma->vm_end);
 		/* Undo any partial mapping done by a device driver. */
-		unmap_region(mm, &vmi.mas, vma, prev, next, vma->vm_start,
-			     vma->vm_end, vma->vm_end, true);
+		unmap_region(&vmi.mas, vma, prev, next);
 	}
 	if (writable_file_mapping)
 		mapping_unmap_writable(file->f_mapping);
-- 
2.43.0


