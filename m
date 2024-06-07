Return-Path: <linux-kernel+bounces-205217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4AFE8FF992
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 03:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EE0C283552
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 01:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5154B101D5;
	Fri,  7 Jun 2024 01:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="b6v6lrRx"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2041.outbound.protection.outlook.com [40.107.22.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB45C320E;
	Fri,  7 Jun 2024 01:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717723873; cv=fail; b=lSuW0wAEIIlA5HbvMweqzQa79nngZCUuWMAnXf4B32iInijbL5Hsp1obtEK2Izu2Ci+QDpbjxWGgs9n2fgS3ptqoYUAx1AOyLNgGjq9PgKNfUNwZzucAKTJ7CeDP6LoxcR0Msv+XjGEojczAU5xyQYJcS+/8SE1XhzVu7Qf44HM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717723873; c=relaxed/simple;
	bh=GEtm3OQd9RH4+D2Ai/gzHUDgxCRzg9LHZ43LOU5WHBE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UXWNU13ZbjpHn62nUNMjg24rIvRW9rUhNvXLw1Jymv5KgvHniTGsqdRfj+p0NeWhtTY5z4FlQEyHR/t2CCduA7CrCP/h1ozYGQxhQiv8OfQZhzn4S2OBlOJc06v3Wztv9/HbjKR4Ngv0kzUmV7z/qvw1HQpCnXwl7V3btpJh78g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=b6v6lrRx; arc=fail smtp.client-ip=40.107.22.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dQIIhW3yqSb1GV4xDVonvIRaJKRbXSjJnoTLvVvQ4HxO6nrAdqAfiqR+eUPVL1AguUqL7OojugHXFriL72ml0XRuf7vwBxooDGgyGYZhrrJThOvczwxFvpVtEiDrjR/2kYojgWhZFllpA55jeV6+P/+PFYljXqiaIi7kRh55iuqQ5YDckVr/saog1tGgAxSSOh0nTdn1qNL6gxtnfc+8lKZprmKxt6w+aTNRaEJ+G83R8+gv9R9/Z0P/t4h3NyCJvRtGunxTCR2IsF6Xv4I8JIomZfaQODQ6844wXp6ldLdEb1/rW+0C6cDV8A+zx7oL6gabIq8XK15/tNqrZbx/ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GEtm3OQd9RH4+D2Ai/gzHUDgxCRzg9LHZ43LOU5WHBE=;
 b=Dghla0shKS2IEwq8ftTI/XzBIP0+5jwUldb6Pedghf6w1A1ZQ2T7+/A7fS124/vq/uYH23N2NDzNDb0sJjK5uoe78HoXNxBDFyaotXl0Z06qfK9owm1bfZ9GH5zcbARsJJWOfyaqBeYRxwvqBZxpvJf3G+ik1lZ8as/0z/vcNSCNG1990+lqaa2Qzd/C6+3rgTCHbs48/KV5xwZJ4I8uNkvmFRtaIM/6prX+p/Nlkn4+CVv604kQqSr01nOXYMlHLb2OJFofziBiOdWC/ZYetlIYXhD8T5oSxkCyDO/bPqAGw5a0Y0bnbClf2o2Ynm+JGgd8Tzp8l7/rwvWcZ3JZnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GEtm3OQd9RH4+D2Ai/gzHUDgxCRzg9LHZ43LOU5WHBE=;
 b=b6v6lrRxvkLtj4hwkB7WnsX2jsY6hWmirB4IxcRXqV18sr7nCNtMnf2z05TFqOpCUJc4WcK5Ncnrf5BF1yEB52BGLVPO39Ne7S1LxpMRMkNxdl372Ddtg3qKKn9KwNyYDfnpZvc8/7QqrzsclKK6NTVoKzvJnnsjoDP24VQ3l8Q=
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
 by AS8PR04MB8326.eurprd04.prod.outlook.com (2603:10a6:20b:3ff::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Fri, 7 Jun
 2024 01:31:09 +0000
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256]) by AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256%5]) with mapi id 15.20.7611.030; Fri, 7 Jun 2024
 01:31:09 +0000
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
Subject: RE: [PATCH 2/7] arm64: dts: imx8qm: add mipi subsystem
Thread-Topic: [PATCH 2/7] arm64: dts: imx8qm: add mipi subsystem
Thread-Index: AQHauEIDj0w9Cm3aTEO16QZu6LNjcLG7g52Q
Date: Fri, 7 Jun 2024 01:31:09 +0000
Message-ID:
 <AM6PR04MB5941D94177D93AA22FD452C388FB2@AM6PR04MB5941.eurprd04.prod.outlook.com>
References: <20240606-imx8qm-dts-usb-v1-0-565721b64f25@nxp.com>
 <20240606-imx8qm-dts-usb-v1-2-565721b64f25@nxp.com>
In-Reply-To: <20240606-imx8qm-dts-usb-v1-2-565721b64f25@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB5941:EE_|AS8PR04MB8326:EE_
x-ms-office365-filtering-correlation-id: 2d818b0b-9a8b-4fd5-1375-08dc86918228
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|376005|366007|1800799015|7416005|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?NC9JUmFmdm0zclU1b08ycG04UHJFQ2pESThSc1BVSGh4YXo2QjM4WjlqSDYy?=
 =?utf-8?B?cmZVSHFYVjN3aWg3LzdhSlM4MkY3cUgxVndIMXpSUDJ6TmVGcDNZRFQwT045?=
 =?utf-8?B?Z1hURDg5S3g2eWw4UENpcm84N0NBOHlxM1dQZ082bFdUaWJEOThqZnBFdEdZ?=
 =?utf-8?B?UFlHMjd3N2JpUGZXMkpZK2dxZENxQkNXMlBoODZMcEpnV1dWMEpPbFc3R3ZI?=
 =?utf-8?B?SVJzS2RvTnJPTTJiNVIrYm9HL1dQOFdCZ01maWhFZkh3WnBLWmN0V01HZ0xF?=
 =?utf-8?B?YVBFQWtJeEJPRXVzc0VkdFJNUDJnN0VEemI4TWJiRjZjMHNERGcwV0M0NG1m?=
 =?utf-8?B?NGpxS1JHaE1xODVSems5aHU2cm1lQ2lkWXBxZnBVK3BDSE5weGo3bWNNaGhX?=
 =?utf-8?B?Z1JRRkJxZGVNRTdqUE5oa0ZodFZuMDBHVTBTU3hxdVo4c29RNjF3cGFSZ1pm?=
 =?utf-8?B?L0ZNQXUzbC9hdEgzckhPNjZjekl6VTJUdnZkamt3b2FLRTZhUE9Ic1FncUp6?=
 =?utf-8?B?WVVyeG1TeFdCa1UzbmJ3NzE1aGNGQVNIb0R3Z2JnMVlNL3hObTdlWEtGcmVJ?=
 =?utf-8?B?RVI5Nitxcm5IOURsUXpkWmNyMEFMNDk0Q3VDeG80WVRrR1ZKanVVMWVxdVln?=
 =?utf-8?B?OGhxQThCRUtBUE15K0hLN2hpamF0cm5JY0VtVE5wMlltbUNma0IySVhKRGFn?=
 =?utf-8?B?K0U5N1laMk9nWTdqbVQzSFBsUFZ5VndsYzdpL3RhclRya2xjSFJYSjJ1b1ZR?=
 =?utf-8?B?VmIrNTdKb2MzZWxWRVdoNnViSXdHY1VheVd0c3BRV2Y0YW15ZVhMTnh1NzNa?=
 =?utf-8?B?aHNiN1cvazNFNjJmM1VWTlorUDJhUGZhRnY5SHpCb2hjM1pheFhZbXp0bGNp?=
 =?utf-8?B?TnlYSzlpcDZBblR6THZvNWkrZWxTN2hzTFo5QkhoTU1uM3QrWXh3cmUzeUJz?=
 =?utf-8?B?aWZiV2JtTDZaL2NDUThLNVBwckJ0anY4QXJCV2srWmJxM1FvSUxnZVhyT0ht?=
 =?utf-8?B?UWFReThBTHlOUWVRd01BTk9oaUMrL3N0TGhQd1ljWVJoUlpSazd2U3RsTXFI?=
 =?utf-8?B?dVUwZXRqdlVTQ25zTWM3d3JvWTAyT1B5MGE4ZzA1c3BUOXFlcnFoM3NyRklJ?=
 =?utf-8?B?ODgyWG5qTFdtZ3RqYlhkUFB0REdKeStWQm5SSG53cnFGVzZPTmVHZGN4bFNi?=
 =?utf-8?B?VG5mREkvUlFQOHFZc1Q0SStwdFg1cUF6QTY3SWZnQWZwOWtWbUpkMC9lRG5q?=
 =?utf-8?B?ZzY3UnU5U01FSlVwZWFycnIrT3hIaEtqb2kvMUUxbTNRMTI3TGJpclFqOUt1?=
 =?utf-8?B?VEZicUd0MUNvMjhmWGR4YVpuSDc3WnVSVUltcUlZTSszV1Vra0cydTBheWdM?=
 =?utf-8?B?Q3BlbW5RMGtGRVlLanp1RkRzOHhHaE5GOXhLVkVNV2VaZDBIV3BmZDFLNGll?=
 =?utf-8?B?M2F1R0hJblJ5aG9OT0NSSHpEWitXRlJiSTF2c1VMS0ZQaERpZ1h1NWRmdm41?=
 =?utf-8?B?d0JNaEN6ODQ2b3FFUDNSUHRpNFYvdWJ3QXZycFdzaVFpTWxRY2tWR0g0WktV?=
 =?utf-8?B?a005T2luUnRwWGw4MTV6UVFFRU5sVGpMbWVPemk2a3dydkpGb2J5UmdDemds?=
 =?utf-8?B?T1JGdTd2eks0QkdRckU0YXdYMElqN0k4aFpVeXpDcTRsUC9HSExud3RXd29a?=
 =?utf-8?B?VkcwTHVJelNNRWgrdVIxZ2pybktvZ1VTV0hBZ2syOVgwUVJnaHlwQkUxdWNL?=
 =?utf-8?B?ZmQreWgzN1Z2WkJqOHR4TTd5MTI3aGFyL0YrSXFlckVLVlVzNEprTmMxamth?=
 =?utf-8?Q?K0biomBgMciXNo1DW9hclbTTZmODRhbTOqgMA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SVh2NG8rNERqdEZKbEhDOHI1c1ZqeGwzVUgvN2hObmRocEdMcjVNREJvUzQ1?=
 =?utf-8?B?cFV1NkgvTTM3Mm5kZXNRdkY4NGtXUUZJWkkwZzhsL1NJVWQ0Y0ZnVG1IWGpF?=
 =?utf-8?B?ZmNnODRvSGZ1T2M3eVFyek5GK0RyTUpuU1NLSFlMV0dXdzdXWmNIaU9wZ3Zx?=
 =?utf-8?B?b3A0STN2OWtIUHFBMWhzZTF4ckxjell5UEsyQWJCRkFibjNMbXFBWlRkMEJo?=
 =?utf-8?B?WC8vMFdCUHViREI2NE85eDdKVzE1WlBZZThxNnZBRXJCL3J5dmZ0UkdqQnU0?=
 =?utf-8?B?SysxYlhxNVNFM3VrOWw4bHBRcGV2Rmd1SE1PY2tSZWE0WkNrNVdoWXVDTE0r?=
 =?utf-8?B?T3owRGxhYXF1VUpzRWlSS0RoalMwenhKNXBiNzl2ekU1c0NxSUZOMG12OVJS?=
 =?utf-8?B?Z3ZhWEdDVWw0UE9CQ3JkMTVuY2JydTNrV0F6V3d1K0FvdGtMb2h6cXdBLzA4?=
 =?utf-8?B?UjJnRUlPUDcvUHhYMkl5VlFYNFI1YnhMU0czN0NOYm4raHVhenRwY25SZS9u?=
 =?utf-8?B?ZVpZYkduTnRQY1dIaXhJTmRDZlAyV3VvNVpNRSs4U0V3eUg2T0ovajVpblJH?=
 =?utf-8?B?WEJocmZpdTk5Q0xtaEVFa3lRMHNCUEcydTBsWjB0eXppSlU2NmZ4RkFPYlph?=
 =?utf-8?B?cVQrcGVtdGpndkdVV2xSV0owdEk2Z2NDTm5XWnZhUnJBSlo0Z0w0TmdhV1dT?=
 =?utf-8?B?TmxzYWlUd3hQZ3VYcVkwTHhiQng3bmY3Z2pHTzdtd3dYc1ZsZ1VkYnZ5blJk?=
 =?utf-8?B?ekRuT0JUS1BaWGJSY1lCZ3EwZlMrTVJ4dWxCa2dOSzh5OE1UczhCamlvVisz?=
 =?utf-8?B?NGJnTzVHQzYyeU81UWJ5VUtxTi9HYkZVbmlaSXJwVytjcUJBNldqMkRnVUV4?=
 =?utf-8?B?QWV4anJoOGVHRU1CQ0w4TktLRzJXK2lhOXIvU1ZqclVsVlV0UVA3UEF0eE9i?=
 =?utf-8?B?QnFvdXE3cjdaSWNFUkczUE5ncGRRZG5odHBJams3aElrdTdIamV6cUw2S3FX?=
 =?utf-8?B?aVJaNU1RSDFlYkZGUkJoLzZHYStZV1UyUTFZWDUvVnBCVWdKcGRCZDhLeFpi?=
 =?utf-8?B?czVYZ0J0dUJoUVp1b0pFRGZrUG1KR1lCaVlMcDdkbXQ0bkNlNzFVRW1xdWlP?=
 =?utf-8?B?TUpxeFJxUVlIQndFYkFoRFB3ME1adGRhOTdEeXFDTVJPQldIeHBRbWd3SXZR?=
 =?utf-8?B?V2NrNU5CS3JPcFIxelpmdUtrcDBmVWlseE5lb1RxTTlSOFVpaVlub1FvQ0V5?=
 =?utf-8?B?U2d3eFUrK1huSVRnd0Y3UXAvVnlRdjlTNDhOeU9sdEx1YzM0SFphcTkrSVNX?=
 =?utf-8?B?UkVlVVdqb2xmdjJaMWF0bVVRMlhYREVKejh0OTZEc0tYekg0R0NGNjhtOXl4?=
 =?utf-8?B?S0g5elcrazJvK0dFVHZ1Qkc4cnhFbW9VaHRjVkxpWVJ0UGZPZEFhdExLY0t4?=
 =?utf-8?B?S0gwKzBVSTQyUWV0eUVqaHVybmcvOFFaeDJFdFlSelFJL2hUbi9Uc0ZhdXBa?=
 =?utf-8?B?TlY3RFAwS3l0cE9JaFpiUGI3RTJVQXROMlJ4SytSUHJFdldGQlp6TXdFUlEr?=
 =?utf-8?B?QUhNUDg1SS9FcGRzM2RsU2VRaWQ4cmlWOUdrYW00NUQxWndPblZsOEVSdmtX?=
 =?utf-8?B?KzVtRzEwN0hVMlRabWY1a3hOOHZiVTg1TG1GNkJsdlhmM3AxVkp4TDBTR0hw?=
 =?utf-8?B?cC9Ja0Q1cnZSSEE2YVczcUxmajU3UmpPK1h3QktvUUxMZ0ZEdHA1K0Fwa3k1?=
 =?utf-8?B?YVA5cGxGbTB0V2dRYkd1STVLVUxPYVBUNE1jWVpHQnVrUHE2UXdiV0k4N1Zv?=
 =?utf-8?B?dWozSCtDaldCU3pzVnBBMm1HM1I3Q1o1UWM5Rm9DK1N4WXh2Y2QxUHZsSU5D?=
 =?utf-8?B?dm4vMlpIbEtDUk9pV2U1LzFKWXZQVzNWRjJrM0QzWVQxakxyOGNucHdvYzRv?=
 =?utf-8?B?M0VYbzdpZW1ObjFHNm9hSVlDaERwaVBveVM0L25SR29jVjVDNVN5Rno2dHpU?=
 =?utf-8?B?TnBaZHF2OEUrWmp5S05oWHhNWU10NHI4czRMR2YrbHpna0JQcVluMGU5K2pO?=
 =?utf-8?B?Z1FUUWNFYUNtNlcxM2Z2YTQ3R051eWJEcXZueXBBMHlJamZQckJsM3hXWXY5?=
 =?utf-8?Q?csZk=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d818b0b-9a8b-4fd5-1375-08dc86918228
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2024 01:31:09.1229
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VNf40BO1Vl1UQSgXYEP/bHLN6rZtmdkY/iC5ejwe/Ed4tDjhFBjHE142coaK5NvhkGyNBDVzTAAIafmMbg5ExQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8326

PiBTdWJqZWN0OiBbUEFUQ0ggMi83XSBhcm02NDogZHRzOiBpbXg4cW06IGFkZCBtaXBpIHN1YnN5
c3RlbQ0KPiANCj4gQWRkIGlycXN0ZWFyLCBwd20gYW5kIGkyYyBpbiBtaXBpIHN1YnN5c3RlbS4N
Cg0KaXJxc3RlZXINCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEZyYW5rIExpIDxGcmFuay5MaUBueHAu
Y29tPg0KPiAtLS0NCj4gIGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhxbS1zcy1t
aXBpLmR0c2kgfCAyODYNCj4gKysrKysrKysrKysrKysrKysrKysrKw0KPiAgYXJjaC9hcm02NC9i
b290L2R0cy9mcmVlc2NhbGUvaW14OHFtLmR0c2kgICAgICAgICB8ICAgMSArDQo+ICAyIGZpbGVz
IGNoYW5nZWQsIDI4NyBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02
NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OHFtLXNzLW1pcGkuZHRzaQ0KPiBiL2FyY2gvYXJtNjQv
Ym9vdC9kdHMvZnJlZXNjYWxlL2lteDhxbS1zcy1taXBpLmR0c2kNCj4gbmV3IGZpbGUgbW9kZSAx
MDA2NDQNCj4gaW5kZXggMDAwMDAwMDAwMDAwMC4uYmQxODQ2ODkyM2U1Mg0KPiAtLS0gL2Rldi9u
dWxsDQo+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhxbS1zcy1taXBp
LmR0c2kNCj4gQEAgLTAsMCArMSwyODYgQEANCj4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVy
OiBHUEwtMi4wKw0KDQpHUEwtMi4wLW9ubHkgYW5kIE1JVD8NCg0KPiArDQo+ICsvKg0KPiArICog
Q29weXJpZ2h0IDIwMjQgTlhQDQo+ICsgKi8NCj4gKw0KPiArLyB7DQo+ICsJZHNpX2lwZ19jbGs6
IGNsb2NrLWRzaS1pcGcgew0KDQpJbiBwYXRjaCAxLCB5b3UgdXNlIGNsb2NrLWNvbnRyb2xsZXIt
eCwgbm90IHZlcnkgc3VyZSB3aGljaCBpcyBjb3JyZWN0LA0KYnV0IHBsZWFzZSBhbGlnbi4NCg0K
PiArCQljb21wYXRpYmxlID0gImZpeGVkLWNsb2NrIjsNCj4gKwkJI2Nsb2NrLWNlbGxzID0gPDA+
Ow0KPiArCQljbG9jay1mcmVxdWVuY3kgPSA8MTIwMDAwMDAwPjsNCj4gKwkJY2xvY2stb3V0cHV0
LW5hbWVzID0gImRzaV9pcGdfY2xrIjsNCj4gKwl9Ow0KPiArDQo+ICsJbWlwaV9wbGxfZGl2Ml9j
bGs6IGNsb2NrLW1pcGktZGl2Mi1wbGwgew0KDQpEaXR0by4NCg0KUmVnYXJkcywNClBlbmcNCg==

