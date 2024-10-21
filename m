Return-Path: <linux-kernel+bounces-373963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC9A9A5FE9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 11:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 453491F21B14
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 09:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5151E284E;
	Mon, 21 Oct 2024 09:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="In8W3ZEf"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2053.outbound.protection.outlook.com [40.107.22.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B521E1C0F;
	Mon, 21 Oct 2024 09:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729502695; cv=fail; b=aYt4GVhh6Hj1KpW0u94wHDqaJDUv4xJM2iy8UEW0exfT32ke7b/NUqucF5+QhkTIHEIzwXNEojQvpgiAqaipxY7BzvtW2OQevd+goA6p7GHZRnQvVVpRR1NOalqj4kKu1SvEltL+Mrh6eJcTFw+ffBg5taYgtz9YOh8rRS66StA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729502695; c=relaxed/simple;
	bh=IHuTiTaRMuagTKqUxQQwD/trFjQAR8Cf0FWO8CLB6iE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HLT1R1Q32Xle8icIz9pzhb2dBs+XQUJgWL00Y7IppKkSsJth27YOyT8yLS/SczmR3XSOOMmY5meD/28YA0g7fz2l7HrFmp+a0ZoehQXWvsc41Y7Cuw6fyxPHBfZCtGVn3zlBNM6lbpXMOSONd6qhicODhYYpQ6+0VUTCvKz9Zeg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=In8W3ZEf; arc=fail smtp.client-ip=40.107.22.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qQkEoDg5Zt/6vTzu86V627JTm+8HRKbcLYyXGqtllUTNkgOd3a2gTaBHTt2Eaa0yJrgsQTC51EA4xzlrQ9KZ4ObRbFi7y20xkMCyi9KaNSBzDKncsk8HrExfRebxh9ZNRZ7wPzWHn0r/g/abcWvF5V1OAYoXc7lt+6iRCSue7YyLfYuSWrGmwN0Lc6goPtMdHk8EGDxXhu844tLJ+fYqZWKuyUgxSQocFayW0ERIUxQTImU246zZDjaCRy8W+4nHt/xFTgZ5YHjKFSxveef8vRANffT/LJOUtVR/lbNT7TNBqhH5Uwe2lf4zvVeV9MOQ1ruQyNNxpGK1cqsNeA52bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IHuTiTaRMuagTKqUxQQwD/trFjQAR8Cf0FWO8CLB6iE=;
 b=Ktrterm3W+duVPbXq5xBqpWDkDglmnagjWf5JX/VCBiuxAgqsfveLgDNPgu187MKaHbjo4j7aKifL6GSsJb2HzBsrmNUDxBTm7rQ03AIxA+FTifXLkpPjCw89u+VfxbG82UL8ZzyrzSK2XX6sqP7ccZdKpeSByuPWTejr46ZGzcco2vwrKIZSPRdZic2JCPPy9Gftwks01TropqP6LD8oavvoZ3HPCW+Xm3blJZfRRnWxeTskPIiuiidU7GheQVNRfGESrxiSsCRxP4JjQ6g0vf3N4gkmHq/RELEdlapnZ29VFGwWgqfSe54mXw/+WMoSRYVg1Njpni4HAVv41H8xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IHuTiTaRMuagTKqUxQQwD/trFjQAR8Cf0FWO8CLB6iE=;
 b=In8W3ZEfZ2fNPiL5S896h+lLFwKKqIYCz0R/YNW8BwFm+3JzMprQrZl0C02oQRd77gUlkAt3rg3oYMi8+4hznM43dGXYzTs4O7ZQinoc8zOBpRyENZjltXvqSWyth4+s2AO+4Lss75NZn0MGAWbCt7KERQOm2fiQLuZAdEeqkTsXdOBhQcx6LQsY6Z1tXYy3H6KVSQ3NGEvVDB9PmmeuGBXbEsLIhvv+uJwL5m1y2nSK8uJvgdJu5HdX1zdSQ+jwpS5Z1MV1BtcdBf7mkeOdOi77IRey5Si8UzEL1SZ6PzLnC35S/OCvA3uDMz4VTffkfmFlGTIdfdo499+auPwylw==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DBBPR04MB8042.eurprd04.prod.outlook.com (2603:10a6:10:1e3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 09:24:50 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.8069.016; Mon, 21 Oct 2024
 09:24:49 +0000
From: Peng Fan <peng.fan@nxp.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
	<festevam@gmail.com>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Alexander Stein
	<alexander.stein@ew.tq-group.com>
Subject: RE: [PATCH v3 0/7] arm64: dts: imx95: add various nodes
Thread-Topic: [PATCH v3 0/7] arm64: dts: imx95: add various nodes
Thread-Index: AQHbHJdbH/XW5Nhd50i9RbbAPTMn4rKQ/PYA
Date: Mon, 21 Oct 2024 09:24:49 +0000
Message-ID:
 <PAXPR04MB8459EE0E9E56BE1EB567CD8888432@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20241012-imx95-dts-new-v3-0-edfab0054c71@nxp.com>
In-Reply-To: <20241012-imx95-dts-new-v3-0-edfab0054c71@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|DBBPR04MB8042:EE_
x-ms-office365-filtering-correlation-id: b65ddc7b-09ae-4b04-a93a-08dcf1b2366c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WDFXdGJCOENiSkp0RU9hTURnSVdEVkx0TDhzZlpXOFo0TjFNWVhhR3hhNTZN?=
 =?utf-8?B?dDhGbXZoSHYwQkVNcmVyMXhHa3E5U01mL1ZxYmJ3OS9ySmlUb3RsazRNNWxo?=
 =?utf-8?B?eDNlbDlabzNXWGR2K2RDVVZOTW9pT2VmaG1BZGI1b0U5a0dYbWZ6VWxSem5m?=
 =?utf-8?B?MVZza0pDZEJaY25tdTZCdDRwOGpUZ1cxNzJhc3R4blV5M1lYamRoVG9KR2Uw?=
 =?utf-8?B?MDlqVFZkSk55Vmlib0QxMkUreGorSVphOFFkWDh0aGJzOHdPRVVBNmFqL0JZ?=
 =?utf-8?B?dEY0YWNhOG9yOW85QTBJb1B3SURibkZ1UGF6bGkrM01XN3BWdG54ejVwVlVY?=
 =?utf-8?B?QllySFlRL2tJb0Z5WS94S3JHMXVTWnVsWk5RcUs0UXFvenRuaHBIMkFBVE91?=
 =?utf-8?B?bTlwNWdKMEYxRUZHSlhiVjVFV0ptbmFjSExOUUxYZE8yK016UjF1bE9mUlFS?=
 =?utf-8?B?dVFUSlh2R1hVeWtTbmlwNGhJMjBjSzJWZXdSUUp0NU16SVZoVTdBZGNXcFU2?=
 =?utf-8?B?bUc3UnRPUUZZRlc4K3NKaEYrOS8xN0RHallGSXQ3Z0FNaWN1VTltSkFtcEp0?=
 =?utf-8?B?Vit0Z281dC9wZmxpbEwrSWVtVzhpQnNuYkxaR2ZpeWlPVlRRMlg5WlFtVWtR?=
 =?utf-8?B?RGd2L1k5ZTBDZmZKLzNuQmxnZ2crQlVQOEtZY2FZWVp3dllaR2VzVkJVKytv?=
 =?utf-8?B?aVpPamo0bWdJajdOY0Z6QjhBN1NJTmp5WUthZTdSa2txbnR6Z2ZrTmw3YUdk?=
 =?utf-8?B?OXVSM29tMTEyQTVtMGdCNGo5QmNkMUVCRHBnNklhKzEzdWdPOHZUMUI5Nlcy?=
 =?utf-8?B?cWs0ajJNQWEvZTB0SHVSNE03eXFhZ1BEN0U4ZzBlN29IdzNVcG43Q1FZYS9U?=
 =?utf-8?B?aDAycis1TitYU0QvbTBMdEI2YjFLRDNKSjNMUlhxTVd3citmeHY3VXNFS3Np?=
 =?utf-8?B?RDBkeXozbHpqTWpQKy85VzRYR3FTZVRvdGFCcTNDM3N3TW9tMGtTWFJZVXlx?=
 =?utf-8?B?V2p3UFFOL0NBVDRJNGhucVpkeXhJOGdiQ1Bnck5HUTN3b0lZQWE1K2p2cXdV?=
 =?utf-8?B?L3p5TEdkaHhKZkd2Q2pSMTVubThaMWJyeVJodlFpTFVXUTZQVXphNi9DSVVK?=
 =?utf-8?B?eUdjUE9ZRGIvQ281TWxHd3Q4bVBBNGQzOGV6a2ZXQ2haK1Z5SFV3QmordHZs?=
 =?utf-8?B?bnVUcW9WZ2ZSeXVZS0lqSm50R210ZmhYR0gwS2duTks1ZzV6SmwrZEpMakVo?=
 =?utf-8?B?Z1BkeHhKYmVsSkhuc2FFVkJSNUUrOTAzQ0RDa2lVRHNZb1FqZUl2RGRlRHEy?=
 =?utf-8?B?UDVHTWtOUlk3WW02Y2djWGNscXp6OVpUdVVNbXdsVkhuMHVleUVEV1dRa0k5?=
 =?utf-8?B?cVJtbWh5RmU1Q3JMVkhiSnlpMlY5TzU4QmlrNjZHYmt6V2drSlFRVGdTQzJW?=
 =?utf-8?B?WEVSVTc3Wktqa1ZjZ0JGUWFCSGd6NkdnSTJmejBMNGE0QTA0b0NVcmtxdUhl?=
 =?utf-8?B?ZDZlK1dGSHhjYzZUTFRocSs3NkdibTlwTkJMRE44YnMzaTRtS3dUbXRlMkxi?=
 =?utf-8?B?TFlWbnB5a3h6NUtPLzZWYmJ4U0VhYXFqemFyajN1eEJiSDYvOE94T2ZrQmlL?=
 =?utf-8?B?RHF4dU42RjAyNkV6dnY4T2l4ZkZwNmI3ZVBON2d6Q3hDLzExRnA1UGdoTUxQ?=
 =?utf-8?B?SEpVZHFZbWZ0aUwwQi85aERXYSsvS1AyeGZZQkVhTU1oZ0EzNEhvTldUNVgz?=
 =?utf-8?B?ZWJES3NyVGtaZlJqVkFKeS9PSzZoekowZHF6RCtLUWZFYTMrM2htUTE4TUZm?=
 =?utf-8?B?QWhYeTlpeHlsS1BkYU1uQm9sNlJ0NlBNM3RqT2JvZkJrc2c2MFlQVGtjUVBI?=
 =?utf-8?Q?W8BPxCKv8pmvu?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?L09xbTJwMCtsNHcrZUczNzZyRnQzN0VpSnFRaHJ5b1pVcnljR241OFlrUFZh?=
 =?utf-8?B?cEVKMG9nNXNuclZ4Z0JnNDJLNU9CdVMrM3RWS21HNFptY2pybkFHOGF1YWx6?=
 =?utf-8?B?a0pKdmlBWHRaczllOEhMUnNWYlVxdkRkMFFUZ3hMMDJhbitHTzRaNk9iZElN?=
 =?utf-8?B?V0YxUnJIR0cxcDBja0tJL2N0ekN6bHAwM2Z3cUF0UHAvRHlTY0RuTFM2aHZz?=
 =?utf-8?B?bWVyUG1FU21XTmI4M3pzMTIxam5ETjVWZEIrVW05eW9UbEhUbC9HMVRKVERJ?=
 =?utf-8?B?dGpnNlVkaEJFSTU1bjBsQS9XMHBJdXROMFZXSktUcWw5ZVoxQ1VqemtJaFdD?=
 =?utf-8?B?bWt4eW1qd3ZKWElrQXhaUGF5dGZ1OHNzeTQzcVhlSEZBcXNZWUlGb1V0cldz?=
 =?utf-8?B?UWl6KzZkV21NbHBabzJYbWhHNE4weGpZSkllSnhSTkRmdjN2SGNNUEhDVDZL?=
 =?utf-8?B?K2VjS21ITmg0dGN3eTI1UktDdGdkY1NiUVowSWNtZW1zL0d4U0hoQ0c2cUJW?=
 =?utf-8?B?UTd1dEM4T0VxZmNmYVNSaEIrb3dFbmJDSnJsZzdjVkZSaWdKTGdtcGQxUzFM?=
 =?utf-8?B?T2lyRVpWRFAwZmExWlRodmdqenc3dEo2SXVWUitRZGMzK3RqMitDcTlCZFJF?=
 =?utf-8?B?aENXSVJ6cWxLRm5HaDFiZVJzaGpiT05WUzJmK3dOQWdZY0gydm5GK0pqeHdH?=
 =?utf-8?B?UlZsaEdUNnRrdlFlOHBERTdyWjNsb3IxUTljL09WWmR1ZlZzcUZnQTZ6bUIy?=
 =?utf-8?B?N2xDeG9zU2ljNDIvZEFTaWtjbDVDSEtQRlVhMzVBa3p2bHc3Z1NZbVNLZzQ4?=
 =?utf-8?B?akx1bjFzTGx2U3N3OVJIbGw0VHBvOE5BTThQWkpoSnJwd0RJU3VMOVRLdmtp?=
 =?utf-8?B?VTR1Rlhmdlc4dElDcXpsRUlpdmhHbU54SmQ3L0xySTQzMXFvSUpJUitoR245?=
 =?utf-8?B?Yk93RkMzbFZRc0FUTDlCdmdYSk9FeDFiUEdOT202YStxaDFMT0oxMGFiZy9T?=
 =?utf-8?B?L1AyTFpjM011bWQ1ekE0V0I5dm04TjE5d2EzeWZCbGZxSDdRNkkrWkpreDZB?=
 =?utf-8?B?emp5ZG8rZ2QwQjkxRFUrQk41TG9GTEEwQlJhWFlGQzhlcGg1Z1Q5NjA3NytQ?=
 =?utf-8?B?QWk0Vk10Sjh4aHZWV2psdHU1OGFTbU04WlVXM3ZNSVJNRmFOMnp3Zy95ZEI3?=
 =?utf-8?B?SDBINitRMUpONTI0aGpYdnVscitwNWgzNEgwVGNOVnBRM0NGTnhVcTFBaW1u?=
 =?utf-8?B?QWhnS293Y3pJZWROTUx2a2FEeU91cFIzRG13dFBVWDNFd0ZNckcyRHBGQi8w?=
 =?utf-8?B?NHVIeUR6Q2hKOFoyVUVhc2ZLUDM3R2NXNXRMT1NFNUY3ZmtCeVZ5R3cwRWtq?=
 =?utf-8?B?ZGwyWGN5aDYvZE9JQnJTeERZMlNKUEdmNytoRzNqSDlwR3g4bUhVR1pYWnV1?=
 =?utf-8?B?bzRabnpyWFk4TUVrWXU4eG8vV0pZa0ZVa1lOVGxPUWhHa2dIUWhrVUtVazVS?=
 =?utf-8?B?ODY5cTN1cFJhNVBGdjBOTE1kczNiM0RiOE5GTEMrL3RXbGF2b1RLT05SdGxx?=
 =?utf-8?B?T2ZuWHdtdk9QVDlPZ0w2Mkd4Nkd4c2k5Y29FY1ZpVklrSHhOYkVEVzU2WGlN?=
 =?utf-8?B?dGY1M3BGZm9ma0J1VGlnSDR0TklhbzZNaUZBWlFCemN5VmgxNTRjYmZneWFo?=
 =?utf-8?B?OVBCQWVUdThCd0xPa1BEYk90UHFQV0ZJcXB4dXFIVEZYdGFaMTVpVHBKbWNT?=
 =?utf-8?B?QWdpa2dJejd6OFpGYy9RRmVqU3RlRUhhYm5veUtHZFIvQXpUZUpMRXdxd0JF?=
 =?utf-8?B?S2p1MjcwV3M0RkJvMGJpK2JGM2tzZ3A4cnBDSk9zb1NZd01TamJiSllaQUV5?=
 =?utf-8?B?ck9weTRObDZQcHlZRG5NOHRjSXorVXppL0ZsSEVnY2dwYkdOekx3ZGdwQy9W?=
 =?utf-8?B?S1dETFlRNFh5elB3T3ptNjB1SkFBOU5NQlBmS3dqV2JuTDhFbHc1UzRBcTIy?=
 =?utf-8?B?Q2F0K0xSTllXNXZnYUJXdFI1Q2Z6Y2ZmNXFBU3Vlcnl1cDhhV1pxdnl4UWZm?=
 =?utf-8?B?Z2R2LzdJZGU0VlFObTNxS2NodlNXYjYvS3FiSTNZek9QWGVKY0d6ZzQ5dW42?=
 =?utf-8?Q?luD4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b65ddc7b-09ae-4b04-a93a-08dcf1b2366c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2024 09:24:49.9257
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DjEIoTydyXH3sCAt1C7rtDWuEhBF5kaIw4tHLdcZp6Milf8sTL40cCJHQxlhJUIYYPr1s6TjyWhsUjpieKDShQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB8042

SGkgU2hhd24sDQoNCj4gU3ViamVjdDogW1BBVENIIHYzIDAvN10gYXJtNjQ6IGR0czogaW14OTU6
IGFkZCB2YXJpb3VzIG5vZGVzDQo+IA0KDQpBbnkgY29tbWVudHM/DQoNClRoYW5rcywNClBlbmcu
DQoNCj4gUGVyIHNjbWkgYmluZGluZyBkb2MgdXBkYXRlIGFuZCBpLk1YIGV4dGVuc3Rpb24gc3Vw
cG9ydGVkLCBhZGQgdGhlDQo+IG5vZGVzIGluIGlteDk1LmR0c2kuDQo+IEVuYWJsZSBjcHVpZGxl
IGZvciBBNTUNCj4gQWRkIGFuYW1peCB0ZW1wZXJhdHVyZSB0aGVybWFsIHpvbmUNCj4gQWRkIGxw
aTJjWzUsNl0gaTJjIG5vZGVzIGFuZCBzdWItbm9kZXMNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFBl
bmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0KPiAtLS0NCj4gQ2hhbmdlcyBpbiB2MzoNCj4gLSBS
ZWJhc2VkIHRvIGxpbnV4LW5leHQgbmV4dC0yMDI0MTAxMQ0KPiAtIERyb3AgbmV3bGluZSBpbiBw
YXRjaCAxDQo+IC0gQWRkIFItYiBmb3IgcGF0Y2ggMg0KPiAtIFR5cG8gZml4IGluIHBhdGNoIDYg
Y29tbWl0IGxvZw0KPiAtIERyb3AgImZyZWVzY2FsZSIgaW4gYWxsIHBhdGNoIHRpdGxlLg0KPiAt
IExpbmsgdG8gdjI6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyNDA5MDMtaW14OTUtZHRz
LW5ldy12Mi0wLQ0KPiA4ZWQ3OTVkNjEzNThAbnhwLmNvbQ0KPiANCj4gQ2hhbmdlcyBpbiB2MjoN
Cj4gLSBVc2UgZ2VuZXJpYyBub2RlIG5hbWUgImdwaW8iIGZvciBncGlvIGNvbnRyb2xsZXIgaW4g
cGF0Y2ggNw0KPiAtIExpbmsgdG8gdjE6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyNDA5
MDItaW14OTUtZHRzLW5ldy12MS0wLQ0KPiBhMWY3OThmNGY3NDZAbnhwLmNvbQ0KPiANCj4gLS0t
DQo+IFBlbmcgRmFuICg3KToNCj4gICAgICAgYXJtNjQ6IGR0czogaW14OTU6IHNldCBtYXgtcngt
dGltZW91dC1tcw0KPiAgICAgICBhcm02NDogZHRzOiBpbXg5NTogYWRkIGJibS9taXNjL3N5c3Bv
d2VyIHNjbWkgbm9kZXMNCj4gICAgICAgYXJtNjQ6IGR0czogaW14OTU6IHVwZGF0ZSBhNTUgdGhl
cm1hbCB0cmlwIHBvaW50cw0KPiAgICAgICBhcm02NDogZHRzOiBpbXg5NTogYWRkIGFuYW1peCB0
ZW1wZXJhdHVyZSB0aGVybWFsIHpvbmUgYW5kDQo+IGNvb2xpbmcgbm9kZQ0KPiAgICAgICBhcm02
NDogZHRzOiBpbXg5NTogZW5hYmxlIEE1NSBjcHVpZGxlDQo+ICAgICAgIGFybTY0OiBkdHM6IGlt
eDk1LTE5eDE5LWV2azogYWRkIG54cCxjdHJsLWlkcyBwcm9wZXJ0eQ0KPiAgICAgICBhcm02NDog
ZHRzOiBpbXg5NS0xOXgxOS1ldms6IGFkZCBscGkyY1s1LDZdIGFuZCBzdWItbm9kZXMNCj4gDQo+
ICBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg5NS0xOXgxOS1ldmsuZHRzIHwgODYN
Cj4gKysrKysrKysrKysrKysrKysrKysrKysNCj4gIGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNj
YWxlL2lteDk1LmR0c2kgICAgICAgICAgfCA2OA0KPiArKysrKysrKysrKysrKysrKy0NCj4gIDIg
ZmlsZXMgY2hhbmdlZCwgMTUyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IC0tLQ0K
PiBiYXNlLWNvbW1pdDogNjBhMDNkZDM2NWI0MjFkMGRkZjJkOGFlODczNzAxZjkwZjk2NDJiNw0K
PiBjaGFuZ2UtaWQ6IDIwMjQwOTAyLWlteDk1LWR0cy1uZXctZmJiOGFjOWZjYTE4DQo+IA0KPiBC
ZXN0IHJlZ2FyZHMsDQo+IC0tDQo+IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0KDQo=

