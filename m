Return-Path: <linux-kernel+bounces-213421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED50907522
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 16:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0E96B21B4E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 14:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85936145B02;
	Thu, 13 Jun 2024 14:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bm/SB6GZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MxQvoxOt"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D526314534B
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 14:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718288977; cv=fail; b=rDvU4eOigwZg2oxWeLUeZ0uXu7TQu/52ThWgn2bF4iNSJ04GnJcOAGrK0XytepQp1M3mNXCz+GLwXbba/+8octwmYCvT8iNBSBoyx03iNZ1uI4/Y3aXXwddSFbNvfFX7kHtZ3O4Q8ebgFic0w6lfEsUEpmDX4LrQt4PuW48i2Ag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718288977; c=relaxed/simple;
	bh=alajSQiVlmbBRAuBxhiluVPpulKOVv2tsbgQYOcljt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WNEW9sjrzEzQYOHaVwbvxDPIZoXwaOKVW/HmJMHtFIggD6oFBmiQvFo6ng3+kfJgh/lNmojNz/jwGKnLG2cwARupFtGJtXJsMWHc3osJrU5iA9wpjWyvRK8ZS8qelmSe7JgvGFkd9g4TsyQlMb9TKbdI9ponRWkIradBiP7Zp7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bm/SB6GZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MxQvoxOt; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45DBtRRl011451;
	Thu, 13 Jun 2024 14:29:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=O+jKF3NF8zw8ax+
	vwPg+Vt8XBNsFJtJTQP04n+v9K90=; b=bm/SB6GZqX0lsvAWL23Dpgv2HjfLuQw
	hhQTJ7zdnTuPmsLTIUgPHY9E36CkUGsaPUZtlwv0vK34tK1OQZi4wDnd/D63o/8I
	riaslwAODvcESUDV0nfPtRyqilftfwXAZkumNFaIhh3G5vueQhSwi+0RJDfC4vx5
	Tj0Hq0jPc2E+jryYNkfUmljkXubUV6sHaiA15dIyMl6m/Wux6Wwnr6Y2bxAOvbBR
	RAYL0UVuvtu9bXIUNrbazs/KJEQa1TO92TsE1IAP+yoXVOHdtiZ55rcO3RWemGEx
	RxOWj/PkNGLWh13RIRgmzM5cpjDMJR0AKCNqCB32E6HfMzama5WtXPQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ymh1mhq8w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Jun 2024 14:29:23 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45DE1FBm036535;
	Thu, 13 Jun 2024 14:29:23 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2174.outbound.protection.outlook.com [104.47.73.174])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ynce0bbe7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Jun 2024 14:29:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sx1LNnSPcAWdZmZjswvo5CiOVoF6rSeg8Pu1tSzFYfFxOoMJJNt/BzqYuEx73VInYrqFyCuhlls5T8bLn2HTQ5sSd2dEYE6rojldhc/TFSAz+9KR7qThZNeKbGBpNGUpKBvQMR+oSav9zl/tpX2wM9BOqcj85S/uUhXPmQFqEyOwxjYx8lTd24/qrazF1ASg7szsETz9kYXXF0+qUpkaul7cGwN39oiFT2tabNIzHVEtz1C8DbN6WCNLnGZrk2TZEAsgurzZWO29NPvoYadpUfJAXXE7cN+Ize4QmFIfm1kM82m8nV+M3mx1mge72p+DN3uSkzFAU6PhkWP2sQK+KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O+jKF3NF8zw8ax+vwPg+Vt8XBNsFJtJTQP04n+v9K90=;
 b=i9yoiYr/8dbwN3QQRGSSDcnG6eUKOFjEofhQ9TcGfcpD1cVeFk0muhD3PVmexQ5PtVOrLhq+Zgk1RsPT9euqYTXu3rm/Tu7aw/a3WTLzIfm9J0TRZf/NUZ9BLWNdwEdOArbIfn3UijECyIGJ5xgYrcozPwW5yGWHmeevCDny5CHgDLUbNArqaNSIEUVUCsJOLpdXZAqPthLY/gPK5/2wLyPOCFRL/2RigzHBmJPJkeN0kGPANLI/c+HvrRGpRAAVFfvj6HlF9yTlpBNh9uAx5PLwfmf1/uQIhANFRwg9vik/ASEL7lDO4K2iEJ6J20nWzRLxgwYwPL33GJB/ZzIhkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O+jKF3NF8zw8ax+vwPg+Vt8XBNsFJtJTQP04n+v9K90=;
 b=MxQvoxOtq/GuPVzDVubBFDkqyQI9EZPVMrY+B7DhQje6HCsjP5GDkogqRb6qggstEDaFYC8KFTmRpwgz52Nb+YW7B6eKk4H7Zu1Julalodp/VFzLWhiN5YPZmEGf3gEgQWSzq3tIa4FVaBd0uUKGpN7Lzjy+w9ykVBhXBlo9LDY=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CH3PR10MB7713.namprd10.prod.outlook.com (2603:10b6:610:1bc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Thu, 13 Jun
 2024 14:29:20 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.7633.037; Thu, 13 Jun 2024
 14:29:20 +0000
Date: Thu, 13 Jun 2024 10:29:18 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, willy@infradead.org
Subject: Re: [PATCH v2 08/16] maple_tree: print store type in mas_dump()
Message-ID: <nuij35r6vabz2s5qikvn6t3v7gabshabv5o7ngyzkkbh5tw3ik@lqy322zs2cua>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org, 
	linux-mm@kvack.org, akpm@linux-foundation.org, willy@infradead.org
References: <20240607185257.963768-1-sidhartha.kumar@oracle.com>
 <20240607185257.963768-9-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607185257.963768-9-sidhartha.kumar@oracle.com>
User-Agent: NeoMutt/20231103
X-ClientProxiedBy: YT4PR01CA0019.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d1::10) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CH3PR10MB7713:EE_
X-MS-Office365-Filtering-Correlation-Id: a804cc0e-f4f5-46ac-51ce-08dc8bb536ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|1800799019|366011|376009;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?WdUo9907MCmRmV8N4WuY19N0IDEz9C+jm8nY4vVETQsqgKMmPTvm4iBsfc39?=
 =?us-ascii?Q?Foc8x3bd0+dSxX+sBaX/Zd7gx4rrgmzxTQICF/fle5ypWVURNjNTKhWJtqbp?=
 =?us-ascii?Q?QmE+KnJhukoB0f8B4x5rTkNMD49JistDoeZ5T4nPlSjs81JHtKU6CMT+r80Y?=
 =?us-ascii?Q?z3DYFz3mWmk/YfKi8/bL5p6W3BOn+ok0P87AwnzntGbUx2tSjLuXk/O4uoIj?=
 =?us-ascii?Q?pCET6xC/Wb7sxKgAMOvdiutkoA95gIsqCCE4pRAh5EF0f5UDF5PSt+QWeJyK?=
 =?us-ascii?Q?OCSwNnkZwlbtLFhHfmHaLXhQiZZwKUt3GzGX4Q1eD+QPuNW8tStB+UkFRlGJ?=
 =?us-ascii?Q?TieCoWsut0lIoAAxxjAGfGJ7u8NM8mouH83+X72lKJ84cJ9CzOU+nus9/Yct?=
 =?us-ascii?Q?lc5Ia45Amxb3JVxWnVEl0Z/geuGRA8mCkyJMG1ygRqlZOElzjk/20iD1To3Q?=
 =?us-ascii?Q?S7cjo6dZgZ39Ll52dsmgIsheeAujZZy5VKcuE4KcCiF4RwUIvgQUDkOuhDUH?=
 =?us-ascii?Q?UH+V3pxtwQueOBFyNT7cd+XUaaeeWzuOeEbMMslcY04/Xgracn5DilxcPTTd?=
 =?us-ascii?Q?uROFGJdbKYUrMpjnCUx2gLLTA4sU/VMLxJK6HT0gr8aOy+k2j/CVy6NIlI4Y?=
 =?us-ascii?Q?STgHhCl5Yg9BB4Oa6vOcupuNKcAyVZIpHjDCGhxh/fV1yVY2/KQQ2LYVoURZ?=
 =?us-ascii?Q?XOtsjGezw5GGTG9QzPwiWIAXy90mrVTcQ61pwX1XokayW7TtvdonUMuBTPsr?=
 =?us-ascii?Q?NL/+zn9J9TWeUZlOaDGKY8MurJEKL/AzfzgcpqcNdIN9u455iNR1KbGQtSXc?=
 =?us-ascii?Q?54o1iIo46FWb+vKSVwh69YjTLVkGa+HNQyB46QZfhVxOxg+cI2YbfsNFzf3Z?=
 =?us-ascii?Q?lCQaKKaBPOMJCodbhfXqs9XrKjAq1xm3S/m0urWEVe0cGs55L1Nyyvw3mwOQ?=
 =?us-ascii?Q?1SNnvwrUCgAv5VPyJ0bWMXiQ6LkQczP8W0DKXr3jCZ63y+7yGn1HQz2h8V/J?=
 =?us-ascii?Q?8UEFr0w/3qNhL3DwEzLhw83yfL4yJwBc2d1wbvk7F9oE/TaTeeBr5kFcEvWI?=
 =?us-ascii?Q?asqCT6veUZgs2edy+0txYhLRNvAaLRdrYPMTLdl2j2lfpEPo7ClsG19lofiG?=
 =?us-ascii?Q?6s+VAem7aTzhLDj3Y2YeAIC3wZjeVxNMnQk6pGFaKg4lJe8C2f5uiUCCHZeL?=
 =?us-ascii?Q?WJi6Z/CelldEHQBK3Wfdp2xxQs56bYxna44ZxebzTczewrks2/ASiiA420gL?=
 =?us-ascii?Q?zPeG3IfnUha8bwWl0uDWU17N+NI0meMU6G1bI09irSkVajvNYd1/YAX9jX3N?=
 =?us-ascii?Q?yXY=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(1800799019)(366011)(376009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?QcDY7oCuyv7c6ATReEZe8OVGM2yCLn8zB0PPNJ2NJCA1Uf6DFZNDt90BXTIN?=
 =?us-ascii?Q?xX+XuueRApaMtnwHzSjXAUw2PHfXt0zpeMUWds2jTR3GGe7MLMNpX9KKfQ2C?=
 =?us-ascii?Q?Oif8LJJgt+1BIu4zTRyrmupuSGTute/DLiuCAdiMWpj80P6GTv4bjH146ZiI?=
 =?us-ascii?Q?68iP4OMuI4hReH2AyxHl6jrGcRAFC4vBKZktJSTWVxuD6EPgtkDtZaVVYndr?=
 =?us-ascii?Q?PzKedKza44T6RC3ADVtVNrHTUC6Vnvq3mROtgtlKr+21x1ovokoT8w2JVzFb?=
 =?us-ascii?Q?L2je6/AOYvId9frDrm3zP8DxOnjnJz8Ov6KxxsaMOQtSyrD0UszFeNfG3WOb?=
 =?us-ascii?Q?OuVZ5YH7axLotdkJfAcm6+5xMM5Rm/869RdzsTIDVaa68fHeh2aQcqmLD6eZ?=
 =?us-ascii?Q?OxtXvMA7K2X70kQDX9X0N1aMD0P2Cqw6huicYiQzgf+qip9BeRJGRqs5UU6q?=
 =?us-ascii?Q?Tcm8mRq8IpQjJMzGNfR3kK/zvYr9WBC6xuiJjFvVuWqpQDWxPHmg9+vc0Avf?=
 =?us-ascii?Q?U90kd/gICdN/A0kq6SJgM3eqTimjMEQHna+8WK6FqwWOo2wlkoHgtqLVhX4D?=
 =?us-ascii?Q?7n5Rnzo86KUQKOkHUt8JepIZewy2uM3qbapy+J3sMRLjRLZ3V7p4Y1jNRC97?=
 =?us-ascii?Q?xVBlx+tK5++OW9M4y8VuCAW7Xj8xXSW+XU4Qv/0+VguXm0TG224hnSe2mVwI?=
 =?us-ascii?Q?o6joTaKaRCK/Xe+Cjhp/k67k87TJ0QRs8q0xq6yqyYv917bdoD4j06aauopJ?=
 =?us-ascii?Q?espMCpTA8hPI8J4I1JNE/I/UiPoU6hw1MnVrQau+2+lKgqWig1bVAUj0Ohxi?=
 =?us-ascii?Q?qWZmd9dzAMSXVcmLY22HbL8GpI030oVlzbodo1s1Jx8+ytZZoFGwK/VVPfVS?=
 =?us-ascii?Q?xkbxkt3+DCA1/P5qH1xvfFr1+xGUCQxC63OE10PLzvg/NrbobrLuavdyMmYc?=
 =?us-ascii?Q?//bjY9Xc0+HQB+E8+B67Vhs4zz8IbJ3MwltjDyPWozPS+3+wMyOu8Tk4IBL8?=
 =?us-ascii?Q?mspIbWBPc8AE4tePY4Bd5kEKUGMcQYE8nlc1rlkscdwMQCC1Y5YvQOCYyzzy?=
 =?us-ascii?Q?p4OxNayTnYbqaNcMEold8rTYVdd5jVV1eNim8v4U14g7hnhHeHfvjxbMyXWK?=
 =?us-ascii?Q?M6gOsWpoN6d/oIbTZlSls85oDBiutQtPnMDhvX6Jk/+/NiVzB+quYSTn0Glk?=
 =?us-ascii?Q?NNcPvj04PHEtDUx9/a0nEAhI4oAP83bhWgB6i2FCATBtr27uJ5RpsfRrGeX2?=
 =?us-ascii?Q?c5nsJgKV9n//hbx/Khuzz/Og5oaRIRzVvuNRm0uP8KwvwttwA4+2PpnhaUMe?=
 =?us-ascii?Q?NpgH87KJnTne2nfbLJZ2KDJpmTtvPs0Qmtomap90ukAusfGyKHv7fJ45Uq0C?=
 =?us-ascii?Q?1ISnXrt3X+OMfi+JJX3bzCyPRVZvGD7tuKFnZ4QCxcK94V+Q5XU8E7JI7hE4?=
 =?us-ascii?Q?3wSefk92vI7biqcw+Q/oZfQkwINJqYPQ6fJpql0U7shbRZw21uQrYZy54b8b?=
 =?us-ascii?Q?K9ev6d9by6k+zXNHaWS9BoSznE2prJk/Q+AtX7fMw3QRRenXP1yUjpt9W/VJ?=
 =?us-ascii?Q?Q/2NjVIHjp42XHE40JQ1FK+B1m/3BBATvyfkV+obN01xAeE4wq9XwC4xnCJM?=
 =?us-ascii?Q?bQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	N/akDb6G9p7jwRnG8rstHqJRIzdZYwZG295zmldQIpN7ftq7kiQ+By05Q7EgBGjPFp8n9HtZgJEWS6hmeNz98EAZoOK0eVUpsTPyCPe7OnJmZtfNSClJZoaqlbyRTc62VH/tWb57LR9oFY1pR/dbmkRNR9Hon8O/LfPPizNlUp1qnoNLO6FteCCHs0pc+jTMkbPdw7PBKHJLNccjgsafr8NBw/tUfI7iPDPkj1C6NN7B24cRkhua41O8MRgJhZns61BVMsTFm/p0X2XgjDKHZ2RBIDRGfYbesiOj2yOfLd5VYJiTAwQwlyZcd/CKCnni9+DY1e/4QOeQ4CvHGWL8d45bPz99JETizJstDi5RA5GszqMKDKL/78CB59xhq8T9U1D9mTMZSI8z6Krkr+C8pYDbqnhxerpaUGgJa5uoMHhrP5bobkaZBrHXHWXMOEkiiA5wlT0DJkeRkvZqFEIljAgvsr8xos5dCRE91nAwqU0EGOEaGFtgNCxFY1dvnCc79eHcT8QbTe9mPzVuehbistSh61jWTutgxzkNOsm87zXjn639sBs5tSfhBHTvAUZn10x9tL/HVQdqR8QPmgbr04RHUqAlzYGEexIihcssiA8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a804cc0e-f4f5-46ac-51ce-08dc8bb536ae
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 14:29:20.3792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8HMWWTwGh7ukv1l2meSX5jP1k+tej508L8AK2Sf1Gvoi0LTczdrxt8tfe+QehkP530N6jt1D54/b2tS8O/G/LQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7713
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-13_08,2024-06-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 adultscore=0
 mlxscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406130106
X-Proofpoint-ORIG-GUID: bHI0KFatA6MB_iB7ZtiNalrZE8nohHbD
X-Proofpoint-GUID: bHI0KFatA6MB_iB7ZtiNalrZE8nohHbD

* Sidhartha Kumar <sidhartha.kumar@oracle.com> [240607 14:53]:
> Knowing the store type of the maple state could be helpful for debugging.
> Have mas_dump() print mas->store_type.
> 
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> ---
>  lib/maple_tree.c | 39 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index a955316b6745..91b18eef81e1 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -7731,6 +7731,45 @@ void mas_dump(const struct ma_state *mas)
>  		break;
>  	}
>  
> +	pr_err("Store Type: ");
> +	switch (mas->store_type) {
> +	case wr_invalid:
> +		pr_err("invalid store type\n");
> +		break;
> +	case wr_new_root:
> +		pr_err("new_root\n");
> +		break;
> +	case wr_store_root:
> +		pr_err("store_root\n");
> +		break;
> +	case wr_exact_fit:
> +		pr_err("exact_fit\n");
> +		break;
> +	case wr_split_store:
> +		pr_err("split_store\n");
> +		break;
> +	case wr_slot_store:
> +		pr_err("slot_store\n");
> +		break;
> +	case wr_append:
> +		pr_err("append\n");
> +		break;
> +	case wr_node_store:
> +		pr_err("node_store\n");
> +		break;
> +	case wr_spanning_store:
> +		pr_err("spanning_store\n");
> +		break;
> +	case wr_rebalance:
> +		pr_err("rebalance\n");
> +		break;
> +	case wr_bnode:
> +		pr_err("write_bnode\n");
> +		break;
> +
> +	}
> +
> +

There is an extra new line here

>  	pr_err("[%u/%u] index=%lx last=%lx\n", mas->offset, mas->end,
>  	       mas->index, mas->last);
>  	pr_err("     min=%lx max=%lx alloc=%p, depth=%u, flags=%x\n",
> -- 
> 2.45.2
> 

