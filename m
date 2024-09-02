Return-Path: <linux-kernel+bounces-311504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E1D9689F1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 16:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73D4A1F24C5D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 14:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95F4E210195;
	Mon,  2 Sep 2024 14:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttcontrol.com header.i=@ttcontrol.com header.b="bEGzLQaR"
Received: from mx08-0061a602.pphosted.com (mx08-0061a602.pphosted.com [205.220.185.213])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7730820FAAA
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 14:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.185.213
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725287384; cv=fail; b=fnc2DOrYYNx3/KfOEmdxK5acAWFH56uE9viY0km38SDttyGihmydPesYvPyWPxZ2jCidhxG7+4GL7iv8XZa9E6q+wO859ma9eI9sHxmC25Ey8sMytJv4A1IikOQXv/aVBOL458BmUjhjyOedNYhKsJr+XezLjL9CbouTC7Iz72A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725287384; c=relaxed/simple;
	bh=MDuO0YeHejQWR0bzDZdDr5lWWTq5UEXdQps+2FVacR4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lMlMHsESZPdSQnCiKYyge2FqgBYZ51epDGudcjbHYoNL/lbP3Avq/+2vmkzMoSVDg3r4cl6Owh1z0GmwkRsczPpNQYccc5QRUqbFt3qQnLN3FkZP+jVaAPzKZrse0ggXi4WVQ3euCz2mj6MkNg9gknjND7IT8JP6tK2enS1UCBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttcontrol.com; spf=pass smtp.mailfrom=ttcontrol.com; dkim=pass (2048-bit key) header.d=ttcontrol.com header.i=@ttcontrol.com header.b=bEGzLQaR; arc=fail smtp.client-ip=205.220.185.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttcontrol.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttcontrol.com
Received: from pps.filterd (m0278994.ppops.net [127.0.0.1])
	by mx07-0061a602.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 482DWkAG016046
	for <linux-kernel@vger.kernel.org>; Mon, 2 Sep 2024 14:18:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ttcontrol.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	s2021; bh=p1Q98ukIZzFe/cL6jY8hAO45s5gdwaF/WilnoecFUzY=; b=bEGzLQ
	aRAsta5mL8jPtzBFFBTn35u7eirBqRuMte+NS9TW0CNsDbLIRu1A2yiCxd22g6Y0
	FlmR6g7Nk0vAGLIhcBBUI3Spzmr4TtxZGegxkmf/tYiw1IWLSoHQfJRvO7kTQZoD
	I5xzSrJKXdIhapLQNielxXilMezLtaICi/vZN8CE9YZc2X/d/1ESiXGsXdWoQ1Vw
	GU8atu/j+mCV3s696ejfvaenHJdZQFkH7VNhl2uUHp2J3WDaPK96GNbwoBk3OyrA
	IXrAoUzXysxSH/tYXeP/UyO4QCOzdp1eVniZy2bsuhELB82jqRTCiyn40JiHrAvP
	WgjGFxuDQXoRBeRQ==
Received: from db3pr0202cu003.outbound.protection.outlook.com (mail-northeuropeazlp17011022.outbound.protection.outlook.com [40.93.64.22])
	by mx07-0061a602.pphosted.com (PPS) with ESMTPS id 41brd0252v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 14:18:12 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JineRb/MQ+s0cj7SzlAayfZ6vHRN1EUEPTArW4TB2u092fYoPBaP+lghF7G/o0SaueQAP1o/9dupxs2ntCkPnNqoUsmZNdL52UGRaWg3QdW6gxWYY+gvr9EPY3eRGSAmhisVxc6D3lwvOhCghdkL72qQKaHtcqsPYNlRVq2r/k668ogDC26T9rOQAa6sUN3gjyUBUPEsxng7vpFEj5qyXq8Ljjvs4Uu8xPDdgN0jxbD4Rz4+9z6j5oZ4G2XQepEpd6xuSXtEnbrWtJMgYVAQccBvog0ySnBRcdgCT0Rp9aOa/pHz4JQIKEv3CGKLVXbSvB0wokCVGZsm9wRrjxRLFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p1Q98ukIZzFe/cL6jY8hAO45s5gdwaF/WilnoecFUzY=;
 b=L2N+/afPuRieB2N1a0rLNvi1PfAh8P/JhyT4UBPjQzimvYPxn1YMF8YIld4cibXymqFNb4SMWS4uFyQLLD7dxGhQVgSqqj+fuHljf2vvIt5PcktcQrb2u0b3K/gBSfE3BBpgJwmTr1GUJnmAtnEGJ8kw/FP+2cdn1cHJoghJfOH4WajhGjhgSz8tLEsAO84w8zFXiZfkPWEe4FZhhYewd1L4M2NP1ttlXHe0E+DF90EA/My6wcvFykfFOlTZJ9vu0VAlCAWocTIYi1dU3n0GnhwUSKl8MCAHZIl3xWyE4jgF4CBxHxKUGTWIHQsch1GjsSJnA7kUfW+npa3MiJnGnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ttcontrol.com; dmarc=pass action=none
 header.from=ttcontrol.com; dkim=pass header.d=ttcontrol.com; arc=none
Received: from DU0PR01MB9382.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:32d::6) by AM7PR01MB6675.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:1a7::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Mon, 2 Sep
 2024 14:18:10 +0000
Received: from DU0PR01MB9382.eurprd01.prod.exchangelabs.com
 ([fe80::c41d:dc9b:3f97:1ae1]) by DU0PR01MB9382.eurprd01.prod.exchangelabs.com
 ([fe80::c41d:dc9b:3f97:1ae1%7]) with mapi id 15.20.7918.024; Mon, 2 Sep 2024
 14:18:10 +0000
From: Diogo Manuel Pais Silva <diogo.pais@ttcontrol.com>
To: Abel Vesa <abel.vesa@linaro.org>
CC: Peng Fan <peng.fan@nxp.com>, "abelvesa@kernel.org" <abelvesa@kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "kernel@pengutronix.de"
	<kernel@pengutronix.de>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "sboyd@kernel.org"
	<sboyd@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "imx@lists.linux.dev"
	<imx@lists.linux.dev>,
        "EMC: linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v3] clk: imx8qxp: Defer instead of failing probe
Thread-Topic: [PATCH v3] clk: imx8qxp: Defer instead of failing probe
Thread-Index: AQHa/ULwBX4QDqA/8Ua7zDhzNMik3g==
Date: Mon, 2 Sep 2024 14:18:10 +0000
Message-ID:
 <DU0PR01MB9382A2BBCCD8C786121975B89D922@DU0PR01MB9382.eurprd01.prod.exchangelabs.com>
References:
 <DU0PR01MB93828B0E6808E33C608BC0E29DD32@DU0PR01MB9382.eurprd01.prod.exchangelabs.com>
 <AM6PR04MB5941651E3920794104B3D24F88D32@AM6PR04MB5941.eurprd04.prod.outlook.com>
 <DU0PR01MB9382F1AC496F22A20C074BDE9DDC2@DU0PR01MB9382.eurprd01.prod.exchangelabs.com>
 <Zs7gXhohOyQ/abOf@linaro.org>
In-Reply-To: <Zs7gXhohOyQ/abOf@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_6d12e765-bdb3-4a42-8d1e-507ff5c9fe67_Enabled=True;MSIP_Label_6d12e765-bdb3-4a42-8d1e-507ff5c9fe67_SiteId=5638dc0c-ffa2-418f-8078-70f739ff781f;MSIP_Label_6d12e765-bdb3-4a42-8d1e-507ff5c9fe67_SetDate=2024-09-02T14:18:09.837Z;MSIP_Label_6d12e765-bdb3-4a42-8d1e-507ff5c9fe67_Name=TTControl
 -
 Public;MSIP_Label_6d12e765-bdb3-4a42-8d1e-507ff5c9fe67_ContentBits=0;MSIP_Label_6d12e765-bdb3-4a42-8d1e-507ff5c9fe67_Method=Privileged;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR01MB9382:EE_|AM7PR01MB6675:EE_
x-ms-office365-filtering-correlation-id: da2f63ff-360f-429d-ed97-08dccb5a12b3
x-ld-processed: 5638dc0c-ffa2-418f-8078-70f739ff781f,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?6hxgFfIAqaQHJsS3O6bNaTCjWV/cBOmJGCOOv/00GwhK4T2hf2834gVmjw?=
 =?iso-8859-1?Q?vZnNeDad3rJjnyx8nWoNGlb43/b7qJzPIZ8hX3x3h3qfBPgo01WmkcFHv3?=
 =?iso-8859-1?Q?UlTlpDFCTdgnIaho+8kRkLaRqPAG9B2hpxnCjoCklYTJpeFOIpCc46BX2l?=
 =?iso-8859-1?Q?o1LJbXmBLOdnx8dI2xNfg9H4rvpAEfajor3YBwqBVHjshj9NvqBJg7p1JI?=
 =?iso-8859-1?Q?ArNs5XJN37ONBMOONc/77LftJOYWVJnoZN7SxXLyxsujZn9v9KjwzfTwhs?=
 =?iso-8859-1?Q?P2BnBd+pcrpsLw5F55Q2Pqgsc3oSj3nXnVtyROLe4VNwk1Ar9QMyoUJKVg?=
 =?iso-8859-1?Q?ja6YHHwK/I2A8MIGVRIGH0HDH4FKtNzYwWid1Afa9jw5qmyUAvorFGlB1M?=
 =?iso-8859-1?Q?FKz3uIfI90moqtf5enwDANcKDJ9cgzoC6Kgt+N8FMSjDMIqHt9lbVQrPd2?=
 =?iso-8859-1?Q?d/71gczc72avG4QdzfrF+mK+P39C/a/e12xmJGSPoVVB35k4SXR4Wt4ZCX?=
 =?iso-8859-1?Q?zCgQzYjSIFY0fo5mBAKU86kDNvmk+fip/hsu8g6BXclH9N/xAjJ5tDYtwh?=
 =?iso-8859-1?Q?1M/NUjWv58ty7/Y7CZ3evOzZIOQDD88dsR3GkhdmRGs8Yt5KVz/SNvhwSx?=
 =?iso-8859-1?Q?BPTByhUYaa89cW6++ypc7Bf87TZI/dtk/2l+gUoUflS/L6Uioqr8XY8DFE?=
 =?iso-8859-1?Q?oxZ2Gw7e7AdH7SYszVCxQM8OJYsFDHhGNX6DmPsrZ/yWsoZf3kEFhvcke0?=
 =?iso-8859-1?Q?GioEk/8NwLCA9zvKAtGXL8dtCGGW2LcbS7mJe4nfOuTquPTrLBZJedxanF?=
 =?iso-8859-1?Q?d8h/VUxnsta53PuQBvRkOKSPD6EEfZr8PkdDKVuZMoNQ9difF1DiHSh/cB?=
 =?iso-8859-1?Q?0tf8oi8K9VnCbe8RrqNiG5/ab6ChdDA6y/pfegQr+Cth0WCSl3Q8TE4nff?=
 =?iso-8859-1?Q?co/5Zog6aP7NzOrMqrM8aFoX4erXiCEkWjSpYbM+ZT6OFOAD6o19uM9xvZ?=
 =?iso-8859-1?Q?G42P4l4mwCypMj3tbr7h2VCsKA4t5fNLwXcYLAP64+8ZjEQjAFIX3YFeu7?=
 =?iso-8859-1?Q?BZloCZRZ81nXSiM1NcW3bpR05GQL17mQ9HUzYn+u9/9428geh7Gl0StuUS?=
 =?iso-8859-1?Q?nN9ayHqwmQ4urqurwmGq9MFSDDXlE+loC5g6MdzqkcILOkxDQM0Oj9in6P?=
 =?iso-8859-1?Q?dUnSERSNTuHg+CfLn66tpXdUEX0B1maLkAt+w0/zusILV8E8rvMCmtMSDs?=
 =?iso-8859-1?Q?QgurH63KABTvBgSpQiwB+Gf158KCziZQeryb7QA53X550o09Vj4CFoODTX?=
 =?iso-8859-1?Q?HJu9i8CEx2YH100NiyHNY5s2LhICX1KGkHoMy3iEbtr6EANBeKqmFr1Mlb?=
 =?iso-8859-1?Q?jeL5cxhuIlX7+253wHOvkfDIgbMXn+hvcqF8+yPu22q+jPJV8pq899DG/4?=
 =?iso-8859-1?Q?OTO/8HWYKwkjmVnd3Auwx88MaTco7lfQB4J8XQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR01MB9382.eurprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?7dgVZw/o9SnoxY5MVbsI8Mi3Z6Yv1gM8Fdm/6qmayW/6vvTlgnb0YczOmO?=
 =?iso-8859-1?Q?cX+hPQG2gjhVSqm9nde7qWicBzeUJzrN35T0hhXBxuK5FxiGGLCePTF/e6?=
 =?iso-8859-1?Q?RwrJgP8FDBjd26V5cPtGEltp5kUfAuGrsj3l7qGzrupOzvNfvj5eRdKbQ6?=
 =?iso-8859-1?Q?oKgveaLMWZq4dsAXX9+TyY4VwraXyioJeZHiEzwSZlqedLlbL5LaUkz+JK?=
 =?iso-8859-1?Q?VJGvbLS4ylzTmVcSMBeC3jw0q4h618hiBEcYYo0WLfeQUsiL5O+zfSTZgz?=
 =?iso-8859-1?Q?Fet3z8i8sSSvfUCqHKXD/cx44NGy/cgRYMuJFa1tO4OSNXGOxPvP10Qo1I?=
 =?iso-8859-1?Q?7ZKEVwHsJ6W64t153CYQgjtK/Dg5VsqzVDKvxtDQfvVTE9r3qvwkhdJSes?=
 =?iso-8859-1?Q?NMlgiU0ovZV2ujxPvgErpPcFjraioHa8kFpGYqbnZfNUJhJIzeewjIcveS?=
 =?iso-8859-1?Q?3nUlSsjGF0+7FWiFrI9fN7lBSOdF+YYrp/F+/8a6MXtcj2ryDJKsS3lhyb?=
 =?iso-8859-1?Q?etqeg2w5xr6g4GbBKGaHaVg9rYsZmRLTRpR7ZBmZYmkDye5GHFSiwA6oAu?=
 =?iso-8859-1?Q?RmvyeOgHXqtCCHYJ+leTS2GI85nRK0I+P/3AtvnnqDNoAHnAmz1BqAeSLh?=
 =?iso-8859-1?Q?X2wWEZS47j19yckFUP4ohui9uNBzW0G039GQNRxeQHhMGaORaoO5Q+M5ez?=
 =?iso-8859-1?Q?nW2UmtFMePF0Y2ZmSiUENl+xEXH6yqE02wQI9cKepntR4XH/TmUt6LT/yV?=
 =?iso-8859-1?Q?lAzwyu0SZyypr496PJfxqUZRLQzsh4UJiL+cwyCMlSh2dUis1GfaT4g6cT?=
 =?iso-8859-1?Q?cO+0MQWq1blA6VWYo5wvwdR1Xo1rg62D25ym1MsKxVdwGO8Do2wG0/Fxzr?=
 =?iso-8859-1?Q?DmHNv4xH2IEzKBnUa2yq8qS73VNzv+ON21aHOE1oBP38Vs0aU+bjDHsLUV?=
 =?iso-8859-1?Q?Sxd6uHmPScKmTTO5a5O3GiaJfe+2OFIMx2JZegwWeLKNhCOnwDCWyx7rfB?=
 =?iso-8859-1?Q?GftbFnHsBHP9+eRr/WOYxSjTdQiXUH2WCSg/XjEmQMuzckQEzji/PrITAV?=
 =?iso-8859-1?Q?bd06igV/fDeqeedV901pSAeeuUqkLy5jl2bijjWMdbp96QWBcWh4T49flp?=
 =?iso-8859-1?Q?cfEgP/CcCzg5e9i9rW7BUbu9tw5+ETfJyaHWqNAh6Ui5UGypk4gLl9zUQh?=
 =?iso-8859-1?Q?+NPH7c7zSHzfZPKuGValW64uGL2/5bqVTYBUq9wLIG6yCNHvxOrlhozIdD?=
 =?iso-8859-1?Q?AHecmGvITtpntXIN9cmP8ez27WwAYnHGt0IY3OOiWzlmdi6RmTaO1eiVfa?=
 =?iso-8859-1?Q?ES9MVPRGf6bVeH0flZV5hw5HYCeNnBlMZelkIONdEGA+Jxy5W1MZGs/NTd?=
 =?iso-8859-1?Q?4JZ0uvavQk9ZReUTtcysicnaZ8UTDa5Py3wEEYZNpVOvXWEYVrjKF5w2uu?=
 =?iso-8859-1?Q?bdztxAtr4NJvd82zJOpK8XVkbE2SoHdPLbAg5rgFPyZUKkpzlGcYeTmuJE?=
 =?iso-8859-1?Q?PMZI5pO1PMr45lQg9cVQwiIIjChmDx8B+AvQa/ZEZvgwwMPKfOIid6/Bjx?=
 =?iso-8859-1?Q?UmUKfY2Zyys2dITzBxG6cW5m2o1Mj4x796/BkNPs6wLuikkaZPrDzSr2P3?=
 =?iso-8859-1?Q?mtgae0b//DbF1UTvKkjqajtFcu7tQtZUfy?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: ttcontrol.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR01MB9382.eurprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da2f63ff-360f-429d-ed97-08dccb5a12b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2024 14:18:10.1004
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5638dc0c-ffa2-418f-8078-70f739ff781f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cSH9XGCPg8co14RXQz3+j6QbVYd7jL6AW9YaMq90zaIyBqkvwBYKvPbcTcj6iqGaDvweyqg1mCa72V7GvzKE0VD+dBdL+bg8DM2JF0Bdwys=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR01MB6675
X-Authority-Analysis: v=2.4 cv=C4i7yhP+ c=1 sm=1 tr=0 ts=66d5c924 cx=c_pps a=thxcoxaKSrYYC4Q79zeVCQ==:117 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=EaEq8P2WXUwA:10 a=9E89HhfwiosA:10 a=EZQmGfNXMHUA:10 a=nxb4IF0AAAAA:8
 a=KKAkSRfTAAAA:8 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8 a=IpJZQVW2AAAA:8 a=pGLkceISAAAA:8 a=gwMhcH0e1l1swrN3wTsA:9 a=wPNLvfGTeEIA:10 a=muotpCzfy8uUhEcWaHt4:22 a=cvBusfyB2V15izCimMoJ:22 a=1CNFftbPRP8L7MoqJWF3:22 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-ORIG-GUID: cYGSGC0xMZiMysG8XBmfxvEp9LfWh8Dd
X-Proofpoint-GUID: cYGSGC0xMZiMysG8XBmfxvEp9LfWh8Dd

When of_clk_parent_fill is ran without all the parent clocks having been=0A=
probed then the probe function will return -EINVAL, making it so that=0A=
the probe isn't attempted again. As fw_devlink is on by default this=0A=
does not usually happen, but if fw_devlink is disabled then it is very=0A=
possible that the parent clock will be probed after the lpcg first=0A=
attempt.=0A=
=0A=
Signed-off-by: Diogo Silva <diogo.pais@ttcontrol.com>=0A=
---=0A=
v2: change from dev_warn to dev_err_probe=0A=
v3: refresh patch=0A=
---=0A=
 drivers/clk/imx/clk-imx8qxp-lpcg.c | 4 ++--=0A=
 1 file changed, 2 insertions(+), 2 deletions(-)=0A=
=0A=
diff --git a/drivers/clk/imx/clk-imx8qxp-lpcg.c b/drivers/clk/imx/clk-imx8q=
xp-lpcg.c=0A=
index d0ccaa040225..cae8f6060fe8 100644=0A=
--- a/drivers/clk/imx/clk-imx8qxp-lpcg.c=0A=
+++ b/drivers/clk/imx/clk-imx8qxp-lpcg.c=0A=
@@ -225,8 +225,8 @@ static int imx_lpcg_parse_clks_from_dt(struct platform_=
device *pdev,=0A=
 =0A=
 	ret =3D of_clk_parent_fill(np, parent_names, count);=0A=
 	if (ret !=3D count) {=0A=
-		dev_err(&pdev->dev, "failed to get clock parent names\n");=0A=
-		return count;=0A=
+		return dev_err_probe(&pdev->dev, -EPROBE_DEFER,=0A=
+				     "failed to get all clock parent names\n");=0A=
 	}=0A=
 =0A=
 	ret =3D of_property_read_string_array(np, "clock-output-names",=0A=
-- =0A=
2.34.1=0A=
________________________________________=0A=
From: Abel Vesa <abel.vesa@linaro.org>=0A=
Sent: Wednesday, August 28, 2024 10:31 AM=0A=
To: Diogo Manuel Pais Silva=0A=
Cc: Peng Fan; abelvesa@kernel.org; linux-clk@vger.kernel.org; shawnguo@kern=
el.org; kernel@pengutronix.de; s.hauer@pengutronix.de; linux-arm-kernel@lis=
ts.infradead.org; sboyd@kernel.org; mturquette@baylibre.com; festevam@gmail=
.com; imx@lists.linux.dev; EMC: linux-kernel@vger.kernel.org=0A=
Subject: Re: [PATCH v2] clk: imx8qxp: Defer instead of failing probe=0A=
=0A=
On 24-07-02 08:10:44, Diogo Manuel Pais Silva wrote:=0A=
> When of_clk_parent_fill is ran without all the parent clocks having been =
probed then the probe function will return -EINVAL, making it so that the p=
robe isn't attempted again. As fw_devlink is on by default this does not us=
ually happen, but if fw_devlink is disabled then it is very possible that t=
he parent clock will be probed after the lpcg first attempt.=0A=
>=0A=
> Signed-off-by: Diogo Silva <diogo.pais@ttcontrol.com>=0A=
=0A=
This patch doesn't apply cleanly.=0A=
=0A=
Please respin.=0A=
=0A=
Thanks!=0A=
=0A=
> ---=0A=
> v2: change from dev_warn to dev_err_probe=0A=
> ---=0A=
>  drivers/clk/imx/clk-imx8qxp-lpcg.c | 4 ++--=0A=
>  1 file changed, 2 insertions(+), 2 deletions(-)=0A=
>=0A=
> diff --git a/drivers/clk/imx/clk-imx8qxp-lpcg.c b/drivers/clk/imx/clk-imx=
8qxp-lpcg.c=0A=
> index d0ccaa040225..7bd9b745edbe 100644=0A=
> --- a/drivers/clk/imx/clk-imx8qxp-lpcg.c=0A=
> +++ b/drivers/clk/imx/clk-imx8qxp-lpcg.c=0A=
> @@ -225,8 +225,8 @@ static int imx_lpcg_parse_clks_from_dt(struct platfor=
m_device *pdev,=0A=
>=0A=
>       ret =3D of_clk_parent_fill(np, parent_names, count);=0A=
>       if (ret !=3D count) {=0A=
> -             dev_err(&pdev->dev, "failed to get clock parent names\n");=
=0A=
> -             return count;=0A=
> +             return dev_err_probe(&pdev->dev, -EPROBE_DEFER,=0A=
> +                             "failed to get all clock parent names\n");=
=0A=
>       }=0A=
>=0A=
>       ret =3D of_property_read_string_array(np, "clock-output-names",=0A=
> --=0A=
> 2.34.1=0A=

