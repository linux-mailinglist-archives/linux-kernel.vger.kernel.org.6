Return-Path: <linux-kernel+bounces-220170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B18A990DDC0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 22:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C21C1F232B2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 20:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99DE6185E5B;
	Tue, 18 Jun 2024 20:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mJM+sdI/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cdNp+xx0"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3970F1779A4
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 20:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718743727; cv=fail; b=sSKnfALGm89JTWO2oedIJiOcqMhFgyi/AdtuC2bBNcg92Pqp0lqqgdbEbFb1YONUDn4pxHdSKr/ESkVfZDEr3NTKRjvPpqsLdvk4nmp8kjFIsr8Ha2rRkezaTcX89NHeewmr3A0L0n0/dGlag9i90RJm22HOdKu3LfHo7FY9Occ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718743727; c=relaxed/simple;
	bh=eJyvqClWO3WM2bXDNTzr/o6yl5f8vmwiY/MXPttQhZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X+jSeiihHT19HuVqu6c/Tv0aLQLvTFlg7RqfReHWKKjPYInQJyLfQLePNH1D78Zzo1SGMfsv8p2aH4GWzbau4Q8skSOQI1iHwQl+Jotm3wFccGbSiQBoV5JO6N6elhSCBnJq82YgaXQEuROqSBtb6s8DXiUA796nshqumxRJkJY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mJM+sdI/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cdNp+xx0; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45IIUqvm005347;
	Tue, 18 Jun 2024 20:48:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=eSYIOHTKRzu7IUz6tv4eIyVN7yGr4LGzTFAAcrhpaf4=; b=
	mJM+sdI/QHeNqSbSSlhOcxN+FtwLkK2OAvhh1h9mIQa1GJKTLYQePY8uS7+fZE+9
	gq/BtA3R+TdaUO59teZxWJkP4+d9YvIGDrM2SoGqQQwELJOiYR+zVcYdWV0jAdpt
	eiFE0GrirNphAR1dNUWt69fRPckb1Yxq5G7vEp1B9Je6uFLJ97GZjMtLz7ZZYiNw
	gcuFc+JCwQuwPRk9RT/Pj8nBlvgkgCrKbkkoij71JziX6Pu6wSeyJvLhhGQR6LvY
	VKuZ9AQODAgcQFXEYuIIhe+PeLcv/ppbdL78wkuL+QqsIMEFZtW+gkTBUTlmaNrl
	gSJBxh86DRz+P0YI2d5H8w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ys1j05xam-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Jun 2024 20:48:33 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45IJlTIQ034656;
	Tue, 18 Jun 2024 20:48:32 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ys1dey4ud-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Jun 2024 20:48:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SOir+CvolmvIj/F9c3zLO9xckFuE0N5eSibwZz5ZOwqy+h44u7w1lf7hBVwIoa46xzhQdpcTu5Y/3LVwLcXxG7dvAb5R0JHsSwrge0uNwhokK7JVABq5X3ujhCVB9K2fRYhYJyRUarTRepDtgaLPiNXVv2r0mVgf6zefpm5LVSm23gKI3HkBZqkZXNbxGF8vOLZnjNVupTIWXEa/dwNfUaUpYDTXUMz7Ze3sqRsc2lYqTh1/E/QYFH7jcS4YqwSC/trLUfZ/1S5l/UTCIbr3V5OizfEM3YBf5ywcI5gtzlsH7/XqH3OoGEGCWZBFLDdaIjtlIdPHozZB+wawNXrT6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eSYIOHTKRzu7IUz6tv4eIyVN7yGr4LGzTFAAcrhpaf4=;
 b=lDc+BjBTK21ORjJEZOMGj+VWW191+flXT9SIU518zD6q6oYLc2f+Gf2Cuh663FEQ7vKbLusNzd9jLpRZF6L/R7GCVEbgqkK1xgdbmfzvzMOnQR7GDoPxR4BusVGtbJ5pDOAoEnjZDFgkEk2ZuLcaqsdHk+Pgukdy7wa/eFjrM8vd1wWW+yJwSXW8vq5o8xQE31Yni3lqOL5OQsRABzGKMc56k6eTdKw/DoFIJ9QJTtGDRt6U8ROvZ7LeXzYWlm62fFDGstkGJ/S4OTOnW7gHHxKHpAE4VaUWDyS5uhVQjylKCAn1i+J1r+1I36/DwMJRlUwZhbUuXMxIH50DdTLC/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eSYIOHTKRzu7IUz6tv4eIyVN7yGr4LGzTFAAcrhpaf4=;
 b=cdNp+xx0KUwO/8P8vP0ZnNVcn7P6Gc9Thlrwlq8yip4Bkh8brhGcRB9OPaX82VXxHe5Y61Cnq35uohoyP/64QglZqw/1LJpx66NnYJVTFZC59ZyhQEGqefmEjxNDkit/Jeh0ovu7IPRv9c/hYDrmbU5i7618m+Ga4bNTIwuwUhw=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by CY8PR10MB6465.namprd10.prod.outlook.com (2603:10b6:930:63::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 20:48:18 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::eab6:6dcc:f05f:5cb2%7]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 20:48:18 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, liam.howlett@oracle.com,
        willy@infradead.org, Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v3 09/16] maple_tree: use store type in mas_wr_store_entry()
Date: Tue, 18 Jun 2024 13:47:43 -0700
Message-ID: <20240618204750.79512-10-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240618204750.79512-1-sidhartha.kumar@oracle.com>
References: <20240618204750.79512-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR21CA0029.namprd21.prod.outlook.com
 (2603:10b6:a03:114::39) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|CY8PR10MB6465:EE_
X-MS-Office365-Filtering-Correlation-Id: f674a0f9-2001-488f-6739-08dc8fd7fb98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?2zl6mvJ21ioLsaISeb/eOkTBYM9pyAQ+0GPn0SFl11lhssbl17AvCg/BY+Lr?=
 =?us-ascii?Q?PQgBIiKz6wHmacP9AarLnzpIrULkxaPF2eFVQ/UkQ5yCuQkJvFq1NGwhGiCF?=
 =?us-ascii?Q?+s9jmHh3UViAtffzA92b9OcehANFNrXzQ1eHfQ3KPUGbDdlxcN8UW0yV6ePh?=
 =?us-ascii?Q?YgIa80cnDPgBBNZk3zh+1MpsaoeJIwKnjUNq0fs6yIgtqNfYpmquOkE7y4SE?=
 =?us-ascii?Q?AqPMEL0Glbe4pm1hFne94fJnzsjiiEx18LLGIgADIb22JMPc/VZx1vf/Zm9s?=
 =?us-ascii?Q?MiNGIMebj77Rce8gbt4OdAmT1Tpx/iyQ12nuftEflUtdiB/d5Kw6aPo2HSeR?=
 =?us-ascii?Q?vqNudNomYln0KNtsMmIrSfYF+SKWy2+bQrVX+Ch5GwWG/oQUkZhOM4e3UZ20?=
 =?us-ascii?Q?NjPffpnpoGuGPZfO8mE9RsskiIHaECK6a5lV01Vwe65dP3qDoWq5l4Es3+AO?=
 =?us-ascii?Q?1AvZ4UkAMe1a32EcrJXWnBLDPFmHc0D7ByEondv+D1KRetUwN+OGW83H0e4U?=
 =?us-ascii?Q?4E/7dVX5CUn3FGPEryu/kXDq/wcdOv2ohgKdd0eayhislMFh7xOOhdBR0sp7?=
 =?us-ascii?Q?Luu4cEqrlCeJptcLKfUxNeGqxqGdp13lZHCiEAR5orP9wdbRs0Rxun7PKgLi?=
 =?us-ascii?Q?78C2VCyNsaQHGsK+ExlqTCwzmsYgTUnEMIIqzJA1XO8jlDcrEAQcivs/E0n6?=
 =?us-ascii?Q?wSMY88CszLOaaTtgI47yKXOGlzFIcJKtv6WwopDlSy+V0Zn6no0GKJlQm5gE?=
 =?us-ascii?Q?iI4onXcFdQyKC3b2l48WHmi16+6RM4o7aSYlI47iR/Fovy+koMrI1FlSzgEK?=
 =?us-ascii?Q?A/BkotDgksyhFHxqEpL0mgFmWjp81fHPsIhjN8Hlv/tIYIxkxwSg/+iRkR1f?=
 =?us-ascii?Q?Za271f82Rg+Mg6yrSlUH9Np9zWBVvbeHG9WWls+Gf4lK95mk7B5gm+rsXVxw?=
 =?us-ascii?Q?8hPnvJh7TvKin0cdEBTQrJNUhis+FifBb5Y+vWv9xtdhzwuYoQE9CvEHlYra?=
 =?us-ascii?Q?uQP+ApLzlcEytJ+TVx+gsfGul7jWLNRk8yXNDHyYm0vLWj9nHAHsKjpNByz3?=
 =?us-ascii?Q?Cw7kwWuGOH1wtd6DAV/8XeCZIf1oLts/64q2Etn99i54ewGARLQD2QIYj9IZ?=
 =?us-ascii?Q?kxdI5YbE9LCTx8GpCfC3U+vlJp9DCa8kPQlkz8c8uWsWDOGy5wAQTZFgCW/e?=
 =?us-ascii?Q?CvOxkNvsPgHOsXDOECU6d4z6E0N2D1tv497ZmPGi9EtKAIIpc+CrTcFwv1eg?=
 =?us-ascii?Q?0iJoraVsJtUxHlzFZGTXor47fISbc8mdGq12tTFHzQSvCWpRsDnqjmeHcXwO?=
 =?us-ascii?Q?vWblXwmEdhGa3YLVlNOzuAFM?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?1cWqxqKVCo8RoLdZiPbiuZxOyV1wdeQ8LSD52ze3ygXneFXUwdKzYTiZertw?=
 =?us-ascii?Q?Zh8TEWK0l/OhMbKVRVh1flMc3Pb0D6Piw/GQ3PHJGtWbZ8l977VLX4fm+M5w?=
 =?us-ascii?Q?NYyzckoFK2fwclLV3ueVN/tCo+fjlj5i+adyqXLKrP2e9HhuEV+TdAzyECxX?=
 =?us-ascii?Q?W7PgLGPTBJMeVxJ8LFFPZy96alOG4qNPz4cnj5cnuu5Nz1KVDT+PCkXQM7wm?=
 =?us-ascii?Q?ly0Nmr3GKc3o+Z6cMEYr6bdJThyujW4LAhsZXZHGCZCyI3tTMSykMrYE2ugg?=
 =?us-ascii?Q?YqjYDrvQP92f2Q+Zv0e3coss0O7B5IFtdpS7DbWcn4zlkob93nt4mPmZ44RR?=
 =?us-ascii?Q?Mfefu65DfxzigpxvBpqRWkkpPQ7IarLa8tF0RUlrypV885N4hgIi4U9xVVOr?=
 =?us-ascii?Q?loWwT6dsqPndhiMCHY1IENqmvOBaGpSS4RkkpPeqCVxhvVj2or/D6O2AnMA1?=
 =?us-ascii?Q?YdVKHGR9aca5hZzUb/MwKvzpzVjcyHtYjQbQX+x4NMIfvbPE+yIwNjTGFgJZ?=
 =?us-ascii?Q?W+YRbC209/4kOOjySo1CoPK8c+eYfl/qpqppD720MiIe+DVtNRZeC32pMRxB?=
 =?us-ascii?Q?Bq6et6tlH3tRlaZxCIJkFtPHzD+ZUoUqM4uE0WoI8ciykJ2EKWHj/mCsfkvp?=
 =?us-ascii?Q?xQ5LZn8VY7i6oO9q7ubbGx8IMSNrG8qPRIn9rWMaAaxgAzeEeVNTc+sp9Z4s?=
 =?us-ascii?Q?5UshHDcCGp4/Ii/Sjo4j5CwCUq4+pLsplTsf+DOrgbuwo4wDxfNf9XKtOxa1?=
 =?us-ascii?Q?e1d1UdlzoZcTUPbm3/aEmz51x0U1bBy4jbxeqYRSw9S8dFyGwaMC0AUHrr+P?=
 =?us-ascii?Q?9u11wN6PtwlptbNn6VkQKVsrTiDWa0dBxgqPl+oUdMLlLN4RUZulxO81TJ9V?=
 =?us-ascii?Q?srD5qUViSU8l1/6Imy0ePSVyKT1JLNXn3bMdyRAV3A5pzt6FSm8r/fbfOBIg?=
 =?us-ascii?Q?lrsXsv2lhFlzGahd5Wq5zEccLM07Z0NClvNAEHSOc3BFZ7EtDNlwpp8s8QWB?=
 =?us-ascii?Q?WI+lKwwZfm09g2+9JVdX2kifr4Qsk/wdOlKoz5ERPTJDrtJ4EZ6Bc939Jk5t?=
 =?us-ascii?Q?lVsf0LBElccnokzxbyJ14gD1AFQVJFeoyChXkFUS9HSqphpvZLB5MLYnjF96?=
 =?us-ascii?Q?TMvaWqpWZbHV/Iz6fmFMZK4zDhU+sFdaDGq9YsWvqlTCncAht0Mdt0l/a0fi?=
 =?us-ascii?Q?ghzRz/Uase/5zzealY2UTLmvyLkXaXRkBdT+GM7eK8cYY7i75ZheXvU07/pD?=
 =?us-ascii?Q?1dTnHUFZt/WyM38d6tnLWkJZy92KbE2X1p06mqI8iYenKkQItW38otLJv4oA?=
 =?us-ascii?Q?pyTf9Z3Zz3c37Z+hWicpf8nWUEdbQWJcC5s2wmW5TaUaSr0GlJNOcFxiPg1M?=
 =?us-ascii?Q?gJcXiKuay2E6QVwPmWihNm1E6XpOry7mjJmpIZw62b/M1fY6qJke80DdfRuL?=
 =?us-ascii?Q?d1HihzzWoNk2dZG+rdXshIEw7vf7JCXAvgG3T8zBmiIDTFb4+vxLeh8PHuGb?=
 =?us-ascii?Q?jI38j0sCk9IGshDK/COP5CaJpApELP1zXHJiIP+OvXTTurX5OilWGqQSTYkJ?=
 =?us-ascii?Q?w/Kv2vJFsxjOiPYxGS7QMziY5cHJOD/SDdj9XxowuNbMy/ruO0GnZLVkW9LI?=
 =?us-ascii?Q?MLxbCzbT8iOGWF6UJPp5AMU=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ZL8dQ25Ukl+uQ7s5qgtypcxTFPUoLfZo1fVxlC9/5z6mnP6vpuQ+b+5GcNrRXa/QS3UZfFEKZHhKPdDENjfy6tRQnqWcpGCwsr8v8ruUHIAHHB9HAKvb2Rhdp4HhMQiiUd6mJJ0zCD6QFfbbgRshFe4Tbzj9UiBAlsAyZVaYch4Cl4y/9zj141Zq1rzsgp6SK9oXl7VD9T9jdUG9uFckVi1ukjyRsptaPxLHfTIlNLHN/diGrxQiunnBsTjIaDivJjhrxu8x4s4PqA8pD90y0wpH1Fwl+zt/YMwSTMyShr/lpAdh9W5cmZLrLxzfchYez0usaqgfbYElkRuZSGEPbjAfNWsZzE3pBGlf8iRypcxDv5FLkSZeORuGC/i2rMxDkFrvYcEDXcuHOtduXPn+xVNyLAVdiZOkfMcJypXF0kcUqFPl75Z3rJZpTzBJWkBaCXtDHraHDNkND1bhhAP4zBqdvoAv+bC8yWlsj2pJ9RvVnsM51q74BO7YYYztsJ3bgq8ez8fXHLiO4GgODHsuScDe5rhiR20c+RD3YEGMLkXwwlWGG3D25cbgmq9ukZYy0Fz/+ICovtZ1qsbSieb6P4M1zqXUldoSMIyBR2LjUek=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f674a0f9-2001-488f-6739-08dc8fd7fb98
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 20:48:18.2859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CArCkYCB8THhFQuY9MzIqKcFq+FDI4ZyRW31mlB1QiKVW9MbCeQJoa0ScUBw0t9dLzRq+NEIITuoMrgoqO4q84YTpxlvIFaLuMHh2R4lK3I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6465
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_04,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406180153
X-Proofpoint-GUID: DvFan6nl07_jfjjaEFKhP8QRb8ieQPi1
X-Proofpoint-ORIG-GUID: DvFan6nl07_jfjjaEFKhP8QRb8ieQPi1

When storing an entry, we can read the store type that was set from a
previous partial walk of the tree. Now that the type of store is known,
select the correct write helper function to use to complete the store.

Also noinline mas_wr_spanning_store() to limit stack frame usage in
mas_wr_store_entry() as it allocates a maple_big_node on the stack.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 lib/maple_tree.c | 54 +++++++++++++++++++++++++++++++++---------------
 1 file changed, 37 insertions(+), 17 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index f40732229c9a..8ae87e512961 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -3780,7 +3780,7 @@ static inline int mas_new_root(struct ma_state *mas, void *entry)
  *
  * Return: 0 on error, positive on success.
  */
-static inline int mas_wr_spanning_store(struct ma_wr_state *wr_mas)
+static noinline int mas_wr_spanning_store(struct ma_wr_state *wr_mas)
 {
 	struct maple_subtree_state mast;
 	struct maple_big_node b_node;
@@ -4206,25 +4206,43 @@ static inline void mas_wr_modify(struct ma_wr_state *wr_mas)
 static inline void mas_wr_store_entry(struct ma_wr_state *wr_mas)
 {
 	struct ma_state *mas = wr_mas->mas;
+	unsigned char new_end = mas_wr_new_end(wr_mas);
 
-	wr_mas->content = mas_start(mas);
-	if (mas_is_none(mas) || mas_is_ptr(mas)) {
-		mas_store_root(mas, wr_mas->entry);
+	switch (mas->store_type) {
+	case wr_invalid:
+		MT_BUG_ON(mas->tree, 1);
 		return;
-	}
-
-	if (unlikely(!mas_wr_walk(wr_mas))) {
+	case wr_new_root:
+		mas_new_root(mas, wr_mas->entry);
+		break;
+	case wr_store_root:
+		mas_store_root(mas, wr_mas->entry);
+		break;
+	case wr_exact_fit:
+		rcu_assign_pointer(wr_mas->slots[mas->offset], wr_mas->entry);
+		if (!!wr_mas->entry ^ !!wr_mas->content)
+			mas_update_gap(mas);
+		break;
+	case wr_append:
+		mas_wr_append(wr_mas, new_end);
+		break;
+	case wr_slot_store:
+		mas_wr_slot_store(wr_mas);
+		break;
+	case wr_node_store:
+		mas_wr_node_store(wr_mas, new_end);
+		break;
+	case wr_spanning_store:
 		mas_wr_spanning_store(wr_mas);
-		return;
+		break;
+	case wr_split_store:
+	case wr_rebalance:
+	case wr_bnode:
+		mas_wr_bnode(wr_mas);
+		break;
 	}
 
-	/* At this point, we are at the leaf node that needs to be altered. */
-	mas_wr_end_piv(wr_mas);
-	/* New root for a single pointer */
-	if (unlikely(!mas->index && mas->last == ULONG_MAX))
-		mas_new_root(mas, wr_mas->entry);
-	else
-		mas_wr_modify(wr_mas);
+	return;
 }
 
 static void mas_wr_store_setup(struct ma_wr_state *wr_mas)
@@ -5587,7 +5605,8 @@ void *mas_store(struct ma_state *mas, void *entry)
 	 * want to examine what happens if a single store operation was to
 	 * overwrite multiple entries within a self-balancing B-Tree.
 	 */
-	mas_wr_store_setup(&wr_mas);
+	mas_wr_prealloc_setup(&wr_mas);
+	mas_wr_store_type(&wr_mas);
 	mas_wr_store_entry(&wr_mas);
 	return wr_mas.content;
 }
@@ -5636,7 +5655,8 @@ void mas_store_prealloc(struct ma_state *mas, void *entry)
 {
 	MA_WR_STATE(wr_mas, mas, entry);
 
-	mas_wr_store_setup(&wr_mas);
+	mas_wr_prealloc_setup(&wr_mas);
+	mas_wr_store_type(&wr_mas);
 	trace_ma_write(__func__, mas, 0, entry);
 	mas_wr_store_entry(&wr_mas);
 	MAS_WR_BUG_ON(&wr_mas, mas_is_err(mas));
-- 
2.45.2


