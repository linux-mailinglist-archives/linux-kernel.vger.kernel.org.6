Return-Path: <linux-kernel+bounces-258994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D74D938FBC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 15:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A8721F217B7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 13:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 136F016D9A1;
	Mon, 22 Jul 2024 13:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fchZxxOg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DhWZMfmu"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA7116938C
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 13:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721654113; cv=fail; b=XcyA5jKN4Su1R3MBYUs9CoYuXUkjFRFbf/0GQss4T5m+MFx9vb6hsGPiGLdH3tGv0oj7iH/1WR96smfmT4pi3Fv4yt+H19IR3zina9f8SladaKnzoGBSB/4zbzLKSc1TAW4KrTrxbRzPfDXiEqxCvPWAA6cnyt7JssLgjtO3vuU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721654113; c=relaxed/simple;
	bh=VzFMDkScIrunGd12VS1qo1nKP5vfMv15vA8JIDUydc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DOCXFUFN0dOb8UQmRghfraPF2jvOX/0H9HbrcBcEv5JXgeVRf6ADQiiY+c/gLWOPM74dWOg/IzX1Q2NRAZfqQBu2n1Zq3BdNYPUW7Cr/dLLJvkchGUEWr9gFupeLyTwL4U9njoTqXHSLc7FtJuD/CBQPFbl3JbIRCiXp/P42k6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fchZxxOg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DhWZMfmu; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46MC1hJ4015775;
	Mon, 22 Jul 2024 13:14:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=1bOC3lMi6pEsB+9
	0osW+RfjUn+m3Rwvd0mYNe/+oO0Q=; b=fchZxxOgvYMi+fUi6bPbabWDDKjF4Z1
	hw1iyepBM1Xu4ZY2ZIhJ+jI2GGa67Y7722Vci2u27s1m5JVvUehISZqkndW2gsZv
	jXxx+qIiLZkr/6wCR9OZDn//sCbX2b/WeSDsQvcAAFuVbdp4q7k1f5ybBVUXyM/D
	LAnHzvq0NMkzO6AzTfNFS60Rzv0cN9WGiY6UI2vCJ/L+7r6D3S97CNUaT4872OSZ
	EiTpKtMTA+KbYtnPowaA+2CrLEZQT7a5HmwHZYhrV+tJgCivqxKyGk3wkAQ1ctBF
	c8uIRfBJhLA6Sn2cTJ8836/6YgK28aU+nV+i8Vm1rRGcekcB0tLMw1A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40hgkqsp7h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jul 2024 13:14:52 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46MCkc5e034532;
	Mon, 22 Jul 2024 13:14:51 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40h27k015c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jul 2024 13:14:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gmX93yQFlN0t/ZunkCMbdXFIIm8XZDkFWkXs7GKCTQDKcaTBSxtSWMCUG8sRsqA014P2xiUUXlizcfK3NBS8l/9WqfgWs1ARMGVYLy08Rx7HyGILnfPAvKIS6dowlQ+tcMC1SrnqdyNW4BSIp+A4uUkMW2i8zxqmPR0mWyQULUzUpLNU2t0L0+O30QDUgb6dWJi2JoFm0NtJT48kFgJbOyDWfZQieRUmORJ4ZPpcDHs1H51VoHzteWod1zsvS9rMlZVo6vp6kMjXaO/3lUCxZFCmR1kFrTPCSbG1FyazUFBTeXHAmxIDuXJmygERbqr2Lv4dAJKgbjl0b4MQD808VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1bOC3lMi6pEsB+90osW+RfjUn+m3Rwvd0mYNe/+oO0Q=;
 b=VJS9rxYBZ/h2q7p/wyyzPEgKIPGzvlrIpss9VYw0Rz9/TEfRHB4pqTEBlemqDJjUQL7cV5yAopSZPOaaqjx61ZYnmtPUkwclLWbS/+tBpcjLoExiUcEPFpTxxCBJqLtGOTfTAwkwd3ftU9YI+NveJ77QblXeBzanQK/NOrsAVpgjA/Cz8ZOhDy82i9+ag7R0ZKggdcRTpxa1Tc+tBn2KihDeJ/mM7Ww6WuT7TjgvqQy42R5of79bKXc5gLqhN8qla1mdpvgKiPBRcjFfVpApC9q0SKY3Oi6VE53rYWpng2dMFJjLnSf/jQWzAvGaarusZWy+c8bv0Koxw3dEhQKoaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1bOC3lMi6pEsB+90osW+RfjUn+m3Rwvd0mYNe/+oO0Q=;
 b=DhWZMfmusAG8PVolujOgAKQnZS630J9VrF+TdErU+NYF+YqSJN/sP2FXkP0Q0fJMxCy9SYFaST+p+c47fx1JwC0o18/PpHHTPIVdOIOKymkyWf0WURYgh52IoMgAAH62AAhgFKbWLsA22B+QOewxPjF/AK5mstVG7CP+UN2YBqk=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by MW4PR10MB5678.namprd10.prod.outlook.com (2603:10b6:303:18c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Mon, 22 Jul
 2024 13:14:49 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7784.016; Mon, 22 Jul 2024
 13:14:45 +0000
Date: Mon, 22 Jul 2024 14:14:41 +0100
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
Subject: Re: [PATCH v5 10/21] mm/mmap: Support vma == NULL in
 init_vma_munmap()
Message-ID: <9013db95-8a67-4e32-bac0-ce04063f7e70@lucifer.local>
References: <20240717200709.1552558-1-Liam.Howlett@oracle.com>
 <20240717200709.1552558-11-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240717200709.1552558-11-Liam.Howlett@oracle.com>
X-ClientProxiedBy: LO4P123CA0435.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a9::8) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|MW4PR10MB5678:EE_
X-MS-Office365-Filtering-Correlation-Id: 15b92124-85aa-436b-22ae-08dcaa504179
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vmEmfMhIcy4/iUJZYrk4Omee+HmVQO2vKOd6y+4aAXZmb7vKylGdQKmbfI+P?=
 =?us-ascii?Q?5zVSEo1T1lB/nhzXzaNtxJATMIKpme84E+nYMKSRPGb4KMK+lFsUO5W2pbWP?=
 =?us-ascii?Q?BDPFmTob4e9V266NHfNUsXYV6v3stGrZp2G93+cMTw26ijgbCsdkqRLlWyvn?=
 =?us-ascii?Q?4zLAW9cPS/JcZ4n6PUNj2lKcQ4e3fdHENixxyZgvUxx15EfhMYzC3RTRE+77?=
 =?us-ascii?Q?rrxQRcP2i3uLgVv3xGlcBR/6ss6+mYl25A9io6P4V9rOmS/HHMw4zBQE/ZRR?=
 =?us-ascii?Q?iegZjU2I3OrgeE3E5LzDdosafBOZPQ70KGJVPSiE2xLotzHJhQUbeXT3Ht1F?=
 =?us-ascii?Q?zfsd/04KChLfDAT2PbQ/SKGF+pT1iyttvkmV0HO4F+eh6iy+P4GzqPuXWeKE?=
 =?us-ascii?Q?O67qUSDP4699rurSJ3ZUwophCJMkXNPffJAJpd+JiXITqPK99kzBHxn2Ygh2?=
 =?us-ascii?Q?DPxcPINuiIlWKHBhH3DfM0cd9ITDcmSIaf2poSJ8wqOvnxqEiwejAMPlvT1G?=
 =?us-ascii?Q?q7TWePuH7VNDbZzc3Ks9gsqYcirkAA6uQclM7x3MuCC4pyjw4Bo2DqXu2oiZ?=
 =?us-ascii?Q?e+f3JbGSbuO6WLNZaQcsKHhm7/gBmpVddafThy2S3115feIkwGvn+XYxXEiE?=
 =?us-ascii?Q?vcdi5ygoZx7ZbGjnpqW7BVn0Kl17zMFJsteZNwg6eIC9NxOWKulp66ldMuld?=
 =?us-ascii?Q?lpO8yTx/ojpfm7z3s+m1eeG/8hqo47n5cvo6ognoTXs8+DwIwLWOmu4MUiSb?=
 =?us-ascii?Q?APPraiaovy6prl519sBLuQ+gbTCbnlLj1h1H/V3NCbm6TZRhtSFapLqxnkfa?=
 =?us-ascii?Q?3hgtJ50oSafIhyEkQgiV9z7VMjWs7PTtN93gXpNYhaCaruPv4fbimMPAdnf5?=
 =?us-ascii?Q?R0XitrXWaT47cbNojsKCmMYZteFsmYEIvOyGvR6dA4+nZ1U1Zv+XgS1W4ZSR?=
 =?us-ascii?Q?Ipgit8Z/kZgSdPlb3bZgxijBhDJWTDznMqUwijdYJbYMIBPNoXQOepNagY3x?=
 =?us-ascii?Q?SiUDrfWCL9T/eJX+nU4wrsIjjgcLgdmQNBOTaKrMWCzMjrqQCRFzJ58AOShT?=
 =?us-ascii?Q?nhVeUqKaaVg1LA3DuaPJcxBIrORVbzlGBNSLSF2rFkAspXEdHEiyfWgYS3bk?=
 =?us-ascii?Q?ir0QsIER9QfzhFvw95DjDFlRru2Xaa0QguBjuKw+Xcb9JZhscVWIrLxeSjtY?=
 =?us-ascii?Q?2Rdk5dh4gbURli+m92DZcQG7saKHoPn459NEl3p8k94iylPeNDpEglJ/pdlC?=
 =?us-ascii?Q?NQynjfDHZhXiXK20FRDJoN5LpnDe6kq6MOTAaAxrdBVhK/EwvNLKnrt3TdZ1?=
 =?us-ascii?Q?EiRGRU1tofAU9w3zD3Z0mwXF/p+6bLzxhR/I3JHs7E/6EA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6IC/U1hManRtwKUgYnttwVufW3JfmF8Hhd6Y7Xd73i303hZF+kOBgIVql4hk?=
 =?us-ascii?Q?r3J5XCWwpAxHF0qK+wSXPZwd01S3yPxGxkdosXFhfq47nMHMPZWxtGPrXHLF?=
 =?us-ascii?Q?NKfEa+opehO+zHcGx3Sdjhiw0YeucvmBsRxWN5hTcbdSlkLcilcKdwpB9H7M?=
 =?us-ascii?Q?F4WBa7Z8EhbFRDxc/4ekXzchJZ0vFA0vcCRi9dGX5GlhOB0wo1P8GlD9FGuK?=
 =?us-ascii?Q?JpORjYZtbirF0OYtDpGoOLjrLEF3naMFTifUGtSCyrh6y1uhjGJSMQBPWRsh?=
 =?us-ascii?Q?tllVfUSaLsyZEkiensVVk8403Rvm80ecIVzz9+sRxKVUHXoov3MfhMKnll9m?=
 =?us-ascii?Q?iQIzA9SvOezA3/FzbAq8y/TEyEfYg+R9ECRdMl4MAz9y3CS8EwjdrGJn6q5v?=
 =?us-ascii?Q?O2+W9aY/SH/RePqoTqH1cu7h/y6D0jMY3JG/coz+9UCoI4fAeIomkjMlJNLb?=
 =?us-ascii?Q?XapQe7X8JHtnkms3RQumKYUvDgc65LrRgvUqRCLHNMv0H4be4pNEZU853zQG?=
 =?us-ascii?Q?nK5VUpXSJ7nqTfgKY1QAPIHwyS6yuUUOOnL/xyTvRgiWPDWWPtbTEkofTvrl?=
 =?us-ascii?Q?0w9hStwyzVPf2nz0hGBfLht4FnU+F+22fQdHx5duqnGPlfvgd7tYjT7pRwxE?=
 =?us-ascii?Q?7HafcfNNFR/zg2+2F7lZgBTm0YRdBOKVjoqBcCnhFuF0QjsemCZ086AJI7/2?=
 =?us-ascii?Q?sycBEs5gvE9gdB6zfL8zUkkkxXuTaoEjZGjU0nCX4gaZOEfcq8EGhhPDVIgY?=
 =?us-ascii?Q?lHhjZqBODp9+umT/RU9mfn/aSr0BRXftkVz9xfnrZ8xibyw6IrRoOYNsz/iM?=
 =?us-ascii?Q?FYMFOohRqy4FpusQz0WnR6iJUtsXdAcyzCXYmVkArTEl2mXr/bwyrwRFkfbl?=
 =?us-ascii?Q?FuRATKQSRMemZR8QXIaooDFyJq03ZYiUNPNioEN3NQiavdSMaEu+Q9/GJu4c?=
 =?us-ascii?Q?jT6E8yj1WHrgc/rsVT+mK85WnnsLsWFZCXnvQ0UidgUy2TU+eGu+olm249UA?=
 =?us-ascii?Q?pP5r3zgoQFOQdLscNrROiDlHeSD6evYJDGKDMnYGZHHTujZ82nyBHnxnOV7L?=
 =?us-ascii?Q?BsWyX0pttFCjgxEnhV+X8XSDBtwWouAGgCKekqVcWvswXe1QfONB5H6vVzCG?=
 =?us-ascii?Q?rR+tEci6ZPSZQHxdJOqCIEYLEgH+Odkz8bEnTKC8FWyxzX635DCXBOyyou0A?=
 =?us-ascii?Q?4xC4YBXCQohKI1+5QO/Wdpb5DDXzjcA4KcMu8jlSC4Fnav58VCDZZ2A7fXtK?=
 =?us-ascii?Q?09v31AXyKau+ko22YYHUjHoCH7lyUdWXx17q1IOSPZ1zOflVaDoVtqq6DNKO?=
 =?us-ascii?Q?f1vMLeSv2ZS4FDpFHPM06YjqDRMdnBMSWiegl2tozgoMWI/dYkepEynpk1LK?=
 =?us-ascii?Q?2GPG/kxsylx3q0SvRUvD3VvjI3xaDaAu/UEjo54OkxFl+dcvvVv5ZDWn3wYH?=
 =?us-ascii?Q?a5VlZNiDIYaszeWE998FHYXpG6xpnpbGmbH5vj+sls1nezBqqF37WC8lrU4c?=
 =?us-ascii?Q?/6S3Z8pmCFngKDjf2QxhztP0/XiAzeYuR7wud2Vrjx8AiM6Bape4oppNmYYu?=
 =?us-ascii?Q?09BLn3HbVxCnC9OzBsKhQB5k+S2ZOt6z7yJYlUzVz5zvnp+rmjcAyDm4a05C?=
 =?us-ascii?Q?Gqay0265oppCRel/dWR4++xAuzb20/xO1ylQC2SJxTQ952JYlRkTHipksxWN?=
 =?us-ascii?Q?QtO90A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YwZ9qM43ftn9nzMzHsGU80mcyxFV8r8X0IYAebE+aTT7pDn7d5IrXlheCfSJ8m29AHrBFw35OowIuS6GYQ+n7RhNC1Ltz9Da7gmcVpBH8/QHN6J7QzpVkpy3YHEh/yxI9/awWmIf7jNS2mTkeQGEDR1FAuciocOvjUk7TPjbCrkJz/d75F106SkdL3Oo5UAO7xQ+YoiXvv7o1oxxticaLlkVRV+brkMlZzXIYmxRRfbt6n2Cw2RRH4Yle0QHL5yMrNKADQbEpkrND9/BJ4w704JStLywyfAeb4S3GzXtnfUBUjJ3D3wUnW7F/h17RI39zLABZYrkyD5TvrINZZDwR+DueaUDmOgdr6oIcdc96jOQgYjRsVB0FSzm4CuJOZbIuxWtoc7ZA+b2qvsTUZLAHmXDkKxnW9CYbox0yrY7x5w1UXeg3O3hSUZTE7VqXiFL5c6U7V02XovJ7koe/PDIgVdGxbqPECconnU4LLTrMBaMMiwLXaQ04l5lAF40ekG+Dpvd9H8dHsbyinFx4sgXIg8owdprzz2uuCJ0w/pwDGRAzNHS1S5chCqaZhP2dEkf/CLAT4kHJR8kDmT+VNtPZNBmjh5jy/K89QyLuOZ4RK0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15b92124-85aa-436b-22ae-08dcaa504179
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 13:14:45.3930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hVHp2DXH9DjrN271ooVK1sDyzfOk9ArRwhO7nm+VCmY8bxU3ViCNr6jG3j/mFNoL6IKeVOxMtrDTPXl3F/1eH3ehenNxwkfaFa8P/9wjwQQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5678
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_09,2024-07-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407220099
X-Proofpoint-ORIG-GUID: Jcq5ff6y3LVnD5LZeEIye6FPr3X_Nl-K
X-Proofpoint-GUID: Jcq5ff6y3LVnD5LZeEIye6FPr3X_Nl-K

On Wed, Jul 17, 2024 at 04:06:58PM GMT, Liam R. Howlett wrote:
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
>
> Adding support for a NULL vma means the init_vma_munmap() can be
> initialized for a less error-prone process when calling
> vms_complete_munmap_vmas() later on.
>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> ---
>  mm/mmap.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/mm/mmap.c b/mm/mmap.c
> index a1544a68558e..722bcced0499 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -517,9 +517,14 @@ static inline void init_vma_munmap(struct vma_munmap_struct *vms,
>  {
>  	vms->vmi = vmi;
>  	vms->vma = vma;
> -	vms->mm = vma->vm_mm;
> -	vms->start = start;
> -	vms->end = end;
> +	if (vma) {
> +		vms->mm = vma->vm_mm;
> +		vms->start = start;
> +		vms->end = end;
> +	} else {
> +		vms->mm = NULL;
> +		vms->start = vms->end = 0;
> +	}
>  	vms->unlock = unlock;
>  	vms->uf = uf;
>  	vms->vma_count = 0;
> @@ -2950,11 +2955,11 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>
>  	/* Find the first overlapping VMA */
>  	vma = vma_find(&vmi, end);
> +	init_vma_munmap(&vms, &vmi, vma, addr, end, uf, /* unlock = */ false);
>  	if (vma) {
>  		mt_init_flags(&mt_detach, vmi.mas.tree->ma_flags & MT_FLAGS_LOCK_MASK);
>  		mt_on_stack(mt_detach);
>  		mas_init(&mas_detach, &mt_detach, /* addr = */ 0);
> -		init_vma_munmap(&vms, &vmi, vma, addr, end, uf, /* unlock = */ false);
>  		/* Prepare to unmap any existing mapping in the area */
>  		if (vms_gather_munmap_vmas(&vms, &mas_detach))
>  			return -ENOMEM;
> --
> 2.43.0
>

LGTM,

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

