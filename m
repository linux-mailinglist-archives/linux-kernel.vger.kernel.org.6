Return-Path: <linux-kernel+bounces-365524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F0399E3A9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 12:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F90E28468A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 10:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125A31E378F;
	Tue, 15 Oct 2024 10:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="YOi1YyIs"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2099.outbound.protection.outlook.com [40.107.255.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DD61D14FF;
	Tue, 15 Oct 2024 10:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728987598; cv=fail; b=I1//TCAyHahek58mbFzh+goWOpPn0b+QIjKN6nffKj9Z0syFyZEuptRiPOw1dTW9zC9fV7LqtmsV+BeDSoxuwc7b0MO6rIq0b/ge7HpLJ0OugS+TrZUkBAVhJinz3R3h2nnNaDJoJsn8fYqlxV9VWn4TwRAqDW1DAqCvr7HxTGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728987598; c=relaxed/simple;
	bh=MnRLI6byLpF2qix7wqKaXQmma9PFznyvP0ku8EgYbSw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OeJoL+25mN8n3ay9j/51HS4QO598IgCagCDSIZt6Uw0fqlireLBB849Lvt0h8wmAKaQZ3YqQSJe9NYw+CMwVIUJpH3WOeWV9oEZ3uEBvsc46JYEelLZ1eN13kNWcwYlb3teS95qaZDe7i1CZgk05TSWCqMM0hlgUo2fx+xxq5ZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=YOi1YyIs; arc=fail smtp.client-ip=40.107.255.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HIXewnmKC997wYaIL65P4+iQYVG2skn4KAieP9bVxEjmmYDorsFR4oQPpw5hy0uT2i7hoHhlAr5S4QX2WaZ6ZrltqoGkUlWr1C2LdpMUfGYrokzyOFQIongW0C7Bz+PWSfDy1uRU+wfJIMUqsKIbohWvAsh5Eb+k6+Xu+u7ZfMrJUVBUiX4yFZ1P+/67teDgv59DMwD2EnuqxKZUWTNXj5U6M+Tl92JFRApQYPmBjQJFUKL8JYp4HAeAOs/talxn4jszj43KB2FHxyluad7VSAtQjilWAJbhu9wcHwV4zU/AwwIRQzr8w+3f+BwN4PjRQLW7IxA1QxeJM9TOkkWIPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MnRLI6byLpF2qix7wqKaXQmma9PFznyvP0ku8EgYbSw=;
 b=YF5H4Pe349bOZ0qalKUIy/NHUa35oHwLwulxrOLHiUuvjZ+vNPN9f6DBnXIo9yMP5+CrxvCzWIsD3iWGD3MhSjT4/Kq4FSqmBhoksKFdricw+NqEqsk19FvP2ibGhGAwvH/o7ay6U6JDP6o3KVMUUtBxa6PxIuOfs4UA07/aQAmw3F/q/TDAJ7Ff1/RpyXe9V17vCEtZ80piebxGVcd35MHu9kKrjghkPmPyZIvQ3qN8AczcyXGJB3bWQJaBA9D0dPLsk+1cwpzoU3za1PujFnLMiuaLzqP1Hlv0BzrMRGek2TgOZCJhTt0ACEqBhdDMCKx2qSXhH1znT1cqTSWK/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MnRLI6byLpF2qix7wqKaXQmma9PFznyvP0ku8EgYbSw=;
 b=YOi1YyIsDvQBidfNPs2D2pcdt/1rRs/ECFiCBg5yX6CNIeOEf6IYjwfrcf2RbxWIZlEsIvFFb7XrN9BRpblbYX28YOfdRAozdtxGTNEMVqIzVsAFQoGeBiGCHtINIzmSFK0Rtqyg8pH4sgEAmmA9I3i/C8qYj4GJ3YmsyWXiyV/pEugbiE01/SItllHoc18l5f4Safsp6fecI02pryG7XRFJMz6CKZetc9YMMirMapCHeRIjew7aHwwl65odOi6PzHfT5w5MzJiLL6pIfxOYKRZC9C/+zWSVIeeo1VtonjFlbiYNTavUMxuSU3MfBwiv92E+I6XW7S66ck575gpd1w==
Received: from PSAPR06MB4949.apcprd06.prod.outlook.com (2603:1096:301:ad::9)
 by KL1PR06MB6090.apcprd06.prod.outlook.com (2603:1096:820:cb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.16; Tue, 15 Oct
 2024 10:19:50 +0000
Received: from PSAPR06MB4949.apcprd06.prod.outlook.com
 ([fe80::7bdd:639a:6b94:37bf]) by PSAPR06MB4949.apcprd06.prod.outlook.com
 ([fe80::7bdd:639a:6b94:37bf%5]) with mapi id 15.20.8069.009; Tue, 15 Oct 2024
 10:19:49 +0000
From: Kevin Chen <kevin_chen@aspeedtech.com>
To: Markus Elfring <Markus.Elfring@web.de>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
CC: Andrew Jeffery <andrew@codeconstruct.com.au>, Conor Dooley
	<conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, Thomas Gleixner
	<tglx@linutronix.de>, "kernel-janitors@vger.kernel.org"
	<kernel-janitors@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	BMC-SW <BMC-SW@aspeedtech.com>
Subject: RE: [PATCH v3 2/2] irqchip/aspeed-intc: Add support for AST27XX INTC
Thread-Topic: [PATCH v3 2/2] irqchip/aspeed-intc: Add support for AST27XX INTC
Thread-Index:
 AQHbGkKMCnGgBPvFn0OoVljQ1X0eJrJ+WgAAgAL6RdCAAF00AIADu5ZwgADTZgCAAV/fQA==
Date: Tue, 15 Oct 2024 10:19:49 +0000
Message-ID:
 <PSAPR06MB49496CC4F25425753EA4252C89452@PSAPR06MB4949.apcprd06.prod.outlook.com>
References: <20241009115813.2908803-3-kevin_chen@aspeedtech.com>
 <f65dd139-1021-47d6-93a1-1477d6b4ca1d@web.de>
 <PSAPR06MB4949904D1FA95DBD3EF5288A89792@PSAPR06MB4949.apcprd06.prod.outlook.com>
 <0b995a34-28c4-4ba6-8ad2-e8413c6a63f5@web.de>
 <PSAPR06MB49491F8E0CE4069E9B9B1EA289442@PSAPR06MB4949.apcprd06.prod.outlook.com>
 <trinity-a5696b99-bf11-4ae3-8b00-20db116f86e4-1728911450361@3c-app-webde-bs22>
In-Reply-To:
 <trinity-a5696b99-bf11-4ae3-8b00-20db116f86e4-1728911450361@3c-app-webde-bs22>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR06MB4949:EE_|KL1PR06MB6090:EE_
x-ms-office365-filtering-correlation-id: c95d5484-7173-4f14-89e0-08dced02e685
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?QmxZZ1IrSUgwb3VGMURPNVF5TURoelk1VTdYZERzSndmNm01OGEyT25laG5B?=
 =?utf-8?B?WUkrbEhUMkoxOFNkMVoyTmszZWk4aDA2WjVXWGk3M1pYdmR4ZGF1VjFySUtK?=
 =?utf-8?B?ZGVENXhpbjd1QTVwZE1SV1hXUnNHdmNEdnpRSXhleEVsMXZvSlBXZkhRZEpG?=
 =?utf-8?B?dHhVQldrQ01IWS8rNFBnL2ZtcUpiUXgyNk1ERFVTZzRZbmtqMFkyUks5ZWZp?=
 =?utf-8?B?OC9NSjJySmp0QnB3aUlZanFIY3hwUzlvNzgxMjlmVnZudnNDdFVmbUx4ZlMw?=
 =?utf-8?B?MXFvMTN3YlZwNHdTMmgrSEdxUW5yZFppaWp3K05CanZPSGsrQ0lIdzVhSENE?=
 =?utf-8?B?cUt4S0Faenp6S1NQL01IeEF5WjBRdDNOSU1jeTlyRGRRbWdWdlFtaDNxRmZF?=
 =?utf-8?B?djVSL0ZhTXE4VW5sMnZDN0ZJNlJ4amE2aldWN205dlJXSzRzQzRoTVlxTUx6?=
 =?utf-8?B?SXJLOWtrUkk1Um1KWTVvSThkL3ZZc1NpampGWnowdG9YRE5LZFdURlllSmJZ?=
 =?utf-8?B?MEZRTWFaRW40dXU4YXIyK2VSSlN0ejNPeFdiTFJpaFZHSTc3eUp5WGVBTklF?=
 =?utf-8?B?dWJLQlp2Q1c5Wlh0My9kbEVFYmNMMEhTK1lORjcxUWRQbitFKzJramxUczlQ?=
 =?utf-8?B?L1RxR1RsTHYrYlNOS2dQVzR3RnExMENGZzBRVzVlbUVmdkE0dVlhNEhXRUpJ?=
 =?utf-8?B?cm5PQU5DalVpUkpFVVc4R1RSanNFaEFwVEVxaElvcW1qOHllemIzQkpScXRW?=
 =?utf-8?B?S2thdm9uU05hZDg0SzZMNDZ6aTZ1UUl2Zm9XazNyakNucGRQRkJ0M2tOOUhx?=
 =?utf-8?B?WndQbCsxVlN3Mk51Q2p2RGkxU1liZWZCZ25JMnFLUUFsM2V4aGlVa2VNVmdu?=
 =?utf-8?B?ZzlodEJUcDQzSllDWE5QSkRWYzlvZ2RjZU54Zkx2cWx2ZHdNQWRnTkZsOWN5?=
 =?utf-8?B?SzFhRlNaeDU0TVJ0SE53TjFUb3VEdGVHZWUwY21lSml3ODkvRmwxTWFUblZr?=
 =?utf-8?B?Z1Z5WGNTZTlFNUhTcGZuMXp3aStSaWFubTN2aW4zd0Znd01wbERtWEh6bHRv?=
 =?utf-8?B?SklWT0pocGpwZGFnYkZLTUp0UFlKMi9URGhEMDN6bkkxS3I3bDJucmJvNlRJ?=
 =?utf-8?B?K1Frckc4Q05QancwcDNwV09nQ25TVXhJd2YxZi9qZDBDWldJcXhKQ2VLWi9h?=
 =?utf-8?B?VDdmTWdMbG9NZHlORTJpWS9oYStOZWNQYmc0YTVZYnVWK0dZMi9iN3lUTmpG?=
 =?utf-8?B?VWhpbzRlN0NlWDFpcm0zVGYvWC9FSXkyRVlhWm9taHhhUXZmZnVlSDJ6MGJr?=
 =?utf-8?B?ZTNFWmdnN2puMVM5UmwrQVZQOEU1N200aDNCczlJNUFvMUI1UUxwSE0xeDRq?=
 =?utf-8?B?WlIzZDdPbDRnZDU0TWhUc2RMNHNBSlMyTjhLbGhlRkk0WmxvYWlhWTdjV2ZU?=
 =?utf-8?B?Tm8rTUFPYjFRSCtFbDRWSUU2YitVQzFGaVlrUHF2V2g0bHNxb05TYWRDcG5m?=
 =?utf-8?B?dDRlVDZHZVAzOE5qYVVtUTg1MXcrMEJEK1lIRnUxR3VxZjBLWjR1bnZKNGEy?=
 =?utf-8?B?YVhsYUhNTUgzZ1AyZlg0NEtpVU45NkhwRGlXRklCVFZSSjQ4cE9RVUJQOG5n?=
 =?utf-8?B?cThlT0hMVExidkVtWng4SjFZTi9yZUZmK253Ymg1MDlIVmNNS3V4eHF6VmFa?=
 =?utf-8?B?SElaWkNjUllnWllEc0dRckNaZzdDQXhlT0xVS1FCVzBVK1Bucjhmdi9aMlJL?=
 =?utf-8?B?UG5WUHd2OC9HQkNkM29OZDhCeTAwNEprVktTWDVFN2tVaXZ5UXAvNkRwM3lN?=
 =?utf-8?B?Vmk2S2hCYUdXN3ZtN2ZBdz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR06MB4949.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RDRSN2ZHNnE2YXhHdC92K3oyWU1yT0JQV2ZVNlNVRTFLQXJnZFJlWjlYdHNE?=
 =?utf-8?B?VXgrcnkyS1BpU1V3dHF1cE0wZEIwMjc3TkxveDVXV0tTSnFsY3dJNGpMZW1O?=
 =?utf-8?B?bURlZ0VWQUVocTBRcE1UbTBSMnNvM0hKWlcyVVFPdURGMENmNXZNQk1lRDdw?=
 =?utf-8?B?OXYxRFlDOGhQZnVoOW91ckcwejMybkkrZWZYb3ZOMk1DWWFFQ1ptczFhZ0tF?=
 =?utf-8?B?SnhITkp5ditXVTI0VmtkVXJiUUVIT3JNTnJ4Tnd2UkdSb3hYTi80NGMxcjFJ?=
 =?utf-8?B?blhwUWphWFFlSzFDdEVaVitidXA2cnFqWGQxTVI0cGRXK0V5dzBia0lmVHg2?=
 =?utf-8?B?RU9rc0V4RXBTNklpZVBRRENtanljR2tSeGF0RWpqWUlVa2xmNFNJZ1BCNW01?=
 =?utf-8?B?TnVPZWpUbzNOdmEzOW5rYzJNMkVicGxiOHcyNVR6UFcvTUpyekMxRnZJMG5W?=
 =?utf-8?B?eWJiSi94ZUZvRndTSUNvbk5FdG5KakVNYlpjL29JVWZ2OVNMMmJkRGxSWjZI?=
 =?utf-8?B?Ri9JSG1IeTg2eGNmVkdBK1Qwa0JEdEw3ODUvOWxpT3NYYzYwc3VWa0F5TGpj?=
 =?utf-8?B?bzhSVVFTYWE4aFF1UUFtTU4vcnYxUkV2cmZncjIvbEdHeHV1S2hwaUUveng0?=
 =?utf-8?B?NFIwbzRHSmtwMlN1QjlCZ3RiZXpIeE1Sc2M1ZjNvWE44ZDNKTDExM0o0Y2s1?=
 =?utf-8?B?elBGeHl3TGlrN3cvVVZqQ3kzNzhUcFBORzhpdXh1bkgrOUZ5cnNxZ09FVXRr?=
 =?utf-8?B?a1ZucVAwR1pjQlBId1lzRFBtY1EyNzVaV2xmQWI4dDlvKzFnejlxck84L1R3?=
 =?utf-8?B?STJQUUZMU3loOE1uODVwdU85VzR2SmxoSDUrQng1WVd5V3dTc1Z0M1dmR1Nz?=
 =?utf-8?B?cFhuNm81U2RLZjM4dWZYYWRGNHdLRFNXdFlLN2FLaUlTNmNoNHZMVDAwYUow?=
 =?utf-8?B?YlRCYjJEeXRlUW5kZnR4czBuSEJyb3JxTlpKeWJqa29oTmJDUWwyQ0xBYnVN?=
 =?utf-8?B?ejNNNmsrWWlydTVSYkNibHRsSFJYSU5uZFNLWWtERWtrZXdzVlk4N3E3NUxB?=
 =?utf-8?B?WWdUR1liVDFxK0pqWVJucnlDTncxR3VGVFlKRkU3UktQTy9pNTdtbjRqUzlu?=
 =?utf-8?B?bUEzSUxwR2c1V25PTVFlenRWbEw4aWRkSU01QzRRblFaUUc0cVV3WmU0UC9F?=
 =?utf-8?B?OHZOV1AwSzkxRmlrcU9JRVJxSjFYaWlFMHB5a3lXcnU0TEJpU2V4c05ZSG5X?=
 =?utf-8?B?RXh3TUR1SWRudTJ0WHdQcTlidkF1VmVKUGYxelZlL2JrOE9VZHFsWXdxS0VS?=
 =?utf-8?B?TVk5NVZ6NU9HNlZuNUV1RGtBTGgwaDhXUzE4d1FuRDNYV3hTZ3Y3MmVOQkkr?=
 =?utf-8?B?L1MzQjVGblpTWlFDVDJzdEVsUnZBUFZwczFuVGNhY0Qza1k3R2xKeWdQVloz?=
 =?utf-8?B?dHpjLzd6Yk9CeHRzamxqNkw5bGExUEpqM0c3TENjWmEreUVENkpnTUsyRVV0?=
 =?utf-8?B?cVJCTjAxK1Z2eHFIbjRKZFdvMzhZQ2pBbkZhU1VOR2dKUWVqcTZXWXV2ZXdQ?=
 =?utf-8?B?dm4rRm1FdzhOcGh2ZlEyc0RGQWNyVDhmV2Z3ZDFqb3dxQXlGZUpKY2dXbUI3?=
 =?utf-8?B?b0hwaE5zYjllVXZ1dEtBazhjYnRpZXZuQllSQWFpcko5YXRxSnNvRGhNVmY1?=
 =?utf-8?B?M3RkbFpFNXZyOEdWNmFzWUF4RzhnM2JlVWZ4R2xTMWJnV2VrWStHUHUyVU4r?=
 =?utf-8?B?TkZFTlluVGFab0gyR1EzTXd4NWhqb0RkS1FMS3Z1NHpoQ095S21sSVJMMlhT?=
 =?utf-8?B?RVE0dDUrbjUvbXhYb2huL0FKbkw2L1Z0YnRielhqNmtKMDZpc3MwK2R6R1Q2?=
 =?utf-8?B?cCt4akVGN3JaMlkySGd5VkVTeExiZ2lRQksxNHhPK1QwSGViR0F4NU13TUdo?=
 =?utf-8?B?TFlOakNFYW1weXdCd2ZqUGZhcy8zV1dCcktrUEp0WHM0ZDJBczU2ZzJzWVkw?=
 =?utf-8?B?Q2JnUmF4UThWY3FIcFFxRXF6NlphSFdxRGYweWJ1SHN4Y3NNaUV2L05MZ2dz?=
 =?utf-8?B?VFMrR0FBUmdhVUNGWTZKOGJBYWlkelVqNTZqOTFwd21MamNZaHpMVVRRN0J4?=
 =?utf-8?Q?MeGFEeheGfxdX2o1yXps0ITgn?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR06MB4949.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c95d5484-7173-4f14-89e0-08dced02e685
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2024 10:19:49.2545
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WCJqilJryMIG1jCtWfJf5MO4iJlQqaEq5S1DnQBXUARVtk/+lWywjqYaJ8uPxGuI5HMpNByts8bb9ggQSqlI/702PfFHsCH5wrgzB+vUYAQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6090

PiANCj4gPiA+IEkgcHJvcG9zZSB0byBtb3ZlIHNlbGVjdGVkIHZhcmlhYmxlIGRlZmluaXRpb25z
IGludG8gY29ycmVzcG9uZGluZw0KPiA+ID4gY29tcG91bmQgc3RhdGVtZW50cyAoYnkgdXNpbmcg
ZXh0cmEgY3VybHkgYnJhY2tldHMpLg0KPiA+ID4gaHR0cHM6Ly9yZWZhY3RvcmluZy5jb20vY2F0
YWxvZy9yZWR1Y2VTY29wZU9mVmFyaWFibGUuaHRtbA0KPiA+IE9LLiBJIG1vdmVkIHRoZXNlIHR3
byBsb2NhbCB2YXJpYWJsZXMgaW50byBzY29wZWRfZ3VhcmQuDQo+IA0KPiBXaWxsIGRldmVsb3Bt
ZW50IGludGVyZXN0cyBncm93IGZvciBmdXJ0aGVyIHJlZmFjdG9yaW5ncz8NCkRvIHlvdSBoYXZl
IGFueSBleGFtcGxlIGZvciB0aGlzIHJlZmFjdG9yaW5ncz8NCg0KPiANCj4gDQo+ID4gK3N0YXRp
YyB2b2lkIGFzcGVlZF9pbnRjX2ljX2lycV9oYW5kbGVyKHN0cnVjdCBpcnFfZGVzYyAqZGVzYykg
ew0KPiA+ICsgICAgICAgc3RydWN0IGFzcGVlZF9pbnRjX2ljICppbnRjX2ljID0NCj4gPiAraXJx
X2Rlc2NfZ2V0X2hhbmRsZXJfZGF0YShkZXNjKTsNCj4gDQo+IEFub3RoZXIgdXBkYXRlIGNhbmRp
ZGF0ZSAoZm9yIHNjb3BlIHJlZHVjdGlvbik/DQpWYXJpYWJsZSBvZiBpbnRjX2ljIHVzZWQgaW4g
InNjb3BlZF9ndWFyZChyYXdfc3BpbmxvY2ssICZpbnRjX2ljLT5naWNfbG9jaykgeyIuDQpPciwg
aG93IGNhbiBJIHJlZHVjZSB0aGUgc2NvcGUgb2YgaW50Y19pYz8NCg0KPiANCj4gDQo+ID4gKw0K
PiA+ICsgICAgICAgZ3VhcmQoY2hhaW5lZF9pcnEpKGRlc2MpOw0KPiANCj4gVXNpbmcgYW5vdGhl
ciBtYWNybyBjYWxsIOKAnHNjb3BlZF9ndWFyZCjigKYpIHsg4oCmIH3igJ0/DQpJcyBpdCBuZWNl
c3NhcnkgdG8gdXNlIHNjb3BlZF9ndWFyZCguLi4pIHsuLi59Pw0KSW4gdGhlIGVuZCBvZiBhc3Bl
ZWRfaW50Y19pY19pcnFfaGFuZGxlciwgY2hhaW5lZF9pcnFfZXhpdCB3b3VsZCBiZSBjYWxsZWQg
YXMgZGVzdHJ1Y3Rvci4NCk9ubHkgb25lIHJlYXNvbiBJIHRob3VnaHQgaXMgdGhhdCB0aGUgY2hh
aW5lZF9pcnFfZXhpdCBpcyBuZWVkZWQgdG8gYmUgY2FsbGVkIGluIHRoZSBtaWRkbGUgb2YgYXNw
ZWVkX2ludGNfaWNfaXJxX2hhbmRsZXIuDQoNCj4gDQo+IA0KPiA+ICsgICAgICAgc2NvcGVkX2d1
YXJkKHJhd19zcGlubG9jaywgJmludGNfaWMtPmdpY19sb2NrKSB7DQo+IA0KPiBXb3VsZCB5b3Ug
bGlrZSB0byByZWNvbnNpZGVyIHRoZSBwcm9wb3NlZCBtYWNybyBtaXh0dXJlIG9uY2UgbW9yZT8N
CkNvdWxkIEkgY2hlY2sgdGhlIHJlYXNvbiBmb3Igb25jZSBtb3JlPw0KDQo+IA0KPiANCj4gPiAr
ICAgICAgICAgICAgICAgdW5zaWduZWQgbG9uZyBiaXQsIHN0YXR1czsNCj4g4oCmDQo+IA0KPiDi
gKYNCj4gPiArKysgYi9pbmNsdWRlL2xpbnV4L2lycWNoaXAvY2hhaW5lZF9pcnEuaA0KPiA+IEBA
IC0zOCw0ICszOCw2IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBjaGFpbmVkX2lycV9leGl0KHN0cnVj
dCBpcnFfY2hpcCAqY2hpcCwNCj4gPiAgICAgICAgICAgICAgICAgY2hpcC0+aXJxX3VubWFzaygm
ZGVzYy0+aXJxX2RhdGEpOw0KPiA+ICB9DQo+ID4NCj4gPiArREVGSU5FX0dVQVJEKGNoYWluZWRf
aXJxLCBzdHJ1Y3QgaXJxX2Rlc2MgKiwNCj4gY2hhaW5lZF9pcnFfZXhpdCgoX1QtPmlycV9kYXRh
LmNoaXApLCAoX1QpKSwNCj4gPiArICAgICAgICAgICAgY2hhaW5lZF9pcnFfZW50ZXIoKF9ULT5p
cnFfZGF0YS5jaGlwKSwgKF9UKSkpDQo+IA0KPiBXb3VsZCB5b3UgbGlrZSB0byBhZGQgYSAjaW5j
bHVkZSBkaXJlY3RpdmUgaW4gdGhpcyBoZWFkZXIgZmlsZSBhY2NvcmRpbmdseT8NCkNhbiB5b3Ug
Z2l2ZSBtZSBhbiBleGFtcGxlPw0KDQo+IA0KPiBSZWdhcmRzLA0KPiBNYXJrdXMNCg==

