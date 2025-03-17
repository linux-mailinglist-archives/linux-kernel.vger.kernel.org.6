Return-Path: <linux-kernel+bounces-565070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64514A6604C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 22:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49EBC3B2E84
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 21:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EBEE1FFC44;
	Mon, 17 Mar 2025 21:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GZA9qEw2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kb9mnzB5"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50DB1CA81
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 21:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742246203; cv=fail; b=mdyA5EtVT8JI2doxYekLPjsZtAA2HKvawM6s3mpqW98IOmHNJIkiTCtaW9ZXxrWIWRZQgNZaEDvvb8uJCwADVj3maX0StjhMLbwsI75HtLecUdHe6xiBkg+p+xGeaaDAC78Y5ZtJTEW6CiRzbesUgywf6/prp9IQYhFMGGwhDME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742246203; c=relaxed/simple;
	bh=55ubcT8ttSzRUIuZMe6SFuiKfJAUxN6zwXpwDxtKzao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TnJfi7j28Q1CS4FVyfUZaKoDdxDhgnys53iKFynqFoun0qYtph40Wami1GmZ1kOXPgrcOGVwS23ZjLcXpy+WthFXPawHENONUGjizSMGAf9ix0ZyjKuVd9FHbYBzNPBigypqtkllRa59YVi5pa2CjHvWv7UWlVrvaC5QQXI661A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GZA9qEw2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kb9mnzB5; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52HKxTCT008309;
	Mon, 17 Mar 2025 21:15:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=ARIetQv6XeaY5idpJw5j2EHsVFHKr5j/kc9YhY8bEj4=; b=
	GZA9qEw2fzYd+RzUXlQyAp8He+lBffWEnXF6Pj0deBHKEHdI3VbKOQpm/ZoIfHbn
	W62mSgUXOVlj6SP0CdyovLs/Bw/El2LufF8pvcm2ldaQS3qMnEIma+ViRNhIg+wi
	sHdSfoAWm/mSssLVDACqa8vdQXjvCXAmBmu9GQWC6TUEZITRHc7mGbR+CrZ7prEh
	7hUiLb627/ZXiCVFjE/GL1vxzSFwlCYSbZK3HIOYIBtoHjfRp+DMtC7qG5OmDNDJ
	uDhS8ZAb+Ft4HDJD9eKD2Av1m+4Mo06lfGpfBsVuZpO1Ts0AJ/POPK2V4U8sl22M
	MAmfAzRdT+SUb6Z+UX1glg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d1kb408r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Mar 2025 21:15:29 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52HKbICg027962;
	Mon, 17 Mar 2025 21:15:29 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2172.outbound.protection.outlook.com [104.47.73.172])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45dxdcgg8y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Mar 2025 21:15:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZL2A3e4MHoyMrygV7NU5RMgpRSETaQuJFBt2ZDt9/tmE8yLehrWOk+ErLJcsOtGU26dQhMDVlNpSrnJl/sXjfP4JaFqmJTRR8n2AHm2iJfWglu4QjRqSKofgKHwyoAsVLr+od2VT1wO4veUkjPlxGrjyi5DKdq5+cMVGOt4JOwc60wTOWXKuS+9h1cvUHg5sUJLE8uLKgUOLv1rZR7Mfv6vwfr1YToMyPB4g9fC+AeTVWCwtSFlp41PU/GdFYrVIvMMKzHFb2pAglblb2dOoRkJH/XGsbHCOudhf/+vllkP/eM/56HeiiQTQ8rLHte/wjDINnMZSd8etXj5ZeXrvqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ARIetQv6XeaY5idpJw5j2EHsVFHKr5j/kc9YhY8bEj4=;
 b=D0o2WjHtZcYb5ltRIAE9sXCxvhRs9FQ9rPZt9iaJMoC51JkffqSIXyj2PbtG4jw7lkn0WcCufwMOJn/FS6DSa4uA9F7BePgKwuyfImlChaSVI5n0IiS67TJanKR+psHhl3xbpaICJlpVthaYMMFlPr73iHIH/hYug5C0d3cK8IGmSZ5hbVWAS0H+QYKvQEWJOXxBzRIioxMV+BfJBVUaEh6xAb9LJca22EM2MMuPhPtlRmSCj/DHiegWhEZyMDIVu4cUEcYSm5NNkk8tIsweJ+VMrgThr9U0vvQvaIENpQSUd3P1taQoCo0D+1jpkji5EKyLLjzwk2rfTYvR0cOFyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ARIetQv6XeaY5idpJw5j2EHsVFHKr5j/kc9YhY8bEj4=;
 b=kb9mnzB5HQEiGooAuYFAKP8T7f8dgBpvPgHsKdfeBsdrxGn2R7SNgWtMOqEIeWs9lI7baPoLqQ7wiQOE/djQE4DbDgQgv/y4p3L8EzMD5dWH75ohyZa18t62lhAicsBax2VOYcZG1k5Kq6j3HiAC6HOaLR0D542fj/13m7bErFk=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by PH7PR10MB7105.namprd10.prod.outlook.com (2603:10b6:510:27f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 21:15:26 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%4]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 21:15:26 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>, Rik van Riel <riel@surriel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] tools/testing/selftests: assert that anon merge cases behave as expected
Date: Mon, 17 Mar 2025 21:15:05 +0000
Message-ID: <e9e016392b6ceb5c58a868439fd7039e31bfda18.1742245056.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1742245056.git.lorenzo.stoakes@oracle.com>
References: <cover.1742245056.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0118.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c6::8) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|PH7PR10MB7105:EE_
X-MS-Office365-Filtering-Correlation-Id: ac5109f3-e423-4ad1-268d-08dd6598d657
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QtGOPyeat/62idNLj1kXhUxl8Yh0IQZiBRG91c1sT3ak2h9paP5E4qNHd17u?=
 =?us-ascii?Q?bQSvp0vrxP+Vc4bi3ccfuLgvOPSQ9XVYP0z185PrQFPA+gO4Tq7RDORsaRqA?=
 =?us-ascii?Q?pRUdP1hdUqMOjTqbwP5RI10Xypbw+CNKNsGorRlM84xc8bcAu4qPyVNc9l5v?=
 =?us-ascii?Q?hyfKJgOCuAlPmIKUsFLo/N7DSCF0JFUmLiYjw56P9EepBCkpgggpVTU/3N5V?=
 =?us-ascii?Q?jTKEP7zuHNCNcV3pvSuUJTGjJvkSgB+zb+g5vcPmhcTJU+PwSB4H5iYjjGE1?=
 =?us-ascii?Q?Tk61SxqUhEOINZv9Kiec29/I3FKsIUnFUFuz+ZiW/Fy2a/RibjUPOwuK6ZQd?=
 =?us-ascii?Q?Hbq4noBHDn89xi4RDnBmiHoIRuXm3SMiX42WVfN4Hdrk4N4hjviP19r+8YlK?=
 =?us-ascii?Q?RRIf++0ADpSI1bs46n6aSfeuj8nJ70By2k65d+YTtfDgUFfPv1JPbjUnngWC?=
 =?us-ascii?Q?jZYQliN3JFBKNNyCoOw6DhgqJoBn1x49zKMVKi3BIIARqQ81o6qejwPhMxIy?=
 =?us-ascii?Q?5wbxo9dxu0WeNCFsjwo4AbCmYEIH+tb1/ukppb5Tz0xIKYBg+wz2sYWS9gV3?=
 =?us-ascii?Q?WDsge3Q08PkaBXfZy8IKcezST0hVeU6e6XvTlgsJOKbWVMWQJE71kE0brJj1?=
 =?us-ascii?Q?tTCc3B1kwDM3KR0TnmOW6aE+2RHzvCBtMsrZ5XgNXVXFXDBGmcaTU7u/DWbT?=
 =?us-ascii?Q?E2hAw5Xv+Lm3Ok6PMrP1byiaCkP/j7TfMvf18NJsughbk3g532zPxRaG00YR?=
 =?us-ascii?Q?DRXyZyMgTKGFRFaXw4//uAtb4jj2OxHfCVNx3ueVxOZg7nzDfy7UjcujD50D?=
 =?us-ascii?Q?zZ9v8MBKaI0F90leBNQYoSGfeaLXNcD135ynQcebOq66HW/jNPqi16h5tI1D?=
 =?us-ascii?Q?mhH4/lLeQ4L/y62+hsL5OEWWTnEeQCet0ft8PeIxWWYwOakkdeSQMVUqayXU?=
 =?us-ascii?Q?zWaPXA1QlfXk6YBwa/1JU3DWDt33r7zywojDunNOjJO1Ek7N/8Cp93mCvA5e?=
 =?us-ascii?Q?IrUNO7WlCzgjmgjSClaVnrqbA0ojVN8FRHE+NUJ2R4smtjCsquyHyfwxgT/l?=
 =?us-ascii?Q?ShTLKUdYQeBnIoIC0TskcY4kx/5fkBhiXMNemti5oVmqTK0XlICOKYjKlYa4?=
 =?us-ascii?Q?gkeu7NBk6BPJbneW9f4nJEerff0073XJ0ojJX/LuGYBbZamYWqya7O4nJnx3?=
 =?us-ascii?Q?0WOvhzG/O6gEHHhPeYi3geX2kAaxXvn3zFoYkeD23feztal8jbZdwg5isqP5?=
 =?us-ascii?Q?SrBoGEMquEfvBLXR+PGyzX2nEPR49n8o8HIcFPmilGZiBL/JiCmhqtzjqOyL?=
 =?us-ascii?Q?xQrzJhRfU/eeUrCAfWKdX0MYd1IU78Tsj2lxJ6LulT0V2ZLyx9AsVcagUsOb?=
 =?us-ascii?Q?eqoIo6Iugc6XCA+Q00283/B9dQ1H?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Lnq5V+MS7NIh9dBGDcIcTIIUXmb4OSxJ4v6uJH4DZbC+TPh5Qd25tuUOHhX+?=
 =?us-ascii?Q?hDnukV3BEQV3PqLdoeRICa8MCd5//nARZ0ZsUsfV5hwILSug6o2YoxG5l4W7?=
 =?us-ascii?Q?YAg+5C/AMo+FBdeFpwog/LKIhzLc2tuf/2HwXjl9A27EIACp7lyo6vjBNuqy?=
 =?us-ascii?Q?xcjm8khxMv3/6/gc/fiS54wWnM10qPJPW9TU8jO9CQrb4phT/68zuwbBMbVg?=
 =?us-ascii?Q?Dp8fmOgAnsjILVaGL0wQl6R2/JTWJSqidebit2tNqCw9C7SzaW0ZtkL/mz68?=
 =?us-ascii?Q?+Up1CR9OmU4IQ6TVFq/BrQL0qsxpB+W6KawI7o5ir1EMMAtgNz1OWlR+vRPm?=
 =?us-ascii?Q?/LpbZxg4aI45dXCnWIGUKEZmlSoMHA5ijFKcSITZTeP71jKMGFuh6q5yJPl2?=
 =?us-ascii?Q?wfGD9CR5gXrPYyBvw3X5O+1FU613eKc/MgQ37qartcQexKwlENR55ut/yP+P?=
 =?us-ascii?Q?GRrP/yYSl8EOmJBBihlD9kU2NLU6st6stkyEGnrXbjloTC+67x+77UVIKdPd?=
 =?us-ascii?Q?a6MP8iNKImz3isQgkXGpdiHY9u8W+awEP/5nrZ5qa8lFW2v60bei0iIWP7ia?=
 =?us-ascii?Q?CuOqnHFZ7sLXLt9ZZuCVtJL+902+7pCh8sTDBonRino/e5BOjmDfP2PQQIwC?=
 =?us-ascii?Q?PFzPsH84fgdvr2cwkxNjifC27oG+/26HY76M/YKLtSuFfTBWDyBNmWUsiwaF?=
 =?us-ascii?Q?mxDAVTE0wq4/ofzE5nDMh5U7wHgcRQCvcKFBmiiI3EQeq77Uen7OxnUTVkJb?=
 =?us-ascii?Q?f6HuQlQMbpdcguIazsueGEGlqbW8TR2NPHQxjv4VQNso7tq38sr0L9EZodzB?=
 =?us-ascii?Q?OLPIWp/LUeAJPVwnhfJYXqIkkYSz8mJ4DTIpvM/0TQK28mFEQZrN/Xyu40iL?=
 =?us-ascii?Q?NBXKQfOu8T48FJzZm7S8cWLEW9KajPm49mwy6zXMwBFN6qBq/EhgMgRIPIHd?=
 =?us-ascii?Q?DTDUyd8iT/XXYYOF9OT+g3ryBYg5LbXFiwx7bJL8My4SANl05AoesPt7zgfQ?=
 =?us-ascii?Q?rO0E6KrIlEUooR+wJRJDCYJuwkoNEMoLUHPuYau/LCC3rpa9/MQaZ08b6u1x?=
 =?us-ascii?Q?tFDlomBj3ni1ILeRSH9Ur0pdTPLAu0ULVb15d4vMdFPaI6dJZ+wBdClfOROI?=
 =?us-ascii?Q?Huu3y2pvvr30urXNw2zR5Zeb3b64O9D6JhrfmcMdaYmO27y4NA4xR5trsbdq?=
 =?us-ascii?Q?WEZWGKFIlC65CLS99vHxac/ytqBCvp4OpiONd/xewtCbaMM3cKoFhk+mqwCQ?=
 =?us-ascii?Q?WjBidNBnK6LNJeev7TEmx5NO7I/xgU/gRNpRYy35Gi296CjinZBI0klFwcUx?=
 =?us-ascii?Q?1Ap1Z+bhD8KLyuhYmOaYei/7HiD6fuSFI1E+cVk1xZIhd7yhiOukge/6cp1C?=
 =?us-ascii?Q?ewGrr1RQdOxrKjAUWVaAozfRrH6lhrakJsZCSX2ZW2/RHC5spAFYOwrW99y3?=
 =?us-ascii?Q?O2/j/B2oAZqR93x78e18HUSYD09GqS9P41iVSFEHg3bZCsti6klv7z+SpoL6?=
 =?us-ascii?Q?pcmIbqUO9p32krIMd0qJuzSNjQg6dQBNfGqraWtQkcNAyIRcGNsebhtSzrgT?=
 =?us-ascii?Q?fK/rxdq+M0B4+VmjC7OpZkthlcMxlZ6Ce6gNmfdLYMhhUG/ZdtXKgDaiWSBE?=
 =?us-ascii?Q?aw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Y1I/7AJjEamXTXVAQnYqfeOMLbyuEi4/fDblLAHcTbtxFZtdghCm473KoDZm3tC2bmjVS9xroZTLVis/9Uly2fMR2nwoIg6XGAmQ3KbYcLFaaeoipu0Wqbl6ChVH9eN5PIq7FKbeP4lpKK9A1aVyngktHfbRy7nfbWbXXooVoJhonWiYoJy9H1uNAmDyujXP0Y0TRwTh1YMWuDyX2CR+YI8s9JTrSD/uRIdeaXZlDy9mwb60lQm6IGbMxRFlGOaMVLcIH6rgvgvm9vncE9IC0HG4zSJT/x9j9HNeHRvJDC3mugwnHvGQHgW7JC3irpotvbPE3fGINdcaL+o70q9B/II8aTM4HF7aljNnAPHlTh3j3TdnXswQxLQgNKPjbHN1X5befTs0+cTDkSB7vRZ9XTHnFK4xZdzsmq6uSU6UUrX23ZSnhaClifgyFDNLIKyLTLGqw7VNUCV7XEjBe4nRWplueYSS//Fad1wwdrjJUCkEK9GvlBXkT++K20eJgRpqBubRkKDeGeW8pfKr9aBiARnzhTXInIS3QouEPqmay3EN3mgssBI+2UudrIZ9ZkWq60/ECpKvqGcXcWYpPNoGhtx30F9+08tGV1WPp+h9zTw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac5109f3-e423-4ad1-268d-08dd6598d657
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 21:15:26.4079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mpEKXES/kmXHjxwJq8tCt1veYNIWkPnwik8dvi5B/igGXvVBgrN+FU6rDNJYgg3EPSXUEC/nk6yPJpvQR5qeBZQleiHSAh4VwPD0Wnv61js=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7105
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-17_09,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 bulkscore=0
 adultscore=0 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503170153
X-Proofpoint-GUID: i5rlVe6OxLCOJcS-vwhO--xTuMkFF9zS
X-Proofpoint-ORIG-GUID: i5rlVe6OxLCOJcS-vwhO--xTuMkFF9zS

Prior to the recently applied commit that permits this merge,
mprotect()'ing a faulted VMA, adjacent to an unfaulted VMA, such that the
two share characteristics would fail to merge due to what appear to be
unintended consequences of commit 965f55dea0e3 ("mmap: avoid merging cloned
VMAs").

Now we have fixed this bug, assert that we can indeed merge anonymous VMAs
this way.

Also assert that forked source/target VMAs are equally
rejected. Previously, all empty target anon merges with one VMA faulted and
the other unfaulted would be rejected incorrectly, now we ensure that
unforked merge, but forked do not.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 tools/testing/selftests/mm/.gitignore     |   1 +
 tools/testing/selftests/mm/Makefile       |   1 +
 tools/testing/selftests/mm/merge.c        | 454 ++++++++++++++++++++++
 tools/testing/selftests/mm/run_vmtests.sh |   2 +
 4 files changed, 458 insertions(+)
 create mode 100644 tools/testing/selftests/mm/merge.c

diff --git a/tools/testing/selftests/mm/.gitignore b/tools/testing/selftests/mm/.gitignore
index c5241b193db8..91db34941a14 100644
--- a/tools/testing/selftests/mm/.gitignore
+++ b/tools/testing/selftests/mm/.gitignore
@@ -58,3 +58,4 @@ hugetlb_dio
 pkey_sighandler_tests_32
 pkey_sighandler_tests_64
 guard-regions
+merge
diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index 8270895039d1..ad4d6043a60f 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -98,6 +98,7 @@ TEST_GEN_FILES += hugetlb_madv_vs_map
 TEST_GEN_FILES += hugetlb_dio
 TEST_GEN_FILES += droppable
 TEST_GEN_FILES += guard-regions
+TEST_GEN_FILES += merge
 
 ifneq ($(ARCH),arm64)
 TEST_GEN_FILES += soft-dirty
diff --git a/tools/testing/selftests/mm/merge.c b/tools/testing/selftests/mm/merge.c
new file mode 100644
index 000000000000..9cc61bdbfba8
--- /dev/null
+++ b/tools/testing/selftests/mm/merge.c
@@ -0,0 +1,454 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#define _GNU_SOURCE
+#include "../kselftest_harness.h"
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <sys/mman.h>
+#include <sys/wait.h>
+#include "vm_util.h"
+
+FIXTURE(merge)
+{
+	unsigned int page_size;
+	char *carveout;
+	struct procmap_fd procmap;
+};
+
+FIXTURE_SETUP(merge)
+{
+	self->page_size = psize();
+	/* Carve out PROT_NONE region to map over. */
+	self->carveout = mmap(NULL, 12 * self->page_size, PROT_NONE,
+			      MAP_ANON | MAP_PRIVATE, -1, 0);
+	ASSERT_NE(self->carveout, MAP_FAILED);
+	/* Setup PROCMAP_QUERY interface. */
+	ASSERT_EQ(open_self_procmap(&self->procmap), 0);
+}
+
+FIXTURE_TEARDOWN(merge)
+{
+	ASSERT_EQ(munmap(self->carveout, 12 * self->page_size), 0);
+	ASSERT_EQ(close_procmap(&self->procmap), 0);
+}
+
+TEST_F(merge, mprotect_unfaulted_left)
+{
+	unsigned int page_size = self->page_size;
+	char *carveout = self->carveout;
+	struct procmap_fd *procmap = &self->procmap;
+	char *ptr;
+
+	/*
+	 * Map 10 pages of R/W memory within. MAP_NORESERVE so we don't hit
+	 * merge failure due to lack of VM_ACCOUNT flag by mistake.
+	 *
+	 * |-----------------------|
+	 * |       unfaulted       |
+	 * |-----------------------|
+	 */
+	ptr = mmap(&carveout[page_size], 10 * page_size, PROT_READ | PROT_WRITE,
+		   MAP_ANON | MAP_PRIVATE | MAP_FIXED | MAP_NORESERVE, -1, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+	/*
+	 * Now make the first 5 pages read-only, splitting the VMA:
+	 *
+	 *      RO          RW
+	 * |-----------|-----------|
+	 * | unfaulted | unfaulted |
+	 * |-----------|-----------|
+	 */
+	ASSERT_EQ(mprotect(ptr, 5 * page_size, PROT_READ), 0);
+	/*
+	 * Fault in the first of the last 5 pages so it gets an anon_vma and
+	 * thus the whole VMA becomes 'faulted':
+	 *
+	 *      RO          RW
+	 * |-----------|-----------|
+	 * | unfaulted |  faulted  |
+	 * |-----------|-----------|
+	 */
+	ptr[5 * page_size] = 'x';
+	/*
+	 * Now mprotect() the RW region read-only, we should merge (though for
+	 * ~15 years we did not! :):
+	 *
+	 *             RO
+	 * |-----------------------|
+	 * |        faulted        |
+	 * |-----------------------|
+	 */
+	ASSERT_EQ(mprotect(&ptr[5 * page_size], 5 * page_size, PROT_READ), 0);
+
+	/* Assert that the merge succeeded using PROCMAP_QUERY. */
+	ASSERT_TRUE(find_vma_procmap(procmap, ptr));
+	ASSERT_EQ(procmap->query.vma_start, (unsigned long)ptr);
+	ASSERT_EQ(procmap->query.vma_end, (unsigned long)ptr + 10 * page_size);
+}
+
+TEST_F(merge, mprotect_unfaulted_right)
+{
+	unsigned int page_size = self->page_size;
+	char *carveout = self->carveout;
+	struct procmap_fd *procmap = &self->procmap;
+	char *ptr;
+
+	/*
+	 * |-----------------------|
+	 * |       unfaulted       |
+	 * |-----------------------|
+	 */
+	ptr = mmap(&carveout[page_size], 10 * page_size, PROT_READ | PROT_WRITE,
+		   MAP_ANON | MAP_PRIVATE | MAP_FIXED | MAP_NORESERVE, -1, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+	/*
+	 * Now make the last 5 pages read-only, splitting the VMA:
+	 *
+	 *      RW          RO
+	 * |-----------|-----------|
+	 * | unfaulted | unfaulted |
+	 * |-----------|-----------|
+	 */
+	ASSERT_EQ(mprotect(&ptr[5 * page_size], 5 * page_size, PROT_READ), 0);
+	/*
+	 * Fault in the first of the first 5 pages so it gets an anon_vma and
+	 * thus the whole VMA becomes 'faulted':
+	 *
+	 *      RW          RO
+	 * |-----------|-----------|
+	 * |  faulted  | unfaulted |
+	 * |-----------|-----------|
+	 */
+	ptr[0] = 'x';
+	/*
+	 * Now mprotect() the RW region read-only, we should merge:
+	 *
+	 *             RO
+	 * |-----------------------|
+	 * |        faulted        |
+	 * |-----------------------|
+	 */
+	ASSERT_EQ(mprotect(ptr, 5 * page_size, PROT_READ), 0);
+
+	/* Assert that the merge succeeded using PROCMAP_QUERY. */
+	ASSERT_TRUE(find_vma_procmap(procmap, ptr));
+	ASSERT_EQ(procmap->query.vma_start, (unsigned long)ptr);
+	ASSERT_EQ(procmap->query.vma_end, (unsigned long)ptr + 10 * page_size);
+}
+
+TEST_F(merge, mprotect_unfaulted_both)
+{
+	unsigned int page_size = self->page_size;
+	char *carveout = self->carveout;
+	struct procmap_fd *procmap = &self->procmap;
+	char *ptr;
+
+	/*
+	 * |-----------------------|
+	 * |       unfaulted       |
+	 * |-----------------------|
+	 */
+	ptr = mmap(&carveout[2 * page_size], 9 * page_size, PROT_READ | PROT_WRITE,
+		   MAP_ANON | MAP_PRIVATE | MAP_FIXED | MAP_NORESERVE, -1, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+	/*
+	 * Now make the first and last 3 pages read-only, splitting the VMA:
+	 *
+	 *      RO          RW          RO
+	 * |-----------|-----------|-----------|
+	 * | unfaulted | unfaulted | unfaulted |
+	 * |-----------|-----------|-----------|
+	 */
+	ASSERT_EQ(mprotect(ptr, 3 * page_size, PROT_READ), 0);
+	ASSERT_EQ(mprotect(&ptr[6 * page_size], 3 * page_size, PROT_READ), 0);
+	/*
+	 * Fault in the first of the middle 3 pages so it gets an anon_vma and
+	 * thus the whole VMA becomes 'faulted':
+	 *
+	 *      RO          RW          RO
+	 * |-----------|-----------|-----------|
+	 * | unfaulted |  faulted  | unfaulted |
+	 * |-----------|-----------|-----------|
+	 */
+	ptr[3 * page_size] = 'x';
+	/*
+	 * Now mprotect() the RW region read-only, we should merge:
+	 *
+	 *             RO
+	 * |-----------------------|
+	 * |        faulted        |
+	 * |-----------------------|
+	 */
+	ASSERT_EQ(mprotect(&ptr[3 * page_size], 3 * page_size, PROT_READ), 0);
+
+	/* Assert that the merge succeeded using PROCMAP_QUERY. */
+	ASSERT_TRUE(find_vma_procmap(procmap, ptr));
+	ASSERT_EQ(procmap->query.vma_start, (unsigned long)ptr);
+	ASSERT_EQ(procmap->query.vma_end, (unsigned long)ptr + 9 * page_size);
+}
+
+TEST_F(merge, mprotect_faulted_left_unfaulted_right)
+{
+	unsigned int page_size = self->page_size;
+	char *carveout = self->carveout;
+	struct procmap_fd *procmap = &self->procmap;
+	char *ptr;
+
+	/*
+	 * |-----------------------|
+	 * |       unfaulted       |
+	 * |-----------------------|
+	 */
+	ptr = mmap(&carveout[2 * page_size], 9 * page_size, PROT_READ | PROT_WRITE,
+		   MAP_ANON | MAP_PRIVATE | MAP_FIXED | MAP_NORESERVE, -1, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+	/*
+	 * Now make the last 3 pages read-only, splitting the VMA:
+	 *
+	 *             RW               RO
+	 * |-----------------------|-----------|
+	 * |       unfaulted       | unfaulted |
+	 * |-----------------------|-----------|
+	 */
+	ASSERT_EQ(mprotect(&ptr[6 * page_size], 3 * page_size, PROT_READ), 0);
+	/*
+	 * Fault in the first of the first 6 pages so it gets an anon_vma and
+	 * thus the whole VMA becomes 'faulted':
+	 *
+	 *             RW               RO
+	 * |-----------------------|-----------|
+	 * |       unfaulted       | unfaulted |
+	 * |-----------------------|-----------|
+	 */
+	ptr[0] = 'x';
+	/*
+	 * Now make the first 3 pages read-only, splitting the VMA:
+	 *
+	 *      RO          RW          RO
+	 * |-----------|-----------|-----------|
+	 * |  faulted  |  faulted  | unfaulted |
+	 * |-----------|-----------|-----------|
+	 */
+	ASSERT_EQ(mprotect(ptr, 3 * page_size, PROT_READ), 0);
+	/*
+	 * Now mprotect() the RW region read-only, we should merge:
+	 *
+	 *             RO
+	 * |-----------------------|
+	 * |        faulted        |
+	 * |-----------------------|
+	 */
+	ASSERT_EQ(mprotect(&ptr[3 * page_size], 3 * page_size, PROT_READ), 0);
+
+	/* Assert that the merge succeeded using PROCMAP_QUERY. */
+	ASSERT_TRUE(find_vma_procmap(procmap, ptr));
+	ASSERT_EQ(procmap->query.vma_start, (unsigned long)ptr);
+	ASSERT_EQ(procmap->query.vma_end, (unsigned long)ptr + 9 * page_size);
+}
+
+TEST_F(merge, mprotect_unfaulted_left_faulted_right)
+{
+	unsigned int page_size = self->page_size;
+	char *carveout = self->carveout;
+	struct procmap_fd *procmap = &self->procmap;
+	char *ptr;
+
+	/*
+	 * |-----------------------|
+	 * |       unfaulted       |
+	 * |-----------------------|
+	 */
+	ptr = mmap(&carveout[2 * page_size], 9 * page_size, PROT_READ | PROT_WRITE,
+		   MAP_ANON | MAP_PRIVATE | MAP_FIXED | MAP_NORESERVE, -1, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+	/*
+	 * Now make the first 3 pages read-only, splitting the VMA:
+	 *
+	 *      RO                RW
+	 * |-----------|-----------------------|
+	 * | unfaulted |       unfaulted       |
+	 * |-----------|-----------------------|
+	 */
+	ASSERT_EQ(mprotect(ptr, 3 * page_size, PROT_READ), 0);
+	/*
+	 * FAult in the first of the last 6 pages so it gets an anon_vma and
+	 * thus the whole VMA becomes 'faulted':
+	 *
+	 *      RO                RW
+	 * |-----------|-----------------------|
+	 * | unfaulted |        faulted        |
+	 * |-----------|-----------------------|
+	 */
+	ptr[3 * page_size] = 'x';
+	/*
+	 * Now make the last 3 pages read-only, splitting the VMA:
+	 *
+	 *      RO          RW          RO
+	 * |-----------|-----------|-----------|
+	 * | unfaulted |  faulted  |  faulted  |
+	 * |-----------|-----------|-----------|
+	 */
+	ASSERT_EQ(mprotect(&ptr[6 * page_size], 3 * page_size, PROT_READ), 0);
+	/*
+	 * Now mprotect() the RW region read-only, we should merge:
+	 *
+	 *             RO
+	 * |-----------------------|
+	 * |        faulted        |
+	 * |-----------------------|
+	 */
+	ASSERT_EQ(mprotect(&ptr[3 * page_size], 3 * page_size, PROT_READ), 0);
+
+	/* Assert that the merge succeeded using PROCMAP_QUERY. */
+	ASSERT_TRUE(find_vma_procmap(procmap, ptr));
+	ASSERT_EQ(procmap->query.vma_start, (unsigned long)ptr);
+	ASSERT_EQ(procmap->query.vma_end, (unsigned long)ptr + 9 * page_size);
+}
+
+TEST_F(merge, forked_target_vma)
+{
+	unsigned int page_size = self->page_size;
+	char *carveout = self->carveout;
+	struct procmap_fd *procmap = &self->procmap;
+	pid_t pid;
+	char *ptr, *ptr2;
+	int i;
+
+	/*
+	 * |-----------|
+	 * | unfaulted |
+	 * |-----------|
+	 */
+	ptr = mmap(&carveout[page_size], 5 * page_size, PROT_READ | PROT_WRITE,
+		   MAP_ANON | MAP_PRIVATE | MAP_FIXED, -1, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+
+	/*
+	 * Fault in process.
+	 *
+	 * |-----------|
+	 * |  faulted  |
+	 * |-----------|
+	 */
+	ptr[0] = 'x';
+
+	pid = fork();
+	ASSERT_NE(pid, -1);
+
+	if (pid != 0) {
+		wait(NULL);
+		return;
+	}
+
+	/* Child process below: */
+
+	/* Reopen for child. */
+	ASSERT_EQ(close_procmap(&self->procmap), 0);
+	ASSERT_EQ(open_self_procmap(&self->procmap), 0);
+
+	/* unCOWing everything does not cause the AVC to go away. */
+	for (i = 0; i < 5 * page_size; i += page_size)
+		ptr[i] = 'x';
+
+	/*
+	 * Map in adjacent VMA in child.
+	 *
+	 *     forked
+	 * |-----------|-----------|
+	 * |  faulted  | unfaulted |
+	 * |-----------|-----------|
+	 *      ptr         ptr2
+	 */
+	ptr2 = mmap(&ptr[5 * page_size], 5 * page_size, PROT_READ | PROT_WRITE,
+		   MAP_ANON | MAP_PRIVATE | MAP_FIXED, -1, 0);
+	ASSERT_NE(ptr2, MAP_FAILED);
+
+	/* Make sure not merged. */
+	ASSERT_TRUE(find_vma_procmap(procmap, ptr));
+	ASSERT_EQ(procmap->query.vma_start, (unsigned long)ptr);
+	ASSERT_EQ(procmap->query.vma_end, (unsigned long)ptr + 5 * page_size);
+}
+
+TEST_F(merge, forked_source_vma)
+{
+	unsigned int page_size = self->page_size;
+	char *carveout = self->carveout;
+	struct procmap_fd *procmap = &self->procmap;
+	pid_t pid;
+	char *ptr, *ptr2;
+	int i;
+
+	/*
+	 * |............|-----------|
+	 * | <unmapped> | unfaulted |
+	 * |............|-----------|
+	 */
+	ptr = mmap(&carveout[page_size], 5 * page_size, PROT_READ | PROT_WRITE,
+		   MAP_ANON | MAP_PRIVATE | MAP_FIXED | MAP_NORESERVE, -1, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+
+	/*
+	 * Fault in process.
+	 *
+	 * |............||-----------|
+	 * | <unmapped> ||  faulted  |
+	 * |............||-----------|
+	 */
+	ptr[0] = 'x';
+
+	pid = fork();
+	ASSERT_NE(pid, -1);
+
+	if (pid != 0) {
+		wait(NULL);
+		return;
+	}
+
+	/* Child process below: */
+
+	/* Reopen for child. */
+	ASSERT_EQ(close_procmap(&self->procmap), 0);
+	ASSERT_EQ(open_self_procmap(&self->procmap), 0);
+
+	/* unCOWing everything does not cause the AVC to go away. */
+	for (i = 0; i < 5 * page_size; i += page_size)
+		ptr[i] = 'x';
+
+	/*
+	 * Map in adjacent VMA in child, ptr2 before ptr, but incompatible.
+	 *
+	 *      RWX      forked RW
+	 * |-----------|-----------|
+	 * | unfaulted |  faulted  |
+	 * |-----------|-----------|
+	 *      ptr2        ptr
+	 */
+	ptr2 = mmap(&carveout[6 * page_size], 5 * page_size, PROT_READ | PROT_WRITE | PROT_EXEC,
+		   MAP_ANON | MAP_PRIVATE | MAP_FIXED | MAP_NORESERVE, -1, 0);
+	ASSERT_NE(ptr2, MAP_FAILED);
+
+
+	/* Make sure not merged. */
+	ASSERT_TRUE(find_vma_procmap(procmap, ptr2));
+	ASSERT_EQ(procmap->query.vma_start, (unsigned long)ptr2);
+	ASSERT_EQ(procmap->query.vma_end, (unsigned long)ptr2 + 5 * page_size);
+
+	/*
+	 * Now mprotect forked region to RWX so it becomes the source for the
+	 * merge to unfaulted region:
+	 *
+	 *      RWX      forked RWX
+	 * |-----------|-----------|
+	 * | unfaulted |  faulted  |
+	 * |-----------|-----------|
+	 *      ptr2        ptr
+	 */
+	ASSERT_EQ(mprotect(ptr, 5 * page_size, PROT_READ | PROT_WRITE | PROT_EXEC), 0);
+	/* Again, make sure not merged. */
+	ASSERT_TRUE(find_vma_procmap(procmap, ptr2));
+	ASSERT_EQ(procmap->query.vma_start, (unsigned long)ptr2);
+	ASSERT_EQ(procmap->query.vma_end, (unsigned long)ptr2 + 5 * page_size);
+}
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
index 9aff33b10999..0b2f8bb91433 100755
--- a/tools/testing/selftests/mm/run_vmtests.sh
+++ b/tools/testing/selftests/mm/run_vmtests.sh
@@ -421,6 +421,8 @@ CATEGORY="madv_guard" run_test ./guard-regions
 # MADV_POPULATE_READ and MADV_POPULATE_WRITE tests
 CATEGORY="madv_populate" run_test ./madv_populate
 
+CATEGORY="vma_merge" run_test ./merge
+
 if [ -x ./memfd_secret ]
 then
 (echo 0 > /proc/sys/kernel/yama/ptrace_scope 2>&1) | tap_prefix
-- 
2.48.1


