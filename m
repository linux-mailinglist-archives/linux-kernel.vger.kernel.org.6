Return-Path: <linux-kernel+bounces-345619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 703C398B835
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 11:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAC58280FA5
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 09:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C1819D88D;
	Tue,  1 Oct 2024 09:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FyE6tx5f";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="abWAvJd9"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420EFB67D
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 09:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727774422; cv=fail; b=izjU8IeBetqW5qC1U3uecxTs7N89cOymaE47LyhbcACEor9pSsO2z85XkEfNiUnPVvnfLG+HKO4OInMTV4clbuWK7dIBvcYN6wXbQGjCy6AGeCBk4dF0FKiViQc2VNy9PrrIJabnVerAntqhFukj+VlUN9C2wK10j+irl8rfU/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727774422; c=relaxed/simple;
	bh=iRLlBINDzcw9ReSfUa7wyFexeTFlgnC/LLvPOsAjEj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HnkHkJi5wT4rN1z+keV4IpgKJ8DjLGaOuXPN+4tjQOMy9B1NtrFT1k1ZcCUEsWwhA5siIoqRs9XbbdN8OrS+jc8jdDEqSiSHgDmR8HbUo8BdZzPsgFw54/e2izhkr8R5ontuW9yeAR3RhEUhLbwOXAeRvdYP73TK9Pe4wl3knAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FyE6tx5f; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=abWAvJd9; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4911tak2024900;
	Tue, 1 Oct 2024 09:20:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=iRLlBINDzcw9ReS
	fUa7wyFexeTFlgnC/LLvPOsAjEj0=; b=FyE6tx5fUDCgFyV0PrFdukvUDcv/p2x
	/9gXMKc3gTmV/uqpIjgc475XRKiqKrMxtvjDxTk9Ia4Y7zsZKyhBBJV4DFOs+OgB
	+QLnRXC8OS6rE4ch6/KGUdlBDqxT4EoqcAOcdzoYpWANPgif6sqAH0fTEa0KoYcp
	ZxB17v/rj74Yhet2fdGJhXOzqqzUSp0qzIa0ShqjEkNo9Sg/m5LKh+gz5Fasizmo
	IRLV/atkAJ5XpNznSGLYpWx3+HS3Hv5BfwO1XhCvt0QeuJOkuE26Ve9+6uTcJjgf
	SJarGcby/0moFK2mvXcAVjpYy8yp8vYSnjisnWgJ0LXkfTLo4Op7tTQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x9p9np62-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Oct 2024 09:20:14 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49180hFx028438;
	Tue, 1 Oct 2024 09:20:13 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41x887gf8r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Oct 2024 09:20:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I+3MNcrPMXPbmiQIezclNDPaH2DC10DDNujRq4dDakK607v9kpBE+euvhA9ZkXblbxgfS756W7sxnHLuumZwYOAeT1HKdbzGOCoHhyFegZDMDLfnV/Hy0L/0tCEOVPpJVybVCBhBmd2CZsjN0MKfXIZPxo5AbU+G6eMEV21GIWl5dBkeXIxqa8UG+DNE0sKOyGpQuCR65892v86JOW/+/HK7ZZv7AJiHu97R29bVqcMMNADeFkfxiUMeY2AOIiV19m7dp/nKR2ozTsdrgD+gikAlrRmMmB5GsKkmfvDt8goY2oyJ49Ixd//4mxpl9ufxYCpn4rQDz/FdsYQDY+TWGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iRLlBINDzcw9ReSfUa7wyFexeTFlgnC/LLvPOsAjEj0=;
 b=hjBtXWq9iG4xpH6n9fu74WOKkMPQvBMxB4oArK3fvrDaBbtWhUkiu63F7tb5EdDgBsPMLeQvoXMls6SUd/EICuOHd1cqH7n6AuxlBt4VbwlgcgIoMn30SYgToWaZQwRg8yYh/LTs14tO+L0Ce0v/QwPKTDJcjSiL0Cd2rwTQyz4ptAhvkByxc6S8qdXeo7ulanF355zFAm0CZqLggSJ/9nF68aNMXLGRl+hpKpj7qzE7aLvK4TiohoysAUMtckrof/1+33AJ1PIvdG/sBXhR1TLjLC91X0DT0r+cz4B9dZhJWCXtGcjBE75RwaXjKfMX/PjwXycdh7jvISDqNYwB+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iRLlBINDzcw9ReSfUa7wyFexeTFlgnC/LLvPOsAjEj0=;
 b=abWAvJd9skoUNqa7VNuIJaEZfK3AxLa7+4Dezj7ZXryqV+qFjObPxyORZ6AmRmY4pvlULMygls/fOfr6lctSlZsPbvmId7Vm7/i5+ThvgMh84ZPW1k139tfmh29HeD5utmE2yqFkkpq4qEV3N/MymSJhiRr5KYfgahlWxOS3VmU=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by CH3PR10MB7187.namprd10.prod.outlook.com (2603:10b6:610:120::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Tue, 1 Oct
 2024 09:20:05 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8026.014; Tue, 1 Oct 2024
 09:20:05 +0000
Date: Tue, 1 Oct 2024 10:20:02 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Bert Karwatzki <spasswolf@web.de>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 14/21] mm/mmap: Avoid zeroing vma tree in mmap_region()
Message-ID: <cb24ddf8-2299-4b65-af04-e8a1ecc180e2@lucifer.local>
References: <20241001023402.3374-1-spasswolf@web.de>
 <5ec8665e-2f51-4b06-b68a-c878a969fb06@lucifer.local>
 <cdbf216338d40b0aa768f93b0fe5aff1994ebd9c.camel@web.de>
 <2f1a5621-1c3b-4c2e-97c4-86e36bc47788@lucifer.local>
 <9a97af91ba1925629d5c7fa1f1aec34f92123a15.camel@web.de>
 <fdaa29c2-e1de-4f77-a23e-8fa7523919b2@lucifer.local>
 <32226c4d16d2a17d8dbdbbd007d583a2a6a2663c.camel@web.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32226c4d16d2a17d8dbdbbd007d583a2a6a2663c.camel@web.de>
X-ClientProxiedBy: LO2P265CA0515.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::22) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|CH3PR10MB7187:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d22532c-7ef2-43ad-fc98-08dce1fa3c72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0nnPOl19UYuaFbHLLp0RS1PIGaccGDaEC42/V5jGjZiUzWbgykeGWzBJy0mx?=
 =?us-ascii?Q?YDnPNZ6Y1v/UFuDL3bdQzF8R6hIWi4b3Z8jY0e4CkWGboGhVBavmuk/KPqjv?=
 =?us-ascii?Q?7pD1G8geYg7tTzb6wV5VK5sGWWSbBDTiwA6iY+eEnOb9LpBN+uI34lIvWrzu?=
 =?us-ascii?Q?wz5IFbr3OngNY9eeveSZRoFi8TcCo9c2hwzHKIZPZikL8UnqX0E4gvrE/azT?=
 =?us-ascii?Q?f9iVXV6HWaUSnf2SfFn7sX3BW37SfrCRT6LKdkr347iRhb3lS0Hxz+uuaIl0?=
 =?us-ascii?Q?2JcTC+74O1R2milAix3OfZbiPVXYcTFbll1j50Uncingr3BqB91ReX5ETMAm?=
 =?us-ascii?Q?Mf0tIn1BWouxwiHLAshwtygXM37moGsXCypdjsDku32uvuAcNvp/OF6hPcwb?=
 =?us-ascii?Q?Nkas6LAxXDI5hPPFsWaaXeXgQa2PRrI0K5j2CX9/u+q0KR71BFuBysjNy3Bc?=
 =?us-ascii?Q?bgmw4WxKt8ifxFdxPaWgrN5SZockiKez4KOmyGasznuHfG6c2IC1TM9uSNmy?=
 =?us-ascii?Q?WmbtSOYXCExBy5Swy8Wr7HZAwIHmkN9seq/eX6gJdgx2AZVOmQoZ8QGfIFDk?=
 =?us-ascii?Q?aqxpsY/8CzFFjTe4Y5aybEbndckEHeyuR/Fe2fU4Nw4cwIJTuw8uEkC89arq?=
 =?us-ascii?Q?lZuHY2Uef1SDC+jnsYql1KArEnms7BAnlSg5PYAsrV4gCEFqLhLtXfdfgEQy?=
 =?us-ascii?Q?v9DH5knfTS2XWKWlly7329VtKEdKp3Pz1i6Q8KQgcZsvDiN2Mia0OLcdog0c?=
 =?us-ascii?Q?e3qTWX7jMgjiDccTgWPqTD2kVr1LtxoeTBy7NJOiNdSkb91sJD1zWRPS/4m3?=
 =?us-ascii?Q?2QsEUP+0H5Eh339VKsEegYY4Yk60245otytrocuK2TD9GaSOEk7ixqeh8Ory?=
 =?us-ascii?Q?wJHn0z8GYcm/t5Ue6lR0E5CIaPhaiQJR5CGGWzWnxA1DQ0RucVpo5XcdrRSm?=
 =?us-ascii?Q?ATf/piMcxO1x3dk7v6yfLaQvfBf3lHmk7DdT7MBhaXLU9SmSRlMFiz7odQnv?=
 =?us-ascii?Q?Qd+QQ308FJlhOog8zgnbjaQmZ9B9kfXBuEnDFER9e1/EviN08IYZ4SeVfJ+l?=
 =?us-ascii?Q?kXhFS7i2kbeC21l7IsRGu4TUmD6NtOgbB0Gn+4MhyJpgKPyEtnBKSZV8gxUG?=
 =?us-ascii?Q?UJGaYgfOgiD+dml4356yA+UiEFGWKFfbRpLJ6RAaL24YhGhhcny+hMIMvoeQ?=
 =?us-ascii?Q?O2v0JHkxfiS33DM1exMG4dr1bS9dtDhCdl9VLUlZvwjtah9IMaN0AHN27kvw?=
 =?us-ascii?Q?vQtqcfCrn0c9NvANgwcmf6leNr8tY1+BwMCojl5CQw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RWVHEq9b2Y1zzb5folwoh66qusoRerAfGfy1hah37kWaNw2JKXcBFvni5MdE?=
 =?us-ascii?Q?r3JadMiGyiY7xrzyYHoZdyxKpOYHzZPHTcMMHIqfZhPuCP6fbkHPOF2+z49+?=
 =?us-ascii?Q?pw3/goxma7mSGs4+txXvqDNSgjIYDB1ff8pDED+jkbxFH+GtN6/mXmDVDqlb?=
 =?us-ascii?Q?dwgnkPcAUBY1xla3sWdS1SELorMZAjxQbZVDjaB4tXRa9MeJrsgN64LQYzPM?=
 =?us-ascii?Q?VaHWzuDnLk3wWXsZgPnsnOEhu0+Kr4UqFnj6+HZy02j0Ix4Soo8vq8aOwax8?=
 =?us-ascii?Q?kfACTXbKLIjA/2zD/F4nZ/35BH4Xeg4K4Wo/XqZMeoRh6ECO57SvO56Zebe4?=
 =?us-ascii?Q?H/GRfncCFukoZPW6Vo5EzXKh9GIRNt2Plh7P0zi1C3W52aknzWnxgAyfMFMT?=
 =?us-ascii?Q?kAIAWzdPg3u9IIf/KzC6SUuXCSFka2uC48tQwFSTxlTCL5lYzfiHDDLJXXxX?=
 =?us-ascii?Q?Xjbne6zeeLUMX7oP63/gFVl3LNKVKDhjEtEnAhrFyEKBox1ZF0GJ2wKIcCCK?=
 =?us-ascii?Q?izOUfUPEVZwX570dVz8BPKtxN+oyANySKBr3IySNaSY5dVZ/ZPPGo7haXyvd?=
 =?us-ascii?Q?VY1yAUKpHyZDYwBRIov7Hg7P5qYYDk9sV/FuDnmssXOssoRDxBC7yuTSA038?=
 =?us-ascii?Q?QqsZmZy0lY+O9Og8QYI1bkWpTTY5yBV0MDDZwygLwx6OgfOFb0M9Uh/93L7l?=
 =?us-ascii?Q?ArfkiWuv7x/EfAcY8lFym3ybYDDaT2vW0AuNoIBaCaGP1SF02zLhTeQ9s0Hu?=
 =?us-ascii?Q?KVheK4apciDf7FC3RRVD93Nqhs/isJvxh/Xl4aVvrjuivwDYNiXg6JOKrzSI?=
 =?us-ascii?Q?1D26tY9zJeUDXZtzxQU80jGpPX29uRCb4B4zxhY6I6uUkF4Xhgh94b+lzzU0?=
 =?us-ascii?Q?GyzC/f2HWdLRxF9d9QZ1IGV44cjko1ZNySQu2WEtkvGv/jh4gti+wxuJmqu9?=
 =?us-ascii?Q?0OJYD5xYXcMbWa5AdC2BLGue8aVR2PIDLGtS3G8cwudJan7LE+iW0M/lMpLR?=
 =?us-ascii?Q?JOoicmIFbS3/TkzAaKNbFmlCIyDOaXvY66rIMzCmFr1xDoS+DUUQOLMQqvSU?=
 =?us-ascii?Q?mpUNbIhxI+9TRZYbsZN9U1Gayy6tuyUHKRRhc7APTmKmge2p327OoJbYLhB4?=
 =?us-ascii?Q?ia+VzaOM+hlvZ/o40Mq8i2sgieNpt9cESTuepr+t4znDF+BDXEJ+P7B9wCkc?=
 =?us-ascii?Q?7pytGCaWJpNAWwDxoFLjcOmaNF4bb3xn4iDKxHbNs2NkS0wVEEZDXJKkifF1?=
 =?us-ascii?Q?EhI7e9V3y5ABy9payO3aYcbGwz1kjzTLlu7CqGyglRJBPOLx9DmeZO34b3A7?=
 =?us-ascii?Q?Azs6phWCDOvD3NhWLQqdTlBcPEuCIKcbuEYlxOLiazbErd8Cm8WJVOHoqhfv?=
 =?us-ascii?Q?WwPzmX9telzYjOQdQX0Iz7cY4rXdhnACD0VUUgqhQZIGP0Cy896ZaeX0TWiI?=
 =?us-ascii?Q?uZfHzrY+raURuLmUKVyaweFoTBV7/5Ue3C+VWKnBC5B2oYIL32Cw5jbTKdvH?=
 =?us-ascii?Q?hUxJdjsT9z4pX+Fs+dmuFOfH9n3MzG0Pg/d3SF1mOs/ZGQ1vkSw0HwkSFK3y?=
 =?us-ascii?Q?WT9cfbVSQ7FfzpvVjenHoKz75e/Vdrf5E80Zo5wkg9qC24piwE5K6RQJNYIP?=
 =?us-ascii?Q?rTyXUOyYVr4Grdco7Y4wuYRc77u6CyoePfie6/Vphzr3EgP/KxscnONh6Lps?=
 =?us-ascii?Q?O+TsMQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	yFCTXlE/Wf1i43moi4AK9tUR7fmfIVbIyIyRj7JySOh5jbzNPcExHJab2lpbzO3LnsrMi5MaMNAgrpYt8iQFZuYM584zNhPbS+3PbNrJ7246Hba6hamHJwN4ocWFsQIzEB2owpdAPeTRFQTuvWPrA1+JjrgID+mP+IzVHYipUhuCWQGGRvTE3tIwZC8u+9Zp5Mv7dzvAFBk/aVxgHIaLfHIN5DmuYsaTi1YNiVSyeNdu9qaTxe6JWTatgNLCEywxdYHsll88tCsVn+KZgPBb2Mw7X8Q4GU+p7d5Kj46SabA4WDp45B2DvyXUgr5uHxH6EtZRsapPEdeDRIpHRr9qbKhMMxCwZG1BpCUL/Yg9D2fV8VTQV2tovhv7G5QhlGQn2A9UPBCGid5Vd4H/Nxiz3bqU+P8l4rD8XM0HEyBGLNo1ku3RDcKWyhrwvCeXD98oQv/Hb51T4+0EdalqJGS+xcPUdOy9w3JAikYfP/9y44Cg/BmnvPQLDFxvT2/I/mPQ/U8K6WCS6sudYhynq1aP9BGcCCr8qXaKae0tfCetLaX6+hS5pKi5S+t1Fll7U3qJeozzvfr9L068+gq2S3RKQVEl1r8Bn4+55FWGnpyNud4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d22532c-7ef2-43ad-fc98-08dce1fa3c72
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 09:20:05.2879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k8J046h0WFeRQ2DGTDDZEgJwi2ZfAX1iY1R3zUjcxqI/OCMgzbR1Sn95Lp4XT+iSRJ+YB5k4TPM2k0IyhC9BkGoiAid5U7FAVdE6Ysh99zw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7187
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-01_07,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2410010060
X-Proofpoint-ORIG-GUID: Zrr978WwzUEqU9OG16wyr09bETjyyegE
X-Proofpoint-GUID: Zrr978WwzUEqU9OG16wyr09bETjyyegE

On Tue, Oct 01, 2024 at 11:10:55AM GMT, Bert Karwatzki wrote:
> It seems that the maple tree broke down, here's the result of the run with
> CONFIG_DEBUG_MAPLETREE=y in all it's g(l)ory. (Here I didn't need to try to
> kill
> the processes to get an error and soon after the error occured everything
> stopped working so I had to reboot via powerbutton.)
>
> Bert Karwatzki

Yike thanks very much!

If it's at all possible for you to confirm this happens on Linus's tree
just to be super super sure (again I totally expect this) then that'd be
amazing.

I ask because we have another thread which bisected a problem to this
commit which we didn't think was the cause and seemed actually to be the
result of something else fiddling around with things it shouldn't so just
want to entirely rule that out (a fix was applied to Linus's tree for
that).

[snip for snaity]

