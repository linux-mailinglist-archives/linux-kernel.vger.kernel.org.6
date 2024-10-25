Return-Path: <linux-kernel+bounces-381662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCFD9B0254
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 14:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C793281CEC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 12:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF97F2022DA;
	Fri, 25 Oct 2024 12:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DbEvce0i";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LjAvkv1k"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05B7203709
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 12:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729859238; cv=fail; b=frsJAxzTHUbUxDpjj6gKMhLagf/PiT6Z86lrjAhUti/xd/5EXbyFlnpaPgWaHTz1vh0uELLYM6ZaGW/mF+YmXey4agpNvH4x8phXRpL3nFgGngWQqcxAq/wKAorFTYgVW6KdCnBb67f0XHucLeAManJyDNIgQNjyw2Tzo5iP7fg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729859238; c=relaxed/simple;
	bh=tPN38tBgdOY8UIWFhut+ECcIjhdA1NTIVjcz7qJP7/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UfkdOn6vVvM3f+VZtfKjIN11Xmo0pR4Vq/9og/LsKSzRzWCnz1f3ZX/a3Pmt0SK6b+ixfInMbeFmlSYWKF/qiV/uOiqPSoMtI74mw8xtnfzVzHDQDZlhQ6nFgT7oMJv2KMmEivJkEounRsoVssuLFNa3BpiELUMWaS6/EvK2vOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DbEvce0i; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LjAvkv1k; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49P8BZ8O005839;
	Fri, 25 Oct 2024 12:27:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Fh+NuR7QCmcKWxRi86ErJ9aexreyrERuoTi9h/YGAIM=; b=
	DbEvce0iBzEHNApq2ebk5pLRwE3WaPP2XCGHlX92+5pvdS+u/DPK86y3TqT5rImr
	RSgkJ1khh9JD+f4IKa+8wCI6SOf0dlE9v/Ntt5NISF6IJIf0qV0dKvv9giUJCuvw
	5eOR0ynTm/1u5AAqNl9weR6yF33Mj0W7DhTZnCiB9x4TCarbuEz6D9sQMxQ5U0bo
	Vdtz7n1CtHby+ccE9JYD1m5CJPNpevdOH+4m8UI8jyVvHhygbVr67wZXQJsouvvy
	jL7fWyjOGWF/rmZ7UuSOIdzBEM0l3XgfPTDCJ5pSvv+GBPoHNDvI6hgh83F1JJ+R
	6WWRJqeVxUs4mGwochTRXw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c53uvtty-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 12:27:04 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49PBxpRm016475;
	Fri, 25 Oct 2024 12:27:03 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42emhdt4th-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 12:27:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wJ8eefl3dxv+QsJWWMWUAyCX07U927502Jms4JRblLUdCpDt9HRjqFbKybnGIAKOnUjysaO1L+7ultaR+6kB528+ei+Lzl/bjMzvOxM+J6loxl5IdOQ5JCaAJXjYODwyEffGgJh/xCohd4oc5uSr3xPJqts5mr2hAC+oUupKP5tsN5jkR0D6Qi743qetASwQidJMubMlFIMdyqhzfIi7+8JMMFJ2dNr45OKcAHaWa3BG9ZKjJlfAbD2DA6A/mQzE0SHhNkyYFa4+7lv90k1kRw2OjnjzbTKEAGZNd0L716lVu9cT0hKeDAYy7aJTvaRDemlPb5KbBfZhaQyE6/1mXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fh+NuR7QCmcKWxRi86ErJ9aexreyrERuoTi9h/YGAIM=;
 b=POC/br9G1MSryKkGLnAzEPTQGkTi9UuA7EAYvoBED02LxXPXIZrY2JFRjbldSMJ6KG56myMTSbYp/WC9KvmXeWrFAjFduqPkradKPDTCsGo9GSanFcWigbPDNv/9kAKlFamFVLbvbSCPHAhn23KQA6bvqafRzBiEmXoYLMgw2dDt9tNJx8ENAw305NV/LHjgFCIWeyZmamIQkL7f+c0dK4DsAFBHFJMywSsxin2LSkEYQ8i+4x+V2fSFHqEqkCk0JFPsxBleoH+jjCv89cmQ3/g1z3rQ8CvX5qNR4g6izfnximLPcxTAcAP+tS+gacGz9G13aVf7d3iwlToAjn+/JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fh+NuR7QCmcKWxRi86ErJ9aexreyrERuoTi9h/YGAIM=;
 b=LjAvkv1kRsrkEn3lKQaukdhuy1M60SIV9Wk0FmjvsCKaI3Np0ZErYujTa6T+s94832OvnMCTod69xLW7hAeYud1z3Yt3vH1MqOz9dVZphbBXLgc+hr+S+1TGxKWZ0hyXPTbDd+vrz4liO6VvBoi0TdEIxCxXcfrmZK7LRkf2D98=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by CO1PR10MB4484.namprd10.prod.outlook.com (2603:10b6:303:90::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Fri, 25 Oct
 2024 12:27:01 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8093.014; Fri, 25 Oct 2024
 12:27:01 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>
Subject: [PATCH v3 4/5] mm: remove unnecessary reset state logic on merge new VMA
Date: Fri, 25 Oct 2024 13:26:26 +0100
Message-ID: <5d9a59eee6498ae017cc87d89aa723de7179f75d.1729858176.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1729858176.git.lorenzo.stoakes@oracle.com>
References: <cover.1729858176.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0384.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18f::11) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|CO1PR10MB4484:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a062c4c-1fbc-4710-1f55-08dcf4f05360
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2djdjVV85awVdBOnSsubmgLlKUOqMrCtcJyqsnThveLdzfMFQDqEIq+Y2JH+?=
 =?us-ascii?Q?x7JgyzkuajQCnCW1nQv7OdTZI1hEaf5d3MCU51sTyKl5I1bIMwn8qQLBr3ir?=
 =?us-ascii?Q?KNwB12sLJr7zoxO3qTf9J2UP8JKHqQlji3znOiUV8eUmIdDGcCsSFhKEmcBZ?=
 =?us-ascii?Q?rAfPfkKzHaUWnVSYgsn4i21CRCSKgXliqsGEhHkBOvV6v5as3RXfR7L0KANB?=
 =?us-ascii?Q?+I6OxHd/sEkWWIUohBeRPbCbXXzNdF01d+VVyvQqUQhwIFKGsoYsdqcYwnij?=
 =?us-ascii?Q?mYOYNK9nlK0C5plVx+vzNjVXI+zCEjG0I0if2alxyp1+qUPjk4GyuzMlZpx9?=
 =?us-ascii?Q?8uLyugqtaeWyKKOF0hofUDqdVLvpD+k+lAZ5fcgyPYn2YR8bcBQxArn7Jfs2?=
 =?us-ascii?Q?+JsYveEXC6JI0A6n4sbcBClEcES1ChaupcLl3Ppo/Dxeh49EQittgOs5eCo2?=
 =?us-ascii?Q?3NRmLvLwDPJuTBhL2OjLwwawXWqmk2NQFRE2dcNloEXOLeWRgRg0Ns2OxXxr?=
 =?us-ascii?Q?O1R4tEPBcoqD837D0QXKIFjFNZzH2SO3wdAT5lPXOQUEytlHKjEzxaVRXrk2?=
 =?us-ascii?Q?6DsCnaE9WnqR/Ru5V33WzCTmTx4FBIxhXHICa1CAUMVXfQxrKof+eTspSr9v?=
 =?us-ascii?Q?dh84KZ6zbk7xRtN2WitcLoLVRG3kB+h08skomHl9qhUwNBClL6WRzcFda+rU?=
 =?us-ascii?Q?DcvYjEDGaQ0U8idJd4d3bbCGqMPXAjMqRfRB2Pqa7iJ+p74BArrmO4oms5ob?=
 =?us-ascii?Q?eRH3KkdoPAbgCVfdT+Q4GnoemLZUP9lcmH1evsesUh3seQOIuAJseiWnLHAX?=
 =?us-ascii?Q?OeNLWeHfCo/p6S7OIWcm3vEIDHYDt0WDyHkG4S66sDeo7RLzwCejG7/lwQJH?=
 =?us-ascii?Q?K/eKyULbMbBp6ehJ9gkiiu5q/cW6dnhzrpdflPuS+PqqhDiKrEmx6BhF8tpI?=
 =?us-ascii?Q?ta9/+H6rDuU4MtJVQNn/G4/DUxwZsl85Y8/q5Hf73SachqXe/b7SHyl+NPMQ?=
 =?us-ascii?Q?nKLZuQWwFCiiI/LS+MXZJN/7scpwGasPlef9SoJM1PbRvVgOcTJJ/MWRiJKL?=
 =?us-ascii?Q?QzdHjiXHttK6TT5cz7U2kQQzeoY2xihJZcs8OIK1ZwCrNTKf1+hXdjgsIhcB?=
 =?us-ascii?Q?WFCQsE1uNCupahuZZPR74J69SSdWeuc0s23Vsx3HotKnvyCK57U+8I/BkpEG?=
 =?us-ascii?Q?DH3xUGApYbjz4JoTgWHREB4WPhC2YSJwaH9C0Wgb7rvbMfKlw8duX/vUa7yG?=
 =?us-ascii?Q?NGy7x5yLckcPrwGbk/ND4NU275lggqy6fa0wotsMJfkot8Ufk3CR0T/TrMTj?=
 =?us-ascii?Q?Zm2cA+6aw5I9+alrU783XZR5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SspEO2vJ+EnSxTZVbjQOSyNEjfU2Tl0PyFzepbsA2ljkk4vO3hE7uL3aMza8?=
 =?us-ascii?Q?ZRFyUpE/q3aauM8OVBLo2Y8YfR/lUG0KJolWY7+R+039kWKuxeXib+fqJUY6?=
 =?us-ascii?Q?5h62hxuAlml+OsbpH9gvge5Y0jHByPwiTm+vry1dyRGkt7s2CdFP2UuWs1cU?=
 =?us-ascii?Q?4y7KX+yPJQXefayZ7HLtI44erwFyzE51fjE6ADH9R4z5jLD1v4mB2fYczsJF?=
 =?us-ascii?Q?YXhxdqWT0epmuaG90AVjKke13nQUNAiq35XYHO5hcmdV9rYBCHAv5obGUWTk?=
 =?us-ascii?Q?Y370yCsghBdRTV34p5ACbqL7dJZ4e75wqyQWbcmUapCJx3dmUVvH7QK8+zzm?=
 =?us-ascii?Q?8BowgBYMPcdCt4fUWYTvOZJ5RP2Ebzt9JwzHZ9IcW93pfPJlJ2LSsikxju16?=
 =?us-ascii?Q?SSaHDZN62gmcjk5Ycy2m5+TVK2Cq4Bqri0W4DNxYN0Dqqz94STvxRbCY8+xc?=
 =?us-ascii?Q?YrrYxX5gZw7riNrNHQgeeQT+he01Ozl5ES9k1XFZ1dwzMmw/z1SFGBWN2VMw?=
 =?us-ascii?Q?0UIW5ybxhEOpopDvtNKOp/Rq8xXPdESjX1KY/fOhmysDz8dSbJ0f9VznmfMF?=
 =?us-ascii?Q?jARBtd3iduDU8n+MGAFB2EiqljNbMj4RIG7jhP2MPDpWS+RrOeGyk3rrfJju?=
 =?us-ascii?Q?Q3MuGV59TKoUkvgGoGcmOtO230SUKkfxuZB36ydGGpTnseB19MsAIatB9FsV?=
 =?us-ascii?Q?EAimWh9lbTMeW+FBhxED5EeqlhW4Fq14g17oc8WsahlMq4aRMNOCHpuBXyWD?=
 =?us-ascii?Q?8X8+UmnuJp6p4OJ2sC5CNAE1fx1+tqXoAx95FV7zWFgOwGc4R7vsef/gCzH6?=
 =?us-ascii?Q?82cmPAIHkHGPnzFnuFwPevs3YVqMHv0Nhml3af5uNC+uD4D5Gz00Tgixppmi?=
 =?us-ascii?Q?eI6Y1jrxreky6LZfDSlMFI19wdjL7hV/BbW0GPbhwV+Xn121lRucqXljxJg3?=
 =?us-ascii?Q?+Izv4ubaxLWhlsLC/+ghsBedGYtidwzJK2lqa527E9+ab1sJNgDtqFI7Si9t?=
 =?us-ascii?Q?W9ldLypl6246Ji98qlae1fdCFEC/VyelIeyMzG+rt3vJIHU4+oV4FHMAOSgK?=
 =?us-ascii?Q?LSKk9CC5jDMgTMaTRf9gSaL/uPtfmmJiwTtIrBWItz5kWbnsdzXH5nDJroW/?=
 =?us-ascii?Q?PI+3t6bgjcG/lIhrMrtNDmMDp0LbdcMeGbd1ZEWONUWD1Bi0LCFUu88fFnHj?=
 =?us-ascii?Q?gFOC2Mqs49pl3q1VcOOLMRD2AIKPoOmlq6YnB6yS8XK65atGjPkxrC/1nArO?=
 =?us-ascii?Q?PZaPMTib2eLL6NEAxJ7u3eJEBbK6pTCIvNp7mSjCC1LFNUtpVa/dScsX9d3V?=
 =?us-ascii?Q?EcbJOX84sF0STM+K8H9CWt5gHVVF/kBk9M21LOc6ens56TIrmZ8YxxQaF3Z3?=
 =?us-ascii?Q?v3mwdh46kCbaw7+lYTXcbgllhS9q3Hx4esvDGa2oqG0yDJvDXwANEbEoRPtG?=
 =?us-ascii?Q?Nsgwx96RSI+jhrMiXo2V6KZFliyc+KY7wFOa7t6lbd/1TPB8vahM1dnSq59u?=
 =?us-ascii?Q?KehvUIAJuFnURWaCpcQoEiC0xgD+EhKFLpoGVQZmi1hDdFDngDbuQzq695G0?=
 =?us-ascii?Q?+tp622uldAotiAab7eZKu0KlMdG/4gmExoOMPdPCTyothkeaUylBUj9P0cvq?=
 =?us-ascii?Q?Z3jDnwwMgmOSdC+ENYHJnQL6JK0m2pRfw2crFIv6w5sArEKuuf38YzELiHaB?=
 =?us-ascii?Q?xQ1WbA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	E1zoyNcnWpKbpu1zUXuMhQEvW8QXMM+7QoLynOLya7ylMwWYGEX0M5dSv4R0Lird0Nd0wfjciyOU9M3cRnq5AGGWslJYM5/eJzQAA8RMjyKACV6hjk461ckcDZ8cXMGelhEbA21bXWWThLvWaNiEoSIJuX9EpBUpfI74XwkukCARArgzg9OVdNkB95xpnAgjRFz4G4Ox6G5MUDZxVkTs0gBd+o2YdA8YrXhVhkUgT0/hBS2tEFpuiC04715oHRKOmTJj1Fg4qyV6zdXa6WaYFlppbSrZBZA2kX0woozUwCwIy5eo3t4Hhy/X52CABf3nWigV05xOf3WbU3QMcJVwyxOP3up2yXc77FedbzmQQGn8ONVKGoiptgcwk+Qb0USfKao45gWCeSBrPRWUvuo74gqoisv0Y21UG8HTRumC2/98Uz3D64XUTc1Quyeh04FKL0C8yQNq3xJWgwf3FVM4PZ+HgY0rJ4nkKDJRVaqxn9uC6H9LYNI0wj+XrAhTYrSbQ0c34VykxOSymR7/d85r3Ma0SMmfLEvcYKmtNprfqBQmV0hpLN5JLo2Frqr8HeUPYjO8JD4KEeV9sCwO4oxjBjOb9+sQxc2oibYERH1cQXE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a062c4c-1fbc-4710-1f55-08dcf4f05360
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 12:27:01.0607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rSzS7/VX+MtWwK3rb60IBMc/2AjT6d83SRH7K4vO3p2ithcjFDWXIsH+jsYl9k5azdm+01uxfWbqOLdK81bFvtA+nAwiF/EldDJBMq6VM40=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4484
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-25_12,2024-10-25_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410250095
X-Proofpoint-GUID: fTZuV6PyLCISfuKZjl2HvDXEV7SoME3v
X-Proofpoint-ORIG-GUID: fTZuV6PyLCISfuKZjl2HvDXEV7SoME3v

The only place where this was used was in mmap_region(), which we have now
adjusted to not require this to be performed (we reset ourselves in
effect).

It also created a dangerous assumption that VMG state could be safely
reused after a merge, at which point it may have been mutated in unexpected
ways, leading to subtle bugs.

Note that it was discovered by Wei Yang that there was also an error in
this code - we are comparing vmg->vma with prev after setting it to
NULL.

This however had no impact, as we previously reset VMA iterator state
before attempting merge again, but it was useless effort.

In any case, this patch removes all of the logic so also eliminates this
wasted effort.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/vma.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index b91c947babd6..7c690be67910 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -963,7 +963,6 @@ struct vm_area_struct *vma_merge_new_range(struct vma_merge_struct *vmg)
 	struct vm_area_struct *next = vmg->next;
 	unsigned long start = vmg->start;
 	unsigned long end = vmg->end;
-	pgoff_t pgoff = vmg->pgoff;
 	pgoff_t pglen = PHYS_PFN(end - start);
 	bool can_merge_left, can_merge_right;
 	bool just_expand = vmg->merge_flags & VMG_FLAG_JUST_EXPAND;
@@ -1020,16 +1019,6 @@ struct vm_area_struct *vma_merge_new_range(struct vma_merge_struct *vmg)
 		return vmg->vma;
 	}
 
-	/* If expansion failed, reset state. Allows us to retry merge later. */
-	if (!just_expand) {
-		vmg->vma = NULL;
-		vmg->start = start;
-		vmg->end = end;
-		vmg->pgoff = pgoff;
-		if (vmg->vma == prev)
-			vma_iter_set(vmg->vmi, start);
-	}
-
 	return NULL;
 }
 
-- 
2.47.0


