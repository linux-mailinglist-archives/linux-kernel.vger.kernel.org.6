Return-Path: <linux-kernel+bounces-437151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 647ED9E8FAF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 11:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1292164CFB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 10:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420EF2165FE;
	Mon,  9 Dec 2024 10:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oZmzxy9U";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lm2w4XNe"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F9B14658C
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 10:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733738821; cv=fail; b=XbSMk0P56nX3+Veqg3mFt+6ubXm7Ct01LHd3iwHlC0FiXzTTFFOhuCkupi5O3Tp1ajzNYnK3w/WnTN56CiHk6f40Yk29593AgrKYHi1Dt5vaLAhPoLhXh/LwJSVvvqaETiOi4UigC+kLM1T57rsdqlrT666ret3fjLjkAFac4Ko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733738821; c=relaxed/simple;
	bh=ulqFwWZjlwqvR8FId60KPTt9YSBQfsUuz3LJ3y1xmFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qT3s+izaxuK6DxuyGJ0sVEOYnfR6Menyt2VnpDPdouPt//zo23vmrV96i6wn6wyVayJYp3bV5cBsH9NhgT8jXWTtshMyKBX6cclHH75/V4Cn4ZO/8SmrrDnpxADdNBDbzWGTKzE8Nzc3s2kdUkB0ntzUvdwJjA18IFZ7JrQCrWw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oZmzxy9U; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lm2w4XNe; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B98ftMl030470;
	Mon, 9 Dec 2024 10:06:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=FyAkavhOTmVAIx+3dK
	CnxCpxP7uS/xgnkJeCq4WHP54=; b=oZmzxy9Ub65ePHU8ZtFXirmUsGbNUf84/G
	xCHuAp8i6aTlTiYZuVDhwdPzUujqCmNlbR7UE7SDMhyB9Qa/2UL459cNkDreV6pk
	SZhQtAMnG/IeyrDxiVpKC5Gb+t1lAMT+isrT2P/E3lglR5+v0KgiqpjZTzNBn/Au
	s1QEb517t7gIKEzchqehnbFTl7TUb8MTdt9sumHrL8kkcUDsgzHvb0ntcoopW+Dj
	+/bDd+gK/7+AwJyTvE9pG3GnD9+ysRcxrTALMv8jCYqAp9vXrukTAr8h5R+X+v3R
	S+3uXPd1JFeMs2WVRqCuKsPyGotSztvKCFWEfU/tmYgAnEHXuZmQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43cewt2u62-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Dec 2024 10:06:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B97rYR6008666;
	Mon, 9 Dec 2024 10:06:46 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2043.outbound.protection.outlook.com [104.47.55.43])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43cct6u3a0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Dec 2024 10:06:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vnAFVZnwl3MHJFdWfGnZxvcB7dDgRYQmgJhjSGdblPbZU1l2+KomOXLQHQ0qJWAzjFJ/xpELg/uCTfYHxkUK9gfk1ECeXTmgjFSdvhKxae+uPT2Y0mUQY4Bi1Cs2FA92h3DKYL/TqTviGNMo5w4uPphHdlCREy6E76cYi0acp1RoJ1MwTRoF4ipZJ2K8Bi+NerKrzf8KhmOLkZ+Vpq4+iI364Ql01HsJKlxTUj3MWKNPx+5efEIksGoTBPNBp92gg0hDVKqhFdxcV44HKCzNl1E7NPyGGb6ooX5kM69n4N32X03TJzFr+loaCtkmN4hBUjnZ/Zoy/GV5CWGQ6x8Kiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FyAkavhOTmVAIx+3dKCnxCpxP7uS/xgnkJeCq4WHP54=;
 b=dRJq5TLoBFPipoiuXJQz3YwOo8IYpvWwWIKvkndtAQ0yLyTkm5GxJzoYkRrsNjpJRBt2JyocWteEPCMFqn1sqjEnM5tzz7kfWwesKoIMd/NBRbG/CXqbqBn6tEagBhCMmdRVwqfYdo0ra0fSDBWIrQY4rIBGLsdfrs7IjQVAa/9NvANtXxo360D3Drl2YG5nKTUAsIwNcr0SPQDtoRm+Kv1iu8Q5Wsop7sShfbUllNYbWQ88X+bz3PxzBESet51oXR0luRSgSXMvuGQSxfOaNEO+0r/1ZnKfMdJ+UcUFjexclvP5wLjWQmXGNh1b8GSuNLEuXwfXicaEwXswIiBe6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FyAkavhOTmVAIx+3dKCnxCpxP7uS/xgnkJeCq4WHP54=;
 b=lm2w4XNeR9V0rI2djBqxXq8q/eZERJ16tGaSl8JokXVBfx3xRUQTjvVBNunEXvzp+z2V5W56XgXezMIExWI4bzjxhnXlPSOk4JMvHOgCfBB9ZNKumEpiTQLVhR1CxyP5CqAYrs8XuUsioWcl+lIqtKvKSld1P1emrWY13rj66sM=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by CY8PR10MB6874.namprd10.prod.outlook.com (2603:10b6:930:85::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Mon, 9 Dec
 2024 10:06:44 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8230.010; Mon, 9 Dec 2024
 10:06:43 +0000
Date: Mon, 9 Dec 2024 10:06:35 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: group all VMA-related files into the VMA
 section
Message-ID: <d9df6f73-9e6c-4f8b-b2c0-5534725d1b18@lucifer.local>
References: <20241206191600.45119-1-lorenzo.stoakes@oracle.com>
 <23d3d7f6-d6d1-430e-8ea0-ccae76b253fd@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23d3d7f6-d6d1-430e-8ea0-ccae76b253fd@redhat.com>
X-ClientProxiedBy: LO4P302CA0031.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:317::18) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|CY8PR10MB6874:EE_
X-MS-Office365-Filtering-Correlation-Id: 9307da11-dc28-44ff-78a0-08dd18392e99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1u8b3wQTWRGcVcecAdtvklq89DkXWWAiNCr/MBN0GDQmgNxrykxlcR0Znzz7?=
 =?us-ascii?Q?SjPkQiMBgCc9//pHcM2pElqllQegnWS2VrzcJRe+EwaEa+PmZgAqkRp+LMiC?=
 =?us-ascii?Q?CN0Ok05c88us1uGmf6OHKLadaP/JlyCRjp4sI+PmMu+uh81avJ6hbjwN5iTg?=
 =?us-ascii?Q?P8u9kQokEHJsylCIQlZW3nTjuG4V4m4IkQzHJJC19SrHF71VXb9z3W9rjm3X?=
 =?us-ascii?Q?jGWY4WyEdFStxHm7U+QTiDflt9VTXlh7c822L2L+tZ7wjRjU+6P8kfLL0lDB?=
 =?us-ascii?Q?Df4daRC050pE+kkvkGCWtXpvU+wUiA1UWxGkXBSG2/ATukWV0BVB9X+vyfrJ?=
 =?us-ascii?Q?jdvmh2WT4vnMN/bOWLv6+MSUupZpCnGmtREbdVAtiR92DRNJ4MzLgNo5en9k?=
 =?us-ascii?Q?+itgq8nbxkCL0jJxdj0rT9D7cSYE9B5w2pXBwYPAHscW1ugWEEmNkU50dVzp?=
 =?us-ascii?Q?kGJr0hTs0dpkkiVsP6tfULmLVg98qA1fpki/NkBl9a2AQ2VfhYqnlF9fEGLN?=
 =?us-ascii?Q?vx5WgibMIFEOhZrrD20GlovzZAQ9opMLKcoTphkESR4KvOpensgPhpabI2Qv?=
 =?us-ascii?Q?ElPsxFvBktMgXwmGa95hn3YwLgXDc1Ms7DlBrLKEQAUSE22Mw52nAHxx8NLm?=
 =?us-ascii?Q?Xu7t9ZfaIzMcjB7+J2I+/8bxJeGgUmkp7UKbx+oZnFhcSJCIx3u0nlSJfvGz?=
 =?us-ascii?Q?N42XKxaEMo6sJo5untUywOXaj9MURQ3aFc1yWpKaoDbMXfpMg/DeSJv14I+I?=
 =?us-ascii?Q?7vK6qUzYAfVJmh/KC3xxfLdk0I8YHv3KEcxAasD5W/XOAVPwj8shILrmbnYG?=
 =?us-ascii?Q?uGc+05yDPMSkyJdr193R0LFOFXdS4uu8imINhgq4UZbFBepqTKW7qWtdkFxY?=
 =?us-ascii?Q?Xj1HZTU8KzBCIODJqSdboDOBovUXN4AbepmUm3z+ppLlkYQZSqmCUgDK3OTh?=
 =?us-ascii?Q?JNm2sjBXBNmS6HMxk7AnurMPLDWcsSxajLfmqZF5+pZnQTyOzxY0D18OUtqH?=
 =?us-ascii?Q?IF1zX9rSCtfRUEYaa0qd6PqxKK/s1GmQGozlhAjLBp67gXy2ni/h4RhL0B6U?=
 =?us-ascii?Q?LIEivlVtKBizlaMuFU/it8ktQCShziRS8iDIwLS5CqwZUcnh9VnLuspd6IHn?=
 =?us-ascii?Q?gqQk/lh5GxQZ1ZOAskWkc7eyTzCWqVgk2/o62DrV3J4K401+VSktKO4abcje?=
 =?us-ascii?Q?X7LVJJ+gw6H/jbvRcB+mfWeJ8eMPVJMcYsN8sz14hJMVM/DatWVzqCiDF9q/?=
 =?us-ascii?Q?kTGhbeHWHeATabjHgPe+OXh17vRp3b4BIK7VEJUstSFAvKfkViqyCyiHSjsI?=
 =?us-ascii?Q?kAo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zT2RAseryRxNF5qVG+HK3GhgIrdWzHrKaeNmkRctcnY4Hc8yLJgp3itvRz48?=
 =?us-ascii?Q?QbBa6EsKJGhvZ3Y5gkUojB7wv5QK/prYNE772oqI6vfDM1An90edQPvxE61H?=
 =?us-ascii?Q?dV8STdsY8w7xxXCdlbAM64iQGYLiVjWT4pT9zl7Erw+L1GAI4aIEjo0/XN49?=
 =?us-ascii?Q?xaggYuA2nbiCZcpyydUl28JDHiXsEpykTTavdKDLljDcyrtwLxSbYvOaLUq9?=
 =?us-ascii?Q?moH36aEL/ZJ0R1DuFP+nsFwbvNlNcilC3knclU92XSluPEFxrA1ogUhoXAjG?=
 =?us-ascii?Q?CrxSOWEP4cCW5c0wEmGIzj5jgJsFe79kAsOmMD4eEBpyu9a5jlm3al3OU/cz?=
 =?us-ascii?Q?VmT7hq0ixr83VGZtm/9/TNG82QoG0lnoS/gN/ppGe1q9zArhULt7qoqZFdn4?=
 =?us-ascii?Q?/i4nK/D+zW23ucRpvv4BkdhFU9gksNIm+Jlqfx5CF0pr99JFZsjH1MktrCkG?=
 =?us-ascii?Q?kWOADcTVdtnzjx5MBTUmk6nEsmpYfMPMrninkPgIEUnZ/MCWbDtPdhSS8iFP?=
 =?us-ascii?Q?ERqOTZicN1wQ6/t829JiZ+tZnfv64YVvbtYlOVFUKQYQupg6GYoLdgfSTdj1?=
 =?us-ascii?Q?BCRtZWg90OoNxFvK7yIqkA4M2Ar5HKgIIbJc+xJ/b3/qHX/KBT12PzXHn4Hv?=
 =?us-ascii?Q?qBBxK3IR3mm5Au2rHSdLWJcFEw6PXrHzFOG5Dsa5opKV/2LM7A5xGDEmkTu3?=
 =?us-ascii?Q?LHpJj4W4K+abPEgNmZl//0zkxyY1h85urT57VlhcyVe0JMqoTXGOXBWGdG4/?=
 =?us-ascii?Q?Uf/fMeCUo2VOiuOZ0NqNhjMccsyJXfktoAg31sqpkURPOzQWOIIjIgtARRac?=
 =?us-ascii?Q?5xTXBP/07to9rzvopWWrlTarS5/jP5M6WXmG42jQPXOKNzkfd3KfFo+QOTTQ?=
 =?us-ascii?Q?oABC7SB35CbOHF2q5lXBki6etCUcoRXF7KQ9kHiliJfX3SM1nVCugtmBwUkw?=
 =?us-ascii?Q?4CVAXiC/jRsRz7LND4R/A9UVUeKSlBGsjmPVumPtfDQPjckJ6Pm2LRVgwNp/?=
 =?us-ascii?Q?bJbbl4wcBGhFuHnkqwFHGARHVKXJXXBaZqikQKwOxkf1lebjQbkdO36J/Yux?=
 =?us-ascii?Q?HVxQ7VO26s6WLiKisuSIStdSwkRfActbjgpnWdXTeEGZa9pAU13fHVmY/gpO?=
 =?us-ascii?Q?FBdoJYwAzRHpjTbDUD8KkUo92+eFRR7yFCBl8RJgMr29mWUvWU97LcYFu1jC?=
 =?us-ascii?Q?y+qI4GotlVJ8SKdKWeJFOSyiVBmpXk4AhOq1A8El5+gsnomRFq9CEs9lfzVp?=
 =?us-ascii?Q?fKyide30Rd5NPheZ+FYKQkuU+o0/hONLBVNN8yjiAnX1HsNnqmyzvy7eizZX?=
 =?us-ascii?Q?wLaxQJMMLnMHQwYuia5bXnbwCB/iVLd0AuBB/4l5H7InxJyHxnB/oKir9FnF?=
 =?us-ascii?Q?O6wkxVXIVFNF6OIuuRwUymCcPFMRbSmIXGraDXSNOV7iZGO7GCUkuxFyRg5s?=
 =?us-ascii?Q?M29pl8NLTioiOV0O0Uu1vo5tgU0BaCOidvn1auaW4PA3Yq82ASazClz8M65N?=
 =?us-ascii?Q?ABinkRFpyfE0hwPNXp83wOr0p7eMK69CfdZFbvYa6+Z7SoipzQiC1QB140o8?=
 =?us-ascii?Q?/MekNnojImaObBv2mStmjYMaCJIo2aZI/o5j65ER3W0cuDmgUnhGQr0CJfk2?=
 =?us-ascii?Q?CA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	CirlW+4sFKqKzmOWJ+ebLNzr1fNyu3oyQJ8UCADf6SgGaZEy+jidAwv58ytE2AkLZVEsz6xBngVvgfOK2+EfIq5g4vzE+QjSemWHRI1ZLP70wNeVG5Z4wqJILWRZzvoAlOdGhxkwCtjMWSWyYG4KXTcZK5IXQTNHbmWerDNly3tg9jYqVzn6Hq1Vjiexb7892fI0/f72xNjka5xXFlBzX3DD6lOE1ceYg3wGI/mghv883+SRoKBY2U1z9Uq0VpyfcIWl7OvEuUn6A+2kNUbXMyWAa05WY2kXabShre/j8XQJWOqWwRIbny83V8R14UWYAYFIfs3G2OrORQSZVcKMeiDxLw9jFVq37qAu7TQncEbOh6WN3h5Htq1f0Hw4JvY4+rfGiVJlWXFunrgRbqU4tYqcxZ+O8qt3RHacJlSF09wSBg1CjdFA0YC3x0o4mPe1QAVn+UYx3IdLrGGBpTI3NPOthstmceoU6n83hoT04nHtd8ttFTJTXNzWKZ3Rs0+q1O1jMPReGs6U/8vAVJ+Ho2VMh+zioS9LeCQP9gOJm73v2+2uGIdwK+QqimSp8lEMaEN5e9/YyUlUkho9oL4PDL4KtDKGGmV9NWlDPrM1ky4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9307da11-dc28-44ff-78a0-08dd18392e99
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 10:06:43.3106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CKxoekUndFQbgE8UCcsR4CXDA5IFR0GH1lzB9gG+DBISah5WBiUgBrC9mjIravejs6FPoLDIsGMmSvNaDka6OOhhysJN8m8CGZDnN8cw0AU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6874
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-09_06,2024-12-09_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412090078
X-Proofpoint-ORIG-GUID: NJJRUVfALYVXP3Fuedhevn2ji6GutC8X
X-Proofpoint-GUID: NJJRUVfALYVXP3Fuedhevn2ji6GutC8X

On Mon, Dec 09, 2024 at 10:16:21AM +0100, David Hildenbrand wrote:
> On 06.12.24 20:16, Lorenzo Stoakes wrote:
> > There are a number of means of interacting with VMA operations within mm,
> > and we have on occasion not been made aware of impactful changes due to
> > these sitting in different files, most recently in [0].
> >
> > Correct this by bringing all VMA operations under the same section in
> > MAINTAINERS. Additionally take the opportunity to combine MEMORY MAPPING
> > with VMA as there needn't be two entries as they amount to the same thing.
> >
> > [0]:https://lore.kernel.org/linux-mm/CAG48ez0siYGB8GP5+Szgj2ovBZAkL6Zi4n6GUAjzzjFV9LTkRQ@mail.gmail.com/
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > ---
> >   MAINTAINERS | 19 +++++++------------
> >   1 file changed, 7 insertions(+), 12 deletions(-)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 1e930c7a58b1..95db20c26f5f 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -15060,18 +15060,6 @@ F:	tools/mm/
> >   F:	tools/testing/selftests/mm/
> >   N:	include/linux/page[-_]*
> >
> > -MEMORY MAPPING
> > -M:	Andrew Morton <akpm@linux-foundation.org>
> > -M:	Liam R. Howlett <Liam.Howlett@oracle.com>
> > -M:	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > -R:	Vlastimil Babka <vbabka@suse.cz>
> > -R:	Jann Horn <jannh@google.com>
> > -L:	linux-mm@kvack.org
> > -S:	Maintained
> > -W:	http://www.linux-mm.org
> > -T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> > -F:	mm/mmap.c
> > -
> >   MEMORY TECHNOLOGY DEVICES (MTD)
> >   M:	Miquel Raynal <miquel.raynal@bootlin.com>
> >   M:	Richard Weinberger <richard@nod.at>
> > @@ -25028,6 +25016,13 @@ L:	linux-mm@kvack.org
> >   S:	Maintained
> >   W:	https://www.linux-mm.org
> >   T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> > +F:	mm/madvise.c
> > +F:	mm/mlock.c
> > +F:	mm/mmap.c
> > +F:	mm/mprotect.c
> > +F:	mm/mremap.c
> > +F:	mm/mseal.c
> > +F:	mm/msync.c
>
> Not sure about mprotect.c, mlock.c and madvise.c, though. I'd claim that the
> real "magic" they perform is in page table handling and not primarily VMA
> handling (yes, both do VMA changes, but they are the "easy" part ;) ).

And large parts of the VMA logic interface with page tables, see - the entire
6.12 cycle - around recent changes in mmap() MAP_FIXED - which... the VMA
maintainers fixed :)

And then there were the issues around VMA and mm locking relating to page
table work which... oh right yeah we had to fix again... :>)

I mean you can make this argument about probably all of these files (mremap
has -tons- of page table-specific stuff), and then we get back to not being
notified about key changes that interface with memory mapping/VMA which we
end up having to deal with anyway.

A lot of the reason we have 'magic' in these files anyway is because we
don't have a decent generic page table handler. Not sure I'd actually use
the word 'magic' for that though.

I am planning to make significant changes to mprotect/mlock soon, which
have some terribly duplicated horrible handling logic, and both are key
considerations in VMA logic as a whole.

Anyway, as far as I'm concerned page table manipulation after the point of
faulting is completely within the purvue of VMA manipulation and a side
product of it.

However, can concede mm/madvise.c if you feel strongly about that as that's
a bit blurry, but of course contains a whole bunch of VMA and... page table
manipulation :) I mean it still to me seems very pertinent.

>
> They have much more in common with memory.c, which I wouldn't want to see in
> here either. Hm.

No, memory.c is really dedicated to fault handling. This is really
different from manipulating page tables in specific cases in my opinion.

>
> --
> Cheers,
>
> David / dhildenb
>

In case you are concerned about how much code this actually spans, it's
~6ksloc out of ~127ksloc, with roughly half of that in mm/vma.c...

