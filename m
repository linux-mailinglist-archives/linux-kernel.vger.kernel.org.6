Return-Path: <linux-kernel+bounces-295456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 948ED959B20
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 14:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B9F11F243C9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 12:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20F91D12EB;
	Wed, 21 Aug 2024 11:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nYqv580X";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Esuvws+s"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A190F1D1314
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 11:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724241564; cv=fail; b=uUIqxfFak0nmPS122aGUqxC7nelk/OxPVCVsgMJV3uYC6tcEe2yHbsLiwc/01RDTzQ+uuxNODQGeY1QLidVlsYIMiCupR2U1rA1sCN/vtdyC18hLFJBOz+mgQHflOuk+sxyQII5vwGssY5PcCKxOig/p7pd5nDNMuWamAdJxeOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724241564; c=relaxed/simple;
	bh=+VgQtk0gzAR1hLH9z+/gbHFhVh19D3s8EkBAK2/BbTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ud/Wr28u8bXG/96ndeEkxSoCsv7ZQvEehP8FabJcr4/jKuVhnknweX/ATKwGxg9R6TRaJ0guJUqKGUPCIJrXyl8+T41KH+xSSSDqtujx9KjYn5/ul+THGqyggseBgxqWgKTKzMX5QxXOOeLsFcVx10TJWOCn0DSnswtT4TpCVrk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nYqv580X; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Esuvws+s; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47LBtWTs003084;
	Wed, 21 Aug 2024 11:59:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=uTnZwgSyGcjPnOm
	niWTQvMkRsSf4+iwO7IVTx73kQZk=; b=nYqv580X/JLnI4ltv3gi/PVca+fiAXZ
	rOAkyLNHROJ1iVAJnFUb1FVoswbxeUSDIrsOiFieOW4XmsPgZsZEomJRwKaXVr6u
	ZQQ5SKcUwLvnDaTgOBWKK95rrXN6evrKQY++BZXXxNmvoYVCB/Cjua45wR/7fMAc
	koTsmLuNtXentCvLpIbXX5Hc0ggnXHZcNxRFHDpfXI1xu52Qz21fwVhDdgFWdbNO
	WOjF8ctsdNmqAUj5+2Ro/TJe653+kYrEjOn3nGTs9x/juNJoOA6zjOEhvRBMGMbX
	kWsAkz3mPf9gFHvEe2j6suZvi1VH19tJBja0mFodkvW6xmSDVT0c6bw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m4uy9wv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Aug 2024 11:59:08 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47LBdq7K009521;
	Wed, 21 Aug 2024 11:59:07 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2170.outbound.protection.outlook.com [104.47.73.170])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 415fjagj4n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Aug 2024 11:59:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WVsXt3ywvc+iwjki7P6WGB2gFrQTAQmOpCjvV6QZz511asbSICgqW/zh8yyJRCg4P0Z8h19B/4oyKToNQfXZwM2F7jlNVP+8BeNQeAkMYTn1zPxwOB7xnSPjeOlGxtl3BnsqeSdNHrc0VRBaL5bEf5th7pfpoqAju6xf6wUN4c4pwfsY64hb+LDDGBjp0OUdNnZIRRPkVc3UvU5ohdUVtqcJb/tcn3RwAE0Ggw4EmtRwD8Th4LqqHENpAWu7V63hTovL0ALxveKuW5hUi3l18Iim16k21kIqE/AZuGPMOfzEF7eepCheLsDRnxUge9pyTdOvA10u8O9GaMkxK95gnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uTnZwgSyGcjPnOmniWTQvMkRsSf4+iwO7IVTx73kQZk=;
 b=iak88sqmsqEeeYu+jVbFUcpASxEWjmSN74F3BMQegVGCTsYGNps8lV96R34KWRv75P5jfGFks7OmSxUec1TFnpgciiO04m5pIBTZizcYOMqcAMUc46agJXisjuI4/NtJn51fV2quIAFfiUp7pKYKS2NEE1HOOIouqpUt/mEk0ap1APEBovSJ2UZSmWX12JHffm/Rkw9PBj1rZwCSEi1mf94FUV0YRbAMX5WtkV/0ifXordoYKLyXEsqWqnyHeKSeH+QWPDDTg2h7UJqoSeC0FlRUyOu4TbfKLDeDu2EGMrRMDfbGlpcgxQsVI67mptSHNrqHtbjyKy8Xcp2HyCpsHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uTnZwgSyGcjPnOmniWTQvMkRsSf4+iwO7IVTx73kQZk=;
 b=Esuvws+sQZuokfllwlzX9NNHf2gR74+UqyLIY9pc04x9sFF/QxedZvft++HEUDuiWy/fMVqH3vHBjwptYEwtf046qU2pIhhrpgc5Osf0AhY6A2Oop4lr6EY1EIfHe9pPcx4GXVTnlXl6qTobCL9L9TghzJxCBBd5KW4Uz9QA8hU=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by BLAPR10MB5169.namprd10.prod.outlook.com (2603:10b6:208:331::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.16; Wed, 21 Aug
 2024 11:59:04 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7897.014; Wed, 21 Aug 2024
 11:59:04 +0000
Date: Wed, 21 Aug 2024 12:59:01 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        sidhartha.kumar@oracle.com, Bert Karwatzki <spasswolf@web.de>,
        Jiri Olsa <olsajiri@gmail.com>, Kees Cook <kees@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v6 18/20] ipc/shm, mm: Drop do_vma_munmap()
Message-ID: <69dc9213-9fe0-4336-a513-23d9a9fd1943@lucifer.local>
References: <20240820235730.2852400-1-Liam.Howlett@oracle.com>
 <20240820235730.2852400-19-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240820235730.2852400-19-Liam.Howlett@oracle.com>
X-ClientProxiedBy: LO4P302CA0040.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:317::15) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|BLAPR10MB5169:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c2e72c3-e11f-4395-b096-08dcc1d8a734
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?l+wFcXvEzyZS8RiZOoAOiivyIrDAunUSM/oLINiHzMI2DHbjm6ER3hzlV3Uz?=
 =?us-ascii?Q?SQ+6AdWCF2ztuLewXyByQ0kqxDwjnS9uKkfci+haM2Dxn/A1QaaGrt8LcenF?=
 =?us-ascii?Q?908vOCadS+Vg+SzClpmem4iAgfSJqsLdl6UUm4deATuH6d5y/fXHZ/K2sMNb?=
 =?us-ascii?Q?tcMpWjwZovoQYtKY8y6AuFiSL/Vy9NHLV3I+dbyRI0hl5Non0NI+mphWNtO4?=
 =?us-ascii?Q?9mK5jBDq+b/2QKL26FlXXULcVhVB0jDWhzA7gxLsbNsyScawaZ80sSLHg4zD?=
 =?us-ascii?Q?QmnIvSKrHOURsw1FeFHhqd6XG0vH8M6eEwXVSIfbciDrw3PV+SojjnmCz544?=
 =?us-ascii?Q?4U4o7DXvsLGTcRVxD9i2t1/OoAE0RLd6A4lAR5BMeXqWQz7qel/w3h6aCijT?=
 =?us-ascii?Q?AJMOL4/Tio/N5rbOlSHc1bGJTyiKhs5wRaxs6yDH4PIr5qqDxX/Xk8Jezb8Z?=
 =?us-ascii?Q?2NNQSlehAqsbq9d2i46Ij60a8G2iPp7eqt4kbSjjv4DznNmry5b1itVFSy0G?=
 =?us-ascii?Q?SmK+Vgaz1XXFeMsNfwFr7MF6OV6QnwpBxLOIZYQLzKu+UMv1kvyNiNFkMQVx?=
 =?us-ascii?Q?asLxz7JHtBt6XlXuyC/FZELPc6xdK52kaogU2KiPOjgHlFZnw/UPzy3j3YsW?=
 =?us-ascii?Q?RtR+p85tGQQM8ocvRYa1uwbrKEtGkfdvPg9dSSeeK09pyRCk4sNfs/teOtds?=
 =?us-ascii?Q?THU0Se0qV7yEShf+KrTKGtyoEV4SiwOT40+UiqlzM6rShoHhlWflWEpggBi6?=
 =?us-ascii?Q?teGqZBj9t5wyaIDRO2Otw1+VvEc9UXykFd8jdlA+zaoy8dVm9xwXhl5ojNXH?=
 =?us-ascii?Q?nwKRC5WqYCpMyae+HKkBC5snO5W4bsQ2bZUhckuR8IippOIxPtoRb454Y5JR?=
 =?us-ascii?Q?LFtz3PIRfhRvF5U00PcxI9Hc4WfkI6hXFsKTrSiAjJ2W84vmZKIA98aWtV/6?=
 =?us-ascii?Q?7wzACY0bpIJ4yF2xqn4sAVOOVpdHB8jkw1F6Oecn1rYjwvYfOfBTtTwSYDqM?=
 =?us-ascii?Q?trRF7h1B6UZBjQie7xB7t1jD4NymaHDzLHdBQm0P2iQn53XPR8DDtTYttmu+?=
 =?us-ascii?Q?2IUYgtIlg24vCxlNEnAXImtKCZNVdjZ2wPbuNY9FG08YI+lbZXrFSRw2lNLZ?=
 =?us-ascii?Q?54q/1g+VCE/xx/X7xhjrERe16Umow65uLwvr2zv2BN5o/RixpbNRcolNOjXw?=
 =?us-ascii?Q?dbAztrdKzNomfu/zel+KXlLLrYSfkrp7xVWnuj73wju2Q1UR6GIl9RxFwJ4y?=
 =?us-ascii?Q?iGW2RllgaR56YSVpplKGt7/A4c/OqwtoUC4u1m9r21a3KksB33wODR5qIUGY?=
 =?us-ascii?Q?v1xtXw4jClni+QJWtT4nCdNebiFaJ2zWw/K7dYoCASrGwg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Y9HupnsUaqZqTVEdySKqtaAa7EwZfNXhdPXEzpPPGUCtSHy9GRVx6DKe84CK?=
 =?us-ascii?Q?U6CFMb+QHn1q1gxQ4FEfXwKt2kECOB+mJMUuddQgwsT0sWoUeRY1gDWvBm6L?=
 =?us-ascii?Q?eMfw11yRKAcQ6NPz8Bl3PdYemDZMjIFptY3tyPhEcDE9DIo3ULCuzl+Nx6Uy?=
 =?us-ascii?Q?BsYZDZ6o1s73dUKS6ENOVkHz34M8GDzyzkYXY4lr8b+a0H570Zzu8L7bSDyb?=
 =?us-ascii?Q?teQgCD5TSPS9IDw1L8KZO9s8zQG971UhsjUROMUqVbZBGyGkH/LqUpNuTXST?=
 =?us-ascii?Q?Zl8hp65XPHov+UfS2H+w2TzHHMazj5GJ5a9XEv7e9ogsaxcdUcmOZm90kgv7?=
 =?us-ascii?Q?f+HCFzv02X6fTlmyxMevnI/U9RcplVHYkLgZiAGY+iwLrZNLO0xi87eAmdmw?=
 =?us-ascii?Q?2OULUxj9VBdOKW4rZddVM7CpMxGKUzBfbO5U+azBULInEEsjAeI+SprbFKXq?=
 =?us-ascii?Q?04dKc/6NR3bk3VKdZzLqSM+D6lxKv/1peVsdEmYYgi/7I1K76OJsW0odKS9z?=
 =?us-ascii?Q?9mBOi1BGOd+IMm7CVUkFSLx2ruMxVaVSJu5rvHsWi1kIUDN8bPfNJwp4AwGu?=
 =?us-ascii?Q?n6u+QX72QBUi0ftHd6Jm0tU7zwRb2jtIV75NzIay9Ac+yuP96JPDju67PoqZ?=
 =?us-ascii?Q?W9VuySUThdDWtOjzZCGxJnbmv5vUEfTgVy1EPBeHucjvI3E4jEPjWpY3JT2o?=
 =?us-ascii?Q?mKDVcBLET5VvP80k+v399u78lmSYpSxAwKN9+NAfDM1k0kvfgexI32N3qqjb?=
 =?us-ascii?Q?jj4D/597Tyl54qKN2eLvb3309iY4jNfls2lh2lztIthO0NkQqeWCChKxdPdw?=
 =?us-ascii?Q?ADlLbB2rNYK/O7B6crdkQYqYLaEF1tz5aq7c/6Yfix/JCaq0e2Ri8apWCvH3?=
 =?us-ascii?Q?+I2sLh9zDMSO2Y+EPUxdv6WCX6qpJ3YYm8JSzjQ2EaDxDS996HAiswtBbxxj?=
 =?us-ascii?Q?nOqBa3VWwsXopMztQOJVyWHT/t+NJkFDAz4FnJydS1Yz4Al+2tU3J06SfyuG?=
 =?us-ascii?Q?WWiwUwp2dWs7AD92b4Q1c20yi1UQvkHnTuQJNvwjRNs7G12jhozSP7OlXGBP?=
 =?us-ascii?Q?x8woPFRUmAYXyjR7dOrH65zlHke8rPCPMAQZ7uqr+VyE/aEdRe98685Ys+Y/?=
 =?us-ascii?Q?qAEinU8enLQ+XfT6SeAcgilq4b2Ijk9qSF87XX+plK4+3zU/yctMiGpL+psc?=
 =?us-ascii?Q?/AImyx7yQL/PkNt58xygqxM9/Zx0p2e/yIe/HL/VSIKgCwhRpW6olBd3XHgl?=
 =?us-ascii?Q?CmR/+epJDqOiKzSKhaa8w/qFRl34Pp2doYKBPYn5Dzj/ovoOlY/0JWghGeDw?=
 =?us-ascii?Q?/B9YgZS6QJRHvVWDyh0agNHY8z8ATj/01qJl9l0W2fadawc7zD4p1pVImJ7N?=
 =?us-ascii?Q?gZS/lju/LQJVGbjioQY+Fi0HyJNr+BJhDSb3oJJgjj9LyXgQhpS7V4kkfR0P?=
 =?us-ascii?Q?2pl87cZl6qnIzlGdXNHQrJ1fBm+v2YC33Q8i1QL1TTbobgbo8ncuEbvgg5g8?=
 =?us-ascii?Q?wuaS/y2ZMugc3yP0uiphkTytLjoEnMFHgpfVMwardXPHczNMiwab4Ln2lE+5?=
 =?us-ascii?Q?P4IraEug6Cms0Ivm5C6tHTgqG+7+jEqlNLM4C1zAf4phENHYdnDC43LHA1za?=
 =?us-ascii?Q?bf/ROP7LnjQivav54lk+AfWO+O0sPohlJr1hffwFkFS9XmW8djJ2SqY8jIEb?=
 =?us-ascii?Q?s0Z3VA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cHVJ4tAEIqujEaDUDjJIpD+XOA7SZW5Vg2WoZEWdQPoB8XyZaNhaX862d0lLYE8k7GLKcF2tkcwe4L+A96iTkdzEAw4wKSZKGC3joI09J3eELPtfW3fSiuWXonNRehK6SXWDqb60fU6iZGujDuM3MvQ3gKFG6+U7nI4UJmeQfMepxKlM3K0EVmXkSurZJAVR0tE0WEj3pe/e8ALQC6OcqwgbltAzONuAIx7PA7u58uZiewmUj+FFiYQhu4LEbZAk3rwZR3AZl7Su5o8puXL+BOQF3x4z4/wR/6D3vPKYvP+FtHFHjpAeXIX1cd/xwAOdIWb1eIISfTe4Mrhrahnirbojr9O5AQG4va4CXpxbWY/dlnJ5SlksMLf6WrORmxQwCuN2GtsWZIdgIfuSG/twAIWTEL9FZ6zJ47rUrHD33Q1xkzjQlLXcQaXa+9pVC5v2ZFXiActyD1c337xCG6xwfDl2UlfOfe0twNvuWLJwKFye8oCdGlZi1SpDGfdGsByU1wkTKLqnDKhC1YW1vBQHGpiGr6bTGWpUJjob39TWgporgqnDfDXosDsPdQo8drIZ+r6CvBwnGU007gRDNuWKzC9KaRDLEhG8uhuqeJ9ZBdQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c2e72c3-e11f-4395-b096-08dcc1d8a734
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 11:59:04.3009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z+qt+tw6ghZkOaKDr/3WoY7FB6lcb4hjNjS6q3uxbxXOVkKtNmLuXm4euR28izMtdtVAaUPKL+jZ1dAmk7NZIzppbA9YSsA+UtAjKhsWgdM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5169
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-21_09,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 bulkscore=0
 adultscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408210087
X-Proofpoint-ORIG-GUID: 7hVkEvtGi2m4KIroQQOfDAU-AINNU-2k
X-Proofpoint-GUID: 7hVkEvtGi2m4KIroQQOfDAU-AINNU-2k

On Tue, Aug 20, 2024 at 07:57:27PM GMT, Liam R. Howlett wrote:
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
>
> The do_vma_munmap() wrapper existed for callers that didn't have a vma
> iterator and needed to check the vma mseal status prior to calling the
> underlying munmap().  All callers now use a vma iterator and since the
> mseal check has been moved to do_vmi_align_munmap() and the vmas are
> aligned, this function can just be called instead.
>
> do_vmi_align_munmap() can no longer be static as ipc/shm is using it and
> it is exported via the mm.h header.
>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>

1 little nit, but generally:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  include/linux/mm.h |  6 +++---
>  ipc/shm.c          |  8 ++++----
>  mm/mmap.c          | 29 ++++-------------------------
>  3 files changed, 11 insertions(+), 32 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index b1eed30fdc06..c5a83d9d1110 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3292,14 +3292,14 @@ extern unsigned long do_mmap(struct file *file, unsigned long addr,
>  extern int do_vmi_munmap(struct vma_iterator *vmi, struct mm_struct *mm,
>  			 unsigned long start, size_t len, struct list_head *uf,
>  			 bool unlock);
> +extern int do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
> +		    struct mm_struct *mm, unsigned long start,
> +		    unsigned long end, struct list_head *uf, bool unlock);

Nit, as per the standard Vlasta one about removing 'extern' from these
declarations as we go ;)

>  extern int do_munmap(struct mm_struct *, unsigned long, size_t,
>  		     struct list_head *uf);
>  extern int do_madvise(struct mm_struct *mm, unsigned long start, size_t len_in, int behavior);
>
>  #ifdef CONFIG_MMU
> -extern int do_vma_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
> -			 unsigned long start, unsigned long end,
> -			 struct list_head *uf, bool unlock);
>  extern int __mm_populate(unsigned long addr, unsigned long len,
>  			 int ignore_errors);
>  static inline void mm_populate(unsigned long addr, unsigned long len)
> diff --git a/ipc/shm.c b/ipc/shm.c
> index 3e3071252dac..99564c870084 100644
> --- a/ipc/shm.c
> +++ b/ipc/shm.c
> @@ -1778,8 +1778,8 @@ long ksys_shmdt(char __user *shmaddr)
>  			 */
>  			file = vma->vm_file;
>  			size = i_size_read(file_inode(vma->vm_file));
> -			do_vma_munmap(&vmi, vma, vma->vm_start, vma->vm_end,
> -				      NULL, false);
> +			do_vmi_align_munmap(&vmi, vma, mm, vma->vm_start,
> +					    vma->vm_end, NULL, false);
>  			/*
>  			 * We discovered the size of the shm segment, so
>  			 * break out of here and fall through to the next
> @@ -1803,8 +1803,8 @@ long ksys_shmdt(char __user *shmaddr)
>  		if ((vma->vm_ops == &shm_vm_ops) &&
>  		    ((vma->vm_start - addr)/PAGE_SIZE == vma->vm_pgoff) &&
>  		    (vma->vm_file == file)) {
> -			do_vma_munmap(&vmi, vma, vma->vm_start, vma->vm_end,
> -				      NULL, false);
> +			do_vmi_align_munmap(&vmi, vma, mm, vma->vm_start,
> +					    vma->vm_end, NULL, false);
>  		}
>
>  		vma = vma_next(&vmi);
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 2a4f1df96f94..49d9e95f42f5 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -169,11 +169,12 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
>  			goto out; /* mapping intersects with an existing non-brk vma. */
>  		/*
>  		 * mm->brk must be protected by write mmap_lock.
> -		 * do_vma_munmap() will drop the lock on success,  so update it
> -		 * before calling do_vma_munmap().
> +		 * do_vmi_align_munmap() will drop the lock on success,  so
> +		 * update it before calling do_vma_munmap().
>  		 */
>  		mm->brk = brk;
> -		if (do_vma_munmap(&vmi, brkvma, newbrk, oldbrk, &uf, true))
> +		if (do_vmi_align_munmap(&vmi, brkvma, mm, newbrk, oldbrk, &uf,
> +					/* unlock = */ true))
>  			goto out;
>
>  		goto success_unlocked;
> @@ -1742,28 +1743,6 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long, size,
>  	return ret;
>  }
>
> -/*
> - * do_vma_munmap() - Unmap a full or partial vma.
> - * @vmi: The vma iterator pointing at the vma
> - * @vma: The first vma to be munmapped
> - * @start: the start of the address to unmap
> - * @end: The end of the address to unmap
> - * @uf: The userfaultfd list_head
> - * @unlock: Drop the lock on success
> - *
> - * unmaps a VMA mapping when the vma iterator is already in position.
> - * Does not handle alignment.
> - *
> - * Return: 0 on success drops the lock of so directed, error on failure and will
> - * still hold the lock.
> - */
> -int do_vma_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
> -		unsigned long start, unsigned long end, struct list_head *uf,
> -		bool unlock)
> -{
> -	return do_vmi_align_munmap(vmi, vma, vma->vm_mm, start, end, uf, unlock);
> -}
> -
>  /*
>   * do_brk_flags() - Increase the brk vma if the flags match.
>   * @vmi: The vma iterator
> --
> 2.43.0
>

