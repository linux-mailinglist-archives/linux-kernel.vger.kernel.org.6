Return-Path: <linux-kernel+bounces-354152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C104C99386A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 22:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0D351C23521
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 20:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011181D31A0;
	Mon,  7 Oct 2024 20:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IZIAFoXa";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JR3diXwk"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A261DA622
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 20:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728333570; cv=fail; b=rGLGlgFTiUfCtSFX6YFyMgr4VSyVZQmUGGWzPqlVnZFaJygWqT0p878xcqgATPy7jXjICCbmTXgIhtRW2b7zzExC6723ZEPyUAYH+ACphB6fyh+X4wa3l+Ue3gHfFVy33WUOeG5gjmPOHQdSX2m+gp3Hy9zVt/03OqAIksyfivs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728333570; c=relaxed/simple;
	bh=9QAg2ML2qXBIwKx7+olK6genUO23YAY3YMli+wPb3zo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kQXH0j/DcFZUUINC1cegWqQxpMTyLn6PjJbxBqVAhbPTg1N28IMcP2QcseTP2W7o4RIvDpL8+LO04LGaV2pYn2geI8mBZqeVWNs/YKaBWVO1hG1M3D9VLAqgsKWChV9Xki5HhH3hwIXKNtqAg1hWEgIfwaa4pDjiVVaBRGalPZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IZIAFoXa; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JR3diXwk; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 497K0b4t004752;
	Mon, 7 Oct 2024 20:39:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=N2kfw0rG7zL/UxsGBt
	tJVAbL3ZtFuVLqkrhcOdkroEc=; b=IZIAFoXau8s/4zacRIIb79/9X90wjLCpvn
	gjvZEnE+8Y5iuUT4nSn9gGvkCzCpgnWWUXVhUZJvWJrFM4wxzj0mC4UK96KrcjhH
	FwPyh4/q5dEZ/i7Eihx6YHMkrbHItxbIk6f1docC5Dg+1+0E+QYK6xLIBBhAcD55
	xeaTAze7FzTbRAZtS9lw6QniDTng0sSx2fJxid+JX+3CiEeA+jiUOYavxo9wTKhF
	gN+Eu9cmntkx0ZaW7gX6FJInwMEWTHtRONiKyVBubQoc3L41bFPmkPlWjfghtXGv
	HVF9ZYfkDFAPB6oUrg2FUJThKya5F8ZxByIyhWNKbeTSUizgqK1Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 423063mb94-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Oct 2024 20:39:15 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 497IlIk9003002;
	Mon, 7 Oct 2024 20:39:14 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2172.outbound.protection.outlook.com [104.47.73.172])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 422uwcjnv5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Oct 2024 20:39:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cyQrOaOLElOsCZksTlLuLn8OC7slKRajXKLxVtMIUwk1KNaxwp1CgKxKygBczxWdpHPBZcnNnZ52HsHcimES1ndtOvA5Ftg3BEZY+fRVW/To2ZemofFgeEZjfIez9K0PFt0SkuEfwzu84vDbq99bD8U6XxESOYVIgDf7OOhV+XWklmCKCC+EQunl0+cqTzkBFHI0QileNUapnRf6TWrH1vodktWmz6LWVI4tvTMha5GNImdBqHqzpCNWypr3mMwAElwJKAVLhoXmk/R1cQLrtSbma0NE72KLxFKovl//cGKkxVkALaPZ4Nd7lncDotVptbvb/Wg4PnajScsx4MDdDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N2kfw0rG7zL/UxsGBttJVAbL3ZtFuVLqkrhcOdkroEc=;
 b=kCvCljKK2dFcnoOszDu9wT2tFHcQpRtUAqbAQQPp1Pr5vIE7s+L6PMeaJDtejjAl0QjJvhx83a8AecHCMRg/pK0zvJzNRVu60pxO6exLBsKeHtrEc3nWmYS6TbgJtHfZ+M0ofp1QK0APqR9ghHILc/xBI47e3smWHtNS98he2VQaKmBQfUhAoSw4/tDDzxN2Ko5JbFkQDjtOCiZdML/86wpyKN9wSpD7t2fSvPARojSbntyaUiSAmZCun5EyHczJb+lWj0wVLpULG/uFx8KE+LoHGKHmPEucVQafFzJIeGgX/4I6jE8R8RbkHTZG+bclAfBMOOHPPr6nCJ/jqmfE8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N2kfw0rG7zL/UxsGBttJVAbL3ZtFuVLqkrhcOdkroEc=;
 b=JR3diXwkfCsfVJDTOHJBWf+QHkJ/p6CswPGYitjiUCBAuE+RQiFwdPxsFitT79BGhQoVld+ySvdiEU980H7c1p30CjfD5XHj664QZBnqC0QojbYu0smzGylUllWIYWFW5vx3PiOTFvxVylIF35/akSm+26jvKYjvelMS45t6RGs=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by LV8PR10MB7847.namprd10.prod.outlook.com (2603:10b6:408:1ec::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 7 Oct
 2024 20:39:05 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%6]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 20:39:05 +0000
Date: Mon, 7 Oct 2024 16:39:03 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Bert Karwatzki <spasswolf@web.de>,
        Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        maple-tree@lists.infradead.org
Subject: Re: [PATCH hotfix 6.12 v3 1/2] maple_tree: correct tree corruption
 on spanning store
Message-ID: <u5rsu26cibfaahivtoy4pqqspitugkbabsm4djdxehfersgcaz@cui4hy3xrxe2>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Sidhartha Kumar <sidhartha.kumar@oracle.com>, 
	Bert Karwatzki <spasswolf@web.de>, Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>, 
	maple-tree@lists.infradead.org
References: <cover.1728314402.git.lorenzo.stoakes@oracle.com>
 <48b349a2a0f7c76e18772712d0997a5e12ab0a3b.1728314403.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48b349a2a0f7c76e18772712d0997a5e12ab0a3b.1728314403.git.lorenzo.stoakes@oracle.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0072.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:111::26) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|LV8PR10MB7847:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f8b3c09-bc0b-49e1-1097-08dce71015d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NBmEiZ4wIBduoSCdKKGXPrhhcPtV5cYyHShBAXL0ce6GOCGxkJ9p/pxtcPNw?=
 =?us-ascii?Q?UVLQCCHjDRLs8TeMtfPtVjNFNeQUkJ240ZaEspjqJtRYkjKxgCv8zuBmee+5?=
 =?us-ascii?Q?fzeZsXMfwqZCKWiCLfD7qx+879ct8W8hpxmJ3TmP2yC85DJABl3DqhbGo1mF?=
 =?us-ascii?Q?VDqSJY/NPm0oTphQcahrJAbgZTjd/IEDQF/j/60f/w9WXltuiQViSK0ebYLd?=
 =?us-ascii?Q?ZOHbUWzV/QLSN/S5bBcYQ5gN6Y9V86JGERanSspYroRYgObcc6d+LSGKxZdp?=
 =?us-ascii?Q?l1IlBgLIxA8tOA+TkjBkW8+5w73RttqN7HdBFmalHKn3SCtYd8h3Uf5J5NJa?=
 =?us-ascii?Q?+/EmCASbp5Ox3QN7/tYiVQllywcecVBtL+h63X3lQ9YJ/+JaJCH1GDsBj8tV?=
 =?us-ascii?Q?xKaet8eSqsYtDg7DOrrSRTfJNjFWXpntMH+Ua5uJ0Ftq7+FCNor0Iabgp//v?=
 =?us-ascii?Q?nBv1iFU1ijG57EuUWlEuVrmRZyPWughSKcy5GkNQ1wlUtCB0reIfp5CZTn83?=
 =?us-ascii?Q?//vUbJFraaKGgVSttRoCKfYbxy/KGKi6Qa1erMwdLBMf3cWxjNpVfJHwzPFD?=
 =?us-ascii?Q?xc2+xyiANzcbqIJ8KP4Nlj7gj6zRkE0cZykH5vE8XTNriLv8lPEWqdwl6qQa?=
 =?us-ascii?Q?wLNttwjIy7WVB4TNrRGH36otythT0gCn2xPlBPoOFnAt5VEKd0XJTOTErXK3?=
 =?us-ascii?Q?zmFl2ROdLixXvgtXO6pupC2T7WAqh+Qm8IaL+RmZXh41vr9kwAaF0VU5KF00?=
 =?us-ascii?Q?h0AZXYXibU+xYYX2Q15UKRxFsT9bGoE573WvVliWqJvB1Gq87dhUs3n64ZKk?=
 =?us-ascii?Q?MvFMVoVtBUr9gH6+jYY9fpXLvC/Zgzq0JSgEz6hRRdbwxggAEtsFo+BxTwlJ?=
 =?us-ascii?Q?xBAj9NtWBEpNKGr77cJYp5NElngV3h7HHi3Z3njW35V1S9gA8mhSypTjbXu9?=
 =?us-ascii?Q?tEesfPRm++9ayDLGTKBFhmZUFK9S0dV/BL8uXe2dtFo0xWDD6905vh0dwSzc?=
 =?us-ascii?Q?WlKTsCSq/vHJkCA8SnnIUkxA3fdCeJtubCJDljnHNNKciCmXaLEWYIcc+5IT?=
 =?us-ascii?Q?WhMwfS1OKLdoO9E3JhdhU7X0ak1yyAIamdiLoi0APPNytPSD+/t9iZMA/4Ng?=
 =?us-ascii?Q?qzzIJa5JY7Rq2UIqZGcmIaZo9t1kelrMlpKTQXDHUHn+xVRoPgj2LWWbcpkM?=
 =?us-ascii?Q?TTdkpOGs0YrxjWEt/xg1M8noD0YqXIStKZApw/4OVnBnukdXBzXuB9jg+84?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2bkuM6uLW6v7djbMDdmq7Wo6K8Ztr+xigYFpfcHOlNqxz64OZpAloT0DRfPc?=
 =?us-ascii?Q?5hnSsqOnsXzWYp3UUdQIN2VR0MdiOm0gjwFXmUR88KeVfXjtgvDWmHmACwSS?=
 =?us-ascii?Q?4TncbTwXkQd1wZlmwnnTeJX2Qj9TIQ1dgK8ZcfViIbsHc2YbkEcwGXkN/UMe?=
 =?us-ascii?Q?iYdDbxezxRrGOdXzxpmEpISspJBk0GtvGcc6QfiAqPwnRPiQ69P0N9dnaccF?=
 =?us-ascii?Q?T7mXVzCMTJ1pdsBzkQ2eZFRVHIoc3i4Aji9+i92UP0lG+pDLndYcD83City7?=
 =?us-ascii?Q?s3RA84y1S95CqCd6RzH5ltU+5oGjwd4fRVuVx7mqq4WDXCntoe51bOZz3Rhd?=
 =?us-ascii?Q?8N2ZHyZw89DTjqIao78I9M6xrAaQD0p5eguHSJcMuBs0kPsoOCcTgSgcYik7?=
 =?us-ascii?Q?ad+8bt6E6z1kVER2qenS0WK/terEKdoMNhFGRO6QnIMdtW55Bo+ylkREHIic?=
 =?us-ascii?Q?ltmex5KF7a2E9+kLeMf+THGgNRnpmR+YmQ952dQPog4i0RtoWq+IFP6qSuRX?=
 =?us-ascii?Q?cdUU75gDSzV412ul1MD05X2e6/wtWECmYYxX+NHB2pPIGG/Svs3CX9Lkvrgz?=
 =?us-ascii?Q?ojh/Ih+8S+3UHI+5VQXk+RFOWbTT8nSLG2ggKoI1mCa0SJJH6NDsfQAKrURL?=
 =?us-ascii?Q?cgw2WP0XqD2Zr29ue7oCFK6Jw0ttdXzwjALHFA+nWUJzMOcSBh5anSbVMdqK?=
 =?us-ascii?Q?fN3+Omtq/tLqYM2Aap0sanz1mtNU/TCK/ixg1NfMPoiycGIp8bkShZlWR8c5?=
 =?us-ascii?Q?xcDOTjW32pbyYsGa5f06nPDrCu4UFcSg/XsFGbTwtl0w5N+BgdkdZ5Y7qf/A?=
 =?us-ascii?Q?UrwFLsR2CsIpJkxgcK+CQxWQ2IKWP3WvSZT4VoGTPEa5nZtVR0xJii99sIoM?=
 =?us-ascii?Q?7R5PYw7WM21nTDpzpmsck1Bs3zKmLEZNqXd3EWwODxr/XLl303Gb9E3hpvpG?=
 =?us-ascii?Q?qLSle8kv//D0xw/nbkTDC7ZZnuamnY3tIFs8pAsA4oq0vC97rNcxc0KzEJq6?=
 =?us-ascii?Q?k74i0iGynju6Vke+ApFskE0wCR3KA9BFzksH+P8PAWKdqgDHH422U3F8y0H/?=
 =?us-ascii?Q?AJqnl/+E/Hnw1pocpRYFn/NFM5vE7Muhbrbqb2QN4Y6uWbx6t5IKZeH0RXIQ?=
 =?us-ascii?Q?8tUlSK1Csy7jc8p8I50lC8FagyhxKyh5ovJIksbsU274LvmTcMxscdLF2DrQ?=
 =?us-ascii?Q?N8YNiYQaziC49xGHFHqfP8R1twWLMfMi7gBI9yhg66VXoyHyDMnn0W4MO2d2?=
 =?us-ascii?Q?HRXOpU+y1jyvPELHkA512bQepbAkE0kv0FU/1Y3UzNaunnlIke+lw36WmnYs?=
 =?us-ascii?Q?9GJrFOTFx1onDbC1txsakmEQHASum5iphzMIlr7ut+8Ki9GioKotJMDycQW5?=
 =?us-ascii?Q?WMjba0ayVlDC4IxyefUlcGGvPu0TCkqhyC/a5eV9uqXFSz/DOJJjjOryWeIR?=
 =?us-ascii?Q?uNLBMHp4CGpgVHuUg69oVI2L7aQ52vrfrvcn2IoGOtqotf5makw1sHKlSeCJ?=
 =?us-ascii?Q?+nE7HVfLgZrZQVTm27WJg1i2HB1TaIWRty16VT+pXXwmn0g8LkPdbaoqCPgL?=
 =?us-ascii?Q?SB8dZRWD4i+tVevuNO8VsNfMOARIdnc6XghF8Mq2?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WF4w92nu+hEFxYf9wP0BshMIY05Kpb+4ORVyI4Z8r/lOVq9pvYS9PdsY9IOZSezqsEz2MuVn+cHazI5/bjznuY8cLTJ9inlUDDSoQ7uoyQq2yX6FN2WNFnrem7qlg8Go8iSZDxC1BjuZP/eYq9AZK0hbZDuLR45EKawPnnRub/Ykz/s/GXvX+Ii5Ak0iqB1JSBLQpNvYXVZ+LhzXi/bX2R+ft5CF3Hl1n4hY0zvDWBE0fQuGMg5Nxfwfb5eTKkhS7nNsf6NQW/WDDuDJMyB/ixxfjPARBIVUR4XBB/G3Rdyh6NW9dFhf1udAxvjAAE90k+80EBRD5K/NQiLty5sLfFgEFRPu/92YBLlMJdaqJEayjGEz8BC6Df+B+1jAty6rVND1ZvJ0Z683m/jzyjf++cfK0rD3gKDiDQQwL89AvG1+LF+cgWklNVqlZINg8SWpnIedamiGncTs5gfGcojEH3qc/kMqcxzL1vHHq+ZrYHkY6u5osGCdT0OUTcCLQVvS+EGEvA0vhC2pGGzDKEbQ43bfZDaMeTT0FeLMQUDV7E6pApD5BZ8OHFUkFcKKP2D+6L4+0RYFunLi9Gzh0RmXq3LciSyqcvTx1Ky49h+m6p0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f8b3c09-bc0b-49e1-1097-08dce71015d0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 20:39:05.2248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: efqQU6syDkjqHMEGnaG0sxw1kK3YnjADOM7WJoI71fMvK0sqHkRz9lL7+wim/G1JhPz5xsAt1RK25VwnUPkCiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7847
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-07_14,2024-10-07_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410070142
X-Proofpoint-ORIG-GUID: fDc3xOY9EY0P7AGICdHpzMdt7xDmhWHq
X-Proofpoint-GUID: fDc3xOY9EY0P7AGICdHpzMdt7xDmhWHq

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [241007 11:28]:
> There has been a subtle bug present in the maple tree implementation from
> its inception.
> 
> This arises from how stores are performed - when a store occurs, it will
> overwrite overlapping ranges and adjust the tree as necessary to
> accommodate this.
> 
> A range may always ultimately span two leaf nodes. In this instance we walk
> the two leaf nodes, determine which elements are not overwritten to the
> left and to the right of the start and end of the ranges respectively and
> then rebalance the tree to contain these entries and the newly inserted
> one.
> 
> This kind of store is dubbed a 'spanning store' and is implemented by
> mas_wr_spanning_store().
> 
> In order to reach this stage, mas_store_gfp() invokes mas_wr_preallocate(),
> mas_wr_store_type() and mas_wr_walk() in turn to walk the tree and update
> the object (mas) to traverse to the location where the write should be
> performed, determining its store type.
> 
> When a spanning store is required, this function returns false stopping at
> the parent node which contains the target range, and mas_wr_store_type()
> marks the mas->store_type as wr_spanning_store to denote this fact.
> 
> When we go to perform the store in mas_wr_spanning_store(), we first
> determine the elements AFTER the END of the range we wish to store (that
> is, to the right of the entry to be inserted) - we do this by walking to
> the NEXT pivot in the tree (i.e. r_mas.last + 1), starting at the node we
> have just determined contains the range over which we intend to write.
> 
> We then turn our attention to the entries to the left of the entry we are
> inserting, whose state is represented by l_mas, and copy these into a 'big
> node', which is a special node which contains enough slots to contain two
> leaf node's worth of data.
> 
> We then copy the entry we wish to store immediately after this - the copy
> and the insertion of the new entry is performed by mas_store_b_node().
> 
> After this we copy the elements to the right of the end of the range which
> we are inserting, if we have not exceeded the length of the node
> (i.e. r_mas.offset <= r_mas.end).
> 
> Herein lies the bug - under very specific circumstances, this logic can
> break and corrupt the maple tree.
> 
> Consider the following tree:
> 
> Height
>   0                             Root Node
>                                  /      \
>                  pivot = 0xffff /        \ pivot = ULONG_MAX
>                                /          \
>   1                       A [-----]       ...
>                              /   \
>              pivot = 0x4fff /     \ pivot = 0xffff
>                            /       \
>   2 (LEAVES)          B [-----]  [-----] C
>                                       ^--- Last pivot 0xffff.
> 
> Now imagine we wish to store an entry in the range [0x4000, 0xffff] (note
> that all ranges expressed in maple tree code are inclusive):
> 
> 1. mas_store_gfp() descends the tree, finds node A at <=0xffff, then
>    determines that this is a spanning store across nodes B and C. The mas
>    state is set such that the current node from which we traverse further
>    is node A.
> 
> 2. In mas_wr_spanning_store() we try to find elements to the right of pivot
>    0xffff by searching for an index of 0x10000:
> 
>     - mas_wr_walk_index() invokes mas_wr_walk_descend() and
>       mas_wr_node_walk() in turn.
> 
>         - mas_wr_node_walk() loops over entries in node A until EITHER it
>           finds an entry whose pivot equals or exceeds 0x10000 OR it
>           reaches the final entry.
> 
>         - Since no entry has a pivot equal to or exceeding 0x10000, pivot
>           0xffff is selected, leading to node C.
> 
>     - mas_wr_walk_traverse() resets the mas state to traverse node C. We
>       loop around and invoke mas_wr_walk_descend() and mas_wr_node_walk()
>       in turn once again.
> 
>          - Again, we reach the last entry in node C, which has a pivot of
>            0xffff.
> 
> 3. We then copy the elements to the left of 0x4000 in node B to the big
>    node via mas_store_b_node(), and insert the new [0x4000, 0xffff] entry
>    too.
> 
> 4. We determine whether we have any entries to copy from the right of the
>    end of the range via - and with r_mas set up at the entry at pivot
>    0xffff, r_mas.offset <= r_mas.end, and then we DUPLICATE the entry at
>    pivot 0xffff.
> 
> 5. BUG! The maple tree is corrupted with a duplicate entry.
> 
> This requires a very specific set of circumstances - we must be spanning
> the last element in a leaf node, which is the last element in the parent
> node.
> 
> spanning store across two leaf nodes with a range that ends at that shared
> pivot.
> 
> A potential solution to this problem would simply be to reset the walk each
> time we traverse r_mas, however given the rarity of this situation it seems
> that would be rather inefficient.
> 
> Instead, this patch detects if the right hand node is populated, i.e. has
> anything we need to copy.
> 
> We do so by only copying elements from the right of the entry being inserted
> when the maximum value present exceeds the last, rather than basing this on
> offset position.
> 
> The patch also updates some comments and eliminates the unused bool return
> value in mas_wr_walk_index().
> 
> The work performed in commit f8d112a4e657 ("mm/mmap: avoid zeroing vma tree
> in mmap_region()") seems to have made the probability of this event much
> more likely, which is the point at which reports started to be submitted
> concerning this bug.
> 
> The motivation for this change arose from Bert Karwatzki's report of
> encountering mm instability after the release of kernel v6.12-rc1 which,
> after the use of CONFIG_DEBUG_VM_MAPLE_TREE and similar configuration
> options, was identified as maple tree corruption.
> 
> After Bert very generously provided his time and ability to reproduce this
> event consistently, I was able to finally identify that the issue discussed
> in this commit message was occurring for him.
> 
> Reported-and-tested-by: Bert Karwatzki <spasswolf@web.de>
> Closes: https://lore.kernel.org/all/20241001023402.3374-1-spasswolf@web.de/
> Reported-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
> Closes: https://lore.kernel.org/all/CABXGCsOPwuoNOqSMmAvWO2Fz4TEmPnjFj-b7iF+XFRu1h7-+Dg@mail.gmail.com/
> Fixes: 54a611b60590 ("Maple Tree: add new data structure")
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>

Reviewed-by: Liam R. Howlett <Liam.Howlett@Oracle.com>

> ---
>  lib/maple_tree.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 20990ecba2dd..2fe59c534328 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -2196,6 +2196,8 @@ static inline void mas_node_or_none(struct ma_state *mas,
> 
>  /*
>   * mas_wr_node_walk() - Find the correct offset for the index in the @mas.
> + *                      If @mas->index cannot be found within the containing
> + *                      node, we traverse to the last entry in the node.
>   * @wr_mas: The maple write state
>   *
>   * Uses mas_slot_locked() and does not need to worry about dead nodes.
> @@ -3532,7 +3534,7 @@ static bool mas_wr_walk(struct ma_wr_state *wr_mas)
>  	return true;
>  }
> 
> -static bool mas_wr_walk_index(struct ma_wr_state *wr_mas)
> +static void mas_wr_walk_index(struct ma_wr_state *wr_mas)
>  {
>  	struct ma_state *mas = wr_mas->mas;
> 
> @@ -3541,11 +3543,9 @@ static bool mas_wr_walk_index(struct ma_wr_state *wr_mas)
>  		wr_mas->content = mas_slot_locked(mas, wr_mas->slots,
>  						  mas->offset);
>  		if (ma_is_leaf(wr_mas->type))
> -			return true;
> +			return;
>  		mas_wr_walk_traverse(wr_mas);
> -
>  	}
> -	return true;
>  }
>  /*
>   * mas_extend_spanning_null() - Extend a store of a %NULL to include surrounding %NULLs.
> @@ -3765,8 +3765,8 @@ static noinline void mas_wr_spanning_store(struct ma_wr_state *wr_mas)
>  	memset(&b_node, 0, sizeof(struct maple_big_node));
>  	/* Copy l_mas and store the value in b_node. */
>  	mas_store_b_node(&l_wr_mas, &b_node, l_mas.end);
> -	/* Copy r_mas into b_node. */
> -	if (r_mas.offset <= r_mas.end)
> +	/* Copy r_mas into b_node if there is anything to copy. */
> +	if (r_mas.max > r_mas.last)
>  		mas_mab_cp(&r_mas, r_mas.offset, r_mas.end,
>  			   &b_node, b_node.b_end + 1);
>  	else
> --
> 2.46.2

