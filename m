Return-Path: <linux-kernel+bounces-352426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83463991EEB
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 16:32:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 645F71C20E58
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 14:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216751304BA;
	Sun,  6 Oct 2024 14:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VYsZQh7+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="b736EQUb"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BC73A8D2
	for <linux-kernel@vger.kernel.org>; Sun,  6 Oct 2024 14:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728225108; cv=fail; b=JsIjgQ79fGfgmrgFm7o7qLzdahIAewwgq3TZwHvNI6XEzcOVHVXlHJ2LwMqf9afZL8ow8Sl7teO4c6BZQFVKlIKhv6AgGOSiBcMbT4osSJ7MDsiQp8x+cQZ4Vx6KUDh8YhLsY74uCZIwlnq0XB2rb6ivVwp+wvYcMOU5O+6Vu5E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728225108; c=relaxed/simple;
	bh=1H2KMb9qGIS2Ai9YNeYYe0gyaiwHEVcXggmOJ2wF5og=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J1WMIJjaxfDPUI5YsomuLwcjXp0c4vyzqFH1mwTFL14DidFPUth+mS5eDVHzA3+60BXucysTbcrysfDHT6R8D0rdhdBN4WwTg0vy4yL0TN1vLT+jVlULvOp/RT4Rky6MSHERah299Z7BElDL9pmxJNEyWVW5WKpViedoNuU4jWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VYsZQh7+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=b736EQUb; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 496EC68n018991;
	Sun, 6 Oct 2024 14:31:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=7kVSLPU3S+DvH+QejgupjPx/n3kvGzT6vMAa/M7tGu4=; b=
	VYsZQh7+OcoWmRSewPaNYSy/40AI9lRxXhD3y2M8N0SZ4o/P+hE7ypebthQXj0xx
	YIHERoDjCynqtubQYs+TCnqGq4jBQSQi3LMLFxMnFG03+A8c5KSgG1b8Jf8e7yt8
	M2T+Bm1XSr23MtfePDH9e0FblZpiVlmk4/s56RWsxTGOjamvbaHo3PwziKIqiljz
	058L4o2pH57Edl62Msb35w3c8PlMofnC1UycjI+O47Qf0jz6ivO+oLbnV7jNPnkq
	AeEF2XwcV/b1yPwryaP9qRN6aScSOl1W8nlm53eWWnBjZxagKYAKEwqZpkr8dJ7C
	4jvvwMHipfGexqQhhqfeFQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42302p9966-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 06 Oct 2024 14:31:23 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 496969MP001235;
	Sun, 6 Oct 2024 14:31:23 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 422uw4xfwk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 06 Oct 2024 14:31:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ot4Jsa5CTJ/u+FarVnas1Gwe21a8CdwAUV/qQN4/vesKNHtUSkeLsz8hEj5ksMRzk2NsuNlrnIRnETVb2+0rvvjQUwTSJbyqd8Q94YWOOYFBdhExc0D8Y7qfvfCWwN+b6hRbVeQ4jkMP2HNZ9BQKmyvf3Bk+7GeIQFJO64XmanvtDfjtK9otysm49aSiiEy5Hx1/GIXX4CnZTekmrfOEHxCIJrLnlc8v9dVKTuUgFjyYX/9qwk2heboW07U3m6qkAJmk4yBg2OuivK3qbiNCLK8xz6yT7H+zJpr5NzRobyaVoaTwdgTtVouFEs1Q92zP/KW2QyOT3QI+CaoEL/RVBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7kVSLPU3S+DvH+QejgupjPx/n3kvGzT6vMAa/M7tGu4=;
 b=BZcTs5Qhucy7UT0F1RsXlIHcOX3bQFS+265bz72tXsm+sGStzbG7b4x/lEHWv6Y/51G9gP3Z80qLpHX5/WsxWZE8DljEVv9WsJOLsfh7Yod6uyo0VFcPqS3WKhGpoP8eyK63CUantZ1OzOOsiio+VYWQ81myEc5eEwvsLmQBlp0bx9jfF6/M/D2Y1BV9L56ehDsBQlsZ5lI9ng91lPy4vb/rr0qLfzafDZ+YrGfHzxAfYYCd7MHmj/Zt2B/eDP7XS2iZDlbhfi5NdkAjIF4PbQBApa8sY23yd9F2cmQtdCgv8WM51I/zIpwpOT51T3JWRWzSs4qVsx5fCnQjvsYZTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7kVSLPU3S+DvH+QejgupjPx/n3kvGzT6vMAa/M7tGu4=;
 b=b736EQUb05dY9AUNGxsgDM1VGVo/CJgA2HfpzCvqYP7/4ZW6bTIO1+LhgQ/A5HiytEeGLa+VDnLWuoIAYr8byoPGn02giNGwdoQT7lc/8+Cc4ZI9+gmdERVR4r+yfMxVA4uXxIxBJ3w9qBG/Z4agZRxbFJo99/jWePWxklFqC5A=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by PH8PR10MB6503.namprd10.prod.outlook.com (2603:10b6:510:229::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.21; Sun, 6 Oct
 2024 14:31:20 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8026.019; Sun, 6 Oct 2024
 14:31:20 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Cc: Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Bert Karwatzki <spasswolf@web.de>,
        Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        maple-tree@lists.infradead.org
Subject: [PATCH v2  hotfix 6.12 1/2] maple_tree: correct tree corruption on spanning store
Date: Sun,  6 Oct 2024 15:31:07 +0100
Message-ID: <964860c315780cf3a5b8929a34b68d8208333c16.1728223996.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <cover.1728223996.git.lorenzo.stoakes@oracle.com>
References: <cover.1728223996.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0146.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::14) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|PH8PR10MB6503:EE_
X-MS-Office365-Filtering-Correlation-Id: 1388fe6d-c0d4-4d0a-3448-08dce6138bb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U2PrAMTGBweTijD0Xytp+lOcX8TEMeFZXmorL9YXbeM9gIzR1NFSnE6t1SHz?=
 =?us-ascii?Q?2y4a88T/0dYSwhKTmsF3gO166uHytodA0hg44bLoOkHVoJFHqTI2T7Zyxmzz?=
 =?us-ascii?Q?/nBmtncD/n1RwRt+4aQqJ+rExG7YtUPaE4Xv5pDI+RBXS2y0+AXzl4iNRN3+?=
 =?us-ascii?Q?9TUM5oGTlf6B/0eGS67yu+5EscvTmf9p8+7zNcWcV3uWqPlHL5B0X5WGtsQE?=
 =?us-ascii?Q?ODYjqA97LrxHZIyHvke2TLYDld/rNntQ4Ic7hyQL5Vek+4NKedraCl6p5rQA?=
 =?us-ascii?Q?es4CF835SUCoAGH95Hr7PqUVQ6kNXNaO1HIhpHJgUvxtgGU1eSlb2d7BYpXm?=
 =?us-ascii?Q?N+HD4I8YKNCHhM3cZQRbJn+0X2VtEIewcIncQUcr/vqlxt0DNEKaRu/euAbV?=
 =?us-ascii?Q?m13YO9g84ITOku0cXeMH6ygqEPXdlS0Gjn+yxOYO40OG+lnNA+/Gb8C/H6J1?=
 =?us-ascii?Q?zSQ336ZLI65eUAAzMkhMU81yV43gyI221QiPrN9m2EU68mOir7tqrGiCK8w+?=
 =?us-ascii?Q?qxXEpyRKZqCuPkBGC0v52uHT9ScrSmcsjWFqk/efnkPCohtJUpf2fV8fwti+?=
 =?us-ascii?Q?BIZYUZTNrXltmeKWLWUfgfuaxkERwcajSCIEo53WUupUTcAhMo20V8Ts7Ua7?=
 =?us-ascii?Q?sl2Jqeh6SdUr02F80d5VJi1PEazuEMeec1p2bvIDV0YQ0KimJAPamDpU6FUJ?=
 =?us-ascii?Q?bg6Dsrkm2vLYId6y1H+CiNGwWIyfKo8tSxlDdhyGvEfP0CzAcncTLqQel440?=
 =?us-ascii?Q?fGx6NWyZGjPIkXaUyJIvVJfy8CDZElBro9zYEvyHPLV7JIpH/KkW2kfsOdGZ?=
 =?us-ascii?Q?jOfBPwMMjoa1Ta6BGg82W29BmrXxhglWqbc+ES2kCyuQkmlKJ9tS6sQxHZn7?=
 =?us-ascii?Q?Ko2aKPGxxSfHBpoX0xYneQ0ejNQ/3DCTPyFXU6iD5dpvB8kqA+oayeGUlQQA?=
 =?us-ascii?Q?kOFft28INM81nxZvrGKf5Y180mwrNNW9/N5V+TUnwf5c7b/95D8jElhf1vu0?=
 =?us-ascii?Q?H+DexxcWLrGlos33N6T8P+xeO7kiIacLNkWFjireaFa3p3vG1tIRIOqRSvF4?=
 =?us-ascii?Q?AyJ0RCEHbr9zd0y3NAL/JOvr4NQr2JxtPubY8h+uLLE+lSrHRkhEoP40zdQd?=
 =?us-ascii?Q?WGOPrAyFh1Q/4/JPNVz9V+nXstAj6BkDG+GUQdsjxPMEm0LN95MsNmfvpumS?=
 =?us-ascii?Q?Av4sWEECxsvjmrhYJEa3R/BJdE6MG9sQEQjTDX66Nw0Elc/vgJoOFcmTmrI?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LxDhpKjd8nIoNQrnMr49BqoAEWLvHfQlRb9quHUro866xQHaOIwnCcBWDPYw?=
 =?us-ascii?Q?vftfOx74neZyh2ZjZagjVp+wGO13F3Z/isgrLBxglyiiQjik/PJGT1YgQ+xf?=
 =?us-ascii?Q?FyOqt6fS/WAT6gB+wMI6rgO3o4iFGyo22gNgk0vEfMq467+83KiHsoJuxHvq?=
 =?us-ascii?Q?z3GaTao1LhJYaaGyU/mKokI7UH/jKK+8mIMRxiO8vzesGPL3TFO1YxcuqEW+?=
 =?us-ascii?Q?fp2oEr8cU9BjSjOXATFOgp0bH0l6XsaZMDqdZWtstMlZiGuWijxTJ0dx9nUd?=
 =?us-ascii?Q?zMZt3k83zHIvyPfOGqFOE3hmG50Id/IvPvYi3DeOlkCdQj9r/8yex/RYJ6MK?=
 =?us-ascii?Q?Rbx07hcDEOVcSOLqUIymWueDFLlDVzgeziHs+f+YzCRqZ1wOE4c7VACqlQB2?=
 =?us-ascii?Q?tXL/NNPoc6liEdhKANqCma0Es85q7kCj4NqgIk67drCGEq5X8ixqCp3gmBtZ?=
 =?us-ascii?Q?oAIfXT1dmpEC85Npt3KeQf4sBFwCSTflcxcxid8K/C8oA+dnJeM+o7lG0Nhc?=
 =?us-ascii?Q?JdzpJUgeXHPp01QM4qw5vGuvkFftRHHd68wYKPUaH7c0Xj+eq1lBjpz+LOa/?=
 =?us-ascii?Q?eGkKuUaYLmC8TiDDFJkOzzMMoJ4441A5BUtPD//b9WNLhMcYvu9C29S5VVyw?=
 =?us-ascii?Q?zkMFUqd9Tb7Jh5oUX1DvBRZUPKRJczfH6FcYrFA1gG74idXY/qDzbgq1JuQ8?=
 =?us-ascii?Q?oAbHXX+VVK+Q5x7UDnrkyySqM4u8i9eTx3q2NJHyDlxsBr5SeytdG0XJMMta?=
 =?us-ascii?Q?rVlTIT85Zl2TZjNAHeOpoiGGYZoOjJ38V3/ygOEbwbv0fIpjYkO7PdaiOqYC?=
 =?us-ascii?Q?IgA/gSEK3godIj29uK+gHEd9veA/84sJMagOI1X7D7693mURP6qxRrvcQhHa?=
 =?us-ascii?Q?yn4GLt8HnIuS2bSN0GXbZROk/0t+a0cW4XxMwdM2qEo0XkHhUhf2K2szE46z?=
 =?us-ascii?Q?IlAwe8j5ctSNYx4WW32ELEoucxb4hpl2dNIGHTreoxq0bI7OcV3YS8lYXaAX?=
 =?us-ascii?Q?XXzF6u4HV/iFbiX/i6G5XmS2lX/5uOR5Wb03bywL+xWlXyrQNZ70mMuyYc3K?=
 =?us-ascii?Q?9FT7BnUBo4906JLJwPkp7GjL9jxD1GAFCTCoUv4GkvJeRVgq7thpowSxvvTu?=
 =?us-ascii?Q?FUxMWDVg5fwpmAjoMv7Jo7dEEwP7Xy+fTgG63Jvw+clvSJ1kgLuCdLLg6G29?=
 =?us-ascii?Q?D1xUxmZc0IXxBte26+TPoTQMTaveTrHTGOOiaLm3ewAN6AIvKlpwEY3Zsuu8?=
 =?us-ascii?Q?PKks6nfmneUxOsB9NILYrOrU2WY8xlLTlUS8z5FO0LgteFD2kvcIWyE59Tyr?=
 =?us-ascii?Q?DTCt438aIYcE5vRpm8WDYR9RxGHu4lKqBbdFBtroU3JTm1v96IjQtBljVILo?=
 =?us-ascii?Q?SQ13HJuVvfuk02erFQSmh2DIEKpaTJHjHlT61AfaB3zqsORpdVK7CszR1qzr?=
 =?us-ascii?Q?EwcOZMkj9dIzzQx8j15fkvoha0a6MYCwz3xhm/oULkEuk/wUg95qCFpwClH+?=
 =?us-ascii?Q?GZxZ9dNZ/EQPo+H/pePMwtS7wOYPCRJPMlNvugJxP1pnxLhvs7JA7JC7cRq1?=
 =?us-ascii?Q?i6Bkc5RwZ7ZQHCiPmANcEhnn6sy2f4WWnLTpENeNQxt+NpYetvkw3jsHPuJh?=
 =?us-ascii?Q?DA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BzQs9ogl+NSNiGU+aprM/IQ1IMxkLqRsn8dYOPwkdwHJCdrJ47toEuxKFNNY0zmLqvyAEf8SfQ7NEOHno2/QMXqDG5B/mWqlfn0LWWRRwrkGAvJhlzIMqjUfCDqeW322+Es9amDVjFvi2uGbxjR0clvcs+57eV9LLBseNet9IymwIJ1qv2dZJv/Wn/wkbv7ZeCOw+A0aCAbTJh5FkdbUf600fi2BJkp9m6CxDZcIVDcXLcmNgZkE9j2FWzl43GfECfkjW5BEOVZ5ZUMQQx2yfF8sr11pggeFhALzHnp86c6XNaItuQNPu9b9/Fkb5VkoAOWupwHBAMIVwRgMPWfShAaGOq/kODnYtYQH6Yc1CGucZSM2t6+ly3nw1hnwyQMj2xjcB4cYlLdGpj9U5H/YDrKWDH5NJHPdDUUFKkRc21MUWvYF9zKqy+vWqfNk+EkmvRUN+FzQ80CfaBlLVS4RVDSgA0QxsN1aQ3xfNSytpItPhiaB292/PyqMY1c3EyajbzCPvONZIaQYf+EnVMaqB+ijoiNBVL9pv693cFOgX9pf2frMi0WNCbB71rYemVyv9np+A+gm3URCriLFbTLu+6uj8uE8hRigByOTqxKoehY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1388fe6d-c0d4-4d0a-3448-08dce6138bb1
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2024 14:31:20.3439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DOPTd/3YBkdaJ7AZCgzKF+S6VAoudrNTv/9wN7DXBjKA/mAzMYxjO99busoZdgxV2k5vI2gpyGVTnm2FMJWkJtCRFDGP1dcMQhqsTWqkCEI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6503
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-06_11,2024-10-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 adultscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410060105
X-Proofpoint-ORIG-GUID: -5Ui-MUO9r24yUa2Z12x08gL2BhBZztk
X-Proofpoint-GUID: -5Ui-MUO9r24yUa2Z12x08gL2BhBZztk

There has been a subtle bug present in the maple tree implementation from
its inception.

This arises from how stores are performed - when a store occurs, it will
overwrite overlapping ranges and adjust the tree as necessary to
accommodate this.

A range may always ultimately span two leaf nodes. In this instance we walk
the two leaf nodes, determine which elements are not overwritten to the
left and to the right of the start and end of the ranges respectively and
then rebalance the tree to contain these entries and the newly inserted
one.

This kind of store is dubbed a 'spanning store' and is implemented by
mas_wr_spanning_store().

In order to reach this stage, mas_store_gfp() invokes mas_wr_preallocate(),
mas_wr_store_type() and mas_wr_walk() in turn to walk the tree and update
the object (mas) to traverse to the location where the write should be
performed, determining its store type.

When a spanning store is required, this function returns false stopping at
the parent node which contains the target range, and mas_wr_store_type()
marks the mas->store_type as wr_spanning_store to denote this fact.

When we go to perform the store in mas_wr_spanning_store(), we first
determine the elements AFTER the END of the range we wish to store (that
is, to the right of the entry to be inserted) - we do this by walking to
the NEXT pivot in the tree (i.e. r_mas.last + 1), starting at the node we
have just determined contains the range over which we intend to write.

We then turn our attention to the entries to the left of the entry we are
inserting, whose state is represented by l_mas, and copy these into a 'big
node', which is a special node which contains enough slots to contain two
leaf node's worth of data.

We then copy the entry we wish to store immediately after this - the copy
and the insertion of the new entry is performed by mas_store_b_node().

After this we copy the elements to the right of the end of the range which
we are inserting, if we have not exceeded the length of the node
(i.e. r_mas.offset <= r_mas.end).

Herein lies the bug - under very specific circumstances, this logic can
break and corrupt the maple tree.

Consider the following tree:

Height
  0                             Root Node
                                 /      \
                 pivot = 0xffff /        \ pivot = ULONG_MAX
                               /          \
  1                       A [-----]       ...
                             /   \
             pivot = 0x4fff /     \ pivot = 0xffff
                           /       \
  2 (LEAVES)          B [-----]  [-----] C
                                      ^--- Last pivot 0xffff.

Now imagine we wish to store an entry in the range [0x4000, 0xffff] (note
that all ranges expressed in maple tree code are inclusive):

1. mas_store_gfp() descends the tree, finds node A at <=0xffff, then
   determines that this is a spanning store across nodes B and C. The mas
   state is set such that the current node from which we traverse further
   is node A.

2. In mas_wr_spanning_store() we try to find elements to the right of pivot
   0xffff by searching for an index of 0x10000:

    - mas_wr_walk_index() invokes mas_wr_walk_descend() and
      mas_wr_node_walk() in turn.

        - mas_wr_node_walk() loops over entries in node A until EITHER it
          finds an entry whose pivot equals or exceeds 0x10000 OR it
          reaches the final entry.

        - Since no entry has a pivot equal to or exceeding 0x10000, pivot
          0xffff is selected, leading to node C.

    - mas_wr_walk_traverse() resets the mas state to traverse node C. We
      loop around and invoke mas_wr_walk_descend() and mas_wr_node_walk()
      in turn once again.

         - Again, we reach the last entry in node C, which has a pivot of
           0xffff.

3. We then copy the elements to the left of 0x4000 in node B to the big
   node via mas_store_b_node(), and insert the new [0x4000, 0xffff] entry
   too.

4. We determine whether we have any entries to copy from the right of the
   end of the range via - and with r_mas set up at the entry at pivot
   0xffff, r_mas.offset <= r_mas.end, and then we DUPLICATE the entry at
   pivot 0xffff.

5. BUG! The maple tree is corrupted with a duplicate entry.

This requires a very specific set of circumstances - we must be spanning
the last element in a leaf node, which is the last element in the parent
node.

spanning store across two leaf nodes with a range that ends at that shared
pivot.

A potential solution to this problem would simply be to reset the walk each
time we traverse r_mas, however given the rarity of this situation it seems
that would be rather inefficient.

Instead, this patch detects if the right hand node is populated, i.e. has
anything we need to copy. We can do this easily in mas_wr_walk_index() by
detecting if the pivot is either 0 (shorthand for the end of the range) or
the required index is less than or equal to the last encountered pivot.

This change is made in mas_wr_walk_index() which is only used by the
spanning store so it has minimal impact.

The work performed in commit f8d112a4e657 ("mm/mmap: avoid zeroing vma tree
in mmap_region()") seems to have made the probability of this event much
more likely, which is the point at which reports started to be submitted
concerning this bug.

The motivation for this change arose from Bert Karwatzki's report of
encountering mm instability after the release of kernel v6.12-rc1 which,
after the use of CONFIG_DEBUG_VM_MAPLE_TREE and similar configuration
options, was identified as maple tree corruption.

After Bert very generously provided his time and ability to reproduce this
event consistently, I was able to finally identify that the issue discussed
in this commit message was occurring for him.

Reported-and-tested-by: Bert Karwatzki <spasswolf@web.de>
Closes: https://lore.kernel.org/all/20241001023402.3374-1-spasswolf@web.de/
Reported-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Closes: https://lore.kernel.org/all/CABXGCsOPwuoNOqSMmAvWO2Fz4TEmPnjFj-b7iF+XFRu1h7-+Dg@mail.gmail.com/
Fixes: 54a611b60590 ("Maple Tree: add new data structure")
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 lib/maple_tree.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 20990ecba2dd..f72e1a5a4dfa 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -2196,6 +2196,8 @@ static inline void mas_node_or_none(struct ma_state *mas,

 /*
  * mas_wr_node_walk() - Find the correct offset for the index in the @mas.
+ *                      If @mas->index cannot be found within the containing
+ *                      node, we traverse to the last entry in the node.
  * @wr_mas: The maple write state
  *
  * Uses mas_slot_locked() and does not need to worry about dead nodes.
@@ -3532,6 +3534,12 @@ static bool mas_wr_walk(struct ma_wr_state *wr_mas)
 	return true;
 }

+/*
+ * Traverse the maple tree until the offset of mas->index is reached.
+ *
+ * Return: Is this node actually populated with entries possessing pivots equal
+ *         to or greater than mas->index?
+ */
 static bool mas_wr_walk_index(struct ma_wr_state *wr_mas)
 {
 	struct ma_state *mas = wr_mas->mas;
@@ -3540,8 +3548,11 @@ static bool mas_wr_walk_index(struct ma_wr_state *wr_mas)
 		mas_wr_walk_descend(wr_mas);
 		wr_mas->content = mas_slot_locked(mas, wr_mas->slots,
 						  mas->offset);
-		if (ma_is_leaf(wr_mas->type))
-			return true;
+		if (ma_is_leaf(wr_mas->type)) {
+			unsigned long pivot = wr_mas->pivots[mas->offset];
+
+			return pivot == 0 || mas->index <= pivot;
+		}
 		mas_wr_walk_traverse(wr_mas);

 	}
@@ -3701,6 +3712,7 @@ static noinline void mas_wr_spanning_store(struct ma_wr_state *wr_mas)
 	struct maple_big_node b_node;
 	struct ma_state *mas;
 	unsigned char height;
+	bool r_populated;

 	/* Left and Right side of spanning store */
 	MA_STATE(l_mas, NULL, 0, 0);
@@ -3742,7 +3754,7 @@ static noinline void mas_wr_spanning_store(struct ma_wr_state *wr_mas)
 		r_mas.last++;

 	r_mas.index = r_mas.last;
-	mas_wr_walk_index(&r_wr_mas);
+	r_populated = mas_wr_walk_index(&r_wr_mas);
 	r_mas.last = r_mas.index = mas->last;

 	/* Set up left side. */
@@ -3766,7 +3778,7 @@ static noinline void mas_wr_spanning_store(struct ma_wr_state *wr_mas)
 	/* Copy l_mas and store the value in b_node. */
 	mas_store_b_node(&l_wr_mas, &b_node, l_mas.end);
 	/* Copy r_mas into b_node. */
-	if (r_mas.offset <= r_mas.end)
+	if (r_populated && r_mas.offset <= r_mas.end)
 		mas_mab_cp(&r_mas, r_mas.offset, r_mas.end,
 			   &b_node, b_node.b_end + 1);
 	else
--
2.46.2

