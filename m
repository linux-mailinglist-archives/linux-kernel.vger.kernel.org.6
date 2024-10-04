Return-Path: <linux-kernel+bounces-350141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63FDA990061
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 11:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E09DA1F21F17
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 09:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B668148850;
	Fri,  4 Oct 2024 09:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bnp0vOtx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mZp1z8Lv"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1C2140E50
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 09:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728035948; cv=fail; b=Lj33cTLsg6VmA+N5vNqGFIAbNY7Sh2fISnyjYXH8Bj93FetNERz8+6Rl68kkfBbXhTAJaCUwhHGrP8Duf42BgGtgnnhi9m01cfgVwfKnQME8yP1FtDSZOnxBjJgHsfmwFUdhf4A6fcc+m7nj09XWs7Bic322JVyrpnPpOyg9sIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728035948; c=relaxed/simple;
	bh=QupVEmKmpUNd0m0e2iAvS3v3XkfHYkQPUDtvzJ4seCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QrPRbJ2hhd6rM61WdxTPy55IFAgXpEqXtqL6PtqlVIfH9EoOpZorm4E6qma1kp131ZYc+HCMwZIyJ6xkUkaxP/SM4suLOjeRwmQNTSn/NHBaNkwpG4j0kKnzUZ9d+uIxXAXp5ztsbrwcMgvvRWCfHQDM0/EiqjYQpMDgF3CHOUM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bnp0vOtx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mZp1z8Lv; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4947td2m015037;
	Fri, 4 Oct 2024 09:59:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=QupVEmKmpUNd0m0
	e2iAvS3v3XkfHYkQPUDtvzJ4seCI=; b=bnp0vOtxZQcKm/n+ZXkkstb2TFHoH3M
	TyiQQZn38kAXLZahvOqFLzh4ene9N9t3InmqkSVvsC36IKi5jpwbo3FisqBvEpVz
	hifVWKUNWF0feNmeyWJ25jjisE/2qsspNcOHUMS6CviXDVA6wmdi3VPq/i9XYBEc
	xU88Oq/J00YskEodlAx9WnevI/anFehPcQ6zXd4me5fyCbZ76O4mJMgpKe5GP41X
	Nqm+3Gqgd/UHPYL+gVsxi0D3+m3yL8hbRDIXoNB6ptyE2dXa9krWWJ/tGYn2GFAS
	ae01gHu/0KCucDIHuCWD/7MI/yl3ZKYjKbgQIJIrG/xriQjxr/pp9iw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42206m181p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Oct 2024 09:59:00 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4948dVw3026488;
	Fri, 4 Oct 2024 09:58:59 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2047.outbound.protection.outlook.com [104.47.56.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 422055j81s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Oct 2024 09:58:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gzzmjpibhb3Sx2cgdaRsT+C/5l30/dT2gBuqnBkh1Hk4A0/pqn3KuI+O1vAj4oyjy9O7Cj+3mgyrJR5i3Wa8nKwiTrxR4a9YS5elqdU8WW00Znn8FskYh2mLZgAiEPXvhvBa86AxsbbqBk8P4JNHlu+Nget608FlLCA6emMl52mAjgjKdGkkg+2Jmq+m+Oz9fgsbgK2tHGTCCvTwNqtcZbcAIJgnfQPAhMYRO5vWKR9wqpTiVRvWBuFhOUFttRBir31H7JcI4ZEql7Muaxf7+NFsg9VE6ooiJrL5kIOc2I+v9yyrTK3hiUPgmBojURACHX8PXKFFLfsETnlenVq6fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QupVEmKmpUNd0m0e2iAvS3v3XkfHYkQPUDtvzJ4seCI=;
 b=vt6tQGE/0xd6wJFAnEFPo7TzGLjvhNyYORNmHqMfPpnH4qBP1BiM5HyTehTNQcoREHtX68rt6W7SM91YAa+BOrYRUT725fpJlQUk7xE7FlARospWs8Pdysy5W/O91YoKGSbQsUf5o8A30PLq/kU0w7eUgEbGl1ZkfnJELk7VjVLjFtsNHmWoyyGKL7ycpQpBZgxToJFtrI7Gaesxq+siIJwUUfhvxoLpYCpVp2kwqyBF6pVCMUoG2m68m4Zu/o9NqhjeYEGmk3HbUy+xwYzfTBUyu80QV8hxgY44CDz6vXdjzjJdrkMhWCE0szO5ye9yl55e2SNnDJaU6jvehaXWhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QupVEmKmpUNd0m0e2iAvS3v3XkfHYkQPUDtvzJ4seCI=;
 b=mZp1z8LvgpCQ6O7xzB2LmFm3Ty2Q6UQdGrNni7no+OgzgieF9nBYBt2TcbXjFBmKF4+vULDu26xjQW0aAREHlipJOQmDpxHVmAnF9Wvvym0tseGH14ljcaMJRdSNXXIS2Wg52uHqmWjycm3YGjCA6gCr9kKtP6W+ehoLqV4SB+k=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by LV8PR10MB7846.namprd10.prod.outlook.com (2603:10b6:408:1f7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Fri, 4 Oct
 2024 09:58:48 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 09:58:48 +0000
Date: Fri, 4 Oct 2024 10:58:43 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Bert Karwatzki <spasswolf@web.de>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 14/21] mm/mmap: Avoid zeroing vma tree in mmap_region()
Message-ID: <e4ca4197-0e3d-4d28-961d-7d5b5d6a9753@lucifer.local>
References: <20241004093546.3232-1-spasswolf@web.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004093546.3232-1-spasswolf@web.de>
X-ClientProxiedBy: LO6P123CA0026.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:313::17) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|LV8PR10MB7846:EE_
X-MS-Office365-Filtering-Correlation-Id: f5179e10-e314-4188-808e-08dce45b243e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fnuIVmyWEtrs3YCxs625UZjCwAzwKvtWnvxXJWD3G7WuuJiOLI9pMUydVwxa?=
 =?us-ascii?Q?2UvAW0FquGBHlGf7p8APqvk3PnDAN71T7wkEfKSUke3CWNk6lrE/xAZ+lgpu?=
 =?us-ascii?Q?+bJB6ukXRG5/BN8997rrjQpYCIRD1U6CUJn+lesJ8tsiLid14/+aR/CIddPh?=
 =?us-ascii?Q?SnqqZ9rVx39kUc7IofMatTfsesZ5BvGdAqd+oEpFutcYC3INubHLSui6jpcQ?=
 =?us-ascii?Q?lL9LJRQVfXzFEmw2xkvWL7okFR2RQoBvk1FiyUq7th7W7cMLllnFVhvCjIAn?=
 =?us-ascii?Q?TAVooO00tvze/95S1iP4y+1n7ogaCohtwaZ9i80OZ+uQiyCyHbzZ4unSFlMX?=
 =?us-ascii?Q?9eEAIS1nwBQ1bzZ/rYHBpietqFHi7ab6h6e9bPmvL5kafEJ+1Yeq5gmZWXug?=
 =?us-ascii?Q?iyxE4+RJJ4c+DPvmMbTd/9KKUh0Es7PaJKjxgohI85vhgj8Z3KUPzHkLhk9r?=
 =?us-ascii?Q?kbQR9+i8j8VOaWSlhd1Shd47+YiePdX7cEDpx7vIrHKgeTN2byqClmsnPqxH?=
 =?us-ascii?Q?1Ss2nqm0dEM3VDR5/Bt0P6O/FfNtRiNPm6MiGD1mTS4hN5/zHmBusq+s5ynm?=
 =?us-ascii?Q?gvUSs+uFhbHsJSa1GjPp+DhVq0AUVDOEti2mJp/5uiDg805gbuRdzaaIbFc0?=
 =?us-ascii?Q?ofjd2CvBwpLj4GyTMtotwhW/gV2Mw00mpaoxFUmjy1SRLYWMhrCGhJ7k6+hu?=
 =?us-ascii?Q?VWZF1edx7tBHVNhx6RlI4QybMb370v6UYfH4yjsfiMfL+psfd5UH4i59fVZP?=
 =?us-ascii?Q?QCr6vKcVtoUzD14+sL/N6kAnjksIIlH1QvjdPYAAcqEn1MjT6fzRxR42EVG8?=
 =?us-ascii?Q?znr/hDjBHYCISSqfJm8gNaJ99lldTop45GUhF+T3C5doA0vkS0IivLbXdEQT?=
 =?us-ascii?Q?/+lwZH2iZd1ecrHzCMQdEIemyihLTgKNjtcc+PkC+puX19K9XblpiixbTmyR?=
 =?us-ascii?Q?7bPEe21EctnppIyiDpwYLnh57Hi6G13UA7tnuvjvWDA/ZmJK9ZljyIQSRPd6?=
 =?us-ascii?Q?TZkCfvHJ6sgcMKCQQytWnDxM5sDHi0slMq0iErFs5Sn/0IX2yTD6mYX89CME?=
 =?us-ascii?Q?rcnoAYsQC+OICJtp1rBWLIcn2TsCMsXjXltpxE+PlPvkuY6m1rQ7kYmtrz1l?=
 =?us-ascii?Q?MOhG5Vkqng9raQJOzmTENEIsGP6WtprPR6XQAYF3UbklMwKzFDR8NRvbZwd1?=
 =?us-ascii?Q?J6wvE7YoZ9FnFoVfsXvIp17gbXhjk4XNvuVbg8orIj5xok5eehxhThWosIFf?=
 =?us-ascii?Q?PUtJr+InPElwjZ29jHlO58gtU966uhBSBe1kCvMwlg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hf6qSIG/Xj9/cQWM4MwTsq9wEGqhbeNFZgw0xxPTNSB1pa19SICVi7nwunjw?=
 =?us-ascii?Q?zPRgSOkwRp9ZwsQ3W46gMgZFtzHudDx5uqjNp/2oaA7SnV32/0nziU8QHpIW?=
 =?us-ascii?Q?QO7rHHqGLPuVQvngc7LOttLL2A1EtNpQMHyGNYQhfsk9TlZSMWNNt2R4BeZy?=
 =?us-ascii?Q?EVScEBZGjktyk8E+PZvy+TDLveyK4Wau7TVl9SUyOP/D/SNUIyhGvg9pvDWq?=
 =?us-ascii?Q?P5RsTNyKoWVB/MeCiV/QxM+TvmgByWXKEM0oirdDE2PiWly06xrWHBeA7uUW?=
 =?us-ascii?Q?p2m7XwyMnGK8f6dXERKfqT09rCvZUmllwfnKjIx9Hklx8Z66Utv7TU/q6QcJ?=
 =?us-ascii?Q?AZQs5IMFSZrri80f1nQvyBnIPkGD9YXJwt5kYUE3OvRYPz0CYa6GHFf5wbsG?=
 =?us-ascii?Q?URP7RdO+358dyOv2Cn1ezj6osj/TwAac5GiXmOWpqySABDMo2pBtm47APVsI?=
 =?us-ascii?Q?WRhe+wHJA2tna/Tv52ZfCnAdR1/cAeFLLV2rDYccMgtm86ODFa01DCAZl2H1?=
 =?us-ascii?Q?rgyC8ivkkXUzK4O8VTtoqFyRo84F9Ty+WSeHyAZYkEfqfrxhr/NCbyBdTfxb?=
 =?us-ascii?Q?8w7Gon4VDkFKWXImH6qgEy5xVXkOsVmFJ14XeJazgo+b4U5zWVFXIDSm7sE4?=
 =?us-ascii?Q?OzMZR7br0dfieG+gT7ZGTDITDSEVXYI4vh/NLiuqbUkDhk8lQAiq5ucMA1qP?=
 =?us-ascii?Q?wv+g4R1q3Osn3FwPLvfVYEYltZlWuuWyCsASpWGES5E8KMoN90RaY9arnHeW?=
 =?us-ascii?Q?ClR3DzJPBB13cJqisQpMvCZ+fOa72KELi0ewXqzCWtqId+ebAgS3oXwgsGQS?=
 =?us-ascii?Q?IlkQ4oTFyBING7cMbhNeE5Yu/B5e4o/N1DhIatF6s32h14uV7lFC2kXwKGSl?=
 =?us-ascii?Q?MhMORcgNooXeizTfw57wXR4PEG2ECST3PJ4t1OsPfPgwRUCO/wX/VVaTLAnm?=
 =?us-ascii?Q?7EibeVAwKBTe+Quk/4EghybEhhgz4aMQmty54FafV2NKMm1Yg3BkhV7hwUJe?=
 =?us-ascii?Q?NxXWwOfkEu8XkuG1XO4Hlz3lVSjA+6xFcOS/usMH0NmCTWZoj2GbLdBwzPf/?=
 =?us-ascii?Q?917875SKrIVvjkt/XbeKZPS1mD0NZFB+FuuiN2L8wFn3ZeqJvQuqNDkXh7p1?=
 =?us-ascii?Q?CNfrER+N0ihFbdqV9i9MkjqE4WquuFvp7M3E8u4kgqcZoz/Hw1q8Ic5yPl9H?=
 =?us-ascii?Q?NYUqLrkrwTUAm+YLOwqCmbo9MlGYtasrK8rt2McH91BeadXMG3moy9yYksAY?=
 =?us-ascii?Q?7L2mAFlQ45awGgK+DfIXHhMSfYhD8Y3JDaNwppzwMWb1XlMmOK5qrwuWDHHQ?=
 =?us-ascii?Q?+nsrn2g3awEQL2StZxEgCX0EE0ycrV2zQ7zBR0lnfftnvHqOjpU6NY/akJys?=
 =?us-ascii?Q?7wrgCdeZbYyMhaKRXUvYuAJVDG3HKOZCylvxVMKOSEEnMrFIRZzojeWBx0KC?=
 =?us-ascii?Q?vlEvb8keeBXZ+EZnqb0cgDJi6nVLMB3VOJROcgTe8z615nEUWabZdXo8s/q1?=
 =?us-ascii?Q?m9aMDjOGoXVJKDUeCNRprhc72lXjLjX1rcNYZTjZMkSpNOO4cEj7llU9eoeW?=
 =?us-ascii?Q?Ee7xIRzL+ekvnXU/afzmQ2TxhYw87JI7C2KCDS7q141ou1/8y/XuFYgertKD?=
 =?us-ascii?Q?/Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/eYC/A96+toK5tKi4yDND8amPLZon7dq7v9RLN9DFvHArXaXVNaYCX69bpMb64eXC0OPBhF0QL5KfqdKA9OpFsEoL4Ff+uxKpM7P3Vgyv1TfC6vtDCjdmctPNNODQCK8wtjSrAm1CEODM/D0jZrWtoGeEQkhFwPH/tT9/vZX+/lFIlKIhCih1Xe0tzHX4rOSsIdYouml4pWCfxhqJBZvOAH1ssNW50bhIpvb2lcYf6Tu3Py9HOzh3NZPwQyYrs0OzzV/2cm5zMG7zW2Pgh7OgQfs6CigxaRKlViS4y4glrC915HJS4XterM8q9C5wBQ2ibD4v+BDZn+MmYOJogZ4r7DrXj9bPLUIM18kbaBrPf72SclboIAcYNwojhzuDL9w6ylX1uUp/IAhmhNA2soZzjGOgqmQfjrY2pS7vJ8AQfYUv/rdDMm6di5rXgCB+8h+tj8o16ybeO9HmTCu94S3PKjdoVIs0tWQng9c86ox6GQIQbV8qCtD8ksnkZsgjPMNHjPCfNjbhcGdbW8wqHoJFRmTNejrqKPYxOPjhfrVKxu6E2hohh8GDI1tI8Evrc1eRsZKP6vxWTPebeTAKzOvCTy/O094yH4XfTIMvz6NlG0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5179e10-e314-4188-808e-08dce45b243e
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 09:58:48.2052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6kfoBy1+RT4jBgWFPdzVgBLA4HM+lSgYIl6FQA8de6E6Eegh3evLVwZ6DvIEFl3Pf2EROacVBGrbdf+LowYOrqipR6BOqCFS5t9EhPd5YVk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7846
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-04_07,2024-10-03_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 mlxlogscore=985 mlxscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410040072
X-Proofpoint-GUID: eL8pHdvgwPP3RA3PZqHCrB_SEqBsJH_A
X-Proofpoint-ORIG-GUID: eL8pHdvgwPP3RA3PZqHCrB_SEqBsJH_A

On Fri, Oct 04, 2024 at 11:35:44AM +0200, Bert Karwatzki wrote:
> Here's the log procduced by this kernel:
>
> c9e7f76815d3 (HEAD -> maple_tree_debug_4) hack: set of info stuff v5
> 7e3bb072761a mm: correct error handling in mmap_region()
> 77df9e4bb222 (tag: next-20241001, origin/master, origin/HEAD, master) Add linux-next specific files for 20241001
>
> Again it took two attempts to trigger the bug.
>
> Bert Karwatzki
>

Thanks very much, it _looks_ like I have just repro'd the bug in userland
testing :))

HOPEFULLY unless I've made a mistake with that (after all this, hey I'm
cautious right?) this should be a straight line to me figuring out the bug
and coming up with a patch.

You are the reason this was even possible so thank you so much!

