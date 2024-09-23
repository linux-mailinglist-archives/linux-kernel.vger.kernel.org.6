Return-Path: <linux-kernel+bounces-335678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC25097E902
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 11:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AADF282C3C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 09:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA8A194AF0;
	Mon, 23 Sep 2024 09:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Z+wq+nnm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="c+QUuQba"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3F1194ACF
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 09:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727084695; cv=fail; b=duiiJMzSgkVkV+MRyWzOazAFSEUVjHM4evWvdwAoeB26yYIdnteVxKRxVKQ9xnXJSiaENG8tyIOYbL5hRCLns035YyXHUIgIqeEb5TulTvC3/JNLHqmFAE7y22fW63eONznbVaeyBOK0xoG5kyc5lm9ZF9Oa2KVGjNvTO9NP9Y0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727084695; c=relaxed/simple;
	bh=7HgWrKeL619Yh1NC2RPgwKHl4eI060vtG6BfqSpqdOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qXWGPMrJ9UE28vqqKjHKM297E9cn/geyjJ5jbGCAt7D2Mk116zXDo9IHrdfMKwnbyNj55FPgfrldLS558j/E2+Sb3DGARdxEXuvKl3aIrQALcQHdSwM5XWR0LK/RgDobNadFH0cXv3oCX46xpcIJfb0b5ESD5ucqg8gA6TCn+fk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Z+wq+nnm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=c+QUuQba; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48N9fgaS028414;
	Mon, 23 Sep 2024 09:44:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=nHp4VTo1p/5ykzz
	ZzE5EkNweydR5Nttm5+IhyDkrWFk=; b=Z+wq+nnmKjDc/fF12twCM1NVcm35x0s
	OGwt1awrJJcHBwaFeYreROnqZ9Lt6m5Ne8Nuwb99UGqnPvzexNf3Ay8yrUjiql17
	IZW6Y4iJzzQinspMGQ2HhhWV3tiBDQrTWCaPjQg9MrmO/GCh2JhKfk/IKpR1uL14
	Robcg+cSgJpGkrQ+TcbLabOwWoi7WQL7Co+q3dRwHlZrpsT4pLESCdTVEozHW2sr
	B3TJGgT57moO/SsKOcrA9BV3B5If6k+fTuuxECRXAEfK6NmGV6rjnU7umWFrfhlf
	cJ7EvFxKisxQgrKGruWEaMds6cGK5F1vMlBL6eNneArsSRl/E2NXPvQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41smx31sfw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Sep 2024 09:44:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48N7VABN029799;
	Mon, 23 Sep 2024 09:44:41 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41smk7j339-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Sep 2024 09:44:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wVAlwiYi7EYb6mu6sGXg7Mz+tO4DIGPKWWu8zUBkUvtFkDiScot5+LDeNq/2uG5lpkLmGH2//+10Usg9CPBmws+t+j3haIEnxO4WiCXdXvBzbHRg8+ltPzHZU4vCStU/grpvaTnxjgKjlRAjzKc1dIzVupOxCavaOAbFE3dD/0pTZQlYzymb6XT4hMeN06sMjJFsglCYQg1K5zuCzxBrgBWaHM25qLmxCHh71UWgaN2KqxR6t0B3mpQKc1wxUCsujUom8rSTuc0KqYOuCu4HRDAPr36pqC4mdS0duUSpJB5FqLJfcgV+wTsfpLF4Kbk1bWrrZ2wyKjvljtoHo1LsxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nHp4VTo1p/5ykzzZzE5EkNweydR5Nttm5+IhyDkrWFk=;
 b=y+wXpfPglxEDldfK7fyDNoBIhlEfkiw8PosLqbDhbUB1W8vfmvfcyYPjJpDaZ3mF634ihdGapnqbmydSFDnxnMrNp3OQuZVnJeS15u6J7s1vNh/DVOGmuGGau4F3teXkpjvnpsacI2S65a5FHYggc3r/MH6puy4cNUyePyXqKJuWTwar15ddNrMs87fO/Ne+F2FZQ5jGKKH78O5uOe4ixjMgseU2VknYt8PtiiLtg6Foixu4UlR7FuZlY4/RSIjdlT4VpQJX88BMnAxT8qniSO5nofTw91IsltJ3VzcLedmrILg7O6wZvAnbI6HcS2gg5dwWNke9G32PFNKl5zIlmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nHp4VTo1p/5ykzzZzE5EkNweydR5Nttm5+IhyDkrWFk=;
 b=c+QUuQba7dKQ/K7eU7K9QNDo+nXwbT1kOjyM/eQ7kTM0bZ+9auSzYqqFtpIM2yDMlR2NuJC2JGjcAVDxmDywy0/LNeSRWy0FOMQn8DpappGsnzpIGZjy0unqvi5y9cV0rtuBs89TAKMCBohc08M0vCQxopbyAffWJjXS3RGq56E=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by SA2PR10MB4682.namprd10.prod.outlook.com (2603:10b6:806:110::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.12; Mon, 23 Sep
 2024 09:44:38 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8005.010; Mon, 23 Sep 2024
 09:44:38 +0000
Date: Mon, 23 Sep 2024 10:44:34 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: syzbot <syzbot+e01fa33e67abb0b3b3bb@syzkaller.appspotmail.com>
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, vbabka@suse.cz
Subject: Re: [syzbot] [mm?] KCSAN: data-race in mas_wr_store_entry /
 mtree_range_walk
Message-ID: <53e80bb1-9d26-4885-81fd-6fe816b4980b@lucifer.local>
References: <66f12f17.050a0220.3eed3.000b.GAE@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66f12f17.050a0220.3eed3.000b.GAE@google.com>
X-ClientProxiedBy: LO4P123CA0419.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18b::10) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|SA2PR10MB4682:EE_
X-MS-Office365-Filtering-Correlation-Id: 22d95662-3dd5-42e1-a6dd-08dcdbb45711
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|10070799003|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xuhroNNTy8Nf+rOF6D890fCvaf2lOm5TU65qBsYIYKuKCI66pVayBpqlC6dn?=
 =?us-ascii?Q?x8cPkRE8A7WDTYaYmmMiqM7rm1I6p+JaKLMooPffUszhnfq5LhAGyL7aAtwo?=
 =?us-ascii?Q?bqeTCuXAR1KH+/MR/gqVV/cjm0TU1PC7BaMzTb7kdilVVPfSlRmbtjpvY7Fx?=
 =?us-ascii?Q?ZnW81O0SIWo0DT/c9AIiBny+utkdqJmENuZhDF6MAzclGlfreeQUC/TePHqw?=
 =?us-ascii?Q?SQkwvfwPu9hrf3yjI4e/4PSfJkY+kFdgcdPIr/A7NEuLeSx8ZNhq+Zqm9Zj8?=
 =?us-ascii?Q?QT20UDVXGXB3B6WMO1OIfuDTktQUd8CgO4JDg8Pf6mw/akkxQEcFzMF4Odif?=
 =?us-ascii?Q?MabO9XaI2McTpAcRcRj2AxNqPowgrLA9MQ5M/yBW92OdU7LjRrYsK5AFaSDl?=
 =?us-ascii?Q?IH4ek9Qjj+xBr7HJtDR+4e2bjWz4lmKsZ5+tCJ7xo2DbEfv6+isP8Y6T2sro?=
 =?us-ascii?Q?B7CCQa1oJwzcqpFeDqcNXT0792Ag62VoLxTCMmbTdwQVCcRPReXuHm4Pv5uA?=
 =?us-ascii?Q?QN6aIEKhnQwUp6D+hljpxBSX0RPV9yITR101jiX3sjDcH83G7FbGoO5Zg6D7?=
 =?us-ascii?Q?dUSaR56nln6f87cUrgxKmA1oui2WAug6jmb6dONT3ACBQWiZ25ZGn/jkOERG?=
 =?us-ascii?Q?ior/yPQHlB0tYudj6rxUSutwvdXFbh7gme5EiFB11ciHsqPkQMEQn/GVxa1U?=
 =?us-ascii?Q?ZANDdkhzSEuTnZOi0M5J6iSQ/37BwSQ+CxytnxR81mPEcf8OM6p7TISNcYLa?=
 =?us-ascii?Q?VeNNVKHl8h4mDIJKSyoraeaejKS4DqvX16WyNJFLOVyXJsoM0hudgAu8ACUm?=
 =?us-ascii?Q?5T+M+VMDIsfesyu7RiC62GFHnOkQrwTPlayb30vGAFYvA0/T8TngonKzjiy/?=
 =?us-ascii?Q?OKg+ULTbiM4YiWXqNkZmmHxR1RWkPg5YszzdQ/la0ttgs9mP+oQu2H8cxQti?=
 =?us-ascii?Q?R4L4afsCAe2blujkuF2WcsEC7BwH+6D1Cx+EP9ImCd5JD2R5NNy8AYQQjn7x?=
 =?us-ascii?Q?kr2rDBMwcwUoBk2MFGWcXHUT7f+JbKkRpH8fxHB8MYQp+ZuVqSnv8QqNABoe?=
 =?us-ascii?Q?Xl0CWb4IlQtipbswm57NGbBPmBq96ukP59AyZdDlfkaLrggjxc/ipsa7kCLU?=
 =?us-ascii?Q?OQRq45s6RDtNbdDVSXFfKIYEFtlRuKboPmpJtm9stXYbacmzEzusctkgsLMY?=
 =?us-ascii?Q?byHEdbI7SWsSTu1XUo+b2lIQX65wKyM4puZ1CbkTpUGKcOuVMIL6Qqby2Ko?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5iacxdckDf7mmTd1MZhTfFw3zlhcSDbG1pAj5jphdELWlu03gm1eLYcldxUj?=
 =?us-ascii?Q?q8pmTdYeO7uCmwL4dzl13hfSRXDVOU5Mx1+YfIm6HvVRyEYmc/jqAhPHW7/P?=
 =?us-ascii?Q?cLxyn+Q1kA8e/I4l2kmcbfDYrCZJ6mki/jELBhmIHz6h40xKLPHWoRrrcGQM?=
 =?us-ascii?Q?Cv/u4gfT6jy32u2R3IHPvA2gbjUm/O1yEngScyuexq2rE0wwCMhw//hhN9D+?=
 =?us-ascii?Q?Yq08wN7ylao9ck2qK8e2OwyuWbz8CwJAe9K5UnzPyt6WFYlu9PmfOEPus7d4?=
 =?us-ascii?Q?ZZyWGEz/t533gL7cSZ8ps96zx2gTQBBQtYKnmZa1NvBNR5bpKgmspoNubIZH?=
 =?us-ascii?Q?4x5GS5TkuuLjsMT9IT+vI4aM3zJnEckfBR5RSPUTveoGWlXQcxBeHbSrQLcw?=
 =?us-ascii?Q?o8W6eYKY/M+k+hCq4YYKGvx3dfmQcJMgsU8Mun7M7bui8NRC18JfrApvRJxd?=
 =?us-ascii?Q?Z9h4YpoEo/fBnMjLUklOviUnel93FnJRm1+ZdCxScdVSiRUGhl55QkZjTRIY?=
 =?us-ascii?Q?U4iUmAuguYn4jQZT+Ah+jZGVxQfFmC69wWUjxP4X6lFP79Ykfrx7X9Ewzrv4?=
 =?us-ascii?Q?aWBAm+CmjFK8OSg9pS7trFaPxzOY+UepxgZHmGuny66AO7axhDwz0UeO16pP?=
 =?us-ascii?Q?T7/dFjvf+2EURIKoN7aBYOBaiFxNpDE3A6zpko82pUYc3tWv1h1krX6OdaKP?=
 =?us-ascii?Q?ElROFpouZMPWrth1gnLHpg53KUQqvRILVxe374rYYIyau3/VgWgjZkzC2QOC?=
 =?us-ascii?Q?bv6PzSPJQQEUz60rw3/rbg5QsIAV9IbELQ9/M0ETQUKMQRV4Pr02TH/wTkI+?=
 =?us-ascii?Q?/7nh+SmSwhSPJH4Wu6FtocvvgMGVArwZpCD1b7IXigOpujybMn6cYy1O9S6d?=
 =?us-ascii?Q?NZCPnvsmoABEifPgvSHg/i40bnbDqBuSc0WiHtZA1tOaLtg1uSfg1Co6k9jl?=
 =?us-ascii?Q?SaRJpbvnBJ1X6MhvbUadgIs6OM9ai7DHqATuK60o3Zof6NM0dxoEYuB5b/QL?=
 =?us-ascii?Q?fR/LmA5HK2Yh9dPr1hibYZo+RlacxcdXTiKJcAiF+vj3nln5Va+3Ip+r4bsT?=
 =?us-ascii?Q?tkp+jYtOSfYP5EXmXJmQglCeo2fhm/FYYBBhtAWFR9B76qyeOHJt4YpiyVyn?=
 =?us-ascii?Q?epv48eKHHxlKoFQhgo9zRzpr2QJdDsFOD8pp3ia3LZvVNvaiduTYg8lTosb4?=
 =?us-ascii?Q?gOJTkfG6uhMvkXDH9mX/ZIZ2SKxGUZDQ5e8CFHEvadOiddwEZBhf7s5zuNUy?=
 =?us-ascii?Q?L8jwq4ZIWhnM8lA52Wkbzy7kDwKM2ahq+vBD1zgbKXaoipSZvGgxDjGNmmkJ?=
 =?us-ascii?Q?j5Zx4zDwIqRDoieou3fceGfntwFdIUc3yICS2oirTNsta7O6PldK1cNwFR2e?=
 =?us-ascii?Q?CaFKD/41Oxn7QiYI4jwsqt7frpdbMeTYbU4rG/7fhOEwoXjR0sfU64shoTh2?=
 =?us-ascii?Q?IvJd4bPjpLyo3fgGSYs2Da1W4/Jq4p/QDAgjS7xar2AODbaw10giXlmzHea7?=
 =?us-ascii?Q?21zGodNORsEEqLNbfcBLDDKsscu6XprEtmEgdL15JhxLIiUb+iLiaOfnv9X2?=
 =?us-ascii?Q?pS0r2kkcb3wKf+rX4VvhtoZNo0cjoPvQZwHC3Kaz9+ShFeYenya2JCGjW5nC?=
 =?us-ascii?Q?2VVa6Nkcv3jmB3GmLlHHnay3gcKsJ8HCJwZ10HSRfodOFwP2lafts/w3aFNQ?=
 =?us-ascii?Q?iebr0w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gy52OGdTjtE4Luq2BovLf7CTxkaPBZvk817yqYjTHWCrrK89YClBntVZNOtWpf0uoN42PN1iYpdQdCYnwJUY4X/+QfYD1OfruTuYv8ucHv1Qk8inZV3lZcANejEaPR0H/l7agLRhkrKZ1/7zZwGT0TxtUBAnprJpPE3OypwOcVIckoLTaF9J8VDj0YHJhIJ5BbGnPK67ANtndW9gn40zS2UnEO+BvsimZ5J3xp89fcBghYm8lT0e0rr4GWxuZvKWcDZsTccOzw+phTNxkeOHPMpCVfe01u3Qdm3/w9BeZZ6fch0Gmv/zbLzvX6+oolB+MpQNfej6SCD9IVCKa4agpfBFTdlw2J4iO0mIAkhzAc6qROuCulj/ldbD/ef/V3B6I5igMjei3by87do8SiL4gvTDvhgl1a++a+0URZvc4XOcBYMZOJMHdpmOzTRxR72UM68LFQ6z/VbMwvZzR8YuUXF9GJLafgZ6EWJcnlKGh6350PeyUgmEG57oakBsm5PSjzXyvZ75zUQJQT0DAlzMHkY/VCvvvQvg20MYvP1f+CDmnP8nX7hbxezsF8hxg/hKJDs95TRXpd+PlkKeCCK6VkpQG/DzN8Yd/cIvOzECHXE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22d95662-3dd5-42e1-a6dd-08dcdbb45711
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 09:44:38.2220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OIRzHERmOUs0Y72qj77Q/o48M/at5uWjQVbRi5U62+HTS5MOrkBev+9ncK0dOh6kOziO3eGL4s61dkXUsHiSd3sutq44cNcHlc5odRdLC+Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4682
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-23_05,2024-09-19_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409230071
X-Proofpoint-ORIG-GUID: Y8BXnwzlpJCSUekFBQ-IIV3pRgpXZr02
X-Proofpoint-GUID: Y8BXnwzlpJCSUekFBQ-IIV3pRgpXZr02

On Mon, Sep 23, 2024 at 02:04:23AM GMT, syzbot wrote:
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    88264981f208 Merge tag 'sched_ext-for-6.12' of git://git.k..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1237ec27980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=e6702f5f2b8ed242
> dashboard link: https://syzkaller.appspot.com/bug?extid=e01fa33e67abb0b3b3bb
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
>

Thanks for the report, investigating.

> Unfortunately, I don't have any reproducer for this issue yet.

I suspect given this is so timing-specific, a reproducer might be difficult.

>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/95bba355b2ed/disk-88264981.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/75966f4e5286/vmlinux-88264981.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/7f1578876250/bzImage-88264981.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+e01fa33e67abb0b3b3bb@syzkaller.appspotmail.com
>
> ==================================================================
> BUG: KCSAN: data-race in mas_wr_store_entry / mtree_range_walk
>
> write to 0xffff888114555710 of 8 bytes by task 9573 on cpu 1:
>  mas_wr_slot_store lib/maple_tree.c:3889 [inline]
>  mas_wr_store_entry+0x146b/0x2d00 lib/maple_tree.c:4075
>  mas_store_prealloc+0x6bf/0x960 lib/maple_tree.c:5520
>  vma_iter_store mm/vma.h:470 [inline]
>  commit_merge+0x441/0x740 mm/vma.c:609
>  vma_expand+0x211/0x360 mm/vma.c:1024
>  vma_merge_new_range+0x2cf/0x3e0 mm/vma.c:963
>  mmap_region+0x887/0x16e0 mm/mmap.c:1416
>  do_mmap+0x718/0xb60 mm/mmap.c:496
>  vm_mmap_pgoff+0x133/0x290 mm/util.c:588
>  ksys_mmap_pgoff+0xd0/0x330 mm/mmap.c:542
>  x64_sys_call+0x1884/0x2d60 arch/x86/include/generated/asm/syscalls_64.h:10
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> read to 0xffff888114555710 of 8 bytes by task 9574 on cpu 0:
>  mtree_range_walk+0x1b4/0x460 lib/maple_tree.c:2779
>  mas_state_walk lib/maple_tree.c:3601 [inline]
>  mas_walk+0x16e/0x320 lib/maple_tree.c:4948
>  lock_vma_under_rcu+0x95/0x260 mm/memory.c:6224
>  do_user_addr_fault arch/x86/mm/fault.c:1329 [inline]
>  handle_page_fault arch/x86/mm/fault.c:1481 [inline]
>  exc_page_fault+0x150/0x650 arch/x86/mm/fault.c:1539
>  asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
>
> value changed: 0x00007f8311576fff -> 0xffffffff8529a680

This suggests we are failing to acquire an RCU lock on mmap() (though we
have the write mmap lock).

Maybe we missed an RCU lock at some point, but I'm a little baffled as to
what could have changed in recent series to adjust this.

I will dig into this and see what's going on.

>
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 0 UID: 0 PID: 9574 Comm: syz.0.2084 Tainted: G        W          6.11.0-syzkaller-08481-g88264981f208 #0
> Tainted: [W]=WARN
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
> ==================================================================
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup

