Return-Path: <linux-kernel+bounces-274654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1C7947B2A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 14:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43C7E281568
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 12:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E03F15921D;
	Mon,  5 Aug 2024 12:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="xw/oMq/O"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2081.outbound.protection.outlook.com [40.107.102.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6F5139CE3;
	Mon,  5 Aug 2024 12:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722861801; cv=fail; b=lfimrb8uNf5HgqjBcfs2W4/vqKcMSHkIG8iD4o4f2Kan4dZOZvfbS0P0nlEipUuwJB1M0mq8iMaLr2H9N19V+WUkGjG+e0X7P73GFcpqsrLQUMS/XkNV9T7RZFdOXa/YaWeFXYWIsj6FQ44bejU0SqAwlPkJsq4Sfu6O0hkzCBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722861801; c=relaxed/simple;
	bh=YDNV4wwH4C1ShDymGvKFPN2wtIMs+1PBhqZO30G3GvA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y2U8FPw3I3YW1fvnYtLSj2hIM+vz6pudDDXv9NfE3gniRckSuRTZYTAdjv80+N+sEGm8wIoJP67CcfA1N409Cv9tqkNgXpJ1XJ+e7MKrI6AetRmS9UYVmvq1MRBKNx6gPsvugYl3j5509DCTNETl2ZPvkIKqqj7uFiU+Uu+ALAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=xw/oMq/O; arc=fail smtp.client-ip=40.107.102.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yyRS/QoC9caEZqMc9PyDNRJb5e/UaHTN+/HJNC1uvZPWgr0YzN4Os9gjFC+594zjjg5P7CCNsiWE4XAPu53qB2ZxFhmSDYCM4LoC+IN8JWq438GuB602KZGhBaY2ec+kxDDtD/AiZw3PNa0Gq7A6lOZUEzLkwzXjd6gGjeaGAFDUolI1OEoGdvkOkq268wc0tuNwmQTCFKcHvYl67fpjHuFxWRu50uX35tWkPVFC4vJds0sauqnPUeW/Qj8bTWrre/rVOScgY5d5n7TpGq1IItl7D1vXmvzIZFEUu4VGfCajyDD1kiIIoiaemrAnL+vEhqWcOK1H6pobQoTtcSuddg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YDNV4wwH4C1ShDymGvKFPN2wtIMs+1PBhqZO30G3GvA=;
 b=xUwF7yiEVIeTRrbP1MRoH9dRiJfpiu3IQbz+FyqlhXXtg9Bb/6Wx3DqlNL7EMrDC8xu/Lmwhl4A7Cb1LW9y0IwszjmUkMnkaVgv8hbQOgzMJ6zF514gnpz1P+9koS37MjY47dR46bhr1Tkc9O2OZ751CuFDv+MPg7GSzkFmMRqVVyHQWSrF6oU8/wqhpufDuIpnDxXdVcyWljFYQ2FtJX/LltR3uAaKryfCo6t552EhMW8dTmA8ej395f9kOs36EVOl70Fpn84oetDDqctHGvCdx+02Arnj07WtqvPhuicOljKYsK61VsvLNAUukJMHvfxA08+DkyaXAzz80qp0jaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YDNV4wwH4C1ShDymGvKFPN2wtIMs+1PBhqZO30G3GvA=;
 b=xw/oMq/Oi/NLOhhCfOTcolqsEDJiEmiBK+lAbYq3H41TEPfys0UWbeMqQ26AuZPILWak0c9jWYpQ0cC8B09JHg4tyv64yRI1s6Ufxmeq15GMmDuXIo3G+AJC6IFXsXF32ZJWwUCfVWoTmSxfSJ7RL10itLmBxkZFbxmn7OcLo/pSal/okMXzFk+sSFkbCoUEaB2rOqeArRpd3kdV+DmqAeaSeCWdwDB+fM2keKDSCvkC7lD8TMe99lxrkyHh+T2/T6KXgLKVB/bngvhGHcXNHnro+KNDlQvgsdqsqFyzLH7AhF0SJI3n1ug0YSrLJrqNUCk5GcpWCWk5KRZ2foyCwQ==
Received: from BN9PR11MB5289.namprd11.prod.outlook.com (2603:10b6:408:136::10)
 by SJ0PR11MB4784.namprd11.prod.outlook.com (2603:10b6:a03:2da::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Mon, 5 Aug
 2024 12:43:15 +0000
Received: from BN9PR11MB5289.namprd11.prod.outlook.com
 ([fe80::93b4:c87a:32b4:c395]) by BN9PR11MB5289.namprd11.prod.outlook.com
 ([fe80::93b4:c87a:32b4:c395%3]) with mapi id 15.20.7828.023; Mon, 5 Aug 2024
 12:43:15 +0000
From: <Andrei.Simion@microchip.com>
To: <broonie@kernel.org>
CC: <lgirdwood@gmail.com>, <claudiu.beznea@tuxon.dev>,
	<Nicolas.Ferre@microchip.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<robh@kernel.org>, <alexandre.belloni@bootlin.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <Mihai.Sain@microchip.com>
Subject: Re: [PATCH 1/6] regulator: mcp16502: Add supplier for regulators
Thread-Topic: [PATCH 1/6] regulator: mcp16502: Add supplier for regulators
Thread-Index: AQHa5LhEn97L1tgXxECJyG0oBvR81bIT7XGAgAAYs4CAADuWgIAEXu0A
Date: Mon, 5 Aug 2024 12:43:15 +0000
Message-ID: <8a0e279a-38e8-44e8-9045-2186e24a5a47@microchip.com>
References: <20240802084433.20958-1-andrei.simion@microchip.com>
 <20240802084433.20958-2-andrei.simion@microchip.com>
 <98f91a56-946c-4a40-b908-45f4c6c6d66e@sirena.org.uk>
 <f318439f-b520-4b86-99a7-eb9a2e47525f@microchip.com>
 <e0db4f2b-ce4f-4560-b586-1d8dbb75c7ff@sirena.org.uk>
In-Reply-To: <e0db4f2b-ce4f-4560-b586-1d8dbb75c7ff@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5289:EE_|SJ0PR11MB4784:EE_
x-ms-office365-filtering-correlation-id: b8e484d9-793f-461d-440c-08dcb54c2cf3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bWp3cUovTTZKWXJwNGw5bkFYK2p6Wmk5eFQvYzhpRHJZNlVBTWZ5S2dqeTRo?=
 =?utf-8?B?RWhSOVNpS09WYmsxM0tQSXUwbE5oSE45c2hQRVBzVnJIbnhvMThHQUpjYnEx?=
 =?utf-8?B?bW4yWkxBajQrMkhLNE8wZ3lqaGNVNzBrRjExQ29RRmQ5VVBMMTZjUERCOTVl?=
 =?utf-8?B?ZlduQUtPRlhCdHlSZHl4blRyc1RzdE8zS2gwQkdjR0REdkg4OWhxMzU0WTZJ?=
 =?utf-8?B?c20rNDJ5MkpxTUMvaE5YRzdMQVg1bGY0Tzlxc2dpVkZCd1ZBY2tzOWRjeERy?=
 =?utf-8?B?ai96L0tKVWg2anVFR2FTb250UVhLcEFVRlZSVjd5alNKWFhyNlE4dnNhaGh3?=
 =?utf-8?B?eFhXaFJCRm1jRjJYQ3ZFSWVNQW5EdmNiTVprcTIyMC9taDFDbDI2SGpKZHcr?=
 =?utf-8?B?RVRzSXJRcWxtQ2w3N0N4YUVjMld6TENIck9oNUtvQzBDMTNETWowSUxKQnNv?=
 =?utf-8?B?aGE3S0MyQThqSHR3dHBqbUtvYmlrUS9lTmlvQ1orbDh6eWZjZkhJU25pQTF3?=
 =?utf-8?B?alBnMm1sQzRvVFZHd3pHcC92VFpXMzcxOGtHRThUL3hUZHFOd3ZIMVpxTi9X?=
 =?utf-8?B?U2ZHN1VtOTFCdXM1N2FyaHU0OXZXcGc2YTFsVHlpWG42YjR0VTdxR1FJMVBq?=
 =?utf-8?B?b1VYdW45RC9RUm0rOW9KZnpNSndIaDhxVzFsYWRmVDZIWlI4Q3R6YUhsVXBS?=
 =?utf-8?B?U2xYVjNEVmU5UmRkWjVzYnNoMEdwWVI1eTNoaVlZWVhnaVN6NkREb2NzUkdv?=
 =?utf-8?B?TktUcmJkSXIzL015K1A5WHZIN0dPZ1lTQUpVSlZKU2N6aStURXY4Y2FwZllk?=
 =?utf-8?B?ZzBkejFZRk0rZHpDZURMOUYzd1RCdlVIS00wa2hEWElzK0s2UW4wbE44OG9N?=
 =?utf-8?B?NVd1a0RRbDV1c2RXSnI2MzlIOEpKQzlCdjM1ZWtQOWc3ZThVMTJzc0lZaktB?=
 =?utf-8?B?L0pOY3E4V2hVUVlraGJuMy92TzQ3UGFiWDV0VzNFbE5mVlFGbTJ2ZmF5eXRw?=
 =?utf-8?B?VW9xanU5dG42Z3l5bTlMMVduSnE3SitVbVdGdmRVRHFRVk52Sk1adHk0K21o?=
 =?utf-8?B?NmZLRUZzZFRJb0prRlVOOXpmNkw3OS9ZNW9UNGt5MzZNejA4Zk0vRzNxU1Rk?=
 =?utf-8?B?NTZIUlN2WXk0a1drcitDZCtPcW5mbmJVMFFJUnVYUkNTeWVqaHJqdzZsckkw?=
 =?utf-8?B?Y2dkYUlrTGFiNDVzMkQ3UGN0WXVYdHY3NmZLdGZBNzRyclRyU0kwbHkwOGEw?=
 =?utf-8?B?OFVJWEVYOEZXK3lhdDduQ0hJdEFWNHZHSDdpVDBoM1JFZWkzUUhZaDB6S1Mw?=
 =?utf-8?B?eFVDVnhzc2ttUmZmMEVNV3JiRmt5VjdRNnNudnpyU3liRmYwWHdBOTVzeDh5?=
 =?utf-8?B?UDU5WGE0NzFQN2JQdm5jSWJ6UTNJMzE2VmtYMDJ5OWl1Z3cyTklrUmN1Rmc3?=
 =?utf-8?B?bjNiVXpPU3pRMnU5WVR4dnFJUmlmbmQ3eVo2QTdDSHdxaE1peFRIUllWRm5R?=
 =?utf-8?B?NzVyRXU4c3JnMCtYKy9ITzBLNW8zYTY2MGwyUDVJZ2wrL1VXT24vYjZSTG94?=
 =?utf-8?B?M3p1TXZlNFRTTHU4cmlLOGcrYlpsYmlmclhGWG5aN0g3WktMditkVnZVK3Y3?=
 =?utf-8?B?SUQzdjdrWm52Q0FBZzBRMUdOQXBPVmRuT0g4QUFUc2x1SEdvRGxPbEVIVHBF?=
 =?utf-8?B?dUlYdEw1MGJOTE9GY0FyMkZiRDJFdW9aVDNvaFpsMk5XVTVLVWFST2pFNTBv?=
 =?utf-8?B?djZ3TDZneHFNQXVBU1VicWxnRjFvRDRoTmFZQVBtYmI4WnVwZnlSS1dORkhP?=
 =?utf-8?B?OThtczlMd2RwRXZaSXBTZ05PbzA5M1J0OHV1a2k0aSs2VEpkN29RR0dpNlcx?=
 =?utf-8?B?ejRwU1JlNWNyRDAxRWZkcVdNSVp5T2dCbDFYYU9UZFJybHc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5289.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WHhldktvUGpVeFlKaUtsVEJXWk9hWm5xR0o2RjhlZnJheFZLVWs0YmlGb1p4?=
 =?utf-8?B?SnQ4YlhLQndmdlkyVng4Q1ZqSG5QT3Jreng1UFJvWDNrbjEzVk03UkNDVmpP?=
 =?utf-8?B?aHNpSFAwZHY2L2lqS25pbGxNZzJkSlJnMXhGS0l4Yi9PblNDYXRRVmg3QWxG?=
 =?utf-8?B?bmF1RVBDVWJHUXQ2R1NHQ0ZzRHBMYjZzb0FUdUFvN0d5ZTJadDVudzkyVlc5?=
 =?utf-8?B?UmtUSlhNWU5GWDdjUXdMMFY2cnVlYVhWczlnbFVYUnRVOTZaVXdqTUxvbXdm?=
 =?utf-8?B?Z2NpT0VCS0Y4SGVHcE0zK09VMlR6RytNOStqSjNwVmVkdWFEcGprbGZmR3E1?=
 =?utf-8?B?d1Q4TlNWdUJyVXEzM0JlRG9ZdnNKWGtSbFp0akU0RlY0bGJid3ZaRFZRSFI2?=
 =?utf-8?B?MCtTQTYxQjhYZWhndWV4M1BxTDltN2t0cHo3a25PUDduYXNJTUk2ZnZTN3pP?=
 =?utf-8?B?SkZGSXVSUEowZEl2VDVsR3J2eUdFakZhRnp3NTBKdGV4NjZVSFF4ZW00cGJy?=
 =?utf-8?B?UjZseFcyaDI4SFdyNGRXQ3BIYjE4d2R3YlZHZ0VOYnlmeWZZMVRDaDI0K2ZQ?=
 =?utf-8?B?M2w2WGh5ZCtSOXRSZ3FtUjNQZGVXN0tuN0liNXUyKzRCYWxqcldHMmZ0YmRR?=
 =?utf-8?B?QkpNUkphTGxCWlB2eWhKS09raWtJS2xvUnRoaVowNUVCUjBKU2RBVngwWk9v?=
 =?utf-8?B?dnRQTEVXVWpIcHlkV1N1S1BSTDVwRnpiT1U0TVdra0tJN3VGcUQ1TVZwSkhV?=
 =?utf-8?B?ZnpYbEZqcHhZUzJ5bU53V1EvTlJMdStrMnFCOGJnSmZ0MEpEVkxmZlZvTlRE?=
 =?utf-8?B?ZWZWZTd5czZEMTJvTU5YRmlrQk5oWU12NURkVmxRQnlyOVNVcDZhaXVXWm1q?=
 =?utf-8?B?a1AvNkhKcmxuNnoyQ0ZmYWN5N1p2K1U0c0RCc2RYMzk5U1FDeXVpTFlZbjdn?=
 =?utf-8?B?WlpSMEhKOTlnY0lXTUxPeHFHWU5JL25ERjlGUjE2V2tYUG56Mnh5emp4NkNF?=
 =?utf-8?B?MFpQV0dWeWgvYzB6L0lrR3NyV0w5SWRCUENBdmZGUjZVczlRZjJXY1gzQitN?=
 =?utf-8?B?U1I2L01xVS9RZGpkK0p2K1dBOGpEUXFNUmE4R3RKSmlhanZ6VWg3ZS93azFy?=
 =?utf-8?B?WHVXU1ljUlNwY09RZUVRQ0V3ZGhSS1E0Vis4WXNYTEVXTm1iQURsdXdXWGJl?=
 =?utf-8?B?bStwYU85VWM1L0dGbHhPZkVZbnQyTVY0TU5OS3E3VHZMVVdXUWZDNmFLano0?=
 =?utf-8?B?MENYWTE2Ri9mN2NtNFp5V2pPdUxveEV5RE04ZDdoUk5KbjFYZXpBb0Y4T2Np?=
 =?utf-8?B?T3FwbWd4MDVWZDFHYTdjYVdxcHcwWG8vSngyT3Z5QVFPczhzbVVXL3NPMDU5?=
 =?utf-8?B?ZTQ0RENUZ2gybkp0VVpGV3JEWXIvVS9iNSsvTnpteXpwcGhqZ3ZYdGtCQ05S?=
 =?utf-8?B?by9sRVVUOVFidmNZNHZjZ1RGS0RYT2h4dFV2aS9yYjhidFF0RlFmWVhEcGRK?=
 =?utf-8?B?Q2UyM0xCWTBGUG14K1NmRDQrSENUZEp2RWtXQVNBK1VxR3UvSjhFdFZRa0lB?=
 =?utf-8?B?cWpYL0FmNExwYjV4YmVHTjZzMjBmMzFmdURmN3JISWRicWhsOS9QeW1aT0Zv?=
 =?utf-8?B?ck5VTWlpS2QvM1lCc2F1U0VncUR2M3NFTm5DaHloK25jSmVFSy9Id0pDZnNn?=
 =?utf-8?B?NlRMYms1ODIvV0UxdUIxbDZZNWdSQVVxNTFZc0d4QlE5NkpIVmRZRXliZkR5?=
 =?utf-8?B?YmdpTHRpMFhWVExGTlo4QTFxUTQvZW9VNDdjWDBCMEJaRHBvM2dWQU1MZVRT?=
 =?utf-8?B?bFV2dVBReGlYNlltbzJnYlk1TW8vdjF3cTJRRndqL21RYlpWS2E5cTB2eW5N?=
 =?utf-8?B?ZDN5L083R3hMWnJpSnMwUWdsam81RDlWb29wbXFJeVpBeHppMEJWN1kvVjZO?=
 =?utf-8?B?UlRpN0V2RmdSWDRvSEVVenRiN05oVG90UUM5WGhrNSs0OG1qVjZnR1VCZ3ZC?=
 =?utf-8?B?dUJBUE9uNDBndEh6V3RNaGh2NUFEOTlpZ3dXbmlEMkFqUlpUclhGSGg2RWxW?=
 =?utf-8?B?RXRsZHdQV3NRdXYyMzh0amJLNHZUQk5OR0dUVFFDNjdmR0tVS1RjVGwwL3gx?=
 =?utf-8?B?RC94L05zNGpIK2wyblBsbTM3dUM4bTJXeGczQkJGYkswd2hKa3k3KzhSajAv?=
 =?utf-8?B?cEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D058CA506B09F040869088769C42D16C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5289.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8e484d9-793f-461d-440c-08dcb54c2cf3
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2024 12:43:15.5426
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WVOU81t4rWrJmBb5I/VFGuVCgpSwCiSxVjLuJt0qm0S1QP19iLt/2+d5qJ35QZEJU1nK/Pt9Gz7jALv0aQJEoHxwkAMdPtYlbMuBVS3s9vk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4784

DQo+IFRoZSBzcGVjaWZpYyBuYW1lcyBmb3IgYSBnaXZlbiBkZXZpY2UgYXJlIHN1cHBvc2VkIHRv
IGJlIHNwZWNpZmllZCwNCj4gdGhlcmUncyBhIGJ1bmNoIG9mIGV4aXN0aW5nIGJpbmRpbmdzIHRo
YXQgYXBwZWFyIHRvIGRvIHRoYXQuDQoNCk9LLCBJIHVuZGVyc3RhbmQuIFRoYW5rIHlvdSBmb3Ig
dGhlIGNsYXJpZmljYXRpb24uDQpJIHdpbGwgdXBkYXRlIHRoZSBiaW5kaW5nIGluIHBhdGNoIHNl
dCBWMi4NCkFsc28sIEkgd2lsbCB1cGRhdGUgYWxsIHRoZSBkdHMgYW5kIGR0c2kgZmlsZXMNCmFj
Y29yZGluZyB0byB0aGUgbW9kaWZpY2F0aW9uLg0KDQpCZXN0IHJlZ2FyZHMsDQpBbmRyZWkgU2lt
aW9uDQoNCg==

