Return-Path: <linux-kernel+bounces-531850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64813A445D2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B41EE16A8EC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9F3193429;
	Tue, 25 Feb 2025 16:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Y5ffm5Te"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2041.outbound.protection.outlook.com [40.107.105.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8540B18DB08;
	Tue, 25 Feb 2025 16:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740500200; cv=fail; b=dxBFcLlY8mCBqshL2MMeKjcaFwjdUfiEZmOr4AsUOn8WzeEKrl3XnqDwD6Llik5pnGcSt2WUONQPwzvLFILnvRmqXA+XO1XXEaTd2+dDIE1AY9T/HGS+N+NtUanTziEI0FMXQWvmEbLYOB0vd7FpVDJEk/oitJA+64Bq6p2Pb68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740500200; c=relaxed/simple;
	bh=W8FOXJ0E0s8JLk9fBMgeOM8WdHNMCtsav6N3XJdREsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QuKNco6kgYYNK2ZCZxGjitTDDEuMm04LQE92lrriUxTLYGjcaLNJh5IkQLWux6pI/HY/6Izs7QNgFUvQA8S2WluqFBxxDBnCmK6uiVRsmFlpn6tJRWF48Jr7JWJbuswpQ7fbfqDTLDA6N2AjmBC4Pll70+4/fh+UOZjephb/eSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Y5ffm5Te; arc=fail smtp.client-ip=40.107.105.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gCTk76ApnPhYbtYtQTt22IF83SbOA+dQCfAcC69Cu5yPHtWl1oVmQycUVmdj5sgVAhvF8cGyetG3RLl7GDNBFV5RuaTmbNtnJacLOq47p6u0w1UVTw4VlR+TFK5CDW898OOx1pLPAMZuNU3Zbtxqpi0W3NB4qzA217HLDNVW5agLU/4zEF8s1yRK62hLWQIEDU2RSJasbTKFMbitWTn4oQCsRkz2hvZ2ZiFfdSRvaTUZRV2f5EeMyXnpR2x06BcqE3kD8waRUoNriu28aYdwqH8GuqU4UYwiXl1IRfDiL4oc7Qm41thA89TW8hjGA9tjVgzxi8Zd8LaQuEdkExavOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wuUySwQp74eFsWRsJ+c1UTXHBnOCkKfksU9BQQAUb60=;
 b=u6scy3Dl3nxMIxORWKvTsGcSyzAHHwVT198viUB+zkEXL3kh3yM8sFdztg7kXdOBXJ0DfhTcWMR8SxjwnemDtC1dk0McOdg2s9h4UyN6rYR7jNMkVux1RBay7h2LRMPB++EmFeOUjDBPV2ohjVg5FhNMSSG/SOC8yQjibSh6+jpMaT9UuAV37IaGvedcMFF4KKMqiZeFgjAbJURXZYGxpCarDeMqAP8BH0garjB9vEsI38qV0ztIKmuSplLRVLURngRVCjmPpDxSvOATAkB5FepuC2S+OvcsCQESpLzQ3NCOUQ/LDFbJZfUpuCNtKkdje/cytbV+68m0qCZtWgPHuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wuUySwQp74eFsWRsJ+c1UTXHBnOCkKfksU9BQQAUb60=;
 b=Y5ffm5Te5nwl4Z89zNPLF5o/VuvSrUrK9Ft5oakr4Y6hDwneQ8ItcOEmBTEpxjrKzd+ObyoWw7x/79W/yWWulIytkLloGyTrW7ITOL7zARKXI4cZaJXnl5AnqtaaGBPDdMD1/HnBPECOYmDMhvyLoKtOpcoU7lWPS6n9D3r8t57Cgk7coVj7HqeQ748+WyaZKAijzBBNqNMCRScXL4F/Ca8Fv0Nf4RD3KHq1YL0c3yczb5b4hhOSPEDRrQOOUl1mogCM5KECf2Dbue2ct3cT8JHE6P284CmC1KsAwUF1xJX3ehVl3CimLcZ4Ngg451l1YDV2E3qIBqajYrfB3tEUcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS4PR04MB9550.eurprd04.prod.outlook.com (2603:10a6:20b:4f9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Tue, 25 Feb
 2025 16:16:35 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 16:16:35 +0000
Date: Tue, 25 Feb 2025 11:16:27 -0500
From: Frank Li <Frank.li@nxp.com>
To: Mihalcea Laurentiu <laurentiumihalcea111@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] arm64: dts: imx8mp: convert 'aips5' to 'aipstz5'
Message-ID: <Z73s2/ZgyaXnAqnn@lizhi-Precision-Tower-5810>
References: <20250221191909.31874-1-laurentiumihalcea111@gmail.com>
 <20250221191909.31874-5-laurentiumihalcea111@gmail.com>
 <Z7jahtO3bxjkMfnc@lizhi-Precision-Tower-5810>
 <cd6a84cd-ff17-45df-becc-9bfc74522f73@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd6a84cd-ff17-45df-becc-9bfc74522f73@gmail.com>
X-ClientProxiedBy: SJ0PR05CA0120.namprd05.prod.outlook.com
 (2603:10b6:a03:334::35) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS4PR04MB9550:EE_
X-MS-Office365-Filtering-Correlation-Id: 5faa93de-26ec-4e7e-5f53-08dd55b7c67d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BEOJojSKMxMqUmwwpwRiUQJmQpg11V16QRI2WWB4hSofAib9HO7ri6wOt/Cw?=
 =?us-ascii?Q?hVocFYH167JLxPc/Y1XnwZF6MutydyODhY7altZBTeEBY63K81WZDmf+2qWD?=
 =?us-ascii?Q?LiChyiKg+2nLx6GzZJ8SV7JdQbQHJG5R7ggccTkn6wXdmvJNQ3XjAjmMadNL?=
 =?us-ascii?Q?Clsa2KM1JyutZ+A90Rs4uY62UO2ww+6ZybWRYnIdnwZIryAJuU2sf+OhQPdY?=
 =?us-ascii?Q?+RsMMwie05G1VMGL9Ait1ZLir6NNjCb3wdoh/NeQm6GjXvuJbuhIe6T03pzD?=
 =?us-ascii?Q?wetn27KT/JEro5RDPeq5PZwL0obosu0sIBYv6NrdM9daxpK8MdXsvCRkmyhK?=
 =?us-ascii?Q?OhjfJnXpGdVHWJjz+Tt1deYyVZ/GWLFdSKDne7J7MN9miVd5Lsrr4pq32CDI?=
 =?us-ascii?Q?wXYR4Ke2bGQH1gaPGj59B3Ni5JVQAkmPki8yCh3PvitVlrpOi1Xp1U8G8tmr?=
 =?us-ascii?Q?9GI5FwOpAXkdaCCPu59Iv3T8uJ7/qVXMDHzoYO5J85Ih+5t/+7EaruK1H+8J?=
 =?us-ascii?Q?eGxfU+ILYlDILsjEEhRfd3OaU4v9UkbI3QmMNJb6BMLYO6hWZTtX90pYcdRj?=
 =?us-ascii?Q?vdErcETElklLUentkQrjxROcc5QeMYAgoXf+cBAf0x8YcD4bHaaVfhmCJbm5?=
 =?us-ascii?Q?JrY+ah8c3NbFuZNo8RG5n+jdhHIHNZnghJfP0jDXOHK6bFXK3iOHko4eSmHG?=
 =?us-ascii?Q?8QWDVz5xn3ODDujw3F4PprGieKE/mZmHgeRhuXI7FwyBQTJ+aiucfxO5IHc+?=
 =?us-ascii?Q?U0ktCVFRyOwOb/+i6/FJS2sJxzQCEurmLTSZazlNsQsack4X9f2KaP+drsHt?=
 =?us-ascii?Q?WT61BpxLIuiZnJD9dnQI4xOCrqFlyctjeNI7G4MXYyvF/oRcutmTrcCimqf8?=
 =?us-ascii?Q?1wx1yxfj0KjX0XcDowRMY8mtZ5K+7leIAsPUEisNEsgqWQp/0gwXi2qJ75J2?=
 =?us-ascii?Q?dZ6sstoccdoTPBCdXGLdud2BwkB8mz3AyD2f7LKGJo7pLkH59eqz08X6YidX?=
 =?us-ascii?Q?V67fFvrqGbQbPSvPJ4VtGFLzb9xgyNjui8ZKYvQbT3qxeTsCgzD72vLZF3jp?=
 =?us-ascii?Q?Ye8Oc39U5ugOdexGZIXu0l9X5Cu319E665ubNu9CUCCyJ+L7R7tdka8dEIqh?=
 =?us-ascii?Q?JZ+FxiDjrJFGTlUjJxIS8KngCq89X78R5mRt94MXeuZVkrCpGvtX7CiFVlov?=
 =?us-ascii?Q?Rdup9bBmR62ipQjK8rwYsj0pWxJ0m7sLn48Nl6yUXDH1X/NxAaFFlKULX+wn?=
 =?us-ascii?Q?gNaRKKa43CCZps1ISMx2iL4EovE0ZR7LP5RvgfFPc1Us+UA1X0Xf+Te8Ker3?=
 =?us-ascii?Q?ur8EKpt0G6/VVGR3RHQR9nqZM2Zng86EaXJrm7fIPHA3YSEeUhUPNbxarGMc?=
 =?us-ascii?Q?oQTjv26KiAVjG9FRmNZiYgAKVTIKm4BHZ1cxUvpX9FJcmU5h/G+sYp4JMCr3?=
 =?us-ascii?Q?Vuhs09xhv9lt7HukUZMAmPwyxxGjwaak?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?W1tyOJs6tw26Ut+f2rpRQeXfxfsoR7kGD6uW2ExRQTCoaNw6fwI0aq9htjAQ?=
 =?us-ascii?Q?yWZROSz2vflj1zdtccxzjTKJUKxv8CbYxv+xelh4mB5VTFiBDQcuSmKD0I8l?=
 =?us-ascii?Q?3+ee4nSLp5P8+XtKRWspMhrZAzCYqczYKIz6QB2st/WT1BdMyRR6HhMvvfHy?=
 =?us-ascii?Q?sepDitn5Pfc6XMqIPx1+Rn4fgYVv+JpzQsQn6txLWoDNlVS81KerwBQN+Mtp?=
 =?us-ascii?Q?kdtzz1nl8jlYIeD4gs1pxrn56vvDVFNIuql0peNvP+RvcokaouhkAfThDVaA?=
 =?us-ascii?Q?NhJUwKMqMZO91ZBJd1GmCtsM3FMpOFvD8cjrgidPKg80DP1A5bQoeJz9jhrN?=
 =?us-ascii?Q?peQLroIIySrHMt5P5uGrPSrBK3T/Wk1HsstjhUeR7jQPth1/3S2VgUmMYMgB?=
 =?us-ascii?Q?z2/AGMfRRGUDBYw83Cviz6xwmnyRr3uMu+dFOPsLCt/Kb2sMFEQx0u6vRf4k?=
 =?us-ascii?Q?+Vwu9NBhRLdOFwgHglc1sypUFtuyaHqEx505QTuMRf1AMXYtB7N8HZtNboDJ?=
 =?us-ascii?Q?d/H1kEnQn7SjGi6UA/7lr0+qcIXvgkcYM8VxR881KD7sOdvP0jcCFTWL82Um?=
 =?us-ascii?Q?UO49Uf1A4vX9XrVNiCg4CY6IDmhRJPbuwkzfQW1Th6b0/7pmI2N+7vJ1JVqA?=
 =?us-ascii?Q?9N2+vE+64n4BxUkAOV9DKTbZggibr4h1KZuMGy8S1ummn4q/yn9oDV4p6ncv?=
 =?us-ascii?Q?e/9jOLCLFpNgm+NGDDpuI21Mm2/+m4bjcFYd/Kj9YxqBrtdi1PbPktI5i988?=
 =?us-ascii?Q?ONW0KQPvclDQNebtiQVCMJ0JY9eEIMPxrF+s2TozQ6mSBCDH8jL2BZIpLF6J?=
 =?us-ascii?Q?29DDFQIJQd9TJsxWsRFW1unThliGQ3f/SGQyKwIDVt/Pion80jIetp0zYm0M?=
 =?us-ascii?Q?y00Jdx1VMTErBBpfepOYIm7Wb2Dmr7cSK8ER4UyprEqOoUqeIb0fVmJPYJut?=
 =?us-ascii?Q?8bWJVHPH48pMrOC1oIdW2qyahH8Au08clGGkeURzyCBF4jIOe/NiVkGWS/h3?=
 =?us-ascii?Q?O2kLoqLE/RYzj12cfK/4V192ckbbDdB9gbHsfbYtUbeClP/tmERXoi78O95T?=
 =?us-ascii?Q?3b6/OwkF2jm8QzaQVLHQ+JCH8ex8KpwLPliTVx7Ge/Ost0m4fpdUp7Q7LrX1?=
 =?us-ascii?Q?xFyDvCLJ/ez+iG5K5dR9uNlMFsF3mXee3ZCCDbpQnUtcgU9IK0av7uQIaJRw?=
 =?us-ascii?Q?RX5WBZ5Xi8vQdsqRVZFES1hV2GT6fs+ydGlfSpDv4IvHGtZ8EQR0mNcpIe5q?=
 =?us-ascii?Q?YFC3aTH81bs9TqPfO79TJApJiNHNirLDzfyqp8RGRGDJed3jTvCboyzw3gg3?=
 =?us-ascii?Q?FWJpPK9kt7snqr1dDUkmCfkAcN6cbfqlMVacEVfU9ZyqEqBAFrd1ZeHiOQyl?=
 =?us-ascii?Q?aNGMTMeC/7xZggXW3i+CXXPFcS3UAD71i4y5Ryye2ReQSkB+Qp8PYZP0LEGU?=
 =?us-ascii?Q?ZQGw9uaXSO294L2KEJvGMUmqFoywZjl3HLUJ2/u9OGqWzcZuo//4tEeZQLhQ?=
 =?us-ascii?Q?fEmrvl9+j5/py3A1pN87/LusytuWLDE/yz/tXGNmeW+XAMn7V2JMBMHkoxOp?=
 =?us-ascii?Q?jTnMX5w7F5l36ShNgkJuvrWZ3Yn5UctFfULMI9Tf?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5faa93de-26ec-4e7e-5f53-08dd55b7c67d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 16:16:35.5186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zpu2hTExgR+zF7FPk1Kd13dSsJuksxRQOTe4FjVILWhmiU/dRhnlHSGr3WaS0ek3hr1ojPtR9YaJ6MLvujhtCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9550

On Tue, Feb 25, 2025 at 04:14:34PM +0200, Mihalcea Laurentiu wrote:
>
> On 21.02.2025 21:56, Frank Li wrote:
> > On Fri, Feb 21, 2025 at 02:19:08PM -0500, Laurentiu Mihalcea wrote:
> >> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> >>
> >> AIPS5 is actually AIPSTZ5 as it offers some security-related
> >> configurations. Since these configurations need to be applied before
> >> accessing any of the peripherals on the bus, it's better to make AIPSTZ5
> >> be their parent instead of keeping AIPS5 and adding a child node for
> >> AIPSTZ5. Also, because of the security configurations, the address space
> >> of the bus has to be changed to that of the configuration registers.
> > The orginal 0x30c0_0000..0x31200000 include 0x30df0000, why not map only
> > config address part in your drivers.
> >
> > Frank
>
>
> Any concerns/anything wrong with current approach?
>
>
> I find it a bit awkward to have the whole bus address space
>
> in the DT given that we're only interested in using the access
>
> controller register space.
>
>
> I'm fine with the approach you suggested but I don't see a
>
> reason for using it?

After second through, reg should indicate only used space. The current
method is good enough. Just need figure out KK's comment about 'simple-bus'

Frank

>
>
> >
> >> Finally, since AIPSTZ5 belongs to the AUDIOMIX power domain, add the
> >> missing 'power-domains' property. The domain needs to be powered on before
> >> attempting to configure the security-related registers.
> >>
> >> The DT node name is not changed to avoid potential issues with DTs in
> >> which this node is referenced.
> >>
> >> Co-developed-by: Daniel Baluta <daniel.baluta@nxp.com>
> >> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> >> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> >> ---
> >>  arch/arm64/boot/dts/freescale/imx8mp.dtsi | 8 +++++---
> >>  1 file changed, 5 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> >> index e0d3b8cba221..a1d9b834d2da 100644
> >> --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> >> +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> >> @@ -1399,11 +1399,13 @@ eqos: ethernet@30bf0000 {
> >>  			};
> >>  		};
> >>
> >> -		aips5: bus@30c00000 {
> >> -			compatible = "fsl,aips-bus", "simple-bus";
> >> -			reg = <0x30c00000 0x400000>;
> >> +		aips5: bus@30df0000 {
> >> +			compatible = "fsl,imx8mp-aipstz", "simple-bus";
> >> +			reg = <0x30df0000 0x10000>;
> >> +			power-domains = <&pgc_audio>;
> >>  			#address-cells = <1>;
> >>  			#size-cells = <1>;
> >> +			#access-controller-cells = <0>;
> >>  			ranges;
> >>
> >>  			spba-bus@30c00000 {
> >> --
> >> 2.34.1
> >>

