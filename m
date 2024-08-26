Return-Path: <linux-kernel+bounces-301368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED4B995EFA5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 13:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DA171F22679
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 11:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB8C153BF7;
	Mon, 26 Aug 2024 11:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YLI/f4nC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Z30DDAfR"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445874A28;
	Mon, 26 Aug 2024 11:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724671503; cv=fail; b=Jl0ehJzkVS1MRd8fcw69+m4lSRz+KHjRX4ynF1jzIUutQqGrygbMyzCjIdf5Nc+SUrlFbLbmj9cei/6xOuxZCfaLuwQYgqUXTI1gCBDAMeyYpyYpu9ayziSUthjqzjX2TVpw28+8SQeRsaZw+OGQAdtOPfgu0Vg1oMinNbRkbV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724671503; c=relaxed/simple;
	bh=sbHAlvjpnxqwbh6flhFj25qCGZUDRhEcNfdUbJOiStM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RslilxJNBRjgw/nGIA8+Gvn4LwUWO5v6dp7nekcQfg10L37CV/RxPf3lRqVink2YoeQc+ivT1eYGON7PTvu969GqsWybmDXs6AVNS+H4zfqud0+AYCvzQWBYYpm4aLKUFsPiiAsxbSZ0J5nQogpEfJNsvpVfyokV6hFyVG6SUnI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YLI/f4nC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Z30DDAfR; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47Q7fT9h016803;
	Mon, 26 Aug 2024 11:24:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=a32GDCxnVgFcHQM
	BVPbLUnwHfeUqek2WWfdvMGRuutM=; b=YLI/f4nCaMdCmv/tEE6rUeRC8/TVUQJ
	hR6pjtPl3kOsxFNQNuD7CSzxp9KTX9PqypcyOwoo/kLV8KCZddJHSeo2mLmhoD5t
	5yd9B5IlPVObpUdkjEfGdYoBNU+TryucEp50vtkppaFRYi2FQtuBJyW+pBUFcDPu
	Bu1kEZPk9HQzMTbtjzkGR29vlKkh0MxWOrPd+7MuFvXKy5ZeQzlxIcund5qpNy96
	g0frvt0xSDSsxmQoItA1mYLj5PNwnnH1q5O48/UfE9ecYsRRjk6OoT+DxYthgtpd
	dptF8vWV1OwLo34MCIsjw5QwpG1d5WPt/slcvlHNMkKngFIUVfTsFsQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4177kstud4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Aug 2024 11:24:48 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47Q96u6I020188;
	Mon, 26 Aug 2024 11:24:46 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 418j8k3v9r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Aug 2024 11:24:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S1kZIPKbe4stgZ769ZDa6PSHDJFW2RYN1Er6lEaWJcPXzpWymUQapl/1Ln0Igai3gAGH2gvSd29LDGC2kkmQSzbiV85eBegiAINCDCLYbFnyg56+VzK5ZEIWwt12oKw4+Q3tq2IkxuRU2a4PElM+qubt36JqBSW+o47POgMqPeO/QvSJhLbyz5qB38Kasy2Ep7yfryDxlIesVI7Gn5WFvC2eDMecE6g6S+RPI+kmhnONhTKeLRd8t3gcbb627Jp9Edb4QmWy3J0dzy3wdqG51SfnrlXDTlHxwhkstwZPLvPoR+SJpSbjRWJqPLX8jE3IbJrX31SAAO+q5lHQHgRDAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a32GDCxnVgFcHQMBVPbLUnwHfeUqek2WWfdvMGRuutM=;
 b=N1QwTjs9X6Zq8wj3MQ2yl1ojVTFmxyehEZBD4uWeT7DagbSi2Dw2HlIwALDYtUWhVlMJdHxxW0CVNc2YrcujrCYI/CBg0wUP0LRnka/A7lxrFhb/WGhtr/s9oRCADVTZHkMPyLYuD6Emv7L40Yuhbp5sBw6pjT1S/Kugd467VxePvtRD9ehyfAHUZ92rooRvGexgpd+kyjOiVQW2Guc5HOmRsGGHxBs8VrHpfRNhqgExtYFczsf++5p4FxJBFwALPx8iZ6lpit+BC9VjPbLauLTVHDa3jtfX9Ij0Au2/+VbToxYZejbwNGzAtPD1PDzsK7gav6no4VJXwcOAQrkcKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a32GDCxnVgFcHQMBVPbLUnwHfeUqek2WWfdvMGRuutM=;
 b=Z30DDAfRq1mx/aR/TOje8IYHhV4/N0+6+0LpoV5ICgzYk3elcyHsZQKMHkDoid9OtH7TRtG4VGAv+5ZvHzxJ+Bu+fnPAbeBhNVvRThHkzhneQtRAinwDOVQzvqb1wuhJS3hgG54tZYwJuWNRc0CQ46D7q+UfML50DvLNS4FSkMw=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by PH7PR10MB6531.namprd10.prod.outlook.com (2603:10b6:510:202::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.14; Mon, 26 Aug
 2024 11:24:44 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.7918.012; Mon, 26 Aug 2024
 11:24:44 +0000
Date: Mon, 26 Aug 2024 12:24:40 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Lukas Bulwahn <lbulwahn@redhat.com>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, maple-tree@lists.infradead.org,
        linux-mm@kvack.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: adjust file entry in MAPLE TREE
Message-ID: <db6bb380-2de5-4dd3-bff1-54981dc6c491@lucifer.local>
References: <20240826110215.19894-1-lukas.bulwahn@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826110215.19894-1-lukas.bulwahn@redhat.com>
X-ClientProxiedBy: LO3P123CA0023.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:388::16) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|PH7PR10MB6531:EE_
X-MS-Office365-Filtering-Correlation-Id: 60aea020-5fe6-440d-413d-08dcc5c1af36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xwhz9lq6qx7UeN04blpfDcnEjZ/lvvklqicEUGwvUdCpKKKCdk3CYsrBUfQv?=
 =?us-ascii?Q?R4zMGKjFueouVkHHsVScOF6RKnhYU7ytwDXU6ltHYcAsr6Y15SV0xqWcuOPV?=
 =?us-ascii?Q?Qa/UdB9c3l0cE8YRCMweWo6UwYgYShs9IhMyqUPPpMqTmaZhBVmFqjealkFd?=
 =?us-ascii?Q?x0B+oqlF3N8CfqzDl87cT0Z0b+XV9nfW6/yKRAAiptx0wY4RI/isxKzsd75K?=
 =?us-ascii?Q?B2B+FbF9vtdweJ6D8oPH+0nMlN6kWfU309y478pNNM+BWyREYnpSY+AHOtMc?=
 =?us-ascii?Q?HB0CF8yh5OV+mx3r3la+mLCS+zN/b4TnopAfgLftYbNlweCGxlriloKjp2a7?=
 =?us-ascii?Q?7r1TAapY8C49f1WDNqla6XEWYuPQ5IP2LeieZzSG9D7wbGfIyBXg5KcVOZeW?=
 =?us-ascii?Q?wzv5lCdPLEYYvHR8IrwVdkCUf7CT4koRv3gBcjtgpWuNeO8hDIuDGyN0dct/?=
 =?us-ascii?Q?6jO85aZMprb47COxmc934hkHVrpYebYMIJia4lmTtGBuifbFYBayEMSOKt8A?=
 =?us-ascii?Q?CWitTUoJF+oQiglMNGtAIM54gnIOxBM0PyJLb6yex5is1heYU4ED+Rmu4A1x?=
 =?us-ascii?Q?Uewxvwa7GSPB1vpj8bnz3jCEw6qXSrjn6vmwdVaTtg9H7V54ZL0m2W0GyIt/?=
 =?us-ascii?Q?n1cQFlKsU4xlBZu5FvbdqnmI3srDFkRkxWr0qYsiBwdAQXya9PZ/TfJ4wrI9?=
 =?us-ascii?Q?qGNzhNuVV97CKO6SS/S7g7PRm9GNgUdAICmfXqxe4w2+pEUvs0+8tKhiPu6a?=
 =?us-ascii?Q?ixPJ/SvNB/BGP7UOaeLKJvNXeAboM1twUGXFCJPS1fNskJcRZxABot/IKnaX?=
 =?us-ascii?Q?9ycg7wxOQYe87gSwW+q6vuSGeNNJt67xWuTp+0mJ9BjuMM0TSEeyHdXbxmkW?=
 =?us-ascii?Q?ymx6r8Vdc+G+bKM/td/e+QB9OLGMbR9mR4SpkIVY75Q8aaizI3c/kHAqfAxE?=
 =?us-ascii?Q?xoIqsZ4gK9v2VHV+a20Ty1LbOEihOSZ61T+/ijO8SjQIKeKcAhX6ADo71XjZ?=
 =?us-ascii?Q?hgEfTaiSMJ37SyS/NYf2PPrcWJtLcVolloCZrdSXJiLDTTdEhqOofznxGmlM?=
 =?us-ascii?Q?pxTtEwJR8R+iO886aNtSMqpaNLkUIn/iM4yOoZzC6Eta+kTC3lgNhv2pds0W?=
 =?us-ascii?Q?XZ5Xm8BNA/wRgZEQVzhgY/H0BmHFDSvfvK0/UOKjt3Mvlb/TvHW82Qb6Ne6t?=
 =?us-ascii?Q?qFLrJglGCQVPU4wOtPpHGKnB/2Ou8Umpht0ga0W1ewqE2ZeHw+zSAv7BS+Sq?=
 =?us-ascii?Q?RtR8mOOlkOu1L0i1VAqenr7NLYe/ej+3F7HqxXvjhL/y9+tj4khpkgQ22iF5?=
 =?us-ascii?Q?85Mo91XxzCbaGD0HVuEmWMKZ8Wu07uvY6yxAwU8ft84Eqg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5j+rtmFtxV0jSME9NCQfL/b+cNXjroMwtTSomxCqXeWeT9qM9H/s0aI6pf/3?=
 =?us-ascii?Q?pHTK3rPkiHM2UGJqem38OKy2FBpyAQRNzJwKXzo60f4KtbgsoIgny4pstQ25?=
 =?us-ascii?Q?rCuJdJvpF8HVoz7K53DZ44PoU1m2eCuETvLJXVfpYhBKOc7X1wMoIQOiexOa?=
 =?us-ascii?Q?AXUQp7mxsRrFoCzGXDOjCe4+lPVDg76cJbW60CoFE4hbMw0/3TuyjqC+17tM?=
 =?us-ascii?Q?3KNzhBBWIWVQGR7eL084qQEThb36wT0tQvIuloX5xY6nESC5pv0yeDB02X7t?=
 =?us-ascii?Q?BTJ5BhWu8ec31JGnP2xHCJMhaB4OTn4H+LDYOOEY+d9xbD7QnpZdKvHrsFkF?=
 =?us-ascii?Q?5jlN/aLAyvzBoP58KDbD6UqArHb0rE1+Ygiw4XK+eiBCXkk1y/VwrE4/y/Fc?=
 =?us-ascii?Q?Q3MAnOMCAWVn2HPJn313wpp/b6rxBpP+SqDm+IP3aU1hXsFLCdXd4oOoBkBN?=
 =?us-ascii?Q?QJRLuEmDMHYt5KBJINtm5lAUy9WgJ57FThmG5gropUq5Vv1cTJBHJXhHGp/B?=
 =?us-ascii?Q?ZLoCGKocypIYsuabWxYZYt3lFheUWAMUlIxPYwofBckETD1U/Pns/mK0Ra/B?=
 =?us-ascii?Q?/MEbt50u8IrEu40E45ViUpR4y/b9TQtT682Dl+Dchu2NT6SUXNO8QqoNkgh0?=
 =?us-ascii?Q?XklwvJgNaUKxHoo24yX3i4eTjHYHj3oN/gI7cR2ktFH2fTQxGI4xkWz4j+YY?=
 =?us-ascii?Q?PmxyLmjlrgLc4IlW7w6DGWtQm4+zjNV50TMSdMtG8gbHYYKNssmxppw2oKS2?=
 =?us-ascii?Q?kaITetM13UEj2/7c8ueZfeg43Oh+VYHccfh9Cpjr8AeaCY+x6z5lHJkwO2TO?=
 =?us-ascii?Q?lLLU8l4shrwfFSIN3H0ON8GiEuhLqEaWpoBzroIFflqdpTCMD2v80fbIAVWO?=
 =?us-ascii?Q?MnZlgVZFFoO99q6PT9mM5q1/k0m2tw7XglDgMeJzsroAdVW4RcmMT72VFqL4?=
 =?us-ascii?Q?W4s1wwekBb3sH6x9ZXZlalsgIbY5S94WZkAsogEdHUihSbvLJYtgP/OlOe/W?=
 =?us-ascii?Q?uzJW9t21afH+SlYHjOoj4MuMVI6aislCLwqhbn9EU/gWbpA1FxR6tO0QfVa6?=
 =?us-ascii?Q?xe78VlWQBCLdn/DJ1FioavLZS3LvS7lLEHlMsSIVljB/6vImHfyornf5Vsqc?=
 =?us-ascii?Q?K84sWvuiensCCaKu4Sip70n67mUEnWZaziFGh1cIgF8KIg23Q+V7zw/yrqu1?=
 =?us-ascii?Q?tP5K9k2fw3cJPKbZzK31JgpDx58tah9eWQ5TEsLr7hzH4RAMdPxWOY0UVmaY?=
 =?us-ascii?Q?lmsuiJKKfT2g6vNQpk8konebpD3GKGkY6QJ43Tc/0ggV9n1trhguLpqdmVfD?=
 =?us-ascii?Q?SPsGJM0FHn0VWWp84p85OL6i1C9OR03kD6h3oAGfIvM0ki7TvGWtobwmzs3P?=
 =?us-ascii?Q?JBinys/NYEwChQYtDqApH+qpxNzZN1NqU39doFuW6Wbl/OU2+H866Rdud+ex?=
 =?us-ascii?Q?PiJ5X6n88ZK1vR3nGYaHNXTcUgQODoq7LXd+k26jj5JhRepuQrAEg2WqpKEk?=
 =?us-ascii?Q?x52k+4vc0V5k6Oc6KULYabKSUlJpRBla+egNZ6NDTO3iqQnuLlHM0G8ns8Op?=
 =?us-ascii?Q?5U/FUbjwOQnMR2h50X9daE8P8fsn8HSo84zoyglfnZNXP1y/tJIu1wyLPC7P?=
 =?us-ascii?Q?gA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	r9rKGL8fZcQVVy1kdzYOtLOahmwfyAebA/ccWB28Pn/hSfOsPqBrjrDqvXzMW7T4FwDJIjT/YeTT6Z45DLzlUQ5a9YwqYqg0KN2SCvVWRX7pT76QXiXvnIBVTjzk3VzZ6P8DvTEnIr7oaW2XX/FA85pT+F99f6asMe0t+YWR0sMNj3lhIYOC4wOdLIwkihL9JQQ2BXO4v57skyzM07payUFd31grhBtRoggbEvnGy87NswEiHW0jcvinhDBrvCbfhuvQpfIZiJnWmw7mQtVeNMhFb/rt00Q0oDSTSv299mkgMeOIsDIjjmC5BvfQ/t2PBUKGH5uX7vWmtiqnVeUZoYNhHoDAJ1l28foNM9xgGgCEtjmFu6RBuJRC7DqDhpL9XLemWKuBH8cxCXagVR6kkLTy9a3cZs782XLjakA2wxVvzAMee8A4GhIaRBciQphcRvrXBOmdaZtJpbPZS4UDMSauEiznHHMR9YDynX7SaKm4HZhtpEUpmiLw6F4ElOXMnEs2hsGrigaRW13AS46L34wSkl9gXtTPMDKS6fHbxyvmWVrctKBdBYEu0tx4YhKV9qQRlZmMBv3RyK0Y0sOXdJJai7UimC2WQR4AFYtENbs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60aea020-5fe6-440d-413d-08dcc5c1af36
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 11:24:43.9713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6KbYwmahKaWbAtgJ7tLZ6MugNEjAo+LepG1Ph3b2We0oTgTGAxaKeV5zekZMdNQUttvK6ephauREesmlLQvJOgYlnoUViXidFBLh4MT/6S8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6531
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-26_08,2024-08-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408260089
X-Proofpoint-ORIG-GUID: eIXyly8ajsDQH-vocr2a2AaLzB3NCE_S
X-Proofpoint-GUID: eIXyly8ajsDQH-vocr2a2AaLzB3NCE_S

On Mon, Aug 26, 2024 at 01:02:15PM GMT, Lukas Bulwahn wrote:
> From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
>
> Commit 0f3b602e1bad ("tools: separate out shared radix-tree components")
> moves files from radix-tree/linux to shared/linux in the
> ./tools/testing/ directory, but misses to adjust a file entry in MAPLE
> TREE. Hence, ./scripts/get_maintainer.pl --self-test=patterns complains
> about a broken reference.
>

Sorry about that!

> Adjust the file entry in MAPLE TREE.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Acked-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6aa85a43d8c1..2af37835c735 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13572,8 +13572,8 @@ F:	include/linux/maple_tree.h
>  F:	include/trace/events/maple_tree.h
>  F:	lib/maple_tree.c
>  F:	lib/test_maple_tree.c
> -F:	tools/testing/radix-tree/linux/maple_tree.h
>  F:	tools/testing/radix-tree/maple.c
> +F:	tools/testing/shared/linux/maple_tree.h
>
>  MARDUK (CREATOR CI40) DEVICE TREE SUPPORT
>  M:	Rahul Bedarkar <rahulbedarkar89@gmail.com>
> --
> 2.45.2
>

