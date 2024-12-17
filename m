Return-Path: <linux-kernel+bounces-448690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B68F99F4454
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 07:50:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B7D2163F20
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 06:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274111DB37F;
	Tue, 17 Dec 2024 06:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="7cZDDi6e"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2074.outbound.protection.outlook.com [40.107.236.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F80175D50;
	Tue, 17 Dec 2024 06:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734417845; cv=fail; b=RpHKfr9tOp+CEjbECZmlhb8/ZW4Nt7pDfE6KwskgkRtb5yD3DFFd9mHB1EWuqM11YR/koOhpBdEmoU+TBRNycTOCYQoccPkd7boKOEXl7PkT3tk1NrbBlOUkFUB0vmJrj4b5T47B2JZ/U7hmVx1rrmhL7eyAEgtdq8NSxR7zjBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734417845; c=relaxed/simple;
	bh=GTXsI8oIU7x/MevhuZbhNgGWMQKgXD/Ho24tfUyqg80=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y6N4HL4WcxicrpRszm78WQhU1Ak6YHpb6uID7gSPz2bW1NyTm4vuQ6vmnSlddqcOSu9aU3pxvl94qHJbJy50CfO7CjxpIZJXnkotRqnTZBuV9Dk19At0l5f22jijacu/X4qO81jA8fTV1SYe/Jin+6aYNJS21xFKmHk44E1bxio=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=7cZDDi6e; arc=fail smtp.client-ip=40.107.236.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rj8uHylOdqAN0joLrzZSjkNxevVWSFOH0HMJKdLIZbPLRD7V9hcNaQ+NHlobMEgTgXc11vRQx9SO7UPo+dS1ZpH3D+JE6QdR4oc2ty8el/0gVdCx+j6YxitLqNsaRfo0pruRlw98SLO1Njs+WyVw9Km+AT6NAFYgxxPE5qgw7OvzNgFjl3SKwG15vye3EVwBCgvsDLRvAaOvhxdQnLACvmgTiWDsObZWkavMUhooqTtnvCaajPuLxmmfnamjy3NePScreOkUKs6P3Wt/2TZKZjlZbczS1bm2VCHPuCJoYYbCWgayAiiUbQWs1V0Ak7nxf69/Td8ttmda61liaqu6pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GTXsI8oIU7x/MevhuZbhNgGWMQKgXD/Ho24tfUyqg80=;
 b=Y1cnNlxJdfSV6WEvLaRE18hIKbF4igR5uyj80zRlmey8ydyREFMoN/NIrezyd/W4aqOOObB6025eHhZL6HVKEVCL9GgPc7QI1rSzG+iwdoGPPm40VdcTe7J5aFQ3TijfQrrD33Zaf20xX7dDRjPOmbO3xOENa8lFu4tMgZUU/gWWcxByxCfciGfhg1aD5bSENcOT0sw8Qqg2pCSxFQTysYXQDOC3L1Ghd9FqWulJQIF9TeHF0LuyeS7w2Z4ksBow4jlz7MYD4xhXsnfZ4R6MOdONT2ZJe4fpMOmOonPFUHpV0FofjytW/dfmgMHhC4RSPOdaIKZEEBZBv38nSugFjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GTXsI8oIU7x/MevhuZbhNgGWMQKgXD/Ho24tfUyqg80=;
 b=7cZDDi6egj9CCi8OOb4+3k/8YZWJqE+o3R3MjDt/HWOUvRIYgp79b7BJceBxzk+L3t3Xb6m5r90nTIM9GTe5CkpJLbOk1m3FW0/b/M2id6Ohnt+bOmyHsPx3uFe/B05OA6+UdXSCOZigifSGLdjjVD41InOmEtSbo2AThc3PKjsGw9GlTcRn4uN3ag0FvqwxciqhF5vsX1x7uLweJIJiXqHqbrZfeMyGR3DDgrRnjeqnffiEAOcAGfe0l4W/7Nj9ALNMjz1XYU58KLyfdP/lTQWPriEku/dMBKh/xByCugT9HCBGMIeukvEr8DK3zWfakCirCmXEalyu8fDvZZRzcQ==
Received: from DS0PR11MB7410.namprd11.prod.outlook.com (2603:10b6:8:151::11)
 by SJ0PR11MB6717.namprd11.prod.outlook.com (2603:10b6:a03:44f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.20; Tue, 17 Dec
 2024 06:44:00 +0000
Received: from DS0PR11MB7410.namprd11.prod.outlook.com
 ([fe80::bc90:804:a33d:d710]) by DS0PR11MB7410.namprd11.prod.outlook.com
 ([fe80::bc90:804:a33d:d710%6]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 06:44:00 +0000
From: <Charan.Pedumuru@microchip.com>
To: <krzk@kernel.org>
CC: <lee@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <Nicolas.Ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: mfd: atmel,at91sam9260: Convert to json
 schema
Thread-Topic: [PATCH] dt-bindings: mfd: atmel,at91sam9260: Convert to json
 schema
Thread-Index: AQHbS8APw+ZU4Xjwh0acaGZqn7hy2LLorvwAgAE6oICAAAi1gIAAFEcA
Date: Tue, 17 Dec 2024 06:44:00 +0000
Message-ID: <e75e296a-c749-4194-b013-eb3ae0678d3d@microchip.com>
References: <20241211-matrix-v1-1-5ef0104a3af4@microchip.com>
 <dxgqkdo6ulmqfa5vyerwta3vubuy32gzzu2cxfwwtespydfc4b@5wjrno3lgjsp>
 <92579055-5a46-4f20-b579-123188554a03@microchip.com>
 <4e4e8a02-5fc1-4b90-ad9d-9f9ec5c8bc61@kernel.org>
In-Reply-To: <4e4e8a02-5fc1-4b90-ad9d-9f9ec5c8bc61@kernel.org>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7410:EE_|SJ0PR11MB6717:EE_
x-ms-office365-filtering-correlation-id: fe1557ba-7271-43a8-b57e-08dd1e663071
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7410.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Y3lrYlBITkI4RER5Szhvb2FvWmoxY2UyRmdwMEVwRHFvU3pvVzZZTWd2V0ZE?=
 =?utf-8?B?MU1NS3RCYUZ1bEIwbWIyQjdySmQ5STI4Y2pYVVlHOTFrVWRCa0RFbHozMEhT?=
 =?utf-8?B?WVpxTlZDU2JxQ09EQkwzbDF3dmRhOXJmMUdXY2Z1S21taytXcHM4SWJFTGRt?=
 =?utf-8?B?c0dwSXBPQUNTbFBXdi9xa29qcmZSeXdTcWNsV1VSOVJRaFNpRWNPN1pjbnpv?=
 =?utf-8?B?Z2ZMZGlzWVdhQ3BjdUwzd2NYTFAwSFpMYW5BU1laUjRCcGF0WGxUcENKMlFG?=
 =?utf-8?B?WmpsRTJaaFRwNUFpcjM1ZzBDZDVZbmlWcUF4WWIrT1N0Wk04UHM1VmJUUTk3?=
 =?utf-8?B?TW1oMmo4bU5jQ0NUUnFNbHZyd0REV3hVOGl1Vll5L01VM21QSFR2T3F0M2d4?=
 =?utf-8?B?ZlJ5dFNNcW1zbnd5T2hrODRRVEp1NEFhTXpvckwybFRuOFp2aXNQaEo2S2pC?=
 =?utf-8?B?QnMrY1lnczYrMjAwcVVORWFLVEIrY3I0VjM1YlhJekhkSEZ4S2ZnNGQwWlBG?=
 =?utf-8?B?Zy9NMFFLeG9JY2lISTdmalJyck9iNitwemcxUXgyMnRRRTJXMTczUklJNXlx?=
 =?utf-8?B?UU4zeXJPUHp2S0FDWmkxSEdFeFVXbUdSN2RNODBtdTVwYlRhamswZjFlQXd4?=
 =?utf-8?B?eFdKaGtZOE5HM2lya29OQm1hOHlWcU5NSmhEY3haOW5qeVBTR1BWdXU3L296?=
 =?utf-8?B?aEY3K2V3dFRwd0NWVmlENGw3djhGWWorRmZpWk8xSjBtSWljSllsTFh1Y2Jh?=
 =?utf-8?B?Z2RqQ0l0bXlKNDNrNzgwZFdna2g0UmtyT0gzN0ZKMm9naHM3WGY0VG0vbU9I?=
 =?utf-8?B?cUVEYms2anFicnZJa3pMNnMwVEhZL3ZqVmFzeEdnTVVkK2EvQkVIYjVHbkdT?=
 =?utf-8?B?YkhjTTk5c3hIOGgwVC9hcmxYa0pKMURTUlJMNUdPYmxYUDJ6ZmhWSEpISVFq?=
 =?utf-8?B?SVAySVNSY296Rkd1ekVqdW1QQjRLdExRQzJWWTJoazdlaWM5SXVaYm1WSUV1?=
 =?utf-8?B?WFg4b3dRMjlraVlYci9aRFVmVTQvQ1JDelcrYW82ektsQ2dSaG9iNGpnVXNC?=
 =?utf-8?B?Q0hWSU03T3g1Vk1oV05lcmJIanpPSXAvcUtVWUhzdzNxU1ArcWRsaWtUNXR5?=
 =?utf-8?B?QXBKdVZsdks2RU1TMWxxdi8yNEJxYldvd2ZjUUJRQzMzWVdEZGRhQWYzYkd5?=
 =?utf-8?B?ZERsRC9ta3hJR0F3aGt6eWZ6VnlvWnpRdDQyblBsODRQb3UwaWN6M0dtMFI5?=
 =?utf-8?B?QzZieFVqU05VUDd1K2NMMXBhazM5MEhHVllieEpuYzR1dVllTXRxRXJBOXVl?=
 =?utf-8?B?dm9YREViWXFIWUpXREhQWFg4aFVCaTVoOXNlbEZVeG01U1Ruc013bEswZkw5?=
 =?utf-8?B?QTIzdmxtd2NFaUZ2aEdLZTRCVlViWmthdmZqN1pDQUJPOWN4K3hZZExKSWlQ?=
 =?utf-8?B?bFVwT09WVngyNmRJdTBEUkVUbXdsVUNhYmV6ZDgwZVMzMUtvcXZhaVE5dE9W?=
 =?utf-8?B?WkwxRnE2RHNuUmF4eFhESkU4cTgxZmNDQ05LZ2h0RDNCWWhLdTJmd3QvN2N0?=
 =?utf-8?B?aXhzM01NWTR6bTc4a3VaTTlySnErRkVjREtFSG1lT0N0Y0R2Y3pGcmxwMVZN?=
 =?utf-8?B?cm83MVNhK2R2MndzVGQ4ZEF4dU1YN0s3SWpFVVNHbHhhMXUzSnN2OGFocjlU?=
 =?utf-8?B?VFUyYVVVMnAyeFU1YXA2Wkx4TTV6NmZMcnlkelZORGlZTVdDQXVYVFZFTkk1?=
 =?utf-8?B?SWk2NGEwZ0lXRUVxVDhYMU1PMk93YWlVbHY4QkcrdHRhc2NmSUQwdUFtaFA4?=
 =?utf-8?B?emgvajJ5andCbys5VnJGdTJpeTlCMjk5YmtZZ3lPZVZQdVBrWWFOQkdZdEZa?=
 =?utf-8?B?a2ZBejNUeUhWakJ6SlZvR0RUYVRHY2FFUmRTazhaNzZzTEkrUithdFNvUXJK?=
 =?utf-8?Q?A3NpsJrCpDljk87fs+3JBnoveAMaoeiT?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UWZIcURZRWFSL3RvbzVqaStmN0NxcmtDK1BWcjJTVTJKUHE0NmdWcmNGY2R5?=
 =?utf-8?B?ZVlsekp1OW5ORk52QnZJYkR6eDFROWVDdkE3cC9OVXNIclliNy9HOWtHRHhR?=
 =?utf-8?B?NTVRVEU0SktlbGkrWVMzUjdqVCtiVUpqNkIyR3ZUdldNZGNENXlUMmhSNm9q?=
 =?utf-8?B?akNZbWV0bjFZbnZlby9zSWZwTS81STJObTZuSjFoeWNEREViL3BzeXJIWlVD?=
 =?utf-8?B?MWdoWW1EQThqNmR6M0hJazF4MnJ3OHZ3UFowdHl0cUxDeHRnN1l1c3lHbTlP?=
 =?utf-8?B?YkY4TFNKR0UrK3g0NE5Za1JpSlhJZDIwVHY0TkhFdUhBYWVLTVNHalpSQlM0?=
 =?utf-8?B?Q3N5TmxTMUluQ1FvVERDWkhZT0w4K1lTTk8rVm5hekZTaVhZek44VkNQeGlW?=
 =?utf-8?B?YndVdGVJNHd2dlM3bnBKQnkvdlNpejlpM2M4WWYvY1g3c3ViMDNnc3VJdGxB?=
 =?utf-8?B?L3IzR0V1NERmdk5sanNrN21SZWNTMGVLK1hsaTBtcWg0ZE8vb3dDL2pJRm1x?=
 =?utf-8?B?N2lsTVJtdlh6ZnZrNDVpdVRhZWw0ejYzZWR3K3lncHpvM2pjWnQxeU9vWXBy?=
 =?utf-8?B?Qm1JVFRBUTlDOEQyZHJRYmF4SnBqSmhsQTlMRlBMYnREVWc4TFpPN0lxOVpD?=
 =?utf-8?B?dXAvZmJhTXhKUFcxVmcrSnpUWG1kMU0zaGRSNmdzR1F0S1pUVW80QUlPTUxP?=
 =?utf-8?B?dUFBNkFDSzU2T3V2WXA0VXpIN21JMUtmVW9oMFNOOHFSMWkyZjhKamE0UEE5?=
 =?utf-8?B?WXl4Zko0S1hTeU9mSHRlcmdxK3FSV2R2MTYrdnNzTzBoUEQxUG1BMmdFVnYv?=
 =?utf-8?B?ajhVZDhyZ2QyUGx5SDVkUUw3ZXJhRjdndWkycmxTUDZCSVhDNmFXZTBOTFpI?=
 =?utf-8?B?T2pXUHhGNjAzenVHcUFtZjhDTGx0ajdmUCtET3NUWjRBdzdxKzZQb1dLYmRv?=
 =?utf-8?B?dmx6cFgwZ3hHdksySG82ZnRTTnBkd1pwS0Q0ZmVlWGh6bU56RUdXKzFzVjgz?=
 =?utf-8?B?ODR3KzhsUGg2Rk1ZYlBjTjZKQ3dGQkVjKzIzQUYxZTlxUElBNFJZSnhPQ0dI?=
 =?utf-8?B?QXk2d2h2bVhvU1VyUE8wUkk2RFpvY1RBRVR3TFE3ZzJRa1F5Q1N2cXVabExm?=
 =?utf-8?B?c3BKMmZmbStMNERXNWtKYlpKMFc2emRGbzFmVTJ0OG1nUzhidGpKSHhBcmxZ?=
 =?utf-8?B?Um9oOWljeW1XNENaL1ZaMGtsS0RVT2MxZmtscEpUd0k5d0kvMGlZWXRaaHFJ?=
 =?utf-8?B?eWVYQWNNVmdoT2ZISE5MOWpIeGVlMy9XOVlXTDB0QmQxSE1wYkNSbXp2Y1Np?=
 =?utf-8?B?eEVVSGpJNGFmSW94L0E2cDByYi84S24zRk9vK1o4YmdUemk2empnMkZkTEFC?=
 =?utf-8?B?UDBROVlrTzBDYVNZWlR3WE9naWd1SHJFYmtQNHNzZFZQWEtock9Qc2F3eUw1?=
 =?utf-8?B?RGRhRm93bTBhbUFkRmsvdjJ1aEVvZ0xxZzFYWVRJWmZXbS84S1VtR1hBYlMx?=
 =?utf-8?B?OVpsb3hTVlJ0YnJlNmJBVkpQeGtLMUhKcEVtUnFYeTIxYUZldHFLMU9sdTh4?=
 =?utf-8?B?ekVSaDFZdTlrYlNOb3JxWFYzMlZPdFNMTHNBZHNZN0QvcnpTc1ZYSHBJT0NV?=
 =?utf-8?B?Sll6WXhVWkR6TEFvVWt3TUlhLzlDTHZGTFNndmdPUklVYWMrRmozY3E3ZnRI?=
 =?utf-8?B?cHhGLzJPTHBjWTc3RXZtc29lMlBKRlBEU0VzcEtRSG5ZOHhPS3R0VWZwMWIr?=
 =?utf-8?B?YXZaYldoRDN0c2tTRUkvZ2ViODJEOEdkSDRRRmhYTTRNUkd3bEloZ3pXQklZ?=
 =?utf-8?B?RkJ5ODQ1VThpYU5WM3FhT3A2cDI1WmErejFmYnNCSy9IZ3Q4UHppNE9nSGFL?=
 =?utf-8?B?MEJsV1dteU0yTTUzQStOVXR3M0M5ZDdGS2dKODJrbE1uaithOEtlOXZ2eXo0?=
 =?utf-8?B?aTdKcGgydHVUK3BwNDIvOUtnR3l2dDhacWNjUXFGZ3VvUEp4MFhneEdXdmhG?=
 =?utf-8?B?TWtHWW4rbUZLdDFqS2xTbVlPMVhMUEtWbG1OQXMzYnpXdU93dHZ5bWs4Ujcy?=
 =?utf-8?B?cUtiS2pwbVV2RU9NQUJkNzhuWFdyUnkwK1ZNN21jaE1WSGY0Mk1vNGM2MFpY?=
 =?utf-8?B?NDlRaW9uWHozSDEvWjYwNnU4dmZacVJRNnZyS3dlS1lrYW12K3RLNWNycm52?=
 =?utf-8?B?Tmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <189EF4E74E387B4CB3CC36A04BC5EAC5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7410.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe1557ba-7271-43a8-b57e-08dd1e663071
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2024 06:44:00.4366
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NcD7mLNzX4fnq71g5AZoiMzRW1uV+on/tCExz9Zd+Unf+t8dNyHXMtfzAVc/Wj/GD6ctX1rwURqfcc6Hcanu0RjvX7FvOvyG9m4A6J2rLTo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6717

T24gMTcvMTIvMjQgMTE6MDEsIEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+IEVYVEVSTkFM
IEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91
IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPg0KPiBPbiAxNy8xMi8yMDI0IDA2OjAwLCBDaGFy
YW4uUGVkdW11cnVAbWljcm9jaGlwLmNvbSB3cm90ZToNCj4+Pj4gKyAgICAgIC0gaXRlbXM6DQo+
Pj4+ICsgICAgICAgICAgLSBlbnVtOg0KPj4+PiArICAgICAgICAgICAgICAtIGF0bWVsLGF0OTFz
YW05MjYwLW1hdHJpeA0KPj4+PiArICAgICAgICAgICAgICAtIGF0bWVsLGF0OTFzYW05MjYxLW1h
dHJpeA0KPj4+PiArICAgICAgICAgICAgICAtIGF0bWVsLGF0OTFzYW05MjYzLW1hdHJpeA0KPj4+
PiArICAgICAgICAgICAgICAtIGF0bWVsLGF0OTFzYW05cmwtbWF0cml4DQo+Pj4+ICsgICAgICAg
ICAgICAgIC0gYXRtZWwsYXQ5MXNhbTlnNDUtbWF0cml4DQo+Pj4+ICsgICAgICAgICAgICAgIC0g
YXRtZWwsYXQ5MXNhbTluMTItbWF0cml4DQo+Pj4+ICsgICAgICAgICAgICAgIC0gYXRtZWwsYXQ5
MXNhbTl4NS1tYXRyaXgNCj4+Pj4gKyAgICAgICAgICAgICAgLSBhdG1lbCxzYW1hNWQzLW1hdHJp
eA0KPj4+PiArICAgICAgICAgIC0gY29uc3Q6IHN5c2Nvbg0KPj4+PiArICAgICAgLSBpdGVtczoN
Cj4+Pj4gKyAgICAgICAgICAtIGNvbnN0OiBtaWNyb2NoaXAsc2FtOXg2MC1tYXRyaXgNCj4+Pj4g
KyAgICAgICAgICAtIGNvbnN0OiBhdG1lbCxhdDkxc2FtOXg1LW1hdHJpeA0KPj4+PiArICAgICAg
ICAgIC0gY29uc3Q6IHN5c2Nvbg0KPj4+PiArICAgICAgLSBpdGVtczoNCj4+Pj4gKyAgICAgICAg
ICAtIGNvbnN0OiBtaWNyb2NoaXAsc2FtOXg3LW1hdHJpeA0KPj4+IFNvIHRoYXQncyBqdXN0IGVu
dW0gd2l0aCBwcmV2aW91cyBncm91cC4NCj4+IFllcywgYXMgYm90aCBib2FyZHMgaGF2ZSAyIGNv
bXBhdGlibGVzIG9uZSBhZnRlciBhbm90aGVyLCBJIGRlZmluZWQgdGhlbQ0KPj4gYXMgdHdvIGRp
ZmZlcmVudCBncm91cHMgdG8gcmVzb2x2ZSBkdF9jaGVjayB3YXJuaW5ncy4NCj4gTXkgY29tbWVu
dCBzdGFuZHMuIEkgdW5kZXJzdGFuZCB5b3VyICJZZXMiIG1lYW5zIHlvdSB3aWxsIGZpeCBpdC4N
Cg0KWWVzLCBJIHdpbGwgcmVtb3ZlIHRoZSBvdGhlciBncm91cCBhbmQgZGVmaW5lIGJvdGggDQpg
bWljcm9jaGlwLHNhbTl4NjAtbWF0cml4YCBhbmQgYG1pY3JvY2hpcCxzYW05eDctbWF0cml4YCBp
biBlbnVtIHVuZGVyIA0KaXRlbXMgYW5kIGFkZCBjb25zdC4NCg0KPg0KPg0KPiBCZXN0IHJlZ2Fy
ZHMsDQo+IEtyenlzenRvZg0KDQoNCi0tIA0KQmVzdCBSZWdhcmRzLA0KQ2hhcmFuLg0KDQo=

