Return-Path: <linux-kernel+bounces-346369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4691498C3EA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 18:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 293431C24111
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 16:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DAC01C9ECE;
	Tue,  1 Oct 2024 16:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ey1ByGFI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IvUPTvUI"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F721B5ED1
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 16:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727801491; cv=fail; b=gXS9UkTT8RVVrDXMhRoKsfmCBENS+Mjw6YmFs+/esDL+bT5sAteBN/KP3iY1M2/MZd7PudxrH3BDsTYf8ppNdvp5soWSlqff0BuwlCOTEA8AQxUG1uRsfurT3h3o/34dtEtXJGNaXWZLavoneiexbQr6lkjmeUGpJ84t0KiNCvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727801491; c=relaxed/simple;
	bh=Q7OFvWVVOlRxkjwL/2zb25PsO2noixKDlHL4atEVEbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EJEX0nYXGQy8s/eJLpSlaApBcYEveGMRbXCZyqp9ZqQ/5Q77epmssJrL1DFSzJ/w/MAy74cEYSpyaNe1LsdpixUPqVtNO3MKmQXDGtFj+cSjG0hcxXYA0NvijeJ9TZGh79J5xeABAtLvLdYy+mvMKUQOHo1DU2mYiBv+PB7MJtk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ey1ByGFI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IvUPTvUI; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 491DtdKG004843;
	Tue, 1 Oct 2024 16:51:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=Q7OFvWVVOlRxkjw
	L/2zb25PsO2noixKDlHL4atEVEbI=; b=Ey1ByGFIn7eF8bYCNHSB5LvsakNlOzR
	4U9inZMxVCnAX7UVFd5yDYqFX5NtsNuZ+QbJKGItyJ9vt/Nzfx3sER/f6rN9nay/
	gaOxHYMj1WfTl3T6OnTOLYVpx43fF1NWkV+9edgnW/YrN6JrFRXSnNOOcJ5m/Ptc
	p6fDnHlD43nMMc9c0IUZ2WLbeH2UIKDG6qgpJ4CGTbXJAw53b033kpiMB8achGMe
	iQpENgEuDv2AKt/Q1996hKlHPsSraZEpK3KChVIaEMwERhN4a3TOObvc0yQ6RGnW
	qGNxe8ZCw3W7veR/TpP2+33vCmSz1PrlbIlwNRVTNh3b4OYLQhqbT+Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x9p9ppfs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Oct 2024 16:51:19 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 491Ffbkt040590;
	Tue, 1 Oct 2024 16:51:18 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41x887t4xd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Oct 2024 16:51:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NdP50XmsLkGD0MlqN7ZOdVMzz7UFYvqhiscsXSgmqdomLRxh94NN+y+CPlFygGAYT4Ayr6IFCjBgPZ5TRpMekEDe7+YCOJ5uVM9MrBApXLnMNYRGkvm+Ie3jqRgkAvIIX9EvEIGnZW5THEegi2cZgZRirdjiAyPHPPT/PiqhjDIySZKR/VnDWYa1BmjTzXR8QafKvkMbC+jUl0kZbRYqJR9jXKsSBEACq32AUl63QRNac2G/p7vWD4y5G/igHGlXWC9/zaxmoKaauTYU7zjsBnI2sYc0cc9FqXKXt86zezDvJY4UF/CYvSD+vAp3OjwdbWrPWbo2M4XRysNmGMNN0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q7OFvWVVOlRxkjwL/2zb25PsO2noixKDlHL4atEVEbI=;
 b=yk1R2+99KFvnWJrk4YPmAEVkX0mNLD27l0yV0IwIL8X2XW++zNTTjshodUknPPVwNWWTpUrxLnvtwMp5ITgsRgqXCkiXi673amAPIXlvYMWBxzaD4kqrQFxsRp/yAveWONexMnizO7XZm6iiD9ZH0oh7x0Vn9gX1l3XwCjHyLKp/iS0Bv3Ul+zK2OomuGOP8lx6uzGvUNwc6LNdpbebqLygmfd8kkxDhSytMiK5Qv98JaMeWuV65nkcOiNaJEKhTBXanL9Eh+HbYqkbuhU+/dMZnbjrzwH70lzCTOt/XqaH7+TuvHs5+s2cq/4J3HY0XQkyhWvqZxuf/smgR5XqQnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q7OFvWVVOlRxkjwL/2zb25PsO2noixKDlHL4atEVEbI=;
 b=IvUPTvUIcmOrKL8ZP+2fLFdLNtUiw0MxFy3zUuwTaGFMUw9SPZYqdDDx7acJKlhFT+diZVpD7f8AXcnm7WjQqL8gbQUhwo6ZRwgQiG5W/jEoxHPh3jMVidxfgmwoS4AvqHJl9b1R9FbsoU2+p1fGol9H6noiUTYCyTZBd0taYYk=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by SA2PR10MB4730.namprd10.prod.outlook.com (2603:10b6:806:117::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Tue, 1 Oct
 2024 16:51:16 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8026.014; Tue, 1 Oct 2024
 16:51:16 +0000
Date: Tue, 1 Oct 2024 17:51:07 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Bert Karwatzki <spasswolf@web.de>,
        Vegard Nossum <vegard.nossum@oracle.com>
Subject: Re: [PATCH hotfix 6.12] mm/mmap: correct error handling in
 mmap_region()
Message-ID: <bae80e71-a139-4209-a2f8-3dd08d1b2c5b@lucifer.local>
References: <20241001133726.160275-1-lorenzo.stoakes@oracle.com>
 <84837835-b483-4d15-9e0f-1719c350423e@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84837835-b483-4d15-9e0f-1719c350423e@suse.cz>
X-ClientProxiedBy: LO2P265CA0060.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::24) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|SA2PR10MB4730:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ca0c0c4-f630-44cc-8040-08dce23943f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3UIAJq4QEAnugESYO0HPmVcesJGFu+EwGWl3ancubp07b2xeaq4GxYOsme1e?=
 =?us-ascii?Q?+Io9xRp8YvG9xoHpM5hunX/jIdTFYPGaysWqZspRSoShhFUi0+tR5UhNVT4i?=
 =?us-ascii?Q?RtaYlVcOkrYRGa8C9CC+8ZnbMv3+EBipUkQoKwbNJhrq+H0tuVFUmlyUmbLD?=
 =?us-ascii?Q?Bksj2QLET5aI/LNjDDS4iiALHc+tC5YaiE4O6DTDc32Pg0xQl/mZXiZ9cTlx?=
 =?us-ascii?Q?WZzgljYKP333WUvbj+WlY0qUSk0cl6q5UMQ51n9NtAO+vRgUnhTxaJP0+91m?=
 =?us-ascii?Q?rWKk7Y0zQR5Kg8GtUdQrzW9Q7ImkwH2ilIAL+xjLtOkYL0a7YRtJ4CXkmKhj?=
 =?us-ascii?Q?YQlUB4KWeShTjlKNyx5RwIhfRtU8+OLsh8RW6A07VJmBcOlBAaGhup9GbfIl?=
 =?us-ascii?Q?PbQT4g0czSJ/LBCqSgIEgzIrbr8sBGaUIqsNLAvWVCfe260dlmx8IiJ+/2qj?=
 =?us-ascii?Q?bY1qnMTMW5qf5TGBKV5hvoe5QBmM2bXY9kdJZ0KHbexZoM6ibiGxzcAv71/v?=
 =?us-ascii?Q?KtM0KlhHgtwQ2+AgM9IMUHhKMFfn6Q1YWbrj4FAc5PZQeTWNqkgb2OP1XWYr?=
 =?us-ascii?Q?3NwOn7/aeoM2AldRNmBwhYH9JsOxbCErpVi1RPwrPGZu55LonF1SyWZiQvR9?=
 =?us-ascii?Q?HgrgfJJhT37T/aorS2QVjkzfoWW/gSOtx/z0kwYDwHpztrbvH1tmYjYG+/We?=
 =?us-ascii?Q?oI+0Qr/Ml7sZmBK2nwYxRU8FOuLj4EXt3Ix4EH6v6Ns5CQAOQMlMGGbqH3Of?=
 =?us-ascii?Q?u8yl7qk49GVxxG6b6U0MPuPkLN05KKJhXWR6Tk+8cPF/OBXScFytzFWhgyF+?=
 =?us-ascii?Q?F1yTDm/zbncOwnA2jlZMeRGQMd/3khDab/PQ885p5hijRaal85XW2gOQQE6h?=
 =?us-ascii?Q?oBo6dGmi8b173Nra+SyrP2TTczn6jGgYfkM1xgL5TJ4vX7Qai0F5GVheCwGy?=
 =?us-ascii?Q?oXbLCaW32PA4DZMKkd2uuFJOiUT/WT5gXgDWjOytwBBxeCakYne0i3yvxFRs?=
 =?us-ascii?Q?bvhemLdaCHg4Q71dGq4Qias6/N6p3ox0Qm7jeGCS+aNR+I8AeXdEinlpBDUK?=
 =?us-ascii?Q?Zo35tgxGl0avi198LeRf0SZrZWZsWYtH+/017nhJE9Jc9mVO4G5mVla5dq3P?=
 =?us-ascii?Q?d1XeQ7EGkir7f+WLs3ojLFGIo15owQPwhj5Z++MdyB5O/Gz/FjHxS/agjA78?=
 =?us-ascii?Q?IeWki1XmbNPHFS4te1PZ3MpAvDIM6I3CbXlD1RvWq/Ql63S2lR3mUJv6PmUQ?=
 =?us-ascii?Q?e1h9o68vy30ivfC4hHascENgCvVo11aguCIH1hgb28VvILQiyb0J1pzUtpja?=
 =?us-ascii?Q?h3yj09M0d07U3bNP7PSC7zqMYdDtCbyF9upjcGXze7zsE5Jnfpy9UjMhj/+U?=
 =?us-ascii?Q?gxhSnfo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?et/5xS7FYXb5uy79nXul+Ut7P0nYlqfTIjaVZT85vnRuqpp/0eRVOkX7HuRC?=
 =?us-ascii?Q?04wl8YxvEqeOZSj3RwBr0YBwVJpH3FZRR72RobxKW9D25dN3v/f7nlR71KRQ?=
 =?us-ascii?Q?57KNylTAqGpdemg4aKoKj16IDl3ARcNbcdcuaWz0kCB31beikugbn0bRicvU?=
 =?us-ascii?Q?Y1nB3WGh8JNDgOr//0FY3Am18TYQlqFr1tF3U/ZCH4uzONj6vC7veRD0NSAo?=
 =?us-ascii?Q?tJr3AA/Lv5r6VELFCuE2163o6N1QUPixsV+YFAldjxEgEVnA693jOGW4K4wM?=
 =?us-ascii?Q?3Xaap+XJOjCD5p+LinCDw8cLgReUEKeAmiBRuAmvETkIrMM+AfnuNnmNpYFY?=
 =?us-ascii?Q?R1VA0GROh8pWJn1F6GjreBaiUqCqlMehqEzfFp+ZgVHuarFcwZXKr6bIY8za?=
 =?us-ascii?Q?0744DU6i0noHcqGCpLYHt7XJeUENs9xhplU8pspuQNVoeYftKS7deEIsfHVV?=
 =?us-ascii?Q?BgE4BhMTRHOM18zywIWfQBZElXRUrgfkJ0dbXYAXRi0IF367kF684ET/Q/VW?=
 =?us-ascii?Q?lvk2RLc9UK/3I4T4M0VcP7muIvPZr0XmEuH1LeHArjCHeO++tp3anhL2N4dw?=
 =?us-ascii?Q?eKjkQpaRfTbSgMX/47JJokeh1eXhrWifTPnOvT3sV6wZr3DSp+9sgsVfmhD2?=
 =?us-ascii?Q?D+bAuy7FZDBAS5fzUD/wZyKBR1vgxA442ZYFK5No2P/Tg6IrKodUmEx7MXv8?=
 =?us-ascii?Q?pJX6MJmr1qyGUnocBHjfakXpVoxZeOCwpxZYhjOxkf1kvuINha5Yy8p9Vbux?=
 =?us-ascii?Q?e8r7kTxg1rRvJiRRxAuGr4AAk7dCDO/HPIXtZxvy0xHktX35Xz1ZkPi6+FIU?=
 =?us-ascii?Q?WAangN2w9T+oRNTKiO41K/Jbz97Mg7K0Kem9BUkiXut7BKVopqLvVDJGCOwp?=
 =?us-ascii?Q?Lit30cd6KC26Co4HAYtVCWMchrE4KfdWyg1T8jW7O1Ez3V9qI9BcthiWVgOn?=
 =?us-ascii?Q?MBRzFfun8eoWIPHi5EQ5jHWlwmADAl1+0lvu/Xf/XUTx94qhhVh4l8yjC2vZ?=
 =?us-ascii?Q?ezM90TWNfhCjtNGfRPizrWcAAQ7EVdh5SzeYWc7O8gB348v8zha3pbqjGOJq?=
 =?us-ascii?Q?wJ1Z0qGInjRJXfmFMHtzZKwRUM6H0s5QtV9krCMuRa4Z5yXA/oP5WRG/jcz8?=
 =?us-ascii?Q?tE/wgtHXBgo8QAiWP41eNAuU5UmOnsc8Q4WE8UBH0G9VEhu/1VIxEClz/WfD?=
 =?us-ascii?Q?1lQ0FxWkmPN4Vt4BHNeL7uPdQhP/1uUGEFWOCtVXeDDk5ZL5pVbpFEenzmc7?=
 =?us-ascii?Q?sccTKv3FJdxVj6I7xT9sq+oqWsqQZDoeGWON0PFaweqflQguqz5qBZ5g/nx3?=
 =?us-ascii?Q?3TFCsJVfAOjSKPFO63q0Oi5I7H5J/mByxtZa1XhW4ZFa2PP2ObPR0l4dNBBG?=
 =?us-ascii?Q?iPtLJw6eZx9pjAgNAOeDlSZKQzWyd/HXPDWLwYNmcmF+Koe9MmXzBq6E0Z9z?=
 =?us-ascii?Q?f8ArvSbr8ud7fnEL7urNVDKDyC4opn9qgxb31qNvoF73QZlEODI2ihK7VXUm?=
 =?us-ascii?Q?866kxzkeYGhklddnnGwWjnYaELuw7bI6TEahxXWnS74TToRWl8WpC7H8DYAt?=
 =?us-ascii?Q?Ak8+VJb7SJEi4cs3CPLGDcy4cJ5FWQj9Nm81+z0ppbnmWFQ6rNGBiqWR4ioq?=
 =?us-ascii?Q?2A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RURxaFQGtEasGCZJIbUUgj2ET8f4OWGLorB7qEQwTz5rYsH2MNIvsYEBCYWlSE48iAjaA6THdn2k8oDOufZnS4Y7n8Y9kCBlsAyyaG5BG+lnlwTXYS98OUi061qUjqv74sIJsmr/ZejGmEGQF8f9OqI98AtYHspx1SPRjM83vC4pxXmqqnee6C/ENAiwexUxHmljufRLdJlGcYZgMha9IFJJGMw5lyiWxCs2thle1oZI1QrXFXISJLojplpBdqLsacOLRudvgDv4yEzV0UdH5KWHDaw8SOsO8HhpO0b3FIctv9zfK/UYsbnWaMMWQIeFbI8oq6jmUAkwp6zNV9jBjw9NZFrPawZky5jX/HQSoLtF5CO9I7mznBAhr/i5/5Rz1kYbcHuSGun069Yn9b7FZ2CI4/GN0oXrBTqeOlr7OqbTVdjR922sjl3pvyBtFZryzxzvDmRI1HV28OiSSNmvPypkM59tXAjS7dTHAZL1lwBn0xJVUWV/tpX//LjiYEg9zlK4jboMlc1LzW+J7NaDb79lrKY3zEBgk/Xb0Ms/w/CCe/dErP2MFUliqQmx8102C2jxXmhkaCqbFl9PcbvvyOJ/gHU4Mi/iyeKJD0DI5hg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ca0c0c4-f630-44cc-8040-08dce23943f8
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 16:51:16.2483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2sSmDXV4zl+6qg0PYjgYgFj6ZclVBOCuAjM62c6iawVfb3LeIukYEUNYDml+wynZDvNg5b6m9eJ9+clPVe2qQMxgzhXNlZ9I0gRt0TzD4tU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4730
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-01_13,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2410010107
X-Proofpoint-ORIG-GUID: kU8M8CYrZyksebF3wcLlgTByGPCfes8K
X-Proofpoint-GUID: kU8M8CYrZyksebF3wcLlgTByGPCfes8K

On Tue, Oct 01, 2024 at 06:42:47PM GMT, Vlastimil Babka wrote:
> On 10/1/24 15:37, Lorenzo Stoakes wrote:
> > Commit f8d112a4e657 ("mm/mmap: avoid zeroing vma tree in mmap_region()")
> > changed how error handling is performed in mmap_region().
> >
> > The error value defaults to -ENOMEM, but then gets reassigned immediately
> > to the result of vms_gather_munmap_vmas() if we are performing a MAP_FIXED
> > mapping over existing VMAs (and thus unmapping them).
> >
> > This overwrites the error value, potentially clearing it.
> >
> > After this, we invoke may_expand_vm() and possibly vm_area_alloc(), and
> > check to see if they failed. If they do so, then we perform error-handling
> > logic, but importantly, we do NOT update the error code.
> >
> > This means that, if vms_gather_munmap_vmas() succeeds, but one of these
> > calls does not, the function will return indicating no error, but rather an
> > address value of zero, which is entirely incorrect.
> >
> > Correct this and avoid future confusion by strictly setting error on each
> > and every occasion we jump to the error handling logic, and set the error
> > code immediately prior to doing so.
> >
> > This way we can see at a glance that the error code is always correct.
> >
> > Many thanks to Vegard Nossum who spotted this issue in discussion around
> > this problem.
> >
> > Reported-by: Bert Karwatzki <spasswolf@web.de>
> > Link: https://lore.kernel.org/all/20241001023402.3374-1-spasswolf@web.de/
>
> I'd be surprised if that fixed the reported issue, but yeah this is a bug to
> fix anyway.

Yeah it seems that you brought about a tear in the space-time continuum and
the very moment you said that Bert reported that yes sadly this doesn't fix
it :>)

I thought maybe some very weird bug by this function returning a non-error
result (of zero!) when it should have failed might have triggered some
later maple tree corruption but yeah, long shot I guess :(

Still, ultimately it spawned from the report and forms part of an overall
fix of the function so may as well vaguely keep the R-b tag, I kept it a
link rather than 'closes' so should be fine.

>
> > Suggested-by: Vegard Nossum <vegard.nossum@oracle.com>
> > Fixes: f8d112a4e657 ("mm/mmap: avoid zeroing vma tree in mmap_region()")
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
>
>

Thanks!

