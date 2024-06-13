Return-Path: <linux-kernel+bounces-213445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4726C907574
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 16:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C59641F23809
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 14:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669201474B2;
	Thu, 13 Jun 2024 14:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MN2fwv+u";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="d9kaPE8b"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F902145A12
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 14:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718289647; cv=fail; b=BUD4B0jfePbqVXNYiTVrw/jkp2gniTmw4AKDn6+Ca3eZGoBt3Z8AH94HKbBK4eM1A+eSFFdtGskWbgRhxNCfwdhFXX9oQxf92HNWgOOiNQuhk+hnwzXe7CmjyScmYQr1JRzxFohcKubkv4fSd9E6QfSlxLKQMl5vG1+qoQnbFfo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718289647; c=relaxed/simple;
	bh=Y9ObYt0CM533QwRhSvEurmT3FxyyaydkUuXHjDX6Q8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=b8G61tZdDLg22KDfHN2aFubBIO5RUhkodqT3SbN+BucNEs5NduWhg8fZBE/N2QFLdmZs7mQoPNM5ZRpDsxTAyDWPQDQ6ARF4DpSDG9sgqAvpdzTVdddQojeKbZ7g1GYRdxkXxFA3NkpRTGqoKNm2yjYzzKo63gm6Zkz7XYX04h0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MN2fwv+u; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=d9kaPE8b; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45DBtRtM011440;
	Thu, 13 Jun 2024 14:40:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=2T16Uyz9/32bBWT
	4mon/N5mnQf5tyOATI0Ar4qAU6N0=; b=MN2fwv+uIcqNI4UVttVlTTxWKI22KRx
	5buThmQvdGXAIH5faZCMUdC1vifxOjoHKwRJIT+MA9aulcIHHjeFlWRSoq6A1sYn
	PrXgnPXE3HUC+DRx7LQNYMMlhGFqtBIhHTxtLHOu8G0yggT21Kdp9i44dJsF99Ju
	tKL6FGATndiLI/45dGrSRAhx1XWQfpuyWmwrcx9xr9yQ4T45mN9k1jkhpgb6uegi
	AyLesPw2fU0BXJATQm8LgxODtMpHyY579fMRlZc0L1w5rpYR1cmjEaQTJ+8RkwjF
	1VlYSJyXKX84YArzREBSaVUD7MAZd+gKjS5tL9i13IF9q9qsVLWJZiw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ymh1mhr5r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Jun 2024 14:40:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45DEP6Bn012449;
	Thu, 13 Jun 2024 14:40:33 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ynca13v5n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Jun 2024 14:40:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jZIiYeHM1yc4tmgCaVbiqHS4gGNro3Mi9G4HpGhqIZaRfk5Gmt2w+h3E9tbuIGB9MFg9Pp8iB6I2a++tNLVE6AZP9mjX+SrTmds2BCYmbGOHzvWjVFIjL1j3PrBYxsCFohyXJ1vdztQ6Qd8M7HZI6iErFM77hFlykgyad0Xjlm3AxQdAhZWQcZUcRCs+P8log3Gw5NK6o1aHr+NcQB9WSL+bJnzQ/hE/EuKt+3mJ3mgPyD+sNHPv5d68/3ggEvkqVhSFoNG+BHwNUmgPHg+tk19Dpgp05tKJaKxwq6sSnn+lPwEVfWQzmbbV7ers37n2uMrEczOyiLPX2wc9asQFTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2T16Uyz9/32bBWT4mon/N5mnQf5tyOATI0Ar4qAU6N0=;
 b=OlQ+wMPok4Tbymrv7Tv190yQOcP9VKUGD3pDjszO687mBftaguuuz8NRWetzvNxr7fP6gIoW8HEtgOQJ+qEPsIQbnsC7cU935pUA2mhqNTT0sOBt1yhVP1PynG6QsWWbjZvsTnaDY1KeljGG1lIIwMokkCJ/dmuYt5kKTL1JwzzLG4g63PTZ+KEHG5RGt7fo7y80oU0qWGRsjrq0dbH5yuhsxI3U/bg4310f8idpMBZ+gCN/3iOL1Ex7EIqwUJceaZ9QT52Oh4vpFhenENh7w98hNUZR3MEzSdFyB2eN4WI4VZgJpRbGQmycl6pqyS0gYY3XZBTxETzSYU94kGUgnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2T16Uyz9/32bBWT4mon/N5mnQf5tyOATI0Ar4qAU6N0=;
 b=d9kaPE8bXNzFsW8fxtUi6vYP5vzZUcKRUvMc1U3IztFMGb/3rvD4pqRAzRxOvctKfO+koVL3Qc0uTtdgr8IrJ4tOhLl5Oh1XrmaI7Nec2eC/+lpOOlEDW+MHu5w73/c7uGZNsnrSrExtLpf1nGIZxt+rRKB5+wGawu5g5qx6abQ=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by IA3PR10MB7994.namprd10.prod.outlook.com (2603:10b6:208:50b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Thu, 13 Jun
 2024 14:40:31 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.7633.037; Thu, 13 Jun 2024
 14:40:30 +0000
Date: Thu, 13 Jun 2024 10:40:28 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, willy@infradead.org
Subject: Re: [PATCH v2 10/16] maple_tree: convert mas_insert() to preallocate
 nodes
Message-ID: <2xqcyocypx4bpwbovxjxplc76dtns5t4qk4cc3yrejjtuzzdh3@periymnnezyg>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org, 
	linux-mm@kvack.org, akpm@linux-foundation.org, willy@infradead.org
References: <20240607185257.963768-1-sidhartha.kumar@oracle.com>
 <20240607185257.963768-11-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607185257.963768-11-sidhartha.kumar@oracle.com>
User-Agent: NeoMutt/20231103
X-ClientProxiedBy: YT4PR01CA0497.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10c::15) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|IA3PR10MB7994:EE_
X-MS-Office365-Filtering-Correlation-Id: 22402690-fd5e-4b4b-4bb3-08dc8bb6c656
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|1800799019|366011|376009;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?ZhAFlzH6o1rY9kS0SbFpzE7k8XeOTsTj6vHmPq/g/PBFCLy7eJSNsDGvMbhH?=
 =?us-ascii?Q?6/H/qJLr41N6cTnNAQNou6ysS88FsVS+fp8+XdqcuqO653bGEbK3BXyOr8oO?=
 =?us-ascii?Q?HJUica6ULLU/97OJk2E0sE3vmOePtLDLE1lBhKzkE/7cb5foD9kCjkiSyziG?=
 =?us-ascii?Q?yTsBvVrD1zcslszFrkSinOyvJ9PK3mVuVIgTzqycqjytrDz8JxW+LbZelmlB?=
 =?us-ascii?Q?/BfM3y+dvu7jEeAKHJE71LRpxV/rkFgxyqhA8w66yC2F0ClRIW/LFJkA2W/T?=
 =?us-ascii?Q?5aJ58p//JvRRnRLIqBVGdiTDAxII8nQHgOvERQBOw/nlQV/e+AKvNBtZY4bE?=
 =?us-ascii?Q?vGFA8++keM/eMRi0AJ7pdIjgw7C3rqpCLhZwJ9uWowN/h9TyJLbBBFvZ8hJl?=
 =?us-ascii?Q?zhuOHTjvPFanyE5+ZvnBPmHLKFFGzDfoFrJO47r2xVo80YPpFqtURjmt7y3z?=
 =?us-ascii?Q?QFmjeUjcek3AVhQvY9RfaPgHhfO0tKXaJbK8nf1rpT4zP0jrzqO+BJIuVrrY?=
 =?us-ascii?Q?bhe90MAGgTut9hQhmmh7sU7TsUhSqunrKD6Ig79tgTQNfVCD548n/tg9dnYz?=
 =?us-ascii?Q?PQpYinNHiW4g94Kfh/eAqv+TiybIYQ+vmLIHutLaHAE4aqyHVoShcEugBmjd?=
 =?us-ascii?Q?Nyy/mt5Zc2k36C16u/Kxo5e0XmR/Lkjem99he19AcBKO43gOwH10Z3J/glXY?=
 =?us-ascii?Q?vO6y5OEhNhmWwmZmkYrDSEWlbM0aA+IVydaC1tozM8mNWMYXMZz5RAuEyjLz?=
 =?us-ascii?Q?V4xshyWterFhREKBnBEnXaru2z0qDYSpWV1thNECQy0X8vj8xYmR7oAjDtpn?=
 =?us-ascii?Q?h+MFDYjRrxQieabXD7cDl5FnxDArTlacEFy3jGcdsBkO/8fYst61B6CGPanv?=
 =?us-ascii?Q?ur9WNbPTURf6Sm3c0bBRs4yVfZzjpY6rCp3yqa+ZZuqUxUJ3kcb9exa8tbHb?=
 =?us-ascii?Q?FiRjSuAreYzVgajVqEGUuY5Mwd0U26rx2WdItlZ9myv10Dm7WsZ9X1oL4x2e?=
 =?us-ascii?Q?4x0WsjTG47L/h+AMvqBAPPfohI6t9WsecQ9tp7Dbt4WEpAk4Wt7864S4egv7?=
 =?us-ascii?Q?6pn80X/Q4YzbFbQnW42YUU70Hexjk2sQG0erqSm27yUsBiGXUbAmgRALmSDW?=
 =?us-ascii?Q?oXQbZtg8q+6/cXJNfsO7WI0ZoW+sz3fNg6FSGHwfJPIbC+v3qyyjD4+ms/GC?=
 =?us-ascii?Q?9XTqM/M52Uc5cYELq35A/wd8b9PZBGU8PiIw188vYUR7W/bF5oLrCW/uRMfM?=
 =?us-ascii?Q?oam6Mu+ld07RZb0+b5bqIU0JBV9YPzV7ckZbn9zCB6G7TnUIhuG7ps/uqpWV?=
 =?us-ascii?Q?FdwySehxi5trZVqvLJdqwI6D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(1800799019)(366011)(376009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?QL0Sa25d39/DpHMbV9ajVE05w63ZbXeJlKp6lrXo8h0uaCBWLOhkv+baxBS6?=
 =?us-ascii?Q?7JnaVQRt54fdz/TczHj0iPmupMadckD8WQ8p6FSD0UmC/6lYRPeJVEIb1EzW?=
 =?us-ascii?Q?57IrPNjBw5seP/T0+sSHt1eILI9C5tPdpG1GzUDXMU7MxLriyhbmTmdv/hqr?=
 =?us-ascii?Q?29toCB6uYWudUFWQ65j0mMewksMM6p58/rwxNyvA+jUawZ/cuD4HiznqjbF2?=
 =?us-ascii?Q?9crbn9aF+rCyBcAxuq8eY4Rhs3Y1hjjhARLrzUUVhjaR7ZjKqdWWCecLh0vx?=
 =?us-ascii?Q?JfrmDLM62wjhgV5k/KMjN/GtSyxxXb3AkJdLdnbqE4yhTntW8cSccjPG03Rj?=
 =?us-ascii?Q?bXHYeI2ppjPoyJOAd1jGTFeLSjjmKRgrb+h+AqBcMdLDR0FVWlvJ4VSYDp0m?=
 =?us-ascii?Q?k/RSsZP7skIIjU+bCcunRyOE06iKv//bJqjk3J2Kvih9bcJYeMb2RERU858s?=
 =?us-ascii?Q?SFn3rckXfbbKyHb5PrQiaGMQ+EDzsyS0+1/8PECz0diHepE51lS2cZy7ZG98?=
 =?us-ascii?Q?VcxLigknlzjpckJ1IZrKEGR6JDufgeZTCKHWk6zMLJbFZ6QqptACqua6ei9K?=
 =?us-ascii?Q?RHonJtdZJr5MlM26S2dWeqAwAAGAivoafdUQ/yVvzq70b/Oe3SYoctc5Nv+h?=
 =?us-ascii?Q?Up3zdZjxJPR8p8/ldKflBx8FT1LOS59BdRqTBIoZ1ey5SqObNO+RVuqFASGy?=
 =?us-ascii?Q?EYtWEP3nHd+MQeBUvq8Qvqo4htjKCI+uZ5QecXytDEzwYsAt+3HQP6TlnWYW?=
 =?us-ascii?Q?dsZ2kR7vp0LwusI8IkgJIy6c5t+YRTHPG1GCztrMlFgvzDjxJ4ebW4Z/K9CC?=
 =?us-ascii?Q?VrMFMwsrYOUKg4qLoqEz7Sy6s/3ZjAKtxlSKLHBmmCiFzXXMKLBRh9lpvno5?=
 =?us-ascii?Q?QH6JYA++3WTpXVif+cqzRFey0DBEQYZFm5W422j4aZ0RTfFSksVBIKkD9neC?=
 =?us-ascii?Q?mBahYGFnP5n/40osryQS1B96cpkBn0lLzhrs4TACXWOApExRQ3Y2u4laIz+f?=
 =?us-ascii?Q?p6qiTOFA+xdmJkjy0K2CTvWHWKUN/dAmuFf4m8kGl+zGHQgvDIpdHK7PLTx7?=
 =?us-ascii?Q?kIwORPV2CrOuq2dVssH0aEWoGOnOSGFXXpEactHrR6lM4SDLLYo6Crqi1urZ?=
 =?us-ascii?Q?ucfnPDSuDFeinIm8VHCeOhQ31QX+V4KreEwnRkHND6cKlB0EAKMC+50+8L5k?=
 =?us-ascii?Q?Z8iMsnfbNiMEoBJBlpryGemTisZiGC8GnPP+AJeo1Up/UF7yr5RczJUuocKg?=
 =?us-ascii?Q?Kde2RLcdIc0u7RY7eaTQBZy0wWnVnFjcM3E24NaMXAhpTuEBucp8IiKgL9rq?=
 =?us-ascii?Q?QlUUhHYz832Ja8GyKX2SAsAE3BJxiQ8qGla/IBC4M3GI7LK8b4jDUaiOOskt?=
 =?us-ascii?Q?kBb+8YQRqiTiL/WN97wsOUtWUqScU25TZmDg3HKOWHTO2oUQIeXsSP7RcV8z?=
 =?us-ascii?Q?BZvKq3OVGkS2Obwa6QmjUJIJsvau1DozLt/nP90o7GeWqjFimUesgNGbR12b?=
 =?us-ascii?Q?h0F434+LsI3FQMFG3iTv1d8kPbVhZIU/bLx5mCakWu13BT45MwdNWgCYkCKO?=
 =?us-ascii?Q?WIOPmkWlPRCLMhNgMJHBQAfJp8fsr6GGM96xnZ1hGr3nn9hOPprE0KX5Wu1X?=
 =?us-ascii?Q?5w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	BE4py/VO97N4wFXoPL9Pn7/5AuLXepd/SYPGwl/CRGMsuuNDv2hkibR4XrVQdRg04k96XvFeI4VUnqTWi3XSjPNzmt5buGkIcMwlZ3uKbL2hy7Eo9+ZsSpsK02BCFHCkmVEowPGm1v5m7u/XL27ufJ/vTpX+ChZE3mvr34Gn+omDW9esNnevwQjg9Smr7Oat7BDrp0/IQ/qSrcgRsUIodVEvT3SLLKbkm+hPwCO28dg/7zqXmAKy+wSE+dhlxsq1CxNOvMAGFXQgS616c4ODeY/MURr4hzL/TrNR0ZK9FtobVUp+mNSopTsaAgCXx9MygV2x3zcrEHCo80ZGPeMI7Rs/gCJu+iptJ7dO0pyIZP9lnQbBtCLG/L00xLqb7KVMPqYpqnT07PT4cGpN5wtwJds8utkFBauEEGYa8sO+E0tu3ArpRaO3vn/NjjCqJ8FPjv1GBjBwWcwbwRHiH4wTfYxbmTBJJ3hZcLzVl8CEKFnWTgVDvx0ZhKUV1U7qkWDOt9cKrj7Yw/9ZOYlHe5F6DRcEeorPCikhsA0lMqXREw6lqNAgOrtD+AFk/I9Scj7xnZ2OIeWpQiiA6Q+tokhnxhAPgIwFMPmvEHe9OdKnhEY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22402690-fd5e-4b4b-4bb3-08dc8bb6c656
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 14:40:30.8904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2rUthGr4zqbDR2ts1hkDrV1spQ4Z4ucgATDaO5GLNbG8mI7gw6t6agf6yOiLrKZ+tZZNXKitphG0hWhfoIrLgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB7994
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-13_08,2024-06-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 suspectscore=0 malwarescore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406130107
X-Proofpoint-ORIG-GUID: QHXH_HZaFS_fptrxKEcjz-bIn0mHUd8E
X-Proofpoint-GUID: QHXH_HZaFS_fptrxKEcjz-bIn0mHUd8E

* Sidhartha Kumar <sidhartha.kumar@oracle.com> [240607 14:53]:
> By setting the store type in mas_insert(), we no longer need to use
> mas_wr_modify() to determine the correct store function to use. Instead,
> set the store type and call mas_wr_store_entry(). Also, pass in the
> requested gfp flags to mas_insert() so they can be passed to the call to
> mas_wr_preallocate().

This can be done without passing in the gfp flags as it was done before
by using the same flags as before (GFP_KERNEL).  However the only user
already has the gfp flags to use, so this makes sense.

We may need to add a _gfp() version in the future, but most users want
to mas_store() vs mas_insert(), so I'm fine with this change.

> 
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> ---
>  lib/maple_tree.c | 33 ++++++++++++++++-----------------
>  1 file changed, 16 insertions(+), 17 deletions(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 2c42e99c400c..c37bfac4f622 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -4442,11 +4442,12 @@ static inline void mas_wr_preallocate(struct ma_wr_state *wr_mas, void *entry, g
>   * mas_insert() - Internal call to insert a value
>   * @mas: The maple state
>   * @entry: The entry to store
> + * @gfp: The GFP_FLAGS to use for allocations
>   *
>   * Return: %NULL or the contents that already exists at the requested index
>   * otherwise.  The maple state needs to be checked for error conditions.
>   */
> -static inline void *mas_insert(struct ma_state *mas, void *entry)
> +static inline void *mas_insert(struct ma_state *mas, void *entry, gfp_t gfp)
>  {
>  	MA_WR_STATE(wr_mas, mas, entry);
>  
> @@ -4468,26 +4469,24 @@ static inline void *mas_insert(struct ma_state *mas, void *entry)
>  	if (wr_mas.content)
>  		goto exists;
>  
> -	if (mas_is_none(mas) || mas_is_ptr(mas)) {
> -		mas_store_root(mas, entry);
> +	mas_wr_preallocate(&wr_mas, entry, gfp);
> +	if (mas_is_err(mas))
>  		return NULL;
> -	}
>  
>  	/* spanning writes always overwrite something */
> -	if (!mas_wr_walk(&wr_mas))
> +	if (mas->store_type == wr_spanning_store)
>  		goto exists;
>  
>  	/* At this point, we are at the leaf node that needs to be altered. */
> -	wr_mas.offset_end = mas->offset;
> -	wr_mas.end_piv = wr_mas.r_max;
> -
> -	if (wr_mas.content || (mas->last > wr_mas.r_max))
> -		goto exists;
> +	if (mas->store_type != wr_new_root && mas->store_type != wr_store_root) {
> +		wr_mas.offset_end = mas->offset;
> +		wr_mas.end_piv = wr_mas.r_max;
>  
> -	if (!entry)
> -		return NULL;
> +		if (wr_mas.content || (mas->last > wr_mas.r_max))
> +			goto exists;
> +	}
>  
> -	mas_wr_modify(&wr_mas);
> +	mas_wr_store_entry(&wr_mas);
>  	return wr_mas.content;
>  
>  exists:
> @@ -4532,7 +4531,7 @@ int mas_alloc_cyclic(struct ma_state *mas, unsigned long *startp,
>  		return ret;
>  
>  	do {
> -		mas_insert(mas, entry);
> +		mas_insert(mas, entry, gfp);
>  	} while (mas_nomem(mas, gfp));
>  	if (mas_is_err(mas))
>  		return xa_err(mas->node);
> @@ -6536,7 +6535,7 @@ int mtree_insert_range(struct maple_tree *mt, unsigned long first,
>  
>  	mtree_lock(mt);
>  retry:
> -	mas_insert(&ms, entry);
> +	mas_insert(&ms, entry, gfp);
>  	if (mas_nomem(&ms, gfp))
>  		goto retry;
>  
> @@ -6585,7 +6584,7 @@ int mtree_alloc_range(struct maple_tree *mt, unsigned long *startp,
>  	if (ret)
>  		goto unlock;
>  
> -	mas_insert(&mas, entry);
> +	mas_insert(&mas, entry, gfp);
>  	/*
>  	 * mas_nomem() may release the lock, causing the allocated area
>  	 * to be unavailable, so try to allocate a free area again.
> @@ -6667,7 +6666,7 @@ int mtree_alloc_rrange(struct maple_tree *mt, unsigned long *startp,
>  	if (ret)
>  		goto unlock;
>  
> -	mas_insert(&mas, entry);
> +	mas_insert(&mas, entry, gfp);
>  	/*
>  	 * mas_nomem() may release the lock, causing the allocated area
>  	 * to be unavailable, so try to allocate a free area again.
> -- 
> 2.45.2
> 

