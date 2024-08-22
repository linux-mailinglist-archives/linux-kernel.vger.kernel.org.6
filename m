Return-Path: <linux-kernel+bounces-297892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA15E95BEE0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 21:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 698571F21EB9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 19:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB76D1D2F6B;
	Thu, 22 Aug 2024 19:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RTl1liVs";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WI6zJDvu"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E0B1D1746
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 19:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724354829; cv=fail; b=mQ3f+W+hmZYh7raZJLRCXahEg2xleoORJocPp/pt32S4RjDNtVuU+hatUfCtzpgc1NJ8titZKz7015JzyWezll0w299hl7ln7USfycuurBGnHMNRJ8u3wmKplcZPVUC4sxxff9bbkXR9Ua00Q1Efs2hoSTpKQjpN+QQjkLYnFdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724354829; c=relaxed/simple;
	bh=USyM0d5e+NS1vAmS7PvP+N0ZqvpcyNvxzzdwm3sdw8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N4pAG/m6T94LgemfjjPdOHUszdeOoFJEUeHHSsRefPvidpypxTZgxV5qq3Q8eYUx4X+01fmlSrVWyZ9N0FYczJaeOiECXpsjrAX15V/ZKrwc5LDqIJcIORrpIjrgn57Jo/8WeG7tFVqJ5FYJIS+rYP3n0T2LHXirQR1eh6EpCas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RTl1liVs; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WI6zJDvu; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47MIMWJF029718;
	Thu, 22 Aug 2024 19:26:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=ttsU2jqtp5fvXasFNgS0NAcV2R20c5Zpzh7VMtrTw7I=; b=
	RTl1liVs/WFF9wMNs6ygEgt/OcBx6LRF7BcwBLHuVM38rmY7MnHTjA5qDCh0Udys
	VCPHusMf1z6+a9W2WudnUlG/pe4iM+/PKAJS3cR8Bq4P2dRR5vdYkusN+yb7+jMB
	re4/nQ0OmiWokRqcVdiO8nx5f+rSfAXi/lAZirS70oz6Kx48DovTCWDSZrCkUbcE
	GLSHFgNWV8/lseZE572Ftyht4m+858pEf4DYehVVs8oqwU+pOYwjb1BPNctC7JTS
	z7om/7JAdfPNX9dyTAVGIh16JZcmjoiBPtwnEwrabIHRSKfCIFYHvJb60cCrOwE0
	xvH8zlwcdFnQp+9zRDpUsg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m67jrs7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Aug 2024 19:26:54 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47MJJK8c005374;
	Thu, 22 Aug 2024 19:26:53 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 416bcu08ec-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Aug 2024 19:26:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dn7O3W5N1fvsepHLGZ1Gwgus+1P7w89R3qbY2pQfKTktQjc/VLISks8kw3zdTn4s4sqV+5dxPHHFexTXhZWRAkP5/8WXJgm2Q06NrPStjHABAidvsr8HcuTfXVo5WKacw7jcIfqqDl1Ia4Iv3dfbRirvQxBcTmPNemS51C7fpgHhgXJLOc8zpysTGRD10RSxn8ahFUuIlyLW1L2jEkyMWNjtuEzopE1gTJo95Lrani0BH4eEWhKx67IJ34F3Yk4gi7JvZHhe9MwN1qqLyQ0gA3X6bEWS2j8feHTXUiHcFKanoMVx3emYPC/NYvYPvlQ7XpkA7CAgRd18brM0Vc0XUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ttsU2jqtp5fvXasFNgS0NAcV2R20c5Zpzh7VMtrTw7I=;
 b=MTHH519SjBTuGMuVeKf1wynqBM9rLoThWlZEo6k8vJeyIL5AvRHHrOznYHSJ+0ighc08FQL3pj/sbnj9wLd5tGEdqKSQ20jYs21OnMUWxE4IEiYlBuAtMxAi8cQ+CrRpLTuZW36c5WOjX6+7g57tDeTgu+tS7HGB/3rhcm0/Ok1mO+4zqgMgckYcK3cqlkFqE35ycCz5vdNrmrwvn2T9vqAUPVJKfELRcBINR16T8LakIR728YaaMQWp+LEfIhCnKdQnTsq+VP6GlJgznqV8WN2kalCsF95LGPc7G9/dnicG4IQl5yv61UggeAOTtDa179xcCjc0Q7MPh1BrYsytFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ttsU2jqtp5fvXasFNgS0NAcV2R20c5Zpzh7VMtrTw7I=;
 b=WI6zJDvuP0B5ZtBlEx9abq/Rt604tUXLSsNBcgPaWtKRA0dLg+uipHCcPyTRvTXyuOOE7w2syjBRsDkGR8xHMkN66Th5ZG1P1LST+alCUQ6l8eSNbFayVzj05RK3nQW7tfw+o1TMe8HrHgGBsEgDkGNU6fzcVS9EkozXpIJYKT8=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by PH0PR10MB5729.namprd10.prod.outlook.com (2603:10b6:510:146::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.13; Thu, 22 Aug
 2024 19:26:18 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 19:26:18 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        sidhartha.kumar@oracle.com, Bert Karwatzki <spasswolf@web.de>,
        Jiri Olsa <olsajiri@gmail.com>, Kees Cook <kees@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v7 05/21] mm/vma: Introduce vma_munmap_struct for use in munmap operations
Date: Thu, 22 Aug 2024 15:25:27 -0400
Message-ID: <20240822192543.3359552-6-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240822192543.3359552-1-Liam.Howlett@oracle.com>
References: <20240822192543.3359552-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4P288CA0035.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d3::17) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|PH0PR10MB5729:EE_
X-MS-Office365-Filtering-Correlation-Id: f7075146-539d-4c9e-3da2-08dcc2e04bac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?EuZLaPH1nA3kWq+lrqi21uknqlJWRkN6o87TUEmKN2NOGq22NetB7SIu+0FI?=
 =?us-ascii?Q?EI5VdROdXZirfjkov0E/lk9FGMwdwJxIM6JqJI9zUwUY3dAzDUEFDp273VRX?=
 =?us-ascii?Q?bQdt4rP8XXLuQCE4Obc2IoFb66mYlxo0bq1XdfLo8/o1LSo5Leh6OZxv7HAu?=
 =?us-ascii?Q?TwnbV7CSY/lZaKYSmrpGyzAlthY31iZwc3i0LHATu8cIUfBTzH5m3NRvpZFQ?=
 =?us-ascii?Q?58UJ+GAY7bMUeH+aylFH1HsKlIIc9gz6TV72H2lIfDqz8yIU/xlezEOxEtYF?=
 =?us-ascii?Q?kmKkl2sLsoxcOEr6GoZbbxLtzQQ5B+lMnafJTH5jKoLROzDePP417KyB05Q0?=
 =?us-ascii?Q?WzBlpZsEXZ5vxFAkGckLC7WPIZ+phc/td+RZVBaKYpoZfriT3GYTJjl1pxb4?=
 =?us-ascii?Q?OYDih/YV3iZHyH91e0yGQFcAxt7oBWQMcKGhcidqlrxYckx9XdsxWLZlx9uU?=
 =?us-ascii?Q?LW2ZBjrHZrtZgMa5ynXE4xYIW9UUZHvnDsxaFIDPkkXo1GH1F2lGa+zFXxhk?=
 =?us-ascii?Q?Ud9IgVH1SSbvNL+qyoRM2r6juKSzNHWImgI+shIXbVJQJzsX33JQN/R9HT/C?=
 =?us-ascii?Q?5J8Ym2C2pDyHf4tsqu4bYNOsIEKzp22cIQLOVtDe2WWwE3pPa+1l8sfnDwB/?=
 =?us-ascii?Q?uXm3ViQuZazwPKPSL0shHPKNJHypGFxStCa+2DvZFkRzYqa/cdXgXtrfL12u?=
 =?us-ascii?Q?eH0zFFQBj9OH6auRvvK8B7KCy3noscGxqaaggSJBvwd1rP+bPRf8oUJrVWaR?=
 =?us-ascii?Q?LeeBsU1LCBF2jSincp4tGlhxYIQbHwDaO9kKzO/W2DpvfSE/nhRfky1ueuSb?=
 =?us-ascii?Q?hNU9vZskZgEWpaWyiHNqg1hz+nAINO1c+GxlfWAm9EEgEzZ/d/+1dhCXNV1e?=
 =?us-ascii?Q?Mcg4gEP1K5PG+4BHeLeAb6tnVZ5vHAVd4FjtZcLIO/qqjCpTDzSFvbbmqvlw?=
 =?us-ascii?Q?Eu9sosjt6BRjMNIMwWcjkFxQBPayTXV8p0BE5OGNB7/kVLvKt33GcpqSSypC?=
 =?us-ascii?Q?M0Qz5tleVi4XB7aWQoDny8dTL5uTVJKutce7bK7Ne6htFW0u/IEJmYnOFJSF?=
 =?us-ascii?Q?4qSfFkCX7Gmcgc29yfRkMLEtl6bWgqyQ7rmI8qZZifMDJUGCq6BoW+tb3opf?=
 =?us-ascii?Q?iF+wp9j1YnRATeK3ez1XVIpM+raydh43nRlcCthB5s8CBKy5fDYWd+a1wGnN?=
 =?us-ascii?Q?xMp9sVnsCTQUW0AEgvzVHEcwvtpPd7JKTQFdFzv/3t+gnpXoHT2snvFXwANF?=
 =?us-ascii?Q?j+bwAfHKaVqx+9ioKkIHYUF2asw95c9YMeVmc4XXpKTKm6webJTGBJaW2Ohy?=
 =?us-ascii?Q?+ifc9buAYAgswKM16ykTPyA/1ilwE6uZgWaxeRetuArqrg=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?CTvpmUTMdQzCy0GljSCM2jznwIvXIcy0km/fungs4Iri1S5+PgvhJlkLuLUE?=
 =?us-ascii?Q?rmdascwf7N/MTHKNdb3yBBs5jw1NcwYFe6zutPD7MZPfMA6Ow4j4lIwmBoV7?=
 =?us-ascii?Q?gUfP2ir8RLRjzYE0xISug1CJ480phlFMJES/I7MyRoomvAz4JGjOc6hMfKm9?=
 =?us-ascii?Q?9bM/aIVOQlruhYRc9hzyLAFy/9884pZw5tLyctYkJaHB56vkaN8awTT5MLYI?=
 =?us-ascii?Q?/TLp9Wt+EK2lVijWUA5a6nP7E8xJnd/0W6wlSjumNbiej/9MCMtDKAOjvEFQ?=
 =?us-ascii?Q?DOR0vk+w42RZCZ4pxMJ/aPcn5edXulA+WzzTbeYmF1RLHiGYtXmE3qpQiB93?=
 =?us-ascii?Q?1z9xWr/akcsRMqlu9fmUMymYSYVe0D/2n+6M4+kNbzdGxUuv3wNQUhAbsLCg?=
 =?us-ascii?Q?bsyEtps/rkpBsgXzLO3xUbMqL5EXIfb4p1pRyE35/b8acVW+3O/NoIS/idlj?=
 =?us-ascii?Q?z9ithcecujlrUOVUVC7LrH0ThLeyEIYYaRG4ze8dYAQIYNi77ayLnX3b6I4f?=
 =?us-ascii?Q?3WrejPH893oZA5tqrVFq8JzOv6xlWdkvYLtuYX/SbOf0js0tk00rItDrXQXU?=
 =?us-ascii?Q?wlN08KzPB7ZbkMzRhoptJZHy6rPTM8UzUkZAe+A6sgAaXxPqwhHNb6FKxa4g?=
 =?us-ascii?Q?6Nhy3u2pqyvXs/2PhL35ilxtFrciqQHbeklWXrj1AUURu3CYOhvxBvW64TWN?=
 =?us-ascii?Q?aN+LQ8xaAYMwLGDx76P+EPcejRzJIe8CBVBCvWhlR6/3VhP/SpWMIEZkq6Yg?=
 =?us-ascii?Q?urSgkIlRMqBvhoWkPmVy/Az/g7Aa3JkER4t55hCoBiZwyvP7C2kZjQeOwHyA?=
 =?us-ascii?Q?X4GOiYpLaZrU/GkCpux2zSgxKflUYs9PXWvJrPDix2H7OUtXw00Iitz+T58E?=
 =?us-ascii?Q?hF687CpMzdh4Eu978kE6MSlkcfOrE/U+UQRQYepAP8euhz84Hz/WZQSiViZ5?=
 =?us-ascii?Q?qQC/TsgJC1rnvL93Xv1vDUUyFgqSL8eEAbH0ahtVePa3aWkbFpd4ztqPt3ob?=
 =?us-ascii?Q?+STNt7dZkZfk4nJJVhkOEvjL8aH0tyNRSzLgaYlo3T/Zn86/toEebkUQfTu0?=
 =?us-ascii?Q?9tcbwZFLd6pWhz9r+JtlLbX0rq9z82Bm4/22qWy8kcqqBJA1sxX8S5b71Koq?=
 =?us-ascii?Q?ctY0feo8bNWjgLfqK4U2h4iNa5+2zH/gakAv3haUkyV+EQTmij7WzgnNy5NN?=
 =?us-ascii?Q?i/YG3goC8cJ+uddZJLWBiwPviTriiHY6/CMk8I18vWJGGhOrchHaeVevghx9?=
 =?us-ascii?Q?aoDJ6QA+3l1g3Fs7w7lK5usuGA74DYy8dPOGXOdS10sUJv3UKyheNO708huU?=
 =?us-ascii?Q?UPbUibzo1DMpnl0ShI/IR1Iru8GL+qdesYsf6SdYjt5UmCHeFIWoTxnF9ns4?=
 =?us-ascii?Q?Yf4oYr207DXXdiVj+J5U4z9j7Sxi5jtRGPN3cR4Kls6QaxygCvUGC1r+k99p?=
 =?us-ascii?Q?MqQgGVC8MOFzvg+KkJdDwe554WspxD7xaWRfZXqqT7mKXq17NoEq0KDlGqi7?=
 =?us-ascii?Q?8vX4ZdEiUBAAo3u9QtMIOqmD+L14gFEtL4cZut82SQkf7cueWtTO0jHSvWVN?=
 =?us-ascii?Q?2Jd9ZWVqEkDIsIGeRLQTfXj2XPciISxVoJ3qf/JB?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
 iCnTPBbq8ZYmO1qlbuiJ12WjMlpHUZ5XOBs0QB4hnmdMb4SB3z470SqAOBRfKFpbkHgxWCpiYnPl4r7WSsInDh5rTQP/Rj7c6OYAdwfl5htEwf1qO9hFpyq7sTd4rKEwYESDBCIcNmsRjwGtrLOBFkAsee6PMoMtBHJqqt8ZE/ZEqmfM+nieQTNnqxg3Zu7eUddCSXcKeKHqCjXARa0WnAWItuMDSgdRGJTV/JchwWIF5/J5EtpI9CxBLRu0sK50X30NvnkSy9bJ/E3fIx18dPwi12iV28T/p7P29xatKLeMKvAjBAsn2e+QM5+KBihOaz7+g47wmDhGHQwi+ewoSQfWIXXixBY9QKZ+MlAkLaQ0by9dZnW8nUkUmmMJxhRU+mZvgWSSEybpq5N2hBoIyirxYK9hJbvo9iE5VxIQ2F1TCSPQNGDiC6q7wA+VIzRfCdZNne1yEC86E8Z2/gMEirfTgb4iSxi2l9FtWhGL2YpfO0uHSS1yenfDK+eQDBpwpwevWB5fCd25K+UT20zyiicChxlaDwmxw7fIkeXZWCxAmSTauyR7T7jXzAhX8ay+wGxfRpLI136Al6iRElM8ZkAKRr8X1ohhkD6yaMMJHxY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7075146-539d-4c9e-3da2-08dcc2e04bac
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 19:26:17.9432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eo4Cu6ij5vmMS93IqzmGusQAs6/Ny+9v6KdU1SBo+b3zo4nTBYjhjTg8+Uyl5E8BW4CdAqdtfRKAUYjvF4/8xQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5729
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-22_12,2024-08-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 adultscore=0 phishscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408220146
X-Proofpoint-ORIG-GUID: Q3sLeL6SZmcXJJi6C9zzwXOGyvA3ttBv
X-Proofpoint-GUID: Q3sLeL6SZmcXJJi6C9zzwXOGyvA3ttBv

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Use a structure to pass along all the necessary information and counters
involved in removing vmas from the mm_struct.

Update vmi_ function names to vms_ to indicate the first argument
type change.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/vma.c | 142 +++++++++++++++++++++++++++++--------------------------
 mm/vma.h |  16 +++++++
 2 files changed, 91 insertions(+), 67 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index da489063b2de..e1aee43a3dc4 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -80,6 +80,32 @@ static void init_multi_vma_prep(struct vma_prepare *vp,
 
 }
 
+/*
+ * init_vma_munmap() - Initializer wrapper for vma_munmap_struct
+ * @vms: The vma munmap struct
+ * @vmi: The vma iterator
+ * @vma: The first vm_area_struct to munmap
+ * @start: The aligned start address to munmap
+ * @end: The aligned end address to munmap
+ * @uf: The userfaultfd list_head
+ * @unlock: Unlock after the operation.  Only unlocked on success
+ */
+static inline void init_vma_munmap(struct vma_munmap_struct *vms,
+		struct vma_iterator *vmi, struct vm_area_struct *vma,
+		unsigned long start, unsigned long end, struct list_head *uf,
+		bool unlock)
+{
+	vms->vmi = vmi;
+	vms->vma = vma;
+	vms->mm = vma->vm_mm;
+	vms->start = start;
+	vms->end = end;
+	vms->unlock = unlock;
+	vms->uf = uf;
+	vms->vma_count = 0;
+	vms->nr_pages = vms->locked_vm = 0;
+}
+
 /*
  * Return true if we can merge this (vm_flags,anon_vma,file,vm_pgoff)
  * in front of (at a lower virtual address and file offset than) the vma.
@@ -685,81 +711,62 @@ static inline void abort_munmap_vmas(struct ma_state *mas_detach)
 }
 
 /*
- * vmi_complete_munmap_vmas() - Finish the munmap() operation
- * @vmi: The vma iterator
- * @vma: The first vma to be munmapped
- * @mm: The mm struct
- * @start: The start address
- * @end: The end address
- * @unlock: Unlock the mm or not
- * @mas_detach: them maple state of the detached vma maple tree
- * @locked_vm: The locked_vm count in the detached vmas
+ * vms_complete_munmap_vmas() - Finish the munmap() operation
+ * @vms: The vma munmap struct
+ * @mas_detach: The maple state of the detached vmas
  *
- * This function updates the mm_struct, unmaps the region, frees the resources
+ * This updates the mm_struct, unmaps the region, frees the resources
  * used for the munmap() and may downgrade the lock - if requested.  Everything
  * needed to be done once the vma maple tree is updated.
  */
-static void
-vmi_complete_munmap_vmas(struct vma_iterator *vmi, struct vm_area_struct *vma,
-		struct mm_struct *mm, unsigned long start, unsigned long end,
-		bool unlock, struct ma_state *mas_detach,
-		unsigned long locked_vm)
+static void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
+		struct ma_state *mas_detach)
 {
 	struct vm_area_struct *prev, *next;
-	int count;
+	struct mm_struct *mm;
 
-	count = mas_detach->index + 1;
-	mm->map_count -= count;
-	mm->locked_vm -= locked_vm;
-	if (unlock)
+	mm = vms->mm;
+	mm->map_count -= vms->vma_count;
+	mm->locked_vm -= vms->locked_vm;
+	if (vms->unlock)
 		mmap_write_downgrade(mm);
 
-	prev = vma_iter_prev_range(vmi);
-	next = vma_next(vmi);
+	prev = vma_iter_prev_range(vms->vmi);
+	next = vma_next(vms->vmi);
 	if (next)
-		vma_iter_prev_range(vmi);
+		vma_iter_prev_range(vms->vmi);
 
 	/*
 	 * We can free page tables without write-locking mmap_lock because VMAs
 	 * were isolated before we downgraded mmap_lock.
 	 */
 	mas_set(mas_detach, 1);
-	unmap_region(mm, mas_detach, vma, prev, next, start, end, count,
-		     !unlock);
+	unmap_region(mm, mas_detach, vms->vma, prev, next, vms->start, vms->end,
+		     vms->vma_count, !vms->unlock);
 	/* Statistics and freeing VMAs */
 	mas_set(mas_detach, 0);
 	remove_mt(mm, mas_detach);
 	validate_mm(mm);
-	if (unlock)
+	if (vms->unlock)
 		mmap_read_unlock(mm);
 
 	__mt_destroy(mas_detach->tree);
 }
 
 /*
- * vmi_gather_munmap_vmas() - Put all VMAs within a range into a maple tree
+ * vms_gather_munmap_vmas() - Put all VMAs within a range into a maple tree
  * for removal at a later date.  Handles splitting first and last if necessary
  * and marking the vmas as isolated.
  *
- * @vmi: The vma iterator
- * @vma: The starting vm_area_struct
- * @mm: The mm_struct
- * @start: The aligned start address to munmap.
- * @end: The aligned end address to munmap.
- * @uf: The userfaultfd list_head
+ * @vms: The vma munmap struct
  * @mas_detach: The maple state tracking the detached tree
- * @locked_vm: a pointer to store the VM_LOCKED pages count.
  *
  * Return: 0 on success
  */
-static int
-vmi_gather_munmap_vmas(struct vma_iterator *vmi, struct vm_area_struct *vma,
-		    struct mm_struct *mm, unsigned long start,
-		    unsigned long end, struct list_head *uf,
-		    struct ma_state *mas_detach, unsigned long *locked_vm)
+static int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
+		struct ma_state *mas_detach)
 {
 	struct vm_area_struct *next = NULL;
-	int count = 0;
 	int error = -ENOMEM;
 
 	/*
@@ -771,23 +778,24 @@ vmi_gather_munmap_vmas(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	 */
 
 	/* Does it split the first one? */
-	if (start > vma->vm_start) {
+	if (vms->start > vms->vma->vm_start) {
 
 		/*
 		 * Make sure that map_count on return from munmap() will
 		 * not exceed its limit; but let map_count go just above
 		 * its limit temporarily, to help free resources as expected.
 		 */
-		if (end < vma->vm_end && mm->map_count >= sysctl_max_map_count)
+		if (vms->end < vms->vma->vm_end &&
+		    vms->mm->map_count >= sysctl_max_map_count)
 			goto map_count_exceeded;
 
 		/* Don't bother splitting the VMA if we can't unmap it anyway */
-		if (!can_modify_vma(vma)) {
+		if (!can_modify_vma(vms->vma)) {
 			error = -EPERM;
 			goto start_split_failed;
 		}
 
-		error = __split_vma(vmi, vma, start, 1);
+		error = __split_vma(vms->vmi, vms->vma, vms->start, 1);
 		if (error)
 			goto start_split_failed;
 	}
@@ -796,7 +804,7 @@ vmi_gather_munmap_vmas(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	 * Detach a range of VMAs from the mm. Using next as a temp variable as
 	 * it is always overwritten.
 	 */
-	next = vma;
+	next = vms->vma;
 	do {
 		if (!can_modify_vma(next)) {
 			error = -EPERM;
@@ -804,22 +812,22 @@ vmi_gather_munmap_vmas(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		}
 
 		/* Does it split the end? */
-		if (next->vm_end > end) {
-			error = __split_vma(vmi, next, end, 0);
+		if (next->vm_end > vms->end) {
+			error = __split_vma(vms->vmi, next, vms->end, 0);
 			if (error)
 				goto end_split_failed;
 		}
 		vma_start_write(next);
-		mas_set(mas_detach, count++);
+		mas_set(mas_detach, vms->vma_count++);
 		error = mas_store_gfp(mas_detach, next, GFP_KERNEL);
 		if (error)
 			goto munmap_gather_failed;
 
 		vma_mark_detached(next, true);
 		if (next->vm_flags & VM_LOCKED)
-			*locked_vm += vma_pages(next);
+			vms->locked_vm += vma_pages(next);
 
-		if (unlikely(uf)) {
+		if (unlikely(vms->uf)) {
 			/*
 			 * If userfaultfd_unmap_prep returns an error the vmas
 			 * will remain split, but userland will get a
@@ -829,16 +837,17 @@ vmi_gather_munmap_vmas(struct vma_iterator *vmi, struct vm_area_struct *vma,
 			 * split, despite we could. This is unlikely enough
 			 * failure that it's not worth optimizing it for.
 			 */
-			error = userfaultfd_unmap_prep(next, start, end, uf);
+			error = userfaultfd_unmap_prep(next, vms->start,
+						       vms->end, vms->uf);
 
 			if (error)
 				goto userfaultfd_error;
 		}
 #ifdef CONFIG_DEBUG_VM_MAPLE_TREE
-		BUG_ON(next->vm_start < start);
-		BUG_ON(next->vm_start > end);
+		BUG_ON(next->vm_start < vms->start);
+		BUG_ON(next->vm_start > vms->end);
 #endif
-	} for_each_vma_range(*vmi, next, end);
+	} for_each_vma_range(*(vms->vmi), next, vms->end);
 
 #if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
 	/* Make sure no VMAs are about to be lost. */
@@ -847,27 +856,28 @@ vmi_gather_munmap_vmas(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		struct vm_area_struct *vma_mas, *vma_test;
 		int test_count = 0;
 
-		vma_iter_set(vmi, start);
+		vma_iter_set(vms->vmi, vms->start);
 		rcu_read_lock();
-		vma_test = mas_find(&test, count - 1);
-		for_each_vma_range(*vmi, vma_mas, end) {
+		vma_test = mas_find(&test, vms->vma_count - 1);
+		for_each_vma_range(*(vms->vmi), vma_mas, vms->end) {
 			BUG_ON(vma_mas != vma_test);
 			test_count++;
-			vma_test = mas_next(&test, count - 1);
+			vma_test = mas_next(&test, vms->vma_count - 1);
 		}
 		rcu_read_unlock();
-		BUG_ON(count != test_count);
+		BUG_ON(vms->vma_count != test_count);
 	}
 #endif
 
-	while (vma_iter_addr(vmi) > start)
-		vma_iter_prev_range(vmi);
+	while (vma_iter_addr(vms->vmi) > vms->start)
+		vma_iter_prev_range(vms->vmi);
 
 	return 0;
 
 userfaultfd_error:
 munmap_gather_failed:
 end_split_failed:
+modify_vma_failed:
 	abort_munmap_vmas(mas_detach);
 start_split_failed:
 map_count_exceeded:
@@ -896,11 +906,11 @@ int do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	MA_STATE(mas_detach, &mt_detach, 0, 0);
 	mt_init_flags(&mt_detach, vmi->mas.tree->ma_flags & MT_FLAGS_LOCK_MASK);
 	mt_on_stack(mt_detach);
+	struct vma_munmap_struct vms;
 	int error;
-	unsigned long locked_vm = 0;
 
-	error = vmi_gather_munmap_vmas(vmi, vma, mm, start, end, uf,
-				       &mas_detach, &locked_vm);
+	init_vma_munmap(&vms, vmi, vma, start, end, uf, unlock);
+	error = vms_gather_munmap_vmas(&vms, &mas_detach);
 	if (error)
 		goto gather_failed;
 
@@ -909,11 +919,9 @@ int do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		goto clear_tree_failed;
 
 	/* Point of no return */
-	vmi_complete_munmap_vmas(vmi, vma, mm, start, end, unlock, &mas_detach,
-				 locked_vm);
+	vms_complete_munmap_vmas(&vms, &mas_detach);
 	return 0;
 
-modify_vma_failed:
 clear_tree_failed:
 	abort_munmap_vmas(&mas_detach);
 gather_failed:
diff --git a/mm/vma.h b/mm/vma.h
index da31d0f62157..cb67acf59012 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -26,6 +26,22 @@ struct unlink_vma_file_batch {
 	struct vm_area_struct *vmas[8];
 };
 
+/*
+ * vma munmap operation
+ */
+struct vma_munmap_struct {
+	struct vma_iterator *vmi;
+	struct mm_struct *mm;
+	struct vm_area_struct *vma;     /* The first vma to munmap */
+	struct list_head *uf;           /* Userfaultfd list_head */
+	unsigned long start;            /* Aligned start addr (inclusive) */
+	unsigned long end;              /* Aligned end addr (exclusive) */
+	int vma_count;                  /* Number of vmas that will be removed */
+	unsigned long nr_pages;         /* Number of pages being removed */
+	unsigned long locked_vm;        /* Number of locked pages */
+	bool unlock;                    /* Unlock after the munmap */
+};
+
 #ifdef CONFIG_DEBUG_VM_MAPLE_TREE
 void validate_mm(struct mm_struct *mm);
 #else
-- 
2.43.0


