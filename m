Return-Path: <linux-kernel+bounces-306265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE45A963C40
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 09:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 763D6286182
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 07:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E7A16C873;
	Thu, 29 Aug 2024 07:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="fbslkAxh"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2106.outbound.protection.outlook.com [40.107.255.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA02CA50;
	Thu, 29 Aug 2024 07:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724915360; cv=fail; b=gad7Be/0D4Dp9OogsHqtYqrOE8HkjxKKdoxwifVVwiBeTn45ByBe7utp91Ep6Hz7P+xm4IsW0Q6a3p8vaSaCyjwJfb07X6Kb3Ao0Rx3quifYEzxXg96asgqUSK/wWhsrqUpmv1b10J8tiIvAgyzblXgMmP6eFcrEIA3UDkQfm7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724915360; c=relaxed/simple;
	bh=Cm/j9coUrFG3UlrDd8iwdF2dpwPhWrb4GLzJDZWju5E=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DJAeRPA3g6fDEDtAWK5YSZN1kJQ6rpnb5pT+H4DNpRB10pkVmSS6jU9fDBNJlWB7b3/MHqhM63xpAXWwhUnHfy5hRGzNVIFAC4yTE0OyseUJsoYTUWIzzi0FnaAxtc3p5gYw5dmJ3jV0n3SOQJGG4xsrsON0gBqBBN76/TtqNLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=fbslkAxh; arc=fail smtp.client-ip=40.107.255.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N3WtkmXoKlHqXxvMLkZxq5AeUXat+G/7wmKt20Kh+GEHuGdFEA5aHyKvMc45x/psU6ZESadFKOw5408MxqzVWjcbPAXtFO+l5iaEY3kKMvq+N5uf5jCY6RhEaq09EAY0chznQK7IaWUUh/8omA/zWsVhJlEcJt4n7AR8JPfZLCi/u8cNX9+M/v42+OrHgI8kPli/xAUwJ3XpF8rx3MnL0G+Hp8SHgrnpQWW2HL0oj7L0TkcwtUh+OcjWorPKXNKa8ZvQP8r43bF01THSjnQoBxZLn5TuHq3zBynFI6AJNCOImiPrfVbbAmHn9sNrYXXmZs5hgz9oxGeJf52TE5BhpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cm/j9coUrFG3UlrDd8iwdF2dpwPhWrb4GLzJDZWju5E=;
 b=u8xPJsiiZx2oW2c2rGWPVlzRbjrj2Ug2ut6rOyUuonVdBLdRF/2M0Sss9NQt1NqYTEbFjwAUTV4cU+4bE8gFkzq3+WgEexsmtkqHpYfFZo3NyLSnnUiGw+TsUOYdLI+/L5R8zQnm2bUa8eeEq1pshRZglK06JPRRDnp5iqskxD2unEfRAvzPd6WgZqAgq51GpUnNgw2EtNY9QiENMTL4mmtvPi9yKGwAQmu+dxCsf4Iooh4ev7VfpifpZJGzagaiUFtdrbSJTJmWQMyixvA73/M4ihPX0bHy1Z5rapHatR/isuscx9c6UGHapARqvV0GQCv6TaiZXgVDm89YJZpRkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cm/j9coUrFG3UlrDd8iwdF2dpwPhWrb4GLzJDZWju5E=;
 b=fbslkAxhroVNzycquAyCI4lmL79bYsQPU4BWAjcpiZbrEim9TAqFaZCNN5p6buweannKXMvhw6C/vgdpI1IJVp7d7yeFJATQN5oE9j1p6Wz1/8x77dOhoWWnwtcZo+lnxJLX3TqoahbaZbqtGVmRV7MTQK1KDPzf86EyCa3eoytSFDEMwjx2bJqN0+xlCptsjTyugLuNytSadKYVunTC9GlBeYpFHhO6PLKkS4r4SrEEj42755SBFTXoMIh0xqJ2TQmVGR3hC/8ywGSOWfDE1At3119/M78mZMZv3jaAtPw/uyGrYaNZJGe1mFb8+XGp/Dfc0IabK8QI/lt/7xDZLA==
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com (2603:1096:604:2b1::11)
 by TY0PR06MB5847.apcprd06.prod.outlook.com (2603:1096:400:276::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Thu, 29 Aug
 2024 07:09:12 +0000
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11]) by OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11%4]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 07:09:12 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Stephen Boyd <sboyd@kernel.org>, "andrew@codeconstruct.com.au"
	<andrew@codeconstruct.com.au>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "joel@jms.id.au"
	<joel@jms.id.au>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "mturquette@baylibre.com"
	<mturquette@baylibre.com>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"robh@kernel.org" <robh@kernel.org>
Subject: RE: [PATCH v2 3/3] clk: aspeed: add AST2700 clk driver
Thread-Topic: [PATCH v2 3/3] clk: aspeed: add AST2700 clk driver
Thread-Index: AQHa+RNp/f6Zl0wHLUuBnq05ailKU7I9A24AgABp7FA=
Date: Thu, 29 Aug 2024 07:09:12 +0000
Message-ID:
 <OS8PR06MB7541F12972412AE565A93287F2962@OS8PR06MB7541.apcprd06.prod.outlook.com>
References: <20240828062740.1614744-1-ryan_chen@aspeedtech.com>
 <20240828062740.1614744-4-ryan_chen@aspeedtech.com>
 <61c8234139fcd2b27610ef18e9d9fbf7.sboyd@kernel.org>
In-Reply-To: <61c8234139fcd2b27610ef18e9d9fbf7.sboyd@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS8PR06MB7541:EE_|TY0PR06MB5847:EE_
x-ms-office365-filtering-correlation-id: 2803905c-8bb9-494b-9533-08dcc7f97c28
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Lzg1ZnJjZDlPQ3lVRGgybDd6N2lIci95UmZ3a0dRWEdjc1JvdEphRGJJV3dj?=
 =?utf-8?B?QUNVMk1UV1I3cy9RTCs1dHZSUTl0WEF0c2MybTFMQ2IzL1pWeHdSZzBWUUFj?=
 =?utf-8?B?Y3FnWGt6NmcyZk82OGJOK0ZaU0VzZGpOeVZnMWx3d2dTbjA1QUIwU1dCazFB?=
 =?utf-8?B?eU5yOUR3aWo3YUFwOUdacDlrZnlJMGsrMjBHSXZxWGJHQXpOYldmbVVUbHNZ?=
 =?utf-8?B?T0doTjdXb0NmWmtRN3lDOU5HTXNPUmFIaUxud3RzUnVyM1EvS1ZiRUxqQ3ZC?=
 =?utf-8?B?TGQ2aGtxQUsxWnc1VnFkRzd2TlFVbDZsSDFxc3g0N09wbHhKQnloZkZFbUtt?=
 =?utf-8?B?c3NjaFlUbGdIUG1VUWE1R2FPUDVPeCtNZzZSQnZlTGE0cFA3eDJLcSs5cUJR?=
 =?utf-8?B?TUx0aUN5bVpESlM2SWlEWnpBUDZuU2ozZ1l0cmFpdWlwU21aOU16WFFCS0R0?=
 =?utf-8?B?QlFza2dzNDh6SzhhSDR0S0FFM0lNdkJSQmFmdUM2SlMxSk5wUVMvMDRCVlVF?=
 =?utf-8?B?ZHkrd0FTaThYTDlQM0dOS3hEWVd4Y05iNDV2WHdkTWJqZHZzOTZqbS9KTWFU?=
 =?utf-8?B?ZkxOK2Q1Z01tZkJBUzAzdG5hMFNoSDFGSmNvSGFBQ3B0akhLMzllZWFpVDh2?=
 =?utf-8?B?YlQra2w5dGwvZW5mTmszTDhXZ215UVJyeFFqRG5xR2taYURudFEvaHpNQUhF?=
 =?utf-8?B?aFBMdVFUQlRqVk53b3ZsdnhrOTF6ZFJiU0F0VmF4SE93Z01ZeXRxMTZLdzl0?=
 =?utf-8?B?RVlCUmhJb1JSYUNLcEt5L1RoVEV5TTZPMU5IZDQ5eWliVHZSMDQ1bWVlM1Fy?=
 =?utf-8?B?UjlVVWF0ckpIUFhkd1FaOW9NdEtXaWF2UFk4WnBvOUdDNVJtRjI1RWtyanpa?=
 =?utf-8?B?RmM4Y3NnbVNSR1FrZEw3S2hBVnlSRE9mMzd1TGZCTC9CdDdqdm9TQnFieTNz?=
 =?utf-8?B?RzV1THNqY2NhNk1KNUZXRkJzdk9hTFJhSXp6cmZid1BrMFlpczN3RmIxK3Fr?=
 =?utf-8?B?cDZoYTNHTjV6UHVFL24vK2wzNkt2cGpVZGZ3QXdhNjRoN2krblJCR0pkLzk5?=
 =?utf-8?B?OHNvalgwV0YrYTUyUnBtSEFnVzdlcnBDZmhEa2JwVStITGtQcUREK0szbGRC?=
 =?utf-8?B?WVFpMUpGNGI0U2I5bzR2Zmd4ZVFFMno3TGdvb3JvYzloZTE2UFRkZE4yVkJp?=
 =?utf-8?B?RkoxR011U2xXbEt1Z2EwK1libkR0M2NMdUFOenZRUU9EdzJYeENobUk0Zm43?=
 =?utf-8?B?V09OWHYvOVVpbFNYb2lWeGhHZTFxbDV6WUNVL2JSSjZpV1NCSDh4MCthbFdL?=
 =?utf-8?B?cUN0MEpnT2Znd0Z1dExRckFlbW1rL1cvMkJMT2l6aVh0YisyQ0VoZ1JJMlJk?=
 =?utf-8?B?M25nT2lpeGg1TmF2eTRObWp0WWRQQnAxNGlnUStNRW8xTHFoYjJuWWpKWHpo?=
 =?utf-8?B?ek13WU9LcHJKRzFSckVvcDBlNHJKZDZNb3Q1QysvWWozYlF2RXMxVlBxR2t2?=
 =?utf-8?B?cUxhUWpneUVMZlFBaW9YYy9zYzBGZTA4VVJYakJ2Z0Jjb0ViQ2hYai8zdjJy?=
 =?utf-8?B?Sm5seHdWaHdQSFJoRExOMkt5N2JtVFNpdmF0bzRGVXpHZXdoRlFEblFTK3Js?=
 =?utf-8?B?V1NtWHVGdkFMZlBkaUFHOExYUi9UVkdTRE8vZGRnTHdHNDdQeGNZTS9IUWky?=
 =?utf-8?B?OWdWZXFOSk45VmFZTnAwd2hSWUlaMUNNZXplTWhvSmhHR2ZsZTluYzZnNFJP?=
 =?utf-8?B?MWFNN1BHRjdFdERPYkdRRDhqQ0xsUVhobDlQVCtkRGVTaXJVVnBxQXNxNUtP?=
 =?utf-8?B?SmxQdERRQzZxRFNJNys1RXNIdjFzNGdkTU14OTNjdWp2ZSs0VlpWc0FLQWhu?=
 =?utf-8?B?RU4vNnhKbm1kbmpnQTN3T2NMcTFqcTdHN0ZZWEFGL2k0aVFtTC9KZmlHaFNJ?=
 =?utf-8?Q?00wic6lSZQk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS8PR06MB7541.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NUMrSHVBNGw3TUhSTnBTUVpxaUNOS0VMQWI0S01rUG12eHNWQm0yTmNkU3M2?=
 =?utf-8?B?bjdyUEpobUNsaWFUVStVSjBSRzNzY1VGdVdpeWhpSjJWUS9NWUFIQ2l5SExx?=
 =?utf-8?B?TFRTOStpeVVKYngwMmgrenFXM3RSa3hkajN1UVdqT2lYK242dU1HQm1iS29u?=
 =?utf-8?B?Y0hSRVpsSkNvdGxkWHVZbEJTOEhRRWg3MGEzY0Noa3RmOXZ1eVc5L3Jna2F0?=
 =?utf-8?B?S0JKRnY4R1hIZTMwcmxxcU43TGxCMVFIZmNTbmx2b1lSQllieGNaMG9hY3RU?=
 =?utf-8?B?SktsWWRhcXJ3czFoSlErQldJb3VsTnA5RDZGQ0tvaHFjL1l0WFo3aVFRTnhV?=
 =?utf-8?B?Qzc4L1czRGZqbndYWWo0dzhIRDZIcWNIWkwyNzErMndnQ3dGaFJiTG8zSFBa?=
 =?utf-8?B?ck42QmtxOXVVZ2l0Szc2Q2c0NGFoWTlteEFZeU5Jcm1LTGc0NDBYOVNaNmE3?=
 =?utf-8?B?aWU1N1hyRXRyTjFJK1lkd0NGOXU2NEcvSC9EMHZoM2N0NCthdnduK0ZKMjdE?=
 =?utf-8?B?WDAxRDE3K2wxSVRZOE9wQzhybGVtOVY4KzJzRFFyditWMVdFRGE4Q1B0Mms4?=
 =?utf-8?B?QkFtS3BkZldtN0FCL3BCNWo5TTMwQWFualI5ZGtad0JFOUdNM3pRbnc1QWNW?=
 =?utf-8?B?Y2g4UW4ydGIwRkNONWx5VFRTOW4vWmtkQlV3TlNkWkFqakF1dCtVM3p2YzFN?=
 =?utf-8?B?cVVjeGtZT0lITEJSZkNqT1R3elV2VmgzVTFiYmJrcVdJbTUzNXhZaDhGVXFa?=
 =?utf-8?B?SlFoT1hXdFp6c3NtNkFvbEZTWUhvMjEyeGtWK1NaMEkzZGhaeFliaWg4TEJU?=
 =?utf-8?B?KytEcmJHQTlUdVZtKzB2clo5dXdxd3hyNFltZWNaZ3RFVld6U08rRzRDYWRa?=
 =?utf-8?B?VlVHMWN0Y0E0VnBqOVozNmg4NThFcmxZUWV4cW9QSy84RzFKZzAyUTFKWTYw?=
 =?utf-8?B?UzVQYzhpakxtSUFmbmhoekZZanFmb3N1YnlYemZWakR2L0p4ZkMwZ08wQ0VN?=
 =?utf-8?B?eFRsTmJ5SUJHa1hhNFNDMUlLRmQxL1NySjBzY0NCcXRDdnI3alBNNUtkcnA3?=
 =?utf-8?B?T3dYRXdwNG91bE00VlIwdHNFTjh2YVpwb1Bud3RGY3BmL2w5L2hadkZHNGRE?=
 =?utf-8?B?dEFoQUw0d042Yk5BQXVHbDZKdUEzMkJjSFUyV05ucFhQTURWY2tGa1h0WmRx?=
 =?utf-8?B?TkllVDdjTFB6Z1FnYkVrQUZjRG5XVVloSlVpa0FXZllBLzhFSysrNEpsQjIy?=
 =?utf-8?B?VUFXcHJ3eEJlMFR3THpFc28yRFFEWE0vNk9Pbi9nOW0vUmI5bUVRZTBYTVg1?=
 =?utf-8?B?V1RXOGI4MFMzajYyb1dzazdhbzRoUHNjSmZKbnVqMFFmTHEvOTJFMmc0OXUv?=
 =?utf-8?B?bEd0R1QyMEhrRWErOUt1c3ZmSkNDemEySzBlakdKM1NNNjdYSGpibTg5ZTN6?=
 =?utf-8?B?Z1RPekt1Q3FOU0lUUGtzT0ZQWHhQWEh2Nm9pQ2pqRHhvR2N3QWU0UlNQam5P?=
 =?utf-8?B?dGc1YzRUdlBsTkZSZzNOdUNGOGl2MWVQWnlUVTRGc3Y4QzN4NWNlNFp2OCtp?=
 =?utf-8?B?NFUxaGFHWUh2R0dBNVIrdmpNM0s0alZCcUh0OGtjODhaMEI3TnFXU1ZLaXZx?=
 =?utf-8?B?cnZzR2doblRFUlhoc0l6RjQ2OUorWXoyblJiNVVGSjlhSFQ0ZnJaMENoUEtG?=
 =?utf-8?B?Z2oyV0xtVmduWEZGbXVBWnRCOTN0QmNSMkpuWnV1NkZtTkprRGx5YTRuZkVk?=
 =?utf-8?B?ZGdxMFRMd1pRcGw1ZTBGZDMrTWE0YlFBMFdJeXVmcmlpOXdjTzNzK04yaDFU?=
 =?utf-8?B?V2VGU2JWVnF6cGxtcDRXMHlBWTYrWEVUdE5nbUY2S0ZpL3hnbTFTaDQvZkk4?=
 =?utf-8?B?YnYwSDUvZjFTb3pQVzlPMnBldFhGZytyRjBWeXpFMWM5T3dCaklCZjh1ekh2?=
 =?utf-8?B?SHZBRmhJcUhQZ2dNcnR1M1FGKytoR0cyM1Bmd0s0QjN6UUI5Y0JIenhabFoz?=
 =?utf-8?B?aGx0QWF2SHZodFp5WWk1WktuaGZ2c3pjUisza01TWTNlN1lkVUdqWG9BcU9G?=
 =?utf-8?B?Z2NFQ2RRck9iZnlHM0NMb0dqdW9ZYy93cFFvYVh6UzRML3pyNHFXMC8xSGln?=
 =?utf-8?Q?5brvX8fPfOZKjD2hZXmRjjYcF?=
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
X-MS-Exchange-CrossTenant-AuthSource: OS8PR06MB7541.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2803905c-8bb9-494b-9533-08dcc7f97c28
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2024 07:09:12.3292
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ukMawI11qMEBK97wI9kdXmfyfpfP4KfKBZAvI+EAiDrkFZgL6xoNwdYhx4e6iOtngdFC1YHTZRyy/aTTgR6lCwSYWtGOyOyU8cqUNazXZS8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5847

PiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDMvM10gY2xrOiBhc3BlZWQ6IGFkZCBBU1QyNzAwIGNs
ayBkcml2ZXINCj4gDQo+IFF1b3RpbmcgUnlhbiBDaGVuICgyMDI0LTA4LTI3IDIzOjI3OjQwKQ0K
PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Nsay9LY29uZmlnIGIvZHJpdmVycy9jbGsvS2NvbmZp
ZyBpbmRleA0KPiA+IDk4M2VmNGYzNmQ4Yy4uODU1YjY1ZjJkNmRkIDEwMDY0NA0KPiA+IC0tLSBh
L2RyaXZlcnMvY2xrL0tjb25maWcNCj4gPiArKysgYi9kcml2ZXJzL2Nsay9LY29uZmlnDQo+ID4g
QEAgLTI2OSw2ICsyNjksMTYgQEAgY29uZmlnIENPTU1PTl9DTEtfQVNQRUVEDQo+ID4gICAgICAg
ICAgIFRoZSBHNCBhbmQgRzUgc2VyaWVzLCBpbmNsdWRpbmcgdGhlIGFzdDI0MDAgYW5kIGFzdDI1
MDAsIGFyZQ0KPiBzdXBwb3J0ZWQNCj4gPiAgICAgICAgICAgYnkgdGhpcyBkcml2ZXIuDQo+ID4N
Cj4gPiArY29uZmlnIENPTU1PTl9DTEtfQVNUMjcwMA0KPiA+ICsgICAgICAgYm9vbCAiQ2xvY2sg
ZHJpdmVyIGZvciBBU1QyNzAwIFNvQyINCj4gPiArICAgICAgIGRlcGVuZHMgb24gQVJDSF9BU1BF
RUQgfHwgQ09NUElMRV9URVNUDQo+ID4gKyAgICAgICBzZWxlY3QgTUZEX1NZU0NPTg0KPiANCj4g
V2h5IGlzIHRoaXMgYSBzeXNjb24/DQpJIHdpbGwgcmVtb3ZlIGl0LiANCj4gDQo+ID4gKyAgICAg
ICBzZWxlY3QgUkVTRVRfQ09OVFJPTExFUg0KPiA+ICsgICAgICAgaGVscA0KPiA+ICsgICAgICAg
ICBUaGlzIGRyaXZlciBwcm92aWRlcyBzdXBwb3J0IGZvciBjbG9jayBvbiBBU1QyNzAwIFNvQy4N
Cj4gPiArICAgICAgICAgVGhpcyBkcml2ZXIgaXMgcmVzcG9uc2libGUgZm9yIG1hbmFnaW5nIHRo
ZSB2YXJpb3VzIGNsb2Nrcw0KPiByZXF1aXJlZA0KPiA+ICsgICAgICAgICBieSB0aGUgcGVyaXBo
ZXJhbHMgYW5kIGNvcmVzIHdpdGhpbiB0aGUgQVNUMjcwMC4NCj4gPiArDQo+ID4gIGNvbmZpZyBD
T01NT05fQ0xLX1MyTVBTMTENCj4gPiAgICAgICAgIHRyaXN0YXRlICJDbG9jayBkcml2ZXIgZm9y
IFMyTVBTMVgvUzVNODc2NyBNRkQiDQo+ID4gICAgICAgICBkZXBlbmRzIG9uIE1GRF9TRUNfQ09S
RSB8fCBDT01QSUxFX1RFU1QgZGlmZiAtLWdpdA0KPiA+IGEvZHJpdmVycy9jbGsvY2xrLWFzdDI3
MDAuYyBiL2RyaXZlcnMvY2xrL2Nsay1hc3QyNzAwLmMgbmV3IGZpbGUgbW9kZQ0KPiA+IDEwMDY0
NCBpbmRleCAwMDAwMDAwMDAwMDAuLjdlMDQ2NmU3Mzk4MA0KPiA+IC0tLSAvZGV2L251bGwNCj4g
PiArKysgYi9kcml2ZXJzL2Nsay9jbGstYXN0MjcwMC5jDQo+ID4gQEAgLTAsMCArMSwxMTk4IEBA
DQo+ID4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wDQo+ID4gKy8qDQo+ID4g
KyAqIENvcHlyaWdodCAoYykgMjAyNCBBU1BFRUQgVGVjaG5vbG9neSBJbmMuDQo+ID4gKyAqIEF1
dGhvcjogUnlhbiBDaGVuIDxyeWFuX2NoZW5AYXNwZWVkdGVjaC5jb20+ICAqLw0KPiA+ICsNCj4g
PiArI2luY2x1ZGUgPGxpbnV4L2JpdHMuaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L2Nsay1wcm92
aWRlci5oPg0KPiBbLi4uXQ0KPiA+ICsNCj4gPiArc3RydWN0IGFzdDI3MDBfcmVzZXQgew0KPiA+
ICsgICAgICAgdm9pZCBfX2lvbWVtICpiYXNlOw0KPiA+ICsgICAgICAgc3RydWN0IGFzdDI3MDBf
cmVzZXRfc2lnbmFsIGNvbnN0ICpzaWduYWw7DQo+ID4gKyAgICAgICBzdHJ1Y3QgcmVzZXRfY29u
dHJvbGxlcl9kZXYgcmNkZXY7IH07DQo+IA0KPiBQbGVhc2UgbW92ZSB0aGUgcmVzZXQgY29udHJv
bGxlciB0byB0aGUgZHJpdmVycy9yZXNldCBkaXJlY3RvcnkgYnkgbWVhbnMgb2YNCj4gdXNpbmcg
YW4gYXV4aWxpYXJ5IGRldmljZS4gVGhlcmUgYXJlIHNvbWUgZXhpc3RpbmcgZXhhbXBsZXMgaW4g
dGhlcmUgaWYgeW91DQo+IGdyZXAgZm9yIGF1eGlsaWFyeV9kZXZpY2UgaW4gZHJpdmVycy9yZXNl
dCB0byBoZWxwIGd1aWRlLg0KDQpEbyB5b3UgbWVhbiB0byBoYXZlIGFub3RoZXIgcmVzZXQgY29u
dHJvbGxlciBkcml2ZXI/DQpJZiB5ZXMsIEkgbWF5IG5lZWQgc3lzY29uIGZvciByZW1hcCB0d28g
ZHJpdmVycy4NCj4gDQo+ID4gKw0KPiA+ICsjZGVmaW5lIHRvX3JjX2RhdGEocCkgY29udGFpbmVy
X29mKHAsIHN0cnVjdCBhc3QyNzAwX3Jlc2V0LCByY2RldikNCj4gPiArDQo+IFsuLi5dDQo+ID4g
Kw0KPiA+ICtzdGF0aWMgaW50IGFzdDI3MDBfc29jMF9jbGtfaW5pdChzdHJ1Y3QgZGV2aWNlX25v
ZGUgKnNvYzBfbm9kZSkgew0KPiA+ICsgICAgICAgc3RydWN0IGNsa19od19vbmVjZWxsX2RhdGEg
KmNsa19kYXRhOw0KPiA+ICsgICAgICAgdm9pZCBfX2lvbWVtICpjbGtfYmFzZTsNCj4gWy4uLl0N
Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAwLCBjbGtf
YmFzZSArDQo+IFNDVTBfQ0xLX1NUT1AsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgMjgsIDAsDQo+ID4gKyAmYXN0MjcwMF9jbGtfbG9jayk7DQo+ID4g
Kw0KPiA+ICsgICAgICAgb2ZfY2xrX2FkZF9od19wcm92aWRlcihzb2MwX25vZGUsIG9mX2Nsa19o
d19vbmVjZWxsX2dldCwNCj4gPiArIGNsa19kYXRhKTsNCj4gPiArDQo+ID4gKyAgICAgICByZXR1
cm4gMDsNCj4gPiArfTsNCj4gPiArDQo+ID4gK0NMS19PRl9ERUNMQVJFX0RSSVZFUihhc3QyNzAw
X3NvYzAsICJhc3BlZWQsYXN0MjcwMC1zY3UwIiwNCj4gPiArYXN0MjcwMF9zb2MwX2Nsa19pbml0
KTsgQ0xLX09GX0RFQ0xBUkVfRFJJVkVSKGFzdDI3MDBfc29jMSwNCj4gPiArImFzcGVlZCxhc3Qy
NzAwLXNjdTEiLCBhc3QyNzAwX3NvYzFfY2xrX2luaXQpOw0KPiANCj4gV2h5IGNhbid0IHRoaXMg
YmUgYSBwbGF0Zm9ybSBkcml2ZXI/DQpEdWUgdG8gY2xrIGFuZCByZXNldCB3aWxsIGJlIHRoZSBm
aXJzdCBkcml2ZXIgaW4gY29yZS4NCkRvIHlvdSB0aGluayBhbGwgZHJpdmVycyBzaG91bGQgYmUg
cGxhdGZvcm0gZHJpdmVyPw0K

