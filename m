Return-Path: <linux-kernel+bounces-439334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D919EADD6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 11:19:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B3B22886EA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A359B1DC980;
	Tue, 10 Dec 2024 10:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ChdUUDop";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NCIgD+YS"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAEB978F40;
	Tue, 10 Dec 2024 10:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733825963; cv=fail; b=q0wWY7O0BRdX0qnGW8sAekDm2krByq2jgERR4W8IIoLtFLum55bOnxQ87fHf6OzHgvJgGr5XGkkLwBd2tw9NkySPce6BokI+KALB8og4jcIrj52XWgHEXGLPwM51eN0KnFR0j7X8UJ3fOXud34UmTxstLsv8EW5hNx8dANRCprg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733825963; c=relaxed/simple;
	bh=P0M3q/sA/SHeP7sYSFRq6nrbkKAz8OouU50Ky01mjZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QoDAny2zchQ4gcBquJG+Xpq9qH3FZaM6wl9DMFkU4KN1VhRv14b6krod0jBV+4BEZEDjCVSRJOjRWPp1nscEudTHBaCY1CKN/oCzQuyOOMHbv1uvSeQ6BnJ664vZPZ1QI/HsIpq8HQ/VGTnFPt5yhzyElFznhG3Q3wI5b6j84vE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ChdUUDop; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NCIgD+YS; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BA9bXG7010611;
	Tue, 10 Dec 2024 10:18:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=oNUmwyekujcmmquDBR
	engpenjRWHr+gFfXqRB9QO2oo=; b=ChdUUDop0OpdRV0KbeIfL1YAFvaweOBIID
	ChC4OUe0zmywaD12QBEhk5Er31xJgoSCln5lX0AzprJwgWbRsLlTtVU5eV1hfccQ
	eHuPVAEkzraE9oeVMoCMm955/6zHWJTg11QEno9RKtcxeaMXH6PyUQBzTpmEV2k2
	zhlnKV755aTQ49YfV8+CMxytw4tgBAReTdhPqDTA0GucrO7Gp07fVCARatBP/N7L
	ZnyN2jjyOYwm1Pbn51q3g4nTlc7DNgh90LC7NcasPduSuDmqzRSaJFpVniWzanh9
	rv7wJ434UdyLGx2v5YHS9b810PNhPZUL4VzIzA1QHlVbbpoFm0/A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43ddr63h3p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Dec 2024 10:18:38 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BA8FAi6020580;
	Tue, 10 Dec 2024 10:18:37 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43cct84q58-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Dec 2024 10:18:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FZ/DE1SiCXEqKd9RllPgjZuxvttmJPRetlyD5qM5OwR6uC0aW18BazRaAyxYzs14Eeur+jBkw4GdJ45XKWABHpTN1on2AJ8s5+AM5/T36Jc1yUG7vqdN8YAAWOoE8qG+h56+jtADobfK8nnrMjyfB5oR46mmd42FlzYfPblSNQN0hQullzXLEMkdx2SnCgPveMg8ILizmNAsUa3MxRMYillZT/R2pDhUmehhTicg71fL/qD9zryhSzybv2JqBEmaWpJXTDj1C2UXHlNL11LCA8OkDyWpPuI5Koqa5nKGSQAnTEDvR7T+W0qhRQYUWEp9ro5BJOIt9QrLIYsAnrlsQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oNUmwyekujcmmquDBRengpenjRWHr+gFfXqRB9QO2oo=;
 b=Ub6mZEn0TGzkMEOZYeeamlvtoSuT3pcjmghDabUNVlEyZMloNsWeCLg9qU+hJFvLeVHXPje4ltUUcCq0Jce9lQWA3wDKFOewgd3MN9E6gojQi2d7nXqVAUwUjEN5zI5zgpXP2M8YyIUkQC3qQD+IbxXlc3ClwJ2o4LfCuA762drxZRL1UCBrwTAPyojZKsnJSMZOEa+x00kJNB4LMLRKdwMLZu/zRiOpsVNc3oJ8LfPCiOeosaX3Z+W3kkkuFVnByFd2orbnIhNlpw7cVB4ZPSb/jIluntQlj/n2OaU9dETjWyYz6Mna8dzX+R9yrVbUnmG6UdkOQ1nTMHMbV8ldcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oNUmwyekujcmmquDBRengpenjRWHr+gFfXqRB9QO2oo=;
 b=NCIgD+YSqD2npAf9noU+L9dQwrRZwy49lxfu3kfrFpRe5Qqb2sG4YsGRKrtIuo6zyPEfBDwdcjsRDLwDwWCvApg7w6pEF7EBYkvf+BTqFdivgt/K/jWj06fynndkrvsTH48PTm0A+UkNidTupLkkuWNDntrWq8jE5kTA2dF7128=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by SA1PR10MB7739.namprd10.prod.outlook.com (2603:10b6:806:3a3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 10:18:03 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8251.008; Tue, 10 Dec 2024
 10:18:02 +0000
Date: Tue, 10 Dec 2024 10:17:59 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, oliver.sang@intel.com, klarasmodin@gmail.com,
        willy@infradead.org, liam.howlett@oracle.com, mhocko@suse.com,
        vbabka@suse.cz, hannes@cmpxchg.org, mjguzik@gmail.com,
        mgorman@techsingularity.net, david@redhat.com, peterx@redhat.com,
        oleg@redhat.com, dave@stgolabs.net, paulmck@kernel.org,
        brauner@kernel.org, dhowells@redhat.com, hdanton@sina.com,
        hughd@google.com, minchan@google.com, jannh@google.com,
        shakeel.butt@linux.dev, souravpanda@google.com,
        pasha.tatashin@soleen.com, corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH 1/1] mm: fix vma_copy for !CONFIG_PER_VMA_LOCK
Message-ID: <98b1bbc5-7579-45b1-91b5-1a9f76ef7900@lucifer.local>
References: <20241209221028.1644210-1-surenb@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209221028.1644210-1-surenb@google.com>
X-ClientProxiedBy: LO4P123CA0198.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::23) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|SA1PR10MB7739:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b71c311-97b0-4e71-597a-08dd1903edcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pGthbhKpoEfvrw15h+5E2yUQJZXM2iVVrxP6pzSkOBV9XMEunV45cl0UVl8R?=
 =?us-ascii?Q?NpLog5NffGPmOM4/qoCL23E9YiF3JmVMWqPTSaePt8SzyjR3OUICUaWh2syX?=
 =?us-ascii?Q?WPw03Lcz8ZJfcLmztSFGPcS6digTXFSiOfc/0rD9/TOD/IS/AsbqDMGOXfMt?=
 =?us-ascii?Q?XYx3IhGQfJBK0yJBjmwLzuY7pLqQPZQ6Jd0M5WoI52d7UwbeE6Gu4uEOGJxX?=
 =?us-ascii?Q?3YQpFMdtiySkKYDcBCmaSyu/MtpF98UsalhTcpRnUo7EYR9pnhfqSoSLrZHy?=
 =?us-ascii?Q?EdkJ/8cQK/EYtmSWnTPjE/S1vPojLXOaLmYmXa6+JkGXKHum+u5R8Q6VZbbc?=
 =?us-ascii?Q?+9KTS7hQ+1DY4QpIEacnwzcUBzzYVhJij8PCWZ+XsQuRw4wN5jAZBowmMIKd?=
 =?us-ascii?Q?CygLEefC7G+NWr2Do1Mzvue93faXwEH/hP/l+f4xR38BJLznCASQbl0adCQk?=
 =?us-ascii?Q?+n59Iz4YH4o2d8RAoJTOozpOtnzxdMuaXB/snYwNTOek4BotXDZsock313on?=
 =?us-ascii?Q?s/cDlDtFLBJAitnEiPhCkFSgTnq19e3WOhYNwmuG5bdpoOHndvEt0w181Jut?=
 =?us-ascii?Q?IDW0VsWqJjloPr3C0otndvhTCbmzOCBHfUk5IwxrV72Q2sKtWZGVPJyTA4BX?=
 =?us-ascii?Q?BjjRwD8C1s+oC9lLXk97zstiq1q4X08oWiyO3QRWUMQV3Dkt3ScXTJtTpMG3?=
 =?us-ascii?Q?6EsCms9x7ONVcOe6hhZz9oCQD3UrVqngn6+h8gvlxWzeIMk5247BrQZ2N9V+?=
 =?us-ascii?Q?LEX1UaPafo0V+1Sn0wRP+OXVcKbe761uyZlw/xy/4bcWE8AMfgZhIw27606R?=
 =?us-ascii?Q?f6KxTidgZdDJw91uTCHEo5HHtb5aPq2L7EUd1e77Z+gsegagDd2CIV0K5WJW?=
 =?us-ascii?Q?jwXaO1KnbGeXxOJyJZAEeK8hZfAQLQvgdxgEiZRo71IsRJ3odd++1Gonvt/d?=
 =?us-ascii?Q?oee+YbiF4hnC8zDh+DhYQRhYgAQZJwMc7H4vlSk4ydvWwXA+Y7fByTCZFi/N?=
 =?us-ascii?Q?C/9BZyVa4D2uHFhQyxH1Y6AfD80DaE+WzI7YkYFB9P9CiwV66Tnx/NLvMziv?=
 =?us-ascii?Q?8FbYRtW4bIah6v6YX6UC1rZ5dcKE/kOBL+QVDTPXrQU5YSIItSzXFwD1m1K+?=
 =?us-ascii?Q?zcVVrlv1QaZf11k7dfx26vNaFJgTkoQ5PMQnDUoI97bE0M8/et/HXhO5QzDk?=
 =?us-ascii?Q?C/chD17cvn4icgDSCEJTZd3/aQQ+ZvP2gYzsxaGwvNBFCW82Leii8GGh6clq?=
 =?us-ascii?Q?BR10GhGwYgAItgn/coNpnTKyrIMDxAT7j7SGisLCusQL4QwoNmDULjaS7A/g?=
 =?us-ascii?Q?DQB/N/CYhWqFY60/zy7OSjsXWz7EWZ7zDIVWwhQtwWX0F0vat0tpbRn6vOHB?=
 =?us-ascii?Q?FvJNoBc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ona3o8hnzWJgmCAjNrML1M6R+sxDYQ9f1/jkhMM7sV/P+LK/NSUoIcpkV4/l?=
 =?us-ascii?Q?klJIzSHo2NsutyDnQViyk20LtGT8X8xGBKBgm1vIWWgzhfANl8tsonO2EAS+?=
 =?us-ascii?Q?aQgEpbfFbO+y8o4L+f54shwVpA5otYssipvHRoOnny5JDyicv9NGtnm6r0vj?=
 =?us-ascii?Q?bRqvccySMH4yFy7ghCP3cxkuvMK/wMCMxFqgk7GtdGwOvqjwRH54BEk3A2nA?=
 =?us-ascii?Q?s+cgCAW9gx2ya1kNpU5tUghbNs6r3tua3jY/U/YetruxCWcEVOv3VUfryWAP?=
 =?us-ascii?Q?VBcPYo1HxNftegbb/e0aqEnkwNb0F2w6DsAE4LCNTxvJ3aFUTlSrsL2r7hM2?=
 =?us-ascii?Q?QWLD/KNNTwD182DE7+y92GPOBpxeWsWVLxii1Dl7bRembhx4V+VrppjToqTK?=
 =?us-ascii?Q?lzh89EQ6J1OACLhOQSW1x5Ba0mb3+QcCrYMebauTE5fWz7LtxkMfcsuvwLqs?=
 =?us-ascii?Q?XyiLYaTJwqXD7n63yvvwrpLFXXUnO+5dGN61jTJqUfNSYbiVGyHwd/NATKQ8?=
 =?us-ascii?Q?O4R+Go5QJMJKsJto6ORbGs9pYppXimQKuRP5SoQ+66IefdkNr160sPwp+zZ4?=
 =?us-ascii?Q?SnEGp86tmFbdRiRBH30NsSmvTJuAwGsOfkTGw+IENHuZQ1oL5XlnZjcF7F81?=
 =?us-ascii?Q?DJdB56IPQ1vzziR2xxDe3VylMS9lm7rhZVxYgMTk+N8VxUsUXBTowNG/Eigw?=
 =?us-ascii?Q?J82d+4odS7hNykDP/RoJ0J7ayBssM17F+YdwPzYCQCFg7ob+k9ljm/Asrpsr?=
 =?us-ascii?Q?P43e+aJb6xg+Yht4BGL4jcXn/WIoadQL2dAKqYCeqZ01UMNK5ShPDOy/Sbed?=
 =?us-ascii?Q?LW4yLhnFdkJcP7KfPQR2WAdEL2Oqyx0qi0wvqXoIeHUSNYFQNj/+uFQkj8uZ?=
 =?us-ascii?Q?o3i1be7oBnScMckW6gjvxstDJODAy/s4Fu7g1ndjjg54SjP7pMGSWZYOkNnl?=
 =?us-ascii?Q?s/yCIOctj8IS9XeFf4lnZqI4CcjKnP/WwaeWOfPvQJSBokBIyte6al/d/fkN?=
 =?us-ascii?Q?SuLpEJScRD8f7gPBRRSQsTQ4cESvdjOE6JPO1TNd4O6nfI5c5/jpfKzUzZMf?=
 =?us-ascii?Q?5hpAo2vDAlP4VwAOP6z3LuuEogsgDsYDS08CfDJtaAjuzSY5rFfOW6sTdjz4?=
 =?us-ascii?Q?gBaMDTMsBz+fLLn1r24bQFcp6Z6t3K8nITifkfE/F512fqSWj0OqIp6VtWnw?=
 =?us-ascii?Q?5S8HM6E/CnDRdC1No2ByS68dEnTPeWEHHLhHKo33V/Iy8Smxov/W2BYBJn8i?=
 =?us-ascii?Q?iMKcxyAQVhbcj86L5nChBnCx4oY9OnfU6P1ciSuL7M7oSShhTFhB74NJjPcy?=
 =?us-ascii?Q?XBxYrp42s9i3+eZpotFQwVsJqvpOn/B232xmAtysCQxum6CWvsMqEnDf7db+?=
 =?us-ascii?Q?5QdNpePnqvRXzVewdWKGu1KhyAhfpVfhWro1Xai4ba09NC2I10q5ZN6Ew4uy?=
 =?us-ascii?Q?ZgkVzdc4s01vPw57UdTPNO0g2rJ/ccELjw72scQiltJtjMTFb/827ugQVHkU?=
 =?us-ascii?Q?B/T0JKyOKAJYTOJffIGWi3agaHFo3l9lUSMnYD+0/OnjefxakqzR8I9GrLJg?=
 =?us-ascii?Q?mOXIGkpe6Z/G0JYQ4OChAYzgWbqxMTF6zE6ivea53Bn291RvdJ+PjYKoSjN0?=
 =?us-ascii?Q?LA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NBEr9jhFovpUOA0e3IhSwaGBqTeXWQBxcLivL3W54LsXNxO3UzInEMBYcmcMPVw/BxmcH5pqtqBzxhTxkZEBvzZ57ofRJ0RWqYEuCSdFiq1uZDBsVoHgVdVDMTXAgko+Ox2/15eVY7ZEYD91PEQQW5kCQrLAHg9mDuMJ+aWZx1Pj7Jngf0ZMzO5aYTAP468JBNspNUDZd1tuhq8Q09AYWweBIxIel5LwdaMakYkfe9OVqcdJ+7JaSq8KuvSsmMWHyjTn2PKhd8UssoihwsKwGG6ucpKgpJcgG3/sTx9AqAqTFnOlHHztK/gs7Z3d3cUSnmH5GIbj9p32nBPS3yAtFvY5lyd9mtksj7DtwlswRtN0Ag5WE7BbjhvpxjO/NxhL7gA899N54s9InFN5GUAXRMNRMzMBjtHSm5pwECQPWamKxZqDkOO4FiyfMqDbUU5lQINwlzyqcYRmyLeF9ZS2GjqK24m7SU7HYBmVnY56QfKFn0UxHbLC3S2TcJsbGDsAKxR53m4hUeIZLrUNNVVuXCqgduSG21wEOZRjc4wJmQzwGJnMb1OnOBuSxieECk8tIFMM/i3/AKT4HQt7ZfwrZnuXOmxeepqHEaR0UUd8FSE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b71c311-97b0-4e71-597a-08dd1903edcb
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 10:18:02.2798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FiDs/Hovbhg1pW2ftkkp3HPY+2EuWKMYYgMKVPXJ+ItZwpQdx1Pz6sFZsRO0qHNa8TvvXkGUVqukceOipllAThJXoJWMEcxk7EJXCuj4bIU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7739
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-10_04,2024-12-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412100077
X-Proofpoint-GUID: NDK-3p9EtDCIjXLwT7u1rc5JJfctNoaJ
X-Proofpoint-ORIG-GUID: NDK-3p9EtDCIjXLwT7u1rc5JJfctNoaJ

On Mon, Dec 09, 2024 at 02:10:28PM -0800, Suren Baghdasaryan wrote:
> vma_copy() function for !CONFIG_PER_VMA_LOCK configuration copies all
> fields using memcpy() as opposed to CONFIG_PER_VMA_LOCK version which
> copies only required fields. anon_vma_chain field should not be copied
> and new vma should instead initialize it to an empty list. Fix this
> by initializing anon_vma_chain inside vma_copy() function. The version
> of vma_copy() for CONFIG_PER_VMA_LOCK is fine since it does not change
> that field and anon_vma_chain of any new vma is already initialized and
> empty.

Yeah ouch, good spot though.

This anon_vma stuff is landmine after landmine...

>
> Fixes: 85ad413389ae ("mm: make vma cache SLAB_TYPESAFE_BY_RCU")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202412082208.db1fb2c9-lkp@intel.com
> Reported-by: Klara Modin <klarasmodin@gmail.com>
> Closes: https://lore.kernel.org/all/d0ae7609-aca4-4497-9188-bb09e96e7768@gmail.com/
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
> Applies over mm-unstable
>
>  kernel/fork.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/kernel/fork.c b/kernel/fork.c
> index fec32aa06135..d532f893e977 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c

Unrelated to patch but it _really_ truly sucks to have this in
kernel/fork.c. Maybe unavoidable given we put a bunch of this kind of logic
there, but would be good to change this at some point...

> @@ -524,6 +524,7 @@ static void vma_copy(const struct vm_area_struct *src, struct vm_area_struct *de
>  	 * will be reinitialized.
>  	 */
>  	data_race(memcpy(dest, src, sizeof(*dest)));
> +	INIT_LIST_HEAD(&dest->anon_vma_chain);

Nit, but might be worth a comment here. Though I suppose it's kind of implicit.

>  }
>
>  #endif /* CONFIG_PER_VMA_LOCK */
>
> base-commit: 6e165f54437931f329d09dca6c19d99af08a36e1
> --
> 2.47.0.338.g60cca15819-goog
>

