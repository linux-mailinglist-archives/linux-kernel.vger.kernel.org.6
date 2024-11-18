Return-Path: <linux-kernel+bounces-413489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C52FD9D19B7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 21:38:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21489B21883
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 20:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163801E5707;
	Mon, 18 Nov 2024 20:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oY5q2rhx"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568B914BF8F
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 20:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731962286; cv=fail; b=hyekkYfVw66CSJ/mVXJzWYzS36w8IMFr9bFq5Axt5O63CyAj3dYYs6F4BtFdNlzzX0Addoy9oHGLSH0l8Gq+zmlm4Us8j5rohtItjsufR+IrFLJBpUO04R6o09LWov6IXyBwcbt/xzVQjVkhPfXCkwjMJxSSMRergekn7sFztHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731962286; c=relaxed/simple;
	bh=mWs649BRaKbXfN68In8+To/QWc5PbnljCG9NkeIw0Ts=;
	h=Message-ID:Date:To:Cc:References:From:Subject:In-Reply-To:
	 Content-Type:MIME-Version; b=oYxSErntTOCZfoTbHWrDRe2JGBU6fcgYuZfAxOlkyimxY8ABeGAyzostraD/ItYxgzBG/WPAJgsj80vd6IiQIOcxhjgllah7/4UJemzuVDyUEDVhGH+ufJYjZ0bOdxHlKGZkMYmLBFYIeZtEE6kI1bjcj4J9XWPgfs8NIR5Fh6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oY5q2rhx; arc=fail smtp.client-ip=40.107.237.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hJF9my9m8pujrJ/oSPwkaQ3bjcIUUjek2YNTzOf6hQ6hC9ATLovStQ3odqGwQ/e991jPhnxHRQ9qMkLC3UhHfkmM6wTDldQlIc5EJ3P2bprfK4jOYOsRuwnpr8Ryr6i/lcr5NjR9XQgV4KiWwqJoqUHMCFRzrlPFpdKvL5d+9CfJ+J07DDYJFyhpGFtah8drV0PE7Lrb2rEMmeEvrp0T17ZVsOPtDb4CN6RKwwTVJY5obmxISqDjTuh0ObuqdIPmgcyuK1GD0eUCO+J934HH0Ql0ysj4iB55uOJgXIhTmdpu8x7Ph3luiExV91iQ/2Jlwrj6SBhEAmzlE2oaiNpe3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UjBO4Oh4l+A5zeo2+7v8R8hiRB9/mVsuA+ODP7wsEGM=;
 b=jvzU6eU4HRL5Dvq+Ae0kSD2F0pfmo0bsF6QK4Hhy3kG64K3RQBkXE2U7i61L2Qhi91KbsH9/ZcNsmHnZc63jQ/a4CCB1tz3toABkk50RH3EiIMkxdxNU/cXlrpRHhDi6ChEilNIeScSHgOIkKgQD/a85IFkNoq5g5vAazxcuBWLPxM4tizwk62EGM+INgSozg9NWGTfsOdB/xBVtAeqJoF3bLIaLJaPFHQNM+T2DL+dOgT/ku6rCOVX+lQbu8nJmcG6RQpDdmtpipS6Ax+bQPZrhcDqA7xQNg7bGuliX+aPngyK371uey7wQWlfBBK9xIcUC8g4DVmd8vE+BI4wXIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UjBO4Oh4l+A5zeo2+7v8R8hiRB9/mVsuA+ODP7wsEGM=;
 b=oY5q2rhxOItf3bu8B2LIzVtaZbPBC7v4n7RP4BRJpfwhF8XWMxINkzdQo70QHpqOJ2djeZVEi777xNWAKPE2mTaqzVB/gCJwj4baz8hQl0eZZDaZ1MqacYqgaOeoBKRqNDV3hoSzNvvdUl7S+LuUNVIWPdgcsC4I/MwBu44sEYc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by DM4PR12MB6590.namprd12.prod.outlook.com (2603:10b6:8:8f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.20; Mon, 18 Nov
 2024 20:38:01 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%5]) with mapi id 15.20.8158.023; Mon, 18 Nov 2024
 20:38:00 +0000
Message-ID: <6539edcb-e865-e33e-5344-77fac413e49d@amd.com>
Date: Mon, 18 Nov 2024 14:37:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: "Ragavendra B.N." <ragavendra.bn@gmail.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, ashish.kalra@amd.com,
 tzimmermann@suse.de, bhelgaas@google.com, x86@kernel.org,
 linux-kernel@vger.kernel.org
References: <20241115003505.9492-2-ragavendra.bn@gmail.com>
 <Zzcp75p3KTFRfW5O@gmail.com>
 <CAMj1kXHK4NxgWCieaQY7tT6BquSBv6Db10K8-V_8qFeZKv=BZA@mail.gmail.com>
 <ZzemwFBfEIgFhrD-@desktop>
 <CAMj1kXHPut9qv7dT9Xv=xhbS6AP3HRP0dikk-G690AKfLuNLGA@mail.gmail.com>
 <c7a9748e-aead-b252-dd29-48dd0d2da9be@amd.com>
 <30558bc8-c22c-1ce1-f59a-66c057fdd06f@amd.com> <ZzuYy9KHwlLa9HLY@desktop>
 <182fc3f3-2b9d-5c86-b058-5d1208305cbb@amd.com> <ZzuiDPWzloIAJYya@desktop>
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH] arch:x86:coco:sev: Initialize ctxt variable
In-Reply-To: <ZzuiDPWzloIAJYya@desktop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR16CA0045.namprd16.prod.outlook.com
 (2603:10b6:805:ca::22) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|DM4PR12MB6590:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bb35bc8-3cd2-4d7e-bb9b-08dd0810e4ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cUhFeFhtL2VsdGZITmpSTEU5S2w4dWdXOFFCQWdzVHRSRnREcmtQR2xqeHo1?=
 =?utf-8?B?K3VTRENzbXp6YkhWNGlzVzV0azlHck5nT01jaThFaG1pbUNsMVM5dlE3YU80?=
 =?utf-8?B?OU5LTnBjaWlNZlRnRmY4S3dqQ1R5cFczdFFKM0N3em9lZktxQ3ZILyt3WlJp?=
 =?utf-8?B?MUtqamt0dHNpTFFHZVVPaDBFdXpkTmNzVlF2S0dLUlFiblBkaGxnVkpOZzhC?=
 =?utf-8?B?eWkzYkVUdnBSSmtURnd4a3BaNkNnR1YyMDBKdHAwd1QveFYwTTltVmNHRDl4?=
 =?utf-8?B?YzhacVZ3TzU1VUhlY3dWZXJPK1JwSWtRVUNaSG5FSWNMcVE2NlFOL3Z0WEhM?=
 =?utf-8?B?dTBobVZiUW9ERWxObDQ3U0hVVUJvMWRaS2FGdmdibW03V01DaTIzVkdDVVpx?=
 =?utf-8?B?RVRJcmdNZ092QjVrZWxMRElPd1JxMU9GWWZqcGNRMklLMWgxWDdTVzZiOUtu?=
 =?utf-8?B?Z0duNlpsazJaSjVVWll5dkZXeE9QTTlQOWNla0NOVGJ6QWZ5N2wzbnc5UW1z?=
 =?utf-8?B?R0ZCWUYrVGhyU05LbTRRTUhzQ3B3MkxpOVRLYVdxRG5iUlZEQlBCSm50c3Z1?=
 =?utf-8?B?RDRHK1cxZzFCaENQdHNWTVAyaXlGQnQ4bDFUVWZuT2ZENWhqaFBVaHZEQ1dP?=
 =?utf-8?B?TDJxd2RuM1hQK3VDMVFqamJocjVvbFZwcER0UVJHaDVoeG9RckhoK216NlRW?=
 =?utf-8?B?ZCtYaS85MEVtNm9YaDhSUEs0aGMwYi9UNWMzQTBJRVRoVTJYZzk0UGRoOUpa?=
 =?utf-8?B?MytoWTBnbTd2L3hKVVFhdEVubmtDM2F5ekhKNUQ4cURqWjhSeXZ1ZFdRSDFm?=
 =?utf-8?B?YUdEUGVCeWJydW1YaTYzcnFBWGFCRWNvUlJ0VmFSSXRPRTVyM2xMc1pSdW9y?=
 =?utf-8?B?MDAzaWtMcms5NEZpUUxrMFNWQzR6aldDeWxQZDdvdExWTTUwVno3d0NKeDk5?=
 =?utf-8?B?ZUtHUVE5a3BxVUZid2liK2xNNGswcGs0MEJOd0lSQWFxbEdUaC9ETWV1TUFo?=
 =?utf-8?B?MzR0dCtYdVgxRm5KaWFseEw4b0dRR29DbG1yVHIxaWlQeG5yNXhmUDhiaHl5?=
 =?utf-8?B?dlN6c2tTZi8ya0JYOEZyVmczSzRPZ002TjVXdTRLR3pwanU4aXErWHN0U1RJ?=
 =?utf-8?B?U2VEV1R1c0REblJncFdiRWdmdXBvcUZlbkd4a2EzZzNlVEM3WVdNNkVjbFMw?=
 =?utf-8?B?c2lXUmllckdpRkRiZmh5VzROdjVZY08xM3Nad3puM1JTYXl4WDF4aGRibWFz?=
 =?utf-8?B?QXlITHcvQ1JaVmMrNU5lMzYzUEN1SjM2VWxrdk9nM2R4dUdlWU5tK3lLMUNq?=
 =?utf-8?B?ZnF6aUJEa2ZaWlY1RkkwTDY2cG1hVGplS2RubWZSeGI0M29ZSThrVE4wc0tw?=
 =?utf-8?B?S3g4U0YvcWNBdkZtbGwvMEJFdFhjbVg1dXYva3FZekVFd2lIeStVZHZIT09a?=
 =?utf-8?B?S0s5Qk9kTWcxTEg4VElHYjBlZ09McGR6bzRmSHlaUm9UNmQyMzkwbGljRjYr?=
 =?utf-8?B?UUF2QithSkE1cU8wSzJUU0tEMGp1cUQwZjNlTEV6NXF6ZjNPL2F2TmtDNmZC?=
 =?utf-8?B?aGo0bU9BRHJ6cDEyRnF1N2V0b2ZwQUVNY2N0Um1ERGpRU2dObHozOUx3V3hC?=
 =?utf-8?B?YzJid0xWcXVrelg0a0JSUkFDTHRXNU5CTDgrL2MvMmJ5cFF0dlQ1RkU0bGQ0?=
 =?utf-8?B?NmtnclJtT0F2clNKVHRESDlKbUlkbjNRaGFGWnJQRSthVXkvYm53ak9KZU5k?=
 =?utf-8?Q?GM9kxZMylCvJ491iX9khD/UsIFnJEpa8h+F3fxo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c2w3cVloV05JVnpxQUtPL2Jaekh2M3pPQlZ2Q25GSjc2VElJcWZ3cGRGcEVV?=
 =?utf-8?B?TWowcXJNU3dtUmFsNElNbFVTQWpqempuYldaY2ZUbFExd1Y1eGNvMmg3ZlBr?=
 =?utf-8?B?clFtK21PVWJrTGh0cXFYRFNWS2p2di9aMVgvZUc1WXBGVWRIMVJLVUFCM3RU?=
 =?utf-8?B?a1d4bTJWQTA0WFovNG9RUzBJczdDQlcrdTdUK0xnODB3aU5jZXZYL0tWTXVX?=
 =?utf-8?B?TVhvODBQZEtza3phdTJTQ2hVVlV5bHRsc0RxbGN6UlRYTW9HV2dzZGJSVVMv?=
 =?utf-8?B?MVR5NEdCb2NibVJRL3RxUkZkdkFmMG54OE9WUkxZT0Z4M2YrVlZhd0FFaDJR?=
 =?utf-8?B?SkpEa2h5SUpzSzgzdkNWMjE3RGRMUGkwVXhVYjVJcEh4dVoxMGNORjQrN2dZ?=
 =?utf-8?B?bUJCb2txYlFpbVMxWDNZVDdSYjRLaVVndFdwYlNXUUZhc2x3OGxtNkl1L2pX?=
 =?utf-8?B?Y1d4UlZxODMrckZYUXZ0dE5WdGRKQ3dLak9TdFVScE92cjhrRGsvRTJDc2JP?=
 =?utf-8?B?MjlpM2p2L1pjbHE3Q0F2bHVLNHhNWFFnOCtoYjBFZHcvS05YNHRIY1lHV3R3?=
 =?utf-8?B?UE40N0kvWU8yemZURTIvcnora1F1WmFaQjg4NG9FSUwrSldlaDdveUxmVTU2?=
 =?utf-8?B?c2hYczZMVXpTY2RXODgxYzFEeSt0OUJ5M0VsaXdkNGVpSk4wU1hQYXlyYk5N?=
 =?utf-8?B?bGwxM3NuRTZUaVFQYlh1UlZoN28vdksycUQxK0RIY0tyWE9lRFpGb3lVaW9I?=
 =?utf-8?B?OXNwUzZTNlk2WU1GSjgwb2tOcVg1cTRnZm9SaGh2VEtIdSsyZUZZTCtYaEhy?=
 =?utf-8?B?UTNIMi9QWGh6SVYxelR6UEU5ZTROYWpOUVg0YVFURTdPREdXU0NaT1Nlb3Vw?=
 =?utf-8?B?UloxZ2xmY29rTW93c3RLelZtWGFqL3k5aC9mS3pKZU9UeUFoM3hzZ1Y0MVRQ?=
 =?utf-8?B?VFRqUXJaVElaQTd1c1BXNTYzS1VncVFuVitTenZKVmJOanNaSHhrWE5KVDRX?=
 =?utf-8?B?VHovYWFOSU5VK2FIRVk0Nlk0WGpIaElSMGlSbnNEQmV4TUJCTXdET04zS2FG?=
 =?utf-8?B?WHZxdnNqYWhIL2tqNWxzUjAyV1R4V25kYjUrd0VmenhGTFg5bSttcUdyWDJa?=
 =?utf-8?B?dnc2TnVYL0FBKzQyN3BBUkxlTXgvMUVPbXh1cCtzL0xwdG8xb1hBdjFsZUJm?=
 =?utf-8?B?V3Z0ZHhldWtRVk5YOS9jZ2lpNzE2V2lSTFM1TFdwVVJOMm45T0E1QklmVUto?=
 =?utf-8?B?UHRkSndmT2xPV0JJQVNKRHprUGpyK2hWTFlITUdYNDVkYWhrblBYZEgzUjZz?=
 =?utf-8?B?S1ZmUzNhckRTc0oyVXBrcGtJYTN2QXczWVpZMFF6bnZYNzhEN09keWo2K2pz?=
 =?utf-8?B?bzVmMGlVY3BnSklxYlYwejRtMVN5NndmT0gveU9TQ3QzVE1hc2pxUmNPQjV2?=
 =?utf-8?B?WDZndFU3emIzMG5qWSs5bUYzRHkwdGlzRkpHN2JDd3o4dFhDTkJCNFVvcWdR?=
 =?utf-8?B?Q2pBM0VBZURxV3BldWNjMGwzWFJtdUdLTlNoVHVKNVYvbWg4YmVRZTRpZlpK?=
 =?utf-8?B?MkFCK1F6MVdoaHJpSER2WjdyUnZtZlRsbVZHZ3FlWjcwY3VSWkkrZWF6clVI?=
 =?utf-8?B?bjFEV1RuSXRsSTdJVmhCZ1lFdDR2SFU5U2xhSTl3ekFPNE1SM050am9LN0J0?=
 =?utf-8?B?YW9WeURGM0t3V2dCbHQxVDZhVVZPNTFtd2NVL2pFVk1YZFZMazdYVVBvaWEr?=
 =?utf-8?B?UVlrUWZNT1dNYXJiRmYrY2ZLbWs5TEg4d25LUzN0akRzZWZBc2s2b1lzeERR?=
 =?utf-8?B?dDVLZ250S2QvMlpDWVRJN0tNM3dkZkt3MXJvbUk0OXVxUVRvNXlGNUJHUHVS?=
 =?utf-8?B?WTdWd2NWOFBVU1FiSEc1MjdoVmVlVHpBaWtxZXhyV205K1RnLzExY1Z6UVk1?=
 =?utf-8?B?MTZONUp2UjladlJsM2RRYjhGYXVSYmRDM0p5V09Wa3lOUEdsVU5RUTB3UDdD?=
 =?utf-8?B?ajd3azJnbFFBZDJoYmlqcHVhcmFLL1RUUUdFcEhQMHh1VFAvRUUwSHd4dWdG?=
 =?utf-8?B?NXFRMDN5emNBUTUxbkJPb3MwVm9VaXJKTlcwSzJBSzdadlhYSFJDbG81ZVRS?=
 =?utf-8?Q?sYWaVTmyN7+rh59bWaoRJ1Gjg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bb35bc8-3cd2-4d7e-bb9b-08dd0810e4ad
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 20:38:00.7079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mTx2dvK19DabIqSIrabrRWn1XQO9fWcHW0tOKZOG1vy88LNXLiAVxQuybVLo/ayh09spf1cPmf995ZSWQnvn2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6590

On 11/18/24 14:22, Ragavendra B.N. wrote:
> On Mon, Nov 18, 2024 at 01:50:55PM -0600, Tom Lendacky wrote:
>> On 11/18/24 13:43, Ragavendra B.N. wrote:
>>> On Mon, Nov 18, 2024 at 08:53:04AM -0600, Tom Lendacky wrote:
>>>> On 11/18/24 08:44, Tom Lendacky wrote:
>>>>> On 11/15/24 16:55, Ard Biesheuvel wrote:
>>>>>> On Fri, 15 Nov 2024 at 20:53, Ragavendra B.N. <ragavendra.bn@gmail.com> wrote:
>>>>>>>
>>>>>>> On Fri, Nov 15, 2024 at 12:02:27PM +0100, Ard Biesheuvel wrote:
>>>>>>>> On Fri, 15 Nov 2024 at 12:01, Ingo Molnar <mingo@kernel.org> wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> * Ragavendra <ragavendra.bn@gmail.com> wrote:
>>>>>>>>>
>>>>>>>>>> Updating the ctxt value to NULL in the svsm_perform_ghcb_protocol as
>>>>>>>>>> it was not initialized.
>>>>>>>>>>
>>>>>>>>>> Fixes: 2e1b3cc9d7f7 (grafted) Merge tag 'arm-fixes-6.12-2' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
>>>>>>>>>
>>>>>>>>> This 'Fixes' tag looks bogus.
>>>>>>>>>
>>>>>>>>
>>>>>>>> So does the patch itself - 'struct es_em_ctxt ctxt' is not a pointer.
>>>>>>> Thank you very much for your response. I am relatively new to kernel development.
>>>>>>>
>>>>>>> I know we can use kmalloc for memory allocation. Please advice.
>>>>>>>
>>>>>>> struct es_em_ctxt ctxt = kmalloc(sizeof(struct es_em_ctxt), GFP_KERNEL);
>>>>>>>
>>>>>>> I am thinking to update like above, but like you mentioned, ctxt is not a pointer. I can update this to be a pointer if needed.
>>>>>>>
>>>>>>
>>>>>> The code is fine as is. Let's end this thread here, shall we?
>>>>>
>>>>> I was assuming he got some kind of warning from some compiler options or
>>>>> a static checker. Is that the case Ragavendra?
>>>>>
>>>>> When I look at the code, it is possible for ctxt->fi.error_code to be
>>>>> left uninitialized. The simple fix is to just initialize ctxt as:
>>>>>
>>>>> 	struct es_em_ctxt ctxt = {};
>>>>
>>>> Although to cover all cases now and going forwared, the es_em_ctxt fi
>>>> member should just be zeroed in verify_exception_info() when
>>>> ES_EXCEPTION is going to be returned.
>>>>
>>>> Thanks,
>>>> Tom
>>>>
>>>>>
>>>>> Thanks,
>>>>> Tom
>>>
>>> Yes Tom, that is exactly the reason I worked on it the first place. The issue was reported by the Coverity tool.
>>>
>>> I can send the below fix if that is fine.
>>>>> 	struct es_em_ctxt ctxt = {};
>>>
>>> For the es_em_ctxt fi member to be zeroed, I can go ahead and assign 0 to all the three long members like below in verify_exception_info()
>>>
>>>
>>> 	if (info & SVM_EVTINJ_VALID_ERR) {
>>> 		ctxt->fi.error_code = info >> 32;
>>> 	} else {
>>> 		ctxt->fi.error_code = 0;
>>> 		ctxt->fi.vector = 0;
>>> 		ctxt->fi.cr2 = 0;
>>
>> But then the cr2 value isn't set/zeroed in the true path of the if
>> statement. I think a simple memset() at the beginning of the if path
>> that will return ES_EXCEPTION is simplest.
>>
>> Thanks,
>> Tom
>>
>>>
>>> 	}
>>>
>>> return ES_EXCEPTION;
>>>
>>> Thanks,
>>> Ragavendra N.
> 
> I am assuming something like below.
> 
> /* Check if exception information from hypervisor is sane. */
> if ((info & SVM_EVTINJ_VALID) &&
> 		((v == X86_TRAP_GP) || (v == X86_TRAP_UD)) &&
> 		((info & SVM_EVTINJ_TYPE_MASK) == SVM_EVTINJ_TYPE_EXEPT)) {
> 
> 	memset(ctxt->fi, 0, sizeof(es_fault_info));
> 
> 	ctxt->fi.vector = v;
> 
> PS - My C skills is not that great as well, as I am from Java/ C# background.

Yes, that is the general idea.

Please be sure that whatever you submit builds properly before
submitting. For example, the above will fail to build (as would have
your first patch).

Be sure to read Documentation/process/coding-style.rst and
Documentation/process/submitting-patches.rst.

Thanks,
Tom

> 
> 
> Thanks,
> Ragavendra N.

