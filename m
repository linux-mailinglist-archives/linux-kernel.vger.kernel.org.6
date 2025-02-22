Return-Path: <linux-kernel+bounces-527476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 292CDA40BA5
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 22:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 216623B245C
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 21:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83693203703;
	Sat, 22 Feb 2025 21:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="fL85HVnp"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068B616C69F;
	Sat, 22 Feb 2025 21:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740258156; cv=fail; b=U8PaY7OwAdLJHGNl830gL8pAdaB4rHU9V9EhG2AZnl57AiNycW4JzDbGIt5jtNlfHzWDRCG4gcQxR8i+XJocBJ5IPv1z6tbfcJX3QBRdUfvm/kKJX3KaDg7PuuLEWUBNv58UE2FAdsHbdv38OTGtjDxooJpdNI5T1wwkaDUuIFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740258156; c=relaxed/simple;
	bh=nSh1gMpa7Q1GKYzdUgAq6vW9TxoAPyJfQIH3XglpC8Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=BE7O0oUsGSvEZahHm5+mt+EdTS3rAr+znZkdUf2eOrMnZOyU+Lf2VUSRmss2ob04qrF/6fbUZ3QAzeRrON+Xrg9Oe9Qn2/wID6uh1qPtstEVPPyXYv5WgHn7FovwSgappCf+CnXnxxD6q3cxzkBZ+q7G3pDLOdsfS2zJfdKQg+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=fail (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=fL85HVnp reason="signature verification failed"; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51ML1uQO002069;
	Sat, 22 Feb 2025 13:02:22 -0800
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2041.outbound.protection.outlook.com [104.47.58.41])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 44yeykrg0d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 22 Feb 2025 13:02:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JWy9VY4yb4AJ59x2Zs0YVa9KqRzQ3qws8hi+eaPAtjDS/t5Gkhk6jZ83lKW6Y/K0QOMgs8Mv6lpAk7tZ5TbCmL5cH4sNAFtQ1GepdyX+dmE3NFNOZ46JQOtdgobQ1Vm7+k1UnhdS/2uSdWoqaVGRVtDV9YembwSI2MTFbwYWPRmYkD7RyXh+mXuKzYiEEQ7P5KpvdhfCGGlkKYQx5LqwHHbegcldWLKbJ1QSTBkt6JqCvjW6Pse5P6e6FyyxXNnJNJvnrHJTTjkjNoRqASp6lFo5la2Yn3wn8sHPNE+3XT+uaPgj0GnRlG5gfs6HnomSy6xtIf2/hulTJoxVogqipA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xYKmLP84MedpeTZo5jE7ng0o8juweAfnuZu+2foFjjo=;
 b=Ll6lRUIYuTd9CBDCsPU0uoZ7hO/Q0L02rRwePJVG4JrQh2hVbyB5vZKwBJGrUmfCB0qkGiLYO6sIILXtrDmlsmvwysavAJgZyeFertQZg7HhSHoX7m2cSjM2YjV2eRP9hIGIeCe1ttFYZsTkOZYpgfbkQUd4n8+secoRVGXMqIVQvUT4XE8H3081R4ADcLGOreUfZDBoxdjgNh+L+B2rnMShbfvIfOHE1JB7aqlHE28JIr4c++DGAHLvxbAEh7ZPs70NEWvTEo7bddHZNY2PcidZ4bHjcp1YONJzynb9FzUic1ttbD10muO3w6wcCjqlJn0AbO8i2WBxbdEbrLKLWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xYKmLP84MedpeTZo5jE7ng0o8juweAfnuZu+2foFjjo=;
 b=fL85HVnpKsaxsGeWqbiq5Gutg95g3GWjkjJ6ONKehXB9dhiIJcwnYVDxBB1FNqLeHyatrRkQPqlloWEkjRKPlQWHMTf1K9SZsYo25+x+oIFZECdrr8tcPyIz0NcSWS14lv3Ax7HWaWNwYYA0bVXk049t3ZIebbyeDPOiWsgCYMc=
Received: from BY3PR18MB4673.namprd18.prod.outlook.com (2603:10b6:a03:3c4::20)
 by PH0PR18MB4799.namprd18.prod.outlook.com (2603:10b6:510:c3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.18; Sat, 22 Feb
 2025 21:02:16 +0000
Received: from BY3PR18MB4673.namprd18.prod.outlook.com
 ([fe80::fbd6:a3a:9635:98b5]) by BY3PR18MB4673.namprd18.prod.outlook.com
 ([fe80::fbd6:a3a:9635:98b5%5]) with mapi id 15.20.8466.016; Sat, 22 Feb 2025
 21:02:16 +0000
From: Wilson Ding <dingwei@marvell.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        Sanghoon Lee
	<salee@marvell.com>,
        Geethasowjanya Akula <gakula@marvell.com>
Subject: RE: [EXTERNAL] Re: [PATCH v2 2/4] dt-bindings: cp110: Document the
 reset controller
Thread-Topic: [EXTERNAL] Re: [PATCH v2 2/4] dt-bindings: cp110: Document the
 reset controller
Thread-Index: AQHbg+6+qH+/Pv1FdESXnLOCJGgYq7NRcleAgAJemFA=
Date: Sat, 22 Feb 2025 21:02:16 +0000
Message-ID:
 <BY3PR18MB4673E3FA63FA85F1C11E68F0A7C62@BY3PR18MB4673.namprd18.prod.outlook.com>
References: <20250220232527.882888-1-dingwei@marvell.com>
 <20250220232527.882888-3-dingwei@marvell.com>
 <20250221-huge-able-ostrich-5c70cd@krzk-bin>
In-Reply-To: <20250221-huge-able-ostrich-5c70cd@krzk-bin>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4673:EE_|PH0PR18MB4799:EE_
x-ms-office365-filtering-correlation-id: 38a7871a-7e40-4602-dbc1-08dd5384300c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?QVY4ZVVtMXlsYkltbk1KaDk3ciszMEo4d3NNRzZhQ2tyUklaQ1Z2TnJuQ3Jo?=
 =?utf-8?B?bGlmUGVKdUtCb2Vwa3QrQnJoVWpjcGl1bFBVTFVqVEdFTk53K0M0Zk9Yekwy?=
 =?utf-8?B?SjJiaHFOeThvSW10TVBWTkxEYXdMU2xKUE1HUk1sbjRGYm4xN2RQSEFXaUhZ?=
 =?utf-8?B?OW0yRC84LzFpdWFkYnpGRXo5K3R4Q3VPTFUrQytYOWU5cEJxWWRTSDhCT1RM?=
 =?utf-8?B?M2VOdnNPMEs2TFE2V1JuSy8yay9MWXZuRnM2cFhSaTQydUdPR2NrMlVzKytX?=
 =?utf-8?B?eW93R2RpVzhLWERzYVM3ZjBkYkJnd1ZjcTlYSzVRa0ovbkpkRzkzSVZHTHp4?=
 =?utf-8?B?ZUszWE5QT2NJMkxlaGlJRnN2UmIwemN0MERiMlU1bkpDaWcvMUd0aWM0dmFx?=
 =?utf-8?B?Q2p0MXZkZkpKMENrZjV5eXloejJoK1YwWlgrNDdBa0hhZEtyWUJXanE0cDdi?=
 =?utf-8?B?UGxMU3dQRUNTVFZYTTBnSElxNkprbHhjcjMrWVkySHcvMVA5NGQxeUFRK2NM?=
 =?utf-8?B?V3plOHZmVFBLMEJQa0NXTW9yaml5UStFdTE3ZjZ3MmdnbjYvTktBVlg1cERR?=
 =?utf-8?B?UmlxM0xKQ2lhY2FQeFdFbWdVVFV6UlFsZlhhanNhOTRUMHBHZk9NZUZkU3BH?=
 =?utf-8?B?SGxXd0tmMjh4SDE4b2RhMnNxZ05yN21YaXFGTW1xb2l1dVF5N3A0TlhoTWNQ?=
 =?utf-8?B?QnAvTklGdmNUbFNuSFBBTmlCZ2U4NTFYSjQwdmJaVnc5NjdteHFPNzhUU0Ft?=
 =?utf-8?B?dS9tc2RFN1ZtYUpzYmMvNGNnaUUvTlZkbGdhZFl2MytrUng0NW9uZldVODZI?=
 =?utf-8?B?QUlBRGVkeDdubFA1bTg2Q29NTkFMTXhwOVFLSkNWbU9pZUJDV3pwVmlSeU8y?=
 =?utf-8?B?cm1BR2s3YmFtaDAzaGdBVFlzMUlSMWZQcTM2NGp5K2xmSjVlR0cwMGZJUFc5?=
 =?utf-8?B?M2pZZTdjS3l1elg5RUlkT1RQTmpqd0RBeWxNYUtQb2ppNzN5MFordENUbkR5?=
 =?utf-8?B?VTd4YUluVXh3dU9rVjljRnRPdWMyVFdDOWh1MDBLUm84cUpnSkE2SkpiZjFT?=
 =?utf-8?B?K1FlSEVna0tYa2Z6Zm1la3BKNmF1K2ZmWWQ2cUJBeXcxdk94Ri93TGdkUERY?=
 =?utf-8?B?aXRYR0Z5WUFDemVhTThOby9xYmVZalF4UlRBbS9xTSs3M2pLTWJlQXJtQTVo?=
 =?utf-8?B?UEtkN2VNeVpjMVR5TjVJdGY5eGpZd2tnMWYxVUZ5OU4yVVRKWmhieHBhV2Rx?=
 =?utf-8?B?OTU0b1NlVExOcmJwcnFWcnRDczZxNE5JN2ova3hkK0xZUGdiVGxpblVhNEZK?=
 =?utf-8?B?TkRuOHJKS1pHRkFhUmlRVUxVcDl0eS9xYTlBenNxTXI5VzNqT1Z6NnNwOFE1?=
 =?utf-8?B?UmwzL0hXVVRXd0g0R29jMVhUQXRldHVKbGJFdi9tbDJUdlE5ZDlqWlE0dE50?=
 =?utf-8?B?YTliSSt6dE00MDBhenBHcE44UXhzV1lHSEJ1SHg0VzEvK0pkbTQ1QTJTZWVD?=
 =?utf-8?B?TjRCd1NJZUNDa0VQaHp6YmxIaXIzbm0rTXBNL2FEcGRmaXRUM2x2WTYvdU04?=
 =?utf-8?B?ZFkvYlMrODZsakc4ckVVbWFHaS9SWnNlSlk1QWhLNUJSQXp5cnBxclZSbWdM?=
 =?utf-8?B?bEJPRTFkTDNBZEhHSG5Jejc4YStOc1NkTmRTNm9OZy83UEcyVklDUWlQbzBk?=
 =?utf-8?B?L203RVlTYThHdEdZYWZ6Mjc4a3hlaW84N0VCdnVkcjdHQVNZQk1RVG1IaHJN?=
 =?utf-8?B?UW1qNzQ1N2VNYUExcVRPVllxNlBXczJtRUxwc09XYmJRZFdzcTVKSkJZQjV0?=
 =?utf-8?B?WmJTR2haRHNZZVFjMEs5MUYyTUFlUDhPOHNjejF4bnVUdlUvQlN0S0VLS25r?=
 =?utf-8?B?Y0VrclppbTM5cVlhMUdZYWFINXhkNmRjRW9qL0R4Z0gwL0E9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR18MB4673.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dkxWSDZ4UmwvMVZJcGF4M1l5UDNQM2RCT2phQmdBbklTN3R4bzNtNDhKakZt?=
 =?utf-8?B?NC9xVXJtSEVwdHJ2OW5SUXNXNURzOHdSamY3T1NENXBROU1CR3NkNzVxZkpv?=
 =?utf-8?B?OGhsZWdLMStMVFhWZXFhbEx1SmZvcGRhZU1CTTRYMzZ6d3JSU1MvK01FTG1J?=
 =?utf-8?B?UHlZUktOeTlUNzlWNUtiRmRWOUo4UWRZczF1UCtucytXcHdPNlR5Z0ZXUm9C?=
 =?utf-8?B?OGE2blR2WUxBTnMzWHEvaVZhcUtwSEp6d1hwQkRLVnNhalpOR1VlcnZPR0Ey?=
 =?utf-8?B?eVczOHdOYmxQLzU1eTNrSEU3c09ISUd0WDRkcFI2eHF4QU9qVDVXaTdDWGRC?=
 =?utf-8?B?b09yVld6QkxMYkhmR1ZCU2dyMXJOWUMxb2hEaEZNVEZ1eHpOZXNxWlZIWUZz?=
 =?utf-8?B?WmxXQ2NibTU3ZXFsNW44bmtpcFFVRGlFQ3Y2WUtCb3VvZzZMZk8weU5yOUNh?=
 =?utf-8?B?MWx4V1FiNDB6Q2xQdHV6aDFxZFIvU3VYYjBLbDIrNFZ3TGxwOXQ4WjRWcGVI?=
 =?utf-8?B?SVJYRDQyWThCK3FNOWRRYjJoMm96aHRjcW01bWtRVURmd2J5VXh0c3ltT0xE?=
 =?utf-8?B?UDh5Mng2c1JVM014Q3lLWGRjZ3JlRU1IYXVxMTdOUGxOUE9WenhGbVNGbkcv?=
 =?utf-8?B?bHl6c2pMamlhQ3loTzAvdEJVd3ZGS0tzaFc2T1RpUzM1ZUxZOXh1ZTByL05a?=
 =?utf-8?B?Si9mMWw3QURVRHh5NnFVT2JrTy9mK2wwT1FwWE9Tbm1Tbm9ZRTBsM3VQOWll?=
 =?utf-8?B?dHovOTFrTTg1MTMxOW5pZFROOUVuZVNMZWdxK1dhbS9aUExldndZZ3FTRFBX?=
 =?utf-8?B?dXkxcUlQK1kzWEw2bWJBWGNOWE8zemhpTy82YkVKVXE0YnNzcUUzQTZjSHg1?=
 =?utf-8?B?MC9oVytzNlRNRXBHWUVqZ3hQeUsrbWJ6NHFESDh6Z1VjMm9TbWoxeGdBeFR2?=
 =?utf-8?B?N0V4cDJWSEhidmJWM2g2NCtxZnVzZ01EcDNkYTdlUzlHbnpUcFlZTzExNmtW?=
 =?utf-8?B?VVVqdzl1OWRndlF4VTVpaWlmdklOWDJ4OCsrc0U1VlN3Zk5yNGtjWlpKTjJp?=
 =?utf-8?B?NGZ2TENmVERvZFpxcXN0V3U2YU0wb0o5MmU2ZXBGY1Z1TUZmYi8rOWtTdTBB?=
 =?utf-8?B?ZUo0NUc5WHFWWTBWWVVIYnUyaE9vYUtZbmlyL3VNYXhWaUtGZ0wvaGhPbEQ2?=
 =?utf-8?B?N2pVbzRXMS9MeVh2UEZWOG1hbGdNRzgvRlI1ZHcwbktWVFlBK2w0QmF2Umo5?=
 =?utf-8?B?UzVDUnRTY3p1Y2JNdkYyV1RqcXduKzEwVjQzc205OHBmNHRxaWJpYXhreVNO?=
 =?utf-8?B?a3Bvd2d3UC9LbFRGblROZFp2WWxjVW4walFkdWFrdVFpUlppb3djUHdKTEhu?=
 =?utf-8?B?TW9lNVZiblNzRm41Z0w5aEUxYStpYjJwTUpEZVgvdHFVdHExSWVqRWs3VUZu?=
 =?utf-8?B?ME1HY0lLV281LzhSeTJYb2FkbEI5NE1UeTVsZ1VUM1NZaEdvb3dIdWU5OFVW?=
 =?utf-8?B?cW84Z0hWR3NJbGxDc1pBcFg3N1hUdFJqbFcwUTdTbkxxMFlISmI3Vm91dnJx?=
 =?utf-8?B?bGswWGhUNXNIU1UxYmdkbUthZXFvNHBxeTFKZGNnUGRncllFTEl5WEg1TlZT?=
 =?utf-8?B?Q0JtbmlhY01acG9XbE1IbVQrWTF4VWdXSjBlclpIYWlGazlNeWdpK2UzeGgv?=
 =?utf-8?B?RDBYQlYvQ2h0NllyR3RjZm0wSVZjQnJ6bW96NVdrblB4aWIzUWVScXpIRmVV?=
 =?utf-8?B?NVFBYjNqRlFkRDNYTXdnd3VFVWZHUzJCRUV0TkRIZG5UeFdsamI1QnN3Mk9F?=
 =?utf-8?B?d2NUWXF6bUxndytVZHgrVTlRUzhtUzZGVWlkWnVWbjg3ZFZ2VkxzdTNPTVVK?=
 =?utf-8?B?L0RWaDNGdXpFQ0ZCWWVyVVZPTExiY2xyUmxPWDZqOUtkTC9SVzkrdURPUnZK?=
 =?utf-8?B?S0d4ZUFKa25JWjV3OW5kc2VXbHcyYTNkMk5WVVlDVzlFdS9vNWNNWmxhM05u?=
 =?utf-8?B?T2FKbldHR3hqSi9reElpOENteTBzd1VKZGwzOTNlelZNVENsQU9pZ1Uyemcx?=
 =?utf-8?B?R21XNVdEY2VJQU5IRm91c09MVUsraGpVK091Qjc1N0J2OWt5SWdydFpxdWNp?=
 =?utf-8?Q?k/Eg=3D?=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4673.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38a7871a-7e40-4602-dbc1-08dd5384300c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2025 21:02:16.3172
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EIBM+30TXPdzLMbL/h9T9cx1LaVrjf9oZ3stJ+a2Sv3MMjdIVOLcWn/EuhssGzmgmjc6ypbY33YCSGCthhA+Sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB4799
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: yHkL4kk697YJS14f5qDU1msVRaeI383R
X-Proofpoint-GUID: yHkL4kk697YJS14f5qDU1msVRaeI383R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-22_09,2025-02-20_02,2024-11-22_01



> -----Original Message-----
> From: Krzysztof Kozlowski <krzk@kernel.org>
> Sent: Friday, February 21, 2025 12:47 AM
> To: Wilson Ding <dingwei@marvell.com>
> Cc: linux-kernel@vger.kernel.org; devicetree@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; andrew@lunn.ch; gregory.clement@bootlin.com;
> sebastian.hesselbarth@gmail.com; robh@kernel.org; krzk+dt@kernel.org;
> conor+dt@kernel.org; p.zabel@pengutronix.de; Sanghoon Lee
> <salee@marvell.com>; Geethasowjanya Akula <gakula@marvell.com>
> Subject: [EXTERNAL] Re: [PATCH v2 2/4] dt-bindings: cp110: Document the
> reset controller
>=20
> On Thu, Feb 20, 2025 at 03:=E2=80=8A25:=E2=80=8A25PM -0800, Wilson Ding w=
rote: > Add reset-
> controller sub-node into the system controller node, and > document the
> supported reset lines. > > Signed-off-by: Wilson Ding
> <dingwei@=E2=80=8Amarvell.=E2=80=8Acom> >=20
> On Thu, Feb 20, 2025 at 03:25:25PM -0800, Wilson Ding wrote:
> > Add reset-controller sub-node into the system controller node, and
> > document the supported reset lines.
> >
> > Signed-off-by: Wilson Ding <dingwei@marvell.com>
> > ---
> >  .../arm/marvell/cp110-system-controller.txt   | 43 +++++++++++++++++++
>=20
> NAK.
>=20
> You already got feedback that TXT bindings are not accepted.
>=20

I am not trying to use this TXT for dt-binding. But as you can see this file
describes all the sub-nodes details, such as mpps, clocks information. So
that I add the reset line info here. If this is not the right place, where =
shall
I put this information. I wonder if you are asking to convert this txt into
yaml.

> Best regards,
> Krzysztof


