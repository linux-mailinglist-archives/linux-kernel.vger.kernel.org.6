Return-Path: <linux-kernel+bounces-409921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 777509C9364
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 21:46:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1EF2B23175
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 20:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E993B1AB52B;
	Thu, 14 Nov 2024 20:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Sx3Fu44B";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="J5oGo9/U"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED41E2905;
	Thu, 14 Nov 2024 20:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731617182; cv=fail; b=U+/eNY+XzzcQDaE6DKZ1BsvayVwif/9bD6s9o90ZCr47AOebiS5iRJljCxbADs3YdGfLNa85Xa6NkWMp+qvTC2wHnPooXpoDcIjhcxy2zLDVdfawz8zOY+gcDoRBgzssXXTh+iTiMTcEOs1GpdzRlMblTb6joV47tQH83aY0KDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731617182; c=relaxed/simple;
	bh=vs3WofJD6EawIP9hPIDoossMwsLLIZSSWkNHI8uVKyA=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cpv7o/ivhuCyRFaDcR+z3a0Ip62OSX6G/rempGi5iVzTTFp2Vp5EbgAL3DnILByXERooJPdvD1369v69sRT6NmrcNk5NYO10L8SjqOQpqMMzN1iC8DdawFAhN3P4ExMagyOAFfuBb0L8zjk9cHxa5JhPJK+wDu88tY+R1vrBMRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Sx3Fu44B; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=J5oGo9/U; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AEKfdgZ010298;
	Thu, 14 Nov 2024 20:45:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=bc6yoHbrQwSunBCU4f
	uArDqDQJRxDIUgLo9ueWO8o9Q=; b=Sx3Fu44BRJUYMi+4Hd0oiOGkAtY4AkzBfT
	DsLG8fy8Nk96nKXsqtXzKQ1DFsxb+g8XG3Ufphmp/4PFVJHHlDojTc+BniX+GCf1
	VEpsVUMvXuDqcW3p/oIr1M0Ja+b9UOrG9ZYwK/AAVu+0Zzg2BYjSZiGofnHKlHpR
	rBk2kmrQCg9KzWeoUoG1SNYfMnAV99JGgDMGla5bC0k+nlPl5X83xVJnYUSQ2Mji
	HAW7BNsKZngrpptmS9g8YFhRveMv+pHZAnJHqP8Rw3kHtwYAN31wAT8mCmOwJPfc
	aqHS4ao0y1QQjdpf+1xla3REF8z+GXtoT6CQymUWJpTo0jUTaBEw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0mbj8mu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 20:45:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AEJLoJE001225;
	Thu, 14 Nov 2024 20:45:44 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42sx6bpuse-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 20:45:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fb6r3FuDzGUrp6/8MAKXpT3PnFWZ8Os6l7OgplF2tL6i29qzH+YQkO62d7doMt1VHXmeZ3mzSwcLbkH2+YoHiLDXh/X7U4elP+8D73M2XwkDGEmyQjGUHa2Y5gAc1K8ZKSBKPA0rx3qqNUuMUAyyt1n/7ixxfyvXkFjnABR2xjDNCMhSfQa4asCkjRcGiLsUO5XxLDUkVQF3rT1WlCsPaPD/ZCaf9XOPEuI+jRn04nOmjbGcblwSAptBHoNqCi0/jLNGwAdoinMaj7iMKkHY3a0AELPNahf4VxjkJCMChGtElnJBAs0p22ok+PPouDfmz+OnK5iLP5EfmzzEdYGK+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bc6yoHbrQwSunBCU4fuArDqDQJRxDIUgLo9ueWO8o9Q=;
 b=Fn2KSf4eo7kC5t4sLPf4PS1P+K21dMO+RJ5z0luY8I6BMTi9WvUkI9mwrU+rs5HWVOPQpFQ3iZ97kUGEPelaOuUx4RTaOL+SG8uJFys7DoNAu/8MywVir28vVkaK7OfhnEgM2ui0P5cnTGM/pFdwmpRNSY/4hRwiklf9O/zcF1XGmk7Um0g97N255bcnJWxQFbSvwPbLvM51rnd2zXgz0qp3bxqDdeYcvPLmzWqEi0eFiJGY5dcTid1oyKtf3p254atszvZEygET2vZHZLIQtWz6Ns6O5vJjfiGcW41XaHaYVHeTi/jofI0/fpQjFDuAPZOn97j9tMsxj+arthWpfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bc6yoHbrQwSunBCU4fuArDqDQJRxDIUgLo9ueWO8o9Q=;
 b=J5oGo9/UGcjStaKyKXTYXtINvHE9tlO9saAm6AZ0ITFYfeNtXHkGAbuL25J+4dQQmbBAOhgcEx43vBUpWhzaDauGsXHlC8dLEdi2Y3J6riQHSu6gNfDRmTBnOpOinTAZP9LVzoc1rUuKWGRrQitvQu60EBJrq7mlfOQbRhi6OMo=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by DS0PR10MB7344.namprd10.prod.outlook.com (2603:10b6:8:fe::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Thu, 14 Nov
 2024 20:45:41 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8137.027; Thu, 14 Nov 2024
 20:45:41 +0000
Date: Thu, 14 Nov 2024 20:45:38 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, Vlastimil Babka <vbabka@suse.cz>,
        Jann Horn <jannh@google.com>, Alice Ryhl <aliceryhl@google.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, Mike Rapoport <rppt@kernel.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Suren Baghdasaryan <surenb@google.com>,
        Hillf Danton <hdanton@sina.com>, Qi Zheng <zhengqi.arch@bytedance.com>,
        SeongJae Park <sj@kernel.org>, Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v2] docs/mm: add VMA locks documentation
Message-ID: <77ebb384-cfeb-4b13-aaad-c9a6b398fecd@lucifer.local>
References: <20241108135708.48567-1-lorenzo.stoakes@oracle.com>
 <le3ykvrau2lbncrjsqll7z6ck43bf3shon4g5ohchxcvcs4fuy@h3pq646xgoz6>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <le3ykvrau2lbncrjsqll7z6ck43bf3shon4g5ohchxcvcs4fuy@h3pq646xgoz6>
X-ClientProxiedBy: LO2P123CA0079.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:138::12) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|DS0PR10MB7344:EE_
X-MS-Office365-Filtering-Correlation-Id: eafa9256-a6fa-4213-080d-08dd04ed4d98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zEmgcsMICo6g4NWN+aaK6hPyfmBXkQBKEVqwWtpDLVh3NSOty3j4YmURdng5?=
 =?us-ascii?Q?3Ko340362oN5v83NhPJq8SWuyhyCUdDKlwCA5rgU1KRnPD2ywiu7MTeB8bKX?=
 =?us-ascii?Q?uM7qBkk9I7ml+0tj6rY5KboffSkR61dLpk3sAxboc5pQSDj2Od3qg4EzFRRx?=
 =?us-ascii?Q?K7aCfCJp55/+0cpC4X/znYrxtRbwBPaiw0FuoGjoFca3oZuoYw/JCpP/Iu/9?=
 =?us-ascii?Q?LtPB4k9WrbhWUqtAYFb5Z9vx35BpowzY/pRaZyuRwuOa1xd2QPsQ8Moy+DSq?=
 =?us-ascii?Q?Ozyet9PF+QeD21A9kWavSBhpLbdoTzfqoDDKRlOydofKt0w1U5vc4hEA9M1k?=
 =?us-ascii?Q?9l7uHcHv818Ipdd7s5CnPiQPMiIAqWlrHxFqeNOfhAP16fkEf7m3lpTBlDvL?=
 =?us-ascii?Q?LMIRygstrCIo7FSk0fxSWpnTwKV08q6F4I4Iu3SGFQd5gfblvgUttL0K0kzN?=
 =?us-ascii?Q?oxawyQowkE3eqop7rMEKN/7o9jEe76sJJbtQfxEVNbuWIgXYieLGsLpi1wrx?=
 =?us-ascii?Q?Q9YZkxodD8lltiyqRIOJICjU6yxGmmMSgm2BgYaIwUOMbN+J+yF+XoNCIjlP?=
 =?us-ascii?Q?iv1TeSrDn9/56uzsCqKmzd73bl8t03/8VsJnY8k60sLnFlUix4A35CWUU+ux?=
 =?us-ascii?Q?LWwElAKrPMxGJ26CJOZo35l30OeU0ihZ0awdke0lkhTpNl1kTYTxu9+QyA0A?=
 =?us-ascii?Q?7KDV3FvoCnacSDYbbkmxHHvJ1mK2H9yXoFluozJX+0/yInIIr9c97z+jalh4?=
 =?us-ascii?Q?JUI2gun7EsPmPl6wUg8Os+oVPaP9HkXkVS30ZzmVYSTNZfWL9HxdyWe+U3yP?=
 =?us-ascii?Q?M9/4EQqlXoNgcGUJfBr1TtwXNfm5hle2B46sulOyK+qBYRynyChteIJJ5N6q?=
 =?us-ascii?Q?/V7DDmarh+BUJgF3ceqVzGaeZXbQBDOuwQGM3dhdG5aXLKVWgQX/bsOpC++d?=
 =?us-ascii?Q?01b/V+T88V42IZB773oilG+ozBDQkj5RnmKMBltTspw90U/cjvCUli4VGSr/?=
 =?us-ascii?Q?4vtikneAAHdDcV+14LGIJ4t9MUq49gVdLkMA7CldV6zH0Pi9+T5QYUeIxj34?=
 =?us-ascii?Q?GTUERKTMXl+6+dqLmMiesnAhCBP+Z0yo8h5CvR4GxpQ9srghScTI/2PL13Rq?=
 =?us-ascii?Q?6mhtIJSCiVxBSdcycIfkzsNH7TQ5vc9HXJ/M/KgEJL25rdbXUW4KLMz3/vYd?=
 =?us-ascii?Q?ikqp+HQOLyCCB2cV2y56k9GSNc/GxTAPmxjxZXV+z0yuug2osvbe661tePy6?=
 =?us-ascii?Q?37yKuFBCjD0+EswaYDCBM0ucknO/kno/YkVNoEPc+wQbHJ8pGK1NIne8ZwAl?=
 =?us-ascii?Q?bTtGp5/xo7FyLCk52//c8M3TWomqEJg5521CiEsb3BQWpIMpdikEY6Senfy2?=
 =?us-ascii?Q?4WtzCQY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EXBk9c6sAyfzW6EtrBhw4GmJiFA+GI7fdL7viBXrQ1mEHcrjoHF/3DqQjmRl?=
 =?us-ascii?Q?mHCys3lgtMAhJ5dzV39Fr9HyoJ0bzlr/qZmvMQDkahg/v4E59bXpaKplHcfl?=
 =?us-ascii?Q?CI9N9xiWCybgHsXCR6TbYngVKeQWGgajLReF7eU7+XEnc2fhe4MmUeD+Ycvt?=
 =?us-ascii?Q?kRmgbsoKvFGeA2JAW56SaLFuXhuLgC6C44pod9LhlQ0EffoINVg+Xy86CqY2?=
 =?us-ascii?Q?K2BlKEdB+d9S9vJ9hf7iqUgE7rYzu+CI8fx0SxpBUPm2xbf5YNPmAoU65qk/?=
 =?us-ascii?Q?UQoeOksH8ABrB34ovfBPuEm3Pqi7tNOe+s/V6oYdv4zxtdq349A79IeIVyBj?=
 =?us-ascii?Q?h6LB0f2OmxoY0/1lIVjCWv+v2D1kGUF+frYqDPQmxbCQNJ//maggWymAWKcO?=
 =?us-ascii?Q?ndZVbewQTYIXN1C18OxV0Zk1dbDsRbDShonKaZ2nGb6TlqaYqVuagOLW+ZpF?=
 =?us-ascii?Q?6BrfPSJPlbAIFD4whjKbso0gzCQvcUvGwWfRQiHrdDjrIzL1fBHfK/7y1LVK?=
 =?us-ascii?Q?LbQAs35MZtV3sLM9BQDsRkNagDaZ1BWJGdwRngvKlWvX+V0H7yFfNZ+pCLQ3?=
 =?us-ascii?Q?vhjbpmARXtyNOpLgJChn37W1/kg+o6AjBkCd6YaFsgCJY2jWJ3FRwJVvhvCM?=
 =?us-ascii?Q?vyZ8EFi57FQsyroaXAlDUd0glIs4G35PBmY+tU4h9w0chxIEm2FioxzZCZ41?=
 =?us-ascii?Q?Lzx+nuppHRTzIeXoAe0xHQoiA00N9L4QbPCnDdmabPwgo+b+rdm0McsDgCBM?=
 =?us-ascii?Q?JPWcSEzPF2IN/YKeEgK6Tjf9LStiCHuv/c3ySnYTYRkSUDxTJ6oNg6ZZ+JNL?=
 =?us-ascii?Q?G/X1PNSBYUDmtbzQ1ew0Sdmi2CfMdG+Wn5Up7GUf+xn1aXX6ITo5tbPpyUTL?=
 =?us-ascii?Q?U0B6Aw7SqF1RFGTSNhLm8NV5smnHBT+QXFFlMD6O6Gv0PaSohiCRnhaGyxTz?=
 =?us-ascii?Q?7RKONgIVf8HpTu1Rkv2sTByOjMXDCNKFhTKb6h0bqI0TKi/2Th8rsnpeFAK1?=
 =?us-ascii?Q?Sp5oF1OFft5UhlLr8ATPFwmt+D3f4QebLYx3NnlA5qNAdx/ZcmJl2JdjMUU5?=
 =?us-ascii?Q?szNuJgVynhi3bO8Rhko7Y5fOL6OgM4QGjfo48asWTpgBj/azooA2/rugSdtR?=
 =?us-ascii?Q?5sILu749aqWa2hAQE1u6OrHwa+peh/gARnCp1kMygI/PiNeaT4Nsfo6ji81y?=
 =?us-ascii?Q?uxKk5pn3Bk3QgcE5aVUXtZo+ez2E91hs86h8vmBtyRWjWOQm5ythmfwB35bF?=
 =?us-ascii?Q?KlCBBMWbjPrtTInDUN1AZaX2oLWq4Xn1Vnas9PEvUwZbwgjj1HJWD09+246a?=
 =?us-ascii?Q?nag4WVBNv9zP6qfP/20i9ddMFpT5k9MVvmIoqJB1qo5DGgASewTdkhKupjEh?=
 =?us-ascii?Q?eBr/mpv5lWTU5sYcan7cTn5JjfX3SwU8KEZQsmpLNyaQLRaXXap0mN5N76xg?=
 =?us-ascii?Q?tewf0oeOkLHj2calQK8pL7TXocaoGdGimIf3IqJ9fRnRyvLALvDbJSRQ2HAC?=
 =?us-ascii?Q?9d6nSrtz5ximEt1L8ONnL8A2QeEKglXRy4elTunYtIA74CSsfbZREFUu/bDT?=
 =?us-ascii?Q?+S4trJT0U9yKHsmufrZNb1bVbVb/sLDPnddkD6AtLBp3qID7e0I9UUU3iPf4?=
 =?us-ascii?Q?TQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PoxT8JLK9kN8v0A2dV0wgsvlXP5HC4OWvj4oFnGbzXcVVlt+caBCeHvRK68/y2Q7/1P0Vt83aE6zAuaF0KytOqVsskKOxidItZB9huRSqXCNF6c3QarTr4+jafs3pnVmysnlRdD5wPnuY2T7Qil2RsjwH/kaQWA0XiUi+VzHJJmJksjhYX9rIddn50vFnhgaA/wunVOsb1u1IZXFJFcoAZ83ics3zuyiraqcrfDhfWl78sN2pSTXWkj7ORY0qgctUBu7QxZVjWQSVmJzZaAg/u82gX+OLXD/x7XS3RcjHgUglDp8DY085BTfixe8qQOuExemEuLcN4KLGGJ1OhHfele/L5UE8yFpMCU4JMc1TZ3OB+VmSWku+o/rB/swBMjDb9shIXiumzTUOc7ixEABZAuwDI2e+bFsNKj3bps3Npj1vez9dHi0C+InfwoB/hFZd5V6ZsNmcotJM13q69aR7DbrM8vnLyuXWdU1dZJ6Gmn0abm70hAiN0iOJd1dJ12p9p9qIpVJtg+LUXh+Qmqv3VYC1ZElGnDQbQ2XCl4anUgk7YwLRmGTM+67IiY0RAWVsCZ/+5ZdzZZVAztME/0ndzocoAcN2Lo9SXvPaT/NvcE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eafa9256-a6fa-4213-080d-08dd04ed4d98
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 20:45:41.3898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5fY3D2fMaDgYMpkDXCD9jpFZulxduW54F2+F+f3vf3/ySV0+4dsGhGLGZSXcGml5HueiWRck5FAAGE4LdLDlg+lMeloq9q+o//LGOSjpz+M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7344
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_05,2024-11-13_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411140163
X-Proofpoint-GUID: 2KDGGwRPiERSa9VD4qXtEsfANnsZgP6k
X-Proofpoint-ORIG-GUID: 2KDGGwRPiERSa9VD4qXtEsfANnsZgP6k

On Tue, Nov 12, 2024 at 10:15:44AM -0500, Liam R. Howlett wrote:
> * Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [241108 08:57]:
> > +VMA locks are special in that you must obtain an mmap **write** lock **first**
> > +in order to obtain a VMA **write** lock. A VMA **read** lock however can be
> > +obtained without any other lock (:c:func:`!lock_vma_under_rcu` will acquire then
> > +release an RCU lock to lookup the VMA for you).
>
> This reduces the impact of a writer on readers by only impacting
> conflicting areas of the vma tree.

Sorry I totally missed this last time round, will add a note.


> > +   ================================= ===================== ======================================== ===============
> > +   Field                             Configuration option  Description                              Write lock
> > +   ================================= ===================== ======================================== ===============
> > +   :c:member:`!anon_name`            CONFIG_ANON_VMA_NAME  A field for storing a                    mmap write,
> > +                                                           :c:struct:`!struct anon_vma_name`        VMA write.
> > +                                                           object providing a name for anonymous
> > +                                                           mappings, or :c:macro:`!NULL` if none
> > +                                                           is set or the VMA is file-backed.
>
> These are ref counted and can be shared by more than one vma for
> scalability.
>
> > +   :c:member:`!swap_readahead_info`  CONFIG_SWAP           Metadata used by the swap mechanism      mmap read,
> > +                                                           to perform readahead. This field is      swap-specific
> > +                                                           accessed atomically.                     lock.
> > +   :c:member:`!vm_policy`            CONFIG_NUMA           :c:type:`!mempolicy` object which        mmap write,
> > +                                                           describes the NUMA behaviour of the      VMA write.
> > +                                                           VMA.
>
> These are also ref counted for scalability.

I think actually on second thoughts I will add notes about this in v3, as it at
least gives a bit more context.

