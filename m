Return-Path: <linux-kernel+bounces-247957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA2992D6A2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 18:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DE3E28A4E2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 16:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96AE194C92;
	Wed, 10 Jul 2024 16:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Y4AUDPIi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QOGGiThq"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDFE194AF7
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 16:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720629249; cv=fail; b=O+qhWJhOiZkIxmgCF3CgT0KQmc9FDet20dMyssy+Cwd56oD3lHkuQ2Ftao9JVPA/uwSgUNhK36Dq0VCT87vVUhAJXKKn0hmFJdyVlCmpTpXSHWh8PtBrTIpmWecyGSRL2P/HtuoyU8DRbQUTD2POUU1MpWbd2qyllO01X//Idr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720629249; c=relaxed/simple;
	bh=Pvnl/kFazxH563MPN2GvNRra1WxXJniptIimOTHJ26Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Pv1UPQHNUGW8by2lHQLdY0Z4Ezy9UxB6sKiHJ4o2APLoKw+GJF1RG6n4LTpF6gRWj8prrA3d8Tqd4khz6N5tucQ3s9oEQQyMQwiZ3V+rOJ7khQ/dXML9GhtQTwXyD5CVwhNpFTtLjE3tAl2vQQRPzmBR6EYupS4dU98XeCF1UM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Y4AUDPIi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QOGGiThq; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46AFf3xZ004061;
	Wed, 10 Jul 2024 16:32:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:content-transfer-encoding:in-reply-to:mime-version; s=
	corp-2023-11-20; bh=tltjSmVVDStVySNU8JV4I9cVbyoLeXKr74lScSlBXUY=; b=
	Y4AUDPIivpra4Wc5ac9Q/38Xpq5DFafUrn0pNjFQujC0iLvsvl39zfupGyxbAMEi
	9PJDNmca/4z4tw4GadX1gTsNmAh8oxa7T1QrcQpU5fJ/0Ck0Nhl3CaC9Gkj1CL1v
	6FyDdjPtGTNDP+plv0MtLgTvm1HBrkq7Iili1zlOvgFxsixSxwUkn9JDkjRnE/wY
	URsiJ/Lts9lJch3WzOvK4CanUp6cvpVgwLSe2/QOu4IR4TryTXaxztGkxfnoeWhR
	E3YVCfzNmgAF5/wTnw2YQOKbUO6oJb/5F8ogGPcNVGfxnSWyCJ1/5x03i4F6TGXd
	B7pmlZ9j7MODKPhFwFbIlg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406xfsqq3w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jul 2024 16:32:26 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46AFKiq1033838;
	Wed, 10 Jul 2024 16:32:26 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 409vv12ut9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jul 2024 16:32:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PGQBm8eNECHb4YNgyOfNx6VQ/gfy+J4D0QZgghAE45uCYWEHPMc300wABruEOV5/8mloGU42ZpamBxjEpqos3SEEn4JTsu7z65Wfdtkvq00Q2J3cgPvkvqV4awBLY452mpP9rB7DjnZLKu0FntYgZGR+EWLtyhkUqOFZ23fAbmmnW5zVfUMMAb1KraxHXfr/H0LKin3Jkk9UaXsV7slXg263lm0NmUU/g8qUm88RrheFPGtfcKItZ5KYLRv7egebPlKxn+4siuZ5MaF3CuaTN1tXc3YwEJKY8gLS5U1zzTC1EAOkqieqTE/fzjlGAIq4k2txrsH9dG+wlVdmi7upZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tltjSmVVDStVySNU8JV4I9cVbyoLeXKr74lScSlBXUY=;
 b=TCNxPqLf2KLEk+JCzfXPP/XveQtLrfgAVCytko6C0fxpkG9vQbAYFJygyEeKpwWlOB8GelTDkKD3pJZLiT681je0UcG9BCYCbf8+g7yqUy0LveKQ2m8KMAmwv6pyRGMcZiVz+yV3P4uFKrZ49k54YkApSMtjrqD9IjX0HupZSxzkOe0IIO4hutd/jac8I5DJbNMf9ihyELR6Mj25oJl6V6Hwc7Zp1R/FxH/I1zqJgrPnb9eUoLAXk0mW3hScplLXO04KtD3vAZVTilsx/om1PxMrCIQeqP3M3b3hBUXywEdk0871Ww4qTrhM1BW4FOgDThq5AIeXDqNkLruT8G8NbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tltjSmVVDStVySNU8JV4I9cVbyoLeXKr74lScSlBXUY=;
 b=QOGGiThqGjYkworqmDdhxeyeKK/jErc8XjB221D1EWti9mNOxgPL3BcHWb/14njDQzS6hjJvRDWgwUqlHT+O/ilkz3/VrhVFnYyTWzFnzMx04AJB481ytSsjpVG0WiLOQa7+Zzp3RqQ+f0G7x4jvFZ5kmxXxfRbmatY62szwrSs=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CY8PR10MB6682.namprd10.prod.outlook.com (2603:10b6:930:91::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 16:32:22 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 16:32:22 +0000
Date: Wed, 10 Jul 2024 12:32:19 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v3 04/16] mm/mmap: Extract the gathering of vmas from
 do_vmi_align_munmap()
Message-ID: <jleknhksnz3tduw645ounhpvuzivfzlqq7zorhkqdv26dy3t5t@wmysgg4ibhep>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lstoakes@gmail.com>, 
	Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com, 
	"Paul E . McKenney" <paulmck@kernel.org>, Bert Karwatzki <spasswolf@web.de>, 
	Jiri Olsa <olsajiri@gmail.com>, linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
References: <20240704182718.2653918-1-Liam.Howlett@oracle.com>
 <20240704182718.2653918-5-Liam.Howlett@oracle.com>
 <CAJuCfpFHK+Bw8H1r5691yjgB+OjUEd1cedDydsfqp8zJwfRb_w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAJuCfpFHK+Bw8H1r5691yjgB+OjUEd1cedDydsfqp8zJwfRb_w@mail.gmail.com>
User-Agent: NeoMutt/20231103
X-ClientProxiedBy: YT4PR01CA0115.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::24) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CY8PR10MB6682:EE_
X-MS-Office365-Filtering-Correlation-Id: 575b2dfa-7367-45cd-8e6e-08dca0fddfe9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?a05OYmZQTGY0SXp6alpWZmlLSG1ub2REaHF1N2V3SUErUXhmNzM3N3FROWcw?=
 =?utf-8?B?V0hlMy8wVmdyZ3hrQXlndlVHbjVncHRKK0xUcGd4enJ2OE1US0RNTTJZL3pN?=
 =?utf-8?B?YmFTdVpQYThkVTVLMWxpQTdUTjA5U2syOTJkUjZnbEZrODlhblozTTMxS0F4?=
 =?utf-8?B?VVRRV2EwMGgvZ05aMHNRS3NxQkk4S0x3amFGQzJFNzNrUHc5Szd0L2xBd2M2?=
 =?utf-8?B?bk1uVWJlSThQcjVybXp4Q21RZjNZcXo1VVdrbnpuVTA1OTlpTFBJQUVzSUlN?=
 =?utf-8?B?blZCTkNab2VhRDRxZW9EVDROZGk3VTNzb1dJMHVXSzhlbTRIVWM1eTEyZ2dN?=
 =?utf-8?B?QTQwTjdkZyt1c3ZlSHdNZTdkd2NYQ05DZ1BiaUhhdUlqcjJvVjlzOEJ0bFNz?=
 =?utf-8?B?aFdiZXcrSDJGSWdwRzFianFqQWZiN2R3NEtMN2xQdnhtUHdzb091QkZvVDhN?=
 =?utf-8?B?NzhEOGxWVEcxUEMraFZHZzE2Qi81S0ZEZE1ZQmNSQnd0Q1BEaDZmR1dsNUI2?=
 =?utf-8?B?cE1yMWVqTFJXK0loYjRMcVBvODBXT2doWmpQOXJIYVhmUmJSTmdkeXZycjNw?=
 =?utf-8?B?SGFuU2srOTNwNUFvY210TytUcjNJUlBPeUsvT0hDZ2lyd2FuZXJNdGNJenRw?=
 =?utf-8?B?cEZNNGxuTUZ5dExseFZRK0VhenRkcmNpWGhHMXVNZUgvdEFFc3R6SStnQ2I3?=
 =?utf-8?B?WXQ5by9zenpUVWNRTXJDVitVbkZCSE55VVZNK0VrTDNsNDBmcFFadnMzM3Rx?=
 =?utf-8?B?YUwzaWxsY3c2ZDdHUG0zdDdRNVZWTXQ4R1VnZksxZGZEQVdFRndzTzR4ZUp0?=
 =?utf-8?B?Z282SXpISDRIMTZjSnNyTFk5bGRwMmkzNDdZa2hKYjRBeFJJOEJxbGdPNDZ2?=
 =?utf-8?B?aTBtSjV5ZWMrWEtGS3owMlp1ZHpBbXpzaHNoQUY3OGZsZ3BWNUZLZk41UDVv?=
 =?utf-8?B?R2tyVHFwVDRlbDI3M3B4dlk4TUNNdVZiMkJoZUdBOGYyMGJjOU9WU0xibFJ5?=
 =?utf-8?B?cjV2Q2V2MndmdDdwOXREVHNWR0ZtU3JTR1d5VVlaTExqU29KTEorQjVkY2lE?=
 =?utf-8?B?T2s2RXpWOHc5OUpYalo2Z1FvUEVKT3IxaTRGRzArdTUxYitFbUdjZndnOVEr?=
 =?utf-8?B?TnNJY3o3azdYOTFiMUtCNHRNV2N4bnZ5L3UxOEdLQ0VoWVZZaVJoYjZJemZX?=
 =?utf-8?B?VzVyYis5aTcwb0NnbmtNdnN5M09mcW5vZHFtd2pMaDhsdHRJUkJTVVFOb1RV?=
 =?utf-8?B?bnNEUzVsNEZuU1kyME85Mk9kYW5QQVRWaWFBdjliTnhmdVYvcEI1UE1vc3lS?=
 =?utf-8?B?aXdLRlFCTHVMV2RNR1ZFT29Lc0thbWx2Q3F6TnpDdElMWG40WnJQRVMrNUtF?=
 =?utf-8?B?TGo2TFZBaU91bHFzTlhqcXc3NU9WTFVCRVoxUXVZc3d3M0ZLNFl5UUlOTDZz?=
 =?utf-8?B?SjQ3aHhpU2hZZy9nMUpuZnpRMHBaeVp6SEJmVWpOL2xYODdtMG1wMnU3bnVu?=
 =?utf-8?B?NTl4TkZiVHYrM2pkZHRQYWlLclVyaWNUdmdCSmp4S3MzLy9WOHJhNnFTcTV6?=
 =?utf-8?B?SWtZeTVvM3QwQVN5cjhzcHU2Z1VrS3Q2U2F6YWltTFpRZ3VzRUIzdmtSL3BG?=
 =?utf-8?B?aW8vaU1VNWZyeUtZb3V5S1ZZdE1jVlNIVThUMi9Vb2RhK2orVlRFTFRuanB3?=
 =?utf-8?B?RnlTaytLT3kzVG5SbGdtY0k4b1d2TTN0bTM2cXlkZlpraEtLb1phRThKbmt2?=
 =?utf-8?B?ZUxkb1lnTDdwalNNZlpUMmpJNEluWWhtRmhTeExwWEc4NGp1WXlqbDY4RlRB?=
 =?utf-8?B?bEJZRGN6NVcvQ1k5d2o3QT09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Rnp1a3lPempxYXAvb2Qvc1dQWnRORW93cm12RExERXBOMkNkb0MzZnhxc2cy?=
 =?utf-8?B?RGhTZU16TGZrZURrY1paM1J3UDlCQ0YrL1RZUm1Rc3hVL1hZdGcyYU1ueWdE?=
 =?utf-8?B?RWgrMEZpanhaZjhFQ0dxSHVRUjdxTFUyTENOcENvb3hiK2ozY1BQemZIL2p2?=
 =?utf-8?B?K3B0bmM4cVhBQlZrWG5hdzNuKzV5YmdJMTlIbzFPMXBVOHQxcEJyRUQrMmxB?=
 =?utf-8?B?b0RFRmVHbnB2NjFudWliTnVMV0V0K2U2UjZ0aUNQNlFWc0N6ZUlMdmJWSlcx?=
 =?utf-8?B?RFJ1SWZHellpWERpaEhCRmRQTmNiREhkV2V6WVBhTkhFRU4rWXdORmdneUpR?=
 =?utf-8?B?ZUxpVHJQd0o2YXU5VEd3ekVqWEtrZUpqK0IxYzZtekpKS3BrWWMrZEpmYXp0?=
 =?utf-8?B?bUt0UWJGdDZ0eU1tWFJTYzFiWDhOOTJBd1I3Z2lleXJJN1g1WlpVc2E2Mkhj?=
 =?utf-8?B?VGdVS0lsNnR0d3REVEdUUkJ6WTFtRkhkN1U2MlU3VHZXT0xyR1RJakttdVY4?=
 =?utf-8?B?VlltYTB2OXFoTnJYS3JkM3BQeVhsV29uK3EwZzV0UnduQWg4Q1l4ZHhkdnBs?=
 =?utf-8?B?Z2pyaDZVV0R3TEZhWmdZZnNXOFFKTVNnek5lQXRYMHZFTkVvN2FtL0xZN0tW?=
 =?utf-8?B?b3dlWlFGRlErMHphWmR1MG1mVXNrM3lzTktZaHM1RU5DQUk1cWQwek9JUjRJ?=
 =?utf-8?B?OXlFSDlHTEZ3Tm51ZnU1MkVPajRGOEp3eGVKSmxzL0pvdHFoSWRPeFZpVGdi?=
 =?utf-8?B?S2M0dlJDWUZNa0txckxhYzB5aGtDbzkxODlNZ2pzbE14SWgxN1ZFNkc3U3p4?=
 =?utf-8?B?Z08zUWtDS0Zib2xNbHVDU1RENlArN0ZQYzNFRkw3dXlsZG9vMUxyd2Y1Wm5T?=
 =?utf-8?B?dTFLM2E4YWFSRWhjYzYxcUpsZ3phTHVKUEVQcEhxQWlVRXBmd0NyRnN5bXFp?=
 =?utf-8?B?OCtWTHRlQ2oyUDlPZjhPa1ozeFR1QjZWbHF6cTdIMWk2T3VVbk16a3lUOERM?=
 =?utf-8?B?UEdUZFpETDRRQUl1WDZwZ2lvQkxMTFZudWhWbmNNR3dPZUkxNVdiUTQ5VnNB?=
 =?utf-8?B?bjNUbmlYa2p4dGc2ZnljM0xLZ29pb0UyQ0lBWW1EMzlXK01ZVWlOZm1ZK2Nn?=
 =?utf-8?B?UnU1emZNUDVnZ3JwQW1Bd1pGaTFwZzByMm9YeVJlbTMwbFpHMno5aGcvK1V5?=
 =?utf-8?B?OFQ4eHl6M29PSUZ6cFhhbGpYWEFPVGpUQ3poeXNVeGFTcDUzME52RlZzeVVB?=
 =?utf-8?B?eDl3TlJ5SGNnM0cvN0VMMy82cWVsVXR6WXJ1M3ZGb2FoNzRPbXR2UzN3aFJO?=
 =?utf-8?B?WHRqZGw1RHUraTZsSUJMZkhFRGlyMHBpTEptS0N3ajZoSGx1VGtQcGk3bFNT?=
 =?utf-8?B?cmM5elNDTlpENi9KMVZ1UzR4THJiVFVEN1p0amRibGY0b0IyeUZlVzlKempm?=
 =?utf-8?B?YzNoRDA2bUUvV0RWUHlRa0UwelpibEp2TkFzRlNHZStzK3huVldDYjY0NGsv?=
 =?utf-8?B?Uno4OVNoMmp6OVU2TjNtWWw0TXlpeEdjYUR1WkZ6QVE3bi9XejB6Zm1NdFdz?=
 =?utf-8?B?SmhmRWhiYVNGcXNya2w4YXA4QXNwcmtaYU1WWk5GN2Nzd2RJT0FYYlJ4VFd4?=
 =?utf-8?B?SHFSRE5yWFpRemN1WFo3YkJHNGM0OWZOZ0FrS1lSLzRpbWJVbE1STFhPSkxs?=
 =?utf-8?B?RzR6bUtuR2VBVmRHMkpQTGNHTFdGc1g5ZDUxaXYwU1VYVHNNbktDYjgwcWJM?=
 =?utf-8?B?c254UTZpTmlxK1p1eWVhZ0pLYVQ2Y1lLTHQ5WUc5cmtKa0QrcmEzYTV5Z1J2?=
 =?utf-8?B?REl2dzB3M3hTN1Y4VnZKTkxrUklRSnY5L0dwei9nZkF1dzlXWENhTjM5Qi9X?=
 =?utf-8?B?Wm1hcjhJd01kS3NqRjBqaGtubGMwUW1QRGZBNHF3dkpWSCt5eFR3a3gvd3dJ?=
 =?utf-8?B?Z2VTdnBaeXhqV3hpYXNndzdwdi9OZFJ4RXJwY0IvYXpVUHVENDAzWVZpdzgr?=
 =?utf-8?B?QW45QUEzL0YwTHc1SytzM2hJTC9DYk9xTWg4aktyMXZqa1AzS0pZQ1BLQktn?=
 =?utf-8?B?Z3NVcHlJaTUyeGlFR0RmeTlaVVZvK0E5dmNjYkdxa3lsWGR5dTlsclhsMmFO?=
 =?utf-8?Q?c/yuPfTx9jy/yGaILsicM/9se?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	jt0wCONSI4UCUbZWd6szN4kS4od2IGPapjpU3jqgxsYeFiuxBbZVhttesDH3GwB0XETfAl7B1M11hpHs70cvPw7iHILW1sAdIwlSMsGneGlDYTbZi7pVSR88dxxuwGdiyK/xw/lFWEOpSFvdLxB3GCxNbzXnaWyo7ETmzPDkS/rEh4Aa9bJlkqEgC2k4fwWdo7zCuYSyxtAvgX0J4ZDg0d0Vtcy3L5q8JEqjFpPpP40jzN7HdW+fkwRc6yRYsLpoji5X9bUgSN5JjnU0MTDjvB/HcxDBCicNOl5GQkG7GaQLHrHmURJl1dV83UzBGhytLfKMexdV2+yIPMFKZpq+5X1B4UmS1jitDCNQF86ALbSBscRh6c9pyRbokPqq6kVSluc8g1zrNhz3/PTQ3wug3uVMW3KCN5++mUfbVfcgAkdDHLdLDy1ALnQJdQnV9T6S6NFa5HYsdKyRHwsLs80KQJYqYep2PLqEmuVkJwlngf+xBINqdJMLSokQlZt89CJU3fFGWwL2fc1PoYGKwvPZcbiAHVTeHMT3yosZgtPl2Xlh+bqMDCdjV7i1+xW0kvhbYNJLGW/I2YwDcuYQX46PgPoAYqo7vy4ECqDqdNQ9kaQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 575b2dfa-7367-45cd-8e6e-08dca0fddfe9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 16:32:22.4563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sxUMcmFQaPQi2ur63BjFBJhFhCRJRy9ZoI0uqDIfQ7sAB/lPRYxgbY66pniPbPQCGI9vIgkT4ygVRkjzxtLKzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6682
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-10_12,2024-07-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407100115
X-Proofpoint-ORIG-GUID: pD6e5eI9H4dDsFAiILN4xDvitqtbflHJ
X-Proofpoint-GUID: pD6e5eI9H4dDsFAiILN4xDvitqtbflHJ

* Suren Baghdasaryan <surenb@google.com> [240710 12:07]:
> On Thu, Jul 4, 2024 at 11:27=E2=80=AFAM Liam R. Howlett <Liam.Howlett@ora=
cle.com> wrote:
> >
> > Create vmi_gather_munmap_vmas() to handle the gathering of vmas into a
> > detached maple tree for removal later.  Part of the gathering is the
> > splitting of vmas that span the boundary.
> >
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> > ---
> >  mm/mmap.c | 82 +++++++++++++++++++++++++++++++++++++++----------------
> >  1 file changed, 58 insertions(+), 24 deletions(-)
> >
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index 411798f46932..8dc8ffbf9d8d 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -2656,32 +2656,29 @@ vmi_complete_munmap_vmas(struct vma_iterator *v=
mi, struct vm_area_struct *vma,
> >  }
> >
> >  /*
> > - * do_vmi_align_munmap() - munmap the aligned region from @start to @e=
nd.
> > + * vmi_gather_munmap_vmas() - Put all VMAs within a range into a maple=
 tree
> > + * for removal at a later date.  Handles splitting first and last if n=
ecessary
> > + * and marking the vmas as isolated.
> > + *
> >   * @vmi: The vma iterator
> >   * @vma: The starting vm_area_struct
> >   * @mm: The mm_struct
> >   * @start: The aligned start address to munmap.
> >   * @end: The aligned end address to munmap.
> >   * @uf: The userfaultfd list_head
> > - * @unlock: Set to true to drop the mmap_lock.  unlocking only happens=
 on
> > - * success.
> > + * @mas_detach: The maple state tracking the detached tree
> >   *
> > - * Return: 0 on success and drops the lock if so directed, error and l=
eaves the
> > - * lock held otherwise.
> > + * Return: 0 on success
> >   */
> >  static int
> > -do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *v=
ma,
> > +vmi_gather_munmap_vmas(struct vma_iterator *vmi, struct vm_area_struct=
 *vma,
> >                     struct mm_struct *mm, unsigned long start,
> > -                   unsigned long end, struct list_head *uf, bool unloc=
k)
> > +                   unsigned long end, struct list_head *uf,
> > +                   struct ma_state *mas_detach, unsigned long *locked_=
vm)
> >  {
> >         struct vm_area_struct *next =3D NULL;
> > -       struct maple_tree mt_detach;
> >         int count =3D 0;
> >         int error =3D -ENOMEM;
> > -       unsigned long locked_vm =3D 0;
> > -       MA_STATE(mas_detach, &mt_detach, 0, 0);
> > -       mt_init_flags(&mt_detach, vmi->mas.tree->ma_flags & MT_FLAGS_LO=
CK_MASK);
> > -       mt_on_stack(mt_detach);
> >
> >         /*
> >          * If we need to split any vma, do it now to save pain later.
> > @@ -2720,15 +2717,14 @@ do_vmi_align_munmap(struct vma_iterator *vmi, s=
truct vm_area_struct *vma,
> >                                 goto end_split_failed;
> >                 }
> >                 vma_start_write(next);
> > -               mas_set(&mas_detach, count);
> > -               error =3D mas_store_gfp(&mas_detach, next, GFP_KERNEL);
> > +               mas_set(mas_detach, count++);
> > +               if (next->vm_flags & VM_LOCKED)
> > +                       *locked_vm +=3D vma_pages(next);
>=20
> Uh, this was confusing. You moved locked_vm/count accounting before
> mas_store_gfp(), so if mas_store_gfp() fails, they will be one-off
> because we incremented them but failed to insert the element. Only
> later I realized that if mas_store_gfp() fails then we never use these
> counters. The code is still correct but I'm wondering if this movement
> was necessary. We wouldn't use wrong values but why make them wrong in
> the first place?
> In later patches you account for more things in here and all that is
> also done before mas_store_gfp(). Would moving all that after
> mas_store_gfp() and keeping them always correct be an issue?

The accounting is only ever used in the even of a successful munmap()
operation, but I can make this change.  I didn't see this as the author
so thanks for pointing it out.

>=20
>=20
>=20
>=20
> > +
> > +               error =3D mas_store_gfp(mas_detach, next, GFP_KERNEL);
> >                 if (error)
> >                         goto munmap_gather_failed;
> >                 vma_mark_detached(next, true);
> > -               if (next->vm_flags & VM_LOCKED)
> > -                       locked_vm +=3D vma_pages(next);
> > -
> > -               count++;
> >                 if (unlikely(uf)) {
> >                         /*
> >                          * If userfaultfd_unmap_prep returns an error t=
he vmas
> > @@ -2753,7 +2749,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, str=
uct vm_area_struct *vma,
> >  #if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
> >         /* Make sure no VMAs are about to be lost. */
> >         {
> > -               MA_STATE(test, &mt_detach, 0, 0);
> > +               MA_STATE(test, mas_detach->tree, 0, 0);
> >                 struct vm_area_struct *vma_mas, *vma_test;
> >                 int test_count =3D 0;
> >
> > @@ -2773,6 +2769,48 @@ do_vmi_align_munmap(struct vma_iterator *vmi, st=
ruct vm_area_struct *vma,
> >         while (vma_iter_addr(vmi) > start)
> >                 vma_iter_prev_range(vmi);
> >
> > +       return 0;
> > +
> > +userfaultfd_error:
> > +munmap_gather_failed:
> > +end_split_failed:
> > +       abort_munmap_vmas(mas_detach);
> > +start_split_failed:
> > +map_count_exceeded:
> > +       return error;
> > +}
> > +
> > +/*
> > + * do_vmi_align_munmap() - munmap the aligned region from @start to @e=
nd.
> > + * @vmi: The vma iterator
> > + * @vma: The starting vm_area_struct
> > + * @mm: The mm_struct
> > + * @start: The aligned start address to munmap.
> > + * @end: The aligned end address to munmap.
> > + * @uf: The userfaultfd list_head
> > + * @unlock: Set to true to drop the mmap_lock.  unlocking only happens=
 on
> > + * success.
> > + *
> > + * Return: 0 on success and drops the lock if so directed, error and l=
eaves the
> > + * lock held otherwise.
> > + */
> > +static int
> > +do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *v=
ma,
> > +                   struct mm_struct *mm, unsigned long start,
> > +                   unsigned long end, struct list_head *uf, bool unloc=
k)
> > +{
> > +       struct maple_tree mt_detach;
> > +       MA_STATE(mas_detach, &mt_detach, 0, 0);
> > +       mt_init_flags(&mt_detach, vmi->mas.tree->ma_flags & MT_FLAGS_LO=
CK_MASK);
> > +       mt_on_stack(mt_detach);
> > +       int error;
> > +       unsigned long locked_vm =3D 0;
> > +
> > +       error =3D vmi_gather_munmap_vmas(vmi, vma, mm, start, end, uf,
> > +                                      &mas_detach, &locked_vm);
> > +       if (error)
> > +               goto gather_failed;
> > +
> >         error =3D vma_iter_clear_gfp(vmi, start, end, GFP_KERNEL);
> >         if (error)
> >                 goto clear_tree_failed;
> > @@ -2783,12 +2821,8 @@ do_vmi_align_munmap(struct vma_iterator *vmi, st=
ruct vm_area_struct *vma,
> >         return 0;
> >
> >  clear_tree_failed:
> > -userfaultfd_error:
> > -munmap_gather_failed:
> > -end_split_failed:
> >         abort_munmap_vmas(&mas_detach);
> > -start_split_failed:
> > -map_count_exceeded:
> > +gather_failed:
> >         validate_mm(mm);
> >         return error;
> >  }
> > --
> > 2.43.0
> >

