Return-Path: <linux-kernel+bounces-238896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F89C9252F7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 07:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35CE4287C77
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 05:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3074963C;
	Wed,  3 Jul 2024 05:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="B2tUOHRb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="g7FV9Ie8"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF001311AC
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 05:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719984466; cv=fail; b=ZSR5B4YDIyu+GFJBGvITlJRTn8zs2xnN+5KsRlviLosah3EPbIaq5sGy7gZZ9KIGh1PPGpr4RoIGHg2NAY6gLTZCn0cQBu37q8inku2PtItU8YLiv16cqNKp5LPtxwFwBZ5933ONPvncjJxTyfq6imCDxl72cAj4If/tqNJLAuE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719984466; c=relaxed/simple;
	bh=8g4gQkTM0hbUtChUJTpaGFbWIqcAYQ+6X9iMR8FxmW8=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=bJ3/FjnecmqipMMzqzZ/JfYlc52swRtNvoces+PuFvwdM9/BLEgYrkdSLiUIvLkE0kofYwEz38RIvdmCU+7cIg5Oh7tT/Z+a6dGe/V8BIxIBXtXTEnWStykouWGSmqbi3JZu3znG0IkKfC7kIAosKnTQSGMK0tVWVl27IOZOJxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=B2tUOHRb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=g7FV9Ie8; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4634tT6l002260;
	Wed, 3 Jul 2024 05:27:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	references:from:to:cc:subject:in-reply-to:date:message-id
	:content-type:mime-version; s=corp-2023-11-20; bh=Kej9FzetMQ/1cA
	uFV4OY0HbpqLARtgomPDaHV3Ux+Qw=; b=B2tUOHRbab9mqq5nvCUB5RzdsPqHmF
	3UdzgFbhEfk19wbeJSVGrbbxKId6k11SOmAyrzursUI6bsvJXsSsAca2HJ+kgVYZ
	1DUUVrnb0N9xlsnP8op5FR/UKF5MquCwZsk+BHa7kUyJWAU6lGbh6ww1h7HfHMp0
	cJYyD5oG5OCDS379hNJ8DSXAra+oCeFfdzuqjgdgR0Sm7pHc0sqWbzgEBPMldpiZ
	POqxqbiTsqmVnGmmDdy/EerofAnHD988K4p9W+RjOx2XKNDDZIglC/7mvrVkLnac
	/sUff8ue0onNjB7XYSS/BambyjqKOvY5YD45HoQre5NcElKXI81dBOAw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 402attfbmh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Jul 2024 05:27:14 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4634PWi6023511;
	Wed, 3 Jul 2024 05:27:13 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 404n0ynkfw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Jul 2024 05:27:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gVkC9bV1JTiCcIfwLSSu8vnMQBoIVMDhRD283GUUK2MkY8RFqca6iCH+ik0p6//zkFj8IZ5aRbl7iX3AkQODuO1swYt/6oiNba3lGcqAfKySoPICKrR8OHWKCsLgoH3wsRYS4yBbzYsy421TBfjL9B67vknTlisCNxZSr7FbuOnohjBONryPlpx2OSGmlt/AzEiRmilosV9SuNwkvd3nB7A1dFYDE2UNI8YEt9JQZCUf8b685vhz3Rg8J453FL4aRa11nGhJ6K6Pg0HaCdG42DfM3HT2u+J2nXnAesIvlCuFrFqurqKjxp3tMbH6KvL66vmbMm+Nx1SqY+mP7M/clQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kej9FzetMQ/1cAuFV4OY0HbpqLARtgomPDaHV3Ux+Qw=;
 b=NGdMUb4sMLFa6Gb16Yn97HKVNvygtH/2hkVRqV1L09gJpVs0lDFcIYjmvhvPnfjQzsqNyTihx8FtqW6JxC2AFTTVM/NJ7D3iYtk3c5qSmqUIzIDSeJkb8+Garp/Wtfoq7i0nW7w7/QlJevM6O9SDQVyqgrUtALjzjsTq1wfhPRVehvWLYsg2vgzdybMM23KCLa7XMJFhGckIr/AEm4It7P1lu7SMqUVXKI7RMWAW5W1JSnkhNDuC30D78gcHtUaLrzzmjzRtbXD7fktlE+iOQeJvGJBHTLA2BD0e4DnRqnIy5PFGFhlMdermji3bNiQTbW72NxMPqMsMKFCt4VkMQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kej9FzetMQ/1cAuFV4OY0HbpqLARtgomPDaHV3Ux+Qw=;
 b=g7FV9Ie8H3ek58OxOXwrkZdDHIV9viLAMdJM6c4wMn32BBw6mldU0D1nqG4Du5MAEqPf/SsbDMRuaCjfLEJW5Z2KHpLy5Bwd2la1IRIEQpnJLHikVRhWnjrum2GcnqYMbv+3fH3ybaXro0ZQPMveBdgSrni+wWPgEhHc1LQnLRA=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DS7PR10MB5152.namprd10.prod.outlook.com (2603:10b6:5:3a9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.23; Wed, 3 Jul
 2024 05:27:10 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%3]) with mapi id 15.20.7741.017; Wed, 3 Jul 2024
 05:27:10 +0000
References: <20240528003521.979836-1-ankur.a.arora@oracle.com>
 <2d6ef6d8-6aef-4703-a9c7-90501537cdc5@linux.ibm.com>
 <8734pw51he.fsf@oracle.com>
 <71efae1a-6a27-4e1f-adac-19c1b18e0f0c@linux.ibm.com>
 <bbeca067-ae70-43ff-afab-6d06648c5481@linux.ibm.com>
 <87zfrts1l1.fsf@oracle.com>
 <17555273-a361-48b8-8543-9f63c2b8856b@linux.ibm.com>
 <e7e2126f-40ca-44af-9287-888f4ec34b35@linux.ibm.com>
 <871q4td59k.fsf@oracle.com>
 <14d4584d-a087-4674-9e2b-810e96078b3a@linux.ibm.com>
 <87msn785f0.fsf@oracle.com> <87sewzkjy5.fsf@mail.lhotse>
 <e8efdade-161e-4efe-8bd3-abb12ad45dee@linux.ibm.com>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
        Ankur Arora
 <ankur.a.arora@oracle.com>, tglx@linutronix.de,
        peterz@infradead.org, torvalds@linux-foundation.org,
        paulmck@kernel.org, rostedt@goodmis.org, mark.rutland@arm.com,
        juri.lelli@redhat.com, joel@joelfernandes.org, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        LKML <linux-kernel@vger.kernel.org>,
        Nicholas
 Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 00/35] PREEMPT_AUTO: support lazy rescheduling
In-reply-to: <e8efdade-161e-4efe-8bd3-abb12ad45dee@linux.ibm.com>
Date: Tue, 02 Jul 2024 22:27:07 -0700
Message-ID: <87sewr6o5w.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0325.namprd03.prod.outlook.com
 (2603:10b6:303:dd::30) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DS7PR10MB5152:EE_
X-MS-Office365-Filtering-Correlation-Id: d11ce38a-969e-4804-4d93-08dc9b20c98c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?BsQP1TGoy/vGgZoa6atNALWPaveVvlS7ZMfxuRLm2VhfAwuLRpz0tB47Ihjm?=
 =?us-ascii?Q?eD4Hdszz4H2+Vp9q13i9qb+oxHqqn9DBwSVc1SOWDoK5trY13oY+ILUwSY4k?=
 =?us-ascii?Q?KqzGurJSC3Gv2y+ef2VEuKQHSLiXv9I9hXLeNyMz1AVbTd2SKLzenPiXwkbD?=
 =?us-ascii?Q?qhuRTNoVvU1004+405aSCr5XYNG3eT09k9j+pnDfjoyrB8ZtaK1pDEU+Lnq6?=
 =?us-ascii?Q?58r61mDtS+1l3xG4X0kV6CY6fTT75qrBWBfkSXKDGNRRafQ+cs5kgyKUuvQ2?=
 =?us-ascii?Q?uPKm92owbiT5DrjlzvHzwCKdY3VI7WusCEzf0CWhAmWS7hqE3BUIeHkdQEiP?=
 =?us-ascii?Q?y0/JHZwZVZZsUrD9lLuz1m0tBz0UvBTGGnKIlu6cb47rr5nYXynb2T/D9+wM?=
 =?us-ascii?Q?0USLC7cE3jcpf922pjSBNtVp9LciZfbH2X4B3v3uUPyfTwR5pBHfy4uPYfMO?=
 =?us-ascii?Q?eQauTYezszP0mF3uuXraspqDhi7lqbnv2A3vKbC6VJF7cL8qbQgtO5NsyWLM?=
 =?us-ascii?Q?QxHlngfJ3U4IwUSb4xf6sRq4584I43Nc01ZuKEwm+OpF3vs1UvjXx28QJ3he?=
 =?us-ascii?Q?Vv4wONFbccEm9Wmvx2drk/lXgXQvgwsplzUOkPRo8lirUhgSKZMwvU9gehkV?=
 =?us-ascii?Q?rzgLk4vGNLsJ1rTD1a+C02Q97eXkSriVxxfwSOrGNgcCedZfDUGSzUOA+vOX?=
 =?us-ascii?Q?clo3BKj1k3CEhTIub5O1lUTqSfCaQ8isJNzxHwA05AfMJl7GAQWE0VxcDdin?=
 =?us-ascii?Q?zbeeZbpplaGIY/GmmDV/kHaoZgWU7YfLJgyDrbNvKcACM2Q80HNsLD8FPlju?=
 =?us-ascii?Q?zPkSvlW9S9tfnE+GWE69f2tHkDcPD+r2+qT5vzany8RyZa0unIXfguso34Pk?=
 =?us-ascii?Q?3nTGjktUY/fQj3EQrYwpHEz+AB/Fs+YVpdB2j1i1lNLGUZXwel7EgwrBJP+o?=
 =?us-ascii?Q?+h7r3KY8LOwOKgaEVDdTcl6gOOvTHtNDAwsBX+pmr0jhUsDh8hePplKJldQp?=
 =?us-ascii?Q?xaNP4VEjWlPS1GbS7MLzaNEXUmG1Y8hvSKl6n/Drqt3/lZyTEVKT9El6KWvj?=
 =?us-ascii?Q?9kzv66CcP4xzfw7ndznK+x/NU9IqR+x5fo9h1nmmbH/AIt8W22hACIaYpbn5?=
 =?us-ascii?Q?DxVH/GIDOuikMz/Uig4yIzXPfvBLFejZ3Xd4ErB2NhwpLg536t7jnqnyyj7s?=
 =?us-ascii?Q?Agu5urbJKDqCbcaxVftEWfRzMcd5mhRXhnz/sRFDAmlkwk7mSe5o+l+Ki7fb?=
 =?us-ascii?Q?wxm+qoordN4uC+eUDafTWBwc2Lk/2bCmOvjHXj1mrhMzyMoO0YyqEVU9beYM?=
 =?us-ascii?Q?z2KjPjsCITx9BWHvvnSXy4cTNwmFmKXm4kfkKSYe0zyU1A=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?wNDLWraSNf6swsHk7thUlPZjxZ1U6M+rlT9sfa+oKQtiy0osthh8M/Y/7ztY?=
 =?us-ascii?Q?B0Ktzp50c87pOzw15jhNQDj7Sx6e5WqpDxPOtFkdgUgoIETuplWnA1mRilaW?=
 =?us-ascii?Q?bgDD/sHZEw9DsKjMwsbPtgyKRzOu6WNNC0feHTscRTB13/ebhswBhyjwMnLG?=
 =?us-ascii?Q?0tEYqdyvtbWZZEEmwn9lghmXUqKzMlI4y1yFD569dJP0QZ12wwYvxQgJ7ZOY?=
 =?us-ascii?Q?/VuVOJRLMmEKI1HYDUSdNhGriA0GTkwlqilMaGr+k2donerUbahjrR4TTcPS?=
 =?us-ascii?Q?uZnMwvJVViFxB9u1Q8m9cnmYNU4IWDGHvivge4a1cbBLf35KaZK3+O9Svids?=
 =?us-ascii?Q?RIGYpvc3gKHqto+wlNjqn+HmAysAij3AiixqKaYGljomquoUQdg1CohMx3Ej?=
 =?us-ascii?Q?/smM8bmwV1wMuTnlFpDjYvgKjoA9el42zRiGeDdb6IYqOdy7c0CrFY30oleG?=
 =?us-ascii?Q?F3wPY5GCA0JKIP4eIIgQ+UAQC/UYiTklbXMB8zGtHno2BPY69vZOLFGXBWbN?=
 =?us-ascii?Q?tyekclxAmwgY3gJjTo0GdrSJaZpLFQEb38pMuMwDcDXGg6YPWHae7DKaJ36J?=
 =?us-ascii?Q?Eu2ToPLjOWJobkUo7EWiPaRuTPYikWYkUhnOfA+Y/dKfPqY3wZAr8H4niKHE?=
 =?us-ascii?Q?KrtC/n7WtwDxjW7hODaDGyCUuJ4FGLsZZl9xy1qmJPHxukmKBhBISBKX1Jy6?=
 =?us-ascii?Q?IvTghNV+j5LBxOc2dLQpERQXhs+AYsa4RrwACRsk8qocfHeqSNVYKi+2vszZ?=
 =?us-ascii?Q?OzJ8xZfDGX6zF/Fdt1wdGNCc6t3sCClhSWke0EXioXajmVzwUO9AsXeUpmd2?=
 =?us-ascii?Q?lToXSm4JIiewjBD01OOQ6NjRx7r7KBn2ACGbyr6u+/xxktfelWgHTohDB7Qz?=
 =?us-ascii?Q?MhnoTyoLLyrR5jKBLsuAwVwmd6il9d0nJx1kOv7shLOYwoZEsKqdBRtxI3TC?=
 =?us-ascii?Q?C7tEZMAAgpBGc7Q2mMLvlB6DQmBrs79RTAOjugoiqcP1x3Ckg9jfGoUag0u5?=
 =?us-ascii?Q?LctcTsRMFIfkL1CuRogZzplVTDtwO7d7zxe44b8aUafHCZ81UUDXLFfjQR3G?=
 =?us-ascii?Q?Wgmu2uVNQ8YXuMk8DJnXozj3kmn1nQO899XqPnLYCp4/NbViP0gccK/8Qs+T?=
 =?us-ascii?Q?IUtIb3CByIQyCu8ZdJatqcvzED232+uMEmE2MlE6HEg+QeOi7COfHelDCuDS?=
 =?us-ascii?Q?YgXjeZLOhMxjz2mpDpQ7UfZLVtOwyG6+8Hqg946CvpyBvT1m0XlX4ErtnuYU?=
 =?us-ascii?Q?ao3mQg4GhU5ViKYPROvhUG1m48Uqk8Z1fU291k/K9CmCRj8Aw4RianEwlccf?=
 =?us-ascii?Q?v0qQksMu2I3W3WOOKF9UFY/PPloFG5X5Y8zx4xL3/XbkVFFpfhX4zhU8nJOe?=
 =?us-ascii?Q?xWs6vnxICrNNDmo4sDSipz1AKV6tUwHpu7cxL2lBwEhxPXYMeFtNH/MkxJ5y?=
 =?us-ascii?Q?TFz2J9fNfokWgSq5K/7ZhbxeD9oCXrUZTofamFXQDotZbFpgP47c4eNJQjfw?=
 =?us-ascii?Q?fgxJWwuiLlKkHGXmXwSl61UbXFQD0aTaSwbGhOmC6R0YETvDtB0eHwlfwjj3?=
 =?us-ascii?Q?gZCxqE0j1+dFEghHeHPnDrKYWWj+fimD6AOiV4VN?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	JrLPVBaudA+VJSgWKdX9qFqik18JOSJtHCpgx7C4qVf2eUIP/wTIEyB3hCzqpnzqjHAV5h7GAq/jpaJHcCUGxj7M/FNeAwTdv1257YJC6ahrFGsRL+tFenhT2fVe7DNGS+qnEP2NN9AYUXgdm+P695mJyKEC0yZTd2gqz0pOw1Lk0T2Zg4r2STte9rZ5leEe0mfiryVyD/fu+ay1M4tnXo9Sz9tTBLl/340DW5qcnAlKQ4ABwDzghLYW+zCT5RU4/izxx1EaUgc/m00sf41SJl28YKnGaLUawwqNErGtA5bh1zNNwULSuJiyIug0ZsvgmiIVDyStjdfSGC4TFfpvy7rTe/57B8cB5u4MBtpFJzAFed8CmB0Ic/RK1N2q6+V7SZSaLhKsgswud50X3lPhV+ZuBdyxmebEyQgru37yGputfWJOgBDCpUWjvOXoPoDpoCDMBDObv/vQQ3ST9nqXwpl6aYERR7Ia3L8ihyc5/ZKuOSWi5VsEJlJPurje/v0MI0jr/BUJcVnK4eILKOQ3//kh0j+lXhtsqtxGc87fywOklZIOJCk0dF4F9BoPdpWbAAbMKy9Uy5Cr2iWm3fcD8+C5A42PFGsaM7r0YDvAT6s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d11ce38a-969e-4804-4d93-08dc9b20c98c
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 05:27:10.4307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ucjTvpNM1zCS+dCx8I0q3wE/SA8E9LK28PdN4DQoJSeRVdDlVQMrZg6jnnCRq2KIWvCSBk3moZ1zM7aBRCbJkEIZio14H8F9BakQXt44Gug=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5152
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-03_02,2024-07-02_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407030038
X-Proofpoint-GUID: -pwWNqgit5yns5RFzhbhU8fIpC1VLlU8
X-Proofpoint-ORIG-GUID: -pwWNqgit5yns5RFzhbhU8fIpC1VLlU8


Shrikanth Hegde <sshegde@linux.ibm.com> writes:

> On 6/27/24 11:26 AM, Michael Ellerman wrote:
>> Ankur Arora <ankur.a.arora@oracle.com> writes:
>>> Shrikanth Hegde <sshegde@linux.ibm.com> writes:
>>>> ...
>>>> This was the patch which I tried to make it per cpu for powerpc: It boots and runs workload.
>>>> Implemented a simpler one instead of folding need resched into preempt count. By hacky way avoided
>>>> tif_need_resched calls as didnt affect the throughput. Hence kept it simple. Below is the patch
>>>> for reference. It didn't help fix the regression unless I implemented it wrongly.
>>>>
>>>> diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
>>>> index 1d58da946739..374642288061 100644
>>>> --- a/arch/powerpc/include/asm/paca.h
>>>> +++ b/arch/powerpc/include/asm/paca.h
>>>> @@ -268,6 +268,7 @@ struct paca_struct {
>>>>  	u16 slb_save_cache_ptr;
>>>>  #endif
>>>>  #endif /* CONFIG_PPC_BOOK3S_64 */
>>>> +	int preempt_count;
>>>
>>> I don't know powerpc at all. But, would this cacheline be hotter
>>> than current_thread_info()::preempt_count?
>>>
>>>>  #ifdef CONFIG_STACKPROTECTOR
>>>>  	unsigned long canary;
>>>>  #endif
>>
>> Assuming stack protector is enabled (it is in defconfig), that cache
>> line should quite be hot, because the canary is loaded as part of the
>> epilogue of many functions.
>
> Thanks Michael for taking a look at it.
>
> Yes. CONFIG_STACKPROTECTOR=y
> which cacheline is a question still if we are going to pursue this.
>> Putting preempt_count in the paca also means it's a single load/store to
>> access the value, just paca (in r13) + static offset. With the
>> preempt_count in thread_info it's two loads, one to load current from
>> the paca and then another to get the preempt_count.
>>
>> It could be worthwhile to move preempt_count into the paca, but I'm not
>> convinced preempt_count is accessed enough for it to be a major
>> performance issue.

Yeah, that makes sense. I'm working on making the x86 preempt_count
and related code similar to powerpc. Let's see how that does on x86.

> With PREEMPT_COUNT enabled, this would mean for every preempt_enable/disable.
> That means for every spin lock/unlock, get/set cpu etc. Those might be
> quite frequent. no? But w.r.t to preempt auto it didn't change the performance per se.

Yeah and you had mentioned that folding the NR bit (or not) doesn't
seem to matter either. Hackbench does a lot of remote wakeups, which
should mean that the target's thread_info::flags cacheline would be
bouncing around, so I would have imagined that that would be noticeable.

--
ankur

