Return-Path: <linux-kernel+bounces-569766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 758C7A6A73E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 14:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C738D7AA0BA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 13:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C0E221D86;
	Thu, 20 Mar 2025 13:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WKBXp5Bh"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2070.outbound.protection.outlook.com [40.107.100.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787EB21B9D3;
	Thu, 20 Mar 2025 13:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742477731; cv=fail; b=pRd8XlffwBdMJHUWpRz8vBicNS+FpR6/PGFGbRW0nJoT/F76LsyAEbcouYwBfRPKHCS4eDmqEE/Nk8lXKNfnovnrLV14UZGmvu8V2M2NXJ+nQ0T0tgUQ1aYZ6tErx9xdkt8hnb1jFaBvx/n8LAy+g0Bq2NnID17QwPXR53B2OWg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742477731; c=relaxed/simple;
	bh=Sjgp1dmQVRBciWTINlIqPFzBOWxXCIe2KJpg6PpAWd8=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=RBt60o9+sTbcx3PNpW56HlWg+wxWXzPrPMgkpSxSQWtUnoSrTRS6E7wWsSUPqXZ7h+X8OhiejqLa1DRC98lf+pu+pLbF3H2A66OyLNAQHKGgc3TBK81uUqWEmk9Rh3LrgOqBEdtg1T6vb4DB4bF5QcKfyWl+1NRjAVkTI8T/k+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WKBXp5Bh; arc=fail smtp.client-ip=40.107.100.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=muffJi33AKUoCqgdefT1DTXJFzUaQ6QOlfovL7xqBIS39YNSah0lRQmpQcjWxB5uwohICWe7d0oAYynYsenn5tVmTR7hpXBLl3siDffaijQPmUyC1ELsowvjX2jcPqF1He14pcb9mSAj7YKHjt+vC9DHDxmkTtyR/SsixW7ziA2tESOjEEQXkdsydyIfNRFXuiQ0lRqimw0H+UUVlYBls8IU9myESk4eq0jvAqrAg8EOL91haYvtvdjHtuQ/T1rMvv0XB/FusoZ/5imAKEBfun0r9JFxD26BElF+QaekVbJewQ7o6uARkkf7+ec257vIK8GA4ZLwNORZhAFiieQczw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XI8D7kl6BHk7qy8XlFYRD3ea21wnBWqN5k8EGroWgAw=;
 b=xnfc+S9FzB63+afwqRZguSPtEKoTugwR919QXKbmfbk/gp8iv4dRAywz1/N38VBoyTGkk/1tdolcvEmJmkx4d13bz6nz5EkZp1fH5YwWotC2GS1imUZNdu+9xhxNJDl22fr2KzkqxVomq96ltrZkAR/ZINeGHNBl3o66x7/rdIHzP42fYBXCcPJrGbBoR0vzbpY2tzWsSxrzC7tzILlvd1mXvCOlCY1c98B58PJXzrxN6lbhJTlgEIOAzG4w2Xpza6XbUjOm3nsRCOsX6Rt2oc/pzEL42udPdGIpUO/qHfzg+HurVSRUXxAD9Pa5MVsaGwnETHapmZO8pN8UmpK6Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XI8D7kl6BHk7qy8XlFYRD3ea21wnBWqN5k8EGroWgAw=;
 b=WKBXp5Bh7ndPC6/s21/weNEE31J5TqFD8Ue1cfSyJbmTCL+DeEukmPPuIST3CWiJWfbriqFJTWxzFx0d5DgX1caYniwiIi8uc7DqtEhcBJyGz/NAfUzeTZKnW7MJSrMW8g6ls5RESFkBgYucV+Sfl/gYOp53jufCB8h52H7YVhQ25x9GPpMYxqCjbM6AoyiP/oz2uqaje03B50+ui5KA0QrEPvWY//ZBwLbc8uFCP0T7W8LgF7sbRpnYtdnYzPfbAf4dw6HmMLlKiOY31zUWw8Aaslth9kTES0r3ywFJ/ccngwvjV5km7yadoWBedctwxLAJt/a4j7ZowXUv02VdOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SA1PR12MB9001.namprd12.prod.outlook.com (2603:10b6:806:387::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.36; Thu, 20 Mar
 2025 13:35:25 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%6]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 13:35:24 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Date: Thu, 20 Mar 2025 22:35:09 +0900
Subject: [PATCH RFC v2] rust: add macros to define registers layout
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250320-registers-v2-1-d277409bcde8@nvidia.com>
X-B4-Tracking: v=1; b=H4sIAIwZ3GcC/23OTW7DIBCG4atYrIuFB/wTq6pyjyoLDGMbJQZ3c
 FGrKHcvjit10+WHhlfPnUUkh5H1xZ0RJhdd8HnAS8HMrP2E3Nm8GQiohawkJ5xc3JAib0drBml
 P0AyC5fuVcHRfz9b7Je853wX6fqZTtb/+V0kVr3hn1amrZYvdAGefnHW6NGFhl8fRJfz4zLTti
 P/JMlSAqgRIvoXVGb5qv82BeA5P6Bcdr3zUg6lbOeKoZJ/ULl0wRv0beD1MogEAKZsSpOogk6y
 +0vmK5PFWBpre9n+Djsiza3FbX6SmrBQnU2fl4weuoRIiSAEAAA==
X-Change-ID: 20250313-registers-7fdcb3d926b0
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: TYWP286CA0031.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:262::19) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SA1PR12MB9001:EE_
X-MS-Office365-Filtering-Correlation-Id: 7aeccd79-2bf3-42a4-8675-08dd67b41134
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SEoySVVrNmtScXFLdThMckV4LytRak1YZVZXWis3ZHdjQ1o2Rm9Jamk0UmZY?=
 =?utf-8?B?VlVRNTVOdTBpRjZ0UzdJSVg5cnRsWVVNWVFBR0RMREhYcWtGVWVKTGQxeDdT?=
 =?utf-8?B?UjJ6RXdNUHo1SXVrNFg4U2laZGlWSHpZOFp2NWhsV0trZG96NXRGbmM2UnhZ?=
 =?utf-8?B?TUpjN00wWVJFS1JKNHA3RmtVcm5aNG10NXVOYTVvOXFkRk40UDBUVy9GdGVn?=
 =?utf-8?B?MTkrOElEYzdUVjcvMjRUdHlacS9LYmU0QVhEQTlYZi82N3NrQ1JhaWtmZ1hr?=
 =?utf-8?B?Z0czUDcrVnRvTnMrV1Y4eURlOTYvZXh0VDJiQXNpWTZOYUx4NHJmU1NSTFJB?=
 =?utf-8?B?a2F4alRWK1hlYm1hdnQ2SzM5WVdweWxPZ1RmR2RTYURYTHNCYVVJWXhITTQv?=
 =?utf-8?B?VHZDcm1QQnJ6aW5tT3Y4S21NRVptcG9MMUsyQ3dLWXd1N3ZvRHBob2lBc2ZR?=
 =?utf-8?B?SnlPQ01hRURKRXlzVEcyMllWaVVzWHptUmlmQlBFcFZoOElyRW9uREVGTnFV?=
 =?utf-8?B?aWFqREkrUGFTZWNvVHZMbnRwTUNiUWZTTkRsSno0R3MzaG5pYjk4K0hUbHNC?=
 =?utf-8?B?dldnZm5vNzRrbVA3U0JPNHhsV1JYT3dGRUE0KzErN0ZaM0llQlduTXV3NS9L?=
 =?utf-8?B?Nis4dS9JY0NKbWpLUEJhMjc5SXpiWTZISjZnVjZhTDlVMENNSlRjUkRuTnRL?=
 =?utf-8?B?OGlzZjkyZnZHVzlFTHZqWFJqNzlzUXBVUlZrckozZTVCOGwxb3NLcGM4b0Vk?=
 =?utf-8?B?TjF0dlJsY0pGMmlBbmtRNyt1a0JTR251UFNkZEc0YzJjMHhucHFaczNydEVN?=
 =?utf-8?B?elZHbHl5QW04VjRSTktoTGIvcjk5YU9KaVlidlZqZnVmZHBGUGVpQkZXbjNj?=
 =?utf-8?B?K1UxVE1nUFY1dEk4dTdSUVdDSEJKQXZHZVNLVUhPdGJlb3VZMnlPdWxwQVBV?=
 =?utf-8?B?ZFV0WGpVQTJ6UlhCU2g0aVB4NXliRUI4NGxab0lBSVQ2c3BqbWUrNFZ2SmlB?=
 =?utf-8?B?Yzh1WTVUM1FxWFpDSHJOTjB0QWhOL0FZZUh3bHZRSmVHR01wZXpXUlZqeXBu?=
 =?utf-8?B?VUJiV3FsMTdENG9LQmxvT1ZLT1RvMy9OK0szNmFVMVgwbmhrbG90a0ttYkFw?=
 =?utf-8?B?WDNuUHo2UzNXQTRGWUcwTzhOL1lSQk5YYW1CZ09VWTU3cDBMZ0Z5b3ZZUi9x?=
 =?utf-8?B?dG5FTms3alY2b1RoQ1RUWHgvQkZZckxrVVhHd1A2MVhFQ1kzaTFkVFdlVmJ6?=
 =?utf-8?B?MlNLdllHeHNCUk5qNkVCOFFqZzBLTEFzOGJjOXhVWVM0QmVGMk5pTVg1TFhZ?=
 =?utf-8?B?T24xN2ZGZUkrTnR5TnhWNVRQdzVjWUlZMGhvTXY1SWc1VWRQdWFCb0pTOVBh?=
 =?utf-8?B?NWd0YStmQnlQWTdhWEFEVjA2cHJKai9PcE9RWmw2WkJOdWV5K2hERlhYZ2My?=
 =?utf-8?B?ZFpzNkt1Yi9kWjZqZWZiVHhOMmIxZUpKbnVSOU94MjNiNGs3ZXVYR3djNkw0?=
 =?utf-8?B?aWl5SzRxNERKTExrTzgvNVdBaHJmY0hrTHlCRG5FaXhNd2p3Uk5kUTM4Mk82?=
 =?utf-8?B?VkhMRkNpcFdYeHNabmRSTmFBMTRJYy9TWkI1WVNuRlR0Qzg2NHVPQU1uMDJi?=
 =?utf-8?B?YXRBUjg5WlVRR1p5ditucFJZMUYrNFpKNFk3cmUzaG83eVJtMGU5ZDZETzl4?=
 =?utf-8?B?NmRISTRPWktNcTVmaWU5VWZXVkhZdlU1dCtSYkZxenlzS3JnSFBOZkFBMWdt?=
 =?utf-8?B?a3F0U2NxaXIxVTZ4U3ZBMERMTm1iSUgvMmxuRkswRk1JYlpDcHJ0dmVoeEVw?=
 =?utf-8?B?dkcrRTJ6V0RscGlDVXJDaE41VUU0cU5Nc1hHeEJITUFVNC90eWpOMFZabWo4?=
 =?utf-8?B?aDgrNFRtbDhXMlJlYjhKSHdZb1RaWFg3QXBtcEptRGp3K003YjNKTEtIQjZH?=
 =?utf-8?Q?XoPwhaZ9CHI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZVd4WDJXRnNDeG9xVVd3aU0zMjU1UnZORCt2VUpaaGZONWEvMGthMGJLNjIy?=
 =?utf-8?B?a3dLRFJDQ3UvdklZNVpMa0pOdmNpWkswSkZVLy9PTCs2bmxLc2VkUnZ5cTVp?=
 =?utf-8?B?R2x4eWY2NGxhWG1zcEZjZHhYOS9PMXhGdUIrKzBvSDhuU3hOaUNseDVQb1V6?=
 =?utf-8?B?VkZpWTRqcDg0aEZsMHNrazN0MU44SDBJaWJLNTQxcjlnanA0MVpXd0I1b2d2?=
 =?utf-8?B?a2xtZlJVdmNvUkZweWowSjJhRVFjR2tJUzFML0d2WnZFcnpreUNhRlBiM3BG?=
 =?utf-8?B?Ui9ETThKM0pWSVVoaW1Tc2xpTzBhOVZqYWN1N004UUJGSTExNk80akZ0bVlI?=
 =?utf-8?B?RmNsTUlkNnhaV0kzc2pBUHBOL2hLT21uWDV1eDZHWThHZmNaKzQ5M0hZUlFa?=
 =?utf-8?B?V1N3K2M0d05JM2ZQcHA0ZzIxT0dJVmpid0QzcnRIQVBoMUF1NHMvTVNrcm9R?=
 =?utf-8?B?TUtRd25CMHRTaVRkVW1wREEzdjRFR2RPQ2N3SHFqNW5Tb3NPamxVUXZMcHJY?=
 =?utf-8?B?NzFVWmRjelRlNHNnTWdJVTlIV1dqWTFQOGdaVVI5OVpWMVA0UlJKUmlZNEZI?=
 =?utf-8?B?azRWdjhGcmZocXdMMGUzVjJDZUpKL3lWY2E2WjRicWNGWWlrUWFYVUQyT2ZK?=
 =?utf-8?B?Mnc5S093YzVzMkRlVk5tUWJFZkRJUHd3aDF2blFlRDNNM0JZTnFTLzg5TU1I?=
 =?utf-8?B?VlNCRkNqZmR0eWdpdG4yNVM3TFM3WDFlb3lzYW1helFPTUZpb2JXS3kwRXpl?=
 =?utf-8?B?MjAvaS9GVE1NZUV2cFFtcFJyZVNGTWpqR01PTUExMnZiOHNrdmEzMk5Fak1O?=
 =?utf-8?B?N0hDVXhvZ0h6Nk96c21mdmNReWZmdWJJRnJ2SWFvU0hicDdINDBzRFA4OHlT?=
 =?utf-8?B?NnlycXRBRW5pRkZRWDRJMGtiakVjb0lSR0VwVlhYRGpWZXdLeG54cTFkdmly?=
 =?utf-8?B?NUZ3OFUyWDlnaWRtT2k2ZTVvaGRNRDBsbmV5bDJpK3JkVWhnRG9KcFlMOS83?=
 =?utf-8?B?UldXYlRLcWhkaUdaRGtRMUNFSEx2aFVNUEVwc0FOUUc2VjRneTY0VXppM2dW?=
 =?utf-8?B?cUVBZlJiY0RoZGY1TWJML1JSZzQwbzdzcXZKT1JPVzBNVkFSWnllQ0dTY1lq?=
 =?utf-8?B?TWtIZkpHL0p6cVg2aWc1akpTeG5mdk1UQlNqZWErR0FLZytCcnFreU9zQW8y?=
 =?utf-8?B?TlJFdmxjWm4vS0hxWEdJMmFacmxxUjcwN2hlWElsdkdyd3NGRCt2eWZpOXcv?=
 =?utf-8?B?STJJRHRlbEdpNndkejRoRWVZZGEwYUZZQXhTeGZsLzcxNEhqT2lvcE9hK280?=
 =?utf-8?B?ZlNpdm82VURHbGczeDg1K0pCMFM0ZXBoU0hEZEp1Nkk4akZSdFQwdnRSOTlH?=
 =?utf-8?B?bHB3OW9OZURZdGRFYnJyTkM1dnRKdStNTTlRRU1JWVFETEtOOThXcEdrNjM0?=
 =?utf-8?B?aHp3WXBtU1dJSUdMQXpuL0R3eTRkMHZOUmFMNnRKS2FpTkV2SldkbkNHOTR2?=
 =?utf-8?B?RzNQdXZXbGdvMzQ5elpMVHdQOThkOElzYkpXWFg5T1JZbGM1N3RkUXI3Mk15?=
 =?utf-8?B?anNNcHlrY1JRRFZrMG03TnJQZ1B1bHpVekNpUmROQXJZdWlLeW5sSCtyWGxS?=
 =?utf-8?B?SFhUOUNEcGtSY3pNamdJZmw1dXBESGpTeCt0cXZMQnVJWnR2TU45L3ZQQVc1?=
 =?utf-8?B?WXM1REFSbzVNTHhHdVg3bk5ZSENqaENkanJJSjJXbVpjc0dScDRYWDcwUEZT?=
 =?utf-8?B?dUZnRThTMkVSNUpwdklaWnhhVkgvdVN3RlVUSDYrV1loM3hCZWpOb1FvaWpo?=
 =?utf-8?B?UTBiWnVUd2dZODVGK0FsZ21yN21HUGJIbFViTlNqUW54cnRCZVVjdHkyVDF3?=
 =?utf-8?B?YzYwTTRVYlNKd2pwMVRZbW03b3JkSlJTT0Ixd0czK3ArUmpyL2F2b0ZlSG42?=
 =?utf-8?B?dkhHb1A0YUNaWmJ3TVEwQWN4ZHprZjREWWNyUlpkbEUyeDVrOWcvNDJkT0Zy?=
 =?utf-8?B?VkhSYWYvMzB3K0V2RHNSVVdEcy9xZnNLckxycnpwSStqYSsweFZZaVRuSk9L?=
 =?utf-8?B?OXIvUVJmeGE0L0I4dDA4Um1qYjdhRTRmK1BGdXNuWGJ0dTVyeHVYRkE5VUM1?=
 =?utf-8?B?NWI3VHFQT1V2OTlseTR3Q3YyL2NTd2U5T0tWQ1NMQ1ZuZUIvNkhyeUVQVXpW?=
 =?utf-8?Q?baqK/SjqEPtlaHjmA7rPYooT5VMspBgJ9rA35YDdn5yd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aeccd79-2bf3-42a4-8675-08dd67b41134
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 13:35:24.3661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FAUujoUFlgB4L2OaV0bioTfah7UqNjxg47YLYXUsLNc+LflwHr8R9WFjWwwcBP3iioa8q3dvwna4Oyn3gYQPEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9001

Add two macros, register!() and register_rel!(), that define a given
register's layout and provide accessors for absolute or relative
offsets, respectively.

The following example (taken from the rustdoc) helps understanding how
they are used:

    register!(Boot0@0x00000100, "Basic revision information about the chip";
        3:0     minor_rev => as u8, "minor revision of the chip";
        7:4     major_rev => as u8, "major revision of the chip";
        28:20   chipset => try_into Chipset, "chipset model"
    );

This defines a `Boot0` type which can be read or written from offset
`0x100` of an `Io` region. It is composed of 3 fields, for instance
`minor_rev` is made of the 4 less significant bits of the register. Each
field can be accessed and modified using helper methods:

    // Read from offset `0x100`.
    let boot0 = Boot0::read(&bar);
    pr_info!("chip revision: {}.{}", boot0.major_rev(), boot0.minor_rev());

    // `Chipset::try_from` will be called with the value of the field and
    // returns an error if the value is invalid.
    let chipset = boot0.chipset()?;

    // Update some fields and write the value back.
    boot0.set_major_rev(3).set_minor_rev(10).write(&bar);

    // Or just update the register value in a single step:
    Boot0::alter(&bar, |r| r.set_major_rev(3).set_minor_rev(10));

Fields are made accessible using one of the following strategies:

- `as <type>` simply casts the field value to the requested type.
- `as_bit <type>` turns the field into a boolean and calls
  <type>::from()` with the obtained value. To be used with single-bit
  fields.
- `into <type>` calls `<type>::from()` on the value of the field. It is
  expected to handle all the possible values for the bit range selected.
- `try_into <type>` calls `<type>::try_from()` on the value of the field
  and returns its result.

The documentation strings are optional. If present, they will be added
to the type or the field getter and setter methods they are attached to.

Suggested-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
I have written these initially for the nova-core driver, then it has
been suggested that they might be useful outside of it as well, so here
goes.

I have considered as suggested to turn these into a single procedural
macro, but could not even get even the basics to parse properly yet -
procedural macros are not easy to begin with, but kernel procedural
macros are also different from user-space ones, making it all the more
difficult. I will keep looking into it but wanted to post a new revision
meanwhile, since it is used by my next nova-core series revision.

The following things needs to be improved before we can remove the [RFC]
flag:

- Inner types other than `u32` need to be supported - this can probably
  just be an extra parameter of the macro.
- The syntax can certainly be improved. I've tried to some with
  something that makes the register layout obvious, while fitting within
  the expectations of the Rust macro parser, but my lack of experience
  certainly shows here.
- We probably need an option to make some fields or whole registers
  read-only.
- The I/O offset and read/write methods should be optional, so the
  layout part can be used for things that are not registers.
- The visibility of the helper macros is a bit of a headache - I haven't
  found a way to completely hide them to the outside, so I have prefixed
  them with `__` for now. Using a procedural macro should help with
  that too.

Dependencies:

- [1] https://lore.kernel.org/rust-for-linux/20250318-topic-panthor-rs-genmask-v4-1-35004fca6ac5@collabora.com/
- [2] https://lore.kernel.org/rust-for-linux/20250306222336.23482-1-dakr@kernel.org/
---
Changes in v2:
- Moved to the io module.
- Rename the macros to "register!()" and "register_rel!()".
- Properly clear field in setter methods.
- Use the genmask macros from [1].
- Add "alter" and "try_alter" methods to modify a register's content
  using a closure.
- Link to v1: https://lore.kernel.org/r/20250313-registers-v1-1-8d498537e8b2@nvidia.com
---
 rust/kernel/io.rs          |   2 +
 rust/kernel/io/register.rs | 305 +++++++++++++++++++++++++++++++++++++++++++++
 rust/kernel/reg.rs         |   2 +
 3 files changed, 309 insertions(+)

diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index d4a73e52e3ee68f7b558749ed0108acde92ae5fe..acecbf196be1751c9de7bc50dc47b213f9ba2362 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -7,6 +7,8 @@
 use crate::error::{code::EINVAL, Result};
 use crate::{bindings, build_assert};
 
+mod register;
+
 /// Raw representation of an MMIO region.
 ///
 /// By itself, the existence of an instance of this structure does not provide any guarantees that
diff --git a/rust/kernel/io/register.rs b/rust/kernel/io/register.rs
new file mode 100644
index 0000000000000000000000000000000000000000..14eac88677f57ca92b80f50d03cee535ab685f07
--- /dev/null
+++ b/rust/kernel/io/register.rs
@@ -0,0 +1,305 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Types and macros to define register layout and accessors.
+//!
+//! A single register typically includes several fields, which are accessed through a combination
+//! of bit-shift and mask operations that introduce a class of potential mistakes, notably because
+//! not all possible field values are necessarily valid.
+//!
+//! The macros in this module allow to define, using an intruitive and readable syntax, a dedicated
+//! type for each register with its own field accessors that can return an error is a field's value
+//! is invalid. They also provide a builder type allowing to construct a register value to be
+//! written by combining valid values for its fields.
+
+/// Helper macro for the `register` macro.
+///
+/// Defines the wrapper `$name` type, as well as its relevant implementations (`Debug`, `BitOr`,
+/// and conversion to regular `u32`).
+#[macro_export]
+macro_rules! __reg_def_common {
+    ($name:ident $(, $type_comment:expr)?) => {
+        $(
+        #[doc=$type_comment]
+        )?
+        #[repr(transparent)]
+        #[derive(Clone, Copy, Default)]
+        pub(crate) struct $name(u32);
+
+        // TODO: should we display the raw hex value, then the value of all its fields?
+        impl ::core::fmt::Debug for $name {
+            fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
+                f.debug_tuple(stringify!($name))
+                    .field(&format_args!("0x{0:x}", &self.0))
+                    .finish()
+            }
+        }
+
+        impl core::ops::BitOr for $name {
+            type Output = Self;
+
+            fn bitor(self, rhs: Self) -> Self::Output {
+                Self(self.0 | rhs.0)
+            }
+        }
+
+        impl From<$name> for u32 {
+            fn from(reg: $name) -> u32 {
+                reg.0
+            }
+        }
+    };
+}
+
+/// Helper macro for the `register` macro.
+///
+/// Defines the getter method for $field.
+#[macro_export]
+macro_rules! __reg_def_field_getter {
+    (
+        $hi:tt:$lo:tt $field:ident
+            $(=> as $as_type:ty)?
+            $(=> as_bit $bit_type:ty)?
+            $(=> into $type:ty)?
+            $(=> try_into $try_type:ty)?
+        $(, $comment:expr)?
+    ) => {
+        $(
+        #[doc=concat!("Returns the ", $comment)]
+        )?
+        #[inline]
+        pub(crate) fn $field(self) -> $( $as_type )? $( $bit_type )? $( $type )? $( core::result::Result<$try_type, <$try_type as TryFrom<u32>>::Error> )? {
+            const MASK: u32 = ::kernel::bits::genmask_u32($hi, $lo);
+            const SHIFT: u32 = MASK.trailing_zeros();
+            let field = (self.0 & MASK) >> SHIFT;
+
+            $( field as $as_type )?
+            $(
+            // TODO: it would be nice to throw a compile-time error if $hi != $lo as this means we
+            // are considering more than one bit but returning a bool...
+            <$bit_type>::from(if field != 0 { true } else { false }) as $bit_type
+            )?
+            $( <$type>::from(field) )?
+            $( <$try_type>::try_from(field) )?
+        }
+    }
+}
+
+/// Helper macro for the `register` macro.
+///
+/// Defines all the field getter methods for `$name`.
+#[macro_export]
+macro_rules! __reg_def_getters {
+    (
+        $name:ident
+        $(; $hi:tt:$lo:tt $field:ident
+            $(=> as $as_type:ty)?
+            $(=> as_bit $bit_type:ty)?
+            $(=> into $type:ty)?
+            $(=> try_into $try_type:ty)?
+        $(, $field_comment:expr)?)* $(;)?
+    ) => {
+        #[allow(dead_code)]
+        impl $name {
+            $(
+            ::kernel::__reg_def_field_getter!($hi:$lo $field $(=> as $as_type)? $(=> as_bit $bit_type)? $(=> into $type)? $(=> try_into $try_type)? $(, $field_comment)?);
+            )*
+        }
+    };
+}
+
+/// Helper macro for the `register` macro.
+///
+/// Defines the setter method for $field.
+#[macro_export]
+macro_rules! __reg_def_field_setter {
+    (
+        $hi:tt:$lo:tt $field:ident
+            $(=> as $as_type:ty)?
+            $(=> as_bit $bit_type:ty)?
+            $(=> into $type:ty)?
+            $(=> try_into $try_type:ty)?
+        $(, $comment:expr)?
+    ) => {
+        kernel::macros::paste! {
+        $(
+        #[doc=concat!("Sets the ", $comment)]
+        )?
+        #[inline]
+        pub(crate) fn [<set_ $field>](mut self, value: $( $as_type)? $( $bit_type )? $( $type )? $( $try_type)? ) -> Self {
+            const MASK: u32 = ::kernel::bits::genmask_u32($hi, $lo);
+            const SHIFT: u32 = MASK.trailing_zeros();
+
+            let value = ((value as u32) << SHIFT) & MASK;
+            self.0 = (self.0 & !MASK) | value;
+            self
+        }
+        }
+    };
+}
+
+/// Helper macro for the `register` macro.
+///
+/// Defines all the field setter methods for `$name`.
+#[macro_export]
+macro_rules! __reg_def_setters {
+    (
+        $name:ident
+        $(; $hi:tt:$lo:tt $field:ident
+            $(=> as $as_type:ty)?
+            $(=> as_bit $bit_type:ty)?
+            $(=> into $type:ty)?
+            $(=> try_into $try_type:ty)?
+        $(, $field_comment:expr)?)* $(;)?
+    ) => {
+        #[allow(dead_code)]
+        impl $name {
+            $(
+            ::kernel::__reg_def_field_setter!($hi:$lo $field $(=> as $as_type)? $(=> as_bit $bit_type)? $(=> into $type)? $(=> try_into $try_type)? $(, $field_comment)?);
+            )*
+        }
+    };
+}
+
+/// Defines a dedicated type for a register with an absolute offset, alongside with getter and
+/// setter methods for its fields and methods to read and write it from an `Io` region.
+///
+/// Example:
+///
+/// ```no_run
+/// register!(Boot0@0x00000100, "Basic revision information about the chip";
+///     3:0     minor_rev => as u8, "minor revision of the chip";
+///     7:4     major_rev => as u8, "major revision of the chip";
+///     28:20   chipset => try_into Chipset, "chipset model"
+/// );
+/// ```
+///
+/// This defines a `Boot0` type which can be read or written from offset `0x100` of an `Io` region.
+/// It is composed of 3 fields, for instance `minor_rev` is made of the 4 less significant bits of
+/// the register. Each field can be accessed and modified using helper methods:
+///
+/// ```no_run
+/// // Read from offset 0x100.
+/// let boot0 = Boot0::read(&bar);
+/// pr_info!("chip revision: {}.{}", boot0.major_rev(), boot0.minor_rev());
+///
+/// // `Chipset::try_from` will be called with the value of the field and returns an error if the
+/// // value is invalid.
+/// let chipset = boot0.chipset()?;
+///
+/// // Update some fields and write the value back.
+/// boot0.set_major_rev(3).set_minor_rev(10).write(&bar);
+///
+/// // Or just update the register value in a single step:
+/// Boot0::alter(&bar, |r| r.set_major_rev(3).set_minor_rev(10));
+/// ```
+///
+/// Fields are made accessible using one of the following strategies:
+///
+/// - `as <type>` simply casts the field value to the requested type.
+/// - `as_bit <type>` turns the field into a boolean and calls `<type>::from()` with the obtained
+///   value. To be used with single-bit fields.
+/// - `into <type>` calls `<type>::from()` on the value of the field. It is expected to handle all
+///   the possible values for the bit range selected.
+/// - `try_into <type>` calls `<type>::try_from()` on the value of the field and returns its
+///   result.
+///
+/// The documentation strings are optional. If present, they will be added to the type or the field
+/// getter and setter methods they are attached to.
+#[macro_export]
+macro_rules! register {
+    (
+        $name:ident@$offset:expr $(, $type_comment:expr)?
+        $(; $hi:tt:$lo:tt $field:ident
+            $(=> as $as_type:ty)?
+            $(=> as_bit $bit_type:ty)?
+            $(=> into $type:ty)?
+            $(=> try_into $try_type:ty)?
+        $(, $field_comment:expr)?)* $(;)?
+    ) => {
+        ::kernel::__reg_def_common!($name);
+
+        #[allow(dead_code)]
+        impl $name {
+            #[inline]
+            pub(crate) fn read<const SIZE: usize, T: Deref<Target=Io<SIZE>>>(bar: &T) -> Self {
+                Self(bar.readl($offset))
+            }
+
+            #[inline]
+            pub(crate) fn write<const SIZE: usize, T: Deref<Target=Io<SIZE>>>(self, bar: &T) {
+                bar.writel(self.0, $offset)
+            }
+
+            #[inline]
+            pub(crate) fn alter<const SIZE: usize, T: Deref<Target=Io<SIZE>>, F: FnOnce(Self) -> Self>(bar: &T, f: F) {
+                let reg = f(Self::read(bar));
+                reg.write(bar);
+            }
+        }
+
+        ::kernel::__reg_def_getters!($name; $( $hi:$lo $field $(=> as $as_type)? $(=> as_bit $bit_type)? $(=> into $type)? $(=> try_into $try_type)? $(, $field_comment)? );*);
+
+        ::kernel::__reg_def_setters!($name; $( $hi:$lo $field $(=> as $as_type)? $(=> as_bit $bit_type)? $(=> into $type)? $(=> try_into $try_type)? $(, $field_comment)? );*);
+    };
+}
+
+/// Defines a dedicated type for a register with a relative offset, alongside with getter and
+/// setter methods for its fields and methods to read and write it from an `Io` region.
+///
+/// See the documentation for [`register`] for more details. This macro works similarly to
+/// `register`, with the exception that the `read` and `write` methods take a `base` argument that
+/// is added to the offset of the register before access, and the `try_read` and `try_write`
+/// methods are added to allow access with offsets unknown at compile-time.
+#[macro_export]
+macro_rules! register_rel {
+    (
+        $name:ident@$offset:expr $(, $type_comment:expr)?
+        $(; $hi:tt:$lo:tt $field:ident
+            $(=> as $as_type:ty)?
+            $(=> as_bit $bit_type:ty)?
+            $(=> into $type:ty)?
+            $(=> try_into $try_type:ty)?
+        $(, $field_comment:expr)?)* $(;)?
+    ) => {
+        ::kernel::__reg_def_common!($name);
+
+        #[allow(dead_code)]
+        impl $name {
+            #[inline]
+            pub(crate) fn read<const SIZE: usize, T: Deref<Target=Io<SIZE>>>(bar: &T, base: usize) -> Self {
+                Self(bar.readl(base + $offset))
+            }
+
+            #[inline]
+            pub(crate) fn write<const SIZE: usize, T: Deref<Target=Io<SIZE>>>(self, bar: &T, base: usize) {
+                bar.writel(self.0, base + $offset)
+            }
+
+            #[inline]
+            pub(crate) fn alter<const SIZE: usize, T: Deref<Target=Io<SIZE>>, F: FnOnce(Self) -> Self>(bar: &T, base: usize, f: F) {
+                let reg = f(Self::read(bar, base));
+                reg.write(bar, base);
+            }
+
+            #[inline]
+            pub(crate) fn try_read<const SIZE: usize, T: Deref<Target=Io<SIZE>>>(bar: &T, base: usize) -> ::kernel::error::Result<Self> {
+                bar.try_readl(base + $offset).map(Self)
+            }
+
+            #[inline]
+            pub(crate) fn try_write<const SIZE: usize, T: Deref<Target=Io<SIZE>>>(self, bar: &T, base: usize) -> ::kernel::error::Result<()> {
+                bar.try_writel(self.0, base + $offset)
+            }
+
+            #[inline]
+            pub(crate) fn try_alter<const SIZE: usize, T: Deref<Target=Io<SIZE>>, F: FnOnce(Self) -> Self>(bar: &T, base: usize, f: F) -> ::kernel::error::Result<()> {
+                let reg = f(Self::try_read(bar, base)?);
+                reg.try_write(bar, base)
+            }
+        }
+
+        ::kernel::__reg_def_getters!($name; $( $hi:$lo $field $(=> as $as_type)? $(=> as_bit $bit_type)? $(=> into $type)? $(=> try_into $try_type)? $(, $field_comment)? );*);
+
+        ::kernel::__reg_def_setters!($name; $( $hi:$lo $field $(=> as $as_type)? $(=> as_bit $bit_type)? $(=> into $type)? $(=> try_into $try_type)? $(, $field_comment)? );*);
+    };
+}
diff --git a/rust/kernel/reg.rs b/rust/kernel/reg.rs
new file mode 100644
index 0000000000000000000000000000000000000000..139597f9cb07c5d48bed18984ec4747f4b4f3438
--- /dev/null
+++ b/rust/kernel/reg.rs
@@ -0,0 +1,2 @@
+
+

---
base-commit: 1d53763dc16c9fc9329a4cdc14d691979d47568f
change-id: 20250313-registers-7fdcb3d926b0
prerequisite-change-id: 20241023-topic-panthor-rs-genmask-fabc573fef43:v4
prerequisite-patch-id: 182945904fd914573eed9388a559ce8a642310ef
prerequisite-message-id: <20250306222336.23482-1-dakr@kernel.org>
prerequisite-patch-id: de15c0d16727e6af2d79f88f5b67be4c06212552
prerequisite-patch-id: f8bca95d983222da29508cc6e6886e4b0f992588
prerequisite-patch-id: 1ae8f68250fb43808342285a284bcf7b572263fe
prerequisite-patch-id: fa5ce1308e1dbc71374a381537ab3978babe20a0
prerequisite-patch-id: 7225e000f745bb5fd45fc43393d801d1d9adb767

Best regards,
-- 
Alexandre Courbot <acourbot@nvidia.com>


