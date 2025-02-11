Return-Path: <linux-kernel+bounces-510169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 243FCA31929
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 23:59:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C28223A231C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 22:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FCF726770C;
	Tue, 11 Feb 2025 22:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MWrF1qg3"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C45272905
	for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 22:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739314789; cv=fail; b=By/Bnq9c2gOLPoEyBdoqEsYSzwheSgMf/sysAv+b05YIt5SRFYGvLUDgDL7I3MNmTkQejC8Za+4oHrnBjl7v54NS6ogPUonDd5uCISY4L9jYHDmtfdrO9oFFnsu38cqGzHEEqNt7MfchAXFkW8KFkt7c5jp1R4RL90asLdo0yT8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739314789; c=relaxed/simple;
	bh=93SvZSG0ttrkK6Vu1pYMOU79T/H6hyantzcgG1Phq1I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Bu56YjFApCr1bRS4mlFe6wyPj8wsZVeNiPGfFnBM74Jc95jAp3SHlNQjgD6Cl2NVBliUlAWJ6CYwyc2bdJ7uWqI9+07eeBromM/9I0ud83nCiAH1lK1+2x+FJQSccyRxsQol690L5Ww18e3vfettTxyy+jU1BZ0ao0ov2p3ttfw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MWrF1qg3; arc=fail smtp.client-ip=40.107.220.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L/yKsTDk1/mIvwvuglRBJQuutH9eqiAo809FBzLYSSytC9Ka+N3lKGhzttlRPjn+VgJF7tl67FjIXP4pxAa3rhBCVAcJJXSMub896PQWqDDDMPy24MUGw65L77XJBaE7OcVkLycOYYwr/XOP/D8KyWSF9xfGkNjfl1Srh9PM7P0LXxeeam4cMgtStol23gPTjKI4Ywpm9E2mr/RhZzlYqVMHbSQEGx3xOqSshqVBDJtS6A6Y+E1xxmDFKQ3BMMXNFPwJCzOW8b1v8IdsI5ESgeuARXCsqh2RhPNZ8slNoL/au4LSvZZlEo8R3iTM2B4wfhO0JbIO58N50pVunQJe4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=93SvZSG0ttrkK6Vu1pYMOU79T/H6hyantzcgG1Phq1I=;
 b=ncrGBfNU2+uOPuPeJA5eFVE4B3laqVWKYBUHPyaYFd+pheRb7rMD4wgOUxeB3D4fW/jZ120DfAf9NtijHGW1dhWVozibJTNU66xiZW1pNolyAA7wYCJmdRQI6xS2IFQzpzr53+uA+3fTjtyAKGw2J4nHWMS9QJdcEW2JLCQgdOuMxn7bn9/QniwNoBSuOwXYSnx758UpIri30w2mCuVpOuKWbY7UvJocJXxVE1nnRr0SW2u2uXbAKaJz/pwtj5hWSp/wv7znr3dhKt/xJ2sQgsVn+CAtPQIJjV9cTvbsVBWOHxr4tRFiUDb1R/bYY7sIGsBJc+LMArldOt4G1ZjUgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=93SvZSG0ttrkK6Vu1pYMOU79T/H6hyantzcgG1Phq1I=;
 b=MWrF1qg36zmdOLKTgR3BpkCjVLuTrJqE+QWeakBHIwwjaqCV59uNLSkYaoelbgj5p8UbitdOb57gUMUoM0oeaD0DMhhwyNUGrAi4y705gMWTVjFihZC45wqRHX1QAPu0GMWFWn4VlF6zpSHA+SNSYKF4B3bwlqL3lZzeWf6Vl8Y=
Received: from LV3PR12MB9265.namprd12.prod.outlook.com (2603:10b6:408:215::14)
 by DM4PR12MB8452.namprd12.prod.outlook.com (2603:10b6:8:184::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Tue, 11 Feb
 2025 22:59:45 +0000
Received: from LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427]) by LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427%4]) with mapi id 15.20.8422.015; Tue, 11 Feb 2025
 22:59:45 +0000
From: "Kaplan, David" <David.Kaplan@amd.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Pawan Gupta
	<pawan.kumar.gupta@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Dave
 Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, "H .
 Peter Anvin" <hpa@zytor.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 09/35] x86/bugs: Restructure srbds mitigation
Thread-Topic: [PATCH v3 09/35] x86/bugs: Restructure srbds mitigation
Thread-Index: AQHbfBW0enTe0X7hPU6RQ0VcXJZMHrNCt0fQ
Date: Tue, 11 Feb 2025 22:59:45 +0000
Message-ID:
 <LV3PR12MB9265C0771729845CC02ADABC94FD2@LV3PR12MB9265.namprd12.prod.outlook.com>
References: <20250108202515.385902-1-david.kaplan@amd.com>
 <20250108202515.385902-10-david.kaplan@amd.com>
 <20250210234413.i4vv6wuesxp37hyh@jpoimboe>
In-Reply-To: <20250210234413.i4vv6wuesxp37hyh@jpoimboe>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=9a4c9973-a44b-4570-9954-8fae382bec61;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-11T22:53:10Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9265:EE_|DM4PR12MB8452:EE_
x-ms-office365-filtering-correlation-id: 4df8ba03-1e4b-4aea-e447-08dd4aefc713
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RWVjRkhjcmpTS0J2QUgzYVNmSDk5djg5TnpxSkdDUDhTM3B2YlNFL3E1R3lU?=
 =?utf-8?B?Z1pIVlY4Z25uWGZQdmFJV2FXb2ZNR1ZLbUY3d0FJWTBVSk1mSHh2Wk1Rb1F5?=
 =?utf-8?B?Ti9id2J2bUx2RHhwTlZEV2FZUHEvdVV4RTZFVGZYeVV1anRqeDhtU1ZDR1RC?=
 =?utf-8?B?b1hxdEgreFZQUk5ycFFnZzJBanNHZk45S1hMeTZOaHhSUU5IOEdUMWlCVk9S?=
 =?utf-8?B?aEFoM1B0anpiY2VPaXpQcEtWVFNaTEdMT093MzJoM0pRbkFuNkhrNVdVeHhv?=
 =?utf-8?B?ZzFpTTRDMGZoMnpCWnZQdzF6Yjg3MkY1Wm5YK3VnSzAvd040QWo0N3lTWVRo?=
 =?utf-8?B?TWYyNTNvdDNhTFVFdlFXdDJZc05LMURPNmlhOFhibDdVZUZYRHdKTnRRZ09j?=
 =?utf-8?B?NVJxV1NwazZUaHl0Qy84ZkFzTzRMd2VNd2l2ZjBxdThBZzdOSUVXT0VpK0lh?=
 =?utf-8?B?SytFZktjQU5hQ3UyMWVrcmJHbE9NTFFJQW82SmJ4VWJTNGVxRHlpOWR4NGtL?=
 =?utf-8?B?MkZmMkZXMmpmTjRNRmVjVXh3MDVyVTkvc29zRm5TaHE4MHNtZU1JNW1Ba09m?=
 =?utf-8?B?QlMrMnltcllIcTZpaHRid09PbXRvZ3FlU1dRN3dVQ01hd1hiUUVET3l6VHZm?=
 =?utf-8?B?N09kQUFPWGk0Wk5Kb1FXVVQ1QkgySlZNYzhSaDNxR3A5S25CSWdNR3FNWjlK?=
 =?utf-8?B?UU9ia2hNYzJEYkxFTXpTSURYVXhqTXhLZExJZGlpRjBpY0RaZUhacFV6Z3Bi?=
 =?utf-8?B?a09VRXltbzE1MWs0MWRlYkcxUUVVZnJTMjc5U2pmQjM4akRPL2pPSGhZUFNw?=
 =?utf-8?B?VUk1WklvRW1qQjduN3VmcDhwRGMzazhBSDJXWlFBQ1JVQk5OUmhQdjN5aHNE?=
 =?utf-8?B?RjFsWDV5N29BUHAzcjMzMUIyUWZ0RnJrTUk5RzJ1aThoVU8rNHhZK0ZrVkQ2?=
 =?utf-8?B?WUpSVmYzT1dpTng2eGVnTThiWU1KYzgvaW10YVFlbm0zRHV0L2swVjVMQ3BU?=
 =?utf-8?B?dStSTkhxQnBIU2t3YlNTd1kzcU44M0EwMk9NeXpBOHV0aGJJY3BUWkNoa2Qr?=
 =?utf-8?B?VnRwOUNSZ1oxaWwvMzJpN0NaK1VINm8zNFkzb3dzSVAydDFHSUl0YlN1Rmd6?=
 =?utf-8?B?bnNsSUhGbTYxU0VrVDdPMU1JM0d1cEkvY1BFSEJEcmpIT1hoVWY2ck1FYXZS?=
 =?utf-8?B?RmhLWHVNaThGOTJ4TXdMUGhhTzVWOG1Cc1VReFZsVVpYT01NM2xLOXJZOEVI?=
 =?utf-8?B?MWttS3ZpN1ZFbXZmL1VQSnE4WkxTY0ZvRXozQm94SnFTWE9TS1ozVE9idk51?=
 =?utf-8?B?ekpJeTNzWjh2UmFoU2RFOWthMGlsMUU3Z1huMGgzUXdxZmlaWjNBZ09FanEx?=
 =?utf-8?B?Qm5IYk41SEU0MUtqUHdoZHEvNVBmZlRtR1oyWHpqL2hsbEZ3akZJaURtYjNq?=
 =?utf-8?B?VTdvSFlTSno3WTQzbHlDemlCVEwvRzJ6V1NoZitGN1hVRjBCa01OaWx3Tldh?=
 =?utf-8?B?WWwxbXFxS1NlVjROemdaeW1VWWdOWmFlSFU1aVFSdlpiZnFSekRvUnk3MnBU?=
 =?utf-8?B?cUpUeHFRUW53Nk9MdDRjYThnNHY1MUIwdjZDRWVWZkhXbFhwdU9VMlRFNnZM?=
 =?utf-8?B?NnpPZzJaNllFYW1HdWZUeWdQWmVBaFA0RzRpNGp1L0JxOW5jUlVZa1p3enVE?=
 =?utf-8?B?dEo5eFpkUXA2SnhraWRDdW1tdjdGdjh2b3hWY2M3NVo0QkZYWlJzQXJ4bnli?=
 =?utf-8?B?QUVnNXJlRXRrMFNxRDJKbkU5emRsaUo1aEpUb3ZBQzNNZ2dzM2ZIcUNCTVls?=
 =?utf-8?B?SUlhWG9UWU1Fb3NSZzNvc2U3WDZPc3pKZ0haTTBwZzVFVHlhRlYvNi9sMzV2?=
 =?utf-8?B?NzB5YW1udHA0RjFhMTVxYlRySFh1TVppUE1sZTR6dGxaWkF4NCtJL3YzcVNT?=
 =?utf-8?Q?pcVFSulLCRc7SN6BrY/8++SEWvG+ERyc?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9265.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZURXYkpFOFBsV3lheE9uMS9BRUZSZ2RjQjhjWnQwaUhSK3BUb0prcjMrN3hy?=
 =?utf-8?B?UGhKQXRTVGNHT1poUktMeWRmMXJManppckk4anhVYWxScjBvbXo1VGFxdytD?=
 =?utf-8?B?aDFTVjdZRVVCbDluaUFYdWtCbHFYUFFWK3ZRZ2UrbHNoakQ4aFlyL0gvdXVP?=
 =?utf-8?B?ZmtoZG1vL3F2VTJKeHdFUk4xVi9vMEJvM0RMbnRtRHNnbTJLRVdBVHc3T2xj?=
 =?utf-8?B?d3JscTJuSFdEcmg5OWJPT0F0SFAxcTRvRks1VXFtUUpNSzc0aWJXeVpSaDhV?=
 =?utf-8?B?R2NRUXkzM1RUNEtrVXNaL1VLdG1Kd2loVnloa0lmVnJUc0hNN2N0ZWZRc0Uz?=
 =?utf-8?B?b2NPVDNVVkZ0VE84NWEvOHBmN2h4OE5Qc0Y0NkZHNWZRNUVKVVpseGJrOVpG?=
 =?utf-8?B?STJMdTE0WWZDQXpKRG9NdFFqajFRY2RwUWovQ1NkUFFVSFo4VVRwc0NYeThl?=
 =?utf-8?B?ck1ieGFoMFBQUW1jR3JVeHZpNmtVUS9WTmxnZ01DR0JGNytNbDFRa0E1NHF6?=
 =?utf-8?B?TERvOFNDOHRnb0RpQ2Z2MmF4MjdMZWQyaEZPMXJCOFNidjM4TE9pTjBrRlJM?=
 =?utf-8?B?Wk5wWU9DZTh6cmxyck9tbEtIK3c4NGJ1YVUvL2pUSVorR2hJbmlDYWF6Zmxt?=
 =?utf-8?B?TmZEaE9WMWxXTlYyNFdVNHpqZWtWd2ZkZkVVWE5KY0RvL0hhZURPNWNLajNQ?=
 =?utf-8?B?Wm5raXNpNXRHSE5tN3R1Vkp2NGhxYm5JUzhuUWF0eHZrVmluMGFBdFlNS0sr?=
 =?utf-8?B?eUhNMHZtN1hweTRaaWxOQ3VQTmhFZEg3SWVWY054T2VWZDk0N1RibUU2TCt2?=
 =?utf-8?B?Ym9qYVlpRG1NWVRQZ1hyM1RES0FBdzhWSS9SUlhLaVpMczd3Q1JUNUNTUjBa?=
 =?utf-8?B?OC8wV1Q4M2p6M2t1M3A2enc1YU5BWkFZeUJyMUxDSXVteGpiaGpyU3F4ZWdi?=
 =?utf-8?B?QlByOFlaUUdXOGZRUHdvcjFQa2Q5Q1AxQ1VRYlNTQ25BMnd5eVpkdU1OVWZl?=
 =?utf-8?B?dkx5YXU0eWNsR05HM0VEandPNlZrUUtBRVFGMWhCMUdEZjAySCtndUs0cFh2?=
 =?utf-8?B?N0lQSkt0VXNJODY2NXg4Tmk1bUd1UVJhSVVYRForeW56R2N0YXo1bnJ0WmlV?=
 =?utf-8?B?a2N5amtCYW91TDVhRk1aWDNYcS8zbFkwejZ4VVVtWnUzM2MxNVZadGpRSGpZ?=
 =?utf-8?B?TVg5WXdnL05CWVdRWmd4SmEra2xJN1pzeCtvb0QveDFrRTVLTW5UbXExa1Bn?=
 =?utf-8?B?ZFpOZUUyWjB0TmREZlFDSmhiMnEyTVNmQkZtVXhPZjBBenU2SXBNNHZNbjQr?=
 =?utf-8?B?R1NEQVc3RVMvNHg0ekN2bWJ3R0QxS1Y5ekxjejIySWc1eFNYellVVmtmRnVy?=
 =?utf-8?B?ci9UVGxHWFo1dWk4eUcya1pvaEZoaERaN1NMZXhTaTdXTDhCMVc0V21ITkwy?=
 =?utf-8?B?dU02cE8yUTBCamtDN0F1dmJNU2RVSHlHKzAxTnc0TU1Bdkl4YlVObnpONk13?=
 =?utf-8?B?WDRuZXEwdjV1UWo3NEIwcDBXL2F0UGlRTDE5ZWdoZEZxSlJHZmxpY0paOTI0?=
 =?utf-8?B?NHlZS3Rnak01akJoc25sbTJGT0o4S0kxeXpwNXJOL1BuZ1FyVERKRHBPZGgx?=
 =?utf-8?B?UlY1S0hOb3R0U0RUd3E5Q1dURXJIMEN5TmlNREZvdUR0dlBQWVlaSG1IeVlP?=
 =?utf-8?B?K1BQWUt4a1ZQdXNnYm1iMHRTMDZJU2hnNnNuaUVRV3k4Ymg3ZzFHeTRILzdv?=
 =?utf-8?B?bHRtbHR5bzhHQzlMUW84RGs0ZXZTbFVBVTBPdkJLYTFvMGF2SnIxbWViUWp1?=
 =?utf-8?B?aFE0VE4xSDMvUmZUSnE4eHhXTURsZ2kwdTNuTzJ3a1czeERONkhsQVdYamlu?=
 =?utf-8?B?WlVEU0g3YkpZTjMySmNOeXZBVXRiRVAvME9UeGFIdmZWU1RPb1ZiTGxhQkhR?=
 =?utf-8?B?c0JadW1nQXFDbEpXWXFyWkhmUVAwbWVLNlYzR2VwZXEvYkRYWmM2OFplS0U2?=
 =?utf-8?B?aFFwb2gvMnhaM0s0ejQwZStyZXFhUFExZGxTSk9vb0Z1S0xlazdMZ3I4ZFpM?=
 =?utf-8?B?dkxwbVBzdjdzOFFEN2lRSnNhSE9UMEZya0Y5VlgxU01rRFlublIxa2RkR2Nk?=
 =?utf-8?Q?kU9w=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4df8ba03-1e4b-4aea-e447-08dd4aefc713
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2025 22:59:45.3853
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 84FhnBVNxUlxtmCZihdxsvYo6/wNnLs90RnGG8tMGmTDPKaAAeI6gElbH3yum/jb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8452

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKb3NoIFBvaW1ib2V1ZiA8
anBvaW1ib2VAa2VybmVsLm9yZz4NCj4gU2VudDogTW9uZGF5LCBGZWJydWFyeSAxMCwgMjAyNSA1
OjQ0IFBNDQo+IFRvOiBLYXBsYW4sIERhdmlkIDxEYXZpZC5LYXBsYW5AYW1kLmNvbT4NCj4gQ2M6
IFRob21hcyBHbGVpeG5lciA8dGdseEBsaW51dHJvbml4LmRlPjsgQm9yaXNsYXYgUGV0a292IDxi
cEBhbGllbjguZGU+OyBQZXRlcg0KPiBaaWpsc3RyYSA8cGV0ZXJ6QGluZnJhZGVhZC5vcmc+OyBQ
YXdhbiBHdXB0YQ0KPiA8cGF3YW4ua3VtYXIuZ3VwdGFAbGludXguaW50ZWwuY29tPjsgSW5nbyBN
b2xuYXIgPG1pbmdvQHJlZGhhdC5jb20+OyBEYXZlDQo+IEhhbnNlbiA8ZGF2ZS5oYW5zZW5AbGlu
dXguaW50ZWwuY29tPjsgeDg2QGtlcm5lbC5vcmc7IEggLiBQZXRlciBBbnZpbg0KPiA8aHBhQHp5
dG9yLmNvbT47IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQ
QVRDSCB2MyAwOS8zNV0geDg2L2J1Z3M6IFJlc3RydWN0dXJlIHNyYmRzIG1pdGlnYXRpb24NCj4N
Cj4gQ2F1dGlvbjogVGhpcyBtZXNzYWdlIG9yaWdpbmF0ZWQgZnJvbSBhbiBFeHRlcm5hbCBTb3Vy
Y2UuIFVzZSBwcm9wZXIgY2F1dGlvbg0KPiB3aGVuIG9wZW5pbmcgYXR0YWNobWVudHMsIGNsaWNr
aW5nIGxpbmtzLCBvciByZXNwb25kaW5nLg0KPg0KPg0KPiBPbiBXZWQsIEphbiAwOCwgMjAyNSBh
dCAwMjoyNDo0OVBNIC0wNjAwLCBEYXZpZCBLYXBsYW4gd3JvdGU6DQo+ID4gK3N0YXRpYyB2b2lk
IF9faW5pdCBzcmJkc19hcHBseV9taXRpZ2F0aW9uKHZvaWQpIHsNCj4gPiArICAgICBpZiAoIWJv
b3RfY3B1X2hhc19idWcoWDg2X0JVR19TUkJEUykpDQo+ID4gKyAgICAgICAgICAgICByZXR1cm47
DQo+DQo+IEkgcmVhbGl6ZSB0aGlzIGlzIGp1c3QgcHJlc2VydmluZyB0aGUgZXhpc3RpbmcgYmVo
YXZpb3IsIGJ1dCBmb3IgY29uc2lzdGVuY3kgd2l0aCB0aGUNCj4gb3RoZXJzIHRoaXMgc2hvdWxk
IGNoZWNrIGZvciBjcHVfbWl0aWdhdGlvbnNfb2ZmKCkgc28gdGhlIG1pdGlnYXRpb24gZG9lc24n
dCBnZXQNCj4gcHJpbnRlZC4NCg0KWWVhaCwgd2UgZGlzY3Vzc2VkIHRoaXMgaW4gdjIgb2YgdGhl
IHNlcmllcy4gIEkgYmVsaWV2ZSB5b3VyIHByZWZlcmVuY2Ugd2FzIG5vdCB0byBwcmludCBhbnl0
aGluZyBpZiBjcHVfbWl0aWdhdGlvbnNfb2ZmKCkgYnV0IHRvIHByaW50IGlmIGEgYnVnLXNwZWNp
ZmljIG1pdGlnYXRpb24gd2FzIGRpc2FibGVkIChlLmcuLCByZXRibGVlZD1vZmYpLiAgSSBzZWUg
Qm9yaXMgd2FzIG9rIHdpdGggdGhhdCwgc28gSSBndWVzcyB3ZSBjYW4gZ28gd2l0aCB0aGF0Lg0K
DQo+DQo+ID4gICAgICAgdXBkYXRlX3NyYmRzX21zcigpOw0KPiA+ICAgICAgIHByX2luZm8oIiVz
XG4iLCBzcmJkc19zdHJpbmdzW3NyYmRzX21pdGlnYXRpb25dKTsNCj4NCj4gTW9yZSBnZW5lcmFs
bHksIElNTyB0aGVzZSBzaG91bGQgYmUgcHJpbnRlZCBpbiB0aGUgc2VsZWN0IChvciB1cGRhdGUp
IGZ1bmN0aW9ucw0KPiByYXRoZXIgdGhhbiBpbiB0aGUgYXBwbHkgZnVuY3Rpb25zLg0KDQpBZ3Jl
ZWQuDQoNCi0tRGF2aWQgS2FwbGFuDQo=

