Return-Path: <linux-kernel+bounces-371900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0455F9A41F3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 17:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E73C1C2491D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 15:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB98768E1;
	Fri, 18 Oct 2024 15:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IviFRnev"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A974F13A409
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 15:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729263970; cv=fail; b=Jl/iEOFX7m/VISxvhD43Tb/rEMGQhpBvIl8TTMnYlghUvcj5MORReQwdQlzNQRPdtJJQ6seLACEWqsVtaJZO6fapYI7jaH08WILkKzqOC5Rzi9e/xR7bppBeIoaHf/bsSAoidZ6gcJmTts5Z7WdoMuY3gvmkbyhHMGBbmksYKio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729263970; c=relaxed/simple;
	bh=L9ukT4U99LoyoxTT6MSaoL4GMIyIlT/CQZgxudixG4E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SG0whJLqYc46pu527SHj7iNJNT46TLuHO+kdfahBQ5erDWv4LxyNo7OmCxaGJHbV3mLoUlruFQU1JdPoN7xAR7FUEm2V6/vrfFoXVCu101iT2VeywwL63zCJr8ap6lUmAvppVMNASdK4dhrLBKCWQue1lj2jIhgVgVQe/irazwY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IviFRnev; arc=fail smtp.client-ip=40.107.243.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AVbNYs7nJeIHaN8/CBvjj1Wf8Z3jGA6lc6+3ZZT1DJIXpZGW+eutZukJrZQ4FnoNKTd5TE1euMUa8Jo5tShffCQ6LPw5DEr2RDsWPDBxP9re+YxLOITF1vrvMK4a7s2RYFC0+S1o8+PTR0x2n34as3/uQg7eX1TNphQWpOY9UZRUifeYQ9u/OKt9Xn4QSbhnWXPb02OEX4OIARpa5UttDYGF5o6igzbyEQ/MBTJPZSb7vdTzFJHWph4tJIv+urUr7xQmC+PVvArqmMRs7a3GAwF1dsi1mCHvu4jZpo0GFsSgsWlt+Q4od/YT2OHIOttSOfq5GdT0Zbk+/lNiVxY2eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=crwvTHE7I4Q9ivm762xxNIBZJznEQvh8W/QxSzyGq+E=;
 b=FY03LnouP65nYrw28Er2nV0yv8zcv7EVo+a2LM5/4MbQsFnhFNw3SKL9p6Ek0CatdlqUU/TreYO7MpXea9c6tUjXMzgY+FwbUp8KO+gSJyRRW42JL9R1qLVE/piZEuwaOXdkkSHZFvtl6Djvj0FUeBj+/UJPn1hU/IZlrzibBs0WVF4xClDEPQB8CHMIQUuZzn+dcDssmVE+oDKSlVTG7PwH94oYZlJ0XZIqOeDQHauhAIRVZJVvouRLfc/SqT/8LHb1cmDxk2sfT3mFc/3Vc2lNSBPrvPG/kxsChXvBOuPCVbPLCASYWrSlJRMCkHzqUTWdFrSSKa3TmRLre1q24g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=crwvTHE7I4Q9ivm762xxNIBZJznEQvh8W/QxSzyGq+E=;
 b=IviFRnev9MYsBycGvwagwvkIL6J46oDbn2tMPPzwdO1VHU+V6xlI9bQegAhVLTDOMVSCudMtanmlgbbKzH9KoDDKd0orc96TTwFglT1YAYyqBKaWNNbdl+CLuookEfGm3YqmPnOb9VMkmvkPwTSabrAlwQEgY2bUcxBN2yeXoS8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by CY8PR12MB7513.namprd12.prod.outlook.com (2603:10b6:930:91::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Fri, 18 Oct
 2024 15:06:05 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%5]) with mapi id 15.20.8069.024; Fri, 18 Oct 2024
 15:06:05 +0000
Message-ID: <13538afd-e3cf-d030-e714-977ff8d5700a@amd.com>
Date: Fri, 18 Oct 2024 10:06:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 7/8] x86/sev: Add full support for a segmented RMP
 table
Content-Language: en-US
To: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
References: <cover.1727709735.git.thomas.lendacky@amd.com>
 <333a437e6412a27ee666e10c2aca568985868ed9.1727709735.git.thomas.lendacky@amd.com>
 <4c1198e7-00c8-449e-bbb9-7dcf15e11cfe@amd.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <4c1198e7-00c8-449e-bbb9-7dcf15e11cfe@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR02CA0008.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::13) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|CY8PR12MB7513:EE_
X-MS-Office365-Filtering-Correlation-Id: c2a8a88e-1766-45a1-38f8-08dcef86635e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Nm9IMTYzdTErTUd2U3FnL3FDYWlvMVVreU1jTzdNQ0dCclFqNzQ0ajVLWnVu?=
 =?utf-8?B?SmdjOWNDVVpvMlVlTU1OSGQyU2FEa2pBS3FzSzBKcjdGVUdTZW5vLzFaY0p3?=
 =?utf-8?B?MHVSdkZSZEpHeTEzbG45QU5HV3FiQm00dXc3TlZ4NlpxanpLdTkwekw0SlhQ?=
 =?utf-8?B?am8wUkNMRm1IRzJJandWeitQYUhVUWs0aFV5SkdSc1lkd0pkbEpuZHhUY0hk?=
 =?utf-8?B?aUR3Q2R5Sk9ZaXhkODNNemFXRmxNSFZ4R2dOcnAyaDVQUzI4N01tUmREUTNT?=
 =?utf-8?B?amV4bWtvUDJ3UFB4TnV3NDNzUWE3Qll3b1lsMUZ3SXJVWDRKWm5Cb0RXMjlI?=
 =?utf-8?B?WCtoaTJabTA1WWhSN1VyWUc1RDhhUTdXNlpVTElDU2tuMjNZR09WQit1WDh6?=
 =?utf-8?B?SUJMSHZhY1RycFVvYVlmdjZ6RWVzWjVFcjd6MzhBUURSdHB3QWU3ZTJaRmRh?=
 =?utf-8?B?QmI2b0w1V3VLaU04Y0dyeDhFSER0RGM0blZmcnlMNUxwSFdwbDFJVU04M0JY?=
 =?utf-8?B?R0ZNSXpMTmlMSWJTc0crRjJCZkQvRGpic29BcCtsS2k5R3lDelFvbHV3c1cx?=
 =?utf-8?B?QjhjTjdZblAvTWFUZCtadFM4WitYNHlqUEllNmx5b2l5bTdXcEtkVHA4RUtY?=
 =?utf-8?B?ZklmY21yNmdkTy9mbWZpdFI4a0c1cTVtYnpKSVA0dDQwaFNOVWc3QU92K1RS?=
 =?utf-8?B?Y0VvK2hla0l3ZVlleFBvV05TV1g1MWp1TCsxWHBIL2FpZE9SYndpdDJ2bUsz?=
 =?utf-8?B?L1I3cnZiWkdnSWlKaUVsaDlxZEh5M1JFZHZOU3hqVGh4djhzc0JpYndIUXgr?=
 =?utf-8?B?RFNBVTRTUjdoL2thTTFheVhVc1NVd0xsQm1JeUJkcnpJTUgvNTRhTVhDOFhp?=
 =?utf-8?B?Tld1NXBVa3pKZVc0Q1M3R2VmWG1KbXFxcWVFUmdWWTAyeDBpMzNlYmo1akFa?=
 =?utf-8?B?azM5b3JtcVIwVitRc3RNRkRhZlE0ZmM1OXQ1eCt2czFvQXZjUW1sUnlFUGwx?=
 =?utf-8?B?VWNPVlhzTEFsWmliWWZyRHVBdnRlOWpsZlhuaXB1Nlg4N3JzR2tITWo5clF1?=
 =?utf-8?B?RDFubElseEVldDZwUmlJc2srVGlIMGFKYTQzR09yTDlXVE1PeGpIaDlJN2J2?=
 =?utf-8?B?TmlDVHRPVUZyallUZjhKenBpZ1RNcHo3WHNFQTViSngwQTVnTVo5TW9aeDdz?=
 =?utf-8?B?WVMycldsUFFWdE1RSnMxdlA2MGlIeDhiNThxeGtGUS9NNDNSZEQrTXNKTk4z?=
 =?utf-8?B?Wm56UStjWGlnWjY3SG1xZ2xJZXE4ZGorYnpaL0Y2SFF0cXd1YkxlemMyQmZF?=
 =?utf-8?B?eUpvQ2tma1hqMVR6c1ZWRDFtdEM4M0EwdndkU2d5VnpTSks4blNqWGJGZmxq?=
 =?utf-8?B?YXo4dVdFWXRQL3NDcHhDNnZIMW1QQVJMVTRLNDBYNnZYdzdTQ3d0MVdUNkht?=
 =?utf-8?B?RGZ3RFQ3SURYTys3Zm53VjZqUTB4OGZ5ZVd3OW9CdWxzblN5cXBubEdQY1Ax?=
 =?utf-8?B?eFRINC92Mm5LYVBXd0E0UWtlVE1jNnA1MEgrV1hxMVR2U3Y4UnF4dnlWaTdE?=
 =?utf-8?B?YUM4aEVUa3gvM05XSVZnSTlkQmt2UDVaTjdOdWhOL2N0bC9qUzFYMGFudkJu?=
 =?utf-8?B?YitKNjlsYVQ3M1NseDR5MjJvdHFHVHJSRFVxN3RCSk1OdWJoclBTdjJQbEZZ?=
 =?utf-8?B?d3VBNE5YUXVxV0s5SVhNbDU0cjZ0YktkTkdrUFk0a0JvYmFldXFKZG9LTjhX?=
 =?utf-8?Q?EeyIdra4+68xQwSbevrcqCS1pey2pyCY/ihF2rk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZnIzaFNtaUV3amtaSEp4bjRCUG9RcDRyVFJFZFhBQW15VUdyR3d5dE5Say9r?=
 =?utf-8?B?eXN4Y21ZdjZ6RmpSTXAxRW1ualNzckNPOTNxQTZsRVh2L3oxMUJGZ2hDSXRu?=
 =?utf-8?B?eXhnanR1QmxXWXd1Y291WW1OcFNjR0RNaEM1bS9sU2pqYzVLcllBejVuTDZo?=
 =?utf-8?B?UVR0YWNoY1BFZGd5OTlwVThzR28rUXlEV0szSXFGL0pHZlQvMG9sOFljUEw3?=
 =?utf-8?B?OHF1R3BMZkM5dGp5eFk5WGpaRFBlYklFOW1XcHlnbDJyblUvL2szc0x1MnUx?=
 =?utf-8?B?MEo4Mzg0clhuMTFDbmQ5S21yZ2FEdG90VFp2aW1Iayt4VVQ5L0dlYTFtbVR4?=
 =?utf-8?B?OGNmN1hRNEk3TW9XU1I2MGV0VGJONkdoNVFja1BZMmpGVllPSnliUXBHV09R?=
 =?utf-8?B?OHdHWEFIR2F4TmF3S1djV0ZCMFlnYXZJOFVxZ2NxK28rVlZuZVVocmFNRTdD?=
 =?utf-8?B?OVM0QWQ5YWFubWZSa3dMMjBHMmxnQ2RDU2E4U3hNTDhuOHFKT3pJQnhEd1E2?=
 =?utf-8?B?REwwYUdRVG1Rc0dnT3JXZjB2SkJRYzdmOHZIZEs1VW9uNS8wS1MrZGFnZTht?=
 =?utf-8?B?MklRR09nMWZjVElIemk3RmY3S0VoT2drZGEyQXExaVE4dUhvOEFxRElNNTQ3?=
 =?utf-8?B?UndSZlFoV2N4NHFYZG10ODZTbGhSU3hoN0dsdHFMa1F2bkVnZUJtUXlxWXB4?=
 =?utf-8?B?TmZlaCtUQmVocWk1dFZHSlBMSno4UEtSa0lQZWFJV3NhQ1o1VXZYZlJzaVJt?=
 =?utf-8?B?N09sRk8vdVZ1UEhLT2JDWGxhY2ZBN1pDSVQrOS95RHlpUlpTVDJxNzNrUjI3?=
 =?utf-8?B?Vlh6c2pvb1FxZHBSL0dWSlY3ZFIyWVVyTVEvSWRLa283UDVZTkJuT3RrMmxk?=
 =?utf-8?B?MWR2OXI4WGxIMlhhMmd6aStSSUtFSFVyZlRjWldSWkc2bU9MRFFPcEdGU3BL?=
 =?utf-8?B?RndlYm9CV0Vndm9WVXFiWERXRW5aeDFtUXhRbWZ4YmdHSzlKU1BmVmd5N05R?=
 =?utf-8?B?YjZJNDA4OUNTWXM0SVhXM2MzOVFXRzFZR0E5NTJvR2c3SVNIZGoxaDY3SFNt?=
 =?utf-8?B?ZlJPYkJ1bCtqeDhxNG9pRlZSci9FWjBRWFhzUndnTDQvZmxMSW1vMkxDNmhk?=
 =?utf-8?B?SUlhS2ZsSnVKN1RZWStWWUl6QTZYSVdUNVM0c2xwNEZTM05HQU9sWGZJb2c5?=
 =?utf-8?B?OFNtVTRmM005ZWttWDVPTDRSbGYzZkVtMUp5RUIxbklVVVB3ZXRwS2pHUVA5?=
 =?utf-8?B?ci9OMklSQVMza1drbmJLVGFuWHRocVQ2RndnVTc1R3dQTnFwenFJckhkM0ww?=
 =?utf-8?B?NzNqYXNNRHozMXp2R2M5bFcrMDE3SXc1ZGxyUXpEbG5ucFJUNTFPVDJkaUdN?=
 =?utf-8?B?M2MvaTFISmhrY2hZU2RVSktGQzJ2dEZOZGdKMFJqa1NpTzhlajl2RGdGUk82?=
 =?utf-8?B?bi9vbU1nRmJVWFJCMG9ZRWFacmgvbWl3R0t0SWZybUJIcG1tbW9NRjZvTVJ4?=
 =?utf-8?B?S25vNVNKR0ZEbndobmdtV1dLa29yd0hIZGFkb3RsUWJNNVBRamZBd0Z2Sllo?=
 =?utf-8?B?S3hzQ2E4aGx1MlpSY3pWV2gvK1FiNFF3Uno5R1lMWjVmSTY4aS85dHpKTHJG?=
 =?utf-8?B?VFlHMmg5RE9XY01IWjFERDJITm0wbnVZM2NqVlhaSndXL0xJVkIvL2JNOFd0?=
 =?utf-8?B?UUVBUFducVkrMEszV2RBM2JkcDRxSjZTcjQrUUxiV1FXSkV2bDhTNlBwTm5W?=
 =?utf-8?B?OGNJWEZ2Z0E2ZUM5b0R2dm1TdlV4NkJrcm9SKzFrNDdwQ09NREhRUkNFNkFj?=
 =?utf-8?B?bFM1MWlqbnJ2UUFxVHh4VmVZOEJJZy9yTFlRbWZvZGN1d0Q3c2tBcy9mUUNv?=
 =?utf-8?B?S0hLZnVRQXhybjZTTFBMeTZtaVNFSUhvVy9YZW4zUmRhZTVmMWhBTW5PZjAy?=
 =?utf-8?B?WWl5TXNIYW14Y1VlRHVTWXUrVjZyWkgxc2N5YlczdHBqUWZQZHBTRGVNRW81?=
 =?utf-8?B?QkUzUm1Wd3k1NkhxajNudHp5endhUU1WamtFcjFua2RqSE1QS0V6ZmRQZ0lD?=
 =?utf-8?B?VGFZUDVQMFUxN053V0dzU1lvbEhSVklIdmxtYnhybCtsSG5KRlhvSUgyNkxi?=
 =?utf-8?Q?kQEhldeIquPoKNY4Wg/cRyl85?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2a8a88e-1766-45a1-38f8-08dcef86635e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 15:06:05.3079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qu1147TG5ej0ywDMNVfgc7UFeqYgKEm3yVSaYcyQBLL8tqAM70aWQ125DO7ULrMz+yRRtjk32rHQ8FRFkyrSgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7513

On 10/18/24 03:37, Neeraj Upadhyay wrote:
> 
> 
>>  
>> @@ -196,7 +203,42 @@ static void __init __snp_fixup_e820_tables(u64 pa)
>>  void __init snp_fixup_e820_tables(void)
>>  {
>>  	__snp_fixup_e820_tables(probed_rmp_base);
>> -	__snp_fixup_e820_tables(probed_rmp_base + probed_rmp_size);
>> +
>> +	if (RMP_IS_SEGMENTED(rmp_cfg)) {
>> +		unsigned long size;
>> +		unsigned int i;
>> +		u64 pa, *rst;
>> +
>> +		pa = probed_rmp_base;
>> +		pa += RMPTABLE_CPU_BOOKKEEPING_SZ;
>> +		pa += RMP_SEGMENT_TABLE_SIZE;
>> +		__snp_fixup_e820_tables(pa);
>> +
>> +		pa -= RMP_SEGMENT_TABLE_SIZE;
>> +		rst = early_memremap(pa, RMP_SEGMENT_TABLE_SIZE);
>> +		if (!rst)
>> +			return;
>> +
>> +		for (i = 0; i < rst_max_index; i++) {
>> +			pa = RST_ENTRY_SEGMENT_BASE(rst[i]);
>> +			size = RST_ENTRY_MAPPED_SIZE(rst[i]);
>> +			if (!size)
>> +				continue;
>> +
>> +			__snp_fixup_e820_tables(pa);
>> +
>> +			/* Mapped size in GB */
>> +			size *= (1UL << 30);
> 
> nit: size <<= 30 ?

Yeah, might be clearer.

> 
>> +			if (size > rmp_segment_coverage_size)
>> +				size = rmp_segment_coverage_size;
>> +
>> +			__snp_fixup_e820_tables(pa + size);
> 
> I might have understood this wrong, but is this call meant to fixup segmented
> rmp table end. So, is below is required?
> 
> size  = PHYS_PFN(size);
> size <<= 4;
> __snp_fixup_e820_tables(pa + size);

Good catch. Yes, it is supposed to be checking the end of the RMP segment
which should be the number of entries and not the mapped size.

> 
>> +		}
>> +
>> +		early_memunmap(rst, RMP_SEGMENT_TABLE_SIZE);
>> +	} else {
>> +		__snp_fixup_e820_tables(probed_rmp_base + probed_rmp_size);
>> +	}
>>  }
>>  
> 
> ...
> 
>> +static bool __init segmented_rmptable_setup(void)
>> +{
>> +	u64 rst_pa, *rst, pa, ram_pa_end, ram_pa_max;
>> +	unsigned int i, max_index;
>> +
>> +	if (!probed_rmp_base)
>> +		return false;
>> +
>> +	if (!alloc_rmp_segment_table())
>> +		return false;
>> +
>> +	/* Map the RMP Segment Table */
>> +	rst_pa = probed_rmp_base + RMPTABLE_CPU_BOOKKEEPING_SZ;
>> +	rst = memremap(rst_pa, RMP_SEGMENT_TABLE_SIZE, MEMREMAP_WB);
>> +	if (!rst) {
>> +		pr_err("Failed to map RMP segment table addr %#llx\n", rst_pa);
>> +		goto e_free;
>> +	}
>> +
>> +	/* Get the address for the end of system RAM */
>> +	ram_pa_max = max_pfn << PAGE_SHIFT;
>> +
>> +	/* Process each RMP segment */
>> +	max_index = 0;
>> +	ram_pa_end = 0;
>> +	for (i = 0; i < rst_max_index; i++) {
>> +		u64 rmp_segment, rmp_size, mapped_size;
>> +
>> +		mapped_size = RST_ENTRY_MAPPED_SIZE(rst[i]);
>> +		if (!mapped_size)
>> +			continue;
>> +
>> +		max_index = i;
>> +
>> +		/* Mapped size in GB */
>> +		mapped_size *= (1ULL << 30);
> 
> nit: mapped_size <<= 30 ?

Ditto.

> 
>> +		if (mapped_size > rmp_segment_coverage_size)
>> +			mapped_size = rmp_segment_coverage_size;
>> +
>> +		rmp_segment = RST_ENTRY_SEGMENT_BASE(rst[i]);
>> +
>> +		rmp_size = PHYS_PFN(mapped_size);
>> +		rmp_size <<= 4;
>> +
>> +		pa = (u64)i << rmp_segment_coverage_shift;
>> +
>> +		/* Some segments may be for MMIO mapped above system RAM */
>> +		if (pa < ram_pa_max)
>> +			ram_pa_end = pa + mapped_size;
>> +
>> +		if (!alloc_rmp_segment_desc(rmp_segment, rmp_size, pa))
>> +			goto e_unmap;
>> +
>> +		pr_info("RMP segment %u physical address [%#llx - %#llx] covering [%#llx - %#llx]\n",
>> +			i, rmp_segment, rmp_segment + rmp_size - 1, pa, pa + mapped_size - 1);
>> +	}
>> +
>> +	if (ram_pa_max > ram_pa_end) {
>> +		pr_err("Segmented RMP does not cover full system RAM (expected 0x%llx got 0x%llx)\n",
>> +		       ram_pa_max, ram_pa_end);
>> +		goto e_unmap;
>> +	}
>> +
>> +	/* Adjust the maximum index based on the found segments */
>> +	rst_max_index = max_index + 1;
>> +
>> +	memunmap(rst);
>> +
>> +	return true;
>> +
>> +e_unmap:
>> +	memunmap(rst);
>> +
>> +e_free:
>> +	free_rmp_segment_table();
>> +
>> +	return false;
>> +}
>> +
> 
> ...
> 
>>  
>> +static bool probe_segmented_rmptable_info(void)
>> +{
>> +	unsigned int eax, ebx, segment_shift, segment_shift_min, segment_shift_max;
>> +	u64 rmp_base, rmp_end;
>> +
>> +	rdmsrl(MSR_AMD64_RMP_BASE, rmp_base);
>> +	rdmsrl(MSR_AMD64_RMP_END, rmp_end);
>> +
>> +	if (!(rmp_base & RMP_ADDR_MASK)) {
>> +		pr_err("Memory for the RMP table has not been reserved by BIOS\n");
>> +		return false;
>> +	}
>> +
>> +	WARN_ONCE(rmp_end & RMP_ADDR_MASK,
>> +		  "Segmented RMP enabled but RMP_END MSR is non-zero\n");
>> +
>> +	/* Obtain the min and max supported RMP segment size */
>> +	eax = cpuid_eax(0x80000025);
>> +	segment_shift_min = eax & GENMASK(5, 0);
>> +	segment_shift_max = (eax & GENMASK(11, 6)) >> 6;
>> +
>> +	/* Verify the segment size is within the supported limits */
>> +	segment_shift = MSR_AMD64_RMP_SEGMENT_SHIFT(rmp_cfg);
>> +	if (segment_shift > segment_shift_max || segment_shift < segment_shift_min) {
>> +		pr_err("RMP segment size (%u) is not within advertised bounds (min=%u, max=%u)\n",
>> +		       segment_shift, segment_shift_min, segment_shift_max);
>> +		return false;
>> +	}
>> +
>> +	/* Override the max supported RST index if a hardware limit exists */
>> +	ebx = cpuid_ebx(0x80000025);
>> +	if (ebx & BIT(10))
>> +		rst_max_index = ebx & GENMASK(9, 0);
>> +
>> +	set_rmp_segment_info(segment_shift);
>> +
>> +	probed_rmp_base = rmp_base;
>> +	probed_rmp_size = 0;
>> +
>> +	pr_info("RMP segment table physical address [0x%016llx - 0x%016llx]\n",
>> +		rmp_base, rmp_base + RMPTABLE_CPU_BOOKKEEPING_SZ + RMP_SEGMENT_TABLE_SIZE);
>> +
> 
> rmp_base + RMPTABLE_CPU_BOOKKEEPING_SZ, rmp_base + RMPTABLE_CPU_BOOKKEEPING_SZ + RMP_SEGMENT_TABLE_SIZE);

I really want the full range printed, which includes the bookkeeping area.
So maybe the text could be clearer, let me think about that.

Thanks,
Tom

> 
> 
> - Neeraj
> 
>> +	return true;
>> +}
>> +

