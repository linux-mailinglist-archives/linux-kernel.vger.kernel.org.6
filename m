Return-Path: <linux-kernel+bounces-353687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC24999312A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 17:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 977D5283909
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 15:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6814A1DA628;
	Mon,  7 Oct 2024 15:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XjMfyHtV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vjr1vMs/"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC891DA2FD
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 15:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728314939; cv=fail; b=o3CAg/Rvm/Ydy/jxm1FUXJiE06h/MWrEEpsEPoEoqqdKNq4bEqIYRP2C31vrOJ2r+Mvfmg15NwHmHGVDGDYPNwWwBX2DffqnNoNsdWhVb6luQjYfNgDMauRWo5igv0LCQkWmswGKkfWTTMJXOcQbKTZ1twn/Q7/+9JLO18xLfX8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728314939; c=relaxed/simple;
	bh=dQO71A03xjb9RmQZ41ffcGU9h+eyOa4UYmvpcwwO3GA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cWExHlubUybTZYKFkqFXQR9QHfh5SFHcTAnEDxZ92rR4kyOuYKuraYUsB4meu+neYLXwl3uEKFL+ccs7+JEgnHjG+rieeP/cHdkwQyffqEJ1pJjTY1VTSekASXvL754U92O0PUqxUCP6+35w91TQLRzvgtI9A/Ld+jlgGa1YBZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XjMfyHtV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vjr1vMs/; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 497FMeQU022959;
	Mon, 7 Oct 2024 15:28:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=rd7vhnBx68OHI7ZCyh6cut1kXuztgkGjhBexOUnTYcM=; b=
	XjMfyHtVFph7hPMlOVR7ROzYQQ9Th1eWHQwg6X8M31oCgsZBaG2ygRCSRAdyNRoe
	NYc2urMthjQ7qaXdDVLGe0ljaI+A6nwRFJm/Do3WoVcsQAh7WPELhmfuUpMnVS2W
	6L/xaiLaZiiJmYvjJGlcMAPXL0eQsYHu1uO76mVlV6nT+M8rPcJDPV7W7/WB/cKG
	cguiTxjYhGe6kxROUgrLqJ3Jc5qQrL9jgE6xvE0FrIsFwkOeAJdrUw6U926o1Wk9
	Slsp4bxewLpQ0lADxHC9KKFSIxbuyVfqD9gynV8g9bUH2HzqYmmQi+1o9Z210zTe
	JN2JNUD1U/USagyp+j+RkQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42303ybpf9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Oct 2024 15:28:44 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 497FBGBC024065;
	Mon, 7 Oct 2024 15:28:43 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 422uwc76vm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Oct 2024 15:28:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aLlRUhBpYcINZGwG57pKqUqSIqRqohm8rXwMs7xW2MPv34IXKhBsL3Lo4wiQwSLGH6IZNGuXNS3RqQnX5RHFIqw0TKD7G4640WwX6OAGE7LlI15+ArqpKr3Dj/m+epwGDkgXl3sJAF38ArjI+HGOL3c58iQKuheh7EGwfLOB4/eBNRRi9gtglK3CWD6u7ms56BWE3+BxdFrugoulKPeZdc4U7+MmaiL0DC4nVPSv2Na0sY44YMzLnl3dbJbSP03HO2UpKAPuPnt1zcEVQazG4oF1g1o0imkWKD3Idwf/3ucRbzRPxa3qW7BfR84zhkrvS4LQau8U0JA1qgoj0mGzqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rd7vhnBx68OHI7ZCyh6cut1kXuztgkGjhBexOUnTYcM=;
 b=E+6dxqry+YbnVato77+6X9bvxguCET3dxyk4ZwUVc8Xvs62x6UU8pHL5/VHqNQGtPMrrIWG9allkPZMKBbjlUkcnBroyfKO1JY3ygRf3M86mh9k10WI0oaiQGfrWgNj9Goa8PIUEN0dwAQRFJpcFrSEZkHcKT+48tu7y9FBBCYcxBelJ95sil1d6j3Vfp35iR1bqkLprO56CJVSAj2jE+MrOpLLg4Ag6V4KDmKhaqARZhNdK1/4ODLsHFgG9tnhTxwZwXqlJ/1r1edN+6SERkZbsceKS4LvMjnQ9kCc6GTVwIFrRFu8zaIsMO3AaWDKZEtcqSHaNU8B7kmXpM7LYbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rd7vhnBx68OHI7ZCyh6cut1kXuztgkGjhBexOUnTYcM=;
 b=vjr1vMs/mHSnUNcXiWPgsIKPKOE5+ypMxRAmp4X3CakyCvbNvXXVwJGcPrkicixhzHR2x9b3i2sZ2v6tLA2Hs+8dE62N93qSwUy3U9CSmSYbJr9iPz3y9B43PjUbtkoPDmWEN5jFPUOEZdKCts+v9L0Hrq66r0NxHaQ4dm5F3yg=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by SA1PR10MB6640.namprd10.prod.outlook.com (2603:10b6:806:2b6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Mon, 7 Oct
 2024 15:28:40 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 15:28:40 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Cc: Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Bert Karwatzki <spasswolf@web.de>,
        Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        maple-tree@lists.infradead.org
Subject: [PATCH hotfix 6.12 v3 1/2] maple_tree: correct tree corruption on spanning store
Date: Mon,  7 Oct 2024 16:28:32 +0100
Message-ID: <48b349a2a0f7c76e18772712d0997a5e12ab0a3b.1728314403.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <cover.1728314402.git.lorenzo.stoakes@oracle.com>
References: <cover.1728314402.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0568.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:276::18) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|SA1PR10MB6640:EE_
X-MS-Office365-Filtering-Correlation-Id: c1dfdda3-9fed-467e-8daa-08dce6e4b893
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Nx3vgUimRQ0UwJ0PtE5bLAQk9Uw3f7/VOukSu00Q+Z8ZhW+lciPjwQIc0FSR?=
 =?us-ascii?Q?v9NdXei1Q69z6XNfTa7OpH4rYf2g4D7RxSbsBD4ohbFb1xOAj0CTPTvONA+t?=
 =?us-ascii?Q?t0c/wzjb90ot+uEMBgY04zOJVR8wOgANgdLbCg5IH9bFlg4NGlGRcy5m/Wp+?=
 =?us-ascii?Q?6Ex20gaWepCYeEpGStDPjep5ATaLx6NYtpAAunP/deYBCpFi5ueHqBAovQbm?=
 =?us-ascii?Q?8IEXwt/yN3RegO06IZ5ytcubIS2FadUH5guJxf8SSF9WWFzoZ6PI+qPkCC0g?=
 =?us-ascii?Q?ERE87pAcwgGjkKoDpSf0RIlrE0musKUJnxqsLwhBJLENtCVgvYP/SkE8HLED?=
 =?us-ascii?Q?lZt0zdeOTHe1ODFBQ/TNTLPQSYdPk+eSgoLEd3vfFOPHVLmN1yzmdNT4NICg?=
 =?us-ascii?Q?hbKkA/pmoVyCgAaAdqNXerWFzzO/LE2/tJc/TtKhvtKVtNuPZMhs5R1F810h?=
 =?us-ascii?Q?QwToGRoDRgG/qVZA7BUuEnb3m0eU4e6Itw4AzTvgYaJOYp/ZVA5gaSmaDhVK?=
 =?us-ascii?Q?yyV4sbjxOVSbpcobd/Se3bMiRkkKvEF3RqoMNK+v68p+3aChZ5Ug9QcI05+A?=
 =?us-ascii?Q?iXZdzrc+o5w/zCH2nWus/+Pv/JfWeAwB3wgWc67gYxHWZd4f/RE+uxRJDkw4?=
 =?us-ascii?Q?DHi5TLKJ5fKfmSp6XdyFxZc99NXNZ2iqrbEcOpQYOpZWcmsKFHgWkFrV7+R+?=
 =?us-ascii?Q?0IRj7pHQq5t2uMHi0aQE1wjyzKA9kUwnzOpk1NYYHVq2hQot2WM8L5OduFi5?=
 =?us-ascii?Q?rlTM1eMYUmo2XvnSmeUMhKzfDL/tgVQbi7njhRXSeN0DMUwL0WdJJzK19j44?=
 =?us-ascii?Q?UuDDNWd/MKLroPsVi3ArLKVfoTq2zpnDzovB+7f8DygKz2BYPkpToR4QCI11?=
 =?us-ascii?Q?M84BXKWDgec1Kz2E7GzCScDe4btLL7HDy2vIOt31ErctRCVfjo/Xh0p4Y4Xa?=
 =?us-ascii?Q?/vBYFLYMPQc8U75gLAhmVOhy6g0HAkrQSVVYiH5NmUjAGH+LbwZm/3Y2X+x4?=
 =?us-ascii?Q?2/78DmwXTiwrFPTCvXn4xeW2rah8dv0bMPIvc+sNzmQdjEfxkV9uGpDKJIP5?=
 =?us-ascii?Q?hiChQw9XlM3O5I9mxljn5SH8taR6KQJXLuclG4k+l8bP20b31VY7cnTlbnu6?=
 =?us-ascii?Q?Pg5NEPGPsqToN2Z+HXPt6AFuJTflkpZFY1CeKHL3mQGtAHwuBlTSvux5OmqL?=
 =?us-ascii?Q?B8Zl0dGsXQlV23+IKlDBIzXV4nGtULZ/JIvKY3jU3RrqYiTiYab5ZVpo16w?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gC1Eg2AUyX860ip8QTKTubsgeG5zcOMDighP+jQQZPKqiJXGpCRzi8PN/1Uy?=
 =?us-ascii?Q?kZL7HWcYVkAMTR4UJ6H+Yuy9VIADBRYok1CtdChZhtNaufuJZgg4665CrJwL?=
 =?us-ascii?Q?CGCq99mJrJ9KZPQBrSEXSrgqzlrVGF06UVbX25dhs3VVWdbxyeUZi+1fRJ4Z?=
 =?us-ascii?Q?oaOXU+GXKmq3htxdndLVzdcNr0NIT0lm56EUoCp4R0Opwo6xY+37DW1QbZCt?=
 =?us-ascii?Q?56shS9mNXF2eFrkkSsh4zh8WH7fwQEv4v2CXPGLlHA8aU4+2E4r1/tKMMVXi?=
 =?us-ascii?Q?IbZlei6RxWlPK1Wng0pFK1sMuNPLBWtWsEq4gDWHzFKalXi4bclb4kVC7VWS?=
 =?us-ascii?Q?xXE6H0OYPDplrWjXCdtzIPbrfL2mkXI8F6PiVPU4GVu9n4UAMBdOsLTxBKS+?=
 =?us-ascii?Q?s1ZfhEuC4LR0wWUcBcOa3Z0IqqhnYqNkt656sudWv6Meme0WORRS+FX8v2CD?=
 =?us-ascii?Q?acbj2NrI0ggXhXnOy/fuxuLvbStmSMU2tvip1K3YcBbFM07Zu5+Fv1xYOFh0?=
 =?us-ascii?Q?teVlVtZ1G3QFW7t49293wkxiMB/Jv9zF71EZzXg3NKoMGtN7fhFY6E43/ikc?=
 =?us-ascii?Q?iNxloi6k93iQslZTbUTqicrd1PiIV/yf9u3S/GTDNEHGxaa5FvIJQK0/C9BB?=
 =?us-ascii?Q?Sbi71zYY5CcOe78byuVqg5Rm7GaNx9Wx8blcB83gKG5TkUzf8L6cMOeAKLtx?=
 =?us-ascii?Q?UCYl1iCj6yTkdJTrF7lFi6PBsVfvZdrGeLU1XB0oaPouBOvsgU7QVShrQKjg?=
 =?us-ascii?Q?4ff9V9BYfx/2sUEPw5MztUZP4uAvCmSBlb4mZMEEuxti+YBGPWCbuUtXQ1ji?=
 =?us-ascii?Q?bkvh7k5QTfJUMDTla3IS/iYSUg04p3v1w5whqBZMCqlw5waz9sY786kavnCC?=
 =?us-ascii?Q?aWuxg9BU18TAjiKuXZARfduCnzEqc3/kJqfkGrgg5mmnJMAsJC/oPVLJRhGA?=
 =?us-ascii?Q?JBysD9MkeUmHddrBelu1fzX2EOGDiTaxh4dmTUHQTJDa3znv2PkZ9lG7GjqO?=
 =?us-ascii?Q?JT/S1ewbpm0wNnMRtwXSsMgB4qaVWGGBOtcrL83TOvlL1kYSc8ekRgBjCJ9B?=
 =?us-ascii?Q?wZgOeQpKvlqt5RizP8dtFD10RzuFFNJaLrdTXhC84yxQhL3cvZJdrgWV/2Lj?=
 =?us-ascii?Q?UKHa7G2HlDPMbfjIKuMafUdnqm0KUm32V+caAvJPW/a6jYo8VMHW95FL9GcO?=
 =?us-ascii?Q?Exk51a3vA4IefwCt9o4VUMAWsDiB+luhdYmJ8QM46yOlLv6w8DzseKxkvuSb?=
 =?us-ascii?Q?VHHJ2bqGALAg2hU6j55Rc6VIxITbAtSGLZ/edhAnXnQAPv2GKf3pGUEkOWZ6?=
 =?us-ascii?Q?kTzT44+JeAp0kGN7PMwRPCRCfrVeGKUtylrhLMTGq7aTi+Jrh2FXJ6tz8sW+?=
 =?us-ascii?Q?4vlafKe/xWqPcDTqcZJn9yH5ppyHkLPdHSVmlF38Bn0VwQnIHN3m9Var9nAG?=
 =?us-ascii?Q?0mQD9/B7N+Hn7N/BGlY7FO9kQY1CcEvcZOuWzplMTnzKf4XWqbAAN4HRbcbT?=
 =?us-ascii?Q?3rCyEyMtEisNRqtHQuDmME2ouK5uebUdVlvvqYknJe+L+ct8WL8wV+JbFUVv?=
 =?us-ascii?Q?KX3Aj53Lc3UIJVkKLi27lb+f7YjRJIfMuI5D0ELF+L8LXLJvI1hBfqfDBdx7?=
 =?us-ascii?Q?lQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4ljaOeBqSHeSh8cCDGUyo1qgHbeDFwFd4g/AP4MtcZdGYCNYHDT3svZcU17cshi1qnwaGGhLmhK9gi5QTBFkLVoVnFVGh7D2WlrL9yPMY8/hLSm2Iek1hoIY8kuITn5wCsuqlm7qTszJOTPOxqae0Dz7Gt9q1a/yU5sNl9Bi96+d37TfWGs33h1W6kBbh1h2M7vK74KZJQds8BUgO6CzRAPrKVkzJOm7EKQQ7j0zNjp5XTsfHscXV37h+qPx355elxYf1QyKRi85BQ3tiOryPTbUCTHDJVkbJsE71yd9GzowkWHmYnvSKQeG7fqTeHdc7uR55YwuYBWBv4QsQTg3mCZgQxphszPY1fdZdd2vaWyaNlos2G/1tNmba9si1VWwE41VD+D0GbwXlxqbHzsEuUbQPktIByym4eYYzFgo6BEtLtWuOpPBzBNTobgNsXGPEwQMha+Mq+45J0V2jk1e3zmdFIdoXZmrbrnCNcmUiouwPHOdv0sNA1YzpM87E+XAKqIPOwuASs8pZIILEySjR5Ongn8ttnEA1XscQal/NCt0+Bdo761CRy8FA6au3IrZTEbCZDXr7t7ys1gQENC7RHKbCUTIOb+IlUCeljy9QD4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1dfdda3-9fed-467e-8daa-08dce6e4b893
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 15:28:40.5722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ER43AKrjUVDjiJjfleL032+M+ynJUxG/Hgzyw4k4Jh61G02lsUfdThA5yX2nFBdvPJxD7pDhKXUrtbHM5faeT/jszX3XQid8Y8P5l2843/8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6640
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-07_08,2024-10-07_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 spamscore=0 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410070109
X-Proofpoint-ORIG-GUID: nkOZ6EkFTmTiL_PURJBvwPsFvef_0LTT
X-Proofpoint-GUID: nkOZ6EkFTmTiL_PURJBvwPsFvef_0LTT

There has been a subtle bug present in the maple tree implementation from
its inception.

This arises from how stores are performed - when a store occurs, it will
overwrite overlapping ranges and adjust the tree as necessary to
accommodate this.

A range may always ultimately span two leaf nodes. In this instance we walk
the two leaf nodes, determine which elements are not overwritten to the
left and to the right of the start and end of the ranges respectively and
then rebalance the tree to contain these entries and the newly inserted
one.

This kind of store is dubbed a 'spanning store' and is implemented by
mas_wr_spanning_store().

In order to reach this stage, mas_store_gfp() invokes mas_wr_preallocate(),
mas_wr_store_type() and mas_wr_walk() in turn to walk the tree and update
the object (mas) to traverse to the location where the write should be
performed, determining its store type.

When a spanning store is required, this function returns false stopping at
the parent node which contains the target range, and mas_wr_store_type()
marks the mas->store_type as wr_spanning_store to denote this fact.

When we go to perform the store in mas_wr_spanning_store(), we first
determine the elements AFTER the END of the range we wish to store (that
is, to the right of the entry to be inserted) - we do this by walking to
the NEXT pivot in the tree (i.e. r_mas.last + 1), starting at the node we
have just determined contains the range over which we intend to write.

We then turn our attention to the entries to the left of the entry we are
inserting, whose state is represented by l_mas, and copy these into a 'big
node', which is a special node which contains enough slots to contain two
leaf node's worth of data.

We then copy the entry we wish to store immediately after this - the copy
and the insertion of the new entry is performed by mas_store_b_node().

After this we copy the elements to the right of the end of the range which
we are inserting, if we have not exceeded the length of the node
(i.e. r_mas.offset <= r_mas.end).

Herein lies the bug - under very specific circumstances, this logic can
break and corrupt the maple tree.

Consider the following tree:

Height
  0                             Root Node
                                 /      \
                 pivot = 0xffff /        \ pivot = ULONG_MAX
                               /          \
  1                       A [-----]       ...
                             /   \
             pivot = 0x4fff /     \ pivot = 0xffff
                           /       \
  2 (LEAVES)          B [-----]  [-----] C
                                      ^--- Last pivot 0xffff.

Now imagine we wish to store an entry in the range [0x4000, 0xffff] (note
that all ranges expressed in maple tree code are inclusive):

1. mas_store_gfp() descends the tree, finds node A at <=0xffff, then
   determines that this is a spanning store across nodes B and C. The mas
   state is set such that the current node from which we traverse further
   is node A.

2. In mas_wr_spanning_store() we try to find elements to the right of pivot
   0xffff by searching for an index of 0x10000:

    - mas_wr_walk_index() invokes mas_wr_walk_descend() and
      mas_wr_node_walk() in turn.

        - mas_wr_node_walk() loops over entries in node A until EITHER it
          finds an entry whose pivot equals or exceeds 0x10000 OR it
          reaches the final entry.

        - Since no entry has a pivot equal to or exceeding 0x10000, pivot
          0xffff is selected, leading to node C.

    - mas_wr_walk_traverse() resets the mas state to traverse node C. We
      loop around and invoke mas_wr_walk_descend() and mas_wr_node_walk()
      in turn once again.

         - Again, we reach the last entry in node C, which has a pivot of
           0xffff.

3. We then copy the elements to the left of 0x4000 in node B to the big
   node via mas_store_b_node(), and insert the new [0x4000, 0xffff] entry
   too.

4. We determine whether we have any entries to copy from the right of the
   end of the range via - and with r_mas set up at the entry at pivot
   0xffff, r_mas.offset <= r_mas.end, and then we DUPLICATE the entry at
   pivot 0xffff.

5. BUG! The maple tree is corrupted with a duplicate entry.

This requires a very specific set of circumstances - we must be spanning
the last element in a leaf node, which is the last element in the parent
node.

spanning store across two leaf nodes with a range that ends at that shared
pivot.

A potential solution to this problem would simply be to reset the walk each
time we traverse r_mas, however given the rarity of this situation it seems
that would be rather inefficient.

Instead, this patch detects if the right hand node is populated, i.e. has
anything we need to copy.

We do so by only copying elements from the right of the entry being inserted
when the maximum value present exceeds the last, rather than basing this on
offset position.

The patch also updates some comments and eliminates the unused bool return
value in mas_wr_walk_index().

The work performed in commit f8d112a4e657 ("mm/mmap: avoid zeroing vma tree
in mmap_region()") seems to have made the probability of this event much
more likely, which is the point at which reports started to be submitted
concerning this bug.

The motivation for this change arose from Bert Karwatzki's report of
encountering mm instability after the release of kernel v6.12-rc1 which,
after the use of CONFIG_DEBUG_VM_MAPLE_TREE and similar configuration
options, was identified as maple tree corruption.

After Bert very generously provided his time and ability to reproduce this
event consistently, I was able to finally identify that the issue discussed
in this commit message was occurring for him.

Reported-and-tested-by: Bert Karwatzki <spasswolf@web.de>
Closes: https://lore.kernel.org/all/20241001023402.3374-1-spasswolf@web.de/
Reported-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Closes: https://lore.kernel.org/all/CABXGCsOPwuoNOqSMmAvWO2Fz4TEmPnjFj-b7iF+XFRu1h7-+Dg@mail.gmail.com/
Fixes: 54a611b60590 ("Maple Tree: add new data structure")
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 lib/maple_tree.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 20990ecba2dd..2fe59c534328 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -2196,6 +2196,8 @@ static inline void mas_node_or_none(struct ma_state *mas,

 /*
  * mas_wr_node_walk() - Find the correct offset for the index in the @mas.
+ *                      If @mas->index cannot be found within the containing
+ *                      node, we traverse to the last entry in the node.
  * @wr_mas: The maple write state
  *
  * Uses mas_slot_locked() and does not need to worry about dead nodes.
@@ -3532,7 +3534,7 @@ static bool mas_wr_walk(struct ma_wr_state *wr_mas)
 	return true;
 }

-static bool mas_wr_walk_index(struct ma_wr_state *wr_mas)
+static void mas_wr_walk_index(struct ma_wr_state *wr_mas)
 {
 	struct ma_state *mas = wr_mas->mas;

@@ -3541,11 +3543,9 @@ static bool mas_wr_walk_index(struct ma_wr_state *wr_mas)
 		wr_mas->content = mas_slot_locked(mas, wr_mas->slots,
 						  mas->offset);
 		if (ma_is_leaf(wr_mas->type))
-			return true;
+			return;
 		mas_wr_walk_traverse(wr_mas);
-
 	}
-	return true;
 }
 /*
  * mas_extend_spanning_null() - Extend a store of a %NULL to include surrounding %NULLs.
@@ -3765,8 +3765,8 @@ static noinline void mas_wr_spanning_store(struct ma_wr_state *wr_mas)
 	memset(&b_node, 0, sizeof(struct maple_big_node));
 	/* Copy l_mas and store the value in b_node. */
 	mas_store_b_node(&l_wr_mas, &b_node, l_mas.end);
-	/* Copy r_mas into b_node. */
-	if (r_mas.offset <= r_mas.end)
+	/* Copy r_mas into b_node if there is anything to copy. */
+	if (r_mas.max > r_mas.last)
 		mas_mab_cp(&r_mas, r_mas.offset, r_mas.end,
 			   &b_node, b_node.b_end + 1);
 	else
--
2.46.2

