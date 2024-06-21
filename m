Return-Path: <linux-kernel+bounces-225209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A92F912DA0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 20:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8677287602
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 18:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D912917B423;
	Fri, 21 Jun 2024 18:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BCIgHSRU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ut4kpXEL"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92F08C1E
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 18:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718996382; cv=fail; b=QyDmKh5ozZG4yXW1Y1JREvxpCvvNJHQwyuqWeP/AmdAtqRD0b0dvQCtnr+TQIfIefSH2veVtND43Khu1mHfQF+++t8toRwNTV1aPySdFaX4J896XmS//PnOzgSbKiPHNo1ggiRGkLt6zuHCQGuIbynYGjzn5AgIW9dPDXFwK9Ck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718996382; c=relaxed/simple;
	bh=aZptx/9a/TJYxH1u8FzJvzs+9Lz0qo9bEZf3o3CtS14=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=BMh5jRPWwgsgci+DSdI8SkYyqWBq0VjaZf3kGkmLLGGfYjiPPWeybY5WlZw8uQg7SK33a/NQHjZ76QNxjDcO2lpskm9NZhL3YH60aNu/RsvITTiMnpOTAK2elX0PrueiEkJCNV9ACiU4x6xi7P/Ualzf165Bi9d7z9ByiQJCNIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BCIgHSRU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ut4kpXEL; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45LEXTH0010247;
	Fri, 21 Jun 2024 18:58:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	references:from:to:cc:subject:in-reply-to:date:message-id
	:content-type:mime-version; s=corp-2023-11-20; bh=U6xAfeJa9Pobkf
	22ShA9PBSI9yX3BmBWYo7Af5b33+E=; b=BCIgHSRU83WILr81whYX1vGrP6cUJM
	vG5WCsV/DbTNlpZdQ6a3aJBY0KkwQinX43fW93f4j2utlZfO9ARVveMfbRz8h49P
	9FMP398BBblQn7+Sbix4EwyuX3WB3EhrZP0epjGyR9CUdJylVQYe50/72PuSUuIQ
	cl77aTBJdFyRCuj3N6rPVMGKlM2IeJYspVImRMS6NdkDBgEUDZrRemY9229JdBc+
	EihUT5quxa/lYPX5OETp/XMs00G3Cp4v9LrvKgaZnlchG6FR+JBjxXxoYF257FTt
	JSpKZkTiO8IbzPEaaH2Rs93vtzODGBSyF4bN72yAfSg3VFuBytyW785Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yvrkfab7u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Jun 2024 18:58:41 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45LH0K1B019509;
	Fri, 21 Jun 2024 18:58:40 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yvrn474yu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Jun 2024 18:58:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nPedXAvza+I2Fbm36ayHEkyjLsG+OFFAG4AZBxRLk5xp9QF/sl/gZ196JxSdYL9HTOpHEzauwN+m8S6Tx38soShEgJVLuqfkKZaWdu2q/alig2Gxz2ejseTD/5yy18DXVIxZeuLTadlOJRGwbdfeSs+RS9opAquViEtqNcljEu0PMOM+j6TEdXrQp5o/8G4fYxLAQsBgE/CUVcFGP5Kx5qW24ae5KfmXLEct5lOx7rcPf5Uww8Jrz1GM6TifiWzWDnC1cAf742SER1esg3OsKJioQJxm58hbfU8CxVhWtOWOFAwhvxQ8pthTiaDTYjVZnGr8bHDlnObXtVRO01nt7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U6xAfeJa9Pobkf22ShA9PBSI9yX3BmBWYo7Af5b33+E=;
 b=WJ9OuU+1JbLImoQwSYdJsAuUQlGA2OcoLjRRKNk1Bku+t2PRQNLhj72I7ohXJeAp/REkwogVqh7UGxMjs/E/brlDftfNvJyoT4JxwRBuiC+yJOjz4VJSPre1N+Bye0rOJx71O374uBhdCgZ8fAoMAYj0242XXBH410V91y8LMmjFXCiIrkkqzQLwvecEfcDkoGUSFt2fu2CHvkDgsKOB69KpB8SANPwojW7E1YWQiGrXoypS+PFjIUFa2D8pBYKoEm1Iq+BhfHont2sfRxS/72Y5AqmhNc5mBGp4xXto0Lwo4VI5HIU6Owbq87Ge5scvRMCxu2DlFefBuNwlxZ/Iog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U6xAfeJa9Pobkf22ShA9PBSI9yX3BmBWYo7Af5b33+E=;
 b=ut4kpXELtHFXczV3RPLHTW22A0KZsi2h1NeURIqu6KULgiPFMFpWsuzJnfOwTySm26FDlqIVGJohr5wVA/oV9idACZSQRSpeptewQeoKDb1zCaRf93Ei/b5cfM1A6Iw/ai8GXR2N+PdvdPCrU8tamZFLSH0Gvp36NYsFFl14mLU=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by BY5PR10MB4210.namprd10.prod.outlook.com (2603:10b6:a03:201::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.24; Fri, 21 Jun
 2024 18:58:38 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%3]) with mapi id 15.20.7698.020; Fri, 21 Jun 2024
 18:58:37 +0000
References: <20240528003521.979836-1-ankur.a.arora@oracle.com>
 <20240528003521.979836-30-ankur.a.arora@oracle.com>
 <8e6f02a0-2bd0-4e75-9055-2cb7c508ce4e@linux.alibaba.com>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Tianchen Ding <dtcccc@linux.alibaba.com>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, tglx@linutronix.de,
        peterz@infradead.org, torvalds@linux-foundation.org,
        paulmck@kernel.org, rostedt@goodmis.org, mark.rutland@arm.com,
        juri.lelli@redhat.com, joel@joelfernandes.org, raghavendra.kt@amd.com,
        sshegde@linux.ibm.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, Ingo Molnar
 <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 29/35] sched: handle preempt=voluntary under
 PREEMPT_AUTO
In-reply-to: <8e6f02a0-2bd0-4e75-9055-2cb7c508ce4e@linux.alibaba.com>
Date: Fri, 21 Jun 2024 11:58:34 -0700
Message-ID: <87h6dmazs5.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: BL0PR1501CA0017.namprd15.prod.outlook.com
 (2603:10b6:207:17::30) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|BY5PR10MB4210:EE_
X-MS-Office365-Filtering-Correlation-Id: 768d1f13-db68-4305-8543-08dc92242848
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|7416011|376011|1800799021|366013;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?qCIhPA/BnOJCNJpvEvmCPnX3/xTtpHW1HeTEH77RjLzyI2fuZYBtTgssfi41?=
 =?us-ascii?Q?RJqRMroAbhOpWbkAW1rGIY/XWGT9zjFh2W+dqJVQ75XSYK0P7dfQSm+jtg0v?=
 =?us-ascii?Q?aadQ2CdRewD5qTwZXO7O34O2IxFStKvFL5ZAOC/D1raMvKv+c2gXam++pBAs?=
 =?us-ascii?Q?POXHbFAvKtLpzC8o/ozvFAVQd8EkoD+RxjMe9RNl27NNzvgCzRMzhTUw52KO?=
 =?us-ascii?Q?SOLpEBQ9416fFZ9uwh8MEbjsauXJVuX0ouZ/KRNljM7Yjo4sTMfBWQzqIX7A?=
 =?us-ascii?Q?Sq0jT6XaSwpxRzhgYFlIbYFnxscOTvDU5wQNwShyHlNfrQfJh/w0FtkhTs89?=
 =?us-ascii?Q?3n+TKGBqajaGjRN8EKDReouRVlTT6J0/zEvOtAb+ZuKS70kLw5g/9iD+P51O?=
 =?us-ascii?Q?KhJMcQ+2Az1F6gHZNtW98oli2IRr4VlCiQLW2+GfB4pHn9TIwdAiAZDodUm4?=
 =?us-ascii?Q?XTlcjAUBt1YkkvD1WtoIBjOU4yPq3f46yyCdwkfveEtEnppdjHjIrpAmPeNM?=
 =?us-ascii?Q?AprPkCbY6owX9iilhTxvo2Y0S7rf+hidTsKy5JzO1aIMCxCq3HFJ4fvdkIp4?=
 =?us-ascii?Q?2B/ZxqZd4GqSTvLoikE9hIB0sdJgeNKW2otfLKW1vdVqgndZqSqguUv9dFy7?=
 =?us-ascii?Q?p47K43QUhk8Z4Zj5yV3lyE0asJMNLAAMuSzHJ1kgEyXI1U1kBj8s/SpUNYqB?=
 =?us-ascii?Q?KHkJox6P+tNkYf9WitWhakudrhn9u+7cxmu6JX2NSlnF2t6+bGyDkAuES45o?=
 =?us-ascii?Q?UZVSbBSd90rjy2ohyZ87z/+7U9+Fgu+fIaw1leOg5VyngRSTJbnZYIp9qJrY?=
 =?us-ascii?Q?YKBR8tcsCv8HlHz6xzSvTPnKEvEp/i2QymA7ZWA9sY9ULT4mWHEbRV7r5FQw?=
 =?us-ascii?Q?5r9wtodtlpWa288h+Ne93teazLUSxsh7rgB69voGJwZKUT7fcy9yBk/PyHqA?=
 =?us-ascii?Q?itqMJ/OUn2k7dC+wdEnUvs/3yVwxmN1VfPbcegbgUrLKlLRbWpGSJIozvyk2?=
 =?us-ascii?Q?3nPtP2jEgSDwWPmgdsxQ9YxTwNVPm7EqjGCZ3oHIkcaOzdYKNOayKRYrNUtP?=
 =?us-ascii?Q?OaJOApPT76I2KtQzmf/UN+iXlnVJqKUDhqAG0o7bT8SPI4b6G/tt4DL3UV9A?=
 =?us-ascii?Q?R3px44dEWs6+s8raz8l7q/JO8dVUaH730g/E/35yY/zCLrgMvtP4A7ROvIvh?=
 =?us-ascii?Q?7uSS96jl3vAKkHxnUFGtUah33qvIycX3LpGMnXxsjCrG94wxqZpyWRB1NRBP?=
 =?us-ascii?Q?xwHfstQVdIqDErjbm3Z8?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(7416011)(376011)(1800799021)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?P/fXldbb9Sb21bEDAuxBmBdxSNmnmM9WCkTMa7mnxWisP0WwNBCS5wCv9Vav?=
 =?us-ascii?Q?73iomtzQlKiC8t0kUfz8ueoxKMpigwff3kPe3eCu+X+vbBM1y1X2JBO3eJmx?=
 =?us-ascii?Q?5hSvcpB/vMk+tCeKyMsKa5Jeno1Ab+IOP1IkMkSoo1Ejt6STxhOBo/tNLFiJ?=
 =?us-ascii?Q?TYTVfxpfDfMfQXiynIdjguf0o5EmumWsh60KYcqGofoiLZv8Zrf8bfAqkPhh?=
 =?us-ascii?Q?JBR5+LSPlSAyhcyBkQrSKqonPepiJM0E/EZ2gmdytpBdkEQ78NC1BqHfaXHA?=
 =?us-ascii?Q?aLU3V/ktPWMNAnU+eDDTE1xmuYtfnzb6C9IF0rVsChax20A1s/pD69f0wXjw?=
 =?us-ascii?Q?Upq7+K9so+fGb3chPRmXr4bgCM4oc30y00RSPXzrOWs+PHsimLuubmZigNNJ?=
 =?us-ascii?Q?PVnNZg6tq/pRHV02UnNFOjtvtY6rFcNeqbzR4h0Te2D0NL65epFAnZisHJLc?=
 =?us-ascii?Q?rRBeq1BsvEF1ab1zBaSosoym7Lym0cFCfGWaXcwGaErUGjuDPOguJdJdvVUL?=
 =?us-ascii?Q?vDJ6YzTL3S0yj5MdHr2B4mzcSwcSReQN4gfCMyBfdZm4ATl016qRmTA7ajmC?=
 =?us-ascii?Q?IMkrP8E7Yjqc46nUAYILsLrn3mhmx6O1MKYMIAwe/02tsgTCUQIUhJTUHcHK?=
 =?us-ascii?Q?7PiY+khNZe5IfAzDAL24aDnctfTe/x6RQonKOZ+zgo9wdfTW9VXUjqC+ap3H?=
 =?us-ascii?Q?0PffYDkPKlWeXJ59e6XS50oe9zv1FfnX/h/yPjCk6XV8GTyufUr2evQ+vkD+?=
 =?us-ascii?Q?Rgq7aKYY5dG6rcegtoXGpsQGKKEQcN2yXg1ADN12DTKiIIiQIKVkklzgRTAX?=
 =?us-ascii?Q?1prjHCqswatGP8OR2ouY4xOFJ4dD65FtpZtaY4wXeGQSB+mn+iSuVhZvpr4F?=
 =?us-ascii?Q?joplb3QkjsREEO98bjcjx7j1oqWR6mCfcY4R54tsuML/T9xMuLzcp1KFZ+GJ?=
 =?us-ascii?Q?sb8HoScWThTdwM2t0sjzdJEIsZflKVWiEFgQq0gV6R2jMFlo1fTOaQZl6WDV?=
 =?us-ascii?Q?RynwCoBXYI9A/KglzDLLMOBSv4gEmqz8zMFx0rk64JwSmTE7FjegaiJp+DFM?=
 =?us-ascii?Q?/6s+TS1biiv5jMgc8+Hg0qkc2QZEPo/ND1U2KQiEeaLzkvUKwpgv/ArCduGk?=
 =?us-ascii?Q?POx7gKa36N2ZP65d0cC7kUyVMSKXsC9VlZ0E4Ba6nLcWmH9LyAJcXMA6YwMq?=
 =?us-ascii?Q?lYRp/eA6i7yuwmVTOZoFTr3sXAbaGG17KwjGvj1brQX10JMgYkr0yFdKO+EL?=
 =?us-ascii?Q?LfPLIJSIuszci8d5+60qMSOUCzOJZgtsHQP/4UM6f0PZWuxjx82vHoiNBX9C?=
 =?us-ascii?Q?fExR4dN8KtQL8DUy4MD2N2Ud5dB3+9HzuaDGyHVmCuTYSgzAhFWQ8qgNLhPN?=
 =?us-ascii?Q?fFUfjMKlHW4k/DXVTY2zHpXXvN6TBngmjwLiUV7PuqcgnX+haOCUI5Q5bAco?=
 =?us-ascii?Q?pMLSu+lNlLetCzJZFQ7fqD5pjCKVWoP4cpxmgNnHgtkFXf4gNdjBvW/a4RMQ?=
 =?us-ascii?Q?osNz88rqPe2XW5JvDGrwrVG+tBxNauO9lWlNNVJ+byj/3XxxJ5iLOnJouyVM?=
 =?us-ascii?Q?7+ea9JqPClq8F1ahuCSq6cnwPxQy5p2qA73B8HZS?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	y6/TN/4xkI043F87cY96rxRmp5FYEZQt2R7SFYOf2oShi4CA3p7ff1IBREZyI/AnjtunEq6MDWeiZf8NG4uYkUXQLI215o1m/qm0430tdeByvR/MONK7u6TT81/yMB3qfXm9bhAodXNtb4HYbLShwkqN/6mvK1WcMNlB9KZNFHE6+FMa5yUXgH0twPqXE/2SxzHx98ZmV7E++3dVdVCYJmIBslUENl2e+Pk9Vqxu08/O4yfhF22bmVaRnuGMJ3SAcQ3pkNmLgdTlhxS0G/RXmOFD33rPvptHGdcSog212BZReI3foRJxTkT8Gr8DDy14tXnlqiKZjon9l+zotXqIrm6gjXuwEsjw5PWwGH4WRwSedMCHsZy8TvP3+Ygs/9hy0qW9rzrRVilWqOdXsy8rQIdxXRWjMC852mbk+8Eu8QHqiRPUpNo2GuTNtboFa/T8K3z2HDlqralFHS1KKFr1edIJsyvK56Nhw6FHZHso3ZfzO2UQ19QlvJPS/FNwGhMzGEiE+5JQG7XsZyuY95h9biBPyP8j12mXczxFkto3YhY4dDxNmHxKdBeMfbPlA9RvddLzlnfJ1qAAlDEqRFcSB45on5+sllSobVcuuA8xZ8M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 768d1f13-db68-4305-8543-08dc92242848
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 18:58:37.4672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5zRQ4I+Vt/gi5hiRrawyFagr3rO3LRBcrla+k8Ct/WZEShzsFTbJVkJ/JA/gFW/gURBPxWrcaPhLFbAjXQb1FR8BL0kaZ0X3rOZsS1qn8sY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4210
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-21_10,2024-06-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2406210138
X-Proofpoint-ORIG-GUID: sUdq2e7mDktJOhxWJAHGxmTNQoKwvduM
X-Proofpoint-GUID: sUdq2e7mDktJOhxWJAHGxmTNQoKwvduM


Tianchen Ding <dtcccc@linux.alibaba.com> writes:

> On 2024/5/28 08:35, Ankur Arora wrote:
>> The default preemption policy for voluntary preemption under
>> PREEMPT_AUTO is to schedule eagerly for tasks of higher scheduling
>> class, and lazily for well-behaved, non-idle tasks.
>> This is the same policy as preempt=none, with an eager handling of
>> higher priority scheduling classes.
>> Comparing a cyclictest workload with a background kernel load of
>> 'stress-ng --mmap', shows that both the average and the maximum
>> latencies improve:
>>   # stress-ng --mmap 0 &
>>   # cyclictest --mlockall --smp --priority=80 --interval=200 --distance=0 -q -D 300
>>                                       Min     (  %stdev )    Act     (  %stdev
>> )   Avg     (  %stdev )   Max      (  %stdev )
>>    PREEMPT_AUTO, preempt=voluntary    1.73  ( +-  25.43% )   62.16 ( +-
>> 303.39% )  14.92 ( +-  17.96% )  2778.22 ( +-  15.04% )
>>    PREEMPT_DYNAMIC, preempt=voluntary 1.83  ( +-  20.76% )  253.45 ( +- 233.21% )  18.70 ( +-  15.88% )  2992.45 ( +-  15.95% )
>> The table above shows the aggregated latencies across all CPUs.
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Peter Ziljstra <peterz@infradead.org>
>> Cc: Juri Lelli <juri.lelli@redhat.com>
>> Cc: Vincent Guittot <vincent.guittot@linaro.org>
>> Originally-by: Thomas Gleixner <tglx@linutronix.de>
>> Link: https://lore.kernel.org/lkml/87jzshhexi.ffs@tglx/
>> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
>> ---
>>   kernel/sched/core.c  | 12 ++++++++----
>>   kernel/sched/sched.h |  6 ++++++
>>   2 files changed, 14 insertions(+), 4 deletions(-)
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index c25cccc09b65..2bc3ae21a9d0 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -1052,6 +1052,9 @@ static resched_t resched_opt_translate(struct task_struct *curr,
>>   	if (preempt_model_preemptible())
>>   		return RESCHED_NOW;
>>   +	if (preempt_model_voluntary() && opt == RESCHED_PRIORITY)
>> +		return RESCHED_NOW;
>> +
>>   	if (is_idle_task(curr))
>>   		return RESCHED_NOW;
>>   @@ -2289,7 +2292,7 @@ void wakeup_preempt(struct rq *rq, struct task_struct
>> *p, int flags)
>>   	if (p->sched_class == rq->curr->sched_class)
>>   		rq->curr->sched_class->wakeup_preempt(rq, p, flags);
>>   	else if (sched_class_above(p->sched_class, rq->curr->sched_class))
>> -		resched_curr(rq);
>> +		resched_curr_priority(rq);
>>
> Besides the conditions about higher class, can we do resched_curr_priority() in the same class?
> For example, in fair class, we can do it when SCHED_NORMAL vs SCHED_IDLE.

So, I agree about the specific case of SCHED_NORMAL vs SCHED_IDLE.
(And, that case is already handled by resched_opt_translate() explicitly
promoting idle tasks to TIF_NEED_RESCHED.)

But, on the general question of doing resched_curr_priority() in the
same class: I did consider it. But, it seemed to me that we want to
keep run to completion semantics for lazy scheduling, and so not
enforcing priority in a scheduling class was a good line.

(Note that resched_curr_priority(), at least as it stands, is going away
for v3. I'll be folding lazy scheduling as a single model under
PREEMPT_DYNAMIC. So, no separate lazy=none, lazy=voluntary.)

Thanks

--
ankur

