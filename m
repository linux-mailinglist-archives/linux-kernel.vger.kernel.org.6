Return-Path: <linux-kernel+bounces-526165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F748A3FB02
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 17:23:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89249421104
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 16:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B7620CCF4;
	Fri, 21 Feb 2025 16:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="k8lwz0aC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uLAu3ez/"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A755F20A5C3;
	Fri, 21 Feb 2025 16:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740154394; cv=fail; b=kooAzpEX0l0FYyQb7Z5eZax/Rilj+WURcf7Na9Su/pKA41r7Ju62Lr5uSrl1qmozayHURGGKWqtHdOj5JayUYr2XJfbhnqQMYHs9hmHtPdZ+RIBq24Urwu6g0EoFnFvB1Bh70Ahg5VbNcbiTizWMo+ZoMcO6arMPtgd52Rp72Lg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740154394; c=relaxed/simple;
	bh=Hz5Esc0HxBkgAxoEbtcvRlFaVwRVSEhMz7lZlJXF8d0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZIHwew6DWkIeUkK9Kvz/bby8ECnQO1844RElqHNAvwyRR1HPSxJj/CReWP7ZqAmXn6LkVMj+TNjHBOWopjxtyEg7NFnYfjWMYl0kXZ0RTKTariTsJUXyxv74xiro98iluju+JSamXcudW2UAd+XkcKBBrLNBT5MZFzl4MsRAtKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=k8lwz0aC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uLAu3ez/; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51L8fbXb018086;
	Fri, 21 Feb 2025 16:12:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=dN2B5kbnK2i5AlX7Uu
	64A7nexo4CH2qnf8WomNzIHJI=; b=k8lwz0aCIj95KYkWiQqrLfsquJqaMMdyAy
	v8fi7Dhz7IZlZ3J3Cnvq2zqZLhoSv5CMBsrR6aHcblcnAkk15GBVHRDjSgy//KcF
	9kuEEmokRsTu3qZjh0gc8KWi31SP5rYLjz0f1E+T0LacrTPBMVCRJ5SbuB9wgMQb
	3g2AcWcAnZ+QJXrwdfaBIJFV/X/6c4J5ODcW+zLH+kcSb8Ae1JcgbeJSGHqIYSYx
	26CkEBhLCwy/rwHAPy7d2rk1nk1QsgsbAfWumzfaUZ2VvATGQwvW7yvteCF/vXbL
	WJACK7kFRh/o5jPLNi0AnXNS0ikRddGG606qgxpCvhsPZp5a1M3Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44w00mxjmt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Feb 2025 16:12:23 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51LFivhf009785;
	Fri, 21 Feb 2025 16:12:22 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2045.outbound.protection.outlook.com [104.47.74.45])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44w09fu9gy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Feb 2025 16:12:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qm9MXJz+EJdv1wWSlMp7Y5FrEdPL8vTOr8iCQemTCd7Ux9CjHrVre/Pl/mcE1HXgmWWT8u4UK6Pv0kzc76hrGcwQIUHQcUN09iNTzPALtAzRi7BZj7wmcJPDgfh3zIoNn4EsJTII/4Lsc5rZ7pR/rNXxBVxBpBEtQ4LRfscwyCJHwzdLbcZas9LF/CDZqarGdpEDmQ9qwHSy5TiAkdnf+He9Lt7JYr6aSsVqTQlxK/7wGcCEAcdRiwZ/ccAlNzKffij/c9kT30UZqcxVTeWrN3j+avfiO4UY1SM0FY0qp9yJpceIKKgCpbG2LbJ+5ixXpHgazE3fDndo0WXlauKLzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dN2B5kbnK2i5AlX7Uu64A7nexo4CH2qnf8WomNzIHJI=;
 b=eguIm+K0Y13k3Df6aTTPNr+uGkeRX+YhUqcz83UjcRccqX+u+RluPn8IteZnuuoRIaOipPy3580C+IWSs/3vBpFZWOwykyAB9sWrthtowQk5mU609KRj3+qFVG2okZ/cFtVzBD8eg+Ip+JCJLOVO/5zl9tZ6j8pkdeTDipKjH2k5ylxzgNPxAJCOWhwqD3+ygyC+ht3/ejRYdvg5wfgvhqvnsbyZjixk+O2YRagb05Zb8ZMj/gwr6RZLPnyFQm9Ez/CBYPnrPmK2DFOfCt9hN0Frtu1pUzVptk+YXMfheY4cadbtASgXLBhpUr1ojfFA2hO+lrWe7Lmhg7TZjGKqCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dN2B5kbnK2i5AlX7Uu64A7nexo4CH2qnf8WomNzIHJI=;
 b=uLAu3ez/MUfebRUmltCCdRe56W6OWxk/1XL7ci307li8PxWc2/kCTL7xaBOsuQPq1fJBIf2E5vEK7hPmVMmNPa7MtqD1hOZ5tnyWbk873sLPPc0nshYoDE1ds57tWVCRvOCvq3Mb9LBLfS6eujISfyaOxx2O1xLSnciXSol9uXY=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by MN2PR10MB4144.namprd10.prod.outlook.com (2603:10b6:208:1d6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Fri, 21 Feb
 2025 16:12:17 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%4]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 16:12:17 +0000
Date: Fri, 21 Feb 2025 11:11:51 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, peterz@infradead.org, willy@infradead.org,
        lorenzo.stoakes@oracle.com, david.laight.linux@gmail.com,
        mhocko@suse.com, vbabka@suse.cz, hannes@cmpxchg.org, mjguzik@gmail.com,
        oliver.sang@intel.com, mgorman@techsingularity.net, david@redhat.com,
        peterx@redhat.com, oleg@redhat.com, dave@stgolabs.net,
        paulmck@kernel.org, brauner@kernel.org, dhowells@redhat.com,
        hdanton@sina.com, hughd@google.com, lokeshgidra@google.com,
        minchan@google.com, jannh@google.com, shakeel.butt@linux.dev,
        souravpanda@google.com, pasha.tatashin@soleen.com,
        klarasmodin@gmail.com, richard.weiyang@gmail.com, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v10 04/18] mm: introduce vma_iter_store_attached() to use
 with attached vmas
Message-ID: <3t6mrzpv2ylqgkwrjvu6wjazrjxqupoz3wxsmbmawmlyodrwhs@vlxleb5wjsfv>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org, peterz@infradead.org, 
	willy@infradead.org, lorenzo.stoakes@oracle.com, david.laight.linux@gmail.com, 
	mhocko@suse.com, vbabka@suse.cz, hannes@cmpxchg.org, mjguzik@gmail.com, 
	oliver.sang@intel.com, mgorman@techsingularity.net, david@redhat.com, peterx@redhat.com, 
	oleg@redhat.com, dave@stgolabs.net, paulmck@kernel.org, brauner@kernel.org, 
	dhowells@redhat.com, hdanton@sina.com, hughd@google.com, lokeshgidra@google.com, 
	minchan@google.com, jannh@google.com, shakeel.butt@linux.dev, souravpanda@google.com, 
	pasha.tatashin@soleen.com, klarasmodin@gmail.com, richard.weiyang@gmail.com, corbet@lwn.net, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kernel-team@android.com
References: <20250213224655.1680278-1-surenb@google.com>
 <20250213224655.1680278-5-surenb@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213224655.1680278-5-surenb@google.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT3PR01CA0113.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::16) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|MN2PR10MB4144:EE_
X-MS-Office365-Filtering-Correlation-Id: 33906e86-0503-4d6c-433a-08dd52928306
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gJ977KlB9fAIP+jVbssiAMIfmBQToI7tNca6Tzd0mDZGHx0/uLXsKsfy9srR?=
 =?us-ascii?Q?FL1GcINmcFwsJq+sjLnOHcjw27gGGdYKqBllWMq1LvskPZN4YEMXvDgI/ljc?=
 =?us-ascii?Q?YSq3bzJygHWa4RIOTrtXTTyboi7gibM21lLMvdz/985o0msDiFhPKuBsoDwE?=
 =?us-ascii?Q?reqENvTm5cT0A+pLkL6V8O6USV/wl+yTsoas14A2n3ZgpINT+XkotNzkktid?=
 =?us-ascii?Q?V66JiVvTHb/bN6AH2hoBz4e0JEJI1K7lkz49KjtIqTFN75FlwHXaE9qB95o2?=
 =?us-ascii?Q?ubA4KNv+kvsj578aMFHEVRLuK54TKvYe6e7AmW9v3P+ryTJccomKxflDWf7Y?=
 =?us-ascii?Q?GZqeQuWmUS47jf5XamLeTIxFF1QOl6YRhf4yxynNk5tJU1pCdNsLkBBOfTV4?=
 =?us-ascii?Q?GrQ3UPDWAXVJnYH1huI3zTuYWeQ6+Kz6t68qJS63UPMiV001lABxVrq63cB0?=
 =?us-ascii?Q?pet0ZROb/Jzk6UI6Rz7SsDdK9hSdFmVIL0y2TKM8YYKBTZfG0ZcuACmqbW+e?=
 =?us-ascii?Q?5yritF4F0I/o6TcbCQCpNgfknmfOw5giIh78wU8mLuTtbi3mP6dHcynSP0iU?=
 =?us-ascii?Q?FPtax2spORcYskUj7g58qpFJ7LHFDubWQ0W6jxkQXg2r6W5oOMGC7tzrdDos?=
 =?us-ascii?Q?jwh4c3LULtbS79ooNZayUFMgFzKkkY4P2/fWnYCy9Q+MgUmn8iCN/l4vsfaL?=
 =?us-ascii?Q?gmp0EQ0jFszaoktkq+pWnM+7w1NG/wAH3gPjyRTGBrAu90YM5d5X/kzqZEph?=
 =?us-ascii?Q?VzzdWy3OHUROA+a1zmMu+8KVi+YAVfTnFTyWpTZiCpD7Ez2/Pu3ULxUh6vuq?=
 =?us-ascii?Q?nq5ssCmj0qSExuAYav5MzJJaop96aMs81TVfuNEIPGP0x11PTXAvkYcD4COX?=
 =?us-ascii?Q?JNMTHdftI0oeNSDipywJ7pZ1f48F24ahAPSu8iXH14AQfZ+eYK8QjnfghPVB?=
 =?us-ascii?Q?aA1wyXF21eoUBFNv9hVfJHaj+AZPeb7H7DOyM7M1XxWn05IkBV2/bmDr9F99?=
 =?us-ascii?Q?TK/H3r1ia1Iocqf1+fD5cXLSKVDzQrb15SGNv7QVHtJ/0jWIxYxKU3T7Wzau?=
 =?us-ascii?Q?10CZL+d6gbGasKOU2CO4j1D6vSsrvbP5fpYKbyLfXnJ1hZMFmtXDKsJrI7p2?=
 =?us-ascii?Q?leZwrLQOLlPj+loFRGu1nmFLsleBxi3WkkcR1AKp1NDooiBKcSf1m+osIp0N?=
 =?us-ascii?Q?TxoVPhqLPyfRB3cjvUvQAKDNg6WFnPkLqzUdWPxZvIfNqeJk0RQfLyJFAczw?=
 =?us-ascii?Q?zplrsGgWwCDYk+XChrBeWCJA+1oQMduuMnWDujB1A4J3AgsJOv5d+DLR+yZj?=
 =?us-ascii?Q?/F0ENWD9U6eo4Q3A1fk6JpbHHOYiBcJuM0IbiIHv21yudqZsv59/jE6rcakv?=
 =?us-ascii?Q?E0Wq67nZrUGcfDuNO1mIT/CMii2e?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lC+qCmW/lYd3b3TrLzPKAMI2NNfastGaKW/1HdHu0gxKrezSPnCfNVYV1oL5?=
 =?us-ascii?Q?APycDnPDqffsAJlGw/k3tomxA9+n17Z4h4c2rr21LGTXfCkeU7NYFF1ujYIV?=
 =?us-ascii?Q?FsOgAW0pU2RG1l4tK+4CgNejlV21cotv+3XKWwJyuQod77Uwtd/mNfwQCvPs?=
 =?us-ascii?Q?XKpAHEVpn6HGuE6jhIwikR9eK1y4WYIXU8KJ4WpokWQ00CiRR03CQdAyzQ5d?=
 =?us-ascii?Q?5ti1Au8mW4pwJM9yllpQMHi/L/CUbZMR9bCx+nmuLbBf6pPuRKQda0ObU7vj?=
 =?us-ascii?Q?p7BjuqSS6FCry/PKQoUXFQBNefTYJo5yXlF+6v1mbkBAZG0IkTbJ5XlaFBM+?=
 =?us-ascii?Q?qWIyI0F9Tqwv8FSmeXT/g5NpBZI9nGzmA9I/I1SN5zbwEjGlg6b0ZYTAqGlO?=
 =?us-ascii?Q?q28qyps245ZmmztynmV9Yrlh1Z5mpXVlNzoNiwjqfjz+FMWuNgTXS4idKRPq?=
 =?us-ascii?Q?BW9j+6/s4D7oTtmqU5ztAvJ0MFJbJWNY7kzihQBNFikMhJC5MutZnFnXIh/S?=
 =?us-ascii?Q?RhtlxgIWLLI07Hif3mFoLLs8IUak6jsCHo4Oc8SnVc112HVGadAoZLgB61Sr?=
 =?us-ascii?Q?WY42tu5t/CUXXf7JxPVil4RikD7EGeEfXG2To8Lq7bolpWuuKjxAeeBbnRtM?=
 =?us-ascii?Q?DlSjbMyJHwTtUugk2j4JN8ME1v6Yg4MBKj9BjckxbXSrdJgn5ftwi8fPMGaG?=
 =?us-ascii?Q?zHQbkPEDAfQ/Mrr8YuDg95HfaakqmE6ckjODgZK7DswZusWDpszwmksz2TGA?=
 =?us-ascii?Q?hHA4eZ7PTM+l4k95Ef4RSLqydP9Vn26p9N/QaTWzUVNwjDZH3wHgUuIZccrk?=
 =?us-ascii?Q?r9ZOhg7Xa3weyQLQvDGgVffKEyOyDnZ7MMUoDzR//Dqtz0D/9rO5W7ga7T4h?=
 =?us-ascii?Q?6R9VC6SML2sQunwzkLTrBkJ+aqxuiZmRx9LO8W7lf2FKqujZGk1GIS1afEvW?=
 =?us-ascii?Q?WHNW5z3Ds24kQQ3M7Z1kC8bcqGbl0p4WRfz8dVwP/UZVcAlFtOmRMHNenGx/?=
 =?us-ascii?Q?Oq7ta9KcBryxNVdDIdSQxqrY4A8cGZEG88Smc1xFAv3p3zjU1RXbCN+9uv18?=
 =?us-ascii?Q?v19NYg1VsFjBsw60II0pdTI3s2YdeV6GbGIIs4Lz65H5VzDg/h8gs8QJzRNr?=
 =?us-ascii?Q?0kKNh3DVnz79M6PiGXlZg2/gqx8pYOcd9PHICi9sJx7z4FIrHj7AM0N7XnhL?=
 =?us-ascii?Q?0iCC6F/wdpUI5oH3qdvBcsTkEmiSEs7xn8TSWRGHo8qDpFA4jf/pbVApMH0s?=
 =?us-ascii?Q?F4p6Lwj3T5wbHDtJXXtlYG3jTfWLNkie+dFZ0/qm/pAbFcZaXRHeT1CEFgrH?=
 =?us-ascii?Q?Yo5ixmWKtdqfoWXHA3DTwxqkss8w2RMJD7HazYlvYj3tTBF9gIDaPRLTwA1h?=
 =?us-ascii?Q?6S8Pa9rtIzwISkk+kl5MLF7DM79sbf9TLfjZ0l8fPT/N+0FXMaRdw0nLQan/?=
 =?us-ascii?Q?3+7DZvp1KtzCGuNxKhwrbX8MYOLDBr8GBqEhPonM1KD3VRj5qzvZ/bJgj1/K?=
 =?us-ascii?Q?PUURGWmSoc2gbIrOYd1knXhJHBFTh/4Bhb8Jq6DfOE6vA5Lf9rFF27vZJlOe?=
 =?us-ascii?Q?+xnRgZ9Xxw5D2SzrH65pj71NDxyQgi58FyVwKDld?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IXHgPWrgHQDeULGOEEHD3zy022O9yXcM76CR+KrGyN780aTa3s88Vjpx0vHh4x1iBIyKrkGoOa0TP1L8bYvr3tSHAxDky3c1yG6SJZTjCp9lLyV1+HjreCNGfIt47UrFe8hHJO5aztdI0TwWY6aMNI1/+fyvHtoPK1xt5JaSUnLZ+lYZN+T9oH6Z2s+/iTTzdscZpHNqbld+wPbYepDvVbMM3Z5duHoV9AZyaxWO1YndPlAkl4vPymBgH3L1CkV4P0Sn8ba8H99AL+1HKRT7O0w4oEkACDt5/YfGaENl/9nm0bKvYgTvAZmQdccFZjQzLhwc4lJP6bXX709ZvjUxTVAP+Uyb22pwIE4OihknTWBB1BlanLlkeXorurQAhZJ9Xdgoz9WQjyvb5LqKqt9JlXu3JRJbE+MQFuSAE/63Qv9+jo8pBYBDPkxiRMf3okNdVvOcT3/Gwk3lroW7HDC8fJUb6ucUakup0Ie2sC7OvdmW7bv5T09uP6XeApFwQucmZHIVZlqHvc0Z+zzCKAyU4fEZlvvkDHr6uF7ajJEJDaqzKPag8Nc3uuQORc5BHOOmmlZl6WABSOyabmv1xxYcjlZRjaV9nKYhgGdFHpAlODk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33906e86-0503-4d6c-433a-08dd52928306
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 16:12:17.5627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qfdY12P7Ph2TBomZv97sMHjYRNomLWoCYDesJoqBnl7Mdvu3q2OPd2uvFnvrf2gkvfY/Cgf0l3PhJfQ9rDKIjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4144
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-21_05,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502210115
X-Proofpoint-ORIG-GUID: ABDXCoBMlVmXZDIOdzh_wRFvBaB4x4Ff
X-Proofpoint-GUID: ABDXCoBMlVmXZDIOdzh_wRFvBaB4x4Ff

* Suren Baghdasaryan <surenb@google.com> [250213 17:47]:
> vma_iter_store() functions can be used both when adding a new vma and
> when updating an existing one. However for existing ones we do not need
> to mark them attached as they are already marked that way. With
> vma->detached being a separate flag, double-marking a vmas as attached
> or detached is not an issue because the flag will simply be overwritten
> with the same value. However once we fold this flag into the refcount
> later in this series, re-attaching or re-detaching a vma becomes an
> issue since these operations will be incrementing/decrementing a
> refcount.
> Introduce vma_iter_store_new() and vma_iter_store_overwrite() to replace
> vma_iter_store() and avoid re-attaching a vma during vma update. Add
> assertions in vma_mark_attached()/vma_mark_detached() to catch invalid
> usage. Update vma tests to check for vma detached state correctness.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Reviewed-by: Liam R. Howlett <Liam.Howlett@Oracle.com>

> ---
> Changes since v9 [1]:
> - Change VM_BUG_ON_VMA() to WARN_ON_ONCE() in vma_assert_{attached|detached},
> per Lorenzo Stoakes
> - Rename vma_iter_store() into vma_iter_store_new(), per Lorenzo Stoakes
> - Expand changelog, per Lorenzo Stoakes
> - Update vma tests to check for vma detached state correctness,
> per Lorenzo Stoakes
> 
> [1] https://lore.kernel.org/all/20250111042604.3230628-5-surenb@google.com/
> 
>  include/linux/mm.h               | 14 +++++++++++
>  mm/nommu.c                       |  4 +--
>  mm/vma.c                         | 12 ++++-----
>  mm/vma.h                         | 11 +++++++--
>  tools/testing/vma/vma.c          | 42 +++++++++++++++++++++++++-------
>  tools/testing/vma/vma_internal.h | 10 ++++++++
>  6 files changed, 74 insertions(+), 19 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index cd5ee61e98f2..1b8e72888124 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -821,8 +821,19 @@ static inline void vma_assert_locked(struct vm_area_struct *vma)
>  		vma_assert_write_locked(vma);
>  }
>  
> +static inline void vma_assert_attached(struct vm_area_struct *vma)
> +{
> +	WARN_ON_ONCE(vma->detached);
> +}
> +
> +static inline void vma_assert_detached(struct vm_area_struct *vma)
> +{
> +	WARN_ON_ONCE(!vma->detached);
> +}
> +
>  static inline void vma_mark_attached(struct vm_area_struct *vma)
>  {
> +	vma_assert_detached(vma);
>  	vma->detached = false;
>  }
>  
> @@ -830,6 +841,7 @@ static inline void vma_mark_detached(struct vm_area_struct *vma)
>  {
>  	/* When detaching vma should be write-locked */
>  	vma_assert_write_locked(vma);
> +	vma_assert_attached(vma);
>  	vma->detached = true;
>  }
>  
> @@ -866,6 +878,8 @@ static inline void vma_end_read(struct vm_area_struct *vma) {}
>  static inline void vma_start_write(struct vm_area_struct *vma) {}
>  static inline void vma_assert_write_locked(struct vm_area_struct *vma)
>  		{ mmap_assert_write_locked(vma->vm_mm); }
> +static inline void vma_assert_attached(struct vm_area_struct *vma) {}
> +static inline void vma_assert_detached(struct vm_area_struct *vma) {}
>  static inline void vma_mark_attached(struct vm_area_struct *vma) {}
>  static inline void vma_mark_detached(struct vm_area_struct *vma) {}
>  
> diff --git a/mm/nommu.c b/mm/nommu.c
> index baa79abdaf03..8b31d8396297 100644
> --- a/mm/nommu.c
> +++ b/mm/nommu.c
> @@ -1191,7 +1191,7 @@ unsigned long do_mmap(struct file *file,
>  	setup_vma_to_mm(vma, current->mm);
>  	current->mm->map_count++;
>  	/* add the VMA to the tree */
> -	vma_iter_store(&vmi, vma);
> +	vma_iter_store_new(&vmi, vma);
>  
>  	/* we flush the region from the icache only when the first executable
>  	 * mapping of it is made  */
> @@ -1356,7 +1356,7 @@ static int split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  
>  	setup_vma_to_mm(vma, mm);
>  	setup_vma_to_mm(new, mm);
> -	vma_iter_store(vmi, new);
> +	vma_iter_store_new(vmi, new);
>  	mm->map_count++;
>  	return 0;
>  
> diff --git a/mm/vma.c b/mm/vma.c
> index 498507d8a262..f72b73f57451 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -320,7 +320,7 @@ static void vma_complete(struct vma_prepare *vp, struct vma_iterator *vmi,
>  		 * us to insert it before dropping the locks
>  		 * (it may either follow vma or precede it).
>  		 */
> -		vma_iter_store(vmi, vp->insert);
> +		vma_iter_store_new(vmi, vp->insert);
>  		mm->map_count++;
>  	}
>  
> @@ -700,7 +700,7 @@ static int commit_merge(struct vma_merge_struct *vmg)
>  			      vmg->__adjust_middle_start ? vmg->middle : NULL);
>  	vma_set_range(vma, vmg->start, vmg->end, vmg->pgoff);
>  	vmg_adjust_set_range(vmg);
> -	vma_iter_store(vmg->vmi, vmg->target);
> +	vma_iter_store_overwrite(vmg->vmi, vmg->target);
>  
>  	vma_complete(&vp, vmg->vmi, vma->vm_mm);
>  
> @@ -1707,7 +1707,7 @@ int vma_link(struct mm_struct *mm, struct vm_area_struct *vma)
>  		return -ENOMEM;
>  
>  	vma_start_write(vma);
> -	vma_iter_store(&vmi, vma);
> +	vma_iter_store_new(&vmi, vma);
>  	vma_link_file(vma);
>  	mm->map_count++;
>  	validate_mm(mm);
> @@ -2386,7 +2386,7 @@ static int __mmap_new_vma(struct mmap_state *map, struct vm_area_struct **vmap)
>  
>  	/* Lock the VMA since it is modified after insertion into VMA tree */
>  	vma_start_write(vma);
> -	vma_iter_store(vmi, vma);
> +	vma_iter_store_new(vmi, vma);
>  	map->mm->map_count++;
>  	vma_link_file(vma);
>  
> @@ -2862,7 +2862,7 @@ int expand_upwards(struct vm_area_struct *vma, unsigned long address)
>  				anon_vma_interval_tree_pre_update_vma(vma);
>  				vma->vm_end = address;
>  				/* Overwrite old entry in mtree. */
> -				vma_iter_store(&vmi, vma);
> +				vma_iter_store_overwrite(&vmi, vma);
>  				anon_vma_interval_tree_post_update_vma(vma);
>  
>  				perf_event_mmap(vma);
> @@ -2942,7 +2942,7 @@ int expand_downwards(struct vm_area_struct *vma, unsigned long address)
>  				vma->vm_start = address;
>  				vma->vm_pgoff -= grow;
>  				/* Overwrite old entry in mtree. */
> -				vma_iter_store(&vmi, vma);
> +				vma_iter_store_overwrite(&vmi, vma);
>  				anon_vma_interval_tree_post_update_vma(vma);
>  
>  				perf_event_mmap(vma);
> diff --git a/mm/vma.h b/mm/vma.h
> index bffb56afce5f..55be77ff042f 100644
> --- a/mm/vma.h
> +++ b/mm/vma.h
> @@ -413,9 +413,10 @@ static inline struct vm_area_struct *vma_iter_load(struct vma_iterator *vmi)
>  }
>  
>  /* Store a VMA with preallocated memory */
> -static inline void vma_iter_store(struct vma_iterator *vmi,
> -				  struct vm_area_struct *vma)
> +static inline void vma_iter_store_overwrite(struct vma_iterator *vmi,
> +					    struct vm_area_struct *vma)
>  {
> +	vma_assert_attached(vma);
>  
>  #if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
>  	if (MAS_WARN_ON(&vmi->mas, vmi->mas.status != ma_start &&
> @@ -438,7 +439,13 @@ static inline void vma_iter_store(struct vma_iterator *vmi,
>  
>  	__mas_set_range(&vmi->mas, vma->vm_start, vma->vm_end - 1);
>  	mas_store_prealloc(&vmi->mas, vma);
> +}
> +
> +static inline void vma_iter_store_new(struct vma_iterator *vmi,
> +				      struct vm_area_struct *vma)
> +{
>  	vma_mark_attached(vma);
> +	vma_iter_store_overwrite(vmi, vma);
>  }
>  
>  static inline unsigned long vma_iter_addr(struct vma_iterator *vmi)
> diff --git a/tools/testing/vma/vma.c b/tools/testing/vma/vma.c
> index c7ffa71841ca..11f761769b5b 100644
> --- a/tools/testing/vma/vma.c
> +++ b/tools/testing/vma/vma.c
> @@ -74,10 +74,22 @@ static struct vm_area_struct *alloc_vma(struct mm_struct *mm,
>  	ret->vm_end = end;
>  	ret->vm_pgoff = pgoff;
>  	ret->__vm_flags = flags;
> +	vma_assert_detached(ret);
>  
>  	return ret;
>  }
>  
> +/* Helper function to allocate a VMA and link it to the tree. */
> +static int attach_vma(struct mm_struct *mm, struct vm_area_struct *vma)
> +{
> +	int res;
> +
> +	res = vma_link(mm, vma);
> +	if (!res)
> +		vma_assert_attached(vma);
> +	return res;
> +}
> +
>  /* Helper function to allocate a VMA and link it to the tree. */
>  static struct vm_area_struct *alloc_and_link_vma(struct mm_struct *mm,
>  						 unsigned long start,
> @@ -90,7 +102,7 @@ static struct vm_area_struct *alloc_and_link_vma(struct mm_struct *mm,
>  	if (vma == NULL)
>  		return NULL;
>  
> -	if (vma_link(mm, vma)) {
> +	if (attach_vma(mm, vma)) {
>  		vm_area_free(vma);
>  		return NULL;
>  	}
> @@ -108,6 +120,7 @@ static struct vm_area_struct *alloc_and_link_vma(struct mm_struct *mm,
>  /* Helper function which provides a wrapper around a merge new VMA operation. */
>  static struct vm_area_struct *merge_new(struct vma_merge_struct *vmg)
>  {
> +	struct vm_area_struct *vma;
>  	/*
>  	 * For convenience, get prev and next VMAs. Which the new VMA operation
>  	 * requires.
> @@ -116,7 +129,11 @@ static struct vm_area_struct *merge_new(struct vma_merge_struct *vmg)
>  	vmg->prev = vma_prev(vmg->vmi);
>  	vma_iter_next_range(vmg->vmi);
>  
> -	return vma_merge_new_range(vmg);
> +	vma = vma_merge_new_range(vmg);
> +	if (vma)
> +		vma_assert_attached(vma);
> +
> +	return vma;
>  }
>  
>  /*
> @@ -125,7 +142,12 @@ static struct vm_area_struct *merge_new(struct vma_merge_struct *vmg)
>   */
>  static struct vm_area_struct *merge_existing(struct vma_merge_struct *vmg)
>  {
> -	return vma_merge_existing_range(vmg);
> +	struct vm_area_struct *vma;
> +
> +	vma = vma_merge_existing_range(vmg);
> +	if (vma)
> +		vma_assert_attached(vma);
> +	return vma;
>  }
>  
>  /*
> @@ -260,8 +282,8 @@ static bool test_simple_merge(void)
>  		.pgoff = 1,
>  	};
>  
> -	ASSERT_FALSE(vma_link(&mm, vma_left));
> -	ASSERT_FALSE(vma_link(&mm, vma_right));
> +	ASSERT_FALSE(attach_vma(&mm, vma_left));
> +	ASSERT_FALSE(attach_vma(&mm, vma_right));
>  
>  	vma = merge_new(&vmg);
>  	ASSERT_NE(vma, NULL);
> @@ -285,7 +307,7 @@ static bool test_simple_modify(void)
>  	struct vm_area_struct *init_vma = alloc_vma(&mm, 0, 0x3000, 0, flags);
>  	VMA_ITERATOR(vmi, &mm, 0x1000);
>  
> -	ASSERT_FALSE(vma_link(&mm, init_vma));
> +	ASSERT_FALSE(attach_vma(&mm, init_vma));
>  
>  	/*
>  	 * The flags will not be changed, the vma_modify_flags() function
> @@ -351,7 +373,7 @@ static bool test_simple_expand(void)
>  		.pgoff = 0,
>  	};
>  
> -	ASSERT_FALSE(vma_link(&mm, vma));
> +	ASSERT_FALSE(attach_vma(&mm, vma));
>  
>  	ASSERT_FALSE(expand_existing(&vmg));
>  
> @@ -372,7 +394,7 @@ static bool test_simple_shrink(void)
>  	struct vm_area_struct *vma = alloc_vma(&mm, 0, 0x3000, 0, flags);
>  	VMA_ITERATOR(vmi, &mm, 0);
>  
> -	ASSERT_FALSE(vma_link(&mm, vma));
> +	ASSERT_FALSE(attach_vma(&mm, vma));
>  
>  	ASSERT_FALSE(vma_shrink(&vmi, vma, 0, 0x1000, 0));
>  
> @@ -1522,11 +1544,11 @@ static bool test_copy_vma(void)
>  
>  	vma = alloc_and_link_vma(&mm, 0x3000, 0x5000, 3, flags);
>  	vma_new = copy_vma(&vma, 0, 0x2000, 0, &need_locks);
> -
>  	ASSERT_NE(vma_new, vma);
>  	ASSERT_EQ(vma_new->vm_start, 0);
>  	ASSERT_EQ(vma_new->vm_end, 0x2000);
>  	ASSERT_EQ(vma_new->vm_pgoff, 0);
> +	vma_assert_attached(vma_new);
>  
>  	cleanup_mm(&mm, &vmi);
>  
> @@ -1535,6 +1557,7 @@ static bool test_copy_vma(void)
>  	vma = alloc_and_link_vma(&mm, 0, 0x2000, 0, flags);
>  	vma_next = alloc_and_link_vma(&mm, 0x6000, 0x8000, 6, flags);
>  	vma_new = copy_vma(&vma, 0x4000, 0x2000, 4, &need_locks);
> +	vma_assert_attached(vma_new);
>  
>  	ASSERT_EQ(vma_new, vma_next);
>  
> @@ -1576,6 +1599,7 @@ static bool test_expand_only_mode(void)
>  	ASSERT_EQ(vma->vm_pgoff, 3);
>  	ASSERT_TRUE(vma_write_started(vma));
>  	ASSERT_EQ(vma_iter_addr(&vmi), 0x3000);
> +	vma_assert_attached(vma);
>  
>  	cleanup_mm(&mm, &vmi);
>  	return true;
> diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
> index f93f7f74f97b..34277842156c 100644
> --- a/tools/testing/vma/vma_internal.h
> +++ b/tools/testing/vma/vma_internal.h
> @@ -470,6 +470,16 @@ static inline void vma_lock_init(struct vm_area_struct *vma)
>  	vma->vm_lock_seq = UINT_MAX;
>  }
>  
> +static inline void vma_assert_attached(struct vm_area_struct *vma)
> +{
> +	WARN_ON_ONCE(vma->detached);
> +}
> +
> +static inline void vma_assert_detached(struct vm_area_struct *vma)
> +{
> +	WARN_ON_ONCE(!vma->detached);
> +}
> +
>  static inline void vma_assert_write_locked(struct vm_area_struct *);
>  static inline void vma_mark_attached(struct vm_area_struct *vma)
>  {
> -- 
> 2.48.1.601.g30ceb7b040-goog
> 

