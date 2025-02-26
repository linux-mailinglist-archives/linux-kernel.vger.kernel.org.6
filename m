Return-Path: <linux-kernel+bounces-534273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A763DA464FA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 16:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9CEB188C5A2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9979821E0BE;
	Wed, 26 Feb 2025 15:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TIANFoFL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KYwN1Rv2"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352FA21E0AA
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 15:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740583873; cv=fail; b=VzAWdITKjl3neWP1zgfRWG3IdPTNicvW07/GQ61ousVFHV97eFg+rOSwKl2H0SP4Ocpb+nsHqFkNacJYVdiNNoJOeY9VlbDYZs7SuwHdRxZpZG6Dif0RZZzHE5UWQ2LVf3SGGnFnoophV6pdTMaHWFo9JePVWjVUGRx+TdJ1+hA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740583873; c=relaxed/simple;
	bh=gerCa1/EB1hyWV9sAWx3XL9EtCKXCkub4HQJqgx2dfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QDyveN/Za7ecQeBN8iBJTdp+0WA0EOqk/nKCSVFKUGZ8Vx1fgaXRcqgft6z88IkhR0LrPg9dMkRs1AKt7R1gVgAvNDiw7bpLTlfj0nH3Ag+JrW6dkONWb1PnEq84tinQatyUUBQcZpxmqQ2nC50v/8R9bTuUdJNvY6qg9vF38FI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TIANFoFL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KYwN1Rv2; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51QEtaMp002641;
	Wed, 26 Feb 2025 15:31:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=Y1Uax3Stq4ETzSy7BV
	IL8u3SwXS8Dn9dzdzmytSZvkk=; b=TIANFoFLTp2stJYOmjloewhGuf+Z9s928E
	m2au3OlVLZTBfkBTbRjdiSGXriXo1WM7Dnvo6HZecJb++pQdaHgViXehgBMWShoh
	KoRpxZruPKb0EQsCdDboxY9qq/6tlQwebvRBrTIymU6EfVuVXjZ3K5U4//aXrGBJ
	pYqSaBMaH1vJBdi6T6bCc1IzgbxHiBLIVT6xIgjmxp7F6AmG8S6EFgKfB41UL0P2
	LOfC9HTUmc4rUJBbgX5IG9KaVc46I42WDIg7nj0Di9e6N2T+U8v9Bm3nJcIP+/kT
	utuSHGUGgiktArL3VgX1UBzQLocYypELbnFKCRgAhqRZtyDx/yZg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 451psfsbrj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2025 15:31:01 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51QFLhQo012641;
	Wed, 26 Feb 2025 15:31:00 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y51c2rnx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2025 15:31:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fqPUoQRS4NHD/hZMzZFJk4pWJrPyjL7ZKZfxjdscXsMhBmYM4HOzjKJC4zJV1sUq1EKBqfFm9CQLGgEvOMGC35cBGm8M0KqtlRqTb4Yrc4ETTaok1oiKhDjk5ahmqsRxUfPwcQUZmJEVZP3jjWfiPJuejtbYmFdVBbzMMbZPkUwFqe82uIVNsYqhzXvbqWDvUclE5Gf+cIFjfhCh8gRd7/FMeoGWJheZOjk/Y5Jtu12wUCe6VGppGbMGpRMH+5X9MwMRXEhtLOh8CMizeT/HDGt2pW1l9Pz3f21zuIR/RoXwaHKaxiFWqa0XJbLZqnVTWIpd3SX1Hf66iIW/LLFItw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y1Uax3Stq4ETzSy7BVIL8u3SwXS8Dn9dzdzmytSZvkk=;
 b=Wr0mr4PGLsuVdCTCPA9MrQ/b2T8Tl9h3XtNzelgY+/+ePoKHHXgFcMfIp+iWn3T1kYifC+Ijxwrbb5H2sOkzn0WKiCszPDD/Qx+yjExBLV6yi6XtQfYj/PA4WvtnpBbBp+BaA6014oMv3ZTpXgg/SzA4jhjsFeYP4nAgMFBN+kX75aNw6dplL88D0eiXMTpvRgg5bgTKXtuE2qc8TytrSnlVAi8WhI7kwfltCuymBsECJkklzjXUvor6AHywu36JC5uzB5uafJj1EMxixHuyvQWie4xcHRuVeJcHziaFKSISJcY/ekXBjbsKo5iQa7I7EZIB08jUaHAt+ueS4jaZew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y1Uax3Stq4ETzSy7BVIL8u3SwXS8Dn9dzdzmytSZvkk=;
 b=KYwN1Rv2QrWXM7ol3MVdnroYun73d2lDdaZpHajuj5LWA98yGfBgNTr/Y77dBrje2GEAYeh0H1Ne370SN6GeGhlk6Yxg82TTKlgbR3i5din0dLUSoSFJLyGABnaQ3LL9BB56DXKNr5DPH3RZRUEEmfGUNS8uo7fuA7mXre2pryM=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by CO1PR10MB4627.namprd10.prod.outlook.com (2603:10b6:303:9d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Wed, 26 Feb
 2025 15:30:58 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%4]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 15:30:58 +0000
Date: Wed, 26 Feb 2025 10:30:55 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        richard.weiyang@gmail.com
Subject: Re: [PATCH v2 3/6] maple_tree: use vacant nodes to reduce worst case
 allocations
Message-ID: <qadlxahyhhm3cihdnwjwhbolk36acybreawwgcy42rltxcpzwy@7xkxdv4ue5pp>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org, 
	linux-mm@kvack.org, akpm@linux-foundation.org, richard.weiyang@gmail.com
References: <20250221163610.578409-1-sidhartha.kumar@oracle.com>
 <20250221163610.578409-4-sidhartha.kumar@oracle.com>
 <sjugioveqmkfqwnse5j6tnnlcz6qk5sfvcqf4isqozu3hn4vc7@2ldyqovzngwo>
 <c43bfd29-8dfb-4751-86d2-9eb31955d693@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c43bfd29-8dfb-4751-86d2-9eb31955d693@oracle.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT1PR01CA0093.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::32) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|CO1PR10MB4627:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a62f038-819d-439e-26a8-08dd567a9159
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tyyAlXqKWbedbhKFMlogwR6vzK3G7zeOo6NTciKxNyeUzfhoO5Ks9xB3jnM+?=
 =?us-ascii?Q?aI1mXnAT9WbcS45uol6c1rSjxeaEU2HH3LGHgPBtEz5rS7k2Uj/0IBevTik2?=
 =?us-ascii?Q?o7sH9yh1mNEu7sdPrLfDqmSxXZNjyM71ZS9yx2H9iMFfcMXjMWycn2FdEedo?=
 =?us-ascii?Q?ko+/AwNobwhSSq9m46Q+sOfdfp+CvHprTH/eGMnIILpp8HDYCf3RDqVDEmCm?=
 =?us-ascii?Q?0FM9WRLTJhsAL4BXRq+evCFqJ7YN5NO3WJR6ZDaK1nybo4FXbm5fFDeDji+C?=
 =?us-ascii?Q?/RO9fZodm+mEvgrnuvsywHNhihq9YONJdz9aJUokGSJ0FaNeoA52f89VfVck?=
 =?us-ascii?Q?USwinWPHZTbXWBy0XFC4JOiNZP8Qu8Wf1byIpijDi/6qXClZbhB37/QOhmZG?=
 =?us-ascii?Q?oCpQvjGfMwjnZkRs1mpzvpwra+MEJNOb7231hCDOdi9wxKgFhdkYxQgHIEzJ?=
 =?us-ascii?Q?PArpD88yVmvWgky9fllk7+CxSbgZZcShDRMLhzn4PIvIrP4Fdvldid3qnQ4M?=
 =?us-ascii?Q?+gKx1iNK9sfywv/5rKs49d8QpvEsdCUm8eywdhfoXOGNcgeTCLOInsLn/SMR?=
 =?us-ascii?Q?yxwGsYrCNmb9hDmyRVv/dSUVZdN/PdGZ5fqe2gci24msMsYDTM/iOUB01/xl?=
 =?us-ascii?Q?Hwosy3t44k0uckaztaGJMrjbJ8PoqkgYslf0dGU7WMrJ0MjlkJFo26rg0unQ?=
 =?us-ascii?Q?H9ubpS6rVyFOm/SLCJZATQji5d8SvSTdL3B/JGdTBMpE+CxK8kfp/EkzwChe?=
 =?us-ascii?Q?r6v0iMtPHitcjYAIZHLAjb5/vqno2yyvQ7Mt5nLjbYglyGrQ6i/A144QRz1T?=
 =?us-ascii?Q?qGyLf321MlbOLJ6BafuCoV9a1QrJbP8otgK9bg8AL2mgZKeGkp4QKamnj+Nf?=
 =?us-ascii?Q?j+FORt4HDL2uZpufDkgoQi1GFhY18ej/M7cNYd0IRWf+WAdPEOLfPw3J2kFK?=
 =?us-ascii?Q?fG3y+vCNNCN2rvGxnb2AXYB4D30b8wi2Cxtviav0M+yNmTtV1LKwHqxVoceI?=
 =?us-ascii?Q?jj+kwIDbgCJ7NiPXFyzmHRYOLaa04igcrYIUN633nPDYrxIRk6uppMBHZu+U?=
 =?us-ascii?Q?Y29+2q7Dvv82ZDKhFMy/654paotjjpj2iP2c0XIJb9FFhHuSMwFF1iuXgfl5?=
 =?us-ascii?Q?PCG47q1CpHigUFJqQGSJMglGpC89zt0GYRoFWzT1ysuWdiXdF4fJuH9KYbEr?=
 =?us-ascii?Q?JzqpufK+BfyIsiZCV6/JkFINiGN7RuSUO1RGmgTCFmURABm+4z+6cwm5OhDR?=
 =?us-ascii?Q?6oVOC0LjODPvZk73vDvUG3DyAf8herAEBmI+JPVesUN7LYCo3XWpDPr8EV4y?=
 =?us-ascii?Q?45SSd8YnUUuTbe9JD/SGJ5ulSInPAofse4OUBUoMWR8tlUeHD23rwfF23Hca?=
 =?us-ascii?Q?OzPlUZS0rTFXs6KDL3SLDdAjw8tQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?K+Tjnlcy8e3SZhbG3Fm4a7crTDygOGimzlXCPVLeTEa/S34xDtyDfNKlzZmk?=
 =?us-ascii?Q?AmgteUchsnf5kigdtVN/h18Q0tLRENjgg/MdxSBWEFowHCdBTIa0zHX7n/24?=
 =?us-ascii?Q?pk94UoNIzGsbzYAMoxOIm9d+0bLYmfFz9IoKaX3rqoSS2HXnkaHxbgJ95+2c?=
 =?us-ascii?Q?4TqfJGd0ZgYrqAIfEuDji5Q5dZeBD8Qh44XJ7Lpt76bs6OFK3bJbL/Ly3nAZ?=
 =?us-ascii?Q?Uz8B13EkrIOxSMeNNXrAblngLPuphdfrskUXvMy8BKfyTPyjdDL1vz9gzNUW?=
 =?us-ascii?Q?T84YTpFwIKDveS8HJVFiHxz/Lq5Cbq1EInU61SopuFJPkfVLxYV56IAhZSF2?=
 =?us-ascii?Q?lXkAmhqm+nwwiDNBVpEBszVAiI7B1JZTe6985SJ5PLGusaa1wxA/3GGgX8Kh?=
 =?us-ascii?Q?bMba5cGq0kjYMyLWYQbb1YYajekQmv7Cni47D1Cw6ocMubQpiePZ+mVPYYWR?=
 =?us-ascii?Q?mUO1/dp9qZ2Y9NU3dI2QGEgpSVtITuYf2awhlBDNrFMKUef7syHtYqyDOWiX?=
 =?us-ascii?Q?/fACzQu2zeIDAzhpDrzSzceAkVr5gw6XsWtIbfHRQ3fO/hAI3Vt6Csx1AhZv?=
 =?us-ascii?Q?Mknp3uFmvnwervtpgwC8El/qAn4mWT9B7ifuRhr6xrNwZze1vGp3zlXRdkSv?=
 =?us-ascii?Q?S88IrE0lHQlJrAb2TLA1kkmJRjGFaXmxERmMLGv6DHaYlSeVqImWRRidM6FU?=
 =?us-ascii?Q?HFspy8m6A22xAxc+WILG8IcbON1rvdu9Xi3Yl75XZ9RuVcgTF+u4E6FkLce8?=
 =?us-ascii?Q?IfMc70UMTAOAObux69I3oOFr+FL1WIlPZVeLxuo7r+P8SQpHVIWETY+aRfN+?=
 =?us-ascii?Q?j+bMkf3eV47KOTRxOK2420LVxtQnPmvUbOzJ7tz+TWi5lkTnWpbyUm2Tc3B8?=
 =?us-ascii?Q?lK7zhIqTWRYgQpgAsRPouW5XWnk7q4mNoCbgyjFcrgCQOf7eItKojBenI6dx?=
 =?us-ascii?Q?QJ5xPNMxlAIgbcxv7hqeQIZ/lTx+nXtBm4wNWfIH7WU+sLQYGQlRdUIEXV+x?=
 =?us-ascii?Q?Mn5XlYhRP6eq7KEmjqVXRm9z+NFJqkorqovfBICaLP2JeYfvEo84lGtkJBQ2?=
 =?us-ascii?Q?QjU2qdi6tj2nwRXjdUQCImv1RzrVRGYIsU1UbvujB/r4+UTaEnK6Js24f3ma?=
 =?us-ascii?Q?0oIKgfToO+zp42lZ9mhh8yGKxP5wNXaURjZRXe2qAmniSXLRV7ees0yWFCxP?=
 =?us-ascii?Q?gHwoL56uro/EP0UtbdQ3mafn4CzDVR7TA/Numjo0cj0SAXmM7R7g3bIXnCHd?=
 =?us-ascii?Q?c/i3JclLzJoJDR95upVuIPAjGxH4ICHqc/gmwyF1Ed92XLd2kInqWkD/oaBn?=
 =?us-ascii?Q?A00KBAO/0+PAXRP/dm3dvFkB8plv4g6Z5l4Wb+VfBKIrhKSWJbxcoYOL6HHc?=
 =?us-ascii?Q?Ze4+crTxhfZtSfgNoWnsTB9dYVgFRJUCCqfEBtcAER2LlFWgmpn4AHypN+rx?=
 =?us-ascii?Q?UMgNePaF7+4dnn/tb2IlEsaQTLYmbgiy3qsk6BzwZnrfkpS4649AZnEVCK/O?=
 =?us-ascii?Q?nEbYGhpmpql1VWVqnKuqhPIbjIoKc1nigKxsYDQ3m07wKIBjM8MRMzKrZQX4?=
 =?us-ascii?Q?s47o0uAtIVGcXUOB7AKSh+DiThIqzOFoYS3/40uB?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	J8yPosfHWb55pMs68Uzfbti4gMFz97+JXGRHjDF81E7/O9XadBMa95Eo9TAsSibi+gHBAEQIps6Ho0xcTJDZPb40noeweBB6psMARfVg3pWvuFeU/2Zxc543nMB6jznbuNJEXNSdI5ND1n827eYg/NAxtnsjTKMwKmWlh0hHOQoxJ2y/kog3of5pVD9y22i/sgdBw8eGHKEHlLfVjgjk7H9EqIWrtC48njdJpwkjwmIRnJ3Ky6AZovKh2DbJnHYRoSbwHoJx2q+DPlhG7jP5ge8kj/8EnB9LGAARsbJnvtHKLiaICT5AxB8cfcuhXr97L7y3CKLbOs+Aa6kfPoDHF7WyyhKObXmEjWKRpeaL3GC9O5IOO45DUfXt9d/M0ed/YAEUYwpDWIfYhJDwtimwSYgJ7L2X7TFyJNfg9bninkvUWEcrAG8k9qr40UhNRWWqeNuhmLY2NhuDLdQwSkHmry8ppW9e376Y5ilZoLzdVJgP1ZzAY2+x/pX9Swm8LuKWHBmQ7idxo5Gjf79kVDNKvuNTCz0DJn82JdLVEb4ZLaxS7J4WDFgaA7fk4zsbmVrQlrBfQUhROqDoRhy6EUJNppP1fklM3dpnkbM/YGD7wNc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a62f038-819d-439e-26a8-08dd567a9159
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 15:30:58.2072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xaTamBx1QJ4e8b6qlR6OtM7IyH/ocJmy8K8wBzQejMWgwF4pJdNQuFvzboUca+mu+yJmyq2rlFJR+bXR/mRKsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4627
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-26_04,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 mlxscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502260123
X-Proofpoint-ORIG-GUID: giYSjYeDGqhOGSJBAg-XGP2XELsHpEb0
X-Proofpoint-GUID: giYSjYeDGqhOGSJBAg-XGP2XELsHpEb0

* Sidhartha Kumar <sidhartha.kumar@oracle.com> [250225 11:22]:
> On 2/25/25 10:46 AM, Liam R. Howlett wrote:
> > * Sidhartha Kumar <sidhartha.kumar@oracle.com> [250221 11:36]:
> > > In order to determine the store type for a maple tree operation, a walk
> > > of the tree is done through mas_wr_walk(). This function descends the
> > > tree until a spanning write is detected or we reach a leaf node. While
> > > descending, keep track of the height at which we encounter a node with
> > > available space. This is done by checking if mas->end is less than the
> > > number of slots a given node type can fit.
> > > 
> > > Now that the height of the vacant node is tracked, we can use the
> > > difference between the height of the tree and the height of the vacant
> > > node to know how many levels we will have to propagate creating new
> > > nodes. Update mas_prealloc_calc() to consider the vacant height and
> > > reduce the number of worst-case allocations.
> > > 
> > > Rebalancing and spanning stores are not supported and fall back to using
> > > the full height of the tree for allocations.
> > > 
> > > Update preallocation testing assertions to take into account vacant
> > > height.
> > > 
> > > Signed-off-by: Sidhartha <sidhartha.kumar@oracle.com>
> > > ---
> > >   include/linux/maple_tree.h       |   2 +
> > >   lib/maple_tree.c                 |  13 ++--
> > >   tools/testing/radix-tree/maple.c | 102 ++++++++++++++++++++++++++++---
> > >   3 files changed, 105 insertions(+), 12 deletions(-)
> > > 
> > > diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
> > > index cbbcd18d4186..7d777aa2d9ed 100644
> > > --- a/include/linux/maple_tree.h
> > > +++ b/include/linux/maple_tree.h
> > > @@ -463,6 +463,7 @@ struct ma_wr_state {
> > >   	void __rcu **slots;		/* mas->node->slots pointer */
> > >   	void *entry;			/* The entry to write */
> > >   	void *content;			/* The existing entry that is being overwritten */
> > > +	unsigned char vacant_height;	/* Height of lowest node with free space */
> > >   };
> > >   #define mas_lock(mas)           spin_lock(&((mas)->tree->ma_lock))
> > > @@ -498,6 +499,7 @@ struct ma_wr_state {
> > >   		.mas = ma_state,					\
> > >   		.content = NULL,					\
> > >   		.entry = wr_entry,					\
> > > +		.vacant_height = 0					\
> > >   	}
> > >   #define MA_TOPIARY(name, tree)						\
> > > diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> > > index d7dac3119748..ef71af0529f4 100644
> > > --- a/lib/maple_tree.c
> > > +++ b/lib/maple_tree.c
> > > @@ -3542,6 +3542,9 @@ static bool mas_wr_walk(struct ma_wr_state *wr_mas)
> > >   		if (ma_is_leaf(wr_mas->type))
> > >   			return true;
> > > +		if (mas->end < mt_slots[wr_mas->type] - 1)
> > > +			wr_mas->vacant_height = mas->depth + 1;
> > > +
> > >   		mas_wr_walk_traverse(wr_mas);
> > >   	}
> > > @@ -4157,7 +4160,9 @@ static inline void mas_wr_prealloc_setup(struct ma_wr_state *wr_mas)
> > >   static inline int mas_prealloc_calc(struct ma_wr_state *wr_mas, void *entry)
> > >   {
> > >   	struct ma_state *mas = wr_mas->mas;
> > > -	int ret = mas_mt_height(mas) * 3 + 1;
> > > +	unsigned char height = mas_mt_height(mas);
> > > +	int ret = height * 3 + 1;
> > > +	unsigned char delta = height - wr_mas->vacant_height;
> > >   	switch (mas->store_type) {
> > >   	case wr_invalid:
> > > @@ -4175,13 +4180,13 @@ static inline int mas_prealloc_calc(struct ma_wr_state *wr_mas, void *entry)
> > >   			ret = 0;
> > >   		break;
> > >   	case wr_spanning_store:
> > > -		ret =  mas_mt_height(mas) * 3 + 1;
> > > +		ret = height * 3 + 1;
> > 
> > ret is already height * 3 + 1, you could add a WARN_ON_ONCE or such to
> > ensure that's the case here and it's not missed in updates to the code.
> > 
> > >   		break;
> > >   	case wr_split_store:
> > > -		ret =  mas_mt_height(mas) * 2 + 1;
> > > +		ret = delta * 2 + 1;
> > >   		break;
> > >   	case wr_rebalance:
> > > -		ret =  mas_mt_height(mas) * 2 - 1;
> > > +		ret = height * 2 + 1;
> > >   		break;
> > >   	case wr_node_store:
> > >   		ret = mt_in_rcu(mas->tree) ? 1 : 0;
> > > diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
> > > index bc30050227fd..d22c1008dffe 100644
> > > --- a/tools/testing/radix-tree/maple.c
> > > +++ b/tools/testing/radix-tree/maple.c
> > > @@ -35475,12 +35475,85 @@ static void check_dfs_preorder(struct maple_tree *mt)
> > >   }
> > >   /* End of depth first search tests */
> > > +/* same implementation as mas_is_span_wr() in lib/maple_tree.c */
> > 
> > Is this needed then?  At the start of this file we have:
> > #include "../../../lib/maple_tree.c" so I would think you could use the
> > one already defined?
> 
> 
> I don't think we can use that one because the it takes in a maple write
> state as an argument which is not exposed externally. The check_prealloc()
> tests use a maple state and the maple write state is then defined internally
> in mas_preallocate() so I'm not sure how to get an external facing interface
> to the maple write state.

Ah, yes.  But you have everything it uses, so you can use it by setting:
wr_mas.mas = mas,
wr_mas.r_max = r_max,
wr_mas.type = type,
wr_mas.entry = entry

You can add a new MA_WR_STATE #define like in the maple_tree.h file, but
only to the testing side.

I think it's worth doing because, if the internal checking changes then
this test will still work (or will fail and force an update the wr_mas
setup, or whatever..).  If we have duplicated code that becomes out of
sync, we risk passing this test without actually getting the right answer
in the kernel where it matters most.

> 
> That's why a similar implementation is needed but one that takes in a maple
> state rather than a maple write state.
> 
> Thanks,
> Sid
> 
> 
> > 
> > > +static bool is_span_wr(struct ma_state *mas, unsigned long r_max,
> > > +				enum maple_type type, void *entry)
> > > +{
> > > +	unsigned long max = r_max;
> > > +	unsigned long last = mas->last;
> > > +
> > > +	/* Contained in this pivot, fast path */
> > > +	if (last < max)
> > > +		return false;
> > > +
> > > +	if (ma_is_leaf(type)) {
> > > +		max = mas->max;
> > > +		if (last < max)
> > > +			return false;
> > > +	}
> > > +
> > > +	if (last == max) {
> > > +		/*
> > > +		 * The last entry of leaf node cannot be NULL unless it is the
> > > +		 * rightmost node (writing ULONG_MAX), otherwise it spans slots.
> > > +		 */
> > > +		if (entry || last == ULONG_MAX)
> > > +			return false;
> > > +	}
> > > +
> > > +	return true;
> > > +}
> > > +
> > > +/* get height of the lowest non-leaf node with free space */
> > > +static unsigned char get_vacant_height(struct ma_state *mas, void *entry)
> > > +{
> > > +	char vacant_height = 0;
> > > +	enum maple_type type;
> > > +	unsigned long *pivots;
> > > +	unsigned long min = 0;
> > > +	unsigned long max = ULONG_MAX;
> > > +
> > > +	/* start traversal */
> > > +	mas_reset(mas);
> > > +	mas_start(mas);
> > > +	if (!xa_is_node(mas_root(mas)))
> > > +		return 0;
> > > +
> > > +	type = mte_node_type(mas->node);
> > > +	while (!ma_is_leaf(type)) {
> > > +		mas_node_walk(mas, mte_to_node(mas->node), type, &min, &max);
> > > +		mas->end = mas_data_end(mas);
> > > +		pivots = ma_pivots(mte_to_node(mas->node), type);
> > > +
> > > +		if (pivots) {
> > > +			if (mas->offset)
> > > +				min = pivots[mas->offset - 1];
> > > +			if (mas->offset < mas->end)
> > > +				max = pivots[mas->offset];
> > > +		}
> > > +
> > > +		/* detect spanning write */
> > > +		if (is_span_wr(mas, max, type, entry))
> > > +			break;
> > > +
> > > +		if (mas->end < mt_slot_count(mas->node) - 1)
> > > +			vacant_height = mas->depth + 1;
> > > +
> > > +		mas_descend(mas);
> > > +		type = mte_node_type(mas->node);
> > > +		mas->depth++;
> > > +	}
> > > +
> > > +	return vacant_height;
> > > +}
> > > +
> > >   /* Preallocation testing */
> > >   static noinline void __init check_prealloc(struct maple_tree *mt)
> > >   {
> > >   	unsigned long i, max = 100;
> > >   	unsigned long allocated;
> > >   	unsigned char height;
> > > +	unsigned char vacant_height;
> > >   	struct maple_node *mn;
> > >   	void *ptr = check_prealloc;
> > >   	MA_STATE(mas, mt, 10, 20);
> > > @@ -35494,8 +35567,9 @@ static noinline void __init check_prealloc(struct maple_tree *mt)
> > >   	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
> > >   	allocated = mas_allocated(&mas);
> > >   	height = mas_mt_height(&mas);
> > > +	vacant_height = get_vacant_height(&mas, ptr);
> > >   	MT_BUG_ON(mt, allocated == 0);
> > > -	MT_BUG_ON(mt, allocated != 1 + height * 3);
> > > +	MT_BUG_ON(mt, allocated != 1 + (height - vacant_height) * 3);
> > >   	mas_destroy(&mas);
> > >   	allocated = mas_allocated(&mas);
> > >   	MT_BUG_ON(mt, allocated != 0);
> > > @@ -35503,8 +35577,9 @@ static noinline void __init check_prealloc(struct maple_tree *mt)
> > >   	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
> > >   	allocated = mas_allocated(&mas);
> > >   	height = mas_mt_height(&mas);
> > > +	vacant_height = get_vacant_height(&mas, ptr);
> > >   	MT_BUG_ON(mt, allocated == 0);
> > > -	MT_BUG_ON(mt, allocated != 1 + height * 3);
> > > +	MT_BUG_ON(mt, allocated != 1 + (height - vacant_height) * 3);
> > >   	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
> > >   	mas_destroy(&mas);
> > >   	allocated = mas_allocated(&mas);
> > > @@ -35514,7 +35589,8 @@ static noinline void __init check_prealloc(struct maple_tree *mt)
> > >   	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
> > >   	allocated = mas_allocated(&mas);
> > >   	height = mas_mt_height(&mas);
> > > -	MT_BUG_ON(mt, allocated != 1 + height * 3);
> > > +	vacant_height = get_vacant_height(&mas, ptr);
> > > +	MT_BUG_ON(mt, allocated != 1 + (height - vacant_height) * 3);
> > >   	mn = mas_pop_node(&mas);
> > >   	MT_BUG_ON(mt, mas_allocated(&mas) != allocated - 1);
> > >   	mn->parent = ma_parent_ptr(mn);
> > > @@ -35527,7 +35603,8 @@ static noinline void __init check_prealloc(struct maple_tree *mt)
> > >   	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
> > >   	allocated = mas_allocated(&mas);
> > >   	height = mas_mt_height(&mas);
> > > -	MT_BUG_ON(mt, allocated != 1 + height * 3);
> > > +	vacant_height = get_vacant_height(&mas, ptr);
> > > +	MT_BUG_ON(mt, allocated != 1 + (height - vacant_height) * 3);
> > >   	mn = mas_pop_node(&mas);
> > >   	MT_BUG_ON(mt, mas_allocated(&mas) != allocated - 1);
> > >   	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
> > > @@ -35540,7 +35617,8 @@ static noinline void __init check_prealloc(struct maple_tree *mt)
> > >   	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
> > >   	allocated = mas_allocated(&mas);
> > >   	height = mas_mt_height(&mas);
> > > -	MT_BUG_ON(mt, allocated != 1 + height * 3);
> > > +	vacant_height = get_vacant_height(&mas, ptr);
> > > +	MT_BUG_ON(mt, allocated != 1 + (height - vacant_height) * 3);
> > >   	mn = mas_pop_node(&mas);
> > >   	MT_BUG_ON(mt, mas_allocated(&mas) != allocated - 1);
> > >   	mas_push_node(&mas, mn);
> > > @@ -35553,7 +35631,8 @@ static noinline void __init check_prealloc(struct maple_tree *mt)
> > >   	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
> > >   	allocated = mas_allocated(&mas);
> > >   	height = mas_mt_height(&mas);
> > > -	MT_BUG_ON(mt, allocated != 1 + height * 3);
> > > +	vacant_height = get_vacant_height(&mas, ptr);
> > > +	MT_BUG_ON(mt, allocated != 1 + (height - vacant_height) * 3);
> > >   	mas_store_prealloc(&mas, ptr);
> > >   	MT_BUG_ON(mt, mas_allocated(&mas) != 0);
> > > @@ -35578,7 +35657,8 @@ static noinline void __init check_prealloc(struct maple_tree *mt)
> > >   	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
> > >   	allocated = mas_allocated(&mas);
> > >   	height = mas_mt_height(&mas);
> > > -	MT_BUG_ON(mt, allocated != 1 + height * 2);
> > > +	vacant_height = get_vacant_height(&mas, ptr);
> > > +	MT_BUG_ON(mt, allocated != 1 + (height - vacant_height) * 2);
> > >   	mas_store_prealloc(&mas, ptr);
> > >   	MT_BUG_ON(mt, mas_allocated(&mas) != 0);
> > >   	mt_set_non_kernel(1);
> > > @@ -35595,8 +35675,14 @@ static noinline void __init check_prealloc(struct maple_tree *mt)
> > >   	MT_BUG_ON(mt, mas_preallocate(&mas, ptr, GFP_KERNEL) != 0);
> > >   	allocated = mas_allocated(&mas);
> > >   	height = mas_mt_height(&mas);
> > > +	vacant_height = get_vacant_height(&mas, ptr);
> > >   	MT_BUG_ON(mt, allocated == 0);
> > > -	MT_BUG_ON(mt, allocated != 1 + height * 3);
> > > +	/*
> > > +	 * vacant height cannot be used to compute the number of nodes needed
> > > +	 * as the root contains two entries which means it is on the verge of
> > > +	 * insufficiency. The worst case full height of the tree is needed.
> > > +	 */
> > > +	MT_BUG_ON(mt, allocated != height * 3 + 1);
> > >   	mas_store_prealloc(&mas, ptr);
> > >   	MT_BUG_ON(mt, mas_allocated(&mas) != 0);
> > >   	mas_set_range(&mas, 0, 200);
> > > -- 
> > > 2.43.0
> > > 
> 

