Return-Path: <linux-kernel+bounces-264212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C7C93E03C
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 18:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A00DD1C21140
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 16:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C99181B82;
	Sat, 27 Jul 2024 16:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="m3LUZRhv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Zs4/BBMY"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F76AB662
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 16:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722099472; cv=fail; b=Sg2yDm2FJcm0RI9AyGhXR5YP7F+UGUk2OaaEyPNf2jZF+m3NfnpeH99J2dvdR5WDJpR/yhlcCYxt03mzPwaIffZeZjm/1YRrRrE7LwwN7sdgAEUf8QzfLABRioVSTRlI/CkALZH+6P6dIusJaqyPuMskcmleNTv4aQvwY3gVzcg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722099472; c=relaxed/simple;
	bh=wb/BePLi8K5UGQDGk2Pp73pZa7hyMviBzHG2FEtEhhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pojo6zH5bn6qSBDwqXASX+8HOFqWw5i7sF/nhfs0w1bXZgL0Ex3zGpNBPatf0sBVSCBOOIwYoJcbXSaU09W3M15JNN7RigftIOG1sGSVIL/DJnrQZ/4dSmdAMvwHotQtKqxwv0GxdPsTf/zCA8Hk1m0gIBNfRcnzKoqEey2sJJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=m3LUZRhv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Zs4/BBMY; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46R6SXAt017475;
	Sat, 27 Jul 2024 16:57:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=YWR3q4DBdr7/04i
	JXnbnP1TZjHUAHQQp3uwrJamyyJI=; b=m3LUZRhvIbYWjQqmrbdCo8B3LSZ/YuD
	4LYXAD//ac1KeTYNslbOQTHxJ3U2zeeQXHXlg3Kc7iOleDb9qt3gBWZHWWIryGS1
	qROi8WHP55XwDCmPnZ0uSNRDTTt7xEo0a2Dv4iM1P+pkpHK2Xaq7pfAPc3fZczQP
	TAaYKIHKvwxN7UUVeObggiMLQaySVN0EbI/Za7uL7RyEvLkCBztRWKtLXmmprZp1
	wOjgDo01YFjRWDCeyUPeE0+R8SOdrk7Zd171r5SxmfcsUF1mO3SxE7B0O1YaKwjp
	3+MK6kFLcJHM4LhBc+YJKR0Nkp495tTyHpS/N+rdcIbPsar/dDNyzvQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40mqtagfdt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 27 Jul 2024 16:57:09 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46RBV6ge030566;
	Sat, 27 Jul 2024 16:57:08 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40mqbbmtfb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 27 Jul 2024 16:57:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jF/Qhj49b+iR5p1G/HHDVWX2T+eIa+HuWDUl/3iMLFiqTirqwxDfQeDivlup9imZOisIlHFTcHlgwWdwULHsEfaJl1+41PGVgvUn2GnLLh2W2jmZX9YWojADnXaD7NI+URzg5cK+a3Lb9lqVSKPm3KWXq9tS+StllgyYmZeQMHL/5QbzSc9mDFZWOO61O5INVVW/bSskzLev6d8mXKEYSOeWwEUkeJR8ycxtEpT/PZKzMu352bnyEAvZqWzwKSjcmF7/MRw+yrVKFAN/ug3iO0B3AHTL1+qE3wDVgnuvPmy3eBSVPPjGIdlEkOArK7G2Vr3INM2ZoWYK1CD/THrRBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YWR3q4DBdr7/04iJXnbnP1TZjHUAHQQp3uwrJamyyJI=;
 b=kfT7p93a5s9Ng5jOqQlMf23aj/FoTOK6Sm1XXigy42z9b6s0SxecAGtul38tFVIBM5Gn9ZQZc9JyUoPJSPzGVq0fyveY/jz8hP0wxU+ynoKvaqUNle+d+HA1VGvRUpJ9qizbeuYqguLcydJ7gE1+CJmAegcko7tBIxJKxtV5FJkTDaoFIIjjhsmIrukHu+wI+a0H2hIWwE33HDx6fM+Gvh1IEgKgpYFsnnmrrZxGnxNHJoHRIKNlChf7/UdDHM6D0DffM/FXdGbD6jjncL25rwkE6wAWmPSgnmTqqrVp/iMSy2GcZcGFx8lWqNH9WtsLjzforcwTY7R2bwYAulcTaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YWR3q4DBdr7/04iJXnbnP1TZjHUAHQQp3uwrJamyyJI=;
 b=Zs4/BBMYtlK6j++G1tB6IL0zP28+KiD2Cr55ecbVfm7M6C9GslbhcUeZ1+obwXmNVPip+BzCBdBcAexp8VFF+1AvSeqUKrqxfzqot5lOCi+qo75WiHbfmnQjOJouOB6F29QpI0O92n02Jy5NwTrtbOOsOn6GTN9Rk9F1g+AP3Co=
Received: from PH0PR10MB5611.namprd10.prod.outlook.com (2603:10b6:510:f9::16)
 by CH3PR10MB7162.namprd10.prod.outlook.com (2603:10b6:610:122::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29; Sat, 27 Jul
 2024 16:57:05 +0000
Received: from PH0PR10MB5611.namprd10.prod.outlook.com
 ([fe80::d513:a871:bbf9:fce2]) by PH0PR10MB5611.namprd10.prod.outlook.com
 ([fe80::d513:a871:bbf9:fce2%6]) with mapi id 15.20.7807.009; Sat, 27 Jul 2024
 16:57:05 +0000
Date: Sat, 27 Jul 2024 17:56:59 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Linus Torvalds <torvalds@linuxfoundation.org>,
        David Laight <David.Laight@aculab.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Arnd Bergmann <arnd@kernel.org>, "Jason@zx2c4.com" <Jason@zx2c4.com>,
        "pedro.falcato@gmail.com" <pedro.falcato@gmail.com>,
        Mateusz Guzik <mjguzik@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH 0/7] minmax: reduce compilation time
Message-ID: <87b65cac-a7f6-490b-9cdb-617584d3edac@lucifer.local>
References: <137646a7-7017-490d-be78-5bd5627609c3@lucifer.local>
 <36aa2cad-1db1-4abf-8dd2-fb20484aabc3@lucifer.local>
 <CAHk-=wjPr3b-=dshE6n3fM2Q0U3guT4reOoCZiBye_UMJ-qg1A@mail.gmail.com>
 <CAHk-=whH6rJeo1WxZWQzTeEXS+8MNV=A2c4qrF-uFYjU-J6U-g@mail.gmail.com>
 <f26b8167-ee81-413e-b48a-0469680fb768@kernel.dk>
 <93243310-22cf-4d44-810c-17629b46a33e@kernel.dk>
 <1d87456d-b565-410f-bf4b-91fe5704617c@lucifer.local>
 <0c5b8177-3602-4840-8956-6196a6175c04@kernel.dk>
 <969b864a-a27a-4bdc-ae1e-e6132dfbfca4@lucifer.local>
 <5124037f-03eb-4966-8b49-a6fac0fd3662@kernel.dk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5124037f-03eb-4966-8b49-a6fac0fd3662@kernel.dk>
X-ClientProxiedBy: LO4P123CA0106.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:191::21) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5611:EE_|CH3PR10MB7162:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a74a076-feea-44ae-f283-08dcae5d2466
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BXRBeLXoBr6s9u0tqryT/bLgY5NR+Iykwd2yNQGKpOFPK82442nwctYuZSU8?=
 =?us-ascii?Q?UrJuP90ZhiApb3KqDrvtFNn/kEmwgul4te9yX4Qwe76vvucB05zHohyNvIxH?=
 =?us-ascii?Q?ff6hrQ7zj/c2NUY29EiNbK0A3z448JibkeG775k9mU5iR8Hq3uITikZN9BbE?=
 =?us-ascii?Q?451IkZzYeppKAfuA3wq5ot9gf2NTNzkk68DMJSIEtcgA/7Uuy14/by+IMk5T?=
 =?us-ascii?Q?uAkF55ReKTmedlkegpvKKDfiiv+5jolTvDJV504u7C/TnbWqFqhK5gPoPAtK?=
 =?us-ascii?Q?M/hI2eoukzGeBhGfXl8/GWh5ZxyxpjmVNTfJO3fJGgKww77vTexdN5NIRXOe?=
 =?us-ascii?Q?oZkqx2CiPCLFPW/Ddmhw6nuWjI3PtP1UvPU3rZ1vqymUVwZb+2W8ZtYeQNjG?=
 =?us-ascii?Q?GRgZUxb903kPqtohS7CvKYT3skSRJrJKldnP9zLtH1Mc7H770m4fPeBakGnf?=
 =?us-ascii?Q?C4SzqDL4Iz6KF+bBRevSwYVmqy7BQxLR/peH6USNV4fXBUdBpIpGM1WVWGNT?=
 =?us-ascii?Q?6CrtE1Ueljy4/mg0z0vuIPvquqS22spN9QL3nn1KL7BrCMR6wM2reLhH+Gic?=
 =?us-ascii?Q?xOwPWJS+PTnLbCbmK0x4zPCppQ5eHGAKUJUYzJvPIM88VjXScSFm2HesL0jB?=
 =?us-ascii?Q?cAzlVNEzUWVrJqAGdPyQIgS+8bQMkH1+I4Ljbae2LF9DPyafZBlmfBVvTLey?=
 =?us-ascii?Q?jMnC7B2R4kCuSKpg1/cfDnuxc3JFDWH/dsxzh2apRSQouXlkfirwEDGNLOIa?=
 =?us-ascii?Q?t9ZCXZg4U4mz7mqLSWU2VgQUZ9GJKnDvVEXpAbthQSZ/KfRsHPw09LAqoc08?=
 =?us-ascii?Q?BCJqb5rYWQ6PUK9iLpJN51UxYqe7vxpjUVFsi9Klghnk1CawX/HgC/a1BUKA?=
 =?us-ascii?Q?MKROB9bYpnb/vD3528AlX7m1cvzT52YnXmpcARFusLny7UcmqPVclMCrnyWm?=
 =?us-ascii?Q?adU3i1Qs2y6Ct5f+6Xl4on0oBW7CWxPp8Hgrlg7f1CGPkOL9hcsSV/5bJuHj?=
 =?us-ascii?Q?k2OCB6DfvwJm+h2jFRvqzCB8E9nbDF6angA6HM27wIqdE2A2HptMo72uV+kM?=
 =?us-ascii?Q?pz+slMWKij8fdEOz78OWiAId+hSheGIzibXvFbpXtuJKJik1NiMgz6Zu+JHL?=
 =?us-ascii?Q?+72Th/jfgVi2N2gH6BqQQ2aYVzPVOhYLYXAeYA78yDUAfJqiwfUY1+iyz7pM?=
 =?us-ascii?Q?qej81XpQW4hiU/M0QKwi5HobT86yLK0VvCXEMuP2RK24YftDsAadLSxDZO3V?=
 =?us-ascii?Q?7qxHmO7w007GUTVTowfzlNgfH2qoAvKPkDVySloU3Yax3IbUZpegtpLnPADt?=
 =?us-ascii?Q?YZQT3HwV3ZqcAFOXTveErW9nySw9tZU8EmavNinQA90EFA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5611.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UFmFxECyJu8ksdt3n6t27yyCeppAJtdQYHkClRPey+8cg27dgnCb+UAwIo4k?=
 =?us-ascii?Q?fmzub7+88GIv96207nPA8bfhOm1rS30Y4mSDuKCtf8M8U5OmaTDSrEsMumm5?=
 =?us-ascii?Q?RmACzD1n3WzMqeZFuC6z4E6vXN+wW/7AKcd7nl/v5nvcGlKKZGZdnATcBc4f?=
 =?us-ascii?Q?rX5zmxoRRUYJeOzFSpKfLFwucPkAZmED0ckfMsx/FHseo26gMKhLm+b5wZh2?=
 =?us-ascii?Q?M2A8CXoWUGelHQfNNnBqn7aaz2dcrahnTUS+66nBu2zZR+4kFKKWY05iuXQJ?=
 =?us-ascii?Q?0YIWxo10Z80u/uNaBLZNleBQzCacqysvVhiUADDpH8dcQtCkqDSeO2qmoIfu?=
 =?us-ascii?Q?P8iPsPoXmHB9VXKQO/uNBkSel2OU9peRiN+iDm59kJdsGdL5bK2z11Ep9Uvt?=
 =?us-ascii?Q?GMjSz0XChCLEPVut7F6Xn4M3xNbHmPXFa69lCx+Re2Rha9iaV8+/s+oQxLOk?=
 =?us-ascii?Q?RsatMmc6+xQZjVD/MTfNn23EKJ4pWaWEnv8UG5tsP/PMKEx7N6Ogcb/icP+O?=
 =?us-ascii?Q?qGpnzJLeQGH6oszFZoDDlLlBXr/MZQAZ/TAfM8s41DKLk998F/fg9Naqa/vW?=
 =?us-ascii?Q?w2b1j2d+OxM0rjM5G0tR6n8qMyHg8489pq0y9NaWOw8QmVruJF4zUnUT/JKO?=
 =?us-ascii?Q?VA602z7WYnfK+t4qPvbSNbqFx/8sRDaSC0TwMRmX2rvpgnj+lFhqFCGGJDxf?=
 =?us-ascii?Q?TF0az613yU3ljQIwv4lOzD7LWoQF1yl+ae9m+MpERXVrRxxyQszkgI54Na3D?=
 =?us-ascii?Q?r6AYh34EF01q1XhbJe7THorZ6J3FFdXlxptwCADfrEasBK6NiSfcx2wvU0An?=
 =?us-ascii?Q?DVBHfe0zhWqLEUPP6Rv1iVWGLtf3u0TBcsL4wBQ6W8Nz1U+6PzAdJBxsDmXI?=
 =?us-ascii?Q?xksw3vuCQZ8QqPXIPs8wIHuRUUasihmAk0GfAReYO98I+OzniGaTqtlGRwUi?=
 =?us-ascii?Q?aHbaaDPaKkhK+WbT2W2wRlzI8aJoHh2RnmYNOlJB5E5Qk+WQulQVaPHGJASr?=
 =?us-ascii?Q?lSI+JGSjIomIgtxg2QC7bHLQk9KdrXTgtiagUF/v060rFQ6M3Mm5FU5DLsDy?=
 =?us-ascii?Q?eeBtQnVHRhzsQG4aGv/I/QCZ8wsk+axl83KaA8ydMWX45SSdKxPiRG2HIjlL?=
 =?us-ascii?Q?DMve5Nyk/4ExAfU5jLuOfS4E+5gvgtMNn1D1ePjjvY9m4QM79MtYJvUGNI7s?=
 =?us-ascii?Q?rFggq8rLX6Gt6U1deZR7JXMyCYnu5LiwIzLNNptHbeTQHvHm+kcIP1gLfZbi?=
 =?us-ascii?Q?jm0zHeJoXziAWPxDe5zn4FqG5epaQqDQeX6xLC8J/piBJPW8suZfr7Lmv8RO?=
 =?us-ascii?Q?GuzxVuu4U2rbwrTQ+9l/5UIlM3VQQVUJVQVI0Eu+yFtnBJgsmvlqVcQk25Dg?=
 =?us-ascii?Q?JbH729gh9sRo2gZhZhHh4vJeSEMnwu7FyE1EXDYCJQGWY95brBvPRRzcxnl/?=
 =?us-ascii?Q?6VHqkp7pnin7hgaktHpyNhhVo23Jsun5uK7VJe+MWaHk9XQuob/U+FmHFRmB?=
 =?us-ascii?Q?FdTSmcNyPjwJLS7rpilZz8TtYgH9yzf+VTSDAdKc5GE6SrJXzlepZ7BZg7RE?=
 =?us-ascii?Q?OflYIzmagAUK10vEZ1rDzWgZQKoLNi7lcz8JqCPpvfxfJ8SL5eQA1ghbF3SV?=
 =?us-ascii?Q?GGwP/aFXWr26S2eIbq/YuxWA+2Fx3ecb3vlPFGRKj+uMdAKLNC9DW4AFGj0B?=
 =?us-ascii?Q?EEY40A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GINIgJOy15DK3VW/R/1tvY1pfIw52wy0LVTUMrOI2NKlZrHFCQ2kvxmq9yjI1nqdpra9dTmydXnD2IsB9fxoej37vMiYFF49rRO3rgyxu5qkFU6e3/0vTwKgOWJ3nApMl7mr6eIVoSHpJRa/rfHtd3XQ2xiWCezOAzX7qqQo4Hc733G2ACKz1M9TlsJGArrPGkl1l4CMLiHI36CFa6MyZKUaMB0ABauRzXxDu+xH/JmNrtaU22WkUsSly7t1KSNi+LsvfMWcCKmzUo44/eSubUcaHuNwJX3cZvKdnC2TEZKETDvQFXyk4H9qLZ3BRFDIvxOnvTQbMyLFMADdVM3CdmRIq/xh2OqZmTMONzO78e0wKrPLjEBhm/LTybmqAMdsMkJGurLdcrSrM3vUWf5nr92F8bPk5ClwcyGkvywDQr+SqdnORs50jXbg4a3Bne+3FF5eV9yhVPgcoyvtSFKd0Vl1wFqi6NqkDFiIhHxFKf+YhoIuBzbHdrvd9SDG5e9OvgbBbdHIBLPU3UN/iT0eem+bph+2AtT4np9Hz84S+Z0xZ/P+owVcwuXSM3vG5nb32dLT2lliuf8pw14pc0M1CRa0z1zvHtqf+pK7ZW2BbaM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a74a076-feea-44ae-f283-08dcae5d2466
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2024 16:57:05.6230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YwhV5iIPtaTzYdc465ncj37SLWBXHg4/2Fm6IQyhjNEW8o4tn6RSu2+Wdt0xiLzG5k8V0mEa7TvnTE/5gytO0Hv0I4M/XIApaifLNJgBYBM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7162
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-27_12,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407270115
X-Proofpoint-GUID: XJl3VcjZRaus-jUMlyByBEii-w7oV3SF
X-Proofpoint-ORIG-GUID: XJl3VcjZRaus-jUMlyByBEii-w7oV3SF

On Sat, Jul 27, 2024 at 10:52:32AM GMT, Jens Axboe wrote:
> On 7/27/24 10:41 AM, Lorenzo Stoakes wrote:
> >>> Patch attached including Jens's change + mine.
> >>
> >> bvec side matches what I have here, fwiw, except I also did
> >> mp_bvec_iter_len(). Didn't see big expansion there, but might as well
> >> keep them consistent.
> >
> > Makes sense, am happy to give R-b tag for this patch if you want to put it
> > forward? Not sure if Linus is minded to just pull something for this now?
>
> Here's what I built (allmodconfig, gcc-14 and clang-20) and did a basic
> boot of. Was just going to shove it into the 6.12 queue once posted, but
> can go either way with this. Or Linus can just grab it and run with it,
> not super particular ;-)

Yeah looks good to me, either way have:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

>
> > If we're whack-a-moleing may as well sort the drivers I found in my
> > allmodconfig too obviously as some hilariously low-hanging fruit there...
>
> Oh I'm not, I got plenty of other things to tend to. Just got sucked
> into the block side as that looked nuts, wanted to make that wasn't
> insane.
>

Fully understandable, and it is the weekend after all :)

As I am clearly a bit bored this w/e, I might take a look at the obvious
bits there myself if Linus hasn't already patched...

Have an allmodconfig build going now.

>
> diff --git a/include/linux/bvec.h b/include/linux/bvec.h
> index f41c7f0ef91e..1cb76a829b83 100644
> --- a/include/linux/bvec.h
> +++ b/include/linux/bvec.h
> @@ -101,9 +101,14 @@ struct bvec_iter_all {
>  #define mp_bvec_iter_page(bvec, iter)				\
>  	(__bvec_iter_bvec((bvec), (iter))->bv_page)
>
> -#define mp_bvec_iter_len(bvec, iter)				\
> -	min((iter).bi_size,					\
> -	    __bvec_iter_bvec((bvec), (iter))->bv_len - (iter).bi_bvec_done)
> +static inline unsigned mp_bvec_iter_len(const struct bio_vec *bvec,
> +					struct bvec_iter iter)
> +{
> +	unsigned remains = __bvec_iter_bvec(bvec, iter)->bv_len -
> +				iter.bi_bvec_done;
> +
> +	return remains < iter.bi_size ? remains : iter.bi_size;
> +}
>
>  #define mp_bvec_iter_offset(bvec, iter)				\
>  	(__bvec_iter_bvec((bvec), (iter))->bv_offset + (iter).bi_bvec_done)
> @@ -111,12 +116,15 @@ struct bvec_iter_all {
>  #define mp_bvec_iter_page_idx(bvec, iter)			\
>  	(mp_bvec_iter_offset((bvec), (iter)) / PAGE_SIZE)
>
> -#define mp_bvec_iter_bvec(bvec, iter)				\
> -((struct bio_vec) {						\
> -	.bv_page	= mp_bvec_iter_page((bvec), (iter)),	\
> -	.bv_len		= mp_bvec_iter_len((bvec), (iter)),	\
> -	.bv_offset	= mp_bvec_iter_offset((bvec), (iter)),	\
> -})
> +static inline struct bio_vec mp_bvec_iter_bvec(const struct bio_vec *bv,
> +					       struct bvec_iter iter)
> +{
> +	return (struct bio_vec) {
> +		.bv_page	= mp_bvec_iter_page(bv, iter),
> +		.bv_len		= mp_bvec_iter_len(bv, iter),
> +		.bv_offset	= mp_bvec_iter_offset(bv, iter)
> +	};
> +}
>
>  /* For building single-page bvec in flight */
>   #define bvec_iter_offset(bvec, iter)				\
> @@ -130,12 +138,15 @@ struct bvec_iter_all {
>  	(mp_bvec_iter_page((bvec), (iter)) +			\
>  	 mp_bvec_iter_page_idx((bvec), (iter)))
>
> -#define bvec_iter_bvec(bvec, iter)				\
> -((struct bio_vec) {						\
> -	.bv_page	= bvec_iter_page((bvec), (iter)),	\
> -	.bv_len		= bvec_iter_len((bvec), (iter)),	\
> -	.bv_offset	= bvec_iter_offset((bvec), (iter)),	\
> -})
> +static inline struct bio_vec bvec_iter_bvec(const struct bio_vec *bv,
> +					    struct bvec_iter iter)
> +{
> +	return (struct bio_vec) {
> +		.bv_page	= bvec_iter_page(bv, iter),
> +		.bv_len		= bvec_iter_len(bv, iter),
> +		.bv_offset	= bvec_iter_offset(bv, iter)
> +	};
> +}
>
>  static inline bool bvec_iter_advance(const struct bio_vec *bv,
>  		struct bvec_iter *iter, unsigned bytes)
>
> --
> Jens Axboe
>
>

