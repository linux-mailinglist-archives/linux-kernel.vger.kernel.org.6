Return-Path: <linux-kernel+bounces-535388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B911CA471EC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 03:04:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5E4918819C7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 02:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F836839F4;
	Thu, 27 Feb 2025 02:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="GWZ6VBhY"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2078.outbound.protection.outlook.com [40.107.104.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1B64683;
	Thu, 27 Feb 2025 02:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740621732; cv=fail; b=OJypSWuJY9H0gPO7O2GQgVLoqok04XS3jrRFqVHgyTRMYC544HABKbjK+6I3T5F8MpEP2fUlbINBLL248+NUhrENSbgbVKuHi8/unhrNER6bcEqn4nic195KEoGoGsHWF7cf+4vr1A4ebqmOF/thOVFG3hUnHTnfLJD0DoeValQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740621732; c=relaxed/simple;
	bh=ObiUY6fpccpLl/0nHIvJSs5UCYVsmPD0yIQyUvMUTT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TWWhDekDC/XaIVqDCL1HsLS92l4PuKAGrpqIKbRRxxrOIrbzPDMWg5I626sQWn7qtsO8pCZhsscaSBItNhJgt5d4Myw0F2BHgI+ZrUIHEbvDixAA/yjjptyHd7DXOkbwpZ4YUGj/IpSmHVxP8H5uaSDwizFyLOvVdv1z1n/HpRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=GWZ6VBhY; arc=fail smtp.client-ip=40.107.104.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f72BiLhiZ78xatTCdoFMHYr6GpJX7AouQkhmZws138azfUY8ANkm5F3gwLKZibWR6BRqH81aURoOT3MZheQK1HxwZqBgfmBg4a4LH/40V5iZFxYiQwC/F3/k+cvPz8+LMiwvT+EcwuNrMbs5yW0TbDrNAD54t4kdLKLy8Mj65H/mZqT8/V6Gs4iWB7VjPj3C8/Pjqtgyr1vOyritU+BmyZjUXOllVSI7axCvFNhvNb9NxC6teadsRoKM1/OApSd/3DLBu85YeRdf2aVT6H2lMMa21Yj4yMPSPQxBahgKfZIdj4hNryBgoYORv+Y24NNvuHP2vcFbcCp2oRomkN9scw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kaV17JdUnZl0G19qmitsECZyXwTBiJaitC2/tsR0rvc=;
 b=l5XyfudtGzP6ItpcfEpu9B4d/xhsJ68ECDe6kKVE9+UcBGYPJe0m4gDIHuJbpQJpN3/qE02C9J3yPXYVuiJYCg/zgPVkw3sLAI/ApQ6vWMS/O34bYMLvRBRaWEKHsknMrS77rwAYdbqZetZx8QdNbc13rvvD2SQAs/75N9mtM2avTJerTXtjL6f713voF1b1ftAFz1BR4LL8jzCFrqMhKXX/9lsSclROSMAP20vsltHGVzsf8a+OWC90hHoWfl6e9qPUK7z6RAg9P6RjlHvDlP3jrZXZuoTSzCtDERDeTi72i4efGrCICZM3tNxRFsttYVjpgtQZ6rjzWcgwAaYmdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kaV17JdUnZl0G19qmitsECZyXwTBiJaitC2/tsR0rvc=;
 b=GWZ6VBhYMfRzsOX4sh1YxbgcUq8KajS+73sBHdxbYrxtvJ00jKWE1I7mT6tCgkdgfpJ+8Ev1mDJWAHL4gmooOVKRBvkc96JEKUOuHcUZa//siurU0pESw4+XEcl3Lh/O1rpV6B50ohrDC41JbmJDycn+734qj6j1+30nSiFkj9EeHd/hCyxlX2R/ZQ7CmeNKxnYbKwSk9sOagV2OdnwKPTWN/4QkZdrLPNmWshX/gSTdSug2B/jjPc05akSY60AU7QemAsBKGWczjPDkTrrMMG/6m5JyXFTMHqidrqvVY3XmEfHKSkz/RSotbzHr8G2JkaVXRjYEwEKKT7wtCBaH/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU0PR04MB9444.eurprd04.prod.outlook.com (2603:10a6:10:35c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Thu, 27 Feb
 2025 02:02:07 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.8466.013; Thu, 27 Feb 2025
 02:02:06 +0000
Date: Thu, 27 Feb 2025 11:09:24 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Rob Herring <robh@kernel.org>
Cc: sudeep.holla@arm.com, cristian.marussi@arm.com, saravanak@google.com,
	krzk+dt@kernel.org, conor+dt@kernel.org, arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [RFC] dt-bindings: firmware: scmi: Introduce compatible string
Message-ID: <20250227030924.GB11411@nxa18884-linux>
References: <20250226094456.2351571-1-peng.fan@oss.nxp.com>
 <20250226160945.GA2505223-robh@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226160945.GA2505223-robh@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2PR02CA0018.apcprd02.prod.outlook.com
 (2603:1096:4:194::18) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DU0PR04MB9444:EE_
X-MS-Office365-Filtering-Correlation-Id: cd68ca26-7058-4966-6f44-08dd56d2bc5e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EnpxZToDrf/6QsPtVYm3UwicOje0MJloiy8MzIDRKejUB4tS+PZPkfErLsMC?=
 =?us-ascii?Q?f+gT9gqSkFDNU9BlC1P+2szi6wuLUzEtTCHz7a3FWWx+cPrP/xeIUyG6Qqu+?=
 =?us-ascii?Q?zoShLyVcht/HzYngvc+dq0X/8q03K54OYlPcO88LWlGfXk6M50jKdN9B889x?=
 =?us-ascii?Q?d+3Ux3kqoPAoFT79PKEM1z5WZofW7TKnKZsP3hubbkd3fSCFoHWcXHtLlxcS?=
 =?us-ascii?Q?mT/Y4QIL6Wq+1weXpaOivNOtWoMzldxlZQyDNG42scMCNyvDhvAqcOoPA3Hy?=
 =?us-ascii?Q?IChXqjqrxqWFWUN/jO0xHd38NkkYijn9bVT/F+Ch7Lg+RTEpiXhhROTf6aV8?=
 =?us-ascii?Q?O4c55F0bjElEBOYF8TFYDbQF3w0IDPRPi3evDzFMH1p2r+8bNY2QRtD6Banf?=
 =?us-ascii?Q?RNyaazqRW95NC8Jt8OXHgTo/73wyWsl4DLBo2DLds0aDMqN2QuzwDdBAAERU?=
 =?us-ascii?Q?xReqmOA5RiqoV0SXrY2v408ff8qzG4s3h5cG4M8//PAyjGm7J4tKkP2wmbnR?=
 =?us-ascii?Q?pf+zPNhlu9mfJ7CnWRJWq0wgddKwXRN5GK7vluoNRlkeKu/xgOSCNtHsaMTu?=
 =?us-ascii?Q?Mkmvorn6P4qnkvMZNln7tSEn4xGsaFpoUnUCwo+HgK7jl3oEo7ECGLvjsXSq?=
 =?us-ascii?Q?b50E4B2RjPoK4FqWyFi/AtyfoCh0EhAc/m+O9zbxjIhPwir29Jdo/aGd3pza?=
 =?us-ascii?Q?ONbruwFTx8ECwsCt9R1D/pU7gd1tBHzGNrY4H8r5SPbDHBdNXIR/YfAzWOQE?=
 =?us-ascii?Q?9eeJodx1RbBIWx53mft6eV5rH78whfRy637vMooK1SDKSxXw6AhbqVs5bbLH?=
 =?us-ascii?Q?Nqjzam+DJe9sn9sAUKADvWSKwn2B6LgCIu97GdGF80dGa61lqzf3P+MjYrbH?=
 =?us-ascii?Q?cErzOu5DAUIOv4f7WeTJFBFIwAbkbRzV3DdYICBWJV/BwL/P3Dta0zmSOzW5?=
 =?us-ascii?Q?7IZUkJokm/+qPeV3CDPHyBv43x8rbsEqkGYJTJhtbRfwp+pzT+rsFdRsICrk?=
 =?us-ascii?Q?jHjzXutJKP85olvKDc2LAZHiP/zFUfXuAWbHvcWtbnazW4zUz0OAsoQyLiRK?=
 =?us-ascii?Q?r4ar/lRLbs4mhGtuxlMZ3LfZw4lCXluGcGN6yemu2CZHquAdM1XumTjJg90E?=
 =?us-ascii?Q?tWGMqidCJz/dknJoSJr8rhW1y5sIzGeEhTiQ7xJ9q1kE0H8VtIZ5NcSELQ1e?=
 =?us-ascii?Q?/mvEntM6p9nKY1a6ooECYEGVFv5hlkXMnkUnrkK4lp6SgzZJrostle9BqHpy?=
 =?us-ascii?Q?qv2Ls2MN6B68OXunBo99bmUagSn94Nvvjdm3lTlx0vqCi0AIRF9J0xmx1noT?=
 =?us-ascii?Q?yywdbdh2/AGWesvWxOim5woqlAJOYlEaIlxgP/OiEmlvcUO+0+zEx5b3G/YN?=
 =?us-ascii?Q?qb6y+cbFT3KPNohUbzrl8Kx+9X3pbIcc9QDvl3hC2zGxsjQZ6A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AwgZkMjRkyQdK+C4dKYs4rIiH+AvuNDGVxZ2LjD2bSaZ1X3c0UsR6hLdGWKI?=
 =?us-ascii?Q?UVDrO1t5ULrPtSzQJ26S4VfvcXbk1KkcrA2HKDiSYSBrAPC1pm8x3HY7ChNl?=
 =?us-ascii?Q?akWphIDFwjePfH9ser8tLwAvSnkJJw6mSNeUGKzYAKpPkYSXmsIAzEDc6gcE?=
 =?us-ascii?Q?X8EnWQFUgK5dyLLXiel5kZyjfnfGuG0F0UnixD+kFx9c6ps8FnH28mXyortf?=
 =?us-ascii?Q?/bwxoSEM9Z834NuEGuvlxFJcWSYsz6xxBOGkPcgRi/dC754JeI4VbkoFU0pO?=
 =?us-ascii?Q?sTYtHlkwJop5ycJMuGp6Ud35munmMTy7uJiU8W1de9eBvG21bYJZCvIclPHO?=
 =?us-ascii?Q?JLqyuQCiVYhDXTbqY9tLzFlj5b5Vcx3zCPwlAMYrZSYAQ9Bs6TD9pDoVuK0g?=
 =?us-ascii?Q?MuDyVoE9ZWF/3oKQWVzQxIb2GBtixMafSTXsguAjclpyui2/T+VdigNVCsf1?=
 =?us-ascii?Q?XMbolduE4dVTkUkzDystADMcMYWvGIxLNE8sVLZlv8JUk4SpWx5fWNy9jdO/?=
 =?us-ascii?Q?y5znDEVbY1mxmQ57qCP9w5s/7GMReF9GjDVDtqtctx4sqB2GGo7XCZU33KVP?=
 =?us-ascii?Q?I/fzCPIgII+wkWJGzlMLlWDtro58kwlq25XGfiWoLne1Ffem9Roupe7Vt6dy?=
 =?us-ascii?Q?i+lkcsdOVlUkrex6yy0QVCmZrRaI9ZQ5RgYMbhDVgID5zBnz78SMMClCC7Q4?=
 =?us-ascii?Q?ELg2In/E0xCowJDRTByqjTiJjjsjjf9C56PMJFVjsk10zK6TSaNNr4HgbStI?=
 =?us-ascii?Q?u0Jcmnq5vA+UeNzjZnve9X9Tlrh2yhGgBsaMd/9BsOfBe+nd0dHUxhVUayt2?=
 =?us-ascii?Q?00D3WmlDd66xy3RZPFyQYb1obJPDDXsuJpjgvGI+NhN96Zs/LR4V7aBeZMqw?=
 =?us-ascii?Q?soLmgFNBrLb+JJBQZpGzzLd7K6s7ePqKLwXLOSbeP0NxLvOVRSIXKEK2M0Zk?=
 =?us-ascii?Q?RpQH2L6gHmafDvDOtRowdlbLHTxjMRbercF8p2HKs5gxvRxxydcH73xT4roR?=
 =?us-ascii?Q?z/EsSxdHukIvbJmjrTUk+QV9nLTT4aqEm0TYiPHN0znA8xop+vl8/ay+3w1N?=
 =?us-ascii?Q?uz254k8e4RusimTRRK+xAG85NDm7Rq+pz8RA+9dVwFnQlE+CG5SlQvjvbcy5?=
 =?us-ascii?Q?uDzUJhhA4TiyYgTB5vKRH08tF071BXNoInHdAuobfKjHzIMLh0NzMIC4xmh1?=
 =?us-ascii?Q?Ist2hlor0cJFxREnB7vZ4vqxS9PFfpQm8LQepXCA31mbNVzjmXWS24EzhZTY?=
 =?us-ascii?Q?PdW3PfHxC62hqF60fGoyyKILBGFxrSlqCtuw99Tv/5yV/UoeDvrQyYAKx/z+?=
 =?us-ascii?Q?TV/BNWRj+8J58tF89SN5T+a/RzBx7bG4yG4dj8iqjF3utWPixbK1xo0wJ9Mv?=
 =?us-ascii?Q?ObeFFQnH01V0qkOF+tLnhp/o68Fawdu7+5OqondrJkZLaHaGiHQlsSKNaEbS?=
 =?us-ascii?Q?h9pz5zYlTdtYtTvltXdSmY0RsRmYI8F4bj6PZkI7hVCpcBrf/FQufgyUXAfu?=
 =?us-ascii?Q?AGVXEYtb1bJwvh/AZaQCylDzlfQm7DRoJA9Stsi2NQXBsep1I98rW5keDxdW?=
 =?us-ascii?Q?3WPqH936GZRh/+VtQDLtaw7N5aGshcQ4p577D8yR?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd68ca26-7058-4966-6f44-08dd56d2bc5e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 02:02:06.1978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DkdmN8rQCixaY1wxhRNsso79GH066e0xqS2SPuc4kZVSBOl0BY2S65enlkV+uh/PfBE+uAuRMZgpS7sEyNU+mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9444

On Wed, Feb 26, 2025 at 10:09:45AM -0600, Rob Herring wrote:
>On Wed, Feb 26, 2025 at 05:44:56PM +0800, Peng Fan (OSS) wrote:
>> From: Peng Fan <peng.fan@nxp.com>
>> 
>> Add compatible string for the protocols by adding new nodes
>> The current nodename pattern is "protocol@[0-9a-f]+$", the new node
>> name will be "scmi-[a-z\-]+$".
>> With compatible string and new nodename, cpufreq and devfreq could be
>> separated into two nodes. And fwdevlink could correctly link suppliers
>> and consumers.
>> With compatible string, and driver updated.
>> - Differnet vendor drivers with same SCMI protocol ID could be built in
>>   without concerning vendor A's driver got probed when using vendor B's
>>   SoC
>> - NXP scmi pinctrl and ARM scmi pinctrl could be both built in, without
>>   concerning arm scmi platform takes nxp scmi pinctrl node as supplier.
>
>How are you going to handle DTs which aren't updated and still don't 
>have compatible strings? Seems like that would be messy if not 
>impossible.

The goal is to support 'reg' based protocol node and compatible based
protocol node both. I could not promise what the end would be, but things
will be tried to make clean.

>
>> 
>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>> ---
>> 
>> RFC:
>>  This may sounds like that adding compatible to resovle linux driver issue.
>>  Yes indeed. current scmi framework limitation makes it not work well with
>>  fwdevlink, wrong suppliers maybe linked to consumers.
>>  I have tried various's method to not introduce compatible, but rejected by
>>  fwdevlink maintainer or scmi maintainer
>>  There was a long discussion in [1][2][3].
>>  [1] https://lore.kernel.org/arm-scmi/20240729070325.2065286-1-peng.fan@oss.nxp.com/
>>  [2] https://lore.kernel.org/arm-scmi/20241225-scmi-fwdevlink-v1-0-e9a3a5341362@nxp.com/T/#mdd17c4b9b11af9fae0d5b6ec2e13756c2c6f977d
>>  [3] https://lore.kernel.org/arm-scmi/20250120-scmi-fwdevlink-v2-0-3af2fa37dbac@nxp.com/
>> 
>>  The binding changes are posted out to see whether DT maintainer's view on
>>  whether introduce compatible string is welcomed or not.
>>  I not include driver changes, because this is just to see whether people
>>  are happy with this or not.
>> 
>> Quote Sudeep's reply"
>> I am not blocking you. What I mentioned is I don't agree that DT can be used
>> to resolve this issue, but I don't have time or alternate solution ATM. So
>> if you propose DT based solution and the maintainers agree for the proposed
>> bindings I will take a look and help you to make that work. But I will raise
>> any objections I may have if the proposal has issues mainly around the
>> compatibility and ease of maintenance.
>> "
>
>This all looks to me like SCMI has failed to provide common interfaces.

What kind common interfaces from your view?

>
>I'm indifferent. If everyone involved thinks adding compatibles will 
>solve whatever the issues are, then it's going to be fine with me 
>(other than the issue above). It doesn't seem like you have that, so I 
>don't know that I'd keep going down this path.

There is no way to build correct supplier and consumer using fw_devlink with 
current scmi reg based protocol node.

To build correct fw_devlink supplier and consumer, need provide
more nodes, not one node for multiple devices.

As fw_devlink maintainer said in
https://lore.kernel.org/arm-scmi/CAGETcx8m48cy-EzP6_uoGN7KWsQw=CfZWQ-hNUzz_7LZ0voG8A@mail.gmail.com/:
I also pasted at end.

"
The problem isn't so much that fw_devlink doesn't want to support
multiple devices getting instantiated from one DT node. The problem is
that there's no way to know which of the multiple devices is the real
supplier just by looking at the information in devicetree/firmware
(the fw in fw_devlink). And keep in mind that one of the main
requirements of fw_devlink is to work before any driver is loaded and
not depend on drivers for correctness of the dependency information
because it needs to work on a fully modular kernel too. So, fw_devlink
just picks the first device that's instantiated from a DT node.

I really hate folks creating multiple devices from one DT node. One IP
block can support multiple things, there's no need to instantiate
multiple devices for it. The same driver could have just as easily
registered with multiple frameworks. So, ideally I'd want us to fix
this issue in the SCMI framework code. In the case where the same SCMI
node is creating two devices, can they both probe successfully? If
yes, why are we not using a child node or a separate node for this
second device? If it's always one or the other, why are we creating
two devices? Can you please point to specific upstream DT examples for
me to get a better handle on what's going on?

Btw, there is the deferred_probe_timeout command line option that can
be used so that fw_devlink stops enforcing dependencies where there
are no supplier drivers for a device after a timeout. It's not ideal,
but it's something to unblock you.

The best fw_devlink could do is just not enforce any dependencies if
there is more than one device instantiated for a given supplier DT
node.
"

Thanks,
Peng
>
>Rob

