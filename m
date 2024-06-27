Return-Path: <linux-kernel+bounces-232378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF7D91A7EA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 15:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06520282D2B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 13:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C30193072;
	Thu, 27 Jun 2024 13:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AxOEu0FC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vgQb8hh0"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C86113E41F
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 13:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719495105; cv=fail; b=UaJmL9VtqbWqMODkIE9d4R8WKwqiVcWI3MjeJis17eEWJFktYuGzb/ob4mwhgpeJAL8sCJvvSI9dee/fAmJ3kxE2UxZybJxFyQ/1bR+IkUE24/MdbAFai+peLWS4yJyF3jbO9eR/HI/LzNtpd/z3A0K/oRBphG/Gk41z4tY4AGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719495105; c=relaxed/simple;
	bh=4PE2b3ACMY3o3d38mU1mSHxVwSSuAydoTxeEbLcQ5UY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MugKe6x8iWIJdUlQ7m537Q5GeYwFyIMGienWTwH/NPj+z/579K6x/hj5c+sevcLDA8379gSkXoGNu6s5s7FVfWj0iQRGDClb5wyq7cMhk/CArliKXa3xGRZ7yK+eSMz/7u84bk9AbFGA8VmoLQzd91w/ZAWYvIm+k2U8r/FOKrQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AxOEu0FC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vgQb8hh0; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45RDMYb1028215;
	Thu, 27 Jun 2024 13:31:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=yrqjIy6sRqrJEdH
	wtwVd5+3eQXwNJQdG3WdnsoKY1FI=; b=AxOEu0FCFhVF0NLGk9RDOc+9BSe8KNS
	ruaU8ED1k+2H7XJL+STCKMoAyWhLLS7iONX1S6OnI/FCjCmLYM1FfpliEvxeVRjC
	71ao8OowHNKArdbiFHFjp8/ix67k2m2KqcTXNZGdPrj4pfLUJ+akw8pzfG8nShcL
	RMDPH/n2nwtfqff+TKKCeNvMyvt85+yaGNIFa7QJdpkZS0vz/AnVYu+T86X6c0uB
	qK5e+KFh11e1LsskeRAd7ezop1xiFJUa5mx6BPIbu+TaatG3DxZqGTg1rguQTJpz
	fA26CEEwX6Svd61uo8zSKnExSmle9dbPLu//VCtGmnpwgNC+zjs3PuQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywpg9dqmn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 13:31:23 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45RC23Tu037044;
	Thu, 27 Jun 2024 13:31:23 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2045.outbound.protection.outlook.com [104.47.74.45])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ywn2b06ye-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 13:31:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JcHZi31NcueYvGa68Y9iXLvX2SRfOGPwXJ8J13B3gXnjEt0oVJTgFcQTYXoctwNAbX6s0WstAlXcLCZ78ncmJb85BuZDQVOCPm/XUfxRQdPCMQQZjXXz0cga70OJjZZKMi1ZHxdUaChoMH7MNOJbi3M2pocU4Lq0lR3pbODEPR71B2KKVxRWw9qOY4+xITs4s/TsgCmaja0rCuSw314AVC9QGGJ3BKORgHjUfsCb483GEqtKmAxQxQ4TkF0p3AL5fyYxkjmBr3LfU/UmtJmO2vextRdUiuTmlwzofKblE7rdq9g/CZLLN3x/gUZad2Rqg4y7efcU6PDCw1AlycP/LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yrqjIy6sRqrJEdHwtwVd5+3eQXwNJQdG3WdnsoKY1FI=;
 b=P3V970rnh/yMLHyQtpP+VdnOqT5Y1BwyrTz0KN0F/siPPRh/eF/xDSqgnYmxvHjmPGFI9Y8BCqb5trAeOg9SMSC0UsIxdEzN2Y3fLTDi9i4npVYDXUhfChK5YExjJS3ZhXTCRo8TU7mTKXehcJnVskIJgLsDXLBEHIuYFj8u3fkG4d7zS82wa/4hEbrWvwJO/LIDxg18XnZrF3oQFIzL0lu6cxBD7BHXVCRj+G50ADCb+DlmPyCuci5KTHUeEKmxKlwDRSEsrTaij/Sb2hNk6Sn5/R/75uan0SyRkJvm7xOr41ieOnBW8FAxAktdqiJ4tenO6Hgp6/Xqr1ZLuZ39mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yrqjIy6sRqrJEdHwtwVd5+3eQXwNJQdG3WdnsoKY1FI=;
 b=vgQb8hh0lEWsg8aPCJ/FGGUwGD1XjRAhb3c7iZUn3XqO94W4QDTaG2neAGSpDtxYpZUA50QFrRy2ulMRuxGtjzLxPo6zfv50Z+CdwO3Z9+MNT3dkoDIysmrEDSE080xXMvyNZdcT1ASasvZ4igRr0w8higCZT937dURWc4AHfyU=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Thu, 27 Jun
 2024 13:31:19 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%5]) with mapi id 15.20.7698.032; Thu, 27 Jun 2024
 13:31:19 +0000
Date: Thu, 27 Jun 2024 09:31:16 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v2 00/15] Avoid MAP_FIXED gap exposure
Message-ID: <ebcnfmbqvsxjcpyvabzkgtjzczmkkeieapvitzjonwxvdgkyao@mbx4au4cpn64>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, Suren Baghdasaryan <surenb@google.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lstoakes@gmail.com>, 
	Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com, 
	"Paul E . McKenney" <paulmck@kernel.org>, Bert Karwatzki <spasswolf@web.de>, 
	Jiri Olsa <olsajiri@gmail.com>, linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
References: <20240625191145.3382793-1-Liam.Howlett@oracle.com>
 <20240626135855.a4b64612a9104ff163e30bd7@linux-foundation.org>
 <nlq44eay3zjapg23tjprukm7w2ae6qcy5xtc5xsxogsmd52lwu@fhfzf4l6777u>
 <20240626182811.fa717f7b1051a35af72cebfa@linux-foundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626182811.fa717f7b1051a35af72cebfa@linux-foundation.org>
User-Agent: NeoMutt/20231103
X-ClientProxiedBy: YT1PR01CA0066.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::35) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|PH0PR10MB5893:EE_
X-MS-Office365-Filtering-Correlation-Id: 933f84cd-dddd-4235-2859-08dc96ad6da8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?xtsj/wEEIgPAIn/5e9RC5NIldcLDL4jPACg/JOeokyCmWw833eAbOnOTnWFa?=
 =?us-ascii?Q?mj6g87KqYdgZs8RnsCD1kbxhS96WroKb6s0XW+UNcRgqzJ87ZuZVq5h3YewR?=
 =?us-ascii?Q?FXLDP8hw3scoEVOshfSMGqrDH6klShtkQZXG6g/PwrFlj5aAfsWHTqqNSeRR?=
 =?us-ascii?Q?AIDQHSLUopK/sQ9tRT5StduqPfVv/hPa3gPJGukuYiitlZ2VxzTZrWeoplfy?=
 =?us-ascii?Q?58lIxizfkUBJFeYKQCmzp+EiQtF5XM2X5gyCa9UPXXa6XdyE+fOxghhnbBQg?=
 =?us-ascii?Q?Pcz0nILN9g+1LJ75kDlJadgXYbACYxPhc5ANJX95uxhozcxBYq+jWS9agXkg?=
 =?us-ascii?Q?w6yIKMRjiFdBwymQR3dxVZK2qViLXtRuoES8/xHUSPhVzXsPheDCCbgEJ2eo?=
 =?us-ascii?Q?Z7b/QjxPZqZn9d34pIC9p515mdYvbz+hFyelU1NARQW/qdplaSAXPoL2jFz6?=
 =?us-ascii?Q?6hRueKUgqZad4YEgaIcEm9WEykzSB7lP3nw96QSJK0ZKTv/JccwtUlHWoUzR?=
 =?us-ascii?Q?RU/5rcoZm8Zfmu/tvgnVZSH4QtVOclaeiXkZ0mE/tCJ0VpHTFKDMHBGjYeiE?=
 =?us-ascii?Q?wYcZP9WJr2KBsaMJpQrP2bAv9VRWnbrcVMvW3MAt8lNLu4nV4OJ+/ic1PlCW?=
 =?us-ascii?Q?ydGq6+zepViQKlrXyp6NcibaE+fUTI1YoUyCby0mcpuADSKFZIsjpBCMzXWc?=
 =?us-ascii?Q?He0n6uBa/OJAe7OFp14vnyo5BkplBhcb1/pqFo5XoSCh25aQrjZuYypBj35o?=
 =?us-ascii?Q?uJljad+x+Ud3g6BVUvpgtt4oEWkFo9g7zLhbfZTvGjVw9i5KFM4xx2vy1pZC?=
 =?us-ascii?Q?wARTDxAMGT/vzVjOCeUSaoH7U9g9BymOhP/abVoUoZy4KIRfsQogy0S7Idvp?=
 =?us-ascii?Q?Z6q0tzUdeP7xXxmYAEyWYE/IuzNJt3WUkJdaGdfiq29NCr1D48Bu1Noiutrv?=
 =?us-ascii?Q?LTxr9Qie3bJjZICMs6y4DVj6sPIL9YQ3IMr+lFZUA4VfCC7XkH32Yhyp9pkD?=
 =?us-ascii?Q?UohnFgcolOrIhG+B4fFfbmpDSn4sHYkDXbIbYtNI7Lzej2jfsogexcykrQ36?=
 =?us-ascii?Q?9Kk74+xZ+W+4Kj9/Ekm4XoctjorW6PMbqUCgej9eabFNIjFF0VUfpVa7z20s?=
 =?us-ascii?Q?dr2tnVq6y8vWyfpmiSqS2zyQC9VtJpVUiO5n54xumOt+H3H/LRJ2L5shGmzT?=
 =?us-ascii?Q?MnMgbAwSWpIxim1IA0kLJIw6oOI48ukZe5oMLObLFZGq1ngtyLgAgZz0B4VF?=
 =?us-ascii?Q?/QdA3iENRUPN17aybQ1+X3Z5Wi+mPa5xb3Kz+wPEWqQJBkBXCf490COoyLCV?=
 =?us-ascii?Q?k9Suo8mN64MFTX5ljqKwvBI9oQQSdkvy0r0jrALuQ4MTRw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?NbN4xqO1IeIalxQa4JlFPIPdWZSzBSTNCjw9pHeW7VkzzYMqaoUeI5BxMzcd?=
 =?us-ascii?Q?tKphS5KB2wsLtKIOqXy64hih8z6ywh54dd0w62No+O5XHYA8BWRLoLkCDgJw?=
 =?us-ascii?Q?g+XQUItA9CHKQoIfdJwRi03PvrH+trA6l+1w604tYYQB7xySX/khRiza2dHT?=
 =?us-ascii?Q?d1TQBSlUL1mZnULr+oZjvAJ9pImUw5jnAk+//rFQkCD+65boU6wslAsyVmPg?=
 =?us-ascii?Q?sjwRrZEi5hTBjAch1mAEqEpt6QL6V9S1WBOIBkRGBBgXMMLfqtV71WtVuhBX?=
 =?us-ascii?Q?pvoAVweJVeoq+PpXcxRsJ8doCt31eHwUuLfRFvZS1qKzIaxOHSbgeEjR7bq+?=
 =?us-ascii?Q?lWk5odt+K9oNkmDrT3LbETQezxjcIF2aS/6lXF0Vm8WuxvfY3yboy/67MU5o?=
 =?us-ascii?Q?5E+WFS5HsgtmDXrHT9+14ipEzVWap1oFA43ByhpJ+4pdw8e0CC87uSsRKQH3?=
 =?us-ascii?Q?JaH3XDJWptGqkUxVxzNXPNDZUjzLp3qvDbFR0nieXqmoGuZOTF0ev5+y+q/0?=
 =?us-ascii?Q?23nFiF5bHbRaMoyuwZwIjz/4uMJNqhMUs4mCFH7dHkngA+jBKtwLI7Tux6gQ?=
 =?us-ascii?Q?oUAUHIzXJf2dQNJ0wRBa20flZeOBn8ui44nKW1PLY8QtgDDpSGQUWdp5YbLr?=
 =?us-ascii?Q?H+r2z7PTHy40KLZtDzy1Ch6op2tcA5h0gL7aDETGX4KnhV7SzXKC9l7YDU6G?=
 =?us-ascii?Q?XdvX2gSMXcYReFq5jRYutjkKmmzIe2sJPxfK1fU8vsIyNsqfgSa4YD+Fxg9m?=
 =?us-ascii?Q?aYbK/s+NY34i7WfEBFf1dDOJQWw25CKbYl4EnS5z3rmDQNQGlGkhc7469g1J?=
 =?us-ascii?Q?tQVomWGa1XDQRQOmDe8mvDrkkBJyydcj+NYiAJjvJhN4Djnaf87ofO+CNhXn?=
 =?us-ascii?Q?G7WEXNHnae8e2EuGd0T2dlTNJhMjetA78ERjHdhWnYS80DM7vo+l9IiHxZ5Z?=
 =?us-ascii?Q?YaGYGfeOkN9CElvNH+i0LXb1YYJ4TDIRhAaHA2YaaMHIWR+7vhDDDwdEGJpU?=
 =?us-ascii?Q?HSDQuwfxNFYX80MDE6qQIgfvv9EG1Y5z5aHJB6CRLQ6hlztpQqiOFK9KEQ4/?=
 =?us-ascii?Q?v0y5oJX5tgRigw06zkoiSY79V6i+2+hZ3rZ5QTWaXqU7pwO3e3RbahkJLXJm?=
 =?us-ascii?Q?mt+dq772ILZ/HG1gbqKVyQZ1znAIiAePPHYld31d7IoLNn56ufxxBqvoc6Ju?=
 =?us-ascii?Q?ePrvMgId+97tHxKcjiS5h8lKSmC1TrGkx/mF8LTkhRwi6OXoQ83/6NGvWqmL?=
 =?us-ascii?Q?eOF4t1V84y1GYjTpuq7fgQlxog7tJil2NB07duolvAWUm4xlnN3rKd0iQO7G?=
 =?us-ascii?Q?LwLxbyoB/E0kjCny6G05cEWSofgaYtdBoutYyvm8A9PrkrMp3W9/0ehXn8rq?=
 =?us-ascii?Q?4zXZH8L9gklNur5mzZ97tEA5xN+US87yrHjzmByU+pIuZl2E77SRsVVPZFyP?=
 =?us-ascii?Q?mNVx27sZUKllXaW1w8nzn82ppUp+b6GjWg5TyJq1EhQ2NWADTbApFSGjqyO2?=
 =?us-ascii?Q?LRZuU6ygug9N2Mwdx3oa1+Iw5Quy6xSoUHHfnso9uoakaHb+yIjE2jswRf5N?=
 =?us-ascii?Q?b1GE0UiDlhWbykW0i6hIG7i2DPeLWKVoGVnJXbgd?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	axSSU+GpZtgnjhEOquIg3nKIvRMDYREsyawHtZq44RTReKmMUAcVKQzwXXZvLYAtMTXiC3a7nET1iaHyNN5+d3YyZHS6pml251BzWsl9v3tQ6/8scXRn+XKVHfknYSyilz7i7gIp7Z3Z5Rjd8cvi5IT3sPsAhjCehlW/BWgLrNoKyPkVvQ28ucscQwnNsIIuwMVRZyNVgFXlYRXviHZ11Zkxo7ZBEfzDemkKbFOusPamNnY2rJwhh54VwGAbWaQ7oKY7ArCT1MqAIqMQb0hbDJvWd03opdRLC9VFsLpCHFACs1IpGVwSi3IECXcw9/6n+HxG6RBeirxDYBOer0LE8iT+9amK2X4hJ826avF8Hlv7otaxTPvMHBfW7XIk5FJRdMvWaSqU1Br05WXAnPwriF4JJQc/h6fDv1/jEVXINOJxWmo6UMjf82/CnjeL7MH1TTtzp8qodItWhNIpF/Iag4wzoXQ+qxm0xcSMyH/vkHcj+H6LyNbWL3IcnAOxObXgHuJIQ2tjOylCoXqQSGzIl+lA7ZNqBss3QtVndRGT3GWgLARkhKukJ4/mLhY/0/ZMbY4JjzpoeQX0sQICXbt4UCtipeokQDzHMdPEkVGoqF8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 933f84cd-dddd-4235-2859-08dc96ad6da8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 13:31:19.4990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kv5LwPfwuhwnGb20cJXPndPWZ6QNuG90VquQ9GdUM/c8G5+yMnJg9WC+bdnj87DGFZAs8qMxSuKzVTJaGzQTlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5893
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-27_08,2024-06-27_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2406270102
X-Proofpoint-ORIG-GUID: jsPwsYYPFPVFhg_2QDqnWlxqfn3a09em
X-Proofpoint-GUID: jsPwsYYPFPVFhg_2QDqnWlxqfn3a09em

* Andrew Morton <akpm@linux-foundation.org> [240626 21:28]:
> On Wed, 26 Jun 2024 21:15:18 -0400 "Liam R. Howlett" <Liam.Howlett@oracle.com> wrote:
> 
> > * Andrew Morton <akpm@linux-foundation.org> [240626 16:59]:
> > > On Tue, 25 Jun 2024 15:11:30 -0400 "Liam R. Howlett" <Liam.Howlett@oracle.com> wrote:
> > > 
> > > > It is now possible to walk the vma tree using the rcu read locks and is
> > > > beneficial to do so to reduce lock contention.  Doing so while a
> > > > MAP_FIXED mapping is executing means that a reader may see a gap in the
> > > > vma tree that should never logically exist - and does not when using the
> > > > mmap lock in read mode.  The temporal gap exists because mmap_region()
> > > > calls munmap() prior to installing the new mapping.
> > > 
> > > What are the consequences when this race hits?  IOW, why do we need to
> > > change anything?
> > > 
> > 
> > In the (near) future, we want to walk the vma tree to produce
> > /proc/<pid>/maps.  Without this change we will see the temporal gap and
> > expose it to the user.  This series was initially sent to Suren as part
> > of his patch set.
> > 
> > We also have the new interface for an ioctl request to a vma at or above
> > an address. I had highlighted that an rcu reader would be ideal, but
> > proved too difficult at this time. These patches by Andrii are currently
> > not using the rcu reading method as this and a per-vma locking
> > clarification are needed.
> > 
> > Since there were two users for this code, I decided to send it out
> > before the other patches.
> 
> OK, thanks.  We're approaching -rc6 and things are a bit sketchy so I'm
> inclined to hold this off until the next cycle, unless there's urgency?
> 

There is no urgency.  I'm more than happy to hold off merging to get a
full cycle of testing.

Thanks,
Liam


