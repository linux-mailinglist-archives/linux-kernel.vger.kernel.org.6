Return-Path: <linux-kernel+bounces-286545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59383951C52
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 15:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E1281C2152F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 13:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20441B150E;
	Wed, 14 Aug 2024 13:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ec62/Jl5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dpDDfxhJ"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D791B29C2
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 13:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723643646; cv=fail; b=i0E0DhAVIBLXyWLEkNOs098RE/+KZglHK1OJgAHXE+o56mTMShlBppnfdU/GgMP8XpgB+T0fMz215kjyLfcPr6g4RPI1Lw7mAbiEdGXZP50znFXstQEljxqanxmay6ZqtBH2Zb3ofvPj/KzmDYnkU/icgBivW6h4A6RDQQGNNG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723643646; c=relaxed/simple;
	bh=8NwYitaZVTgtWeyyUJPdOllzVuTltxfRkAP3ZEWaNe0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=S7OGw200PAKnc+2Uijq+KpfxleQxvmP6gUD6QDJMKP1PJNF4lhMiTB3s/yJUk7s1LCel43OX0EM9jhXn7MHXJyeZ/OMNMUgJc+dJAF2+oy5+VoNrEPL1xURM//B24+87q/mlE6gjP8ptXzxi9Eru9O6GwRRfQWZ6/Cy5eyAkCA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ec62/Jl5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dpDDfxhJ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47EBtZIh007011;
	Wed, 14 Aug 2024 13:53:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=wR6JAz08HAL9oe/
	DN3+y2geSaIzoEo5QGdYnDILoBpE=; b=ec62/Jl5D7fAxAZoiRSCxkemfNeGXTd
	w5dS1tkMcaKBUIbfpI4xFLrpkKO1ecO+8tNwNwoN5TKgdeIdvelGLORJOYhExSEB
	fBokOfdopPX4tWroxzTxDd4PpCZz7U7HWxjaj5eSiIRir/0xnC7GWd0y6zno3/2y
	+M3XftGhQ3ps7jMEEY4+YdIXSKG/NQjsNejJBunAXzxG/ei3aDQRjwSULTxpCI0C
	VSTcu0zdSyRc56Wj1FWRazd4LBRSfDpdInBtVWaSr3s961DC3rkXcp+C6ZJcJEia
	G9Acc05POSeWRX5CBe643cqfbUtVaNFoVI1QmYqR3cZvIBqB6jlmVEA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40x03987xf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Aug 2024 13:53:55 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47ECnJ68001390;
	Wed, 14 Aug 2024 13:53:55 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2045.outbound.protection.outlook.com [104.47.70.45])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40wxn9vqs5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Aug 2024 13:53:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SY/1XQdP5K9C17ca2FCcXCNzzKOGcFz9VCAHYajFFn1UFVw9VAO9h/bIcsiYvI2N5WBTum0hlnrGw4ET0jOI0FBNAJqeLmHOkgRv6KQ5K+d52Nw+ucc8ytWHYsr36aiM+h/uud35hbJc5xGHrbc+RSrNFqJYxyA9ZdJUaPMRBad4LuAkMKYVu1dgbORt1/ExrLuSErZfXrfDSN3hHOVZTPO2Yy7Wdf37e9iXIY9gsSy+e84g8mr74eB09mJptwgnNpwHGRmOyrx/MXbEp/vYe7QYrf49ludvAqvqAoTyFZLzpeQsCnzh9ivuamB5tTLECMSq6I+UecG1VfHKoyCxZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wR6JAz08HAL9oe/DN3+y2geSaIzoEo5QGdYnDILoBpE=;
 b=OK5qr4/SB3dyI3AkA23mN6Nto6CFVXy7ffPLwHa4WqZf4m28ZnjQDb+bweOc91CfT+SOUbgrs1K8qzb8X8W0OaT6/Rh/NbX1RAjrRovX/frA/GDgZFWtQUX0CpbkXX/SLcAqjMS88NV0S2R76/W1bhoJdozMeLNsGIuN7jz77uAVhPccQDirstuWPqjByy5lfiTJFGNL/FcRTb3fmYQCqzrMSX+FdrE0cDCFcmqXxKtf4q+wznM1w+m39h8L6aEpSfmlIfF0M0eZ387OWf3ZAKWBZppQQ6p12pYtyj6zjOHr9qJWSPKLaXnk/fX5qLqylodezDw6venmwLd+ATq1Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wR6JAz08HAL9oe/DN3+y2geSaIzoEo5QGdYnDILoBpE=;
 b=dpDDfxhJXVGyTBR3cbKVcQNSodx59+770TrAxau1uf/QA/St4DLLSjoUQIBIyUsb0syxvPOyc4879UQWCiIIgwfgptFZ9WXufumzpu2+MI5aWDbkYBKZSR4whQPiW0IiLgPbfgzjgAOH9eMIcZE+Pv3wVLp4Eg/1QDz4thlM5O8=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by SN7PR10MB6450.namprd10.prod.outlook.com (2603:10b6:806:2a1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.16; Wed, 14 Aug
 2024 13:53:52 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7828.023; Wed, 14 Aug 2024
 13:53:52 +0000
Date: Wed, 14 Aug 2024 14:53:47 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: Re: [PATCH 04/10] mm: abstract parameters for vma_expand/shrink()
Message-ID: <d1c80a35-0a96-4dd3-9e91-ce4f062d90d8@lucifer.local>
References: <cover.1722849859.git.lorenzo.stoakes@oracle.com>
 <95292b1d1215f49bd895f1aa38f54a8274c350af.1722849859.git.lorenzo.stoakes@oracle.com>
 <f12608ec-9c40-4977-a5a6-479f86b44e80@kernel.org>
 <2d85f8a8-6937-499c-91fd-7dc5deced71f@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d85f8a8-6937-499c-91fd-7dc5deced71f@lucifer.local>
X-ClientProxiedBy: LO4P123CA0270.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::23) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|SN7PR10MB6450:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d988ce0-dd4a-42bd-1b0f-08dcbc6887c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Hj9gswQR23hYOkPTgK7JWPT7/kg4wk92xG8/RBkX2SH4e9zoCZ/VjZj9pnXO?=
 =?us-ascii?Q?yhHV8XaDa+OATXGYvPPN7eYhqkoRBTUW6Wb192XThG+XL/K9vUFXutwuxjBV?=
 =?us-ascii?Q?wJ5g1Bj39GONwcPoFAShbeJ8ik07uo2LRCJWVZ+AvR5zUsdBJOGgbKPz2KLj?=
 =?us-ascii?Q?CRTxzDxgfdw1YzqGeMrXCaE4V4K59nSl+BEJxMxDQIfmn5jMWhv0urz9jCTM?=
 =?us-ascii?Q?xrxZPvoM3z/dZMDFdhE3uB1tpSHugZbJMh99vx/RkPbYHVvpv2lvJOWVyWpj?=
 =?us-ascii?Q?WAa1EZKR0/NORiNwDEqc81QMReRSQogwnAsX7rMVL0tk79kI235SG9321OP2?=
 =?us-ascii?Q?FO1pBmiuvZB77TmmJm/tcP+3EXz88hwSRHRg7KmMZ29/Ez9jJZf+JMe7IWUI?=
 =?us-ascii?Q?q7ctmchwObIv7T0d7WwqFEGDvmD30Mr2EUEqQsfFakGkMHN1AI/lkWwKDYwf?=
 =?us-ascii?Q?v+VwChM5xPzz0QNtEhSHsD5LojMRB5CSHeBwiGlJqnTgcUX88i3cNpoOQTCS?=
 =?us-ascii?Q?Q72uqQRM2dRtAjIKPDxk8u67WcE9Zp/XRJ/wy8ogLac1Z7cDZyFXRHjcbomx?=
 =?us-ascii?Q?+jjC9153k8unq0EhdoNA1TzA1w1RrtR080ZDaAZpfziVihyXWmJqr8ypDhTG?=
 =?us-ascii?Q?vvQJDtRGT4PEQrEQCTdOn73H0ExSo7mi6i0Ok2kmD2Dw7TGgI6XVzx2KpSeM?=
 =?us-ascii?Q?/u6qD+fw66uWqJuq0RLxGclvNtPbpyI4VPZD8OoFKfcPR51clW9oDCexbufC?=
 =?us-ascii?Q?1CWoecl/Bdkpva1cCOFfAniKXOX3r5r5Pi56RuMSsNNExdYrwcWsk+cPnhIx?=
 =?us-ascii?Q?GhxmOlSU4qjLnVtyOpdx79NggNQOaDD/anb2KEZrEm1patp0d+ksrb/kxW4D?=
 =?us-ascii?Q?2zqVv+MpOy3EPhcMuE/5SNakHv4hpQG1xbaSuPqm+MLT5jHSi3siNBHVteEh?=
 =?us-ascii?Q?YkoruGovsQtTJ5R3u5hhnPUrERE99TvIoI8jPz2Wmd8kd55mnXy815gFHWfa?=
 =?us-ascii?Q?qykrU5KZWOsNy3+X5l4C+iPrWg6u+ACe3N1VlgS8wpvLUBcE/cranS1hXpe7?=
 =?us-ascii?Q?wyozvi8qbe/BPefC1kZUq//NV8D8ZBSOfSa7xcp+0j+VGU9zKyxfzyt3fqvU?=
 =?us-ascii?Q?Gbdy/7SzGrZlmufwKf8IRhR3x5TStmw8QtplyOw5E+VoJZdeNyDpgKx00r/y?=
 =?us-ascii?Q?yLuJ5FA2rKYu7+3YJvbyLxC6U0JQcCiG7Pln1Wle5S87drFv95lENyiWwCAQ?=
 =?us-ascii?Q?9xx6uiJe0Kluz/QCc4Pwa5h6IXSq2MzM/41rFWEhbKkmOaRgxY60F4SwTY8x?=
 =?us-ascii?Q?q4PKd9PJmlbtQ/cAP1JpnbWZ+NbOMpHlnHQ5KT2Li3H0TQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1AD4misdOYYHEaarih4Eeq1q8crlMA6luBwnNt1c4S7R8V53qLFZJi2oTzRn?=
 =?us-ascii?Q?ojqdsTTbdjWeCZCZmwvUdOa4lTVHHY6cLKfFIMWWpoPmCxt0w8d9RFnQEvM8?=
 =?us-ascii?Q?+5B6ePV24vWw7WCKjdFB0WCVgMXfnSKlnn/PWpD2+RHDd2JWSVtBLHU3VjT2?=
 =?us-ascii?Q?rinLyTvRwk9JGt6WQO7OVCCsPsfxrYq4C7vB5RaZpb3LwxP90Te3yGo/ncIb?=
 =?us-ascii?Q?7+PtzcDC8SNPHSxFI6LwtA/QNFIxJ3MMZ956EugNm4CqrF1gpq7RY/3n1A+w?=
 =?us-ascii?Q?5S3LQ43KI6SggX+JNzGFQNvk5oXwbPd6JVjvBLbIFVj6Gx1CsRaXkosYC6Fi?=
 =?us-ascii?Q?QweQk4ezmoek7MVdj7GgPmiylxW8Jvw3PUQnc0n/7Jp////n8SJAA6/2YEUf?=
 =?us-ascii?Q?F633YyP2Mz/LKSGLqNrEr/SwUM/y6YwYT0ymPiFf67LtqIEU2CD0KxBzk0in?=
 =?us-ascii?Q?K3ZaCjqc9LAo21AVJCxpLYXZtDBiKZJKhBmXfW8tJg/HXsdA9Ad0U4mOX1ES?=
 =?us-ascii?Q?BKf7cpnAYDGtG8Ip2gcZcHFT6IlTbwmL3GdPYuwk9PwgO+VIHkMpZUvZYdv8?=
 =?us-ascii?Q?FonE7eu/sgAfsaWp9eDqgtouVAZEJEHFyXdSWboKj8xH/ZEUCPxnZfwjVUUi?=
 =?us-ascii?Q?YcSUzCeeQ+GHvOJdTQAt8EhmFlfYHLZR00FkXeJXoixsXTgFtX3qReiiYUmf?=
 =?us-ascii?Q?dzpb4LJUTHynYsr5HfVTrJHlyt61quBCcAAnXIZkfNcQ277pk5xS243L+eKf?=
 =?us-ascii?Q?3thCTetgkuRsHkQ7yX/V3RkL+lOpu31/Gux1Al/xPrODq11URjZ25hBQd0mx?=
 =?us-ascii?Q?iuFAUo83SFdnXxeV6YNldnb9Nuby9u2RjEde6suk92e2NggmSfYxZoi8hXDg?=
 =?us-ascii?Q?6sZQyfX3tqbPmaux4tj+nDZ4aSrxG12jFjq4R/RZeY/4XF6GgBSX86wjVgY0?=
 =?us-ascii?Q?4kq3PeZQL5jKAie/J8WkvgZ7Vmu2y0VPaJmB/Y2fpc37gfNunWkg3oWSjSxV?=
 =?us-ascii?Q?T4u8pw7Xdmmg08p7Cmfzf3GZFdfUMztZphFoVxOCpHdmzF3rqFAhjdDylqOP?=
 =?us-ascii?Q?gGwM6Yg6oWFE6YDH/uQzlBtMI2JaX+2J0veusr3KIqUwvmTV8ndChIAvR4bK?=
 =?us-ascii?Q?NRC7uZQhlyU8ahgL2sbxs0A8NVGY7yzrOQ29LAUhX10b0xeZiC/RPXehmnye?=
 =?us-ascii?Q?B830GcOTjveLasd5ulX05tfRoMXXHbtTi24M4bzGyKetXvH1WjRvGX1sco6j?=
 =?us-ascii?Q?Ruop/N1Gw7vGCv7U1WFvt6lhFpB6h/RHhvVozwzRpbPXsBFZfNurMc1CzqMl?=
 =?us-ascii?Q?KkStvK8Y7jqYEP4XVlzF8drYDuIwZbgmK3fUfJrq0qP9lDO+CXJG3JJDUgrV?=
 =?us-ascii?Q?rVQapCGlJJ2EdYeWaeOZF+RxlEEoz2owhG3sTQjUXBKBpPXINDjg5aqFEG8z?=
 =?us-ascii?Q?d//3cTXU/6pDLC36ktSSXGoTSJH9MuQ7P1bFVdCMR2gwbaVHw+TjppmmH0Hm?=
 =?us-ascii?Q?LRbRstAVeyRN37B0q7KuCWuR0ilKZO/61eiDMEBhSYCqQ/8SvQtfrjcopZgQ?=
 =?us-ascii?Q?Q8Z3LL6dkAYVG54ID1lEg9cLNMiKtvhS7JXkfObf/0t5UkHHNzCLMoW3XH5h?=
 =?us-ascii?Q?YrLWnvdiBpvRHbm1xiH6l5GwGDxsQy+//BIW7pb0fXLeFAv8aQ61A14vsvYb?=
 =?us-ascii?Q?ETAl0g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DUTSoMQ9iTbOaChpVIBtqZJPLw0UhQ8BcP2n5e5DZQsTZ7Ebql5jSJnVPerHvj9LijTmV3SYQc0MWjMCw6OL+vC9fMX2JOd6XZUKxOJKWXHnrTQ8kx/E0eTYRKBjDM0olSPnKjwNKf81LXyFDpWLLZ82Gs2jMlaTflkmqATHq5AnHSa/GnM8PJa4ZgIM9zVQj6/jhTQWiiKDuSfVZvu3iSA2L0WS4d4i+DLSx97vAF7H2aYPSN73wkw3cewLt3zsgbo5BMjoxJiBEmtOi3zYWu2CZbqXnO4r3EQ+ZerbbRmd+2kjoUSqSYDxxkjNdu5MBUQ/wtCCvwF/WkFXAxTd0NPDo/066gB2D/Bc+CT1B6PUwRRbZiq060Ru9azV/u5IXxp4SMpsk2gShzKODtqXV+u4y01B5T92v/wyFHvZRxYEeNfic/F4l23eXOOQ3yWChN5lT91fKBnrbpJyH6rDEmgzJD4IHV1wHGO9JKNM1njSe94eOl9ZLvhMcCLAuLlV6ITaMp+PDoD73k/ifLDZZPlg4HZdhMSyiyKQMdSnHJyodUnFVbEF9sqRMuZb1Kxhg9b/9xJ1p65uis/M0bYSsWsBmkI3f0izWZDOISut98I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d988ce0-dd4a-42bd-1b0f-08dcbc6887c2
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 13:53:52.1206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dw1gZjqs/7XOcA3yvllYb++95cq6GS8RbJ3U4Rx41CK2YoeAgTo1PfF8W6ZOIUuxzTA6lk0ubsbUlrgaINHfbHaQIsBrZpxNOA6mFNI4+L4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6450
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-14_10,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408140098
X-Proofpoint-ORIG-GUID: ceRC-CyA-zif0txksvYMzYxzetjUvV2-
X-Proofpoint-GUID: ceRC-CyA-zif0txksvYMzYxzetjUvV2-

On Thu, Aug 08, 2024 at 04:45:53PM GMT, Lorenzo Stoakes wrote:
> On Thu, Aug 08, 2024 at 04:20:26PM GMT, Vlastimil Babka (SUSE) wrote:
> > On 8/5/24 14:13, Lorenzo Stoakes wrote:
> > > Equally use struct vma_merge_struct to abstract parameters for VMA
> > > expansion and shrinking.
> > >
> > > This leads the way to further refactoring and de-duplication by
> > > standardising the interface.
> > >
> > > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > > ---
> > >  mm/mmap.c               | 30 +++++++++++--------
> > >  mm/vma.c                | 66 ++++++++++++++++++-----------------------
> > >  mm/vma.h                |  8 ++---
> > >  tools/testing/vma/vma.c | 18 +++++++++--
> > >  4 files changed, 65 insertions(+), 57 deletions(-)
> > >
> > > diff --git a/mm/mmap.c b/mm/mmap.c
> > > index 721ced6e37b0..04145347c245 100644
> > > --- a/mm/mmap.c
> > > +++ b/mm/mmap.c
> > > @@ -1367,7 +1367,6 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> > >  	pgoff_t pglen = len >> PAGE_SHIFT;
> > >  	unsigned long charged = 0;
> > >  	unsigned long end = addr + len;
> > > -	unsigned long merge_start = addr, merge_end = end;
> > >  	bool writable_file_mapping = false;
> > >  	int error;
> > >  	VMA_ITERATOR(vmi, mm, addr);
> > > @@ -1423,28 +1422,26 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> > >  	/* Attempt to expand an old mapping */
> > >  	/* Check next */
> > >  	if (next && next->vm_start == end && can_vma_merge_before(&vmg)) {
> > > -		merge_end = next->vm_end;
> > > -		vma = next;
> > > +		/* We can adjust this as can_vma_merge_after() doesn't touch */
> > > +		vmg.end = next->vm_end;
> >
> > Ugh, ok but wonder how fragile that is.
>
> Yeah you're right this is a bit horrid, I'll find a way to make this less
> brittle.

FYI for when I send out the v2 respin:

Actually, as I work through it now, I think this is OK as-is (I'll remove
the comment as it's confusing though).

The next block checks prev, so the end of the VMA doesn't really matter,
and in any case isn't checked by can_vma_merge_after(), but rather by the
prev->vm_end == addr conditional below.

I've addressed your other comments.

[snip]

