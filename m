Return-Path: <linux-kernel+bounces-435502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 580279E78B0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 20:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1357F281B52
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 19:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FAB51CBE8C;
	Fri,  6 Dec 2024 19:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PGmDrq8p";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MIwgzg8g"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FCF2206BA
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 19:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733512605; cv=fail; b=CQ1JyhVAzimNS7G6Qz48lt+FKKlvdVw0//LtveUSGvDHdkIR+CFa5VlzofhSmaffigLLhyr44qQjfR5hlMH/+iBFvng7i5OFbqcGmlfy2VUK2hkAiIXjh1biOBKkbNzYNP12bWXTmbUTRBVefZ2ppqWm81khDuztH8d87qD+dUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733512605; c=relaxed/simple;
	bh=pyaTBVhZr1+FAUH0enpja4RXM7QDqm3ogJSX9V1QBoA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Cf390kEZHbSt84Vh9Szl0GszwBAjWYvrMIikHW/uFC3IVWHI480CZosS8c/Ei5ik9QCAcNjpGAmfbfOq4gRnQNxkCZFylbCaryVkrchtpckOrySwqz2XrsRloSfgLE7uZoyP39ZRkpSY1du8DTAvyYf4bi24wge++Cb6Tz2XJuY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PGmDrq8p; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MIwgzg8g; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B6Htt8L019879;
	Fri, 6 Dec 2024 19:16:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=NhlbW2eMR62NLXbZ
	/0HtFVXndqFQdwWZCJsFh2Zz6cA=; b=PGmDrq8pth7B138PUeSRXmMHtFBlgFhA
	eWi0sSkj19jQSDTsMoTBhaCAxzRlwMrRzxOP0Ya1KUC8ZfOQUw3rzGNTUy2v10Py
	b59R19rdyf6Q5mNZtYxRNoGPQWWvggIlmalw6j3tjGnPQIx6os3azZvuoM7XDOiN
	kt1ZCXU2HUCEwddJCzk/osYmsBFPK+hdQq3BretZCXMp6utIykqxEH0FNu6DfM7W
	V9iqxTQEAu6iQGbg/d4Wr9q0uysWbzqFE9yTVnUwaVecBmGkjy/Y6Flvg1iFF1HV
	6xrk7tlSQiti/P0rQ8aCVvYV9EYHgnQFeqJibjZb1pQElOg5Y+0Wjg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437s4ce0g8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Dec 2024 19:16:29 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B6J1Mwi040009;
	Fri, 6 Dec 2024 19:16:28 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2049.outbound.protection.outlook.com [104.47.58.49])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43836yjxj7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Dec 2024 19:16:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U5VleE3hQSyAmbjJaax/coI1PZ3hhb3LfORvA0nlhCKXh79ltbzE0MYy/60uaTB3xwwdE8ez1jTD98mwfCuVLY382au+wxlK0NLqHif/AuQ3N1R6pyMXJASCUGO2aAhnKsg52ta/dlMCZdq+8A41bxGGLnOn2tieW4oX2fCMTzBZM/8na6IYFjUGHTe5E/f5xy4GnPyuCb0Ei5D1261CCoMwFu7ScDGVkVb/AQR4/gBQbzamRGICd/Mj44DemHmI7LMq3UFg4VtkPFJG3anxehlNohLlJQs/z5i4OmUA4UzSb/DagBoWVTt3UyBetkPvKe1s1ZN/3gnHy72qkeDH5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NhlbW2eMR62NLXbZ/0HtFVXndqFQdwWZCJsFh2Zz6cA=;
 b=qGKMyRLFgi3O8TqShjtRxK50GQHuDhXEk5YpUAJuhdD02XcQ2fdGOvfEpn7Z03ZgGTk9MiMVHyPnMNY62aEsnw724UjPul3euiSDGeOlwREFFzHszKHjiOphFGruFabGNrgXTjn2h7G9GGISsMtXYjv2L4YujyWvbPF3h848rF+IJjkzZYs6pt1Sfd2zBqKnL/O5qTvw3ziI05l8YhkgOmEGqUIsoYXLtlZhnATv00qOIsoDjRQHnPH1BAfqdUEZcNFChQQvrhE5aNFZc+MB7TWzugvhtI3O/yGfJPLCjxLbEo33hph9n1IKKcEuvPFPepAHPWgVUrHbUXx/X8DbHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NhlbW2eMR62NLXbZ/0HtFVXndqFQdwWZCJsFh2Zz6cA=;
 b=MIwgzg8gRAwukCoKLjLKoBb9XLVKu5Wyb7vIN8+geXG6Z3y4xBGv3xNiT2EKSvu0jUMAY/V3O0PStmMgvf25eUhfUdPz1ThPUdcbx7y46pMSMUoZaqGquN8Ly/qCZq2w269m7cMhzwUhNddNGU/5OdVYgFoarAV64ipyt0vTNAA=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by SA2PR10MB4745.namprd10.prod.outlook.com (2603:10b6:806:11b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Fri, 6 Dec
 2024 19:16:25 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 19:16:25 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: group all VMA-related files into the VMA section
Date: Fri,  6 Dec 2024 19:16:00 +0000
Message-ID: <20241206191600.45119-1-lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0350.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::13) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|SA2PR10MB4745:EE_
X-MS-Office365-Filtering-Correlation-Id: 73d9c3a0-2e29-4568-fcbb-08dd162a7a35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?i8cf/N/MXb8ovXvj9MeORKs0KEQDBse8Hq4lAirBBc0O6WAm/EeiOv1qdtkN?=
 =?us-ascii?Q?db1qdqwz0td2X/8RxIdWk+ObuvACxG/VhrJLC6QwFmHUoQvyzevmRZgnbUnh?=
 =?us-ascii?Q?exRLIXqHOT3O0GlR2NRm47xxq3WbSELSzKF100zZFaStGsKeURLqFG87dtqI?=
 =?us-ascii?Q?jQC+7EZZxO3iICr5VOjt1U3m4s6RWRUyrZZuDzOasGD7p3NV4hmKrSAqCsKH?=
 =?us-ascii?Q?IDLvoPv7WWWbay2A5fqRIgr/pz0MkDI87qevZfLLp/MZGcyif9OTb+uh+B20?=
 =?us-ascii?Q?StJc0ZWjKPTvnol2Ncj/aQqT5EmbnEX3SB3Cu0A1JndbEQP+GCFRTto3ngjR?=
 =?us-ascii?Q?ctWepKgllyOzwW+UKG4kBGJErJNhR96FyWd9KwWr0UFXXy4YJSrAqtd/7TTt?=
 =?us-ascii?Q?Opkp2Q7h3YmZ1UFhB9/5z5V+VdJniHYanCF5TmDILM757YqdVlUTutleYe3l?=
 =?us-ascii?Q?j+/wVNWQ60T7hCvJIDYarceNs0e/29wz+9NItC6RijapFc+Y/p6wmG3Fk3Fw?=
 =?us-ascii?Q?2eosWQThj+LgGzwPcRfQf9FZAN4IMAz+pvMTX/nlvNdZOl5VNpMiXwHjug5+?=
 =?us-ascii?Q?adnz1nwte3Zjrxw8lDfY2AaJ4yXdgCX3PKV3yXBraJvqFzplBK64z0Nx0BvG?=
 =?us-ascii?Q?fRL70SEaxnSLLWevtR7KoW1ZJxWujsyoPwOftvtMfsfY83x83VQJrAlLImh9?=
 =?us-ascii?Q?GIZaNukXKBJuV5O7ps/ofFfzp6Jxtn7TFF0k1O6nk8QfPcNcyLVz+nJNuOkS?=
 =?us-ascii?Q?AbSjizB5IdX41g7bXLr4KNK+LpcDW3OqQwxzq3pDuxKqo7FTGZw7Kpy49oDe?=
 =?us-ascii?Q?BL5RcS8sdJHeTzI7sYoquUyVJBtTSjhCqgNLr/DrXkcCf1dCVPdNZbbGYfZu?=
 =?us-ascii?Q?7BePZuVCg/CN1CnHhrT8IyhKK5Mu8dHbQwsa7FdKl9L0xFq34NGqPfiHhbzA?=
 =?us-ascii?Q?dI0lAxbxc5oJ0KyxHc0BGYpNoOO5dDsPTYlgbbL6RtT1vDOxQcjTaygo+tJ+?=
 =?us-ascii?Q?rCR1c19L+aVhK2iFtvm3ZyaV8GoKPr3nHKIby9aaASYcLLVTAfDYO8bRh+2a?=
 =?us-ascii?Q?4kFsxZzANYLB51G2hYoLOAZCrx5oOKqoFOKDrkyWM3fZLI1dFsLEj3c6St3t?=
 =?us-ascii?Q?zpBWbECh3sJUeeHIuA8IrHjqY7xEQj/Wa+kr0sH/+U8dfwP6ggisX+28+Mbg?=
 =?us-ascii?Q?j+BOY/Um5Yhu2gs258ndxuKzw4RX+Jp1dPWbOkHweijPB8zk2mCSMAOtugza?=
 =?us-ascii?Q?r8wFG20zqs9NG72PlUKQQcRxX9HQMKom88a95g8loPb3D0vPlC2gsovm3c9L?=
 =?us-ascii?Q?/rc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YXYXL7sgL5TUdRKyqUsc71hU0yibCS/0A0I3bEQlzNyejWS8qxFz7T6Jj37S?=
 =?us-ascii?Q?qOFHSaess123lZ2xky3o4s8mti2RzIbfvxMxhkcvgosXol5voyy1GckFooUZ?=
 =?us-ascii?Q?F0f5xx1RH0SikrnnoUNmJZtZ/PWH5lN8+hE2IFx7qck8b479zpxlR733RUW6?=
 =?us-ascii?Q?5Sx+q4Edb9l6Yn89ZQwP2BQc6l7DvT7dbzOqKkWlcqIwFXrb7int5uHbu75H?=
 =?us-ascii?Q?fqSV8hcMtOaewj7jGhsNrcFgBKcKm61dJLMIFdfqAN38G3erMbEyGDUzg6pS?=
 =?us-ascii?Q?T+GxPUVvPmI4PvCYxJmDv4Hf4BhxG7QI7wF8xl1kv7C4u/+6HCRrht5RVcJW?=
 =?us-ascii?Q?e7jfD7NBMtmMo6gpAQxlKGE5ywU+55cQrOilHhAqy7tqZDcHRAzWQIrDS7Kg?=
 =?us-ascii?Q?JpHIKk5u+UR+0dYH9manomoK4/cwpt6AYPPNaqcmeyR78YCyam4X4GOh1cbu?=
 =?us-ascii?Q?Abh2wprSWkzx3ccayymTomw1LbfEMYWzoLaHklziF0NLNa/glWiER1rlF0Ku?=
 =?us-ascii?Q?Dj3Pcj/o568I0cNXoSh16AWfZ8UXFKYvNAqn94OlmHq1y+nUjtCiXecOU3r4?=
 =?us-ascii?Q?XRAoRyRuo8bDQStaKANE4jpvMg2lORRf7AgKj5L0Z6tJC/0LCmhZbkaK6eH0?=
 =?us-ascii?Q?yRJ3hlOk1zQKb1NSlIPOy2jZIZJ3Fbzp5L4TeEyhIBN7GXpuisq8fgGNmCLo?=
 =?us-ascii?Q?iL3yZ34OS/+zSr6WvecCg5Wo8sxFU4SLtptKAMmEXnc1032KqjNBHjm95qVP?=
 =?us-ascii?Q?noZwjWS20xrE4BE+p4yeKbtfWx3dmvYKv2AdJDTsgDgUPNzJhtZTGaCdk/3i?=
 =?us-ascii?Q?tkr7tBa2ac/x/F7ChJ7sYycXVovyqf1EoqvRZvY0MpYIIQe0HsqeKkCkOMCr?=
 =?us-ascii?Q?vJMFcrkR9spFECHSb3bWldbRm0x8jTTH9LEB0C8F0OCXOvPn63D1I7th6Jwo?=
 =?us-ascii?Q?g3OA74VlyMjDsJAtC5H3xpoV1D06WwW1JiPWKsSuRfCG8/z9paigg2Vj1LgA?=
 =?us-ascii?Q?dRR1dCn2AA5/OvrT3gQ+VGhxJxpMcRWD+LT1gE9hCBgx6n1uv4Vcmyv9exKd?=
 =?us-ascii?Q?5cqqMQkSPyS8/OL4MlRUZ5FqPJzteo0Po1gbwb4U7CjXJ9/9jyIL1bkMxJUT?=
 =?us-ascii?Q?JOxj5K4vnBMLmFdADb7gSbvKc/KBGWJdNE5oKuS6Q+iFpceX/GcpFfnhaHEf?=
 =?us-ascii?Q?yoklEtTrgvqUZ2wATHkqKa4tImBmDQXygRTEETVkivouDIxtDaLCzmWTw4YT?=
 =?us-ascii?Q?HK7kwV7xcpadomwKN4T8Sa7M7u1AVTsxLZbbNx0zKT8uIBLaVn7gr7LqdJ00?=
 =?us-ascii?Q?mgPF1AbqAEWOkOta9zRK3H5Bn4CNA2E2nYiY+XFiZCevwtg/j3jPZSgm9OR4?=
 =?us-ascii?Q?lfq+WEnRPlpt4H8byavxuGBwPGo/tbga8IByJFHAl5937WqzIvjPOsCT3eaj?=
 =?us-ascii?Q?ejqeaDG5LPvJJZ4nqfVLX1bvCMu7GEFmSLAScz17kco2w8qyyu0/zBvkYYqW?=
 =?us-ascii?Q?jry/V/yipzZ6GvBNwksUnxTxTGoA7IMtDSFLxr9pbU4ljcWsTq6LQ6SbSJpB?=
 =?us-ascii?Q?GAwTvdZZlFYfPoIFcWk+rWbnDF1QWF4ynGckkMDCSGljF9UMPlvmVVfiSr5D?=
 =?us-ascii?Q?9A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	McZsFnsgzUr2PXhE5pjz9IpAqLCvQise1XAOoG98I+SRkGTRZLdhUcAwulaStVFl04CAFKbxBSa6vA4ZgmLQh0hd8GeHIRCi1e7yxLEqD9+N/cGZP49uYv6SK0Uk31Z5Bo7nyA4sw07bmTQLZ00p85GRPccDj1W/3yE3IKMXlNA8dj32EhhwMLZJR/jySxtaIq+KkOYBt4jVNrA4R4z2OWgK7CpWYvCno1xHH/YEewoO+awe163HIOuOpzxIga2q+5NiMdFwEa7BGkvvbGqgJyEh5H9+f+jsJIroBsyHw152M/vB5pyryL3v3/M1auKatxRjPGnLh5Kw0mB1T/RTaVNUkQYdgAOCgdO94/h6EIadfDhX4g7CWhIbAt63A6yisDp72+OG1bAFj5/3FCZNEci/nl99X3U/MXj/iYcvy1piRiW0RX1EUbkIipaWsdyTKqOdwWK+7tr2QLbDwkz305VQlqmwcLVvFvqi4aHIDsC5O+d3qbmp/nNc7dXAUcEyICFCmRtwymMD4VgzCYrXXrCg38oeYeXjslYKcMGZeqdfEBVHIW4Rg/Gv87ufpo/7x9o97TisVRZK87JoGJPJOSjN2P3YCuiiwWyiPsT1ZoE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73d9c3a0-2e29-4568-fcbb-08dd162a7a35
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 19:16:25.2861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k2pwAFfAXiaJTsYpV1aBssJ5ccLzelxbAV+2mguj20rKQF8zEdGAwoN7408YNwRkCXQCrYNaD6KLrjuXV1yCZzZqVzvGINL5EKrfdl2FyQU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4745
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-06_13,2024-12-06_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412060144
X-Proofpoint-ORIG-GUID: rIexws027lHOvaKTvJ-ZtZamy8_uZ8lo
X-Proofpoint-GUID: rIexws027lHOvaKTvJ-ZtZamy8_uZ8lo

There are a number of means of interacting with VMA operations within mm,
and we have on occasion not been made aware of impactful changes due to
these sitting in different files, most recently in [0].

Correct this by bringing all VMA operations under the same section in
MAINTAINERS. Additionally take the opportunity to combine MEMORY MAPPING
with VMA as there needn't be two entries as they amount to the same thing.

[0]:https://lore.kernel.org/linux-mm/CAG48ez0siYGB8GP5+Szgj2ovBZAkL6Zi4n6GUAjzzjFV9LTkRQ@mail.gmail.com/

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 MAINTAINERS | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1e930c7a58b1..95db20c26f5f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15060,18 +15060,6 @@ F:	tools/mm/
 F:	tools/testing/selftests/mm/
 N:	include/linux/page[-_]*

-MEMORY MAPPING
-M:	Andrew Morton <akpm@linux-foundation.org>
-M:	Liam R. Howlett <Liam.Howlett@oracle.com>
-M:	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
-R:	Vlastimil Babka <vbabka@suse.cz>
-R:	Jann Horn <jannh@google.com>
-L:	linux-mm@kvack.org
-S:	Maintained
-W:	http://www.linux-mm.org
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
-F:	mm/mmap.c
-
 MEMORY TECHNOLOGY DEVICES (MTD)
 M:	Miquel Raynal <miquel.raynal@bootlin.com>
 M:	Richard Weinberger <richard@nod.at>
@@ -25028,6 +25016,13 @@ L:	linux-mm@kvack.org
 S:	Maintained
 W:	https://www.linux-mm.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
+F:	mm/madvise.c
+F:	mm/mlock.c
+F:	mm/mmap.c
+F:	mm/mprotect.c
+F:	mm/mremap.c
+F:	mm/mseal.c
+F:	mm/msync.c
 F:	mm/vma.c
 F:	mm/vma.h
 F:	mm/vma_internal.h
--
2.47.1

