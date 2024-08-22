Return-Path: <linux-kernel+bounces-297890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4A495BEDC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 21:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D2AB1C22C7C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 19:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5601D2788;
	Thu, 22 Aug 2024 19:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nm5rvLNa";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TMTzKMoo"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F9B1D1F4D
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 19:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724354821; cv=fail; b=uVIHxtmvPtRFXgV/gbjgEsYHhtapdFjh8ZzccZbZewlKDOAMHxTAFAhaXuD8XVxgd+0jE+GIvLscq98zW1nByoM6AqucggvlBqkrtQF/7Qc5JoMHOPIJsmljBdGZ0Q2ylsNVgIvsAd7gZDtDFjPHCf5MFKFXRbRajuT4rGMl7OU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724354821; c=relaxed/simple;
	bh=h6yEM6fCOcieEV8KjzMcS/5yvcJkxHLzeCuXhpzU+jQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WzZrACfn8qFtTqOOTP1JdSxydSEXxV9qdfVf7uKeGm9iDh04uUzMgMbCw9kr8EGSaVAskpIS6RYQ2yc9WYwCdN9FaCZ8uSy15a4KFyf4Pl3dF6KpN8IIxlOHASK87goGXW1ccM6IGWSKppTDKyKOkvCMkDM4fQizUpeBA0K+VA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nm5rvLNa; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TMTzKMoo; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47MIMUY8021045;
	Thu, 22 Aug 2024 19:26:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=0LLZ3RbsTLjZoi+XWRh7T3mXeaSWkQv5kP+Gqd3u8CI=; b=
	nm5rvLNayggSx6nNjcRrDvawcS4XkwMeNKVRXBV5pLN0idtarfv0G4WOiMyA5OaX
	nKe2LSskSPQWIioWWkjprn8bP7EgBh6rpmw/bgAZ8iRMvOzQy298WsVs+5kBh7Ys
	RfUiIN5t3dKom6TEqH3Ffn8Bxu8/D5oVoQu6aXvxp8DUtf9tjHsOEB5dWrKEnaGM
	XQ3oShKDTh9cOZ7fMhoP38tRwCa0XmKNktRhqgMnEE8HXZ3Yqcs6cg5vtLJ6UWyg
	vBnuv08J8bgW5vIrC7I6wzzxx5LEOjVS+IqF9Fr0Jv/I7DanpPdsYac7mWeRsJ3L
	cLm/vqpXjSYeGx1hUJdpSA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412mdt2w0y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Aug 2024 19:26:36 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47MIqaPx019453;
	Thu, 22 Aug 2024 19:26:35 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 416b0b9ckf-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Aug 2024 19:26:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RCwiZ1hYkklBzckBckEyK45sYFUprp15FzFx1smCgA2qz+bucH9UdNBTaD9vDMCSk2uFh2mKzEO29uKMkbOOauXncD0VKd3/qtec04ST/mzqAibxekNobnRfM5nqeFWL6pXHcITF9B1I4ax0PqYrheFDLWFJOZyrl1GFEZakj6JMSDTORKjHp9MVi9SA9M8KdmNfIa/m/M4yR4nH/+UGkdQnQC410mmBvx3Cg0nKMBKlktjzzY/hPjls61EQhmN/5P8dDB2ylF5R0O29x12wjCG7BJrzLN8gWj5hhVEFrEUuuIyfxqCBeYBfMthM2baTRmENZD80fXenTYT74N7hBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0LLZ3RbsTLjZoi+XWRh7T3mXeaSWkQv5kP+Gqd3u8CI=;
 b=BCHRsie2uTQgp/fuiBRPJB7M5LoN8lSM/2MWITTDdnX9M9GSqLm4Qcb2G5FLdXvhKkMiEiMJm5cAvSJRRW975WZUMGfPFZgu7Q3df/gWM8zQgIqiI75kZDqWmp39TmXSMPBhdg+lV767iXTCjd/i6sopJ/XZZbF5G4M+REnWnADp62u9XYLOM6tQewWvIBq9/6GdHv8Q1M22dCrc/rIHxSXZleWB+mF+nxrAlkQDX/v7LTDma8vdtPGWD1BKYEzY95MuKplLeg3iu4+BSpi7w2Q6V97vn7c3hmkGtj3zSGuGmYZ2k0LaDi13KtRCOARLoboMUI1hpQsyhXp1PyLD9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0LLZ3RbsTLjZoi+XWRh7T3mXeaSWkQv5kP+Gqd3u8CI=;
 b=TMTzKMooAPFdflTd8A8AsonJpVk4knAhvgzdxWP8H20skpZ/uI0cJ0+0RGG8bWQPlXPjVRicy2d3b1O5Te1/Oc6yuHM/+Ytr/BoNBEsnWam+Xjv0AC3QyXSdlK1ycUaa1y+ltPyRPUWomhvDRSNiZoauExoeVunzQP7wiz6PgM4=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CH3PR10MB7761.namprd10.prod.outlook.com (2603:10b6:610:1bc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.16; Thu, 22 Aug
 2024 19:26:32 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 19:26:31 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        sidhartha.kumar@oracle.com, Bert Karwatzki <spasswolf@web.de>,
        Jiri Olsa <olsajiri@gmail.com>, Kees Cook <kees@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Subject: [PATCH v7 11/21] mm/mmap: Reposition vma iterator in mmap_region()
Date: Thu, 22 Aug 2024 15:25:33 -0400
Message-ID: <20240822192543.3359552-12-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240822192543.3359552-1-Liam.Howlett@oracle.com>
References: <20240822192543.3359552-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0054.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::25) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CH3PR10MB7761:EE_
X-MS-Office365-Filtering-Correlation-Id: 79d22c16-ff67-4ee4-ed3c-08dcc2e05376
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wVbN9qBbEX2Yr34+iAkSQkwMjF1XhPNlvnKbkWQo9bmeXCKZxr3Im/zkHSnz?=
 =?us-ascii?Q?45oXFuhsHiR2b20v94xs19atH582zP+xvVD+tQNq9ufAT7gdJJtZyjlXsF3r?=
 =?us-ascii?Q?BRY6i5OFIm+jg3rBC0nTCUUgeC+v1e+bDJD09Oq5vbQPjrrdJaH68aYNmqDw?=
 =?us-ascii?Q?Mi1RyWNVTfHa+hw9oalZshWSwjhxrbk3Ae+qwWqayiWkHuNGDTHV/LExtnYW?=
 =?us-ascii?Q?vGEPgzk+lXNZuN1/G1s7tHOke5agGzlD2nMrXR57KnQdCWkgmiem4gUmomrq?=
 =?us-ascii?Q?bGA/Y39xmkFe2JEzcT4UmIhMW3IIqrM2oaL+U6ylFnrehSDmcgcjDtLO5bav?=
 =?us-ascii?Q?aDSrwKkiG03RQCU9UGGQyTxswNGRQVXTh4oabD8LFOOn7o5Ji+Q7NwoZ7s1l?=
 =?us-ascii?Q?oFk9zqjqEoicPBY1VEV6xnKqFYBdoUs5DIpPBm8VdPlbf5xtO2Rts7NhxTM8?=
 =?us-ascii?Q?NUGtmpVxvgaFTrdAJzvbelDso8sOOM5Xhll8en44gFlI/j337+ByYoNnvqE+?=
 =?us-ascii?Q?dV/aOeu/eQf7G0jHwnlCsa4J6Hnf/5NY5MP4ha6cXwFOoW0lSeo8sPsOOh7/?=
 =?us-ascii?Q?1lvF+UQpYQX1URj6AJlbjbGS8lbc0iPIyD8ya+CoqtHxrMUiAD0B/R58YR69?=
 =?us-ascii?Q?9i+m2euDfE2FxGKol70pV9SC/PuBlFsG73KlUIEJtco7yCNIqq59kNpmso1I?=
 =?us-ascii?Q?HIMw0Oad9vrFNLuUE22jBbgmvZHWSIZ0Xoekcd0S6N5Vq6j9SShFTtizbHLw?=
 =?us-ascii?Q?UX38lq4yRBzFMfLzJAsTo4munul2/agvMkYg7IBjpMPyEsyjKuyc+yN9xlSJ?=
 =?us-ascii?Q?3F53O2k2MaTCCZDBZit2ow9FrNMSCZOrXjLd7acUP+MaF/lq0NDNuNmvJLl+?=
 =?us-ascii?Q?C80N8GYMh8g6QLs/NiRFnj/snSzoU+HTGsdYNJWa5muO2EyDbY9j/XpwMV/L?=
 =?us-ascii?Q?ysjtfDBHtsJYusubEXZsw4utGL8/pOPGUw/qIidMzt0cySgBi/XvgB+5dGoH?=
 =?us-ascii?Q?EMoL7WGj7nELNeskQ9EqLn+VkGeSxj1Q4MZxBh4K0gGTFzIeu9vR258Ra+3i?=
 =?us-ascii?Q?CTZ8Gdoa/iM2yFUDOY4vFvnCWBoWBOt38gfkornJ55rHZiNivHb/dAR4vSqN?=
 =?us-ascii?Q?JrBuBsuw9R8HBHqlfD6IPrQ1BIe7/vzqp9/FF2PzFW7IRehkpvj1LzTIHqbq?=
 =?us-ascii?Q?eCWXuQGUqJ8n7yntFGhaAGDIVkHVW1JKhKWWvxEBfYxXpZGcQCWHKoGOT7Uu?=
 =?us-ascii?Q?wlzUemPnl0ZDVMuKzEyvz5O92ewxeVpoDbcsMagz6Y0MvXQikb+RUYFDvVSG?=
 =?us-ascii?Q?MkES90k1ePg2kHsyWeogNUAmB/tShDUgujc3gS9CVXvWPg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tpveRwNbbGb7QrFm1Jz2/6m1MJnoMZjWfHO1KsHy/ie0Qm/ChxWHi5qDewAq?=
 =?us-ascii?Q?hdEolTr3ufq88jaV4bKkKsHeLtvVmdmpsra/pNsWSZnnJULm7d5fJagikayx?=
 =?us-ascii?Q?LGYThg8CBg7Mfe/ZmmWmuQf8L8mU9gQ3jRfJtEF/pHCL1oe4IM+Al6hBgDfk?=
 =?us-ascii?Q?T+c9tVZiq+Le6/tTLvA5+eMq78a8o/9kRBrDp2pK7R/C6Wt5r9ExIKY9SXVd?=
 =?us-ascii?Q?KbazpM4f/dDmhP4rpb8dOQimdb13rwKxIQQZyt1o6XG6El8p5SLjyjLmrXFn?=
 =?us-ascii?Q?LjWxHZr+siRwdMrom3QW9YScCS1QAd9n4ZuFZklQFCMlOHgx0CJ+VWt5H9MD?=
 =?us-ascii?Q?rMj62MU6MBbjaPlW38FClx5D/DJmdgzIXjVSC9AhUS0Ff3GFeoVO4PnjRHP0?=
 =?us-ascii?Q?ucxVwZOIm7y5f0taAInls2xfHjzCkQMsGZcXwZt9Eo3Fn1QKTiUn+7yFYDC7?=
 =?us-ascii?Q?6ti69+lKVPvBMW5AerqTZn/4REl6QGkX6rk+sXlBgKcscODRPd0yFj/YuDLf?=
 =?us-ascii?Q?KCI/AxatTfeQouroFCFmixOr+b18N+tupTLhBRIkYsBTthelFTIeLq7pAFYA?=
 =?us-ascii?Q?laLGydUbjzu7D1I6LV9m1LNBK1JpQsdvsdQ/6//JRaTiwe1YY+UpPEKhbEnV?=
 =?us-ascii?Q?Pi1rjeqDrXBe60oa+96+A55SqUetRF2LdJgMNtyx0OOAoWAflmerFvtGbo17?=
 =?us-ascii?Q?T7eSAjv4B3yvDH9cFk59Dxyb8H/bWUgsWQz6fpxrLbBaT57InAW8QonXT537?=
 =?us-ascii?Q?yFZRfmiNNRZ+shnwuMWPItGJW5k+yGAg+VZXOeU4/yDQvaYvuTYRh/0+NiY5?=
 =?us-ascii?Q?DK7NuLLx8Tb6sVeeR5GWWNcklYhZBZVMdKuQNenStF+VJeL+CxjeYwBt+5pE?=
 =?us-ascii?Q?hrzLG1bpuWFqcTytzEk8XdcA/xSyYOi2uD2zJxKyjjxfqy+pWJvagt4iQ2gy?=
 =?us-ascii?Q?zY/SmCDtX8CVG0lO/aacI3vqWNtcGfS31JcYWl/eJn0TsIRfD68iEzXYHeee?=
 =?us-ascii?Q?Im8/cu0egYW2Zte1V8P37UqFLr7km7Sk5GhxZOAzY6V2wtc0aQImcUL/6WNw?=
 =?us-ascii?Q?VVMqIVdkAEpYgM0nRKkBjARQO+s2IQUExmbCAqcLjYqF6U9+/N+id5Gok1QK?=
 =?us-ascii?Q?v9SLSVcpLof3LngmUoTqJJPOfHz2uF3Z5qGjHOy7R5gEFIF49COnSgnf+sx9?=
 =?us-ascii?Q?E68ceSRaOod7riiCBJOuoG5Z3lB3GGAVJTQ0+yG+ZTl8dq+D5tNv+sq1bFY5?=
 =?us-ascii?Q?DJkLDPbTHjsysgU4FPwL6QXCwgBEk+YccitMUn524u3HdE2uFZEIbRd6dv0D?=
 =?us-ascii?Q?ELUY+SUUuM8qPQ+YRwhhPolYj6EDjcKNCAygAGDULWbaGfv3xpl3PDYDq2O+?=
 =?us-ascii?Q?jVqGc7DadCBIk0ugL63F4hfadJV7B1vE+gIWAYoz2945Mrj156rKyrRmZBT0?=
 =?us-ascii?Q?2jpWHWSmZsjkiV+9DnShvRwYny6/gcpIeRz3gxexSRX9UQ6CStysAxuLnWcc?=
 =?us-ascii?Q?tMoeBeNQDW6LwDwPkKbXjv3jyjsAjmP+3RdRPOWVhz/7MOyqU4THG+FpZ0mZ?=
 =?us-ascii?Q?9X5iKrrRlhiNcGrD5NppuoJ5fDwy6FhixRtmXDjse4pOkOA4552vAOsDLD0Z?=
 =?us-ascii?Q?nw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gR0bK7kbp09HQ+SokgaPc78U+YdWyPseakTQOiCbBTYRHVWARSos4RjAnW5LEvs/TZyNgi1fqwyrn/dgYTOJkoro2Iyq+kuKjO6KqOpbm9zghX3L/RvIzYc50LIyu9prKnU6Ebl0JW7PIXpwAZy6i20Fz9WG26mKWn8toPHFz12+bNMH7Z4Tiq/DrS3bUvOiyWWxRg3c4oPAxiwpWj7TUNmlPLsw8eTZFeJ1qp5QZpSxwZQ2S3ZsoNDG8WB5/LzXWyv5Ohl8yb4odl6TQ+h56cSHQmANf9p0FoL2kPv9c/UoQoTtBS3q1/TZnQ9OI7ubv0oCKpXfn5gnX0ndF2X/KbggVeZwWdqMYTFbRU2Rkfne9h35acUmzn0DqjcpM13RmVHrBpVljupf3NkP9/7mliLNw4lcMLOo5wgeFA/xTvtKJ5ds0d8vf+zVPIZYqREeAL6Gp0uRxmi+pB4PAbQfFSRf0+tOQ116F2/nqOmzRuiGGKytYjlPEExIS4bu2JdfUfx7E0wWuOpJkarSd9bwSECK17VWHsRrRxJQbjnbs6ITYgfFTkNcB5Ga0iIRK9ldjntvvgspdtDC2qtyoa8Rr7T8yWmWUIrd29Xpmya0ha8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79d22c16-ff67-4ee4-ed3c-08dcc2e05376
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 19:26:30.9921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cnoWFhziwzOaUOy3ptztsGgaMlcSzAjZbVhJXGMpIB1k2wrSnhpRfk9freonrWOkzPDHdlQ52BYCmGQ4nUn15Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7761
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-22_12,2024-08-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 bulkscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408220146
X-Proofpoint-ORIG-GUID: FXYv3_2sO_CnkqvU7CMsW2o6DeTEKatc
X-Proofpoint-GUID: FXYv3_2sO_CnkqvU7CMsW2o6DeTEKatc

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Instead of moving (or leaving) the vma iterator pointing at the previous
vma, leave it pointing at the insert location.  Pointing the vma
iterator at the insert location allows for a cleaner walk of the vma
tree for MAP_FIXED and the no expansion cases.

The vma_prev() call in the case of merging the previous vma is
equivalent to vma_iter_prev_range(), since the vma iterator will be
pointing to the location just before the previous vma.

This change needs to export abort_munmap_vmas() from mm/vma.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/mmap.c | 38 ++++++++++++++++++++++----------------
 mm/vma.c  | 16 ----------------
 mm/vma.h  | 16 ++++++++++++++++
 3 files changed, 38 insertions(+), 32 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 2b7445a002dc..9285bdf14c4f 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1400,21 +1400,22 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		mas_init(&mas_detach, &mt_detach, /* addr = */ 0);
 		/* Prepare to unmap any existing mapping in the area */
 		if (vms_gather_munmap_vmas(&vms, &mas_detach))
-			return -ENOMEM;
+			goto gather_failed;
 
 		/* Remove any existing mappings from the vma tree */
 		if (vma_iter_clear_gfp(&vmi, addr, end, GFP_KERNEL))
-			return -ENOMEM;
+			goto clear_tree_failed;
 
 		/* Unmap any existing mapping in the area */
 		vms_complete_munmap_vmas(&vms, &mas_detach);
 		next = vms.next;
 		prev = vms.prev;
-		vma_prev(&vmi);
 		vma = NULL;
 	} else {
 		next = vma_next(&vmi);
 		prev = vma_prev(&vmi);
+		if (prev)
+			vma_iter_next_range(&vmi);
 	}
 
 	/*
@@ -1427,11 +1428,8 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		vm_flags |= VM_ACCOUNT;
 	}
 
-	if (vm_flags & VM_SPECIAL) {
-		if (prev)
-			vma_iter_next_range(&vmi);
+	if (vm_flags & VM_SPECIAL)
 		goto cannot_expand;
-	}
 
 	/* Attempt to expand an old mapping */
 	/* Check next */
@@ -1452,19 +1450,21 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		merge_start = prev->vm_start;
 		vma = prev;
 		vm_pgoff = prev->vm_pgoff;
-	} else if (prev) {
-		vma_iter_next_range(&vmi);
+		vma_prev(&vmi); /* Equivalent to going to the previous range */
 	}
 
-	/* Actually expand, if possible */
-	if (vma &&
-	    !vma_expand(&vmi, vma, merge_start, merge_end, vm_pgoff, next)) {
-		khugepaged_enter_vma(vma, vm_flags);
-		goto expanded;
+	if (vma) {
+		/* Actually expand, if possible */
+		if (!vma_expand(&vmi, vma, merge_start, merge_end, vm_pgoff, next)) {
+			khugepaged_enter_vma(vma, vm_flags);
+			goto expanded;
+		}
+
+		/* If the expand fails, then reposition the vma iterator */
+		if (unlikely(vma == prev))
+			vma_iter_set(&vmi, addr);
 	}
 
-	if (vma == prev)
-		vma_iter_set(&vmi, addr);
 cannot_expand:
 
 	/*
@@ -1625,6 +1625,12 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		vm_unacct_memory(charged);
 	validate_mm(mm);
 	return error;
+
+clear_tree_failed:
+	abort_munmap_vmas(&mas_detach);
+gather_failed:
+	validate_mm(mm);
+	return -ENOMEM;
 }
 
 static int __vm_munmap(unsigned long start, size_t len, bool unlock)
diff --git a/mm/vma.c b/mm/vma.c
index 6b30f9748187..9de41e1bf3b2 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -646,22 +646,6 @@ void vma_complete(struct vma_prepare *vp,
 		uprobe_mmap(vp->insert);
 }
 
-/*
- * abort_munmap_vmas - Undo any munmap work and free resources
- *
- * Reattach any detached vmas and free up the maple tree used to track the vmas.
- */
-static inline void abort_munmap_vmas(struct ma_state *mas_detach)
-{
-	struct vm_area_struct *vma;
-
-	mas_set(mas_detach, 0);
-	mas_for_each(mas_detach, vma, ULONG_MAX)
-		vma_mark_detached(vma, false);
-
-	__mt_destroy(mas_detach->tree);
-}
-
 /*
  * vms_complete_munmap_vmas() - Finish the munmap() operation
  * @vms: The vma munmap struct
diff --git a/mm/vma.h b/mm/vma.h
index 0e214bbf443e..c85fc7c888a8 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -116,6 +116,22 @@ int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
 		struct ma_state *mas_detach);
 
+/*
+ * abort_munmap_vmas - Undo any munmap work and free resources
+ *
+ * Reattach any detached vmas and free up the maple tree used to track the vmas.
+ */
+static inline void abort_munmap_vmas(struct ma_state *mas_detach)
+{
+	struct vm_area_struct *vma;
+
+	mas_set(mas_detach, 0);
+	mas_for_each(mas_detach, vma, ULONG_MAX)
+		vma_mark_detached(vma, false);
+
+	__mt_destroy(mas_detach->tree);
+}
+
 int
 do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		    struct mm_struct *mm, unsigned long start,
-- 
2.43.0


