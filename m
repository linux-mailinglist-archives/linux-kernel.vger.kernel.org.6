Return-Path: <linux-kernel+bounces-300112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5AD995DEF7
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 18:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2FBE1C20DE5
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 16:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1AD01714C6;
	Sat, 24 Aug 2024 16:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FmatzDsG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pT+cXQWo"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0475529A1;
	Sat, 24 Aug 2024 16:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724516884; cv=fail; b=PwtWZIkJ28MrRjLNgRyGVIH7Toil7heGGElLyURMzFAYqE8Dr90dXGCQ4p7X5rTo5p4Kkldl4i/ogQdNMsec6Nl8E/4aEZQ5pr7tl4k9GN1YAtziimc7KxNs4QQnGT48mGb6G0ubz/YeyNM2vMB5XvvOvYgAKHfVx6pO6Kr8w5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724516884; c=relaxed/simple;
	bh=atQ/ufU7AyeNLPCu3i5IreSTLGmMkZTiM7wJSg/ccxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GQpMag8sO5ZDIJSsGuj9+2ReY0zwWRWaUsOI48d6K1Xq+SBRkWf8RgW1fA7q4pxoF3SsUyNn8XmkWtlPtN/RgsERsAM1iuIY6As9ydN3dIsh8nXWHK8PmhK7otBOTRF0451IuImhXN0zmG6cO6Jq+s4trWSn5RCarKWUEIAiqac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FmatzDsG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pT+cXQWo; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47OEpoj1021529;
	Sat, 24 Aug 2024 16:27:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=5+M0Y7xB+V0oSRr
	4ZUxqzTM6fhiA3oo80g2vq6gpr88=; b=FmatzDsGMHGEdjD4SiXvmB1QZnwcPV3
	0lYoUMJ+9K/TDPUwVABwPJHIUobmGfgR3RwWRoC4nqWOGX1SUVsZ1kdL6+Gf+bdF
	mL9z7zYxInu2mbH9XhETyDu6tf//Vy1DSvdTsIVWT7eBSVGmp0cWvvWoI2UayKgT
	SAKLO6K7zrbC/XOHDnNEJvAxZV01a0l5LZ15Th3QKXp8UmBme0ZET7o8L0WRWziE
	XrbPM9i5Z15la00wk19fB3SURJkHXpJk7z1jFjksG/SdyMJpxHFtuy6HchhPHdMY
	ZSkF3OfcD6x9L0a/I1flARkOBp5q5fXqNsa48AzJRPaTzFi7IeYE3gg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41782srdsb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 24 Aug 2024 16:27:54 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47OGJcZL020016;
	Sat, 24 Aug 2024 16:27:53 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 417jxkg2jt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 24 Aug 2024 16:27:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vb+Z5dVmn2SdEa9vxGHOdppyj3bAjaAx2nLYraqRLk0Y6THyVefYedq5agnjzBEHa/LJccMczeN7GDq1dyGyU4mO2twllRXnC7NzBL8xvviU47CY3lDIg+y55TLtASu4y0t79OFv8Rbna6yiChoLRoZvbRxD3dyp4GyWd3hdDLQRUepIn+vVSiq4p8ODEFBFhFCSVg78Tv14u3idFjRP8/U0V0zvxQm6Mq36bm6NkKXOaib2X4pS7Vv7P4ya3zDjkkSAAe79rApCxwPj5w7Ozl2XK4fsXNaa8tzX+uEDuGjg64cCwHef//J3oHT+P2DO9yJF4UMcJVOrqCeYN+YQ3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5+M0Y7xB+V0oSRr4ZUxqzTM6fhiA3oo80g2vq6gpr88=;
 b=NahMtqviR+NyVg+4Ji/UK0knb02CA3b7SBgJPRBOoLQyxtLyFgiVytv4uvXmwRtjrSpnD+eo8GXrv6NyvS31ZSfgIHgPQ2brnSY2ouRWUNT7Qp82WppTqBJMf52ch6XvuUYIiyM6oskToI24pidzf/Lww5B/1NwlsRC9ZPcnq4Le1gGSCLaRtDhdVDTMDBebbqOPf9tDrDhAqlCUI5TBBMukrSQIaBxhEJAhrHFQMvXlMH02m+JpTlZBHcGXoe4+N4pTtAKzSRC2+fFYdT6NYgoJtX/a7IhJaL6SnVm0b5yR30hhXbGRI2GUpofr23MHidt1s5AVrFUGFH4bvdpweA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5+M0Y7xB+V0oSRr4ZUxqzTM6fhiA3oo80g2vq6gpr88=;
 b=pT+cXQWoECwh9yWs3C5Zyb8YxbIImesmI0yFRx14ngtrWEa4EyM76j0gt2MGbrFue1nhNsQDPuM4bRXPB5HgSp4cyMT9PueobE2J0wwBVP9gO+AUEG1yHZOiKjdt+VTgj8Pt5X+tVRKtw5WbSjp+1LyIXVGkpc9nANMVEZ0FXYk=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by SJ2PR10MB7598.namprd10.prod.outlook.com (2603:10b6:a03:540::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Sat, 24 Aug
 2024 16:26:50 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7897.014; Sat, 24 Aug 2024
 16:26:50 +0000
Date: Sat, 24 Aug 2024 17:26:46 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Zhiguo Jiang <justinjiang@vivo.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, oe-lkp@lists.linux.dev, lkp@intel.com,
        opensource.kernel@vivo.com
Subject: Re: [PATCH v2] vma remove the unneeded avc bound with non-CoWed folio
Message-ID: <73ad9540-3fb8-4154-9a4f-30a0a2b03d41@lucifer.local>
References: <20240823150206.565-1-justinjiang@vivo.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823150206.565-1-justinjiang@vivo.com>
X-ClientProxiedBy: LO4P123CA0277.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:195::12) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|SJ2PR10MB7598:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d37ec49-a197-418b-4cb7-08dcc4598e8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?c40wOOInOzpj8Fig3bRgB17IiRwnyW2Z3uu+ZLXUy+70nhW7J9jdjzb9AymL?=
 =?us-ascii?Q?aLNlYNn01b+rsWDS5BMHlGF6qigbCCVY51uK02h32eWvelvtfqz+oW7Momr0?=
 =?us-ascii?Q?GqKVe893ZEB63GbD7KKimibOvM5YYpFBcm8NUr/h666DLxS4U0uhc4jCwL4z?=
 =?us-ascii?Q?hQTDVcHrtrLETAdCieNe7u4MNGMByScGUfTCQzupm8PRVdpkiQCFEXzaB569?=
 =?us-ascii?Q?UIJJrCOdqhK3mPa/FrxVgNsv7gkqEAQr8Q13vrX4iNNrCILmlI8ZzSP5OoAD?=
 =?us-ascii?Q?50AqVviYhymBK6iWJIK5AdvcWxjdfMHNAVK96z9vDkIhUixmPwjBz3eAI2wx?=
 =?us-ascii?Q?mFvJQ4rHDHNWkrgJRRu5VGGdbL3yhD1oEZyDqCRX2kLp/cuIkqd64gGfDe14?=
 =?us-ascii?Q?Mn6hQC4qlkHBapWYDvw4QXI20eRtfUMUO9K9vn4nvj4y+uGxsSGYgbSF75HH?=
 =?us-ascii?Q?JsQ7PlHx6nzkRxm7V2vHy1CDsQlWJJV3Z3t7WoLopRYfJAKed/6vZfD8Ogbs?=
 =?us-ascii?Q?4QTeXa8kj81nsGWume56sEW44N4X/QDy+ZXavzeGNFqC5TrfvNg21dcdMZ73?=
 =?us-ascii?Q?D0dI3t1lA3DyZBHQF3q7GyX92HbsyNtdZ2DwYnpUXJvtWIAk3kfGRyoTIlif?=
 =?us-ascii?Q?Whn9Ky1ZMjZsb+lIlm3VMdd6P1UTAfiXb9lF/McM5jH3E1EsYJ5qf0c2BZae?=
 =?us-ascii?Q?YqH0Cx9//wrR7nmscHrpGGhUNLOkC96d3452ovrpXBGJWjcBws4sJ9iz9Jca?=
 =?us-ascii?Q?b3yEguc6Hf0hJGswOGwDGVyD7bgSOjXk4uGr+diWjcSDN8mpnDDvlcxL2xxt?=
 =?us-ascii?Q?QgW7rxvQ60AxrvWb5YSXzZd1Oz4/WVuszXPyCZ2F0P4+ekxC73cOn9qdLeGc?=
 =?us-ascii?Q?JKMgIzKHjCTYo/fuMWOq71utWVKfTK7J9PBaWwNGm8C6nDMIHNf92SX91/n6?=
 =?us-ascii?Q?BEN3sDjH26H7RkZ8aYF2BifZwJ0Vedp4sU6Oidq28KHtkE4x2/APsFW+Excm?=
 =?us-ascii?Q?QiqSWYdq8pN+TDnA01LGlAvJFeHbh48jlVc/QumJPlsdSy9OwMc0obyEK01x?=
 =?us-ascii?Q?1AnozcQTRywWSLWU9Cj7gVWxbA5YD6OSfzDE8ySb7/Ih0slWL2mVML6d446x?=
 =?us-ascii?Q?qd8v62TDlfZ2n0l2rhOkJBA4xQuSWT0SofX1zGyPU9zhnPKgCjBBuwi22MWP?=
 =?us-ascii?Q?YEDjc4jyZJkudWZDHDkw0AjTy7n1TLiH1wd3vkP6YTkiq+PvwHdrM75y7K63?=
 =?us-ascii?Q?CpO4bm76dy69Kc07rCRFEuqc40O6k14R21VOGvHnyPF/CpUSBkUhwD7gfjUi?=
 =?us-ascii?Q?p3mvHTCYatSPJBKqLcckoSUS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jJASQCQ9ug6diNI68IFmoJHYe+cyHoki/2HuNiQTHtG31DU4FjnARHjN7omA?=
 =?us-ascii?Q?s3ajwzthrJ0ZGR1nTCTQROFO8c7hUqL2VocEbHjniXgS8fxWVD8aVLCiLdHe?=
 =?us-ascii?Q?fN4YraKpimQRNdaxlrj0ZO7EQt4cVCIC2aOeNni6RNgo+z0YtOeCvGTLCy9y?=
 =?us-ascii?Q?ePSyk+zyPJ8GpVopv7QcuMnHa/YyNTs21+inJnlEE4XYhbfBEmVYWB3Mwu8j?=
 =?us-ascii?Q?U+N7P32b1tT/sTFrQyN1DLpuWu11MLEa6CHOOToTt+3wg4dsqfEufkeFqTel?=
 =?us-ascii?Q?jZyeD1ice10ULOEohuwcANy2QE1e3g7w2w9Dst6fkh3ZFvomwI9QkF9AxcrV?=
 =?us-ascii?Q?wXLXjCwjx2pbq1t8JVaBVo3Puh77WtB8CFoUaCakitVwaZ+p341rb/Msdwyk?=
 =?us-ascii?Q?IvE1yr7Uy8lWBtdu/Nugn5ekJ0yCNvsbVLVpFSasZ/SsSeipEQBjzzyeZK8S?=
 =?us-ascii?Q?oSM7SN/7Nzgnt/5Z4UzKRGg6lc6NBXJIW6JqjKYT+f1uUdHpg7lt0zOq4RF0?=
 =?us-ascii?Q?Qs5E/H/xOI/8jIQ5+jz7LH2GOjuCCrvK4uj2F/wwVoQb3dD2ws2iUnu4Ch78?=
 =?us-ascii?Q?jya8Tw0cwHFqnhVb6WYDh8X69t+Jh8ACQPzVmLbJF2ROV126/F2I1uSoWQRq?=
 =?us-ascii?Q?XeiwWSH+dHGY5ZecFLA5DVPvsee5hxPPU4denMer4r6SZB9ZwUhtYux2V+9A?=
 =?us-ascii?Q?FnaxHZ4HBtC26WI3p0pW7J4wG1oSp9qf3IJUfvUXAvU6R2gTj0z43chfnsND?=
 =?us-ascii?Q?o5JfBNgRMl0bPaeDB1fyv8Lv5sytts1jPDQxA7h9zAvVjZAZI7A4Nup6lZXs?=
 =?us-ascii?Q?FwE6xrKx2LAELOZUfzYzjOTaeiKGeKlV2uW2TYGc1hgLdfNENgR12EChW+Jj?=
 =?us-ascii?Q?JzxyX/rsbajthEwo+PNHyWg5va+jItfoaR4fwWf3q9cdIt0agJpqjRhn/y7r?=
 =?us-ascii?Q?ViULSfeqXzceZPPhRwijXZa/DfTW+ZIfwTmR4cDMvAb1DO44JNpyqejkRBIV?=
 =?us-ascii?Q?Mezug/OyaoVFViL1lXl5FRpub+FOZEZojYyIEVw15xNdYBPE4USakWjN8MMH?=
 =?us-ascii?Q?4hfTH4b/ZnXm8Ih1SAp7PNrEjMTqXg9phB7zvbDRKACGuP+VQoTTrMm1jzcz?=
 =?us-ascii?Q?MLJf/CsNoAfow0Tf4fN8mEF4EWPnROWc35HYM8JWpJriXdszYr2EbQLAeK4l?=
 =?us-ascii?Q?4rkYY60nKP1/VbhjiD4WFqKa9CXpyJegVC8wt57gyArz8DPGkAIxBWYtR3KI?=
 =?us-ascii?Q?7J/fiXEjVf7SRsm3BH1zmlqvY/ojBXhUtL0hyRUy6usHTWQcM3Jx9UkqMpVe?=
 =?us-ascii?Q?LmuHrA/oJR9MP/kmJ1eid/rbRCI5KR0gDmWMl/5Vj0ptqB0LPdAR4DIaYhef?=
 =?us-ascii?Q?F3BENuoIfTu4PoTBHrZ+ZtR5Hxxh15EdnkF5+jec2Lx/w8Jw1QJetrGexuZi?=
 =?us-ascii?Q?6XC1YmFW2SFQOxv6a9s86+FuVpZXPgyM60OPAjtGvLlG4Lg0ky0q3qxvoWbj?=
 =?us-ascii?Q?2Tjmg2LRfM3bEJs7881KCdk4xu6nZrA6Odk/6L9jUQ5HnFN1ptpVdZXN3/P+?=
 =?us-ascii?Q?QiIVhH4fv3MxI1lbChwAFJtOpL94nx8p8MN7Al3lDbFtXhbhjexz4JuPajAm?=
 =?us-ascii?Q?0g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SyIncQj8Cj4SULsdHRCqjjeXr9Pk5R+cRlMF8xXVKGrmdQRwyzIvzl+H7DFtfGnShmEEAYfyYWutPh628NOjpoi3tjTwwmMLW4z8oOM9R2izmFRC0smfRlgDZ/Dsy48dNB080jTbEnZaWSFvpRgMJNuBVudMFYhu9xo+LxV7KW0rKaT8fA734ZH45oxCdACEiOn0Nf7MQvD5vOPLs37JU2Q67YQZ8G1uFCqPGntpbQLmQ6Ulsvr/8dbWFI+pVStOOuCCPbJBg4hCl4xhYewI4fHBGMV7HtORXhcA2yaZvfFFSSTFvsCG57bJyoSKa4eWFUrPXxVhDyFeU9deTxB6H/cp2XLn7vPKkh+MY/F20Er+qza+fwCDNJkuw5BF5wH1/AT1iVrP3czTVLY+JGo8iC9I+5FQFPPTlMc4AXLfb8R3XCvN5nRPKD7eOWb6xHweaJ+PO3oICyAxTINaY1+2qcCbhy6s8TaK0O50dqB48DpYUjj9NUhQ99BPzWhP/HNN7fakbGlL2ZRYHoM2RMQWd889FidLFTcTFUqM5nWBU6A3DSFkFtB/Zm7YXIkEt1LHDA3+ZBqR3FoklSmOWox51gr1ygrlwalFzFGvlUUM+7E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d37ec49-a197-418b-4cb7-08dcc4598e8e
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2024 16:26:50.4124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sfYzjrevC/2S2dDoxTmrEglynI64KDWp190Ok/rZSHDLA8K4U8CCyAd5mmTXdaLxjj2EPC+u8A/wV0bDnsCf93cVQBdYwqwMMgq0D2mPkHA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7598
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-24_12,2024-08-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 adultscore=0
 phishscore=0 spamscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408240104
X-Proofpoint-GUID: 6i3URlFYD2hJXRwG7gZkMK9_4szKheia
X-Proofpoint-ORIG-GUID: 6i3URlFYD2hJXRwG7gZkMK9_4szKheia

On Fri, Aug 23, 2024 at 11:02:06PM GMT, Zhiguo Jiang wrote:
> After CoWed by do_wp_page, the vma established a new mapping relationship
> with the CoWed folio instead of the non-CoWed folio. However, regarding
> the situation where vma->anon_vma and the non-CoWed folio's anon_vma are
> not same, the avc binding relationship between them will no longer be
> needed, so it is issue for the avc binding relationship still existing
> between them.
>
> This patch will remove the avc binding relationship between vma and the
> non-CoWed folio's anon_vma, which each has their own independent
> anon_vma. It can also alleviates rmap overhead simultaneously.
>
> Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>


NACK (until fixed). This is broken (see below).


I'm not seeing any numbers to back anything up here as to why we want to
make changes to this incredibly sensitive code?

Also anon_vma logic is very complicated and confusing, this commit message
feels about 3 paragraphs too light.

Under what circumstances will vma->anon_vma be different from
folio_anon_vma(non_cowed_folio)? etc.

Confusing topics strongly require explanations that help (somewhat)
compensate. This is one of them.

> ---
>
> -v2:
>  * Solve the kernel test robot noticed "WARNING"
>    Reported-by: kernel test robot <oliver.sang@intel.com>
>    Closes: https://lore.kernel.org/oe-lkp/202408230938.43f55b4-lkp@intel.com

It doesn't.

Saw a bunch of warning output in dmesg when running in qemu, bisected it to
this commit. The below assert is being fired (did you build this kernel
with CONFIG_DEBUG_VM?):

	VM_WARN_ON(anon_vma->num_children);

From what I saw, these appear to all be cases where anon_vma->num_children == 0...


[    1.905603] ------------[ cut here ]------------
[    1.905604] WARNING: CPU: 2 PID: 231 at mm/rmap.c:443 unlink_anon_vmas+0x181/0x1c0
[    1.905605] Modules linked in:
[    1.905605] CPU: 2 UID: 1000 PID: 231 Comm: zsh Tainted: G        W          6.11.0-rc4+ #49
[    1.905606] Tainted: [W]=WARN
[    1.905606] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux 1.16.3-1-1 04/01/2014
[    1.905607] RIP: 0010:unlink_anon_vmas+0x181/0x1c0
[    1.905608] Code: 48 83 7f 40 00 75 1c f0 ff 4f 30 75 ab e8 d7 fd ff ff eb a4 5b 5d 41 5c 41 5d 41 5e 41 5f c3 cc cc cc cc 90 0f 0b 90 eb de 90 <0f> 0b 90 eb d1 90 0f 0b 90 48 83 c7 08 e8 4d 7c ea ff e9 fc fe ff
[    1.905608] RSP: 0018:ffffc90000547cb0 EFLAGS: 00010286
[    1.905609] RAX: ffff88817b265390 RBX: ffff88817b265380 RCX: ffff88817b2cb790
[    1.905609] RDX: ffff88817b265380 RSI: ffff88817b2cb790 RDI: ffff888179e08888
[    1.905610] RBP: dead000000000122 R08: 000000000000000c R09: 0000000000000010
[    1.905610] R10: 0000000000000001 R11: 0000000000000000 R12: ffff88817b2cb790
[    1.905611] R13: dead000000000100 R14: ffff88817b2cb780 R15: ffff888179e08888
00000000000
[    1.905613] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.905613] CR2: 0000555bc5d97390 CR3: 000000017c12c000 CR4: 0000000000750ef0
[    1.905614] PKRU: 55555554
[    1.905614] Call Trace:
[    1.905614]  <TASK>
[    1.905615]  ? unlink_anon_vmas+0x181/0x1c0
[    1.905615]  ? __warn.cold+0x8e/0xe8
[    1.905616]  ? unlink_anon_vmas+0x181/0x1c0
[    1.905617]  ? report_bug+0xff/0x140
[    1.905618]  ? handle_bug+0x3b/0x70
[    1.905619]  ? exc_invalid_op+0x17/0x70
[    1.905620]  ? asm_exc_invalid_op+0x1a/0x20
[    1.905621]  ? unlink_anon_vmas+0x181/0x1c0
[    1.905622]  free_pgtables+0x11f/0x250
[    1.905622]  exit_mmap+0x15e/0x380
[    1.905624]  mmput+0x54/0x110
[    1.905625]  do_exit+0x27e/0xa10
[    1.905626]  ? __x64_sys_close+0x37/0x80
[    1.905626]  do_group_exit+0x2b/0x80
[    1.905628]  __x64_sys_exit_group+0x13/0x20
[    1.905629]  x64_sys_call+0x14af/0x14b0
[    1.905630]  do_syscall_64+0x9e/0x1a0
[    1.905630]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[    1.905631] RIP: 0033:0x7f4416ae33ad
[    1.905632] Code: Unable to access opcode bytes at 0x7f4416ae3383.
000e7
[    1.905633] RAX: ffffffffffffffda RBX: 00007f4416d5e3c0 RCX: 00007f4416ae33ad
[    1.905633] RDX: 00000000000000e7 RSI: ffffffffffffff88 RDI: 0000000000000000
[    1.905633] RBP: 0000555b8eed1378 R08: 0000000000000000 R09: 0000000000000007
[    1.905634] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
[    1.905634] R13: 0000000000000000 R14: 00007ffe7dbe9190 R15: 00007ffe7dbe9110
[    1.905635]  </TASK>
[    1.905635] ---[ end trace 0000000000000000 ]---
[    1.905638] ------------[ cut here ]------------


>  * Update comments to more accurately describe this patch.
>
> -v1:
>  https://lore.kernel.org/linux-mm/20240820143359.199-1-justinjiang@vivo.com/
>
>  include/linux/rmap.h |  1 +
>  mm/memory.c          |  8 +++++++
>  mm/rmap.c            | 53 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 62 insertions(+)
>
> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
> index 91b5935e8485..8607d28a3146
> --- a/include/linux/rmap.h
> +++ b/include/linux/rmap.h
> @@ -257,6 +257,7 @@ void folio_remove_rmap_ptes(struct folio *, struct page *, int nr_pages,
>  	folio_remove_rmap_ptes(folio, page, 1, vma)
>  void folio_remove_rmap_pmd(struct folio *, struct page *,
>  		struct vm_area_struct *);
> +void folio_remove_anon_avc(struct folio *, struct vm_area_struct *);
>
>  void hugetlb_add_anon_rmap(struct folio *, struct vm_area_struct *,
>  		unsigned long address, rmap_t flags);
> diff --git a/mm/memory.c b/mm/memory.c
> index 93c0c25433d0..4c89cb1cb73e
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3428,6 +3428,14 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
>  			 * old page will be flushed before it can be reused.
>  			 */
>  			folio_remove_rmap_pte(old_folio, vmf->page, vma);
> +
> +			/*
> +			 * If the new_folio's anon_vma is different from the
> +			 * old_folio's anon_vma, the avc binding relationship
> +			 * between vma and the old_folio's anon_vma is removed,
> +			 * avoiding rmap redundant overhead.

What overhead? Worth spelling out for instance if it's unnecessary to
traverse avc's.

> +			 */
> +			folio_remove_anon_avc(old_folio, vma);
>  		}
>
>  		/* Free the old page.. */
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 1103a536e474..56fc16fcf2a9
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1522,6 +1522,59 @@ void folio_add_file_rmap_pmd(struct folio *folio, struct page *page,
>  #endif
>  }
>
> +/**
> + * folio_remove_anon_avc - remove the avc binding relationship between
> + * folio and vma with different anon_vmas.
> + * @folio:	The folio with anon_vma to remove the binded avc from
> + * @vma:	The vm area to remove the binded avc with folio's anon_vma
> + *
> + * The caller is currently used for CoWed scene.

Strange turn of phrase,

> + */
> +void folio_remove_anon_avc(struct folio *folio,

I think this should be 'oldfolio'. You're not looking at the copied folio,
but the unCoW'd original folio.

> +		struct vm_area_struct *vma)
> +{
> +	struct anon_vma *anon_vma = folio_anon_vma(folio);
> +	pgoff_t pgoff_start, pgoff_end;
> +	struct anon_vma_chain *avc;
> +
> +	/*
> +	 * Ensure that the vma's anon_vma and the folio's
> +	 * anon_vma exist and are not same.
> +	 */
> +	if (!folio_test_anon(folio) || unlikely(!anon_vma) ||

The folio_test_anon() is already implied by folio_anon_vma() != NULL and
doesn't preclude KSM.

> +	    anon_vma == vma->anon_vma)
> +		return;

This is all super confusing, the 'parent' is actually anon_vma
(oldfolio). The newly created 'child' anon_vma is vma->anon_vma. Should
probably rename each accordingly.


> +
> +	pgoff_start = folio_pgoff(folio);
> +	pgoff_end = pgoff_start + folio_nr_pages(folio) - 1;
> +
> +	if (!anon_vma_trylock_write(anon_vma))
> +		return;
> +
> +	anon_vma_interval_tree_foreach(avc, &anon_vma->rb_root,
> +			pgoff_start, pgoff_end) {
> +		/*
> +		 * Find the avc associated with vma from the folio's
> +		 * anon_vma and remove it.
> +		 */

This is a meaningless comment.

This should be something like 'anon_vma_chain objects bind VMAs and
anon_vma's. Find the avc binding the unCoW'd folio's anon_vma to the new
VMA, and remove it, as it is now redundant.'

> +		if (avc->vma == vma) {

In testing I found that a lot of the time this isn't found at all... is
that expected?

> +			anon_vma_interval_tree_remove(avc, &anon_vma->rb_root);
> +			/*
> +			 * When removing the avc with anon_vma that is
> +			 * different from the parent anon_vma from parent
> +			 * anon_vma->rb_root, the parent num_children
> +			 * count value is needed to reduce one.
> +			 */

This is a really confusing comment. You're not explaining the 'why' you're
just essentially asserting that you need to do this, and clearly this is
broken.

> +			anon_vma->num_children--;

So we know this is broken to start due to VM_WARN_ON() failures.

As per above dmesg analysis, sometimes this is zero, so you're
underflowing. We definitely need a:

	VM_WARN_ON(anon_vma->num_children == 0);

At least.

But also the naming is broken here too, anon_vma is actually the parent
(oldfolio's) anon_vma...


This is also just not correct on any level - the anon_vma->num_children
field indicates how many child anon_vma objects point at it via
anon_vma->parent, NOT avc.

You're removing an avc, not disconnecting an anon_vma.

So it seems to me you should have logic to remove the avc AND logic to
disconnect vma->anon_vma from (parent) anon_vma if it points to it.

You'll need to be careful about locking when you do that too, as anon_vma's
lock on the root anon_vma, but in isolating the child anon_vma you'd lose
this lock.

I've tried to write code to fix this but haven't been able to yet, this is
fiddly stuff.

(I think this might have seemed to work at some point in testing because
unlink_anon_vmas() uses the avc list to determine what to unlink, rather
than looking at individual anon_vma's but still).

> +
> +			list_del(&avc->same_vma);
> +			anon_vma_chain_free(avc);
> +			break;
> +		}
> +	}
> +	anon_vma_unlock_write(anon_vma);
> +}
> +
>  static __always_inline void __folio_remove_rmap(struct folio *folio,
>  		struct page *page, int nr_pages, struct vm_area_struct *vma,
>  		enum rmap_level level)
> --
> 2.39.0
>

Again I question the value of this change. Are we REALLY seeing a big
problem due to unneeded avc's hanging around? This is very sensitive,
fiddly, confusing code, do we REALLY want to be playing with it?

It'd be good to get some tests though unless you move this to vma.c with
its userland testing (probably a good idea actually as Andrew suggested)
this might be tricky.

NACK until the issues are fixed and the approach at least seems more
correct.

