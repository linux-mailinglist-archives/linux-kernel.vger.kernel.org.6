Return-Path: <linux-kernel+bounces-435768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6729E7C05
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 23:54:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89CEE2830C6
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 22:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A783E1FBEAF;
	Fri,  6 Dec 2024 22:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NFvMFh6i";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="m/Aidjcu"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D159D1DF743
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 22:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733525654; cv=fail; b=h58s9sTIUxtHYKUviRiqwxSvKkhA8dTDjsdBodKt+OYy+yDbknGPhftCAUQ5lB2AuccvMMpLMXRtnqTKenMYFVEWjrE1yjPiPXipC+BRxgI6/yFOpMquDPlR6AeMekFyCsKtt3rUlRA4niQ/0xqD/s5Db+XwYKsUj9HDmxTgUhQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733525654; c=relaxed/simple;
	bh=r+uT4rZnVkHs2JKKiRUgSVEoylGIxX2/6El+RlSQdoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ilTNqIe566PdrQ2c2GLqSdDQYV1pIav9LsyFlaJassF38nEG80O0ZZya3VNPHgPArYr8WXc09Gv/8HOjZJTLdjiQ9xDHs2wudE+GbwP/CJ3ZOvUe76X32JyFsfXADoDso+Npa2KlGNKzgI9QWs1YnNfQP5kG5J3XOxkGXkVsKz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NFvMFh6i; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=m/Aidjcu; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B6LWlIL020662;
	Fri, 6 Dec 2024 22:54:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=FudhT2ZtRWJoXS8tka
	At5tjjIWtvgaLUqDPXMn8z1cs=; b=NFvMFh6imCgKqX0f3yPovMaGeorp40KRmA
	2YgnTm0YeV3khQYid99nb8mI0SXFaTUGKcWW506/9v0ak248Ab7TKA+eqRAOyvG0
	dheNROTgPV0xcfYPPBdWZb+koxTN/Wx3ENzDNcV6YjTXp7pcxei/rnjr9UJUCTP7
	vKT6sAKVmfeketQ4hSq9ZuwoqjJD86dFVJ/OdT7xugsYvoJyDxC74rcyAAAgyelK
	TBWbf7U34QzwueiiTO+spW0aAMsgNTonrAhi9nQiwbkvJkGJ0XR9qLlb1Z1kHlJm
	yQ2Z5WAjxj2xCyGvx4KW23NzBJTplTnMEFLO0wLkYMpp8LieUVhA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437smapk6x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Dec 2024 22:54:03 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B6KObia036791;
	Fri, 6 Dec 2024 22:54:01 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2040.outbound.protection.outlook.com [104.47.58.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 437s5ddbss-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Dec 2024 22:54:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FyR3KmIib2dWKZfAvv2h6qcAR4sEtrsQHjLnTp/3ttHjoaaqEINGtPTcHQV3mnr8EctwqXclv7r4ywmAlx3dvaaRyO+UA93y5lGn81kF+e7g6DSe6KXDvzmNNsiMX3l3HaNlUYxMPCYnG7OoQwhUV9CorM5FrmnZzrK0fl6ZbFo0+iDsBegPR+VMLQb/iNgFjns3qlPjnbDTwQVufqWf6ZPc6PgXckdnsYGUWt0e4ap0aQ2EMs2GCZXCX55L/bsdnWJs/LYQu6QOvLoa5bG9I917X5xePMvi7XN+j3abzLvBHCKCv3jpyKC0N50yYOE5DlPgbhSi1x/Rcs9FbdO34A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FudhT2ZtRWJoXS8tkaAt5tjjIWtvgaLUqDPXMn8z1cs=;
 b=aC/4s48ET2eIegmX+beH5Vkw797gjGlfPx1BbECyRrkm9RtLvHSJlkdr+1O6M3ZEsIw/O2R8RN6p5LGqvM9W7yioySPqJcN+c8d+loWf7V8Yis3NmPVCF4FBNJp9H1fbob+VrQu19HQzAqG7HTXtLPM5+RBIYOLW6C1xC4e0QkStNNQb6hbiaAwfeBjkCDCL6Ws3sJzXg8v8kz4PdZv5AsustvGBpCRew8dvXiqaIFKNxgZP2qGHbkXLctoQGrqVOZbDQm8SQVo9OCnQG0D1rbjwZ22Kj2+MxNuWu5LOkrGrvQVI17sNstpqe9s/rbViJnw2xaLD+/LCu3sufc+2RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FudhT2ZtRWJoXS8tkaAt5tjjIWtvgaLUqDPXMn8z1cs=;
 b=m/Aidjcu/zs1bLS9gnygGldBG30dngEPyEL+lcXPx+8RSyrqtbjeBQlPlB+BEFlFNku1PP0CEx62XInl2bA9T77c6BfaUzL1km0Gf8nMwbVICSElR0sZ8qnY4aBXeSJsOVRXMcTph9KVmfdUmQnBZbwkuliglS8jwpcqGZJ4InA=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by CYXPR10MB7924.namprd10.prod.outlook.com (2603:10b6:930:e6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Fri, 6 Dec
 2024 22:53:59 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 22:53:59 +0000
Date: Fri, 6 Dec 2024 22:53:56 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: enforce __must_check on VMA merge and split
Message-ID: <82df5197-65d4-4533-be8f-bf2e041524f1@lucifer.local>
References: <20241206225036.273103-1-lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206225036.273103-1-lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: LO4P123CA0086.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:190::19) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|CYXPR10MB7924:EE_
X-MS-Office365-Filtering-Correlation-Id: 6641ea89-5be6-4256-a030-08dd1648df02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U+V8eF1M0PWwZU+4d8lO0VugAUZWw+SuKY2DBGNg8rSmvq7xrdjKrwSW6Ffv?=
 =?us-ascii?Q?7xEVVp9NoH29n2kw9DpwqJk00pCGb7wa/tMdmigrcuWiHMoBp/vc+Wyhz6Ah?=
 =?us-ascii?Q?23Nkia42+O5QO+9vAB6q48sdnPYfNprV1lJgzsbD2Qekv0QQU3Am96I9qdDH?=
 =?us-ascii?Q?poaJ1O+vv17Kc6s/3w+0XcBYr1YCVWunclktWPQPDOAmCuz4qi2D4iNkACmQ?=
 =?us-ascii?Q?PzodjFrucAFkmlX15sLnQRARF0lv0CSR2oB3iBiSUxU2ZzKYuJ17ZF8TqwkQ?=
 =?us-ascii?Q?SlKueJBUwLrhCNuFBIjCP3XwsLXdVou1ANzsvo3nyVRKWNAn4ic++eaudzBA?=
 =?us-ascii?Q?kSuoJZC/n2+aDarh8tJ5HbY3S5K54GAqg2enGS74Xfua/0WU61yFnSI/0VVU?=
 =?us-ascii?Q?QWU8P6K4ZRO67Me/Y/aDi8dFvA3qvcxCm/mTUoBiVJRlGQk/+C+jbxfqYAGi?=
 =?us-ascii?Q?PG8u9FEMSnWy6mQdzUijtwOyb+8+yc/ig1h6JxE/BEbfqJ89yxHvVKLr7O02?=
 =?us-ascii?Q?hUwIHWMFuvR+08ucEcw6KW2smh7YInvzh4aVvH/MW9qGHEjIMYjROmHFZh7W?=
 =?us-ascii?Q?Gy8G09EuieR2KmlLGnTnW3sZvPVkGaUkpqmhmYhjMrxKasJ43Dk0vqHVqUZy?=
 =?us-ascii?Q?CKwsyprY25B7D60maD5fp6hO4/1P/wJXZmwve+Znfa/VBIHKrW5f5ZjGPxPL?=
 =?us-ascii?Q?jGPqxhfhnXrGmHrmAM2cwSiK6npSwbQF2rQFDOEjw4Rmwl2L0N0Qx6rcojNW?=
 =?us-ascii?Q?Ki5gnu4glbDmtwEMJ6oGsCHXPLGeOa1LH4yhJb8goTgyCHRG3UG1cHXovv3g?=
 =?us-ascii?Q?DKBCde0MpDsxzi2D5qtct3dxZRdc3ds7lo6rOwUnn1BJrVdF851bZlVL2PVn?=
 =?us-ascii?Q?bu/jipAk7uBTpSau8Nll8xZN4zWwCI0c1VuEADi9E5EqHKdkS4oW9/JZEEug?=
 =?us-ascii?Q?BknTTSQ6lP/sIE2IIkKolAXGOk9MAPTtvvmaq/zaTnCRVD6HnTMWkPgRX7Wk?=
 =?us-ascii?Q?9S22V9aVFXVfAzF/HypsvWaCQrrRmPObn/ITgGHwVRw1oLjXe5A5FJRMNnvw?=
 =?us-ascii?Q?oFxN+w8QJ3IR+GQ8tIp+umXttGBinrQNNXAovGhhjvEQ0cAaBodt3lb4RRts?=
 =?us-ascii?Q?4mqPb8vJRzH0/eTwM4LAxUN/tt/KJVsx7CHBImTbRa04A6svKqG9ck9eOhEx?=
 =?us-ascii?Q?MlH+5VQik1U1pc+8PdCjmRiFyAPYYYa6B7jqELlB4o94MPfbpxVCZ0JTn6q8?=
 =?us-ascii?Q?Rz+brELQNMp1dLYiiw0Vuet31fCJ/ZFelcjor5KQf/T0Jmhv2AAVyzb7LcHS?=
 =?us-ascii?Q?m6xXZHPyHLK7eLM1wOLErVjsfhZ76pbPLyiAeterM6cJkMasWNjlY7VyMOkU?=
 =?us-ascii?Q?AKUrckY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0dMAaWDmimePjYw51YeuhcJygLBVLSYnD6bLNiZx+mVnchdqdvHVQZo9FfKS?=
 =?us-ascii?Q?V9r9sjzNWKmgh+BUjcGBriT9TLskbkVNhYiwXXTIe1G61zRFQ8Gm1K1VtGH4?=
 =?us-ascii?Q?mt6Zl2nWk/OEjpD1VP3JCA3fgIiSB6EDwJIP5Y3dUi879uq1ryYOxUmQNkqW?=
 =?us-ascii?Q?My+CATqj8J4emwy0iv/ZJs3/SK+b6olc0YOTIRyke/xrCIGQHe+XX8kjZu/y?=
 =?us-ascii?Q?LY5qcLZuvdh6NN72RF/Hz5zTEjNckR9LtKoH4MaRra4cNQTtRMjRNDvspUfA?=
 =?us-ascii?Q?1/KiPniCv90dxEcMxwHsJfQUxV7RJ24wM03t8fW07aeiZQIqpfelHir2Ig0h?=
 =?us-ascii?Q?n4K7BdO94WanJC1336cgSVc8QT44Tk2BTKmsU5w/TGwK3v4WlVi3sYPebwnm?=
 =?us-ascii?Q?qmbKu8WXxXbhHTvPxGhAq2I1PybhqUevAhNfUAkwTbVlM6ljdCBD6UMg4WKC?=
 =?us-ascii?Q?6PoU6/sdwe1xt7A/yV3fUURbsrpkl+jXORgTpK4K4+minABrsAvpSipDJh3q?=
 =?us-ascii?Q?Nhv+HHQc+ZFfZXNDGxwoT/7QZz86jpRdAEvnn5FioZsegClc7WrzKU6K9e+A?=
 =?us-ascii?Q?NYoQb/I83/1KMRJXdNLGcA2y5ZoQir9sZfeakwbR3af6QSw+27SCNjCHrqlF?=
 =?us-ascii?Q?3Fcm335gce86iZCUp60Hde81lDM/m9e24e28Uy6Py0qCNgKJi1BpnIqH1r4t?=
 =?us-ascii?Q?l0pq9SRQz47tFo1bzt0eHKKJ1jtJNqY0FN3paC8hWVEFJLr+7rQcrwlsy63P?=
 =?us-ascii?Q?cWYmgtShWwe4JEHU5En4QhkLLN3t2O5dzQYZPg4QCBFJOPL7W5Y5pikkGjUW?=
 =?us-ascii?Q?EZ614O6RoT2QsscZwvIwj/z/LgnT6gQOD31Ww7CbFbBQB0rF3OFlmFRjWK+j?=
 =?us-ascii?Q?DKDbldutFviQbF+Hkf3qmsuWAAbkBPwBPbfmjAfMx9eHBVBxGlAmCremLR3x?=
 =?us-ascii?Q?f1zXpE4TemYHZjXPaihjgxDr8iiFZ7WQcyc+xSgH81Z7Mx/hZSjI3xeCx1KX?=
 =?us-ascii?Q?tfk0z8PeLPD6f4Wk9FiU+izPF8eNdD012zkLuHW8Xqkrgc8q/Y72h5u7t/bI?=
 =?us-ascii?Q?ub5f/+viAp4L3JosJZqWM+r4cLBcMwfz1f5/JIx1WRwIzMbZ8f8jbyEYHscm?=
 =?us-ascii?Q?HyAr0nVYgrcQbhEmGSEkD2yVNbjSn0ZkEE8NpTAeu/ETVf6rcqCkmhdEePbW?=
 =?us-ascii?Q?Ou0+F+7w1C14IhShL4zRgoLeqSCo5Jvb6m+LcXFMTsUnBlGFDH+GwO3AG6XH?=
 =?us-ascii?Q?u+46EcOo4A94pPDjkBvM9tAErxvEZz1gha8mHHro6BDzmnKrD+T/NhKKJe9x?=
 =?us-ascii?Q?VuLR0H7s63nz4acpVSgQSqF9VodqbfSuItYSjGKw+yW2MQI7KA9cIlY8f42/?=
 =?us-ascii?Q?rR9tAMEI/tEVG32llLJVgDH6i9RjLdf1WYNtPNVqfx6lN3F+t9RBzMsudl7b?=
 =?us-ascii?Q?kY7f9xs1ght5M5oE/dsLN5jui10Q4szxj0zGjhV3pDEp7NLqMoB1Y/OSEhWU?=
 =?us-ascii?Q?lDFpdEzPneW3K5n36XDGYLSg9g3jkzZbmrGtYABUSw43+1t5kEDj+/KV/+Ew?=
 =?us-ascii?Q?hmPvieCxjSlrsB30+fo7Bm8g0xglaMtk4HsllDY5feEAANDIX8Q8Yuew+P21?=
 =?us-ascii?Q?ig=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	s/QOPNBnAH1EzOlR2su7oaJNg6i7XGU1umtX41ewu4c8eMhxm7N841jzUq9X02TbVkKqdgWIi0E/YWach9hAY7djiqqsmEZulua7soYaNVxA4o0svWfRT68bnU2xT/nS2xkFI6dSb+sVautyNDF1lnD4HwKvDje+9YFo4sJGtAT6HKNa3yVwrLa9ksGX1Jk4c6qieeAvekOUb7kBhj7lG60zjY0CEMoWIL7c+MNV7DCaX8PkzTP3A5iy1go6zfBUdFSwa+RLKLUTBiMZMwD9XfHbafTPeTt7T6nH3yY05lIPWTf2xBPQc6M5+xXt3iN3tfsrUFlNIgkDmm6wEVzdX10auT9oiIs0Id8hsM2/OPyca2/G5M8jNBrvz/1ihjFTz3JTMqgEPNYSfKoJ+LCqJ8y5X3hjJ9s/dvT/30pYgw5J8hBZnUGDRJsno9EcgO9FZUQcWM2bguivMSw/Iy9BzuA/Y2HpZh1uPyBBGheg+5oGhBrgwXtgkmZeLGR/r8vccE+zJXqr8wU9h+kLcXTDa6kRT1rKeItL/EvSpRBspCChzF/ASojr+fqsUPRp/4CHChR5+6sBvCvtxHAd1K1/UpbWuKBd9YjWPhxISLIr9KQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6641ea89-5be6-4256-a030-08dd1648df02
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 22:53:59.3636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J0fqGTsJGhsy62L9tken9zheoPud9Vh8+LyImlVPwlHtFExk3Oy8XOhpDrbKifsgaVvOsZFb3WPNChdABiP/OSoTtl7xFvmXEZNDw7OIOSI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR10MB7924
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-06_16,2024-12-06_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412060175
X-Proofpoint-ORIG-GUID: U4l1ZARdMYla1TbowidFgtQStwI4MHd_
X-Proofpoint-GUID: U4l1ZARdMYla1TbowidFgtQStwI4MHd_

Andrew - I'm guessing this will hit mm-unstable alongside [0], but to be
clear this patch relies on that one, as that one fixes a case this check
would have highlighted :)

Thanks!

[0]:https://lore.kernel.org/linux-mm/20241206215229.244413-1-lorenzo.stoakes@oracle.com/

On Fri, Dec 06, 2024 at 10:50:36PM +0000, Lorenzo Stoakes wrote:
> It is of critical importance to check the return results on VMA merge (and
> split), failure to do so can result in use-after-free's. This bug has
> recurred, so have the compiler enforce this check to prevent any future
> repetition.
>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  mm/vma.c |  8 +++++---
>  mm/vma.h | 26 +++++++++++++++-----------
>  2 files changed, 20 insertions(+), 14 deletions(-)
>
> diff --git a/mm/vma.c b/mm/vma.c
> index a06747845cac..543c102b4062 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -447,8 +447,9 @@ void unmap_region(struct ma_state *mas, struct vm_area_struct *vma,
>   * has already been checked or doesn't make sense to fail.
>   * VMA Iterator will point to the original VMA.
>   */
> -static int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
> -		       unsigned long addr, int new_below)
> +static __must_check int
> +__split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
> +	    unsigned long addr, int new_below)
>  {
>  	struct vma_prepare vp;
>  	struct vm_area_struct *new;
> @@ -710,7 +711,8 @@ static bool can_merge_remove_vma(struct vm_area_struct *vma)
>   * - The caller must hold a WRITE lock on the mm_struct->mmap_lock.
>   * - vmi must be positioned within [@vmg->vma->vm_start, @vmg->vma->vm_end).
>   */
> -static struct vm_area_struct *vma_merge_existing_range(struct vma_merge_struct *vmg)
> +static __must_check struct vm_area_struct *vma_merge_existing_range(
> +		struct vma_merge_struct *vmg)
>  {
>  	struct vm_area_struct *vma = vmg->vma;
>  	struct vm_area_struct *prev = vmg->prev;
> diff --git a/mm/vma.h b/mm/vma.h
> index 295d44ea54db..61ed044b6145 100644
> --- a/mm/vma.h
> +++ b/mm/vma.h
> @@ -139,9 +139,10 @@ void validate_mm(struct mm_struct *mm);
>  #define validate_mm(mm) do { } while (0)
>  #endif
>
> -int vma_expand(struct vma_merge_struct *vmg);
> -int vma_shrink(struct vma_iterator *vmi, struct vm_area_struct *vma,
> -	       unsigned long start, unsigned long end, pgoff_t pgoff);
> +__must_check int vma_expand(struct vma_merge_struct *vmg);
> +__must_check int vma_shrink(struct vma_iterator *vmi,
> +		struct vm_area_struct *vma,
> +		unsigned long start, unsigned long end, pgoff_t pgoff);
>
>  static inline int vma_iter_store_gfp(struct vma_iterator *vmi,
>  			struct vm_area_struct *vma, gfp_t gfp)
> @@ -174,13 +175,14 @@ void unmap_region(struct ma_state *mas, struct vm_area_struct *vma,
>  		struct vm_area_struct *prev, struct vm_area_struct *next);
>
>  /* We are about to modify the VMA's flags. */
> -struct vm_area_struct *vma_modify_flags(struct vma_iterator *vmi,
> +__must_check struct vm_area_struct
> +*vma_modify_flags(struct vma_iterator *vmi,
>  		struct vm_area_struct *prev, struct vm_area_struct *vma,
>  		unsigned long start, unsigned long end,
>  		unsigned long new_flags);
>
>  /* We are about to modify the VMA's flags and/or anon_name. */
> -struct vm_area_struct
> +__must_check struct vm_area_struct
>  *vma_modify_flags_name(struct vma_iterator *vmi,
>  		       struct vm_area_struct *prev,
>  		       struct vm_area_struct *vma,
> @@ -190,7 +192,7 @@ struct vm_area_struct
>  		       struct anon_vma_name *new_name);
>
>  /* We are about to modify the VMA's memory policy. */
> -struct vm_area_struct
> +__must_check struct vm_area_struct
>  *vma_modify_policy(struct vma_iterator *vmi,
>  		   struct vm_area_struct *prev,
>  		   struct vm_area_struct *vma,
> @@ -198,7 +200,7 @@ struct vm_area_struct
>  		   struct mempolicy *new_pol);
>
>  /* We are about to modify the VMA's flags and/or uffd context. */
> -struct vm_area_struct
> +__must_check struct vm_area_struct
>  *vma_modify_flags_uffd(struct vma_iterator *vmi,
>  		       struct vm_area_struct *prev,
>  		       struct vm_area_struct *vma,
> @@ -206,11 +208,13 @@ struct vm_area_struct
>  		       unsigned long new_flags,
>  		       struct vm_userfaultfd_ctx new_ctx);
>
> -struct vm_area_struct *vma_merge_new_range(struct vma_merge_struct *vmg);
> +__must_check struct vm_area_struct
> +*vma_merge_new_range(struct vma_merge_struct *vmg);
>
> -struct vm_area_struct *vma_merge_extend(struct vma_iterator *vmi,
> -					struct vm_area_struct *vma,
> -					unsigned long delta);
> +__must_check struct vm_area_struct
> +*vma_merge_extend(struct vma_iterator *vmi,
> +		  struct vm_area_struct *vma,
> +		  unsigned long delta);
>
>  void unlink_file_vma_batch_init(struct unlink_vma_file_batch *vb);
>
> --
> 2.47.1
>

