Return-Path: <linux-kernel+bounces-378801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 721FE9AD59E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 22:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53B23B21B05
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 20:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9BF1DEFD8;
	Wed, 23 Oct 2024 20:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ud158EJE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nXApxsgq"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00B27C6E6
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 20:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729715946; cv=fail; b=RWXnfwuQ2UINK9jLmCvmx3n92UrSlouwFYUjA9bUiQelnHlAg0hLUkmOLMCQ91y+IgmuZwuKT01EqGn7szqN9woNUP51wUm8nolqXnxES898dRP21YBdweJT4pTM+QAZClulQ2m8wONMy9OKyTsuDDb2I90thJxhC5/0sHn9EMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729715946; c=relaxed/simple;
	bh=J1l26bDuR5AMNqXWNzLNGAhGOo7SKewwn15G9gJ3q1k=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=pgbLjLt7QrPR9H/jnDJ+D/HjN9UU8WltzsRJ8EY6J/zkHVJJysBZGyUrrstd75ioA2uvc7KFIlqB618lz3CA5nIDIKP/pjA4OK0mGfh6Vpgp4R0QFgJySu6SMH1nt0YUPLhMfajMrD+U2swQrIO2lYvbRC9OVKG0XBY/voSdrXs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ud158EJE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nXApxsgq; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49NKcni3005471;
	Wed, 23 Oct 2024 20:38:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=jJ0VN9cEY47aVst/
	SDONE4skPXoC1YBHTQJV6Q3MXyQ=; b=Ud158EJEFeSJXpIuEQ0ihEoi1bc3d7CK
	4eCnCiv1MqFUdqFqbFhx+6uTqIQInwyMfsDA9OCHyobWTQrJDI6PxTFP7reY7wVg
	8YzuVySoyFBkRSvIo7L8QfdQEF7SSNVwMongD0FZcM+sHmEWekiCl/p5K2uhNK8V
	GlLwTiL1gnt3QkOl2Yu2FTbosSxParaLa9Ma3xDJEMX1zpFHN3NX7wnnDPrzto3V
	Oj6Z/6x0XYFpI32zXkwJxdF36BYWxO8TS4mooZOAa4T0svvqsMoSpdKaejK1OKRX
	etYcTgyZgpCa/BDPgokmbqxUyFV5w5oeSyLtmbOwO1LlZgKgQnAycw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c55eh1gn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 20:38:51 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49NK99Lk030906;
	Wed, 23 Oct 2024 20:38:50 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2040.outbound.protection.outlook.com [104.47.70.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42emh2191d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 20:38:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OQ7wSeonZIYWeKlDKDpXeHQ8OQrqrjZtGxpuYQ0ppJvS4sibk89bBGtXlfDlgfYByUH6tON2xTJwc9q6H04RvXd6dZXs80Q4taJb1bbH+c2Wx2GVPNl9e3EAxtmRfEnqK94frgJhVvgIv/ead4xvmGkXxCSef2ZeZeAE95KhJ4F6mZsGCtUBemRVpVrrJKSCjm6qc0Kvl1BQM2nArL0hNcceKRGOP6/JF2RB6wjVZcun9qHKXaaKrhAhCqnV99AIRcpBeCbqrRj2q15LZtfJOUvbqWMrfXFpCCV/OfZxuGXV0iD4UQ9IkD1JqPELEpEELteT1SG2+TObp1U7A4/KRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jJ0VN9cEY47aVst/SDONE4skPXoC1YBHTQJV6Q3MXyQ=;
 b=Lne660fI2sKvgjmbXCQ3XavfpLGqI/1/nQWPhq1dersJVe5o9eMOhCZ7W5yOQCSFGpP6nTQ1Oab/v4m7axnkLIYQ+6jnvmhf4wnxyEeAI9pPQh81wozS1TwqUkLRQVLGtAvI0e9AC62DLYDEnC1uvMaiE5ExcFrI4BZsDL5Hr30Fy/XCT4kJVVQP2fVjv+lx9AEe9KGQLvbZKtemLfUOnrGZwBU1ZVwrQW5Gz90ejBucxY/HV9QV+Zjieac95pEC0v0BDh8ESJw3Z92YNAasAL61PxOmtArZ4a5dsl711UM3rTZx/nrNrnO+rw/RrNhgFxmfNh4O+OvcoHjc7NxFZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jJ0VN9cEY47aVst/SDONE4skPXoC1YBHTQJV6Q3MXyQ=;
 b=nXApxsgqJYVqesMJV+e0wqhsgjqpr0dpulSYxYPEhz1rsumiBi5LwbPGNwfvLjsXl7RBMQ9zdCdhSDJeb14b0XmqJeMxtwTTx1B/fCoNs/rUtObaB6GMVK+xBNMkjokJJHOQL5HCLjN4/uPQEj+aMu5izjiasVhEb+T15f7lUnQ=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by SJ0PR10MB5833.namprd10.prod.outlook.com (2603:10b6:a03:3ed::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Wed, 23 Oct
 2024 20:38:47 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8069.024; Wed, 23 Oct 2024
 20:38:47 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>
Subject: [PATCH v2 0/8] fix error handling in mmap_region() and refactor
Date: Wed, 23 Oct 2024 21:38:25 +0100
Message-ID: <cover.1729715266.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO3P123CA0017.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:ba::22) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|SJ0PR10MB5833:EE_
X-MS-Office365-Filtering-Correlation-Id: 3472c355-4a57-47b1-8f4c-08dcf3a2b199
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?55Q3rbVPYVMsHOjmoqGf1kDNwin6eh2jpuJewkekr+NhDAwNV6sNbdrGrJoQ?=
 =?us-ascii?Q?GpP80/8K9C5gq4oK0FF47i/yL3xkDgJVl6VHquus6ZtTlaYecfpZvcIh9aJ3?=
 =?us-ascii?Q?eS0Fq9qYhkkobXfr1c6LhkNo/jOEDkEwFJ7qeS2EdW+2yKOmsFft0YpIaUCi?=
 =?us-ascii?Q?r5Tej+Ub20AJok1Th8093N490z6S/pDWIWPq/UZi3bKJ0PC+L7AdDhaazr3n?=
 =?us-ascii?Q?laag5go2YsdppgnpjcGrOAohyVUdoJc+cKdZuqpMITdSlf1Iu8rk9sF+HXA6?=
 =?us-ascii?Q?FMMBDr3/RfV8d7Lcve9DnUKZNzqfCa6lP+KCmdD1dEH3LbBzI6xSz3ZiTVwj?=
 =?us-ascii?Q?0Wi8hgEpdJQk4TL4lmmBuN8QxusCG6T44GJbGU1yXdCXddeJF9oNqHAIprmN?=
 =?us-ascii?Q?znOurkU63oDPaLHEPQ3RroEmCQJc5LAvYzjNJ2n8fZMRiyn6Mda4PVpF2Obd?=
 =?us-ascii?Q?Qa3cmEiMl0DpcaxSmO97aaRUrbkjNbN4ijCw6x5ceKfwb3Zqe2fqduwWLNIe?=
 =?us-ascii?Q?ZNHYsVECcK0pqjCEmn3WPJbt9f3pyKKGW/xLHmzTlmUIN6v9wf+CVgNTNFiB?=
 =?us-ascii?Q?DoIV5xm/E3SQI3llMniOw3VIT6FGcX3gv2x60R8bvdZVkKyVorgTCoJ4FJjn?=
 =?us-ascii?Q?B3HyjKnufVUKxtezhOM9c3YF9d4YwFn6UI46hu5MlRssphyr1sIOJq+eiY+r?=
 =?us-ascii?Q?gInDdhqAmtzjyaBFcePHSHYPMiTtgR2aAOEeyElVoi5cE3mpIzmj/oPjgGkn?=
 =?us-ascii?Q?8Zum9XxJrbcJIsAs/tJBI2HDM+94tKo+AW2j8HAb+7L+wmHnwaOylm3HGTCB?=
 =?us-ascii?Q?ff7BdwXA6rg+S3xQXITM2u8bJ+ajaXHbMdrrP81NBkXU1YYRwUQWd7vyVu/f?=
 =?us-ascii?Q?ysau+QgD1PBFhaZhghGOMrTyUsOvtSrK1vhxdQaVlVpH9ZxxXQ4VR6BjUP+3?=
 =?us-ascii?Q?YJnvFRt98nLWzNzKhEc3n7S9rwjM1a0QlhpQHm69QJ3NhlVg05QLPHIP+bXB?=
 =?us-ascii?Q?O4Fy897boZwDsuRrgWkEpS/2deBDNE02p9JdPA/2LmalklJDQausWNXDsGsW?=
 =?us-ascii?Q?FjcoeMII0r1xAojdYbCujoFurYz11ikPAom9lUA0sG5kZhmJFkXDqKlx+mPH?=
 =?us-ascii?Q?B+BfaSQgojXKSh6gQM/g6C7mtKnHiiLaFpbYN5yVbojkOQq07DI7wjHJrPm8?=
 =?us-ascii?Q?oxmE49Je9Em0SmQIcCj4Ilb5hxGzncA2sM1xevIujZgUContktng9btWb+cl?=
 =?us-ascii?Q?TGpVG+ZTV77bX/SSqJtf69Oeg6T4xrv/rijs+6ompHU5Y6fVqoYMzAKSf6QF?=
 =?us-ascii?Q?+2MhOPInkPvButpg/DwVQWA8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZMclwrSE2bFZ4AfXGrCAfwsgwYn/ohNwubQZIEqDMh3+5pbrDseGV2Q4cFQc?=
 =?us-ascii?Q?JM/Ne5okG94h7tFB8hcI60Uw+IprMdSzIfWLSCOVTZb0OtYsNjHuOwA2aR/K?=
 =?us-ascii?Q?obISIe42FjiX4H+rmo9dV/dpUPP+tVTc6UK4Jk+dXVaTDs5QOoSCNgJ+QMDi?=
 =?us-ascii?Q?l/1iaj+Nm06QbRSKTXtIcdOGpGVP6uYCmrwpUFiaj/YUFEeV0yS+2DDBzuIO?=
 =?us-ascii?Q?cvReN6qev13yOflGPixHasZp7AvTmkBWovtc7SxUp+ife7IhQFAiEd/7sDns?=
 =?us-ascii?Q?Nuu1KQeubmrxec+yt/XmTrwETsp8NTSv2lGVujgUsjmzxK++9qLuu8ke3nOT?=
 =?us-ascii?Q?XgHu4U6C9PzXbmNtz9u/yCcOAOMnOsfMTeC56c+yqx+lY4CKWuzqFBbdIaPJ?=
 =?us-ascii?Q?cClUrep7VaYlW7njkZhwHuvYS8szKoYXsLp1Ed4MNHRSqBlPhTgGfZbxxILx?=
 =?us-ascii?Q?zRCQSGgqdaD8u7pYWdUefe6WZ9Qmb34vfANx0cULwg2DQJcMGsDNS/zli0IA?=
 =?us-ascii?Q?4M/7f03iTey71F4Z5Celz8k1hiCWT1FHHutRj2b/Qf4kLbMcavlC3Qsmpn2S?=
 =?us-ascii?Q?kGj3Hfo4NU54IRwoXALTIRl/ugOfoBFEtl+K5mZrX43+LWOsBa2R/hiumX6Q?=
 =?us-ascii?Q?0Hra8E+JZrS16ldNfodtwry6j6k+iLm8dkEOKrAfTE7aC+mO3DmaIErzYX+y?=
 =?us-ascii?Q?BpT+dW7/FrAazAZZbJmSm2bjv9VC/GTb13RlPnLFQCiY/bPy8VsIIiry0ZjT?=
 =?us-ascii?Q?xsjwYfJHoXU/xsXmtPrvsIGmSd6HEt2ojtjKBDk+bq3OIW2WdAPxqkB2SNL/?=
 =?us-ascii?Q?0yKvXT59fS/gBTeG8X/iOLGiiV7hfwTT08lyXBJzAJ+OzMVbnqq659JL69Mb?=
 =?us-ascii?Q?pT4wz5ISNZzKl9pXtC7jKbfs7YxlZsBT0V9RAZALDauDM6piN74jaa71zu8v?=
 =?us-ascii?Q?9wMGZFGxC63QeBCwSb3sJW/QSLCBSYLKFgZYIesAB2iqQtkDIHZ2OIloP+lM?=
 =?us-ascii?Q?wK9YsG1eNJHwLPqzJc6aFdRJ3b7tgH45vaB57+3A6aSAdOfnhTqAYrAB4L38?=
 =?us-ascii?Q?0f3NmMEX98k2bSJMrxzwpOG0bSM7I1fddsashElJTO2vUrtsQ5FKwvamho7M?=
 =?us-ascii?Q?swWW/uksj3/ZN88TeEqp+MxedvXEH+bsvK4G8ySGhDN94LwDxpgB0NWAi4ex?=
 =?us-ascii?Q?wgsAUo+G75BYpNI3KISOIZ1xRg5+OmunnvOI5M2I7/1Hy+YFDSoSG1rMGtef?=
 =?us-ascii?Q?4ai+6AH5hgTpT5ZEOJB6wx1bhqboNN4LVY/dXWiTomK0AbOIsImfZU/sXO0J?=
 =?us-ascii?Q?weJ3eli08LZgJDfWacSR0TVVxyjRJKaHIeYA3LUFFU6oyUemYrDskwjMkboP?=
 =?us-ascii?Q?BrYK6N5u8WoCtnT8kvUIDvp9czR4mKeKVQJJUUVXBjhqJpjssATpQR/gmloA?=
 =?us-ascii?Q?DzP5rq+fCCLx8m9htpcb5FeijxO2JMsvDHP14+hMgTq9oAA64XcjEoTovh/e?=
 =?us-ascii?Q?63PJciCzByHEgfakcU5VxYBh/S3LC4QoJQci+eZi09TCpgpolSS7YxUn+91O?=
 =?us-ascii?Q?kx9rtAjWMA24oRZy0v4v35rLZH2TFh/ijmwflSKBNGP7HUoUTRRnk5Zzh8Hg?=
 =?us-ascii?Q?cxBYRy6z+Dhn7ZeuWF92InvmHGRAdfCuXsbkWhJMqDCcCBAJVg9ld9htFsFC?=
 =?us-ascii?Q?u6itWw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XMcGcEzevXHGW0u+Q18lVlTnkO/1te7yY7Ki81v7S7z2ljSW5MN6ViGfrmWj3eG9udOqe2SFaFbTq+AQ8afQ1B212DRzlP72WxDei6AWTewcFu17KnNkt5ILMseqlL/l6HPnzI91GET4LfRaTfhG6NWeX6kEjBt+wKfbFw4dvGht/fVItrNh6wFqhl+IfDtCCc1i4nbTePljjCSMFymg8njoIMwqlEtCr6kaXrMsVZXicCELgZSeoPeMfO5gsU+0UEoz0VcLymz9HCKdHJSduHgM1zd40vLEd1utj0KmxQbwCWMWnrSK1k0QtHe3gw/8QVIsnFYvGVfxzXTrFo1aZq5n7jSFDzPVUR7mx7ItcZCxNEf84dGG9UgnRIsWkK8ZcJ+bmo3Dx3wmG3AyHhh43GjZmj4WHBHgIdFJmAYgaEdJ7hEwlf4B56l8P3Cwc6NG4IJYytBsdcmnRMkNb2MQnUvstkKZASaHm7+12bAHEmi/gJE5EUTdANYvZM+1AaTu8hkWL4Si8q7dqP+0dewKxXg6UN4PhJBuzh3ukO9kfHas4cnXlsodeK8x0DCUBVo/6hwrB+Cv4Zy2LuIw0ckCN7iPy5EqGHDwr2zCwf8CB+U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3472c355-4a57-47b1-8f4c-08dcf3a2b199
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 20:38:47.3232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vgHLkFlRnjQEd3JjnGOExvyxFCVlpE701xpil3ewu0Co951LYDNOj9pxtcZfeiMyj+eosufN+G86c8fEtMJV0dLgVsi41E0XXKDrqVPcqaU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5833
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-23_16,2024-10-23_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 mlxscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410230132
X-Proofpoint-ORIG-GUID: 08C2_PfjRO6HiQmQsmwc_xlZA8d2jup5
X-Proofpoint-GUID: 08C2_PfjRO6HiQmQsmwc_xlZA8d2jup5

The mmap_region() function is somewhat terrifying, with spaghetti-like
control flow and numerous means by which issues can arise and incomplete
state, memory leaks and other unpleasantness can occur.

A large amount of the complexity arises from trying to handle errors late
in the process of mapping a VMA, which forms the basis of recently observed
issues with resource leaks and observable inconsistent state.

This series goes to great lengths to simplify how mmap_region() works and
to avoid unwinding errors late on in the process of setting up the VMA for
the new mapping, and equally avoids such operations occurring while the VMA
is in an inconsistent state.

The first four patches are intended for backporting to correct the
possibility of people encountering corrupted state while invoking mmap()
which is otherwise at risk of happening.

After this we go further, refactoring the code, placing it in mm/vma.c in
order to make it eventually userland testable, and significantly
simplifying the logic to avoid this issue arising in future.

v2:
* Marked first 4 patches as hotfixes, the rest as not.
* Improved comment in vma_close() as per Vlastiml.
* Updated hole byte count as per Jann.
* Updated comment in map_deny_write_exec() as per Jann.
* Dropped unnecessary vma_iter_free() as per Vlastmil, Liam.
* Corrected vms_abort_munmap_vmas() mistaken assumption about nr_pages as
  per Vlasitmil.
* Changed order of initial checks in mmap_region() to avoid user-visible
  side effects as per Vmastlil, Liam.
* Corrected silly incorrect use of vma field.
* Various style corrects as per Liam.
* Fix horrid mistake with merge VMA, reworked the logic to avoid that
  nonsense altogether.
* Add fields to map state rather than using vmg fields to avoid
  confusion/risk of vmg state changing breaking things.
* Replaced last commit removing merge retry with one that retries the
  merge, only sanely.

v1:
https://lore.kernel.org/all/cover.1729628198.git.lorenzo.stoakes@oracle.com/

Lorenzo Stoakes (8):
  mm: avoid unsafe VMA hook invocation when error arises on mmap hook
  mm: unconditionally close VMAs on error
  mm: refactor map_deny_write_exec()
  mm: resolve faulty mmap_region() error path behaviour
  tools: testing: add additional vma_internal.h stubs
  mm: isolate mmap internal logic to mm/vma.c
  mm: refactor __mmap_region()
  mm: defer second attempt at merge on mmap()

 include/linux/mman.h             |  21 +-
 mm/internal.h                    |  45 ++++
 mm/mmap.c                        | 262 ++-----------------
 mm/mprotect.c                    |   2 +-
 mm/nommu.c                       |   7 +-
 mm/vma.c                         | 435 ++++++++++++++++++++++++++++++-
 mm/vma.h                         | 103 +-------
 mm/vma_internal.h                |   5 +
 tools/testing/vma/vma_internal.h | 115 +++++++-
 9 files changed, 634 insertions(+), 361 deletions(-)

--
2.47.0

