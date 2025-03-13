Return-Path: <linux-kernel+bounces-559508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 113C7A5F4B5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 13:41:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9641189FE98
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 12:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172012673B6;
	Thu, 13 Mar 2025 12:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="i2Tjh75b"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7470E78F59;
	Thu, 13 Mar 2025 12:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741869679; cv=fail; b=nPpbqGHsuA8m83EITViBj9b+W5dJsDz047tBHxDM839EG+j9HIq8LjS97wpw3doFeDjj7XGqR5C1EeWAvXqHsoyQONsg34gczuMOM70wyzlDHzA23DB3Bfhg/X5YbtYN+WYxx7FLz5WndHbA+H5CLKoKWqkV+5wIU6nTY/Bsn08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741869679; c=relaxed/simple;
	bh=OHnFG+L5al8IDck31Niu1rdsUwTD/LhTuNz+XRTFDGA=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=bE56yqaVwukn4rFcWUqXxGoLDfYxwQ8MgyfUycVFckehqMjcpSoXKahVLSnlDNWXpPOgaGfFNacchLDCzsJuSMpXuFcZYhFkOwHPnAOClDNPr9kXX3u8BX4LLpTtjhDB7Pq3KxWiGrfmPKnlc+Fbp9oLZBF/XulkXDN3rmOWTbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=i2Tjh75b; arc=fail smtp.client-ip=40.107.243.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ysMr2l0CidTThpG8kV8XfceelxEXquQ0GlUqbvYZkJI0EwmJoAnVd+2k30uLS91CYb1bTmJqqmYLoNLnNzfhm2iX1zfYyLKtUPR+IHS8l+6FvF6Bfp2qDWEjUGoOF/ZrZa4Lelihp3Fa1jL4wUgkOYtqb+qL5rRWXPcP5QC3prjxvdTI3q0PNDY1thb08Jcjoja/l1k/B5d7ueUvfHkoO/IT74n89vh6ziyrsoJDdrRx8Qex2Mslh6tMxojtU5AaNAmYP3IfxHvH3y5Jt6+FWobfPEgNoczmeObqCawmyiwcsTPvvb9SnL3UDNa49srf2d+UwQ6r/1oz76CLarQAew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IpGpZWwE6ClOscUad3ws4bxVL5Xn9rIYumTsmKdm3Ws=;
 b=HxhweIGGVgBDezpmsy2PutCvi9AR2WYc32Ww5pF0ytJIn6CZuKIz+1GjuZ71BUH6Pkey7JZBRE2dpD/kIH63OOXKqmTFiF1cxOPHH+hIaS5iPpj95mWYoi7+BcGgPbldAxFcqKlZl+1jWATYnSWzCk8Dv5VHMymYXWvzLFR4/ENd75sSo7ZpEO4gNQrLVFEObcXr166wYsHgeAxWuszmBNibSgMXTT/On3TufM0ULatsiXVsLXGVbl+vUvufqaEc6WJmsT2MH8FD/fXWuLvJvrrwD43zWXNvPH9FspBR7askEFfOEQdiezSQ5QZt08q0hVTqQonV+K3z35Z/4gxYjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IpGpZWwE6ClOscUad3ws4bxVL5Xn9rIYumTsmKdm3Ws=;
 b=i2Tjh75bVT4D611MIN+5kvduYx9VS62sIW23ZPx8TpnvQA/ZEFTI14nhDQ25VU6wrKFeKEdE0cdEzUAevItwU18P93iALv2D9BQ+vyT36Gru9uReJrWEqNF5PcAkwNzRJ4zlpF/Nm8hpIBoMJihKLIJZIvWfPMIYnxW+gjhPVcH3ozJlw4cXVxnoz2VHQt6J2+JWmQz+nRXb/8JO8hRjRc89k99M8VBs8NQUDEquD2J+430BXSVZjFlApGB58ajKKR3X6BrmvKYKishWmMazBUQO7sh4s/uVkEwiptIONmJE9HIHwClTIiOkz/QqYZNq3ypqyvnl6IhGqNMIMgqnkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by IA0PR12MB8086.namprd12.prod.outlook.com (2603:10b6:208:403::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Thu, 13 Mar
 2025 12:41:14 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%6]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 12:41:14 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Thu, 13 Mar 2025 21:40:59 +0900
Subject: [PATCH] rust/revocable: add try_with() convenience method
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-try_with-v1-1-adcae7ed98a9@nvidia.com>
X-B4-Tracking: v=1; b=H4sIAFrS0mcC/23MSw7CIBSF4a00dyyGW1JTHLkP0xjkIXcgGCBo0
 7B3sWOH/8nJt0G2iWyG87BBspUyxdADDwNor8LDMjK9YeTjxAUKVtJ6e1PxTGvpJBoj7icO/f5
 K1tFnp65Lb0+5xLTucsXf+gepyJBN0vFZ6ZlzNJdQyZA66viEpbX2BRH1fn6hAAAA
X-Change-ID: 20250313-try_with-cc9f91dd3b60
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 Danilo Krummrich <dakr@kernel.org>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: TY2PR06CA0048.apcprd06.prod.outlook.com
 (2603:1096:404:2e::36) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|IA0PR12MB8086:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b75059e-e83a-481c-93fd-08dd622c578f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|10070799003|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cy9QbmJldkt1SXN5d1FLeUlGVXRhWVRHUWFCMWRiVks4VFFNNlpyNHgvaFRx?=
 =?utf-8?B?SkJaV2UvMXNPdnRTWUJQaXVpRCtBTC9VMWVSUjF5YnNyNDVXMllIZnA4ZmtK?=
 =?utf-8?B?OEY1MjVPbW10UUZxNzZCaW5uamtVNFpyTDE4YlRyc3BITWhGSjJKQmkveWFH?=
 =?utf-8?B?K1loTXVVWENOMUc4SUxTMisyZmpFc3UvWTNDYlVxMi9FQXI2S2pBTHNBdnYz?=
 =?utf-8?B?QTUvcUx6ZzlGWjhmaWYrUmFvS2hMa1RjcG9KSHFXQzNXejJvOTZhMzcyelpF?=
 =?utf-8?B?dVMwZ2ZGY21ZQjhCWTNPVFBvbWtZNlVTMU44emhWNHpEa200MDNoeXBNbEpi?=
 =?utf-8?B?akg4OWhvZEY5Uk5FaHovVU5JL3k2cjJVWGN6NVQwN1RuTUhBL2I5OG9zUFdv?=
 =?utf-8?B?U1djb01UQ2p3RkNtZ1RXSkk0Nk1wNjZqbXliVHk4cW9qWHFVanRhTWVKR1pk?=
 =?utf-8?B?NE1FeFhKYTFGTmN6MVZyZmxKQTdIWVJrR2Rka3hySjVvMnV0VDVDNVdoTGtK?=
 =?utf-8?B?d3d6emkzZVFlcUgrN1JUNGI1UE1RTzNGL3lxb1JiMFZtdTE2U2pqUjRzcDdH?=
 =?utf-8?B?dFRHVC8xMW9idGFhMXRwRFdQU3Q1akFTU0E1Y0dncGVuVnJFVW5CcFhldDE1?=
 =?utf-8?B?M3hWZGdMclJ2MWl1dllTU2w5ck1wR2dUVXF2Mm9Kc0dySWNtMUlQOE9ZZ0l1?=
 =?utf-8?B?RGxYN1h4TVp2cXJ5Q1hhU3cwc1crL3NwSEtBUjBMdVlaQjdvRFNPUW9RQk9s?=
 =?utf-8?B?Z3VMN3BtL0VsdzFjN2s2VEpIL05EOG9kQVFpVmwzeTd6Zms3cEg0UDZZeWw4?=
 =?utf-8?B?WlFWa3pJQnQyeEhNamFQa1FKNDJXd21DUllyU29ud01wQjNNVnBPUUhBSHhi?=
 =?utf-8?B?VTJZWEVkOU1SbEJxVUlPOFUvcVlEdmdabENqUWlkaXM2WFVLcU5QWDRkL05X?=
 =?utf-8?B?KzM4SW9PUGFtbVQ2NDVEWUFzdUN6V2crUG1lZERSaFZrdVdvK0ZBQmpQL3k3?=
 =?utf-8?B?MWJNWnFodTJscGxncW5KRHVoZ0E2eWRqYW5ycDlkb21mTXh3OVNrZjhZbHZY?=
 =?utf-8?B?YmVxTFhyRFF2SlB4TTlZR2srb1N2ejRVWWE3Z3dQaFoxY0NOdnhIUUpBSFJM?=
 =?utf-8?B?eVJ2L2xRdzNxVFdNeWxWK0NqTDR4OXdZeW5NVEtXYnJTMiswL08rZC9KUHNv?=
 =?utf-8?B?WFZ1b3Bla0ltaVFtMC9sK2pyNU5tSmllVVB5ejMvMFQveVVIa2J1bjRRQ3hQ?=
 =?utf-8?B?MnpHYmhqUFhSdDNzZjdRZitsbDFTOG5ZMlpSa2JJUzVYUnpJWlJLSWlWL0pk?=
 =?utf-8?B?WEpIRE05eTlyQVVOTEIyOHhuNDNCYzgxTzdRWDFMWTZ3NHVVaks0RlFwek03?=
 =?utf-8?B?OFYzdEZ6VEMxaFBFWTA5c2JhSk1vTkpZTm1HdStFaTdCVElhYmdZWkVTK041?=
 =?utf-8?B?ZE9MdmpBM21hU0JUSDU5YzlyQVpzK1QrN1ppWXUvN0s0aFYyclMzVTFWV3BZ?=
 =?utf-8?B?WDJoQnRWejFNR3ZLY09mZTB4cElscEFWODMzclZ1Zk5aTXlqNTNCR015NmQw?=
 =?utf-8?B?eXE2V0ZKVmRKN3FPNG8wMERNUSt6VXJILzV6RkIyd3pCbUcvKytRNlJQZXU3?=
 =?utf-8?B?TkdTU2lheFl1cC9UQkxpVGtqNjVHdVFwYitxTm52enJ0blZzbWRsZ1NpOUM1?=
 =?utf-8?B?SUl2WUswWXd2WUFicTJQODA0V1JHMlh5cUtrclY4dE4xRVRaazNGUTViYW1O?=
 =?utf-8?B?cXlYb2FZMm9CMTNEL3I0ZXRTQTdxQU4ya1ZtdWwxWC9abkVzKzRTdU1EZHY2?=
 =?utf-8?B?Vi9NajN0Wkg4QlduT2xFamJZcXNYb0hJYjlTdDhqcENlRG5tL25sRE5MOHB2?=
 =?utf-8?B?ZDlwMnhicnFNZzZyUG1zMHVXcUE2NVg5Q2F2ZFFqV2Y1NzlIQWtZRFY4a3BV?=
 =?utf-8?Q?lAQEF5prIKY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZG9GcFQ1NnNFZndWK3JoTjBoYlFVNGZuWkx1eWt1ZHdxWTJkMHkzUUVlaE1O?=
 =?utf-8?B?K1FUN0M1YUhkMzZUbGNreHpONFRjTmkyc3liaGl2UEVaNW5jdmxHSTlPbzhM?=
 =?utf-8?B?OTc1Z0JNMXo3MWgrSHFMbzdLSFVOMEorMTlvcDVoS2JjcEVuaHB4QWgwckpa?=
 =?utf-8?B?RTBmZ0czOGVkRStvbkMrdnA4b0w1bVNJYW4wM2xOMzVLSGlKTnBPT3NubVJ4?=
 =?utf-8?B?dWQxUFRodStWK2VRbzhjYmdZRlJHckNNd2dva0RlWGI1ZXJTbHQwZm1tQUk3?=
 =?utf-8?B?bkNVbFVaeVdkUlpoeHFxdXZFejlmckxvMTFPQ1NhWHZHbmxCcWFXVUdMR3lw?=
 =?utf-8?B?QnRNaEp0T1I4SDQ5Vi9NdW1UQ0RqY3d3MG1WQjhjWDF6WVNNNDR4amFXTi9q?=
 =?utf-8?B?anhXUXV5aWc0bEUxZ3k2TmkwSkVubXl1WmU3U2VaMTBiQzVSY0QxQXlCRmIr?=
 =?utf-8?B?WklyVU1Oa0FneTdRVnVMbm5sOURTVC85V3dDOTJyeXRUTHFZdUtLMHFjdzd5?=
 =?utf-8?B?S3R0dGtjeFlmUmlxNHcrR3EwTk91bzZEODJqLzQ5NjVIMUFlcEZUZEl6T1d3?=
 =?utf-8?B?NmpjaTJmMUw3cjlrNmdyeUF4WUF6bGZxRkRlckx4L0dwUVQ3VVVXeW0vajdK?=
 =?utf-8?B?bDI1RUowMHJCZFR0OW1MQzJoM1NKRXFkUkhIbHloL1ZkeDVXSWc5a0lrZEFE?=
 =?utf-8?B?djljOFdKK280MXBTT0R2c2UrMWJ6RFpabWVEQnV5Z3FwcXFYVjFwWi9SdEY0?=
 =?utf-8?B?T2FoclBKZ1RaMk5UYTd0dm14eUR6WWV1SFFLNlYveThoODlJTXdLTWs0U0ls?=
 =?utf-8?B?aEtzNHlsaU01MlR2QWV1cThTOWFXblgzMEJKMFVRY3YyaXEvWGNvQkM4Uk55?=
 =?utf-8?B?L01kK1c4L2FPNUUzdG8wT0tjcVRsQTQ2dDFiYVI5U1dvamU0M0JIQkJKUDBE?=
 =?utf-8?B?ZGdLbHVmSU5NY1lYN2oxbTZLc04vbnI4Y1pVd1hlTHlGak9kcG84TDF5U1pH?=
 =?utf-8?B?ckhkSXRvNUtzeWYvOWcwOGRiMEkwRi91aHJtYmx6eTJ4UzcvWXMvVFpnRXR3?=
 =?utf-8?B?djUxcGcrOUZDMFlqaEFjVUJ6RVNmL2ROQlBHd0k5b2VmUE16V2Q5MGZhdWlU?=
 =?utf-8?B?SnBSUUZnTlpwa2s5VFA1elZlN0h2S0lGeTd3VENUNUtJWHV1QjMvLzl0UGZu?=
 =?utf-8?B?UU45MUpqejliRk1qNTN2RWNwUVlZTk5keTVob3pzV3lNelAwUzJJT1V0NUFI?=
 =?utf-8?B?UW9hNjliK1RVeGVaSW5sTTVnVFNiVkhQK3ZhbGtkd1ExL0xreXBsOXVsTG5Z?=
 =?utf-8?B?U1pXUTEyUlk4UENyS043ZmQzZHZJRVhCbFl5OG5SelNFUXEyMmNITHZzZGtq?=
 =?utf-8?B?ZDJBSzhnK21aZFRmV2ZTUWt6Y2tUSE8wd1pRTEsyY0JjY1BDcWJ3WlpLS3JK?=
 =?utf-8?B?bTJzd3liVDB3UExYeDRMWnBSdWFNVmJvZ296RitJTEFtUTJHb2FWNmxLU3Rq?=
 =?utf-8?B?L3JMRllRMWxlbm9kZmd1RzBMbW55c1ZSR29jUDNMVEcrcFVyUHlYdDlUZG9j?=
 =?utf-8?B?Z0N0emxWbm9wbEg1RFZhaFpQTEpjS0xEQm92WkIwUjRNdHNKMC9WWEpVcW5z?=
 =?utf-8?B?QXM5ZGhJTGJVLzlZdUEzTHljU2o2WmJnY1pTN05YWVZBSExHOWw0czRKMGxL?=
 =?utf-8?B?b1ltdkNSdlAveDhOcTdHWCtEZUdzUmp1QnBCYVlTSUhVaExLMktTUkZmbUpO?=
 =?utf-8?B?QlFxVXp3dTRad0hOeHZKUW52TWhRY05YcFVRQmk1THFESUFIZWVaOG44QVRw?=
 =?utf-8?B?R2RQSXVlTzVDSm1tUExZSmxtVUZiUTlEZ1lsdWZnVjhXR29wOWtKS0d2T3pr?=
 =?utf-8?B?K2hmT3pCRVczVGY5bTIweUNaUVZGb1c5NmUvUUR5RjZDaUYvZURtalN5Q1c0?=
 =?utf-8?B?bTJjZExQWFp5YUpIMVBnYlJZN2YrVzEvY2RkSTk3cUdjc2k5VU5vVlRoM3JB?=
 =?utf-8?B?K3BWbVMyeTJxR2RUVVRkcUVZZzZKQXpOek9IRUVNOXVSQUxzWXB0cnVKZmh3?=
 =?utf-8?B?eE44SUpsK2dJYUxFTjZqZ0FMWVo1YW9vT0wzcFl2dm1wTzYvSkU0Qllpc2lh?=
 =?utf-8?B?VlpDZmlHZUFHR2FtNzhTdGw3WHNYM3Vpby8yMXpRSzVhWDlkaUVHcnpEUFRk?=
 =?utf-8?Q?RY6wEo+LH0LKI6thQNQda7NtMDYwGes0vDYDWmtWdhtb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b75059e-e83a-481c-93fd-08dd622c578f
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 12:41:14.4769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tIRMMjkm3cdBXLmXzEkbTkDfGDxaaF9iQ/wOtkgGAcod+PJ80QOS5nTic1fAu9uKdp/Zr296lfR+C7BLOczJCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8086

Revocable::try_access() returns a guard through which the wrapped object
can be accessed. Code that can sleep is not allowed while the guard is
held ; thus, it is common that the caller will explicitly need to drop
it before running sleepable code, e.g:

    let b = bar.try_access()?;
    let reg = b.readl(...);

    // Don't forget this or things could go wrong!
    drop(b);

    something_that_might_sleep();

    let b = bar.try_access()?;
    let reg2 = b.readl(...);

This is arguably error-prone. try_with() and try_with_ok() provides an
arguably safer alternative, by taking a closure that is run while the
guard is held, and by dropping the guard automatically after the closure
completes. This way, code can be organized more clearly around the
critical sections and the risk is forgetting to release the guard when
needed is considerably reduced:

    let reg = bar.try_with_ok(|b| b.readl(...))?;

    something_that_might_sleep();

    let reg2 = bar.try_with_ok(|b| b.readl(...))?;

Unlike try_access() which returns an Option, try_with() and
try_with_ok() return Err(ENXIO) if the object cannot be acquired. The
Option returned by try_access() is typically converted to an error in
practice, so this saves one step for the caller.

try_with() requires the callback itself to return a Result that is
passed to the caller. try_with_ok() accepts a callback that never fails.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
This is a feature I found useful to have while writing Nova driver code
that accessed registers alongside other operations. I would find myself
quite confused about whether the guard was held or dropped at a given
point of the code, and it felt like walking through a minefield ; this
pattern makes things safer and easier to read IMHO.
---
 rust/kernel/revocable.rs | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/rust/kernel/revocable.rs b/rust/kernel/revocable.rs
index 1e5a9d25c21b279b01f90b02997492aa4880d84f..0157b20373b5b2892cb618b46958bfe095e428b6 100644
--- a/rust/kernel/revocable.rs
+++ b/rust/kernel/revocable.rs
@@ -105,6 +105,28 @@ pub fn try_access(&self) -> Option<RevocableGuard<'_, T>> {
         }
     }
 
+    /// Tries to access the wrapped object and run the closure `f` on it with the guard held.
+    ///
+    /// This is a convenience method to run short non-sleepable code blocks while ensuring the
+    /// guard is dropped afterwards. [`Self::try_access`] carries the risk that the caller
+    /// will forget to explicitly drop that returned guard before calling sleepable code ; this
+    /// method adds an extra safety to make sure it doesn't happen.
+    ///
+    /// Returns `Err(ENXIO)` if the wrapped object has been revoked, or the result of `f` after it
+    /// has been run.
+    pub fn try_with<R, F: Fn(&T) -> Result<R>>(&self, f: F) -> Result<R> {
+        self.try_access().ok_or(ENXIO).and_then(|t| f(&*t))
+    }
+
+    /// Tries to access the wrapped object and run the closure `f` on it with the guard held.
+    ///
+    /// This is the same as [`Self::try_with`], with the exception that `f` is expected to
+    /// always succeed and thus does not need to return a `Result`. Thus the only error case is if
+    /// the wrapped object has been revoked.
+    pub fn try_with_ok<R, F: Fn(&T) -> R>(&self, f: F) -> Result<R> {
+        self.try_with(|t| Ok(f(t)))
+    }
+
     /// Tries to access the revocable wrapped object.
     ///
     /// Returns `None` if the object has been revoked and is therefore no longer accessible.

---
base-commit: 4d872d51bc9d7b899c1f61534e3dbde72613f627
change-id: 20250313-try_with-cc9f91dd3b60

Best regards,
-- 
Alexandre Courbot <acourbot@nvidia.com>


