Return-Path: <linux-kernel+bounces-309304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C857C9668B7
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 20:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CF871F2337C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 18:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD7061BDA88;
	Fri, 30 Aug 2024 18:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kL73vxjq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZJgNlviu"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904A11BD034
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 18:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725041463; cv=fail; b=Dz/OL5Prd47U4cDhcUW/r47zYdpGx48ZUWcXld/YkyrGMQ4t70eHP1n93opwV6G3J+yiGa8jb29fXayKzeDBLbJ4hhTnzbppcjQLAPGSgVcwhig+tzgcBiUrfJNFcKmg1NmnQ8A1WOOBz+8NbWijCZT0QvLslL0BB2pUIdFYncA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725041463; c=relaxed/simple;
	bh=DU6yVNU0Ir2CjwTHkQVirVtVQQxRr1VKtkyyhTWCz6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lw9GlYLCz14MlAW4Lg6d95W0Qz6d80K4mZemHUOAex8ac2Tz5RY8bRS24R82dLTsKuOjbNUoAy7bH2lqLY/WUacn3tztaNILHyFuTdZjnAJXz0TlM2NMVYDmVaRQ1JyyO+NTLgIj+7ipRVls6JdCILIPgDa25vxCw3JuIbaopjs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kL73vxjq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZJgNlviu; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47UI38SD025963;
	Fri, 30 Aug 2024 18:10:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=vb4pbELSREq7Y+qtxTDLKKzNtKzGl0XNez0D1ELx3TI=; b=
	kL73vxjqDo0yNLh/MQD6WlNKpmqGdzhCiz3fyX1+QlJfAFVir4D04BtiFkowT0Q5
	hklK+4Ew++9xZUzhm9jO/Gl8M+M0Aj7atGjpiBCDU80ADnOb1aZ0a8bLM08EXRsI
	StRK4k1mcucByjh72smsjm2UgZlezZjXtEhIaUeDBiheyILdpXXOygw3lJYKpNIE
	kNAVHj221yBgpoe3MqpHRTmtssgQLIIyqUDG4hJLHTPGXrSfAkEEoDwHIJTOXT+A
	u551Nkn+9keSDNyY0ywcWeNBN3MIE1lXIiwE3x2AvxMqaOlODgFHcZDYxlClkCOG
	NKWUffzHnI7DSIOEJR80Mw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 419pugycbb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 18:10:49 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47UHnTbF034680;
	Fri, 30 Aug 2024 18:10:48 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4189sxqdbd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 18:10:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qkoi4KwXLdwMVjJRdWWiqhaFCdwWNmuyUfLhHv8/2gewNx9/dMfHBJHE4doEu8tHmlWCwcyd7VnKsy9IRzio7kJFaANy+Qi4bXRrZJ1YK+geDD51joRGpQpCy5u3CQtw7yx755SzBOfwKwt8j2/X+lQZuxqtsQnHhc/lKTqk/NO1waO0cqw/p/n/nJaUcJ4YwCwv5ftj55eUh5BX07K2VaZgQFFXzuk20Uj8ByhkG7eCRnmuVBnY2YXZz90WHGbcB9UgsJQ/ptds8pbKopJG8stwmrJOM6Ue9bk+aZdyTna2Xe6ZrjsbnR8Nx+c1/pur5K1Z0bFjekg/IUhM9C7mCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vb4pbELSREq7Y+qtxTDLKKzNtKzGl0XNez0D1ELx3TI=;
 b=rnipDDWOrSoS/11OvL7Q9h1gboAQJ2oNtepjxIaruBdyk2m1wLqcVpWZKxEhsxFW7/43xiDi28xiTF1Vb2wfdSy+6omSm1tPWNlmw3cdgkUF2I50yLghlmECAw1ZxUhpJcLfVYOl/c47gpBbAJtFF9QQLhLV8l8bwbe8N+08u9Zq0Zd/o4Mpx9jMZwrjGCbMbs0kqx5aX3BpeQzPmSsG+dbmIFxQYuMIk+ZnWkWYvgXqrnForbNYDk+/JS1yrk9s22WoSemOkEjeQ1TzWKjAOkCS5iBw9t74rvRDZrhLNTJDCHWrS0yFprksFalhV4UIcO/BYJh54OuIgX/wkLVvdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vb4pbELSREq7Y+qtxTDLKKzNtKzGl0XNez0D1ELx3TI=;
 b=ZJgNlviuoRMbA/vCNve5xPF3imSTlLAWpsQAjE5+CBUEfdFFBN2wg8nGAv74ojDbxagHhphDPdBd1aa4vtRPO9SFA6opVAR7iTPHgprd9gDiBb4Q2s1kf9uNBQHgCkSICGpx0vrs4/3NJcKt1hdbG1MaGmpPf/fxoWnVrKu49xc=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by DS0PR10MB7151.namprd10.prod.outlook.com (2603:10b6:8:dd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 18:10:45 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 18:10:45 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 06/10] mm: avoid using vma_merge() for new VMAs
Date: Fri, 30 Aug 2024 19:10:18 +0100
Message-ID: <49d37c0769b6b9dc03b27fe4d059173832556392.1725040657.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1725040657.git.lorenzo.stoakes@oracle.com>
References: <cover.1725040657.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0603.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:295::19) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|DS0PR10MB7151:EE_
X-MS-Office365-Filtering-Correlation-Id: 7383b22f-b6c2-42b6-f1f3-08dcc91f117a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KZiV6GNrBkvw3qu2YRohA8Z36Tyztj0/SGE2WHgcXtlmoNy6ZeWR2fhp15Te?=
 =?us-ascii?Q?8Ohd1jR4+x4Eg7pSiD7BCNjYqbtAbm1yw59/nYDPhcZGhoNHBpceRPW2NDJB?=
 =?us-ascii?Q?1m/tATXKDAQhHF0ZIJ8w6X8Hi1wkNFkHxI7Kr3ir49i/E/ad5Y39KhJo5MS4?=
 =?us-ascii?Q?Wr9jc5VfGdUZz4Y/9CPOeSGvIG5U4/SgiYIsfDIwPj/rF/lzEqtLi9pygi2H?=
 =?us-ascii?Q?bWU2bXCl23+fe7GJITEgL1dAULPGdU/f0Y5Kiv+Y6sjRgQ6/Ge5c36f/8W4t?=
 =?us-ascii?Q?VXqSz4eRkqc+vl2lmx+X74j/vOG3cmBpkEcf7GRQeAoOyodVAs0mhpuky0wY?=
 =?us-ascii?Q?IPCsZdmaKezBC5L0pKxJ1CY2omZOIx8XESxBSYiF62xgoub7NxASBvnmfrPy?=
 =?us-ascii?Q?KE5ZwCGA+OKZ7EQ/aj3uwFXWR8ZeeTZMyGjOk/FdRM3v3/uWsQTzv9dKIsFV?=
 =?us-ascii?Q?vFTCwLmc4oPJYXSU7uA7SbHAVrNmDrEjZm6cNxNrN/IxpVQ0kKwdUA17mFVX?=
 =?us-ascii?Q?pZXP1d2RGKivgmB7Kte7OKnr4PUpNXApWDo/ulLcQYlgbJqKBPsjrv0lUepa?=
 =?us-ascii?Q?aEFzZUTzyinrIqURsf9QNQiRStfIZmCUXX+VmyFLEezihtnJE6YxD8UXAswx?=
 =?us-ascii?Q?XDSV4Q1BoLA85VWCsrqrib4sccOOwaU9C7HPm7YnoUBD2oFVGLKDDGY/EknU?=
 =?us-ascii?Q?iDjXlaPEgtJkTie66w/O7+7ai2Q9g4KrQe0gxc/GSDvwLoX5hd6ZWuV4eUlR?=
 =?us-ascii?Q?i1SGBeC8c9VSAtgo2nlHSojaT4mP08WsQ5hXKKPvoMdNx19oGmeOnzCH20qw?=
 =?us-ascii?Q?uJfTIY2ky8AS/HvC4CyV5wXuK4lkaJ8wmDizBgAOnrh+2UhtR0koi9wCMWCz?=
 =?us-ascii?Q?PtLb0hs6NZ8xrnvNTw9Hv/JkPdYQ9/Zf93cWnYhF4HnM8rn/jr70L74pOPID?=
 =?us-ascii?Q?Lecj/vOz1omLjd5U7Ux8u+89ukTNtmF9EcQ7qjF/xmbBr29AdINHS1M8fomx?=
 =?us-ascii?Q?BMMutHfR8tFatp0sWnOTNYQ9PDi6TmsWgchy8dxVUYdgFQqzWyGoIvPePPX5?=
 =?us-ascii?Q?Q+onsL+VrdIpKpw7UtyPbBxfeunQaWM3FcCBU3XFBpXh/j50zv/I8y9eEBuJ?=
 =?us-ascii?Q?qkYIgrxgv0mTyDe3Y8O1GF6iKyIGxVEPBek5vfkXU+osuYIRkpwA72T14Tgj?=
 =?us-ascii?Q?vgLgbLdqO1WmmZslVXB366ULxSV4fTu2xIfUFmIu48xybsjnnTjoqMaKP/n0?=
 =?us-ascii?Q?j6Zs+aBb/g599NgJhUG4Hujo48lbkWQ4JD5LT7X9KOuVGUFCNGFj7q7TJHIu?=
 =?us-ascii?Q?B/0TRR9gxLxKLt5Md+Ct+f8N5U/XueTATP3nYdSAMMIbsQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QYNvkNjgpQFGFlyPGEMADCYZdKIkx5GXq4XwwwJutOYvAXzu9yz+Y5wCikT+?=
 =?us-ascii?Q?J9F4IEUi3ytOuumrAdyjmu0PqkK/DwuOElQd+eFy2WwaDQFDiMDFUhqKcPA8?=
 =?us-ascii?Q?jWuYcrW5qVtIYbP4ZZOg4Mp82Dfk+LfcgeIPKOKkqpPu6xMTXf8AHdOMBzr5?=
 =?us-ascii?Q?2ygJfSNKeK7gWWfMWky+Gyj/BjyC267sT1k96MsAvYV2opZ6Ccaj817n031V?=
 =?us-ascii?Q?K16dDgKgSm6iTyVPnY8N7enSYRaEjpI0bHYLazVcbEXtBS6WwKXurp7n3vkh?=
 =?us-ascii?Q?Hd37x8oOxq09xolfZfTgIaHLYk25jSUCdbeTCxI8UgI885cVQr5brPHzK1qz?=
 =?us-ascii?Q?3jDCxWsY4AOJpavO8MREm9f1O/h7+QfshkfScEJuueSFXrISUs4hAFv+3Raf?=
 =?us-ascii?Q?AwsCH3ys7HNxAUpQ4lzy+JXOe9epRnPOEtD0L1qkS7agJD2Hzp0c0KXbNqiv?=
 =?us-ascii?Q?luWmXALIrIEIRJeQNU6ED//dTX7ajjeV5htklDpZu/2x5BhENoKigrcI1GdO?=
 =?us-ascii?Q?UcG/lRIcXykTj1qsKZGd3OP2Z0aB8YWEVq90k9ZMAM/AHiFfA4dZRlJmQg1x?=
 =?us-ascii?Q?2qqUMmUUSig4W2/PIGfZLfzhjwZd05mFMJbQjVoz+QwJPqajRfZvQ48wAcIv?=
 =?us-ascii?Q?siiS+RDoG0Br55xjqYT3RfaRJgby2EFMJ5fTI8jFkGz7Zoe+3SNXzDtWqBGJ?=
 =?us-ascii?Q?meAgc77lejOuavq9fGxalNFI85yBlVRXIVBudu03L7rgPzfgsRLxVueziXfR?=
 =?us-ascii?Q?um/ICsERM8MONN4VRIb+cZ6olby8t/FKTklWIeF+mXljCEcmqOPeLpY0xyMx?=
 =?us-ascii?Q?BfS0Xe3iuOntiAisjSEovHkWZOliVRAdH15ooqK5rcVsxRgNeC1ENymCjcM6?=
 =?us-ascii?Q?h2+5cBeEZdyQlEv2+E0oLi77I8cSezmaO6BVQ4spauftQnOZR8zTMhx2zGje?=
 =?us-ascii?Q?GyFyRgtVpeQIRTdKtEV0YEHsrPl5vsrAhQ2wcjFF7MfKyzI04NoPV0+30eHY?=
 =?us-ascii?Q?ApBfafIJmpUpm/Q+5Qf7FD4kviqVPjFaCWUvoyDdwuZCNujeSzJUihUvXLK6?=
 =?us-ascii?Q?oPwqrcrxVlRRurLokk4x598lRX+nsXLxPOmfoFXtoOlSYSJnmFlfNWtOXfIR?=
 =?us-ascii?Q?UffuXGILPPCA2d3FJWIti5LkSsS5y4V5lk1QQ88i5+2ErYk5j8DtEnhHMuQ2?=
 =?us-ascii?Q?5whNOXPQY6149f9JYZHZgzf/WIVqjOogE2k8rzaA4wQyuVtsnttEjot90fGe?=
 =?us-ascii?Q?wvNahMpn4urLML7Xe17rBU+m94g50j8h9nkLKn0ElWjuZMHlY8TjVVqURvDj?=
 =?us-ascii?Q?DDiub8V9XruwwUwWjGRmV/a29vOWtW7MVS1/CqS81nYqwxUhYCh6+2ksSmcQ?=
 =?us-ascii?Q?YRzDVxP1tSrl4KVLCfpRO5xJzJx8ehAtQ0pU2gu/w+JKc0khChPeYXix2sG9?=
 =?us-ascii?Q?tLRCaInRAAD4DYvgpxVr1ShVKz1eHEMv9yFFvNyy09Wnt+lyCxZf5NYx4zUQ?=
 =?us-ascii?Q?XcFZ4lmn4SjvzrtQpcNTXlY26qFlvtld6wIrXN64Jq2A36d3Ul18gF6hcYSV?=
 =?us-ascii?Q?BgAkj1GxPriz/fvomTWNQm/Nt8u5Hc0nqeUIFzvo/7xGaAaHMl1zdybW9jpU?=
 =?us-ascii?Q?HQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	N0X6Oqg5WgOCKiJeamw7CE1tN7FGDGPiU4ro4AAjtlFtaSak4751cpqzc7nOW4ac7lACiKbW2ClLqqJB3JACBBNjdzV2Bzgd4lMS9PDP8RDdxrYs6XO6UPmMRs4emNI6dWW+BB4rYPB3IhOlPUbhvwrUaHJql2/mxGmh6ph31Q1BIe2k8x0oXfXBwUQz7cfia4bqCW7DzFMaX/utGnYQ95mxs08++fCR74z4Xofc0/RgoeUtI+OOUzPRY2wM+ZG7fjAqY5L+f+W7IKhzjLvkV8MF7AKZcycV8+eFwYOIDQd8VZlOr4R+drD9Mm2cUbD5Iyx1Mwq8LiIHRoonPjum4ELvih9SYR+RuVDtNg7WlnJojyfHrDXvef3JVYqwkZtRSEnz7CLsG7EL8a8UZtL8v9Pkun4xjJQ5yh7iKW5I07RTw306Sh7zzFXvoFdDtdkxbsQ5LkTYIkFi4m1LN99s/1f8WlczKCdAveyi1j8N99etwr0vnbnIqUkNQjAJJkXaKVfWQz9HSy24ykzYVtOcs+P6eViD2aHD8G5cwZwd9jLf+nIAxZu2I17vLtydGyo4DbJ0sI/9+CAi/ZEAXXR+kRWGnPN95iyWhqIAObyEjLw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7383b22f-b6c2-42b6-f1f3-08dcc91f117a
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 18:10:45.6373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WOICE5cmXkCrzFBgcxtu03BoYuZohw2pwQiL1U3h9u9SXbEMOG1ZPmm3+PRjkf0aDK+ykbIVLvg60XtN1HQemvBGXEFcsSuRk1fqyfUh+Qw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7151
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_10,2024-08-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408300138
X-Proofpoint-GUID: xLKB-M7ChbuqOUL20xH4lFrNjv4klOkI
X-Proofpoint-ORIG-GUID: xLKB-M7ChbuqOUL20xH4lFrNjv4klOkI

Abstract vma_merge_new_vma() to use vma_merge_struct and rename the
resultant function vma_merge_new_range() to be clear what the purpose of
this function is - a new VMA is desired in the specified range, and we wish
to see if it is possible to 'merge' surrounding VMAs into this range rather
than having to allocate a new VMA.

Note that this function uses vma_extend() exclusively, so adopts its
requirement that the iterator point at or before the gap. We add an assert
to this effect.

This is as opposed to vma_merge_existing_range(), which will be introduced
in a subsequent commit, and provide the same functionality for cases in
which we are modifying an existing VMA.

In mmap_region() and do_brk_flags() we open code scenarios where we prefer
to use vma_expand() rather than invoke a full vma_merge() operation.

Abstract this logic and eliminate all of the open-coding, and also use the
same logic for all cases where we add new VMAs to, rather than ultimately
use vma_merge(), rather use vma_expand().

Doing so removes duplication and simplifies VMA merging in all such cases,
laying the ground for us to eliminate the merging of new VMAs in
vma_merge() altogether.

Also add the ability for the vmg to track state, and able to report errors,
allowing for us to differentiate a failed merge from an inability to
allocate memory in callers.

This makes it far easier to understand what is happening in these cases
avoiding confusion, bugs and allowing for future optimisation.

Also introduce vma_iter_next_rewind() to allow for retrieval of the next,
and (optionally) the prev VMA, rewinding to the start of the previous gap.

Introduce are_anon_vmas_compatible() to abstract individual VMA anon_vma
comparison for the case of merging on both sides where the anon_vma of the
VMA being merged maybe compatible with prev and next, but prev and next's
anon_vma's may not be compatible with each other.

Finally also introduce can_vma_merge_left() / can_vma_merge_right() to
check adjacent VMA compatibility and that they are indeed adjacent.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Tested-by: Mark Brown <broonie@kernel.org>
---
 mm/mmap.c                        |  92 ++++----------
 mm/vma.c                         | 200 +++++++++++++++++++++++++++----
 mm/vma.h                         |  48 +++++++-
 tools/testing/vma/vma.c          |  33 ++++-
 tools/testing/vma/vma_internal.h |   6 +
 5 files changed, 279 insertions(+), 100 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 2b3006efd3fb..02f7b45c3076 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1364,8 +1364,8 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 {
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma = NULL;
-	struct vm_area_struct *next, *prev, *merge;
 	pgoff_t pglen = PHYS_PFN(len);
+	struct vm_area_struct *merge;
 	unsigned long charged = 0;
 	struct vma_munmap_struct vms;
 	struct ma_state mas_detach;
@@ -1389,14 +1389,11 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		if (error)
 			goto gather_failed;
 
-		next = vmg.next = vms.next;
-		prev = vmg.prev = vms.prev;
+		vmg.next = vms.next;
+		vmg.prev = vms.prev;
 		vma = NULL;
 	} else {
-		next = vmg.next = vma_next(&vmi);
-		prev = vmg.prev = vma_prev(&vmi);
-		if (prev)
-			vma_iter_next_range(&vmi);
+		vmg.next = vma_iter_next_rewind(&vmi, &vmg.prev);
 	}
 
 	/* Check against address space limit. */
@@ -1417,46 +1414,9 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		vmg.flags = vm_flags;
 	}
 
-	if (vm_flags & VM_SPECIAL)
-		goto cannot_expand;
-
-	/* Attempt to expand an old mapping */
-	/* Check next */
-	if (next && next->vm_start == end && can_vma_merge_before(&vmg)) {
-		vmg.end = next->vm_end;
-		vma = vmg.vma = next;
-		vmg.pgoff = next->vm_pgoff - pglen;
-		/*
-		 * We set this here so if we will merge with the previous VMA in
-		 * the code below, can_vma_merge_after() ensures anon_vma
-		 * compatibility between prev and next.
-		 */
-		vmg.anon_vma = vma->anon_vma;
-		vmg.uffd_ctx = vma->vm_userfaultfd_ctx;
-	}
-
-	/* Check prev */
-	if (prev && prev->vm_end == addr && can_vma_merge_after(&vmg)) {
-		vmg.start = prev->vm_start;
-		vma = vmg.vma = prev;
-		vmg.pgoff = prev->vm_pgoff;
-		vma_prev(&vmi); /* Equivalent to going to the previous range */
-	}
-
-	if (vma) {
-		/* Actually expand, if possible */
-		if (!vma_expand(&vmg)) {
-			khugepaged_enter_vma(vma, vm_flags);
-			goto expanded;
-		}
-
-		/* If the expand fails, then reposition the vma iterator */
-		if (unlikely(vma == prev))
-			vma_iter_set(&vmi, addr);
-	}
-
-cannot_expand:
-
+	vma = vma_merge_new_range(&vmg);
+	if (vma)
+		goto expanded;
 	/*
 	 * Determine the object being mapped and call the appropriate
 	 * specific mapper. the address has already been validated, but
@@ -1503,10 +1463,11 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		 * If vm_flags changed after call_mmap(), we should try merge
 		 * vma again as we may succeed this time.
 		 */
-		if (unlikely(vm_flags != vma->vm_flags && prev)) {
-			merge = vma_merge_new_vma(&vmi, prev, vma,
-						  vma->vm_start, vma->vm_end,
-						  vma->vm_pgoff);
+		if (unlikely(vm_flags != vma->vm_flags && vmg.prev)) {
+			vmg.flags = vma->vm_flags;
+			/* If this fails, state is reset ready for a reattempt. */
+			merge = vma_merge_new_range(&vmg);
+
 			if (merge) {
 				/*
 				 * ->mmap() can change vma->vm_file and fput
@@ -1522,6 +1483,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 				vm_flags = vma->vm_flags;
 				goto unmap_writable;
 			}
+			vma_iter_config(&vmi, addr, end);
 		}
 
 		vm_flags = vma->vm_flags;
@@ -1554,7 +1516,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	vma_link_file(vma);
 
 	/*
-	 * vma_merge() calls khugepaged_enter_vma() either, the below
+	 * vma_merge_new_range() calls khugepaged_enter_vma() too, the below
 	 * call covers the non-merge case.
 	 */
 	khugepaged_enter_vma(vma, vma->vm_flags);
@@ -1609,7 +1571,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 
 		vma_iter_set(&vmi, vma->vm_end);
 		/* Undo any partial mapping done by a device driver. */
-		unmap_region(&vmi.mas, vma, prev, next);
+		unmap_region(&vmi.mas, vma, vmg.prev, vmg.next);
 	}
 	if (writable_file_mapping)
 		mapping_unmap_writable(file->f_mapping);
@@ -1756,7 +1718,6 @@ static int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		unsigned long addr, unsigned long len, unsigned long flags)
 {
 	struct mm_struct *mm = current->mm;
-	struct vma_prepare vp;
 
 	/*
 	 * Check against address space limits by the changed size
@@ -1780,25 +1741,12 @@ static int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		VMG_STATE(vmg, mm, vmi, addr, addr + len, flags, PHYS_PFN(addr));
 
 		vmg.prev = vma;
-		if (can_vma_merge_after(&vmg)) {
-			vma_iter_config(vmi, vma->vm_start, addr + len);
-			if (vma_iter_prealloc(vmi, vma))
-				goto unacct_fail;
-
-			vma_start_write(vma);
-
-			init_vma_prep(&vp, vma);
-			vma_prepare(&vp);
-			vma_adjust_trans_huge(vma, vma->vm_start, addr + len, 0);
-			vma->vm_end = addr + len;
-			vm_flags_set(vma, VM_SOFTDIRTY);
-			vma_iter_store(vmi, vma);
-
-			vma_complete(&vp, vmi, mm);
-			validate_mm(mm);
-			khugepaged_enter_vma(vma, flags);
+		vma_iter_next_range(vmi);
+
+		if (vma_merge_new_range(&vmg))
 			goto out;
-		}
+		else if (vmg_nomem(&vmg))
+			goto unacct_fail;
 	}
 
 	if (vma)
diff --git a/mm/vma.c b/mm/vma.c
index d1033dade70e..749c4881fd60 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -55,6 +55,13 @@ static inline bool is_mergeable_anon_vma(struct anon_vma *anon_vma1,
 	return anon_vma1 == anon_vma2;
 }
 
+/* Are the anon_vma's belonging to each VMA compatible with one another? */
+static inline bool are_anon_vmas_compatible(struct vm_area_struct *vma1,
+					    struct vm_area_struct *vma2)
+{
+	return is_mergeable_anon_vma(vma1->anon_vma, vma2->anon_vma, NULL);
+}
+
 /*
  * init_multi_vma_prep() - Initializer for struct vma_prepare
  * @vp: The vma_prepare struct
@@ -130,6 +137,44 @@ bool can_vma_merge_after(struct vma_merge_struct *vmg)
 	return false;
 }
 
+/*
+ * Can the proposed VMA be merged with the left (previous) VMA taking into
+ * account the start position of the proposed range.
+ */
+static bool can_vma_merge_left(struct vma_merge_struct *vmg)
+
+{
+	return vmg->prev && vmg->prev->vm_end == vmg->start &&
+		can_vma_merge_after(vmg);
+}
+
+/*
+ * Can the proposed VMA be merged with the right (next) VMA taking into
+ * account the end position of the proposed range.
+ *
+ * In addition, if we can merge with the left VMA, ensure that left and right
+ * anon_vma's are also compatible.
+ */
+static bool can_vma_merge_right(struct vma_merge_struct *vmg,
+				bool can_merge_left)
+{
+	if (!vmg->next || vmg->end != vmg->next->vm_start ||
+	    !can_vma_merge_before(vmg))
+		return false;
+
+	if (!can_merge_left)
+		return true;
+
+	/*
+	 * If we can merge with prev (left) and next (right), indicating that
+	 * each VMA's anon_vma is compatible with the proposed anon_vma, this
+	 * does not mean prev and next are compatible with EACH OTHER.
+	 *
+	 * We therefore check this in addition to mergeability to either side.
+	 */
+	return are_anon_vmas_compatible(vmg->prev, vmg->next);
+}
+
 /*
  * Close a vm structure and free it.
  */
@@ -464,6 +509,111 @@ void validate_mm(struct mm_struct *mm)
 }
 #endif /* CONFIG_DEBUG_VM_MAPLE_TREE */
 
+/*
+ * vma_merge_new_range - Attempt to merge a new VMA into address space
+ *
+ * @vmg: Describes the VMA we are adding, in the range @vmg->start to @vmg->end
+ *       (exclusive), which we try to merge with any adjacent VMAs if possible.
+ *
+ * We are about to add a VMA to the address space starting at @vmg->start and
+ * ending at @vmg->end. There are three different possible scenarios:
+ *
+ * 1. There is a VMA with identical properties immediately adjacent to the
+ *    proposed new VMA [@vmg->start, @vmg->end) either before or after it -
+ *    EXPAND that VMA:
+ *
+ * Proposed:       |-----|  or  |-----|
+ * Existing:  |----|                  |----|
+ *
+ * 2. There are VMAs with identical properties immediately adjacent to the
+ *    proposed new VMA [@vmg->start, @vmg->end) both before AND after it -
+ *    EXPAND the former and REMOVE the latter:
+ *
+ * Proposed:       |-----|
+ * Existing:  |----|     |----|
+ *
+ * 3. There are no VMAs immediately adjacent to the proposed new VMA or those
+ *    VMAs do not have identical attributes - NO MERGE POSSIBLE.
+ *
+ * In instances where we can merge, this function returns the expanded VMA which
+ * will have its range adjusted accordingly and the underlying maple tree also
+ * adjusted.
+ *
+ * Returns: In instances where no merge was possible, NULL. Otherwise, a pointer
+ *          to the VMA we expanded.
+ *
+ * This function adjusts @vmg to provide @vmg->next if not already specified,
+ * and adjusts [@vmg->start, @vmg->end) to span the expanded range.
+ *
+ * ASSUMPTIONS:
+ * - The caller must hold a WRITE lock on the mm_struct->mmap_lock.
+ * - The caller must have determined that [@vmg->start, @vmg->end) is empty,
+     other than VMAs that will be unmapped should the operation succeed.
+ * - The caller must have specified the previous vma in @vmg->prev.
+ * - The caller must have specified the next vma in @vmg->next.
+ * - The caller must have positioned the vmi at or before the gap.
+ */
+struct vm_area_struct *vma_merge_new_range(struct vma_merge_struct *vmg)
+{
+	struct vm_area_struct *prev = vmg->prev;
+	struct vm_area_struct *next = vmg->next;
+	unsigned long start = vmg->start;
+	unsigned long end = vmg->end;
+	pgoff_t pgoff = vmg->pgoff;
+	pgoff_t pglen = PHYS_PFN(end - start);
+	bool can_merge_left, can_merge_right;
+
+	mmap_assert_write_locked(vmg->mm);
+	VM_WARN_ON(vmg->vma);
+	/* vmi must point at or before the gap. */
+	VM_WARN_ON(vma_iter_addr(vmg->vmi) > end);
+
+	vmg->state = VMA_MERGE_NOMERGE;
+
+	/* Special VMAs are unmergeable, also if no prev/next. */
+	if ((vmg->flags & VM_SPECIAL) || (!prev && !next))
+		return NULL;
+
+	can_merge_left = can_vma_merge_left(vmg);
+	can_merge_right = can_vma_merge_right(vmg, can_merge_left);
+
+	/* If we can merge with the next VMA, adjust vmg accordingly. */
+	if (can_merge_right) {
+		vmg->end = next->vm_end;
+		vmg->vma = next;
+		vmg->pgoff = next->vm_pgoff - pglen;
+	}
+
+	/* If we can merge with the previous VMA, adjust vmg accordingly. */
+	if (can_merge_left) {
+		vmg->start = prev->vm_start;
+		vmg->vma = prev;
+		vmg->pgoff = prev->vm_pgoff;
+
+		vma_prev(vmg->vmi); /* Equivalent to going to the previous range */
+	}
+
+	/*
+	 * Now try to expand adjacent VMA(s). This takes care of removing the
+	 * following VMA if we have VMAs on both sides.
+	 */
+	if (vmg->vma && !vma_expand(vmg)) {
+		khugepaged_enter_vma(vmg->vma, vmg->flags);
+		vmg->state = VMA_MERGE_SUCCESS;
+		return vmg->vma;
+	}
+
+	/* If expansion failed, reset state. Allows us to retry merge later. */
+	vmg->vma = NULL;
+	vmg->start = start;
+	vmg->end = end;
+	vmg->pgoff = pgoff;
+	if (vmg->vma == prev)
+		vma_iter_set(vmg->vmi, start);
+
+	return NULL;
+}
+
 /*
  * vma_expand - Expand an existing VMA
  *
@@ -474,7 +624,11 @@ void validate_mm(struct mm_struct *mm)
  * vmg->next->vm_end.  Checking if the vmg->vma can expand and merge with
  * vmg->next needs to be handled by the caller.
  *
- * Returns: 0 on success
+ * Returns: 0 on success.
+ *
+ * ASSUMPTIONS:
+ * - The caller must hold a WRITE lock on vmg->vma->mm->mmap_lock.
+ * - The caller must have set @vmg->vma and @vmg->next.
  */
 int vma_expand(struct vma_merge_struct *vmg)
 {
@@ -484,6 +638,8 @@ int vma_expand(struct vma_merge_struct *vmg)
 	struct vm_area_struct *next = vmg->next;
 	struct vma_prepare vp;
 
+	mmap_assert_write_locked(vmg->mm);
+
 	vma_start_write(vma);
 	if (next && (vma != next) && (vmg->end == next->vm_end)) {
 		int ret;
@@ -516,6 +672,7 @@ int vma_expand(struct vma_merge_struct *vmg)
 	return 0;
 
 nomem:
+	vmg->state = VMA_MERGE_ERROR_NOMEM;
 	if (anon_dup)
 		unlink_anon_vmas(anon_dup);
 	return -ENOMEM;
@@ -1029,6 +1186,8 @@ static struct vm_area_struct *vma_merge(struct vma_merge_struct *vmg)
 	pgoff_t pglen = PHYS_PFN(end - addr);
 	long adj_start = 0;
 
+	vmg->state = VMA_MERGE_NOMERGE;
+
 	/*
 	 * We later require that vma->vm_flags == vm_flags,
 	 * so this tests vma->vm_flags & VM_SPECIAL, too.
@@ -1180,13 +1339,19 @@ static struct vm_area_struct *vma_merge(struct vma_merge_struct *vmg)
 	vma_complete(&vp, vmg->vmi, mm);
 	validate_mm(mm);
 	khugepaged_enter_vma(res, vmg->flags);
+
+	vmg->state = VMA_MERGE_SUCCESS;
 	return res;
 
 prealloc_fail:
+	vmg->state = VMA_MERGE_ERROR_NOMEM;
 	if (anon_dup)
 		unlink_anon_vmas(anon_dup);
 
 anon_vma_fail:
+	if (err == -ENOMEM)
+		vmg->state = VMA_MERGE_ERROR_NOMEM;
+
 	vma_iter_set(vmg->vmi, addr);
 	vma_iter_load(vmg->vmi);
 	return NULL;
@@ -1293,22 +1458,6 @@ struct vm_area_struct
 	return vma_modify(&vmg);
 }
 
-/*
- * Attempt to merge a newly mapped VMA with those adjacent to it. The caller
- * must ensure that [start, end) does not overlap any existing VMA.
- */
-struct vm_area_struct
-*vma_merge_new_vma(struct vma_iterator *vmi, struct vm_area_struct *prev,
-		   struct vm_area_struct *vma, unsigned long start,
-		   unsigned long end, pgoff_t pgoff)
-{
-	VMG_VMA_STATE(vmg, vmi, prev, vma, start, end);
-
-	vmg.pgoff = pgoff;
-
-	return vma_merge(&vmg);
-}
-
 /*
  * Expand vma by delta bytes, potentially merging with an immediately adjacent
  * VMA with identical properties.
@@ -1319,8 +1468,10 @@ struct vm_area_struct *vma_merge_extend(struct vma_iterator *vmi,
 {
 	VMG_VMA_STATE(vmg, vmi, vma, vma, vma->vm_end, vma->vm_end + delta);
 
-	/* vma is specified as prev, so case 1 or 2 will apply. */
-	return vma_merge(&vmg);
+	vmg.next = vma_iter_next_rewind(vmi, NULL);
+	vmg.vma = NULL; /* We use the VMA to populate VMG fields only. */
+
+	return vma_merge_new_range(&vmg);
 }
 
 void unlink_file_vma_batch_init(struct unlink_vma_file_batch *vb)
@@ -1421,9 +1572,10 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 	struct vm_area_struct *vma = *vmap;
 	unsigned long vma_start = vma->vm_start;
 	struct mm_struct *mm = vma->vm_mm;
-	struct vm_area_struct *new_vma, *prev;
+	struct vm_area_struct *new_vma;
 	bool faulted_in_anon_vma = true;
 	VMA_ITERATOR(vmi, mm, addr);
+	VMG_VMA_STATE(vmg, &vmi, NULL, vma, addr, addr + len);
 
 	/*
 	 * If anonymous vma has not yet been faulted, update new pgoff
@@ -1434,11 +1586,15 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 		faulted_in_anon_vma = false;
 	}
 
-	new_vma = find_vma_prev(mm, addr, &prev);
+	new_vma = find_vma_prev(mm, addr, &vmg.prev);
 	if (new_vma && new_vma->vm_start < addr + len)
 		return NULL;	/* should never get here */
 
-	new_vma = vma_merge_new_vma(&vmi, prev, vma, addr, addr + len, pgoff);
+	vmg.vma = NULL; /* New VMA range. */
+	vmg.pgoff = pgoff;
+	vmg.next = vma_iter_next_rewind(&vmi, NULL);
+	new_vma = vma_merge_new_range(&vmg);
+
 	if (new_vma) {
 		/*
 		 * Source vma may have been merged into new_vma
diff --git a/mm/vma.h b/mm/vma.h
index c9b49c15f15a..497bb49a318e 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -52,6 +52,13 @@ struct vma_munmap_struct {
 	unsigned long data_vm;
 };
 
+enum vma_merge_state {
+	VMA_MERGE_START,
+	VMA_MERGE_ERROR_NOMEM,
+	VMA_MERGE_NOMERGE,
+	VMA_MERGE_SUCCESS,
+};
+
 /* Represents a VMA merge operation. */
 struct vma_merge_struct {
 	struct mm_struct *mm;
@@ -68,8 +75,14 @@ struct vma_merge_struct {
 	struct mempolicy *policy;
 	struct vm_userfaultfd_ctx uffd_ctx;
 	struct anon_vma_name *anon_name;
+	enum vma_merge_state state;
 };
 
+static inline bool vmg_nomem(struct vma_merge_struct *vmg)
+{
+	return vmg->state == VMA_MERGE_ERROR_NOMEM;
+}
+
 /* Assumes addr >= vma->vm_start. */
 static inline pgoff_t vma_pgoff_offset(struct vm_area_struct *vma,
 				       unsigned long addr)
@@ -85,6 +98,7 @@ static inline pgoff_t vma_pgoff_offset(struct vm_area_struct *vma,
 		.end = end_,						\
 		.flags = flags_,					\
 		.pgoff = pgoff_,					\
+		.state = VMA_MERGE_START,				\
 	}
 
 #define VMG_VMA_STATE(name, vmi_, prev_, vma_, start_, end_)	\
@@ -103,6 +117,7 @@ static inline pgoff_t vma_pgoff_offset(struct vm_area_struct *vma,
 		.policy = vma_policy(vma_),			\
 		.uffd_ctx = vma_->vm_userfaultfd_ctx,		\
 		.anon_name = anon_vma_name(vma_),		\
+		.state = VMA_MERGE_START,			\
 	}
 
 #ifdef CONFIG_DEBUG_VM_MAPLE_TREE
@@ -309,10 +324,7 @@ struct vm_area_struct
 		       unsigned long new_flags,
 		       struct vm_userfaultfd_ctx new_ctx);
 
-struct vm_area_struct
-*vma_merge_new_vma(struct vma_iterator *vmi, struct vm_area_struct *prev,
-		   struct vm_area_struct *vma, unsigned long start,
-		   unsigned long end, pgoff_t pgoff);
+struct vm_area_struct *vma_merge_new_range(struct vma_merge_struct *vmg);
 
 struct vm_area_struct *vma_merge_extend(struct vma_iterator *vmi,
 					struct vm_area_struct *vma,
@@ -505,6 +517,34 @@ struct vm_area_struct *vma_iter_prev_range(struct vma_iterator *vmi)
 	return mas_prev_range(&vmi->mas, 0);
 }
 
+/*
+ * Retrieve the next VMA and rewind the iterator to end of the previous VMA, or
+ * if no previous VMA, to index 0.
+ */
+static inline
+struct vm_area_struct *vma_iter_next_rewind(struct vma_iterator *vmi,
+		struct vm_area_struct **pprev)
+{
+	struct vm_area_struct *next = vma_next(vmi);
+	struct vm_area_struct *prev = vma_prev(vmi);
+
+	/*
+	 * Consider the case where no previous VMA exists. We advance to the
+	 * next VMA, skipping any gap, then rewind to the start of the range.
+	 *
+	 * If we were to unconditionally advance to the next range we'd wind up
+	 * at the next VMA again, so we check to ensure there is a previous VMA
+	 * to skip over.
+	 */
+	if (prev)
+		vma_iter_next_range(vmi);
+
+	if (pprev)
+		*pprev = prev;
+
+	return next;
+}
+
 #ifdef CONFIG_64BIT
 
 static inline bool vma_is_sealed(struct vm_area_struct *vma)
diff --git a/tools/testing/vma/vma.c b/tools/testing/vma/vma.c
index f6c4706a861f..b7cdafec09af 100644
--- a/tools/testing/vma/vma.c
+++ b/tools/testing/vma/vma.c
@@ -101,9 +101,9 @@ static struct vm_area_struct *merge_new(struct vma_merge_struct *vmg)
 	 */
 	vmg->next = vma_next(vmg->vmi);
 	vmg->prev = vma_prev(vmg->vmi);
+	vma_iter_next_range(vmg->vmi);
 
-	vma_iter_set(vmg->vmi, vmg->start);
-	return vma_merge(vmg);
+	return vma_merge_new_range(vmg);
 }
 
 /*
@@ -162,10 +162,14 @@ static struct vm_area_struct *try_merge_new_vma(struct mm_struct *mm,
 	merged = merge_new(vmg);
 	if (merged) {
 		*was_merged = true;
+		ASSERT_EQ(vmg->state, VMA_MERGE_SUCCESS);
 		return merged;
 	}
 
 	*was_merged = false;
+
+	ASSERT_EQ(vmg->state, VMA_MERGE_NOMERGE);
+
 	return alloc_and_link_vma(mm, start, end, pgoff, flags);
 }
 
@@ -595,6 +599,7 @@ static bool test_vma_merge_special_flags(void)
 		vmg.flags = flags | special_flag;
 		vma = merge_new(&vmg);
 		ASSERT_EQ(vma, NULL);
+		ASSERT_EQ(vmg.state, VMA_MERGE_NOMERGE);
 	}
 
 	/* 2. Modify VMA with special flag that would otherwise merge. */
@@ -616,6 +621,7 @@ static bool test_vma_merge_special_flags(void)
 		vmg.flags = flags | special_flag;
 		vma = merge_existing(&vmg);
 		ASSERT_EQ(vma, NULL);
+		ASSERT_EQ(vmg.state, VMA_MERGE_NOMERGE);
 	}
 
 	cleanup_mm(&mm, &vmi);
@@ -708,6 +714,7 @@ static bool test_vma_merge_with_close(void)
 
 	/* The next VMA having a close() operator should cause the merge to fail.*/
 	ASSERT_EQ(merge_new(&vmg), NULL);
+	ASSERT_EQ(vmg.state, VMA_MERGE_NOMERGE);
 
 	/* Now create the VMA so we can merge via modified flags */
 	vmg_set_range(&vmg, 0x1000, 0x2000, 1, flags);
@@ -719,6 +726,7 @@ static bool test_vma_merge_with_close(void)
 	 * also fail.
 	 */
 	ASSERT_EQ(merge_existing(&vmg), NULL);
+	ASSERT_EQ(vmg.state, VMA_MERGE_NOMERGE);
 
 	/* SCENARIO B
 	 *
@@ -744,6 +752,7 @@ static bool test_vma_merge_with_close(void)
 	vmg.vma = vma;
 	/* Make sure merge does not occur. */
 	ASSERT_EQ(merge_existing(&vmg), NULL);
+	ASSERT_EQ(vmg.state, VMA_MERGE_NOMERGE);
 
 	cleanup_mm(&mm, &vmi);
 	return true;
@@ -792,6 +801,7 @@ static bool test_vma_merge_new_with_close(void)
 	vmg_set_range(&vmg, 0x2000, 0x5000, 2, flags);
 	vma = merge_new(&vmg);
 	ASSERT_NE(vma, NULL);
+	ASSERT_EQ(vmg.state, VMA_MERGE_SUCCESS);
 	ASSERT_EQ(vma->vm_start, 0);
 	ASSERT_EQ(vma->vm_end, 0x5000);
 	ASSERT_EQ(vma->vm_pgoff, 0);
@@ -831,6 +841,7 @@ static bool test_merge_existing(void)
 	vmg.prev = vma;
 	vma->anon_vma = &dummy_anon_vma;
 	ASSERT_EQ(merge_existing(&vmg), vma_next);
+	ASSERT_EQ(vmg.state, VMA_MERGE_SUCCESS);
 	ASSERT_EQ(vma_next->vm_start, 0x3000);
 	ASSERT_EQ(vma_next->vm_end, 0x9000);
 	ASSERT_EQ(vma_next->vm_pgoff, 3);
@@ -861,6 +872,7 @@ static bool test_merge_existing(void)
 	vmg.vma = vma;
 	vma->anon_vma = &dummy_anon_vma;
 	ASSERT_EQ(merge_existing(&vmg), vma_next);
+	ASSERT_EQ(vmg.state, VMA_MERGE_SUCCESS);
 	ASSERT_EQ(vma_next->vm_start, 0x2000);
 	ASSERT_EQ(vma_next->vm_end, 0x9000);
 	ASSERT_EQ(vma_next->vm_pgoff, 2);
@@ -889,6 +901,7 @@ static bool test_merge_existing(void)
 	vma->anon_vma = &dummy_anon_vma;
 
 	ASSERT_EQ(merge_existing(&vmg), vma_prev);
+	ASSERT_EQ(vmg.state, VMA_MERGE_SUCCESS);
 	ASSERT_EQ(vma_prev->vm_start, 0);
 	ASSERT_EQ(vma_prev->vm_end, 0x6000);
 	ASSERT_EQ(vma_prev->vm_pgoff, 0);
@@ -920,6 +933,7 @@ static bool test_merge_existing(void)
 	vmg.vma = vma;
 	vma->anon_vma = &dummy_anon_vma;
 	ASSERT_EQ(merge_existing(&vmg), vma_prev);
+	ASSERT_EQ(vmg.state, VMA_MERGE_SUCCESS);
 	ASSERT_EQ(vma_prev->vm_start, 0);
 	ASSERT_EQ(vma_prev->vm_end, 0x7000);
 	ASSERT_EQ(vma_prev->vm_pgoff, 0);
@@ -948,6 +962,7 @@ static bool test_merge_existing(void)
 	vmg.vma = vma;
 	vma->anon_vma = &dummy_anon_vma;
 	ASSERT_EQ(merge_existing(&vmg), vma_prev);
+	ASSERT_EQ(vmg.state, VMA_MERGE_SUCCESS);
 	ASSERT_EQ(vma_prev->vm_start, 0);
 	ASSERT_EQ(vma_prev->vm_end, 0x9000);
 	ASSERT_EQ(vma_prev->vm_pgoff, 0);
@@ -981,31 +996,37 @@ static bool test_merge_existing(void)
 	vmg.prev = vma;
 	vmg.vma = vma;
 	ASSERT_EQ(merge_existing(&vmg), NULL);
+	ASSERT_EQ(vmg.state, VMA_MERGE_NOMERGE);
 
 	vmg_set_range(&vmg, 0x5000, 0x6000, 5, flags);
 	vmg.prev = vma;
 	vmg.vma = vma;
 	ASSERT_EQ(merge_existing(&vmg), NULL);
+	ASSERT_EQ(vmg.state, VMA_MERGE_NOMERGE);
 
 	vmg_set_range(&vmg, 0x6000, 0x7000, 6, flags);
 	vmg.prev = vma;
 	vmg.vma = vma;
 	ASSERT_EQ(merge_existing(&vmg), NULL);
+	ASSERT_EQ(vmg.state, VMA_MERGE_NOMERGE);
 
 	vmg_set_range(&vmg, 0x4000, 0x7000, 4, flags);
 	vmg.prev = vma;
 	vmg.vma = vma;
 	ASSERT_EQ(merge_existing(&vmg), NULL);
+	ASSERT_EQ(vmg.state, VMA_MERGE_NOMERGE);
 
 	vmg_set_range(&vmg, 0x4000, 0x6000, 4, flags);
 	vmg.prev = vma;
 	vmg.vma = vma;
 	ASSERT_EQ(merge_existing(&vmg), NULL);
+	ASSERT_EQ(vmg.state, VMA_MERGE_NOMERGE);
 
 	vmg_set_range(&vmg, 0x5000, 0x6000, 5, flags);
 	vmg.prev = vma;
 	vmg.vma = vma;
 	ASSERT_EQ(merge_existing(&vmg), NULL);
+	ASSERT_EQ(vmg.state, VMA_MERGE_NOMERGE);
 
 	ASSERT_EQ(cleanup_mm(&mm, &vmi), 3);
 
@@ -1071,6 +1092,7 @@ static bool test_anon_vma_non_mergeable(void)
 	vmg.vma = vma;
 
 	ASSERT_EQ(merge_existing(&vmg), vma_prev);
+	ASSERT_EQ(vmg.state, VMA_MERGE_SUCCESS);
 	ASSERT_EQ(vma_prev->vm_start, 0);
 	ASSERT_EQ(vma_prev->vm_end, 0x7000);
 	ASSERT_EQ(vma_prev->vm_pgoff, 0);
@@ -1106,6 +1128,7 @@ static bool test_anon_vma_non_mergeable(void)
 	vmg.prev = vma_prev;
 
 	ASSERT_EQ(merge_new(&vmg), vma_prev);
+	ASSERT_EQ(vmg.state, VMA_MERGE_SUCCESS);
 	ASSERT_EQ(vma_prev->vm_start, 0);
 	ASSERT_EQ(vma_prev->vm_end, 0x7000);
 	ASSERT_EQ(vma_prev->vm_pgoff, 0);
@@ -1181,6 +1204,7 @@ static bool test_dup_anon_vma(void)
 	vmg.vma = vma;
 
 	ASSERT_EQ(merge_existing(&vmg), vma_prev);
+	ASSERT_EQ(vmg.state, VMA_MERGE_SUCCESS);
 
 	ASSERT_EQ(vma_prev->vm_start, 0);
 	ASSERT_EQ(vma_prev->vm_end, 0x8000);
@@ -1209,6 +1233,7 @@ static bool test_dup_anon_vma(void)
 	vmg.vma = vma;
 
 	ASSERT_EQ(merge_existing(&vmg), vma_prev);
+	ASSERT_EQ(vmg.state, VMA_MERGE_SUCCESS);
 
 	ASSERT_EQ(vma_prev->vm_start, 0);
 	ASSERT_EQ(vma_prev->vm_end, 0x8000);
@@ -1236,6 +1261,7 @@ static bool test_dup_anon_vma(void)
 	vmg.vma = vma;
 
 	ASSERT_EQ(merge_existing(&vmg), vma_prev);
+	ASSERT_EQ(vmg.state, VMA_MERGE_SUCCESS);
 
 	ASSERT_EQ(vma_prev->vm_start, 0);
 	ASSERT_EQ(vma_prev->vm_end, 0x5000);
@@ -1263,6 +1289,7 @@ static bool test_dup_anon_vma(void)
 	vmg.vma = vma;
 
 	ASSERT_EQ(merge_existing(&vmg), vma_next);
+	ASSERT_EQ(vmg.state, VMA_MERGE_SUCCESS);
 
 	ASSERT_EQ(vma_next->vm_start, 0x3000);
 	ASSERT_EQ(vma_next->vm_end, 0x8000);
@@ -1303,6 +1330,7 @@ static bool test_vmi_prealloc_fail(void)
 
 	/* This will cause the merge to fail. */
 	ASSERT_EQ(merge_existing(&vmg), NULL);
+	ASSERT_EQ(vmg.state, VMA_MERGE_ERROR_NOMEM);
 	/* We will already have assigned the anon_vma. */
 	ASSERT_EQ(vma_prev->anon_vma, &dummy_anon_vma);
 	/* And it was both cloned and unlinked. */
@@ -1327,6 +1355,7 @@ static bool test_vmi_prealloc_fail(void)
 
 	fail_prealloc = true;
 	ASSERT_EQ(expand_existing(&vmg), -ENOMEM);
+	ASSERT_EQ(vmg.state, VMA_MERGE_ERROR_NOMEM);
 
 	ASSERT_EQ(vma_prev->anon_vma, &dummy_anon_vma);
 	ASSERT_TRUE(dummy_anon_vma.was_cloned);
diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
index a3c262c6eb73..c5b9da034511 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -740,6 +740,12 @@ static inline void vma_iter_free(struct vma_iterator *vmi)
 	mas_destroy(&vmi->mas);
 }
 
+static inline
+struct vm_area_struct *vma_iter_next_range(struct vma_iterator *vmi)
+{
+	return mas_next_range(&vmi->mas, ULONG_MAX);
+}
+
 static inline void vm_acct_memory(long pages)
 {
 }
-- 
2.46.0


