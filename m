Return-Path: <linux-kernel+bounces-372157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B59C9A4527
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 19:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 986D91C2213C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 17:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F448204F64;
	Fri, 18 Oct 2024 17:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aYk/SlYf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wfq3DC/2"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396B920409E
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 17:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729273307; cv=fail; b=LGzTeLdqt1Q7cFC9TIrbdYxbSfGgM+oagoYT9ACO4QJJXXIMUUOZcvcQyLd9Hx28poPjrQkKuLepdrI1H5Q8PxELuqwzS2JFq76jso1hhMYKPpHW5/EAYtxZWWgCLUcY1rLeC53bhIUmxSLZnslUZThD8u9kBC9SEVqDfnPiA8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729273307; c=relaxed/simple;
	bh=zJ/dEb+vB8Sun1bezP4YlNhGW8j/YO2seLgDynS57i0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=JMXwixubcNjXA+rbCM6ax6RaTJYZRLI+5BQ5dzn0rV7pdgWK9obKIUAXC1vjjAXtSjvABjxnvifheMvjXFrlOe5EwWG4R1IL9xrC1rSwu4XL1362zegyLKAoX67sZpP3sZJafBixMSlRtYZPScoo6Zd6wS91VEz/p0gcCaSWsD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aYk/SlYf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wfq3DC/2; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49IEBg3s022575;
	Fri, 18 Oct 2024 17:41:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=tf0IaB232j/iYgc5
	Kw4DJ/6mPt3+Sd9Q0LX4sTxWpus=; b=aYk/SlYfbJIR1p9wVG25kbvS2+00F2+l
	FHzMMO5kYqBbaj65wTBswA3AbGQOBoKDM+LoR1D0Juui0xrYJqvk9oHKrykhKRGQ
	UfXx1izmM60QDJ8HYtdSgjeqKDNxs0J0Nw/Y3u0SLBQkdo4kaUGWYw9C2oJ1vb7A
	IkYQooYluCvm0sIKnGJJbxcodGixJ+Z1zBBeGwvYFBB2z3U2qLskc058DSx8iOeB
	W2BLPaSHZNKmM31/EqppLGxpx46XI/76oFWCe5AmsAjaY24n4FxW0WwuOcLLftRp
	Y4GYOS41XhjGEcABwOZuDqsI6JUTtoassei607RwgjVJntxzX9z9OA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427fw2shj6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 17:41:22 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49IGMPTQ019304;
	Fri, 18 Oct 2024 17:41:21 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2045.outbound.protection.outlook.com [104.47.58.45])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fjbvx7g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 17:41:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Krzb3a0RN5a4671mL3/kPUrQ/bcCLOHqL+NoIXx05TR/r4QhGWI72SNOI8qV74ewmkYvZc/cB8H84Sm8eL/sl/ZujPyJNJfdj6XJRyimZcTH8bHizcKNx1k4Q6wnYaffp6kmAF2fOIy+oLNrXFY13OOlLjvfjmJVhJu5RVy/2wFF6lD3E53rfoxvNljr/hI9TytF1UhKuIOr1wDE7wgJjTHa0q+Vtuaq6xVfwCSOt59TVlS8suEBcDOAN1lyInXNRD7hGZY8beIpD9BraxA76ehcFQt5fSvXIiWe4dJ6hRtsW1aiZHT/NUgvymmJ56gt5Vf6ecGzVTCnLWBr7sbJAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tf0IaB232j/iYgc5Kw4DJ/6mPt3+Sd9Q0LX4sTxWpus=;
 b=xZy0JziojLJVIk38e824NwLtWH5geJYfzgMjq79B2NeHQHtjKYV7u9KbjBRMjn8VYph9I/gxLA9N3TiSk2kUnSbZ1zFUWuCRhWpZG5Gq0UFWotuMCGgRnaAoL4nTUmzYTqg1tJf0UpMXXWpVsVntLm2wD10+0CESlGb+oBpFo4GoTcNyvYiCf5SuVMWKt7XxaX5MYLOCruQVKJQefghUq+2+8Il50YywLfNS1wGeZwVfPxSbdb73a4InUPxUXyGitX/rz9qoPXUbezIz6JqfcZVtHugJup9iGU1knyGOQqW7qpA3LeWesldLR4Shy9C4ENyRlLw9cp8mP2I4rpR2Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tf0IaB232j/iYgc5Kw4DJ/6mPt3+Sd9Q0LX4sTxWpus=;
 b=wfq3DC/2Car3zJWN2sx3OGUo/bVVX7ZJ9uurCWju73j3nvICECS5DLEhzQIOpDbWWRhrQc9C87ZrDZqWPIdaJDUQgvUpPW9SrhZCgpvbggYSRGsWPEVi2dcEwOFWszyZWS9LZ2MTy4QqGdbfbk9hDJYaIUBnTnrpnnmedhIna1s=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by PH0PR10MB7078.namprd10.prod.outlook.com (2603:10b6:510:288::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Fri, 18 Oct
 2024 17:41:18 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.8069.016; Fri, 18 Oct 2024
 17:41:18 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Jann Horn <jannh@google.com>, David Hildenbrand <david@redhat.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Jeff Xu <jeffxu@chromium.org>, Pedro Falcato <pedro.falcato@gmail.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v2 0/2] mm/mremap: Remove extra vma tree walk
Date: Fri, 18 Oct 2024 13:41:12 -0400
Message-ID: <20241018174114.2871880-1-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT1PR01CA0088.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::27) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|PH0PR10MB7078:EE_
X-MS-Office365-Filtering-Correlation-Id: a79c3499-caec-4267-453a-08dcef9c122c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Dk6YSMclaS8Gjy5nY3ARkzzpp+H34vV8KW+d2hk1OhVLZaCKffK8uTcSpiY4?=
 =?us-ascii?Q?kze8zj3VIy9CJSL2wa4wE9HirQF95/9N1XicOYIge0xc0/i5nOPjTuRjyXdR?=
 =?us-ascii?Q?8DxP67XQx9nEvNlvh7kVlmBAbu1QpRsFaqGWGgFQLzSxSU5mRfDS1jJAiKB4?=
 =?us-ascii?Q?enEzZUZuqELc00QFespTx+qB3gSZsHGkV+RuVZ95va9+Vzdv/+RoX48SAFKi?=
 =?us-ascii?Q?h5uUrT6B+UauzI/VtV6P3WhE+JoF/IMjwRwZ4abc5XgNvnBVLNL569riuhsv?=
 =?us-ascii?Q?0IQkoLWhXVlOV9ehlOdFEiVK5LpcQmYZ8cOr4Iolq1OOT+VxmevpCkDtSJJm?=
 =?us-ascii?Q?Rpf33Ah+sxIcb634jF2AWwIhiT97F4Kp+FZug7YsJtWdo9nXsQmOnAWlJ+ii?=
 =?us-ascii?Q?KfnH23WKyAH4i2xwiBa5R01x/ViG+X7ZsMJLty2fzPcfLaagjV9XcRKPE9/n?=
 =?us-ascii?Q?gAgW531LkKAOGwe8FZ7K3EICJVm/gbSwRYsh8hzLJWlIJav6QC3qJJ1foVi4?=
 =?us-ascii?Q?Zax2mwtIiOhOthQyycknY8+HxJXBBTYNpJjLPr6FSp0HVrEDGbF2/DUTzvtE?=
 =?us-ascii?Q?Qh6jkuiYhsmA5q5QQegJRYIF5fpDlYYOXh7HUNK4whbNMs5tngpLTHdtXGv8?=
 =?us-ascii?Q?IhcS57qyYX7rEclyeR72z+sG7scje2hjDp8M31SEFWqM0qbXepoGjKZ4+grk?=
 =?us-ascii?Q?KvwEHEmyuP3/uhySffrNAJi1MftEt7zHGe/PJecpt6z4cChvK2OAtIQ1/YKc?=
 =?us-ascii?Q?ZB96wpGEMow39PAQnPWbXuCy1Ph8W5Q7LVv5tksTOj54n+newCFAuAfPZS6L?=
 =?us-ascii?Q?7XvCo+oyBasWwG4/gC+rhY9gUC8u37teNvTqwW4pnbEfTPeSJqoLV/iwUsM5?=
 =?us-ascii?Q?oWbbmp3pGj2dO3y1FqxnrCV8RGTAD2aMcPchOo9TDd0nQf7Tekw05oKhr7bo?=
 =?us-ascii?Q?70YTE+ujj7Lx4OKYbTjUT1eyYSjFJIHY56/tZ/WkJARCKUcRQlgljK7gNfjw?=
 =?us-ascii?Q?AEmmUEAwzDtU99sm4zEzVjBl8X67L/zR2dlI4gExETHB5Eso9kQJdKE6gALs?=
 =?us-ascii?Q?2LuxcKS5XyPt+VW3idEKI9kdks+27qWVMWY6kEwzeMtJFAAbqzxlCMj802MQ?=
 =?us-ascii?Q?Fr4ALCfDpAD5tX2v2DQ3UGzlMKTTSy8wgKyHKHT7jGw2cVDYfi5zer49wRo7?=
 =?us-ascii?Q?NvR3luFhDQXjetPeOt/6897h129QRAfU27AGOxcWJgPollZ6+4pdAgreE4JC?=
 =?us-ascii?Q?/N2D3WSjrOvVnVypHd23gFVJgDl7LdHCH+F+iWncAo4bi9bR/iNJrFMhEAqD?=
 =?us-ascii?Q?Jt9mA63PhB35rocXg7ryza/p?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dTH5NmKxgm204EiPj1UHqmsBtcQaOY2xiFnfNsShDa/TlHZF7s6jYh1hxyUG?=
 =?us-ascii?Q?INchn9GugMUj6F5f7zy+ZvjsqqMeTaYEY9sK02ot64uuAuPs3IR9JTlOqN6P?=
 =?us-ascii?Q?McqOvZuxynsfv841YH/yVtfzQtGy6j88vQDNdFkNPaTgB5hWLSlxCQb//Hub?=
 =?us-ascii?Q?fVNZ7UQOXCocVUq4M4g0PjO2F+8oro4u4o0T+nXsApur6yjFTT0ItUwp1vAB?=
 =?us-ascii?Q?X/W82IvFpocT+nsSJfStn4LTvcOPki+sh+EGWMIP6xuoVdS38G9GEyJCKpf5?=
 =?us-ascii?Q?40Qv5kbjZU9tQ5zNDqQ72bUNQturYCOsUdlJShKgWofjltHY9YjCRaAWfzCx?=
 =?us-ascii?Q?+Hb4HFsyINfFs8vXKMYIOsc0TV11qnMpxGNAUVzI13yhj2C9cyd6knJSOB6p?=
 =?us-ascii?Q?mKCVT28H2x6+benysDgIv42Pw+4GAKWBT61iKIduh5YLhH7uBAP4tDJy40Vb?=
 =?us-ascii?Q?Gcy5vqomPak8pE4UVJT7t1u546i1vX0G6id8RJYb3d1XCpPhC0Lw8qIxWcld?=
 =?us-ascii?Q?OkwOFhkMsn64ghU/x7uagP9DEfxI5ZNyaueKz717rw6XGj990Oy5P8XxcUoC?=
 =?us-ascii?Q?uM8piwAoAAXB5Mmvdy4kLWhUv6JsrOBCryX1OAN5AuzMpXoSUtvtdFyhyT51?=
 =?us-ascii?Q?30xiPsa7D4JeJuxL/Vfkgy37bL8uoCJtN/uQAw5F/m53SuM4P0W1Bd+xH+ZK?=
 =?us-ascii?Q?04wH2LtCNF+ACoBRQOEQmaAJcW1d8ruXXx3lJMG0AmlbOegSzHSIcTgcsQV6?=
 =?us-ascii?Q?G6fWQZRFHGOSE6j9UD95abR8/m5VNUsY2UZrhxpVcrmv6vytW7DYixqfymVU?=
 =?us-ascii?Q?7O1d/kdE2tOtAji8Pxy4YhtAJ/XojigF65uJuNZih1sc90kAOkRc9Mp7nmMU?=
 =?us-ascii?Q?GWm2vi7WjpWZ7hfj8ct1fjTIt5GHeFI9cJ1qsn8f78jMXPz9GhOBXJl/s7HV?=
 =?us-ascii?Q?eHkGc6LXG7b2Lhv4njzBVI3lUMuJNXijVIYVEglFPdT25bozx0SS/Mf0lucA?=
 =?us-ascii?Q?UQzu5+m5BVT9RAQDhqP+R0JO4rGhh5pADCBPmWQGzB/GIgKphabBP5b1J0fn?=
 =?us-ascii?Q?59BP9U909eWUlVi0/f2aOd5yXbMnykPTcky4TbA0uaQBD64//RYF5qML25gK?=
 =?us-ascii?Q?xvyY12UmmtllB4vE+ddG7sZEhpf+PzLntXoz6VkIctsvP1R38RdTeHuQJqXM?=
 =?us-ascii?Q?9ZqnKMUQYGQm3Fgn+Zqo5qAFwjE7fZJd3A+RwUdpZlO0q0WZHMcWKxbaPBrs?=
 =?us-ascii?Q?kNyt2TKvax8vWnBV8jOEMqdm5MZBB4r5TWeRAfnSDILvsfmalvyoEAfVKcUf?=
 =?us-ascii?Q?rDnOl3SIvkh2wdKqvv9oeyLksGOUitcdeegRFeImtP0pO865FJUb3D5BXoAQ?=
 =?us-ascii?Q?jk/hLsrYEZF7kDkQD7zixPbois5IobmX5/IiesnsFd3iTDuegjTOmAUBle70?=
 =?us-ascii?Q?eEyYV9G0ipKILAMq1j3CT1PfYDMvFTpXLd1yKWghlXL+/6xE8+RFVWiEY9lZ?=
 =?us-ascii?Q?Fwe3FUhNfcgo2R29LAIeH8EX9Orm9Jg+ZQviSthm3bqxaekuLCa/fxxa5kaM?=
 =?us-ascii?Q?DoHV38KMOxPjhSgR/chp93lrGWTjCQzWv44qTfcm?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	epM5Fm4JBDJS/30axPrm0QL0clApU2fF5aClepR3bjVktYOqiE+V90uT0NCF1OdjbM0rqNX7P22pvQboZmJl92Mhxx8bshV+xsZNkww//XgZna/FCUvJv8cEClZLKM4FlRu6QaCtEpb08zD2HqdAbxIZCY8l4KT4GEPigONxRNUaLI+KAT8QV4ZVu1sxYavgLf01SaKdvntZ04mmruT+mFzCHx1wor01I0fRp2pGSVPuutGy6BdTE9WLswZeYBkVViF0fUFpPwDGl3sfSutSz8hHcdUTVP3XwTbHRe2NBEtIaXUtvyWoT/ZHczitv26W+wUfC2MOVZ8LFDxe6u0AenAGckr9jWsmrv9PNFtLYy+HDeIMZ08uEk0KsRKeXJhvt5A8ZHkJBn8EpH5R3D6Vg+gLJhqshapNii1zg5qpF6xEk262YTuXhYTcR0gPDO1eh0Zjyl4rdon4iTKGg5+1pNQvaMJ8tR8h4N5ALIfCzgF1fA3f8gVpeDfYesuNQCAjMZLCf/chvgcmWpO9ITmoOD02hEy/MfQ57H07SskpUm13fVLi7Fe9NBQtZ0xEU/CRqrJjpfPPbRNgBMYVOA9Sujf6fbzXSLe+tP9Vcp8YluQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a79c3499-caec-4267-453a-08dcef9c122c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 17:41:18.0042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hysbLPJnGI65U2LGfeA0wJ39/lvl+9pgg450WDpaEu6hhoQyTJnWre5+Po1BP6H32eS0R+lf+gAuxSE2nuxOgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7078
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-18_13,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=654 mlxscore=0 phishscore=0
 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410180113
X-Proofpoint-GUID: wKdwXUEC3jLSCZG7f7_ewh15ywV7wL8F
X-Proofpoint-ORIG-GUID: wKdwXUEC3jLSCZG7f7_ewh15ywV7wL8F

An extra vma tree walk was discovered in some mremap call paths during
the discussion on mseal() changes.  This patch set removes the extra vma
tree walk and further cleans up mremap_to().

v1: https://lore.kernel.org/all/20241016201719.2449143-1-Liam.Howlett@oracle.com/

Changes since v1:
 Change mremap_vma_check() to resize_is_valid() - Thanks Jeff & Andrew
 Fixed missing return check - Thanks Andrew
 Added comments to both functions that are touched - Thanks Andrew

Liam R. Howlett (2):
  mm/mremap: Clean up vma_to_resize()
  mm/mremap: Remove goto from mremap_to()

 mm/mremap.c | 93 +++++++++++++++++++++++++++++++----------------------
 1 file changed, 55 insertions(+), 38 deletions(-)

-- 
2.43.0


