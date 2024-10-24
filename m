Return-Path: <linux-kernel+bounces-379510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBBCA9ADF84
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 10:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 957FF280D3D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 08:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E54E1B0F2F;
	Thu, 24 Oct 2024 08:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=newgenag.onmicrosoft.com header.i=@newgenag.onmicrosoft.com header.b="TDwqnn8i"
Received: from ZR1P278CU001.outbound.protection.outlook.com (mail-switzerlandnorthazon11022101.outbound.protection.outlook.com [40.107.168.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9040D1B0F17;
	Thu, 24 Oct 2024 08:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.168.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729760052; cv=fail; b=jDKYKbjI1+QEi33V/Tq2ZmGkruwpypEhgvlApugik09M9ngr5opupgKkw6CTgO4beOycpzHyiEjCbkNpFRudC5IKuO3LNOMKYdnUYQVd/AqxTkLjA63y2FnIS8w7q4ck1xCtw9gGFmX68O8CEIMhRa3reAo2iyFvA8uH46E14yM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729760052; c=relaxed/simple;
	bh=mtObSPaP60+qfQFFkD45QL5c+0Lv9rFE74magWHsluA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dDrfDBck++2zY3OxQqKF4RS2GjvzxgDf10D/5F4gRPeHwSwstLAIO3TtSy4anOWPr4LILLp9jCCTzEpo2WazVNsMH3qeqAxorZVAAqr9u5uLJQnpMzvx3NY8IU7ucALbw9auQpcdCU3M5txBDdlNkLneH7RF/OJE35UWkfgYCrU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mbv.ch; spf=pass smtp.mailfrom=mbv.ch; dkim=pass (1024-bit key) header.d=newgenag.onmicrosoft.com header.i=@newgenag.onmicrosoft.com header.b=TDwqnn8i; arc=fail smtp.client-ip=40.107.168.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mbv.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mbv.ch
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cgAlhi+oCUI0Ayt/ZD+oXVaD8EqDqiRtPxussEHxT/jjoyPVQWkc8CyYV8bJ3Q/5kAbWXoKY261fUSxzPxDd1Kcak16bt41PeKZ7P8JRJH4W+TSj9QuJ/qIhvAXdo09EksjRnpM+Ol47kHqK1QTtj6N0eeV2SUVEsL+W8G4f+yY49bE3UkJV7N89XbZ+kpzcYaYumO8R6wjUdno4BVjfwrgoFg6wTBGvtkSrqYHnybkalhuG4F/79xr8zHxaFmIImKjBAcrsQaw1FyV4n4fKUuH9tRJal6XX3ss/oAUlbb5N82r4IQ7M0btW4AwA4voYPKRMqqCfIjlkVXOXBMNZHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r9KgYGZ+tcFN7KhaVBjzsD2F3dOPlCcL+LidmhiWVVo=;
 b=NrGlIjk3txaHCzSEULLOHrchMAJfbkxlsvH7dx22jzugnvZ2FXzs2y/iMxsFa80jT7WQyxbYxGy6qZsIK9o0pdpXEoMq0tb6043gQ2zrPHCdmZnmE4/ixGzOq0lrqmYa213uCjCbzwCqP7Ok8AWRdx2hGpvD9uIYnH3m7nKu0JD/X21rbtIjPwNZG5SRnBYS0fAoW8rJA17sfeZb5seAuXZDlcdaXEnb9BKCkEOl2n9HRKqSUo5pU+cflLm+DcIRol+cZj0myiH/A0zMRA3Zvo9dnFN8KIwqpfLc48TxNx0VirMPd+/sBOF1lJJQTCPC6eNmQYtxoNqT1mvVO0pN9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mbv.ch; dmarc=pass action=none header.from=mbv.ch; dkim=pass
 header.d=mbv.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=newgenag.onmicrosoft.com; s=selector1-newgenag-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r9KgYGZ+tcFN7KhaVBjzsD2F3dOPlCcL+LidmhiWVVo=;
 b=TDwqnn8ilrwASKE+bQHZ1hCbi1KopBsgkErj5pW4Q3tXWm5Rg6R1t5eZw2DMK1T8e44WPNCymXYGUWC5pvuJsr18zKrPK+ZX67fB/fDgVl46fWaGYNpyLvLYxpsC4InYI1C7oedKOPeDxfrDkMYRXklVzPitL8Lp9QJ1U4l3Jow=
Received: from GVAP278MB0662.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:49::12)
 by GV0P278MB0049.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:1c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Thu, 24 Oct
 2024 08:54:03 +0000
Received: from GVAP278MB0662.CHEP278.PROD.OUTLOOK.COM
 ([fe80::373:3184:90d1:31b6]) by GVAP278MB0662.CHEP278.PROD.OUTLOOK.COM
 ([fe80::373:3184:90d1:31b6%3]) with mapi id 15.20.8093.018; Thu, 24 Oct 2024
 08:54:03 +0000
From: Yanik Fuchs <Yanik.fuchs@mbv.ch>
To: Amit Sunil Dhamne <amitsd@google.com>, "heikki.krogerus@linux.intel.com"
	<heikki.krogerus@linux.intel.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "rdbabiera@google.com" <rdbabiera@google.com>,
	"linux@roeck-us.net" <linux@roeck-us.net>, "kyletso@google.com"
	<kyletso@google.com>, "badhri@google.com" <badhri@google.com>,
	"xu.yang_2@nxp.com" <xu.yang_2@nxp.com>, "sebastian.reichel@collabora.com"
	<sebastian.reichel@collabora.com>
CC: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: AW: [PATCH] usb: typec: tcpm: Prevent Hard_Reset if Vbus was never
 low
Thread-Topic: [PATCH] usb: typec: tcpm: Prevent Hard_Reset if Vbus was never
 low
Thread-Index: AQHbJKZBKbAlUNbL60mUuxGGz7rdE7KVPCEAgABe/ZA=
Date: Thu, 24 Oct 2024 08:54:03 +0000
Message-ID:
 <GVAP278MB066241A50CBD35448CB11DE7974E2@GVAP278MB0662.CHEP278.PROD.OUTLOOK.COM>
References:
 <GVAP278MB0662F98EAAFAD95645E7010A974C2@GVAP278MB0662.CHEP278.PROD.OUTLOOK.COM>
 <d6bbd32a-6de4-492a-8965-c0bc3dbddcff@google.com>
In-Reply-To: <d6bbd32a-6de4-492a-8965-c0bc3dbddcff@google.com>
Accept-Language: de-DE, de-CH, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mbv.ch;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GVAP278MB0662:EE_|GV0P278MB0049:EE_
x-ms-office365-filtering-correlation-id: fe3a42eb-69f5-4871-b4a2-08dcf409691f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?HhPgVXbPPiPMfJ5e9bXct7TgqGZyvubU8T2e/bIoqUgdm7Kd0Lbca3OdSO?=
 =?iso-8859-1?Q?WO5OdVVUr+92Op0ftGaDCSsVO6T7PWxefBpC4MbELKmsM+D4QkxD7INd8X?=
 =?iso-8859-1?Q?lcNZ3FYNe7bm/LI3Fy0gCb0/31+uwfBsqRTpnK3DhYUSxFHG1gjGZhqMI3?=
 =?iso-8859-1?Q?gWVYFEWRwQKhiszKJjeIOWBgFace9PZ3nIDjbDQQKTHSo5dvoX5WfeJlag?=
 =?iso-8859-1?Q?kpOiQ3MgflnCcdQNmvP+STrd4RqT8j4NFdEC4pFV8zeTRkOJYyk0lLSqsT?=
 =?iso-8859-1?Q?hIjO1hIFJtC2D+KzzVIUM9RirpBU71uqC10s4rOrfvXx2Rg9fsgTo04MTa?=
 =?iso-8859-1?Q?UCXuoC9Wwh3A0/6y0jUui+rzWNJVMsrqoI58S1QjpxOoq4VGGNCbnaMZE4?=
 =?iso-8859-1?Q?kVZE/sar/l/ZkZWunJip8W1ymkiN4bl69+Skaqmj0U9+1THxg74JWdzLO8?=
 =?iso-8859-1?Q?AF9WIrLpzSS4Cdcg35M4nqk8vFZHsqOPTkfROopXgc2As8lM9Xmn5RJKRB?=
 =?iso-8859-1?Q?N5I+fl7gA8lz24BiAZWRDR7avjL9/Zi0jg1jx27x6J0oDPlBvKvesauFRf?=
 =?iso-8859-1?Q?JcCOPcImZ4hrknj8cAMN4k/aUjOcXgMmynl4jO9QR2FgiiWFAqHbw156Cd?=
 =?iso-8859-1?Q?tu138FtbL+C5TxHtcd3Swn5SRdO9Df69A36+0iCM3rJQpUCcxBanES3fWE?=
 =?iso-8859-1?Q?P/RDLidYR8lxZImQZQ+XhVAfyXEBJQL6wgzSYjQnBxrjH2fN2hpWDDF7yb?=
 =?iso-8859-1?Q?pbeEekMPO/ZJaxf4vsXAZqcK9H4TqeL8X3o6OVc5NoZ9KoGVuBdNl7qS61?=
 =?iso-8859-1?Q?jWu6Iql4DNz+eTHjtCLqXM/UYo+5+j5JgPCjP9jxPHziz6ehLR2z1MOoTw?=
 =?iso-8859-1?Q?SiMr37ZfEqMNhP4+F3CDZ9+oGJkBBrE4OmX586G254oT2WfuDu9KOtazr5?=
 =?iso-8859-1?Q?LWn1xHn068tcMVJYT4oIq37YGm+5ymMb/sstbvfXTMjzTswFBOPd05dAIK?=
 =?iso-8859-1?Q?5QeajAAmjoYKYUf8lHSwvg7vIHHfMi3pO05/g+sf74x39hCkVoB9FoyBP1?=
 =?iso-8859-1?Q?pf92H+wFNRj+UFmfvFCCGik711h4jU0Ir8pRftfFQKwGBdzYQpKEXJSn7V?=
 =?iso-8859-1?Q?c4wj4pQXOMatL5mS6F6hHKFy51SeQFumsnpk3d8wypWf54EQD3WEidSoHz?=
 =?iso-8859-1?Q?c6jL/21DuwVCqB7pT6NY8AghqMDuZ/CwkPbNrl8SBaDQmgXvzSJNWzCeFD?=
 =?iso-8859-1?Q?zHpPA1SC4xrVqffhnylVPozyVGxgumKM/yNsUNMcYgk+p0RvHUgoLBILlP?=
 =?iso-8859-1?Q?N52MBw33TELeMne3AeQSXz4fpORqmGRRvyhZk7CikOQyN3Umq//3T2cqUN?=
 =?iso-8859-1?Q?+QzlWA9a05eM7rtqy3XthCV1Pgev8DvxnVkJ5v/WRcycSaSpQdv4QMG5eW?=
 =?iso-8859-1?Q?c3UnQMLtPq+/ZpFh?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVAP278MB0662.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?+qdzkcx306Jk8RTu4lE23c3mmYHX1j5L02u6+KudgWDeiwKKtK/ukBEbdq?=
 =?iso-8859-1?Q?mS3XVveqAylp2XygcnoQWRVMAfqFL3vDMofwZhBTJKiymVrtQ2EkQ/bSTN?=
 =?iso-8859-1?Q?WxrqtHsFH6DvTALZJIEPuKRqL6W2Y5SvyUQCHUT7nQvTBuIwerleeUjdIA?=
 =?iso-8859-1?Q?n770iOEj5iz5kXe6AWb3D1BkOo49N98aKG8/g14l9bYJpI6O2wT/SyqWj9?=
 =?iso-8859-1?Q?KsHUUjReS27+tNrqad8CUs5A8sBl1/QEYWXSy0M6nCCmlX7HA/+hXk7xn7?=
 =?iso-8859-1?Q?hLWDuhN35eZGMxzfUl5LWFbHeRg4AkItGBSM1IZrihboKApj8bYTrR2fmP?=
 =?iso-8859-1?Q?LlglqzHmWckIIQz4/RyjxSo909Zy24SKA+q1Hsu4P82U9attFVWdsXH3YZ?=
 =?iso-8859-1?Q?KQXeyJx4TK/ylMj49eZPK4s3T7BBeny3Esy17k3rXStww5nSFBxVUfkIPm?=
 =?iso-8859-1?Q?k6yRRYZ3WM9/59pbEbWxQwGWNRCRyotxnOBcALF+T5fYodsyyDxaryCux6?=
 =?iso-8859-1?Q?6pZhyYR/KiHrZHRPQr4ItJly1wteg2jFtQZFAxMij5G0IasMhp1BS16pnG?=
 =?iso-8859-1?Q?MqpfbO8Nnks4Yp0xptNkELTdOBDly3xKccla4pFjgwapDXv5lJo6c9VpHw?=
 =?iso-8859-1?Q?ClhAThvXv4NgJpkyzFf4yhKGvqpu34cvlTLsEppzpChoU0NqWuxWhvHoYG?=
 =?iso-8859-1?Q?TpO5oAIZfAoyxa/Mt3CWTKETn8yE2JU9uZNgfmQ98VuSr2gVXW36nNNeRV?=
 =?iso-8859-1?Q?jw+2z6lDnXqJr6UmQNvgnnqBSJZrytlNlgNznsVgVXV4uSXVWRh5M4H5z9?=
 =?iso-8859-1?Q?9BvBDELkPzMsjcw8DxAsoZWUHGA/tGj3o7isl+q4u+4nvj1HhxcBUIuhPt?=
 =?iso-8859-1?Q?xqGp12OxiTm/ZZ98zoHw5KjodwvS8rgeEVfCaPgDGzfU6EU4rX6MU57vYq?=
 =?iso-8859-1?Q?rF55/nx5LWTdGaNJlYIHXiXmimMDSG1aNklwo8hLUYqiJaZEDV5uSWIu7v?=
 =?iso-8859-1?Q?oNXfI28ivf7OE7wV7MuPeafz8fS226LSDf/4HCFkMLpnp73ye5250MgGny?=
 =?iso-8859-1?Q?UoeKP/7l9syJM0YkQeFk6sHW6w0pQSimI5HhMgJcBSwaMQV4hcLVUkiyt2?=
 =?iso-8859-1?Q?kz3f9NVAi/WGGoy9niB/P5T0pIDBBvE5FnTt+0vINvvnTb4xXffrnKSRPH?=
 =?iso-8859-1?Q?aV3iCOE26eRYXQhEohF/8peT3jSOMIlDekFlVIxfaMUsilStmaChhTQmPq?=
 =?iso-8859-1?Q?fKqePZN6qm5T1/FncCTbdol9pMCQWbbO4vIHBiNPoXwx7xuIW31HTevLHd?=
 =?iso-8859-1?Q?ORpRl2vzHGPbI0wMOzch5ye24epOjpwAm86YEQ+m3T29n5GGAiF/Dxal5x?=
 =?iso-8859-1?Q?OHpGtUn9xebFYv2qTuJDUclZ8eJkaDzd0OXORu5YtfjDI7jrN1QW5tQQDE?=
 =?iso-8859-1?Q?2muC/h6lNw2Awi5MDD9spk0m7H4nLWBIXKFAT29mlg5DLan/hlTgG2qTRY?=
 =?iso-8859-1?Q?1xs2+iZegrUV7ZJLEBDANg86SqZAbzCLVcW3mONVQliInjTs7VjkP6cwmY?=
 =?iso-8859-1?Q?DvgTcFyTCQY/rVxGtyv31UBT4Awyjd5R5us+3Fk+1eVrflVpUOUm7rvs9x?=
 =?iso-8859-1?Q?YJjHchHWl+vEQ=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: mbv.ch
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GVAP278MB0662.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: fe3a42eb-69f5-4871-b4a2-08dcf409691f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2024 08:54:03.5196
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0b9c2100-a992-4d02-9349-895ecb1a1527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sbvyAM6RwOncKOnBqll1k14BSRpuIZ/yxJTWSgVgxENgWmhVyrMGSJzA1vuAccQ+TjHfHVR9MExlMVC2ajKqpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0049

Hi Amit

If the setting "bus-powered" is not set, there is only one way, that Vbus d=
oes not go down in init (where we force a Hard_Reset, which sets CC to Open=
 if not bus-powerded). The case where Vbus never goes down and setting Bus-=
powered is not set is only with a legacy cable/adabter. In that case, we do=
 not have PD compatibility anyway, and have to end up in SNK_READY eventual=
ly.
So we do the SOFT_RESET if Vbus was never down out of historical reasons an=
d is not needed anymore since tcpm is sending Get_Capabilities (the only re=
ason we send SOFT_RESET if Vbus was never down, is to get capabilities of S=
ource, and that we still do, if Get_Capabilities does not work).

As you correctly have pointed out, I have to fix a issue I spotted yesterda=
y as well, that with this Patch, after two hard_resets and then after 3 Sof=
tReset we seem not to end up in SNK_READY, but in SNK_UNNCONECTED -> I have=
 to find a way to check if we try hard reset in SOFT_RESET state after leav=
ing the WAIT_SINK_CAPABILITIES_TIMOUT and in that case send it to SNK_CONNE=
CTED (same as if we would be in state WAIT_SINK_CAPABILITIES or WAIT_SINK_C=
APABILITIES_TIMOUT).
Maybe we have to count softresets after requesing capabilities and reset it=
 as soon as we are in SNK_READY

BTW:
I have a patch which I use in the 5.15 version of the driver, where I can g=
et ptn5110 to init correctly without forcing the Hardreset and the manual C=
C_Change trigger (I changed default state of sink to SNK_DEBOUNCED (where V=
bus is checked and if not true sends us to SNK_UNCONNECTED) and added a del=
ay of one second to be shure that IRQ is running when state machine starts)

Freundliche Gr=FCsse
Best regards


Freundliche Gr=FCsse
Best regards


Freundliche Gr=FCsse
Best regards





________________________________________
Von: Amit Sunil Dhamne <amitsd@google.com>
Gesendet: Donnerstag, 24. Oktober 2024 05:13
An: Yanik Fuchs <Yanik.fuchs@mbv.ch>; heikki.krogerus@linux.intel.com <heik=
ki.krogerus@linux.intel.com>; gregkh@linuxfoundation.org <gregkh@linuxfound=
ation.org>; rdbabiera@google.com <rdbabiera@google.com>; linux@roeck-us.net=
 <linux@roeck-us.net>; kyletso@google.com <kyletso@google.com>; badhri@goog=
le.com <badhri@google.com>; xu.yang_2@nxp.com <xu.yang_2@nxp.com>; sebastia=
n.reichel@collabora.com <sebastian.reichel@collabora.com>
Cc: linux-usb@vger.kernel.org <linux-usb@vger.kernel.org>; linux-kernel@vge=
r.kernel.org <linux-kernel@vger.kernel.org>
Betreff: Re: [PATCH] usb: typec: tcpm: Prevent Hard_Reset if Vbus was never=
 low

ACHTUNG: Dieses E-Mail stammt von einem externen Absender. Pr=FCfe Anh=E4ng=
e oder Links sehr genau!


Hi Yanik,

On 10/22/24 10:28 AM, Yanik Fuchs wrote:
> Good Evening
>
> Here is a Patch to resolve an issue with TCPM if Vbus was never low.
> Please consider that this is one of my first kernel pull requests, I may =
have missunderstood the process.
>
> Freundliche Gr=FCsse
> Best regards
>
>
> Yanik Fuchs
>
> ---
>
>  From 604b97b6394b5643394bc63d4ac691c098c99c40 Mon Sep 17 00:00:00 2001
> From: yfu <yanikfuchs@me.com>
> Date: Tue, 22 Oct 2024 18:23:18 +0200
> Subject: [PATCH] usb: typec: tcpm: Prevent Hard_Reset if Vbus was never l=
ow
>
> Before this patch, tcpm went into SOFT_RESET state, if Vbus was never low
> resulting in Hard_Reset, if power supply does not support USB_PD Soft_Res=
et.
>
> In order to prevent this, I remove the Vbus check completely, so that
> we go as well into the SNK_WAIT_CAPABILITIES_TIMEOUT state. There, we sen=
d
> PD_CTRL_GET_SOURCE_CAP which many power supply do support.
> (122968f8dda8 usb: typec: tcpm: avoid resets for missing source capabilit=
y messages)

Please refer to
https://lore.kernel.org/all/20241024022233.3276995-1-amitsd@google.com/ as
122968f8dda8 is causing USB Type-C PD compliance failures.

>
> Additionally, I added SOFT_RESET (instead of Hard_Reset) as Fallback solu=
tion
> if we still not have gotten any capabilities. Hard_Reset is now only done=
,
> if PD_CTRL_GET_SOURCE_CAP and SOFT_RESET fail to get capabilities.
> ---
>   drivers/usb/typec/tcpm/tcpm.c | 10 ++--------
>   1 file changed, 2 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.=
c
> index fc619478200f..c7a59c9f78ee 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -5038,14 +5038,8 @@ static void run_state_machine(struct tcpm_port *po=
rt)
>                * were already in a stable contract before this boot.
>                * Do this only once.
>                */
> -             if (port->vbus_never_low) {
> -                     port->vbus_never_low =3D false;
> -                     tcpm_set_state(port, SNK_SOFT_RESET,
> +             tcpm_set_state(port, SNK_WAIT_CAPABILITIES_TIMEOUT,
>                                      PD_T_SINK_WAIT_CAP);
> -             } else {
> -                     tcpm_set_state(port, SNK_WAIT_CAPABILITIES_TIMEOUT,
> -                                    PD_T_SINK_WAIT_CAP);
> -             }

Instead of deleting code, please restrict this behavior to non self
powered battery case as this most likely break compliance and

may break actual use-cases for other users as a result. If you want you
can move stuff around after

https://lore.kernel.org/all/20241024022233.3276995-1-amitsd@google.com/

gets accepted in the following way:

```

if (!port->self_powered) {

         tcpm_set_state(port, SNK_WAIT_CAPABILITIES_TIMEOUT,
PD_T_SINK_WAIT_CAP);

         break;

}


if (port->vbus_never_low) {

         tcpm_set_state(port, SNK_SOFT_RESET, PD_T_SINK_WAIT_CAP);

} else {

         tcpm_set_state(port, hard_reset_state(..), PD_T_SINK_WAIT_CAP);

}

```

This way you don't have to execute the SNK_SOFT_RESET flow for non self
powered use-case.

Thanks,

Amit

>               break;
>       case SNK_WAIT_CAPABILITIES_TIMEOUT:
>               /*
> @@ -5064,7 +5058,7 @@ static void run_state_machine(struct tcpm_port *por=
t)
>                * according to the specification.
>                */
>               if (tcpm_pd_send_control(port, PD_CTRL_GET_SOURCE_CAP, TCPC=
_TX_SOP))
> -                     tcpm_set_state_cond(port, hard_reset_state(port), 0=
);
> +                     tcpm_set_state_cond(port, SNK_SOFT_RESET, 0);
>               else
>                       tcpm_set_state(port, hard_reset_state(port), PD_T_S=
INK_WAIT_CAP);
>               break;

