Return-Path: <linux-kernel+bounces-565071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CEAFEA6604D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 22:16:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 629DA7A5E13
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 21:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7F51FFC70;
	Mon, 17 Mar 2025 21:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Mj3r0Px9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZiM0SYdv"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9AD01E8352
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 21:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742246204; cv=fail; b=kkFCSCEHGr1ovhX3wGQ+JNvC5HTH7U2p3w1GD9Nix5ciFOs9vIYGLXbrHrD/6JXMfZxCWH8wL8M1Bmf2ipXmhYASS3xvjjS5MHU7Li2gYwr+ynVnEl6c90ia+Sadrv1E3u1sUanZw3gOzcLVsQ41VJPmPxBMS2+AwPbWmYgcOT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742246204; c=relaxed/simple;
	bh=9pjvceYZrS0wj75LVQjtE7M7clB1OQacHB2Vuh+Z6K0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NbxE0OmMajCqWukHYrdgNyic9cLVNPHiTClZPhCBH5vcBkl9FFjErP9wW/34fjWy9BaPPS9BDdsbBGUeA4Kj9f5cMH5WiXNAafO6nXj05RuMZPPiEbVamQ/HscB5lh64BVkc/D/fOd+qw6FtCm8QTEa65ZBZzQtaeWCz0Jurjg8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Mj3r0Px9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZiM0SYdv; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52HKxiqY004220;
	Mon, 17 Mar 2025 21:15:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=9JGaiNeHzko7DLwD5R7fqyVgFCXtQuIIbGMbq1KTEp0=; b=
	Mj3r0Px9LsVLTYLx01scAclQSqtt3tMAVxhZjN9RSl7nwtr1X94zJqABWwiojdbR
	2lhFk1T41niWQXwF0QhLQxG4VbAh0EhsB/I+WMEEhsL+ahGGyiTWZj3yHZXhoGHc
	5hbHW5HCrjwWzB8u0IMH+vxX3VCjngEVA/44czOhF8puMKui+ActMlV0cbUK7fVE
	l62QTFmjZ328B41BD0z1rYzCYJLI3BfSKJoqGNVJTXy7EppT1OgTeHO8xb30DqSI
	7t80wkO4G4IV0cK7SXAejy7yKk3VebFNxYILj52SPJTTcwoeoF6DoASClSTNaGoB
	JaZiNV4K7s+LkJL6K/GyiQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d23ruwx5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Mar 2025 21:15:26 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52HJWHce023892;
	Mon, 17 Mar 2025 21:15:25 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45dxeefmgt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Mar 2025 21:15:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vO+Av8hcypi4AUGaCDosG3/v8ouhSx1R5Q5VcvgRywNT8pjpRl58LT5YrvJmB1Weslkw98XmyHE/jrF+Y/9+aZhDd7WruYqaAJsWPuiTxt5A0j24trywfEaXTk+EZwfyk2bISjlC68eZkp6WgrFNo4h4NIc38pKxJyODDxam7S/Korbq5360PXnvapwHYKMp19M9wQBNRp+mR7hVyEHTAuVyjqlYQOjkM8wu3ff2GKyjftsqb/lmgu7waJOEw3MTxw0sZlch3PMBeiSmyaN0ocIKZAgQh4xOEboFBh1yzW1yUoIrV/BvM+ZgR8chTABAGaj6CngDNAmgkvLLbCnlAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9JGaiNeHzko7DLwD5R7fqyVgFCXtQuIIbGMbq1KTEp0=;
 b=VWCNLcebu75eNdDr6XZkJbRe1jLuhjP/6ax5zaNd2VOjsraM/tgkfzdx6X8IwAzIBfaIZCFvddRQwYnzjuNJYB0ei2qmf4kQQeV/4aKWV1CavWrxXX5p+wq/oiCl9ZlHQBUdRVsFdzR1vRhQdMquPN7f4AbhuaNxdC/omuzpZHOPhATNOhVN/0xtGF74pBPpbhLmeFQsxyTTsuLAXU2TsGRui75RTlroz+lpLYkOhLelKgKdyighS4rIHIwQwg/oxzInKlPhBjkFmiwjtQ/7txMmYntUuuV6P6ZRLsH0WhyFmnYb76AwN2EB+pM0JY2ZVb2nxL+uHmpxr5mZF4GHzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9JGaiNeHzko7DLwD5R7fqyVgFCXtQuIIbGMbq1KTEp0=;
 b=ZiM0SYdv9ZsBGCDYGdq8xLUx5Jw0RAJQ5uUUmg78jGirOWElwDPdA1Cwnqtjen8j6wyOUJujFfDf8igECCjI7uaUqHyrIRGIco7tAOvYXrDul9dEu0TAgeeWH1lAZxxVRuyo7mRsGnAGC18IZUAQ7+9Oqjc8jiElWpTYuGNr9yM=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by PH7PR10MB7105.namprd10.prod.outlook.com (2603:10b6:510:27f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 21:15:22 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%4]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 21:15:22 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>, Rik van Riel <riel@surriel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] mm/vma: fix incorrectly disallowed anonymous VMA merges
Date: Mon, 17 Mar 2025 21:15:03 +0000
Message-ID: <ab86a655c18cf9feb031a9b08b74812dcb432221.1742245056.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1742245056.git.lorenzo.stoakes@oracle.com>
References: <cover.1742245056.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0129.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c6::20) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|PH7PR10MB7105:EE_
X-MS-Office365-Filtering-Correlation-Id: ef0c1a96-7ebc-4704-8454-08dd6598d3dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zNV429CfdEm+kvyw3rNiZX98+gqLHacDAdPdpwU6OOX5y2XZoINu0yeJvE4a?=
 =?us-ascii?Q?+GMpQ/P6zvmZg9JeMBqNucAhV9x/Db2M/T1T93Vrs/MlTIjhUzAlWw0doCPe?=
 =?us-ascii?Q?fvcEYxeizEoUoq3GYPJ6Jx2T9TOJGjqN4Q0pkwllJ/p2KaimR1z6YbNnEDPD?=
 =?us-ascii?Q?w44HqrlZiptlYKGKSQUxrv2o3C+dR/xd/9/xIT4l0O2jxrAs82DpgV8BB9rs?=
 =?us-ascii?Q?RmSGohnaLGw2C2EPVq/J6z91Qpxw+snXt3hvd3y/A5GzLK0WKe/TzKvGY8KE?=
 =?us-ascii?Q?DsOrF5KbAOtzUpck7Bsnn8xyHiFqFFWF9Bl/OC2j3nbPLbyf9heIi6s9gds8?=
 =?us-ascii?Q?uNwBTwvslzTIbsofjd4eGJvOYVBQ8ZyccrwY8MOwMk9oM3RH+gW6MN6SDdZz?=
 =?us-ascii?Q?MmH3dBcCfm3UCUvuVWlhoeJlYR+JDLoY/69mVWsiBvsXtwGXjrnCWl1yxp4d?=
 =?us-ascii?Q?KPNjb/SdIBXpRG6uuToRSCXxnMxOsVEsGV8HDiQrNWzs9hyJWl9BQkd/pGjK?=
 =?us-ascii?Q?KewJ2l3SA0lw/enN2StyEhxU4qq2WaEH9kegyxdwr0TXY4kGGuasLLCnakxe?=
 =?us-ascii?Q?cobRKvJUNK+iut3ThuXCRaHGEHIfejC7P5YRTkSpKy5zeBrQnQo1XdcpEoOI?=
 =?us-ascii?Q?sKz0uVzFHwXtZ8RxBpNZMpU3mShLTIl/8ZmC4w36ejWgJyAoQ1ZZj29JHQfh?=
 =?us-ascii?Q?5xlyI5795ImIBDECkAtVTVqFZaj8zOI14oecETmzxGDDJ59iPENmCAITo0EI?=
 =?us-ascii?Q?qiSe5/RNJQ6zCFzYIwjOw8KqQXfpd3MeSaxngSa7uMmGf4Rb29k0Q7Ssxdnt?=
 =?us-ascii?Q?7ns3wpFYnR2Z7yz6+UrxTsqCM7qMO70OeK5kn0Vc7BT5cLbeT+EvtMvwRbns?=
 =?us-ascii?Q?dLPCayjWcS2qE1xItg3+WPmNzPB4yVCRyFQw1/oJ18Tn5tMgGkeGtXGkxWR7?=
 =?us-ascii?Q?o1VQkKRPnzbYKERl1kPStFLdev1K9dxHNMHTkfaCLlbKrGiEEWA0OF88zy8O?=
 =?us-ascii?Q?naWw/au5dbJbMcSVQw2U2Xw8k4WxFGCxrqqMs64StoMy8EZPARi6mhEFIYcA?=
 =?us-ascii?Q?326BmXbHT+xmQp0zSl3Q0YtorjZLNJl4tB+sAcYTpTLiSsQlTjCIOITiPsB9?=
 =?us-ascii?Q?NIX3GYDIIcp6JrD9tGB/UqiMP5HIHTv/UvOfskzaE+fzh2avpzMJIv0eS4Vs?=
 =?us-ascii?Q?eV8/SJjECGbotXOCi0nQYIj11qht8xhB6JBmHYjlvmXKjNjNfJgFSZ9krqtY?=
 =?us-ascii?Q?IVfaXkBuVY3p+0GBi0l1cllctV6wB1+v/DzIwOFlBg4YrPcYM8TfWeInslSe?=
 =?us-ascii?Q?tOt53ssw7T9Kv67v5f8je0Ok9m+Vdjm23mPtmyziwdKDqes498QADNNsNhad?=
 =?us-ascii?Q?g3nFlYzhjrDIie+mzaCveSfJ8dgN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7W8He5CTl4G/1/8S/mtNfPq5YlHS2e3zMsfAbbHVB1xq8p9Kn5w9d8PM+PNb?=
 =?us-ascii?Q?d8y1cO/yh+m1EtC5xbWqiedZCdc9jDYk4plI0u3sdmKTAFkhf8UyC4yFWiW0?=
 =?us-ascii?Q?X8uQy18wiO1Nd/4K8Jutw2JqBppX8Q/2ujuRc8RnqsN9g31OA3Tjuc03o2Gm?=
 =?us-ascii?Q?3mhmM4+TRAxjqm40pN3NUwt/LV2q1KqeJRKOq1KmFLpy38JTnOFTZRn8H5MC?=
 =?us-ascii?Q?Ryk6bnzy+q4nZAcRLrqvam80BfcUm26cHLEJ1ICUe1QCgL5ypUBk3YJtEKEJ?=
 =?us-ascii?Q?BW2oUh8xXB1Tv/uMqrqIkNnJDJs6AnGCKBJHFuRlMX/IGLdzskY5uxuIqByA?=
 =?us-ascii?Q?/mQhHByOuKQAcKessWl0y8e6kUwCi1x8TtLUBAPv64kJRkXKvw1ldenpd/Cn?=
 =?us-ascii?Q?zxrPEaHTeGWpnbcCLHYEjZLYNRG/gb52PV0Q3Ruz1zKtp3oxombgiTNMARer?=
 =?us-ascii?Q?tdybKevE8wEqU0JZz9cjuAEMMnfPGCj5CGCKFjivv7TvzpJ2Nm9qBl1Z0u28?=
 =?us-ascii?Q?o2Oo6h1jFOJVF+HECM3XjeHSFRyMVQJfLmQpY3pHDnaIR4HLU/p1w58LozdA?=
 =?us-ascii?Q?C2D/kJ8Nd9pXuIU/YwkuxBPd94HaRlDvO1CA9VkUp09d7DGqcwzIkOeCfbIO?=
 =?us-ascii?Q?2kk12+Ei068HBtdqPBndMb4gG754eL4uth/GPZA6ze2R7dzTQXqrs6zMdRBg?=
 =?us-ascii?Q?W852SQusYDaiQECoG6KVM0QNxjQw7r5bURsoG1T8OfrOz8SKDhiQ8POXN1gO?=
 =?us-ascii?Q?iQsWf56Pkm91c0s9JApS49OqDntHGItKbQow9+q0j1EICrlDhZn0VdabV8yW?=
 =?us-ascii?Q?5TLKvDQFa0CiKTIxCQr9MWv0pyKXUnHD18N0T0Ka9bQg0Azvo8RZZgA1WR04?=
 =?us-ascii?Q?9V08qWzOpNp5/lY8vDxGuqaeG9/aIGUceMvbWnDT/6reVDcjsN7820YZd26N?=
 =?us-ascii?Q?0UPnGWSjR21vBqZ5RerOpE2xLyQ8wuGEZ26bpU33FTAssl+JH0PsBRiZidfF?=
 =?us-ascii?Q?aKfArlo5IuC8S4fMfg1KBUdrDwU4ZUsu5cwxgTEk///1jjTk92ltKf8HK06i?=
 =?us-ascii?Q?erX+VxUind8V4B3bdCPxtKpWhu6GHVCy1Lr5dXiKsh6uk9/D2hQJzpddLZHD?=
 =?us-ascii?Q?ja9zALjma6oCT0mtcK1JGv+Xh9fEy3s6quZX+yVAM9aDRv+/8DRvGYg1E0Q3?=
 =?us-ascii?Q?MICmENnNOMpMtQulq1rKeTOlVzllpiK6feunQQKR+nUBJeohXuhjkIKxltBH?=
 =?us-ascii?Q?aLqd1GX2K/Ry/dL5rrcyj/uStoA649hZaTHLTxRlYjPNxnUzpUkUPhwNGWQC?=
 =?us-ascii?Q?uh0pd7oA/i+4P5a7G5X1fazHfypGSpO2ipoWw6uBG71CbYjL6K+fyecOQrMU?=
 =?us-ascii?Q?Ozs9Kxv0eT8Gy5QtfxQdKpEDaqXzT/DkRJyd803LX2dGZ5xkyHBGawqZJfAI?=
 =?us-ascii?Q?zhA8F4G/3vE6MNRtuLs777h6K+103RGMZavrSGy7TFEINRAnFfj5sj7hQAPq?=
 =?us-ascii?Q?WGb7/l0bf2OvcBSMHynhz6xUqM5XTSHjrQP55Azo+XyMgG80PmNMwS58H4f7?=
 =?us-ascii?Q?a+2VhtEEPERX2/MPeq7WShEJEd2zbQ87vIjhYz+xVR0CdQr4uXzU2OARE5Ga?=
 =?us-ascii?Q?aw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7qky29zhmI+qs+a2oiwNeUKf4mTTN9Cpt3/a/sGqwqKWnKB2Jp2+tWSmAOGL5G98pab9cya0In+yIez8BiFqpYEpU136+EJjgFteJwjSk1rBEtfzQqrPDJ2Kyqe19BJsKITpWsf+7VgHvrGrv+n0mbzlZWd2kXr0TSQ1xeaqaCn/GDHRE2tgOTRP9fsCbK44lqSBYKoAtTStg3TDhSbnh41Wu5s71seDMHjbBn/rAGqYM3qc5Vm/Ofd39Y4gSuoS8pMfZHChxpfmwyfMHfbzBRrhsSBmEBqwy27odNxkT/WwHr0i5BSARLeek/WF6zkoNDRz21H6ESiuW2dXZux5tRuVVFfeOoDzJ5DuYtGy/L54wcnjY5s89BWgnKCwu73smkSzrVS5m6TxQnOvVxSYD+qh/GbyupjiST/3TT9bJWkZ6TvJzIqFIs8GQJpfxlgKMoK/s4jcZAVrM5S4b6yM1T24d+PQxK390IGS6sJrplsgec2P9J2Hf6gi6Gi980QN78k4WpUylA3jwHA0D0ifJQNrsvD3e8Df8wLgWkkSAB/u6d6NXvV3H3UAXrsvAJHGEdPotHtHTz29l22qsWTqqkwdYZC5DTouCF9wGvYa06s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef0c1a96-7ebc-4704-8454-08dd6598d3dd
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 21:15:22.2802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VeRONMIeOyUefkxA/ePGXpIooojbd0QYaJqkvNEqnmLIKEpXdmZkghkynLuXKec6IqeC53YszsXiBVYJ6mhBbzQqgLj1VRmD2dj2u/ao2SI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7105
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-17_09,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503170153
X-Proofpoint-GUID: RKclHUrvIMeSSv94VMdJbQkRfwOTrHDD
X-Proofpoint-ORIG-GUID: RKclHUrvIMeSSv94VMdJbQkRfwOTrHDD

anon_vma_chain's were introduced by Rik von Riel in commit 5beb49305251 ("mm:
change anon_vma linking to fix multi-process server scalability issue").

This patch was introduced in March 2010. As part of this change, careful
attention was made to the instance of mprotect() causing a VMA merge, with one
faulted (i.e. having anon_vma set) and another not:

		/*
		 * Easily overlooked: when mprotect shifts the boundary,
		 * make sure the expanding vma has anon_vma set if the
		 * shrinking vma had, to cover any anon pages imported.
		 */

In the modern VMA code, this is handled in dup_anon_vma() (and ultimately
anon_vma_clone()).

This case is one of the three configurations of adjacent VMA anon_vma state
that we might encounter on merge (where dst is the VMA which will be merged
into and src the one being merged into dst):

1.  dst->anon_vma,  src->anon_vma - These must be equal, no-op.
2.  dst->anon_vma, !src->anon_vma - We simply use dst->anon_vma, no-op.
3. !dst->anon_vma,  src->anon_vma - The case in question here.

In case 3, the instance addressed here - we duplicate the AVC connections
from src and place into dst.

However, in practice, we very often do NOT do this.

This appears to be due to an inadvertent consequence of the change
introduced by commit 965f55dea0e3 ("mmap: avoid merging cloned VMAs"),
introduced in May 2011.

This implies that this merge case was functional only for a little over a
year, and has since been broken for ~15 years.

Here, lock scalability concerns lead to us restricting anonymous merges
only to those VMAs with 1 entry in their vma->anon_vma_chain, that is, a
VMA that is not connected to any parent process's anon_vma.

The mergeability test looks like this:

static inline bool is_mergeable_anon_vma(struct anon_vma *anon_vma1,
		 struct anon_vma *anon_vma2, struct vm_area_struct *vma)
{
	if ((!anon_vma1 || !anon_vma2) && (!vma ||
		!vma->anon_vma || list_is_singular(&vma->anon_vma_chain)))
		return true;
	return anon_vma1 == anon_vma2;
}

However, we have a problem here - typically the vma passed here is the
destination VMA.

For instance in vma_merge_existing_range() we invoke:

can_vma_merge_left()
-> [ check that there is an immediately adjacent prior VMA ]
-> can_vma_merge_after()
  -> is_mergeable_vma() for general attribute check
-> is_mergeable_anon_vma([ proposed anon_vma ], prev->anon_vma, prev)

So if we were considering a target unfaulted 'prev':

	  unfaulted    faulted
	|-----------|-----------|
	|    prev   |    vma    |
	|-----------|-----------|

This would call is_mergeable_anon_vma(NULL, vma->anon_vma, prev).

The list_is_singular() check for vma->anon_vma_chain, an empty list on
fault, would cause this merge to _fail_ even though all else indicates a
merge.

Equally a simple merge into a next VMA would hit the same problem:

	   faulted    unfaulted
	|-----------|-----------|
	|    vma    |    next   |
	|-----------|-----------|

can_vma_merge_right()
-> [ check that there is an immediately adjacent succeeding VMA ]
-> can_vma_merge_before()
  -> is_mergeable_vma() for general attribute check
-> is_mergeable_anon_vma([ proposed anon_vma ], next->anon_vma, next)

For a 3-way merge, we'd also hit the same problem if it was configured like
this for instance:

	  unfaulted    faulted    unfaulted
	|-----------|-----------|-----------|
	|    prev   |    vma    |    next   |
	|-----------|-----------|-----------|

As we'd call can_vma_merge_left() for prev, and can_vma_merge_right() for
next, both of which would fail.

vma_merge_new_range() (and relatedly, vma_expand()) are not impacted, as
the new VMA would never already be faulted (it is a proposed new range).

Because we already handle each of the aforementioned merge cases, and can
absolutely therefore deal with an existing VMA merge with !dst->anon_vma,
src->anon_vma, there is absolutely no reason to disallow this kind of
merge.

It seems that the intention of this patch is to ensure that, in the
instance of merging unfaulted VMAs with faulted ones, we never wish to do
so with those with multiple AVCs due to the fact that anon_vma lock's are
held across both parent and child anon_vma's (actually, the 'root' parent
anon_vma's lock is used).

In fact, the original commit alludes to this - "find_mergeable_anon_vma()
already considers this case".

In find_mergeable_anon_vma() however, we check the anon_vma which will be
merged from, if it is set, then we check
list_is_singular(vma->anon_vma_chain).

So to match this logic, update is_mergeable_anon_vma() to perform this
scalability check on the VMA whose anon_vma we ultimately merge into.

This matches existing behaviour with forked VMAs, only we no longer wrongly
disallow ALL empty target merges.

So we both allow merge cases and ensure the scalability check is correctly
applied.

We may wish to revisit these lock scalability concerns at a later date and
ensure they are still valid.

Additionally, correct userland VMA tests which were mistakenly not
asserting these cases correctly previously to now correctly assert this,
and to ensure vmg->anon_vma state is always consistent to account for newly
introduced asserts.

Fixes: 965f55dea0e3 ("mmap: avoid merging cloned VMAs")
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/vma.c                |  81 +++++++++++++++++++++++---------
 tools/testing/vma/vma.c | 100 +++++++++++++++++++++-------------------
 2 files changed, 111 insertions(+), 70 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index 5cdc5612bfc1..5418eef3a852 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -57,6 +57,22 @@ struct mmap_state {
 		.state = VMA_MERGE_START,				\
 	}
 
+/*
+ * If, at any point, the VMA had unCoW'd mappings from parents, it will maintain
+ * more than one anon_vma_chain connecting it to more than one anon_vma. A merge
+ * would mean a wider range of folios sharing the root anon_vma lock, and thus
+ * potential lock contention, we do not wish to encourage merging such that this
+ * scales to a problem.
+ */
+static bool vma_had_uncowed_parents(struct vm_area_struct *vma)
+{
+	/*
+	 * The list_is_singular() test is to avoid merging VMA cloned from
+	 * parents. This can improve scalability caused by anon_vma lock.
+	 */
+	return vma && vma->anon_vma && !list_is_singular(&vma->anon_vma_chain);
+}
+
 static inline bool is_mergeable_vma(struct vma_merge_struct *vmg, bool merge_next)
 {
 	struct vm_area_struct *vma = merge_next ? vmg->next : vmg->prev;
@@ -82,24 +98,28 @@ static inline bool is_mergeable_vma(struct vma_merge_struct *vmg, bool merge_nex
 	return true;
 }
 
-static inline bool is_mergeable_anon_vma(struct anon_vma *anon_vma1,
-		 struct anon_vma *anon_vma2, struct vm_area_struct *vma)
+static bool is_mergeable_anon_vma(struct vma_merge_struct *vmg, bool merge_next)
 {
+	struct vm_area_struct *tgt = merge_next ? vmg->next : vmg->prev;
+	struct vm_area_struct *src = vmg->middle; /* exisitng merge case. */
+	struct anon_vma *tgt_anon = tgt->anon_vma;
+	struct anon_vma *src_anon = vmg->anon_vma;
+
 	/*
-	 * The list_is_singular() test is to avoid merging VMA cloned from
-	 * parents. This can improve scalability caused by anon_vma lock.
+	 * We _can_ have !src, vmg->anon_vma via copy_vma(). In this instance we
+	 * will remove the existing VMA's anon_vma's so there's no scalability
+	 * concerns.
 	 */
-	if ((!anon_vma1 || !anon_vma2) && (!vma ||
-		list_is_singular(&vma->anon_vma_chain)))
-		return true;
-	return anon_vma1 == anon_vma2;
-}
+	VM_WARN_ON(src && src_anon != src->anon_vma);
 
-/* Are the anon_vma's belonging to each VMA compatible with one another? */
-static inline bool are_anon_vmas_compatible(struct vm_area_struct *vma1,
-					    struct vm_area_struct *vma2)
-{
-	return is_mergeable_anon_vma(vma1->anon_vma, vma2->anon_vma, NULL);
+	/* Case 1 - we will dup_anon_vma() from src into tgt. */
+	if (!tgt_anon && src_anon)
+		return !vma_had_uncowed_parents(src);
+	/* Case 2 - we will simply use tgt's anon_vma. */
+	if (tgt_anon && !src_anon)
+		return !vma_had_uncowed_parents(tgt);
+	/* Case 3 - the anon_vma's are already shared. */
+	return src_anon == tgt_anon;
 }
 
 /*
@@ -164,7 +184,7 @@ static bool can_vma_merge_before(struct vma_merge_struct *vmg)
 	pgoff_t pglen = PHYS_PFN(vmg->end - vmg->start);
 
 	if (is_mergeable_vma(vmg, /* merge_next = */ true) &&
-	    is_mergeable_anon_vma(vmg->anon_vma, vmg->next->anon_vma, vmg->next)) {
+	    is_mergeable_anon_vma(vmg, /* merge_next = */ true)) {
 		if (vmg->next->vm_pgoff == vmg->pgoff + pglen)
 			return true;
 	}
@@ -184,7 +204,7 @@ static bool can_vma_merge_before(struct vma_merge_struct *vmg)
 static bool can_vma_merge_after(struct vma_merge_struct *vmg)
 {
 	if (is_mergeable_vma(vmg, /* merge_next = */ false) &&
-	    is_mergeable_anon_vma(vmg->anon_vma, vmg->prev->anon_vma, vmg->prev)) {
+	    is_mergeable_anon_vma(vmg, /* merge_next = */ false)) {
 		if (vmg->prev->vm_pgoff + vma_pages(vmg->prev) == vmg->pgoff)
 			return true;
 	}
@@ -400,8 +420,10 @@ static bool can_vma_merge_left(struct vma_merge_struct *vmg)
 static bool can_vma_merge_right(struct vma_merge_struct *vmg,
 				bool can_merge_left)
 {
-	if (!vmg->next || vmg->end != vmg->next->vm_start ||
-	    !can_vma_merge_before(vmg))
+	struct vm_area_struct *next = vmg->next;
+	struct vm_area_struct *prev;
+
+	if (!next || vmg->end != next->vm_start || !can_vma_merge_before(vmg))
 		return false;
 
 	if (!can_merge_left)
@@ -414,7 +436,9 @@ static bool can_vma_merge_right(struct vma_merge_struct *vmg,
 	 *
 	 * We therefore check this in addition to mergeability to either side.
 	 */
-	return are_anon_vmas_compatible(vmg->prev, vmg->next);
+	prev = vmg->prev;
+	return !prev->anon_vma || !next->anon_vma ||
+		prev->anon_vma == next->anon_vma;
 }
 
 /*
@@ -554,7 +578,9 @@ static int split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 }
 
 /*
- * dup_anon_vma() - Helper function to duplicate anon_vma
+ * dup_anon_vma() - Helper function to duplicate anon_vma on VMA merge in the
+ * instance that the destination VMA has no anon_vma but the source does.
+ *
  * @dst: The destination VMA
  * @src: The source VMA
  * @dup: Pointer to the destination VMA when successful.
@@ -565,9 +591,18 @@ static int dup_anon_vma(struct vm_area_struct *dst,
 			struct vm_area_struct *src, struct vm_area_struct **dup)
 {
 	/*
-	 * Easily overlooked: when mprotect shifts the boundary, make sure the
-	 * expanding vma has anon_vma set if the shrinking vma had, to cover any
-	 * anon pages imported.
+	 * There are three cases to consider for correctly propagating
+	 * anon_vma's on merge.
+	 *
+	 * The first is trivial - neither VMA has anon_vma, we need not do
+	 * anything.
+	 *
+	 * The second where both have anon_vma is also a no-op, as they must
+	 * then be the same, so there is simply nothing to copy.
+	 *
+	 * Here we cover the third - if the destination VMA has no anon_vma,
+	 * that is it is unfaulted, we need to ensure that the newly merged
+	 * range is referenced by the anon_vma's of the source.
 	 */
 	if (src->anon_vma && !dst->anon_vma) {
 		int ret;
diff --git a/tools/testing/vma/vma.c b/tools/testing/vma/vma.c
index 11f761769b5b..7cfd6e31db10 100644
--- a/tools/testing/vma/vma.c
+++ b/tools/testing/vma/vma.c
@@ -185,6 +185,15 @@ static void vmg_set_range(struct vma_merge_struct *vmg, unsigned long start,
 	vmg->__adjust_next_start = false;
 }
 
+/* Helper function to set both the VMG range and its anon_vma. */
+static void vmg_set_range_anon_vma(struct vma_merge_struct *vmg, unsigned long start,
+				   unsigned long end, pgoff_t pgoff, vm_flags_t flags,
+				   struct anon_vma *anon_vma)
+{
+	vmg_set_range(vmg, start, end, pgoff, flags);
+	vmg->anon_vma = anon_vma;
+}
+
 /*
  * Helper function to try to merge a new VMA.
  *
@@ -265,6 +274,22 @@ static void dummy_close(struct vm_area_struct *)
 {
 }
 
+static void __vma_set_dummy_anon_vma(struct vm_area_struct *vma,
+				     struct anon_vma_chain *avc,
+				     struct anon_vma *anon_vma)
+{
+	vma->anon_vma = anon_vma;
+	INIT_LIST_HEAD(&vma->anon_vma_chain);
+	list_add(&avc->same_vma, &vma->anon_vma_chain);
+	avc->anon_vma = vma->anon_vma;
+}
+
+static void vma_set_dummy_anon_vma(struct vm_area_struct *vma,
+				   struct anon_vma_chain *avc)
+{
+	__vma_set_dummy_anon_vma(vma, avc, &dummy_anon_vma);
+}
+
 static bool test_simple_merge(void)
 {
 	struct vm_area_struct *vma;
@@ -953,6 +978,7 @@ static bool test_merge_existing(void)
 	const struct vm_operations_struct vm_ops = {
 		.close = dummy_close,
 	};
+	struct anon_vma_chain avc = {};
 
 	/*
 	 * Merge right case - partial span.
@@ -968,10 +994,10 @@ static bool test_merge_existing(void)
 	vma->vm_ops = &vm_ops; /* This should have no impact. */
 	vma_next = alloc_and_link_vma(&mm, 0x6000, 0x9000, 6, flags);
 	vma_next->vm_ops = &vm_ops; /* This should have no impact. */
-	vmg_set_range(&vmg, 0x3000, 0x6000, 3, flags);
+	vmg_set_range_anon_vma(&vmg, 0x3000, 0x6000, 3, flags, &dummy_anon_vma);
 	vmg.middle = vma;
 	vmg.prev = vma;
-	vma->anon_vma = &dummy_anon_vma;
+	vma_set_dummy_anon_vma(vma, &avc);
 	ASSERT_EQ(merge_existing(&vmg), vma_next);
 	ASSERT_EQ(vmg.state, VMA_MERGE_SUCCESS);
 	ASSERT_EQ(vma_next->vm_start, 0x3000);
@@ -1001,9 +1027,9 @@ static bool test_merge_existing(void)
 	vma = alloc_and_link_vma(&mm, 0x2000, 0x6000, 2, flags);
 	vma_next = alloc_and_link_vma(&mm, 0x6000, 0x9000, 6, flags);
 	vma_next->vm_ops = &vm_ops; /* This should have no impact. */
-	vmg_set_range(&vmg, 0x2000, 0x6000, 2, flags);
+	vmg_set_range_anon_vma(&vmg, 0x2000, 0x6000, 2, flags, &dummy_anon_vma);
 	vmg.middle = vma;
-	vma->anon_vma = &dummy_anon_vma;
+	vma_set_dummy_anon_vma(vma, &avc);
 	ASSERT_EQ(merge_existing(&vmg), vma_next);
 	ASSERT_EQ(vmg.state, VMA_MERGE_SUCCESS);
 	ASSERT_EQ(vma_next->vm_start, 0x2000);
@@ -1030,11 +1056,10 @@ static bool test_merge_existing(void)
 	vma_prev->vm_ops = &vm_ops; /* This should have no impact. */
 	vma = alloc_and_link_vma(&mm, 0x3000, 0x7000, 3, flags);
 	vma->vm_ops = &vm_ops; /* This should have no impact. */
-	vmg_set_range(&vmg, 0x3000, 0x6000, 3, flags);
+	vmg_set_range_anon_vma(&vmg, 0x3000, 0x6000, 3, flags, &dummy_anon_vma);
 	vmg.prev = vma_prev;
 	vmg.middle = vma;
-	vma->anon_vma = &dummy_anon_vma;
-
+	vma_set_dummy_anon_vma(vma, &avc);
 	ASSERT_EQ(merge_existing(&vmg), vma_prev);
 	ASSERT_EQ(vmg.state, VMA_MERGE_SUCCESS);
 	ASSERT_EQ(vma_prev->vm_start, 0);
@@ -1064,10 +1089,10 @@ static bool test_merge_existing(void)
 	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, flags);
 	vma_prev->vm_ops = &vm_ops; /* This should have no impact. */
 	vma = alloc_and_link_vma(&mm, 0x3000, 0x7000, 3, flags);
-	vmg_set_range(&vmg, 0x3000, 0x7000, 3, flags);
+	vmg_set_range_anon_vma(&vmg, 0x3000, 0x7000, 3, flags, &dummy_anon_vma);
 	vmg.prev = vma_prev;
 	vmg.middle = vma;
-	vma->anon_vma = &dummy_anon_vma;
+	vma_set_dummy_anon_vma(vma, &avc);
 	ASSERT_EQ(merge_existing(&vmg), vma_prev);
 	ASSERT_EQ(vmg.state, VMA_MERGE_SUCCESS);
 	ASSERT_EQ(vma_prev->vm_start, 0);
@@ -1094,10 +1119,10 @@ static bool test_merge_existing(void)
 	vma_prev->vm_ops = &vm_ops; /* This should have no impact. */
 	vma = alloc_and_link_vma(&mm, 0x3000, 0x7000, 3, flags);
 	vma_next = alloc_and_link_vma(&mm, 0x7000, 0x9000, 7, flags);
-	vmg_set_range(&vmg, 0x3000, 0x7000, 3, flags);
+	vmg_set_range_anon_vma(&vmg, 0x3000, 0x7000, 3, flags, &dummy_anon_vma);
 	vmg.prev = vma_prev;
 	vmg.middle = vma;
-	vma->anon_vma = &dummy_anon_vma;
+	vma_set_dummy_anon_vma(vma, &avc);
 	ASSERT_EQ(merge_existing(&vmg), vma_prev);
 	ASSERT_EQ(vmg.state, VMA_MERGE_SUCCESS);
 	ASSERT_EQ(vma_prev->vm_start, 0);
@@ -1180,12 +1205,9 @@ static bool test_anon_vma_non_mergeable(void)
 		.mm = &mm,
 		.vmi = &vmi,
 	};
-	struct anon_vma_chain dummy_anon_vma_chain1 = {
-		.anon_vma = &dummy_anon_vma,
-	};
-	struct anon_vma_chain dummy_anon_vma_chain2 = {
-		.anon_vma = &dummy_anon_vma,
-	};
+	struct anon_vma_chain dummy_anon_vma_chain_1 = {};
+	struct anon_vma_chain dummy_anon_vma_chain_2 = {};
+	struct anon_vma dummy_anon_vma_2;
 
 	/*
 	 * In the case of modified VMA merge, merging both left and right VMAs
@@ -1209,24 +1231,11 @@ static bool test_anon_vma_non_mergeable(void)
 	 *
 	 * However, when prev is compared to next, the merge should fail.
 	 */
-
-	INIT_LIST_HEAD(&vma_prev->anon_vma_chain);
-	list_add(&dummy_anon_vma_chain1.same_vma, &vma_prev->anon_vma_chain);
-	ASSERT_TRUE(list_is_singular(&vma_prev->anon_vma_chain));
-	vma_prev->anon_vma = &dummy_anon_vma;
-	ASSERT_TRUE(is_mergeable_anon_vma(NULL, vma_prev->anon_vma, vma_prev));
-
-	INIT_LIST_HEAD(&vma_next->anon_vma_chain);
-	list_add(&dummy_anon_vma_chain2.same_vma, &vma_next->anon_vma_chain);
-	ASSERT_TRUE(list_is_singular(&vma_next->anon_vma_chain));
-	vma_next->anon_vma = (struct anon_vma *)2;
-	ASSERT_TRUE(is_mergeable_anon_vma(NULL, vma_next->anon_vma, vma_next));
-
-	ASSERT_FALSE(is_mergeable_anon_vma(vma_prev->anon_vma, vma_next->anon_vma, NULL));
-
-	vmg_set_range(&vmg, 0x3000, 0x7000, 3, flags);
+	vmg_set_range_anon_vma(&vmg, 0x3000, 0x7000, 3, flags, NULL);
 	vmg.prev = vma_prev;
 	vmg.middle = vma;
+	vma_set_dummy_anon_vma(vma_prev, &dummy_anon_vma_chain_1);
+	__vma_set_dummy_anon_vma(vma_next, &dummy_anon_vma_chain_2, &dummy_anon_vma_2);
 
 	ASSERT_EQ(merge_existing(&vmg), vma_prev);
 	ASSERT_EQ(vmg.state, VMA_MERGE_SUCCESS);
@@ -1253,17 +1262,12 @@ static bool test_anon_vma_non_mergeable(void)
 	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, flags);
 	vma_next = alloc_and_link_vma(&mm, 0x7000, 0x9000, 7, flags);
 
-	INIT_LIST_HEAD(&vma_prev->anon_vma_chain);
-	list_add(&dummy_anon_vma_chain1.same_vma, &vma_prev->anon_vma_chain);
-	vma_prev->anon_vma = (struct anon_vma *)1;
-
-	INIT_LIST_HEAD(&vma_next->anon_vma_chain);
-	list_add(&dummy_anon_vma_chain2.same_vma, &vma_next->anon_vma_chain);
-	vma_next->anon_vma = (struct anon_vma *)2;
-
-	vmg_set_range(&vmg, 0x3000, 0x7000, 3, flags);
+	vmg_set_range_anon_vma(&vmg, 0x3000, 0x7000, 3, flags, NULL);
 	vmg.prev = vma_prev;
+	vma_set_dummy_anon_vma(vma_prev, &dummy_anon_vma_chain_1);
+	__vma_set_dummy_anon_vma(vma_next, &dummy_anon_vma_chain_2, &dummy_anon_vma_2);
 
+	vmg.anon_vma = NULL;
 	ASSERT_EQ(merge_new(&vmg), vma_prev);
 	ASSERT_EQ(vmg.state, VMA_MERGE_SUCCESS);
 	ASSERT_EQ(vma_prev->vm_start, 0);
@@ -1363,8 +1367,8 @@ static bool test_dup_anon_vma(void)
 	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, flags);
 	vma = alloc_and_link_vma(&mm, 0x3000, 0x5000, 3, flags);
 	vma_next = alloc_and_link_vma(&mm, 0x5000, 0x8000, 5, flags);
-
-	vma->anon_vma = &dummy_anon_vma;
+	vmg.anon_vma = &dummy_anon_vma;
+	vma_set_dummy_anon_vma(vma, &dummy_anon_vma_chain);
 	vmg_set_range(&vmg, 0x3000, 0x5000, 3, flags);
 	vmg.prev = vma_prev;
 	vmg.middle = vma;
@@ -1392,7 +1396,7 @@ static bool test_dup_anon_vma(void)
 	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, flags);
 	vma = alloc_and_link_vma(&mm, 0x3000, 0x8000, 3, flags);
 
-	vma->anon_vma = &dummy_anon_vma;
+	vma_set_dummy_anon_vma(vma, &dummy_anon_vma_chain);
 	vmg_set_range(&vmg, 0x3000, 0x5000, 3, flags);
 	vmg.prev = vma_prev;
 	vmg.middle = vma;
@@ -1420,7 +1424,7 @@ static bool test_dup_anon_vma(void)
 	vma = alloc_and_link_vma(&mm, 0, 0x5000, 0, flags);
 	vma_next = alloc_and_link_vma(&mm, 0x5000, 0x8000, 5, flags);
 
-	vma->anon_vma = &dummy_anon_vma;
+	vma_set_dummy_anon_vma(vma, &dummy_anon_vma_chain);
 	vmg_set_range(&vmg, 0x3000, 0x5000, 3, flags);
 	vmg.prev = vma;
 	vmg.middle = vma;
@@ -1447,6 +1451,7 @@ static bool test_vmi_prealloc_fail(void)
 		.mm = &mm,
 		.vmi = &vmi,
 	};
+	struct anon_vma_chain avc = {};
 	struct vm_area_struct *vma_prev, *vma;
 
 	/*
@@ -1459,9 +1464,10 @@ static bool test_vmi_prealloc_fail(void)
 	vma = alloc_and_link_vma(&mm, 0x3000, 0x5000, 3, flags);
 	vma->anon_vma = &dummy_anon_vma;
 
-	vmg_set_range(&vmg, 0x3000, 0x5000, 3, flags);
+	vmg_set_range_anon_vma(&vmg, 0x3000, 0x5000, 3, flags, &dummy_anon_vma);
 	vmg.prev = vma_prev;
 	vmg.middle = vma;
+	vma_set_dummy_anon_vma(vma, &avc);
 
 	fail_prealloc = true;
 
-- 
2.48.1


