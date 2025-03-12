Return-Path: <linux-kernel+bounces-557173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A49CA5D47D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 03:46:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD9B71897483
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 02:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C32918C937;
	Wed, 12 Mar 2025 02:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="bl3CkwBd"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0E94A01;
	Wed, 12 Mar 2025 02:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741747579; cv=fail; b=W50FkhlqCoBKUNIO5HZ72mVrkE3sG8LbZ199g6Z7C7QBEzABgFBgnXrNPFizrv53rCnsoDhkGo4mIRcRyBVt3l7S1FMuEgqcs2uFphoNpMkHCh/zKrBF35wIEUcTTUEwXkQoeyRciMnBfmLhLDN6Zayie8Hx+6YBO9gHNFfJ5QU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741747579; c=relaxed/simple;
	bh=cOECiLyNldd4+MvzGSXG5ja+I8lhjuN8sH/N/EIoqcI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EQSskhV+ZIWa+s3Q4NYF1NIp3i9ZIr/ftqdgbaM/4pTKSVgeSG7OuKw4wnDApl42kbMSYIywSW/J1dyZUKpnfLjQ/Qc2C7Ba1hgtNtqLh7U302wVDnYrYlRJL2qGsfUPJkH2cfQJRXM0AMBRhRwD2Ab6KwOVmWIvhk2pbinsJEI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=bl3CkwBd; arc=fail smtp.client-ip=40.107.237.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GQKAqsz5i4PUfbITJk0HuD6lyX0NyPuncHPBMGaiQArncg8svuDh0U5EUEx93zwZb9O28vnaA4H3uVBY0rerU5uxCPWAw6Z4g7GA0R70YFUp6PgtDyLsWow737tZ7O+Qqa2gnXA2ISW6inupJt2fEV+4X5o2RttBNZ2TehXW+TH6TJ689QDYvyv+uhnLP1x7QWZ3LOk5vVLGcWoEkqfFOCOc7EfwS3GWJr6XhZhofH+oI/pEnkki4tnIlH5rQPFiPRjmY7b4tNVatfyTsus40GqX7KjTw1WdgnZ/kyZowryxaxm8sezs4hjIJWJYHf922yt1yWk6a8nRPIPPzKyCXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cOECiLyNldd4+MvzGSXG5ja+I8lhjuN8sH/N/EIoqcI=;
 b=yrWhpxDSI7s3y82nDUw0Z/geVowYFHUniyOY0b0taqlLjCnQl48RpwI1h+CXVFIWc6Ywsk84/86c3/D33Tf/R5FvPqYXe5Oe2FPro9rUY9HbiELhK8FB1uo3XoMC15LVeguNWB/LwkBiqyYRuATvJ2fooWDvAVJBgwhTeVTyVQ680uvkfcbIVmzW8AmNRHMvRZ3GHcIIKd0IPVaaNW2ulPNYYQk7v8yUXdLMHQEqIjXARlMhyqTMsakSuSEnmoi34C/P6/7bnIA8pz6FPA1JjROSBF6ktKEAGZs/uruL6qaMda+4N/JQLzH/QhIQ5ZfTwxKsK1BygQ1O41PtnHht4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cOECiLyNldd4+MvzGSXG5ja+I8lhjuN8sH/N/EIoqcI=;
 b=bl3CkwBdQIsNZ9fvrnNypmMXGc/Q2zmvdAQAhiGXoniAT83N2KJ9J4LQfpAXqI5iV2iu2OLUv8duOPRJCvptvVfeVdDd01rbT2ZTAjvASIVG66XPt1PAdDlvEx9ZmBCK30JKECf5yyU7FJG9I3XclHLKZzVgBuxV6kgsdN9YV6zJ8R/Tg9pKutZPRRD/RvR8p9FlXabUwvNvfbdZGJFt7zkrtMyLhljvuWbPwzmvSExz/7Y4qOrCeY5Bq0t6bSwszP/yaZqFXmuy/WBJ5CV88Df8Asg0x5fwK5MYZhT/FcpTdE4ycb5o5vfIgReeOHKFga1lbbIyJvd66ikn5lLxag==
Received: from MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15)
 by CH3PR11MB8342.namprd11.prod.outlook.com (2603:10b6:610:167::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 02:46:13 +0000
Received: from MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::a137:ffd0:97a3:1db4]) by MN0PR11MB6231.namprd11.prod.outlook.com
 ([fe80::a137:ffd0:97a3:1db4%4]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 02:46:13 +0000
From: <Balamanikandan.Gunasundar@microchip.com>
To: <robh@kernel.org>
CC: <linux-mtd@lists.infradead.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<richard@nod.at>, <miquel.raynal@bootlin.com>, <krzk+dt@kernel.org>,
	<claudiu.beznea@tuxon.dev>, <vigneshr@ti.com>,
	<linux-kernel@vger.kernel.org>, <Nicolas.Ferre@microchip.com>,
	<conor+dt@kernel.org>, <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: mtd: microchip-nand: convert txt to
 yaml
Thread-Topic: [PATCH v2 1/3] dt-bindings: mtd: microchip-nand: convert txt to
 yaml
Thread-Index: AQHbkoE+72dcVvO6N0apxmdWeyv3TrNuBYIAgADHT4A=
Date: Wed, 12 Mar 2025 02:46:13 +0000
Message-ID: <e459cf3c-5ad1-40c8-a2f9-d766584d4cd9@microchip.com>
References: <20250311122847.90081-1-balamanikandan.gunasundar@microchip.com>
 <20250311122847.90081-2-balamanikandan.gunasundar@microchip.com>
 <174170473601.3452705.4276708145941047362.robh@kernel.org>
In-Reply-To: <174170473601.3452705.4276708145941047362.robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB6231:EE_|CH3PR11MB8342:EE_
x-ms-office365-filtering-correlation-id: 5e1defac-ec67-4148-fd45-08dd61100d8b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|13003099007|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ajRWZW1CemFrL2FYWmNwWVN0OXRqbmlSK3VaLzNIM0szd2tXSm9lR2x6OUxq?=
 =?utf-8?B?dERia2p4aFp0eVRVeUtmRisvdk9hM2lHQXRKcXJEREZqUXBNTkN5TDArdEpS?=
 =?utf-8?B?TDZwWElRRHFIaVdPbGNkK2tJRWttQkprY1dBRzdLdU1xYjlCcWVLOWpKei9J?=
 =?utf-8?B?elR3dE91YXhkYWsxazdnSWVXTzdRSTdFUGZlc25sWFViZThuV0FieEhOTkdX?=
 =?utf-8?B?Q3hYdGx5MjFzbEVlUTl5amgrSjNUZytJSnVoaHR6MnErUThoQTdCMCtjZ2RT?=
 =?utf-8?B?RllMSS9TSk1oUHphbDlveEF3ei9rRGV1bUVzU0EzVnBmWEJqQ05NSHNaa3Nz?=
 =?utf-8?B?eVkxVVMrQTFVdUxWV0M1TGFpdGVBWWdaaExaWW9ENUVPRnpGRUpxVWtRakNS?=
 =?utf-8?B?Y0RuWTJqdXVtVHczeHdUZnQyd1d4bVRoRU92MS9WbTgrVVpkNys4Z2M3bjBI?=
 =?utf-8?B?R09WN2d3cjF3Y0Z6V3BlL2JUSUdDOXVoSm04VVMrTEJzUnZQVy9hRkRXd0Fj?=
 =?utf-8?B?bTBWVDZCTjFyQXUyM3NoNStGYTJQOSs3V3hFM1BDa0kwMDFMSlVqN0tRTkZO?=
 =?utf-8?B?VVMwb24zamNvZTR5d2kzcnBBdnV6eHBsRjRCcXEwTTBHZ1ZpSG9lNU9iUEpp?=
 =?utf-8?B?VU14U01EMWZLMHpHVFNOWnp4VnJISU8xSkZRUEJUbmhYMlRXNEl4VDNEOGda?=
 =?utf-8?B?TjlrZXVIKzdJOHE5NCtpZDErQnVYL2VFdnFSRmVTVmxscUVoRHEyN2o4UVpP?=
 =?utf-8?B?NWRMTjgyVVVIR0RDNjNhY2UzMlJPQjNxR2tqMm95N2oxVEozVVlHNmZqemVB?=
 =?utf-8?B?Y3h5cFhJZU1OcERORzFPeU9KWVJUcFlDa1lkcDBzWlFMMGdXY0dwOHAwVTBI?=
 =?utf-8?B?Q2h1RThtSW1HN0VONDVHa3VGK1dQUnlCQWJlVC9TUEs5VGcyZzlVdW9XQ0lx?=
 =?utf-8?B?K2RSU1gyNWcybkhkQkRvM2lvUk1Bajg5STgwN3lKWEF5aWY5V09ma2JWdEow?=
 =?utf-8?B?K3JGUWlqMU1jZk5ERjF0dkFnZXJ0SklnWVJiWmFUTmc2Sk1LeXk1bnlFR0hR?=
 =?utf-8?B?Q3h2UHc3OFB2Y0F4Vlg1WllsNFRuQmJoUnBJMVhhYUVES1ZyeTUvV2NJcmFI?=
 =?utf-8?B?WXFxK0dpVUdLQ0Q3RmNzZDA0TUFFMXFrK3pxdWROdEJJVW9paWtMVVNCSEVC?=
 =?utf-8?B?emt6c1FHZDloTnRFM1dZUGV0U2RtWTdONzZDNVZPbDdBRlRwZEprMThvelZl?=
 =?utf-8?B?U1JvaGhTNUJka0dkUThjVGFsa2x1WDZva2EzcDdVZVdiMzJONWk3aVMyRWlN?=
 =?utf-8?B?WE1mUW1UMUFSaENMbHAzM0ZBUjVjOGt2Vlc5Z2VYSUtjeWdNOFB6aFpNMjlu?=
 =?utf-8?B?N24vMzBKR2JzNG1KY01jd3FMdStkeFFFQmRUaUNKaytWMnJ4R1Q3WlZOZTNh?=
 =?utf-8?B?WFpFR0pKTy9qYlhNR2NFemVyZ0NjSmRFUm1PZWIvcjVHdTRNVDVVMHM1T0hI?=
 =?utf-8?B?dHVpamUzU2Q0WVd3UURJbkhBS1pXRjYyN3N1TWk4NmxQRjkrbElkem5XSzRM?=
 =?utf-8?B?YlBDSXNGVXBUTSs4SWFReGVIUDFhV3RHSzRqYUZEWmhXeTAxY3N3RTVXSngy?=
 =?utf-8?B?OVlTdDNKd1Z1UWlrbkN3R1dpK09WaVd6TDFXbDhKVlJDUkhiRlFVN1dvdjVI?=
 =?utf-8?B?VW42WkUvNjBTSHFJc0hYQXB0Zzc1eDFPakt3U1B3elFvakNhUUw3dzQ4ZHFE?=
 =?utf-8?B?cWEzakZHQi9DRkl2dEV2SHQ5SDF2bjlBeEp4WlR0SmpFVDMzbDNSaTBJYlFv?=
 =?utf-8?B?Z2FpanNFL0VvS2pHRW54UU9TRXlkbjZES1RMajk0d3NJS2c4a3BiVTQ0Z0xU?=
 =?utf-8?Q?5A6F9n0lrdZs1?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6231.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(13003099007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TkFPUkhlVlNoRjlCQ0VJUCt4MzhmY2dWT2RzakVBVWlLOUJWUkpXeDhHTDJv?=
 =?utf-8?B?VzNFcXBJOHZ1ZUNtV0JCQmV0aEJELzhYNEdyZmV1bHdBSFFmV0VKWXRqYTJm?=
 =?utf-8?B?b0l1OXJJQ1FSR2tNbitRZzNEamZjOC9wTmZDVGdCUmo5ekRHL0Z1U1h0b3dE?=
 =?utf-8?B?cWN5bkNUR096bnFUNGdvVDJzKytvR0RCdCsxd3VmbmxNczE4L29mRnpaS2t4?=
 =?utf-8?B?dmhDODU5a2ZOSEdobERjdzArdlRuNXNwWFFiZ1R5N3l3Ty9xZzJjbU1LcC9a?=
 =?utf-8?B?S2x5akhaZ0xhbUxQU2o5YjluTExhTVE5MnJpRCtlMzBNWVllK0o2VStQTXQr?=
 =?utf-8?B?RHg3dEZHeFZEZ2Nxb0JoM3hWQXBoSHR5QTh0TG50cjAvdlZ3Tk5uMEJvNGZy?=
 =?utf-8?B?ZTVrM25KdzRSQWdQNGJjM0Z2OUwwN2ZraW9LdzV4UWFVTWtHUHRpalFyV0hq?=
 =?utf-8?B?RnpnYW9SL3pLNmMxR056RFZyN1oxSmFNWEozT0RNK1IyVm1zYmo4L3QzMGhM?=
 =?utf-8?B?UUdrckliMFNCWEJ4OXlZYzVhSHNQd2wvbmRJWUVIaTlSVXNkY1UvQUl3bDFo?=
 =?utf-8?B?OHV6NGFxR2h3RVRHZXIxeFdYWXVjMFViVEo2RTRzM0UxZ3FmOTdwRGhISnFP?=
 =?utf-8?B?LzZPSFBGZFhUU3Y5VFY2UDNGUGxDOXJXblUrMXNWOGEydWZvam9lRFAyYW80?=
 =?utf-8?B?d3BCT0hYbjh3Y0FabTdjVWZ5clNQdjhsVUhlLzhLdmdab1lYeUpFWDEwd3Jx?=
 =?utf-8?B?ZWRSTk4yNGx5OGE5Zzh6d1BJTUxJOElWZysvZkR5aDZGNjRuTkpzbTVYc0l3?=
 =?utf-8?B?Zk1XQWRpZDR4WFpiZml6eTA3RU1vcUlOdlRnV1laVVJxWEw5OGtFMVJYb3JI?=
 =?utf-8?B?RThNTUp2M0lKZGc1ZVF2b3VRMzl3cVBvdis0M3M4aVZheHNHRDlQQ01GZUhN?=
 =?utf-8?B?emRzMTBYTWRGM1hpMVNxUG1lNUJtZVJ6MTB5Z3pZRG9UM2NyWnZLMW1aZjNm?=
 =?utf-8?B?M2V0MGhjSGU2ODF4NkVpdmtITzI4bnUxa3BjcHF6bWFzVGlDUkNRcEVudXhO?=
 =?utf-8?B?QWdyTzIzSVQyazVrbXdEQlpNN3F0ajNXaS9QZGpaQ2htdVU4OXAyb0VFQTJm?=
 =?utf-8?B?ZkkwN0NUbENDdUR2UFFrYi9aSGFUOVhBZ2pXV2tIOG1NNVF0UWpPeVp1bDVt?=
 =?utf-8?B?cTFlblIvS1ZKNyt4dWcxVXhpSnk4SGxiekxpYnV2QmFqeVQwNFZIcEhwUnNG?=
 =?utf-8?B?QzdIR3pBd282MWFMWlE3enVkOHBSbWkwZCthZGVFMWhyZWVnWEZmbTFOSlV0?=
 =?utf-8?B?eUwxYjEzbEZXblB0Z1ZzZUdPcXMyMkh0dnlLRUJmTE51Zitia1gyM1dxbVI2?=
 =?utf-8?B?UUt0YkN6Yi8wQTJ0c2lQZHVRaXBUY0xTYTBHbEFzeVE5c0gxejR0eFlrbW1y?=
 =?utf-8?B?TzhZcWpQeWE1UGs2MC9MUXN5VzRmZEVaRzRsUXh0L1NzWlFyVlV2Qk91MGFp?=
 =?utf-8?B?U3hNQlFRTWVIeVB5dGs1OHVvT3Q4RGs2eTFka2RiWWhzeTFVeXE0N3gzQ2U2?=
 =?utf-8?B?bGZCU2FmaDhlT3gvcjZEU3haTjFCbnYvUnErR3l5TzNScnRkcUJZV1hoa3Yx?=
 =?utf-8?B?K0RPUW5McUhyUHI1SHhBNWkrd2VWaGpjRHZhWlBWOWZPQ2ZRa2p0RlBUL0hk?=
 =?utf-8?B?VzdNMlpqUGc1ZmVkVUoxUkdZUlluSytoZUVqOXA5NVp3bFNxVUlKRFh4ZlRX?=
 =?utf-8?B?amlCU05yT3d4VFUrc0xOZk1DRStLRy9TbSszNjRxdzRBQkZWcmdFemd5WnFp?=
 =?utf-8?B?R1RUelJoaS81eU1qWXg4bjRXREEzL2MveE5QVVNjeWtvUmxzcHRNU2hQT2Y1?=
 =?utf-8?B?a25pekxNQTlrMEJsdUJ5VC9jcHcwYzU4WWRQekJQWCtBYzBxMlVVWlRRY3hH?=
 =?utf-8?B?SnVWM1hQNGRVK3N4TTcrVlkxRm9nMCtzNVI3Mk5aZmZZTjhlUVlXWFpSYlpt?=
 =?utf-8?B?UlM2N0FvbURLa3IrSG03NjRxaW9KaUs0R01wTlRNWHNzZ29peHlKZ28xVk0v?=
 =?utf-8?B?ZWt2T0JCY0IydEczL0JXS01jdWl1OUVuUmQ0Mk5GM1JZdWM3RDF1dUkvMnlD?=
 =?utf-8?B?VDVlZ0pMUUNoTldpd2gxOE9Hb2x2akYzblI0dGVTMWwzUW5sdDltaHZ3L1Bi?=
 =?utf-8?Q?kWpX/WvmEJhcJtSX+xViC4s=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <190399C48CFD0B4B839B2DD82371ED29@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6231.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e1defac-ec67-4148-fd45-08dd61100d8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2025 02:46:13.0879
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KlsvayJ7s29tLzA9W1ZF9TX4NV6cEJIgI8/3e1kjTz1Sh4I94CDPKt189x8vo8kvMkNIYMszw+/BiJhdu+7B0tiQq10uhevLL4SFuTf9tiVFg31Vn6WW9II2L0EnYM1K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8342

SGkgUm9iLA0KDQpPbiAxMS8wMy8yNSA4OjIyIHBtLCBSb2IgSGVycmluZyAoQXJtKSB3cm90ZToN
Cj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRz
IHVubGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiBUdWUsIDExIE1h
ciAyMDI1IDE3OjU4OjQ1ICswNTMwLCBCYWxhbWFuaWthbmRhbiBHdW5hc3VuZGFyIHdyb3RlOg0K
Pj4gQ29udmVydCB0ZXh0IHRvIHlhbWwgZm9yIG1pY3JvY2hpcCBuYW5kIGNvbnRyb2xsZXINCj4+
DQo+PiBTaWduZWQtb2ZmLWJ5OiBCYWxhbWFuaWthbmRhbiBHdW5hc3VuZGFyIDxiYWxhbWFuaWth
bmRhbi5ndW5hc3VuZGFyQG1pY3JvY2hpcC5jb20+DQo+PiAtLS0NCj4+DQo+PiBDaGFuZ2VzIGlu
IHYyOg0KPj4NCj4+IC0gQ2hhbmdlIHRoZSBmaWxlbmFtZSB0byBtYXRjaCB0aGUgY29tcGF0aWJs
ZSBzdHJpbmcNCj4+IC0gRHJvcCBpdGVtcyBhbmQgb25lT2YgaW4gdGhlIGNvbXBhdGlibGUgcHJv
cGVydHkgYXMgaXQgaXMganVzdCBhbiBlbnVtDQo+PiAtIFJlbW92ZSB0aGUgaWYgaW4gdGhlICNh
ZGRyZXNzLWNlbGxzIGFuZCAjc2l6ZS1jZWxscw0KPj4gLSBSZW1vdmUgdGhlIHVud2FudGVkIGNv
bW1lbnRzIHRoYXQgcmVmZXJzIHRvIC50eHQgZmlsZXMNCj4+IC0gRml4IHJlZyBwcm9wZXJ0eSBk
ZXNjcmlwdGlvbg0KPj4gLSBEZWZpbmUgdGhlIHByb3BlcnRpZXMgaW4gYSBsaXN0IGFuZCBhZGQg
Y29uc3RyYWludHMNCj4+IC0gRml4IERUIGNvZGluZyBzdHlsZSBhbmQgZHJvcGVkIHVudXNlZCBs
YWJlbHMNCj4+DQo+PiAgIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL210ZC9hdG1lbC1uYW5kLnR4
dCAgICB8ICA1MCAtLS0tLQ0KPj4gICAuLi4vbXRkL21pY3JvY2hpcCxuYW5kLWNvbnRyb2xsZXIu
eWFtbCAgICAgICAgfCAxNzUgKysrKysrKysrKysrKysrKysrDQo+PiAgIDIgZmlsZXMgY2hhbmdl
ZCwgMTc1IGluc2VydGlvbnMoKyksIDUwIGRlbGV0aW9ucygtKQ0KPj4gICBjcmVhdGUgbW9kZSAx
MDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL210ZC9taWNyb2NoaXAsbmFu
ZC1jb250cm9sbGVyLnlhbWwNCj4+DQo+IA0KPiBNeSBib3QgZm91bmQgZXJyb3JzIHJ1bm5pbmcg
J21ha2UgZHRfYmluZGluZ19jaGVjaycgb24geW91ciBwYXRjaDoNCj4gDQo+IHlhbWxsaW50IHdh
cm5pbmdzL2Vycm9yczoNCj4gDQo+IGR0c2NoZW1hL2R0YyB3YXJuaW5ncy9lcnJvcnM6DQo+IERv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tdGQvbWljcm9jaGlwLG5hbmQtY29udHJv
bGxlci5leGFtcGxlLmR0YjogL2V4YW1wbGUtMC9lY2MtZW5naW5lQGZmZmZjMDcwOiBmYWlsZWQg
dG8gbWF0Y2ggYW55IHNjaGVtYSB3aXRoIGNvbXBhdGlibGU6IFsnYXRtZWwsYXQ5MXNhbTlnNDUt
cG1lY2MnXQ0KPiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbXRkL21pY3JvY2hp
cCxuYW5kLWNvbnRyb2xsZXIuZXhhbXBsZS5kdGI6IC9leGFtcGxlLTAvZWJpQDEwMDAwMDAwOiBm
YWlsZWQgdG8gbWF0Y2ggYW55IHNjaGVtYSB3aXRoIGNvbXBhdGlibGU6IFsnYXRtZWwsc2FtYTVk
My1lYmknXQ0KPiAvYnVpbGRzL3JvYmhlcnJpbmcvZHQtcmV2aWV3LWNpL2xpbnV4L0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tdGQvbWljcm9jaGlwLG5hbmQtY29udHJvbGxlci5l
eGFtcGxlLmR0YjogbmFuZC1jb250cm9sbGVyOiAjYWRkcmVzcy1jZWxsczogMSB3YXMgZXhwZWN0
ZWQNCj4gICAgICAgICAgZnJvbSBzY2hlbWEgJGlkOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvc2No
ZW1hcy9tdGQvbmFuZC1jb250cm9sbGVyLnlhbWwjDQo+IC9idWlsZHMvcm9iaGVycmluZy9kdC1y
ZXZpZXctY2kvbGludXgvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL210ZC9taWNy
b2NoaXAsbmFuZC1jb250cm9sbGVyLmV4YW1wbGUuZHRiOiBuYW5kLWNvbnRyb2xsZXI6ICNzaXpl
LWNlbGxzOiAwIHdhcyBleHBlY3RlZA0KPiAgICAgICAgICBmcm9tIHNjaGVtYSAkaWQ6IGh0dHA6
Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFzL210ZC9uYW5kLWNvbnRyb2xsZXIueWFtbCMNCj4gDQo+
IGRvYyByZWZlcmVuY2UgZXJyb3JzIChtYWtlIHJlZmNoZWNrZG9jcyk6DQo+IA0KPiBTZWUgaHR0
cHM6Ly9wYXRjaHdvcmsub3psYWJzLm9yZy9wcm9qZWN0L2RldmljZXRyZWUtYmluZGluZ3MvcGF0
Y2gvMjAyNTAzMTExMjI4NDcuOTAwODEtMi1iYWxhbWFuaWthbmRhbi5ndW5hc3VuZGFyQG1pY3Jv
Y2hpcC5jb20NCj4gDQo+IFRoZSBiYXNlIGZvciB0aGUgc2VyaWVzIGlzIGdlbmVyYWxseSB0aGUg
bGF0ZXN0IHJjMS4gQSBkaWZmZXJlbnQgZGVwZW5kZW5jeQ0KPiBzaG91bGQgYmUgbm90ZWQgaW4g
KnRoaXMqIHBhdGNoLg0KPiANCj4gSWYgeW91IGFscmVhZHkgcmFuICdtYWtlIGR0X2JpbmRpbmdf
Y2hlY2snIGFuZCBkaWRuJ3Qgc2VlIHRoZSBhYm92ZQ0KPiBlcnJvcihzKSwgdGhlbiBtYWtlIHN1
cmUgJ3lhbWxsaW50JyBpcyBpbnN0YWxsZWQgYW5kIGR0LXNjaGVtYSBpcyB1cCB0bw0KPiBkYXRl
Og0KDQpZZXMgSSBtYWRlIHN1cmUgSSByYW4gZHRfYmluZGluZ19jaGVjayBhbmQgZHRic19jaGVj
ayBiZWZvcmUgc2VuZGluZyBhbmQgDQpkaWRuJ3Qgc2VlIHRoZSBlcnJvcnMuIEFzIHlvdSBzYWlk
IEkgd2lsbCB1cGRhdGUgdGhlIGR0LXNjaGVtYSBhbmQgY2hlY2sgDQphZ2Fpbi4gV2lsbCBhZGRy
ZXNzIHRoZSBvdGhlciBjb21tZW50cyBmb3IgdGhpcyBzZXJpZXMgYW5kIHNlbmQgYSB2My4NCg0K
VGhhbmtzLA0KQmFsYQ0KDQo+IA0KPiBwaXAzIGluc3RhbGwgZHRzY2hlbWEgLS11cGdyYWRlDQo+
IA0KPiBQbGVhc2UgY2hlY2sgYW5kIHJlLXN1Ym1pdCBhZnRlciBydW5uaW5nIHRoZSBhYm92ZSBj
b21tYW5kIHlvdXJzZWxmLiBOb3RlDQo+IHRoYXQgRFRfU0NIRU1BX0ZJTEVTIGNhbiBiZSBzZXQg
dG8geW91ciBzY2hlbWEgZmlsZSB0byBzcGVlZCB1cCBjaGVja2luZw0KPiB5b3VyIHNjaGVtYS4g
SG93ZXZlciwgaXQgbXVzdCBiZSB1bnNldCB0byB0ZXN0IGFsbCBleGFtcGxlcyB3aXRoIHlvdXIg
c2NoZW1hLg0KPiANCg0K

