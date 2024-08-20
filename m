Return-Path: <linux-kernel+bounces-294695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A26895916F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 01:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7AB0282873
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 23:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2DE1C9DD7;
	Tue, 20 Aug 2024 23:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Me6zM/ZP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lUAxqbuI"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CD51C8FDB
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 23:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724198291; cv=fail; b=XffZBNEhUKc5KTtz4jVjLQpYrQOCpxNi1RKic/ZaOg3l3kKod0SD5TOIKs1RaMX4+rxrjcpctf7O20uuAcunPIMhHe1qxbecpB7w2ihishFtAstyHtGBfpg53g6BRSZSlsSPzZ2ou2Y3ojhYGo0Fdl/kg2URrqZPHSnrDuhCTio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724198291; c=relaxed/simple;
	bh=BqQz40OqzPtGsqK+chLoMHo9IBeOINIsNRURO7HunHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PDWvra8fWUKoTu5e2+hxdAtK5fePZzn9+ERzNthCQwSYnoaEqKovbhqW5XCoGcgMPoGg6JfYY/KtZLoOcnI0W5tNF/hXL/Y9GyCbvZA//EOmDclcP36ttRt9lj1eCIIfXAJSjO9rkA93aWxrEQy6kJUf+bf04MvDGhSS/opUBDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Me6zM/ZP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lUAxqbuI; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47KMBboa017802;
	Tue, 20 Aug 2024 23:57:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=+SgEZNii7vamI+Wr52WRA094htKGd868kPJiAHCbwa0=; b=
	Me6zM/ZPC9I/tL3gi7hWIGQM8VfKqlxm6I7DsMR7gBNk9k8tloSDLVJEc+YOWJzM
	mXgjBYSSVJIwnG8vky+M8LvlBPSdCk/mjU6PnIP99oBCmvzCDszzHH3l26YR/ZIO
	eMjpRPitBWGX3tRXGh/ip7euSDuPRpA8jzExWsOLX/82c2xsvu8GolKBK/SVjxUC
	Hn53d8cyYGYDskTbROjSfdFIkk5+AsK+/Mlp/yzxo1zpPp69pXRDMDf/IVkJ2tjP
	bI7KvL5DQlpCSOryI7kTWAalY0/r3Z7fqmV1oojb4RAiggzPpGFfw+gHYdWQ6gZR
	2FXSN9B5myWDe/1a1+PSKw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412mdsxagg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Aug 2024 23:57:56 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47KNY6L7023532;
	Tue, 20 Aug 2024 23:57:55 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4154x78fsn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Aug 2024 23:57:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tp4n/CJyYRd2aY9WcFrs7EMMtyCabnLoxMd1nJNTzweu+E13Smp+C3Evniu4fLZYzHpVg8eihVFAqdsJGc/EH+yLq+rdwW26h22AZhVJL5BxkB4IIJm+wj0HyHqOR94kpP2VN5T597hQIBjxnMTMrpdHBAy+yyvkVy/SJrfFiDp4rFoiL1HMnKAn8d+3i19s8PBGFmFOKwztSJ6B1kU0ySE3En19AMCg0j3wwFBk1vxNsjIyzvuNKFYKE8KHDRS2RQ5ob4cc1iYMWy5DxDmBFVPy7lTgwXB/UN7jazv9XEjwUgfhTJsxHy7PoKqiF3lCsoAkGt4/wQY3kIKOTOZpAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+SgEZNii7vamI+Wr52WRA094htKGd868kPJiAHCbwa0=;
 b=C0efeCCiJCft2R3dIY5AJ0Yee//Y1CyIg/6pN4cZPQm9GXIJypWQa8jEMKSCDZrkDUz8Mui9YzE2AXisVB5eclBljbx/CTpCPmGvrkToyIsMlh1RPNMLABqmlpKIh0p7m6MtcBZoXoQmJoRx/raZjCgAxtEO1LTONBA+zE6v1BN633XV1ri99AilFnC4LMhC8N9G39FrM09WOPEPdy08SGwbaPotDQXv3kkeVrrnS6dIZvEuvGjW84w/7t89DdK1T4WXIOXHNU9SjKXOMhek5yrR8JLxY+YuiD3uEyhiAlieGZDg3QfTDF3j0q8hKRLjcq7jo6uiV+cUUjCDmkFRUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+SgEZNii7vamI+Wr52WRA094htKGd868kPJiAHCbwa0=;
 b=lUAxqbuIfJBqgE+7RK2cS9igh+O3CZCVNt6ZF9BInRCoNkLkP8K3t6hY1OV9ifdhj7wj8FvnD3onmHtaUz02UvocrLVt8PiAuE7Xt9IoXcND+EzJgAs5q4NSJ8pxs9eDHka9DzrjeGcLheUk33raX7+hr9mUpzI52pcvDaDTHQY=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by PH0PR10MB7099.namprd10.prod.outlook.com (2603:10b6:510:26d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.13; Tue, 20 Aug
 2024 23:57:50 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7897.010; Tue, 20 Aug 2024
 23:57:49 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        sidhartha.kumar@oracle.com, Bert Karwatzki <spasswolf@web.de>,
        Jiri Olsa <olsajiri@gmail.com>, Kees Cook <kees@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH v6 01/20] mm/vma: Correctly position vma_iterator in __split_vma()
Date: Tue, 20 Aug 2024 19:57:10 -0400
Message-ID: <20240820235730.2852400-2-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240820235730.2852400-1-Liam.Howlett@oracle.com>
References: <20240820235730.2852400-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0112.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::11) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|PH0PR10MB7099:EE_
X-MS-Office365-Filtering-Correlation-Id: 353a9446-2b49-4b15-6eea-08dcc173e5a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DH1k4puYGZFjcfFEAavWg6e8sMHhRmbBb+mNFeSXi/yWD4tt0sAadRBxVSAo?=
 =?us-ascii?Q?o+ADlWW+nLnpC68tT1ojl35x6yYDkqHLDpwpXwp+881j+rFL5Kme0f+mV8Lz?=
 =?us-ascii?Q?nTW+QlZMtklawzE+IVKyHCDnCjTA2SFr/bLIqSMZ7k24lhNCMT9HJ4zpa98m?=
 =?us-ascii?Q?2V9Ktd/OcfoVyorI3V/Ss2T1eucxxmUtFl4/lAcTvFRH1KpPcJeKikEdBPc6?=
 =?us-ascii?Q?8YoeURPgxsEAr+TJcJ9LHfM+60MYgJhqhPOoO133uU4bmq6PkbwWklfX0DpM?=
 =?us-ascii?Q?+qt3kLqeb+ra5teKMl71CkoEw2BQGOv/Wqt7NGrG+03r00eJ0SVor4eePapW?=
 =?us-ascii?Q?pTnMdeMhaGWhSkDB6BIDQ4SadFBl9XHcGkNs/5I0ekMGpmnGjywe33vCj/ei?=
 =?us-ascii?Q?vFMwEG9WN1CnaDACmYKEVq/9paJWedjZyT8oDseymNNBiAVPYrFpBUtiMT9W?=
 =?us-ascii?Q?i6co5aZ0kyaeJ2eeD1y4EVYlpx6RenAXoCrHTjR2Mzqvg0cy68GjYZ7C3v4U?=
 =?us-ascii?Q?TkG4GSQFPlSG21ZoYkXNMrNeH0CkwsRW7jdGGepUoJAfavgb7RneKmsLMb9b?=
 =?us-ascii?Q?otA74qOR6Uaw1Qu4ACkyykrNn6CLvqXW7VBYyWCSvcYSXqCd7DOCTWLUsonS?=
 =?us-ascii?Q?J9vreJmON+G54kjL4gp+DP77pWBOWm8RkFogsOZQvFh8Ql63hjyWnCFO7Blm?=
 =?us-ascii?Q?Nm0WiKNMRGT5GnXn6qwI4sETzgqSBTCnV/KMkMuGoS6dwbdXi0vLnJC8bWAq?=
 =?us-ascii?Q?+Iw/pColRB5yacc3/K40WxTBa6pkfo2Am9bKA5lS49lSAroaiLVYwFZDYXb2?=
 =?us-ascii?Q?g3LBpgk60qVlWklgamfsIKbYgd9IWQmb+jwHZiLQ2je/3wvz9UbCD9FfVyEZ?=
 =?us-ascii?Q?Hx7buf8i4a2SctqTEvjK2L485tgFjYI/emlX1x+s8qzAa4WTPIUKKHk4eHZG?=
 =?us-ascii?Q?AMVgvSUISy/cPOBL34A/dQ//rA76sXy/wSAEY3kbUzxQFL7ka1oKpEbYiV/J?=
 =?us-ascii?Q?AgHjmHOvgQhJzn4Ok0RBU2h0pqefhY3b/d3rIlwyVVzMAT4xQWk4Ykgkwii/?=
 =?us-ascii?Q?++Ee1M/jM81SdRd5k3hxTZR0sWAEWxlThAZJo1HvPiOcUMNN1hdleQviS8Be?=
 =?us-ascii?Q?g61Cc9b3v1um733wCuFIfO6Wuv0jkym0bD3YRsGjrVU3GmXWAmx5XQXWyhvT?=
 =?us-ascii?Q?5Q8IbUIH70iiqH5jVkl/OWa5I58EBTlKPQI16HJzogj89GkQxSrpJ4d4swlI?=
 =?us-ascii?Q?2IQZaNxuasxsU7jN3Qds41ojf+DVom3ucFOg4jWTzDtn+lYZCTQs+DeWqoLl?=
 =?us-ascii?Q?hrJTEZr2k/RDk4PoK0caAqXzSesChwSlWiABpMHFlUKEsw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LtpkUH/Jrrb/wrVcS54Z8NwmSZaC/IYMIUBd3H6SRowEuYmO3rMYD85GtFQr?=
 =?us-ascii?Q?3jhxn4GYS6KsGXmoD3npOgLeVV3XA42pXm3iMwh2z+EskSkWJ3Iy8Lm2qLwH?=
 =?us-ascii?Q?W0LN6MK7YajL9YHWOK9i2ZG5eTLFH80X5cgKSr+PADBlfeRrUr/ANfxjY7va?=
 =?us-ascii?Q?jz5GPxANW/BxJLB3ypZHgYpEZWr6CijCanMDyN/y49OswcqYHVGO5auQio0M?=
 =?us-ascii?Q?kdbLcr04kV4C10MsA9reQYSRjg/qK67oIJ9y7CJiC0etbI4nNxGpv1pmz02k?=
 =?us-ascii?Q?HrzebPD91BZxWBcYHkgg0ZBgzqYa1VMhTtEXNgJOy1EfGzdxSQEEThdU49og?=
 =?us-ascii?Q?fRsZ8KrcTb6K0TTkLaf7TQyFhedsg7/Rels9QoiRDpidl0jVlMYZaPnr3nKP?=
 =?us-ascii?Q?6JLtORX2/TusZyzP1I4CHG3AduEVCmuppB1Ly45LD5I5k38wxybazRnqelhq?=
 =?us-ascii?Q?gorR61cuj4rJcuuJIw42MbhSsFtor7HKSsLRnHN9zgmni3gi6DmKqF1OJC1c?=
 =?us-ascii?Q?TCJ6UpvPRzMdvLdrbLt3C//mtEa/lUF7V8esc3ulc4uqJ0mhkCQb9onvmi+u?=
 =?us-ascii?Q?qVybyUl93u9lnMVqHYyF/N52HFn8AaFXSqswewgDe9zaEpXma2gmZJ8cOQQn?=
 =?us-ascii?Q?ik1pvCNkIbOY6Uqc46waxzy7MJHyhE4y0ZSCnxKayZ3rKkEP9xdCCbReiuLt?=
 =?us-ascii?Q?n1nvE1FWTt+Pz4nXUb2uEFT71oKOIwJxfhjJI6R6AMC7o4k2WYbgk8GSIUDE?=
 =?us-ascii?Q?hn8PYJlNQKyZxJAPTVXqr3KoMbjA6ffs7duY3dIh/Cn8mS8mB2/Po9XDitTf?=
 =?us-ascii?Q?84ucAod9whKqEFBsOMeAYUVA77EWd46bIDL71AGyOQ5aM5tbi2LYWXFBIzMT?=
 =?us-ascii?Q?1B/jO/j8QbDTp+vwrjz9/9EjP2HKZ0YziTvqAGPaHm6LWO22m7VZpyEIgEJ7?=
 =?us-ascii?Q?uQ0DDecgTbkt+apdvF7i7tcVhhUeUVQGM7vsRnYeDU/Yn0JrKnvFWb2lFpgp?=
 =?us-ascii?Q?5hy87WGMrKmCNehPmd68Hsa9Z6GsrnMdVasDcWT1orGCFOpnBKZj6RS0Xd6b?=
 =?us-ascii?Q?FlUcTzm6/U68YNNtDeNBKzCzLBQcrW0K11L7RSz6wP09KQOsuKq+ndAq5rS9?=
 =?us-ascii?Q?yJ35Cl4vMjYedDi+rqcdrFicifA0E13hgqssIn6ke4FdHz5pREn4uhmzE0qP?=
 =?us-ascii?Q?J1BO4Nw/jhFFMYLWsIC4ME5TxCJh1kZjBovZ3pSiF1iEEN+VzoUzsPmsqgHe?=
 =?us-ascii?Q?Gb9+Y2aqaPYizfnXdP4wXZzWMAchG1/L7TnQSg4FJugf9fVnZXZJ1PwQieaA?=
 =?us-ascii?Q?xfYOt3vaeWWCwNTV3cceA58824nA4XsQYIiRE52lcp9EHyxPbXgCcspozp6m?=
 =?us-ascii?Q?pih4uY4cZ++OLwr54D18P6KiTvFR+va4XU6efmZzVqzl1G0SOTtOPkr0zz61?=
 =?us-ascii?Q?Ouu1U2FEzLbhholKTZ0Bladj3Yd4ouNAY4y2FyADwUXLtJ1pcEIVi7UP29nA?=
 =?us-ascii?Q?Fyl+DH3CV13S4SWHtu/MD0nwjVtcH2q08em/WpaPHEptnntGf+U/PldQAbdq?=
 =?us-ascii?Q?LOraQsCMI3BsurKpu89h5uanxhO6a8c4MCcEGciE1L4bX0kuALlII9ujboit?=
 =?us-ascii?Q?dQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	K7oM+dRwybG6AOR9JDqqDDH/mdAdzCaEbZ7I0wnpMXvi53CLSX4RW6GX3Hj1+ORy9ToBSvuxG6Z6HqDBG343n0DVsh2lorxuhNxBpyq73wTmqvrLHGELC3/UsaXTVugpXim+rWrgi1TmqOM0o4aY4FSNTp3J95L8ZkVx8rJQflQsStEc1X5RvXHj+xb5y2KUAVKbWnhN6zD0AWn9E8g7l4afP6xFlF+dIErWHHAuRXI2JG87k2752T/CBDE4SAKi8HTp8k6jMYQ5Aq+dtAduMtXYRlMyTAzaLuD7aaxGc7YN8hYFK+xJWBrP+ClYAqXYSQqVRmdC4pAc8KkNwezxhS894K96MgAxyIlmmzqyMpMf/w7cPBVjvg0RX8x4SLBl///gbBg4DMazbebwHbrij+3SQTEsjqZB0Vl8Il0Xz6HvIVxOg/Ob7MDdl7kK22FOJjIkoiATJJ20VZyS6WfRiueKD4GYMWxhtnDAuk9NevQtvhmeG1KgCAeFEE0hILYIL23aBsMqONdAxzRtNEHnpizn50F2RIuZH7M2jZ3mLvfKEH4ciCr5Z/J5/R2NU4nGtBTMHHm4TeJ0ITJn9R0AhsZHx62iPyv+nizqNyV4pJk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 353a9446-2b49-4b15-6eea-08dcc173e5a2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 23:57:49.9065
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +XMlbSGQXJegV0dgU11gqbOE9em6V8eV89iasrRZjKjyvm/LMSXMWbB/4eHmaraQSSK08v1lr3AyD75aO0/QCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7099
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-20_18,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 spamscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408200176
X-Proofpoint-ORIG-GUID: Pkly3eK0LM7nZv_XIHanr2QxgglMfv0c
X-Proofpoint-GUID: Pkly3eK0LM7nZv_XIHanr2QxgglMfv0c

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

The vma iterator may be left pointing to the newly created vma.  This
happens when inserting the new vma at the end of the old vma
(!new_below).

The incorrect position in the vma iterator is not exposed currently
since the vma iterator is repositioned in the munmap path and is not
reused in any of the other paths.

This has limited impact in the current code, but is required for future
changes.

Fixes: b2b3b886738f ("mm: don't use __vma_adjust() in __split_vma()")
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 mm/vma.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/vma.c b/mm/vma.c
index 5850f7c0949b..066de79b7b73 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -177,7 +177,7 @@ void unmap_region(struct mm_struct *mm, struct ma_state *mas,
 /*
  * __split_vma() bypasses sysctl_max_map_count checking.  We use this where it
  * has already been checked or doesn't make sense to fail.
- * VMA Iterator will point to the end VMA.
+ * VMA Iterator will point to the original VMA.
  */
 static int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		       unsigned long addr, int new_below)
@@ -246,6 +246,9 @@ static int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	/* Success. */
 	if (new_below)
 		vma_next(vmi);
+	else
+		vma_prev(vmi);
+
 	return 0;
 
 out_free_mpol:
-- 
2.43.0


