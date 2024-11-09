Return-Path: <linux-kernel+bounces-402626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B82B99C29C7
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 04:58:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45D2B282DA3
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 03:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6806B45BE3;
	Sat,  9 Nov 2024 03:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OoWVCymr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="b4/KaIv9"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E69139D
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 03:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731124710; cv=fail; b=J8xbTLbaiTZ+uX4BLEwvLtiF5roiHZ8CJ1aCCx15OUHH/fCmN/eM3TsCjGnbidtZ4EewA/4IsJL0UJLEylxgKuPEmMOaUuAg64QJtBnlguiuzoXbx25+TI+TQp+hoUkVXBdtsd+kchHGgwltmzFY81P98oGTaRL0R3o0ReuwAmw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731124710; c=relaxed/simple;
	bh=h/4S8SGENNrfYtutVq8y3j5GrkNQRYgWoj36hL1RvfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MJ2nAqi2k6ObtWvbhzFlwsPT2tVEdRx8zwmSXRsiPPlbYssM2pwVE5OogW7NEp+ZldeT/UmaaGrVqZQTrs3Mb4BVdTUh/Yo2HsoWhWTTR57wJgL08gqk31fPCjw7SSF6exrRbRy1VDnlmgRyWy+MpZTuogPIrpnNZKeqf4q8syM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OoWVCymr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=b4/KaIv9; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A93wGMR002477;
	Sat, 9 Nov 2024 03:58:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=TWL91pWkrOfLDMD+7/
	BR92eJBEUgnwUPBipcNHSGggE=; b=OoWVCymr6xRu8eAsX2fSuN/BMKWwxZQ0dC
	0IzpxQAV0mkmhBtD/zSLq6rBliUKIOa7zRrmlNiDwO7dcW/2YH+zInmwn2HdGl8j
	DnJYzgGb+jTSP4iGh6kGEYZMQJLNpgnyhQmRxQfjjRC0Oy7AHiV5EPGvRxdhoEyW
	v9QaqmfV8OymfJy2HRNuyZzJjEZLoTsBzR7pAICrMAjTtDBYuNvXp29DCkX1FxVj
	vNJASLrYjQPpBSVJZi/atWUrWLockDrKccVv24T4Q4XP9r9rSF+iWCMHLG7o4TbV
	Z7Tsy0ZGLcawzDmG+G/4/NlFpgtg0p4U0uwXjlcNc54vVnbcMprA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t09sr00b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 09 Nov 2024 03:58:15 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A91YJpF024437;
	Sat, 9 Nov 2024 03:58:15 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2042.outbound.protection.outlook.com [104.47.70.42])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42sx6520dd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 09 Nov 2024 03:58:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W6T9soWcm+kb3hjZ2J+tMTFbM2+/eK6klYajRN/XdJa5tTHBZLfeCswmISvBwHr1cXBZN20acXmar2v7lZ/KN05ouSPQ9W/EjMCWm0XeBSWnxeghbiINmGkmgpm5uE0LsyrN9TINQE5AyKn+aVmbxlLcdcrEbvr3fVEBcfKFi4Rxx/3Ysz1bgRXhQSB2AG0s2Onl628LZLdtd1EezuQUz/rF+XqSxqkhxNyr834a8lxPh4FgupoVA2gjrINkCamB7QrKYgBCv7NUshKLLIr0edLucWKJvmcjleo2DDcQKlE/s24lG/uzxUW1iDLeK7cGcbpJZ2krwzMHrre54QG5lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TWL91pWkrOfLDMD+7/BR92eJBEUgnwUPBipcNHSGggE=;
 b=DZNGYZlgwMmgkyWZWes/0vbQ+MOA4pkfiPlB+GzuJzqqljrHoCbN0Ee4RzfnLSq1w8IEM48udve/NhcbOw7RBbBe/80Eopu7PDFfTK2/K7xcJlcL21KWD7TKrjaowjP/AD7OroCVnGhXFWtSpPImVIjNWmUf9AhV6aDnLYz14hqBunX8AdQogk6S3QVmLnH2JGx2zv2Qh9u1zmKDrvzXqyG/FLlnCPWPiNSqGOuL9VJl4vDtmIYpCq4J393VE95vyNRm4qN2uC9XT9GsT+gHFyEesdkUQPNBW3FScbnBVGiVT/T4YRPRVogzkovx7Z8N5SA0JK8rjiRKeNmdhjRdWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TWL91pWkrOfLDMD+7/BR92eJBEUgnwUPBipcNHSGggE=;
 b=b4/KaIv9aY0ys5xxn+yZ/BO1EzJEbWi/1O1Lj+It7m63GpMvhKmg+ZO/8TQGXHeKAa6WVtXmN/5/3afJhW6C7byUpP2Te8U5KxPxxf+49Jh+gZj2tHIjKprx1Sysvw7MY5T97hzcCaZJp+rrtyFQwncdHa79HJK95z0KvCJvWn0=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by DS0PR10MB8125.namprd10.prod.outlook.com (2603:10b6:8:1f6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Sat, 9 Nov
 2024 03:58:12 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%6]) with mapi id 15.20.8137.019; Sat, 9 Nov 2024
 03:58:12 +0000
Date: Fri, 8 Nov 2024 22:58:03 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Carlos Llamas <cmllamas@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, linux-kernel@vger.kernel.org,
        kernel-team@android.com, David Hildenbrand <david@redhat.com>,
        Barry Song <v-songbaohua@oppo.com>
Subject: Re: [PATCH v3 2/8] binder: concurrent page installation
Message-ID: <i3wikc32rd4mxcvppwe7daakk7nmyd5hiutse4akakgjpzy3al@b3ksxa3hzf6g>
References: <20241108191057.3288442-1-cmllamas@google.com>
 <20241108191057.3288442-3-cmllamas@google.com>
 <xpzec7tqe43sykvqtgrlh3furu7vn2nrnkjmv7odzy7ywd4lf6@hlawbgapxcfk>
 <Zy6QC71iEy3w5FYA@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zy6QC71iEy3w5FYA@google.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0429.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10b::19) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|DS0PR10MB8125:EE_
X-MS-Office365-Filtering-Correlation-Id: bab2d573-2a95-44bc-2601-08dd0072bb09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ac72mu0mV/nIl7ZQi+lsfw7Pa4c5q10rfrPoacD+Pmfrmchxb7gDIEo2Zjs0?=
 =?us-ascii?Q?ZEH9xgz+JYP9gzr6Hk2yqwnBdwr8Lt/Gg6KKl3RPZoPV/0DsvFNDquXNnpj7?=
 =?us-ascii?Q?GmuFiUeYKETAoxS9QhG2eCxSiYruGzbK+FBcMNmAGBhtQzoZrW4SzwtyDIpo?=
 =?us-ascii?Q?cGQsTj9px9PpxZP7SYpFF3stCwfnsLKkzMgD7zPNKcWAXHQtUU/FPlY2TUY2?=
 =?us-ascii?Q?5dthrg7AExvHcyMCNiJniarlWWTipFLlPb1H3AUFVpVIFc5j8pUpFTbg1U69?=
 =?us-ascii?Q?h7mCEZpwQd+tkKRZK87OK432AsJe7uokpWL1Atmb85MJGY6xgH1X1qyRNO8m?=
 =?us-ascii?Q?LLhPlc+qrOIzuO2HCxtoDDhZKRmF24z291leGxtO98F0TBAsKzb5a8tTOiYj?=
 =?us-ascii?Q?kI93SfnLMwTeempoXVaaqSJXNYNZN/6BAOuoiIvDuXiOevishmZ/cNZBl/DY?=
 =?us-ascii?Q?KbquY8JFeIFqIA7oKApNwxTw1tEf5Pma6j8Gv28Mh7evmzBxWM8lzw7Az5+l?=
 =?us-ascii?Q?19FuCMVAZu6Ps5YJ4RxFs9UKOEOSPqnmH/dAy2kO8+Fvfb4M1K3cWGRI2Wih?=
 =?us-ascii?Q?0K6/Hes8FhItpeOTsw2Pjd11jBT7hARLrNDjJVdep+bdiBK2nDcAFxc84rRo?=
 =?us-ascii?Q?f1xtWhuJt77Ha16zHtH/BdoVOplvXULau6LgoLIcB33WItndxF4dn8WOjVTD?=
 =?us-ascii?Q?gImXR9ymtai9bfZetdJMJQkwAjZiVvThcaYe2i9uDFFHk3fN0LJe8RCg5+yk?=
 =?us-ascii?Q?MdGzni/cEWXg3rXRvnhTKEI/pMkJI8CYKMBPUiw/w97mOQigaZOggwxkCeQO?=
 =?us-ascii?Q?1rgxImingDB8FY0FZHFhqNOeF6fX3Wuqhrd3M2v39G12fOqfUnmmqP2oWKec?=
 =?us-ascii?Q?mrQaL3wNJyMV9O/LtVS9CsWVAWI2uj4PEVHbQaE4UP+uoYyVwShD/MA7mgUg?=
 =?us-ascii?Q?p4H11ee7QvMLlJT94KYF4vmBCPc1MYZFsy+NHA/S28EYGXEl7slg6fJ1XoMP?=
 =?us-ascii?Q?Y6EDZlWnBEhIW3dRirLVa8fw5F0bQfvK+fx+31VvpYBxJAaSa6pIS+rdIRaw?=
 =?us-ascii?Q?8pOaPPOfSKgkDOBDMn10JLqMHhhnTdntJIl+hCJc9y9lfKoNDqWXxdknpSHF?=
 =?us-ascii?Q?bmiXWO+cLCIf4j8o5rEzMg9ALM2vyDCmsRAof81BjQAlmXT5N6DhvrwxfDmJ?=
 =?us-ascii?Q?6z3SOzs96UXZt3PmaNXZz6flN8cZCg6T7aIswkt15Neb6PFTqbVJfrbQTPk4?=
 =?us-ascii?Q?NZFxMVRtnqYBSOHUzzaog6Ck5pjNy7YAkE17lfCgDcGlUy1+aT3DAqMztVP7?=
 =?us-ascii?Q?Tc3zXcm4xilij+ewo6DPH1Bm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QJpQun/7tiFD7LdiFGQmNLpcjc1TbXgdAzBV+fTeZ3IrY1k+zEu783Xi5ej3?=
 =?us-ascii?Q?Y24VgPORYpouTvGp5hF3aoOp5tW1pR25CeBpKL3aBPCe9uUBGCpPTYV6hI9z?=
 =?us-ascii?Q?O0yK9N405Ie7JxVn0ADFLmysAPKvR8d3TsRAm0Vdlq57pUU/V/UtvNpo6iEj?=
 =?us-ascii?Q?RKutPtPI10IT2EmJ0t8C2ClDnUSAyXpfHpSs0QUM1U0vX4zJKE7G1OEropPQ?=
 =?us-ascii?Q?TiDNEuA2d9Fjp9/Jmy3+uzw12uYl7ENcIweM8Pxn7A/zhxfFM0P4l0d37aqY?=
 =?us-ascii?Q?JUDIVnbiagbL7uUfxS8V905g/ALv7QUJgeXoL95OVrIjUIIkM0cHZIGCunvm?=
 =?us-ascii?Q?UwdTMlGPPxyVHSbKdUZi7VGtDNJ7GvI6cDJMGHetedzSoo4fg4KIjZDJ2zvG?=
 =?us-ascii?Q?cpiRmfnucBUmAIvJD19FPdQyyTS6Jk6w8iRWikfhyNwezLXTWKGv3Se6qgdT?=
 =?us-ascii?Q?G+L/M/wyUJBh0pJYcxqncGrOwGqhrwb612H/SYBllu2oWa4Cae3hVlII3pnC?=
 =?us-ascii?Q?PAwXpAhYF9BTAN1QR1Y/7IOh5wHP58qTT75T23hUbHT3SEC3slBXVkplqNhp?=
 =?us-ascii?Q?3R3kUbmzwppUipjJ2wdvf2OFIcMlthog5uxkOLp/yoYGZwvsoVBZWkwNqA/H?=
 =?us-ascii?Q?tbNuBtYYW/yuwF7thaixfwy8t12pEFCUBx0iCST9+cFatxYyWuvepon2D8dC?=
 =?us-ascii?Q?kKxZLyfHBF0PEj8XamO1ZDGoQebuDLErgdbmhaEdU6iVkVIV0quv1s5s4pyB?=
 =?us-ascii?Q?XpMA7uScjcnV5vxAJtEMqK9SRiiwyiwoirftOtm6XI2km1G7R7qXAPGk8TGy?=
 =?us-ascii?Q?eGS2GH9javXjDfkpD1tC7lVNLPEyFh1jkLmJIeT0xmBLY7Gv1QO2ftXlhztD?=
 =?us-ascii?Q?sPZ5paC1ng+FhAW9PrI9jzir4jM0/kTiUutMjfHXr4KhSfiW48uPRYRflnHp?=
 =?us-ascii?Q?fEHkPZU9ixV263Vjt4L3yIBg00JfNM+NeFhAgywwJQH0erE6LSEyAVySG+CY?=
 =?us-ascii?Q?JJ4xEtyrF3VUCVIi/Abt//fJf5jb84Q/iRY1mGWJxfKv6JII+6rhJzodTfrl?=
 =?us-ascii?Q?YJzRHlS1wA7irwLasITpbogIQfmnHqKoarCuzAtHzC1ZtV7QQ7TSrMP+7IXU?=
 =?us-ascii?Q?zCuK7S8nBsNj114eD8X8H6/yuZ1M+ROse2ASZjCTolkZ0Y5/amDTVw9d0vRU?=
 =?us-ascii?Q?brppZTZbgd0GA19pCeyKIAVX+E98BxUq6j9q3nxsgDpzvFgIRfuWAYeAhTAW?=
 =?us-ascii?Q?gazlDsdOPtuFGCcphdpSD9CirJCYIbqThGYf2RnGeI4aQN9FXo1BNtb68rKf?=
 =?us-ascii?Q?y78Ehb9N+KrflhvYqDwHSKDPxndH4RlHqjNpPEdVlzzLz+KFc5qEl7LjSJ9L?=
 =?us-ascii?Q?b4xAiCS8sSk+McAl1SJDg2nohb138D/Q6p3H5b4XrYJRMMbORP7+4H3tdCfk?=
 =?us-ascii?Q?Tba51qdhU30vTolXRyKUedc/9cnCJywLBmaYCoV9q9qpGjEtM5EEFiuRUQWv?=
 =?us-ascii?Q?NakjrWsTS9yHyc42T/DL2mMPNFNtQGKfCW44HYTI4l4VDcDoU7xu3wnA1kbB?=
 =?us-ascii?Q?dMgH4THk0R/ecN9EeVIbtClTOMMps8hmUDT7gNH6?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wJ5C/MBgzQHgc7kcpY8orfgfr/0NWJyWn/Y6WTbrZNWulFXzgDpEVgWW7ZkPOwDj27IfyXTrRUgMRjd39lhtJrO9zY0Xf8VuILo3d/vSvw0Fg5rY7DLgcinTkh6ozS9+aJXiJjw/+7R9G9NAqj9cmRho8YVTzmpFTbbI1Hb2A+b2/oA3SCvktbQtX2zKBvtb2YNmCaUHAAOrA4Qe3lFR14oQeU6/z+gKYduCRRVfPqOLhUElhlJuqRn9P7Q1wdxvnlOLEq2yimqUODd83EsQui8ziRN4/vvD8riPVSkPda9sD9bjijpRNgsPEskhUTyMd6Za2/LhAVn5KtrmVn4Zn/ssXPx68mDsAAJdMeLLwSK64mQZJgh1HHSaHKJDV8FbOaJrccv5zF1k8nMpK4+cV00A++UHP+iYbQVIF3I5G0HfXIQKN685ftas7KUZuDbDK9amSCkI3d/1+E646sLGdMSpYLXlt5PFrdJ1U94y3XgnenUDsGhG5GMrP+qXv5eAHDw6i2/dim7l/4jmrb6+5Dwj+Nab8Mb70+QCcUwfslvxfYj7X2o3Bp4egDTXsegNYLlH8GYAHPDeaKe/6mHsO+SQmAvb4A/anqzDT93bId4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bab2d573-2a95-44bc-2601-08dd0072bb09
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2024 03:58:12.2139
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ETF+D9WvY/LnYBCeLJketZNTIQ4DQfkPyzd0kM81u5/uaSSz9xqqW6/DP9mnfODImjZi08MQWU7cpV6nFRQsFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8125
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-09_02,2024-11-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 suspectscore=0 phishscore=0 mlxlogscore=782 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411090031
X-Proofpoint-GUID: JLOiH3KfHP2Ppzm3iFYgeLmZHUmDONtK
X-Proofpoint-ORIG-GUID: JLOiH3KfHP2Ppzm3iFYgeLmZHUmDONtK

* Carlos Llamas <cmllamas@google.com> [241108 17:26]:

...
> > > -	ret = vm_insert_page(alloc->vma, addr, page);
> > > -	if (ret) {
> > > +	mmap_read_lock(alloc->mm);
> > 
> > Ah, I debate bring this up, but you can do this without the mmap read
> > lock.  You can use rcu and the per-vma locking like in the page fault
> > path.  If you look at how that is done using the lock_vma_under_rcu()
> > (mm/memory.c) then you can see that pages are installed today without
> > the mmap locking (on some architectures - which includes x86_64 and
> > arm64).
> 
> Right, per-vma locking is implemented in patch 7 of this series:
> https://lore.kernel.org/all/20241108191057.3288442-8-cmllamas@google.com/
> 

Oh, sorry I missed that.  I had not pulled the entire patch set for
review due to other tasks, but wanted to say something before this went
in.

Is there any performance numbers on how much this helps?

> 
> > userfaultfd had to do something like this as well, and created some
> > abstraction to facilitate either mmap or rcu, based on the arch support.
> > Going to rcu really helped performance there [1].  There was also a
> > chance of the vma being missed, so it is checked again under the mmap
> > read lock, but realistically that never happens and exists to ensure
> > correctness.
> 
> hmm, if there are more users of this pattern in the future then perhaps
> it might be worth adding a common helper?

Yes.  But the userfaultfd is a bit different in that it could need to
deal with a lazy init issue with anon vma, iirc.  Some of the fine
details have prevented common helpers so far.

> 
> > You also mention the shrinker and using the alloc->mutex, well zapping
> > pages can also be done under the vma specific lock - if that helps?
> > 
> > Freeing page tables is different though, that needs more locking, but I
> > don't think this is an issue for you.
> > 
> > [1]. https://lore.kernel.org/all/20240215182756.3448972-1-lokeshgidra@google.com/
> 
> ha, I was not aware of this. I'll have a look thanks.

Happy to help.
Liam

