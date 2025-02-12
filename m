Return-Path: <linux-kernel+bounces-511565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C20A32CAC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 18:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57233168883
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 17:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E1221171B;
	Wed, 12 Feb 2025 17:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vB3z4fpm"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B09256C8C
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 17:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739379701; cv=fail; b=EI5K1Rylny2RsxyZXxcuvAt6eCp7NiZny13aE8LV0VvntbMvZ3ESxIIYoFDGFoIBfLjkY0tCWjFj9zny7EOuuie2TLnLoN2nuxoO2e4x/diyC2aLSyp3StPfjj4pgGsVwr/cvy2sCLIjVPJ3MItrB+sColfWo++qPsXgKPfRyiI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739379701; c=relaxed/simple;
	bh=RUb/pGQnpUy9GxUQStPyLTTKnDhNqr5x5mPMqLUOgrc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=X+ZSceeywDV8Y9E6+Y2avsvn1Pv7ZDtREGI3Oi94c1pJajKNYYHuwTdoozec8EV66eamsh33ybCWZtpkNQeuJ6oanClvguKODiL5egZOQFcc/AxQRW0GsD5t15MnAPKxdTCjnSqVNPJShjrua40maI/heRBAqCxrgKiPqOcOdUY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vB3z4fpm; arc=fail smtp.client-ip=40.107.244.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PcFSl2UoCMcd4NYZADFRA9OSfv7m8Te/b+xZ/1SoR3otB145tzRfRb0bBZwjTEb0hLGsqoHrVVU8uG/BEX4kWwpvwNBFMUt3g2zQ5jk0dZhS+jiZs+ID2jsAP9cqHFiZ0DIGx3Vc93+owCudJIALcY0oyBW/cw5bylzIHGtLvcgzvLXAaB30GeF//PErslT74I8ui+8UCalgY1Dl9jZU2A9MLxYehthoZAUkTs19VbHY0PlSEaYM3sxCAr7mM2aoXNoFQNKGSvFg9sZ3yZbR7nULUwNv4udQ+MXk0sJxEy65ofEzrnO/Ld13EWKjbs+9PiuuazZALIw3wLXnWoIwgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RUb/pGQnpUy9GxUQStPyLTTKnDhNqr5x5mPMqLUOgrc=;
 b=sCaVxBVjgfELncYFucXnA7yDykcEwbd3BOoKGp7V+Miy5MDHOUudlSTMev3k3hUivHUQP3cAoa/4OR8o3jsVGsyqU9N7jfpIzTKDjueKcpYcyXOBuZCC/w04jxyfxecJlUs9Surjl9Byl/gHXB4lVJ+CvduNMf5hs1EHau4pvbvnTvW/yt/Tkeb/SEg32f1TMngoNSYJXv4R/bi5+c0QiOnqwRL6q9pwESPmcwtsktW+ZvzVbOu/11Xvcb6vp3tGi3MJxxs7qTOzheM/LfxDKP7DfNdCQ1i7sAOzz4xb8n4jqA/IOCZzEcrvjXS+kpnvGfKYJZz+Z+fB20pcQwvs3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RUb/pGQnpUy9GxUQStPyLTTKnDhNqr5x5mPMqLUOgrc=;
 b=vB3z4fpmcf/GCedogXqMO5l3esjwzGNQmn+3+L/6MW5KTMRqanUrPHJtLNv0skQlRGHFdYbH6DmpOgsU/clFRBfhNO0Y78Z1jsvuss1Wm9JWlo5YTx0gAQkMwhvoVgHSSa79eh3dFYAfCuQ1QcOUdQjTGZW0Lgppq0ydQdzPtm8=
Received: from LV3PR12MB9265.namprd12.prod.outlook.com (2603:10b6:408:215::14)
 by DS0PR12MB9347.namprd12.prod.outlook.com (2603:10b6:8:193::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.22; Wed, 12 Feb
 2025 17:01:35 +0000
Received: from LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427]) by LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427%4]) with mapi id 15.20.8422.015; Wed, 12 Feb 2025
 17:01:35 +0000
From: "Kaplan, David" <David.Kaplan@amd.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Pawan Gupta
	<pawan.kumar.gupta@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Dave
 Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, "H .
 Peter Anvin" <hpa@zytor.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 18/35] x86/bugs: Restructure srso mitigation
Thread-Topic: [PATCH v3 18/35] x86/bugs: Restructure srso mitigation
Thread-Index: AQHbfKN6QSbyYjXgQE6USZHY7gJZXLND4wSQ
Date: Wed, 12 Feb 2025 17:01:35 +0000
Message-ID:
 <LV3PR12MB9265DBA83B6338C0393F985794FC2@LV3PR12MB9265.namprd12.prod.outlook.com>
References: <20250108202515.385902-1-david.kaplan@amd.com>
 <20250108202515.385902-19-david.kaplan@amd.com>
 <20250211163901.kt4if7r7xehq3hqo@jpoimboe>
In-Reply-To: <20250211163901.kt4if7r7xehq3hqo@jpoimboe>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=e8a0e799-8dc0-4df5-8d23-82125c67a396;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-12T16:49:57Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9265:EE_|DS0PR12MB9347:EE_
x-ms-office365-filtering-correlation-id: 9ca9c812-c059-4f07-7c68-08dd4b86e89b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?a21WdzFmN1V0SlNNRm5idkJJUllEaWs4alM5ZkgyVnl1TkdLOFp3Tm1oamZq?=
 =?utf-8?B?Tjk1a2UwRE9jNjJtaGoyWDdhWGs4QVlrNllFd3lJQXVDZHFvUWh4WlZJWm4r?=
 =?utf-8?B?WG5TRUZiVktjeFJOelM3eVVJKzJGeEExd0pCN3RISzBGQkpHSmlEb0NMN3Jk?=
 =?utf-8?B?a3hvR3c2ZVMrS0tiTm0ycXpwVnhxeXc3b2dRczZmbmJaWTJQOXVKQjFLTXpT?=
 =?utf-8?B?b0d1RkRHK2RGVnRYZElpdU9rZkhNRHFla2pNTU4wV3JJc0VNaTZvQ2QyQWdo?=
 =?utf-8?B?QlZnd3I0SWQydmpETEk3RGFkUUtEcUtYU1h6VmYyRG01RzllMjJLa3orYnox?=
 =?utf-8?B?VkFnbWRLTWFmM00yWDJvV1ZCZ2gvUm1rSkJ6L3hDRUxFVk9ScE9WbzZoakgy?=
 =?utf-8?B?SnZ0WGdZODgyK2wrcVVoWVJNYTlHWDNmdUFQOHIzNUk4ajR2b21oWnFPVzg4?=
 =?utf-8?B?YVNkblE5eWZERUxjS3hMWXBZb09nTnpYbjJ0TytWbVg1cnBCRnVUNFU5aEZL?=
 =?utf-8?B?ZmI5NmxDWC9USWtYOEh3eGlYNHdOM2VTMkdxMndKZkVwczdOckNrdFErVWZy?=
 =?utf-8?B?c1JQSXpZdWsyQldwaUZIY0Fqc3NCcnNCVHZRQXVGa3ZjS3VuakdmYXA3OVdq?=
 =?utf-8?B?VWlxS1ZkSytyUUhMYiszTVlFM1BLMi8zM2tZa01ONUgzRytCc1JFc1o3bWFz?=
 =?utf-8?B?VzBlODZrYm1aNFZEQnU1c2xmb0FXY0c5YmowNnZkNmFXUjZqK2NEOHV2SmIw?=
 =?utf-8?B?b1FrTTF2bFdjbWlwaWloM1B0WGs3YTB4QVd0QXhpdytWOVVKZEtjeGdHeFZF?=
 =?utf-8?B?K2xJaVEwOURzdVpUb09VSGw4WmN2RHN0V25QZHh0MGlaSEkwSmc1a0hGaldL?=
 =?utf-8?B?UUFJcGdReTA2Rzc4R0FUK25ESVJZcWwrZGdoYzk5UHhRYXdsa3NxQ0tVdXls?=
 =?utf-8?B?V0NpOGc1cGdFaUt0dUdkMEVOcGdhMFpxYnpkd3RPbEpyTHQyKy9ndEYyZDdT?=
 =?utf-8?B?MXNmcmpZNjJFdm5MRHVQNVVlSkxteXBkNHNIRGZIKzIwYjdad29lNkw2Ulpp?=
 =?utf-8?B?ekhCcUthbWt5aTIxbUhidkdOT3puYlJIemJJTmJsZGtiYmJaUE9mMmFHOVlt?=
 =?utf-8?B?eUI3bVVNRHpkRFg3cEpzeEpiUjlPeHFBYXdUWHFIMGwvKyt1MEM4OU1LRUk4?=
 =?utf-8?B?K1FMeTl2em5VYU12bWhKeGhlV04xQzR5ZUd2WUlZQnlNRUhCRWxJZUhEZ3JM?=
 =?utf-8?B?V0YyRVU2SGZvNGh0NWMxOFVGWHZOY2xyeE4vTGRHYmpqZE94S2w2bCtEOENo?=
 =?utf-8?B?WEJ3dGx6MlpMMGFNdWNEcjhmaXZ3NDJjZkQ5dmZCMm5oK1FrWEhGSVBadXRF?=
 =?utf-8?B?dmVtczkvTlZMVVZlN2JtZ3dCYVREY3dZNExqOVBCNDhCR096VGN3L1FhMEJ5?=
 =?utf-8?B?UlNrZGdrTFJkNmpGOWVtQ3NXTjEzTTNIbFVMREZ3VDZTV1BnZ2ZrY3pBdk9Z?=
 =?utf-8?B?MHd5U1N1MCtCd1NZb3Y0NEM3VkNCQjZJb2JGWFB2QmlpK2g5bUJDRTZOMXNU?=
 =?utf-8?B?RUVrZkx1elo1N0orbm4xN2xOckRHTzd1c2d3YmVzTStIbEEzYkN2S0NSQzVZ?=
 =?utf-8?B?MVV2djhHYnFVYm1mc0tHZGVuYzlmcUJDUUJFWTdmbERyZVpTaVFkMWFldjR2?=
 =?utf-8?B?MkJ0cjVsRXZCZHNsdVR3NUpmNTkwdHpMRjMvdnJDWXNoejBxOWZkZnJrR2dp?=
 =?utf-8?B?bERpa0pVYjA1WExLMktuSzNKY0Y3S0VUcWhCaHp3MHdadVloS1EybzZKOTE5?=
 =?utf-8?B?L1RIaXhiK0U1M2NFY00zNk55enF2UW16ejdwMk9SdlhzaGt6alZHVFlnTXpa?=
 =?utf-8?B?TVUxUzd2eHY3VnZta1ZWWVU4K1JsMmZxd3VQSncxa3lOTFVmK3M2MUxwL1pw?=
 =?utf-8?Q?mj6ovF41H8QXusGhaVDUdz43AZqcFt+y?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9265.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?L0dFTGJzL0ZsOU9BZVBmRm4xZCtsbkhmbHhYMitGcFBvTjVhb1NiMlp3Z3Iy?=
 =?utf-8?B?VFFuOEZsT1hscVJrR1FaU3BtT242YXFDV3Exa0tPNjk5QlNzQ0FFOWw4UmpU?=
 =?utf-8?B?WUJVRDJyYkZZaityODF0eTlKdGU3a204blVsS1VZWG1jcUlhKyt6SHZ6d2FK?=
 =?utf-8?B?WjVDbTNwQXVCVGptR1dveUV5TEVKaGc2Vjd3bHgvaFVwYTNKZVpiblBQQ3JO?=
 =?utf-8?B?SnE4TU8yd1lzdmJtQXJkRTBYTVFFMFBodDVZM2RWU1BFWjd0SkZ0OXdzeTA2?=
 =?utf-8?B?dXU5ZWQ1UGo0R2lWekliZ0pYWmxHMXVuSTNWYllzdWg0a1B6azV1S2FUeUph?=
 =?utf-8?B?Mm5ad1JmbHJQSjNEWUlYRVRFUWlBMnpQYzc0YVNRY2NiOGM5eVV4RGtndDN5?=
 =?utf-8?B?SDhOdFVJQno1WWJqTE9YZzh6L0FaK0tBM1dZSFZ1eEozVkh2RmFvNXdJaklL?=
 =?utf-8?B?R25lQmh4Sm83K3N4NVNpMUFKNVlTK1o5RDM5eDdJRGFRTWpNQjU5ZlNJR1Ra?=
 =?utf-8?B?dEJMQ242TE9Fb294MXJjOU10b2NzTm9TbWtDUzZac2k4c3RuZVBWN0RGQWx2?=
 =?utf-8?B?dStqMzRuMU12bWJpNEQvNlluK3RnUmpnM1lwd0VKWGd4aklMcktaelRiVTk1?=
 =?utf-8?B?c0tiVVNTa2xJNExxTEdtOG5yTVBSR0E4bGVYNUFCSVRpSHFiTjY1cElRVk5h?=
 =?utf-8?B?UlMvblBSNVU0M0lJRHZWSGRxeDNIOGpZTHRBb1h5Qk4wL3R1Nzk5WCtMdmZy?=
 =?utf-8?B?VkZNZ2NLZXF4cWRZaVFUU3piOHFmS29WSi9WMDFoSnlkTW55ZXNXY3kvM2NL?=
 =?utf-8?B?QjRRSVdUQ0dkWmRndFJzd3FPZ3ZNTjB2MklyZVFYbkw1cWNYajNuVW1aSThz?=
 =?utf-8?B?Qmp6Vk5laStuTU5kaDZWaWJMY2NKRXNCT3RmdUZTUm9HRjdzcFBBK2FqbUxY?=
 =?utf-8?B?bFZVOUY1cUIvRVBaRU1mbHNYQWFib0g5QjN0elh1UGpKL1Qyd1czcTlvSU03?=
 =?utf-8?B?SkthQWhYVXB0T2dPOGgyNkorVEhzSTRzT004MXhDK3UrdWpvTHY4M3ZWSENO?=
 =?utf-8?B?cGNubkpqMlNnY1hhMGJ2SlMwU0NmS3ZMSUVsNVR2L21FMEFaWUR4Z1lGUXIw?=
 =?utf-8?B?di94cEw0WmR6YnRRemlOOEg3VnY2T3U2QmNPa1ByQkRsSHFQRWVOQXdWNFhY?=
 =?utf-8?B?MjBxcHdGdXZZQmw0K1kzOC84cC9aakd2b1U4akdFdnh4cE91WGNKSkVXUUl0?=
 =?utf-8?B?V2RncllEZCtmSHI0elcrdWNNaVZwTjdldjM4c254c1lLSzRrMnpzWkdER0sz?=
 =?utf-8?B?d3c5bnVBYmJFS2twZGdVSlZDbXptTEsrd0VCTS9xRWpOTytOTmNkbW1QOVp0?=
 =?utf-8?B?ZWlMdFdSK0E4Z1hGMGpQcVhzNlBpdXNKTlNZb3Bmb0NzZEVmeXVOU0d4aU15?=
 =?utf-8?B?bkRPNTZPRmkzVGlQNjU0SDN6WUZLaTFqRFRHQyt0eXg4aHR0cDI3Um0xYlBU?=
 =?utf-8?B?ZVh1MFRKQXZOWHdlNWxpeEk2cUxKN2RqcHpNVkZ6SlRMU2d4QVcrSlp3VmhO?=
 =?utf-8?B?ZUh5Sm1sQUZZMjFRbW5GbXQwUERiYXZRaXhWeDJFYXlwd3V2ZFpRenhwdlVp?=
 =?utf-8?B?QjFFaXlaQ3VXWDdadFZjWCt4bk0rVXRRWDlyQUI5dVczdFN1Y2xZOEVsMkVk?=
 =?utf-8?B?YkhzTGp1MUQyQU5WQ3JwMHpoRG14a21acUJlZjliblF3VWVUNGtGaEVBRkp1?=
 =?utf-8?B?YU1MQk1CcERMNDhJNnlDczFiYm5oOXYzOTZpeDdPbWo4ZXZVQkZCMk5CbHZ2?=
 =?utf-8?B?ZmZ5TTdVZHRwNzhQSkJJbXZXVkdyMlZDZjlWWnRBMURiSVpKTmxaMDZNYlpZ?=
 =?utf-8?B?M2pyY0R4RndBZVF5MGdFNWM4SjA3ZnBjcHRFd3lLcUNibFV1bWlvTFZ6YWlm?=
 =?utf-8?B?bVc3cG1IcTZWNk5BcmFDaVZwejlnTTUxSk9TQ2l5MFZ6VmVqYVpXcHFQWDNC?=
 =?utf-8?B?WWhpVjRQTC8yWTdWdzJnQnRobk1kajNMSnBmMlhHelZNM2Y2a0hwZHNHODBt?=
 =?utf-8?B?dzFucEFxK2lNcDh6K1d6LzZKVHVOeVVHeXhwTURMRTA1OC9XUlBvbFdrUlN0?=
 =?utf-8?Q?ttrA=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ca9c812-c059-4f07-7c68-08dd4b86e89b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2025 17:01:35.6392
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /dTYyPDj8EUJutvIfCtffeXV4w4Bti9p1Cx0XxSYKoVvYx/2wU7Fm2Eq9Kovr4sW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9347

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKb3NoIFBvaW1ib2V1ZiA8
anBvaW1ib2VAa2VybmVsLm9yZz4NCj4gU2VudDogVHVlc2RheSwgRmVicnVhcnkgMTEsIDIwMjUg
MTA6MzkgQU0NCj4gVG86IEthcGxhbiwgRGF2aWQgPERhdmlkLkthcGxhbkBhbWQuY29tPg0KPiBD
YzogVGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+OyBCb3Jpc2xhdiBQZXRrb3Yg
PGJwQGFsaWVuOC5kZT47IFBldGVyDQo+IFppamxzdHJhIDxwZXRlcnpAaW5mcmFkZWFkLm9yZz47
IFBhd2FuIEd1cHRhDQo+IDxwYXdhbi5rdW1hci5ndXB0YUBsaW51eC5pbnRlbC5jb20+OyBJbmdv
IE1vbG5hciA8bWluZ29AcmVkaGF0LmNvbT47IERhdmUNCj4gSGFuc2VuIDxkYXZlLmhhbnNlbkBs
aW51eC5pbnRlbC5jb20+OyB4ODZAa2VybmVsLm9yZzsgSCAuIFBldGVyIEFudmluDQo+IDxocGFA
enl0b3IuY29tPjsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTog
W1BBVENIIHYzIDE4LzM1XSB4ODYvYnVnczogUmVzdHJ1Y3R1cmUgc3JzbyBtaXRpZ2F0aW9uDQo+
DQo+IENhdXRpb246IFRoaXMgbWVzc2FnZSBvcmlnaW5hdGVkIGZyb20gYW4gRXh0ZXJuYWwgU291
cmNlLiBVc2UgcHJvcGVyIGNhdXRpb24NCj4gd2hlbiBvcGVuaW5nIGF0dGFjaG1lbnRzLCBjbGlj
a2luZyBsaW5rcywgb3IgcmVzcG9uZGluZy4NCj4NCj4NCj4gT24gV2VkLCBKYW4gMDgsIDIwMjUg
YXQgMDI6MjQ6NThQTSAtMDYwMCwgRGF2aWQgS2FwbGFuIHdyb3RlOg0KPiA+IEBAIC0yNzQ5LDk4
ICsyNzQxLDk4IEBAIHN0YXRpYyB2b2lkIF9faW5pdCBzcnNvX3NlbGVjdF9taXRpZ2F0aW9uKHZv
aWQpDQo+ID4gICAgICAgaWYgKGhhc19taWNyb2NvZGUpIHsNCj4gPiAgICAgICAgICAgICAgIC8q
DQo+ID4gICAgICAgICAgICAgICAgKiBaZW4xLzIgd2l0aCBTTVQgb2ZmIGFyZW4ndCB2dWxuZXJh
YmxlIGFmdGVyIHRoZSByaWdodA0KPiA+ICAgICAgICAgICAgICAgICogSUJQQiBtaWNyb2NvZGUg
aGFzIGJlZW4gYXBwbGllZC4NCj4gPiAgICAgICAgICAgICAgICAqDQo+ID4gICAgICAgICAgICAg
ICAgKiBaZW4xLzIgZG9uJ3QgaGF2ZSBTQlBCLCBubyBuZWVkIHRvIHRyeSB0byBlbmFibGUgaXQg
aGVyZS4NCj4gPiAgICAgICAgICAgICAgICAqLw0KPg0KPiBUaGlzIHNlY29uZCBwYXJhZ3JhcGgg
bm8gbG9uZ2VyIGFwcGxpZXMgaGVyZSBzaW5jZSBlbmFibGVtZW50IGlzbid0IGRvbmUgaW4gdGhp
cw0KPiBmdW5jdGlvbiBhbnl3YXkuDQoNCkFoLCBnb29kIHBvaW50DQoNCj4NCj4gPiAgICAgICAg
ICAgICAgIGlmIChib290X2NwdV9kYXRhLng4NiA8IDB4MTkgJiYgIWNwdV9zbXRfcG9zc2libGUo
KSkgew0KPiA+ICAgICAgICAgICAgICAgICAgICAgICBzZXR1cF9mb3JjZV9jcHVfY2FwKFg4Nl9G
RUFUVVJFX1NSU09fTk8pOw0KPiA+ICAgICAgICAgICAgICAgICAgICAgICByZXR1cm47DQo+ID4g
ICAgICAgICAgICAgICB9DQo+DQo+IFRoaXMgc2hvdWxkIGFsc28gc2V0ICdzcnNvX21pdGlnYXRp
b24gPSBTUlNPX01JVElHQVRJT05fTk9ORScsIG90aGVyd2lzZSBpdA0KPiB3aWxsIGVuZCB1cCBh
cHBseWluZyB0aGUgbWl0aWdhdGlvbi4NCg0KR29vZCBjYXRjaCwgd2lsbCBmaXguDQoNCj4NCj4N
Cj4gPiArICAgICBzd2l0Y2ggKHNyc29fbWl0aWdhdGlvbikgew0KPiA+ICsgICAgIGNhc2UgU1JT
T19NSVRJR0FUSU9OX01JQ1JPQ09ERToNCj4gPiAgICAgICAgICAgICAgIGJyZWFrOw0KPg0KPiBU
aGUgc3dpdGNoIHN0YXRlbWVudCBoYXMgYSBkZWZhdWx0IGNhc2Ugc28gdGhpcyBvbmUgaXNuJ3Qg
bmVlZGVkLg0KDQpBY2sNCg0KPg0KPiA+DQo+ID4gKyAgICAgY2FzZSBTUlNPX01JVElHQVRJT05f
U0FGRV9SRVQ6DQo+ID4gKyAgICAgY2FzZSBTUlNPX01JVElHQVRJT05fU0FGRV9SRVRfVUNPREVf
TkVFREVEOg0KPiA+ICsgICAgICAgICAgICAgaWYgKCFJU19FTkFCTEVEKENPTkZJR19NSVRJR0FU
SU9OX1NSU08pKQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgICBwcl9lcnIoIldBUk5JTkc6IGtl
cm5lbCBub3QgY29tcGlsZWQgd2l0aA0KPiBNSVRJR0FUSU9OX1NSU08uXG4iKTsNCj4gPiAtICAg
ICAgICAgICAgIH0NCj4gPiArICAgICAgICAgICAgIGVsc2UgaWYgKGJvb3RfY3B1X2hhcyhYODZf
RkVBVFVSRV9TUlNPX1VTRVJfS0VSTkVMX05PKSkNCj4gPiArICAgICAgICAgICAgICAgICAgICAg
c3Jzb19taXRpZ2F0aW9uID0NCj4gPiArIFNSU09fTUlUSUdBVElPTl9JQlBCX09OX1ZNRVhJVDsN
Cj4NCj4gVGhpcyBtaXNzZXMgdGhlIGJlbG93IFNSU09fTUlUSUdBVElPTl9JQlBCX09OX1ZNRVhJ
VCBjaGVjayBmb3INCj4gQ09ORklHX01JVElHQVRJT05fU1JTTy4NCj4NCj4gVGhvdWdoLCB0aGF0
IGRvZXNuJ3QgbWFrZSBhbnkgc2Vuc2UuICBXaGF0IHRoZXkgcmVhbGx5IG5lZWQgdG8gYmUgY2hl
Y2tpbmcgZm9yIGlzDQo+IENPTkZJR19NSVRJR0FUSU9OX0lCUEJfRU5UUlkuDQo+DQo+ID4gKyAg
ICAgY2FzZSBTUlNPX01JVElHQVRJT05fSUJQQl9PTl9WTUVYSVQ6DQo+ID4gKyAgICAgICAgICAg
ICBpZiAoIUlTX0VOQUJMRUQoQ09ORklHX01JVElHQVRJT05fU1JTTykpDQo+ID4gICAgICAgICAg
ICAgICAgICAgICAgIHByX2VycigiV0FSTklORzoga2VybmVsIG5vdCBjb21waWxlZCB3aXRoDQo+
IE1JVElHQVRJT05fU1JTTy5cbiIpOw0KPiA+IC0gICAgICAgICAgICAgICAgfQ0KPiA+ICsgICAg
ICAgICAgICAgYnJlYWs7DQo+DQo+IFRoaXMgaXMgYW4gZXhpc3RpbmcgYnVnLCBidXQgYXMgbWVu
dGlvbmVkIGFib3ZlIHRoaXMgc2hvdWxkIGJlIGNoZWNraW5nIGZvcg0KPiBDT05GSUdfTUlUSUdB
VElPTl9JQlBCX0VOVFJZIGluc3RlYWQgb2YgQ09ORklHX01JVElHQVRJT05fU1JTTy4NCg0KQWdy
ZWVkLCB3aWxsIGZpeCBib3RoIGNhc2VzDQoNCj4NCj4gPiArc3RhdGljIHZvaWQgX19pbml0IHNy
c29fdXBkYXRlX21pdGlnYXRpb24odm9pZCkgew0KPiA+ICsgICAgIC8qIElmIHJldGJsZWVkIGlz
IHVzaW5nIElCUEIsIHRoYXQgd29ya3MgZm9yIFNSU08gYXMgd2VsbCAqLw0KPiA+ICsgICAgIGlm
IChyZXRibGVlZF9taXRpZ2F0aW9uID09IFJFVEJMRUVEX01JVElHQVRJT05fSUJQQikNCj4gPiAr
ICAgICAgICAgICAgIHNyc29fbWl0aWdhdGlvbiA9IFNSU09fTUlUSUdBVElPTl9JQlBCOw0KPg0K
PiBBbm90aGVyIGRlcGVuZGVuY3kgb24gcmV0YmxlZWRfdXBkYXRlX21pdGlnYXRpb24oKS4NCg0K
V2VsbCwgbm90IHJlYWxseSAob3RoZXIgdGhhbiB0aGUgYml6YXJyZSByZXRibGVlZD0nc3R1ZmYn
IG9uIEFNRCBjYXNlIG1lbnRpb25lZCBpbiB0aGUgb3RoZXIgcGF0Y2gpLiAgVGhhdCBpcywgSSBk
b24ndCB0aGluayB0aGVyZSdzIGEgY2FzZSB0aGF0IG1hdHRlcnMgaWYgcmV0YmxlZWRfdXBkYXRl
X21pdGlnYXRpb24gaXMgcnVuIGJlZm9yZSBvciBub3QuDQoNCkJ1dCBJIHRoaW5rIEkgY2FuIGF0
IGxlYXN0IGRvY3VtZW50IHRoYXQgdGhpcyBmdW5jdGlvbiB1c2VzIHJldGJsZWVkX21pdGlnYXRp
b24uDQoNCj4NCj4gPiArICAgICBpZiAoc3Jzb19taXRpZ2F0aW9uICE9IFNSU09fTUlUSUdBVElP
Tl9OT05FKQ0KPiA+ICsgICAgICAgICAgICAgcHJfaW5mbygiJXNcbiIsIHNyc29fc3RyaW5nc1tz
cnNvX21pdGlnYXRpb25dKTsgfQ0KPg0KPiBGb3IgY29uc2lzdGVuY3kgd2l0aCBvdGhlcnMgdGhp
cyBzaG91bGQgcHJvYmFibHkgYmUgc29tZXRoaW5nIGxpa2UNCj4NCj4gICAgICAgICBpZiAoYm9v
dF9jcHVfaGFzX2J1ZyhYODZfQlVHX1NSU08pICYmICFjcHVfbWlnaXRhdGlvbnNfb2ZmKCkpDQo+
ICAgICAgICAgICAgICAgICBwcl9pbmZvKCIlc1xuIiwgc3Jzb19zdHJpbmdzW3Nyc29fbWl0aWdh
dGlvbl0pOw0KDQpPaw0KDQo+DQo+ID4gKyAgICAgICAgICAgICBzZXR1cF9jbGVhcl9jcHVfY2Fw
KFg4Nl9GRUFUVVJFX1JTQl9WTUVYSVQpOw0KPiA+ICAgICAgICAgICAgICAgYnJlYWs7DQo+ID4g
ICAgICAgZGVmYXVsdDoNCj4gPiAgICAgICAgICAgICAgIGJyZWFrOw0KPiA+ICAgICAgIH0NCj4g
Pg0KPiA+IC1vdXQ6DQo+ID4gLSAgICAgcHJfaW5mbygiJXNcbiIsIHNyc29fc3RyaW5nc1tzcnNv
X21pdGlnYXRpb25dKTsNCj4gPiAgfQ0KPg0KPiBFeHRyYSB3aGl0ZXNwYWNlLg0KDQpBY2sNCg0K
VGhhbmtzIC0tRGF2aWQgS2FwbGFuDQo=

