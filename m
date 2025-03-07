Return-Path: <linux-kernel+bounces-551132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86CC1A5688C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 14:12:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2680178A60
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 13:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6342B219A72;
	Fri,  7 Mar 2025 13:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UZ4CoBjk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dvIbgVoS"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AFC2185B4
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 13:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741353150; cv=fail; b=U6eJDVbc8+B2HpzyiWqb0jks9oPQUi+vjH1FECc9AbfpTlH9FAw6eGWLaVuRs/1tLkgJ1i6TtDtOisgY3l6vVa7lv1kakfeDbd5ec5wX2JyXSOhdGHadASM9VGyShQQoS8o+Jx1X/M1mFAvbmk5x2t1S5xpDJb7+carG2iQxxxs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741353150; c=relaxed/simple;
	bh=jxq2ft8rKy9uYUZhX7UR4NLRdpzyHKojkWiGOfEepYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GbSUwTIYv3Lj387+DNhyLsR2tMrO+l9/l30//fVkEUa2H3BKlXeI8Zo/l/YXbDwilj+75sloOXdwY6RgsN6tbMGs6Yh/Tcbqz3MNZQj8aE++iK+8VzU4h+Rlm588G/+o9JdoX7YCoEP0pYPnEHKNB+spl1gtENBc2U5pemHwu3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UZ4CoBjk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dvIbgVoS; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5271uMTV002399;
	Fri, 7 Mar 2025 13:12:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=uW/xoVCIBJqS1hMeyh
	IaxWPCgZniHhM4jkD1DPgqpBw=; b=UZ4CoBjkeFcBUrHBdIfvgywWs6edKK3hEN
	rPzRU5HxcwLRVecRjzIP6466NPzxSYyL/dZWy/nVdGCEyHnYEtOcrvXou8/MjNHg
	aH67/QJ1dexVAD0cty/YE7lKEaVQQ2tkoKZBZ2Gp+DLqNO6UneKypc0p8aFKUI0X
	DbYXOxt+tKSPnQ9VsoMG841UwqoMHB8ukRBnesD0MCopLUPWkPR4qiY9Z4tNDKcB
	kF54VOef7kZRRFO8gTmu0fv3JnJT/zK5Y8TgIpfpzw/6IxaKEhjO2mD4QU1hdjff
	GqpEHzjVsiAgMC47EARy+tfyRuY0/41FKcSvfDoP8i203SBvzkHQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u824845-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Mar 2025 13:12:15 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 527BrBS4010929;
	Fri, 7 Mar 2025 13:12:14 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 453rpf4dp7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Mar 2025 13:12:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E8TK/neZrz2TXrSfPcHLZ2nKMaknXhtmiai9gCZWdPGljjXjLSUQFKIjh4MJZP1K9FeE4fJyIF2tZm2DIgnfOoOdI6EltuQZYABnC0vzG1hQ9lArge16Qw+lHqfGM6wlpVBSitadiqYcUlV+ODomY3TAPJyXmMp7SnfNYyzYPdukOamAt7Wy7Ce4OpOu+EJZqEdXQlwM5ah8pjphwctZ/pPIZMnPATiACyORxE40p70afzLcL+scpbgRwWv7DTUP7rxVBDdG1HzvtR/lE36+lKxTUEZw1F9Fm9wO9M52A+OD/r/sKlY5A11OqGcLZ8jgISBuCeKwuTZkUAeJVPraCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uW/xoVCIBJqS1hMeyhIaxWPCgZniHhM4jkD1DPgqpBw=;
 b=Dej3AJ36mJ5NddKEpuatj5D6AEswBNYtCTpzHSyFodYeTYDrrXEPWjBrv/5myGv4G01n/Zs59E0of4/AsBOhJg7qABuenfZw3/bAbsJzUDlljPaI0V1T70UDzieJuMD38/F4d8ht+Pho9pea8txvpc71ATK9Yp8sgsiid5IAppw6WhnNZdhMzLo8i1Ns+mwUIcL2tevVK//Z8hkky/9nJ/21kTpCCuoK8Q6hSbCiseIE3N6aWlR/4L1GVuSfb3vKjLKRifjZ8f1lI37JGLO7HVMFIx53cjO2S896PdgQx/iTDjnkQWwCbQNmTw5vZWnrY3JRTYQ4Ck4Rw4eZPzy/sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uW/xoVCIBJqS1hMeyhIaxWPCgZniHhM4jkD1DPgqpBw=;
 b=dvIbgVoS/sBL73GIrg+dvvkDLl9ErFf42Ecq49z2QpxOOC3ZQeRfzmnTfFUGoHoGmyvw6RuUTuKgBlQ+9PJF8igxAZasdXHOIY1kwJL4J+EKCvM7vCUq/lnlnL8hies70+rHQYy9Q7SnyEwBbJdksNB2JvDYbemxp8K0YyESCTE=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by PH7PR10MB6553.namprd10.prod.outlook.com (2603:10b6:510:204::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Fri, 7 Mar
 2025 13:12:11 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.025; Fri, 7 Mar 2025
 13:12:10 +0000
Date: Fri, 7 Mar 2025 13:12:08 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Yang Shi <yang@os.amperecomputing.com>
Cc: Liam.Howlett@oracle.com, vbabka@suse.cz, jannh@google.com,
        oliver.sang@intel.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: vma: skip anonymous vma when inserting vma to file
 rmap tree
Message-ID: <6f3cece7-4dc6-471c-978c-efcf4bbe64ce@lucifer.local>
References: <20250306214948.2939043-1-yang@os.amperecomputing.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306214948.2939043-1-yang@os.amperecomputing.com>
X-ClientProxiedBy: LO6P123CA0055.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:310::12) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|PH7PR10MB6553:EE_
X-MS-Office365-Filtering-Correlation-Id: 866aa339-28fd-447b-f411-08dd5d79ab82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ppaqrA8IMItoBXDOpZqf5cWTHOR05En4dEB4qhiFCRdbHcCdFsBc9414XAj9?=
 =?us-ascii?Q?r4SJH2aoJkcreeF6beHAI9u8BAx7GYOCccB7jRx/kSzcs93TEH8cbfVq29OZ?=
 =?us-ascii?Q?GaBmpD2qwucMR7ExvHdd8JI5Biw4W6TDZt6M2wtVhXaeN2Rbtl9KZ5mlc6t/?=
 =?us-ascii?Q?7baYn2CIA0AlKiOzKqBH/7DC43UknxnQLiYEBXqZMDvP9HDPqTH8JJ66v/rI?=
 =?us-ascii?Q?rR85izmB8jfNFT/iePus/dnWgtVLtnJndi2JK5fnlCn2Oiku+PMU88N2kjd+?=
 =?us-ascii?Q?Lr5OA30MjxgnKewHYLFAjq+x2l+8QWSCfO9L+XEgyfNN6AOV/2UBi1lfLWIP?=
 =?us-ascii?Q?EWpKxKOonRoNDZ7KeBWQZ7fdTeeLdJ45rW4qb/kOUr10QqDgavwj3Bdwt74B?=
 =?us-ascii?Q?0g4j3X2L6YM7L99QB9TKYeROAd6Yp18a9TtUs3DPBvpkfMu15tw4HPVhWNx9?=
 =?us-ascii?Q?gSOCM23Vc9ZdxFkYw4368YO1G93Elp/OQbwgeNkf1Jy20Jwvs/wilbW7ei8h?=
 =?us-ascii?Q?8oy85EAiSQgEJgPUKUSewnPBDqD78mVdLG96WGBiVIGIBD1OoAiRqcvqMM/e?=
 =?us-ascii?Q?NTb/FDTyah+qzFFR2lU0sqW1oNrQu3WZv/hvfF7FNXjnFGIxMdXvNNnx78Hi?=
 =?us-ascii?Q?IgD7yT5Wf1svdYEsAm47tgFKunBSbng8iRw3KsSqAOyTBtEziRbZWuLt+8WZ?=
 =?us-ascii?Q?dihGW86NWbsFl2pAIKumkuxHppGiIstz7PSnG0oPo+G3f/5yyBx8stepyuC/?=
 =?us-ascii?Q?Va2LSULxwSyFrTVCkmAgWGSbWLPXv22GKZrGA7q5zQqQl/5YnwH0Gs7zX1kr?=
 =?us-ascii?Q?abOP3NkWAYI8cQFtnXsVPSC/BWZUOPJgegv6o4nCIlY6nikeMMxE7sUKZD3M?=
 =?us-ascii?Q?0Ei86lARO2BmGoGBJbSxR3DVnjl32buf6aZmmx+7FqjTdhCXLB5JF3Bc+9QP?=
 =?us-ascii?Q?LtvLFsV/3h+30TIz4Dtam7lqu0+5YFVKYDVQCtQ15IQgoCZnObGezDb3OUvY?=
 =?us-ascii?Q?OjZ1Bu6czug1MccrP9kF+V0fTk2BvbFP6y9kR3nyIAPUn4v9njDJIZM1IrER?=
 =?us-ascii?Q?/pGlXUqWLSzzVItwpkKyWCOrU01Q+qXHGOatUm4EfwNrZbe0KrfAYQuhaWBl?=
 =?us-ascii?Q?jgGct2zmigav/FofUOMPuIxopfQ26Az8L722jB7GXNdWcqqVfYRZ2+thPDQY?=
 =?us-ascii?Q?12HExyFF12ZKqwGi/tjqZnivTlSWNsIsCgQ2GuvLRyzteTBbcvCBpEav3qB9?=
 =?us-ascii?Q?aUIIF0zqOc+3cmQkgh5OutyCGpF575ZUAbLjaakPdVSwrGTTPZ+DW/9msOOv?=
 =?us-ascii?Q?IGsEMDg4O4FmW+QzueShJxw1hHNjYhaeJR0FQ2FGr3RxAhjvHuD7ZWEckBKB?=
 =?us-ascii?Q?E8qWYluM75QyxmBPhA/cq690nFh+uKJD5/abFOF4G3ITPsy2rw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xxLRKO1JWS9RSa6W/6te/Ie06yq3QLlAWg3AavVR7kxbZP5kZ7/az25lqglL?=
 =?us-ascii?Q?SVRiiJImUrqeB3+N9yne+mN7xzzcCMujtnkX2B0kSgIY5Z9muwXsEWLZ6lEO?=
 =?us-ascii?Q?79VaRE9jZ74IabxLVvr3ILV7fpokDI8GKtQMUNu0NKMIIdXQOx9qJkj45X8W?=
 =?us-ascii?Q?251TENdJG1QqcwOYgCv4hJ8iR8XMUiWiS9ctThXjnHHDVMv85PLqIY9HNFbo?=
 =?us-ascii?Q?dR+DfhAVGvrjMtPWy4apiLfk+PD9vIkOrVktiBFuNVryw5tB+T5LSZDifbrr?=
 =?us-ascii?Q?3zNMQ0/5DsdDc6mgrB/zj0H2Pol73KH+F+C5UCVp2DNsLtQjrqVpBypq45Gs?=
 =?us-ascii?Q?xiB0F1egEMKsREo6mAvfg7DT2eQjgbR16ZQfqCSSIojyk/mvsgZirLJu1Eu5?=
 =?us-ascii?Q?BMibbnzV7UpzOdfZBZd1AnVbIX2+K3zUkcTOSyDI8dPsVkTUZ0BVI6R80lnR?=
 =?us-ascii?Q?Uv6Uto2jhwfH6PeNJGTZQAOH5szeczCvduVBubVzbzdqY4RKzNkdT5IH7TJc?=
 =?us-ascii?Q?cbr3tXS2R31I8hxKDaGJUJ1jen3snHjfYr+B9pI4k0Upx3M50H8mPY9629n5?=
 =?us-ascii?Q?vcfGHj7eJX44KUi1UfEFxXBgqhcH3wrjq6LWEvv2Hn03V7hWiUp0NPRxK9LQ?=
 =?us-ascii?Q?3HRY4bVeaHjPMatisSURyLa/KW+aq94xsDZ+2qGAQFjq5XfZ2jWLrCsmPE31?=
 =?us-ascii?Q?l5MeE3qWban6Le7Awlb1dg9szQ/Yyu8jZDX59WCzdFmYBOnFf+8yuwlqCJDH?=
 =?us-ascii?Q?SQEJvD5pcvLTIQG2zAgTBvQ35Qr5l9tgA2OGYpXwFvFfwAQcn9a9IchgcwY/?=
 =?us-ascii?Q?aYEas3ho26Ng8FLQr0DVcbzc6IjxsMOyBbguE/QGj8QDG1CSRyEe9KRibeMI?=
 =?us-ascii?Q?TCPFjVW8fggX+yu1f8XtHkwoJf76PDBP/5AMpv/56TogLom1KTcERsKM4heI?=
 =?us-ascii?Q?pBgLYguzAlKXkWPIRcZ2YH0PNymPn3sppXXEhwEgXsvAZd3kCOcn+XysYcw2?=
 =?us-ascii?Q?UXZLp/Ptpy18KGuAm1XHKbulVY5FH+UDnuxMBW5nUVZGZ8+2IYz9BMmvrHYd?=
 =?us-ascii?Q?E58gbgWIkAdnL2OLcSLbTde6N045a07Doq4gxJ0ixVLAPTYMGfaF9ugldWyn?=
 =?us-ascii?Q?T12V8ILdv/fLJzr7ERVOHhBRoaalp8eTVdozYqPYgcLyAiwYh0tbWWzYuNJp?=
 =?us-ascii?Q?oxI+f3n1/ts38GupsZz5XjXDb29dffYRpneJn62CdM8XBjXz2MuKIKjpWvFK?=
 =?us-ascii?Q?UMKNQBGTq7MYC9g2P/rPgaeKky2a8SpiASgHBK+tflMhC+YN7WZaV6wjdpAJ?=
 =?us-ascii?Q?HYteM+Zf2AJdKNqvh5x6C3DfU4K1gxfhsC2DJSVNL8X+eGDRPoxjk9mWU1TN?=
 =?us-ascii?Q?t29YXQVNn/SmxqWHVjsBRH+lqDsTNjxg2ue3/6xa+u64p5OJhIj899cLyRqT?=
 =?us-ascii?Q?aGIFRRLjNhyPZkSNWmXN4IqSkBE1yy3RBqHu0jqvt2XYLnGRCUASG005SGD6?=
 =?us-ascii?Q?ba4br/E6JKXjruWEtDix1xS+W9F3Bs53ciXI3sTlt+FfBS39rdpkKiftxc6z?=
 =?us-ascii?Q?Grl3vyDvMqsZHukY6z9ctEAYUJ/2kCyAuPh1ualjXqiLWs0O3Js3DTYVV4FK?=
 =?us-ascii?Q?Uw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Fm7wy7AFiax9hRkl7lNHeAG0PVfVQCmfolozpvtcV3S46vRCSw/hqxlPOqAcYu2l7nrhe2dilujLWo9JpMlSeQxzZAwKSQYJEHohy+fljD4GmBmjLdExsKrhyp6Gt4Abf0vT/2S81+y5aEcU5dEhywCYoI7qI2slLwn0i+aIm9JxYKYko6FXjv3WEyE1Ad+bTD3ByirI45Ng/JP2auddxt+PbDzAygyjjbKv/p35Ylfh7knGzXMTO74l1tNCHUHMJYfmYjJAxc+RsPykghzopqq+hufxXj6zFp4/SN0hQAeDjesVOcc7c3lWMNjbw+IveOyGNiSRc1dhZ9iAoeVY3f1dVD8X7ZoFj9Ws6ozboHIHha86o8hx0V4vM5Ep6P5XOJN5p2mv2hYBXPMe/YV5Mu1EBcjm9diXbaeIO8iqqtEGhZCf5yLLvMSSgKthCxLQjS9TYn2YJqNfL2sNNjIqOq+sCJkx+b6raNr027ujGLSQ+eBUD/92crr5YhEG/8N5CA3Qa6Zdyb0Zs0Vh74pXoKNU5Hbelljs41AH6Q/wb9SIxvDA9kxPfV64d1lJ22xO2DoTmFuLH1fwPbYZIGE0ajJ2kaJ+7yG3t+3DwMydbj0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 866aa339-28fd-447b-f411-08dd5d79ab82
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 13:12:10.8284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c06lYHeHNE6Zu+vzYVNjVpXXbfPnndi2qlQD2qIgwyxug6YdrXH7UC3NZkJ2Z11n9itvT/JRHLma9XpQJnrx8aMh3bBPihFaZZOFyiwPwV0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6553
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-07_05,2025-03-06_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0 mlxscore=0
 spamscore=0 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503070096
X-Proofpoint-GUID: 3C9eIEbjKcmFQJD78S3ZYgY6W-C_O9-I
X-Proofpoint-ORIG-GUID: 3C9eIEbjKcmFQJD78S3ZYgY6W-C_O9-I

On Thu, Mar 06, 2025 at 01:49:48PM -0800, Yang Shi wrote:
> LKP reported 800% performance improvement for small-allocs benchmark
> from vm-scalability [1] with patch ("/dev/zero: make private mapping
> full anonymous mapping") [2], but the patch was nack'ed since it changes
> the output of smaps somewhat.

Yeah sorry about that, but unfortunately something we really do have to
think about (among other things, the VMA edge cases are always the source
of weirdness...)

>
> The profiling shows one of the major sources of the performance
> improvement is the less contention to i_mmap_rwsem.

Great work tracking that down! Sorry I lost track of the other thread.

>
> The small-allocs benchmark creates a lot of 40K size memory maps by
> mmap'ing private /dev/zero then triggers page fault on the mappings.
> When creating private mapping for /dev/zero, the anonymous VMA is
> created, but it has valid vm_file.  Kernel basically assumes anonymous
> VMAs should have NULL vm_file, for example, mmap inserts VMA to the file
> rmap tree if vm_file is not NULL.  So the private /dev/zero mapping
> will be inserted to the file rmap tree, this resulted in the contention
> to i_mmap_rwsem.  But it is actually anonymous VMA, so it is pointless
> to insert it to file rmap tree.

Ughhhh god haha.

>
> Skip anonymous VMA for this case.  Over 400% performance improvement was
> reported [3].

That's insane. Amazing work.

>
> It is not on par with the 800% improvement from the original patch.  It is
> because page fault handler needs to access some members of struct file
> if vm_file is not NULL, for example, f_mode and f_mapping.  They are in
> the same cacheline with file refcount.  When mmap'ing a file the file
> refcount is inc'ed and dec'ed, this caused bad cache false sharing
> problem.  The further debug showed checking whether the VMA is anonymous
> or not can alleviate the problem.  But I'm not sure whether it is the
> best way to handle it, maybe we should consider shuffle the layout of
> struct file.

Interesting, I guess you'll take a look at this also?

>
> However it sounds rare that real life applications would create that
> many maps with mmap'ing private /dev/zero and share the same struct
> file, so the cache false sharing problem may be not that bad.  But

Right

> i_mmap_rwsem contention problem seems more real since all /dev/zero
> private mappings even from different applications share the same struct
> address_space so the same i_mmap_rwsem.

Yeah, lord above, that's crazy. Again, great work!

>
> [1] https://lore.kernel.org/linux-mm/202501281038.617c6b60-lkp@intel.com/
> [2] https://lore.kernel.org/linux-mm/20250113223033.4054534-1-yang@os.amperecomputing.com/
> [3] https://lore.kernel.org/linux-mm/Z6RshwXCWhAGoMOK@xsang-OptiPlex-9020/#t
>
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Signed-off-by: Yang Shi <yang@os.amperecomputing.com>

Thanks, this looks sensible, other than nits below, so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  mm/vma.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/mm/vma.c b/mm/vma.c
> index c7abef5177cc..f4cf85c32b7a 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -1648,6 +1648,9 @@ static void unlink_file_vma_batch_process(struct unlink_vma_file_batch *vb)
>  void unlink_file_vma_batch_add(struct unlink_vma_file_batch *vb,
>  			       struct vm_area_struct *vma)
>  {
> +	if (vma_is_anonymous(vma))
> +		return;
> +

This really needs a comment imo, something simple like:

/* Rare, but e.g. /dev/zero sets vma->vm_file on an anon VMA */

>  	if (vma->vm_file == NULL)
>  		return;
>
> @@ -1671,8 +1674,12 @@ void unlink_file_vma_batch_final(struct unlink_vma_file_batch *vb)
>   */
>  void unlink_file_vma(struct vm_area_struct *vma)
>  {
> -	struct file *file = vma->vm_file;
> +	struct file *file;
> +
> +	if (vma_is_anonymous(vma))
> +		return;

Same comment as above.

>
> +	file = vma->vm_file;
>  	if (file) {
>  		struct address_space *mapping = file->f_mapping;
>
> @@ -1684,9 +1691,13 @@ void unlink_file_vma(struct vm_area_struct *vma)
>
>  void vma_link_file(struct vm_area_struct *vma)
>  {
> -	struct file *file = vma->vm_file;
> +	struct file *file;
>  	struct address_space *mapping;
>
> +	if (vma_is_anonymous(vma))
> +		return;

Same comment as above.

> +
> +	file = vma->vm_file;
>  	if (file) {
>  		mapping = file->f_mapping;
>  		i_mmap_lock_write(mapping);
> --
> 2.47.0
>

