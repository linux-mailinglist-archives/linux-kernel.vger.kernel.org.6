Return-Path: <linux-kernel+bounces-383075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D83E9B1718
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 12:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6136A2845B3
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 10:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2441D0E28;
	Sat, 26 Oct 2024 10:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="C0d7JP8f";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mg1dRwe5"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2276C1667DA
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 10:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729938867; cv=fail; b=ft168eq7QeCAbe8ncD2CmBdiXgoEDcLYWUKGjbvkPqykeBCgA0sERYqaNsXzM0QnIQFdFYpegkfdjkSPEHmpYW08qYnEId3xQTUkPCwaNwERClzlqZIhxlRAHy0yPLvf+W3vjkpm1WhSboVtPXxzLciuwkPvm++qFbaBU6VPylg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729938867; c=relaxed/simple;
	bh=4ucXe3CCsvyOI+6uwlybKZOjkBqjU6lQMyqLn+95WsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=K7CzW3W9fqvCCNq703QPoexJdXsAVPOhC0tQJ0tjyNURRUQGhoNLj/AkxudffycXj6wQ4xos/uVin7kzxjnn7zymMVHapcJ8hFOO7SYel+L3ge5ZavOd85uV+80dqvoZBASJzx57rRGMUuzORAFtZSgSmYUT3lShstay6tZ3raI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=C0d7JP8f; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mg1dRwe5; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49Q3PFSM019504;
	Sat, 26 Oct 2024 10:34:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=V+qB722RWHDZqhkO8V
	gI/G1Xq/xSmKxXKep/mafuDrg=; b=C0d7JP8fWnsWK4FwmuTj4LOaqzsWpXTRa4
	onK2qbg1exrBjgUanZkSJyj43GgDJ9uTOfXnTa22w6wjBlmmjHioazR0YgGv3wpw
	D911ShhAZXVIyP5WQcTBizQj1Ft70y9sB1LUa9xiQlV1pbRRmesWK4k8IZUe22uu
	SxBPEig9aw7RIjnRK2TGXoIt7DRQJ7LpsKVZsCkRLRYCtaVNKCucpBg9ZdZGMa4B
	0hwMOWaeeMCboqCKlMdiv9nHlJDtIPovwOaRFR1yt9+DRBp342iOHWZvSYVq9zzk
	emlu59mLN6ToxPFmeeVFhdMYPngYwp1UFo+rjexjwm1MXw6W09UA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grgm8b9m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 26 Oct 2024 10:34:14 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49Q8IjHl018995;
	Sat, 26 Oct 2024 10:34:13 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2042.outbound.protection.outlook.com [104.47.55.42])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42gpvafe27-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 26 Oct 2024 10:34:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DojJFquh+kz5xNFKoXFZ14BPeCyNnd9Uj9/DL+Se5xCB+d6GIH/iQj5poyWG+ZRJPoNxEn9/xjw5iY/E1Ngr/FNgAgdn5Mhjw/LkBJH5UBC7cDLk+f43Qfu/WoA35K86FGxXEJWvLqybMkxVEKwKFd9Xkm45LCIDUiZzutMuiGXJ7hYwSvjpYMwBtY5pxUeioQiKkcABGOyYoVbkWRXR6GPsAte3XEr8sXdv/oEnpLBLTTSs0NJ62eo4pxgCRa5rfxSYInJovTjBjkK7npSQPxiC/3lGzYElQ6DGrHIiYE+7QMhleYK9RQtdvIkZllsYCTuAEKPnEtBceVWU94wDBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V+qB722RWHDZqhkO8VgI/G1Xq/xSmKxXKep/mafuDrg=;
 b=bL6xJxFmblPBQI1RuDhlddWM/Hzd8kEuDfU+o98MT9JFp2YxGF4GwdcBxsz3N61DRNaUPHpaeW/FK5drXX64OLN+BpB1urEl2Sn3g3Mi5B2qPHU5ndga8lOnSzbwnt0carvDrAiELFZXxPq30ZJWhMAlLKSLlTbNZ/5M3vk9jUeBFs3GmVVWpiufPD8GGOwStPkO+jC4O6es6jwzA5ipIGkv/2QvrG9zlfw9h2aT9xg9GXxhov7mAi0HB5pXq/ZIvh3qGE5EtcNfiuGgAK4R6VgsamlhEFwuzdceNAUCiFlEkQG7bP7ZWSzIuxrXc00037eMHnvGFiiUAOQ8e/1rkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V+qB722RWHDZqhkO8VgI/G1Xq/xSmKxXKep/mafuDrg=;
 b=mg1dRwe5IvzsX0dykcPIhOoGIy0956Qc/7DV0bIlY5QRzJ7KQ+fPlmhUkrjRaimJEjZbggq47aQJrNJjSdMC0Jv3B+F86YTqbC3D/6ihrRoB4yWTb4H5qJrRNrSdLqeMvHiXay5TYk1kAZOWU/tKuTkhpLbkTFNcn0WbbG5lVW4=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by PH7PR10MB5745.namprd10.prod.outlook.com (2603:10b6:510:125::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Sat, 26 Oct
 2024 10:34:10 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8093.014; Sat, 26 Oct 2024
 10:34:09 +0000
Date: Sat, 26 Oct 2024 11:34:05 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH v3 5/5] mm: defer second attempt at merge on mmap()
Message-ID: <5106696d-e625-4d8a-8545-9d1430301730@lucifer.local>
References: <cover.1729858176.git.lorenzo.stoakes@oracle.com>
 <d4f84502605d7651ac114587f507395c0fc76004.1729858176.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4f84502605d7651ac114587f507395c0fc76004.1729858176.git.lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: LO4P123CA0060.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:153::11) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|PH7PR10MB5745:EE_
X-MS-Office365-Filtering-Correlation-Id: 40fd5482-1a69-4003-d711-08dcf5a9b97a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?P62MOmCmJfI4ZbCcwH804qYG7grXnQSASU7bvoIcgrR0eBkGCmRCjBe5wlej?=
 =?us-ascii?Q?Y7KFm0r/eELZ/ZT8HVWgbGdw5vY2GMiHULUz4pGtHKeE/xxTvI60nYGND0cA?=
 =?us-ascii?Q?xTgnHZ5rD3X04jgnW+Y5AEoULp2pwqZbqFJ64/Sdz2y+/48PeLkjihj1sZO3?=
 =?us-ascii?Q?7aOp+r5M9gdjKy7sevwrXvufVsZcfjHCTaNm5fK09T8IZu9Yz5/SbypQ3LD5?=
 =?us-ascii?Q?/qnWjWMjmviAGf10Zh751B0E5s0j0x8rwORLGAvoXj/NTm4w0IS7FJhFjD9l?=
 =?us-ascii?Q?WHOy7eIrVMI+zFSkYDVgrA/s2BiDgIudBI2HpOjHyyNUikV0AXzUBGUyWSaH?=
 =?us-ascii?Q?sVYNgvP/YYDPlOnEn3Wi123k9eI+RN7kb78kkhdI0G9rsLV1vuy0k9kPVSdr?=
 =?us-ascii?Q?KE33QFpMex/PMaRcE7ln+EmxWO6sokmiEWkflvRU72IhkwHqy9cb50eOEMMI?=
 =?us-ascii?Q?gOyEcuA1fErpgQasHsc+laYLNgDtBxfcgWj6JLZlypZZs7JrT34ztsZMm0I/?=
 =?us-ascii?Q?oQXhBLXKN7fdWJ00tJE6wWe3eWiP2UX2Vcb/TvmXqPmFHwhO4hz6Ugizxnq4?=
 =?us-ascii?Q?Ndngcrf2gkmb9WekxRp+491m/0ek367+F88n6d/xq5tsZ+5ii3CG3TcSTTcr?=
 =?us-ascii?Q?Fdqt/f9lMu1HViB0+oFKwAsc+DVyLgL8h3w/RBuJwZN3AKDb8Cozve0RbFYb?=
 =?us-ascii?Q?9qFLO/HX9PnIl4wrMLIDt6VE78+71bxo40u8ulXXrJMYEK2msERpwt4LHIcX?=
 =?us-ascii?Q?3AE1WWf/0hBNckLkRnDfgVlZeuoV26DJfA6l+bIXI/r3Of7jN5a/xV/3WKmG?=
 =?us-ascii?Q?AR5lHQIgn6cwSVHBzze4pXpDKI1AuEhXJZAc9fbxhIC442HGx/IxC8te88Wb?=
 =?us-ascii?Q?mOOF2733mX7o0xF24lk0Oel5aVKbYmwtpWG6Y/qoD28bUDWFn7ESIGnMjJMM?=
 =?us-ascii?Q?WF12ltKab/Ck9/y9fYuNUL0ZwKoCXsbcjg96vt7kOtCIedb6+fXOyeIXv8w4?=
 =?us-ascii?Q?LgzcDqU377SdxRC9IuVdD3BWQ3Cz+/p9DskMCivXOc9ICqPJyu23iaLSVASL?=
 =?us-ascii?Q?16IAZ3adUvPUrdnZLI79/9agI86pgGCcs0QpC2NUyb/wdul1VarSVTynvImL?=
 =?us-ascii?Q?qdAPUbKH6S4ZoqioBYY5rX7spqGujgC4PGB8q+pWhdKPmILPNDOB8Xl9MBkQ?=
 =?us-ascii?Q?CrCdzFRU+QQpTfcKV7k0LC5qwWfnu7eoX0SOD60g6h1zbdLKdpQDfRHY5hCo?=
 =?us-ascii?Q?PAg/mdbYokEDWoHckrivI4qzYiu1HuDUglVap++R4r7EeHxTg8Lyy0ZwnkLG?=
 =?us-ascii?Q?IkpFU9BCg2KpPk5G/JYljdWr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SzyTPd6fkMrSXXGRv0IW3urbSP7uNYminLDpgnX8Ef72sCiXE8yCfId2bnj0?=
 =?us-ascii?Q?cCYvlqBVZRg8cQplPHMLB948W0OuSGh3pPUIB/IaCisc1b1X1nfRLMgN3fRI?=
 =?us-ascii?Q?k9rFzUUcKKZ7q1jckOAhhTxX9umsRcZVIFYKyoNeWPbzTeBckXO2pbJc9TXC?=
 =?us-ascii?Q?sWL7TKRecaiJc520AWUKZRrFOIffTnigJksm5ccJBzOJxLiKBhL+VytzB0yf?=
 =?us-ascii?Q?RnyIaHig3ABNyy3OTxt4p8z/YIR+vpAiTkAIQ3D3pGV5FBO42SME5zyqJY+r?=
 =?us-ascii?Q?yIsooYxLy/9wY9DIeCkO6mlT27LCjSZdKiM1QgAQvXwXOvbkBt/SNtR7JnY0?=
 =?us-ascii?Q?Q/n6DCzfAQRwmY5Tk5jeLmGaGpCswkG83Vk+7Jrj1jPYgQx4rW2rC3vWYjEH?=
 =?us-ascii?Q?MoVNtoBMLrSNH5cT77poonIitPkJk7MMury5VsLKqNKsMZoSUiF19vylmJIb?=
 =?us-ascii?Q?Zl0ashWHzWFpnemTpJnosVPtP+YctlLINFhOn41WBfUtg+GmtZyw7KYtOAII?=
 =?us-ascii?Q?pUn2BQiVaFPRQXiyj/uKWZVH1Dxel6rIySoPnaQvXtN2zrQz5ciZ88V9lJag?=
 =?us-ascii?Q?MSnFFQZuJg97kU9h5LArab0uD1wVdYrf9XdV+G+kkCdLQt6mztN8f198jGm/?=
 =?us-ascii?Q?NKWyLAMcobdjtYeoy5NMOCnrEU+WfHT0q4aqyQcqXYEqUrhntBXVacRZ4RIY?=
 =?us-ascii?Q?I7NduBkCFci9ETmYnfWqP49F+1gSBX9Z97mDY+88okprMC3tfecAuQ3I1kqU?=
 =?us-ascii?Q?g8E2GU95hGRZBX3ltIqr2UwAIdVkYO23lfkSgPm/klbvZVHyGZ3g9cV97Kdj?=
 =?us-ascii?Q?acAtSjC4/a7TeQgBLqMHFMViyX1OvTWth3+rf3S7RRX0vSrvu19OaLsIIwi3?=
 =?us-ascii?Q?EQ6JuAmD/f7vReHp8hqdWGeRyK8g6h4j9GAljJnKjIFRFF/VHnZmRsFOEgmb?=
 =?us-ascii?Q?fwi/aViDZulexqcdtrN6x6o4P1G2EV3jldwF5cRlXCBF3+I1x/MET6dmP05M?=
 =?us-ascii?Q?dMbjWsDbTdKl1NEyKsxidPpvnGoDh7bn2ipTZ45Q5mt7V6gbhicevFCrtteN?=
 =?us-ascii?Q?5Xy9q/USq4WVAELaXXE6GHeLln3cInIm0OaM+9ZwkO9qVkRW03wEaEUUEZoL?=
 =?us-ascii?Q?fZvXBjHcss4GJeVoXHFAixMOwCzffrbjeRXDm8vnMSWpo91FLHDBrTQLIl5S?=
 =?us-ascii?Q?vYsv7OuVQhkjanOuyZhppv4i+a3VVjOmiqD+5vJDoRBqEu1mK/AXPL6EegWW?=
 =?us-ascii?Q?touAZ58yzGO6BRlMJB3vqKkABWRBVuMZSM7aph5MHHHMO0Sit2gjutJSDeLf?=
 =?us-ascii?Q?lrR6H8Dq3ucjFwhDSeVlIi7ZBFWglNARaf5kMl0C8eETtlFO1SWE/ZkU+J8h?=
 =?us-ascii?Q?qrbEcb7do7pjG5E3k4X2dB4wBKMdLqTkldl0b0XJB6S+bBt7nA2E99HrCUR1?=
 =?us-ascii?Q?CJ1O30iMz+Neg8WpqDIcTtMqUQrsRBE+O5/eOZobVIxa9w7VRMB59LXTKK1c?=
 =?us-ascii?Q?67aYMQVVumiIf9EP1MOtupATQgDv+gMqjahkMVgnpyLV9Gbo+uzZBUBKaAHC?=
 =?us-ascii?Q?WFM8tI+LuYHkz9iHa4OluxbsZI0T0Hl5S8kvqOIi8dl8+8JI8kjTEDXbv6Fl?=
 =?us-ascii?Q?mA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	sB2WmSxl1/HsKdmgWEFpoLMlmtN9N3en1icflfvsuHE4uYPzRyj7KLdGeHojiUpduRiq1VOOtPH7eenBBeLVhGL1l97sQfA9eOZH+ey2s9iVA8bFQeY9DtINFU51m/QabprQqP2SSMT+ENPEn+MEOJ5vPXx9I+waqSVpXcHKS4sVnfXx3GKO1h9+LRdRngxIpHGjcTBUGs6P2/wRcdpCCVKonpPpmxgF/S8hy875mOxrl6ItHWVc4FvHU4QvbfCAo2w7PbBT+1R33W+oIb5yCC/d+Ta4+hwTGyqz+TNzW/73pSy4xPs96xsqssxMwd+r7WdsgM3xsgdbh09x/5Rp0dBLVPW2ITiIkrwZUyOEHWz51hOH4ou7N2ImcGrSxn4BBO7pzLdU/M6aWrjBGgCdjrD+Ba4j5/w4hnWM8Ae126Ww4YFMjyb66XDf3iWzNmF7HLO0o8goUILD7OMld6CxN45DAFb02AmjpoIEAaXaa33d6qJiR2w+dy5FvCw10qDenSFEztGmpcTTgCIW/k7ivQ16JxXh+1yTtNZg6FZ8JEgHHFV7N+g9FG9q2GjlyP8N/Pz6xGv0ueggi3V+kKaariOznOi1qK70me18A8bPTM4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40fd5482-1a69-4003-d711-08dcf5a9b97a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2024 10:34:09.1400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z6gkhGZKM59PWgX+Y7fUO4frWRoZfCTs/MMdl7xH8EM+ThsU77vw+Yp0dKJx3yM2WqUblmjeGDdL7K3PxSd2Mh5bBJ8mNEo4aifzEkZrOWk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5745
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-25_14,2024-10-25_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 adultscore=0
 malwarescore=0 phishscore=0 mlxlogscore=674 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410260088
X-Proofpoint-GUID: tFPb33h4QgMdsb1fhJvpKLC3gP-Hzojs
X-Proofpoint-ORIG-GUID: tFPb33h4QgMdsb1fhJvpKLC3gP-Hzojs

On Fri, Oct 25, 2024 at 01:26:27PM +0100, Lorenzo Stoakes wrote:
> Rather than trying to merge again when ostensibly allocating a new VMA,
> instead defer until the VMA is added and attempt to merge the existing
> range.
>
> This way we have no complicated unwinding logic midway through the process
> of mapping the VMA.
>
> In addition this removes limitations on the VMA not being able to be the
> first in the virtual memory address space which was previously implicitly
> required.
>
> In theory, for this very same reason, we should unconditionally attempt
> merge here, however this is likely to have a performance impact so it is
> better to avoid this given the unlikely outcome of a merge.
>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Hi Andrew, as per Vlasitmil's review could you squash this fix-patch into
this commit please?  Thanks!

----8<----
From 51efd2702933919a605eb9a198adbdcf03da9c2f Mon Sep 17 00:00:00 2001
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Date: Sat, 26 Oct 2024 11:33:01 +0100
Subject: [PATCH] mm: remove unnecessary indirection

Now we removed the merge logic from __mmap_new_file_vma() we can simply
pass in the vma direct rather than a pointer to a VMA, as pointed out by
Vlastimil.
---
 mm/vma.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index f22ffb772fe1..68138e8c153e 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -2278,10 +2278,9 @@ static int __mmap_prepare(struct mmap_state *map, struct list_head *uf)


 static int __mmap_new_file_vma(struct mmap_state *map,
-			       struct vm_area_struct **vmap)
+			       struct vm_area_struct *vma)
 {
 	struct vma_iterator *vmi = map->vmi;
-	struct vm_area_struct *vma = *vmap;
 	int error;

 	vma->vm_file = get_file(map->file);
@@ -2349,7 +2348,7 @@ static int __mmap_new_vma(struct mmap_state *map, struct vm_area_struct **vmap)
 	}

 	if (map->file)
-		error = __mmap_new_file_vma(map, &vma);
+		error = __mmap_new_file_vma(map, vma);
 	else if (map->flags & VM_SHARED)
 		error = shmem_zero_setup(vma);
 	else
--
2.47.0

