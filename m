Return-Path: <linux-kernel+bounces-205227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA998FF9A8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 03:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5586E1C21A76
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 01:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B14711184;
	Fri,  7 Jun 2024 01:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="AVtQ9mp+"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2044.outbound.protection.outlook.com [40.107.6.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29992F37;
	Fri,  7 Jun 2024 01:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717724430; cv=fail; b=og7TxGSoHm9D2RtBscKe33+iQ8WWVgOLWhAPUk5oCe4KcrZvAUtmH+qmyc7eqKngs+IYBGCoggpNwWYG8gUR1PfFfRU++csVct9nLX0LX0xdsmjkQqNv0g5TQR1BcDZk+xj+1Oa8ysVhSjmIwwVPnmsPUilqwYrr2QQw3W0X5Wo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717724430; c=relaxed/simple;
	bh=19xW6r4ojTkmJaYgKGT3FAtoY18tE4uWH0TzbEKFNe4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=X/zFnrdNqjk1e1BdtTsiQPjhN+dqcyrI4zCyRIvPEBb+UoegX0eWjUsZnJwkljrWcL6rr43dwKEjQKpnytOPV2TgOTYkloHyV3RcICnPCzm1nHHxNSAPzG7vlS25sN+ogm0/Vb9THHbtN/epK5CRvzNl9BQtT3a1XWr9+/Bcxfg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=AVtQ9mp+; arc=fail smtp.client-ip=40.107.6.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MrU8Ndew5Csj+TWSN/niPk/YZE4oiF6/iaTraRYxai10Ls4B0893DYWoyjMPGZ5UUaPHd3TSOQGJvws/JgnsQsnR9oakvAYrHDoP4WRdSsMuzB2+pGCtor4fplKOViqIMc06mDMUa6aP4pBdL+1uhc3jc1dSomTouQo1cOReqwdYCNN1cwBx8K7RZhcDVOM3B7nxbPKHmRJRubcU6xraExNqQgI7UfmfQuJBPgGCvPnhR/+C1VR34nVcMjYz9bEc7DWJYQ9mh+g8zaEw4cKVHigVzb842x2hiZwL0NHpZKs3GNBsEJo1zIUcekmPt79aMGFH5J3A9PqfNiuXhlf01g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=19xW6r4ojTkmJaYgKGT3FAtoY18tE4uWH0TzbEKFNe4=;
 b=Wz2cwvePDf/YWOCJhd1qSHs8N6kmb7Spv4B7Rc4FiPzZLSsgaXLpiKGWafeHytQGRif725/UuiNJJJ+FIc6A2ts1SKwbgM1lXV6g195Ce0mk7i3s3sdCvzvpHrYZiPXvFPlAEx8LZh3BAYtknK8oGwiknjcRra0UW2YVy8/aaqWZxAkz4y9X7M8SBX0VQHEP914eFW3nrz+2YG2CXAEVJdZvAbRzDgpoGkDijVJXz1vs3j8bh6dv5cTtmrTXWcnTNEu8QsWaYzDbJFVnQLLDyRqcDrthrNK+FhOUXAuxS82NsalabZygI1QcKhUvBRtpYkrlpbeYwJ8hPwOk1i0XOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=19xW6r4ojTkmJaYgKGT3FAtoY18tE4uWH0TzbEKFNe4=;
 b=AVtQ9mp+YNns14TsmxfEEaGBkijcZiJOcLhokegUZXUmYqWjpQWFvkvYnU3kF3QpErj64XvkqAV10q7yo7KT6EJq7UUCE0iJIUmWJ9EIngbgwT6XSQjd0LGnl0xRtLaCzgTWxPGETnU0RgIk0x18OOPq78aLytuDzDKeer8tYlM=
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
 by AS5PR04MB9798.eurprd04.prod.outlook.com (2603:10a6:20b:654::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Fri, 7 Jun
 2024 01:40:24 +0000
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256]) by AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256%5]) with mapi id 15.20.7611.030; Fri, 7 Jun 2024
 01:40:24 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Frank Li <frank.li@nxp.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
	Aisheng Dong <aisheng.dong@nxp.com>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Frank Li <frank.li@nxp.com>
Subject: RE: [PATCH 7/7] arm64: dts: imx8qm-mek: add usb 3.0 and related type
 C nodes
Thread-Topic: [PATCH 7/7] arm64: dts: imx8qm-mek: add usb 3.0 and related type
 C nodes
Thread-Index: AQHauEI0IBBuxlXNWUqxNI0/NtzMa7G7hbpA
Date: Fri, 7 Jun 2024 01:40:23 +0000
Message-ID:
 <AM6PR04MB5941A72E8BD0363A185B2A3E88FB2@AM6PR04MB5941.eurprd04.prod.outlook.com>
References: <20240606-imx8qm-dts-usb-v1-0-565721b64f25@nxp.com>
 <20240606-imx8qm-dts-usb-v1-7-565721b64f25@nxp.com>
In-Reply-To: <20240606-imx8qm-dts-usb-v1-7-565721b64f25@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB5941:EE_|AS5PR04MB9798:EE_
x-ms-office365-filtering-correlation-id: 35f7741b-259c-42b1-ac5d-08dc8692ccdf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|376005|1800799015|7416005|366007|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?eWtSeUZiVDlZaVR4R1VPaGlnNjJPdHV3QWFsYi93eFZjZjBaS3Y4bkdzWGlJ?=
 =?utf-8?B?K0VEd2FuUVc3Q3BZK05kK3Vjdmd6b0hScnRITVUyZE02TFdSNmw0QVAwblVH?=
 =?utf-8?B?MzBuckh2WmJQb2pxQkE3NmJlOWlxSkpKMFJXa2h3azJta1Z4dUZGZWx0ckJh?=
 =?utf-8?B?U2hxQXdSRVBIcnh2M3NjRUZhcG81WUp2ZW1MN3dxQ0gvUmgzY0diN2h6VnRU?=
 =?utf-8?B?dWtQRWZpRG1JR3FEWmVFUVFLOW5xK2h6cnZyU3h0VGI4cExQQk9PZjFPRXBY?=
 =?utf-8?B?UThOUGFrck1kYzdVVVppUGVzTjRycEdQZDVQcXJ5YldzZEh2Zzh1YzhRVUxP?=
 =?utf-8?B?WTBCNnAwNXB2Z0hlUFZGMkNkUVhWZmZHb3VoWDVXMDlyUmc0MXBCQWs0Y2VG?=
 =?utf-8?B?cFhXRGRVaXBWOTJkNm1YeENjcUFmTFlRYmtTN3V6c0FuVGxzKzl1eXNKaVA4?=
 =?utf-8?B?QkV4OG1rdkIrZ090UG1ldWJIZ2d2bHowSVBnU2dqK0pVR25UekdOeGRldzky?=
 =?utf-8?B?Ykc2UkJvNXNFdWhLTG1kUnJEWVBmbVRDUmVvS1doN1lKQ3dCRFd0ek44SXFi?=
 =?utf-8?B?VHpzNzJudzdiNXc0OW9NUUhRK0dLeXY3ZzZ4MVdua1p3OHd5OHdTQTBxazlE?=
 =?utf-8?B?dmIzMUQ2K1BkdGhYV2VaVElGNDFTSSsxVk5sdC9RWFgya0F3MVhiMHg4NEFk?=
 =?utf-8?B?Vy9TSUgzZWJsR0ZlS1dQZkh6QVNJZCtoUjdlUnk2YXlvWnVibHN5RlgrWm0v?=
 =?utf-8?B?QkNyT1lHbFVEV3FLOFNHaXdsdDM3NWI0QUN3UTZSaDB4VnBuOFM2ZjRtTjhS?=
 =?utf-8?B?UGVTZDdISjVaNGlIb1piandLb1ZmVURKdFI2ZW42VmloM1ZOWGZYYXZoM3Ry?=
 =?utf-8?B?MXNrUFdMZllvbGxEUC96U0ZTSDdhaEJrTUtrRDFrR2V5cWR6cGUyY3NSSlhq?=
 =?utf-8?B?dER5MVhCOVVxcWZyMmEySkFBZmVUMHExQ3pxSVRoSklIUjJsbW5JT2psNWpU?=
 =?utf-8?B?NHk2TWNIWU9xeVlqbkRrZEFFNFZvN29ocXRRSENlck54TVZZdkRJbFRNeThM?=
 =?utf-8?B?T04xMGtYNUNJVEU5ZjRhcXNjN2lNeE9EZmMvYVhSWmhOaGlRSmJSczZBdHJ1?=
 =?utf-8?B?eElwbWwrdTExSkFxbHJzeHlKejFoamIzSUJlRmYvTnZhWWo5bGY2SnZveTdW?=
 =?utf-8?B?SklsdUJweVhmVFEvWE0zTWVPWm5leHdHMXBXbnR2aDEwNEtYM1FPcHRhN1Rk?=
 =?utf-8?B?dVRVaXBDUVZYaGFjM1NvT3pTZVlqZjUxOHNmZUtYVHNHNkkyTjc0MjVqL3Yr?=
 =?utf-8?B?c0g1ak51MmJFUDVnNE9ZaGVlZktyNlpEdG0zS3d4Ykk1ejFVQ1FackkyMmo0?=
 =?utf-8?B?MmFxZ2NKdmd3MVhtUkFrYlplcnFXL3JWekNoK3BDd2NubE1vQS9YVStCd2pN?=
 =?utf-8?B?Z2NRWCtyTi93RWE1N0ZWaWRTK2E3UC9NTm9jL2RjUzJYcDFWNU1pQUV2NjY0?=
 =?utf-8?B?ekMyT3c4ZElmdFJtd3JuMEZ2S2ZvRlVqKzlSbFRVQndaMW5NdUxzRi9heksx?=
 =?utf-8?B?aFdyM2xidUZJSTRFUUNpNW5jOS9BWE1vVEs5SGN2RDBCZm5SUWdCNEtGL1dT?=
 =?utf-8?B?OE14SmxtenE3YTV0UjRCRy96RE5sWXlkZFljamQ5SEVqbDlOVkMzZ293ZHZi?=
 =?utf-8?B?aDVNYlBDMTFFNHJDdW5qaHpOS2ZGNTF5MlhwblNBQTFocDJ1U01LdTZLYkVU?=
 =?utf-8?B?UjBkTTdCQmZrcXNwdk1PNlkzbVFoN0VMWjFYS250TG1LaXlQVVN0NnBJdTNJ?=
 =?utf-8?Q?VBSJeF2l7rbmhLgUaPgl0bPpLrVd/xVFrTDi8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZXlzQU9JamM5T2VaVnlTbStzR0ZIYUpGQXVieTRRUVhDUXY1b3Bka0lWekl5?=
 =?utf-8?B?NS9ONEU4NmtPN0xVSmI3Z3lkemtBTEE1S2FXSDZzVjZueDJCdGl1K0tQdzh3?=
 =?utf-8?B?a3hKRTJYa1c4bjk4OEdCamNFZng4U3pXZGx0TlluYnhuVnRxR1RSd291bnpL?=
 =?utf-8?B?NFA0SGhOeWVsNm1RbHJJS0RiSHhNaFpyajVNSXA4aHRzQjExdGJrc2JWNnM4?=
 =?utf-8?B?Z0lFR1VycUhpeUhxWGVrZU9OZ0FYMk04VXpSek9mVHA2b2JDNnUrVUMxdFZy?=
 =?utf-8?B?TVk4aytRaXBHMnBSLy9jWDZabTVJbzlObTFXckRiSWk2SHdja3ZrWU9lTkVm?=
 =?utf-8?B?UTk5Qk94TEFpWGVwZnc2OUhLUU5mbnpyWGd0bmlxbEE4aVJlRU9IK3pJenVZ?=
 =?utf-8?B?ZEpMajN6Z0ZCOStyMTBGYnRCNERzM1pYMzVLMGwxMFUzZVBGa0ovUGVCYVUy?=
 =?utf-8?B?VmNpRm1KK09DQ3JPMFBBSjdSQWtJSDlRRkVrNmY0SGU3TnlkUzlOUXVMSHVC?=
 =?utf-8?B?UGMxVGZKVEZsNG1nbE15MFFXbW9mWDRFc2xIR3B5Q0hQZHV0aUNDR2xmUDBJ?=
 =?utf-8?B?QVp3RWI3VCtEV2Y2aW8wMUpUQXI5NXk1MkR4UWxJUi9JL3NPdjhNaVVFQjYy?=
 =?utf-8?B?dnpwbGJRdDA0V1E2eVZyVU00dVNqcjRPbWhncHNZcVdFZVM5OENKRlczL1h1?=
 =?utf-8?B?MVpMdWc4aUF1a1VybFg4cXdabCtCL25DWjZhT0dJNllSa1h4cjNBL05vZlkr?=
 =?utf-8?B?VHozNmxyZGdRNkRmTjhzc1B4dVVuSnFXK2RndGptV2hkN1lVVmdMd2hLa1dm?=
 =?utf-8?B?ZmVaSTMvc2ZBN09LS0NRa2F3Z1MwVUg5S1lIUC9UMVEzbmNkTVQ5REFSQkVU?=
 =?utf-8?B?NnlsdDBFTm9aWXMzcGlSRGdyU2x1U1FvazJ5N0JCaFk0YWt5OFp6TzFET0Zv?=
 =?utf-8?B?WUdEUVIzbHY2YkgyYmRDbW9XRCs4NTFSUDU1Zng1YitqRFBnM01JdUVtb05W?=
 =?utf-8?B?ajV2alZnVGVSaUxZUXhJYmJ5NGRrelJPa0h3RDdNMG80Qy9pRmN4cVJWaXVH?=
 =?utf-8?B?NG00RG5oQzdFUnhxUTV5c3lDM1djb1g0UmpyVHdHQ0wyTmpWR0VQQlFLb2tH?=
 =?utf-8?B?T0pwVWN3MVVlVWZhcDRzV1N3b2wySXJWMDBsQjljQlYrcEVyOTJMaUJrVXFE?=
 =?utf-8?B?RG5VTEdzMk9hOFB2Y1B0SnRoV0wwdzk4T294YXY4enZ0blZqTk9hVk1jOVJW?=
 =?utf-8?B?NFluRktpM3F4eStlajNPZGRmZGRpM2F6Q2cxSVhzN0YvTWVPYURsRkRFMHhz?=
 =?utf-8?B?WVVCemtJbUM4TksrY1BMVDdNZitFNUU3NU82d2pXSWlIZzV4U2pxdUxjNHFK?=
 =?utf-8?B?a3pad1lQTzhoejRGck1UeXZEaENZbjhETEQ5UDRxTWRYa2dpUGdhSXJ2SUY0?=
 =?utf-8?B?REJpdmxFcDZvQUFseFVkWHY0MjludWJiUGhUeHRKeTdPMzhjdUF3cldBYXJZ?=
 =?utf-8?B?a2JEQVJ1S1VMdXhFR1RCSmVnbmxDdnQxdVI3WUl5ZTBqS1RYblpPWTNZR0VJ?=
 =?utf-8?B?MXg1TGJKNVViME02dU1jN1JWbG9UQTJwY2VGbzllc3ZTQ1RCOTlEVUlFRjlz?=
 =?utf-8?B?dWt5UktWRzErNEVKMDRMMml0Rmc4YzlWT2RhKzZPOVJmelJwcEQzcVZPZEZG?=
 =?utf-8?B?OHRxcS9vc0loS3lacWxxZVNobld4Nm8vSGR2TFptMUZDRDgxczFVRGdGem00?=
 =?utf-8?B?QU9tbE1TaERXNnlMTTFCcU9BRVpDSW9xNFV5aU1UYTIvM3hVSjRROHI3cEdO?=
 =?utf-8?B?ZkJjYjkyak1VUHFXeEFQQTFUNHAwdkxHK1lUbmNUOENvR2JlY0pSYnR0N0l3?=
 =?utf-8?B?em9sS01FN0JTUFl3bStKd3JKbkV5SzcwMDNmLytQNDFid0ZiVzVUUjlwaWoz?=
 =?utf-8?B?VU9BOWptYTk2R0VSVDZRU0N6SjVzWks4L1MxdnU3eFRPVjdTQ0FqVWMzZzlP?=
 =?utf-8?B?Tll0NGlLWGs5K2duQ2c1M3FQOTF4bzhwMGVFbTZWU1JydFR6SnJuZkNuMXdw?=
 =?utf-8?B?YVgvS1lSNVVZM3BCNDRLeWFTV2tyVXNBWkhiZWdlRHBqVkhmM2NjV0Z0T2V1?=
 =?utf-8?Q?SRt4=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5941.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35f7741b-259c-42b1-ac5d-08dc8692ccdf
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2024 01:40:23.9927
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MnGkLS1iMGv3ZxBm29xPeGtDzp6Elc8OuPgTVdgNhysK/fWeKLoQ/s5okgkI91VyPlJzmu61OmX3w3NopQC9ZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9798

PiBTdWJqZWN0OiBbUEFUQ0ggNy83XSBhcm02NDogZHRzOiBpbXg4cW0tbWVrOiBhZGQgdXNiIDMu
MCBhbmQgcmVsYXRlZCB0eXBlDQo+IEMgbm9kZXMNCj4gDQo+IEVuYWJsZSB1c2IzLjAgYW5kIHJl
bGF0ZWQgdXNiIHR5cGUgQyBub2Rlcy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEZyYW5rIExpIDxG
cmFuay5MaUBueHAuY29tPg0KPiAtLS0NCj4gIGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxl
L2lteDhxbS1tZWsuZHRzIHwgODcNCj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiAg
MSBmaWxlIGNoYW5nZWQsIDg3IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNo
L2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4cW0tbWVrLmR0cw0KPiBiL2FyY2gvYXJtNjQv
Ym9vdC9kdHMvZnJlZXNjYWxlL2lteDhxbS1tZWsuZHRzDQo+IGluZGV4IGRlZGNjMWIxYmYxMmYu
LmY2ZTJmMTU3M2Y2YWIgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNj
YWxlL2lteDhxbS1tZWsuZHRzDQo+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxl
L2lteDhxbS1tZWsuZHRzDQo+IEBAIC03LDYgKzcsNyBAQA0KPiAgL2R0cy12MS87DQo+IA0KPiAg
I2luY2x1ZGUgImlteDhxbS5kdHNpIg0KPiArI2luY2x1ZGUgImR0LWJpbmRpbmdzL3VzYi9wZC5o
Ig0KDQojaW5jbHVkZSA8ZHQtYmluZGluZ3MvdXNiL3BkLmg+ID8gYW5kIG1vdmUgYmVmb3JlICJp
bXg4cW0uZHRzaSIgPw0KDQo+IA0KPiAgLyB7DQo+ICAJbW9kZWwgPSAiRnJlZXNjYWxlIGkuTVg4
UU0gTUVLIjsNCj4gQEAgLTEyOSw2ICsxMzAsMjEgQEAgbHZkc19iYWNrbGlnaHQxOiBiYWNrbGln
aHQtbHZkczEgew0KPiAgCQlkZWZhdWx0LWJyaWdodG5lc3MtbGV2ZWwgPSA8ODA+Ow0KPiAgCX07
DQo+IA0KPiArCWdwaW8tc2J1LW11eCB7DQoNCnVzZSBtdXgtY29udHJvbGxlcj8NCg0KUmVnYXJk
cywNClBlbmcNCg==

