Return-Path: <linux-kernel+bounces-308009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB28965619
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 06:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 617B928859E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 04:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0415E14A615;
	Fri, 30 Aug 2024 04:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="U2Y7mpKM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nfuXuNF8"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127E114A612
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 04:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724990503; cv=fail; b=omF4DZScuimfAD4Qfzn5XggvjOF9eeRcHjQRGtIlECpzrDDhN/eKl+m7a5G6oD1ADvc71PFCVV3e6irCHAqQ3lk9jFTryi5aSXcgbuloII5rLACPmQ2DI+PghOxLOXxyJYJfu8pC6GqbNHvwZ15VWIYTxthsXApryDBufA32ru0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724990503; c=relaxed/simple;
	bh=QKx4HhIBl4QlOsXqRFDAYg/u+9WJfayKcgl7JZOCQQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Yy3zlvYsPAytHiTI15tlRYPXV84SGHSnos4959pDg2xYv2ODjlzmo6D43J1CZcVbsLilqTHA9jBMvcQbe4UsA4jqP4aBEZsUDhdAWUhT6gflHXlF4bn6RIUtyrjlpECYMDPZ+fgDBxzZFL3qLswnNO5YapDKZGAM9wV963HAJIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=U2Y7mpKM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nfuXuNF8; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47U3LAZj021755;
	Fri, 30 Aug 2024 04:01:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=vsjQKbisoOW0P4k2LKeId1n/RkQG3vYsFDDL6+Q3PXw=; b=
	U2Y7mpKMd537xJb9oT6mnpzgibrsfN4SYIGwqnGWcAnQJ7BORVptDcKFRObgWV64
	UZxPTtdJu5+JBZAcBN8Cue3SLffhieTyfOWggJbP+Xz+LViw4J75vrdEtPfxF4iI
	e3yQInMRNHY1pcUl0+ww7zIxs0IFgFKpaxBpPwxe1gf8mHpIvDfej3gKM3Tsve1N
	Oyp55CG0TNoSRBLqFBvUGCd87w0Xw0cUp74VzFSfNa/IR/xQaaGrWG9RNyxkF+fb
	YgXRZ2tKABze6C+0S7qPhiFoOM2QAfzbjrpi8qbV6B8LKIKuo5uXUG8iWCGN/rUe
	2DPpFb/K9jenLqHCexgP4w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41b3myr584-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 04:01:30 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47U3jJaQ036502;
	Fri, 30 Aug 2024 04:01:29 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4189jp2swm-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 04:01:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bs93jPt3EZL1CZpMLgt8GmqUt/XFNfiMBj7F1LPWMDXgwicuxVaBOaZ5y4RIRwaY3NE99MTnVwuVzjCMKlg2axV+Z37/STJVt7wUF5nXIFzcZUQyjhFZ+F4xzLtT0C6FIr38ZP1R8wnRgfYiU41vGEa86Qg8fl1pnf9S5UNF+hVjk9lIo0ERh36bjpJvJuXcMbhjnoYLjc7vRHlawxGPNkH1a2uh0M+oaDgPxthsoYwCYmgrDADNNJkdIxXl+k5bYgxwE2wD+FF7jXC1rnyfveYwMCo9n0lqO68YNafGGQeb8Xs8jO1ea9M23dmj5if0Ji1hH6nqB53IXiXmckdL6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vsjQKbisoOW0P4k2LKeId1n/RkQG3vYsFDDL6+Q3PXw=;
 b=KLsc26ZihzOrqt64jEpgVCa0/eXJdArnDrjjKaf5cwnuPTmoRfMWmI0SPsX2YcCLRvsZPGzstWys3m9W5GZSD8elYhfadRKTtPQcWOfAFAgO5VltC7K9jq0JeZ+74Iuvz0ob0QiPZrOrw7SSa+BmgqB9pMqWS0dFZBDFL1HkzVxGG8ldBAFY5vvVjkTMiLoXbc7yQOXGMK++fXSfebEGrZcOnzOnCZybs1Z66sZN5VRu/hbmcVU06CscHPa4p9z2YcEA5+xQchFT5wI7Sl30MwxEAEWxpHt2ivokMNzHvO+1rhMTHyrlWWQcJyV6buK+JJL3mWOZegfpr5z4Gd2Hhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vsjQKbisoOW0P4k2LKeId1n/RkQG3vYsFDDL6+Q3PXw=;
 b=nfuXuNF8m4LvfR0CEQ0R7tMugQVcoD4vHtlH/YypTmWMqXX7Z2rjJWr65IcWzmWff6f0rnBniOBJn8ZJQoeNlZMttWVS8AbjOighTiHVXaW2n2Dgf1l8WEtAglvLiC1FoY4mSSbzJ8WnlyMKweiUtHgPeMTF1nPywGU+OiQG6Rw=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CYXPR10MB7949.namprd10.prod.outlook.com (2603:10b6:930:e3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 04:01:26 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 04:01:26 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        sidhartha.kumar@oracle.com, Bert Karwatzki <spasswolf@web.de>,
        Jiri Olsa <olsajiri@gmail.com>, Kees Cook <kees@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Jeff Xu <jeffxu@chromium.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Subject: [PATCH v8 09/21] mm/vma: Expand mmap_region() munmap call
Date: Fri, 30 Aug 2024 00:00:49 -0400
Message-ID: <20240830040101.822209-10-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240830040101.822209-1-Liam.Howlett@oracle.com>
References: <20240830040101.822209-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0031.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fe::15) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CYXPR10MB7949:EE_
X-MS-Office365-Filtering-Correlation-Id: 673e0af9-989c-4eca-3669-08dcc8a86b8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?seQX4AvNOFIrr74URqOcTZ+ted0+W+rWotzL4qGFY56XSp+9tATcyl3vb+8n?=
 =?us-ascii?Q?dkNQXq9bzceHSx7arfjMSwnOC2rFWC0NJEBkzC3qlZTa8f3Inpz/MB7hG3sf?=
 =?us-ascii?Q?YHrjVMmoXC45Sc8am3RJw29h9mcRe1SNr/+5CY5OEcdjJGwZ+FAQcIhZBMRg?=
 =?us-ascii?Q?n0a35Npg7YDUUcFhkRNhD2x07wN7a7UWlxJzk5rIz2bCMNTFsSEj9dL5vHqY?=
 =?us-ascii?Q?FW9ysXHhaQ3Lvn4QlD1uZG+2u7HtlKMizbPcQRGhwHXe6XHaQCwOlS5oH5rG?=
 =?us-ascii?Q?SvR/cGO2CYJFzvJhvkBDed4VekaycfanS83Q1t1Q8JnzBPmo7M7YuVr3/5ZJ?=
 =?us-ascii?Q?VeIvkd1wVESlT827YCPxZiu97ij7e+kksQwKOy4EtTnE2ByeAg8y+so5gVl9?=
 =?us-ascii?Q?xGBQbNtorfqgrzGSCL/HTD9T3Y5lWCq4ZGtUA0FvHll/jO3St1KC4ZTdnnnw?=
 =?us-ascii?Q?1yb2WGgyVJhQ6uKnP/axMUMNWwelPp+CzpSMiWUumkXCI4TDJfSF3WMrfMrR?=
 =?us-ascii?Q?Iuit1kz21UWSNVru4bjENxiRsNmejC5/7TCSFzQa6XtgN+TM2gvfXWwQR4dg?=
 =?us-ascii?Q?c+zxVL/i3s6OVMmZ4dt0NwGYT0cGinYxsOJDrj2Y0s3cGeaeLwsFTNANE+xX?=
 =?us-ascii?Q?KDiqI2M6QwqN0BXPzRlqpAeIE2OHovHU65kwrfgIKM9lPTw1QyvZUcG6uhuG?=
 =?us-ascii?Q?9c1Q16tMuZ3PUpr/ZgDClQLkeq6Ki9dVLS6hv1d0x7Mjwsc5YP5QYbA+lIvv?=
 =?us-ascii?Q?exkqdUdDthIH7iBfj17sbHDsbGUXBExtwixUzNHNQAsBJUNqyJ5RbLfqEdjG?=
 =?us-ascii?Q?O5hZpPzahhvjmWCbZzb7Xe4u97lMBomFp2w+NVEGMx02EeoAHNFKqaGUpym3?=
 =?us-ascii?Q?64/TYbjib3V+LVm6x92Is4DN/xTqkTYPeH6f+DotU6bYn1HobtmZfPDqag6S?=
 =?us-ascii?Q?huIFFSh5oXd+OSsGqEL9oCaBM319Qx69B8xpQ+HGoni5FsihYQhnHgmfUcp5?=
 =?us-ascii?Q?TlI1mJXokDMwgerj1ctwZ6MP3ITHYsUTszPQkASv8f6FI01q8BXW0LYcPwk0?=
 =?us-ascii?Q?Xdo22jfQzyC5WXlfHp8SPadYqMyxSA0wSyNAlu25GSMi0x68pIdRXKvXsXiP?=
 =?us-ascii?Q?2S+xPISgPPACMQW57N33iAL5EfpaXMidnAk0A6yfxnmRCq/NhfyGujOpWR7Z?=
 =?us-ascii?Q?spGq7e6bUAf+nXBDEHXRB8vkpjLDU2hnEgOOjUDt2iCFmjCwu7cDcOmqECVQ?=
 =?us-ascii?Q?eu+zxhLz8e16wYBgAYNAWK/dhIPL+JHrrDnV6rlwmhWWgVSMCt15Lvy/xo0a?=
 =?us-ascii?Q?eIeCUoJMJlaF1Rvmc21gKksQZEO12Qu7cJKXrFbLxqAq3g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9X4fQ5KqYVIBWrf6k8sH9KLkHnf1eqE1QmjvsqPSzFylmACa2rSE+KEPGW1/?=
 =?us-ascii?Q?4KM99LCU1DgrJaFdj//phkFHeK0rGRJoUpECS5B5ryPe8601KlpKOnegozcx?=
 =?us-ascii?Q?4uZN5NQmfnzZRBu18RKXWfqFR8KCQDofxbqFoma2S2sJvvgJXwE9D682Twti?=
 =?us-ascii?Q?b9DGyFLIwx0BcqnRvYFhAgP/iSMaMfSbBOBRb0t8HmyGzUvMTsGyKeXtytSm?=
 =?us-ascii?Q?sQzD5dkxN3Xe/UxDO0Ah5bj0Q78Pcq/D7tsKI7EQXMLai0ApkqnG2od/KrSm?=
 =?us-ascii?Q?MwkuR1dM+vxQCa668WJyck7ZulZy3W3bIyzuEL5BJxE6lb7YLwgdEZUA4wHm?=
 =?us-ascii?Q?Ss186UMCko9jzScYxKpObyyjdq4W3TNr/LBeED8+sOiiZw6VQ1xFL0VI+Hge?=
 =?us-ascii?Q?9CH0HrdhRjEIgyiiQ92Y70n6eNOYjLvaYI2LXBstKVe+WqHqwXq1ZAL9/rsm?=
 =?us-ascii?Q?BVWnWe9Xb95Cks5bzyKcfmPDRFAg/QAUfUcRo3YsIK0KbhDsFIAWuN1LiKzB?=
 =?us-ascii?Q?fpEgeBT+9zIi8TMk9cNMF3LhOG+/vQTNg/TithtTzIzLXnVQVhsUQIB3B/ID?=
 =?us-ascii?Q?Pg92AXSfLMgzZ3x8antznFcU5KrdFVPja1CRIx8l4Y7UxVqN4Tesnr3D819V?=
 =?us-ascii?Q?TBkEG9crlcWpPlOnxh/lb2dOeicwbT4y5YgiCxulWOY3yR9sklYHNxcPbnRZ?=
 =?us-ascii?Q?nyx3Eh+SUDUApRisNOs/5fWy90mCmCmAmUKCAaI+fwremM3vjsOLfj4zqBqQ?=
 =?us-ascii?Q?sl07vQoSaDIkPhJ1VcORNFJO415nwO+cadYKc30SPT1G6aZ4zBAjdWUvKK5f?=
 =?us-ascii?Q?qZ8OEO4z7Zft7s0Vyeng1rlnA3s09qkzaiOWYFiLvZROdN7XB4vqm2rC90I/?=
 =?us-ascii?Q?l/FPn7TYuWyQoL+mo4qp9iNy9djnRp12WbQeTfmG6vhpiqj46aVxEUkqhTSL?=
 =?us-ascii?Q?i1PwVRknyx8FoFpXZUTTFFwfrHNcueLkn+7pZRGYHtk1T4Fbd6lG2w/gANpI?=
 =?us-ascii?Q?SClQkC9EzMWUb/HkCFvitVMxm6I1WrlF5v9izQv0WJJdQ8Oz4rD5pKIl4zLi?=
 =?us-ascii?Q?n3ZW/AoHyVRaIyiqw7lnDkokAYa17P06ET9ZwTGNT+Dmtq1yGf9J4rl/Eq1s?=
 =?us-ascii?Q?vunOZcqe/epT+YQVlekC7TyXXdGETif0t80cnBPY0O+QNmXIG4PXJf68cylP?=
 =?us-ascii?Q?QBG6MwdHFtN9Kqu/1FuDgZTikdsWRXU3KcrVdpqro/0uFuOKiI1lcwg4jGmd?=
 =?us-ascii?Q?mC25AnI7stZ5iqzndCJW/qzhBg5ReeZaY+tRwiQn0uW4CofNcM+h9uQCHu6C?=
 =?us-ascii?Q?5KiyAF7tLikNqOpik3mbY8nULr7CJ6q3DkIAGV0JC+JEz07sMUZI9ABk79xf?=
 =?us-ascii?Q?iGYooo/8mMDQIGp7Q3Wl8eiyR0ZgjVAMzbJCzVUn6pkZdtRTGKVyPhYl4j2r?=
 =?us-ascii?Q?cDAcjcYVr4wYQFOdzpsSCrR3zYLBIAskbqMhwX5PAhLEdUWIPuPMDi1aN9Dp?=
 =?us-ascii?Q?JmPDZYSc0Mynp8XZqnss+DnZEsat1P29+t8lf5WQP8bIl0Fs61hqx1h6rGO8?=
 =?us-ascii?Q?QjzzupP7H4Z5hqkI0UWAce6gVXJBDi2ML59+/NHSJF9sU8I949OAUwzeCv9w?=
 =?us-ascii?Q?+w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hoqyxFaG2G3gppmSwnVc36FkQI8xdP2fJ4cKnz2ZtxV1Q92WzlMMk08EByea9kTw/pDiJBFLgibAxYJLa1+6tNYXw4O2u9FjRb4NTpXqNHe8c/LK5jCBQ5uJtSAIyYlo43yuQI4k9MKl2el8IFSnKL1pPdOEoRqYLFfHTbYuCeau2HG0+Sj1WJJOhVR9RzfkCNNdktpNgQ6Kz1OZrwxwJ6OikN490yj4X0K4SyOyoc1ql5zjaDL7cfCcA8S5i3Xkqn+CopRIXlDAF4rZ7/C296YJKSiJBQSOVcN5uEqJnVkzr+D0tz0DKWv5Q5DdtSAk8SuXXowKvc7pN5FlXky4ogWu/1h9bmmhSKP9VB9yR5RdynWN4KJjhcjI2sdRpB7kMIBJ527joClIqv9HH2uueSU7O/gayZ/hd5mBpPxzMaRo737lQ97Eo5Kld9lUjfIWv6AjPZGhlA17hth+q2wzaC8mGdPIbtygzrd3iTc4RONq+YwJx0wVmbA4LLaVaAAUriI0Kebn/AzMzBiCKJXMCy3Jyu6Oc31Iq9QBxh12v1TDb354sz+fuyEuk9mG9ltpZEBvP4QouZ5vDJUhgC757dCMUZm15j/G+aw5w5ixz6E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 673e0af9-989c-4eca-3669-08dcc8a86b8f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 04:01:26.5250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WLBJIVcadzCbSxwWtXhY0ss82KDWT9nBj8KhNfI6dnF1aowHLo1+LV4fUrRYEAlzfA8XZ5Qxg+Mz2qQaMeqOpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR10MB7949
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_02,2024-08-29_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408300028
X-Proofpoint-GUID: SYqKMsUtNBMT5GYaueVV1M8pjl14X6g3
X-Proofpoint-ORIG-GUID: SYqKMsUtNBMT5GYaueVV1M8pjl14X6g3

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Open code the do_vmi_align_munmap() call so that it can be broken up
later in the series.

This requires exposing a few more vma operations.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/mmap.c | 26 ++++++++++++++++++++++----
 mm/vma.c  | 31 ++-----------------------------
 mm/vma.h  | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 57 insertions(+), 33 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index ec72f05b05f2..84cb4b1df4a2 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1366,6 +1366,9 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	struct vm_area_struct *next, *prev, *merge;
 	pgoff_t pglen = len >> PAGE_SHIFT;
 	unsigned long charged = 0;
+	struct vma_munmap_struct vms;
+	struct ma_state mas_detach;
+	struct maple_tree mt_detach;
 	unsigned long end = addr + len;
 	unsigned long merge_start = addr, merge_end = end;
 	bool writable_file_mapping = false;
@@ -1391,11 +1394,28 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	/* Find the first overlapping VMA */
 	vma = vma_find(&vmi, end);
 	if (vma) {
-		/* Unmap any existing mapping in the area */
-		error = do_vmi_align_munmap(&vmi, vma, mm, addr, end, uf, false);
+		mt_init_flags(&mt_detach, vmi.mas.tree->ma_flags & MT_FLAGS_LOCK_MASK);
+		mt_on_stack(mt_detach);
+		mas_init(&mas_detach, &mt_detach, /* addr = */ 0);
+		init_vma_munmap(&vms, &vmi, vma, addr, end, uf, /* unlock = */ false);
+		/* Prepare to unmap any existing mapping in the area */
+		error = vms_gather_munmap_vmas(&vms, &mas_detach);
 		if (error)
 			return error;
+
+		/* Remove any existing mappings from the vma tree */
+		if (vma_iter_clear_gfp(&vmi, addr, end, GFP_KERNEL))
+			return -ENOMEM;
+
+		/* Unmap any existing mapping in the area */
+		vms_complete_munmap_vmas(&vms, &mas_detach);
+		next = vms.next;
+		prev = vms.prev;
+		vma_prev(&vmi);
 		vma = NULL;
+	} else {
+		next = vma_next(&vmi);
+		prev = vma_prev(&vmi);
 	}
 
 	/*
@@ -1408,8 +1428,6 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		vm_flags |= VM_ACCOUNT;
 	}
 
-	next = vma_next(&vmi);
-	prev = vma_prev(&vmi);
 	if (vm_flags & VM_SPECIAL) {
 		if (prev)
 			vma_iter_next_range(&vmi);
diff --git a/mm/vma.c b/mm/vma.c
index 4e08c1654bdd..fc425eb34bf7 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -80,33 +80,6 @@ static void init_multi_vma_prep(struct vma_prepare *vp,
 
 }
 
-/*
- * init_vma_munmap() - Initializer wrapper for vma_munmap_struct
- * @vms: The vma munmap struct
- * @vmi: The vma iterator
- * @vma: The first vm_area_struct to munmap
- * @start: The aligned start address to munmap
- * @end: The aligned end address to munmap
- * @uf: The userfaultfd list_head
- * @unlock: Unlock after the operation.  Only unlocked on success
- */
-static inline void init_vma_munmap(struct vma_munmap_struct *vms,
-		struct vma_iterator *vmi, struct vm_area_struct *vma,
-		unsigned long start, unsigned long end, struct list_head *uf,
-		bool unlock)
-{
-	vms->vmi = vmi;
-	vms->vma = vma;
-	vms->mm = vma->vm_mm;
-	vms->start = start;
-	vms->end = end;
-	vms->unlock = unlock;
-	vms->uf = uf;
-	vms->vma_count = 0;
-	vms->nr_pages = vms->locked_vm = vms->nr_accounted = 0;
-	vms->exec_vm = vms->stack_vm = vms->data_vm = 0;
-}
-
 /*
  * Return true if we can merge this (vm_flags,anon_vma,file,vm_pgoff)
  * in front of (at a lower virtual address and file offset than) the vma.
@@ -698,7 +671,7 @@ static inline void abort_munmap_vmas(struct ma_state *mas_detach)
  * used for the munmap() and may downgrade the lock - if requested.  Everything
  * needed to be done once the vma maple tree is updated.
  */
-static void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
+void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
 		struct ma_state *mas_detach)
 {
 	struct vm_area_struct *vma;
@@ -752,7 +725,7 @@ static void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
  *
  * Return: 0 on success, -EPERM on mseal vmas, -ENOMEM otherwise
  */
-static int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
+int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 		struct ma_state *mas_detach)
 {
 	struct vm_area_struct *next = NULL;
diff --git a/mm/vma.h b/mm/vma.h
index cbf55e0e0c4f..e78b24d1cf83 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -78,6 +78,39 @@ int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
 int vma_shrink(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	       unsigned long start, unsigned long end, pgoff_t pgoff);
 
+/*
+ * init_vma_munmap() - Initializer wrapper for vma_munmap_struct
+ * @vms: The vma munmap struct
+ * @vmi: The vma iterator
+ * @vma: The first vm_area_struct to munmap
+ * @start: The aligned start address to munmap
+ * @end: The aligned end address to munmap
+ * @uf: The userfaultfd list_head
+ * @unlock: Unlock after the operation.  Only unlocked on success
+ */
+static inline void init_vma_munmap(struct vma_munmap_struct *vms,
+		struct vma_iterator *vmi, struct vm_area_struct *vma,
+		unsigned long start, unsigned long end, struct list_head *uf,
+		bool unlock)
+{
+	vms->vmi = vmi;
+	vms->vma = vma;
+	vms->mm = vma->vm_mm;
+	vms->start = start;
+	vms->end = end;
+	vms->unlock = unlock;
+	vms->uf = uf;
+	vms->vma_count = 0;
+	vms->nr_pages = vms->locked_vm = vms->nr_accounted = 0;
+	vms->exec_vm = vms->stack_vm = vms->data_vm = 0;
+}
+
+int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
+		struct ma_state *mas_detach);
+
+void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
+		struct ma_state *mas_detach);
+
 int
 do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		    struct mm_struct *mm, unsigned long start,
-- 
2.43.0


