Return-Path: <linux-kernel+bounces-381663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE369B0255
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 14:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CC491C219E7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 12:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F6D2040A2;
	Fri, 25 Oct 2024 12:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iDdFFshc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="J15mkOls"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C004D20402E
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 12:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729859239; cv=fail; b=fdzlyFPSDKkd9JYel303TfO0G9HbbJmC8kU9pGimk4zfGg9q5WvHIXQbXQGwwUd15StN5+uyVTkWSknoC678LR2wv7eIDcPGuNcfVHzCWsxJe7TSDvtO2fbkLp3a7cru6Kbu7SJGqjD8Bx2MwEnpjVJoTlesZg8ncWVWiLir88o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729859239; c=relaxed/simple;
	bh=vPqHs9Nf7qupIKP9+48cqzwgaroNUSpwzFhytzfc/Us=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cdSMl3AsX8hww1yCqEFbjTMurb+0bpIJe3EwdR0x2579ov3Nq6FaNAxEWLdyRbFaQlXML5A8E7jGAZxder+3q6QuMc9jWGDEKiztnI7xL1Iqiub5Af3SSPNdUa3WZzOHZUKg9cc1h1KAA+BELtwNLlws9k/Jl3mRNPu5v5RN+u0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iDdFFshc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=J15mkOls; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49P8BYFe014704;
	Fri, 25 Oct 2024 12:27:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=v2dv89kI7lw9WI2akap4rWRfGxfF/RsmR8cPxtvRT3Q=; b=
	iDdFFshcUMstesfit8GHcTErF7yUhtHFOmNpvYe6rjm2YOf8VSHRgDCCuBBTMwKI
	B3ZBDqiFsWu1C+M+oq3DBWg/dhjQpY0aQmNelmHtkebPACtVi9QYPzIh4dwjizQs
	8bngK17ImM1STZBTZmiavgr9ZYPdNIRZ/yNrTDKWm0RK4YmT31c9DgerkFY3Mu+x
	yVpapRG5WC/o8ccFtdEaS79Il5TuksOS+q8KnkKfKrsymGN+YbtjkSwJIdVo+6rW
	AClm2vdyBudEoB/0vQJI80GdR7KNEyw55jUNOgGC8YDsg7zgoAnVHKn516/67993
	tssUbJLCEdLxqIsfoXW03w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c5asmut7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 12:27:03 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49PBxpRi016475;
	Fri, 25 Oct 2024 12:27:02 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42emhdt4th-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 12:27:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mNkyJstE0exslBTkAXPcTcZ6znOL2Q1GSq+NQNqXvnAMCEETSk2aCYMlGLeQOL0RYQJajdik7fyLVzZff4ufd/w97V+AIZp0K9dBu1uH3i7beRawz4C3T1i+md1lPH84d/ZrcQ3DtsHqKEp9YwQfTTau1LXdBgrXzlFGeGxTIrFb4EdteaKL50fiFa3rxJwzGXUupZN2fMPLX0krsGZi69Cny2vuJJKHtRmrucxCTt3nK8RlRi9V4LGa/1hIUiShXskyYVdAo4yPbUT89fCmLZMkCiBMdSec3m+Co/TJaW7zZyInHQ35gT89gVsYxi2xBjHmCbEyP72rbLT0vxePxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v2dv89kI7lw9WI2akap4rWRfGxfF/RsmR8cPxtvRT3Q=;
 b=aal6jA9c8GqEaMfmpC0/vYyDclEsW/3p/LCwxs85/4LToaCq7Gdd7VR47PzIT9keZeEV7T+PfTYvKpZ7rjFpehAwhv8Ih2iooYX1ZEYrHL/Bxlqkf2M53lunr3Ff2/9t9h3GLv1WkSUgyVJmVDlXRiR8Isy1RaqOykzstSph5vyP5PGUH8xkejeLAb+DBQgaG3UTpIMXiAufiWZQm51BInSROokThF9811ypoPJTCz/zI5+gRVEosBF+LE0UavmF2GMByOSxwNXk4oGsJjJPJ9uqFyUJVxISgF0sETyf7BFTfrHDhP+0E34Gc7HOcJ0cS1x2lnvDpuzxd7KlDU+DVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v2dv89kI7lw9WI2akap4rWRfGxfF/RsmR8cPxtvRT3Q=;
 b=J15mkOlsjimKSakQyXM6u2Dsu+icU/hy2duH+ZbDzSGltN2L2LqoGz0yHKJJPv2NC1TnNm3nJDCE1yfVGca7rmPYqsOaCbLht0/h1BzqczhGVBYJffH2ZafCFjpXx6bE+8aeP9CtxhWftZMEMBzomGi+5ekthboUYWzxSEUXMMI=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by CO1PR10MB4484.namprd10.prod.outlook.com (2603:10b6:303:90::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Fri, 25 Oct
 2024 12:26:54 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8093.014; Fri, 25 Oct 2024
 12:26:54 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>
Subject: [PATCH v3 2/5] mm: isolate mmap internal logic to mm/vma.c
Date: Fri, 25 Oct 2024 13:26:24 +0100
Message-ID: <93fc2c3aa37dd30590b7e4ee067dfd832007bf7e.1729858176.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1729858176.git.lorenzo.stoakes@oracle.com>
References: <cover.1729858176.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0448.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a9::21) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|CO1PR10MB4484:EE_
X-MS-Office365-Filtering-Correlation-Id: ac415e02-f052-4556-7aed-08dcf4f04f69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?i3aMan+sFFNzvmXV/nHe8+sMiCCEk2WpRC5jI1Z463XLQZY90stVIHJuS64u?=
 =?us-ascii?Q?OHKl+V1P4dB+VgY6vyyOm3aDwwxxBIMZ7AfM/ALX8EkPxmOMf5n5sZ7tUddU?=
 =?us-ascii?Q?wPheFR0c9Jd0PQhW0I+sl1UmGAalAO64xVnFccOyH/CADnhJq8YVcZzhsyec?=
 =?us-ascii?Q?9YHojPXaEb3RM6nzQCfvWFn1wYb9fRxaAoOr5VH66Gtbop5sJBycBeTsKQR7?=
 =?us-ascii?Q?I113we2bdRJ9JYozlBg0h0GVicSY0zQmg8JFm5AiEMroghJ2nT7cbl7tS3vK?=
 =?us-ascii?Q?HpDOTfoi8wNy5jRtZnYtOfZqp0Dc0mlSxiF+tRa+xaE/sjMxP8jOJmB5xORJ?=
 =?us-ascii?Q?zu1EeVu52cG/XzUhx8LaOT20sVHcO6uc2+PZbE5ebY0plrZ5SqtivI8d2g5M?=
 =?us-ascii?Q?2mi7uMKsp1oOkpwtkc8mPeUXh05JjdKi7rpx1zRPjs5ZLUh339Ag9OERFJD0?=
 =?us-ascii?Q?OZ4bOHqr4MMi+FD+JvBYQJBDyCj0Oet7IrkvD5qD9CKnNKzMqWXfqFrunPX1?=
 =?us-ascii?Q?SlAyJOcIrLfxrSLYerUObQcZDMSFDuu9i/z+f3iaX1jpgV1/F1j4q8WhtrZi?=
 =?us-ascii?Q?+1CPkeyZxGS6PgD/Mr1v+/BpB8Ki2L7I9Zpu8Re7qKKEJ19OEuaEfULIlJXb?=
 =?us-ascii?Q?rXdy7UctEbgCCluPlJLPKiYhhD0VtgdG3gNw5/3GDVRSx94aRxWJgMa+udqX?=
 =?us-ascii?Q?GRr/pp3u5ddSjP+fs8H3ZVngfGGXHGDyjoasb15J6KdLZjFocu17/PV4uS/h?=
 =?us-ascii?Q?ulFkY9hF2CBS5Rb8G4qwhUfakAZjsJnryycfsbMUPsSAUnvJe6OE4kW0U6/J?=
 =?us-ascii?Q?6RCqY3KCXIYtlxuXln+TWcVHpIRpcpqfmUbQGhs31nkPZoSrStRm7YgHCP/k?=
 =?us-ascii?Q?zrPviJj1QJcUPt5yXX5UUi2dqJg8PKYPR7XyxK1em/BR49EI2z9bbojLB3xt?=
 =?us-ascii?Q?mRXzna1GLyYpWQJvHosVsGyMaWKXCnZ9zIorgjaBldBx8IoF9YU9g2r1T/GI?=
 =?us-ascii?Q?4pLbUk9sugxRaTbc+RerIks0VDjjXYSQRN3dNY/UTFfNNc3a9LRhwfTJtcaz?=
 =?us-ascii?Q?otld/DiFRr1yH23jBCC4z4CFim8SZe/M6hLBB8DKxFc7/ORlt7Dz1UJ2vgSr?=
 =?us-ascii?Q?Edw0KQuQ1bYLDUzzWMcw9gsZ+DOknhnYHAnBqPub2+qlL+RQTkWfncQAKcai?=
 =?us-ascii?Q?gqo6rSI4B0d6JX1fZrEryYIYy75e6aMGdfKXi/RmVXoCBMH6eSlxNBHBOQ57?=
 =?us-ascii?Q?Hj626YF1iAU+1B9N6zIxoPg3sKgG0QpPq3i0ZuYizw7Lsyx8lQsLnOmw3Brm?=
 =?us-ascii?Q?vdZW5HYQzy21xV8Q9VXEUlv7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RnLo10JZ/TyF63gvlKijympeTRx26Au35ui8JxqFWtKmDjru6/D9d4FHq2HO?=
 =?us-ascii?Q?ck66kcl6Qjoirg7nLosihc5t3l4eKkO1OriMjyrr8+f1jvGHdePPO3GFOM7K?=
 =?us-ascii?Q?+L/X7ox17LodLAlC/XKksj2mSUZVN2q6a8KqFgzHpYLJ7E4HG/QruZo/370a?=
 =?us-ascii?Q?q+PRJbzLwwI14e/UF5ju4cESkd3h0E+N+8OwQX3KoF64JdBq9bz71GjZw0Ls?=
 =?us-ascii?Q?JiWcG7Ae9pSEJnIjdDvuTWCA/0zhppU5lz5d+uL8fkzT2CpZWPVIijhlwVWv?=
 =?us-ascii?Q?9ndIFnDIhVlFf8L0HYErZm7MLAqzk/9996noMp5h936oY+dRhqHqbW6/IGtf?=
 =?us-ascii?Q?vo601ynxFyqqebPC/7coSaTd/NnG6MxBo/ywZqrbRdB0blUtpTOw8HClg1wf?=
 =?us-ascii?Q?/THIoAG1ijA0te2HQRuCXP6KZaH5ku42zq0CMxjZGaVD2WUuLoYUj3lg1K7b?=
 =?us-ascii?Q?oAyMXErTQyHU+T+STyGE9S7yDZC8EfpSlUETUDY5XXtId9yRyr4SwCR9Zs2a?=
 =?us-ascii?Q?LGWxR771YfYzbepKJxnNxp+1jDKWx2jPZlLaLFNrJcFaIkUjkgbu4G9lr1KL?=
 =?us-ascii?Q?QK8QhCL/RCWmp7h2NJQRq29tYBLrSsc6jegoJXWgdP7xQskCUjOMVWa/Knd/?=
 =?us-ascii?Q?RdpGtlJetSmmXAHv2MIy5MdVD4psDud5iFwdGsjAfl2Ztr6oQbob0oDGz7T3?=
 =?us-ascii?Q?OvDMASKG+bK4x896QwYachKEx2BBVsLj6ZdMnvmW79VQvXjkHMByoqCe6w0W?=
 =?us-ascii?Q?yfbgl6Qr5TgQQIvMlBzjZPoWySj7RqaCnRQTdmyjbhp/VrXNVZpuzb5FJ+UB?=
 =?us-ascii?Q?Cdf60iyanieu8YMWRUjxvXUCGlLjjdjs1EZkmZHwy718ualEIS+7e0/mS9LB?=
 =?us-ascii?Q?r4539E5nQ0UL4ADc/tbPhPGJyacnsBvEuSWY0O+YQueIXbZCynD980QSwBAW?=
 =?us-ascii?Q?1fEdDNV4Lksm2r3Pxnfn0Tr7zBykNxIFONAAGrb4zn+VsFSYOoTwTSGF/kLn?=
 =?us-ascii?Q?VWb5dzNJ6af54SesTSx17NfBqdi3oLzidBJAazyt9g5SJSqY+gOXMDH+xBDu?=
 =?us-ascii?Q?Y8uDknSlniQIJVEC/01DbkJlTU0hc8VkaZEguXvcyAXIeWmVPWJl7WDZsT22?=
 =?us-ascii?Q?F2QIWqSlxnYWAwkSOqBg6ZLq8VT4PKvc98Pfbs/An/ap3nHqx3KL+uuWtaAC?=
 =?us-ascii?Q?BVtacMSbV18jhmQ5kvkwXcQmMyg92diQXxlqH0uumC4PWbG36Tje+KAGdNqp?=
 =?us-ascii?Q?TXoeskckSgHa6eZ64cKro7MSOd8qxKPBiAYKirQE+LBbFGOrm9+pUv8Gv8ky?=
 =?us-ascii?Q?dJxq9BkBjXEppvE+gZfzIicrFEGiR26sLZs7BpN2xzz/3/H9QonMKzAzIa8P?=
 =?us-ascii?Q?d+bJ9aF1JXw52P1ZruizblYnH15kByO9JpRG978LozpbUoGhpnfTYaMwprXV?=
 =?us-ascii?Q?Nf/zhNk8UldHFPXbVErmzr/Y2gX5dQ15BT3piVVaMf5xBD1QdgkZzI+aEM9u?=
 =?us-ascii?Q?xaWIZf/xqDBYdBZLcPgjXj3K/JCMmtR8dQ3m8vB79mNjVF46Adbmxqy+c6KX?=
 =?us-ascii?Q?urCW08RYbbAMMO+Bc8ejpI6FuJpLhV8DaVoMeYQ7AXPlb5ExGZt0o8xDI5XI?=
 =?us-ascii?Q?NZPwzLE9AC01DmaawWcU2ExoaNMwoA1aV/0osMBOgDFpvP3MY6IrRP+QRd7P?=
 =?us-ascii?Q?0NQkNA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kwvxFeBzFuN+R8p/1W1GzTFEJojlxqOpkJYzzVVq3TvkfTHVWW37aXEDGAaZTICuG2y6geEUlFOZe3hXpr5C3cLKpbd396g4CzKD5Mknq4Vqc7zPKkhYYsnVdICeosZTbZuX7WrelYU8+xgnwff9C93zhQaiZO45H0/7yN1AhyBEviCmxQiutISE81kU+n/xFKZnqSNMNpBMyOsjY89JKvjOdlw5iLCidQN5/KFGkoOy4zOvFJ0Xpmv65trMKWtfFGnOuzXwbXCNm8Oj5QHpo2vkLivAvm0FWd1tEA6/pqjJw4KPJn6uIr/oAia+vJga06UINKz8GlQs6ZaW4S/ljaPoT7C2KWPIeA0YV9JNW5YTuhSW7rvityG0FXcOXWZOGgKMX7MDZ+HuZyY8CDAPhR8wXrtScRLyrg1v/YT7gfSiemMChERfsP6ig9kP5sWnSsB61bJLv5Ss5lKfporgPAftoHlTQIpHlOpl+wpIwdAnefrSRdGX8QmWgS2csZ25CfeLqqisjuvy3/sp1g/5RzASB9NuCHCHVCeaUZzir4XHIpIfdsZwrz+D5JiCobOiM9B6Zad444Sb15QCJdnc+Nl3gAmKJQUJIsROi1lrITo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac415e02-f052-4556-7aed-08dcf4f04f69
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 12:26:54.4095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XZb6AR6beI8sEUi0jr6vDhWgWwQgFzMkemcYS1dft3EGtm5CydJFCW9Fl4CHugRyCVUla5oUL60cFgdfq7j1ChqDt6lm90C0Z+UkVu29xiI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4484
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-25_12,2024-10-25_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410250095
X-Proofpoint-GUID: Rvno4F1x0mJy_mdNFTjy4FNT3LgaVXOE
X-Proofpoint-ORIG-GUID: Rvno4F1x0mJy_mdNFTjy4FNT3LgaVXOE

In previous commits we effected improvements to the mmap() logic in
mmap_region() and its newly introduced internal implementation function
__mmap_region().

However as these changes are intended to be backported, we kept the delta
as small as is possible and made as few changes as possible to the newly
introduced mm/vma.* files.

Take the opportunity to move this logic to mm/vma.c which not only isolates
it, but also makes it available for later userland testing which can help
us catch such logic errors far earlier.

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/mmap.c         | 234 ---------------------------------
 mm/vma.c          | 323 +++++++++++++++++++++++++++++++++++++++++++++-
 mm/vma.h          |  97 +-------------
 mm/vma_internal.h |   5 +
 4 files changed, 329 insertions(+), 330 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index e686d57ed9f7..0affd1a0687f 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -577,22 +577,6 @@ SYSCALL_DEFINE1(old_mmap, struct mmap_arg_struct __user *, arg)
 }
 #endif /* __ARCH_WANT_SYS_OLD_MMAP */
 
-/*
- * We account for memory if it's a private writeable mapping,
- * not hugepages and VM_NORESERVE wasn't set.
- */
-static inline bool accountable_mapping(struct file *file, vm_flags_t vm_flags)
-{
-	/*
-	 * hugetlb has its own accounting separate from the core VM
-	 * VM_HUGETLB may not be set yet so we cannot check for that flag.
-	 */
-	if (file && is_file_hugepages(file))
-		return false;
-
-	return (vm_flags & (VM_NORESERVE | VM_SHARED | VM_WRITE)) == VM_WRITE;
-}
-
 /**
  * unmapped_area() - Find an area between the low_limit and the high_limit with
  * the correct alignment and offset, all from @info. Note: current->mm is used
@@ -1361,224 +1345,6 @@ int do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
 	return do_vmi_munmap(&vmi, mm, start, len, uf, false);
 }
 
-static unsigned long __mmap_region(struct file *file, unsigned long addr,
-		unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
-		struct list_head *uf)
-{
-	struct mm_struct *mm = current->mm;
-	struct vm_area_struct *vma = NULL;
-	pgoff_t pglen = PHYS_PFN(len);
-	unsigned long charged = 0;
-	struct vma_munmap_struct vms;
-	struct ma_state mas_detach;
-	struct maple_tree mt_detach;
-	unsigned long end = addr + len;
-	int error;
-	VMA_ITERATOR(vmi, mm, addr);
-	VMG_STATE(vmg, mm, &vmi, addr, end, vm_flags, pgoff);
-
-	vmg.file = file;
-	/* Find the first overlapping VMA */
-	vma = vma_find(&vmi, end);
-	init_vma_munmap(&vms, &vmi, vma, addr, end, uf, /* unlock = */ false);
-	if (vma) {
-		mt_init_flags(&mt_detach, vmi.mas.tree->ma_flags & MT_FLAGS_LOCK_MASK);
-		mt_on_stack(mt_detach);
-		mas_init(&mas_detach, &mt_detach, /* addr = */ 0);
-		/* Prepare to unmap any existing mapping in the area */
-		error = vms_gather_munmap_vmas(&vms, &mas_detach);
-		if (error)
-			goto gather_failed;
-
-		vmg.next = vms.next;
-		vmg.prev = vms.prev;
-		vma = NULL;
-	} else {
-		vmg.next = vma_iter_next_rewind(&vmi, &vmg.prev);
-	}
-
-	/* Check against address space limit. */
-	if (!may_expand_vm(mm, vm_flags, pglen - vms.nr_pages)) {
-		error = -ENOMEM;
-		goto abort_munmap;
-	}
-
-	/*
-	 * Private writable mapping: check memory availability
-	 */
-	if (accountable_mapping(file, vm_flags)) {
-		charged = pglen;
-		charged -= vms.nr_accounted;
-		if (charged) {
-			error = security_vm_enough_memory_mm(mm, charged);
-			if (error)
-				goto abort_munmap;
-		}
-
-		vms.nr_accounted = 0;
-		vm_flags |= VM_ACCOUNT;
-		vmg.flags = vm_flags;
-	}
-
-	/*
-	 * clear PTEs while the vma is still in the tree so that rmap
-	 * cannot race with the freeing later in the truncate scenario.
-	 * This is also needed for mmap_file(), which is why vm_ops
-	 * close function is called.
-	 */
-	vms_clean_up_area(&vms, &mas_detach);
-	vma = vma_merge_new_range(&vmg);
-	if (vma)
-		goto expanded;
-	/*
-	 * Determine the object being mapped and call the appropriate
-	 * specific mapper. the address has already been validated, but
-	 * not unmapped, but the maps are removed from the list.
-	 */
-	vma = vm_area_alloc(mm);
-	if (!vma) {
-		error = -ENOMEM;
-		goto unacct_error;
-	}
-
-	vma_iter_config(&vmi, addr, end);
-	vma_set_range(vma, addr, end, pgoff);
-	vm_flags_init(vma, vm_flags);
-	vma->vm_page_prot = vm_get_page_prot(vm_flags);
-
-	if (vma_iter_prealloc(&vmi, vma)) {
-		error = -ENOMEM;
-		goto free_vma;
-	}
-
-	if (file) {
-		vma->vm_file = get_file(file);
-		error = mmap_file(file, vma);
-		if (error)
-			goto unmap_and_free_file_vma;
-
-		/* Drivers cannot alter the address of the VMA. */
-		WARN_ON_ONCE(addr != vma->vm_start);
-		/*
-		 * Drivers should not permit writability when previously it was
-		 * disallowed.
-		 */
-		VM_WARN_ON_ONCE(vm_flags != vma->vm_flags &&
-				!(vm_flags & VM_MAYWRITE) &&
-				(vma->vm_flags & VM_MAYWRITE));
-
-		vma_iter_config(&vmi, addr, end);
-		/*
-		 * If vm_flags changed after mmap_file(), we should try merge
-		 * vma again as we may succeed this time.
-		 */
-		if (unlikely(vm_flags != vma->vm_flags && vmg.prev)) {
-			struct vm_area_struct *merge;
-
-			vmg.flags = vma->vm_flags;
-			/* If this fails, state is reset ready for a reattempt. */
-			merge = vma_merge_new_range(&vmg);
-
-			if (merge) {
-				/*
-				 * ->mmap() can change vma->vm_file and fput
-				 * the original file. So fput the vma->vm_file
-				 * here or we would add an extra fput for file
-				 * and cause general protection fault
-				 * ultimately.
-				 */
-				fput(vma->vm_file);
-				vm_area_free(vma);
-				vma = merge;
-				/* Update vm_flags to pick up the change. */
-				vm_flags = vma->vm_flags;
-				goto file_expanded;
-			}
-			vma_iter_config(&vmi, addr, end);
-		}
-
-		vm_flags = vma->vm_flags;
-	} else if (vm_flags & VM_SHARED) {
-		error = shmem_zero_setup(vma);
-		if (error)
-			goto free_iter_vma;
-	} else {
-		vma_set_anonymous(vma);
-	}
-
-#ifdef CONFIG_SPARC64
-	/* TODO: Fix SPARC ADI! */
-	WARN_ON_ONCE(!arch_validate_flags(vm_flags));
-#endif
-
-	/* Lock the VMA since it is modified after insertion into VMA tree */
-	vma_start_write(vma);
-	vma_iter_store(&vmi, vma);
-	mm->map_count++;
-	vma_link_file(vma);
-
-	/*
-	 * vma_merge_new_range() calls khugepaged_enter_vma() too, the below
-	 * call covers the non-merge case.
-	 */
-	khugepaged_enter_vma(vma, vma->vm_flags);
-
-file_expanded:
-	file = vma->vm_file;
-	ksm_add_vma(vma);
-expanded:
-	perf_event_mmap(vma);
-
-	/* Unmap any existing mapping in the area */
-	vms_complete_munmap_vmas(&vms, &mas_detach);
-
-	vm_stat_account(mm, vm_flags, pglen);
-	if (vm_flags & VM_LOCKED) {
-		if ((vm_flags & VM_SPECIAL) || vma_is_dax(vma) ||
-					is_vm_hugetlb_page(vma) ||
-					vma == get_gate_vma(current->mm))
-			vm_flags_clear(vma, VM_LOCKED_MASK);
-		else
-			mm->locked_vm += pglen;
-	}
-
-	if (file)
-		uprobe_mmap(vma);
-
-	/*
-	 * New (or expanded) vma always get soft dirty status.
-	 * Otherwise user-space soft-dirty page tracker won't
-	 * be able to distinguish situation when vma area unmapped,
-	 * then new mapped in-place (which must be aimed as
-	 * a completely new data area).
-	 */
-	vm_flags_set(vma, VM_SOFTDIRTY);
-
-	vma_set_page_prot(vma);
-
-	return addr;
-
-unmap_and_free_file_vma:
-	fput(vma->vm_file);
-	vma->vm_file = NULL;
-
-	vma_iter_set(&vmi, vma->vm_end);
-	/* Undo any partial mapping done by a device driver. */
-	unmap_region(&vmi.mas, vma, vmg.prev, vmg.next);
-free_iter_vma:
-	vma_iter_free(&vmi);
-free_vma:
-	vm_area_free(vma);
-unacct_error:
-	if (charged)
-		vm_unacct_memory(charged);
-
-abort_munmap:
-	vms_abort_munmap_vmas(&vms, &mas_detach);
-gather_failed:
-	return error;
-}
-
 unsigned long mmap_region(struct file *file, unsigned long addr,
 			  unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
 			  struct list_head *uf)
diff --git a/mm/vma.c b/mm/vma.c
index bb7cfa2dc282..0a2965be582d 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -1103,7 +1103,7 @@ static inline void vms_clear_ptes(struct vma_munmap_struct *vms,
 	vms->clear_ptes = false;
 }
 
-void vms_clean_up_area(struct vma_munmap_struct *vms,
+static void vms_clean_up_area(struct vma_munmap_struct *vms,
 		struct ma_state *mas_detach)
 {
 	struct vm_area_struct *vma;
@@ -1126,7 +1126,7 @@ void vms_clean_up_area(struct vma_munmap_struct *vms,
  * used for the munmap() and may downgrade the lock - if requested.  Everything
  * needed to be done once the vma maple tree is updated.
  */
-void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
+static void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
 		struct ma_state *mas_detach)
 {
 	struct vm_area_struct *vma;
@@ -1167,6 +1167,23 @@ void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
 	__mt_destroy(mas_detach->tree);
 }
 
+/*
+ * reattach_vmas() - Undo any munmap work and free resources
+ * @mas_detach: The maple state with the detached maple tree
+ *
+ * Reattach any detached vmas and free up the maple tree used to track the vmas.
+ */
+static void reattach_vmas(struct ma_state *mas_detach)
+{
+	struct vm_area_struct *vma;
+
+	mas_set(mas_detach, 0);
+	mas_for_each(mas_detach, vma, ULONG_MAX)
+		vma_mark_detached(vma, false);
+
+	__mt_destroy(mas_detach->tree);
+}
+
 /*
  * vms_gather_munmap_vmas() - Put all VMAs within a range into a maple tree
  * for removal at a later date.  Handles splitting first and last if necessary
@@ -1177,7 +1194,7 @@ void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
  *
  * Return: 0 on success, error otherwise
  */
-int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
+static int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 		struct ma_state *mas_detach)
 {
 	struct vm_area_struct *next = NULL;
@@ -1315,6 +1332,39 @@ int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 	return error;
 }
 
+/*
+ * init_vma_munmap() - Initializer wrapper for vma_munmap_struct
+ * @vms: The vma munmap struct
+ * @vmi: The vma iterator
+ * @vma: The first vm_area_struct to munmap
+ * @start: The aligned start address to munmap
+ * @end: The aligned end address to munmap
+ * @uf: The userfaultfd list_head
+ * @unlock: Unlock after the operation.  Only unlocked on success
+ */
+static void init_vma_munmap(struct vma_munmap_struct *vms,
+		struct vma_iterator *vmi, struct vm_area_struct *vma,
+		unsigned long start, unsigned long end, struct list_head *uf,
+		bool unlock)
+{
+	vms->vmi = vmi;
+	vms->vma = vma;
+	if (vma) {
+		vms->start = start;
+		vms->end = end;
+	} else {
+		vms->start = vms->end = 0;
+	}
+	vms->unlock = unlock;
+	vms->uf = uf;
+	vms->vma_count = 0;
+	vms->nr_pages = vms->locked_vm = vms->nr_accounted = 0;
+	vms->exec_vm = vms->stack_vm = vms->data_vm = 0;
+	vms->unmap_start = FIRST_USER_ADDRESS;
+	vms->unmap_end = USER_PGTABLES_CEILING;
+	vms->clear_ptes = false;
+}
+
 /*
  * do_vmi_align_munmap() - munmap the aligned region from @start to @end.
  * @vmi: The vma iterator
@@ -2069,3 +2119,270 @@ void mm_drop_all_locks(struct mm_struct *mm)
 
 	mutex_unlock(&mm_all_locks_mutex);
 }
+
+/*
+ * We account for memory if it's a private writeable mapping,
+ * not hugepages and VM_NORESERVE wasn't set.
+ */
+static bool accountable_mapping(struct file *file, vm_flags_t vm_flags)
+{
+	/*
+	 * hugetlb has its own accounting separate from the core VM
+	 * VM_HUGETLB may not be set yet so we cannot check for that flag.
+	 */
+	if (file && is_file_hugepages(file))
+		return false;
+
+	return (vm_flags & (VM_NORESERVE | VM_SHARED | VM_WRITE)) == VM_WRITE;
+}
+
+/*
+ * vms_abort_munmap_vmas() - Undo as much as possible from an aborted munmap()
+ * operation.
+ * @vms: The vma unmap structure
+ * @mas_detach: The maple state with the detached maple tree
+ *
+ * Reattach any detached vmas, free up the maple tree used to track the vmas.
+ * If that's not possible because the ptes are cleared (and vm_ops->closed() may
+ * have been called), then a NULL is written over the vmas and the vmas are
+ * removed (munmap() completed).
+ */
+static void vms_abort_munmap_vmas(struct vma_munmap_struct *vms,
+		struct ma_state *mas_detach)
+{
+	struct ma_state *mas = &vms->vmi->mas;
+
+	if (!vms->nr_pages)
+		return;
+
+	if (vms->clear_ptes)
+		return reattach_vmas(mas_detach);
+
+	/*
+	 * Aborting cannot just call the vm_ops open() because they are often
+	 * not symmetrical and state data has been lost.  Resort to the old
+	 * failure method of leaving a gap where the MAP_FIXED mapping failed.
+	 */
+	mas_set_range(mas, vms->start, vms->end - 1);
+	mas_store_gfp(mas, NULL, GFP_KERNEL|__GFP_NOFAIL);
+	/* Clean up the insertion of the unfortunate gap */
+	vms_complete_munmap_vmas(vms, mas_detach);
+}
+
+unsigned long __mmap_region(struct file *file, unsigned long addr,
+		unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
+		struct list_head *uf)
+{
+	struct mm_struct *mm = current->mm;
+	struct vm_area_struct *vma = NULL;
+	pgoff_t pglen = PHYS_PFN(len);
+	unsigned long charged = 0;
+	struct vma_munmap_struct vms;
+	struct ma_state mas_detach;
+	struct maple_tree mt_detach;
+	unsigned long end = addr + len;
+	int error;
+	VMA_ITERATOR(vmi, mm, addr);
+	VMG_STATE(vmg, mm, &vmi, addr, end, vm_flags, pgoff);
+
+	vmg.file = file;
+	/* Find the first overlapping VMA */
+	vma = vma_find(&vmi, end);
+	init_vma_munmap(&vms, &vmi, vma, addr, end, uf, /* unlock = */ false);
+	if (vma) {
+		mt_init_flags(&mt_detach, vmi.mas.tree->ma_flags & MT_FLAGS_LOCK_MASK);
+		mt_on_stack(mt_detach);
+		mas_init(&mas_detach, &mt_detach, /* addr = */ 0);
+		/* Prepare to unmap any existing mapping in the area */
+		error = vms_gather_munmap_vmas(&vms, &mas_detach);
+		if (error)
+			goto gather_failed;
+
+		vmg.next = vms.next;
+		vmg.prev = vms.prev;
+		vma = NULL;
+	} else {
+		vmg.next = vma_iter_next_rewind(&vmi, &vmg.prev);
+	}
+
+	/* Check against address space limit. */
+	if (!may_expand_vm(mm, vm_flags, pglen - vms.nr_pages)) {
+		error = -ENOMEM;
+		goto abort_munmap;
+	}
+
+	/*
+	 * Private writable mapping: check memory availability
+	 */
+	if (accountable_mapping(file, vm_flags)) {
+		charged = pglen;
+		charged -= vms.nr_accounted;
+		if (charged) {
+			error = security_vm_enough_memory_mm(mm, charged);
+			if (error)
+				goto abort_munmap;
+		}
+
+		vms.nr_accounted = 0;
+		vm_flags |= VM_ACCOUNT;
+		vmg.flags = vm_flags;
+	}
+
+	/*
+	 * clear PTEs while the vma is still in the tree so that rmap
+	 * cannot race with the freeing later in the truncate scenario.
+	 * This is also needed for mmap_file(), which is why vm_ops
+	 * close function is called.
+	 */
+	vms_clean_up_area(&vms, &mas_detach);
+	vma = vma_merge_new_range(&vmg);
+	if (vma)
+		goto expanded;
+	/*
+	 * Determine the object being mapped and call the appropriate
+	 * specific mapper. the address has already been validated, but
+	 * not unmapped, but the maps are removed from the list.
+	 */
+	vma = vm_area_alloc(mm);
+	if (!vma) {
+		error = -ENOMEM;
+		goto unacct_error;
+	}
+
+	vma_iter_config(&vmi, addr, end);
+	vma_set_range(vma, addr, end, pgoff);
+	vm_flags_init(vma, vm_flags);
+	vma->vm_page_prot = vm_get_page_prot(vm_flags);
+
+	if (vma_iter_prealloc(&vmi, vma)) {
+		error = -ENOMEM;
+		goto free_vma;
+	}
+
+	if (file) {
+		vma->vm_file = get_file(file);
+		error = mmap_file(file, vma);
+		if (error)
+			goto unmap_and_free_file_vma;
+
+		/* Drivers cannot alter the address of the VMA. */
+		WARN_ON_ONCE(addr != vma->vm_start);
+		/*
+		 * Drivers should not permit writability when previously it was
+		 * disallowed.
+		 */
+		VM_WARN_ON_ONCE(vm_flags != vma->vm_flags &&
+				!(vm_flags & VM_MAYWRITE) &&
+				(vma->vm_flags & VM_MAYWRITE));
+
+		vma_iter_config(&vmi, addr, end);
+		/*
+		 * If vm_flags changed after mmap_file(), we should try merge
+		 * vma again as we may succeed this time.
+		 */
+		if (unlikely(vm_flags != vma->vm_flags && vmg.prev)) {
+			struct vm_area_struct *merge;
+
+			vmg.flags = vma->vm_flags;
+			/* If this fails, state is reset ready for a reattempt. */
+			merge = vma_merge_new_range(&vmg);
+
+			if (merge) {
+				/*
+				 * ->mmap() can change vma->vm_file and fput
+				 * the original file. So fput the vma->vm_file
+				 * here or we would add an extra fput for file
+				 * and cause general protection fault
+				 * ultimately.
+				 */
+				fput(vma->vm_file);
+				vm_area_free(vma);
+				vma = merge;
+				/* Update vm_flags to pick up the change. */
+				vm_flags = vma->vm_flags;
+				goto file_expanded;
+			}
+			vma_iter_config(&vmi, addr, end);
+		}
+
+		vm_flags = vma->vm_flags;
+	} else if (vm_flags & VM_SHARED) {
+		error = shmem_zero_setup(vma);
+		if (error)
+			goto free_iter_vma;
+	} else {
+		vma_set_anonymous(vma);
+	}
+
+#ifdef CONFIG_SPARC64
+	/* TODO: Fix SPARC ADI! */
+	WARN_ON_ONCE(!arch_validate_flags(vm_flags));
+#endif
+
+	/* Lock the VMA since it is modified after insertion into VMA tree */
+	vma_start_write(vma);
+	vma_iter_store(&vmi, vma);
+	mm->map_count++;
+	vma_link_file(vma);
+
+	/*
+	 * vma_merge_new_range() calls khugepaged_enter_vma() too, the below
+	 * call covers the non-merge case.
+	 */
+	khugepaged_enter_vma(vma, vma->vm_flags);
+
+file_expanded:
+	file = vma->vm_file;
+	ksm_add_vma(vma);
+expanded:
+	perf_event_mmap(vma);
+
+	/* Unmap any existing mapping in the area */
+	vms_complete_munmap_vmas(&vms, &mas_detach);
+
+	vm_stat_account(mm, vm_flags, pglen);
+	if (vm_flags & VM_LOCKED) {
+		if ((vm_flags & VM_SPECIAL) || vma_is_dax(vma) ||
+					is_vm_hugetlb_page(vma) ||
+					vma == get_gate_vma(current->mm))
+			vm_flags_clear(vma, VM_LOCKED_MASK);
+		else
+			mm->locked_vm += pglen;
+	}
+
+	if (file)
+		uprobe_mmap(vma);
+
+	/*
+	 * New (or expanded) vma always get soft dirty status.
+	 * Otherwise user-space soft-dirty page tracker won't
+	 * be able to distinguish situation when vma area unmapped,
+	 * then new mapped in-place (which must be aimed as
+	 * a completely new data area).
+	 */
+	vm_flags_set(vma, VM_SOFTDIRTY);
+
+	vma_set_page_prot(vma);
+
+	return addr;
+
+unmap_and_free_file_vma:
+	fput(vma->vm_file);
+	vma->vm_file = NULL;
+
+	vma_iter_set(&vmi, vma->vm_end);
+	/* Undo any partial mapping done by a device driver. */
+	unmap_region(&vmi.mas, vma, vmg.prev, vmg.next);
+free_iter_vma:
+	vma_iter_free(&vmi);
+free_vma:
+	vm_area_free(vma);
+unacct_error:
+	if (charged)
+		vm_unacct_memory(charged);
+
+abort_munmap:
+	vms_abort_munmap_vmas(&vms, &mas_detach);
+gather_failed:
+	return error;
+}
diff --git a/mm/vma.h b/mm/vma.h
index d58068c0ff2e..388d34748674 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -165,99 +165,6 @@ static inline int vma_iter_store_gfp(struct vma_iterator *vmi,
 	return 0;
 }
 
-#ifdef CONFIG_MMU
-/*
- * init_vma_munmap() - Initializer wrapper for vma_munmap_struct
- * @vms: The vma munmap struct
- * @vmi: The vma iterator
- * @vma: The first vm_area_struct to munmap
- * @start: The aligned start address to munmap
- * @end: The aligned end address to munmap
- * @uf: The userfaultfd list_head
- * @unlock: Unlock after the operation.  Only unlocked on success
- */
-static inline void init_vma_munmap(struct vma_munmap_struct *vms,
-		struct vma_iterator *vmi, struct vm_area_struct *vma,
-		unsigned long start, unsigned long end, struct list_head *uf,
-		bool unlock)
-{
-	vms->vmi = vmi;
-	vms->vma = vma;
-	if (vma) {
-		vms->start = start;
-		vms->end = end;
-	} else {
-		vms->start = vms->end = 0;
-	}
-	vms->unlock = unlock;
-	vms->uf = uf;
-	vms->vma_count = 0;
-	vms->nr_pages = vms->locked_vm = vms->nr_accounted = 0;
-	vms->exec_vm = vms->stack_vm = vms->data_vm = 0;
-	vms->unmap_start = FIRST_USER_ADDRESS;
-	vms->unmap_end = USER_PGTABLES_CEILING;
-	vms->clear_ptes = false;
-}
-#endif
-
-int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
-		struct ma_state *mas_detach);
-
-void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
-		struct ma_state *mas_detach);
-
-void vms_clean_up_area(struct vma_munmap_struct *vms,
-		struct ma_state *mas_detach);
-
-/*
- * reattach_vmas() - Undo any munmap work and free resources
- * @mas_detach: The maple state with the detached maple tree
- *
- * Reattach any detached vmas and free up the maple tree used to track the vmas.
- */
-static inline void reattach_vmas(struct ma_state *mas_detach)
-{
-	struct vm_area_struct *vma;
-
-	mas_set(mas_detach, 0);
-	mas_for_each(mas_detach, vma, ULONG_MAX)
-		vma_mark_detached(vma, false);
-
-	__mt_destroy(mas_detach->tree);
-}
-
-/*
- * vms_abort_munmap_vmas() - Undo as much as possible from an aborted munmap()
- * operation.
- * @vms: The vma unmap structure
- * @mas_detach: The maple state with the detached maple tree
- *
- * Reattach any detached vmas, free up the maple tree used to track the vmas.
- * If that's not possible because the ptes are cleared (and vm_ops->closed() may
- * have been called), then a NULL is written over the vmas and the vmas are
- * removed (munmap() completed).
- */
-static inline void vms_abort_munmap_vmas(struct vma_munmap_struct *vms,
-		struct ma_state *mas_detach)
-{
-	struct ma_state *mas = &vms->vmi->mas;
-	if (!vms->nr_pages)
-		return;
-
-	if (vms->clear_ptes)
-		return reattach_vmas(mas_detach);
-
-	/*
-	 * Aborting cannot just call the vm_ops open() because they are often
-	 * not symmetrical and state data has been lost.  Resort to the old
-	 * failure method of leaving a gap where the MAP_FIXED mapping failed.
-	 */
-	mas_set_range(mas, vms->start, vms->end - 1);
-	mas_store_gfp(mas, NULL, GFP_KERNEL|__GFP_NOFAIL);
-	/* Clean up the insertion of the unfortunate gap */
-	vms_complete_munmap_vmas(vms, mas_detach);
-}
-
 int
 do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		    struct mm_struct *mm, unsigned long start,
@@ -336,6 +243,10 @@ bool vma_wants_writenotify(struct vm_area_struct *vma, pgprot_t vm_page_prot);
 int mm_take_all_locks(struct mm_struct *mm);
 void mm_drop_all_locks(struct mm_struct *mm);
 
+unsigned long __mmap_region(struct file *file, unsigned long addr,
+		unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
+		struct list_head *uf);
+
 static inline bool vma_wants_manual_pte_write_upgrade(struct vm_area_struct *vma)
 {
 	/*
diff --git a/mm/vma_internal.h b/mm/vma_internal.h
index b930ab12a587..fc5f172a36bd 100644
--- a/mm/vma_internal.h
+++ b/mm/vma_internal.h
@@ -17,8 +17,10 @@
 #include <linux/file.h>
 #include <linux/fs.h>
 #include <linux/huge_mm.h>
+#include <linux/hugetlb.h>
 #include <linux/hugetlb_inline.h>
 #include <linux/kernel.h>
+#include <linux/ksm.h>
 #include <linux/khugepaged.h>
 #include <linux/list.h>
 #include <linux/maple_tree.h>
@@ -32,11 +34,14 @@
 #include <linux/mmu_context.h>
 #include <linux/mutex.h>
 #include <linux/pagemap.h>
+#include <linux/perf_event.h>
 #include <linux/pfn.h>
 #include <linux/rcupdate.h>
 #include <linux/rmap.h>
 #include <linux/rwsem.h>
 #include <linux/sched/signal.h>
+#include <linux/security.h>
+#include <linux/shmem_fs.h>
 #include <linux/swap.h>
 #include <linux/uprobes.h>
 #include <linux/userfaultfd_k.h>
-- 
2.47.0


