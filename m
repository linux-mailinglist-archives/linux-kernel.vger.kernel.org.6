Return-Path: <linux-kernel+bounces-407839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9309C752A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 16:02:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05E791F22F03
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 15:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5873141C92;
	Wed, 13 Nov 2024 15:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NRWdbx6T";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rvFm5YoG"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9891208A7
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 15:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731510157; cv=fail; b=tSqqu4A1yWe7fSTIzoSUurz5OZXEOT/WCm0QJxG49MIq+nJ6vY+lb7aad1NUoM6iCKmltWQO6HOUCcprbUd8JcSBI93jMaNLQR7aYdq6b3nw5wP6FHG5IZYB6bhJ4GL3XkNHDfwe9yltAz/tofz5F1E+KzWVHcx3uNGRnaNjVxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731510157; c=relaxed/simple;
	bh=hs1Q7oV77S+cT/NdWVOAXvdHEGDydAAm1tC8IqOOXR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GxvYIgiBf6Y0mWIw60UhUxkPrhHbKqeXhvU4BPE8+xwFCsjfWBnpLSrXyv81tUSm33+epLez9hhGSBpA9/qaab9chYbNapaFjRs6QPezyaXY6bmCwTDiZHMqIWjMYTG3FXxkxKOv63CP8WYXr+FDYI78cPju3SZ8ss6pMhbVMAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NRWdbx6T; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rvFm5YoG; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADDXYeo010705;
	Wed, 13 Nov 2024 15:01:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=hs1Q7oV77S+cT/NdWV
	OAXvdHEGDydAAm1tC8IqOOXR0=; b=NRWdbx6TFUuADbcNOabGQ7rw/ejg9Yg94a
	OQOUheq3OeO5ntCARvoq3JhXWwSH/XtRCIRFqNBTQepOK2F8UBEm+DFjN1hkwxxL
	Z3T4jCAB8fZ8av4Zpjzb0ZgvQnhRM7AYLoFS2V7pY7up3i+n27Yu6Upfeg+tZpSO
	C/vH5fTwHSXuMQX3cd4IO+vLtqqB9Hh7Nte4tTC4FC6Wv/bmaPPrk46TGRKFkI+w
	4Fs5M2xHAHX0SdquxHTdvI1pYsy+zUEs8O/aSPt7Co43hGaOHRJDO3WVxAK27pC0
	9VXaUaS73Sh1cFnpUvZGFr7tPgGnw8DnX09bT15m8mWwTcVYGo2g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0k5exbr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Nov 2024 15:01:57 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADDXl1D005677;
	Wed, 13 Nov 2024 15:01:56 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42sx69r40y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Nov 2024 15:01:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=upBpNRxGR4t48uQvDEhdTzWXuLiw4XMpy9ALqFk5J79bhuTLUKei+y8ZYA6fXP//SqKUCuCEGc81+X/ZCdMyVihSOo9O/BlPDJ4HgmxUrGBs/lCJcO5GaaoVcIdsgto3qJYmiG1aSHwd06m8EV7EU9RVL8I1J4sA28VThUjdrRtt5zqmwJRvblbNVw8T3AOukJ8pQbYgDI9/aQ/ex2qCauzCuw3clqhCNXG7dVbPtpsC72SwPuE5x63R9I3aBKyXqdxizg+5tEycbEMLo1iTTI+NcYZvQsLwGI7R71JX8lYNkZGIsZZ7Axtnid9E7UjnV5wPvbut1ib/GS0Gq7j0aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hs1Q7oV77S+cT/NdWVOAXvdHEGDydAAm1tC8IqOOXR0=;
 b=fnO4uPUo0wz6q+va1BOvCu+J0ctaIgvFZ4fn9NEKqNwTl2nrXM0tMYpmJjwRMoFq4X687sHJTzmc49GTOmRutNDIJ0OVKnIZEpmCg7azlLdvAHqwb4zMtRDy/Qaj+l8NcOEMbgLQMyfSXnB4xGd+PryDMfqRV9alchPPWgi343vvwgoxZOuqLTNVfdR1n1SE4ltcUTJwEujEhs6suIyFwASfRxhcWbJ2nR2tXxN4NIZcisrPoX4BCTvwFRTin9vOSb6LFs0oqyAxOAfdxe7sRQzWrB2F6fOAMoYR36ydUnDHhMAioGbOv0RVFFn510SdyCwrFqRhEr1w4OFMMQ2d7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hs1Q7oV77S+cT/NdWVOAXvdHEGDydAAm1tC8IqOOXR0=;
 b=rvFm5YoGTxFb1bA24ml25ZxHrJl5d/AlxAn7GCDO+B7GCeyLUT9ARKGEbJnymMN4W2L7nOHb38P4knmIjkgHLGuB3NeVgPmaFVal31KMSu4bys/ctElPSfAhljP9khb//qYSwoyxP7dxN6KxoUIuI4wEC0anl3RvOeKR1UU2OR0=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by CY5PR10MB6009.namprd10.prod.outlook.com (2603:10b6:930:2a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Wed, 13 Nov
 2024 15:01:51 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8137.027; Wed, 13 Nov 2024
 15:01:51 +0000
Date: Wed, 13 Nov 2024 15:01:48 +0000
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
Subject: Re: [PATCH v2 2/5] mm: move per-vma lock into vm_area_struct
Message-ID: <5d34da83-92eb-4666-816c-73a0e831aa89@lucifer.local>
References: <20241112194635.444146-1-surenb@google.com>
 <20241112194635.444146-3-surenb@google.com>
 <637370b8-3e3e-4457-81d6-5913a3ff1d4e@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <637370b8-3e3e-4457-81d6-5913a3ff1d4e@lucifer.local>
X-ClientProxiedBy: LO4P265CA0154.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c7::11) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|CY5PR10MB6009:EE_
X-MS-Office365-Filtering-Correlation-Id: 88cbf91b-88fb-45ee-0805-08dd03f41ad2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mk5DPDdaQ52flZtgP0skJPiPRjHcVTK5NdRoo0FNK0gRcggHmnvj9Sq/k2WR?=
 =?us-ascii?Q?4/6pDNfBLOUht5oVP88JkHNKHWWmfYUAgqLb12mKWhHE765G/uoDElg+v5x+?=
 =?us-ascii?Q?VLPTeytL1v1tlpv9nD9lNgeINtsp7MW5h1fyhbVhjsPE5fQK0BDREHPvucxg?=
 =?us-ascii?Q?IWQArI2yMNbA6rcHdteaG6JDtkU3YLxxpkZdd0+DhyVO8I+GyPXQYc4c6ZNR?=
 =?us-ascii?Q?VrOwvWwqhyPJ1vheX+Ka1OS5jTIN9SLjgv4eOaVe+epMwzCcZMNt0NOyTt4b?=
 =?us-ascii?Q?gr12Hg5tp60RDF6yyUkbcwa7FwD4m6aon8H/Vi/FP0hFAGJsi2LBMGXQeE26?=
 =?us-ascii?Q?e9jfQnN5+VXgc7KUZh9x6uztiKrxB/Knsy9cu72Uq1ms1g8o8v0wT5Shl/4e?=
 =?us-ascii?Q?MW4cHqA6cMziKZoQepZLfe69+46eiF/dse1VP6pkBLlGKhzWupM2GDYr0GRV?=
 =?us-ascii?Q?3lQ/yxN95ZHP0n5fPs2YnfZEHZa48uuDcdRhmhqJQWQjmvh5QOUj5xUXKvfe?=
 =?us-ascii?Q?U963AKmpGy0w5M8wzWdHSkm4tU8w80mYXCdMVjxqHPSuztcsGh2xwTqdKsZq?=
 =?us-ascii?Q?BSyWMfKN7CCUgXD7afsnGwR2oe2phYktjeiVoXgBPfXQ1c2qhcTywo/gMM9q?=
 =?us-ascii?Q?uFAnC11PQKi0KbUVVrePbbnWXdeLtValOprKsluZFuNcJ0rmlbTle++iGXeg?=
 =?us-ascii?Q?yLOTLDV3PChY2QTTZJD/yTB89iFrZS/EYAIw4m40BlssEcaK1TB+tBehyupj?=
 =?us-ascii?Q?tftpj/yp6OMX2SJiOY5glGlNVFdcwoua67ipd9lbP3tMdV8Faot9XlcMWZ/6?=
 =?us-ascii?Q?pNEAnfvT+GyS3yDJF3tmuP3BQGSX3NuE7J4lX/Y6bLrNJ3zPUSrmE7hTNhNb?=
 =?us-ascii?Q?XG8LM9EPpDuSwVSQQrdrBNf0wozkDBseQjKlJRh1+j7iaBMylHJpLpds1jkD?=
 =?us-ascii?Q?Sm1wj4NdTpcViMIpzyfhDQMzYHVMIkPO60jjBO67fOTXY+tR/SphwFfezG05?=
 =?us-ascii?Q?b76kbASFP1EvIcC4lhBgsNzB9wGv5j+eq+RrDtyw+oLh5XaPcnucxlAaBgNC?=
 =?us-ascii?Q?WVyIMZ14mlVSXTDNAdYoeGecEh+PaxAsj+W+Bu5+gBmxmA/x/85EayeBHzrb?=
 =?us-ascii?Q?pvXiabpWwzYNaGpH+Ju7vBYr2pFDfKchp3tUMrrC6QHZrTnF5RWXNdPZhlvf?=
 =?us-ascii?Q?5/S0O1xYbDg8FXGgR0zEApCADBGdFVZHtqQTVb88OHjPwlQg43N8cVAxf7tG?=
 =?us-ascii?Q?UMUvX7q2en6m3QOlNoLWKlPSx2Z4+lB05mWJ51sqHu6NqRwfMksPJYK4UYrj?=
 =?us-ascii?Q?BcVVcMuDm+IiiiLmVmRnQ3L9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?s5xC2PEcJeyrF+294dT1XUiU3J+LztFeTHf2IvFk2OVS399JtEyoDd5JRIQN?=
 =?us-ascii?Q?MP4KZGtHNZVwrbsKiUdpgrYDrEN54RUYSI0QdqzDY1H6f4+fMil7Ex9TXRrq?=
 =?us-ascii?Q?nDdajcLRe7OFl2Y0Fn8E1Ffuvu/WUTH5O83LAWL2lb3k7r7CZkFQ6BnUj/1x?=
 =?us-ascii?Q?MtVN3dC9mvuTFl9yHOB3uIKDbXJ3NZWstKCbFL0G0grI2px2VSxIPiFN2rST?=
 =?us-ascii?Q?6HqkmKM5i35ESExSc/0SB+fS6N1tUy2TmkX46mplXAmqHsQKj04GXlbRvFvZ?=
 =?us-ascii?Q?GJ2TTf4T6ZxCozBe2tKYjUwmbgJcnNXO7Hlfepo8wfAdGiIGv8+EyxSjKqaI?=
 =?us-ascii?Q?yMSwtjnQ8jhn8l4To0XSK5DCTTcwiRroZcXWX9f7c8JN9US2AOE2Bj1zbsSL?=
 =?us-ascii?Q?1eEmWMMJ8rYy6g4bpjBvdjCTftfFnbfLj+S0O3zumQsw/sh1zYdsygiNyhqm?=
 =?us-ascii?Q?AXvUynX0HziK9C298jWv6J38uFoHN4pqDvq0ppQygpRTo5dyNsLexKUWqw14?=
 =?us-ascii?Q?c2sL1I49KMXTng7Yz0bRqLq1U5suztFwZeYs4H01byf/g/IF04khoDAGiyqJ?=
 =?us-ascii?Q?XwDA+7Le4C0HTd77MRwezTucrOHTkLqPTX9uYExVpWV3PB7oJpCFdnvKmm7A?=
 =?us-ascii?Q?C02aS9vOB8EaKX1XLAWk5M1xy/EURw9HFH52xtCbwLT0q+fUjaAtadnmLxJG?=
 =?us-ascii?Q?i3dpLgmLbthAEsUnyl4JcE2dPOVMhvimqO428DHpfxzp7g0HCdgTvWHKXXdV?=
 =?us-ascii?Q?mJ3fURSlna3MGgAd8jbo7oawooNWQJljxtdorYyNkVBcisfP5tg7TZv11e7Y?=
 =?us-ascii?Q?hCadFg/zJDDgFwViV9BuHnj+VnnV6L8ng3dfjHkc0ir/Me6PlZ5oSgXaVaLJ?=
 =?us-ascii?Q?0roQYMbQD1/uxq3IYfgz1Eh26OvOFpnC/93HRI3x/bsgtI5GfPAPqOa96F0V?=
 =?us-ascii?Q?g7Imi4LN+C4rX3FLOnvxdxYgTbTqcPhTORaEf8n8XlO6WX+JKlQF/E+4cwby?=
 =?us-ascii?Q?Ek/RujmwfhEY5W/ixpFUj2zDoQ0nviukNcZdh9kOLnqXGFMsdkHum0CQkmk6?=
 =?us-ascii?Q?Ghr5Qqs2ihXiLNubUngLrwWSMwAUFYwfUB9zxQaip95SgyXxVbdOZzg+Fi63?=
 =?us-ascii?Q?WDEjatAT+JNrWXP6iMjH68r9I/oNJJA+QMEAxMs2QSUL8S72OBh0cyaB49U8?=
 =?us-ascii?Q?hs2hksXmvN890g1yOWinjhS6/hQHhOGmC1QtK8CgOM34qd/8r6MBtzRwgTt4?=
 =?us-ascii?Q?72qSsuK3LkzGQ9fsAPd2AdkGtY/DiGp/1WmFRX8cbZeB0q6LUMq090is52mQ?=
 =?us-ascii?Q?C9p7RI/0H2vfut2ztv/OvgsJ+GPplpDf2UG3h3ikKPLkYoOuIrHmwvRR2ZX6?=
 =?us-ascii?Q?k6k2357Hn7sLwQxZTs8TUZUEINNh3AAeN9X3aLLWVES+23gOc35t1yDy4RP9?=
 =?us-ascii?Q?ts+PTzi0rQ+3ARLrlL3w9YrrqEF6sLCxxlTsnAizaQ+zXNBcR0If3otX3LZg?=
 =?us-ascii?Q?d+BL/KC3G/vV+kjJA9+RGzPFIXgFIwmBhbK6/JWQyfWovNEdyaFjVzQdiUqA?=
 =?us-ascii?Q?te3GXgntrhTAsIioQ1jwU1a5YOxUXliKt9JIT/xPhTEMDw72xwqU5wu7IGhY?=
 =?us-ascii?Q?pQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	c995ANrzO18GBtxoxBMQzRV4ik6ZjWKy6H/jMcSyCUBjXXNWrfdyyb7FISuZX8QiykCgs4uOvNJxL3Y2NDM5ZvxwJIXrMYdSpywlAuo4yL77gN0QocR6qhsMekPaZoIZbYshqXM860Nhi+Bv6N2vr8Yn7pNEA5nQ4rsLrze1o3B3yC+TnsLeKOgEAcIhwfSR81vdg1l6S/lnSRWZk/R8FbT5xsKHSqURdpy2HbyhK5aiMhi2J808OJ6PswoMbPUEh9mq+Z/Zfc47laNEhqz59G444ikgWYI5RTpctz0v8n5nPPONmhIyzpQW3vpWVn3cQqJFs4Bwgj4z+S8s3Y1ccVrto4bXiySHl+N9F3Sv5jQBz2MfYUJNGej5KlROciqwChZXl613DNW8JggSS3evUyaVuDZ0InHVXhmlaShvVa3XfzdDcQKyN+xG4jvIkJLHwgS3YQqxClTQfDst+MFgAIB0czRvHzCBEragrBvKmbONfPKRzRELA+rDyE3zjVLACw3nI8RN4imEhILwuE/vgoC+UfJ2yT42e4Lv76qUpcZj8sxtGtnBVrZuh+LTlvHhqdhrb4pbHKBd8P4E2YDy0j8OmO9rET1syGutIVJr1JQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88cbf91b-88fb-45ee-0805-08dd03f41ad2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 15:01:51.4307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BKHzI7TErtYM/YKFBN2Ex3Yo2Ofm3sxMo99QzAIGqaHS45zbUsmlb9Eo2nMdLlL0HWt5Mcw3qd5wne+oQ89evBNQXuwjCW4+mBo+2oCgzGo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6009
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-13_08,2024-11-13_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 spamscore=0 adultscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411130126
X-Proofpoint-ORIG-GUID: LLKLL1Arrv9THeXJkPXXITxOj-CYbEcx
X-Proofpoint-GUID: LLKLL1Arrv9THeXJkPXXITxOj-CYbEcx

On Wed, Nov 13, 2024 at 02:28:16PM +0000, Lorenzo Stoakes wrote:
> On Tue, Nov 12, 2024 at 11:46:32AM -0800, Suren Baghdasaryan wrote:
> > Back when per-vma locks were introduces, vm_lock was moved out of
> > vm_area_struct in [1] because of the performance regression caused by
> > false cacheline sharing. Recent investigation [2] revealed that the
> > regressions is limited to a rather old Broadwell microarchitecture and
> > even there it can be mitigated by disabling adjacent cacheline
> > prefetching, see [3].
>
> I don't see a motivating reason as to why we want to do this? We increase
> memory usage here which is not good, but later lock optimisation mitigates
> it, but why wouldn't we just do the lock optimisations and use less memory
> overall?

I worded this badly. To clarify:

I don't see a motivating reason _in the commit message_ as to why we want
to do this.

I am certain there are, in fact Mateusz and Vlastimil have provided them.

So my review is - let's just put these there :)

