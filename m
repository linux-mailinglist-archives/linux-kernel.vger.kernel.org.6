Return-Path: <linux-kernel+bounces-576599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3422A7119A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 08:45:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 129FE3B9E30
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 07:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB91419CC0C;
	Wed, 26 Mar 2025 07:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="q5jL3NQ8"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2061.outbound.protection.outlook.com [40.107.21.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5741DDD1
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 07:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742975075; cv=fail; b=T05nX0V9vnXSaI30BYs7dlUqBlYfgD2+U7bZ5mr4dw0Tvo9lTmoDqatxhpuCRT/OXwzzxXBT0/QmGAE5wf0QL/sqExScX+KAj/OikGKXyfFWfOdo8nhOFyOSv546KBgWXudxcoJ+EbkYUESzB2hBZNO5qBqOnNH8qgoscsLz/g0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742975075; c=relaxed/simple;
	bh=BYgUlnlYx9j7jj+X16Qqv057mRSr/RayRXwOFfZrdms=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aongeaexs1so+SNePamb5gsJHqLNjRHLyAUhvmwjeBTwbTD1sNwG36XJObVIOtRzMT5aoM+GvOq9dAIt891FbRBzOsJg/3KpXqeCGEkh7BrLjIEGr51InnralapIVVEsK/B0yeTT0Uv3y6rTudVcatkCq3kVRzb5+MCKVciaNyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=q5jL3NQ8; arc=fail smtp.client-ip=40.107.21.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fbmi3kxGjXO1yKXRizoVSZxk7Lr5E+rcgruYZL9VRaA2O+ipiU+4Jg20bk6kymT6S2644H1BOD51ptCibKQinRU5gZu29eXsKEykrPpWZupga7VjyW3Q02qkOFST67Oz65OUsCLY+cZC6RVMQEQHXy/6VH7a6M19WGMQH/NCAjOddlqB31dyofQWIIFDszmZYIiaYExv/XRPnS008OXBwWJuggtObIpbOHMhGIkw3BY7CAbeAMQIgkFIsuj+A5dqEpTcISnj/Rh2ZpkawXi2LDWmjb0ODYPjHwFl/gkmaw0X93NzYLYDFOkqxDVRROZnGnAnVXw9xgsLV8upEOpCsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HKphW6u5Q14BhA2gL22AsHQ8GVOjVy7z4bygIduhTzw=;
 b=Rcjft78aL+3s+cPOy+c4T/6EOsTZYZtRJWsd+EXTP+GhAjjIdEpJwoJUc/JmHqNxSiq0hL5/ne5utI0lEDZp1FJlRATs7Ii4ZTAFjOIsGnSQUFhuANNe+UyeQ+vpCPeiMtOFXasqOpkow4weuWXFoGO1NlRN9RNsV65q1j2eiMhYHRMJbBgPEYgl6FnZkovyUMiDnCzTAi861R+tocGybtFeY98OSGPAD1z03MQuOb8H1reJq7wNpNkyaG/zCSPfxfoEN/89bsGC4AV2naqk8neH9F/29iqxgAUhsHCyQ26lqZK/juSMAONnGV5vovuZNJt4TBLG1Vy2H1AfLNJV2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HKphW6u5Q14BhA2gL22AsHQ8GVOjVy7z4bygIduhTzw=;
 b=q5jL3NQ8u61/Ug2mKxqE0MVmIorAr2x/RkObK5q+jKeCGTk+uEJYMVKq1QeBurvSKlX3EF310ZKueAUd4pazUgJXWXkWNgsMR0+DGpWylgBthJT4CZLv0MqeiJCf495+3GqFD+FqwU4rfIMFxIbxL+QcM9S7/LDHRjwIamzLj1XjQTkITFpDYR6I7x2LCPG39l+UwcnWJ+1fc2sSZoud8vrkvZxacukNgNSVPgHL7ZTQTG138OKkHAYLsXaglejpTOooh0MuIWECkKFY8cDaiXuEiZD2vjZUe/UMGi1vbc9yXEGMtA1eIgL5x9BSXrsCC1ZzGMvFLep8DTzh8CnMEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU2PR04MB8582.eurprd04.prod.outlook.com (2603:10a6:10:2d9::24)
 by DBBPR04MB7515.eurprd04.prod.outlook.com (2603:10a6:10:202::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Wed, 26 Mar
 2025 07:44:29 +0000
Received: from DU2PR04MB8582.eurprd04.prod.outlook.com
 ([fe80::c96e:12f1:67b7:ed74]) by DU2PR04MB8582.eurprd04.prod.outlook.com
 ([fe80::c96e:12f1:67b7:ed74%5]) with mapi id 15.20.8534.043; Wed, 26 Mar 2025
 07:44:23 +0000
Message-ID: <a31a575b-8f6d-6317-f172-b4f8b1a5cda7@oss.nxp.com>
Date: Wed, 26 Mar 2025 09:44:18 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 2/2] clocksource/drivers/nxp-timer: Add the System Timer
 Module for the s32g platform
Content-Language: en-US
To: Daniel Lezcano <daniel.lezcano@linaro.org>, tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org, Thomas Fossati <thomas.fossati@linaro.org>,
 Larisa Grigore <Larisa.Grigore@nxp.com>,
 Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 "moderated list:ARM/STM32 ARCHITECTURE"
 <linux-stm32@st-md-mailman.stormreply.com>,
 "moderated list:ARM/STM32 ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, NXP S32 Linux Team <s32@nxp.com>
References: <20250324100008.346009-1-daniel.lezcano@linaro.org>
 <20250324100008.346009-2-daniel.lezcano@linaro.org>
 <d60fca36-0beb-2574-cb82-3969bbfb58a9@oss.nxp.com>
 <8c208e8c-2e1e-430c-916a-dbc6732881b0@linaro.org>
 <065d6f32-3161-8316-bbbd-4da18eef839b@oss.nxp.com>
 <098c5de8-9291-4f3e-a276-500825cac7c5@linaro.org>
 <068713cb-47ca-ae26-e113-9f5026be9196@oss.nxp.com>
 <cc2dd75c-e279-4e55-ab88-75498e93146a@linaro.org>
 <50d2c651-746e-4ddd-4036-f72742a622f8@oss.nxp.com>
 <e8054f85-2a23-4ceb-8e1c-7cdfe7c87628@linaro.org>
From: Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>
In-Reply-To: <e8054f85-2a23-4ceb-8e1c-7cdfe7c87628@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR10CA0080.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::33) To DU2PR04MB8582.eurprd04.prod.outlook.com
 (2603:10a6:10:2d9::24)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8582:EE_|DBBPR04MB7515:EE_
X-MS-Office365-Filtering-Correlation-Id: 04f548b2-238b-44db-7c12-08dd6c3a065d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TzlNeW43bHpOS0RYUVhZZmxTTGdtVXFlYTRSQUZ0RzBVVTlBbkZEWXV3TU82?=
 =?utf-8?B?U1VaQU9ObzNWVVVuaHlFRmVxWDNJeFNhTXpjSDV3bmdadlZKSWxXNnZScTZS?=
 =?utf-8?B?NEtMVkdESWl2RnV4ZjlGamdSMVZUb29vMHpOSVE5blRmWGo5NzRqK2xrc295?=
 =?utf-8?B?RjRycU1uS3IvZC9jQVpuUW03UDJ4Z3BzaWR0RnBIdGE5MllPcXNXUlQydGNw?=
 =?utf-8?B?eWFTSW4wRHAxeThrWHFiSk4xRG9yVW9OUFpzS29FRVllT25CdCtKVjlPK2ll?=
 =?utf-8?B?NEFGbkoxdDNZWFYybDVZSFBqOUdUc3JqMDBWWE9ONmxvRHdDNms4ZDBFL2Vw?=
 =?utf-8?B?emttZmtMcGR1UUZQck5aU2FkOFFvblEzTGR3NGVsOGt2WU5YNTdRZkRCaEpI?=
 =?utf-8?B?Q0VsN096bCtXWEVwUXJLU1B6dU9rL1o1anptbGVIVUVXOTVtTmhFUjVDS2px?=
 =?utf-8?B?VDdrRGNaR1RUV1MxZ25tYXA3WXBlK2ZOcWczQU5jbEd5NEpDV25pcnZkYk5W?=
 =?utf-8?B?QUFVeGU3ejFDNlJ4RlpGK3FFcWltbHhSMUNrZEd3UHhnYkxiUk1LMkg5empq?=
 =?utf-8?B?THBqM3llR2ltQ1lTcTRibmZjdUJpR2NDTWJray8rOFJrTWMwbnI0cUY4dkMy?=
 =?utf-8?B?bUZsWjFGa0d6WDd1Z2FXWjRQdHlpNUxzYVRmNU9wdVFkbTRvUWgxUnNObVkr?=
 =?utf-8?B?anhkQktCRmIvdDdvOTl6Mkl6M0V3Ri9XTFpYNVFZTFNZZ0NVOGRnSzZ1NGdT?=
 =?utf-8?B?Z2dHWUFjaXNNTDRrWklEQ1BpYnhGYzRjeEZBRTVQU1NmUEZUUnppSGpxTWNh?=
 =?utf-8?B?Q3dDN2k2czdnZWFmVkVqOUpjNlNBcXZaTU1ZclI2RW5HS1RndG1vdTg5RGR3?=
 =?utf-8?B?RnB0Mk5JbHRUUTFqb0k3QVJEVjBoUFdSaEE5RDZoOHZKVHU2WlR1dVFUVXVS?=
 =?utf-8?B?MldZSnVqcW41SnhCc3dIT2FwR0t0cDhoVjVwaUo2UFFrSEN5a3hudmFDMVFB?=
 =?utf-8?B?YTJTQUhwdmVmWDlsVSsyLzlBa3AvaDVNYXU2bVdWYWxScVJoT2FaZjh4UmFR?=
 =?utf-8?B?MXM2S1pQTXR1MkRDT0JKUWFCbFM1cUNoSjRFbWtPZFF2TjVCYUdOQVB2bi8w?=
 =?utf-8?B?MU5GQ0o1WjdhVStFWnBEQ3p4NTlqcVQrYUtMNktuQU9pOEVJN3BMdDA5N3cz?=
 =?utf-8?B?Y0Y5aWsrcVlraDM3dFNEUEc5eUpZUHZuQXZxdFVOWHhQZDJYdEJVWHBKdGdE?=
 =?utf-8?B?aU11alZmaVVMSnA5eHRiR3ErRjViS0xGNmt0RmVnbmhoUitpT3FObXpCQjRM?=
 =?utf-8?B?TVpqemdGVTlLdWgrajgyaksxcXlWeitrbXRGOWVaR0pkZFFGNUlMc25WZ2hE?=
 =?utf-8?B?eExpOVpRNVVIOUhQNTBaUjRuU1ZLb2EzYk5yT1FZRWZERzJSdUtEeDNScUc1?=
 =?utf-8?B?MWI1b1dkb20zVlFvOTBLSW9WRU5DZXE5TnF2MlFYcEJ0SzFsRmtMZEpQaHhI?=
 =?utf-8?B?KzZrOXR1K2FEWjJSYVdBNTRnNUZkKzRKaUV4dFZaOFhPbk1rdC9KOXRYREYz?=
 =?utf-8?B?b2t2cDFuQys2VFhWeDJPNkJsNDd3SG5iN3pMWm9LRVdIMXN6NW1JL21zM3p3?=
 =?utf-8?B?MHFraFczeDlIOW14WndoaC85cHpDMVhhOUtlbjZCSDFMdlZ5eTI1Ym1admtk?=
 =?utf-8?B?MkdoaW1uMG1LT2hLcXI5c00rbWRlUU5va21uOXhqaElRZVNpdHM3aE9vb3Uw?=
 =?utf-8?B?Q0U4N3ZhRzlaa2U4ZGxJcDRVY092NGkxT05KcHdsbDBTN1dLaEdqend4MWEr?=
 =?utf-8?B?L3VuVFYwRThva1VYOG1EOWJldWQ0bHprUlI3Wm9PVmlxU3RNTDI5Z2RzOGti?=
 =?utf-8?Q?TfqYcE73MWUuq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8582.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UUhWN3V0QVlWNUswUVBFdnM1b083OHpLQVF1d1dETWNrNHVScHBhbnV3SU9C?=
 =?utf-8?B?S1BYNjQ5ZDBnVG4xaTZhTTRkT0Y0N3dVdHZ4UGZJUGZ2RDNsVVRWVFp2ZnVJ?=
 =?utf-8?B?ZXZ0Ky9XVjlnb2NuUnpPM2RsbXZVWWVJM0plSjRsVEdmOXliaGhUUWlQRzJi?=
 =?utf-8?B?RC83VUwveDBXNVJ4blZpdjMvTCs1MUVyMlZneGFxa3pPdHhCUkxaR0VxQUgy?=
 =?utf-8?B?UTVuMWhhaFFVRGR3VERsbmdVUEd2ZDNFQWpUQlZxaXh6Uk9MRlJBOFhPR284?=
 =?utf-8?B?c0JDWExmdzN4TGsrdTlxQUhaSTJhckpKWE9ORHJDeWlvMEZEWllQUzNhRlgy?=
 =?utf-8?B?MzN4NktiVjUwUGRWek9Zb2VGWWU4TWRORTlrVG91UUsvQ05tMGRQKzZ2Vnp4?=
 =?utf-8?B?NnJvUVRxaWZub2lya01QSm1GeW1JdENsK0FYL0lVNlpJVFF3M0pqaWZ2UWto?=
 =?utf-8?B?NElmZC9MYTNiaUtuZkxOVy9lQVVSTzdLZ1Q3eTEyK2wxZmI2YVBNeUY5eTVl?=
 =?utf-8?B?cmg1Uk5YTmhxK2d6NDlwZnZpRU52SDNaUGhBbVcxZ0l2WTV0NUFPNHFrbGZr?=
 =?utf-8?B?Unh3L2ZmaEE5djhPNkl3TmNGaFV1dWxZeEI3RXg4TTB5UE9scGEwVGlpUjg0?=
 =?utf-8?B?ZmVpb1RqRlNxSkdzSTRoVlBlOENpQnBSM2ZnbjQ3Mjd1enhqZ0JZMC9OZ1VK?=
 =?utf-8?B?YTRUbEF6bS9KL0hKcktlRnZkblRtd1U2UlUxUnBKZ2hHTkZjaDRzeHpxamZ6?=
 =?utf-8?B?VlI0eUhJUVR2NHJoMGZ5amxvTUZWejNPUEtDUGZ6OWI4K3E3M01UN3VYUUd3?=
 =?utf-8?B?MkdzS3pBamxjem9sZWs3RGpLWUxzN2VXUHZvMEErbkV1b25JRGU3L3hzV1Fv?=
 =?utf-8?B?U1NrbHU4SnpFSWdlK2IvUzZEQUp3Z0JpMG1Db0Z5MXpoRDV0TGZmTUhlUDQ1?=
 =?utf-8?B?L2d4Nm9YREsvdHoxWTl5TlhJWVlEanc2OGdIQXJkR3I0TVBWREF4MnhjQVFt?=
 =?utf-8?B?SXFZOGJXa0lraDVadWZHS1BJOFQ5M0dlaDM3L3pJUnZ3d255UTVJQ2F4YURP?=
 =?utf-8?B?OHc5Q2RSNVRlSDJiSk5wc3JqZXcvSFJCTks0RG55MnEzNS94Vnluc3ExQktk?=
 =?utf-8?B?RnFsalRwRXo1bHZhYmpMYUdqS0kwS2wvV2dLNGZlc3JwYkZoMkVhR0VhNStG?=
 =?utf-8?B?Vytia3Rrak1MdVAydzg5VUxRQ0g1eVlnU2xNRkJaREIyLzNNWmpBVHVxK3JR?=
 =?utf-8?B?MTlycmQ3dVhEbEZ6bit1WHgxdjQzR3RtbnJaZVZ5YzVOLzJaM2ZiMnc5SFh5?=
 =?utf-8?B?cFJld1E2eFAzVWlKaVNUMEZHWHRxYVozOFpONlYvdVlNL0hnbkUxejROMk5s?=
 =?utf-8?B?MldxQ1M4SkFWNW9zYU1ONk00ejNIV3BabEx5clFyN04vWENJWCtVZHhZRGlF?=
 =?utf-8?B?ZWkxMVZ3QVV1RVkycXkvZ0Fyb1J6QXE2YlFHZGQzOXB3TmxnZkk4aEFqak5t?=
 =?utf-8?B?MUZVMjN4QXNFOTZqbmhaSWtJOE5oUUVmcFNjQllZRmsyWGdmSnNNblBXUElw?=
 =?utf-8?B?MUNuS0FoR3YrbVhxTmxiZ0RDVUVuRXpueWRuYk53RHNzRXFoQUhicXRjNnZv?=
 =?utf-8?B?c3RTVXNIK0hSMU55YWtnbFlFZHlHbk5Cd1Y3WXQ3OUVsamF6dlY0MFk1a3Zn?=
 =?utf-8?B?dkQyOVNnTk1mYVg2eHo0aEpOb1kzVnVTQzBkeENXRnQ5VFdJbGk3RDRHcGdn?=
 =?utf-8?B?YVBXaE1GMm1qblVJUmRTTXlqTmVTZ2k5WDk5WHpHMkF2QUxQNFlBVlJ2Z1lr?=
 =?utf-8?B?NUhYb3NxZFRIcWFHd3ZqVlEycTkreGF4TnVCVWRJZnRkL2oraHJtQWhvcEIv?=
 =?utf-8?B?d2xDWENJUlBwUml0RWllMlN6ei9BQ0g2RnNZemMwbENMWjdoRkRnMThaTDhh?=
 =?utf-8?B?eFhBSEVjR0kzWndHOU9jQnpoU3dKbkdPSVdvMlJNU25xMy8zb2FhQzNWQzhM?=
 =?utf-8?B?VXJnVE9DZVZLSjBzQW5vSGpZdFEvREtnRE1hWUJ1d0JBTjNITy9ZWjhVWldJ?=
 =?utf-8?B?SEk3T2NqNzRMMEMzWHpwc0FRanM2cTR3Yk5yTGk5UU5rd052bzg2V1hOTEpE?=
 =?utf-8?B?cDhtdnZiYWhiY2IvejRYVVJ5a1pYRVNQYmxyODNaR2hiUU5zOXQwTkV0VGcx?=
 =?utf-8?Q?CPlAJoua6ot1/XouFumzZUU=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04f548b2-238b-44db-7c12-08dd6c3a065d
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8582.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 07:44:23.0212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nxyM6R7+GMPlLZ87sEnMsaWJs9UHKn2+cDJMcp9e6Ml7CuwcwgEGaHNWLVq7YCzGqmBqi0BXJbocQCQTWT/j0b1P6AkRE8fQ5JNh5R6ev/U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7515

On 3/25/2025 3:54 PM, Daniel Lezcano wrote:
> On 25/03/2025 14:21, Ghennadi Procopciuc wrote:
>> On 3/25/2025 2:51 PM, Daniel Lezcano wrote:
>> [ ... ]
>>>>>>>>> +static int __init nxp_stm_timer_probe(struct platform_device
>>>>>>>>> *pdev)
>>>>>>>>> +{
>>>>>>>>> +    struct device *dev = &pdev->dev;
>>>>>>>>> +    struct device_node *np = dev->of_node;
>>>>>>>>> +    struct stm_instances *stm_instances;
>>>>>>>>> +    const char *name = of_node_full_name(np);
>>>>>>>>> +    void __iomem *base;
>>>>>>>>> +    int irq, ret;
>>>>>>>>> +    struct clk *clk;
>>>>>>>>> +
>>>>>>>>> +    stm_instances =
>>>>>>>>> (typeof(stm_instances))of_device_get_match_data(dev);
>>>>>>>>> +    if (!stm_instances) {
>>>>>>>>> +        dev_err(dev, "No STM instances associated with a cpu");
>>>>>>>>> +        return -EINVAL;
>>>>>>>>> +    }
>>>>>>>>> +
>>>>>>>>> +    base = devm_of_iomap(dev, np, 0, NULL);
>>>>>>>>> +    if (IS_ERR(base)) {
>>>>>>>>> +        dev_err(dev, "Failed to iomap %pOFn\n", np);
>>>>>>>>> +        return PTR_ERR(base);
>>>>>>>>> +    }
>>>>>>>>> +
>>>>>>>>> +    irq = irq_of_parse_and_map(np, 0);
>>>>>>>>> +    if (irq <= 0) {
>>>>>>>>> +        dev_err(dev, "Failed to parse and map IRQ: %d\n", irq);
>>>>>>>>> +        return -EINVAL;
>>>>>>>>> +    }
>>>>>>>>
>>>>>>>>     From commit description:
>>>>>>>>
>>>>>>>>> The first probed STM is used as a clocksource, the second will be
>>>>>>>>> the
>>>>>>>>> broadcast timer and the rest are used as a clockevent with the
>>>>>>>>> affinity set to a CPU.
>>>>>>>>
>>>>>>>> Why is the interrupt mandatory when the node is probed as a
>>>>>>>> clocksource?
>>>>>>>
>>>>>>> It relies on the DT description and it does not hurt to have a
>>>>>>> consistent code path for clockevent / clocksource even if the
>>>>>>> interrupt
>>>>>>> is not requested for the clocksource later.
>>>>>>>
>>>>>>
>>>>>> If so, in my opinion, it would make sense to use the same STM
>>>>>> instance
>>>>>> for both the clocksource and broadcast clockevent, as both functions
>>>>>> can
>>>>>> be accommodated within a single STM instance, which will help reduce
>>>>>> the
>>>>>> number of STM instances used.
>>>>>
>>>>> The broadcast timer is stopped when it is unused which is the case for
>>>>> the s32 because there are no idle state powering down the local
>>>>> timers.
>>>>> They have to have be separated.
>>>>>
>>>>
>>>> This wouldn't be the case if the STM is kept running/counting during
>>>> the
>>>> clock event setup, with only the clock event interrupt being disabled
>>>> (CCR.CEN).
>>>
>>> Are you asking to use two different channels for the same STM instance,
>>> one for the clocksource and one for the clockevent ?
>>>
>>
>> I suggested using the CNT register to obtain the count for the clock
>> source, while using one of the STM channels for the clock event.
> 
> Ah, ok.
> 
> I think it is preferable to keep them separated to keep the code
> modular. Given the number of STM on the platform, it does not hurt
> 

The S32G2 and S32G3 are SoCs featuring a diverse set of cores. Linux is
expected to run on Cortex-A53 cores, while other software stacks will
operate on Cortex-M cores. The number of STM instances has been sized to
include at most one instance per core. Allocating six instances (1 clock
source, 1 broadcast clock event, and 4 clock events for all A53 cores)
to Linux on the S32G2 leaves the M7 software stacks without adequate STM
coverage.

Additionally, the proposed implementation uses only one STM channel out
of four, which is not optimal hardware usage. I suggest using all STM
channels instead of limiting it to a single channel per instance, given
that the driver already uses a global structure to pair STM instances
with cores. This approach will optimize the number of instances required
by Linux and leverage the capabilities of each STM.

-- 
Regards,
Ghennadi


