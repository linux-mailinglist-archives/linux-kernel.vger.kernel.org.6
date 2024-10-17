Return-Path: <linux-kernel+bounces-369464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD159A1D9C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 10:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DE871F22691
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 08:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D55F1D3185;
	Thu, 17 Oct 2024 08:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="D9lBB9ZZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="j4ILgO7W"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A2F154454
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 08:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729155282; cv=fail; b=c3xnW1j5dDHFJr+otifNGjmhP3OHH/m7gGuQCVaW1TB4nrwBc5xlAGplxmdjjRzhlGhFJU6KD2JDOt4plRCfW5qCQj0kAM4AzQclUWigLI3YRI2r0L+UxBq38H63DpJHfpUjIu63/nmFhOC2sK9QjEBe+R2SsSvxexyy6fBjZOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729155282; c=relaxed/simple;
	bh=2zuLtvw7DNIDARAf/yBxdUjdNQ0p9ZOUdqBkWU1JKkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sco9jaVmC1Nj/4qE0hc0I808xLMr4pyf0LJCZMXTHh8TU/7GrdbMPKY9Rmnv9VXuKBVgGy8yf2jnRbofXgCNDgoCqpvF7mT4+ALryMfz19ZjaB0ifHadRxRcLo1WSSmGRHyTPfrMOWaTInB0/3hHQQUiJNAtmvpOFN4tRjG5ZoE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=D9lBB9ZZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=j4ILgO7W; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49H7fhYc009815;
	Thu, 17 Oct 2024 08:54:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=2zuLtvw7DNIDARAf/y
	BxdUjdNQ0p9ZOUdqBkWU1JKkM=; b=D9lBB9ZZGX0guRd0qViqQ4SDTk1QY94ZvD
	/Mttkn3GxspWWRWm24ERET+O5kHaekoVxCDFaL6+Br97Xyi7HLM8ZC+haUKDBfEN
	tC6bQZm1GHKIEn6hD0IPYCkDj7dZXYpEcwkvgkU9IDAaXJl8k3cj8phLss4TLxND
	tiu/dzMRc7piLoghmMUso9GaPT2IkumY5oiNHhkrcTTS1EtZ58CAqn3batw20LI+
	HR/UcHFX0cMcGC4aDzdlrV020yu5kiAd2blP0ZIKoLuD7TuwqWo0+RO/Ku6jGDY8
	dzu91GYKokh3DciWwaCroloEyV0cxTXWP6WpHyBppNyErzq81Mfw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427h09na4h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 08:54:20 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49H6lo6b026369;
	Thu, 17 Oct 2024 08:54:20 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fj9xce4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 08:54:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ll+GG5zFi5BwMFxdPMafEw7lhUEFr0mmrUhNKu7kYeskWEZS9Fq5ZwpsYejDtUwTmrMLqf03VnhBZAdBzREW5j7wPk8oRtfECv4Gnw7tWKtNj7m3PsqZGCjuMfrlJIsS9Qa7Io7mCqm0yNzJXegbBZXHobZ7ZS9TLUITh6+pwQcvkGjojYPAt2W4Mw6/a5uSI1V4ZcdV/gZU5xpywhXIYY1OE5IX8mFLehzOxloQCd4GugoEmWXsZuT5AjJ8cQ4SH+I0MPW/pbUj1M5nJJIkby4iD7d/VRMZSehp7TZ1W02eotopqbOwAob/EO/J5JunFQhe7xMd36kFvmqzY16CeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2zuLtvw7DNIDARAf/yBxdUjdNQ0p9ZOUdqBkWU1JKkM=;
 b=UhDm5Yf6cyM4fY7kreIAytX1SYKO0UGRDlb4v0wZvlB6HblNIoUv4iwIKj1U4GXEFpFKDDiSmb1Ntai3UsBnFGpSKg+rRVd3p0OVph/TwZvmlbRB7UBGtklIT8vy8VBoqZvKUhzrPxZvL+QrsuA+4WFLynpagDNINW+xGGvvFr0dPtb++xUUz/CoWN8NNAcngQTcUMZAnaKqF53BPTeFOvFfL2Ao7U5TFjJuLXMuw+zyhiBClWIRu1+z7ONSOve3kFEExYV/Z7Bme/BxNxWz9kGVfPk8w9iZ/kciNtrBJqSpwRWr7BK3E4Kq4WPFVElEMkwPdsHpBkGJ7mVr6kXmvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2zuLtvw7DNIDARAf/yBxdUjdNQ0p9ZOUdqBkWU1JKkM=;
 b=j4ILgO7W3OkGbusUrwlRYOn1Y8DObm9uhzOHsA/r+xyg/4aqC34HQaQjd1JnAhukxVbEEzO6h6FuO+JbnCJqQ9fVyWH0ro6Saq7conzO/eGOY5OLvEB+bWzAjZ45oeLpdosKthrKaAc6F+GOIap8Qy50dRUnvZYc+UzX46yXGCk=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by IA0PR10MB7603.namprd10.prod.outlook.com (2603:10b6:208:485::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Thu, 17 Oct
 2024 08:54:17 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 08:54:17 +0000
Date: Thu, 17 Oct 2024 09:54:13 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Oliver Sang <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Bert Karwatzki <spasswolf@web.de>,
        Jeff Xu <jeffxu@chromium.org>, Jiri Olsa <olsajiri@gmail.com>,
        Kees Cook <kees@kernel.org>, Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
        ying.huang@intel.com, feng.tang@intel.com, fengwei.yin@intel.com
Subject: Re: [linus:master] [mm]  cacded5e42:  aim9.brk_test.ops_per_sec
 -5.0% regression
Message-ID: <ac1e101c-f3ed-4e9a-9ef4-37788fce4680@lucifer.local>
References: <202409301043.629bea78-oliver.sang@intel.com>
 <77321196-5812-4e5b-be4c-20930e6f22bc@lucifer.local>
 <ZwTt/wB/mmszSXc3@xsang-OptiPlex-9020>
 <8f5e8ae0-dfaf-4b33-ae79-ca6065dc96ec@lucifer.local>
 <ZwYmTnWEhgWO702t@xsang-OptiPlex-9020>
 <5b7227fa-d0f1-452e-b1b3-9d7b87641522@lucifer.local>
 <ZwiRdemGMY6Z6pSN@xsang-OptiPlex-9020>
 <fa645dd9-3835-4e1d-aa04-1892d97a6c86@lucifer.local>
 <af510726-4245-46c1-81bb-e32379c2c127@lucifer.local>
 <ZxB9XpvYoDrYgnah@xsang-OptiPlex-9020>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxB9XpvYoDrYgnah@xsang-OptiPlex-9020>
X-ClientProxiedBy: LO4P302CA0042.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:317::14) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|IA0PR10MB7603:EE_
X-MS-Office365-Filtering-Correlation-Id: ba5bc7df-8d0d-4f2f-20ea-08dcee894830
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?esKCAtBEocFiKf9Z3TzHWajkm9KMwNAzL5oaBznfgOAjra/BicMcOiE2Netx?=
 =?us-ascii?Q?pPG1DeXgSkO0CLj0isEJYgvf4vDlU6wKKlz47ZsPaIgxwmEMqgci3eyaB3uG?=
 =?us-ascii?Q?AE339/2SWAQGRHChyBYUmLts3umjNt2IO8Jjad+n/ndQAuCMiWM0sJH/9yCB?=
 =?us-ascii?Q?lUj6NkAoRG7jvjJMiDiCeOBh58QHsGeI9PdrCk4C0Ask1BcrD8a5aUybVi99?=
 =?us-ascii?Q?/rb1DdBmnYmlfHyalrWG6KnJZtIHQFKTK6/YXmboP5AG/7hY6AcZLZsLWYwR?=
 =?us-ascii?Q?oL4qrlkyIoAeW1ezKGHnmWdvJqpEXJetbhTgZ3Ee/zcyvQGA1pAUOMBRAonb?=
 =?us-ascii?Q?NTN+hSLZEq2SqAsWlC/NxrwSsMjCE/95Ia2ngBVYP/h++SyBUuwZAVFupOdA?=
 =?us-ascii?Q?vSXzcFZiMCaXTJEs7fogbbs55iSv2fvAN/9TnPnmQh2hTymeYnNiLPrvJ/1V?=
 =?us-ascii?Q?RKmbtzsGsH853DXILTeWSrYV1XPR3w+wuGQ1lcoKX0WOI30btd7HBbfSw3NW?=
 =?us-ascii?Q?UjbShYHbbCiwjbvaCXitG6L0o6PG9KMJKsWmNnAGO3FhrKrtxAtLwMS7Dn37?=
 =?us-ascii?Q?fEdXETJbrPEDDLUs1ZhWh4wiHB4cuowwi9Ju3iJXSk3vz2SbRwTfdXpi12vi?=
 =?us-ascii?Q?6Wnr2+5NJILRyBApsNzouoKgcYeLzBDvst3vvGxJgfAs0cyAoSWLZkF8ep7g?=
 =?us-ascii?Q?EkkjocY3xUEowe1uCWrgSdggpx4ZI3fLpqiOzWLL/TxfcgpRH8JeJd8Dwe7l?=
 =?us-ascii?Q?hS9ZridnSPjig5N95dBSG5lPUC6zY2wYFWWZwxpWDJGXiHGHHj4QDvK/OFqm?=
 =?us-ascii?Q?Rp7i8sadsl1w62vznaXmPN0ssM/mMxpKbRO41QpUBXbTmCBLjHGL8MwGMP6K?=
 =?us-ascii?Q?vWWHD82naYfejkg6RnVArnyqpNaXlnwRs4wHJR9M+x6xBPk19VKZqTkJvm8G?=
 =?us-ascii?Q?Ocfkvi3DfthqBnNioMZ7BU3RWHvXgi0HFRBZF7wHGcIebWkhFEKpKV4XDCJi?=
 =?us-ascii?Q?DqqpT7O+lN2ez5aPWea14sJphNbfqZoqroTVrg4qSQKTsd93L5yU3BP1AQXt?=
 =?us-ascii?Q?vwZPdO/e9OzV2qfiT/R0BYYnBLrflNVUMsjEXVEAkIP4BSYVxiX7TkygfyZY?=
 =?us-ascii?Q?E2N0UIph7GFi/0uujAMXBfLmMn9NGzefp2ztaqWKBQI9WNzDAihvly+ivIdm?=
 =?us-ascii?Q?xyMCCoW1fOyrJMNyDp8v+aAdMsCRRy+OoO2Lh1XiNzvDgRA60G2uKlJJPkS+?=
 =?us-ascii?Q?1edoVJkoyeBuluQQj1r9G16t5/G8jfwlEeSux7k9UrXJgp5JK8Nvn9wS1di6?=
 =?us-ascii?Q?5/N+wopUH1yM9SAbvo4keiBY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tXCo2/mQMDBN/68LtPaIYNX9q+vA+hUjYAarHeEAfeX+WGTXpmiyhOGZvEL9?=
 =?us-ascii?Q?HBWpTokZ0wzAC68o8olcG/itDZT1P6PpdAjlPj+23o2vFUHQuveIVOtYiDD2?=
 =?us-ascii?Q?a8ILo0mwr1QW8XXSDpaZRN87Ca4ZH6S1LGjkjh5Po6D8Py7dSVxeLWOvCQ45?=
 =?us-ascii?Q?6S02x28czKT0doizV3Ktw9UnBvYwPZejOJHnYp48Tf/fXAPUl+B20P9VvEzJ?=
 =?us-ascii?Q?6BjPWC5wsYj8sh7OKmgD52nTexuUB+OVXmBgCSdHVAlPBstylquWcHA+wBKB?=
 =?us-ascii?Q?YC+E0B6GounDapGyEK2953sk3RuS/9PYdMfcsQipB9N25JpKLzxKcAcHsm5v?=
 =?us-ascii?Q?eNLLy/ew7WPymxytFRc/Y8SO7zgdZfMFY5j87YU0K3O9kL4uA7Jsod6AmaCd?=
 =?us-ascii?Q?aXFkNA5lE6gBFDsI2IzLMVztIrbzD234S8sBBtMLv8W5OSkDxKA9OvfQryyj?=
 =?us-ascii?Q?af4bN5jjk3oO7qDKe6RW88uWsUyUE8Rcw9E9oQtDXdi59N/v/X/OeadUAhNg?=
 =?us-ascii?Q?5rqu+s99QxHWswrqX1CLeT0a/uKkaF1ogBVh4yz3QF5UUCsMfozpUm4PQg+B?=
 =?us-ascii?Q?KLFc4X/lXYu7h9nDZ7uCdGcV4tHYd5G71XF8zaRfpuNyXK381BTWo0qgbiI2?=
 =?us-ascii?Q?jJRIjpUKsLjneRS/9xiL24CtkNpVM1cc5Jr7+/Pdt5kO/WEPcu2H3nu2CLi8?=
 =?us-ascii?Q?ASnnI2MGbDKK5eHKlmq9g0xvk5HLcd+tVg9plBqxvv/DQN7Wbpe8ZL6fJwDh?=
 =?us-ascii?Q?JFcdV7IQcZXgFdkLoJYOcy1ZwuqSoEmETYljlWuPDOSDFkAiglzWAiQQSHVD?=
 =?us-ascii?Q?WJSgYtl6tB7uK6yjfRPF7ZkvYYHYM1H0GzJZrhYnGX5+yxVlN8l/xBgoXE3m?=
 =?us-ascii?Q?Ust2hsDaF99GHB25f5Tkc0q/gqmcT+knn7B3uHC/5p6NQU/TNSs4my7RzxM1?=
 =?us-ascii?Q?QOtM0eTQ6uBKXC78Jc8NHghzSB0so4/tA4ffypTpmIm6GsenTqDvO8HJTAte?=
 =?us-ascii?Q?HNbAvzHQw7ov6ccQLzDESOmnDqLazW+Td2RcC4h9zfObVqlOoH0DEWnRJC7M?=
 =?us-ascii?Q?JEYp+Bd0WkhsUegWDl+JCHL7oDIUphl3/HV3Ia028HF7s4DkNdezwPQF7ywT?=
 =?us-ascii?Q?uw/RWJBZne4FlH5bHLlnQDy79XqhmkpI4pBx/M5xqvjR+UuMO6ZomwlK4pzs?=
 =?us-ascii?Q?bSAEDvjCTSyUA8+biohZL/36CywbUv86DzLih6Nwy+OYsSx6jDBAo6HJnC9M?=
 =?us-ascii?Q?FJPx76qTGdcsw6NYP5RHnjr0OXZ/8NEXAmEZC4CQ7yojzMqJxnEjzO3JzGhi?=
 =?us-ascii?Q?S262LhEc4cbTmVpHKoGipeeKrZCrzUF/Svs2o06pobvTy9RIt0J5wl15e3do?=
 =?us-ascii?Q?JsMEvMT99VIuHXXWH8plN4aGQu5dd2Ja+bba0FJrfTrWfeCud/cw/q5wGXgI?=
 =?us-ascii?Q?aBIwZUsHuu2uZdfe8oveKwNtOMlx3RtlJn9fMp/gXaAUvI771ORF6BFXimbG?=
 =?us-ascii?Q?vE7bkYq73hT5B3ZEDDkPw6MJhDTDIT7L6szr66OlzCo0vJphz6lVCqrS7m2o?=
 =?us-ascii?Q?THjPX0wNa7q+9L6v+bwuuzatK9RQGT4qgXMgcIYZFwhia5SOt2nnMdwgIz7E?=
 =?us-ascii?Q?RA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	86GLnR6a4zbQ6XE+EeSnXMd27cbWWDUyk9FZ5jxxmGEhy0Qh7Fof877XIozVTYN4zvCVNPyR9CUHDW3EcqcnIN8ZaUT53L0AbpnQimiM5qTvTq1gTCW+HznTqvrWG71WkDUNCkMPAw4qwkw4nsAwwrKDUdYBGxuLIUVN5zY2muaJKVY57+PBForDw2KwdlX9RaUOFNBqY0l1YVPZDW3HOj9xE3kfqPFlP4NxiW0/Za1UMdYcXok2BymimtT6/ntDPTNgV2I0Ku0gJFflw8+oxIy797Nd6ks6N0A+g/TQ1zHdTw4E4GMoSDpYXKWbdmNcFbEbVVXWDrnQmGjV9bExoPCS28t/zPRWh/tRWHUrRG9ZVg+OAUZX0JDhnV1+ZJ/JH1kXdA2uHGrtElM1+VweWCQMXReQIY4Jnl9EdUvYlrl57pi1Z+6If7QeHJ0afkxpVNWVCKryW+cmZfkDndFT+FlIe78IvAAgwjcT99Vgc8bvXU3yG7+3HfTVPMigU9tew39Xona+2qll3NFfhM9bz/ustUf9Rmb0wU2ndVZnz02ba0jjR3S1wDZQxGcSkIlGCq+WR8BSO7dUGOL5bgb0PiGRbR7NZhzi/hKR0CqXkn4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba5bc7df-8d0d-4f2f-20ea-08dcee894830
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 08:54:16.9702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fpeeb9HzQgRxj4h2jEgoUSZ4fYxea43QLTpeIFee1AqbZMEcwkUvzxaJ7wYYfsA5A9rcLRG+5TxZ764pJtl0Mdv5dWvDwenR3I/fQJa7zxo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7603
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-17_08,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 bulkscore=0 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410170059
X-Proofpoint-GUID: UxR_eLo9fv8KlLDnm2Q8PDkOmSFAxOsO
X-Proofpoint-ORIG-GUID: UxR_eLo9fv8KlLDnm2Q8PDkOmSFAxOsO

On Thu, Oct 17, 2024 at 10:58:38AM +0800, Oliver Sang wrote:
> hi, Lorenzo,
>
> On Tue, Oct 15, 2024 at 08:56:28PM +0100, Lorenzo Stoakes wrote:
> > On Fri, Oct 11, 2024 at 08:26:37AM +0100, Lorenzo Stoakes wrote:
> > [snip]
> >
> > > Thanks for testing this suffices to rule this one out... I will try to get a
> > > functional and reliable performance environment locally so I can properly
> > > address this and then we can try something else.
> > >
> > > Thanks!
> > > Lorenzo
> > >
> >
> > OK Oliver, could you try the below patch? I have got aim9.brk up and
> > running locally and for me this seems to address the issue.
> >
> > This is against Andrew's tree [0] in the mm-unstable branch. It should
> > hopefully apply cleanly to -next also.
>
> I found the patch still be able to applied to cacded5e42 cleanly, so below data
> still based on this applyment.
>
> $ git log --oneline 9cecc5dc893886
> 9cecc5dc893886 mm: add expand-only VMA merge mode and optimise do_brk_flags()
> cacded5e42b960 mm: avoid using vma_merge() for new VMAs
> fc21959f74bc11 mm: abstract vma_expand() to use vma_merge_struct
> ...
>
> again, if some patches in mm-unstable or -next have some impacts, please let me
> know then I can re-apply the patch and do the tests again. thanks
>
>
> by this patch, we do see performance recovery but not fully.
>
> e.g. for
> model: Granite Rapids
> nr_node: 1
> nr_cpu: 240
> memory: 192G
>
> we got better score from the patch than cacded5e42b960, but still 2.0%
> regression than fc21959f74bc11 (the parent of cacded5e42b960)

Thanks for this. As far as I'm concerned this puts us into noise territory,
so we'll go with this as the solution!

A side-note, the brk2 test from the will-it-scale suite, written explicitly
to be more real-world representative, sees an actual performance
_improvement_ here (though small).

So overall I'm comfortable with this, we can revisit if anybody raises any
objection! The benefit in de-duplicating code is very significant.

Thanks for all your help, hugely appreciated!

Cheers, Lorenzo

[snip]

