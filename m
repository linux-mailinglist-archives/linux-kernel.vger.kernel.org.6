Return-Path: <linux-kernel+bounces-248167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E23892D911
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 21:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8145F1F20E8F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 19:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9892219924F;
	Wed, 10 Jul 2024 19:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DAYNy54i";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="B74dl8nk"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB27A198E60
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 19:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720639432; cv=fail; b=BHq6b5BXR3l5NmiY5Aerl21D3agE1xcjEOxftZdlMUISfhX7PoEhGrXJnc7Jlqyck1uI77qTxQLtn4HiSxoFfzz0ypzkTkxErvNZOS2ZFncQP2flLzcha0e1d9UWJSMJ62L73xypWyvmf9v/DLhMgTfrqY4ASjge6I3YmBf1mCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720639432; c=relaxed/simple;
	bh=YEqd+KJatxRuj7+X+vRtCnJtZkDAgTjLHSq8GOvJUBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EqpxMt+ucxm2Isi1zTu+K9yv32O1Lgien9F1UvXAXsJf4P7Z4gWAGp6V5Kv44Z25ND5G6UEb5q9g8H31pHOdhoHc3f5MONMNuK96x04zHxl+ljgHXKy7c6XeQfRtHadqhOZcRnvyVj+mEvKP1PaC9IHUGrcuo26fYg+lwMywFls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DAYNy54i; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=B74dl8nk; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46AG26hj012005;
	Wed, 10 Jul 2024 19:23:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=b6f+cXlgUcQfrdseKlJZgmWZ3atIxU2VOZg5eVuWr3A=; b=
	DAYNy54i7LAyHpDnfPMoDe19lnlL2Kw8eTMkvUsOSxKEJCctxxqLLSPfjlLiPbqH
	6CPuRwoRoNZ3TKXegdtXFuKYZBmvrj3AAX0embBsdz0BrRunBnvStMumOT+AJcjd
	WM2CS2koMLzYULa2gBk82O/wsTfwDEuGdDmwCT4HEME3IMPbYQEtFyNzrj6IS4f0
	h62VrzYuvwH6lHbVJxVBek/F2s82XEyQC5xOIfmd3ddNLLDBqD65MrTZby9TXYRU
	W45pKo3RiifrTnwu/G2Gi4BV5hVpHc9f70M1Xh1QsIqElYRFL4YKRfIrUtfODWmx
	EIKOklkYmePn9eY8Ej1drQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wkcg0bn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jul 2024 19:23:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46AIs3bh022604;
	Wed, 10 Jul 2024 19:23:35 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2047.outbound.protection.outlook.com [104.47.55.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 409vv1gwv5-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jul 2024 19:23:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DTb/DHUrGHk+GlN+Kw6As/bakUYj69Na9Mn5jiXEIY4Ri7DKF3uI+4kCvZc7wMNsOWxhmqFxplCydxmJMWLoKyrsFmHx9sv4C8LqIGmzEJ7VWsu1OBDyJftYqEywkZ6xHoEwa9QFYHfTdRnR3JwhJzP3a9FoE/93WY7hWAAgUzSW0S3Wfsnjx7OGwUW1zu75hy825gnrRCW71dte0vdKv/MON9RX/OTjkjOaC0UFx+uxuDabNA+wh2N9oNs1EPyA5KbpI01q5ypdqkFL9UKbqT2oeVQMrb920vDfqa6/QQ9dnCHAJz0Cow17tlzPATe+8MfdSfk8tVhRWNpALY6Mgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b6f+cXlgUcQfrdseKlJZgmWZ3atIxU2VOZg5eVuWr3A=;
 b=IoyqUx0c4pOb6XMyPtT/3oj0AKCQaRfcDARoFk6zkaCZhzUzUb2ENomqsPUwhO4QD7UdH7wO0U8OQq46S6jur5YgOCSIW5CfiaF/sln8cpDBcvxT36DpMr3G9LXMayB5v3kYPBEWIa6EGk0Tz4LWQzzjjM/ZODosLyh4My5eZJwM6z4Rl4BxFHmAxk/oE3+/H7h02CJD8yf8i/nKWlZcl+1QBdz32AEHAtbtn+LLUX+S9eEjmeJHf27OBrmdiC1pOBq0t95RNQZAlh8HsDQBSi60118vTab73erauKYDZNzCaPRCwdBN/KJsLdzEXoPqXhohCNWKsO4hkOT1yHEn8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b6f+cXlgUcQfrdseKlJZgmWZ3atIxU2VOZg5eVuWr3A=;
 b=B74dl8nkMYBVoDpkvzMzBvIKl7mxFYP8pHPVLlovuGNI0N20FctHtfNUpYDuvn/0J12xJ79HFJmGrydJkubjE7lW8hQapDPWgzG2d1lB1hagS08icaVBxpbjEXyf1g905wMhCvQ/qICB+bof14vJg5prS2FAbGproUlJcBkDPNI=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CH3PR10MB6833.namprd10.prod.outlook.com (2603:10b6:610:150::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 19:23:22 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 19:23:22 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Subject: [PATCH v4 12/21] mm/mmap: Track start and end of munmap in vma_munmap_struct
Date: Wed, 10 Jul 2024 15:22:41 -0400
Message-ID: <20240710192250.4114783-13-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240710192250.4114783-1-Liam.Howlett@oracle.com>
References: <20240710192250.4114783-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0018.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::22) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CH3PR10MB6833:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c50cfe8-bfe8-4ed9-2a4f-08dca115c388
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Xu+61HJf+UF/JkR6gviN/79E3QPnjIYbBRRNVHviH/sXUyScIzK15HVjLCCV?=
 =?us-ascii?Q?XmsBC9a+URC1seV+vYLcOV3IRz8p0/ZoONomdwKpu2EH2T8S8fMs2MRk6Q0d?=
 =?us-ascii?Q?iXg+hcAYoJm1qiyvd39hOc1LQ0G20b+1JT21iq/0GzRleGOtn1yOzjxW2s5M?=
 =?us-ascii?Q?jjRdbaCbFfOnB/Jn8MgKhPw4fo0DmUeZrs8ZgNdTJJSOgWsixeAq0Ejaz6jB?=
 =?us-ascii?Q?D687CfqFXURfse4MMUll1Wt+bOrXCO6gwlWz4UxjKfhvfwX4+NyKgFnBD4JA?=
 =?us-ascii?Q?Ey62emeR3JH3RoEMNm/mEapo9Bdu4vUhlYH69QOJErZgTV9J4sIcLgIyrWwd?=
 =?us-ascii?Q?50Jyd/dAV6m/FQ5hZJDcm1ZTvXZJTaSueSIf2ObW+8hSWxquZm1IW1+VLjuD?=
 =?us-ascii?Q?L25P8V9F60IbJvHjIs8MBc4mjkAZwqAWtDzkheIMUiSVB5cDpJRhSpSMlZhW?=
 =?us-ascii?Q?FiQTzb4p9E7W/m7QyiIzN81tyEFfkcJ029DQRPyXj1mcvW8Q4Tbx90KBFYsa?=
 =?us-ascii?Q?YjyAFTPuzxEIeVSXrYlvgroH7Pdxt41OoMFnX+ibChAMu9Asgdy5WFi55kff?=
 =?us-ascii?Q?oNxDT2TmHf7DDp+wtvzj17C3daDYYWMHEGVG+NBy19zo7PY3ABWSxwJZ25Kt?=
 =?us-ascii?Q?x5PEUyoFM4FwJESexyp7dWiHcIRbiotDf77joaPv1PQjDGwfp7ImJSShmoG3?=
 =?us-ascii?Q?86LcdMGh8oK8FGZ3F/Crkx2TTGJa3AOoTpRm4ppvDHpS7VlXjwbDEksC7AbQ?=
 =?us-ascii?Q?d5vRdf31v+CNj8OZMR7MyVNqk0xOl0ge3QTyD0L57FC5baKh4fyONRASdJu9?=
 =?us-ascii?Q?LxyZbBrdxgpeTrgIhlxV2Gs+HbXT7yd8L9FqvBeFZDrbrfmoS5CR0ZWBBLIy?=
 =?us-ascii?Q?0VXcBAedaXsto8Psdl5u3+VNBcT8hK6OE7cHG7+SFN8L1iVLae+qWHnpBnQS?=
 =?us-ascii?Q?qj7mZpRskwVqOJTu3q8cx6N6w3H2qfD6m5pa4trhBg9d3Ldh12MfXgTXlqsZ?=
 =?us-ascii?Q?SSM2hWoZCl+WwHDimifQnKYYbOKmKb8biuS4rChOUVmPjxmNCbFF+Bac05ts?=
 =?us-ascii?Q?3NRlJh9B+O8Y6Sp9yKTMxCtPCacgHaZ92O2sfoT1g1lLsM3ImluWhuOjcjvR?=
 =?us-ascii?Q?kqhmQs32KQcag/FSfBDxwTK1aw5wRcS1nrcaJeI8a4LOrw4kZ04sdFV8tT9X?=
 =?us-ascii?Q?ciAQOQmUmu110xSN5Sf8bPjxM/bLhrCzpoIQoRVdNyPK+6OUkF9k1/78/Kpd?=
 =?us-ascii?Q?tlDHOh5GpI31bnc6OSQkTSJIA5UDlsk05caMbL/1Ar5FJYonOlo97xSyfbXF?=
 =?us-ascii?Q?ZcVxAfVxzLvgKwlA5AlC6aCZfTcHz44Af++bYQSn9qxBpw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?+gQglyFLKmCOEHqMlkiiPOKql9vXwRcOagWzt2ymNT+qxC2hN9yePTxyoFla?=
 =?us-ascii?Q?37NLrub4dWHXvOLvtgFBHUx7gZQmeOwtfWGJtJ4xzTfguNRUAPkBeMS6wr19?=
 =?us-ascii?Q?2togqqVQ50be7yScwcUxOh4wH3wxboaH5jMhRQfWF08WvO2ziO5NQLgWZt4b?=
 =?us-ascii?Q?uXwc0IPOYuay0TY9uYUKQGx/HVdevK9XT087L3hke+Qpx/sy+sxrrFM8rejr?=
 =?us-ascii?Q?xAhfgXchNa6HtrH5Iel5eXi/aYDEf7dYM8aSitfU7reEmCZh8S74OxzQpei7?=
 =?us-ascii?Q?EGk69RauY8bSS09phDiFHI73HFEEF+3AmSaiFCgdT6ouhriVHHjSP+ZFwK6z?=
 =?us-ascii?Q?mnSW6zzeZb0x3R+URFanJyBK6uM9Czp5XM5ptcQqnzOTpsz6bP7xndF5aK9b?=
 =?us-ascii?Q?OvhrI7aVuL6hIA8lpLg+iYOUzUnO7ZxK1ZwiM/E8Ohiq7VmawoFgrptr7sXl?=
 =?us-ascii?Q?uICD2VSVzo3ahR95fTWKRPYEzMUCQ/sixfwh6hg9mmMX2GUPtqiICbQwlsmI?=
 =?us-ascii?Q?knmvjpkYcveTfWZ2oXKDi7HWjCeCUYSCVfhGI2a61bPZ1dDqauCVcWfjTgoZ?=
 =?us-ascii?Q?q/K64eKbZf++jsBjaMT4JK/Ii74kwghZFA9oXjHAZnwi/5nlp6neezFwtGvj?=
 =?us-ascii?Q?XWc4CagGzfZXIM1mcSfelwHlBVHrF4/VJopcfeHGpPc4m0bjZSHcn5Kjiw2x?=
 =?us-ascii?Q?beetwjJMHDLf4CxT5r4yBAKnOGZNPNfjDVZNAaZCp/152Ul7DRxKx46oYYFo?=
 =?us-ascii?Q?7kGRPFnmHh7zGgTEpy7wCwceyZE0r1JTlCxYyo//Mjr2XrY75QuFa3smXc8F?=
 =?us-ascii?Q?tGQgLxSMPnwDS2nhMg/ugL2GV7FVBO3rEX5qIvH0K66ixJGQJlaxl0mG/DCP?=
 =?us-ascii?Q?wVb6+VpibcGjQTPQS+uCMbwhiYD+S0KWMHPy7bc1ggLMHMcDuIF2U9TtcIGg?=
 =?us-ascii?Q?LpQ1ZGZYMjqKcLbX42q11kI5bQqG7HYtUOV0ywPuSUo/NUk4uaB66YIELZq1?=
 =?us-ascii?Q?o4VO2vgBBnS1eNSLU+PqMpeGkZ7sbkeaRmVOLm2bWS7WL2bnxFjkE4ArAD5q?=
 =?us-ascii?Q?FhCgVUJRAZ2zZsAf+UOePDYSyzoUmIgEAcGB00VE7VhMU+VOK7xopLboMoAi?=
 =?us-ascii?Q?Hj84qn4FlnvIR9IAfVU1n0Sjk2b6yS2IgXO0hTEunalnWb/pe8wASYBlWzhW?=
 =?us-ascii?Q?IUeiODQj8E2Zi6LY4ByvZ/+Np6zOBNSlUmXFOa4mwbQOIuC5jvjJQvWWuHS5?=
 =?us-ascii?Q?VtO/yBCrk790LpyNkXVgl/ZAg13KqQwCxIj23q94fhKdWygcgSVJfBs91txs?=
 =?us-ascii?Q?BQH/1AvhSGzrGRl+N+ekAZ8eISqopDMwhVjbUzoFrqRbxQCdA9dexHEhp6AX?=
 =?us-ascii?Q?JtXZOZ4wPU2LXmrxs/wLhe8CHtYMWuwXojXSQTjeAiGAG7Hhjw4vB2U0/LSR?=
 =?us-ascii?Q?VPHkALn11ayJ2B3mk9yoJ/smCh5nSfzQangfT9uOlBJ2VHD52PqKlHFHW9zT?=
 =?us-ascii?Q?fo4Tlwu7rUN622SFyiwptdnxCxvw4uLS6kHfApPs8fdt1Eun9o92z4pt7DrY?=
 =?us-ascii?Q?DQoDWYcnBroF00u9iuEeL9cM1nFS2NMvrGTiGt9P6aiqgokqk4tykQv/Yj0a?=
 =?us-ascii?Q?nw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	tLoZjPjUElYne7szt0niayCO2afTcoMIlkrxVep40rfFtAsN+/wL/WtS/KcTYi1+Mvb/1J1xLv+t8H9KQxRbJW03yMw7wcMaIVvvRqtwnZHNbSjd/ARqqurfEANAAxcPtGp3ESYhQoyY8wU6jblWbd6yNsKAE55pxnX0ld8GqfSJO+cHk9NaZ/P15yuYLbMuM7THe9/5lHGyX+ctX7kw6RGtFCzsKk9S1Eew9SEYnn3E0bkA9Y7nIccJ05Ic6yGnc0YywQRHBcHE1o0iHIfgHIUdR2i4KBJOLH1f6rRsGC7SOzArL9tbXYDG9RWFgtmpWqagEwzhnLcdNCTVLppMJsiKin/GpKZPTWXepi2JJLlQvOJJlQ7ZpSCQLnNPU4P1QwQK1WlAShu31RXgO6AXj5Uzo7Taot4uwe7MMsLM8DXinZE7uUbT90F1yHgzTf/eXqxwXoVHGEiXA2+fjEqS68b166+UORpj7l/iAE/pFSFFTPr4w3ujd9d8URXVeWLLWOqgYXM8XMB+O/EKxbNRwK0aqk5XxTCkXbCufaGnPrNxWhKgTSy8r25UQCA3F8TMSehCGzKV9BzdhVQ+rlUrMjLvuDqjMC68g5lTYAoBMmk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c50cfe8-bfe8-4ed9-2a4f-08dca115c388
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 19:23:22.7636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mJsyIqvMIYvjGmx90ai7xL0aJ8OG2xOZpckuIaNUAeK2tDw+1r2dykXPfVvOYeaRa5CZAfGTvHj4KRSWpLpj4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6833
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-10_14,2024-07-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407100137
X-Proofpoint-ORIG-GUID: 290507lpejHaOMKqnXij0Foqyc4lkq6u
X-Proofpoint-GUID: 290507lpejHaOMKqnXij0Foqyc4lkq6u

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Set the start and end address for munmap when the prev and next are
gathered.  This is needed to avoid incorrect addresses being used during
the vms_complete_munmap_vmas() function if the prev/next vma are
expanded.

Add a new helper vms_complete_pte_clear(), which is needed later and
will avoid growing the argument list to unmap_region() beyond the 9 it
already has.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/internal.h |  2 ++
 mm/mmap.c     | 35 ++++++++++++++++++++++++++++-------
 2 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index a22547125c13..11e90c6e5a3e 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1493,6 +1493,8 @@ struct vma_munmap_struct {
 	struct list_head *uf;		/* Userfaultfd list_head */
 	unsigned long start;		/* Aligned start addr (inclusive) */
 	unsigned long end;		/* Aligned end addr (exclusive) */
+	unsigned long unmap_start;	/* Unmap PTE start */
+	unsigned long unmap_end;	/* Unmap PTE end */
 	int vma_count;			/* Number of vmas that will be removed */
 	unsigned long nr_pages;		/* Number of pages being removed */
 	unsigned long locked_vm;	/* Number of locked pages */
diff --git a/mm/mmap.c b/mm/mmap.c
index 83cfe575c114..12a5ca6c979f 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -527,6 +527,8 @@ static inline void init_vma_munmap(struct vma_munmap_struct *vms,
 	vms->vma_count = 0;
 	vms->nr_pages = vms->locked_vm = vms->nr_accounted = 0;
 	vms->exec_vm = vms->stack_vm = vms->data_vm = 0;
+	vms->unmap_start = FIRST_USER_ADDRESS;
+	vms->unmap_end = USER_PGTABLES_CEILING;
 }
 
 /*
@@ -2609,6 +2611,27 @@ static inline void abort_munmap_vmas(struct ma_state *mas_detach)
 	__mt_destroy(mas_detach->tree);
 }
 
+
+static void vms_complete_pte_clear(struct vma_munmap_struct *vms,
+		struct ma_state *mas_detach, bool mm_wr_locked)
+{
+	struct mmu_gather tlb;
+
+	/*
+	 * We can free page tables without write-locking mmap_lock because VMAs
+	 * were isolated before we downgraded mmap_lock.
+	 */
+	mas_set(mas_detach, 1);
+	lru_add_drain();
+	tlb_gather_mmu(&tlb, vms->mm);
+	update_hiwater_rss(vms->mm);
+	unmap_vmas(&tlb, mas_detach, vms->vma, vms->start, vms->end, vms->vma_count, mm_wr_locked);
+	mas_set(mas_detach, 1);
+	/* start and end may be different if there is no prev or next vma. */
+	free_pgtables(&tlb, mas_detach, vms->vma, vms->unmap_start, vms->unmap_end, mm_wr_locked);
+	tlb_finish_mmu(&tlb);
+}
+
 /*
  * vms_complete_munmap_vmas() - Finish the munmap() operation
  * @vms: The vma munmap struct
@@ -2630,13 +2653,7 @@ static void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
 	if (vms->unlock)
 		mmap_write_downgrade(mm);
 
-	/*
-	 * We can free page tables without write-locking mmap_lock because VMAs
-	 * were isolated before we downgraded mmap_lock.
-	 */
-	mas_set(mas_detach, 1);
-	unmap_region(mm, mas_detach, vms->vma, vms->prev, vms->next,
-		     vms->start, vms->end, vms->vma_count, !vms->unlock);
+	vms_complete_pte_clear(vms, mas_detach, !vms->unlock);
 	/* Update high watermark before we lower total_vm */
 	update_hiwater_vm(mm);
 	/* Stat accounting */
@@ -2698,6 +2715,8 @@ static int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 			goto start_split_failed;
 	}
 	vms->prev = vma_prev(vms->vmi);
+	if (vms->prev)
+		vms->unmap_start = vms->prev->vm_end;
 
 	/*
 	 * Detach a range of VMAs from the mm. Using next as a temp variable as
@@ -2760,6 +2779,8 @@ static int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
 	}
 
 	vms->next = vma_next(vms->vmi);
+	if (vms->next)
+		vms->unmap_end = vms->next->vm_start;
 
 #if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
 	/* Make sure no VMAs are about to be lost. */
-- 
2.43.0


