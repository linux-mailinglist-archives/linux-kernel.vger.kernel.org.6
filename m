Return-Path: <linux-kernel+bounces-555090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72AA3A5A553
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 21:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 831E6188F554
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 20:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D5A1E1C1F;
	Mon, 10 Mar 2025 20:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eVwVHUsP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LqfXcSL2"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287541DF24F
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 20:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741639911; cv=fail; b=Q9QTN1knRhzhc6g2pTsm8MDE8mOFwgClI5MRwukK27qzqrvxbb76V1VnUwyOGB9PoZ0ouRdkx/RIIxn7POt95o4V3ezxYsS5BOj0bGz8751ryBzmUN8DQ/sBl4QJjhL5ssnGLONjnoc8hcpGp3Qb9oqhXRIqC1bzFB2JjBU7QXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741639911; c=relaxed/simple;
	bh=aIkaR8+wK4Nrrm/h5GyKdX6GQEqcF8qMM6dNBQya5Zs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aq/OtqneTpQ+C+M9tQ/JqxhgOw0dJV9MYJnGqqLVk1QvRFducwf0W5ra/73mf297W2hM4tNTOevFuZbqSrZ94t3g8mREe7CreEXWIpoxXuTSPTLHoAZx50QkmuSNwFwIQADkdxDtiT77kkalRiL5/wC4HYImvTx8inA4c84DI1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eVwVHUsP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LqfXcSL2; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52AJtkMM015556;
	Mon, 10 Mar 2025 20:51:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=KkJ1hYyM1bPxyqbnxzKgf3ulFFMsyMbbAPot2MbGbzQ=; b=
	eVwVHUsPPK146PFVabwCCFX9jKK2I9KTZzcEG7LkUmQBTJ5QIOXUoubNqp5jMYo5
	MnZ1G+Iu2rFHEfXQSA4t2YJRBAXrnj10c7TT/ZGqzNpDGQv3lZOpxdJruuVkHDCG
	RO0WS/T9mKr1aLPnfkY4uMm+hT6x42ujzGSVe+qAYMZdck7gNTJnSgo7DJb0cM5w
	+RHD+y4hTENv2mO28GGawUeiL0v41OU+D0VKHjo0G8HhPGKVr5aVCco3kiJA/jqh
	pqIYD9gll22oF2yHZEp3IOXJ6TIDFzDnZ4mazJ544wg8gN4SJO07Cs13KdV2XEoQ
	CmkyPbhnet/m/NYCadkKNQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 458cg0uke9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Mar 2025 20:51:32 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52AKVsuD019748;
	Mon, 10 Mar 2025 20:51:32 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 458cb84r55-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Mar 2025 20:51:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KsfrPO/QJI6lxhRtl5n7Yf2djhp9V1TyWs370ZmBApI3P/3oq23qqZYEXBE/++MOxcwT6FLCuCOwoVnFgzkRuLG9+ops2QeEyRhXfzRqqjCYz0xVJEirL+wRAdUU2azTnusSWS/7xWJW3lDs9AZjTZJVEJ2daMn8xWxjvujkOT/9DGaijtmCXZbc9Yc67cQhodMMn3zckFHkVulSYp48BBiXDh3GUxjvra7pfpp7ByZ9ID4XWu23FUN6AfZrZwKndZG6vwn5GgvCN+3uAIwg5d1TNqhDsw+Q+GR/SJ4IHd+WsuYpWrfH1X2VAaM54qveVrTQYdj/zsxBr8h1oTHcHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KkJ1hYyM1bPxyqbnxzKgf3ulFFMsyMbbAPot2MbGbzQ=;
 b=tZ6aAePusdVRVEhIuEFYmyvzj5VMXIMNE3yDdpjD2VW2G9RRqqGNisYtykSnVMI5gGt17wKFL9uzf8y7uTlxV+t0FQxVqvCGaQMTEf0jo4tleB8E17C7HXEjl1YHkclx96eV00bIV+sq59/8nW14IQNRTB8+ipOs2cS0ZMyFRYiR8mHxrueI8DmpWtawa54pvhLOwk73caO2RJhB6NNTVHs+JuN9S9BfhdQ1rcyl3A8II9eo7x0rs8uasUue/w9hjmGX+gtw99Uwy5WFH+AtrK8rPcipKvVBUbhfnzyyNbOvrerWk1zKwMJGqnpvaeGY1mAMganFmH0zuYV0OlAoQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KkJ1hYyM1bPxyqbnxzKgf3ulFFMsyMbbAPot2MbGbzQ=;
 b=LqfXcSL2nMd8Q7numuwj7hK4uqvtW+lUBhG6rhY6/C6XXYaduMp2tQCrYkxnxS1htiynI9elC8Ov/QgZioa+BFWYCzzhp69hauPamYuE5J+X02GKFyRQj9k0RJhAatHRwR5kk/QmRi3MAmBI1pslGs8NkGzJtb6eFKN+jHWIxTc=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by DS7PR10MB7250.namprd10.prod.outlook.com (2603:10b6:8:e0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 20:51:29 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.025; Mon, 10 Mar 2025
 20:51:29 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Harry Yoo <harry.yoo@oracle.com>, Yosry Ahmed <yosry.ahmed@linux.dev>,
        Oliver Sang <oliver.sang@intel.com>
Subject: [PATCH v3 3/7] mm/mremap: introduce and use vma_remap_struct threaded state
Date: Mon, 10 Mar 2025 20:50:36 +0000
Message-ID: <27951739dc83b2b1523b81fa9c009ba348388d40.1741639347.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741639347.git.lorenzo.stoakes@oracle.com>
References: <cover.1741639347.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO3P265CA0022.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::13) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|DS7PR10MB7250:EE_
X-MS-Office365-Filtering-Correlation-Id: df31eb2f-2262-432a-aa1b-08dd601554ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ua0T3VBoK+DNc3R9gWHur/GpfGR7ESWZOsjyBPaTzIB+RK3C3O/Yj4Y+jcl7?=
 =?us-ascii?Q?XIjZkQ4gaxP0yRA6jucXnl1GGculmJYSxxBDJ+Z14ez0sOg1P15/sFXatMjO?=
 =?us-ascii?Q?gWBEjuFAE4/64w9CZ7d30W3nEwtj/Ydr9Gz/srvzFIrcpwWp5aKojATBC5L/?=
 =?us-ascii?Q?OALkhBsjBl+/E++bjS7SiMcZ3kcTbuJ8nGQHeOPteJO7PFRHegOKDjEb/7o/?=
 =?us-ascii?Q?mltcy/549btLixBO2uFgvwSI273VyXA2QeGSpPkanx9FrYtQC35kgNnskxUX?=
 =?us-ascii?Q?07tNukm73iRay57dgvV/5ksMTSN43fG5G1WCQ6hH9qST9GQc38P6311JRSC6?=
 =?us-ascii?Q?MI6+hqO3frHepky2M+C5CH7mCxtZmKVxOE+GnyfptvUtkRWdPYxxGFiurtcY?=
 =?us-ascii?Q?vT4igEIt1tPfMXRTFETRoTsSopaBu78v4q+UOLQcb3PgwuCOQT+LQ4uZ/jGN?=
 =?us-ascii?Q?mNh3peusvDdja89nqsTalqg2IxE3c0Td8oxPyHBXbacN6wVOXKZ4Sdj72o8C?=
 =?us-ascii?Q?Qc9pg8lfIh4b/INQki8hpmxUjyHUDQyxYE9WTJoGfSfJSAjsQXV+RO8d/Pgo?=
 =?us-ascii?Q?34taxKLC0cCu9FoWzYW3Xr7neYo+8KVuMK8QM3m6eZmIM7EIShwkp33S0vTs?=
 =?us-ascii?Q?sdlVrXTnfC+0rtNTUKlbRNbTg/Lm70ggXhGTcHi3UTbO4pu495whtK9XqSVj?=
 =?us-ascii?Q?HhAYjs1Lk+kRiLiP4EL1VSuS2kjOyfDroEsB8/aam3AXBciZj31h1T34eBTY?=
 =?us-ascii?Q?LBvE7YqCu7hYfgRygLYuul0fxYcwA/f/DjqJHl9o8mZyRsPqo7pzXd2LBIza?=
 =?us-ascii?Q?hCTNzajDaZNDR/o0oTACLuXq6JAg06HHDZ3+oQbOd625InXz/La5c5T0UJo5?=
 =?us-ascii?Q?g1rO7Z5IXR9GFoj2zKetHATvEPalfOwEdli+SVtH8X++6Ox1BXw35qcUKYbQ?=
 =?us-ascii?Q?+T6G46X+eIrLsBb74sN1AYtubKQfaAEteKudDSs2UC6+wNHMs7IsJOl+Phoj?=
 =?us-ascii?Q?+oEJ7ouaNDunb5cFQjuukrI55jM+dX5o80xqwmXkNmnIz5OBdyXxMj6UNali?=
 =?us-ascii?Q?HKWCx1Bo7WcxD73NhKsipWdMF6Xi4hDs8T4xR8xjKUAsfakSDwCN24V9eZNZ?=
 =?us-ascii?Q?S9zkVZ5PAmoK0ncFveOQi9LMJkrHHmvZJ9rXAPvQ+rfB82oWqRXRRoBqk7iP?=
 =?us-ascii?Q?r0hzSKaAZpdechiJD0vsl54yR6EPbf2c598Aj3vH86KMaHoW7Wuo/UXH6hC4?=
 =?us-ascii?Q?w7TM3jLbezfezzZETurIGFjDEqNhRC5t6Cm4Ts+mpoPXhWJxsnigABf9pDLo?=
 =?us-ascii?Q?wNKwxuzrB9s4y/sl3KX4lNBSgY1/YBKjOmtRr0omh/EygIkMoqDqFZM/ibtv?=
 =?us-ascii?Q?UyOfGt1hra+VWLxeURVH/JZlzloA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NxtBaqCgGhEb0yFjbhgWbbiF08wmxUQcvw+Mta7ppgnBUsd6FnprXyNjXyaO?=
 =?us-ascii?Q?GOu9q0zawUS2lX2+XjmcAUZbXUZS3nA8y5xVQ2Y4bUAwdVCbIoSYBGNmemBJ?=
 =?us-ascii?Q?2B+t0NshH23kc1FcsBCD32Rm6ufmuV6TAXTpySyNYEjTBm3Huow2UHzBcocu?=
 =?us-ascii?Q?UAp0FBciEXnOxXF9ezqlBLhCLF2yeYk7O6CNlJ9uovyIbbme4Ib3tslTq7RO?=
 =?us-ascii?Q?OnpPz4Q+1qYCcb0o5nUlTEp1nbcCtgbnzSxW9cATaWjbwiBVVgkUhJT1r/TH?=
 =?us-ascii?Q?FeW7zjTMRyXB8Dh4CZPD/UM6i/KyKy6LeweDnxHAHemT+vmTLMa35lIRp3ks?=
 =?us-ascii?Q?skWMcyZOC+rgQ+H3L4THJw9PMwld9e/duqMg4eztnyKcq6UAohsyMFwO9Ioc?=
 =?us-ascii?Q?46RwcHuX8mbAMO951vm9VplZVbNYOB8d7Nqp5H0B3wYPJ+NPax615/a86mWZ?=
 =?us-ascii?Q?rtkxHxHVQtlSafywV8NWeERIxCNlf2RqpPGfQlD8cfpQ3zx6J1ATIwNEm+81?=
 =?us-ascii?Q?SQVbBXAg2jRiBBBvlEWJOmSZqMDVqYhM33Pfj6OGxON/IFL7mfFtM6i7m4SL?=
 =?us-ascii?Q?iK3gnyMSa8oMZ/Wp3WkdVi5tFFfTfHxMvaYcJZQL+dobgtaJAXHVK0u80g07?=
 =?us-ascii?Q?9mwLC2yFBsKFtPD2KdugJIfQM93Q7CsmNCH5NEmezlRmV5xw677ldJwcC2GT?=
 =?us-ascii?Q?J5WYskVl7RPjO0Ns7VxvsJfi6/xK6XVV2wBNnpTkMBogWY/W9avuMJXfRQ46?=
 =?us-ascii?Q?kyc2CVKuPacAo/6cURGfgtvdACHGaBtuNhxHVWLkigycjr3az0Lk/6TnjImO?=
 =?us-ascii?Q?ltEmml+a6TZPaANdLko6zkSNrTuD6MjoZRQDWD/0SjCG7B7aX27SN7iXjfUJ?=
 =?us-ascii?Q?wIEKlIbRiPktI5tMpBlNBO+wp3XpuswiPnJgLoI9wJmugp1v0HWbDb309g/o?=
 =?us-ascii?Q?4Ntaw8FKbSAYjohg3WhEaWpJr6Yxtod+s5LlZYqaNT/fGHlwhG186vmHj7+X?=
 =?us-ascii?Q?1m74rRFa+8LMbHPt90ECjQTU4CWK/FS556J8yflYmdgk1GyB6diPd7ZHZlUb?=
 =?us-ascii?Q?9oiS6H0N/izbeyNzPdfu6Lf0VIXDp3vyeBxEXGQVJtyOKxSOsG8JlSknmZ6K?=
 =?us-ascii?Q?+fneMOSopb03p8Yy4OyqEg1W7nkmjpO7WIfk1gzeRgDUA3TQC5MIsdHa3nga?=
 =?us-ascii?Q?2SbaqoPvoroIfRowV8ZISfDvBkFBWUN5+L19p0w5gx4d0YXU7A5QSdajRRCU?=
 =?us-ascii?Q?VIwnPFK9+kgA2Px90nyZUNIlG85Ytr6z0saiml7XF2yAgeHRUm5LHnOWkGnH?=
 =?us-ascii?Q?FWJ0SpUibE4/Nm1w5qELi3i5k6JeDYL/DQPnYdBxRH+W2TRcmokaXoWJgrDX?=
 =?us-ascii?Q?NH+Sh6Nk5mvNfB2n9jFZKgcSxRGxy+JLXPhhbKISlpW5SO637BwWFYLZfrLl?=
 =?us-ascii?Q?Xn9rY+YpKHXY4J337smkzLSmj/dcwn+MOfKLDYFp/7vO+nl4RUj6uZlyQjos?=
 =?us-ascii?Q?406VJvtmHzQvk5KX6zpGudiy/ZC/ZUC2bdZkKHbgZDcIurXsxdOZpoIaEwqv?=
 =?us-ascii?Q?VFeqpsLNq0xjgTkqAh5uylUQER2C+/cT42FODW1U44K2QnYpnIfPwTnTziA0?=
 =?us-ascii?Q?sg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9+DaJ8G+VUbMlKA4HVEMs7ORjTCxHEcjNiv8dZMsXMI+2msWmEwlvOXfnHE6FiejGgMukZrYA1sbXMPie+EKWiBMS0CENJfwqmQKyUBA9JgC8ufd6avrucCMoivArIGFb4ApAdVgz2RyeCifzvQpr5tuJm7tQ3JCnHzaox9nuA6n70pSF10kf0kSFB72cCVmwn24YrjugTHHKZ3TSjIg/WMgd+bs+ZMIERH+D19OXFpOL/asFDlzFpOV0LXnrKVRDdvczMxuU38LwUIWHxq3gAR2eT4iA2zB622BnFUoZiDdB4mnwFADqy3vFlDk3qovZ+2stpeQ0C/WQeFtmO5H9HtZ3JClLeWkD7S2HABDUyD/ip2Q6gIyX6Y1ypKAQOvQFrO2xb9ixqD8yJjDmSrtps1zMFqXR9GFzjEhw0mSpe7e4QYQbOfpI3f/k/fNBl0MMuWh2JL7ARCuHoK0Nq5G7jcBYcTtYORtLiiXRN2I/fVbrcb1Mg7xI5+itJeoM1OnkoN/Csq/j2lpQ6T1xvAK9eeEyQNdCwOA/Gcy2GcSULf1oH60zDqkHOXAoJScYHpvEO+miJrCdkOVlFUHyvUgczhl8hDJzudSoXbJ2Ogbyv4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df31eb2f-2262-432a-aa1b-08dd601554ef
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 20:51:29.7793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BFdBH2WGWRuxkcCRYA3cFtlxGwv+uY31NVXf33fGnE2qNRAG/JsKOko+JSqXRk40Qvm63jPQ1ArVxDJW9rcdw2jW3HJBvBNW9jCPYhVEnyg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7250
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-10_08,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 adultscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2503100159
X-Proofpoint-GUID: EeHnw_yiJYHUr4N8DfOmFup4xnBX9ZZu
X-Proofpoint-ORIG-GUID: EeHnw_yiJYHUr4N8DfOmFup4xnBX9ZZu

A number of mremap() calls both pass around and modify a large number of
parameters, making the code less readable and often repeatedly having to
determine things such as VMA, size delta, and more.

Avoid this by using the common pattern of passing a state object through
the operation, updating it as we go.  We introduce the vma_remap_struct or
'VRM' for this purpose.

This also gives us the ability to accumulate further state through the
operation that would otherwise require awkward and error-prone pointer
passing.

We can also now trivially define helper functions that operate on a VRM
object.

This pattern has proven itself to be very powerful when implemented for
VMA merge, VMA unmapping and memory mapping operations, so it is
battle-tested and functional.

We both introduce the data structure and use it, introducing helper
functions as needed to make things readable, we move some state such as
mmap lock and mlock() status to the VRM, we introduce a means of
classifying the type of mremap() operation and de-duplicate the
get_unmapped_area() lookup.

We also neatly thread userfaultfd state throughout the operation.

Note that there is further refactoring to be done, chiefly adjust
move_vma() to accept a VRM parameter.  We defer this as there is
pre-requisite work required to be able to do so which we will do in a
subsequent patch.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/mremap.c | 570 +++++++++++++++++++++++++++++++++-------------------
 1 file changed, 363 insertions(+), 207 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index c4abda8dfc57..af022e3b89e2 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -32,6 +32,44 @@
 
 #include "internal.h"
 
+/* Classify the kind of remap operation being performed. */
+enum mremap_type {
+	MREMAP_INVALID,		/* Initial state. */
+	MREMAP_NO_RESIZE,	/* old_len == new_len, if not moved, do nothing. */
+	MREMAP_SHRINK,		/* old_len > new_len. */
+	MREMAP_EXPAND,		/* old_len < new_len. */
+};
+
+/*
+ * Describes a VMA mremap() operation and is threaded throughout it.
+ *
+ * Any of the fields may be mutated by the operation, however these values will
+ * always accurately reflect the remap (for instance, we may adjust lengths and
+ * delta to account for hugetlb alignment).
+ */
+struct vma_remap_struct {
+	/* User-provided state. */
+	unsigned long addr;	/* User-specified address from which we remap. */
+	unsigned long old_len;	/* Length of range being remapped. */
+	unsigned long new_len;	/* Desired new length of mapping. */
+	unsigned long flags;	/* user-specified MREMAP_* flags. */
+	unsigned long new_addr;	/* Optionally, desired new address. */
+
+	/* uffd state. */
+	struct vm_userfaultfd_ctx *uf;
+	struct list_head *uf_unmap_early;
+	struct list_head *uf_unmap;
+
+	/* VMA state, determined in do_mremap(). */
+	struct vm_area_struct *vma;
+
+	/* Internal state, determined in do_mremap(). */
+	unsigned long delta;		/* Absolute delta of old_len,new_len. */
+	bool mlocked;			/* Was the VMA mlock()'d? */
+	enum mremap_type remap_type;	/* expand, shrink, etc. */
+	bool mmap_locked;		/* Is mm currently write-locked? */
+};
+
 static pud_t *get_old_pud(struct mm_struct *mm, unsigned long addr)
 {
 	pgd_t *pgd;
@@ -693,10 +731,95 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
 	return len + old_addr - old_end;	/* how much done */
 }
 
+/* Set vrm->delta to the difference in VMA size specified by user. */
+static void vrm_set_delta(struct vma_remap_struct *vrm)
+{
+	vrm->delta = abs_diff(vrm->old_len, vrm->new_len);
+}
+
+/* Determine what kind of remap this is - shrink, expand or no resize at all. */
+static enum mremap_type vrm_remap_type(struct vma_remap_struct *vrm)
+{
+	if (vrm->delta == 0)
+		return MREMAP_NO_RESIZE;
+
+	if (vrm->old_len > vrm->new_len)
+		return MREMAP_SHRINK;
+
+	return MREMAP_EXPAND;
+}
+
+/*
+ * When moving a VMA to vrm->new_adr, does this result in the new and old VMAs
+ * overlapping?
+ */
+static bool vrm_overlaps(struct vma_remap_struct *vrm)
+{
+	unsigned long start_old = vrm->addr;
+	unsigned long start_new = vrm->new_addr;
+	unsigned long end_old = vrm->addr + vrm->old_len;
+	unsigned long end_new = vrm->new_addr + vrm->new_len;
+
+	/*
+	 * start_old    end_old
+	 *     |-----------|
+	 *     |           |
+	 *     |-----------|
+	 *             |-------------|
+	 *             |             |
+	 *             |-------------|
+	 *         start_new      end_new
+	 */
+	if (end_old > start_new && end_new > start_old)
+		return true;
+
+	return false;
+}
+
+/* Do the mremap() flags require that the new_addr parameter be specified? */
+static bool vrm_implies_new_addr(struct vma_remap_struct *vrm)
+{
+	return vrm->flags & (MREMAP_FIXED | MREMAP_DONTUNMAP);
+}
+
+/*
+ * Find an unmapped area for the requested vrm->new_addr.
+ *
+ * If MREMAP_FIXED then this is equivalent to a MAP_FIXED mmap() call. If only
+ * MREMAP_DONTUNMAP is set, then this is equivalent to providing a hint to
+ * mmap(), otherwise this is equivalent to mmap() specifying a NULL address.
+ *
+ * Returns 0 on success (with vrm->new_addr updated), or an error code upon
+ * failure.
+ */
+static unsigned long vrm_set_new_addr(struct vma_remap_struct *vrm)
+{
+	struct vm_area_struct *vma = vrm->vma;
+	unsigned long map_flags = 0;
+	/* Page Offset _into_ the VMA. */
+	pgoff_t internal_pgoff = (vrm->addr - vma->vm_start) >> PAGE_SHIFT;
+	pgoff_t pgoff = vma->vm_pgoff + internal_pgoff;
+	unsigned long new_addr = vrm_implies_new_addr(vrm) ? vrm->new_addr : 0;
+	unsigned long res;
+
+	if (vrm->flags & MREMAP_FIXED)
+		map_flags |= MAP_FIXED;
+	if (vma->vm_flags & VM_MAYSHARE)
+		map_flags |= MAP_SHARED;
+
+	res = get_unmapped_area(vma->vm_file, new_addr, vrm->new_len, pgoff,
+				map_flags);
+	if (IS_ERR_VALUE(res))
+		return res;
+
+	vrm->new_addr = res;
+	return 0;
+}
+
 static unsigned long move_vma(struct vm_area_struct *vma,
 		unsigned long old_addr, unsigned long old_len,
 		unsigned long new_len, unsigned long new_addr,
-		bool *locked, unsigned long flags,
+		bool *mlocked, unsigned long flags,
 		struct vm_userfaultfd_ctx *uf, struct list_head *uf_unmap)
 {
 	long to_account = new_len - old_len;
@@ -837,7 +960,7 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 
 	if (vm_flags & VM_LOCKED) {
 		mm->locked_vm += new_len >> PAGE_SHIFT;
-		*locked = true;
+		*mlocked = true;
 	}
 
 	mm->hiwater_vm = hiwater_vm;
@@ -860,18 +983,15 @@ static unsigned long move_vma(struct vm_area_struct *vma,
  * resize_is_valid() - Ensure the vma can be resized to the new length at the give
  * address.
  *
- * @vma: The vma to resize
- * @addr: The old address
- * @old_len: The current size
- * @new_len: The desired size
- * @flags: The vma flags
- *
  * Return 0 on success, error otherwise.
  */
-static int resize_is_valid(struct vm_area_struct *vma, unsigned long addr,
-	unsigned long old_len, unsigned long new_len, unsigned long flags)
+static int resize_is_valid(struct vma_remap_struct *vrm)
 {
 	struct mm_struct *mm = current->mm;
+	struct vm_area_struct *vma = vrm->vma;
+	unsigned long addr = vrm->addr;
+	unsigned long old_len = vrm->old_len;
+	unsigned long new_len = vrm->new_len;
 	unsigned long pgoff;
 
 	/*
@@ -883,11 +1003,12 @@ static int resize_is_valid(struct vm_area_struct *vma, unsigned long addr,
 	 * behavior.  As a result, fail such attempts.
 	 */
 	if (!old_len && !(vma->vm_flags & (VM_SHARED | VM_MAYSHARE))) {
-		pr_warn_once("%s (%d): attempted to duplicate a private mapping with mremap.  This is not supported.\n", current->comm, current->pid);
+		pr_warn_once("%s (%d): attempted to duplicate a private mapping with mremap.  This is not supported.\n",
+			     current->comm, current->pid);
 		return -EINVAL;
 	}
 
-	if ((flags & MREMAP_DONTUNMAP) &&
+	if ((vrm->flags & MREMAP_DONTUNMAP) &&
 			(vma->vm_flags & (VM_DONTEXPAND | VM_PFNMAP)))
 		return -EINVAL;
 
@@ -907,99 +1028,122 @@ static int resize_is_valid(struct vm_area_struct *vma, unsigned long addr,
 	if (vma->vm_flags & (VM_DONTEXPAND | VM_PFNMAP))
 		return -EFAULT;
 
-	if (!mlock_future_ok(mm, vma->vm_flags, new_len - old_len))
+	if (!mlock_future_ok(mm, vma->vm_flags, vrm->delta))
 		return -EAGAIN;
 
-	if (!may_expand_vm(mm, vma->vm_flags,
-				(new_len - old_len) >> PAGE_SHIFT))
+	if (!may_expand_vm(mm, vma->vm_flags, vrm->delta >> PAGE_SHIFT))
 		return -ENOMEM;
 
 	return 0;
 }
 
 /*
- * mremap_to() - remap a vma to a new location
- * @addr: The old address
- * @old_len: The old size
- * @new_addr: The target address
- * @new_len: The new size
- * @locked: If the returned vma is locked (VM_LOCKED)
- * @flags: the mremap flags
- * @uf: The mremap userfaultfd context
- * @uf_unmap_early: The userfaultfd unmap early context
- * @uf_unmap: The userfaultfd unmap context
+ * The user has requested that the VMA be shrunk (i.e., old_len > new_len), so
+ * execute this, optionally dropping the mmap lock when we do so.
  *
+ * In both cases this invalidates the VMA, however if we don't drop the lock,
+ * then load the correct VMA into vrm->vma afterwards.
+ */
+static unsigned long shrink_vma(struct vma_remap_struct *vrm,
+				bool drop_lock)
+{
+	struct mm_struct *mm = current->mm;
+	unsigned long unmap_start = vrm->addr + vrm->new_len;
+	unsigned long unmap_bytes = vrm->delta;
+	unsigned long res;
+	VMA_ITERATOR(vmi, mm, unmap_start);
+
+	VM_BUG_ON(vrm->remap_type != MREMAP_SHRINK);
+
+	res = do_vmi_munmap(&vmi, mm, unmap_start, unmap_bytes,
+			    vrm->uf_unmap, drop_lock);
+	vrm->vma = NULL; /* Invalidated. */
+	if (res)
+		return res;
+
+	/*
+	 * If we've not dropped the lock, then we should reload the VMA to
+	 * replace the invalidated VMA with the one that may have now been
+	 * split.
+	 */
+	if (drop_lock) {
+		vrm->mmap_locked = false;
+	} else {
+		vrm->vma = vma_lookup(mm, vrm->addr);
+		if (!vrm->vma)
+			return -EFAULT;
+	}
+
+	return 0;
+}
+
+/*
+ * mremap_to() - remap a vma to a new location.
  * Returns: The new address of the vma or an error.
  */
-static unsigned long mremap_to(unsigned long addr, unsigned long old_len,
-		unsigned long new_addr, unsigned long new_len, bool *locked,
-		unsigned long flags, struct vm_userfaultfd_ctx *uf,
-		struct list_head *uf_unmap_early,
-		struct list_head *uf_unmap)
+static unsigned long mremap_to(struct vma_remap_struct *vrm)
 {
 	struct mm_struct *mm = current->mm;
-	struct vm_area_struct *vma;
-	unsigned long ret;
-	unsigned long map_flags = 0;
+	unsigned long err;
 
 	/* Is the new length or address silly? */
-	if (new_len > TASK_SIZE || new_addr > TASK_SIZE - new_len)
+	if (vrm->new_len > TASK_SIZE ||
+	    vrm->new_addr > TASK_SIZE - vrm->new_len)
 		return -EINVAL;
 
-	/* Ensure the old/new locations do not overlap. */
-	if (addr + old_len > new_addr && new_addr + new_len > addr)
+	if (vrm_overlaps(vrm))
 		return -EINVAL;
 
-	if (flags & MREMAP_FIXED) {
+	if (vrm->flags & MREMAP_FIXED) {
 		/*
 		 * In mremap_to().
 		 * VMA is moved to dst address, and munmap dst first.
 		 * do_munmap will check if dst is sealed.
 		 */
-		ret = do_munmap(mm, new_addr, new_len, uf_unmap_early);
-		if (ret)
-			return ret;
-	}
+		err = do_munmap(mm, vrm->new_addr, vrm->new_len,
+				vrm->uf_unmap_early);
+		vrm->vma = NULL; /* Invalidated. */
+		if (err)
+			return err;
 
-	if (old_len > new_len) {
-		ret = do_munmap(mm, addr+new_len, old_len - new_len, uf_unmap);
-		if (ret)
-			return ret;
-		old_len = new_len;
+		/*
+		 * If we remap a portion of a VMA elsewhere in the same VMA,
+		 * this can invalidate the old VMA. Reset.
+		 */
+		vrm->vma = vma_lookup(mm, vrm->addr);
+		if (!vrm->vma)
+			return -EFAULT;
 	}
 
-	vma = vma_lookup(mm, addr);
-	if (!vma)
-		return -EFAULT;
-
-	ret = resize_is_valid(vma, addr, old_len, new_len, flags);
-	if (ret)
-		return ret;
+	if (vrm->remap_type == MREMAP_SHRINK) {
+		err = shrink_vma(vrm, /* drop_lock= */false);
+		if (err)
+			return err;
 
-	/* MREMAP_DONTUNMAP expands by old_len since old_len == new_len */
-	if (flags & MREMAP_DONTUNMAP &&
-		!may_expand_vm(mm, vma->vm_flags, old_len >> PAGE_SHIFT)) {
-		return -ENOMEM;
+		/* Set up for the move now shrink has been executed. */
+		vrm->old_len = vrm->new_len;
 	}
 
-	if (flags & MREMAP_FIXED)
-		map_flags |= MAP_FIXED;
+	err = resize_is_valid(vrm);
+	if (err)
+		return err;
 
-	if (vma->vm_flags & VM_MAYSHARE)
-		map_flags |= MAP_SHARED;
+	/* MREMAP_DONTUNMAP expands by old_len since old_len == new_len */
+	if (vrm->flags & MREMAP_DONTUNMAP) {
+		vm_flags_t vm_flags = vrm->vma->vm_flags;
+		unsigned long pages = vrm->old_len >> PAGE_SHIFT;
 
-	ret = get_unmapped_area(vma->vm_file, new_addr, new_len, vma->vm_pgoff +
-				((addr - vma->vm_start) >> PAGE_SHIFT),
-				map_flags);
-	if (IS_ERR_VALUE(ret))
-		return ret;
+		if (!may_expand_vm(mm, vm_flags, pages))
+			return -ENOMEM;
+	}
 
-	/* We got a new mapping */
-	if (!(flags & MREMAP_FIXED))
-		new_addr = ret;
+	err = vrm_set_new_addr(vrm);
+	if (err)
+		return err;
 
-	return move_vma(vma, addr, old_len, new_len, new_addr, locked, flags,
-			uf, uf_unmap);
+	return move_vma(vrm->vma, vrm->addr, vrm->old_len, vrm->new_len,
+			vrm->new_addr, &vrm->mlocked, vrm->flags,
+			vrm->uf, vrm->uf_unmap);
 }
 
 static int vma_expandable(struct vm_area_struct *vma, unsigned long delta)
@@ -1016,22 +1160,33 @@ static int vma_expandable(struct vm_area_struct *vma, unsigned long delta)
 	return 1;
 }
 
-/* Do the mremap() flags require that the new_addr parameter be specified? */
-static bool implies_new_addr(unsigned long flags)
+/* Determine whether we are actually able to execute an in-place expansion. */
+static bool vrm_can_expand_in_place(struct vma_remap_struct *vrm)
 {
-	return flags & (MREMAP_FIXED | MREMAP_DONTUNMAP);
+	/* Number of bytes from vrm->addr to end of VMA. */
+	unsigned long suffix_bytes = vrm->vma->vm_end - vrm->addr;
+
+	/* If end of range aligns to end of VMA, we can just expand in-place. */
+	if (suffix_bytes != vrm->old_len)
+		return false;
+
+	/* Check whether this is feasible. */
+	if (!vma_expandable(vrm->vma, vrm->delta))
+		return false;
+
+	return true;
 }
 
 /*
  * Are the parameters passed to mremap() valid? If so return 0, otherwise return
  * error.
  */
-static unsigned long check_mremap_params(unsigned long addr,
-					 unsigned long flags,
-					 unsigned long old_len,
-					 unsigned long new_len,
-					 unsigned long new_addr)
+static unsigned long check_mremap_params(struct vma_remap_struct *vrm)
+
 {
+	unsigned long addr = vrm->addr;
+	unsigned long flags = vrm->flags;
+
 	/* Ensure no unexpected flag values. */
 	if (flags & ~(MREMAP_FIXED | MREMAP_MAYMOVE | MREMAP_DONTUNMAP))
 		return -EINVAL;
@@ -1045,15 +1200,15 @@ static unsigned long check_mremap_params(unsigned long addr,
 	 * for DOS-emu "duplicate shm area" thing. But
 	 * a zero new-len is nonsensical.
 	 */
-	if (!PAGE_ALIGN(new_len))
+	if (!PAGE_ALIGN(vrm->new_len))
 		return -EINVAL;
 
 	/* Remainder of checks are for cases with specific new_addr. */
-	if (!implies_new_addr(flags))
+	if (!vrm_implies_new_addr(vrm))
 		return 0;
 
 	/* The new address must be page-aligned. */
-	if (offset_in_page(new_addr))
+	if (offset_in_page(vrm->new_addr))
 		return -EINVAL;
 
 	/* A fixed address implies a move. */
@@ -1061,7 +1216,7 @@ static unsigned long check_mremap_params(unsigned long addr,
 		return -EINVAL;
 
 	/* MREMAP_DONTUNMAP does not allow resizing in the process. */
-	if (flags & MREMAP_DONTUNMAP && old_len != new_len)
+	if (flags & MREMAP_DONTUNMAP && vrm->old_len != vrm->new_len)
 		return -EINVAL;
 
 	/*
@@ -1090,11 +1245,11 @@ static unsigned long check_mremap_params(unsigned long addr,
  * If we discover the VMA is locked, update mm_struct statistics accordingly and
  * indicate so to the caller.
  */
-static unsigned long expand_vma_inplace(struct vm_area_struct *vma,
-					unsigned long delta, bool *locked)
+static unsigned long expand_vma_in_place(struct vma_remap_struct *vrm)
 {
 	struct mm_struct *mm = current->mm;
-	long pages = delta >> PAGE_SHIFT;
+	long pages = vrm->delta >> PAGE_SHIFT;
+	struct vm_area_struct *vma = vrm->vma;
 	VMA_ITERATOR(vmi, mm, vma->vm_end);
 	long charged = 0;
 
@@ -1114,7 +1269,7 @@ static unsigned long expand_vma_inplace(struct vm_area_struct *vma,
 	 * adjacent to the expanded vma and otherwise
 	 * compatible.
 	 */
-	vma = vma_merge_extend(&vmi, vma, delta);
+	vma = vrm->vma = vma_merge_extend(&vmi, vma, vrm->delta);
 	if (!vma) {
 		vm_unacct_memory(charged);
 		return -ENOMEM;
@@ -1123,42 +1278,34 @@ static unsigned long expand_vma_inplace(struct vm_area_struct *vma,
 	vm_stat_account(mm, vma->vm_flags, pages);
 	if (vma->vm_flags & VM_LOCKED) {
 		mm->locked_vm += pages;
-		*locked = true;
+		vrm->mlocked = true;
 	}
 
 	return 0;
 }
 
-static bool align_hugetlb(struct vm_area_struct *vma,
-			  unsigned long addr,
-			  unsigned long new_addr,
-			  unsigned long *old_len_ptr,
-			  unsigned long *new_len_ptr,
-			  unsigned long *delta_ptr)
+static bool align_hugetlb(struct vma_remap_struct *vrm)
 {
-	unsigned long old_len = *old_len_ptr;
-	unsigned long new_len = *new_len_ptr;
-	struct hstate *h __maybe_unused = hstate_vma(vma);
+	struct hstate *h __maybe_unused = hstate_vma(vrm->vma);
 
-	old_len = ALIGN(old_len, huge_page_size(h));
-	new_len = ALIGN(new_len, huge_page_size(h));
+	vrm->old_len = ALIGN(vrm->old_len, huge_page_size(h));
+	vrm->new_len = ALIGN(vrm->new_len, huge_page_size(h));
 
 	/* addrs must be huge page aligned */
-	if (addr & ~huge_page_mask(h))
+	if (vrm->addr & ~huge_page_mask(h))
 		return false;
-	if (new_addr & ~huge_page_mask(h))
+	if (vrm->new_addr & ~huge_page_mask(h))
 		return false;
 
 	/*
 	 * Don't allow remap expansion, because the underlying hugetlb
 	 * reservation is not yet capable to handle split reservation.
 	 */
-	if (new_len > old_len)
+	if (vrm->new_len > vrm->old_len)
 		return false;
 
-	*old_len_ptr = old_len;
-	*new_len_ptr = new_len;
-	*delta_ptr = abs_diff(old_len, new_len);
+	vrm_set_delta(vrm);
+
 	return true;
 }
 
@@ -1169,19 +1316,16 @@ static bool align_hugetlb(struct vm_area_struct *vma,
  * Try to do so in-place, if this fails, then move the VMA to a new location to
  * action the change.
  */
-static unsigned long expand_vma(struct vm_area_struct *vma,
-				unsigned long addr, unsigned long old_len,
-				unsigned long new_len, unsigned long flags,
-				bool *locked_ptr, unsigned long *new_addr_ptr,
-				struct vm_userfaultfd_ctx *uf_ptr,
-				struct list_head *uf_unmap_ptr)
+static unsigned long expand_vma(struct vma_remap_struct *vrm)
 {
 	unsigned long err;
-	unsigned long map_flags;
-	unsigned long new_addr; /* We ignore any user-supplied one. */
-	pgoff_t pgoff;
+	struct vm_area_struct *vma = vrm->vma;
+	unsigned long addr = vrm->addr;
+	unsigned long old_len = vrm->old_len;
+	unsigned long new_len = vrm->new_len;
+	unsigned long flags = vrm->flags;
 
-	err = resize_is_valid(vma, addr, old_len, new_len, flags);
+	err = resize_is_valid(vrm);
 	if (err)
 		return err;
 
@@ -1189,10 +1333,9 @@ static unsigned long expand_vma(struct vm_area_struct *vma,
 	 * [addr, old_len) spans precisely to the end of the VMA, so try to
 	 * expand it in-place.
 	 */
-	if (old_len == vma->vm_end - addr &&
-	    vma_expandable(vma, new_len - old_len)) {
-		err = expand_vma_inplace(vma, new_len - old_len, locked_ptr);
-		if (IS_ERR_VALUE(err))
+	if (vrm_can_expand_in_place(vrm)) {
+		err = expand_vma_in_place(vrm);
+		if (err)
 			return err;
 
 		/*
@@ -1200,8 +1343,8 @@ static unsigned long expand_vma(struct vm_area_struct *vma,
 		 * satisfy the expectation that mlock()'ing a VMA maintains all
 		 * of its pages in memory.
 		 */
-		if (*locked_ptr)
-			*new_addr_ptr = addr;
+		if (vrm->mlocked)
+			vrm->new_addr = addr;
 
 		/* OK we're done! */
 		return addr;
@@ -1217,62 +1360,67 @@ static unsigned long expand_vma(struct vm_area_struct *vma,
 		return -ENOMEM;
 
 	/* Find a new location to move the VMA to. */
-	map_flags = (vma->vm_flags & VM_MAYSHARE) ? MAP_SHARED : 0;
-	pgoff = vma->vm_pgoff + ((addr - vma->vm_start) >> PAGE_SHIFT);
-	new_addr = get_unmapped_area(vma->vm_file, 0, new_len, pgoff, map_flags);
-	if (IS_ERR_VALUE(new_addr))
-		return new_addr;
-	*new_addr_ptr = new_addr;
+	err = vrm_set_new_addr(vrm);
+	if (err)
+		return err;
 
-	return move_vma(vma, addr, old_len, new_len, new_addr,
-			locked_ptr, flags, uf_ptr, uf_unmap_ptr);
+	return move_vma(vma, addr, old_len, new_len, vrm->new_addr,
+			&vrm->mlocked, flags, vrm->uf, vrm->uf_unmap);
 }
 
 /*
- * Expand (or shrink) an existing mapping, potentially moving it at the
- * same time (controlled by the MREMAP_MAYMOVE flag and available VM space)
- *
- * MREMAP_FIXED option added 5-Dec-1999 by Benjamin LaHaise
- * This option implies MREMAP_MAYMOVE.
+ * Attempt to resize the VMA in-place, if we cannot, then move the VMA to the
+ * first available address to perform the operation.
  */
-SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
-		unsigned long, new_len, unsigned long, flags,
-		unsigned long, new_addr)
+static unsigned long mremap_at(struct vma_remap_struct *vrm)
+{
+	unsigned long res;
+
+	switch (vrm->remap_type) {
+	case MREMAP_INVALID:
+		break;
+	case MREMAP_NO_RESIZE:
+		/* NO-OP CASE - resizing to the same size. */
+		return vrm->addr;
+	case MREMAP_SHRINK:
+		/*
+		 * SHRINK CASE. Can always be done in-place.
+		 *
+		 * Simply unmap the shrunken portion of the VMA. This does all
+		 * the needed commit accounting, and we indicate that the mmap
+		 * lock should be dropped.
+		 */
+		res = shrink_vma(vrm, /* drop_lock= */true);
+		if (res)
+			return res;
+
+		return vrm->addr;
+	case MREMAP_EXPAND:
+		return expand_vma(vrm);
+	}
+
+	BUG();
+}
+
+static unsigned long do_mremap(struct vma_remap_struct *vrm)
 {
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
 	unsigned long ret;
-	unsigned long delta;
-	bool locked = false;
-	struct vm_userfaultfd_ctx uf = NULL_VM_UFFD_CTX;
-	LIST_HEAD(uf_unmap_early);
-	LIST_HEAD(uf_unmap);
-
-	/*
-	 * There is a deliberate asymmetry here: we strip the pointer tag
-	 * from the old address but leave the new address alone. This is
-	 * for consistency with mmap(), where we prevent the creation of
-	 * aliasing mappings in userspace by leaving the tag bits of the
-	 * mapping address intact. A non-zero tag will cause the subsequent
-	 * range checks to reject the address as invalid.
-	 *
-	 * See Documentation/arch/arm64/tagged-address-abi.rst for more
-	 * information.
-	 */
-	addr = untagged_addr(addr);
 
-	ret = check_mremap_params(addr, flags, old_len, new_len, new_addr);
+	ret = check_mremap_params(vrm);
 	if (ret)
 		return ret;
 
-	old_len = PAGE_ALIGN(old_len);
-	new_len = PAGE_ALIGN(new_len);
-	delta = abs_diff(old_len, new_len);
+	vrm->old_len = PAGE_ALIGN(vrm->old_len);
+	vrm->new_len = PAGE_ALIGN(vrm->new_len);
+	vrm_set_delta(vrm);
 
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;
+	vrm->mmap_locked = true;
 
-	vma = vma_lookup(mm, addr);
+	vma = vrm->vma = vma_lookup(mm, vrm->addr);
 	if (!vma) {
 		ret = -EFAULT;
 		goto out;
@@ -1285,62 +1433,70 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
 	}
 
 	/* Align to hugetlb page size, if required. */
-	if (is_vm_hugetlb_page(vma) &&
-	    !align_hugetlb(vma, addr, new_addr, &old_len, &new_len, &delta)) {
+	if (is_vm_hugetlb_page(vma) && !align_hugetlb(vrm)) {
 		ret = -EINVAL;
 		goto out;
 	}
 
-	/* Are we RELOCATING the VMA to a SPECIFIC address? */
-	if (implies_new_addr(flags)) {
-		ret = mremap_to(addr, old_len, new_addr, new_len,
-				&locked, flags, &uf, &uf_unmap_early,
-				&uf_unmap);
-		goto out;
-	}
-
-	/*
-	 * From here on in we are only RESIZING the VMA, attempting to do so
-	 * in-place, moving the VMA if we cannot.
-	 */
+	vrm->remap_type = vrm_remap_type(vrm);
 
-	/* NO-OP CASE - resizing to the same size. */
-	if (new_len == old_len) {
-		ret = addr;
-		goto out;
-	}
+	/* Actually execute mremap. */
+	ret = vrm_implies_new_addr(vrm) ? mremap_to(vrm) : mremap_at(vrm);
 
-	/* SHRINK CASE. Can always be done in-place. */
-	if (new_len < old_len) {
-		VMA_ITERATOR(vmi, mm, addr + new_len);
+out:
+	if (vrm->mmap_locked) {
+		mmap_write_unlock(mm);
+		vrm->mmap_locked = false;
 
-		/*
-		 * Simply unmap the shrunken portion of the VMA. This does all
-		 * the needed commit accounting, unlocking the mmap lock.
-		 */
-		ret = do_vmi_munmap(&vmi, mm, addr + new_len, delta,
-				    &uf_unmap, true);
-		if (ret)
-			goto out;
-
-		/* We succeeded, mmap lock released for us. */
-		ret = addr;
-		goto out_unlocked;
+		if (!offset_in_page(ret) && vrm->mlocked && vrm->new_len > vrm->old_len)
+			mm_populate(vrm->new_addr + vrm->old_len, vrm->delta);
 	}
 
-	/* EXPAND case. We try to do in-place, if we can't, then we move it. */
-	ret = expand_vma(vma, addr, old_len, new_len, flags, &locked, &new_addr,
-			 &uf, &uf_unmap);
+	userfaultfd_unmap_complete(mm, vrm->uf_unmap_early);
+	mremap_userfaultfd_complete(vrm->uf, vrm->addr, ret, vrm->old_len);
+	userfaultfd_unmap_complete(mm, vrm->uf_unmap);
 
-out:
-	if (offset_in_page(ret))
-		locked = false;
-	mmap_write_unlock(mm);
-	if (locked && new_len > old_len)
-		mm_populate(new_addr + old_len, delta);
-out_unlocked:
-	userfaultfd_unmap_complete(mm, &uf_unmap_early);
-	mremap_userfaultfd_complete(&uf, addr, ret, old_len);
-	userfaultfd_unmap_complete(mm, &uf_unmap);
 	return ret;
 }
+
+/*
+ * Expand (or shrink) an existing mapping, potentially moving it at the
+ * same time (controlled by the MREMAP_MAYMOVE flag and available VM space)
+ *
+ * MREMAP_FIXED option added 5-Dec-1999 by Benjamin LaHaise
+ * This option implies MREMAP_MAYMOVE.
+ */
+SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
+		unsigned long, new_len, unsigned long, flags,
+		unsigned long, new_addr)
+{
+	struct vm_userfaultfd_ctx uf = NULL_VM_UFFD_CTX;
+	LIST_HEAD(uf_unmap_early);
+	LIST_HEAD(uf_unmap);
+	/*
+	 * There is a deliberate asymmetry here: we strip the pointer tag
+	 * from the old address but leave the new address alone. This is
+	 * for consistency with mmap(), where we prevent the creation of
+	 * aliasing mappings in userspace by leaving the tag bits of the
+	 * mapping address intact. A non-zero tag will cause the subsequent
+	 * range checks to reject the address as invalid.
+	 *
+	 * See Documentation/arch/arm64/tagged-address-abi.rst for more
+	 * information.
+	 */
+	struct vma_remap_struct vrm = {
+		.addr = untagged_addr(addr),
+		.old_len = old_len,
+		.new_len = new_len,
+		.flags = flags,
+		.new_addr = new_addr,
+
+		.uf = &uf,
+		.uf_unmap_early = &uf_unmap_early,
+		.uf_unmap = &uf_unmap,
+
+		.remap_type = MREMAP_INVALID, /* We set later. */
+	};
+
+	return do_mremap(&vrm);
+}
-- 
2.48.1


