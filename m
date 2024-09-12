Return-Path: <linux-kernel+bounces-327287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7879497736D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 23:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C5082852E6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 21:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D0318953F;
	Thu, 12 Sep 2024 21:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2bEC16tl"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F007447F6B
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 21:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726175722; cv=fail; b=B8Nd98RdxUF93udF7ln9HgEmGqJflxdtyOkN0OZbFHZK+A6QdvwtChWs391qxJYLDZcQu7kkPgn7oemmdY18KgQqAVxYnv/y7UrJLQayt7w24XPGzsHea6y+OETT8Zl7nfx60KWZkf93uOfoBu4Kp2mg7PMVPMcNlCASFCnddmk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726175722; c=relaxed/simple;
	bh=0tmIlWBFeri0Nb+yHF82krUoGg0tqdR/iou/WPAx30g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=U4O7gGDkWLvyd30iM2ATuJYahMpnjJGTzys9WmZpTB6KVtMGSOty/DKoo6pYtYjdRvQHhjt9rZsPaLIBcJMxV1MWSWuhUapNJi86nX3XGaivEYkR5iDaIKP8052oWY4GyV551alDx0SyD/K31DVdNVQ8hTt5d/D4OpR+tbjqrg8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2bEC16tl; arc=fail smtp.client-ip=40.107.223.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rsVwIS3kG+3UbM65TwMbki6UkcGHLD7afcXGuK+kKCimof0SZ7mh8E7gdXZgmu4ZwuTx+JIKVxCFIFfl/MOVpreuZqsTRemkhw9m6zceVMfQv/S/uVRwnoO9/lqzixm8MrkttWanuX3pPSJmvDgccBWVnpoJkz+N9Jj+Q3P3OC/oGSkIErNilRgDVvt0scxnqycIR+t2ZLjY6teqfTJtcnuybRWLOWnpeXJXWzuNESghytJy5EcoBw5W/7vX0ARHV4jChMk6sjVI9nw5aDTViU1GiNkgyIDlom2CQryBAUgEevTfycuvWLTemVezi5m/0P6gf8dAZrANYJHMnQRHUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0tmIlWBFeri0Nb+yHF82krUoGg0tqdR/iou/WPAx30g=;
 b=g8oJygi2A8g8qa0IcBhgG3k68hQUvjPMUbW6FdTuozhp15OXJWoY8TaZA8IR+WfiX6S/0Nk6pmctiQokqYkYvoqn1Jyk3In17gno3mYTWphW92fw6wylXUCGBuxhwxqrf6ZJo4QSsDiO4DVjvDEStvSuQdthj5En1F7XSfPt0SAth6W3C1yXyPEmXLR7z6D6As8C3q60KqVkBzO4YRtQNlMTWB7+P3/Tsji9w9A7GI6OE/QYA99DUw5YdsX68a9x9Y0Q+OinQZt4hdjJvQAyWFTapVApvA8PYnePOxV9o47+s3JeGHIigd1WqegVP6Mhb8QxQrmUQUsx5PpsS3YEhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0tmIlWBFeri0Nb+yHF82krUoGg0tqdR/iou/WPAx30g=;
 b=2bEC16tlkKW1EWPTO87hWOIaNPxSiAg+tDdQQMwP98rwrQmXacBsRcEza1PsW+REk3wIlCuYd3OICxLqmmEiqqSAnl8Oyko6480Bk2KdmuRnERfpP2pdHmShMdssX+Si+3JRmJIvhPQbHuyU2q2vhswNWuRxEIY457Dd0TU1jxE=
Received: from LV3PR12MB9265.namprd12.prod.outlook.com (2603:10b6:408:215::14)
 by DM6PR12MB4449.namprd12.prod.outlook.com (2603:10b6:5:2a5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Thu, 12 Sep
 2024 21:15:18 +0000
Received: from LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427]) by LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427%4]) with mapi id 15.20.7897.021; Thu, 12 Sep 2024
 21:15:17 +0000
From: "Kaplan, David" <David.Kaplan@amd.com>
To: Dave Hansen <dave.hansen@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, Josh
 Poimboeuf <jpoimboe@kernel.org>, Pawan Gupta
	<pawan.kumar.gupta@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Dave
 Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, "H .
 Peter Anvin" <hpa@zytor.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH 27/34] x86/bugs: Add attack vector controls for
 spectre_v1
Thread-Topic: [RFC PATCH 27/34] x86/bugs: Add attack vector controls for
 spectre_v1
Thread-Index: AQHbBUtAYS9nEfikDEWFe8hVs68IMrJUjQ3AgAAJsgCAAA3esA==
Date: Thu, 12 Sep 2024 21:15:17 +0000
Message-ID:
 <LV3PR12MB926575E4BB94AE51EA662A3694642@LV3PR12MB9265.namprd12.prod.outlook.com>
References: <20240912190857.235849-1-david.kaplan@amd.com>
 <20240912190857.235849-28-david.kaplan@amd.com>
 <8a406835-b985-415a-a944-25d0ebea4fd0@intel.com>
 <LV3PR12MB9265FDD41382B1271DB0305E94642@LV3PR12MB9265.namprd12.prod.outlook.com>
 <9f5b7d94-91ae-41be-b4f3-49d2b9526133@intel.com>
In-Reply-To: <9f5b7d94-91ae-41be-b4f3-49d2b9526133@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=15914dd1-89bc-49ad-830b-83f9286bed29;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-09-12T21:06:14Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9265:EE_|DM6PR12MB4449:EE_
x-ms-office365-filtering-correlation-id: 07a57df6-9880-4e09-1bd9-08dcd370008c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bmJscHpIemptRGZjUUZudmlRVGpOWjBRTkhQMmw4VnpxcTlKRnJJTEovL0Zp?=
 =?utf-8?B?S04yc3hKeDh6S1VUTDJXbFVSYytPajVYaWkwcndYS2tmYlovL0NvUWs3Sjly?=
 =?utf-8?B?TDNVTjNXQ2xVa0xUeFR5UGhYdnN4TXJ5T0hDazFmaUlncGplMDBFSVpaYis4?=
 =?utf-8?B?azhDd2hySHhyOWZtL1dxT0xTMGt6Z1FMY0tRaG1ZcE1DVlB2eVArMUFTNitk?=
 =?utf-8?B?alBlSWNxR0dmTXF0b251SUdMVjhhOXlxTXVXelhoUE1OcUVqdG9MOEYwKzh6?=
 =?utf-8?B?R0NoQUMyY2NVRFNWRDV4UzdYK1NjRWE0ai9ld294UHBzdjBwOW1kN2VTeWRE?=
 =?utf-8?B?aUU4YzZsMkVzK2tyZjlpTnJxR1F3TjAxN21LRXdKdzEwRUFTRGVJVHc5UDhW?=
 =?utf-8?B?RGhZajlRRjhXR1VRVWVMdjV3T09KVnh2YVpjM0Vybk90NUtRMWZhN1ZIVE93?=
 =?utf-8?B?NkhxaGJ6ZmY0NUltbGhTRnpEWVJZajVwNnNUelhQd2oreFpOMXd4NEhZVk40?=
 =?utf-8?B?Y29MYUZYM0tST1ByRW5KekhLUS8zSDJIWHlCUXpBamNjOVRKOUpFS3F3UUdh?=
 =?utf-8?B?bkhoMTlpZ1RENnY4dUowdFBGcGZXeU4zU0dKbm5BQVdkMUgrbzZBelF5Ujh5?=
 =?utf-8?B?S2dzYmxINXZCWFY3STdobHFsRzhjUTlkMXBxWnltc2dKdmJoR293eUY3ZE5I?=
 =?utf-8?B?MU5vY1MyUDE4Y2FmS0w1TWtEakN3NXFaWVE2blcxK2lSeWI1SDF2ZHFWUE9y?=
 =?utf-8?B?K0x2RFVQcmhlSi9MMDVrT1JaRTJOR1JpR1Niek15d2sxNzMyKzRibkdIQXR5?=
 =?utf-8?B?dkYxLzlVM1BmTllyeFdXditZRE1MOVBBdE8zendHUVAzN3hsY1gzUTJwY2xP?=
 =?utf-8?B?czE2QVh6SGNqc1haWjEveG4vV0V2Z0hsVVlGMWNXUmJZUDQvOURPVVhkS004?=
 =?utf-8?B?UGh0ek1pcTV0WTkwanc2UXBrdG1CTkNOZms2RkhRNUNsNEY5RWNEVVJZUDlm?=
 =?utf-8?B?UFNsMlZYYVpiTWdZTXZIMWNLVDhmL1JaU2hxcE5uSVhXbjNaUFFsV0prUklm?=
 =?utf-8?B?enczZFZpYXBlT3ppaGgzYTFqQzEvWmUwand2VjVyVzdWN1VuKzdWRFk0SHJO?=
 =?utf-8?B?RUdUQy9xR3ZTNC9xVjZibmljWnlBUWxIVFJ4MlZENzBpbC9zT1NuNTBYNFNj?=
 =?utf-8?B?cTk0c0ZnUTRhTUVTd2ZFTFVmdGcvN054UnRpS2JYTmJpcXRVb3dGbWlveThk?=
 =?utf-8?B?a1FwZCsvVlM1TFpQT0ZlMEF2K3g1OXhRaGhrakovODkxa0VKWTg4c1Y3T1FE?=
 =?utf-8?B?a1hpeEppb2o0a2wzelR1QmJ2OWxrR1VjRnBucVZrTkM4MkE0UnVqSkNMY2hM?=
 =?utf-8?B?L05rSlMyNkRlSUdEcDdTSHRtVms5ck9sNVp6TWIxL1ZoOE50bU1SVlc5RUFJ?=
 =?utf-8?B?aDBtMmJvWmc4TlNYMXg2VEhWdVJrNnlLMWdVdnhCOXFHeTFJSERaMUJSL2F2?=
 =?utf-8?B?SlJwWnJFbTMxdlpTRDJ1Mk1DRXdWZ0F0Z3F2RFdsM2pMeUowVFBXUGNPTnFw?=
 =?utf-8?B?UzhmYjVKdFBFS01yTCszT0hTVnZIcU9Gekl5ZW9ER0tNTTNSUkNWakxBM2xL?=
 =?utf-8?B?enI2VEt1OEF2SnpLMUE2SWpvM2pQa1hvZTg0bDEzb2ZBUVQ2VnpCdllrL3kr?=
 =?utf-8?B?YmJuL3FHbS9mbmJ0UytmVCtCVlJjaVJLbDhmVFNkc0tIeWduVStpMTI0UDJy?=
 =?utf-8?B?ZVFkbTlPUndtWjhnVVZLdTlEVnZXNi9DaE0rWUhhWEcvNUJiK3FmTVY4NDJV?=
 =?utf-8?B?THczZ2VZRzEzbnM4WkN3WlVteXZmYzVGMHN1akpjcElQdUIzR2xYMzRhUzUx?=
 =?utf-8?B?VlRmcm9mYXptNzZiaVBrTEFwb2M0TTN3M1hXOU5hemVYNjAyS3hUamo3VzJm?=
 =?utf-8?Q?+IZ4QLKWb6E=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9265.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ckVia0ZJRjlBVXFlZVZyeGtjQVp3d2NzS3NTWEpuUkNUWDFUMGtCY0hDUEdI?=
 =?utf-8?B?Z0RoQjErM0FTdTR6ei91UGxGZUJ6YjRxZkxBaUdwT1kwNkFWZ0NnTEJGNTdj?=
 =?utf-8?B?RU54cXZyU0FIaEpLNmtUVzcxL1hRTUhHU2lGVTBYekNMUndhYjhKUEJEWVJR?=
 =?utf-8?B?ZDNvZE1KTGN0aHNua0w2K1ZHVjBpblFWSVo5czdnalFLSVE3cFM1T3BzMnFk?=
 =?utf-8?B?a1pYbXZJWTY1Rll3ZjdPRU9BYWMrU2xLTjh1aW44ZnMzMm9FY1czUjFnaU9E?=
 =?utf-8?B?ejJTeGpHY3F5WGRDek9NYWppSFhrUnBjYjZDdFFUeURNYUorRGNkSW43OTgw?=
 =?utf-8?B?VlBJZVU3UVIxMlVNejViUDk0Q1JIMG5CcmI0c1hhUjJ6d01mSTNoSFFsUjM0?=
 =?utf-8?B?M3FyMWhUMGhTem84b1N2S01kL3FRdjAzYlhud2t6ZVRFL0lGclJabm93VzIw?=
 =?utf-8?B?MnI5QmlMM1dQUjhvTHIwSzZrNmtUMUNOVFo1NmJIVi94NmdrRUh2Vlh5OWdF?=
 =?utf-8?B?L2l2VGxJc2FJU2FWVXVWUlBoWSs5b0o3K1N0Vk9Xb3ZkZHdIakMyY0tjbldM?=
 =?utf-8?B?UzZhN2t2dnF1bnA4eXp1a2J6N1ZnQkdOU3BmOEtlU05UbTBaNDQwSWxKaytB?=
 =?utf-8?B?SG8xWmQ4UzZjYThTZFFIcHZEajNDcjM3U0U3MkUwQ1NvUEFtQ3BUdS82ZFFF?=
 =?utf-8?B?Zy9wOUk5dHVDY01RQ3lPUmRlQkt4amg0SkJPcWlqYXJRemlHUXg4MnlLVGM2?=
 =?utf-8?B?RDdxanFaODdHRWcrSldHRWFSRnpZdTNyK1E5dEtIWUZ0MW54RFR5KzZITVA2?=
 =?utf-8?B?V0FsN1JEemRxUlV5bFBwK3hjTjdrZWZBWXhUU2lQWTh4bFBrMDhIWkQzbTlW?=
 =?utf-8?B?UGtaVnRvOXp4Vm5uZXJXQ3RZeEsxbXdNTW5weWdCMHBucVdzcStqTDN2OFdE?=
 =?utf-8?B?elBKK3ZRb3hoYlBxYnZzWFhiMmpRSGZXNXVNampBcGlvSWowVXJVNXJKVUxa?=
 =?utf-8?B?czk1VWtJN0Z5c2E5NGpEZGJzWWd0bEpKSk4ra1BtU0RFSFlCRVBlVEpQZkhY?=
 =?utf-8?B?andLcGxNR2tKT1Y2MDBtMWtIT0o0R01WZ25uTW56eEhPSE5nTG53TURVZ2Ro?=
 =?utf-8?B?YW4rMXAwa1VUNXcrNGtnNkJRQjJhVGl0bmpVK3NBTnZ3VzFSZ3JVd3NVWEVI?=
 =?utf-8?B?UlN0Zk5GOFAxY216UG85VWN6SzZteWtFNU1ObGhPWE9jMnNnNE5lbmZkMFNr?=
 =?utf-8?B?M3drZmRyUC9MUHJiR0F5ZUErTkJtRlc1cG9CZE1sR1hxN2FqdzJCTGdNVExP?=
 =?utf-8?B?WlpiRDQ1WDVPVEtGaUtVeFQ5NzNZZnQrcTJqbUdvTmcxQ21Pc2xTR1l0cUoz?=
 =?utf-8?B?T1JNMzhwa2JDTXNWWjZJR1RzQyt0bitWRThuV09jYTJ4VXFZRk5XeFNCQnpx?=
 =?utf-8?B?dlB0L21MbnhtS2xSK2drNy9RaExwb3ZxZUxZR3pRdERpSFEyTTBjM2t6ZjhW?=
 =?utf-8?B?VU9lY2ZFNlpKTG9FWWxwUXpjMGZDQWlPYXZYKzZSWkdhazZpZWFUektWL0dR?=
 =?utf-8?B?ZitZZ1lhd1M1MUc4OUlpZnVYWXlzUVUya1RGdkpVbGpGbk8rNGRnUmRBU3E4?=
 =?utf-8?B?SVh0VE1abWl1dmh0M0lOdUNiR3RVUVZ2MUJGbkN3UDZMRkN5UDc2WEV1SER3?=
 =?utf-8?B?ZU1Sclc0RmwxS0tEMUNZcW5yaG03aGJHT25XR0JUdjdtKzA0Q3N5RWM0QW01?=
 =?utf-8?B?VmRxeDdqMWoyS2VzblFqN2thcmwrb0hNTXgyd0xib3RNb29qc3RIbGszTHJE?=
 =?utf-8?B?YXVNcHFUZXpXeUt0d0ZhOE9UQUJlbnZucWw3Wmtoc0VzbDhMK3FidEJmRmJr?=
 =?utf-8?B?Q0RLUnBOL1NybTU4aFBwVGlYcXA0WlVZMFh6S3Y0dEJ4OG8rNWFJNEhXUDhI?=
 =?utf-8?B?TmQ5emZvQjBORjl6cjJRczVwSGEzNDFUWTJpNTRFd3l0WG5mWndEeUZYTytT?=
 =?utf-8?B?R2pkR29TQVBSSFBBSmU1WDFwdDgyWWY0cnRjR1Q1ZmZqTytBSWgydU1vTXZV?=
 =?utf-8?B?d0krVkhhSmtJU0pVTDBwMDdIcUxWaCtMS0V1d2x5SUR2VEtJanNiV3ZvNlU1?=
 =?utf-8?Q?S3z4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9265.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07a57df6-9880-4e09-1bd9-08dcd370008c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2024 21:15:17.8143
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bkbXgNtOwwSEq+dv6F/9wdpUEfz2F4A+DVJ8sPAFh7clYsnkxurhlxGWJPrPtEtD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4449

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBEYXZlIEhhbnNlbiA8ZGF2
ZS5oYW5zZW5AaW50ZWwuY29tPg0KPiBTZW50OiBUaHVyc2RheSwgU2VwdGVtYmVyIDEyLCAyMDI0
IDM6MTcgUE0NCj4gVG86IEthcGxhbiwgRGF2aWQgPERhdmlkLkthcGxhbkBhbWQuY29tPjsgVGhv
bWFzIEdsZWl4bmVyDQo+IDx0Z2x4QGxpbnV0cm9uaXguZGU+OyBCb3Jpc2xhdiBQZXRrb3YgPGJw
QGFsaWVuOC5kZT47IFBldGVyIFppamxzdHJhDQo+IDxwZXRlcnpAaW5mcmFkZWFkLm9yZz47IEpv
c2ggUG9pbWJvZXVmIDxqcG9pbWJvZUBrZXJuZWwub3JnPjsgUGF3YW4NCj4gR3VwdGEgPHBhd2Fu
Lmt1bWFyLmd1cHRhQGxpbnV4LmludGVsLmNvbT47IEluZ28gTW9sbmFyDQo+IDxtaW5nb0ByZWRo
YXQuY29tPjsgRGF2ZSBIYW5zZW4gPGRhdmUuaGFuc2VuQGxpbnV4LmludGVsLmNvbT47DQo+IHg4
NkBrZXJuZWwub3JnOyBIIC4gUGV0ZXIgQW52aW4gPGhwYUB6eXRvci5jb20+DQo+IENjOiBsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUkZDIFBBVENIIDI3LzM0
XSB4ODYvYnVnczogQWRkIGF0dGFjayB2ZWN0b3IgY29udHJvbHMgZm9yDQo+IHNwZWN0cmVfdjEN
Cj4NCj4gQ2F1dGlvbjogVGhpcyBtZXNzYWdlIG9yaWdpbmF0ZWQgZnJvbSBhbiBFeHRlcm5hbCBT
b3VyY2UuIFVzZSBwcm9wZXIgY2F1dGlvbg0KPiB3aGVuIG9wZW5pbmcgYXR0YWNobWVudHMsIGNs
aWNraW5nIGxpbmtzLCBvciByZXNwb25kaW5nLg0KPg0KPg0KPiBPbiA5LzEyLzI0IDEyOjU3LCBL
YXBsYW4sIERhdmlkIHdyb3RlOg0KPiA+IEFuZCB0byBiZSBjbGVhciwgSSB3YXMgdHJ5aW5nIHRv
IGNvbnRpbnVlIHRvIHN1cHBvcnQgYm90aC4gIEJ1dCB0aGUNCj4gPiBhdHRhY2stdmVjdG9yIHN0
eWxlIGlzIGFsc28gbW9yZSBmdXR1cmUtcHJvb2YgYmVjYXVzZSB3aGVuIG5ldyBpc3N1ZXMNCj4g
PiBhcmlzZSwgdGhleSB3b3VsZCBnZXQgYWRkZWQgdG8gdGhlIGFwcHJvcHJpYXRlIHZlY3RvcnMg
YW5kIHVzZXJzDQo+ID4gd291bGRuJ3QgaGF2ZSB0byBkbyBhbnl0aGluZyBpZGVhbGx5Lg0KPg0K
PiBUaGF0J3MgYSBnb29kIHBvaW50LiAgRG8geW91IGhhdmUgYW55IGlua2xpbmcgYWJvdXQgaG93
IHN0YXRpYyBmb2xrcycNCj4gdmVjdG9yIHNlbGVjdGlvbiB3b3VsZCBoYXZlIGJlZW4gb3ZlciB0
aW1lPw0KPg0KPiBGb3IgaW5zdGFuY2UsIGlmIHNvbWVvbmUgY2FyZWQgYWJvdXQgQ1BVX01JVElH
QVRFX0dVRVNUX0hPU1QgYXQgdGhlDQo+IG9yaWdpbmFsIHNwZWN0cmVfdjIgdGltZSwgZGlkIHRo
YXQgY2FycnkgZm9yd2FyZCB0byBMMVRGIGFuZCBhbGwgdGhlIHdheSBpbnRvDQo+IDIwMjQ/DQo+
DQo+IE9yIHdvdWxkIHRoZXkgaGF2ZSBoYWQgdG8gc2hpZnQgdGhlaXIgdmVjdG9yIHNlbGVjdGlv
biBvdmVyIHRpbWU/DQoNCkluIG15IHZpZXcsIHRoZSBhdHRhY2sgdmVjdG9yIHNlbGVjdGlvbiBp
cyBhIGZ1bmN0aW9uIG9mIGhvdyB0aGUgc3lzdGVtIGlzIGJlaW5nIHVzZWQuICBBIHN5c3RlbSB0
aGF0IHJ1bnMgdW50cnVzdGVkIGd1ZXN0cyBhbmQgY2FyZWQgYWJvdXQgc3BlY3RyZV92MiBJIHdv
dWxkIHRoaW5rIGFsc28gY2FyZXMgYWJvdXQgTDFURiwgUmV0YmxlZWQsIGV0Yy4gVGhleSdyZSBh
bGwgYXR0YWNrcyB0aGF0IGNhbiBsZWFrIHRoZSBzYW1lIGtpbmQgb2YgZGF0YSwgYWx0aG91Z2gg
dGhlIG1lY2hhbmlzbXMgb2YgZXhwbG9pdCBhcmUgZGlmZmVyZW50LiAgSW4gd2hhdCBJJ3ZlIHBl
cnNvbmFsbHkgc2VlbiwgaWYgeW91IGNhcmUgYWJvdXQgb25lIGF0dGFjayBhbG9uZyBhIGNlcnRh
aW4gYXR0YWNrIHZlY3RvciwgeW91IHRlbmQgdG8gY2FyZSBhYm91dCBhbGwgb2YgdGhlbS4NCg0K
Tm93IHRoYXQgc2FpZCwgdGhlcmUgY291bGQgYmUgcmlzayBkZWNpc2lvbnMgYmFzZWQgb24gdGhl
IGNoYXJhY3RlcmlzdGljcyBvZiBpbmRpdmlkdWFsIGJ1Z3MuICBBbmQgdGhhdOKAmXMgb25lIHJl
YXNvbiB3aHkgdGhpcyBSRkMgcHJvcG9zZXMgdGhhdCB0aGUgYnVnLXNwZWNpZmljIG9wdGlvbnMg
YWx3YXlzIG92ZXJyaWRlIHRoZSBhdHRhY2sgdmVjdG9yIHNlbGVjdGlvbiAoaW4gZWl0aGVyIGRp
cmVjdGlvbikuDQoNCi0tRGF2aWQgS2FwbGFuDQo=

