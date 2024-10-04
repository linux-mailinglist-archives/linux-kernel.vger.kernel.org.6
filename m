Return-Path: <linux-kernel+bounces-350506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1AC990629
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 16:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D34E5280CE0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 14:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 814D2217906;
	Fri,  4 Oct 2024 14:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BhAJAjf7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kBCEioWu"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF8B217330
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 14:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728052366; cv=fail; b=X+KVZDVISt0UyWeuZWHXYDA/+29W3ZF0OTgkRvgv3YUD65J94OhUgzFwaqj9ZuHmVHUOv2HbjuORYfuyQBQkzswCV4lYMf8KgY4Pgjj9Qlq181v1GW0NDoMByybUCqxj6jzE4idTaWJjAYyIfX0jzof9Cmmfs7I/am1g8skQr5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728052366; c=relaxed/simple;
	bh=WrYWpxDOUk7iNW+8S2RSS7L6IApXHMGGCo8BolREpBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Tr/35Bx+8Bb+fMCUNYH9qFgltQ4mLpnueqeBX1cg6PKcVge+NwTPRVJ3t/QU683FHm2O9k43cMtTNPtfIO+9AiKOKMiIvMDssPzB8gV5wYas+/T+u1sVQV1m2yKyrIVhDyySovTy/yJgpliPxW1nHGJStEPe+4ZpLB+vyqE7dOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BhAJAjf7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kBCEioWu; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 494E02PG031804;
	Fri, 4 Oct 2024 14:32:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=ZwqVkrBuQCS55xf
	pNgiuUWno0u3hEV8tzX8K8TKcwYk=; b=BhAJAjf716FO+X1b/nu854Mxc6ucPB3
	NKaTyFf8gModQuN9cN1YapZAogo250af7eFAGKqkSVyq7gj4BlECXjN2v8fhHXiy
	zmeSiBRxXupb+dQNXEkXnKs6J6AAeoCTPd8eyfeO/Si6DMfJlZbdVmdgRqhcbxAi
	8Cwx8YH1F8Htzlw8HD7fILQS4d8sh5XMMU2KYK+UOX/71sepUy6zKVLSvDV4YSCe
	4aLT0u4aNLBAg9A65YKFKdYsuqTXrfXAUZZqgubcEt7sfJ+xiER6o5UlNDpPxtD8
	e2oux8eauM2Y4QlxWcf5j4Ofsk2PUcdxWJaDvvc0cTSKaFq+A7CWyvw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42206m1q0s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Oct 2024 14:32:39 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 494DWqNQ013254;
	Fri, 4 Oct 2024 14:32:37 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2047.outbound.protection.outlook.com [104.47.55.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 422057mqc2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Oct 2024 14:32:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QFC7+iuVYkvMoraU+I95WoZr6FUeaUrOuiNUMvAV/5KtG4FRnHE6nWOkbmmJcqAwo4snexGaDgUwV4bUzVj5bsXHXTbm+4XK81ksvK33f3YBLRyHQBv12Hh0Bq/qIDE6Jvuzpipz8jy3M2QZ8LVTKHUvRt7nOGC3U4+fYMfueBprhHpCy1uXHKROt3tu3RfDm5OoySFTuVbHQpvwwE/Cjhg79Y1T1V2p0UuDiD3/XzawcvMpyvizUGYaQkNZuV54rYkoZ34diQeadmJuJxHBAtxadj96+Q+BUzKx539fSvOIndKUhpv6V4P4NwNMQBu/Q2kaJncGUzRPNB0iBBmv0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZwqVkrBuQCS55xfpNgiuUWno0u3hEV8tzX8K8TKcwYk=;
 b=T/RXKvMoni5KbH5hOkU0XvmuzVDhqO1RMRaOmY5h0174vGW4sB40Mab40pnXo0Xb8fZoiUhFEvX7gWwVR0A48HXVNUBJQrRswGUiwvwmhaZI3nWmBqDokqQR8ZDWrkTkS1roLt/iMQwSx19JoMu46ZO3cQpSt1nghVQWlegxKuuBGNW84TPIIbkfzftuRzpV5hDN23buBfVwl+flz1N353B3Acw9vdJNHou7AD1dBSRLkEnfjY6DixEVDEklEQHHLwIhYIPwrnaAxDNhN3zZXf21N5oGqVREUEbxnFADE0waHxyKpumLzrhHLr69d1yvcxctr1/qJU1QgXvelZxsBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZwqVkrBuQCS55xfpNgiuUWno0u3hEV8tzX8K8TKcwYk=;
 b=kBCEioWu1bAit7fKnD9gfnmWRcF/MkOKuLVy+AqKNpbtBcuj/wtiTjxrNi35PBVTDxneQhUAI9SGs5K0xCM/UUzNB4N6eUO8plySA/eZxlEnNYh5O3+qo6Lt2dFZPJCfcZgGFHhstJGduYE/Vd56THnutNslVDA/mmu7dDaTn8Q=
Received: from PH0PR10MB5611.namprd10.prod.outlook.com (2603:10b6:510:f9::16)
 by BL3PR10MB6090.namprd10.prod.outlook.com (2603:10b6:208:3b6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Fri, 4 Oct
 2024 14:32:31 +0000
Received: from PH0PR10MB5611.namprd10.prod.outlook.com
 ([fe80::d513:a871:bbf9:fce2]) by PH0PR10MB5611.namprd10.prod.outlook.com
 ([fe80::d513:a871:bbf9:fce2%7]) with mapi id 15.20.8026.019; Fri, 4 Oct 2024
 14:32:31 +0000
Date: Fri, 4 Oct 2024 15:32:28 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Bert Karwatzki <spasswolf@web.de>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 14/21] mm/mmap: Avoid zeroing vma tree in mmap_region()
Message-ID: <76a7c74b-9240-40b5-a5ac-9b128c7007c5@lucifer.local>
References: <20241004093546.3232-1-spasswolf@web.de>
 <d07c85a3-d1b6-48e7-9e98-bb533bb73417@lucifer.local>
 <a34fe509-f1d0-482e-9aa9-8dc3fa0743f3@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a34fe509-f1d0-482e-9aa9-8dc3fa0743f3@lucifer.local>
X-ClientProxiedBy: LO0P265CA0013.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::8) To PH0PR10MB5611.namprd10.prod.outlook.com
 (2603:10b6:510:f9::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5611:EE_|BL3PR10MB6090:EE_
X-MS-Office365-Filtering-Correlation-Id: 2072b28c-8d5a-421c-7850-08dce48160e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fEDc+ssEPXfpeNWQ+rLJAbyv4Kt0LsNKrucR/L4DB3gSIjHkXtKjjI9PUqd4?=
 =?us-ascii?Q?fucAj32CFb70bggKNaaIIohNeP3o/hHBl4bgEbETSVaKH9wnlDv6qfVFb7Sr?=
 =?us-ascii?Q?7RRNgPW2QbSW1QkRIokGoUASmxVS7IJurNkYLuRkwVNCxjkt50jpyrjLv/JM?=
 =?us-ascii?Q?Ppy2OdgUvOj9S/5+h3bbERSnUUMJ4tVp+Ra4hSgY/NIJ0JeppmIWm7/bLnkS?=
 =?us-ascii?Q?st63Lil/y6uyJX6t5rSFhbqMUpY5UlM4Z7vDDqxmyNbabEdbX3+PMJT/b6Eh?=
 =?us-ascii?Q?Hqk3LoQTtLoX0heD1q1H5UsM2ruS6fqFQ1ojECTF6bZrMsan5+UCpg+Tj8zq?=
 =?us-ascii?Q?u9e5uWf2/QrnmjfMGPSvF7AE1/JfTjmppqmUmwDXl4xAlk3w6hYYcwhfEYWA?=
 =?us-ascii?Q?moVf3AkY2O8ciK3nCak59o7Tcfm0DSbeoX307bOD+iTCS6VoEAWeuR2qKznj?=
 =?us-ascii?Q?S9mh2xngZlWYB9mARDVKxQrN4+hAUyfr1tDQPMuVRCE43WkGcYxzKPPQK0FZ?=
 =?us-ascii?Q?dB4sl5h0Kd2bCnpihl484UYw9q8YJnA6+fCAqg+WcGln1xTrLCFop+gaebB2?=
 =?us-ascii?Q?DzKr4VUoUz2ilFF8+zDa5XY31iR/2U4XcJ6HARyniNO9TcY92jX6d8IXGbTV?=
 =?us-ascii?Q?eUjjptsm3uaJuTQSytJ4TAUlQAOY1ipUWfbiMlYwlma9FHwzzJwG50xIkolP?=
 =?us-ascii?Q?tsI2K1V9v86lWvJGia2vjgUUJBu0CkIJZM/lduq2tH9G8+s5UNwp981Nz+Rv?=
 =?us-ascii?Q?Hz27sc3Hx7ETKfRDYWjAImc7hLNj5p4Rec9EkczKtLiEUjxr95EE58j4hzaM?=
 =?us-ascii?Q?LX9l28KCs12Jc4LqdwqKOQhQN+V/Co456pVRWLpf0YyQFUBHcP9JYRZ7nAEV?=
 =?us-ascii?Q?thZ3TDMEeAn/zHnCNWOMy+1EhEg9S4FIO0BqzpboO9zM8AuY/HmMB4n/XzDG?=
 =?us-ascii?Q?ZqDuclCnJX76iatru5Z/Lu1oSD8dQRViC6Tovh7HjBBKrNYrSDEFFagZ0WGS?=
 =?us-ascii?Q?ysAdeSEKJqhOBn9Wiv2tdC9WnR86sYwVoUznquDy0jqG2hN+MXMl9iimk1DA?=
 =?us-ascii?Q?gUZ5oeMR53EGMFCfXJYi2VwdV3h4+N2Zyqgzk1Djd/8Ie/GLehGX3dhRLXOM?=
 =?us-ascii?Q?HqbQuG9k+oxUjWmJnNXnlPhacJ+oqpn3gkifQrHPBHR+VcRevPuoa+djYKqt?=
 =?us-ascii?Q?0dYwQBdt6m1KMhdIscorxjPQ84DLplZX0ntIJ3tJHQY6Qxofw5G7PVZmR4iV?=
 =?us-ascii?Q?/sKr6bq+hm9uBrYPYyKiTB6Uh5XtEmar5iltRB4YiQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5611.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cim1dPy+CPYAj+6KREUmWhFWVaKSWzi0/2RMjqZk7QJUUN2hiASLH2gUY86Z?=
 =?us-ascii?Q?vOs/CwmiIYAC3gdRBrYsALGgOnBjkHJpYHoPahTPzbzsOi53yty8+HckBbAX?=
 =?us-ascii?Q?ag8Y4bRRZ6WvdNkrvctJmxneoH4sRJ54h+yS1ZwXgVDPx3K8wxkFpme0tpD4?=
 =?us-ascii?Q?0qIu4LHrLyeSgZehklQw2++MraayvD2IKCo43QT7OgD/cspzPivyWfOsVAlA?=
 =?us-ascii?Q?3x0HPYbLxAdhoCnHw1spUfVWjCd47MRMEdKNGNxg0qID+RPqkRpJ4pN9cbqb?=
 =?us-ascii?Q?dEpt5FRE7wm7MPCy7BAFkV2QiKhkG/a+5yIi05oxVRgTufHYvJ7J4NtWndw0?=
 =?us-ascii?Q?9zPjrpRJBwv3ffNLtCWJODFDxM36xqaaYXIuAmAMB+vR10hxdgfpzQUFeMTp?=
 =?us-ascii?Q?QcLhFt0eRJOpoGywJzy2G1OwEClc5eJ6/RUciRLmSKCTwFfBP/XpbTkOI1O8?=
 =?us-ascii?Q?TZU6frgdWgD5+Zzu2CUBqeo8QEC7NHW0MMSCfq33wql0GZuJKfXBsupU2VCI?=
 =?us-ascii?Q?w+W3iJJEyB8vOmPKsksHfc+P7VqsUVm9MB/OR+1Tgn2PoNDf/5AXvB0qBEsN?=
 =?us-ascii?Q?DA3jicNEffoKs+83Nvgzm4TMVXbokylbyhjB6yozyWXVTsqeKl9yOArmjGV7?=
 =?us-ascii?Q?b6MUZbeIGnMsM4RNohdf9kgqDqPIDaxSWaGFS+FFoQMfTtKGZ7nNNzOIivOm?=
 =?us-ascii?Q?Cb4g9SfY+H4mTDnHYouW4p+04IiHeqnqlaaqjiSeIdSC5P1xIqT+wkaj+oT+?=
 =?us-ascii?Q?iAXzqi2IhIzGACOluk4Q99qO7ViY7JepZBl5y8cAE/bmD8N2G65OWreWkrBy?=
 =?us-ascii?Q?sTyECFJfogyXVihtBJdg2Hv3jsGYQ80vWAhzwTZ+x6MCUYiIjSRMhcow58qd?=
 =?us-ascii?Q?S6WKC6AGFNtH0pHx6VAUi5vmCclgNYszfgcXApVRnRn59eamQGA1pYpLgrPu?=
 =?us-ascii?Q?1NOR6KewHEx1bJnAIl2rTl/SVMDHVqWsQdoFZ5kmT60Mrz7A0a9G1ruxTWji?=
 =?us-ascii?Q?fwupBj5iZLMxWML1NUKhhtBvDEF7OKeJjg2CjBoV1X0YdafTdHRMxMAvHxEm?=
 =?us-ascii?Q?t04wlVL+KFUQ2z2h+Gl9otfMOzCB/u+DvLKbQb6v5LA7I7LhFrrUAGmtznNS?=
 =?us-ascii?Q?nEPZrC6WE3oXgcjCLe3vx7I6BjrtD45cfJmCCwWO609EFdflSquzAjgVyNne?=
 =?us-ascii?Q?qzjQOiCT7JYLX02CfHSh7hoLCHRWl2mUsQX67ZNMd3YLxK27QIbcbeNldnpR?=
 =?us-ascii?Q?TCVBqZg/DGnXnX9x5Hy4QJh5gaUuwz3MRzd1pvt7Y9VZwbQSAxKmV9jwIRLD?=
 =?us-ascii?Q?LZS0/ePze437qGE0qA4+DX7v6hrjJhqN6/FuGwsYUsHYRW7mlc9nQ/4JaUW0?=
 =?us-ascii?Q?JNzQpXv2eNY81PtphaJvXvrMq/NWE2Qpsd+wPkVQgpx8Ej7qAhxpA7HK1HnN?=
 =?us-ascii?Q?EMPfPGLRxXuwRQfynGDRtJH9JJGvb8zgVHSKRtAT1yAXjscwXBLvOkTe+3tG?=
 =?us-ascii?Q?E6atQo/eNCvvq2S89kePe6qZXvUusn1thAXfsxNnxfBI6xinWHpwOAQEDfAM?=
 =?us-ascii?Q?U1rtBXIvsWwFi+Fjd8qq0e6uE3KZsbaZcOb5+UV4V9f7Pjz6IOH7boVx+9aZ?=
 =?us-ascii?Q?nQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	a2mtS7Zgk0qHsZLjvEtsM9BfcC3B0oCUK8Ij52JQpEGASeAv0NGVIElEH4DqUi6EUYIyt/zK2Btq96eRin4hfS12cDV8NBn2lDyd373pIwYMGd/m+iTsizcTPnW/EmbLjWiVSWsye4IkHmaTAFNOpob1qL9Qdfb5L2vyR3/1QBkraf738y51GcsxDaTSxZ5oDFe6W0cQfwRqoCesH6Bsxqo0/C3K3ZA3RVQLK00uYZQF1/VRAB3bqeWzxFROHF8/YbLsqKRwreg6WV7EzVqWzChDMwMuunqZunCQYBzX2VovLe5NuajVZNNOXY0MbuIx5PRGeZyhoCxazuTbhbkQWUZ7kj+5Fgb44f44/80y4dnTkhpahLmJcQxAJFFkvHF47xbH2bsYhcH4jwKJdbtod5xxq1JsCdm5FErbOhNxremDFGZoPAS1U8Coc+LlMQlJJArrsGBxzyb2ispbP41cXvZYvKML7f1sfyqAixD6FNeTQ6J4VuvcUp9Bq05TAvoVfPG+x5QkNYkgz49t3A0ghxhowOx6Bpx2Fi9rojcSYKnim6cJ5aaBGHNGhKV9+VzmhowionRONfBmFTIvy6jOTOR3Zeapw4xeNdz4J7qcs4A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2072b28c-8d5a-421c-7850-08dce48160e1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5611.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 14:32:30.9509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gACdIero55lVYlUVRjeQcO7e2g2eCdYVDzFXSIeDmbvPSV8P7qx4/mvGI7sCGv6uNhx/NO0NjNLUI5EaQRAq+yJ39Wzgu8atDwyEQ6Hdu5M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6090
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-04_10,2024-10-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 suspectscore=0
 spamscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410040100
X-Proofpoint-GUID: uoBMBJtgayYXi8Gx1kE_Yq1T0Y7FvaMW
X-Proofpoint-ORIG-GUID: uoBMBJtgayYXi8Gx1kE_Yq1T0Y7FvaMW

On Fri, Oct 04, 2024 at 03:26:26PM +0100, Lorenzo Stoakes wrote:
> On Fri, Oct 04, 2024 at 03:23:37PM +0100, Lorenzo Stoakes wrote:
> > On Fri, Oct 04, 2024 at 11:35:44AM +0200, Bert Karwatzki wrote:
> > > Here's the log procduced by this kernel:
> > >
> > > c9e7f76815d3 (HEAD -> maple_tree_debug_4) hack: set of info stuff v5
> > > 7e3bb072761a mm: correct error handling in mmap_region()
> > > 77df9e4bb222 (tag: next-20241001, origin/master, origin/HEAD, master) Add linux-next specific files for 20241001
> > >
> > > Again it took two attempts to trigger the bug.
> > >
> > > Bert Karwatzki
> > >
> >

[snip]

OK please try the _actual_ fix, shown below.

It may be a little unstable as I am still working on this but it'd be good
to confirm it fixes the issue for you!

Thanks, Lorenzo

----8<----
From b9a8b45e62ad2749dd4066a828bd2efc109e87e5 Mon Sep 17 00:00:00 2001
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Date: Fri, 4 Oct 2024 15:18:58 +0100
Subject: [PATCH] fix v2

---
 lib/maple_tree.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 37abf0fe380b..2ce24349f53a 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -3527,6 +3527,7 @@ static bool mas_wr_walk(struct ma_wr_state *wr_mas)
 	return true;
 }

+// Return whether the node actually contains entries at or greater than wr_mas->mas->index.
 static bool mas_wr_walk_index(struct ma_wr_state *wr_mas)
 {
 	struct ma_state *mas = wr_mas->mas;
@@ -3536,7 +3537,8 @@ static bool mas_wr_walk_index(struct ma_wr_state *wr_mas)
 		wr_mas->content = mas_slot_locked(mas, wr_mas->slots,
 						  mas->offset);
 		if (ma_is_leaf(wr_mas->type))
-			return true;
+			return mas->index <= wr_mas->pivots[mas->offset];
+
 		mas_wr_walk_traverse(wr_mas);

 	}
@@ -3696,6 +3698,7 @@ static noinline void mas_wr_spanning_store(struct ma_wr_state *wr_mas)
 	struct maple_big_node b_node;
 	struct ma_state *mas;
 	unsigned char height;
+	bool r_populated;

 	/* Left and Right side of spanning store */
 	MA_STATE(l_mas, NULL, 0, 0);
@@ -3737,7 +3740,7 @@ static noinline void mas_wr_spanning_store(struct ma_wr_state *wr_mas)
 		r_mas.last++;

 	r_mas.index = r_mas.last;
-	mas_wr_walk_index(&r_wr_mas);
+	r_populated = mas_wr_walk_index(&r_wr_mas);
 	r_mas.last = r_mas.index = mas->last;

 	/* Set up left side. */
@@ -3759,9 +3762,12 @@ static noinline void mas_wr_spanning_store(struct ma_wr_state *wr_mas)

 	memset(&b_node, 0, sizeof(struct maple_big_node));
 	/* Copy l_mas and store the value in b_node. */
+
 	mas_store_b_node(&l_wr_mas, &b_node, l_mas.end);
+
 	/* Copy r_mas into b_node. */
-	if (r_mas.offset <= r_mas.end)
+
+	if (r_populated && r_mas.offset <= r_mas.end)
 		mas_mab_cp(&r_mas, r_mas.offset, r_mas.end,
 			   &b_node, b_node.b_end + 1);
 	else
--
2.46.2

