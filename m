Return-Path: <linux-kernel+bounces-387327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8823D9B4F80
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 17:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C54F1F22D50
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 16:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A261DD52D;
	Tue, 29 Oct 2024 16:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EsB91KVD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AI3jDk0t"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25E51DB958
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 16:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730219828; cv=fail; b=gbhz2nqJ8MGcAahOxy/xSgIzPgvIeiTQWa3eUlWTEQ/oaZXgXXMLM5bwdmJ+5KPMy2y4iiBwA/pdEHrtA47VTaDRVsobFLvwdmtbuvhPidvGXux4364VdWloeYS0VVDB5DrZkPisPJlOgafeoNFQt2lcJXcoGG0G4U6fD9n0J2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730219828; c=relaxed/simple;
	bh=6zpSORKZtXitWRNCM4GMshoTJdkRrW1U/BUhm/IF2F8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=P1BTe26/DR1V7GsDnsXTI0g1VuCvqi/3YW9HqTF4I7bJ2pP8RmNzTCa80/OFPwDn1a5/6OR8dg5R46s6tVLhk7fXytyjzU9sJa72qfmwcAyCaB8bzrnurschMegxCsiFJ+23ljVzHNPv9UeOuYVlRwF3jql6qJ8ISY1uwgYv9ww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EsB91KVD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AI3jDk0t; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49TGaJSu027340;
	Tue, 29 Oct 2024 16:36:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=qx5JFTlNs/a/8NqVPo
	B/j1AcBHX4nFg5/ha2Cqpx4/E=; b=EsB91KVDOtgeWNe0g/nkabxrDMI7tp4UgX
	cTLZ1GdI9xeXheL8TfAPAAKX8Iqhu+mOlIxv+YLKafesq1Ooj4XnwL/IWVbjle9b
	rKaqgpNDxKmTrmsRP3jtsYXSJWabOQi6KZM/FpJRXZYMonQssufcq3/HhYDkzvXO
	xK5NZZ74ya20rxCCNwYNR7qC6YW0BjJrH8fkhM7HQLPTGPd6D0Bdjt++HfTH+F3+
	dQwZS0zrId/8jQZ25KxC77xn1gZKiXwy3Qbu2sq5iorzqfXyygIYRCdt3DWZQIM5
	JiMpLYTfdCaTd8yY9n6Ia5LgTP5oGoj+FkV2NRZ4IerCIl2WRQ7g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grgwdyk3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Oct 2024 16:36:41 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49TG6kJU011738;
	Tue, 29 Oct 2024 16:36:39 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2046.outbound.protection.outlook.com [104.47.58.46])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42hnact24a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Oct 2024 16:36:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B1ilJQrH4lxIjAyTJFBJ/B7N2BV2DLHD61I+SCnZT516qMDz5mRMYSGrwwqWjuKreYrUmQYpvr3zCsGBak7iPEz5AaW0oDV3nghTZ/JbpTYFLW5SOyUZoFUdcQ4UiEcKH+mTL7tQ40p/EQawRvdVUzwRlY61EkWQExTFM3kJpwyocqydS2lFeAycg/CUtky/EA3HYMPatM3IpVJ2/QWvtuBwiNkl1ZXzexJVbsuI8ZZ7S3fVIDOmD64diePHSA1sfuOhzHmET5PpO7Na1HFVGquO5LshHYdcqiY/Nldoyeb7UlvZ5TWfvNANs9NFnesAULfSZuRXfoPZ780403ohRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qx5JFTlNs/a/8NqVPoB/j1AcBHX4nFg5/ha2Cqpx4/E=;
 b=I0L9qkCVjDlCOzC6UI8G/k5w7XeADCrTaS35jywzja7ZEGfQZaBjEM8rnijVPY/TP3OKz5B78Qe3qn7XkP72AabyFoS+j80DAOn6jU3fYBGpMtK1aoZQdXE7iR25VQsUwl3DA0mjLvMNtAObNIasBxRl5b//iQjLnoUTP+REcgIrmEAjIzLFXGYQ9hu33NdOhAiYJRR+AtEqlPQlHbsuAI2/dw8k91RFvnBHUQ57AqHfrflptFt9a9d1qs3tw/V2uYxUnfZpz20eetextG2kQWOya4UrbqSqJt/1F75x9nEiaXpQ8G4NFLk4/fCAprIhuQ8xZB18P1ez4KaophjKxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qx5JFTlNs/a/8NqVPoB/j1AcBHX4nFg5/ha2Cqpx4/E=;
 b=AI3jDk0t7B4CoiWDF1kc77+Ab6ftodEXCBK2R3bzCBhDNXK5g6bKYjvBJB7pT5jbClhAvAiq1PIveH6alq1uG1N8bE1uCfw6hw8JojeeYKacx/cLdetL7Yosf+zeVXgl8gd1W4++Iln1vn5MAdsZ+1q/14G5CL+J16KOOJ/YNiA=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by SA3PR10MB7000.namprd10.prod.outlook.com (2603:10b6:806:316::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Tue, 29 Oct
 2024 16:36:37 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8093.027; Tue, 29 Oct 2024
 16:36:36 +0000
Date: Tue, 29 Oct 2024 16:36:32 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Vlastimil Babka <vbabka@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Mark Brown <broonie@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Peter Xu <peterx@redhat.com>,
        linux-arm-kernel@lists.infradead.org, Will Deacon <will@kernel.org>,
        Aishwarya TCV <Aishwarya.TCV@arm.com>
Subject: Re: [PATCH hotfix 6.12 v2 4/8] mm: resolve faulty mmap_region()
 error path behaviour
Message-ID: <a050599e-6d43-4759-b08c-d37c0d28ce0e@lucifer.local>
References: <ykzmur56ms7fm4midi6tbncjvcvf7ue4lp7e4orblrmwnefw3e@oa3enlpdrcrr>
 <bea02efe-a695-49e0-b15c-2270a82cadbf@lucifer.local>
 <CAHk-=whpXVBNvd0NJpw9=FGcuTuThwtfcKeM3Ug=Uk6kpChCPA@mail.gmail.com>
 <0b64edb9-491e-4dcd-8dc1-d3c8a336a49b@suse.cz>
 <CAHk-=wgE8410gu3EabjNEHhOYh1dyYwt23J62S4a9SYcwZUFhw@mail.gmail.com>
 <1608957a-d138-4401-98ef-7fbe5fb7c387@suse.cz>
 <cf1deb9b-c5c4-4e85-891d-62ecf9a04e0f@lucifer.local>
 <ZyD5iXikMzotl9mU@arm.com>
 <da15a72b-c1de-427b-a764-0ebbdd3f6a8e@lucifer.local>
 <ZyEL0s_qiyAYURR2@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyEL0s_qiyAYURR2@arm.com>
X-ClientProxiedBy: LO4P265CA0188.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:311::17) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|SA3PR10MB7000:EE_
X-MS-Office365-Filtering-Correlation-Id: 7018f8b2-480b-4e1d-0623-08dcf837db4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JivVgnlwcB5U7S43abP97gYbjJ+vquwFLlSZKgF/m0cJq0SoTv6zLBGP7MCk?=
 =?us-ascii?Q?EIxCssGmDn2W2qJ9qbnkBwF3/R6qZgmaEubpKJBQYJrjA1RT9CDPn+LCGNTB?=
 =?us-ascii?Q?5JiQIj+UOlvL6ZgzWDf7Sqi6RzTZVwh3cw8MAXHDyWYPqkfjkL2UZ//u8FW7?=
 =?us-ascii?Q?tOIZbDaKcTYQQEajBY67JCHunQCgh5iWn5N2Eyo8FslcR3fi1pICN4c1Bjlh?=
 =?us-ascii?Q?f0VipYRjR9ygY57ryfgoZWIgBQBPko+qalgCkmvxlQWSDLld2zHj6W91H5ln?=
 =?us-ascii?Q?5YNXMNOSJI19Z3H6UHLBCHQBBCr2ukQGd3R4wmgE8n0Jb6G3ZcLAzzXW/NVw?=
 =?us-ascii?Q?j3B2F0ANFApxbdnjaM5smVxM7XZaDWOxOQ7yuOdtXcL06emKPglgfREP1q2r?=
 =?us-ascii?Q?vHgbTdMFgngnPdP3RQhKw1qJ6aFS/OgSohjLGlKb3dTWDnkvsb2VfQDFfqPh?=
 =?us-ascii?Q?zb59xh7XtuVQSyc9f29quR3f5/XATc2MzChqEfFkcHsNFXJWm43cfmc/1oiQ?=
 =?us-ascii?Q?ImcxhZ4zei4FS2qclp3VGUQQLpIJAtjbuRFFxpUOO3Y7MV+5eCPAClJGIVgm?=
 =?us-ascii?Q?6Fbp2opNuWKpSwOuQKF6BRh1+Nu3KOwUHY0BXaRF/7KAb/92CYQKnUcKVxaE?=
 =?us-ascii?Q?/hp7wGzyZKWbmN2hQeMZ04ucUuHqjdT2hKomLWcM9f5zITXlQBZlypFJ3foZ?=
 =?us-ascii?Q?bSlUQ4JyDD/EqDz+iOKAfO15v9Sey8TlGC8+k9+Tu5rLdylbzYAVY6Mfzfvz?=
 =?us-ascii?Q?A1K0vcHYIcTIb/SVgxyhdYWGGkZ2JZCR85DoOiCGdSsjySyKeCmsSDNH8BR5?=
 =?us-ascii?Q?YcMOKGq34YkpvIp/9xHLhzrxziBBoNPWrU9Xmks08mSwBVrOFHYXfzHUZBWi?=
 =?us-ascii?Q?WzGBpg3AOAUfSrKWA7CoOKu/siTMq/JRS0v9w3DR+JdGTrvnvPhTnu4JP5hv?=
 =?us-ascii?Q?pKbIvtYcBKi+o5Nkw1ChTS6e4gYOija8c3glZOsXG+PdaYjB/DcioIMVbbsy?=
 =?us-ascii?Q?CIF2bG9Qbkvt0M8dZl12ouJlD4HzywdIkvPy9pwue1OSZwsWbla5pP0MCkNZ?=
 =?us-ascii?Q?jiWBRM6pr0CT6cPI/nwE5NNoylCcpqjShUZUSZGkN0YRK3wmtnapf9Pucwe3?=
 =?us-ascii?Q?kFgsU8T2Mci/SlAQr+f6bVGGs06EeU5v3roZ5yJ0UXiTj3YWA/c7j45K4K+e?=
 =?us-ascii?Q?658eXtfv/4wvuS3g+G7ayKPK30W0g4M2+UQ4SlijhmWDcKsPFPIX1e+Ctc61?=
 =?us-ascii?Q?WSbgBB38Lce6uNl/LBSgkLyWtuICfpYGdumUouBK2yIusZ+Yy9t7tuI1WqdA?=
 =?us-ascii?Q?B7+Tkuayfy20C//8J25HCh1V?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IPrXVbZqokX2L/WhybXYYqDzZVP6ytyhtZpyvktT+fgz/EvM6NIltnKmsIM8?=
 =?us-ascii?Q?s7FP4oUujnpCunNCBW4ZLlmTt+ayTmQmECVIs9mraqF0TIK6+LFKBNJEuwUK?=
 =?us-ascii?Q?bdv+QMbSpyj0U0XdSAGsbihazrNQw9LYEsAb7h+CPQjacHiuM5PtZug2JcmF?=
 =?us-ascii?Q?L2jSsJ2IXbS3kExCsmodFYCEC6e9svwtSBAmoag9pbe2BUCANBG6GikKcHFD?=
 =?us-ascii?Q?FfUd24uhN6YfCYQHHAUPh9Mq3c9pOYDK53m9H3SYoaaUJIXRsOp092tXQf0k?=
 =?us-ascii?Q?ktZT7ird9NV5+JyOWwRz/W6eZFp0l5S75VeIrYBoQZbfbc+4q0adkURmkiOz?=
 =?us-ascii?Q?cIHEjxKqB4JIfpyguvVjIJWG1aLVHcPjauqGdvGIK/h0+MLbPCgCgCADvv7A?=
 =?us-ascii?Q?ZCNmnFoCHCQYgRETzhDjEGAnBmena5eF6VibBsAFpEKZX+OrLyioaPClW2sY?=
 =?us-ascii?Q?tVRXAOIniL0VWUPyo/mfcb/ZtM8wM91U7Ms9jg8u2sxkdc7dI8TSqGiipCJs?=
 =?us-ascii?Q?okk/T4diAxudm6F5N2QI0554R/q2cMqz71G9i5Fj52GRZkOscPLZUlP2OkhX?=
 =?us-ascii?Q?gm0E1uA9MrV25JnSIvUP+MT+quiGIxxeb/FTnALWnxKZ5fTiYiyQUMWI6jek?=
 =?us-ascii?Q?94a8fAwsNILjq96GffapTr/lJOwUYH213Rh6NtsOpxApwztavkTiqA9WNuUP?=
 =?us-ascii?Q?O11Y2IoamQKkj9CEJ9w1aN9zkj1W8zCOpW+XzY2XROSoYKUbgvr4w5chTrwM?=
 =?us-ascii?Q?bs3sA66kZm1jlCrzJpEGrgVL3r1/9mzTpm/utEH8LpyQ6D93fdGLX5WAu5+X?=
 =?us-ascii?Q?0feH8ghX9pvqf4jP3xsz1cBkdI5QOICsgciCyWbmpLi1IUAEKezex/7QzNkt?=
 =?us-ascii?Q?yM53VtdOKOaG2NXpM7CIkEqTV8MTle6Y1rUXiPkDxztmuON4PqkfQRUw+4Qw?=
 =?us-ascii?Q?LEt0eODlUuNbu3XwLKyfLgmixjz39KcBHZAScWsvRsHyxGlZ83JOQ76VQVe6?=
 =?us-ascii?Q?KNtTXxSoB4SHaHZQtOxiOrvzx4nwbsXLbK4RVZYp29Jq1+0B3Fm+13qgplSb?=
 =?us-ascii?Q?T47eB7g16ZsX4IyEoJzP+PYJ07C8dmzh1vxkxM6/kU8583mc/VqMTchw7XN3?=
 =?us-ascii?Q?X6+/uQUuRvtwW8SNCpUoLvlMhWzj0gZHS3C9w6UC9eq2oMZsThgl+JA+O6GD?=
 =?us-ascii?Q?a9C80FPkob+gxkUHFf6fg7w7XHzX0Vx9oKqzyHVXrwcCgVwOwUUjKCoUGiQa?=
 =?us-ascii?Q?bE3eZcu8ztqKbNLF4H21/PvQ05TH9OzImezvvByZP3qascriJ/vzvdDowPRq?=
 =?us-ascii?Q?9FEjXGVuiEyEamIAOBaIki0zYlAtPsidqGD8cTqOs3nUOYfRg2jlNi+5wiP1?=
 =?us-ascii?Q?uI5xLToKMEt+RtLMWVpjDoBTj/gteDwCvOMKLm5ciOWeBgJcdSyGjFQnFeUg?=
 =?us-ascii?Q?fDiQzbOOAE2KOHXsFRu0UUhrTNw0xQQoGduGK15xGMlCyuFD6VXjUFZ2bgC1?=
 =?us-ascii?Q?ebgSZgL/sWP/9O5I7HxqFXJ6FHZA+z8oEWzUW2bJVVKB6RBPQFBhBu85C2HH?=
 =?us-ascii?Q?0M4wcCqOrMXRjnDNJEXBub0Tc0t+idgZahKgFHEPkXkWzwbx4ZufY6+H9rln?=
 =?us-ascii?Q?zg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	doDnAjjPnH4b74oV36k72V3wZABwcp6jW2T+/tNPTN4r6m8sRQCp17K/qvcCOlz9f/QJGzEz+ucQFu9lFZDC2csitWXSYXN2EHxHG/eQfsCT6uuAZaSN6ABxq9KssYx2yNucqn50YAV50L/SQHhLy0X1DCDfpBO2Gm2P3/KprNDiPNlZHyeTzioCXILt2EAuP7TWnomDW1EiyEzdv7C/TSfmO+2mCTxLDhLzaRYasc5voVF+RnM9G4ts2nmm9VmkXANac9UjTG1V8Z/tXEAbz/oqlbIS+Czk4F0FRLaz0wSRubU06XPCKhvIK7yCjkkdc+gVafhXusfLET4ZmTQO22w+xJO5I3Fy6edP7hU5p5HPJAGFfiEhqmI34DjfRQaeiSsn2F+Xo/kgXCEYhr6w6Gbp5E+g0EVW8v7vCR5GxYssacjWyNUdsRmVp3UKP9TKB6HPEZriHRUEkR/isu924+tT/GFQ+MEBPuYZ1hWRlFDYn4FHyx4DkDO4Y6wF94Wf3GpawIf6wj15iDhO7987IXzl2i83mZNgkdWIzmKaJ5amm6PvhBnS1X0hIZrWZDYxrDpU8ISsIyRuxa9jOr+gatfpMS6W0XgadT3BCuVEiKQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7018f8b2-480b-4e1d-0623-08dcf837db4a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 16:36:36.8214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s/RKuTMOqqRukljXbsOgvWZlm0DdHU4MV+TJYF1X58vYQmtwR1BV0EcEFyTfX8B9oDcDj/jEzOn2t17wMO09JvfiTcKAi4TDAa8S2krEOz4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB7000
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-29_12,2024-10-29_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 bulkscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410290127
X-Proofpoint-ORIG-GUID: iBpQkzCO9VcD5GzgSknkcC1nNTinArjL
X-Proofpoint-GUID: iBpQkzCO9VcD5GzgSknkcC1nNTinArjL

On Tue, Oct 29, 2024 at 04:22:42PM +0000, Catalin Marinas wrote:
> On Tue, Oct 29, 2024 at 03:16:00PM +0000, Lorenzo Stoakes wrote:
> > On Tue, Oct 29, 2024 at 03:04:41PM +0000, Catalin Marinas wrote:
> > > On Mon, Oct 28, 2024 at 10:14:50PM +0000, Lorenzo Stoakes wrote:
> > > > So continue to check VM_MTE_ALLOWED which arch_calc_vm_flag_bits() sets if
> > > > MAP_ANON.
> > > [...]
> > > > diff --git a/mm/shmem.c b/mm/shmem.c
> > > > index 4ba1d00fabda..e87f5d6799a7 100644
> > > > --- a/mm/shmem.c
> > > > +++ b/mm/shmem.c
> > > > @@ -2733,9 +2733,6 @@ static int shmem_mmap(struct file *file, struct vm_area_struct *vma)
> > > >  	if (ret)
> > > >  		return ret;
> > > >
> > > > -	/* arm64 - allow memory tagging on RAM-based files */
> > > > -	vm_flags_set(vma, VM_MTE_ALLOWED);
> > >
> > > This breaks arm64 KVM if the VMM uses shared mappings for the memory
> > > slots (which is possible). We have kvm_vma_mte_allowed() that checks for
> > > the VM_MTE_ALLOWED flag as the VMM may not use PROT_MTE/VM_MTE directly.
> >
> > Ugh yup missed that thanks.
> >
> > > I need to read this thread properly but why not pass the file argument
> > > to arch_calc_vm_flag_bits() and set VM_MTE_ALLOWED in there?
> >
> > Can't really do that as it is entangled in a bunch of other stuff,
> > e.g. calc_vm_prot_bits() would have to pass file and that's used in a bunch
> > of places including arch code and... etc. etc.
>
> Not calc_vm_prot_bits() but calc_vm_flag_bits().
> arch_calc_vm_flag_bits() is only implemented by two architectures -
> arm64 and parisc and calc_vm_flag_bits() is only called from do_mmap().
>
> Basically we want to set VM_MTE_ALLOWED early during the mmap() call
> and, at the time, my thinking was to do it in calc_vm_flag_bits(). The
> calc_vm_prot_bits() OTOH is also called on the mprotect() path and is
> responsible for translating PROT_MTE into a VM_MTE flag without any
> checks. arch_validate_flags() would check if VM_MTE comes together with
> VM_MTE_ALLOWED. But, as in the KVM case, that's not the only function
> checking VM_MTE_ALLOWED.
>
> Since calc_vm_flag_bits() did not take a file argument, the lazy
> approach was to add the flag explicitly for shmem (and hugetlbfs in
> -next). But I think it would be easier to just add the file argument to
> calc_vm_flag_bits() and do the check in the arch code to return
> VM_MTE_ALLOWED. AFAICT, this is called before mmap_region() and
> arch_validate_flags() (unless I missed something in the recent
> reworking).

I mean I totally get why you're suggesting it - it's the right _place_ but...

It would require changes to a ton of code which is no good for a backport
and we don't _need_ to do it.

I'd rather do the smallest delta at this point, as I am not a huge fan of
sticking it in here (I mean your point is wholly valid - it's at a better
place to do so and we can change flags here, it's just - it's not where you
expect to do this obviously).

I mean for instance in arch/x86/kernel/cpu/sgx/encl.c (a file I'd _really_
like us not to touch here by the way) we'd have to what pass NULL?

I mean passing file to arch_validate_flags() is icky, but it makes some
sense since we _always_ have that available and meaningful at the point of
invocation, if we added it to arch_calc_vm_flag_bits() now there are places
where it's not available.

And then we're assuming we can just pass NULL... and it becomes a confusing
mess really I think.

I also worry we might somehow break something somewhere this way, we're
already exposed to subtle issues here.

Alternatively, we can change my series by 2 lines (as I've already asked
Andrew to do), everything still works, the fix applies, the VM_MTE_ALLOWED
flag works still in an obvious way (it behaves exactly as it did before)
and all is well with the world and we can frolick in the fields freely and
joyously :)

>
> > I suggest instead we instead don't drop the yucky shmem thing, which will
> > set VM_MTE_ALLOWED for shmem, with arch_calc_vm_flag_bits() still setting
> > it for MAP_ANON, but the other changes will mean the arch_validate_flags()
> > will be fixed too.
> >
> > So this just means not dropping the mm/shmem.c bit basically and everything
> > should 'just work'?
>
> If we can't get the calc_vm_flag_bits() approach to work, I'm fine with
> this as a fix and we'll look to do it properly from 6.13.

I think overwhelmingly since I'm going to be backporting this and as a
hotfix it's better to just leave the shmem stuff in and leave the rest the
same.

I really would like us to figure out a better way overall from >=6.13
though and replace all this with something saner :>)

Am happy to help and collaborate on that!

>
> --
> Catalin

Cheers, and sorry to fiddle with arm64 stuff here, sadly happens to just be
where this issue becomes a thing with this hotfix!

