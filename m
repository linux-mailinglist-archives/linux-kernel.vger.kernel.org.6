Return-Path: <linux-kernel+bounces-300383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AEFDE95E307
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 13:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16AAEB2145A
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 11:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C67E13E3E1;
	Sun, 25 Aug 2024 11:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="Rq7t5fZ5"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11021088.outbound.protection.outlook.com [52.101.65.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67523801;
	Sun, 25 Aug 2024 11:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724584738; cv=fail; b=cHmNwpajnd1/x3X8J3RAR+W3OViuwE4k+LzivenySt2AfMWcbjqX2lZ44Teiw9jbuwH4I30CHMd//evGd9YqMas99mo0/uGlAj+8sKAI0CcWPaKpE8L2fNAx8ndbFdahHotdt0+JgxmhsCgR4MV9dFS7kGX0FAcZm5ByfxL895A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724584738; c=relaxed/simple;
	bh=5sbs4qCm7CmByZ/yIH/poJ1bPkLzyfmRISCSnwH+2rk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KT47Tp3tauEBkzTZsgGW6Udd3B2Q8/yLHZEyU6/OXhSc22cwvwCh1GgMm2Nn2a4k37ejhBZBzVo7X9Dzq0t9U2GANbyiiU/vTDPMh+OOmX2eLkmr1dOgvrqido013e6DtCUM2e0nQmA7RZBKsXbsNXUeIvrCNKk37VAUtR7rXQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=Rq7t5fZ5; arc=fail smtp.client-ip=52.101.65.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tt1F9rPdvFQc4NvjmA3KKlktrJ4ZqAe+0kHpDk78O+LsTrUi2yhM6G6CuH5gdse2dDO6ILLy11NCVPxoWy0rUFzokQGSRzKT9N3V6MvdyWDTzaunQIgGtK8uzAJOrktHGP1awhWjljRfdfmQClwYl7ddY+DlJOLxQcQtnLwS7SnXR7ygfkRfKuiTmJ9G7hqJoGaGWJNwb/SokbGvl85belEsSFewyofJqIpPjtQ/+bkCPXhiJ0/58NijJ8JYugvkBZMEPxscGeCgWAfIo5ljVvflQWT4HdBqWmR6GEhA7Fwq7OTr8VLXHkt2hTVc+bXYctUNDi350AG9qQntjpqaPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5sbs4qCm7CmByZ/yIH/poJ1bPkLzyfmRISCSnwH+2rk=;
 b=j9ozQFO2FwV0Bg4eZrIFAPqT9iS69uvG1B3m9ZytB48jxoAeUImhh9vrOdND2g/G03LLkTc3NmTBBXBgASy3ZkbSdWFqPiorYM4SgczcWnnTBrSU7l3n6FWpSpNXC5v8slwLgKzJaG4vrhOvScVs9y0tphQZQiFEXlLaT/g9sAoN6cM4N+25GxMUIYfTd2WzL3qIThFaOQNA3D0/ymKC+20K/2MlIMGjynpVuVKtu336vCAF2awjySouc5PIqp/3ScRWQfMwf/8czuv+U6vyNQQaNxrNOF1z4jFoI5GfmuS3jz25P1ElXxHF8rGR5Knb6UWosBDyegq9MEuBs5ETOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5sbs4qCm7CmByZ/yIH/poJ1bPkLzyfmRISCSnwH+2rk=;
 b=Rq7t5fZ5R525KowZw2hEtZ05EjRv+SgSkiARyjQjSllYgDs3WAqsJKg8KP7ZbEAQOSqznH6FPde6w3cWPJXKrZFKDJSWeRjBYDxHMAzMdr6b6r++CYrNHo8cduRF8buYl+IuVtSp8aYQNE9vPWZkYbUmqr1swOHgixG983IZ2Fs=
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by PAXPR04MB9489.eurprd04.prod.outlook.com (2603:10a6:102:2c1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Sun, 25 Aug
 2024 11:18:45 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%5]) with mapi id 15.20.7897.021; Sun, 25 Aug 2024
 11:18:45 +0000
From: Josua Mayer <josua@solid-run.com>
To: Logan Bristol <logan.bristol@utexas.edu>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Vignesh Raghavendra
	<vigneshr@ti.com>, Nishanth Menon <nm@ti.com>
CC: Matt McKee <mmckee@phytec.com>, Wadim Egorov <w.egorov@phytec.de>,
	"linux@ew.tq-group.com" <linux@ew.tq-group.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2] arm64: dts: ti: k3-am64* Disable ethernet by default
 at SoC level
Thread-Topic: [PATCH v2] arm64: dts: ti: k3-am64* Disable ethernet by default
 at SoC level
Thread-Index: AQHa6mRMvn4eMRt68kiqym0pT5BO+bI37FCA
Date: Sun, 25 Aug 2024 11:18:45 +0000
Message-ID: <23ac5cfb-dc5d-422b-925b-ab3f7cfae622@solid-run.com>
References: <20240809135753.1186-1-logan.bristol@utexas.edu>
In-Reply-To: <20240809135753.1186-1-logan.bristol@utexas.edu>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB7586:EE_|PAXPR04MB9489:EE_
x-ms-office365-filtering-correlation-id: e60d88d2-be2d-433c-fd01-08dcc4f7af22
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VHRNWWVoR2oyMDY2NE1lTlczV0hxck1zOFJXVHpzTVNuOHM4d0dmZHRtVGhn?=
 =?utf-8?B?cmZQMm9teUlJaGczZkVaL3BSSUZCN3VnWXRSUUx6OUhjQXpoNEtMSStTV3BJ?=
 =?utf-8?B?N3lVZzdMUXhxRWVSb0ZtRUhJbFI0R1ZDNERJSjIxZUQ4QWpqNjhQeUswR2sv?=
 =?utf-8?B?dmIzalpFT3puelE1YTBNYVFwV29TVW5nVkFmdTZ2L2ZiU0dwd2NjRmg5dXE1?=
 =?utf-8?B?RXliYkxDMzRxOHpqbEVsUWY2YWtyM0FMMGxOZ3l6WFJibG1GYlBvQkNaTzA2?=
 =?utf-8?B?N3JuelppVGtqVXJTSUx5OFJHbmJnRWVjdWcwQWN2VEcrZitGcENMcDl4ZXR3?=
 =?utf-8?B?ZTM2c1RuVFUwUUJBT0RPcnJ2enNzQnJmOTJVUG1sZ0tOSUI5Y3JmdU40aHpG?=
 =?utf-8?B?d3hMOUZZK3hzNnZnbis2alZ1YjBNTjRhK210WFgxNFpkQWo0SVd4KzQxL2wv?=
 =?utf-8?B?SkhEVHVyWDBQckpMWjNkV3VSYWlJNkxNOWlyQWtiVHgrd1B1OG9oN0hHTDcy?=
 =?utf-8?B?S1Jvdis3MzRZSWNLeWU1OTE5TzdxMERsZm5VQzdFWDNLU0RIaktnWXFFc2lX?=
 =?utf-8?B?dWtERFlJQWFYK2tmQnMrcDc2YzByRTJHT3RMay8zbnBXeHZzYWdzUlRUb2RE?=
 =?utf-8?B?RU9rNnBYdGlWbFNrWFM2TE5mdTJ6NWtDYWxHR2pnM09BV2s2QTV5dmdnT2N6?=
 =?utf-8?B?aFlIMWhaSW5kSHhLTDlJRlFsWUxhUEIrL2tQeDNsZzhuMzZlcUFkYkdQblh2?=
 =?utf-8?B?eFB2NDdkMmJkN3lNRXpsZVludGloQlV1b3I5OUpzeGFsNHVaZWpOcFZMZVlB?=
 =?utf-8?B?OW5SSXF4Lys0YVJqa1RQeGI2akF4MS9FMFB2d1k0MVQ3TlQwRFJUWm05Wll6?=
 =?utf-8?B?UURPWVlSR1pKQ0ZaMTNwb3loOC8wNHhtWVNTcHNPSExUTmVleDhmV2ZONGVW?=
 =?utf-8?B?Z3MrTEl3VHdmeHNzNkFla0Rlc0ZYZlI1SU1rY2hLT2VRVEI3SWFrcjM4cnk1?=
 =?utf-8?B?ZTJPZUlmdms3ZFozYUJCSzFZRUhlcUhCcyttVXFWL0UrMmk5ZFNCUjU3cVBB?=
 =?utf-8?B?aEY0Qlo5cnZCOHFVZE4vQjVOWExmT1FlbzRFeG9IZ2F6RitKS0FaamFoV2Na?=
 =?utf-8?B?VWl2NVZQbWtJYTVZWHd4bFUrRVU5VnowNXA2S0hjaHBrWHloS0xyL2tkMWxz?=
 =?utf-8?B?TC9jYkRyVkIrZWZUMlpOUFJtL2lRdFVKR0k3Q3NBNlNlU1RrRUFKUktUSmk0?=
 =?utf-8?B?UHRXMElYZHc0TmNrOXZmdFBGdDZ3bHVzcXNTVjJtYS9ESmo1UnYwN0w2YXFK?=
 =?utf-8?B?UnV3cm9Wd3ZpVThlSGdOblhjRmpFcUY0UExOVG5FYURYbXRZWWczMXc4SENp?=
 =?utf-8?B?Y0dBb0lWRHhWVHRETEllVVc5aGlEMzNoc2tvSi9ZZjBvUThEeG5aMUg3V2xq?=
 =?utf-8?B?S01ka0VBdzMxc2FJQTl3eWVUNDEycjR6VXByb0FIcVNZdmlGNGNyaDJYek1E?=
 =?utf-8?B?SnpidEdqL0d5czFIZ1M4TytTSnlQaVUzTFhZZkhpNTZnQVRRRzFoMW0wVFFh?=
 =?utf-8?B?ekE4MlpTYkJXanBEZm5lcjdPWHM5aFd3YUpITFBxbHdxaWoxaG1EVTdGY1dw?=
 =?utf-8?B?bHIrQTV0b2R3SXdxTE1rTWwyZGlaSTJLWFhuZXlZZStOY1F5cWhCYTZTbTFi?=
 =?utf-8?B?Z2tvL1NXeXhPU3pCOG1ONTBqMHBLWm1BN24wV0ZXRWpQQmlRYnNiK1J0MEti?=
 =?utf-8?B?bWlScFFZelZaYU5XWFFNUTFOVjFTSXpFYzhyZ2lHenZ5ZFJscGpiR0FqbFdn?=
 =?utf-8?B?OUhkRzZhaENNZ25BdENLTmFQNmY5NGI5ZlRBaUdYV1VZNDh2RE1KNDNRVFZR?=
 =?utf-8?B?TGVkZHhPb3FBMGxwU3RxZUJvTXRkMmQxSzNmL2FRdGloeFE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?blFldnRVTFgyUEJFdEpPTmYxTHFuVDJOeklaUHBhUElaRE1rVmtFYWp3Ty9z?=
 =?utf-8?B?Q2dzMG5GSXFMS2Z5TzZUUHl3TnVTdVljZG9GSWoySEpVRFg0SklEZE9zYjFG?=
 =?utf-8?B?L0VoNjFXUDNmb2NiRXc2WWJ3bldleDRzN3BUdjJiK0ZEbDFyNGVHNi9TQ09X?=
 =?utf-8?B?eVljNXRkRGxYT3NaVW5DZE9JOXdKVHFCVk1LblZRTVAya0NndXVCcWUyQW5H?=
 =?utf-8?B?b1gwRzlmWDRuOVBLZE1SVzFraVlXWVkvdGFUTkRLWjYrelpibHNEdlZHb0Nr?=
 =?utf-8?B?V2pIY3RBWnFYQ09JZWZpQ3Y5a3lGbUREektsOUZiSDl4Q0pUUytvS0t0NFRJ?=
 =?utf-8?B?SU12ZGxpL2tKWUZLTTNEWi80ZHU1eXVmTno3V00wWlVqUHpaSnhHWTkxTTlO?=
 =?utf-8?B?L1NKUDJqUFVFZkVGUm5KM3ZTMHQ5R3g3QjdqTDV6Uk9ZNlVweGRrbHVETm5r?=
 =?utf-8?B?QzRzRy8vWE9Uai8yVDdjSy90ZVpNSUZCY3JJUlNkbFJBYjQ0eHdtVUl4WmxI?=
 =?utf-8?B?bGdEZFlqbk1XV3B0U2RDcXM1M080Nk0rN1VDUzJjdXplQTRVaFdRd0NUOC9U?=
 =?utf-8?B?MUJ4d3JZam5TbTFCcS92bFVnV0RwanZWeXZNWXozTjN0QlRXYmRscnJuZFho?=
 =?utf-8?B?alhCSEU5cWJkMHVCdWZTazR0N3lvYVdZL0t3MXdPbFlXOFVzMXRVMStobTEr?=
 =?utf-8?B?NUJnQUMrcnRSaE8xaEx4SWQyTklZY2lZMUdqM01ic1o4UFNPRWhIbmF6aVdz?=
 =?utf-8?B?SEV5c0lJV0diK3RpWDIyK2xzekZXM0VUdWxFb0lzTW80bkZRTzg2RGNhaEc4?=
 =?utf-8?B?dFR2N1hFS1JoVE9PQk1EL3E0anNoNWNYcDRNb3V4bzE4U0pkTFJwdUM1ODcr?=
 =?utf-8?B?UE0vemNpYjhIczU5NENpVnZTUkdmRkJnT2xzazlPczZLWFhoYWROSk1mUmp4?=
 =?utf-8?B?a1hwTEh2ZGZxeU5PREVnY2V1djV5d3lZRXVTUjVzTkxGdHJXMWsydjVxQUNX?=
 =?utf-8?B?d0JJZTIvZWp4SEJBdEVqa2hMRzJTMHQxWmNvTjdqUEVic2pUT0NZempXWHZi?=
 =?utf-8?B?N0M5azVXaHBRbDZUSkp1OE13WENrQXJaTFJQbmd4d2k3cFJGL01tQmFDeWlM?=
 =?utf-8?B?Yk12ZkZyalJicCtMdXkwcUNRT2dMRnRWU2w5NS81VlltRmZPZGlIR21wVTV0?=
 =?utf-8?B?Z0I5SDJVT1NxRmEvY0hzY2RXRGhUR3JqelNydlFiWWk5ZUJxeUQraDluQ09J?=
 =?utf-8?B?eUY1Q1A3VTBSRzJzTjUxbUcwVkVrczFJK1RLcWtJTTNUYXU5MEt4TlJiR28z?=
 =?utf-8?B?Q2pCaWxrb1plS0d5WHdKYmloSFNlYUF5bEJYV01hOXdpei9nVWdPUUt5S016?=
 =?utf-8?B?a0ZSNFA0QlhnYWpRRURCdS92MUh1Y0hzOGF6bTVYVXNWNXpWTWFWYzEwSUw4?=
 =?utf-8?B?UWpjMkVPU3BhbmpaSU1rdnRDd0wxTlNlMVRpSDUxTkppeGFBNmFibUx6SlFT?=
 =?utf-8?B?eHNoQ3lEZ2ZMcENsdUo2QVFkUWg1L2ZodCtCZDdaaVFKOVNDakFwWkdoQzJj?=
 =?utf-8?B?dExlbUVpYWMyUTJUQnVya2hHVXhPc1JSc2pBeXlVSUd2MTlFalNsNGYxZ25w?=
 =?utf-8?B?UTZpdkNyOXFvVERHVkdxN29hR05Ybm5TdHdrVURvNzI3eEQyTUlOOERSL2RJ?=
 =?utf-8?B?am1WOGJvZFJCK0hOYUpNTStMcTg3UFhDNTczb2Mrd2ZsZ3JrdGlNZGNnRkEv?=
 =?utf-8?B?dTUwbzRicU96NlpLRmR0NWd5TXpvNElVMzZERVIvdXRXbEpicGNYdklMeVJW?=
 =?utf-8?B?b016NTNacWJuRXNlYVhoaUx4ZXF4ekhjYnkrNS8vaFVjQWp3S25FbGlKK0JD?=
 =?utf-8?B?QjBIa3Z3ak9idWlvSWppKzlscHFtSXFyazA3SXBOdlBpYTVtbjdsSjNIMXdp?=
 =?utf-8?B?T3BnNERRWjVSNEpWR2RDQWI2YVFva01xZ0lGajkzRDJzZjkvYkV4R2h2MmV4?=
 =?utf-8?B?U1RGeGZhdHdBK3E1N3c2WjV0cnBwMng0UHYwOTA5bHl6c1dIRWtvbE1tQUE4?=
 =?utf-8?B?SUJPdzdsY3NlSExzUm90YWNXUkVGNnlJR20wTzFjOXUzUGJuNzhVRmk2dzlx?=
 =?utf-8?Q?9sudoIymL4efJDPFOSzFJDHe9?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <60D4216EB0430B4CB868E4F6F3FAE7C9@eurprd04.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e60d88d2-be2d-433c-fd01-08dcc4f7af22
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2024 11:18:45.3450
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C2WexjMQQDWCqxsldsH4WosZ4YE27PMzA/pS9ggtWo8sWmjOKojTQBFZqhGKCJsvjaueCTvei/jW6Uq7uo1Azw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9489

SGkgTG9nYW4sDQoNClRhbmsgeW91IGZvciBpbmNvcnBvcmF0aW5nIHRoZSByZXF1ZXN0ZWQgY2hh
bmdlcywNCnVuZm9ydHVuYXRlbHkgSSBmb3VuZCBhbm90aGVyIG1pc3Rha2UgLi4uIHNlZSBiZWxv
dy4NCg0KQW0gMDkuMDguMjQgdW0gMTY6NTcgc2NocmllYiBMb2dhbiBCcmlzdG9sOg0KPiBFeHRl
cm5hbCBpbnRlcmZhY2VzIHNob3VsZCBiZSBkaXNhYmxlZCBhdCB0aGUgU29DIERUU0kgbGV2ZWws
IHNpbmNlDQo+IHRoZSBub2RlIGlzIGluY29tcGxldGUuIERpc2FibGUgRXRoZXJuZXQgc3dpdGNo
IGFuZCBwb3J0cyBpbiBTb0MgRFRTSQ0KPiBhbmQgZW5hYmxlIHRoZW0gaW4gdGhlIGJvYXJkIERU
Uy4gSWYgdGhlIGJvYXJkIERUUyBpbmNsdWRlcyBhIFNvTSBEVFNJDQo+IHRoYXQgY29tcGxldGVz
IHRoZSBub2RlIGRlc2NyaXB0aW9uLCBlbmFibGUgdGhlIEV0aGVybmV0IHN3aXRjaCBhbmQgcG9y
dHMNCj4gaW4gU29NIERUU0kuDQo+DQo+IFJlZmxlY3QgdGhpcyBjaGFuZ2UgaW4gU29NIERUU0lz
IGJ5IHJlbW92aW5nIGV0aGVybmV0IHBvcnQgZGlzYWJsZS4NCj4NCj4gU2lnbmVkLW9mZi1ieTog
TG9nYW4gQnJpc3RvbCA8bG9nYW4uYnJpc3RvbEB1dGV4YXMuZWR1Pg0KPiAtLS0NCj4gQ2hhbmdl
cyBzaW5jZSB2MToNCj4gLSBFbmFibGVkIGNwc3czZyBhbmQgY3Bzd19wb3J0MSBpbiBTb00gRFRT
SSBpbnN0ZWFkIG9mIGJvYXJkIERUUw0KPiBpZiBib2FyZCBEVFMgaW5jbHVkZWQgU29NIERUU0kN
Cj4gLS0tDQo+ICAgYXJjaC9hcm02NC9ib290L2R0cy90aS9rMy1hbTY0LW1haW4uZHRzaSAgICAg
ICAgICAgICAgIHwgMyArKysNCj4gICBhcmNoL2FybTY0L2Jvb3QvZHRzL3RpL2szLWFtNjQtcGh5
Y29yZS1zb20uZHRzaSAgICAgICAgfCA2ICsrLS0tLQ0KPiAgIGFyY2gvYXJtNjQvYm9vdC9kdHMv
dGkvazMtYW02NDItZXZtLmR0cyAgICAgICAgICAgICAgICB8IDMgKysrDQo+ICAgYXJjaC9hcm02
NC9ib290L2R0cy90aS9rMy1hbTY0Mi1zay5kdHMgICAgICAgICAgICAgICAgIHwgMyArKysNCj4g
ICBhcmNoL2FybTY0L2Jvb3QvZHRzL3RpL2szLWFtNjQyLXNyLXNvbS5kdHNpICAgICAgICAgICAg
fCA2ICsrLS0tLQ0KPiAgIGFyY2gvYXJtNjQvYm9vdC9kdHMvdGkvazMtYW02NDItdHFtYTY0eHhs
LW1iYXg0eHhsLmR0cyB8IDYgKystLS0tDQo+ICAgNiBmaWxlcyBjaGFuZ2VkLCAxNSBpbnNlcnRp
b25zKCspLCAxMiBkZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9v
dC9kdHMvdGkvazMtYW02NC1tYWluLmR0c2kgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL3RpL2szLWFt
NjQtbWFpbi5kdHNpDQo+IGluZGV4IGY4MzcwZGQwMzM1MC4uNjljNWFmNThiNzI3IDEwMDY0NA0K
PiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL3RpL2szLWFtNjQtbWFpbi5kdHNpDQo+ICsrKyBi
L2FyY2gvYXJtNjQvYm9vdC9kdHMvdGkvazMtYW02NC1tYWluLmR0c2kNCj4gQEAgLTY3Nyw2ICs2
NzcsNyBAQCBjcHN3M2c6IGV0aGVybmV0QDgwMDAwMDAgew0KPiAgIAkJYXNzaWduZWQtY2xvY2st
cGFyZW50cyA9IDwmazNfY2xrcyAxMyA5PjsNCj4gICAJCWNsb2NrLW5hbWVzID0gImZjayI7DQo+
ICAgCQlwb3dlci1kb21haW5zID0gPCZrM19wZHMgMTMgVElfU0NJX1BEX0VYQ0xVU0lWRT47DQo+
ICsJCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+ICAgDQo+ICAgCQlkbWFzID0gPCZtYWluX3BrdGRt
YSAweEM1MDAgMTU+LA0KPiAgIAkJICAgICAgIDwmbWFpbl9wa3RkbWEgMHhDNTAxIDE1PiwNCj4g
QEAgLTcwMSw2ICs3MDIsNyBAQCBjcHN3X3BvcnQxOiBwb3J0QDEgew0KPiAgIAkJCQlwaHlzID0g
PCZwaHlfZ21paV9zZWwgMT47DQo+ICAgCQkJCW1hYy1hZGRyZXNzID0gWzAwIDAwIDAwIDAwIDAw
IDAwXTsNCj4gICAJCQkJdGksc3lzY29uLWVmdXNlID0gPCZtYWluX2NvbmYgMHgyMDA+Ow0KPiAr
CQkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+ICAgCQkJfTsNCj4gICANCj4gICAJCQljcHN3X3Bv
cnQyOiBwb3J0QDIgew0KPiBAQCAtNzA5LDYgKzcxMSw3IEBAIGNwc3dfcG9ydDI6IHBvcnRAMiB7
DQo+ICAgCQkJCWxhYmVsID0gInBvcnQyIjsNCj4gICAJCQkJcGh5cyA9IDwmcGh5X2dtaWlfc2Vs
IDI+Ow0KPiAgIAkJCQltYWMtYWRkcmVzcyA9IFswMCAwMCAwMCAwMCAwMCAwMF07DQo+ICsJCQkJ
c3RhdHVzID0gImRpc2FibGVkIjsNCj4gICAJCQl9Ow0KPiAgIAkJfTsNCj4gICANCi4uLg0KPiBk
aWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy90aS9rMy1hbTY0Mi1zci1zb20uZHRzaSBi
L2FyY2gvYXJtNjQvYm9vdC9kdHMvdGkvazMtYW02NDItc3Itc29tLmR0c2kNCj4gaW5kZXggYzE5
ZDBiOGJiZjBmLi5hNWNlYzlhMDc1MTAgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9k
dHMvdGkvazMtYW02NDItc3Itc29tLmR0c2kNCj4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy90
aS9rMy1hbTY0Mi1zci1zb20uZHRzaQ0KPiBAQCAtMTc3LDYgKzE3Nyw3IEBAIHZkZF9tbWMwOiBy
ZWd1bGF0b3ItdmRkLW1tYzAgew0KPiAgICZjcHN3M2cgew0KPiAgIAlwaW5jdHJsLW5hbWVzID0g
ImRlZmF1bHQiOw0KPiAgIAlwaW5jdHJsLTAgPSA8JnJnbWlpMV9kZWZhdWx0X3BpbnM+Ow0KPiAr
CXN0YXR1cyA9ICJva2F5IjsNCmNvcnJlY3QNCj4gICB9Ow0KPiAgIA0KPiAgICZjcHN3M2dfbWRp
byB7DQo+IEBAIC0yMTAsMTAgKzIxMSw3IEBAIGV0aGVybmV0X3BoeTA6IGV0aGVybmV0LXBoeUAw
IHsNCj4gICAmY3Bzd19wb3J0MSB7DQo+ICAgCXBoeS1tb2RlID0gInJnbWlpLWlkIjsNCj4gICAJ
cGh5LWhhbmRsZSA9IDwmZXRoZXJuZXRfcGh5MD47DQpXZSB1c2UgdGhpcyBwb3J0IG9uIHRoZSBT
b00sIHBsZWFzZSBzZXQgc3RhdHVzIG9rYXkuDQo+IC19Ow0KPiAtDQo+IC0mY3Bzd19wb3J0MiB7
DQo+IC0Jc3RhdHVzID0gImRpc2FibGVkIjsNCj4gKwlzdGF0dXMgPSAib2theSI7DQpXZSBhcmUg
bm90IHVzaW5nIHRoaXMgcG9ydCBvbiB0aGUgU29NLCBkcm9wIG5vZGUgdG8ga2VlcCBzdGF0dXMg
ZGlzYWJsZWQuDQo+ICAgfTsNCj4gICANCj4gICAmaWNzc2cxX21kaW8gew0KDQo=

