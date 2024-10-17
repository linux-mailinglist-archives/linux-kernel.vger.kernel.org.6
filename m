Return-Path: <linux-kernel+bounces-370256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A678B9A29EF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 19:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAEDF1C208A0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 17:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0191E0B68;
	Thu, 17 Oct 2024 16:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="k3aBH+Ou";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="h4Ej8pb/"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEEC1DFE28
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 16:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729184221; cv=fail; b=iLX8sRaqQGCIf/AqqA15q81PTp3pHt0q8G4tO6sfhUVYF8NABivZ+m79tH5fEA352+nO0ai2yPtrphqcAq5Y7khQAc8cRtHx1/CXmxvVx5TUH1V9GuDydaiQZKbmHszIJbAUSkvBoZLCwojAEZNVfZ9YBUOtBIBd5+e3tzWrx9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729184221; c=relaxed/simple;
	bh=RjYVwPpXeWjW3s2+8CgMaVGGmbqvU05Iqe4NKbUOj30=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=jh1BUNcYgF6JsSv2wgf6xEJOYJSvq1qa/UzL1Fvoghgx80HGhvSbxUhDM9P/fcsryFmr9skGhA0wmqa6njyPetNxXoIWUNQ+dpCdGhq3dT96JeVaJUOW1cxRvb9/fXoVV2bDkOYHWO2yNjzK0kRAP7BEhmVHgIsgY64YJmjXtbU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=k3aBH+Ou; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=h4Ej8pb/; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49HFBv08017840;
	Thu, 17 Oct 2024 16:56:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=5TZO9INgzw3HN2mx
	usJi70XCnjg6P1ZrMP2Vpje9Qzo=; b=k3aBH+OuN8bNol+J+RMXWIkDgiVCtjGb
	7Zqzv/1Xj/Vq1n6X1I+IN7gEOrASpPRwoJKwOt/iqWukjkH5CFa3oMc7bxsMOgAW
	aDIXpA7LpnGPi4YNjCxS/AAyTMbnSKGEgIpahLQMylpNDK8QoL6LYaU/3DG0Vwd0
	ynK7WA82rgWC6MiGqnne+iPPwgHaQgX31csVInZHlUTuIKFy2DBXopjvqSCMldIs
	M9YMDJIVvA9udSYt8Wz8ak4c3oMeAL++lREOvzyWqYV9BZdbJ1QUHz5fXORTvNXS
	5dxYByVjNJEgjI02/oNVDQI5V5rhf4Sdd3QrSbQQKLqYhwzX7f1gvg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427hnteyje-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 16:56:46 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49HGYD9Z026232;
	Thu, 17 Oct 2024 16:56:45 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fjah37n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 16:56:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oHJjTTsAnYorGsV+gMS3J+4/6PW4/yCsS/2agVoGNzwo/oOMFg7M1ybUa0eVkLqYy+sn2i28PCVz5gNEFsR3wWWx0GYYzCpA5Vx+RUR1Z+BabhQpM/GznlEg7koy2Je1TANP10nXo650sz9w0t55Hc41ozZKZsSCl8bIpDajwt+lHDWhd6KvTGK0PU9QS0x2x2c+V+TffdSH9Q/bdn+lDm9zJ1eXWmD/BJpQvVZ07ACR8XXTXhfRqUAxrz2gjcUDrcitv8j0MiduFkvHQevMvgwTuJ9VZvbY5q0yVNFBBeeJgOi4Eze6ckCZUcFm+m7FmgD5bQeAVz6wTa5A0AuZmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5TZO9INgzw3HN2mxusJi70XCnjg6P1ZrMP2Vpje9Qzo=;
 b=Yz5Z1fZCHLjXYAXzyIXmr+lj8xMSep9nkmLTKcm1Bad7r2IXNAtxypXhDRhpWCuOBrLazd2qjLVTU33XETEHpCWDJ4uLVTfnsm5HgizvquJf89DxuqHiUt40B2PlP532tZJdzQ/GZ3pr3yYICJchENAvvkmgKdI1DV9b5GqeUt/R7wOfE6/GO+5sWnd9ist5s4Xjklw47gMP35XnpNtiJM1Wb57LKP1pjms5g93N951ytv1WGOR/LHOJFWgLNx8rumKAtUIXKi9UPtHHBIGLRXYHyv+dvWi1BCUIDrD0yanCO01dGm74+gYcoLEZ2BSUdOMTidmhuwaKpyf9DHMgzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5TZO9INgzw3HN2mxusJi70XCnjg6P1ZrMP2Vpje9Qzo=;
 b=h4Ej8pb/tYtJmJoyIOpW7QIAfCwnfvtFam2Coqpf0j0vEOlk03qGkAueB1OPcnuJYeMWwpikX1rvTnWvgJhj+vJqC9kCL2E/6HXPQZM1f8F7/OgkwT1D2a8IC2NLD81SkiFcVfJQPpxKQNOck8zvgqI55CGYcCP95PEbi2sj9lU=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by BY5PR10MB4211.namprd10.prod.outlook.com (2603:10b6:a03:20c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 16:56:42 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 16:56:42 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] tools: testing: fix phys_addr_t size on 64-bit systems
Date: Thu, 17 Oct 2024 17:56:38 +0100
Message-ID: <20241017165638.95602-1-lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.46.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0040.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:152::9) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|BY5PR10MB4211:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f904138-f494-4884-1c34-08dceeccad38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JeT9wBM+BJaB34devo2uAe/0pVsJHUbsCY1VdMkJkORCoq1xZksxvhnX+fhK?=
 =?us-ascii?Q?eQePkLrvkwIxM8VkkdQRGPvpjZp/d/67dwO4Bz5u3aCWRJ7KZhWUrUudzUis?=
 =?us-ascii?Q?77qvBadTfxHoutkKurWChxKkVPCAB14E8T23/e1e0Y/WlXAntr0P8FKS1ddW?=
 =?us-ascii?Q?Z6TnIzyneltlCZzPcDYErlC8inmGUVkM8GoFtr3VYm42r9IgP9M5bVbrfVpQ?=
 =?us-ascii?Q?5GG1XwidopfiTdyMAzg75MeL8EgFXbBTs42cd1oreecKJzLwcHxrwe6yEHEv?=
 =?us-ascii?Q?nd5a919hYDfE92lIQRJYImNWamZ52ifoyGX+bN07bl9V/4SNy8++RclMKGeo?=
 =?us-ascii?Q?G+LNz+gWxfEcySH2abeQeKZzYEo7LAeAUxuiPqpt7DPAAa+TA+dSdRu0G+Xw?=
 =?us-ascii?Q?k4n5pIned0S315DkfKw8cr2JVOmmUcWnhrurqF0c0SQhHZZBzUkSwnr++uw3?=
 =?us-ascii?Q?7G9kz6Qau8wEP3UFecQe5fVe2xe2l1qJxtgsZehg+lu8sBJ7PuUytH/TEO79?=
 =?us-ascii?Q?fzXevvyJCQaN/Hwpijp+ndgJTiKNKAgCE12r+fY1JvahCVE/gGhwrvZO2ln8?=
 =?us-ascii?Q?g/h9O9uwv6VQzF0XT5f18qUcvm4GGWmrxfdMQa0CcKLd+217vaXQC7gOVaiU?=
 =?us-ascii?Q?hGPbfIomjFwZ4yi8PWMEbp+2lAsnovTx60RJD6fv8TWIL1EGbHVm5OaNw3qm?=
 =?us-ascii?Q?ptFZyDMdlNOsqdYvvHxN6Jmhni7KkDfih4kc8pL/6ejE2QsZyWonHybIbaTW?=
 =?us-ascii?Q?WH2vp4CHBKXymWFGnyAmFWp31KGvyj1vbcqy5llHX216evoQk9eDhBgDcfNG?=
 =?us-ascii?Q?1bTHX0CqXqLzq4TchWDAWAMv0zX4uR8xSGafe2jSVLRX7zC/cV4ngWGTTDe+?=
 =?us-ascii?Q?3RZI7AtKGFbRUgAZwNU6Q3JV1jO/dME9CP0rfx8V/+oRUIHrIOy4/Kp40Ga9?=
 =?us-ascii?Q?rzEj1i/7HPPTJUuLQijLW5iJYeI71lhaxRMzp2MfuqkoYbUiOem+yksjhoFI?=
 =?us-ascii?Q?oixgG2opiCfqzhKgB7A192n4SxSbdCohOf5mNC+6tJqBZHhNR5VVvkgtt3Hb?=
 =?us-ascii?Q?e5jk9fj03R+UxF5Ts6ltU6BMYz+eZmNI1qiB8WsLy3fsXAR70r0u3AEy9A9r?=
 =?us-ascii?Q?U9XcEbiiFUzv/YWGhRa3F5aiKU3Bd6JDLcRlSrZiDZXTuni5LnaoSUqQwLTw?=
 =?us-ascii?Q?ANrp6XcMRS22crVSCxMr2CF3fsLIG3Hl/oBUGZoahJf4H8szBNEuGmlxs7F9?=
 =?us-ascii?Q?Ohfyg8zwRDwru7XPACxA0AB3eJmkqLTecxLHJ2EXaEEG4Mswq7YiIcMSr1AZ?=
 =?us-ascii?Q?Zu1aotFEm1ChRJI3YMMAe/Gz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dc5LbfI7fczEFDwbnLamAPl8kYl+JteFNPo47G+rBrs4GRNdQHIe2ACd3kG4?=
 =?us-ascii?Q?UktM7swrnb/MjeuEE66DNRjQCJw+8kvWup9Hma6yl6+jeMHIH4lFPM1HcpE5?=
 =?us-ascii?Q?OQ5RvdF8R4OAeDE6he7UtiXlHRbPg5cDbyKyxgemmyn9pnNQb2HFbPLG8I/D?=
 =?us-ascii?Q?v8FWi0sZan79Q05K58IcIUyXpzPw9BTgVaE1L0FFw9Pa9SE2hpw8InVTMOsN?=
 =?us-ascii?Q?oGVaM/NF3u6Uh4oUJcDcH8P9GJqqWGCkspg5xu7+BepccN7PO3X9H+foOqiX?=
 =?us-ascii?Q?ZqWGVgL9Or0io19LJh6N+nErJsywoJLN60j12EuRnJFlSfuJWZbQvnOWpp/0?=
 =?us-ascii?Q?vgnahm8l9DCUIkas/dShKsJbLmIB+OG0bc2WHKkjBJmucoApITsc0IMV+Cen?=
 =?us-ascii?Q?lqgzOpe5CA6wOwWJuKtZWWMAh/vnB6Cslv2g+TR+yF++aREt9hwtI5kMtPC4?=
 =?us-ascii?Q?m+bfP3Fmz9zXEVX4/VoHy2m8Vsx6umlsvnV1D/Kjeijlm+2hL9J15li1FRWn?=
 =?us-ascii?Q?5CHO4SsEGhIq5t/OH5nHitDy5ItKhpIJ7BkcnE1KvpA5rs1pbMMBFdtKZlJI?=
 =?us-ascii?Q?q/buUSQzGuAc87vdYLY8VfNq+SPAfdiXiWWN7w0/UQlRDENmRjboVyV9IefW?=
 =?us-ascii?Q?caZgUSqcF5POBkljBjl8G/lkn8Ej0QuEhrfIYf52x/Pwt4YYt2c1smr+kpb5?=
 =?us-ascii?Q?7Wkb4mVwj9EEHaN06V/8PjxbWtxV6nlEOj5nVSGtqUEAihRjIMnqIK66CEn+?=
 =?us-ascii?Q?XQ+J3IXCZEmW8SFTjANm21my88/9RzIpGreqw06AUd0rzRfbv3MNlf2V6IFV?=
 =?us-ascii?Q?QwikDIALHMLecgURvNowKYc8ggkOSaRFTX3x2Frcm3hCWO/IA3TB0fLB7Yrt?=
 =?us-ascii?Q?sMMmRVi25S6ZnbRaa55+4KnBCp5nyOc9Kl+KvrCJ1CNjwfT33qiVtnaumLTC?=
 =?us-ascii?Q?wmdXrCl2/k7RqNn28Mz6bEB0FHmdypgUCiel7CUt5nVd27lJ+Zqhubvk49bj?=
 =?us-ascii?Q?fww7Ur/VtdSiI6dAINY+uNKd7V9gzBjXs2zM8F5pLzzCwqmhxNNfLaSzXWXM?=
 =?us-ascii?Q?DaYSnOytRRjoaI47t5e0SdeLI8tqJbGrn8T9AnaSFlqctxiquosCqTsGwY5E?=
 =?us-ascii?Q?KxW81AD1+1+zjCBUSfmObnOIWQ7w9pMszOGFGQUB6tF6LZp8xkbFTKtxBS20?=
 =?us-ascii?Q?N5PhKUUwrXiXBe1J3rgsN1u3PphniEp++hYA71+YXHFnYcKvQ2TITldKrxrJ?=
 =?us-ascii?Q?x7uBP4/I/E29XCBTizAxeEDeMM5aUW5nVXdMXZqS/Qlk48GskEUCpQ+juBaA?=
 =?us-ascii?Q?T3mKyvVV1fGlKL8+/O1q/GY8b7JawiKKpwei3mXbdyVgeZYDRTvCTJsqUqbl?=
 =?us-ascii?Q?0VtleD+S56bDBl7gl6RTzZFANjgjXcK35wGuMO3JR6936zKh3j3VVTM9++g7?=
 =?us-ascii?Q?iBGQApO7ELbqj1EuEWQvFhOjSIOMUmRHoLYZ+h4f4B3R1xY6d5QCwsR+0HVu?=
 =?us-ascii?Q?lcg8QZfg+cEJJYnHp3pjTg92MhU8b5lJTlrJ1FT1mJLv+/yjd77fsWafEojQ?=
 =?us-ascii?Q?WFsHbi+SR4UTf5IVtaZFIYwchDmdWyU6XS35c7Fxm8N+VNSw6zn2lAGR2om3?=
 =?us-ascii?Q?WA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BFRq+684I6V7TQg/m1m7sPCkwPEvwJnycKAP5duQxw8WNb+C5yuHSJqxjubgukLMQBXUtlhiCQA6g5OsmvnLTgcOdWNMqT+9MR8pf5HKPRuSk6yGmEXOOhwwQrwJxZCNSEljL5HXHYVudzl9Q7bq0iDarlxLEQElLiD2WEbhsBzAWRsydOA34cMjdCnwbUMwWeQdSY7On5S0cBS6KCPePAOShb1+3uYE3I98jyAb1sC5zBgFJHDY7mo+Rhp3KG/Abi+HoTF8APrPs5xwHXNwCLZ/r9SLJWZaLEFSGxD0QoefuN6iv7KvW/RDKvD+J6oQ5qBjDeMVvoTFEaLu36m7+3i6U39zTscjDhMBtbESbBIzI8rk54Vw4Tddgy6zUDHrLlIwRqRrsqShMi6d4fiMYApbyo50rFOY8+hzP3GfZtV6hMRWEXP26uWcYqCYYcRYM3ulmUIJlYepI50wKsDgPKygLDnTunGxwa1dl72RXX6GaKfm6EJ8qK68vNnnEPFP9ybUcDgK2FBicxkF1fyFbd8upNFv3aQIN4qvcZT/MNOnh9iGhyHmS1k+XsceH5KyYoec+v6PM82FfpjLGZ7CUCaHEuGCt7pv7AuBvYIwv4c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f904138-f494-4884-1c34-08dceeccad38
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 16:56:42.7816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wzUQ21u2A1Nl5RiSnV7sGIQ6GoO8ZU5WV1AERkNn8f3PZ2Y7fS4ABQPhgWlDyQcILYtFrYuLQ56GMfdBGVFNlTIEPkpYuaYn4qJ1uaMUU/M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4211
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-17_19,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 bulkscore=0 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410170115
X-Proofpoint-ORIG-GUID: N0cVd-X68ZYTDWfYEmrvW96yy4G6_6Qs
X-Proofpoint-GUID: N0cVd-X68ZYTDWfYEmrvW96yy4G6_6Qs

The phys_addr_t size is predicated on whether CONFIG_PHYS_ADDR_T_64BIT is
set or not.

In the VMA tests, virt_to_phys() from tools/include/linux casts a volatile
void * pointer to phys_addr_t, if CONFIG_PHYS_ADDR_T_64BIT is not set, this
will be 32-bit and trigger a warning.

Obviously this might also lead to truncation, which we would rather avoid.

Fix this by adjusting the generation of generated/bit-length.h to generate
a CONFIG_PHYS_ADDR_T{bits}BIT define.

This does result in the generation of the useless CONFIG_PHYS_ADDR_T_32BIT
define for 32-bit systems, but this should have no effect, and makes
implementation of this easier.

This resolves the issue and the warning.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 tools/testing/shared/shared.mk | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/shared/shared.mk b/tools/testing/shared/shared.mk
index a6bc51d0b0bf..b37362224a73 100644
--- a/tools/testing/shared/shared.mk
+++ b/tools/testing/shared/shared.mk
@@ -69,6 +69,7 @@ generated/bit-length.h: FORCE
 	@if ! grep -qws CONFIG_$(LONG_BIT)BIT generated/bit-length.h; then   \
 		echo "Generating $@";                                        \
 		echo "#define CONFIG_$(LONG_BIT)BIT 1" > $@;                 \
+		echo "#define CONFIG_PHYS_ADDR_T_$(LONG_BIT)BIT 1" > $@;     \
 	fi
 
 FORCE: ;
-- 
2.46.2


