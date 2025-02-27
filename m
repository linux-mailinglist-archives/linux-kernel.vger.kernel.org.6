Return-Path: <linux-kernel+bounces-535391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0D0A471F2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 03:09:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A43231884089
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 02:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9744A14885D;
	Thu, 27 Feb 2025 02:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="tX4dx2GW"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013005.outbound.protection.outlook.com [52.101.67.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B53839F4;
	Thu, 27 Feb 2025 02:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740622117; cv=fail; b=C4bnjvDPurPjEjhOgYg1wAweNnrq3gL8BJLOXE6o8buL/E5DI79T2UzCL0Y0UrqFfiT1aj86anGJSjMz9gYuOP8sPo5qZuW2oV1rRZ1WAXYE37R/eOQ64O4SsI4WOlnRqB0nel5GH07oOxrg8hCjcqgN+zTM56IwVGw0T3opQHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740622117; c=relaxed/simple;
	bh=fmhHHiSRW+hXzZ9shgZOyboxYoaXharFtd2BchShwyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sWMO1qGLvaRWI06d5L/W0Lxm4XKZaXylLLz1iFxQz4IPE+0DT2MhFo9OoWAlN8m9ezPxVdjyXuIrH7ONI3FVcWyHxj+l9zX0z2ZcUOF0DXFUWOd2ncBHRl8FOb0b9B+tbsBjhtABNYPgY88VuXt8T8WG/NGStTE5uSlRO1papUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=tX4dx2GW; arc=fail smtp.client-ip=52.101.67.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XgIiWTCc7NF7HmiM+jkUgT2XIT6wONVR068mI4c907NuD/yf/iGqmxSZDMJvkPIlR3KKP472wpJSCC2J3kzaMe4+ha7vzG8Lw6ItiLE0aoJq4BUpGL1cY4E8EeSk1JUr0PKdn1ckvWzHgYd91uSKJQSV96Q7BSoHdfFVyz6JPDbyE4xDaG4Xy/oTcxZxe+5pYkNUIKD5UtMeGu9g0VkzFoESu/zjcLZjcvKRd1QBhqinacQpyUqgxao9TLWICfb46ijc/Ox1gvklI9nyN572YPuJZQr0aLyw4jTA0O4rI3PtjpPC7pPWSR4QSNdE/UlDP9d1Dlgef9eStg3hgKj9BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fmhHHiSRW+hXzZ9shgZOyboxYoaXharFtd2BchShwyw=;
 b=EJYwbbfPSFF8JXyRX9ktDqezm4Bq36yu2MILh1WKH8t4gnUiW3JzVHRyx5a1vBwcWbWqXGJ3IZM/wo25FWBW6y4mVhK/0RlPsSdxScMgMJIHUZ2gnMIlzf11+m+dXR/vQC2aP3NV4QYHUDwPxuugBddlBguGe+m+ui5FmclAKZzh48okAB8kJWNoVqT4JnuRVD/xPWez8FEX2d844MRaV/eocfC43qirH7nGeKcr1l1bd7GzRiSvFaF3StuwH2lciNNyBj88XluDSdq0c0lzmKxcE1q1a3155Rnifmz6TYdqwLEFQwMRLcBmj7Xlvk/O/KzWfUDfiR+2HMTJlg5cTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fmhHHiSRW+hXzZ9shgZOyboxYoaXharFtd2BchShwyw=;
 b=tX4dx2GWM/EQDKj/gjd9vLP+6VhvKPF6mgR1M06JNgIIsVBPendRVEDlgcA9fak0PMjvL4lyjsd80uOMMzg/p3vEhBn6J4sAyv8U37m8ZMQIj8CDqdD0mB7YzrgmRsI+tNWCMSuShWOc8V3nlJHEpgzGQ/B5x4QmxJC0vnFTPDtqt3CG6bvBB9NciyaaxfQnHPmG+o5OLLr/0GGAPsMQjCGZ/jXmP3sD6regIIqEY2A4rRzj7CyxdPKCJsIigK3uy/l7R+OOYhubfU1NOBEEJyx6Uy6K0J4IWD4TpDRKAFee1VeitzmduxNvczwGHI/sT/bYlRCqt6tGVV/HDTVltQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS5PR04MB10058.eurprd04.prod.outlook.com (2603:10a6:20b:683::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Thu, 27 Feb
 2025 02:08:33 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.8466.013; Thu, 27 Feb 2025
 02:08:33 +0000
Date: Thu, 27 Feb 2025 11:15:51 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Rob Herring <robh@kernel.org>, cristian.marussi@arm.com,
	saravanak@google.com, krzk+dt@kernel.org, conor+dt@kernel.org,
	arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [RFC] dt-bindings: firmware: scmi: Introduce compatible string
Message-ID: <20250227031551.GC11411@nxa18884-linux>
References: <20250226094456.2351571-1-peng.fan@oss.nxp.com>
 <20250226160945.GA2505223-robh@kernel.org>
 <Z79NOeyWzfRio8qs@bogus>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z79NOeyWzfRio8qs@bogus>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2PR02CA0047.apcprd02.prod.outlook.com
 (2603:1096:4:196::14) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS5PR04MB10058:EE_
X-MS-Office365-Filtering-Correlation-Id: 20de737e-e576-4e30-f9cc-08dd56d3a319
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?23FH24/AncEhTD7Cfa+srAWWMqRV4hsmdGALFu7sifpW7NLzqLUZ8cVNBCpR?=
 =?us-ascii?Q?gRWo28ntdPv3B3O3iSK6ZIFux66kvTGjFpurbbo3kbZHY2MJeGk8CDoN1Qy8?=
 =?us-ascii?Q?ogkTLJYhWoTq+NbrjqNGaNcYSAqo5n4iH1GgvLvLp4jL6KijKplfMWF6T4cX?=
 =?us-ascii?Q?oqaMTHr6Kkg9qTUuSxfJrfCCGrfnFqFWp5WOii42zFtlRDPIHpl0cD/auB1/?=
 =?us-ascii?Q?2BRwGaIFICn8tqybX6Au7LJfu58Jc/tf2ITEXtex+WOf7PIJTlydJVbFcYZ7?=
 =?us-ascii?Q?9mE81CsaLgilSm+5Vb5rh3Imsvr3cMXL+f2OnB7k4JzdSUDgl8EjWJ3L56gf?=
 =?us-ascii?Q?LT9qMTugOxq83j3zeAoteGqdC5gfOnMvATL9tE4PF043T3VVaAWZDQC/pGSA?=
 =?us-ascii?Q?F4DFMga9lubkDGHT3LJ5fx4Ke570wr2NfUWmVFnHW4WlM41Bizv3U+0mRsHo?=
 =?us-ascii?Q?Dteq2cQbE1MYobOr8GYhIkM93YeTCNFwLwk7qZ1TEXFOBAWItU4XoK3cRKMO?=
 =?us-ascii?Q?Fuj/Bo4WdwfM9gVI04mWLTffu+7rwpds8WpTkrBfet+hvHL+CAoVIejH8n0d?=
 =?us-ascii?Q?1FaJzpv3Cqtig8jmzaRyxE5iYONE7+QU6X6I8i1Z1VK3o9dyDaLiElC2Bn54?=
 =?us-ascii?Q?+tSpW1Hh09vX4JZOUrL1j6pRh3zegdWgv2hgVMnUc0/4mEKSWb/1jFiHL/aw?=
 =?us-ascii?Q?gjY43EsEPaRx9un9sn4BKIL+R7B8FuPpyloS9NUftT85cwq8w9jBBGWTCP8d?=
 =?us-ascii?Q?IAEbog5zUhcvvREk8h5rsd5wgxWtsup1OaeJpDKeaYtt4o56sGA8JfJBeztG?=
 =?us-ascii?Q?dwZKfusvCMLZGPylYfgsUSvH25hpmU1wh4pdZnJqvsGC7YxkhG6qQZ1Ja0wF?=
 =?us-ascii?Q?zT3oYaEZUfYsrXhFVPrfX2QqtfaB5VaB+8aAQaZc1UcX+dv+uJv6veT4mEd4?=
 =?us-ascii?Q?4PQ4dA1gVsrDY4NDrT7thzgtZqUPdAGwebpQQfeFu3ciNMKjN9ZIcr1Motp2?=
 =?us-ascii?Q?iKnpphwtNaJkLMGnDI3GxRWpTvijS3hotbbc05hSzePnCJDIS/49RQYSI657?=
 =?us-ascii?Q?CNzz6uWRObeaR7q+WO30JP2biQrgvkEK2F5OTSzIWGZ1leFG+gLqDzkZIjeJ?=
 =?us-ascii?Q?KE7H/HpxLOJv5gfdc/3ClSbW0U94iEzXG8IToJf1PQg75CtYiABHY7sWtV7S?=
 =?us-ascii?Q?3D+fqKo03d15mP2LGdy6GdfgopCIPdz5F2lD+iDvpDmDUkOiPOmpMOaStB0i?=
 =?us-ascii?Q?WPSk6uDaXhrnlB3UC3eFIno91n5J6Nw/FNW9Tjbnk5j1ug9QAmPShjIbmjbK?=
 =?us-ascii?Q?kPHX80+cJWhqe+0U08CEESFQp8SbIg31rjDvHsoAu1H7ZQwEsc1TTv++q7x1?=
 =?us-ascii?Q?e6/j+RU8fL9rYtoZRtfwqztegyv3PKzRpJvieIRvfXpYZI8r58QI+mizEZeY?=
 =?us-ascii?Q?/2Y2hEIvsd15vnX0VbVlwNlPYwIFn/Ob?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tXG2ZKoq6EIRtyIh62Fg+NxJ4PxuPYcHGSzhDZhRUPT+t+YBqTxZ6/rmdQZN?=
 =?us-ascii?Q?Sy5rFe+4oJVGjn6+f3kRmnxJCU8wbtrtEkIfuFpbwe/zM/CO0PZT9JD2JWQX?=
 =?us-ascii?Q?6sJxa+He/5Zr+puBpmYty15Pmf8MmAQR9s7wUgtGlD6xCVi/Msu04o14eqGc?=
 =?us-ascii?Q?3esAt3EtAloRdeBFc8Bmvflw12odGVvt1IgN4HyV1x8Mmkj6PAj4MrkrVT7j?=
 =?us-ascii?Q?y4dxu5kXtk2RtzxNPV4YqCnKW84wq59gabbSoAne/+sBt+wCur1OlrX9UHj9?=
 =?us-ascii?Q?DL2qlYN+zv6jQ5Ohlt1TassFrXwdPInrLmWnFC1NHDqE1TAAd5PPekLFZd9V?=
 =?us-ascii?Q?bCD1xWLcW20uAXqV8l03z2Lx5koUWGoWeuH2PNo+zOMwnQwgNNEui/hiQcEg?=
 =?us-ascii?Q?GMLuxt6LnVmJXQuJ7UtKLJQ4Kf6csXfxXw7aRGjQMhHBeX7xY3wMF+QUB8av?=
 =?us-ascii?Q?Cvj6FLbYlMlvsvBnWN1YFBK7EK/la3Altr3ffqnhHlqT5HkMFVDyeMw8l3XV?=
 =?us-ascii?Q?z4MXdXDffXPIGqi2dQJBuNPz8edl5pBnN/YcJMbtB/n91tFkynTdJWcLMJbn?=
 =?us-ascii?Q?WCr6Rcqh/3hcezyCWdrycpxD2Kd1tzyJaBtw7PYOFhpOcoWnLp1Exi+37K8p?=
 =?us-ascii?Q?HNpj7LRc/fpJFz+3IcChOphchv4gHX1WrDFvucJoZTkwfdTN4qYzmOhWb0Ee?=
 =?us-ascii?Q?11ve9AmNwzaf8E+vyVzg3nuxdZjCKS58c+PMZOPQXBQ1x9pyYg66CydTiKSo?=
 =?us-ascii?Q?W5F75fs9OXM0oxV7MGGO5OLwOOeN4lu/YbJoCqbGxsalDNjvkr/BQ8bxJOz5?=
 =?us-ascii?Q?FQIw2BAbhdJjvvgQAuGGrn/KNb/sOEEjIWJojHb0LNlr2UE+zQFM+1F+e/PA?=
 =?us-ascii?Q?lN9CHQsTL3hul3zgm/seqDejy3IULPuG+LoiEoS7aJwm99tl8RxKWQYgb9zP?=
 =?us-ascii?Q?+p6/g3ORNen9pgqfgiO/eZEGu6QnfxR9CY0ERBOBnUGpHR5PCyuVIhYATeMY?=
 =?us-ascii?Q?CVF04t1Vxb1+Urz3Lwu6SEGex+0YUneVXnJ4d8PWrsTFLc+2oKQLMDVrtXXy?=
 =?us-ascii?Q?BTYSrtN9B/eUlxyEkRKgdvVBN/K+RzyXEXf44oTgVgcQMW2T1W4DQSLIrEG1?=
 =?us-ascii?Q?3cPFhRd2MmAd2/j9dmWeR4Sd0ItSCTlcIsHCk5YBrl39REWQphLqo8Ys1uqm?=
 =?us-ascii?Q?MykKeyGvZUTh/lnnEH2r3y9sgc3zZBF5XjscOELzz9mrQ3m+koBa70xPBcq9?=
 =?us-ascii?Q?2E9xFjSaJP56P5HfkISQ5gP+Bze/DJB+5BpMeQNjrVO9HzHP+3X/H3aKTaFJ?=
 =?us-ascii?Q?Y3WtIcXTtXW641+fiSHPlOJhiK9Q1TO376pL02YbOqdHlC40BOZQcYU712Da?=
 =?us-ascii?Q?S2xZdZi1DcWp+gV/dli0+bpG0a9UGUlGmZh/EFKJgopdurKEmBQ5YWUmS3MI?=
 =?us-ascii?Q?12yB1KaAsGc6puT34ErqG6WAPYVgXx5yOferrQKzrpkwQrHRj+HdfbY7cqOT?=
 =?us-ascii?Q?ZmABpq04A0nY+lpM+nri0UheEknsh7rAweSBrdJeuRKCu55hY9t/OhOuS4+G?=
 =?us-ascii?Q?YN01abE/a/6moUIyuMdiinzwyL9Nfb5hsdL/0Mid?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20de737e-e576-4e30-f9cc-08dd56d3a319
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 02:08:33.2186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GUoNcmbQsAgSBvOwoePfu/jvIAdz5EV2yIxGTINL1VkzZ5KeiF2D+LIjf//yUTIve4H8xNSa9kI2CnmgVizqIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10058

On Wed, Feb 26, 2025 at 05:19:53PM +0000, Sudeep Holla wrote:
>On Wed, Feb 26, 2025 at 10:09:45AM -0600, Rob Herring wrote:
>> On Wed, Feb 26, 2025 at 05:44:56PM +0800, Peng Fan (OSS) wrote:
>> > Quote Sudeep's reply"
>> > I am not blocking you. What I mentioned is I don't agree that DT can be used
>> > to resolve this issue, but I don't have time or alternate solution ATM. So
>> > if you propose DT based solution and the maintainers agree for the proposed
>> > bindings I will take a look and help you to make that work. But I will raise
>> > any objections I may have if the proposal has issues mainly around the
>> > compatibility and ease of maintenance.
>> > "
>>
>> This all looks to me like SCMI has failed to provide common interfaces.
>>
>
>We can look into this if having such common interface can solve this problem.
>
>> I'm indifferent. If everyone involved thinks adding compatibles will
>> solve whatever the issues are, then it's going to be fine with me
>> (other than the issue above). It doesn't seem like you have that, so I
>> don't know that I'd keep going down this path.
>
>Sorry if I was ambiguous with my stance as quoted above. For me, 2 devices
>pointing to the same node seems implementation issue rather than fixing/
>working around by extending DT bindings like this $subject patch is
>attempting.
>
>If you disagree with that and think 2 devices in the kernel shouldn't
>point to the same device tree node, then yes I see this is right approach
>to take. ATM I don't know which is correct and what are other developer's
>include DT maintainer opinion on this. I just didn't like the way Peng
>was trying to solve it with some block/allow list which wouldn't have
>fixed the issue or just created new ones.

With compatible string, no need block/allow list anymore I think.

But honestly I have not spend efforts on do driver changes to support
compatible string. If in the end we all agree on the proposal,
I could start on driver changes.

Thanks,
Peng

>
>--
>Regards,
>Sudeep

