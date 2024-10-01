Return-Path: <linux-kernel+bounces-345773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4D198BAF0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 13:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E4241C2232D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 11:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64A91BF801;
	Tue,  1 Oct 2024 11:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jF2M9SV4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="InH2PVXO"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35ADC19AD4F
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 11:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727781833; cv=fail; b=itTzjHXRZF2HUpyj7wP6dEuF8n/3PesXZ12KMYrH75Cgxake/0wtJSOTWPeI+MUnM6zX7eyrwGz3pcy82J9TZ4w8EQoBe/Tu/g4k+75gcXNqH1nIlYWnBk3f7mCZ9eM12bfHke1WeLovQrNYQoSpur+LzHEBK/ERVsXFRYZI+Gk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727781833; c=relaxed/simple;
	bh=FkjkXIzchT6uY/QllX2ks20tAEXHTiVXqBLGXLaFY8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HbW4KBTGrmQLaH9LPr4WuGPX+dhnoQCb1HlQKEIVa3vDaSOTxuA2inGxoN3ZKlzTigPLSEY7a8L5+SOf73HGWG6ikc1Oj+fABERSQMbYrynRadMKIPaiCimT1X1jI8TwPZ7TDSR1w9uSBwsHDAqsTKpnNTqRgY1NY4v2Ah34DLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jF2M9SV4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=InH2PVXO; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4911vjCP002160;
	Tue, 1 Oct 2024 11:23:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=FkjkXIzchT6uY/Q
	llX2ks20tAEXHTiVXqBLGXLaFY8Q=; b=jF2M9SV400SasLWvIEaWN2pEXUahY9C
	43oree75Vnw8k4F0YN4XhWzPG4kRF7B/RC5FEXsjerZ7xWdp9ht89StnrX5ruL1S
	Hf/clyDkVDS2FuJTxlWDApWjmZh3hZnSf88foE3G5rsHSJ0RU1KpMr8YCZM0DmQX
	jbaF0sXv1ktmU3uBRvuBvWAwtifA5LNgukX2VVfze8pjh2+wXl39YRGRJGqfHKfK
	KgUmkeTVxVpkViBWtkQ775SMNGQotQizVtNSk2M45lyzHHMoRBtl+F8j95JAUloD
	gsNfCRcCylqTk0CV5P0OfSjPTeNFGbbzAuVkpmz3L10Fsp6f5oDeQ3Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x8qb5yn4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Oct 2024 11:23:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 491AkVek038609;
	Tue, 1 Oct 2024 11:23:44 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41x887dgf4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Oct 2024 11:23:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YDe2pc5MWVtoGQQE3yfWaDb18n4BLYTr48nefzpE30JqMoDRgsBSf4JxlHTeXdKfwJl6W+/vLlnYb7qV0ei0gCEyrRq9BkxShzcvehMWBvYYVgaxWYN0ctrNEQDx0Z7R9jSlCokXqb3gV7YqlroaqA2DuU8q0KzxgCBXVQNTA90QjLBySOjNeI0ZB15trUmp7PjDfjVpxnQRIpPcfViyzBK9e3JuwJN3Q9Y+0JDn1Up70JUWmprUfIkwFt9u+p42FKVlbJ6ttmI+Ynj7vLb0LDipg50TMHmi05iA1TiJJ6oVCtmTBei2f8lXJDLZUfDd0sVk1KjV/oSIjsF7gqEnaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FkjkXIzchT6uY/QllX2ks20tAEXHTiVXqBLGXLaFY8Q=;
 b=T8TNMpLnkrON/p651YjcoEqcYrMajDp4kEpQEHGGozyBJvNmC+nZjzYM3Iv2JZ8qfjMAvcP1dRcj/dVockqnsSCmvHQF9BrI+6TVj2+LJUpA3ly+MO1CWDl4s0oGTO2Qbb0r/G0vGVRPCR6AA+/N4ayYRNqy7hRik72GguTd3SWgy0vESyOyfWm93WFQIMj16a1FqphzKkHaDaOBS+cz+UKK9WGYCdYOMBU2lD3TYV8d6piA9KYrf3hhbTq/HZ8Jw98/15TJrcZv7cRWGkt+BHinmS0y5KKUwI9Jf/IzqDG8etp65B7TO9F6bW0pl86Txjt5xhWyoEDFjXAb80XXQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FkjkXIzchT6uY/QllX2ks20tAEXHTiVXqBLGXLaFY8Q=;
 b=InH2PVXOswfuFXfUrWjZHD/Cdq2jC5pDyENrjsFNjgaWYhyYrKtNX6o30AIozRwMw0dwZJyQQAyG3MMTwKR18zJXSy4YIZ4lqyNB4ZmTvtZjq4OF4ujm0vAxZxoL61ecJeJvkJWtmdnvRBUsrpTJKuIP2ckBwv9Rve+/Y6gePN0=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by PH7PR10MB7106.namprd10.prod.outlook.com (2603:10b6:510:268::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Tue, 1 Oct
 2024 11:23:42 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8026.014; Tue, 1 Oct 2024
 11:23:42 +0000
Date: Tue, 1 Oct 2024 12:23:39 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Bert Karwatzki <spasswolf@web.de>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 14/21] mm/mmap: Avoid zeroing vma tree in mmap_region()
Message-ID: <374424db-4b16-4d19-b372-c51f00a62db0@lucifer.local>
References: <9a97af91ba1925629d5c7fa1f1aec34f92123a15.camel@web.de>
 <fdaa29c2-e1de-4f77-a23e-8fa7523919b2@lucifer.local>
 <32226c4d16d2a17d8dbdbbd007d583a2a6a2663c.camel@web.de>
 <cb24ddf8-2299-4b65-af04-e8a1ecc180e2@lucifer.local>
 <386f485c-5dec-4c7c-81f8-a23aa98a72e7@lucifer.local>
 <0e9eb75f6342a7aaa1fd0eee3dcbbb15fb1f6539.camel@web.de>
 <81235f36-7266-4ce0-8175-7c4d0e6ae3de@lucifer.local>
 <dac4dd705b0c5084cdc15b3bae4d363bc6448544.camel@web.de>
 <ff1c8321-3830-41a3-abe3-6b32a4f72238@lucifer.local>
 <2933d931be9904d2e63cb419d190d2b3d17ff27b.camel@web.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2933d931be9904d2e63cb419d190d2b3d17ff27b.camel@web.de>
X-ClientProxiedBy: LO4P265CA0104.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c3::8) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|PH7PR10MB7106:EE_
X-MS-Office365-Filtering-Correlation-Id: d920531e-e5f9-4608-4f3c-08dce20b8125
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?h/+zg1As/NvwiMVEmSIdUKZLv8xnzvkrAAgiR4cYd5+09QNwyPStF2NDGF2+?=
 =?us-ascii?Q?oXIKc8GChpr+F0e+OY+XRIOsmA4Gbp0eI+NC1A0z6vG/epMaJfhj/E/Zk87D?=
 =?us-ascii?Q?QKObrwoE9VauzNrfHJfMlge9mbMCZjfCMJzQi/wFog3XRkg846L3uAoTwK3e?=
 =?us-ascii?Q?Ylpux9SK02ZOLYQC/m5CFfHFdcySHEBPS9mVXEHSVbDmGrp4E8cVS0AFbFKh?=
 =?us-ascii?Q?N4UxmoFd2GJWXhotHZGO9dmwy8QQznOhxKtQyWsRu5sKtVeKcMOa5vG2mPGv?=
 =?us-ascii?Q?EHrt40spjUVxoKKFS5YHhNesVJAaRm+grYS6+PHzroe+4AR52gFntDK9mlyK?=
 =?us-ascii?Q?kIm8y75ZXxs/o9dQAFgpmpW+WMXH+4EE342ExNxUttWwwzsPoSEj0jptLNYV?=
 =?us-ascii?Q?BXTaqt/t0ddLn2iq/79d3XqANaX0CH35W/FNQN9YpNyq1SKWBOhfU2/P0KBK?=
 =?us-ascii?Q?S7bpHRT+rd3ogTyngEXTObEQUrRLddPMD5mg6IPF4b38JNR1FzPOVGxu2pp+?=
 =?us-ascii?Q?pQmdGYrLg6PP/HbEuzrG3v5KRtjUjejuKRbGC9cvG6QE/SvGjoQGVNuEctGk?=
 =?us-ascii?Q?32+3rID0z+4PXk8qZz19GOEl6I8JAdN/6bPOsmHv3dgjpxPNEmTCogteHKe5?=
 =?us-ascii?Q?qJKU1GzcxdDwCo9XagiRC3sdZRv1cNa+TdH1WtrlwXzj2NAVNu8fhKlIkYyb?=
 =?us-ascii?Q?4A2HrIugt4yy5NNRq1kZejJXEEZmdDJOGTf1BdN0HRxPRGZkHHI3ujxDtHqw?=
 =?us-ascii?Q?lAMGcMgpAnlbem9h6GXO4pWw+k9Q2VPsa7236IjvIyQ1BCjoUAzF5XlJOQSH?=
 =?us-ascii?Q?FxiRO2/h6EXLx3Qbn1cUDZHbq/lgb+4aea0gQdGdxremzTLR/Dgna1pbGu2m?=
 =?us-ascii?Q?gL45IUfaP6kPU7DPhx0annLci2dxT7S98MW3Y0F7G2T9vcVquzPZiIg/H1C2?=
 =?us-ascii?Q?W+rFVqcnp8Xtypvxoztgi4WqfN9ILggscZzI7ziYchDdauI0S66QH9a0fe6l?=
 =?us-ascii?Q?zY3Lj75iZCIMeMM8MHpRlb7RBMH8FNKYItpyFS3DyBM+OTXVpsKYq2cI2Ar/?=
 =?us-ascii?Q?shgvhOJbI/CvK3HRp1qyM3Ohegj45J3FbkIvQhbwWJJJD4CmOXbVVhssnNBh?=
 =?us-ascii?Q?7YfcZVO2Joyiamw4RhjnDvVmB4Ahjhn5qxTO1JV7kWrR6xMoOCu74gQ4vbtO?=
 =?us-ascii?Q?Ucrx9RLAwANZ9YMdhxINvy0jQ7kinqKpDGI9Drr7zZ2sBW79H+zry3d6qGSe?=
 =?us-ascii?Q?bfMccPsL3WRZ4GdXKANWzcbNdy6+tpUtb05z2OzKAg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mkt7K2cWOYOXCXYwZ7iwz47M1PBBAbLJDh2UXUu3mL0EU9Nlqao/tWkrpxZv?=
 =?us-ascii?Q?eHnB0z0HsjOJARKeBHs3BmbqNHUfr2gZ3oYosRLN6+G9EcITioQG+t+X4GD7?=
 =?us-ascii?Q?fPZpe9mc+lmA9wVoZUGH+90FBmF4EZZhfYjti5gZORObc0shQGtMRAm6V5n+?=
 =?us-ascii?Q?Ls7vr5vbbXjxbmX5VKW9S5ZgAXfvzapfs0ErOzrrR27hx/qcvs9HiuGq08nv?=
 =?us-ascii?Q?p9WEjj2BkRyNFkO4HGqoEmzmlxgo6BeuOY+3OQNFm8mc1b9WQfSdKW8oIZ6i?=
 =?us-ascii?Q?zu0db2PNZb/u//28LgHw8w/cFwzDRCZXBIbZUYC4Au5gp+M2dRllcJcEAZGv?=
 =?us-ascii?Q?uLKLdFfSqSjp6rt6lmIO8ahNnHVRwSW8kK6F9VBq30YTta1L1rVWKutHzMNZ?=
 =?us-ascii?Q?oWpmMoyO+sFMMsPkpvKSLRDaXWBbOw8kU86V3W3osQESjc81XKOG8+bSr80W?=
 =?us-ascii?Q?4i2PKUstEBn2MfU/3mGjRuJ9g0SRlmQH7TKii1ztdAvJdbJYUql8tjLZFAZz?=
 =?us-ascii?Q?o+ea0SE8hvbFZTacMmOOLjKVcyo5u6PlRD6b+0GK+AK3Xs16gAfPeIflvQmv?=
 =?us-ascii?Q?PzUP5gv8+Lu7uHNdIE8A3tuhsasvnncVyEtnAciNiiq2StNLQnOeUAcUrYCT?=
 =?us-ascii?Q?oOUcbTaJbhOHzHelVszuUEPk5F/u7b3YBxFTp6gRIPaK2pFTStXAFATHNaFr?=
 =?us-ascii?Q?DXvsD2KPvh/7p1SHIV6105bduG8jENgXr+YLbeRdoHNtqXAJszRjWbP5aRJb?=
 =?us-ascii?Q?izIHfaiTHel+HCNrkTZ74DEc8u9ioTPa5sZ6PeG9xUawbF6IaBgB/myXQLC2?=
 =?us-ascii?Q?pOknBPRpxTIETmTB3YbqSb/ftcp2nJc4Zm0ZrUUun5cQhQjKMXkO7HyXcS4W?=
 =?us-ascii?Q?2mCXeCI+WBJRjQZbBmPo5xiRyeuwFnQCbSBhaEkbcDLVZ3HT9vk9aTdNviKg?=
 =?us-ascii?Q?gQXfF4mrouNa8nrDEQsjGqFHJ86XeroIuh8hshXRi3ZXYpD+WMcZeTA7jETw?=
 =?us-ascii?Q?+vwmws6wT0j2NV3LDv1IykNlTLUnupZyNNTKmmagZtB+3Kj7yeTz2dZFXcpJ?=
 =?us-ascii?Q?KytUszhum3NyHSGq9Jzpmk0NeAn0KY2nxTdW0KDINhbzZiM4N67PTKsJYfLy?=
 =?us-ascii?Q?GA23PmxpmTDExiZo2c55i0crsZqMOuzseUMs44ML1XuwvJPRgeGgVpGNEWHV?=
 =?us-ascii?Q?3285KE/kIOtjLv0Gu0YHtkVqDXcN0o/j1Ur7qwOIjIuQdQ3sdzcIMLkTjMda?=
 =?us-ascii?Q?hACWH6QhrkwddCw0wUgElPpL3xZv7yihK16EVeJQSTRAcNhBrQtXLkCrzXJG?=
 =?us-ascii?Q?We6a+DEAs0Z00ile7T5w7NhGsYjCV+cJMITMV2kaI03VT47chNCiy3M+vIx8?=
 =?us-ascii?Q?iccQhhljfJRFoH8nkjG7gS8RKtgtjISwwRL9bLpG057nf6MzUZg+5CUKZQgb?=
 =?us-ascii?Q?ah58zf5QtKmnJM06t7CKCCyGE0f0E5potc54y/JS35y5SuAiNF8Q4zgrL7DP?=
 =?us-ascii?Q?vYjXMajk/xQ6wyoKrX7b+eWRFJrpsgfzzbN6wa5Vv1iVUpl0AdPUr/BHw14p?=
 =?us-ascii?Q?XR85xtx/1VUDTj9Kp0fkN9tapHyQ0w9/VRAohpZuc2vhuojXul8rac+bZCng?=
 =?us-ascii?Q?hQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	I+JItCeCabWyMMnQIgpVkf3jg9yw0UNZcLCrzYl3474qumXZbvOecM17uW/yAq2Je0zE9gHu9CI9XWNOarfYotD35rm0RckKXaSol6tGVVofN4j3YbyzFJEOqX4WL3yY0751lsJUQJhziYkW0MnyNtAN7MvdLQpnfNtNVexx+ExOfh+FngdEMxYp5wr3lYewIBGaAuLeQnnpAWFA2+OkUJYYhAXZ1GYW2VzEHfAV7c4qQgbi2QdFGQXYJyJ1wDH0vT0l3tGXrAYYWn+/Ijc8tCZW6/XwAyU/MTOf1JpN19bKgi0MyOuTpBPwNdEPwjP26Jq2jE+tIDB42hzxBTTXmgpBEhJ2DjlExfu1nnWUaI19QiCjoBs9GZAet8/r0AvRWpBoKgemxsWrRSl+pASgqScNfizfhk4+VogsbV/0XpzmG7GNcxLF3smkYqxyHnFVA24mGBuKFUbUcWlp7dkWQdgjVJXA3c2i0TKhnh8uCzXKXlUrXhwzjcxMhuiqyfFNFeqSsk/nsOuY+NRt6czqErW4Wse3qhSGDelx0leUH5lSBIa7UVby2Y8I+pjuhEaBM3xuh0Rdjib2JHu3ZjsVzSOxV2bmyOYpaj7+5D2AJ5U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d920531e-e5f9-4608-4f3c-08dce20b8125
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 11:23:41.9849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8385/wHEwDNXj0N6PvA7T6AoO4qxcrmfE2sNBsF4zOK9mAM4VHI0jlrvRWhff55LlD+BLmzAIOigxgtN+LyhwKy55cVGfU/Jfe798Ef28II=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7106
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-01_07,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 bulkscore=0 mlxscore=0 suspectscore=0 mlxlogscore=936
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2410010074
X-Proofpoint-GUID: X_HAV3MRgbgXJbaPnUMf5iH_r-eOc_Pm
X-Proofpoint-ORIG-GUID: X_HAV3MRgbgXJbaPnUMf5iH_r-eOc_Pm

On Tue, Oct 01, 2024 at 12:42:33PM GMT, Bert Karwatzki wrote:
> Am Dienstag, dem 01.10.2024 um 11:33 +0100 schrieb Lorenzo Stoakes:
> >
> >
> > OK so what is less perfect is this looks very genuine and present in rc1 so
> > yeah.
> >
> > Thanks so much for helping out here - I may ask you to try some patches if
> > that's ok at some point?
> >
> > Cheers, Lorenzo
> >
> Yes, that would be ok. As a sidenote, when I first got this bug I conducted an
> internet search and found this vaguely similar report:
> https://lkml.org/lkml/2024/8/28/1558
> The report says its from 6.10.0, that would be not related, but at least from
> the date it's possible that it could have tested the v7 patchset.
>
> Bert Karwatzki
> >

Thanks it looks similar but as I noted there, I couldn't repro it [0], the sender
sent a bunch of seemingly bogus reports in a flurry and it seemed to be on exit
whwere the issue occurred rather than anything the change did.

Of course that could be due to maple tree corruption that only got flagged on
exit, similar to your situation.

Unfortunately we got no further information or details and the report was sparse
so I don't think it hugely helps us.

Thankfully here we have a repro-able situation (albeit, painful, sorry about
that!) so we should be able to figure this out.

[0]:https://lore.kernel.org/linux-mm/e50f9da1-521d-46ae-9e12-d82c4c093223@lucifer.local/

