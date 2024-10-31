Return-Path: <linux-kernel+bounces-390975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5466C9B80C3
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 18:02:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 753381C21598
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 17:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772BC1A76D1;
	Thu, 31 Oct 2024 17:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ddmboRI1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VmubW/n9"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B20A26AD0
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 17:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730394129; cv=fail; b=TTHItJSo5DDKNzXuvI2xAPFMtpK7vTutYq9hg97DzcLirNrnF75ZJ95zaJ6CVOvIrvLx6CUVnz5bhqYOTzSpYjf1mQUJVAbb+nqdoLqrMJTdQJcHcZWGTlEnRfvj6d5bmvNW0ktovxQQNUNONPwpNGAFAHJ1iTx6ajt3LZy1EMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730394129; c=relaxed/simple;
	bh=TCmtThx9T7nvSVPaGTL7vn/1XVqMogcaebaBDXMS0QY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=jOXvi/L9hyjEdYyDEUo47LzdC/Nfyo5Y+UCrsrTZ2Si4eLHdz7FL5Rj/BBCzZf837rnpEv662Ojx+fGTbVdNAFnh7cZMOPHnsEPfww2NNyuUelpllrvg9mIbBDEENF4AddCqkwh5/DVK7CTMPo0zgUkU1ktrG9qj1KUXXKLMvLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ddmboRI1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VmubW/n9; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49VGwTMO021893;
	Thu, 31 Oct 2024 17:01:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=gPE0z606kxurXbta
	Y3gV7/VY+Q2UzlV7FHgKR9bZnsY=; b=ddmboRI1WeFmQoe5v8Uvn4DTQ4mSwYx7
	UxfceoqbEyDP8v8J0prHrRkpMc4m8j7dPA4F6HLwSbWUKFdD8JFR5bilo1tcfWMD
	xMUJIr3VU5Qd8BDdR27dFf0vLllLjKGMY9k7RB7tZPaCTXzwTDLekrF7wsWZ6rMI
	/h7aWOUNozDf5xdba1ZMma1XItCHY66ZQD9g5qjjqM+P0cLfPeGD6OCjSKXc/pcm
	16I0XBNmifszaiLGCcz6ehPINbwQMGRI8OLtCzbROInd8hvnHNlFJO6QciVL01Pr
	4mvIBl2bx3y7Wl+7adK4FH8te1YN5FH7zDa8QUx9uHgJwB8TSjh90Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grc22p9j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 31 Oct 2024 17:01:54 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49VGt8Hc004798;
	Thu, 31 Oct 2024 17:01:53 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42jb2x6bc7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 31 Oct 2024 17:01:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dpT6LW8vUdivD5aS0X1I/LEHvpPJEmwnbpplNcMpPgJUBTWDouti8BHBuYKFE6PnQR6nibdY35xiM2u6n/imp0IigflQAY8uhSObwZgFxHJTKaNIP0n0Zh71UK7F7odLwtl8fEKPvnisGE9DQFzZUBKkkOBXEOJc9WQ98A9RHbfeLrQK16IKXZDU6NDmg7ilvzYYOLYlOQ5u3k0MXH/RFGVC5bwFTyys3cXIHubO0k7gOZT4tXKASwG9h1DxrhxtnPMuBKaDnRxnOC3axhohxnOhBWz83rkDOie0yZi3CgsSmts7WdQvZ5VjE5+INzdMYLI4kdzjYPf0ECsjsESY2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gPE0z606kxurXbtaY3gV7/VY+Q2UzlV7FHgKR9bZnsY=;
 b=kpF7x7T5tXdCVoSPWoOtb5dIpFjmXE2e6h1GTEYmgmTEN/+JbMQo3wq4Vk/vC5Xkwp1eWr1OYdcDhlpRfu+5fiqPHERIZ1x5FqEpR8Y67Raqc0HeUspCI1bDqyLCGZoyGDAT4ZEQIxR5iOOCHPJn3z5K4u7TJpiLpNfLAFqEdFQr8PKWOcNgMCF+ACQLtyiSwLDD1ighhucbL5GJRFxMDTzc/SZVztcEoSKGCn2QIFnfRpDta06RIL16J69O3vgdHL7Gz0wZjiz/83EDdihIOdBeS7jLBloHoOe5/2vI3QHVu4/Db6rbwvbYs5X5JFsa27agWTWoTxW4LAQiWniBaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gPE0z606kxurXbtaY3gV7/VY+Q2UzlV7FHgKR9bZnsY=;
 b=VmubW/n9xe+CYxMLf89o51DJzDb3Bc8Q+k4f9lvtZv/akGsz1cqRoMjS5GQX5p7yV3hYG3DLl+inzns5G53ttpKfbYAPATkZVgzDgLPzhQg5+E9YVqM8Ohk3bRRdNEwzmQiI3XEm7eD/88uVVdIr5agB+b6Ff+tsjV0lInM8Xrw=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by SA3PR10MB7096.namprd10.prod.outlook.com (2603:10b6:806:306::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Thu, 31 Oct
 2024 17:01:51 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.8093.027; Thu, 31 Oct 2024
 17:01:50 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>
Subject: [PATCH] vma: Detect infinite loop in vma tree
Date: Thu, 31 Oct 2024 13:01:37 -0400
Message-ID: <20241031170138.1935115-1-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0044.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::29) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|SA3PR10MB7096:EE_
X-MS-Office365-Filtering-Correlation-Id: a0e9cfcc-cdf5-438b-9b2d-08dcf9cdb69c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Azwm+iFCJBqYy6U3CAOZrz2hCJZmdI6bCEzlqCW/4ajc4Q+bzhT5Ng0jiHiQ?=
 =?us-ascii?Q?nn1QOskVoTg+7fVdWDDbHrBMNo41xLNzI1WEMH40PRxQJivZcroIJdaJciem?=
 =?us-ascii?Q?sm64btPtMMFUmWAQXaHFLWGJeBqBMwdowFw+h3mb5Sg4evOQbAmzvwCZYzFe?=
 =?us-ascii?Q?wP3VHPpa3mNyb6JPjFvOquMHfn15D3dtCN7cz0SSTmFR1fKjTuBe/FitIB70?=
 =?us-ascii?Q?pVt8ViMH2BYyDGwhMrrj2lIBsDoF++VjQkLj2eVhhRG+u/8txZnJmBRbNWBz?=
 =?us-ascii?Q?ZhsAQ/YePZtAgyKNvqXav611/+DC5AJnT6NKz6ppsi8edc0aWH8/UtA1OfBH?=
 =?us-ascii?Q?iPeR5bJpkUwaDSM3vjcHJjAn2zxrRzTar6cDwPCbVMaK4MiymvUyYqqz3uV4?=
 =?us-ascii?Q?ReepcmfNj5HYWusJiLmrAT0gAcCzjhRi59X3f1VIY++n7uTymK7x6KQODrNk?=
 =?us-ascii?Q?+nozcLijEF8dCOIxzyqIGMFMEX8hpDgC6naH94QYtwjbXyRfBmJW9pZUGJ3f?=
 =?us-ascii?Q?XGdfAA94POMM+oKfSHJ+sxWsalSsdIhzaOMUSSKU8vLJQEPI9qGHw4WizNqE?=
 =?us-ascii?Q?GzuVzv5xnEtsPnlWLbyWeJlCSSztIVLAqr+OYpDAxFSetJy8D2RRZw9QB1/r?=
 =?us-ascii?Q?TD1qpY80E0QheFN4QatJJuS6cnzOmk2OQn0ACJSmrlr6rj2O+quJAUG4X3j2?=
 =?us-ascii?Q?zmEarWF/MbKgAd5wEt0yUp/Pvk/t3VEnDGRIuxKn3S/gXbD8lp+FGEdKycab?=
 =?us-ascii?Q?wQFH+1vfY60YcPmKDM9As4Ag/qDw+2gZCFArH0dTV1BIwvj236Q740IGfp8N?=
 =?us-ascii?Q?Nynio/jyo3+rlfYcmzZ3JnspeWzGphbYKi7gLlRo/0tYvSIVGYVKN8V5+5VR?=
 =?us-ascii?Q?pysdUDJdIrKEs9S1MJkr028Vt/LHVip8NeLrRBc7U6lIkeMIAxMPdxCo8qOv?=
 =?us-ascii?Q?BL18Di+3enJsbEK/A7eevSjSKhjYDRGL4HWf+1yMaOrflqjBHMm9a1Twk15M?=
 =?us-ascii?Q?x/jocV6ahKjjqdmMFxbZxj6J29ulR0dfUEPiwVwourZs76/xHI0p+6gD0bZB?=
 =?us-ascii?Q?MczBDgm1CmkKKtl3wLom1xwdR1+si6gCanetIGQ1iOKyzoJahuo3ZYMqrD6c?=
 =?us-ascii?Q?SPxNnp2u6Pj+Ifq0yQ/qAryHDDZ1qeB5318433JvheRtOlPP7F2gjNMLMMbq?=
 =?us-ascii?Q?q+6qr6GsAKRCo4xOAW1B6CtGC3xg8jZzLeNTGBnd2CBAsFYaQzLDyVYSsUJ9?=
 =?us-ascii?Q?H80KQDcpF7ZMdDaMZzPtmsMuwPMG/VLMInbhV103avm0s6+hSh8y3xhMoXaR?=
 =?us-ascii?Q?KPjro8sXisqxC7O3Rno/ZWIZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eT3zxhSkW5OSV6jDWB3eg7/AsHrWB1/7QNZGVRYXS/5z7XKAkMoGmJqvJ9A8?=
 =?us-ascii?Q?F93x39DbDLQi3KqljIYaB3nfc24Zi9AYs/1AUpImPDk0JTUfexYLTsiBeGcY?=
 =?us-ascii?Q?NawazAHQbEodrRClPO2ysPn7vRmfffojYVvnPFygE2bbcc9em+zhvTS12tQN?=
 =?us-ascii?Q?blpYCtI1Y+y7VnElIswzmLvWf54v9Dql1Q3Nw3kJgiluZb1p1BitI6H46+gf?=
 =?us-ascii?Q?E2CtvpN8g5HhfOg4fJOGyVgZveet7cQAhzeiXLQyWXBQYUkdsvwHJzfnv3SA?=
 =?us-ascii?Q?XeQPU8YS2UcguqlkGugzTbPuAuTG4o/8T8ykZLlc9rhGQxDikq8Chrgec+1B?=
 =?us-ascii?Q?FkC0TN0J24ck60lvWTjQc0nUbOvuco2ZxDjVtFlF6mAkd07uCmWxIihFj5jy?=
 =?us-ascii?Q?lDoOZZLwsSFfBoXgMKzWz52ck0rF3EpSjg1HAT0Ips4ogq0h0OOmrhLCWJYw?=
 =?us-ascii?Q?5IRBVr+0GefGY2urz5DHjAraav7whn6rz0INvpl66fOnnM9vUxzM7sivvL/u?=
 =?us-ascii?Q?ie4HardulVBZvO33u4iRVpEOnwWwEDA1I6queH4mbdzKjSvZfu9b6FkWdxhA?=
 =?us-ascii?Q?CN7eNHxc25iCADkaVo+nerMCAh/9nWShWwBKmzJ6cQFmsHZBdJUs38q1PGIV?=
 =?us-ascii?Q?xzePCyIWgoUtNtTEDvC7JU+D5WRKYBdYvHWidSeRMF8YSiwBLumKPJ88q1Xs?=
 =?us-ascii?Q?FtHxeUvhBHL8i/fqBq0iMIFkNo8mVPAyRuiZsctZdM8hFKZNM9ZDWlI3oQS4?=
 =?us-ascii?Q?uuznCq5Y7hO7MUpJ5Wab6EidFUwkzy2LldYDSIWoNXdneOXzqa8DGiFzZiVT?=
 =?us-ascii?Q?CN9rsVN0k8AbIDzyV0oZrf+RG2m/0OoSfHJvePBBR7chGvscwCjRBRkkF06g?=
 =?us-ascii?Q?+6L3d6wYYOoVq/YpT633WSkbcJGmDmPJVqpTizeddeHVB41jK+VOVpxb4H+Y?=
 =?us-ascii?Q?qTrvCUo4kJifdw8Q2OSLtpc3JE5iJXWPryllq0K9j6NZKi24+O/ISWqYxcLa?=
 =?us-ascii?Q?6tJyCDgFW51LNTQ2JfPUX/8Tu6RS/lGhqS5J0yBAiRMIEjoh/ID2+2XYH9SH?=
 =?us-ascii?Q?H9X1zYWht0Itii9/9L/Yg2WnwAla6UULLTOPt4thj7lEX9il8OhFgtyH3NC5?=
 =?us-ascii?Q?EWJ7hrHmoEQNZxCvtOIDr8s03gz2RpGynzzEIJyNdItDcxvn166RpZJZT1DL?=
 =?us-ascii?Q?pH7/4m0oavVGFDfbLukS+6gDv7HK1qT/CL4RtK2/CmRdMxzfpgEHK/Vx8sP8?=
 =?us-ascii?Q?PSz+riuRCHvhpiuazHoa2sLFy7cxRgbe+IZDtuUprpzDZYYzi0mUmGoLKI2P?=
 =?us-ascii?Q?7ppi8Q5Yf3eZ5hzYfcqN80mP679TA7Wm7ouZWT467vzKSFoBktS5x2onH0i9?=
 =?us-ascii?Q?Ek7+P5W6zXbL7NMAJ3WKhh1IK2uiB2ieBXLuXgK/FRmoEY9IITdiEfpJw7d5?=
 =?us-ascii?Q?6i3AYMYf25uzisT8mIQErHD0eINRauMwvlB35HLWqirnD1pyOAzkWE9ybS+u?=
 =?us-ascii?Q?bizSzZ6HCvS6XHMX7pTbihP3n9x/MPEAMg0z61SMY7JSgukDCLbXeG7ASUEg?=
 =?us-ascii?Q?MnaiqLtoQ8yL354SDfykiGSSLyjwQkPzzIYEZght?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UDNmbUrrVhHIBRCQb/JtUeb8lnfL3TCTPix+tuTmoQEkNE8o27f7Sjtxr7OJD9RmcTSEf33YRNJxOnbIsZqm+wtFB8lnVEheUx5ZhmOgipqLB+c1Zd2FMsvCGgi729svoXybPg7Iq4UThxwn8BIhIueHSaAVD3k3YW31dNxgMLMxCKj9VFNwb3ILLZ8KrLnj1cQBuJPbdyc2syRIzM+Xy4qaGxbWv7oz8F4nep8o5S8DATyXNZpVaQWBfgoRIoR+fEGLPuy4QpRozWlOvsT+LaK0CFnYTbAjISr8VIbvvDRJ7dnl26mqZQ9oFOY0+9R19QJFiIwCIFxW74XeUH2FPtWuWWF86UOiE7j1Qmz61WC5BqdpBEpYYzVewwYTwq9+f/n4lrFPLOlUCic0ZDmevZhIP4k334teaVk3uKBsXi4xqq5d3YnHGZFEBioPArkOp0rW+9gF6TA+UyBMrawb/NfGuIKG1u1gZ5KecDX+LfVIoHAFOwj27BPqqY4hL6YHZf4mnOjfqgsKWdNIiM2msy/oU2aW8rFgxf7D48wEYCxowAnrqPZkh7a4nFUJql8gC+K5kiMU59a8unDZUGj+EcpU7x3Oc2ZOmckLZJjt0LA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0e9cfcc-cdf5-438b-9b2d-08dcf9cdb69c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 17:01:50.9177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YyWYqvCoLazhWTJ63+Xa+U4ckDWkwbQ1jwAkuQETPECsLID2GQZNPOVSn0IcvgwbrckptLac4meF/Rqz1aPZ0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB7096
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-31_08,2024-10-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 phishscore=0 malwarescore=0 mlxlogscore=802 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410310128
X-Proofpoint-GUID: d6J34eMugjpJAWHQrmztDTu8rxf984Pp
X-Proofpoint-ORIG-GUID: d6J34eMugjpJAWHQrmztDTu8rxf984Pp

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

There have been no reported infinite loops in the tree, but checking the
detection of an infinite loop during validation is simple enough.  Add
the detection to the validate_mm() function so that error reports are
clear and don't just report stalls.

This does not protect against internal maple tree issues, but it does
detect too many vmas being returned from the tree.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Jann Horn <jannh@google.com>
---
 mm/vma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/vma.c b/mm/vma.c
index 68138e8c153e..60ed8cc187ad 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -615,7 +615,8 @@ void validate_mm(struct mm_struct *mm)
 			anon_vma_unlock_read(anon_vma);
 		}
 #endif
-		i++;
+		if (++i > mm->map_count)
+			break;
 	}
 	if (i != mm->map_count) {
 		pr_emerg("map_count %d vma iterator %d\n", mm->map_count, i);
-- 
2.43.0


