Return-Path: <linux-kernel+bounces-274634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EED6A947AF2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 14:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EA911C20372
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 12:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858E4156F37;
	Mon,  5 Aug 2024 12:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TpA7L04u";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="P2ia5gUl"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC969156F40
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 12:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722860104; cv=fail; b=i/exJccp0FA0F0rpUd7aVDpg7MaEAFQie2/KV6ylFGpnQsmEfYc9HqJNipyWuBgDyRCIP8BoWVXYxZtZRhFbth3ZrFTRbMVUw27Uh/MppiUerFbe81BpL1QjSHKHjL6rmNwgC8ceZjVSgGjMibvn4VSE7kHj0AwH9fcLKWk3dpc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722860104; c=relaxed/simple;
	bh=LbAEY7j6SUKPcdHbpe0vSKiwdsPrlI6CHLMmlTHUJZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=As50Sy4eZtwD2zfviuDR1ZZxN2Jm33VkgjZP7BjecugPXMm3jtK4HQoPUdiOvQ3ubRU5AD5b893jqDaSUk8Y7sCWK7n8q1eqRs4Aih65+TYA/ENkPA7F8/3bZAQV8huoRu+k37JPbwhjiTZqfLyZl86+guH92Fc4s6vQVw3KJH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TpA7L04u; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=P2ia5gUl; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4758fWVV012608;
	Mon, 5 Aug 2024 12:14:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=feC8z8uC5xsEhMKYHwYFy7Lqw68zN8Vg415PZaV3Wtc=; b=
	TpA7L04uDrqL08js6Hb80yLUyo5Xa7gDX6n+97kcirfRGPFeqYIUdZzIiL+fT94V
	75AlfgRaPBYgrkhl9yQr70DcNjY6D9jdHhrxqny6345zpDZzI33QZHNXQ20hA6Gp
	jwqLbs8pplkggMbEQWGSmBklhiBcD2I+mwDRG/JYB1g5HzBFIwcz/0hstgEmkUxi
	PnPM5v1JxNCT95ZzvT+HX8cSyK2xmVT5oFnwhGzIxYx1NCPSvZUFM252vXG7BII7
	jlNVGFrR/MfsherCP4LLgTRoEWGpvRighZFFHBVZnYuPft9gxkgxtvbMZLRydvIr
	KaKCJjkRAFSInV58Fbdabw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40sc5tafun-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Aug 2024 12:14:54 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 475C0TYm016979;
	Mon, 5 Aug 2024 12:14:41 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40sb08eu9c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Aug 2024 12:14:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vI3lTj671hqMtxkf0Bc973MQHOdBdAvYvQmfoAc3pkqeXcFt4zrewV2bvq1KhhonUTd7Rwn7N1uFHOCn6COyhekrFbQ5DpuCpYmIr9KPXQHN0E4YfSZ4igvVd8/X7ksxYs5nfANUr9/8MhVQ0dBOkZD572bGyeCYPViuacOAKC5siNLGUtTASM/MA7hOSa7IgcjMZ+Zv/C1NgGU3XxsohBHX4a+GsawaEK20iX4nb5fIK5gKkWpBv30xBR4ToddWAbh/U76HtY7ka9egsEbnFAodHOzWFSfeTh2u3nz8bvfpdcOaSW3NRhwyBpyIudGXGM3D8j9QqHnsmfZ+/TH3Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=feC8z8uC5xsEhMKYHwYFy7Lqw68zN8Vg415PZaV3Wtc=;
 b=AKMhGvGhUMKK5d9cpPoC9vyKob23ydHMZ6t2/v/VxPZTTgr3nJgOTwboq4b7awv0GGbxXqdm7BjS3NDbrv04Vs/QWrmkvqq0ArpogvJmmE7A4ichQzXVdwXE8fSb9oZe8MSCMOOynRdf35pT/xfqbtza3w/SBPLm4xCUpIllkzWVSiF6V/bSzZ/IhIlOBloWJdGyOS2eOABeD/mLu1ilE+TZXl+u0oP6xz75JKMV4+qhw3gPuopO6Cn7/EWcwgRNqSlE43Dn1PiS9G2EQ+eqEYTFyBwWEiTQuucEZspbvQMXV6ZjNz0KL4Z4pV6jwiqYGuRm97er1dLC/CdDpk20bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=feC8z8uC5xsEhMKYHwYFy7Lqw68zN8Vg415PZaV3Wtc=;
 b=P2ia5gUl+gcJa/MS2cRdCyIeUp8VhF0GGnvzkMLMpSbGU8SLMbO28UMnBDNk57Tdf0AdpC5vjntMSCJiAnfO8vyqAvk/C2IYGL614SNH6YVHeIP9ozjUZfYNgyRIma6xHX4iDMVoh8VAC+420S4/ADTGQGINf37z/Y/Xqa5Ymw0=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by SJ2PR10MB7760.namprd10.prod.outlook.com (2603:10b6:a03:574::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Mon, 5 Aug
 2024 12:14:38 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7828.023; Mon, 5 Aug 2024
 12:14:38 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH 07/10] mm: avoid using vma_merge() for new VMAs
Date: Mon,  5 Aug 2024 13:13:54 +0100
Message-ID: <cf40652a2c3f6b987623f8f11a514618718546f7.1722849860.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1722849859.git.lorenzo.stoakes@oracle.com>
References: <cover.1722849859.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0011.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:62::23) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|SJ2PR10MB7760:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b0fad8e-7582-424d-4eda-08dcb5482d75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?X6X4Fg/qYR2z+hBynTdzU64ZWMI0yYyeMb1o3w5j9Lv2Dw1U0szjYCITam2v?=
 =?us-ascii?Q?LDRJm6aFCNs3uxRW8QyGR0i/sCuZmwG8c35aDthEozc6VzTZDnkIr0PG8uf+?=
 =?us-ascii?Q?FmjxFfQHuIjsrPR4cSc9Y4doIFim58RJVObi7hm6lT453/hITxgPGlvrKox2?=
 =?us-ascii?Q?UmDEGkQ6YVkEfwVjS4kebHph8WqBo+0EA/mRRIUDLe7ZyGjWyQEvv8C/PzfB?=
 =?us-ascii?Q?ekdV+d9S9vAI/rPZ+yKo+F0WsU3GH0NBci6xBU9ia9XO5q7+bbVOQi+o+QNs?=
 =?us-ascii?Q?dSQaOjJlcw6g9c5hA0eZ95357fkU2jiaROlNMfyaXrWptp6o/Z5MvdLbo/JY?=
 =?us-ascii?Q?JBFeNSJCQ0J6zMe3ls12iee6BywYLUSZZX6U4VuyDe6hyszf1wjB4FDukkMA?=
 =?us-ascii?Q?D22T9oiUlsaA8b93rRBOOTubrI40bFtgij0qrJ4zfi6nc6yS1Bx0YFfsJSiV?=
 =?us-ascii?Q?g7Ipy9KA9tzoMej8GwbcEgrTI9TGcs7RaT+t/GqljjfbzTeL/AnmRppu21fK?=
 =?us-ascii?Q?TdzB5iTi7lgbEokWYcriyoql1DbDRYEp/xIOyik/36Il6fwI1S2nn8oFzLV1?=
 =?us-ascii?Q?Hn8NnFQQTa9BdG/XGBZa0n3zkj40gQ7Y5T1IVTl9Cy+pMllhIUK+BRRllRVn?=
 =?us-ascii?Q?P5YF+fIwln9WTwr4vz3g+OG2lV/wsyWN/TAnDyxs1HVMrrCX3trwabORKaZA?=
 =?us-ascii?Q?2TXLAucyob/FNHP8uM8ELmOaJfBcTWqyCZIcwx1zWMtibkBpSGfNJZWg/VQc?=
 =?us-ascii?Q?oxDUeJMvoAbGwRFiDagU90kGcNir8RHPT1AaUO3lIjaHOOZkIHywCBIkBUw6?=
 =?us-ascii?Q?eaazTE6QJrEUvc/tBMME5nbeX4MyLQlHfEeKntpJRHhh1mnzCd1hb04uG55c?=
 =?us-ascii?Q?qPeT6ntWljlSJbkcP3zBY7TxComvxrHaB06m4rbHiDrhyUaYZwdY2VnVGNEM?=
 =?us-ascii?Q?xERvFAKiBICKUSEDVc12gcAlynBsLT2/3WLwzu/v0lse69YcmZ8L8b3g0Fnr?=
 =?us-ascii?Q?mI1/qB421V5lpSiLUSmMsWnaG1K0MibnaxUrmNr/YNIUp2RmxDi4Uu1bYWQp?=
 =?us-ascii?Q?e4b28xg0AoDJ5es9mQwQtAK0iFZ3CVHsIMob4dUrHo01+92YBg1VeYu+tz4G?=
 =?us-ascii?Q?Tc4UqVSQKwFVQg0bVYXhvyni+dUbCPxEf6FqLkI8AvnnqP/HJRB43HG7c0rr?=
 =?us-ascii?Q?lMsXoO4NwtkxY6bz656BA70hTqikXbq4X09p/gPpE/hCcXeWjt2aLRal4CEy?=
 =?us-ascii?Q?xPXeGy9LBhjyXQHb42TGa5esvE6WOUiV0l8SX+nVI9GXPjMOgVxpXNMfhNlQ?=
 =?us-ascii?Q?iQTpYnGTthiMMKegj+nyJVMlTXEsC3YNgmB3K8hyWxznEQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rNwyRij/G+lybaoQcPOUjJZS8IuuFJBLejti8PQ0pTByTfM7APDLYk8nvPHd?=
 =?us-ascii?Q?jSOxmNK9hP3koML3pm4cZarkt9eDU4/vB4ZVEGCfoSARvcZKnblF8mQbcaiq?=
 =?us-ascii?Q?gteEyQ9cqP7sm33gnKuE8OKPvVhNff0POFp1gT9qTs2LVdmgXy54+f2K/Lb4?=
 =?us-ascii?Q?vXjM45l2sdJjRytDG6vEdGgXrzqT6ynDx6Wg9Q8uqkPwYQI/ElLiO4zMtPih?=
 =?us-ascii?Q?jl8/K/LuOoqJdb5Fec5+W8J1bZriLMHrYC7u2vXtJbFqdaxdtktNHjRtHZ09?=
 =?us-ascii?Q?Yf784eR3sXWbnk6LPX9XBRyNCT4XIM3HqzLZQfMsiOZGZ0+o/4pfn59XNA+/?=
 =?us-ascii?Q?vhhFoDPPsXsfUQGHUHXAeVgvZYO+3uheYXIv78WkPMQ/YxH+HS+QzWbCn3hy?=
 =?us-ascii?Q?P0zQeJXOnzCNcboO6RQ2mzUXF5oV5lidFQZiQvYi6lgjdVE269nXcV7AbUAS?=
 =?us-ascii?Q?IlSVwRrigTTlliQyt/Fyt794wj+5lC0z+kBY55TSfEiWz2w+P1v+d8eJfARf?=
 =?us-ascii?Q?HRYQRzq+5TebRYW9U/2vD8dtAF6dC3cI92islO86sqo9X67MC5i/TLC4vQpk?=
 =?us-ascii?Q?TP3ZaVXCsamNOO1uTR/IGS4p6Hz2qThdDET5uA8MfzyWIzkDUMi9B/Od8Sux?=
 =?us-ascii?Q?5mXdGdChvTnMuAePYqJ0oUzghNdZXOxGyfjTfZ1DTTtNKo6GjQztR8c+9HM3?=
 =?us-ascii?Q?jOizHGFEdJn/nznNl2Z/O7KAsCl1oZ14SvjP55hhEY6i960YvoXoT3pDshxL?=
 =?us-ascii?Q?fJZI7JRrnvW2IA9VoxW7F7oCt1j9Ag6z/AKGmhoSjAj4HrPyt+XPkI1LTFQN?=
 =?us-ascii?Q?QjYXjMF4zKANAHBEhpjuTo45yX7sV6dPpLk/hYgsGStDGnJNFA5zFn8eezlh?=
 =?us-ascii?Q?pNKd+AtFBEjWdorqUPK5phPRLKkJvDwogipV67PJCbaPv672NE/anZvSggee?=
 =?us-ascii?Q?W7BZSXkQ7Svfy1nB9srNUWgm6NIsJrD3WNj84x8w1P5uj8Ain15E1b2YXJ/x?=
 =?us-ascii?Q?bd+qRVdBrU+yJKX6XE1GiIzq1+a2KqKpgEQkwij/2za7PhUQRIoQJAEib10+?=
 =?us-ascii?Q?iuuJxtIbU6qL2LEZIPnfdwcpFldLUvpABfkreGuYBRaeheV+sAGlQOBYxLBV?=
 =?us-ascii?Q?W1sQP0inmEqYSEGy3UgLgayImO3Uo8PMaE84ygPqubdYbqvHhmHqCkrPb7NW?=
 =?us-ascii?Q?Q0+48TSG6vDiKbehaCY8xwnKhaF8G/724fGCtS8lQdlwxEMNkHyutXs5cFzo?=
 =?us-ascii?Q?CbxggXGSeUTApqGpSRVtyN6Har+7WLReSkjyFwKaj+sbz99/3zeZP55HkLxB?=
 =?us-ascii?Q?qD5lJnp405SArw9UEhJqGPE1fpTTbN27ZF257uYbUTdb5cqDnZHrNDHW2na7?=
 =?us-ascii?Q?7cMaLYimyJTQJ7WAeXHqclcVO4gTaRs0K5DkHG4Ra6uawQPR7Th0B+J58NRb?=
 =?us-ascii?Q?i0KZ27mOOZN4zv1+uPQLKyIFROE9/O8AVuaIbE/ZLZCDv5yXHRXKbTpJG/p0?=
 =?us-ascii?Q?KaQC6IQmhe+eWyrIFne4Sq2nW/OfPIOyb5c68fuBwJlt+BK5zT/mLELzHod/?=
 =?us-ascii?Q?BRpkav7siGRn/kpLOfH21iYKNWIQFFQLhBN9+6Xxz7KD+mdDIDuzen6pZp0c?=
 =?us-ascii?Q?u8PMqT7Tg0kz026nmpcdDVkik0PXTYJP82weiyByZ3QuqyrFLMsbfmS1N6Tx?=
 =?us-ascii?Q?+t4DlQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	J/S9W88fobQZShFq7uW6FhuQTN4s5eZlNXAQlM+xLfs+Lyutgr2pGv/ZPFok6+RBUCMTAqQR9O7EPHaAuMwcH8OJatLI96kWYmUmNYGatVy3Ac2y6q8Rw1dVn/XBUdu3qLra7tmHldovTsDy3GXw2NpSokebRPXsm4yKUtgIlh9cpoGLKBFkrYUyE+o2OEznJ2HGtzzpxFdhfQifFEbVZVqSI5LYRa2pnfQ4nHGUwA+k5lYAYyzX+KvlOVooaBNiKTtqY3v4Y9EdnS8MjPNfl1qBVP1CKuZS45mYlv4qt8WY9g5GAmDYNvLehuNbjqYGeHhKpnlRAjOpSYUVXuDc7JAVOV8vd4UHRBCkNR9/TaFMOuGi3kJHKqaII6faT+UMSuV8vgoCyce6gpTbUZFBjjWCaiDL+8QmwlWJ0XvBBATDOV8mBnvJTsm8L3tfza9HBzrRinLOrneK7nr4h5t0hjW7B5flmMdrx57k9aLYG6XCgDLQigUIkZSKPhu7NYYnapvAZ3vvAy22zEMqfH/K6Z6ku/HGAZMWLXMouXRh3J1EnRgCvATjHFYC9JVwCVk5cR8hdBJ3B2xMWV8R18twwkBN2gpfq9fyHcIVLIVNvDk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b0fad8e-7582-424d-4eda-08dcb5482d75
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 12:14:38.7685
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H1BjCsDASO0fg12oSLQ2QDpqMMwjylLANA+OywGCwZnLcQEeguCIYU2SAilW6ZjAawKUgcCDmH4ggwGdyjAHVdcBEFdEVmfWAl33K4Ttwyo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7760
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-05_01,2024-08-02_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408050088
X-Proofpoint-ORIG-GUID: H6T1aqxQyXBKgzCW0UgupLC8pPswydHx
X-Proofpoint-GUID: H6T1aqxQyXBKgzCW0UgupLC8pPswydHx

In mmap_region() and do_brk_flags() we open code scenarios where we prefer
to use vma_expand() rather than invoke a full vma_merge() operation.

Abstract this logic and eliminate all of the open-coding, and also use the
same logic for all cases where we add new VMAs to, rather than ultimately
use vma_merge(), rather use vma_expand().

We implement this by replacing vma_merge_new_vma() with this newly
abstracted logic.

Doing so removes duplication and simplifies VMA merging in all such cases,
laying the ground for us to eliminate the merging of new VMAs in
vma_merge() altogether.

This makes it far easier to understand what is happening in these cases
avoiding confusion, bugs and allowing for future optimisation.

As a result of this change we are also able to make vma_prepare(),
init_vma_prep(), vma_complete(), can_vma_merge_before() and
can_vma_merge_after() static and internal to vma.c.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/mmap.c                        |  79 ++---
 mm/vma.c                         | 482 +++++++++++++++++++------------
 mm/vma.h                         |  51 +---
 tools/testing/vma/vma_internal.h |   6 +
 4 files changed, 324 insertions(+), 294 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index f6593a81f73d..c03f50f46396 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1363,8 +1363,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 {
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma = NULL;
-	struct vm_area_struct *next, *prev, *merge;
-	pgoff_t pglen = len >> PAGE_SHIFT;
+	struct vm_area_struct *merge;
 	unsigned long charged = 0;
 	unsigned long end = addr + len;
 	bool writable_file_mapping = false;
@@ -1411,44 +1410,9 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		vm_flags |= VM_ACCOUNT;
 	}
 
-	next = vmg.next = vma_next(&vmi);
-	prev = vmg.prev = vma_prev(&vmi);
-	if (vm_flags & VM_SPECIAL) {
-		if (prev)
-			vma_iter_next_range(&vmi);
-		goto cannot_expand;
-	}
-
-	/* Attempt to expand an old mapping */
-	/* Check next */
-	if (next && next->vm_start == end && can_vma_merge_before(&vmg)) {
-		/* We can adjust this as can_vma_merge_after() doesn't touch */
-		vmg.end = next->vm_end;
-		vma = vmg.vma = next;
-		vmg.pgoff = next->vm_pgoff - pglen;
-
-		/* We may merge our NULL anon_vma with non-NULL in next. */
-		vmg.anon_vma = vma->anon_vma;
-	}
-
-	/* Check prev */
-	if (prev && prev->vm_end == addr && can_vma_merge_after(&vmg)) {
-		vmg.start = prev->vm_start;
-		vma = vmg.vma = prev;
-		vmg.pgoff = prev->vm_pgoff;
-	} else if (prev) {
-		vma_iter_next_range(&vmi);
-	}
-
-	/* Actually expand, if possible */
-	if (vma && !vma_expand(&vmg)) {
-		khugepaged_enter_vma(vma, vm_flags);
+	vma = vma_merge_new_vma(&vmg);
+	if (vma)
 		goto expanded;
-	}
-
-	if (vma == prev)
-		vma_iter_set(&vmi, addr);
-cannot_expand:
 
 	/*
 	 * Determine the object being mapped and call the appropriate
@@ -1493,10 +1457,9 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		 * If vm_flags changed after call_mmap(), we should try merge
 		 * vma again as we may succeed this time.
 		 */
-		if (unlikely(vm_flags != vma->vm_flags && prev)) {
-			merge = vma_merge_new_vma_wrapper(&vmi, prev, vma,
-							  vma->vm_start, vma->vm_end,
-							  vma->vm_pgoff);
+		if (unlikely(vm_flags != vma->vm_flags && vmg.prev)) {
+			merge = vma_merge_new_vma(&vmg);
+
 			if (merge) {
 				/*
 				 * ->mmap() can change vma->vm_file and fput
@@ -1596,7 +1559,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 
 		vma_iter_set(&vmi, vma->vm_end);
 		/* Undo any partial mapping done by a device driver. */
-		unmap_region(mm, &vmi.mas, vma, prev, next, vma->vm_start,
+		unmap_region(mm, &vmi.mas, vma, vmg.prev, vmg.next, vma->vm_start,
 			     vma->vm_end, vma->vm_end, true);
 	}
 	if (writable_file_mapping)
@@ -1773,7 +1736,6 @@ static int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		unsigned long addr, unsigned long len, unsigned long flags)
 {
 	struct mm_struct *mm = current->mm;
-	struct vma_prepare vp;
 
 	/*
 	 * Check against address space limits by the changed size
@@ -1795,29 +1757,22 @@ static int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	 */
 	if (vma && vma->vm_end == addr) {
 		struct vma_merge_struct vmg = {
+			.vmi = vmi,
 			.prev = vma,
+			.next = NULL,
+			.start = addr,
+			.end = addr + len,
 			.flags = flags,
 			.pgoff = addr >> PAGE_SHIFT,
+			.file = vma->vm_file,
+			.anon_vma = vma->anon_vma,
+			.policy = vma_policy(vma),
+			.uffd_ctx = vma->vm_userfaultfd_ctx,
+			.anon_name = anon_vma_name(vma),
 		};
 
-		if (can_vma_merge_after(&vmg)) {
-			vma_iter_config(vmi, vma->vm_start, addr + len);
-			if (vma_iter_prealloc(vmi, vma))
-				goto unacct_fail;
-
-			vma_start_write(vma);
-
-			init_vma_prep(&vp, vma);
-			vma_prepare(&vp);
-			vma_adjust_trans_huge(vma, vma->vm_start, addr + len, 0);
-			vma->vm_end = addr + len;
-			vm_flags_set(vma, VM_SOFTDIRTY);
-			vma_iter_store(vmi, vma);
-
-			vma_complete(&vp, vmi, mm);
-			khugepaged_enter_vma(vma, flags);
+		if (vma_merge_new_vma(&vmg))
 			goto out;
-		}
 	}
 
 	if (vma)
diff --git a/mm/vma.c b/mm/vma.c
index 55615392e8d2..a404cf718f9e 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -97,8 +97,7 @@ static void init_multi_vma_prep(struct vma_prepare *vp,
  *
  * We assume the vma may be removed as part of the merge.
  */
-bool
-can_vma_merge_before(struct vma_merge_struct *vmg)
+static bool can_vma_merge_before(struct vma_merge_struct *vmg)
 {
 	pgoff_t pglen = PHYS_PFN(vmg->end - vmg->start);
 
@@ -120,7 +119,7 @@ can_vma_merge_before(struct vma_merge_struct *vmg)
  *
  * We assume that vma is not removed as part of the merge.
  */
-bool can_vma_merge_after(struct vma_merge_struct *vmg)
+static bool can_vma_merge_after(struct vma_merge_struct *vmg)
 {
 	if (is_mergeable_vma(vmg, false) &&
 	    is_mergeable_anon_vma(vmg->anon_vma, vmg->prev->anon_vma, vmg->prev)) {
@@ -130,6 +129,164 @@ bool can_vma_merge_after(struct vma_merge_struct *vmg)
 	return false;
 }
 
+static void __vma_link_file(struct vm_area_struct *vma,
+			    struct address_space *mapping)
+{
+	if (vma_is_shared_maywrite(vma))
+		mapping_allow_writable(mapping);
+
+	flush_dcache_mmap_lock(mapping);
+	vma_interval_tree_insert(vma, &mapping->i_mmap);
+	flush_dcache_mmap_unlock(mapping);
+}
+
+/*
+ * Requires inode->i_mapping->i_mmap_rwsem
+ */
+static void __remove_shared_vm_struct(struct vm_area_struct *vma,
+				      struct address_space *mapping)
+{
+	if (vma_is_shared_maywrite(vma))
+		mapping_unmap_writable(mapping);
+
+	flush_dcache_mmap_lock(mapping);
+	vma_interval_tree_remove(vma, &mapping->i_mmap);
+	flush_dcache_mmap_unlock(mapping);
+}
+
+/*
+ * vma_prepare() - Helper function for handling locking VMAs prior to altering
+ * @vp: The initialized vma_prepare struct
+ */
+static void vma_prepare(struct vma_prepare *vp)
+{
+	if (vp->file) {
+		uprobe_munmap(vp->vma, vp->vma->vm_start, vp->vma->vm_end);
+
+		if (vp->adj_next)
+			uprobe_munmap(vp->adj_next, vp->adj_next->vm_start,
+				      vp->adj_next->vm_end);
+
+		i_mmap_lock_write(vp->mapping);
+		if (vp->insert && vp->insert->vm_file) {
+			/*
+			 * Put into interval tree now, so instantiated pages
+			 * are visible to arm/parisc __flush_dcache_page
+			 * throughout; but we cannot insert into address
+			 * space until vma start or end is updated.
+			 */
+			__vma_link_file(vp->insert,
+					vp->insert->vm_file->f_mapping);
+		}
+	}
+
+	if (vp->anon_vma) {
+		anon_vma_lock_write(vp->anon_vma);
+		anon_vma_interval_tree_pre_update_vma(vp->vma);
+		if (vp->adj_next)
+			anon_vma_interval_tree_pre_update_vma(vp->adj_next);
+	}
+
+	if (vp->file) {
+		flush_dcache_mmap_lock(vp->mapping);
+		vma_interval_tree_remove(vp->vma, &vp->mapping->i_mmap);
+		if (vp->adj_next)
+			vma_interval_tree_remove(vp->adj_next,
+						 &vp->mapping->i_mmap);
+	}
+
+}
+
+/*
+ * vma_complete- Helper function for handling the unlocking after altering VMAs,
+ * or for inserting a VMA.
+ *
+ * @vp: The vma_prepare struct
+ * @vmi: The vma iterator
+ * @mm: The mm_struct
+ */
+static void vma_complete(struct vma_prepare *vp,
+			 struct vma_iterator *vmi, struct mm_struct *mm)
+{
+	if (vp->file) {
+		if (vp->adj_next)
+			vma_interval_tree_insert(vp->adj_next,
+						 &vp->mapping->i_mmap);
+		vma_interval_tree_insert(vp->vma, &vp->mapping->i_mmap);
+		flush_dcache_mmap_unlock(vp->mapping);
+	}
+
+	if (vp->remove && vp->file) {
+		__remove_shared_vm_struct(vp->remove, vp->mapping);
+		if (vp->remove2)
+			__remove_shared_vm_struct(vp->remove2, vp->mapping);
+	} else if (vp->insert) {
+		/*
+		 * split_vma has split insert from vma, and needs
+		 * us to insert it before dropping the locks
+		 * (it may either follow vma or precede it).
+		 */
+		vma_iter_store(vmi, vp->insert);
+		mm->map_count++;
+	}
+
+	if (vp->anon_vma) {
+		anon_vma_interval_tree_post_update_vma(vp->vma);
+		if (vp->adj_next)
+			anon_vma_interval_tree_post_update_vma(vp->adj_next);
+		anon_vma_unlock_write(vp->anon_vma);
+	}
+
+	if (vp->file) {
+		i_mmap_unlock_write(vp->mapping);
+		uprobe_mmap(vp->vma);
+
+		if (vp->adj_next)
+			uprobe_mmap(vp->adj_next);
+	}
+
+	if (vp->remove) {
+again:
+		vma_mark_detached(vp->remove, true);
+		if (vp->file) {
+			uprobe_munmap(vp->remove, vp->remove->vm_start,
+				      vp->remove->vm_end);
+			fput(vp->file);
+		}
+		if (vp->remove->anon_vma)
+			anon_vma_merge(vp->vma, vp->remove);
+		mm->map_count--;
+		mpol_put(vma_policy(vp->remove));
+		if (!vp->remove2)
+			WARN_ON_ONCE(vp->vma->vm_end < vp->remove->vm_end);
+		vm_area_free(vp->remove);
+
+		/*
+		 * In mprotect's case 6 (see comments on vma_merge),
+		 * we are removing both mid and next vmas
+		 */
+		if (vp->remove2) {
+			vp->remove = vp->remove2;
+			vp->remove2 = NULL;
+			goto again;
+		}
+	}
+	if (vp->insert && vp->file)
+		uprobe_mmap(vp->insert);
+	validate_mm(mm);
+}
+
+/*
+ * init_vma_prep() - Initializer wrapper for vma_prepare struct
+ * @vp: The vma_prepare struct
+ * @vma: The vma that will be altered once locked
+ */
+static void init_vma_prep(struct vma_prepare *vp,
+			  struct vm_area_struct *vma)
+{
+	init_multi_vma_prep(vp, vma, NULL, NULL, NULL);
+}
+
 /*
  * Close a vm structure and free it.
  */
@@ -292,31 +449,6 @@ static inline void remove_mt(struct mm_struct *mm, struct ma_state *mas)
 	vm_unacct_memory(nr_accounted);
 }
 
-/*
- * init_vma_prep() - Initializer wrapper for vma_prepare struct
- * @vp: The vma_prepare struct
- * @vma: The vma that will be altered once locked
- */
-void init_vma_prep(struct vma_prepare *vp,
-		   struct vm_area_struct *vma)
-{
-	init_multi_vma_prep(vp, vma, NULL, NULL, NULL);
-}
-
-/*
- * Requires inode->i_mapping->i_mmap_rwsem
- */
-static void __remove_shared_vm_struct(struct vm_area_struct *vma,
-				      struct address_space *mapping)
-{
-	if (vma_is_shared_maywrite(vma))
-		mapping_unmap_writable(mapping);
-
-	flush_dcache_mmap_lock(mapping);
-	vma_interval_tree_remove(vma, &mapping->i_mmap);
-	flush_dcache_mmap_unlock(mapping);
-}
-
 /*
  * vma has some anon_vma assigned, and is already inserted on that
  * anon_vma's interval trees.
@@ -349,60 +481,6 @@ anon_vma_interval_tree_post_update_vma(struct vm_area_struct *vma)
 		anon_vma_interval_tree_insert(avc, &avc->anon_vma->rb_root);
 }
 
-static void __vma_link_file(struct vm_area_struct *vma,
-			    struct address_space *mapping)
-{
-	if (vma_is_shared_maywrite(vma))
-		mapping_allow_writable(mapping);
-
-	flush_dcache_mmap_lock(mapping);
-	vma_interval_tree_insert(vma, &mapping->i_mmap);
-	flush_dcache_mmap_unlock(mapping);
-}
-
-/*
- * vma_prepare() - Helper function for handling locking VMAs prior to altering
- * @vp: The initialized vma_prepare struct
- */
-void vma_prepare(struct vma_prepare *vp)
-{
-	if (vp->file) {
-		uprobe_munmap(vp->vma, vp->vma->vm_start, vp->vma->vm_end);
-
-		if (vp->adj_next)
-			uprobe_munmap(vp->adj_next, vp->adj_next->vm_start,
-				      vp->adj_next->vm_end);
-
-		i_mmap_lock_write(vp->mapping);
-		if (vp->insert && vp->insert->vm_file) {
-			/*
-			 * Put into interval tree now, so instantiated pages
-			 * are visible to arm/parisc __flush_dcache_page
-			 * throughout; but we cannot insert into address
-			 * space until vma start or end is updated.
-			 */
-			__vma_link_file(vp->insert,
-					vp->insert->vm_file->f_mapping);
-		}
-	}
-
-	if (vp->anon_vma) {
-		anon_vma_lock_write(vp->anon_vma);
-		anon_vma_interval_tree_pre_update_vma(vp->vma);
-		if (vp->adj_next)
-			anon_vma_interval_tree_pre_update_vma(vp->adj_next);
-	}
-
-	if (vp->file) {
-		flush_dcache_mmap_lock(vp->mapping);
-		vma_interval_tree_remove(vp->vma, &vp->mapping->i_mmap);
-		if (vp->adj_next)
-			vma_interval_tree_remove(vp->adj_next,
-						 &vp->mapping->i_mmap);
-	}
-
-}
-
 /*
  * dup_anon_vma() - Helper function to duplicate anon_vma
  * @dst: The destination VMA
@@ -486,6 +564,120 @@ void validate_mm(struct mm_struct *mm)
 }
 #endif /* CONFIG_DEBUG_VM_MAPLE_TREE */
 
+/*
+ * vma_merge_new_vma - Attempt to merge a new VMA into address space
+ *
+ * @vmg: Describes the VMA we are adding, in the range @vmg->start to @vmg->end
+ *       (exclusive), which we try to merge with any adjacent VMAs if possible.
+ *
+ * We are about to add a VMA to the address space starting at @vmg->start and
+ * ending at @vmg->end. There are three different possible scenarios:
+ *
+ * 1. There is a VMA with identical properties immediately adjacent to the
+ *    proposed new VMA [@vmg->start, @vmg->end) either before or after it -
+ *    EXPAND that VMA:
+ *
+ * Proposed:       |-----|  or  |-----|
+ * Existing:  |----|                  |----|
+ *
+ * 2. There are VMAs with identical properties immediately adjacent to the
+ *    proposed new VMA [@vmg->start, @vmg->end) both before AND after it -
+ *    EXPAND the former and REMOVE the latter:
+ *
+ * Proposed:       |-----|
+ * Existing:  |----|     |----|
+ *
+ * 3. There are no VMAs immediately adjacent to the proposed new VMA or those
+ *    VMAs do not have identical attributes - NO MERGE POSSIBLE.
+ *
+ * In instances where we can merge, this function returns the expanded VMA which
+ * will have its range adjusted accordingly and the underlying maple tree also
+ * adjusted.
+ *
+ * Returns: In instances where no merge was possible, NULL. Otherwise, a pointer
+ *          to the VMA we expanded.
+ *
+ * This function also adjusts @vmg to provide @vmg->prev and @vmg->next if
+ * neither already specified, and adjusts [@vmg->start, @vmg->end) to span the
+ * expanded range.
+ *
+ * ASSUMPTIONS:
+ * - The caller must hold a WRITE lock on the mm_struct->mmap_lock.
+ * - The caller must have determined that [@vmg->start, @vmg->end) is empty.
+ */
+struct vm_area_struct *vma_merge_new_vma(struct vma_merge_struct *vmg)
+{
+	bool is_special = vmg->flags & VM_SPECIAL;
+	struct vm_area_struct *prev = vmg->prev;
+	struct vm_area_struct *next = vmg->next;
+	unsigned long start = vmg->start;
+	unsigned long end = vmg->end;
+	pgoff_t pgoff = vmg->pgoff;
+	pgoff_t pglen = PHYS_PFN(end - start);
+
+	VM_WARN_ON(vmg->vma);
+
+	if (!prev && !next) {
+		/*
+		 * Since the caller must have determined that the requested
+		 * range is empty, vmg->vmi will be left pointing at the VMA
+		 * immediately prior.
+		 */
+		next = vmg->next = vma_next(vmg->vmi);
+		prev = vmg->prev = vma_prev(vmg->vmi);
+
+		/* Avoid maple tree re-walk. */
+		if (is_special && prev)
+			vma_iter_next_range(vmg->vmi);
+	}
+
+	/* If special mapping or no adjacent VMAs, nothing to merge. */
+	if (is_special || (!prev && !next))
+		return NULL;
+
+	/* If we can merge with the following VMA, adjust vmg accordingly. */
+	if (next && next->vm_start == end && can_vma_merge_before(vmg)) {
+		/*
+		 * We can adjust this here as can_vma_merge_after() doesn't
+		 * touch vmg->end.
+		 */
+		vmg->end = next->vm_end;
+		vmg->vma = next;
+		vmg->pgoff = next->vm_pgoff - pglen;
+
+		vmg->anon_vma = next->anon_vma;
+	}
+
+	/* If we can merge with the previous VMA, adjust vmg accordingly. */
+	if (prev && prev->vm_end == start && can_vma_merge_after(vmg)) {
+		vmg->start = prev->vm_start;
+		vmg->vma = prev;
+		vmg->pgoff = prev->vm_pgoff;
+	} else if (prev) {
+		vma_iter_next_range(vmg->vmi);
+	}
+
+	/*
+	 * Now try to expand adjacent VMA(s). This takes care of removing the
+	 * following VMA if we have VMAs on both sides.
+	 */
+	if (vmg->vma && !vma_expand(vmg)) {
+		khugepaged_enter_vma(vmg->vma, vmg->flags);
+		return vmg->vma;
+	}
+
+	/* If expansion failed, reset state. Allows us to retry merge later. */
+	vmg->vma = NULL;
+	vmg->anon_vma = NULL;
+	vmg->start = start;
+	vmg->end = end;
+	vmg->pgoff = pgoff;
+	if (vmg->vma == prev)
+		vma_iter_set(vmg->vmi, start);
+
+	return NULL;
+}
+
 /*
  * vma_expand - Expand an existing VMA
  *
@@ -496,7 +688,11 @@ void validate_mm(struct mm_struct *mm)
  * vmg->next->vm_end.  Checking if the vmg->vma can expand and merge with
  * vmg->next needs to be handled by the caller.
  *
- * Returns: 0 on success
+ * Returns: 0 on success.
+ *
+ * ASSUMPTIONS:
+ * - The caller must hold a WRITE lock on vmg->vma->mm->mmap_lock.
+ * - The caller must have set @vmg->prev and @vmg->next.
  */
 int vma_expand(struct vma_merge_struct *vmg)
 {
@@ -576,85 +772,6 @@ int vma_shrink(struct vma_merge_struct *vmg)
 	return 0;
 }
 
-/*
- * vma_complete- Helper function for handling the unlocking after altering VMAs,
- * or for inserting a VMA.
- *
- * @vp: The vma_prepare struct
- * @vmi: The vma iterator
- * @mm: The mm_struct
- */
-void vma_complete(struct vma_prepare *vp,
-		  struct vma_iterator *vmi, struct mm_struct *mm)
-{
-	if (vp->file) {
-		if (vp->adj_next)
-			vma_interval_tree_insert(vp->adj_next,
-						 &vp->mapping->i_mmap);
-		vma_interval_tree_insert(vp->vma, &vp->mapping->i_mmap);
-		flush_dcache_mmap_unlock(vp->mapping);
-	}
-
-	if (vp->remove && vp->file) {
-		__remove_shared_vm_struct(vp->remove, vp->mapping);
-		if (vp->remove2)
-			__remove_shared_vm_struct(vp->remove2, vp->mapping);
-	} else if (vp->insert) {
-		/*
-		 * split_vma has split insert from vma, and needs
-		 * us to insert it before dropping the locks
-		 * (it may either follow vma or precede it).
-		 */
-		vma_iter_store(vmi, vp->insert);
-		mm->map_count++;
-	}
-
-	if (vp->anon_vma) {
-		anon_vma_interval_tree_post_update_vma(vp->vma);
-		if (vp->adj_next)
-			anon_vma_interval_tree_post_update_vma(vp->adj_next);
-		anon_vma_unlock_write(vp->anon_vma);
-	}
-
-	if (vp->file) {
-		i_mmap_unlock_write(vp->mapping);
-		uprobe_mmap(vp->vma);
-
-		if (vp->adj_next)
-			uprobe_mmap(vp->adj_next);
-	}
-
-	if (vp->remove) {
-again:
-		vma_mark_detached(vp->remove, true);
-		if (vp->file) {
-			uprobe_munmap(vp->remove, vp->remove->vm_start,
-				      vp->remove->vm_end);
-			fput(vp->file);
-		}
-		if (vp->remove->anon_vma)
-			anon_vma_merge(vp->vma, vp->remove);
-		mm->map_count--;
-		mpol_put(vma_policy(vp->remove));
-		if (!vp->remove2)
-			WARN_ON_ONCE(vp->vma->vm_end < vp->remove->vm_end);
-		vm_area_free(vp->remove);
-
-		/*
-		 * In mprotect's case 6 (see comments on vma_merge),
-		 * we are removing both mid and next vmas
-		 */
-		if (vp->remove2) {
-			vp->remove = vp->remove2;
-			vp->remove2 = NULL;
-			goto again;
-		}
-	}
-	if (vp->insert && vp->file)
-		uprobe_mmap(vp->insert);
-	validate_mm(mm);
-}
-
 /*
  * do_vmi_align_munmap() - munmap the aligned region from @start to @end.
  * @vmi: The vma iterator
@@ -1261,20 +1378,6 @@ struct vm_area_struct
 	return vma_modify(&vmg);
 }
 
-/*
- * Attempt to merge a newly mapped VMA with those adjacent to it. The caller
- * must ensure that [start, end) does not overlap any existing VMA.
- */
-struct vm_area_struct *vma_merge_new_vma(struct vma_merge_struct *vmg)
-{
-	if (!vmg->prev) {
-		vmg->prev = vma_prev(vmg->vmi);
-		vma_iter_set(vmg->vmi, vmg->start);
-	}
-
-	return vma_merge(vmg);
-}
-
 /*
  * Expand vma by delta bytes, potentially merging with an immediately adjacent
  * VMA with identical properties.
@@ -1297,8 +1400,7 @@ struct vm_area_struct *vma_merge_extend(struct vma_iterator *vmi,
 		.anon_name = anon_vma_name(vma),
 	};
 
-	/* vma is specified as prev, so case 1 or 2 will apply. */
-	return vma_merge(&vmg);
+	return vma_merge_new_vma(&vmg);
 }
 
 void unlink_file_vma_batch_init(struct unlink_vma_file_batch *vb)
@@ -1399,24 +1501,40 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 	struct vm_area_struct *vma = *vmap;
 	unsigned long vma_start = vma->vm_start;
 	struct mm_struct *mm = vma->vm_mm;
-	struct vm_area_struct *new_vma, *prev;
+	struct vm_area_struct *new_vma;
 	bool faulted_in_anon_vma = true;
 	VMA_ITERATOR(vmi, mm, addr);
+	struct vma_merge_struct vmg = {
+		.vmi = &vmi,
+		.start = addr,
+		.end = addr + len,
+		.flags = vma->vm_flags,
+		.pgoff = pgoff,
+		.file = vma->vm_file,
+		.anon_vma = vma->anon_vma,
+		.policy = vma_policy(vma),
+		.uffd_ctx = vma->vm_userfaultfd_ctx,
+		.anon_name = anon_vma_name(vma),
+	};
 
 	/*
 	 * If anonymous vma has not yet been faulted, update new pgoff
 	 * to match new location, to increase its chance of merging.
 	 */
 	if (unlikely(vma_is_anonymous(vma) && !vma->anon_vma)) {
-		pgoff = addr >> PAGE_SHIFT;
+		pgoff = vmg.pgoff = addr >> PAGE_SHIFT;
 		faulted_in_anon_vma = false;
 	}
 
-	new_vma = find_vma_prev(mm, addr, &prev);
+	new_vma = find_vma_prev(mm, addr, &vmg.prev);
 	if (new_vma && new_vma->vm_start < addr + len)
 		return NULL;	/* should never get here */
 
-	new_vma = vma_merge_new_vma_wrapper(&vmi, prev, vma, addr, addr + len, pgoff);
+	vmg.next = vma_next(&vmi);
+	vma_prev(&vmi);
+
+	new_vma = vma_merge_new_vma(&vmg);
+
 	if (new_vma) {
 		/*
 		 * Source vma may have been merged into new_vma
diff --git a/mm/vma.h b/mm/vma.h
index 50459f9e4c7f..bbb173053f34 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -55,17 +55,6 @@ void anon_vma_interval_tree_pre_update_vma(struct vm_area_struct *vma);
 /* Required for expand_downwards(). */
 void anon_vma_interval_tree_post_update_vma(struct vm_area_struct *vma);
 
-/* Required for do_brk_flags(). */
-void vma_prepare(struct vma_prepare *vp);
-
-/* Required for do_brk_flags(). */
-void init_vma_prep(struct vma_prepare *vp,
-		   struct vm_area_struct *vma);
-
-/* Required for do_brk_flags(). */
-void vma_complete(struct vma_prepare *vp,
-		  struct vma_iterator *vmi, struct mm_struct *mm);
-
 int vma_expand(struct vma_merge_struct *vmg);
 int vma_shrink(struct vma_merge_struct *vmg);
 
@@ -85,20 +74,6 @@ void unmap_region(struct mm_struct *mm, struct ma_state *mas,
 		struct vm_area_struct *next, unsigned long start,
 		unsigned long end, unsigned long tree_end, bool mm_wr_locked);
 
-/*
- * Can we merge the VMA described by vmg into the following VMA vmg->next?
- *
- * Required by mmap_region().
- */
-bool can_vma_merge_before(struct vma_merge_struct *vmg);
-
-/*
- * Can we merge the VMA described by vmg into the preceding VMA vmg->prev?
- *
- * Required by mmap_region() and do_brk_flags().
- */
-bool can_vma_merge_after(struct vma_merge_struct *vmg);
-
 /* We are about to modify the VMA's flags. */
 struct vm_area_struct *vma_modify_flags(struct vma_iterator *vmi,
 					struct vm_area_struct *prev,
@@ -133,31 +108,7 @@ struct vm_area_struct
 		       unsigned long new_flags,
 		       struct vm_userfaultfd_ctx new_ctx);
 
-struct vm_area_struct
-*vma_merge_new_vma(struct vma_merge_struct *vmg);
-
-/* Temporary convenience wrapper. */
-static inline struct vm_area_struct
-*vma_merge_new_vma_wrapper(struct vma_iterator *vmi, struct vm_area_struct *prev,
-			   struct vm_area_struct *vma, unsigned long start,
-			   unsigned long end, pgoff_t pgoff)
-{
-	struct vma_merge_struct vmg = {
-		.vmi = vmi,
-		.prev = prev,
-		.start = start,
-		.end = end,
-		.flags = vma->vm_flags,
-		.file = vma->vm_file,
-		.anon_vma = vma->anon_vma,
-		.pgoff = pgoff,
-		.policy = vma_policy(vma),
-		.uffd_ctx = vma->vm_userfaultfd_ctx,
-		.anon_name = anon_vma_name(vma),
-	};
-
-	return vma_merge_new_vma(&vmg);
-}
+struct vm_area_struct *vma_merge_new_vma(struct vma_merge_struct *vmg);
 
 /*
  * Temporary wrapper around vma_merge() so we can have a common interface for
diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
index 40797a819d3d..a39a734282d0 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -709,6 +709,12 @@ static inline void vma_iter_free(struct vma_iterator *vmi)
 	mas_destroy(&vmi->mas);
 }
 
+static inline
+struct vm_area_struct *vma_iter_next_range(struct vma_iterator *vmi)
+{
+	return mas_next_range(&vmi->mas, ULONG_MAX);
+}
+
 static inline void vm_acct_memory(long pages)
 {
 }
-- 
2.45.2


