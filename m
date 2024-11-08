Return-Path: <linux-kernel+bounces-401396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98AC29C19B6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 10:59:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC01A1C22F63
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 09:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4581E22EE;
	Fri,  8 Nov 2024 09:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LFhmh3wb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="utdxpSLK"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B601E1C1F
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 09:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731059923; cv=fail; b=f339U9PAO4ITYfw2DmGOrbkvK/iZmnQEsKwe10nn6Opwp/MPWdgesDKj1uKISk+D4gKaSK1DNseeKiHHFALfs2uwqeIicdEhNmTUrb49JTN6iFtOzuJ/F0HOv2bUC+YwZ1SUaz5guoDNXyrSJdjOMbj5hQkj4uJae1CCRpTxz2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731059923; c=relaxed/simple;
	bh=RLB++tlwMs5+ACc42xDfulsXATR9ZIuNtwcNeWH618E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MyLvIxGngabuk7UvkJNw8dwOWaF+M+9C8Y2zAfc9ItfQxqijrN+vrQULNEBusNx7Dcr4j5kflVmoj/dv/vqjnP67GR8D0XVyeEIonhHdNwlxwwaIvpf2zTofcYY/HCYDZ4JP53g78Xjwo1oYkpRFLRQ2LbpL3tKhb0gm08FGPyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LFhmh3wb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=utdxpSLK; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A87tWSV007374;
	Fri, 8 Nov 2024 09:58:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=4+GphNd/oob+bfQVcgPqEGMNbpp23ENhRmpvLw2Rmt8=; b=
	LFhmh3wb7abHFnSB5b9SMOdzNVeF+2NEsn0+ZvlLDYu7iIOLKIPfdQg/xW494KOJ
	EV0pCpxcloAENqzWQ5jBr36qFYF0pjew5SYBOFw1mGsCNFQpupmJ1a85YuBhMxX5
	OA0LJe2JfCcIDLxjUMLEXCgdTEfZjvWAQ4nvZdgNHyKPb4KVG623iGHmB1RCzr/i
	DpMzhzHvE2OaSEa+jDQOCojOsGHv5SD6HeLx26sEw+iP+nAJLQvpYptdDho3bCjC
	cdzbB0ojUVtOa5JSZbwZ0RQT8FAUyVVaAokQLZAVdGxZu+vrNi9O/EVNjm4/8nMb
	1QQWFfJyhgjZkx/tDw8V9A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42s6gjh42n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Nov 2024 09:58:27 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A89fdmn036171;
	Fri, 8 Nov 2024 09:58:26 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42nahhjwgq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Nov 2024 09:58:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ChTUzn78OvbxSwjIjFGyB7VLBSf3dbACtmaEY3jUkE0nMiZw3XLdhO87LHd8nWyAWwwSx6KAf91DFnBT+cttTA4O0MJsgJpJZrdgyoGveFdl3p/aE1Ws3EZol/XxRWCW8r4H0COfYbrNXXHOAxWmixRKUCQbbSMWAIw0wikbhi9MTraLBdJzg5gSoj8QcI4tUJ1SdpcTksf3JxzCQnKV3BQs8Xsez49/m+fz6V3uydRbqm+B+fhSakxJW5bwZe5IGIByzt4+Q0DgG1iF/TKoNDytklg5oji6iH5NGj1w0nNLUBk9yFLzVch/dpGVp0AX3JGGVelI/U7EyFs7rYTBiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4+GphNd/oob+bfQVcgPqEGMNbpp23ENhRmpvLw2Rmt8=;
 b=ChS6G5Ol9OOlAjR3RhpYKuuLlCQrDIQjvSZ7JonXRbm86qZq+y86R5P/g+k7rk7KKQaqZSngbEfpYnKze38Z4ezbzmPCsVHRspN4qnuLIWJYkgiztWf7tWyy9FOAKq+nUgro1SM1odpXmKsl+AHp8NGdkWkeyCSevVeNjP5AP5VjjTfb6l9BqabGFWBdaSKaD0j8Q9JnZ4ruf3lpUMhYpfCqdYJx1BKM0q07YLDKG4iAZznOhiCVtfYtDspDV+7z3aCHGJFQVgPYNGKMM3YFGlV7k46nd5VyGwKstzTxrLB4nEcXt6N/tkxGjvYRrDXzNiyQLfzdyatuB1roDHxGlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4+GphNd/oob+bfQVcgPqEGMNbpp23ENhRmpvLw2Rmt8=;
 b=utdxpSLKNTOdqLzWHHe27peQIZGGc/ZMLNFTqLupMeVKNuKN+4Li7XcP5chisXsmFwkNz+R3M43y83Qf9Qw5J+WdTvxF3Lc1GRs0tu0WwJZ5ZrghWoWDTrN0OlC3B0sBIbl8GcvV9SGgAfsLXdG9Krou9jyfwc2FHIkOP2TrFYk=
Received: from SJ0PR10MB4720.namprd10.prod.outlook.com (2603:10b6:a03:2d7::14)
 by SJ0PR10MB4736.namprd10.prod.outlook.com (2603:10b6:a03:2d6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.21; Fri, 8 Nov
 2024 09:58:06 +0000
Received: from SJ0PR10MB4720.namprd10.prod.outlook.com
 ([fe80::7ac8:e778:e4b7:13f0]) by SJ0PR10MB4720.namprd10.prod.outlook.com
 ([fe80::7ac8:e778:e4b7:13f0%6]) with mapi id 15.20.8137.021; Fri, 8 Nov 2024
 09:58:05 +0000
From: Rudi Horn <rudi.horn@oracle.com>
To: Dave Hansen <dave.hansen@intel.com>,
        Aruna Ramakrishna
	<aruna.ramakrishna@oracle.com>
CC: Thomas Gleixner <tglx@linutronix.de>,
        "mingo@redhat.com"
	<mingo@redhat.com>,
        "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Joe Jin
	<joe.jin@oracle.com>, Jeff Xu <jeffxu@chromium.org>
Subject: Re: [RFC] Restore PKRU to user-defined value after signal handling
Thread-Topic: [RFC] Restore PKRU to user-defined value after signal handling
Thread-Index:
 AQHbMHpucV7Hizrp2kqRQDNKin6377KqosSAgAEFPvyAAFJgAIAAheMAgAAIaoCAAJbqMA==
Date: Fri, 8 Nov 2024 09:58:05 +0000
Message-ID:
 <SJ0PR10MB4720CAFB829ABC467384BC799C5D2@SJ0PR10MB4720.namprd10.prod.outlook.com>
References: <4225E088-6D34-421A-91AA-E3C4A6517EB7@oracle.com>
 <4d484280-3bed-453f-b2f6-0619df4e9914@intel.com>
 <SJ0PR10MB47208C97D877C27053E546DC9C5C2@SJ0PR10MB4720.namprd10.prod.outlook.com>
 <7819c425-5792-4cc5-96aa-9c8b012f1a06@intel.com>
 <4111AC83-7A7C-4268-B294-3AB75C0EC451@oracle.com>
 <59464733-17d1-4b43-83f4-e85a8389638d@intel.com>
In-Reply-To: <59464733-17d1-4b43-83f4-e85a8389638d@intel.com>
Accept-Language: en-CH, en-US
Content-Language: aa
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR10MB4720:EE_|SJ0PR10MB4736:EE_
x-ms-office365-filtering-correlation-id: b3566883-fa85-4290-bea7-08dcffdbd791
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?O3Hugj9qucDZRN5YUYL7f7HZ5xzb2dPG63tEFsssSP2qH8Ckaq80+6OcxCV3?=
 =?us-ascii?Q?ft9O/xPFdbgUzSGktR73sNZHllAe2koFVj3Qe1zTKwU2BXYXAZ3RNMfwSDxz?=
 =?us-ascii?Q?qbN2HzGvnbbFURs5c+kf/841eeRwJOVTByjtjGTEoOgIthlYbKJ0yW5uzTm3?=
 =?us-ascii?Q?w0aQx3ipKTAvXqQ2Crwh3sPdQl1LsWs3f0cExT/g94wcXGSbtTD5oZDPHkPF?=
 =?us-ascii?Q?R6XSxIX/BUI4yI+ceQpVCF0mtJKNF/Y8JJ4gN5e8dOnf73OO72h61IgmhHjs?=
 =?us-ascii?Q?uVlzh1915QNcR1N2pOd50Jw+7tJsHpAe4m5dfqEWKcz2MbDsYG8vuDxVb9nj?=
 =?us-ascii?Q?lbcumcOY4usK+vJDNWVYU13WavoZTXMTFdL6kX2NaCMdE59kjEyHCvsZbTu7?=
 =?us-ascii?Q?E8fYs0OGjp/rnwZ6/U5sUkdIMrZHSBFcfQr7ZdHc4AD1fOM2FyH8xHSp6jlb?=
 =?us-ascii?Q?r1SsJazRWDwwA29lGFPCVo4X2E7J2g8QFffBpMAD7nxLg0M7pkBDS4XHLZhk?=
 =?us-ascii?Q?ynFzyzOErG7lSF84WFtlX5ufMS9qgbTBjbnqK8wgBjhFVjXvtDKEamWjEXtK?=
 =?us-ascii?Q?TB1o4ivwpYZURZyubs3JGIMANo2IAlnLcU1bgQ/nuUv3SfdmXSN6O/xeqdsn?=
 =?us-ascii?Q?kkb/614tijr3hbkC0vgbwJtpa1TLKQOXauODh4Oc9rknkjvZgmI4QV9IR+We?=
 =?us-ascii?Q?24qNDLrpJy5rB1U3hEPTT2mlkW1I+Ed2auWwtp+X9DAm/aV1i4xhdXBHgluJ?=
 =?us-ascii?Q?n2TQdqC8ZEVygRr0JH+JHT00E5f8CxBstnziX3j4jy6rGDHf0VbhOkbA0sO4?=
 =?us-ascii?Q?2eyDOLlwqA95edxZGX76j999LRZoMpHJUyTtHCkeXCu7GEkkf9/A1GysPstm?=
 =?us-ascii?Q?4iJA+TJ7kde5lcIfas0SPCe8h/nSyqODFW9IP8EPhgeGZfJxdebDS1rqjlkj?=
 =?us-ascii?Q?0GwLoq82yfEnD/U9xV73qbBSAPYVb4ueg36qo2hUDjmAu6GR35sSdD4mI7MB?=
 =?us-ascii?Q?R3prHZpvr7JSYpGXe0DJJmNwcZgvGcwsAfAqQ9ClHddctm1rFzpnnTsn7Z44?=
 =?us-ascii?Q?WB0MxnwV+2TNCrKaFS/BibLg/l4LL5ykCOvuu+RAdw5ZlPpzPvXq7fB30OOk?=
 =?us-ascii?Q?xFqkpEG1vgvnDy2qXaas+pZdyLxX8pUEYjM7uY9R/FnughDDSF5j7HreOwtQ?=
 =?us-ascii?Q?+aZoF02Mk4JQ8GbPtaz01WjgeCov6+G4c4eOSTqjKj7yBKlcOBBOV63UX8uD?=
 =?us-ascii?Q?MhVbavtntPduZ3vIHMBaCtLnzmEgm5sJ3FR2KvOpgL5ylEPE4qro2T466qSe?=
 =?us-ascii?Q?JzO3w5PMGNL9oojiulEOSKtHuI/yhy2Tujpwg+9Ri+Oq6fZSh/LBW+jea9Fp?=
 =?us-ascii?Q?u9wL2PA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4720.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?QivLxUojv+gthQ15mYj5UmIU0T7w0XjJ2UTm+wWDOaKKxSNIkX6k5sagaXqZ?=
 =?us-ascii?Q?04+KrDkC+nf3XTHVlaxmIE9UXG3sAYPPaQpJJJRWShOznG2HwStyTt1wPX9X?=
 =?us-ascii?Q?odRdKBKXssneOBw+RoGEZNinYofMgeyRD7dRtJZqNmuRPfP/H9IyqrNenbaD?=
 =?us-ascii?Q?GvAGfqwqTifQne3WpTO+JgVdVmXqf6zhK2ZhfA02qZw8rvaHTpVHSugA2mTd?=
 =?us-ascii?Q?odszlqBabXybM47/uRp1No8XDtoIO2V0fyLOOpPjS8r79OxcD5j1jYspNjIO?=
 =?us-ascii?Q?z7Z37ZfM8IBvzNVOvgmh8zICteAQUCpCGYGjilOoBXN4VZczPnleLspv7EOE?=
 =?us-ascii?Q?VYsaIh0XggcbAYJHn/GJNFrnxYWB9F4r6iLXgP2kgrhrSl+jeM9kvNXSeEEC?=
 =?us-ascii?Q?PSggxNnd4loqJHwgeAYMcpGGv8HHzqwBOu3yf8n00qEf4RAlzU0Y1Dr9op+u?=
 =?us-ascii?Q?7pOlCOBXz7HfiMChTzgLaIUQkKgPzXkHR4JT1/csiANtBqVwrmCdvMBqC2II?=
 =?us-ascii?Q?Ko3iJ9DRk1zrqxuJtJMe5+KP44gFRWnUX/mOlSwCQuRR56LYqtN4AHEXwnnU?=
 =?us-ascii?Q?IyjxYIR/Hu7BoPlFMl8JptewGI/KNK0AaGR3Ihtjty1S+hmWkhrAw5v/ThVO?=
 =?us-ascii?Q?ydAJoK0waWGXCoOEgWFfAsItId1Tit5cMAOQE6RgUPBPtd7Gw85697Gu67sw?=
 =?us-ascii?Q?dBm5niizbUo/WHbRvZLcFt6GicxJ2IpZRZuq37f9uaueKKC/3KWr8w8q8Zqi?=
 =?us-ascii?Q?AO1OBOuiMKEAgGKGON/B49tRy++dh4tgKHXLNnfioEET9fs6CvIuEtLuhBS2?=
 =?us-ascii?Q?FRMCZjPeTgoTlGlvgyPOH+OddKeoAmbFZYXZW1tEfayElmq62KKuSRmzWRDh?=
 =?us-ascii?Q?PfnpsKXqZb9+2lwvrm29unCkOIvqidQMTMahw9f9ADrQC3rnd/tN+tHsz5Kh?=
 =?us-ascii?Q?L/MNCYa0O5uwD4xFqUV8diZgRHCqkTR1B3NkXIVVelPy1PmOQ9OY4TrnpFUe?=
 =?us-ascii?Q?Fm9czgW2RVX2hUxtR+pF4LlsSfSHu/7I+GGPxiYUgSdvIu+B3EbZQwKWNqKK?=
 =?us-ascii?Q?BbGGVqB+m4b/0QE2nF3g+GbkfWFc84EeTbpa2e7pTtRBQ4pLV2tfMosPkzH+?=
 =?us-ascii?Q?QN/t3qpM7jlQ4DUIgyXmuywtyoym32KPvGYE60V2kJbNSbyBZ/rBb78IhOf3?=
 =?us-ascii?Q?+hdEfqX4z2EGzmmlUGqDedVAt9sxJO5Wuqv8QzEB+C3C1B3lqSWaB7jjp7NZ?=
 =?us-ascii?Q?DJkfNEZhZ+li92UDAAfTsb1jqx5AwQ42c8gWpfWxnNn1UMfognYXWJSfNpwi?=
 =?us-ascii?Q?B9nZPTzLxbNRRnb3PxOGqvamnFTCYdL2R7MnMgxu8mAaGxSM6QopdQB5CTIC?=
 =?us-ascii?Q?jQ6YUXdXcVvadX8Aft1ACcis76x0S0e69BeTPR3j7ZBzmjEF8BnY8JELpY1v?=
 =?us-ascii?Q?rAivJ4As6GK8gfjaSOFIMW3WOolwXmDq2Su8qzE+fa3VxlZ49XSu1KqfHPzV?=
 =?us-ascii?Q?gb+fCRz5SFm0rRDCHgCnzv6+/bZKwVjX7LrB5dcapJtO9vFiGNSUv0coPWEK?=
 =?us-ascii?Q?JQjJhmR0E62vzZ3HpJQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TGMeX8gQ5mu4J/89Yf3fIZDrv2i/I5zSfr+0hHCOnfWNqck4v3A3ES/IRtxSHAAox5oKVkvRJgqVFkgqUoZhHw/2Qef/DyrFYQNchnT0nmxK7+WmHNICCh6OAvYeMcVnaE5GTJvkSf0HNpsqiWC0r1z/REZqNaF1d1r/BRE+P85SQLWe0Apw2SGWCqNvMzai3d677CStEdlmrvvCEGb/fE2tG2Sz84Dws9IMNFGkBpasyrc+eJTbxKti0O2n2SfKeftSQT2rRdjP36Sa+emvbdk/WEgrthIfDHPdxWdxiwUunZIOD3YNr68VdsbP0YWAJDv8RhAwDNDkjr/61m3FrFOW422ca9au9eHMr9/6XQszb2OF7P2XW2GsVKVCbKfNNSY1EX9zeA5MD7S18nHKDb2N/PC8aSXtHF7Qg++lgysLXQkZycV6KdBm8c+BK5YeJItR4HTjIiudIRsss4dL7pm9GyqI7nI0zuxqxJpAQl95AnxVPhcR4o2tN1q9zyK/BswUt++L7wJhLkhKC1BCX9E+2MPLO9vrsJSU1OHyoiSk9yYqcxxyBmfG4HSWkg4f0PBBtaZHPfFpqa1gICMTrFdwdsJ+fRkuPOASxzy+5Dg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4720.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3566883-fa85-4290-bea7-08dcffdbd791
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2024 09:58:05.8917
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: paG0KLYHq+SU+AN9NGV1jrBdyEYWeXJDmTk3xGpQ9mcU4oRYiPBi4mVyJgbTDOuBtbIVakgZiq4Bjgm6tpIABA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4736
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-08_07,2024-11-07_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 spamscore=0 mlxlogscore=582 mlxscore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411080081
X-Proofpoint-GUID: i5u8IP3RdN2kPLmSQXhrNng2JcbXfzzI
X-Proofpoint-ORIG-GUID: i5u8IP3RdN2kPLmSQXhrNng2JcbXfzzI

> Tell me more, please.  What changes to the XSAVE area are you concerned=
=0A=
> about?  There is currently vanishingly little code between the XSAVE and=
=0A=
> overwriting the PKRU state.=0A=
=0A=
I'm concerned about any inconsistency between the XSAVE area and the=0A=
current CPU buffer, which can be caused both by changing the CPU state =0A=
(e.g. a zeroall instruction, or any FP register usage) as well as by changi=
ng the =0A=
XSAVE area (we do not know what future CPU features to expect). There is=0A=
currently nothing happening between these code sequences, so I'm not=0A=
concerned about this change being incorrect. I do think it would be easier =
to=0A=
read / understand and harder to accidentally break the code going forward i=
f=0A=
the XSAVE code was immediately followed by the xgetbv instruction.=0A=
=0A=
> The question still stands as to whether the new XSTATE_BV value should=0A=
> be calculated by the kernel or read directly from the userspace buffer.=
=0A=
=0A=
I don't really mind either way. It somewhat depends on what the overhead of=
=0A=
reading the value from the userspace buffer is. It is a bit unfortunate the=
re=0A=
isn't (that I know of) a read-modify-write sequence on user space memory th=
at=0A=
has similar overhead to a plain user write. I think it would be safe to opt=
 out of=0A=
the userspace xfeatures write if the PKRU bit was set in XGETBV(1).=0A=
=0A=
> I think it's safe to assume that if you use XGETBV(1) that the state is=
=0A=
> sticky at least until there's an explicit change to a state component.=0A=
=0A=
I agree with this, we already rely on the xstate (a superset of XGETBV(1))=
=0A=
being sticky until we save it.=0A=
=0A=
Thanks,=0A=
Rudi=

