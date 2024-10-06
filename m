Return-Path: <linux-kernel+bounces-352457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DBA8991F7E
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 17:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6A01B21CB2
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 15:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14799187FF5;
	Sun,  6 Oct 2024 15:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="lqAs5EWX"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2113.outbound.protection.outlook.com [40.107.249.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4703F18757C;
	Sun,  6 Oct 2024 15:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728229352; cv=fail; b=Y82oKiXy6mv/watQ/QqAiqye+tVrnZvu2chaUQljnh8Xy7z1Gk61LwYvdjDtY0E0sD7ql1CcOQVnqe0AZ/K/Q+RBRmd+a+Pr8/HTNCs4FsNTyIjF6kdUcC5A8IjTS9By+dUG08ghvO+mf29PmaGSX1admmixfZsfAJOovL4eovY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728229352; c=relaxed/simple;
	bh=9ZAMIAjzCiTLJ/4MAfunZUHotGY+iNFHP2ECiNhX5FY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GayQtvF9hF59DWn7PsdNmmQYWF6HYkE2DZRCqptcOT3bT/miL3j2YTcFCXGy5mcWRsGO/A/8AW0XH0o8rQsuXCP1Ql+qEbKdc7Ta8G0rkoMQ108tpwfsWMNEve5XePuwkga0VPTtQbs01N5AMKl0PPhPm/KKR/i1OFwSZfYVr0Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=lqAs5EWX; arc=fail smtp.client-ip=40.107.249.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wxpwzo2pj+uiJxn6DcGr7GV6X0+8I0D2oIfHRdNqj7yQota+IYWduhas1p/BN1YMxNJD46HjUCO8YU+4OfRNSfYNwxG4cZjuu5W0k59B6dhF6WGwKg60UOd1a10fEGNv47Y5mw9gDAPxgvlsIDIf0/4Hy8b/0fMW+xrX8cfHJ3BwjKQSfhaxhOTQ3FwUzf4Z3BcFaYcTPYZAngKOOGQC691WjrVntNC0YUrf/LwjnIE8jg9wXxKgR3Jkv5DJXA1Iz6CUkvdWEY+rL4ArODTDoo4zqmdjUDINs/jYY/0RzYt517XZ1eH8isvsM6qDugjzQ3Gl1Grqx4vZ8fxfnd37KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ZAMIAjzCiTLJ/4MAfunZUHotGY+iNFHP2ECiNhX5FY=;
 b=luHRsU9VCMQq8v36VcVmaMFsxZ6/tOTfXLerqiEZ6Y0dFzpGg3AHozZN6YGzHQzW1YJLMMlKvfCCHQaISg98YBZ/6cy4sYaqKLuG60KUxA/TFw3mKAZ5g9A4tmcZsqftfXQcG70WQbQlvzsgj90IGo1eKnuWSmEVYq9oJOtBLsW8XlThThs3MvT+Zaj3yGrPXlKD/TxKx4ZVbHUTlhyN57kjcNRiu6Mkj77JiFs1TPWP++Q0MJnt4M33VevmmCeBqsadJv4wKdY+RjervMCraHe4fJCa56vxeCJPcWLgXcLwH3YwbZS3qt5LqAqfecNIOdM9cT02ykC/cEYU5wzh7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ZAMIAjzCiTLJ/4MAfunZUHotGY+iNFHP2ECiNhX5FY=;
 b=lqAs5EWXQcqR/laIaaAAzCd/bsD8WUa0wz1qfgZUPiqYljkJJvAeNdJ0s6IdaWKaKPXvKoV+iqQZ2YF7H5SCGq9PSCi4Zw7/DfnvXEWevcyivXSGHCeQ/sRbEev0BQphEuBG+cp4OYRbh2R56o3Bze1RMAQQHUjogHReO1DEe3E=
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by AS8PR04MB7512.eurprd04.prod.outlook.com (2603:10a6:20b:29e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.21; Sun, 6 Oct
 2024 15:42:26 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%6]) with mapi id 15.20.8026.020; Sun, 6 Oct 2024
 15:42:26 +0000
From: Josua Mayer <josua@solid-run.com>
To: Nishanth Menon <nm@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] arm64: dts: ti: k3-am642-sr-som: mux ethernet phy
 reset signals input
Thread-Topic: [PATCH v2] arm64: dts: ti: k3-am642-sr-som: mux ethernet phy
 reset signals input
Thread-Index: AQHa/d6gCJuT66rbcU+oM9bE0EU3FbJGAdwAgBEU3YCAIvo5AA==
Date: Sun, 6 Oct 2024 15:42:26 +0000
Message-ID: <eda9a4b4-5893-49ca-aedb-fd22c6e523f1@solid-run.com>
References: <20240903-am64-phy-lockup-v2-1-8cf6bd138ebd@solid-run.com>
 <20240903124256.kmlkjcihl6zyzgiu@commuting>
 <120f7936-97bd-46cd-bb8c-90fca27d2140@solid-run.com>
In-Reply-To: <120f7936-97bd-46cd-bb8c-90fca27d2140@solid-run.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB7586:EE_|AS8PR04MB7512:EE_
x-ms-office365-filtering-correlation-id: 649e6886-7be9-408a-43fb-08dce61d7aa9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Vm1nQlE4cFc2aVZRSEFCbFI4dzQ5YmI3dHFXZnU0K2twZDBxQWVlVUVsT003?=
 =?utf-8?B?cWFGYTFuQWdWRzUwRCtrWVJ6dWhzbDRkSEM5NXEwU2kwRzc3TVBVamNGbkhz?=
 =?utf-8?B?T2gwR3U1MEJxVE9yL0NRdTRWSXA1ZnFUWjdxUXdOOVBERGFTaEZKWWoyQ2pX?=
 =?utf-8?B?RUlHUjNJUHh2TDIrd2VVeUh2VGpEY2VTNE43MzRKanJRRjBvbEFSSnVia0M0?=
 =?utf-8?B?VkloN0I4b1UvdVZpUEJaT1h1V2VnZys5MWhRT1daK3BHaG1pNEFIbVREa0x4?=
 =?utf-8?B?SHRNUTllOU5DanRzQWgwRWh3Z25VWGNTMmRVZ1VLUG9GMEJwL1Z6cmErUjB5?=
 =?utf-8?B?b2N5dFZXeUQwM2ZnWWJzaTQ3U1JOTU40SEowTWNtR0s1TnJaWTFrbEVidGNL?=
 =?utf-8?B?bytKTkl1Mk05ZW1qc1k4RkhPcEpEaktLckpseVh5RjIrelRjTUpiY1ZVV3hC?=
 =?utf-8?B?SGk3VUFUc1hlOTJ6cjBtTmcvSkp1cFhjZnhHRXczbjVWV2lIdUg3STYweUtq?=
 =?utf-8?B?L291azE3MEhSaDMwVU1pNWFTenpwTG1NdmhCc0FxNFdtWWN3MzkvUUlzOW85?=
 =?utf-8?B?ZTl4cThwOHFoRERkZlhXRGZqRnZxWmNEOHRaTnM2SXZNNVQrSXI0dkZ1NDd5?=
 =?utf-8?B?T1RuNEliWkFNT1g1eU1zRlNnSXgwNlZuZVQ1SjFkMW43L2o0Uzc4VXg5UDBs?=
 =?utf-8?B?K0UzOGdqc3l5K1hRa095RVJzZEh2MjllU2ZaMGFNMWJxUG5lWTYvMWhKemZS?=
 =?utf-8?B?N3l5TStFL3JUQkp2UGRaeFR3K2hXWjVxdGdRWXc4cGV3SzJ0NGdlSlRVQlJO?=
 =?utf-8?B?cUE2TW5ZWWRlS0E3RlMyZWdjNmxCZUFIaXVqekdxeER4QUt4Z2lkUGE0eXVU?=
 =?utf-8?B?cE9jOFkzVUxIVTFpV1Y0NFhxOTRqT01SSVFoYTRBZUh2b1E4OENTMkJpdjho?=
 =?utf-8?B?enUyK1NhT2F3dFhOM3cva1o5M0tzb2NRV1RPN0FzcVd5UGk5SFFQa0FXYldz?=
 =?utf-8?B?V3NXbGpwTzZrakgxV2ZCYm1Yb2tXNldVWllhQW9OTUNtbGNlRDZWVk5YcXlz?=
 =?utf-8?B?UkNPa0ljc0tkNkRQSXV0Zk9vSmpRS2RRTENEOHU3cFJDaEhxOG8yMTVHcFg1?=
 =?utf-8?B?ZUVlQno1TjJNdGRUMCttcmhFcnJoWkNvZlNDcFVkM2pscFYrUUNxRzI3STRI?=
 =?utf-8?B?STBpUEhsbXBIUVNjZlNOQ3RDd3Vsa3lsbmh5Ry91RFdjRnd4RGJwVzNFQms1?=
 =?utf-8?B?UlRhUjM0MjE3cVREVkRUcnB6dmdxZjFxd3hwbXBNWEJtTG5nTi8vZFdIUkc5?=
 =?utf-8?B?YTA4MVloNUpxSkN0cTE3QUJ6alJpanlKVTBwSUdybHd3QmhDeHY1MVZtYmtC?=
 =?utf-8?B?OHVNR1k4WWo1YTJmSVREOEdjNU9mWGhzL2VMekxvOE5qYkhZdS9TM0NIckVl?=
 =?utf-8?B?UGZLZTRhMWh3dlA3dTZYWjZwRmhhdjB5Y3Z0RTdjOHJ3clJKR3pnQXN4eEdq?=
 =?utf-8?B?OFVRTU85dmVmQ2lzMGR3SDFOemRWdXJWUnVxRkkzQVRLNmthSy9ZOWNXaWZZ?=
 =?utf-8?B?Um9uang3TWRtSG1GQ205NVFXM1dGUzVCd2ZmK3R1T1VaRG9FYUpIenJqN2ZI?=
 =?utf-8?B?WkdGMFZoR1hpSlQxTUd1OWpCNWNxWFM5cE9Ea3JKVjhORVFRdHBqZEpPRlQ2?=
 =?utf-8?B?NEpOZmpMemlLU0dzSStSVjFoMnlGd3oweTEvYU94T1lRL001YnpyRVVhOHFX?=
 =?utf-8?B?TktCemcrYzg3UUJ5THZ3N0hINjViUzFjb1JjbE12OWRZaEsrT2ZMdEtXYmtS?=
 =?utf-8?B?bW1GYlJqQk5lbXd3eDU2dz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YWhZU3IvNzliM1BPM1gxN2pZQVdIS0QwMFdXV3FtRHh3bmFDUG1QKzI2MEVr?=
 =?utf-8?B?WDhhdUgyYWRkSHZyeVRMUDgrM1R0TFZ2SHBjb1BsVEczSXhxemhySUk3bktv?=
 =?utf-8?B?bHNkVjBZbGdWeFZNbWlLTTZlcUtVcnNKZDF3T3dwL1RrdW8vRzh1dzJVcnRk?=
 =?utf-8?B?UzhydUs0dDUrb2tUN1Mwd251Q3l2Szl6YXlDTzU0b0ZQSHBRWnB2VFRtdGt3?=
 =?utf-8?B?SnZwaVlnTmNLL09mZHhhSFoycDBnSDE2N3MzUC9NemhZR092WDcyek4wd2pW?=
 =?utf-8?B?bmZsR2ZOOFJuN3JQK1JPeEZhNTd2U1pyU01idW5zcVB4VVpRTmI0YzZacEdt?=
 =?utf-8?B?V2xKQ3hySkpNclFqRW44UHNRb09PbzN6SHRPdnJTWlBqOFFadXppSnF6WE51?=
 =?utf-8?B?d21zenc0NWNuRG5zaXdYM2pOZk92VitJK1cxY2N2SnQ5Q2gzMS9JZ2hHM1Rn?=
 =?utf-8?B?YTBBbUVUUE1tS0ZhZGFaUWEzSXVwSzlRZnd0QStlbTJEQXdnN01iU05CTHhZ?=
 =?utf-8?B?TFhyVFNKZlFsMnc5VHdtbTRBd0hxUFFDYjBOd3JWeCtmejN4ZFBCYWxIY0lF?=
 =?utf-8?B?VkU5eU50dWJCRWh5VzFMZGY0L1pxT3JkOEFFTjVXVDkwNStnL3lMUFZ3dURt?=
 =?utf-8?B?YkNCd1orcElkQ0hLc2tEaFRUTnBLYXl6aWRUcjMvc3B2UVhzaUhnaWVPTzYy?=
 =?utf-8?B?T255dWFtVFhaalJ5NjUwOXFpYkYraE9HUEFJbk1WeC9WYlI2T2paTEg3MGhs?=
 =?utf-8?B?THZwd01LTFBqK2J5blNaRUJyVERZbUNEQ1ZWaUFyemN5STVvTTVkL2RSNFdW?=
 =?utf-8?B?b0o3d0xnVzVHdFpVU0FTK0ptV25KclB4UFpBeEJ0WS91eHhuZU9ZU1o2UnR2?=
 =?utf-8?B?UkRWME40VmphV0dXS2dZQ0ZRWDA5TGVTeHI5bnFlMjI4eW0rYnBaWlBiRG9z?=
 =?utf-8?B?Q28rM2Jka1R6eitBb2JoK0NyZGNSdU96T3VrdHR4a1U4bFlqa3Z3WUJFM1pX?=
 =?utf-8?B?Wjl1bTdMTCt6d2FCMHZGRWV3M3ZGYzdVYll1dEsyTlB2SlNVUGZPb2ovUXQx?=
 =?utf-8?B?NmJqTFpPYnZYb2JNK1NNNW1mUmYxVFBpSHpneVJkVXdxNlhSWnI1NzEyaDMx?=
 =?utf-8?B?bDdBdnJISGYwWW1mUFlwLzRVQjJIbEdNVTNlcUkxanZDNitzeXUrN1ZkUk5V?=
 =?utf-8?B?bG0rdHVyUlhYR2dDRHVOOXFsTStUekg5YzY5Z2xzMGY3ZmJZZ3N4VDREZXVL?=
 =?utf-8?B?d3BRaW4yVjBUdENNNlZId1lGM0tHL3RZYldJYVZNd3R6RXZQOW9QUHFBWno4?=
 =?utf-8?B?OXRJbHdTMWt0eElaWEpweHA2VXE1eW0vakJOc1I4bUl2cldUNENacCt5WWpk?=
 =?utf-8?B?Tm44MDRxVlh3ajFidS92aGJxeWw2TGh2M0xSY3c5d1pZOHNiSmVOam5SeFVD?=
 =?utf-8?B?UWM1OERBVDNFTitoRnFvdUdEV01NQ1A3bWszL1gyK3pqdlRjQ0hGQU1GRExF?=
 =?utf-8?B?ZFRtc2hEaXAwa0dad0EwYnRraDg5V1d0NTFLQ0l0V3N5WFExNHp6SDBxOVBR?=
 =?utf-8?B?NTZJNDdheG9Va3EweVFMT3VhejFBTlJtd1hKcnFLNkZHaGFwTmNuS2hWMHdv?=
 =?utf-8?B?VnoxMm9ud0phMVRvS2E0aEx0WE9mbk9wSlVhNytGS3VyTmY3em82ODgwYXZZ?=
 =?utf-8?B?RCtBcEhlMXZtclczVmRQVHpiOTcrZDBOQjhvNnp6S1NOVUFyWWV5b29ndFNh?=
 =?utf-8?B?NXdhTTNzNTVrd2dLa1Nvak1GbmRveFlOc2FoT1Y1M1B2MytzaFQreHFack1l?=
 =?utf-8?B?ODFJTHM4ZDFESWxLL3ZHdDRDN2dvbmlWVEZmMFY4MHVVRDdCdkNZNjJDOTd5?=
 =?utf-8?B?N2ZmdFZFTkJuYTZaQUxCMGtvU2dwTHBLaGgvaEIwTExwckM3WERaWWRtMjlw?=
 =?utf-8?B?QTkrZ2NPZFhqd0d1bEN4VUVKY1FEZWFhTVQ0cmlqMmNZcTFyTzdHMlV2YlNL?=
 =?utf-8?B?dnFLNTV0TDNLd2hZQXBkY3RZdXVPc0VkcFVKWWlPSFFuUEdadEt4czJDM3NF?=
 =?utf-8?B?MEMwcnlTNnhqRm5GREtoVEVhT3NmdlUzdnZJZFBHU1A3elI1SUFoZVNPZk9h?=
 =?utf-8?Q?eCcg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <41FA2A4CA45F3D4F9AEBDA0CEF541B85@eurprd04.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 649e6886-7be9-408a-43fb-08dce61d7aa9
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2024 15:42:26.5892
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WsbD3oEnf/oyzE+4FfLDgJqPA3Fmd2LFUi1ohz9s8WORAX2huGPCshsOOB9NGmj/gz3QTdYbz1zbJbekQ7PiOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7512

SGkgTmlzaGFudGgsDQoNCkFtIDE0LjA5LjI0IHVtIDExOjM0IHNjaHJpZWIgSm9zdWEgTWF5ZXI6
DQo+IEFtIDAzLjA5LjI0IHVtIDE0OjQyIHNjaHJpZWIgTmlzaGFudGggTWVub246DQo+PiBPbiAx
MTo1Mi0yMDI0MDkwMywgSm9zdWEgTWF5ZXIgd3JvdGU6DQo+Pj4gU3BlY2lmaWNhbGx5IG9uIEFN
NjQgU29NIGRlc2lnbiwgdGhlIERQODM4NjkgcGh5cyBoYXZlIGEgY2hhbmNlIHRvIGxvY2sNCj4+
PiB1cCBpZiByZXNldCBncGlvIGNoYW5nZXMgc3RhdGUuIFVwZGF0ZSB0aGUgcGlubXV4IHRvIGlu
cHV0LW9ubHksDQo+Pj4gc3Ryb25nbHkgZW5mb3JjaW5nIHRoYXQgdGhlc2Ugc2lnbmFscyBhcmUg
bGVmdCBmbG9hdGluZyBhdCBhbGwgdGltZXMuDQo+Pj4NCj4+PiBUaGlzIGF2b2lkcyBzcG9yYWRp
YyBwaHkgaW5pdGlhbGlzYXRpb24gZXJyb3JzIG1vc3RseSBlbmNvdW50ZXJlZCBkdXJpbmcNCj4+
PiBwb3dlci1vbiBhbmQgcmVzZXQuIEluIHRoaXMgc3RhdGUgdGhlIHBoeXMgcmVzcG9uZCB0byBh
bGwgbWRpbyBtZXNzYWdlcw0KPj4+IHdpdGggYSBjb25zdGFudCByZXNwb25zZSwgcmVjb3Zlcmlu
ZyBvbmx5IGFmdGVyIHBvd2VyLWN5Y2xlLg0KPj4+DQo+Pj4gU2lnbmVkLW9mZi1ieTogSm9zdWEg
TWF5ZXIgPGpvc3VhQHNvbGlkLXJ1bi5jb20+DQo+Pj4gLS0tDQo+Pj4gQ2hhbmdlcyBpbiB2MjoN
Cj4+PiAtIHVwZGF0ZSBjb21taXQgbWVzc2FnZSB3aXRoIGFkZGl0aW9uYWwgZGV0YWlscw0KPj4+
IC0gcmViYXNlZCBvbiB2Ni4xMS1yYzENCj4+PiAtIExpbmsgdG8gdjE6IGh0dHBzOi8vbG9yZS5r
ZXJuZWwub3JnL3IvMjAyNDA3MDQtYW02NC1waHktbG9ja3VwLXYxLTEtNGEzOGRlZDQ0ZjlkQHNv
bGlkLXJ1bi5jb20NCj4+PiAtLS0NCj4+PiAgYXJjaC9hcm02NC9ib290L2R0cy90aS9rMy1hbTY0
Mi1zci1zb20uZHRzaSB8IDYgKysrLS0tDQo+Pj4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlv
bnMoKyksIDMgZGVsZXRpb25zKC0pDQo+Pj4NCj4+PiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9i
b290L2R0cy90aS9rMy1hbTY0Mi1zci1zb20uZHRzaSBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvdGkv
azMtYW02NDItc3Itc29tLmR0c2kNCj4+PiBpbmRleCBjMTlkMGI4YmJmMGYuLmIxZjA2MDcxZGY0
YyAxMDA2NDQNCj4+PiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL3RpL2szLWFtNjQyLXNyLXNv
bS5kdHNpDQo+Pj4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy90aS9rMy1hbTY0Mi1zci1zb20u
ZHRzaQ0KPj4+IEBAIC0zMjAsNyArMzIwLDcgQEAgQU02NFhfSU9QQUQoMHgwMjc4LCBQSU5fSU5Q
VVQsIDcpIC8qIEVYVElOVG4uR1BJTzFfNzAgKi8NCj4+PiAgCWV0aGVybmV0X3BoeTBfZGVmYXVs
dF9waW5zOiBldGhlcm5ldC1waHkwLWRlZmF1bHQtcGlucyB7DQo+Pj4gIAkJcGluY3RybC1zaW5n
bGUscGlucyA9IDwNCj4+PiAgCQkJLyogcmVzZXQgKi8NCj4+PiAtCQkJQU02NFhfSU9QQUQoMHgw
MTU0LCBQSU5fT1VUUFVULCA3KSAvKiBQUkcxX1BSVTFfR1BPMTkuR1BJTzBfODQgKi8NCj4+PiAr
CQkJQU02NFhfSU9QQUQoMHgwMTU0LCBQSU5fSU5QVVQsIDcpIC8qIFBSRzFfUFJVMV9HUE8xOS5H
UElPMF84NCAqLw0KPj4+ICAJCQkvKiByZWZlcmVuY2UgY2xvY2sgKi8NCj4+PiAgCQkJQU02NFhf
SU9QQUQoMHgwMjc0LCBQSU5fT1VUUFVULCA1KSAvKiBFWFRfUkVGQ0xLMS5DTEtPVVQwICovDQo+
Pj4gIAkJPjsNCj4+PiBAQCAtMzI5LDcgKzMyOSw3IEBAIEFNNjRYX0lPUEFEKDB4MDI3NCwgUElO
X09VVFBVVCwgNSkgLyogRVhUX1JFRkNMSzEuQ0xLT1VUMCAqLw0KPj4+ICAJZXRoZXJuZXRfcGh5
MV9kZWZhdWx0X3BpbnM6IGV0aGVybmV0LXBoeTEtZGVmYXVsdC1waW5zIHsNCj4+PiAgCQlwaW5j
dHJsLXNpbmdsZSxwaW5zID0gPA0KPj4+ICAJCQkvKiByZXNldCAqLw0KPj4+IC0JCQlBTTY0WF9J
T1BBRCgweDAxNTAsIFBJTl9PVVRQVVQsIDcpIC8qIFBSRzFfUFJVMV9HUE8xOC5HUElPMF8yMCAq
Lw0KPj4+ICsJCQlBTTY0WF9JT1BBRCgweDAxNTAsIFBJTl9JTlBVVCwgNykgLyogUFJHMV9QUlUx
X0dQTzE4LkdQSU8wXzIwICovDQo+Pj4gIAkJCS8qIGxlZDAsIGV4dGVybmFsIHB1bGwtZG93biBv
biBTb00gKi8NCj4+PiAgCQkJQU02NFhfSU9QQUQoMHgwMTI4LCBQSU5fSU5QVVQsIDcpIC8qIFBS
RzFfUFJVMV9HUE84LkdQSU8wXzczICovDQo+Pj4gIAkJCS8qIGxlZDEvcnhlciAqLw0KPj4+IEBA
IC0zNDAsNyArMzQwLDcgQEAgQU02NFhfSU9QQUQoMHgwMTFjLCBQSU5fSU5QVVQsIDcpIC8qIFBS
RzFfUFJVMV9HUE81LkdQSU8wXzcwICovDQo+Pj4gIAlldGhlcm5ldF9waHkyX2RlZmF1bHRfcGlu
czogZXRoZXJuZXQtcGh5Mi1kZWZhdWx0LXBpbnMgew0KPj4+ICAJCXBpbmN0cmwtc2luZ2xlLHBp
bnMgPSA8DQo+Pj4gIAkJCS8qIHJlc2V0ICovDQo+Pj4gLQkJCUFNNjRYX0lPUEFEKDB4MDBkNCwg
UElOX09VVFBVVCwgNykgLyogUFJHMV9QUlUwX0dQTzcuR1BJTzBfNTIgKi8NCj4+PiArCQkJQU02
NFhfSU9QQUQoMHgwMGQ0LCBQSU5fSU5QVVQsIDcpIC8qIFBSRzFfUFJVMF9HUE83LkdQSU8wXzUy
ICovDQo+PiBQSU5fSU5QVVQgaXMgYmktZGlyZWN0aW9uYWwgZGVzcGl0ZSB3aGF0IHRoZSBuYW1l
IHN0YXRlcy4NCj4gR29vZCBwb2ludCwgSSB3aWxsIHRyeSB0byBtZWFzdXJlIHRoZSBlbGVjdHJp
Y2FsIHNpZ25hbCBkdXJpbmcgYm9vdA0KPiBhbmQgYmV0dGVyIHVuZGVyc3RhbmQgd2hhdCBleGFj
dGx5IGhhcHBlbnMuDQo+DQo+IEd1ZXNzIGlzIHRoZXJlIGFyZSBnbGl0Y2hlcyB3aGVuIGVpdGhl
ciB1LWJvb3Qgb3IgbGludXgNCj4gYXJlIGNoYW5naW5nIHRoZSBwaW5tdXggcmVnaXN0ZXJzLg0K
PiBIZW5jZSB3aGF0ZXZlciBnbGl0Y2gtZnJlZSB2YWx1ZSB3ZSBlbmQgdXAgcGlja2luZyBmb3Ig
dS1ib290DQo+IHNob3VsZCBiZSByZWZsZWN0ZWQgaW4gbGludXggZHRzIGFsc28uDQoNCkkgaGF2
ZSBtZWFzdXJlZCB0aGUgcmVzZXQgc2lnbmFscyB3aXRoIGEgc2NvcGUgZHVyaW5nIHBvd2VyLW9u
IGFuZCByZWJvb3Q6DQpZb3Ugd2VyZSBpbmRlZWQgY29ycmVjdCB0aGF0IHRoZXJlIGFyZSBubyBn
bGl0Y2hlcyBpbiB0aGUgbXV4Lg0KDQpJbiBlYXJseSBwcm90b3R5cGVzIHdlIGhhZCBwdWxsLWRv
d24gZm9yIGVhY2ggcmVzZXQsDQphbmQgaXQgd2FzIGVhc3kgdG8gcmVwcm9kdWNlIHRoZSBwcm9i
bGVtYXRpYyBzdGF0ZSBvZiBwaHkuDQoNClRoZXkgaGF2ZSBsb25nIHNpbmNlIGJlZW4gcmVtb3Zl
ZC4NCg0KPg0KPj4gRWl0aGVyIHdheSwgaXQNCj4+IGlzIGEgYml0IGxhdGUgZm9yIG1lIHRvIHBp
Y2sgdGhpbmdzIHVwLg0KRm9yIG5vdywgcGxlYXNlIG5hY2ssIHRoZSBjaGFuZ2VzIGRvIG5vdCBp
biBmYWN0IGFjY29tcGxpc2ggdGhlaXIgcHVycG9zZS4NCj4+DQo+Pj4gIAkJCS8qIGxlZDAsIGV4
dGVybmFsIHB1bGwtZG93biBvbiBTb00gKi8NCj4+PiAgCQkJQU02NFhfSU9QQUQoMHgwMGQ4LCBQ
SU5fSU5QVVQsIDcpIC8qIFBSRzFfUFJVMF9HUE84LkdQSU8wXzUzICovDQo+Pj4gIAkJCS8qIGxl
ZDEvcnhlciAqLw0KPj4+DQo+Pj4gLS0tDQo+Pj4gYmFzZS1jb21taXQ6IDg0MDAyOTFlMjg5ZWU2
YjJiZjk3NzlmZjFjODNhMjkxNTAxZjAxN2INCj4+PiBjaGFuZ2UtaWQ6IDIwMjQwNzA0LWFtNjQt
cGh5LWxvY2t1cC0xMDdlYTVmZmEyMjgNCj4+Pg0KPj4+IEJlc3QgcmVnYXJkcywNCj4+PiAtLSAN
Cj4+PiBKb3N1YSBNYXllciA8am9zdWFAc29saWQtcnVuLmNvbT4NCj4+Pg0K

