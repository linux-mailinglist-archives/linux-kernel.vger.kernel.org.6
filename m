Return-Path: <linux-kernel+bounces-533529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72790A45BB4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 11:26:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB93B1889EBD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 10:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECBE72459D8;
	Wed, 26 Feb 2025 10:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cixtech.com header.i=@cixtech.com header.b="Cr26lHWi"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2109.outbound.protection.outlook.com [40.107.117.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788C023814F;
	Wed, 26 Feb 2025 10:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740565601; cv=fail; b=tbiA7PQBKkuhN8Hd0dljJ5mHujg0kXUc+NOR9fAHzAHrwLX+tgN6hSfPHgWma63Ps+evoeWQGd0G3RHVHO9pyyc04kWreG8q/MoC5h8g5rFDthm5yORDoSpwTGDHrfjYP7jAzxtZM6tQ0cm5qA3vWcS/u+vb4wcAIU4y1v/uXsM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740565601; c=relaxed/simple;
	bh=j9y5cYhqU+XKFd+7s5uewxGWCDlfHPhZ4maygS8mHgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QJRuaj4mIdoJbXX2lCXYPo1nqYbePbna54HUxzxC26udpv2vpKAjompM7wv/UbcVsZYARkAuhvKLnrZKA6S1wM2lC+8YbhBQHXakOHTPqbbPIzZJFphvDThPOH3x0xjo1rrJhbvirKzCZg6+DRdGBokdoLEUKWK3v4PRKU2M4rs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; dkim=pass (2048-bit key) header.d=cixtech.com header.i=@cixtech.com header.b=Cr26lHWi; arc=fail smtp.client-ip=40.107.117.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qfC+8YfP3ZtfsvQhFXsUBWm3EbbTs41aH3+akrTyZ9TZzQRZxV49VGcKUuSDKxSu4WeZgWtX72bmsC2UflMifliDYwZoWJPfYLF9lY58OScLBnIxYU4X7kEqZHVIfPI/vI8JySRAhX155NMsL0mi5soDuoxz1wYtG1iBtIVViYvTjNnNWfXx38q8/IlC8YtigIs4o26HI4yipV3eNMgP1FlpYJEXfBLFd3wxKeCh5Ic76qYER4jfGg4GgPef127dGwFam4IjsJm6CvO+9EKh+RPqZk5t7fF75qbqqsIU/ZhHvlNnL8zlkZKzEcXyp74wJhxPz1HRSp6vcJGTB/xFoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mFwGxpqZVsiIQyRHtu3HZ4FyFrGFSfsxqg4vi/+HhNM=;
 b=vPhsChhshpFInoo21Ea9/fuyJ0Wc4/kKAuixODPy84CL1lFDhHY6gp0NBmw8ZoqQZ64TzEOHpk2o6LXNNnSnUchGzHIQSosQrQKraUncwrHxzh6NHkF5bXVqKzZuVCCBfUuTGERLvX75Qze5UdVsy/aINy/B0xVI9CI/hDKtYxFUDYwspiJcIYwRyDze9qyR/hIAVIlAqtlFYfOMZaPk4UvVMgnJR50jCrwJuIi78iXBsDsL2km9PdZGgS5PjNTESnmlcozkiPzqlmbVsoZxjzMC64s+3fzgET9ieppgRnNmDh40zcFUuL2gpiaokaCUkwjoVioAmE3aeEELkUWFcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cixtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mFwGxpqZVsiIQyRHtu3HZ4FyFrGFSfsxqg4vi/+HhNM=;
 b=Cr26lHWiBmRQuK1Zdn+vhDQ9iFbTsWUjIsUL7E44THw6sZOmyaThVMdeF6+sBvGmdmrM5AT5ffQyqdiLHNMGFkZHzqn+/GfMKC44/l2zogo4zatkCfYUJ2lM5MrEUPMZjYOVrRTmj/SZrHOTQtEqCH2S5+7O3+eaao7yWF7ofrA2ueQDYwoiI2xCs8mGyu9cvRU6F6lo3XASuTMZgtApkhBihvSid+rVW3TwvJ7hiiN72NL25LOUVcTUu/BwA2X1ML3x90iAKmlztUnIfnYz3B7H8zyTfrGbQSThXtmeZlwmXLHVzLRfvYQR0Ty8D89qtTF81mIzPj8PtXgN8s2m8w==
Received: from SE2P216CA0071.KORP216.PROD.OUTLOOK.COM (2603:1096:101:118::13)
 by SEYPR06MB6778.apcprd06.prod.outlook.com (2603:1096:101:170::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.18; Wed, 26 Feb
 2025 10:26:32 +0000
Received: from HK3PEPF00000220.apcprd03.prod.outlook.com
 (2603:1096:101:118:cafe::61) by SE2P216CA0071.outlook.office365.com
 (2603:1096:101:118::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.18 via Frontend Transport; Wed,
 26 Feb 2025 10:26:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 HK3PEPF00000220.mail.protection.outlook.com (10.167.8.42) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Wed, 26 Feb 2025 10:26:30 +0000
Received: from nchen-desktop (unknown [172.16.64.25])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 728B04160CA0;
	Wed, 26 Feb 2025 18:26:28 +0800 (CST)
Date: Wed, 26 Feb 2025 18:26:18 +0800
From: Peter Chen <peter.chen@cixtech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, cix-kernel-upstream@cixtech.com,
	marcin@juszkiewicz.com.pl, Fugang Duan <fugang.duan@cixtech.com>
Subject: Re: [PATCH v2 2/6] dt-bindings: arm: add CIX P1 (SKY1) SoC
Message-ID: <Z77sSg_3YC30oYoP@nchen-desktop>
References: <20250226012136.854614-1-peter.chen@cixtech.com>
 <20250226012136.854614-3-peter.chen@cixtech.com>
 <f89817fe-22af-460e-9f5c-a3347eba1892@kernel.org>
 <Z77MHGhUF6pPwLww@nchen-desktop>
 <d9556611-cfe7-44fa-8965-bc2b0f870845@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9556611-cfe7-44fa-8965-bc2b0f870845@kernel.org>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF00000220:EE_|SEYPR06MB6778:EE_
X-MS-Office365-Filtering-Correlation-Id: d3d7153f-ea0d-4382-65ce-08dd56500918
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?C/Nec0pjgc6Y0DmKTRk4r6sRPuCupsCmbZWfnkzbqM8PElTIIy0tYm+v5x3D?=
 =?us-ascii?Q?MPY0My0Ytbwq3K40U/oPcc64Pb1XZ5N7n4tbftekx8QmN3UqV+hiXDpc5xvY?=
 =?us-ascii?Q?AUAhWXGF6x4gnNmM1Z0mlvEdXH3wDzYfN0XjxrIBVKjjbAtsAjtunNKBLcMu?=
 =?us-ascii?Q?1XmIrrQwB+hnscvDQ+3BnCsbpujMFyb3SSB3MEmmPPNdnybHnvqGymhMtymy?=
 =?us-ascii?Q?q4A6sNaaxvSfPu4IF5DBFAm0WdwpkIXadoMdd4HZnFKu28yhX3U53cIPqRoo?=
 =?us-ascii?Q?lOHMd4NVcG9TEvXIgR1RC5274FoEAAWYVWZq+fpFiO35L9lClmFVqzQh4kw5?=
 =?us-ascii?Q?2/m3nRbaL5dXncc6sMd+92oPUYLYO5Xm3abhzr6blsHs+PZSAp/+bqaI/nDM?=
 =?us-ascii?Q?eNuUOkJBBqjIX5vyEcjE/a7zjvBlkIokDkko/7AI+s0G0YWeR/9VDEQ1Ph5t?=
 =?us-ascii?Q?QuqCRw9uPr9LVNB1W1eaWLNvio+ajOOcZrpQfoZOKqsuUnYoluBAABrNSVPo?=
 =?us-ascii?Q?8K5rp17+o59KF5KVkw7mOhmMIPBTi+tYq2twVjEdH40XwvTVI2o9xPvvv4ND?=
 =?us-ascii?Q?xDJc1pluhN2/tvlHUCxQeJaXAPAuPHH27pFIRrnc4RuxtP6233oyPrTgsP0T?=
 =?us-ascii?Q?J3Lic5o8dFpiaZwWT/v+3K0uKYd3uNoiaKegxaU8NEtcmeMwX+Kyho1BFBrE?=
 =?us-ascii?Q?VZ+9G41KB54tritvVGrFPVkvs859wpBOgs8cBVHb+7m2ORH7XB5HjDClyRjK?=
 =?us-ascii?Q?gXTVLE+NRsQyyV2YwbOzeBE9SPWdjmRXMNhmNwSjwo+FYPpRhGTFna6CX/4I?=
 =?us-ascii?Q?DY3YK+hCOoCdacxiZv15mJir1HXKbWgEbknzRnhtLUniGQUMY6L0EoxhxtwS?=
 =?us-ascii?Q?sQcK45pDbJPASqcY7gQnBjt1CoO6eWsPug7XdZUHGyXJ+V7wb0lS4PDx1/Q3?=
 =?us-ascii?Q?jfysVcwy3QI6UsqgwDjSmcgl2P17mAL6hPILu+2Z0AM8oJMidHZmeiNK9TPG?=
 =?us-ascii?Q?QO/kB5kXe21n3+osd275rJ6ow5KiL7pGScz8kUmaOitIlloCZAgcGspqes7i?=
 =?us-ascii?Q?YuAvkMMNoFJ8WI83RS3E76c5I5RkyIR6exMCqg6ouUrxqnmR28OaBHT6S+Y4?=
 =?us-ascii?Q?6LNHcEsOe2hWko4LGf5xFPnhkjUMQojJvWbKYNfMVU2cyehZzaqQKY2Qs5L/?=
 =?us-ascii?Q?4xMVZQOSJ/oQWWXkq24AOO9l19AS4hTekxUoZiUd0x6iQtEV81jh4ED2zNHI?=
 =?us-ascii?Q?bWNzVYAiLrczCNvzLLuE3Hz7tFaAxnwOhlkqB4RHPIfX9ySQAGNbgicXsiA+?=
 =?us-ascii?Q?4A7TzhYmxVl6JMT8SXJauTGgLpMQ8XGq0HeJ8I4A42PWVOanE2QPXmt0Uev+?=
 =?us-ascii?Q?dYl1ZR3ygTWp8jvhSJd8zp4R4Sx2IjwMVeAS2i4FBGiwB/IhZqQOhnq7TXpE?=
 =?us-ascii?Q?rEgd+75uDsY=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 10:26:30.3944
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3d7153f-ea0d-4382-65ce-08dd56500918
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: HK3PEPF00000220.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6778

On 25-02-26 09:40:06, Krzysztof Kozlowski wrote:
> >>
> >> On 26/02/2025 02:21, Peter Chen wrote:
> >>> Add device tree bindings for CIX P1 (Internal name sky1) Arm SoC,
> >>> it consists several SoC models like CP8180, CD8180, etc.
> >>>
> >>> Acked-by: Fugang Duan <fugang.duan@cixtech.com>
> >>> Signed-off-by: Peter Chen <peter.chen@cixtech.com>
> >>> ---
> >>
> >> <form letter>
> >> This is a friendly reminder during the review process.
> >>
> >> It looks like you received a tag and forgot to add it.
> >>
> >> If you do not know the process, here is a short explanation:
> >> Please add Acked-by/Reviewed-by/Tested-by tags when posting new versions
> >> of patchset, under or above your Signed-off-by tag, unless patch changed
> >> significantly (e.g. new properties added to the DT bindings). Tag is
> >> "received", when provided in a message replied to you on the mailing
> >> list. Tools like b4 can help here. However, there's no need to repost
> >> patches *only* to add the tags. The upstream maintainer will do that for
> >> tags received on the version they apply.
> >>
> >> Please read:
> >> https://elixir.bootlin.com/linux/v6.12-rc3/source/Documentation/process/submitting-patches.rst#L577
> >>
> >> If a tag was not added on purpose, please state why and what changed.
> >> </form letter>
> >>
> >
> > I have checked the review-process again at:
> > https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=935897
> 
> This does not matter - that's not a patchwork anyone uses...
> 
> > It seems no one gives any Reviewed-by or Acked-by Tag.
> 
> You were directly addressed! So you got email and what did you do with it?
> 
> And lists received it:
> https://lore.kernel.org/all/ac6c4a8b-a6bd-44a9-993b-3b743a172dcc@kernel.org/
> 

I am sorry about that. I checked this email with our IT engineers at
office365 administration page, it was not received by Microsoft office365
server, we don't know what's the reason.

I will put your Reviewed-by tag when sending v3 patch, may I get your
Ack for the 1st patch:
https://lore.kernel.org/linux-arm-kernel/330a01b7-7285-47fe-abb1-8d5fa71dd240@kernel.org/T/#u

-- 

Best regards,
Peter

