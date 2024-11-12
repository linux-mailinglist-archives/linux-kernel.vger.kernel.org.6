Return-Path: <linux-kernel+bounces-405507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F329C523A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 10:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 656C128276E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 09:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655BF20DD78;
	Tue, 12 Nov 2024 09:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ip2AhcAX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="utHLuuhl"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9154B20D4F4
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 09:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731404438; cv=fail; b=BhyWol4jxslTomRvcBEg37VmElxjUM+lZ8LJFUccZ4kg5Fm5dGlLa3tUjBovRRrL/oJ5Vs2hRMV9z5C5CZfhBwKnqDQ/Ef/fOkvIMdIS0A3suzRV/Uk4C+FNdUFrRE9VhlNT9s3VbCd9MsVmQu9LjBw4670Yx3EOu1kUF9XNVOk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731404438; c=relaxed/simple;
	bh=eSlEAJYGm5FrTyjTwW1V6h0bW2wW7N8FOFywwP6+aYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rhtbwfIisbE8psvoq0vGVZGOkPWabkcmaLZEv+zgdlxYmJ7aFkpJDFmsIxvbn+sDOXNfl57t1BmaVM3ttxrdQMwk8hwWs3nyYjyY49Ea2m1bhBV5AzBYVj7cBbDL7PBWRQHI6xqhLGzz4eSJq7Q9vH47NZgIm01oAZgUUIFGNU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ip2AhcAX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=utHLuuhl; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AC8faOK020795;
	Tue, 12 Nov 2024 09:39:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=eSlEAJYGm5FrTyjTwW
	1V6h0bW2wW7N8FOFywwP6+aYQ=; b=Ip2AhcAXitGBHs91tuDh4jW2lISkdp0rYb
	NDfMjsqM8lFFn6aO/+htBRgPWBG47XgK9hxJZ/3wtyiHprtyfIrIyiBykqK5ZmMj
	R3cksxm2PI46pFgXEzT2zWhgbJkHsm2hjcQsyf5l24IDpEBlwnaGeYL8jX80gffq
	YGys+ZYLr64p2nDzIR9bU86JqtO3LL1MQdGj65TZewHxxzP9ihwi8JP9+FCcVSv/
	CJPTX/jdLNrZZel25QgFstGLx5IeWieSAPFn6DK07aEDxs5tA48ggCXS8Q40rN2E
	nwzn7vmbV5tz3AfLlP0rRavMZW2XMVK+npcFFe+bccxPfYtwdsgQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0k23y5u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Nov 2024 09:39:44 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AC9bWHZ012110;
	Tue, 12 Nov 2024 09:39:43 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42sx67pbpc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Nov 2024 09:39:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HRBJHOte1OTGW/sKu9fYryY9GPfeWpbmjbStrEHSUKOnD8GvMiNjounyaHhFcnhI2wejwIhaShgx0KsuXtwUWWLAVklXYYEb3Qd+70NIT0BZ5nG1RUkyTt1T1XJKZodOM93XgM02Lw3lgkuR/AerKwbZEdCRNHPnNWuATlLX5Cg2+xvlO898Y9rLWLH8xPkD1vstJXYdizRyD0kIR1V5pFzK5JVhaqUvr2NAc8f+4Fd1ETOjp4I2U50Q07XyVK7muPsJD7C+oJ4MZQyqDcGZqkB9nAsU/Aw8uqb8Iq1upEhxAprx7pbvIPa5pugh2juKi4ig0pKs3U35s0Pv9/Q4XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eSlEAJYGm5FrTyjTwW1V6h0bW2wW7N8FOFywwP6+aYQ=;
 b=WRfgbrIITYqksdmuQ/fM8cZ7VPKuRjdjEqYLeXXP0kfrqKS28KWNTEdhMeEMosnxQSJfyZ2npON78RjOx9jIUrLhPx25CXzIxF4q3crRkUI8X/IFsruM+ujeoFsINV6izVcpKQjngGTjXmY2fRwwf9ntzaq7dQvQ8uh5DkYFr1KvYpv10A8nrNxnIDsTLJziXndRgD+Q8+PwDup83B3V+41dAzRhA73ST6Nu6wMl6AT1F/W6KdzNJMGDPZ2QgnnMAq7uWNBE0K+mnnR9pb764ToygIiV1bp+6wJGxPTLcTbLfG8Sx8XzXDBUfHpnNQHQvpCkYtErziRBQWmETgT3FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eSlEAJYGm5FrTyjTwW1V6h0bW2wW7N8FOFywwP6+aYQ=;
 b=utHLuuhllu8d5eZvcMmw6l/vlJG46TEZ0snramIbfc4n4OtiLBUQ67GJZ7Zk/nL/i1MOuqOECRdpSxpG/D3roSUgpHBtjngniTnfd4o+0A69ITzXH12LshqsdyWGmdRVjtDJv+JAvsiBMJWFmZCwi/FBB0bLKNEz7LKd8Ll1MQs=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by PH7PR10MB5745.namprd10.prod.outlook.com (2603:10b6:510:125::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Tue, 12 Nov
 2024 09:39:40 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 09:39:40 +0000
Date: Tue, 12 Nov 2024 09:39:37 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, liam.howlett@oracle.com,
        mhocko@suse.com, vbabka@suse.cz, hannes@cmpxchg.org, mjguzik@gmail.com,
        oliver.sang@intel.com, mgorman@techsingularity.net, david@redhat.com,
        peterx@redhat.com, oleg@redhat.com, dave@stgolabs.net,
        paulmck@kernel.org, brauner@kernel.org, dhowells@redhat.com,
        hdanton@sina.com, hughd@google.com, minchan@google.com,
        jannh@google.com, shakeel.butt@linux.dev, souravpanda@google.com,
        pasha.tatashin@soleen.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 0/4] move per-vma lock into vm_area_struct
Message-ID: <561f69f7-147f-4f34-ac2b-aa1c8c3dae7b@lucifer.local>
References: <20241111205506.3404479-1-surenb@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241111205506.3404479-1-surenb@google.com>
X-ClientProxiedBy: LO3P123CA0005.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:ba::10) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|PH7PR10MB5745:EE_
X-MS-Office365-Filtering-Correlation-Id: aebbe52d-33c0-4369-b5ec-08dd02fdee2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GWHeoXYcLAOCLTdf3mpErbTlW3rCJ+tqPzSrDZDqfejqbML4sM+2AjQIndcI?=
 =?us-ascii?Q?9gi4cWyncZ1EShT5Ce9MSSkef2Lxrnakg3z/gn/TUGkzHueKLrUHpaNW8Ez4?=
 =?us-ascii?Q?RInvOS9ODq8c+wDlCtihQs5mNQvyoBNkpva36x9jwm7Ei61x82KT7ALdTXmS?=
 =?us-ascii?Q?d80rTtmsRnWAXJfOFitKWj53FALZQDwOt0P/8ZD2/7gKPjyqsAbJtKcMTjxT?=
 =?us-ascii?Q?+qOz9P+3j+V0SdsOnVzwNolXIg/7rYfmAkZIrm2r2Wqp516rbu0W2IZpvOd9?=
 =?us-ascii?Q?LjNNOFIwPzA56PdpkoXmtOVdvQ0JL++8jHmZKu8zzutpRYvw/nk+NhZ+PQac?=
 =?us-ascii?Q?PFLy2aju1CxNzJIQ/0VWtUZb7Qimxk2ZnavZR1lB8gVsqHcc4+543cGNHt0t?=
 =?us-ascii?Q?twcwhVHRk8CJTcAfCuG7y8HDBSVCH016irHZ2oJVjXclGZluEDaKcGKwC5CX?=
 =?us-ascii?Q?s78SLYBADkLHv4/SXMhd1EDa53V3sNEAkblNN5i9qcdFa9uUE56DzAoA63Kx?=
 =?us-ascii?Q?RsoinC0MVN6YTFZQPWKACau4TOH8WnGtnr4TCXlzPjSXSC3uQJ4f6Im9EZox?=
 =?us-ascii?Q?81fh+zCz8gV2FkaBFyb081o2iAPBnWnpR4L88Ze6ua6Vm62mzVCC59hyjx6a?=
 =?us-ascii?Q?EdCPetBLFe6laV3GyDpyliDIl6/T87jcrw4O8hvq/ku5RiAC7vwjrBGpAEVp?=
 =?us-ascii?Q?3azFLVh/3KhnVpkQE2ZWyqxPQhQR8dvKvWjgmoPngeZCuoQYsW23ABO8euX5?=
 =?us-ascii?Q?RdvRM39HiHVVVCRW+Ah4Wo0oj2NPg3arBd8xGqFSBPwMqIhWYWyG5zUMZOe9?=
 =?us-ascii?Q?kbRZ4Gzw6UHUhGrEs7HW92r6LzZtj5tdmiut/4OM49YRBeBLhTIFbrXH6Ulq?=
 =?us-ascii?Q?dJD0nxkpZBte5wou7vMf3gPwBr5ty4ULwEqqDQuYwut176OQheYihQVAEsr+?=
 =?us-ascii?Q?Um5IpJDLvIQ76yHLMr6Qs3VA+lZ+8c8Kr1bhCgHgr52jW2BlBcMRkS3G9aWa?=
 =?us-ascii?Q?8tFlETG1YK4Y5KFOePVc6oDCI/YqTaHFeT8KO0M17J9pPFNyyMVcdqUKUEDM?=
 =?us-ascii?Q?vvO8dten8GgIjRIe3JgG5ygBB/Gu8L08TXg5QCsHwlsl5olBo8fSefFO81zM?=
 =?us-ascii?Q?otrIcxBVZUcCRHxzgYnXh0soqolHRqR6rC9ALJCDHAJ5Y/DDV1q3h1CfEhde?=
 =?us-ascii?Q?jScrfaH5dosqgLzgyh6gz+9KMT1vBcSzqUdnPwkiwNEPFmr1InWmpIvjHSvn?=
 =?us-ascii?Q?g4CGH9LPxvfTfYuEMm6/uiMT81WsR8GXG0hWMpEOeV0nGy0WQdP06fuqXbQD?=
 =?us-ascii?Q?3N3vch90piO2gscFkmEbonpk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MpL0J+XqqnJzP2LwurPZA/yiz4tSU5b23mx6S2qLV/lfnSLZw+b2jI2qTJ84?=
 =?us-ascii?Q?Gl90WeG+TmbiFgwBI08RTjJIWuHXMIOK7senkikbAL4fLbUaHJsTTBs0mIEP?=
 =?us-ascii?Q?+XynMkIgnlmVqii9lQnPh71uuSFVLheJ2mg7caBhJz1sLUhlQo7veDItMH0V?=
 =?us-ascii?Q?o3D/DFI53BGJTQcUiBniHrL3WmIUyEWyYAj6P+z8Nn1WIuWw4BsnI7s9Wnbt?=
 =?us-ascii?Q?7rRSBZH84AYd1IH41sHWFCkPvWumbLg8nEOf/IzpWJ3n1Y72P6/iUVUxL62h?=
 =?us-ascii?Q?6cK2C5DR6fWaTp4RIuJEJH277LriJbiH+00uj0kTPm2MVBIapgjBQBbVsEE+?=
 =?us-ascii?Q?OepXJF9VZoEez8b7v6BKdgDhWkRe6aFuCXSDrF3uOUxtIPq4MdYXo5sQtcSU?=
 =?us-ascii?Q?L0/zxBN9KUk8X2kKY7TjxGv27lHvbnNc3YdCxRrVOmFLg9frMmc8/o/atISV?=
 =?us-ascii?Q?3NCyWjlOqhck972DL4F+nYk6VsNxCRFwGloebqTIRPfi6O9LVVPuRxXY5Bai?=
 =?us-ascii?Q?B5vcump0yBfkb07fyzJnZrkrItwIupeTroVsAGzwuvCnyyE4j8fE7R6VX7ur?=
 =?us-ascii?Q?eiewiCgIdqGTXXW9eml4kVcA0znTH/1YWX9eTI8hVDMqTK7eNCnxtpo0nPWX?=
 =?us-ascii?Q?h3a3TSLgOtEK2X9NBZXukWrf1YgfVcFa5pF28weAgWAy5EjRXzyx2BckDpOP?=
 =?us-ascii?Q?Lv5m5pciD/YQqglsBzYn6x6Qv9h3wFMH9Rni2OLf7N54MPoXppFUM9d81o+0?=
 =?us-ascii?Q?g5KUDazdXyb78i8oVF7nVWHCQArUzdIY1Ua3Pr18gNMELzzroXvbcPoud/l3?=
 =?us-ascii?Q?Ao6b1fMb8ABgLxkPqu9TKEE9eGYfU72rfKxaOLiaQZESgDS8DpGJUw2hiVSi?=
 =?us-ascii?Q?0u21kETAGX+69GNGHXAFVCWsQkh3I27+a9l5O3YusT8dBO+HYDbGoBZMIOBr?=
 =?us-ascii?Q?hq6s9cepEfCGm9cSrNAHXJTpKQYfb8fMVF/Bz+Xs3nZa7vB8gOcEtYwgLFCz?=
 =?us-ascii?Q?TtqjMLatXbfU1MDO62HT//BqT1ArOOxp3boAQNJav6V0b7feljaDJzo+0cKv?=
 =?us-ascii?Q?js3NA7MAuKc7HwdNWUzITvsh1120ogxFiMHdbzdp9g2UHRCkjI0nzJs2+NuX?=
 =?us-ascii?Q?vnyW9SGlByzyKvoCitflnKYCGRdJbNk8gVe5BIUjGmTzokVHua5mu2hXyKoO?=
 =?us-ascii?Q?kDYZmCbj7Nvco+7A+7NaYNbn4NKtI3e9RURy+iRB1KT79Hpj9AXRBzLEwo11?=
 =?us-ascii?Q?x5mUFmoK5qkeH6NsP1krU0Boq+7e7S+XkVYyj464DSjTr2YIx9CJcx2znn8T?=
 =?us-ascii?Q?yH0Wp8mGzl1swP8qVA9S0GNsqclA9modrBVP1bsBB5c4JtvtGersgUOU+kWO?=
 =?us-ascii?Q?5e79BUwqdKR4xDRv84v8hkFLtwj0wqTibjAJtzSquI3vmGvZyZcQfUNHahSS?=
 =?us-ascii?Q?hI73iHIjeG/rJYITKPu5lvENR3/xy0DQJUs1Ycx1Xu+vPg7U+4jXmXIS6pok?=
 =?us-ascii?Q?rQG0gQGmVXRco05+bzEpL9+F5tYoSvKiqVOYEy/avT544gzH0RTbVzrBDlz4?=
 =?us-ascii?Q?fVuDRZ1i3cH1wZwhuC9A32AWkssfHoy1yjh0dOy3u9UhCo1vUu7TgbNIn8tf?=
 =?us-ascii?Q?pQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	B+YqM0+wJ9eADdfOmB65HghikSQO6SAv8vQgBTvjVz7AefgaRg7vp8CgxVTrHRlLLKZJkX+LGNE4OJEGiEMDgQ9ztwvX/X+uvRgmKzgUo8F4q6eMJWfEdI1y2BBeIbIPjorOjF7RGkTprHGHQRnn3ZzHQtxKpVwd0rCOFUex0l6aUSYi9NIqFuTdYEwCx1CuwNBwAAlzZ3TJEv3bKZKDGaYz/P5xO5W+oYrOcxFY/xn3I8TWJlMgADMoUZflU4tSqtSlEOOk1YZ6whiAyT7/KM4lUVgoDFcrNHXhuW+sLvvwHIWUcKk1Ky+PlnLrey3wQJY+RTN0aPFnxazmGssbXcgfUM4tn6kBKPkbx+Qcrp4ocD5qVzMSSNOy5VC5eSOvxBTZZ2/7VcQ9YbAxdI+STUD2HkpTlrNd4nTKvjGFWyk/edqWTUEJJLm8WrSFFy3XkVQu8qznTYU7/xO11LZmr5DZ/JiytyBxJdLeZ4WNBK4FVBuQZXilRfspkb0RLcZwNtetsy1LjTlYkFHdL0Wv7r/A7PNCGgAhwakAZrWixqAe53RAbjP13IqcSPvblb5Ag5MQTicZwFT30UVq7QDl+lGVq5zmmJzTUZ+GGOUINKM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aebbe52d-33c0-4369-b5ec-08dd02fdee2e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 09:39:40.3418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YkVgkMyLcy+Sg+78ZEX5hmkBko9kb9ZbGgG9UIoMFyAbTlF12VRMsDmOz3rNN6keQ4J0j0YwU4ZOc2svQ/usQIFDLCCim/u94akegWMJjNI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5745
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-11_08,2024-11-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 suspectscore=0 phishscore=0 mlxlogscore=910 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411120078
X-Proofpoint-ORIG-GUID: zTSfY2d-Zuho-hrdY8jZ5nhH4QHvjIWr
X-Proofpoint-GUID: zTSfY2d-Zuho-hrdY8jZ5nhH4QHvjIWr

On Mon, Nov 11, 2024 at 12:55:02PM -0800, Suren Baghdasaryan wrote:
> Back when per-vma locks were introduces, vm_lock was moved out of
> vm_area_struct in [1] because of the performance regression caused by
> false cacheline sharing. Recent investigation [2] revealed that the
> regressions is limited to a rather old Broadwell microarchitecture and
> even there it can be mitigated by disabling adjacent cacheline
> prefetching, see [3].

Sorry to nag + add workload, but could you also add changes to the
Documentation/mm/process_addrs.rst file to reflect this as part of the
series? It'd be really cool to have the change as part of your series, so
when it lands we update the documentation with it.

This change fundamentally changes internals that are documented there so it
makes sense to :)

Thanks!

