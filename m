Return-Path: <linux-kernel+bounces-354507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19CD9993E6E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 07:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E41A1C226C5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 05:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D4C612C484;
	Tue,  8 Oct 2024 05:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IeeJ/J9g";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aXRr+J6F"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5553341A80
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 05:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728366292; cv=fail; b=bxyBLfdGL2yoj8EwZw68L1+hC/dQEibyOSPV5vmi/VR0yGul6ewC7eC2/GBzsU5AFU6YNDRjq6vKIHvFV/jat8yIJ6gqGpCPfg9tV+IJoYWXPy+cyhAijvArbWLW/53XO5jFjUpmUPVXeLWrG39Xv3F6HVB5eBRTZHIw2TzMLfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728366292; c=relaxed/simple;
	bh=0mbxD6N5hOLQBXj13/B9zlM1mHkrVkQYhnc4bI/c+rU=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=n0fqO8M/7cYHH2VAQpeTLm1tpH9JDQIOwQx7+qQKoK29X1hUg6fsccmhVrbgq0DArYeYTK+QlEshaJ7T00bzXiOUPm4uCpefpjy7GcmPFTM2vZTejlZsyUSMpfej2ve8kzfkJtChpB4i90/cqAsSAOosPoPSOSNl8S4yh2Jwwfw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IeeJ/J9g; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aXRr+J6F; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4981MeQL010406;
	Tue, 8 Oct 2024 05:44:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=SOcuUyh1M2JjgesU+f
	Pd6vSQA5zGOJZ8K3pOPKFKEXY=; b=IeeJ/J9g3tkx9QQFbjqS8b12qcL/3k9dcS
	lVqQP4ySKwBhILM15E6mTnsBZvZ4pzsVv8RZnfNyfKbpy8KtHJP6K+F6/vKbPE++
	pjpIj3RsDqChH8GSGtktJ+PtqEleUWlM3AGl7UOhOeIi58htGh5/arUD3w0ASGah
	lblZG4kJUJlhWizpCgwovHjv0GL+mQjpWKmDm/NsvU09NGnZW55c8bg6qQx9hSsl
	y2sXi7CTLxTghdahTZMav4HAT95DU59B+riKqFALjaTwlXGgMvDynT8ao6nACNdK
	aa9oxLpFKHsi1vekCtdieT62IbkcgW9cdgAwT8cJltc15nvlTnZA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42302pcufp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Oct 2024 05:44:07 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4985JRL5024101;
	Tue, 8 Oct 2024 05:44:05 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 422uwd063w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Oct 2024 05:44:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F0G1/llAGPcIIBnKpHeP0uNPsrUEHkKKo0sqrmoIVAf6X3Hp0HpE1g4ElpV8QqlL0CrdabaQgNireZOMspLVGCTE1Bs0Vu2koROtuIrseL2rubmWXpFperX9DvqO5DM9UUpf3yu5RXycNcRDfjb1Stn9zkb04n9sN4hrVxhejb0YslqP+1lPQOnvDxEJH9hFlefSlJbvZuvXIb5gsMiUnI+HBbc9m7PAPCHUl3ROCLEpf0VKEdKenS99bDNDRiVeyvMBp/j3hmEqvqwI+Mv7Srq2AnJY2L6ECZXTqCp3wA66Ov2d4WIcnZt84m5Gmq4TfGdious1ChyC9w8igoSGdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SOcuUyh1M2JjgesU+fPd6vSQA5zGOJZ8K3pOPKFKEXY=;
 b=wq1gx67jb7SPVK5ydxlusjXGyliKTDgjkN8w45GGCgNaL8W6TSPylGQ/ZlKcCnLbftm0xZKnHbr65IFV7TEPYj1upb3HUjgpAzG0kAUD2WyAvrtNw9jZBxB9ZTiBzy2OV9uKFQNiJqIfOClPqAidMF0ZXLUZKQL2Nta3lZPgwHMrYIh3OU9UcJdyFvNTs6Bvu/L2Rk00kxO9d/fIfeXAnJ+hNboGB9UTlAQeIYDUfJ6DAEdbSjilmIpjt2cdD+/bd9YqvVAv+PuA2cqrEVAdEmcDF6KUz75SUpn3asUIIFIpl+87mxr79Oim0AiWq4LD3exzinXCYa0op4XRubTqog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SOcuUyh1M2JjgesU+fPd6vSQA5zGOJZ8K3pOPKFKEXY=;
 b=aXRr+J6F3EZ5EFv4c6G/0EMdFIvmGkFcWbZorsOdxYTv69pRt2uBaN7I8phANYuvLzynXo+PvKVOaTWCN/+RMdtaIUefmTtnyTJtt5iN8HDS5Gpo9n9sGjca96nkNVEsTVhRbTafeMNTEMMhFJCvJLXECT2vjncmy5TKS8op7ik=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CYYPR10MB7572.namprd10.prod.outlook.com (2603:10b6:930:b8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 05:44:03 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%4]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 05:44:02 +0000
References: <20241007074609.447006177@infradead.org>
 <20241007075055.331243614@infradead.org>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: bigeasy@linutronix.de, tglx@linutronix.de, mingo@kernel.org,
        linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, ankur.a.arora@oracle.com, efault@gmx.de
Subject: Re: [PATCH 2/5] sched: Add Lazy preemption model
In-reply-to: <20241007075055.331243614@infradead.org>
Date: Mon, 07 Oct 2024 22:43:58 -0700
Message-ID: <877cajdu8x.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0320.namprd03.prod.outlook.com
 (2603:10b6:303:dd::25) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CYYPR10MB7572:EE_
X-MS-Office365-Filtering-Correlation-Id: 5118d14a-ad6d-451d-b967-08dce75c36e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oKd7hpKr682OwRnmpOHMPGSoGWCnO3Ox8kRFywxDE2HPm+e5V1H8yhWgrpM1?=
 =?us-ascii?Q?5PaddRP7z4dsVSMT3RUpZzYefXMPb7YWqNxOkE1SD49poP+G6P/X+QtjD8YM?=
 =?us-ascii?Q?hnJOcK0nWfjDkkJb8hU/zbOQ+rPBpa7N+7KJei21wy4OlwQUEgN64Q+sedIZ?=
 =?us-ascii?Q?8FvcR0yMJ4Dv5JngzeZaUUgmc/VJ4kbTVAGZN/zdTMVUtalw0llP0tNw7pse?=
 =?us-ascii?Q?YA9t5pRXP1+Fv+dhfP9TrLZ38RJfQtTGYxSW4dd4BFKcy+K7A2/FuZKx2uNq?=
 =?us-ascii?Q?BDGisnAzTqBg6gR3J8TIQ/NzvwAvMtrYEXe8xiUYLnWAKlMJg571xMExYSPK?=
 =?us-ascii?Q?MpxF+tG1iji4n3Pu9K/D5m6V0Qs3+Wckk5leGpTN7vROa+Lvhi+7+4+lpNME?=
 =?us-ascii?Q?hlxco+vBt6JuOyGrA4cVrxgyjF+R+olmYd1j/9A/iEtChuCy/fISibIeERhX?=
 =?us-ascii?Q?wx3mi7hQFzo+5N0G2T7ws1ywnYGWhS5c1+BoR7b8ELXFn1OeSe3nrDLUuwfw?=
 =?us-ascii?Q?ZJE97hmuZ0Yeuc6ef9Ob1fvZngHN++9b/eOHWnU5/aCoCp+6Wm3urXosHQ/N?=
 =?us-ascii?Q?gjBYQM5v/1q+cLwQvw2vxg0oh3RtcCP1xgrIS6ZDQD98kiZKVy11fT2hth+N?=
 =?us-ascii?Q?v+YKbsZbOjZiWxYLVuuNrJuxJvxE7DFRQTb6Ilhwxe1CdIKiEo7n0SiKLR7V?=
 =?us-ascii?Q?yGyPzbfC1a9RlW+5Mo1ZuHyFBEM0A8D8z52BKT9u/7LPYKQlMpl0jnoEftmI?=
 =?us-ascii?Q?4n9Qgu8SlaeXa9+t50oK8FDIfXTgjhDjF+IibsPA8jzzmMKhboqbVwGtOV5x?=
 =?us-ascii?Q?DB67CmsKP/a14CCVhQUXDcrJl3Q7OzAuexDe47YVv1nMHSMkPcJwDGOjL5xt?=
 =?us-ascii?Q?4yRYSoER+68mATrJTSyfoDv6cFb3yG33fDQeqvn++WrEFSRY7Ox66VrjLTYz?=
 =?us-ascii?Q?M+ApPuU7OrbW4lzebAYc6IkACR8CTRZR8oL88kCoP3gPgIa4t30BJoBK4uAH?=
 =?us-ascii?Q?GB9G8XWnudoAwb2/1dWU8kAHHhY32GXj3qbkxbOEGhFkHhHdeh/drQLkgyTO?=
 =?us-ascii?Q?iB5uaTOkvcYihsuqskkxXMw2P0zaWfS5mVwkTzI+2+aGBf2e2wcB/J1QjbXU?=
 =?us-ascii?Q?d94rDcU1FN2wNIOFa31zBMPGxanacEUUcCV6tuhGmHy8NYlUaZbfSDJ/XBc9?=
 =?us-ascii?Q?iWTu7Lj5IHZ1x6OQB4GEmPyNegGQQMc8J3erM14vScQv2LcYY761onG6cAmm?=
 =?us-ascii?Q?qoxz8qyrYTpmB1DU4G0z80Qnt2bor/LHbSs33qghvw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iIY6vmYjS85/GuAtWkYggQ1IZlBTg5iiv3lKRkFPjmgg7xPxkiIvx+6BwzeL?=
 =?us-ascii?Q?F4CTNOWVDDn1vdsBT6ihqdB8xQ5Wv5Mw4mCdrdKDcuWqwNNMnfZIcCTIQbMi?=
 =?us-ascii?Q?87A7M5AgsdJDL7o6hX7k/pWldVQIPrfiFLcel6UukRjduzT0DWQNIK8BvdJH?=
 =?us-ascii?Q?I3SaJ4WnlHWrbkuF2ZJeWERdCEUuSbXoIvuUuNX1RV2PMCrXN6i8XsXgsKid?=
 =?us-ascii?Q?NWaVvelxzicbtgc9590wGeUsb5bwZ2z6kAXGo5xaJnWAa1ztK5CoAt7ZVlHf?=
 =?us-ascii?Q?Q724d/VdfUyuXmrfu04S/bnsBzHQJB9cxHPasYP3baTDmPxc0myamCWAF6mg?=
 =?us-ascii?Q?w9sm5jv+ouO+uwMukl8GmF2JpuuqdjAvuATt3NqIXLxfBQs7NCk0cwvChMtt?=
 =?us-ascii?Q?EXSi+TWPpu6JTXczTrxneD7m9ZRcju+5kdLbgnMRJDO522J2MARbg0ee9cpN?=
 =?us-ascii?Q?bJhoGqInbB4KxMg7E2CktP1xv1s4ua67pbEV1VnVfhVsXBNx2uisqXJzrg//?=
 =?us-ascii?Q?Jn7ClqMW0kZJtSLb2WXnlWd2MFbp37/TeotXOTVVHvh1DMhGF57sSODiJgeG?=
 =?us-ascii?Q?NjtlOWdw22RznFw+0ZJcQIxGFxRi3kcHFAtsgqd6Otgxsv1Oqq21uFp2NN1v?=
 =?us-ascii?Q?2V2keU38CiZUt7UehsFOzBsY+y5C7Ep8gwQ987N53DjZxh2KBtd4Qgy6Q0pp?=
 =?us-ascii?Q?/hv3r4nh/uoLsG+6UjSYiQEIZSrYp8HAOvYQeV51UppfHTd6G9WaLHGneDMf?=
 =?us-ascii?Q?R3/fLjTn2KpXMnv7O7nuqjwGiAGRL+zdFIa6UUJ3MzbWN1XkrsEpHIXwe3Uj?=
 =?us-ascii?Q?3fxqDRm2QCBg57Fen733QBczZmNixDnkhhJZorZWvIIPsJFs9URIM2/LWQd/?=
 =?us-ascii?Q?pzRZeMysn1xl6xjl+0HIepmyaOr75E9O27744cBBjI2R1Sv7iSOufwybCYzX?=
 =?us-ascii?Q?xmQ3N+E3cC6XbwAI7eXrE7qVdHZU/2K9LU/j+wSY6fHjaPXSjZyTaP2VIInW?=
 =?us-ascii?Q?ztcxYZnBVYKoZcQdsQJIcPtY4SMedg7lCtxUG5ofenDUSkbauEx6zZFXA5LT?=
 =?us-ascii?Q?tXKbhy4jPRGlzi74XZEXidAYjYNdxeLMxaVx8kytpcjV7LkXImpqIvoAmdLx?=
 =?us-ascii?Q?kiYtKMApsdpblZR9MPItThJ1oL18cSX8388nkvTYtc5WVrGQ4n2D7PF5VI9X?=
 =?us-ascii?Q?iHJVOpMXRyKSCbDBvxFyNVtJD4DweC9NMX4tqbevgcCOMR2/0WEMModzWxFi?=
 =?us-ascii?Q?rYR09QkrdlNKFqFwLqd3MJ9m9PKdp2EkAyQsfa2rsw5dTJwLpb6BVSJTEyyO?=
 =?us-ascii?Q?T7gjbBTydHsGwZltUXTqQndW1SwO0MEw2UYRr75xXzubuY8bGGDVp9CCaK56?=
 =?us-ascii?Q?ct/tQKu/6RCI2GtCz2pyM/CZ9S8l4Lx0QkMraGswpAJUllRnBkbu56XdhFj+?=
 =?us-ascii?Q?dc4LxhPOay3CB6+QKK89Ya670QRcvNjxnP6ZL44n4JM6SWkYfY3P8m8XwGpY?=
 =?us-ascii?Q?Rc6LLEfXRCasx6mEOI7HPmTczG3XbywB0sK9YJciJGjwKkrlBhJrmugrWujy?=
 =?us-ascii?Q?j7h6G+rByeE+mUO4AY5rJOAv4TZN2axvrhD5eEhT?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Z0xnXSJEwXuTOg2HivZvLiVWNQuaMvm8bMRS+Im5bPHWGZ6QrrjV+vrz97UpXowgln5VzIjeWHgU+mK08O/N2s4rXQ5bvDHfLLxidFXiAMc+O/2TJ7Oxb6sxdPw3z9N96HV1hp16VH62ZEaodt7mvKGb8FDUktOAyO/x5dBqjAY+/9Ax/mFr9AQ4f8mHL2PQLj0+AC0wSFCq7liV+c6wQBNjT4OmnoaCyt+g7aj9Lk6mNJ84Jlq47Dpox9BLm8j2OhGIMAUpLa18ZhyyGjQ6LO06qJEJzqloQ5jeBqNxwfd4Z0qJeG1Et5VlRvKBlQoHx5z5ONG8Kpzx1kL/tKo/nqirp3gDFEGTnTl+y7VYSUyReBaexlmVMeD77LMwAEcY+HUE6CjTkpsoxkwu/A6pyz6CygoQUe+GTfcnM8/IqDfFPiDxnzoAN3jcbgObUC5gr8BjU3fMMvuw7RNjltvKdI0DkwpmNhmcWtNZOLZkLASz74rxgaFjc5a/VCfnzNVuRoBTGDmx7zrWufGvwGrNOE0L4nH6xsOTJcOZdIyHojoixULRiSRW2KqmqDNIrswz2rkFFoXOd+NXCjNuY4ZPi0JVom03kC+FrfoLJCwYFw4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5118d14a-ad6d-451d-b967-08dce75c36e9
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 05:44:02.7836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6e7kV86xzkH4AP3cxmeakLj3RsLTLiUH+/zv85uJif5WCdwjPqSFlnxqixNoTXWniK6v+PGsmVfYXdIds7/xhBpAmN57Vk4Bu3YJ96jVc5s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7572
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-08_04,2024-10-07_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=809
 spamscore=0 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410080033
X-Proofpoint-ORIG-GUID: bReG2qey9jfXH_x5kktTLFJ0jnrxXKhG
X-Proofpoint-GUID: bReG2qey9jfXH_x5kktTLFJ0jnrxXKhG


Peter Zijlstra <peterz@infradead.org> writes:

> Change fair to use resched_curr_lazy(), which, when the lazy
> preemption model is selected, will set TIF_NEED_RESCHED_LAZY.
>
> This LAZY bit will be promoted to the full NEED_RESCHED bit on tick.
> As such, the average delay between setting LAZY and actually
> rescheduling will be TICK_NSEC/2.
>
> In short, Lazy preemption will delay preemption for fair class but
> will function as Full preemption for all the other classes, most
> notably the realtime (RR/FIFO/DEADLINE) classes.
>
> The goal is to bridge the performance gap with Voluntary, such that we
> might eventually remove that option entirely.
>
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  include/linux/preempt.h |    8 ++++-
>  kernel/Kconfig.preempt  |   15 +++++++++
>  kernel/sched/core.c     |   76 ++++++++++++++++++++++++++++++++++++++++++++++--
>  kernel/sched/debug.c    |    5 +--
>  kernel/sched/fair.c     |    6 +--
>  kernel/sched/sched.h    |    1
>  6 files changed, 103 insertions(+), 8 deletions(-)
>
> --- a/include/linux/preempt.h
> +++ b/include/linux/preempt.h
> @@ -486,6 +486,7 @@ DEFINE_LOCK_GUARD_0(migrate, migrate_dis
>  extern bool preempt_model_none(void);
>  extern bool preempt_model_voluntary(void);
>  extern bool preempt_model_full(void);
> +extern bool preempt_model_lazy(void);
>
>  #else
>
> @@ -502,6 +503,11 @@ static inline bool preempt_model_full(vo
>  	return IS_ENABLED(CONFIG_PREEMPT);
>  }
>
> +static inline bool preempt_model_lazy(void)
> +{
> +	return IS_ENABLED(CONFIG_PREEMPT_LAZY);
> +}
> +
>  #endif
>
>  static inline bool preempt_model_rt(void)
> @@ -519,7 +525,7 @@ static inline bool preempt_model_rt(void
>   */
>  static inline bool preempt_model_preemptible(void)
>  {
> -	return preempt_model_full() || preempt_model_rt();
> +	return preempt_model_full() || preempt_model_lazy() || preempt_model_rt();
>  }

In addition to preempt_model_preemptible() we probably also need

  static inline bool preempt_model_minimize_latency(void)
  {
  	return preempt_model_full() || preempt_model_rt();
  }

for spin_needbreak()/rwlock_needbreak().

That would make the behaviour of spin_needbreak() under the lazy model
similar to none/voluntary.

>  #endif /* __LINUX_PREEMPT_H */
> --- a/kernel/Kconfig.preempt
> +++ b/kernel/Kconfig.preempt
> @@ -11,6 +11,9 @@ config PREEMPT_BUILD
>  	select PREEMPTION
>  	select UNINLINE_SPIN_UNLOCK if !ARCH_INLINE_SPIN_UNLOCK
>
> +config ARCH_HAS_PREEMPT_LAZY
> +	bool
> +
>  choice
>  	prompt "Preemption Model"
>  	default PREEMPT_NONE
> @@ -67,6 +70,18 @@ config PREEMPT
>  	  embedded system with latency requirements in the milliseconds
>  	  range.
>
> +config PREEMPT_LAZY
> +	bool "Scheduler controlled preemption model"
> +	depends on !ARCH_NO_PREEMPT
> +	depends on ARCH_HAS_PREEMPT_LAZY
> +	select PREEMPT_BUILD
> +	help
> +	  This option provides a scheduler driven preemption model that
> +	  is fundamentally similar to full preemption, but is less
> +	  eager to preempt SCHED_NORMAL tasks in an attempt to
> +	  reduce lock holder preemption and recover some of the performance
> +	  gains seen from using Voluntary preemption.
> +
>  config PREEMPT_RT
>  	bool "Fully Preemptible Kernel (Real-Time)"
>  	depends on EXPERT && ARCH_SUPPORTS_RT
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1078,6 +1078,9 @@ static void __resched_curr(struct rq *rq
>
>  	lockdep_assert_rq_held(rq);
>
> +	if (is_idle_task(curr) && tif == TIF_NEED_RESCHED_LAZY)
> +		tif = TIF_NEED_RESCHED;
> +

Tasks with idle policy get handled at the usual user space boundary.
Maybe a comment reflecting that?

>  	if (cti->flags & ((1 << tif) | _TIF_NEED_RESCHED))
>  		return;
>
> @@ -1103,6 +1106,32 @@ void resched_curr(struct rq *rq)
>  	__resched_curr(rq, TIF_NEED_RESCHED);
>  }
>
> +#ifdef CONFIG_PREEMPT_DYNAMIC
> +static DEFINE_STATIC_KEY_FALSE(sk_dynamic_preempt_lazy);
> +static __always_inline bool dynamic_preempt_lazy(void)
> +{
> +	return static_branch_unlikely(&sk_dynamic_preempt_lazy);
> +}
> +#else
> +static __always_inline bool dynamic_preempt_lazy(void)
> +{
> +	return IS_ENABLED(PREEMPT_LAZY);
> +}
> +#endif
> +
> +static __always_inline int tif_need_resched_lazy(void)
> +{
> +	if (dynamic_preempt_lazy())
> +		return TIF_NEED_RESCHED_LAZY;
> +
> +	return TIF_NEED_RESCHED;
> +}

Nice. This simplifies things.

> +void resched_curr_lazy(struct rq *rq)
> +{
> +	__resched_curr(rq, tif_need_resched_lazy());
> +}
> +
>  void resched_cpu(int cpu)
>  {
>  	struct rq *rq = cpu_rq(cpu);
> @@ -5598,6 +5627,10 @@ void sched_tick(void)
>  	update_rq_clock(rq);
>  	hw_pressure = arch_scale_hw_pressure(cpu_of(rq));
>  	update_hw_load_avg(rq_clock_task(rq), rq, hw_pressure);
> +
> +	if (dynamic_preempt_lazy() && tif_test_bit(TIF_NEED_RESCHED_LAZY))
> +		resched_curr(rq);
> +

So this works for SCHED_NORMAL. But, does this do the right thing for
deadline etc other scheduling classes?


--
ankur

