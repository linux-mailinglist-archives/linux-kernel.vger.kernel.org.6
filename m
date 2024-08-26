Return-Path: <linux-kernel+bounces-301562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9881C95F291
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 15:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2515328383A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 13:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80CD413C695;
	Mon, 26 Aug 2024 13:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DE6XCHhH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cE0bxivs"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D38E1E519;
	Mon, 26 Aug 2024 13:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724678040; cv=fail; b=lrptii4oLdefEkCXmCuVTOx8XOHzyXwMg4JO7u1PtDhLgbBfngcSUwyQsbH6zHY+zc4EOlgcYFyjLgA/cj8G/FLTpv8qe1gkH3P6xjz+4Gf95HLf/pc6nQ4ijIZ6LTyPA3ltC2cN6rGgQfg+h0UZx+EHle64SlTORLmwJE3Es78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724678040; c=relaxed/simple;
	bh=AcYTrnEQ6rEmwT1vaGyuY4nZx/1v2qAyODP40cMMc1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PqGJhecYF2Pj8YiEwCAtePvXLCpkoo6alE2jdamezEb0gtoHlUafA6LBE5Qv07Dwuy6Gxyg/IeSNu/f6b9VdSYNVzEcQ4nd9wBWvKhikg1Ts9j0R5zRnr0P3xjqhwHew1k2MYLcdn2P29jlUTQe3WbWsjyBTUQ7Nl5koh5vLx6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DE6XCHhH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cE0bxivs; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47Q7fZjK025643;
	Mon, 26 Aug 2024 13:13:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=yq8sBJ1D+e/CWN2
	bkGtVufWWFUjT9bATABVWMKGNjtg=; b=DE6XCHhHsFBGfd8LUqHz317LZFai6s4
	hRCU4T6EfJwZeG7Q38P60wExKDFY7pSRFg6UU5LbQgfwnxyehbBHLtUHQ7GWsH2r
	wPbOz1hBKwFq29GesDC7itcngRkUas84uQa5FoV8guVDKlqbk1kkF3dvhKSct1KJ
	rl3qghrg7UiN7VP7aOvEgrxgOUUqqg7haIqOHFpisp1uW9IZS4v2ym55uP1ZbV5H
	PR5wVaMPzO8jtScyxv0LkHIAgUdQRphONa8zmhUfvIrRCblsZmlsrGHOBFd/N+4F
	ysqpI07kBJOeepP+U8rbXRZMMnSheXb9/nbYK27zAf6NVi+aJxuzWIA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4177nw320q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Aug 2024 13:13:48 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47QBvQRE016849;
	Mon, 26 Aug 2024 13:13:47 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 418a5qyf4m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Aug 2024 13:13:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rh2FN65+pgbpUbHnuXdiyhRNDb3D9c1LhNO1b0aTn6OwO7WDLkeg+XJ1XZS0bNKtaPws1EyW80OImiqECsPIlw2gYEeGUVgYCojK3Ib5Ww8tHcMweBOTMWx0bXPJX8xSquj0/Qgy2G0Fut+1d0ZpHexWvfjkCFvj+L57tvJSW1AhSCN+QZ202fgKQK71BMUP/0hCv6m18g4CdIeIzFauDed7yiqusf6hBmswpM0sQHBzz5Ovo1fqvSsUo3nECpKUSukbUJ1d3PlyKrbav/ZBP/OaM7bllSBNhFihnkd8b3XvSJD/kzQ6QMlnlq2Ld/bMoo4rEtSi50TwIqwEoicIwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yq8sBJ1D+e/CWN2bkGtVufWWFUjT9bATABVWMKGNjtg=;
 b=q+EV23xyVGnuFRu1xdixkP7pFspuBUX34lvdkvdYZmj8PEItXjkk8bpUs2LuZUu7qTz4+sv22wPhbVjTxniMYJ4arA7+nVQ2NApDv7A4ZTHM+fpTdSZa8hroFiP1iLGSrcJfpQ0gOc6qAksWbtZOb0b56RWL4i72/5/1UhVAqylC0LRMhKn4zEiN0iuTwX1d7V5nr75IkvZJWS/8QFQCuDBUUkqgdXDyZU8AdguDACCqBOAVP8c3AIoSjSDoO80q7Djr9Pfd9IEBRQGhSd1rlQdxsvOCQuVlE7XTKFKmHoJWvaxecekGIZdP9wzsO143kMXy0A1k5kytDEm0OEgtHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yq8sBJ1D+e/CWN2bkGtVufWWFUjT9bATABVWMKGNjtg=;
 b=cE0bxivsaj2cPfk7yfP67OD8hnRz4mYb5XMLFwgwoevzAlmdxcv+qewrWP/ztXQM+9dJwc6DC+Xxywld7zzWbbPmm+zbRv0O6B7tV4Nw0mwb1jqJIAYRhBagst+iIK0n+12jIyeA+HnSPFl52r9y16kGvcXaVBp9t4tWVFCmkEM=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by IA1PR10MB7446.namprd10.prod.outlook.com (2603:10b6:208:447::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.14; Mon, 26 Aug
 2024 13:13:10 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.7918.012; Mon, 26 Aug 2024
 13:13:10 +0000
Date: Mon, 26 Aug 2024 14:13:05 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: linux-mm <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org,
        Linux Regressions <regressions@lists.linux.dev>
Subject: Re: next-20240826: arm: tinyconfig: mm/vma.h:184:26: error:
 'USER_PGTABLES_CEILING' undeclared (first use in this function)
Message-ID: <5697d788-1206-421b-9c9a-3887c90e1c6d@lucifer.local>
References: <CA+G9fYuTLbZ+UiONYVQbtREuOZXc3oWP5=x-qqDhmFRmFfPtHA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYuTLbZ+UiONYVQbtREuOZXc3oWP5=x-qqDhmFRmFfPtHA@mail.gmail.com>
X-ClientProxiedBy: LO2P265CA0130.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9f::22) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|IA1PR10MB7446:EE_
X-MS-Office365-Filtering-Correlation-Id: a0dd4309-6e3a-4728-4cfb-08dcc5d0d526
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1uswW9Ng/fPK3tABjh8ObMFvhXEIewUH/LMkI373YMc/y4xBUn7OoyimQl9r?=
 =?us-ascii?Q?ZwMNioE8B88164er0sbRd4Xv2B++F+BK5+LPPDQ49cemjUP3Upq5lEplbkwp?=
 =?us-ascii?Q?ifdyJNzKwvjsLFh1p7XQ0FKg8irKXbL7hIW3MV283M1jGRnCxDxepk03klmj?=
 =?us-ascii?Q?VNM8wPzqstU78Qv+q+EP4rT4G2jQNKX7rhrG5OKiQqlSN8qdGZI/7qYtLY/H?=
 =?us-ascii?Q?aWzAxp5eZoi0p/vlwO8oJmLuT1y5hi6Id7WQQuiRjo7k8Bn+FNkFLf6DKDPS?=
 =?us-ascii?Q?mVz9QWvUPs7IdANbvr/KyiQyW9jIxeuY25CT6+uDpbUGxRJv+irRgKAqVu8o?=
 =?us-ascii?Q?6ccmB3O4F+qbhY6rYAp21+hjgb5i4BQ2aWlPEke3VK3+55zMrtwC9U0AWONV?=
 =?us-ascii?Q?UapbltszNrtzJ56FRNuoAF5HfenQe0eFM4jzNe6oBO6ERuHcxzmsW7hJCZ8Y?=
 =?us-ascii?Q?3JnfTM6cZZv4uxsY8xxeAn/aCn2JKKcGGIBPHkZ1mcygIYTkm3UmAa4IXKqF?=
 =?us-ascii?Q?sJ79XcEr/1L8q+PzaQadqIEik78Xuw9eSIwGEUqKG0uWqvLEkc52oTuAET2p?=
 =?us-ascii?Q?FVKGeBRaYfdWiorgTCoAKC7fyAzREPjV4cmstZSD7uGcMyiHpjfGKoPhLzUJ?=
 =?us-ascii?Q?O202TTYlI9MF0+H2wEbonHT0TdXMVq8M+PGZ2Z++aCg9mXbUH6fDAZe+nuv8?=
 =?us-ascii?Q?68+kqQRmPB/i9lr7D8kbEJvCdPLFo1Jr+6qFlWJPRIV2VQM+dDlpaZihJ9RK?=
 =?us-ascii?Q?49TJxkY2tHF7l/lHuM2yZmRNxWlR23hPFC6OoxDRUrngifKoiIOd/qJNxNB0?=
 =?us-ascii?Q?0IUHsAPWvVk091cGPyuuc9Mi3HSWP6QJGtvihCvB0L9A+6F/kYeUKNA2KcaX?=
 =?us-ascii?Q?08aBOSfdkwa4tFan2FvFfpSCbXBmD1he20yATggyxctrivZtcdG8hIlFfXtf?=
 =?us-ascii?Q?GpumuX7BoMDM1I7/u1NNfKMOAlM8VvD7qSMsElFk9QVls/d2cVQp+HmPj3mF?=
 =?us-ascii?Q?mxjo5uu/qojjuPE7KwD4aa/Cpw87d+Awj7sbWagOFs0N1oVisBPTTCiO9mX2?=
 =?us-ascii?Q?FJZ1/X4ch+otfV29aKHFW+94eYgQ9mfC5RlnrGLuopBDsGOlnS627mtozSxl?=
 =?us-ascii?Q?YCYptDzpOl/KVrsfTrcrj0MJy+CIXZT3ZQfmd19Fvw0zdVkBkj5Ikzc2ELRw?=
 =?us-ascii?Q?peoNlHHoKDRa698Rp5wd0/4sd/X1oCjCCmdYq9dWElsjqaaOM4nHObJ6OJjV?=
 =?us-ascii?Q?W9L60q2L3kCaTP3AI2xCShScEnR4b3EoWeeuFnlyubbgL7yzebsPhAIPCxqQ?=
 =?us-ascii?Q?F44=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tWOF+fOxRHS80RKitcxCK/LXrgMwaZdTHok2xqXoLvBdswA+c1OxPqCP3Uk6?=
 =?us-ascii?Q?v2djvU3FYkMmozIc/02AzQsDjoUM+mOB17myUsuIahsiqnzUN20IoiBqEpCO?=
 =?us-ascii?Q?PtN9HXIZs2Tk3C0rnVoq1sgTzcv1mTk1V8GApfTvKJzR7mngLM4TNeIXM01y?=
 =?us-ascii?Q?GDA++SmManEYYE3uBgdg0me3TcUx7i64nXgtby5dEvM7nGALEl9TNKWC5RAb?=
 =?us-ascii?Q?4Cn5SjuJCEAFmsFrnsYlfcbPQ0QF9iLEURwIIimGbb8rUSFU9J1cv3X2v8lN?=
 =?us-ascii?Q?mplerBJgrWh4Zi9wIVZpcp08sY7N8aIFvSFl2YDfVKm6dHWVux546WB89maX?=
 =?us-ascii?Q?6vye1qlDv8zzU1+FGy8GbdjpfUHwNPm61GEBmio+yIMN1lUPKd+ipsG3VXiO?=
 =?us-ascii?Q?8FF3rK78TOBJfz/Z439643s0jrUgKAz/o1icIpP3FALVpw5c4d1Ad19uYO0d?=
 =?us-ascii?Q?0dnqdVT5gsWBx67FO+C2mZPvMecqJcVtI3K/3JRAtjZCoD1CZgmo38ncbfQS?=
 =?us-ascii?Q?slTC5rphtWZ/B5PqfV2vO3r48uTXpqOSRdZqoHZIVKf2yVui6bIU24mBXX6F?=
 =?us-ascii?Q?RZkyHE/Okq6CypEdOGuoTqaFqMBdItD/o26oKfTrstEyWIP//6LYX/19Rui8?=
 =?us-ascii?Q?7UKpRtwoH5qCds25Z1ZPu2L8Xve8/w21Up2wh6VY3MNftUIv6hG0NS2fZKOB?=
 =?us-ascii?Q?nN5GUmAJAiCb0M93jy4X92V+nPzmh/dGtj5dborubc85DEDKQe5euvReRKmO?=
 =?us-ascii?Q?a7ZBt6LVAs92iSYKHzx/UcUl/fLPlsYkQvUVH4ohk4f3FvZ8e0y3m+Iu50Vh?=
 =?us-ascii?Q?bOFYLiovRudffGWeiyaOIrN7jXMNpFfxk0BVEZ/ZIpJl4uXBA+YztCxL/HYo?=
 =?us-ascii?Q?sCswHa17gAAd6JDSteOPCFrgh3vJSVbcnuz3v6acN9XQQjyBmedzdxydNaNg?=
 =?us-ascii?Q?k/Q1HG90m5/VfHd68IT+dyy6DO6i3zdzcmejh9Qg76RDmIdYdw2ctt/lAb0R?=
 =?us-ascii?Q?R73xF0UT14VWv99LvrNgDRGHUsgYS+qNu1ZqDr4iLrj03nBTHrg7W4DM+MDV?=
 =?us-ascii?Q?oFAEEqvcX4K+bs41Xi7MvQ8/Acblu6cXuLZt1SaxoxIb2b+dtYiI6XzK4AOY?=
 =?us-ascii?Q?jexI6w7v8pDg+N/96/njQIr9ZvzNa7v2B3w1/oWMNFzIgiBzWdl4ioiwAC23?=
 =?us-ascii?Q?fate034BXtB5ZrzFwG5enE5mzHXAZm0QJrTmBXzNGo0wClb4bR/7oLo8wtUQ?=
 =?us-ascii?Q?apJEarvt+BN8RCQV573j8gkMZ08DZndIvhFXApGttaw1TZPOVzvU4pvNVtUW?=
 =?us-ascii?Q?L53RxVgQHiW84GEqu6IgBzJowGShTSj5wjMJhY+H/G5E2QdmvH/8/X8UN6jE?=
 =?us-ascii?Q?Tz3czTINJGggwqUy2Gdx5BWDupdQZ+ll11sb2JD0y0Q73l09fx1qtQVQABp8?=
 =?us-ascii?Q?TFnMUT7X9vk/4utvIf5ALhflhKXDi1/gwgVjP8lABSF9m4C8OzjAGmiZbzEh?=
 =?us-ascii?Q?Kguvmo3RJ3DoP32RPLQY62gYkc5Rz5E5vEVVa/g0ZDNRhmPFDnZYRO/ZLyGF?=
 =?us-ascii?Q?Us1C2zcZr8srVenrczaopn9q7Bj1ZG4IPityBvM2egv3Pt8F1k7+8xzBQNju?=
 =?us-ascii?Q?IQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8rwbXHxL5acNo4Gv6y5PEYd+5QuvoTXsOO4YcEZlUZcpeukDzIctFeKyqrRRHzUhxV+M9cOKrR9jFW+Z0LDqRhESDeXSN4+A0L2PO5mJgM1bDx7uBoWCwN5sAHRQYLMmEJMjr/Li76gxuvwPEfcO/6C7FF5aSAU3XpLAciAQwn5hLaZmB/trsmdnUZkoqiGuvc4rEHS1LOy7+PFe7mJejhM71j6RJ0FEQlBLrh4SRg7KKkuPXXRCv8R4Krsgd3JGx0fxpFQmvbhB2+uFdhj8gcmV8GJv8+Bg8FzhAXwNHwLyKwKYuRXddj7S4rZgQ7WYFwvoT3ftjeH9q0PBPva4nPhFXfyfSi3ELOMEvwYOCtgt+jG2DOuRRw9y0fMNcue9MfUQ5h8HCdda5aeED6QkXZ05NxSjW1TI4l9Rxf0yBY747A+H5sjmZ63EW/DzL/zwPR6wLs8xrDGKWWS34QdNaKt7C70e78lWRjG5t5OTkHLsXKeTtTBjwue1gxpl/zcNE1jlmd3aXiiz5rdOgyb8ybPtfTgrkodVdTJZA8JjAOfFjfVzkJDTCAH/19e6oqZFowovZ9jSM6/GNbgEejYGSekNnlMwggebcSftXT60Zpw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0dd4309-6e3a-4728-4cfb-08dcc5d0d526
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 13:13:10.0500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mQo31b+AVLhXdewj1ncvToTcDz3+4IVkiuYG286dn83Z+ElFZ6o/Gj0kZRqE1MxpbNmduYnnjrQqEBreLUDDIJpgH2/vqOpdNLnI5ifnWTQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7446
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-26_10,2024-08-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408260103
X-Proofpoint-GUID: CetQykK8xf1SkAzPmyGcRnaEtk6zEBWp
X-Proofpoint-ORIG-GUID: CetQykK8xf1SkAzPmyGcRnaEtk6zEBWp

On Mon, Aug 26, 2024 at 06:06:59PM GMT, Naresh Kamboju wrote:
> The arm tinyconfig and allnoconfig builds failed on today's Linux next-20240826
> due to following build warnings / errors.

This was resolved in the fixpatch sent in [0] which should hopefully go to
mm-unstable and thus -next soon.

[0]: https://lore.kernel.org/all/7d0ea994-f750-49c5-b392-ae7117369cf3@lucifer.local/

P.S. this message doesn't seem (at least yet) to have hit the linux-mm
mailing list, don't know why.

>
> first seen on next-20240826.
>   Good: next-20240823
>   BAD:  next-20240826
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> build log:
> --------
>
> In file included from mm/internal.h:22,
>                  from mm/filemap.c:52:
> mm/vma.h: In function 'init_vma_munmap':
> mm/vma.h:184:26: error: 'USER_PGTABLES_CEILING' undeclared (first use
> in this function)
>   184 |         vms->unmap_end = USER_PGTABLES_CEILING;
>       |                          ^~~~~~~~~~~~~~~~~~~~~
> mm/vma.h:184:26: note: each undeclared identifier is reported only
> once for each function it appears in
> make[4]: *** [scripts/Makefile.build:244: mm/filemap.o] Error 1
> In file included from mm/internal.h:22,
>                  from mm/oom_kill.c:50:
> mm/vma.h: In function 'init_vma_munmap':
> mm/vma.h:184:26: error: 'USER_PGTABLES_CEILING' undeclared (first use
> in this function)
>   184 |         vms->unmap_end = USER_PGTABLES_CEILING;
>       |                          ^~~~~~~~~~~~~~~~~~~~~
>
> Build Log links,
> --------
>  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240826/testrun/24951924/suite/build/test/gcc-13-tinyconfig/log
>
> Build failed comparison:
>  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240826/testrun/24951940/suite/build/test/clang-18-tinyconfig/history/
>
> metadata:
> ----
>   git describe: next-20240826
>   git repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
>   git sha: 1ca4237ad9ce29b0c66fe87862f1da54ac56a1e8
>   kernel config:
> https://storage.tuxsuite.com/public/linaro/lkft/builds/2lC5HukjOlVYM52f7n4rm8EXOLG/config
>   build url: https://storage.tuxsuite.com/public/linaro/lkft/builds/2lC5HukjOlVYM52f7n4rm8EXOLG/
>   toolchain: clang-18 and gcc-13
>   config: tinyconfig and allnoconfig
>
> Steps to reproduce:
> ---------
>  - tuxmake --runtime podman --target-arch arm --toolchain gcc-13
> --kconfig tinyconfig
>
> --
> Linaro LKFT
> https://lkft.linaro.org

