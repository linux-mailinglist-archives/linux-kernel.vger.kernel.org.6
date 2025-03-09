Return-Path: <linux-kernel+bounces-553164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BDDDA5851B
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 15:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE521188E662
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 14:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7C81DE3D8;
	Sun,  9 Mar 2025 14:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IjqbGFOM"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8099460;
	Sun,  9 Mar 2025 14:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741532161; cv=fail; b=s/ccD73RnOX6T1n/u2EEVn06m6zoGt38xi+QjM92gIbCOyEWb/WVUMpthIZH04wKWlXVhruUTf50/Jq4XNEdE8XoKjMTPKEj2PvK6SF+oAnsMaDd1L7tfNEd7esGMRErpNTbyX75Jdi8D/YkCsFeKplD2NY3qAPuiQby7mOAtrY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741532161; c=relaxed/simple;
	bh=gGT8eK8z6epHDTzBhtKHaFm4x7yJchRQ0l5ye3iDf0A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dWGj/4SWXs0pqi/Ue6rOgzyvqq81XIrRGbSDC+Y3LOYdMwPcaWrkLq5oSMOne0wf9dvUmDqIOfHkGBcv+0exL61PJeoDzPxqyLvT7DVXD6oE9N7qFoeGlrdtIpdb/cpd5L5Bt5yFU/Ffoksy77BOjsBx5Zg3lh097km8WePfotE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IjqbGFOM; arc=fail smtp.client-ip=40.107.94.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aSK/3KJB68iWlLmafphRdKb1PB0BEjQkJA49qE8uXomMLbb/U+MZtyvP94ARh4Gf4leJdNDuRKeoKF3y1wytEGObTQoTglIWmRNRW1kGJmDQUDsZSYMtxKiFyNGzhH969FWBW2ySYuJYOi6naEbdCUUXv+mH07L+DcMHcyXIAWxs/ja04X6/NAFP6MsnV5ZewizPq7OLvRyRUgqAenE7cA8SSlyy1TOnsBGaOMq6NWVKZfIk2M44jNC8iCyIBp39KgXd78rUWtSVvfnux89/DCB/M1+JvIU0cMVXZDnahHwX2EvWUzJaWKWIdSWfcSxPf3ik/3S1VNfyKDu7ONdr9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gGT8eK8z6epHDTzBhtKHaFm4x7yJchRQ0l5ye3iDf0A=;
 b=zR8Rs9wJr5pRmT64v/CDV6delzTeJUytnpMWLYgl+ogu3vTi26KxE7dztv7jk/anGgHAz7t2pzoAxJUU4OVUedIikDTQGrdAX74aii9Maaoqfidum3nRbV3MH+9Vz9T90+X84FM9Rxx9o8RUM2TIP7cVnF/TntGo+rCGCUazleBmvfxo+9NSJijp+rNCUoFsXcS0uiULVtgn7RsJFzyqGuVTu9eGeNh1Rn7ZzF32TJhMOL8AkSaNuTBx+nGYttK0Lns0ocsq4g7UmE2i7qQougNMrSJZSTSbWx2nPbwTs+i7yEH/un6mEScZHKmEAtEAA1ytc6x67g21Wm9NbODxvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gGT8eK8z6epHDTzBhtKHaFm4x7yJchRQ0l5ye3iDf0A=;
 b=IjqbGFOMP/U127uKf3MAJLcUISLQOfAjTBoXH7ePdHnBFp1I2IZkP1I1B2ciLhLBoX+NJ3+wFvIVJ3Ftp4NkF8D7YpnZ5dJ4E3NHYSR28Qh9BOWNq6WJbZ8t9rWtMLXs60uqlvb650xHn8S2fpgV/5/U/dIt9zTvpZ62wcDRYLo=
Received: from MN0PR12MB5953.namprd12.prod.outlook.com (2603:10b6:208:37c::15)
 by MW6PR12MB7086.namprd12.prod.outlook.com (2603:10b6:303:238::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Sun, 9 Mar
 2025 14:55:56 +0000
Received: from MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::6798:13c6:d7ba:e01c]) by MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::6798:13c6:d7ba:e01c%7]) with mapi id 15.20.8511.017; Sun, 9 Mar 2025
 14:55:56 +0000
From: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
To: Junzhong Pan <panjunzhong@outlook.com>, "piyush.mehta@amd.com"
	<piyush.mehta@amd.com>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "Simek, Michal"
	<michal.simek@amd.com>, "peter.chen@kernel.org" <peter.chen@kernel.org>,
	"Paladugu, Siva Durga Prasad" <siva.durga.prasad.paladugu@amd.com>
Subject: RE: [PATCH V2] usb: chipidea: udc: Add revision check of
 2.20[CI_REVISION_22]
Thread-Topic: [PATCH V2] usb: chipidea: udc: Add revision check of
 2.20[CI_REVISION_22]
Thread-Index: AQHaDVsl7WnXubZ1EEu+fnbcqFTAD7NpKPkAgATCS+A=
Date: Sun, 9 Mar 2025 14:55:56 +0000
Message-ID:
 <MN0PR12MB59534165D2775B7DD478C0B2B7D72@MN0PR12MB5953.namprd12.prod.outlook.com>
References: <20231102070603.777313-1-piyush.mehta@amd.com>
 <ME0P300MB05533B11B123B7C9188B699EA6CA2@ME0P300MB0553.AUSP300.PROD.OUTLOOK.COM>
In-Reply-To:
 <ME0P300MB05533B11B123B7C9188B699EA6CA2@ME0P300MB0553.AUSP300.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=872eae3b-54fc-4725-94ff-af37d4d477d8;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-09T14:53:16Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB5953:EE_|MW6PR12MB7086:EE_
x-ms-office365-filtering-correlation-id: 614023cf-8811-4518-8942-08dd5f1a7f2c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?d3RtcFc0YUNXRlNjd2ZLWnE0d1dWaHBiMW9hMTlMWS9IU1RsVVd4YTlZRTd6?=
 =?utf-8?B?d0ErTGVFQmZxMVFtTnFISlUzeldqUXRxZFQ5SjNKeVVjZTU3TEszNUxFQTcy?=
 =?utf-8?B?SmV3TGs2dXJZelpNcUFOcUF2NlN2OWpyZ2FiOE1EZUhUenFQNXhVRDQzaDJP?=
 =?utf-8?B?YlhVZ2tjYWd2cU9paUticlM4cU5DaU16OGFYbURUck5XZWlCMkdIT1IyUmpr?=
 =?utf-8?B?SlZtSFdFVGlWK004UFU1UWdjL2o2Rk4wRTJXZUxQQVpPRm9TRGlJU2V4Z1Jv?=
 =?utf-8?B?R01sc2hFa0VGMFdycy9oc054MXJxK2JwTW1kNStMQlhmbFdtd21nMGZiRjNk?=
 =?utf-8?B?K3VOejRCdXZTQXZZenNGQm9TT3Vhb3FqZlF6VXhlN3J1TUMyQW41a2pVcXkr?=
 =?utf-8?B?V0kzMERrQWZJbmZncHBJU2tDWmlFSE14bWJBUzJENFd5a1JtNFVpOE84V01D?=
 =?utf-8?B?ZEFFaHd0ZCtxeEhpODJQdVFjRDgvWHlUOXNoV1g4Mi9zRnozQzFDNVY3c3ll?=
 =?utf-8?B?Y1pRRGI4MTM2ZzNVYytXbUpwVmJoUDhJbFhTYm9XSGhxUVUyb2tTMVVwOHJM?=
 =?utf-8?B?SmQrajBNV0I3TWRDeGNmMFVoOU5ndGlXYWROWFFQUllLcnF6U291aGlCa0FW?=
 =?utf-8?B?UEdGYU8yb3g3TmZCb0xzTHNPWjR4RTJhZzNzQ2tjaWwyRXFqL2tJaDIrWDBj?=
 =?utf-8?B?VjB5YzV4Wk1lTktjQ3UrWFVwSnp2SjFFNnI0Uytwc2xaQnBXUUNrckRZVlZU?=
 =?utf-8?B?S0Q5bnllc29aOUh3ck90bDgzVGJSejlPaVh6eEVSREJrak83T0RDWi9CanZM?=
 =?utf-8?B?MVdrUEh4aEVWcEZZdXIySDEvbVR0a1pzUkhtaGV3dTdJZ05UU2FYSWhPdWll?=
 =?utf-8?B?MXJvWTZLbk1hS042eXZZRkZheEVlSWdVQUR5QTZ1U0l6UVZWQ2hWNlRBdXhQ?=
 =?utf-8?B?UlVDbXFQTEJpUDdFbEVHcjZhdkNqQTQ5TGdyMEVZczdJMlJlVVp5SXB1WDJH?=
 =?utf-8?B?SVJPNHVSSkV0MTdDQk9FS0tpejQ5ME4wRWdJMFJVWDZhTjIyVmI4d1JlMi8r?=
 =?utf-8?B?TG9qd1NQcXJSMWxESjIzUHZkYWJXV3V1T0RoT09pL0p6N0FHZGlLMFNWTnhC?=
 =?utf-8?B?RjBrbHBocEVsWW5wWGt1TlRETFZJaFMzSFVVSytzUUxQZWp3cXFiS2s0WUZQ?=
 =?utf-8?B?L3F3RHZ3NTNkMWpwbHBCWmlIUVQraVUvamhmclErbUtPelQzYUoyUDhWV2Ja?=
 =?utf-8?B?Q1ArZzhWTHRJbWFiUUdHT2FvQ3pTbmtqOGwwTktxVUUxNHJheThhemZ1U1FO?=
 =?utf-8?B?elMxalJUazB0dSs4WWRjVnpzRWxQb1ZMSXA1M2NNZGRnVGIvQTBGZU1GMGsz?=
 =?utf-8?B?aXZrMDBLWEhITlE0RDFSQ3RzOVl2UmRGcUtTYlU1S3RrelhoekhPaUJ5T1Fm?=
 =?utf-8?B?OC81Q2tEYXZBMXdPcUtoRW5seEw4RWZSWGlZaXFPcUtZMFBRbE1Ud0RPZUNF?=
 =?utf-8?B?Sk80aXNLQzhUdkluQ1JvQmpUV2thSmVuRitvVGFkSWZnVkRBL2REVXc0c0NE?=
 =?utf-8?B?VVBQaVppaTI5REVDd29QK282YnJ0TlA3ZStaUUlZOW52dnNCaVp1S0NHbHJt?=
 =?utf-8?B?VjZhSDhrYVlJMGZkRGdpQi9xQTZWZTlRa0FXMjYrTnVyeG9qZzVMY2xqMlVB?=
 =?utf-8?B?cVQveG84V3RpdUNSTTZtY0EvYmJJalA2S1gzMmxiZzQzN1FKck0vNDJEVG1u?=
 =?utf-8?B?TzFNYnZQMzVlcUprMS9YRWpjUHBQdTByZEwrVytLQnJXeFZMREI1dVNnSERD?=
 =?utf-8?B?ZUltSE51ZnJtbzZsRTJ6SU1hbUdKVkRITFFORHMwd0hBRHdhblMra1BTaWpz?=
 =?utf-8?B?MElQNzgvc1lMVnpVVXQwd0JGOVY3dytmR0c3Vis5d2xGaFArcjlndEU4K3Z3?=
 =?utf-8?Q?uYe/1pvbioTRB1UdmBmTEFP0z8nHSaG1?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5953.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Tjl6YXh2M3AxeWN1MWxETzFPTW4zSE9tUkZleWROZGEyYjNnQnFBbkpYZTVS?=
 =?utf-8?B?amlVaVdtcHlaZllTS2Y3RzRyUGFMdm84VnFHMGJQdWVDNmFoYVgzYjNLa0Ey?=
 =?utf-8?B?c3Naa2NkMnNuaG1VbTN6c2hKSWxzeFZiYmVuQzBMMU8rNVZCMDZNSTJaY0Mz?=
 =?utf-8?B?cWN2NWVLem50RUZxVjNpbFF2bVZlZndORFltMWdmNzNtQnoyd01oK2VEMW5I?=
 =?utf-8?B?cW5kU1ZDVjhpdmFHTzI4cW16bkp5alc0eXhBSHI5Uk51bXpPb0tOS0N3UVc5?=
 =?utf-8?B?enNKOStybDhGOVl6YTl5NVcwSEtIN1VMcy9FM0pPemZiZzJuN0RYK3Zzc25j?=
 =?utf-8?B?d3l2NFJDdEZkb2tyTW5CMFo0cUJFTml4WjkrMWRRdktYUGh3SlUzeWJRVUU0?=
 =?utf-8?B?empuaVRxUXFyMGp2VzdsQ0VOZG9JWWR5NTlyR0s5UDMzRy82eUVraGREWTRB?=
 =?utf-8?B?OXhOb2dKSnRMaWZIeWx5dXpVL0Uxd3FYMlRuT2NxRWxWc1pyMnVsUlJXclVL?=
 =?utf-8?B?Qzlhb2kvd1NmNGg2b1JQNkx4VFg0WkZFY002emFLNHQ5Ymw1THhvZnNPSFNT?=
 =?utf-8?B?UE9kOFNwV2xOVjBQTDBQNDJqTGZvVWhZNzBXL1U1Y2dYOUVFVENKeFN5Wm1o?=
 =?utf-8?B?S2RheVE3bTZyUE5xYVp2ODE0Ry9KNEpXSCtVRTVFTnAxODdURktTRGVlWG1h?=
 =?utf-8?B?NDlvVnBXUGwrSDljTE5TOC85MlhzdGpWZURGbFRhMXhSdHYya1M4b2c2ZzU5?=
 =?utf-8?B?S0FSMnYzbDdxYklXRlAyZVVzbkpnbUFVRUJodXF4d0pQQndOWTBtdkJVY0lx?=
 =?utf-8?B?VTNVN1d1TFZEbE02cW1RMHVybTVnZTZMOW16azZuUFlPeVRHaFJaQTZCK3Qv?=
 =?utf-8?B?MDVqN2JVSlFPdHZvUE0rNG1WZnZ0U1ZDWFdod1lmQ3lIVG1td0NRUk1hRWph?=
 =?utf-8?B?ejUvNmNhRWxxb05FTDIrZWdRcXVFZUdaSzJJckM4bFA5QUNVNzJEMFBaRU56?=
 =?utf-8?B?d1hPNSttbkNpYlp2NlRodjB1NGJKWFBoZDBESWtEMDlIYkFYa3pKZHBhYnNs?=
 =?utf-8?B?RUNSNHZRTC9DU3N2NEVoUjBFTDdvTjB3UHZsUUpMUy81YmtiRlhXWXpVQ3Zp?=
 =?utf-8?B?TENRMURpUk9NOFRWV21LdXVEVTVjTEplUkhxZ0xnOFk2SGpuQjFTNVVMd1VL?=
 =?utf-8?B?K3JORzM5SXM2Vk1Zc0E3TUJITnlpeThsTzgvZlQxUGhxNDQzUWtFaFNzdjhJ?=
 =?utf-8?B?VnNRQlk2MWgwdjYvN1RjQy9FaVJ2dkUwcS9JOHd0QU9LNlpnaC9XdGxTMEJP?=
 =?utf-8?B?YnVKR0p1b3htZFhxQlVROVo5dGdLWFNBRHVibk5RRWJ4NHhJS1RidnFzR3pi?=
 =?utf-8?B?SE5FOUdJcnQ3ZTZuWTFVZEFSVi9Tb2MxN2ltTHg2SVZYR3ROa2RyUzNiK09u?=
 =?utf-8?B?bGEvVFg0Mkh1T0UrbXhuL0I5SW1oU1IwRDVxYlBjR3N0c0huL0pzMStobGVm?=
 =?utf-8?B?WUlXT0R4TEdxcVdET25TaHZNVUZHcVJ2b0hPaXpNajl5cGc0OXlxREhGZStn?=
 =?utf-8?B?QVR6NzBNd05UOG9IdkJ4cFFLOW8vWS9tOGRrVXUySXRidDMva216VWVVSU9F?=
 =?utf-8?B?NzdZYllQWTBFdkFtRlJSU2NqbzVHV2NUK2YrMXQvMXN2TEtxUzRJUFZVeXdv?=
 =?utf-8?B?bzJVcjQvbGNuUGxVZ0ZrTUFKUTJLTWFWbGJlQ25yb1d3cDhxVkRGbEdzWHFj?=
 =?utf-8?B?V2lrZ1oxaUFtY1V6a2NOYmtsRWY5TUdYNm9sRWZiRTU1SkxIL3pBdWlHR1pn?=
 =?utf-8?B?MlA3Z2tYZHI5QmNpTjB0YXJveDM3ZjlkWU0vMUZ0VEJlSzRQR0wwSWNaYzNP?=
 =?utf-8?B?VzhVd2JCYytXeHg5NGg4QUlreFBLVWptR0ZjQktTVHZTTWhRL3dQSXZzY1hM?=
 =?utf-8?B?ZWFyYVJQdzFSOGZPa2FlY0xMMTZKYUxsT0JvMW1sa1BPdTdXektuMmZVUlJx?=
 =?utf-8?B?QzdZeEVmZTFXd2Jzb3c5MzhmR1hBeWt3LzgrNEZOcjhtZ0QwQitVNEdSai9P?=
 =?utf-8?B?eFVkaE5QYUxRajFiVjQxZWtKWUNGanJWUEw0aFZ6V0hiTExsZTJIeXF4NjRr?=
 =?utf-8?Q?2LHg=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5953.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 614023cf-8811-4518-8942-08dd5f1a7f2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2025 14:55:56.3663
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xUp4UVicmdl3rq9LHxEJ/nB9/ZyNTPh/oCCx+jgMH+D6o/4ZF6dPTcDi/mJS+Tx6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7086

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKdW56aG9uZyBQYW4gPHBh
bmp1bnpob25nQG91dGxvb2suY29tPg0KPiBTZW50OiBUaHVyc2RheSwgTWFyY2ggNiwgMjAyNSA3
OjQzIFBNDQo+IFRvOiBwaXl1c2gubWVodGFAYW1kLmNvbQ0KPiBDYzogZ3JlZ2toQGxpbnV4Zm91
bmRhdGlvbi5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiB1c2JA
dmdlci5rZXJuZWwub3JnOyBTaW1laywgTWljaGFsIDxtaWNoYWwuc2ltZWtAYW1kLmNvbT47DQo+
IHBldGVyLmNoZW5Aa2VybmVsLm9yZzsgUGFuZGV5LCBSYWRoZXkgU2h5YW0NCj4gPHJhZGhleS5z
aHlhbS5wYW5kZXlAYW1kLmNvbT47IFBhbGFkdWd1LCBTaXZhIER1cmdhIFByYXNhZA0KPiA8c2l2
YS5kdXJnYS5wcmFzYWQucGFsYWR1Z3VAYW1kLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCBW
Ml0gdXNiOiBjaGlwaWRlYTogdWRjOiBBZGQgcmV2aXNpb24gY2hlY2sgb2YNCj4gMi4yMFtDSV9S
RVZJU0lPTl8yMl0NCj4NCj4gSGkgUGl5dXNoLA0KPg0KPiA+IElzc3VlOiBBZGRpbmcgYSBkVEQg
dG8gYSBQcmltZWQgRW5kcG9pbnQgTWF5IE5vdCBHZXQgUmVjb2duaXplZCB3aXRoDQo+ID4gcmV2
aXNpb24gMi4yMGEuDQo+ID4NCj4gPiBUaGVyZSBpcyBhbiBpc3N1ZSB3aXRoIHRoZSBhZGQgZFRE
IHRyaXB3aXJlIHNlbWFwaG9yZSAoQVREVFcgYml0IGluDQo+ID4gVVNCQ01EIHJlZ2lzdGVyKSB0
aGF0IGNhbiBjYXVzZSB0aGUgY29udHJvbGxlciB0byBpZ25vcmUgYSBkVEQgdGhhdCBpcw0KPiA+
IGFkZGVkIHRvIGEgcHJpbWVkIGVuZHBvaW50LiBXaGVuIHRoaXMgaGFwcGVucywgdGhlIHNvZnR3
YXJlIGNhbiByZWFkDQo+ID4gdGhlIHRyaXB3aXJlIGJpdCBhbmQgdGhlIHN0YXR1cyBiaXQgYXQg
JzEnIGV2ZW4gdGhvdWdoIHRoZSBlbmRwb2ludCBpcw0KPiA+IHVucHJpbWVkLg0KPiA+IFRoaXMg
aXNzdWUgb2JzZXJ2ZWQgd2l0aCB0aGUgV2luZG93cyBob3N0IG1hY2hpbmUuDQo+DQo+IFNvcnJ5
IHRvIGRpZyB0aHJvdWdoIHRoaXMgb2xkIHBhdGNoIGVtYWlsLg0KPg0KPiBNYXkgSSBhc2sgd2hh
dCBkb2VzICoqdGhlIHNjZW5lIGxvb2sgbGlrZSAoYnVzIGNvbmRpdGlvbi9kdGQgc3RhdHVzKSoq
IHdoZW4gdGhpcw0KPiBpc3N1ZSBvYnNlcnZlZCB3aXRoIHRoZSBXaW5kb3dzIGhvc3QgbWFjaGlu
ZSBvY2N1cnM/DQo+DQo+IEkgd2FudCB0byBrbm93IGlmIGl0J3MgcmVsZXZhbnQgdG8gYW4gaXNz
dWUgSSBlbmNvdW50ZXJlZCByZWNlbnRseS4NCj4NCj4gSSBtZXQgdGhpcyBhIHRyaWNreSBpc3N1
ZSB3aXRoIGFuIHNvYyBoYXZlIGEgbWFydmVsIHVkYyAoZHJpdmVuIGJ5IG12X3VkY19jb3JlLmMs
IGl0J3MNCj4gYSBzYW1lIGNoaXBpZGVhIElQIGFjY29yZGluZ2x5KSB3aGVuIHJ1bm5pbmcgcm5k
aXMgZ2FkZ2V0IHdpdGggdGhlIFdpbmRvd3MgaG9zdA0KPiBtYWNoaW5lLg0KDQpXaGF0IGlzIElQ
IHZlcnNpb24gPyBJZiBub3QgMi4yMCwgY2FuIHlvdSB0cnkgd2l0aCBleHRlbmRpbmcgY3VycmVu
dCBjaGVjaz8NCg0KPg0KPiBXaGVuIHRoZSBybmRpcyBnYWRnZXQgcnVubmluZyBmb3IgYSBsb25n
IHRpbWUgKHJhbmRvbWx5KSwgdGhlIHVkYyB3b3VsZCBzdWRkZW5seQ0KPiBzdG9wcGVkIGFuZCBu
byBsb25nZ2VyIHJlc3BvbnNlIHRvIElOIHRva2VuIHNlbnQgZnJvbSB0aGUgaG9zdC4NCj4NCj4g
VGhlIGJ1cyB0cmFjZSBsb29rcyBsaWtlIHRoaXM6DQo+DQo+IEJVTEsgSU46DQo+ICAgICAgIElO
DQo+ICAgICAgIERBVEEwIDEyMCBCeXRlcw0KPiAgICAgICBBQ0sNCj4gQlVMSyBPVVQ6DQo+ICAg
ICAgIE9VVA0KPiAgICAgICBEQVRBMSA5OCBCeXRlcw0KPiAgICAgICBOWUVUDQo+IEJVTEsgSU4g
ICAgICAgPz8NCj4gICAgICAgSU4gTkFLDQo+ICAgICAgIElOIE5BSw0KPiAgICAgICBJTiBOQUsN
Cj4gICAgICAgLi4uLi4NCj4gICAgICAgSU4gISFQcm9wYWdhdGVkIEVycm9yISEoVHVybmFyb3Vu
ZC9UaW1lb3V0IEVycm9yKQ0KPg0KPg0KPg0KPiBUaGUgZHJpdmVyIGRvZXNuJ3QgcmVjZWl2ZSBh
bnkgZnVydGhlciBpbnRlcnJ1cHRzIHdoZW4gaXQgc3RvcHBlZCwgdGhvdWdoIHRoZSBJTiAxMDIN
Cj4gQnl0ZXMgdHJhbnNhY3Rpb24gaXMgZmluaXNoZWQgb24gdGhlIGJ1cywgYnV0IHRoZSBURF9U
T1RBTF9CWVRFUyBvZiB0aGF0IGRUZCBpcw0KPiBuZXZlciB1cGRhdGVkLg0KPg0KPiAgZXAgbnVt
OiAxIGRpcjogMShpbikNCj4gICBxaCBvZiBjdXJyZW50IGVwOiAxIGRpcjogMShpbikNCj4gICAg
IHFoIG1heHBhY2tsZW46IDB4MjIwMDAwMDAsIHRva2VuOiAweDY2ODA4MA0KPiAgICAgcWggdGRf
ZG1hIGN1cnJfZHRkX3B0cjogMHg2NTg0MDNjMCwgbmV4dF9kdGRfcHRyOiAweDENCj4gICAgIHFo
IGJ1ZiBwMDogMHg2NzJkY2RlLCBwMTogMHg2NzJlMzc4LCBwMjogMHg2NzJmMDAwLCBwMzogMHg2
NzMwMDAwLCBwNDoNCj4gMHg2NzMxMDAwDQo+ICAgcmVxIDB4ZDgxZTI0NTU0MCBsZW46ICoqMTAy
KiosIGZpcnN0X2R0ZDogMHg2NTg0MDNjMCwgbGFzdF9kdGQ6IDB4NjU4NDAzYzAsDQo+IGR0ZF9j
b3VudDogMSwgYWN0dWFsOiAxMDINCj4gICAgICBbcWgtPmN1cnJfZHRkX3B0cl1kdGQgZG1hIDB4
NjU4NDAzYzAsIHRva2VuOiAweDY2ODA4MCwgZXJyOiAweDAsIGR0ZF9ueHQ6DQo+IDB4NjU4NDA1
NDANCj4gICAgICAgICAgYnVmIHAwOjB4NjcyZGNkZSBwMToweDY3MmUwMDAgcDI6MHg2NzJmMDAw
IHAzOjB4NjczMDAwMCBwNDoweDY3MzEwMDANCj4gc2NyOiAweDANCj4gICByZXEgMHhkODFlMjQ1
YjQwIGxlbjogMTU1OCwgZmlyc3RfZHRkOiAweDY1ODQwNTQwLCBsYXN0X2R0ZDogMHg2NTg0MDU0
MCwNCj4gZHRkX2NvdW50OiAxLCBhY3R1YWw6IDE1NTgNCj4gICAgICBbLS0tXWR0ZCBkbWEgMHg2
NTg0MDU0MCwgdG9rZW46IDB4NjE2ODA4MCwgZXJyOiAweDAsIGR0ZF9ueHQ6IDB4NjU4NDAwODAN
Cj4gICAgICAgICAgYnVmIHAwOjB4MjBjZTUwZGUgcDE6MHgyMGNlNjAwMCBwMjoweDIwY2U3MDAw
IHAzOjB4MjBjZTgwMDANCj4gcDQ6MHgyMGNlOTAwMCBzY3I6IDB4MCAuLi4uLi4NCj4NCj4gZXBu
YWs6IDB4MDAwNzAwMDMNCj4gZXBzZXR1cHN0YXQ6IDB4MDAwMDAwMDANCj4gZXBwcmltZTogMHgw
MDAwMDAwMA0KPiBlcGZsdXNoOiAweDAwMDAwMDAwDQo+IGVwc3RhdHVzOiAweDAwMDIwMDAyDQo+
DQo+DQo+IFRoYW5rcyENCg0K

