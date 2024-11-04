Return-Path: <linux-kernel+bounces-395410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0193B9BBD99
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 20:01:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 213C11C21B15
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 19:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD111CB9F1;
	Mon,  4 Nov 2024 19:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="LFu6RRDk"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8717FE552;
	Mon,  4 Nov 2024 19:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730746878; cv=fail; b=l092x/r3d75d8yV9p9Z+nYG0zS1DqDbcazeSv6W8aOb90jO4KmDah3SWV47Fi1bLAAEZtVzbP7/IGqYsV0266vXntNhKv43ViKOMFToKkHKVLMmfISwrvKqQ4KXbeXettHxcKdstOjnf0en0PEx5p65c8Gl+8myRoVZP1RemT14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730746878; c=relaxed/simple;
	bh=fAlh+RkV1iC48LZ1TzhzVHuRtgsRo2ZCLhE4x7y3mR4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tSvVFpr5e8zppBN61U1AqOWbTK90LuexH9ERdfkBWzfjt6v585XaEWKt3aYDJ8QdsK3RN/cj0kDcWeMCAS0Jl+xtVfZjJQPowsKTVLJTmcF0RiLDrdZoFpt4rqEKoaKPtADgAS0lhESSkFPeSHmT6WZBdOKs2bBh3GCeaHerpfQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=LFu6RRDk; arc=fail smtp.client-ip=40.107.220.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AkIF9Xub2g0kNg2L5vEIRCsCyGilUXBVZMxDpF2/nHn1mv8M/mG0N1EgOkfNZpsn1hWswlaaSG3BX7AVUd22BdXbxYHvR/BEjZtNkR9xpbgC0/oWBEbWQ1LSsnOKP75CWN/KMCAJ1zvtkEa9ehpi4hgN3xf2Phs66yojX+0A7mswYiUAv1FsWpz1ob2XsrPTa8WS3XqhTUnvmVnTIymLqoEvpgad0A3EI7bGy9IrteAHvyTKd8MecY1eNr5acSApjHgBxenCzR+hW8C7bfEg6JHU9/ZzYvwytlLjSkgGyNgozz7aqO4/D/1AjVJaHavhK/J3qc2wGaGJwq0Vyt/X3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fAlh+RkV1iC48LZ1TzhzVHuRtgsRo2ZCLhE4x7y3mR4=;
 b=MhnXMPaxk+hVX1QhwTwdF+H2fDrkRjOb1IBycLt1Sjw+oU8LLsXl/X/4gzczsytkoHuwBudwcbCm+lZs8lX30/ZAjuKSEJx+J+KvoaczG4+kdlxDVg0FaHD6jgfg0PDt0pYbVhbW9RmRwg6JefVdlgv6ycZGg/AaJGIOZsIhuV6ME/FNIDa5NOVUS5Up2+Mnmfh5MgD9t555I1x5XhF5CDezRmJWZzGqeIqBrj2oQZazIKAZJie+SvogroNmiZzGSveWHPu5FZ1LhzAuyk115JbSbVb6IvS5CyqWzZpeHvipsXlTMmrpzmlXPzs0EOm7XmrjcREDoHH8zezGzcw4EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fAlh+RkV1iC48LZ1TzhzVHuRtgsRo2ZCLhE4x7y3mR4=;
 b=LFu6RRDkKbTB0VYQiIM0v+DY/wNQdK62bCNxS2DscLNRhzsZ5LopbEtmq/rnVf4tnX7WLNa0RhvwMlB1oGAm6OEYWy4IiUlpx1mxDBDU2Lrx7vFFa4lkcQpr/kFcu1rgjQZ4VUG4Ul+XpT8hGehiiUP0W6Ca10ibXplTIT9hajI0tWupvBfGgZ6cjkgoXbz+4FVLa0opJLSN6obz9mrwt0OMSZlGufr0jn+FmgHjm8EpPvqDEDOIsQsRPAHMcfTgi0idvlPRpoIohZgRFUq6R5SLSTTXp/liqErx9W1vosnfEgYK2JM0z2KLL3ROvQeJY6E89odOg5DAI5Io7kMWvA==
Received: from CYXPR11MB8732.namprd11.prod.outlook.com (2603:10b6:930:d6::5)
 by LV2PR11MB6021.namprd11.prod.outlook.com (2603:10b6:408:17e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Mon, 4 Nov
 2024 19:01:05 +0000
Received: from CYXPR11MB8732.namprd11.prod.outlook.com
 ([fe80::67aa:b655:6890:4bfe]) by CYXPR11MB8732.namprd11.prod.outlook.com
 ([fe80::67aa:b655:6890:4bfe%5]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 19:01:05 +0000
From: <Valentina.FernandezAlanis@microchip.com>
To: <jassisinghbrar@gmail.com>
CC: <paul.walmsley@sifive.com>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
	<peterlin@andestech.com>, <Conor.Dooley@microchip.com>,
	<conor+dt@kernel.org>, <ycliang@andestech.com>, <dminus@andestech.com>,
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <linux-riscv@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<Valentina.FernandezAlanis@microchip.com>
Subject: Re: [PATCH v2 3/3] mailbox: add Microchip IPC support
Thread-Topic: [PATCH v2 3/3] mailbox: add Microchip IPC support
Thread-Index: AQHbJtqDr4vW5fbFsES/YDv8qYTG/7Kkv1+AgALKtgA=
Date: Mon, 4 Nov 2024 19:01:05 +0000
Message-ID: <ee8b10e3-ccd2-409e-82d0-612107f3fe26@microchip.com>
References: <20241025125110.1347757-1-valentina.fernandezalanis@microchip.com>
 <20241025125110.1347757-4-valentina.fernandezalanis@microchip.com>
 <CABb+yY3cDD-E-P1MPKQjdX7R2XVVKjwXUW-BANWcz-9aR6kskA@mail.gmail.com>
In-Reply-To:
 <CABb+yY3cDD-E-P1MPKQjdX7R2XVVKjwXUW-BANWcz-9aR6kskA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYXPR11MB8732:EE_|LV2PR11MB6021:EE_
x-ms-office365-filtering-correlation-id: 0325741d-669b-46e5-a6b7-08dcfd0308d4
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR11MB8732.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?OGlnRktJZlRQSE1iazBMTHRtK01SUzBqbWUyOEJLZ09mNjhxaHgrdmhyL0JR?=
 =?utf-8?B?MmtkRU1UY1dXOS90MjJkVFR1RUhzWGdtOXR1N1VsRDRMcXVMUTBucGZRUlc5?=
 =?utf-8?B?ZzNWSGtqSGtmNkpLd25nWHlOaFg4QjRoa3RyYWJtcjhCOFZQTW9FT2lzS2lB?=
 =?utf-8?B?Qm0zb05pR1FtTTBJVEJaYnY5VVBxTk5aM1I0azgwLzZqdnpRcnVid2t5MGly?=
 =?utf-8?B?TkJTM09OZEN4Y2xGaDgzU21HWk5NMXhvMjFCNUNmZ1BiejRnY0tNTm5xOEZi?=
 =?utf-8?B?TGJ0eXorS0MxVi9nVHpxa3pqTVk4TlE4c2x5VWR5ejFkSHVUMkFXTS9EeDhH?=
 =?utf-8?B?NkhpSXRQeTRGRGhCL0JVS3k0UWtYR3QwQW1wMmFVSU9oQTl1Z2dvdzE0MXpq?=
 =?utf-8?B?ZkpHd3JzVEsyanJ0a3d6VitiSHhHaTREZ1ZBakFEVmd1Z2hka09VMGsyYWxx?=
 =?utf-8?B?R3IybXVZVGNUcGlPUTc3S3RTOTUwb0RaQWFReklydTZMR2t5OEc5ZU9HTHU4?=
 =?utf-8?B?blNGc1hIVjlwaWdKSGJJNFhqb3A4THd3a0JHeHZrYnluV1dteVRXZUQ0cndm?=
 =?utf-8?B?eGp0L0twbHF2eVd5ckFVZmJ5ZzRMNzlqR2hCMEx1aXZDeVBxUitkblVwL0Iz?=
 =?utf-8?B?OEEydmo5Y25XdnlXMEQ5WnJLTmJUckJvUGFBZkZlOFFBSk42N1NSVldPWTFh?=
 =?utf-8?B?Z2Y3YmlZbEI3alVIQmg4YzlaSzMzUVZvMmY0d0NsNXl3SVlRbnRoMUlGRUVP?=
 =?utf-8?B?cVRwSnVVL2ZWOEVXNWZTYnRLamN4aGg2RXpaeU9nMnozZHdjdjhxVVZOd3k4?=
 =?utf-8?B?SFVaRllkcjNvM3RVU0lSYVVsMEthbFVIVEc3SEYwMmMweWRmWjB3RTVMa05K?=
 =?utf-8?B?UlB1cnpzQno2OW1lcTk0dHZiV3Fad2QwVkhNdUhUSDZHbHpqWnh0SmwydTFJ?=
 =?utf-8?B?V1hONzRUL295OUVTdW1yOVRjZksrNmw2em0vVHMyOGpKek9pR0w1YzJGblJN?=
 =?utf-8?B?VnRwckJDb1ByL1o0Y1E3Z3RGSktvaXBjdHl1by9venF2T29lSkVoNnc4V3A0?=
 =?utf-8?B?SWRXYUZYRDB0ZCtINHJsK2h6S2FrdVJaQncveGI3MGV6emFEbjZOdlEyOHht?=
 =?utf-8?B?Q051VTlLSGJzVkpYOEVxZmxIeHRmcTZ6VTNVWDlOUlh0WHFUQW5rRUhCWUNO?=
 =?utf-8?B?TzB4cTB3YjQrM3BXNGpOK0R2a1RxSlJRem4vL2w2N1B2ZlhFbGQzaEN4ZWhE?=
 =?utf-8?B?b3FxMVRWT3Y5ckEzNzFOYjhPR0ZYUzdGS01VdnR4a3hVd0I4Tjk2NHlZd0wr?=
 =?utf-8?B?a3A5TEdwRyt3WmhOUGh0VXBuTnk1N0lVRVVVajV2d25mME9xbVpBRVJGN3hy?=
 =?utf-8?B?eTJLN3B4eG1PMERHaFhZN0JsOUFLRGpmZm9NT0t5cUg4Ylh6WWh5bkx3RmxS?=
 =?utf-8?B?bVNhd2lpYkVnOFdOUEx3TDU3R3IxakV3RFp4c3ByRDBwWUtlUS9PVzRwYWJs?=
 =?utf-8?B?MnM3S0x3Q2tPY3M1ZEVCRTVhcWU1Sk5UeU1NTzc4VDgwa1JTdzc4ek95ZGFK?=
 =?utf-8?B?T21saUJkRVUvKzFyTUR3SjNwOGk2d0I3MnFjaG54T3ZZMktrbmFNS0hEWUF3?=
 =?utf-8?B?NzlZN3Z5eENNM3pLVkp1RXBQQkZIbTRyWUJrRFIyaVF1VHBTT1ZuU004TjBh?=
 =?utf-8?B?VnhCMzhnVU9MVUtLUzF1alh2ZGREWTdYaTNWZG13bHZLZ0U5cHEyLzZEelFP?=
 =?utf-8?B?QWpBcmV5ejI5c0hpeFlVVERUOWRSYVBtbGJ4MEtDTnBZOWhYV2JZbFhsY3lK?=
 =?utf-8?Q?NYKJF82fC4mmOihXVYoWurk5Y1Ji4jTAO3u60=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N3owWllqNWV6Q29mbDd3eUVyL3JaSWRyZVBFaUVpR1Rya0F3cE1vMWV3Y3hN?=
 =?utf-8?B?SDdPenRVYkF6czVMS2hFckEzSW9EMHNkVk5hdmtucmpYZFRjdkJVRUJWaEJX?=
 =?utf-8?B?TFVWeEZpQitXU24rN2t4Ky9jazBZbzlQUlI4SzlONituMmpWRHJZMDRNZnJx?=
 =?utf-8?B?YjBqcEtweDNMaTAzeWVJL3M3M0ZiRlZHVC9mdHpHYnNxOGpIT2lnV1dlU0lz?=
 =?utf-8?B?dXZqOWxtWjM4T2FOeDNxc1BaSVV4d2JnVEEyNVFyVEp1bFhKUTR6eEJYRXBU?=
 =?utf-8?B?UDZrUUtSM1VZN1RFbElrbmVsczBjZXUvOGlhYXV5bERPZGE0ZnBmNGplR2JT?=
 =?utf-8?B?am8zVW40YjB2QktCTDhldldubEdObGFMUkt6TzVLTStsdDFEOS91a2k1ZktJ?=
 =?utf-8?B?NU1Ma0pINU1YOXBmYjBvNzlSQUJrUjJSTTJBZFRTQklHcUZaMDlVOHJ6aVZ3?=
 =?utf-8?B?RG9HdWNLT2FiNGYrN0hMWG8wZ1RLR1VJeTkyZ2xuMTBQRGZsOVlMeXBOZVBt?=
 =?utf-8?B?L0l5SHBTZ0VvcXIvZWkyOWpYMitHVExOVUJ1RlJvWUFnU2hZYUdtMkpTbVRx?=
 =?utf-8?B?MUQvOStDUkFBTi9ubU5HRFNBem5xVS82ZGpRVnlmSEVXTTEvekR0QUNNQmc5?=
 =?utf-8?B?RWlRSU55cnR2NE14QzNqekNrWk1oWkUzTElkZ3ZiR3BpZ2dDVXdudEZTZXR6?=
 =?utf-8?B?Vjg0WEZXQm0zOTl3NXV2a05zRWhZLzlLeGpIOGJwSXJDUHJHb25KM3Z1UU55?=
 =?utf-8?B?cEFFWUJsYXJsZWFkYjNxRFFMYkpIVk5QTUFqdHJxZVlNVWZMZjhSUmpReHQ0?=
 =?utf-8?B?by8wUjdpeFZMeDZPWFlkSXhMUXA4aTZBdkZjUThyS1VaeFJMZndVbmJtSUpv?=
 =?utf-8?B?KzNZajZtZTNoOGV1cW9XMG1wVmRpUXlreVM3Mk5iYjFYeXBkeE1PMnNCMnpQ?=
 =?utf-8?B?Q0llVEttb3ZQTXNLWW9KcVJGOG5OODBmSktpQXNXWDljOFFNQ0tJVWpvZFRG?=
 =?utf-8?B?SzI1cWp1bmFTcmJPaWU1NU93eVpsTytEd2lrdmk0aEpCcFBmUXlVMHlXNzQ3?=
 =?utf-8?B?bC9WTmNBdEV1eGgzbUttOEoyR3AzSWMxVFQxdGM3SkVjWXhrUVpjWlM1TW5t?=
 =?utf-8?B?aHk3dmtZL3J1OHJvZmdkcFFGY3M2N3dnWmM4bkhjTDNMRjhOakV6YStFbmto?=
 =?utf-8?B?eU1MangwbzhTczcvR0x3bXN4VzVHUExDd3FEUUdxSER2NlBBOUlGWUFZU0tH?=
 =?utf-8?B?UGsxeDN5ekN3ZkhFWC9zVDRXVUMxVW5PbURZZWN6VHQzQk9EYURTMVorOFEr?=
 =?utf-8?B?LyszNTV6ZnorcDV2aDRsTjkwbElrdjErcjlTcUFreEV4cThDM1oxM0huRmJE?=
 =?utf-8?B?UWh3UCtZT1NSeDlyQ05lNk5JNWIvbFpzaEVXek1Pa2J0Tll0bEo1UjJTSEo1?=
 =?utf-8?B?cFpQeStmb2Y4b1JZMER4TDhYN2J3dUFNV0k0RmZmVEpQTlByNlZzWXdGd0gv?=
 =?utf-8?B?YTUyWVZvZnplS241RG83L2hGWlNadlNLYVc0L1pFUVRWVVRhVHkyeTlVd3FP?=
 =?utf-8?B?WmtUNldNR281ZVZoVkk0QmVuOS9oOUl3TVdSTm1VOHM4aWpRTlRZWjN6YTBI?=
 =?utf-8?B?eVZmNkZLK21WZFc3MTVyRzl1dlgxVFdIN1A3TXgwMHFMMm5OLy9FdUtPVXRL?=
 =?utf-8?B?bVRoR1gzRlFyalk5OGdNdlJPbEwzMHVCT00xVzJrMTJPK3EybXloZGFLb3Ax?=
 =?utf-8?B?bHROTnhOOXlPN2oxYURYYkJlWU1nN1FCdzQvQ0NqWjcyaFBUSUhGYWd3d3FI?=
 =?utf-8?B?Wk1OZEpQbUdYL0dKUkZPV1praXdPT0NEa2ZLb0tUd08xaVI3cHVBNDBFRXZo?=
 =?utf-8?B?c2ZkdnRJdVpHUU8zNTMxUUlWWXlrblJlOVJLSUtjUVQ1VFAzbVUwMVZnc3dX?=
 =?utf-8?B?eHJxQjFjb0dTWGxCRVJpTWtBR01rdWNSS1phYzlGSVVyQ2RYRVplazNiSG13?=
 =?utf-8?B?ZTluRjR3RzM0TEY2U1hoRFhYMWltVmg2VkJGbUhyYVFxamdqZlNqbzdmamdi?=
 =?utf-8?B?V1Q0R2VNZmk1S3hoUDU0UmhKaDNwTEk3L2d1V2taQUVIemtoeUFKZWhneWpr?=
 =?utf-8?B?d05aVGc0ZkU1VmpSc2llUFBJaEI3WlF3Tkx5eUIrdWdrb216ZHN1TEdpMWhx?=
 =?utf-8?Q?VB3nUdRX1TvO3vPoL8Lwq1g=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7FA213E1867BC446AD79BD1CC5DF1811@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYXPR11MB8732.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0325741d-669b-46e5-a6b7-08dcfd0308d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2024 19:01:05.4567
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bv8Sql95LJfD2Er4qI3lQJ/KO9f4SCK/D8qHwPYL/HvoQHz0y0VHnDfNjpz5/Fyipw2TELkNhQfiDPmOXO2UjuPQ8mBxcO+jJmrtW/83tMFbB7qnrTtGECkKqUWIOeyf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6021

T24gMDMvMTEvMjAyNCAwMDoyMywgSmFzc2kgQnJhciB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6
IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0
aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiBGcmksIE9jdCAyNSwgMjAyNCBhdCA3OjM24oCv
QU0gVmFsZW50aW5hIEZlcm5hbmRleg0KPiA8dmFsZW50aW5hLmZlcm5hbmRlemFsYW5pc0BtaWNy
b2NoaXAuY29tPiB3cm90ZToNCj4gDQo+IC4uLi4NCj4+ICsNCj4+ICtlbnVtIGlwY19pcnFfdHlw
ZSB7DQo+PiArICAgICAgIElQQ19PUFNfTk9UX1NVUFBPUlRFRCAgID0gMSwNCj4+ICsgICAgICAg
SVBDX01QX0lSUSAgICAgICAgICAgICAgPSAyLA0KPj4gKyAgICAgICBJUENfTUNfSVJRICAgICAg
ICAgICAgICA9IDQsDQo+PiArfTsNCj4gdG90YWxseSB1bnVzZWQuDQo+IA0KPj4gKw0KPj4gKy8q
Kg0KPj4gKyAqIHN0cnVjdCBtY2hwX2lwY19wcm9iZSAtIElQQyBwcm9iZSBtZXNzYWdlIGZvcm1h
dA0KPj4gKyAqDQo+PiArICogQGh3X3R5cGU6ICAgICAgICAgICBJUEMgaW1wbGVtZW50YXRpb24g
YXZhaWxhYmxlIGluIHRoZSBoYXJkd2FyZQ0KPj4gKyAqIEBudW1fY2hhbm5lbHM6ICAgICAgbnVt
YmVyIG9mIElQQyBjaGFubmVscyBhdmFpbGFibGUgaW4gdGhlIGhhcmR3YXJlDQo+PiArICoNCj4+
ICsgKiBVc2VkIHRvIHJldHJpZXZlIGluZm9ybWF0aW9uIG9uIHRoZSBJUEMgaW1wbGVtZW50YXRp
b24NCj4+ICsgKiB1c2luZyB0aGUgU0JJX0VYVF9JUENfUFJPQkUgU0JJIGZ1bmN0aW9uIGlkLg0K
Pj4gKyAqLw0KPj4gK3N0cnVjdCBtY2hwX2lwY19wcm9iZSB7DQo+ICAgc2FtZSBhcyB0aGUgZHJp
dmVyLnByb2JlKCksIHNvIG1heWJlIGNhbGwgdGhpcyBtaWNyb2NoaXBfbWJveF9pbmZvDQo+IA0K
PiAuLi4uLi4NCj4gDQo+PiArc3RydWN0IG1jaHBfaXBjX2NsdXN0ZXJfY2ZnIHsNCj4+ICsgICAg
ICAgdm9pZCAqYnVmX2Jhc2U7DQo+PiArICAgICAgIHVuc2lnbmVkIGxvbmcgYnVmX2Jhc2VfYWRk
cjsNCj4+ICsgICAgICAgaW50IGlycTsNCj4+ICt9Ow0KPj4gKw0KPj4gK3N0cnVjdCBpcGNfY2hh
bl9pbmZvIHsNCj4gICBJIHN1Z2dlc3Qgcy9pcGNfY2hhbl9pbmZvL21pY3JvY2hpcF9zYmlfY2hh
biBhbmQgaG9va2luZyBpdCB0bw0KPiBtYm94X2NoYW4uY29uX3ByaXYNCj4gDQo+IC4uLi4NCj4g
DQo+PiArICAgICAgIHVuc2lnbmVkIGxvbmcgYnVmX2Jhc2VfdHhfYWRkcjsNCj4+ICsgICAgICAg
dW5zaWduZWQgbG9uZyBidWZfYmFzZV9yeF9hZGRyOw0KPj4gKyAgICAgICB1bnNpZ25lZCBsb25n
IG1zZ19idWZfdHhfYWRkcjsNCj4+ICsgICAgICAgdW5zaWduZWQgbG9uZyBtc2dfYnVmX3J4X2Fk
ZHI7DQo+IElmIHRoZXNlIGFyZSBfX3BhKCksIHRoZW4gcGh5c19hZGRyX3QgcGxlYXNlLg0KPiAN
Cj4+ICsgICAgICAgaW50IGNoYW5fYWdncmVnYXRlZF9pcnE7DQo+PiArICAgICAgIGludCBtcF9p
cnE7DQo+PiArICAgICAgIGludCBtY19pcnE7DQo+PiArICAgICAgIHUzMiBpZDsNCj4+ICsgICAg
ICAgdTMyIG1heF9tc2dfc2l6ZTsNCj4+ICt9Ow0KPj4gKw0KPj4gK3N0cnVjdCBtaWNyb2NoaXBf
aXBjIHsNCj4gICBNYXliZSBzL21pY3JvY2hpcF9pcGMvbWljcm9jaGlwX3NiaV9tYm94ID8NCj4g
DQo+IA0KPj4gKyAgICAgICBzdHJ1Y3QgZGV2aWNlICpkZXY7DQo+PiArICAgICAgIHN0cnVjdCBt
Ym94X2NoYW4gKmNoYW5zOw0KPj4gKyAgICAgICBzdHJ1Y3QgbWNocF9pcGNfY2x1c3Rlcl9jZmcg
KmNsdXN0ZXJfY2ZnOw0KPj4gKyAgICAgICBzdHJ1Y3QgaXBjX2NoYW5faW5mbyAqcHJpdjsNCj4g
ICAgcmVwbGFjZSB0aGlzIHdpdGggJ3N0cnVjdCBtYm94X2NoYW4gKmNoYW4nIGFuZCBob29rDQo+
ICAgICAgIGNoYW5baV0uY29uX3ByaXYgPSBwcml2W2ldDQo+ICAgIHRoaXMgd2lsbCBoZWxwIGF2
b2lkIGhhdmluZyB0byBFWFBPUlQgbWNocF9pcGNfZ2V0X2NoYW5faWQNCg0KVGhhbmtzIGZvciB0
aGUgZmVlZGJhY2ssIEknbGwgaW1wbGVtZW50IHRoZSBzdWdnZXN0aW9ucyBpbiB2My4NCg0KUmVn
YXJkaW5nIHRoZSBFWFBPUlQgZnVuY3Rpb24sIEkgdW5kZXJzdGFuZCB0aGF0IGl04oCZcyBhbHNv
IHBvc3NpYmxlIHRvIA0KcmV0cmlldmUgY29uX3ByaXYgZnJvbSBtYm94X2NoYW4gaW4gdGhlIGNs
aWVudC4gSG93ZXZlciwgSSBmZWx0IGl0IHdvdWxkIA0KYmUgY2xlYW5lciB0byBleHBvcnQgdGhl
IGZ1bmN0aW9uIHRvIG9idGFpbiB0aGUgY2hhbm5lbCBJRCBkaXJlY3RseSwgDQpyYXRoZXIgdGhh
biBkZWNsYXJpbmcgdGhlIHN0cnVjdCBpcGNfY2hhbl9pbmZvIGluIGEgaGVhZGVyIGZpbGUgdG8g
bWFrZSANCml0IGFjY2Vzc2libGUgdG8gdGhlIGNsaWVudC4NCg0KSWYgbmVjZXNzYXJ5LCBJIGNh
biByZW1vdmUgdGhlIGZ1bmN0aW9uIGFuZCBpbnN0ZWFkIGV4cG9zZSBzdHJ1Y3QgDQppcGNfY2hh
bl9pbmZvIGluIGxpbnV4L21haWxib3gvbWNocC1pcGMuaC4NCj4gDQo+IA0KPj4gKyAgICAgICB2
b2lkICpidWZfYmFzZTsNCj4+ICsgICAgICAgdW5zaWduZWQgbG9uZyBidWZfYmFzZV9hZGRyOw0K
PiBwaHlzX2FkZHJfdCBidWZfYmFzZV9hZGRyID8NCj4gDQo+PiArICAgICAgIHN0cnVjdCBtYm94
X2NvbnRyb2xsZXIgY29udHJvbGxlcjsNCj4+ICsgICAgICAgdTggbnVtX2NoYW5uZWxzOw0KPiB0
aGlzIGNvdWxkIGJlIGRyb3BwZWQgYnkgZGlyZWN0bHkgdXNpbmcgJ2NvbnRyb2xsZXIubnVtX2No
YW5zJw0KPiANCj4gLi4uLi4uDQo+IA0KPj4gK3N0YXRpYyBpbnQgbWNocF9pcGNfc2VuZF9kYXRh
KHN0cnVjdCBtYm94X2NoYW4gKmNoYW4sIHZvaWQgKmRhdGEpDQo+PiArew0KPj4gKyAgICAgICBz
dHJ1Y3QgaXBjX2NoYW5faW5mbyAqY2hhbl9pbmZvID0gKHN0cnVjdCBpcGNfY2hhbl9pbmZvICop
Y2hhbi0+Y29uX3ByaXY7DQo+PiArICAgICAgIGNvbnN0IHN0cnVjdCBtY2hwX2lwY19tc2cgKm1z
ZyA9IGRhdGE7DQo+PiArICAgICAgIHN0cnVjdCBtY2hwX2lwY19zYmlfbXNnIHNiaV9wYXlsb2Fk
Ow0KPj4gKw0KPj4gKyAgICAgICBtZW1jcHkoY2hhbl9pbmZvLT5tc2dfYnVmX3R4LCBtc2ctPmJ1
ZiwgbXNnLT5zaXplKTsNCj4+ICsgICAgICAgc2JpX3BheWxvYWQuYnVmX2FkZHIgPSBjaGFuX2lu
Zm8tPm1zZ19idWZfdHhfYWRkcjsNCj4+ICsgICAgICAgc2JpX3BheWxvYWQuc2l6ZSA9IG1zZy0+
c2l6ZTsNCj4+ICsgICAgICAgbWVtY3B5KGNoYW5faW5mby0+YnVmX2Jhc2VfdHgsICZzYmlfcGF5
bG9hZCwgc2l6ZW9mKHNiaV9wYXlsb2FkKSk7DQo+IEhvdyBkb2VzIHRoaXMgd29yaz8gc2l6ZW9m
KHNiaV9wYXlsb2FkKSBpcyBtb3JlIHRoYW4NCj4gc2l6ZW9mKCpjaGFuX2luZm8tPmJ1Zl9iYXNl
X3R4KQ0KPiBJIHRoaW5rIGJ1Zl9iYXNlX3R4IG5lZWRzIHRvIGJlIHU4IGFycmF5IG9mIG1heHtz
aXplb2Yoc3RydWN0DQo+IG1jaHBfaXBjX2luaXQpLCBzaXplb2Yoc3RydWN0IG1jaHBfaXBjX3Ni
aV9tc2cpfSwgaWYgdGhlcmUgYXJlDQo+IGFsaWdubWVudCByZXF1aXJlbWVudHMgdGhlbiBtYXli
ZSBrbWFsbG9jIHRoYXQgc2l6ZS4NCj4gU2ltaWxhcmx5IGZvciBidWZfYmFzZV9yeC4NCj4gDQo+
IC4uLg0KPiANCj4+ICtzdGF0aWMgc3RydWN0IHBsYXRmb3JtX2RyaXZlciBtY2hwX2lwY19kcml2
ZXIgPSB7DQo+PiArICAgICAgIC5kcml2ZXIgPSB7DQo+PiArICAgICAgICAgICAgICAgLm5hbWUg
PSAibWljcm9jaGlwX2lwYyIsDQo+PiArICAgICAgICAgICAgICAgLm9mX21hdGNoX3RhYmxlID0g
bWNocF9pcGNfb2ZfbWF0Y2gsDQo+PiArICAgICAgIH0sDQo+PiArICAgICAgIC5wcm9iZSA9IG1j
aHBfaXBjX3Byb2JlLA0KPiBUaGUgZHJpdmVyIGNvdWxkIGJlIGJ1aWx0IGFzIGEgbW9kdWxlLCBz
byBwbGVhc2UgcHJvdmlkZSAucmVtb3ZlKCkNCj4gZXZlbiBpZiB5b3UgbmV2ZXIgaW50ZW5kIHRv
IHVubG9hZCBpdC4NCkluIHRoaXMgcGFydGljdWxhciBjYXNlLCB0aGVyZSBpcyBub3RoaW5nIHNw
ZWNpZmljIHRvIGltcGxlbWVudCBpbiB0aGUgDQoucmVtb3ZlKCkgZnVuY3Rpb24gYmVjYXVzZSBh
bGwgcmVzb3VyY2VzIGFsbG9jYXRlZCBpbiB0aGUgLnByb2JlKCkgDQpmdW5jdGlvbiBhcmUgbWFu
YWdlZCB1c2luZyBkZXZtXyoNCj4gDQo+IGNoZWVycy4NCg0K

