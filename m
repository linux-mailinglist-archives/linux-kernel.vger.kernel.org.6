Return-Path: <linux-kernel+bounces-378808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0189AD5A6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 22:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D6541F24F20
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 20:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0CCE1FE108;
	Wed, 23 Oct 2024 20:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="P7wUYVpc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aSeU5KxM"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A00D1FDFBD
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 20:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729715969; cv=fail; b=uFImR0Pd+W2tqyFrOin3o1GgRGGdL6l1j3G/opE8eLuqok/tW7GF1TX/9leXhA5FTWNznwd0G4LK4oDuG3BIL7P63K1ksSBT2EAV3ZeWxwIS2h64ypInZYEmsLFremss/QhoYcBIpxW8Mkf0ejfs1YPb3VvYsD7oW6GDcfzrbP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729715969; c=relaxed/simple;
	bh=5jKXsmd8IKys0YPguzxwU0FnHF0EyFftdn3PFcECWgc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K+tDSDDLnBIZ5OA03BMu4W/Gpr7DeaFm8UAdztPPT0UJiYZMGKClK0nRNJ+qM7JaziN2Grem8lP/1D8c8TTFepUEkhyiOqRKUQm6v+7Gx7wIuZWWttfC7y1Prg46owMTnf0Msw8jbPnJesvDCNi9Z/90K3oTYeshLPT55zTUyQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=P7wUYVpc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aSeU5KxM; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49NKcSvA025102;
	Wed, 23 Oct 2024 20:39:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=vHCZVUqc1OUCr81cPgBjdxfmyaJ7aPEXNpHoog10F9s=; b=
	P7wUYVpc+GNTuQiiEwHeiZn8qnZCiF9c5Rdl6vecgUhjY3TVMG6iaNfJSZ2F38VH
	BOUKXAB0to8774cVS8k9joaKAIfwpjj6SddEOfHggRe4+Ic8+Q4Ut3Z4/LgVNVuM
	Vh69eDdFE+tb1H+NNn+luE1i+hajunk6rIYWwCWxq/qLpIvP1y8bql5g3LGGOdGu
	018vIggzJeRBejDN2YsIqUkD3T3pLZ/D5FlwoAmwqlbX78ZJQKXRDw9G67dXfZNp
	1vD5UTdNYZXVOjsS56WvBmFghf1MikvDLw3mxBXFkwxCeVNm5JdF5lKKxggY8EhU
	WURzoezomfsyIMVWkCUotg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c57qh5dh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 20:39:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49NJKtmU025386;
	Wed, 23 Oct 2024 20:39:17 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2047.outbound.protection.outlook.com [104.47.58.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42emha1at9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 20:39:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s/7paXTJIYpvUJ5CQ15I+7Th0MbvZOBUmJsnqS7NwHsTZ5O04KlnQpiwg9Le/jLKSkf+1L2PzLkEWUlWumahE1PDVT9/m+lUiQO5o2jYEKh9zSAOsmcIAn8SYcVVyweD49FZFZ9Bn56o/kZhAlO6iO+Qaxr719j9TzsN1eIc3QNXMuL09qTyCAoNJ3/L8uW+RLRXd+1x4Tv4I3Ury41Me+tAZK50DXhJ//XTRmUFaMC11LCUM8bMHdeMmtD0UFfyiTyLUNx5Zc9Saudt9VTS5m1/wbC1wJ8UoQWIw6xkJHskmVTLL54bn3cT72WmtMnOV2AFnHiGX5pUmmjru8ZU2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vHCZVUqc1OUCr81cPgBjdxfmyaJ7aPEXNpHoog10F9s=;
 b=l9jukNyjFBl1AmFBMijPCTXSIuY5q6ik3ugsGeTKOjGwFlvWpHhsFNbqH+FhtS/W+7fGTUmIvus2Jg7Wa2hTpf/hghBII7dDxw1TanUWjGd0vYO0bLZY5qcNKeA8ig3S/TUbWFDmfulzxp4R7edFb8/Fdtj//H4IQr6SY4/tkP8MkdpZGPH28Fx3Mtd5O7G9Xz8siJrjgbhImb5sNU5A6rTpt5n2G/bGLvbXidnlAY+STUkSQ4k/OGFPW9b+Sk7/Rq3kcxpFxvkIFpJrdUDw2ESuvP8eMBUvYKPAcAgaH7p3Qxc7dZIuBESQEOG8dPtbBEPouu0VIfnS3WONMwcASg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vHCZVUqc1OUCr81cPgBjdxfmyaJ7aPEXNpHoog10F9s=;
 b=aSeU5KxM0qsk1TDAtN7elBVri98OSH1SbhHkLz9hq9U3baGvQ9SkQDBKqMMYDXpwMSUS7Mggm5rplnWPBuRQcVYDJexaJRPAkO8EZ/qHzZknycNwl1XrDL5AOTNUsl0vjLCuIxfL6lXweEVhUQiKrmAN14RZetcCYBslRmdUXIQ=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by SJ0PR10MB5833.namprd10.prod.outlook.com (2603:10b6:a03:3ed::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Wed, 23 Oct
 2024 20:39:14 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8069.024; Wed, 23 Oct 2024
 20:39:14 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>
Subject: [PATCH v2 7/8] mm: refactor __mmap_region()
Date: Wed, 23 Oct 2024 21:38:32 +0100
Message-ID: <0b1da31b49d47ccb930d36f509d50d04c0422b73.1729715266.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1729715266.git.lorenzo.stoakes@oracle.com>
References: <cover.1729715266.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0017.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:150::22) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|SJ0PR10MB5833:EE_
X-MS-Office365-Filtering-Correlation-Id: 32a31267-82d1-455a-9d55-08dcf3a2c1e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uARFujKRRbAN7Duma0lB6AwYvt3jkfbmkkAQthcqAyALiSE9ubD+ELRYoxwh?=
 =?us-ascii?Q?jKWerQyQtn6zcbYVTjFKac+AE50lRUrkF/URsb8jYyEc28xqj4/x1nUzRB5W?=
 =?us-ascii?Q?V1YpR21ID2WPp3C0oKrWeDWfAatOADIDtPJfpXcJ3k3jJGm4yhHedzgjAhSg?=
 =?us-ascii?Q?vERzHxDiIWbf4N23gj/kqo+/U/A/FnjQUE21TmXo/JvcbZRQbcHQ7HcYve2D?=
 =?us-ascii?Q?l63SwU47caX5IBIP4zGL+Wzgv47GWth08/1nqL1HarRwpMUCnIld0eUCNHoE?=
 =?us-ascii?Q?A2cMPCeW+gi+x3vqR2akiI+RRlebFqXkbAQEhsw3ocSpzRX5zH8u2SH2kRqL?=
 =?us-ascii?Q?AZ4CD7oSxzcxGHGspAkpzl+5Hoa5Ovef0Gr5XjwV+LJrO4qq06cpxW0DGUVu?=
 =?us-ascii?Q?SNzQJTOdTo7/Pv1CuCsZ8A1s4cE4qPqrdu9foegncfD1AbfD+jO+misMnh6e?=
 =?us-ascii?Q?Uw/18wnH9js2iWbSLxBRGbs3Nx4d1WviNFKZbc2kIt1lTRJMs/uByDE+hSaR?=
 =?us-ascii?Q?sxT0YNDUwKjondn2XoBjEv5ROE3iGBo4kKGfwkrnOF1108IGFW7znoyzSmhP?=
 =?us-ascii?Q?pUGuL0yT8jcXUSuXxTAQ8jtwVTzy/QmqarPZ6iTWDBWIvgcQx+TxGL4f/Jc0?=
 =?us-ascii?Q?0EiwrHgMGtAPNSlYI3lw300eYoRfgK7pKZP1K23Jaz1nexhsNG1FAtREL7Ze?=
 =?us-ascii?Q?UING5WYXxnzvPJkAw5cQ8qlOBONFvjdFjcSvIR7HylC8dwZebTpHaLb4LMrv?=
 =?us-ascii?Q?6ZE+CJZhmQCODqYEqKJpU9QqJvM2Yywt+RW0lRS7FWVR6gAM+FsFhrp3a7mc?=
 =?us-ascii?Q?0wUksSb7AmFQZp9HdFf99drHZmoxwnKl03Gr/Roev8fSZ2UKHVLkIRAoel05?=
 =?us-ascii?Q?vmPx5D5XrYQGx464daMLVSkIIdpsIQj8oz0HfaytZD011dm8NtSvPf/bMW6A?=
 =?us-ascii?Q?wpnDI1aSXUFMx5Ai4gfSi+etsXDSzMH6XxyC3tiJm3005mDCopC/KRnrOKmg?=
 =?us-ascii?Q?t3mP5jvlj2ca86WvbxmZEuVipfoRiM8UyHrWIIaaz/6yHvFzMvoNOKGXqyyG?=
 =?us-ascii?Q?3EG4r0SAKJcjbAQ7i13kwKNUzc7RAN5UJcW4fKpO7RoTD2y2ub38X0U3blHQ?=
 =?us-ascii?Q?k9LFEbxX2mKiy9FKMsKvrgTmYO7/jqM821BoNwgb+XHZ2eziVvgFRF/4zH6G?=
 =?us-ascii?Q?9To35PzEA3IfPCdesEwwdbGIU/VFBGr1jJVyefrOrzfhBZ9M8d85USb5r4dT?=
 =?us-ascii?Q?TC80sOFezwN86g3k3Xz5OsZp7rW5k212tKKfeQKGPnDh3Asfq0kRjpE2RYbI?=
 =?us-ascii?Q?wvvgGYIYIBo1GRfXGNQ6QKod?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ru2HcCFNLNwVzbo3C81gm8DttFacSl48iTH7TkBQD2VvvETvDbrdOtm8jbK2?=
 =?us-ascii?Q?G3aStzj6sDoSzUXm+cZ37iax7za0hiMYTq7kmfJ5h8yCnwFhdvLUXaCffLBf?=
 =?us-ascii?Q?TK7fgDZ29etazyiEThkJeRLAGuyz6Ziizjp3QPkmrzTn3g1hk+KBD8OhUcZ8?=
 =?us-ascii?Q?5S5vzg1HhZnt/4sfzdDiHguXgrrdZSrP2KgudBD1xn/uXrbzUqPXDAo45NJk?=
 =?us-ascii?Q?vnhjNAyBb3+0U1ZQ5y6pHswwm9UUPISoUX73y5osno0o00chBReEQyFwaFYl?=
 =?us-ascii?Q?GuGteV/SLOktWEqxVWJo00ONK6zmOyjRSKrS0fw8nhzmSDA/e7MyE5Q/nFAG?=
 =?us-ascii?Q?Q8kjkHND4XTG2QQTlpNCV/rRpJu3//vsFXi8lrP7+YFHvCdRFNzHzyqo98yA?=
 =?us-ascii?Q?ge6VBFrw4nvmZDChyvnj9ASD5uC5vcKyHLMlIzug0WgBF3PoAgahsT5FZUbB?=
 =?us-ascii?Q?fcSkD2kNq5pywdp971OqfHuCCE/fACC7ZpWuhlab0RxNkw7X0L8rKmpJ2MqW?=
 =?us-ascii?Q?mML/wSCp9rYhLcO9W3/GQ0eqOgxv4h02Mr3ZjuMcuGF7i/f4o4DMfx7EGQpg?=
 =?us-ascii?Q?/9t5PKQxADTVLuMx7BSSgQjrkdvNPCbeK2h/vzaJQKhOTKdBJdSLPtgoWemo?=
 =?us-ascii?Q?7ytC2Gv/MrjJbK1JqVYTfzoB1FHnHZM8vE0m7Ap+nhVm5ZqWrzIWEU+aF1EE?=
 =?us-ascii?Q?o1CqqEEmdon7y5iWcqFV+epjWGVUxK4D+7FJh8vwLFo8J076I06XsMRzFXU7?=
 =?us-ascii?Q?c2u/uO3ZrDyQXFcW04EIqNtTPhTVHRsDb8Y4QgFJadQ0Y2YnZRpJR5vOcvLI?=
 =?us-ascii?Q?TD7tbXLRqjqYlHt+3XFPFMu8OUzl474zv6ON2KVWLf7yAoQB5TT3Pm70HKHL?=
 =?us-ascii?Q?MRiqKA+Fcjw/37dJBDAY1PhToZY/KRWZas65V7yApvMVfJN/0O9fxKgMHND3?=
 =?us-ascii?Q?ar/iZWecI2V6Q1nnCuJ5UWp5DDc6maW0MUtD/sGUFlK35q3wRL8GlPSDroYa?=
 =?us-ascii?Q?ZCEZUTldPmwKciHt0klop/3TUgLz0XEberXEeeD47anIhfjvgpEGJSR2Wybz?=
 =?us-ascii?Q?ostqzhJxblY6XxjEiYBb32vlyTLL9/t319lz6oThdQPBsSOaGWV9k8XY6Iyf?=
 =?us-ascii?Q?ziyqD8Z4/4se0IhQnc1kwSs6TJXK8mjpHQrIndceFMctcVcd7cF2Q8xToyMc?=
 =?us-ascii?Q?SFMdSmNNiwLHTF5nhG3B3t6s7wwHdxnWZ6DMQoFIcIWlaIVk0IAKfzq+AfcZ?=
 =?us-ascii?Q?y6M4W1C0vJdQ7t0Ye6212mPlMnJA0uf7EVTP4yfRJja57z0SPttCURQWbWkr?=
 =?us-ascii?Q?QQP2nkkhhWmdKCUeb+Ku++PF1pERePNad0OldCaiwQWkcfXL4WZsegBymk7r?=
 =?us-ascii?Q?wsVqSG3E/2sZzP0ssbMVBKhQz/XKLN4bXJU5SH/q5QWUbyykjamGjn6KaVC7?=
 =?us-ascii?Q?bCJ0ducIkogkYwurZ4SnTkAZ6Qz6Y57vZnTWgi+43A/au1vcWgO6qKtb7nJK?=
 =?us-ascii?Q?xhkwr6zZGRgbtPZM7jXfvq3l9Fa7IAmoeCoimhDMH/aqC7f4WjKLFcv1MfSb?=
 =?us-ascii?Q?b71odnJscGctvoVtrBlrQFo9eaxWgOzBaoNjIBMn9TmJN8t2mfy+zKpPvn+u?=
 =?us-ascii?Q?hKkIlyerPbdNkolWCjjobOyvqXD20ui7fFv+PBg2UiBn1c4KegrdPKdZh5d4?=
 =?us-ascii?Q?bQCuFg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	iwBiPogV/6hg07Mqq4QM0M1jkIzKR+e1hPWxsnIAMx35O4Yd/ozGYQCOqkcoiU6+YgJ9aZzcah3EpYIpkSJ+GR4vYrfoZHOk/kqgagzapozNNuDeDf1nnLDWYOZ1eGmecsVpsG63Vrla9wrNWEWajji4xOZuWICvCqq0q04u2dN4uweHaI6PBCNNCK9lW31OQKjWH2oF02LMIwSbDxAfzgZawqbB5ccLc+Rkfs2rUjJi7bit8UFi434cl0EhCXV3u1BaPeb9/kJ87qJLVpkXgUqQtSEHck4pLlmLIcRTWYx4HzLdKHCuuPmLMClMMgeVi/tDeg26Zwe/SWsy9KH/sC9HR1IGIqSGo73+NJYKDAAzd+Slw31hfEYd9nxtezUy/LCINvEIG6S5LsLav44SuN0S7ZllD4D1paMVUlNz4pj83/lV5+DDQQswfDG5DtuLnpgJsbbRzbVlr8+xbMthnu7oYbGPHW7jBU8JB9BqceLUB5STc2KsGiXyAqm+bUOH9+HJJrxyhTCURvXkIDYWPFR1ApqRiuZi3D00n3SxwmgnyzAnv1uns9uJ1FjykNrBiH0osesFQfmkqAgeURCysgVn55jPjwfEfWHDALFxomg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32a31267-82d1-455a-9d55-08dcf3a2c1e7
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 20:39:14.4229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iMDX2IZYFu4d5iSGMtEyJYMFVSGDRUqKKt6b5qlYTdC87p6eBqOagXmrqDXQknb4h9W273BhoJEAV3zk6n+FYYX3mQjxVmzbYQS++7rwRdA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5833
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-23_16,2024-10-23_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410230132
X-Proofpoint-ORIG-GUID: CBlrgsLu13UUVspl6ZZk8r7P3AeOqAD4
X-Proofpoint-GUID: CBlrgsLu13UUVspl6ZZk8r7P3AeOqAD4

We have seen bugs and resource leaks arise from the complexity of the
__mmap_region() function. This, and the generally deeply fragile error
handling logic and complexity which makes understanding the function
difficult make it highly desirable to refactor it into something readable.

Achieve this by separating the function into smaller logical parts which
are easier to understand and follow, and which importantly very
significantly simplify the error handling.

Note that we now call vms_abort_munmap_vmas() in more error paths than we
used to, however in cases where no abort need occur, vms->nr_pages will be
equal to zero and we simply exit this function without doing more than we
would have done previously.

Importantly, the invocation of the driver mmap hook via mmap_file() now has
very simple and obvious handling (this was previously the most problematic
part of the mmap() operation).

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/vma.c | 401 ++++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 261 insertions(+), 140 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index 0a2965be582d..065f5e1f65be 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -7,6 +7,40 @@
 #include "vma_internal.h"
 #include "vma.h"
 
+struct mmap_state {
+	struct mm_struct *mm;
+	struct vma_iterator *vmi;
+
+	unsigned long addr;
+	unsigned long end;
+	pgoff_t pgoff;
+	unsigned long pglen;
+	unsigned long flags;
+	struct file *file;
+
+	unsigned long charged;
+
+	struct vm_area_struct *prev;
+	struct vm_area_struct *next;
+
+	/* Unmapping state. */
+	struct vma_munmap_struct vms;
+	struct ma_state mas_detach;
+	struct maple_tree mt_detach;
+};
+
+#define MMAP_STATE(name, mm_, vmi_, addr_, len_, pgoff_, flags_, file_) \
+	struct mmap_state name = {					\
+		.mm = mm_,						\
+		.vmi = vmi_,						\
+		.addr = addr_,						\
+		.end = addr + len,					\
+		.pgoff = pgoff_,					\
+		.pglen = PHYS_PFN(len_),				\
+		.flags = flags_,					\
+		.file = file_,						\
+	}
+
 static inline bool is_mergeable_vma(struct vma_merge_struct *vmg, bool merge_next)
 {
 	struct vm_area_struct *vma = merge_next ? vmg->next : vmg->prev;
@@ -2169,188 +2203,259 @@ static void vms_abort_munmap_vmas(struct vma_munmap_struct *vms,
 	vms_complete_munmap_vmas(vms, mas_detach);
 }
 
-unsigned long __mmap_region(struct file *file, unsigned long addr,
-		unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
-		struct list_head *uf)
+/*
+ * __mmap_prepare() - Prepare to gather any overlapping VMAs that need to be
+ * unmapped once the map operation is completed, check limits, account mapping
+ * and clean up any pre-existing VMAs.
+ *
+ * @map: Mapping state.
+ * @vmg: VMA merge state.
+ * @uf:  Userfaultfd context list.
+ *
+ * Returns: 0 on success, error code otherwise.
+ */
+static int __mmap_prepare(struct mmap_state *map, struct vma_merge_struct *vmg,
+	struct list_head *uf)
 {
-	struct mm_struct *mm = current->mm;
-	struct vm_area_struct *vma = NULL;
-	pgoff_t pglen = PHYS_PFN(len);
-	unsigned long charged = 0;
-	struct vma_munmap_struct vms;
-	struct ma_state mas_detach;
-	struct maple_tree mt_detach;
-	unsigned long end = addr + len;
 	int error;
-	VMA_ITERATOR(vmi, mm, addr);
-	VMG_STATE(vmg, mm, &vmi, addr, end, vm_flags, pgoff);
-
-	vmg.file = file;
-	/* Find the first overlapping VMA */
-	vma = vma_find(&vmi, end);
-	init_vma_munmap(&vms, &vmi, vma, addr, end, uf, /* unlock = */ false);
-	if (vma) {
-		mt_init_flags(&mt_detach, vmi.mas.tree->ma_flags & MT_FLAGS_LOCK_MASK);
-		mt_on_stack(mt_detach);
-		mas_init(&mas_detach, &mt_detach, /* addr = */ 0);
+	struct vma_iterator *vmi = map->vmi;
+	struct vma_munmap_struct *vms = &map->vms;
+
+	/* Find the first overlapping VMA and initialise unmap state. */
+	vms->vma = vma_find(vmi, map->end);
+	init_vma_munmap(vms, vmi, vms->vma, map->addr, map->end, uf,
+			/* unlock = */ false);
+
+	/* OK, we have overlapping VMAs - prepare to unmap them. */
+	if (vms->vma) {
+		mt_init_flags(&map->mt_detach,
+			      vmi->mas.tree->ma_flags & MT_FLAGS_LOCK_MASK);
+		mt_on_stack(map->mt_detach);
+		mas_init(&map->mas_detach, &map->mt_detach, /* addr = */ 0);
 		/* Prepare to unmap any existing mapping in the area */
-		error = vms_gather_munmap_vmas(&vms, &mas_detach);
-		if (error)
-			goto gather_failed;
+		error = vms_gather_munmap_vmas(vms, &map->mas_detach);
+		if (error) {
+			/* On error VMAs will already have been reattached. */
+			vms->nr_pages = 0;
+			return error;
+		}
 
-		vmg.next = vms.next;
-		vmg.prev = vms.prev;
-		vma = NULL;
+		map->next = vms->next;
+		map->prev = vms->prev;
 	} else {
-		vmg.next = vma_iter_next_rewind(&vmi, &vmg.prev);
+		map->next = vma_iter_next_rewind(vmi, &map->prev);
 	}
 
+	/* Set up vmg for merge attempt. */
+	vmg->file = map->file;
+	vmg->prev = map->prev;
+	vmg->next = map->next;
+
 	/* Check against address space limit. */
-	if (!may_expand_vm(mm, vm_flags, pglen - vms.nr_pages)) {
-		error = -ENOMEM;
-		goto abort_munmap;
-	}
+	if (!may_expand_vm(map->mm, map->flags, map->pglen - vms->nr_pages))
+		return -ENOMEM;
 
-	/*
-	 * Private writable mapping: check memory availability
-	 */
-	if (accountable_mapping(file, vm_flags)) {
-		charged = pglen;
-		charged -= vms.nr_accounted;
-		if (charged) {
-			error = security_vm_enough_memory_mm(mm, charged);
+	/* Private writable mapping: check memory availability. */
+	if (accountable_mapping(map->file, map->flags)) {
+		map->charged = map->pglen;
+		map->charged -= vms->nr_accounted;
+		if (map->charged) {
+			error = security_vm_enough_memory_mm(map->mm, map->charged);
 			if (error)
-				goto abort_munmap;
+				return error;
 		}
 
-		vms.nr_accounted = 0;
-		vm_flags |= VM_ACCOUNT;
-		vmg.flags = vm_flags;
+		vms->nr_accounted = 0;
+		map->flags |= VM_ACCOUNT;
 	}
 
 	/*
-	 * clear PTEs while the vma is still in the tree so that rmap
+	 * Clear PTEs while the vma is still in the tree so that rmap
 	 * cannot race with the freeing later in the truncate scenario.
 	 * This is also needed for mmap_file(), which is why vm_ops
 	 * close function is called.
 	 */
-	vms_clean_up_area(&vms, &mas_detach);
-	vma = vma_merge_new_range(&vmg);
-	if (vma)
-		goto expanded;
+	vms_clean_up_area(vms, &map->mas_detach);
+
+	return 0;
+}
+
+static int __mmap_new_file_vma(struct mmap_state *map,
+			       struct vma_merge_struct *vmg,
+			       struct vm_area_struct **vmap, bool *mergedp)
+{
+	struct vma_iterator *vmi = map->vmi;
+	struct vm_area_struct *vma = *vmap;
+	int error;
+
+	vma->vm_file = get_file(map->file);
+	error = mmap_file(vma->vm_file, vma);
+	if (error) {
+		fput(vma->vm_file);
+		vma->vm_file = NULL;
+
+		vma_iter_set(vmi, vma->vm_end);
+		/* Undo any partial mapping done by a device driver. */
+		unmap_region(&vmi->mas, vma, map->prev, map->next);
+
+		return error;
+	}
+
+	/* Drivers cannot alter the address of the VMA. */
+	WARN_ON_ONCE(map->addr != vma->vm_start);
+	/*
+	 * Drivers should not permit writability when previously it was
+	 * disallowed.
+	 */
+	VM_WARN_ON_ONCE(map->flags != vma->vm_flags &&
+			!(map->flags & VM_MAYWRITE) &&
+			(vma->vm_flags & VM_MAYWRITE));
+
+	vma_iter_config(vmi, map->addr, map->end);
+	/*
+	 * If flags changed after mmap_file(), we should try merge
+	 * vma again as we may succeed this time.
+	 */
+	if (unlikely(map->flags != vma->vm_flags && map->prev)) {
+		struct vm_area_struct *merge;
+
+		vmg->flags = vma->vm_flags;
+		/* If this fails, state is reset ready for a reattempt. */
+		merge = vma_merge_new_range(vmg);
+
+		if (merge) {
+			/*
+			 * ->mmap() can change vma->vm_file and fput
+			 * the original file. So fput the vma->vm_file
+			 * here or we would add an extra fput for file
+			 * and cause general protection fault
+			 * ultimately.
+			 */
+			fput(vma->vm_file);
+			vm_area_free(vma);
+			vma = merge;
+			*mergedp = true;
+		} else {
+			vma_iter_config(vmi, map->addr, map->end);
+		}
+	}
+
+	map->flags = vma->vm_flags;
+	*vmap = vma;
+	return 0;
+}
+
+/*
+ * __mmap_new_vma() - Allocate a new VMA for the region, as merging was not
+ * possible.
+ *
+ * An exception to this is if the mapping is file-backed, and the underlying
+ * driver changes the VMA flags, permitting a subsequent merge of the VMA, in
+ * which case the returned VMA is one that was merged on a second attempt.
+ *
+ * @map:  Mapping state.
+ * @vmg:  VMA merge state.
+ * @vmap: Output pointer for the new VMA.
+ *
+ * Returns: Zero on success, or an error.
+ */
+static int __mmap_new_vma(struct mmap_state *map, struct vma_merge_struct *vmg,
+			  struct vm_area_struct **vmap)
+{
+	struct vma_iterator *vmi = map->vmi;
+	int error = 0;
+	bool merged = false;
+	struct vm_area_struct *vma;
+
 	/*
 	 * Determine the object being mapped and call the appropriate
 	 * specific mapper. the address has already been validated, but
 	 * not unmapped, but the maps are removed from the list.
 	 */
-	vma = vm_area_alloc(mm);
-	if (!vma) {
-		error = -ENOMEM;
-		goto unacct_error;
-	}
+	vma = vm_area_alloc(map->mm);
+	if (!vma)
+		return -ENOMEM;
 
-	vma_iter_config(&vmi, addr, end);
-	vma_set_range(vma, addr, end, pgoff);
-	vm_flags_init(vma, vm_flags);
-	vma->vm_page_prot = vm_get_page_prot(vm_flags);
+	vma_iter_config(vmi, map->addr, map->end);
+	vma_set_range(vma, map->addr, map->end, map->pgoff);
+	vm_flags_init(vma, map->flags);
+	vma->vm_page_prot = vm_get_page_prot(map->flags);
 
-	if (vma_iter_prealloc(&vmi, vma)) {
+	if (vma_iter_prealloc(vmi, vma)) {
 		error = -ENOMEM;
 		goto free_vma;
 	}
 
-	if (file) {
-		vma->vm_file = get_file(file);
-		error = mmap_file(file, vma);
-		if (error)
-			goto unmap_and_free_file_vma;
-
-		/* Drivers cannot alter the address of the VMA. */
-		WARN_ON_ONCE(addr != vma->vm_start);
-		/*
-		 * Drivers should not permit writability when previously it was
-		 * disallowed.
-		 */
-		VM_WARN_ON_ONCE(vm_flags != vma->vm_flags &&
-				!(vm_flags & VM_MAYWRITE) &&
-				(vma->vm_flags & VM_MAYWRITE));
-
-		vma_iter_config(&vmi, addr, end);
-		/*
-		 * If vm_flags changed after mmap_file(), we should try merge
-		 * vma again as we may succeed this time.
-		 */
-		if (unlikely(vm_flags != vma->vm_flags && vmg.prev)) {
-			struct vm_area_struct *merge;
-
-			vmg.flags = vma->vm_flags;
-			/* If this fails, state is reset ready for a reattempt. */
-			merge = vma_merge_new_range(&vmg);
-
-			if (merge) {
-				/*
-				 * ->mmap() can change vma->vm_file and fput
-				 * the original file. So fput the vma->vm_file
-				 * here or we would add an extra fput for file
-				 * and cause general protection fault
-				 * ultimately.
-				 */
-				fput(vma->vm_file);
-				vm_area_free(vma);
-				vma = merge;
-				/* Update vm_flags to pick up the change. */
-				vm_flags = vma->vm_flags;
-				goto file_expanded;
-			}
-			vma_iter_config(&vmi, addr, end);
-		}
-
-		vm_flags = vma->vm_flags;
-	} else if (vm_flags & VM_SHARED) {
+	if (map->file)
+		error = __mmap_new_file_vma(map, vmg, &vma, &merged);
+	else if (map->flags & VM_SHARED)
 		error = shmem_zero_setup(vma);
-		if (error)
-			goto free_iter_vma;
-	} else {
+	else
 		vma_set_anonymous(vma);
-	}
+
+	if (error)
+		goto free_iter_vma;
+
+	if (merged)
+		goto file_expanded;
 
 #ifdef CONFIG_SPARC64
 	/* TODO: Fix SPARC ADI! */
-	WARN_ON_ONCE(!arch_validate_flags(vm_flags));
+	WARN_ON_ONCE(!arch_validate_flags(map->flags));
 #endif
 
 	/* Lock the VMA since it is modified after insertion into VMA tree */
 	vma_start_write(vma);
-	vma_iter_store(&vmi, vma);
-	mm->map_count++;
+	vma_iter_store(vmi, vma);
+	map->mm->map_count++;
 	vma_link_file(vma);
 
 	/*
 	 * vma_merge_new_range() calls khugepaged_enter_vma() too, the below
 	 * call covers the non-merge case.
 	 */
-	khugepaged_enter_vma(vma, vma->vm_flags);
+	khugepaged_enter_vma(vma, map->flags);
 
 file_expanded:
-	file = vma->vm_file;
 	ksm_add_vma(vma);
-expanded:
+	*vmap = vma;
+	return 0;
+
+free_iter_vma:
+	vma_iter_free(vmi);
+free_vma:
+	vm_area_free(vma);
+	return error;
+}
+
+/*
+ * __mmap_complete() - Unmap any VMAs we overlap, account memory mapping
+ *                     statistics, handle locking and finalise the VMA.
+ *
+ * @map: Mapping state.
+ * @vma: Merged or newly allocated VMA for the mmap()'d region.
+ */
+static void __mmap_complete(struct mmap_state *map, struct vm_area_struct *vma)
+{
+	struct mm_struct *mm = map->mm;
+	unsigned long vm_flags = vma->vm_flags;
+
 	perf_event_mmap(vma);
 
-	/* Unmap any existing mapping in the area */
-	vms_complete_munmap_vmas(&vms, &mas_detach);
+	/* Unmap any existing mapping in the area. */
+	vms_complete_munmap_vmas(&map->vms, &map->mas_detach);
 
-	vm_stat_account(mm, vm_flags, pglen);
+	vm_stat_account(mm, vma->vm_flags, map->pglen);
 	if (vm_flags & VM_LOCKED) {
 		if ((vm_flags & VM_SPECIAL) || vma_is_dax(vma) ||
 					is_vm_hugetlb_page(vma) ||
-					vma == get_gate_vma(current->mm))
+					vma == get_gate_vma(mm))
 			vm_flags_clear(vma, VM_LOCKED_MASK);
 		else
-			mm->locked_vm += pglen;
+			mm->locked_vm += map->pglen;
 	}
 
-	if (file)
+	if (vma->vm_file)
 		uprobe_mmap(vma);
 
 	/*
@@ -2363,26 +2468,42 @@ unsigned long __mmap_region(struct file *file, unsigned long addr,
 	vm_flags_set(vma, VM_SOFTDIRTY);
 
 	vma_set_page_prot(vma);
+}
 
-	return addr;
+unsigned long __mmap_region(struct file *file, unsigned long addr,
+		unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
+		struct list_head *uf)
+{
+	struct mm_struct *mm = current->mm;
+	struct vm_area_struct *vma;
+	int error;
+	VMA_ITERATOR(vmi, mm, addr);
+	VMG_STATE(vmg, mm, &vmi, addr, addr + len, vm_flags, pgoff);
+	MMAP_STATE(map, mm, &vmi, addr, len, pgoff, vm_flags, file);
 
-unmap_and_free_file_vma:
-	fput(vma->vm_file);
-	vma->vm_file = NULL;
+	error = __mmap_prepare(&map, &vmg, uf);
+	if (error)
+		goto abort_munmap;
 
-	vma_iter_set(&vmi, vma->vm_end);
-	/* Undo any partial mapping done by a device driver. */
-	unmap_region(&vmi.mas, vma, vmg.prev, vmg.next);
-free_iter_vma:
-	vma_iter_free(&vmi);
-free_vma:
-	vm_area_free(vma);
-unacct_error:
-	if (charged)
-		vm_unacct_memory(charged);
+	/* Attempt to merge with adjacent VMAs... */
+	vmg.flags = map.flags;
+	vma = vma_merge_new_range(&vmg);
+	if (!vma) {
+		/* ...but if we can't, allocate a new VMA. */
+		error = __mmap_new_vma(&map, &vmg, &vma);
+		if (error)
+			goto unacct_error;
+	}
+
+	__mmap_complete(&map, vma);
 
+	return addr;
+
+	/* Accounting was done by __mmap_prepare(). */
+unacct_error:
+	if (map.charged)
+		vm_unacct_memory(map.charged);
 abort_munmap:
-	vms_abort_munmap_vmas(&vms, &mas_detach);
-gather_failed:
+	vms_abort_munmap_vmas(&map.vms, &map.mas_detach);
 	return error;
 }
-- 
2.47.0


