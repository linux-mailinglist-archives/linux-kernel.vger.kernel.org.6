Return-Path: <linux-kernel+bounces-407234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A739C6A98
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 09:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6949B22C7B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 08:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48EAF18A6C4;
	Wed, 13 Nov 2024 08:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="ZEMg1Oqi"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2106.outbound.protection.outlook.com [40.107.104.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9163611CBA;
	Wed, 13 Nov 2024 08:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731486780; cv=fail; b=VZ1rXVx6+n+BDKS8urr9/vz44QHWO0VQri3KyKJBelEwtNa0USGCyB0JC+fS2GUepEe0IKxSUC5Ud81mIiLZ8H7p/5qDzOLNTIOCFHPMvoBIgywoqwf6+1c3J6Ptx39DH28dDVLEuYp/0CchDDWp1nA77arzUt9h+vUrGbXtPHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731486780; c=relaxed/simple;
	bh=RZbYjYgqjyI3KUp/Q1mUv4aOe0MNNqp2Rum9uxPUGdQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jw94bYeFQ+a/qKrjU7+t6HsNSWKZ8WLhQypBmAN5kYpKGB3R5LsoqoHy+EQ6fCv7t7dzb4pC59/xQVKU0MjpMm98zI5x3bDNsJhIQYDqzLWN5YkNL8VX7qSbfQloqBhUYmEpm4FD6ru7n6SXPehRPzG8LKJOcBM/UjRqbq5rWtA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=ZEMg1Oqi; arc=fail smtp.client-ip=40.107.104.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CnHkijJrUKBdiKezkoW6/9QEXngOmhgVJbfvFQTBjWT47vTr848vCxKIeHm29SHKQIh/TgJYn4SdhYCwTZRJBP0O/7mSQuUZRC0H6HETHDvb7f8CsxZEPZ1VsSVVPe1Scceqp6EmZCsuEjzjo9M4v1SL2l1zjIT70RQvow6PBwZKAWyqKi1sZyMXAheAT15QeMdouLB2FmXauKCeNOzk4OaeKqfYTbus2vxidM42ymLqaK4xqZ3zUNv8CA5YwL5Ext2LekuoCxG0u+BsUsXQ5ZIpVFfenKd4jzqMdg/x5lI9vgq1tyAOBswFKzdP7zwELEcPl9g3uAZW9xcpBVsjhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RZbYjYgqjyI3KUp/Q1mUv4aOe0MNNqp2Rum9uxPUGdQ=;
 b=SFf536xcdF/2nC5+wiGKJMg9YdNUf+roIS90vupKNCUBRZ95cpfG/viJTpKpgjB3J9r60n0ehs41zp2JBAbCnWuTVFX49Q/r5dCUv0hcDh4Np/QwDa98WAnUXiIV6okn/T0pRnLc1RoebXKx5XrNiOmvj/rNuhyXOxoQ36748GEpGAXj7sSOwOMADfbIeB2+YhdNKXS1GPfzHqqIXVXduRscPbeecoa+YY3FkcqUF/I7iZpsUxQaNOTooIquI7d/VP2nYUsENobC9qmkaw+IdSLSOCaurmCx96qp7gIejcFdINx14HHnaAduhZUPYUSYRkwrXLJupQXIcl76m5aCzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RZbYjYgqjyI3KUp/Q1mUv4aOe0MNNqp2Rum9uxPUGdQ=;
 b=ZEMg1OqibwVqNwUH9wK5cwVO0gtjweeDxFqRSljxkkCGzMyezWfeXk9aBZ5mLgFNAm1FdE21j9Uk5ICPh8XdKmrBGi/xW51dMRczszt5udxgBqEAF+6NIKmOAwPM9jcYUVmADHSG4VAdGf1NQ23iy1DlwCCzh5/7ifDRSYonWeA=
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by DU2PR04MB9130.eurprd04.prod.outlook.com (2603:10a6:10:2f5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Wed, 13 Nov
 2024 08:32:54 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%4]) with mapi id 15.20.8158.013; Wed, 13 Nov 2024
 08:32:49 +0000
From: Josua Mayer <josua@solid-run.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: ti: k3-am642-hummingboard-t: convert overlay
 to board dts
Thread-Topic: [PATCH] arm64: dts: ti: k3-am642-hummingboard-t: convert overlay
 to board dts
Thread-Index: AQHbLGBE4Oj6TeCKV0+veZ0PVk2MEbKzKEoAgAA2oYCAAZWSgA==
Date: Wed, 13 Nov 2024 08:32:49 +0000
Message-ID: <8b77dc76-7c03-45e8-8b40-98e62c468310@solid-run.com>
References: <20241101-am64-hb-fix-overlay-v1-1-080b98b057b6@solid-run.com>
 <32c1f44c-6bc7-4722-9f73-743ea15cdcbd@solid-run.com>
 <CAMuHMdVZB1iiM5K1VWch5HrohRz+HYu2z1KBXDh2e01TTPgOWQ@mail.gmail.com>
In-Reply-To:
 <CAMuHMdVZB1iiM5K1VWch5HrohRz+HYu2z1KBXDh2e01TTPgOWQ@mail.gmail.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB7586:EE_|DU2PR04MB9130:EE_
x-ms-office365-filtering-correlation-id: 14a6aac4-06f7-4f4d-6a34-08dd03bdc247
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SWRkY3h0clhtMGtTZkl6TjRQbnlKSHZ2NW5Sb2tmUjFpOUZLNFh3dytoU0ZD?=
 =?utf-8?B?L3VHV1BrWVZ1MXJNbFcxaWxWRXV4eStjNTdEcXJtQWtPUWVjck5aUWVJWXhm?=
 =?utf-8?B?YjQ1dzdlVFBGeTJsMSs5MlNaSVlUY2RQWEpyamVFRmpOaDVpbVpVcE15dko2?=
 =?utf-8?B?UlBneFF5R1JZWGl2WnNOU2ppaTdudDVDdjRkeW8rbVdlVUxoTUVaalNhR1hh?=
 =?utf-8?B?RjRKeFp1Wm00U2lUbmFFMXJERTZIcUJnVFgyWm9kWmNsd3lmVys3akxWVDRB?=
 =?utf-8?B?ekxEL2FGYW5tTnhXUzNsNlVISU1jbmRMcENaZ25pWTM1T0pqdytjWVU2bHA4?=
 =?utf-8?B?bGZOZ09wTnpoblhaRHA4dEJaWVRnaDdpaFB3bjZKdWZ5R3NBL2ZuS2lMMVhE?=
 =?utf-8?B?amlJTUxXOS83OU1ZY0U5SitoQ3o1dWpFbW4rYnJRWHJDb2piNWxFSFltWlQ5?=
 =?utf-8?B?TWFHVWtzUUs2bUJrcjZwQ1diVG9jb0VKdXRPZHRVWG1iTGcwR29Jd0h0bkRq?=
 =?utf-8?B?Q3JsdFNhdE80WVNVNjN2dVo2NVVrb3BmSStBYVRSaHlZSkpTUXFFVHArdTV1?=
 =?utf-8?B?V284a3RNY0ZsS0UxZGhYbDZTSVJDSnZ2bWwrNXRhZExYRVFPS0hXcyszUjlh?=
 =?utf-8?B?UWhEZXlsdUEwRkx0dWxobzdvNndRbGFLaEFlL2lEbE1CWWRSbGo3VkxJeWtO?=
 =?utf-8?B?WXk5aytHaXNQYmZ6TGZJRzlhQzJ4WE5iMnJsVXc1ekJZM1diWVlBUEJtaVA2?=
 =?utf-8?B?N0YrcWtsMU1SNnV6VTJDV3FOcDhYMTN2U2QwZXhta1BXcGxBcFJhMmZFUVVP?=
 =?utf-8?B?T28vWFNUUVhsY1N5WW1CSHdOYVN1OHY4UXVaNGJoZG1SK2NhZ1hKV2wvQnl4?=
 =?utf-8?B?Uit1Z0tVNENoTUlMNXVDRjVJOWFGTTZtK050ekh3T0M0U002amJpNmhEZ0pa?=
 =?utf-8?B?N3dlR3ZQRFU3ZVBwdTVWSUs4aEtKT3RDcENweko4Z1ZQN2lJNE5rV0VadzNw?=
 =?utf-8?B?dE5Pa0txakRvUW5CNHRPL1VLeEdyTVJHUmltekNzL01NcE9HelcxaHVwOEJs?=
 =?utf-8?B?SVNxYk9DTVlHVXp0SHAra2xESUxhekI5bVhScGdqVUU5MU1LY1R5czVWRExR?=
 =?utf-8?B?VmpydTJiMzJSNFpnVld6Y1BBQ1JUakIxbkhpUlMySHgzOVVFR24vYlVIWUQz?=
 =?utf-8?B?SndHYTloNHlndjhpREtQTmdXaVdDOUx0WXhxYWI5SmpNbWNiR2ptcGFKZS9h?=
 =?utf-8?B?VWlwS3ByWXE3WlhEN0RwdWZXQlZZUUEzMmpYVHp3VXJGQWYvVjhvUVZueW1w?=
 =?utf-8?B?Zkt0K3JhSytMRHNUazRpUkVJbHJPeFdzdEZPelJBOVIrK0ZZR29saERCSytj?=
 =?utf-8?B?NVIxMWdiSnp0ck80RlhjOVM0ZlJNSW1aV3lFWlBiS2t4RnBBTEt1SVVKS01M?=
 =?utf-8?B?L0puVC9QOVpBMGRpSCtIa3h3TUVJWmZHRzdML2RUaDBHM3hpOTJEeldZU01l?=
 =?utf-8?B?T0V0TGd3WTlESnlPUGtWMDB0QXhheEZ3WEdON21Pb1htZ1hmTXRzenJ6SEd2?=
 =?utf-8?B?ZEx5NWxDQ1pyejJGNE5reGI2WTBaUDdTSEhjdHdjbERkNE84b2oyR3Z5M0xu?=
 =?utf-8?B?d1dWQ0JyK1l1TDBrK0VHdzRlYzFDeWdacFZUaW8rMFVoOTQ4WTk5OG43UDF5?=
 =?utf-8?B?WnZJcVNjeTZMT1NuSG5HeTRTRnEyYnEwZlVkcVgzajdkaE4wTDNYNU9FQ3VE?=
 =?utf-8?B?ZlBvYXF2MkFxeEQ5dUxtWXFWdldkKzVoY1g4SldHRzZrM2x1czNnWGtReTBu?=
 =?utf-8?B?YW9NVGtIMzVQaWI2Y0tzY3ltb1RNdGVNcnJBN055Q3JrWHF5U0xVWXg4TTRL?=
 =?utf-8?Q?/eLL7AAcrOTGt?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SXZ2bk8ydnV1NnowaUJtR1ljZFk0V3ZvdWcrdlpNMkxmV1VURWdnWDkrRk1R?=
 =?utf-8?B?OFBEbFlPZDJuL2tWcHVpakIzUzMrSnlyb0srVFFxWVVvK2JBcTllZWtyK1Qw?=
 =?utf-8?B?b0RoRkdSTVFpRnpKaTAydHZ5TjJNNWk2L0JyUUtHdk42OURlbEpCWUxRSGNT?=
 =?utf-8?B?dGtBUDVGMDNyMVJOcm1PRHh4K0ZHcVcxZU40dU5qTjgxeTZhbkFPS1g1SENt?=
 =?utf-8?B?VExqYi9VeVdtQXdTcW03V3h3anI3S2F1aFJsMzBGeEdkdnBqRGVTd2YrcHZ0?=
 =?utf-8?B?R3hlNElPYkF5bjdpeWIxcHYrNmVwdkh1V0xTYkVJNTN3UmJrVFpPNEhtWXRr?=
 =?utf-8?B?cStleGlhNFdCalprcnFXUXU3TExaY0JGV3JDNlRvZXlXVmhMSHY1aFU5WjFh?=
 =?utf-8?B?WjF1Sjk4dFgrR2ZQWktwMlc4T1BhaTVmcTBPdFdFRFpraWc4c01HWW1xYXFC?=
 =?utf-8?B?dEJXR2x5ajBFOVVYVHhXa3VZbmowNURyMVV6NHJZWEc2Y0RXOGRqbXdTQkha?=
 =?utf-8?B?VUI4Z3VBWGNOUGM5bnY2OW5kbnlkR1ZJRkxibS8rWXRmd2NiYVl5SlJ2U3dS?=
 =?utf-8?B?RHA3alM0QkFDVkNNS2FJL2hOWjNVZWxneWJKcHlYQUV4akczSm1hNUl1YVNE?=
 =?utf-8?B?dVZrM1QyWXpoMGora3lTSkhnY1RCUngwaUtYMm5RVGRiYldsN2dnQTI5Znhl?=
 =?utf-8?B?U1FDZ1JDT3pqRDJwQXFzam5TblhXcjBmazZwamRMMjhSTW9RTldnUFdNNUtH?=
 =?utf-8?B?QU5mcWo2OFNpclRzRklSeThPeW9RMktBRnZMWUVwTEtJUi95UU90Wkhyemp3?=
 =?utf-8?B?VW9WZTE0Mm90K3NMZnhPZVgzNGk0RjI2LzhPaWZaM3lHN1FDckZCTVNtNjZZ?=
 =?utf-8?B?RHJVaHRhcDQ0WkZCYkNSbjIwOW1sK2J1alBKSit3M3V5azdlQmpSaUk1WVcy?=
 =?utf-8?B?MUswMUJxUG1rUU0rK08rR0VpVkVUSFpRQzhoc1FhaWZBTWFXakExUTEyV1Fq?=
 =?utf-8?B?b2hyYWZOOGZ2MkVhS2tGcXk1M0hSQ2pkZkxFUzlxUUpqUzdjWkV5YlpDM2NY?=
 =?utf-8?B?U3pOVW1Yc1JTaUdyQ29QTWZzK1FjQkMyNlF2Vm94a0ozNkhGaml6Y0tTTHUr?=
 =?utf-8?B?SlNMTEJPUGFZSXFSZzlDcUZiTDREcHRZc0wzVVNDSXNMQmJrSjR1bWF5SC9V?=
 =?utf-8?B?a3hGMU9BWXdxaStycG4vSExsb05TSU00elBKS1N6c2x2dG8vdGlvUUVBNHVa?=
 =?utf-8?B?cHd3YjlOV0xUWURKYzE4RVlYME5sbkc0T3ZuczRLU0JITDc5YUhXTDQ3L1JB?=
 =?utf-8?B?Sm5EOWRqZ3Y3VTZLT1Q0R2tvaHUrUjM5Yk8yZEJqdDJEZkh4TlN4cEd1U3Zs?=
 =?utf-8?B?VU81WXRVUllTcjBvK0RKdm9OdUM3aktYVjZYR3drOWFiTER1Y3UzYUF0eTY2?=
 =?utf-8?B?VnoyYXFPUjY5WklDcEJnNEtSNkZxY0hXbk83VTdLcy9Nem92YmZsL2RmL1Zr?=
 =?utf-8?B?QWVTa2M4SUJYT2Z6am5PejBWeGM4NUc0SXBDVXRLRUhJTlYvWTdVYk5sSnVO?=
 =?utf-8?B?ano0dzdPOUVhTHhlSjVXc1gvSzdXbHJjUkhmNnFrSXlHVVFXZE1SdjZmNTho?=
 =?utf-8?B?ZlR3cDdXTUdMdFVZU0RHc2JoQWhrNFpUQjRSdEVWNk5yODVLWTlPMWpEcC8y?=
 =?utf-8?B?cDg2eWthMUVQbUUrRjdHWUlpdHNPRmpGYXJxVHYrbjB4QXdlZEU4cEp0em9w?=
 =?utf-8?B?YVFaSGU4aUNmR1cvMXczWXVIMVJsUFpldGNjSVovc0VWK2dDZHF4UDhYeS9C?=
 =?utf-8?B?L2dwWU5SR3VySDh3REdMZE1UcCtESUFQcHdYeWIwMGoxVndJSWdJcjR4emZN?=
 =?utf-8?B?bW5wOUhTZmovdVg1OUhJcHlObFZKYjNuL3d4dTVsN2hKeWdvL3VEc3FrTDJ5?=
 =?utf-8?B?YTVwRmNqQ3lpckRJaVcyM1VUYVpQdjNHYVNmUDI4TGZ2YURrL2w5c0pEeVRN?=
 =?utf-8?B?b1RxTk1TUms4ODR2VVZEMWhZMldBMFpaZDF1UVowak4zV3h4T0ZWR1A4alhx?=
 =?utf-8?B?NlVwejQrajRTVjNZMnVZSy9GSTh4b3UwMkJ1Yk8xVU5pRFZpVGllSnFvZzBP?=
 =?utf-8?B?NVgwOTd2RmZ6SlFqQXNFUE5IN2thYnZ3VEM0Y0VLNEM1OUpJbVg5aUdQRXdv?=
 =?utf-8?Q?O0p5BBM4fF+Qsl5mMYVDBsE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <13690C7BD6762743AA36D2D54703CE8D@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14a6aac4-06f7-4f4d-6a34-08dd03bdc247
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2024 08:32:49.9348
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c+PnN21QPLGbe3sjg68iX78n3YKysfaZjZ4qAx9zC/dgrRdap8YM7WA1960mHPhEoH46lH/NLGLsBOtJTkMIEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9130

QW0gMTIuMTEuMjQgdW0gMTA6MjEgc2NocmllYiBHZWVydCBVeXR0ZXJob2V2ZW46DQo+IEhpIEpv
c3VhLA0KPg0KPiBPbiBUdWUsIE5vdiAxMiwgMjAyNCBhdCA2OjA14oCvQU0gSm9zdWEgTWF5ZXIg
PGpvc3VhQHNvbGlkLXJ1bi5jb20+IHdyb3RlOg0KPj4gQW0gMDEuMTEuMjQgdW0gMTU6MTYgc2No
cmllYiBKb3N1YSBNYXllcjoNCj4+PiBTb2xpZFJ1biBIdW1taW5nQm9hcmQtVCBoYXMgdHdvIG9w
dGlvbnMgZm9yIE0uMiBjb25uZWN0b3IsIHN1cHBvcnRpbmcNCj4+PiBlaXRoZXIgUENJLUUgb3Ig
VVNCLTMuMSBHZW4gMSAtIGRlcGVuZGluZyBvbiBjb25maWd1cmF0aW9uIG9mIGEgbXV4DQo+Pj4g
b24gdGhlIHNlcmRlcyBsYW5lLg0KPj4+IFRoZSByZXF1aXJlZCBjb25maWd1cmF0aW9ucyBpbiBk
ZXZpY2UtdHJlZSB3ZXJlIG1vZGVsZWQgYXMgb3ZlcmxheXMuDQo+Pj4NCj4+PiBUaGUgVVNCLTMu
MSBvdmVybGF5IHVzZXMgL2RlbGV0ZS1wcm9wZXJ0eS8gdG8gdW5zZXQgYSBib29sZWFuIHByb3Bl
cnR5DQo+Pj4gb24gdGhlIHVzYiBjb250cm9sbGVyIGxpbWl0aW5nIGl0IHRvIFVTQi0yLjAgYnkg
ZGVmYXVsdC4NCj4+PiBPdmVybGF5cyBjYW4gbm90IGRlbGV0ZSBhIHByb3BlcnR5IGZyb20gdGhl
IGJhc2UgZHRiLCB0aGVyZWZvcmUgdGhpcw0KPj4+IG92ZXJsYXkgaXMgYXQgdGhpcyB0aW1lIHVz
ZWxlc3MuDQo+Pj4NCj4+PiBDb252ZXJ0IGJvdGggb3ZlcmxheXMgaW50byBmdWxsIGR0cyBieSBp
bmNsdWRpbmcgdGhlIGJhc2UgYm9hcmQgZHRzLg0KPj4+IFdoaWxlIHRoZSBwY2llIG92ZXJsYXkg
d2FzIGZ1bmN0aW9uYWwsIGJvdGggYXJlIGNvbnZlcnRlZCBmb3IgYQ0KPj4+IGNvbnNpc3RlbnQg
dXNlciBleHBlcmllbmNlIHdoZW4gc2VsZWN0aW5nIGJldHdlZW4gdGhlIHR3byBtdXR1YWxseQ0K
Pj4+IGV4Y2x1c2l2ZSBjb25maWd1cmF0aW9ucy4NCj4+Pg0KPj4+IFJlcG9ydGVkLWJ5OiBHZWVy
dCBVeXR0ZXJob2V2ZW4gPGdlZXJ0QGxpbnV4LW02OGsub3JnPg0KPj4+IENsb3NlczogaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtZGV2aWNldHJlZS9DQU11SE1kWFRncFRuSjlVN2VnQzJY
akZYWE5aNXVpWTFPK1d4TmQ2TFBKVzVSczVLVHdAbWFpbC5nbWFpbC5jb20NCj4+PiBGaXhlczog
YmJlZjQyMDg0Y2MxICgiYXJtNjQ6IGR0czogdGk6IGh1bW1pbmdib2FyZC10OiBhZGQgb3Zlcmxh
eXMgZm9yIG0uMiBwY2ktZSBhbmQgdXNiLTMiKQ0KPj4+IFNpZ25lZC1vZmYtYnk6IEpvc3VhIE1h
eWVyIDxqb3N1YUBzb2xpZC1ydW4uY29tPg0KPj4+IC0tLQ0KPj4+ICAgIGFyY2gvYXJtNjQvYm9v
dC9kdHMvdGkvTWFrZWZpbGUgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgNCAtLS0tDQo+
Pj4gICAgLi4uZ2JvYXJkLXQtcGNpZS5kdHNvID0+IGszLWFtNjQyLWh1bW1pbmdib2FyZC10LXBj
aWUuZHRzfSB8IDE0ICsrKysrKysrLS0tLS0tDQo+Pj4gICAgLi4uZ2JvYXJkLXQtdXNiMy5kdHNv
ID0+IGszLWFtNjQyLWh1bW1pbmdib2FyZC10LXVzYjMuZHRzfSB8IDEzICsrKysrKysrLS0tLS0N
Cj4+PiAgICAzIGZpbGVzIGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKyksIDE1IGRlbGV0aW9ucygt
KQ0KPj4+DQo+PiBQbGVhc2UgaG9sZCBvZmYgb24gdGhpcyBwYXRjaCBmb3IgdGhlIG1vbWVudCwN
Cj4+IFRoYW5rcyB0byBzb21lIGNvbW1lbnRzIGZyb20gR2VlcnQgSSB3aXNoIHRvIHN1Ym1pdCBh
biBhbHRlcm5hdGl2ZQ0KPj4gc29sdXRpb24gdmlhIHNlcGFyYXRlIHBhdGNoLXNldCwgZm9yIGZ1
cnRoZXIgZGlzY3Vzc2lvbi4NCj4gQXMgeW91IHN0YXRlIGluIHRoZSBvdGhlciBwYXRjaCBzZXQg
ICJJIGRvIG5vdCBjb25zaWRlciBpdCByZWFkeSBmb3INCj4gY3VycmVudCBtZXJnZSB3aW5kb3ci
LCAgaXQgbWF5IGJlIHdvcnRod2hpbGUgdG8gbm90IGhvbGQgb2ZmPw0KPiBJdCBjYW4gYWx3YXlz
IGJlIHJldmVydGVkIHdoZW5pZiB0aGUgYWx0ZXJuYXRpdmUgc29sdXRpb24gaXMgYWNjZXB0ZWQu
DQogRnJvbSBteSBzaWRlIGl0IGlzIG5vdCBhIGhpZ2ggcHJpb3JpdHkgdG8gc29sdmUgdGhlIHVz
YjMgZnVuY3Rpb24sDQpJIGFtIG1vcmUgd29ycmllZCBmb3IgdGhlIGRpZmZlcmVuY2UgaW4gaG93
IGEgdXNlcihzcGFjZSkgb3IgYm9vdGxvYWRlciB3aWxsDQpzZWxlY3QgdGhlIGNvcnJlY3QgZmls
ZSBkdXJpbmcgYm9vdC4NCg0KUmlnaHQgbm93IGV2ZW4gdGhvdWdoIHBjaWUgYW5kIHVzYjMgdmFy
aWFudHMgYXJlIG92ZXJsYXlzLA0KIm1ha2UiIGdlbmVyYXRlcyBzdGFuZGFsb25lIGR0YiBmb3Ig
ZWFjaC4NCg0KU2hvdWxkIGRpc3Ryb3MgZXhwZWN0IHRvIGhhdmUgYSAuZHRiIGZvciBlYWNoIGNv
bWJpbmF0aW9uIG9mIG92ZXJsYXlzDQpvbiBhIHBhcnRpY3VsYXIgYm9hcmQ/IEUuZy4gaW1hZ2lu
ZSBpZiB0aGVyZSB3YXMgYWxzbyBhbiBvdmVybGF5DQpyZWFzc2lnbmluZyBldGhlcm5ldCBwb3J0
LCB0aGVuIHdlIGhhdmUgNCBjb21iaW5hdGlvbnMuDQoNCkFsdGVybmF0aXZlbHkgZXhwZWN0YXRp
b24gY2FuIGJlIHRoYXQgdGhlIGJvb3Rsb2FkZXIgY29sbGVjdHMgb3ZlcmxheXMsDQphbmQgYXBw
bGllcyB0aGVtIGFzIG5lZWRlZCBiZWZvcmUgYm9vdCBvbiB0b3Agb2YgYSBiYXNlIGR0Yi4NCg0K
VGhpcyBpcyByZWxldmFudCBlLmcuIGFzIERlYmlhbiB1c2VzIHRoZSAibW9kZWwiIHByb3BlcnR5
DQp0byBpZGVudGlmeSB0aGUgY29ycmVjdCBkdGIgZmlsZSBhbmQgY29weSBpdCB0byAvYm9vdC4N
CkkgYWRkZWQgIm1vZGVsIiBmaWVsZHMgaW4gdGhpcyBwYXRjaC1zZXQgdG8gYWxsb3cgZGlmZmVy
ZW50aWF0aW9uLg0KQnV0IG9uY2UgdGhlIGJvb2xlYW4gaXNzdWUgd2lsbCBiZSBmaXhlZCwgYW5k
IHRoZSBjaGFuZ2UgcmV2ZXJ0ZWQsDQpBIGRpc3RybyBtYXkgaGF2ZSBhbHJlYWR5IGNob3NlbiB0
aGUgdXNiMyBvciBwY2llIHZhcmlhbnRzIGFzIGJhc2UgZHRiDQoNCkkgd291bGQgcHJlZmVyIHRv
IGhvbGQgb2ZmIG9uIHRoaXMgcGF0Y2gtc2V0IHVudGlsIG90aGVyIG9wdGlvbnMgaGF2ZSBiZWVu
DQpleHBsb3JlZCBmdWxseS4NCg0KLg0KDQpzaW5jZXJlbHkNCkpvc3VhIE1heWVyDQoNCg==

