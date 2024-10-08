Return-Path: <linux-kernel+bounces-355401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C529951B6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 16:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65A8A1C25551
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 14:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29AE1DFDAC;
	Tue,  8 Oct 2024 14:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0PEy7a2L"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2056.outbound.protection.outlook.com [40.107.102.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AC11DF971
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 14:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728397726; cv=fail; b=YEB1fXvMFAkBroIJ9KNGCnuXX0ExRYfhmyu6TfkenMJufqQvCuiQdozDLBrIN4ctqeaRGxdP7YHHxUPpQ24zlG5/jJxas3+P3UzR46twIQWKQUt6tjclCi/Z8VSH0saubeUdCfTCGFXS94ryE8c6y396BvUwwolqaD4FcVHpZnE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728397726; c=relaxed/simple;
	bh=ii9zU5HviL+s0KiOcw1ClkWMFaUOuzNwz2bTc7y3wFQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SS1+PQKKLWYyWA+EF7i8CAtRjToMOvd1bnCj6bWepRl3wrzlI/SePcoNUJ51xz/HaFzD6RDbFaiu/06S7+Fmz5YSwZGfnq/YgVoEXwTIUAVR5FyUOF+M/rOHQk25rgR9l/dCa/1JjhZhKqABC+Iuhyx/z2etwtd69/VrhdLyCrY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0PEy7a2L; arc=fail smtp.client-ip=40.107.102.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f1A2ZRWM6al35MjF9oXbWASWVoQ3TdSqkZrSvIK0h51pS1BH2h7n67bkgu4LiJ/33acIKc25LvBDorJS9zXxprrwZY0Yf4G5l+G6WM7DHWGxUjbqVCALNPRSrN6/aqfxunWzyMzSl0rqMpxdrIwl5Rau8qnrTI5/6W0E17VRp8HbgR5iu9T2Ev/xqA0Z/UdorKoo9CGummYW5wSfPePpOdOP2hbrRQWOznwrivz8MsnUXMzMNv3ObvMGDHCLaH+5ODItVIQpPnJhS3/hoBMBfQ++rSHqH8Ew7Snm3F2d7eH/qFPm19xYx6AnIH5wIdHH5cz8uS63hpOoSQq82vnJzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ii9zU5HviL+s0KiOcw1ClkWMFaUOuzNwz2bTc7y3wFQ=;
 b=IKyNPykR4vvD4i7jfhCJeM2mVzWQhzQoUCaIpi821+fyKtaydx5KZBz3VIYlNXgdwsXmK1CoMNLuLruVTohMc0Z/nepuvMIekEg8vfrACu4hdMsrl4Jm9RXRaASU+hq9Zx3+6nvS17h4FsaZqMLTiTXLGV2W0+7xH5MbhMlKcumOZLM1brVAEC53VAyHLjI0Wkqg9EeV1w4Y3fV4Fbm+T80kzflOlJuEOxgSkiMQY5AIi5VjJ+cKGL84RtYOWtc7M23DDU1Iiq6s4d8UjwPAqw86zQeZqXK4HlhRhBQprh/8ilsLPp+5xkh/NUCGvZ93I2QVLRD7ypFnkSHGCBhBsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ii9zU5HviL+s0KiOcw1ClkWMFaUOuzNwz2bTc7y3wFQ=;
 b=0PEy7a2LLMb7bXQnpbq3gbUCJmddjsJdNW1/sI2TIELjYBlax4Unjl2NZsuEmHg8KSYjhXlHBe2zlbN7E2wucrrZ2OyMywg5XFBLebycyQxcSmAKqnm605oTW+hmDTHbiC0Chi+rQPeKQOTVfzWY5KFE9C94/2RSj2pfIIhfX0A=
Received: from LV3PR12MB9265.namprd12.prod.outlook.com (2603:10b6:408:215::14)
 by SA1PR12MB7246.namprd12.prod.outlook.com (2603:10b6:806:2bc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 14:28:41 +0000
Received: from LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427]) by LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427%4]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 14:28:41 +0000
From: "Kaplan, David" <David.Kaplan@amd.com>
To: Nikolay Borisov <nik.borisov@suse.com>, Thomas Gleixner
	<tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Peter Zijlstra
	<peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>, Pawan Gupta
	<pawan.kumar.gupta@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Dave
 Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, "H .
 Peter Anvin" <hpa@zytor.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH 11/34] x86/bugs: Restructure retbleed mitigation
Thread-Topic: [RFC PATCH 11/34] x86/bugs: Restructure retbleed mitigation
Thread-Index: AQHbGVyx1f5W5FZWPkqXj2YxbqpMlLJ86eOw
Date: Tue, 8 Oct 2024 14:28:41 +0000
Message-ID:
 <LV3PR12MB9265EBFEECC97FA448039B34947E2@LV3PR12MB9265.namprd12.prod.outlook.com>
References: <20240912190857.235849-1-david.kaplan@amd.com>
 <20240912190857.235849-12-david.kaplan@amd.com>
 <bb0ad741-6474-4668-a895-2554cdcb8b33@suse.com>
In-Reply-To: <bb0ad741-6474-4668-a895-2554cdcb8b33@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=876fbc59-5b6a-4fb5-b6f6-fe7bb4cc7fd5;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-10-08T14:28:13Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9265:EE_|SA1PR12MB7246:EE_
x-ms-office365-filtering-correlation-id: 48120d31-fc52-4e39-a1b9-08dce7a58206
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?amFGYU5KQU4ybEZxYjd6Z1B6Vmo3dkpnVUN0SHA0Tm5UcXR0Z1UraDVTeWpP?=
 =?utf-8?B?ck5hckVLeFloQjBwMElmOC9PQm1xWXpTdXBwZ2t2ZUFzV2RPTE9vS1BiZHBZ?=
 =?utf-8?B?dEhTWDFrZzZQZExNazFadDZ1akE3RFcvT25RanhObjJ5REpLV292akViSEY0?=
 =?utf-8?B?Zm5ZYlo3YUdhbFhjNEFsbjVoMkpyWDVRYjFrUGM0SXpHeW81Q2YybE9Td3Iz?=
 =?utf-8?B?ckFDdkVYTG1TM0Z2NW9OMU9XeERPd09VbU1EZkZiVmd2dlRYQ3NPN2lHOXVW?=
 =?utf-8?B?Y3FqSjBxYzYwV0k4N0gyeW1SL2UvMUg3aCt4VWd0U1k2U0lQNHFVWFQ3aCtx?=
 =?utf-8?B?eU04dHB5QU95VTVIbWdhUmhSVm9KWVhnQjg3YnRZKzZvYzMrbE1xaDBpMVhp?=
 =?utf-8?B?NWRFMTJWekJlSzVhaUUwWlVvbnNQZ1lKMWhPZEplOVRZWUw3NFFNQWN2RjY3?=
 =?utf-8?B?MnZSMDNHM1ZMcEpkZVpheDJTNEh1VWUzVVp3Y1dlc1FUS0ErSnlGb2lFRktj?=
 =?utf-8?B?WndoejFaZ0s5SVJabG9oTXpCWkYwY2NJdVphUmdWblk4ZWlqKysvMW13b01Q?=
 =?utf-8?B?YVN3NEM4bmN4Ry8rVmY2Q3hQejBEK0FDaFFNeWkxMEJBQXRPUG5NbUtVT0lk?=
 =?utf-8?B?OEhFaGwvcmU3QXdiVzJjdVFSR0p4UUUwQlJsWk11QUI1L1VUN01sL1MraGNS?=
 =?utf-8?B?MGtyTXZ5TFAxQ0Y1WkhQNUgvbEtJZW9PcDhVeXI2aHRNRkpmdm5UaUVHV1lZ?=
 =?utf-8?B?ZS9uOGFaMnYvZWNPbk1Ud0xvYlY1emJWMmNVcy93WmZlaVJVL2lqNGY3aGtk?=
 =?utf-8?B?VTlQS3BYSENqOGZXWEZIZ1V0dVlsTU5nTnk3a05RZGE2MWJ4QWFSdkdrRXl2?=
 =?utf-8?B?cUU1Nmt4KzlWbjJPZUVyNnpaSE1DRTBJU3BVTUlDa1ZOc1VBQ0l4K29DamFY?=
 =?utf-8?B?SHpXZkJ0bkx6UmxoK0Z4bldjNnJWTjR4Q2FRNTlzL2pHcGN0WXFuRThDaFRG?=
 =?utf-8?B?ZkptZWcvS1dLSUNsN25ac1dVcXN2YXcrTE82YXZlRGcwZGtGckg0WkhsdTFn?=
 =?utf-8?B?ZDlwRE9HS2E5QlowTTJ3dGU2OCtZNUFCTis5VFV0SDJtV2tVS0JCYURDZHAx?=
 =?utf-8?B?aGNiZXNQSmRnQlFCdFdGZzYxcUhGUndkMFcvdjJkWEpZSVRONDM0RFQzNnRY?=
 =?utf-8?B?MWdtSFNrSjI4V211RlNOOEhxdmwwRFVqWTllMFBId3VQeE0rVDBpU3doTVNO?=
 =?utf-8?B?Y3ZjNlhpRzNrYzlGSGRXTFRtckRNWmhYWWZ4Y1VBK0dzbmozLzMzWFhyazd5?=
 =?utf-8?B?RHhSSklvQ3FiWjdyZXBFMzI0d2ZKcXNUSGpIamJicEFWSEZDZkh6ajNuZ2hp?=
 =?utf-8?B?YXRBdDhCVzF2TUtVVnVDT2pRZi9zVFJBTzdFa1VzVnlXWVk0SnZmU2xZMHVw?=
 =?utf-8?B?OWs1ZXVMQ2M4ZExpamVpSlY0UkdubGxhMVdTQ2JNOUQ2Lzg1bG1JbkZzWjds?=
 =?utf-8?B?QkR0bmxic3hXNlo5UjZSZHh5OE9WMDNJaG5lbitFQkpDbzBtR0tDeE1GWjdZ?=
 =?utf-8?B?Tk9BZmxMNFlQeWN4ZStycnRvTjBpUDNPZUJXY1hIaktKYVMxMzVJUHRxNTNX?=
 =?utf-8?B?TjdKQzZHek1nQjB1YVVxVUZBbGVRdkpSVm5zVnBIUE9uS1l1OU9VaWFqYnp0?=
 =?utf-8?B?aGZjN3hhVFA5eFpvNUgvNDhLMWpra3ZlZTRKM2VRNENlR3NRYzY0Vk5pSUJn?=
 =?utf-8?B?SHcrYW5xUmkvTkt5aEZ6U1BVTC93VFBlT29mN2gzNk50c2I3SkMzdFdMVVNo?=
 =?utf-8?Q?AA1OMJrrqIlq+myovO+lLNWPfzwUb4o0Ym6po=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9265.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YjdSbG5PL1c0UUVHUEtiQXg3YW5zcGlRd21GZVVmbUtHWFI0OWhPajBxbXB4?=
 =?utf-8?B?eGFTdXZKL1VZSTJ3YWdCYXJhVXIvRk44MFJPM2Q1T2Y1blZHR0pycmY0VnFR?=
 =?utf-8?B?RGh0eDVmcDBrT000U2oxYU1MSGxaMndhM1lDMXNFWlRWS0lCVVFvL214YVpB?=
 =?utf-8?B?d2pxaWFnSmxwTDU3WnZGNW9oUnlPMnpWSWJpa29ZZFUwRVlqTGZhWVU0c0dq?=
 =?utf-8?B?UzRxR0pXb2x2NjIzZUUzeGtzSUpYdUtOWmpkQmpuUVo4Z1dKTUZvSlN2Z0Vz?=
 =?utf-8?B?QWRQQ2Q1ZnBGRnhKWGswSFA2R2R1QTFMQi9GNG9jWEJpSlJucHltTFBDL2FQ?=
 =?utf-8?B?TnI4WDNZQWNGNVpQZDZWRnYxaEhiL2VRYlN3N092dXZ4c2phYnhNSEt4aGxI?=
 =?utf-8?B?Tk9EMDhzQ3JGaTNGVGwvTmQ3dXl5UTZlODAxcGxxa3VqWkRHNndUY2JRM1pI?=
 =?utf-8?B?aUtWbFpLc1BtQnU1Y21ZbU56OVpqTHcwa0RDbUFmMzExQjNiZFh6ZjlxZGQr?=
 =?utf-8?B?amExUTNmVVFseEFEL2VHSjBrYTVjTzBlZEJUSTZLRXZ2dHNyMDJYVE1LaGJX?=
 =?utf-8?B?U0tqVm55V25XVEJ5VGIvWUgyODhqNzJDTVZpc3B2VncrQllPNnVBeG9sUUhI?=
 =?utf-8?B?elpmeVZaYXI4bVRybGpRU3Z5WjZOWlkrSlZMTlF1eUtOQTJrU3pnTjdRaTMx?=
 =?utf-8?B?b2c2aUpXeWZjaDJUWmNuaVd6cWpHUUUyQlE0eE45MDRaak93eHNuMXhra1lo?=
 =?utf-8?B?Um1kQUFreUdTZXZOSEV4K0F2Q3Z1U21Qd3FLUnJWM3Mwbmp4L05uZEdET2Yy?=
 =?utf-8?B?SkFENHdxUmdJb2JhTVdrNEpEZTNDZHZVSnFYMnI2eng3WXE0MDJPeDg2Ujly?=
 =?utf-8?B?dEFyZmlVb2luTGFWUVJlVE96MlhSVjdYSzdsZ2k2aU5BcE1UN0hWbFpxRkNx?=
 =?utf-8?B?VDBkV1lDVCtPMTFQTDVCMlI2K0hCK1p3UnhhRmFjL1lsYXE1QjAra3N4MEtU?=
 =?utf-8?B?dDV2TjdudW0xSVFyeDZ2R2M4SGNsU1AwQ2RybVI0Ti84ODZqL3hFNlk0eVZC?=
 =?utf-8?B?a3UzTjFDeTdLdWJpUmU4ZDVhTzlSSVBYc3Zlc3I0ZHBYa2xDRkpidjdyWFcw?=
 =?utf-8?B?TUJzOW5pWkNLNEFUSHNFakw3TW9CZkNsb1V4NE50OFBMcW5QZ2pZbFBlckFX?=
 =?utf-8?B?L1FQRGcvd2VMai9VSnZkU1Z0ellXZm9iUFVZQzNBSlY0ZkpRKytLTU5EU1hC?=
 =?utf-8?B?dEt3K29US0dmbUNhQ28xbzB2c0srN2EwdThUVFBRRmtCQnU2U2dpM1hZNnl5?=
 =?utf-8?B?b1NWWXlBeVYzcjZLanpoeXRsY0NiUTVGakVoKzZkNHZ2cnRURjBQTjNkV3U1?=
 =?utf-8?B?Tms5RTBYMGhOWkoxTVRuRDNyeWh1SUlQbkpZYWkvS3BzcHM2SEM5Wnc5Tnov?=
 =?utf-8?B?bWhzeWhRMy8zeFpMaFBDMWFvNkJGZVFYblg3WU5UZXVCMUc0c0JMWWVRLzFE?=
 =?utf-8?B?WmtpeHZiSmNLRkxmQ0JFbUMrSjFlekNYMFUxYUl3UDk5MW1TSHFsY2FpSFVt?=
 =?utf-8?B?VHZrWEpwcmNMc1VUdVF2dzgxLytmZVdkZU11ZThHc2FZSUFzV1VyY2FJcUVj?=
 =?utf-8?B?SUc0YU1Vd1REL1RiQ0IzRGp4bjJwdXpwelRzSXdVRFlCYmVPZXI3cVJKR0Fr?=
 =?utf-8?B?SlBwMlREYzkwdGsrS0tIdTZoTyt5azFCOE4wVXhheDk3bmhGMDFNbmxIKzV1?=
 =?utf-8?B?azVlN2tjbGJ5d1R2bGMwM1VVQUFKaEwrK1lyT0o5QUwvZHdwMWVXaWI2am03?=
 =?utf-8?B?Y2pSNEo3cUNJUDM4UkxPZXVMTE9SbElURmg3TGhYM25rNmFxajVDbnJFckU2?=
 =?utf-8?B?ZUxaOVFleHN1SWR4Yk56Qm1LMmVKUnZvclRhN2hrallVc0xZY1ZWeTc4Vm9a?=
 =?utf-8?B?ZDd5NzViQ2VXaEYvMHZ3TVBkbUkvcUZkQW1WbG53MktqZU82aWhwYUFweDE1?=
 =?utf-8?B?eGR1c2k2ZlNyMFBkekhSQkorYzVuY2N5bzBReUdqQUxXdVJvR0hwRCtBbWli?=
 =?utf-8?B?eHpLbGtiSGR6YVFobE4xRkZjUnJoR2h5YkM5YTZYK0FlUEdpZXpicndtNlAy?=
 =?utf-8?Q?9R60=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 48120d31-fc52-4e39-a1b9-08dce7a58206
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2024 14:28:41.6274
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UlQNFBepN5UMXNbaGhpDPqSKQqoR0B3pnwEJV0KkfArLhcdFk6x2MUnMLF/0INNG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7246

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBOaWtvbGF5IEJvcmlzb3Yg
PG5pay5ib3Jpc292QHN1c2UuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBPY3RvYmVyIDgsIDIwMjQg
MzozMyBBTQ0KPiBUbzogS2FwbGFuLCBEYXZpZCA8RGF2aWQuS2FwbGFuQGFtZC5jb20+OyBUaG9t
YXMgR2xlaXhuZXINCj4gPHRnbHhAbGludXRyb25peC5kZT47IEJvcmlzbGF2IFBldGtvdiA8YnBA
YWxpZW44LmRlPjsgUGV0ZXIgWmlqbHN0cmENCj4gPHBldGVyekBpbmZyYWRlYWQub3JnPjsgSm9z
aCBQb2ltYm9ldWYgPGpwb2ltYm9lQGtlcm5lbC5vcmc+OyBQYXdhbiBHdXB0YQ0KPiA8cGF3YW4u
a3VtYXIuZ3VwdGFAbGludXguaW50ZWwuY29tPjsgSW5nbyBNb2xuYXIgPG1pbmdvQHJlZGhhdC5j
b20+OyBEYXZlDQo+IEhhbnNlbiA8ZGF2ZS5oYW5zZW5AbGludXguaW50ZWwuY29tPjsgeDg2QGtl
cm5lbC5vcmc7IEggLiBQZXRlciBBbnZpbg0KPiA8aHBhQHp5dG9yLmNvbT4NCj4gQ2M6IGxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtSRkMgUEFUQ0ggMTEvMzRd
IHg4Ni9idWdzOiBSZXN0cnVjdHVyZSByZXRibGVlZCBtaXRpZ2F0aW9uDQo+DQo+IENhdXRpb246
IFRoaXMgbWVzc2FnZSBvcmlnaW5hdGVkIGZyb20gYW4gRXh0ZXJuYWwgU291cmNlLiBVc2UgcHJv
cGVyIGNhdXRpb24NCj4gd2hlbiBvcGVuaW5nIGF0dGFjaG1lbnRzLCBjbGlja2luZyBsaW5rcywg
b3IgcmVzcG9uZGluZy4NCj4NCj4NCj4gT24gMTIuMDkuMjQg0LMuIDIyOjA4INGHLiwgRGF2aWQg
S2FwbGFuIHdyb3RlOg0KPiA+IFJlc3RydWN0dXJlIHJldGJsZWVkIG1pdGlnYXRpb24gdG8gdXNl
IHNlbGVjdC91cGRhdGUvYXBwbHkgZnVuY3Rpb25zDQo+ID4gdG8gY3JlYXRlIGNvbnNpc3RlbnQg
dnVsbmVyYWJpbGl0eSBoYW5kbGluZy4gIFRoZQ0KPiA+IHJldGJsZWVkX3VwZGF0ZV9taXRpZ2F0
aW9uKCkgc2ltcGxpZmllcyB0aGUgZGVwZW5kZW5jeSBiZXR3ZWVuIHNwZWN0cmVfdjIgYW5kDQo+
IHJldGJsZWVkLg0KPiA+DQo+ID4gVGhlIGNvbW1hbmQgbGluZSBvcHRpb25zIG5vdyBkaXJlY3Rs
eSBzZWxlY3QgYSBwcmVmZXJyZWQgbWl0aWdhdGlvbg0KPiA+IHdoaWNoIHNpbXBsaWZpZXMgdGhl
IGxvZ2ljLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogRGF2aWQgS2FwbGFuIDxkYXZpZC5rYXBs
YW5AYW1kLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGFyY2gveDg2L2tlcm5lbC9jcHUvYnVncy5jIHwg
MTY4ICsrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiAgIDEgZmlsZSBj
aGFuZ2VkLCA3MyBpbnNlcnRpb25zKCspLCA5NSBkZWxldGlvbnMoLSkNCj4gPg0KPg0KPiA8c25p
cD4NCj4NCj4gPiAgIHN0YXRpYyB2b2lkIF9faW5pdCByZXRibGVlZF9zZWxlY3RfbWl0aWdhdGlv
bih2b2lkKQ0KPiA+ICAgew0KPiA+IC0gICAgIGJvb2wgbWl0aWdhdGVfc210ID0gZmFsc2U7DQo+
ID4gLQ0KPiA+ICAgICAgIGlmICghYm9vdF9jcHVfaGFzX2J1ZyhYODZfQlVHX1JFVEJMRUVEKSB8
fCBjcHVfbWl0aWdhdGlvbnNfb2ZmKCkpDQo+ID4gICAgICAgICAgICAgICByZXR1cm47DQo+ID4N
Cj4gPiAtICAgICBzd2l0Y2ggKHJldGJsZWVkX2NtZCkgew0KPiA+IC0gICAgIGNhc2UgUkVUQkxF
RURfQ01EX09GRjoNCj4gPiAtICAgICAgICAgICAgIHJldHVybjsNCj4gPiAtDQo+ID4gLSAgICAg
Y2FzZSBSRVRCTEVFRF9DTURfVU5SRVQ6DQo+ID4gLSAgICAgICAgICAgICBpZiAoSVNfRU5BQkxF
RChDT05GSUdfTUlUSUdBVElPTl9VTlJFVF9FTlRSWSkpIHsNCj4gPiAtICAgICAgICAgICAgICAg
ICAgICAgcmV0YmxlZWRfbWl0aWdhdGlvbiA9IFJFVEJMRUVEX01JVElHQVRJT05fVU5SRVQ7DQo+
ID4gLSAgICAgICAgICAgICB9IGVsc2Ugew0KPiA+ICsgICAgIHN3aXRjaCAocmV0YmxlZWRfbWl0
aWdhdGlvbikgew0KPiA+ICsgICAgIGNhc2UgUkVUQkxFRURfTUlUSUdBVElPTl9VTlJFVDoNCj4g
PiArICAgICAgICAgICAgIGlmICghSVNfRU5BQkxFRChDT05GSUdfTUlUSUdBVElPTl9VTlJFVF9F
TlRSWSkpIHsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgcmV0YmxlZWRfbWl0aWdhdGlvbiA9
IFJFVEJMRUVEX01JVElHQVRJT05fQVVUTzsNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgcHJf
ZXJyKCJXQVJOSU5HOiBrZXJuZWwgbm90IGNvbXBpbGVkIHdpdGgNCj4gTUlUSUdBVElPTl9VTlJF
VF9FTlRSWS5cbiIpOw0KPiA+IC0gICAgICAgICAgICAgICAgICAgICBnb3RvIGRvX2NtZF9hdXRv
Ow0KPiA+ICAgICAgICAgICAgICAgfQ0KPiA+ICAgICAgICAgICAgICAgYnJlYWs7DQo+ID4gLQ0K
PiA+IC0gICAgIGNhc2UgUkVUQkxFRURfQ01EX0lCUEI6DQo+ID4gLSAgICAgICAgICAgICBpZiAo
IWJvb3RfY3B1X2hhcyhYODZfRkVBVFVSRV9JQlBCKSkgew0KPiA+IC0gICAgICAgICAgICAgICAg
ICAgICBwcl9lcnIoIldBUk5JTkc6IENQVSBkb2VzIG5vdCBzdXBwb3J0IElCUEIuXG4iKTsNCj4g
PiAtICAgICAgICAgICAgICAgICAgICAgZ290byBkb19jbWRfYXV0bzsNCj4gPiAtICAgICAgICAg
ICAgIH0gZWxzZSBpZiAoSVNfRU5BQkxFRChDT05GSUdfTUlUSUdBVElPTl9JQlBCX0VOVFJZKSkg
ew0KPiA+IC0gICAgICAgICAgICAgICAgICAgICByZXRibGVlZF9taXRpZ2F0aW9uID0gUkVUQkxF
RURfTUlUSUdBVElPTl9JQlBCOw0KPiA+IC0gICAgICAgICAgICAgfSBlbHNlIHsNCj4gPiAtICAg
ICAgICAgICAgICAgICAgICAgcHJfZXJyKCJXQVJOSU5HOiBrZXJuZWwgbm90IGNvbXBpbGVkIHdp
dGgNCj4gTUlUSUdBVElPTl9JQlBCX0VOVFJZLlxuIik7DQo+ID4gLSAgICAgICAgICAgICAgICAg
ICAgIGdvdG8gZG9fY21kX2F1dG87DQo+ID4gKyAgICAgY2FzZSBSRVRCTEVFRF9NSVRJR0FUSU9O
X0lCUEI6DQo+ID4gKyAgICAgICAgICAgICBpZiAocmV0YmxlZWRfbWl0aWdhdGlvbiA9PSBSRVRC
TEVFRF9NSVRJR0FUSU9OX0lCUEIpIHsNCj4NCj4gVGhpcyBjaGVjayBpcyByZWR1bmRhbnQsIGlm
IHRoaXMgbGVnIG9mIHRoZSBzd2l0Y2ggaXMgZXhlY3V0ZWQgaXQncyBiZWNhdXNlDQo+IHJldGJs
ZWVkX21pdGlnYXRpb24gaXMgYWxyZWFkeSBSRVRCTEVFRF9NSVRJR0FUSU9CX0lCUEIuDQoNClll
cywgdGhhbmtzIGZvciBjYXRjaGluZyB0aGF0LiAgV2lsbCBmaXguDQoNCi0tRGF2aWQgS2FwbGFu
DQo=

