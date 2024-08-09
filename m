Return-Path: <linux-kernel+bounces-281272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 823EC94D4FE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 18:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D602DB223F8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 16:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12E43A1A8;
	Fri,  9 Aug 2024 16:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IO6lVX/0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gTl0prFq"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58EE22087
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 16:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723222136; cv=fail; b=fFI4TyeZYUtLY8h7XJA1zjTQij8W/be9KevM/34JWPaI9T0S999IuAooXLlSoNz9ZdG80JwO5qIgdLPS6YHfsna9X3rpsgVbbQOzB0PhzQakwRUhWnpeqC/3et4aTuj6s7gxYNs+eh9NkrNIDAAz8GIAU5O57C5vwn1SJEEz54s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723222136; c=relaxed/simple;
	bh=j+RB0P7VA7g3tbCqrWTW4xQgeQN9/Mo3jxFhEW6nxME=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QPARzNKpRU2hzoHusDE0QkhTwlyfU1rDTY3ky6RqtzsB4lvlftR1blsMontwVae5fG9eZxwd7hd6J45T6W945pI4UZwnonmpFN2lJa5Hm7WpKjwd2s0HGfVrr1eVBSBvgVtj9vTT8rJD5xuttt5Zw+RcldY+195tzGCWKP3vtWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IO6lVX/0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gTl0prFq; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 479FMXlI009871;
	Fri, 9 Aug 2024 16:48:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=Qwfhp5dyzNnMnJG
	w+3DBHUc9nys48EQd+yzPvgdiTsU=; b=IO6lVX/0MUw9D5qOOJePGbs2MynieuF
	ICvvkTQtVpl2pB476+Vv/0cF3FH8nF8Xl+Ax3LWJocTcoggqWVw5W6liGgGXEzR5
	5PhUxnWe0RTKqMvgQXMhFO57hkBS3J4Pjx78MVJfvl6xzU7k5L+BzH0WT23zoQZc
	dqfSq1uNCpass1eIn7Qai/fkYSPXyQoc1y5gc8bUXPRS5u75oCdFXr0N0RpkoRAI
	CIJvzmsFLjnBzEk8RAAGlTt6DCkOxeUgoeAna7b7o3Cg1elra+v6O7VeTzQ5G27O
	wkSVMmj72+rbfvGvxSuadOu6h4d0vDnAJ43Lx9wOfZj/z3uU+T9iftA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40sbfavggx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Aug 2024 16:48:39 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 479GTslk039413;
	Fri, 9 Aug 2024 16:48:38 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40sb0e4uyc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Aug 2024 16:48:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JjwdwKi5Bpmd3CKVf43BpzFNVQU4MIRsmDxcKRSZUs6S1l0yuLZEiBmYmB4z6NmKgDxNeheXfP3RgroP3nRz08OJIA552sRmHc3qPtOuXa7dv3s15PivgOtNR5xpHAIBoT/bZN78pd/d9BZmySDzY7gl8UuJUpE+MYW7EEnUO+S8g93mKD1Ek9ff08Eh94zI0C43eSv7OGxJ5JuRREuU2BUX4dT9do34ICW61b7a4cBq3BeH0wK5pV5SVHHnLYLVAqJXA/FEnblctcnWE+iukFGlIDL9JYFnw1d4QP0F86ZEhl+4rbn7glV5tNbqZZ+kZN3RS6buuMJxUbnddhGNQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qwfhp5dyzNnMnJGw+3DBHUc9nys48EQd+yzPvgdiTsU=;
 b=rcz3BNkKoZcogvohR1prttdHtapqG/MUzqRtz0V4Qy39U9cAjbHa+yKotBO0eCk8QicEFM+ul/WO3KB8LcOnYSzdlt4Db88lblCbkukc5aJEHAId586aMfGHvNE3p4NEQwtKWgu+JMb+9PwTSE1SFM2z7vxk5DlNjyP2/1bf5om8zBo8z6qqMPtXQdG+NM0OH0LnLVkQPNm2AG2FY08uZDyB4vK4eYMH9VlCK3o0PZ7nnTN2weDZC+YC6xVoyEUBVJe3C4tMh+tOkU5FWVCCTSW1mFNhPzGCpgo5lzBs+1py2vJ5maIutN4RqKyXyS6JaQ+GN6oGxo27Q3CgRr1BTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qwfhp5dyzNnMnJGw+3DBHUc9nys48EQd+yzPvgdiTsU=;
 b=gTl0prFqoyH2pXGOMvkekIDHtDYdEYmMh0Vt5T2SIqYGOFi3Qn68Jd4cT0Co/45a+A6jLG8oMzI8D/2JCnprHFIOZIx56FRTqGYhEZxEA+nyLOg2mhbOHfxyZQoYqOa2CqDfcbbUVWGu5MEM1Jvmvv0eEKt6OzwcarwfcXafrbE=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by MN2PR10MB4366.namprd10.prod.outlook.com (2603:10b6:208:1dd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Fri, 9 Aug
 2024 16:48:35 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7849.008; Fri, 9 Aug 2024
 16:48:35 +0000
Date: Fri, 9 Aug 2024 12:48:33 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Pedro Falcato <pedro.falcato@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, oliver.sang@intel.com,
        torvalds@linux-foundation.org, jeffxu@google.com,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v2 2/6] mm/munmap: Replace can_modify_mm with
 can_modify_vma
Message-ID: <3hzwtm7jw25ng5gemkp42k5ypkfky25fxeevccnk2d6gcpft32@qwkwofgauqna>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Pedro Falcato <pedro.falcato@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, oliver.sang@intel.com, torvalds@linux-foundation.org, 
	jeffxu@google.com, Michael Ellerman <mpe@ellerman.id.au>
References: <20240807211309.2729719-1-pedro.falcato@gmail.com>
 <20240807211309.2729719-3-pedro.falcato@gmail.com>
 <n3v6ebfiwnk26rvxwtgkingmuduv7gla7kaiasjdvadbrpczlw@d3xjceezvgzc>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <n3v6ebfiwnk26rvxwtgkingmuduv7gla7kaiasjdvadbrpczlw@d3xjceezvgzc>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0460.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d6::24) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|MN2PR10MB4366:EE_
X-MS-Office365-Filtering-Correlation-Id: 7912b876-8d16-43b8-df7e-08dcb8931bed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0/HmDh1nyH5OKAAxAmfwdRBc6Z+py/K5UV7rODF+yhR9xI9mKKrJDRyQTaSZ?=
 =?us-ascii?Q?AJiw+x7LYzZxcI/Tp7RpcjHH+t4WeIMnzSqvByZPsW4BoEt413cCpUUdcLyv?=
 =?us-ascii?Q?4SOSuVhWWVi8cwWqlqtsguGzJJ5eneiX239TN2+9d5KjI6EOWW7OeK3hrTVV?=
 =?us-ascii?Q?7XjKb0dUbeWC2/dLrc8eUpuQ0ArPYFUmokaskoJ5D6/0SY+LMfMbhZP/YWfI?=
 =?us-ascii?Q?cb4xoyP4q9BxHY1BDNM01AjMJxqwYP+0rzoIZe7+Lh7Sg9TaORfjNT0Qrm/I?=
 =?us-ascii?Q?AehvJjFriZS8j3KXLN/GicJ0bAPkJQEQGBTyVQlVSCpiEhmA/zU8rzTiUa8c?=
 =?us-ascii?Q?HEWZuniAImdOwolww9d12x2aNahGvh60ljeWvb6EXxJGUpUpBmTUoTLI/4lz?=
 =?us-ascii?Q?kDboO3iZmrVxPd60SfJAg7SiGkbRvPjTEfjCdtLufmP8Rrlxfcys/DnY/jQW?=
 =?us-ascii?Q?o47k1TrtYDrF3rOKWzr+JaxI8yuB8T93ZjvpMFEP+Po3Jeg0ZCavZdheCjmj?=
 =?us-ascii?Q?AgRec3FC9VkR9HyciyFryn0U6aCMDWrdLhTrHuSfBnEb2j1kJg9pnJgfW/tD?=
 =?us-ascii?Q?sVahtPH9p8hYl3KXR84bKe4bZToIFUSp5mrU7KxYI5+y7Fy2gaSuAy8KuKX2?=
 =?us-ascii?Q?0hVnFneGxOmLIJ+lwvm83awxKF5f7uFgQqfwheOT2VlOe/k864MLoPYkiXxJ?=
 =?us-ascii?Q?eHDifXbhVkU4nfijmbJlaoOORJiYur4Yup/vRdFmXka6TvHCU/DpeGlqelkZ?=
 =?us-ascii?Q?jcvkJE8jzqdlUJR4FoJFuPyZppns7xxLTBBmCEeZAnISKC8NgfKaOQDr4KSr?=
 =?us-ascii?Q?xWl0+0qo9uSXRP57Rx9FgB6d67GByaoghXI51qIbAVF3uVlvGxEoICjVgw4o?=
 =?us-ascii?Q?xVNVqBtsGf/RRMiF/iHW9oAE13oQUO/MKMHfSb4T6ONivqpnSG1DMcCacQQw?=
 =?us-ascii?Q?fgsot+H+za4Tyq8YKkaXZUGyveW4RI1zkwqCqFgJ32EHvuX5RiY2CI9fONaL?=
 =?us-ascii?Q?crCtbv6+gBU4IFDIe126IVoUoIFw6NP5O+mJ/V8hOGtyDzkVaQMIZDj7tkei?=
 =?us-ascii?Q?0kkPvzi3EqgRPCPFfgB80xOVjHVMDM13ZCSLbeU14K5bGR4MDxbDYxXYL0Ws?=
 =?us-ascii?Q?FVTUDkPjqoJ1Ts3Cs8MB0pvVykV3AlZWGmv2nS/rv8LfTqJGj8yaUzs9WBcv?=
 =?us-ascii?Q?5D3xZlprx2Ux4fN9GredjYaKWb2Bew/3rggrSABS9iC16pjrX5bgDWw0Nv+c?=
 =?us-ascii?Q?Zsdp2Sq5ltgpYM9XUY4ZIt2xO9fUlpk3vMG/0LflDGlFGQDx28Y/w+A4k0a1?=
 =?us-ascii?Q?VG7Eyo9AAXNHSaWa7uzjRd9qGL4ZqX9lVqf5AzemDE1i6/WOlnXn+eIcZ0AL?=
 =?us-ascii?Q?ARgcjeLgxJ0pKQ25M1V4GStPxAdB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?D4bvvzfkfWUWxdIV8UogM9gnmF4GDJIStMw4JDSFqXwkdqFd/MjKig9VCaRg?=
 =?us-ascii?Q?PEQfH2h6mGzLs4kq1v8HZYlV/fq7j2bNzikGEYE+16z6iRx6GVxtqH82lvSt?=
 =?us-ascii?Q?roNug6ehZiqU9OaNhn36E+620Ew9ou1I47KTTMFmr242UMM/uZMuEGidLv0G?=
 =?us-ascii?Q?jWpAE1ExV8kVjjl3I49PxxdWnNhELF0H3wb+CKkVl0pPvDsGbn6dhf8oFJpF?=
 =?us-ascii?Q?t6BI92IxlhNGA+snr7ByFsQW/feYKSFSYHy5hpIPqseJ7uCisEuuBkB/dCxD?=
 =?us-ascii?Q?8Ue80Jk89BZmDppZeXN48N2GLkvdRu8CepErMZILyPPHdXd9Fpgaa1PHBD9E?=
 =?us-ascii?Q?aXF/xywyCBCbtPb+bB2JR6OFULOgMWyI4Gm5+omkONgPFiZaS9u5UwwnxeKg?=
 =?us-ascii?Q?AcwEE7eLVZyKjR406Ur/9cRxlaXgc3IFCqouXw+w3rfL3O7kkPhWePfnf36s?=
 =?us-ascii?Q?I1sEC76oPnc2w3icFdya9MRF6lRcBSk9tr43+EYBECTT8AZzGu9bIJphdduk?=
 =?us-ascii?Q?ykxSF0cq+C/KTFFwBKdAXydkIZdh5P/40MqxgUqjVezyq5Z1FoOdwfwf7Ljk?=
 =?us-ascii?Q?D0NbyC/RKXeYgnmrxsfupQCair+wObh7wiRJIPI1lnZZg471tPyZwgqhWY+a?=
 =?us-ascii?Q?eM3g5vr3zrQmVwbzHc3/8xGSeWTyGdVamZTxs4n+IJNUrnsQ8A/4jTrrRMkO?=
 =?us-ascii?Q?lUsd9g6wnql5noEtj0bixp2drovra9QvJoG4/MddL9PaKFxOmDXV4ShoIJK8?=
 =?us-ascii?Q?78+3xuCovnPaoPkNbEt4TlsCrk0Fdrl5wOsoS4eD9oCBDXqF+fKbbi9KJ+cj?=
 =?us-ascii?Q?kK/SeQId9K6lm+QoUsad0zAP5mupGVTaIyvaF94esbS+0l41JBlA6cB8XxM/?=
 =?us-ascii?Q?eP/luL9bNrJHgmxF9QEyTDb+P9Z98ySKDsUMzXcNWo2JgmZlSy0RgsFDMbVf?=
 =?us-ascii?Q?1sqONufzXry/HMTkWwOf0fzuLpvfAm6ICpb9FmSpjd9TcgwBF/TCS2/v5XV+?=
 =?us-ascii?Q?PbMYHdT1QWjCheOZypgiHOrPyZAPnZ91vF7vIJ6zD74LYxZKL7UjgKE7I6Ot?=
 =?us-ascii?Q?Z4msub7Yg9/xOQqsqi2UDSs6bfeEDlL05OCPlelBpDohVPYljF0oMWSxgq7r?=
 =?us-ascii?Q?OQsetyQOcmhDomJNtEH/Zqd9NTDI/TQSa5pFrDBiN+XzXwKLpKmlDGbMTLTu?=
 =?us-ascii?Q?Ny3NEXMV8tNHKWSTn2rv6o1B9iHhrFpHQhxFYEkJrlbA60CjYodK4ZhPIRZQ?=
 =?us-ascii?Q?Py1z70QIVksL8sQnHgoMamf7A5uGM8rCEmCqs5nIkwz9COAiFZmbKjbNuPvR?=
 =?us-ascii?Q?+gKYnIo4K/xPN064qvu6iY7afYcCkh3EvZj7xdigXuZ0Ps3B0cnlpGal3PMk?=
 =?us-ascii?Q?A3ps/bFeVhW++AJRpB6yp4H8/3ME1O5s/h2PzASuV/Bykiol4uPBjxIJnWh9?=
 =?us-ascii?Q?vr2gZ8qt7rNhYvov6yuaKfyLW7hoG5oEcOZ23IO+2GOXURrxSIGcdpZ/yI99?=
 =?us-ascii?Q?YMkRIRHgOXf5XjIl1FnthtVf442EfTs1FfZKTm6U2jaGNAkqbCLs7EcQqkOc?=
 =?us-ascii?Q?s+VVDZXJRq/4itoiOTWrsyMxDmAiSSZb7sH9QrlzjDPK4QUoGoWQcgcOeZV/?=
 =?us-ascii?Q?Ew=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	CuluWWS1hRQlQxyV6ThEHP98KVCGxnNbmHx+DtvGTKQ2WqG+MXkMH9MRA0yNrLZkCbWecV1BF1u75rpBHLsnKfWZePTrLaLJ5i+SmlWwhyF2Z0vm0e41TpVr0vSsG8Zokj8Uk0EriNH+dI88NzhWMbtsz6ZV+qoW2+fScCs+WSO52cCu+yEM4WhkgNn/CbYCuCI2yWmu06D0xiuqz8ZpSt9xilHTypmHiDM7qPzku55iqvobQMf3hcjAIumR+ykznJdIS6NuH+Gs/DN5KzPb5Ts55OqIty7bmmCZ3SbR3sHVzJRkvbhfJBZJJf3mIYioVjyuODYFcTxYwhs0pMKtA1QZkqFSd3BWqtM91PhUuOaVvxf15yVcL/fNCtfa7WMFNXfY14anjYzs5LhJqCiCBxwnPSpUuOV9t4KkIxO3RqcZBkRP/Igi2mqmlQa3gLadewZFWbJ46ncLyXFc1Frn7OZp6qJQZR/xzDR40hNw6IxtPX9ee4MFEvDX4EjA02B34jrS5+9+hJpdnfYKvqmIjdQzVtTuPEqv+g2T+dEiyvoqXuZFRDowVQP8775DL66oICeG0fCzVog4K3+6pltjUhMcsQeoZPr2rNtYxBPZ6Rk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7912b876-8d16-43b8-df7e-08dcb8931bed
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 16:48:34.9449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hjFcnUcglOGmC0y+kHIFv7lrk8ZlmmD9Ehe5EvhZMDmx4hiRAi3MCoLL6B0O+cAvqrXmGnNjT9BhSmtI1eO/ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4366
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-09_13,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408090120
X-Proofpoint-GUID: zsE00UyHLjT37rf9EwJPFO28W7SJZfWJ
X-Proofpoint-ORIG-GUID: zsE00UyHLjT37rf9EwJPFO28W7SJZfWJ

* Liam R. Howlett <Liam.Howlett@oracle.com> [240809 12:15]:
> * Pedro Falcato <pedro.falcato@gmail.com> [240807 17:13]:
> > We were doing an extra mmap tree traversal just to check if the entire
> > range is modifiable. This can be done when we iterate through the VMAs
> > instead.
> > 
> > Signed-off-by: Pedro Falcato <pedro.falcato@gmail.com>
> > ---
> >  mm/mmap.c | 13 +------------
> >  mm/vma.c  | 23 ++++++++++++-----------
> >  2 files changed, 13 insertions(+), 23 deletions(-)
> > 
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index 4a9c2329b09..c1c7a7d00f5 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -1740,18 +1740,7 @@ int do_vma_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
> >  		unsigned long start, unsigned long end, struct list_head *uf,
> >  		bool unlock)
> >  {
> > -	struct mm_struct *mm = vma->vm_mm;
> > -
> > -	/*
> > -	 * Check if memory is sealed before arch_unmap.
> > -	 * Prevent unmapping a sealed VMA.
> > -	 * can_modify_mm assumes we have acquired the lock on MM.
> > -	 */
> > -	if (unlikely(!can_modify_mm(mm, start, end)))
> > -		return -EPERM;
> > -
> > -	arch_unmap(mm, start, end);
> > -	return do_vmi_align_munmap(vmi, vma, mm, start, end, uf, unlock);
> > +	return do_vmi_align_munmap(vmi, vma, vma->vm_mm, start, end, uf, unlock);
> >  }
> >  
> >  /*
> > diff --git a/mm/vma.c b/mm/vma.c
> > index bf0546fe6ea..7a121bcc907 100644
> > --- a/mm/vma.c
> > +++ b/mm/vma.c
> > @@ -712,6 +712,12 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
> >  		if (end < vma->vm_end && mm->map_count >= sysctl_max_map_count)
> >  			goto map_count_exceeded;
> >  
> > +		/* Don't bother splitting the VMA if we can't unmap it anyway */
> > +		if (!can_modify_vma(vma)) {
> > +			error = -EPERM;
> > +			goto start_split_failed;
> > +		}
> > +
> 
> Would this check be better placed in __split_vma()?  It could replace
> both this and the next chunk of code.

not quite.

> 
> >  		error = __split_vma(vmi, vma, start, 1);
> >  		if (error)
> >  			goto start_split_failed;
> > @@ -723,6 +729,11 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
> >  	 */
> >  	next = vma;
> >  	do {
> > +		if (!can_modify_vma(vma)) {
> > +			error = -EPERM;
> > +			goto modify_vma_failed;
> > +		}
> > +

This chunk would need to be moved below the end check so that we catch
full vma unmaps.

> >  		/* Does it split the end? */
> >  		if (next->vm_end > end) {
> >  			error = __split_vma(vmi, next, end, 0);
> > @@ -815,6 +826,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
> >  	__mt_destroy(&mt_detach);
> >  	return 0;
> >  
> > +modify_vma_failed:
> >  clear_tree_failed:
> >  userfaultfd_error:
> >  munmap_gather_failed:
> > @@ -860,17 +872,6 @@ int do_vmi_munmap(struct vma_iterator *vmi, struct mm_struct *mm,
> >  	if (end == start)
> >  		return -EINVAL;
> >  
> > -	/*
> > -	 * Check if memory is sealed before arch_unmap.
> > -	 * Prevent unmapping a sealed VMA.
> > -	 * can_modify_mm assumes we have acquired the lock on MM.
> > -	 */
> > -	if (unlikely(!can_modify_mm(mm, start, end)))
> > -		return -EPERM;
> > -
> > -	 /* arch_unmap() might do unmaps itself.  */
> > -	arch_unmap(mm, start, end);
> > -
> >  	/* Find the first overlapping VMA */
> >  	vma = vma_find(vmi, end);
> >  	if (!vma) {
> > -- 
> > 2.46.0
> > 

