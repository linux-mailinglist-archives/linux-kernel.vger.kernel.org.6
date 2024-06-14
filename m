Return-Path: <linux-kernel+bounces-214312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF719082A9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 05:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0B5C1F2455D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 03:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319271474B2;
	Fri, 14 Jun 2024 03:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="pz0m6ocL"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2041.outbound.protection.outlook.com [40.107.215.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F73146D75
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 03:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718336992; cv=fail; b=O2Lk+Szj7ldWP0cnV1cscPSEJT+cy9cSYbtPI7FECtm7a3e7KZL+T576WbDiDoOyyoIo8PQ74kKOi1Z5mB7DH/DpzCQ/x3syd7pMaZGNjOOoQtoRRA7Ov8fnIT2YNEIlpYOs4vWgzQ3sJ9bgNFwsi+o6C+JOQ0fYb7XGOTfNYfI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718336992; c=relaxed/simple;
	bh=n02lQPnRS3ZBzq+o/1yrYCtnbspAwOBocWnLjMsYx/w=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=gaLAhA2vhr4DtPOtbDNqXag87kIGfdOajE9SQdugldk6StK9eqcMBXbquX/XlRNy7OXjjgJkaE80ZC+CRornOb3rXpaDIyGcAcrae86KQlwqrq3WGf5BZ1zf9w5ebo9kozWBPHU15qvsI/OOlvOsLeIOBxSKqqG3if3f8nMvMNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=pz0m6ocL; arc=fail smtp.client-ip=40.107.215.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dM3ZzRJAPWFfSdYP7FVr1aZTdotpa0z8B3RabpoBwHkcYZrUK8hi2/0oqC5lXZSJWSlxKA1ox+zpT7wAehkMTz+ugYF0EEcYSFSEx1xNV5jXr3qOALFPmJKsXCUsnbKS/4MiZ0tbZZzHBuke+h1bS8Arb2ZZ/B2g3kxp11MDapxPAul7+7FbzyQsH+UED7gAYqkxfEM6C7bmUWGCn22SmKGWpO6DTNhFMlyRcyDnT6bQ4n2YrKF2lVYgOPdCdKgBxuuDtIreYwd+GhQM9RRZetrhz31tFyyEdk6E5FidAhXj34dymWPdu16Np+JumSOp78Rx2UV8ToQO4+35yoZKpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wbm6yHrtlg0aUB7CL1BjZ6bmiFDwh37V+wS/+T6iAeE=;
 b=jlxlgdYp4Aa8CX2kjfDxH9GtKhwOPvvE+cLvoInJytakY0Nee7nvsEFAU+/zRgavTC8koDBxDDBGYhGumtg5YHMwzy4pwCM4R6oCO7vr1eTpKrOKGjtUF2sqn/HhqpSzsd5UrDLVNBa2B1Tquu34y7SLoHrvMPl7V1pEyvuJo+FX5JK7jNDnEPhh4gmP5AVhmhnGHfjPQ2s5O2GOP2zQfLIyFG9rl+Py8Esl5116IYmXj05nsMJ7KFdNAWJpBJxZ5a4AwQnatmex4ZKT8g/GJRDs21ZMSzBtMXiRBMmpTdse58wGNtmkln1DsS4thJIR4eWxxntbCJkbC0tLqejvZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wbm6yHrtlg0aUB7CL1BjZ6bmiFDwh37V+wS/+T6iAeE=;
 b=pz0m6ocLoVSzZLNyfgh+7yUOMjbTxavpXv2ptf//2z12dYDr3k6u1HRjZkKh861v8K3VgF8a9PHhjXBs7bZHnbn9Pi1qFacGHdiFLPwqmuIY91ntSVhD/W2do1cL6wehNV3tvw2FvyV7Q8UQIyA+OJKdyYEhYbWlTq+XBH7jAyOj3kPFXXQaNAkAB75/MvlwBP+zemdAxyr41XJrkAFCpLbdP975RJU3ElGu2zHn5mDhbzNzmWaT2Gum53TClCvQNSBpx5wNyZU8RavPYq0TS3isOApRqfX9mlPTl00ZDQwyriRNyQZrzXioprEDGYv2lt5TIpO49T0baL594BVIZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5624.apcprd06.prod.outlook.com (2603:1096:101:c8::14)
 by PUZPR06MB5649.apcprd06.prod.outlook.com (2603:1096:301:fe::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25; Fri, 14 Jun
 2024 03:49:43 +0000
Received: from SEZPR06MB5624.apcprd06.prod.outlook.com
 ([fe80::e837:10e3:818e:bdfd]) by SEZPR06MB5624.apcprd06.prod.outlook.com
 ([fe80::e837:10e3:818e:bdfd%5]) with mapi id 15.20.7677.024; Fri, 14 Jun 2024
 03:49:43 +0000
From: Lei Liu <liulei.rjpt@vivo.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>,
	Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Christian Brauner <brauner@kernel.org>,
	Carlos Llamas <cmllamas@google.com>,
	Suren Baghdasaryan <surenb@google.com>,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com,
	Lei Liu <liulei.rjpt@vivo.com>
Subject: [PATCH v2] binder_alloc: Replace kcalloc with kvcalloc to mitigate
Date: Fri, 14 Jun 2024 11:49:30 +0800
Message-Id: <20240614034930.8759-1-liulei.rjpt@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYWPR01CA0020.jpnprd01.prod.outlook.com
 (2603:1096:400:aa::7) To SEZPR06MB5624.apcprd06.prod.outlook.com
 (2603:1096:101:c8::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5624:EE_|PUZPR06MB5649:EE_
X-MS-Office365-Filtering-Correlation-Id: 530df132-1e5b-450e-79a2-08dc8c250666
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230035|1800799019|366011|376009|52116009|38350700009;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RTNUT1hqVG8wNlZLbGtNWlB5TjVzb3E0WTk4SVJZaDhBYWxBbGE2RElZeWZi?=
 =?utf-8?B?S0Mvc3VIL2phOG9JOWl3b3RaalJXVVREY2NVUHNJR1dyVUJUL0FuNUpySTM4?=
 =?utf-8?B?dXRuNmk4aGlISWtLVlBPaWdzZnVzVEM4U2NLU3VhMXBLVzYvTUpwckZKakFI?=
 =?utf-8?B?MzdzTjhoRVRqbk1rMWh3YmVYYmExVXZLdnd6TWFkKzJMVGNLaU8xTEpoaG1r?=
 =?utf-8?B?WUZRRDRQQm5CT1FaZ1JmOFkrUFY4UWp6d1NSZW9QdFkyaXVEZEh3c0xlY2Qr?=
 =?utf-8?B?dXBodzJ4aVVSY1ZFSUVZVTNVRTFqdUVyZy93ZmljOUxoeHpLQUU2UmZzOVk3?=
 =?utf-8?B?Q1BpMGJ5RVM2QjVvSWQ0Q0o3ZEU4djJlTGtnV0xLL1FtYlB0V2JMSi9FZ2NI?=
 =?utf-8?B?c3hzWTdXcEQzYzU4SmRWVEwxSjZTSmdvaGlhcGhMWUFweVNuWFVMMGVqTXJs?=
 =?utf-8?B?NDNnMjM4dms3U2FubjlVWlB2Z0REWVVwNDFUMHBUV2pTNVhUNHpFYkNrd0JB?=
 =?utf-8?B?d0pCQWdveDFUVUpHOHYxVXdCa2phbXFWY3BFdVpHSFRtdlA4Mkx0ajZyb0My?=
 =?utf-8?B?dm5LOWlRTEpQQkxFb0NPdVY3V3g4d2xaUHQxaVRHNkxnMXdKSUxuWmc2aGVu?=
 =?utf-8?B?enRWM2dLQVdDakltTnFydjIzMHdxYi9YdFdvYWZWRy9Sa0tDWk00ZHVFNWo1?=
 =?utf-8?B?bjNpeXZ3ZDdXNG0yK0lWMVBIdkZpK2N1eEtndURqdisvVERub3p3SWU5MjJs?=
 =?utf-8?B?MmVEYUJyMXZoYlZBOWtYMFE3YTZkeHlPY3BrVEJaWEtVRnZUNThRL3N5UVA3?=
 =?utf-8?B?WTJBK3hkZGt6aW5Sc0Z2bi9ZQTJwbW1oZzJmZmoycUZzVHpibUQ5cFpBeHkr?=
 =?utf-8?B?dmtEdldqVUdhdlZzRlU0SHRUeWNveitqaGJTQzQvakorWEdYdDh1NkJjVlRn?=
 =?utf-8?B?K2xhaXRuNk5kemdjdWxEc2dJZXhhSnRZQ3RtVVZ1c1k1eUtaQjBqWWl1WFJT?=
 =?utf-8?B?cEFSMzgxM1lGdXVMWEg0VitxendsYmkvY1IwYjRCZnJ1aVY2L0V2MjJGbVhE?=
 =?utf-8?B?ODlNVGlkTWdNQnhUM25sbXN1enR6YU5aMThNRlZtd2JPQU43cUhPQ2UwaGpU?=
 =?utf-8?B?VUVtRUJMUTR3T3EwdWtiTUFiVHRFWGlkOFZocWNlVFBvaUk4L1BjRHUrbEd6?=
 =?utf-8?B?NkRhTWpHYTN0MDI2K0V0V1k4ekp1Y2ZocE00SFhpUmNXM09YaWwrN3dpK2Fa?=
 =?utf-8?B?RCs4NUVxNlVjam5RVC8vaS8vc3hOQ2drR3YyT215dTVBQ21VRTJkVnFYb0Zj?=
 =?utf-8?B?K2lCeE91YVNra2FZRzlza1VmaGxuNEhDYmIyQlY0ZFZVNUE0cTVTR282UjRY?=
 =?utf-8?B?VDlKSjVIRVA2YXd2ZDczajAxS3lHbzF3ZWZ2SjhDN3gzWDUzenk2a3JNYllT?=
 =?utf-8?B?ejk1MUhVdyszVXVPY092dHhKRERZTHhQK2gvcStQVEE3TkFWRi8xQjZzK21t?=
 =?utf-8?B?QjVydzBsaFJOWmdLRHpUbmlKYnE3aUQveFA0Y2FEWGZHaHNNMERJNkxqUkZW?=
 =?utf-8?B?N0VYb1RYUldhQy90Q3IxbnNFdW1OeTN1NXkwWGw2SFcwR0VPeFNnM21PUGhU?=
 =?utf-8?B?NWdXbE1ieEVJY1J4cWtXUmdRelZQNXJvU0RUMHp4T0tSYkczbmhVc1pvSFp0?=
 =?utf-8?B?bjVCZWxiMFFPNnduZ1V5VTdUNEh3alJiUlh4YTVpUVhHYTZrbERUemFXU3hU?=
 =?utf-8?B?ZFNaaGhQdWhDZFIrZ3NBcFhSZ3R0WXZ3U3YwN1RuSnI0Rm1pSllIcUFnUzNZ?=
 =?utf-8?Q?ToHD3jTP4qW59Kp4tIHJ59gRKdKnrb4v91SGQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5624.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(1800799019)(366011)(376009)(52116009)(38350700009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MDFza0V5cEpQemVFV3d5cVdocHlvUXlxVXBMY01TNExYeUpSTXFjVzZqMWZO?=
 =?utf-8?B?aG1qTEpJN2gxWW1JMDdkUlhSbGFQTENFNjVDcHF6Q0lQVCtUWXJxeG1WOGxi?=
 =?utf-8?B?bnJjYWU2Z0ZJNS9MYysvc2hRVHRSTE9GZUFBMmNhdGtCMWFrOHRVcTlRbHVs?=
 =?utf-8?B?RUVwNmVFOHN0dGJGRzA0V2lKTXJDdUtSTXJteEo2NWNMUmdXeVZkV0tiQzg2?=
 =?utf-8?B?eE5vb1ZLVW1saWdwVXhZME1Fc3pyR2l6aE9vVjkycFRhNFVjZ0dyY3hmZEo4?=
 =?utf-8?B?T2Y4dGU0d0s1cm1zSHRLSEp1MFJCM3BGK2FIcTdRUjhOK2x1Q0ZIb05pVXps?=
 =?utf-8?B?SXVEZ2FjakNIYlNtVDNtTzRnM1NldzE1VTdWdHlxbjV4bTRoQkxYd0pKeXJm?=
 =?utf-8?B?TUpXa0hOTW8zTXVKNWltQkk1RTA4ZTBseHlVMVV6SUI5dGMwalZjbnhOZHNU?=
 =?utf-8?B?L0UycUw2azdxeEV0bDVsSWRWQWp3eTFFOVRSTWp0ZFlSdWdLTmtRakF1Titl?=
 =?utf-8?B?M01kWFZCNjhHY0RBR2M2Y2Y2anNkRHNqVHRycTNkVXJ5UzEwS1FQMHpNcFVt?=
 =?utf-8?B?b0IxZ2VETHBjelJSU0tNU0dtVU1kYkpNYnFHMllPeGx3eHo1OEJUUkNKLzVo?=
 =?utf-8?B?YmVFbFhqcjRCdlRSZkU4eDVEekpiK282amcxVlk2OGluZ3NLa0h1U3NpdWtr?=
 =?utf-8?B?eEw5UEFxN1luZlJBeHRmeVY1N3hNOVh0TUpTbnZhUGtTOWNxRXBJbUtocmhG?=
 =?utf-8?B?c085U3lVREczL3Bld21pWW8vTXc4ZGRFN0FoL3NTVEFTYjhwRDUzb04xVTg1?=
 =?utf-8?B?b2xMOUpTNlBSQkxhY3lPdkFaQXd4ZUpmVktpUDZVa0hsaFk3WkRCT2Qyc3J1?=
 =?utf-8?B?U2dXeUcvdjF6YTZlcXFxSlJ3QmRwV3Y1Mzh0REU3L1dOMVZyN0duME9WWExQ?=
 =?utf-8?B?dTMvdndlWjJzRERwN0VQWjh1bW15SDRjR0Q2NlYrWjlvaXh1WE5kZm1NbWYx?=
 =?utf-8?B?ZXZIQ1NTTllnUUdxV1VVTzk3TjhRRWtDVlJ0dVk5QS9QU1pwWE1lME1jQXIw?=
 =?utf-8?B?V1JpSDlDQ0xhOUlLNlVhY3daU3p2d1JWbGQvZ2dtdjl5UVlHQlRtWGM1OG11?=
 =?utf-8?B?RG45RC92aFQ1d3RwcTZBS3ZLMzNXZmZzL1dWT0crV0tBeVZ2ZGFWaTNER3dR?=
 =?utf-8?B?Uld2UFNkQ21XRUNINC9mSStKZFZGRUY3SFhxRlowVVNlWHJab2FaN3lJckZt?=
 =?utf-8?B?alFRMFJFd1RhQlAyb0t4S2VEZCtlYmJvUGNzMUJmZ1VhVjNacE02azI5b1FN?=
 =?utf-8?B?Z21GRGNLbXhvemdjT1U0YTFBV1NsV1dwT0dBMHBoaFhNQ1RPUjVBd2U0blZG?=
 =?utf-8?B?cFBWUStURWdYdmoxY2VXKzVrWG5QeWF2ZUtxRGtubXFpWkh3NEpzN2tjRXU5?=
 =?utf-8?B?OHIvS2hNK2JTMjlheUhtR2EvYTB1clFpaU85WTFOTnMwTzU2czQrN2MvZFdF?=
 =?utf-8?B?bytaby9adUMzRkhQTGp0N2pSWXZUOTlOMDVYVDBzMVVEcVBkL054OFJKN1FV?=
 =?utf-8?B?ZzZubHZGU2p6N1Z0dE1xa1lVNmZXcXFYWStSRGVkbUNwbk1iY0kyU2pqalNx?=
 =?utf-8?B?SysrRUlmWm1nTDlvU3R6ODhMcFhIai9xQmRpVUxwWC9ZL3k5M3hWcFZsbysz?=
 =?utf-8?B?SStEU0wxVVE4anNxNjZ3ZjBYV1prRm9xSi9SZmZ0eGZMYWEzRXozMlFZYnlq?=
 =?utf-8?B?Q1k1bzRPTFhjUjJvVDRYdnYzeUJpbmZhUjZMT1BRN3hNQnEzc2JZdW9PY0s0?=
 =?utf-8?B?ZjgyemlkY1U3NXFnV1FYNjZDVGw0NDJHcmxxTzhOYmQwSFcxbk1NdjNCcCt3?=
 =?utf-8?B?bmxLZVNTbzVmbUhIRGtiRGduclI0UEdUUnlQVXRKMG1vSXEraFJDbGVKQlMx?=
 =?utf-8?B?TmJRWC95OWdhQXFCOU9UdG1yYndnalEzQmpEQXNWQ0M2alVIazlCVDVlR1Bz?=
 =?utf-8?B?NXA5ak91VFNUd1dNaXd1K2hCS1U2NUF6K0ZaVll6QVBDKzl3YTNYMkJjSDdS?=
 =?utf-8?B?RzNhbFFVSS95eEhWSHlvbXRiczVJcS9kY2Y4M0RxZFJIeDIrbU1DNWNJbnIv?=
 =?utf-8?Q?XPBHdjo4g23xryf0Bw3PmvO6r?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 530df132-1e5b-450e-79a2-08dc8c250666
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5624.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 03:49:43.1095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h10Nusi+xlJDcdwOVXsGYQyaJm1jUiTzCotPC5la7j7V0pZfXKvJ0AlM0uh0YhkowWN2HmR699ixIF5M6f8D/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5649

1.In binder_alloc, there is a frequent need for order3 memory:
allocation, especially on small-memory mobile devices, which can lead
to OOM and cause foreground applications to be killed, resulting in
flashbacks.The kernel call stack after the issue occurred is as follows:
dumpsys invoked oom-killer:
gfp_mask=0x40dc0(GFP_KERNEL|__GFP_COMP|__GFP_ZERO), order=3,
oom_score_adj=-950
CPU: 6 PID: 31329 Comm: dumpsys Tainted: G        WC O
5.10.168-android12-9-00003-gc873b6b86254-ab10823632 #1
Call trace:
 dump_backtrace.cfi_jt+0x0/0x8
 dump_stack_lvl+0xdc/0x138
 dump_header+0x5c/0x2ac
 oom_kill_process+0x124/0x304
 out_of_memory+0x25c/0x5e0
 __alloc_pages_slowpath+0x690/0xf6c
 __alloc_pages_nodemask+0x1f4/0x3dc
 kmalloc_order+0x54/0x338
 kmalloc_order_trace+0x34/0x1bc
 __kmalloc+0x5e8/0x9c0
 binder_alloc_mmap_handler+0x88/0x1f8
 binder_mmap+0x90/0x10c
 mmap_region+0x44c/0xc14
 do_mmap+0x518/0x680
 vm_mmap_pgoff+0x15c/0x378
 ksys_mmap_pgoff+0x80/0x108
 __arm64_sys_mmap+0x38/0x48
 el0_svc_common+0xd4/0x270
 el0_svc+0x28/0x98
 el0_sync_handler+0x8c/0xf0
 el0_sync+0x1b4/0x1c0
Mem-Info:
active_anon:47096 inactive_anon:57927 isolated_anon:100
active_file:43790 inactive_file:44434 isolated_file:0
unevictable:14693 dirty:171 writeback:0\x0a slab_reclaimable:21676
slab_unreclaimable:81771\x0a mapped:84485 shmem:4275 pagetables:33367
bounce:0\x0a free:3772 free_pcp:198 free_cma:11
Node 0 active_anon:188384kB inactive_anon:231708kB active_file:175160kB
inactive_file:177736kB unevictable:58772kB isolated(anon):400kB
isolated(file):0kB mapped:337940kB dirty:684kB writeback:0kB
shmem:17100kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB
writeback_tmp:0kB kernel_stack:84960kB shadow_call_stack:21340kB
Normal free:15088kB min:8192kB low:42616kB high:46164kB
reserved_highatomic:4096KB active_anon:187644kB inactive_anon:231608kB
active_file:174552kB inactive_file:178012kB unevictable:58772kB
writepending:684kB present:3701440kB managed:3550144kB mlocked:58508kB
pagetables:133468kB bounce:0kB free_pcp:1048kB local_pcp:12kB
free_cma:44kB
Normal: 3313*4kB (UMEH) 165*8kB (UMEH) 35*16kB (H) 15*32kB (H) 0*64kB
0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 15612kB
108356 total pagecache pages

2.We use kvcalloc to allocate memory, which can reduce system OOM
occurrences, as well as decrease the time and probability of failure
for order3 memory allocations. Additionally, it can also improve the
throughput of binder (as verified by Google's binder_benchmark testing
tool).

3.We have conducted multiple tests on an 12GB memory phone, and the
performance of kvcalloc is better. Below is a partial excerpt of the
test data.
throughput = (size * Iterations)/Time
kvcalloc->kvmalloc:
Benchmark-kvcalloc	Time	CPU	Iterations	throughput(Gb/s)
----------------------------------------------------------------
BM_sendVec_binder-4096	30926 ns	20481 ns	34457	4563.66↑
BM_sendVec_binder-8192	42667 ns	30837 ns	22631	4345.11↑
BM_sendVec_binder-16384	67586 ns	52381 ns	13318	3228.51↑
BM_sendVec_binder-32768	116496 ns	94893 ns	7416	2085.97↑
BM_sendVec_binder-65536	265482 ns	209214 ns	3530	871.40↑

kcalloc->kmalloc
Benchmark-kcalloc	Time	CPU	Iterations	throughput(Gb/s)
----------------------------------------------------------------
BM_sendVec_binder-4096	39070 ns	24207 ns	31063	3256.56
BM_sendVec_binder-8192	49476 ns	35099 ns	18817	3115.62
BM_sendVec_binder-16384	76866 ns	58924 ns	11883	2532.86
BM_sendVec_binder-32768	134022 ns	102788 ns	6535	1597.78
BM_sendVec_binder-65536	281004 ns	220028 ns	3135	731.14

Signed-off-by: Lei Liu <liulei.rjpt@vivo.com>
---
Changelog:
v1->v2:
1.The call stack for the OOM error during the stress test on a phone
with an additional 4GB of memory.
2.Corrected the error in the title of the test data table.
---
 drivers/android/binder_alloc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index 2e1f261ec5c8..5dcab4a5e341 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -836,7 +836,7 @@ int binder_alloc_mmap_handler(struct binder_alloc *alloc,
 
 	alloc->buffer = vma->vm_start;
 
-	alloc->pages = kcalloc(alloc->buffer_size / PAGE_SIZE,
+	alloc->pages = kvcalloc(alloc->buffer_size / PAGE_SIZE,
 			       sizeof(alloc->pages[0]),
 			       GFP_KERNEL);
 	if (alloc->pages == NULL) {
@@ -869,7 +869,7 @@ int binder_alloc_mmap_handler(struct binder_alloc *alloc,
 	return 0;
 
 err_alloc_buf_struct_failed:
-	kfree(alloc->pages);
+	kvfree(alloc->pages);
 	alloc->pages = NULL;
 err_alloc_pages_failed:
 	alloc->buffer = 0;
@@ -939,7 +939,7 @@ void binder_alloc_deferred_release(struct binder_alloc *alloc)
 			__free_page(alloc->pages[i].page_ptr);
 			page_count++;
 		}
-		kfree(alloc->pages);
+		kvfree(alloc->pages);
 	}
 	spin_unlock(&alloc->lock);
 	if (alloc->mm)
-- 
2.34.1


