Return-Path: <linux-kernel+bounces-391032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E52BB9B8178
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 18:46:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5F901C21768
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 17:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DAF31BC069;
	Thu, 31 Oct 2024 17:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inadvantage.onmicrosoft.com header.i=@inadvantage.onmicrosoft.com header.b="BkMc5nJ9"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2112.outbound.protection.outlook.com [40.107.220.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F58112D1EA
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 17:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730396811; cv=fail; b=F/dGgJ3eHUh1eCjjzlWGDfYWyGumiZMC2DWlhYMbQP6q3CHACSLP7lc3P6+47mjWnJk02XqKrg83wziF+v5G3IEYYR7kHKmlNe+97I5m5r3BNF8RzU5Exo36yo13tJo25eEJ9ABey5gGKfDvyHtHKls3lGBFZVUeackL1C4XZaY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730396811; c=relaxed/simple;
	bh=nAhf1t4KwFsWBjUSEnFNuGhe5GVcL0e1mK93rO2cyM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jlHKbuw4FbjGJlpQva72WgoIW0TMGWVZC/qIe0L03tNmtqCSJ5GXRpWCQoOI6N6v+v1sZT7cXkQb4jO+rYu2PlIcMXv1Y7Xyi6Nr/KAWCTEFcL26IhnGMONYwn2P18yxV+KK0id5/Y0d34YEqmItxaD6YOB3OvpPNzLdMEgfBJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=in-advantage.com; spf=pass smtp.mailfrom=in-advantage.com; dkim=pass (1024-bit key) header.d=inadvantage.onmicrosoft.com header.i=@inadvantage.onmicrosoft.com header.b=BkMc5nJ9; arc=fail smtp.client-ip=40.107.220.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=in-advantage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=in-advantage.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V8ff1o7nES+Zym+eWskgF9gZ+nO/fwGwCTpoGXJOEQUKP6/EegNN50VXsCNoVtQbsaMzX0LtidhPCumqSGCrZJXc4uU0UHybnrxpNQ5EmNOKXZb5m+ovG7rlcRci4vBUVpmXKJ1c1onG/nWnHErWd6CZ65u3x+4zz/5GpmE2KTWhYviLEoHOrjeMuOAqw/2cPMJc2sMRbLal8yyj613VZLdy3nObWVyjTBEU8k3/ZUnjQtL+bRoMbBtfUrSHjEc2q7HfduCABfvoUDUvbai+oexKtpXYgdcX94CBG+GZaQ2z5XI2/5Sr0+UCjpz4HMnHVFs9PM9DAphF2iv6VPiXCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ir3vVjBe+S+gjA9OO11ZFvfTS9Omnaq/qWkoOqzhm5U=;
 b=WZv/AhE1m9TLIrpDanHZ/M+fcoEXxudMrWuAGEq4RmsOoglhf05Khv5vBeSO8I4g82Afrzi3skaYhkO6f252pBjt66YT1L/FwVElKx/xiv/4fxjfDGWfsjRZ4Aq1qbjlH6II15i7JS3fN+HatMU7qtXdK1ARQLbg4CNx/9dwOfKhMc8G/0Ba1hQ8bXISk7ciOrVQGnopfp97FFozH13GfxnhiGsXJ/+8j5nD6+mtHkvfakq82h6ge1oTFP6ZhGMwK3evD3AmbftTmPwm2PREjR4q34OEtPGtpdYEPlBdIwcYUyU6sXOvpnBHcEXckCfEr2R/wnWyb3ZcPXo+suXK5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=in-advantage.com; dmarc=pass action=none
 header.from=in-advantage.com; dkim=pass header.d=in-advantage.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=inadvantage.onmicrosoft.com; s=selector2-inadvantage-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ir3vVjBe+S+gjA9OO11ZFvfTS9Omnaq/qWkoOqzhm5U=;
 b=BkMc5nJ9cEGI5LQx1USTvaz2sEhSUaRIJGKnXkVyX0JhALXaxyXJNFlfG6hi3s4Mg8iNvFvkUr0RVyWb7HbBn9wOy7gN2GbFERzRCHZzBw2C14N03FqPxhqkPq1bcI1bv/JsJYCRgsmNl6VLesMxXf+1NoH2VPQ3LWUQiun2vbQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=in-advantage.com;
Received: from DS0PR10MB6974.namprd10.prod.outlook.com (2603:10b6:8:148::12)
 by CH3PR10MB6740.namprd10.prod.outlook.com (2603:10b6:610:144::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Thu, 31 Oct
 2024 17:46:44 +0000
Received: from DS0PR10MB6974.namprd10.prod.outlook.com
 ([fe80::7603:d234:e4ab:3fea]) by DS0PR10MB6974.namprd10.prod.outlook.com
 ([fe80::7603:d234:e4ab:3fea%6]) with mapi id 15.20.8093.024; Thu, 31 Oct 2024
 17:46:43 +0000
Date: Thu, 31 Oct 2024 12:46:40 -0500
From: Colin Foster <colin.foster@in-advantage.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Jinjie Ruan <ruanjinjie@huawei.com>, linux-phy@lists.infradead.org,
	"David S. Miller" <davem@davemloft.net>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Thierry Reding <treding@nvidia.com>, Vinod Koul <vkoul@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: phy: ocelot-serdes: Fix IS_ERR vs NULL bug in serdes_probe()
Message-ID: <ZyPCgOByeVNZC5rt@colin-ia-desktop>
References: <ZyOUr7iDa9nFBxgq@colin-ia-desktop>
 <28bef742-84ca-4d52-8d19-258f1a3d695b@web.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28bef742-84ca-4d52-8d19-258f1a3d695b@web.de>
X-ClientProxiedBy: MN2PR01CA0054.prod.exchangelabs.com (2603:10b6:208:23f::23)
 To DS0PR10MB6974.namprd10.prod.outlook.com (2603:10b6:8:148::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6974:EE_|CH3PR10MB6740:EE_
X-MS-Office365-Filtering-Correlation-Id: 55fecd7b-b419-4d93-0041-08dcf9d3fbb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bqhgIiquqbE4VhRy+mVZwxp/1OePVFC2+CMTyIN2/LCgB2Da+E2LLkKT+gPg?=
 =?us-ascii?Q?nIGzdKKzOrn1aHXPr/c6puCipsyvSLQ4EFvSY9aM9M32XBmXwuSzE7/J184E?=
 =?us-ascii?Q?8w3HnAaHXtr+VzPMAKo1i3cV6YMAXx92Wr2u7LEZZOp7xH30iydNcW9iAZZh?=
 =?us-ascii?Q?Knh6BjBDT76Qz4vfjAdY6+kPPFeXZLm2qojeVtv51XJxq61etFPAWFoP9cyX?=
 =?us-ascii?Q?2OY0pZSsRYj6akANG/M3pmDj+YiBebK9uptgMC+7hq0QKCU2ZgwvRa0wC9cf?=
 =?us-ascii?Q?ITjI521JKm09UeYQNKFt6904XjpnPjX7AIi3TwW3BaRqsxedUA4CiCzelLPp?=
 =?us-ascii?Q?BF3nk+pMce+AWJ5RN1T9URBOKU42GEGRXO50RVZnykjC4IA+EdAu+/6v3A0p?=
 =?us-ascii?Q?EQeDR78lrv1jQU/9BQNGjAajgta4eQXAluCniZPPp3lSLJBwrnR5tjJbRAfq?=
 =?us-ascii?Q?YAygXp4PLOymCEeVM2O/oQJxHupr218qEonOHxoax/PN0ags5tAgzKgJ/4Ja?=
 =?us-ascii?Q?hcWl9lFopSaqoFnl/eEtkpr6hsRYU34iTuTD9YtttASGEKt2cz4TxtyHLIBO?=
 =?us-ascii?Q?TVUi2hDcrRROLoYGDBU5cHs3i2CeEXwjBDYWWf0ctRj0pFNPm6DSTRYFtObG?=
 =?us-ascii?Q?Aaxk2EnEpi7Xex1+NLHsc3mb5byVFbzkkudGO+n5WM+OS+o8YAxjBLAw/z9j?=
 =?us-ascii?Q?2C5fXScVxxInQDM6y4Ijyoj/gjS/khTCOGxDZufKce7v3BBSwUawXRXUhR1r?=
 =?us-ascii?Q?INn8WefSbzJskENpHCEaMEPXbo5o9rwwoxp1fpUdBssKOWWstCtBzbkJrVVO?=
 =?us-ascii?Q?UHzNhISfd29u9D2MqTjY/QjO1kIGY/kuAF1ZYu3chLKfDAyJhkaxR6h6Zxiy?=
 =?us-ascii?Q?O6cLScj2ynEspMKo9/Ypc4v8KE5uik/9c5zoPqiZTcbdNqP+1H2hbXN1W3cr?=
 =?us-ascii?Q?OotmcV4TtXWyyCfBM+lHz5QBJbZkf4BrcXG4mlNEVC+KgCmmWFvvwvHp40qd?=
 =?us-ascii?Q?2JcfPOJ522nnRm5kPEkITbtkkF5NultMZT/0IR/V2xAilMwZ1yR3+2w8gdLQ?=
 =?us-ascii?Q?dZcAsjo0TnX0776eTVDCcFoeJ1UjU89OD7imNJRFG4+9NJJB+8bpocVFQ+MO?=
 =?us-ascii?Q?b5dHQdpgJSBssBt+S3WF2mIET9X23WMuVTzhqdXgpMo59ViS2s9r7I0GgYCG?=
 =?us-ascii?Q?DRwN4TpLCNDhxxDyx8tWxS3mOBv1lgxmguNUieTUQN8A3rUTkEG/TMoOZ1PX?=
 =?us-ascii?Q?sNOLeg/cfu3guJXe9AtLus2nP9Wv4ts6oAg4lJOkPUvradLQZYptTxsdyVBR?=
 =?us-ascii?Q?MIQhewCyRTIGQqiACGcAcvPS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6974.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zm70sUClcWe9jsP6wfxp6LKl9CoIdP2M2KlsN9+5Z3wDYzuonsgeEV8SzYml?=
 =?us-ascii?Q?eZil1mHAINulBGcRa5WqSQ7/ccI7rRB9JUdTn1tWmDGcAgVtkRjMJeBQOpnz?=
 =?us-ascii?Q?7ZfIn0hvqxl2vgoTWdhJdYK1vuhKw+iPy/GQB0fg6z+v7Lir78RH3CszeJq7?=
 =?us-ascii?Q?0BL3dURbVf+rFjYlvPqxGvNa/+dSfspkQUM9Hm60dKg2dU9iXrX3/tG8gFkw?=
 =?us-ascii?Q?wB0sf5Tctj768cbMLSNUfbdLleuj+kkYcbbZiy54thm0B/Ue/4CZLHTcPTT6?=
 =?us-ascii?Q?fNyzQ4BV0RDeJOjXMpupAP46G9V8w0/Yp0k6hxdXr0UBWugT430x39XSn47u?=
 =?us-ascii?Q?6g5cT0Lhu35epobP3Kjn7YkZDKObisgRHjWuXRZlA0QOyS6190915TDlvX9E?=
 =?us-ascii?Q?AnIBdtRa84c2+hyS2V1KJTTzA2boPXzt9SFEor1O2kkyw/L+2wXV8IMI1jFX?=
 =?us-ascii?Q?BPcwEUAco+GCeoLvmIR6mPOFXlQLanv2cLe4Wj4S/PEUaDQfmDhzwOXBvcJN?=
 =?us-ascii?Q?d6qK8TtQGWJ2bOOK50lAW34DQ9A3rxutkYDI+1gYi0By1e0oMLgSl1Grm3B7?=
 =?us-ascii?Q?coeB6dR6+FUmKUySlRxufYyvRmmTpZCb/hatAdRtRRs1X6j/Viks9F+tr9Tv?=
 =?us-ascii?Q?KJLetSMLnK3EAygyJal6GB6rAMNqtpmg97KB6Ic+m4CWzXw8bNW1s7uA+PLt?=
 =?us-ascii?Q?CDrdn1RcYMToLze8KLRh1XkxiLgoZNkghwV9T2DeGAU2AWbDbAiHd7t55bPq?=
 =?us-ascii?Q?uk7XbAmVor5dtrPZo6jDPDFnrDZpbIOaLtdYtuYz9BAFq2mKpNnDXGBnB6b8?=
 =?us-ascii?Q?XziNHJqLxX/ZjmbeNawcVGQMyBs1dGC08p2o6g9lL1TCZ432hbn5SjB55htz?=
 =?us-ascii?Q?D/Cwgwa20G6uZrHCrCZZZOv94MvP9M53Y8v+/NRrDQ4RmHI4H7MuW6jluulj?=
 =?us-ascii?Q?VTXyF9J4u9ijHDGQY0fnDOPchqGLzi6q28OpXilFNvuhOwYxZAWSolDuxcg7?=
 =?us-ascii?Q?lTNGHZ1ZFzlGN787bdp3nels1Mycqyhp3Th35QCEY/R/ilt+rWwpm4zx0+g6?=
 =?us-ascii?Q?xOrewo7f2Kxxl6k8KSweXAshQKDYHCq8umfXc80xwM8mQWl+qJagMz6ktWQh?=
 =?us-ascii?Q?9MFDbyDhvz/FcbzU64Nh6YgryHPB6N3zMImwYfuzxfPivMf/VTkR6QNFDgNo?=
 =?us-ascii?Q?KuBhm5wYN4cI5hZ0NxWLRK0Kep85KjEkjukuHGCyYG5zL4wiLrkydrx0g8rO?=
 =?us-ascii?Q?rw8ZyH4xzvgsQIJtUlQGQevI7bwtvDs1ffifCjhpow8JVxaHA1h0ipQY1qg4?=
 =?us-ascii?Q?7miQwByjSyIssfl7VxGvX7RBsEo3JqDYqlEh39nV+T3Plvvdpot2s5AS0wou?=
 =?us-ascii?Q?yGHjBRdZi8lmFeFfbOKGsYIXCx6eaX5YZZghkZoVq8GNxQ1aG3KwdEtHIiJ4?=
 =?us-ascii?Q?AOe1gOfPOF3FyOjcxQjT+0gFyzj5IfMEUyChLJq2xsDY9jN4NIYX5cOADBjf?=
 =?us-ascii?Q?P333UkZ8u+0/1I5Au1KO0dQzWK39Rqmsj6hb/NfHLClTiqqezKi1RAPfJ6K1?=
 =?us-ascii?Q?/q5cgFQh3/bUYbbe/EPEXWvnv/hq02ISy8jrxQ64Tt6WA2EqIjJCPIE5bqSC?=
 =?us-ascii?Q?Z27762YEEBY4X86qa7N4SnM=3D?=
X-OriginatorOrg: in-advantage.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55fecd7b-b419-4d93-0041-08dcf9d3fbb3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6974.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 17:46:43.8143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 48e842ca-fbd8-4633-a79d-0c955a7d3aae
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BkDGiv1J3mR9dAy4OtE3MA2z/kuVF9phzT5lqBezof6gE4/EDWC7fmM5/py4jHDrg3Z8EmdV1iiCJjLZeqoIMhqRLIcd1goz1RIQDr0uXBA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6740

On Thu, Oct 31, 2024 at 06:15:09PM +0100, Markus Elfring wrote:
> > Good find.
> >
> > Acked-by: colin.foster@in-advantage.com
> > Revieved-by: colin.foster@in-advantage.com
> 
> Please reconsider the usage of these tags once more.
> 
> * https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.12-rc5#n456
> 
> * Should a personal name be mentioned (besides the email address)?
> 

You're absolutely right. Apologies.

Acked-by: Colin Foster <colin.foster@in-advantage.com>
Revieved-by: Colin Foster <colin.foster@in-advantage.com>

> 
> Regards,
> Markus

