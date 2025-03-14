Return-Path: <linux-kernel+bounces-561265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F11A60F73
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E5213BD47C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B808D1FCFF3;
	Fri, 14 Mar 2025 10:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="YvzIlFNQ"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2133.outbound.protection.outlook.com [40.107.255.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DB11FCFD4;
	Fri, 14 Mar 2025 10:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741949820; cv=fail; b=nJQ+tWJK7tbBpgOf5t6q+mG+6dmh+J1TJKXmtaCPf2JBeMi78D7DJB/40k5QnP7hrJ4oFtfesj4boCKDEtB3P6I05/Nz0Ll76vXk4Z7Jv6udGYkN+GSGdKaXMpRkBf59P+iSRcYsPR1PBG3BHx1YsmzDx11iQX7HnuLnb69MvOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741949820; c=relaxed/simple;
	bh=/9gw8JZ6r6bxlCNOXOJ82nOAAt35FzxfJaRXk+L+j0Y=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lyHbCOvPnBkqSTGp200GzQL3BWm6YERRxjzJFmiNZ2+0+6KzUYqaHHhGZ4kKBNCiGEDinQa0+kTPZkpIT+YQbhgdOGssFI0cbDKE4F22koazCEb48ZyvDn8UB1Wr2rER0bhwUc03mOu6B+pevRVsR9fUHTKoEA4++qfFZV+25nM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=YvzIlFNQ; arc=fail smtp.client-ip=40.107.255.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F1pb7jMjjGroCtVtKxt94ek4U9ObZYJeyAgiax8LANfKH0BcGQDESB+GwtKXp4gcu4JdDHq1wtokhRLG4xPubC2sZMNFSfLF+/RDKkgbZZ+7YPpnPTlx7ebMmwKixqXJxrA7OV5eycaWHFBmjDO7iJ0AWBxQvCgSQAwgmkJKRaYjr3aimuzkGDjOQWsVT/wXFpOmVyzdaZcNzmMJoJkOPyrEAx3QRASBe/MxesqFrYcVwtyI2bijt7fSBhthH/SMxTmGbWfQmIOqq1qzlL0+8aiiKfD1bXKVzUGr7GNh5DDUDpfyZ56v1fLaiV7LhPOydCBZBpDUXdSlds8DWHFRfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/9gw8JZ6r6bxlCNOXOJ82nOAAt35FzxfJaRXk+L+j0Y=;
 b=vYSnBU157GMj+V4ZQMwzpjoYKgyJPk9Onbf4hKWPHcly1nuaKjkIRUpbqVgLhVpBB2f6CedJciEIWdeHzc797ZPs8koo6mo8y/mCUkrStJstIPRWPFXQtoN0aVyBUyIXHbqqDGyhZFQN24uy9JNJD/SllBczbYaiwHvAM0Yxdhgq/kow0Ha1Y5jnhGnG5PIRDK9FQrdFbjm9bJeXvbyXhnlqgk79utrBzwOXWERHCK1T4Dvu+QY+aGQEG+owEczy+NwdzEBieK5D4oOzY16uhdNlCgJOiMIQbI1gN3GBX0cRHYPigKvCGXGmaOkZydyFh3Rn9qFeTmnGf0ytLXcDWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/9gw8JZ6r6bxlCNOXOJ82nOAAt35FzxfJaRXk+L+j0Y=;
 b=YvzIlFNQ2fWNyLQEImw5a1iy0PXJ2EPG/qsynttp+lpmoWLbqge4mEPTQcdcOdLMArqh84+VFadKMz6KafTj/sXZe+i4QtVUJAtFCqQHAAxPg5+P2g/I0gPeZYIXr+HADAETg95djTGdfe/3elJcnpCJ0g42e4DFD0xLPUZYxPvN74Kirot1/3I3IkYt5YHwn4t3zF6p1IqhnPeNybmI1DjU5Fi+G55s5teGAvQj7Ur6UFSBVIObeI0/i26XVvVDfmVKR4OAJ8mHEFa5XKaWlOpjBfR190zNg1Eyy6u5UP6cHNn9sHOk4dd4v2inU7xKqYZmwZTbH0l4hd6+ymx2UQ==
Received: from PSAPR06MB4949.apcprd06.prod.outlook.com (2603:1096:301:ad::9)
 by TYUPR06MB6003.apcprd06.prod.outlook.com (2603:1096:400:352::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Fri, 14 Mar
 2025 10:56:53 +0000
Received: from PSAPR06MB4949.apcprd06.prod.outlook.com
 ([fe80::7bdd:639a:6b94:37bf]) by PSAPR06MB4949.apcprd06.prod.outlook.com
 ([fe80::7bdd:639a:6b94:37bf%4]) with mapi id 15.20.8534.024; Fri, 14 Mar 2025
 10:56:53 +0000
From: Kevin Chen <kevin_chen@aspeedtech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, "lee@kernel.org" <lee@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"joel@jms.id.au" <joel@jms.id.au>, "andrew@codeconstruct.com.au"
	<andrew@codeconstruct.com.au>, "derek.kiernan@amd.com"
	<derek.kiernan@amd.com>, "dragan.cvetic@amd.com" <dragan.cvetic@amd.com>,
	"arnd@arndb.de" <arnd@arndb.de>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 3/3] soc: aspeed: lpc-pcc: Add PCC controller support
Thread-Topic: [PATCH v3 3/3] soc: aspeed: lpc-pcc: Add PCC controller support
Thread-Index: AQHbkbJkvsK+QLqX80Gv9+2qnbu6NLNtjLyAgATsX7A=
Date: Fri, 14 Mar 2025 10:56:53 +0000
Message-ID:
 <PSAPR06MB4949A7F02A7780572DCD87F389D22@PSAPR06MB4949.apcprd06.prod.outlook.com>
References: <20250310114839.3098148-1-kevin_chen@aspeedtech.com>
 <20250310114839.3098148-4-kevin_chen@aspeedtech.com>
 <0e30c12f-5ac5-4008-8cc8-ec4111520655@kernel.org>
In-Reply-To: <0e30c12f-5ac5-4008-8cc8-ec4111520655@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR06MB4949:EE_|TYUPR06MB6003:EE_
x-ms-office365-filtering-correlation-id: 410c3aa8-0850-437f-a840-08dd62e6ee2e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|1800799024|376014|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?WVVIOXlKUGRNUFQyZ25xL3JIZWJjcUN5ZFV5cUhad0ZMM1Z3UVFFbDhPcmNl?=
 =?utf-8?B?N0tnYUhjdEZhYWYxWHAxVHBXdTZVYU1kVy8yT0VaNElPcXNlMXVKY3VhQXZs?=
 =?utf-8?B?d1loalJuSTYyMFJlbG9lNTRaV3dIQ3Q5eXBoYW1YNXJsS3ZwaTRXajV0QVhv?=
 =?utf-8?B?SXdaMnh2ek4xK0dDSThsOXNEeENzYUE3SXl1ckxrZUZhZ0hRY25ERkptemlr?=
 =?utf-8?B?WnVaOU5TeFl6QkVFT2d3bWM5MDN6cTFzSG9LUVJiZmdlSEJpalVlR1pBaUN2?=
 =?utf-8?B?dm83RE1CNHlML3l2TlZVQlZUeUw4SVVJY0txRFdwMjZMdi9HYW42UmJqRG9X?=
 =?utf-8?B?cHJCSVhHVi9Ga2JRV3dtejl6R2QvV2g3ZDhDVmNOZXhJcFpWOWovMmg2a0Rz?=
 =?utf-8?B?SFloZlZlWWVPZWtLeFc3d0lDTFVmQUJINDVyc0c2bDJXYkthenFjTkhXTmVZ?=
 =?utf-8?B?WE5qcHBGb01ZaHVFMUptQVJESDU5dnpoZlpnTW55bXBkVUJLY3JobDR0anlQ?=
 =?utf-8?B?eHZldnI1azhYcUExV1IyRExOd3hHbGJDcUVlbGl5bWVZSVU5TnZUUExPY3ph?=
 =?utf-8?B?US93TjFqRUpZT0RrYStkbjdlVlF5Y3ZWbnExKzJzR0ZyZ0NPaDlOai9HN3ZN?=
 =?utf-8?B?aEsyQXhERUxPbGh2bDY0cnVva0Y4blhIVHFhYTBiRGFzd0JEUEdUaW9IdXg2?=
 =?utf-8?B?RnRoVStIaUdvVy9Ec21Td3Z4TmxoV3Q2OWRXcy9maGRpcmh4OFQ0aUYyc3Na?=
 =?utf-8?B?dURDczNXbmpWdkRjN2p3VmRBL1BqdURXR3R1cGkwSVpsdnJseTR4ZS9MQXZt?=
 =?utf-8?B?Vkl5Ukp4amNVUnRSSW1DaE45R0hJcEdkTmZVUlZkWkljZjl3akZvdEtuVWY3?=
 =?utf-8?B?WlE3RUZvQlBoSjhUVjdKc1AwekR4bEc1ckhtOCt1T0VzZmhRL0VxbEp6MU55?=
 =?utf-8?B?N1I1VnVoWUpjKzEvRFJpSkI3SUYzZFpOMTNRYlFxcTdWUERKV3hjYTA1RDlI?=
 =?utf-8?B?aEorMjl0dmxKUklDVW9nWXlPVGEvQ0hPdkF0L01sd1p6dzVTM0pSQTZaRnRT?=
 =?utf-8?B?Rk44YVorZ3RUd3NZWGNYR2NwU2tLbFRzL3VkRlZnblNGVnkzUktTMnVTQ1A2?=
 =?utf-8?B?eWIxOFpvSmo5ajhSNHZ6ZnphdU9SYVlBdDY3S2JhNitocFY4TkwvVGc0RFly?=
 =?utf-8?B?TjJMK2txM2c4ZGE1ODBldGpISlJ4NFFLSXY4U21ZWGdpaEhrVUlLQkNic1Rq?=
 =?utf-8?B?OUlSYy84dEorUEd3N1c4Q3RJZkNhN2kza0ZVbXVVeE92eHE2b3Y5OVh0UlFi?=
 =?utf-8?B?YUVvSWFSTUhXYUpQVnkyQS96OWhLMnFLdFEwVUtpd09RUmlza05KS1lnMUUx?=
 =?utf-8?B?UE80MTJFUVN0YjBPeVlPVWVyTDYrd0tqZnloRVZnREJyMmd1ciswMGk2WTZO?=
 =?utf-8?B?QVFHYUJINHF4cjJNR2NJdnZScHVUNVpxdlc5Wjl2N3U4TklSRFRSTUxqY3F4?=
 =?utf-8?B?dktBOUVmQkhCL3Z1L05CU3BpU3JFOVlZZ2RJdHFQMm9vb2IvZWc5OTQ1YWtu?=
 =?utf-8?B?WUpvdWdLUC8yc1ZVMm90NksyQjkzSDVnYlRueUFsbUZpK1NURWtRSEMxN04r?=
 =?utf-8?B?cjZDQk5BZmZGQW1xMEYvMVRVY3BscXNZTDg4bWlQMHRvZ1FXN2FvbzNWcytm?=
 =?utf-8?B?UWl6eDh5dXlTNmxlem9FRFdZVnJxR0xVaks2WHgyZjVqWDVrNTZsWHoyazc4?=
 =?utf-8?B?dGg5ZFZEZ0FBWVpicTE4K0tLV3IveXhydkNGTkhGMXpkTkkzdDArNjFxNmZn?=
 =?utf-8?B?akFrS3NwZm02dFJaVk1PbjlqRGJseFJQVGdsaForeXg5MmNMU1NnOStUSEFD?=
 =?utf-8?B?QTZHd0E0RnE3ZHI5ay9jUWg4R1NLcG1Hd0pLNXZmd1hPV3pFYUZLMnc5ajRt?=
 =?utf-8?B?Q3ZGbjczRmhtdFoxSjNCV2NJdmJ5SFIvRXZiTjVMVy9UTHVrOXJYR3cvTG5v?=
 =?utf-8?B?bWtPRnd2WDh3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR06MB4949.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(38070700018)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UEFEc2RPdmVqNitTSWZvam5XT29wTEd3R2NpWDNoKzRQRWxPWnB0OFg0Riti?=
 =?utf-8?B?MEF3cnJJOER5ZDAvb0xWOVFMaVUzbmpkN0xkZDNFaEdVdkpnemxXNlRObmJL?=
 =?utf-8?B?eVZMbTFhck5CUzBqd1dGM1Uwd3l0M1h2aWFUSWpBMVNGdDU4emwzeGMvVnlO?=
 =?utf-8?B?d01MQ2NFaUg1Y2lqSENOKzIzeHZuNlNCSTJKQnQ1b253VTFsaklZeEs3Skp3?=
 =?utf-8?B?Q2h2eWdTR2hzVEl6ZVQxWXduN0RSdlhXSW1NaGhvZTFqaTBydkpNZG1KMy9B?=
 =?utf-8?B?dW1KYU5kYXRFcm80ZGZESVhPQzFESnZmK3hTdEk4QXlXcEx5Y1lRRjFQT0I2?=
 =?utf-8?B?Y2NwSUNESm44VFpZZGIzVUxZcmc1aTFSNVVNZVVZRVBueE90Z3U4dUo1dytZ?=
 =?utf-8?B?V3dTQXNyN0ZUSnN5ZGF1Ly8vbjltWGJPTWs3WnlNMHJ1Q3FjdC9VdnFYNWVl?=
 =?utf-8?B?eHRpSnhOdVpwR0RIcjg4V0x4UlVGN3lKbFVNVTZlL0Z3MytRSUtvdmtkaWx6?=
 =?utf-8?B?bHlET05BUUtQSU1iejFBQmFDUlNYbTNpdUpZTWhwRldNbzY1ZlZSb1JibUtM?=
 =?utf-8?B?MnNQaGRoNm9kQ05pM3hQaFh4TVhhN2IrRklsWXpwVUw5QWV3dE8rbXByQnU1?=
 =?utf-8?B?bVlwVGpyZlU1Q05lOWxPSEZja21LNHl0bGF1RlcvK09jSXZ1cHNobVhBUU5w?=
 =?utf-8?B?NHc4eG9tVUhVcWN3OXVESlJsZlRFeityVDRreHZpSDRnUitYcGdISXNSd0Zs?=
 =?utf-8?B?Ui9hYnNUVGNkcTVDQWV4UnBYZVZBVUVZVmVzTks1YXZibWNLbE1CU1g4UjR4?=
 =?utf-8?B?dFEyMUFrUEhBNzIzNWxISmZDdk5qNkpHNStjMC9NQ0lYYjZ4b0QxVitRVWtB?=
 =?utf-8?B?Y0lsVnY0L1VtZkRhTzA4UDVRQUtVTE83d0JqQkRTek1TWVFIZEkxaEhqMFo3?=
 =?utf-8?B?b1h4R1l4SDFyUEpuWk9lNUFvalp0NHFLZ2hTa09pVER6U1Q0TFBVZlBpbmdX?=
 =?utf-8?B?YVJPQ0ROanN4ay9qbk1UY05ZaE1hZVkrOTVNQWt6N2FTVlBVNTVIQUdzdnpJ?=
 =?utf-8?B?Sjd0cjE2d2szNnF2VlFobUo2bDdNandYZXVwdEdIR2ZwZ0dBVVBjaXZ1Z0ww?=
 =?utf-8?B?blFkVXJIb3FTVnFvTlhpVU5BcDdmVzhiRnU3L2diNzVNZFR4TTJMQ1BaZStn?=
 =?utf-8?B?ZVhUYkNKWm9heHFyTDRHd3Y2cG1RZWlBVVFWTVEzL3VkY09ud0x0OG9KUWpt?=
 =?utf-8?B?NVRXVDRVM0NzWnQyUGhub0JjbksyQjczay9YTW5BZitRK1N5ZXpVRXM1UGFp?=
 =?utf-8?B?YVJMTHFCVHRJRDMzblg5ZmtGdzhYZHhnYmpuWHlkY21aS1hIUW1TNGVIK0g3?=
 =?utf-8?B?L0g2M0ZESnZnMU9CUS9HS0piWWJkVXh6QUN3SGtiL2I0TEJiWis2dWxCdTB1?=
 =?utf-8?B?dUEraTg0NW1nK1g4NURaeFpiVXUxMG5MUXNIUUs2WUFDRFN5RU5jTlFLS1Ay?=
 =?utf-8?B?eTZkSEhDa09IcDZFUHN6ZHl5ZGRCREk0K0lXSUlFSEg4aTkwem83bnljQnU2?=
 =?utf-8?B?czhjcWNRWUpIakNTUUNad21hbVRvSmRTRk1JNzFSSCsxeUZOK0xHclhPWUsy?=
 =?utf-8?B?NGlsbG9LNkpSQkhtVzl6ZTRIT1FyNTRtRlduM3B2eDRnaTFrK09pU1hUSWZ5?=
 =?utf-8?B?RmMxWVJORzg2QnhNb3lqd0FzZkpRNlNJbWJzT2VFU3JMVjRYY0RMYlJneCti?=
 =?utf-8?B?aXc2RHVhT1RHbkRyeEwwZHI2ZVdEVWJVVE9aZklNR00rWmhnY0FSSnZqb1dJ?=
 =?utf-8?B?NGxqM0pUYXc5RlFqRVRHY2F2ME5VN0tzNmZRVWx1LzI4dERZYi91QXEzZUR4?=
 =?utf-8?B?TnIyaVh4THRVQUk3LzhrY3RkNVNDbVdJSDE3RS94YUd4UzY1V2VIQU0zaGps?=
 =?utf-8?B?SUwxWWN0Rm90OGNNZUZ5b0NjTTFHR01SZ2I0M3dWQm12T1dVdDhwWHBvZTVE?=
 =?utf-8?B?Z3p1eGpnNU9qN0JhRWlnZ3pteDY1MWRRMzJIMStyWSs0NllDQ3V4SGJDZERQ?=
 =?utf-8?B?UHNpNGVCejROU1g0NzdudXk5VEVQVkp1U2pBT0ZGSXFtTms5OFcwMWJDQkE1?=
 =?utf-8?Q?lP/dU11e629ObhJ7zJUFdPj7i?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 410c3aa8-0850-437f-a840-08dd62e6ee2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2025 10:56:53.4415
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VW16jJjSycEn93w2yzG68lw6EXuGn99gaGdmLdAKLh7o+41MjOh33hyZznZ/XQc9khV7+KS83WMKTGVZA8dHOX1K1Qq8Ha2+IEy09n4LhoE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6003

PiBPbiAxMC8wMy8yMDI1IDEyOjQ4LCBLZXZpbiBDaGVuIHdyb3RlOg0KPiA+ICtzdGF0aWMgaW50
IGFzcGVlZF9wY2NfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikgew0KPiA+ICsJ
aW50IHJjOw0KPiA+ICsJc3RydWN0IGFzcGVlZF9wY2NfY3RybCAqcGNjOw0KPiA+ICsJc3RydWN0
IGRldmljZSAqZGV2ID0gJnBkZXYtPmRldjsNCj4gPiArCXVpbnQzMl90IGZpZm9fc2l6ZSA9IFBB
R0VfU0laRTsNCj4gPiArDQo+ID4gKwlwY2MgPSBkZXZtX2t6YWxsb2MoZGV2LCBzaXplb2YoKnBj
YyksIEdGUF9LRVJORUwpOw0KPiA+ICsJaWYgKCFwY2MpDQo+ID4gKwkJcmV0dXJuIC1FTk9NRU07
DQo+ID4gKw0KPiA+ICsJcGNjLT5yZWdtYXAgPSBzeXNjb25fbm9kZV90b19yZWdtYXAoZGV2LT5w
YXJlbnQtPm9mX25vZGUpOw0KPiA+ICsJaWYgKElTX0VSUihwY2MtPnJlZ21hcCkpIHsNCj4gPiAr
CQlkZXZfZXJyKGRldiwgIkNvdWxkbid0IGdldCByZWdtYXBcbiIpOw0KPiANCj4gcmV0dXJuIGRl
dl9lcnJfcHJvYmUoKSBpcyBub3Qgc3VpdGFibGU/DQpBZ3JlZS4gQ2hhbmdlIHRvICIgZGV2X2Vy
cl9wcm9iZShkZXYsIFBUUl9FUlIocGNjLT5yZWdtYXApLCJDb3VsZG4ndCBnZXQgcmVnbWFwXG4i
KTsiPw0KDQo+IA0KPiA+ICsJCXJldHVybiAtRU5PREVWOw0KPiANCj4gV2h5IG92ZXJyaWRpbmcg
ZXJyb3IgY29kZT8NCg0KPiANCj4gPiArCX0NCj4gPiArDQo+ID4gKwlyYyA9IG9mX3Byb3BlcnR5
X3JlYWRfdTMyKGRldi0+b2Zfbm9kZSwgInBjYy1wb3J0cyIsICZwY2MtPnBvcnQpOw0KPiA+ICsJ
aWYgKHJjKSB7DQo+ID4gKwkJZGV2X2VycihkZXYsICJubyBwY2MgcG9ydHMgY29uZmlndXJlZFxu
Iik7DQo+ID4gKwkJcmV0dXJuIC1FTk9ERVY7DQo+IA0KPiBXaHkgb3ZlcnJpZGluZyBlcnJvciBj
b2RlPw0KQWdyZWUuDQoNCj4gDQo+IFlvdSBnb3QgdGhpcyBjb21tZW50IGFscmVhZHkgYXQgdjIu
DQpTb3JyeSwgSSBhbHJlYWR5IGNoZWNrZWQgdGhlIGNvbW1lbnQgaW4gdjIuDQoNCj4gDQo+ID4g
Kwl9DQo+ID4gKw0KPiA+ICsJcmMgPSBkbWFfc2V0X21hc2tfYW5kX2NvaGVyZW50KGRldiwgRE1B
X0JJVF9NQVNLKDY0KSk7DQo+ID4gKwlpZiAocmMpIHsNCj4gPiArCQlkZXZfZXJyKGRldiwgImNh
bm5vdCBzZXQgNjQtYml0cyBETUEgbWFza1xuIik7DQo+ID4gKwkJcmV0dXJuIHJjOw0KPiA+ICsJ
fQ0KPiA+ICsNCj4gPiArCXBjYy0+ZG1hLnNpemUgPSBQQ0NfRE1BX0JVRlNaOw0KPiA+ICsJcGNj
LT5kbWEudmlydCA9IGRtYW1fYWxsb2NfY29oZXJlbnQoZGV2LA0KPiA+ICsJCQkJCSAgICBwY2Mt
PmRtYS5zaXplLA0KPiA+ICsJCQkJCSAgICAmcGNjLT5kbWEuYWRkciwNCj4gPiArCQkJCQkgICAg
R0ZQX0tFUk5FTCk7DQo+ID4gKwlpZiAoIXBjYy0+ZG1hLnZpcnQpIHsNCj4gPiArCQlkZXZfZXJy
KGRldiwgImNhbm5vdCBhbGxvY2F0ZSBETUEgYnVmZmVyXG4iKTsNCj4gPiArCQlyZXR1cm4gLUVO
T01FTTsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwlmaWZvX3NpemUgPSByb3VuZHVwKHBjYy0+ZG1h
LnNpemUsIFBBR0VfU0laRSk7DQo+ID4gKwlyYyA9IGtmaWZvX2FsbG9jKCZwY2MtPmZpZm8sIGZp
Zm9fc2l6ZSwgR0ZQX0tFUk5FTCk7DQo+ID4gKwlpZiAocmMpIHsNCj4gDQo+IERyb3Age30NCkFn
cmVlLg0KPiANCj4gPiArCQlyZXR1cm4gLUVOT01FTTsNCj4gPiArCX0NCj4gPiArDQo+IA0KPiBQ
bGVhc2UgcnVuIHNjcmlwdHMvY2hlY2twYXRjaC5wbCBhbmQgZml4IHJlcG9ydGVkIHdhcm5pbmdz
LiBBZnRlciB0aGF0LCBydW4gYWxzbw0KPiBgc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tc3RyaWN0
YCBhbmQgKHByb2JhYmx5KSBmaXggbW9yZSB3YXJuaW5ncy4gU29tZQ0KPiB3YXJuaW5ncyBjYW4g
YmUgaWdub3JlZCwgZXNwZWNpYWxseSBmcm9tIC0tc3RyaWN0IHJ1biwgYnV0IHRoZSBjb2RlIGhl
cmUgbG9va3MNCj4gbGlrZSBpdCBuZWVkcyBhIGZpeC4gRmVlbCBmcmVlIHRvIGdldCBpbiB0b3Vj
aCBpZiB0aGUgd2FybmluZyBpcyBub3QgY2xlYXIuDQpBZ3JlZS4NCg0KPiANCj4gDQo+IA0KPiBC
ZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0K

