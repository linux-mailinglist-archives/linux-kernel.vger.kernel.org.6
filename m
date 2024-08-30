Return-Path: <linux-kernel+bounces-309308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 833279668BB
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 20:12:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7B861C20CB2
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 18:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C941BE25B;
	Fri, 30 Aug 2024 18:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VYwxptKP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cVe7ZiC6"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AEB1BE22E
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 18:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725041473; cv=fail; b=dUBGZDgBTLzgaGqVhZu2xApJnhaIQBAwMOs9T/uuEpNk5e7dfYeOKjxzGWcagnvWbWJtw0VFJOa5+dvs5WxUi6Y5E1Imz+Gdmx3e2R1++OT2IOnKEnhnHoaHROsHEqzXUgjKwPvq+ZWbDYO2F2Sx/n6w6lCLdC+KobaWLbSDTKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725041473; c=relaxed/simple;
	bh=oEK34lKjs65lZZOo/ZzoVDjKSPxxnLthbfhWndkCKsg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EfeWz65eJs02bRMRjDjSwFa4rfSQYfL6V3ejUN6qX+mSz74a5YgEUdtWz6+veKu7siKmMWP03jwjp9HQWHgpgx4k80PT2VMhSknn5X9ekiEmG3KyGnS0yyutJOZRb5hraR56hw5i2mt9dfIcfKp7/zLIK9qECBoirlgmlEN5vgE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VYwxptKP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cVe7ZiC6; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47UI0XfF009726;
	Fri, 30 Aug 2024 18:11:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=NERpJfNr+1qqfA+VTms4cXNhl2jftMUfgiR3NXfZtiE=; b=
	VYwxptKPUCEW+8Ah0LuucxPglp7/NnLitjNshbKEu/1pEMYU3rZdCokfUSEvxFch
	I6B8fiGLg8u/Ft47SVYGzPwTq/1lvs5vsAP32BH531TdQ2QENUGlS1ezEyrcDsWi
	ItX0yVzH9c+/3UhksvnDfYkOMiCkT4NgLF5ykDhW7bkHe3GbamrjQwZpdA4L5s8k
	p8UM159c+6zCCPr6eiaS9ZEdYiMDUD762dYR2mvc/BsZq6HflllBMe1zC/xu0WSv
	A7UKIgBAly81p6/czftmHucxKDt9s9I7SYCKp7FFwfKZ4ng6kWqJbniMbgDkWdjI
	EGw8MslaCeKx3x6hRVjbzw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41bh8t863u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 18:11:00 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47UHeDpx036530;
	Fri, 30 Aug 2024 18:11:00 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2043.outbound.protection.outlook.com [104.47.55.43])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4189jpw306-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 18:11:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bBDimvgj8e1CXT2D+FM2Sbr79rR9XcMpa3kHIYyvpkzsPo0RDVJzrBYeMkpY7KT+TDFjiQSvB2NwHu+L7KXtUAH4YU2wcpQdxqsB6vz7WwlB4ieiLSQ8XzCstbzYKt+bZcnyQQLjigtlP+PAyqQE8SkzGyZCM52FrklXYRt5gWfRgFuvKfxdp9nJKtfMFrNcswejrKkdmY48ILjJiZJVAdp/GRyexvqhYPHr4WkE3OHj3IGpC/oxBveY4XCwMIpjJZTaR2vL7JmivdcisaRBGbBZeCWHZzcJKlFuMhoKZqxGdODFLf4vbbavXJSddMyHGHVIROd/H0x8jTk5TTSlow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NERpJfNr+1qqfA+VTms4cXNhl2jftMUfgiR3NXfZtiE=;
 b=sqP39lo56yGt/opgTsvoEWOCeviv235xys4YSlSqyJDn97bOn6zaohlq28s6GLryIm2HqLWpMe+y/6jyJgWlKUitlFkpn6EU9YCoQDUdgsTBKkQHZ3xS4lay/2KcziUZoqVOnn/H/YPmmgZOzUKDlO2b/wmgw6cCYITa2ERwaYfAHFFDlPYlHI4GZ1L0wxJXBp+fg1PaK+TLzITQCr6pu7x4v+cWkfpNyYgC9G/jIG7WVCnBJ6flfGxz3/TB6tc8RRJa8/EQnjf5eM8CDD8YzHxwxiMUZPMOfo9B5CDladyQgPieVybyQhiPwfjRp7ZmhNG71ULrJb4s2XADgMURKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NERpJfNr+1qqfA+VTms4cXNhl2jftMUfgiR3NXfZtiE=;
 b=cVe7ZiC6l89U67lp7MUreC4Fvbma/lkqARdYm7SrAyU4IfyvL41A5H/vgWA4125o2nB4KpDQnWDjbNMV0YpKNR2EOR/L1ynq0rz0uPdW1uSlCd6Ek6w08DKLWoAaMOZP4j+cv2KqdnysHp08WpQO6Pe3npZd33oZGXgh/e8mKRI=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by IA0PR10MB7276.namprd10.prod.outlook.com (2603:10b6:208:3dc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.19; Fri, 30 Aug
 2024 18:10:57 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 18:10:57 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 10/10] mm: rework vm_ops->close() handling on VMA merge
Date: Fri, 30 Aug 2024 19:10:22 +0100
Message-ID: <9f96b8cfeef3d14afabddac3d6144afdfbef2e22.1725040657.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1725040657.git.lorenzo.stoakes@oracle.com>
References: <cover.1725040657.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0487.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13a::12) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|IA0PR10MB7276:EE_
X-MS-Office365-Filtering-Correlation-Id: 824439bf-55e5-4f04-ed4f-08dcc91f1845
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JcfgsqZ/X1Xa8gVYOf3DKrt9XuiXubiiwpwvvOwMk8egD5RgdGxmMrAi5bA0?=
 =?us-ascii?Q?OoxfANko4bzUDnQDn024Bzns7aHqooNJt+mbAkvUW1VLXdYzbL3q/qSvRpkH?=
 =?us-ascii?Q?xV6tCZMcPadZsL61FOSIFfrWvmvnceYYlwLp0H8MTG9tWkfpaNdArQSsbAoU?=
 =?us-ascii?Q?wNO0CL7PPbGfwASMw3I+P+XDFMB8N+SP3h7eIVelr6Wy5YDYbcd9UKEYA7HQ?=
 =?us-ascii?Q?nGpo2KBObDZP5hKnKB/b80kwBDAb7lGOgwrX1cHN48LweD2rtmAfQTDB4lcE?=
 =?us-ascii?Q?9X+V5xT7Csl4BZzJrl84bl0YytjYzzqPEKKPfP70VkEZINHWEAXxyaSgdXgd?=
 =?us-ascii?Q?scnU4C0zcVi3VIeCrNWGc4MoZqx75mM0cLtGsBL9K5o8Qu5ieEOEojuYW+lQ?=
 =?us-ascii?Q?tF3hNZiKxla6hAwLrX89RwBlyKjpnRZt2tmvq4nTstJ7SslQUG9l6/NWyUdV?=
 =?us-ascii?Q?Lt38Hq7sh1a3fO5291N8jyu9DpAPO//ehpt+DAhjG6VrgnTHu5M4Y7Dz8H47?=
 =?us-ascii?Q?z8Mu3SYyTmEc3dq5y9vicO50uPVbJfWX0P4MCzTsKX9iRLbn3eV9zAlHKH55?=
 =?us-ascii?Q?n9uQppYCQuiE/xy4rJ6+/5F8YYti6exKkHALWdmMAEFpha+eQSfKeFoBheDG?=
 =?us-ascii?Q?mBaPOAd8h/m3TxqpbWWXtOadxuLO9Y9Vaetk+Q1b3fXMgZ/chFxrOsadl6fm?=
 =?us-ascii?Q?QEdVjHmU7WaL11YE1Wwi0EfOIHzfC7vgOmVphXMPKlWydPv+MusafumoAZzd?=
 =?us-ascii?Q?GpI0XDMg1oggy9rRvUa/6TTcH1xc0hShY6By0PmCFn+OiuzZrQ3kxuhefLXT?=
 =?us-ascii?Q?HJqrHOzXWquwceuJBToYMu+bx/HSZhJmj8SA4FsNdHGDBdmtchOWMPWizk4J?=
 =?us-ascii?Q?sre3mBpnq6UJv3y/tZmmFOPl+RYVwDgD4njASVU1Q8jgVMnCxHvs8bxRW8jo?=
 =?us-ascii?Q?jbOT6DpbgT59wDx7+n8TzWgBTuRXUhkef2b+YUTOFysSW+jWVQGwbs+D0Mdu?=
 =?us-ascii?Q?OILWyHv6LvnWXpouPDxUw5KS/I3tzO/fCNU7G6etRIcwEUr7UBOJLr5ZL2sU?=
 =?us-ascii?Q?fI9vwZJtwKlVS8ORJ7aRCtE6k4JX0zfEoL5BQV05cVBlNYnjwG4YmRKfUu4T?=
 =?us-ascii?Q?BdQR6oFJh2fRijA+eG0tHYcWd7+sugD5PbkCvr0XDWjrVz7fjVvWt8ygNle7?=
 =?us-ascii?Q?90/1oaNoViFuqs0e5gYFpvR1/Atxl1ZtTYsO9PGzOm/gheAT/r8AygyHda5C?=
 =?us-ascii?Q?JcDuhUNDTZoSNjQ0shQQ8y8cGogzcC9XHkfUv+lqgqbHI7FEU6GlgKoVQf2J?=
 =?us-ascii?Q?IlVeCQQa9FlCypQNkx/X7fGPHgN2rZeW3Kv6cm70x7dkZA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WgsHjUHDvZhsnfB15furhbThAlyLgFHjTLz2/PHfb4qfzlYQrVJHdNSM5wtl?=
 =?us-ascii?Q?ZAeBpbJ/OQrU+8ay4UOJOuqcvZUrk7toOVLRhuXr9wld6EbyoWPD4Tqt5TZu?=
 =?us-ascii?Q?X8txXggsq4o1f4oxTVDSRgmOLZ5qUwnfzDC2BY7LSVl3asvM/OZxfQsst5/S?=
 =?us-ascii?Q?nRn5MzORMy0EJuXA6s1P6SXxLtHUXjjwqXszQZSoCmToOlCSAMB7i77LqzZa?=
 =?us-ascii?Q?owZwIWcnFm7MQJyTV7KAo3di1KDBNGs+t9HxfHTphRmCcB5LjmGQ7JeHULtx?=
 =?us-ascii?Q?vo6B7+ycX0l2wsp7cy7tkR3pGeaFMXxzqYTaGyiumXMsM8J+uNaBPyTkVvNc?=
 =?us-ascii?Q?EeCksXx7k+oJZ7IwzBNv9UTgDwr8SYHWrK0G8CABYSK8GPxgkA1x+oh1XUjO?=
 =?us-ascii?Q?FziCW+iFIuKMd4AKlPbttUcfGv8b1y3ma2zyW1JUni6PDuS87n+gvNPFA0k7?=
 =?us-ascii?Q?P/rCDUo0jhHdOcxdQe3IyoBPm3SQmEI1yltiLgEBDSUlxSk4tCxI5Lud64ie?=
 =?us-ascii?Q?mSEoF3fzbSCUBMwiWuJGgHUl8te8yXKVmVHzeJhUSz9LZDlFHbnJ5PlJKj2p?=
 =?us-ascii?Q?BuKkNPXyPW6Hoho24b71N9Gp38/oG1QX5Ih+uJ00yzya3yp83XcjWD93g/IU?=
 =?us-ascii?Q?HdhRuimbJ3ZSBcHldJyMW6+V74UWMYwAHWFCpTkGka28AdGFjMDNb41cBv8N?=
 =?us-ascii?Q?KkElmPo8TQO8ZjdMxYO1xwlDlSJ81HmHuiN0HDw/2aU8oco544th4QGj0Yiw?=
 =?us-ascii?Q?fzjGWISKhNiNS66XuXppYv45N6wkjxlVKkwzFsuxNX/LUf8y80ZLr6vroCbq?=
 =?us-ascii?Q?GkqH1Hj8dBpWo8JaGZD+Cj09OvsurwykTcJbF5EaABwem1QS/6jmIjSCb+px?=
 =?us-ascii?Q?0jk/VoNlbS/S9NAo8xvbGM3sule3GdOElBqvlkBXbuIWJh1MxZCWl+R69jJc?=
 =?us-ascii?Q?qdsUWotR8tCHLOQVPqS/FiWyfzPULvXeHi2noZ1pWtm6jtQGO2dRLuwwIRc3?=
 =?us-ascii?Q?nVAbn6nCU8HZmQf6eItQQHUtaLOVCIY9nNj4C8xAS3HUChVyZ+tYQc0skWSm?=
 =?us-ascii?Q?NCNz4RPELbJkMxHN6jdCJBO/4QOm83worahTd5cNQl8yVwKG+fyF39mf1exH?=
 =?us-ascii?Q?Y9L61X0Xi/PLLKwENNVFvWxzyLOyTM7DP3O2DPpCme1Yx3gvkuHvFAwAndwR?=
 =?us-ascii?Q?08p0dDL+rvwnpZ4W5lkYGYUVGjK3hGCf5sn8AQjMH2ONsRkZZigP94x2wMJ4?=
 =?us-ascii?Q?waCpgDWr3Ha5SkYK4gUM2aEJB4RuzN6NrMT/MnvfVxLa9UJzspOHTEGxID3A?=
 =?us-ascii?Q?oZyaI6p+zmkGRc+bUeGxkYI3x7KyMZDZDwptlQYanmvJfHEQmcg3ZTY2M4Gs?=
 =?us-ascii?Q?7XFhFxM9w3rf3sJlGAlhq4dEShf6fhRF4s4FHP/Y5I1sXledF8JcJ4DDJW/W?=
 =?us-ascii?Q?G8PRzC3JdceDbTgSI29y/v5UwFFY2xdcwntOOgY7XUb9JZg5T5w2clshLo8Q?=
 =?us-ascii?Q?HXzbxzIE4xy2UvyY237MF/kBsKylKs78ngkAENeAjSNj/iKlMmdBtfaxjXjP?=
 =?us-ascii?Q?83IeHUtU4pCYEbrvOXagvoGDsab4pY2etqLT4s0Ave1/oDTmQWkO550x9BiU?=
 =?us-ascii?Q?cQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+9FqJVuzuPHufLfLCADiEUVNZyofagMQeW4gGW7on01O2vvjFU5hTaDwcpZi9rPpVR+Be0bO5+MQ6Wng2BxrajEFVNaRTFwe9/bkL8AZHiBj7Soq03v2EhvtCeefTzzwWhUIYQtxZGbcRFvEcQZsrpKsVBvRUXlD0S2u/0q3jRaxpBeYsmMmVRkTLl66CxZjWPGOL2Rt69cv1uUajcqrFNGs6oXpq9FEDSPWse8VotKBW75be6Vfz4qKdVY+4vzIUtuKvfAS967PkHzHif2Et9yZWhvMP7pZX2AQNYOsO2uVPP5WGRhbFpAozfXaInahJL0sD0X9J0F/Og7v9sTfw7BMnnhgEsFCkdZhgL+m9hZJsjQF41eJkOxGb/XSGJvQX3S3nTSrKVzshP9mjxykXjKSrhWHul8eHGyJKKGo2QtDjnLjFfl8wzto7gJujzAkqCENKrFLr8BpnCg6H6y94URM0IT/Am6ls3WOYLo1pyTVkkBDinHUT4axS12xHGvPvJvcxxvw7yI54SsTRKDzqx9kV9knRW0E9gimnDwIkrs/NI4RP7UmXE72+FjsYBDy2sIYLJVXaCepdoM7dIQWi5U5peUwXFeC82AzSDT/Fe0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 824439bf-55e5-4f04-ed4f-08dcc91f1845
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 18:10:57.0309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WaCo2ZvOvAMTBdpd9msIhQHJgcsj7hubhE/Mh7oZ+7Ch+AcmbxP6wJ1jDRNzr1OnhnEGce1935MOjGAKhuBQr03Pzh43dOy/UciyJLZsEN0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7276
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_10,2024-08-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408300138
X-Proofpoint-GUID: rx0WViF6MFPRofM6Ir4-FGSeDZHGJQId
X-Proofpoint-ORIG-GUID: rx0WViF6MFPRofM6Ir4-FGSeDZHGJQId

In commit 714965ca8252 ("mm/mmap: start distinguishing if vma can be
removed in mergeability test") we relaxed the VMA merge rules for VMAs
possessing a vm_ops->close() hook, permitting this operation in instances
where we wouldn't delete the VMA as part of the merge operation.

This was later corrected in commit fc0c8f9089c2 ("mm, mmap: fix vma_merge()
case 7 with vma_ops->close") to account for a subtle case that the previous
commit had not taken into account.

In both instances, we first rely on is_mergeable_vma() to determine whether
we might be dealing with a VMA that might be removed, taking advantage of
the fact that a 'previous' VMA will never be deleted, only VMAs that follow
it.

The second patch corrects the instance where a merge of the previous VMA
into a subsequent one did not correctly check whether the subsequent VMA
had a vm_ops->close() handler.

Both changes prevent merge cases that are actually permissible (for
instance a merge of a VMA into a following VMA with a vm_ops->close(), but
with no previous VMA, which would result in the next VMA being extended,
not deleted).

In addition, both changes fail to consider the case where a VMA that would
otherwise be merged with the previous and next VMA might have
vm_ops->close(), on the assumption that for this to be the case, all three
would have to have the same vma->vm_file to be mergeable and thus the same
vm_ops.

And in addition both changes operate at 50,000 feet, trying to guess
whether a VMA will be deleted.

As we have majorly refactored the VMA merge operation and de-duplicated
code to the point where we know precisely where deletions will occur, this
patch removes the aforementioned checks altogether and instead explicitly
checks whether a VMA will be deleted.

In cases where a reduced merge is still possible (where we merge both
previous and next VMA but the next VMA has a vm_ops->close hook, meaning we
could just merge the previous and current VMA), we do so, otherwise the
merge is not permitted.

We take advantage of our userland testing to assert that this functions
correctly - replacing the previous limited vm_ops->close() tests with tests
for every single case where we delete a VMA.

We also update all testing for both new and modified VMAs to set
vma->vm_ops->close() in every single instance where this would not prevent
the merge, to assert that we never do so.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/vma.c                |  57 +++++++++-----
 tools/testing/vma/vma.c | 166 +++++++++++++++++++++++++++++++---------
 2 files changed, 164 insertions(+), 59 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index 393bef832604..8d1686fc8d5a 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -10,14 +10,6 @@
 static inline bool is_mergeable_vma(struct vma_merge_struct *vmg, bool merge_next)
 {
 	struct vm_area_struct *vma = merge_next ? vmg->next : vmg->prev;
-	/*
-	 * If the vma has a ->close operation then the driver probably needs to
-	 * release per-vma resources, so we don't attempt to merge those if the
-	 * caller indicates the current vma may be removed as part of the merge,
-	 * which is the case if we are attempting to merge the next VMA into
-	 * this one.
-	 */
-	bool may_remove_vma = merge_next;
 
 	if (!mpol_equal(vmg->policy, vma_policy(vma)))
 		return false;
@@ -33,8 +25,6 @@ static inline bool is_mergeable_vma(struct vma_merge_struct *vmg, bool merge_nex
 		return false;
 	if (vma->vm_file != vmg->file)
 		return false;
-	if (may_remove_vma && vma->vm_ops && vma->vm_ops->close)
-		return false;
 	if (!is_mergeable_vm_userfaultfd_ctx(vma, vmg->uffd_ctx))
 		return false;
 	if (!anon_vma_name_eq(anon_vma_name(vma), vmg->anon_name))
@@ -632,6 +622,12 @@ static int commit_merge(struct vma_merge_struct *vmg,
 	return 0;
 }
 
+/* We can only remove VMAs when merging if they do not have a close hook. */
+static bool can_merge_remove_vma(struct vm_area_struct *vma)
+{
+	return !vma->vm_ops || !vma->vm_ops->close;
+}
+
 /*
  * vma_merge_existing_range - Attempt to merge VMAs based on a VMA having its
  * attributes modified.
@@ -725,12 +721,30 @@ static struct vm_area_struct *vma_merge_existing_range(struct vma_merge_struct *
 	merge_both = merge_left && merge_right;
 	/* If we span the entire VMA, a merge implies it will be deleted. */
 	merge_will_delete_vma = left_side && right_side;
+
+	/*
+	 * If we need to remove vma in its entirety but are unable to do so,
+	 * we have no sensible recourse but to abort the merge.
+	 */
+	if (merge_will_delete_vma && !can_merge_remove_vma(vma))
+		return NULL;
+
 	/*
 	 * If we merge both VMAs, then next is also deleted. This implies
 	 * merge_will_delete_vma also.
 	 */
 	merge_will_delete_next = merge_both;
 
+	/*
+	 * If we cannot delete next, then we can reduce the operation to merging
+	 * prev and vma (thereby deleting vma).
+	 */
+	if (merge_will_delete_next && !can_merge_remove_vma(next)) {
+		merge_will_delete_next = false;
+		merge_right = false;
+		merge_both = false;
+	}
+
 	/* No matter what happens, we will be adjusting vma. */
 	vma_start_write(vma);
 
@@ -772,21 +786,12 @@ static struct vm_area_struct *vma_merge_existing_range(struct vma_merge_struct *
 		vmg->start = prev->vm_start;
 		vmg->pgoff = prev->vm_pgoff;
 
-		if (merge_will_delete_vma) {
-			/*
-			 * can_vma_merge_after() assumed we would not be
-			 * removing vma, so it skipped the check for
-			 * vm_ops->close, but we are removing vma.
-			 */
-			if (vma->vm_ops && vma->vm_ops->close)
-				err = -EINVAL;
-		} else {
+		if (!merge_will_delete_vma) {
 			adjust = vma;
 			adj_start = vmg->end - vma->vm_start;
 		}
 
-		if (!err)
-			err = dup_anon_vma(prev, vma, &anon_dup);
+		err = dup_anon_vma(prev, vma, &anon_dup);
 	} else { /* merge_right */
 		/*
 		 *     |<----->| OR
@@ -940,6 +945,14 @@ struct vm_area_struct *vma_merge_new_range(struct vma_merge_struct *vmg)
 		vmg->vma = prev;
 		vmg->pgoff = prev->vm_pgoff;
 
+		/*
+		 * If this merge would result in removal of the next VMA but we
+		 * are not permitted to do so, reduce the operation to merging
+		 * prev and vma.
+		 */
+		if (can_merge_right && !can_merge_remove_vma(next))
+			vmg->end = end;
+
 		vma_prev(vmg->vmi); /* Equivalent to going to the previous range */
 	}
 
@@ -994,6 +1007,8 @@ int vma_expand(struct vma_merge_struct *vmg)
 		int ret;
 
 		remove_next = true;
+		/* This should already have been checked by this point. */
+		VM_WARN_ON(!can_merge_remove_vma(next));
 		vma_start_write(next);
 		ret = dup_anon_vma(vma, next, &anon_dup);
 		if (ret)
diff --git a/tools/testing/vma/vma.c b/tools/testing/vma/vma.c
index 25a95d9901ea..c53f220eb6cc 100644
--- a/tools/testing/vma/vma.c
+++ b/tools/testing/vma/vma.c
@@ -387,6 +387,9 @@ static bool test_merge_new(void)
 	struct anon_vma_chain dummy_anon_vma_chain_d = {
 		.anon_vma = &dummy_anon_vma,
 	};
+	const struct vm_operations_struct vm_ops = {
+		.close = dummy_close,
+	};
 	int count;
 	struct vm_area_struct *vma, *vma_a, *vma_b, *vma_c, *vma_d;
 	bool merged;
@@ -430,6 +433,7 @@ static bool test_merge_new(void)
 	 * 0123456789abc
 	 * AA*B   DD  CC
 	 */
+	vma_a->vm_ops = &vm_ops; /* This should have no impact. */
 	vma_b->anon_vma = &dummy_anon_vma;
 	vma = try_merge_new_vma(&mm, &vmg, 0x2000, 0x3000, 2, flags, &merged);
 	ASSERT_EQ(vma, vma_a);
@@ -466,6 +470,7 @@ static bool test_merge_new(void)
 	 * AAAAA *DD  CC
 	 */
 	vma_d->anon_vma = &dummy_anon_vma;
+	vma_d->vm_ops = &vm_ops; /* This should have no impact. */
 	vma = try_merge_new_vma(&mm, &vmg, 0x6000, 0x7000, 6, flags, &merged);
 	ASSERT_EQ(vma, vma_d);
 	/* Prepend. */
@@ -483,6 +488,7 @@ static bool test_merge_new(void)
 	 * 0123456789abc
 	 * AAAAA*DDD  CC
 	 */
+	vma_d->vm_ops = NULL; /* This would otherwise degrade the merge. */
 	vma = try_merge_new_vma(&mm, &vmg, 0x5000, 0x6000, 5, flags, &merged);
 	ASSERT_EQ(vma, vma_a);
 	/* Merge with A, delete D. */
@@ -640,13 +646,11 @@ static bool test_vma_merge_with_close(void)
 	const struct vm_operations_struct vm_ops = {
 		.close = dummy_close,
 	};
-	struct vm_area_struct *vma_next =
-		alloc_and_link_vma(&mm, 0x2000, 0x3000, 2, flags);
-	struct vm_area_struct *vma;
+	struct vm_area_struct *vma_prev, *vma_next, *vma;
 
 	/*
-	 * When we merge VMAs we sometimes have to delete others as part of the
-	 * operation.
+	 * When merging VMAs we are not permitted to remove any VMA that has a
+	 * vm_ops->close() hook.
 	 *
 	 * Considering the two possible adjacent VMAs to which a VMA can be
 	 * merged:
@@ -697,28 +701,52 @@ static bool test_vma_merge_with_close(void)
 	 * would be set too, and thus scenario A would pick this up.
 	 */
 
-	ASSERT_NE(vma_next, NULL);
-
 	/*
-	 * SCENARIO A
+	 * The only case of a new VMA merge that results in a VMA being deleted
+	 * is one where both the previous and next VMAs are merged - in this
+	 * instance the next VMA is deleted, and the previous VMA is extended.
 	 *
-	 * 0123
-	 *  *N
+	 * If we are unable to do so, we reduce the operation to simply
+	 * extending the prev VMA and not merging next.
+	 *
+	 * 0123456789
+	 * PPP**NNNN
+	 *             ->
+	 * 0123456789
+	 * PPPPPPNNN
 	 */
 
-	/* Make the next VMA have a close() callback. */
+	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, flags);
+	vma_next = alloc_and_link_vma(&mm, 0x5000, 0x9000, 5, flags);
 	vma_next->vm_ops = &vm_ops;
 
-	/* Our proposed VMA has characteristics that would otherwise be merged. */
-	vmg_set_range(&vmg, 0x1000, 0x2000, 1, flags);
+	vmg_set_range(&vmg, 0x3000, 0x5000, 3, flags);
+	ASSERT_EQ(merge_new(&vmg), vma_prev);
+	ASSERT_EQ(vmg.state, VMA_MERGE_SUCCESS);
+	ASSERT_EQ(vma_prev->vm_start, 0);
+	ASSERT_EQ(vma_prev->vm_end, 0x5000);
+	ASSERT_EQ(vma_prev->vm_pgoff, 0);
 
-	/* The next VMA having a close() operator should cause the merge to fail.*/
-	ASSERT_EQ(merge_new(&vmg), NULL);
-	ASSERT_EQ(vmg.state, VMA_MERGE_NOMERGE);
+	ASSERT_EQ(cleanup_mm(&mm, &vmi), 2);
 
-	/* Now create the VMA so we can merge via modified flags */
-	vmg_set_range(&vmg, 0x1000, 0x2000, 1, flags);
-	vma = alloc_and_link_vma(&mm, 0x1000, 0x2000, 1, flags);
+	/*
+	 * When modifying an existing VMA there are further cases where we
+	 * delete VMAs.
+	 *
+	 *    <>
+	 * 0123456789
+	 * PPPVV
+	 *
+	 * In this instance, if vma has a close hook, the merge simply cannot
+	 * proceed.
+	 */
+
+	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, flags);
+	vma = alloc_and_link_vma(&mm, 0x3000, 0x5000, 3, flags);
+	vma->vm_ops = &vm_ops;
+
+	vmg_set_range(&vmg, 0x3000, 0x5000, 3, flags);
+	vmg.prev = vma_prev;
 	vmg.vma = vma;
 
 	/*
@@ -728,38 +756,90 @@ static bool test_vma_merge_with_close(void)
 	ASSERT_EQ(merge_existing(&vmg), NULL);
 	ASSERT_EQ(vmg.state, VMA_MERGE_NOMERGE);
 
-	/* SCENARIO B
+	ASSERT_EQ(cleanup_mm(&mm, &vmi), 2);
+
+	/*
+	 * This case is mirrored if merging with next.
 	 *
-	 * 0123
-	 * P*
+	 *    <>
+	 * 0123456789
+	 *    VVNNNN
 	 *
-	 * In order for this scenario to trigger, the VMA currently being
-	 * modified must also have a .close().
+	 * In this instance, if vma has a close hook, the merge simply cannot
+	 * proceed.
 	 */
 
-	/* Reset VMG state. */
-	vmg_set_range(&vmg, 0x1000, 0x2000, 1, flags);
-	/*
-	 * Make next unmergeable, and don't let the scenario A check pick this
-	 * up, we want to reproduce scenario B only.
-	 */
-	vma_next->vm_ops = NULL;
-	vma_next->__vm_flags &= ~VM_MAYWRITE;
-	/* Allocate prev. */
-	vmg.prev = alloc_and_link_vma(&mm, 0, 0x1000, 0, flags);
-	/* Assign a vm_ops->close() function to VMA explicitly. */
+	vma = alloc_and_link_vma(&mm, 0x3000, 0x5000, 3, flags);
+	vma_next = alloc_and_link_vma(&mm, 0x5000, 0x9000, 5, flags);
 	vma->vm_ops = &vm_ops;
+
+	vmg_set_range(&vmg, 0x3000, 0x5000, 3, flags);
 	vmg.vma = vma;
-	/* Make sure merge does not occur. */
 	ASSERT_EQ(merge_existing(&vmg), NULL);
 	/*
 	 * Initially this is misapprehended as an out of memory report, as the
 	 * close() check is handled in the same way as anon_vma duplication
 	 * failures, however a subsequent patch resolves this.
 	 */
-	ASSERT_EQ(vmg.state, VMA_MERGE_ERROR_NOMEM);
+	ASSERT_EQ(vmg.state, VMA_MERGE_NOMERGE);
+
+	ASSERT_EQ(cleanup_mm(&mm, &vmi), 2);
+
+	/*
+	 * Finally, we consider two variants of the case where we modify a VMA
+	 * to merge with both the previous and next VMAs.
+	 *
+	 * The first variant is where vma has a close hook. In this instance, no
+	 * merge can proceed.
+	 *
+	 *    <>
+	 * 0123456789
+	 * PPPVVNNNN
+	 */
+
+	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, flags);
+	vma = alloc_and_link_vma(&mm, 0x3000, 0x5000, 3, flags);
+	vma_next = alloc_and_link_vma(&mm, 0x5000, 0x9000, 5, flags);
+	vma->vm_ops = &vm_ops;
+
+	vmg_set_range(&vmg, 0x3000, 0x5000, 3, flags);
+	vmg.prev = vma_prev;
+	vmg.vma = vma;
+
+	ASSERT_EQ(merge_existing(&vmg), NULL);
+	ASSERT_EQ(vmg.state, VMA_MERGE_NOMERGE);
+
+	ASSERT_EQ(cleanup_mm(&mm, &vmi), 3);
+
+	/*
+	 * The second variant is where next has a close hook. In this instance,
+	 * we reduce the operation to a merge between prev and vma.
+	 *
+	 *    <>
+	 * 0123456789
+	 * PPPVVNNNN
+	 *            ->
+	 * 0123456789
+	 * PPPPPNNNN
+	 */
+
+	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, flags);
+	vma = alloc_and_link_vma(&mm, 0x3000, 0x5000, 3, flags);
+	vma_next = alloc_and_link_vma(&mm, 0x5000, 0x9000, 5, flags);
+	vma_next->vm_ops = &vm_ops;
+
+	vmg_set_range(&vmg, 0x3000, 0x5000, 3, flags);
+	vmg.prev = vma_prev;
+	vmg.vma = vma;
+
+	ASSERT_EQ(merge_existing(&vmg), vma_prev);
+	ASSERT_EQ(vmg.state, VMA_MERGE_SUCCESS);
+	ASSERT_EQ(vma_prev->vm_start, 0);
+	ASSERT_EQ(vma_prev->vm_end, 0x5000);
+	ASSERT_EQ(vma_prev->vm_pgoff, 0);
+
+	ASSERT_EQ(cleanup_mm(&mm, &vmi), 2);
 
-	cleanup_mm(&mm, &vmi);
 	return true;
 }
 
@@ -828,6 +908,9 @@ static bool test_merge_existing(void)
 		.mm = &mm,
 		.vmi = &vmi,
 	};
+	const struct vm_operations_struct vm_ops = {
+		.close = dummy_close,
+	};
 
 	/*
 	 * Merge right case - partial span.
@@ -840,7 +923,9 @@ static bool test_merge_existing(void)
 	 *   VNNNNNN
 	 */
 	vma = alloc_and_link_vma(&mm, 0x2000, 0x6000, 2, flags);
+	vma->vm_ops = &vm_ops; /* This should have no impact. */
 	vma_next = alloc_and_link_vma(&mm, 0x6000, 0x9000, 6, flags);
+	vma_next->vm_ops = &vm_ops; /* This should have no impact. */
 	vmg_set_range(&vmg, 0x3000, 0x6000, 3, flags);
 	vmg.vma = vma;
 	vmg.prev = vma;
@@ -873,6 +958,7 @@ static bool test_merge_existing(void)
 	 */
 	vma = alloc_and_link_vma(&mm, 0x2000, 0x6000, 2, flags);
 	vma_next = alloc_and_link_vma(&mm, 0x6000, 0x9000, 6, flags);
+	vma_next->vm_ops = &vm_ops; /* This should have no impact. */
 	vmg_set_range(&vmg, 0x2000, 0x6000, 2, flags);
 	vmg.vma = vma;
 	vma->anon_vma = &dummy_anon_vma;
@@ -899,7 +985,9 @@ static bool test_merge_existing(void)
 	 * PPPPPPV
 	 */
 	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, flags);
+	vma_prev->vm_ops = &vm_ops; /* This should have no impact. */
 	vma = alloc_and_link_vma(&mm, 0x3000, 0x7000, 3, flags);
+	vma->vm_ops = &vm_ops; /* This should have no impact. */
 	vmg_set_range(&vmg, 0x3000, 0x6000, 3, flags);
 	vmg.prev = vma_prev;
 	vmg.vma = vma;
@@ -932,6 +1020,7 @@ static bool test_merge_existing(void)
 	 * PPPPPPP
 	 */
 	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, flags);
+	vma_prev->vm_ops = &vm_ops; /* This should have no impact. */
 	vma = alloc_and_link_vma(&mm, 0x3000, 0x7000, 3, flags);
 	vmg_set_range(&vmg, 0x3000, 0x7000, 3, flags);
 	vmg.prev = vma_prev;
@@ -960,6 +1049,7 @@ static bool test_merge_existing(void)
 	 * PPPPPPPPPP
 	 */
 	vma_prev = alloc_and_link_vma(&mm, 0, 0x3000, 0, flags);
+	vma_prev->vm_ops = &vm_ops; /* This should have no impact. */
 	vma = alloc_and_link_vma(&mm, 0x3000, 0x7000, 3, flags);
 	vma_next = alloc_and_link_vma(&mm, 0x7000, 0x9000, 7, flags);
 	vmg_set_range(&vmg, 0x3000, 0x7000, 3, flags);
-- 
2.46.0


