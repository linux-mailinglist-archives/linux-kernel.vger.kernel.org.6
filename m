Return-Path: <linux-kernel+bounces-206629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 979C8900C20
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 20:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 081B81F22EEF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 18:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84AD614B94A;
	Fri,  7 Jun 2024 18:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hB3dmpwt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tINR6m36"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E25149C77
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 18:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717786474; cv=fail; b=m8PcMabJKDOjpplXxjesNaOJoQkhOYrVmIA8couG2yesa9HX5UXQhvRYJM+lSsAleAm4Y32fLWe7TPktcQg4rahB44fs+WT8aVJUfptGra4rUUqw+n7J6oGfgFJDsH9700Gc81OVLjtjGxDOGSDblgtV1hXYwgEJnX9ru0adZdI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717786474; c=relaxed/simple;
	bh=twyEa7nc1jUOjZQ7aiChVpp0Y5Uf4/5pmGd9pxuukg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SjaYlpFhMrSE8PMQIkTGovFm22ARzSSuJ1bkTfdBuycWy1xnUxNNVY9TermEqpD94dqTi0Qto/nVq/gjVg2H53JWtWmZgHUrMqF7AahWpHbxCoP3VddxToxz/yxSJ8/agVjHlgnEALH1ob+1SIH/NKfZonVmswC3Rv3wasqZa1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hB3dmpwt; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tINR6m36; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 457CuejC009427;
	Fri, 7 Jun 2024 18:54:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=corp-2023-11-20;
 bh=qD9T/3YKT0sotRrS3Aan2Vhb5C5Ldo9fYDTe76XpBLw=;
 b=hB3dmpwtzhm1diw/a4epSgZnZI0CrwIZ5uzeqVkCrKNv0mYiELNI7Cs75zIxxFNCN/f/
 ENcpQctPQl/Tnkfd6/lG26DHASd/9iyytuMfcXYhMBiXDTQ+me3WrWpQcZ1ye32c49xq
 gZza0J+SkfjisBCE/ZXutY7gLHkSUlhkG9nyxfSMvKP47BR6u0PeuN4Cp9eowY1NSPdq
 iMtW4GIJ/2adBDBxpGHH0DQbH+zdj8fJDa6O+7xbZMFMfr8oG6DUOd2z1lNA3Cjov6lS
 7TjMglL+iBXUV9lF1dZw25YkFTmpbfS7fP89HpxmNzwaYCyDNllTDlnPgANYl3CZikVy tw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yjbtwe89v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Jun 2024 18:54:23 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 457HOGFw015573;
	Fri, 7 Jun 2024 18:54:22 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrjh0eud-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Jun 2024 18:54:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gN8E6wblX9o6BXfmi6/WciUPqKn2QYZj8HPdg7b9c6BMDz9GaqR/mlwcIC/DXyY+IkWwoVo1qSe7OpDrxUxU5zkT2w1e+zvFuty62jB0N3D3/snjZ8XjAuECDeeW2b/KBCeKepzxjACN8EYeq5pZHxMs33Q2jXEhUl92Ypzx+xZoGN3OaRbGg1vSNnCMSYErugsxGjFSbP2OSVYbljG+fczWgp82wFEnKk/qJWYRoFI8aeNxsdk2Xv8h9WFbwI2XQvMKNsVrUGqcAEW/LU2NxXVijO28wYjwwtwCvNhmS2YPT9QL8YAIPXBzRchgqFsBl0QLCgDcFvTU/B80/nZRqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qD9T/3YKT0sotRrS3Aan2Vhb5C5Ldo9fYDTe76XpBLw=;
 b=a3+EiorbpSuXy0gRtPoWV/hhjNHh64yWTIl7ge3zFwqQevleQwTmPXhqAKqor3Pikd4tlLRZE7S0QcQKe7G80dguSXYaP8NFuLrb2GmilCKltLpzx1ayzpc0FCEbtO8VjvWheau5MteiwUglQ/O8zoFB3jsxvygLCl3uxX7apfdqhx7U0oH+x6cpw72xub67J1ShSneiq0QZ94AwFV387XosDzr6QjzfQ5lN9cJvn61Nno2vlwYmHdf57EL6NKLSCEFJksiiOurNFbzqGtlYzAqXm/JfmV3HygdKpzbhZRLeUVTX7C2KLEx6bsTkB+2xjRjwMIe5p2PweYTkbe3/kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qD9T/3YKT0sotRrS3Aan2Vhb5C5Ldo9fYDTe76XpBLw=;
 b=tINR6m36nhXBZPE37wmA5o0s/Nqm0aFsK2dw3t1XiS7EdO+LSP48sRN47tphNL6ikvpi5XBs+4oAMaxFLfAIDw6hE7tmJdOgCRO4yAeOQGWJv0mw5zhD22zDHJPpWimcZBCfqrvDmqLjztJxwpHEV3+voILyR6vrN3epM17sOSw=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by SA1PR10MB6640.namprd10.prod.outlook.com (2603:10b6:806:2b6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Fri, 7 Jun
 2024 18:53:50 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2%7]) with mapi id 15.20.7633.034; Fri, 7 Jun 2024
 18:53:50 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, liam.howlett@oracle.com,
        willy@infradead.org, Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v2 15/16] maple_tree: remove repeated sanity checks from mas_wr_append()
Date: Fri,  7 Jun 2024 11:52:56 -0700
Message-ID: <20240607185257.963768-16-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240607185257.963768-1-sidhartha.kumar@oracle.com>
References: <20240607185257.963768-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1P222CA0030.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::35) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|SA1PR10MB6640:EE_
X-MS-Office365-Filtering-Correlation-Id: ad19298e-5ab0-4cfd-80d1-08dc87232b4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?g+KnjpAIm5Drcof+9+ZjiQxYbdYe3S9WdSpnOJ6bryfPf8BSkuaiwVWJ/3/m?=
 =?us-ascii?Q?MTAqpsb6iE8CUsVYDn4kBOIRBT+LGArbleihSR5PzZBbyHhPcG/ib245m94Y?=
 =?us-ascii?Q?COXLqas4yPmVwC9OMwCgP8mJz6L0b7V9qw//YEqR8yTFq+C0+nXUBaJbpcyO?=
 =?us-ascii?Q?rMkYmXeZqNo43DkAYIuCmH5lruRx47ifxTeje/p6gLP/127paf1vaGYnEnU4?=
 =?us-ascii?Q?54hy3n7qQBDCyQARVtDTDGhs18g4iuxWwxMuVWRDG2s2iEPzrzThHwdb21iX?=
 =?us-ascii?Q?zsGgiusAfO2Uwxi3qDsXUwBNb+OY+aLGAhevznKWiDaPxRQyOOrdDDXOsmvr?=
 =?us-ascii?Q?oqBVt6huGVXW5RxE8lLTNSxLGKWxEmr6HD4kXElnU1zPFpjRm9icGHUGA/no?=
 =?us-ascii?Q?xGBzaktXoynr3DbedL3x8E7GEGFr9WUhfE+gN1W7QqzYwNJWi589u6rF5R+G?=
 =?us-ascii?Q?SJGJ2vtqZUWiVmzke2x8CGewuY//muxzA92tyAp5QvjFN3Z6kgdOol4PyKrg?=
 =?us-ascii?Q?NYsb3VZyTWMriT2wFTc6HOPZzw/XH/n5t828iv3u3PbH+Vx75oY0geS5gv5m?=
 =?us-ascii?Q?DHgUun6kpLtRs8vrFcodHNiUXL5Vwdv3E+JJXJM2TNw6EAOdbWxstkOwB6D4?=
 =?us-ascii?Q?JcGFuPdM86lyJ6E0YR2GNkua6/NhH4XV2OeFlY6KEYV/Ai0aSX6ABA2l0EpD?=
 =?us-ascii?Q?JQd9X5KAi8jF3sKyRnaHzUBVj+ZxG8gnoiL3fd6faufyO0Zl1g47S3cckByz?=
 =?us-ascii?Q?Z4IesYe9xeVsYeOUnHrC6qqXDKBNaV+iJ55aWgTm0XLyhZSFNvpvufUs/ScL?=
 =?us-ascii?Q?A06AsYAgzvp3ihJNZAirrX7utrkpfXf9wGJP2AbnhPO1BLO4h6iUbYeQd81Q?=
 =?us-ascii?Q?6x4/Hok2BE8zwEIJ2n8bTW8UONBmamfcdeYShIr0L8ccjXncbg5pG3xgkuV7?=
 =?us-ascii?Q?wDPHNSEGfemDzcN3Jzv/yyf4429QBpurDazbNgvGpXyrvjLhnGPdVztphjMj?=
 =?us-ascii?Q?OAqMCDQvU8JJcVeBlZ3O3KIKNkquMkqMP9YbtLJapmhNUFc7nQhXTCCQihFb?=
 =?us-ascii?Q?nrgGWGTMRZgPgOGupD0Yk+w4+3ZoMl0SFo55JWPHU1fjypo9Ocf/6DiuQNh1?=
 =?us-ascii?Q?BXimGxY2lXgzH9yq5+IW03ojRzLaWpp0uO39JPYn4SCIvDv3XsPtHdpH4tEx?=
 =?us-ascii?Q?4RbHJX1NFLewfYf2O9gI5sOoOj3HWF54czgBYMt+5QE7Dnb3J6lp2aQ6O4ZO?=
 =?us-ascii?Q?pa52KaAskJ8rk4nhyoqsz3QjIB2k4EnA6T9Eh0QHhjSuTH6CZYlEGvPwo9OK?=
 =?us-ascii?Q?GMCtJC4612zbOWlQ8gBZMBY9?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?nsB2iuhWAqqTPKpKAbHU7OtSE6dDDv8aow8MXzJ5HIRVp3IcjtaIME/qyZ0o?=
 =?us-ascii?Q?PU6IIRnnwGwB3DSKWROiU4hBw4ZY38IRtp/itX//ybybIaR+Q2IDeJDRnE2+?=
 =?us-ascii?Q?NJkkoId2dmjwMAumvRi1guQeN2sRal8FlRDalY62LOnwkRSMfM8LEyZVGYoH?=
 =?us-ascii?Q?Hn28Aue5rDbr81oecU9JBBcMmup3dktTmmO2JhcAOu1qBqvaryMRz6wQeaD5?=
 =?us-ascii?Q?5Ba91cm+ZSGltTkzfKScxlEVigkZp3/3OMZXj4pAbBykW4nBgHEoSxzTs5UN?=
 =?us-ascii?Q?DKBezXLNSGqIUFlwfSShHdCDiJNURMMslRieIc/Y5bj5FgyGMiO2G22Ijggs?=
 =?us-ascii?Q?G9UAQ4zo7OcfDM//uGadtg8JTf35clDllRIm4mjNDTkP2/p7yXbCwUZQLx2r?=
 =?us-ascii?Q?lPZ7baupm2h90lrcKfpFl+hcpxCdE4bENf819zwYQD7t8e82MiOl1E2KKxKH?=
 =?us-ascii?Q?3f4VCbvu95+sHQaKKrMBDB3Snz7TAFoZFjJJDsrABr/J4OIPeazMFbw2E/Pz?=
 =?us-ascii?Q?TqOjfTd9gmr+5Om5WtpwC0rTT508SDiPNmnSyZDYhzNfrA+pUogAqUvgV/7Q?=
 =?us-ascii?Q?WnnkuV/SHM55D+nacl2y5cjrn3U4Kk5LcBLmqWndNWhfFUXAtCwTMsZ5F527?=
 =?us-ascii?Q?Ws1D1gJw7GNxUiCNAVruOa2TTVJq1cZQvzEv35a/55QzrYgey50eY7znI/Sx?=
 =?us-ascii?Q?jgq8aNGLVq2keIRSuvCA3eo5Wfa7X8Jf/WxxE54klIHd6Pi11p5OAWKbLJRN?=
 =?us-ascii?Q?eX7YSthSvdTYHhKn5M5IM7oV0hQIuP0h8YXFwwrATJjJEmf5okcljuJMQp5V?=
 =?us-ascii?Q?44u42+XsKYfEAKOfydAgD+aGNkf/RZzMThozZKq04M41KWIGdwn3PuYsFDgY?=
 =?us-ascii?Q?6xLu9uZxviFByhDfEKYIzzB8P+m2h+eS0yujYYzWVZXOQIBdgy6lxo7d59Ym?=
 =?us-ascii?Q?xranvHgbhEHLRVDYcRauqKktlwQVb0qs2AOclfGz2NhXsQkRZlYsEMVo2eKj?=
 =?us-ascii?Q?0nDa77eKM95u+omEjHvYbLDiEJXTpZ75LMGikdisrbRPKa7o1AzHUqLGbn/0?=
 =?us-ascii?Q?ixmTZUjdYzj71GOe8xdmK4gNJI4IB0zcaC3QMj5DtP68aiV9dypHcur/CoCF?=
 =?us-ascii?Q?wtlZVrrL34SbofA6t85xS1L32qn5Iu7XEUR/cQL6xmFSA7sOGEKAYLdNtQTp?=
 =?us-ascii?Q?N27WElhNMPd+xz0vszwCoxUJPskq3aSP/ijv9OidoTxGQVT7REUfV9S2UcAw?=
 =?us-ascii?Q?O8HKsQAowY93G/zGj8ZmBUUXZjcQgaSr/mb3sC8fZbfs/LQspyuemmJt86eY?=
 =?us-ascii?Q?l2cQoCANqqJsj67GLz+yLnvjUbMBhBUoYJ2jWw3vbOiP0mgF7RcHdfX0tT9o?=
 =?us-ascii?Q?4C8JtkfCc9Uz3P5NC79kdOUfLp8NgBzeWlPzGgMlG8uaWWirzqOWK2ye+32p?=
 =?us-ascii?Q?o7Gmb5ibU3PPr3VpC7I+Dv88v31ey2AzbpN66oO+PNZpu2EOCxRac6jNLIN6?=
 =?us-ascii?Q?6C7hspyxb+1YSylI4RQvJOjIBi6KkjnfaRAY6G1Z5E5gh79leeQjRJr7D1bd?=
 =?us-ascii?Q?9Ke1B56Oph0ACIvi9bAnMrmWdKkuhTPIOAVDESij7BJu5ORQUTesw5io5qEG?=
 =?us-ascii?Q?Kt+9Z2LJXA0EyjEmV+6d88U=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	9j24szKgbDMOtp25WrY+dQjj6Z9f+ZUaqYGPOTvfjngl3c0CwVsimUIb6P1YxzGDuladSwTOg/LZCcZgF7EoCzgYJnNim7T37H01KrotL2DZ3oQjKxaa7pqFG/1ziw/zCyMdNhCA6hqoytSDnZ7CZPExqk50etgQDy8NBqgbsxs+0lJs4u/VK3HKLIlaG3bygDF/t8xsSnGii7xu6ffy0hpQhDbRoTJ5GDRMS0KU2Kkd2A6Wg4BhnkxXbgtuNfiTrgv4A3+Mm9GyczLMOGEVGZHfm9O/XPb/YCGv3TzzBhF41wHozXK/sK6At46YXuggROoFuDjB6Ew1XKhfY3r9zFLpwst/NgzEXn0qMTDLSIOuBiFj6YsDYJVbJERTW9R5bCNz7sZy1eIo6sqVUrqoMVfeimGdjkDjcy66mgpw/EzSa9LmihgpG2GlNhxP3fWelC9j9EbgeNlFBHAwft0EEGhvl7AiOlwRSdAN/wudRKdXR1k9vCSETD93rGCnXhA2JngjkJUdlQvfkplfxmjMOTsdTRtzt0UVWOQNJfx6XXGiG7AQuAmNMxChx/+TiABjzG2cs29WjvtyrWY4zjk+MMccFI2Vtw356pwMEFkiZVc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad19298e-5ab0-4cfd-80d1-08dc87232b4b
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 18:53:50.1525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qx7uA8Gmg3RhZFMoZNnlLZ0f5YrfKoNgl/TuCsc8ijSkpikDO3qWIgGIr0fBu54uZ3OBN7rBT2Vy09c7UVEY624kHKQLvhOYmrVwxV1rRf8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6640
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-07_11,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406070138
X-Proofpoint-GUID: fmwPz5ngUnBY-ED8L7xBSPWBZw_do3pF
X-Proofpoint-ORIG-GUID: fmwPz5ngUnBY-ED8L7xBSPWBZw_do3pF

These sanity checks are now redundant as they are already checked in
mas_wr_store_type(). We can remove them from mas_wr_append().

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 lib/maple_tree.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 7e1f64490662..3d334e7c19a5 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4061,17 +4061,9 @@ static inline unsigned char mas_wr_new_end(struct ma_wr_state *wr_mas)
 static inline bool mas_wr_append(struct ma_wr_state *wr_mas,
 		unsigned char new_end)
 {
-	struct ma_state *mas;
+	struct ma_state *mas = wr_mas->mas;
 	void __rcu **slots;
-	unsigned char end;
-
-	mas = wr_mas->mas;
-	if (mt_in_rcu(mas->tree))
-		return false;
-
-	end = mas->end;
-	if (mas->offset != end)
-		return false;
+	unsigned char end = mas->end;
 
 	if (new_end < mt_pivots[wr_mas->type]) {
 		wr_mas->pivots[new_end] = wr_mas->pivots[end];
-- 
2.45.2


