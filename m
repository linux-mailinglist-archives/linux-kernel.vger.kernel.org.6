Return-Path: <linux-kernel+bounces-244792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 846A692A99B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 21:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A758E1C218AE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 19:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9734B14C582;
	Mon,  8 Jul 2024 19:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="g1ij8y+y";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ntdk4JnN"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71BA7D07E
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 19:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720465838; cv=fail; b=rSPrd/E5erRheLuc5NVVIL8jramCix+Z4DamO8sabxO7bLHXbb8rP41KEVQmAc3KhqzCyiD3ni5P5mEEYV9aPnMfVMP3ERPyG0iLRZQUBEsG8hjtHxy+r+noT2bOmwMJnTyw+8hvNPcx0WML+yOz/UuNwhLdUkjzdsjYI4ncE4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720465838; c=relaxed/simple;
	bh=wC2AB8vwLgp8yUsCvMKJ3X+5ZYL7WO6IYDj6qZqHm+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rrB3eDoljfpuzQGIF+cf7XTMFEDyhvSfeReZ2iIgHO0ueKJ/gH1b81iqt5ZxGj9GytmDWOkXGVd2K8sBLPjJyfZ8BOn/b6lh5FEnhym2ug6Y5kFkhbYeFBZX9iXfy6j/Sa/kObrCcGNOpQ7fcnmZj6Wo21mPIGA3ADmqc7pRZ7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=g1ij8y+y; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ntdk4JnN; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 468HXnlb016279;
	Mon, 8 Jul 2024 19:10:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=3EtYOW8fOhbYnbO
	9u6MpoAejfh2tRAmPtv0m3DWUK+g=; b=g1ij8y+yXt4x/UtXJ7aLF2GgFozDrdU
	hNM4m/SjG5ce7F7vQkfBZ+cqvbx5qgnWqxaBqhZM2N7ko5hyZ9rIEr+RbcQXqNR4
	d7dxxqsgMHgtN/pxWWrzMLxwdE3sngmw6OGTVH71J9Omk0tPT0QxxMTmb+hWLK4j
	rWtCjxA95rN5uEmRFYtsCYMBNJs/71SMelk0EURbIW4UmvcRONIPyPn0u3xPWlL2
	p2g3QTIZZgxPNI+Jo/wc1Dx041jQY8IeRCQv6PEKb/ybR+FLL4ZmA32uNQYQt56G
	idy/ZTDwK24zFF5vlN2087xdIekCNdzjueYIa2vVtlTo3Q5Fb3VXTDw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wt8bcdk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Jul 2024 19:10:16 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 468IUMGU038841;
	Mon, 8 Jul 2024 19:10:16 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 407tv05p8e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Jul 2024 19:10:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VZ9rQTl3qBY2Bwo3VxatcKMsFAWL5CC3WsRR6RnUhqVteQJKCDjXUT/yfIYiDdBiTFZdMUP9F6hjYTF2LamxAVLwU4C5qETgS9SHXEU58F7CogFKaJ6927BuDSwOmH/dkNR7tBT+W3VHY7fGLpdRHQ8SjLIqElXhMVwXg/fFZ1228xjXfvoslrHkvHdVB6gWuQuAw1sZSykvzObJon+41Y5xadbXzX8SuWndl77fdP5obxKdMCVgr/omBJBEnYpi0egEKxLx464YFF51CHU1Prj/blI/b3KcP92QFkVCGzvuqoJXG2zqjPb4nSdJDePeXNeGtHl9wjqWEwACw4Da9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3EtYOW8fOhbYnbO9u6MpoAejfh2tRAmPtv0m3DWUK+g=;
 b=HH363Ri08tXe/FDABjtvOAh1vHFpln9sBY16PUMSV9DuL4llluKq+HWXd7Cl2a2QeXnau78JluYUwbd5iq2kkbJH1KLcz5WduelXYp/8Vzdhx+GgCVQz5rM2PZLNwasKccu/cmDpblA1ajODiLuAG2sJpb+tu2VP454a7GrpwgrEYc17bEiJ+cmCFQWtSjhxECzIc+QDulyI8bUDDNrVnZNkDZoiV3gJbHD1cfVBYIyLIGMgSmK/g4s1udVv9nPcXznI8Y0AY3IFA6LCE6YLYEhO6CEeniyzBtAtd/JBrn0vkRuk96YXXA+neasVLliIKlRyWfvS56ThGjFu85pTVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3EtYOW8fOhbYnbO9u6MpoAejfh2tRAmPtv0m3DWUK+g=;
 b=ntdk4JnNtkoOYKWys/SeScGiJUcN2GO9Pet7L9DYXUrXuMcvs/e0W2t6PyBoi1G1935FjxvXtNX4MAgSZQolR0i1z1NtDdAJvZP7TMghp4mYLlB1NfrmUKEkd6iKXs7VwO8oP8Rv9I0T4dpgoeK3trbojcnkCSknBtgS69Su3FQ=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by MN2PR10MB4271.namprd10.prod.outlook.com (2603:10b6:208:199::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 19:10:13 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 19:10:13 +0000
Date: Mon, 8 Jul 2024 15:10:10 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v3 13/16] mm/mmap: Avoid zeroing vma tree in mmap_region()
Message-ID: <fhshsdxi4axwriv2od7lkqfzhhydccnwnov22caw5lgbfuy7mi@5hf73szoc3uz>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Lorenzo Stoakes <lstoakes@gmail.com>, Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com, 
	"Paul E . McKenney" <paulmck@kernel.org>, Bert Karwatzki <spasswolf@web.de>, 
	Jiri Olsa <olsajiri@gmail.com>, linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
References: <20240704182718.2653918-1-Liam.Howlett@oracle.com>
 <20240704182718.2653918-14-Liam.Howlett@oracle.com>
 <867602f8-85bb-4c2c-81df-c15de15a2bf8@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <867602f8-85bb-4c2c-81df-c15de15a2bf8@lucifer.local>
User-Agent: NeoMutt/20231103
X-ClientProxiedBy: CH0PR03CA0308.namprd03.prod.outlook.com
 (2603:10b6:610:118::10) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|MN2PR10MB4271:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f8792fe-32f5-40aa-e639-08dc9f819829
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?qsbmO58Vx3EJN5eLKevtQFGdIXb7zG8IaG98HtVyxsc291rJQwUxaIwidkP5?=
 =?us-ascii?Q?yJ0SCaJjudMHJPtgCpMYfs7JABtGYR2aKVKiRdpoD3/p/ygt4n1oJ+uQCbFf?=
 =?us-ascii?Q?fJcyzitQVevAS4SGFHH7uCnpRVc/QRICtQxb/A5emC6PwqfSJqXsaqJ+XD2B?=
 =?us-ascii?Q?pdNqskK6mTtzXJuB9Jj5h3sdjXhXL3z2mXvBMS8akWNqRD/dqDwg22hdrjbF?=
 =?us-ascii?Q?u7dZZJic+jRnKH7EOKrEJ6P5lwsduwrij5JQ24+QVP2iFb2gtMGLA/XOnIp0?=
 =?us-ascii?Q?Agdgwp4q2CiVczoFWnOycOE6aD+/j9Zg9H/qu4qet3m4fOvNmjXkyg93pIKn?=
 =?us-ascii?Q?y63Vtpp8CiSTd/xfQ211xcAL21XZ1x+KMiru6FbdgJ48qHOwczOdAdWbtrDa?=
 =?us-ascii?Q?4igaT3IKY2fgTPqLflKoBspCIRkpnMQ9EYADAFybuamn7ZNjN7AXkNVQj7BH?=
 =?us-ascii?Q?ODAvOmBDySSsxyMCXXRHFP9f4kIuRSYYW8FH+Tn7moaQr13qp/SP3MNOTEfu?=
 =?us-ascii?Q?oRINguZXmBvQViHwhhkyTMyYb04KegbzNXiseOsrKN58W9dI3phNbkaPuQSK?=
 =?us-ascii?Q?10vbAAnIl5YLklmGyDM1JmRWuRd/p46yZpFODO0E1uNjuFgoz1vJLcQbIOMc?=
 =?us-ascii?Q?GEkltcJdZ1VQc6Omu6ol6mF9JkAwUJOiRwMjo9I4gr9QIxYWfiqsy2n8Rj1v?=
 =?us-ascii?Q?PZMTVBV1pKTmwdYKMR7xaNX6N0IpM2N5dC49oqSRghgp8KIoaeZci7Kz/nvt?=
 =?us-ascii?Q?ROIP6XKWqtSPNah0N9361jzPRUa9cKALa87FqRCvT1amFSrHJ+nQdkwhWJ3G?=
 =?us-ascii?Q?fXZA6dW8JHYgxo1+j9NWEplrG765VEIrY4OMWgyB8TJoRu7Z3jOmiZ5Bqpxs?=
 =?us-ascii?Q?6vOFJqdnEk0Sr0qHYJzNSJlAT44U+wrXzFnouupEXTQqXjdqAtlDkKu55Zmd?=
 =?us-ascii?Q?FMFeksz7ggm6KpOn2z+AKc9k+TTmQXkH2y6gMafG2eNAAnbS4u20RpQzRJJ+?=
 =?us-ascii?Q?pJekRbwsqTYhnSlhFKWAoBuzJgXgQ4rhF+w10UvafCdcMAXjcPp29+3It+T/?=
 =?us-ascii?Q?fzouiZzDg9nTdYXU7mydm+FCHdARrOY89eLgi3PqBaiFhC0V5vE44d5Xcm1u?=
 =?us-ascii?Q?iOecitKTF96HKCnVqjI2QYlvnX6EpNqeeiaMfWdGc2Vf28/JUglZeyJ8lwOn?=
 =?us-ascii?Q?2oJJd6q4DPpSIcdIgz/IO8Is9VmT1Niw2kqgPCtdpFjMM0oMP6GHJR+Vy1xm?=
 =?us-ascii?Q?UrlVEfn9gpAGygovzbGfR8j5vah9oDHH3alFJb+/pmSltW1VpIn9UKrrc3WT?=
 =?us-ascii?Q?eLblkOciC8I4K03/ThknVp60r9a/i+q4zp8livCQ9C4AnQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?XB+5Pi29d9NymHdB/fSQEMKpCs3yXAZ7A3BKMskGqP77vPTlyR8huwr14VIr?=
 =?us-ascii?Q?rT5OwIiKYTaJFKj/yis7yIcoBUQ2PyJ69fRTXzRzF9ECtoCCmPrCeFB2X434?=
 =?us-ascii?Q?pZdLz0RVhdS5D0qlfqyU3LZSHO9bNQgmz2zZ9eStbKlhB/Qe9pe9gxkxbnpe?=
 =?us-ascii?Q?mVedob7Q0Bo0ehVwDtdNkz6YjTEoA+TPkgF4wcqb+cuvMZuJroFOAr+4fpio?=
 =?us-ascii?Q?SaLmTSd6ygUYBglHJ27QsKfOET+Q6/p31DPvR+Sp+pbUkvxDGzpWtkYiaUJA?=
 =?us-ascii?Q?LLBeKTkgeP91HhJLlsmP/KzkrltiALuFGy8PVMWlL4ZNXgQ307PnLkhpqsS2?=
 =?us-ascii?Q?BFOAEEaWNQv4KHAZ+MDPaqS6a0Vu2vh0Di0YVdVoHvTqPB92MwReAF3or5FX?=
 =?us-ascii?Q?XsHOaIGqjCmjYRxMgrmItG5oE5l0IEtAY0hAkydNv/jO8Ty+JJhm56hyYmT5?=
 =?us-ascii?Q?wEwii12ryh8Kpn93O/K5bNOo0TdsFbhiO3k85rortCHqew0An2OGdIFWv2Oq?=
 =?us-ascii?Q?JE2cWIPgSklWH2YckqKsjWrRRUuNoiznojfXNr9QUXDpXGMuxEU4eCUBb/A2?=
 =?us-ascii?Q?ANf4BAnuxLUx6dLsk0O59YE+RXOXq5DCR0zat3uXt13vv2EPNKKDMGfT1y4/?=
 =?us-ascii?Q?lm7poqwQgo6mptd1jcOO0s73uCkMLRoOuY67nngjhgdthCxyGZ4FrYTIQKIy?=
 =?us-ascii?Q?g2JE9tHjlvcFS+z51pKHhahIkuhtT3f2Of7iHyzFTRLYJjXSiedydBCqs3Sd?=
 =?us-ascii?Q?ec+AY7+cYE67+hTyhZf/jhj9IcJkyF7Qx815NBEnohdPKx8XYhuXgISYQPbo?=
 =?us-ascii?Q?J7CcyltX3FhlODz/B10iqjbqZ7gA2AdTXaZ8d4iFUsdzaFn7w+G5RseZ+RRf?=
 =?us-ascii?Q?/eqZvIgFS/bWLIaB09d4W3dUoF49S8IVgt4L/z73xrcnt9390vPjohK7S0zg?=
 =?us-ascii?Q?jvRO5nWcaMuDVRnNFzklflxyqXEuDwAx8z2VHOJLYy7Sinujfv90IfbpJwYX?=
 =?us-ascii?Q?uGB0KDiYeeoeRA3mbe+8h+c8fBGqmeiQ9NoXW1pvaopdZQHfGzct8OrZxyCG?=
 =?us-ascii?Q?+s9TkkR3mm4QvvjvE7N8QL1h8s0yHPm/tADu6f3HF1dE5cVkELhql/pf+7Gf?=
 =?us-ascii?Q?tSTidEDl09W1G7f2UHI0wrLBjpMbdeLZCNt+/5NBZJyK657CxoIXwP/UQzJJ?=
 =?us-ascii?Q?oPi4nTNxAWHmoXkQjthdrMZyCHhUh+lzT5EzeAom/h/af2K4+Rsh5e2QKQuO?=
 =?us-ascii?Q?/dEsbK6TAdnaR0Y4AjaE5VWW8di6c7bSA1H0T/nxWQV7oeGDf1vfpidVfcne?=
 =?us-ascii?Q?bF/4mJVkVy7exw1m0u9HCIlqyo4sQ8xxbxOETjPBqGTYVM3bysv57J86DnqS?=
 =?us-ascii?Q?129CXWuqvGz96iK2VEWvOzt4v0hv1dsX2VWFCRdPv63ldKAb4PXoQQ2qw5+y?=
 =?us-ascii?Q?LRpgq42zLaoWLg4USV+1ZXpc9Xl6UQL3+N6h/HzGZw57pY1Maif/64JMRJ8w?=
 =?us-ascii?Q?PryzxAwyj3C49F2Xr0wf+rBLpY6L5m9jQ0Mwzps/W9e421hH7pZXF/HTYHqu?=
 =?us-ascii?Q?ONNqcLSEqGysia6KAiwEklSpD5JwkuYf8+xlAYwUMLBNWc4Mny3aXUE2ix6F?=
 =?us-ascii?Q?jQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	jiXZdqvL6GPHIjzwUqjHjLRYrciOD1xAHJTOF+qhAtJBGjxPKfkKcTrUZkEHw1hTe5tMqxxQ5yAft8mH1qBs7lP8pvyGqupv4FYN1MQpRy5wSZxrcf2eE3zHeBH2KCPqMat5OWjpkzE5S/t3VxIkcpxxKjfxKcPAxz05bKUI/k+VeDfajn2IjMDxcvfyS0yLAO9XSbzjgg26B6Hp1QhtpBn6PvvgKmYksiiqUOvJE1QWydY+d4v/PtM7WYYxz9sOOHQf3zoXzLTttMa73mtedja4bQTNAMrP1VwSNPOMQjPCaCXePg0313pEMbCE2ewIwGetQQLQMsEhQsj3jlm4b8bbXa94EYU88t3dtEZcbp4/qayzSCk4cmyAkSprSOMU+5s/xvrHTdqCxf7nBiN+7RWqIVE0LlVicGnP56WLZsU7LSjlMIGM5jCERqDItEDZDUpCLjaUcEwoY5SRjxyLaNPzhrcrsSyknF65skYDXVBc4ZWBdMrYl1m+2GTIncVy1LGL2Pco8SD2kanB/zfhSN9RQfsjd8LRyUuymxS+pw0nB4msQySaNbb63VhEhlDDx34dftSyfRCFBTQXtS3mKndEtSvE9cP+wzG9XxdGcS4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f8792fe-32f5-40aa-e639-08dc9f819829
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 19:10:13.4025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +gviPM1A146ImJbimFmZdmB4fe9ywaAFH58Djq+ie5D3EZDGwTPWpPac4gq8pU6KX5AL1RpjBT0AP5eCeyzmkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4271
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-08_09,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407080144
X-Proofpoint-GUID: rMy2zH_dNNGK3mTtgDgSkLiciMRdiDHb
X-Proofpoint-ORIG-GUID: rMy2zH_dNNGK3mTtgDgSkLiciMRdiDHb

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [240708 08:18]:
> On Thu, Jul 04, 2024 at 02:27:15PM GMT, Liam R. Howlett wrote:
> > From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> >
> > Instead of zeroing the vma tree and then overwriting the area, let the
> > area be overwritten and then clean up the gathered vmas using
> > vms_complete_munmap_vmas().
> >
> > In the case of a driver mapping over existing vmas, the PTEs are cleared
> > using the helper vms_complete_pte_clear().
> >
> > Temporarily keep track of the number of pages that will be removed and
> > reduce the charged amount.
> >
> > This also drops the validate_mm() call in the vma_expand() function.
> > It is necessary to drop the validate as it would fail since the mm
> > map_count would be incorrect during a vma expansion, prior to the
> > cleanup from vms_complete_munmap_vmas().
> >
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> > ---
> >  mm/internal.h |  1 +
> >  mm/mmap.c     | 61 ++++++++++++++++++++++++++++++---------------------
> >  2 files changed, 37 insertions(+), 25 deletions(-)
> >
> > diff --git a/mm/internal.h b/mm/internal.h
> > index 4c9f06669cc4..fae4a1bba732 100644
> > --- a/mm/internal.h
> > +++ b/mm/internal.h
> > @@ -1503,6 +1503,7 @@ struct vma_munmap_struct {
> >  	unsigned long stack_vm;
> >  	unsigned long data_vm;
> >  	bool unlock;			/* Unlock after the munmap */
> > +	bool cleared_ptes;		/* If the PTE are cleared already */
> >  };
> >
> >  void __meminit __init_single_page(struct page *page, unsigned long pfn,
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index 5d458c5f080e..0c334eeae8cd 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -401,17 +401,21 @@ anon_vma_interval_tree_post_update_vma(struct vm_area_struct *vma)
> >  }
> >
> >  static unsigned long count_vma_pages_range(struct mm_struct *mm,
> > -		unsigned long addr, unsigned long end)
> > +		unsigned long addr, unsigned long end,
> > +		unsigned long *nr_accounted)
> >  {
> >  	VMA_ITERATOR(vmi, mm, addr);
> >  	struct vm_area_struct *vma;
> >  	unsigned long nr_pages = 0;
> >
> > +	*nr_accounted = 0;
> >  	for_each_vma_range(vmi, vma, end) {
> >  		unsigned long vm_start = max(addr, vma->vm_start);
> >  		unsigned long vm_end = min(end, vma->vm_end);
> >
> >  		nr_pages += PHYS_PFN(vm_end - vm_start);
> > +		if (vma->vm_flags & VM_ACCOUNT)
> > +			*nr_accounted += PHYS_PFN(vm_end - vm_start);
> 
> We're duplicating the PHYS_PFN(vm_end - vm_start) thing, probably worth
> adding something like:
> 
> unsigned long num_pages = PHYS_PFN(vm_end - vm_start);
> 
> Side-note, but it'd be nice to sort out the inconsistency of PHYS_PFN()
> vs. (end - start) >> PAGE_SHIFT. This is probably not a huge deal though...

I split this out into another patch for easier reviewing.

> 
> >  	}
> >
> >  	return nr_pages;
> > @@ -522,6 +526,7 @@ static inline void init_vma_munmap(struct vma_munmap_struct *vms,
> >  	vms->exec_vm = vms->stack_vm = vms->data_vm = 0;
> >  	vms->unmap_start = FIRST_USER_ADDRESS;
> >  	vms->unmap_end = USER_PGTABLES_CEILING;
> > +	vms->cleared_ptes = false;
> >  }
> >
> >  /*
> > @@ -730,7 +735,6 @@ int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
> >  	vma_iter_store(vmi, vma);
> >
> >  	vma_complete(&vp, vmi, vma->vm_mm);
> > -	validate_mm(vma->vm_mm);
> 
> Since we're dropping this here, do we need to re-add this back somehwere
> where we are confident the state will be consistent?

The vma_expand() function is used in two places - one is in the mmap.c
file which can no longer validate the mm until the munmap is complete.
The other is in fs/exec.c which cannot call the validate_mm().  So
to add this call back, I'd have to add a wrapper to vma_expand() to call
the validate_mm() function for debug builds.

Really all this code in fs/exec.c doesn't belong there so we don't need
to do an extra function wrapper just to call validate_mm(). And you have
a patch to do that which is out for review!

> 
> >  	return 0;
> >
> >  nomem:
> > @@ -2612,6 +2616,9 @@ static void vms_complete_pte_clear(struct vma_munmap_struct *vms,
> >  {
> >  	struct mmu_gather tlb;
> >
> > +	if (vms->cleared_ptes)
> > +		return;
> > +
> >  	/*
> >  	 * We can free page tables without write-locking mmap_lock because VMAs
> >  	 * were isolated before we downgraded mmap_lock.
> > @@ -2624,6 +2631,7 @@ static void vms_complete_pte_clear(struct vma_munmap_struct *vms,
> >  	mas_set(mas_detach, 1);
> >  	free_pgtables(&tlb, mas_detach, vms->vma, vms->unmap_start, vms->unmap_end, mm_wr_locked);
> >  	tlb_finish_mmu(&tlb);
> > +	vms->cleared_ptes = true;
> >  }
> >
> >  /*
> > @@ -2936,24 +2944,19 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> >  	unsigned long merge_start = addr, merge_end = end;
> >  	bool writable_file_mapping = false;
> >  	pgoff_t vm_pgoff;
> > -	int error;
> > +	int error = -ENOMEM;
> >  	VMA_ITERATOR(vmi, mm, addr);
> > +	unsigned long nr_pages, nr_accounted;
> >
> > -	/* Check against address space limit. */
> > -	if (!may_expand_vm(mm, vm_flags, len >> PAGE_SHIFT)) {
> > -		unsigned long nr_pages;
> > -
> > -		/*
> > -		 * MAP_FIXED may remove pages of mappings that intersects with
> > -		 * requested mapping. Account for the pages it would unmap.
> > -		 */
> > -		nr_pages = count_vma_pages_range(mm, addr, end);
> > -
> > -		if (!may_expand_vm(mm, vm_flags,
> > -					(len >> PAGE_SHIFT) - nr_pages))
> > -			return -ENOMEM;
> > -	}
> > +	nr_pages = count_vma_pages_range(mm, addr, end, &nr_accounted);
> >
> > +	/* Check against address space limit. */
> > +	/*
> > +	 * MAP_FIXED may remove pages of mappings that intersects with requested
> > +	 * mapping. Account for the pages it would unmap.
> > +	 */
> 
> Utter pedantry, but could these comments be combined? Bit ugly to have one
> after another like this.

Since this was mainly a relocation, I didn't want to change it too much
but since you asked, I'll do it.

> 
> > +	if (!may_expand_vm(mm, vm_flags, (len >> PAGE_SHIFT) - nr_pages))
> > +		return -ENOMEM;
> >
> >  	if (unlikely(!can_modify_mm(mm, addr, end)))
> >  		return -EPERM;
> > @@ -2971,14 +2974,12 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> >  		if (vms_gather_munmap_vmas(&vms, &mas_detach))
> >  			return -ENOMEM;
> >
> > -		if (vma_iter_clear_gfp(&vmi, addr, end, GFP_KERNEL))
> > -			return -ENOMEM;
> > -
> > -		vms_complete_munmap_vmas(&vms, &mas_detach);
> >  		next = vms.next;
> >  		prev = vms.prev;
> >  		vma = NULL;
> >  	} else {
> > +		/* Minimal setup of vms */
> > +		vms.nr_pages = 0;
> 
> I'm not a huge fan of having vms be uninitialised other than this field and
> then to rely on no further code change accidentally using an uninitialised
> field. This is kind of asking for bugs.
> 
> Can we not find a way to sensibly initialise it somehow?

Yes, I can switch to the same sort of thing as the maple state and
initialize things as empty.

> 
> >  		next = vma_next(&vmi);
> >  		prev = vma_prev(&vmi);
> >  		if (prev)
> > @@ -2990,8 +2991,10 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> >  	 */
> >  	if (accountable_mapping(file, vm_flags)) {
> >  		charged = len >> PAGE_SHIFT;
> > +		charged -= nr_accounted;
> >  		if (security_vm_enough_memory_mm(mm, charged))
> > -			return -ENOMEM;
> > +			goto abort_munmap;
> > +		vms.nr_accounted = 0;
> 
> This is kind of expanding the 'vms possibly unitialised apart from selected
> fields' pattern, makes me worry.

I'll fix this with an init of the struct that will always be called.

> 
> >  		vm_flags |= VM_ACCOUNT;
> >  	}
> >
> > @@ -3040,10 +3043,8 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> >  	 * not unmapped, but the maps are removed from the list.
> >  	 */
> >  	vma = vm_area_alloc(mm);
> > -	if (!vma) {
> > -		error = -ENOMEM;
> > +	if (!vma)
> >  		goto unacct_error;
> > -	}
> >
> >  	vma_iter_config(&vmi, addr, end);
> >  	vma_set_range(vma, addr, end, pgoff);
> > @@ -3052,6 +3053,9 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> >
> >  	if (file) {
> >  		vma->vm_file = get_file(file);
> > +		/* call_mmap() map PTE, so ensure there are no existing PTEs */
> 
> Typo? Should this be 'call_mmap() maps PTEs, so ensure there are no
> existing PTEs'? I feel like this could be reworded something like:
> 
> 'call_map() may map PTEs, so clear any that may be pending unmap ahead of
> time.'

I had changed this already to 'call_mmap() may map PTE, so ensure there
are no existing PTEs'  That way it's still one line and more descriptive
than what I had.

> 
> > +		if (vms.nr_pages)
> > +			vms_complete_pte_clear(&vms, &mas_detach, true);
> >  		error = call_mmap(file, vma);
> >  		if (error)
> >  			goto unmap_and_free_vma;
> > @@ -3142,6 +3146,9 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> >  expanded:
> >  	perf_event_mmap(vma);
> >
> > +	if (vms.nr_pages)
> > +		vms_complete_munmap_vmas(&vms, &mas_detach);
> > +
> 
> Hang on, if we already did this in the if (file) branch above, might we end
> up calling this twice? I didn't see vms.nr_pages get set to zero or
> decremented anywhere (unless I missed it)?

No, we called the new helper vms_complete_pte_clear(), which will avoid
clearing the ptes by the added flag vms->cleared_ptes in the second
call.

Above, I modified vms_complete_pte_clear() to check vms->cleared_ptes
prior to clearing the ptes, so it will only be cleared if it needs
clearing.

I debated moving this nr_pages check within vms_complete_munmap_vmas(),
but that would add an unnecessary check to the munmap() path.  Avoiding
both checks seemed too much code (yet another static inline, or such).
I also wanted to keep the sanity of nr_pages checking to a single
function - as you highlighted it could be a path to insanity.

Considering I'll switch this ti a VMS_INIT(), I think that I could pass
it through and do the logic within the static inline at the expense of
the munmap() having a few extra instructions (but no cache hits, so not
a really big deal).

> 
> >  	vm_stat_account(mm, vm_flags, len >> PAGE_SHIFT);
> >  	if (vm_flags & VM_LOCKED) {
> >  		if ((vm_flags & VM_SPECIAL) || vma_is_dax(vma) ||
> > @@ -3189,6 +3196,10 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> >  unacct_error:
> >  	if (charged)
> >  		vm_unacct_memory(charged);
> > +
> > +abort_munmap:
> > +	if (vms.nr_pages)
> > +		abort_munmap_vmas(&mas_detach);
> >  	validate_mm(mm);
> >  	return error;
> >  }
> > --
> > 2.43.0
> >
> 
> In general I like the approach and you've made it very clear how you've
> altered this behaviour.
> 
> However I have a few concerns (as well some trivial comments) above. With
> those cleared up we'll be good to go!

