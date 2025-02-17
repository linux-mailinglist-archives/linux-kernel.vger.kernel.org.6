Return-Path: <linux-kernel+bounces-518329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E91A4A38D60
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 21:38:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D18D7A379C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 20:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D05223770B;
	Mon, 17 Feb 2025 20:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ltLALRdZ"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2064.outbound.protection.outlook.com [40.107.95.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8898B237706
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 20:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739824692; cv=fail; b=bw164KxljqHwh4CW2U3doLhJ2nuz6SkM6UZiqt2fl8GZulEzw2FJVv2oWWEoBpYaeCkLiv6XMfUaLCaCW0xFDFW4F8pk1XuB4jKgADkJFpFqVyM67H91IubQ4Fah8TWrlenzElfGpBMgOwPq1zdZp6JJul3f58s9MCpCwO+HQ3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739824692; c=relaxed/simple;
	bh=g+UfsSQ32FQxG7Ej8IsRv2SL6NCBaquu5Ce8NUvxU+k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bRREszgvQ2Z/mANrlJ+Hs5JpPQ9cUWOYyuyjzn0fdW0Lr7qaIK1OlEKwwGDMqaY+m7jBLudre6fTcKmLu/7D0eYaXqGle9G4s6ZNhIPnFhCuUaflgNwRhtRIpcFdiVxExjG0H+DuyetsG5yjJimCoPtbfT1DiX6rV/0iWxEk06E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ltLALRdZ; arc=fail smtp.client-ip=40.107.95.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wyQ7I2wvr6tnOiUA5RZM2szaET4NMe9JXYxnphso1UZ9eEpIlQzkyRrF8niFKTa1KbcOfb+urQW8AICmXlodyABEll9oukdA6VVyKcaSCKHC3YT+lR9TWc7mrvsBFLdb+6qaaJzIZaPVOQWSdZvH8+IBSdFpopMFXl6mMMKuwfGtYlveQBSk5YnzC0cZOMz2PCYmijczmqEU1bsjW8dOEQKrs3mKivBMpQY3uGK2JKftGc6kDVq4TkK9ygIXxqsoggDhhOSL/Jby65eB52WJ7apV67DS4yO21RkqUbRt2BztSzsVwVs9Ky62A3XQezig78npuV8tKINljk0b2yk/1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g+UfsSQ32FQxG7Ej8IsRv2SL6NCBaquu5Ce8NUvxU+k=;
 b=sdtfoMbExxgM8a2cpTAM/YaVSm3lJINk2oJQ7jRCX4bDv5vI9fCQ5NxdITge13slzM19mvrSV881SgyO5vUqS/wEFGGyZqZ34O0N+D2nLnP2zgpbacuQAZZseu9uv1fgcc3Csld7Xr/3PJEDG3ewje2wAIIQD5swt8Jt0EVtMUfkOd7CqjZkGMsyAUvKLb3cDkiBHdU+x+QCD3Fs+0W6LFfxtWVTtzK4G/pN6lxE+UuMp83VkpnI53/ln7kT6w+iscQghgiqzVbQXw1VpoaiVjpwWTzgJaHOZ5WuL3ORpuo4fIsBSdCCeC4ILXanZkT18yPcDJA5vFB6Vvpe5201Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g+UfsSQ32FQxG7Ej8IsRv2SL6NCBaquu5Ce8NUvxU+k=;
 b=ltLALRdZ/NdmaMAknUjAD1cxSrDB0hYvoUnq27bGG7XG+qTUZFC9prm6zl0W7WPv5trECGlcZRy1c+RIUCm8Conur9707YfLg8lEMwmaOgE12ui0OomGDTtejj6psLc8d/3DIQCWPuJXsYH+w3twFreaJbzljjfasl4z0Ysl+wA=
Received: from LV3PR12MB9265.namprd12.prod.outlook.com (2603:10b6:408:215::14)
 by CYYPR12MB8964.namprd12.prod.outlook.com (2603:10b6:930:bc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Mon, 17 Feb
 2025 20:38:08 +0000
Received: from LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427]) by LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427%4]) with mapi id 15.20.8445.017; Mon, 17 Feb 2025
 20:38:07 +0000
From: "Kaplan, David" <David.Kaplan@amd.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Pawan Gupta
	<pawan.kumar.gupta@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Dave
 Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, "H .
 Peter Anvin" <hpa@zytor.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 20/35] x86/bugs: Define attack vectors
Thread-Topic: [PATCH v3 20/35] x86/bugs: Define attack vectors
Thread-Index: AQHbfK/msIIkfjoqOkyd6FXsW3bSnrND631ggAfdInCAADBpAIAAAIOw
Date: Mon, 17 Feb 2025 20:38:07 +0000
Message-ID:
 <LV3PR12MB9265249E8D0FD3920C42A1A994FB2@LV3PR12MB9265.namprd12.prod.outlook.com>
References: <20250108202515.385902-1-david.kaplan@amd.com>
 <20250108202515.385902-21-david.kaplan@amd.com>
 <20250211180752.pfsjvz62bztpnmoi@jpoimboe>
 <LV3PR12MB9265804700AB74A446F5220F94FC2@LV3PR12MB9265.namprd12.prod.outlook.com>
 <LV3PR12MB926524EFB64F6FB361046C5E94FB2@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20250217201910.crsu7xucsa4dz3ub@jpoimboe>
In-Reply-To: <20250217201910.crsu7xucsa4dz3ub@jpoimboe>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=9b5335cb-c787-4692-bfb7-f5c14de6386b;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-17T20:20:59Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9265:EE_|CYYPR12MB8964:EE_
x-ms-office365-filtering-correlation-id: d90dc9eb-8421-4381-b547-08dd4f92fc8f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MG0rWFZEeUh0dUdUUXZLRHdDaDVQMWRoZkRyTG1nTk5WSGVuckNiVjFsc050?=
 =?utf-8?B?eVRFdTJ2SGF4L3ZJVEhZVm14ZTRyQ3NCRTF3OUtBdm9JSmp1K1ZOQWxzc0k0?=
 =?utf-8?B?R1htZytFVmZZYnFpcXdGL1JEbVZLaFBhaHpvN0FiQ1dWQjNDdDI5V3Y2UXp2?=
 =?utf-8?B?c1RHZU9lVjNpVDBLbDIrNGRLaVRJS0E5MWtvNmtzZXM1T05xNUM4T2JIWUZX?=
 =?utf-8?B?ejVCZXc3N05nbkgyelN1eTFSbXN0VXBCSlhDd2tId0dpWjltY3kzck1zc085?=
 =?utf-8?B?TlBZQS9GV1FIbTRYNGtzWlV5TkU4UjlYQ294Rm9UbkQzYWtHKzZGbWFkaThC?=
 =?utf-8?B?SllpeHl5YnpJOUdyNEttTnBSTldKTk1lUTdGQjVTNVFTU2NjZ3ZJUUx1QUMy?=
 =?utf-8?B?c3RxRVNVdjRzNGZUNmZ1RmMyNkZ3MCtXZkVHZkpFWCtCMitkQzljcVo2dU5H?=
 =?utf-8?B?WFZNRGJpOUpSc21PTGQxYjVsZ1BqNHVJd0krU0h5N2pCNGJ3QkhWMnZncVRT?=
 =?utf-8?B?QkUrNFVPSnZCcFp1WmltZnRaTkNLRkh5djgyNEJJSEIwMnRrQjdXSUZJSTJZ?=
 =?utf-8?B?ZE1pbWRTQjFRYUFpWGVqSVNQSi9kdGdRQW0rUUtEQzlCMkFIVEc1RWhXczk5?=
 =?utf-8?B?QVA1ajBSYkJKeklLdFpSYTlDd0VrdGVkYnkrNWlkcnowcDlhamJQNlZHTEND?=
 =?utf-8?B?STRzTmRaMjh2NHJLdGFsdFdzRmxWbEVUOGlpeFpveXhNZFFMTVl0eUU1bXhC?=
 =?utf-8?B?QWphbHdYSDZCMnByYUlRaHNna01ObFdpWnBnUmpMeVFVMEVPd01Pdm5WbU1q?=
 =?utf-8?B?NnozbE81K1ZhbGlVUGN0NlprQWJEU3pxcDF5L0o3OTViUlpjdStxcHJ5dTk0?=
 =?utf-8?B?SXF2WUxjVmtGeTh2WWZieXZRcGNnMzFsaWozdWdGVTkza2pySnVBemZGMjc5?=
 =?utf-8?B?VUVyT0E4b2VmYUlsSGMzaWJiSXBvQXRpOTF3R21NRGVnYXM5OGMzODdYdjFE?=
 =?utf-8?B?RmpOQ3BVV2MrWWljdFhlWEFCQVBsRDJ4NkxoR2dhK0M0SE5BZUZIZnZRbkJF?=
 =?utf-8?B?RTlhOFJveWJSbmFkeE91R2VYODFEb3pPWkJxS1Q3WS9uLzJGM2lNbUlkZ0dJ?=
 =?utf-8?B?elZhdzBQeEFXWVhYUWRmcmc1RXIrbGRYSk9qaW15SXNCeWVTcVptdXdEd25p?=
 =?utf-8?B?UDc2bWdyNmNVMGlIdk90SXhHbkVxUXNjQ05kbU9QVVd3TFRtZ1h5a2c4V1Nr?=
 =?utf-8?B?eEtaMWo1ZFZvblNKa0NkeDRaZDk3anpncVFHRHBHSzBSZWVnQjgzREJTVHp1?=
 =?utf-8?B?cmNpMmxMMHFuT1dOMEpyMGgySXdiVFJnaHYvS1JPanlaaVJUdDVwQVdRSk85?=
 =?utf-8?B?eVlGUWRoMWdYbDFEajJnZkUyakhVQkNVVnBpcWVRaXNaZGplTzlyQWdyWWJi?=
 =?utf-8?B?aTB5WnZ6QnM2MTRabkRyNm5wRGk2QU55S1dZdmMwMjh4Mm9DSjA2bjJwZXp0?=
 =?utf-8?B?Zy82QUV1MUdjVEdkUXN4bmZyTnRWRFVLdlFGZTQ3dGQwYVc1ZTY3Z0h3YTRs?=
 =?utf-8?B?OTlMRDdoUHNVOGhaZ1BRRFFHZitSQ1RGZFAzWHhTbktOVzJWVHRjcnpQMjhi?=
 =?utf-8?B?bmJwZzQ3VGZyOW1IT0xQS2JKWTRuRStDUHExdE5tczc4VXFpL2dtWXlXZDl3?=
 =?utf-8?B?UXBGeWN4b0VwVnlNRXR1OFdsYzNVTHVmelBLU1pWcHJyVGN6Y3gyQVBRTlhw?=
 =?utf-8?B?TmF0cmhlL01uYlVBQkhYMGxTdEhjRDhrY292TEhERDJwT29sTzBSeGkvZjBE?=
 =?utf-8?B?U3h5SFZnSTlGQ01Vazg5VGdWSG5zWDVGYU1ZM2FjSG8yY2R1OS91MklVTXNw?=
 =?utf-8?B?bDBUYjFPMDQ0Y2h5RFNYVDBkNnhqUXdiQ3VVeXlPb0VGTStUaHZzVlFTUEFD?=
 =?utf-8?Q?P5eAo0QWiCWCxVsYJxzLe2ZYGh3KaoPH?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9265.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QUtVQUd1SnFqTHJEN05pb1pmNTdtS1NYWjRmSE5YcFJqMlVSV25GQWtnVkZy?=
 =?utf-8?B?MFV3QVl3QUUyYTdHVkhwYitidEJlSy9zS1kxUXZFeEJ3TVpQNWZhQm5sc0lk?=
 =?utf-8?B?a294ZkROaUlDTnlpZlJ3SDNEb1h2M1hJS3NlNUZKcUlDVEFsZ1MvTnNwa1Nn?=
 =?utf-8?B?a3MrRkFmVXZpWTJER0Z0QXE0TGtVVmVzbEdOZVZZTHhGSUsrYnYxVGU4bEFy?=
 =?utf-8?B?OEdVaTJRTXNxRUdBK3QycWlXdnpUaS8yT2wzMlNHUmJZdHRTVzFwWGJaUVor?=
 =?utf-8?B?RGowRUROaElMMDBBMXI4Q28vK2RMWGFXbzMvWEM4Umo0MnZ3azkrSGdPTkVt?=
 =?utf-8?B?Vm5sUGRIMmdkTUtVcjhaSmswR1I1dWlEa2dzUmpVdHJmODdsZGpjRHU4aHhG?=
 =?utf-8?B?b1U3MllVelhaK0w5WHk1L3hiOHdqQ0pjL2dRcUJxb2kxZFNFZG9TWUdybXlL?=
 =?utf-8?B?b2tnSUppeDBuUURpRWNQT0xWZUJRZ25pb21kMnc1aXJtTUI1WWFoZFJhSUcv?=
 =?utf-8?B?SndnZmI2SXNRZEtFTEtzczFUMi9vUTg1RStlVUNWakNUejNraGtxMVVhUVNU?=
 =?utf-8?B?WitSWG1TS3JlMWpQdnVzRVI5bWJoVTcxM0NtdWxDQUpXa29vYWVObHg0Zk04?=
 =?utf-8?B?a0lWM2JWcWdpVU16UmVKSmRqb2RLRkZCSGdid1dZS0RZUlVPVTdFdzRpK1VR?=
 =?utf-8?B?VU5vc0E4bnl0bGRER1N2REg0VjVmMGdaVFNETmlwczBPZXFPbEZjd2ZubE9u?=
 =?utf-8?B?bjV4ODZWZW40Nytlc1c1UUlwcnk4NUJLZDRCMTFOM2paemtQYU5wL253d3J6?=
 =?utf-8?B?U2t5ZXFySnJkTWIxZ0tUM0I5U3VmM2lXQmRPZjB2WlhMeStoM2tIbnZFT2JH?=
 =?utf-8?B?b2cvSGRCNjRaZURlbWdEZjVxTGhIZ2lwdmd4NEU5STJTT1dhRlArQWJ4UUtt?=
 =?utf-8?B?VXNSNmNhQ1dMa2VsT2taUWRZMExTTFBlbjN2VzcybGsrQWdLQTdjMjBPOUNj?=
 =?utf-8?B?N2E2Sk9rQTg0OUpQTWpUMnFyUW54UHo0dFlqMlQyU0VaZzlVeENMTWlzNzI3?=
 =?utf-8?B?ZUJnZjVLemp1MDYzaUVaNXEvcW1yTjQ3QWpJZXVibCtKdS9rY3ZNOEluR2Z6?=
 =?utf-8?B?V2V1d2NaSGFpcFZ6Z2w3V0hRMFVyR3ovSklYRXMwUm5iRzVnSlpKVSsyZ21H?=
 =?utf-8?B?UDdHMmFXdFR1dHhtOXo2Uld4SFdMZHdhY2paS2JsdlVqOFJGWEpQdDlaekVY?=
 =?utf-8?B?UE8rSHpXVDlRaXVodFRtQ2Fac0dIUjVpWnhWaWx3N0dqM0FTY1BPeHJad1hi?=
 =?utf-8?B?L0t1ZWpGK244N3lHMmxRWm05eDZydUlRa2JRVlo4L3FQREgvUXF2MVZkZDBW?=
 =?utf-8?B?YTEwbk1uZURVelkyMXZVQlQ5NDFUTmlvOEIva0t2RnhtcFdxamMyYkU0ejJB?=
 =?utf-8?B?WDQwdWx5OTJBbVYzdXhzVDBYSmdadFduKzFKRnM0Nzg0YVNKMk1aYlBuK2ZX?=
 =?utf-8?B?SXJ0eEZ1N0dnaHlLcHlFSzA5elZ1VkZ6Z3dhVTl4OVpYS09NWCtra2ZaYlhI?=
 =?utf-8?B?NXl6c2xHbHJaUHUzQ2FiUW41bUFYeFB5YU13NTdHT2RKYUxyT2tPS3J3L1Bz?=
 =?utf-8?B?WDIzWSsxcnpwUTFqOU9sVGNlaWdFUi9SSWF0VW9ZSkx1TUI5bkVtSXpNM0Vz?=
 =?utf-8?B?Tk5CWXhzdlNuc2VCVUdNaUdiQ1FkN1BBSUp3QjQrNXAvYjlHZFYyUytTVitR?=
 =?utf-8?B?MncvTWo5MHhTM1B3cVVaSmRZeDEyTjdRU29UY0p0YlRNTzRpUGgzTWlNS3pp?=
 =?utf-8?B?VGxVZmlyREVpMzlKSmM4Q0o1RmRONHRVQW1FRVBTM25qQlorV3lSNE5lcFJY?=
 =?utf-8?B?R2YvUXVkczYxd056eGxnV3p1Mkh0bmpmcnovUjdSNlI3SzRJRmJVT0NPbHZG?=
 =?utf-8?B?UlZuWUZsZTFEbGQyaStpTVZldHhTZC8xcmpINEN0VnVoc2Y5OC9odnF4enJw?=
 =?utf-8?B?cHFEZTdKVGNibDR0dHpqSUJIaWtsN2tTTzdiQmVocmhsVzF5N1F1Ulk1YUti?=
 =?utf-8?B?Z2pJb0JVdmtUcjVsUVdUazU1MWtuVjkyNGVoMEd0UXIzbEVtc1ZhVmI1MXB3?=
 =?utf-8?Q?A5sM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9265.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d90dc9eb-8421-4381-b547-08dd4f92fc8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2025 20:38:07.7185
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: we4+NPlpbhaYxdKaHk3DTovgR6SGU5whYFXIHNWdNJxmxZL/PDw4PGRiK++rHyaP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8964

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKb3NoIFBvaW1ib2V1ZiA8
anBvaW1ib2VAa2VybmVsLm9yZz4NCj4gU2VudDogTW9uZGF5LCBGZWJydWFyeSAxNywgMjAyNSAy
OjE5IFBNDQo+IFRvOiBLYXBsYW4sIERhdmlkIDxEYXZpZC5LYXBsYW5AYW1kLmNvbT4NCj4gQ2M6
IFRob21hcyBHbGVpeG5lciA8dGdseEBsaW51dHJvbml4LmRlPjsgQm9yaXNsYXYgUGV0a292IDxi
cEBhbGllbjguZGU+OyBQZXRlcg0KPiBaaWpsc3RyYSA8cGV0ZXJ6QGluZnJhZGVhZC5vcmc+OyBQ
YXdhbiBHdXB0YQ0KPiA8cGF3YW4ua3VtYXIuZ3VwdGFAbGludXguaW50ZWwuY29tPjsgSW5nbyBN
b2xuYXIgPG1pbmdvQHJlZGhhdC5jb20+OyBEYXZlDQo+IEhhbnNlbiA8ZGF2ZS5oYW5zZW5AbGlu
dXguaW50ZWwuY29tPjsgeDg2QGtlcm5lbC5vcmc7IEggLiBQZXRlciBBbnZpbg0KPiA8aHBhQHp5
dG9yLmNvbT47IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQ
QVRDSCB2MyAyMC8zNV0geDg2L2J1Z3M6IERlZmluZSBhdHRhY2sgdmVjdG9ycw0KPg0KPiBDYXV0
aW9uOiBUaGlzIG1lc3NhZ2Ugb3JpZ2luYXRlZCBmcm9tIGFuIEV4dGVybmFsIFNvdXJjZS4gVXNl
IHByb3BlciBjYXV0aW9uDQo+IHdoZW4gb3BlbmluZyBhdHRhY2htZW50cywgY2xpY2tpbmcgbGlu
a3MsIG9yIHJlc3BvbmRpbmcuDQo+DQo+DQo+IE9uIE1vbiwgRmViIDE3LCAyMDI1IGF0IDA1OjMz
OjI0UE0gKzAwMDAsIEthcGxhbiwgRGF2aWQgd3JvdGU6DQo+ID4gU28gYWN0dWFsbHkgdGhpcyBk
b2Vzbid0IHF1aXRlIHdvcmsgYmVjYXVzZSB0aGUgY29kZSBpbg0KPiA+IGFyY2gveDg2L21tL3B0
aS5jIGhhcyB0byBjYWxsIGNwdV9taXRpZ2F0ZV9hdHRhY2tfdmVjdG9yIGluIG9yZGVyIHRvDQo+
ID4gY2hlY2sgaWYgUFRJIGlzIHJlcXVpcmVkIChpdCBjaGVja3MgaWYgdXNlci0+a2VybmVsIG1p
dGlnYXRpb25zIGFyZQ0KPiA+IG5lZWRlZCkuICBUaGF0J3MgdGhlIG9ubHkgdXNlIG9mIHRoZSBh
dHRhY2sgdmVjdG9ycyBvdXRzaWRlIG9mIGJ1Z3MuYy4NCj4gPg0KPiA+IFRoZSBvcmlnaW5hbCBj
b2RlICh1c2luZyBhIGZ1bmN0aW9uIGFuZCBXQVJOX09OX09OQ0UpIGNhbiB3b3JrLCBvciBJDQo+
ID4gY291bGQgcGVyaGFwcyBjcmVhdGUgYSBwdGktc3BlY2lmaWMgZnVuY3Rpb24gaW4gYnVncy5j
IHRoYXQgdGhlIHB0aQ0KPiA+IGNvZGUgY2FuIHF1ZXJ5LiAgQnV0IHJpZ2h0IG5vdyBJIGRvbid0
IHRoaW5rIHRoZXJlIGlzIGFueSBwdGktcmVsYXRlZA0KPiA+IGNvZGUgaW4gYnVncy5jIGF0IGFs
bC4NCj4gPg0KPiA+IEFueSBzdWdnZXN0aW9uPw0KPg0KPiBIbS4gIFdlICpjb3VsZCogcHV0IHRo
ZSBjcHVfbWl0aWdhdGVfYXR0YWNrX3ZlY3RvcigpIG1hY3JvIGluIGJ1Z3MuaCBhbmQgbWFrZSB0
aGUNCj4gYXJyYXkgZ2xvYmFsIChhbmQgcG9zc2libHkgZXhwb3J0ZWQpLiAgVGhhdCB3YXkgYW55
Ym9keSBjb3VsZCBjYWxsIGl0LCBidXQgaXQgd291bGQgc3RpbGwNCj4gaGF2ZSB0aGUgY29tcGls
ZS10aW1lIGNoZWNrLg0KPg0KPg0KPiBIb3dldmVyLi4uIHNob3VsZCB0aGVzZSBub3QgYWN0dWFs
bHkgYmUgYXJjaC1nZW5lcmljIG9wdGlvbnMsIGxpa2UgbWl0aWdhdGlvbnM9DQo+IGFscmVhZHkg
aXM/ICBJdCB3b3VsZCBtYWtlIGZvciBhIG1vcmUgY29uc2lzdGVudCB1c2VyIGludGVyZmFjZSBh
Y3Jvc3MgYXJjaGVzLg0KDQpUaGF0J3Mgd2hhdCBJIGhhZCBpbiBteSBwYXRjaCBzZXJpZXMgdXAg
dW50aWwgdGhpcyBvbmUuICBCb3JpcyBzYWlkIHRvIG1vdmUgdGhlbSB0byB4ODYtc3BlY2lmaWMg
Y29kZSBiZWNhdXNlIG5vYm9keSBlbHNlIGlzIHVzaW5nIHRoZW0geWV0IGFuZCBzb21lYm9keSBk
b3duIHRoZSByb2FkIGNvdWxkIG1vdmUgdGhlbS4NCg0KSSBkbyBhZ3JlZSB0aGF0IHRoZXkgY2Fu
IGJlIGFyY2gtZ2VuZXJpYyAoaGVuY2Ugd2h5IEkgb3JpZ2luYWxseSBwdXQgdGhlbSBpbiBrZXJu
ZWwvY3B1LmMpIGJ1dCBJIGFsc28gZG9uJ3Qga25vdyB3aGVuIChpZiBldmVyKSBhbnlvbmUgZnJv
bSBvdGhlciBhcmNocyB3aWxsIHdhbnQgdG8gcGljayB0aGVtIHVwLg0KDQo+DQo+IFRoZXkgY291
bGQgZXZlbiBiZSBpbnRlZ3JhdGVkIGludG8gdGhlICJtaXRpZ2F0aW9ucz0iIGludGVyZmFjZS4g
IFRoZSBvcHRpb25zIGNvdWxkDQo+IGJlIGNvbWJpbmVkIGluIGFueSBvcmRlciAoc2VwYXJhdGVk
IGJ5IGNvbW1hcyk6DQo+DQo+ICAgbWl0aWdhdGlvbnM9dXNlcl9rZXJuZWwsdXNlcl91c2VyDQo+
ICAgbWl0aWdhdGlvbnM9Z3Vlc3RfaG9zdCx1c2VyX2tlcm5lbA0KPiAgIC4uLmV0Yy4uLg0KPg0K
PiBBbmQgZS5nLiwgIm1pdGlnYXRpb25zPW9mZiIgd291bGQgc2ltcGx5IGRpc2FibGUgYWxsIHRo
ZSB2ZWN0b3JzLg0KDQpIbW0sIHRoYXQncyBhbiBpbnRlcmVzdGluZyBpZGVhLiAgSSBhc3N1bWUg
dGhhdCBhbnkgdmVjdG9ycyBub3QgbGlzdGVkIHdvdWxkIGJlIGNvbnNpZGVyZWQgJ29mZicsIHVu
bGVzcyBubyBtaXRpZ2F0aW9ucz0gd2FzIHNwZWNpZmllZCwgb3IgbWl0aWdhdGlvbnM9YXV0byB3
YXMgc3BlY2lmaWVkIGluIHdoaWNoIGNhc2UgdGhleSdkIGRlZmF1bHQgdG8gJ29uJyBsaWtlIHRo
ZXkgZG8gdG9kYXkuDQoNCkluIG90aGVyIHdvcmRzOg0KbWl0aWdhdGlvbnM9YXV0bw0KICA9PiBh
bGwgNCB2ZWN0b3JzIGFyZSAnb24nDQptaXRpZ2F0aW9ucz11c2VyX2tlcm5lbA0KICA9PiB1c2Vy
X2tlcm5lbCBpcyAnb24nLCBhbGwgb3RoZXJzIGFyZSAnb2ZmJw0KDQpUaGF0IHdvdWxkIGFsc28g
aW1wbHkgdGhhdDoNCm1pdGlnYXRpb25zPXVzZXJfa2VybmVsIG1pdGlnYXRpb25zPXVzZXJfdXNl
cg0KDQpXb3VsZCBhY3R1YWxseSBtZWFuIHRoYXQgdXNlcl91c2VyIGlzICdvbicgYW5kIGV2ZXJ5
dGhpbmcgaXMgJ29mZicuICBOb3Qgc3VyZSBpZiB0aGF0J3MgYW4gaXNzdWUgb3Igd291bGQgYmUg
c3VmZmljaWVudGx5IG9idmlvdXMuDQoNClRoZW4gYSBxdWVzdGlvbiBpcyBob3cgdG8gaW50ZWdy
YXRlIHRoZSBtaXRpZ2F0ZV9zbXQgb3B0aW9uIHdlIHdlcmUganVzdCBkaXNjdXNzaW5nIHNpbmNl
IHRoYXQgbmVlZHMgYSAzLXdheSBzZWxlY3QuICBPciBwZXJoYXBzIGtlZXAgdGhhdCBvbmUgYXMg
YSBzZXBhcmF0ZSBjb21tYW5kIGxpbmUgb3B0aW9uLg0KDQo+DQo+IFRoYXQgd291bGQgcmVtb3Zl
IGFtYmlndWl0eSBjcmVhdGVkIGJ5IGNvbWJpbmluZyBtaXRpZ2F0aW9ucz0gd2l0aA0KPiBtaXRp
Z2F0ZV8qIGFuZCB3b3VsZCBtYWtlIGl0IGVhc2llciBmb3IgYWxsIHRoZSBjdXJyZW50DQo+IGNw
dV9taXRpZ2F0aW9uc19vZmYoKSBjYWxsZXJzOiBvbmx5IG9uZSBnbG9iYWwgZW5hYmxlL2Rpc2Fi
bGUgaW50ZXJmYWNlIHRvIGNhbGwgaW5zdGVhZA0KPiBvZiB0d28uICBBbnkgY29kZSBjYWxsaW5n
IGNwdV9taXRpZ2F0aW9uc19vZmYoKSBzaG91bGQgcHJvYmFibHkgYmUgY2FsbGluZyBzb21ldGhp
bmcNCj4gbGlrZSBjcHVfbWl0aWdhdGVfYXR0YWNrX3ZlY3RvcigpIGluc3RlYWQuDQo+DQo+IGNw
dV9taXRpZ2F0aW9uc19vZmYoKSBhbmQgY3B1X21pdGlnYXRpb25zX2F1dG9fbm9zbXQoKSBjb3Vs
ZCBiZSBkZXByZWNhdGVkIGluDQo+IGZhdm9yIG9mIG1vcmUgdmVjdG9yLXNwZWNpZmljIGludGVy
ZmFjZXMsIGFuZCBjb3VsZCBiZSByZW1vdmVkIG9uY2UgYWxsIHRoZSBhcmNoZXMNCj4gc3RvcCB1
c2luZyB0aGVtLiAgVGhleSBjb3VsZCBiZSBnYXRlZCBieSBhIHRlbXBvcmFyeQ0KPiBBUkNIX1VT
RVNfTUlUSUdBVElPTl9WRUNUT1JTIG9wdGlvbi4gIEFzIGNvdWxkIHRoZSBwZXItdmVjdG9yIGNt
ZGxpbmUNCj4gb3B0aW9ucy4NCj4NCj4gVGhvdWdodHM/DQo+DQoNCkknbSBub3Qgc3VyZSB0aGVy
ZSBpcyByZWFsbHkgdGhhdCBtdWNoIGFtYmlndWl0eS4uLnRoZSBnbG9iYWwgbWl0aWdhdGlvbnM9
b2ZmIGlzIHRoZSBiaWcgYnV0dG9uIHRoYXQgZGlzYWJsZXMgZXZlcnl0aGluZy4gIEkgZG9uJ3Qg
dGhpbmsgd2UgY2FuIGNoYW5nZSB0aGF0Lg0KDQpJIHRoaW5rIHRoZSBvdGhlciBpc3N1ZSBoZXJl
IG1heSBiZSB0aGF0IHRoZSBhdHRhY2sgdmVjdG9ycyBhcmUgZGVmaW5lZCB0byBiZSByYXRoZXIg
bG93LXByaW9yaXR5IGluIHRlcm1zIG9mIHNlbGVjdGlvbi4gIFRoYXQgaXMsIHlvdSBjYW4gZGlz
YWJsZSBhbGwgdGhlIGF0dGFjayB2ZWN0b3JzIGJ1dCB0aGVuIHN0aWxsIGVuYWJsZSBhbiBpbmRp
dmlkdWFsIGJ1ZyBmaXguDQoNCkluIG90aGVyIHdvcmRzLCBpZiB5b3Ugd2VyZSB0byByZXBsYWNl
IGNwdV9taXRpZ2F0aW9uc19vZmYoKSB3aXRoIGEgZnVuY3Rpb24gbG9va2luZyBmb3IgYWxsIGF0
dGFjayB2ZWN0b3JzIHRvIGJlIG9mZiwgdGhhdCBpc24ndCBxdWl0ZSBjb3JyZWN0IGJlY2F1c2Ug
b2YgdGhlIHByaW9yaXR5IGRpZmZlcmVuY2UuDQoNCi0tRGF2aWQgS2FwbGFuDQo=

