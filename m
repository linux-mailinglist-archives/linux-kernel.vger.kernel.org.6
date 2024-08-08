Return-Path: <linux-kernel+bounces-280087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D95C94C584
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 22:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A134A1C222DD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 20:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3550E15622E;
	Thu,  8 Aug 2024 20:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dLG6hQtm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="s3xGLIOM"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9C04A1E
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 20:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723147652; cv=fail; b=ipiY2bF5o2JHVP07cU5B/R7aGmRZlZ61kk/163Tr1pr7TVTaXBgTEqb3OMiqkAUUFCaeI9hBWQLSxHB+vcH2G1ZzqYCdXQX5Yi3Rami8kIDP7VeZ4hXGuX3DLcr6KeuLqD58phKCnOWNpTMTRDpLlkRctpwYQQslYZZiKFp2N0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723147652; c=relaxed/simple;
	bh=Smatu9xLlE+E3458cZxu6Yq8+xuAzzYfCVhojxVeZO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Y1Ph6EFz5kwZUOwp26Sz25dncp6/s1I7r8Pwn+QufXT/nMoKFUtAohIBqkTixUh/obkxYRPZ3PD53WyJ/rS/sxPmAuBBl+N1js/2SQoJmfqtVqnKfNzAab1I/xS2xYmjGt6BNhfbvBl4faqsFrVP+pWemZFnsFiZVg/LdUAMhUY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dLG6hQtm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=s3xGLIOM; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 478HfZiC031657;
	Thu, 8 Aug 2024 20:07:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=Dvv5tAljqniuLvX
	QR0PrS5VaBwK+C3+PnjQkdd6pCTw=; b=dLG6hQtm43T4r0A31CoHGBYIeDrMQWj
	fsVrPyRWtbENeJR+QrifnurcwmuaKbSyu/8e9se+5x9heYgicPHEIH3EUb/Jh+zO
	BWVFzWK5BPb0FuLKQiRd7BlLW+3lK10Ak9zV9rlnBOw/C4VE9UWn1q8H+Ex0ichd
	fJ2wF7tBwpSuBLjzTi18ofd48zqDQFJKSoegurbM6Ve96kiTK2g7ExK7GbTWHNHL
	tiBuznG7oVdJ7ZDbExfJYvizr62/BLxl+ka+F9AwI0hbbTBhf85BgcJ2gGBXifrS
	/ljqlYwxd+SsPKrXUyKj79xPi15seCm9Ud9/BBGsx1cUKdvEltMFEJw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40sckcjp9u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Aug 2024 20:07:21 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 478Jh4ol021746;
	Thu, 8 Aug 2024 20:07:20 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40sb0j3rvr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Aug 2024 20:07:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=szX15eoBdhI/TZOuHK4DESdhQvfIxTKh9pWazysujoA2dkXEmWJpdyZ5MznZr7iwkimfYYdikZ6AtfhXbkgdnGSwrU6xzP5G69wwrHeX8CRxLTyylzE9563DthuCvpAWdidKfcLENIUEK6wzpUGu/kTjQ7DinFtwDlMUIjw7oNdHoFgdfqH+LfVQJ7qtEz+sSxbGKZvxcugErTWnMMC6QFIOl+JiC884U+mtDr02NBQ7d/Bq6zr3Db+O851T8YSEVWtGWTixxVnKjzNN/72hC/XUyP+qXqmJmtp4flwDn0D4OQCiRDVnHR0XRVKrrmbm9pBkON+Tz7wrgbNJur8YuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dvv5tAljqniuLvXQR0PrS5VaBwK+C3+PnjQkdd6pCTw=;
 b=mykYjQXt/JzbxA8pXV0VOHiSef8d1f96Ww71YZguYgABRp+uflQ+CK/ll5q+vH6OzUbt2LeSXpPviWa50XCgprAnBDRyWt3w644X63F1VYsobw4iNTUOoiLoVJ554iYnqK1qspAFSBTjx4GTIB7JKZ+8yQOJOw6PLHGHS61vAFWeJOerjGiXW9QeUAN6R+0q6YKBUoEg3i9UOMlENk2EqZ2sK3R+1bhhyMb8D79eIpxT78MeoUPEOpdEPrdeHLAl3lfd14Bi5FnA9/1JR+oZO3J3HrGtVlyHJ+2jWCg64HexsSgugAxhxhGe/H4Fnp0lRr0grTcSD67OVONnNVzkEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dvv5tAljqniuLvXQR0PrS5VaBwK+C3+PnjQkdd6pCTw=;
 b=s3xGLIOMzt+WQt7as2+MJ87L15IPlLBMgHT1AZMUd4zKx+rV0EuaFWiTvsLK5AOga8kteVukRP5s6F6ZXiDmrw29FO/b3obEIM87ILuqPo6/Rlq6Xzw3OLXJytN5/uPzKojrGjiMF2kcAiytXmrd02jdBjTQpUt/XlHWFBmpnL0=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by IA1PR10MB5996.namprd10.prod.outlook.com (2603:10b6:208:3ec::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Thu, 8 Aug
 2024 20:07:17 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7849.008; Thu, 8 Aug 2024
 20:07:17 +0000
Date: Thu, 8 Aug 2024 16:07:15 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 02/10] mm: introduce vma_merge_struct and abstract merge
 parameters
Message-ID: <jsb525zhs3d5n42n75k6p4ou3d3on6lwdwp2rwhijgi6k65w5o@dlw2hya6zjkm>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>
References: <cover.1722849859.git.lorenzo.stoakes@oracle.com>
 <f2d7cc5de8aecc50d353980f62a74a0a6fcec198.1722849859.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2d7cc5de8aecc50d353980f62a74a0a6fcec198.1722849859.git.lorenzo.stoakes@oracle.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0491.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10c::28) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|IA1PR10MB5996:EE_
X-MS-Office365-Filtering-Correlation-Id: 293e0dae-19f3-4416-ed13-08dcb7e5b3dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ohe17eg5Eixdm24q2plUuNGS6YSuQK53oWrTIn5WUXIrBLGl4yMmh1fiaDW7?=
 =?us-ascii?Q?FgKh2uptzerCJ01ylagKOx0CL6NwJH1CMlUaJJGQmvRvVBvDlJUb7QbKt494?=
 =?us-ascii?Q?F4sRJ2ygOq1Qle8F2jWZ17DBV378upTzKqaVEwTrebC2mr+250xTNkBg7YAk?=
 =?us-ascii?Q?pSQWCDbQok8lCZ9Xl15r7Kk7Awd1yc7Lv9Fe7jef2BHBBnTHMOBmbyNDHkzv?=
 =?us-ascii?Q?6pTtFzN1hBiDEhLqoFXmrwFb+iHQ0Xs/AvxR7T+/ph8Dw8Ia4yxJ2bsCljwZ?=
 =?us-ascii?Q?KqP/NfM3qBdNU1kiqx8MEMDj94DXducqyQnKqFpT5zgldfFS2R9er5i7yTVD?=
 =?us-ascii?Q?cZr9akAS4S8bVfz2kJPSlXeKF2NtUJuLl2m/tfylDUYCyVIsPg5wePubkt4U?=
 =?us-ascii?Q?5NY+ePiD3DwnlK1Tws4Xd9pUpv81S7ewORRffmQw9DNqozdCbCNNxOcIhY91?=
 =?us-ascii?Q?6UspXwQg17aOSRwCy4FdWI1+jgi0ft1PhBw2kFJyZt02mLuPVxsyCaHMNXjk?=
 =?us-ascii?Q?abu+n7zreqNhyM+XvVv25NoCAqbS7u78LmsKcffAn0uAI5mOXUC07UMzcJqO?=
 =?us-ascii?Q?/obwiK+e6YFdlXKNi2XNXDLomprSbvM/ctoyQRShtvtgirEQ8z9740z2O2Nc?=
 =?us-ascii?Q?/KhFwh9UDeXLSQmG/lbO/QQxFDJm0SJ0QOkqAB1uCibv/VeCAZVAOlEgQ8du?=
 =?us-ascii?Q?XrBHZjr8Q/hHgVUalV3Xa4kuP1kTHO/kBqfWObj4L+0nwyB46zNkkygzHTWd?=
 =?us-ascii?Q?gpBcvmjB+LXQnC4M1TTKJnp7TzBfoJHLYxRGT9u+h//WywcdNIo9a2y26Fao?=
 =?us-ascii?Q?bP8nJZa18yawShT4tcUgLx2TUTFd+jT/EzT++R52fe+JWbH180kSZkH5KNMS?=
 =?us-ascii?Q?km6MW0b7xns4X8+dsdo7RhgLjZ4yJ7jb52Pzx6UcuHD4+vDZSx79tqFfUbPG?=
 =?us-ascii?Q?jaRHvlGTd8K+Z5VWlZ/nzZqqOrD/+bt/XGh3x8BeCmuXBb2WmTQDUhXhfJzP?=
 =?us-ascii?Q?WZY56nttZxePh04lt1Gw6SAJ+wU4dqtKL3mnznUADHnHi97Hl1EhrpJk4oxt?=
 =?us-ascii?Q?JgUVwbEHObVPqfmxuPUpdI8+0zZIOEUqEYkbuJK9twiVXGQlWpd6DTFYj97Z?=
 =?us-ascii?Q?3VAnNnbU1371JAdEvPc2OH5mtNGVO+ppN+FBEVuhrmtlLZ9WnF7G3FNgZspt?=
 =?us-ascii?Q?6SU6yRb+3NpXT3Lk/ypswH5wplOSn31zILkchh2jmq6GBqpoNPZaS+nHx1LS?=
 =?us-ascii?Q?TdfJkXvcSh5tRyAo7siDzXDcySu89dhg5g2hgfH2VTQgeSziDFSJ7W5CDbLO?=
 =?us-ascii?Q?ASxbd3lnq7CoZDI7H1eUBDl4MF+dwc6+A6ulCyvJ0u21sw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?V/ZyoGlJill/e2MV7vLYGu9uxDTjM6cdgSHU5QhEYU+NRjJlLjE0i3j0tLax?=
 =?us-ascii?Q?gSYptY3P6F1SQBCMmd24na4IDZx3IUQMSvd9VA0XsvVlI3AZYN0FxXpg738Q?=
 =?us-ascii?Q?P46tZ1b/KR+MYTOdwvScivOd47y/m0OK9LZtJTvPYf3OkbrxHyTvXticchDA?=
 =?us-ascii?Q?TpTBH2eka4hAN4kjMuaWRXl4AaRtzqiLS1TXLuupN/N12aS5GW5oDB6I24oz?=
 =?us-ascii?Q?qrMLYKyapcChdepIrM2koXGgaJNNKq81Map5NH/LyCGy+langcaWE6um1eZf?=
 =?us-ascii?Q?HLfDHw4Ow+cfOJScaeQ3N0WYF2Ux24WpV64jLx40wynJMzGzm/tTKgYUopk2?=
 =?us-ascii?Q?P2UVGtYLQBng29PrpWw1JEq5ryX1ppvce6W4e07W0LiF1CUQ9p4Jp8Niu56Z?=
 =?us-ascii?Q?DWMJgpykiU21ewrFbtTeQsrcm51R2XqzREQ1WiETQOarhMBGWZLYyY+FgXzC?=
 =?us-ascii?Q?crs+2/B24geWd1qimiU5e7/++rKtt0r3TH6qo96Bax/PrbNOpADA5urvtpYg?=
 =?us-ascii?Q?OljPpSvHhphRmO6AIXnSAvJ9bqOCDFikkrdkZoTQOew/vsug1P6xs1HlrgC+?=
 =?us-ascii?Q?6WWb+5AX1sl6sgl4I1EV6xNAz72lF92zdFS8/zKS9KfYP2LQY6wKQtzYMdkV?=
 =?us-ascii?Q?4tlfIzBSPgkX57OhBitVhtvjJWZLv44DkhE1h5/RW+uAXiMK9rsbZcLj8X4d?=
 =?us-ascii?Q?iT3lF8GJZ9te4Gdm0f2Q6yuExw0SpgsSW2QP79ohEWEY7SgA0kT7uWrkYwrh?=
 =?us-ascii?Q?6abzE7z1BquuQnvTpk68/V9Tu2nMeJOhDKVUYUvlDVPU2FpVJ57uNc0Ua4vh?=
 =?us-ascii?Q?KKwB0wu6yX/nMkJZMDL4MfTP/07AalFCSz31cu2e0cGQLf60Shzmwf8J8Xhb?=
 =?us-ascii?Q?1KedJ+pkSLGj4nSIXgBC3Cj36rSTk1V9t05QGe9NHNqFjaw/cB34+FglwimO?=
 =?us-ascii?Q?fZR0G3TygrjZUHj1WqPmCLXcoEhf0bVq7bQOoQrgL7HEpC5MZAB1tk04FQgM?=
 =?us-ascii?Q?itplHfZZLYETxK4+u1a2vp5z5hKaZY3zPMYteQ5nas0dpxsthWfr6tqwLQWR?=
 =?us-ascii?Q?N2zHWJXVi/AjOrgVfFHd+Mz3CEcGOmfoKGVl8BA6DvCJfUECIVy2L1f8Ak6M?=
 =?us-ascii?Q?vnLDyYbiEtGs+B0cge7Za8kzzKghCF4LQKXQl2S1Q0lS2dVYk6Wma3kIMwcz?=
 =?us-ascii?Q?QoJwQ7o6hV8Jjut3JaVkWWeJx8KQ7sMYFIa3wAb0sZEsp7A2cxt+dGzsfi0w?=
 =?us-ascii?Q?zmZsNY5a5Yqr/1vk7gtT+k6hzaNU+lRa5TwpxaL4Dw8xXiH6th4McypRNnKb?=
 =?us-ascii?Q?GM+1qNKEVhtnarLq+G3x18IXmnRZgIsYLqNsr5VoqB0qmNmJ5dHFb2EoumIe?=
 =?us-ascii?Q?LgbAoBSRj7UdeXjC+xKLLJS53E0nnSy2iZe5AAXzJG110lcRmO5HrHA37qSo?=
 =?us-ascii?Q?zeI/XtUeJIwc2ROZn5P+9avpR4yqpo1FCsJDr/O9qMwa7diE5y5wTdKcwJR5?=
 =?us-ascii?Q?UxMK4UCz2oCCtFbLZlWOP5Is1vqXMPSOQ4sezjrggVPdZA73dYRbQOWm1Dwa?=
 =?us-ascii?Q?hGCQL1FIlJ5+2HN9tQ+sP2gmR7kWCogKjXyP8pbn71b5jAaAA5A7JDI8PKDT?=
 =?us-ascii?Q?Zw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1Ju17AYZPOcuWbUbRnHyzixmf4LOLin0eBpaUG3hTAXncYmq3+fG9MdHe1Uip1qNzGGnbMFMYaeXSO79aRMOmgPrfFRBnftaBDrRROR0PEFkdEebcBpgFevjqGIdH75g+M8kCexudR1ktky+0MyHonQy7hUrBzqHwA7fAVkheH/l80uhiGq1NnIfy/m47pT57AcTRk8NQNWlRtD2vK2wely8AGciBX9AsLpYz60qwlwIud9BYrymm57fbrXaGEZhoJENHD/XLz3c39LRnNmSUZFlaOaMSp/oUUi+tMCgRoLYbtN4JBsUt045xPS2IR95uHL7fwJ+Tpw9sKhOyPhKMNUHYj9uCAyS6WM/OHWJUrpnhilTvgYixqxZw46KJfNpUP/NA6YynL4xDGHHyB7Eho30ObVv9gg63qF7lIYYmLeekk30vAp/HVKKo5iHYinseBXLzI+EXoK6pV06aen7UAFOzwV7/nAWnQWg0iY2UXGJlCrVyds4RPoLcWhmD4OHHNLmDh/u51IzyIs+uDFHPDjndSvLprnso4H8lzKhoSB8uPk4qTm+wAje1dhSc0phQyT2LsIdo0aQXi0lRBZmFjNuSIpnDu2zlXzTGXSD7eA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 293e0dae-19f3-4416-ed13-08dcb7e5b3dc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 20:07:17.4615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jeLK40jwY/zvSzqxmZrz+FYYfPcWGdXYzTOXFlh5i/gQEXxCEXlsMt17eTpQd4r1R4XSuqyA5uHDlcZH7XH91w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5996
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-08_20,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 adultscore=0
 phishscore=0 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408080142
X-Proofpoint-GUID: fTwm0QgE7K7MitP-4kjvOpyGK4uoWLzJ
X-Proofpoint-ORIG-GUID: fTwm0QgE7K7MitP-4kjvOpyGK4uoWLzJ

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [240805 08:14]:
> Rather than passing around huge numbers of parameters to numerous helper
> functions, abstract them into a single struct that we thread through the
> operation.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  mm/mmap.c |  76 ++++++++------
>  mm/vma.c  | 297 ++++++++++++++++++++++++++++++++++++++----------------
>  mm/vma.h  |  92 ++++++++---------
>  3 files changed, 294 insertions(+), 171 deletions(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 4a9c2329b09a..f931000c561f 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1369,9 +1369,16 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  	unsigned long end = addr + len;
>  	unsigned long merge_start = addr, merge_end = end;
>  	bool writable_file_mapping = false;
> -	pgoff_t vm_pgoff;
>  	int error;
>  	VMA_ITERATOR(vmi, mm, addr);
> +	struct vma_merge_struct vmg = {
> +		.vmi = &vmi,
> +		.start = addr,
> +		.end = end,
> +		.flags = vm_flags,
> +		.pgoff = pgoff,
> +		.file = file,
> +	};
>  
>  	/* Check against address space limit. */
>  	if (!may_expand_vm(mm, vm_flags, len >> PAGE_SHIFT)) {
> @@ -1405,8 +1412,8 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  		vm_flags |= VM_ACCOUNT;
>  	}
>  
> -	next = vma_next(&vmi);
> -	prev = vma_prev(&vmi);
> +	next = vmg.next = vma_next(&vmi);
> +	prev = vmg.prev = vma_prev(&vmi);
>  	if (vm_flags & VM_SPECIAL) {
>  		if (prev)
>  			vma_iter_next_range(&vmi);
> @@ -1416,29 +1423,30 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  	/* Attempt to expand an old mapping */
>  	/* Check next */
>  	if (next && next->vm_start == end && !vma_policy(next) &&
> -	    can_vma_merge_before(next, vm_flags, NULL, file, pgoff+pglen,
> -				 NULL_VM_UFFD_CTX, NULL)) {
> +	    can_vma_merge_before(&vmg)) {
>  		merge_end = next->vm_end;
>  		vma = next;
> -		vm_pgoff = next->vm_pgoff - pglen;
> +		vmg.pgoff = next->vm_pgoff - pglen;
> +	}
> +
> +	if (vma) {
> +		vmg.anon_vma = vma->anon_vma;
> +		vmg.uffd_ctx = vma->vm_userfaultfd_ctx;
>  	}
>  
>  	/* Check prev */
>  	if (prev && prev->vm_end == addr && !vma_policy(prev) &&
> -	    (vma ? can_vma_merge_after(prev, vm_flags, vma->anon_vma, file,
> -				       pgoff, vma->vm_userfaultfd_ctx, NULL) :
> -		   can_vma_merge_after(prev, vm_flags, NULL, file, pgoff,
> -				       NULL_VM_UFFD_CTX, NULL))) {
> +	    can_vma_merge_after(&vmg)) {
>  		merge_start = prev->vm_start;
>  		vma = prev;
> -		vm_pgoff = prev->vm_pgoff;
> +		vmg.pgoff = prev->vm_pgoff;
>  	} else if (prev) {
>  		vma_iter_next_range(&vmi);
>  	}
>  
>  	/* Actually expand, if possible */
>  	if (vma &&
> -	    !vma_expand(&vmi, vma, merge_start, merge_end, vm_pgoff, next)) {
> +	    !vma_expand(&vmi, vma, merge_start, merge_end, vmg.pgoff, next)) {
>  		khugepaged_enter_vma(vma, vm_flags);
>  		goto expanded;
>  	}
> @@ -1790,25 +1798,31 @@ static int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  	 * Expand the existing vma if possible; Note that singular lists do not
>  	 * occur after forking, so the expand will only happen on new VMAs.
>  	 */
> -	if (vma && vma->vm_end == addr && !vma_policy(vma) &&
> -	    can_vma_merge_after(vma, flags, NULL, NULL,
> -				addr >> PAGE_SHIFT, NULL_VM_UFFD_CTX, NULL)) {
> -		vma_iter_config(vmi, vma->vm_start, addr + len);
> -		if (vma_iter_prealloc(vmi, vma))
> -			goto unacct_fail;
> -
> -		vma_start_write(vma);
> -
> -		init_vma_prep(&vp, vma);
> -		vma_prepare(&vp);
> -		vma_adjust_trans_huge(vma, vma->vm_start, addr + len, 0);
> -		vma->vm_end = addr + len;
> -		vm_flags_set(vma, VM_SOFTDIRTY);
> -		vma_iter_store(vmi, vma);
> -
> -		vma_complete(&vp, vmi, mm);
> -		khugepaged_enter_vma(vma, flags);
> -		goto out;
> +	if (vma && vma->vm_end == addr && !vma_policy(vma)) {
> +		struct vma_merge_struct vmg = {
> +			.prev = vma,
> +			.flags = flags,
> +			.pgoff = addr >> PAGE_SHIFT,
> +		};

I see that this struct here makes sense later.

> +
> +		if (can_vma_merge_after(&vmg)) {
> +			vma_iter_config(vmi, vma->vm_start, addr + len);
> +			if (vma_iter_prealloc(vmi, vma))
> +				goto unacct_fail;
> +
> +			vma_start_write(vma);
> +
> +			init_vma_prep(&vp, vma);
> +			vma_prepare(&vp);
> +			vma_adjust_trans_huge(vma, vma->vm_start, addr + len, 0);
> +			vma->vm_end = addr + len;
> +			vm_flags_set(vma, VM_SOFTDIRTY);
> +			vma_iter_store(vmi, vma);
> +
> +			vma_complete(&vp, vmi, mm);
> +			khugepaged_enter_vma(vma, flags);
> +			goto out;
> +		}
>  	}
>  
>  	if (vma)
> diff --git a/mm/vma.c b/mm/vma.c
> index bf0546fe6eab..20c4ce7712c0 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -7,16 +7,18 @@
>  #include "vma_internal.h"
>  #include "vma.h"
>  
> -/*
> - * If the vma has a ->close operation then the driver probably needs to release
> - * per-vma resources, so we don't attempt to merge those if the caller indicates
> - * the current vma may be removed as part of the merge.
> - */
> -static inline bool is_mergeable_vma(struct vm_area_struct *vma,
> -		struct file *file, unsigned long vm_flags,
> -		struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
> -		struct anon_vma_name *anon_name, bool may_remove_vma)
> +static inline bool is_mergeable_vma(struct vma_merge_struct *vmg, bool merge_next)
>  {
> +	struct vm_area_struct *vma = merge_next ? vmg->next : vmg->prev;
> +	/*
> +	 * If the vma has a ->close operation then the driver probably needs to
> +	 * release per-vma resources, so we don't attempt to merge those if the
> +	 * caller indicates the current vma may be removed as part of the merge,
> +	 * which is the case if we are attempting to merge the next VMA into
> +	 * this one.
> +	 */
> +	bool may_remove_vma = merge_next;
> +
>  	/*
>  	 * VM_SOFTDIRTY should not prevent from VMA merging, if we
>  	 * match the flags but dirty bit -- the caller should mark
> @@ -25,15 +27,15 @@ static inline bool is_mergeable_vma(struct vm_area_struct *vma,
>  	 * the kernel to generate new VMAs when old one could be
>  	 * extended instead.
>  	 */
> -	if ((vma->vm_flags ^ vm_flags) & ~VM_SOFTDIRTY)
> +	if ((vma->vm_flags ^ vmg->flags) & ~VM_SOFTDIRTY)
>  		return false;
> -	if (vma->vm_file != file)
> +	if (vma->vm_file != vmg->file)
>  		return false;
>  	if (may_remove_vma && vma->vm_ops && vma->vm_ops->close)
>  		return false;
> -	if (!is_mergeable_vm_userfaultfd_ctx(vma, vm_userfaultfd_ctx))
> +	if (!is_mergeable_vm_userfaultfd_ctx(vma, vmg->uffd_ctx))
>  		return false;
> -	if (!anon_vma_name_eq(anon_vma_name(vma), anon_name))
> +	if (!anon_vma_name_eq(anon_vma_name(vma), vmg->anon_name))
>  		return false;
>  	return true;
>  }
> @@ -94,16 +96,16 @@ static void init_multi_vma_prep(struct vma_prepare *vp,
>   * We assume the vma may be removed as part of the merge.
>   */
>  bool
> -can_vma_merge_before(struct vm_area_struct *vma, unsigned long vm_flags,
> -		struct anon_vma *anon_vma, struct file *file,
> -		pgoff_t vm_pgoff, struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
> -		struct anon_vma_name *anon_name)
> +can_vma_merge_before(struct vma_merge_struct *vmg)
>  {
> -	if (is_mergeable_vma(vma, file, vm_flags, vm_userfaultfd_ctx, anon_name, true) &&
> -	    is_mergeable_anon_vma(anon_vma, vma->anon_vma, vma)) {
> -		if (vma->vm_pgoff == vm_pgoff)
> +	pgoff_t pglen = PHYS_PFN(vmg->end - vmg->start);
> +
> +	if (is_mergeable_vma(vmg, true) &&
> +	    is_mergeable_anon_vma(vmg->anon_vma, vmg->next->anon_vma, vmg->next)) {
> +		if (vmg->next->vm_pgoff == vmg->pgoff + pglen)
>  			return true;
>  	}
> +
>  	return false;
>  }
>  
> @@ -116,18 +118,11 @@ can_vma_merge_before(struct vm_area_struct *vma, unsigned long vm_flags,
>   *
>   * We assume that vma is not removed as part of the merge.
>   */
> -bool
> -can_vma_merge_after(struct vm_area_struct *vma, unsigned long vm_flags,
> -		struct anon_vma *anon_vma, struct file *file,
> -		pgoff_t vm_pgoff, struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
> -		struct anon_vma_name *anon_name)
> +bool can_vma_merge_after(struct vma_merge_struct *vmg)
>  {
> -	if (is_mergeable_vma(vma, file, vm_flags, vm_userfaultfd_ctx, anon_name, false) &&
> -	    is_mergeable_anon_vma(anon_vma, vma->anon_vma, vma)) {
> -		pgoff_t vm_pglen;
> -
> -		vm_pglen = vma_pages(vma);
> -		if (vma->vm_pgoff + vm_pglen == vm_pgoff)
> +	if (is_mergeable_vma(vmg, false) &&
> +	    is_mergeable_anon_vma(vmg->anon_vma, vmg->prev->anon_vma, vmg->prev)) {
> +		if (vmg->prev->vm_pgoff + vma_pages(vmg->prev) == vmg->pgoff)
>  			return true;
>  	}
>  	return false;
> @@ -180,7 +175,7 @@ void unmap_region(struct mm_struct *mm, struct ma_state *mas,
>   * VMA Iterator will point to the end VMA.
>   */
>  static int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
> -		       unsigned long addr, int new_below)
> +		       unsigned long addr, bool new_below)
>  {
>  	struct vma_prepare vp;
>  	struct vm_area_struct *new;
> @@ -261,13 +256,14 @@ static int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
>   * Split a vma into two pieces at address 'addr', a new vma is allocated
>   * either for the first part or the tail.
>   */
> -static int split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
> -		     unsigned long addr, int new_below)
> +static int split_vma(struct vma_merge_struct *vmg, bool new_below)
>  {
> -	if (vma->vm_mm->map_count >= sysctl_max_map_count)
> +	if (vmg->vma->vm_mm->map_count >= sysctl_max_map_count)
>  		return -ENOMEM;
>  
> -	return __split_vma(vmi, vma, addr, new_below);
> +	return __split_vma(vmg->vmi, vmg->vma,
> +			   new_below ? vmg->start : vmg->end,
> +			   new_below);

Why did this get worse?
Maybe split the __split_vma changes out of this patch?  I mean, split is
used for more than just merging, it's used for unmapping as well.
Changing argument types in __split_vma() seems unrelated to the main
focus of this patch.

>  }
>  
>  /*
> @@ -712,7 +708,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  		if (end < vma->vm_end && mm->map_count >= sysctl_max_map_count)
>  			goto map_count_exceeded;
>  
> -		error = __split_vma(vmi, vma, start, 1);
> +		error = __split_vma(vmi, vma, start, true);
>  		if (error)
>  			goto start_split_failed;
>  	}
> @@ -725,7 +721,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  	do {
>  		/* Does it split the end? */
>  		if (next->vm_end > end) {
> -			error = __split_vma(vmi, next, end, 0);
> +			error = __split_vma(vmi, next, end, false);
>  			if (error)
>  				goto end_split_failed;
>  		}
> @@ -934,16 +930,10 @@ int do_vmi_munmap(struct vma_iterator *vmi, struct mm_struct *mm,
>   * **** is not represented - it will be merged and the vma containing the
>   *      area is returned, or the function will return NULL
>   */
> -static struct vm_area_struct
> -*vma_merge(struct vma_iterator *vmi, struct vm_area_struct *prev,
> -	   struct vm_area_struct *src, unsigned long addr, unsigned long end,
> -	   unsigned long vm_flags, pgoff_t pgoff, struct mempolicy *policy,
> -	   struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
> -	   struct anon_vma_name *anon_name)
> +static struct vm_area_struct *vma_merge(struct vma_merge_struct *vmg)
>  {
> -	struct mm_struct *mm = src->vm_mm;
> -	struct anon_vma *anon_vma = src->anon_vma;
> -	struct file *file = src->vm_file;
> +	struct mm_struct *mm = container_of(vmg->vmi->mas.tree, struct mm_struct, mm_mt);

No.  current->mm is way better, or put it in that vmg thing.

> +	struct vm_area_struct *prev = vmg->prev;
>  	struct vm_area_struct *curr, *next, *res;
>  	struct vm_area_struct *vma, *adjust, *remove, *remove2;
>  	struct vm_area_struct *anon_dup = NULL;
> @@ -953,16 +943,18 @@ static struct vm_area_struct
>  	bool merge_prev = false;
>  	bool merge_next = false;
>  	bool vma_expanded = false;
> +	unsigned long addr = vmg->start;
> +	unsigned long end = vmg->end;
>  	unsigned long vma_start = addr;
>  	unsigned long vma_end = end;
> -	pgoff_t pglen = (end - addr) >> PAGE_SHIFT;
> +	pgoff_t pglen = PHYS_PFN(end - addr);
>  	long adj_start = 0;
>  
>  	/*
>  	 * We later require that vma->vm_flags == vm_flags,
>  	 * so this tests vma->vm_flags & VM_SPECIAL, too.
>  	 */
> -	if (vm_flags & VM_SPECIAL)
> +	if (vmg->flags & VM_SPECIAL)
>  		return NULL;
>  
>  	/* Does the input range span an existing VMA? (cases 5 - 8) */
> @@ -970,27 +962,26 @@ static struct vm_area_struct
>  
>  	if (!curr ||			/* cases 1 - 4 */
>  	    end == curr->vm_end)	/* cases 6 - 8, adjacent VMA */
> -		next = vma_lookup(mm, end);
> +		next = vmg->next = vma_lookup(mm, end);
>  	else
> -		next = NULL;		/* case 5 */
> +		next = vmg->next = NULL;	/* case 5 */
>  
>  	if (prev) {
>  		vma_start = prev->vm_start;
>  		vma_pgoff = prev->vm_pgoff;
>  
>  		/* Can we merge the predecessor? */
> -		if (addr == prev->vm_end && mpol_equal(vma_policy(prev), policy)
> -		    && can_vma_merge_after(prev, vm_flags, anon_vma, file,
> -					   pgoff, vm_userfaultfd_ctx, anon_name)) {
> +		if (addr == prev->vm_end && mpol_equal(vma_policy(prev), vmg->policy)
> +		    && can_vma_merge_after(vmg)) {
> +
>  			merge_prev = true;
> -			vma_prev(vmi);
> +			vma_prev(vmg->vmi);
>  		}
>  	}
>  
>  	/* Can we merge the successor? */
> -	if (next && mpol_equal(policy, vma_policy(next)) &&
> -	    can_vma_merge_before(next, vm_flags, anon_vma, file, pgoff+pglen,
> -				 vm_userfaultfd_ctx, anon_name)) {
> +	if (next && mpol_equal(vmg->policy, vma_policy(next)) &&
> +	    can_vma_merge_before(vmg)) {
>  		merge_next = true;
>  	}
>  
> @@ -1041,7 +1032,7 @@ static struct vm_area_struct
>  				remove = curr;
>  			} else {			/* case 5 */
>  				adjust = curr;
> -				adj_start = (end - curr->vm_start);
> +				adj_start = end - curr->vm_start;
>  			}
>  			if (!err)
>  				err = dup_anon_vma(prev, curr, &anon_dup);
> @@ -1081,13 +1072,13 @@ static struct vm_area_struct
>  		vma_expanded = true;
>  
>  	if (vma_expanded) {
> -		vma_iter_config(vmi, vma_start, vma_end);
> +		vma_iter_config(vmg->vmi, vma_start, vma_end);
>  	} else {
> -		vma_iter_config(vmi, adjust->vm_start + adj_start,
> +		vma_iter_config(vmg->vmi, adjust->vm_start + adj_start,
>  				adjust->vm_end);
>  	}
>  
> -	if (vma_iter_prealloc(vmi, vma))
> +	if (vma_iter_prealloc(vmg->vmi, vma))
>  		goto prealloc_fail;
>  
>  	init_multi_vma_prep(&vp, vma, adjust, remove, remove2);
> @@ -1099,19 +1090,19 @@ static struct vm_area_struct
>  	vma_set_range(vma, vma_start, vma_end, vma_pgoff);
>  
>  	if (vma_expanded)
> -		vma_iter_store(vmi, vma);
> +		vma_iter_store(vmg->vmi, vma);
>  
>  	if (adj_start) {
>  		adjust->vm_start += adj_start;
>  		adjust->vm_pgoff += adj_start >> PAGE_SHIFT;
>  		if (adj_start < 0) {
>  			WARN_ON(vma_expanded);
> -			vma_iter_store(vmi, next);
> +			vma_iter_store(vmg->vmi, next);
>  		}
>  	}
>  
> -	vma_complete(&vp, vmi, mm);
> -	khugepaged_enter_vma(res, vm_flags);
> +	vma_complete(&vp, vmg->vmi, mm);
> +	khugepaged_enter_vma(res, vmg->flags);
>  	return res;
>  
>  prealloc_fail:
> @@ -1119,8 +1110,8 @@ static struct vm_area_struct
>  		unlink_anon_vmas(anon_dup);
>  
>  anon_vma_fail:
> -	vma_iter_set(vmi, addr);
> -	vma_iter_load(vmi);
> +	vma_iter_set(vmg->vmi, addr);
> +	vma_iter_load(vmg->vmi);
>  	return NULL;
>  }
>  
> @@ -1137,38 +1128,141 @@ static struct vm_area_struct
>   * The function returns either the merged VMA, the original VMA if a split was
>   * required instead, or an error if the split failed.
>   */
> -struct vm_area_struct *vma_modify(struct vma_iterator *vmi,
> -				  struct vm_area_struct *prev,
> -				  struct vm_area_struct *vma,
> -				  unsigned long start, unsigned long end,
> -				  unsigned long vm_flags,
> -				  struct mempolicy *policy,
> -				  struct vm_userfaultfd_ctx uffd_ctx,
> -				  struct anon_vma_name *anon_name)
> +static struct vm_area_struct *vma_modify(struct vma_merge_struct *vmg)
>  {
> -	pgoff_t pgoff = vma->vm_pgoff + ((start - vma->vm_start) >> PAGE_SHIFT);
> +	struct vm_area_struct *vma = vmg->vma;
>  	struct vm_area_struct *merged;
>  
> -	merged = vma_merge(vmi, prev, vma, start, end, vm_flags,
> -			   pgoff, policy, uffd_ctx, anon_name);
> +	/* First, try to merge. */
> +	merged = vma_merge(vmg);
>  	if (merged)
>  		return merged;
>  
> -	if (vma->vm_start < start) {
> -		int err = split_vma(vmi, vma, start, 1);
> +	/* Split any preceding portion of the VMA. */
> +	if (vma->vm_start < vmg->start) {
> +		int err = split_vma(vmg, true);
>  
>  		if (err)
>  			return ERR_PTR(err);
>  	}
>  
> -	if (vma->vm_end > end) {
> -		int err = split_vma(vmi, vma, end, 0);
> +	/* Split any trailing portion of the VMA. */
> +	if (vma->vm_end > vmg->end) {
> +		int err = split_vma(vmg, false);
>  
>  		if (err)
>  			return ERR_PTR(err);
>  	}
>  
> -	return vma;
> +	return vmg->vma;
> +}
> +
> +/* Assumes addr >= vma->vm_start. */
> +static pgoff_t vma_pgoff_offset(struct vm_area_struct *vma, unsigned long addr)
> +{
> +	return vma->vm_pgoff + PHYS_PFN(addr - vma->vm_start);
> +}
> +

Could we do something like the MA_STATE() in the maple_tree.h for the
below?

> +struct vm_area_struct *vma_modify_flags(struct vma_iterator *vmi,
> +					struct vm_area_struct *prev,
> +					struct vm_area_struct *vma,
> +					unsigned long start, unsigned long end,
> +					unsigned long new_flags)
> +{
> +	struct vma_merge_struct vmg = {
> +		.vmi = vmi,
> +		.prev = prev,
> +		.vma = vma,
> +		.start = start,
> +		.end = end,
> +		.flags = new_flags,
> +		.pgoff = vma_pgoff_offset(vma, start),
> +		.file = vma->vm_file,
> +		.anon_vma = vma->anon_vma,
> +		.policy = vma_policy(vma),
> +		.uffd_ctx = vma->vm_userfaultfd_ctx,
> +		.anon_name = anon_vma_name(vma),
> +	};
> +
> +	return vma_modify(&vmg);
> +}
> +
> +struct vm_area_struct
> +*vma_modify_flags_name(struct vma_iterator *vmi,
> +		       struct vm_area_struct *prev,
> +		       struct vm_area_struct *vma,
> +		       unsigned long start,
> +		       unsigned long end,
> +		       unsigned long new_flags,
> +		       struct anon_vma_name *new_name)
> +{
> +	struct vma_merge_struct vmg = {
> +		.vmi = vmi,
> +		.prev = prev,
> +		.vma = vma,
> +		.start = start,
> +		.end = end,
> +		.flags = new_flags,
> +		.pgoff = vma_pgoff_offset(vma, start),
> +		.file = vma->vm_file,
> +		.anon_vma = vma->anon_vma,
> +		.policy = vma_policy(vma),
> +		.uffd_ctx = vma->vm_userfaultfd_ctx,
> +		.anon_name = new_name,
> +	};
> +
> +	return vma_modify(&vmg);
> +}
> +
> +struct vm_area_struct
> +*vma_modify_policy(struct vma_iterator *vmi,
> +		   struct vm_area_struct *prev,
> +		   struct vm_area_struct *vma,
> +		   unsigned long start, unsigned long end,
> +		   struct mempolicy *new_pol)
> +{
> +	struct vma_merge_struct vmg = {
> +		.vmi = vmi,
> +		.prev = prev,
> +		.vma = vma,
> +		.start = start,
> +		.end = end,
> +		.flags = vma->vm_flags,
> +		.pgoff = vma_pgoff_offset(vma, start),
> +		.file = vma->vm_file,
> +		.anon_vma = vma->anon_vma,
> +		.policy = new_pol,
> +		.uffd_ctx = vma->vm_userfaultfd_ctx,
> +		.anon_name = anon_vma_name(vma),
> +	};
> +
> +	return vma_modify(&vmg);
> +}
> +
> +struct vm_area_struct
> +*vma_modify_flags_uffd(struct vma_iterator *vmi,
> +		       struct vm_area_struct *prev,
> +		       struct vm_area_struct *vma,
> +		       unsigned long start, unsigned long end,
> +		       unsigned long new_flags,
> +		       struct vm_userfaultfd_ctx new_ctx)
> +{
> +	struct vma_merge_struct vmg = {
> +		.vmi = vmi,
> +		.prev = prev,
> +		.vma = vma,
> +		.start = start,
> +		.end = end,
> +		.flags = new_flags,
> +		.file = vma->vm_file,
> +		.anon_vma = vma->anon_vma,
> +		.pgoff = vma_pgoff_offset(vma, start),
> +		.policy = vma_policy(vma),
> +		.uffd_ctx = new_ctx,
> +		.anon_name = anon_vma_name(vma),
> +	};
> +
> +	return vma_modify(&vmg);
>  }
>  
>  /*
> @@ -1180,8 +1274,22 @@ struct vm_area_struct
>  		   struct vm_area_struct *vma, unsigned long start,
>  		   unsigned long end, pgoff_t pgoff)
>  {
> -	return vma_merge(vmi, prev, vma, start, end, vma->vm_flags, pgoff,
> -			 vma_policy(vma), vma->vm_userfaultfd_ctx, anon_vma_name(vma));
> +	struct vma_merge_struct vmg = {
> +		.vmi = vmi,
> +		.prev = prev,
> +		.vma = vma,
> +		.start = start,
> +		.end = end,
> +		.flags = vma->vm_flags,
> +		.file = vma->vm_file,
> +		.anon_vma = vma->anon_vma,
> +		.pgoff = pgoff,
> +		.policy = vma_policy(vma),
> +		.uffd_ctx = vma->vm_userfaultfd_ctx,
> +		.anon_name = anon_vma_name(vma),
> +	};
> +
> +	return vma_merge(&vmg);
>  }
>  
>  /*
> @@ -1193,11 +1301,22 @@ struct vm_area_struct *vma_merge_extend(struct vma_iterator *vmi,
>  					unsigned long delta)
>  {
>  	pgoff_t pgoff = vma->vm_pgoff + vma_pages(vma);
> +	struct vma_merge_struct vmg = {
> +		.vmi = vmi,
> +		.prev = vma,
> +		.vma = vma,
> +		.start = vma->vm_end,
> +		.end = vma->vm_end + delta,
> +		.flags = vma->vm_flags,
> +		.file = vma->vm_file,
> +		.pgoff = pgoff,
> +		.policy = vma_policy(vma),
> +		.uffd_ctx = vma->vm_userfaultfd_ctx,
> +		.anon_name = anon_vma_name(vma),
> +	};
>  
>  	/* vma is specified as prev, so case 1 or 2 will apply. */
> -	return vma_merge(vmi, vma, vma, vma->vm_end, vma->vm_end + delta,
> -			 vma->vm_flags, pgoff, vma_policy(vma),
> -			 vma->vm_userfaultfd_ctx, anon_vma_name(vma));
> +	return vma_merge(&vmg);
>  }
>  
>  void unlink_file_vma_batch_init(struct unlink_vma_file_batch *vb)
> diff --git a/mm/vma.h b/mm/vma.h
> index 6efdf1768a0a..c31684cc1da6 100644
> --- a/mm/vma.h
> +++ b/mm/vma.h
> @@ -26,6 +26,23 @@ struct unlink_vma_file_batch {
>  	struct vm_area_struct *vmas[8];
>  };
>  
> +/* Represents a VMA merge operation. */
> +struct vma_merge_struct {
> +	struct vma_iterator *vmi;
> +	struct vm_area_struct *prev;
> +	struct vm_area_struct *next; /* Modified by vma_merge(). */
> +	struct vm_area_struct *vma; /* Either a new VMA or the one being modified. */
> +	unsigned long start;
> +	unsigned long end;
> +	unsigned long flags;
> +	pgoff_t pgoff;
> +	struct file *file;
> +	struct anon_vma *anon_vma;
> +	struct mempolicy *policy;
> +	struct vm_userfaultfd_ctx uffd_ctx;
> +	struct anon_vma_name *anon_name;
> +};
> +
>  #ifdef CONFIG_DEBUG_VM_MAPLE_TREE
>  void validate_mm(struct mm_struct *mm);
>  #else
> @@ -72,80 +89,53 @@ void unmap_region(struct mm_struct *mm, struct ma_state *mas,
>  		struct vm_area_struct *next, unsigned long start,
>  		unsigned long end, unsigned long tree_end, bool mm_wr_locked);
>  
> -/* Required by mmap_region(). */
> -bool
> -can_vma_merge_before(struct vm_area_struct *vma, unsigned long vm_flags,
> -		struct anon_vma *anon_vma, struct file *file,
> -		pgoff_t vm_pgoff, struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
> -		struct anon_vma_name *anon_name);
> -
> -/* Required by mmap_region() and do_brk_flags(). */
> -bool
> -can_vma_merge_after(struct vm_area_struct *vma, unsigned long vm_flags,
> -		struct anon_vma *anon_vma, struct file *file,
> -		pgoff_t vm_pgoff, struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
> -		struct anon_vma_name *anon_name);
> -
> -struct vm_area_struct *vma_modify(struct vma_iterator *vmi,
> -				  struct vm_area_struct *prev,
> -				  struct vm_area_struct *vma,
> -				  unsigned long start, unsigned long end,
> -				  unsigned long vm_flags,
> -				  struct mempolicy *policy,
> -				  struct vm_userfaultfd_ctx uffd_ctx,
> -				  struct anon_vma_name *anon_name);
> +/*
> + * Can we merge the VMA described by vmg into the following VMA vmg->next?
> + *
> + * Required by mmap_region().
> + */
> +bool can_vma_merge_before(struct vma_merge_struct *vmg);
> +
> +/*
> + * Can we merge the VMA described by vmg into the preceding VMA vmg->prev?
> + *
> + * Required by mmap_region() and do_brk_flags().
> + */
> +bool can_vma_merge_after(struct vma_merge_struct *vmg);
>  
>  /* We are about to modify the VMA's flags. */
> -static inline struct vm_area_struct
> -*vma_modify_flags(struct vma_iterator *vmi,
> -		  struct vm_area_struct *prev,
> -		  struct vm_area_struct *vma,
> -		  unsigned long start, unsigned long end,
> -		  unsigned long new_flags)
> -{
> -	return vma_modify(vmi, prev, vma, start, end, new_flags,
> -			  vma_policy(vma), vma->vm_userfaultfd_ctx,
> -			  anon_vma_name(vma));
> -}
> +struct vm_area_struct *vma_modify_flags(struct vma_iterator *vmi,
> +					struct vm_area_struct *prev,
> +					struct vm_area_struct *vma,
> +					unsigned long start, unsigned long end,
> +					unsigned long new_flags);

Functions with insane number of arguments can be written like this:

struct vm_area_struct *vma_modify_flags(struct vma_iterator *vmi,
		struct vm_area_struct *prev, struct vm_area_struct,
		*vma, unsigned long start, unsigned long end,
		unsigned long new_flags);

The advantage is that more of the insane arguments are on the same line,
and if the name changes it will limit the impact.

>  
>  /* We are about to modify the VMA's flags and/or anon_name. */
> -static inline struct vm_area_struct
> +struct vm_area_struct
>  *vma_modify_flags_name(struct vma_iterator *vmi,
>  		       struct vm_area_struct *prev,
>  		       struct vm_area_struct *vma,
>  		       unsigned long start,
>  		       unsigned long end,
>  		       unsigned long new_flags,
> -		       struct anon_vma_name *new_name)
> -{
> -	return vma_modify(vmi, prev, vma, start, end, new_flags,
> -			  vma_policy(vma), vma->vm_userfaultfd_ctx, new_name);
> -}
> +		       struct anon_vma_name *new_name);
>  
>  /* We are about to modify the VMA's memory policy. */
> -static inline struct vm_area_struct
> +struct vm_area_struct
>  *vma_modify_policy(struct vma_iterator *vmi,
>  		   struct vm_area_struct *prev,
>  		   struct vm_area_struct *vma,
>  		   unsigned long start, unsigned long end,
> -		   struct mempolicy *new_pol)
> -{
> -	return vma_modify(vmi, prev, vma, start, end, vma->vm_flags,
> -			  new_pol, vma->vm_userfaultfd_ctx, anon_vma_name(vma));
> -}
> +		   struct mempolicy *new_pol);
>  
>  /* We are about to modify the VMA's flags and/or uffd context. */
> -static inline struct vm_area_struct
> +struct vm_area_struct
>  *vma_modify_flags_uffd(struct vma_iterator *vmi,
>  		       struct vm_area_struct *prev,
>  		       struct vm_area_struct *vma,
>  		       unsigned long start, unsigned long end,
>  		       unsigned long new_flags,
> -		       struct vm_userfaultfd_ctx new_ctx)
> -{
> -	return vma_modify(vmi, prev, vma, start, end, new_flags,
> -			  vma_policy(vma), new_ctx, anon_vma_name(vma));
> -}
> +		       struct vm_userfaultfd_ctx new_ctx);
>  
>  struct vm_area_struct
>  *vma_merge_new_vma(struct vma_iterator *vmi, struct vm_area_struct *prev,
> -- 
> 2.45.2
> 

