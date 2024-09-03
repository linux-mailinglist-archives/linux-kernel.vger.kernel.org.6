Return-Path: <linux-kernel+bounces-312559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C719969831
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 11:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7A58285F63
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 09:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE1019F10D;
	Tue,  3 Sep 2024 09:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="K4EQf848"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6615F1C7677;
	Tue,  3 Sep 2024 09:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725354179; cv=fail; b=sQAhwXdi6srbtwOozjokSFLxUPJBCTpnYbznLcGBl717vMXdWASPHuhiPCoACWDtkZO/v0H9RDn4DaIyDAWo9tMGmBlJe9Rc6JkEvSCAG+eMTnoCdMmKnfoNbFIEVt487b39T+8cFxEOf9IK12sjOnnTyC6Qxi3xhBa/Rlyp9ao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725354179; c=relaxed/simple;
	bh=moc52Jnnk9oJqZcYFUhxMWNDZ5xYreC1FCasDD+ACNQ=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Gki32ZXo4gB7KxzIduOBWu0fJ452vT9fUU4vkndN5kdCnsxrXf4u+ynke3CkROou4azLmytW8ug1JEp4tzsV1HPC3A/DyHB1iL1HkUhGB9jUPPqYAItVWnvwJqhxKr2xab0f2Iks/KkgEcMzx86H2BEPA7R/9hAClgxEdSGmB+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=K4EQf848; arc=fail smtp.client-ip=40.107.244.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fi6vWR1nzFYjIUG6QwGBNTHFXGTpwPcFqxMqlaaGoXhQvcj0I5MOddMhLb8z2Slht3qu32AdA4BQ21qz9R7GShiT3lgKaRKYRpaVSiQGXihRLHaVeS943OEevmwJb31YpylsKeVE/4Omw2k82qLedhKapaEsnzQPHD2ytpJb1YyWUR45uN+R5gdAKV5dR5FNPuMbqXR44LJLtHUoxZ4RxSuOXWZH8I3VwINUJwoOroJn5ni9kiSRGgQ6G6CYwjRvD1T2YYnZkiKAowX6LD4pefUG8hXo+EVmFpMetYsHjpvAQLiGPrm5EY9WlnzW1ORoOekOIVPano5dUKPXjiv3uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=moc52Jnnk9oJqZcYFUhxMWNDZ5xYreC1FCasDD+ACNQ=;
 b=MJEPMK1YWF6LWaCInAuVrXjNikVJKsJ2HwAtLNiXOlpD7UqPY7FNC3zziWHS816rIzdShRWmxdS02qN8lvZxl0Y0pM0WgAQRQpplY09edb/uwjAV0x+75mw66RbZxPFQ1REzf6Xrm0ZRIoJmncVs+u7kPs2YRN61C36YrhVYwYUHLbYbSAFc2gXUsK21TUVmLM/JntIfYxwYhP8UQYJsIws8swq9WZrJjya9V6anP6HMMlNgjGozM/KOfRb+hClJLph58S32UVx8YbxSSVQXT2OFyujjCeTxPFbp5LZnng6Iaz/sBWNEnmE4ajPKJMvgXIrPBRdtBlPLNsvykjBdsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=moc52Jnnk9oJqZcYFUhxMWNDZ5xYreC1FCasDD+ACNQ=;
 b=K4EQf848oXoARA1PrU6Q+OSxx4itQ6JCx60y/m3LnI/KS4XZjVbaLHKo5csWLpheLiwXrf44h95RlEoL0lGdWYPGbPANR8VDpjggIl5fMG1moGYHOaCoMdgzL2saQVc5unjG2KXDg1UeT18sufAmhw9YsOVP+CDVR6at6DMgSRrStoqdYLdO9qz2Fntx4cRsAQYEsBQWiTnMp5hKGHhbc+IoVFgK1ggr9VGGPKbG5PLX1KmYYpRU4MQuelIJoMQk8gkPO6vsmrGBu6v0fUGXRAm1k7B3Q52zOOgvQ/EhsqLC/ZKOwYqLqEdIAFC0bYmMma6YCcIPysy6t6NFNcadWQ==
Received: from PH7PR11MB6451.namprd11.prod.outlook.com (2603:10b6:510:1f4::16)
 by SN7PR11MB7092.namprd11.prod.outlook.com (2603:10b6:806:29b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Tue, 3 Sep
 2024 09:02:54 +0000
Received: from PH7PR11MB6451.namprd11.prod.outlook.com
 ([fe80::80a8:f388:d92e:41f8]) by PH7PR11MB6451.namprd11.prod.outlook.com
 ([fe80::80a8:f388:d92e:41f8%6]) with mapi id 15.20.7918.024; Tue, 3 Sep 2024
 09:02:54 +0000
From: <Dharma.B@microchip.com>
To: <Varshini.Rajendran@microchip.com>, <tglx@linutronix.de>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v7 03/12] dt-bindings: interrupt-controller: Add support
 for sam9x7 aic
Thread-Topic: [PATCH v7 03/12] dt-bindings: interrupt-controller: Add support
 for sam9x7 aic
Thread-Index: AQHa/cyB57+7Gy/cDEiR8njStl3xkLJFxIWA
Date: Tue, 3 Sep 2024 09:02:54 +0000
Message-ID: <44d176c6-eaf2-493b-9fba-81f5bd9dac82@microchip.com>
References: <20240903063913.48307-1-varshini.rajendran@microchip.com>
 <20240903064240.49415-1-varshini.rajendran@microchip.com>
In-Reply-To: <20240903064240.49415-1-varshini.rajendran@microchip.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6451:EE_|SN7PR11MB7092:EE_
x-ms-office365-filtering-correlation-id: a821342a-9ec9-4b16-cf20-08dccbf732b0
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6451.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?UWx3TUUrK2dQa0NOcTM4SGpoS2JvMUJVcGdPSHl4OUc3a1V2N1F4d0liTXJp?=
 =?utf-8?B?czZjMVlUelpjc3pNVE9zVXNJWVVDYlREc1JnZlY4SEx1RHZHYTl1OERMV1kw?=
 =?utf-8?B?THZpOEVSYmNKQVZMVzhGY0FuZHg5elRhSVc1akJYMjBxREZnUWpMQ05Vb2Ew?=
 =?utf-8?B?cDNPVXEwV2N3QXhxandPRG9wY1JDMkR1b244NWdpUjR2Q29YSUp1MER5WTBK?=
 =?utf-8?B?OXdHYUFuZmpkeUNJVHlWdDh4Q1VaVHdUT3EzUGVxZnB6RzJFc0pSbUJvVGJr?=
 =?utf-8?B?OGxPRmg0MGxJWUsyTTNML0RCaWhnU3I5RERpREdndndmWmJaTXpXQlFxcmR6?=
 =?utf-8?B?SHFQYVlBcTNoOTdSTlM2R0wzcGFIM0ovL1Y0RkVvUUJaU1YrcjhIcnJkaTZl?=
 =?utf-8?B?SGc4TFFFaTgveGdoNGlId2dBbnRDL0pQREo5SGxuOEJRWjAxaXFhd3NXU204?=
 =?utf-8?B?RHJZY3ZDeUwzR3NRbmswa3hpSXMwK0R3Ly9UWXBiOXJLSEdQTDhDRXZkaXht?=
 =?utf-8?B?b2U4bmFZemtLQ3l0MTJoWjJSS3JxcTdGN29SZ2lsTzJUQnI0Z2NFbmJDT2pR?=
 =?utf-8?B?ZjhiYlljb2lKRnRjb2VvdG5xeTh0bHVtc1lZNFRVRHlvQ29hbnBBaWdSNmdH?=
 =?utf-8?B?REE1c1c1L0NWYkdFWFhJZitzV1VTUkF5YlN1SWxnNmt2ZVZlQ2loSjNDb1Vy?=
 =?utf-8?B?d2VFendBSFRUdHNmM3h3OVM0RFZUV3ZZZHpoQnoxOHREOEE2V1E2YlpnMmVl?=
 =?utf-8?B?dVdXNmE0UkdNYTlCRjhHQkFkWEdubnJQOFgrK050Y0NxZXJxOG55aXFiUmN6?=
 =?utf-8?B?L09rNWdWeEpPdWtTZC83RGo0ZUJtbW1pQ3BQTWpwZVExR1pYNlZtUGJDbXdx?=
 =?utf-8?B?OGR1UWJZa09McXpOR1FtQTErc1NidlIzbUdyMFovSTZKV2svREtsdm13TC83?=
 =?utf-8?B?WU9WOWRVdXNid0pLWXNJc2Q1VnB1eStxdHYraFluSDRWKzYvMlc4dU5jK3pF?=
 =?utf-8?B?M09zcERCeU9hdzNSZXc1dWs5Qnd5eVcrS0ZDZGMzcXhsdGZzcE5XREU3MXpo?=
 =?utf-8?B?UjgraXZrbUxFOUU3QjVSQXdxQjVLQXN5VVRJWkxoZ1lqQTRDMUtrSE1yODBZ?=
 =?utf-8?B?Ni9ObCtoODltRFVNWHF5MFJrZEhFaVlFR0FVTW1VLytSRG5aekpLc0VoUmc5?=
 =?utf-8?B?ZUF2Ym4yVG13TVdQTElETXFqczduZFkwZ3FHbGJpd1FZNjVqSlpqVUdDeWdk?=
 =?utf-8?B?RlR3MGRSU0hOblJqbHJ4TklaRG8yS0xaTFFJa0NOOFo1eVBtaWlFVnJIUWtL?=
 =?utf-8?B?dTBOU3lLYlp6Sll0M3lxcWI3T3I3dm5EM0wzQVVNQ28wT1diK1c4cHhWaFJ1?=
 =?utf-8?B?WHZsTVFrQWJ3aHhUU0xLS2VWUTl6YllQTXR1U1l4Nm8yWVRaTEZhd1JWMlVV?=
 =?utf-8?B?bDhEazdrL0VFanoxaFUxaGVzL2ZSemlxakExUSttSWRPNEk1elZ6Q2RHanE1?=
 =?utf-8?B?NG5PYUxLajVxNEl5VDFGWmJvcWdEZG9CT0ZMN25OenhGcWI3K3ZGOWk5NGp5?=
 =?utf-8?B?SUpLS2VQUTlOYnhlQlZZQkc0OFVoeGVQZ3ZuWG90Q0FOQUd5eXkwNXlkUlZB?=
 =?utf-8?B?c3EzYU5tOENrNkRuNkdNQjgvVVIxYkcxemM3cTNVSExOUzlHeFBRcVFNZkJK?=
 =?utf-8?B?djFRYVRTNXFBdVdCbFVLWW9mZkJLQVE1azk5aWNuZlVRTGYwVy8rb2ZTYXFG?=
 =?utf-8?B?eFYwMjVreExGY1JXWlpmRTBiRHFLc0o4VUErTEs1Qk1ZWHoxei85aGMzbzdF?=
 =?utf-8?B?VVVtaENSaGJXb3pvVTZhK3c2cVVjbCs3M200VGViTXRpT2NaTWJwYVpXbzh3?=
 =?utf-8?B?dzdhMFJyVUFRUU92bjVnUVBELzNOTUIvOUd6RnRRdFJ2MnZWeUdMc2NIMzQ4?=
 =?utf-8?Q?heSBsSluCl4=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bkJBV2FmMWsrRVdMOXFzK24rZXNLSkJqalRxemhjdjhTOWM5emhaUFRjOGRl?=
 =?utf-8?B?RE9mQzJZYTM0MmJGR28vNWlWakJWeSt0Y29DYWpYM3k3Wlh5d3RzQnFxWXU4?=
 =?utf-8?B?RFpYdG84UFFoTVgweC96TURaSDlhUnptL2ZLd3IyM3VEZndIZGJLZHhpQ3dM?=
 =?utf-8?B?dEN6WEs3Sm03OU04UDJabnNyK2Jld3VYQ0lvU280V2xoeUpXRmk3ZVZyUHZu?=
 =?utf-8?B?dUU0RG43aU80bkxxdHo1TVFQbkY5dVVjY2x2RGw1SVc2dUNhMno1ejVsT0hu?=
 =?utf-8?B?aFg0TVlpN1pNd1hSdVRGVStQU2x5RlU1NlJGRzFqUmRqTFBXc1g5OVVSVGw5?=
 =?utf-8?B?Q1NsVU0zMHRwanoxc3ZpTGFCNFZKcGYrbStrV20ray82L2Fld0RRaXJ0Q2wy?=
 =?utf-8?B?aENoaE5mVG5UQ2FuMFVaMnhhU21wemRvcVk3YS85NndIRTQ5aWp3UG9XRC9N?=
 =?utf-8?B?aC9vMDJLcHZtT25DbzIycnI5enQxTTgveXpuWjhVTTNsR1dmNE5wSjEzQkFS?=
 =?utf-8?B?MjVJdVVmM2F0bURXNktUdU9oNzk4U3djUzRVL2xXaytLRTNlQUtrWk5CZ2dK?=
 =?utf-8?B?SFBzOHoxMWVhazRMOVRZN3BuSnlIQXorY1lnTjRhT1lxV1p2SWlrME5WVjJW?=
 =?utf-8?B?UVVVWUNoRmlrSlVjcE1peGtDeUtReUsvN3RHM2N3aGNjeGo4ZlJwS1Ivd3d4?=
 =?utf-8?B?Z2N4TU1YY1c4bmoyZzhlaDRHM1RXRy8yQWxiWTZBQW02ZitZZzRUZ21QMEpY?=
 =?utf-8?B?UkF2OUFYN2JWR3MxdWp6NEd2ZFNjTGVpbUJKT0E0VEJ0TzVLTzlYZ1c4WGJE?=
 =?utf-8?B?T3Y0QlJXUFZIYStIU3BpWDJ5bWUrd3VWVE16UnFIQjRpR3dZbW00RkxyUmVh?=
 =?utf-8?B?NGNVUFJWR0p5VUUxS25aK0REUUpqSVpncWxRUGtKSUJvTE96bVZPNUJKWUtE?=
 =?utf-8?B?N0NXeis3M0orZzk1ZDZIcTBrRk9jMU5lOXhFNHJXNWZwWGJnVDVFK0d1S2Zv?=
 =?utf-8?B?TGV0U3BoV0UxVXF6NGRvNlVFNHowS041V0xaczdOSzVhSkpmblhtRzZuYVV6?=
 =?utf-8?B?b1N2OGFnWWMzQ2dhZW9mUW9RUkM0RGdRQzlwdnZMUFV4K0RveWNUZjV0azE2?=
 =?utf-8?B?NWJHRm5zejJCUGNEelkxUUlIK080M3lWYkZnNzNIVDBHcWREekEyV1RaSHpl?=
 =?utf-8?B?eUN3Sm1RMk1EZkZibkVyR1dRMEczNkdSMmZwelNLQU1RVnNuNTRPcUlhbG91?=
 =?utf-8?B?SEJNczNEUU5hNXFrT3IzZ2xFNVFNaVo3RGZWZjZxVUVlR1RJMU5oc1B5QTRs?=
 =?utf-8?B?NjliWE5UTVkwT1Y1bjRJZ1FyeDczaFVHRzhLL0hLc09hTDRRL25wTFpDUkdX?=
 =?utf-8?B?VUZsUDMvR2lzZTZzTXZ3VW9hbmVzL2lIU1ZhUzhPaVplTktYdVBzR2FOVHVI?=
 =?utf-8?B?K3JMRzBJZ2RIc1BrVy9ycFhhRkhzNHZ0TDBJVFkvaHNaYUw4eW1HR2d3UDln?=
 =?utf-8?B?WjlibmYrODFOVGh1MEpmcjlGYlliWCs1dUd0eFNJYWgycnQzZEtndU9YUmhH?=
 =?utf-8?B?eUVDcXQ5YmsrSm1FSnM2RERsc3QrZTBjYzJvR3BDckdob0JzTzdHSm8zYWx3?=
 =?utf-8?B?aXhTdm9QTUtYZ05tNzZRdGhFc0RVTlZEVXFtbmFUb3VTYitzaU1yUEllcytu?=
 =?utf-8?B?dmJNSlJ3ZzdzWnBZN0ptU0NlZURvNTFpMVQ5cmxTbUZPOXVxUkJYRVQ2VE1h?=
 =?utf-8?B?ZkJUWlBiWWNESm1ORG1Sb2dOb1RVdWNMT2ZLWmJPcURDMHFLbVgzQVFkWjlj?=
 =?utf-8?B?M0E1RUc4S08vczJBVFZHeDFEckRRSld5bXc1a1psYlZHZ1dMRkJiNnVZTFYv?=
 =?utf-8?B?WWhnUVNBNWhzUGFHTFNZS0JySWdnNEppbDdvNE9PaEIwV08zM3Vqb0ZyTWd0?=
 =?utf-8?B?Y3ltNkRTSHBNTmVodDgydlo1NmY2czlmQzZDemR0aC9kRDRDK0h2c3VJOC9m?=
 =?utf-8?B?aTVoZWt5bmUwSzFyZnc0d1MvWWZLY3JEKzBiQjd5aXRHdW1zRDFhVGtVS0RX?=
 =?utf-8?B?M1VDY0lTY2VjOUtmaTFLWGhuTGQ4Nmd4c1JTRisxT0xHWUxQa1N4MS9JcDhZ?=
 =?utf-8?Q?rrcizi6QnYftFQu9/u6ya7xT4?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <136CE1F6D9BFFE44B02FB2C42763911F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6451.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a821342a-9ec9-4b16-cf20-08dccbf732b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2024 09:02:54.7376
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AxlnhoSptj5fd7w0QVYZPHj+ccOlqhkwAlGSZwsq/fAlwdHpiv4zYpeygnH4do9bGaeGJRZYp6DxzDGmTyRSYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7092

T24gMDMvMDkvMjQgMTI6MTIgcG0sIFZhcnNoaW5pIFJhamVuZHJhbiB3cm90ZToNCj4gRG9jdW1l
bnQgdGhlIHN1cHBvcnQgYWRkZWQgZm9yIHRoZSBBZHZhbmNlZCBpbnRlcnJ1cHQgY29udHJvbGxl
cihBSUMpDQo+IGNoaXAgaW4gdGhlIHNhbTl4NyBTb0MgZmFtaWx5LiBOZXcgY29tcGF0aWJsZSBp
cyBpbnRyb2R1Y2VkIHRvIGNhcHR1cmUNCj4gdGhlIGRpZmZlcmVuY2VzIGxpa2UgdGhlIG51bWJl
ciBvZiBpbnRlcnJ1cHRzIHN1cHBvcnRlZCBpbiB0aGUNCj4gaW50ZWdyYXRpb24gb2YgdGhlIElQ
IHRvIHRoYXQgb2YgdGhlIHByZXZpb3VzIGRlc2lnbnMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBW
YXJzaGluaSBSYWplbmRyYW4gPHZhcnNoaW5pLnJhamVuZHJhbkBtaWNyb2NoaXAuY29tPg0KVGhl
IGRyaXZlciBhbmQgZHRzIGNoYW5nZXMgaW4gdGhpcyBwYXRjaCBzZXJpZXMgbG9va3MgZ29vZCB0
byBtZS4NCg0KQWNrZWQtYnk6RGhhcm1hIEJhbGFzdWJpcmFtYW5pIDxkaGFybWEuYkBtaWNyb2No
aXAuY29tPg0KPiAtLS0NCj4gQ2hhbmdlcyBpbiB2NzoNCj4gDQo+IC0gRWxhYm9yYXRlZCB0aGUg
Y29tbWl0IG1lc3NhZ2UgYnkgZXhwbGFpbmluZyB0aGUgZGlmZmVyZW5jZSBpbiBJUC4NCj4gLS0t
DQo+ICAgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvaW50ZXJydXB0LWNvbnRyb2xsZXIvYXRtZWws
YWljLnlhbWwgICAgICB8IDEgKw0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9pbnRl
cnJ1cHQtY29udHJvbGxlci9hdG1lbCxhaWMueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9pbnRlcnJ1cHQtY29udHJvbGxlci9hdG1lbCxhaWMueWFtbA0KPiBpbmRleCBk
NDY1OGZlMzg2N2MuLmQ2NzFlZDg4NGM5ZSAxMDA2NDQNCj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL2ludGVycnVwdC1jb250cm9sbGVyL2F0bWVsLGFpYy55YW1sDQo+
ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9pbnRlcnJ1cHQtY29udHJv
bGxlci9hdG1lbCxhaWMueWFtbA0KPiBAQCAtMjMsNiArMjMsNyBAQCBwcm9wZXJ0aWVzOg0KPiAg
ICAgICAgIC0gYXRtZWwsc2FtYTVkMy1haWMNCj4gICAgICAgICAtIGF0bWVsLHNhbWE1ZDQtYWlj
DQo+ICAgICAgICAgLSBtaWNyb2NoaXAsc2FtOXg2MC1haWMNCj4gKyAgICAgIC0gbWljcm9jaGlw
LHNhbTl4Ny1haWMNCj4gICANCj4gICAgIHJlZzoNCj4gICAgICAgbWF4SXRlbXM6IDENCg0KDQot
LSANCldpdGggQmVzdCBSZWdhcmRzLA0KRGhhcm1hIEIuDQo=

