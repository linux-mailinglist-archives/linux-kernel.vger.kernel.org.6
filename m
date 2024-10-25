Return-Path: <linux-kernel+bounces-381664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 781019B0256
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 14:27:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 358DC281CB2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 12:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 121C82038A2;
	Fri, 25 Oct 2024 12:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="m6k4klEh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ynLSN769"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644A3204033
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 12:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729859240; cv=fail; b=DH84xhYYjpTT4YpXiVaRtUqnQYot/r2kBBI/3JCzGHVbExVbxdw7Bz48KY0CHgGMHKzhmLwBCaDxs0goI3F4GEs5lNM+apUhrGH1818akh27N25m21YZjH14VCLF8fcUbNJYV89fbUZ+Ao/d+JhPV+CsRqUxu0JYGJIxpwA+1og=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729859240; c=relaxed/simple;
	bh=qKR44KByMohzwwmmH5JP4+FmtjoTCjH0fwarecyq5bM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LPNG4NdkXAAk29jhlTiOAhw7bqRUPeGNyBXuiQbmATHLVvS2EBuJG8Myoo4w9YlIo97j8aEBRV4gKLXf9L9+PGkP83AIiMfvV6tqd3NPkmX8foQRZ6XME1Ptjwmw6N8n0pioxxwex153gkvAojrGJOQc4qT59xtDk81vhdHFri8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=m6k4klEh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ynLSN769; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49P8BZn4005842;
	Fri, 25 Oct 2024 12:27:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=tW/u9DgrsB/MKCUWnxSg/nTn3ydO0p05DZVgDkldlBM=; b=
	m6k4klEhZMTAqv1rfH8Kjx7SFwysJqy/4V3O1njAw/SiEUWNEV3GoMgw+Q2YG/sL
	qMptBZ2AVcsVCfA1pikazNQO33ZhvDy0thO0uT5RznlpIe4T9XIxuwPMlvR5zQy5
	puCGTKolg6hx8gQLGb/lR0k8L3BGkyszCx1bxJKFKlcsBfbKGkVxJJDwp5mgMr7j
	ipPfMu6XQ8Rr7l5ik8ywzA8If34Y7hqXZ4ASfviTVBP2bBDr1kwHmdHzjMrV9SM3
	SC38VGjrStWZBOjD2Q2psUGJE9+RRvu/7CShWxrcBXrSlNp0Fyq/QxeFD/gsa/08
	aYucDczmkZ86uwiqEYDrrQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c53uvttx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 12:27:04 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49PBxpRl016475;
	Fri, 25 Oct 2024 12:27:02 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42emhdt4th-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 12:27:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rsdrgkE9ZFZFPuiQsGU/nQ2iWNimlBe7hzpNeoEEswJARGk2dX8xLVXfC0EIIFrHW3tmG4jqF4+tLE3eExWOz05ZxhW2ccg5/YLVCR+W70Yr813loNtiv5X8yJGTugGgRjtQQDUVzAXqw5OV3jwpXeuXKTAcdRrTbRCjcmAzr5+oI0kNlaeUsowEm9rZf0+LO9neaKG32kISfs2NJH7yQCVu9E9PlKNlCQ8BPMHaAYoofbxTH9ilDJvh6L+CrUAjbe1ttdgTQuhO2/ca4fhGzn7vAwPZwVPbVwLZuZ81AWmwKX11kSKd0EoAZemphltv5HihdAiONy56UYItDjf9aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tW/u9DgrsB/MKCUWnxSg/nTn3ydO0p05DZVgDkldlBM=;
 b=RQGXV4fvH0pl/3KB4gdAlSSw31GJKnEDsjVIlZE2i98MXhNgrTfOyyiapnjF+uq9r81wdbDDKs0WSFu3gnpd56mWyToBcuPi0t7AogDuxXDVIS5DPGMuIhDTzlT66gvFrG/Z8Q+cD6JOtsp3Kp14Dbx2s1ksP/Dn0tAE+J+ynqvSkJlZoJU6vQ3sA14XLyq1oFZys7OJkFu2T6dsuljh8LbPjAEgl2N6H1vP6KbXBFaE04hXfHRcZkA0bwXItgVHp47Wnysw3N1E8hpx41ocoIVZGjfqgGaymeRAEnRqEb5/GovW00XZoQJKISRWVpy9C24gzsn5CUwWPGgEtewF7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tW/u9DgrsB/MKCUWnxSg/nTn3ydO0p05DZVgDkldlBM=;
 b=ynLSN769BOlRDcAWIQlrfLrhY6gZ/el/zfM5rrw45bZEuPkWYJ1sfmbgXxFDMfgQQlhvh8AnT1lE/CdLuiUKV+kuuVKSyVhb4egKxkfonWdUmdTX81CkgEzrIAd5ozaNRPFWBsX5OPZpHEU/E5e+XRLTNpZaKmmD0NTyRo5z4vs=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by CO1PR10MB4484.namprd10.prod.outlook.com (2603:10b6:303:90::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Fri, 25 Oct
 2024 12:26:57 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8093.014; Fri, 25 Oct 2024
 12:26:57 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>
Subject: [PATCH v3 3/5] mm: refactor __mmap_region()
Date: Fri, 25 Oct 2024 13:26:25 +0100
Message-ID: <25bd2edc3275450f448cbfe0756ce2a7cd06810f.1729858176.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1729858176.git.lorenzo.stoakes@oracle.com>
References: <cover.1729858176.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0164.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:312::13) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|CO1PR10MB4484:EE_
X-MS-Office365-Filtering-Correlation-Id: 914a8a93-d272-42ce-1a5a-08dcf4f0515b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?osZhqhfKNS8pMS3EbYV+v+gfXfQocnPHpeAIxQyXyC8P9N14h74d8mUd90GU?=
 =?us-ascii?Q?Aq3EFnCSeVhZ9ZPAuehGo5oa7ww1BTQwuJb+shYxwCp4KDU1/RoEMB8EhWFS?=
 =?us-ascii?Q?saV0XS3QDjaFetrcT5bKc+cZ4jxUCJ/syYONDQ1NytNQDDJiZzKRTswR36aR?=
 =?us-ascii?Q?VMnS5MA0/p9qhGDSlqP4fpxrjo4/HGLn9E5OIz2R5gSmKKrc9BdV4ada8pHf?=
 =?us-ascii?Q?bJD/bS9y5TTqpwc8zDJLPS9TrxnXpM418zxkYGDEdnB3dfV2X9MpDrJC8o6R?=
 =?us-ascii?Q?0FH3DpBvaj91gjU2eijRIwoHs2d0tj/30LgVdGuq1/zzGiaFUXuJF63KhqF7?=
 =?us-ascii?Q?Qjsr5xMRMRFCXK8Ep94m2mnWUPQiCrWfH8zV1sp8BuDRkBcoUChX+CnpOpV1?=
 =?us-ascii?Q?ttXneVi3jeVOre7muQjSyBMvdH3meu2qD+dqnyhOGe2HfOfxk+Z4LnxheyAi?=
 =?us-ascii?Q?AJw12VHusArRXJ1FA+uVEondqITRk2JQPfS/sJcsIbkjJDly3HWej/iD9eT9?=
 =?us-ascii?Q?LuXnI0XS4doaPQQaAtcwUXPFfs0P3maMEaZNiWG1haKHX8Hs4N+6qt6DNAu8?=
 =?us-ascii?Q?FW9N29hEkdVZ9ixLH4XVY3y1Y5mCZipSXyC/r5IAmZr15ESoK0Z5TuMJjHEH?=
 =?us-ascii?Q?KrxlnMmc9S3SA6DNw+goKh3JcIlB8q/0dMgUD51ywnXvbSj6Aew7dyEm81fw?=
 =?us-ascii?Q?Esui7TUfXctg5rqTZs0gqdfFTIgXqBQOxP9Nr3Mt9h1xlgfCvGRtmvY76tAZ?=
 =?us-ascii?Q?v6ZAclFwtomZ5sQCnynH6GneTfrgAcUlNXytHL2ugj162mBcT0YOrzrc3Ke4?=
 =?us-ascii?Q?ZfHMrLRBXVPx+rsIA+91qIhXSbWL5sjIQsuoz2hOmoaJsSCp08fP3uqDeI0E?=
 =?us-ascii?Q?q1qM8XNURICPxXimHPOAbsulphidJirLS9V3MXz2cu6EP04ATAJgOeSiONV3?=
 =?us-ascii?Q?Y8UdJE6zO5fAeKDusWVYH8ZTeDBirupZA3PG0WAB1QqF+BHwTbD+Br4OHKx7?=
 =?us-ascii?Q?HMW6PE1hJFu4Ogs4Bm9isX5jVyR5rEs2KHCogb1pNsF0FNffV5BryUrvXjXP?=
 =?us-ascii?Q?cp7VNtgjPXVXHgsOdDb4kjZO/SD5KGQJoWXiLYtXsk7MWKYSeVgYMVORnBjl?=
 =?us-ascii?Q?+vAGdgzGsrBTWtTml/7uDqbE5Q91DK/snvY24A0lpUqz8MRXMD4xZu1nyMPQ?=
 =?us-ascii?Q?o7Xg+DFbaT/94N1gAK/zD3p8flrSZCQmKfdpKkwxUSZ7OHYfT2V8TOEZaTaM?=
 =?us-ascii?Q?cY5wjuQiSgqKhJmfsEJ6Fq0sKEH7YeBHOn2/KuW7O+IMts4R0gn17fmagqiX?=
 =?us-ascii?Q?+8nmUJB7nyGF6hmxYBVIcVeP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?r6HNeyun50+FwmOiBnQmv6cpgDVyOHRsFTDfvwwXJPoJ28dGMfVKWolJRdA1?=
 =?us-ascii?Q?qHhGRripqHSV9wEhsCTlBsLUEHOKEav59AWtm38BQJidvDyUNEWkhP7CeoQu?=
 =?us-ascii?Q?HIyGRC7diVZV/dYWhzbKDHdvWsTzNhn81d44nvNZE4Odadb9lH5wa/g0H4Ko?=
 =?us-ascii?Q?oKiWbSfz3Fwvtpxh0prEUKH+RwCNpnM5yplW1MUEZ77MYIa1rmabLXm5iuZM?=
 =?us-ascii?Q?I+PRph1n0VXc03hl+PVVafWMsZi/VIeO4NpEriaEWhBghpyxS4upjh7+MF0u?=
 =?us-ascii?Q?K4ENT/PLQxukvCDQNa4tQSmKlQALnS2Q5PCTN59XyXyKF4Mm1fC+t/Soobgz?=
 =?us-ascii?Q?X5AwC+QP+kxwWpBu7/bp08lnx7Uy2kVndJH0kk6vjiVjes7lybQTjuZyBnxb?=
 =?us-ascii?Q?O53RuFhsoASL4wlqJBarVQJIz5DDJEbC8tjAgR44Zvvi3lfZd9M9JiBK48+i?=
 =?us-ascii?Q?BIDiEys+Mdsyimkz7t2PSJ4DjXsa4cNMpla20Lbe38C8+YH2ble7Qc1Y7OOi?=
 =?us-ascii?Q?yjy+lfNAWDqiHD1evQXL7yZCCGX/pPWcRGI05XPL4SIk2Thqs83sdKRMSHCa?=
 =?us-ascii?Q?RbUNwHORjbdjXEw6k1fF7o5rHDrWw/LlZBnjgS6BaP5C/iaz6CZNTLdii1lq?=
 =?us-ascii?Q?i/N++6ePkd8sgkyscoO2kMse1ceGnXnVm9vsqGI5aDyTiHhR040yNSKhr5oC?=
 =?us-ascii?Q?q/4jEafWQhgTt13mfWlRMVYPPyIBEZTOvMDJ0YZafM09HJ5CnO9uzinhucQ3?=
 =?us-ascii?Q?VDf5tdeYacCB/8rgqdVS9z5/UFmAcHabRwyZpoKVb7CXqKt8oBo+IzC1hTel?=
 =?us-ascii?Q?Dq9Fm5xYm521PzBYSipgNE7gWr57VYmHakrbQl4eNBn6jekeMJmTANLW2SgF?=
 =?us-ascii?Q?+p7RHoWhvsem/Uq4iey8fuH9d9bEO5lQwCAj+u4aenpdJpfyyCBIrBvmUtu2?=
 =?us-ascii?Q?uIlacxWSwRZJOvDXXDyyvwKhDXCmIPgIH2ajIVfZmhrsEsW95hK510uUrmxk?=
 =?us-ascii?Q?+5P0e1rpdDkpk8Z/jDGAVWT/ZY1f0ecuZP19JUwtx1l9mqjJMb49oBc+Bf3l?=
 =?us-ascii?Q?IJk9Oh3frXYKQvP0OlM+fwDvaOF3Y0sS9Xm5fGoXCT9N0Nx9/t30KvXu1VUe?=
 =?us-ascii?Q?1HO0uDVYsFmejLZa9JblBvUbz10Df66JFpfhZg5aUZuH7wHZyDy3bJ72jhcM?=
 =?us-ascii?Q?MqEtZ4P0nwX3i2XaP27N/1rJUYq0WGaTr7u5wBo8iDur/2nD15byX0xKe8O8?=
 =?us-ascii?Q?+bKtjqRMqnOD22K1GPvTrZn/2gRkBxjyRoqoaGbdovIIYwBcPOmUBY9TgIE0?=
 =?us-ascii?Q?cnPA5wpBQlv732FDkJUHdkSBeRCC7gx49CFAJ6/nQoLdnwbA4KtA/UvVOQfB?=
 =?us-ascii?Q?lqnFvPu61UwaPYu0IX6NnAkk7Ul5Tu4awfyaGnV11pODfN2mlPDheB6u5Dk+?=
 =?us-ascii?Q?D3XeOASsUm9r3ZIXtwUsNo2UyYjYtcaTWerODfP8SIcW9TpHPQ7xCTqxX1RU?=
 =?us-ascii?Q?s4/ftPtmM6OGuvwX5d75+rSYlsHvutGmXLSGoDNQeUCR6v+kHQRzeON7Q1x9?=
 =?us-ascii?Q?XPXBaDba3Hg16HPy5yDFdJU23k+l5kiYwN/wAYKqq2bXGMPoND/XhIEfeIMm?=
 =?us-ascii?Q?Bl5NEr76y5uteH8pLtnv/sCfCqlb+lSHhRZvH29p7R3dvKdfXhRDCQqwi0vb?=
 =?us-ascii?Q?4/g+eA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	etryJ5fLoaS1vvp81pFYFoLxRtvmdAc6uyK+iDPQyZUfRNH5xy16pTrqP+/aY5LMEtd8WSfpoejumL4fUbxPUbkOpw5hslWuBmjmAQo5UN/41H6lx+GmbRk4wyus4MUp/+K5aRuYa491bXADo5HPYSHUerOQnaO0qzi9vwDnNxfpuAVP4bHOEZYuYmmQxgJcCp26h/JutBjFC0nlS56UxNquTa4RlwZnz9KhNXImN9m3yEVFdusFVvB1amCj6JBg3lk5FBnP+El1AuIzJbHRR0EXruXs9D7GMlprcrBs6YlPWTQm1tXm0ZsX2vWZTZPtx3PnicVGb+FP+3aW/6PbSY7gbfquQFXPFpWJv3mdpSwGA6Pt816szI3vx0EuWNJ/6E5S87/glb6tLxaNwkPntaTtpSdIf5XgtdWdN5DWgH5VvxEoQd9RGfEeygEHYbVlVJCXKK/hJo2627HsvlYBH/FrITm/mWbdBg3Ctnvv6nTzD8XWMEl4//4gQtPRl3IqJZNBqoVq0VdG0fqvmMZpexI9icIFUvp90iuKxzkLWhrJ7k4be2Bj7SXtJRsT6pf5ivLIRVsFnLN/8E+US0J3Js2ESnjJmgB7G8w8UWJaD98=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 914a8a93-d272-42ce-1a5a-08dcf4f0515b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 12:26:57.5594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UoAwdC64miYexY8atyLM0kplhvI55RkL8ISG5ZOSJt8ztVlB4DmA2q+41bZVZoSlbxbXFKLaiiRhXdvRJXR43xC311p1zExijZ/dwP/q89w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4484
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-25_12,2024-10-25_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410250095
X-Proofpoint-GUID: 8HOIUugaD2zHS8gRfFuKMNjyXbOJt0Cz
X-Proofpoint-ORIG-GUID: 8HOIUugaD2zHS8gRfFuKMNjyXbOJt0Cz

We have seen bugs and resource leaks arise from the complexity of the
__mmap_region() function. This, and the generally deeply fragile error
handling logic and complexity which makes understanding the function
difficult make it highly desirable to refactor it into something readable.

Achieve this by separating the function into smaller logical parts which
are easier to understand and follow, and which importantly very
significantly simplify the error handling.

Note that we now call vms_abort_munmap_vmas() in more error paths than we
used to, however in cases where no abort need occur, vms->nr_pages will be
equal to zero and we simply exit this function without doing more than we
would have done previously.

Importantly, the invocation of the driver mmap hook via mmap_file() now has
very simple and obvious handling (this was previously the most problematic
part of the mmap() operation).

Use a generalised stack-based 'mmap state' to thread through values and
also retrieve state as needed.

Also avoid ever relying on vma merge (vmg) state after a merge is
attempted, instead maintain meaningful state in the mmap state and
establish vmg state as and when required.

This avoids any subtle bugs arising from merge logic mutating this state
and mmap_region() logic later relying upon it.

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/vma.c | 410 ++++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 270 insertions(+), 140 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index 0a2965be582d..b91c947babd6 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -7,6 +7,56 @@
 #include "vma_internal.h"
 #include "vma.h"
 
+struct mmap_state {
+	struct mm_struct *mm;
+	struct vma_iterator *vmi;
+
+	unsigned long addr;
+	unsigned long end;
+	pgoff_t pgoff;
+	unsigned long pglen;
+	unsigned long flags;
+	struct file *file;
+
+	unsigned long charged;
+
+	struct vm_area_struct *prev;
+	struct vm_area_struct *next;
+
+	/* Unmapping state. */
+	struct vma_munmap_struct vms;
+	struct ma_state mas_detach;
+	struct maple_tree mt_detach;
+};
+
+#define MMAP_STATE(name, mm_, vmi_, addr_, len_, pgoff_, flags_, file_) \
+	struct mmap_state name = {					\
+		.mm = mm_,						\
+		.vmi = vmi_,						\
+		.addr = addr_,						\
+		.end = (addr_) + len,					\
+		.pgoff = pgoff_,					\
+		.pglen = PHYS_PFN(len_),				\
+		.flags = flags_,					\
+		.file = file_,						\
+	}
+
+#define VMG_MMAP_STATE(name, map_, vma_)				\
+	struct vma_merge_struct name = {				\
+		.mm = (map_)->mm,					\
+		.vmi = (map_)->vmi,					\
+		.start = (map_)->addr,					\
+		.end = (map_)->end,					\
+		.flags = (map_)->flags,					\
+		.pgoff = (map_)->pgoff,					\
+		.file = (map_)->file,					\
+		.prev = (map_)->prev,					\
+		.vma = vma_,						\
+		.next = (vma_) ? NULL : (map_)->next,			\
+		.state = VMA_MERGE_START,				\
+		.merge_flags = VMG_FLAG_DEFAULT,			\
+	}
+
 static inline bool is_mergeable_vma(struct vma_merge_struct *vmg, bool merge_next)
 {
 	struct vm_area_struct *vma = merge_next ? vmg->next : vmg->prev;
@@ -2169,188 +2219,249 @@ static void vms_abort_munmap_vmas(struct vma_munmap_struct *vms,
 	vms_complete_munmap_vmas(vms, mas_detach);
 }
 
-unsigned long __mmap_region(struct file *file, unsigned long addr,
-		unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
-		struct list_head *uf)
+/*
+ * __mmap_prepare() - Prepare to gather any overlapping VMAs that need to be
+ * unmapped once the map operation is completed, check limits, account mapping
+ * and clean up any pre-existing VMAs.
+ *
+ * @map: Mapping state.
+ * @uf:  Userfaultfd context list.
+ *
+ * Returns: 0 on success, error code otherwise.
+ */
+static int __mmap_prepare(struct mmap_state *map, struct list_head *uf)
 {
-	struct mm_struct *mm = current->mm;
-	struct vm_area_struct *vma = NULL;
-	pgoff_t pglen = PHYS_PFN(len);
-	unsigned long charged = 0;
-	struct vma_munmap_struct vms;
-	struct ma_state mas_detach;
-	struct maple_tree mt_detach;
-	unsigned long end = addr + len;
 	int error;
-	VMA_ITERATOR(vmi, mm, addr);
-	VMG_STATE(vmg, mm, &vmi, addr, end, vm_flags, pgoff);
-
-	vmg.file = file;
-	/* Find the first overlapping VMA */
-	vma = vma_find(&vmi, end);
-	init_vma_munmap(&vms, &vmi, vma, addr, end, uf, /* unlock = */ false);
-	if (vma) {
-		mt_init_flags(&mt_detach, vmi.mas.tree->ma_flags & MT_FLAGS_LOCK_MASK);
-		mt_on_stack(mt_detach);
-		mas_init(&mas_detach, &mt_detach, /* addr = */ 0);
+	struct vma_iterator *vmi = map->vmi;
+	struct vma_munmap_struct *vms = &map->vms;
+
+	/* Find the first overlapping VMA and initialise unmap state. */
+	vms->vma = vma_find(vmi, map->end);
+	init_vma_munmap(vms, vmi, vms->vma, map->addr, map->end, uf,
+			/* unlock = */ false);
+
+	/* OK, we have overlapping VMAs - prepare to unmap them. */
+	if (vms->vma) {
+		mt_init_flags(&map->mt_detach,
+			      vmi->mas.tree->ma_flags & MT_FLAGS_LOCK_MASK);
+		mt_on_stack(map->mt_detach);
+		mas_init(&map->mas_detach, &map->mt_detach, /* addr = */ 0);
 		/* Prepare to unmap any existing mapping in the area */
-		error = vms_gather_munmap_vmas(&vms, &mas_detach);
-		if (error)
-			goto gather_failed;
+		error = vms_gather_munmap_vmas(vms, &map->mas_detach);
+		if (error) {
+			/* On error VMAs will already have been reattached. */
+			vms->nr_pages = 0;
+			return error;
+		}
 
-		vmg.next = vms.next;
-		vmg.prev = vms.prev;
-		vma = NULL;
+		map->next = vms->next;
+		map->prev = vms->prev;
 	} else {
-		vmg.next = vma_iter_next_rewind(&vmi, &vmg.prev);
+		map->next = vma_iter_next_rewind(vmi, &map->prev);
 	}
 
 	/* Check against address space limit. */
-	if (!may_expand_vm(mm, vm_flags, pglen - vms.nr_pages)) {
-		error = -ENOMEM;
-		goto abort_munmap;
-	}
+	if (!may_expand_vm(map->mm, map->flags, map->pglen - vms->nr_pages))
+		return -ENOMEM;
 
-	/*
-	 * Private writable mapping: check memory availability
-	 */
-	if (accountable_mapping(file, vm_flags)) {
-		charged = pglen;
-		charged -= vms.nr_accounted;
-		if (charged) {
-			error = security_vm_enough_memory_mm(mm, charged);
+	/* Private writable mapping: check memory availability. */
+	if (accountable_mapping(map->file, map->flags)) {
+		map->charged = map->pglen;
+		map->charged -= vms->nr_accounted;
+		if (map->charged) {
+			error = security_vm_enough_memory_mm(map->mm, map->charged);
 			if (error)
-				goto abort_munmap;
+				return error;
 		}
 
-		vms.nr_accounted = 0;
-		vm_flags |= VM_ACCOUNT;
-		vmg.flags = vm_flags;
+		vms->nr_accounted = 0;
+		map->flags |= VM_ACCOUNT;
 	}
 
 	/*
-	 * clear PTEs while the vma is still in the tree so that rmap
+	 * Clear PTEs while the vma is still in the tree so that rmap
 	 * cannot race with the freeing later in the truncate scenario.
 	 * This is also needed for mmap_file(), which is why vm_ops
 	 * close function is called.
 	 */
-	vms_clean_up_area(&vms, &mas_detach);
-	vma = vma_merge_new_range(&vmg);
-	if (vma)
-		goto expanded;
+	vms_clean_up_area(vms, &map->mas_detach);
+
+	return 0;
+}
+
+static int __mmap_new_file_vma(struct mmap_state *map,
+			       struct vm_area_struct **vmap, bool *mergedp)
+{
+	struct vma_iterator *vmi = map->vmi;
+	struct vm_area_struct *vma = *vmap;
+	int error;
+
+	vma->vm_file = get_file(map->file);
+	error = mmap_file(vma->vm_file, vma);
+	if (error) {
+		fput(vma->vm_file);
+		vma->vm_file = NULL;
+
+		vma_iter_set(vmi, vma->vm_end);
+		/* Undo any partial mapping done by a device driver. */
+		unmap_region(&vmi->mas, vma, map->prev, map->next);
+
+		return error;
+	}
+
+	/* Drivers cannot alter the address of the VMA. */
+	WARN_ON_ONCE(map->addr != vma->vm_start);
+	/*
+	 * Drivers should not permit writability when previously it was
+	 * disallowed.
+	 */
+	VM_WARN_ON_ONCE(map->flags != vma->vm_flags &&
+			!(map->flags & VM_MAYWRITE) &&
+			(vma->vm_flags & VM_MAYWRITE));
+
+	/* mmap_file() might have changed VMA flags. */
+	map->flags = vma->vm_flags;
+
+	vma_iter_config(vmi, map->addr, map->end);
+	/*
+	 * If flags changed after mmap_file(), we should try merge
+	 * vma again as we may succeed this time.
+	 */
+	if (unlikely(map->flags != vma->vm_flags && map->prev)) {
+		struct vm_area_struct *merge;
+		VMG_MMAP_STATE(vmg, map, /* vma = */ NULL);
+
+		merge = vma_merge_new_range(&vmg);
+		if (merge) {
+			/*
+			 * ->mmap() can change vma->vm_file and fput
+			 * the original file. So fput the vma->vm_file
+			 * here or we would add an extra fput for file
+			 * and cause general protection fault
+			 * ultimately.
+			 */
+			fput(vma->vm_file);
+			vm_area_free(vma);
+			vma = merge;
+			*mergedp = true;
+		} else {
+			vma_iter_config(vmi, map->addr, map->end);
+		}
+	}
+
+	*vmap = vma;
+	return 0;
+}
+
+/*
+ * __mmap_new_vma() - Allocate a new VMA for the region, as merging was not
+ * possible.
+ *
+ * An exception to this is if the mapping is file-backed, and the underlying
+ * driver changes the VMA flags, permitting a subsequent merge of the VMA, in
+ * which case the returned VMA is one that was merged on a second attempt.
+ *
+ * @map:  Mapping state.
+ * @vmap: Output pointer for the new VMA.
+ *
+ * Returns: Zero on success, or an error.
+ */
+static int __mmap_new_vma(struct mmap_state *map, struct vm_area_struct **vmap)
+{
+	struct vma_iterator *vmi = map->vmi;
+	int error = 0;
+	bool merged = false;
+	struct vm_area_struct *vma;
+
 	/*
 	 * Determine the object being mapped and call the appropriate
 	 * specific mapper. the address has already been validated, but
 	 * not unmapped, but the maps are removed from the list.
 	 */
-	vma = vm_area_alloc(mm);
-	if (!vma) {
-		error = -ENOMEM;
-		goto unacct_error;
-	}
+	vma = vm_area_alloc(map->mm);
+	if (!vma)
+		return -ENOMEM;
 
-	vma_iter_config(&vmi, addr, end);
-	vma_set_range(vma, addr, end, pgoff);
-	vm_flags_init(vma, vm_flags);
-	vma->vm_page_prot = vm_get_page_prot(vm_flags);
+	vma_iter_config(vmi, map->addr, map->end);
+	vma_set_range(vma, map->addr, map->end, map->pgoff);
+	vm_flags_init(vma, map->flags);
+	vma->vm_page_prot = vm_get_page_prot(map->flags);
 
-	if (vma_iter_prealloc(&vmi, vma)) {
+	if (vma_iter_prealloc(vmi, vma)) {
 		error = -ENOMEM;
 		goto free_vma;
 	}
 
-	if (file) {
-		vma->vm_file = get_file(file);
-		error = mmap_file(file, vma);
-		if (error)
-			goto unmap_and_free_file_vma;
-
-		/* Drivers cannot alter the address of the VMA. */
-		WARN_ON_ONCE(addr != vma->vm_start);
-		/*
-		 * Drivers should not permit writability when previously it was
-		 * disallowed.
-		 */
-		VM_WARN_ON_ONCE(vm_flags != vma->vm_flags &&
-				!(vm_flags & VM_MAYWRITE) &&
-				(vma->vm_flags & VM_MAYWRITE));
-
-		vma_iter_config(&vmi, addr, end);
-		/*
-		 * If vm_flags changed after mmap_file(), we should try merge
-		 * vma again as we may succeed this time.
-		 */
-		if (unlikely(vm_flags != vma->vm_flags && vmg.prev)) {
-			struct vm_area_struct *merge;
-
-			vmg.flags = vma->vm_flags;
-			/* If this fails, state is reset ready for a reattempt. */
-			merge = vma_merge_new_range(&vmg);
-
-			if (merge) {
-				/*
-				 * ->mmap() can change vma->vm_file and fput
-				 * the original file. So fput the vma->vm_file
-				 * here or we would add an extra fput for file
-				 * and cause general protection fault
-				 * ultimately.
-				 */
-				fput(vma->vm_file);
-				vm_area_free(vma);
-				vma = merge;
-				/* Update vm_flags to pick up the change. */
-				vm_flags = vma->vm_flags;
-				goto file_expanded;
-			}
-			vma_iter_config(&vmi, addr, end);
-		}
-
-		vm_flags = vma->vm_flags;
-	} else if (vm_flags & VM_SHARED) {
+	if (map->file)
+		error = __mmap_new_file_vma(map, &vma, &merged);
+	else if (map->flags & VM_SHARED)
 		error = shmem_zero_setup(vma);
-		if (error)
-			goto free_iter_vma;
-	} else {
+	else
 		vma_set_anonymous(vma);
-	}
+
+	if (error)
+		goto free_iter_vma;
+
+	if (merged)
+		goto file_expanded;
 
 #ifdef CONFIG_SPARC64
 	/* TODO: Fix SPARC ADI! */
-	WARN_ON_ONCE(!arch_validate_flags(vm_flags));
+	WARN_ON_ONCE(!arch_validate_flags(map->flags));
 #endif
 
 	/* Lock the VMA since it is modified after insertion into VMA tree */
 	vma_start_write(vma);
-	vma_iter_store(&vmi, vma);
-	mm->map_count++;
+	vma_iter_store(vmi, vma);
+	map->mm->map_count++;
 	vma_link_file(vma);
 
 	/*
 	 * vma_merge_new_range() calls khugepaged_enter_vma() too, the below
 	 * call covers the non-merge case.
 	 */
-	khugepaged_enter_vma(vma, vma->vm_flags);
+	khugepaged_enter_vma(vma, map->flags);
 
 file_expanded:
-	file = vma->vm_file;
 	ksm_add_vma(vma);
-expanded:
+	*vmap = vma;
+	return 0;
+
+free_iter_vma:
+	vma_iter_free(vmi);
+free_vma:
+	vm_area_free(vma);
+	return error;
+}
+
+/*
+ * __mmap_complete() - Unmap any VMAs we overlap, account memory mapping
+ *                     statistics, handle locking and finalise the VMA.
+ *
+ * @map: Mapping state.
+ * @vma: Merged or newly allocated VMA for the mmap()'d region.
+ */
+static void __mmap_complete(struct mmap_state *map, struct vm_area_struct *vma)
+{
+	struct mm_struct *mm = map->mm;
+	unsigned long vm_flags = vma->vm_flags;
+
 	perf_event_mmap(vma);
 
-	/* Unmap any existing mapping in the area */
-	vms_complete_munmap_vmas(&vms, &mas_detach);
+	/* Unmap any existing mapping in the area. */
+	vms_complete_munmap_vmas(&map->vms, &map->mas_detach);
 
-	vm_stat_account(mm, vm_flags, pglen);
+	vm_stat_account(mm, vma->vm_flags, map->pglen);
 	if (vm_flags & VM_LOCKED) {
 		if ((vm_flags & VM_SPECIAL) || vma_is_dax(vma) ||
 					is_vm_hugetlb_page(vma) ||
-					vma == get_gate_vma(current->mm))
+					vma == get_gate_vma(mm))
 			vm_flags_clear(vma, VM_LOCKED_MASK);
 		else
-			mm->locked_vm += pglen;
+			mm->locked_vm += map->pglen;
 	}
 
-	if (file)
+	if (vma->vm_file)
 		uprobe_mmap(vma);
 
 	/*
@@ -2363,26 +2474,45 @@ unsigned long __mmap_region(struct file *file, unsigned long addr,
 	vm_flags_set(vma, VM_SOFTDIRTY);
 
 	vma_set_page_prot(vma);
+}
 
-	return addr;
+unsigned long __mmap_region(struct file *file, unsigned long addr,
+		unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
+		struct list_head *uf)
+{
+	struct mm_struct *mm = current->mm;
+	struct vm_area_struct *vma = NULL;
+	int error;
+	VMA_ITERATOR(vmi, mm, addr);
+	MMAP_STATE(map, mm, &vmi, addr, len, pgoff, vm_flags, file);
 
-unmap_and_free_file_vma:
-	fput(vma->vm_file);
-	vma->vm_file = NULL;
+	error = __mmap_prepare(&map, uf);
+	if (error)
+		goto abort_munmap;
 
-	vma_iter_set(&vmi, vma->vm_end);
-	/* Undo any partial mapping done by a device driver. */
-	unmap_region(&vmi.mas, vma, vmg.prev, vmg.next);
-free_iter_vma:
-	vma_iter_free(&vmi);
-free_vma:
-	vm_area_free(vma);
-unacct_error:
-	if (charged)
-		vm_unacct_memory(charged);
+	/* Attempt to merge with adjacent VMAs... */
+	if (map.prev || map.next) {
+		VMG_MMAP_STATE(vmg, &map, /* vma = */ NULL);
+
+		vma = vma_merge_new_range(&vmg);
+	}
 
+	/* ...but if we can't, allocate a new VMA. */
+	if (!vma) {
+		error = __mmap_new_vma(&map, &vma);
+		if (error)
+			goto unacct_error;
+	}
+
+	__mmap_complete(&map, vma);
+
+	return addr;
+
+	/* Accounting was done by __mmap_prepare(). */
+unacct_error:
+	if (map.charged)
+		vm_unacct_memory(map.charged);
 abort_munmap:
-	vms_abort_munmap_vmas(&vms, &mas_detach);
-gather_failed:
+	vms_abort_munmap_vmas(&map.vms, &map.mas_detach);
 	return error;
 }
-- 
2.47.0


