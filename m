Return-Path: <linux-kernel+bounces-332193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37BBE97B6A5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 03:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B516B23CB9
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 01:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 325C02233A;
	Wed, 18 Sep 2024 01:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="TzfX5pkE"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2081.outbound.protection.outlook.com [40.107.117.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED72AD2D;
	Wed, 18 Sep 2024 01:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726624516; cv=fail; b=jWg+jGhK+h3KES9zyxnyuJVNAVYJbV8ltEsDE6BtiV8CQmZwu8RAUZguKdN0XynJ3qaDeMjEeVx7+XFpdvsTsshBwUuG5UjDD6LsLWgFAQj12VSbqesQQzt/aF1rd2ye4W3dFvu5SQ2FjRBq7IIpTU1ixxb28mwEUnlq2TEU6C4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726624516; c=relaxed/simple;
	bh=QkA90JyFjzEbKGy+1mtfROobaywDhSVN3NiHY+F94kM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=V2nZv/6q0BhoKDKGhgWhfmnM3dqroXF0hXw67MbwiXn+X4Zf/uZqdiiSKdZ4c18sbPQHMilRZLsVei1H7V1FGtMKV3j8sjNpZQLMlN818BPo/bBMN+lrT5zB7owjPPjd1djkyApu+XQ4FWsjWlCQSB2t2mJNprQ//pD4/eBhN8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=TzfX5pkE; arc=fail smtp.client-ip=40.107.117.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yFv0k7SVyMUGKW1dClSETZYCjlCUnT8/93c3bjmXAgKf9MprZxA142mVkjasWUFLwfS/QDxusLPEaDS0gECOF75Zfzy+qxbBdUwP8kkGwYtyy3wfemzU3xqlPDCqFTInbXhEQwqRVwGM9LaUZGbNaHvm33o7h8Z4+CGb1QuDxg07TRsydwxgO50Jlg0v1RivqLcLlCCyy7wWgNvO3vJ0PWJvJ8hzqoGTiuMgO2fmRedZK/WbFdr67psh2bjUWKs1lwGr2QMSn4VihC7H+olFy+0ImIAtLnbPGeSAtrhvN8ZuQKwruzR3c+lNb6lal3qyO2KB/nxBiAvebxVPtF+pdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QkA90JyFjzEbKGy+1mtfROobaywDhSVN3NiHY+F94kM=;
 b=CpzXkjSPvaFAjVfULT5W7QAv4BDv9r5j/6vbn58JktQaFWFReeIJsW/N87Vab0VPv7Kbyfh2hDT82yPnubg/msWAg8/9aCBSiBGJv9aaoXidDBE0bnGXUV24YGEbW65Wk2phcjMeyXCEVN4o/hxsHIcrlw57zLrIm06UWUr2akoFFvWrIrWJYVVAm5gwINvxmiR04rsUJRQDH2cVyHVmSUSwjd8o3dZt/ERduwJGI7gTIecfj5M/mlCbw9luIKeJdp4eH6pa0o0r3CdqJQiymUTdp4PbdNHPo+ouRkmfw6wMILr5S1c/+OBqL4+k5RzZfjbZ3WJ96StloPeO5kkZSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wiwynn.com; dmarc=pass action=none header.from=wiwynn.com;
 dkim=pass header.d=wiwynn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QkA90JyFjzEbKGy+1mtfROobaywDhSVN3NiHY+F94kM=;
 b=TzfX5pkEBdCXGAPSD0pt6K3cNMwpejE5bMqwuz3q58bAByOh94EaMrTk3OEvXBSMmZlRa5sXftr4Ag8tmJtof9MYU/BLS2xxUt3GQxeRyrjMkbLHfQSLqbCWo43IsSx9GhcK8KbyNoSuOtLNK1nf+Eb2SyyDfYxzWzpAdbbQlhB3xpBsrGNo/WVWk8fIXgSqjtTwucwNLwCjY8KGH43eYjzGGeAP9XkABXPGdU8Qwv1y4fMFYVXrB6C3ZtQNR74kqiGnyEOLIY2BJ27BIwqLsipg7SWKUW4SxUE0zB07p1EXrn6QqzaajxMnGfOuAUxrb1e9Yw6oJ08p9G0Gkgct7w==
Received: from TYZPR04MB5853.apcprd04.prod.outlook.com (2603:1096:400:1f3::5)
 by SEYPR04MB7037.apcprd04.prod.outlook.com (2603:1096:101:173::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Wed, 18 Sep
 2024 01:55:06 +0000
Received: from TYZPR04MB5853.apcprd04.prod.outlook.com
 ([fe80::ae7d:7486:9319:8d96]) by TYZPR04MB5853.apcprd04.prod.outlook.com
 ([fe80::ae7d:7486:9319:8d96%6]) with mapi id 15.20.7962.022; Wed, 18 Sep 2024
 01:55:05 +0000
From: Delphine_CC_Chiu/WYHQ/Wiwynn <Delphine_CC_Chiu@wiwynn.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>, Delphine_CC_Chiu/WYHQ/Wiwynn
	<Delphine_CC_Chiu@wiwynn.com>, "patrick@stwcx.xyz" <patrick@stwcx.xyz>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>
CC: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 2/2] ARM: dts: aspeed: yosemite4: Add gpio pca9506 for
 CPLD IOE
Thread-Topic: [PATCH v1 2/2] ARM: dts: aspeed: yosemite4: Add gpio pca9506 for
 CPLD IOE
Thread-Index: AQHbA0UHYnKTipIy9EyxznCx6Ypb1bJTa20AgAGQKZCAABa04IAEsbUAgAMQ5BA=
Date: Wed, 18 Sep 2024 01:55:05 +0000
Message-ID:
 <TYZPR04MB58536B1037542111FAA553A8D6622@TYZPR04MB5853.apcprd04.prod.outlook.com>
References: <20240910054751.2943217-1-Delphine_CC_Chiu@wiwynn.com>
	 <20240910054751.2943217-3-Delphine_CC_Chiu@wiwynn.com>
	 <ccef1d90b9a7eb343e99afa2c6cd6ea7407b0541.camel@codeconstruct.com.au>
	 <TYZPR04MB5853B6611AF9AA5C3E5AE778D6652@TYZPR04MB5853.apcprd04.prod.outlook.com>
	 <TYZPR04MB5853062387962EB4CA08A366D6652@TYZPR04MB5853.apcprd04.prod.outlook.com>
 <a18eff1095e1ddffa8eb44fb4a76a0b458213a62.camel@codeconstruct.com.au>
In-Reply-To:
 <a18eff1095e1ddffa8eb44fb4a76a0b458213a62.camel@codeconstruct.com.au>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wiwynn.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR04MB5853:EE_|SEYPR04MB7037:EE_
x-ms-office365-filtering-correlation-id: a9d21060-b5ad-49e2-46f4-08dcd784eb15
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cnJTY254L3BjamRWNUFwa2RCVFlJeVA3dGtDM0RGZUs2OXhaWC9nS2M0dWN1?=
 =?utf-8?B?M1o3NFVWRTB0RXB5V3JVZlJCbXQyMURRZ1h5Y1BueTBzUU5rMDRZZVFtSXpW?=
 =?utf-8?B?VWVuN2hHdE9xSC9CMjNpK2NIK0RLc1B3RU10UVlFR0R1NjhxeElIWHdnVFg5?=
 =?utf-8?B?RkNCd0FFWnBtUDBoeWxmcnlSRUVBZEpXaFBFNkVQbndDOTYvRGRVaFhzS1JW?=
 =?utf-8?B?azArZzJIdGIzKzF4eHFrMDRoVGxEdE96M056UXEzVDUzcGxnRzFXWTRYdVNM?=
 =?utf-8?B?K1ZldldHMVNDZEV3ek9QMGFEbzlURW5Bb3JQRnpaTW40U1VpODR2RmFQWkYx?=
 =?utf-8?B?MUh6VjZickhwT01FSEhjS1BrbVh0VWcrYmRGZHdWYm1iRkNUdnYyeFBvKzFm?=
 =?utf-8?B?My8zaEdGNUNqeEZBNXdUYzF3Rmx4REhtd2N1TUZJSzNORHJISXRPUCthSm04?=
 =?utf-8?B?eGZJdWtSeHV6WXhWczV3RG9XVmFDMFowWWNVMktIallnZ2tXalZnRUNIbmh1?=
 =?utf-8?B?VTYxMjJNVnZId2dBQi9UakdMUXNsTjhMdC81OVF3SzRjUEhKTGVBZEtiV1Y2?=
 =?utf-8?B?SDVXelN4aFVKcTFKOWhocjlwMi8vQmFOUldScjVvTkI2WUY0aTF1cjdGMUFU?=
 =?utf-8?B?cEZkR1M3MkdmN1FBSmJrYmJ2VlBxaEY0c0U4UmxDSVR5UFBiRjQvZGpsY21i?=
 =?utf-8?B?Q3JNUExrcGtyMFdFU3l1Z2xlRWpsTmVMMUJoRnRzUGl6QlhiZjFMM2NqVVNl?=
 =?utf-8?B?cWFpZm9YUGszbFoyNE1WRTBEZVg0NDR4RHVJRXJiS1BVOTZwQlpUVWw5R1VQ?=
 =?utf-8?B?SVZlMWRMVE83UzFRbStSb2ZEbnBIZ2ZOMnR1NW5DUnF1TnBQNmhsNG5qVFVF?=
 =?utf-8?B?Qm43czQvU1dDdWEveFRhanl0RGxjTm9hN3FwY0lHVkFDS3B6ck5jaktwQW9U?=
 =?utf-8?B?d2hNbVI4M3MzQVlKVzdMYmtxb1BWVERtWGpVdDU1bC9XK3NYVEpEZ3BCSkE3?=
 =?utf-8?B?ZkZDRHkvRzliVjQxaFR2K09pdm9QMFJkNWYxZ3VpWUlBdXhhWUpjVGhzM0py?=
 =?utf-8?B?K0g4MFJtWC9WV1hjM1FqTVpZNmNlTUZDYUE4ZmlGSTUrN0pDSEN6OEtZQ2dH?=
 =?utf-8?B?ZUxPQzIxOWFYVmJDU1lrd2JFUWdZRVQ1ZDF4dXpFQVVSb1RDMFpmV0VxMkha?=
 =?utf-8?B?VlFMVjRQNm1mME9tZHF6OUI3dEJzREw5WnA2NWZOZGx2WituMW9WbktjMkZR?=
 =?utf-8?B?Sjdwamp3amJwMENtaEYwdTdoNHZ0Y2U2RHBPRURFS0tnQlVBazBZMmVycVo5?=
 =?utf-8?B?cmVRVVZYczJOODBSM2ZrSVpNZVZ0elFQNlRmRFFnNlpXQkkzNElLdFZYR3ow?=
 =?utf-8?B?SE1TQXhxaXIyeGk3b09WSnp6OFFIcUxzU0IrYjRMMGNGY25zMDMrTys3STV2?=
 =?utf-8?B?eG1Id2hFd0RRdUdlMTc0T0o2cTRGcy9VVjQ0VGV5S1NlaXlRMi9wVlNrTDFw?=
 =?utf-8?B?KytaZWRTMWw2Y2hnK0pjNGo5TC96eFFZbnVYamFTWGkrS2MyZTVSVWtzVjRl?=
 =?utf-8?B?RlU0cGJwY0ZWVUJTTkh2Ymc5ek81alJ2cTRNYkxHVlJvRVQ3ZkZUNFdxcGJs?=
 =?utf-8?B?VDgyemhPaGNaRThBdk50UWhDYlBjeHZFMUNmekdBN1h2TUszSXdNTEJBSXJH?=
 =?utf-8?B?ajVGeE5UN0lUeUd4dVl4ZldxK1RPU3RtMHBFWm1ocFo4VUE1TjZyS3VkdGEv?=
 =?utf-8?B?RElmVFVPbnllRWR1MTdFY3FSaU5ScEdGa1VmQU5sYkxUNVhXdHVJUS9mQ0cx?=
 =?utf-8?B?YUQvRFhNVnFZVG5YbUZGdz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR04MB5853.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VVRkUkNxTitONk5oYTRqMTlId1phNDlTQ1dUWWVzbW9rMWhZaFFIZ1piMjc5?=
 =?utf-8?B?TFo2V0MwdHBBSmgvcWNQUTdrR2NRVzN4V2Y2cDNZbE9aZG9Qa1ZmYXNwOUhi?=
 =?utf-8?B?NnRwK3cvVnFRQkZlTk83SU9iT0RHSXlKWUFoOXRDSVBxeHorMC9RakZxQ1ZN?=
 =?utf-8?B?N3QxUnFKUmZFWHVmeklnOW1LaFNCZ3VqVzR6dkFKMlpXL25PUUJYdVkrU0U3?=
 =?utf-8?B?QVVudUhkMXBHU04wMmZXZ3FMWkNBL3d5UHMwd3hRVmF2MTZKb05jdi9abERx?=
 =?utf-8?B?MW5IWXZML3BzNFFrQWdtMGlTeCtoeVRsaW53R3RaR295dXRXZHRFSThob2Fh?=
 =?utf-8?B?Y1dLVVlsTlVMNS81WTduSE5iSXNRcTg3dXNPVW80c3hNZ1BkS1RGbnlwZnB0?=
 =?utf-8?B?OUY1UHpCOGN3NElockNHS1huS2JBOURudllpQ1ZqODhkWTF6MlNQemQzVWMr?=
 =?utf-8?B?TUhiTEgrVDA1UElSSFhlR0ZWZW5MSVc0a1JXeFdCWVd1MEdZSGlQeDJBNGRS?=
 =?utf-8?B?TzJVdUpJajJQcEtCaDNRZStXM1ZsdStpTFQ3OTVRQmNWWDZmOW1KOTFzTDBX?=
 =?utf-8?B?TzA2V2ZPZCtFd0FpVXBqRExGR0I3ck4vNzlEVWhBOWlydEJzYklmZWw4bG5B?=
 =?utf-8?B?dlBlY3IrUSt6bHJLNTRxSzhqbVlLcmtxNTV1TlQ3L090c1ExMWllQmFQREgw?=
 =?utf-8?B?Q2tjR2paUWRoUkJuT3dlNkoyczMvaWVaZUd5ZTdlV3U4UzRtdVNNQXdPUlRU?=
 =?utf-8?B?dm9MS3dZKzJwUHNBWjJtSFoyZmtRN1ZxWjdKL2VubjFGNHc2d1ZhNUtCUDZx?=
 =?utf-8?B?cWV1NzlEcjZXaENldUFuTmlCMnQxY1BjZ2VjS3FSSEFxelkrNFlQOWtMbU44?=
 =?utf-8?B?UVBwOG1FblZjVG9QOE9KMzBxQ0FZbmh4Zy93bzdEQUZwQVc3MCtPRnV2eCtz?=
 =?utf-8?B?RlFUVlB6ZitRS24zeG9oK3FHRnRqVEZiVExsQWdMckpiUnVENkVsTjRSNzM1?=
 =?utf-8?B?Uy9VSFRzZHZFWGFDUTdtb2hPVUwxMmFSQ2ZOQWcwaFU5VkdweVdmeXFOZzk3?=
 =?utf-8?B?QmdVa2tydVRFeWJBS09OY0JpN2luZk44MjNTQWIxOWdZQnAybkhMRFI5eFdx?=
 =?utf-8?B?VXp4YkgwS2V6ZHorc3dWV0tuTE1XMUlDOXRMSFZabTU3b25uQkFmSGVWUEd0?=
 =?utf-8?B?ZWVTRnByS0dJSXNLUUlFTnRDbGhId3RpRE1JNDI5SnRSbWJDVCtJVWJoOGZR?=
 =?utf-8?B?RFFvaHljMUkyZjBJdU9UNE5LN3c0SStBY3Q1VEg5ZWRVd01kZHRvcE1iaU44?=
 =?utf-8?B?WWZieFlscDFEMGQxRXdkRytKZGgybHM2aHNUd052WmRCMVBpZjBRRmJvYVhv?=
 =?utf-8?B?QU13WEora3NPQjNXUzNUd0h6cHpidzlycFdVenBOMVpDM1RBK0tOYkxIZHhE?=
 =?utf-8?B?cVFwcjJ5a2hBYjA4dHdaN01PT056QWVTWHVMbEVvQW9zM0dnQzJQbWNoaWZ1?=
 =?utf-8?B?TUd3YUFkR2JxYnExdGx4QURYTDRRZTgrTlJyNG9PM3JPdk9VQThxVG81TXNF?=
 =?utf-8?B?RnZPKzdmSjVBSS9HM1hqL1hYeXJ2a3NVVmMxWWpvQTdMbzB2Y0tUd05wTTBp?=
 =?utf-8?B?WlpMZTFLSGcwRkdRY2RIOVRmUmlWanlvd0tiaURvaEJ6d1BvSVQzNnlBcVhw?=
 =?utf-8?B?MzBMdE1Pb3RGWWgxd0VSNWFxUk9OMXBGRVNXS2EySUlvWUJZanFPR0hrZU5P?=
 =?utf-8?B?aS9sclpKampzZ1l3TEdwNDRQRmlKMThwaEhsank1MzlYdzJFWE4zMnhKUEtJ?=
 =?utf-8?B?RHVxRFF5b0NFQlBhaWk4aDVBWDZic1VIb3JVa1FuVUROTHFBWkdmOU1aakZE?=
 =?utf-8?B?bWE2UlE3R2UvREFxRkpsbWszZzJwL0NHZ3poeUdncmFRTkhkNkdPOVdJTEw0?=
 =?utf-8?B?UTJSWjVvVW0zdC9iMCtMNkhTYzJOWEUxcTFMeHJsbDhoZXJPRVdCaFIrU1I1?=
 =?utf-8?B?dWMxWEwwSFp1eDFUUkIrTXpBZTFHTFlubUhTcXBTYWVNbVFxN1FHb3d5TlRB?=
 =?utf-8?B?dUZ0ZE5PdGoycHZKRUtwUFQwL25TZFQyZEpGdEM2cHZYc3R2cUJPM0dNUElL?=
 =?utf-8?Q?noUdDQ6452ocqfwxxzmuhUHHu?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR04MB5853.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9d21060-b5ad-49e2-46f4-08dcd784eb15
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2024 01:55:05.9119
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZOix+XL1sKHGa7ow0rlkxs7RsnkqNRQ+CajMj0FH75+S3yZnPZzea1CxITUgsP0WGOsAPh8cw5Nj+V8c4srtKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR04MB7037

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQW5kcmV3IEplZmZlcnkg
PGFuZHJld0Bjb2RlY29uc3RydWN0LmNvbS5hdT4NCj4gU2VudDogTW9uZGF5LCBTZXB0ZW1iZXIg
MTYsIDIwMjQgMTE6MDUgQU0NCj4gVG86IERlbHBoaW5lX0NDX0NoaXUvV1lIUS9XaXd5bm4gPERl
bHBoaW5lX0NDX0NoaXVAd2l3eW5uLmNvbT47DQo+IHBhdHJpY2tAc3R3Y3gueHl6OyBSb2IgSGVy
cmluZyA8cm9iaEBrZXJuZWwub3JnPjsgS3J6eXN6dG9mIEtvemxvd3NraQ0KPiA8a3J6aytkdEBr
ZXJuZWwub3JnPjsgQ29ub3IgRG9vbGV5IDxjb25vcitkdEBrZXJuZWwub3JnPjsgSm9lbCBTdGFu
bGV5DQo+IDxqb2VsQGptcy5pZC5hdT4NCj4gQ2M6IFJpY2t5IENYIFd1IDxyaWNreS5jeC53dS53
aXd5bm5AZ21haWwuY29tPjsNCj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFy
bS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gbGludXgtYXNwZWVkQGxpc3RzLm96bGFi
cy5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRD
SCB2MSAyLzJdIEFSTTogZHRzOiBhc3BlZWQ6IHlvc2VtaXRlNDogQWRkIGdwaW8gcGNhOTUwNg0K
PiBmb3IgQ1BMRCBJT0UNCj4gDQo+ICBbRXh0ZXJuYWwgU2VuZGVyXQ0KPiANCj4gIFtFeHRlcm5h
bCBTZW5kZXJdDQo+IA0KPiBPbiBGcmksIDIwMjQtMDktMTMgYXQgMDM6MjYgKzAwMDAsIERlbHBo
aW5lX0NDX0NoaXUvV1lIUS9XaXd5bm4gd3JvdGU6DQo+ID4NCj4gPiA+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBEZWxwaGluZV9DQ19DaGl1L1dZSFEvV2l3eW5uDQo+
ID4gPiBTZW50OiBGcmlkYXksIFNlcHRlbWJlciAxMywgMjAyNCAxMDowOCBBTQ0KPiA+ID4gVG86
IEFuZHJldyBKZWZmZXJ5IDxhbmRyZXdAY29kZWNvbnN0cnVjdC5jb20uYXU+Ow0KPiA+ID4gRGVs
cGhpbmVfQ0NfQ2hpdS9XWUhRL1dpd3lubiA8RGVscGhpbmVfQ0NfQ2hpdUB3aXd5bm4uY29tPjsN
Cj4gPiA+IHBhdHJpY2tAc3R3Y3gueHl6OyBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPjsg
S3J6eXN6dG9mDQo+ID4gPiBLb3psb3dza2kgPGtyemsrZHRAa2VybmVsLm9yZz47IENvbm9yIERv
b2xleSA8Y29ub3IrZHRAa2VybmVsLm9yZz47DQo+ID4gPiBKb2VsIFN0YW5sZXkgPGpvZWxAam1z
LmlkLmF1Pg0KPiA+ID4gQ2M6IFJpY2t5IENYIFd1IDxyaWNreS5jeC53dS53aXd5bm5AZ21haWwu
Y29tPjsNCj4gPiA+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVs
QGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+ID4gPiBsaW51eC1hc3BlZWRAbGlzdHMub3psYWJzLm9y
ZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiA+ID4gU3ViamVjdDogUkU6IFtQQVRD
SCB2MSAyLzJdIEFSTTogZHRzOiBhc3BlZWQ6IHlvc2VtaXRlNDogQWRkIGdwaW8NCj4gPiA+IHBj
YTk1MDYgZm9yIENQTEQgSU9FDQo+ID4gPg0KPiA+ID4NCj4gPiA+DQo+ID4gPiA+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiA+IEZyb206IEFuZHJldyBKZWZmZXJ5IDxhbmRyZXdA
Y29kZWNvbnN0cnVjdC5jb20uYXU+DQo+ID4gPiA+IFNlbnQ6IFRodXJzZGF5LCBTZXB0ZW1iZXIg
MTIsIDIwMjQgMTA6MTEgQU0NCj4gPiA+ID4gVG86IERlbHBoaW5lX0NDX0NoaXUvV1lIUS9XaXd5
bm4NCj4gPERlbHBoaW5lX0NDX0NoaXVAd2l3eW5uLmNvbT47DQo+ID4gPiA+IHBhdHJpY2tAc3R3
Y3gueHl6OyBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPjsgS3J6eXN6dG9mDQo+ID4gPiA+
IEtvemxvd3NraSA8a3J6aytkdEBrZXJuZWwub3JnPjsgQ29ub3IgRG9vbGV5DQo+ID4gPiA+IDxj
b25vcitkdEBrZXJuZWwub3JnPjsgSm9lbCBTdGFubGV5IDxqb2VsQGptcy5pZC5hdT4NCj4gPiA+
ID4gQ2M6IFJpY2t5IENYIFd1IDxyaWNreS5jeC53dS53aXd5bm5AZ21haWwuY29tPjsNCj4gPiA+
ID4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5m
cmFkZWFkLm9yZzsNCj4gPiA+ID4gbGludXgtYXNwZWVkQGxpc3RzLm96bGFicy5vcmc7IGxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gPiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSCB2MSAy
LzJdIEFSTTogZHRzOiBhc3BlZWQ6IHlvc2VtaXRlNDogQWRkIGdwaW8NCj4gPiA+ID4gcGNhOTUw
NiBmb3IgQ1BMRCBJT0UNCj4gPiA+ID4NCj4gPiA+ID4gIFtFeHRlcm5hbCBTZW5kZXJdDQo+ID4g
PiA+DQo+ID4gPiA+ICBbRXh0ZXJuYWwgU2VuZGVyXQ0KPiA+ID4gPg0KPiA+ID4gPiBPbiBUdWUs
IDIwMjQtMDktMTAgYXQgMTM6NDcgKzA4MDAsIERlbHBoaW5lIENDIENoaXUgd3JvdGU6DQo+ID4g
PiA+ID4gRnJvbTogUmlja3kgQ1ggV3UgPHJpY2t5LmN4Lnd1Lndpd3lubkBnbWFpbC5jb20+DQo+
ID4gPiA+ID4NCj4gPiA+ID4gPiBXZSB1c2UgQ1BMRCB0byBlbXVsYXRlIGdwaW8gcGNhOTUwNiBJ
L08gZXhwYW5kZXIgb24gZWFjaCBzZXJ2ZXINCj4gPiA+ID4gPiBib2FyZHMuDQo+ID4gPiA+ID4g
VGhlcmVmb3JlLCBhZGQgcGNhOTUwNiB0byBwcm9iZSBkcml2ZXIgZm9yIHRoZSBDUExEIEkvTyBl
eHBhbmRlci4NCj4gPiA+ID4NCj4gPiA+ID4gSSB0aGluayBpdCBtaWdodCBiZSBiZXN0IGlmIHlv
dSBhZGQgeW91ciBvd24gY29tcGF0aWJsZSB0byB0aGUNCj4gPiA+ID4gbGlzdCBpbiB0aGUgZ3Bp
by1wY2E5NXh4IGJpbmRpbmcganVzdCBpbiBjYXNlIHRoZXJlIGFyZSBzb21lDQo+ID4gPiA+IGJl
aGF2aW91cmFsIHF1aXJrcyBvZiB5b3VyIENQTEQgaW1wbGVtZW50YXRpb24/IE5vdCBzdXJlIGlm
IHRoaXMNCj4gPiA+ID4gc2hvdWxkIGJlICJmYWNlYm9vayxwY2E5NTA2IiBvciAid3l3aW5uLHBj
YTk1MDYiLCBidXQgYXNzdW1pbmcNCj4gPiA+ID4gZmFjZWJvb2ssIGZyb20gdGhlcmUgeW91IGNh
biBzcGVjaWZ5DQo+ID4gPiA+DQo+ID4gPiA+ICAgICBjb21wYXRpYmxlID0gImZhY2Vib29rLHBj
YTk1MDYiLCAibnhwLHBjYTk1MDYiOw0KPiA+ID4gPg0KPiA+ID4gPiBUaGlzIGFsbG93cyB5b3Ug
dG8gYWRkIHRoZSBxdWlya3MgdG8gdGhlIGRyaXZlciBhcyByZXF1aXJlZCBpbiB0aGUNCj4gPiA+
ID4gZnV0dXJlIHRocm91Z2ggdGhlIG1vcmUtc3BlY2lmaWMgY29tcGF0aWJsZS4NCj4gPiA+ID4N
Cj4gPiA+ID4gQW5kcmV3DQo+ID4gPg0KPiA+ID4gSGkgQW5kcmV3LA0KPiA+ID4NCj4gPiA+IFRo
YW5rcyBmb3IgdGhlIHJldmlldy4NCj4gPiA+IEknbGwgYWRkIHRoZSAiZmFjZWJvb2sscGNhOTUw
NiIgaW4gZ3Bpby1wY2E5NXh4IGJpbmRpbmcgaW4gbmV4dA0KPiA+ID4gdmVyc2lvbiBvZiBwYXRj
aGVzLg0KPiA+DQo+ID4gSGkgQW5kcmV3LA0KPiA+DQo+ID4gSSB0cmllZCB0byBhZGQgImZhY2Vi
b29rLHBjYTk1MDYiIGluIHRoZSBjb21wYXRpYmxlIGxpc3Qgb2YNCj4gPiBncGlvLXBjYTk1eHgg
YmluZGluZyBhbmQgYWRkIGNvbXBhdGlibGUgPSAiZmFjZWJvb2sscGNhOTUwNiIsDQo+ID4gIm54
cCxwY2E5NTA2IiBidXQgZ290IGZvbGxvd2luZyBmYWlsZWQNCj4gPiBtZXNzYWdlczoNCj4gPiAg
ICAgZ3Bpb0AyMTogY29tcGF0aWJsZTogJ29uZU9mJyBjb25kaXRpb25hbCBmYWlsZWQsIG9uZSBt
dXN0IGJlIGZpeGVkOg0KPiA+ICAgICAgICAgWydmYWNlYm9vayxwY2E5NTA2JywgJ254cCxwY2E5
NTA2J10gaXMgdG9vIGxvbmcNCj4gPiAgICAgICAgICdkaW9kZXMscGk0aW9lNXY2NTM0cScgd2Fz
IGV4cGVjdGVkDQo+ID4gICAgICAgICAnbnhwLHBjYWw2NTM0JyB3YXMgZXhwZWN0ZWQNCj4gPiAg
ICAgICAgIGZyb20gc2NoZW1hICRpZDoNCj4gPiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19f
aHR0cDovL2RldmljZXRyZWUub3JnL3NjaGVtYXMvZ3Bpby9ncGlvLXBjDQo+ID4NCj4gYTk1eHgu
eWFtbCpfXztJdyEhSjYzcXFnWGohS2w0cUhzLWMwRU9CUG12M2FvU1BOb09JNHJ5UTA3R0hDaWFG
SVprbjcNCj4gZEgNCj4gPiAtYVlfNTBic09vUzNabUYxYlFwVnQwWl9wZEtBTm9wVHV0LW80Q0h6
bFdXUl95YTAkDQo+ID4gV291bGQgbGlrZSB0byBhc2sgZG8geW91IGhhdmUgYW55IHN1Z2dlc3Rp
b25zPyBUaGFua3MuDQo+IA0KPiBNbW0sIG1heWJlIGl0J3MgYmVzdCBpZiB3ZSBsZWF2ZSB0aGUg
Y29tcGF0aWJsZSBhcyBqdXN0ICdueHAscGNhOTUwNicNCj4gZm9yIG5vdywgYnV0IGlmIHlvdSBk
byBkaXNjb3ZlciBxdWlya3MgdGhlbiB3ZSBjYW4gY29uc2lkZXIgdGhpcyBhZ2Fpbi4NCj4gDQo+
IEFuZHJldw0KSGkgQW5kcmV3LA0KVGhhbmtzIGZvciB5b3VyIHJlcGx5Lg0KSSdsbCBrZWVwIHRo
ZXNlIHBhdGNoZXMgYXQgdjEuIFRoYW5rcy4NCg==

