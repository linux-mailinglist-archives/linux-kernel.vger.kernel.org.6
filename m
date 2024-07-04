Return-Path: <linux-kernel+bounces-241604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C68EC927D08
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 20:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA1241C20326
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 18:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A5F14389D;
	Thu,  4 Jul 2024 18:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SEnYnF7x";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hOH2ZfdE"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2584114375D
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 18:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720117693; cv=fail; b=fHXpBxcScW0ka/g97uGo808/jrJ4F0EB4lwk+EoaQjE1Oz1+6Mq/p6IM1C/LjYNMPDcCqShJ/wbZnb9n4QObC+ejSDqyRNQXMUcHZZsUa1WmEq3HLMlq8FAzpKhGuc4UIE4cgA7S632vGdoJ/lfUxWk//B9qSRPpD8a+9HdbZi4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720117693; c=relaxed/simple;
	bh=Y3/Bg/nbtTsEcK77auokgwmdompngI/8N4uz2SW4D78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BfDNCZQcyTQBwIeLS9d+PDIrXTLVL2ELYmg+aDYb9xn0WUytZAnrItUEMDzN8go1+N3JT2FC57C/YLGHwNBuUPRwqH/UzBVdhwKmWfEmg7uknC8D4pbKXdnmU//2ftLZ/gOuQwtWz8DxLx6n09gSeXXUWn3OKbzst9BTX8wptA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SEnYnF7x; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hOH2ZfdE; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 464Dn5Yj016715;
	Thu, 4 Jul 2024 18:27:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=hlZHpYovIetZlE6yqUMS7duN92CEaSAa4tUxocsHEbE=; b=
	SEnYnF7xaWZrmfqMD2f9fA7AMuAHjBD36vNKR/94PVzw2441kEsAIdJzt9dWXMQx
	XPi0ggwl8Cs5PB5XfOKgCfE04JZsF7vIU4hv4t8E1wK41igy80SbR6DjOq3I4e/A
	DEPOyydWUhvzc83EWBsvKkp59EKsPjKSoNxcL+/7/HGjwsSITj9HVn7iGdGJjHsK
	GaPb9IpG0D5EVGThwkpO5s7LTw7Ge9JyLOa7oG2vQmsuxTHXSs0qCdWArdWZEs/V
	t3n7s0ZOOfWl4C4UCYg37vLvpasjfcq+xcY8+dCWjprH1EnsTxpRytaGg3/8Mwv5
	QV7lTZuKV/a7tZrcRnrn8A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 402attjph1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jul 2024 18:27:58 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 464FsRx0010337;
	Thu, 4 Jul 2024 18:27:57 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4028qh0phx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jul 2024 18:27:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gsn06GdbM9iTo5q4h+44qL47/71VSbIIFIFRpDxvQz6y8jKejrrYMoZ6s35ZAWKZc0HNvEmGIQVIq6tnBmHL3gD+zVR+W/CWgmRj3vMgNQ+Jcjb3NrVHrXg13zfd9blWOlPfPqHCL2Hu1dVVhth5pUT4+QhdKXnhDgXByFWO6iHP0l1/5qOAcHFr1vWU6x25SWpi4i1pjlcwnPMP1mQxLID5cEqqrIcn5TXch5f/nN1RgQM7HzSLI0m3QCFqkI+Fs/DgtyK1nKYbA2X/rJTyZ2fhOI3IgPhCDzr7WBDLQnSgFn4eP8d7r9VJP5zemTlP0OinbEoVTyVIOn21OzmACw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hlZHpYovIetZlE6yqUMS7duN92CEaSAa4tUxocsHEbE=;
 b=KwOFavltI+HN/UaCigcUVbItezQf9ADXsFjV4kZzQkJYGUTIJfNL1Bh1XVcsQlTcG4ZM5vRS65FHfsWG7f7z1lzmk3fQMo7fWkyYAyccY1+XP5VjG66wnrAP9VGSaHfgvaZnquPCbyn8qhOQLEf1cukPyGsgA/gzwuArn/pHDhYnftolHK3/G94TuIZfM3VKrA7E9l5yYUBXcCFHpw9QamtXPZpPQRWQQkaodVFqTllJVx709wtBK+LMJe39v5JghNtZD90q8Gy08vmq5doH4aADaGS1Z5tsz+2JceGOcvSAO1lAyDX2nD5NL5UvmB/xVTudwWUI2UKayJ8XskkHyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hlZHpYovIetZlE6yqUMS7duN92CEaSAa4tUxocsHEbE=;
 b=hOH2ZfdEo6uMKslJsTPdpm5cez6fpcbauUs3qxGOUKUR8nYX06Pvf2CoGSbfDZj5Ifgt2YcPnKlc7RSX0SDHU96Q1d2jzwELkDtdWHJJ2+vwaeMJD8MTu9D9ESTFnKqUFJ5O0M8Bu7FeOhjQeY6BfcNOOPtZrBf+yZI1QCJsRs0=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by IA3PR10MB7995.namprd10.prod.outlook.com (2603:10b6:208:50d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Thu, 4 Jul
 2024 18:27:55 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%5]) with mapi id 15.20.7741.027; Thu, 4 Jul 2024
 18:27:54 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Subject: [PATCH v3 15/16] mm/mmap: Use vms accounted pages in mmap_region()
Date: Thu,  4 Jul 2024 14:27:17 -0400
Message-ID: <20240704182718.2653918-16-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240704182718.2653918-1-Liam.Howlett@oracle.com>
References: <20240704182718.2653918-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0322.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10a::11) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|IA3PR10MB7995:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ca4abcd-45a9-4d85-8275-08dc9c570533
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?KszkA+GMZ69LE67lNtKGRY35W3+eaqRTrBlA+UWCkwVMbC0ihTDoRrpTNUmg?=
 =?us-ascii?Q?Uv1N6eC03VXKvK+A/7VZg55mUafjoHCvnT8NAURxsHB6oIEQW8w98Soc2Y81?=
 =?us-ascii?Q?RVfxeCPBkWM+ll/G/+RJjKQhae6hVdGzZtsvra2dazN/GRglhLSD7P2K2joa?=
 =?us-ascii?Q?uB9JlU69WrbemoxWG5fEzdnILug/s3ue/2CoVNXo139LgQtvs+7VY3WfR19K?=
 =?us-ascii?Q?+BXUP7O5Z07MKfmAmE8LZugMFclmYvWxZWZ8Tkuw2O6zg3JpnkSteJ2g8bMk?=
 =?us-ascii?Q?Z8uqPQeOnnG3jJ4khCjQRt8UrHBXASGoAMbhHyq549h/Ri9U69ROyyDla2SV?=
 =?us-ascii?Q?YluM7bXwhN89MV3KVD7fzSOWSSmhThbsEXyAGWBv5CFQBkKhtmOrNN6rKio3?=
 =?us-ascii?Q?Q1EEWywnSdFfBg43GqURWY9ufVezSd4ESfo43NGpckuppH/BBSp/ftlC43LO?=
 =?us-ascii?Q?7Pd4aaAUMTM01Vn6xv0GJ78n+eDGo/j/vVQlR8tvUomu2L4ns8QDIOPEJo2J?=
 =?us-ascii?Q?5t23bvAa10FD+4fXfMASEh75rncyxNgpouvVDWILN4hPsp+jZNRTfcz9+7Fe?=
 =?us-ascii?Q?i5l1GMJineV57+bQFOECTUoXIkWcBJInhU1MYRYzhFHGGP53kY4dJhrvSauV?=
 =?us-ascii?Q?tkm9cSto74n9getksdBUCFKQOuZijkkNjEBpsI0QVLkw5H7Qn16U11N4hH14?=
 =?us-ascii?Q?XlSe47YEgMw2HTANhaJ/wbwf+kolVd7J0irRkbWvtW/9D3RTNQ3RG6BZJ0U7?=
 =?us-ascii?Q?A5KePmK8V/1z25W8sItLAIQSJE/g8EpNauc4ZJngT+uf9SWrxcaQkUD3NFsd?=
 =?us-ascii?Q?/1m5fkvQTIoVvdBAZyDX0C/023QxSoDIW3f4rAEOs5iukRjGo3cZap1Uh2eV?=
 =?us-ascii?Q?qXqe9UHnjRKnKppYW9FbzQW7/WkRSi1YeIMkUg3tcBiuQh8+foVHE/NimukZ?=
 =?us-ascii?Q?yYrodXjU/HIc25BCjpISuJZUndE2psrI8nyhkqweiYSq8SziXkkQLnK/zGqm?=
 =?us-ascii?Q?5gHuNPZabFozt3CQS2rMOFLqn5qKFYpG9RQNwlGqbiXEKaTwOn0zKvopeNLs?=
 =?us-ascii?Q?eeffBj5UptdKwHKci0yoOQ3cOSYM802+0cT7vQBMC+Ii2wdUitwuQ1owy8f0?=
 =?us-ascii?Q?ZbdPN7o/FbgX0/UAm25pQ/hfV+lCXYzSylGGbDxAG39KWmsFBqIXCgf1Rwmj?=
 =?us-ascii?Q?1j7cjs6EXQBODbcK8DzLgOyyvQMawIVfkDYQ2Ys07zVkAIMBn2WcHciFl7xw?=
 =?us-ascii?Q?TArAepRSGG81uDThFI3fCYT/Upt+WS/MubeIvNEaEPqC8Lj0+haz6NUrV9oC?=
 =?us-ascii?Q?v8V7/9KHevsrFQqRHVvbw8L7i6e8/YZAztkocVrhNeFwOA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?GQWzJz7q8MYb3fmFx2HvgSFaRXauqRnR6GTWRVn958Aqt4kcqWJYBSoFtNUR?=
 =?us-ascii?Q?+mTsqsa0Qu48etqXM09/9agvkfpcS/3Vu9sfrPdx1NyhCQB7NxAAgkQ3Dw6w?=
 =?us-ascii?Q?0Zr8z6zTsa+heqv8+7oht+gr3FsLGYyIjZ8tuHnIS4bS/s9pWlIzKXcRikG7?=
 =?us-ascii?Q?A7WCfj6KOX4p80AolgeSBXk/WWSL5nUROTJUx40UV5dsFXSZLPs0POHRs8ah?=
 =?us-ascii?Q?F6Atx3uiIpPfdZnNcwuG6nwlKYQd/NZjuoSsxqH8xi/RQKn+CrbAbQpDbeGC?=
 =?us-ascii?Q?JjKQnZCTZLKa0iYu8u33O/7gQR/R1L44PZOnagwA3137f/v09jPHwWok2rxW?=
 =?us-ascii?Q?NhdfRzdcRDXXkgkxE4MOP0pO7a9KkFkyQlpT2Jxcu6y6YsabKcepFzGFNm0H?=
 =?us-ascii?Q?wLIXhLYtGzGsazRHLkyhxnK+3dvpr3dynxVwi+qNfgYEJvyAjj47GUQ8Vz2y?=
 =?us-ascii?Q?mhM9phTQsk0SwAya5gFBNyHtX9pD+3gliVmcR/QupXQa5fe3rHXCxlqUELV0?=
 =?us-ascii?Q?/Fc7kR95Xk1jINrvD1MmQ5j8KTbKouXBL9rn7z+phEZ2WybxXDl/WfjvhM6W?=
 =?us-ascii?Q?yRiaft8YpkOSh09cGEn8rs93lQ9l+i2GjQP8bLAIKpRJIdSx037TXi/B+J8K?=
 =?us-ascii?Q?a/WW3cGVx/k6ZX0SwwzsStlHcW6eQ7cmnNWhDp1lOrzEZN5h3SX/zU9/+MSY?=
 =?us-ascii?Q?731eV6aJOykg/64jdiv4dLfb86ap1q9/xkDAPyLDh0upA7OnEYc9sLZ0YfDz?=
 =?us-ascii?Q?eX9cb6a/NEKMDcF+Oblq1mOoYTdM3gn+1iop1MZMcP4r5wIXeqBHNZ8flOYE?=
 =?us-ascii?Q?qr4XM2f61GcY8FGbYr2rXtPD5zxujytHgjRhUIh9onwZZJU87uGj9D+V3geY?=
 =?us-ascii?Q?FOLzjb7hyCQJA6EgfUkaZuOZkxxWM+Av1L5wZ5b0NuYqKXmRUaBenmWVtC9f?=
 =?us-ascii?Q?A78mCa90JW3+rh+PwZ5uIs48y4iYthmjXZ+jyNf0QSKCvtIgooHISIG4fkaV?=
 =?us-ascii?Q?AbwAhggaa7D5OKmpXiFEggOVIU+bQxOe+yUCHsPgSoukIDpdbFlL4yGAFyb6?=
 =?us-ascii?Q?V8jN5dSSjNUIdDMWLGQmkPljGHYqQDrbyUpXmsZH8Ybk6kH+UMNWup/6hl9/?=
 =?us-ascii?Q?D5xlRnuVZ1YQZwrry1osYWacfoZnuPlgYmFLD6OYhf/vkMmojBhufZoAWiBC?=
 =?us-ascii?Q?hMxWckXt1kGQ21Ki7DALXzF9AMv7dlDwxsTdW85g4Hb+UGTTOOZw8cIQJTku?=
 =?us-ascii?Q?UCTAbU121P0CPBOrkpoZIGuMoB+UJnv58pxuKM4yiqmlvULAvWB219owzwVS?=
 =?us-ascii?Q?BGWRDXMToTS7q4Zj8ZXnYtOkemoU/tGGcHgsvPoOXu+4H2ifQcmLgkcrX98l?=
 =?us-ascii?Q?xNpP4YmKSXrougrRvnu/XmBMFgOOHD6VLX3dGmIsYYXzPMf8SOul5DyKE/Cv?=
 =?us-ascii?Q?QPOMPUBQfzctHHMSbwKEy9eGUJ3Q93GLp1OsRm6BgpU49d5a10ObOwKrkQtx?=
 =?us-ascii?Q?+1zLlB4gCFMSp1xvD5xcA0zi7iODfUOP9iiJVqYxq/3tNM/YJVVj/dmD4pQB?=
 =?us-ascii?Q?V3c1kPYfcVuOPYWVywhlyFJHV8vRhgCh4uOGBW6u3zxfJl+cU6YJDO68XHhR?=
 =?us-ascii?Q?fw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	+ja5hMn8VCw3yBEdNkL7nbgqUz3ydt0gNFhPTav7ZgFyBgcQmiw2Grc3Hw/UqI1Hyi0l7RKwQGSdf5Gb7NBcXptj3xwZ/eLSjMj1blefVw9WPTeSOrRbYQprtlPPFQytrouyEtnTmyfxWZtnxp8lNNgyqnrkGKEt4tg5TyH1DG7d0q/knakXvmnDQh/ppgaJA9FL+vjFvMBu5p7ffdtCpXtKfmyMO+7ecoBKe+/uHrpiBaMCDz/wuhS5heK1f5+kHnyibX89Gl/Xmois5GroVn7dvCbmvh6r5+KS7BbdzQJyF5VoJ5ZdOakVHUoZN1b0gobnP7hH/N2m5gkW0q6cW2kuFP55kGIaccd/lAmgfgtu3LRewkRTjFV/VcbT0tGbGtDZY+9ABrWIf/RuBPkDYhy7+U/Z18MFR5YLYxMDIB2O8dCn5qKLGR9QPTiW0igNrgdWmF/mHYcfZS/oRtM9sHaa7j+MGePlHzgo+35PVICvIuFgEN+W3fBOCpXrg637U+My6ChQ6xfgNWdKSnHmzflEI8azEe1zUHauAH9ISS5DmmXWWs7moZvK0LaosDEQDnpjZ8PTBiZQgVczbb+3fdLPYmodKiItPD7Nvr4b6uA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ca4abcd-45a9-4d85-8275-08dc9c570533
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 18:27:54.3939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fd2fusYWnCfFmLQ0sdahcNkoRKYo3I3U9wIquWfYT5M7zrhesOhCHLgJvEjPFabJ6Hz+gz+JIqfvbEQ3/1E75g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB7995
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-04_14,2024-07-03_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407040134
X-Proofpoint-GUID: IqP-oJW1nGM9zLSDfg3g7zc6hSrVDmTG
X-Proofpoint-ORIG-GUID: IqP-oJW1nGM9zLSDfg3g7zc6hSrVDmTG

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Change from nr_pages variable to vms.nr_accounted for the charged pages
calculation.  This is necessary for a future patch.

This also avoids checking security_vm_enough_memory_mm() if the amount
of memory won't change.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Cc: Kees Cook <kees@kernel.org>
---
 mm/mmap.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index b14da6bd257f..b2de26683903 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2980,6 +2980,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	} else {
 		/* Minimal setup of vms */
 		vms.nr_pages = 0;
+		vms.nr_accounted = 0;
 		next = vma_next(&vmi);
 		prev = vma_prev(&vmi);
 		if (prev)
@@ -2991,9 +2992,10 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	 */
 	if (accountable_mapping(file, vm_flags)) {
 		charged = pglen;
-		charged -= nr_accounted;
-		if (security_vm_enough_memory_mm(mm, charged))
+		charged -= vms.nr_accounted;
+		if (charged && security_vm_enough_memory_mm(mm, charged))
 			goto abort_munmap;
+
 		vms.nr_accounted = 0;
 		vm_flags |= VM_ACCOUNT;
 	}
-- 
2.43.0


