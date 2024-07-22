Return-Path: <linux-kernel+bounces-259072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D79699390DA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 16:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63BD41F21D60
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 14:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4459C16DC16;
	Mon, 22 Jul 2024 14:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nzq9dcth";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ct6Jy0nK"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA2216C6B8
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 14:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721659297; cv=fail; b=bUSbCpZGXc2DvsXoq0o5S+TJva94AG5PuxqAVEGikV1qgR3vjwzGAN1zvRdxWoQvFlAFWEYYlAeWcn/PKNatx3HJRYzFaLOiWL0YFylDwOG9B1AaMtmskrzlhGsHqqL4qr7zxYhA1kp7szp5zd4CcAwAwI+J2veogt/zqKxKbPA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721659297; c=relaxed/simple;
	bh=iIacudnaRCq0V+w0G9Tl0bXM6O0Fh9EaO1hsrxV+8/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=N3wUWAU4gE/Ea+hOi34JXaUHuZ2/zZbLRBFAa0ttKFq1hE67WKF5UeOKT1Qgn9O3Ia6o2iqiB6coFyz3BBPq2iKMZ13NBQpeihJWvSfT9GW5dT/v2cep/khSz5RlJf5iU2jXKZPto+2WluDA+bel6rguBvTb4lUvGKN2R0OQq8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nzq9dcth; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ct6Jy0nK; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46MC2SQ9021211;
	Mon, 22 Jul 2024 14:41:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=gKMGUMl0L6QYz1y
	UR7dtboWdfBD/1fIpTaYHBSJgkls=; b=nzq9dcth7dhRPFxEexOX7u7t21CcOeH
	cNs9KUca+aCE/CVPVuktnnoLIRDvA4HEAO1lLZ2F8a3ICcysHlQYRgmG6NjtJNrT
	cqs6ifkLsAdOz9Fm+/+OzdBTODUaks1pySteO+Pix87qSh10ngZPgADRTOOrYeuZ
	bxZTANFNn10AFztkVcCZnJRKq2AZCZUJVAz/wFPNPDOK9zw/maKYbAyh/+vwa9nb
	7tOjE5xIP3ygGb3T3cNWa4zn4eJOu9UiC5AimNdgOkHYS1vO7eAg1LFmkzVCc44x
	iBsaZ7xO96HB2UleIE/pO2kBtlq2Ozu4KXiPq940j1/u6hD2A4vT56A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40hgkt1y2c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jul 2024 14:41:19 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46MERSHW040047;
	Mon, 22 Jul 2024 14:41:17 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40h26k1upc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jul 2024 14:41:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FzyPt0UoZ2ZO5b4tgqxguXI/pW3znn6MTHnGctUfMSuMna1a+pjKd8YaPJ2csnKMg48P3O7MR0nqYKILEJeYSVSqh906X4nFPqEP4P/JfX9RwD7n2JMcZAu9QFw0fwIGPUyW79ueJINtku5lEB23AXsnXjPUJ/POxE0S1IdjwKX5UOa3HVLnsdAe7dMALQ+2ai7j3Eam6E8/IK3++31cDXaijytB828VOBDXs2lGwvqCf63F27ELRIlmnr3pcu104K9VDlUveBmi7R29BOgnN8IGSBAn17L5yhQhI92NEfDFDSeQjrECRPG5KChZgeI4cqraP08qMU6W8VssqVsXNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gKMGUMl0L6QYz1yUR7dtboWdfBD/1fIpTaYHBSJgkls=;
 b=VRl9THL5weNvQuCUaAd3J9eMDof+rapBklyKXrb0rwtmg4KDWzU0F38E7Hz/wYRND+TFl/zB9tB73u2IOzI8ytUyIAXDgnoYeVXFzBjgQie/NBysjnDATcXDKllL14WZtJc9P/rX5Vc5ervnHBNbiauxJowl7TTjUnT872InM2jJwI2MLpVeRM6qa0vbByY8pd+QnqGsT2w8Z6PkInMzTEwIs6ICcJ9kVtjHg6ukElJ3XrGcZxWzuoSgcHtRG5cRFdGfNiauKagoIDFQ5gFQxPcu1FLlgn+iwY8QqhgXGDLU22bLictrt0BfMf/TKtzQz+sZcFVoEVCThBhPqmo8CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gKMGUMl0L6QYz1yUR7dtboWdfBD/1fIpTaYHBSJgkls=;
 b=Ct6Jy0nKYnT2OpeI8jm8D0wWVAu/YLvfYi+AUbUnYkv9YaTDaIFzeyMeaiB/QyDvZp8l59TUsvi52bOchhSobk7L8KRnQmBHc+DB4cCpZq71TZ2P1Uy0teEUsdXCRWzQP0sN65sLK7F6Y4YOQ5Wv90IOwLGNdgkn3umPAIPJ4/g=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by SJ0PR10MB4799.namprd10.prod.outlook.com (2603:10b6:a03:2ac::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.19; Mon, 22 Jul
 2024 14:41:15 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7784.016; Mon, 22 Jul 2024
 14:41:15 +0000
Date: Mon, 22 Jul 2024 15:41:12 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>,
        Jeff Xu <jeffxu@chromium.org>
Subject: Re: [PATCH v5 18/21] mm/mmap: Move can_modify_mm() check down the
 stack
Message-ID: <edc5c08f-fa83-42d1-98b4-62d1e9487069@lucifer.local>
References: <20240717200709.1552558-1-Liam.Howlett@oracle.com>
 <20240717200709.1552558-19-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240717200709.1552558-19-Liam.Howlett@oracle.com>
X-ClientProxiedBy: LO4P123CA0416.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18b::7) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|SJ0PR10MB4799:EE_
X-MS-Office365-Filtering-Correlation-Id: 945cb9b0-2396-4386-d27b-08dcaa5c56f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ysbyLQc8EgppxlVPwk3MogiLf/POyiRa6o79kAQshqz1pABiF1lXLzCtBHiE?=
 =?us-ascii?Q?Q4Mn9o61847Vlq9opRw9KD/4I4gqqnfOn2tHJ9MkkAeJQqv6hGNKaExVe2dx?=
 =?us-ascii?Q?ru3F9+jtwQynLQIrXr02Y74hgHPT2t18OZbt3hxOu/Fxnd6ak8txkQTg30Uo?=
 =?us-ascii?Q?kGB3t5m4IF+wRuBqYXDyU3rKN2z1HkXclxsk2wCpVgY2h1DYdgAaM2442a6s?=
 =?us-ascii?Q?EFtMsereUjMhlMLIIfkvp36yhbRH2+tLCpdggVuT9bz/bFBxGhHphP2Ogmwu?=
 =?us-ascii?Q?QL62D5MFd7lR/GN4Rgym/JWJLoFVImGHUEOMQJ0YE4R/KoG+paJMYe99VOyD?=
 =?us-ascii?Q?47wOmdJ6kAQACedbimnng0j3glXBRiDMKP7pBzBY2P+AKSlGNmmo+Uzc3UDU?=
 =?us-ascii?Q?i7kgRWDyqcZog7KBGbL3zwl225igEhzMJdUmICz/xl6TcKrUyMufB9ZGSu/u?=
 =?us-ascii?Q?rl8eAvokueAFwPnTxv/ctab7RZd6NLpzHYpd8cYNBdVZQtWN+wJIwAaJnXwn?=
 =?us-ascii?Q?tGGHDHX4Qr4154/LgcKKp5Yj07UarZZFL6X379qYxxO+eBmGBgP0SiOvVJdt?=
 =?us-ascii?Q?CcLWd5Ygv1CnVThg8cWedhSER0xzbWm1yV4GSLcoWZabHHKqdR/gsvuS7qDM?=
 =?us-ascii?Q?AKbnn5gEH5qJtRFw3+k3EkRTfxg19Uzc+R7x5L9I2SrNuLTNJVSmicNTSScQ?=
 =?us-ascii?Q?/Y6EnCgRwGuNXgb17n19FdFhOavnFk33qIhJl5Nx//cDpU57OQ+6ZKEcPoS2?=
 =?us-ascii?Q?lr1skas/C5eXqPhlq7/hp1tG3k/Bk0Em7gdeviqH0nuWnubTC8KkdK6PNRRP?=
 =?us-ascii?Q?OCCziaaQDhCInxqppk7Z+85TkrQ47SeZlwrPGCaI3lKosFSDKKkVEAvmD7QL?=
 =?us-ascii?Q?iIiCa4XJKHsIBYXqSlASDtsLkB/XSbJhrHIHamf/9ekVXjFJ1sBNtPEpSnik?=
 =?us-ascii?Q?6NrNcdkAXPMN6psAj0Jn3rFtPYRPhTn3WBaVyMlLHlRIS/Np5JL0FoGcWQvG?=
 =?us-ascii?Q?BN39OGdODenXLeaile9t15CGkpqdl/FX0SknixsmQEGOGUYh4B+5mRfeVor0?=
 =?us-ascii?Q?DnTmFaURqGmtI8AeHm1qC6iOvV6mM3IbI/ToMycIRHwG+2POw3jzvTFOzjec?=
 =?us-ascii?Q?d1MWdFP8e2NffNgN9r+FUWB02UM9T4bBotAT1q4syKDSSkHrx/4lnxDxSCb7?=
 =?us-ascii?Q?2RqOAZKP8/nPVhIUswXeXOIULA+Orpuoum5TlHnogz/igss8/VI2hwOo/snk?=
 =?us-ascii?Q?EL1tk6p7r3Tg+bmj9JzEQopFhXQ24ASMruE3X7Prxtdwp68mKOxxRaapjDMj?=
 =?us-ascii?Q?5hTSP7/3K8Pg7Gf4QvAtJ9nZoCJ1r5JlxwVoLTL+FGOkng=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/863NYPLN3CmeeIVwAeHiXAOK1Y0zKWSUSZ78Uq9u2eg/PB6BDARDQWH60I/?=
 =?us-ascii?Q?D7JZehsN8pudGKM8tFLhy74HRCf63Ezn3KtaUt1g3KxmA4deHav9/w2jkJF7?=
 =?us-ascii?Q?WXHoak3HYmx6OFmoeQ5DxB8vkmDLc6UFPRGleWpXRSO6K2yiWcYJu9fsxVjn?=
 =?us-ascii?Q?MwEX762XDinqkftc9h5ioLVMP+PGIPjZkqFZTOSrnmFmJLRGrhvYIJYqNjpk?=
 =?us-ascii?Q?aTxzJcwFHmifEg55CVk5qeT/YCHfHBRjtRZKabfwmYjQEiUQhRsv2huACP58?=
 =?us-ascii?Q?/mUgrPaHXuTMbkUNix1RmlYk5wRcE0IVjbCP43VKN8C4t134//ui3dnUaMFq?=
 =?us-ascii?Q?i98eJIyoY+Z/UDD5hZGfQg9xX4XY8qo8EvM0kirlL9WQBndbxZ0c13wyuWWV?=
 =?us-ascii?Q?GzvP1uv++rIa8SON3BrROH3Y9TitkLh6uirFJW0HSLRqFodzNcesNJmmGZcs?=
 =?us-ascii?Q?b3XMRLf5hy6NJ/oTJlin/Tj80re2M/hD0x+g82qAn/oDKN1K3CmsfXMW+QA/?=
 =?us-ascii?Q?V8s0KKeJJ8Jx3B+xoL733c3ATf0RC2uO2tHlgvP+fP77gI8NJgGRhB+HvIEw?=
 =?us-ascii?Q?L/z8cWioXc4h9/aMkuogJq43ZAz1KS0lpIDI3B02IJaPD/k1RJTQkf7D6IHF?=
 =?us-ascii?Q?fco77MFvL1828Mv2fcpb5WhCRZF0yBoRuwO62AMbjmdntiX3zZBCAiSer+7I?=
 =?us-ascii?Q?agJ6nwNLcE9bCljPFL6J7Pvm4x62B6iU7eWRvNE5neMXrqK3Jf7pF0N5Dqo1?=
 =?us-ascii?Q?ZCjvepC7a/iPpER3ivl0ZaHI34h4GCOJ7Z1MmsVYYTVAp6MEhZoW46bBCfmG?=
 =?us-ascii?Q?6NQdUWY0wbIfLtVoY2u/+etZA0VcESug3C/kZwmAOhKeVU9h7yJBoZHV3t1o?=
 =?us-ascii?Q?vEZfsRWLBIR8TRCwEwJ+UOqVrengfok99wp2wqDSv/qdQAduJuoiraZCPhlL?=
 =?us-ascii?Q?K/HitjhUBycWsYEXxcPnfjsPKSEVoNDiO+QcQEBnm1QKYtEUBkxTQcBYDmpn?=
 =?us-ascii?Q?HfPK/t+AKnP3+QGx/3PTexweMJkTMiFXJtOMRH0XFzCOhFC/lMZUa+DRqwFq?=
 =?us-ascii?Q?rrjGOGYSGXJWt2lG7hfnPbWlOdOkwDPM15qj6jvR/B4xQ/jSppd9/Tavlz20?=
 =?us-ascii?Q?kttQFR4VlecPhdlxsm2rdHFPpaFdH0zxCDAvTOVpxCLN5LNf6aNj3JWPHsq4?=
 =?us-ascii?Q?yLBVUEHNAGMDxvf7DgIonN5vG0WK6SO/EidG0lBD0EgkKuKaTZeTCttM8oFD?=
 =?us-ascii?Q?ZDHT6VVWlxws+EYBS6NltkT5xKWX33KASAx4Tsr3/G3OIuxYAwLlfWIARTtz?=
 =?us-ascii?Q?tEWnXpNq305cusH5+zwd7uE+uo6jO9IjxP5/H5Oe+JFMDPayNyx2rfiyACiC?=
 =?us-ascii?Q?tVTp0ebm5O6GebGUfB+A3qrRM1pDnw19K0zMQyPVVX+zvm7W14qxQkOHdavu?=
 =?us-ascii?Q?GObjXWdwnttxBO++U1MY2QMe2VnMTnujQ0RoivJ8vUsdpwiXumPHFbuBot4U?=
 =?us-ascii?Q?f0DOa2Qrs7a/yFCNg3NCIqVzXBslFd/6oHFc/zB6uV//VZHr7+dGvZyqV2xf?=
 =?us-ascii?Q?JEA2KuKObtubU9oWqTgcaDVIR7k/0t3XVxiYHZS1o34yGlX7RpcATKe+X6+P?=
 =?us-ascii?Q?vqhxnT+dyxDD2aY0vDr2dNlBwMiO1vo1y3R/qc1rS6TIQkXE1t4RnAhUT+ZQ?=
 =?us-ascii?Q?XkZPQw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gf9xxDysWeAr3i0x7sP7wJXZtrIAY3vthblK7EK1aMGh3Qk7YoPA65bSjnrFMOTmXGdflxJQfyWltnAVSKKzUfR+Zxt9GJHvHZFn3zXHBcSCqv8NfdxJalUY5Nxt+soLRRvSQUYaaBjmmLQRGla+WzyVv3e0f9SMezj+R1wAzOzehjbvpMR1QNz+XD7WzWXz4ZTvQZYgyDFiMFEOTb0a4JztzZaTvkNAHk3zDv8PEvvijKi6XiPbpZPx4qK1CiT8uidnm5O8AirhiYF7Ntim397nAoV3L5zIKYBkcS9hFewDzu0DeLmGrGd9cuprQM2ToT6zOTX7GD5BUplTdrFaHFiR6J7qpVHZ7YDeV6+Lq5xAENqnRO44l5EaO6UVAM7QDCDAYWFd4V21IxK4ErxCf66qoSSJaOIAE2szMN8wW3KH0eg8sKZ81TwCc0PRProIZrLF5XsVq83FdFbFfykNweqmMzM25zNA0BpN8OISAiLfN02t3I8LFEqzTJmwdBXYwfcgGxo9KJdgLZGN4SrzEhlAhSdJV3q67Mh3nAd35IXzSI5Dh7of+jyokvTUGd5L5CzjY49b2v21BASkooxnQxg23p3qjbJBc+MwLidR+70=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 945cb9b0-2396-4386-d27b-08dcaa5c56f6
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 14:41:15.3518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vB/KDiAUvld/pkMDuFFZm+LenwNlF5XIu0LZkq1e8QIeQk1w4BdJxkItJRMi5IIt7ur/6KOVLkdoBv1xBY9ZmRkWq8lUD1KIGPH/G1DjeGs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4799
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_10,2024-07-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407220110
X-Proofpoint-GUID: w6GjZjJ7roeFAJWlNkvviAZPP5hdovfO
X-Proofpoint-ORIG-GUID: w6GjZjJ7roeFAJWlNkvviAZPP5hdovfO

On Wed, Jul 17, 2024 at 04:07:06PM GMT, Liam R. Howlett wrote:
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
>
> Without an arch_unmap() call so high in the call stack, the check for
> mseal'ed vmas can be moved lower as well.  This has the benefit of only
> actually checking if things are msealed when there is anything to check.
> That is, we know there is at least one vma that is in the way and needs
> to be checked.
>
> Only call the can_modify_mm() in do_vmi_align_munmap() and the MAP_FIXED
> case of mmap_region().
>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> Cc: Jeff Xu <jeffxu@chromium.org>
> ---
>  mm/mmap.c | 24 ++++++++----------------
>  1 file changed, 8 insertions(+), 16 deletions(-)
>
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 117e8240f697..a32f545d3987 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -2877,6 +2877,10 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  	struct vma_munmap_struct vms;
>  	int error;
>
> +	/* Prevent unmapping a sealed VMA. */
> +	if (unlikely(!can_modify_mm(mm, start, end)))
> +		return -EPERM;
> +
>  	init_vma_munmap(&vms, vmi, vma, start, end, uf, unlock);
>  	error = vms_gather_munmap_vmas(&vms, &mas_detach);
>  	if (error)
> @@ -2927,13 +2931,6 @@ int do_vmi_munmap(struct vma_iterator *vmi, struct mm_struct *mm,
>  	if (end == start)
>  		return -EINVAL;
>
> -	/*
> -	 * Prevent unmapping a sealed VMA.
> -	 * can_modify_mm assumes we have acquired the lock on MM.
> -	 */
> -	if (unlikely(!can_modify_mm(mm, start, end)))
> -		return -EPERM;
> -
>  	/* Find the first overlapping VMA */
>  	vma = vma_find(vmi, end);
>  	if (!vma) {
> @@ -2991,13 +2988,15 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  	if (!may_expand_vm(mm, vm_flags, pglen - nr_pages))
>  		return -ENOMEM;
>
> -	if (unlikely(!can_modify_mm(mm, addr, end)))
> -		return -EPERM;
>
>  	/* Find the first overlapping VMA */
>  	vma = vma_find(&vmi, end);
>  	init_vma_munmap(&vms, &vmi, vma, addr, end, uf, /* unlock = */ false);
>  	if (vma) {
> +		/* Prevent unmapping a sealed VMA. */
> +		if (unlikely(!can_modify_mm(mm, addr, end)))
> +			return -EPERM;
> +
>  		mt_init_flags(&mt_detach, vmi.mas.tree->ma_flags & MT_FLAGS_LOCK_MASK);
>  		mt_on_stack(mt_detach);
>  		mas_init(&mas_detach, &mt_detach, /* addr = */ 0);
> @@ -3370,13 +3369,6 @@ int do_vma_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  {
>  	struct mm_struct *mm = vma->vm_mm;
>
> -	/*
> -	 * Prevent unmapping a sealed VMA.
> -	 * can_modify_mm assumes we have acquired the lock on MM.
> -	 */
> -	if (unlikely(!can_modify_mm(mm, start, end)))
> -		return -EPERM;
> -
>  	return do_vmi_align_munmap(vmi, vma, mm, start, end, uf, unlock);
>  }
>
> --
> 2.43.0
>

LGTM,

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

