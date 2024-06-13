Return-Path: <linux-kernel+bounces-213487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F369075F4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 17:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5649F288B3F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 15:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5371B149012;
	Thu, 13 Jun 2024 15:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="a8LvvSc7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ug4sXcIf"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1D1145FE2
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 15:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718290984; cv=fail; b=KyqOYMDgX0qwNuEAVchbRikZ4+pL1b6AmG0wYOgIQHwyJAzl2Q+/+JhPXDryN8vCUbXJ8rAufPJcyJuqSB98JqBaIVoSx9UrASLbvGbB6h7CDFJZVKVNc/HmJrhRuabnCra0hAd+yvodiszvgBfNHIyde5HOTmFGWxrZnOrkaCM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718290984; c=relaxed/simple;
	bh=lKgyOcA3HlMJEtGk7g1ktfJnpC3c5LvJ4DJIqadtMyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qGyo81NAf5XnhFh2gmsxuAPYq6Qr/ytQY3qaplYieiCrzJqN327GcZ2yiB37XJjZwkA5peGwKnAgOJ8XA90gf39LVaEG/dx5C6YwBKSQFP96oVO81EQyQlOPLEK7aACpgGp6umc3nKFcDU5acSymYU3E46YbpuUzekER71L3H3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=a8LvvSc7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ug4sXcIf; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45DEtjsi029543;
	Thu, 13 Jun 2024 15:02:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=m4k5mIulXKuhWLG
	qonsu66DD9hQNyIh9ciFPIufqIsE=; b=a8LvvSc7bXIA5dtoK1mK/oORX1YmXnJ
	NS52KdCnEbWNzPhe+buk8ON6Y+hAotUWOFCfHuqxZLKmwypxNgbLI103vr4spnrO
	Q27YoB9B6muo/326t1fShEgbkTD07+mvu9ut8vC8uN2s9OfKVtElZjyC8/4y5I8q
	N6BNSXxz7ym02RXtP145P7nhBYVnfcx+/1A9VWhvtMWKABkeLe4OAFqH8FRyxp4R
	LoaxudkTh3K4JJP3UD6Yehn8i+JwJWjbXv6Bn7iFxScBmtNdSqS8c6Un8dAr5MSz
	/4b5R0GYpcHdqzvgegd9WChUQjZ0Qk4BZgGPN3q8lp4P+4l13jsBmBQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ymh1mhssh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Jun 2024 15:02:51 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45DE8K0W027353;
	Thu, 13 Jun 2024 15:02:50 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2047.outbound.protection.outlook.com [104.47.70.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3yncdwcac4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Jun 2024 15:02:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NJDq8EjXCBnSXdbSMf1JcT4wa4VTAm0D8uf5d8tXnvCj5wjf8fFMEC1r0DbjZbS/585pTfVwSTWy9CFcsE47OTQDPQ4xX1W9BkbbCImZr2ejVkkbHEHNtSeBqIoDD2LB35uZ6zKNm1gtrNnRPCrgrX3tYBEdvGU64RLU4L+6zcWFYvHrPjV1UgIcpXKUejd/T+WhNjd+JFJ5FBTS/8NVe15/Ae4H6mASmidz1vWganKc7sSHSbY6xBWj2r66+Vh8dER9VNUnU+UNY1l826jXxyohN5TLOMkNApCWmjBW0WWUsWScjWOPdXpvmudnJbsjR71+97lSS0Ui+B/dZS4F0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m4k5mIulXKuhWLGqonsu66DD9hQNyIh9ciFPIufqIsE=;
 b=Dq+44rb9IkQWTTL11BFgg7yy6XV0HWMAyTH7NmOJhIUf3GAJemf/ZZVwERgTSNn1f+nL0ttKE0GTXWSQm0LNqi59GWuLodNOqHZynMfVRFJy534IozSylHDU8IM6WJdDR8A9AJxZto5hV1IbU/ENgUKoabP2hFlEMrUaaDJsiRfBbGCfJZ5fYT/Exqgb8ybWEvEaYb0K8m9FHsMoozI42QGVjwdT2KhCWRgrm7eQf8mGnt/rp7deUpT1n1OeNQftFx2/M7sFG/OxUojJ6QwAGy9DtpDOZDNxw9FlhHekK8Xa0cfKcsYFkziolb2Y3v+pzp62lSBZvSef/VsYoysG6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m4k5mIulXKuhWLGqonsu66DD9hQNyIh9ciFPIufqIsE=;
 b=ug4sXcIfoagkDH57Yje+e3EwBbzNLQzO64MMOftHoot08vPXJpuBMFIpJDwt5NmQ7qWWHbtDl6kFASV5Xx07log5pw+ZqjvPHvr+Z6PoGv64AOHSE66YNMGge2kbLegHpZ+/c0fqo5rDZ8JFn6kRODHZr/DQksZpM2Y6p773LZI=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CH2PR10MB4279.namprd10.prod.outlook.com (2603:10b6:610:a8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.21; Thu, 13 Jun
 2024 15:02:48 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.7633.037; Thu, 13 Jun 2024
 15:02:48 +0000
Date: Thu, 13 Jun 2024 11:02:46 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, willy@infradead.org
Subject: Re: [PATCH v2 16/16] maple_tree: remove unneeded mas_wr_walk() in
 mas_store_prealloc()
Message-ID: <qa7zqgwm76eyjkkbqmvi73lvwuqbojjnx3zbppk2b4mdstji5m@fjicd6zbwfby>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org, 
	linux-mm@kvack.org, akpm@linux-foundation.org, willy@infradead.org
References: <20240607185257.963768-1-sidhartha.kumar@oracle.com>
 <20240607185257.963768-17-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607185257.963768-17-sidhartha.kumar@oracle.com>
User-Agent: NeoMutt/20231103
X-ClientProxiedBy: YT4P288CA0006.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d4::12) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CH2PR10MB4279:EE_
X-MS-Office365-Filtering-Correlation-Id: a739580e-48fa-49c6-1394-08dc8bb9e3a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|1800799019|366011|376009;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?XxEa+fJXuFFLczTCx24cnGGCksdQbfm3MYFxEzRLye9qAMWoY7gFpPSOcoVO?=
 =?us-ascii?Q?ESBzmYEAlpxRWYIWhtH0/R4CBD2Ei+dr9/FOjR3O4MN7L9k0J183meN8Y+Kt?=
 =?us-ascii?Q?SvgMQvv86YY4zhGE5FDje6+6n9NTK2YVWNwYzQUID/IOLqD+4Kv8ERssRWOf?=
 =?us-ascii?Q?52dImg7SOwtB8obAZEkkzjCzzH+APyUtvzXlgjBIN5YhOyWKBw91TYscNc80?=
 =?us-ascii?Q?KKJDejDfNBmXnKnCxuMnhBc6+Gk+Ico6+fADSuHgD+HSbUY0tKtgKLrk+Rc2?=
 =?us-ascii?Q?YHoIwYR5RxhNPMbuHfFKEeHBTBdYeE1YPqwM7X87P0tj68JMOmw3pWBlsFLu?=
 =?us-ascii?Q?PPDd+6mEm26G5jZeXQS+3IbCW1cczIdlmfGzTNKKakCqXKiHTziqO+ZncOt1?=
 =?us-ascii?Q?yU8wQkUBj/Lt+rD7lE7iALBH41Rx2mjV0h9azV4pYTzakv7D3smApB3TMCA4?=
 =?us-ascii?Q?gDYClXiDz6koWwTS0U75jQAzOxelgzUgGhDvAt+lnnq4EnNAmWhPLInJdOCQ?=
 =?us-ascii?Q?etVW3NK876D5ZHiVz9pUE4qdOZBPRT6FcKNp1/3wfWZOCpRGqhon63p6/nr7?=
 =?us-ascii?Q?xUnKp8MD2yUMdgRcyOHUd9FfOp82aOhpM9G4HjEDD5mqn77Q7cYCvGJjiwsF?=
 =?us-ascii?Q?AKyNhafbvZ8gkw+nZcHJ+qqJyJS7KFcEISKw3PIcTG1jrsKzm3/JY1e18HOj?=
 =?us-ascii?Q?qcD39qCBG2le7MTcNaZ6RYlaqTlG0Yz26mrILg0VGbWEmeKVTrxFD1FiBDQ/?=
 =?us-ascii?Q?mwKBpVjzY31q7bc8zXXKkZlJxGfBu9dY3r3bo+MgPP3IcQOtLyzwFeoOgHsx?=
 =?us-ascii?Q?FIX1Zuf8vAjiUpHUP+sE0t2L3uoVUTkMqhjbed579B9zrlJFFS4Mqsi5xgV2?=
 =?us-ascii?Q?c06xM+mQum9Ouw0R1MqfXSYOunfl4JlPrH0O5kQ/3KrZIEMiY2SdU7+gzK95?=
 =?us-ascii?Q?3NOT68Nfp7ACBV88Rqq095zHpieTUFqnMc4PPt0laer5kKIzEe9T9krbp8YU?=
 =?us-ascii?Q?GGbh2pjDnFTAQTl3Ozmeq/bjLladI1tUASAihzZTAlax7RSVyJBCx143sspl?=
 =?us-ascii?Q?66qzafWK0skCS2267DGNxiD81XynYp+R5//9x2Y6iKvPbfZKFngkJhPkWFnQ?=
 =?us-ascii?Q?VUMytI0nFYuElDFNdtxc1NfVqzpv8rRczJaGHIm9ZkBukQJxyjCmSmc6GjGN?=
 =?us-ascii?Q?cFpLXdavGxTwe0bCjTlpPrY0EF3Go7cF+GSx0Jx9Tqv+k2da1x63ohMYV7AI?=
 =?us-ascii?Q?oVAcLrSwcWNPNtayWlho3MCVDbrMhVx0oRnn0e9XInyYO6hPyt9yyOQTaji9?=
 =?us-ascii?Q?Ip0=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(1800799019)(366011)(376009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?zQL81xiedyKsjgilCNQuqsjVstx7JedsAfdMwgiWmPwmHISspqlh2stxRhaX?=
 =?us-ascii?Q?i9A7Ex7MtZj5uo6Pn1RWizgQp1OBO5WpWp2mYmfvBY+GU2ZymiyxtbnmagMZ?=
 =?us-ascii?Q?mTJ+wLuhBydbbOHwIMf0A8Wg74j7KRxIKkkqrtt2gFv5s1sj3ZSmei+Q2VAS?=
 =?us-ascii?Q?/hZPHgADiEXaf9rM0nUNBhiycFGRJcq8krUR7W8U5t1xQK7K3YPqXvlKhjL4?=
 =?us-ascii?Q?UhYZpCqWhRswbJZFcNps15p6phgbXPBV9oK2r0ei33IFarX7BT9wmoA9K46R?=
 =?us-ascii?Q?WS0MSwsM+TRI1jxT/girURVcd9p2sjMAyOHP+1jt2wVaMnCo3kDO7POk4YkP?=
 =?us-ascii?Q?MFajWAoBYpbHriR1f/BoAQh8Ab0XlLtEbUYDZ8Hgrqn/+S/moMvNkpK4qtag?=
 =?us-ascii?Q?jFBHmizmDA5PJP+2cS64p7vMB1eqLxu/onz8c/i6Wv9hcO+DN54wn5TYHfK4?=
 =?us-ascii?Q?sxGquBoIWcXeMu4VTW4UbDkBRGLAUBctwpF2KwZZsNmW2nVyoc333sNNxhDz?=
 =?us-ascii?Q?DqBh8bwY1FZuq3FfqpVMjiudtuO9jCzxGY9IeGsF5mpYxe4iEbmHVWlP3kyL?=
 =?us-ascii?Q?NUV87gul7QxGNzC5PEPQVa33NA/QGM3PzcegxX3JJ4XcNJ3YkoNZrTVBaepu?=
 =?us-ascii?Q?x0m8SUElNTP3b31h9IFDzqaOMKQud01T2FbGMIWZtr7olOjmItvTyDbdxeay?=
 =?us-ascii?Q?Xl75F69dSBAZKHXYAuKL1y0lhAY5ivAkpMBhCWyD/bT7vCR+2jaBn4gkYhLZ?=
 =?us-ascii?Q?sijPQWa+a+AdSOAgztGWTG215xaxu2YORmsMZ8XHsg4osqwM4owFQ0TTpdlY?=
 =?us-ascii?Q?OXuGQ2cbfAdOtazwjoVpHGRgdLWhjJBcJhLCcYBuvarnKrvkUCe5HU9UBDGT?=
 =?us-ascii?Q?zmT81x3YDmMsARkIRMzTJhmxlv5g0Cg/7txRR9+r26o4TAq69C0VSgkMsC+G?=
 =?us-ascii?Q?kWilS8avl+kpA3CiOXqcUjblR2AzzlX2hfxy82rDePhyHDL5QUF8KoNjxbfO?=
 =?us-ascii?Q?vlxDmD1tp7pmEQ5leaSGMdU/jGiLkh38SF0XXhXL+cpiSmHIbBPnKrsSqGli?=
 =?us-ascii?Q?fhwUQFMC7/OjzQ5taVqJ9RP8kJeDi7SV5nmZWfbgWY1C7oRNUaEvQvvUL9ZZ?=
 =?us-ascii?Q?a8du5N0DOA77V9NwwL1mUq9GWGZMj9Iez3bu+jmV3aa4PDZbeIW5CFj1njiF?=
 =?us-ascii?Q?8pZQeeWNbL9E2gL9g5HFMs5X1Sbw0TLAxpfKSf/Nkdx+utrY0DiQnBwWU1IB?=
 =?us-ascii?Q?CXrLJeJzTVj+IxHFLYVcxBddFaZrmV5gcqgxxKaDqB4l8j5VMudq4V4lxOoC?=
 =?us-ascii?Q?eLWE5esMP1mwqK8PmfUvIdhM9eztGoswroeXhWfzUPS8Cx0jwYkkp8VB0l3e?=
 =?us-ascii?Q?aipQg82kJGBPz2vNKhiokPT8PvWUuRD60Hb5z6XZGGWAfJPDITLHISx6sGZ8?=
 =?us-ascii?Q?zVqf5FAWOwtCySqEO6w4Qy+m+tXJvll9ria36Vrsf0qfmg7lYUigjMgn6go/?=
 =?us-ascii?Q?lEZUsDO67PNiK4GVwooNm2n4n2HSYo2JXT/F2JWuo9d8QsebwiYaYvGgT/Im?=
 =?us-ascii?Q?D3SEhmWZcGpaurDRfrufkMJd7que1ddo9kFdc6XV1ziXKotXTxT1lQoNLg6h?=
 =?us-ascii?Q?kw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	izb3KQuycSFy2JNYBkYCqlE2D7ARSc735bhEH8nUXw+0GcwQwEv76/0d2n0hB/EqMVAEYSoxuzhITU6vfc+zrtDP5DSbLG0yJZGtRgkN5lFjIyJpZJnxs4NXHyTl3N44DQoZgrIvSHOoTbsEVc70xJtuz/Y22XQ1rtlZBKL5t9opnKH1SQQt8bFb9Jg4O7XRoYPnshW0XrfHdhaxY2Moluc1VYR5oZbj9//d0K67gmIRCab4/zQ/j1DH4A5IZQrKEVMSyKoNNl2koaEMfOy4E+9bqaB1DpWClGv3xCPlKgkLrDeKAcNsYvByCRL542m7RkkPagl6l5MPDK87QPJ7286ZgtpwfumxXr7+U0EGOgil+MFg/38xB4vRI8MsqXcY7AjmQAVSAGDDA292CY/X/T+D7ZJaN0+SjBU010SL/vXiL5ti7oQnxZhX/kwPo3weL354lxvhvBfMoRF55EsaKj65Kn+B27QqmfcQbByoXjJwkeSk2K/pOgwr4Z2izSNTgd1S/LMEXDCrSJp8hX7tNfs6Lfq+vtbeydhl4mrCf714gZQnzA8r8FdHY+7Ifl5QZkOHZ7/TX8oe4LBSXoq8Bv8RPf45qPkJQSz48o9N/9M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a739580e-48fa-49c6-1394-08dc8bb9e3a6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 15:02:48.6123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Tz/Ar9iiP3YSn1G85kUW73SctoJDlk+KPj44fa4gZC9k+xe0B7dlKTYXoQXdnPTCkBA6FfojpK02uIPzFbO6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4279
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-13_08,2024-06-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 spamscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406130110
X-Proofpoint-ORIG-GUID: fqVl7AKV3_GKMgrWd9DqLLYLzMdY2Dc9
X-Proofpoint-GUID: fqVl7AKV3_GKMgrWd9DqLLYLzMdY2Dc9

* Sidhartha Kumar <sidhartha.kumar@oracle.com> [240607 14:53]:
> Users of mas_store_prealloc() enter this function with nodes already
> preallocated. This means the store type must be already set. We can then
> remove the call to mas_wr_store_type() and initialize the write state to
> continue the partial walk that was done when determining the store type.
> 
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> ---
>  lib/maple_tree.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 3d334e7c19a5..5854f25a4ae5 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -4027,9 +4027,6 @@ static inline void mas_wr_end_piv(struct ma_wr_state *wr_mas)
>  		wr_mas->end_piv = wr_mas->pivots[wr_mas->offset_end];
>  	else
>  		wr_mas->end_piv = wr_mas->mas->max;
> -
> -	if (!wr_mas->entry)
> -		mas_wr_extend_null(wr_mas);
>  }
>  
>  static inline unsigned char mas_wr_new_end(struct ma_wr_state *wr_mas)
> @@ -5598,12 +5595,23 @@ void mas_store_prealloc(struct ma_state *mas, void *entry)
>  {
>  	MA_WR_STATE(wr_mas, mas, entry);
>  
> -	mas_wr_prealloc_setup(&wr_mas);
> -	mas_wr_store_type(&wr_mas);
> +	if (mas->store_type == wr_store_root) {
> +		mas_wr_prealloc_setup(&wr_mas);
> +		goto store;
> +	}
> +
> +	mas_wr_walk_descend(&wr_mas);
> +	if (mas->store_type != wr_spanning_store) {
> +		/* set wr_mas->content to current slot */
> +		wr_mas.content = mas_slot_locked(mas, wr_mas.slots, mas->offset);
> +		mas_wr_end_piv(&wr_mas);
> +	}
> +store:
>  	trace_ma_write(__func__, mas, 0, entry);
>  	mas_wr_store_entry(&wr_mas);
>  	MAS_WR_BUG_ON(&wr_mas, mas_is_err(mas));
>  	mas_destroy(mas);
> +

nit, this new line should probably be before the "store" label?

>  }
>  EXPORT_SYMBOL_GPL(mas_store_prealloc);
>  
> -- 
> 2.45.2
> 

