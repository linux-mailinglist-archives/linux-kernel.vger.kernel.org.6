Return-Path: <linux-kernel+bounces-345452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C604298B679
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 10:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82983282ABF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 08:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD23B1BCA05;
	Tue,  1 Oct 2024 08:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CEwPxuZJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bH4dbNkf"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B282319D8A3
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 08:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727769806; cv=fail; b=e9SH8gX22kjrYM1n0xDqKat138UU2BB45i2STBIIlSuqZMgOAkeUqjdsa3KgvTKEZgO/BxMUjRCanAENxf9T3F17F9wU0oAVBWqZmerX9kmUz63Z3oNKdD73sy5dC9fNq+ZbwaJel3FysC+3OLyhiJp6V643No153RnufOHwSJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727769806; c=relaxed/simple;
	bh=itrC7Q7MHT6R4BOXNRG/Z2MaYxGJfSPEleQmIaRo/lo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bdv2aJBBZYwHVyxStNu3awgsSLyBGsAqA1lv/YDFINsq6hwmRbXNsir3l1Tgxlva5k5zvhxLs/RIAx3ss+Hq4vUXj9Y/rynd0xrl/NrqUGXn4YvcmEuC3jGDIe/ehgJHhMM21cH3dLWGnoTeEegesFddB2gvDquWYMfZnrYkUwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CEwPxuZJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bH4dbNkf; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4911tecE031728;
	Tue, 1 Oct 2024 08:03:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:content-transfer-encoding:in-reply-to:mime-version; s=
	corp-2023-11-20; bh=BRgReFMN2FApJgOCZ3TaBDaKuNOWcPYk5w1YvgyBJLA=; b=
	CEwPxuZJ1D7jOQLSZZS0Cuv3NCv1GMjGeX3uQWp0NZqRfw0JwnFEgRtit6gMK5yh
	Do6hVkswTcjY0mgWVvldoTIO2g6h9OFNN73OMe/JmnKxGWKzOot/4bLdrtJ/Y+aU
	BQdykhMmiUxNjC89HUUVFzwE9DDUXP9/+XSy6ZjAp+cXHkzByUGezCOyKbbny8rk
	bxGTCtfVCqAxaY8mBuxjQmp0mqWiCt9ebtiG4O1iZgDT30k8IW+GN5zzjOx8Cm3l
	4qHf7NQO/E1QHb2lZTzythz0JL3QA9HuQoKtfB5WckSDvFXRXQpyi8TIhuTskdNW
	8xKScTE6xJNQc5g2/6rvdw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x8qb5ke9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Oct 2024 08:03:16 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4916FQIL026413;
	Tue, 1 Oct 2024 08:03:15 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41x8877jte-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Oct 2024 08:03:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pSwQz42ufjFQFnm5HFNxVtJ/OfOIJon/4Qd8ZUXUvyyIOmDCUjhdJtt9pBfJd4Bw8MSW4ZnbAfLV4WzzWA/KCDxo4XDhbb4TuHkShqCvxuv8Zhl/Tn7xn39ZmcE635cBtYPQy5lx1hJNHqPV8/mR3A0+cvkQx/5f3HixQgVZ8BsZRgqDYsAscznXA/z/MrWo35xVDyrixPCCtAIxrct2eCDUkSPi/mqgKtjL07np34og6hFVYKcLb6US+tl54owOpBhffasvfats/kRvj43J479B43/+v3E5bD7Co90iuhgR3BMHw4YXNGa3447vJPTjb4hkoMKDHA0mSmukR54bCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BRgReFMN2FApJgOCZ3TaBDaKuNOWcPYk5w1YvgyBJLA=;
 b=Da4lds5IlNxGVfXG3yxgDLUreZ/Am2a4VjRECaih6CueXWSm59aEr21xH/kL0LmwB7nRey3qDC6oB4vwvxo8fbFoLo/AjWwSW4QJ3aZ568zaewvArsfVBYHpnMXaA3kMdVUTZ24drritZyW67gr5grH+rgueBwhyli+KT7TYiwe+1r9f0pR/e4Kwlnv7qNFMIwlynrgTNn3q5Te8z4wdnNy9m0gtd+cczPePxOcnPdWLKzxmdMILOv+Ofb6AXYzIb6P+tTDGezhXr99KIx4ezCOR4IIyYCw2uj4VZAz25ZVHF8YxkHu1QztZ52zimTEgaqMGB1CgvZ6SClzw2kIluQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BRgReFMN2FApJgOCZ3TaBDaKuNOWcPYk5w1YvgyBJLA=;
 b=bH4dbNkfIctcpzAS7c22wtqMWLxd7FWh6pfzZPkAu0jt1AVkB+eRAQfw9b2TJInh6K02aC/iFMyPnSWV7bHIDXR07ddPHvZjK/5Wz3iEUHfeJphQRzjY+Pas9vOWv7SrGkF+/9e2FO9M0JFATxFCOynIx3STVv5clee2DRnCYQc=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by DS0PR10MB7173.namprd10.prod.outlook.com (2603:10b6:8:dc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Tue, 1 Oct
 2024 08:03:02 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8026.014; Tue, 1 Oct 2024
 08:03:02 +0000
Date: Tue, 1 Oct 2024 09:02:58 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Bert Karwatzki <spasswolf@web.de>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 14/21] mm/mmap: Avoid zeroing vma tree in mmap_region()
Message-ID: <5ec8665e-2f51-4b06-b68a-c878a969fb06@lucifer.local>
References: <20241001023402.3374-1-spasswolf@web.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241001023402.3374-1-spasswolf@web.de>
X-ClientProxiedBy: LNXP123CA0010.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::22) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|DS0PR10MB7173:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b61a521-e7ce-4fd6-0c2a-08dce1ef78f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?v5+Q2gfYF0vZ+bKII5H6tRc0XmlB71YVa7Ei+iWVS5HcApxVp6wdIiqZ0N7A?=
 =?us-ascii?Q?O7YcM1k3qAX0/zyZ6p3dMpIZcDcgG+zPLN2q6rX4fmhT0SwvhP5kGkQ5fL2V?=
 =?us-ascii?Q?QjcJ8HvsIeJiHRys/livgcQTbghLtvkzITgWYDy7WqtoxHiHEOxyoyNmjIGk?=
 =?us-ascii?Q?OAhXTLtcotIAb5RaJX9AKRR0aKvzKzuQJxGvMF+IteRI2YySLW1uKlbNdCJ6?=
 =?us-ascii?Q?O9++4kwEpw5axbDGn0znAaiIZaolPLBcvQPyWFmay9Vu45HiAf+y3DRli5RU?=
 =?us-ascii?Q?7KeJxYCu4yfWsjjhNXYJDX6ORGliKgaT53U5DkBNier1qoUVW8nRT1ROAbm4?=
 =?us-ascii?Q?yZ8EURTsLGLElt32CCvsaicgMP+Mxdp+yLGhBdrz8rf+68YfifFiFlrHlebn?=
 =?us-ascii?Q?PVxlu7V8Bso7M90ei5qlCxvyqBtuXjUwxA+ECNd3XbRVO5KWFGCHhjpn64uS?=
 =?us-ascii?Q?Ub8c2GJZ1l4Z6sy1zuF6Ejw6AH7MchoO0VyKoEBL+7BctkG9KtXkT82gx1Al?=
 =?us-ascii?Q?Fj8QCb5mStjZJ7JtC148nTSTpEzmMBxBQ0yl8h8nGyr+NV6EzpUYsM79FoRw?=
 =?us-ascii?Q?7AxoKOB1B20iQPpjDJ3OkIoLSGyqXX39bKYKEHmvr0NTA0TOQBZ9c1oE5gL9?=
 =?us-ascii?Q?Y8hZK19lJtmLNT4dM3Aj3ZzInyzqOBSuVVfNoFzyL2bpg3dxepcofm6P+DQF?=
 =?us-ascii?Q?fb9bQcsgGbLBqHAYtQjzr8kzXHWpEUQ8EZoYg4tW+p0CafoXZC9J5Avv7B3j?=
 =?us-ascii?Q?9clRQp1ZTU7K5w1dgLIzu+tlxFCCyyCgSvOF0qPgAkBpZvDNc/Qufnl5t9uX?=
 =?us-ascii?Q?6ayzjn6pkHsxDz1iUVMlBuFnN7LBjQUMDXEwSk4rgyP82cI+jt3LIgGpDaM8?=
 =?us-ascii?Q?wPK3mrUzBNzmafKWnpmQiU+YCr+t1DaN/KOg2E/XZzwKYqZMriaUNpwASQLb?=
 =?us-ascii?Q?JuWs2qaAfvaXzWUuKhRYU12YX7UDOqF4UQpPne+r+7dtIYheRtK7YFqOD1L5?=
 =?us-ascii?Q?B/i4hrt3/bVasVe/7WOXEQBS9mJXHeCC2QZ1eD5HVhEzKDQhXKfYxAtxWTQV?=
 =?us-ascii?Q?Pqd44FOj7xjL/z0+5i2uJB04Wdyj+gUvjSQqQuoFt1tepKJm9Ap3xPu6Y3SB?=
 =?us-ascii?Q?zrV8fH3cMIt6tN01KvO7p5IVOhGeVzco+1A0wfSZaU25TZxcbTTRIaK6rlNt?=
 =?us-ascii?Q?yEVAxKeh54zvp5Ov3X9bP8UF8+ZZ3vmoyJFObsrkHFL3nE14CeTiMyZHINwe?=
 =?us-ascii?Q?Hh4IOXEbs/74nDDqrCUceYZzb9GUDptPXUaqdDFKFToEQxJ76OyrPXxzp4Og?=
 =?us-ascii?Q?1W4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cbsZViomQJW7G2rjpmPjSFIst25dVZnHXpnNGVuNZ1Ufbr06nNMRFVXyGvOo?=
 =?us-ascii?Q?gzUQVqMGi8kZJenjdqctErEKVe0w6o9wDNGyJBenX1lijtP8CalbwAnGEdZ+?=
 =?us-ascii?Q?zHdLXqDwURTcCBYbXbgyQzHmV2W13fEdsrgE+kAEe79A0A3WXrWpRHPw8AWJ?=
 =?us-ascii?Q?pwR8koBx75zHtSOFNX06TB7xuf5E3Z9aQYoDMisyPNPsNSYcXUbJ426S/+Hw?=
 =?us-ascii?Q?s37WQE53d7aKJ3m9RYjOmln87QSNkxhVmQcrvpTZ2+McvWxVjxY/6SxF7ntX?=
 =?us-ascii?Q?5awgTA9GHKwzTCcCRkqetnBaxgnu88yYJUBsYyHs1Dc2ly4BYrMQXxvexZIT?=
 =?us-ascii?Q?BH/sN+u0zMGyxU5T8t0K8pkVZdV3lafZlxdRjjIvL1KWuwdrd4qyO8lEknQu?=
 =?us-ascii?Q?RIt6NKIIfQ4B1DtJNnLphVwhxIEvOFxHwNYBlj2Uu95p2jtuqHkOoS6tQAF0?=
 =?us-ascii?Q?OJDdL6/aZUxDi9v9AMszqd9/yyweq0Nr7+J+lJn+lgdsC5idb4uXL+jqTWaW?=
 =?us-ascii?Q?SbzaWYWbqptQq1AJ02s8VohXxsyIXAhv4elgD/LKT9vhRV6nAN245y+2nxs1?=
 =?us-ascii?Q?JQSiXMnbHH0xhmI1I1HU3ZfRm+vRQ6VpKZGczDklHKDQwc7Du4EO6iR6uWBf?=
 =?us-ascii?Q?zIuJ/eFheq3dYCK3jSrYYs6q/h2iAleMAMTCFTFad8sYVhCuU3p+GUW82JuS?=
 =?us-ascii?Q?aLc4PbLxVJyLlxFKGaeHQnI11eprJq5yR73KUmDY7avP/6P4dc5zwq662IdJ?=
 =?us-ascii?Q?ODlWe9/vaFYGjK6AnRUvv37sxZ/TAvut93dBolTUOMYUHcEqs/o13XIDaNcF?=
 =?us-ascii?Q?M9QRZKzK76OMMbtiaeZggrXI2nhCObgLcqLYQ5qH8fyiJPl9gWBwEHeoD7x8?=
 =?us-ascii?Q?Y+eP2HwZA4G5EXz1RJJuZx8eOMjA7MpRahEShnI3K8Kp5jzYLJzjwy1MnE0s?=
 =?us-ascii?Q?m2JsiyP2fDudHqNxALcNCnxyOz1hzJoH6zhlBoZHVOFtCFO9j2aBDe47q70V?=
 =?us-ascii?Q?TawBQezIR2XtqyeZ0FOEtFPNH7vgh3Kf+a+OCSH4n+Jr0Hn4WjE+Y3aky1+e?=
 =?us-ascii?Q?C94TScrExN08Qhzo7GomNKfDzOfnFzQp4V6ch2f1znlbCTUawhqbYgGHW65A?=
 =?us-ascii?Q?Ypz386AqkSg5i50AoVLx//h3sBAr8A7q8xQA4sLo+jXAORr9cwiOg90AWCd6?=
 =?us-ascii?Q?Q4VWdl+V9qX3PwlGAvq40j46tug4ZAZ/y0txHDSid6uMn2v35op8TBe2Keaj?=
 =?us-ascii?Q?ZgCmx3Mb6gZCvizUYWe0nrc1X6jVthJRR30AWgbtiYdK9UMk7TKjsbKWsWGO?=
 =?us-ascii?Q?v0KJYkY44SWRxVoHWLtXaoJmMWOPcP9KccipkhORTCmWdIAfz9GCheX/1KXy?=
 =?us-ascii?Q?FeFZ1U0RGdo46K4Vs4nxByms+9mbcwhG8tCN6UUHoC86khXWr+QyyghT8OJh?=
 =?us-ascii?Q?i/MFo8e9QUC4fY0PXyYcYV7oKTkV9+1yywUk6N15BlfGUFWczI0UVMAWKDe6?=
 =?us-ascii?Q?VDk6X2sbucGQtEl/gmXyzu4eDnnbENNa62VFZNuBbs55aQ9yfSVbi1Py1mBk?=
 =?us-ascii?Q?7gi8Xoe9ynklid5ghL8JTGLYnzIZ3WlP8oYVllhdJK8Kx2JlIf3WigxGnED7?=
 =?us-ascii?Q?8XMPaUp/6Wn2glBgvkbpSyBDJbLvXdp3vaIv/R35fz0Ls5KkXwQJOHZ5gWyQ?=
 =?us-ascii?Q?pOs3zg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BDjYc23dA9qh57ld7TCkx2BDaUDk+Peon4ISCOjbriNMHYN7BQ62td2P1CwmTHKmvhQWsePrZutp4CWffOoMHxOqQt1xjIUscbPO+ER9eQop27X0gLN4UOi2zJvjsNxbBfM7q0fKtsZAFz2ZU1Kfua6hcIxdt8FZgSQ1+LR60oXjGqbv32UQS4EoFrg0CJoqpZQvK2hK/LBfAHYmTvDU7m7DWFECgchKOuf8tK38go8jo7vOk2lb6qX/puI2igExI3OcpQ/4ZY7u2SKxaac9KPpJOVWIHEqB5T8rJg0VxSEkNyqTRTD+ujMwAi8bDzYmQMMQICqGvUmNiojbe8CJ9CX0j6POwT8iHIF1+5KnsPZUL3qOThb8SWyzZFgrqadStf1bSXmqj+cJsqQugwWFoSptHMg9PMHlEgLulBjYlhbu6fhvNC4mJFq/axlHCETNtWgxzdM0jx9Qh2zORIcgfNBZwBUCrEDDLIuYWiIec34HC0d0WsH/nKIwJ/UGo/AVKkfk3GnwK+xxZ3O6Jc1kt0eNZLNvHEXay6HtjzM2epSP66+uGhSuVykZrZeJRfnFsi0m2mQxXLSFrfdz2f5YMDZEpuBi8M+HAu1FU+VKswU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b61a521-e7ce-4fd6-0c2a-08dce1ef78f2
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 08:03:02.3726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S5H0lZpzzL/ffDh51Cyk58OI8uu+olUsaibZJR3/qj/Ok7CwaoDt57FazauAd+YphEJufEhQ+Vz9TW1o5HZ2dVU0+OEFMscZpzqlTlCReOI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7173
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-01_05,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2410010054
X-Proofpoint-GUID: EZWv2OuXRjuq8SXAehsqrocyLttcloNj
X-Proofpoint-ORIG-GUID: EZWv2OuXRjuq8SXAehsqrocyLttcloNj

On Tue, Oct 01, 2024 at 04:34:00AM GMT, Bert Karwatzki wrote:
> I just noticed (via a bisect between v6.11 and v6.12-rc1) that this patch
> (commit f8d112a4e657 in linux-next tree) leads to a severe memory corrupt=
ion
> error under these (rather rare) circumstances:
> 1. Start a 32bit windows game via steam (which uses proton, steam's versi=
on of wine)
> 2. When starting the game you the proton version used has to be updated

Yikes. Thanks for the report, very very much appreciated. Will look into
this as Liam is out until next week.

How repro is this? Is it consistent?

Can you confirm exactly what commit you are at in the kernel when you
generate the below dmesg?

If you are able to reliably repro, could you try again with:

CONFIG_DEBUG_VM, CONFIG_DEBUG_VM_MAPLE_TREE and CONFIG_DEBUG_MAPLE_TREE ena=
bled?

Might be useful to get CONFIG_KASAN on the go too... and CONFIG_DEBUG_INFO =
:))

Actually CONFIG_LOCKDEP and CONFIG_PROVE_LOCKING would be handy here too...

Very much appreciated!

>
> The effect is the following: The updating process of proton hangs and the=
 game does
> not start and even after an exit from steam two processes remain, one of =
them at
> 100% CPU:
> $ ps aux | grep rundll
> bert      222638  1.7  0.1 2054868 87492 ?       Ss   23:14   0:01 C:\win=
dows\syswow64\rundll32.exe setupapi,InstallHinfSection Wow64Install 128 \\?=
\Z:\mnt\data\.steam\debian-installation\steamapps\common\Proton - Experimen=
tal\files\share\wine\wine.inf
> bert      222639 99.8  0.0 2054868 2380 ?        R    23:14   1:01 C:\win=
dows\syswow64\rundll32.exe setupapi,InstallHinfSection Wow64Install 128 \\?=
\Z:\mnt\data\.steam\debian-installation\steamapps\common\Proton - Experimen=
tal\files\share\wine\wine.inf

Is there any dmesg at this point? Or not?

>
> When trying to kill those processes with "killall rundll32.exe", these er=
ror happen:
>
> [ T4313] ------------[ cut here ]------------
> [ T4313] WARNING: CPU: 6 PID: 4313 at include/linux/rwsem.h:85 free_pgtab=
les+0x233/0x250

That should be rwsem_assert_held_write_nolockdep() if my kernel is not too
different from yours, which suggests we're asserting that a write lock is
held and it's not...

Likely this is in __is_vma_write_locked() called from vma_start_write().

That's extremely weird if exit_mmap() is doing that as it explicitly calls
mmap_write_lock() before invoking free_pgtables()...

> [ T4313] Modules linked in: ccm snd_seq_dummy snd_hrtimer snd_seq_midi sn=
d_seq_midi_event snd_rawmidi snd_seq snd_seq_device rfcomm bnep nls_ascii n=
ls_cp437 vfat fat snd_ctl_led snd_hda_codec_realtek snd_hda_codec_generic s=
nd_hda_scodec_component snd_hda_codec_hdmi snd_hda_intel btusb snd_intel_ds=
pcfg btrtl snd_hda_codec btintel uvcvideo btbcm btmtk snd_acp3x_pdm_dma snd=
_soc_dmic snd_acp3x_rn videobuf2_vmalloc snd_hwdep uvc videobuf2_memops blu=
etooth snd_soc_core snd_hda_core videobuf2_v4l2 snd_pcm_oss videodev snd_mi=
xer_oss snd_pcm snd_rn_pci_acp3x videobuf2_common snd_acp_config snd_timer =
msi_wmi snd_soc_acpi ecdh_generic amd_atl ecc mc sparse_keymap edac_mce_amd=
 snd wmi_bmof ccp soundcore snd_pci_acp3x k10temp ac battery button hid_sen=
sor_prox hid_sensor_gyro_3d hid_sensor_accel_3d hid_sensor_magn_3d hid_sens=
or_als hid_sensor_trigger industrialio_triggered_buffer kfifo_buf industria=
lio hid_sensor_iio_common joydev amd_pmc evdev serio_raw mt7921e mt7921_com=
mon mt792x_lib mt76_connac_lib mt76 mac80211 libarc4
> [ T4313]  cfg80211 rfkill msr fuse nvme_fabrics efi_pstore configfs efiva=
rfs autofs4 ext4 crc32c_generic mbcache jbd2 usbhid amdgpu amdxcp i2c_algo_=
bit drm_ttm_helper ttm drm_exec gpu_sched xhci_pci hid_sensor_hub drm_subal=
loc_helper xhci_hcd nvme i2c_piix4 drm_buddy mfd_core hid_multitouch hid_ge=
neric crc32c_intel psmouse usbcore drm_display_helper i2c_hid_acpi i2c_smbu=
s amd_sfh usb_common i2c_hid nvme_core crc16 r8169 hid i2c_designware_platf=
orm i2c_designware_core
> [ T4313] CPU: 6 UID: 1000 PID: 4313 Comm: rundll32.exe Not tainted 6.11.0=
-rc6-bisect-00259-gf8d112a4e657 #539
> [ T4313] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK=
/MS-158L, BIOS E158LAMS.107 11/10/2021
> [ T4313] RIP: 0010:free_pgtables+0x233/0x250
> [ T4313] Code: f3 5d 02 00 49 8b 57 08 e9 74 fe ff ff 48 8b 53 10 31 ed 4=
8 8b 8a a8 00 00 00 83 e1 01 0f 85 51 ff ff ff 0f 0b e9 4a ff ff ff <0f> 0b=
 e9 80 fe ff ff 4c 89 f7 4c 89 fb e8 bb 5d 02 00 e9 7b ff ff
> [ T4313] RSP: 0018:ffffb21c0775bbe0 EFLAGS: 00010246
> [ T4313] RAX: ffffa02298d5f8c0 RBX: ffffa023b115b780 RCX: 000000000000000=
0
> [ T4313] RDX: ffffa022be442200 RSI: ffffa02290460d00 RDI: ffffa023b115b78=
0
> [ T4313] RBP: ffffa025b102ab40 R08: 0000000000000001 R09: 000000000000000=
8
> [ T4313] R10: ffffa02284b42500 R11: 0000000000000000 R12: 000000000000000=
1
> [ T4313] R13: ffffffffffffffff R14: ffffb21c0775bc08 R15: ffffa025b102ab4=
0
> [ T4313] FS:  0000000000000000(0000) GS:ffffa0312e780000(0000) knlGS:0000=
000000000000
> [ T4313] CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
> [ T4313] CR2: 00007f326de7e328 CR3: 0000000202832000 CR4: 0000000000750ef=
0
> [ T4313] PKRU: 55555554
> [ T4313] Call Trace:
> [ T4313]  <TASK>
> [ T4313]  ? __warn+0x83/0xb5
> [ T4313]  ? free_pgtables+0x233/0x250
> [ T4313]  ? report_bug+0xfa/0x140
> [ T4313]  ? handle_bug+0x3a/0x70
> [ T4313]  ? exc_invalid_op+0x17/0x70
> [ T4313]  ? asm_exc_invalid_op+0x1a/0x20
> [ T4313]  ? free_pgtables+0x233/0x250
> [ T4313]  exit_mmap+0x14d/0x2a0
> [ T4313]  mmput+0x3e/0xf0
> [ T4313]  do_exit+0x283/0x9b0
> [ T4313]  ? srso_alias_return_thunk+0x5/0xfbef5
> [ T4313]  do_group_exit+0x2b/0x80
> [ T4313]  get_signal+0x78d/0x7d0
> [ T4313]  ? srso_alias_return_thunk+0x5/0xfbef5
> [ T4313]  ? __do_wait+0x13d/0x250
> [ T4313]  arch_do_signal_or_restart+0x29/0x230
> [ T4313]  ? srso_alias_return_thunk+0x5/0xfbef5
> [ T4313]  ? kernel_wait4+0xa7/0x140
> [ T4313]  syscall_exit_to_user_mode+0x154/0x1a0
> [ T4313]  do_int80_emulation+0x94/0x140
> [ T4313]  asm_int80_emulation+0x1a/0x20
> [ T4313] RIP: 0023:0xf7ef9bc2
> [ T4313] Code: Unable to access opcode bytes at 0xf7ef9b98.
> [ T4313] RSP: 002b:000000000050f9ec EFLAGS: 00000246 ORIG_RAX: 0000000000=
000072
> [ T4313] RAX: fffffffffffffe00 RBX: 00000000000010da RCX: 000000000000000=
0
> [ T4313] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000000000=
0
> [ T4313] RBP: 0000000000000000 R08: 0000000000000000 R09: 000000000000000=
0
> [ T4313] R10: 0000000000000000 R11: 0000000000000000 R12: 000000000000000=
0
> [ T4313] R13: 0000000000000000 R14: 0000000000000000 R15: 000000000000000=
0
> [ T4313]  </TASK>
> [ T4313] ---[ end trace 0000000000000000 ]---
> [ T4313] BUG: kernel NULL pointer dereference, address: 0000000000000000
> [ T4313] #PF: supervisor write access in kernel mode
> [ T4313] #PF: error_code(0x0002) - not-present page
> [ T4313] PGD 0 P4D 0
> [ T4313] Oops: Oops: 0002 [#1] PREEMPT SMP NOPTI
> [ T4313] CPU: 6 UID: 1000 PID: 4313 Comm: rundll32.exe Tainted: G        =
W          6.11.0-rc6-bisect-00259-gf8d112a4e657 #539
> [ T4313] Tainted: [W]=3DWARN
> [ T4313] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK=
/MS-158L, BIOS E158LAMS.107 11/10/2021
> [ T4313] RIP: 0010:__rb_erase_color+0x19e/0x260
> [ T4313] Code: 48 89 ee 48 89 df 4c 89 e5 2e e8 ed 16 06 00 e9 a2 fe ff f=
f 48 89 68 10 eb e6 4c 8b 65 08 48 8d 43 01 4c 89 63 10 48 89 5d 08 <49> 89=
 04 24 48 8b 03 48 89 45 00 48 89 2b 48 83 f8 03 76 27 48 83
> [ T4313] RSP: 0018:ffffb21c0775bb78 EFLAGS: 00010246
> [ T4313] RAX: ffffa0228380ef39 RBX: ffffa0228380ef38 RCX: 00000000000000f=
b
> [ T4313] RDX: 0000000000000000 RSI: ffffa02352021d80 RDI: ffffa0228380ef3=
8
> [ T4313] RBP: ffffa0228380e678 R08: 00000000000000fc R09: 000000000000000=
1
> [ T4313] R10: 0000000000400035 R11: 0000000000000000 R12: 000000000000000=
0
> [ T4313] R13: ffffffff83c46b90 R14: ffffa02352021d80 R15: ffffb21c0775bc0=
8
> [ T4313] FS:  0000000000000000(0000) GS:ffffa0312e780000(0000) knlGS:0000=
000000000000
> [ T4313] CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
> [ T4313] CR2: 0000000000000000 CR3: 0000000202832000 CR4: 0000000000750ef=
0
> [ T4313] PKRU: 55555554
> [ T4313] Call Trace:
> [ T4313]  <TASK>
> [ T4313]  ? __die+0x51/0x92
> [ T4313]  ? page_fault_oops+0x99/0x210
> [ T4313]  ? srso_alias_return_thunk+0x5/0xfbef5
> [ T4313]  ? srso_alias_return_thunk+0x5/0xfbef5
> [ T4313]  ? vprintk_emit+0xc1/0x270
> [ T4313]  ? exc_page_fault+0x35e/0x660
> [ T4313]  ? asm_exc_page_fault+0x26/0x30
> [ T4313]  ? __pfx_vma_interval_tree_augment_rotate+0x10/0x10
> [ T4313]  ? __rb_erase_color+0x19e/0x260
> [ T4313]  ? __rb_erase_color+0x183/0x260
> [ T4313]  unlink_file_vma_batch_add+0x8a/0xc0
> [ T4313]  free_pgtables+0x124/0x250
> [ T4313]  exit_mmap+0x14d/0x2a0
> [ T4313]  mmput+0x3e/0xf0
> [ T4313]  do_exit+0x283/0x9b0
> [ T4313]  ? srso_alias_return_thunk+0x5/0xfbef5
> [ T4313]  do_group_exit+0x2b/0x80
> [ T4313]  get_signal+0x78d/0x7d0
> [ T4313]  ? srso_alias_return_thunk+0x5/0xfbef5
> [ T4313]  ? __do_wait+0x13d/0x250
> [ T4313]  arch_do_signal_or_restart+0x29/0x230
> [ T4313]  ? srso_alias_return_thunk+0x5/0xfbef5
> [ T4313]  ? kernel_wait4+0xa7/0x140
> [ T4313]  syscall_exit_to_user_mode+0x154/0x1a0
> [ T4313]  do_int80_emulation+0x94/0x140
> [ T4313]  asm_int80_emulation+0x1a/0x20
> [ T4313] RIP: 0023:0xf7ef9bc2
> [ T4313] Code: Unable to access opcode bytes at 0xf7ef9b98.
> [ T4313] RSP: 002b:000000000050f9ec EFLAGS: 00000246 ORIG_RAX: 0000000000=
000072
> [ T4313] RAX: fffffffffffffe00 RBX: 00000000000010da RCX: 000000000000000=
0
> [ T4313] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000000000=
0
> [ T4313] RBP: 0000000000000000 R08: 0000000000000000 R09: 000000000000000=
0
> [ T4313] R10: 0000000000000000 R11: 0000000000000000 R12: 000000000000000=
0
> [ T4313] R13: 0000000000000000 R14: 0000000000000000 R15: 000000000000000=
0
> [ T4313]  </TASK>
> [ T4313] Modules linked in: ccm snd_seq_dummy snd_hrtimer snd_seq_midi sn=
d_seq_midi_event snd_rawmidi snd_seq snd_seq_device rfcomm bnep nls_ascii n=
ls_cp437 vfat fat snd_ctl_led snd_hda_codec_realtek snd_hda_codec_generic s=
nd_hda_scodec_component snd_hda_codec_hdmi snd_hda_intel btusb snd_intel_ds=
pcfg btrtl snd_hda_codec btintel uvcvideo btbcm btmtk snd_acp3x_pdm_dma snd=
_soc_dmic snd_acp3x_rn videobuf2_vmalloc snd_hwdep uvc videobuf2_memops blu=
etooth snd_soc_core snd_hda_core videobuf2_v4l2 snd_pcm_oss videodev snd_mi=
xer_oss snd_pcm snd_rn_pci_acp3x videobuf2_common snd_acp_config snd_timer =
msi_wmi snd_soc_acpi ecdh_generic amd_atl ecc mc sparse_keymap edac_mce_amd=
 snd wmi_bmof ccp soundcore snd_pci_acp3x k10temp ac battery button hid_sen=
sor_prox hid_sensor_gyro_3d hid_sensor_accel_3d hid_sensor_magn_3d hid_sens=
or_als hid_sensor_trigger industrialio_triggered_buffer kfifo_buf industria=
lio hid_sensor_iio_common joydev amd_pmc evdev serio_raw mt7921e mt7921_com=
mon mt792x_lib mt76_connac_lib mt76 mac80211 libarc4
> [ T4313]  cfg80211 rfkill msr fuse nvme_fabrics efi_pstore configfs efiva=
rfs autofs4 ext4 crc32c_generic mbcache jbd2 usbhid amdgpu amdxcp i2c_algo_=
bit drm_ttm_helper ttm drm_exec gpu_sched xhci_pci hid_sensor_hub drm_subal=
loc_helper xhci_hcd nvme i2c_piix4 drm_buddy mfd_core hid_multitouch hid_ge=
neric crc32c_intel psmouse usbcore drm_display_helper i2c_hid_acpi i2c_smbu=
s amd_sfh usb_common i2c_hid nvme_core crc16 r8169 hid i2c_designware_platf=
orm i2c_designware_core
> [ T4313] CR2: 0000000000000000
> [ T4313] ---[ end trace 0000000000000000 ]---
> [ T4313] RIP: 0010:__rb_erase_color+0x19e/0x260
> [ T4313] Code: 48 89 ee 48 89 df 4c 89 e5 2e e8 ed 16 06 00 e9 a2 fe ff f=
f 48 89 68 10 eb e6 4c 8b 65 08 48 8d 43 01 4c 89 63 10 48 89 5d 08 <49> 89=
 04 24 48 8b 03 48 89 45 00 48 89 2b 48 83 f8 03 76 27 48 83
> [ T4313] RSP: 0018:ffffb21c0775bb78 EFLAGS: 00010246
> [ T4313] RAX: ffffa0228380ef39 RBX: ffffa0228380ef38 RCX: 00000000000000f=
b
> [ T4313] RDX: 0000000000000000 RSI: ffffa02352021d80 RDI: ffffa0228380ef3=
8
> [ T4313] RBP: ffffa0228380e678 R08: 00000000000000fc R09: 000000000000000=
1
> [ T4313] R10: 0000000000400035 R11: 0000000000000000 R12: 000000000000000=
0
> [ T4313] R13: ffffffff83c46b90 R14: ffffa02352021d80 R15: ffffb21c0775bc0=
8
> [ T4313] FS:  0000000000000000(0000) GS:ffffa0312e780000(0000) knlGS:0000=
000000000000
> [ T4313] CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
> [ T4313] CR2: 0000000000000000 CR3: 000000043109c000 CR4: 0000000000750ef=
0
> [ T4313] PKRU: 55555554
> [ T4313] note: rundll32.exe[4313] exited with irqs disabled
> [ T4313] Fixing recursive fault but reboot is needed!
> [ T4313] BUG: scheduling while atomic: rundll32.exe/4313/0x00000000
> [ T4313] Modules linked in: ccm snd_seq_dummy snd_hrtimer snd_seq_midi sn=
d_seq_midi_event snd_rawmidi snd_seq snd_seq_device rfcomm bnep nls_ascii n=
ls_cp437 vfat fat snd_ctl_led snd_hda_codec_realtek snd_hda_codec_generic s=
nd_hda_scodec_component snd_hda_codec_hdmi snd_hda_intel btusb snd_intel_ds=
pcfg btrtl snd_hda_codec btintel uvcvideo btbcm btmtk snd_acp3x_pdm_dma snd=
_soc_dmic snd_acp3x_rn videobuf2_vmalloc snd_hwdep uvc videobuf2_memops blu=
etooth snd_soc_core snd_hda_core videobuf2_v4l2 snd_pcm_oss videodev snd_mi=
xer_oss snd_pcm snd_rn_pci_acp3x videobuf2_common snd_acp_config snd_timer =
msi_wmi snd_soc_acpi ecdh_generic amd_atl ecc mc sparse_keymap edac_mce_amd=
 snd wmi_bmof ccp soundcore snd_pci_acp3x k10temp ac battery button hid_sen=
sor_prox hid_sensor_gyro_3d hid_sensor_accel_3d hid_sensor_magn_3d hid_sens=
or_als hid_sensor_trigger industrialio_triggered_buffer kfifo_buf industria=
lio hid_sensor_iio_common joydev amd_pmc evdev serio_raw mt7921e mt7921_com=
mon mt792x_lib mt76_connac_lib mt76 mac80211 libarc4
> [ T4313]  cfg80211 rfkill msr fuse nvme_fabrics efi_pstore configfs efiva=
rfs autofs4 ext4 crc32c_generic mbcache jbd2 usbhid amdgpu amdxcp i2c_algo_=
bit drm_ttm_helper ttm drm_exec gpu_sched xhci_pci hid_sensor_hub drm_subal=
loc_helper xhci_hcd nvme i2c_piix4 drm_buddy mfd_core hid_multitouch hid_ge=
neric crc32c_intel psmouse usbcore drm_display_helper i2c_hid_acpi i2c_smbu=
s amd_sfh usb_common i2c_hid nvme_core crc16 r8169 hid i2c_designware_platf=
orm i2c_designware_core
> [ T4313] CPU: 3 UID: 1000 PID: 4313 Comm: rundll32.exe Tainted: G      D =
W          6.11.0-rc6-bisect-00259-gf8d112a4e657 #539
> [ T4313] Tainted: [D]=3DDIE, [W]=3DWARN
> [ T4313] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK=
/MS-158L, BIOS E158LAMS.107 11/10/2021
> [ T4313] Call Trace:
> [ T4313]  <TASK>
> [ T4313]  dump_stack_lvl+0x58/0x90
> [ T4313]  __schedule_bug.cold+0x3e/0x4a
> [ T4313]  __schedule+0xed3/0x12d0
> [ T4313]  ? irq_work_queue+0x2d/0x50
> [ T4313]  ? srso_alias_return_thunk+0x5/0xfbef5
> [ T4313]  ? srso_alias_return_thunk+0x5/0xfbef5
> [ T4313]  ? vprintk_emit+0xc1/0x270
> [ T4313]  ? srso_alias_return_thunk+0x5/0xfbef5
> [ T4313]  ? _printk+0x57/0x72
> [ T4313]  do_task_dead+0x3d/0x40
> [ T4313]  make_task_dead.cold+0xcc/0xd8
> [ T4313]  rewind_stack_and_make_dead+0x16/0x20
> [ T4313] RIP: 0023:0xf7ef9bc2
> [ T4313] Code: Unable to access opcode bytes at 0xf7ef9b98.
> [ T4313] RSP: 002b:000000000050f9ec EFLAGS: 00000246 ORIG_RAX: 0000000000=
000072
> [ T4313] RAX: fffffffffffffe00 RBX: 00000000000010da RCX: 000000000000000=
0
> [ T4313] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000000000000=
0
> [ T4313] RBP: 0000000000000000 R08: 0000000000000000 R09: 000000000000000=
0
> [ T4313] R10: 0000000000000000 R11: 0000000000000000 R12: 000000000000000=
0
> [ T4313] R13: 0000000000000000 R14: 0000000000000000 R15: 000000000000000=
0
> [ T4313]  </TASK>
>
> After that sometimes a kernel panic happen sometimes trying to reboot is =
still
> possible but even then the reboot fails due to the mentioned processes be=
ing
> unkillable.
>

Yeah sorry about this, but thanks for the report, will try to get this
resolved as soon as possible!

> Bert Karwatzki
>
>

Cheers, Lorenzo

