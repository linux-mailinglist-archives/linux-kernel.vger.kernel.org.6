Return-Path: <linux-kernel+bounces-191563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FCFF8D10FB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 02:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72EB31C2178D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 00:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765B64C618;
	Tue, 28 May 2024 00:36:43 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD581401C
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 00:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716856602; cv=fail; b=PkrFYF1eicRGuES/ZpcVx1LaLuFByRgo9vN4wNMqAX1VCMZ9JA6PwIRMQaatQvmtJZiWeBZzHnTilje9flFfOw4iV+Tnk6ifPLRdhzfGoRBFFZ1zJkUvcFPZRiuaRH1DZ/z+iPM7KWTED8ffdWZgeJp986czFci8ht4nxQHliis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716856602; c=relaxed/simple;
	bh=8EbQMq9yhiRaY69+ZXoiqNPuqCRhLJiJrdoVRn/gOOI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lCeagUA83nge/5jCh+aCMrN094beOCzKzunf4ti7X0AORdupQfy9LL5kVsoOCLOack84JFQiaARXPBDHihbZLCEyMDziyQa80XQLN0XTz2zF/BndUHYC0TmhNzeZli/6x7A87oMMLZVOLn0RbJpL4PwcVHCQj6moB90uBby1rlU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44RNkmrN016198;
	Tue, 28 May 2024 00:36:25 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3DkS18Rb4cvEIKXLYYFDsOYcEXh408pOVMRLjbr2O2q8M=3D;_b?=
 =?UTF-8?Q?=3DNbEabUT/TIyXsXc3TCX7ydeDqxRSJAuF7wzi/Yoqk5+C/3bLfgXn06tlsuNi?=
 =?UTF-8?Q?u6vwq/e9_xdRaBV4IHXN+wMN5TIjIJ+S+VtKNPfmakGItRkLmpX8Ru7GuXjsAqA?=
 =?UTF-8?Q?HJ1uUKYNtP4Gw4_wDtONGWnO3vf/YM0Yw0b/dr7rYEqk0wGyAOCwINXj7DX+Um+?=
 =?UTF-8?Q?7HhSTcMvKyF2AYWyLDQq_LtoLiFvtTWeiScBqImtYqifVotupihk6CYb/UzN4hO?=
 =?UTF-8?Q?dGHfRnY6GFIk2LyhjZxp7mMgbf_55OD7IKn/vDoQmDdsyklHU1cDrnKdSDbbLRR?=
 =?UTF-8?Q?nwObCAq5reywA87KnqABc1kQDbjhZ1qd_cw=3D=3D_?=
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8kb37ra-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 00:36:25 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44RKdJ4E037250;
	Tue, 28 May 2024 00:36:24 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3yc534rdpv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 00:36:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YBRCf8g+D6e3tuc0Q/pvfT2s0YFzpL21RiTkvT0DibWh5HVtHJv1Ds7p06T/QvCH+it+JUZp6x0QxN0/VWUyfvWSpi5RebTDorv6oBNw90Aoj+4Yex3ErJN15bywt/5Qs48HeOKoC2I8SubrysDtSVWYS3cNphN22o7VJ5WWeJ625lf9mO48KtMuo7Yt8GKvgfLxpWIayBOoTcIxpS82avrP1ZeH8iWSV4Iq4UITOwgrjvaMYWjfDAKiD0mvnZkfC1cNVKM+FnMSh1MFswLtVLdSHg6JgYAYh5pmQxah5s0pikPAybeSlE4MErCxPLErJfhnbk5MPqfqMtxUGUu3EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kS18Rb4cvEIKXLYYFDsOYcEXh408pOVMRLjbr2O2q8M=;
 b=KQho4wKHAJWJF5fv6tBTs4fP/DOExW3PAmqGm/aM+ZPgdQn7kezFHxPc6YZMae9KsPBLi/+rBhIwUn+CLG5cxCa+5MXxIqZF75JmOqY6wYDHT4AVhV6QovzL/bIzWDBtP+hD218nS8RjKjQ7COGqMl69frACtzdfnrI9ByDrdw2Pl29f4z6Ku6MaObsxCza4yHLzqc7oc3FVWwr9IKbRiYjBRWmNwQKvR6fJvVz8Ai4wdX8nXTncYbflSVMFwT3PQLRC+N6mBJ7s90R0pFgpKJI7GKM45Y0SalJx/qnhO1oSGvsY+J5WyIQ0Sm/tRiZ129IWu8FY/DhH0DugcggyTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kS18Rb4cvEIKXLYYFDsOYcEXh408pOVMRLjbr2O2q8M=;
 b=z+1qmmBRkrLIlnZoMscBz8H44W/TtQH49HIvX2nyNX5aFeW/8yhmIqyZNnJTXMUz2yV+WLjYT1XEFB3SyFSRsqKvoBACdoHc/+mhHwinifB7EBFLOEPj1IZm2b410ScVK7d/UbjqkhUPYDG0qD3tY0dhNaSEzKdYemm1Txo2yPI=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DS7PR10MB7177.namprd10.prod.outlook.com (2603:10b6:8:e1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Tue, 28 May
 2024 00:36:23 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%4]) with mapi id 15.20.7611.030; Tue, 28 May 2024
 00:36:22 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, peterz@infradead.org, torvalds@linux-foundation.org,
        paulmck@kernel.org, rostedt@goodmis.org, mark.rutland@arm.com,
        juri.lelli@redhat.com, joel@joelfernandes.org, raghavendra.kt@amd.com,
        sshegde@linux.ibm.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, Ankur Arora <ankur.a.arora@oracle.com>
Subject: [PATCH v2 18/35] rcu: force context-switch for PREEMPT_RCU=n, PREEMPT_COUNT=y
Date: Mon, 27 May 2024 17:35:04 -0700
Message-Id: <20240528003521.979836-19-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240528003521.979836-1-ankur.a.arora@oracle.com>
References: <20240528003521.979836-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4P221CA0007.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::12) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DS7PR10MB7177:EE_
X-MS-Office365-Filtering-Correlation-Id: edd9f82c-e770-4e54-8c11-08dc7eae333b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?qeRJZxDF2uNj7nRx7mADTtAmWnvKXIvyRPpw/wZe6h0k3WWxlUr8DT9YC1on?=
 =?us-ascii?Q?4Ur0yKxVkGLGEd+SiH+LQIVW/GWjGmQk9NuikP1bGcyGF5DJx+3mGYxHvo2f?=
 =?us-ascii?Q?CozZmVOU9PCyeg0lXsIjK92mEV4Gipqry1n0FBDqJrDN0jzpUZDrSbA3pWyN?=
 =?us-ascii?Q?Aik14PssR0/js2vJ6y659a9djrqGk9Sbuux1QN+3hr6Ui2RZzlNDbau8rjy4?=
 =?us-ascii?Q?rBpzfTPq6NALuUhWLyikuUBpoM6r8CEEjEXXhncC49lDQWj3NchAnDuUvL3m?=
 =?us-ascii?Q?hGENTu+Qr8GQKx6OBlftaOmaP8EZQi09QpGzGoSKZh6G1AG6EfsAFBJydNJ6?=
 =?us-ascii?Q?UpG4NHEPrveLwr41YghullgMlIjDdYbLIQQKjT8O0HjwbCTer7i1aM3/XB78?=
 =?us-ascii?Q?G7GVKYeisFlTO5rHPMTBCQzMxDP67yjNEFJNWCM66sSkLJBJOEncIN0lNQpw?=
 =?us-ascii?Q?4ilQLVZlvjANd+oWaAaWkLaaqzdqLHB8OZuxoYc/ibKMJgFS1/NjrwQtiiBc?=
 =?us-ascii?Q?ifUajSddStY60KbAGQg0YlNHB65iI7W8V+WIWbr7uI95lda+SLEmn3OKvmro?=
 =?us-ascii?Q?jbbE8JC+LcU1JSjUV5XDDPtUDqz8b3rUd4RaAeOMPbo7Ulo1v9VVHvuUCqz+?=
 =?us-ascii?Q?Bj76GUS5GGbH700LLOZaalhXuxz2dS5eHfpxyUQyaCy2GgEtL4nywCiGa7Qa?=
 =?us-ascii?Q?fjd3qO2sRuZnO5lkrITgyHOd8R0L73gRPD/3xv8yX811u9xHlWmP72+ozTwN?=
 =?us-ascii?Q?wjP3Xy1pSRCoxV5vRCxBdOwhpFjrk2RTpr/c2uw1CSC6WG0bQw7a7TjF9Ma9?=
 =?us-ascii?Q?OwJVDTvvIDzXXuvqDoIBYe6b/dnPW1ILTlR+F3dghbOsdRmE0Hv42zrAFKkg?=
 =?us-ascii?Q?gLu5BfxbCz4OMik2rx6QHl3iZOg2zcwH/TzsVbqN/KZk3Ns5fHYVHE82qFuw?=
 =?us-ascii?Q?A8ZoM7q2sVqPYxj5MFNCeJ09UHHehYFv6JHM2fPR6B1hrJrmAv7pZytf0jgA?=
 =?us-ascii?Q?LME8QJ1K6CNBzr8Qg98XgTmmUn9p1EuDl1DmSbFAA+/sdDQVPIoUGJs3fC93?=
 =?us-ascii?Q?ESQ2zsHHYmFlj3rhKqePoSUECt8jvGqhTy1uEIUN/25fBwkn3xP3x1N/jYAA?=
 =?us-ascii?Q?XBhHaOwK370weZhY5aa1nBcdXPQsDcf6oOulcnplFA+CfBD+pwZQ8VoVyl9b?=
 =?us-ascii?Q?ILrhD3UjeCvLpcZG0oFxCS5Cz6KBui0BcYWae+A7iG2540f8dQkZ0IZaQH7t?=
 =?us-ascii?Q?6Qj8fZZ2+Tmtp8gyb+zccda1aCStQ9x4HLlFUPf/wA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?KiVuz7KGfvQUoCLbBsB0rfyrJ4n66D8JuYqSbs2+g7tIxpUb8u5AybILOEqo?=
 =?us-ascii?Q?fDRbNMXswwHHJVb7HMnDXxtyzUrQfazZS95vU6eLG2Kt/Ss7zJ9bAxgUGwnF?=
 =?us-ascii?Q?wAX0YjqhCOUmG2YRQvUeMyswug6NHdeuvme1CzpDQC2kGzNrXNUn4AqFIH1l?=
 =?us-ascii?Q?Bje2OXkE+mFq2f/L2KURcZUy4zFugFjdk9SlLdIgffL184GgLgfLsXDae14N?=
 =?us-ascii?Q?TUQneRdGjf8bfbgFl+k7mU0a0H5PC3LvaCoaDB+zWLqOPREld7hwojXUcSbU?=
 =?us-ascii?Q?1jMsz3C/ynP8QccvRiJaqf18Oz9+/a3d3CemZO4qveSctW6QpTvhFl8gL7Tm?=
 =?us-ascii?Q?UmIk2QZNgtFtaospN9zsiEYmI2lvxo8CQv2qFvAHR2CyCoRQELwtdiJ93rrX?=
 =?us-ascii?Q?Sx/zSEI9eTq+EFXrjVRgaNkoeBA8jAv28pBhqeOyXt+hPdGUegITtqkjCpPw?=
 =?us-ascii?Q?61tQkqWnsuHyHX/xPJHSwV7YI0eJbEjhfr5Q3BqoTXfZ0i3UN5cq/j5eFsw1?=
 =?us-ascii?Q?gcBXLhkofRHCF0J6oqE+6AMDYr3aWvZdpkRz448xd3GXxrqY2+fcl9eBgIxO?=
 =?us-ascii?Q?vGfVZ+U/398ZxqaTzsiiwkZ9TSm8kUI9hZAUQjQkJq+We8Ves6C1pKlEPlZj?=
 =?us-ascii?Q?VYURCdpUfICy5R/NNpKirIWDUJYnEwN885ZWzA6ZLSjRN8kVpxFPdvm6EMg5?=
 =?us-ascii?Q?dNmCpYKo3Envrc1GwtnRUeYqt4+6IkKvXqQsjN7DDu3Yo6fKZHAxfeOSoxzr?=
 =?us-ascii?Q?pvGB1xcEzs2pg3l9FbngwQfm0zW+az5yCIY/mGbYG5XZbO8Kx/aFJ6BOgRDi?=
 =?us-ascii?Q?30jNOFNCGCrJOgYw9yPy1BkGxBMaEcg6Jv+yY6p1lDl4Y47QdfMCkG/gYg20?=
 =?us-ascii?Q?MHoe9QihEg12K9NAwL2AkNFjloWMIcikjVOuLmx6RiFgRDnaoMl87zZcmhnV?=
 =?us-ascii?Q?5UzyPEh9vUvRq1bwMShAWN+T2ErvOCX7EOPpQFQNM1XxEcHbCKqn86feraoj?=
 =?us-ascii?Q?FOEQdLyKLps8+2+MAZIFDCuWorQv7ZG7bj/o+0bUjIL5l1RH2vtY6xmvyV4K?=
 =?us-ascii?Q?wUWX6W4+kBV58Zp22uY9eBqMTlETtGkm+snLUCCxBLQvOqwTxoLpgyz445IX?=
 =?us-ascii?Q?JIj36g2xvuhUBkCRCiuj+cfmXS5cx9EIKyQ6nqwqvcOvUu7t0rU5nQveKKkz?=
 =?us-ascii?Q?WYu4MAFddhUmp03LoC5H2dvYUaGTdLABO82v3MsJGXJRRM5RqABmzvKu3FtT?=
 =?us-ascii?Q?Q2b9qdVOTQKenwUsduBJMdnRud343PcJqsb82B+GElYCXLTZI7xZsBU8VgI+?=
 =?us-ascii?Q?Obm0ptCju0dioAxxVTgrjl50ZOBndcZ38gbTyt7mjBZlJAq97XuPgBQ0wpw+?=
 =?us-ascii?Q?owkKZXBb7q07mRR4gBtke67HC8HYjOmie7ifuB6fXEFyfRz9E3yR/gO+yy32?=
 =?us-ascii?Q?cZYWVwvPd76JCwrPMZpEEb1k6mBGWXRHcvHkOw1afLmDk92qOvGd3avKzICX?=
 =?us-ascii?Q?fKqcQtxiYaiM6cg5ph0Xxg0l7gKpyUsE8L7t+AEQn4JjMEoWrv5QN5DWgFI/?=
 =?us-ascii?Q?UhCyBXy1OZDjRmLZFFQPuBVLnXsNBtUSjAm+o+LPdZ/p8f8lJ7vmYeeLxp9N?=
 =?us-ascii?Q?Kw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	We+a8q3ivFvmEwqR3YL2vdVgY3cWdrY5nuppjzYkBH3xhvU9GNsxTCh3effJmzHa5XmTalTeCq/nJoWayZVfElnDEUr0HAqf9Zn2MoGefZiH/wyV55qXRy0etbt1R+nMrGKu5LJJgnArCrkVpRk5PqD+f+CRdtpp0pyx9P4Pb7IzRpMVWHff0aPOnc4YWOVWTJivBOEhKEZrvJeNLubDrllFkXWxwi3q/CQF7TRu7idEk0iBOCbE4Sp8t/9uV2n8V+1kCivp5LkvUusdPYVsCOYxwl8NbAOBEqilUaSIpADKpMoe7jQ2X0fRd0hYgOt+q65nIdHr62AUoMrML19zmTJK5LzNMwTWThOubFGCmiOKsEIjHL5k0sGsqaZpG3v6G7c852gjpWBpxAyeYRkeE6hdavCkqB46q/a8gF/LtzoQTGYE/5NVBFCPi+mcV2q22qXi5cyUa93Ld3zbzrt6psHjL2+7ttCb6OPKQUW1qiFKZMUbOH8AFgYDtSJc2H3yKsVwxgqQs3cMNjAPe2CylHYrVL/kIQ28wzhK+Lt2F/KmMtR2TAVRRwJ3G48DUVdXRS9hYXoz6jq5Uv4vYRLlbOJx+c2n8IcBKRXHmdE40UI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edd9f82c-e770-4e54-8c11-08dc7eae333b
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 00:36:22.9397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8/GshhxQKvofIIM806fk5D4fg8ABsj2wdBp1mA49EiV5zTDCADI/6dySgIaNsYW2NpAeP6qhMSqOWFlsO+j895ZE8n6B1COnXx2Tr6AwUWU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7177
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-27_06,2024-05-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405280003
X-Proofpoint-GUID: OUn2i8iFRic1sbCoL4Wg1V7zMjXTNq-q
X-Proofpoint-ORIG-GUID: OUn2i8iFRic1sbCoL4Wg1V7zMjXTNq-q

With (PREEMPT_RCU=n, PREEMPT_COUNT=y), rcu_flavor_sched_clock_irq()
registers urgently needed quiescent states when preempt_count() is
available and no task or softirq is in a non-preemptible section.

This, however, does nothing for long running loops where preemption
is only temporarily enabled, since the tick is unlikely to neatly fall
in the preemptible() section.

Handle that by forcing a context-switch when we require a quiescent
state urgently but are holding a preempt_count().

Cc: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 kernel/rcu/tree.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index d9642dd06c25..3a0e1d0b939c 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2286,8 +2286,17 @@ void rcu_sched_clock_irq(int user)
 	raw_cpu_inc(rcu_data.ticks_this_gp);
 	/* The load-acquire pairs with the store-release setting to true. */
 	if (smp_load_acquire(this_cpu_ptr(&rcu_data.rcu_urgent_qs))) {
-		/* Idle and userspace execution already are quiescent states. */
-		if (!rcu_is_cpu_rrupt_from_idle() && !user) {
+		/*
+		 * Idle and userspace execution already are quiescent states.
+		 * If, however, we came here from a nested interrupt in the
+		 * kernel, or if we have PREEMPT_RCU=n but are holding a
+		 * preempt_count() (say, with CONFIG_PREEMPT_AUTO=y), then
+		 * force a context switch.
+		 */
+		if ((!rcu_is_cpu_rrupt_from_idle() && !user) ||
+		     ((!IS_ENABLED(CONFIG_PREEMPT_RCU) &&
+		       IS_ENABLED(CONFIG_PREEMPT_COUNT)) &&
+		     (preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK)))) {
 			set_tsk_need_resched(current);
 			set_preempt_need_resched();
 		}
-- 
2.31.1


