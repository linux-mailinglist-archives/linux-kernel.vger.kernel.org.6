Return-Path: <linux-kernel+bounces-378805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 507729AD5A3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 22:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 711E91C22391
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 20:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B831F9439;
	Wed, 23 Oct 2024 20:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jAeG5v8X";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="eePXmu1B"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98E61E5735
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 20:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729715959; cv=fail; b=RyVjPR7LwPyBnuPWj/VZ0VLJhHkH8sS8l8wHw658IBZjpFW7WBvhFh5942lWh/ey90DbahF5+c8QxXSdYU2K5EFD2FcLJ+ou1sHba3QdsIk33kt/38N4yj9NL0hoUZR/KNjHQ0j53Mpkz1zxdXBEzWxql8GTWyX3dZmu2yRbEGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729715959; c=relaxed/simple;
	bh=JOJbhOxD4VQ8W1+wXrAHjuEzE8gcLZBteHOJ6l88gNs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XFP64WyBehxDN1EXzR1lYScEeqil2Vh0u6X1WCMuXj8emKl9nKSgbrCczUC8YeZYzkJWVxAgaadpovreDDkKtXJ9P8cu4DOq+wENe/XSWBX4J90sWzRLBQf5yaNEXKFICpPnHBnC1W/wJgnZSIYWwv/3zzoHkrNAClIEP7+5CUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jAeG5v8X; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=eePXmu1B; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49NKcXg3010429;
	Wed, 23 Oct 2024 20:39:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=TGZw0tx4qXQwwlFjxRJyFwIfVly//uJpCzOdUNUOgFU=; b=
	jAeG5v8XZLqcJ45zSJSyjzuBEPD/zPWzaPdMFHokfimcdg2Cli0eksS7I1c/xQv5
	zz6NAKc3+tIEWaZyd28lH8sszfJHwAxbMNw9bj7VO5LfZZ1iPzNyuCgbci4TG57x
	NpWENmG2G7ibjaRTbFErF101o6Yh2P01ZPy29oEkzJjv8gUkY1k/4hBnokE1cTzh
	+htXd0fKNjF1acn8JGkEEaY/tKLa+yeuGWQ36+PNbVGYnfX38qg18bAzUmVH4ex/
	VM4+VRlj81evpJZMIIy6fIFPRoLYxT5BsG5dZciqUK95X6me9rWqrv0BWi71K7hA
	3t77Z3lMn5hD/HT5tIHVbw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42cqv3g8w4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 20:39:08 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49NKIAZm031093;
	Wed, 23 Oct 2024 20:39:07 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2049.outbound.protection.outlook.com [104.47.70.49])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42emh219dg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 20:39:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M09eoLqT9dIRokBOCZ8VH8KjBuyNg++ZuzTbXkkCixxzcoEKNhCKFo1kUBF856WaFNdmP+CnKkBMQKKkWhKKKNwQOyGspdqCryE0C7X5V+3Jf77Nk3VYdhQq9pLaymyAG785MIkVL8FYddPq5JgY5qKQBkoMcgx7mr2xE4no7pGBNTTiN6X8aEzMbVfbTqyCBbNQvNcry/sUJciPrl5XLpUI7W1yuMMgLBSvSfQ4zRwPaWwjvbr9DIay1kCOmXLoyw4rSXaccWAyPNDY5sDtJOrnL/IqG10w6TPR8X6vxAA7eDDUycAs6unjo12cjBV6QdjX3LZfI32GrvPfKejKxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TGZw0tx4qXQwwlFjxRJyFwIfVly//uJpCzOdUNUOgFU=;
 b=xtdBNCZHiE4K1za8MuGHwyxtVUqQkkByV0iCZGS+4VasDJK/YkIwI/IGx8Qq7RVIaYJ1U1izGVyicYhKtxv866L0+Hgd+GYlM72h921CHstCEnzU4C6j1x/sXoZL5D2LlIcAApBd/B17FYApT4fpiB9Uza2LcJethXt42c8Vmc/Fs0ZWeBTZewSpQ8fu0x/xElpWTRd2abQ6b80PGNs5NShHArZd75I3UM2E1CUTHp2NZJnTvteFwEoYrHs6WMRGGO6kSN130Ja+sWF0Mt8xfVS2e0rpvBdcyfzlJXquD3IiIiprEoSwBhVqgGNKWPnRXSJw9hUZy5PW4Q31YgNCxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TGZw0tx4qXQwwlFjxRJyFwIfVly//uJpCzOdUNUOgFU=;
 b=eePXmu1BUWNfaqKR/QeDV67sr+b8MgN7zjRwU+TOvEDcTXF4b6EUZhqcwF+XSW3Yz3xdP7eMk4C98ZMvyUeorCQvTjdOWXkjW64EvTaDsjGs4lnmzZDc/epOg5vRrkEv3M4UF83IRCGMYKzjY4OwhLnxkkg1mjCaAiYIjROuWFw=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by SJ0PR10MB5833.namprd10.prod.outlook.com (2603:10b6:a03:3ed::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Wed, 23 Oct
 2024 20:39:04 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8069.024; Wed, 23 Oct 2024
 20:39:04 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>
Subject: [PATCH hotfix 6.12 v2 4/8] mm: resolve faulty mmap_region() error path behaviour
Date: Wed, 23 Oct 2024 21:38:29 +0100
Message-ID: <6e8deda970b982e1e8ffd876e3cef342c292fbb5.1729715266.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1729715266.git.lorenzo.stoakes@oracle.com>
References: <cover.1729715266.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0264.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::36) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|SJ0PR10MB5833:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c0c3067-c6e4-4580-1dca-08dcf3a2bbcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ezwjPU10Hy8v9RBw6meAkObqWSYxnJqvMbDdLpNfouFhlGfV1wYr0Fx/ONJT?=
 =?us-ascii?Q?L5GvGVfEwmwB0rmI5yA1vNBQz/Fsde1o0W/2IgOhU270478pxlMqV0924tiw?=
 =?us-ascii?Q?aqygyTf2BGVb6Dvuk2cPrprYiuB2YuLB1MhVkfNjoQAQlToWZfVgKXSlXwwD?=
 =?us-ascii?Q?Lor2kpmqCWHfLVSyzvUbDuSAxsxR4K3Q9MjLWxgW6T43e9P7PBBbeywEn994?=
 =?us-ascii?Q?fQ9yKrL6HtnYIBg4Qchua3bR+OgaNA8akh7qPvVUar6s1yCEaGGRQDE+bwhz?=
 =?us-ascii?Q?tmw3EyDbCuXdJJwnpmAOeBSaWOcxTIMontab2S3omGKv2X0wc5wtpwDQUG3N?=
 =?us-ascii?Q?03vxfGb3FecQR5FD4mkfNxA+p5q2rWLHhf9Szluu57VJf2WE2UpGkbjyjKh7?=
 =?us-ascii?Q?wKtZQ0I4rajEqNnB1a/i5mcl/f46qLeXdn0ucwziPhuZawqiNYMNLMwY6Wn2?=
 =?us-ascii?Q?JU5nGtTQorzoEexPuTrs4Wsm/hEC9IjpJppvjrKUtCCSpQWsYYEtIEfAttdR?=
 =?us-ascii?Q?NJYetfEfWZBeB49T5vsHvNP/bub5u5bKJ/9ourlBKg7xI6y7+SPcA+Krt66p?=
 =?us-ascii?Q?CnrYcPwnh94ZFoEe7KZkUH9rYjUs+9xs/sT/0l/OoO8X8UHN49AwlNuZT7KD?=
 =?us-ascii?Q?RLz+XKfM6yo1BcsGUjDCCb7TQDK8b0mftINlFUR9Lo/CfKzXIYS9SYhGwow7?=
 =?us-ascii?Q?XBm9ajVV6PiEuZdIbww9ZdFr9kfg67N3vkhqyFDdriXY9KVwqbMfso/hYWzm?=
 =?us-ascii?Q?gvtkv4i04LKlKI4M5iGAZZvk0oU/CQS1F5LNQckCe13yZo6VpiAPgJPdIuEd?=
 =?us-ascii?Q?lK2pQShTevEjcppMExok2yT7W0taVR9UE8uLrZcFKYiVO7N6C8o2SrWtWbSR?=
 =?us-ascii?Q?l9ESndSXVChCqxaQFpbNTi2Rvr9J5SG8wJ/2ZKtJx45S1EQ26vVzqr31SJ9K?=
 =?us-ascii?Q?z/XVkm1z6cYS+CRDk/B2k9b2HrCpDM6y2qVhvJ70N00y29zyvr9C2lNwICAE?=
 =?us-ascii?Q?665HuepvGZY5DYHhTp/zHl1mtvhLOlR1L+nzz3V8a1JeOk58Qi2+ddL/Hgdp?=
 =?us-ascii?Q?nplk8z2qYKkwDLa6bCm6Zt4z6As3YVNOkWU4rTlpZh5g25Ua1NXyq1zFx+kU?=
 =?us-ascii?Q?IZ+KD5MVtpOATQq2jsXxoZ/dLyB3DE6r2i6UBc9rmk3C4ekS2HEFtLZ+l/ie?=
 =?us-ascii?Q?p7FwDwJRveOwBDCVgP148Ap2g5hrXHQ4iGpVnsbegYC5d/5o0iohhFz66DQg?=
 =?us-ascii?Q?z3SVsuM2J+snOy2Uc8e5UPPJ82an8YHm36GRtXCa4085ZqZJlhnTaS2CfbJm?=
 =?us-ascii?Q?B8MkjKcHC5afEuj/yM3gkTbW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hmCLnWVgMs20n9QGLaLm+loQlmuWwQt8YP8ZbFYsGzXA5weWX9GNI72jSNVc?=
 =?us-ascii?Q?dxVNfgvFz1ejAHdMYulAVtHmSUTc+rWEWyk1lW2gy8Xcwefk3f/ulK5WHot6?=
 =?us-ascii?Q?ImM3qE06J7azJZ+Xf/ovgHeMwndnzhfnnv9sFN4oxa7+ltSLq8+poRZC6xww?=
 =?us-ascii?Q?xUgT3xcbCQ7ZqKYY+5rFxI/xn/+gCoHiCvlcAViP/F2C5xTviRL+QftxczEH?=
 =?us-ascii?Q?62m+fCsAFJGrkFuuw0y3YffNpJKVKWQvG87sK5i0k4eDaZh3syWLlRCj16s6?=
 =?us-ascii?Q?emVG96wxh+8Aq3Ua3S/eiy6IEJiqFZttT5KKJSWH4kLCk7DLwA8uGZotUhws?=
 =?us-ascii?Q?6ugLWGifq8JPacb+qAoI992gSqjAtC0LSRQFznJNcds39U5zBTeBm7T1Qme2?=
 =?us-ascii?Q?yfbQAxhovuGA6ia36ZBLHUd6uXVKzwBOjdIlgGEP9umtCA5m6nE3nrfZVwHh?=
 =?us-ascii?Q?Hp6atPvNygg1s4QCj6LrXp/YBwYcnxdoedFDYpyInJ0lNXZCbBqDn7LkKGwf?=
 =?us-ascii?Q?ZQAeL0c8BhwcPE52mgnSsess0LH1FOyAmd7hiZtHq/DQiZDCnam0qKy8Dytj?=
 =?us-ascii?Q?zkrGPEx4gVphpcatsGNetaIS2Z5UrBOeiQZuca89ImK+3lOdhD/a7dpk0Kfw?=
 =?us-ascii?Q?20XiyH08NjditDfGAvAYAnIrQ6i+3rJoKgMZeDoy+JJMUMuTwYwjEr6QQ+zD?=
 =?us-ascii?Q?R9k/KmYI935r1HSl2vFiLTivQCwgyfx4s9J1ZRaykVpmTZYLOABPJgkWiObc?=
 =?us-ascii?Q?rb0LDGDhLYXduT24dNPKWeQb9j2lgojMENNFC/DpzuJfQ1xzgsmuPi6RoSvB?=
 =?us-ascii?Q?YEgH6+t6JV9we8mqt++cFTlQAEBwC/q+DeeOHXqR2Mg32HfRxF3hHrLOGFm3?=
 =?us-ascii?Q?/aOW0xtqRVU/8o3ZEehb6eNCdC9uX41Bjx6QnJbmK1FzymzA6eKQf+5CzCy5?=
 =?us-ascii?Q?ZfiUjFSpOy+6+PMVEcS8A3ROJlm57U4lRmHAwgJf23AQcKp/eEbAT7mpAX35?=
 =?us-ascii?Q?NTPj2gXePW5vWhD51RSVug7fwIfkXCuNErGagNYLGN4gQaDUIpcUJj/sNnr2?=
 =?us-ascii?Q?fIYi2sSYy0ZHrG/mK9sTGeikv8GivP6Ko2v/ji0yfVUfdWp510Ubq37ST8JX?=
 =?us-ascii?Q?vkSl8X33w6gYHebDwBTSMMAyI0eGEsgkGStSjao8SY+WXlE6enr39uphImW/?=
 =?us-ascii?Q?R7ZAa033AQK9y2PDFfxqVHx8zbwmQZKgKROP5mQ06kM/qPd0iB8ntW5br2k5?=
 =?us-ascii?Q?UAjuzAmW2AH4ECxgAIChI5BFJQaubyZHH6KMXzst9P5SpnCULUKLKUojOp6A?=
 =?us-ascii?Q?WSseDMg1q84dXGz1VplcTp18UXigd8lAlBEDoX1BOfktCKF8pv4131KLMda5?=
 =?us-ascii?Q?ZcAIAiVeo543syuGzhCy619qiwAg8PeUENIKRZnXAyfnEyxrfn2HGsT/TCCf?=
 =?us-ascii?Q?J+z0ve+qGH4KnPVtnkSOge1KHdgzX24SVzAaVvz8nTWT5ilf+KWxMRbAFdzZ?=
 =?us-ascii?Q?Y7Cec4DLeQDNK6DpNhYqeVCdhSqGKj4AROKLeT2wkOnt/+r4dhRWzshCpC3T?=
 =?us-ascii?Q?+MQw8REFGZqRNPsNQT9xiHJRNJrcoF1gp+2sPjcfV9rQCi/xwIgz1w+7QL7G?=
 =?us-ascii?Q?1vtOhy6ioaPOgbA28JnrmaYJRmw5a6WC4+VA0uqj7kgKweKoBMEwU+Xh1ErI?=
 =?us-ascii?Q?59oiAQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tEbNw632Zv6KGAYJHvI9GjavZn3Cb5f6XLBHw1s5zcEx/MW96BLH8n6JoLk+QFrmLhr8x5ugvQ4pzMU1GUyZlbrU1AsreSguZfQOFEnaqO3TCXgKw2CC+IVZqZdVT8nvjeBJ26g8+5b9Mu5ncqXpgQt1PewNRWGhujYhDCo8KMxzAcgHRmyvef4G5XftqCbNP0VwLUtYvV3analAENl4eaM41pXQyiX8ekuvoXKNg/H/f7pm4AH3puejseZnGIzMLaYjvaAXakg5uZ/YMAK2YybS9jG54TWQXnW64AmKY9YOlQZ62h16ggJggI1BVoA+MrwgvPi7/N4QrZoDi7AoEL8c63LQdvZIEK+gOCf+nGiPajse3lKVxhWKX6pWARwc67QpawGVJTrSPhlyBEB9ejiU5Rei+1PDUwMfs/LNbDVtz46Dv4NoRAkwuztebSNxn9He0IMZSBqAawcVFottF7nB5sHjYSa3XYDFQlrC+vALqQ9+2FxGRGnT25UYSOBGTsSlW1bnczczpeWx0YzCwbjFzlZl7S67xeaJJvbuRmVySsyO7KoI+GKK3RmNJEO+hJLBoszthfJXCF4EyXv3Am9jGaX+PU4H0WPyle05f5k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c0c3067-c6e4-4580-1dca-08dcf3a2bbcd
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 20:39:04.1804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PB5FehlCXSNSyjAf6hA96DYkmPRwniofeSwsGqvT4t3mOjD/l2idYRyhSggNvZAfdaOHFMsYi+eKOzDnl8ZCBqr8X96QchsDfxUd7iBF25Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5833
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-23_16,2024-10-23_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 mlxscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410230132
X-Proofpoint-ORIG-GUID: cJ4ZA9dO-MjJLmDSTGZ47qRkGazPDiZv
X-Proofpoint-GUID: cJ4ZA9dO-MjJLmDSTGZ47qRkGazPDiZv

The mmap_region() function is somewhat terrifying, with spaghetti-like
control flow and numerous means by which issues can arise and incomplete
state, memory leaks and other unpleasantness can occur.

A large amount of the complexity arises from trying to handle errors late
in the process of mapping a VMA, which forms the basis of recently observed
issues with resource leaks and observable inconsistent state.

Taking advantage of previous patches in this series we move a number of
checks earlier in the code, simplifying things by moving the core of the
logic into a static internal function __mmap_region().

Doing this allows us to perform a number of checks up front before we do
any real work, and allows us to unwind the writable unmap check
unconditionally as required and to perform a CONFIG_DEBUG_VM_MAPLE_TREE
validation unconditionally also.

We move a number of things here:

1. We preallocate memory for the iterator before we call the file-backed
   memory hook, allowing us to exit early and avoid having to perform
   complicated and error-prone close/free logic. We carefully free
   iterator state on both success and error paths.

2. The enclosing mmap_region() function handles the mapping_map_writable()
   logic early. Previously the logic had the mapping_map_writable() at the
   point of mapping a newly allocated file-backed VMA, and a matching
   mapping_unmap_writable() on success and error paths.

   We now do this unconditionally if this is a file-backed, shared writable
   mapping. If a driver changes the flags to eliminate VM_MAYWRITE, however
   doing so does not invalidate the seal check we just performed, and we in
   any case always decrement the counter in the wrapper.

   We perform a debug assert to ensure a driver does not attempt to do the
   opposite.

3. We also move arch_validate_flags() up into the mmap_region()
   function. This is only relevant on arm64 and sparc64, and the check is
   only meaningful for SPARC with ADI enabled. We explicitly add a warning
   for this arch if a driver invalidates this check, though the code ought
   eventually to be fixed to eliminate the need for this.

With all of these measures in place, we no longer need to explicitly close
the VMA on error paths, as we place all checks which might fail prior to a
call to any driver mmap hook.

This eliminates an entire class of errors, makes the code easier to reason
about and more robust.

Reported-by: Jann Horn <jannh@google.com>
Fixes: deb0f6562884 ("mm/mmap: undo ->mmap() when arch_validate_flags() fails")
Cc: stable <stable@kernel.org>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/mmap.c | 119 +++++++++++++++++++++++++++++-------------------------
 1 file changed, 65 insertions(+), 54 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 66edf0ebba94..e686d57ed9f7 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1361,20 +1361,18 @@ int do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
 	return do_vmi_munmap(&vmi, mm, start, len, uf, false);
 }

-unsigned long mmap_region(struct file *file, unsigned long addr,
+static unsigned long __mmap_region(struct file *file, unsigned long addr,
 		unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
 		struct list_head *uf)
 {
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma = NULL;
 	pgoff_t pglen = PHYS_PFN(len);
-	struct vm_area_struct *merge;
 	unsigned long charged = 0;
 	struct vma_munmap_struct vms;
 	struct ma_state mas_detach;
 	struct maple_tree mt_detach;
 	unsigned long end = addr + len;
-	bool writable_file_mapping = false;
 	int error;
 	VMA_ITERATOR(vmi, mm, addr);
 	VMG_STATE(vmg, mm, &vmi, addr, end, vm_flags, pgoff);
@@ -1448,28 +1446,26 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	vm_flags_init(vma, vm_flags);
 	vma->vm_page_prot = vm_get_page_prot(vm_flags);

+	if (vma_iter_prealloc(&vmi, vma)) {
+		error = -ENOMEM;
+		goto free_vma;
+	}
+
 	if (file) {
 		vma->vm_file = get_file(file);
 		error = mmap_file(file, vma);
 		if (error)
-			goto unmap_and_free_vma;
-
-		if (vma_is_shared_maywrite(vma)) {
-			error = mapping_map_writable(file->f_mapping);
-			if (error)
-				goto close_and_free_vma;
-
-			writable_file_mapping = true;
-		}
+			goto unmap_and_free_file_vma;

+		/* Drivers cannot alter the address of the VMA. */
+		WARN_ON_ONCE(addr != vma->vm_start);
 		/*
-		 * Expansion is handled above, merging is handled below.
-		 * Drivers should not alter the address of the VMA.
+		 * Drivers should not permit writability when previously it was
+		 * disallowed.
 		 */
-		if (WARN_ON((addr != vma->vm_start))) {
-			error = -EINVAL;
-			goto close_and_free_vma;
-		}
+		VM_WARN_ON_ONCE(vm_flags != vma->vm_flags &&
+				!(vm_flags & VM_MAYWRITE) &&
+				(vma->vm_flags & VM_MAYWRITE));

 		vma_iter_config(&vmi, addr, end);
 		/*
@@ -1477,6 +1473,8 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		 * vma again as we may succeed this time.
 		 */
 		if (unlikely(vm_flags != vma->vm_flags && vmg.prev)) {
+			struct vm_area_struct *merge;
+
 			vmg.flags = vma->vm_flags;
 			/* If this fails, state is reset ready for a reattempt. */
 			merge = vma_merge_new_range(&vmg);
@@ -1494,7 +1492,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 				vma = merge;
 				/* Update vm_flags to pick up the change. */
 				vm_flags = vma->vm_flags;
-				goto unmap_writable;
+				goto file_expanded;
 			}
 			vma_iter_config(&vmi, addr, end);
 		}
@@ -1503,26 +1501,15 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	} else if (vm_flags & VM_SHARED) {
 		error = shmem_zero_setup(vma);
 		if (error)
-			goto free_vma;
+			goto free_iter_vma;
 	} else {
 		vma_set_anonymous(vma);
 	}

-	if (map_deny_write_exec(vma->vm_flags, vma->vm_flags)) {
-		error = -EACCES;
-		goto close_and_free_vma;
-	}
-
-	/* Allow architectures to sanity-check the vm_flags */
-	if (!arch_validate_flags(vma->vm_flags)) {
-		error = -EINVAL;
-		goto close_and_free_vma;
-	}
-
-	if (vma_iter_prealloc(&vmi, vma)) {
-		error = -ENOMEM;
-		goto close_and_free_vma;
-	}
+#ifdef CONFIG_SPARC64
+	/* TODO: Fix SPARC ADI! */
+	WARN_ON_ONCE(!arch_validate_flags(vm_flags));
+#endif

 	/* Lock the VMA since it is modified after insertion into VMA tree */
 	vma_start_write(vma);
@@ -1536,10 +1523,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	 */
 	khugepaged_enter_vma(vma, vma->vm_flags);

-	/* Once vma denies write, undo our temporary denial count */
-unmap_writable:
-	if (writable_file_mapping)
-		mapping_unmap_writable(file->f_mapping);
+file_expanded:
 	file = vma->vm_file;
 	ksm_add_vma(vma);
 expanded:
@@ -1572,23 +1556,17 @@ unsigned long mmap_region(struct file *file, unsigned long addr,

 	vma_set_page_prot(vma);

-	validate_mm(mm);
 	return addr;

-close_and_free_vma:
-	vma_close(vma);
-
-	if (file || vma->vm_file) {
-unmap_and_free_vma:
-		fput(vma->vm_file);
-		vma->vm_file = NULL;
+unmap_and_free_file_vma:
+	fput(vma->vm_file);
+	vma->vm_file = NULL;

-		vma_iter_set(&vmi, vma->vm_end);
-		/* Undo any partial mapping done by a device driver. */
-		unmap_region(&vmi.mas, vma, vmg.prev, vmg.next);
-	}
-	if (writable_file_mapping)
-		mapping_unmap_writable(file->f_mapping);
+	vma_iter_set(&vmi, vma->vm_end);
+	/* Undo any partial mapping done by a device driver. */
+	unmap_region(&vmi.mas, vma, vmg.prev, vmg.next);
+free_iter_vma:
+	vma_iter_free(&vmi);
 free_vma:
 	vm_area_free(vma);
 unacct_error:
@@ -1598,10 +1576,43 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 abort_munmap:
 	vms_abort_munmap_vmas(&vms, &mas_detach);
 gather_failed:
-	validate_mm(mm);
 	return error;
 }

+unsigned long mmap_region(struct file *file, unsigned long addr,
+			  unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
+			  struct list_head *uf)
+{
+	unsigned long ret;
+	bool writable_file_mapping = false;
+
+	/* Check to see if MDWE is applicable. */
+	if (map_deny_write_exec(vm_flags, vm_flags))
+		return -EACCES;
+
+	/* Allow architectures to sanity-check the vm_flags. */
+	if (!arch_validate_flags(vm_flags))
+		return -EINVAL;
+
+	/* Map writable and ensure this isn't a sealed memfd. */
+	if (file && is_shared_maywrite(vm_flags)) {
+		int error = mapping_map_writable(file->f_mapping);
+
+		if (error)
+			return error;
+		writable_file_mapping = true;
+	}
+
+	ret = __mmap_region(file, addr, len, vm_flags, pgoff, uf);
+
+	/* Clear our write mapping regardless of error. */
+	if (writable_file_mapping)
+		mapping_unmap_writable(file->f_mapping);
+
+	validate_mm(current->mm);
+	return ret;
+}
+
 static int __vm_munmap(unsigned long start, size_t len, bool unlock)
 {
 	int ret;
--
2.47.0

