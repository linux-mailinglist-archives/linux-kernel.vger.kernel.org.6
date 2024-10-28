Return-Path: <linux-kernel+bounces-384083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F0C9B2412
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 06:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDD56B21397
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 05:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF63818C035;
	Mon, 28 Oct 2024 05:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="jW/sJxV4"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE64C18A92F
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 05:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730092841; cv=fail; b=QV0DLN8BRCsnYpHQQ0H7Ae4alT9KSjh2X8NECLvC7fcVyl+jSQvEnkoBi9DTto8Nxr0OQ2+Xf+/zitYsss6Fvocly7d3Dsu4WwMUsQVqZP61rUTPw6/xfvjA+8HUEqbUziddA/7Zs/c7ONU+YqElrxNS3T9NZobtqfHJn8qzPp4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730092841; c=relaxed/simple;
	bh=Fd+RK5zyJuPeLcO+R7znxRkzlWCtIkr/eEZjwQcuspk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oEkwA0y3Yo3/sg7PQdgQZB0wxWQYaFPPMNj8oj8Wz7j5zZ6aq2PhpXLzsmjvYdAD6TTqVvjMmliUfzV1nYp25++SHFsZQxY9QP2SnH/JlBWWW1gPm+Y3XuGTskOhOfNuSRjdpiLW4r4Lr+zZkJyD2fACZlB+mCHUFw5nW90dHP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=jW/sJxV4; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49RNjYmI017765;
	Sun, 27 Oct 2024 22:20:03 -0700
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 42hh66hfwn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 27 Oct 2024 22:20:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=veKcMLZPx2nJtxYn/EmkTHhWSYTxCWH7YlidZej81BAPGnPY/PSKGkJAmvzc5NxdABcuTtf/YDTnX2+Rw4G94/xN6SItVlOa2f7RlfTcoM80EZGmqkNevwILqpTVpNEdfMjDUgdzOGMg9SvVlKtMHirUT/2IpDY8t3TEj5uRaSKWVTDI4ku9vee6Ia1UJNYCjjNxdSAUvHmNP+qSUbSRDF5r4I8MDR2BSp5ARG2Tc0Rh2GQ9Rq0EZUH23AYm1ScFWDiRnuLzXjuMDMEWAw09OK1VobAbNi2BQLCAJsGKAU2COFREeK4zN+WteofW6d1XGgUtICsBhsnSCwIqE+F8iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fd+RK5zyJuPeLcO+R7znxRkzlWCtIkr/eEZjwQcuspk=;
 b=uG0rc8N/fowtuh3q0dwbBSp/uB0KQbpT6brLiDiPYyepWJ1f8k15Q5iKdcXO2v42xWpiZd2q5wCHJNpo3Glj7AtjtSAYcjPuahaMOo3IBsaXB3YDRWOE7SNzFnQoWOEXEkaAhr/JngRUPznIUCfvxeX2gkp7h6aeb+Ev7T1oO9MFs15f7RhowjvQfqAstUtkqTdAVD1IK+xrZf6FUcyoW49AowRHkTbYGNThtyPxcZbNf53EJQAq3KCLSluxjvmPBzNuQ+bsgJ3Fn+kcE9/k+3d6q2yuPfCOHcxOOi/1Jyht+6q1nHprVCW9s8mfDkCWSPfw7DCzOxuKdwROotM0xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fd+RK5zyJuPeLcO+R7znxRkzlWCtIkr/eEZjwQcuspk=;
 b=jW/sJxV4CJxEdIXolF52PmfEGjJ+VQ00SLkpdXauPhqL4/0ygbefPziaWLyUqvLM/7JMZaKQo/bH8BbkD12vSyP4XeBPpwlgEpsfHQMizPOH+6Dn0nu5p7m1TNbDZdwjLXR+Wcqo7EG5OfSkVMGhS0Sztf1kApYO8TP639qjkGE=
Received: from SJ0PR18MB3865.namprd18.prod.outlook.com (2603:10b6:a03:2ea::22)
 by LV8PR18MB5959.namprd18.prod.outlook.com (2603:10b6:408:232::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.24; Mon, 28 Oct
 2024 05:19:59 +0000
Received: from SJ0PR18MB3865.namprd18.prod.outlook.com
 ([fe80::697b:186f:f4bb:a5fc]) by SJ0PR18MB3865.namprd18.prod.outlook.com
 ([fe80::697b:186f:f4bb:a5fc%3]) with mapi id 15.20.8093.021; Mon, 28 Oct 2024
 05:19:59 +0000
From: Gowthami Thiagarajan <gthiagarajan@marvell.com>
To: Will Deacon <will@kernel.org>
CC: "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        George Cherian <gcherian@marvell.com>,
        Sunil
 Kovvuri Goutham <sgoutham@marvell.com>,
        Linu Cherian <lcherian@marvell.com>
Subject: Re: [PATCH v9] perf/marvell: Marvell PEM performance monitor support
Thread-Topic: [PATCH v9] perf/marvell: Marvell PEM performance monitor support
Thread-Index: AQHbKPkIPSNm08VXPUeTC5sNOqhMBQ==
Date: Mon, 28 Oct 2024 05:19:59 +0000
Message-ID:
 <SJ0PR18MB3865C47C3668C312B96D19DBDB4A2@SJ0PR18MB3865.namprd18.prod.outlook.com>
References: <20241016131457.3821256-1-gthiagarajan@marvell.com>
 <20241024123214.GB30704@willie-the-truck>
In-Reply-To: <20241024123214.GB30704@willie-the-truck>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR18MB3865:EE_|LV8PR18MB5959:EE_
x-ms-office365-filtering-correlation-id: 1aafd57c-cbda-499d-a171-08dcf7102b18
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VzYzSDN1Mnl6L0hpM3ZWZmtuaG1IL1hmUi93bUJSV1NPMnBuMjQ0S2tINVpF?=
 =?utf-8?B?R0Z3RFlLM2N0VGJ1ZmFDT2EyZUJZZzRzb3Z3SlFUN1czQytOV0YvclA3QXVQ?=
 =?utf-8?B?ajFIdTZmYVhwRk90WGMyenAyT2pIWXZ5NmJTQVNCdUR3TzF1TmJqclZMdzBw?=
 =?utf-8?B?R2VaL0Nmd2FNWG9XSy93Tk44R25SeUZVemMwYytSRXNhbmpVK1Jkc0JGazJu?=
 =?utf-8?B?eWFGei9tdzdVREFNYVVxdmNLY1ptenF1YnVtTEN4Q09QQXZsb00yRDh5R3N0?=
 =?utf-8?B?L0dxYkFIK05iNGM2a29nMjB4MTZvWjR4MGE0RUtJVTBIRElvR1Eyc053ZUxQ?=
 =?utf-8?B?Zm9maEZWd1U4SWx3U3JhTFpRZU9vcTFGSVBrOThkZ0FHMVFSNDZhZGZmdWxy?=
 =?utf-8?B?SW1oemh5L1B4UEg3Sys5c3NWWjVTcG52K3NJK1pCMkVWR0Z4NFpKSCtvSGN1?=
 =?utf-8?B?UElKbmVHbXlKY3R4dlZwNjEvd2gyMlZtdXFaNVBIdC9JblVzL2Z4aDIyOFd4?=
 =?utf-8?B?VEYvVWRlbjh4ek9xMkVwSzRCemIvT3V6OUx0UVJ4ZFdsSmxMVDlnTjFFT09y?=
 =?utf-8?B?OC9pQmE5OUJUZmJiYy9mcWhqQU1Bb0M1WFRHVXZBSGpqdm9LYmtHRVhoMHJj?=
 =?utf-8?B?KzgrYnUzNjAzeU14SFA2M3BzbE51TE8zSXk3dDBab0hqbTdORWVGK3B4K2pB?=
 =?utf-8?B?UlJuRmhoanJCdWdsSnFvajdabjlBUTh0d29qbDgyVkZvcDlPOEV4YTY3YlNU?=
 =?utf-8?B?ZlNneFJjajN6Sk1NS0RrU3U5cUVHQ3dDZnRuS3JYbVZVOVh6OWdhZTlCOEdI?=
 =?utf-8?B?VWc2LzI1ZlhPVCsxNVl0Nzh4Sk9scTI4L3BwUk43TjNOSUVOZHZDTjY2aFF0?=
 =?utf-8?B?UEljZnhaR0xkZ3o3dlZoL0hQeUwrN3dUSGF4c2RxVU9tcjZSZnoxeXpZUCt4?=
 =?utf-8?B?dnRiQVhBd1RmMm04d0tpVkE3dDB4Sis5OGdueEQ0NzgwQWZ6VENrU0l6VHdh?=
 =?utf-8?B?cjRCR3A2RmRmUmpsU0V6dmdkR3YzcEdWcU1YRnFpckRXN3NpYjFZZU4ybysz?=
 =?utf-8?B?KzJpc0ZlL1VUalltSVBRc3U5ZzFUOHYwSVpOZ1dzUWErWnZsb3RRQndFNGQ2?=
 =?utf-8?B?Rm1BODZjS1F4RWw0TC8xMnppa0IyRndXZWliM2Yzblg4SWZIMC94TmliaGpi?=
 =?utf-8?B?TWJBK3MxWUVOdHFGZlhLay9DbjdIQ3RDNFEzWWFsTGlYc0hBNGkvOGpnWUVj?=
 =?utf-8?B?dUZvemNkYnI2cmVGSWkycSszSUxyaisvUjc5WWM3TzlUMHpnVnh1VUhEVTVz?=
 =?utf-8?B?UkJZcEJZNUZsWkF1dzVhVTNqdVFTL3ZTYlBhbEQvTU13NlZUK01sb05WZzBB?=
 =?utf-8?B?MHVrZm9HaGxiUkhPbnVlZ0ZCbVFlcys0M0JnU0xZUUg5Q2FJenoyeUtzcDhh?=
 =?utf-8?B?NVpwL3l5QnhPYWExaUR3WGh6cFkwYTBCb1creFVpUDFxRDRPWXhyWk9KZ2hr?=
 =?utf-8?B?ZzZDK1g0R05YN2R2aXVtUHZVMkRySzNuTXVraWJOWENKQlFsakZuUlUxMTNj?=
 =?utf-8?B?QWI4THFlQlRPTzNqY3RwZVZ3NFVzQjBKUVpsNFhCUmw2UHMrL0NYcWhTNjBz?=
 =?utf-8?B?akJrNTI4RVk5MmJJNmxCUE5aREZtWVk1T0FZdGVITkErNE5UeFJrWVZlajhL?=
 =?utf-8?B?UVhyTXgvTk1sQ1NVemdVaWVIQjBOa2ViWVk5cEFTU1dsTS9zYkVjSVloQWRO?=
 =?utf-8?B?NWJLdmp2Y1UxWXRCd00yRVpCWEFQTnhRamE5Wk1SN2R5eUdPN1hHMGNoZnZ4?=
 =?utf-8?Q?sZSJgYV9kZbaGd/+hnZ/20DIaIFPagIT1zxMs=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR18MB3865.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RE51NkhXT3NUdzZWZERONzFHN2tzL0hYZ1g0UEZqeE8yVStkcDJtU1VERDc0?=
 =?utf-8?B?d0grMmxNYUQ3YkYzWHpFTjA4dXBQeUpQYTJwSU5vbEMrVTdXMVoxU1gwTGRU?=
 =?utf-8?B?ZjBzaGJpMmFnMFJJb2NqZXVTRVdIQ2VKK3FTM3lHWjZ4T1dvVFdORTlFNGxI?=
 =?utf-8?B?MDVLT3dwcWxweDVieEl5UHBXNlR4a3RjYnpHdGRXT0lpeHlyaTlTd2tKejJF?=
 =?utf-8?B?Q0xVTTJDMUx4LzBOV3JxMXJ0cDVzVGpXYVNaQTZTMk1FWHRFRkwrcGVCMzNT?=
 =?utf-8?B?SW0reSs3OGxJZjR6Nk0zS2w0MFJuNzNMQ09QTDl4TFpaUmZGR3NDTVdOUkh2?=
 =?utf-8?B?ZnFxNGN2cERVam1tdXQySk45TVM2YXpObGVrYkNIcHN2cTZGY1dXVWV6ZnI4?=
 =?utf-8?B?ZHdKR1l1VENQMlVIYmlHOFZGT0VOUzMrakQxUUlQY21RTDUwUzQ2b1hkaW5L?=
 =?utf-8?B?ZEx2MnR1YW1wS0FoL2xGaEwyaHhNSFJRYzBueWNpTGt6WUU3U3BSSXc2Wldw?=
 =?utf-8?B?TzhoVEF0dWhscWIxZTEreXlYYWEwdlhsMlJUYk5CNzRiSVUrNlFtQmMzTVM3?=
 =?utf-8?B?SE9GOXkwU2hEKzdRV1FXZ0V4enpaU2c4UVRuWDE0KythNmJoa3p1aGRteUdH?=
 =?utf-8?B?WDBpUVgxMjhMeWFENVozSFRKd0tUUHVyY0xuN0lTbU1iYmdGU3BrRnpjN0FS?=
 =?utf-8?B?WEtwOUJtSmhvUmp6SiswMllNK3V0TWRSSzA0YnhTQmhLU2tPc1FpVHFjM2N6?=
 =?utf-8?B?eG9GNmx4WmJFN0lJS2d2QWJwTm1BclczY0owS3Fmd2Fzd2VWS2ZaWnF0Rnh1?=
 =?utf-8?B?T0FydVRjNmlvZmxSMWp6U1RMVHdBdmFKUzhad3hTS3cvRzBjUUVMemI4MC9a?=
 =?utf-8?B?cTR4QnM3dk9FL3JqVnBwUDhiR2k4K0NMODJTeVd4Q3IzSGdFd0FEQVBDTDJQ?=
 =?utf-8?B?NWR1bUJpY2pFRWlHbnhFUW94c1JKaFJUVCsxOVduSFVWaG9PTy9VK3J2WGRE?=
 =?utf-8?B?T2NhVVA1bmdOWHhid1JDeSt4b2RBdFR2ZkpQaGp5WUxKWWg2L0NaQnBRUkVz?=
 =?utf-8?B?TW5ITkRBVGh2OWtWbVBCU2JGdXNacEVRZUtqV1BTRnJ1WHRsZjhlUjczeDZK?=
 =?utf-8?B?V1FkYXFoLytSeGcyd3NWODJQNEYrRWlYWjA4M2pWQ3diTjl1ZXFCMFpjTk5C?=
 =?utf-8?B?SGxUL3pxam9YN05BYkhKUjRGdDBzenNLVnJ2VHNkWUxkL2lVUnRJMHFMQlZJ?=
 =?utf-8?B?UnhNcU82R25hNjdmc3lHUWY4RzJkMXdRTXhRN1c2K2tLaUFjYzVhSzZOOGZT?=
 =?utf-8?B?Qy9vZmNydjVvajQ3c1lhYkJ5V3RRVkg4QUt1Z0FKektZKzY2b29oa1VvT3Js?=
 =?utf-8?B?U2NFS3ZjNmhRT085QkZkUVFHZWhkTXpYMzlETThvVFRzelFxQVMwWGpBcUY3?=
 =?utf-8?B?a2ROd0ROUGp1VVZoNnF5M2R5VE84U2dBYUZYUGdjUUZZaklRZElxNGxQcG4w?=
 =?utf-8?B?OFcwK0ozMWlzNFdpNTVqUmYyMng1bmdWOVNiMklYSXExeG9EUy9Uc1pPK3F5?=
 =?utf-8?B?cVo5dzdvOTgwRVdtQVp1SVlhcFFRbzJNWWZXU0dPVldpOHpIZlFPSWwrTFk4?=
 =?utf-8?B?SDZKMXVQcWNyNlN5STVpdDl3V0dRRllPKzc0d2pyd2pkUjJQckRnUzF4UkNJ?=
 =?utf-8?B?RVVIbjVnUGlZTG1ac3lNSEhwZFVDbHFRSU1iTnJKTHBCazJQalpzS0ZBWDFz?=
 =?utf-8?B?aVlLNDlyWmZPUzYwQ0MrTE10WlZQVUFMOHRLZllUNUJ4akEza1oxdEJSK1JK?=
 =?utf-8?B?TDBkOHRNc3h0WE1MS0dITkhlQW4vTTA3Vm1NbkVKSmJXeVNIK0Z2K0ZzaVNL?=
 =?utf-8?B?cDhmSFNTYTI0YTEreDRYWnlpdi9HamVaR1JaSHAzYm43eWZYc3RXUDhSV0tQ?=
 =?utf-8?B?aEZDa0hJVlVjY2MzNHRlcXlTdVBIbEQ4M2NQSms0bnU1RzlJNWkwcEJNNEs1?=
 =?utf-8?B?TWtoODRhdFpKY3FuTDhxUE1zWjF6WlZTUXp0OHd5M3NTWTZQbUxzUkxxU25F?=
 =?utf-8?B?RVZhbkU3WVNTaFhnTVpXdUJSWkNNTmw5YzlVVHJKeEZhaVM2aS9Cb3JRNVdT?=
 =?utf-8?Q?BW4SqVRfUe1/JnnP524ZlHeVL?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR18MB3865.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aafd57c-cbda-499d-a171-08dcf7102b18
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2024 05:19:59.4191
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yz+koburvvFLtVIpx/6Qfloj7tfIzyDI0teS5mCQzfbINDXvYf79QQ+4sR2sokvXTfGCftIt+UEqS5o3OxpMWbOPDXo4zr26Ky3LLy1FeMI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR18MB5959
X-Proofpoint-ORIG-GUID: ElwQhyiYx4zl3IKnRCwP7hE8SNis0GMb
X-Proofpoint-GUID: ElwQhyiYx4zl3IKnRCwP7hE8SNis0GMb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

SGkgV2lsbCwNCg0KRnJvbTogV2lsbCBEZWFjb24gPHdpbGxAa2VybmVsLm9yZz4gDQpTZW50OiBU
aHVyc2RheSwgT2N0b2JlciAyNCwgMjAyNCA2OjAyIFBNDQpUbzogR293dGhhbWkgVGhpYWdhcmFq
YW4gPGd0aGlhZ2FyYWphbkBtYXJ2ZWxsLmNvbT4NCkNjOiBtYXJrLnJ1dGxhbmRAYXJtLmNvbTsg
bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnOyBHZW9yZ2UgQ2hlcmlhbiA8Z2NoZXJpYW5AbWFydmVsbC5jb20+OyBTdW5pbCBL
b3Z2dXJpIEdvdXRoYW0gPHNnb3V0aGFtQG1hcnZlbGwuY29tPjsgTGludSBDaGVyaWFuIDxsY2hl
cmlhbkBtYXJ2ZWxsLmNvbT4NClN1YmplY3Q6IFtFWFRFUk5BTF0gUmU6IFtQQVRDSCB2OV0gcGVy
Zi9tYXJ2ZWxsOiBNYXJ2ZWxsIFBFTSBwZXJmb3JtYW5jZSBtb25pdG9yIHN1cHBvcnQNCg0KT24g
V2VkLCBPY3QgMTYsIDIwMjQgYXQgMDY6NDQ6NTdQTSArMDUzMCwgR293dGhhbWkgVGhpYWdhcmFq
YW4gd3JvdGU6DQo+IFBDSSBFeHByZXNzIEludGVyZmFjZSBQTVUgaW5jbHVkZXMgdmFyaW91cyBw
ZXJmb3JtYW5jZSBjb3VudGVycw0KPiB0byBtb25pdG9yIHRoZSBkYXRhIHRoYXQgaXMgdHJhbnNt
aXR0ZWQgb3ZlciB0aGUgUENJZSBsaW5rLiBUaGUNCj4gY291bnRlcnMgdHJhY2sgdmFyaW91cyBp
bmJvdW5kIGFuZCBvdXRib3VuZCB0cmFuc2FjdGlvbnMgd2hpY2gNCj4gaW5jbHVkZXMgc2VwYXJh
dGUgY291bnRlcnMgZm9yIHBvc3RlZC9ub24tcG9zdGVkL2NvbXBsZXRpb24gVExQcy4NCj4gQWxz
bywgaW5ib3VuZCBhbmQgb3V0Ym91bmQgbWVtb3J5IHJlYWQgcmVxdWVzdHMgYWxvbmcgd2l0aCB0
aGVpcg0KPiBsYXRlbmNpZXMgY2FuIGFsc28gYmUgbW9uaXRvcmVkLiBBZGRyZXNzIFRyYW5zbGF0
aW9uIFNlcnZpY2VzKEFUUylldmVudHMNCj4gc3VjaCBhcyBBVFMgVHJhbnNsYXRpb24sIEFUUyBQ
YWdlIFJlcXVlc3QsIEFUUyBJbnZhbGlkYXRpb24gYWxvbmcgd2l0aA0KPiB0aGVpciBjb3JyZXNw
b25kaW5nIGxhdGVuY2llcyBhcmUgYWxzbyBzdXBwb3J0ZWQuDQo+IA0KPiBUaGUgcGVyZm9ybWFu
Y2UgY291bnRlcnMgYXJlIDY0IGJpdHMgd2lkZS4NCj4gDQo+IEZvciBpbnN0YW5jZSwNCj4gcGVy
ZiBzdGF0IC1lIGliX3RscF9wciA8d29ya2xvYWQ+DQo+IHRyYWNrcyB0aGUgaW5ib3VuZCBwb3N0
ZWQgVExQcyBmb3IgdGhlIHdvcmtsb2FkLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogR293dGhhbWkg
VGhpYWdhcmFqYW4gPG1haWx0bzpndGhpYWdhcmFqYW5AbWFydmVsbC5jb20+DQo+IFNpZ25lZC1v
ZmYtYnk6IExpbnUgQ2hlcmlhbiA8bWFpbHRvOmxjaGVyaWFuQG1hcnZlbGwuY29tPg0KDQpJIHRo
aW5rIHRoaXMgU2lnbmVkLW9mZi1ieTogbGluZSBmcm9tIExpbnUgaXMgbmV3IGluIHY5LiBXaGF0
IGhhcHBlbmVkPw0KSSBub3RpY2UgdGhhdCBMaW51IGlzIGxpc3RlZCBhcyB0aGUgZHJpdmVyIGF1
dGhvcjoNCg0KPiArTU9EVUxFX0RFU0NSSVBUSU9OKCJNYXJ2ZWxsIFBFTSBQZXJmIGRyaXZlciIp
Ow0KPiArTU9EVUxFX0FVVEhPUigiTGludSBDaGVyaWFuIDxtYWlsdG86bGNoZXJpYW5AbWFydmVs
bC5jb20+Iik7DQoNCmJ1dCB0aGUgcGF0Y2ggYXV0aG9yIGlzIHlvdSwgc28gZ2l0IGJsYW1lIHdp
bGwgYmUgaW5jb25zaXN0ZW50Lg0KDQpQbGVhc2UgY2FuIHlvdSBtYWtlIHN1cmUgdGhhdCBNT0RV
TEVfQVVUSE9SIGFuZCB0aGUgcGF0Y2ggYXV0aG9yIGFyZQ0KY29uc2lzdGVudCwgYW5kIHRoZW4g
dXNlIENvLWRldmVsb3BlZC1ieSBhcyB3ZWxsIGFzIHRoZSBhZGRpdGlvbmFsIFNvQg0KZm9yIHRo
ZSBzZWNvbmQgYXV0aG9yPw0KDQpIYWQgdGhpcyBkaXNjdXNzZWQgaW50ZXJuYWxseS4gSSB3aWxs
IGNoYW5nZSB0aGUgTU9EVUxFX0FVVEhPUiB0byBteXNlbGYgYW5kIGFkZCB0aGUgDQp0YWdzIGFz
IHN1Z2dlc3RlZC4NCg0KLUdvd3RoYW1pDQo=

