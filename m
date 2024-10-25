Return-Path: <linux-kernel+bounces-381495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83ADF9AFFED
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 12:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 284CB283376
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 10:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF7FD18D655;
	Fri, 25 Oct 2024 10:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dP56cJXR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Df0fIBFz"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861141DE2A9
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 10:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729851651; cv=fail; b=gWWTkMKK8SUbCnYXUx6XlHWAEXVHnbes9d840tJZKYQoCICcE8Sf9QUuB86Di+w/Eea+vfOmh/bRL0hn8Ji14566lnNsVjM01hi6qT6GcHQWrx4gbX5UKBfkK2TAwUiTtfQR8DAabgTCqfXsQj6mDqN7oN9ZvYV3HXpWDW3fKyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729851651; c=relaxed/simple;
	bh=A8hyWHK/mM2hN7nKBGzX2W2Fqj7k9XZemafyykYyDL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FMya2+ZW8Sc9rXgSrgbYbQ23BagBsoIuv9Y4KaZw9paFA6+mJkrgK+6em5kEVwYO1+tMSI/rYJjbl26Vu2dH2riewRTbg+z/ECRu0f0d90399vjKm4Tt1ZnXUGYWV/pVfSTGUCtUkNxXkVtNCKack6+E94PcTWwx4+9c7Qebz5g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dP56cJXR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Df0fIBFz; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49P8BaPO014251;
	Fri, 25 Oct 2024 10:20:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=L0/oGYzmdhkIIC/t78
	0qONgGf8oibiywk2/tgQLzLGU=; b=dP56cJXRHEoTIqtKwdBZqKcy1xE0rFSujq
	AiKbNLwYz3K1pH3I1y/etFy8Dj/lPnxdS30/H9Q9p+xABsxGe64lTAxK6100RWlG
	HlpziHLSPxr3pIQ+saBgMwc3dZn1KVAdXHqA8n5g6k85K3yOpyKAq7G0vR3H1hWn
	GW65hUQJ7VTlGm/b8vQpK3MRGU8Y7LDOHSQNoqxhhGrsxRZaaJjxKR/nQ9Lhd0Rl
	NpwFHtwv6SDUuzCnDMtrHSYcvHq8Ov3K+otp8KRm47C8oeDlpMrfRPBq4+l6BdlO
	wOdQ34j9CbDLtVxM/PiwLpmObKrVI5IvUIOUiS3pLxfDNmJSXb7A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c55emha4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 10:20:37 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49P8hvU3025419;
	Fri, 25 Oct 2024 10:20:37 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2173.outbound.protection.outlook.com [104.47.73.173])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42emhc4909-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 10:20:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DTBQaEV6gfdP40fGlUPYMKnoWTQFtlRnXUnhTrtvK+zjKGAU+WapLI4WZEBmZd8ajL+eUKQqUhroOk+rp1gp0MY7/otr6X6N22YjS2pzOi5vIAxdiQ+mP6jFCN7fN8Iiks9wgxssjr5P+BOoJrxlqtMcf0S4kb3pcae71FSNQ8vgsS96kjukVOBH9VQKw30LHgDOxG8OfgqVz6opfqUuw1ePmDEKDbqUQ4iNkylmXRviZ7F5soYyVrtdwLJgjD7AcbMp2DSjsCMMsGeAmHLW6i3jA01Qp7lYXKNU1FTC5bBoMcQP9ACUopmUxqY3EeHMfhHh1vmdqMIt7nRXQitS6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L0/oGYzmdhkIIC/t780qONgGf8oibiywk2/tgQLzLGU=;
 b=yVmKcl193uynpfxKTzCs2KOaljUp+Shr/0PMOmAHh/GirUsghGzq2Jg1MFSVT0XdaUyl7MXoYZL6o7hQgphBjq1hpmu9GfnpOgpCnZ9GTUmUJEQw9RYXlaTGeHYFh7cliRqeRK7k9yCB8eYRPWaI0mrEZv4bOtU1Fc+EroO4OQxwgnGseHaT4ogs8aRf5IbjGLgyYsMCpnz0wNFZJ8/qDF1iCOQXcYtx5SDhhaoI1dc0umOSZlTG8c9Oe8SOyy/IllVW2tdz6qJYnBpsA5Mnuvfz1oWFz5LgNUUcjjT1FJAox9DA5d3rPpkCsHdOAzXICC6/sX/HdcREM5SFDO1ZEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L0/oGYzmdhkIIC/t780qONgGf8oibiywk2/tgQLzLGU=;
 b=Df0fIBFzVYrYE11RvDzvHoJ20lpYNPuRJZIyOUm/YWkyatuFQUjlD8SjGcPsEKDu0UnoB/h3KYDWOCzYOKwu91B8+nqJ5ifiGlM9z90PoIYi92LNI5e5CIhBqec32lIEn0W/ASPc+wa6Unptklf1n2RvPTjcyLUrBulPAPwU4mw=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by CY8PR10MB6755.namprd10.prod.outlook.com (2603:10b6:930:96::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Fri, 25 Oct
 2024 10:20:34 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8093.014; Fri, 25 Oct 2024
 10:20:34 +0000
Date: Fri, 25 Oct 2024 11:20:31 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH v2 8/8] mm: defer second attempt at merge on mmap()
Message-ID: <e76fb4dc-3134-46fa-ab51-f28e542e1880@lucifer.local>
References: <cover.1729715266.git.lorenzo.stoakes@oracle.com>
 <e063d9d31a4dbd83c2d77a3f1e0114e6a0788724.1729715266.git.lorenzo.stoakes@oracle.com>
 <2ca9450c-b5aa-4e7d-aa7b-437d9aec45dd@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ca9450c-b5aa-4e7d-aa7b-437d9aec45dd@suse.cz>
X-ClientProxiedBy: LO4P123CA0446.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a9::19) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|CY8PR10MB6755:EE_
X-MS-Office365-Filtering-Correlation-Id: df304200-0ead-44af-468f-08dcf4dea974
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9EmVpeztsOKMmUNdxjU1ua3CVso/1cRIo+26t+KxeiC1NPi/viKYgwJj0t7G?=
 =?us-ascii?Q?KlvGAymdH+7LS6N9iK5gD5S342k+jP5riWCQhR1aLG57jL89gZX8jEQCNsLr?=
 =?us-ascii?Q?yoUDlrMjmVgogYipWDW5nGBdnO85ISKf82KeQtY9dQXtI7RPMw9CCCl1tzHX?=
 =?us-ascii?Q?BWMLPFewUvHKaxDvIgOe52Y5pjrAzt4AD2IWmEGUEJj/nKioHpD5OWDNiTuY?=
 =?us-ascii?Q?ShH/Xq9op63ConqkC7D1L3pFmbc9vOTUNvW162XEt3PU6e5wBSjIpTodpHQv?=
 =?us-ascii?Q?su/09mfjfvCObQI3S7MFg0q8iexk3GtKcEcQtriEdR0esM4FXNlXHBO6DDyr?=
 =?us-ascii?Q?a+nSvE/yAcxyLJfmdHeeMDhZDDfXKljtyDIH59VdOIjrTOD9P1B01hdUC7D3?=
 =?us-ascii?Q?+O/R3Ob5QXU9vArxXzS6WUTiF1A64f9BxoP+C960VNFcdi+U4BTGqEWqbxpV?=
 =?us-ascii?Q?fg67gXfnsOV2pUVCl90hwz5OXTDMDTgcY+ye5njYcyDn8xUu9wW5W/SSVdt6?=
 =?us-ascii?Q?A2fDrNYIL+yLlwBskagz0VJJGdnpE5Y+CgFMsM/KTK1Iws4yP/lyN+V1j318?=
 =?us-ascii?Q?ii7rP+nRaRVYumcJUTuG8jvCNPpt1JnZ+5GfaXVXtt70/dsYWl1GuAen2ohR?=
 =?us-ascii?Q?NPXJoa4achmjEt2Du3/WxOphY12OllhXl3VEJgX3lARE+PCwRTs4hUP/BNa3?=
 =?us-ascii?Q?2XcNjD9dQuMJB5eE+9MxkC/jYd+jGPHfHNVnVVRoWvVySQphHVn2Q1qVR6aW?=
 =?us-ascii?Q?Fp3VciT8i/y0xPz005aViCfwXSnUfhbYSE9AYlh3AypUCkA9l0wy7KJgKBKu?=
 =?us-ascii?Q?p5TqxdBonw8FCf7kTcmqWf+wl/1qA+0iN+YS7tnNk+A3j06GCYF9Kwl0zG5C?=
 =?us-ascii?Q?urIUG+jJCMAu83XGIsso7lnuLqVWSQ5BEcKEW17Dyc74JjV/i5ygHeHz/7Rt?=
 =?us-ascii?Q?5Qlhwj6iMUi6eMfc/8r17CLjpnzK6C0dBupLvuQp41pGt3ILZ4w+QmZQdzGW?=
 =?us-ascii?Q?PY6kkGnIippiE4VpbAZrzszS2VlWbmok5mEn8wzdV8/Hj+fF84ltfyNVmebu?=
 =?us-ascii?Q?Mqh+WxSjgjlyvc2n9Gf70uFxzKmpgiSW084DqEs0mD8EuRf1AcBEXzDFZ7If?=
 =?us-ascii?Q?jJXtIJG0PTz0Rz0kNGNo/buzu6+mKPvrqM+FAolBd4vHV5TH2ZFnw+yD2beJ?=
 =?us-ascii?Q?MIBT95He45waOBYtCGXsic5LgSynpVO4sppdfuMWNlq3F2s6Hr9iHenn3GDx?=
 =?us-ascii?Q?I0g54dhor/h4MacLfCT6/KBAsUG6mimEdmYinHvueS0UKQWKi8tA3oQ/kPFp?=
 =?us-ascii?Q?8dQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VYgYe+xnshWyLgjntTADAw4K4otvSPCQmqyUBm7+cvwxmrvctMh9xiambw9q?=
 =?us-ascii?Q?SJ9o55uLZ6558Cz+HwWRBbBRnevo9ws0wASw9mXQE9VCEWDD3WjDavFvEPTm?=
 =?us-ascii?Q?4QRm4c6e8RnSfhQCZP1pgBIu0VWMWm/O73O4+HxpR9Hh2ZvTs3aITw1fC/tY?=
 =?us-ascii?Q?gG5di932mbVvuco07AgUSbKJw2JGMVOPODhMQY53D293s1K+tWJGA9nmxJEj?=
 =?us-ascii?Q?X6tsI+s5J7ynRfbtvmom5MkLXLPfjEHiB8U3WiWxaZRXM9VUDOU9BDUSO/SU?=
 =?us-ascii?Q?oINqcduBlyHgr0QtN9AbjUvz429pbGc/eAGpo29zxFaHNxbMmGT+GFuVM8wZ?=
 =?us-ascii?Q?nbA16tPfl4E2ZOoze/cdHdaTmBAINofgcd4firedQ6RFjSZ6awQyo+uvGt5h?=
 =?us-ascii?Q?6skF+y0aBKJZFKwVNH3rNtUvFpY/XtOmqeJ3gk0mzegcLdr8bL2kyMtzpqGn?=
 =?us-ascii?Q?+M5P5aZB/2tfXFoDUB+Uf4BhHg0XHHylNCHxG3Cy1izIkxoctbBSr2s0wrl7?=
 =?us-ascii?Q?DtOZx6excTcoldjzKRgRrEU1kuDk5FXMoM2j/9zXglVJkR58B+I7Nd2IcbYS?=
 =?us-ascii?Q?Fpfk/rEniikbmiBa+gIDrmvyifsFfP+5hrcF/xR9/0ez6ec3BqNHkxJs5IYY?=
 =?us-ascii?Q?e8u5bJeYy6HJUMh7ozWJ1HpM8+audwgsvpQPXDIVF4eCLjURWq7iJ/Nbh4nM?=
 =?us-ascii?Q?iNtmydV6Y3kh1qu3Vt6iqPIFnNpPglG/cWrU9orwjap/0HKJt3F2T920/6u0?=
 =?us-ascii?Q?G5dXhGpCMS2JmT2hu7gKSNFENM/KgTtrjxBnCcHlF4SSCVXnsWqEhrEDIE1O?=
 =?us-ascii?Q?XOYHr6Im5aKi6d5rg9P6jnqqqxjT6uUSREQ/j1AQ20YUJMWvXqMt3pY4tz/q?=
 =?us-ascii?Q?yKggbtmcZZowqc1IsRPKAPXq+1liIsJqX72PbaTzEcvWBunQE5wYehBG2yZM?=
 =?us-ascii?Q?vfxgNyKB2GQZlOVJa46eq2MoIY1gvNLOPZd72Jv9FcovZrcU9IOJqDeagY2V?=
 =?us-ascii?Q?4bkk3QKwrhYMdtPbsCYDrUp1raxmoixCKiW4i3e+faqFzlkujvnCzyP+Phsg?=
 =?us-ascii?Q?nDYna1FjEuI2eW/j457VC4DyFgpPjl61d79ImGLaxRYPkOLhmf6cb67ScHif?=
 =?us-ascii?Q?qCJsZnVUGKus9rad8u1ZTzh/1LpOsS86RE051WG3JFTH0mPEVbNFjQ+7dIws?=
 =?us-ascii?Q?T+HsAK1P5rKA5NAFWa9KRuhBGqF/8GQta+MHzXc6gBYtszaS8Mp50e8X/2+D?=
 =?us-ascii?Q?ghPalsKBS3XmFzEzNSyci1Wsvz19Wncn7pKlGvinPCXwifl4vPnAxuHeRjBn?=
 =?us-ascii?Q?sP/B55rrRf2rJ9uCcbZpLVUB5HUM8voHNXNJgyCzVEBaQFpiitY/iLMkx7oI?=
 =?us-ascii?Q?va69/ZSl7L1vd9JLg1YLuODP88QKgzWxrqCjtvqN4EF1DfylKsE0F5zHUZix?=
 =?us-ascii?Q?PenjymTddOxuPdf01cMLcgvVE67TKs3/1t5EqFWIsNDMXCDsNiyNZ8krmH8D?=
 =?us-ascii?Q?boWpUYKf5wMf0HipJVByd82BoQpezInXiEgExoklnV+0rhSPpdLFtoyVOWvN?=
 =?us-ascii?Q?goWV+9hPjaOKTz+PDq1Gma3ekjD/YuIYOlBAfrVfqtuaDq7caax6DleYdve1?=
 =?us-ascii?Q?2WyUeaa5pF+OrRb0huv/tNNJVPWomhq8y1YcHXe9MJNcwD8QTEjAuJV2m1Df?=
 =?us-ascii?Q?GwzuuA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SxexQHDsqd9bgsDW6AzPnvLi96XOdQ9qe/WSptqlkD18KBTThvoYeu1cdPsRTQyrp9MSYz4+FXAfFnBQjYbXYFK1x/wltJyXXiX/s4aDMSY0LQOpulgDywYr9a71Y4wVKUab7CHRdiZ+Jv0bT7x8PAJOgRLpYqZ8N1+dTzZ2hrNIpOzh+6c1utMP8mCqNl5wm4R9gUz/dCyPKPTH+biF4xyUGdgHV/Ya19X00+NX8NORNugoKftAYv4E0pqTl5XC/OlqpM0rTQdezCxuLfZ1da/l4XJPwigpg81rhYvhgPe35YyihTJtdEPR0gn+kevcJnX38vQxsdzE0CcdfRiuu58GRrlUVwrDJxwPjkuvvhuM8wD3wd9v4Gv20xWXDSlraH/8P3X5SV8vTbl5d4HoSN/252Eah9+yZwZydjqbilPosdlKxkJcLbrUQQ5DbxZrdyCHnMu3yBRhiBg2JZGDBsSOJBf0HYAiarBSEgOZtCeRXxvbMXOlNrelxGXduqkDOSELp5ouA1KSmX24WU8ZH+yUXYK4PD2+Kx1CTWD9JRXDSJ0aqG+hKCcPo2cwAjUBuVcP/S00/mTQi+Xe90XKGGJN6CuIu+IACPXG8nG1eXQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df304200-0ead-44af-468f-08dcf4dea974
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 10:20:34.5162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FzPUyfKsy8fU39okhbQX8j4lLaSh1qfBRjoQwpheiArVgz9uwx6EPPgLw2sWApOg+55VM99X1EaWLHQKVQs8Ha3bSkGidwwgERjIErdvsNY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6755
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-25_07,2024-10-25_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 mlxlogscore=731 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410250078
X-Proofpoint-ORIG-GUID: u6vg46HbXCtaxiLoguo2a7WLI6qBTrPp
X-Proofpoint-GUID: u6vg46HbXCtaxiLoguo2a7WLI6qBTrPp

On Fri, Oct 25, 2024 at 11:43:20AM +0200, Vlastimil Babka wrote:
> On 10/23/24 22:38, Lorenzo Stoakes wrote:
> > Rather than trying to merge again when ostensibly allocating a new VMA,
> > instead defer until the VMA is added and attempt to merge the existing
> > range.
> >
> > This way we have no complicated unwinding logic midway through the process
> > of mapping the VMA.
> >
> > In addition this removes limitations on the VMA not being able to be the
> > first in the virtual memory address space which was previously implicitly
> > required.
> >
> > It also performs this merge after the final flag adjustments are performed,
> > something that was not done previously and thus might have prevented
> > possibly valid merges in the past.
> >
> > In theory, for this very same reason, we should unconditionally attempt
> > merge here, however this is likely to have a performance impact so it is
> > better to avoid this given the unlikely outcome of a merge.
>
> Maybe just expand the cases where we set map->retry_merge, i.e. in case the
> final flag adjustments do anything?
>
> > The vmg state will already have been reset by the first attempt at a merge
> > so we only need to reset the iterator, set the vma and flags and try again.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Thanks (and for 7/8!)

>
> A nit:
>
> > ---
> >  mm/vma.c | 75 ++++++++++++++++++++------------------------------------
> >  1 file changed, 26 insertions(+), 49 deletions(-)
> >
> > diff --git a/mm/vma.c b/mm/vma.c
> > index 065f5e1f65be..c493ecebf394 100644
> > --- a/mm/vma.c
> > +++ b/mm/vma.c
> > @@ -19,6 +19,7 @@ struct mmap_state {
> >  	struct file *file;
> >
> >  	unsigned long charged;
> > +	bool retry_merge;
> >
> >  	struct vm_area_struct *prev;
> >  	struct vm_area_struct *next;
> > @@ -2280,9 +2281,9 @@ static int __mmap_prepare(struct mmap_state *map, struct vma_merge_struct *vmg,
> >  	return 0;
> >  }
> >
> > +
> >  static int __mmap_new_file_vma(struct mmap_state *map,
> > -			       struct vma_merge_struct *vmg,
> > -			       struct vm_area_struct **vmap, bool *mergedp)
> > +			       struct vm_area_struct **vmap)
> >  {
> >  	struct vma_iterator *vmi = map->vmi;
> >  	struct vm_area_struct *vma = *vmap;
> > @@ -2311,37 +2312,11 @@ static int __mmap_new_file_vma(struct mmap_state *map,
> >  			!(map->flags & VM_MAYWRITE) &&
> >  			(vma->vm_flags & VM_MAYWRITE));
> >
> > -	vma_iter_config(vmi, map->addr, map->end);
> > -	/*
> > -	 * If flags changed after mmap_file(), we should try merge
> > -	 * vma again as we may succeed this time.
> > -	 */
> > -	if (unlikely(map->flags != vma->vm_flags && map->prev)) {
> > -		struct vm_area_struct *merge;
> > -
> > -		vmg->flags = vma->vm_flags;
> > -		/* If this fails, state is reset ready for a reattempt. */
> > -		merge = vma_merge_new_range(vmg);
> > -
> > -		if (merge) {
> > -			/*
> > -			 * ->mmap() can change vma->vm_file and fput
> > -			 * the original file. So fput the vma->vm_file
> > -			 * here or we would add an extra fput for file
> > -			 * and cause general protection fault
> > -			 * ultimately.
> > -			 */
> > -			fput(vma->vm_file);
> > -			vm_area_free(vma);
> > -			vma = merge;
> > -			*mergedp = true;
> > -		} else {
> > -			vma_iter_config(vmi, map->addr, map->end);
> > -		}
> > -	}
> > +	/* If the flags change (and are mergeable), let's retry later. */
> > +	map->retry_merge = vma->vm_flags != map->flags && !(vma->vm_flags & VM_SPECIAL);
> >
> > +	vma_iter_config(vmi, map->addr, map->end);
>
> Do we need this still? __mmap_new_vma() did that and nothing changed since
> in the non-error case, AFAICS?

You're right, this change really highlights that, will remove thanks!

>
> >  	map->flags = vma->vm_flags;
> > -	*vmap = vma;
> >  	return 0;
> >  }
> >

