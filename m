Return-Path: <linux-kernel+bounces-279951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B17B94C3CC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 19:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF4F71F22808
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 17:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E621917C6;
	Thu,  8 Aug 2024 17:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MNJTCbmd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="0U5o+Qw0"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFF8191466
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 17:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723138308; cv=fail; b=pEaWUH0n5q68B5d99BGvZngjH/CIZ48UpNJvCALclqSeDDizuZQNQDyso3xOzFkWL1AJ2hCE6LlLm6r0dkrkpudA80h7VbY0FoUvqLSscuxoFt+DPAsot3m6bBIBLBkdYSZEFYEpE4urJHUUQGVZ2hRl5plBMwdc1ZkXUUQpziM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723138308; c=relaxed/simple;
	bh=mebltZpz0RjAS0mI6jWNbWplrvz1JDybYTgvrOx3zeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=D+O9gPXy5s3LjWcxAGXuwcmdadQ+4lu4h65HG43s3cDte061NuHwt75TP0ovymDjrK53/hjzLXvzl3chddp8YGk0qZfFZLn2RSTV6MKk0IPhG1iwr6TwIcsNxUviYjEMdzfDvnagwJfUMRUIyeMFDOdiTLx440vpp3WbRMEWlds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MNJTCbmd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=0U5o+Qw0; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 478AMY19024565;
	Thu, 8 Aug 2024 17:31:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=C9m/KGP8JbjtqI5
	d8Kk9VAM6uBJWbefK+FhDm9Lft4M=; b=MNJTCbmdvC1MzOTGMHUyvix1qFX5wiY
	7btlxVzgsM/AVi6Ji9ZqCSHrrpej92u2k1CTZHrDV0hXTN/v7NH2Y/h2nWpPgv0Y
	WSgIIoASXrb95snpxWBuoaTsivnbe59bXQW2V4MWbZuoTxHTrF8OQ5kdWjrfbOuq
	RyCJ3DDM+dyrSSqLQXrzgCQb3eO5Ds6Gc8+rDXtK2USbPKuWbAEggoy2cEfRTGLn
	qOB9skonYKczLG+JJ+gH3UOg5x8XHTZgJyguHClaDYALCXVlUG3vGBlw0Fr0O+zN
	jeKFRUOmQGlDbRO9ps/8DvwzG0Wf2+jWJjcIMxavZTs9JG5vjhZZFDA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40sayea92w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Aug 2024 17:31:34 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 478G2quB023765;
	Thu, 8 Aug 2024 17:31:34 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40sb0hps7x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Aug 2024 17:31:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PnOJpHoTDdFakHoprVGkwK5nvCnk3b6qwXo4nHk1tWdEBbXzElp+81Az6hSz9O2cThVBqvqwIS/CYguiJaA/A9y89LPBiLxCGgTUp6rv8nE1QsykQ+cEs4xPawCHByr4nrhCGOC/Unu5vQ0GxUlcY66I7NZdlgwUm9GGEjzjp3wyHbI5tr/+bp8UDvPSf1k5YgrIptoI7Aqw9mpT1cVE//5LCiZu8oqlANR07tP4vZpRtqlaJoLBeI20bp0V4UvukV3jk9li7idGNVNbEK5OvhccWe+Ne6hG2MPs2Y452FrUwIS5qVQgkrgZgFwYv3lIQwJ/uyisrm5Rvk/uraO5Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C9m/KGP8JbjtqI5d8Kk9VAM6uBJWbefK+FhDm9Lft4M=;
 b=slIVcOilMk09/cT+gCOXlBD7E86U32WHsopaHMR/fCzc7cOtoJPHU+ZUWM7eKXSa7TXYLbLh3Ly6ex5+f+Hzqb8XlnyRj80KhYWMDNpv/uCRqWTlWvrcS8fjK6UIAcgFVcXJe+vYJJxNVw+fEa/Bo3UwqnsxqCpyaIj/MT/x9gorBE7ftQiICfUXgCd7LtXPv3KOwfgwh81OqLnkmPBPo6vvnoVnAm82PGIzrJVW9TBnbQ2kuzZ9oqUwFXauZH4t7puarMsftgjfTKe64B0UGgnzDJ8SOmQYVgJcMSlf5HkFb/zVfAT/EKVoIt6dZj2e5a20N3xoriePeeCISXG3zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C9m/KGP8JbjtqI5d8Kk9VAM6uBJWbefK+FhDm9Lft4M=;
 b=0U5o+Qw0gZNzBNza269g+9J49keEZvakZ0cRh/2Kw2YXgNDbg6rSLfl1cd27IQt4CeRas6//eEM6rcnDKB4H8RpZCboZ3imhq1vtd22o1VSO5Irt3SAouQXEikcTCLTbMnRbL11k6z+Cd5BusaUzAVlWyeykrI0yulC8nxhW528=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by IA0PR10MB6769.namprd10.prod.outlook.com (2603:10b6:208:43e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.9; Thu, 8 Aug
 2024 17:31:31 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7849.008; Thu, 8 Aug 2024
 17:31:31 +0000
Date: Thu, 8 Aug 2024 13:31:29 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, willy@infradead.org
Subject: Re: [PATCH 2/2] maple_tree: reset mas->index and mas->last on write
 retries
Message-ID: <lxwpafvlnw5fyquhehlfoe53hqtfmdo42krhzxacurjpu77r2d@zmzxm6mh7z2q>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org, 
	linux-mm@kvack.org, akpm@linux-foundation.org, willy@infradead.org
References: <20240808163000.25053-1-sidhartha.kumar@oracle.com>
 <20240808163000.25053-2-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808163000.25053-2-sidhartha.kumar@oracle.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0254.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10f::9) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|IA0PR10MB6769:EE_
X-MS-Office365-Filtering-Correlation-Id: a4dc4865-017c-4fe3-cfa7-08dcb7cff17d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bj2B0otB+24hoPmgCmxwyR5kb41tH/ePTllQDNtpQ9dvXz8JgiHqR6yZ3N0l?=
 =?us-ascii?Q?NJizeiJfHdCU0sTkhQEfCyHTXgFrrjqBGyEb+QXnIg32aT3nXx3l3KPlYXnH?=
 =?us-ascii?Q?ye/NagDFbHeLDqbmxMhq7uxtC1g5bitkqyDRF7qezw+FU1oFqOj8LZ8dVCUg?=
 =?us-ascii?Q?Xts8vMie2Evd6hYIZywBKuyOH/JU+8lNByRy0diI30rrElo1sxOGeDk+V7v1?=
 =?us-ascii?Q?JDSmV1VGO6EPVuEv+0Bh+N563F0Uj/FJ9ItKvLvhF3ykg6/43zC1avvXN4l8?=
 =?us-ascii?Q?cf7CSWx0nnuc0Ti8wRsykJvVGU3tToJg/S1u+ATIDy0nSXPW/S1B/zA2UW64?=
 =?us-ascii?Q?GwT5OaciuiqA6O3F+9VyvEEUMU71P00nxQF/ln69XzePW7eqi7Ij6mI7Lovb?=
 =?us-ascii?Q?N8cuu3AB/ZaYSsY0iR3mSw6iMwX0PCdSf5OzESQVVRJvqisc6MUDp0Pcc5NA?=
 =?us-ascii?Q?CniS9XxgsX4pwA9kUjJMXkHogeX/3WzWpq9i5/KvXKdmxODiaP9QiEb6oJNK?=
 =?us-ascii?Q?PcCK/J4omWJdtiv1+2OFMN/BNPtPoU1AIdiLgpO+4skMClSrgKBJAeOBGB35?=
 =?us-ascii?Q?0jTokHTCWtrQgmTNJpUaYI+3LbfX/YjjGKB7SaIECykrX366AKrE3rax4Iy6?=
 =?us-ascii?Q?YQ6nQZZ1hL4WFPNdfUzpMajRTa9MzC6wXc9BETOS/RL/sejmYPXScVFc7O74?=
 =?us-ascii?Q?aU+VY0Qx69Bg/WPbgWWvUhNUb+sLM134HlA0D3LOLLSe8uXlOgau+mI++etQ?=
 =?us-ascii?Q?Q/NPINxrMtJVJ7tRAKLha3n+3N0ASWeM3U9Sj2NfzAltY0m+a86OiLsdFtJM?=
 =?us-ascii?Q?0OquW0ynpqONJP6q3fe7emY8AFYhzc9c9Q3w3utZG01DzkQeFPvH4nC5rtix?=
 =?us-ascii?Q?YKAHzkdW8WBbSzusfsTJVlRTsxk+T6mpjqfFjAPvN+ay5MrFSuPU7kM+G135?=
 =?us-ascii?Q?/66r5FRWHwUlLh8cc856KYMa7K7CnqdveTIfCN/JxzW/Y/iyLENt8TzMrrnM?=
 =?us-ascii?Q?Pt/CM3OZ3muPjknh9nUwmHUOU38pyiXPS3ZMX7qxtaIP5EAYo9P7pZJWGlRq?=
 =?us-ascii?Q?fZeAxNsaFWCsmp6sZA60SbL4LjV3B6UhoOitsNBABcUN+gWF/Z1xe1sIkTkr?=
 =?us-ascii?Q?LFOwSY65Kz0qSgQPHjo5wiZvVhehuCo7sR/yhLAlSmmhtlN/RK6B5+w0nm3V?=
 =?us-ascii?Q?mQYGWXsvgzr9sTA3CTC1s0OLHyn0iBJ71AozrRYCpRvhWKwnBAact7Y+1bqj?=
 =?us-ascii?Q?xcQEvlIuTBrQ5LDDrs0VE43lVM6EEbeLRg2yT/oRlPpK20piHZnfUXj6cujW?=
 =?us-ascii?Q?3+jrYGbHXOhU9pRJPacb2PO/wCEZ+qaBNJv5uZ98E/jHVA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?P3dYNrKqQhvVmvTOE8+Yj8bPPuDzm6m7AIeLT/wn9y4s1/UNvG6r7D1qCIM0?=
 =?us-ascii?Q?DM4vWAlSu5ANPVTRtCuAsPQw93WuoS386sQhH9bBAv9034Qj8RlKGUpRjmW4?=
 =?us-ascii?Q?3lPYKhcdd1QUZmRGBhsGJDwUvT/vKk6GLvOvoBS9ML6jA9KeZ2QBRAMumGI6?=
 =?us-ascii?Q?Fxah8N3OtWs4+vKuswViOrn9h9aeEBIP6TES7EAjqHZRRTLkJDRkIiRGM5+t?=
 =?us-ascii?Q?0qKgGrxOKRN06DH2ikCoAlxz2L0PxZH0ZdtTSku+0qAzSIeH9zU3eqoNHqsh?=
 =?us-ascii?Q?SG7KjsMUG9mrV9yqN8WaBaSYFikCouoJ4cUocSKm90SVeuwsxHB72i5PEQDd?=
 =?us-ascii?Q?DE7SrFcyeeVIwGF6sazXD0T+W13nWR/Qu6icNFga1c66Zgk75k5nPWqqewZK?=
 =?us-ascii?Q?OSNZS9qe8KRxOcfvSJXhAo5sQafemK5NwEOE46DPaA19zDbCIJeoiIAVOmEF?=
 =?us-ascii?Q?t2JNsKezONLQiukUkKYOIyz73tnBUSWA/qIww2j4FQ8wFG+kMIrEJUbIrGty?=
 =?us-ascii?Q?As6hEU9Kq+Az9HjuD+5Tcx8D3013myzZqjLtbSKzF6eK0SHh3rCL5bFO/v8L?=
 =?us-ascii?Q?2Wsv7oy0YI6J6suwh78Tg9BdKToiyxgWIhwrf5o+YNOwQxLD5jg1q3ctpVur?=
 =?us-ascii?Q?8xGoWfAKWGqH11mEKlLT80aAIlDBKwiCRjbwgx5Ahw+WbXC8EHY6FOHIz4Wl?=
 =?us-ascii?Q?+ZyR8P8ue2LC+65wgoTSRGioQwjmL38tMwYr4VK2YYoGCKmKQK6W604gM/h9?=
 =?us-ascii?Q?kAZ1HveNHPukRecOfcoKGIZsrS+VE0kkrnV8az1lA5eD96sKGQLRDZv2GTpS?=
 =?us-ascii?Q?94e9sh18duDztfF/19Jg5WHTv0DejOoocTtm/9FX056l4HMo2Bz1BxYKHuiX?=
 =?us-ascii?Q?u+GyQ+58hRuqNjmq+Iu17Q5lQoM5I1OEhLg+N8wN7+4Tral7rGKA99nRYWrW?=
 =?us-ascii?Q?QLIRFX2AC+/KmNxereh0agTAr5GoybvFwG+2Dcy5wfpmmAvXy4gQxWMgNeBE?=
 =?us-ascii?Q?tSSQVywPqTn5AkVDDDrADj6IiyTDRXGJzFBpVrct1+6HxDfG2rCJSiLdaUgU?=
 =?us-ascii?Q?d8LAeZqHeSUguTGNVN1VKFoO1L4sXNy1TgH9zxY8O+VwX5Edp33lekV9Roh2?=
 =?us-ascii?Q?i85BRJu5Q6ngNKDZsPT7DmFrfrT5jx2UEv/V7CL6Ne0wWnqs20ktJd3Bo6ai?=
 =?us-ascii?Q?mQsWrEbG2iM7mNBAu1fej1MtwdGEAFZ5lbQQDjmDAth10twXsHkeNRYu9/9K?=
 =?us-ascii?Q?Qs8FNg/eFOYJ+G0kjiUmHpN5rs3T0K9qtOdeuhVLVItTlvLmyVEJGppLw5dM?=
 =?us-ascii?Q?L1DTpqno2hq4b1piNp1+z27zF/TST1/b5OX5ic8KfmtXFFZO5CBqt4jxCa3i?=
 =?us-ascii?Q?0YxqvuqADzAYaZ1jS52iPICn7DH4PG4JGN+EHNokLB552ItLuE9BYShovibE?=
 =?us-ascii?Q?wEpMW//nvDrfhz6HiZNPL3OpLQT4bVsJvU9QfXBmNHWh8ms5ht6+aczRYbh9?=
 =?us-ascii?Q?MbwAwDpSPmnCrdKh8bsCtvm6oinHuW0Sx3EnXd8QM5008Z6DJp3MSqX8vOHY?=
 =?us-ascii?Q?8cf5YAH85k67HnDbIL7wIL4A7Sg2tQqeAVleE1Tp?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WfndPE5RkfiZXeBvNJ78agg7h4H7B3aZrklzMixfkLDBMyWOjRgc/rOJuyLCOVXeXm3hqIUaJ1/1dtiVzAvVXdTRYqyPM7++NHqJO2uKoJe+umAxd1iBT4wqm6OMkX2HTcDRBLfFGMcgRh53jlhfHQqeRX7HjVsPw48ULJxJmfqfAuDbFtbhiQ3SVm6wq17YcX7FksNDg/zNoqKdZrz3mKa5Ri5OnV5NvtYEzFO3iaDLVzTOMQuaAZVsiBW/+Wd6yp1TVNO1QJMKQDU5bBm19SLJx61ULQcr+XATX/qIF8F66Wt2a52QZyNtVJt2645C8nYMKt5Hf3n33RoEsH9pkEomDtHLzi6zn89Q6yWXGGND9IgrlgVR/xk+56G7CNbd3J2SbRiwZ8wMpHvQDEfXK7vUb8HZTpcT8MVh+fzuMvh/D0alIQ8QoS+eM7+SMp135QShQPvm0J495YAxizbjO4fqheKXU1OFFMmFEjsrlL2vVS2behZHzEcaJYv7s+vH5OtR/0sbDJqqgVHRdeLPbdM6EaHsakEUC3b5ssrOrnbiMDQmmD9pmOKQZI1eje5APa4xAzDqZy5tw9VZPIf5vuaAqlgpvvLeNb2DBS+/3L8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4dc4865-017c-4fe3-cfa7-08dcb7cff17d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 17:31:31.8547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wEtN6uziAcZmcZqttUxdzPtIahvCkWJILlPQGU6ihoi6qUmqXvfn2rNPsF7pnV/mXc52UMt22Cx9O+s3FuI00A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6769
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-08_17,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 bulkscore=0
 adultscore=0 mlxscore=0 phishscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408080124
X-Proofpoint-ORIG-GUID: hZCNVeJSaRHQ-eX23jCH3usHYQV4_qbR
X-Proofpoint-GUID: hZCNVeJSaRHQ-eX23jCH3usHYQV4_qbR

* Sidhartha Kumar <sidhartha.kumar@oracle.com> [240808 12:30]:
> The following scenario can result in a race condition:
> 
> Consider a node with the following indices and values
> 
> 	a<------->b<----------->c<--------->d
> 	    0xA        NULL          0xB
> 
> 	CPU 1			  CPU 2
>       ---------        		---------
> 	mas_set_range(a,b)
> 	mas_erase()
> 		-> range is expanded (a,c) because of null expansion
> 
> 	mas_nomem()
> 	mas_unlock()
> 				mas_store_range(b,c,0xC)
> 
> The node now looks like:
> 
> 	a<------->b<----------->c<--------->d
> 	    0xA        0xC          0xB
> 
> 	mas_lock()
> 	mas_erase() <------ range of erase is still (a,c)
> 
> The node is now NULL from (a,c) but the write from CPU 2 should have been
> retained and range (b,c) should still have 0xC as its value. We can fix
> this by re-intializing to the original index and last. This does not need
> a cc: Stable as there are no users of the maple tree which use internal
> locking and this condition is only possible with internal locking.
> 
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> ---
>  lib/maple_tree.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 65fba37ef999..6ba95a278326 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -5451,14 +5451,21 @@ EXPORT_SYMBOL_GPL(mas_store);
>   */
>  int mas_store_gfp(struct ma_state *mas, void *entry, gfp_t gfp)
>  {
> +	unsigned long index = mas->index;
> +	unsigned long last = mas->last;
>  	MA_WR_STATE(wr_mas, mas, entry);
>  
>  	mas_wr_store_setup(&wr_mas);
>  	trace_ma_write(__func__, mas, 0, entry);
>  retry:
>  	mas_wr_store_entry(&wr_mas);
> -	if (unlikely(mas_nomem(mas, gfp)))
> +	if (unlikely(mas_nomem(mas, gfp))) {
> +		if (!entry) {
> +			mas->index = index;
> +			mas->last = last;

__mas_set_range(mas, index, last);

> +		}
>  		goto retry;
> +	}
>  
>  	if (unlikely(mas_is_err(mas)))
>  		return xa_err(mas->node);
> @@ -6245,17 +6252,19 @@ EXPORT_SYMBOL_GPL(mas_find_range_rev);
>  void *mas_erase(struct ma_state *mas)
>  {
>  	void *entry;
> +	unsigned long index = mas->index;
>  	MA_WR_STATE(wr_mas, mas, NULL);
>  
>  	if (!mas_is_active(mas) || !mas_is_start(mas))
>  		mas->status = ma_start;
>  
> -	/* Retry unnecessary when holding the write lock. */
> +write_retry:
> +	/* reset mas->index and mas->last in case range of entry changed */
> +	mas->index = mas->last = index;

it might make sense to re-init in the mas_nomem() case only, to avoid
extra instructions in the fast path.

>  	entry = mas_state_walk(mas);
>  	if (!entry)
>  		return NULL;
>  
> -write_retry:
>  	/* Must reset to ensure spanning writes of last slot are detected */
>  	mas_reset(mas);
>  	mas_wr_store_setup(&wr_mas);
> -- 
> 2.46.0
> 

