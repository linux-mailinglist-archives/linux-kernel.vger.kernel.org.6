Return-Path: <linux-kernel+bounces-378544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 133039AD215
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 19:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C18482893B7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 17:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B8E1CF7A8;
	Wed, 23 Oct 2024 17:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bNy41TlK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vZGblkqV"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7ED1ADFF7
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 17:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729702847; cv=fail; b=Xu4DZKfMNUhBE/SS9OTbK/7Maovn1y+yCTqXRl5t5nypIOMgxKuhYXhK4nEORg9T3jV7OpeBo8ilUIoludWaiMhT8XKJ1aTOsV9WI7bGWjrojLlyGuLt2JGeWoFL2xZz8qOklf0+4Hmwtq6WwfKWKj+dTCFV1tWS42X+ny8Sa/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729702847; c=relaxed/simple;
	bh=+EQRGWBafa1ff0Lxqf0l3n8JnrxiWvQ9BQa76YqSbkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TFZ7tim1IAPmwcxAg1QECoLp+pNM0H54EOwudTjc5/H44Od4Nf/DbMnxy3D1/6L9gU2NvKk2pQgSE7NASgyWAAW/Cb+RL49dT9uGrhmqNBEKdhLGc3EAWBSuJpvzML/14YkJGJq6MGJ/+4rdXcx2yKcZNtN9d1pl8bkLwMEiSE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bNy41TlK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vZGblkqV; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49NFfeHt012097;
	Wed, 23 Oct 2024 17:00:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Za3hmi7Pqwiat/em6fmljqm4WogOT+Vo/qoNazPmc2A=; b=
	bNy41TlKxucJiXC4NsQ6hu3hMGKB7xQw0+19qbpalRlY2AYFqJlTQRXCI9r/VU6l
	nMCis/WBjfGxtLyEsRM8oHKuptCNvd8bhD6F6L4coRgng72ZXEid14J/P00BA5eK
	SjrnJtnIEQvTW4qmpTVuiZjrx4CwHwg8V5nsyqvR72Fg1pDrreW8CaAo72GzxBAv
	WfXMihGIN5rWCbCVnGoIbcEGyEDrnNy7afu10aHYXvPw93P5fW+4TErhQRgxSsBW
	5YDRh69ZXluzI+EawItFQqDfg4g2kxWziVqU+IzPtuxaxRZfnmZreR+jXvuAw+Vo
	8XeInLDHfRGBEtVo7zSkGw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c53urme2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 17:00:30 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49NFvSFB035996;
	Wed, 23 Oct 2024 17:00:30 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42emh2spfg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 17:00:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cF/tQmt0TmqTGph68Dl16DW6WIFniAW3isAPanDxXMQhofpKVOP8V+U72nHzYKMdJQbGxn7yEKqhq/pNNjjmN/Xm+EP5uZuWNblvW9QnwFVeUACrdvPENtEtWNi98u91wvx2c1O7+P5fLdUWawUZLcGF+eQJjK/95Vt+tV+yROwKmj8YsMCo/GoH7FdIxwauEKIrUYhqNjiNHdkjrjqF0JS2UJE3yQcEYNFGAVbMecIN+Ekq818OjZYI8oRWcSHJoFZJFmAD2VHklbAtEGyBuf4mbH0ViuxM5fvTWfJTrGUcoantShYV00zE9Y+t5zm4D91D00KCmwEbrNexDJQyTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Za3hmi7Pqwiat/em6fmljqm4WogOT+Vo/qoNazPmc2A=;
 b=vhIPe6HgsmZH9vRQwCgaSiJbeg80QnJXArlOGbwD8hr+rAJmNfv+THnaBzfLG8KvzxgAVro4P8GCB2p7K+SnBPhr9KEDbXX/ybfYd6YVVN7YhIB18M+8S99AMidmJSDU41IA6ESVr07NhlTNDZlgSNwoWxUdpDryj73GHKJFfJl6ScEQDfQor3pm1I49wTD29EH23ZwxYZGlGXSWhWK7IUeDxfrlozZdxv9PWWAlDEIETzmPNuDKYHzLesCJDgPmDXUC1gYPy1HLudPBRbmB/9RZvZtYyYq3/wucMRYIQH/J4/dZ2L/3WNf6tuFfsvohdwyTIFeNjdVqKw5eZdAX5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Za3hmi7Pqwiat/em6fmljqm4WogOT+Vo/qoNazPmc2A=;
 b=vZGblkqV52dy7tJKjoyKBOP4sZjK4wOLQvFjTZzIgEnijVk70YhZWN9BhIvr5qvp9o8vujhpTBSCHYTz8xvnFPtqhSRP/6hvcqEhy2uE7MbF1PriVTHxmem2G5lxwu8HY/7BAp/+7Erb7q/QuN5LAj2xuSMib/jeiYHeOhZY0h4=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by DS0PR10MB6727.namprd10.prod.outlook.com (2603:10b6:8:13a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Wed, 23 Oct
 2024 17:00:18 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8069.024; Wed, 23 Oct 2024
 17:00:18 +0000
Date: Wed, 23 Oct 2024 18:00:14 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jann Horn <jannh@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH hotfix 6.12 2/8] mm: unconditionally close VMAs on error
Message-ID: <c2ca1ebe-a9df-4087-8a4d-8ed48d099848@lucifer.local>
References: <cover.1729628198.git.lorenzo.stoakes@oracle.com>
 <9a84bad9fdebbdb0adca2b5b43ed63afceb5bacc.1729628198.git.lorenzo.stoakes@oracle.com>
 <CAG48ez3-ZcWzf5at25PTxcB0FVUCQR5OqjPpFKKgW=r3NTQmgg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez3-ZcWzf5at25PTxcB0FVUCQR5OqjPpFKKgW=r3NTQmgg@mail.gmail.com>
X-ClientProxiedBy: LO3P123CA0013.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:ba::18) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|DS0PR10MB6727:EE_
X-MS-Office365-Filtering-Correlation-Id: 9db9e2d1-c93f-40f2-b40a-08dcf3842bcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eWdYN1J0UmJ5VHpTMktMa0l6SDNQSXdxUldRRUh4Q1N2MkRjSEVJbEMxdHZY?=
 =?utf-8?B?NHdEMm5oKytVakQrenJ0TlNYaWhFZTNvV2lWSmVoY1BsQ01iNi9RUTl5ZjVj?=
 =?utf-8?B?a0EvU0Q0c3YyWXZjY0R4M3duZGNnSloydkJkcFZ2YktBVndVNHY0K2lwWDlm?=
 =?utf-8?B?OXV5QWc4NWJPU1NVdVJva3JoRnlncElFR1Z1N3NQLzY4NktKbnVQc1FGa0E5?=
 =?utf-8?B?ZitnZWduclRjUUo3MWJVMi9LT3p1M0Q2SDlyN082d0ZuSHc3Y1p3SzRmZVQ0?=
 =?utf-8?B?S1M0WWdxZUk5emI3S044MHVpRnNNWW0xVUNZK2dOMmsyNnBidkwrSjdMcFV4?=
 =?utf-8?B?YTg4WWtNRVMwbVRrSlowY01RVjNWK243MkxIc2dRbTZlbFZNZ3lNZi91bTFY?=
 =?utf-8?B?TjRjZ21oWlJialRaRStWMG9XcUtOV1pJQzFOUHMrUHQ2VUh1MEEvOGVYbkQ5?=
 =?utf-8?B?N1pIdW1BTHFsZmtFRXVoSlpFRUZESlNON0hyamo0cXovQThScVFJYStjWUpZ?=
 =?utf-8?B?ZGFWYlZnSXE3emFTQldrZEpRUEloYXY1cUtPbXc4c2o4RnJYVmRrWjB4WlMr?=
 =?utf-8?B?TG1CTDBnYmxPa3REYXc0dXpuMXk1dGpkb21LdFJyS0cwWm0raGppYVphZDFF?=
 =?utf-8?B?NEdQV3ZVM3ExYk1HUStMTXpIWG1XbTlVRE83Y1BieGc1TjJReXRBUElhR2l0?=
 =?utf-8?B?WEdXMVc3cDNLYkx6YkVibFdnMkxIRmVtZi9hSithOEtyZDN1OCsvNHNHNWpT?=
 =?utf-8?B?MjRZalF3OXJCQzBIN3ErRCtNV3ZmU2pVeEZjQkM1d2paTllXTHB3RWgrSFhv?=
 =?utf-8?B?RENRbTZQN3pQYjVORVBQM1VsVC8rRGpVemFWdWo5U1pyd2dLVmUvMDU2TFJz?=
 =?utf-8?B?T3JGOGhtSkZNdXRyRFN2ZDJGRTNlYWx6bG1ScnhxT3lVazBCN1dubmk1cUg0?=
 =?utf-8?B?U1hFYm5hYVFuY0Q3amZwY0Izbm5yRnF5QlU4WktITGN2S3pSYkJrTHRwQnlR?=
 =?utf-8?B?d29MY2E5NzdGRFNSbTVpWVNma2FjR0JqWFFvWFkvM3FmYWtuUmVNWENuM3Jm?=
 =?utf-8?B?eGNkT1U5MTBldW9YaTFTWGVJVW5UNWFlbThMbU1FeUhJUkdONzkrL2kvaFN4?=
 =?utf-8?B?MTJYUy9xM1pwMklWRnJteUJkeFNhTGRqMHNkcGNtWlFSREZJZjFVUE4rcWMy?=
 =?utf-8?B?ZWo2RDFlMTM1cjdjbEFWREg0L3RZWCs0UUdHY3ZZYUJJTU5PNlZPMDNIVlR6?=
 =?utf-8?B?SWs0RHIzSEREUXd5N09mWkRQcnJwUDkyclFVQ0ZFUmN5MElPWm9KT0FJM056?=
 =?utf-8?B?MmxiZUtkai9Xa1hUd08valMxODNrcDkydU5UQTRBY2h2S1ZmME1VT0ZzMmND?=
 =?utf-8?B?V0xnRW5rWWpCZ3p3Znpsei9GMEZtNW9iNUtTVGhQaElZb3FhTjhrTEg0N0Ns?=
 =?utf-8?B?N0lyakZlckZhVzlBRjdGVWltdzNJRm44ZXN0WGpETUhLRUJXMjR6bzA2Zk51?=
 =?utf-8?B?VjJMT0crRmphSW1XUDh5dTcrV0ZDcTc4REc5b3ZLNzJ2OEVBNDVzUGxzbU01?=
 =?utf-8?B?aXlpRGVieEhOemZ6ZUhZNVZ1WUhVZTNibm9DSW9vRXVUNm5ra05pN09BRVBD?=
 =?utf-8?B?Q0U2OHA3Wm5Gbjd5OWFEblRPcHNkVVl3TDk3a3IvYTY5TUE5bHRyajdQTUZS?=
 =?utf-8?B?US9pMHdjaDQwVTdOV3BFSzU2eWNQOW9jOUd0TTFnbzhYTVNSSFcvR0tZRFZl?=
 =?utf-8?Q?tvXAIxGLtQrkG2kmBZU05t2jZuM/j9eZ9ddVBru?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?alZPRTBoRHZ1emE1em5IS285TFU2T3NYei9vR0xBT0svdUl6WHgvTHJkV01q?=
 =?utf-8?B?cTFKRXpYYVBpbm1xMThmSkRVWmk1R1NadkxEem5ySmk0WUtRZmxjZDQyam9z?=
 =?utf-8?B?Wkc1Z2JVdnBGb05iS0h2eGNtNmFuZ2hBN2hFM3Y3NVlYVG5PYWs0YWlpMktZ?=
 =?utf-8?B?QzdjWlg4Qk01NHE1SUgzckV5bDdCWnkwMkxabTI3eko4ek9vQlR1eWxuOWxn?=
 =?utf-8?B?Q0xlVm8rSk85emtWRGxOUnh2SU1rSnh4eUJWbFQ0NzQ0L0UvSmF2aVFDOVVK?=
 =?utf-8?B?d1VsRzQxamdDVkR1bEtaS0k0YzArSDFnMDdVMnhsMDZBSnQ5YUVBb3plbkVZ?=
 =?utf-8?B?aElWSzNzb0xRL0tOZTJCQlpValk5WTRHV1psOVBvMDZvS0o1YUFQcmZUdE5t?=
 =?utf-8?B?WCsxcm1sSFNkc2Y4TktrSHJHRXlNSVFLVXNrblBrUzcxSXM1VHpMSCtMTkpQ?=
 =?utf-8?B?QllaMXhPV2h5R3Z4RXlENURIS0NzRjJ6SjlRMitQNENvUmZzek0rTVRkNnpt?=
 =?utf-8?B?MGRQMU9wSVZ0dGRRR0J0WXFiVjlFWllGTEZXU1FyemdRbkhYQUNQdnl2anFa?=
 =?utf-8?B?aUk0bmZ2bDZvd2xhcmNQNm1ZK3ovV3JRQUNNWW54djdjVlhxdnl0SEVraGhn?=
 =?utf-8?B?bkZkWXN5ZFdtb0ZaaGhCL3lrQkpib3N0MFdsV3JpQzdmMFJwNnI2MHZGQTlE?=
 =?utf-8?B?NzVkYXBwam8zV2xocjROM0dvTXNxcWJxN3UyZTRuVFNmM25FL3Ftb0FxdlhT?=
 =?utf-8?B?Q0ZnTUZrMEkwQ1VOTlE5bFMzNFphTmhnS09FMGd3Qy90c3IvblJjaTNOdXZu?=
 =?utf-8?B?SXEwQjlJUW5WYkI0bWpDZUp1ZFc1ODFvUHlOdDY3SE9KMXQwb3YxeFV3WnZw?=
 =?utf-8?B?MUNSaUlCd2hMVHBqak4rbjFmUHB3Tmt1eldqR3FwanZWL0dsbVBJQnVNNVZy?=
 =?utf-8?B?YmZUaFd6QjZDTmdPL2F0YzJ5aXl4M1BYWFVaakJNLzlXWmNqZENqQ0ZZM21r?=
 =?utf-8?B?YVlHSHdtZ3d1aXdGRVMxOVJ6clkwSktCSWE0WDg0cHFsK3o5elBmOVJEc0Iy?=
 =?utf-8?B?V0NZZDRpNnZ5akNTVk9oaDlCQUY3ekR1Y1JENk9GU3YxYkt3Tko3dGlqV2Uw?=
 =?utf-8?B?YVNOMjk4dS9WdE53aXdpR3o5cFhLSWJaVjRmdUJwOFNkMHVJVXphNE1YcVNn?=
 =?utf-8?B?Rm9GNVVzbWdQckJ0czJLOXBTTVZtZE03ZFhOYVZhenR4c1o3LzN6WGFSUllL?=
 =?utf-8?B?bXd5L0VPTWdJR25MZzQzUjNibXkyeFZaNHFEYVdId29rc2YyM3RpRHJ2eGhs?=
 =?utf-8?B?UXBHQlBlZU0zbVU0M0E4dnIxQVNoMFhQdm5KRVhySkpuTTUwb2FJdVhrOGpW?=
 =?utf-8?B?bXFJZ3R5YVdIMzRJT3FoTW14SnJPQ3Zhc2xEbjNIQUlWd1RBak9RZUkvTnRx?=
 =?utf-8?B?L0lGa2xJZ3I3ZG94dU9Da0FmSlVqZTBLTnI4ZVpoVWlSVVFGMXhnNCtPcHpR?=
 =?utf-8?B?dGtTczVqK3BkT1J3RTZIbzQ5K0NYQ2NTM1I2Rkx1SUNBS095SnlOQi9Gdmhn?=
 =?utf-8?B?TVJWalFaNy9LanRlb2hzanpRNlFpU2k1U040NFBubUJ6UUxnTXJWSmxxYUpX?=
 =?utf-8?B?TlZqL09VaGszTHlyRTJ0SWlldjFCNjhpaDV4bWFFUUw3S3VlSTkzdTEvSG4v?=
 =?utf-8?B?NU9sdUNTZEhYU3oxSVhBcDNsM0pNbXhHc3h2V0R2OWtHRkFiOHFPbHhtaW1s?=
 =?utf-8?B?NW9pd0xNZnhpeDkwbVVRRXhnalFOYUlWYlQ4YUZydEkzbWxVNENNeWRydUgz?=
 =?utf-8?B?aFp5a3AyWlJpWWpCd0pTdEdsU1lPRk5Ya2FibDJHWlNmQVltSjZodU9jZlBv?=
 =?utf-8?B?Tldaam5EV2wzVWdSTXEvckpSUGNWKy9wNDFrWUt3Y0ZvdUsvTEhacnBHd3Rs?=
 =?utf-8?B?UU5YOFVCTmsrcDZCYW92YWpnVGQ2OHZKS3c2bng3emc0RU52T2FWS2Q4b1pW?=
 =?utf-8?B?SFExQVNvNEFIZGRoaFVTaC9EVk5WUTViSHRhTmxIb0ZoeWZjWGFubWV2WGsy?=
 =?utf-8?B?Q0U5OVZObWwvVTFiRHh2U3JhZkFKMFczVkY0WVF2QjA5L0FmMFE5blZIOVhY?=
 =?utf-8?B?dWFRcUQ5VkpCS3pRTWtsTXZCakpJdGZBaGFDYjF2enJBK3FTNG13NjM2Yndx?=
 =?utf-8?B?UDNvVmJDS3pneWg5Q1E2RTJ0aFF3RndpMldnYzBzU3ZYSTg2b2p1TEFwSXYz?=
 =?utf-8?B?QlI5Z2w0Y0hFVkZqenRhc1BuVVZ3PT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lTi+tOjuigwv3vfzTgfKZPEqutgjUIzfAhEeYgNLs/OrpIuQorKCV8Nm0gY4gSi1OBewHlds6TSPIDT00mRwU4ks/738tcbOjyFJV2FvJyviwQgKoxqDXwc6vck8QxacQshkn2UUoZQ0eM+OGQTebB0pz9dVMN6mklFbkuW7Eg4WL5Ip4BArdOLr1dKEQ9AO6rPQYAAitPHGyPyE2IJadcXj5YG3bZ/ajCWiAuaGr1swsxxoNt/EwBW7572nNF/7kIztjg+6PbNXkmY7JQ9EnLDgkpnRiRXRIlOERdOYdBnOnJm68Is0DsCGIkIYPSuxSHUpy3Jp8jTCG0SCnGfspzlc4uQWBoKveIp+xrFc5z3u5nD0qlC8djYKFaizmzvKDxfbE1cybZ5sio0FLPIE7K5qOdrtek+qVr9IECRQaioJyTtH0zvtkv2/x5lrJju9Vr4C4nwDFGOzXj4TLdKreqT1q0i9jLqlTWFUoLWd6I1nX4CIsiIJWcJ4fCP39cLIHzve8miPQMffozwNq/HIiBaO5T/S7GkTpL1+riUKxfEv5IKUzED+J0Vw3WKvRbrcGbfz/a38b9odibV5YWzn0DegkFGVjCed9AKAuBT0N0A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9db9e2d1-c93f-40f2-b40a-08dcf3842bcb
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 17:00:18.1463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H493xfHgDQ3V0pDReWPF7QfCEDKYnTC4KKFTTnK59JGE74OPsVdhlv5LRSG5khZnaGo4mCWsoJb6kDCpCBNnoIx6hNZg0vOuoSCjCQrk6fc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6727
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-23_15,2024-10-23_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410230106
X-Proofpoint-GUID: PgbmqFNwx3x9HfNhAbj8qPWU-kv4DiXR
X-Proofpoint-ORIG-GUID: PgbmqFNwx3x9HfNhAbj8qPWU-kv4DiXR

On Tue, Oct 22, 2024 at 11:15:10PM +0200, Jann Horn wrote:
> On Tue, Oct 22, 2024 at 10:41 PM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> > Incorrect invocation of VMA callbacks when the VMA is no longer in a
> > consistent state is bug prone and risky to perform.
> >
> > With regards to the important vm_ops->close() callback We have gone to
> > great lengths to try to track whether or not we ought to close VMAs.
> >
> > Rather than doing so and risking making a mistake somewhere, instead
> > unconditionally close and reset vma->vm_ops to an empty dummy operations
> > set with a NULL .close operator.
> >
> > We introduce a new function to do so - vma_close() - and simplify existing
> > vms logic which tracked whether we needed to close or not.
> >
> > This simplifies the logic, avoids incorrect double-calling of the .close()
> > callback and allows us to update error paths to simply call vma_close()
> > unconditionally - making VMA closure idempotent.
> >
> > Reported-by: Jann Horn <jannh@google.com>
> > Fixes: deb0f6562884 ("mm/mmap: undo ->mmap() when arch_validate_flags() fails")
> > Cc: stable <stable@kernel.org>
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> Reviewed-by: Jann Horn <jannh@google.com>

Thanks!

>
> [...]
> > diff --git a/mm/vma.h b/mm/vma.h
> > index 55457cb68200..75558b5e9c8c 100644
> > --- a/mm/vma.h
> > +++ b/mm/vma.h
> > @@ -42,7 +42,6 @@ struct vma_munmap_struct {
> >         int vma_count;                  /* Number of vmas that will be removed */
> >         bool unlock;                    /* Unlock after the munmap */
> >         bool clear_ptes;                /* If there are outstanding PTE to be cleared */
> > -       bool closed_vm_ops;             /* call_mmap() was encountered, so vmas may be closed */
> >         /* 1 byte hole */
>
> nit: outdated comment, this hole is 2 bytes now

Ack, will update.

>
>
>
> >         unsigned long nr_pages;         /* Number of pages being removed */
> >         unsigned long locked_vm;        /* Number of locked pages */

