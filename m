Return-Path: <linux-kernel+bounces-313310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5027796A392
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 18:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3FA9286208
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 16:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857B7189526;
	Tue,  3 Sep 2024 16:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ac8PvoFB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="D8Eoc24V"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8167462
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 16:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725379435; cv=fail; b=GodPNWgoNuY+yX3YorNS4fPpeUkQT0kvWaj8M+MYBBpGJa/J26ZSMhzJsFTPCBxngfkL0rLSqZUEOCW3EFg4Ehp6cLfdgnelNWm9/fBPbIVKFZgLL4fCV5N6cg+Ii47XQR6Y7X5gnQe3npCCQWwz28FD2STtqFdWG3gclVbtlFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725379435; c=relaxed/simple;
	bh=ASCgxFz163VghpCMvuL1Bv06BGjTvqxGwZwr2Xqso1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=T0Cw65PmPQIcmMOxs0gXYA9rTEcYIEQ5M+lEZrEsNR2a/JGXlTH5BA38pbcQtFPzjDxrvzO/FIet0Xxezh1iD0MVbn2FkXy3V5x2jgvH/1pYXUNCZR/iV6V2Z5o6DVxmiLtN48Y10B21uUzxQdCwDtfrsOAa6G2Co+47NrS9ROs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ac8PvoFB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=D8Eoc24V; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 483F5Mtb009000;
	Tue, 3 Sep 2024 16:03:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=V4YR5f+AOHZKKr+
	S4GaQTfFMxFS38NC2bKLAzTW1E6U=; b=Ac8PvoFBRyEjFrlsaveQjx2a5tzkr90
	/At75szaAI1WFKDkYhUKvuinX+UHRu3PQbX/Y2LOhZWv8+gXo6i5u0t2CasJqR01
	0JAA2AcSRRaabxZGJD7/DB0238niXR/U6M4AXOXVaCwnyyMApJ3ik81svZAfJigD
	NT9MJFqFnxh7BF4ShmF5cpoVHOT/0qYKS1VMTgvyKqrJ0n/IdW2GaP0Ui24D2SRz
	lhH3gSOsBLveEGRR0pnscNhbi5hOQ5XMpG4tYGg6vDRJ9G4HvCn7/poWuPg59jKp
	PIJht8MNJ1ZAM8OyNW4fTnXVrxJ+W9cD5ZLxBfgWowlR9/+2VEVL6+Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41duw7sbd6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Sep 2024 16:03:32 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 483FlVBA023640;
	Tue, 3 Sep 2024 16:03:31 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2044.outbound.protection.outlook.com [104.47.70.44])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41bsm8dk6d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Sep 2024 16:03:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A8gGD1or4LQZIGmfKnhOV/hYFJFCk1GrlUZB3nzdLydKVUFpT+iLjr3WL1NCFOeL+/X222RX868i68pE6HSeZuVJJttS/3oFj39/fRUt+Vo6XPYFUhFfgey0H4ND7n77T9t2fYzUnrP/rKY5jwJdBdALHFVRo3KUGbGyWfdfT4InddhFpNscdIeKqiaz1CTvl5rCBLx4kwxJufu6OpfKgJrnjruEBn45ybLSqZFfQcpmvynDXK9/ubGIpMUlD6BgiZHmSnwVuQ83+DGCzGc57hOQPvGn/F7yZcGgWbb00uG8MpC2X21XObwxe8dMocksGHeC6/73P78VQh+Fkzoo5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V4YR5f+AOHZKKr+S4GaQTfFMxFS38NC2bKLAzTW1E6U=;
 b=txWO5uwIsghXs5njFWhvIksOqtxkvH4W6FIgTLlca/yKXbQpfXyMPQzp6A/lu5z0cMSA0t6T7wGEWPnNNd7PqgozdSczN9ZwFwva7ZlwWmSqKCcGZjC3nOAX0hUUNyWAHUANY0VNViKf7JONiMycs6+wknMsTl0HF9yNBLnNCpluiXmWdSmf9l8MwduQdahj4+b/lqnkD9VW0zS9rLULbWTxsLfC8OVO9CLWv3TYZ1VaRTNxsEf662B5z+LdwdUIehkZ5CizvbX+f64P4tP8qjw+w9ydk1dH8uAUNmj1HwtGgWfiVC+zyBTl5rU9abog3rnkZxZMR8DpzsXsu1IJ0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V4YR5f+AOHZKKr+S4GaQTfFMxFS38NC2bKLAzTW1E6U=;
 b=D8Eoc24V542zvvPSBe2uY2vbR7F6R1vJK4F1BrZ2xNlICjr4MufPSyfNJzpAqIaXSmCjLI4/pNlxhv3IlIw4Cg7Ym0HUKviWCS5SlQ3G9mGWDXQGHgceT270quwCvtxtFf8hYjW0UoSWa1j7IWCW/vOSKB0CvxxU72QZmzYROrI=
Received: from CYXPR10MB7924.namprd10.prod.outlook.com (2603:10b6:930:e6::10)
 by SA6PR10MB8088.namprd10.prod.outlook.com (2603:10b6:806:43f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.14; Tue, 3 Sep
 2024 16:03:28 +0000
Received: from CYXPR10MB7924.namprd10.prod.outlook.com
 ([fe80::794d:6966:dd4a:f6e5]) by CYXPR10MB7924.namprd10.prod.outlook.com
 ([fe80::794d:6966:dd4a:f6e5%4]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 16:03:28 +0000
Date: Tue, 3 Sep 2024 12:03:25 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Pengfei Xu <pengfei.xu@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        sidhartha.kumar@oracle.com, Bert Karwatzki <spasswolf@web.de>,
        Jiri Olsa <olsajiri@gmail.com>, Kees Cook <kees@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Jeff Xu <jeffxu@chromium.org>, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH v8 15/21] mm: Change failure of MAP_FIXED to restoring
 the gap on failure
Message-ID: <atepi7eatm6dkmybou7dsyxg5c7mrlpuhfom45xzug7lqoexc2@kwk2avbfa3vl>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Pengfei Xu <pengfei.xu@intel.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Suren Baghdasaryan <surenb@google.com>, Matthew Wilcox <willy@infradead.org>, 
	Vlastimil Babka <vbabka@suse.cz>, sidhartha.kumar@oracle.com, Bert Karwatzki <spasswolf@web.de>, 
	Jiri Olsa <olsajiri@gmail.com>, Kees Cook <kees@kernel.org>, 
	"Paul E . McKenney" <paulmck@kernel.org>, Jeff Xu <jeffxu@chromium.org>, syzkaller-bugs@googlegroups.com
References: <20240830040101.822209-1-Liam.Howlett@oracle.com>
 <20240830040101.822209-16-Liam.Howlett@oracle.com>
 <ZtZ9euGTU9T0PWDA@xpf.sh.intel.com>
 <a753f480-8dc6-42f7-bc6b-32f37d47d829@lucifer.local>
 <52ee7eb3-955c-4ade-b5f0-28fed8ba3d0b@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52ee7eb3-955c-4ade-b5f0-28fed8ba3d0b@lucifer.local>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0298.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10e::17) To CYXPR10MB7924.namprd10.prod.outlook.com
 (2603:10b6:930:e6::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR10MB7924:EE_|SA6PR10MB8088:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a02fb9d-7306-4ddb-ffe2-08dccc31f316
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1IGa3bttWJtp7Vk2aonUhQ4jpxpezOqtML35kl8FwheghGB6DZYxjBsL90A/?=
 =?us-ascii?Q?Y1co/nJx+6ApyaZq/JnZgWoDChCkBrMWZgKy8Uo0kIVIjkd0h7GNJfUnxouX?=
 =?us-ascii?Q?CIMt+thKeA/iAaV9E8x95QPPcQs29EMJKmU7Mf+OIlrF7R3CEN1s2hGhMc53?=
 =?us-ascii?Q?yU5b7cNEmNmO3R4Aey82wcksqfItVYr0+zaC6TZQaDWv2lFti46y1WfenlKO?=
 =?us-ascii?Q?lxS6ZYvMWPUwqbb2I+Wzktyl9CLg9E3DmYkFZEazyBL+chHjsyZUEycGQ1wi?=
 =?us-ascii?Q?pjPA9jq/SjeA56txWlio32P4PSws+aACXbm6f22qRiiAKZYhxrfEmA20GFUn?=
 =?us-ascii?Q?QsdoEeTwgQ40/YzzjCqqGWLQDfHff/sj+3uk1icVH154IOdR6sy7qRLqf/ez?=
 =?us-ascii?Q?d/lDzlPgKZi02dWM1/1cO2TmW4pLKGQEVU8Jug+Q6w2QSKdj8ii4lIMIqOxd?=
 =?us-ascii?Q?4uF3OK6K1bCxO0z4cO8cE5AE4TEXf8t+BkBZ24GdbDCqOwjfhcVCrq1qxp1H?=
 =?us-ascii?Q?EdkJ3HpYdu7qPMoSxQjNkKw5chZ9USz8MUCj0hZEZdma4i0DFVS1Ol9axC6n?=
 =?us-ascii?Q?8IJHEyTaVoCbs6CvMT8Vy7LhKvsy+HME3O0RtV9NCVtEqphmCJmydNA7MUkv?=
 =?us-ascii?Q?yO+aP5WOVkX3WM/OcWvczSTNiHFXQiaQdp6qTta3XEJHUVu5pA98rrDzolMj?=
 =?us-ascii?Q?9LEbtJvgwPjWPwKEwukEGngeBK61API+QZpERUP3tCjBj1bus//7ahypiZPo?=
 =?us-ascii?Q?21iiGurCxwBcEyocXVcN7mSzhJkx3y0Sz20wWxug08djQD+y6ZP/xvsSYZd4?=
 =?us-ascii?Q?sJft3UQRsSL1arCdh4rkSesB5k9XfcWRrRm7nqsdWHvlh4bf57DOBFRD+Tcl?=
 =?us-ascii?Q?JQ+NDk4qtTRjDmG0RkWCfgjktJbgJx9gj+lilV1+PsCi3yVisEjOZ9mLKdOD?=
 =?us-ascii?Q?MRQ41j+m56D09erjrEb5vLPddK5fZjwZBDlgkkB7GFnq0Y04Dyqit3cTGB+y?=
 =?us-ascii?Q?JrveHXSIrzX4lDr6kTH/Zh/0cYrtYcjwKen4yktCAisBHsJHRsQqIX72wAWb?=
 =?us-ascii?Q?GMTHmIrlVB1bRq250lDxG5cWkWfILaL3aKbWf8AsmgoTLzffAfKDdDk11KYg?=
 =?us-ascii?Q?Dw82hK8ZAEk6lzkGVsbgOZOloDq2O5q+1GaUlw0vGX7gJI/Z1CtVGJFvyBdy?=
 =?us-ascii?Q?max9wbw+gf9fF4Qx9HPBMqPZ6MCySG5fL5CSbw+MwpNUJ3ORt0a9BnydSGSK?=
 =?us-ascii?Q?kHSbWE2v7qOYbYqSD6otK2m3raTpEqMHbT+Twgjvoo3x86BPxJpZKLM1e13+?=
 =?us-ascii?Q?ggkfCc37vf8copgQW7W7vEiD0cstKiMKquvMzzRYjUdhRw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR10MB7924.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wg45glgd8buN08G90RemapaSq52XKCB7afvC3s0qQCItFYXsuSguh4u0mE1W?=
 =?us-ascii?Q?mhZes1EJ8XtAJE3mwKPmOzuNEAdWzXQRjY5uF/cjg8W+u0wdogpGingKwISR?=
 =?us-ascii?Q?iZ76DQaEMddtVRwyIUA3QeNCwa8s+yJVJ/HOR696vv6MKkGS6SSwabFAtyfi?=
 =?us-ascii?Q?IyfwHv+mNmAqhpwkPhHooYwSLFtpfgBPZvChPpPLPAwf6EprlzH2HfCsekXz?=
 =?us-ascii?Q?vndtAsTQ5aFkGgatFg6f6Xe4OYbY3eBmeVaolr41NZaqdgd47NHXdUnbWmad?=
 =?us-ascii?Q?SN9cqpK8kkXYW8HQ2Koicus/n0fyRMXYDi8Wxhq4K+0R9pJW0mCxRPFbiclu?=
 =?us-ascii?Q?S+qSh++6GhTo0S5Cpgb3Zkfor6Xs4zprRi9uoARZtXzFyULw9/E073DjVfBD?=
 =?us-ascii?Q?iIWCvqSRuAYJBz7M8yPQukRqebpdxtxHURWTVsiA/KYa/iLLFWzLOCO7tluF?=
 =?us-ascii?Q?q1fx4jGz9UyARrwYW7e7dvtG3AfomAsKZ2ySBp9wdDR1bAvyrw9n43fV8uFp?=
 =?us-ascii?Q?6/Zucsg0leGQPsJPQZZ/DJ5eu0oVUSXrKpKn9DWTiYfN3W21B5pvDe6wGQd9?=
 =?us-ascii?Q?rUvZxVUIkkcfHF1jUwadEnKLrvH5vVbUb1WrrCL3iNleuqHi8iTtEqqSMjUo?=
 =?us-ascii?Q?rtntIamY7ovHbzB6nutXN+Tv1r1rzumYPXLAWGLEN8xKblW5pMtywwWCCicV?=
 =?us-ascii?Q?JSlUdgLi/mgzZaGj/eYNJ+DQx7oBhLW2m3bmtqNPHyDizwn7sdr9efjQxlVr?=
 =?us-ascii?Q?2TVrvClflP88sX5MTiggJcQFjcY9zDtYJUB9JxTa5joFd7xYz/mMouYI6Sos?=
 =?us-ascii?Q?GepMC8AjhbYx84HWJyLclaNgg1anFfkFD7ZyJNqc0jiBCfhA5TJDVtHjLOah?=
 =?us-ascii?Q?DohBB0Mviu8cSmgh41OOH4NEgb/esZwqa09jKfCDEByWODNEjxK+GmAkluWw?=
 =?us-ascii?Q?FcbBBP7lay8o8pHRwvuH77lL3/d3VII1zVKf83oOpQ/ccgCqyUPVm03seMZ+?=
 =?us-ascii?Q?NdD5eAehAC58vYWkJ1MZJpnozigelpdAhOCvEalrVe2PozMy2dYvMe6jsa83?=
 =?us-ascii?Q?adfBOlNPl67MehVmpmmzxwT9ddcO01pDc4SnLf1sE7klM+9GbabA0uwAET7t?=
 =?us-ascii?Q?iMWPE/qu7z2PE3FQRFwIoc1/MYiATjHcAkfM8dWiO3m9AzeGmPMzZwATVQ6U?=
 =?us-ascii?Q?uGIZK53j4P6hWToQ3XU9VjBOrVfaDiGwRVCNOYBOukxRmzrxcwZ0L3HqH+r8?=
 =?us-ascii?Q?+xUIYw94zwpt9Wma0G+ySkG9MVlVf7ywQD1wU5ZVKviybqo4lw5C+A3HRmfu?=
 =?us-ascii?Q?zbgj7QR/Nw+KavHk2dFA6UhFekgsRgp70p4ld3V3wgB1iCjce1V0d9T4EUzI?=
 =?us-ascii?Q?meIe7FkKUcDquS2I9OJTjIJm/c1sQylGSZZ8lwZkR9J24KGFFQwdlug0lAVZ?=
 =?us-ascii?Q?SS2UVEOuM0R9ocWpnk3Ke6jlT9vpDFm2EYFLP6dH/xD3/qslJhE8ifOLaFnc?=
 =?us-ascii?Q?erni4veRGtVUnyPH0IuQSt18d39JUjKsTaaw48L8gOLGyiXTDkiM6XeOz9yT?=
 =?us-ascii?Q?hvHyHxFSuuoukT/hHO59SdaR3Izr4qT/2lnfkWFk?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	L0uDlS9NBZBdUpiOMFQOeZHBgGOXfzVzUO7moeYpoxmai2GCFsmjpx6yFjZv3KrRBBI3tqZsFgpAzMZ4LCLOvqtXiUKRu1b8kvzwcwFKyT/SUZm8Bl9+e/nYLUyKUeeSlByBAOybcPIPYc4VociQEXiDSw/Eg32D4YnVLHPdODeVLZjQTCyqYU33X7pXPiDtR5ZFMBQ03JRDU2TbW6K4oDE/dg82bb26rJshs2GSH52Avn9akZIBgOks0ma8pp4nTxxK31Tf2exX6NLCSd0XuDml79xDAQrsJXuPXFyqPtP5Rg43zGdgggF8MFwbbzSZuxc3W4YQwByc8G7+4wbfOj5ufUtuC/bSsx49+di9QXUz7w3qkIJTn9uIBj/AaxcG2OrWseIWZe5CYR8rldtKs+9s1KrtwT5V8UXDx0QMO6+HP3kwjA14Tn6RIomvf4o3Wnqw1nh2cxFllt80G863UOLRP6+3w/wJVP7uhuGBW825kZjd8O/OE8ObxR4An6T1JLXHJgvVAVKXnjxcvlRXv/X96XAShYGUqUh+/79dOIzqXUov72TvXH5YQpGS6FEjC1BSGR3oisg/Tkayb3gBDHV4D0hD21HhJchLeJmEBpw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a02fb9d-7306-4ddb-ffe2-08dccc31f316
X-MS-Exchange-CrossTenant-AuthSource: CYXPR10MB7924.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2024 16:03:28.4609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zN6gg1QEQ3KGRGxGn5WOqgtj5jxanYUtkWroeAuzFnBtsbEBBiiee4VEBRj9OdDZLjEW0BS6Jn6cLYnXUPRhbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8088
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-03_03,2024-09-03_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 spamscore=0 adultscore=0 phishscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2409030130
X-Proofpoint-GUID: KtPCq5MhLF833TFG03nVgPrW6y88TTp8
X-Proofpoint-ORIG-GUID: KtPCq5MhLF833TFG03nVgPrW6y88TTp8

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [240903 08:27]:
> Hi Andrew - TL;DR of this is - please apply the fix patch attached below to
> fix a problem in this series, thanks! :)

Oh yes.  I should have caught this, thanks Lorenzo.

Cheers,
Liam


> ----8<----
> From 3e7decc5390b0edc462afa74794a8208e25e50f2 Mon Sep 17 00:00:00 2001
> From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Date: Tue, 3 Sep 2024 13:20:34 +0100
> Subject: [PATCH] mm: fix off-by-one error in vms_abort_munmap_vmas()
> 
> Maple tree ranges have an inclusive end, VMAs do not, so we must subtract
> one from the VMA-specific end value when using a mas_...() function.
> 
> We failed to do so in vms_abort_munmap_vmas() which resulted in a store
> overlapping the intended range by one byte, and thus corrupting the maple
> tree.
> 
> Fix this by subtracting one from vms->end() passed into mas_set_range().
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  mm/vma.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/vma.h b/mm/vma.h
> index 370d3246f147..819f994cf727 100644
> --- a/mm/vma.h
> +++ b/mm/vma.h
> @@ -240,7 +240,7 @@ static inline void vms_abort_munmap_vmas(struct vma_munmap_struct *vms,
>  	 * not symmetrical and state data has been lost.  Resort to the old
>  	 * failure method of leaving a gap where the MAP_FIXED mapping failed.
>  	 */
> -	mas_set_range(mas, vms->start, vms->end);
> +	mas_set_range(mas, vms->start, vms->end - 1);
>  	if (unlikely(mas_store_gfp(mas, NULL, GFP_KERNEL))) {
>  		pr_warn_once("%s: (%d) Unable to abort munmap() operation\n",
>  			     current->comm, current->pid);
> --
> 2.46.0

