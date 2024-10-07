Return-Path: <linux-kernel+bounces-353685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9BD993128
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 17:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C28091F24725
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 15:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA69F1DA314;
	Mon,  7 Oct 2024 15:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Sq0VvAi1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cTB68Ymo"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1048F1DA0EB
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 15:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728314936; cv=fail; b=DxulaE4U9IvsBCStCis+MHyCatjt2AkqUvNLtlOs+PCRBQy/+hGHYoxyG1YodpDU3X5ifaBRbt4tnCza95Gquhk/fiFWQE3TA2q2zI6jwBmdF5rysRUmMciASaA1l8IRECvqahYNE5t8zuV0NwgWzOiOcSqFA9n3A+WaDyMVWh8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728314936; c=relaxed/simple;
	bh=QL8ECTDO07JfYiT+vQvwIigfhitywFIgxs5d0VSVTVc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=DhvZTwIyPYHDXgSGeQW4qIBdgDWjfq4JJpyjJ0/JqavSby8qKx7F4mSWCkHwuhPYrZwAGL6rfjLP2UYZ94KY1qHGPFlpZeChgQx7sw5LQ76MKzUUrBWctJZMklYELK/wWYdy046n7qrZOJgENPVNp6DDz7PP0HPUceG+GkoXFNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Sq0VvAi1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cTB68Ymo; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 497FMedK011699;
	Mon, 7 Oct 2024 15:28:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=/zxbCU6GPmDXB4tj
	+h1dr3ZabASn5EsgGWggxKqanFE=; b=Sq0VvAi1BY/jbwwLsCELi3odqDQ1vh+6
	E7fDD1XZHudzFvMqvFV6j+DqUKFsBLVde4MI1ctpdj5OPjHGjUA19j2+pYkjXkFt
	vnN17EYfJF20XmuNJEKDkTUp4WnxKAStwNaS6NrXMq4eo+l9fDk/YDJ61PmUkKZu
	JpmH9dZ7FRlwoc4poTe8p9Mrev2E1Wttrxe8cf1vEYapuLDKcS/jMf9PYbyHGFkR
	sq6btEdge0MOZ0HZmZJNidbWmqy8sV2LjFNIWuA3BV9Lq9iVa01KCeVTksNIgWsq
	CYT8h7ovG56XQqCPK0E4YcwbPP+CjBQwhMJgcwW/iJDg5/jx6eACbA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42302pbk8n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Oct 2024 15:28:41 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 497E4H9G012067;
	Mon, 7 Oct 2024 15:28:40 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 422uw5xugk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Oct 2024 15:28:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WGC5t2DJEidYFc+O1dbzgoSqfeS6zXlZ0nNpcTXtq2I//hSnDTHDl6LLvjt2f6pyXrRDnWcfHO2vuUkQG3/8MWpou1z4xoogjdVdbiQPjh6UOshEVsQATW4EzSdT5tBQwVbOslhp8RyM7Z7YRnRV4YZvlzWKoCGaDMY9yQ7JSuOFI/KQs4jrcjAnS5qe0aIn5tNgluzC4+P3h+/PBFQJ+N72clg1OrVUBt23TUcmq1FkyOBKFTJp91vWToxiWKMibczcskZ8OuHZHYKY5bheOLalZorKzIkAAx+zWm9VDeUrziHAtfcUSLf86kj1Bkr+ZaVK/dfa9nkblY2pIcCPXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/zxbCU6GPmDXB4tj+h1dr3ZabASn5EsgGWggxKqanFE=;
 b=JV2Fh7zjwGFso5GeOERqMGHq3t7dLLl1C9VkesmrshY8m1Ib7NUSIKBr8roXExTSZ0ZG8EYlXq/YN/r1QnoohrNk9c9N933WKhmYa40BGFdU8jWveBMHUDB31qviovdGzRt5XxB9LCRcqff3P9VZFLapTTJYztKUCIOLRJIKMR4ll5beZpOhN+i8JEdxS6Hj/NQmOmWVSqUpq/UqlMs0Tz8XKEZ2rZ9mPDr+MfsoRlg8TUeDrzu/hiIUiXD0gjnTPpoQx+S2IKB56PeEE2jNo/P2Dhx4/MIZIUl2zY+XzuEYUJ3mdaThPg40IQaVlywEfBFYYRz8t2ngkwt8RL7SJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/zxbCU6GPmDXB4tj+h1dr3ZabASn5EsgGWggxKqanFE=;
 b=cTB68YmoCEpTG0qVEvgce90HF5XhwbklcWh1VRu2t9uhVsr9jOHXd+FqJeV1icgYZjKWxXbqMuTB9srITkva3bLXHK48kXTsnnW0yZ2L9UYjnUfceOy9p/F0zQ9dVupQfQuPWe21pIGgutFueMfTaKKSfUIN9UkLsbBwdrTfB/I=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by SA1PR10MB6640.namprd10.prod.outlook.com (2603:10b6:806:2b6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Mon, 7 Oct
 2024 15:28:37 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 15:28:37 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Cc: Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Bert Karwatzki <spasswolf@web.de>,
        Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        maple-tree@lists.infradead.org
Subject: [PATCH hotfix 6.12 v3 0/2] maple_tree: correct tree corruption on spanning store
Date: Mon,  7 Oct 2024 16:28:31 +0100
Message-ID: <cover.1728314402.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.46.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0664.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:316::8) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|SA1PR10MB6640:EE_
X-MS-Office365-Filtering-Correlation-Id: 605f3b5a-198d-4763-ad55-08dce6e4b6e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wQVdR73xT+42/ucLF2m4Hs5xBqqaMOiI73uK7vQL/srmqBVVuZB6DreezDBM?=
 =?us-ascii?Q?LW+tanoR2vWangrhB+sQJ5rzQ3uhBa+y0mcYQDX5yCzdre3Gi6E2gLXEaIJe?=
 =?us-ascii?Q?7FOKnuZSHQD6Ct9RPwA5O9QGPQiKESIE/Fn/NadcyiJA8+U8dSBW0vdOLtLJ?=
 =?us-ascii?Q?C0/AGl5+KZiHKW5gG3qAielFy7KS67sRANBQuzst/tkSL3byB3zY+JfNrBxe?=
 =?us-ascii?Q?fEUQ+qU1HSWfK1h5S5vSHo8jv4Ldp3NySPTZN7dQGBQa87Ev6ueCBAdTMSGW?=
 =?us-ascii?Q?k4EDsDBiq8hjZicfyvFkayTV0XCQYLyGnGqQnqFNGlTuPvTNdNZ9X6YnAygu?=
 =?us-ascii?Q?TOcVSw5oQFbV5sNasPkP7c1P+3uc4IVicjbFYMUE3mvGHsOQ+Kgjyjp/DPnK?=
 =?us-ascii?Q?4zz6VkzbeZObj5diCgkSSjFEMAa7wKnw2TX1KzE0sPkIA8mIhm6ukybAlDKE?=
 =?us-ascii?Q?P6Bgf7VJzVDkQEmQG3LTT0Oy9/kR8hQiwwJq2RaELuMnwpeFmm67DbzyRaBc?=
 =?us-ascii?Q?Bsebhea1NpQ3/dWqej2SW4ZU2o2oD/L3kw2EqbwS62D8j2gA/SAl7IaPNtNN?=
 =?us-ascii?Q?H+48y8wKoKineeFGR+qpwwIhSDVEpihEpnI5NdFsMsR3g+/uNtXXCLXeEB7H?=
 =?us-ascii?Q?t8GiAJUXIBLbDNknShwfhurk4NWHJHbv2j7MSQX6I7F2lpglwQBFKfXcpeXS?=
 =?us-ascii?Q?NRQLMWOXsz9UuFGbDtF6++ijVyfllIuX6UUKLRLSKRylz4j/CQTFPp1YFapg?=
 =?us-ascii?Q?HZ2If5jA/kOYdnm4lFHgjZiDO0rqUun6owZfAyCK8dd+r/uf5PfVtN0J6QuW?=
 =?us-ascii?Q?nw1posMSqDSSIjUt4uaL2GMRI+zYhAJSztr1zhnrzZJzd+JCI/D/yNcPxb7J?=
 =?us-ascii?Q?OlYPgybZU4mzVMRGFF1Oy87QDkgU8ftbz2cBqCYt8mS8kaCBbQ1oild9qvgS?=
 =?us-ascii?Q?wf6L0LyoGAFxoKKYpXgSi/kyAzD9/OwTF9UvGB6M/+u5BnPwPowtN36k6tX2?=
 =?us-ascii?Q?TfDM+woEWSNSfxh5dX2t2/hK+n+uKF7tj+wQGeb5nNMNYPr+iHcyNOz64crf?=
 =?us-ascii?Q?YW53pBuyb3v/vCYD6g87N4+o/q4NEdKx4nP4hw0Xm0gw6Lmp8g0ORdmjOrGo?=
 =?us-ascii?Q?b2sGM56E7Rq/0txykVfCYCp2Z7xpEiFNHsuvlH+HIPvo6+MHSU8kn0lME7+K?=
 =?us-ascii?Q?gpo1oMz6nK8vhCt4fPoCjIca0wAXJXlKPr9xIbFVp/g1mX5KYqC/XvO8Qodh?=
 =?us-ascii?Q?rFjmlqRKxvhjDrMiWUt2AziAOU+8gnsdK14/t29B8W/8r8ifhwOrrpiq5uae?=
 =?us-ascii?Q?520=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZZt6fOWwP37kHcST4ANPqoiFoQ8CabDmGpQ0lD8KhDac6FYBRlywpTRFnLXU?=
 =?us-ascii?Q?ya/nhYOCoTESgpQZHF1hJvXsM5mOC435Y/0Pgs5aQ6FGxlQWe9wSlAqz5HAf?=
 =?us-ascii?Q?YWfLJAio935LVjlL8LPtM4jLLDqQbOJKIVjF7uaZs2VSBsJtzhQ222N87NZe?=
 =?us-ascii?Q?fDnQA66NAjYdaRZA1YZfrSeQdPm2m80QpeSqw5hwFVSaPr/Q5AETlLCZ753e?=
 =?us-ascii?Q?wvI1ORpWkqm8CnC5NzHSnd9lPiRVaTcM5k4G3MSyWI14aE6rcJUt119nXDmk?=
 =?us-ascii?Q?EzPOEU07aezvFMTPXrJzCRSRL5PkT3pYHyPdHULHh2BJ+tKTSCHIz6kGfTNA?=
 =?us-ascii?Q?yKmm5J3kwE/+gDKAbkS09PDop5YFubSpG/d8DzAoJeazu+iMIC6d8pqik8+F?=
 =?us-ascii?Q?xX0Xh5jAzmx3ZLklAwcFi3FkZzM1BhR6+ELFbbDJhfI+YFRpSv8ruBtvkyPi?=
 =?us-ascii?Q?n9i3LCJDsbQjd6Z9V/53Z+y62F05XqiBVXhNUGBX4biKTS8K6Ta+9XH4YhVl?=
 =?us-ascii?Q?//4A3LFMmIcKfeygxftEkG/ZXfRWoDVZBptTEu1nB9FobdaI2v+djq0e+tnQ?=
 =?us-ascii?Q?GLzhnLhM+HQKWUhVXA9ILv7hVaoF8SkVO1suHSeUC0TLeFzXMEIO/NwfoiO9?=
 =?us-ascii?Q?s2YW8TIS0G3OWPMF51s11WrFrLUdYFR05803mFIYNfXmoK9QmuvDVS8vIZdQ?=
 =?us-ascii?Q?8JEs8AHPbSVs2lI4JdaszLMtjqk8SBGpc/EqDnxvIyH9dOH2W5DutTPuP83C?=
 =?us-ascii?Q?lzA4VnE4H1M0LEmsrkGWYY2y8VJC4kLvj2XqHdbRLceGTx1uZtGyykrLl/ZP?=
 =?us-ascii?Q?3drWs2p1D80oF+K6NbcodY69B2cGzGgnqhZ5ZMjKkOtXa8J8q5uBwqcFu5i/?=
 =?us-ascii?Q?MCwHpQ7RHLsFMSTbRzplOw5TtcMGdxyk0HP/nkymQqlypsdIlEzEQHtZsi7U?=
 =?us-ascii?Q?UjeizHJbiT8BkfQWS91FSiyw7R1irkIykyT8Knqu38mWnTFFsVeKP0qQyMVQ?=
 =?us-ascii?Q?4wtGz5HeNVOUB/mfeOdY8glSgWsoM6MJXLoLCD/stbKlJD3tXjjiDSQgd1F/?=
 =?us-ascii?Q?sssKMM4lHWDVybLap9JdNnO9NWeUmrHV0AhX3yFBdnr61dqUR18Gfbn6oyQe?=
 =?us-ascii?Q?qepg/8p7Yhst/2xRgivjiYuLDlUAbJPcN3EgB1P7mgdnndgkY0JcAoWL8uTS?=
 =?us-ascii?Q?ohT/CX5sriQSgZ/lPdPNO30OJIoaYNA0iBfqRe/NV8SqpJcIvbUUktPoMcWZ?=
 =?us-ascii?Q?nZobvdwwoYpLf/Xdqm2u55Q6FC7/ox4uuKBFlPgJ3aywkii9VRPfzktMRQIq?=
 =?us-ascii?Q?xVlu+LIjpBKMPUx7PxywxeHxLjvhSUsruqzIj0XRruZ0qT/SXg00f4zRzBaM?=
 =?us-ascii?Q?40SENhfjLGSq56eq/w6P0ny58S06tul3qgJwAumtifC5Tzu5KjymTJ49FRAP?=
 =?us-ascii?Q?mV3CCtmrvGqOd8Ya2NTf8KvxXA+zfJZdQHzVIMWXIvQkhczTjjg5VDS7EQcd?=
 =?us-ascii?Q?+P/KZz/40MfSMm6Vajv5U9z+KWCLLActhChBreuZ3uR3JvSD+3zI3bI+u/pt?=
 =?us-ascii?Q?zAO4NzsC/kqcflLGgN7CZhdj5Yq9Pwfmkq5s9hKA7WfdjKVXid4DJzA1I45d?=
 =?us-ascii?Q?Gg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xpS92eJOvSEa6ggEOim9AjPZPk4s/qwv6249QBshmx9UJaoLlzhFjbbYVqqNI7zFYMF+u0l01vm/sqc8Obqag3jiBRpCJcQeb5FuDFwmi/JsQbprG7Mj0FYt4XWUOYCjJTwu4HIbnbZjWCNQVDKCKxqtgDb1C9CgC5g3QydRQWf3U1ybD9/GP/V/meTaUs0e5DgGwwplhypiseLrH1XAfWKccag+6h/2U8BzSyMxHm+o8h3Mtd/OYfWsl5Ntw2m/mqr2EARWkRqdMbJ6QIySy334W9dyWa5BPKxqUAh9oJ0i9c7BJTyfQ6CPQ93j/3o/FXHKnRFkM/h4U4bgzHjIPoFgfKuqLsdjz1tkBueCkj9bVdtgh/PvWcnzJ7hdOYd40lx3J2wLvtEKkvpUjVLdRxjHdqwxcAhc1EPcrJJF1MQzFs6g8wIHTKXrBOB4fi7utTNcQ+hJY5EMmEIM4929Qzo13DeBYkjfQgIazH4TElmMfjo2xKuT1gGq2cEc4eZHe1rmQfghN7nUZUal812KU+dTXRiW0MSFF//G3eRZBTHSjE3OngWoBClSM4ekZTB6bnosVwHL/QMzKwiwrizLNN4FNELY7p1xnuner+RyfTc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 605f3b5a-198d-4763-ad55-08dce6e4b6e3
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 15:28:37.5924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v8ROOeZDJKlC3DkrdvsPZ/Dd0Qc6zRkiBUyCI1R5RVAHpFhb9mCDJgEzqSndRRHJ37g0ti847x4bk+rBNYaG/Zykib3KJVWFIsGRe/n5niM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6640
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-07_08,2024-10-07_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 mlxscore=0 suspectscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410070109
X-Proofpoint-ORIG-GUID: ukZ5SeY8a9h4Pp6TbdIkBh03xPLSSC6U
X-Proofpoint-GUID: ukZ5SeY8a9h4Pp6TbdIkBh03xPLSSC6U

There has been a nasty yet subtle maple tree corruption bug that appears to
have been in existence since the inception of the algorithm.

This bug seems far more likely to happen since commit f8d112a4e657
("mm/mmap: avoid zeroing vma tree in mmap_region()"), which is the point at
which reports started to be submitted concerning this bug.

We were made definitely aware of the bug thanks to the kind efforts of Bert
Karwatzki who helped enormously in my being able to track this down and
identify the cause of it.

The bug arises when an attempt is made to perform a spanning store across
two leaf nodes, where the right leaf node is the rightmost child of the
shared parent, AND the store completely consumes the right-mode node.

This results in mas_wr_spanning_store() mitakenly duplicating the new and
existing entries at the maximum pivot within the range, and thus maple tree
corruption.

The fix patch corrects this by detecting this scenario and disallowing the
mistaken duplicate copy.

The fix patch commit message goes into great detail as to how this occurs.

This series also includes a test which reliably reproduces the issue, and
asserts that the fix works correctly.

Bert has kindly tested the fix and confirmed it resolved his issues. Also
Mikhail Gavrilov kindly reported what appears to be precisely the same bug,
which this fix should also resolve.

Please note - I am intentionally holding off on cc'ing stable until we've
had a chance to be satisfied the series has stabilised in 6.12 as this is a
highly subtle change.

v3:
* Significantly simplify the solution to a one-liner as suggested by Liam.
* Eliminate incorrect boolean return type in mas_wr_walk_index().

v2:
* Majorly improve clarity of commit message describing the problem.
* Add a reproducable test.
* Add missing maple tree mailing list to cc- list.
https://lore.kernel.org/linux-mm/cover.1728223996.git.lorenzo.stoakes@oracle.com/

v1:
https://lore.kernel.org/linux-mm/20241005064114.42770-1-lorenzo.stoakes@oracle.com/

Lorenzo Stoakes (2):
  maple_tree: correct tree corruption on spanning store
  maple_tree: add regression test for spanning store bug

 lib/maple_tree.c                 | 12 ++---
 tools/testing/radix-tree/maple.c | 84 ++++++++++++++++++++++++++++++++
 2 files changed, 90 insertions(+), 6 deletions(-)

--
2.46.2

