Return-Path: <linux-kernel+bounces-248166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 864FF92D90F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 21:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAC231C208EC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 19:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB53199229;
	Wed, 10 Jul 2024 19:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AX/xobzN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VKP4w5zX"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A2A198A33
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 19:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720639432; cv=fail; b=dcRg716PvF/Kfi2A2umLY/myxUdB5FrA5HLP4/rbtncHoX+yOw5AWQiGXelcOzBC1PTEw+8I5XInHehfc+5HVCnk5tlW2vocSYA7tSPEHtjANPWthxXC73FCLfel6SDGlttzx53w4nOrgljX7nq3cllw2Hctf96aF/MxAoEBJxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720639432; c=relaxed/simple;
	bh=dj2NiLRtkw5fofhP9PCHC6J8Nf5sBVmmycx15qEpjLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dwMlZdnFsNELEneXS4tBWEs7q4IEo7QhhreZ8EERbmqDtgI3Iez0Nh7j6ZuDmIUFPle2+BUxLHcqT+FFOTbidbBYI6BI8TSu5VGl8gPZwXs6so+aIQcBusGJ0IWto+5TjsKHLXlFDnSpt5wDmkWZGdlGMUWh5VuJ/lE7JMoLhgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AX/xobzN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VKP4w5zX; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46AFnCs6006199;
	Wed, 10 Jul 2024 19:23:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=DoMwpLBw9WhZL+32pCwXz6AxsApbM/3+qs6lMKa9YfU=; b=
	AX/xobzNpcaC93CQ/gONwDiwfTlO7M1FYSPrAbQ1/WRzn4Csjaeo/dSiWNZbEnFf
	TOW5u/kcKIFHkm0PEiXk3lbtja9apMp3A6KNX1BE6gktSFzKfCOKjQr+MaZ3MXiX
	klj0WL/wdlgf/ZK07/GojAdVJEb+nbAcQC/P8XZCUFHN8P6sTspo1ot6ElLKU5cG
	8etjuqg+vM+HUojYC6xmFOTnllXxa0m1LMVxTqD21ou7i6FgrpaVGEnKL1UzS1bn
	WWKOQsMeyP827amwmIK0wEdbhxmxngVJr0xxVGU/xCTIqt49toWLhbtS851bLtil
	nuHCm9Luykvw8jR6woU6qw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wknr2ef-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jul 2024 19:23:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46AIdNi8033802;
	Wed, 10 Jul 2024 19:23:33 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2042.outbound.protection.outlook.com [104.47.70.42])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 409vv194ff-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jul 2024 19:23:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EgnSyBUxoMFG2pJKEvwTuoGMlNrmfyWVvdl9hKjdJ3s+ZX/iNf5K456AAcspMPd980gt0Gevs+pITuyfWJboC3iH1A9j6gd8tYCCgJXHJ5xDh9SX7faF+7GQbCrqS8X/jZ6M40jYjI6ZGLVY9TH1LOTTeMSN5/0eQNnsX97Z/kRT8n6G0IMThceUTUyLXQTdMsk0fiNoTioYcqEBA+oJP7rvpkE9rpq9D5sb6sIkHwdxbUjw45+j1hiEskbD6ZQls1UBZkMRz0IuAQH0SvcC+1yIaUx8H2P1LAiuAxm8meLClO1Pzab/uSHGOfh5HDiN8LLJoMswej/xzEumr3UeZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DoMwpLBw9WhZL+32pCwXz6AxsApbM/3+qs6lMKa9YfU=;
 b=Ko46QYqr5Hv1LabKsd+DBcVHPp7lu1JrkDII0JbXUSW/Z/SMg36qtU6mwz+AsdwwnB+IgU30D6yqLquUol+7liRGFsCdzlj3ITb82qiEubuYjPSZYPaxmkwfklmEqLOh/j55NV5bI6yQSxp/TNgSV+3jU8mf50s1WCMpbsMm2sODWN8Cgt/zpwMYtFlkPlhlxDgCxffhM0LH2v5qMikU4TZc046EvLxhJ9N4RPvXSIw9YbCPH1/Fiz8jdyBw8jKshald/SI6g4t6+Whgv/EuUBN0dEz6RO1vFmwgDuny2btiOSSIev8yiPrELD89lJ/JZO/O+/lXRmvDab3NzKL1Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DoMwpLBw9WhZL+32pCwXz6AxsApbM/3+qs6lMKa9YfU=;
 b=VKP4w5zX3yXehde+vY7BX6ZPojKjD+MQOcOORfEZB11B7cYI8W+LbfctsYgs3lSKbZtzBckB7QkzXJnDQzTtzYuIg2aOaW9TzBDaXPh7Ph0W6jYVyutV6XejgO/9+TOlZsneeJUkSu9+yqqGNIZscdJ1bWjlzUsQr0STGXyv7QM=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CH3PR10MB6833.namprd10.prod.outlook.com (2603:10b6:610:150::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 19:23:19 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 19:23:19 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Subject: [PATCH v4 10/21] mm/mmap: Support vma == NULL in init_vma_munmap()
Date: Wed, 10 Jul 2024 15:22:39 -0400
Message-ID: <20240710192250.4114783-11-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240710192250.4114783-1-Liam.Howlett@oracle.com>
References: <20240710192250.4114783-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0049.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::30) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CH3PR10MB6833:EE_
X-MS-Office365-Filtering-Correlation-Id: 51974674-f6d4-494b-28c5-08dca115c0f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?oSNHtG4DTfLp+MkrWyPE1YwNni7hjS825zrcZWZowPhsvrMTAnxN7EYbiArj?=
 =?us-ascii?Q?wmnv5YdKd5B0XmjTOQN5H2liMBO2TEqoh0VIanyxzijuPHsyTB4RlMtCnotz?=
 =?us-ascii?Q?KI7tkwED82fkjgiczEmbxl2vFBHyzM6cFvl1n7K4YxJ/MmLkqtIQ7q3GdFVl?=
 =?us-ascii?Q?BZKUJJGhvapODvU72I1u2VfYv9jv8qe+98KNPCh+NQ88uZb0aUiwO7gZJPRr?=
 =?us-ascii?Q?XBNlnxC9eMDFy/SCc7gpGu75E+loSerXhwLqec6YHCREtnZg5qWr9EBk99Za?=
 =?us-ascii?Q?+rNTtcK0sZLEEx90sqRP8unNLuwUIfqmu6hdt4A0IGbPplfwjlqzCf6JKU3L?=
 =?us-ascii?Q?BzEhRtdVRO5obv//Ahhx52d1w5Rqw62+c4eA7nHxd6m3UWeE8nX9evsBnSSJ?=
 =?us-ascii?Q?GgskToZlsaRp2DwFjDE32eg9R8/su493jnriywNJMSG9H01m72qTXUu5wXr4?=
 =?us-ascii?Q?nYALpheCho3cpmRlhLGEGbf4wA+iZlR2rQJfAfYdfheGvKbrVkt6rHFE2VzR?=
 =?us-ascii?Q?PqAfRGoRihUbVfc65jJfIMyQ6kA/eAqbX8TgTBO3w0jDVT0X/XDRvvDRiYpZ?=
 =?us-ascii?Q?l3/TshBpXQYgVezmiC4lFPsuEpxpM3B/SGV2StYgxuxajl5yTmd2wXpIiNW8?=
 =?us-ascii?Q?eryDxapOCY3nM0uVfMkCtuWW3RaW9QfVi611juR0IbI0AMogmuKkD9m95pKN?=
 =?us-ascii?Q?heJLGNwDt2S7MTxcJLis9e6HzaEQsgd3nUiM3eiy/LSece9kWnSmlXaQuil/?=
 =?us-ascii?Q?VaCi4az42eCsf3uoPsMclLiVqe+gG3qNsfM4XBqz3y1X2jWyJSECMLySzuwg?=
 =?us-ascii?Q?dg3cvlh8+VbZxRNjHjrHUhRfa9DoELFfn8wsjCmty8lHJ5RvEZWD2jwYqSSk?=
 =?us-ascii?Q?i+ccY3V7bLINZVxQR27viw+uZOAw4VJcd6ULNJHKordtl+wRY6k3ESJ5ldXk?=
 =?us-ascii?Q?F46yWm2BDffjSUNYDRZtRPW+gGXdMfpLYD5e8zqWZJSy7+PdWmKxad2Wv753?=
 =?us-ascii?Q?8nNbX//PCkjdRy5qD/taajypu/bHiyLG52OKmZoh+9UGYV57ajv0JntDVTyY?=
 =?us-ascii?Q?aWq026ZJc0D7mey5LFPz6JsF1pUlRrh8F0QQ11ryZQOmYk3YFpfIzGS3bHwC?=
 =?us-ascii?Q?2e3SnojPKH1oS+3y8UGcjC2dIUNjX77drV+0rD/TA9D4zUphsVY1NlNOdXiY?=
 =?us-ascii?Q?zqrWBPU8GMzvMga/eJdhQ8XGdBAHjL98SCJAs6cLUxzwh6e4pmKiMxMlq081?=
 =?us-ascii?Q?STeD+6qzWVPL8oMqK4jiHU0GhY/fIaxI5V689hVMjw+oiDAXBJn1fNUytBEz?=
 =?us-ascii?Q?SnV0NOqFjZ6XMiiolB9yLODqGZ4fD9u/3Li9Kj7KpmS0Ow=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?3LuM46FgQKswdonzwdFgjaEIprrEi+dkQyn92kliclItXbm3sLEW3QVCahKK?=
 =?us-ascii?Q?MN8SiuqQXL7F44FVx7JpKQ03w02qgcZflP//FrmbxoP5yp6/qPUgyiY7ImcL?=
 =?us-ascii?Q?3XxMdWzO9Bc2Foe4c8noVNDyXowkBJYBO3IEi6FU0f1YSX6A4I/TUDuoMs+N?=
 =?us-ascii?Q?fnjVgDqjUmZzJfXgMRiJTVkLRwHp3y+Yv0UP0xvuV5sj3F3XFij+VL8eaSmX?=
 =?us-ascii?Q?UgkrnyIPc9sdp90jOLVpQf8XKuZ2l9jfdh63IpA/VTKNqxn8USo85uWjabmv?=
 =?us-ascii?Q?eSDAYkpX/7EBUZOBDckgLD0cqdvRXLd3FnKgZ2gw37Ao/OnlMRF//ZdGZz16?=
 =?us-ascii?Q?c5ucOTflwMvxuN0qiVh0DGif2gs3OzqeofQz4pFZRAW2lI2iACY/uPHg3+3N?=
 =?us-ascii?Q?piRpjaIaiX9g86iHM0rSQakOXd3fhefSyFSSOhUO6udhfIEEI6kbPCmlniLL?=
 =?us-ascii?Q?y1U/ta7HKwefcwcFnccyZmSyURA9JGRjUPJAj6BveNFDJtB3sJjk7SafSqtn?=
 =?us-ascii?Q?GH1MwaKYhDedX4YAzR6YdVfT6va/i27DlhE/p7nhd7hUpoewqQAguIkyXKbr?=
 =?us-ascii?Q?2mgvroXGos/oT7InAPq6gFl/GsQj4/4d1myWEfTUaHxRBn2tfcrJrUgnKpB6?=
 =?us-ascii?Q?qxH0tSJsyl0qq32eYom5qTLs2h9fT+JxGpkY4GaoehhXTARXwnTqBgSUBXFv?=
 =?us-ascii?Q?PmKMiQVeGqWqQ+wjaA+FiKq61Y8B4XbmPp1Lf7EbglI1Nuj7QP7asVxoJyky?=
 =?us-ascii?Q?ImizOu5WDc7iOkrw94MIhIdstOv/CFf5VZYPBEL1oB3DiMGTMUX4dLL0IYOU?=
 =?us-ascii?Q?GEEr3++JNbfZ9JSPFRmdp0hCKvmt3xSuOMWkIw/YH5jEtEfGm+Esj2rSz+aN?=
 =?us-ascii?Q?pxqHIh5lZP+tXxfMwsLnkjAS/88Fv/2yqJdaz1imFxUrDdH6WFtvtmaT5K9F?=
 =?us-ascii?Q?qmi2AAyWxAQq6ZD22ODwLyulW7NpKhYFypNSifGZD94BPg1MkpJacHBAMEmp?=
 =?us-ascii?Q?JLK8iwPQpiJ58+MW4gord6ygVxjty1DHxRtjZwms/4CvkD70ZuwjHNM56zBN?=
 =?us-ascii?Q?R5s6wwOa7l4QpbxouzVsTDP7daFFIjuQA+OGcjbL+hfEw14ZQ5bWRwgildet?=
 =?us-ascii?Q?Kh978j0ptq6rA3b1Pdz/8263c5Iv4w6OI3MbcmswK4lOslC4NBGxjtRHm83m?=
 =?us-ascii?Q?o3qzRD8x9uyP3tckCatLW5Gg0iMXqU6gQ9fSrDumOnvvVGpNgzjxJhFOttjV?=
 =?us-ascii?Q?afrNm4AdHlK4ANKcWsdO7/3RE/1xZw5s7+oTWQN+919XSt/zGp8OqHO+8KvW?=
 =?us-ascii?Q?PFrBysZXjW94wEFjMkmhd9a/QtRoEmk1mVKfb2RBn3YouVwzGicKH01kKwqw?=
 =?us-ascii?Q?ZZ5ZxoZaI4po5dwVCCo2ZQFLCQXb6oAxBg/GAstsheKnanAMzNav1qSYOkrY?=
 =?us-ascii?Q?Hg/Mw6xwU2k8p5wy3430y3i59VTEfTd1T96rwR1aT0RRez4TxuOyseapfMhc?=
 =?us-ascii?Q?O4df4mcBHRbuJZLnFB8dfGRoPkVTwAKddmm13NfYcULBrdWpZ3UqwUqz3Xsb?=
 =?us-ascii?Q?mKHMKKlWw0mcfED8k7U2CDdakTjdZktNUGmYWnVfaEtjz0Pcl/Ts0myQDLKU?=
 =?us-ascii?Q?Mg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	PWo0GIJx6/Xt93ZkvdGvk9r+KmioDa+8Z4hYR3J29T6Xs0NHOTs9+EpunKujPI/8Ze8IF0T3GCMTQjV8bdBTx/escL9Bf2yxccj69jl0vP6d2M2LPX5Od1DASnGMYSpMuVAQWBMk0zVmXiaBRg4vKvOubvTpP1pZ7HQFUy+cU12uvFvSCxFIc3nWe01Dqn1ishB4VRyhldfEHI+Y+U50U+38Lob4CybyNPU3QjoI5ea/mLfYBKUBKn2iW0SfJmF/s1XaNtWkxxrWRu5/jND5d00Lo25CX79zBPzo9Jd72Var15obEIqqH+TlXEWFH5V3lxJqjvZs8CSFwXqeIAZqaeNXw31qotg8YGL/b85I45JDy80llnteent8PCh+k6wjKHE1dSS0dFezlvaUUYheSrtgxeVihYxoIo+V/IkAQsI6XckF+2MZprAtgKBuA4XFiUREpfUjWEiH/pxRDxQb0/t7TrZnkSploXTatX2I0pFdsNDxm7OclcUrjj2LqWp6V8RQmKCaCC5FDFszvJtOl+BKTJRYoNiBqzgu4YLw5c31aien+2yQEZw3ur25KibGxu3XFBj4c+Mnv7dr7DoGT0BYN7xR71rnkl73tPCpyKw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51974674-f6d4-494b-28c5-08dca115c0f9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 19:23:18.4500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bAhFBDL2SORemJW3Km1K+BOXNx+cNuZbYHGzMsHsoYJA/haQcHgwTWQDNk2NtepT7JlFusdL96pmcjlkorBAlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6833
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-10_14,2024-07-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407100137
X-Proofpoint-GUID: GtRhqp71Z-I9pTRdU62fMwZ50ePWkO4H
X-Proofpoint-ORIG-GUID: GtRhqp71Z-I9pTRdU62fMwZ50ePWkO4H

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Adding support for a NULL vma means the init_vma_munmap() can be
initialized for a less error-prone process when calling
vms_complete_munmap_vmas() later on.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index a1544a68558e..e2e6b3202c25 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -516,10 +516,12 @@ static inline void init_vma_munmap(struct vma_munmap_struct *vms,
 		bool unlock)
 {
 	vms->vmi = vmi;
-	vms->vma = vma;
-	vms->mm = vma->vm_mm;
-	vms->start = start;
-	vms->end = end;
+	if (vma) {
+		vms->vma = vma;
+		vms->mm = vma->vm_mm;
+		vms->start = start;
+		vms->end = end;
+	}
 	vms->unlock = unlock;
 	vms->uf = uf;
 	vms->vma_count = 0;
@@ -2950,11 +2952,11 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 
 	/* Find the first overlapping VMA */
 	vma = vma_find(&vmi, end);
+	init_vma_munmap(&vms, &vmi, vma, addr, end, uf, /* unlock = */ false);
 	if (vma) {
 		mt_init_flags(&mt_detach, vmi.mas.tree->ma_flags & MT_FLAGS_LOCK_MASK);
 		mt_on_stack(mt_detach);
 		mas_init(&mas_detach, &mt_detach, /* addr = */ 0);
-		init_vma_munmap(&vms, &vmi, vma, addr, end, uf, /* unlock = */ false);
 		/* Prepare to unmap any existing mapping in the area */
 		if (vms_gather_munmap_vmas(&vms, &mas_detach))
 			return -ENOMEM;
-- 
2.43.0


