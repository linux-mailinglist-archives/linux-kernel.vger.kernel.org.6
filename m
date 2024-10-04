Return-Path: <linux-kernel+bounces-351308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF57990F89
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 22:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70A5E1C20B95
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 20:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4162A1FAC4D;
	Fri,  4 Oct 2024 19:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="xqDKFSO5"
Received: from GBR01-LO4-obe.outbound.protection.outlook.com (mail-lo4gbr01on2120.outbound.protection.outlook.com [40.107.122.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02911DD869;
	Fri,  4 Oct 2024 19:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.122.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728068926; cv=fail; b=NxNlyN4ta6uMM27niOZRVw3T6JR5tjdyMRO3z9Hu2msKyQp8pQGNX8rIN1EihUjWd4a6HN1v2ired0zjujjNMNi9zfeRruwjmgFxq01ltF24HjzACddDvbK2TfDAbX6MuX46tA5whV5m3OKldxBEiFxqfC8r3m8xBdUk4NlK6AY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728068926; c=relaxed/simple;
	bh=LyF7+koiSDxi+HBadWUAthh0ymCi1q5dI3UNF/QCAls=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NcdoUVU9LmpDZ++awDhjda9o3VqSydnorWMaVOxnlmletI9Y2Zbe28uJhy236+aPgChyuvmukBmtfuQgdIPPzHeFlB6wIHXGhR2chrDEzQGxCoCOE1OUXLx1hDBuGQv3uumGMTPZL0BPQJMTiMrK/TXH7Z3YufUFWSLVrnbmvkA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=xqDKFSO5; arc=fail smtp.client-ip=40.107.122.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uze4YMxGX5b6k1EH7wKWSGzYAlCJA43MYtyet6ebZHtU3nCaYQefs3rDN5KBlj1yTU8CVSalkHyw/L9i+/cDXW09RoBy9SHH3WK8GlPX+PDXRVRepZdCeuck35xCZRVKlScDQPefJAXt1VyVMFJQRD/BG/U+vVU+G0gSBdRAkuHMlpZdfa1c6CYF+nCy3VGFzt0pULS1WCGQOgYk4CaF/DB4mVXjbl/Y5diHgHGts4wJG0+cOquJUfvg2muuV5V7DPcXYRqalsajjymshVSVZ60vCTnIdOP8jd/1E4WPcBP6bfJpk5U/KeGlMkpvWtsy46LBEK8apYdpiCWLxBqLfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B9TXnd+6n8rXzDan47aHjOrNXX13M1Z3Q3Wj2ACEEWk=;
 b=XAZ8ah6hhuw93ncUDDxwqnf16ZYHXXrithcp5LOw9EF3O+T708zEtNTXDWGcsjdV8V4s68BpvQEL3z/YFRoPXFgxoZ6mENJu0RJbcg/9TttkylueS7rHA4RjdQFa9b1V6ZC8KlL1sgMhgyRe24wFiPlPIX5L4DTVl5h0JiVH6CUcTxVk4HNtZjyfK1P85wwlNVk3uXkms+vJNddOLu3EPrG1HolQsmU+6lu+4IhQ0slLTOXZlc8W5BrwamcsscoLZ2ruPGU6Up/Lo47AVh0kOJ8VNYlg5I58UkynQx542ewOgVTVmCLW7yhj6gZDZl/QJC0+YEGGsYaa7xV0zKSbVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B9TXnd+6n8rXzDan47aHjOrNXX13M1Z3Q3Wj2ACEEWk=;
 b=xqDKFSO5eS98J0AyxTWQ+xx/Gxkh1YUPYF6OUgQ5YQXIzv6GHd417PKoKuFUHWYf0hORfAJ+ph1N10Yjko3DB+KAuZmxene66sxpaAQwHI885XOknFTSTqUXXw3hZTq9lIYNrlETQ+wA7jTMIjWcQkAL7ik6T4aOpzxJtmFs3Mg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWLP265MB5866.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1a3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.19; Fri, 4 Oct
 2024 19:08:41 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%3]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 19:08:41 +0000
Date: Fri, 4 Oct 2024 20:08:36 +0100
From: Gary Guo <gary@garyguo.net>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>,
 =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <benno.lossin@proton.me>, "Alice Ryhl" <aliceryhl@google.com>, "Trevor
 Gross" <tmgross@umich.edu>, "Martin Rodriguez Reboredo"
 <yakoyoku@gmail.com>, "Will Deacon" <will@kernel.org>, "Peter Zijlstra"
 <peterz@infradead.org>, "Mark Rutland" <mark.rutland@arm.com>, "Dirk Behme"
 <dirk.behme@de.bosch.com>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH 1/3] rust: implement `kernel::sync::Refcount`
Message-ID: <20241004200836.137ce41f.gary@garyguo.net>
In-Reply-To: <87cykfpuqd.fsf@kernel.org>
References: <20241004155247.2210469-1-gary@garyguo.net>
	<pKZ-hxxNoouLWnfXzFGWvcgGgfjpEixPzJ--cZeEufWI9_MoG_mpToSPflheyUhYmZ4qTKLVypVLRuvX7rfyxg==@protonmail.internalid>
	<20241004155247.2210469-2-gary@garyguo.net>
	<87cykfpuqd.fsf@kernel.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0190.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a::34) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWLP265MB5866:EE_
X-MS-Office365-Filtering-Correlation-Id: 013f2599-c78c-411a-f145-08dce4a7f5f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5ZC2g5q0kExnVL1T790OvHgv2ouqzLcRGHEQPfbzCu3ibvYgDuZVMTB0DpdV?=
 =?us-ascii?Q?TYEHEMay4eHn9H3A4wVWS7ql6yyEkHKSuw/6kvHbA1S31PnxIl4NrPUvWJaU?=
 =?us-ascii?Q?ZELCOsuu5zc4778/97fSRik00lFRMSdryyk8EzGOYND9b5PBuosaI6jJsjzh?=
 =?us-ascii?Q?URSrbymA8NOmBa1tYo18pCurevMrq7If+vNV8FOkTfRBFrcmGssioqlUkZ54?=
 =?us-ascii?Q?7JdYvbbzc8FWofjd59FRc6XWnmi/47nGs47TMEJKFp+GsY7G761eLJgSeUS2?=
 =?us-ascii?Q?vAhD1T6gU6RMBgaGewZ4tRIm4eFEZcN26xyz7zZyvcwn3qmEaLnK4FxEN7Fb?=
 =?us-ascii?Q?u+7Whu9Cn/sqZA0z8AklDxs1Fg48vvQzGw+t7jyXf0gUutIIP5cvzw5iexw9?=
 =?us-ascii?Q?4N36bdUHS/GccWhDm/kzaMs+MYQRabPSuSXXm6az1b2AWuwSpmitPssT2iL/?=
 =?us-ascii?Q?HvnrYiyiix4Xu7NsQtvwmq78A2dMsm2DS+AK43HyvJsh8EHZGeiC0ylaJ7fS?=
 =?us-ascii?Q?ogGxgRiYwemxkecSIrkQslvsrsbC9XuRKZEnhg55Et+I7nsg0vhqOU4arPvE?=
 =?us-ascii?Q?sG7uEw/42zX6PGVpTH665oyBRnGG5g6AoUpM0WjqEKoMb8Q/3wOV1PQwcTD1?=
 =?us-ascii?Q?IbD62joIB3jDnQmWrDvGdX+IfMrpCAEzhSclv/FIb20PnwAP43XvT4Hq5bGc?=
 =?us-ascii?Q?yYuesO/9vypYoGWRiQ7KmfP8twieD8+SAYIt6UQ2gUdJwaIJ/UHuUIbNStaT?=
 =?us-ascii?Q?F5NR6S9HPq4e2XEpxDCxupgVf1xqjktqx0rOQn5n/LEXVoXIm7YL1iJQ1REM?=
 =?us-ascii?Q?3O2fsEK63dkawhhAsIgOlxJaVnZsPKXRFwli4vajWBOhNffaRxL0ogm4OfBi?=
 =?us-ascii?Q?mDPXxz3YFD3T+V50MzxHR1mC3S0uEo6qWEnheNec6ZxEVTSPk44NE9Wo9fvK?=
 =?us-ascii?Q?JN/St7ngxtfT2KyMiU09boMGmjDnvvym34nWFpGBNIP4HShzlz2LgibL2LO0?=
 =?us-ascii?Q?oHkPLJl/LZyzTIPPR4Sd5b1uvDxuBo1Wl2yQMD19Xm6ukVSiiD3QRUy9CjXh?=
 =?us-ascii?Q?Ffymjl3QormrMpnLRiLE88ie2avSe7V5LOiZFycz6FgIbg+Qn9vlLVyuSCRZ?=
 =?us-ascii?Q?RdjyHtYsbs+WJNX+MeOorOLi+TzsfI2HywOX+fkcejSsW+4uz0R8B8XuXPbC?=
 =?us-ascii?Q?iqDW57ma3JaqkR5pXp3SRzSIXOfZeOEP42XXj8oLpJVg+BTOBTkabVv4AsTb?=
 =?us-ascii?Q?RiG82e8sShbP1hmEHl2X1XHkoVvE8w23n9hQd8wLWA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vxYSrYTVHTdmJxhWy8c9qkPlsL4kAFozjdjmTDwn8HWRFDpDvp6ETq4UUsxA?=
 =?us-ascii?Q?/JoJqhMs6JqKmJYvveN2szHs3AS2Bz4LVMdCik13+TMkICwfV6MKzpWBzI7F?=
 =?us-ascii?Q?XnI+eE+s6YurNRHgnEQy6WVL5Io6Q4+S2qJ1vHtp+8ixP7N8MDPhxvP6UJDx?=
 =?us-ascii?Q?ZLLGA5uMqJKF68PiWcp6a5jsqf1/FPp4rQgVxE89lakh5Ot1zsJbnxUzTiJF?=
 =?us-ascii?Q?a8OlpESSfJ8XDfEQJ8XQtkvYdbvV+gmxcwIWSxlscZejO7D6kYim/37bFXpH?=
 =?us-ascii?Q?AOhfNq9pKdHBRPTbWGn3DpV/OTQAzZg9nPPR5K0bSv/OjcFrUwCipS9RDBDy?=
 =?us-ascii?Q?2OTlphoQf9a2DbWt4ESBwKwi5dMJMrpw8Hg6a0zGVhIisiUmxNYP9xYV2kN3?=
 =?us-ascii?Q?4pG03gbvDdShXE2wzzcNgTFSMyZXC5ZcQw4Bj2Oy4itKLoKeLYJkyzePRPB2?=
 =?us-ascii?Q?nq8a1eTnCqjKmYfuHWcZ7oUzBejhoO17wU9CT3YGw2S7acrV7K+d+CvyFPK7?=
 =?us-ascii?Q?eCZAw4etZmAbr5qUDbISfxsIjHyTfU6NdluG9HTIsnYTNU3yytNWQkzBYMJ2?=
 =?us-ascii?Q?G/ZfgXnRCiQBcnUfnW1Wo1Sm6kdY/ZvYC2n7WH5j63wxkOfHMeraeXeJJHC4?=
 =?us-ascii?Q?mEaQ+MvP0fpY2rWeu6M6b+y1dzd2Ogs7M26CfAUzY9X4QnPihgG+S0RWs0l0?=
 =?us-ascii?Q?fRRBbi5JJYxB/UzxGjjqgGreiRa5EWuL48t6Z1HiMRi6OGl580/i2Wx6DawN?=
 =?us-ascii?Q?ZvmK58NbZSc2yXEALLQdgWyQU/DFzPJlYr3NXzaCFbDP5TOxAqN9kGtdwrOY?=
 =?us-ascii?Q?EOl8JN2q20v2Nn6lCil9As9tBwxCYMWBE52A1aVfG6nIiHeOrgaWjrNm3Ebt?=
 =?us-ascii?Q?XtRWfO92L5v0z14fUn21Nw2if0QOWKKPMXhSZtPbvqmu36tzjzR3La6iCkKg?=
 =?us-ascii?Q?L/sT7ibR6uDlBpAlzbXftnv8ACr6Ybf6Hjw1tTG8nAcbYEAybPlma1Q6N91+?=
 =?us-ascii?Q?65WiNiprcYhkN68vjqCf1DtUIn0Ndj4/S+i5XBuSdsW/dubjhqANoCl5w81E?=
 =?us-ascii?Q?8q0A4mtop5TN9k42J97tfEC2i/bCDkglaNihp6zd7IGP7SsikN2eqQogc4o8?=
 =?us-ascii?Q?6F3PJpFqnbooh+kinCwDdg6i6za9JwrvClPNvf0GPa2o1LGnmrTcZJiossVj?=
 =?us-ascii?Q?BSfnE9VsI+ZckxuRQ4WfcrQAOlMjqtt6SNWTBCoWvRCKj4Y4C6KgcSdV3hgp?=
 =?us-ascii?Q?0VBFq8LUdoK4pxFBNLZbqrPXIXS8ig5hGtMZykc2zw6tGa72V6T2f+EP55oR?=
 =?us-ascii?Q?6kW5OSVh0n4AwWscgwJWbLbYvkz7lpW/xCM51y2SbK4y2yCPlFYCP3KSerrt?=
 =?us-ascii?Q?yMN9DETeIWXTNq6MeDwyIRxwLnjRjIV0tqeTCbOSBaH/KbX/W0BwUMpPcHAG?=
 =?us-ascii?Q?TXtGztVjE36vA93b/NHQtjWNX6bQXfKKSFQiXk3iXju026eb4xRlPEth7b/w?=
 =?us-ascii?Q?tW1+T0gZ89NGe/QbphaCjL/BgnJ1cqSutZ8nBImmgTHs0A8SQ/raVD77Q20n?=
 =?us-ascii?Q?ra+dWWb8pRK6xyS+K89qTBN2MDviXlZbC0mWhbzsa2HGvPnhsaq2WKKFigcs?=
 =?us-ascii?Q?8Q=3D=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 013f2599-c78c-411a-f145-08dce4a7f5f4
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 19:08:41.8242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zIPOxU95Yeli2mEpJZjAR/O71Idyr9pluEAfMorwj1CtPA66D+t8tVBUAEipXLOGylIvizwPOqGf/hmVdmXcHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB5866

On Fri, 04 Oct 2024 20:51:22 +0200
Andreas Hindborg <a.hindborg@kernel.org> wrote:

> Hi Gary,
> 
> "Gary Guo" <gary@garyguo.net> writes:
> 
> [...]
> 
> > diff --git a/rust/helpers/refcount.c b/rust/helpers/refcount.c
> > index f47afc148ec3..39649443426b 100644
> > --- a/rust/helpers/refcount.c
> > +++ b/rust/helpers/refcount.c
> > @@ -8,11 +8,26 @@ refcount_t rust_helper_REFCOUNT_INIT(int n)
> >  	return (refcount_t)REFCOUNT_INIT(n);
> >  }
> >
> > +unsigned int rust_helper_refcount_read(refcount_t *r)
> > +{
> > +	return refcount_read(r);
> > +}  
> 
> +EXPORT_SYMBOL_GPL(rust_helper_refcount_read);
> 
> > +
> > +void rust_helper_refcount_set(refcount_t *r, int n)
> > +{
> > +	refcount_set(r, n);
> > +}  
> 
> +EXPORT_SYMBOL_GPL(rust_helper_refcount_set);
> 
> BR Andreas
> 

Helper symbol export is automatic after
e26fa546042a (rust: kbuild: auto generate helper exports)

Best,
Gary

