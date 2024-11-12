Return-Path: <linux-kernel+bounces-405187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7840D9C4E0C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 06:06:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE5F21F24EE5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 05:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954B120896E;
	Tue, 12 Nov 2024 05:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="VLKaJNrg"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2119.outbound.protection.outlook.com [40.107.20.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BF11990AB;
	Tue, 12 Nov 2024 05:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731387949; cv=fail; b=canOOOXW12mnjv4177aCFiuyXqfGlqcAE+yvkfyuyvdA67+xgY6QFGjVOWj9Y45a1j0OnoJsoqAJDJBPh7WPH5PNA7fTk9Xhh42nB3R/xHw2m6qrEu/2w5Po3gZyU/cv1W5ptXg/AYgTgOejz3MRlijI0BIKW887jss8TEfJAD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731387949; c=relaxed/simple;
	bh=+vRMMl9S9OoeXY5cSQl//CdQK48zp/LHfCd3zxAXlxE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EhkKhIZjPzLtXGufMMklLPJgtCuRqyKWxs9nFp1eGCSRO6jF6wgeSUJ3rKAbdOFbp40sZrllXEeZXC8PWYboKNirBr6+viIbfSjTs6ET5L9gd+LFlK9RhjnL5VHZxP8096sqNuiHfADFeIK6xGoFQNWX1cEe7qpD3rWNP7ibmLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=VLKaJNrg; arc=fail smtp.client-ip=40.107.20.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MeH9+kXxgYeVQ9+dnio3GiiepMQdZ2iY8RNDtah4opW51mSEG1vASOU6VYnU3b2EZkx5XELGgHCI+msVDTR1bBEa/HxfnAVBBRr+nL0i/op6gXPX7Z931lateFc7E3rcedKBGTk7QUAfp4HLYT/2xdKDGDpbyAW/mSTDo0XgrgsXXoQUHgoUZlFKGPY3AQN2EMntkJUddnPlKFa9VBpTJIVrUDWYvuTwKJ/x4UFcYKOJeZUIASBQNCTkek+yO188pYwp+ehqjSaBqvLgT+uMjKdE2YH58UCz7rh11diHkaAmxBpWrl2iX3mi0AagxlAS4MQCz+Bexs2b+Jy5SL3V8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+vRMMl9S9OoeXY5cSQl//CdQK48zp/LHfCd3zxAXlxE=;
 b=gOEM4VSNEipfyGXBXf20FfxuCFqOkFqf8rGP1CX7Gnj/8NPXafdg0NK37LztZS8NyVxH+xMeVjbS9cA5UWEuUh/fHP04vqpocLmA2hwGWnh1SUM4cx7/U5T51VQ6RIPFGFRcxSK9zFJjD/NQJjGSBc5CxQDCRSRyrJV8J2no8ryzcx16n8Z0IbUQA4GWAt4dXBqgkbQTVxy+Fie9E0zsJzCi9DjO0nb3lJL1hklKxi78UMqpRlbtcElnBFtwu2dlCa5olZKO1F8EMTC6pMxNkE1Kt+XDQjeALWuTq04iDiWHk1YHYI2DCLPal6C6t+x3aWR1Ynkgx3HFTwH4K+NYgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+vRMMl9S9OoeXY5cSQl//CdQK48zp/LHfCd3zxAXlxE=;
 b=VLKaJNrg1sDRdm3epYpuYb+2pLytCVSQLZWva171v1f1pUHhof8VlJh5Hv/S30sNY2GhcWWhZQWHDoxjMustLlnc11vo9dh6y8NnnJcRW4F8GwUHF1OVjO+5Zq0v1r7Jz8qzoCXHjKsvVt9vHEDpEZrtRhb85ETbxEvrxlG37B0=
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by GVXPR04MB10898.eurprd04.prod.outlook.com (2603:10a6:150:214::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Tue, 12 Nov
 2024 05:05:42 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%4]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 05:05:42 +0000
From: Josua Mayer <josua@solid-run.com>
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>
CC: Geert Uytterhoeven <geert@linux-m68k.org>, Vignesh Raghavendra
	<vigneshr@ti.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: ti: k3-am642-hummingboard-t: convert overlay
 to board dts
Thread-Topic: [PATCH] arm64: dts: ti: k3-am642-hummingboard-t: convert overlay
 to board dts
Thread-Index: AQHbLGBE4Oj6TeCKV0+veZ0PVk2MEbKzKEoA
Date: Tue, 12 Nov 2024 05:05:42 +0000
Message-ID: <32c1f44c-6bc7-4722-9f73-743ea15cdcbd@solid-run.com>
References: <20241101-am64-hb-fix-overlay-v1-1-080b98b057b6@solid-run.com>
In-Reply-To: <20241101-am64-hb-fix-overlay-v1-1-080b98b057b6@solid-run.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB7586:EE_|GVXPR04MB10898:EE_
x-ms-office365-filtering-correlation-id: e235eb5e-0185-4d3b-c833-08dd02d7a884
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?YnlOa3hpMjU3VEx5WHlFb3E5NXJyaW5ocGpyeDIxNm9nYkFmYjNxOWR0ZEFu?=
 =?utf-8?B?eTRzVHRWRlgxT2l5YWNNcC9jVkFGR0EzenFINlJUTW9WMU52amE3SEdBR3NQ?=
 =?utf-8?B?R0UyaW85Z0pFTlkwS1Fac3dGRWYrSHJwOTdBTnBNc2FZYlVqeUJudFZCY25B?=
 =?utf-8?B?L1dYWXowQ0s0ckc1TGxyUSsvL3JLUnZ5QVhpaHdGYWluMWJBZkw2bzBySktY?=
 =?utf-8?B?UUhvSzBuSi9JWjVLYjZTbVlGRGNRdTgzT2ltRFRyZlRoMzZxMHV2NFdmdERi?=
 =?utf-8?B?YlVXK1o2RHNVUGtKb0NQeGc1UFF4UTNGSG8vcVk5RVRKWmUyWXVKd28rRGZ6?=
 =?utf-8?B?NVpCOG9BTCtWOWhhN2pkZ1JZMElISGprMTBWemxWZ0VhYUhkSVQ4aS9Dc2FZ?=
 =?utf-8?B?cit2RFVRYXhMdWV0Vi82SW16OUNKT3dnMUNCalhUTGVxOG9aK25vUWd0eThZ?=
 =?utf-8?B?UUo3QTFOdmlYcEJxaFNHTGtYYW5JMlBKZG1ZR3ZqMEN3U1VOdWIvUkNDT25I?=
 =?utf-8?B?ZkliQWxvMlJGMzdnQUR4c01tMHZqeWYzS3FwS0JaM3R3eWhKZThlUHNvUER5?=
 =?utf-8?B?NDVrci9SZDVVRW5ZcU9EazRwdy9oYmhodE1acG5IaFYyTnZURDN6a3U2RHZp?=
 =?utf-8?B?Y3daR1BPeTd5cklPa3F5Y0JQQ29tcUN4Z3hLNWFERldrcTU0WTdyVW84SnlD?=
 =?utf-8?B?c2M0RmI1emRuVys4M2ROUVY5aVNNUkJJcktGVTlTVmhIbFlobzZEeUI5NUJy?=
 =?utf-8?B?elVPUm5JTEdSL1RBNmg4N3FpajlWUHJ5Skxvd1FOSkNrVzFoelVVUXZIV05R?=
 =?utf-8?B?OWdXcGxDUCtUejJlNzdxNlY5NjhQRksxKy9qZFp2SEtZSjEyTFZQOWk3Q05w?=
 =?utf-8?B?SGl3a3drRnpncXBzVmRqMUNaQnRHSGxaQTlrOGlLVTIvK2VFNTcweXRPTDQ2?=
 =?utf-8?B?TGh1Q2tzN1l6Q1NpM1lrTmpCOXc4dnBjcjlqYnJEdWpOc3AxSVRGU0ZKOHlN?=
 =?utf-8?B?emg0UitxaFlBcisxcXBEenVrd3V2aFBLNW1oN2M2SFRna21qOFJERG1tU29t?=
 =?utf-8?B?WTVKSmFnb0o1YWlFUE4rZlluQXVLeHhKbkNoU21lZmppTEV6b2d1ZWtnSGwy?=
 =?utf-8?B?S29MK2l4ZGdyTWc2WmZJY2xDSGJhaDJlTzZiaWY1dEYwMDl6cnVlS280M3hQ?=
 =?utf-8?B?dU01M2NWY0lRdUNJUENSQ2lUVExTc1RSVjNMYXJlU3RsaUxUNzNibUp5ZWQ3?=
 =?utf-8?B?RFVBTkR1a3ZydjJDaUt4TWtQSUp2NFkvbmxsTlNnVDlqNDNTbW5rRC9JbDZz?=
 =?utf-8?B?bkMvWlNXajJNY3doR3hrZjNGR2Fla1NTYjJKNWt0WFVIRTN1dmRGRlhPc2ll?=
 =?utf-8?B?a20vZDhsaFYyN2tlKzlrZk5sYWdSUG41dm83OUJ1dDdNK2VCdFYxTVhlbzNZ?=
 =?utf-8?B?L0VZSU1icWdSM0huQXdDaUxtZEpvTXpRL041M0xnanZRcHN6cDR0T29FMVpO?=
 =?utf-8?B?N0lOd1R3WDFvdHdrNEhWQXpWNlZmWkZxOTNuRnphamlrVFhSUk1WWStqdFNi?=
 =?utf-8?B?R2NpUnlvL29PWXdISE5heW83SkkzdTk5aGlJWFFuVlRmenorQml2czhTeDNV?=
 =?utf-8?B?ejNha1M4ekQ3V28xTUxCQzV2QzAyeGh3RTlxRlU1b3RUSG5RT2tVbHlXV1hz?=
 =?utf-8?B?RnJ4bDd0NXJvTjh1eDJ4V241YWsxQWh3SGpZaElyM0lOUUh3NFZKblk4a0Q2?=
 =?utf-8?B?ekhxTHVwMUhPWWI4VTJsWndleVFJTG5qK3p4NWMyQm84T0M1QllPZEkxQ0hs?=
 =?utf-8?B?QWlZMXNic2pOYnI0RFcrK2ovN2d3UTN0T1JGa1dlSUpvYTI5QnRnQm56dXFt?=
 =?utf-8?Q?BZpODIZ0cjFWT?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QjBENHNoRTJqVjhJa3luZHhIdmxUL3FHd1dhT3B3bUQybGtZa05oZ3lMZUY3?=
 =?utf-8?B?dGVJY2REdTBKczBFeC82YWoyZjV2Y3NaeVV4R0gzamRYMUZ2SEN6WVZRTzcr?=
 =?utf-8?B?WHRBdktGQ01CTnRRb3Q5b2ZURlFTdWluTW9YN1hmb25SdUdvVE11U0RYdGR2?=
 =?utf-8?B?RHNxeHE1d2Fnb3NjWkgzV3JvTnJyVXpONmQzSmUrTEM4YXhxTXpqb0w3ckRJ?=
 =?utf-8?B?bEJHcElWdmZ3a3BuR0k4TWYyUHBoV1VFL0dldE95czAxOFp0RnB1NGwyeXhz?=
 =?utf-8?B?L2t1VnRZalhKWW5EenRPdzdOQzUvZlU5TitPZHZMOCsybHRpNVAwdEw5V0xV?=
 =?utf-8?B?RjV2REZZTi9UdE5RQUZ0YmYyMXBiaHNIR2k5VkFLQ29ua3FwVER3TlBPUFlW?=
 =?utf-8?B?cGdBdDBBNTdPMnd4Sm80djczMk1DQnVXMUFHNlcyRkZsZ0hxNWMzb0VuaGpv?=
 =?utf-8?B?T01pQlJ4RnUvYytoWWJaazZIaDA4K3hkN2ZBNjZKQjVDU29uS2NabW1JbVRC?=
 =?utf-8?B?WU9UZExEMjF5ZWp1U3hHL1Bpbm9aOHQ2TkszUEJFYkxQaWp0NHdyR2JsL1FB?=
 =?utf-8?B?REQyeXJNSXJ6cWtCNWRQZkpocDFzTFovUUdLVWRXcGVXZWhrZWJjQkhjR3pO?=
 =?utf-8?B?UjhvMEVtbWg0NGs5dU5DSjYra0QyT0hQTWxDcGh3dEFydy83VDdNNVczNUhp?=
 =?utf-8?B?dUp4LzJtbHA0SmZhZjlHVkJTb0x3emFBZWppdm9BN0k4bFhwMzR5VGFPcWZ1?=
 =?utf-8?B?WGRmakJHeXpjNGUzUldIcEZ0RTNTL2p4Z3JyRTZIT0hBcG1XL05zRlN3UG9r?=
 =?utf-8?B?NWVxTmJua1J4bHpLK0RIMlhZZnFHYXc1SFZLcUNsOXpWRGFaUEhlc04yZ0xR?=
 =?utf-8?B?dStzRWo1ek44Q3U5Vy9qZ3RVREh5TUJRYngxUStySTM3QTIvM3pvd1lNRVVG?=
 =?utf-8?B?d1c2YmFCTTBIWnZGdGtyZGN2VFI4aEpHaTdEU1VaWU1LREV1U0NJM3NWbDc5?=
 =?utf-8?B?MWpUWW5UY3lyd2lZcFRNZkxwSEJTS2hEenlvL040NGdST2RwZmxMOFpablNC?=
 =?utf-8?B?R1VqSmFEQnZHai9HQytKQ09yTHZLd1ozTG1GL3hyNS82SGNXbDRpaTNqeTlp?=
 =?utf-8?B?dFZWZU9adWw1aW1xMW1rdlQ0NnVhTkppdlptRUtJR2FRTHViRDZLKzErcVVE?=
 =?utf-8?B?WEgzZTlCLzVOL1psRkZGWXRXbGZhMHVreEtjUFduSitQUEtCaGQyMHBvb2hR?=
 =?utf-8?B?Qit6Ri85UWNpb0dteTd3WFF6aHBQYVVGUjJIeitqRm1Ud1JZN1JjZzVYeFdh?=
 =?utf-8?B?ZUE1cTVNVCtTKzlMSGw0Um4rYzREZU40cURpTURqRUdNckZ4eVlIajY4Q3Ry?=
 =?utf-8?B?QTRzem16NldtTWZpMDFHRlFCbU1Qa0ZqaWNzQVA1UnVCRm15aEN3YjhXWEFQ?=
 =?utf-8?B?U1ZWYjhnMjEvSW50TGRlV2JRV1VmeXRhcWM4YVNtclZNVnZuK3lCL04rY1JT?=
 =?utf-8?B?S0JDbEUxWCs3aDNTY2lSWVdGMkdYdGZ1dm9KZEErQjFoc3hKb0tMZTl6TURj?=
 =?utf-8?B?MmVEM3VRRVo4c2FpS0lNL01FNmFudi9BM3E5azhhQU5OOWNzSTZDTys4cjdN?=
 =?utf-8?B?c0xCQ1ZDRUkyd2djZTZnUjc5ZjQzTlVtb2ZwMmEwMnN3bEVMUEhoT2RuZ2pR?=
 =?utf-8?B?aVNoY2RZMHNQOGlIL25NSUFPTkVNWEQ0bElDMnJoMkh4aDkxZnVTSUJZZkww?=
 =?utf-8?B?bkJTRCtKOVJlaVptU1lKOElPaGx4Ny96dy96OXp1aW9jMzdNRTdubEhuNE1U?=
 =?utf-8?B?REhkQzFGMVB2VlpGRkl2cFJlTFd4eTJYbkorSEg5Y0g0eTlHQkcvc3N0ZlNK?=
 =?utf-8?B?THdwWDdma2szTVpyUnpqRUtFTWVjem1mSWNnTHBxenBiTytzK1NWa0xSS1ZX?=
 =?utf-8?B?NlJkUmdaS3VMVDdybE5nWUFSdDNucTFUSnVXclJNWTcxV0YxQ2w2dG5sdzJX?=
 =?utf-8?B?WVlud3NBVGdKeWtia1BZaitSYnNGbnI4c25WaDZMZXpJMng3ZFMwb3RKUmd1?=
 =?utf-8?B?M041ZUZmZ1lRakFoWjVYYjJZWWZyeWw4b1dSdVRNandML0dMZjJkRHR0N2px?=
 =?utf-8?Q?DnbfQSqOmDzpcbLp8H/V8bjkR?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C97B316487896641BB6B22E8A9E216D5@eurprd04.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e235eb5e-0185-4d3b-c833-08dd02d7a884
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2024 05:05:42.4340
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vME5ziBgWobz6MSLPb3iYqHlyqXTiMoig0ETy+3h3h76bQcXvrElLv421qqyck6e5xdeS/AnZsoYp5c9uEt84A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10898

QW0gMDEuMTEuMjQgdW0gMTU6MTYgc2NocmllYiBKb3N1YSBNYXllcjoNCj4gU29saWRSdW4gSHVt
bWluZ0JvYXJkLVQgaGFzIHR3byBvcHRpb25zIGZvciBNLjIgY29ubmVjdG9yLCBzdXBwb3J0aW5n
DQo+IGVpdGhlciBQQ0ktRSBvciBVU0ItMy4xIEdlbiAxIC0gZGVwZW5kaW5nIG9uIGNvbmZpZ3Vy
YXRpb24gb2YgYSBtdXgNCj4gb24gdGhlIHNlcmRlcyBsYW5lLg0KPiBUaGUgcmVxdWlyZWQgY29u
ZmlndXJhdGlvbnMgaW4gZGV2aWNlLXRyZWUgd2VyZSBtb2RlbGVkIGFzIG92ZXJsYXlzLg0KPg0K
PiBUaGUgVVNCLTMuMSBvdmVybGF5IHVzZXMgL2RlbGV0ZS1wcm9wZXJ0eS8gdG8gdW5zZXQgYSBi
b29sZWFuIHByb3BlcnR5DQo+IG9uIHRoZSB1c2IgY29udHJvbGxlciBsaW1pdGluZyBpdCB0byBV
U0ItMi4wIGJ5IGRlZmF1bHQuDQo+IE92ZXJsYXlzIGNhbiBub3QgZGVsZXRlIGEgcHJvcGVydHkg
ZnJvbSB0aGUgYmFzZSBkdGIsIHRoZXJlZm9yZSB0aGlzDQo+IG92ZXJsYXkgaXMgYXQgdGhpcyB0
aW1lIHVzZWxlc3MuDQo+DQo+IENvbnZlcnQgYm90aCBvdmVybGF5cyBpbnRvIGZ1bGwgZHRzIGJ5
IGluY2x1ZGluZyB0aGUgYmFzZSBib2FyZCBkdHMuDQo+IFdoaWxlIHRoZSBwY2llIG92ZXJsYXkg
d2FzIGZ1bmN0aW9uYWwsIGJvdGggYXJlIGNvbnZlcnRlZCBmb3IgYQ0KPiBjb25zaXN0ZW50IHVz
ZXIgZXhwZXJpZW5jZSB3aGVuIHNlbGVjdGluZyBiZXR3ZWVuIHRoZSB0d28gbXV0dWFsbHkNCj4g
ZXhjbHVzaXZlIGNvbmZpZ3VyYXRpb25zLg0KPg0KPiBSZXBvcnRlZC1ieTogR2VlcnQgVXl0dGVy
aG9ldmVuIDxnZWVydEBsaW51eC1tNjhrLm9yZz4NCj4gQ2xvc2VzOiBodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9saW51eC1kZXZpY2V0cmVlL0NBTXVITWRYVGdwVG5KOVU3ZWdDMlhqRlhYTlo1dWlZ
MU8rV3hOZDZMUEpXNVJzNUtUd0BtYWlsLmdtYWlsLmNvbQ0KPiBGaXhlczogYmJlZjQyMDg0Y2Mx
ICgiYXJtNjQ6IGR0czogdGk6IGh1bW1pbmdib2FyZC10OiBhZGQgb3ZlcmxheXMgZm9yIG0uMiBw
Y2ktZSBhbmQgdXNiLTMiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBKb3N1YSBNYXllciA8am9zdWFAc29s
aWQtcnVuLmNvbT4NCj4gLS0tDQo+ICAgYXJjaC9hcm02NC9ib290L2R0cy90aS9NYWtlZmlsZSAg
ICAgICAgICAgICAgICAgICAgICAgICAgICB8ICA0IC0tLS0NCj4gICAuLi5nYm9hcmQtdC1wY2ll
LmR0c28gPT4gazMtYW02NDItaHVtbWluZ2JvYXJkLXQtcGNpZS5kdHN9IHwgMTQgKysrKysrKyst
LS0tLS0NCj4gICAuLi5nYm9hcmQtdC11c2IzLmR0c28gPT4gazMtYW02NDItaHVtbWluZ2JvYXJk
LXQtdXNiMy5kdHN9IHwgMTMgKysrKysrKystLS0tLQ0KPiAgIDMgZmlsZXMgY2hhbmdlZCwgMTYg
aW5zZXJ0aW9ucygrKSwgMTUgZGVsZXRpb25zKC0pDQo+DQpQbGVhc2UgaG9sZCBvZmYgb24gdGhp
cyBwYXRjaCBmb3IgdGhlIG1vbWVudCwNClRoYW5rcyB0byBzb21lIGNvbW1lbnRzIGZyb20gR2Vl
cnQgSSB3aXNoIHRvIHN1Ym1pdCBhbiBhbHRlcm5hdGl2ZQ0Kc29sdXRpb24gdmlhIHNlcGFyYXRl
IHBhdGNoLXNldCwgZm9yIGZ1cnRoZXIgZGlzY3Vzc2lvbi4NCg==

