Return-Path: <linux-kernel+bounces-409941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3E09C93CC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 22:06:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10E331F22F66
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 21:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8E11ADFFE;
	Thu, 14 Nov 2024 21:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="roLFBEni";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="feb7Dc6e"
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0571718B484
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 21:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.151.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731618386; cv=fail; b=Nwtcio4zpa4k9+0ZwoVef9z2L+z6XpMS5O6mdudcx0gsdBPIcw3J453aEyZu5cdz+1DYzoDvzZYfRBmK25u5Uf3fCnZvzOr1oIpIktvdzpVYNJ+x/VzySmZnD5nv6zJRHd8hYNTHcbbuj8l/NHemo9pyg8e49OrOriKj2Iuy5jM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731618386; c=relaxed/simple;
	bh=s+d5l600UMq2pQu9tDYN5SUyTofv8GPoSifj8m5nASY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=c5yfhCQd43f0PSTF/IKx1y/Mmp5mjva6Stiv5MsbQLWyY5eehHogU23LHm8Glzv6RDFTCAr54GrEtZS6MoH0djBJLc7BUZmt6CPP4psp5ooEr6Eym2s+LDKv/KSsstYpPv9pkfM2tvNI+DcB1Ck/HcsGJLXNEjT8hz6GjUSuNvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=roLFBEni; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=feb7Dc6e; arc=fail smtp.client-ip=148.163.151.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
	by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AEJ8eOC014456;
	Thu, 14 Nov 2024 12:47:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint20171006; bh=DD1RlrFJXdYE1
	uGo79GGaXovGI9Xm2ksLJ+CFStTosM=; b=roLFBEniWpgcXNhFmEZa/tK2d3d1K
	ZlhSZ98V8p2mnqkYp2vU+XgFUabS2w5XigyYiU1le0CcTXlxx6ffA8kTc0nXfSMy
	gFvVi82tZjasrNkBOSbhn5eL/QW3NqlGmH85DMdX4rUUpDHJSe33boGsVSIBiXZa
	vpsqAljcnFeRY8k+gL4zwIWwZ/XLdZWs7JA8K2ee/ETFD4FxO+z2eBZyP0Cyb3fn
	vkDFcRDBk1A4GqPeS5fHNG+Ls+XspX0BxAyCtXF2w2Nhf0fqi1yMWwhv8ybybN0m
	WSEo/PDVcb5xKs8WVD4pTLIlz5UAKTUXejhRfZ83ThoNbQ4Ai8Gzzs0Tg==
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azlp17011028.outbound.protection.outlook.com [40.93.12.28])
	by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 42t8635uf2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Nov 2024 12:47:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I1EgPpdY98x7GlQ95rRlSXv7WSiwzXEpjZ+vpBjn/0J7IjASbNKC4F9mndjvoxotpk+dhj3bMk5zHVBQB0jnH+g8bATNFFojbX4dl/Y3U4FX6yUgZ7zJJ09uEgmUo2Q5A0BfoeVFu55P/OL5wxmjZjhOe3Bi+Wl0eYAORDYTJl0CrgHWUtL3shceK3JIC44S0I2ed+CCl4glLyVDuRWYu3+t3OeavYUfFwtNESAjsHMAcsSeTs2P/8SSe8TqK/7acNJcPVumt44DPkzaXCQw5QFoAPMJcn4neLY3P5duPp/8MyIGuqhngl8SqLSpModVhR0/1rG50y0aQVTrmDz5Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DD1RlrFJXdYE1uGo79GGaXovGI9Xm2ksLJ+CFStTosM=;
 b=gXSuMvcr6/vJ3fl3LHANnstlCrzRBYlBY+Gs+JOvazN8ebw6j8sPPfOo3W/r/pq7bwzOFZvpjOJQrUJ/P5r0TI+G8oNLExyTH82QAmHY5n/kI9xJklnU9fjkFDV9cCGdUGbHK0kTzq+8GRApvtWeKx8ZCYTPzy7SNDzL3ndPnpLmL09qSxQoNQplo6LTE1fZ7Xg1VB/TDFInmsKuWN0JZoiOPfwV1hNjUXGAfS37Fvi01HNsBPZRIS+Ix+s26tVO07cvV+YnFS4wJ9CwVlg36Q7vOdt7DN/VOk+MjqhYlEzJ4PTwGydd0JL4H4gWICPg7ARve7UlEN9L5elVKlgfcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DD1RlrFJXdYE1uGo79GGaXovGI9Xm2ksLJ+CFStTosM=;
 b=feb7Dc6e4CSb9uPc1KBhB6AKnJd3nNm7WQs+nk13AZ76CuFocPGmUvq3XnyTK5xaunYBg9gzxBxFcGUeSQmU6faMSVSv8LeNCsbDxsYG6GXTrzVWW6+zLK0ETpdQSDk0idYu9qt7tBl8QQ5yEGiYAoVgkx+X7GcnDc8GryyTzWnL7rAcuIAeZ0pkxvvPJN088y2w1Xz0J+ZewivjnCOcby8qAhFXqPfJDloBfBgn5zAiq5mOTZkIVVBMvbiOKW1GnlqMzd+2eYdEm5fr9Mqpj6oR4th35xqHs2ORzQZw8CmxkQfCsfDBgwEK4g7bH2qGJoYwbhaWtksg39fJ+7CNcA==
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 (2603:10b6:408:1fa::10) by PH0PR02MB8405.namprd02.prod.outlook.com
 (2603:10b6:510:107::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Thu, 14 Nov
 2024 20:47:52 +0000
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054]) by LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054%4]) with mapi id 15.20.8137.027; Thu, 14 Nov 2024
 20:47:52 +0000
From: Jon Kohler <jon@nutanix.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org
Cc: Harshit Agarwal <harshit@nutanix.com>, Phil Auld <pauld@redhat.com>,
        Jon Kohler <jon@nutanix.com>
Subject: [PATCH v2] sched: add READ_ONCE to task_on_rq_queued
Date: Thu, 14 Nov 2024 14:08:11 -0700
Message-ID: <20241114210812.1836587-1-jon@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0136.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::21) To LV8PR02MB10287.namprd02.prod.outlook.com
 (2603:10b6:408:1fa::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR02MB10287:EE_|PH0PR02MB8405:EE_
X-MS-Office365-Filtering-Correlation-Id: 2045b4cc-66af-4a64-b2ae-08dd04ed9b97
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5Zb+Eqa0HI/yACUoUslvzzgyknsOFfXiRk0BHsCvsZZI9qZLtDboXH/w3XYU?=
 =?us-ascii?Q?UOzZNP/za0hVjYTPzzCCdP4dejtG4X2EUMHzGRD2SR5KnRPmizlpls5ywdeO?=
 =?us-ascii?Q?l1xzhOlQwonEM+Y9MXF61dg6cFSQguIcaZFgoXiO5SZF27droAlaQdDgcW6y?=
 =?us-ascii?Q?O3DzyhpyhAJMrwY4nYJ6/i5ntFhJeYoMn/tUo43rnLjuLAUCnM+Mbz1PuKxV?=
 =?us-ascii?Q?AnAGi8CbxdMosxTCq9N8RFKJhyVbEZciqU+yTNPqX+Z3VqkVIy59VCcWQGMi?=
 =?us-ascii?Q?/7OHJiOvYsuN7xAs8GUw8i08ahS4MCfoAz13G2S38gUzwPJs2m0M9b8BJ88p?=
 =?us-ascii?Q?VYnp4NfQGJnJDOTMQ/ukZV6bzNuUvJ53XB6Bk8sMYpHsSQhf+TRZo4rVYiDb?=
 =?us-ascii?Q?lJno70BB65tDPgeMTKqHeEvQ57c1hVvJP+WedbzrWbOMIZjkU34hKcIuX88o?=
 =?us-ascii?Q?zzmLlPUdfkUcieDFkKXNxFzcYy3XCigruUbMCVYtXhRIqmZ/GwTRoxm5UFCA?=
 =?us-ascii?Q?PNnG1Gfdju4pN4j6iNRVNbK77JN3d7WItXBklsbLwzWkeTLCiSrCMiHIl9Cw?=
 =?us-ascii?Q?P9gBT25T5s0gv+M3njkha+yeI7C/YQBgX5ZIxhaR1ly7g/l5sp4Qz5JA7V0H?=
 =?us-ascii?Q?RCgSAi28S7T2/VtE5GZ8nd6pF6TR4tuRgVGAE/C+dJ6RZTVS4UaScYxiwB1R?=
 =?us-ascii?Q?VYlRbhchfj+UheVGFcH5JVW4AQUXrZK7Ipt8UBLXJygvHFAxBRjmy1EsN+tO?=
 =?us-ascii?Q?DBrynA6LFT+EDa7Ru9p+iNs8uTuwTTt+w970qYGddJg/PYJlktFQAOTnq8ZB?=
 =?us-ascii?Q?4mM6Cauxa6Jil53ZwwPcoJmnM3eOw+fNt5wVttgkxhR3Z9Kbm0XSozYUFUFd?=
 =?us-ascii?Q?FxqENWAXOtBidUNAKwekKAd4zd2/HAp68S0h4iFqM+VnyTmbVKbLAXBirdHA?=
 =?us-ascii?Q?4r4fYR8FH6Yq7q3z9Yz5pqoV7PVJpIvngBjjVPIGQqfr9fLCbqphIwLbI8BK?=
 =?us-ascii?Q?otaUmGxZkoVr6WjGIbbRIU4eGNXON9RxywU2PxKq9DbsiuwlL7+8VJMkBiCt?=
 =?us-ascii?Q?qZ9ZS0wmDnkr5I3ZuykYuySccpsbBmEGqdbKF2XVfq/GTPI87ENzGinsJ9nO?=
 =?us-ascii?Q?SnIQUyD+tZDa9Pnr5v0To7MaYr7FQ4UYMagagHq8mAHJjDZN5d/F6KIfFOn5?=
 =?us-ascii?Q?d057M4vAyzYWHeXTVJxXNN/33JalN6TraCgUZ2vN713zJwnxvNgW0jIKbb5Y?=
 =?us-ascii?Q?8v7vrnxDMEorWzsOOuXthB7uD5E6WGqoX3aCWCouj1Am8C4Ch0zS3bC28mZq?=
 =?us-ascii?Q?iLqpKVJELFTg8UglcIoru/WnDLSYXSeRilU0by2mo/NcKqFNZj2LMRGbp+/e?=
 =?us-ascii?Q?bE2IoqXuJ966yhBkPWzWUE+tonz2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR02MB10287.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?++ZKzhhaKf4NB1SAC2QiS+PRJENg1+MbJiQqk9Lxou3iIm5t5CDj4WeuJyz+?=
 =?us-ascii?Q?jk8ybxR+Tl8PgrH+ELTiSedo9VbW5oRhIvbd4VGEzpBB+R0fRfCtPa6G6uQK?=
 =?us-ascii?Q?MMx5oiUU0PJp84kvz8NmPG14v5kvKwVhuzp7l4WMD1Dotq5dcptp8Zik0Vl7?=
 =?us-ascii?Q?IW/u000NO3sYCGGXkq71TixfJxZ4GdSWLh66iTCuBPRnog18goyzg2D4vUoj?=
 =?us-ascii?Q?tdmbyzheYgRXiPhv88ozDWo+BxaEP4qX9ZLVR8dU2wbTST+kceEVu+Aj6+09?=
 =?us-ascii?Q?1u1o+jMj7hAHsSW0aqU6uNLHGh33oBH6KaOVtSNB9COV5SyKAIBRhaVCEr8u?=
 =?us-ascii?Q?qo+wAzFX8mgVQrZ9wVK91HAv9OIYuLGyWNmlHRsfkEhQHlef5bMnlckx+e8H?=
 =?us-ascii?Q?57e1g2pQ1lqw3CKJbD8mdW2ItAKI5RYH8q9VYdXwpqqKPw2FATJI/vJDG/Lz?=
 =?us-ascii?Q?7SG0HUUCIm233MvVkaRoBs2/BaAPQM2br/fIFk/r/4JlArI3H7UffGd+cJOA?=
 =?us-ascii?Q?dU394Qef+SEYywciDB0PTwZPGdVA+NrtllE0RyC2icG4i+IDEdzp77xCk4Yi?=
 =?us-ascii?Q?hZDZOr1pRaAnfyKpJ7s3+E5wJ4OP5qyKWgh2iofV7lTEGji8wWcyz6nlBTBX?=
 =?us-ascii?Q?IYHNcaZ5GVgW9dV2QHn3VTfomcKoQOHulk8WuHU8DYsJm6MBTnsmi4O7xESW?=
 =?us-ascii?Q?phJlyEiQChP+i9T+jacRn9CBzsy9mbJ4RDlqETuoQ4iGvCCPtJVnXLNnu9Sy?=
 =?us-ascii?Q?ZnR7RjYpolzFpwCIRed+2RGh838BBk4ienCWyvPw9C4BgcI1s1uLZFMZFflg?=
 =?us-ascii?Q?FfqHzsDnlAhX4ZI2bcqA4ZOuf5SDqL16l5vQmXrP/7jMfrNGehIjxZXGdHLU?=
 =?us-ascii?Q?V5Yx+VLiNHbVRH8CdfOzOH2WPzVgXZ6ru7hSourjxUP1zU031LNAkdIOcf5a?=
 =?us-ascii?Q?9p0M1opw+T+wFR4Ktew0e30kVTdq27RCv0yOJ67AmLwQmOXaDkKRVIDwg/4Q?=
 =?us-ascii?Q?p1emK8w6m+gRRGzxk4BDQNap10hVA/siiR+U6cIO8BGBXrUXDqphUMMOjfKs?=
 =?us-ascii?Q?JM630CTFV/1qzbyZSV7ohPjsd8nBaKug/7Ouwmh7ZHMjAyMjcoFud2fzcXuf?=
 =?us-ascii?Q?728WZ33uBrbMeYp+JEy9V/+qw6vXNCuuZhs4jhPk8n3z1pT1phXFJ5/gsEP0?=
 =?us-ascii?Q?M05OUktHNfxMxMAetATaoaAcTzNFHcU/subNXgwARzKImn7dCYejwN1R/9nq?=
 =?us-ascii?Q?mCcbNvQN9EzMzLu2X35A+mH6BBz6C/cCefO5fsiYXD+DqoeZjm9Ki690n9dX?=
 =?us-ascii?Q?iiXagH3kDNi1khMlgX/+UgDck3Wi0R0BV12mqFFRYMLswCT5RdgOdeG1jAci?=
 =?us-ascii?Q?LEGppFaiEBjijFt5ccyoMapzVI5/tFnjSUudtkHRajtJ61zNCfd/8/gslIHT?=
 =?us-ascii?Q?zLJkKBgSzp6VVvu3tB7+sTMbI5Whq2OyYte4MNyd5NRIPQzY16R4lg6rxBSN?=
 =?us-ascii?Q?3Sxrn5S4FuNtwUtsXbfaIyT6uk/8p9jmc/+VebSk+bFy1JivOrsW8yxFhvVG?=
 =?us-ascii?Q?rll+oOQrzumjuQaNWPKr4HZXpXWDbWSw7nFc5ESfSIirYcCSPqRSUTdEwcVd?=
 =?us-ascii?Q?bg=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2045b4cc-66af-4a64-b2ae-08dd04ed9b97
X-MS-Exchange-CrossTenant-AuthSource: LV8PR02MB10287.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 20:47:52.3480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ePdYt99NsSZhJyHFnsSEZVi3dKkU8XTCJLpDUXZCTLRogT9jATUWoBfH9D4e2zrBV/2bXEGzGcz99jH8vb7XHEHRy4rs81cPwRB92AfD4Ik=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8405
X-Authority-Analysis: v=2.4 cv=EMRU0EZC c=1 sm=1 tr=0 ts=673661fa cx=c_pps a=WlqDjRht0D+wB3AL0MAriA==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=VlfZXiiP6vEA:10 a=0034W8JfsZAA:10 a=0kUYKlekyDsA:10
 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8 a=MZS4hmKXz2L-7tdKGUUA:9 a=14NRyaPF5x3gF6G45PvQ:22
X-Proofpoint-GUID: G81C79eo_cbjqHZEOCqzXlN27QpSpta7
X-Proofpoint-ORIG-GUID: G81C79eo_cbjqHZEOCqzXlN27QpSpta7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_05,2024-11-13_01,2024-09-30_01
X-Proofpoint-Spam-Reason: safe

From: Harshit Agarwal <harshit@nutanix.com>

task_on_rq_queued read p->on_rq without READ_ONCE, though p->on_rq is
set with WRITE_ONCE in {activate|deactivate}_task and smp_store_release
in __block_task, and also read with READ_ONCE in task_on_rq_migrating.

Make all of these accesses pair together by adding READ_ONCE in the
task_on_rq_queued.

Signed-off-by: Harshit Agarwal <harshit@nutanix.com>
Reviewed-by: Phil Auld <pauld@redhat.com>
Cc: Jon Kohler <jon@nutanix.com>
---
 kernel/sched/sched.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index c03b3d7b320e..dbbe5ce0dd96 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2277,7 +2277,7 @@ static inline int task_on_cpu(struct rq *rq, struct task_struct *p)
 
 static inline int task_on_rq_queued(struct task_struct *p)
 {
-	return p->on_rq == TASK_ON_RQ_QUEUED;
+	return READ_ONCE(p->on_rq) == TASK_ON_RQ_QUEUED;
 }
 
 static inline int task_on_rq_migrating(struct task_struct *p)
-- 
2.43.0


