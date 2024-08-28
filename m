Return-Path: <linux-kernel+bounces-305605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DAD963118
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 21:42:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C238F1F23CA9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 19:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B471ABEC3;
	Wed, 28 Aug 2024 19:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YC7IsVfo";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YabBiMPy"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D58F14A4D1
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 19:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724874153; cv=fail; b=mvv08iyU8C6oHFNTyF/ZEDt3jW4e8M83mxrGw2A0KlrnsZMLTSqnsn2xVYLGID9CKecWXjGegsjYmkmSu0MvC0Ylznvqm6jOQbZKaxpwOv+QyDuvjf+iJ9m98jS2IicddJHzn/jcYIxXgAgPtRp8Fgogiq/FU6DAXzdtlsQ3e9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724874153; c=relaxed/simple;
	bh=KHErRSkDlQYu98BE8YhTmfxc7CpFbxqWVgzVHuZs+1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Gj5Dp+Kvhfszj1ZT6XhxI2bLb9YzdXBguU1W/AjEU88ttbcSNAA0c/r6noEvoHkjLqrmwO9HA231gPYy2Ek3DILTbecltzpbgg6jD2tu7vgk/o+54qTjPOqAdlSxhVaqlZU0VUoiEj/vFw6O43iN1t7Kq5xQmhkA/duUyBUexZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YC7IsVfo; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YabBiMPy; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47SJYVT4009760;
	Wed, 28 Aug 2024 19:42:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=hOiOWaCXgqzzglm
	4J1iqr05VBlPJhoT6+cuTJvyt2Jo=; b=YC7IsVfodGw/oydhNR2qL5sO5zxMwbk
	EDSozTlPvk+KSox9qUGueV1lYiab8xLunbtn4R+FkhoMxXdPB/M8R3agYfz5mWdk
	os2xz3XuVfTEX4/72ilf1XBBdAdkApyJPmShBBXvWCvSH0lTkO7KiTg/+Rij+/xO
	7WxaLnAq0HwTEmCGnJe5sBEh51gKBmNYRovqRDXEoLIm4+HPJyiViOziVdm9fqMN
	3U55ZoRaaaa7I+BWmbiynUk8OBYY/oj7dtOngHw4gdjuBC78R/he68qi7IzhQ6f2
	EHtXFLpaJmlgFNUW/LZjhM+NWeQPx1Abaj14Zjt5oPUtLyCZRpkbCrQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 419pwv262q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Aug 2024 19:42:24 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47SItd6Y033070;
	Wed, 28 Aug 2024 19:42:23 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 418a0vrp3s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Aug 2024 19:42:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LsVQ7Wx0lpIY0N9rFpDL7XZmfCe8rofpQ+YpJp4mp/XlZmgTCX0MQ+2RV1px1Aqs7aMa+5rVRGTQlrvDME6KsSI3SHb7YnhffAG17fqmh+FijMsd2VqN8v/OsQRTtYykP/2G98wPsKocJU/iEiNYYzXeUQNwcKjmg6cJdJTjTrEiBNH3rJqCwGTYaq/i+uxYqQOYbZaGBUKbhDTwXISzbMC8UidCH/NgZpxqnPmLut2L2ISAREHVGeG8i/ttXpOFKUmDEBgLa8cZ/SUcFhA7xhBWE/VZIcbxzSN3fyatGQMcddoWbW9WoSperR4cCKe1S+drX1DasME/8orKsi8DWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hOiOWaCXgqzzglm4J1iqr05VBlPJhoT6+cuTJvyt2Jo=;
 b=FVm1K0yV108pKe2r5naaZLXz29zx82pxXXPWtVNztv0BQy6JJnS4msF2qEt/AJV0IA0wzlDWwyjSjRFayOfrptVmALYISgK9fwj/eNU7IjOLjfT7etmO80ooLvvyLvq786mcKfTdSLewEYvs9tgYCA5xROYBU9ACY0Kxumep0YjrLQh63pqinsPX5e5xf3jQK84vFjn5TwS7S4u4u9IOKVu/Pnv1b8/7Tvhs7Sb7OT2uUkOP8sXqa5lB9GA5wkZNVgaY155ROSTutz8ok1jrpvs0GFfc9N7I9aMZn69j49s8UmSy8FpMoFMuIyFml8gaPd7e3v9VxLW2hcuvzyyZEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hOiOWaCXgqzzglm4J1iqr05VBlPJhoT6+cuTJvyt2Jo=;
 b=YabBiMPypT0epCxMmiIe9/VKn9Bupt7l/Wkh5B3Jv+dvFZ4f1eh3/F0drk77QCnGFRJ0aSWysRox2ccxlq//oXB6eu8EC+o+/Qm+dTbLTnI6CUazjBTGpVOhS8r36x+3E7gaHzElEgO3NwD7ypfxKTYTXtHx1epXhLQ5U7JdMso=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by IA0PR10MB7183.namprd10.prod.outlook.com (2603:10b6:208:401::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.14; Wed, 28 Aug
 2024 19:42:20 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7918.012; Wed, 28 Aug 2024
 19:42:20 +0000
Date: Wed, 28 Aug 2024 15:42:18 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v2 04/10] mm: remove duplicated open-coded VMA policy
 check
Message-ID: <6dts7wb7wycm53st22aupcj6ilvl4gmsheq2hyhfcjkmbfysb6@wz7p3dretp4u>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>
References: <cover.1724441678.git.lorenzo.stoakes@oracle.com>
 <c0b2c70cf5c7a036c560d9ddba7b2904b84ab9ab.1724441678.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0b2c70cf5c7a036c560d9ddba7b2904b84ab9ab.1724441678.git.lorenzo.stoakes@oracle.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0044.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fe::19) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|IA0PR10MB7183:EE_
X-MS-Office365-Filtering-Correlation-Id: aa6d5ce0-ffc1-4ac1-92ad-08dcc79987ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DQeHdb4WwTE1khU+DUSVvDABct5F+cBuXICpuP1dgGidsod9ciP1b+JgdOAm?=
 =?us-ascii?Q?ROWyzKnpPhfRyXrJzSqIHYVvLFYUY6y9CUffRmXjSL7/zocjT1lW3egMqy9v?=
 =?us-ascii?Q?BI3evgLRI+zlYD9ivXiFYDyANW8EW2llq/uJGbztKgVY793NAw8DaJOxoHwI?=
 =?us-ascii?Q?lyPP+SRwIB1oiA27D+VOvMgS/dJ3oCEuvcmZ08f6pYpikaPWd2QzapPrKNZC?=
 =?us-ascii?Q?BODXG63nytsf91vyAiPX2LkYhXfNkinF9V0ossmOYIbdwU2d5SJ90ofLTony?=
 =?us-ascii?Q?Ly6d41+lb9UlxM1U9ItbpeTBstTebW0pr2zOpxEkLd4/ZkQoo+eKBhFqE+1N?=
 =?us-ascii?Q?n8FxW486xYiNs92+Q51Q59kEuVZKkQunhs37yAQ6v5AKag/5sbCh2VCGGOUW?=
 =?us-ascii?Q?dybym/54JM1FlYE2SHyoiFMFZFPnafjmwJ3+U0cpYlIebJaUVoN4IQ7Zrmtz?=
 =?us-ascii?Q?WhxcTGKl2cHDuIV8Ff5IeFGXT4tKY7Ngz/OMmEER4zwhI/qDeBKcDAReNzt7?=
 =?us-ascii?Q?sPeHVeaWqQgA9RV6+oYK5gElkBxwMMX+4FUyorKoV49lTtyWoj6J/m6knUSo?=
 =?us-ascii?Q?aBEKxOG8DyP+zVbodQi69u4LFd1tjzpdHNIOsv3GCqtZKLnosCa5iFxPo7dq?=
 =?us-ascii?Q?ftAWmjBW/7hfxKVueBmR6lXXBlyke7LCNRndCnAcEy1maTRx4Nqmitfb6QR/?=
 =?us-ascii?Q?WDbIkdCTxEpLGrrRbqk6eshGIZ/qKfJg7I3sOp8pUp0x0FB3i5bBPz4Gl5Bm?=
 =?us-ascii?Q?N8sznuEJz+QIbe0GK0nVCCMHdV4ai2t9CYD4qfLikLR5a31mURG6OhpbmWXN?=
 =?us-ascii?Q?gZ6NHYFTQWWfyZHu1ZT7BkzsHhVRA9QwoGwOTVQSxLKrytP4lKlWZvGaMRUv?=
 =?us-ascii?Q?iIW3yXxwvZftJzEQSi/scTYIVXRfuskBPYDs+NdjxECtLSNtcnkNAgH95+/0?=
 =?us-ascii?Q?ptJFMMu2y0uWjVvdWR+hjafPjq1LuQZ1rB+x/Bc0ItdkEfpEhxl3jdXiJojO?=
 =?us-ascii?Q?MAuQDmQKHPvyIHtF0vM7SOmWYDY2uSU21UzTKJrG+mnVno7Mc7VbOOtQSpDi?=
 =?us-ascii?Q?6qnHHHF+xYUZskIwecQu4L+rwrNvMCqcgABY4L+EEgL6MthhUpK9kyUVNNrm?=
 =?us-ascii?Q?UCy4bziDhyF+vUurKxcCejMsjZJsUDhgcVCoaJGQMnMBADpi3ukjGyvYOtwp?=
 =?us-ascii?Q?U547fzeM8EsqgNtf/YT2YgoB0iJZGPWZhFN3CiBS1NJMCTEAWoB6zOB0Fglz?=
 =?us-ascii?Q?+QYfZgZBKiEy0/Ihuhct3SJeZ/yMjFuJ9UZbnTn+KuWXVhDBYFhP0qYh3uYx?=
 =?us-ascii?Q?u9v/B5875MHe7psQUvJUd6bNna3Ecledp8Nsa4IETNdRmQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ImdfhynuAkTxRzDXKUmoFB+tejOkZCZmiwNbCWviHd8djIdlPoH3dljPwNk9?=
 =?us-ascii?Q?ZpYYQJiD20QkzOI4xqay4+LI9tm7Xkfyedq/6jOft8fATj3c2XrRNaX6Z0w+?=
 =?us-ascii?Q?9iA5fDO80Tp5DIW03S4JL8DGotTIK7TfilOdBNvzxXmWA/zt4Yt6UXMHi1SG?=
 =?us-ascii?Q?kwe0DuEvXUpzBtlBX4nHrwA8A4gOHjB4BPS4A4bDRGhhlYQPNCGqfDlZH9QW?=
 =?us-ascii?Q?ZUuzAU+2VYD8jFTaab2GCKE040ymrinT+9F4MD6whujCeF9gI5ziRp4rBsxY?=
 =?us-ascii?Q?1b4E3pGVaUPsuKEUCaLDQD9BReQvrnxE6RTbznAr4OaNyWrvKRRMwK97+qum?=
 =?us-ascii?Q?hHDznwBvwbfWrL1AkpWogpV6A6x5Q8MfeP7qCyERxDopCs3dM63gA3FYpPzk?=
 =?us-ascii?Q?r4KVpXQFU8XLYq2Iy9u3iozbtfnL+vK76j7b8Gqz3x9/OuG8FAMYDOqcsiBN?=
 =?us-ascii?Q?sOGJXdwaOWfuqXvFEoqPYuZnylRbI1+10L1B0Ih5P9gFtFlzBDqfVqQsS2zx?=
 =?us-ascii?Q?HjJ90FEoKRJd12Ia8cwTjBbNET+bn5J1Jk/1+ktYNQ+Z7TQEzz1gfuXh/JJO?=
 =?us-ascii?Q?BHy1FaIjjUM+XDQfUsiGBf7WPbbGNodFLRGjONMX1o+o43aH8EHhTO+xcdbh?=
 =?us-ascii?Q?6AhOd0U7g87Fq19ypGUl07I8pMpBv+0aOBJz4rPs57qgrQ0zSVYDguovv3i0?=
 =?us-ascii?Q?dKU+XdWb1LHQwW7GrSv9sNi0aeduIzBGazB8sQanf7G0aBqdlNHJMpjMrlLn?=
 =?us-ascii?Q?Gv/vm+TVcm3Xfg7/PghRHA29xSKMotUVQxcuiBlR0XKCU8dVaArnWrDM9KyV?=
 =?us-ascii?Q?l1SFXnd1w5AdoJQooNNKuQrYOL9fIZiTprj82QHjiKqTJn/CQXQ/AYhytMEB?=
 =?us-ascii?Q?janFC/oWH8PFiUeOPRC2tqGdIkoM/8LeN7fGXklVUsHF6OTrt7aiVwueGbjq?=
 =?us-ascii?Q?6Z8PG46N1HULRPQxWq0f+1cbCCSvo3XIJLAb+qbaYSn7gzNjLmme92dgv2Pn?=
 =?us-ascii?Q?Du887n1+cTpT/ReOyG2jo7wgXqspLkRgzCe4jgfLGFrI7k9RZgbX4S1MmyMW?=
 =?us-ascii?Q?jNOrAueRZLs1M4470y6RAKm4DaQxdUEMXNZEg4eWw7f3PbD1U+LaSqx8gI5E?=
 =?us-ascii?Q?BNilo2+Blcf/BIuFEl100djxheKQZz8FFPwCdp+Eho7QF87fK3HtOfDxKBh4?=
 =?us-ascii?Q?uvu5Al+yxVZRyItCsafbhiRSyQdq109fLEsspZI8GxdRYTjpMMAsewhO9s0f?=
 =?us-ascii?Q?sp6feFHQTT/hi6geWTUkl/x+aQIqrdwuRCNeFA7cYQqxBu/059j/N8RJRE8b?=
 =?us-ascii?Q?Pv/hXsckH/hHHt+yCtAJpbBlBqfzlE8G83Ff/cSzL9kB+OGBslEsQllknByl?=
 =?us-ascii?Q?4tQZs1mzHzb2lYhkx/P6h55Uk1eeaABqUMAaB/+uFhunhqWh4o2YGvKtT7LG?=
 =?us-ascii?Q?Uu9FzoXlAz49rFkpTo+1dnXyseNvbtfWtEIAo5DYMogHWEui/mFNXxQOfN3N?=
 =?us-ascii?Q?sz0dPBRVtdFjUzfpKomawfXFXZaKB8kGqEfoNTUxJRQ9ecvbwlgJzRgsS5cn?=
 =?us-ascii?Q?oOfdmASLjRAYSkAeQPX/STtKuhSQc3w9m166Fawm?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YEwCgwk11g/lBLLXR4+87T5SMnCg5mAAYV0v46m8GA9hwV5SIziiio56lDSg+ok8psStAU4iBpp6plshWGiJdwwfVpouCZ1MrRToW4lcpfwN7N/PzTixylAbKtCH7+xaiToJveXTIutkBHvtfehZ5TqhJ+aicgtstzM2Xuk+pO1+lGplFFnf8Ud/nbFEhdO726AjoyjjLf3vc8UcA+DDcFlKhtbh9SyJwwTf7vO6cpW49OxNE0zxMyLBZO14ZnzIN2ke/JWaI7hNJ981aQCS/JX7/aiFXbi290JtNeMlr0mMlqh3xIQc2mZWx4rs0QLA1BzN8M7X/QwNCUCeMjKbP1hU5QkVe0lsixt6gGwzJhHpow0FbcDaq4gUsEZOyhLcE+WDsYneFbCi+a9ie688gjIJ4Rnvvy+YyOdP614DA2w2FYmaN7N7RBV/0NspO3Gt2SigHdPsinYhZ0NxoBv4KoUj2P6Jw8/VrPTaVMURxGiLJpLvmFJgZlZMR2sa5j7XWUJXPHXRgMJjFyDKNqB61zNHzyNUxD/9vKJ2vbP1l3sWFQ9qQ4zcuu8ilcTEzn3BMDyi30o2FgusaPOGPQcVqM8ZML4iKOSlDwBEU4hQfj4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa6d5ce0-ffc1-4ac1-92ad-08dcc79987ee
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 19:42:20.5967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j10i/hBxZBNY9hSN7zvK2CeeCcH5zpGGxImy0tJagAVT8/IoybqUXiqclD8e6kjBMg6iqTncSf2ZbqfQPCu83g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7183
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-28_08,2024-08-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=983 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408280143
X-Proofpoint-GUID: Dz5NygAlvFmnftwZUkTumDunwfMc0AfH
X-Proofpoint-ORIG-GUID: Dz5NygAlvFmnftwZUkTumDunwfMc0AfH

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [240823 16:07]:
> Both can_vma_merge_before() and can_vma_merge_after() are invoked after
> checking for compatible VMA NUMA policy, we can simply move this to
> is_mergeable_vma() and abstract this altogether.
> 
> In mmap_region() we set vmg->policy to NULL, so the policy comparisons
> checked in can_vma_merge_before() and can_vma_merge_after() are exactly
> equivalent to !vma_policy(vmg.next) and !vma_policy(vmg.prev).
> 
> Equally, in do_brk_flags(), vmg->policy is NULL, so the
> can_vma_merge_after() is checking !vma_policy(vma), as we set vmg.prev to
> vma.
> 
> In vma_merge(), we compare prev and next policies with vmg->policy before
> checking can_vma_merge_after() and can_vma_merge_before() respectively,
> which this patch causes to be checked in precisely the same way.
> 
> This therefore maintains precisely the same logic as before, only now
> abstracted into is_mergeable_vma().
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  mm/mmap.c | 8 +++-----
>  mm/vma.c  | 9 ++++-----
>  2 files changed, 7 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 4066c0444495..c72f50feb98a 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1423,8 +1423,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  
>  	/* Attempt to expand an old mapping */
>  	/* Check next */
> -	if (next && next->vm_start == end && !vma_policy(next) &&
> -	    can_vma_merge_before(&vmg)) {
> +	if (next && next->vm_start == end && can_vma_merge_before(&vmg)) {

It occurs to me that we could use the vma iterators index/last to check
the limits prior to needing to move at all.. but I'll leave that for
future work.

>  		merge_end = next->vm_end;
>  		vma = next;
>  		vmg.pgoff = next->vm_pgoff - pglen;
> @@ -1438,8 +1437,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  	}
>  
>  	/* Check prev */
> -	if (prev && prev->vm_end == addr && !vma_policy(prev) &&
> -	    can_vma_merge_after(&vmg)) {
> +	if (prev && prev->vm_end == addr && can_vma_merge_after(&vmg)) {
>  		merge_start = prev->vm_start;
>  		vma = prev;
>  		vmg.pgoff = prev->vm_pgoff;
> @@ -1778,7 +1776,7 @@ static int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  	 * Expand the existing vma if possible; Note that singular lists do not
>  	 * occur after forking, so the expand will only happen on new VMAs.
>  	 */
> -	if (vma && vma->vm_end == addr && !vma_policy(vma)) {
> +	if (vma && vma->vm_end == addr) {
>  		VMG_STATE(vmg, mm, vmi, addr, addr + len, flags, PHYS_PFN(addr));
>  
>  		vmg.prev = vma;
> diff --git a/mm/vma.c b/mm/vma.c
> index 74c627ff0313..b1ec412fac7f 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -19,6 +19,8 @@ static inline bool is_mergeable_vma(struct vma_merge_struct *vmg, bool merge_nex
>  	 */
>  	bool may_remove_vma = merge_next;
>  
> +	if (!mpol_equal(vmg->policy, vma_policy(vma)))
> +		return false;

Should we ensure there is any vma to check here?  Maybe just an assert?

>  	/*
>  	 * VM_SOFTDIRTY should not prevent from VMA merging, if we
>  	 * match the flags but dirty bit -- the caller should mark
> @@ -1058,17 +1060,14 @@ static struct vm_area_struct *vma_merge(struct vma_merge_struct *vmg)
>  		vma_pgoff = prev->vm_pgoff;
>  
>  		/* Can we merge the predecessor? */
> -		if (addr == prev->vm_end && mpol_equal(vma_policy(prev), vmg->policy)
> -		    && can_vma_merge_after(vmg)) {
> -
> +		if (addr == prev->vm_end && can_vma_merge_after(vmg)) {
>  			merge_prev = true;
>  			vma_prev(vmg->vmi);
>  		}
>  	}
>  
>  	/* Can we merge the successor? */
> -	if (next && mpol_equal(vmg->policy, vma_policy(next)) &&
> -	    can_vma_merge_before(vmg)) {
> +	if (next && can_vma_merge_before(vmg)) {
>  		merge_next = true;
>  	}
>  
> -- 
> 2.46.0
> 

