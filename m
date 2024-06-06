Return-Path: <linux-kernel+bounces-204794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 044A88FF3A6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 19:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06B0C1C265BD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 17:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97331990C7;
	Thu,  6 Jun 2024 17:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lWjum/h2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="w44Jxo0y"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8601990B0
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 17:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717694762; cv=fail; b=nMSNYQowcKu9/8HubjjCFRH0KR4475OnovvMhLTSJZpyWFGnA3tIWGJB5QIT2Fsj7svKPh0BIrobv89rQ5gEfX/zeQTBzzN28dnqSP33d9UJzEw1P7o0i/Op9guL4Pgos6uEatDMkrs5MYiZxhGokC+E9ogrr1zrvdsjsfFQ+DQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717694762; c=relaxed/simple;
	bh=yfD7p06X1BwYyjaXJqDtjBlHtb5Uf5TBzos2QWUQkCg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ODnLXcv+RYwFqsJVcySoprVTDwCWkyfMU7NAIuE5l0iMVHC6/T/Jlew/sghnAfOiT8w7mdDywUJaK+NXUr9e9VZ5UmyjVYEiLSMb4M8atNX4VjTcBlKENSsT0KHob/jvJRJBIgZF80tcFa5Cg/BeoRUW7ywnob5nDOKmkkJTAtQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lWjum/h2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=w44Jxo0y; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 456HOrpY007419;
	Thu, 6 Jun 2024 17:25:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc :
 content-transfer-encoding : content-type : date : from : message-id :
 mime-version : subject : to; s=corp-2023-11-20;
 bh=PDRHWDWsU3RfNWo4T3VVzNkzoEgDCPG61J2G/s6SWCg=;
 b=lWjum/h2WcpJiNZ3kM6i+S/cTdU0NQOgQNvERHnQbQl83bxi7VBSyinFtUXPM/B4/XE5
 vC9+vJM6Y8HrIXcLTTQNzPqwfedulAuaoHryF4t9Xi3ZZbu3DJON0J3XXyGWthzX7phN
 RA9exES3wpFnkrsBn6cBB2dxGQRVNTSxAQNqv/2Taz1NedOYKCesZmBCBfUJvTT/PaiY
 waPfGxRsXTES2PBWC60klWDNkcBLOZKyC1Dr6jwAHcDJHt46lAiuqZZjMY6V4WbJnLpp
 ufrn6yQ4zLwxjXaR05APRwfYtpVdkG2zmDKMHqGc/ct17vEonmCRpyUb6wqLjIk2ylQq 6A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yjbsyc1k4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Jun 2024 17:25:36 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 456H8xIp023967;
	Thu, 6 Jun 2024 17:25:34 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrr15epk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Jun 2024 17:25:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ljh28c/4dobJBzIjLIvPysFx01PheYUpgPp8ty+Df/npQILjRs+TZQk2d2pj/0vllZyxXQeoyVCSMK8IDOvaSVv5/Tm0sWA8t7dcOvNGgYbAoCZOc2E1MoGkBrHYJSWMm32i5wHz1WWUl9t3yGh1Uj/LOJmTHj1wNwRIAqSLvFCeMJNG67AjCGiim3tfeAhOQ+HAHFm0C0lKYyKrDqY8C9TkcQVWQFcoDsMNN35OjX/Tyb/wZdR9kqSZJu+Btj3+ekFzhDA1gEkDC6Z+wsBakR8yRbVWcxHC8/+camWY4VU0GoQ+GmJbr9Az1k0EovELAYcUTVtDT0HVu1a/kTPzcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PDRHWDWsU3RfNWo4T3VVzNkzoEgDCPG61J2G/s6SWCg=;
 b=F7YfntE7PB+ZL2KJP64zeyMuk5WLBT3vYkZ1nGudCWvP8VSceD6opZHD+zWiIPBhPWLk0SJs43stYNEYFwzqQ8yrkSEDBx3k3pmlD/GsfcB8hQvtN8KKrnIsHx2DO1ExIx9pa/TVBiv+9FE82Rn+pGB54n0okGDO4DgtgGlsW3Jw+yA7NOdCwv1yf/R/elumYCVWdEbcWmQSCl03D6MNmvD5+bgyI0W6tdY2sAxI7CX2wHAXJbtbPnkWcdTfjAhlHLEmg/D9yY33dS0gldlgyjNWx79z87UL/xtfkPeFvvdUlSyjZoLu+3TLcHhFOp5PhJT8yqFKvE/693Izc4d0Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PDRHWDWsU3RfNWo4T3VVzNkzoEgDCPG61J2G/s6SWCg=;
 b=w44Jxo0yL9a8VBZ3UCvO+ajefkiFCx2tkPYaDFOa7NUP2y1yHKI66Lr4YsBKYhCEOXhHMWwFy7k1ejNEiPGI9jbivZWJ0A18Mz+zK8Rlp812ymERI/ZSiDr1s26NjlwhTfRwHtHid2DaDCHl8UrWtJ5rFdUg+P+0Cvd1mv1jVqg=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by IA1PR10MB5898.namprd10.prod.outlook.com (2603:10b6:208:3d6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Thu, 6 Jun
 2024 17:25:32 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca%3]) with mapi id 15.20.7611.030; Thu, 6 Jun 2024
 17:25:32 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        David Hildenbrand <david@redhat.com>, Hao Ge <gehao@kylinos.cn>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Omar Sandoval <osandov@osandov.com>
Subject: [PATCH] mm: convert page type macros to enum
Date: Thu,  6 Jun 2024 10:25:29 -0700
Message-ID: <20240606172530.829790-1-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0066.namprd05.prod.outlook.com
 (2603:10b6:a03:332::11) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|IA1PR10MB5898:EE_
X-MS-Office365-Filtering-Correlation-Id: 2511f38e-7ff7-4e78-e3e1-08dc864dab35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?JcjinOg86KCuwW94r3+98CE8ug6ohXL0p/NX4bt89HpjGiZDTyxyyoexYoWg?=
 =?us-ascii?Q?zJSuFFp6Trzyi7YAVTgDLEeVznk5aA/dicCg7fpLaJ7tLhxKqS3wlJLax2FJ?=
 =?us-ascii?Q?Et7d3DiccCBnuLN8e/my/Rp0ImL15UXrjNG9LAr87uzgSwrglqO7r1FGoBPn?=
 =?us-ascii?Q?8iUy02SRAmYFcancv3aEZ/NuuTlsg96915QWT1c6/6fnZgExOVlNW6e85Qht?=
 =?us-ascii?Q?iJnL01g6e1Iopya4zW2G43QU70hK008NYp9QlfJ+jIu2+okhv/pJWs4xQutt?=
 =?us-ascii?Q?OxJs7jp3cE4KTjR0XTLTLY/3Dwh3jOnqyidIQBaZHbMKdr+NjQOQFA2rZzpx?=
 =?us-ascii?Q?QAL2uFFS+Iv9t7dG7wESePDZ6FZ7Lb/HyJUXx72GiQkK4ssOS5hgcHJufjrp?=
 =?us-ascii?Q?5KVfTWsZM02zYUTjQvcsvnq3gBXILSaxykFYlb1QRpDOBMFDu1Ip1jHSvZfw?=
 =?us-ascii?Q?uROfssWZI60dO4vjUde785IyUrHmbXb33/RPI9OVieKOr+uvUfifZm0rzm57?=
 =?us-ascii?Q?tGrFY5U9GzLKqEe54mK6oYu0AQ+U92RzKdZOz/KTVP0vE607RhFADYubBFuR?=
 =?us-ascii?Q?uADbK5illBr/1UrnIsJvKzjkpKOVAXJIPmkeqIPI6qsjBzus/MtlqTFY5qpf?=
 =?us-ascii?Q?q5SI/NIzgMWdkpp8p/h6i0b9mPSICtrnsG9JEZWQM34upo3rYHWs2TSfJCWP?=
 =?us-ascii?Q?vooHxsNuqkfkBdQneiUqgEfRhnfubFUmmePd3ucaA9b/IHDHi1HlcExo6hk2?=
 =?us-ascii?Q?iiAtS6nb8yDmINjiiNEz8rg+9xMi03//MUIUzlV1T8x2wzYNpL7Rttqz81Dv?=
 =?us-ascii?Q?Vji1jhgQin4bM2ZaPcOEC4UlAH6DutuLP4caqwfF/NhqxzSXVeKWPK5WsSZZ?=
 =?us-ascii?Q?8TuclhZGMokShUFfXEp0AYKd9WgtuzkhPpAubVOg/1DsxaY2qZRlZSgsyryV?=
 =?us-ascii?Q?a5pY1UK4sAT0HwXoee5OVZi90tGmkRr28JytQxmNVKW24sUZyeLoYLzmHiNv?=
 =?us-ascii?Q?h2v8+92IIb/koAdRU2dD9ho4fS/zFzwIx/M3PuUzegMDOIN99ep+Sgt7ON0e?=
 =?us-ascii?Q?48mqxCg0YL0OUoxDfDVsd8Kz4FaP+m98Q+hGSbhZMJVJQO3xkecYqUJQM4nB?=
 =?us-ascii?Q?on2naDpAavIIrYSSXxwnJfiHLNwzU+i6LcDxesVQ/H2f2ZETqdwe1kWfTXKo?=
 =?us-ascii?Q?Op+XfpcpeEks1l/+veL6O0sAWIwV72PRXyl1tcwgZcv9rEw8iBogNIFQo+ky?=
 =?us-ascii?Q?p3gM/E6Ui7o9k9erG4VAtut1roiv4N0O+lB6z/SIhxNFeEhnSp+hjwUL3Vv+?=
 =?us-ascii?Q?jLsxlizIZoqIIY6GKCwPwicG?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6597.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?5AVedErpLgCiIrTaY2crpNdB+RVRYl4ZcwLw8pp7DFQg02w81htc+3eawrtr?=
 =?us-ascii?Q?wBpkOAoL6f4gPeHK0wdhvYTucSfONwua7kMXkpAHIu6nUSfNBdU87r9nRwld?=
 =?us-ascii?Q?nVWd2De1E4/HiIQpt+CR+L8W1BXQ3v0xiL45aFRRJ/pqbC2tNNRm8IrNEZUa?=
 =?us-ascii?Q?nR71hCDw6JGwTtNrTJQtCC2yDe888LgxLElxje3a5U/wtufRw4QURMUUkNBr?=
 =?us-ascii?Q?Cn0ApkyNC6JMJEk5eCMkxUZNr9S0e37eMP/BMY9jPO2MUOlcmSNgVj91Fpbb?=
 =?us-ascii?Q?HcVaZWX694CHsh+cAgE3UFbFFPlDiSNKRhMK3KfZLgPtY2/nulSRBcYwgkg5?=
 =?us-ascii?Q?kPDG5TtNvCkP/9CTVvLv4TRjpAUogV/u1aNYp5XVyeQVkjlpPJ1eG69rBjXM?=
 =?us-ascii?Q?9Pn1uKul3RpV9qlQ7lL977sXExDuGYMLPsVSehPFqPp4fly7yMOrdbRC9d6z?=
 =?us-ascii?Q?9Q3rVIHe1BBx3jY+zcfowMC4v1NaF1x12/oyM9Ttz0CYOPCFGfm8LwxyxwF3?=
 =?us-ascii?Q?Ca4U6TuaBFoNMmbPFr2KC8Ua/Mss60tz2UJEcIwiV4hiJFGsQTSOazS2WS6l?=
 =?us-ascii?Q?+uVYm95XGed//JcZL+9soOXxEVIst9QzGxUkJt668QJGljb4OZb0GsVIbQYa?=
 =?us-ascii?Q?Def0ijooSjXlw0/i6w0wMKQaz6hR2LP2yTr5bEKNGMRVX/OBDr13B1CWioNl?=
 =?us-ascii?Q?hgNKkJpM4PszaXsKXorvmL8shBFjFAVbH7oWgWfSLww4In+kqlk+/p/p8gkV?=
 =?us-ascii?Q?B15xYqmqO5JP2o4dGzPTszGPoEDy9yn1kWI89xPcoYI+zKKUKn8uzPWygAJf?=
 =?us-ascii?Q?eLmTGO8rZJIkAX8k3NaA8d+Kt9yv744UPqRSd09jMf9hnj83FzNTSlLfYTnG?=
 =?us-ascii?Q?oniPARd5OMw81rp2LU9VAT7ZunsFR+HkNrYvW4pIO+iJrzfB/7C3FG8mFq4u?=
 =?us-ascii?Q?2LYC4KyQsNGArowEYqsgl1nPVMliBu1ceKrFW0J2ZDtLUwHFahOAWEmchLUa?=
 =?us-ascii?Q?NntfpucN1vEcQXT3RQDOhBjsFrsvMS6FnPX3p8WHf5neSmyzi5zYCRASNNbI?=
 =?us-ascii?Q?GRR5YaUUzwcfT+Ezb6QnYAbA7ZXl8X3+4JKwvIaFrkeFMV9S4rAGq2MIPTFJ?=
 =?us-ascii?Q?fQ0ZdPymkCIKVaCMR29Q4jTQ4YSMenQMjKk+ZREBNzmN+1hE8J/KJCr749EC?=
 =?us-ascii?Q?NAtNnFUdCQI0SX7G2ueF/RsrV2FMmFc8GLHHjybDkVPlQtDXcIs/X4izOX4Z?=
 =?us-ascii?Q?NHK/+IMtaowJY5BtBpxD6UajIF9P07e8yTbdtGx+5vw/XgChI0kH6bAW5mcL?=
 =?us-ascii?Q?dDL6+N/wsCN2q/IC3w3RY1g2O3ntm4J+Zqtsdbef81O+dgH/3pcPCj06a1Mb?=
 =?us-ascii?Q?JueGNP4CFe2xkygxbXmXTKNdapiaO1fzE7cajV0TvzUC/8WkOFq5Ktd9dtd8?=
 =?us-ascii?Q?Af9M6NlcouDAhc/2V3p4LMtMtr3fZwT4QJEEjmT2D807jhT8S0lTfD62iij5?=
 =?us-ascii?Q?qt7x926XiJGTXH6QeT8RIaKuFSEo2SmGs3n6fqLJmgyoVVvbDakyeXhAjTFr?=
 =?us-ascii?Q?SYofo56BbCy4cANUN1/WbKMtLs8rK4VV70xKjTKWp7SzbFhhmkL3GqJuOJj8?=
 =?us-ascii?Q?xWPQwguZ5k9+rb0qZ5WSG3QK2qyUNur5nrrM9rMEs0KunMBA38iOcRTE81T5?=
 =?us-ascii?Q?dYDxeQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	zom4q2G5LEB+m6DuZkdEqB/myPh00FcstJpPlClVtlSX/GFJdVHYbYMuKIihv6yjMLMjq//ch2D8HJVIilCWfyjGHIkP7/ni2u/iRR6OQ4BQvksYJmXJufn5QGbS21juAZrMoA2CIdxtnuqdSL2Dadyf/A99fZMfbi/3uwS+kpDr6Ibr/ShWyZJJRYg8/lyOU821vFxCkK7w3DPWy3yC83ZxjUI3qmkcz4DolSnN/ZIrouQXOKzSYe8VYrnuV1FQeKcjrshHyh/X3ZH7xVq2vmMYwnf9BWGH2pBrYR0n34K6pOqbdjhdme0Xq6pBejgnUjwYt4aZljoPpOg8Syt1dal/Wpnnylw701brjf8QBNQ1LUcIwU/2kRoEFhokmtQZ5xfy4PAGEP3qHa/AEEVT+OWHWD0F9vgg+nLCejNlqLOsGihaTCiAEggwIJJOQ0TAV2bsyaO5COT0voY4Smr4uDBVlfPhI6HKuje5pggqfV70fWtU9OprDwK6j/SxJXFeLhRTgmUvtDHo+aswvao8xZKWKjNz5Fgyi84krhchlTuHCzx+kHyv3ttUZXI4hcz2XwMWXNYhgCzHvxQIjraoxv0pLGaRAJSwSsyzbuRTud0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2511f38e-7ff7-4e78-e3e1-08dc864dab35
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 17:25:32.4228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QhKG62JF6SFons4A4eULeVhZiejrhBI40qJy3CgULEkVbXpZMzlGrSimoqq/q+WRX19kN59UvlLvXRxPHBEtT0O1ByPoRdpdyNjYH9lZkc4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5898
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-06_14,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406060123
X-Proofpoint-GUID: xeIUb3xLW93gn4Dp0QJ70SYqIworwC6F
X-Proofpoint-ORIG-GUID: xeIUb3xLW93gn4Dp0QJ70SYqIworwC6F

Changing PG_slab from a page flag to a page type in commit 46df8e73a4a3
("mm: free up PG_slab") in has the unintended consequence of removing
the PG_slab constant from kernel debuginfo. The commit does add the
value to the vmcoreinfo note, which allows debuggers to find the value
without hardcoding it. However it's most flexible to continue
representing the constant with an enum. To that end, convert the page
type fields into an enum. Debuggers will now be able to detect that
PG_slab's type has changed from enum pageflags to enum page_type.

Fixes: 46df8e73a4a3 ("mm: free up PG_slab")

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---
 include/linux/page-flags.h | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 104078afe0b16..64fc191a75e8d 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -947,12 +947,15 @@ PAGEFLAG_FALSE(HasHWPoisoned, has_hwpoisoned)
 #define PAGE_TYPE_BASE	0xf0000000
 /* Reserve		0x0000007f to catch underflows of _mapcount */
 #define PAGE_MAPCOUNT_RESERVE	-128
-#define PG_buddy	0x00000080
-#define PG_offline	0x00000100
-#define PG_table	0x00000200
-#define PG_guard	0x00000400
-#define PG_hugetlb	0x00000800
-#define PG_slab		0x00001000
+
+enum page_type {
+	PG_buddy	= 0x00000080,
+	PG_offline	= 0x00000100,
+	PG_table	= 0x00000200,
+	PG_guard	= 0x00000400,
+	PG_hugetlb	= 0x00000800,
+	PG_slab		= 0x00001000,
+};
 
 #define PageType(page, flag)						\
 	((page->page_type & (PAGE_TYPE_BASE | flag)) == PAGE_TYPE_BASE)
-- 
2.43.0


