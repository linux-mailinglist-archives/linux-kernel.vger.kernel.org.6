Return-Path: <linux-kernel+bounces-202792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA728FD129
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 16:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5BDD285B83
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 14:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F512E403;
	Wed,  5 Jun 2024 14:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="UVTbbqf2";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="3nNbuzaN"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192CB25774;
	Wed,  5 Jun 2024 14:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717599124; cv=fail; b=SgJf7xnhYAB5VNN97eCpjUbE6228OlckEC/GWDIvVGz7tz842kGN6xMrXRmV/OaIQXAcE0Nn8tpo7h/PI+n0UJfeGpuOIMWHYkdXmsA8E7fzaqAoqGLlZb+nDXBAKjTb8x8LB9qMfpU3JeTJtbfQuvLoftMrqA3hZfn3YyEQrn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717599124; c=relaxed/simple;
	bh=6tsIlrEOjVLnAYi5sabsLcgHH9QaA4DMV+cww9hdYXI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=k5wGgLMl7BVZXvh/VWAevtfdDT7iNTX8sGxiLqerOEpjoxOGE5wRlXcdVIcT+zHsI6DezWG77aysdfWdqwvb6Lfl8qlzzKFwv1GdewJBehEX3/gtQD0z4u350qwkOJph1mH7nMHjahzHmX3aVJkrAJcTNJuSk8WqwESZ/crhfPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=UVTbbqf2; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=3nNbuzaN; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1717599122; x=1749135122;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=6tsIlrEOjVLnAYi5sabsLcgHH9QaA4DMV+cww9hdYXI=;
  b=UVTbbqf2042BF8Yw1sUpFJ/Wy40Bnw5wDpNSuPy83Lk8HCYr543LksrI
   BaOJpmTwNe8JFQxZXXVNoDEhjyt+6ttMhIEdqM+TBn8Li+U578mM8sS4h
   qHJ0oltra43NdhPnTlAzOTZSNXMtkgECW/YSetZHQ9uY85n15Dx+ZR9Ui
   jZ2sGG8sfow+U7YRL6ZZjXOEScuKW0H1T5/L1xS9RKgXkw3SrzLsr3IpM
   A48dOyJSm/umy8b1x3OFv4kb6Y8NizKykfZBds/Ro51xTzDoYCh9Dr0Qn
   2YzZhMb33/J2DNDOqYeCKCmhgKExOea5hu6aM/fkKrC7Wqo1wp0f1y6JP
   w==;
X-CSE-ConnectionGUID: XKKeJsAPTZCUg0xtek6lWQ==
X-CSE-MsgGUID: aBeAjK4ATI2UmQr8JJjrvg==
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; 
   d="scan'208";a="257862775"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Jun 2024 07:51:59 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 5 Jun 2024 07:51:30 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 5 Jun 2024 07:51:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L+utgRvLIS74HE8teT4MR2qhjOCLB8jIoH8f++nxxPpRBJ8T2KDAP1KHNrSAUz1coL0UXxeqbP7OECdN/giqGbcKIaKG8syai37noIV3uNjAzq3oLWl5364pl2+86cuLH74QEEJVK+Umb26GhoJTNPxqjI5SvLZ04nhqk2PtlzgvP1tu0UQzHs28ESnNM9eY7b/qCc+dkOBitESWirkJoj/U4FA1moPlDkLdwBROCZ4g9B/1U+vBMjMibLPrOEBhzUEBGFmDq7KoxCG5wY8jPfKhIs7psqxezgUHMtIUkOH7JE9MURe/I6+60hST3RRQqPXZaRVpfh2qgSa5uYbRRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6tsIlrEOjVLnAYi5sabsLcgHH9QaA4DMV+cww9hdYXI=;
 b=n2iwTh20S3Gv9hXZqR4AWzy9iZ1X0PCACDJLTeupV0JzER77gZU9vXHuGzDotVDvn1tXIRzKbKklmsm3n5BbEG+tvPWIT76gMz73GNg25TLWD0yrVJTbQ+3ggdSx705OctG8cfIr6O38LINbT1azZvKSP/r0fiVflc8Iv6I8/oMIx9MiB6Yj0MQNnfWyKgACS1/E9HkteNGAJSZNAwtfa7Rb9fWLbaxCyIsG0EPmZpTbZmWy3GreBeXP1CjiT7ggbdlZYbK/JCymrUtNLqPg/rC/9DX4CTgZ/pksbQbg/RZfo7e/i7Vok60Af9YnhvxSW0qG6KX+zTsSS7bHfEt+WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6tsIlrEOjVLnAYi5sabsLcgHH9QaA4DMV+cww9hdYXI=;
 b=3nNbuzaNDfol718AsLJmsdn7RTI06kTKHotXxYcqOG1DfbpS4kvPd1isW43LeeTcmdq5oaI/LA/Wj+5nc5mLiJW0VX3bFU4idr8ycuaHGAdDLTBU7dof5M8U02lQiKimNPYj7BRR9vlDROBz30iYqe83iKimCJ4J9DAEPfIYd67Aga5PDxKmLGGkB56LFjlPJEcWpFTMAHsQVSGwm/5Au7VakEKPkGsWpLrEMAQVL8uJpnRnSYktjK77Z7pndKDyfK1/7WE0rWRwtCGz/h8Iv62r3X8MIlfNnpzKxQpuQYgJHlWwJISS1ui9CvjXBWO+aU1VTv+1LlrBFboeyjOPTA==
Received: from BN9PR11MB5289.namprd11.prod.outlook.com (2603:10b6:408:136::10)
 by DS0PR11MB7335.namprd11.prod.outlook.com (2603:10b6:8:11e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Wed, 5 Jun
 2024 14:51:23 +0000
Received: from BN9PR11MB5289.namprd11.prod.outlook.com
 ([fe80::93b4:c87a:32b4:c395]) by BN9PR11MB5289.namprd11.prod.outlook.com
 ([fe80::93b4:c87a:32b4:c395%5]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 14:51:23 +0000
From: <Andrei.Simion@microchip.com>
To: <kuninori.morimoto.gx@renesas.com>
CC: <claudiu.beznea@tuxon.dev>, <lgirdwood@gmail.com>, <broonie@kernel.org>,
	<perex@perex.cz>, <tiwai@suse.com>, <Nicolas.Ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <alsa-devel@alsa-project.org>,
	<linux-sound@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: atmel: atmel-classd: Re-add dai_link->platform to
 fix card init
Thread-Topic: [PATCH] ASoC: atmel: atmel-classd: Re-add dai_link->platform to
 fix card init
Thread-Index: AQHatmeJnAzYtMVVRUGLQr0BpcgrurG4QygAgAD/twA=
Date: Wed, 5 Jun 2024 14:51:23 +0000
Message-ID: <21b228d6-77eb-4e5e-a935-779fff4b5e24@microchip.com>
References: <20240604101030.237792-1-andrei.simion@microchip.com>
 <87tti8p9gc.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87tti8p9gc.wl-kuninori.morimoto.gx@renesas.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5289:EE_|DS0PR11MB7335:EE_
x-ms-office365-filtering-correlation-id: 30afbeba-5751-4107-3dab-08dc856ef80a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|7416005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?dWFXNzgvRllTTW00bGpzN2VRb3NWNWs3bXBWSVdQYmFuY25Ta3kxclh0M3J6?=
 =?utf-8?B?S2ZZa25kcTkyMlNkckppZXh3ZVFDa0xvRndiVDJ2K1Y1c3p6dlI4TGdqZnJ3?=
 =?utf-8?B?amdleTVaaGwrR0hnQTVpd1lJTUVpNXNhaEJueCtmeS82OFcwSUwxMGNvTnF5?=
 =?utf-8?B?TVRxTHJNclVhdDBuak45OE1wZVhFTW5kVDRHTkZ4aTF0UDBRQWdqVjBUMUV3?=
 =?utf-8?B?dDFENmJBcCt3dXp5c2ZZb2UwWW8xbmpEanMyU3BtcitLY1ZyeWpPVlRacW1a?=
 =?utf-8?B?bzVjZDJKZ1A4cDJnelJCS0srNlVIcjMxUWdpRVJEczdTZ3RlbTdSUXdsN1Rw?=
 =?utf-8?B?QkZ6UjBQckRVaEh4Tit2R1ZqeFlFbE9BajdiU1VtT3BwQUZuSExodmpvSnhj?=
 =?utf-8?B?YUxIb3dvamo0Vm45MmxHNDJGMlpBZWdIY3dWZEpWL0pwYU1Sem1Db2FEOTRM?=
 =?utf-8?B?aXVWYVBCK3c1NzJvSEkvK3ZDNEE3M3o5L3hhTlhjc3FYbXIwMkFXaWJrd05F?=
 =?utf-8?B?TStRWSthdWNDTUZFcE9yVzlaS3hBWGZBWWVNM25JK2kvRkpCdDlsVmxZUUtO?=
 =?utf-8?B?cGF0dVFIUFFWblpnVCtJbFNTNDdCZERPOWI3bXZyb1ZXZkZwdE9IRndzR0FM?=
 =?utf-8?B?cndaMFFEclM5b3l6OEprRlpsTjVza29qMGpzcTkvZWxkVEF3RWJKZ2tRVUpm?=
 =?utf-8?B?MFRaOGZwQUtWWktNcmpuS1BwOU5EME0zWkk5ZkRXZ3U0dm43dnRHSUNPeGph?=
 =?utf-8?B?c2ppby9RUm9QVE5LN1hPRDBSWm5ycjJTVGRMaDlueldoSENYZXIyVUJsMms5?=
 =?utf-8?B?eUpQcC9ReWJZSmtBRlF6SkNPSmN6SGJ2ZlU0R3kxcWozNXBtTUUwNHJsRW9a?=
 =?utf-8?B?RVlYTGNHektRYjdtRW9kMEN2L0gyVTR6UXZNQW1BblRUT0c5ZFllaGJ6Wm1t?=
 =?utf-8?B?aE5EczF1VWtlVHRxSkhoUlo5TUhyd2NnTUZNY3dUS1FSSks0d3l3YmtPWXRR?=
 =?utf-8?B?VEo5YXBCb2V6b1VwT0dYc0lkMWZ3ci81aFU2V3FTYlRlam90ZFVEVkg2RVcw?=
 =?utf-8?B?aC9GOVdVbWRPQkRsZ2MxRTBpMzQ2c3ZKd3lUaWR2VkRPVGV1NTdHdFVvUmZq?=
 =?utf-8?B?OXRlQUdJMDBoSHlhUTZLTHBHK084NFFXSW5OSHorMzFkWHIxazZzUzF6Q2wz?=
 =?utf-8?B?NURJTzVWbG5MUmQvT0hoeHNzQW5jU0ttQmdFTEFYUW5xaTN2WmlPSldQMDZ4?=
 =?utf-8?B?N0lCZ05adElwbmJwWjdybUZ1TTFDMjczVTBuM2hYOEVxUVkrajF4Tmt0SlVC?=
 =?utf-8?B?SjlXWmZYVVE5b1pJeXI1a2NvWURwcEo3QmdpaVpTVmN1ZDZDUUoyQ0QrSVp3?=
 =?utf-8?B?NmFUS1hYVjR5R1FkR3ZPNzlldTBVb2NITnNsbDV1OWFFYmdIbndhWm1kYUNE?=
 =?utf-8?B?b1I2Qi9PMXJPZlZjR2pUdHZ4NG1NZkxobHJzOFJRWTlZcCtUY2ZmUWs3NEhw?=
 =?utf-8?B?VCs1bGZzUUk2MTV4ZEtHckM1c0x0SW5OaGVSN0VUQzdaK2h5K0lRZmxCSEtP?=
 =?utf-8?B?aC9LazRiUDN0RXlINFhyaFcvY0NPZ0t2ajQ2dGVyWG92cmkxZXJDSUpUZ05a?=
 =?utf-8?B?R3NjMXBWcmhha3ZCV0R6ZXV1cE9UZE9QV0lPOHpEVzV6bGszYlU3QVRBcmpE?=
 =?utf-8?B?cUUrWUI5ek80TDcwazNsTUhXeHI3dVp2cmVJUzNRVzkxNVlnbXVnbEhvOW12?=
 =?utf-8?B?YWJJMFhvRDBwU1F0OTdLTHYrU0FISWUwN3BjU1ZMQmVudEJQcVdSTzlzM2VN?=
 =?utf-8?Q?SPQuIwyfU4LhZlwXstifZpCNqsqEL9TngOQz4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5289.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(7416005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aU0zWTVJczJIdHUzNXFDdFBxS0lHdTNSUE9IcHZhczRNMWlJeHRtNFJQNlZZ?=
 =?utf-8?B?MzNTb3Vabmc0SGdjSXRWam5BKzllVU9FSkoyekViZGtObDBXdmlncWk0WHV0?=
 =?utf-8?B?Qit0Mk9NQnlqaEZpQW80MThIb3hkWHpvSlM1WE0vZWdvYU1xQUwxaVdWd0tr?=
 =?utf-8?B?Y0h5T2xQSmY4S0FsenZ3c3NWV3FZOFlkc01KSzNjUzV4Y0VLUlJnbjRpNStX?=
 =?utf-8?B?VzQ2NjhySkZvVUNPdWY5Q1kvUTRDVzdhallGYWJpVTU5c3E4UDh6aGRSL0lz?=
 =?utf-8?B?RHArWEttU2hRQ1poeE1iOXRKVFVvaWpWSUdHNEhxU2w0RlRsdzhkRmV4MERF?=
 =?utf-8?B?TlpybVZBSmVLVHc4a1lCQVFHZkFwSTREeFhNOUlHVG9wTVRDUktySDQ0TlBr?=
 =?utf-8?B?MlRXSXg0aXdTWTFRSzk1aUsxVU43Y2p5bDRRSmp4dFlxTlVjM09rc0lUeUh6?=
 =?utf-8?B?ejY4ZHFXYlVUUjZMY2xta0NnYjFucldyaW9BaUlOd1hoRzNmWDcxN1JZb2tY?=
 =?utf-8?B?b1NvQ2dVM0UrRmxBWk9jVFBTSVNLUUdrTElVZ1JiWWp2N0Y3ZTVuNHFuSU81?=
 =?utf-8?B?NURTdlVSN291ZFJIeVc5USthZTByeGFuK3cremtaeXhxVDRFTmJUMFdMakE2?=
 =?utf-8?B?Z3ZmcEhuelU1RXhrVEI1SEVqdHFFdHl6dHBsZnI0OWFsbkJaTEI1N2M3R1E5?=
 =?utf-8?B?dnI2V051eU9PV0dqRE5adGpWVFlYL1hLakUrYUh1M3VINlJVR1dzZUtaa215?=
 =?utf-8?B?WUFUZzBFK292K2dDTGZtckRjeXdjTjg5bGRScjZxNCtqeEtYdWt4OWNuUWZz?=
 =?utf-8?B?SkhPc3ZpM1dLSDRQM1JyektRSTdObzFIdUNRa0ZKSm9Pa3BmaytpQWl5S0Rv?=
 =?utf-8?B?R1J1WXh5M1d4TFJNYlZHeHR3UnkzSTBIVG1ibno1bUxVQ1ptS055cDFaYVl2?=
 =?utf-8?B?VVRCanpFMWc2TnAxcEo0Vk5VVDFDWUs4T25uWFZNQjVBdEl6a1RRQ3gyUm15?=
 =?utf-8?B?L01GTTZRWHhKQlFDenVRYTFYeWlSeVJBRjJlck1zU2RNNjJQc2JZR1hmaWYz?=
 =?utf-8?B?VnZnUGRBaVJJRHFpVmkyUS9ab2RSWXB5ckNBbUpISjZCY1dXVXdETmxPYVJT?=
 =?utf-8?B?ZTgvZHFxOE9QcHRvQUdXaldGQzdQdExTWFlNdXV5ay9VN1dUeVBPYjJBY3Iw?=
 =?utf-8?B?UUV6ZmIxdHRKMWUvRFRHNVpCVE9idWRVbjJwczZoQmZzdnVWbVYvcmsvcHcy?=
 =?utf-8?B?L0RsdVB3WWYyRlUwbmxpQ1RmWUtIK0E5S2pTc1MzMGtmYlQwWU9vL296QzVE?=
 =?utf-8?B?aGRPYWpaYmZ0NnJodElxTnVVZnIvblNYcHc0MENrMHBhdDJic25YbXZIT09o?=
 =?utf-8?B?bGxJR0pFNUtiTzRSUmxJS0xPTGZ2ZTVFandvbmlCdEI4VmFqWVB0MjA4ZWFx?=
 =?utf-8?B?YWNURVc4aEliMFNxcmc0RjhReFE2T1IzY3JQM0FEQWtESWZtWnU1K1BwdXVD?=
 =?utf-8?B?Y1R4OWNPaEdyNkVKTGpIWExWM3J3M2tTbXJQRE50TEVidmQyR21zWkdkbDJa?=
 =?utf-8?B?bjNFLzh5Z3c0OGg1ZmtXL2lDQnRDS3MyOTQvVTUrRWpMc1lFUGJrK0lwcklx?=
 =?utf-8?B?Y1VmajVyNUdhbnIrL2dGZXNySjFLblJRdGh1NS9LeERYMTMzUStrL3Q1OUNJ?=
 =?utf-8?B?aEI2eWlFYVlDbUlyb1hiSXVlS292ZEFuUm9ZNUwyVld6UEJURTVNTVNXeTFp?=
 =?utf-8?B?ZmRnd3JpZ1UwS0o0UUFOaHdLcU85Q3NCSDVBcHBUeFpXa1RHRGdmQUtTUmVo?=
 =?utf-8?B?TTBXNXBJNnovZGpSN3lyLzZyZUlTOHE0VHRtSjB4ajNFV293N1dlZnJjQzNI?=
 =?utf-8?B?WEpFMHM5cTJLY1FyRkxZWVpaNE1NTEVhdG5DUHdSUE9Xd0xkakVIaTZUcDJE?=
 =?utf-8?B?TFZWTVltQy9lQXNYSC9GYS9qVFRMQU5hSzdMUmJwVzArZ05YOGg0MU0vUFBN?=
 =?utf-8?B?WXBRczlUTUs2WTVaamU2TDFSbXZNZzllbTBoUjdOTHB1RGtsWVg3Wk5vTi9J?=
 =?utf-8?B?emR5dlpGc04vTXZaWjNPUjl5bzVJRm9uNitSUHBSejc0VWROZXErOWlUaUMw?=
 =?utf-8?B?NHBxb2dvb3QwbHhOQlNnTlg3K3BldU1ncFNBTCtWUGh5MThaLzE2dVZFaU0w?=
 =?utf-8?B?RkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <25C8D5E023C17F4A9E2764F0500D769E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5289.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30afbeba-5751-4107-3dab-08dc856ef80a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2024 14:51:23.3517
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w+erO54G4ZhrY7/Em44l1FLIis2bHtzlp2pR8vfPF7mZg+oeejorY2QIVC2QNH+ZfGNIPPFCFT2KcTXTRT5YxAiz6JjR+x5AJrNfjqdFEOA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7335

SGkgS3VuaW5vcmksDQoNCk9uIDA1LjA2LjIwMjQgMDI6MzYsIEt1bmlub3JpIE1vcmltb3RvIHdy
b3RlOg0KPiBIaSBBbmRyZWkNCj4gDQo+PiBUaGUgcmVtb3ZlZCBkYWlfbGluay0+cGxhdGZvcm0g
Y29tcG9uZW50IGNhdXNlIGEgZmFpbCB3aGljaA0KPj4gaXMgZXhwb3NlZCBhdCBydW50aW1lLiAo
ZXg6IHdoZW4gYSBzb3VuZCB0b29sIGlzIHVzZWQpDQo+PiBUaGlzIHBhdGNoIHJlLWFkZHMgdGhl
IGRhaV9saW5rLT5wbGF0Zm9ybSBjb21wb25lbnQgdG8gaGF2ZQ0KPj4gYSBmdWxsIGNhcmQgcmVn
aXN0ZXJlZC4NCj4gDQo+IFRoYW5rIHlvdSBmb3IgdGhlIHBhdGNoLCBhbmQgc29ycnkgdG8gYm90
aGVyIHlvdSBieSBteSBwYXRjaC4NCj4gDQo+IEFja2VkLWJ5OiBLdW5pbm9yaSBNb3JpbW90byA8
a3VuaW5vcmkubW9yaW1vdG8uZ3hAcmVuZXNhcy5jb20+DQo+IA0KPiANCj4gSSB3b3VsZCBsaWtl
IHRvIGFzayBmb3IgcmVmZXJlbmNlLiBXaGF0IGlzIHRoaXMgInNvdW5kIHRvb2wiID8NCj4gKElz
IGl0IG9uIHVzZXJsYW5kIHNpZGUgPyBvciBLZXJuZWwgc2lkZSA/KQ0KDQpJdCBpcyBvbiB1c2Vy
bGFuZCBzaWRlIGxpa2UgOiBhcmVjb3JkLCBhcGxheSAtIGNvbW1hbmQtbGluZSBzb3VuZCByZWNv
cmRlciBhbmQgcGxheWVyIGZvciBBTFNBIHNvdW5kY2FyZCBkcml2ZXIgb3Igc3BlYWtlci10ZXN0
IC0gY29tbWFuZC1saW5lIHNwZWFrZXIgdGVzdCB0b25lIGdlbmVyYXRvciBmb3IgQUxTQQ0KDQo+
IEFuZCBkbyB5b3Uga25vdyB3aGF0IGl0IHdpbGwgZG8gdG8gZGFpX2xpbmstPnBsYXRmb3JtID8N
Cj4NCg0KQSBwbGF0Zm9ybSBkcml2ZXIgaXMgY3JpdGljYWwgZm9yIGludGVyZmFjaW5nIGJldHdl
ZW4gdXNlcmxhbmQgYXVkaW8gYXBwbGljYXRpb25zIGFuZCB0aGUgcGh5c2ljYWwgYXVkaW8gaGFy
ZHdhcmUuIFByb3BlciBpbXBsZW1lbnRhdGlvbiBlbnN1cmVzIHN1Y2Nlc3NmdWwgYXVkaW8gcGxh
eWJhY2sgYW5kIHJlY29yZGluZy4NCg0KT24gdGhlIGJhc2ljIGxldmVsIG9mIGhvdyBpdCB3b3Jr
cyB3aGVuIGEgdXNlcmxhbmQgYXBwbGljYXRpb24gcGxheXMgYXVkaW86DQoxLiBUaGUgQUxTQSBz
dWJzeXN0ZW0gcHJvY2Vzc2VzIHRoZSBhdWRpbyBzdHJlYW0gYW5kIHNlbmRzIGl0IHRvIHRoZSBh
cHByb3ByaWF0ZSBkcml2ZXIgdGhyb3VnaCB0aGUgQVNvQyBsYXllci4NCjIuIFRoZSBkYWlfbGlu
ay0+cGxhdGZvcm0gY29tcG9uZW50IGlzIHJlc3BvbnNpYmxlIGZvciBtYW5hZ2luZyB0aGUgZGF0
YSB0cmFuc2ZlciwgdXNpbmcgRE1BLCB0byB0aGUgY29kZWMgKENsYXNzIEQgYW1wbGlmaWVyKS4N
CjMuIFRoZSBjb2RlYyBkcml2ZXIgdGhlbiBjb252ZXJ0cyB0aGUgZGlnaXRhbCBhdWRpbyBkYXRh
IGludG8gYSBQV00gc2lnbmFsIG9yIG90aGVyIHN1aXRhYmxlIGRpZ2l0YWwgcmVwcmVzZW50YXRp
b24gdGhhdCBkaXJlY3RseSBkcml2ZXMgdGhlIGxvdWRzcGVha2VyLg0KDQo+IFRoYW5rIHlvdSBm
b3IgeW91ciBoZWxwICEhDQo+IEJlc3QgcmVnYXJkcw0KPiAtLS0NCj4gS3VuaW5vcmkgTW9yaW1v
dG8NCg0KDQpCZXN0IHJlZ2FyZHMsDQpBbmRyZWkgU2ltaW9uDQoNCg0K

