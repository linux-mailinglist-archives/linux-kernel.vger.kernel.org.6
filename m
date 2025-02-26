Return-Path: <linux-kernel+bounces-533276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A86F9A457B4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 09:09:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 647E7188E863
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 08:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57CF21E1DEB;
	Wed, 26 Feb 2025 08:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cixtech.com header.i=@cixtech.com header.b="VoFYNTJj"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2096.outbound.protection.outlook.com [40.107.255.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A08018C0C;
	Wed, 26 Feb 2025 08:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740557356; cv=fail; b=EStBMDiMKSb+MjSI76gzBT589Rz9q8Q2UKoFLvVpTYmrRA+zu3KIVdg+gZXKJ7/b9ArTPe4zCgnTcK8ydOoqy+VAwDlhspQbckn5qpraangrzcBkteYqYq75PlfrF37YAv4VF4py644gwoZcpVyjKBUU5jxMemHLiQkkHk3No4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740557356; c=relaxed/simple;
	bh=viRZxU/ZwXurH5kfFdsEQl7ABqaiKtFyW3RXMAqMvtk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NqS8qY1ZML0YYPiq9H9KMFRAoI6IqX0MVdvY0LlY4EbietCAmw7GvDpQ1YvVhJtb02lc+VkZjcLVJyL03ldRSAuiMxRrEWnulyo7LMKAELN8MjVH6fqkECB/kkefISevMKPZ/Fhv9Gv/s2UPMxeEn/VpzH/iTqAJKvlerR3m9l0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; dkim=pass (2048-bit key) header.d=cixtech.com header.i=@cixtech.com header.b=VoFYNTJj; arc=fail smtp.client-ip=40.107.255.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UHsRMDKSSF9NSvCNDMuBxEiqM8cX/3/2EflptBGRt98pFFXFSg+QZu8sN27b+oiXLQHZpk4Vml4hsHpwSxh0NOgdZr7H2i4nl0EZS3V2rvKUSy/P8RGU7OAalBQ2IqkCVvEv+fCMHj6t78ewv/XFw8KjitoGWQtISEVm9ofK0sp80vNUFqvfJtkZgopxtOQbxaoI+yx7GZ6qt7YVlmJHa6gqUYNUvxRPBQAKz164HxuF4XIrCHlHfwM/HBRKxhlCKyrHB0YC1XgR8Glrohb+fZsH6atLni8yRzjuwGDkwgu6d1WUsCmagqa0DZkn+DYlNp6pheeF6kdsBIutujbong==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U7nfxIdf8M/5IC9KVZlOZ+U6lRsZC040/sXFOP/9g+E=;
 b=G4oNkiRlXlN6YEG/Qdg8KMxfECntKIpyj3bxovs5DXGzfgQ1xSATWR0rtRzXvyjDL/0yywaPdS3tCsofCaL53DIpDh6onieDrI8apY2Le5Obxic/uk1okXRs75R52g0vpyQ7QuzOiQ3uPNLwjV82qveqQhY1MD7+OktIQAEdpVQk8ZYq8vowCBC4LGjdlpkPqb0GR8I0o70HjrKh0iNesmtD0P3c3lnoxU/BITQOyNouzK94tSQjzxDbCLp0eoeTuSjpk1j2ZEME473oovNoeVoByJgw02d1IAZ4s5tr7NzI4xumVM763dISi1sUO+2p8FjYhKXtX+NCCksTihtAqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cixtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U7nfxIdf8M/5IC9KVZlOZ+U6lRsZC040/sXFOP/9g+E=;
 b=VoFYNTJjAT1w7KpuvCeNCGRfYf3RlX5R6VI1vYco/sRYeuXidw3bopJavCc37Hf3awltO0qPSSZ6oqLh96aZOW5NTWH/f14KjYZ/B790aDxIDrzPLi7gHmQWT9wH9QNqTtwqIPcjuggji2ZB2SN1Ftm76yltjSkbwnxuuMFhPAXDZtHSws9Bsaw1lU+pFqHY60KGEdiNG6q8bDNqHRSqWn/Wdp7tCBetfR+HsEF1YFsg1BK/fv+gGk4tecRYN7lQFyH7AIV2urwCVWCTKRrz59FwbzYKDlG1oZW4X7w40wPFg/1GnKbTi2ZxuRfQl8hN0UIVt79w3ff88Dcj4UOIHg==
Received: from SG2PR02CA0104.apcprd02.prod.outlook.com (2603:1096:4:92::20) by
 PUZPR06MB5556.apcprd06.prod.outlook.com (2603:1096:301:e9::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.19; Wed, 26 Feb 2025 08:09:08 +0000
Received: from HK2PEPF00006FB4.apcprd02.prod.outlook.com
 (2603:1096:4:92:cafe::2a) by SG2PR02CA0104.outlook.office365.com
 (2603:1096:4:92::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.21 via Frontend Transport; Wed,
 26 Feb 2025 08:09:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 HK2PEPF00006FB4.mail.protection.outlook.com (10.167.8.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Wed, 26 Feb 2025 08:09:07 +0000
Received: from nchen-desktop (unknown [172.16.64.25])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 3B7C24160CA0;
	Wed, 26 Feb 2025 16:09:06 +0800 (CST)
Date: Wed, 26 Feb 2025 16:09:00 +0800
From: Peter Chen <peter.chen@cixtech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, cix-kernel-upstream@cixtech.com,
	marcin@juszkiewicz.com.pl, Fugang Duan <fugang.duan@cixtech.com>
Subject: Re: [PATCH v2 2/6] dt-bindings: arm: add CIX P1 (SKY1) SoC
Message-ID: <Z77MHGhUF6pPwLww@nchen-desktop>
References: <20250226012136.854614-1-peter.chen@cixtech.com>
 <20250226012136.854614-3-peter.chen@cixtech.com>
 <f89817fe-22af-460e-9f5c-a3347eba1892@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f89817fe-22af-460e-9f5c-a3347eba1892@kernel.org>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK2PEPF00006FB4:EE_|PUZPR06MB5556:EE_
X-MS-Office365-Filtering-Correlation-Id: a6e4e211-2e8a-4dd9-9de3-08dd563cd7dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rmhARDMwuanQ9Qeju5EaWqjhCQQ6CfFFkMD2C7uEVDJsEroo3fMteOeZSkss?=
 =?us-ascii?Q?HQIP1kFmgFwxSCyRry9/0OKIeaZSX1kz5WFQpkXZkNVlSiLE4aEVN/m6kegl?=
 =?us-ascii?Q?AR8xs5aIzH2IB0Q1wJ7r9NKfI2MnkGK0c5SNt8Vyf320g5X5Lk75eiIbKskc?=
 =?us-ascii?Q?bzNeiEqGp+vw014j/ZTOoyZYTWkpVKiP/GPnbPv9qK8/yvJ5eTGB5/WV78/t?=
 =?us-ascii?Q?xG3nJL52UamUOAqDlcij00gBy8rAhKDBcCVstrpQTTWU2rfh9kLHnEFIfptd?=
 =?us-ascii?Q?muZfPgzCq2uJ5+3puvHHjAUV2VpAf+HTX64cIMdNtKAZa1490jPvG6piYofL?=
 =?us-ascii?Q?ZDOPM6BXclmtNyyPBtv5TRDhXTqzvHkZ3Es5NPVM9Q9L4yOlU/XGCGIrxomm?=
 =?us-ascii?Q?wgH7llMshwC2XuLfdljn9lo307CiCKr8SUwwRQjbLwSxkZTQGE+nJGnEpygj?=
 =?us-ascii?Q?+53/fZmNSE+THKvzv2AKbw1spfS1C9fd+R/9lyB6OpqlCS5voj/eIUv0UZWN?=
 =?us-ascii?Q?1ac8fkFCtlmQeyC3rbIaLlAQCMZzAb/7WmVAQOZmFCB7WMNPkPK/lLc6Xu3z?=
 =?us-ascii?Q?OljbvnzZ4LZX/hvZK/IrwjtvMyNCXBgTsLNvrPhumXmUF+X7+3nYUsvibktI?=
 =?us-ascii?Q?i1B3sFG3QavLmlTT6Z9CoDo3GWlsR4WmM2B6uZwt7pDPeiOXzRcBNvQ3FXd8?=
 =?us-ascii?Q?QIa6NkdYYnsOuYOmhdjjSH6gCQQXPLobdqBdJGzlNNF1fZH8U5wfm9eLCcuE?=
 =?us-ascii?Q?Y+XhPtrW5jOr0GODs1evBNspFnhbQBeO93LeWdZLeck+WiR1EW00TLfME/uo?=
 =?us-ascii?Q?tgI8TkP9fdGnEp3U3mP1oKVXMVQOc0Tp/zrbd4/QACJ16eFYAq532IfSGKal?=
 =?us-ascii?Q?d8/Cb9h/gKsCNvfxLwbUH4b+luCTgml68kREkFUunQ+PldtQ7gpt6sdR9ryG?=
 =?us-ascii?Q?7ZMCQeARfPDH+50q7GFuojWg+cZqMqGABXJ49gBcOfOvzrsq8CnaFi7LBwPd?=
 =?us-ascii?Q?cH9Hqar09wuDf+bNOlkg1QNdIDK+Q95pVWNfwRMip66iO+gC8aZRLLa2M5I5?=
 =?us-ascii?Q?k5FDH7eYUNE34o9V2vm8dFXiOAReV5l5xAWTpLSl06Ym1IAZLubF+qOpqAw8?=
 =?us-ascii?Q?Ih8u6sLwses0KzaOcp6HmlDoeiyV37V5bjaW5MZs9S/gxh5Pogvur9m6d60R?=
 =?us-ascii?Q?u4WcDsEQyOAGAvf2Q/ctMnXyd2m149iWuHUDSbv8kI1Wop0qXfnOF0zg2l6T?=
 =?us-ascii?Q?lWlt358lbVZl4dwpxGaiygLIeWR+wN2eczK2nlPk01Q6iMyy37x/XtA9TGiW?=
 =?us-ascii?Q?FYtZdtswo0pmkZFVLUHwBrqPE06vG9qUTzpfhkIvxtaltnKOxp8FSQsntaZp?=
 =?us-ascii?Q?UWvxB4AJT3yB69bIXYuncY+Q/O44T/ZVcDtPBTufzgV/8GU5ObPiBYpUOIxh?=
 =?us-ascii?Q?k+KlNFkQ5Jk=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 08:09:07.3786
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6e4e211-2e8a-4dd9-9de3-08dd563cd7dd
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: HK2PEPF00006FB4.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5556

On 25-02-26 08:02:12, Krzysztof Kozlowski wrote:
> EXTERNAL EMAIL
> 
> On 26/02/2025 02:21, Peter Chen wrote:
> > Add device tree bindings for CIX P1 (Internal name sky1) Arm SoC,
> > it consists several SoC models like CP8180, CD8180, etc.
> >
> > Acked-by: Fugang Duan <fugang.duan@cixtech.com>
> > Signed-off-by: Peter Chen <peter.chen@cixtech.com>
> > ---
> 
> <form letter>
> This is a friendly reminder during the review process.
> 
> It looks like you received a tag and forgot to add it.
> 
> If you do not know the process, here is a short explanation:
> Please add Acked-by/Reviewed-by/Tested-by tags when posting new versions
> of patchset, under or above your Signed-off-by tag, unless patch changed
> significantly (e.g. new properties added to the DT bindings). Tag is
> "received", when provided in a message replied to you on the mailing
> list. Tools like b4 can help here. However, there's no need to repost
> patches *only* to add the tags. The upstream maintainer will do that for
> tags received on the version they apply.
> 
> Please read:
> https://elixir.bootlin.com/linux/v6.12-rc3/source/Documentation/process/submitting-patches.rst#L577
> 
> If a tag was not added on purpose, please state why and what changed.
> </form letter>
> 

I have checked the review-process again at:
https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=935897
It seems no one gives any Reviewed-by or Acked-by Tag.

If I am missing something, please correct me.

-- 

Best regards,
Peter

